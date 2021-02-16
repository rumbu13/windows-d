module windows.windowsimagingcomponent;

public import windows.core;
public import windows.com : HRESULT, IEnumString, IEnumUnknown, IPersistStream, IPropertyBag2, IUnknown, PROPBAG2;
public import windows.direct2d : D2D1_PIXEL_FORMAT, ID2D1Device, ID2D1Image;
public import windows.dxgi : DXGI_FORMAT, DXGI_JPEG_AC_HUFFMAN_TABLE, DXGI_JPEG_DC_HUFFMAN_TABLE,
                             DXGI_JPEG_QUANTIZATION_TABLE;
public import windows.gdi : HBITMAP, HICON, HPALETTE;
public import windows.structuredstorage : IStream, PROPVARIANT;
public import windows.systemservices : BOOL, HANDLE, ULARGE_INTEGER;

extern(Windows):


// Enums


enum WICColorContextType : int
{
    WICColorContextUninitialized  = 0x00000000,
    WICColorContextProfile        = 0x00000001,
    WICColorContextExifColorSpace = 0x00000002,
}

enum WICBitmapCreateCacheOption : int
{
    WICBitmapNoCache                       = 0x00000000,
    WICBitmapCacheOnDemand                 = 0x00000001,
    WICBitmapCacheOnLoad                   = 0x00000002,
    WICBITMAPCREATECACHEOPTION_FORCE_DWORD = 0x7fffffff,
}

enum WICDecodeOptions : int
{
    WICDecodeMetadataCacheOnDemand     = 0x00000000,
    WICDecodeMetadataCacheOnLoad       = 0x00000001,
    WICMETADATACACHEOPTION_FORCE_DWORD = 0x7fffffff,
}

enum WICBitmapEncoderCacheOption : int
{
    WICBitmapEncoderCacheInMemory           = 0x00000000,
    WICBitmapEncoderCacheTempFile           = 0x00000001,
    WICBitmapEncoderNoCache                 = 0x00000002,
    WICBITMAPENCODERCACHEOPTION_FORCE_DWORD = 0x7fffffff,
}

enum WICComponentType : int
{
    WICDecoder                   = 0x00000001,
    WICEncoder                   = 0x00000002,
    WICPixelFormatConverter      = 0x00000004,
    WICMetadataReader            = 0x00000008,
    WICMetadataWriter            = 0x00000010,
    WICPixelFormat               = 0x00000020,
    WICAllComponents             = 0x0000003f,
    WICCOMPONENTTYPE_FORCE_DWORD = 0x7fffffff,
}

enum WICComponentEnumerateOptions : int
{
    WICComponentEnumerateDefault             = 0x00000000,
    WICComponentEnumerateRefresh             = 0x00000001,
    WICComponentEnumerateDisabled            = 0x80000000,
    WICComponentEnumerateUnsigned            = 0x40000000,
    WICComponentEnumerateBuiltInOnly         = 0x20000000,
    WICCOMPONENTENUMERATEOPTIONS_FORCE_DWORD = 0x7fffffff,
}

enum WICBitmapInterpolationMode : int
{
    WICBitmapInterpolationModeNearestNeighbor  = 0x00000000,
    WICBitmapInterpolationModeLinear           = 0x00000001,
    WICBitmapInterpolationModeCubic            = 0x00000002,
    WICBitmapInterpolationModeFant             = 0x00000003,
    WICBitmapInterpolationModeHighQualityCubic = 0x00000004,
    WICBITMAPINTERPOLATIONMODE_FORCE_DWORD     = 0x7fffffff,
}

enum WICBitmapPaletteType : int
{
    WICBitmapPaletteTypeCustom           = 0x00000000,
    WICBitmapPaletteTypeMedianCut        = 0x00000001,
    WICBitmapPaletteTypeFixedBW          = 0x00000002,
    WICBitmapPaletteTypeFixedHalftone8   = 0x00000003,
    WICBitmapPaletteTypeFixedHalftone27  = 0x00000004,
    WICBitmapPaletteTypeFixedHalftone64  = 0x00000005,
    WICBitmapPaletteTypeFixedHalftone125 = 0x00000006,
    WICBitmapPaletteTypeFixedHalftone216 = 0x00000007,
    WICBitmapPaletteTypeFixedWebPalette  = 0x00000007,
    WICBitmapPaletteTypeFixedHalftone252 = 0x00000008,
    WICBitmapPaletteTypeFixedHalftone256 = 0x00000009,
    WICBitmapPaletteTypeFixedGray4       = 0x0000000a,
    WICBitmapPaletteTypeFixedGray16      = 0x0000000b,
    WICBitmapPaletteTypeFixedGray256     = 0x0000000c,
    WICBITMAPPALETTETYPE_FORCE_DWORD     = 0x7fffffff,
}

enum WICBitmapDitherType : int
{
    WICBitmapDitherTypeNone           = 0x00000000,
    WICBitmapDitherTypeSolid          = 0x00000000,
    WICBitmapDitherTypeOrdered4x4     = 0x00000001,
    WICBitmapDitherTypeOrdered8x8     = 0x00000002,
    WICBitmapDitherTypeOrdered16x16   = 0x00000003,
    WICBitmapDitherTypeSpiral4x4      = 0x00000004,
    WICBitmapDitherTypeSpiral8x8      = 0x00000005,
    WICBitmapDitherTypeDualSpiral4x4  = 0x00000006,
    WICBitmapDitherTypeDualSpiral8x8  = 0x00000007,
    WICBitmapDitherTypeErrorDiffusion = 0x00000008,
    WICBITMAPDITHERTYPE_FORCE_DWORD   = 0x7fffffff,
}

enum WICBitmapAlphaChannelOption : int
{
    WICBitmapUseAlpha                        = 0x00000000,
    WICBitmapUsePremultipliedAlpha           = 0x00000001,
    WICBitmapIgnoreAlpha                     = 0x00000002,
    WICBITMAPALPHACHANNELOPTIONS_FORCE_DWORD = 0x7fffffff,
}

enum WICBitmapTransformOptions : int
{
    WICBitmapTransformRotate0             = 0x00000000,
    WICBitmapTransformRotate90            = 0x00000001,
    WICBitmapTransformRotate180           = 0x00000002,
    WICBitmapTransformRotate270           = 0x00000003,
    WICBitmapTransformFlipHorizontal      = 0x00000008,
    WICBitmapTransformFlipVertical        = 0x00000010,
    WICBITMAPTRANSFORMOPTIONS_FORCE_DWORD = 0x7fffffff,
}

enum WICBitmapLockFlags : int
{
    WICBitmapLockRead              = 0x00000001,
    WICBitmapLockWrite             = 0x00000002,
    WICBITMAPLOCKFLAGS_FORCE_DWORD = 0x7fffffff,
}

enum WICBitmapDecoderCapabilities : int
{
    WICBitmapDecoderCapabilitySameEncoder          = 0x00000001,
    WICBitmapDecoderCapabilityCanDecodeAllImages   = 0x00000002,
    WICBitmapDecoderCapabilityCanDecodeSomeImages  = 0x00000004,
    WICBitmapDecoderCapabilityCanEnumerateMetadata = 0x00000008,
    WICBitmapDecoderCapabilityCanDecodeThumbnail   = 0x00000010,
    WICBITMAPDECODERCAPABILITIES_FORCE_DWORD       = 0x7fffffff,
}

enum WICProgressOperation : int
{
    WICProgressOperationCopyPixels   = 0x00000001,
    WICProgressOperationWritePixels  = 0x00000002,
    WICProgressOperationAll          = 0x0000ffff,
    WICPROGRESSOPERATION_FORCE_DWORD = 0x7fffffff,
}

enum WICProgressNotification : int
{
    WICProgressNotificationBegin        = 0x00010000,
    WICProgressNotificationEnd          = 0x00020000,
    WICProgressNotificationFrequent     = 0x00040000,
    WICProgressNotificationAll          = 0xffff0000,
    WICPROGRESSNOTIFICATION_FORCE_DWORD = 0x7fffffff,
}

enum WICComponentSigning : int
{
    WICComponentSigned              = 0x00000001,
    WICComponentUnsigned            = 0x00000002,
    WICComponentSafe                = 0x00000004,
    WICComponentDisabled            = 0x80000000,
    WICCOMPONENTSIGNING_FORCE_DWORD = 0x7fffffff,
}

enum WICGifLogicalScreenDescriptorProperties : uint
{
    WICGifLogicalScreenSignature                        = 0x00000001,
    WICGifLogicalScreenDescriptorWidth                  = 0x00000002,
    WICGifLogicalScreenDescriptorHeight                 = 0x00000003,
    WICGifLogicalScreenDescriptorGlobalColorTableFlag   = 0x00000004,
    WICGifLogicalScreenDescriptorColorResolution        = 0x00000005,
    WICGifLogicalScreenDescriptorSortFlag               = 0x00000006,
    WICGifLogicalScreenDescriptorGlobalColorTableSize   = 0x00000007,
    WICGifLogicalScreenDescriptorBackgroundColorIndex   = 0x00000008,
    WICGifLogicalScreenDescriptorPixelAspectRatio       = 0x00000009,
    WICGifLogicalScreenDescriptorProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICGifImageDescriptorProperties : uint
{
    WICGifImageDescriptorLeft                   = 0x00000001,
    WICGifImageDescriptorTop                    = 0x00000002,
    WICGifImageDescriptorWidth                  = 0x00000003,
    WICGifImageDescriptorHeight                 = 0x00000004,
    WICGifImageDescriptorLocalColorTableFlag    = 0x00000005,
    WICGifImageDescriptorInterlaceFlag          = 0x00000006,
    WICGifImageDescriptorSortFlag               = 0x00000007,
    WICGifImageDescriptorLocalColorTableSize    = 0x00000008,
    WICGifImageDescriptorProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICGifGraphicControlExtensionProperties : uint
{
    WICGifGraphicControlExtensionDisposal               = 0x00000001,
    WICGifGraphicControlExtensionUserInputFlag          = 0x00000002,
    WICGifGraphicControlExtensionTransparencyFlag       = 0x00000003,
    WICGifGraphicControlExtensionDelay                  = 0x00000004,
    WICGifGraphicControlExtensionTransparentColorIndex  = 0x00000005,
    WICGifGraphicControlExtensionProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICGifApplicationExtensionProperties : uint
{
    WICGifApplicationExtensionApplication            = 0x00000001,
    WICGifApplicationExtensionData                   = 0x00000002,
    WICGifApplicationExtensionProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICGifCommentExtensionProperties : uint
{
    WICGifCommentExtensionText                   = 0x00000001,
    WICGifCommentExtensionProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICJpegCommentProperties : uint
{
    WICJpegCommentText                   = 0x00000001,
    WICJpegCommentProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICJpegLuminanceProperties : uint
{
    WICJpegLuminanceTable                  = 0x00000001,
    WICJpegLuminanceProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICJpegChrominanceProperties : uint
{
    WICJpegChrominanceTable                  = 0x00000001,
    WICJpegChrominanceProperties_FORCE_DWORD = 0x7fffffff,
}

enum WIC8BIMIptcProperties : uint
{
    WIC8BIMIptcPString                = 0x00000000,
    WIC8BIMIptcEmbeddedIPTC           = 0x00000001,
    WIC8BIMIptcProperties_FORCE_DWORD = 0x7fffffff,
}

enum WIC8BIMResolutionInfoProperties : uint
{
    WIC8BIMResolutionInfoPString                = 0x00000001,
    WIC8BIMResolutionInfoHResolution            = 0x00000002,
    WIC8BIMResolutionInfoHResolutionUnit        = 0x00000003,
    WIC8BIMResolutionInfoWidthUnit              = 0x00000004,
    WIC8BIMResolutionInfoVResolution            = 0x00000005,
    WIC8BIMResolutionInfoVResolutionUnit        = 0x00000006,
    WIC8BIMResolutionInfoHeightUnit             = 0x00000007,
    WIC8BIMResolutionInfoProperties_FORCE_DWORD = 0x7fffffff,
}

enum WIC8BIMIptcDigestProperties : uint
{
    WIC8BIMIptcDigestPString                = 0x00000001,
    WIC8BIMIptcDigestIptcDigest             = 0x00000002,
    WIC8BIMIptcDigestProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICPngGamaProperties : uint
{
    WICPngGamaGamma                  = 0x00000001,
    WICPngGamaProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICPngBkgdProperties : uint
{
    WICPngBkgdBackgroundColor        = 0x00000001,
    WICPngBkgdProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICPngItxtProperties : uint
{
    WICPngItxtKeyword                = 0x00000001,
    WICPngItxtCompressionFlag        = 0x00000002,
    WICPngItxtLanguageTag            = 0x00000003,
    WICPngItxtTranslatedKeyword      = 0x00000004,
    WICPngItxtText                   = 0x00000005,
    WICPngItxtProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICPngChrmProperties : uint
{
    WICPngChrmWhitePointX            = 0x00000001,
    WICPngChrmWhitePointY            = 0x00000002,
    WICPngChrmRedX                   = 0x00000003,
    WICPngChrmRedY                   = 0x00000004,
    WICPngChrmGreenX                 = 0x00000005,
    WICPngChrmGreenY                 = 0x00000006,
    WICPngChrmBlueX                  = 0x00000007,
    WICPngChrmBlueY                  = 0x00000008,
    WICPngChrmProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICPngHistProperties : uint
{
    WICPngHistFrequencies            = 0x00000001,
    WICPngHistProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICPngIccpProperties : uint
{
    WICPngIccpProfileName            = 0x00000001,
    WICPngIccpProfileData            = 0x00000002,
    WICPngIccpProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICPngSrgbProperties : uint
{
    WICPngSrgbRenderingIntent        = 0x00000001,
    WICPngSrgbProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICPngTimeProperties : uint
{
    WICPngTimeYear                   = 0x00000001,
    WICPngTimeMonth                  = 0x00000002,
    WICPngTimeDay                    = 0x00000003,
    WICPngTimeHour                   = 0x00000004,
    WICPngTimeMinute                 = 0x00000005,
    WICPngTimeSecond                 = 0x00000006,
    WICPngTimeProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICHeifProperties : uint
{
    WICHeifOrientation            = 0x00000001,
    WICHeifProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICHeifHdrProperties : uint
{
    WICHeifHdrMaximumLuminanceLevel                 = 0x00000001,
    WICHeifHdrMaximumFrameAverageLuminanceLevel     = 0x00000002,
    WICHeifHdrMinimumMasteringDisplayLuminanceLevel = 0x00000003,
    WICHeifHdrMaximumMasteringDisplayLuminanceLevel = 0x00000004,
    WICHeifHdrCustomVideoPrimaries                  = 0x00000005,
    WICHeifHdrProperties_FORCE_DWORD                = 0x7fffffff,
}

enum WICWebpAnimProperties : uint
{
    WICWebpAnimLoopCount              = 0x00000001,
    WICWebpAnimProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICWebpAnmfProperties : uint
{
    WICWebpAnmfFrameDuration          = 0x00000001,
    WICWebpAnmfProperties_FORCE_DWORD = 0x7fffffff,
}

enum WICSectionAccessLevel : uint
{
    WICSectionAccessLevelRead         = 0x00000001,
    WICSectionAccessLevelReadWrite    = 0x00000003,
    WICSectionAccessLevel_FORCE_DWORD = 0x7fffffff,
}

enum WICPixelFormatNumericRepresentation : uint
{
    WICPixelFormatNumericRepresentationUnspecified     = 0x00000000,
    WICPixelFormatNumericRepresentationIndexed         = 0x00000001,
    WICPixelFormatNumericRepresentationUnsignedInteger = 0x00000002,
    WICPixelFormatNumericRepresentationSignedInteger   = 0x00000003,
    WICPixelFormatNumericRepresentationFixed           = 0x00000004,
    WICPixelFormatNumericRepresentationFloat           = 0x00000005,
    WICPixelFormatNumericRepresentation_FORCE_DWORD    = 0x7fffffff,
}

enum WICPlanarOptions : int
{
    WICPlanarOptionsDefault             = 0x00000000,
    WICPlanarOptionsPreserveSubsampling = 0x00000001,
    WICPLANAROPTIONS_FORCE_DWORD        = 0x7fffffff,
}

enum WICJpegIndexingOptions : uint
{
    WICJpegIndexingOptionsGenerateOnDemand = 0x00000000,
    WICJpegIndexingOptionsGenerateOnLoad   = 0x00000001,
    WICJpegIndexingOptions_FORCE_DWORD     = 0x7fffffff,
}

enum WICJpegTransferMatrix : uint
{
    WICJpegTransferMatrixIdentity     = 0x00000000,
    WICJpegTransferMatrixBT601        = 0x00000001,
    WICJpegTransferMatrix_FORCE_DWORD = 0x7fffffff,
}

enum WICJpegScanType : uint
{
    WICJpegScanTypeInterleaved      = 0x00000000,
    WICJpegScanTypePlanarComponents = 0x00000001,
    WICJpegScanTypeProgressive      = 0x00000002,
    WICJpegScanType_FORCE_DWORD     = 0x7fffffff,
}

enum WICTiffCompressionOption : int
{
    WICTiffCompressionDontCare           = 0x00000000,
    WICTiffCompressionNone               = 0x00000001,
    WICTiffCompressionCCITT3             = 0x00000002,
    WICTiffCompressionCCITT4             = 0x00000003,
    WICTiffCompressionLZW                = 0x00000004,
    WICTiffCompressionRLE                = 0x00000005,
    WICTiffCompressionZIP                = 0x00000006,
    WICTiffCompressionLZWHDifferencing   = 0x00000007,
    WICTIFFCOMPRESSIONOPTION_FORCE_DWORD = 0x7fffffff,
}

enum WICJpegYCrCbSubsamplingOption : int
{
    WICJpegYCrCbSubsamplingDefault      = 0x00000000,
    WICJpegYCrCbSubsampling420          = 0x00000001,
    WICJpegYCrCbSubsampling422          = 0x00000002,
    WICJpegYCrCbSubsampling444          = 0x00000003,
    WICJpegYCrCbSubsampling440          = 0x00000004,
    WICJPEGYCRCBSUBSAMPLING_FORCE_DWORD = 0x7fffffff,
}

enum WICPngFilterOption : int
{
    WICPngFilterUnspecified        = 0x00000000,
    WICPngFilterNone               = 0x00000001,
    WICPngFilterSub                = 0x00000002,
    WICPngFilterUp                 = 0x00000003,
    WICPngFilterAverage            = 0x00000004,
    WICPngFilterPaeth              = 0x00000005,
    WICPngFilterAdaptive           = 0x00000006,
    WICPNGFILTEROPTION_FORCE_DWORD = 0x7fffffff,
}

enum WICNamedWhitePoint : int
{
    WICWhitePointDefault           = 0x00000001,
    WICWhitePointDaylight          = 0x00000002,
    WICWhitePointCloudy            = 0x00000004,
    WICWhitePointShade             = 0x00000008,
    WICWhitePointTungsten          = 0x00000010,
    WICWhitePointFluorescent       = 0x00000020,
    WICWhitePointFlash             = 0x00000040,
    WICWhitePointUnderwater        = 0x00000080,
    WICWhitePointCustom            = 0x00000100,
    WICWhitePointAutoWhiteBalance  = 0x00000200,
    WICWhitePointAsShot            = 0x00000001,
    WICNAMEDWHITEPOINT_FORCE_DWORD = 0x7fffffff,
}

enum WICRawCapabilities : int
{
    WICRawCapabilityNotSupported   = 0x00000000,
    WICRawCapabilityGetSupported   = 0x00000001,
    WICRawCapabilityFullySupported = 0x00000002,
    WICRAWCAPABILITIES_FORCE_DWORD = 0x7fffffff,
}

enum WICRawRotationCapabilities : int
{
    WICRawRotationCapabilityNotSupported           = 0x00000000,
    WICRawRotationCapabilityGetSupported           = 0x00000001,
    WICRawRotationCapabilityNinetyDegreesSupported = 0x00000002,
    WICRawRotationCapabilityFullySupported         = 0x00000003,
    WICRAWROTATIONCAPABILITIES_FORCE_DWORD         = 0x7fffffff,
}

enum WICRawParameterSet : int
{
    WICAsShotParameterSet          = 0x00000001,
    WICUserAdjustedParameterSet    = 0x00000002,
    WICAutoAdjustedParameterSet    = 0x00000003,
    WICRAWPARAMETERSET_FORCE_DWORD = 0x7fffffff,
}

enum WICRawRenderMode : int
{
    WICRawRenderModeDraft        = 0x00000001,
    WICRawRenderModeNormal       = 0x00000002,
    WICRawRenderModeBestQuality  = 0x00000003,
    WICRAWRENDERMODE_FORCE_DWORD = 0x7fffffff,
}

enum WICDdsDimension : int
{
    WICDdsTexture1D           = 0x00000000,
    WICDdsTexture2D           = 0x00000001,
    WICDdsTexture3D           = 0x00000002,
    WICDdsTextureCube         = 0x00000003,
    WICDDSTEXTURE_FORCE_DWORD = 0x7fffffff,
}

enum WICDdsAlphaMode : int
{
    WICDdsAlphaModeUnknown       = 0x00000000,
    WICDdsAlphaModeStraight      = 0x00000001,
    WICDdsAlphaModePremultiplied = 0x00000002,
    WICDdsAlphaModeOpaque        = 0x00000003,
    WICDdsAlphaModeCustom        = 0x00000004,
    WICDDSALPHAMODE_FORCE_DWORD  = 0x7fffffff,
}

enum WICMetadataCreationOptions : int
{
    WICMetadataCreationDefault      = 0x00000000,
    WICMetadataCreationAllowUnknown = 0x00000000,
    WICMetadataCreationFailUnknown  = 0x00010000,
    WICMetadataCreationMask         = 0xffff0000,
}

enum WICPersistOptions : int
{
    WICPersistOptionDefault       = 0x00000000,
    WICPersistOptionLittleEndian  = 0x00000000,
    WICPersistOptionBigEndian     = 0x00000001,
    WICPersistOptionStrictFormat  = 0x00000002,
    WICPersistOptionNoCacheStream = 0x00000004,
    WICPersistOptionPreferUTF8    = 0x00000008,
    WICPersistOptionMask          = 0x0000ffff,
}

// Callbacks

alias PFNProgressNotification = HRESULT function(void* pvData, uint uFrameNum, WICProgressOperation operation, 
                                                 double dblProgress);

// Structs


struct WICRect
{
    int X;
    int Y;
    int Width;
    int Height;
}

struct WICBitmapPattern
{
    ULARGE_INTEGER Position;
    uint           Length;
    ubyte*         Pattern;
    ubyte*         Mask;
    BOOL           EndOfStream;
}

struct WICImageParameters
{
    D2D1_PIXEL_FORMAT PixelFormat;
    float             DpiX;
    float             DpiY;
    float             Top;
    float             Left;
    uint              PixelWidth;
    uint              PixelHeight;
}

struct WICBitmapPlaneDescription
{
    GUID Format;
    uint Width;
    uint Height;
}

struct WICBitmapPlane
{
    GUID   Format;
    ubyte* pbBuffer;
    uint   cbStride;
    uint   cbBufferSize;
}

struct WICJpegFrameHeader
{
    uint            Width;
    uint            Height;
    WICJpegTransferMatrix TransferMatrix;
    WICJpegScanType ScanType;
    uint            cComponents;
    uint            ComponentIdentifiers;
    uint            SampleFactors;
    uint            QuantizationTableIndices;
}

struct WICJpegScanHeader
{
    uint  cComponents;
    uint  RestartInterval;
    uint  ComponentSelectors;
    uint  HuffmanTableIndices;
    ubyte StartSpectralSelection;
    ubyte EndSpectralSelection;
    ubyte SuccessiveApproximationHigh;
    ubyte SuccessiveApproximationLow;
}

struct WICRawCapabilitiesInfo
{
    uint               cbSize;
    uint               CodecMajorVersion;
    uint               CodecMinorVersion;
    WICRawCapabilities ExposureCompensationSupport;
    WICRawCapabilities ContrastSupport;
    WICRawCapabilities RGBWhitePointSupport;
    WICRawCapabilities NamedWhitePointSupport;
    uint               NamedWhitePointSupportMask;
    WICRawCapabilities KelvinWhitePointSupport;
    WICRawCapabilities GammaSupport;
    WICRawCapabilities TintSupport;
    WICRawCapabilities SaturationSupport;
    WICRawCapabilities SharpnessSupport;
    WICRawCapabilities NoiseReductionSupport;
    WICRawCapabilities DestinationColorProfileSupport;
    WICRawCapabilities ToneCurveSupport;
    WICRawRotationCapabilities RotationSupport;
    WICRawCapabilities RenderModeSupport;
}

struct WICRawToneCurvePoint
{
    double Input;
    double Output;
}

struct WICRawToneCurve
{
    uint cPoints;
    WICRawToneCurvePoint[1] aPoints;
}

struct WICDdsParameters
{
    uint            Width;
    uint            Height;
    uint            Depth;
    uint            MipLevels;
    uint            ArraySize;
    DXGI_FORMAT     DxgiFormat;
    WICDdsDimension Dimension;
    WICDdsAlphaMode AlphaMode;
}

struct WICDdsFormatInfo
{
    DXGI_FORMAT DxgiFormat;
    uint        BytesPerBlock;
    uint        BlockWidth;
    uint        BlockHeight;
}

struct WICMetadataPattern
{
    ULARGE_INTEGER Position;
    uint           Length;
    ubyte*         Pattern;
    ubyte*         Mask;
    ULARGE_INTEGER DataOffset;
}

struct WICMetadataHeader
{
    ULARGE_INTEGER Position;
    uint           Length;
    ubyte*         Header;
    ULARGE_INTEGER DataOffset;
}

// Functions

@DllImport("WindowsCodecs")
HRESULT WICConvertBitmapSource(GUID* dstFormat, IWICBitmapSource pISrc, IWICBitmapSource* ppIDst);

@DllImport("WindowsCodecs")
HRESULT WICCreateBitmapFromSection(uint width, uint height, GUID* pixelFormat, HANDLE hSection, uint stride, 
                                   uint offset, IWICBitmap* ppIBitmap);

@DllImport("WindowsCodecs")
HRESULT WICCreateBitmapFromSectionEx(uint width, uint height, GUID* pixelFormat, HANDLE hSection, uint stride, 
                                     uint offset, WICSectionAccessLevel desiredAccessLevel, IWICBitmap* ppIBitmap);

@DllImport("WindowsCodecs")
HRESULT WICMapGuidToShortName(const(GUID)* guid, uint cchName, char* wzName, uint* pcchActual);

@DllImport("WindowsCodecs")
HRESULT WICMapShortNameToGuid(const(wchar)* wzName, GUID* pguid);

@DllImport("WindowsCodecs")
HRESULT WICMapSchemaToName(const(GUID)* guidMetadataFormat, const(wchar)* pwzSchema, uint cchName, char* wzName, 
                           uint* pcchActual);

@DllImport("WindowsCodecs")
HRESULT WICMatchMetadataContent(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, IStream pIStream, 
                                GUID* pguidMetadataFormat);

@DllImport("WindowsCodecs")
HRESULT WICSerializeMetadataContent(const(GUID)* guidContainerFormat, IWICMetadataWriter pIWriter, 
                                    uint dwPersistOptions, IStream pIStream);

@DllImport("WindowsCodecs")
HRESULT WICGetMetadataContentSize(const(GUID)* guidContainerFormat, IWICMetadataWriter pIWriter, 
                                  ULARGE_INTEGER* pcbSize);


// Interfaces

@GUID("00000040-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICPalette : IUnknown
{
    HRESULT InitializePredefined(WICBitmapPaletteType ePaletteType, BOOL fAddTransparentColor);
    HRESULT InitializeCustom(char* pColors, uint cCount);
    HRESULT InitializeFromBitmap(IWICBitmapSource pISurface, uint cCount, BOOL fAddTransparentColor);
    HRESULT InitializeFromPalette(IWICPalette pIPalette);
    HRESULT GetType(WICBitmapPaletteType* pePaletteType);
    HRESULT GetColorCount(uint* pcCount);
    HRESULT GetColors(uint cCount, char* pColors, uint* pcActualColors);
    HRESULT IsBlackWhite(int* pfIsBlackWhite);
    HRESULT IsGrayscale(int* pfIsGrayscale);
    HRESULT HasAlpha(int* pfHasAlpha);
}

@GUID("00000120-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmapSource : IUnknown
{
    HRESULT GetSize(uint* puiWidth, uint* puiHeight);
    HRESULT GetPixelFormat(GUID* pPixelFormat);
    HRESULT GetResolution(double* pDpiX, double* pDpiY);
    HRESULT CopyPalette(IWICPalette pIPalette);
    HRESULT CopyPixels(const(WICRect)* prc, uint cbStride, uint cbBufferSize, char* pbBuffer);
}

@GUID("00000301-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICFormatConverter : IWICBitmapSource
{
    HRESULT Initialize(IWICBitmapSource pISource, GUID* dstFormat, WICBitmapDitherType dither, 
                       IWICPalette pIPalette, double alphaThresholdPercent, WICBitmapPaletteType paletteTranslate);
    HRESULT CanConvert(GUID* srcPixelFormat, GUID* dstPixelFormat, int* pfCanConvert);
}

@GUID("BEBEE9CB-83B0-4DCC-8132-B0AAA55EAC96")
interface IWICPlanarFormatConverter : IWICBitmapSource
{
    HRESULT Initialize(char* ppPlanes, uint cPlanes, GUID* dstFormat, WICBitmapDitherType dither, 
                       IWICPalette pIPalette, double alphaThresholdPercent, WICBitmapPaletteType paletteTranslate);
    HRESULT CanConvert(char* pSrcPixelFormats, uint cSrcPlanes, GUID* dstPixelFormat, int* pfCanConvert);
}

@GUID("00000302-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmapScaler : IWICBitmapSource
{
    HRESULT Initialize(IWICBitmapSource pISource, uint uiWidth, uint uiHeight, WICBitmapInterpolationMode mode);
}

@GUID("E4FBCF03-223D-4E81-9333-D635556DD1B5")
interface IWICBitmapClipper : IWICBitmapSource
{
    HRESULT Initialize(IWICBitmapSource pISource, const(WICRect)* prc);
}

@GUID("5009834F-2D6A-41CE-9E1B-17C5AFF7A782")
interface IWICBitmapFlipRotator : IWICBitmapSource
{
    HRESULT Initialize(IWICBitmapSource pISource, WICBitmapTransformOptions options);
}

@GUID("00000123-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmapLock : IUnknown
{
    HRESULT GetSize(uint* puiWidth, uint* puiHeight);
    HRESULT GetStride(uint* pcbStride);
    HRESULT GetDataPointer(uint* pcbBufferSize, char* ppbData);
    HRESULT GetPixelFormat(GUID* pPixelFormat);
}

@GUID("00000121-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmap : IWICBitmapSource
{
    HRESULT Lock(const(WICRect)* prcLock, uint flags, IWICBitmapLock* ppILock);
    HRESULT SetPalette(IWICPalette pIPalette);
    HRESULT SetResolution(double dpiX, double dpiY);
}

@GUID("3C613A02-34B2-44EA-9A7C-45AEA9C6FD6D")
interface IWICColorContext : IUnknown
{
    HRESULT InitializeFromFilename(const(wchar)* wzFilename);
    HRESULT InitializeFromMemory(char* pbBuffer, uint cbBufferSize);
    HRESULT InitializeFromExifColorSpace(uint value);
    HRESULT GetType(WICColorContextType* pType);
    HRESULT GetProfileBytes(uint cbBuffer, char* pbBuffer, uint* pcbActual);
    HRESULT GetExifColorSpace(uint* pValue);
}

@GUID("B66F034F-D0E2-40AB-B436-6DE39E321A94")
interface IWICColorTransform : IWICBitmapSource
{
    HRESULT Initialize(IWICBitmapSource pIBitmapSource, IWICColorContext pIContextSource, 
                       IWICColorContext pIContextDest, GUID* pixelFmtDest);
}

@GUID("B84E2C09-78C9-4AC4-8BD3-524AE1663A2F")
interface IWICFastMetadataEncoder : IUnknown
{
    HRESULT Commit();
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

@GUID("135FF860-22B7-4DDF-B0F6-218F4F299A43")
interface IWICStream : IStream
{
    HRESULT InitializeFromIStream(IStream pIStream);
    HRESULT InitializeFromFilename(const(wchar)* wzFileName, uint dwDesiredAccess);
    HRESULT InitializeFromMemory(char* pbBuffer, uint cbBufferSize);
    HRESULT InitializeFromIStreamRegion(IStream pIStream, ULARGE_INTEGER ulOffset, ULARGE_INTEGER ulMaxSize);
}

@GUID("DC2BB46D-3F07-481E-8625-220C4AEDBB33")
interface IWICEnumMetadataItem : IUnknown
{
    HRESULT Next(uint celt, char* rgeltSchema, char* rgeltId, char* rgeltValue, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IWICEnumMetadataItem* ppIEnumMetadataItem);
}

@GUID("30989668-E1C9-4597-B395-458EEDB808DF")
interface IWICMetadataQueryReader : IUnknown
{
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    HRESULT GetLocation(uint cchMaxLength, char* wzNamespace, uint* pcchActualLength);
    HRESULT GetMetadataByName(const(wchar)* wzName, PROPVARIANT* pvarValue);
    HRESULT GetEnumerator(IEnumString* ppIEnumString);
}

@GUID("A721791A-0DEF-4D06-BD91-2118BF1DB10B")
interface IWICMetadataQueryWriter : IWICMetadataQueryReader
{
    HRESULT SetMetadataByName(const(wchar)* wzName, const(PROPVARIANT)* pvarValue);
    HRESULT RemoveMetadataByName(const(wchar)* wzName);
}

@GUID("00000103-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmapEncoder : IUnknown
{
    HRESULT Initialize(IStream pIStream, WICBitmapEncoderCacheOption cacheOption);
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    HRESULT GetEncoderInfo(IWICBitmapEncoderInfo* ppIEncoderInfo);
    HRESULT SetColorContexts(uint cCount, char* ppIColorContext);
    HRESULT SetPalette(IWICPalette pIPalette);
    HRESULT SetThumbnail(IWICBitmapSource pIThumbnail);
    HRESULT SetPreview(IWICBitmapSource pIPreview);
    HRESULT CreateNewFrame(IWICBitmapFrameEncode* ppIFrameEncode, IPropertyBag2* ppIEncoderOptions);
    HRESULT Commit();
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

@GUID("00000105-A8F2-4877-BA0A-FD2B6645FB94")
interface IWICBitmapFrameEncode : IUnknown
{
    HRESULT Initialize(IPropertyBag2 pIEncoderOptions);
    HRESULT SetSize(uint uiWidth, uint uiHeight);
    HRESULT SetResolution(double dpiX, double dpiY);
    HRESULT SetPixelFormat(GUID* pPixelFormat);
    HRESULT SetColorContexts(uint cCount, char* ppIColorContext);
    HRESULT SetPalette(IWICPalette pIPalette);
    HRESULT SetThumbnail(IWICBitmapSource pIThumbnail);
    HRESULT WritePixels(uint lineCount, uint cbStride, uint cbBufferSize, char* pbPixels);
    HRESULT WriteSource(IWICBitmapSource pIBitmapSource, WICRect* prc);
    HRESULT Commit();
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

@GUID("F928B7B8-2221-40C1-B72E-7E82F1974D1A")
interface IWICPlanarBitmapFrameEncode : IUnknown
{
    HRESULT WritePixels(uint lineCount, char* pPlanes, uint cPlanes);
    HRESULT WriteSource(char* ppPlanes, uint cPlanes, WICRect* prcSource);
}

@GUID("04C75BF8-3CE1-473B-ACC5-3CC4F5E94999")
interface IWICImageEncoder : IUnknown
{
    HRESULT WriteFrame(ID2D1Image pImage, IWICBitmapFrameEncode pFrameEncode, 
                       const(WICImageParameters)* pImageParameters);
    HRESULT WriteFrameThumbnail(ID2D1Image pImage, IWICBitmapFrameEncode pFrameEncode, 
                                const(WICImageParameters)* pImageParameters);
    HRESULT WriteThumbnail(ID2D1Image pImage, IWICBitmapEncoder pEncoder, 
                           const(WICImageParameters)* pImageParameters);
}

@GUID("9EDDE9E7-8DEE-47EA-99DF-E6FAF2ED44BF")
interface IWICBitmapDecoder : IUnknown
{
    HRESULT QueryCapability(IStream pIStream, uint* pdwCapability);
    HRESULT Initialize(IStream pIStream, WICDecodeOptions cacheOptions);
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    HRESULT GetDecoderInfo(IWICBitmapDecoderInfo* ppIDecoderInfo);
    HRESULT CopyPalette(IWICPalette pIPalette);
    HRESULT GetMetadataQueryReader(IWICMetadataQueryReader* ppIMetadataQueryReader);
    HRESULT GetPreview(IWICBitmapSource* ppIBitmapSource);
    HRESULT GetColorContexts(uint cCount, char* ppIColorContexts, uint* pcActualCount);
    HRESULT GetThumbnail(IWICBitmapSource* ppIThumbnail);
    HRESULT GetFrameCount(uint* pCount);
    HRESULT GetFrame(uint index, IWICBitmapFrameDecode* ppIBitmapFrame);
}

@GUID("3B16811B-6A43-4EC9-B713-3D5A0C13B940")
interface IWICBitmapSourceTransform : IUnknown
{
    HRESULT CopyPixels(const(WICRect)* prc, uint uiWidth, uint uiHeight, GUID* pguidDstFormat, 
                       WICBitmapTransformOptions dstTransform, uint nStride, uint cbBufferSize, char* pbBuffer);
    HRESULT GetClosestSize(uint* puiWidth, uint* puiHeight);
    HRESULT GetClosestPixelFormat(GUID* pguidDstFormat);
    HRESULT DoesSupportTransform(WICBitmapTransformOptions dstTransform, int* pfIsSupported);
}

@GUID("3AFF9CCE-BE95-4303-B927-E7D16FF4A613")
interface IWICPlanarBitmapSourceTransform : IUnknown
{
    HRESULT DoesSupportTransform(uint* puiWidth, uint* puiHeight, WICBitmapTransformOptions dstTransform, 
                                 WICPlanarOptions dstPlanarOptions, char* pguidDstFormats, char* pPlaneDescriptions, 
                                 uint cPlanes, int* pfIsSupported);
    HRESULT CopyPixels(const(WICRect)* prcSource, uint uiWidth, uint uiHeight, 
                       WICBitmapTransformOptions dstTransform, WICPlanarOptions dstPlanarOptions, char* pDstPlanes, 
                       uint cPlanes);
}

@GUID("3B16811B-6A43-4EC9-A813-3D930C13B940")
interface IWICBitmapFrameDecode : IWICBitmapSource
{
    HRESULT GetMetadataQueryReader(IWICMetadataQueryReader* ppIMetadataQueryReader);
    HRESULT GetColorContexts(uint cCount, char* ppIColorContexts, uint* pcActualCount);
    HRESULT GetThumbnail(IWICBitmapSource* ppIThumbnail);
}

@GUID("DAAC296F-7AA5-4DBF-8D15-225C5976F891")
interface IWICProgressiveLevelControl : IUnknown
{
    HRESULT GetLevelCount(uint* pcLevels);
    HRESULT GetCurrentLevel(uint* pnLevel);
    HRESULT SetCurrentLevel(uint nLevel);
}

@GUID("4776F9CD-9517-45FA-BF24-E89C5EC5C60C")
interface IWICProgressCallback : IUnknown
{
    HRESULT Notify(uint uFrameNum, WICProgressOperation operation, double dblProgress);
}

@GUID("64C1024E-C3CF-4462-8078-88C2B11C46D9")
interface IWICBitmapCodecProgressNotification : IUnknown
{
    HRESULT RegisterProgressNotification(PFNProgressNotification pfnProgressNotification, void* pvData, 
                                         uint dwProgressFlags);
}

@GUID("23BC3F0A-698B-4357-886B-F24D50671334")
interface IWICComponentInfo : IUnknown
{
    HRESULT GetComponentType(WICComponentType* pType);
    HRESULT GetCLSID(GUID* pclsid);
    HRESULT GetSigningStatus(uint* pStatus);
    HRESULT GetAuthor(uint cchAuthor, char* wzAuthor, uint* pcchActual);
    HRESULT GetVendorGUID(GUID* pguidVendor);
    HRESULT GetVersion(uint cchVersion, char* wzVersion, uint* pcchActual);
    HRESULT GetSpecVersion(uint cchSpecVersion, char* wzSpecVersion, uint* pcchActual);
    HRESULT GetFriendlyName(uint cchFriendlyName, char* wzFriendlyName, uint* pcchActual);
}

@GUID("9F34FB65-13F4-4F15-BC57-3726B5E53D9F")
interface IWICFormatConverterInfo : IWICComponentInfo
{
    HRESULT GetPixelFormats(uint cFormats, char* pPixelFormatGUIDs, uint* pcActual);
    HRESULT CreateInstance(IWICFormatConverter* ppIConverter);
}

@GUID("E87A44C4-B76E-4C47-8B09-298EB12A2714")
interface IWICBitmapCodecInfo : IWICComponentInfo
{
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    HRESULT GetPixelFormats(uint cFormats, char* pguidPixelFormats, uint* pcActual);
    HRESULT GetColorManagementVersion(uint cchColorManagementVersion, char* wzColorManagementVersion, 
                                      uint* pcchActual);
    HRESULT GetDeviceManufacturer(uint cchDeviceManufacturer, char* wzDeviceManufacturer, uint* pcchActual);
    HRESULT GetDeviceModels(uint cchDeviceModels, char* wzDeviceModels, uint* pcchActual);
    HRESULT GetMimeTypes(uint cchMimeTypes, char* wzMimeTypes, uint* pcchActual);
    HRESULT GetFileExtensions(uint cchFileExtensions, char* wzFileExtensions, uint* pcchActual);
    HRESULT DoesSupportAnimation(int* pfSupportAnimation);
    HRESULT DoesSupportChromakey(int* pfSupportChromakey);
    HRESULT DoesSupportLossless(int* pfSupportLossless);
    HRESULT DoesSupportMultiframe(int* pfSupportMultiframe);
    HRESULT MatchesMimeType(const(wchar)* wzMimeType, int* pfMatches);
}

@GUID("94C9B4EE-A09F-4F92-8A1E-4A9BCE7E76FB")
interface IWICBitmapEncoderInfo : IWICBitmapCodecInfo
{
    HRESULT CreateInstance(IWICBitmapEncoder* ppIBitmapEncoder);
}

@GUID("D8CD007F-D08F-4191-9BFC-236EA7F0E4B5")
interface IWICBitmapDecoderInfo : IWICBitmapCodecInfo
{
    HRESULT GetPatterns(uint cbSizePatterns, char* pPatterns, uint* pcPatterns, uint* pcbPatternsActual);
    HRESULT MatchesPattern(IStream pIStream, int* pfMatches);
    HRESULT CreateInstance(IWICBitmapDecoder* ppIBitmapDecoder);
}

@GUID("E8EDA601-3D48-431A-AB44-69059BE88BBE")
interface IWICPixelFormatInfo : IWICComponentInfo
{
    HRESULT GetFormatGUID(GUID* pFormat);
    HRESULT GetColorContext(IWICColorContext* ppIColorContext);
    HRESULT GetBitsPerPixel(uint* puiBitsPerPixel);
    HRESULT GetChannelCount(uint* puiChannelCount);
    HRESULT GetChannelMask(uint uiChannelIndex, uint cbMaskBuffer, char* pbMaskBuffer, uint* pcbActual);
}

@GUID("A9DB33A2-AF5F-43C7-B679-74F5984B5AA4")
interface IWICPixelFormatInfo2 : IWICPixelFormatInfo
{
    HRESULT SupportsTransparency(int* pfSupportsTransparency);
    HRESULT GetNumericRepresentation(WICPixelFormatNumericRepresentation* pNumericRepresentation);
}

@GUID("EC5EC8A9-C395-4314-9C77-54D7A935FF70")
interface IWICImagingFactory : IUnknown
{
    HRESULT CreateDecoderFromFilename(const(wchar)* wzFilename, const(GUID)* pguidVendor, uint dwDesiredAccess, 
                                      WICDecodeOptions metadataOptions, IWICBitmapDecoder* ppIDecoder);
    HRESULT CreateDecoderFromStream(IStream pIStream, const(GUID)* pguidVendor, WICDecodeOptions metadataOptions, 
                                    IWICBitmapDecoder* ppIDecoder);
    HRESULT CreateDecoderFromFileHandle(size_t hFile, const(GUID)* pguidVendor, WICDecodeOptions metadataOptions, 
                                        IWICBitmapDecoder* ppIDecoder);
    HRESULT CreateComponentInfo(const(GUID)* clsidComponent, IWICComponentInfo* ppIInfo);
    HRESULT CreateDecoder(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                          IWICBitmapDecoder* ppIDecoder);
    HRESULT CreateEncoder(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                          IWICBitmapEncoder* ppIEncoder);
    HRESULT CreatePalette(IWICPalette* ppIPalette);
    HRESULT CreateFormatConverter(IWICFormatConverter* ppIFormatConverter);
    HRESULT CreateBitmapScaler(IWICBitmapScaler* ppIBitmapScaler);
    HRESULT CreateBitmapClipper(IWICBitmapClipper* ppIBitmapClipper);
    HRESULT CreateBitmapFlipRotator(IWICBitmapFlipRotator* ppIBitmapFlipRotator);
    HRESULT CreateStream(IWICStream* ppIWICStream);
    HRESULT CreateColorContext(IWICColorContext* ppIWICColorContext);
    HRESULT CreateColorTransformer(IWICColorTransform* ppIWICColorTransform);
    HRESULT CreateBitmap(uint uiWidth, uint uiHeight, GUID* pixelFormat, WICBitmapCreateCacheOption option, 
                         IWICBitmap* ppIBitmap);
    HRESULT CreateBitmapFromSource(IWICBitmapSource pIBitmapSource, WICBitmapCreateCacheOption option, 
                                   IWICBitmap* ppIBitmap);
    HRESULT CreateBitmapFromSourceRect(IWICBitmapSource pIBitmapSource, uint x, uint y, uint width, uint height, 
                                       IWICBitmap* ppIBitmap);
    HRESULT CreateBitmapFromMemory(uint uiWidth, uint uiHeight, GUID* pixelFormat, uint cbStride, 
                                   uint cbBufferSize, char* pbBuffer, IWICBitmap* ppIBitmap);
    HRESULT CreateBitmapFromHBITMAP(HBITMAP hBitmap, HPALETTE hPalette, WICBitmapAlphaChannelOption options, 
                                    IWICBitmap* ppIBitmap);
    HRESULT CreateBitmapFromHICON(HICON hIcon, IWICBitmap* ppIBitmap);
    HRESULT CreateComponentEnumerator(uint componentTypes, uint options, IEnumUnknown* ppIEnumUnknown);
    HRESULT CreateFastMetadataEncoderFromDecoder(IWICBitmapDecoder pIDecoder, 
                                                 IWICFastMetadataEncoder* ppIFastEncoder);
    HRESULT CreateFastMetadataEncoderFromFrameDecode(IWICBitmapFrameDecode pIFrameDecoder, 
                                                     IWICFastMetadataEncoder* ppIFastEncoder);
    HRESULT CreateQueryWriter(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, 
                              IWICMetadataQueryWriter* ppIQueryWriter);
    HRESULT CreateQueryWriterFromReader(IWICMetadataQueryReader pIQueryReader, const(GUID)* pguidVendor, 
                                        IWICMetadataQueryWriter* ppIQueryWriter);
}

@GUID("7B816B45-1996-4476-B132-DE9E247C8AF0")
interface IWICImagingFactory2 : IWICImagingFactory
{
    HRESULT CreateImageEncoder(ID2D1Device pD2DDevice, IWICImageEncoder* ppWICImageEncoder);
}

@GUID("95C75A6E-3E8C-4EC2-85A8-AEBCC551E59B")
interface IWICDevelopRawNotificationCallback : IUnknown
{
    HRESULT Notify(uint NotificationMask);
}

@GUID("FBEC5E44-F7BE-4B65-B7F8-C0C81FEF026D")
interface IWICDevelopRaw : IWICBitmapFrameDecode
{
    HRESULT QueryRawCapabilitiesInfo(WICRawCapabilitiesInfo* pInfo);
    HRESULT LoadParameterSet(WICRawParameterSet ParameterSet);
    HRESULT GetCurrentParameterSet(IPropertyBag2* ppCurrentParameterSet);
    HRESULT SetExposureCompensation(double ev);
    HRESULT GetExposureCompensation(double* pEV);
    HRESULT SetWhitePointRGB(uint Red, uint Green, uint Blue);
    HRESULT GetWhitePointRGB(uint* pRed, uint* pGreen, uint* pBlue);
    HRESULT SetNamedWhitePoint(WICNamedWhitePoint WhitePoint);
    HRESULT GetNamedWhitePoint(WICNamedWhitePoint* pWhitePoint);
    HRESULT SetWhitePointKelvin(uint WhitePointKelvin);
    HRESULT GetWhitePointKelvin(uint* pWhitePointKelvin);
    HRESULT GetKelvinRangeInfo(uint* pMinKelvinTemp, uint* pMaxKelvinTemp, uint* pKelvinTempStepValue);
    HRESULT SetContrast(double Contrast);
    HRESULT GetContrast(double* pContrast);
    HRESULT SetGamma(double Gamma);
    HRESULT GetGamma(double* pGamma);
    HRESULT SetSharpness(double Sharpness);
    HRESULT GetSharpness(double* pSharpness);
    HRESULT SetSaturation(double Saturation);
    HRESULT GetSaturation(double* pSaturation);
    HRESULT SetTint(double Tint);
    HRESULT GetTint(double* pTint);
    HRESULT SetNoiseReduction(double NoiseReduction);
    HRESULT GetNoiseReduction(double* pNoiseReduction);
    HRESULT SetDestinationColorContext(IWICColorContext pColorContext);
    HRESULT SetToneCurve(uint cbToneCurveSize, char* pToneCurve);
    HRESULT GetToneCurve(uint cbToneCurveBufferSize, char* pToneCurve, uint* pcbActualToneCurveBufferSize);
    HRESULT SetRotation(double Rotation);
    HRESULT GetRotation(double* pRotation);
    HRESULT SetRenderMode(WICRawRenderMode RenderMode);
    HRESULT GetRenderMode(WICRawRenderMode* pRenderMode);
    HRESULT SetNotificationCallback(IWICDevelopRawNotificationCallback pCallback);
}

@GUID("409CD537-8532-40CB-9774-E2FEB2DF4E9C")
interface IWICDdsDecoder : IUnknown
{
    HRESULT GetParameters(WICDdsParameters* pParameters);
    HRESULT GetFrame(uint arrayIndex, uint mipLevel, uint sliceIndex, IWICBitmapFrameDecode* ppIBitmapFrame);
}

@GUID("5CACDB4C-407E-41B3-B936-D0F010CD6732")
interface IWICDdsEncoder : IUnknown
{
    HRESULT SetParameters(WICDdsParameters* pParameters);
    HRESULT GetParameters(WICDdsParameters* pParameters);
    HRESULT CreateNewFrame(IWICBitmapFrameEncode* ppIFrameEncode, uint* pArrayIndex, uint* pMipLevel, 
                           uint* pSliceIndex);
}

@GUID("3D4C0C61-18A4-41E4-BD80-481A4FC9F464")
interface IWICDdsFrameDecode : IUnknown
{
    HRESULT GetSizeInBlocks(uint* pWidthInBlocks, uint* pHeightInBlocks);
    HRESULT GetFormatInfo(WICDdsFormatInfo* pFormatInfo);
    HRESULT CopyBlocks(const(WICRect)* prcBoundsInBlocks, uint cbStride, uint cbBufferSize, char* pbBuffer);
}

@GUID("8939F66E-C46A-4C21-A9D1-98B327CE1679")
interface IWICJpegFrameDecode : IUnknown
{
    HRESULT DoesSupportIndexing(int* pfIndexingSupported);
    HRESULT SetIndexing(WICJpegIndexingOptions options, uint horizontalIntervalSize);
    HRESULT ClearIndexing();
    HRESULT GetAcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE* pAcHuffmanTable);
    HRESULT GetDcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE* pDcHuffmanTable);
    HRESULT GetQuantizationTable(uint scanIndex, uint tableIndex, DXGI_JPEG_QUANTIZATION_TABLE* pQuantizationTable);
    HRESULT GetFrameHeader(WICJpegFrameHeader* pFrameHeader);
    HRESULT GetScanHeader(uint scanIndex, WICJpegScanHeader* pScanHeader);
    HRESULT CopyScan(uint scanIndex, uint scanOffset, uint cbScanData, char* pbScanData, uint* pcbScanDataActual);
    HRESULT CopyMinimalStream(uint streamOffset, uint cbStreamData, char* pbStreamData, uint* pcbStreamDataActual);
}

@GUID("2F0C601F-D2C6-468C-ABFA-49495D983ED1")
interface IWICJpegFrameEncode : IUnknown
{
    HRESULT GetAcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE* pAcHuffmanTable);
    HRESULT GetDcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE* pDcHuffmanTable);
    HRESULT GetQuantizationTable(uint scanIndex, uint tableIndex, DXGI_JPEG_QUANTIZATION_TABLE* pQuantizationTable);
    HRESULT WriteScan(uint cbScanData, char* pbScanData);
}

@GUID("FEAA2A8D-B3F3-43E4-B25C-D1DE990A1AE1")
interface IWICMetadataBlockReader : IUnknown
{
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    HRESULT GetCount(uint* pcCount);
    HRESULT GetReaderByIndex(uint nIndex, IWICMetadataReader* ppIMetadataReader);
    HRESULT GetEnumerator(IEnumUnknown* ppIEnumMetadata);
}

@GUID("08FB9676-B444-41E8-8DBE-6A53A542BFF1")
interface IWICMetadataBlockWriter : IWICMetadataBlockReader
{
    HRESULT InitializeFromBlockReader(IWICMetadataBlockReader pIMDBlockReader);
    HRESULT GetWriterByIndex(uint nIndex, IWICMetadataWriter* ppIMetadataWriter);
    HRESULT AddWriter(IWICMetadataWriter pIMetadataWriter);
    HRESULT SetWriterByIndex(uint nIndex, IWICMetadataWriter pIMetadataWriter);
    HRESULT RemoveWriterByIndex(uint nIndex);
}

@GUID("9204FE99-D8FC-4FD5-A001-9536B067A899")
interface IWICMetadataReader : IUnknown
{
    HRESULT GetMetadataFormat(GUID* pguidMetadataFormat);
    HRESULT GetMetadataHandlerInfo(IWICMetadataHandlerInfo* ppIHandler);
    HRESULT GetCount(uint* pcCount);
    HRESULT GetValueByIndex(uint nIndex, PROPVARIANT* pvarSchema, PROPVARIANT* pvarId, PROPVARIANT* pvarValue);
    HRESULT GetValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, PROPVARIANT* pvarValue);
    HRESULT GetEnumerator(IWICEnumMetadataItem* ppIEnumMetadata);
}

@GUID("F7836E16-3BE0-470B-86BB-160D0AECD7DE")
interface IWICMetadataWriter : IWICMetadataReader
{
    HRESULT SetValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, const(PROPVARIANT)* pvarValue);
    HRESULT SetValueByIndex(uint nIndex, const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, 
                            const(PROPVARIANT)* pvarValue);
    HRESULT RemoveValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId);
    HRESULT RemoveValueByIndex(uint nIndex);
}

@GUID("449494BC-B468-4927-96D7-BA90D31AB505")
interface IWICStreamProvider : IUnknown
{
    HRESULT GetStream(IStream* ppIStream);
    HRESULT GetPersistOptions(uint* pdwPersistOptions);
    HRESULT GetPreferredVendorGUID(GUID* pguidPreferredVendor);
    HRESULT RefreshStream();
}

@GUID("00675040-6908-45F8-86A3-49C7DFD6D9AD")
interface IWICPersistStream : IPersistStream
{
    HRESULT LoadEx(IStream pIStream, const(GUID)* pguidPreferredVendor, uint dwPersistOptions);
    HRESULT SaveEx(IStream pIStream, uint dwPersistOptions, BOOL fClearDirty);
}

@GUID("ABA958BF-C672-44D1-8D61-CE6DF2E682C2")
interface IWICMetadataHandlerInfo : IWICComponentInfo
{
    HRESULT GetMetadataFormat(GUID* pguidMetadataFormat);
    HRESULT GetContainerFormats(uint cContainerFormats, char* pguidContainerFormats, uint* pcchActual);
    HRESULT GetDeviceManufacturer(uint cchDeviceManufacturer, char* wzDeviceManufacturer, uint* pcchActual);
    HRESULT GetDeviceModels(uint cchDeviceModels, char* wzDeviceModels, uint* pcchActual);
    HRESULT DoesRequireFullStream(int* pfRequiresFullStream);
    HRESULT DoesSupportPadding(int* pfSupportsPadding);
    HRESULT DoesRequireFixedSize(int* pfFixedSize);
}

@GUID("EEBF1F5B-07C1-4447-A3AB-22ACAF78A804")
interface IWICMetadataReaderInfo : IWICMetadataHandlerInfo
{
    HRESULT GetPatterns(const(GUID)* guidContainerFormat, uint cbSize, char* pPattern, uint* pcCount, 
                        uint* pcbActual);
    HRESULT MatchesPattern(const(GUID)* guidContainerFormat, IStream pIStream, int* pfMatches);
    HRESULT CreateInstance(IWICMetadataReader* ppIReader);
}

@GUID("B22E3FBA-3925-4323-B5C1-9EBFC430F236")
interface IWICMetadataWriterInfo : IWICMetadataHandlerInfo
{
    HRESULT GetHeader(const(GUID)* guidContainerFormat, uint cbSize, char* pHeader, uint* pcbActual);
    HRESULT CreateInstance(IWICMetadataWriter* ppIWriter);
}

@GUID("412D0C3A-9650-44FA-AF5B-DD2A06C8E8FB")
interface IWICComponentFactory : IWICImagingFactory
{
    HRESULT CreateMetadataReader(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, uint dwOptions, 
                                 IStream pIStream, IWICMetadataReader* ppIReader);
    HRESULT CreateMetadataReaderFromContainer(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                                              uint dwOptions, IStream pIStream, IWICMetadataReader* ppIReader);
    HRESULT CreateMetadataWriter(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, uint dwMetadataOptions, 
                                 IWICMetadataWriter* ppIWriter);
    HRESULT CreateMetadataWriterFromReader(IWICMetadataReader pIReader, const(GUID)* pguidVendor, 
                                           IWICMetadataWriter* ppIWriter);
    HRESULT CreateQueryReaderFromBlockReader(IWICMetadataBlockReader pIBlockReader, 
                                             IWICMetadataQueryReader* ppIQueryReader);
    HRESULT CreateQueryWriterFromBlockWriter(IWICMetadataBlockWriter pIBlockWriter, 
                                             IWICMetadataQueryWriter* ppIQueryWriter);
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
