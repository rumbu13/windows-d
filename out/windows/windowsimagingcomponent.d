// Written in the D programming language.

module windows.windowsimagingcomponent;

public import windows.core;
public import windows.com : HRESULT, IEnumString, IEnumUnknown, IPersistStream,
                            IPropertyBag2, IUnknown, PROPBAG2;
public import windows.direct2d : D2D1_PIXEL_FORMAT, ID2D1Device, ID2D1Image;
public import windows.dxgi : DXGI_FORMAT, DXGI_JPEG_AC_HUFFMAN_TABLE,
                             DXGI_JPEG_DC_HUFFMAN_TABLE, DXGI_JPEG_QUANTIZATION_TABLE;
public import windows.gdi : HBITMAP, HICON, HPALETTE;
public import windows.structuredstorage : IStream, PROPVARIANT;
public import windows.systemservices : BOOL, HANDLE, ULARGE_INTEGER;

extern(Windows):


// Enums


///Specifies the color context types.
enum WICColorContextType : int
{
    ///An uninitialized color context.
    WICColorContextUninitialized  = 0x00000000,
    ///A color context that is a full ICC color profile.
    WICColorContextProfile        = 0x00000001,
    WICColorContextExifColorSpace = 0x00000002,
}

///Specifies the desired cache usage.
enum WICBitmapCreateCacheOption : int
{
    ///Do not cache the bitmap.
    WICBitmapNoCache                       = 0x00000000,
    ///Cache the bitmap when needed.
    WICBitmapCacheOnDemand                 = 0x00000001,
    ///Cache the bitmap at initialization.
    WICBitmapCacheOnLoad                   = 0x00000002,
    WICBITMAPCREATECACHEOPTION_FORCE_DWORD = 0x7fffffff,
}

///Specifies decode options.
enum WICDecodeOptions : int
{
    ///Cache metadata when needed.
    WICDecodeMetadataCacheOnDemand     = 0x00000000,
    ///Cache metadata when decoder is loaded.
    WICDecodeMetadataCacheOnLoad       = 0x00000001,
    WICMETADATACACHEOPTION_FORCE_DWORD = 0x7fffffff,
}

///Specifies the cache options available for an encoder.
enum WICBitmapEncoderCacheOption : int
{
    ///The encoder is cached in memory. This option is not supported.
    WICBitmapEncoderCacheInMemory           = 0x00000000,
    ///The encoder is cached to a temporary file. This option is not supported.
    WICBitmapEncoderCacheTempFile           = 0x00000001,
    ///The encoder is not cached.
    WICBitmapEncoderNoCache                 = 0x00000002,
    WICBITMAPENCODERCACHEOPTION_FORCE_DWORD = 0x7fffffff,
}

///Specifies the type of Windows Imaging Component (WIC) component.
enum WICComponentType : int
{
    ///A WIC decoder.
    WICDecoder                   = 0x00000001,
    ///A WIC encoder.
    WICEncoder                   = 0x00000002,
    ///A WIC pixel converter.
    WICPixelFormatConverter      = 0x00000004,
    ///A WIC metadata reader.
    WICMetadataReader            = 0x00000008,
    ///A WIC metadata writer.
    WICMetadataWriter            = 0x00000010,
    ///A WIC pixel format.
    WICPixelFormat               = 0x00000020,
    ///All WIC components.
    WICAllComponents             = 0x0000003f,
    WICCOMPONENTTYPE_FORCE_DWORD = 0x7fffffff,
}

///Specifies component enumeration options.
enum WICComponentEnumerateOptions : int
{
    ///Enumerate any components that are not disabled. Because this value is 0x0, it is always included with the other
    ///options.
    WICComponentEnumerateDefault             = 0x00000000,
    ///Force a read of the registry before enumerating components.
    WICComponentEnumerateRefresh             = 0x00000001,
    ///Include disabled components in the enumeration. The set of disabled components is disjoint with the set of
    ///default enumerated components
    WICComponentEnumerateDisabled            = 0x80000000,
    ///Include unsigned components in the enumeration. This option has no effect.
    WICComponentEnumerateUnsigned            = 0x40000000,
    ///At the end of component enumeration, filter out any components that are not Windows provided.
    WICComponentEnumerateBuiltInOnly         = 0x20000000,
    WICCOMPONENTENUMERATEOPTIONS_FORCE_DWORD = 0x7fffffff,
}

///Specifies the sampling or filtering mode to use when scaling an image.
enum WICBitmapInterpolationMode : int
{
    ///A nearest neighbor interpolation algorithm. Also known as nearest pixel or point interpolation. The output pixel
    ///is assigned the value of the pixel that the point falls within. No other pixels are considered.
    WICBitmapInterpolationModeNearestNeighbor  = 0x00000000,
    ///A bilinear interpolation algorithm. The output pixel values are computed as a weighted average of the nearest
    ///four pixels in a 2x2 grid.
    WICBitmapInterpolationModeLinear           = 0x00000001,
    ///A bicubic interpolation algorithm. Destination pixel values are computed as a weighted average of the nearest
    ///sixteen pixels in a 4x4 grid.
    WICBitmapInterpolationModeCubic            = 0x00000002,
    ///A Fant resampling algorithm. Destination pixel values are computed as a weighted average of the all the pixels
    ///that map to the new pixel.
    WICBitmapInterpolationModeFant             = 0x00000003,
    ///A high quality bicubic interpolation algorithm. Destination pixel values are computed using a much denser
    ///sampling kernel than regular cubic. The kernel is resized in response to the scale factor, making it suitable for
    ///downscaling by factors greater than 2. <div class="alert"><b>Note</b> This value is supported beginning with
    ///Windows 10.</div> <div> </div>
    WICBitmapInterpolationModeHighQualityCubic = 0x00000004,
    WICBITMAPINTERPOLATIONMODE_FORCE_DWORD     = 0x7fffffff,
}

///Specifies the type of palette used for an indexed image format.
enum WICBitmapPaletteType : int
{
    ///An arbitrary custom palette provided by caller.
    WICBitmapPaletteTypeCustom           = 0x00000000,
    ///An optimal palette generated using a median-cut algorithm. Derived from the colors in an image.
    WICBitmapPaletteTypeMedianCut        = 0x00000001,
    ///A black and white palette.
    WICBitmapPaletteTypeFixedBW          = 0x00000002,
    ///A palette that has its 8-color on-off primaries and the 16 system colors added. With duplicates removed, 16
    ///colors are available.
    WICBitmapPaletteTypeFixedHalftone8   = 0x00000003,
    ///A palette that has 3 intensity levels of each primary: 27-color on-off primaries and the 16 system colors added.
    ///With duplicates removed, 35 colors are available.
    WICBitmapPaletteTypeFixedHalftone27  = 0x00000004,
    ///A palette that has 4 intensity levels of each primary: 64-color on-off primaries and the 16 system colors added.
    ///With duplicates removed, 72 colors are available.
    WICBitmapPaletteTypeFixedHalftone64  = 0x00000005,
    ///A palette that has 5 intensity levels of each primary: 125-color on-off primaries and the 16 system colors added.
    ///With duplicates removed, 133 colors are available.
    WICBitmapPaletteTypeFixedHalftone125 = 0x00000006,
    ///A palette that has 6 intensity levels of each primary: 216-color on-off primaries and the 16 system colors added.
    ///With duplicates removed, 224 colors are available. This is the same as <b>WICBitmapPaletteFixedHalftoneWeb</b>.
    WICBitmapPaletteTypeFixedHalftone216 = 0x00000007,
    ///A palette that has 6 intensity levels of each primary: 216-color on-off primaries and the 16 system colors added.
    ///With duplicates removed, 224 colors are available. This is the same as
    ///<b>WICBitmapPaletteTypeFixedHalftone216</b>.
    WICBitmapPaletteTypeFixedWebPalette  = 0x00000007,
    ///A palette that has its 252-color on-off primaries and the 16 system colors added. With duplicates removed, 256
    ///colors are available.
    WICBitmapPaletteTypeFixedHalftone252 = 0x00000008,
    ///A palette that has its 256-color on-off primaries and the 16 system colors added. With duplicates removed, 256
    ///colors are available.
    WICBitmapPaletteTypeFixedHalftone256 = 0x00000009,
    ///A palette that has 4 shades of gray.
    WICBitmapPaletteTypeFixedGray4       = 0x0000000a,
    ///A palette that has 16 shades of gray.
    WICBitmapPaletteTypeFixedGray16      = 0x0000000b,
    ///A palette that has 256 shades of gray.
    WICBitmapPaletteTypeFixedGray256     = 0x0000000c,
    WICBITMAPPALETTETYPE_FORCE_DWORD     = 0x7fffffff,
}

///Specifies the type of dither algorithm to apply when converting between image formats.
enum WICBitmapDitherType : int
{
    ///A solid color algorithm without dither.
    WICBitmapDitherTypeNone           = 0x00000000,
    ///A solid color algorithm without dither.
    WICBitmapDitherTypeSolid          = 0x00000000,
    ///A 4x4 ordered dither algorithm.
    WICBitmapDitherTypeOrdered4x4     = 0x00000001,
    ///An 8x8 ordered dither algorithm.
    WICBitmapDitherTypeOrdered8x8     = 0x00000002,
    ///A 16x16 ordered dither algorithm.
    WICBitmapDitherTypeOrdered16x16   = 0x00000003,
    ///A 4x4 spiral dither algorithm.
    WICBitmapDitherTypeSpiral4x4      = 0x00000004,
    ///An 8x8 spiral dither algorithm.
    WICBitmapDitherTypeSpiral8x8      = 0x00000005,
    ///A 4x4 dual spiral dither algorithm.
    WICBitmapDitherTypeDualSpiral4x4  = 0x00000006,
    ///An 8x8 dual spiral dither algorithm.
    WICBitmapDitherTypeDualSpiral8x8  = 0x00000007,
    ///An error diffusion algorithm.
    WICBitmapDitherTypeErrorDiffusion = 0x00000008,
    WICBITMAPDITHERTYPE_FORCE_DWORD   = 0x7fffffff,
}

///Specifies the desired alpha channel usage.
enum WICBitmapAlphaChannelOption : int
{
    ///Use alpha channel.
    WICBitmapUseAlpha                        = 0x00000000,
    ///Use a pre-multiplied alpha channel.
    WICBitmapUsePremultipliedAlpha           = 0x00000001,
    ///Ignore alpha channel.
    WICBitmapIgnoreAlpha                     = 0x00000002,
    WICBITMAPALPHACHANNELOPTIONS_FORCE_DWORD = 0x7fffffff,
}

///Specifies the flip and rotation transforms.
enum WICBitmapTransformOptions : int
{
    ///A rotation of 0 degrees.
    WICBitmapTransformRotate0             = 0x00000000,
    ///A clockwise rotation of 90 degrees.
    WICBitmapTransformRotate90            = 0x00000001,
    ///A clockwise rotation of 180 degrees.
    WICBitmapTransformRotate180           = 0x00000002,
    ///A clockwise rotation of 270 degrees.
    WICBitmapTransformRotate270           = 0x00000003,
    ///A horizontal flip. Pixels are flipped around the vertical y-axis.
    WICBitmapTransformFlipHorizontal      = 0x00000008,
    ///A vertical flip. Pixels are flipped around the horizontal x-axis.
    WICBitmapTransformFlipVertical        = 0x00000010,
    WICBITMAPTRANSFORMOPTIONS_FORCE_DWORD = 0x7fffffff,
}

///Specifies access to an IWICBitmap.
enum WICBitmapLockFlags : int
{
    ///A read access lock.
    WICBitmapLockRead              = 0x00000001,
    ///A write access lock.
    WICBitmapLockWrite             = 0x00000002,
    WICBITMAPLOCKFLAGS_FORCE_DWORD = 0x7fffffff,
}

///Specifies the capabilities of the decoder.
enum WICBitmapDecoderCapabilities : int
{
    ///Decoder recognizes the image was encoded with an encoder produced by the same vendor.
    WICBitmapDecoderCapabilitySameEncoder          = 0x00000001,
    ///Decoder can decode all the images within an image container.
    WICBitmapDecoderCapabilityCanDecodeAllImages   = 0x00000002,
    ///Decoder can decode some of the images within an image container.
    WICBitmapDecoderCapabilityCanDecodeSomeImages  = 0x00000004,
    ///Decoder can enumerate the metadata blocks within a container format.
    WICBitmapDecoderCapabilityCanEnumerateMetadata = 0x00000008,
    ///Decoder can find and decode a thumbnail.
    WICBitmapDecoderCapabilityCanDecodeThumbnail   = 0x00000010,
    WICBITMAPDECODERCAPABILITIES_FORCE_DWORD       = 0x7fffffff,
}

///Specifies the progress operations to receive notifications for.
enum WICProgressOperation : int
{
    ///Receive copy pixel operation.
    WICProgressOperationCopyPixels   = 0x00000001,
    ///Receive write pixel operation.
    WICProgressOperationWritePixels  = 0x00000002,
    ///Receive all progress operations available.
    WICProgressOperationAll          = 0x0000ffff,
    WICPROGRESSOPERATION_FORCE_DWORD = 0x7fffffff,
}

///Specifies when the progress notification callback should be called.
enum WICProgressNotification : int
{
    ///The callback should be called when codec operations begin.
    WICProgressNotificationBegin        = 0x00010000,
    ///The callback should be called when codec operations end.
    WICProgressNotificationEnd          = 0x00020000,
    ///The callback should be called frequently to report status.
    WICProgressNotificationFrequent     = 0x00040000,
    ///The callback should be called on all available progress notifications.
    WICProgressNotificationAll          = 0xffff0000,
    WICPROGRESSNOTIFICATION_FORCE_DWORD = 0x7fffffff,
}

///Specifies the component signing status.
enum WICComponentSigning : int
{
    ///A signed component.
    WICComponentSigned              = 0x00000001,
    ///An unsigned component
    WICComponentUnsigned            = 0x00000002,
    ///A component is safe. Components that do not have a binary component to sign, such as a pixel format, should
    ///return this value.
    WICComponentSafe                = 0x00000004,
    ///A component has been disabled.
    WICComponentDisabled            = 0x80000000,
    WICCOMPONENTSIGNING_FORCE_DWORD = 0x7fffffff,
}

///Specifies the logical screen descriptor properties for Graphics Interchange Format (GIF) metadata.
enum WICGifLogicalScreenDescriptorProperties : uint
{
    ///[VT_UI1 | VT_VECTOR] Indicates the signature property.
    WICGifLogicalScreenSignature                        = 0x00000001,
    ///[VT_UI2] Indicates the width in pixels.
    WICGifLogicalScreenDescriptorWidth                  = 0x00000002,
    ///[VT_UI2] Indicates the height in pixels.
    WICGifLogicalScreenDescriptorHeight                 = 0x00000003,
    ///[VT_BOOL] Indicates the global color table flag. <b>TRUE</b> if a global color table is present; otherwise,
    ///<b>FALSE</b>.
    WICGifLogicalScreenDescriptorGlobalColorTableFlag   = 0x00000004,
    ///[VT_UI1] Indicates the color resolution in bits per pixel.
    WICGifLogicalScreenDescriptorColorResolution        = 0x00000005,
    ///[VT_BOOL] Indicates the sorted color table flag. <b>TRUE</b> if the table is sorted; otherwise, <b>FALSE</b>.
    WICGifLogicalScreenDescriptorSortFlag               = 0x00000006,
    ///[VT_UI1] Indicates the value used to calculate the number of bytes contained in the global color table. To
    ///calculate the actual size of the color table, raise 2 to the value of the field + 1.
    WICGifLogicalScreenDescriptorGlobalColorTableSize   = 0x00000007,
    ///[VT_UI1] Indicates the index within the color table to use for the background (pixels not defined in the image).
    WICGifLogicalScreenDescriptorBackgroundColorIndex   = 0x00000008,
    ///[VT_UI1] Indicates the factor used to compute an approximation of the aspect ratio.
    WICGifLogicalScreenDescriptorPixelAspectRatio       = 0x00000009,
    WICGifLogicalScreenDescriptorProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the image descriptor metadata properties for Graphics Interchange Format (GIF) frames.
enum WICGifImageDescriptorProperties : uint
{
    ///[VT_UI2] Indicates the X offset at which to locate this frame within the logical screen.
    WICGifImageDescriptorLeft                   = 0x00000001,
    ///[VT_UI2] Indicates the Y offset at which to locate this frame within the logical screen.
    WICGifImageDescriptorTop                    = 0x00000002,
    ///[VT_UI2] Indicates width of this frame, in pixels.
    WICGifImageDescriptorWidth                  = 0x00000003,
    ///[VT_UI2] Indicates height of this frame, in pixels.
    WICGifImageDescriptorHeight                 = 0x00000004,
    ///[VT_BOOL] Indicates the local color table flag. <b>TRUE</b> if global color table is present; otherwise,
    ///<b>FALSE</b>.
    WICGifImageDescriptorLocalColorTableFlag    = 0x00000005,
    ///[VT_BOOL] Indicates the interlace flag. <b>TRUE</b> if image is interlaced; otherwise, <b>FALSE</b>.
    WICGifImageDescriptorInterlaceFlag          = 0x00000006,
    ///[VT_BOOL] Indicates the sorted color table flag. <b>TRUE</b> if the color table is sorted from most frequently to
    ///least frequently used color; otherwise, <b>FALSE</b>.
    WICGifImageDescriptorSortFlag               = 0x00000007,
    ///[VT_UI1] Indicates the value used to calculate the number of bytes contained in the global color table. To
    ///calculate the actual size of the color table, raise 2 to the value of the field + 1.
    WICGifImageDescriptorLocalColorTableSize    = 0x00000008,
    WICGifImageDescriptorProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the graphic control extension metadata properties that define the transitions between each frame animation
///for Graphics Interchange Format (GIF) images.
enum WICGifGraphicControlExtensionProperties : uint
{
    ///[VT_UI1] Indicates the disposal requirements. 0 - no disposal, 1 - do not dispose, 2 - restore to background
    ///color, 3 - restore to previous.
    WICGifGraphicControlExtensionDisposal               = 0x00000001,
    ///[VT_BOOL] Indicates the user input flag. <b>TRUE</b> if user input should advance to the next frame; otherwise,
    ///<b>FALSE</b>.
    WICGifGraphicControlExtensionUserInputFlag          = 0x00000002,
    ///[VT_BOOL] Indicates the transparency flag. <b>TRUE</b> if a transparent color in is in the color table for this
    ///frame; otherwise, <b>FALSE</b>.
    WICGifGraphicControlExtensionTransparencyFlag       = 0x00000003,
    ///[VT_UI2] Indicates how long to display the next frame before advancing to the next frame, in units of 1/100th of
    ///a second.
    WICGifGraphicControlExtensionDelay                  = 0x00000004,
    ///[VT_UI1] Indicates which color in the palette should be treated as transparent.
    WICGifGraphicControlExtensionTransparentColorIndex  = 0x00000005,
    WICGifGraphicControlExtensionProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the application extension metadata properties for a Graphics Interchange Format (GIF) image.
enum WICGifApplicationExtensionProperties : uint
{
    ///[VT_UI1 | VT_VECTOR] Indicates a string that identifies the application.
    WICGifApplicationExtensionApplication            = 0x00000001,
    ///[VT_UI1 | VT_VECTOR] Indicates data that is exposed by the application.
    WICGifApplicationExtensionData                   = 0x00000002,
    WICGifApplicationExtensionProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the comment extension metadata properties for a Graphics Interchange Format (GIF) image.
enum WICGifCommentExtensionProperties : uint
{
    ///[VT_LPSTR] Indicates the comment text.
    WICGifCommentExtensionText                   = 0x00000001,
    WICGifCommentExtensionProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the JPEG comment properties.
enum WICJpegCommentProperties : uint
{
    ///Indicates the metadata property is comment text.
    WICJpegCommentText                   = 0x00000001,
    WICJpegCommentProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the JPEG luminance table property.
enum WICJpegLuminanceProperties : uint
{
    ///[VT_UI2|VT_VECTOR] Indicates the metadata property is a luminance table.
    WICJpegLuminanceTable                  = 0x00000001,
    WICJpegLuminanceProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the JPEG chrominance table property.
enum WICJpegChrominanceProperties : uint
{
    ///[VT_UI2|VT_VECTOR] Indicates the metadata property is a chrominance table.
    WICJpegChrominanceTable                  = 0x00000001,
    WICJpegChrominanceProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the identifiers of the metadata items in an 8BIM IPTC block.
enum WIC8BIMIptcProperties : uint
{
    ///[VT_LPSTR] A name that identifies the 8BIM block.
    WIC8BIMIptcPString                = 0x00000000,
    WIC8BIMIptcEmbeddedIPTC           = 0x00000001,
    WIC8BIMIptcProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the identifiers of the metadata items in an 8BIMResolutionInfo block.
enum WIC8BIMResolutionInfoProperties : uint
{
    ///[VT_LPSTR] A name that identifies the 8BIM block.
    WIC8BIMResolutionInfoPString                = 0x00000001,
    ///[VT_UI4] The horizontal resolution of the image.
    WIC8BIMResolutionInfoHResolution            = 0x00000002,
    ///[VT_UI2] The units that the horizontal resolution is specified in; a 1 indicates pixels per inch and a 2
    ///indicates pixels per centimeter.
    WIC8BIMResolutionInfoHResolutionUnit        = 0x00000003,
    ///[VT_UI2] The units that the image width is specified in; a 1 indicates inches, a 2 indicates centimeters, a 3
    ///indicates points, a 4 specifies picas, and a 5 specifies columns.
    WIC8BIMResolutionInfoWidthUnit              = 0x00000004,
    ///[VT_UI4] The vertical resolution of the image.
    WIC8BIMResolutionInfoVResolution            = 0x00000005,
    ///[VT_UI2] The units that the vertical resolution is specified in; a 1 indicates pixels per inch and a 2 indicates
    ///pixels per centimeter.
    WIC8BIMResolutionInfoVResolutionUnit        = 0x00000006,
    ///[VT_UI2] The units that the image height is specified in; a 1 indicates inches, a 2 indicates centimeters, a 3
    ///indicates points, a 4 specifies picas, and a 5 specifies columns.
    WIC8BIMResolutionInfoHeightUnit             = 0x00000007,
    WIC8BIMResolutionInfoProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the identifiers of the metadata items in an 8BIM IPTC digest metadata block.
enum WIC8BIMIptcDigestProperties : uint
{
    ///[VT_LPSTR] A name that identifies the 8BIM block.
    WIC8BIMIptcDigestPString                = 0x00000001,
    ///[VT_BLOB] The embedded IPTC digest value.
    WIC8BIMIptcDigestIptcDigest             = 0x00000002,
    WIC8BIMIptcDigestProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the Portable Network Graphics (PNG) gAMA chunk metadata properties.
enum WICPngGamaProperties : uint
{
    ///[VT_UI4] Indicates the gamma value.
    WICPngGamaGamma                  = 0x00000001,
    WICPngGamaProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the Portable Network Graphics (PNG) background (bKGD) chunk metadata properties.
enum WICPngBkgdProperties : uint
{
    ///Indicates the background color. There are three possible types, depending on the image's pixel format.
    WICPngBkgdBackgroundColor        = 0x00000001,
    WICPngBkgdProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the Portable Network Graphics (PNG) iTXT chunk metadata properties.
enum WICPngItxtProperties : uint
{
    ///[VT_LPSTR] Indicates the keywords in the iTXT metadata chunk.
    WICPngItxtKeyword                = 0x00000001,
    ///[VT_UI1] Indicates whether the text in the iTXT chunk is compressed. 1 if the text is compressed; otherwise, 0.
    WICPngItxtCompressionFlag        = 0x00000002,
    ///[VT_LPSTR] Indicates the human language used by the translated keyword and the text.
    WICPngItxtLanguageTag            = 0x00000003,
    ///[VT_LPWSTR] Indicates a translation of the keyword into the language indicated by the language tag.
    WICPngItxtTranslatedKeyword      = 0x00000004,
    ///[VT_LPWSTR] Indicates additional text in the iTXT metadata chunk.
    WICPngItxtText                   = 0x00000005,
    WICPngItxtProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the Portable Network Graphics (PNG) cHRM chunk metadata properties for CIE XYZ chromaticity.
enum WICPngChrmProperties : uint
{
    ///[VT_UI4] Indicates the whitepoint x value ratio.
    WICPngChrmWhitePointX            = 0x00000001,
    ///[VT_UI4] Indicates the whitepoint y value ratio.
    WICPngChrmWhitePointY            = 0x00000002,
    ///[VT_UI4] Indicates the red x value ratio.
    WICPngChrmRedX                   = 0x00000003,
    ///[VT_UI4] Indicates the red y value ratio.
    WICPngChrmRedY                   = 0x00000004,
    ///[VT_UI4] Indicates the green x value ratio.
    WICPngChrmGreenX                 = 0x00000005,
    ///[VT_UI4] Indicates the green y value ratio.
    WICPngChrmGreenY                 = 0x00000006,
    ///[VT_UI4] Indicates the blue x value ratio.
    WICPngChrmBlueX                  = 0x00000007,
    ///[VT_UI4] Indicates the blue y value ratio.
    WICPngChrmBlueY                  = 0x00000008,
    WICPngChrmProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the Portable Network Graphics (PNG) hIST chunk metadata properties.
enum WICPngHistProperties : uint
{
    ///[VT_VECTOR | VT_UI2] Indicates the approximate usage frequency of each color in the color palette.
    WICPngHistFrequencies            = 0x00000001,
    WICPngHistProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the Portable Network Graphics (PNG) iCCP chunk metadata properties.
enum WICPngIccpProperties : uint
{
    ///[VT_LPSTR] Indicates the International Color Consortium (ICC) profile name.
    WICPngIccpProfileName            = 0x00000001,
    ///[VT_VECTOR | VT_UI1] Indicates the embedded ICC profile.
    WICPngIccpProfileData            = 0x00000002,
    WICPngIccpProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the Portable Network Graphics (PNG) sRGB chunk metadata properties.
enum WICPngSrgbProperties : uint
{
    ///[VT_UI1] Indicates the rendering intent for an sRGB color space image. The rendering intents have the following
    ///meaning. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>0</td> <td>Perceptual</td> </tr> <tr>
    ///<td>1</td> <td>Relative colorimetric</td> </tr> <tr> <td>2</td> <td>Saturation</td> </tr> <tr> <td>3</td>
    ///<td>Absolute colorimetric</td> </tr> </table>
    WICPngSrgbRenderingIntent        = 0x00000001,
    WICPngSrgbProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the Portable Network Graphics (PNG) tIME chunk metadata properties.
enum WICPngTimeProperties : uint
{
    ///[VT_UI2] Indicates the year of the last modification.
    WICPngTimeYear                   = 0x00000001,
    ///[VT_UI1] Indicates the month of the last modification.
    WICPngTimeMonth                  = 0x00000002,
    ///[VT_UI1] Indicates day of the last modification.
    WICPngTimeDay                    = 0x00000003,
    ///[VT_UI1] Indicates the hour of the last modification.
    WICPngTimeHour                   = 0x00000004,
    ///[VT_UI1] Indicates the minute of the last modification.
    WICPngTimeMinute                 = 0x00000005,
    ///[VT_UI1] Indicates the second of the last modification.
    WICPngTimeSecond                 = 0x00000006,
    WICPngTimeProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the properties of a High Efficiency Image Format (HEIF) image.
enum WICHeifProperties : uint
{
    ///[VT_UI2] Indicates the orientation of the image. The value of this property uses the same numbering scheme as the
    ///System.Photo.Orientation property. For example, a value of 1 (PHOTO_ORIENTATION_NORMAL) indicates a 0 degree
    ///rotation.
    WICHeifOrientation            = 0x00000001,
    WICHeifProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the HDR properties of a High Efficiency Image Format (HEIF) image.
enum WICHeifHdrProperties : uint
{
    ///[VT_UI2] Specifies the maximum luminance level of the content in Nits.
    WICHeifHdrMaximumLuminanceLevel                 = 0x00000001,
    ///[VT_UI2] Specifies the maximum average per-frame luminance level of the content in Nits.
    WICHeifHdrMaximumFrameAverageLuminanceLevel     = 0x00000002,
    ///[VT_UI2] Specifies the maximum luminance of the display on which the content was authored, in Nits.
    WICHeifHdrMinimumMasteringDisplayLuminanceLevel = 0x00000003,
    ///[VT_UI2] Specifies the maximum luminance of the display on which the content was authored, in Nits.
    WICHeifHdrMaximumMasteringDisplayLuminanceLevel = 0x00000004,
    ///[VT_BLOB] Specifies custom color primaries for a video media type. The value of this property is a
    ///[MT_CUSTOM_VIDEO_PRIMARIES](/windows/desktop/api/mfapi/ns-mfapi-mt_custom_video_primaries)structure, returned as
    ///an array of bytes (VT_BLOB).
    WICHeifHdrCustomVideoPrimaries                  = 0x00000005,
    WICHeifHdrProperties_FORCE_DWORD                = 0x7fffffff,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Specifies the animation properties of a WebP image.
enum WICWebpAnimProperties : uint
{
    ///The number of times the animation loops. A value of 0 indicates that the animation will loop infinitely.
    WICWebpAnimLoopCount              = 0x00000001,
    WICWebpAnimProperties_FORCE_DWORD = 0x7fffffff,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Specifies the animation frame properties of a WebP image.
enum WICWebpAnmfProperties : uint
{
    ///The time to wait before displaying the next frame, in milliseconds.
    WICWebpAnmfFrameDuration          = 0x00000001,
    WICWebpAnmfProperties_FORCE_DWORD = 0x7fffffff,
}

///Specifies the access level of a Windows Graphics Device Interface (GDI) section.
enum WICSectionAccessLevel : uint
{
    ///Indicates a read only access level.
    WICSectionAccessLevelRead         = 0x00000001,
    ///Indicates a read/write access level.
    WICSectionAccessLevelReadWrite    = 0x00000003,
    WICSectionAccessLevel_FORCE_DWORD = 0x7fffffff,
}

///Defines constants that specify a primitive type for numeric representation of a WIC pixel format.
enum WICPixelFormatNumericRepresentation : uint
{
    ///The format is not specified.
    WICPixelFormatNumericRepresentationUnspecified     = 0x00000000,
    ///Specifies that the format is indexed.
    WICPixelFormatNumericRepresentationIndexed         = 0x00000001,
    ///Specifies that the format is represented as an unsigned integer.
    WICPixelFormatNumericRepresentationUnsignedInteger = 0x00000002,
    ///Specifies that the format is represented as a signed integer.
    WICPixelFormatNumericRepresentationSignedInteger   = 0x00000003,
    ///Specifies that the format is represented as a fixed-point number.
    WICPixelFormatNumericRepresentationFixed           = 0x00000004,
    ///Specifies that the format is represented as a floating-point number.
    WICPixelFormatNumericRepresentationFloat           = 0x00000005,
    WICPixelFormatNumericRepresentation_FORCE_DWORD    = 0x7fffffff,
}

///Specifies additional options to an IWICPlanarBitmapSourceTransform implementation.
enum WICPlanarOptions : int
{
    ///No options specified. WIC JPEG Decoder: The default behavior for iDCT scaling is to preserve quality when
    ///downscaling by downscaling only the Y plane in some cases, and the image may change to 4:4:4 chroma subsampling.
    WICPlanarOptionsDefault             = 0x00000000,
    ///Asks the source to preserve the size ratio between planes when scaling. WIC JPEG Decoder: Specifying this option
    ///causes the JPEG decoder to scale luma and chroma planes by the same amount, so a 4:2:0 chroma subsampled image
    ///outputs 4:2:0 data when downscaling by 2x, 4x, or 8x.
    WICPlanarOptionsPreserveSubsampling = 0x00000001,
    WICPLANAROPTIONS_FORCE_DWORD        = 0x7fffffff,
}

///Specifies the options for indexing a JPEG image.
enum WICJpegIndexingOptions : uint
{
    ///Index generation is deferred until IWICBitmapSource::CopyPixels is called on the image.
    WICJpegIndexingOptionsGenerateOnDemand = 0x00000000,
    ///Index generation is performed when the when the image is initially loaded.
    WICJpegIndexingOptionsGenerateOnLoad   = 0x00000001,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    WICJpegIndexingOptions_FORCE_DWORD     = 0x7fffffff,
}

///Specifies conversion matrix from Y'Cb'Cr' to R'G'B'.
enum WICJpegTransferMatrix : uint
{
    ///Specifies the identity transfer matrix.
    WICJpegTransferMatrixIdentity     = 0x00000000,
    ///Specifies the BT601 transfer matrix.
    WICJpegTransferMatrixBT601        = 0x00000001,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    WICJpegTransferMatrix_FORCE_DWORD = 0x7fffffff,
}

///Specifies the memory layout of pixel data in a JPEG image scan.
enum WICJpegScanType : uint
{
    ///The pixel data is stored in an interleaved memory layout.
    WICJpegScanTypeInterleaved      = 0x00000000,
    ///The pixel data is stored in a planar memory layout.
    WICJpegScanTypePlanarComponents = 0x00000001,
    ///The pixel data is stored in a progressive layout.
    WICJpegScanTypeProgressive      = 0x00000002,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    WICJpegScanType_FORCE_DWORD     = 0x7fffffff,
}

///Specifies the Tagged Image File Format (TIFF) compression options.
enum WICTiffCompressionOption : int
{
    ///Indicates a suitable compression algorithm based on the image and pixel format.
    WICTiffCompressionDontCare           = 0x00000000,
    ///Indicates no compression.
    WICTiffCompressionNone               = 0x00000001,
    ///Indicates a CCITT3 compression algorithm. This algorithm is only valid for 1bpp pixel formats.
    WICTiffCompressionCCITT3             = 0x00000002,
    ///Indicates a CCITT4 compression algorithm. This algorithm is only valid for 1bpp pixel formats.
    WICTiffCompressionCCITT4             = 0x00000003,
    ///Indicates a LZW compression algorithm.
    WICTiffCompressionLZW                = 0x00000004,
    ///Indicates a RLE compression algorithm. This algorithm is only valid for 1bpp pixel formats.
    WICTiffCompressionRLE                = 0x00000005,
    ///Indicates a ZIP compression algorithm.
    WICTiffCompressionZIP                = 0x00000006,
    ///Indicates an LZWH differencing algorithm.
    WICTiffCompressionLZWHDifferencing   = 0x00000007,
    WICTIFFCOMPRESSIONOPTION_FORCE_DWORD = 0x7fffffff,
}

///Specifies the JPEG YCrCB subsampling options.
enum WICJpegYCrCbSubsamplingOption : int
{
    ///The default subsampling option.
    WICJpegYCrCbSubsamplingDefault      = 0x00000000,
    ///Subsampling option that uses both horizontal and vertical decimation.
    WICJpegYCrCbSubsampling420          = 0x00000001,
    ///Subsampling option that uses horizontal decimation .
    WICJpegYCrCbSubsampling422          = 0x00000002,
    ///Subsampling option that uses no decimation.
    WICJpegYCrCbSubsampling444          = 0x00000003,
    ///Subsampling option that uses 2x vertical downsampling only. This option is only available in Windows 8.1 and
    ///later.
    WICJpegYCrCbSubsampling440          = 0x00000004,
    WICJPEGYCRCBSUBSAMPLING_FORCE_DWORD = 0x7fffffff,
}

///Specifies the Portable Network Graphics (PNG) filters available for compression optimization.
enum WICPngFilterOption : int
{
    ///Indicates an unspecified PNG filter. This enables WIC to algorithmically choose the best filtering option for the
    ///image.
    WICPngFilterUnspecified        = 0x00000000,
    ///Indicates no PNG filter.
    WICPngFilterNone               = 0x00000001,
    ///Indicates a PNG sub filter.
    WICPngFilterSub                = 0x00000002,
    ///Indicates a PNG up filter.
    WICPngFilterUp                 = 0x00000003,
    ///Indicates a PNG average filter.
    WICPngFilterAverage            = 0x00000004,
    ///Indicates a PNG paeth filter.
    WICPngFilterPaeth              = 0x00000005,
    ///Indicates a PNG adaptive filter. This enables WIC to choose the best filtering mode on a per-scanline basis.
    WICPngFilterAdaptive           = 0x00000006,
    WICPNGFILTEROPTION_FORCE_DWORD = 0x7fffffff,
}

///Specifies named white balances for raw images.
enum WICNamedWhitePoint : int
{
    ///The default white balance.
    WICWhitePointDefault           = 0x00000001,
    ///A daylight white balance.
    WICWhitePointDaylight          = 0x00000002,
    ///A cloudy white balance.
    WICWhitePointCloudy            = 0x00000004,
    ///A shade white balance.
    WICWhitePointShade             = 0x00000008,
    ///A tungsten white balance.
    WICWhitePointTungsten          = 0x00000010,
    ///A fluorescent white balance.
    WICWhitePointFluorescent       = 0x00000020,
    ///Daylight white balance.
    WICWhitePointFlash             = 0x00000040,
    ///A flash white balance.
    WICWhitePointUnderwater        = 0x00000080,
    ///A custom white balance. This is typically used when using a picture (grey-card) as white balance.
    WICWhitePointCustom            = 0x00000100,
    ///An automatic balance.
    WICWhitePointAutoWhiteBalance  = 0x00000200,
    ///An "as shot" white balance.
    WICWhitePointAsShot            = 0x00000001,
    WICNAMEDWHITEPOINT_FORCE_DWORD = 0x7fffffff,
}

///Specifies the capability support of a raw image.
enum WICRawCapabilities : int
{
    ///The capability is not supported.
    WICRawCapabilityNotSupported   = 0x00000000,
    ///The capability supports only get operations.
    WICRawCapabilityGetSupported   = 0x00000001,
    ///The capability supports get and set operations.
    WICRawCapabilityFullySupported = 0x00000002,
    WICRAWCAPABILITIES_FORCE_DWORD = 0x7fffffff,
}

///Specifies the rotation capabilities of the codec.
enum WICRawRotationCapabilities : int
{
    ///Rotation is not supported.
    WICRawRotationCapabilityNotSupported           = 0x00000000,
    ///Set operations for rotation is not supported.
    WICRawRotationCapabilityGetSupported           = 0x00000001,
    ///90 degree rotations are supported.
    WICRawRotationCapabilityNinetyDegreesSupported = 0x00000002,
    ///All rotation angles are supported.
    WICRawRotationCapabilityFullySupported         = 0x00000003,
    WICRAWROTATIONCAPABILITIES_FORCE_DWORD         = 0x7fffffff,
}

///Specifies the parameter set used by a raw codec.
enum WICRawParameterSet : int
{
    ///An as shot parameter set.
    WICAsShotParameterSet          = 0x00000001,
    ///A user adjusted parameter set.
    WICUserAdjustedParameterSet    = 0x00000002,
    ///A codec adjusted parameter set.
    WICAutoAdjustedParameterSet    = 0x00000003,
    WICRAWPARAMETERSET_FORCE_DWORD = 0x7fffffff,
}

///Specifies the render intent of the next CopyPixels call.
enum WICRawRenderMode : int
{
    ///Use speed priority mode.
    WICRawRenderModeDraft        = 0x00000001,
    ///Use normal priority mode. Balance of speed and quality.
    WICRawRenderModeNormal       = 0x00000002,
    ///Use best quality mode.
    WICRawRenderModeBestQuality  = 0x00000003,
    WICRAWRENDERMODE_FORCE_DWORD = 0x7fffffff,
}

///Specifies the dimension type of the data contained in DDS image.
enum WICDdsDimension : int
{
    ///DDS image contains a 1-dimensional texture .
    WICDdsTexture1D           = 0x00000000,
    ///DDS image contains a 2-dimensional texture .
    WICDdsTexture2D           = 0x00000001,
    ///DDS image contains a 3-dimensional texture .
    WICDdsTexture3D           = 0x00000002,
    ///The DDS image contains a cube texture represented as an array of 6 faces.
    WICDdsTextureCube         = 0x00000003,
    WICDDSTEXTURE_FORCE_DWORD = 0x7fffffff,
}

///Specifies the the meaning of pixel color component values contained in the DDS image.
enum WICDdsAlphaMode : int
{
    ///Alpha behavior is unspecified and must be determined by the reader.
    WICDdsAlphaModeUnknown       = 0x00000000,
    ///The alpha data is straight.
    WICDdsAlphaModeStraight      = 0x00000001,
    ///The alpha data is premultiplied.
    WICDdsAlphaModePremultiplied = 0x00000002,
    ///The alpha data is opaque (UNORM value of 1). This can be used by a compliant reader as a performance
    ///optimization. For example, blending operations can be converted to copies.
    WICDdsAlphaModeOpaque        = 0x00000003,
    ///The alpha channel contains custom data that is not alpha.
    WICDdsAlphaModeCustom        = 0x00000004,
    WICDDSALPHAMODE_FORCE_DWORD  = 0x7fffffff,
}

///Specifies metadata creation options.
enum WICMetadataCreationOptions : int
{
    ///The default metadata creation options. The default value is <b>WICMetadataCreationAllowUnknown</b>.
    WICMetadataCreationDefault      = 0x00000000,
    ///Allow unknown metadata creation.
    WICMetadataCreationAllowUnknown = 0x00000000,
    ///Fail on unknown metadata creation.
    WICMetadataCreationFailUnknown  = 0x00010000,
    WICMetadataCreationMask         = 0xffff0000,
}

///Specifies Windows Imaging Component (WIC) options that are used when initializing a component with a stream.
enum WICPersistOptions : int
{
    ///The default persist options. The default is <b>WICPersistOptionLittleEndian</b>.
    WICPersistOptionDefault       = 0x00000000,
    ///The data byte order is little endian.
    WICPersistOptionLittleEndian  = 0x00000000,
    ///The data byte order is big endian.
    WICPersistOptionBigEndian     = 0x00000001,
    ///The data format must strictly conform to the specification. <div class="alert"><b>Warning</b> This option is
    ///inconsistently implement and should not be relied on.</div> <div> </div>
    WICPersistOptionStrictFormat  = 0x00000002,
    ///No cache for the metadata stream. Certain operations, such as
    ///IWICComponentFactory::CreateMetadataWriterFromReader require that the reader have a stream. Therefore, these
    ///operations will be unavailable if the reader is initialized with <b>WICPersistOptionNoCacheStream</b>.
    WICPersistOptionNoCacheStream = 0x00000004,
    ///Use UTF8 instead of the default UTF16. <div class="alert"><b>Note</b> This option is currently unused by
    ///WIC.</div> <div> </div>
    WICPersistOptionPreferUTF8    = 0x00000008,
    ///The WICPersistOptions mask.
    WICPersistOptionMask          = 0x0000ffff,
}

// Callbacks

///Application defined callback function called when codec component progress is made.
///Params:
///    pvData = Type: <b>LPVOID</b> Component data passed to the callback function.
///    uFrameNum = Type: <b>ULONG</b> The current frame number.
///    operation = Type: <b>WICProgressOperation</b> The current operation the component is in.
///    dblProgress = Type: <b>double</b> The progress value. The range is 0.0 to 1.0.
///Returns:
///    Type: <b>HRESULT</b> If this callback function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
alias PFNProgressNotification = HRESULT function(void* pvData, uint uFrameNum, WICProgressOperation operation, 
                                                 double dblProgress);

// Structs


///Represents a rectangle for Windows Imaging Component (WIC) API.
struct WICRect
{
    ///Type: <b>INT</b> The horizontal coordinate of the rectangle.
    int X;
    ///Type: <b>INT</b> The vertical coordinate of the rectangle.
    int Y;
    ///Type: <b>INT</b> The width of the rectangle.
    int Width;
    int Height;
}

///Contains members that identify a pattern within an image file which can be used to identify a particular format.
struct WICBitmapPattern
{
    ///Type: <b>ULARGE_INTEGER</b> The offset the pattern is located in the file.
    ULARGE_INTEGER Position;
    ///Type: <b>ULONG</b> The pattern length.
    uint           Length;
    ///Type: <b>BYTE*</b> The actual pattern.
    ubyte*         Pattern;
    ///Type: <b>BYTE*</b> The pattern mask.
    ubyte*         Mask;
    BOOL           EndOfStream;
}

///This defines parameters that you can use to override the default parameters normally used when encoding an image.
struct WICImageParameters
{
    ///The pixel format to which the image is processed before it is written to the encoder.
    D2D1_PIXEL_FORMAT PixelFormat;
    ///The DPI in the x dimension.
    float             DpiX;
    ///The DPI in the y dimension.
    float             DpiY;
    ///The top corner in pixels of the image space to be encoded to the destination.
    float             Top;
    ///The left corner in pixels of the image space to be encoded to the destination.
    float             Left;
    ///The width in pixels of the part of the image to write.
    uint              PixelWidth;
    ///The height in pixels of the part of the image to write.
    uint              PixelHeight;
}

///Specifies the pixel format and size of a component plane.
struct WICBitmapPlaneDescription
{
    ///Describes the pixel format of the plane.
    GUID Format;
    ///Component width of the plane.
    uint Width;
    ///Component height of the plane.
    uint Height;
}

///Specifies the pixel format, buffer, stride and size of a component plane for a planar pixel format.
struct WICBitmapPlane
{
    ///Type: <b>WICPixelFormatGUID</b> Describes the pixel format of the plane.
    GUID   Format;
    ///Type: <b>BYTE*</b> Pointer to the buffer that holds the plane’s pixel components.
    ubyte* pbBuffer;
    ///Type: <b>UINT</b> The stride of the buffer ponted to by <i>pbData</i>. Stride indicates the total number of bytes
    ///to go from the beginning of one scanline to the beginning of the next scanline.
    uint   cbStride;
    ///Type: <b>UINT</b> The total size of the buffer pointed to by <i>pbBuffer</i>.
    uint   cbBufferSize;
}

///Represents a JPEG frame header.
struct WICJpegFrameHeader
{
    ///The width of the JPEG frame.
    uint            Width;
    ///The height of the JPEG frame.
    uint            Height;
    ///The transfer matrix of the JPEG frame.
    WICJpegTransferMatrix TransferMatrix;
    ///The scan type of the JPEG frame.
    WICJpegScanType ScanType;
    ///The number of components in the frame.
    uint            cComponents;
    ///The component identifiers.
    uint            ComponentIdentifiers;
    ///The sample factors. Use one of the following constants, described in IWICJpegFrameDecode Constants. <ul>
    ///<li>WIC_JPEG_SAMPLE_FACTORS_ONE</li> <li>WIC_JPEG_SAMPLE_FACTORS_THREE_420</li>
    ///<li>WIC_JPEG_SAMPLE_FACTORS_THREE_422</li> <li>WIC_JPEG_SAMPLE_FACTORS_THREE_440</li>
    ///<li>WIC_JPEG_SAMPLE_FACTORS_THREE_444</li> </ul>
    uint            SampleFactors;
    ///The format of the quantization table indices. Use one of the following constants, described in
    ///IWICJpegFrameDecode Constants. <ul> <li>WIC_JPEG_QUANTIZATION_BASELINE_ONE</li>
    ///<li>WIC_JPEG_QUANTIZATION_BASELINE_THREE </li> </ul>
    uint            QuantizationTableIndices;
}

///Represents a JPEG frame header.
struct WICJpegScanHeader
{
    ///The number of components in the scan.
    uint  cComponents;
    ///The interval of reset markers within the scan.
    uint  RestartInterval;
    ///The component identifiers.
    uint  ComponentSelectors;
    ///The format of the quantization table indices. Use one of the following constants, described in
    ///IWICJpegFrameDecode Constants. <ul> <li>WIC_JPEG_HUFFMAN_BASELINE_ONE</li> <li>WIC_JPEG_HUFFMAN_BASELINE_THREE
    ///</li> </ul>
    uint  HuffmanTableIndices;
    ///The start of the spectral selection.
    ubyte StartSpectralSelection;
    ///The end of the spectral selection.
    ubyte EndSpectralSelection;
    ///The successive approximation high.
    ubyte SuccessiveApproximationHigh;
    ///The successive approximation low.
    ubyte SuccessiveApproximationLow;
}

///Defines raw codec capabilites.
struct WICRawCapabilitiesInfo
{
    ///Type: <b>UINT</b> Size of the <b>WICRawCapabilitiesInfo</b> structure.
    uint               cbSize;
    ///Type: <b>UINT</b> The codec's major version.
    uint               CodecMajorVersion;
    ///Type: <b>UINT</b> The codec's minor version.
    uint               CodecMinorVersion;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of exposure compensation support.
    WICRawCapabilities ExposureCompensationSupport;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of contrast support.
    WICRawCapabilities ContrastSupport;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of RGB white point support.
    WICRawCapabilities RGBWhitePointSupport;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of WICNamedWhitePoint support.
    WICRawCapabilities NamedWhitePointSupport;
    ///Type: <b>UINT</b> The WICNamedWhitePoint mask.
    uint               NamedWhitePointSupportMask;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of kelvin white point support.
    WICRawCapabilities KelvinWhitePointSupport;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of gamma support.
    WICRawCapabilities GammaSupport;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of tint support.
    WICRawCapabilities TintSupport;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of saturation support.
    WICRawCapabilities SaturationSupport;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of sharpness support.
    WICRawCapabilities SharpnessSupport;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of noise reduction support.
    WICRawCapabilities NoiseReductionSupport;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of destination color profile support.
    WICRawCapabilities DestinationColorProfileSupport;
    ///Type: <b>WICRawCapabilities</b> The WICRawCapabilities of tone curve support.
    WICRawCapabilities ToneCurveSupport;
    ///Type: <b>WICRawRotationCapabilities</b> The WICRawRotationCapabilities of rotation support.
    WICRawRotationCapabilities RotationSupport;
    WICRawCapabilities RenderModeSupport;
}

///Represents a raw image tone curve point.
struct WICRawToneCurvePoint
{
    ///Type: <b>double</b> The tone curve input.
    double Input;
    double Output;
}

///Represents a raw image tone curve.
struct WICRawToneCurve
{
    ///Type: <b>UINT</b> The number of tone curve points.
    uint cPoints;
    WICRawToneCurvePoint[1] aPoints;
}

///Specifies the DDS image dimension, DXGI_FORMAT and alpha mode of contained data.
struct WICDdsParameters
{
    ///Type: <b>UINT</b> The width, in pixels, of the texture at the largest mip size (mip level 0).
    uint            Width;
    ///Type: <b>UINT</b> The height, in pixels, of the texture at the largest mip size (mip level 0). When the DDS image
    ///contains a 1-dimensional texture, this value is equal to 1.
    uint            Height;
    ///Type: <b>UINT</b> The number of slices in the 3D texture. This is equivalent to the depth, in pixels, of the 3D
    ///texture at the largest mip size (mip level 0). When the DDS image contains a 1- or 2-dimensional texture, this
    ///value is equal to 1.
    uint            Depth;
    ///Type: <b>UINT</b> The number of mip levels contained in the DDS image.
    uint            MipLevels;
    ///Type: <b>UINT</b> The number of textures in the array in the DDS image.
    uint            ArraySize;
    ///Type: <b>DXGI_FORMAT</b> The DXGI_FORMAT of the DDS pixel data.
    DXGI_FORMAT     DxgiFormat;
    ///Type: <b>WICDdsDimension</b> Specifies the dimension type of the data contained in DDS image (1D, 2D, 3D or cube
    ///texture).
    WICDdsDimension Dimension;
    ///Type: <b>WICDdsAlphaMode</b> Specifies the alpha behavior of the DDS image.
    WICDdsAlphaMode AlphaMode;
}

///Specifies the DXGI_FORMAT and block information of a DDS format.
struct WICDdsFormatInfo
{
    ///Type: <b>DXGI_FORMAT</b> The DXGI_FORMAT
    DXGI_FORMAT DxgiFormat;
    ///Type: <b>UINT</b> The size of a single block in bytes. For DXGI_FORMAT values that are not block-based, the value
    ///is equal to the size of a single pixel in bytes.
    uint        BytesPerBlock;
    ///Type: <b>UINT</b> The width of a single block in pixels. For DXGI_FORMAT values that are not block-based, the
    ///value is 1.
    uint        BlockWidth;
    ///Type: <b>UINT</b> The height of a single block in pixels. For DXGI_FORMAT values that are not block-based, the
    ///value is 1.
    uint        BlockHeight;
}

///Represents a metadata pattern.
struct WICMetadataPattern
{
    ///Type: <b>ULARGE_INTEGER</b> The position of the pattern.
    ULARGE_INTEGER Position;
    ///Type: <b>ULONG</b> The length of the pattern.
    uint           Length;
    ///Type: <b>BYTE*</b> Pointer to the pattern.
    ubyte*         Pattern;
    ///Type: <b>BYTE*</b> Pointer to the pattern mask.
    ubyte*         Mask;
    ULARGE_INTEGER DataOffset;
}

///Represents metadata header.
struct WICMetadataHeader
{
    ///Type: <b>ULARGE_INTEGER</b> The position of the header.
    ULARGE_INTEGER Position;
    ///Type: <b>ULONG</b> The length of the header.
    uint           Length;
    ///Type: <b>BYTE*</b> Pointer to the header.
    ubyte*         Header;
    ULARGE_INTEGER DataOffset;
}

// Functions

///Obtains a IWICBitmapSource in the desired pixel format from a given <b>IWICBitmapSource</b>.
///Params:
///    dstFormat = Type: <b>REFWICPixelFormatGUID</b> The pixel format to convert to.
///    pISrc = Type: <b>IWICBitmapSource*</b> The source bitmap.
///    ppIDst = Type: <b>IWICBitmapSource**</b> A pointer to the <b>null</b>-initialized destination bitmap pointer.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns **S_OK**. Otherwise, it returns an **HRESULT** error
///    code.
///    
@DllImport("WindowsCodecs")
HRESULT WICConvertBitmapSource(GUID* dstFormat, IWICBitmapSource pISrc, IWICBitmapSource* ppIDst);

///Returns a IWICBitmapSource that is backed by the pixels of a Windows Graphics Device Interface (GDI) section handle.
///Params:
///    width = Type: <b>UINT</b> The width of the bitmap pixels.
///    height = Type: <b>UINT</b> The height of the bitmap pixels.
///    pixelFormat = Type: <b>REFWICPixelFormatGUID</b> The pixel format of the bitmap.
///    hSection = Type: <b>HANDLE</b> The section handle. This is a file mapping object handle returned by the CreateFileMapping
///               function.
///    stride = Type: <b>UINT</b> The byte count of each scanline.
///    offset = Type: <b>UINT</b> The offset into the section.
///    ppIBitmap = Type: <b>IWICBitmap**</b> A pointer that receives the bitmap.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("WindowsCodecs")
HRESULT WICCreateBitmapFromSection(uint width, uint height, GUID* pixelFormat, HANDLE hSection, uint stride, 
                                   uint offset, IWICBitmap* ppIBitmap);

///Returns a IWICBitmapSource that is backed by the pixels of a Windows Graphics Device Interface (GDI) section handle.
///Params:
///    width = Type: <b>UINT</b> The width of the bitmap pixels.
///    height = Type: <b>UINT</b> The height of the bitmap pixels.
///    pixelFormat = Type: <b>REFWICPixelFormatGUID</b> The pixel format of the bitmap.
///    hSection = Type: <b>HANDLE</b> The section handle. This is a file mapping object handle returned by the CreateFileMapping
///               function.
///    stride = Type: <b>UINT</b> The byte count of each scanline.
///    offset = Type: <b>UINT</b> The offset into the section.
///    desiredAccessLevel = Type: <b>WICSectionAccessLevel</b> The desired access level.
///    ppIBitmap = Type: <b>IWICBitmap**</b> A pointer that receives the bitmap.
@DllImport("WindowsCodecs")
HRESULT WICCreateBitmapFromSectionEx(uint width, uint height, GUID* pixelFormat, HANDLE hSection, uint stride, 
                                     uint offset, WICSectionAccessLevel desiredAccessLevel, IWICBitmap* ppIBitmap);

///Obtains the short name associated with a given GUID.
///Params:
///    guid = Type: <b>REFGUID</b> The GUID to retrieve the short name for.
///    cchName = Type: <b>UINT</b> The size of the <i>wzName</i> buffer.
///    wzName = Type: <b>WCHAR*</b> A pointer that receives the short name associated with the GUID.
///    pcchActual = Type: <b>UINT*</b> The actual size needed to retrieve the entire short name associated with the GUID.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("WindowsCodecs")
HRESULT WICMapGuidToShortName(const(GUID)* guid, uint cchName, char* wzName, uint* pcchActual);

///Obtains the GUID associated with the given short name.
///Params:
///    wzName = Type: <b>const WCHAR*</b> A pointer to the short name.
///    pguid = Type: <b>GUID*</b> A pointer that receives the GUID associated with the given short name.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("WindowsCodecs")
HRESULT WICMapShortNameToGuid(const(wchar)* wzName, GUID* pguid);

///Obtains the name associated with a given schema.
///Params:
///    guidMetadataFormat = Type: <b>REFGUID</b> The metadata format GUID.
///    pwzSchema = Type: <b>LPWSTR</b> The URI string of the schema for which the name is to be retrieved.
///    cchName = Type: <b>UINT</b> The size of the <i>wzName</i> buffer.
///    wzName = Type: <b>WCHAR*</b> A pointer to a buffer that receives the schema's name. To obtain the required buffer size,
///             call <b>WICMapSchemaToName</b> with <i>cchName</i> set to 0 and <i>wzName</i> set to <b>NULL</b>.
///    pcchActual = Type: <b>UINT</b> The actual buffer size needed to retrieve the entire schema name.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("WindowsCodecs")
HRESULT WICMapSchemaToName(const(GUID)* guidMetadataFormat, const(wchar)* pwzSchema, uint cchName, char* wzName, 
                           uint* pcchActual);

///Obtains a metadata format GUID for a specified container format and vendor that best matches the content within a
///given stream.
///Params:
///    guidContainerFormat = Type: <b>REFGUID</b> The container format GUID.
///    pguidVendor = Type: <b>const GUID*</b> The vendor GUID.
///    pIStream = Type: <b>IStream*</b> The content stream in which to match a metadata format.
///    pguidMetadataFormat = Type: <b>GUID*</b> A pointer that receives a metadata format GUID for the given parameters.
@DllImport("WindowsCodecs")
HRESULT WICMatchMetadataContent(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, IStream pIStream, 
                                GUID* pguidMetadataFormat);

///Writes metadata into a given stream.
///Params:
///    guidContainerFormat = Type: <b>REFGUID</b> The container format GUID.
///    pIWriter = Type: <b>IWICMetadataWriter*</b> The metadata writer to write metadata to the stream.
///    dwPersistOptions = Type: <b>DWORD</b> The WICPersistOptions options to use when writing the metadata.
///    pIStream = Type: <b>IStream*</b> A pointer to the stream in which to write the metadata.
@DllImport("WindowsCodecs")
HRESULT WICSerializeMetadataContent(const(GUID)* guidContainerFormat, IWICMetadataWriter pIWriter, 
                                    uint dwPersistOptions, IStream pIStream);

///Returns the size of the metadata content contained by the specified IWICMetadataWriter. The returned size accounts
///for the header and the length of the metadata.
///Params:
///    guidContainerFormat = Type: <b>REFGUID</b> The container GUID.
///    pIWriter = Type: <b>IWICMetadataWriter*</b> The IWICMetadataWriter that contains the content.
///    pcbSize = Type: <b>ULARGE_INTEGER*</b> A pointer that receives the size of the metadata content.
@DllImport("WindowsCodecs")
HRESULT WICGetMetadataContentSize(const(GUID)* guidContainerFormat, IWICMetadataWriter pIWriter, 
                                  ULARGE_INTEGER* pcbSize);


// Interfaces

///Exposes methods for accessing and building a color table, primarily for indexed pixel formats.
@GUID("00000040-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICPalette : IUnknown
{
    ///Initializes the palette to one of the pre-defined palettes specified by WICBitmapPaletteType and optionally adds
    ///a transparent color.
    ///Params:
    ///    ePaletteType = Type: <b>WICBitmapPaletteType</b> The desired pre-defined palette type.
    ///    fAddTransparentColor = Type: <b>BOOL</b> The optional transparent color to add to the palette. If no transparent color is needed,
    ///                           use 0. When initializing to a grayscale or black and white palette, set this parameter to <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializePredefined(WICBitmapPaletteType ePaletteType, BOOL fAddTransparentColor);
    ///Initializes a palette to the custom color entries provided.
    ///Params:
    ///    pColors = Type: <b>WICColor*</b> Pointer to the color array.
    ///    cCount = Type: <b>UINT</b> The number of colors in <i>pColors</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializeCustom(char* pColors, uint cCount);
    ///Initializes a palette using a computed optimized values based on the reference bitmap.
    ///Params:
    ///    pISurface = Type: <b>IWICBitmapSource*</b> Pointer to the source bitmap.
    ///    cCount = Type: <b>UINT</b> The number of colors to initialize the palette with.
    ///    fAddTransparentColor = Type: <b>BOOL</b> A value to indicate whether to add a transparent color.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializeFromBitmap(IWICBitmapSource pISurface, uint cCount, BOOL fAddTransparentColor);
    ///Initialize the palette based on a given palette.
    ///Params:
    ///    pIPalette = Type: <b>IWICPalette*</b> Pointer to the source palette.
    HRESULT InitializeFromPalette(IWICPalette pIPalette);
    ///Retrieves the WICBitmapPaletteType that describes the palette.
    ///Params:
    ///    pePaletteType = Type: <b>WICBitmapPaletteType*</b> Pointer that receives the palette type of the bimtap.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetType(WICBitmapPaletteType* pePaletteType);
    ///Retrieves the number of colors in the color table.
    ///Params:
    ///    pcCount = Type: <b>UINT*</b> Pointer that receives the number of colors in the color table.
    HRESULT GetColorCount(uint* pcCount);
    ///Fills out the supplied color array with the colors from the internal color table. The color array should be sized
    ///according to the return results from GetColorCount.
    ///Params:
    ///    cCount = Type: <b>UINT</b> The size of the <i>pColors</i> array.
    ///    pColors = Type: <b>WICColor*</b> Pointer that receives the colors of the palette.
    ///    pcActualColors = Type: <b>UINT*</b> The actual size needed to obtain the palette colors.
    HRESULT GetColors(uint cCount, char* pColors, uint* pcActualColors);
    ///Retrieves a value that describes whether the palette is black and white.
    ///Params:
    ///    pfIsBlackWhite = Type: <b>BOOL*</b> A pointer to a variable that receives a boolean value that indicates whether the palette
    ///                     is black and white. <b>TRUE</b> indicates that the palette is black and white; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IsBlackWhite(int* pfIsBlackWhite);
    ///Retrieves a value that describes whether a palette is grayscale.
    ///Params:
    ///    pfIsGrayscale = Type: <b>BOOL*</b> A pointer to a variable that receives a boolean value that indicates whether the palette
    ///                    is grayscale. <b>TRUE</b> indicates that the palette is grayscale; otherwise <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IsGrayscale(int* pfIsGrayscale);
    ///Indicates whether the palette contains an entry that is non-opaque (that is, an entry with an alpha that is less
    ///than 1).
    ///Params:
    ///    pfHasAlpha = Type: <b>BOOL*</b> Pointer that receives <code>TRUE</code> if the palette contains a transparent color;
    ///                 otherwise, <code>FALSE</code>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HasAlpha(int* pfHasAlpha);
}

///Exposes methods that refers to a source from which pixels are retrieved, but cannot be written back to.
@GUID("00000120-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmapSource : IUnknown
{
    ///Retrieves the pixel width and height of the bitmap.
    ///Params:
    ///    puiWidth = Type: <b>UINT*</b> A pointer that receives the pixel width of the bitmap.
    ///    puiHeight = Type: <b>UINT*</b> A pointer that receives the pixel height of the bitmap
    HRESULT GetSize(uint* puiWidth, uint* puiHeight);
    ///Retrieves the pixel format of the bitmap source..
    ///Params:
    ///    pPixelFormat = Type: <b>WICPixelFormatGUID*</b> Receives the pixel format GUID the bitmap is stored in. For a list of
    ///                   available pixel formats, see the Native Pixel Formats topic.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPixelFormat(GUID* pPixelFormat);
    ///Retrieves the sampling rate between pixels and physical world measurements.
    ///Params:
    ///    pDpiX = Type: <b>double*</b> A pointer that receives the x-axis dpi resolution.
    ///    pDpiY = Type: <b>double*</b> A pointer that receives the y-axis dpi resolution.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetResolution(double* pDpiX, double* pDpiY);
    ///Retrieves the color table for indexed pixel formats.
    ///Params:
    ///    pIPalette = Type: <b>IWICPalette*</b> An IWICPalette. A palette can be created using the CreatePalette method.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WINCODEC_ERR_PALETTEUNAVAILABLE</b></dt> </dl>
    ///    </td> <td width="60%"> The palette was unavailable. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The palette was successfully copied. </td> </tr> </table>
    ///    
    HRESULT CopyPalette(IWICPalette pIPalette);
    ///Instructs the object to produce pixels.
    ///Params:
    ///    prc = Type: <b>const WICRect*</b> The rectangle to copy. A <b>NULL</b> value specifies the entire bitmap.
    ///    cbStride = Type: <b>UINT</b> The stride of the bitmap
    ///    cbBufferSize = Type: <b>UINT</b> The size of the buffer.
    ///    pbBuffer = Type: <b>BYTE*</b> A pointer to the buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CopyPixels(const(WICRect)* prc, uint cbStride, uint cbBufferSize, char* pbBuffer);
}

///Represents an IWICBitmapSource that converts the image data from one pixel format to another, handling dithering and
///halftoning to indexed formats, palette translation and alpha thresholding.
@GUID("00000301-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICFormatConverter : IWICBitmapSource
{
    ///Initializes the format converter.
    ///Params:
    ///    pISource = Type: <b>IWICBitmapSource*</b> The input bitmap to convert
    ///    dstFormat = Type: <b>REFWICPixelFormatGUID</b> The destination pixel format GUID.
    ///    dither = Type: <b>WICBitmapDitherType</b> The WICBitmapDitherType used for conversion.
    ///    pIPalette = Type: <b>IWICPalette*</b> The palette to use for conversion.
    ///    alphaThresholdPercent = Type: <b>double</b> The alpha threshold to use for conversion.
    ///    paletteTranslate = Type: <b>WICBitmapPaletteType</b> The palette translation type to use for conversion.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Initialize(IWICBitmapSource pISource, GUID* dstFormat, WICBitmapDitherType dither, 
                       IWICPalette pIPalette, double alphaThresholdPercent, WICBitmapPaletteType paletteTranslate);
    ///Determines if the source pixel format can be converted to the destination pixel format.
    ///Params:
    ///    srcPixelFormat = Type: <b>REFWICPixelFormatGUID</b> The source pixel format.
    ///    dstPixelFormat = Type: <b>REFWICPixelFormatGUID</b> The destionation pixel format.
    ///    pfCanConvert = Type: <b>BOOL*</b> A pointer that receives a value indicating whether the source pixel format can be
    ///                   converted to the destination pixel format.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CanConvert(GUID* srcPixelFormat, GUID* dstPixelFormat, int* pfCanConvert);
}

///Allows a format converter to be initialized with a planar source. You can use QueryInterface to obtain this interface
///from the Windows provided implementation of IWICFormatConverter.
@GUID("BEBEE9CB-83B0-4DCC-8132-B0AAA55EAC96")
interface IWICPlanarFormatConverter : IWICBitmapSource
{
    ///Initializes a format converter with a planar source, and specifies the interleaved output pixel format.
    ///Params:
    ///    ppPlanes = Type: <b>IWICBitmapSource**</b> An array of IWICBitmapSource that represents image planes.
    ///    cPlanes = Type: <b>UINT</b> The number of component planes specified by the planes parameter.
    ///    dstFormat = Type: <b>REFWICPixelFormatGUID </b> The destination interleaved pixel format.
    ///    dither = Type: <b>WICBitmapDitherType</b> The WICBitmapDitherType used for conversion.
    ///    pIPalette = Type: <b>IWICPalette*</b> The palette to use for conversion.
    ///    alphaThresholdPercent = Type: <b>double</b> The alpha threshold to use for conversion.
    ///    paletteTranslate = Type: <b>WICBitmapPaletteType</b> The palette translation type to use for conversion.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Initialize(char* ppPlanes, uint cPlanes, GUID* dstFormat, WICBitmapDitherType dither, 
                       IWICPalette pIPalette, double alphaThresholdPercent, WICBitmapPaletteType paletteTranslate);
    ///Query if the format converter can convert from one format to another.
    ///Params:
    ///    pSrcPixelFormats = An array of WIC pixel formats that represents source image planes.
    ///    cSrcPlanes = The number of source pixel formats specified by the <i>pSrcFormats</i> parameter.
    ///    dstPixelFormat = The destination interleaved pixel format.
    ///    pfCanConvert = True if the conversion is supported.
    ///Returns:
    ///    If the conversion is not supported, this method returns S_OK, but *<i>pfCanConvert</i> is set to FALSE. If
    ///    this method fails, the out parameter <i>pfCanConvert</i> is invalid.
    ///    
    HRESULT CanConvert(char* pSrcPixelFormats, uint cSrcPlanes, GUID* dstPixelFormat, int* pfCanConvert);
}

///Represents a resized version of the input bitmap using a resampling or filtering algorithm.
@GUID("00000302-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmapScaler : IWICBitmapSource
{
    ///Initializes the bitmap scaler with the provided parameters.
    ///Params:
    ///    pISource = Type: <b>IWICBitmapSource*</b> The input bitmap source.
    ///    uiWidth = Type: <b>UINT</b> The destination width.
    ///    uiHeight = Type: <b>UINT</b> The desination height.
    ///    mode = Type: <b>WICBitmapInterpolationMode</b> The WICBitmapInterpolationMode to use when scaling.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Initialize(IWICBitmapSource pISource, uint uiWidth, uint uiHeight, WICBitmapInterpolationMode mode);
}

///Exposes methods that produce a clipped version of the input bitmap for a specified rectangular region of interest.
@GUID("E4FBCF03-223D-4E81-9333-D635556DD1B5")
interface IWICBitmapClipper : IWICBitmapSource
{
    ///Initializes the bitmap clipper with the provided parameters.
    ///Params:
    ///    pISource = Type: <b>IWICBitmapSource*</b> he input bitmap source.
    ///    prc = Type: <b>const WICRect*</b> The rectangle of the bitmap source to clip.
    HRESULT Initialize(IWICBitmapSource pISource, const(WICRect)* prc);
}

///Exposes methods that produce a flipped (horizontal or vertical) and/or rotated (by 90 degree increments) bitmap
///source. The flip is done before the rotation.
@GUID("5009834F-2D6A-41CE-9E1B-17C5AFF7A782")
interface IWICBitmapFlipRotator : IWICBitmapSource
{
    ///Initializes the bitmap flip rotator with the provided parameters.
    ///Params:
    ///    pISource = Type: <b>IWICBitmapSource*</b> The input bitmap source.
    ///    options = Type: <b>WICBitmapTransformOptions</b> The WICBitmapTransformOptions to flip or rotate the image.
    HRESULT Initialize(IWICBitmapSource pISource, WICBitmapTransformOptions options);
}

///Exposes methods that support the Lock method.
@GUID("00000123-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmapLock : IUnknown
{
    ///Retrieves the width and height, in pixels, of the locked rectangle.
    ///Params:
    ///    puiWidth = Type: <b>UINT*</b> A pointer that receives the width of the locked rectangle.
    ///    puiHeight = Type: <b>UINT*</b> A pointer that receives the height of the locked rectangle.
    HRESULT GetSize(uint* puiWidth, uint* puiHeight);
    ///Provides access to the stride value for the memory.
    ///Params:
    ///    pcbStride = Type: <b>UINT*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStride(uint* pcbStride);
    ///Gets the pointer to the top left pixel in the locked rectangle.
    ///Params:
    ///    pcbBufferSize = Type: <b>UINT*</b> A pointer that receives the size of the buffer.
    ///    ppbData = Type: <b>BYTE**</b> A pointer that receives a pointer to the top left pixel in the locked rectangle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDataPointer(uint* pcbBufferSize, char* ppbData);
    ///Gets the pixel format of for the locked area of pixels. This can be used to compute the number of bytes-per-pixel
    ///in the locked area.
    ///Params:
    ///    pPixelFormat = Type: <b>WICPixelFormatGUID*</b> A pointer that receives the pixel format GUID of the locked area.
    HRESULT GetPixelFormat(GUID* pPixelFormat);
}

///Defines methods that add the concept of writeability and static in-memory representations of bitmaps to
///IWICBitmapSource.
@GUID("00000121-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmap : IWICBitmapSource
{
    ///Provides access to a rectangular area of the bitmap.
    ///Params:
    ///    prcLock = Type: <b>const WICRect*</b> The rectangle to be accessed.
    ///    flags = Type: <b>DWORD</b> The access mode you wish to obtain for the lock. This is a bitwise combination of
    ///            WICBitmapLockFlags for read, write, or read and write access. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///            </tr> <tr> <td width="40%"><a id="WICBitmapLockRead"></a><a id="wicbitmaplockread"></a><a
    ///            id="WICBITMAPLOCKREAD"></a><dl> <dt><b>WICBitmapLockRead</b></dt> </dl> </td> <td width="60%"> The read
    ///            access lock. </td> </tr> <tr> <td width="40%"><a id="WICBitmapLockWrite"></a><a
    ///            id="wicbitmaplockwrite"></a><a id="WICBITMAPLOCKWRITE"></a><dl> <dt><b>WICBitmapLockWrite</b></dt> </dl>
    ///            </td> <td width="60%"> The write access lock. </td> </tr> </table>
    ///    ppILock = Type: <b>IWICBitmapLock**</b> A pointer that receives the locked memory location.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Lock(const(WICRect)* prcLock, uint flags, IWICBitmapLock* ppILock);
    ///Provides access for palette modifications.
    ///Params:
    ///    pIPalette = Type: <b>IWICPalette*</b> The palette to use for conversion.
    HRESULT SetPalette(IWICPalette pIPalette);
    ///Changes the physical resolution of the image.
    ///Params:
    ///    dpiX = Type: <b>double</b> The horizontal resolution.
    ///    dpiY = Type: <b>double</b> The vertical resolution.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetResolution(double dpiX, double dpiY);
}

///Exposes methods for color management.
@GUID("3C613A02-34B2-44EA-9A7C-45AEA9C6FD6D")
interface IWICColorContext : IUnknown
{
    ///Initializes the color context from the given file.
    ///Params:
    ///    wzFilename = Type: <b>LPCWSTR</b> The name of the file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializeFromFilename(const(wchar)* wzFilename);
    ///Initializes the color context from a memory block.
    ///Params:
    ///    pbBuffer = Type: <b>const BYTE*</b> The buffer used to initialize the IWICColorContext.
    ///    cbBufferSize = Type: <b>UINT</b> The size of the <i>pbBuffer</i> buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializeFromMemory(char* pbBuffer, uint cbBufferSize);
    ///Initializes the color context using an Exchangeable Image File (EXIF) color space.
    ///Params:
    ///    value = Type: <b>UINT</b> The value of the EXIF color space. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///            <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>1</dt> </dl> </td> <td width="60%"> A sRGB color
    ///            space. </td> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>2</dt> </dl> </td> <td
    ///            width="60%"> An Adobe RGB color space. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializeFromExifColorSpace(uint value);
    ///Retrieves the color context type.
    ///Params:
    ///    pType = Type: <b>WICColorContextType*</b> A pointer that receives the WICColorContextType of the color context.
    HRESULT GetType(WICColorContextType* pType);
    ///Retrieves the color context profile.
    ///Params:
    ///    cbBuffer = Type: <b>UINT</b> The size of the <i>pbBuffer</i> buffer.
    ///    pbBuffer = Type: <b>BYTE*</b> A pointer that receives the color context profile.
    ///    pcbActual = Type: <b>UINT*</b> A pointer that receives the actual buffer size needed to retrieve the entire color context
    ///                profile.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetProfileBytes(uint cbBuffer, char* pbBuffer, uint* pcbActual);
    ///Retrieves the Exchangeable Image File (EXIF) color space color context.
    ///Params:
    ///    pValue = Type: <b>UINT*</b> A pointer that receives the EXIF color space color context. <table> <tr> <th>Value</th>
    ///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>1</dt> </dl> </td> <td
    ///             width="60%"> A sRGB color space. </td> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt>
    ///             <dt>2</dt> </dl> </td> <td width="60%"> An Adobe RGB color space. </td> </tr> <tr> <td width="40%"><a
    ///             id=""></a><dl> <dt><b></b></dt> <dt>3 through 65534</dt> </dl> </td> <td width="60%"> Unused. </td> </tr>
    ///             </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetExifColorSpace(uint* pValue);
}

///Exposes methods that transforms an IWICBitmapSource from one color context to another.
@GUID("B66F034F-D0E2-40AB-B436-6DE39E321A94")
interface IWICColorTransform : IWICBitmapSource
{
    ///Initializes an IWICColorTransform with a IWICBitmapSource and transforms it from one IWICColorContext to another.
    ///Params:
    ///    pIBitmapSource = Type: <b>IWICBitmapSource*</b> The bitmap source used to initialize the color transform.
    ///    pIContextSource = Type: <b>IWICColorContext*</b> The color context source.
    ///    pIContextDest = Type: <b>IWICColorContext*</b> The color context destination.
    ///    pixelFmtDest = Type: <b>REFWICPixelFormatGUID</b> The GUID of the desired pixel format. This parameter is limited to a
    ///                   subset of the native WIC pixel formats, see Remarks for a list.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Initialize(IWICBitmapSource pIBitmapSource, IWICColorContext pIContextSource, 
                       IWICColorContext pIContextDest, GUID* pixelFmtDest);
}

///Exposes methods used for in-place metadata editing. A fast metadata encoder enables you to add and remove metadata to
///an image without having to fully re-encode the image.
@GUID("B84E2C09-78C9-4AC4-8BD3-524AE1663A2F")
interface IWICFastMetadataEncoder : IUnknown
{
    ///Finalizes metadata changes to the image stream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Commit();
    ///Retrieves a metadata query writer for fast metadata encoding.
    ///Params:
    ///    ppIMetadataQueryWriter = Type: <b>IWICMetadataQueryWriter**</b> When this method returns, contains a pointer to the fast metadata
    ///                             encoder's metadata query writer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

///Represents a Windows Imaging Component (WIC) stream for referencing imaging and metadata content.
@GUID("135FF860-22B7-4DDF-B0F6-218F4F299A43")
interface IWICStream : IStream
{
    ///Initializes a stream from another stream. Access rights are inherited from the underlying stream.
    ///Params:
    ///    pIStream = Type: <b>IStream*</b> The initialize stream.
    HRESULT InitializeFromIStream(IStream pIStream);
    ///Initializes a stream from a particular file.
    ///Params:
    ///    wzFileName = Type: <b>LPCWSTR</b> The file used to initialize the stream.
    ///    dwDesiredAccess = Type: <b>DWORD</b> The desired file access mode. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                      width="40%"><a id="GENERIC_READ"></a><a id="generic_read"></a><dl> <dt><b>GENERIC_READ</b></dt> </dl> </td>
    ///                      <td width="60%"> Read access. </td> </tr> <tr> <td width="40%"><a id="GENERIC_WRITE"></a><a
    ///                      id="generic_write"></a><dl> <dt><b>GENERIC_WRITE</b></dt> </dl> </td> <td width="60%"> Write access. </td>
    ///                      </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializeFromFilename(const(wchar)* wzFileName, uint dwDesiredAccess);
    ///Initializes a stream to treat a block of memory as a stream. The stream cannot grow beyond the buffer size.
    ///Params:
    ///    pbBuffer = Type: <b>BYTE*</b> Pointer to the buffer used to initialize the stream.
    ///    cbBufferSize = Type: <b>DWORD</b> The size of buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializeFromMemory(char* pbBuffer, uint cbBufferSize);
    ///Initializes the stream as a substream of another stream.
    ///Params:
    ///    pIStream = Type: <b>IStream*</b> Pointer to the input stream.
    ///    ulOffset = Type: <b>ULARGE_INTEGER</b> The stream offset used to create the new stream.
    ///    ulMaxSize = Type: <b>ULARGE_INTEGER</b> The maximum size of the stream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializeFromIStreamRegion(IStream pIStream, ULARGE_INTEGER ulOffset, ULARGE_INTEGER ulMaxSize);
}

///Exposes methods that provide enumeration services for individual metadata items.
@GUID("DC2BB46D-3F07-481E-8625-220C4AEDBB33")
interface IWICEnumMetadataItem : IUnknown
{
    ///Advanced the current position in the enumeration.
    ///Params:
    ///    celt = Type: <b>ULONG</b> The number of items to be retrieved.
    ///    rgeltSchema = Type: <b>PROPVARIANT*</b> An array of enumerated items. This parameter is optional.
    ///    rgeltId = Type: <b>PROPVARIANT*</b> An array of enumerated items.
    ///    rgeltValue = Type: <b>PROPVARIANT*</b> An array of enumerated items. This parameter is optional.
    ///    pceltFetched = Type: <b>ULONG*</b> The number of items that were retrieved. This value is always less than or equal to the
    ///                   number of items requested.
    HRESULT Next(uint celt, char* rgeltSchema, char* rgeltId, char* rgeltValue, uint* pceltFetched);
    ///Skips to given number of objects.
    ///Params:
    ///    celt = Type: <b>ULONG</b> The number of objects to skip.
    HRESULT Skip(uint celt);
    ///Resets the current position to the beginning of the enumeration.
    HRESULT Reset();
    ///Creates a copy of the current IWICEnumMetadataItem.
    ///Params:
    ///    ppIEnumMetadataItem = Type: <b>IWICEnumMetadataItem**</b> A pointer that receives a pointer to the IWICEnumMetadataItem copy.
    HRESULT Clone(IWICEnumMetadataItem* ppIEnumMetadataItem);
}

///Exposes methods for retrieving metadata blocks and items from a decoder or its image frames using a metadata query
///expression.
@GUID("30989668-E1C9-4597-B395-458EEDB808DF")
interface IWICMetadataQueryReader : IUnknown
{
    ///Gets the metadata query readers container format.
    ///Params:
    ///    pguidContainerFormat = Type: <b>GUID*</b> Pointer that receives the cointainer format GUID.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    ///Retrieves the current path relative to the root metadata block.
    ///Params:
    ///    cchMaxLength = Type: <b>UINT</b> The length of the <i>wzNamespace</i> buffer.
    ///    wzNamespace = Type: <b>WCHAR*</b> Pointer that receives the current namespace location.
    ///    pcchActualLength = Type: <b>UINT*</b> The actual buffer length that was needed to retrieve the current namespace location.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLocation(uint cchMaxLength, char* wzNamespace, uint* pcchActualLength);
    ///Retrieves the metadata block or item identified by a metadata query expression.
    ///Params:
    ///    wzName = Type: <b>LPCWSTR</b> The query expression to the requested metadata block or item.
    ///    pvarValue = Type: <b>PROPVARIANT*</b> When this method returns, contains the metadata block or item requested.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMetadataByName(const(wchar)* wzName, PROPVARIANT* pvarValue);
    ///Gets an enumerator of all metadata items at the current relative location within the metadata hierarchy.
    ///Params:
    ///    ppIEnumString = Type: <b>IEnumString**</b> A pointer to a variable that receives a pointer to the IEnumString interface for
    ///                    the enumerator that contains query strings that can be used in the current IWICMetadataQueryReader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEnumerator(IEnumString* ppIEnumString);
}

///Exposes methods for setting or removing metadata blocks and items to an encoder or its image frames using a metadata
///query expression.
@GUID("A721791A-0DEF-4D06-BD91-2118BF1DB10B")
interface IWICMetadataQueryWriter : IWICMetadataQueryReader
{
    ///Sets a metadata item to a specific location.
    ///Params:
    ///    wzName = Type: <b>LPCWSTR</b> The name of the metadata item.
    ///    pvarValue = Type: <b>const PROPVARIANT*</b> The metadata to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetMetadataByName(const(wchar)* wzName, const(PROPVARIANT)* pvarValue);
    ///Removes a metadata item from a specific location using a metadata query expression.
    ///Params:
    ///    wzName = Type: <b>LPCWSTR</b> The name of the metadata item to remove.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveMetadataByName(const(wchar)* wzName);
}

///Defines methods for setting an encoder's properties such as thumbnails, frames, and palettes.
@GUID("00000103-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmapEncoder : IUnknown
{
    ///Initializes the encoder with an IStream which tells the encoder where to encode the bits.
    ///Params:
    ///    pIStream = Type: <b>IStream*</b> The output stream.
    ///    cacheOption = Type: <b>WICBitmapEncoderCacheOption</b> The WICBitmapEncoderCacheOption used on initialization.
    HRESULT Initialize(IStream pIStream, WICBitmapEncoderCacheOption cacheOption);
    ///Retrieves the encoder's container format.
    ///Params:
    ///    pguidContainerFormat = Type: <b>GUID*</b> A pointer that receives the encoder's container format GUID.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    ///Retrieves an IWICBitmapEncoderInfo for the encoder.
    ///Params:
    ///    ppIEncoderInfo = Type: <b>IWICBitmapEncoderInfo**</b> A pointer that receives a pointer to an IWICBitmapEncoderInfo.
    HRESULT GetEncoderInfo(IWICBitmapEncoderInfo* ppIEncoderInfo);
    ///Sets the IWICColorContext objects for the encoder.
    ///Params:
    ///    cCount = Type: <b>UINT</b> The number of IWICColorContext to set.
    ///    ppIColorContext = Type: <b>IWICColorContext**</b> A pointer an IWICColorContext pointer containing the color contexts to set
    ///                      for the encoder.
    HRESULT SetColorContexts(uint cCount, char* ppIColorContext);
    ///Sets the global palette for the image.
    ///Params:
    ///    pIPalette = Type: <b>IWICPalette*</b> The IWICPalette to use as the global palette.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, or an error value otherwise. Returns
    ///    WINCODEC_ERR_UNSUPPORTEDOPERATION if the feature is not supported by the encoder.
    ///    
    HRESULT SetPalette(IWICPalette pIPalette);
    ///Sets the global thumbnail for the image.
    ///Params:
    ///    pIThumbnail = Type: <b>IWICBitmapSource*</b> The IWICBitmapSource to set as the global thumbnail.
    HRESULT SetThumbnail(IWICBitmapSource pIThumbnail);
    ///Sets the global preview for the image.
    ///Params:
    ///    pIPreview = Type: <b>IWICBitmapSource*</b> The IWICBitmapSource to use as the global preview.
    HRESULT SetPreview(IWICBitmapSource pIPreview);
    ///Creates a new IWICBitmapFrameEncode instance.
    ///Params:
    ///    ppIFrameEncode = Type: <b>IWICBitmapFrameEncode**</b> A pointer that receives a pointer to the new instance of an
    ///                     IWICBitmapFrameEncode.
    ///    ppIEncoderOptions = Type: <b>IPropertyBag2**</b> Optional. Receives the named properties to use for subsequent frame
    ///                        initialization. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateNewFrame(IWICBitmapFrameEncode* ppIFrameEncode, IPropertyBag2* ppIEncoderOptions);
    ///Commits all changes for the image and closes the stream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Commit();
    ///Retrieves a metadata query writer for the encoder.
    ///Params:
    ///    ppIMetadataQueryWriter = Type: <b>IWICMetadataQueryWriter**</b> When this method returns, contains a pointer to the encoder's metadata
    ///                             query writer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

///Represents an encoder's individual image frames.
@GUID("00000105-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmapFrameEncode : IUnknown
{
    ///Initializes the frame encoder using the given properties.
    ///Params:
    ///    pIEncoderOptions = Type: <b>IPropertyBag2*</b> The set of properties to use for IWICBitmapFrameEncode initialization.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Initialize(IPropertyBag2 pIEncoderOptions);
    ///Sets the output image dimensions for the frame.
    ///Params:
    ///    uiWidth = Type: <b>UINT</b> The width of the output image.
    ///    uiHeight = Type: <b>UINT</b> The height of the output image.
    HRESULT SetSize(uint uiWidth, uint uiHeight);
    ///Sets the physical resolution of the output image.
    ///Params:
    ///    dpiX = Type: <b>double</b> The horizontal resolution value.
    ///    dpiY = Type: <b>double</b> The vertical resolution value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetResolution(double dpiX, double dpiY);
    ///Requests that the encoder use the specified pixel format.
    ///Params:
    ///    pPixelFormat = Type: <b>WICPixelFormatGUID*</b> On input, the requested pixel format GUID. On output, the closest pixel
    ///                   format GUID supported by the encoder; this may be different than the requested format. For a list of pixel
    ///                   format GUIDs, see Native Pixel Formats.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINCODEC_ERR_WRONGSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The IWICBitmapFrameEncode::Initialize method was not called. </td> </tr> </table>
    ///    
    HRESULT SetPixelFormat(GUID* pPixelFormat);
    ///Sets a given number IWICColorContext profiles to the frame.
    ///Params:
    ///    cCount = Type: <b>UINT</b> The number of IWICColorContext profiles to set.
    ///    ppIColorContext = Type: <b>IWICColorContext**</b> A pointer to an IWICColorContext pointer containing the color contexts
    ///                      profiles to set to the frame.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetColorContexts(uint cCount, char* ppIColorContext);
    ///Sets the IWICPalette for indexed pixel formats.
    ///Params:
    ///    pIPalette = Type: <b>IWICPalette*</b> The IWICPalette to use for indexed pixel formats. The encoder may change the
    ///                palette to reflect the pixel formats the encoder supports.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetPalette(IWICPalette pIPalette);
    ///Sets the frame thumbnail if supported by the codec.
    ///Params:
    ///    pIThumbnail = Type: <b>IWICBitmapSource*</b> The bitmap source to use as the thumbnail.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, or an error value otherwise. Returns
    ///    WINCODEC_ERR_UNSUPPORTEDOPERATION if the feature is not supported by the encoder.
    ///    
    HRESULT SetThumbnail(IWICBitmapSource pIThumbnail);
    ///Copies scan-line data from a caller-supplied buffer to the IWICBitmapFrameEncode object.
    ///Params:
    ///    lineCount = Type: <b>UINT</b> The number of lines to encode.
    ///    cbStride = Type: <b>UINT</b> The stride of the image pixels.
    ///    cbBufferSize = Type: <b>UINT</b> The size of the pixel buffer.
    ///    pbPixels = Type: <b>BYTE*</b> A pointer to the pixel buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINCODEC_ERR_CODECTOOMANYSCANLINES</b></dt> </dl>
    ///    </td> <td width="60%"> The value of <i>lineCount</i> is larger than the number of scan lines in the image.
    ///    </td> </tr> </table>
    ///    
    HRESULT WritePixels(uint lineCount, uint cbStride, uint cbBufferSize, char* pbPixels);
    ///Encodes a bitmap source.
    ///Params:
    ///    pIBitmapSource = Type: <b>IWICBitmapSource*</b> The bitmap source to encode.
    ///    prc = Type: <b>WICRect*</b> The size rectangle of the bitmap source.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WriteSource(IWICBitmapSource pIBitmapSource, WICRect* prc);
    ///Commits the frame to the image.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Commit();
    ///Gets the metadata query writer for the encoder frame.
    ///Params:
    ///    ppIMetadataQueryWriter = Type: <b>IWICMetadataQueryWriter**</b> When this method returns, contains a pointer to metadata query writer
    ///                             for the encoder frame.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

///Allows planar component image pixels to be written to an encoder. When supported by the encoder, this allows an
///application to encode planar component image data without first converting to an interleaved pixel format. You can
///use QueryInterface to obtain this interface from the Windows provided implementation of IWICBitmapFrameEncode for the
///JPEG encoder.
@GUID("F928B7B8-2221-40C1-B72E-7E82F1974D1A")
interface IWICPlanarBitmapFrameEncode : IUnknown
{
    ///Writes lines from the source planes to the encoded format.
    ///Params:
    ///    lineCount = Type: <b>UINT</b> The number of lines to encode. See the Remarks section for WIC Jpeg specific line count
    ///                restrictions.
    ///    pPlanes = Type: <b>WICBitmapPlane*</b> Specifies the source buffers for each component plane encoded.
    ///    cPlanes = Type: <b>UINT</b> The number of component planes specified by the <i>pPlanes</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the planes and source rectangle do not meet the requirements, this method fails with
    ///    <b>WINCODEC_ERR_IMAGESIZEOUTOFRANGE</b>. If the IWICBitmapSource format does not meet the encoder
    ///    requirements, this method fails with <b>WINCODEC_ERR_UNSUPPORTEDPIXELFORMAT</b>.
    ///    
    HRESULT WritePixels(uint lineCount, char* pPlanes, uint cPlanes);
    ///Writes lines from the source planes to the encoded format.
    ///Params:
    ///    ppPlanes = Type: <b>IWICBitmapSource**</b> Specifies an array of IWICBitmapSource that represent image planes.
    ///    cPlanes = Type: <b>UINT</b> The number of component planes specified by the planes parameter.
    ///    prcSource = Type: <b>WICRect*</b> The source rectangle of pixels to encode from the IWICBitmapSource planes. Null
    ///                indicates the entire source. The source rect width must match the width set through SetSize. Repeated
    ///                <b>WriteSource</b> calls can be made as long as the total accumulated source rect height is the same as set
    ///                through <b>SetSize</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the planes and source rectangle do not meet the requirements, this method fails with
    ///    <b>WINCODEC_ERR_IMAGESIZEOUTOFRANGE</b>. If the IWICBitmapSource format does not meet the encoder
    ///    requirements, this method fails with <b>WINCODEC_ERR_UNSUPPORTEDPIXELFORMAT</b>.
    ///    
    HRESULT WriteSource(char* ppPlanes, uint cPlanes, WICRect* prcSource);
}

///Encodes ID2D1Image interfaces to an IWICBitmapEncoder. The input images can be larger than the maximum device texture
///size.
@GUID("04C75BF8-3CE1-473B-ACC5-3CC4F5E94999")
interface IWICImageEncoder : IUnknown
{
    ///Encodes the image to the frame given by the IWICBitmapFrameEncode.
    ///Params:
    ///    pImage = Type: <b>ID2D1Image*</b> The Direct2D image that will be encoded.
    ///    pFrameEncode = Type: <b>IWICBitmapFrameEncode*</b> The frame encoder to which the image is written.
    ///    pImageParameters = Type: <b>const WICImageParameters*</b> Additional parameters to control encoding.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WriteFrame(ID2D1Image pImage, IWICBitmapFrameEncode pFrameEncode, 
                       const(WICImageParameters)* pImageParameters);
    ///Encodes the image as a thumbnail to the frame given by the IWICBitmapFrameEncode.
    ///Params:
    ///    pImage = Type: <b>ID2D1Image*</b> The Direct2D image that will be encoded.
    ///    pFrameEncode = Type: <b>IWICBitmapFrameEncode*</b> The frame encoder on which the thumbnail is set.
    ///    pImageParameters = Type: <b>const WICImageParameters*</b> Additional parameters to control encoding.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WriteFrameThumbnail(ID2D1Image pImage, IWICBitmapFrameEncode pFrameEncode, 
                                const(WICImageParameters)* pImageParameters);
    ///Encodes the given image as the thumbnail to the given WIC bitmap encoder.
    ///Params:
    ///    pImage = Type: <b>ID2D1Image*</b> The Direct2D image that will be encoded.
    ///    pEncoder = Type: <b>IWICBitmapEncoder*</b> The encoder on which the thumbnail is set.
    ///    pImageParameters = Type: <b>const WICImageParameters*</b> Additional parameters to control encoding.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WriteThumbnail(ID2D1Image pImage, IWICBitmapEncoder pEncoder, 
                           const(WICImageParameters)* pImageParameters);
}

///Exposes methods that represent a decoder. The interface provides access to the decoder's properties such as global
///thumbnails (if supported), frames, and palette.
@GUID("9EDDE9E7-8DEE-47EA-99DF-E6FAF2ED44BF")
interface IWICBitmapDecoder : IUnknown
{
    ///Retrieves the capabilities of the decoder based on the specified stream.
    ///Params:
    ///    pIStream = Type: <b>IStream*</b> The stream to retrieve the decoder capabilities from.
    ///    pdwCapability = Type: <b>DWORD*</b> The WICBitmapDecoderCapabilities of the decoder.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT QueryCapability(IStream pIStream, uint* pdwCapability);
    ///Initializes the decoder with the provided stream.
    ///Params:
    ///    pIStream = Type: <b>IStream*</b> The stream to use for initialization. The stream contains the encoded pixels which are
    ///               decoded each time the CopyPixels method on the IWICBitmapFrameDecode interface (see GetFrame) is invoked.
    ///    cacheOptions = Type: <b>WICDecodeOptions</b> The WICDecodeOptions to use for initialization.
    HRESULT Initialize(IStream pIStream, WICDecodeOptions cacheOptions);
    ///Retrieves the image's container format.
    ///Params:
    ///    pguidContainerFormat = Type: <b>GUID*</b> A pointer that receives the image's container format GUID.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    ///Retrieves an IWICBitmapDecoderInfo for the image.
    ///Params:
    ///    ppIDecoderInfo = Type: <b>IWICBitmapDecoderInfo**</b> A pointer that receives a pointer to an IWICBitmapDecoderInfo.
    HRESULT GetDecoderInfo(IWICBitmapDecoderInfo* ppIDecoderInfo);
    ///Copies the decoder's IWICPalette .
    ///Params:
    ///    pIPalette = Type: <b>IWICPalette*</b> AnIWICPalette to which the decoder's global palette is to be copied. Use
    ///                CreatePalette to create the destination palette before calling <b>CopyPalette</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CopyPalette(IWICPalette pIPalette);
    ///Retrieves the metadata query reader from the decoder.
    ///Params:
    ///    ppIMetadataQueryReader = Type: <b>IWICMetadataQueryReader**</b> Receives a pointer to the decoder's IWICMetadataQueryReader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMetadataQueryReader(IWICMetadataQueryReader* ppIMetadataQueryReader);
    ///Retrieves a preview image, if supported.
    ///Params:
    ///    ppIBitmapSource = Type: <b>IWICBitmapSource**</b> Receives a pointer to the preview bitmap if supported.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPreview(IWICBitmapSource* ppIBitmapSource);
    ///Retrieves the IWICColorContext objects of the image.
    ///Params:
    ///    cCount = Type: <b>UINT</b> The number of color contexts to retrieve. This value must be the size of, or smaller than,
    ///             the size available to <i>ppIColorContexts</i>.
    ///    ppIColorContexts = Type: <b>IWICColorContext**</b> A pointer that receives a pointer to the IWICColorContext.
    ///    pcActualCount = Type: <b>UINT*</b> A pointer that receives the number of color contexts contained in the image.
    HRESULT GetColorContexts(uint cCount, char* ppIColorContexts, uint* pcActualCount);
    ///Retrieves a bitmap thumbnail of the image, if one exists
    ///Params:
    ///    ppIThumbnail = Type: <b>IWICBitmapSource**</b> Receives a pointer to the IWICBitmapSource of the thumbnail.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetThumbnail(IWICBitmapSource* ppIThumbnail);
    ///Retrieves the total number of frames in the image.
    ///Params:
    ///    pCount = Type: <b>UINT*</b> A pointer that receives the total number of frames in the image.
    HRESULT GetFrameCount(uint* pCount);
    ///Retrieves the specified frame of the image.
    ///Params:
    ///    index = Type: <b>UINT</b> The particular frame to retrieve.
    ///    ppIBitmapFrame = Type: <b>IWICBitmapFrameDecode**</b> A pointer that receives a pointer to the IWICBitmapFrameDecode.
    HRESULT GetFrame(uint index, IWICBitmapFrameDecode* ppIBitmapFrame);
}

///Exposes methods for offloading certain operations to the underlying IWICBitmapSource implementation.
@GUID("3B16811B-6A43-4EC9-B713-3D5A0C13B940")
interface IWICBitmapSourceTransform : IUnknown
{
    ///Copies pixel data using the supplied input parameters.
    ///Params:
    ///    prc = Type: <b>const WICRect*</b> The rectangle of pixels to copy.
    ///    uiWidth = Type: <b>UINT</b> The width to scale the source bitmap. This parameter must equal the value obtainable
    ///              through IWICBitmapSourceTransform::GetClosestSize.
    ///    uiHeight = Type: <b>UINT</b> The height to scale the source bitmap. This parameter must equal the value obtainable
    ///               through IWICBitmapSourceTransform::GetClosestSize.
    ///    pguidDstFormat = Type: <b>WICPixelFormatGUID*</b> The GUID of desired pixel format in which the pixels should be returned.
    ///                     This GUID must be a format obtained through an GetClosestPixelFormat call.
    ///    dstTransform = Type: <b>WICBitmapTransformOptions</b> The desired rotation or flip to perform prior to the pixel copy. The
    ///                   transform must be an operation supported by an DoesSupportTransform call. If a <i>dstTransform</i> is
    ///                   specified, <i>nStride</i> is the <i>transformed stride</i> and is based on the <i>pguidDstFormat</i> pixel
    ///                   format, not the original source's pixel format.
    ///    nStride = Type: <b>UINT</b> The stride of the destination buffer.
    ///    cbBufferSize = Type: <b>UINT</b> The size of the destination buffer.
    ///    pbBuffer = Type: <b>BYTE*</b> The output buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CopyPixels(const(WICRect)* prc, uint uiWidth, uint uiHeight, GUID* pguidDstFormat, 
                       WICBitmapTransformOptions dstTransform, uint nStride, uint cbBufferSize, char* pbBuffer);
    ///Returns the closest dimensions the implementation can natively scale to given the desired dimensions.
    ///Params:
    ///    puiWidth = Type: <b>UINT*</b> The desired width. A pointer that receives the closest supported width.
    ///    puiHeight = Type: <b>UINT*</b> The desired height. A pointer that receives the closest supported height.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetClosestSize(uint* puiWidth, uint* puiHeight);
    ///Retrieves the closest pixel format to which the implementation of IWICBitmapSourceTransform can natively copy
    ///pixels, given a desired format.
    ///Params:
    ///    pguidDstFormat = Type: <b>WICPixelFormatGUID*</b> A pointer that receives the GUID of the pixel format that is the closest
    ///                     supported pixel format of the desired format.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetClosestPixelFormat(GUID* pguidDstFormat);
    ///Determines whether a specific transform option is supported natively by the implementation of the
    ///IWICBitmapSourceTransform interface.
    ///Params:
    ///    dstTransform = Type: <b>WICBitmapTransformOptions</b> The WICBitmapTransformOptions to check if they are supported.
    ///    pfIsSupported = Type: <b>BOOL*</b> A pointer that receives a value specifying whether the transform option is supported.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DoesSupportTransform(WICBitmapTransformOptions dstTransform, int* pfIsSupported);
}

///Provides access to planar Y’CbCr pixel formats where pixel components are stored in separate component planes. This
///interface also allows access to other codec optimizations for flip/rotate, scale, and format conversion to other
///Y’CbCr planar formats; this is similar to the pre-existing IWICBitmapSourceTransform interface. QueryInterface can
///be used to obtain this interface from the Windows provided implementations of IWICBitmapFrameDecode for the JPEG
///decoder, IWICBitmapScaler, IWICBitmapFlipRotator, and IWICColorTransform.
@GUID("3AFF9CCE-BE95-4303-B927-E7D16FF4A613")
interface IWICPlanarBitmapSourceTransform : IUnknown
{
    ///Use this method to determine if a desired planar output is supported and allow the caller to choose an optimized
    ///code path if it is. Otherwise, callers should fall back to IWICBitmapSourceTransform or IWICBitmapSource and
    ///retrieve interleaved pixels. The following transforms can be checked:<ul> <li> Determine if the flip/rotate
    ///option specified via WICBitmapTransformOptions is supported.</li> <li>Determine if the requested planar pixel
    ///format configuration is supported.</li> <li>Determine the closest dimensions the implementation can natively
    ///scale to given the desired dimensions. </li> </ul> When a transform is supported, this method returns the
    ///description of the resulting planes in the <i>pPlaneDescriptions</i> parameter.
    ///Params:
    ///    puiWidth = Type: <b>UINT*</b> On input, the desired width. On output, the closest supported width to the desired width;
    ///               this is the same size or larger than the desired width.
    ///    puiHeight = Type: <b>UINT*</b> On input, the desired height. On output, the closest supported height to the desired
    ///                height; this is the same size or larger than the desired width.
    ///    dstTransform = Type: <b>WICBitmapTransformOptions</b> The desired rotation or flip operation. Multiple
    ///                   WICBitmapTransformOptions can be combined in this flag parameter, see <b>WICBitmapTransformOptions</b>.
    ///    dstPlanarOptions = Type: <b>WICPlanarOptions</b> Used to specify additional configuration options for the transform. See
    ///                       WICPlanarOptions for more detail. WIC JPEG Decoder: WICPlanarOptionsPreserveSubsampling can be specified to
    ///                       retain the subsampling ratios when downscaling. By default, the JPEG decoder attempts to preserve quality by
    ///                       downscaling only the Y plane in some cases, changing the image to 4:4:4 chroma subsampling.
    ///    pguidDstFormats = Type: <b>const WICPixelFormatGUID*</b> The requested pixel formats of the respective planes.
    ///    pPlaneDescriptions = Type: <b>WICBitmapPlaneDescription*</b> When *<i>pfIsSupported</i> == TRUE, the array of plane descriptions
    ///                         contains the size and format of each of the planes. WIC JPEG Decoder: The Cb and Cr planes can be a different
    ///                         size from the values returned by <i>puiWidth</i> and <i>puiHeight</i> due to chroma subsampling.
    ///    cPlanes = Type: <b>UINT</b> The number of component planes requested.
    ///    pfIsSupported = Type: <b>BOOL*</b> Set to TRUE if the requested transforms are natively supported.
    ///Returns:
    ///    Type: <b>HRESULT</b> Check the value of <i>pfIsSupported</i> to determine if the transform is supported via
    ///    IWICPlanarBitmapSourceTransform::CopyPixels. If this method fails, the output parameters for width, height,
    ///    and plane descriptions are zero initialized. Other return values indicate failure.
    ///    
    HRESULT DoesSupportTransform(uint* puiWidth, uint* puiHeight, WICBitmapTransformOptions dstTransform, 
                                 WICPlanarOptions dstPlanarOptions, char* pguidDstFormats, char* pPlaneDescriptions, 
                                 uint cPlanes, int* pfIsSupported);
    ///Copies pixels into the destination planes. Configured by the supplied input parameters. If a <i>dstTransform</i>,
    ///scale, or format conversion is specified, <i>cbStride</i> is the transformed stride and is based on the
    ///destination pixel format of the <i>pDstPlanes</i> parameter, not the original source's pixel format.
    ///Params:
    ///    prcSource = Type: <b>const WICRect*</b> The source rectangle of pixels to copy.
    ///    uiWidth = Type: <b>UINT</b> The width to scale the source bitmap. This parameter must be equal to a value obtainable
    ///              through IWICPlanarBitmapSourceTransform:: DoesSupportTransform.
    ///    uiHeight = Type: <b>UINT</b> The height to scale the source bitmap. This parameter must be equal to a value obtainable
    ///               through IWICPlanarBitmapSourceTransform:: DoesSupportTransform.
    ///    dstTransform = Type: <b>WICBitmapTransformOptions</b> The desired rotation or flip to perform prior to the pixel copy. A
    ///                   rotate can be combined with a flip horizontal or a flip vertical, see WICBitmapTransformOptions.
    ///    dstPlanarOptions = Type: <b>const WICPlanarOptions</b> Used to specify additional configuration options for the transform. See
    ///                       WICPlanarOptions for more detail. WIC JPEG Decoder: WICPlanarOptionsPreserveSubsampling can be specified to
    ///                       retain the subsampling ratios when downscaling. By default, the JPEG decoder attempts to preserve quality by
    ///                       downscaling only the Y plane in some cases, changing the image to 4:4:4 chroma subsampling.
    ///    pDstPlanes = Type: <b>WICBitmapPlane</b> Specifies the pixel format and output buffer for each component plane. The number
    ///                 of planes and pixel format of each plane must match values obtainable through
    ///                 IWICPlanarBitmapSourceTransform::DoesSupportTransform.
    ///    cPlanes = Type: <b>UINT</b> The number of component planes specified by the <i>pDstPlanes</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the specified scale, flip/rotate, and planar format configuration is not supported
    ///    this method fails with <b>WINCODEC_ERR_INVALIDPARAMETER</b>. You can check if a transform is supported by
    ///    calling IWICPlanarBitmapSourceTransform::DoesSupportTransform.
    ///    
    HRESULT CopyPixels(const(WICRect)* prcSource, uint uiWidth, uint uiHeight, 
                       WICBitmapTransformOptions dstTransform, WICPlanarOptions dstPlanarOptions, char* pDstPlanes, 
                       uint cPlanes);
}

///Defines methods for decoding individual image frames of an encoded file.
@GUID("3B16811B-6A43-4EC9-A813-3D930C13B940")
interface IWICBitmapFrameDecode : IWICBitmapSource
{
    ///Retrieves a metadata query reader for the frame.
    ///Params:
    ///    ppIMetadataQueryReader = Type: <b>IWICMetadataQueryReader**</b> When this method returns, contains a pointer to the frame's metadata
    ///                             query reader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMetadataQueryReader(IWICMetadataQueryReader* ppIMetadataQueryReader);
    ///Retrieves the IWICColorContext associated with the image frame.
    ///Params:
    ///    cCount = Type: <b>UINT</b> The number of color contexts to retrieve. This value must be the size of, or smaller than,
    ///             the size available to <i>ppIColorContexts</i>.
    ///    ppIColorContexts = Type: <b>IWICColorContext**</b> A pointer that receives a pointer to the IWICColorContext objects.
    ///    pcActualCount = Type: <b>UINT*</b> A pointer that receives the number of color contexts contained in the image frame.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetColorContexts(uint cCount, char* ppIColorContexts, uint* pcActualCount);
    ///Retrieves a small preview of the frame, if supported by the codec.
    ///Params:
    ///    ppIThumbnail = Type: <b>IWICBitmapSource**</b> A pointer that receives a pointer to the IWICBitmapSource of the thumbnail.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetThumbnail(IWICBitmapSource* ppIThumbnail);
}

///Exposes methods for obtaining information about and controlling progressive decoding.
@GUID("DAAC296F-7AA5-4DBF-8D15-225C5976F891")
interface IWICProgressiveLevelControl : IUnknown
{
    ///Gets the number of levels of progressive decoding supported by the CODEC.
    ///Params:
    ///    pcLevels = Type: <b>UINT*</b> Indicates the number of levels supported by the CODEC.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLevelCount(uint* pcLevels);
    ///Gets the decoder's current progressive level.
    ///Params:
    ///    pnLevel = Type: <b>UINT*</b> Indicates the current level specified.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentLevel(uint* pnLevel);
    ///Specifies the level to retrieve on the next call to CopyPixels.
    ///Params:
    ///    nLevel = Type: <b>UINT</b> Specifies which level to return next. If greater than the total number of levels supported,
    ///             an error will be returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetCurrentLevel(uint nLevel);
}

///<b>IWICProgressCallback</b> interface is documented only for compliance; its use is not recommended and may be
///altered or unavailable in the future. Instead, and use RegisterProgressNotification.
@GUID("4776F9CD-9517-45FA-BF24-E89C5EC5C60C")
interface IWICProgressCallback : IUnknown
{
    ///<b>Notify</b> method is documented only for compliance; its use is not recommended and may be altered or
    ///unavailable in the future. Instead, and use RegisterProgressNotification.
    ///Params:
    ///    uFrameNum = Type: <b>ULONG</b> The current frame number.
    ///    operation = Type: <b>WICProgressOperation</b> The operation on which progress is being reported.
    ///    dblProgress = Type: <b>double</b> The progress value ranging from is 0.0 to 1.0. 0.0 indicates the beginning of the
    ///                  operation. 1.0 indicates the end of the operation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Notify(uint uFrameNum, WICProgressOperation operation, double dblProgress);
}

///Exposes methods used for progress notification for encoders and decoders.
@GUID("64C1024E-C3CF-4462-8078-88C2B11C46D9")
interface IWICBitmapCodecProgressNotification : IUnknown
{
    ///Registers a progress notification callback function.
    ///Params:
    ///    pfnProgressNotification = Type: <b>PFNProgressNotification</b> A function pointer to the application defined progress notification
    ///                              callback function. See ProgressNotificationCallback for the callback signature.
    ///    pvData = Type: <b>LPVOID</b> A pointer to component data for the callback method.
    ///    dwProgressFlags = Type: <b>DWORD</b> The WICProgressOperation and WICProgressNotification flags to use for progress
    ///                      notification.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterProgressNotification(PFNProgressNotification pfnProgressNotification, void* pvData, 
                                         uint dwProgressFlags);
}

///Exposes methods that provide component information.
@GUID("23BC3F0A-698B-4357-886B-F24D50671334")
interface IWICComponentInfo : IUnknown
{
    ///Retrieves the component's WICComponentType.
    ///Params:
    ///    pType = Type: <b>WICComponentType*</b> A pointer that receives the WICComponentType.
    HRESULT GetComponentType(WICComponentType* pType);
    ///Retrieves the component's class identifier (CLSID)
    ///Params:
    ///    pclsid = Type: <b>CLSID*</b> A pointer that receives the component's CLSID.
    HRESULT GetCLSID(GUID* pclsid);
    ///Retrieves the signing status of the component.
    ///Params:
    ///    pStatus = Type: <b>DWORD*</b> A pointer that receives the WICComponentSigning status of the component.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSigningStatus(uint* pStatus);
    ///Retrieves the name of component's author.
    ///Params:
    ///    cchAuthor = Type: <b>UINT</b> The size of the <i>wzAuthor</i> buffer.
    ///    wzAuthor = Type: <b>WCHAR*</b> A pointer that receives the name of the component's author. The locale of the string
    ///               depends on the value that the codec wrote to the registry at install time. For built-in components, these
    ///               strings are always in English.
    ///    pcchActual = Type: <b>UINT*</b> A pointer that receives the actual length of the component's authors name. The author name
    ///                 is optional; if an author name is not specified by the component, the length returned is 0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAuthor(uint cchAuthor, char* wzAuthor, uint* pcchActual);
    ///Retrieves the vendor GUID.
    ///Params:
    ///    pguidVendor = Type: <b>GUID*</b> A pointer that receives the component's vendor GUID.
    HRESULT GetVendorGUID(GUID* pguidVendor);
    ///Retrieves the component's version.
    ///Params:
    ///    cchVersion = Type: <b>UINT</b> The size of the <i>wzVersion</i> buffer.
    ///    wzVersion = Type: <b>WCHAR*</b> A pointer that receives a culture invariant string of the component's version.
    ///    pcchActual = Type: <b>UINT*</b> A pointer that receives the actual length of the component's version. The version is
    ///                 optional; if a value is not specified by the component, the length returned is 0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetVersion(uint cchVersion, char* wzVersion, uint* pcchActual);
    ///Retrieves the component's specification version.
    ///Params:
    ///    cchSpecVersion = Type: <b>UINT</b> The size of the <i>wzSpecVersion</i> buffer.
    ///    wzSpecVersion = Type: <b>WCHAR*</b> When this method returns, contain a culture invarient string of the component's
    ///                    specification version. The version form is NN.NN.NN.NN.
    ///    pcchActual = Type: <b>UINT*</b> A pointer that receives the actual length of the component's specification version. The
    ///                 specification version is optional; if a value is not specified by the component, the length returned is 0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSpecVersion(uint cchSpecVersion, char* wzSpecVersion, uint* pcchActual);
    ///Retrieves the component's friendly name, which is a human-readable display name for the component.
    ///Params:
    ///    cchFriendlyName = Type: <b>UINT</b> The size of the <i>wzFriendlyName</i> buffer.
    ///    wzFriendlyName = Type: <b>WCHAR*</b> A pointer that receives the friendly name of the component. The locale of the string
    ///                     depends on the value that the codec wrote to the registry at install time. For built-in components, these
    ///                     strings are always in English.
    ///    pcchActual = Type: <b>UINT*</b> A pointer that receives the actual length of the component's friendly name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFriendlyName(uint cchFriendlyName, char* wzFriendlyName, uint* pcchActual);
}

///Exposes methods that provide information about a pixel format converter.
@GUID("9F34FB65-13F4-4F15-BC57-3726B5E53D9F")
interface IWICFormatConverterInfo : IWICComponentInfo
{
    ///Retrieves a list of GUIDs that signify which pixel formats the converter supports.
    ///Params:
    ///    cFormats = Type: <b>UINT</b> The size of the <i>pPixelFormatGUIDs</i> array.
    ///    pPixelFormatGUIDs = Type: <b>WICPixelFormatGUID*</b> Pointer to a GUID array that receives the pixel formats the converter
    ///                        supports.
    ///    pcActual = Type: <b>UINT*</b> The actual array size needed to retrieve all pixel formats supported by the converter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPixelFormats(uint cFormats, char* pPixelFormatGUIDs, uint* pcActual);
    ///Creates a new IWICFormatConverter instance.
    ///Params:
    ///    ppIConverter = Type: <b>IWICFormatConverter**</b> A pointer that receives a new IWICFormatConverter instance.
    HRESULT CreateInstance(IWICFormatConverter* ppIConverter);
}

///Exposes methods that provide information about a particular codec.
@GUID("E87A44C4-B76E-4C47-8B09-298EB12A2714")
interface IWICBitmapCodecInfo : IWICComponentInfo
{
    ///Retrieves the container GUID associated with the codec.
    ///Params:
    ///    pguidContainerFormat = Type: <b>GUID*</b> Receives the container GUID.
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    ///Retrieves the pixel formats the codec supports.
    ///Params:
    ///    cFormats = Type: <b>UINT</b> The size of the <i>pguidPixelFormats</i> array. Use <code>0</code> on first call to
    ///               determine the needed array size.
    ///    pguidPixelFormats = Type: <b>GUID*</b> Receives the supported pixel formats. Use <code>NULL</code> on first call to determine
    ///                        needed array size.
    ///    pcActual = Type: <b>UINT*</b> The array size needed to retrieve all supported pixel formats.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPixelFormats(uint cFormats, char* pguidPixelFormats, uint* pcActual);
    ///Retrieves the color manangement version number the codec supports.
    ///Params:
    ///    cchColorManagementVersion = Type: <b>UINT</b> The size of the version buffer. Use <code>0</code> on first call to determine needed buffer
    ///                                size.
    ///    wzColorManagementVersion = Type: <b>WCHAR*</b> Receives the color management version number. Use <code>NULL</code> on first call to
    ///                               determine needed buffer size.
    ///    pcchActual = Type: <b>UINT*</b> The actual buffer size needed to retrieve the full color management version number.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetColorManagementVersion(uint cchColorManagementVersion, char* wzColorManagementVersion, 
                                      uint* pcchActual);
    ///Retrieves the name of the device manufacture associated with the codec.
    ///Params:
    ///    cchDeviceManufacturer = Type: <b>UINT</b> The size of the device manufacture's name. Use <code>0</code> on first call to determine
    ///                            needed buffer size.
    ///    wzDeviceManufacturer = Type: <b>WCHAR*</b> Receives the device manufacture's name. Use <code>NULL</code> on first call to determine
    ///                           needed buffer size.
    ///    pcchActual = Type: <b>UINT*</b> The actual buffer size needed to retrieve the device manufacture's name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDeviceManufacturer(uint cchDeviceManufacturer, char* wzDeviceManufacturer, uint* pcchActual);
    ///Retrieves a comma delimited list of device models associated with the codec.
    ///Params:
    ///    cchDeviceModels = Type: <b>UINT</b> The size of the device models buffer. Use <code>0</code> on first call to determine needed
    ///                      buffer size.
    ///    wzDeviceModels = Type: <b>WCHAR*</b> Receives a comma delimited list of device model names associated with the codec. Use
    ///                     <code>NULL</code> on first call to determine needed buffer size.
    ///    pcchActual = Type: <b>UINT*</b> The actual buffer size needed to retrieve all of the device model names.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDeviceModels(uint cchDeviceModels, char* wzDeviceModels, uint* pcchActual);
    ///Retrieves a comma delimited sequence of mime types associated with the codec.
    ///Params:
    ///    cchMimeTypes = Type: <b>UINT</b> The size of the mime types buffer. Use <code>0</code> on first call to determine needed
    ///                   buffer size.
    ///    wzMimeTypes = Type: <b>WCHAR*</b> Receives the mime types associated with the codec. Use <code>NULL</code> on first call to
    ///                  determine needed buffer size.
    ///    pcchActual = Type: <b>UINT*</b> The actual buffer size needed to retrieve all mime types associated with the codec.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMimeTypes(uint cchMimeTypes, char* wzMimeTypes, uint* pcchActual);
    ///Retrieves a comma delimited list of the file name extensions associated with the codec.
    ///Params:
    ///    cchFileExtensions = Type: <b>UINT</b> The size of the file name extension buffer. Use <code>0</code> on first call to determine
    ///                        needed buffer size.
    ///    wzFileExtensions = Type: <b>WCHAR*</b> Receives a comma delimited list of file name extensions associated with the codec. Use
    ///                       <code>NULL</code> on first call to determine needed buffer size.
    ///    pcchActual = Type: <b>UINT*</b> The actual buffer size needed to retrieve all file name extensions associated with the
    ///                 codec.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFileExtensions(uint cchFileExtensions, char* wzFileExtensions, uint* pcchActual);
    ///Retrieves a value indicating whether the codec supports animation.
    ///Params:
    ///    pfSupportAnimation = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the codec supports images with timing information; otherwise,
    ///                         <b>FALSE</b>.
    HRESULT DoesSupportAnimation(int* pfSupportAnimation);
    ///Retrieves a value indicating whether the codec supports chromakeys.
    ///Params:
    ///    pfSupportChromakey = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the codec supports chromakeys; otherwise, <b>FALSE</b>.
    HRESULT DoesSupportChromakey(int* pfSupportChromakey);
    ///Retrieves a value indicating whether the codec supports lossless formats.
    ///Params:
    ///    pfSupportLossless = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the codec supports lossless formats; otherwise, <b>FALSE</b>.
    HRESULT DoesSupportLossless(int* pfSupportLossless);
    ///Retrieves a value indicating whether the codec supports multi frame images.
    ///Params:
    ///    pfSupportMultiframe = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the codec supports multi frame images; otherwise, <b>FALSE</b>.
    HRESULT DoesSupportMultiframe(int* pfSupportMultiframe);
    ///Retrieves a value indicating whether the given mime type matches the mime type of the codec.
    ///Params:
    ///    wzMimeType = Type: <b>LPCWSTR</b> The mime type to compare.
    ///    pfMatches = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the mime types match; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td
    ///    width="60%"> The codec does not implement this method. </td> </tr> </table>
    ///    
    HRESULT MatchesMimeType(const(wchar)* wzMimeType, int* pfMatches);
}

///Exposes methods that provide information about an encoder.
@GUID("94C9B4EE-A09F-4F92-8A1E-4A9BCE7E76FB")
interface IWICBitmapEncoderInfo : IWICBitmapCodecInfo
{
    ///Creates a new IWICBitmapEncoder instance.
    ///Params:
    ///    ppIBitmapEncoder = Type: <b>IWICBitmapEncoder**</b> A pointer that receives a pointer to a new IWICBitmapEncoder instance.
    HRESULT CreateInstance(IWICBitmapEncoder* ppIBitmapEncoder);
}

///Exposes methods that provide information about a decoder.
@GUID("D8CD007F-D08F-4191-9BFC-236EA7F0E4B5")
interface IWICBitmapDecoderInfo : IWICBitmapCodecInfo
{
    ///Retrieves the file pattern signatures supported by the decoder.
    ///Params:
    ///    cbSizePatterns = Type: <b>UINT</b> The array size of the <i>pPatterns</i> array.
    ///    pPatterns = Type: <b>WICBitmapPattern*</b> Receives a list of WICBitmapPattern objects supported by the decoder.
    ///    pcPatterns = Type: <b>UINT*</b> Receives the number of patterns the decoder supports.
    ///    pcbPatternsActual = Type: <b>UINT*</b> Receives the actual buffer size needed to retrieve all pattern signatures supported by the
    ///                        decoder.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPatterns(uint cbSizePatterns, char* pPatterns, uint* pcPatterns, uint* pcbPatternsActual);
    ///Retrieves a value that indicates whether the codec recognizes the pattern within a specified stream.
    ///Params:
    ///    pIStream = Type: <b>IStream*</b> The stream to pattern match within.
    ///    pfMatches = Type: <b>BOOL*</b> A pointer that receives <b>TRUE</b> if the patterns match; otherwise, <b>FALSE</b>.
    HRESULT MatchesPattern(IStream pIStream, int* pfMatches);
    ///Creates a new IWICBitmapDecoder instance.
    ///Params:
    ///    ppIBitmapDecoder = Type: <b>IWICBitmapDecoder**</b> A pointer that receives a pointer to a new instance of the
    ///                       IWICBitmapDecoder.
    HRESULT CreateInstance(IWICBitmapDecoder* ppIBitmapDecoder);
}

///Exposes methods that provide information about a pixel format.
@GUID("E8EDA601-3D48-431A-AB44-69059BE88BBE")
interface IWICPixelFormatInfo : IWICComponentInfo
{
    ///Gets the pixel format GUID.
    ///Params:
    ///    pFormat = Type: <b>GUID*</b> Pointer that receives the pixel format GUID.
    HRESULT GetFormatGUID(GUID* pFormat);
    ///Gets the pixel format's IWICColorContext.
    ///Params:
    ///    ppIColorContext = Type: <b>IWICColorContext**</b> Pointer that receives the pixel format's color context.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetColorContext(IWICColorContext* ppIColorContext);
    ///Gets the bits per pixel (BPP) of the pixel format.
    ///Params:
    ///    puiBitsPerPixel = Type: <b>UINT*</b> Pointer that receives the BPP of the pixel format.
    HRESULT GetBitsPerPixel(uint* puiBitsPerPixel);
    ///Gets the number of channels the pixel format contains.
    ///Params:
    ///    puiChannelCount = Type: <b>UINT*</b> Pointer that receives the channel count.
    HRESULT GetChannelCount(uint* puiChannelCount);
    ///Gets the pixel format's channel mask.
    ///Params:
    ///    uiChannelIndex = Type: <b>UINT</b> The index to the channel mask to retrieve.
    ///    cbMaskBuffer = Type: <b>UINT</b> The size of the <i>pbMaskBuffer</i> buffer.
    ///    pbMaskBuffer = Type: <b>BYTE*</b> Pointer to the mask buffer.
    ///    pcbActual = Type: <b>UINT*</b> The actual buffer size needed to obtain the channel mask.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetChannelMask(uint uiChannelIndex, uint cbMaskBuffer, char* pbMaskBuffer, uint* pcbActual);
}

///Extends IWICPixelFormatInfo by providing additional information about a pixel format.
@GUID("A9DB33A2-AF5F-43C7-B679-74F5984B5AA4")
interface IWICPixelFormatInfo2 : IWICPixelFormatInfo
{
    ///Returns whether the format supports transparent pixels.
    ///Params:
    ///    pfSupportsTransparency = Type: <b>BOOL*</b> Returns <b>TRUE</b> if the pixel format supports transparency; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SupportsTransparency(int* pfSupportsTransparency);
    ///Retrieves the WICPixelFormatNumericRepresentation of the pixel format.
    ///Params:
    ///    pNumericRepresentation = Type: <b>WICPixelFormatNumericRepresentation*</b> The address of a WICPixelFormatNumericRepresentation
    ///                             variable that you've defined. On successful completion, the function sets your variable to the
    ///                             **WICPixelFormatNumericRepresentation** of the pixel format.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetNumericRepresentation(WICPixelFormatNumericRepresentation* pNumericRepresentation);
}

///Exposes methods used to create components for the Windows Imaging Component (WIC) such as decoders, encoders and
///pixel format converters.
@GUID("EC5EC8A9-C395-4314-9C77-54D7A935FF70")
interface IWICImagingFactory : IUnknown
{
    ///Creates a new instance of the IWICBitmapDecoder class based on the given file.
    ///Params:
    ///    wzFilename = Type: <b>LPCWSTR</b> A pointer to a null-terminated string that specifies the name of an object to create or
    ///                 open.
    ///    pguidVendor = Type: <b>const GUID*</b> The GUID for the preferred decoder vendor. Use <b>NULL</b> if no preferred vendor.
    ///    dwDesiredAccess = Type: <b>DWORD</b> The access to the object, which can be read, write, or both. <table> <tr> <th>Value</th>
    ///                      <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>GENERIC_READ</dt> </dl> </td> <td width="60%"> Read
    ///                      access. </td> </tr> <tr> <td width="40%"> <dl> <dt>GENERIC_WRITE</dt> </dl> </td> <td width="60%"> Write
    ///                      access. </td> </tr> </table> For more information, see Generic Access Rights.
    ///    metadataOptions = Type: <b>WICDecodeOptions</b> The WICDecodeOptions to use when creating the decoder.
    ///    ppIDecoder = Type: <b>IWICBitmapDecoder**</b> A pointer that receives a pointer to the new IWICBitmapDecoder.
    HRESULT CreateDecoderFromFilename(const(wchar)* wzFilename, const(GUID)* pguidVendor, uint dwDesiredAccess, 
                                      WICDecodeOptions metadataOptions, IWICBitmapDecoder* ppIDecoder);
    ///Creates a new instance of the IWICBitmapDecoder class based on the given IStream.
    ///Params:
    ///    pIStream = Type: <b>IStream*</b> The stream to create the decoder from.
    ///    pguidVendor = Type: <b>const GUID*</b> The GUID for the preferred decoder vendor. Use <b>NULL</b> if no preferred vendor.
    ///    metadataOptions = Type: <b>WICDecodeOptions</b> The WICDecodeOptions to use when creating the decoder.
    ///    ppIDecoder = Type: <b>IWICBitmapDecoder**</b> A pointer that receives a pointer to a new IWICBitmapDecoder.
    HRESULT CreateDecoderFromStream(IStream pIStream, const(GUID)* pguidVendor, WICDecodeOptions metadataOptions, 
                                    IWICBitmapDecoder* ppIDecoder);
    ///Creates a new instance of the IWICBitmapDecoder based on the given file handle.
    ///Params:
    ///    hFile = Type: <b>ULONG_PTR</b> The file handle to create the decoder from.
    ///    pguidVendor = Type: <b>const GUID*</b> The GUID for the preferred decoder vendor. Use <b>NULL</b> if no preferred vendor.
    ///    metadataOptions = Type: <b>WICDecodeOptions</b> The WICDecodeOptions to use when creating the decoder.
    ///    ppIDecoder = Type: <b>IWICBitmapDecoder**</b> A pointer that receives a pointer to a new IWICBitmapDecoder.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateDecoderFromFileHandle(size_t hFile, const(GUID)* pguidVendor, WICDecodeOptions metadataOptions, 
                                        IWICBitmapDecoder* ppIDecoder);
    ///Creates a new instance of the IWICComponentInfo class for the given component class identifier (CLSID).
    ///Params:
    ///    clsidComponent = Type: <b>REFCLSID</b> The CLSID for the desired component.
    ///    ppIInfo = Type: <b>IWICComponentInfo**</b> A pointer that receives a pointer to a new IWICComponentInfo.
    HRESULT CreateComponentInfo(const(GUID)* clsidComponent, IWICComponentInfo* ppIInfo);
    ///Creates a new instance of IWICBitmapDecoder.
    ///Params:
    ///    guidContainerFormat = Type: <b>REFGUID</b> The GUID for the desired container format. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///                          </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>GUID_ContainerFormatBmp</dt> </dl> </td>
    ///                          <td width="60%"> The BMP container format GUID. </td> </tr> <tr> <td width="40%"><a id=""></a><dl>
    ///                          <dt><b></b></dt> <dt>GUID_ContainerFormatPng</dt> </dl> </td> <td width="60%"> The PNG container format GUID.
    ///                          </td> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>GUID_ContainerFormatIco</dt> </dl>
    ///                          </td> <td width="60%"> The ICO container format GUID. </td> </tr> <tr> <td width="40%"><a id=""></a><dl>
    ///                          <dt><b></b></dt> <dt>GUID_ContainerFormatJpeg</dt> </dl> </td> <td width="60%"> The JPEG container format
    ///                          GUID. </td> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>GUID_ContainerFormatTiff</dt>
    ///                          </dl> </td> <td width="60%"> The TIFF container format GUID. </td> </tr> <tr> <td width="40%"><a
    ///                          id=""></a><dl> <dt><b></b></dt> <dt>GUID_ContainerFormatGif</dt> </dl> </td> <td width="60%"> The GIF
    ///                          container format GUID. </td> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt>
    ///                          <dt>GUID_ContainerFormatWmp</dt> </dl> </td> <td width="60%"> The HD Photo container format GUID. </td> </tr>
    ///                          </table>
    ///    pguidVendor = Type: <b>const GUID*</b> The GUID for the preferred encoder vendor. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>NULL</dt> </dl> </td> <td
    ///                  width="60%"> No preferred codec vendor. </td> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt>
    ///                  <dt>GUID_VendorMicrosoft</dt> </dl> </td> <td width="60%"> Prefer to use Microsoft encoder. </td> </tr> <tr>
    ///                  <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>GUID_VendorMicrosoftBuiltIn</dt> </dl> </td> <td
    ///                  width="60%"> Prefer to use the native Microsoft encoder. </td> </tr> </table>
    ///    ppIDecoder = Type: <b>IWICBitmapDecoder**</b> A pointer that receives a pointer to a new IWICBitmapDecoder. You must
    ///                 initialize this <b>IWICBitmapDecoder</b> on a stream using the Initialize method later.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateDecoder(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                          IWICBitmapDecoder* ppIDecoder);
    ///Creates a new instance of the IWICBitmapEncoder class.
    ///Params:
    ///    guidContainerFormat = Type: <b>REFGUID</b> The GUID for the desired container format. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///                          </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>GUID_ContainerFormatBmp</dt> </dl> </td>
    ///                          <td width="60%"> The BMP container format GUID. </td> </tr> <tr> <td width="40%"><a id=""></a><dl>
    ///                          <dt><b></b></dt> <dt>GUID_ContainerFormatPng</dt> </dl> </td> <td width="60%"> The PNG container format GUID.
    ///                          </td> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>GUID_ContainerFormatIco</dt> </dl>
    ///                          </td> <td width="60%"> The ICO container format GUID. </td> </tr> <tr> <td width="40%"><a id=""></a><dl>
    ///                          <dt><b></b></dt> <dt>GUID_ContainerFormatJpeg</dt> </dl> </td> <td width="60%"> The JPEG container format
    ///                          GUID. </td> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>GUID_ContainerFormatTiff</dt>
    ///                          </dl> </td> <td width="60%"> The TIFF container format GUID. </td> </tr> <tr> <td width="40%"><a
    ///                          id=""></a><dl> <dt><b></b></dt> <dt>GUID_ContainerFormatGif</dt> </dl> </td> <td width="60%"> The GIF
    ///                          container format GUID. </td> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt>
    ///                          <dt>GUID_ContainerFormatWmp</dt> </dl> </td> <td width="60%"> The HD Photo container format GUID. </td> </tr>
    ///                          </table>
    ///    pguidVendor = Type: <b>const GUID*</b> The GUID for the preferred encoder vendor. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>NULL</dt> </dl> </td> <td
    ///                  width="60%"> No preferred codec vendor. </td> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt>
    ///                  <dt>GUID_VendorMicrosoft</dt> </dl> </td> <td width="60%"> Prefer to use Microsoft encoder. </td> </tr> <tr>
    ///                  <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>GUID_VendorMicrosoftBuiltIn</dt> </dl> </td> <td
    ///                  width="60%"> Prefer to use the native Microsoft encoder. </td> </tr> </table>
    ///    ppIEncoder = Type: <b>IWICBitmapEncoder**</b> A pointer that receives a pointer to a new IWICBitmapEncoder.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateEncoder(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                          IWICBitmapEncoder* ppIEncoder);
    ///Creates a new instance of the IWICPalette class.
    ///Params:
    ///    ppIPalette = Type: <b>IWICPalette**</b> A pointer that receives a pointer to a new IWICPalette.
    HRESULT CreatePalette(IWICPalette* ppIPalette);
    ///Creates a new instance of the IWICFormatConverter class.
    ///Params:
    ///    ppIFormatConverter = Type: <b>IWICFormatConverter**</b> A pointer that receives a pointer to a new IWICFormatConverter.
    HRESULT CreateFormatConverter(IWICFormatConverter* ppIFormatConverter);
    ///Creates a new instance of an IWICBitmapScaler.
    ///Params:
    ///    ppIBitmapScaler = Type: <b>IWICBitmapScaler**</b> A pointer that receives a pointer to a new IWICBitmapScaler.
    HRESULT CreateBitmapScaler(IWICBitmapScaler* ppIBitmapScaler);
    ///Creates a new instance of an IWICBitmapClipper object.
    ///Params:
    ///    ppIBitmapClipper = Type: <b>IWICBitmapClipper**</b> A pointer that receives a pointer to a new IWICBitmapClipper.
    HRESULT CreateBitmapClipper(IWICBitmapClipper* ppIBitmapClipper);
    ///Creates a new instance of an IWICBitmapFlipRotator object.
    ///Params:
    ///    ppIBitmapFlipRotator = Type: <b>IWICBitmapFlipRotator**</b> A pointer that receives a pointer to a new IWICBitmapFlipRotator.
    HRESULT CreateBitmapFlipRotator(IWICBitmapFlipRotator* ppIBitmapFlipRotator);
    ///Creates a new instance of the IWICStream class.
    ///Params:
    ///    ppIWICStream = Type: <b>IWICStream**</b> A pointer that receives a pointer to a new IWICStream.
    HRESULT CreateStream(IWICStream* ppIWICStream);
    ///Creates a new instance of the IWICColorContext class.
    ///Params:
    ///    ppIWICColorContext = Type: <b>IWICColorContext**</b> A pointer that receives a pointer to a new IWICColorContext.
    HRESULT CreateColorContext(IWICColorContext* ppIWICColorContext);
    ///Creates a new instance of the IWICColorTransform class.
    ///Params:
    ///    ppIWICColorTransform = Type: <b>IWICColorTransform**</b> A pointer that receives a pointer to a new IWICColorTransform.
    HRESULT CreateColorTransformer(IWICColorTransform* ppIWICColorTransform);
    ///Creates an IWICBitmap object.
    ///Params:
    ///    uiWidth = Type: <b>UINT</b> The width of the new bitmap .
    ///    uiHeight = Type: <b>UINT</b> The height of the new bitmap.
    ///    pixelFormat = Type: <b>REFWICPixelFormatGUID</b> The pixel format of the new bitmap.
    ///    option = Type: <b>WICBitmapCreateCacheOption</b> The cache creation options of the new bitmap. This can be one of the
    ///             values in the WICBitmapCreateCacheOption enumeration. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///             <td width="40%"><a id="WICBitmapCacheOnDemand"></a><a id="wicbitmapcacheondemand"></a><a
    ///             id="WICBITMAPCACHEONDEMAND"></a><dl> <dt><b>WICBitmapCacheOnDemand</b></dt> </dl> </td> <td width="60%">
    ///             Allocates system memory for the bitmap at initialization. </td> </tr> <tr> <td width="40%"><a
    ///             id="WICBitmapCacheOnLoad"></a><a id="wicbitmapcacheonload"></a><a id="WICBITMAPCACHEONLOAD"></a><dl>
    ///             <dt><b>WICBitmapCacheOnLoad</b></dt> </dl> </td> <td width="60%"> Allocates system memory for the bitmap when
    ///             the bitmap is first used. </td> </tr> <tr> <td width="40%"><a id="WICBitmapNoCache"></a><a
    ///             id="wicbitmapnocache"></a><a id="WICBITMAPNOCACHE"></a><dl> <dt><b>WICBitmapNoCache</b></dt> </dl> </td> <td
    ///             width="60%"> This option is not valid for this method and should not be used. </td> </tr> </table>
    ///    ppIBitmap = Type: <b>IWICBitmap**</b> A pointer that receives a pointer to the new bitmap.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateBitmap(uint uiWidth, uint uiHeight, GUID* pixelFormat, WICBitmapCreateCacheOption option, 
                         IWICBitmap* ppIBitmap);
    ///Creates a IWICBitmap from a IWICBitmapSource.
    ///Params:
    ///    pIBitmapSource = Type: <b>IWICBitmapSource*</b> The IWICBitmapSource to create the bitmap from.
    ///    option = Type: <b>WICBitmapCreateCacheOption</b> The cache options of the new bitmap. This can be one of the values in
    ///             the WICBitmapCreateCacheOption enumeration. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///             width="40%"><a id="WICBitmapNoCache"></a><a id="wicbitmapnocache"></a><a id="WICBITMAPNOCACHE"></a><dl>
    ///             <dt><b>WICBitmapNoCache</b></dt> </dl> </td> <td width="60%"> Do not create a system memory copy. Share the
    ///             bitmap with the source. </td> </tr> <tr> <td width="40%"><a id="WICBitmapCacheOnDemand"></a><a
    ///             id="wicbitmapcacheondemand"></a><a id="WICBITMAPCACHEONDEMAND"></a><dl>
    ///             <dt><b>WICBitmapCacheOnDemand</b></dt> </dl> </td> <td width="60%"> Create a system memory copy when the
    ///             bitmap is first used. </td> </tr> <tr> <td width="40%"><a id="WICBitmapCacheOnLoad"></a><a
    ///             id="wicbitmapcacheonload"></a><a id="WICBITMAPCACHEONLOAD"></a><dl> <dt><b>WICBitmapCacheOnLoad</b></dt>
    ///             </dl> </td> <td width="60%"> Create a system memory copy when this method is called. </td> </tr> </table>
    ///    ppIBitmap = Type: <b>IWICBitmap**</b> A pointer that receives a pointer to the new bitmap.
    HRESULT CreateBitmapFromSource(IWICBitmapSource pIBitmapSource, WICBitmapCreateCacheOption option, 
                                   IWICBitmap* ppIBitmap);
    ///Creates an IWICBitmap from a specified rectangle of an IWICBitmapSource.
    ///Params:
    ///    pIBitmapSource = Type: <b>IWICBitmapSource*</b> The IWICBitmapSource to create the bitmap from.
    ///    x = Type: <b>UINT</b> The horizontal coordinate of the upper-left corner of the rectangle.
    ///    y = Type: <b>UINT</b> The vertical coordinate of the upper-left corner of the rectangle.
    ///    width = Type: <b>UINT</b> The width of the rectangle and the new bitmap.
    ///    height = Type: <b>UINT</b> The height of the rectangle and the new bitmap.
    ///    ppIBitmap = Type: <b>IWICBitmap**</b> A pointer that receives a pointer to the new bitmap.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateBitmapFromSourceRect(IWICBitmapSource pIBitmapSource, uint x, uint y, uint width, uint height, 
                                       IWICBitmap* ppIBitmap);
    ///Creates an IWICBitmap from a memory block.
    ///Params:
    ///    uiWidth = Type: <b>UINT</b> The width of the new bitmap.
    ///    uiHeight = Type: <b>UINT</b> The height of the new bitmap.
    ///    pixelFormat = Type: <b>REFWICPixelFormatGUID</b> The pixel format of the new bitmap. For valid pixel formats, see Native
    ///                  Pixel Formats.
    ///    cbStride = Type: <b>UINT</b> The number of bytes between successive scanlines in <i>pbBuffer</i>.
    ///    cbBufferSize = Type: <b>UINT</b> The size of <i>pbBuffer</i>.
    ///    pbBuffer = Type: <b>BYTE*</b> The buffer used to create the bitmap.
    ///    ppIBitmap = Type: <b>IWICBitmap**</b> A pointer that receives a pointer to the new bitmap.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateBitmapFromMemory(uint uiWidth, uint uiHeight, GUID* pixelFormat, uint cbStride, 
                                   uint cbBufferSize, char* pbBuffer, IWICBitmap* ppIBitmap);
    ///Creates an IWICBitmap from a bitmap handle.
    ///Params:
    ///    hBitmap = Type: <b>HBITMAP</b> A bitmap handle to create the bitmap from.
    ///    hPalette = Type: <b>HPALETTE</b> A palette handle used to create the bitmap.
    ///    options = Type: <b>WICBitmapAlphaChannelOption</b> The alpha channel options to create the bitmap.
    ///    ppIBitmap = Type: <b>IWICBitmap**</b> A pointer that receives a pointer to the new bitmap.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateBitmapFromHBITMAP(HBITMAP hBitmap, HPALETTE hPalette, WICBitmapAlphaChannelOption options, 
                                    IWICBitmap* ppIBitmap);
    ///Creates an IWICBitmap from an icon handle.
    ///Params:
    ///    hIcon = Type: <b>HICON</b> The icon handle to create the new bitmap from.
    ///    ppIBitmap = Type: <b>IWICBitmap**</b> A pointer that receives a pointer to the new bitmap.
    HRESULT CreateBitmapFromHICON(HICON hIcon, IWICBitmap* ppIBitmap);
    ///Creates an IEnumUnknown object of the specified component types.
    ///Params:
    ///    componentTypes = Type: <b>DWORD</b> The types of WICComponentType to enumerate.
    ///    options = Type: <b>DWORD</b> The WICComponentEnumerateOptions used to enumerate the given component types.
    ///    ppIEnumUnknown = Type: <b>IEnumUnknown**</b> A pointer that receives a pointer to a new component enumerator.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateComponentEnumerator(uint componentTypes, uint options, IEnumUnknown* ppIEnumUnknown);
    ///Creates a new instance of the fast metadata encoder based on the given IWICBitmapDecoder.
    ///Params:
    ///    pIDecoder = Type: <b>IWICBitmapDecoder*</b> The decoder to create the fast metadata encoder from.
    ///    ppIFastEncoder = Type: <b>IWICFastMetadataEncoder**</b> When this method returns, contains a pointer to the new
    ///                     IWICFastMetadataEncoder.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFastMetadataEncoderFromDecoder(IWICBitmapDecoder pIDecoder, 
                                                 IWICFastMetadataEncoder* ppIFastEncoder);
    ///Creates a new instance of the fast metadata encoder based on the given image frame.
    ///Params:
    ///    pIFrameDecoder = Type: <b>IWICBitmapFrameDecode*</b> The IWICBitmapFrameDecode to create the IWICFastMetadataEncoder from.
    ///    ppIFastEncoder = Type: <b>IWICFastMetadataEncoder**</b> When this method returns, contains a pointer to a new fast metadata
    ///                     encoder.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFastMetadataEncoderFromFrameDecode(IWICBitmapFrameDecode pIFrameDecoder, 
                                                     IWICFastMetadataEncoder* ppIFastEncoder);
    ///Creates a new instance of a query writer.
    ///Params:
    ///    guidMetadataFormat = Type: <b>REFGUID</b> The GUID for the desired metadata format.
    ///    pguidVendor = Type: <b>const GUID*</b> The GUID for the preferred metadata writer vendor. Use <b>NULL</b> if no preferred
    ///                  vendor.
    ///    ppIQueryWriter = Type: <b>IWICMetadataQueryWriter**</b> When this method returns, contains a pointer to a new
    ///                     IWICMetadataQueryWriter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateQueryWriter(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, 
                              IWICMetadataQueryWriter* ppIQueryWriter);
    ///Creates a new instance of a query writer based on the given query reader. The query writer will be pre-populated
    ///with metadata from the query reader.
    ///Params:
    ///    pIQueryReader = Type: <b>IWICMetadataQueryReader*</b> The IWICMetadataQueryReader to create the IWICMetadataQueryWriter from.
    ///    pguidVendor = Type: <b>const GUID*</b> The GUID for the preferred metadata writer vendor. Use <b>NULL</b> if no preferred
    ///                  vendor.
    ///    ppIQueryWriter = Type: <b>IWICMetadataQueryWriter**</b> When this method returns, contains a pointer to a new metadata writer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateQueryWriterFromReader(IWICMetadataQueryReader pIQueryReader, const(GUID)* pguidVendor, 
                                        IWICMetadataQueryWriter* ppIQueryWriter);
}

///An extension of the WIC factory interface that includes the ability to create an IWICImageEncoder. This interface
///uses a Direct2D device and an input image to encode to a destination IWICBitmapEncoder.
@GUID("7B816B45-1996-4476-B132-DE9E247C8AF0")
interface IWICImagingFactory2 : IWICImagingFactory
{
    ///Creates a new image encoder object.
    ///Params:
    ///    pD2DDevice = The ID2D1Device object on which the corresponding image encoder is created.
    ///    ppWICImageEncoder = A pointer to a variable that receives a pointer to the IWICImageEncoder interface for the encoder object that
    ///                        you can use to encode Direct2D images.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateImageEncoder(ID2D1Device pD2DDevice, IWICImageEncoder* ppWICImageEncoder);
}

///Exposes a callback method for raw image change nofications.
@GUID("95C75A6E-3E8C-4EC2-85A8-AEBCC551E59B")
interface IWICDevelopRawNotificationCallback : IUnknown
{
    ///An application-defined callback method used for raw image parameter change notifications.
    ///Params:
    ///    NotificationMask = Type: <b>UINT</b> A set of IWICDevelopRawNotificationCallback Constants parameter notification flags.
    HRESULT Notify(uint NotificationMask);
}

///Exposes methods that provide access to the capabilites of a raw codec format.
@GUID("FBEC5E44-F7BE-4B65-B7F8-C0C81FEF026D")
interface IWICDevelopRaw : IWICBitmapFrameDecode
{
    ///Retrieves information about which capabilities are supported for a raw image.
    ///Params:
    ///    pInfo = Type: <b>WICRawCapabilitiesInfo*</b> A pointer that receives WICRawCapabilitiesInfo that provides the
    ///            capabilities supported by the raw image.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT QueryRawCapabilitiesInfo(WICRawCapabilitiesInfo* pInfo);
    ///Sets the desired WICRawParameterSet option.
    ///Params:
    ///    ParameterSet = Type: <b>WICRawParameterSet</b> The desired WICRawParameterSet option.
    HRESULT LoadParameterSet(WICRawParameterSet ParameterSet);
    ///Gets the current set of parameters.
    ///Params:
    ///    ppCurrentParameterSet = Type: <b>IPropertyBag2**</b> A pointer that receives a pointer to the current set of parameters.
    HRESULT GetCurrentParameterSet(IPropertyBag2* ppCurrentParameterSet);
    ///Sets the exposure compensation stop value.
    ///Params:
    ///    ev = Type: <b>double</b> The exposure compensation value. The value range for exposure compensation is -5.0
    ///         through +5.0, which equates to 10 full stops.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetExposureCompensation(double ev);
    ///Gets the exposure compensation stop value of the raw image.
    ///Params:
    ///    pEV = Type: <b>double*</b> A pointer that receives the exposure compensation stop value. The default is the
    ///          "as-shot" setting.
    HRESULT GetExposureCompensation(double* pEV);
    ///Sets the white point RGB values.
    ///Params:
    ///    Red = Type: <b>UINT</b> The red white point value.
    ///    Green = Type: <b>UINT</b> The green white point value.
    ///    Blue = Type: <b>UINT</b> The blue white point value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetWhitePointRGB(uint Red, uint Green, uint Blue);
    ///Gets the white point RGB values.
    ///Params:
    ///    pRed = Type: <b>UINT*</b> A pointer that receives the red white point value.
    ///    pGreen = Type: <b>UINT*</b> A pointer that receives the green white point value.
    ///    pBlue = Type: <b>UINT*</b> A pointer that receives the blue white point value.
    HRESULT GetWhitePointRGB(uint* pRed, uint* pGreen, uint* pBlue);
    ///Sets the named white point of the raw file.
    ///Params:
    ///    WhitePoint = Type: <b>WICNamedWhitePoint</b> A bitwise combination of the enumeration values.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetNamedWhitePoint(WICNamedWhitePoint WhitePoint);
    ///Gets the named white point of the raw image.
    ///Params:
    ///    pWhitePoint = Type: <b>WICNamedWhitePoint*</b> A pointer that receives the bitwise combination of the enumeration values.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetNamedWhitePoint(WICNamedWhitePoint* pWhitePoint);
    ///Sets the white point Kelvin value.
    ///Params:
    ///    WhitePointKelvin = Type: <b>UINT</b> The white point Kelvin value. Acceptable Kelvin values are 1,500 through 30,000.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetWhitePointKelvin(uint WhitePointKelvin);
    ///Gets the white point Kelvin temperature of the raw image.
    ///Params:
    ///    pWhitePointKelvin = Type: <b>UINT*</b> A pointer that receives the white point Kelvin temperature of the raw image. The default
    ///                        is the "as-shot" setting value.
    HRESULT GetWhitePointKelvin(uint* pWhitePointKelvin);
    ///Gets the information about the current Kelvin range of the raw image.
    ///Params:
    ///    pMinKelvinTemp = Type: <b>UINT*</b> A pointer that receives the minimum Kelvin temperature.
    ///    pMaxKelvinTemp = Type: <b>UINT*</b> A pointer that receives the maximum Kelvin temperature.
    ///    pKelvinTempStepValue = Type: <b>UINT*</b> A pointer that receives the Kelvin step value.
    HRESULT GetKelvinRangeInfo(uint* pMinKelvinTemp, uint* pMaxKelvinTemp, uint* pKelvinTempStepValue);
    ///Sets the contrast value of the raw image.
    ///Params:
    ///    Contrast = Type: <b>double</b> The contrast value of the raw image. The default value is the "as-shot" setting. The
    ///               value range for contrast is 0.0 through 1.0. The 0.0 lower limit represents no contrast applied to the image,
    ///               while the 1.0 upper limit represents the highest amount of contrast that can be applied.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetContrast(double Contrast);
    ///Gets the contrast value of the raw image.
    ///Params:
    ///    pContrast = Type: <b>double*</b> A pointer that receives the contrast value of the raw image. The default value is the
    ///                "as-shot" setting. The value range for contrast is 0.0 through 1.0. The 0.0 lower limit represents no
    ///                contrast applied to the image, while the 1.0 upper limit represents the highest amount of contrast that can
    ///                be applied.
    HRESULT GetContrast(double* pContrast);
    ///Sets the desired gamma value.
    ///Params:
    ///    Gamma = Type: <b>double</b> The desired gamma value.
    HRESULT SetGamma(double Gamma);
    ///Gets the current gamma setting of the raw image.
    ///Params:
    ///    pGamma = Type: <b>double*</b> A pointer that receives the current gamma setting.
    HRESULT GetGamma(double* pGamma);
    ///Sets the sharpness value of the raw image.
    ///Params:
    ///    Sharpness = Type: <b>double</b> The sharpness value of the raw image. The default value is the "as-shot" setting. The
    ///                value range for sharpness is 0.0 through 1.0. The 0.0 lower limit represents no sharpening applied to the
    ///                image, while the 1.0 upper limit represents the highest amount of sharpness that can be applied.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSharpness(double Sharpness);
    ///Gets the sharpness value of the raw image.
    ///Params:
    ///    pSharpness = Type: <b>double*</b> A pointer that receives the sharpness value of the raw image. The default value is the
    ///                 "as-shot" setting. The value range for sharpness is 0.0 through 1.0. The 0.0 lower limit represents no
    ///                 sharpening applied to the image, while the 1.0 upper limit represents the highest amount of sharpness that
    ///                 can be applied.
    HRESULT GetSharpness(double* pSharpness);
    ///Sets the saturation value of the raw image.
    ///Params:
    ///    Saturation = Type: <b>double</b> The saturation value of the raw image. The value range for saturation is 0.0 through 1.0.
    ///                 A value of 0.0 represents an image with a fully de-saturated image, while a value of 1.0 represents the
    ///                 highest amount of saturation that can be applied.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSaturation(double Saturation);
    ///Gets the saturation value of the raw image.
    ///Params:
    ///    pSaturation = Type: <b>double*</b> A pointer that receives the saturation value of the raw image. The default value is the
    ///                  "as-shot" setting. The value range for saturation is 0.0 through 1.0. A value of 0.0 represents an image with
    ///                  a fully de-saturated image, while a value of 1.0 represents the highest amount of saturation that can be
    ///                  applied.
    HRESULT GetSaturation(double* pSaturation);
    ///Sets the tint value of the raw image.
    ///Params:
    ///    Tint = Type: <b>double</b> The tint value of the raw image. The default value is the "as-shot" setting if it exists
    ///           or 0.0. The value range for sharpness is -1.0 through +1.0. The -1.0 lower limit represents a full green bias
    ///           to the image, while the 1.0 upper limit represents a full magenta bias.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetTint(double Tint);
    ///Gets the tint value of the raw image.
    ///Params:
    ///    pTint = Type: <b>double*</b> A pointer that receives the tint value of the raw image. The default value is the
    ///            "as-shot" setting if it exists or 0.0. The value range for sharpness is -1.0 through +1.0. The -1.0 lower
    ///            limit represents a full green bias to the image, while the 1.0 upper limit represents a full magenta bias.
    HRESULT GetTint(double* pTint);
    ///Sets the noise reduction value of the raw image.
    ///Params:
    ///    NoiseReduction = Type: <b>double</b> The noise reduction value of the raw image. The default value is the "as-shot" setting if
    ///                     it exists or 0.0. The value range for noise reduction is 0.0 through 1.0. The 0.0 lower limit represents no
    ///                     noise reduction applied to the image, while the 1.0 upper limit represents highest noise reduction amount
    ///                     that can be applied.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetNoiseReduction(double NoiseReduction);
    ///Gets the noise reduction value of the raw image.
    ///Params:
    ///    pNoiseReduction = Type: <b>double*</b> A pointer that receives the noise reduction value of the raw image. The default value is
    ///                      the "as-shot" setting if it exists or 0.0. The value range for noise reduction is 0.0 through 1.0. The 0.0
    ///                      lower limit represents no noise reduction applied to the image, while the 1.0 upper limit represents full
    ///                      highest noise reduction amount that can be applied.
    HRESULT GetNoiseReduction(double* pNoiseReduction);
    ///Sets the destination color context.
    ///Params:
    ///    pColorContext = Type: <b>const IWICColorContext*</b> The destination color context.
    HRESULT SetDestinationColorContext(IWICColorContext pColorContext);
    ///Sets the tone curve for the raw image.
    ///Params:
    ///    cbToneCurveSize = Type: <b>UINT</b> The size of the <i>pToneCurve</i> structure.
    ///    pToneCurve = Type: <b>const WICRawToneCurve*</b> The desired tone curve.
    HRESULT SetToneCurve(uint cbToneCurveSize, char* pToneCurve);
    ///Gets the tone curve of the raw image.
    ///Params:
    ///    cbToneCurveBufferSize = Type: <b>UINT</b> The size of the <i>pToneCurve</i> buffer.
    ///    pToneCurve = Type: <b>WICRawToneCurve*</b> A pointer that receives the WICRawToneCurve of the raw image.
    ///    pcbActualToneCurveBufferSize = Type: <b>UINT*</b> A pointer that receives the size needed to obtain the tone curve structure.
    HRESULT GetToneCurve(uint cbToneCurveBufferSize, char* pToneCurve, uint* pcbActualToneCurveBufferSize);
    ///Sets the desired rotation angle.
    ///Params:
    ///    Rotation = Type: <b>double</b> The desired rotation angle.
    HRESULT SetRotation(double Rotation);
    ///Gets the current rotation angle.
    ///Params:
    ///    pRotation = Type: <b>double*</b> A pointer that receives the current rotation angle.
    HRESULT GetRotation(double* pRotation);
    ///Sets the current WICRawRenderMode.
    ///Params:
    ///    RenderMode = Type: <b>WICRawRenderMode</b> The render mode to use.
    HRESULT SetRenderMode(WICRawRenderMode RenderMode);
    ///Gets the current WICRawRenderMode.
    ///Params:
    ///    pRenderMode = Type: <b>WICRawRenderMode*</b> A pointer that receives the current WICRawRenderMode.
    HRESULT GetRenderMode(WICRawRenderMode* pRenderMode);
    ///Sets the notification callback method.
    ///Params:
    ///    pCallback = Type: <b>IWICDevelopRawNotificationCallback*</b> Pointer to the notification callback method.
    HRESULT SetNotificationCallback(IWICDevelopRawNotificationCallback pCallback);
}

///Provides information and functionality specific to the DDS image format.
@GUID("409CD537-8532-40CB-9774-E2FEB2DF4E9C")
interface IWICDdsDecoder : IUnknown
{
    ///Gets DDS-specific data.
    ///Params:
    ///    pParameters = Type: <b>WICDdsParameters*</b> A pointer to the structure where the information is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetParameters(WICDdsParameters* pParameters);
    ///Retrieves the specified frame of the DDS image.
    ///Params:
    ///    arrayIndex = Type: <b>UINT</b> The requested index within the texture array.
    ///    mipLevel = Type: <b>UINT</b> The requested mip level.
    ///    sliceIndex = Type: <b>UINT</b> The requested slice within the 3D texture.
    ///    ppIBitmapFrame = Type: <b>IWICBitmapFrameDecode**</b> A pointer to a IWICBitmapFrameDecode object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFrame(uint arrayIndex, uint mipLevel, uint sliceIndex, IWICBitmapFrameDecode* ppIBitmapFrame);
}

///Enables writing DDS format specific information to an encoder.
@GUID("5CACDB4C-407E-41B3-B936-D0F010CD6732")
interface IWICDdsEncoder : IUnknown
{
    ///Sets DDS-specific data.
    ///Params:
    ///    pParameters = Type: <b>WICDdsParameters*</b> Points to the structure where the information is described.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetParameters(WICDdsParameters* pParameters);
    ///Gets DDS-specific data.
    ///Params:
    ///    pParameters = Type: <b>WICDdsParameters*</b> Points to the structure where the information is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetParameters(WICDdsParameters* pParameters);
    ///Creates a new frame to encode.
    ///Params:
    ///    ppIFrameEncode = A pointer to the newly created frame object.
    ///    pArrayIndex = Points to the location where the array index is returned.
    ///    pMipLevel = Points to the location where the mip level index is returned.
    ///    pSliceIndex = Points to the location where the slice index is returned.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateNewFrame(IWICBitmapFrameEncode* ppIFrameEncode, uint* pArrayIndex, uint* pMipLevel, 
                           uint* pSliceIndex);
}

///Provides access to a single frame of DDS image data in its native DXGI_FORMAT form, as well as information about the
///image data.
@GUID("3D4C0C61-18A4-41E4-BD80-481A4FC9F464")
interface IWICDdsFrameDecode : IUnknown
{
    ///Gets the width and height, in blocks, of the DDS image.
    ///Params:
    ///    pWidthInBlocks = Type: <b>UINT*</b> The width of the DDS image in blocks.
    ///    pHeightInBlocks = Type: <b>UINT*</b> The height of the DDS image in blocks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSizeInBlocks(uint* pWidthInBlocks, uint* pHeightInBlocks);
    ///Gets information about the format in which the DDS image is stored.
    ///Params:
    ///    pFormatInfo = Type: <b>WICDdsFormatInfo*</b> Information about the DDS format.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFormatInfo(WICDdsFormatInfo* pFormatInfo);
    ///Requests pixel data as it is natively stored within the DDS file.
    ///Params:
    ///    prcBoundsInBlocks = Type: <b>const WICRect*</b> The rectangle to copy from the source. A NULL value specifies the entire texture.
    ///                        If the texture uses a block-compressed DXGI_FORMAT, all values of the rectangle are expressed in number of
    ///                        blocks, not pixels.
    ///    cbStride = Type: <b>UINT</b> The stride, in bytes, of the destination buffer. This represents the number of bytes from
    ///               the buffer pointer to the next row of data. If the texture uses a block-compressed DXGI_FORMAT, a "row of
    ///               data" is defined as a row of blocks which contains multiple pixel scanlines.
    ///    cbBufferSize = Type: <b>UINT</b> The size, in bytes, of the destination buffer.
    ///    pbBuffer = Type: <b>BYTE*</b> A pointer to the destination buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CopyBlocks(const(WICRect)* prcBoundsInBlocks, uint cbStride, uint cbBufferSize, char* pbBuffer);
}

///Exposes methods for decoding JPEG images. Provides access to the Start Of Frame (SOF) header, Start of Scan (SOS)
///header, the Huffman and Quantization tables, and the compressed JPEG JPEG data. Also enables indexing for efficient
///random access.
@GUID("8939F66E-C46A-4C21-A9D1-98B327CE1679")
interface IWICJpegFrameDecode : IUnknown
{
    ///Retrieves a value indicating whether this decoder supports indexing for efficient random access.
    ///Params:
    ///    pfIndexingSupported = Type: <b>BOOL*</b> True if indexing is supported; otherwise, false.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK on successful completion.
    ///    
    HRESULT DoesSupportIndexing(int* pfIndexingSupported);
    ///Enables indexing of the JPEG for efficient random access.
    ///Params:
    ///    options = Type: <b>WICJpegIndexingOptions</b> A value specifying whether indexes should be generated immediately or
    ///              deferred until a future call to IWICBitmapSource::CopyPixels.
    ///    horizontalIntervalSize = Type: <b>UINT</b> The granularity of the indexing, in pixels.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK upon successful completion.
    ///    
    HRESULT SetIndexing(WICJpegIndexingOptions options, uint horizontalIntervalSize);
    ///Removes the indexing from a JPEG that has been indexed using IWICJpegFrameDecode::SetIndexing.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK upons successful completion.
    ///    
    HRESULT ClearIndexing();
    ///Retrieves a copy of the AC Huffman table for the specified scan and table.
    ///Params:
    ///    scanIndex = Type: <b>UINT</b> The zero-based index of the scan for which data is retrieved.
    ///    tableIndex = Type: <b>UINT</b> The index of the AC Huffman table to retrieve. Valid indices for a given scan can be
    ///                 determined by retrieving the scan header with IWICJpegFrameDecode::GetScanHeader.
    ///    pAcHuffmanTable = Type: <b>DXGI_JPEG_AC_HUFFMAN_TABLE*</b> A pointer that receives the table data. This parameter must not be
    ///                      NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return value</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt>WINCODEC_ERR_INVALIDJPEGSCANINDEX </dt>
    ///    </dl> </td> <td width="60%"> The specified scan index is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt>WINCODEC_ERR_INVALIDPARAMETER</dt> </dl> </td> <td width="60%"> Can occur if <i>pAcHuffmanTable</i> is
    ///    NULL or if <i>tableIndex</i> does not point to a valid table slot. Check the scan header for valid table
    ///    indices. </td> </tr> </table>
    ///    
    HRESULT GetAcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE* pAcHuffmanTable);
    ///Retrieves a copy of the DC Huffman table for the specified scan and table.
    ///Params:
    ///    scanIndex = Type: <b>UINT</b> The zero-based index of the scan for which data is retrieved.
    ///    tableIndex = Type: <b>UINT</b> The index of the DC Huffman table to retrieve. Valid indices for a given scan can be
    ///                 determined by retrieving the scan header with IWICJpegFrameDecode::GetScanHeader.
    ///    pDcHuffmanTable = Type: <b>DXGI_JPEG_AC_HUFFMAN_TABLE*</b> A pointer that receives the table data. This parameter must not be
    ///                      NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return value</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt>WINCODEC_ERR_INVALIDJPEGSCANINDEX </dt>
    ///    </dl> </td> <td width="60%"> The specified scan index is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt>WINCODEC_ERR_INVALIDPARAMETER</dt> </dl> </td> <td width="60%"> Can occur if <i>pTable</i> is NULL or if
    ///    <i>tableIndex</i> does not point to a valid table slot. Check the scan header for valid table indices. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetDcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE* pDcHuffmanTable);
    ///Retrieves a copy of the quantization table.
    ///Params:
    ///    scanIndex = Type: <b>UINT</b> The zero-based index of the scan for which data is retrieved.
    ///    tableIndex = Type: <b>UINT</b> The index of the quantization table to retrieve. Valid indices for a given scan can be
    ///                 determined by retrieving the scan header with IWICJpegFrameDecode::GetScanHeader.
    ///    pQuantizationTable = Type: <b>DXGI_JPEG_QUANTIZATION_TABLE*</b> A pointer that receives the table data. This parameter must not be
    ///                         NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return value</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt>WINCODEC_ERR_INVALIDJPEGSCANINDEX </dt>
    ///    </dl> </td> <td width="60%"> The specified scan index is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt>WINCODEC_ERR_INVALIDPARAMETER</dt> </dl> </td> <td width="60%"> Can occur if <i>pTable</i> is NULL or if
    ///    <i>tableIndex</i> does not point to a valid table slot. Check the scan header for valid table indices. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetQuantizationTable(uint scanIndex, uint tableIndex, DXGI_JPEG_QUANTIZATION_TABLE* pQuantizationTable);
    ///Retrieves header data from the entire frame. The result includes parameters from the Start Of Frame (SOF) marker
    ///for the scan as well as parameters derived from other metadata such as the color model of the compressed data.
    ///Params:
    ///    pFrameHeader = Type: <b>WICJpegFrameHeader*</b> A pointer that receives the frame header data.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK on successful completion.
    ///    
    HRESULT GetFrameHeader(WICJpegFrameHeader* pFrameHeader);
    ///Retrieves parameters from the Start Of Scan (SOS) marker for the scan with the specified index.
    ///Params:
    ///    scanIndex = Type: <b>UINT</b> The index of the scan for which header data is retrieved.
    ///    pScanHeader = Type: <b>WICJpegScanHeader*</b> A pointer that receives the frame header data.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK on successful completion.
    ///    
    HRESULT GetScanHeader(uint scanIndex, WICJpegScanHeader* pScanHeader);
    ///Retrieves a copy of the compressed JPEG scan directly from the WIC decoder frame's output stream.
    ///Params:
    ///    scanIndex = Type: <b>UINT</b> The zero-based index of the scan for which data is retrieved.
    ///    scanOffset = Type: <b>UINT</b> The byte position in the scan data to begin copying. Use 0 on the first call. If the output
    ///                 buffer size is insufficient to store the entire scan, this offset allows you to resume copying from the end
    ///                 of the previous copy operation.
    ///    cbScanData = Type: <b>UINT</b> The size, in bytes, of the <i>pbScanData</i> array.
    ///    pbScanData = Type: <b>BYTE*</b> A pointer that receives the table data. This parameter must not be NULL.
    ///    pcbScanDataActual = Type: <b>UINT*</b> A pointer that receives the size of the scan data actually copied into <i>pbScanData</i>.
    ///                        The size returned may be smaller that the size of <i>cbScanData</i>. This parameter may be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return value</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt>WINCODEC_ERR_INVALIDJPEGSCANINDEX </dt>
    ///    </dl> </td> <td width="60%"> The specified scan index is invalid. </td> </tr> </table>
    ///    
    HRESULT CopyScan(uint scanIndex, uint scanOffset, uint cbScanData, char* pbScanData, uint* pcbScanDataActual);
    HRESULT CopyMinimalStream(uint streamOffset, uint cbStreamData, char* pbStreamData, uint* pcbStreamDataActual);
}

///Exposes methods for writing compressed JPEG scan data directly to the WIC encoder's output stream. Also provides
///access to the Huffman and quantization tables.
@GUID("2F0C601F-D2C6-468C-ABFA-49495D983ED1")
interface IWICJpegFrameEncode : IUnknown
{
    ///Retrieves a copy of the AC Huffman table for the specified scan and table.
    ///Params:
    ///    scanIndex = Type: <b>UINT</b> The zero-based index of the scan for which data is retrieved.
    ///    tableIndex = Type: <b>UINT</b> The index of the AC Huffman table to retrieve.
    ///    pAcHuffmanTable = Type: <b>DXGI_JPEG_AC_HUFFMAN_TABLE*</b> A pointer that receives the table data. This parameter must not be
    ///                      NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return value</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt>WINCODEC_ERR_INVALIDJPEGSCANINDEX </dt>
    ///    </dl> </td> <td width="60%"> The specified scan index is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt>WINCODEC_ERR_INVALIDPARAMETER</dt> </dl> </td> <td width="60%"> Can occur if <i>pAcHuffmanTable</i> is
    ///    NULL or if <i>tableIndex</i> does not point to a valid table slot. Check the scan header for valid table
    ///    indices. </td> </tr> </table>
    ///    
    HRESULT GetAcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE* pAcHuffmanTable);
    ///Retrieves a copy of the DC Huffman table for the specified scan and table.
    ///Params:
    ///    scanIndex = The zero-based index of the scan for which data is retrieved.
    ///    tableIndex = The index of the DC Huffman table to retrieve.
    ///    pDcHuffmanTable = A pointer that receives the table data. This parameter must not be NULL.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt>WINCODEC_ERR_INVALIDJPEGSCANINDEX </dt> </dl> </td> <td width="60%"> The
    ///    specified scan index is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt>WINCODEC_ERR_INVALIDPARAMETER</dt> </dl> </td> <td width="60%"> Can occur if <i>pTable</i> is NULL or if
    ///    <i>tableIndex</i> does not point to a valid table slot. Check the scan header for valid table indices. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetDcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE* pDcHuffmanTable);
    ///Retrieves a copy of the quantization table.
    ///Params:
    ///    scanIndex = Type: <b>UINT</b> The zero-based index of the scan for which data is retrieved.
    ///    tableIndex = Type: <b>UINT</b> The index of the quantization table to retrieve.
    ///    pQuantizationTable = Type: <b>DXGI_JPEG_QUANTIZATION_TABLE*</b> A pointer that receives the table data. This parameter must not be
    ///                         NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return value</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt>WINCODEC_ERR_INVALIDJPEGSCANINDEX </dt>
    ///    </dl> </td> <td width="60%"> The specified scan index is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt>WINCODEC_ERR_INVALIDPARAMETER</dt> </dl> </td> <td width="60%"> Can occur if <i>pTable</i> is NULL or if
    ///    <i>tableIndex</i> does not point to a valid table slot. Check the scan header for valid table indices. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetQuantizationTable(uint scanIndex, uint tableIndex, DXGI_JPEG_QUANTIZATION_TABLE* pQuantizationTable);
    ///Writes scan data to a JPEG frame.
    ///Params:
    ///    cbScanData = Type: <b>UINT</b> The size of the data in the <i>pbScanData</i> parameter.
    ///    pbScanData = Type: <b>BYTE*</b> The scan data to write.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK on successful completion.
    ///    
    HRESULT WriteScan(uint cbScanData, char* pbScanData);
}

///Exposes methods that provide access to all of the codec's top level metadata blocks.
@GUID("FEAA2A8D-B3F3-43E4-B25C-D1DE990A1AE1")
interface IWICMetadataBlockReader : IUnknown
{
    ///Retrieves the container format of the decoder.
    ///Params:
    ///    pguidContainerFormat = Type: <b>GUID*</b> The container format of the decoder. The native container format GUIDs are listed in WIC
    ///                           GUIDs and CLSIDs.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    ///Retrieves the number of top level metadata blocks.
    ///Params:
    ///    pcCount = Type: <b>UINT*</b> When this method returns, contains the number of top level metadata blocks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* pcCount);
    ///Retrieves an IWICMetadataReader for a specified top level metadata block.
    ///Params:
    ///    nIndex = Type: <b>UINT</b> The index of the desired top level metadata block to retrieve.
    ///    ppIMetadataReader = Type: <b>IWICMetadataReader**</b> When this method returns, contains a pointer to the IWICMetadataReader
    ///                        specified by <i>nIndex</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetReaderByIndex(uint nIndex, IWICMetadataReader* ppIMetadataReader);
    ///Retrieves an enumeration of IWICMetadataReader objects representing each of the top level metadata blocks.
    ///Params:
    ///    ppIEnumMetadata = Type: <b>IEnumUnknown**</b> When this method returns, contains a pointer to an enumeration of
    ///                      IWICMetadataReader objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEnumerator(IEnumUnknown* ppIEnumMetadata);
}

///Exposes methods that enable the encoding of metadata. This interface is implemented by the decoder and its image
///frames.
@GUID("08FB9676-B444-41E8-8DBE-6A53A542BFF1")
interface IWICMetadataBlockWriter : IWICMetadataBlockReader
{
    ///Initializes an IWICMetadataBlockWriter from the given IWICMetadataBlockReader. This will prepopulate the metadata
    ///block writer with all the metadata in the metadata block reader.
    ///Params:
    ///    pIMDBlockReader = Type: <b>IWICMetadataBlockReader*</b> Pointer to the IWICMetadataBlockReader used to initialize the block
    ///                      writer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializeFromBlockReader(IWICMetadataBlockReader pIMDBlockReader);
    ///Retrieves the IWICMetadataWriter that resides at the specified index.
    ///Params:
    ///    nIndex = Type: <b>UINT</b> The index of the metadata writer to be retrieved. This index is zero-based.
    ///    ppIMetadataWriter = Type: <b>IWICMetadataWriter**</b> When this method returns, contains a pointer to the metadata writer that
    ///                        resides at the specified index.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetWriterByIndex(uint nIndex, IWICMetadataWriter* ppIMetadataWriter);
    ///Adds a top-level metadata block by adding a IWICMetadataWriter for it.
    ///Params:
    ///    pIMetadataWriter = Type: <b>IWICMetadataWriter*</b> A pointer to the metadata writer to add to the image.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddWriter(IWICMetadataWriter pIMetadataWriter);
    ///Replaces the metadata writer at the specified index location.
    ///Params:
    ///    nIndex = Type: <b>UINT</b> The index position at which to place the metadata writer. This index is zero-based.
    ///    pIMetadataWriter = Type: <b>IWICMetadataWriter*</b> A pointer to the IWICMetadataWriter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetWriterByIndex(uint nIndex, IWICMetadataWriter pIMetadataWriter);
    ///Removes the metadata writer from the specified index location.
    ///Params:
    ///    nIndex = Type: <b>UINT</b> The index of the metadata writer to remove.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveWriterByIndex(uint nIndex);
}

///Exposes methods that provide access to underlining metadata content. This interface is implemented by independent
///software vendors (ISVs) to create new metadata readers.
@GUID("9204FE99-D8FC-4FD5-A001-9536B067A899")
interface IWICMetadataReader : IUnknown
{
    ///Gets the metadata format associated with the reader.
    ///Params:
    ///    pguidMetadataFormat = Type: <b>GUID*</b> Pointer that receives the metadata format GUID.
    HRESULT GetMetadataFormat(GUID* pguidMetadataFormat);
    ///Gets the metadata handler info associated with the reader.
    ///Params:
    ///    ppIHandler = Type: <b>IWICMetadataHandlerInfo**</b> Pointer that receives a pointer to the IWICMetadataHandlerInfo.
    HRESULT GetMetadataHandlerInfo(IWICMetadataHandlerInfo* ppIHandler);
    ///Gets the number of metadata items within the reader.
    ///Params:
    ///    pcCount = Type: <b>UINT*</b> Pointer that receives the number of metadata items within the reader.
    HRESULT GetCount(uint* pcCount);
    ///Gets the metadata item at the given index.
    ///Params:
    ///    nIndex = Type: <b>UINT</b> The index of the metadata item to retrieve.
    ///    pvarSchema = Type: <b>PROPVARIANT*</b> Pointer that receives the schema property.
    ///    pvarId = Type: <b>PROPVARIANT*</b> Pointer that receives the id property.
    ///    pvarValue = Type: <b>PROPVARIANT*</b> Pointer that receives the metadata value.
    HRESULT GetValueByIndex(uint nIndex, PROPVARIANT* pvarSchema, PROPVARIANT* pvarId, PROPVARIANT* pvarValue);
    ///Gets the metadata item value.
    ///Params:
    ///    pvarSchema = Type: <b>const PROPVARIANT*</b> Pointer to the metadata item's schema property.
    ///    pvarId = Type: <b>const PROPVARIANT*</b> Pointer to the metadata item's id.
    ///    pvarValue = Type: <b>PROPVARIANT*</b> Pointer that receives the metadata value.
    HRESULT GetValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, PROPVARIANT* pvarValue);
    ///Gets an enumerator of all the metadata items.
    ///Params:
    ///    ppIEnumMetadata = Type: <b>IWICEnumMetadataItem**</b> Pointer that receives a pointer to the metadata enumerator.
    HRESULT GetEnumerator(IWICEnumMetadataItem* ppIEnumMetadata);
}

///Exposes methods that provide access to writing metadata content. This is implemented by independent software vendors
///(ISVs) to create new metadata writers.
@GUID("F7836E16-3BE0-470B-86BB-160D0AECD7DE")
interface IWICMetadataWriter : IWICMetadataReader
{
    ///Sets the given metadata item.
    ///Params:
    ///    pvarSchema = Type: <b>const PROPVARIANT*</b> Pointer to the schema property of the metadata item.
    ///    pvarId = Type: <b>const PROPVARIANT*</b> Pointer to the id property of the metadata item.
    ///    pvarValue = Type: <b>const PROPVARIANT*</b> Pointer to the metadata value to set
    HRESULT SetValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, const(PROPVARIANT)* pvarValue);
    ///Sets the metadata item to the specified index.
    ///Params:
    ///    nIndex = Type: <b>UINT</b> The index to place the metadata item.
    ///    pvarSchema = Type: <b>const PROPVARIANT*</b> Pointer to the schema property of the metadata item.
    ///    pvarId = Type: <b>const PROPVARIANT*</b> Pointer to the id property of the metadata item.
    ///    pvarValue = Type: <b>const PROPVARIANT*</b> Pointer to the metadata value to set at the given index.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetValueByIndex(uint nIndex, const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, 
                            const(PROPVARIANT)* pvarValue);
    ///Removes the metadata item that matches the given parameters.
    ///Params:
    ///    pvarSchema = Type: <b>const PROPVARIANT*</b> Pointer to the metadata schema property.
    ///    pvarId = Type: <b>const PROPVARIANT*</b> Pointer to the metadata id property.
    HRESULT RemoveValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId);
    ///Removes the metadata item at the specified index.
    ///Params:
    ///    nIndex = Type: <b>UINT</b> The index of the metadata item to remove.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveValueByIndex(uint nIndex);
}

///Exposes methods for a stream provider.
@GUID("449494BC-B468-4927-96D7-BA90D31AB505")
interface IWICStreamProvider : IUnknown
{
    ///Gets the stream held by the component.
    ///Params:
    ///    ppIStream = Type: <b>IStream**</b> Pointer that receives a pointer to the stream held by the component.
    HRESULT GetStream(IStream* ppIStream);
    ///Gets the persist options used when initializing the component with a stream.
    ///Params:
    ///    pdwPersistOptions = Type: <b>DWORD*</b> Pointer that receives the persist options used when initializing the component with a
    ///                        stream. If none were provided, <b>WICPersistOptionDefault</b> is returned.
    HRESULT GetPersistOptions(uint* pdwPersistOptions);
    ///Gets the preferred vendor GUID.
    ///Params:
    ///    pguidPreferredVendor = Type: <b>GUID*</b> Pointer that receives the preferred vendor GUID.
    HRESULT GetPreferredVendorGUID(GUID* pguidPreferredVendor);
    ///Informs the component that the content of the stream it's holding onto may have changed. The component should
    ///respond by dirtying any cached information from the stream.
    HRESULT RefreshStream();
}

///Exposes methods that provide additional load and save methods that take WICPersistOptions.
@GUID("00675040-6908-45F8-86A3-49C7DFD6D9AD")
interface IWICPersistStream : IPersistStream
{
    ///Loads data from an input stream using the given parameters.
    ///Params:
    ///    pIStream = Type: <b>IStream*</b> Pointer to the input stream.
    ///    pguidPreferredVendor = Type: <b>const GUID*</b> Pointer to the GUID of the preferred vendor .
    ///    dwPersistOptions = Type: <b>DWORD</b> The WICPersistOptions used to load the stream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LoadEx(IStream pIStream, const(GUID)* pguidPreferredVendor, uint dwPersistOptions);
    ///Saves the IWICPersistStream to the given input IStream using the given parameters.
    ///Params:
    ///    pIStream = Type: <b>IStream*</b> The stream to save to.
    ///    dwPersistOptions = Type: <b>DWORD</b> The WICPersistOptions to use when saving.
    ///    fClearDirty = Type: <b>BOOL</b> Indicates whether the "dirty" value will be cleared from all metadata after saving.
    HRESULT SaveEx(IStream pIStream, uint dwPersistOptions, BOOL fClearDirty);
}

///Exposes methods that provide basic information about the registered metadata handler.
@GUID("ABA958BF-C672-44D1-8D61-CE6DF2E682C2")
interface IWICMetadataHandlerInfo : IWICComponentInfo
{
    ///Retrieves the metadata format of the metadata handler.
    ///Params:
    ///    pguidMetadataFormat = Type: <b>GUID*</b> Pointer that receives the metadata format GUID.
    HRESULT GetMetadataFormat(GUID* pguidMetadataFormat);
    ///Retrieves the container formats supported by the metadata handler.
    ///Params:
    ///    cContainerFormats = Type: <b>UINT</b> The size of the <i>pguidContainerFormats</i> array.
    ///    pguidContainerFormats = Type: <b>GUID*</b> Pointer to an array that receives the container formats supported by the metadata handler.
    ///    pcchActual = Type: <b>UINT*</b> The actual number of GUIDs added to the array. To obtain the number of supported container
    ///                 formats, pass <code>NULL</code> to <i>pguidContainerFormats</i>.
    HRESULT GetContainerFormats(uint cContainerFormats, char* pguidContainerFormats, uint* pcchActual);
    ///Retrieves the device manufacturer of the metadata handler.
    ///Params:
    ///    cchDeviceManufacturer = Type: <b>UINT</b> The size of the <i>wzDeviceManufacturer</i> buffer.
    ///    wzDeviceManufacturer = Type: <b>WCHAR*</b> Pointer to the buffer that receives the name of the device manufacturer.
    ///    pcchActual = Type: <b>UINT*</b> The actual string buffer length needed to obtain the entire name of the device
    ///                 manufacturer.
    HRESULT GetDeviceManufacturer(uint cchDeviceManufacturer, char* wzDeviceManufacturer, uint* pcchActual);
    ///Retrieves the device models that support the metadata handler.
    ///Params:
    ///    cchDeviceModels = Type: <b>UINT</b> The length of the <i>wzDeviceModels</i> buffer.
    ///    wzDeviceModels = Type: <b>WCHAR*</b> Pointer that receives the device models supported by the metadata handler.
    ///    pcchActual = Type: <b>UINT*</b> The actual length needed to retrieve the device models.
    HRESULT GetDeviceModels(uint cchDeviceModels, char* wzDeviceModels, uint* pcchActual);
    ///Determines if the handler requires a full stream.
    ///Params:
    ///    pfRequiresFullStream = Type: <b>BOOL*</b> Pointer that receives <b>TRUE</b> if a full stream is required; otherwise, <b>FALSE</b>.
    HRESULT DoesRequireFullStream(int* pfRequiresFullStream);
    ///Determines if the metadata handler supports padding.
    ///Params:
    ///    pfSupportsPadding = Type: <b>BOOL*</b> Pointer that receives <b>TRUE</b> if padding is supported; otherwise, <b>FALSE</b>.
    HRESULT DoesSupportPadding(int* pfSupportsPadding);
    ///Determines if the metadata handler requires a fixed size.
    ///Params:
    ///    pfFixedSize = Type: <b>BOOL*</b> Pointer that receives <b>TRUE</b> if a fixed size is required; otherwise, <b>FALSE</b>.
    HRESULT DoesRequireFixedSize(int* pfFixedSize);
}

///Exposes methods that provide basic information about the registered metadata reader.
@GUID("EEBF1F5B-07C1-4447-A3AB-22ACAF78A804")
interface IWICMetadataReaderInfo : IWICMetadataHandlerInfo
{
    ///Gets the metadata patterns associated with the metadata reader.
    ///Params:
    ///    guidContainerFormat = Type: <b>REFGUID</b> The cointainer format GUID.
    ///    cbSize = Type: <b>UINT</b> The size, in bytes, of the <i>pPattern</i> buffer.
    ///    pPattern = Type: <b>WICMetadataPattern*</b> Pointer that receives the metadata patterns.
    ///    pcCount = Type: <b>UINT*</b> Pointer that receives the number of metadata patterns.
    ///    pcbActual = Type: <b>UINT*</b> Pointer that receives the size, in bytes, needed to obtain the metadata patterns.
    HRESULT GetPatterns(const(GUID)* guidContainerFormat, uint cbSize, char* pPattern, uint* pcCount, 
                        uint* pcbActual);
    ///Determines if a stream contains a metadata item pattern.
    ///Params:
    ///    guidContainerFormat = Type: <b>REFGUID</b> The container format of the metadata item.
    ///    pIStream = Type: <b>IStream*</b> The stream to search for the metadata pattern.
    ///    pfMatches = Type: <b>BOOL*</b> Pointer that receives <code>TRUE</code> if the stream contains the pattern; otherwise,
    ///                <code>FALSE</code>.
    HRESULT MatchesPattern(const(GUID)* guidContainerFormat, IStream pIStream, int* pfMatches);
    ///Creates an instance of an IWICMetadataReader.
    ///Params:
    ///    ppIReader = Type: <b>IWICMetadataReader**</b> Pointer that receives a pointer to a metadata reader.
    HRESULT CreateInstance(IWICMetadataReader* ppIReader);
}

///Exposes methods that provide basic information about the registered metadata writer.
@GUID("B22E3FBA-3925-4323-B5C1-9EBFC430F236")
interface IWICMetadataWriterInfo : IWICMetadataHandlerInfo
{
    ///Gets the metadata header for the metadata writer.
    ///Params:
    ///    guidContainerFormat = Type: <b>REFGUID</b> The format container GUID to obtain the header for.
    ///    cbSize = Type: <b>UINT</b> The size of the <i>pHeader</i> buffer.
    ///    pHeader = Type: <b>WICMetadataHeader*</b> Pointer that receives the WICMetadataHeader.
    ///    pcbActual = Type: <b>UINT*</b> The actual size of the header.
    HRESULT GetHeader(const(GUID)* guidContainerFormat, uint cbSize, char* pHeader, uint* pcbActual);
    ///Creates an instance of an IWICMetadataWriter.
    ///Params:
    ///    ppIWriter = Type: <b>IWICMetadataWriter**</b> Pointer that receives a pointer to a metadata writer.
    HRESULT CreateInstance(IWICMetadataWriter* ppIWriter);
}

///Exposes methods that create components used by component developers. This includes metadata readers, writers and
///other services for use by codec and metadata handler developers.
@GUID("412D0C3A-9650-44FA-AF5B-DD2A06C8E8FB")
interface IWICComponentFactory : IWICImagingFactory
{
    ///Creates an IWICMetadataReader based on the given parameters.
    ///Params:
    ///    guidMetadataFormat = Type: <b>REFGUID</b> The GUID of the desired metadata format.
    ///    pguidVendor = Type: <b>const GUID*</b> Pointer to the GUID of the desired metadata reader vendor.
    ///    dwOptions = Type: <b>DWORD</b> The WICPersistOptions and WICMetadataCreationOptions options to use when creating the
    ///                metadata reader.
    ///    pIStream = Type: <b>IStream*</b> Pointer to a stream in which to initialize the reader with. If <b>NULL</b>, the
    ///               metadata reader will be empty.
    ///    ppIReader = Type: <b>IWICMetadataReader**</b> A pointer that receives a pointer to the new metadata reader.
    HRESULT CreateMetadataReader(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, uint dwOptions, 
                                 IStream pIStream, IWICMetadataReader* ppIReader);
    ///Creates an IWICMetadataReader based on the given parameters.
    ///Params:
    ///    guidContainerFormat = Type: <b>REFGUID</b> The container format GUID to base the reader on.
    ///    pguidVendor = Type: <b>const GUID*</b> Pointer to the vendor GUID of the metadata reader.
    ///    dwOptions = Type: <b>DWORD</b> The WICPersistOptions and WICMetadataCreationOptions options to use when creating the
    ///                metadata reader.
    ///    pIStream = Type: <b>IStream*</b> Pointer to a stream in which to initialize the reader with. If <b>NULL</b>, the
    ///               metadata reader will be empty.
    ///    ppIReader = Type: <b>IWICMetadataReader**</b> A pointer that receives a pointer to the new metadata reader
    HRESULT CreateMetadataReaderFromContainer(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                                              uint dwOptions, IStream pIStream, IWICMetadataReader* ppIReader);
    ///Creates an IWICMetadataWriter based on the given parameters.
    ///Params:
    ///    guidMetadataFormat = Type: <b>REFGUID</b> The GUID of the desired metadata format.
    ///    pguidVendor = Type: <b>const GUID*</b> Pointer to the GUID of the desired metadata reader vendor.
    ///    dwMetadataOptions = Type: <b>DWORD</b> The WICPersistOptions and WICMetadataCreationOptions options to use when creating the
    ///                        metadata reader.
    ///    ppIWriter = Type: <b>IWICMetadataWriter**</b> A pointer that receives a pointer to the new metadata writer.
    HRESULT CreateMetadataWriter(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, uint dwMetadataOptions, 
                                 IWICMetadataWriter* ppIWriter);
    ///Creates an IWICMetadataWriter from the given IWICMetadataReader.
    ///Params:
    ///    pIReader = Type: <b>IWICMetadataReader*</b> Pointer to the metadata reader to base the metadata writer on.
    ///    pguidVendor = Type: <b>const GUID*</b> Pointer to the GUID of the desired metadata reader vendor.
    ///    ppIWriter = Type: <b>IWICMetadataWriter**</b> A pointer that receives a pointer to the new metadata writer.
    HRESULT CreateMetadataWriterFromReader(IWICMetadataReader pIReader, const(GUID)* pguidVendor, 
                                           IWICMetadataWriter* ppIWriter);
    ///Creates a IWICMetadataQueryReader from the given IWICMetadataBlockReader.
    ///Params:
    ///    pIBlockReader = Type: <b>IWICMetadataBlockReader*</b> Pointer to the block reader to base the query reader on.
    ///    ppIQueryReader = Type: <b>IWICMetadataQueryReader**</b> A pointer that receives a pointer to the new metadata query reader.
    HRESULT CreateQueryReaderFromBlockReader(IWICMetadataBlockReader pIBlockReader, 
                                             IWICMetadataQueryReader* ppIQueryReader);
    ///Creates a IWICMetadataQueryWriter from the given IWICMetadataBlockWriter.
    ///Params:
    ///    pIBlockWriter = Type: <b>IWICMetadataBlockWriter*</b> Pointer to the metadata block reader to base the metadata query writer
    ///                    on.
    ///    ppIQueryWriter = Type: <b>IWICMetadataQueryWriter**</b> A pointer that receives a pointer to the new metadata query writer.
    HRESULT CreateQueryWriterFromBlockWriter(IWICMetadataBlockWriter pIBlockWriter, 
                                             IWICMetadataQueryWriter* ppIQueryWriter);
    ///Creates an encoder property bag.
    ///Params:
    ///    ppropOptions = Type: <b>PROPBAG2*</b> Pointer to an array of PROPBAG2 options used to create the encoder property bag.
    ///    cCount = Type: <b>UINT</b> The number of PROPBAG2 structures in the <i>ppropOptions</i> array.
    ///    ppIPropertyBag = Type: <b>IPropertyBag2**</b> A pointer that receives a pointer to an encoder IPropertyBag2.
    HRESULT CreateEncoderPropertyBag(char* ppropOptions, uint cCount, IPropertyBag2* ppIPropertyBag);
}


// GUIDs


const GUID IID_IWICBitmap                          = GUIDOF!IWICBitmap;
const GUID IID_IWICBitmapClipper                   = GUIDOF!IWICBitmapClipper;
const GUID IID_IWICBitmapCodecInfo                 = GUIDOF!IWICBitmapCodecInfo;
const GUID IID_IWICBitmapCodecProgressNotification = GUIDOF!IWICBitmapCodecProgressNotification;
const GUID IID_IWICBitmapDecoder                   = GUIDOF!IWICBitmapDecoder;
const GUID IID_IWICBitmapDecoderInfo               = GUIDOF!IWICBitmapDecoderInfo;
const GUID IID_IWICBitmapEncoder                   = GUIDOF!IWICBitmapEncoder;
const GUID IID_IWICBitmapEncoderInfo               = GUIDOF!IWICBitmapEncoderInfo;
const GUID IID_IWICBitmapFlipRotator               = GUIDOF!IWICBitmapFlipRotator;
const GUID IID_IWICBitmapFrameDecode               = GUIDOF!IWICBitmapFrameDecode;
const GUID IID_IWICBitmapFrameEncode               = GUIDOF!IWICBitmapFrameEncode;
const GUID IID_IWICBitmapLock                      = GUIDOF!IWICBitmapLock;
const GUID IID_IWICBitmapScaler                    = GUIDOF!IWICBitmapScaler;
const GUID IID_IWICBitmapSource                    = GUIDOF!IWICBitmapSource;
const GUID IID_IWICBitmapSourceTransform           = GUIDOF!IWICBitmapSourceTransform;
const GUID IID_IWICColorContext                    = GUIDOF!IWICColorContext;
const GUID IID_IWICColorTransform                  = GUIDOF!IWICColorTransform;
const GUID IID_IWICComponentFactory                = GUIDOF!IWICComponentFactory;
const GUID IID_IWICComponentInfo                   = GUIDOF!IWICComponentInfo;
const GUID IID_IWICDdsDecoder                      = GUIDOF!IWICDdsDecoder;
const GUID IID_IWICDdsEncoder                      = GUIDOF!IWICDdsEncoder;
const GUID IID_IWICDdsFrameDecode                  = GUIDOF!IWICDdsFrameDecode;
const GUID IID_IWICDevelopRaw                      = GUIDOF!IWICDevelopRaw;
const GUID IID_IWICDevelopRawNotificationCallback  = GUIDOF!IWICDevelopRawNotificationCallback;
const GUID IID_IWICEnumMetadataItem                = GUIDOF!IWICEnumMetadataItem;
const GUID IID_IWICFastMetadataEncoder             = GUIDOF!IWICFastMetadataEncoder;
const GUID IID_IWICFormatConverter                 = GUIDOF!IWICFormatConverter;
const GUID IID_IWICFormatConverterInfo             = GUIDOF!IWICFormatConverterInfo;
const GUID IID_IWICImageEncoder                    = GUIDOF!IWICImageEncoder;
const GUID IID_IWICImagingFactory                  = GUIDOF!IWICImagingFactory;
const GUID IID_IWICImagingFactory2                 = GUIDOF!IWICImagingFactory2;
const GUID IID_IWICJpegFrameDecode                 = GUIDOF!IWICJpegFrameDecode;
const GUID IID_IWICJpegFrameEncode                 = GUIDOF!IWICJpegFrameEncode;
const GUID IID_IWICMetadataBlockReader             = GUIDOF!IWICMetadataBlockReader;
const GUID IID_IWICMetadataBlockWriter             = GUIDOF!IWICMetadataBlockWriter;
const GUID IID_IWICMetadataHandlerInfo             = GUIDOF!IWICMetadataHandlerInfo;
const GUID IID_IWICMetadataQueryReader             = GUIDOF!IWICMetadataQueryReader;
const GUID IID_IWICMetadataQueryWriter             = GUIDOF!IWICMetadataQueryWriter;
const GUID IID_IWICMetadataReader                  = GUIDOF!IWICMetadataReader;
const GUID IID_IWICMetadataReaderInfo              = GUIDOF!IWICMetadataReaderInfo;
const GUID IID_IWICMetadataWriter                  = GUIDOF!IWICMetadataWriter;
const GUID IID_IWICMetadataWriterInfo              = GUIDOF!IWICMetadataWriterInfo;
const GUID IID_IWICPalette                         = GUIDOF!IWICPalette;
const GUID IID_IWICPersistStream                   = GUIDOF!IWICPersistStream;
const GUID IID_IWICPixelFormatInfo                 = GUIDOF!IWICPixelFormatInfo;
const GUID IID_IWICPixelFormatInfo2                = GUIDOF!IWICPixelFormatInfo2;
const GUID IID_IWICPlanarBitmapFrameEncode         = GUIDOF!IWICPlanarBitmapFrameEncode;
const GUID IID_IWICPlanarBitmapSourceTransform     = GUIDOF!IWICPlanarBitmapSourceTransform;
const GUID IID_IWICPlanarFormatConverter           = GUIDOF!IWICPlanarFormatConverter;
const GUID IID_IWICProgressCallback                = GUIDOF!IWICProgressCallback;
const GUID IID_IWICProgressiveLevelControl         = GUIDOF!IWICProgressiveLevelControl;
const GUID IID_IWICStream                          = GUIDOF!IWICStream;
const GUID IID_IWICStreamProvider                  = GUIDOF!IWICStreamProvider;
