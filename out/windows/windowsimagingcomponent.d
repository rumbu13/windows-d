module windows.windowsimagingcomponent;

public import system;
public import windows.com;
public import windows.direct2d;
public import windows.dxgi;
public import windows.gdi;
public import windows.structuredstorage;
public import windows.systemservices;

extern(Windows):

struct WICRect
{
    int X;
    int Y;
    int Width;
    int Height;
}

enum WICColorContextType
{
    WICColorContextUninitialized = 0,
    WICColorContextProfile = 1,
    WICColorContextExifColorSpace = 2,
}

enum WICBitmapCreateCacheOption
{
    WICBitmapNoCache = 0,
    WICBitmapCacheOnDemand = 1,
    WICBitmapCacheOnLoad = 2,
    WICBITMAPCREATECACHEOPTION_FORCE_DWORD = 2147483647,
}

enum WICDecodeOptions
{
    WICDecodeMetadataCacheOnDemand = 0,
    WICDecodeMetadataCacheOnLoad = 1,
    WICMETADATACACHEOPTION_FORCE_DWORD = 2147483647,
}

enum WICBitmapEncoderCacheOption
{
    WICBitmapEncoderCacheInMemory = 0,
    WICBitmapEncoderCacheTempFile = 1,
    WICBitmapEncoderNoCache = 2,
    WICBITMAPENCODERCACHEOPTION_FORCE_DWORD = 2147483647,
}

enum WICComponentType
{
    WICDecoder = 1,
    WICEncoder = 2,
    WICPixelFormatConverter = 4,
    WICMetadataReader = 8,
    WICMetadataWriter = 16,
    WICPixelFormat = 32,
    WICAllComponents = 63,
    WICCOMPONENTTYPE_FORCE_DWORD = 2147483647,
}

enum WICComponentEnumerateOptions
{
    WICComponentEnumerateDefault = 0,
    WICComponentEnumerateRefresh = 1,
    WICComponentEnumerateDisabled = -2147483648,
    WICComponentEnumerateUnsigned = 1073741824,
    WICComponentEnumerateBuiltInOnly = 536870912,
    WICCOMPONENTENUMERATEOPTIONS_FORCE_DWORD = 2147483647,
}

struct WICBitmapPattern
{
    ULARGE_INTEGER Position;
    uint Length;
    ubyte* Pattern;
    ubyte* Mask;
    BOOL EndOfStream;
}

enum WICBitmapInterpolationMode
{
    WICBitmapInterpolationModeNearestNeighbor = 0,
    WICBitmapInterpolationModeLinear = 1,
    WICBitmapInterpolationModeCubic = 2,
    WICBitmapInterpolationModeFant = 3,
    WICBitmapInterpolationModeHighQualityCubic = 4,
    WICBITMAPINTERPOLATIONMODE_FORCE_DWORD = 2147483647,
}

enum WICBitmapPaletteType
{
    WICBitmapPaletteTypeCustom = 0,
    WICBitmapPaletteTypeMedianCut = 1,
    WICBitmapPaletteTypeFixedBW = 2,
    WICBitmapPaletteTypeFixedHalftone8 = 3,
    WICBitmapPaletteTypeFixedHalftone27 = 4,
    WICBitmapPaletteTypeFixedHalftone64 = 5,
    WICBitmapPaletteTypeFixedHalftone125 = 6,
    WICBitmapPaletteTypeFixedHalftone216 = 7,
    WICBitmapPaletteTypeFixedWebPalette = 7,
    WICBitmapPaletteTypeFixedHalftone252 = 8,
    WICBitmapPaletteTypeFixedHalftone256 = 9,
    WICBitmapPaletteTypeFixedGray4 = 10,
    WICBitmapPaletteTypeFixedGray16 = 11,
    WICBitmapPaletteTypeFixedGray256 = 12,
    WICBITMAPPALETTETYPE_FORCE_DWORD = 2147483647,
}

enum WICBitmapDitherType
{
    WICBitmapDitherTypeNone = 0,
    WICBitmapDitherTypeSolid = 0,
    WICBitmapDitherTypeOrdered4x4 = 1,
    WICBitmapDitherTypeOrdered8x8 = 2,
    WICBitmapDitherTypeOrdered16x16 = 3,
    WICBitmapDitherTypeSpiral4x4 = 4,
    WICBitmapDitherTypeSpiral8x8 = 5,
    WICBitmapDitherTypeDualSpiral4x4 = 6,
    WICBitmapDitherTypeDualSpiral8x8 = 7,
    WICBitmapDitherTypeErrorDiffusion = 8,
    WICBITMAPDITHERTYPE_FORCE_DWORD = 2147483647,
}

enum WICBitmapAlphaChannelOption
{
    WICBitmapUseAlpha = 0,
    WICBitmapUsePremultipliedAlpha = 1,
    WICBitmapIgnoreAlpha = 2,
    WICBITMAPALPHACHANNELOPTIONS_FORCE_DWORD = 2147483647,
}

enum WICBitmapTransformOptions
{
    WICBitmapTransformRotate0 = 0,
    WICBitmapTransformRotate90 = 1,
    WICBitmapTransformRotate180 = 2,
    WICBitmapTransformRotate270 = 3,
    WICBitmapTransformFlipHorizontal = 8,
    WICBitmapTransformFlipVertical = 16,
    WICBITMAPTRANSFORMOPTIONS_FORCE_DWORD = 2147483647,
}

enum WICBitmapLockFlags
{
    WICBitmapLockRead = 1,
    WICBitmapLockWrite = 2,
    WICBITMAPLOCKFLAGS_FORCE_DWORD = 2147483647,
}

enum WICBitmapDecoderCapabilities
{
    WICBitmapDecoderCapabilitySameEncoder = 1,
    WICBitmapDecoderCapabilityCanDecodeAllImages = 2,
    WICBitmapDecoderCapabilityCanDecodeSomeImages = 4,
    WICBitmapDecoderCapabilityCanEnumerateMetadata = 8,
    WICBitmapDecoderCapabilityCanDecodeThumbnail = 16,
    WICBITMAPDECODERCAPABILITIES_FORCE_DWORD = 2147483647,
}

enum WICProgressOperation
{
    WICProgressOperationCopyPixels = 1,
    WICProgressOperationWritePixels = 2,
    WICProgressOperationAll = 65535,
    WICPROGRESSOPERATION_FORCE_DWORD = 2147483647,
}

enum WICProgressNotification
{
    WICProgressNotificationBegin = 65536,
    WICProgressNotificationEnd = 131072,
    WICProgressNotificationFrequent = 262144,
    WICProgressNotificationAll = -65536,
    WICPROGRESSNOTIFICATION_FORCE_DWORD = 2147483647,
}

enum WICComponentSigning
{
    WICComponentSigned = 1,
    WICComponentUnsigned = 2,
    WICComponentSafe = 4,
    WICComponentDisabled = -2147483648,
    WICCOMPONENTSIGNING_FORCE_DWORD = 2147483647,
}

enum WICGifLogicalScreenDescriptorProperties
{
    WICGifLogicalScreenSignature = 1,
    WICGifLogicalScreenDescriptorWidth = 2,
    WICGifLogicalScreenDescriptorHeight = 3,
    WICGifLogicalScreenDescriptorGlobalColorTableFlag = 4,
    WICGifLogicalScreenDescriptorColorResolution = 5,
    WICGifLogicalScreenDescriptorSortFlag = 6,
    WICGifLogicalScreenDescriptorGlobalColorTableSize = 7,
    WICGifLogicalScreenDescriptorBackgroundColorIndex = 8,
    WICGifLogicalScreenDescriptorPixelAspectRatio = 9,
    WICGifLogicalScreenDescriptorProperties_FORCE_DWORD = 2147483647,
}

enum WICGifImageDescriptorProperties
{
    WICGifImageDescriptorLeft = 1,
    WICGifImageDescriptorTop = 2,
    WICGifImageDescriptorWidth = 3,
    WICGifImageDescriptorHeight = 4,
    WICGifImageDescriptorLocalColorTableFlag = 5,
    WICGifImageDescriptorInterlaceFlag = 6,
    WICGifImageDescriptorSortFlag = 7,
    WICGifImageDescriptorLocalColorTableSize = 8,
    WICGifImageDescriptorProperties_FORCE_DWORD = 2147483647,
}

enum WICGifGraphicControlExtensionProperties
{
    WICGifGraphicControlExtensionDisposal = 1,
    WICGifGraphicControlExtensionUserInputFlag = 2,
    WICGifGraphicControlExtensionTransparencyFlag = 3,
    WICGifGraphicControlExtensionDelay = 4,
    WICGifGraphicControlExtensionTransparentColorIndex = 5,
    WICGifGraphicControlExtensionProperties_FORCE_DWORD = 2147483647,
}

enum WICGifApplicationExtensionProperties
{
    WICGifApplicationExtensionApplication = 1,
    WICGifApplicationExtensionData = 2,
    WICGifApplicationExtensionProperties_FORCE_DWORD = 2147483647,
}

enum WICGifCommentExtensionProperties
{
    WICGifCommentExtensionText = 1,
    WICGifCommentExtensionProperties_FORCE_DWORD = 2147483647,
}

enum WICJpegCommentProperties
{
    WICJpegCommentText = 1,
    WICJpegCommentProperties_FORCE_DWORD = 2147483647,
}

enum WICJpegLuminanceProperties
{
    WICJpegLuminanceTable = 1,
    WICJpegLuminanceProperties_FORCE_DWORD = 2147483647,
}

enum WICJpegChrominanceProperties
{
    WICJpegChrominanceTable = 1,
    WICJpegChrominanceProperties_FORCE_DWORD = 2147483647,
}

enum WIC8BIMIptcProperties
{
    WIC8BIMIptcPString = 0,
    WIC8BIMIptcEmbeddedIPTC = 1,
    WIC8BIMIptcProperties_FORCE_DWORD = 2147483647,
}

enum WIC8BIMResolutionInfoProperties
{
    WIC8BIMResolutionInfoPString = 1,
    WIC8BIMResolutionInfoHResolution = 2,
    WIC8BIMResolutionInfoHResolutionUnit = 3,
    WIC8BIMResolutionInfoWidthUnit = 4,
    WIC8BIMResolutionInfoVResolution = 5,
    WIC8BIMResolutionInfoVResolutionUnit = 6,
    WIC8BIMResolutionInfoHeightUnit = 7,
    WIC8BIMResolutionInfoProperties_FORCE_DWORD = 2147483647,
}

enum WIC8BIMIptcDigestProperties
{
    WIC8BIMIptcDigestPString = 1,
    WIC8BIMIptcDigestIptcDigest = 2,
    WIC8BIMIptcDigestProperties_FORCE_DWORD = 2147483647,
}

enum WICPngGamaProperties
{
    WICPngGamaGamma = 1,
    WICPngGamaProperties_FORCE_DWORD = 2147483647,
}

enum WICPngBkgdProperties
{
    WICPngBkgdBackgroundColor = 1,
    WICPngBkgdProperties_FORCE_DWORD = 2147483647,
}

enum WICPngItxtProperties
{
    WICPngItxtKeyword = 1,
    WICPngItxtCompressionFlag = 2,
    WICPngItxtLanguageTag = 3,
    WICPngItxtTranslatedKeyword = 4,
    WICPngItxtText = 5,
    WICPngItxtProperties_FORCE_DWORD = 2147483647,
}

enum WICPngChrmProperties
{
    WICPngChrmWhitePointX = 1,
    WICPngChrmWhitePointY = 2,
    WICPngChrmRedX = 3,
    WICPngChrmRedY = 4,
    WICPngChrmGreenX = 5,
    WICPngChrmGreenY = 6,
    WICPngChrmBlueX = 7,
    WICPngChrmBlueY = 8,
    WICPngChrmProperties_FORCE_DWORD = 2147483647,
}

enum WICPngHistProperties
{
    WICPngHistFrequencies = 1,
    WICPngHistProperties_FORCE_DWORD = 2147483647,
}

enum WICPngIccpProperties
{
    WICPngIccpProfileName = 1,
    WICPngIccpProfileData = 2,
    WICPngIccpProperties_FORCE_DWORD = 2147483647,
}

enum WICPngSrgbProperties
{
    WICPngSrgbRenderingIntent = 1,
    WICPngSrgbProperties_FORCE_DWORD = 2147483647,
}

enum WICPngTimeProperties
{
    WICPngTimeYear = 1,
    WICPngTimeMonth = 2,
    WICPngTimeDay = 3,
    WICPngTimeHour = 4,
    WICPngTimeMinute = 5,
    WICPngTimeSecond = 6,
    WICPngTimeProperties_FORCE_DWORD = 2147483647,
}

enum WICHeifProperties
{
    WICHeifOrientation = 1,
    WICHeifProperties_FORCE_DWORD = 2147483647,
}

enum WICHeifHdrProperties
{
    WICHeifHdrMaximumLuminanceLevel = 1,
    WICHeifHdrMaximumFrameAverageLuminanceLevel = 2,
    WICHeifHdrMinimumMasteringDisplayLuminanceLevel = 3,
    WICHeifHdrMaximumMasteringDisplayLuminanceLevel = 4,
    WICHeifHdrCustomVideoPrimaries = 5,
    WICHeifHdrProperties_FORCE_DWORD = 2147483647,
}

enum WICWebpAnimProperties
{
    WICWebpAnimLoopCount = 1,
    WICWebpAnimProperties_FORCE_DWORD = 2147483647,
}

enum WICWebpAnmfProperties
{
    WICWebpAnmfFrameDuration = 1,
    WICWebpAnmfProperties_FORCE_DWORD = 2147483647,
}

enum WICSectionAccessLevel
{
    WICSectionAccessLevelRead = 1,
    WICSectionAccessLevelReadWrite = 3,
    WICSectionAccessLevel_FORCE_DWORD = 2147483647,
}

enum WICPixelFormatNumericRepresentation
{
    WICPixelFormatNumericRepresentationUnspecified = 0,
    WICPixelFormatNumericRepresentationIndexed = 1,
    WICPixelFormatNumericRepresentationUnsignedInteger = 2,
    WICPixelFormatNumericRepresentationSignedInteger = 3,
    WICPixelFormatNumericRepresentationFixed = 4,
    WICPixelFormatNumericRepresentationFloat = 5,
    WICPixelFormatNumericRepresentation_FORCE_DWORD = 2147483647,
}

enum WICPlanarOptions
{
    WICPlanarOptionsDefault = 0,
    WICPlanarOptionsPreserveSubsampling = 1,
    WICPLANAROPTIONS_FORCE_DWORD = 2147483647,
}

enum WICJpegIndexingOptions
{
    WICJpegIndexingOptionsGenerateOnDemand = 0,
    WICJpegIndexingOptionsGenerateOnLoad = 1,
    WICJpegIndexingOptions_FORCE_DWORD = 2147483647,
}

enum WICJpegTransferMatrix
{
    WICJpegTransferMatrixIdentity = 0,
    WICJpegTransferMatrixBT601 = 1,
    WICJpegTransferMatrix_FORCE_DWORD = 2147483647,
}

enum WICJpegScanType
{
    WICJpegScanTypeInterleaved = 0,
    WICJpegScanTypePlanarComponents = 1,
    WICJpegScanTypeProgressive = 2,
    WICJpegScanType_FORCE_DWORD = 2147483647,
}

struct WICImageParameters
{
    D2D1_PIXEL_FORMAT PixelFormat;
    float DpiX;
    float DpiY;
    float Top;
    float Left;
    uint PixelWidth;
    uint PixelHeight;
}

struct WICBitmapPlaneDescription
{
    Guid Format;
    uint Width;
    uint Height;
}

struct WICBitmapPlane
{
    Guid Format;
    ubyte* pbBuffer;
    uint cbStride;
    uint cbBufferSize;
}

struct WICJpegFrameHeader
{
    uint Width;
    uint Height;
    WICJpegTransferMatrix TransferMatrix;
    WICJpegScanType ScanType;
    uint cComponents;
    uint ComponentIdentifiers;
    uint SampleFactors;
    uint QuantizationTableIndices;
}

struct WICJpegScanHeader
{
    uint cComponents;
    uint RestartInterval;
    uint ComponentSelectors;
    uint HuffmanTableIndices;
    ubyte StartSpectralSelection;
    ubyte EndSpectralSelection;
    ubyte SuccessiveApproximationHigh;
    ubyte SuccessiveApproximationLow;
}

const GUID IID_IWICPalette = {0x00000040, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]};
@GUID(0x00000040, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]);
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

const GUID IID_IWICBitmapSource = {0x00000120, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]};
@GUID(0x00000120, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]);
interface IWICBitmapSource : IUnknown
{
    HRESULT GetSize(uint* puiWidth, uint* puiHeight);
    HRESULT GetPixelFormat(Guid* pPixelFormat);
    HRESULT GetResolution(double* pDpiX, double* pDpiY);
    HRESULT CopyPalette(IWICPalette pIPalette);
    HRESULT CopyPixels(const(WICRect)* prc, uint cbStride, uint cbBufferSize, char* pbBuffer);
}

const GUID IID_IWICFormatConverter = {0x00000301, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]};
@GUID(0x00000301, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]);
interface IWICFormatConverter : IWICBitmapSource
{
    HRESULT Initialize(IWICBitmapSource pISource, Guid* dstFormat, WICBitmapDitherType dither, IWICPalette pIPalette, double alphaThresholdPercent, WICBitmapPaletteType paletteTranslate);
    HRESULT CanConvert(Guid* srcPixelFormat, Guid* dstPixelFormat, int* pfCanConvert);
}

const GUID IID_IWICPlanarFormatConverter = {0xBEBEE9CB, 0x83B0, 0x4DCC, [0x81, 0x32, 0xB0, 0xAA, 0xA5, 0x5E, 0xAC, 0x96]};
@GUID(0xBEBEE9CB, 0x83B0, 0x4DCC, [0x81, 0x32, 0xB0, 0xAA, 0xA5, 0x5E, 0xAC, 0x96]);
interface IWICPlanarFormatConverter : IWICBitmapSource
{
    HRESULT Initialize(char* ppPlanes, uint cPlanes, Guid* dstFormat, WICBitmapDitherType dither, IWICPalette pIPalette, double alphaThresholdPercent, WICBitmapPaletteType paletteTranslate);
    HRESULT CanConvert(char* pSrcPixelFormats, uint cSrcPlanes, Guid* dstPixelFormat, int* pfCanConvert);
}

const GUID IID_IWICBitmapScaler = {0x00000302, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]};
@GUID(0x00000302, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]);
interface IWICBitmapScaler : IWICBitmapSource
{
    HRESULT Initialize(IWICBitmapSource pISource, uint uiWidth, uint uiHeight, WICBitmapInterpolationMode mode);
}

const GUID IID_IWICBitmapClipper = {0xE4FBCF03, 0x223D, 0x4E81, [0x93, 0x33, 0xD6, 0x35, 0x55, 0x6D, 0xD1, 0xB5]};
@GUID(0xE4FBCF03, 0x223D, 0x4E81, [0x93, 0x33, 0xD6, 0x35, 0x55, 0x6D, 0xD1, 0xB5]);
interface IWICBitmapClipper : IWICBitmapSource
{
    HRESULT Initialize(IWICBitmapSource pISource, const(WICRect)* prc);
}

const GUID IID_IWICBitmapFlipRotator = {0x5009834F, 0x2D6A, 0x41CE, [0x9E, 0x1B, 0x17, 0xC5, 0xAF, 0xF7, 0xA7, 0x82]};
@GUID(0x5009834F, 0x2D6A, 0x41CE, [0x9E, 0x1B, 0x17, 0xC5, 0xAF, 0xF7, 0xA7, 0x82]);
interface IWICBitmapFlipRotator : IWICBitmapSource
{
    HRESULT Initialize(IWICBitmapSource pISource, WICBitmapTransformOptions options);
}

const GUID IID_IWICBitmapLock = {0x00000123, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]};
@GUID(0x00000123, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]);
interface IWICBitmapLock : IUnknown
{
    HRESULT GetSize(uint* puiWidth, uint* puiHeight);
    HRESULT GetStride(uint* pcbStride);
    HRESULT GetDataPointer(uint* pcbBufferSize, char* ppbData);
    HRESULT GetPixelFormat(Guid* pPixelFormat);
}

const GUID IID_IWICBitmap = {0x00000121, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]};
@GUID(0x00000121, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]);
interface IWICBitmap : IWICBitmapSource
{
    HRESULT Lock(const(WICRect)* prcLock, uint flags, IWICBitmapLock* ppILock);
    HRESULT SetPalette(IWICPalette pIPalette);
    HRESULT SetResolution(double dpiX, double dpiY);
}

const GUID IID_IWICColorContext = {0x3C613A02, 0x34B2, 0x44EA, [0x9A, 0x7C, 0x45, 0xAE, 0xA9, 0xC6, 0xFD, 0x6D]};
@GUID(0x3C613A02, 0x34B2, 0x44EA, [0x9A, 0x7C, 0x45, 0xAE, 0xA9, 0xC6, 0xFD, 0x6D]);
interface IWICColorContext : IUnknown
{
    HRESULT InitializeFromFilename(const(wchar)* wzFilename);
    HRESULT InitializeFromMemory(char* pbBuffer, uint cbBufferSize);
    HRESULT InitializeFromExifColorSpace(uint value);
    HRESULT GetType(WICColorContextType* pType);
    HRESULT GetProfileBytes(uint cbBuffer, char* pbBuffer, uint* pcbActual);
    HRESULT GetExifColorSpace(uint* pValue);
}

const GUID IID_IWICColorTransform = {0xB66F034F, 0xD0E2, 0x40AB, [0xB4, 0x36, 0x6D, 0xE3, 0x9E, 0x32, 0x1A, 0x94]};
@GUID(0xB66F034F, 0xD0E2, 0x40AB, [0xB4, 0x36, 0x6D, 0xE3, 0x9E, 0x32, 0x1A, 0x94]);
interface IWICColorTransform : IWICBitmapSource
{
    HRESULT Initialize(IWICBitmapSource pIBitmapSource, IWICColorContext pIContextSource, IWICColorContext pIContextDest, Guid* pixelFmtDest);
}

const GUID IID_IWICFastMetadataEncoder = {0xB84E2C09, 0x78C9, 0x4AC4, [0x8B, 0xD3, 0x52, 0x4A, 0xE1, 0x66, 0x3A, 0x2F]};
@GUID(0xB84E2C09, 0x78C9, 0x4AC4, [0x8B, 0xD3, 0x52, 0x4A, 0xE1, 0x66, 0x3A, 0x2F]);
interface IWICFastMetadataEncoder : IUnknown
{
    HRESULT Commit();
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

const GUID IID_IWICStream = {0x135FF860, 0x22B7, 0x4DDF, [0xB0, 0xF6, 0x21, 0x8F, 0x4F, 0x29, 0x9A, 0x43]};
@GUID(0x135FF860, 0x22B7, 0x4DDF, [0xB0, 0xF6, 0x21, 0x8F, 0x4F, 0x29, 0x9A, 0x43]);
interface IWICStream : IStream
{
    HRESULT InitializeFromIStream(IStream pIStream);
    HRESULT InitializeFromFilename(const(wchar)* wzFileName, uint dwDesiredAccess);
    HRESULT InitializeFromMemory(char* pbBuffer, uint cbBufferSize);
    HRESULT InitializeFromIStreamRegion(IStream pIStream, ULARGE_INTEGER ulOffset, ULARGE_INTEGER ulMaxSize);
}

const GUID IID_IWICEnumMetadataItem = {0xDC2BB46D, 0x3F07, 0x481E, [0x86, 0x25, 0x22, 0x0C, 0x4A, 0xED, 0xBB, 0x33]};
@GUID(0xDC2BB46D, 0x3F07, 0x481E, [0x86, 0x25, 0x22, 0x0C, 0x4A, 0xED, 0xBB, 0x33]);
interface IWICEnumMetadataItem : IUnknown
{
    HRESULT Next(uint celt, char* rgeltSchema, char* rgeltId, char* rgeltValue, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IWICEnumMetadataItem* ppIEnumMetadataItem);
}

const GUID IID_IWICMetadataQueryReader = {0x30989668, 0xE1C9, 0x4597, [0xB3, 0x95, 0x45, 0x8E, 0xED, 0xB8, 0x08, 0xDF]};
@GUID(0x30989668, 0xE1C9, 0x4597, [0xB3, 0x95, 0x45, 0x8E, 0xED, 0xB8, 0x08, 0xDF]);
interface IWICMetadataQueryReader : IUnknown
{
    HRESULT GetContainerFormat(Guid* pguidContainerFormat);
    HRESULT GetLocation(uint cchMaxLength, char* wzNamespace, uint* pcchActualLength);
    HRESULT GetMetadataByName(const(wchar)* wzName, PROPVARIANT* pvarValue);
    HRESULT GetEnumerator(IEnumString* ppIEnumString);
}

const GUID IID_IWICMetadataQueryWriter = {0xA721791A, 0x0DEF, 0x4D06, [0xBD, 0x91, 0x21, 0x18, 0xBF, 0x1D, 0xB1, 0x0B]};
@GUID(0xA721791A, 0x0DEF, 0x4D06, [0xBD, 0x91, 0x21, 0x18, 0xBF, 0x1D, 0xB1, 0x0B]);
interface IWICMetadataQueryWriter : IWICMetadataQueryReader
{
    HRESULT SetMetadataByName(const(wchar)* wzName, const(PROPVARIANT)* pvarValue);
    HRESULT RemoveMetadataByName(const(wchar)* wzName);
}

const GUID IID_IWICBitmapEncoder = {0x00000103, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]};
@GUID(0x00000103, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]);
interface IWICBitmapEncoder : IUnknown
{
    HRESULT Initialize(IStream pIStream, WICBitmapEncoderCacheOption cacheOption);
    HRESULT GetContainerFormat(Guid* pguidContainerFormat);
    HRESULT GetEncoderInfo(IWICBitmapEncoderInfo* ppIEncoderInfo);
    HRESULT SetColorContexts(uint cCount, char* ppIColorContext);
    HRESULT SetPalette(IWICPalette pIPalette);
    HRESULT SetThumbnail(IWICBitmapSource pIThumbnail);
    HRESULT SetPreview(IWICBitmapSource pIPreview);
    HRESULT CreateNewFrame(IWICBitmapFrameEncode* ppIFrameEncode, IPropertyBag2* ppIEncoderOptions);
    HRESULT Commit();
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

const GUID IID_IWICBitmapFrameEncode = {0x00000105, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]};
@GUID(0x00000105, 0xA8F2, 0x4877, [0xBA, 0x0A, 0xFD, 0x2B, 0x66, 0x45, 0xFB, 0x94]);
interface IWICBitmapFrameEncode : IUnknown
{
    HRESULT Initialize(IPropertyBag2 pIEncoderOptions);
    HRESULT SetSize(uint uiWidth, uint uiHeight);
    HRESULT SetResolution(double dpiX, double dpiY);
    HRESULT SetPixelFormat(Guid* pPixelFormat);
    HRESULT SetColorContexts(uint cCount, char* ppIColorContext);
    HRESULT SetPalette(IWICPalette pIPalette);
    HRESULT SetThumbnail(IWICBitmapSource pIThumbnail);
    HRESULT WritePixels(uint lineCount, uint cbStride, uint cbBufferSize, char* pbPixels);
    HRESULT WriteSource(IWICBitmapSource pIBitmapSource, WICRect* prc);
    HRESULT Commit();
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

const GUID IID_IWICPlanarBitmapFrameEncode = {0xF928B7B8, 0x2221, 0x40C1, [0xB7, 0x2E, 0x7E, 0x82, 0xF1, 0x97, 0x4D, 0x1A]};
@GUID(0xF928B7B8, 0x2221, 0x40C1, [0xB7, 0x2E, 0x7E, 0x82, 0xF1, 0x97, 0x4D, 0x1A]);
interface IWICPlanarBitmapFrameEncode : IUnknown
{
    HRESULT WritePixels(uint lineCount, char* pPlanes, uint cPlanes);
    HRESULT WriteSource(char* ppPlanes, uint cPlanes, WICRect* prcSource);
}

const GUID IID_IWICImageEncoder = {0x04C75BF8, 0x3CE1, 0x473B, [0xAC, 0xC5, 0x3C, 0xC4, 0xF5, 0xE9, 0x49, 0x99]};
@GUID(0x04C75BF8, 0x3CE1, 0x473B, [0xAC, 0xC5, 0x3C, 0xC4, 0xF5, 0xE9, 0x49, 0x99]);
interface IWICImageEncoder : IUnknown
{
    HRESULT WriteFrame(ID2D1Image pImage, IWICBitmapFrameEncode pFrameEncode, const(WICImageParameters)* pImageParameters);
    HRESULT WriteFrameThumbnail(ID2D1Image pImage, IWICBitmapFrameEncode pFrameEncode, const(WICImageParameters)* pImageParameters);
    HRESULT WriteThumbnail(ID2D1Image pImage, IWICBitmapEncoder pEncoder, const(WICImageParameters)* pImageParameters);
}

const GUID IID_IWICBitmapDecoder = {0x9EDDE9E7, 0x8DEE, 0x47EA, [0x99, 0xDF, 0xE6, 0xFA, 0xF2, 0xED, 0x44, 0xBF]};
@GUID(0x9EDDE9E7, 0x8DEE, 0x47EA, [0x99, 0xDF, 0xE6, 0xFA, 0xF2, 0xED, 0x44, 0xBF]);
interface IWICBitmapDecoder : IUnknown
{
    HRESULT QueryCapability(IStream pIStream, uint* pdwCapability);
    HRESULT Initialize(IStream pIStream, WICDecodeOptions cacheOptions);
    HRESULT GetContainerFormat(Guid* pguidContainerFormat);
    HRESULT GetDecoderInfo(IWICBitmapDecoderInfo* ppIDecoderInfo);
    HRESULT CopyPalette(IWICPalette pIPalette);
    HRESULT GetMetadataQueryReader(IWICMetadataQueryReader* ppIMetadataQueryReader);
    HRESULT GetPreview(IWICBitmapSource* ppIBitmapSource);
    HRESULT GetColorContexts(uint cCount, char* ppIColorContexts, uint* pcActualCount);
    HRESULT GetThumbnail(IWICBitmapSource* ppIThumbnail);
    HRESULT GetFrameCount(uint* pCount);
    HRESULT GetFrame(uint index, IWICBitmapFrameDecode* ppIBitmapFrame);
}

const GUID IID_IWICBitmapSourceTransform = {0x3B16811B, 0x6A43, 0x4EC9, [0xB7, 0x13, 0x3D, 0x5A, 0x0C, 0x13, 0xB9, 0x40]};
@GUID(0x3B16811B, 0x6A43, 0x4EC9, [0xB7, 0x13, 0x3D, 0x5A, 0x0C, 0x13, 0xB9, 0x40]);
interface IWICBitmapSourceTransform : IUnknown
{
    HRESULT CopyPixels(const(WICRect)* prc, uint uiWidth, uint uiHeight, Guid* pguidDstFormat, WICBitmapTransformOptions dstTransform, uint nStride, uint cbBufferSize, char* pbBuffer);
    HRESULT GetClosestSize(uint* puiWidth, uint* puiHeight);
    HRESULT GetClosestPixelFormat(Guid* pguidDstFormat);
    HRESULT DoesSupportTransform(WICBitmapTransformOptions dstTransform, int* pfIsSupported);
}

const GUID IID_IWICPlanarBitmapSourceTransform = {0x3AFF9CCE, 0xBE95, 0x4303, [0xB9, 0x27, 0xE7, 0xD1, 0x6F, 0xF4, 0xA6, 0x13]};
@GUID(0x3AFF9CCE, 0xBE95, 0x4303, [0xB9, 0x27, 0xE7, 0xD1, 0x6F, 0xF4, 0xA6, 0x13]);
interface IWICPlanarBitmapSourceTransform : IUnknown
{
    HRESULT DoesSupportTransform(uint* puiWidth, uint* puiHeight, WICBitmapTransformOptions dstTransform, WICPlanarOptions dstPlanarOptions, char* pguidDstFormats, char* pPlaneDescriptions, uint cPlanes, int* pfIsSupported);
    HRESULT CopyPixels(const(WICRect)* prcSource, uint uiWidth, uint uiHeight, WICBitmapTransformOptions dstTransform, WICPlanarOptions dstPlanarOptions, char* pDstPlanes, uint cPlanes);
}

const GUID IID_IWICBitmapFrameDecode = {0x3B16811B, 0x6A43, 0x4EC9, [0xA8, 0x13, 0x3D, 0x93, 0x0C, 0x13, 0xB9, 0x40]};
@GUID(0x3B16811B, 0x6A43, 0x4EC9, [0xA8, 0x13, 0x3D, 0x93, 0x0C, 0x13, 0xB9, 0x40]);
interface IWICBitmapFrameDecode : IWICBitmapSource
{
    HRESULT GetMetadataQueryReader(IWICMetadataQueryReader* ppIMetadataQueryReader);
    HRESULT GetColorContexts(uint cCount, char* ppIColorContexts, uint* pcActualCount);
    HRESULT GetThumbnail(IWICBitmapSource* ppIThumbnail);
}

const GUID IID_IWICProgressiveLevelControl = {0xDAAC296F, 0x7AA5, 0x4DBF, [0x8D, 0x15, 0x22, 0x5C, 0x59, 0x76, 0xF8, 0x91]};
@GUID(0xDAAC296F, 0x7AA5, 0x4DBF, [0x8D, 0x15, 0x22, 0x5C, 0x59, 0x76, 0xF8, 0x91]);
interface IWICProgressiveLevelControl : IUnknown
{
    HRESULT GetLevelCount(uint* pcLevels);
    HRESULT GetCurrentLevel(uint* pnLevel);
    HRESULT SetCurrentLevel(uint nLevel);
}

const GUID IID_IWICProgressCallback = {0x4776F9CD, 0x9517, 0x45FA, [0xBF, 0x24, 0xE8, 0x9C, 0x5E, 0xC5, 0xC6, 0x0C]};
@GUID(0x4776F9CD, 0x9517, 0x45FA, [0xBF, 0x24, 0xE8, 0x9C, 0x5E, 0xC5, 0xC6, 0x0C]);
interface IWICProgressCallback : IUnknown
{
    HRESULT Notify(uint uFrameNum, WICProgressOperation operation, double dblProgress);
}

alias PFNProgressNotification = extern(Windows) HRESULT function(void* pvData, uint uFrameNum, WICProgressOperation operation, double dblProgress);
const GUID IID_IWICBitmapCodecProgressNotification = {0x64C1024E, 0xC3CF, 0x4462, [0x80, 0x78, 0x88, 0xC2, 0xB1, 0x1C, 0x46, 0xD9]};
@GUID(0x64C1024E, 0xC3CF, 0x4462, [0x80, 0x78, 0x88, 0xC2, 0xB1, 0x1C, 0x46, 0xD9]);
interface IWICBitmapCodecProgressNotification : IUnknown
{
    HRESULT RegisterProgressNotification(PFNProgressNotification pfnProgressNotification, void* pvData, uint dwProgressFlags);
}

const GUID IID_IWICComponentInfo = {0x23BC3F0A, 0x698B, 0x4357, [0x88, 0x6B, 0xF2, 0x4D, 0x50, 0x67, 0x13, 0x34]};
@GUID(0x23BC3F0A, 0x698B, 0x4357, [0x88, 0x6B, 0xF2, 0x4D, 0x50, 0x67, 0x13, 0x34]);
interface IWICComponentInfo : IUnknown
{
    HRESULT GetComponentType(WICComponentType* pType);
    HRESULT GetCLSID(Guid* pclsid);
    HRESULT GetSigningStatus(uint* pStatus);
    HRESULT GetAuthor(uint cchAuthor, char* wzAuthor, uint* pcchActual);
    HRESULT GetVendorGUID(Guid* pguidVendor);
    HRESULT GetVersion(uint cchVersion, char* wzVersion, uint* pcchActual);
    HRESULT GetSpecVersion(uint cchSpecVersion, char* wzSpecVersion, uint* pcchActual);
    HRESULT GetFriendlyName(uint cchFriendlyName, char* wzFriendlyName, uint* pcchActual);
}

const GUID IID_IWICFormatConverterInfo = {0x9F34FB65, 0x13F4, 0x4F15, [0xBC, 0x57, 0x37, 0x26, 0xB5, 0xE5, 0x3D, 0x9F]};
@GUID(0x9F34FB65, 0x13F4, 0x4F15, [0xBC, 0x57, 0x37, 0x26, 0xB5, 0xE5, 0x3D, 0x9F]);
interface IWICFormatConverterInfo : IWICComponentInfo
{
    HRESULT GetPixelFormats(uint cFormats, char* pPixelFormatGUIDs, uint* pcActual);
    HRESULT CreateInstance(IWICFormatConverter* ppIConverter);
}

const GUID IID_IWICBitmapCodecInfo = {0xE87A44C4, 0xB76E, 0x4C47, [0x8B, 0x09, 0x29, 0x8E, 0xB1, 0x2A, 0x27, 0x14]};
@GUID(0xE87A44C4, 0xB76E, 0x4C47, [0x8B, 0x09, 0x29, 0x8E, 0xB1, 0x2A, 0x27, 0x14]);
interface IWICBitmapCodecInfo : IWICComponentInfo
{
    HRESULT GetContainerFormat(Guid* pguidContainerFormat);
    HRESULT GetPixelFormats(uint cFormats, char* pguidPixelFormats, uint* pcActual);
    HRESULT GetColorManagementVersion(uint cchColorManagementVersion, char* wzColorManagementVersion, uint* pcchActual);
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

const GUID IID_IWICBitmapEncoderInfo = {0x94C9B4EE, 0xA09F, 0x4F92, [0x8A, 0x1E, 0x4A, 0x9B, 0xCE, 0x7E, 0x76, 0xFB]};
@GUID(0x94C9B4EE, 0xA09F, 0x4F92, [0x8A, 0x1E, 0x4A, 0x9B, 0xCE, 0x7E, 0x76, 0xFB]);
interface IWICBitmapEncoderInfo : IWICBitmapCodecInfo
{
    HRESULT CreateInstance(IWICBitmapEncoder* ppIBitmapEncoder);
}

const GUID IID_IWICBitmapDecoderInfo = {0xD8CD007F, 0xD08F, 0x4191, [0x9B, 0xFC, 0x23, 0x6E, 0xA7, 0xF0, 0xE4, 0xB5]};
@GUID(0xD8CD007F, 0xD08F, 0x4191, [0x9B, 0xFC, 0x23, 0x6E, 0xA7, 0xF0, 0xE4, 0xB5]);
interface IWICBitmapDecoderInfo : IWICBitmapCodecInfo
{
    HRESULT GetPatterns(uint cbSizePatterns, char* pPatterns, uint* pcPatterns, uint* pcbPatternsActual);
    HRESULT MatchesPattern(IStream pIStream, int* pfMatches);
    HRESULT CreateInstance(IWICBitmapDecoder* ppIBitmapDecoder);
}

const GUID IID_IWICPixelFormatInfo = {0xE8EDA601, 0x3D48, 0x431A, [0xAB, 0x44, 0x69, 0x05, 0x9B, 0xE8, 0x8B, 0xBE]};
@GUID(0xE8EDA601, 0x3D48, 0x431A, [0xAB, 0x44, 0x69, 0x05, 0x9B, 0xE8, 0x8B, 0xBE]);
interface IWICPixelFormatInfo : IWICComponentInfo
{
    HRESULT GetFormatGUID(Guid* pFormat);
    HRESULT GetColorContext(IWICColorContext* ppIColorContext);
    HRESULT GetBitsPerPixel(uint* puiBitsPerPixel);
    HRESULT GetChannelCount(uint* puiChannelCount);
    HRESULT GetChannelMask(uint uiChannelIndex, uint cbMaskBuffer, char* pbMaskBuffer, uint* pcbActual);
}

const GUID IID_IWICPixelFormatInfo2 = {0xA9DB33A2, 0xAF5F, 0x43C7, [0xB6, 0x79, 0x74, 0xF5, 0x98, 0x4B, 0x5A, 0xA4]};
@GUID(0xA9DB33A2, 0xAF5F, 0x43C7, [0xB6, 0x79, 0x74, 0xF5, 0x98, 0x4B, 0x5A, 0xA4]);
interface IWICPixelFormatInfo2 : IWICPixelFormatInfo
{
    HRESULT SupportsTransparency(int* pfSupportsTransparency);
    HRESULT GetNumericRepresentation(WICPixelFormatNumericRepresentation* pNumericRepresentation);
}

const GUID IID_IWICImagingFactory = {0xEC5EC8A9, 0xC395, 0x4314, [0x9C, 0x77, 0x54, 0xD7, 0xA9, 0x35, 0xFF, 0x70]};
@GUID(0xEC5EC8A9, 0xC395, 0x4314, [0x9C, 0x77, 0x54, 0xD7, 0xA9, 0x35, 0xFF, 0x70]);
interface IWICImagingFactory : IUnknown
{
    HRESULT CreateDecoderFromFilename(const(wchar)* wzFilename, const(Guid)* pguidVendor, uint dwDesiredAccess, WICDecodeOptions metadataOptions, IWICBitmapDecoder* ppIDecoder);
    HRESULT CreateDecoderFromStream(IStream pIStream, const(Guid)* pguidVendor, WICDecodeOptions metadataOptions, IWICBitmapDecoder* ppIDecoder);
    HRESULT CreateDecoderFromFileHandle(uint hFile, const(Guid)* pguidVendor, WICDecodeOptions metadataOptions, IWICBitmapDecoder* ppIDecoder);
    HRESULT CreateComponentInfo(const(Guid)* clsidComponent, IWICComponentInfo* ppIInfo);
    HRESULT CreateDecoder(const(Guid)* guidContainerFormat, const(Guid)* pguidVendor, IWICBitmapDecoder* ppIDecoder);
    HRESULT CreateEncoder(const(Guid)* guidContainerFormat, const(Guid)* pguidVendor, IWICBitmapEncoder* ppIEncoder);
    HRESULT CreatePalette(IWICPalette* ppIPalette);
    HRESULT CreateFormatConverter(IWICFormatConverter* ppIFormatConverter);
    HRESULT CreateBitmapScaler(IWICBitmapScaler* ppIBitmapScaler);
    HRESULT CreateBitmapClipper(IWICBitmapClipper* ppIBitmapClipper);
    HRESULT CreateBitmapFlipRotator(IWICBitmapFlipRotator* ppIBitmapFlipRotator);
    HRESULT CreateStream(IWICStream* ppIWICStream);
    HRESULT CreateColorContext(IWICColorContext* ppIWICColorContext);
    HRESULT CreateColorTransformer(IWICColorTransform* ppIWICColorTransform);
    HRESULT CreateBitmap(uint uiWidth, uint uiHeight, Guid* pixelFormat, WICBitmapCreateCacheOption option, IWICBitmap* ppIBitmap);
    HRESULT CreateBitmapFromSource(IWICBitmapSource pIBitmapSource, WICBitmapCreateCacheOption option, IWICBitmap* ppIBitmap);
    HRESULT CreateBitmapFromSourceRect(IWICBitmapSource pIBitmapSource, uint x, uint y, uint width, uint height, IWICBitmap* ppIBitmap);
    HRESULT CreateBitmapFromMemory(uint uiWidth, uint uiHeight, Guid* pixelFormat, uint cbStride, uint cbBufferSize, char* pbBuffer, IWICBitmap* ppIBitmap);
    HRESULT CreateBitmapFromHBITMAP(HBITMAP hBitmap, HPALETTE hPalette, WICBitmapAlphaChannelOption options, IWICBitmap* ppIBitmap);
    HRESULT CreateBitmapFromHICON(HICON hIcon, IWICBitmap* ppIBitmap);
    HRESULT CreateComponentEnumerator(uint componentTypes, uint options, IEnumUnknown* ppIEnumUnknown);
    HRESULT CreateFastMetadataEncoderFromDecoder(IWICBitmapDecoder pIDecoder, IWICFastMetadataEncoder* ppIFastEncoder);
    HRESULT CreateFastMetadataEncoderFromFrameDecode(IWICBitmapFrameDecode pIFrameDecoder, IWICFastMetadataEncoder* ppIFastEncoder);
    HRESULT CreateQueryWriter(const(Guid)* guidMetadataFormat, const(Guid)* pguidVendor, IWICMetadataQueryWriter* ppIQueryWriter);
    HRESULT CreateQueryWriterFromReader(IWICMetadataQueryReader pIQueryReader, const(Guid)* pguidVendor, IWICMetadataQueryWriter* ppIQueryWriter);
}

const GUID IID_IWICImagingFactory2 = {0x7B816B45, 0x1996, 0x4476, [0xB1, 0x32, 0xDE, 0x9E, 0x24, 0x7C, 0x8A, 0xF0]};
@GUID(0x7B816B45, 0x1996, 0x4476, [0xB1, 0x32, 0xDE, 0x9E, 0x24, 0x7C, 0x8A, 0xF0]);
interface IWICImagingFactory2 : IWICImagingFactory
{
    HRESULT CreateImageEncoder(ID2D1Device pD2DDevice, IWICImageEncoder* ppWICImageEncoder);
}

enum WICTiffCompressionOption
{
    WICTiffCompressionDontCare = 0,
    WICTiffCompressionNone = 1,
    WICTiffCompressionCCITT3 = 2,
    WICTiffCompressionCCITT4 = 3,
    WICTiffCompressionLZW = 4,
    WICTiffCompressionRLE = 5,
    WICTiffCompressionZIP = 6,
    WICTiffCompressionLZWHDifferencing = 7,
    WICTIFFCOMPRESSIONOPTION_FORCE_DWORD = 2147483647,
}

enum WICJpegYCrCbSubsamplingOption
{
    WICJpegYCrCbSubsamplingDefault = 0,
    WICJpegYCrCbSubsampling420 = 1,
    WICJpegYCrCbSubsampling422 = 2,
    WICJpegYCrCbSubsampling444 = 3,
    WICJpegYCrCbSubsampling440 = 4,
    WICJPEGYCRCBSUBSAMPLING_FORCE_DWORD = 2147483647,
}

enum WICPngFilterOption
{
    WICPngFilterUnspecified = 0,
    WICPngFilterNone = 1,
    WICPngFilterSub = 2,
    WICPngFilterUp = 3,
    WICPngFilterAverage = 4,
    WICPngFilterPaeth = 5,
    WICPngFilterAdaptive = 6,
    WICPNGFILTEROPTION_FORCE_DWORD = 2147483647,
}

enum WICNamedWhitePoint
{
    WICWhitePointDefault = 1,
    WICWhitePointDaylight = 2,
    WICWhitePointCloudy = 4,
    WICWhitePointShade = 8,
    WICWhitePointTungsten = 16,
    WICWhitePointFluorescent = 32,
    WICWhitePointFlash = 64,
    WICWhitePointUnderwater = 128,
    WICWhitePointCustom = 256,
    WICWhitePointAutoWhiteBalance = 512,
    WICWhitePointAsShot = 1,
    WICNAMEDWHITEPOINT_FORCE_DWORD = 2147483647,
}

enum WICRawCapabilities
{
    WICRawCapabilityNotSupported = 0,
    WICRawCapabilityGetSupported = 1,
    WICRawCapabilityFullySupported = 2,
    WICRAWCAPABILITIES_FORCE_DWORD = 2147483647,
}

enum WICRawRotationCapabilities
{
    WICRawRotationCapabilityNotSupported = 0,
    WICRawRotationCapabilityGetSupported = 1,
    WICRawRotationCapabilityNinetyDegreesSupported = 2,
    WICRawRotationCapabilityFullySupported = 3,
    WICRAWROTATIONCAPABILITIES_FORCE_DWORD = 2147483647,
}

struct WICRawCapabilitiesInfo
{
    uint cbSize;
    uint CodecMajorVersion;
    uint CodecMinorVersion;
    WICRawCapabilities ExposureCompensationSupport;
    WICRawCapabilities ContrastSupport;
    WICRawCapabilities RGBWhitePointSupport;
    WICRawCapabilities NamedWhitePointSupport;
    uint NamedWhitePointSupportMask;
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

enum WICRawParameterSet
{
    WICAsShotParameterSet = 1,
    WICUserAdjustedParameterSet = 2,
    WICAutoAdjustedParameterSet = 3,
    WICRAWPARAMETERSET_FORCE_DWORD = 2147483647,
}

enum WICRawRenderMode
{
    WICRawRenderModeDraft = 1,
    WICRawRenderModeNormal = 2,
    WICRawRenderModeBestQuality = 3,
    WICRAWRENDERMODE_FORCE_DWORD = 2147483647,
}

struct WICRawToneCurvePoint
{
    double Input;
    double Output;
}

struct WICRawToneCurve
{
    uint cPoints;
    WICRawToneCurvePoint aPoints;
}

const GUID IID_IWICDevelopRawNotificationCallback = {0x95C75A6E, 0x3E8C, 0x4EC2, [0x85, 0xA8, 0xAE, 0xBC, 0xC5, 0x51, 0xE5, 0x9B]};
@GUID(0x95C75A6E, 0x3E8C, 0x4EC2, [0x85, 0xA8, 0xAE, 0xBC, 0xC5, 0x51, 0xE5, 0x9B]);
interface IWICDevelopRawNotificationCallback : IUnknown
{
    HRESULT Notify(uint NotificationMask);
}

const GUID IID_IWICDevelopRaw = {0xFBEC5E44, 0xF7BE, 0x4B65, [0xB7, 0xF8, 0xC0, 0xC8, 0x1F, 0xEF, 0x02, 0x6D]};
@GUID(0xFBEC5E44, 0xF7BE, 0x4B65, [0xB7, 0xF8, 0xC0, 0xC8, 0x1F, 0xEF, 0x02, 0x6D]);
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

enum WICDdsDimension
{
    WICDdsTexture1D = 0,
    WICDdsTexture2D = 1,
    WICDdsTexture3D = 2,
    WICDdsTextureCube = 3,
    WICDDSTEXTURE_FORCE_DWORD = 2147483647,
}

enum WICDdsAlphaMode
{
    WICDdsAlphaModeUnknown = 0,
    WICDdsAlphaModeStraight = 1,
    WICDdsAlphaModePremultiplied = 2,
    WICDdsAlphaModeOpaque = 3,
    WICDdsAlphaModeCustom = 4,
    WICDDSALPHAMODE_FORCE_DWORD = 2147483647,
}

struct WICDdsParameters
{
    uint Width;
    uint Height;
    uint Depth;
    uint MipLevels;
    uint ArraySize;
    DXGI_FORMAT DxgiFormat;
    WICDdsDimension Dimension;
    WICDdsAlphaMode AlphaMode;
}

const GUID IID_IWICDdsDecoder = {0x409CD537, 0x8532, 0x40CB, [0x97, 0x74, 0xE2, 0xFE, 0xB2, 0xDF, 0x4E, 0x9C]};
@GUID(0x409CD537, 0x8532, 0x40CB, [0x97, 0x74, 0xE2, 0xFE, 0xB2, 0xDF, 0x4E, 0x9C]);
interface IWICDdsDecoder : IUnknown
{
    HRESULT GetParameters(WICDdsParameters* pParameters);
    HRESULT GetFrame(uint arrayIndex, uint mipLevel, uint sliceIndex, IWICBitmapFrameDecode* ppIBitmapFrame);
}

const GUID IID_IWICDdsEncoder = {0x5CACDB4C, 0x407E, 0x41B3, [0xB9, 0x36, 0xD0, 0xF0, 0x10, 0xCD, 0x67, 0x32]};
@GUID(0x5CACDB4C, 0x407E, 0x41B3, [0xB9, 0x36, 0xD0, 0xF0, 0x10, 0xCD, 0x67, 0x32]);
interface IWICDdsEncoder : IUnknown
{
    HRESULT SetParameters(WICDdsParameters* pParameters);
    HRESULT GetParameters(WICDdsParameters* pParameters);
    HRESULT CreateNewFrame(IWICBitmapFrameEncode* ppIFrameEncode, uint* pArrayIndex, uint* pMipLevel, uint* pSliceIndex);
}

struct WICDdsFormatInfo
{
    DXGI_FORMAT DxgiFormat;
    uint BytesPerBlock;
    uint BlockWidth;
    uint BlockHeight;
}

const GUID IID_IWICDdsFrameDecode = {0x3D4C0C61, 0x18A4, 0x41E4, [0xBD, 0x80, 0x48, 0x1A, 0x4F, 0xC9, 0xF4, 0x64]};
@GUID(0x3D4C0C61, 0x18A4, 0x41E4, [0xBD, 0x80, 0x48, 0x1A, 0x4F, 0xC9, 0xF4, 0x64]);
interface IWICDdsFrameDecode : IUnknown
{
    HRESULT GetSizeInBlocks(uint* pWidthInBlocks, uint* pHeightInBlocks);
    HRESULT GetFormatInfo(WICDdsFormatInfo* pFormatInfo);
    HRESULT CopyBlocks(const(WICRect)* prcBoundsInBlocks, uint cbStride, uint cbBufferSize, char* pbBuffer);
}

const GUID IID_IWICJpegFrameDecode = {0x8939F66E, 0xC46A, 0x4C21, [0xA9, 0xD1, 0x98, 0xB3, 0x27, 0xCE, 0x16, 0x79]};
@GUID(0x8939F66E, 0xC46A, 0x4C21, [0xA9, 0xD1, 0x98, 0xB3, 0x27, 0xCE, 0x16, 0x79]);
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

const GUID IID_IWICJpegFrameEncode = {0x2F0C601F, 0xD2C6, 0x468C, [0xAB, 0xFA, 0x49, 0x49, 0x5D, 0x98, 0x3E, 0xD1]};
@GUID(0x2F0C601F, 0xD2C6, 0x468C, [0xAB, 0xFA, 0x49, 0x49, 0x5D, 0x98, 0x3E, 0xD1]);
interface IWICJpegFrameEncode : IUnknown
{
    HRESULT GetAcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE* pAcHuffmanTable);
    HRESULT GetDcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE* pDcHuffmanTable);
    HRESULT GetQuantizationTable(uint scanIndex, uint tableIndex, DXGI_JPEG_QUANTIZATION_TABLE* pQuantizationTable);
    HRESULT WriteScan(uint cbScanData, char* pbScanData);
}

enum WICMetadataCreationOptions
{
    WICMetadataCreationDefault = 0,
    WICMetadataCreationAllowUnknown = 0,
    WICMetadataCreationFailUnknown = 65536,
    WICMetadataCreationMask = -65536,
}

enum WICPersistOptions
{
    WICPersistOptionDefault = 0,
    WICPersistOptionLittleEndian = 0,
    WICPersistOptionBigEndian = 1,
    WICPersistOptionStrictFormat = 2,
    WICPersistOptionNoCacheStream = 4,
    WICPersistOptionPreferUTF8 = 8,
    WICPersistOptionMask = 65535,
}

const GUID IID_IWICMetadataBlockReader = {0xFEAA2A8D, 0xB3F3, 0x43E4, [0xB2, 0x5C, 0xD1, 0xDE, 0x99, 0x0A, 0x1A, 0xE1]};
@GUID(0xFEAA2A8D, 0xB3F3, 0x43E4, [0xB2, 0x5C, 0xD1, 0xDE, 0x99, 0x0A, 0x1A, 0xE1]);
interface IWICMetadataBlockReader : IUnknown
{
    HRESULT GetContainerFormat(Guid* pguidContainerFormat);
    HRESULT GetCount(uint* pcCount);
    HRESULT GetReaderByIndex(uint nIndex, IWICMetadataReader* ppIMetadataReader);
    HRESULT GetEnumerator(IEnumUnknown* ppIEnumMetadata);
}

const GUID IID_IWICMetadataBlockWriter = {0x08FB9676, 0xB444, 0x41E8, [0x8D, 0xBE, 0x6A, 0x53, 0xA5, 0x42, 0xBF, 0xF1]};
@GUID(0x08FB9676, 0xB444, 0x41E8, [0x8D, 0xBE, 0x6A, 0x53, 0xA5, 0x42, 0xBF, 0xF1]);
interface IWICMetadataBlockWriter : IWICMetadataBlockReader
{
    HRESULT InitializeFromBlockReader(IWICMetadataBlockReader pIMDBlockReader);
    HRESULT GetWriterByIndex(uint nIndex, IWICMetadataWriter* ppIMetadataWriter);
    HRESULT AddWriter(IWICMetadataWriter pIMetadataWriter);
    HRESULT SetWriterByIndex(uint nIndex, IWICMetadataWriter pIMetadataWriter);
    HRESULT RemoveWriterByIndex(uint nIndex);
}

const GUID IID_IWICMetadataReader = {0x9204FE99, 0xD8FC, 0x4FD5, [0xA0, 0x01, 0x95, 0x36, 0xB0, 0x67, 0xA8, 0x99]};
@GUID(0x9204FE99, 0xD8FC, 0x4FD5, [0xA0, 0x01, 0x95, 0x36, 0xB0, 0x67, 0xA8, 0x99]);
interface IWICMetadataReader : IUnknown
{
    HRESULT GetMetadataFormat(Guid* pguidMetadataFormat);
    HRESULT GetMetadataHandlerInfo(IWICMetadataHandlerInfo* ppIHandler);
    HRESULT GetCount(uint* pcCount);
    HRESULT GetValueByIndex(uint nIndex, PROPVARIANT* pvarSchema, PROPVARIANT* pvarId, PROPVARIANT* pvarValue);
    HRESULT GetValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, PROPVARIANT* pvarValue);
    HRESULT GetEnumerator(IWICEnumMetadataItem* ppIEnumMetadata);
}

const GUID IID_IWICMetadataWriter = {0xF7836E16, 0x3BE0, 0x470B, [0x86, 0xBB, 0x16, 0x0D, 0x0A, 0xEC, 0xD7, 0xDE]};
@GUID(0xF7836E16, 0x3BE0, 0x470B, [0x86, 0xBB, 0x16, 0x0D, 0x0A, 0xEC, 0xD7, 0xDE]);
interface IWICMetadataWriter : IWICMetadataReader
{
    HRESULT SetValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, const(PROPVARIANT)* pvarValue);
    HRESULT SetValueByIndex(uint nIndex, const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, const(PROPVARIANT)* pvarValue);
    HRESULT RemoveValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId);
    HRESULT RemoveValueByIndex(uint nIndex);
}

const GUID IID_IWICStreamProvider = {0x449494BC, 0xB468, 0x4927, [0x96, 0xD7, 0xBA, 0x90, 0xD3, 0x1A, 0xB5, 0x05]};
@GUID(0x449494BC, 0xB468, 0x4927, [0x96, 0xD7, 0xBA, 0x90, 0xD3, 0x1A, 0xB5, 0x05]);
interface IWICStreamProvider : IUnknown
{
    HRESULT GetStream(IStream* ppIStream);
    HRESULT GetPersistOptions(uint* pdwPersistOptions);
    HRESULT GetPreferredVendorGUID(Guid* pguidPreferredVendor);
    HRESULT RefreshStream();
}

const GUID IID_IWICPersistStream = {0x00675040, 0x6908, 0x45F8, [0x86, 0xA3, 0x49, 0xC7, 0xDF, 0xD6, 0xD9, 0xAD]};
@GUID(0x00675040, 0x6908, 0x45F8, [0x86, 0xA3, 0x49, 0xC7, 0xDF, 0xD6, 0xD9, 0xAD]);
interface IWICPersistStream : IPersistStream
{
    HRESULT LoadEx(IStream pIStream, const(Guid)* pguidPreferredVendor, uint dwPersistOptions);
    HRESULT SaveEx(IStream pIStream, uint dwPersistOptions, BOOL fClearDirty);
}

const GUID IID_IWICMetadataHandlerInfo = {0xABA958BF, 0xC672, 0x44D1, [0x8D, 0x61, 0xCE, 0x6D, 0xF2, 0xE6, 0x82, 0xC2]};
@GUID(0xABA958BF, 0xC672, 0x44D1, [0x8D, 0x61, 0xCE, 0x6D, 0xF2, 0xE6, 0x82, 0xC2]);
interface IWICMetadataHandlerInfo : IWICComponentInfo
{
    HRESULT GetMetadataFormat(Guid* pguidMetadataFormat);
    HRESULT GetContainerFormats(uint cContainerFormats, char* pguidContainerFormats, uint* pcchActual);
    HRESULT GetDeviceManufacturer(uint cchDeviceManufacturer, char* wzDeviceManufacturer, uint* pcchActual);
    HRESULT GetDeviceModels(uint cchDeviceModels, char* wzDeviceModels, uint* pcchActual);
    HRESULT DoesRequireFullStream(int* pfRequiresFullStream);
    HRESULT DoesSupportPadding(int* pfSupportsPadding);
    HRESULT DoesRequireFixedSize(int* pfFixedSize);
}

struct WICMetadataPattern
{
    ULARGE_INTEGER Position;
    uint Length;
    ubyte* Pattern;
    ubyte* Mask;
    ULARGE_INTEGER DataOffset;
}

const GUID IID_IWICMetadataReaderInfo = {0xEEBF1F5B, 0x07C1, 0x4447, [0xA3, 0xAB, 0x22, 0xAC, 0xAF, 0x78, 0xA8, 0x04]};
@GUID(0xEEBF1F5B, 0x07C1, 0x4447, [0xA3, 0xAB, 0x22, 0xAC, 0xAF, 0x78, 0xA8, 0x04]);
interface IWICMetadataReaderInfo : IWICMetadataHandlerInfo
{
    HRESULT GetPatterns(const(Guid)* guidContainerFormat, uint cbSize, char* pPattern, uint* pcCount, uint* pcbActual);
    HRESULT MatchesPattern(const(Guid)* guidContainerFormat, IStream pIStream, int* pfMatches);
    HRESULT CreateInstance(IWICMetadataReader* ppIReader);
}

struct WICMetadataHeader
{
    ULARGE_INTEGER Position;
    uint Length;
    ubyte* Header;
    ULARGE_INTEGER DataOffset;
}

const GUID IID_IWICMetadataWriterInfo = {0xB22E3FBA, 0x3925, 0x4323, [0xB5, 0xC1, 0x9E, 0xBF, 0xC4, 0x30, 0xF2, 0x36]};
@GUID(0xB22E3FBA, 0x3925, 0x4323, [0xB5, 0xC1, 0x9E, 0xBF, 0xC4, 0x30, 0xF2, 0x36]);
interface IWICMetadataWriterInfo : IWICMetadataHandlerInfo
{
    HRESULT GetHeader(const(Guid)* guidContainerFormat, uint cbSize, char* pHeader, uint* pcbActual);
    HRESULT CreateInstance(IWICMetadataWriter* ppIWriter);
}

const GUID IID_IWICComponentFactory = {0x412D0C3A, 0x9650, 0x44FA, [0xAF, 0x5B, 0xDD, 0x2A, 0x06, 0xC8, 0xE8, 0xFB]};
@GUID(0x412D0C3A, 0x9650, 0x44FA, [0xAF, 0x5B, 0xDD, 0x2A, 0x06, 0xC8, 0xE8, 0xFB]);
interface IWICComponentFactory : IWICImagingFactory
{
    HRESULT CreateMetadataReader(const(Guid)* guidMetadataFormat, const(Guid)* pguidVendor, uint dwOptions, IStream pIStream, IWICMetadataReader* ppIReader);
    HRESULT CreateMetadataReaderFromContainer(const(Guid)* guidContainerFormat, const(Guid)* pguidVendor, uint dwOptions, IStream pIStream, IWICMetadataReader* ppIReader);
    HRESULT CreateMetadataWriter(const(Guid)* guidMetadataFormat, const(Guid)* pguidVendor, uint dwMetadataOptions, IWICMetadataWriter* ppIWriter);
    HRESULT CreateMetadataWriterFromReader(IWICMetadataReader pIReader, const(Guid)* pguidVendor, IWICMetadataWriter* ppIWriter);
    HRESULT CreateQueryReaderFromBlockReader(IWICMetadataBlockReader pIBlockReader, IWICMetadataQueryReader* ppIQueryReader);
    HRESULT CreateQueryWriterFromBlockWriter(IWICMetadataBlockWriter pIBlockWriter, IWICMetadataQueryWriter* ppIQueryWriter);
    HRESULT CreateEncoderPropertyBag(char* ppropOptions, uint cCount, IPropertyBag2* ppIPropertyBag);
}

@DllImport("WindowsCodecs.dll")
HRESULT WICConvertBitmapSource(Guid* dstFormat, IWICBitmapSource pISrc, IWICBitmapSource* ppIDst);

@DllImport("WindowsCodecs.dll")
HRESULT WICCreateBitmapFromSection(uint width, uint height, Guid* pixelFormat, HANDLE hSection, uint stride, uint offset, IWICBitmap* ppIBitmap);

@DllImport("WindowsCodecs.dll")
HRESULT WICCreateBitmapFromSectionEx(uint width, uint height, Guid* pixelFormat, HANDLE hSection, uint stride, uint offset, WICSectionAccessLevel desiredAccessLevel, IWICBitmap* ppIBitmap);

@DllImport("WindowsCodecs.dll")
HRESULT WICMapGuidToShortName(const(Guid)* guid, uint cchName, char* wzName, uint* pcchActual);

@DllImport("WindowsCodecs.dll")
HRESULT WICMapShortNameToGuid(const(wchar)* wzName, Guid* pguid);

@DllImport("WindowsCodecs.dll")
HRESULT WICMapSchemaToName(const(Guid)* guidMetadataFormat, const(wchar)* pwzSchema, uint cchName, char* wzName, uint* pcchActual);

@DllImport("WindowsCodecs.dll")
HRESULT WICMatchMetadataContent(const(Guid)* guidContainerFormat, const(Guid)* pguidVendor, IStream pIStream, Guid* pguidMetadataFormat);

@DllImport("WindowsCodecs.dll")
HRESULT WICSerializeMetadataContent(const(Guid)* guidContainerFormat, IWICMetadataWriter pIWriter, uint dwPersistOptions, IStream pIStream);

@DllImport("WindowsCodecs.dll")
HRESULT WICGetMetadataContentSize(const(Guid)* guidContainerFormat, IWICMetadataWriter pIWriter, ULARGE_INTEGER* pcbSize);

