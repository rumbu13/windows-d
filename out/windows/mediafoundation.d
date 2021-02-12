module windows.mediafoundation;

public import system;
public import windows.audio;
public import windows.automation;
public import windows.com;
public import windows.coreaudio;
public import windows.direct2d;
public import windows.direct3d11;
public import windows.direct3d12;
public import windows.direct3d9;
public import windows.directshow;
public import windows.displaydevices;
public import windows.dxgi;
public import windows.kernel;
public import windows.multimedia;
public import windows.shell;
public import windows.streamingmedia;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.winrt;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

enum MF_Plugin_Type
{
    MF_Plugin_Type_MFT = 0,
    MF_Plugin_Type_MediaSource = 1,
    MF_Plugin_Type_MFT_MatchOutputType = 2,
    MF_Plugin_Type_Other = -1,
}

struct CodecAPIEventData
{
    Guid guid;
    uint dataLength;
    uint reserved;
}

const GUID IID_ICodecAPI = {0x901DB4C7, 0x31CE, 0x41A2, [0x85, 0xDC, 0x8F, 0xA0, 0xBF, 0x41, 0xB8, 0xDA]};
@GUID(0x901DB4C7, 0x31CE, 0x41A2, [0x85, 0xDC, 0x8F, 0xA0, 0xBF, 0x41, 0xB8, 0xDA]);
interface ICodecAPI : IUnknown
{
    HRESULT IsSupported(const(Guid)* Api);
    HRESULT IsModifiable(const(Guid)* Api);
    HRESULT GetParameterRange(const(Guid)* Api, VARIANT* ValueMin, VARIANT* ValueMax, VARIANT* SteppingDelta);
    HRESULT GetParameterValues(const(Guid)* Api, char* Values, uint* ValuesCount);
    HRESULT GetDefaultValue(const(Guid)* Api, VARIANT* Value);
    HRESULT GetValue(const(Guid)* Api, VARIANT* Value);
    HRESULT SetValue(const(Guid)* Api, VARIANT* Value);
    HRESULT RegisterForEvent(const(Guid)* Api, int userData);
    HRESULT UnregisterForEvent(const(Guid)* Api);
    HRESULT SetAllDefaults();
    HRESULT SetValueWithNotify(const(Guid)* Api, VARIANT* Value, char* ChangedParam, uint* ChangedParamCount);
    HRESULT SetAllDefaultsWithNotify(char* ChangedParam, uint* ChangedParamCount);
    HRESULT GetAllSettings(IStream __MIDL__ICodecAPI0000);
    HRESULT SetAllSettings(IStream __MIDL__ICodecAPI0001);
    HRESULT SetAllSettingsWithNotify(IStream __MIDL__ICodecAPI0002, char* ChangedParam, uint* ChangedParamCount);
}

enum D3D12_VIDEO_FIELD_TYPE
{
    D3D12_VIDEO_FIELD_TYPE_NONE = 0,
    D3D12_VIDEO_FIELD_TYPE_INTERLACED_TOP_FIELD_FIRST = 1,
    D3D12_VIDEO_FIELD_TYPE_INTERLACED_BOTTOM_FIELD_FIRST = 2,
}

enum D3D12_VIDEO_FRAME_STEREO_FORMAT
{
    D3D12_VIDEO_FRAME_STEREO_FORMAT_NONE = 0,
    D3D12_VIDEO_FRAME_STEREO_FORMAT_MONO = 1,
    D3D12_VIDEO_FRAME_STEREO_FORMAT_HORIZONTAL = 2,
    D3D12_VIDEO_FRAME_STEREO_FORMAT_VERTICAL = 3,
    D3D12_VIDEO_FRAME_STEREO_FORMAT_SEPARATE = 4,
}

struct D3D12_VIDEO_FORMAT
{
    DXGI_FORMAT Format;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
}

struct D3D12_VIDEO_SAMPLE
{
    uint Width;
    uint Height;
    D3D12_VIDEO_FORMAT Format;
}

enum D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE
{
    D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE_NONE = 0,
    D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE_FIELD_BASED = 1,
}

enum D3D12_FEATURE_VIDEO
{
    D3D12_FEATURE_VIDEO_DECODE_SUPPORT = 0,
    D3D12_FEATURE_VIDEO_DECODE_PROFILES = 1,
    D3D12_FEATURE_VIDEO_DECODE_FORMATS = 2,
    D3D12_FEATURE_VIDEO_DECODE_CONVERSION_SUPPORT = 3,
    D3D12_FEATURE_VIDEO_PROCESS_SUPPORT = 5,
    D3D12_FEATURE_VIDEO_PROCESS_MAX_INPUT_STREAMS = 6,
    D3D12_FEATURE_VIDEO_PROCESS_REFERENCE_INFO = 7,
    D3D12_FEATURE_VIDEO_DECODER_HEAP_SIZE = 8,
    D3D12_FEATURE_VIDEO_PROCESSOR_SIZE = 9,
    D3D12_FEATURE_VIDEO_DECODE_PROFILE_COUNT = 10,
    D3D12_FEATURE_VIDEO_DECODE_FORMAT_COUNT = 11,
    D3D12_FEATURE_VIDEO_ARCHITECTURE = 17,
    D3D12_FEATURE_VIDEO_DECODE_HISTOGRAM = 18,
    D3D12_FEATURE_VIDEO_FEATURE_AREA_SUPPORT = 19,
    D3D12_FEATURE_VIDEO_MOTION_ESTIMATOR = 20,
    D3D12_FEATURE_VIDEO_MOTION_ESTIMATOR_SIZE = 21,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_COUNT = 22,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMANDS = 23,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_PARAMETER_COUNT = 24,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_PARAMETERS = 25,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_SUPPORT = 26,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_SIZE = 27,
    D3D12_FEATURE_VIDEO_DECODE_PROTECTED_RESOURCES = 28,
    D3D12_FEATURE_VIDEO_PROCESS_PROTECTED_RESOURCES = 29,
    D3D12_FEATURE_VIDEO_MOTION_ESTIMATOR_PROTECTED_RESOURCES = 30,
    D3D12_FEATURE_VIDEO_DECODER_HEAP_SIZE1 = 31,
    D3D12_FEATURE_VIDEO_PROCESSOR_SIZE1 = 32,
}

enum D3D12_BITSTREAM_ENCRYPTION_TYPE
{
    D3D12_BITSTREAM_ENCRYPTION_TYPE_NONE = 0,
}

struct D3D12_VIDEO_DECODE_CONFIGURATION
{
    Guid DecodeProfile;
    D3D12_BITSTREAM_ENCRYPTION_TYPE BitstreamEncryption;
    D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE InterlaceType;
}

struct D3D12_VIDEO_DECODER_DESC
{
    uint NodeMask;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
}

struct D3D12_VIDEO_DECODER_HEAP_DESC
{
    uint NodeMask;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    uint DecodeWidth;
    uint DecodeHeight;
    DXGI_FORMAT Format;
    DXGI_RATIONAL FrameRate;
    uint BitRate;
    uint MaxDecodePictureBufferCount;
}

struct D3D12_VIDEO_SIZE_RANGE
{
    uint MaxWidth;
    uint MaxHeight;
    uint MinWidth;
    uint MinHeight;
}

enum D3D12_VIDEO_PROCESS_FILTER
{
    D3D12_VIDEO_PROCESS_FILTER_BRIGHTNESS = 0,
    D3D12_VIDEO_PROCESS_FILTER_CONTRAST = 1,
    D3D12_VIDEO_PROCESS_FILTER_HUE = 2,
    D3D12_VIDEO_PROCESS_FILTER_SATURATION = 3,
    D3D12_VIDEO_PROCESS_FILTER_NOISE_REDUCTION = 4,
    D3D12_VIDEO_PROCESS_FILTER_EDGE_ENHANCEMENT = 5,
    D3D12_VIDEO_PROCESS_FILTER_ANAMORPHIC_SCALING = 6,
    D3D12_VIDEO_PROCESS_FILTER_STEREO_ADJUSTMENT = 7,
}

enum D3D12_VIDEO_PROCESS_FILTER_FLAGS
{
    D3D12_VIDEO_PROCESS_FILTER_FLAG_NONE = 0,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_BRIGHTNESS = 1,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_CONTRAST = 2,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_HUE = 4,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_SATURATION = 8,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_NOISE_REDUCTION = 16,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_EDGE_ENHANCEMENT = 32,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_ANAMORPHIC_SCALING = 64,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_STEREO_ADJUSTMENT = 128,
}

enum D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS
{
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_NONE = 0,
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_BOB = 1,
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_CUSTOM = -2147483648,
}

struct D3D12_VIDEO_PROCESS_ALPHA_BLENDING
{
    BOOL Enable;
    float Alpha;
}

struct D3D12_VIDEO_PROCESS_LUMA_KEY
{
    BOOL Enable;
    float Lower;
    float Upper;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC
{
    DXGI_FORMAT Format;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
    DXGI_RATIONAL SourceAspectRatio;
    DXGI_RATIONAL DestinationAspectRatio;
    DXGI_RATIONAL FrameRate;
    D3D12_VIDEO_SIZE_RANGE SourceSizeRange;
    D3D12_VIDEO_SIZE_RANGE DestinationSizeRange;
    BOOL EnableOrientation;
    D3D12_VIDEO_PROCESS_FILTER_FLAGS FilterFlags;
    D3D12_VIDEO_FRAME_STEREO_FORMAT StereoFormat;
    D3D12_VIDEO_FIELD_TYPE FieldType;
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS DeinterlaceMode;
    BOOL EnableAlphaBlending;
    D3D12_VIDEO_PROCESS_LUMA_KEY LumaKey;
    uint NumPastFrames;
    uint NumFutureFrames;
    BOOL EnableAutoProcessing;
}

enum D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE
{
    D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_OPAQUE = 0,
    D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_BACKGROUND = 1,
    D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_DESTINATION = 2,
    D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_SOURCE_STREAM = 3,
}

struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC
{
    DXGI_FORMAT Format;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
    D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE AlphaFillMode;
    uint AlphaFillModeSourceStreamIndex;
    float BackgroundColor;
    DXGI_RATIONAL FrameRate;
    BOOL EnableStereo;
}

const GUID IID_ID3D12VideoDecoderHeap = {0x0946B7C9, 0xEBF6, 0x4047, [0xBB, 0x73, 0x86, 0x83, 0xE2, 0x7D, 0xBB, 0x1F]};
@GUID(0x0946B7C9, 0xEBF6, 0x4047, [0xBB, 0x73, 0x86, 0x83, 0xE2, 0x7D, 0xBB, 0x1F]);
interface ID3D12VideoDecoderHeap : ID3D12Pageable
{
    D3D12_VIDEO_DECODER_HEAP_DESC GetDesc();
}

const GUID IID_ID3D12VideoDevice = {0x1F052807, 0x0B46, 0x4ACC, [0x8A, 0x89, 0x36, 0x4F, 0x79, 0x37, 0x18, 0xA4]};
@GUID(0x1F052807, 0x0B46, 0x4ACC, [0x8A, 0x89, 0x36, 0x4F, 0x79, 0x37, 0x18, 0xA4]);
interface ID3D12VideoDevice : IUnknown
{
    HRESULT CheckFeatureSupport(D3D12_FEATURE_VIDEO FeatureVideo, char* pFeatureSupportData, uint FeatureSupportDataSize);
    HRESULT CreateVideoDecoder(const(D3D12_VIDEO_DECODER_DESC)* pDesc, const(Guid)* riid, void** ppVideoDecoder);
    HRESULT CreateVideoDecoderHeap(const(D3D12_VIDEO_DECODER_HEAP_DESC)* pVideoDecoderHeapDesc, const(Guid)* riid, void** ppVideoDecoderHeap);
    HRESULT CreateVideoProcessor(uint NodeMask, const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC)* pOutputStreamDesc, uint NumInputStreamDescs, char* pInputStreamDescs, const(Guid)* riid, void** ppVideoProcessor);
}

const GUID IID_ID3D12VideoDecoder = {0xC59B6BDC, 0x7720, 0x4074, [0xA1, 0x36, 0x17, 0xA1, 0x56, 0x03, 0x74, 0x70]};
@GUID(0xC59B6BDC, 0x7720, 0x4074, [0xA1, 0x36, 0x17, 0xA1, 0x56, 0x03, 0x74, 0x70]);
interface ID3D12VideoDecoder : ID3D12Pageable
{
    D3D12_VIDEO_DECODER_DESC GetDesc();
}

enum D3D12_VIDEO_DECODE_TIER
{
    D3D12_VIDEO_DECODE_TIER_NOT_SUPPORTED = 0,
    D3D12_VIDEO_DECODE_TIER_1 = 1,
    D3D12_VIDEO_DECODE_TIER_2 = 2,
    D3D12_VIDEO_DECODE_TIER_3 = 3,
}

enum D3D12_VIDEO_DECODE_SUPPORT_FLAGS
{
    D3D12_VIDEO_DECODE_SUPPORT_FLAG_NONE = 0,
    D3D12_VIDEO_DECODE_SUPPORT_FLAG_SUPPORTED = 1,
}

enum D3D12_VIDEO_DECODE_CONFIGURATION_FLAGS
{
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_NONE = 0,
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_HEIGHT_ALIGNMENT_MULTIPLE_32_REQUIRED = 1,
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_POST_PROCESSING_SUPPORTED = 2,
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_REFERENCE_ONLY_ALLOCATIONS_REQUIRED = 4,
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_ALLOW_RESOLUTION_CHANGE_ON_NON_KEY_FRAME = 8,
}

enum D3D12_VIDEO_DECODE_STATUS
{
    D3D12_VIDEO_DECODE_STATUS_OK = 0,
    D3D12_VIDEO_DECODE_STATUS_CONTINUE = 1,
    D3D12_VIDEO_DECODE_STATUS_CONTINUE_SKIP_DISPLAY = 2,
    D3D12_VIDEO_DECODE_STATUS_RESTART = 3,
    D3D12_VIDEO_DECODE_STATUS_RATE_EXCEEDED = 4,
}

enum D3D12_VIDEO_DECODE_ARGUMENT_TYPE
{
    D3D12_VIDEO_DECODE_ARGUMENT_TYPE_PICTURE_PARAMETERS = 0,
    D3D12_VIDEO_DECODE_ARGUMENT_TYPE_INVERSE_QUANTIZATION_MATRIX = 1,
    D3D12_VIDEO_DECODE_ARGUMENT_TYPE_SLICE_CONTROL = 2,
    D3D12_VIDEO_DECODE_ARGUMENT_TYPE_MAX_VALID = 3,
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_SUPPORT
{
    uint NodeIndex;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    uint Width;
    uint Height;
    DXGI_FORMAT DecodeFormat;
    DXGI_RATIONAL FrameRate;
    uint BitRate;
    D3D12_VIDEO_DECODE_SUPPORT_FLAGS SupportFlags;
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAGS ConfigurationFlags;
    D3D12_VIDEO_DECODE_TIER DecodeTier;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_PROFILE_COUNT
{
    uint NodeIndex;
    uint ProfileCount;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_PROFILES
{
    uint NodeIndex;
    uint ProfileCount;
    Guid* pProfiles;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_FORMAT_COUNT
{
    uint NodeIndex;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    uint FormatCount;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_FORMATS
{
    uint NodeIndex;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    uint FormatCount;
    DXGI_FORMAT* pOutputFormats;
}

struct D3D12_FEATURE_DATA_VIDEO_ARCHITECTURE
{
    BOOL IOCoherent;
}

enum D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT
{
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_Y = 0,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_U = 1,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_V = 2,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_R = 0,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_G = 1,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_B = 2,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_A = 3,
}

enum D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAGS
{
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_NONE = 0,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_Y = 1,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_U = 2,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_V = 4,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_R = 1,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_G = 2,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_B = 4,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_A = 8,
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_HISTOGRAM
{
    uint NodeIndex;
    Guid DecodeProfile;
    uint Width;
    uint Height;
    DXGI_FORMAT DecodeFormat;
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAGS Components;
    uint BinCount;
    uint CounterBitDepth;
}

enum D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAGS
{
    D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAG_NONE = 0,
    D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAG_SUPPORTED = 1,
}

enum D3D12_VIDEO_SCALE_SUPPORT_FLAGS
{
    D3D12_VIDEO_SCALE_SUPPORT_FLAG_NONE = 0,
    D3D12_VIDEO_SCALE_SUPPORT_FLAG_POW2_ONLY = 1,
    D3D12_VIDEO_SCALE_SUPPORT_FLAG_EVEN_DIMENSIONS_ONLY = 2,
}

struct D3D12_VIDEO_SCALE_SUPPORT
{
    D3D12_VIDEO_SIZE_RANGE OutputSizeRange;
    D3D12_VIDEO_SCALE_SUPPORT_FLAGS Flags;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_CONVERSION_SUPPORT
{
    uint NodeIndex;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    D3D12_VIDEO_SAMPLE DecodeSample;
    D3D12_VIDEO_FORMAT OutputFormat;
    DXGI_RATIONAL FrameRate;
    uint BitRate;
    D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAGS SupportFlags;
    D3D12_VIDEO_SCALE_SUPPORT ScaleSupport;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODER_HEAP_SIZE
{
    D3D12_VIDEO_DECODER_HEAP_DESC VideoDecoderHeapDesc;
    ulong MemoryPoolL0Size;
    ulong MemoryPoolL1Size;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESSOR_SIZE
{
    uint NodeMask;
    const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC)* pOutputStreamDesc;
    uint NumInputStreamDescs;
    const(D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC)* pInputStreamDescs;
    ulong MemoryPoolL0Size;
    ulong MemoryPoolL1Size;
}

struct D3D12_QUERY_DATA_VIDEO_DECODE_STATISTICS
{
    ulong Status;
    ulong NumMacroblocksAffected;
    DXGI_RATIONAL FrameRate;
    uint BitRate;
}

struct D3D12_VIDEO_DECODE_FRAME_ARGUMENT
{
    D3D12_VIDEO_DECODE_ARGUMENT_TYPE Type;
    uint Size;
    void* pData;
}

struct D3D12_VIDEO_DECODE_REFERENCE_FRAMES
{
    uint NumTexture2Ds;
    ID3D12Resource* ppTexture2Ds;
    uint* pSubresources;
    ID3D12VideoDecoderHeap* ppHeaps;
}

struct D3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM
{
    ID3D12Resource pBuffer;
    ulong Offset;
    ulong Size;
}

struct D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS
{
    BOOL Enable;
    ID3D12Resource pReferenceTexture2D;
    uint ReferenceSubresource;
    DXGI_COLOR_SPACE_TYPE OutputColorSpace;
    DXGI_COLOR_SPACE_TYPE DecodeColorSpace;
}

struct D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS
{
    uint NumFrameArguments;
    D3D12_VIDEO_DECODE_FRAME_ARGUMENT FrameArguments;
    D3D12_VIDEO_DECODE_REFERENCE_FRAMES ReferenceFrames;
    D3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM CompressedBitstream;
    ID3D12VideoDecoderHeap pHeap;
}

struct D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS
{
    ID3D12Resource pOutputTexture2D;
    uint OutputSubresource;
    D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS ConversionArguments;
}

const GUID IID_ID3D12VideoProcessor = {0x304FDB32, 0xBEDE, 0x410A, [0x85, 0x45, 0x94, 0x3A, 0xC6, 0xA4, 0x61, 0x38]};
@GUID(0x304FDB32, 0xBEDE, 0x410A, [0x85, 0x45, 0x94, 0x3A, 0xC6, 0xA4, 0x61, 0x38]);
interface ID3D12VideoProcessor : ID3D12Pageable
{
    uint GetNodeMask();
    uint GetNumInputStreamDescs();
    HRESULT GetInputStreamDescs(uint NumInputStreamDescs, char* pInputStreamDescs);
    D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC GetOutputStreamDesc();
}

enum D3D12_VIDEO_PROCESS_FEATURE_FLAGS
{
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_NONE = 0,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_ALPHA_FILL = 1,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_LUMA_KEY = 2,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_STEREO = 4,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_ROTATION = 8,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_FLIP = 16,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_ALPHA_BLENDING = 32,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_PIXEL_ASPECT_RATIO = 64,
}

enum D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAGS
{
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_NONE = 0,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_DENOISE = 1,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_DERINGING = 2,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_EDGE_ENHANCEMENT = 4,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_COLOR_CORRECTION = 8,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_FLESH_TONE_MAPPING = 16,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_IMAGE_STABILIZATION = 32,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_SUPER_RESOLUTION = 64,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_ANAMORPHIC_SCALING = 128,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_CUSTOM = -2147483648,
}

enum D3D12_VIDEO_PROCESS_ORIENTATION
{
    D3D12_VIDEO_PROCESS_ORIENTATION_DEFAULT = 0,
    D3D12_VIDEO_PROCESS_ORIENTATION_FLIP_HORIZONTAL = 1,
    D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_90 = 2,
    D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_90_FLIP_HORIZONTAL = 3,
    D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_180 = 4,
    D3D12_VIDEO_PROCESS_ORIENTATION_FLIP_VERTICAL = 5,
    D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_270 = 6,
    D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_270_FLIP_HORIZONTAL = 7,
}

enum D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS
{
    D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_NONE = 0,
    D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_FRAME_DISCONTINUITY = 1,
    D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_FRAME_REPEAT = 2,
}

struct D3D12_VIDEO_PROCESS_FILTER_RANGE
{
    int Minimum;
    int Maximum;
    int Default;
    float Multiplier;
}

enum D3D12_VIDEO_PROCESS_SUPPORT_FLAGS
{
    D3D12_VIDEO_PROCESS_SUPPORT_FLAG_NONE = 0,
    D3D12_VIDEO_PROCESS_SUPPORT_FLAG_SUPPORTED = 1,
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESS_SUPPORT
{
    uint NodeIndex;
    D3D12_VIDEO_SAMPLE InputSample;
    D3D12_VIDEO_FIELD_TYPE InputFieldType;
    D3D12_VIDEO_FRAME_STEREO_FORMAT InputStereoFormat;
    DXGI_RATIONAL InputFrameRate;
    D3D12_VIDEO_FORMAT OutputFormat;
    D3D12_VIDEO_FRAME_STEREO_FORMAT OutputStereoFormat;
    DXGI_RATIONAL OutputFrameRate;
    D3D12_VIDEO_PROCESS_SUPPORT_FLAGS SupportFlags;
    D3D12_VIDEO_SCALE_SUPPORT ScaleSupport;
    D3D12_VIDEO_PROCESS_FEATURE_FLAGS FeatureSupport;
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS DeinterlaceSupport;
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAGS AutoProcessingSupport;
    D3D12_VIDEO_PROCESS_FILTER_FLAGS FilterSupport;
    D3D12_VIDEO_PROCESS_FILTER_RANGE FilterRangeSupport;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESS_MAX_INPUT_STREAMS
{
    uint NodeIndex;
    uint MaxInputStreams;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESS_REFERENCE_INFO
{
    uint NodeIndex;
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS DeinterlaceMode;
    D3D12_VIDEO_PROCESS_FILTER_FLAGS Filters;
    D3D12_VIDEO_PROCESS_FEATURE_FLAGS FeatureSupport;
    DXGI_RATIONAL InputFrameRate;
    DXGI_RATIONAL OutputFrameRate;
    BOOL EnableAutoProcessing;
    uint PastFrames;
    uint FutureFrames;
}

struct D3D12_VIDEO_PROCESS_REFERENCE_SET
{
    uint NumPastFrames;
    ID3D12Resource* ppPastFrames;
    uint* pPastSubresources;
    uint NumFutureFrames;
    ID3D12Resource* ppFutureFrames;
    uint* pFutureSubresources;
}

struct D3D12_VIDEO_PROCESS_TRANSFORM
{
    RECT SourceRectangle;
    RECT DestinationRectangle;
    D3D12_VIDEO_PROCESS_ORIENTATION Orientation;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE
{
    uint OutputIndex;
    uint InputFrameOrField;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM
{
    ID3D12Resource pTexture2D;
    uint Subresource;
    D3D12_VIDEO_PROCESS_REFERENCE_SET ReferenceSet;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS
{
    D3D12_VIDEO_PROCESS_INPUT_STREAM InputStream;
    D3D12_VIDEO_PROCESS_TRANSFORM Transform;
    D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS Flags;
    D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE RateInfo;
    int FilterLevels;
    D3D12_VIDEO_PROCESS_ALPHA_BLENDING AlphaBlending;
}

struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM
{
    ID3D12Resource pTexture2D;
    uint Subresource;
}

struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS
{
    D3D12_VIDEO_PROCESS_OUTPUT_STREAM OutputStream;
    RECT TargetRectangle;
}

const GUID IID_ID3D12VideoDecodeCommandList = {0x3B60536E, 0xAD29, 0x4E64, [0xA2, 0x69, 0xF8, 0x53, 0x83, 0x7E, 0x5E, 0x53]};
@GUID(0x3B60536E, 0xAD29, 0x4E64, [0xA2, 0x69, 0xF8, 0x53, 0x83, 0x7E, 0x5E, 0x53]);
interface ID3D12VideoDecodeCommandList : ID3D12CommandList
{
    HRESULT Close();
    HRESULT Reset(ID3D12CommandAllocator pAllocator);
    void ClearState();
    void ResourceBarrier(uint NumBarriers, char* pBarriers);
    void DiscardResource(ID3D12Resource pResource, const(D3D12_DISCARD_REGION)* pRegion);
    void BeginQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void EndQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void ResolveQueryData(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint StartIndex, uint NumQueries, ID3D12Resource pDestinationBuffer, ulong AlignedDestinationBufferOffset);
    void SetPredication(ID3D12Resource pBuffer, ulong AlignedBufferOffset, D3D12_PREDICATION_OP Operation);
    void SetMarker(uint Metadata, char* pData, uint Size);
    void BeginEvent(uint Metadata, char* pData, uint Size);
    void EndEvent();
    void DecodeFrame(ID3D12VideoDecoder pDecoder, const(D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS)* pOutputArguments, const(D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS)* pInputArguments);
    void WriteBufferImmediate(uint Count, char* pParams, char* pModes);
}

const GUID IID_ID3D12VideoProcessCommandList = {0xAEB2543A, 0x167F, 0x4682, [0xAC, 0xC8, 0xD1, 0x59, 0xED, 0x4A, 0x62, 0x09]};
@GUID(0xAEB2543A, 0x167F, 0x4682, [0xAC, 0xC8, 0xD1, 0x59, 0xED, 0x4A, 0x62, 0x09]);
interface ID3D12VideoProcessCommandList : ID3D12CommandList
{
    HRESULT Close();
    HRESULT Reset(ID3D12CommandAllocator pAllocator);
    void ClearState();
    void ResourceBarrier(uint NumBarriers, char* pBarriers);
    void DiscardResource(ID3D12Resource pResource, const(D3D12_DISCARD_REGION)* pRegion);
    void BeginQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void EndQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void ResolveQueryData(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint StartIndex, uint NumQueries, ID3D12Resource pDestinationBuffer, ulong AlignedDestinationBufferOffset);
    void SetPredication(ID3D12Resource pBuffer, ulong AlignedBufferOffset, D3D12_PREDICATION_OP Operation);
    void SetMarker(uint Metadata, char* pData, uint Size);
    void BeginEvent(uint Metadata, char* pData, uint Size);
    void EndEvent();
    void ProcessFrames(ID3D12VideoProcessor pVideoProcessor, const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS)* pOutputArguments, uint NumInputStreams, char* pInputArguments);
    void WriteBufferImmediate(uint Count, char* pParams, char* pModes);
}

struct D3D12_VIDEO_DECODE_OUTPUT_HISTOGRAM
{
    ulong Offset;
    ID3D12Resource pBuffer;
}

struct D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS1
{
    BOOL Enable;
    ID3D12Resource pReferenceTexture2D;
    uint ReferenceSubresource;
    DXGI_COLOR_SPACE_TYPE OutputColorSpace;
    DXGI_COLOR_SPACE_TYPE DecodeColorSpace;
    uint OutputWidth;
    uint OutputHeight;
}

struct D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS1
{
    ID3D12Resource pOutputTexture2D;
    uint OutputSubresource;
    D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS1 ConversionArguments;
    D3D12_VIDEO_DECODE_OUTPUT_HISTOGRAM Histograms;
}

const GUID IID_ID3D12VideoDecodeCommandList1 = {0xD52F011B, 0xB56E, 0x453C, [0xA0, 0x5A, 0xA7, 0xF3, 0x11, 0xC8, 0xF4, 0x72]};
@GUID(0xD52F011B, 0xB56E, 0x453C, [0xA0, 0x5A, 0xA7, 0xF3, 0x11, 0xC8, 0xF4, 0x72]);
interface ID3D12VideoDecodeCommandList1 : ID3D12VideoDecodeCommandList
{
    void DecodeFrame1(ID3D12VideoDecoder pDecoder, const(D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS1)* pOutputArguments, const(D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS)* pInputArguments);
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS1
{
    D3D12_VIDEO_PROCESS_INPUT_STREAM InputStream;
    D3D12_VIDEO_PROCESS_TRANSFORM Transform;
    D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS Flags;
    D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE RateInfo;
    int FilterLevels;
    D3D12_VIDEO_PROCESS_ALPHA_BLENDING AlphaBlending;
    D3D12_VIDEO_FIELD_TYPE FieldType;
}

const GUID IID_ID3D12VideoProcessCommandList1 = {0x542C5C4D, 0x7596, 0x434F, [0x8C, 0x93, 0x4E, 0xFA, 0x67, 0x66, 0xF2, 0x67]};
@GUID(0x542C5C4D, 0x7596, 0x434F, [0x8C, 0x93, 0x4E, 0xFA, 0x67, 0x66, 0xF2, 0x67]);
interface ID3D12VideoProcessCommandList1 : ID3D12VideoProcessCommandList
{
    void ProcessFrames1(ID3D12VideoProcessor pVideoProcessor, const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS)* pOutputArguments, uint NumInputStreams, char* pInputArguments);
}

enum D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE
{
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_8X8 = 0,
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_16X16 = 1,
}

enum D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAGS
{
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAG_NONE = 0,
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAG_8X8 = 1,
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAG_16X16 = 2,
}

enum D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION
{
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_QUARTER_PEL = 0,
}

enum D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAGS
{
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAG_NONE = 0,
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAG_QUARTER_PEL = 1,
}

struct D3D12_FEATURE_DATA_VIDEO_FEATURE_AREA_SUPPORT
{
    uint NodeIndex;
    BOOL VideoDecodeSupport;
    BOOL VideoProcessSupport;
    BOOL VideoEncodeSupport;
}

struct D3D12_FEATURE_DATA_VIDEO_MOTION_ESTIMATOR
{
    uint NodeIndex;
    DXGI_FORMAT InputFormat;
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAGS BlockSizeFlags;
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAGS PrecisionFlags;
    D3D12_VIDEO_SIZE_RANGE SizeRange;
}

struct D3D12_FEATURE_DATA_VIDEO_MOTION_ESTIMATOR_SIZE
{
    uint NodeIndex;
    DXGI_FORMAT InputFormat;
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE BlockSize;
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION Precision;
    D3D12_VIDEO_SIZE_RANGE SizeRange;
    BOOL Protected;
    ulong MotionVectorHeapMemoryPoolL0Size;
    ulong MotionVectorHeapMemoryPoolL1Size;
    ulong MotionEstimatorMemoryPoolL0Size;
    ulong MotionEstimatorMemoryPoolL1Size;
}

struct D3D12_VIDEO_MOTION_ESTIMATOR_DESC
{
    uint NodeMask;
    DXGI_FORMAT InputFormat;
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE BlockSize;
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION Precision;
    D3D12_VIDEO_SIZE_RANGE SizeRange;
}

const GUID IID_ID3D12VideoMotionEstimator = {0x33FDAE0E, 0x098B, 0x428F, [0x87, 0xBB, 0x34, 0xB6, 0x95, 0xDE, 0x08, 0xF8]};
@GUID(0x33FDAE0E, 0x098B, 0x428F, [0x87, 0xBB, 0x34, 0xB6, 0x95, 0xDE, 0x08, 0xF8]);
interface ID3D12VideoMotionEstimator : ID3D12Pageable
{
    D3D12_VIDEO_MOTION_ESTIMATOR_DESC GetDesc();
    HRESULT GetProtectedResourceSession(const(Guid)* riid, void** ppProtectedSession);
}

struct D3D12_VIDEO_MOTION_VECTOR_HEAP_DESC
{
    uint NodeMask;
    DXGI_FORMAT InputFormat;
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE BlockSize;
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION Precision;
    D3D12_VIDEO_SIZE_RANGE SizeRange;
}

const GUID IID_ID3D12VideoMotionVectorHeap = {0x5BE17987, 0x743A, 0x4061, [0x83, 0x4B, 0x23, 0xD2, 0x2D, 0xAE, 0xA5, 0x05]};
@GUID(0x5BE17987, 0x743A, 0x4061, [0x83, 0x4B, 0x23, 0xD2, 0x2D, 0xAE, 0xA5, 0x05]);
interface ID3D12VideoMotionVectorHeap : ID3D12Pageable
{
    D3D12_VIDEO_MOTION_VECTOR_HEAP_DESC GetDesc();
    HRESULT GetProtectedResourceSession(const(Guid)* riid, void** ppProtectedSession);
}

const GUID IID_ID3D12VideoDevice1 = {0x981611AD, 0xA144, 0x4C83, [0x98, 0x90, 0xF3, 0x0E, 0x26, 0xD6, 0x58, 0xAB]};
@GUID(0x981611AD, 0xA144, 0x4C83, [0x98, 0x90, 0xF3, 0x0E, 0x26, 0xD6, 0x58, 0xAB]);
interface ID3D12VideoDevice1 : ID3D12VideoDevice
{
    HRESULT CreateVideoMotionEstimator(const(D3D12_VIDEO_MOTION_ESTIMATOR_DESC)* pDesc, ID3D12ProtectedResourceSession pProtectedResourceSession, const(Guid)* riid, void** ppVideoMotionEstimator);
    HRESULT CreateVideoMotionVectorHeap(const(D3D12_VIDEO_MOTION_VECTOR_HEAP_DESC)* pDesc, ID3D12ProtectedResourceSession pProtectedResourceSession, const(Guid)* riid, void** ppVideoMotionVectorHeap);
}

struct D3D12_RESOURCE_COORDINATE
{
    ulong X;
    uint Y;
    uint Z;
    uint SubresourceIndex;
}

struct D3D12_VIDEO_MOTION_ESTIMATOR_OUTPUT
{
    ID3D12VideoMotionVectorHeap pMotionVectorHeap;
}

struct D3D12_VIDEO_MOTION_ESTIMATOR_INPUT
{
    ID3D12Resource pInputTexture2D;
    uint InputSubresourceIndex;
    ID3D12Resource pReferenceTexture2D;
    uint ReferenceSubresourceIndex;
    ID3D12VideoMotionVectorHeap pHintMotionVectorHeap;
}

struct D3D12_RESOLVE_VIDEO_MOTION_VECTOR_HEAP_OUTPUT
{
    ID3D12Resource pMotionVectorTexture2D;
    D3D12_RESOURCE_COORDINATE MotionVectorCoordinate;
}

struct D3D12_RESOLVE_VIDEO_MOTION_VECTOR_HEAP_INPUT
{
    ID3D12VideoMotionVectorHeap pMotionVectorHeap;
    uint PixelWidth;
    uint PixelHeight;
}

const GUID IID_ID3D12VideoEncodeCommandList = {0x8455293A, 0x0CBD, 0x4831, [0x9B, 0x39, 0xFB, 0xDB, 0xAB, 0x72, 0x47, 0x23]};
@GUID(0x8455293A, 0x0CBD, 0x4831, [0x9B, 0x39, 0xFB, 0xDB, 0xAB, 0x72, 0x47, 0x23]);
interface ID3D12VideoEncodeCommandList : ID3D12CommandList
{
    HRESULT Close();
    HRESULT Reset(ID3D12CommandAllocator pAllocator);
    void ClearState();
    void ResourceBarrier(uint NumBarriers, char* pBarriers);
    void DiscardResource(ID3D12Resource pResource, const(D3D12_DISCARD_REGION)* pRegion);
    void BeginQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void EndQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void ResolveQueryData(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint StartIndex, uint NumQueries, ID3D12Resource pDestinationBuffer, ulong AlignedDestinationBufferOffset);
    void SetPredication(ID3D12Resource pBuffer, ulong AlignedBufferOffset, D3D12_PREDICATION_OP Operation);
    void SetMarker(uint Metadata, char* pData, uint Size);
    void BeginEvent(uint Metadata, char* pData, uint Size);
    void EndEvent();
    void EstimateMotion(ID3D12VideoMotionEstimator pMotionEstimator, const(D3D12_VIDEO_MOTION_ESTIMATOR_OUTPUT)* pOutputArguments, const(D3D12_VIDEO_MOTION_ESTIMATOR_INPUT)* pInputArguments);
    void ResolveMotionVectorHeap(const(D3D12_RESOLVE_VIDEO_MOTION_VECTOR_HEAP_OUTPUT)* pOutputArguments, const(D3D12_RESOLVE_VIDEO_MOTION_VECTOR_HEAP_INPUT)* pInputArguments);
    void WriteBufferImmediate(uint Count, char* pParams, char* pModes);
    void SetProtectedResourceSession(ID3D12ProtectedResourceSession pProtectedResourceSession);
}

enum D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAGS
{
    D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAG_NONE = 0,
    D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAG_SUPPORTED = 1,
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_PROTECTED_RESOURCES
{
    uint NodeIndex;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAGS SupportFlags;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESS_PROTECTED_RESOURCES
{
    uint NodeIndex;
    D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAGS SupportFlags;
}

struct D3D12_FEATURE_DATA_VIDEO_MOTION_ESTIMATOR_PROTECTED_RESOURCES
{
    uint NodeIndex;
    D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAGS SupportFlags;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODER_HEAP_SIZE1
{
    D3D12_VIDEO_DECODER_HEAP_DESC VideoDecoderHeapDesc;
    BOOL Protected;
    ulong MemoryPoolL0Size;
    ulong MemoryPoolL1Size;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESSOR_SIZE1
{
    uint NodeMask;
    const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC)* pOutputStreamDesc;
    uint NumInputStreamDescs;
    const(D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC)* pInputStreamDescs;
    BOOL Protected;
    ulong MemoryPoolL0Size;
    ulong MemoryPoolL1Size;
}

enum D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE
{
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_CREATION = 0,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_INITIALIZATION = 1,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_EXECUTION = 2,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_CAPS_INPUT = 3,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_CAPS_OUTPUT = 4,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_DEVICE_EXECUTE_INPUT = 5,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_DEVICE_EXECUTE_OUTPUT = 6,
}

enum D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE
{
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT8 = 0,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT16 = 1,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT32 = 2,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT64 = 3,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT8 = 4,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT16 = 5,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT32 = 6,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT64 = 7,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_FLOAT = 8,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_DOUBLE = 9,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_RESOURCE = 10,
}

enum D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAGS
{
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAG_NONE = 0,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAG_READ = 1,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAG_WRITE = 2,
}

struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_COUNT
{
    uint NodeIndex;
    uint CommandCount;
}

struct D3D12_VIDEO_EXTENSION_COMMAND_INFO
{
    Guid CommandId;
    const(wchar)* Name;
    D3D12_COMMAND_LIST_SUPPORT_FLAGS CommandListSupportFlags;
}

struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMANDS
{
    uint NodeIndex;
    uint CommandCount;
    D3D12_VIDEO_EXTENSION_COMMAND_INFO* pCommandInfos;
}

struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_PARAMETER_COUNT
{
    Guid CommandId;
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE Stage;
    uint ParameterCount;
    uint ParameterPacking;
}

struct D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_INFO
{
    const(wchar)* Name;
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE Type;
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAGS Flags;
}

struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_PARAMETERS
{
    Guid CommandId;
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE Stage;
    uint ParameterCount;
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_INFO* pParameterInfos;
}

struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_SUPPORT
{
    uint NodeIndex;
    Guid CommandId;
    const(void)* pInputData;
    uint InputDataSizeInBytes;
    void* pOutputData;
    uint OutputDataSizeInBytes;
}

struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_SIZE
{
    uint NodeIndex;
    Guid CommandId;
    const(void)* pCreationParameters;
    uint CreationParametersSizeInBytes;
    ulong MemoryPoolL0Size;
    ulong MemoryPoolL1Size;
}

struct D3D12_VIDEO_EXTENSION_COMMAND_DESC
{
    uint NodeMask;
    Guid CommandId;
}

const GUID IID_ID3D12VideoDecoder1 = {0x79A2E5FB, 0xCCD2, 0x469A, [0x9F, 0xDE, 0x19, 0x5D, 0x10, 0x95, 0x1F, 0x7E]};
@GUID(0x79A2E5FB, 0xCCD2, 0x469A, [0x9F, 0xDE, 0x19, 0x5D, 0x10, 0x95, 0x1F, 0x7E]);
interface ID3D12VideoDecoder1 : ID3D12VideoDecoder
{
    HRESULT GetProtectedResourceSession(const(Guid)* riid, void** ppProtectedSession);
}

const GUID IID_ID3D12VideoDecoderHeap1 = {0xDA1D98C5, 0x539F, 0x41B2, [0xBF, 0x6B, 0x11, 0x98, 0xA0, 0x3B, 0x6D, 0x26]};
@GUID(0xDA1D98C5, 0x539F, 0x41B2, [0xBF, 0x6B, 0x11, 0x98, 0xA0, 0x3B, 0x6D, 0x26]);
interface ID3D12VideoDecoderHeap1 : ID3D12VideoDecoderHeap
{
    HRESULT GetProtectedResourceSession(const(Guid)* riid, void** ppProtectedSession);
}

const GUID IID_ID3D12VideoProcessor1 = {0xF3CFE615, 0x553F, 0x425C, [0x86, 0xD8, 0xEE, 0x8C, 0x1B, 0x1F, 0xB0, 0x1C]};
@GUID(0xF3CFE615, 0x553F, 0x425C, [0x86, 0xD8, 0xEE, 0x8C, 0x1B, 0x1F, 0xB0, 0x1C]);
interface ID3D12VideoProcessor1 : ID3D12VideoProcessor
{
    HRESULT GetProtectedResourceSession(const(Guid)* riid, void** ppProtectedSession);
}

const GUID IID_ID3D12VideoExtensionCommand = {0x554E41E8, 0xAE8E, 0x4A8C, [0xB7, 0xD2, 0x5B, 0x4F, 0x27, 0x4A, 0x30, 0xE4]};
@GUID(0x554E41E8, 0xAE8E, 0x4A8C, [0xB7, 0xD2, 0x5B, 0x4F, 0x27, 0x4A, 0x30, 0xE4]);
interface ID3D12VideoExtensionCommand : ID3D12Pageable
{
    D3D12_VIDEO_EXTENSION_COMMAND_DESC GetDesc();
    HRESULT GetProtectedResourceSession(const(Guid)* riid, void** ppProtectedSession);
}

const GUID IID_ID3D12VideoDevice2 = {0xF019AC49, 0xF838, 0x4A95, [0x9B, 0x17, 0x57, 0x94, 0x37, 0xC8, 0xF5, 0x13]};
@GUID(0xF019AC49, 0xF838, 0x4A95, [0x9B, 0x17, 0x57, 0x94, 0x37, 0xC8, 0xF5, 0x13]);
interface ID3D12VideoDevice2 : ID3D12VideoDevice1
{
    HRESULT CreateVideoDecoder1(const(D3D12_VIDEO_DECODER_DESC)* pDesc, ID3D12ProtectedResourceSession pProtectedResourceSession, const(Guid)* riid, void** ppVideoDecoder);
    HRESULT CreateVideoDecoderHeap1(const(D3D12_VIDEO_DECODER_HEAP_DESC)* pVideoDecoderHeapDesc, ID3D12ProtectedResourceSession pProtectedResourceSession, const(Guid)* riid, void** ppVideoDecoderHeap);
    HRESULT CreateVideoProcessor1(uint NodeMask, const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC)* pOutputStreamDesc, uint NumInputStreamDescs, char* pInputStreamDescs, ID3D12ProtectedResourceSession pProtectedResourceSession, const(Guid)* riid, void** ppVideoProcessor);
    HRESULT CreateVideoExtensionCommand(const(D3D12_VIDEO_EXTENSION_COMMAND_DESC)* pDesc, char* pCreationParameters, uint CreationParametersDataSizeInBytes, ID3D12ProtectedResourceSession pProtectedResourceSession, const(Guid)* riid, void** ppVideoExtensionCommand);
    HRESULT ExecuteExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pExecutionParameters, uint ExecutionParametersSizeInBytes, char* pOutputData, uint OutputDataSizeInBytes);
}

const GUID IID_ID3D12VideoDecodeCommandList2 = {0x6E120880, 0xC114, 0x4153, [0x80, 0x36, 0xD2, 0x47, 0x05, 0x1E, 0x17, 0x29]};
@GUID(0x6E120880, 0xC114, 0x4153, [0x80, 0x36, 0xD2, 0x47, 0x05, 0x1E, 0x17, 0x29]);
interface ID3D12VideoDecodeCommandList2 : ID3D12VideoDecodeCommandList1
{
    void SetProtectedResourceSession(ID3D12ProtectedResourceSession pProtectedResourceSession);
    void InitializeExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pInitializationParameters, uint InitializationParametersSizeInBytes);
    void ExecuteExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pExecutionParameters, uint ExecutionParametersSizeInBytes);
}

const GUID IID_ID3D12VideoProcessCommandList2 = {0xDB525AE4, 0x6AD6, 0x473C, [0xBA, 0xA7, 0x59, 0xB2, 0xE3, 0x70, 0x82, 0xE4]};
@GUID(0xDB525AE4, 0x6AD6, 0x473C, [0xBA, 0xA7, 0x59, 0xB2, 0xE3, 0x70, 0x82, 0xE4]);
interface ID3D12VideoProcessCommandList2 : ID3D12VideoProcessCommandList1
{
    void SetProtectedResourceSession(ID3D12ProtectedResourceSession pProtectedResourceSession);
    void InitializeExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pInitializationParameters, uint InitializationParametersSizeInBytes);
    void ExecuteExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pExecutionParameters, uint ExecutionParametersSizeInBytes);
}

const GUID IID_ID3D12VideoEncodeCommandList1 = {0x94971ECA, 0x2BDB, 0x4769, [0x88, 0xCF, 0x36, 0x75, 0xEA, 0x75, 0x7E, 0xBC]};
@GUID(0x94971ECA, 0x2BDB, 0x4769, [0x88, 0xCF, 0x36, 0x75, 0xEA, 0x75, 0x7E, 0xBC]);
interface ID3D12VideoEncodeCommandList1 : ID3D12VideoEncodeCommandList
{
    void InitializeExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pInitializationParameters, uint InitializationParametersSizeInBytes);
    void ExecuteExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pExecutionParameters, uint ExecutionParametersSizeInBytes);
}

const GUID CLSID_CMpeg4DecMediaObject = {0xF371728A, 0x6052, 0x4D47, [0x82, 0x7C, 0xD0, 0x39, 0x33, 0x5D, 0xFE, 0x0A]};
@GUID(0xF371728A, 0x6052, 0x4D47, [0x82, 0x7C, 0xD0, 0x39, 0x33, 0x5D, 0xFE, 0x0A]);
struct CMpeg4DecMediaObject;

const GUID CLSID_CMpeg43DecMediaObject = {0xCBA9E78B, 0x49A3, 0x49EA, [0x93, 0xD4, 0x6B, 0xCB, 0xA8, 0xC4, 0xDE, 0x07]};
@GUID(0xCBA9E78B, 0x49A3, 0x49EA, [0x93, 0xD4, 0x6B, 0xCB, 0xA8, 0xC4, 0xDE, 0x07]);
struct CMpeg43DecMediaObject;

const GUID CLSID_CMpeg4sDecMediaObject = {0x2A11BAE2, 0xFE6E, 0x4249, [0x86, 0x4B, 0x9E, 0x9E, 0xD6, 0xE8, 0xDB, 0xC2]};
@GUID(0x2A11BAE2, 0xFE6E, 0x4249, [0x86, 0x4B, 0x9E, 0x9E, 0xD6, 0xE8, 0xDB, 0xC2]);
struct CMpeg4sDecMediaObject;

const GUID CLSID_CMpeg4sDecMFT = {0x5686A0D9, 0xFE39, 0x409F, [0x9D, 0xFF, 0x3F, 0xDB, 0xC8, 0x49, 0xF9, 0xF5]};
@GUID(0x5686A0D9, 0xFE39, 0x409F, [0x9D, 0xFF, 0x3F, 0xDB, 0xC8, 0x49, 0xF9, 0xF5]);
struct CMpeg4sDecMFT;

const GUID CLSID_CZuneM4S2DecMediaObject = {0xC56FC25C, 0x0FC6, 0x404A, [0x95, 0x03, 0xB1, 0x0B, 0xF5, 0x1A, 0x8A, 0xB9]};
@GUID(0xC56FC25C, 0x0FC6, 0x404A, [0x95, 0x03, 0xB1, 0x0B, 0xF5, 0x1A, 0x8A, 0xB9]);
struct CZuneM4S2DecMediaObject;

const GUID CLSID_CMpeg4EncMediaObject = {0x24F258D8, 0xC651, 0x4042, [0x93, 0xE4, 0xCA, 0x65, 0x4A, 0xBB, 0x68, 0x2C]};
@GUID(0x24F258D8, 0xC651, 0x4042, [0x93, 0xE4, 0xCA, 0x65, 0x4A, 0xBB, 0x68, 0x2C]);
struct CMpeg4EncMediaObject;

const GUID CLSID_CMpeg4sEncMediaObject = {0x6EC5A7BE, 0xD81E, 0x4F9E, [0xAD, 0xA3, 0xCD, 0x1B, 0xF2, 0x62, 0xB6, 0xD8]};
@GUID(0x6EC5A7BE, 0xD81E, 0x4F9E, [0xAD, 0xA3, 0xCD, 0x1B, 0xF2, 0x62, 0xB6, 0xD8]);
struct CMpeg4sEncMediaObject;

const GUID CLSID_CMSSCDecMediaObject = {0x7BAFB3B1, 0xD8F4, 0x4279, [0x92, 0x53, 0x27, 0xDA, 0x42, 0x31, 0x08, 0xDE]};
@GUID(0x7BAFB3B1, 0xD8F4, 0x4279, [0x92, 0x53, 0x27, 0xDA, 0x42, 0x31, 0x08, 0xDE]);
struct CMSSCDecMediaObject;

const GUID CLSID_CMSSCEncMediaObject = {0x8CB9CC06, 0xD139, 0x4AE6, [0x8B, 0xB4, 0x41, 0xE6, 0x12, 0xE1, 0x41, 0xD5]};
@GUID(0x8CB9CC06, 0xD139, 0x4AE6, [0x8B, 0xB4, 0x41, 0xE6, 0x12, 0xE1, 0x41, 0xD5]);
struct CMSSCEncMediaObject;

const GUID CLSID_CMSSCEncMediaObject2 = {0xF7FFE0A0, 0xA4F5, 0x44B5, [0x94, 0x9E, 0x15, 0xED, 0x2B, 0xC6, 0x6F, 0x9D]};
@GUID(0xF7FFE0A0, 0xA4F5, 0x44B5, [0x94, 0x9E, 0x15, 0xED, 0x2B, 0xC6, 0x6F, 0x9D]);
struct CMSSCEncMediaObject2;

const GUID CLSID_CWMADecMediaObject = {0x2EEB4ADF, 0x4578, 0x4D10, [0xBC, 0xA7, 0xBB, 0x95, 0x5F, 0x56, 0x32, 0x0A]};
@GUID(0x2EEB4ADF, 0x4578, 0x4D10, [0xBC, 0xA7, 0xBB, 0x95, 0x5F, 0x56, 0x32, 0x0A]);
struct CWMADecMediaObject;

const GUID CLSID_CWMAEncMediaObject = {0x70F598E9, 0xF4AB, 0x495A, [0x99, 0xE2, 0xA7, 0xC4, 0xD3, 0xD8, 0x9A, 0xBF]};
@GUID(0x70F598E9, 0xF4AB, 0x495A, [0x99, 0xE2, 0xA7, 0xC4, 0xD3, 0xD8, 0x9A, 0xBF]);
struct CWMAEncMediaObject;

const GUID CLSID_CWMATransMediaObject = {0xEDCAD9CB, 0x3127, 0x40DF, [0xB5, 0x27, 0x01, 0x52, 0xCC, 0xB3, 0xF6, 0xF5]};
@GUID(0xEDCAD9CB, 0x3127, 0x40DF, [0xB5, 0x27, 0x01, 0x52, 0xCC, 0xB3, 0xF6, 0xF5]);
struct CWMATransMediaObject;

const GUID CLSID_CWMSPDecMediaObject = {0x874131CB, 0x4ECC, 0x443B, [0x89, 0x48, 0x74, 0x6B, 0x89, 0x59, 0x5D, 0x20]};
@GUID(0x874131CB, 0x4ECC, 0x443B, [0x89, 0x48, 0x74, 0x6B, 0x89, 0x59, 0x5D, 0x20]);
struct CWMSPDecMediaObject;

const GUID CLSID_CWMSPEncMediaObject = {0x67841B03, 0xC689, 0x4188, [0xAD, 0x3F, 0x4C, 0x9E, 0xBE, 0xEC, 0x71, 0x0B]};
@GUID(0x67841B03, 0xC689, 0x4188, [0xAD, 0x3F, 0x4C, 0x9E, 0xBE, 0xEC, 0x71, 0x0B]);
struct CWMSPEncMediaObject;

const GUID CLSID_CWMSPEncMediaObject2 = {0x1F1F4E1A, 0x2252, 0x4063, [0x84, 0xBB, 0xEE, 0xE7, 0x5F, 0x88, 0x56, 0xD5]};
@GUID(0x1F1F4E1A, 0x2252, 0x4063, [0x84, 0xBB, 0xEE, 0xE7, 0x5F, 0x88, 0x56, 0xD5]);
struct CWMSPEncMediaObject2;

const GUID CLSID_CWMTDecMediaObject = {0xF9DBC64E, 0x2DD0, 0x45DD, [0x9B, 0x52, 0x66, 0x64, 0x2E, 0xF9, 0x44, 0x31]};
@GUID(0xF9DBC64E, 0x2DD0, 0x45DD, [0x9B, 0x52, 0x66, 0x64, 0x2E, 0xF9, 0x44, 0x31]);
struct CWMTDecMediaObject;

const GUID CLSID_CWMTEncMediaObject = {0x60B67652, 0xE46B, 0x4E44, [0x86, 0x09, 0xF7, 0x4B, 0xFF, 0xDC, 0x08, 0x3C]};
@GUID(0x60B67652, 0xE46B, 0x4E44, [0x86, 0x09, 0xF7, 0x4B, 0xFF, 0xDC, 0x08, 0x3C]);
struct CWMTEncMediaObject;

const GUID CLSID_CWMVDecMediaObject = {0x82D353DF, 0x90BD, 0x4382, [0x8B, 0xC2, 0x3F, 0x61, 0x92, 0xB7, 0x6E, 0x34]};
@GUID(0x82D353DF, 0x90BD, 0x4382, [0x8B, 0xC2, 0x3F, 0x61, 0x92, 0xB7, 0x6E, 0x34]);
struct CWMVDecMediaObject;

const GUID CLSID_CWMVEncMediaObject2 = {0x96B57CDD, 0x8966, 0x410C, [0xBB, 0x1F, 0xC9, 0x7E, 0xEA, 0x76, 0x5C, 0x04]};
@GUID(0x96B57CDD, 0x8966, 0x410C, [0xBB, 0x1F, 0xC9, 0x7E, 0xEA, 0x76, 0x5C, 0x04]);
struct CWMVEncMediaObject2;

const GUID CLSID_CWMVXEncMediaObject = {0x7E320092, 0x596A, 0x41B2, [0xBB, 0xEB, 0x17, 0x5D, 0x10, 0x50, 0x4E, 0xB6]};
@GUID(0x7E320092, 0x596A, 0x41B2, [0xBB, 0xEB, 0x17, 0x5D, 0x10, 0x50, 0x4E, 0xB6]);
struct CWMVXEncMediaObject;

const GUID CLSID_CWMV9EncMediaObject = {0xD23B90D0, 0x144F, 0x46BD, [0x84, 0x1D, 0x59, 0xE4, 0xEB, 0x19, 0xDC, 0x59]};
@GUID(0xD23B90D0, 0x144F, 0x46BD, [0x84, 0x1D, 0x59, 0xE4, 0xEB, 0x19, 0xDC, 0x59]);
struct CWMV9EncMediaObject;

const GUID CLSID_CWVC1DecMediaObject = {0xC9BFBCCF, 0xE60E, 0x4588, [0xA3, 0xDF, 0x5A, 0x03, 0xB1, 0xFD, 0x95, 0x85]};
@GUID(0xC9BFBCCF, 0xE60E, 0x4588, [0xA3, 0xDF, 0x5A, 0x03, 0xB1, 0xFD, 0x95, 0x85]);
struct CWVC1DecMediaObject;

const GUID CLSID_CWVC1EncMediaObject = {0x44653D0D, 0x8CCA, 0x41E7, [0xBA, 0xCA, 0x88, 0x43, 0x37, 0xB7, 0x47, 0xAC]};
@GUID(0x44653D0D, 0x8CCA, 0x41E7, [0xBA, 0xCA, 0x88, 0x43, 0x37, 0xB7, 0x47, 0xAC]);
struct CWVC1EncMediaObject;

const GUID CLSID_CDeColorConvMediaObject = {0x49034C05, 0xF43C, 0x400F, [0x84, 0xC1, 0x90, 0xA6, 0x83, 0x19, 0x5A, 0x3A]};
@GUID(0x49034C05, 0xF43C, 0x400F, [0x84, 0xC1, 0x90, 0xA6, 0x83, 0x19, 0x5A, 0x3A]);
struct CDeColorConvMediaObject;

const GUID CLSID_CDVDecoderMediaObject = {0xE54709C5, 0x1E17, 0x4C8D, [0x94, 0xE7, 0x47, 0x89, 0x40, 0x43, 0x35, 0x84]};
@GUID(0xE54709C5, 0x1E17, 0x4C8D, [0x94, 0xE7, 0x47, 0x89, 0x40, 0x43, 0x35, 0x84]);
struct CDVDecoderMediaObject;

const GUID CLSID_CDVEncoderMediaObject = {0xC82AE729, 0xC327, 0x4CCE, [0x91, 0x4D, 0x81, 0x71, 0xFE, 0xFE, 0xBE, 0xFB]};
@GUID(0xC82AE729, 0xC327, 0x4CCE, [0x91, 0x4D, 0x81, 0x71, 0xFE, 0xFE, 0xBE, 0xFB]);
struct CDVEncoderMediaObject;

const GUID CLSID_CMpeg2DecMediaObject = {0x863D66CD, 0xCDCE, 0x4617, [0xB4, 0x7F, 0xC8, 0x92, 0x9C, 0xFC, 0x28, 0xA6]};
@GUID(0x863D66CD, 0xCDCE, 0x4617, [0xB4, 0x7F, 0xC8, 0x92, 0x9C, 0xFC, 0x28, 0xA6]);
struct CMpeg2DecMediaObject;

const GUID CLSID_CPK_DS_MPEG2Decoder = {0x9910C5CD, 0x95C9, 0x4E06, [0x86, 0x5A, 0xEF, 0xA1, 0xC8, 0x01, 0x6B, 0xF4]};
@GUID(0x9910C5CD, 0x95C9, 0x4E06, [0x86, 0x5A, 0xEF, 0xA1, 0xC8, 0x01, 0x6B, 0xF4]);
struct CPK_DS_MPEG2Decoder;

const GUID CLSID_CAC3DecMediaObject = {0x03D7C802, 0xECFA, 0x47D9, [0xB2, 0x68, 0x5F, 0xB3, 0xE3, 0x10, 0xDE, 0xE4]};
@GUID(0x03D7C802, 0xECFA, 0x47D9, [0xB2, 0x68, 0x5F, 0xB3, 0xE3, 0x10, 0xDE, 0xE4]);
struct CAC3DecMediaObject;

const GUID CLSID_CPK_DS_AC3Decoder = {0x6C9C69D6, 0x0FFC, 0x4481, [0xAF, 0xDB, 0xCD, 0xF1, 0xC7, 0x9C, 0x6F, 0x3E]};
@GUID(0x6C9C69D6, 0x0FFC, 0x4481, [0xAF, 0xDB, 0xCD, 0xF1, 0xC7, 0x9C, 0x6F, 0x3E]);
struct CPK_DS_AC3Decoder;

const GUID CLSID_CMP3DecMediaObject = {0xBBEEA841, 0x0A63, 0x4F52, [0xA7, 0xAB, 0xA9, 0xB3, 0xA8, 0x4E, 0xD3, 0x8A]};
@GUID(0xBBEEA841, 0x0A63, 0x4F52, [0xA7, 0xAB, 0xA9, 0xB3, 0xA8, 0x4E, 0xD3, 0x8A]);
struct CMP3DecMediaObject;

const GUID CLSID_CResamplerMediaObject = {0xF447B69E, 0x1884, 0x4A7E, [0x80, 0x55, 0x34, 0x6F, 0x74, 0xD6, 0xED, 0xB3]};
@GUID(0xF447B69E, 0x1884, 0x4A7E, [0x80, 0x55, 0x34, 0x6F, 0x74, 0xD6, 0xED, 0xB3]);
struct CResamplerMediaObject;

const GUID CLSID_CResizerMediaObject = {0xD3EC8B8B, 0x7728, 0x4FD8, [0x9F, 0xE0, 0x7B, 0x67, 0xD1, 0x9F, 0x73, 0xA3]};
@GUID(0xD3EC8B8B, 0x7728, 0x4FD8, [0x9F, 0xE0, 0x7B, 0x67, 0xD1, 0x9F, 0x73, 0xA3]);
struct CResizerMediaObject;

const GUID CLSID_CInterlaceMediaObject = {0xB5A89C80, 0x4901, 0x407B, [0x9A, 0xBC, 0x90, 0xD9, 0xA6, 0x44, 0xBB, 0x46]};
@GUID(0xB5A89C80, 0x4901, 0x407B, [0x9A, 0xBC, 0x90, 0xD9, 0xA6, 0x44, 0xBB, 0x46]);
struct CInterlaceMediaObject;

const GUID CLSID_CWMAudioLFXAPO = {0x62DC1A93, 0xAE24, 0x464C, [0xA4, 0x3E, 0x45, 0x2F, 0x82, 0x4C, 0x42, 0x50]};
@GUID(0x62DC1A93, 0xAE24, 0x464C, [0xA4, 0x3E, 0x45, 0x2F, 0x82, 0x4C, 0x42, 0x50]);
struct CWMAudioLFXAPO;

const GUID CLSID_CWMAudioGFXAPO = {0x637C490D, 0xEEE3, 0x4C0A, [0x97, 0x3F, 0x37, 0x19, 0x58, 0x80, 0x2D, 0xA2]};
@GUID(0x637C490D, 0xEEE3, 0x4C0A, [0x97, 0x3F, 0x37, 0x19, 0x58, 0x80, 0x2D, 0xA2]);
struct CWMAudioGFXAPO;

const GUID CLSID_CWMAudioSpdTxDMO = {0x5210F8E4, 0xB0BB, 0x47C3, [0xA8, 0xD9, 0x7B, 0x22, 0x82, 0xCC, 0x79, 0xED]};
@GUID(0x5210F8E4, 0xB0BB, 0x47C3, [0xA8, 0xD9, 0x7B, 0x22, 0x82, 0xCC, 0x79, 0xED]);
struct CWMAudioSpdTxDMO;

const GUID CLSID_CWMAudioAEC = {0x745057C7, 0xF353, 0x4F2D, [0xA7, 0xEE, 0x58, 0x43, 0x44, 0x77, 0x73, 0x0E]};
@GUID(0x745057C7, 0xF353, 0x4F2D, [0xA7, 0xEE, 0x58, 0x43, 0x44, 0x77, 0x73, 0x0E]);
struct CWMAudioAEC;

const GUID CLSID_CClusterDetectorDmo = {0x36E820C4, 0x165A, 0x4521, [0x86, 0x3C, 0x61, 0x9E, 0x11, 0x60, 0xD4, 0xD4]};
@GUID(0x36E820C4, 0x165A, 0x4521, [0x86, 0x3C, 0x61, 0x9E, 0x11, 0x60, 0xD4, 0xD4]);
struct CClusterDetectorDmo;

const GUID CLSID_CColorControlDmo = {0x798059F0, 0x89CA, 0x4160, [0xB3, 0x25, 0xAE, 0xB4, 0x8E, 0xFE, 0x4F, 0x9A]};
@GUID(0x798059F0, 0x89CA, 0x4160, [0xB3, 0x25, 0xAE, 0xB4, 0x8E, 0xFE, 0x4F, 0x9A]);
struct CColorControlDmo;

const GUID CLSID_CColorConvertDMO = {0x98230571, 0x0087, 0x4204, [0xB0, 0x20, 0x32, 0x82, 0x53, 0x8E, 0x57, 0xD3]};
@GUID(0x98230571, 0x0087, 0x4204, [0xB0, 0x20, 0x32, 0x82, 0x53, 0x8E, 0x57, 0xD3]);
struct CColorConvertDMO;

const GUID CLSID_CColorLegalizerDmo = {0xFDFAA753, 0xE48E, 0x4E33, [0x9C, 0x74, 0x98, 0xA2, 0x7F, 0xC6, 0x72, 0x6A]};
@GUID(0xFDFAA753, 0xE48E, 0x4E33, [0x9C, 0x74, 0x98, 0xA2, 0x7F, 0xC6, 0x72, 0x6A]);
struct CColorLegalizerDmo;

const GUID CLSID_CFrameInterpDMO = {0x0A7CFE1B, 0x6AB5, 0x4334, [0x9E, 0xD8, 0x3F, 0x97, 0xCB, 0x37, 0xDA, 0xA1]};
@GUID(0x0A7CFE1B, 0x6AB5, 0x4334, [0x9E, 0xD8, 0x3F, 0x97, 0xCB, 0x37, 0xDA, 0xA1]);
struct CFrameInterpDMO;

const GUID CLSID_CFrameRateConvertDmo = {0x01F36CE2, 0x0907, 0x4D8B, [0x97, 0x9D, 0xF1, 0x51, 0xBE, 0x91, 0xC8, 0x83]};
@GUID(0x01F36CE2, 0x0907, 0x4D8B, [0x97, 0x9D, 0xF1, 0x51, 0xBE, 0x91, 0xC8, 0x83]);
struct CFrameRateConvertDmo;

const GUID CLSID_CResizerDMO = {0x1EA1EA14, 0x48F4, 0x4054, [0xAD, 0x1A, 0xE8, 0xAE, 0xE1, 0x0A, 0xC8, 0x05]};
@GUID(0x1EA1EA14, 0x48F4, 0x4054, [0xAD, 0x1A, 0xE8, 0xAE, 0xE1, 0x0A, 0xC8, 0x05]);
struct CResizerDMO;

const GUID CLSID_CShotDetectorDmo = {0x56AEFACD, 0x110C, 0x4397, [0x92, 0x92, 0xB0, 0xA0, 0xC6, 0x1B, 0x67, 0x50]};
@GUID(0x56AEFACD, 0x110C, 0x4397, [0x92, 0x92, 0xB0, 0xA0, 0xC6, 0x1B, 0x67, 0x50]);
struct CShotDetectorDmo;

const GUID CLSID_CSmpteTransformsDmo = {0xBDE6388B, 0xDA25, 0x485D, [0xBA, 0x7F, 0xFA, 0xBC, 0x28, 0xB2, 0x03, 0x18]};
@GUID(0xBDE6388B, 0xDA25, 0x485D, [0xBA, 0x7F, 0xFA, 0xBC, 0x28, 0xB2, 0x03, 0x18]);
struct CSmpteTransformsDmo;

const GUID CLSID_CThumbnailGeneratorDmo = {0x559C6BAD, 0x1EA8, 0x4963, [0xA0, 0x87, 0x8A, 0x68, 0x10, 0xF9, 0x21, 0x8B]};
@GUID(0x559C6BAD, 0x1EA8, 0x4963, [0xA0, 0x87, 0x8A, 0x68, 0x10, 0xF9, 0x21, 0x8B]);
struct CThumbnailGeneratorDmo;

const GUID CLSID_CTocGeneratorDmo = {0x4DDA1941, 0x77A0, 0x4FB1, [0xA5, 0x18, 0xE2, 0x18, 0x50, 0x41, 0xD7, 0x0C]};
@GUID(0x4DDA1941, 0x77A0, 0x4FB1, [0xA5, 0x18, 0xE2, 0x18, 0x50, 0x41, 0xD7, 0x0C]);
struct CTocGeneratorDmo;

const GUID CLSID_CMPEGAACDecMediaObject = {0x8DDE1772, 0xEDAD, 0x41C3, [0xB4, 0xBE, 0x1F, 0x30, 0xFB, 0x4E, 0xE0, 0xD6]};
@GUID(0x8DDE1772, 0xEDAD, 0x41C3, [0xB4, 0xBE, 0x1F, 0x30, 0xFB, 0x4E, 0xE0, 0xD6]);
struct CMPEGAACDecMediaObject;

const GUID CLSID_CNokiaAACDecMediaObject = {0x3CB2BDE4, 0x4E29, 0x4C44, [0xA7, 0x3E, 0x2D, 0x7C, 0x2C, 0x46, 0xD6, 0xEC]};
@GUID(0x3CB2BDE4, 0x4E29, 0x4C44, [0xA7, 0x3E, 0x2D, 0x7C, 0x2C, 0x46, 0xD6, 0xEC]);
struct CNokiaAACDecMediaObject;

const GUID CLSID_CVodafoneAACDecMediaObject = {0x7F36F942, 0xDCF3, 0x4D82, [0x92, 0x89, 0x5B, 0x18, 0x20, 0x27, 0x8F, 0x7C]};
@GUID(0x7F36F942, 0xDCF3, 0x4D82, [0x92, 0x89, 0x5B, 0x18, 0x20, 0x27, 0x8F, 0x7C]);
struct CVodafoneAACDecMediaObject;

const GUID CLSID_CZuneAACCCDecMediaObject = {0xA74E98F2, 0x52D6, 0x4B4E, [0x88, 0x5B, 0xE0, 0xA6, 0xCA, 0x4F, 0x18, 0x7A]};
@GUID(0xA74E98F2, 0x52D6, 0x4B4E, [0x88, 0x5B, 0xE0, 0xA6, 0xCA, 0x4F, 0x18, 0x7A]);
struct CZuneAACCCDecMediaObject;

const GUID CLSID_CNokiaAACCCDecMediaObject = {0xEABF7A6F, 0xCCBA, 0x4D60, [0x86, 0x20, 0xB1, 0x52, 0xCC, 0x97, 0x72, 0x63]};
@GUID(0xEABF7A6F, 0xCCBA, 0x4D60, [0x86, 0x20, 0xB1, 0x52, 0xCC, 0x97, 0x72, 0x63]);
struct CNokiaAACCCDecMediaObject;

const GUID CLSID_CVodafoneAACCCDecMediaObject = {0x7E76BF7F, 0xC993, 0x4E26, [0x8F, 0xAB, 0x47, 0x0A, 0x70, 0xC0, 0xD5, 0x9C]};
@GUID(0x7E76BF7F, 0xC993, 0x4E26, [0x8F, 0xAB, 0x47, 0x0A, 0x70, 0xC0, 0xD5, 0x9C]);
struct CVodafoneAACCCDecMediaObject;

const GUID CLSID_CMPEG2EncoderDS = {0x5F5AFF4A, 0x2F7F, 0x4279, [0x88, 0xC2, 0xCD, 0x88, 0xEB, 0x39, 0xD1, 0x44]};
@GUID(0x5F5AFF4A, 0x2F7F, 0x4279, [0x88, 0xC2, 0xCD, 0x88, 0xEB, 0x39, 0xD1, 0x44]);
struct CMPEG2EncoderDS;

const GUID CLSID_CMPEG2EncoderVideoDS = {0x42150CD9, 0xCA9A, 0x4EA5, [0x99, 0x39, 0x30, 0xEE, 0x03, 0x7F, 0x6E, 0x74]};
@GUID(0x42150CD9, 0xCA9A, 0x4EA5, [0x99, 0x39, 0x30, 0xEE, 0x03, 0x7F, 0x6E, 0x74]);
struct CMPEG2EncoderVideoDS;

const GUID CLSID_CMPEG2EncoderAudioDS = {0xACD453BC, 0xC58A, 0x44D1, [0xBB, 0xF5, 0xBF, 0xB3, 0x25, 0xBE, 0x2D, 0x78]};
@GUID(0xACD453BC, 0xC58A, 0x44D1, [0xBB, 0xF5, 0xBF, 0xB3, 0x25, 0xBE, 0x2D, 0x78]);
struct CMPEG2EncoderAudioDS;

const GUID CLSID_CMPEG2AudDecoderDS = {0xE1F1A0B8, 0xBEEE, 0x490D, [0xBA, 0x7C, 0x06, 0x6C, 0x40, 0xB5, 0xE2, 0xB9]};
@GUID(0xE1F1A0B8, 0xBEEE, 0x490D, [0xBA, 0x7C, 0x06, 0x6C, 0x40, 0xB5, 0xE2, 0xB9]);
struct CMPEG2AudDecoderDS;

const GUID CLSID_CMPEG2VidDecoderDS = {0x212690FB, 0x83E5, 0x4526, [0x8F, 0xD7, 0x74, 0x47, 0x8B, 0x79, 0x39, 0xCD]};
@GUID(0x212690FB, 0x83E5, 0x4526, [0x8F, 0xD7, 0x74, 0x47, 0x8B, 0x79, 0x39, 0xCD]);
struct CMPEG2VidDecoderDS;

const GUID CLSID_CDTVAudDecoderDS = {0x8E269032, 0xFE03, 0x4753, [0x9B, 0x17, 0x18, 0x25, 0x3C, 0x21, 0x72, 0x2E]};
@GUID(0x8E269032, 0xFE03, 0x4753, [0x9B, 0x17, 0x18, 0x25, 0x3C, 0x21, 0x72, 0x2E]);
struct CDTVAudDecoderDS;

const GUID CLSID_CDTVVidDecoderDS = {0x64777DC8, 0x4E24, 0x4BEB, [0x9D, 0x19, 0x60, 0xA3, 0x5B, 0xE1, 0xDA, 0xAF]};
@GUID(0x64777DC8, 0x4E24, 0x4BEB, [0x9D, 0x19, 0x60, 0xA3, 0x5B, 0xE1, 0xDA, 0xAF]);
struct CDTVVidDecoderDS;

const GUID CLSID_CMSAC3Enc = {0xC6B400E2, 0x20A7, 0x4E58, [0xA2, 0xFE, 0x24, 0x61, 0x96, 0x82, 0xCE, 0x6C]};
@GUID(0xC6B400E2, 0x20A7, 0x4E58, [0xA2, 0xFE, 0x24, 0x61, 0x96, 0x82, 0xCE, 0x6C]);
struct CMSAC3Enc;

const GUID CLSID_CMSH264DecoderMFT = {0x62CE7E72, 0x4C71, 0x4D20, [0xB1, 0x5D, 0x45, 0x28, 0x31, 0xA8, 0x7D, 0x9D]};
@GUID(0x62CE7E72, 0x4C71, 0x4D20, [0xB1, 0x5D, 0x45, 0x28, 0x31, 0xA8, 0x7D, 0x9D]);
struct CMSH264DecoderMFT;

const GUID CLSID_CMSH263EncoderMFT = {0xBC47FCFE, 0x98A0, 0x4F27, [0xBB, 0x07, 0x69, 0x8A, 0xF2, 0x4F, 0x2B, 0x38]};
@GUID(0xBC47FCFE, 0x98A0, 0x4F27, [0xBB, 0x07, 0x69, 0x8A, 0xF2, 0x4F, 0x2B, 0x38]);
struct CMSH263EncoderMFT;

const GUID CLSID_CMSH264EncoderMFT = {0x6CA50344, 0x051A, 0x4DED, [0x97, 0x79, 0xA4, 0x33, 0x05, 0x16, 0x5E, 0x35]};
@GUID(0x6CA50344, 0x051A, 0x4DED, [0x97, 0x79, 0xA4, 0x33, 0x05, 0x16, 0x5E, 0x35]);
struct CMSH264EncoderMFT;

const GUID CLSID_CMSH265EncoderMFT = {0xF2F84074, 0x8BCA, 0x40BD, [0x91, 0x59, 0xE8, 0x80, 0xF6, 0x73, 0xDD, 0x3B]};
@GUID(0xF2F84074, 0x8BCA, 0x40BD, [0x91, 0x59, 0xE8, 0x80, 0xF6, 0x73, 0xDD, 0x3B]);
struct CMSH265EncoderMFT;

const GUID CLSID_CMSVPXEncoderMFT = {0xAEB6C755, 0x2546, 0x4881, [0x82, 0xCC, 0xE1, 0x5A, 0xE5, 0xEB, 0xFF, 0x3D]};
@GUID(0xAEB6C755, 0x2546, 0x4881, [0x82, 0xCC, 0xE1, 0x5A, 0xE5, 0xEB, 0xFF, 0x3D]);
struct CMSVPXEncoderMFT;

const GUID CLSID_CMSH264RemuxMFT = {0x05A47EBB, 0x8BF0, 0x4CBF, [0xAD, 0x2F, 0x3B, 0x71, 0xD7, 0x58, 0x66, 0xF5]};
@GUID(0x05A47EBB, 0x8BF0, 0x4CBF, [0xAD, 0x2F, 0x3B, 0x71, 0xD7, 0x58, 0x66, 0xF5]);
struct CMSH264RemuxMFT;

const GUID CLSID_CMSAACDecMFT = {0x32D186A7, 0x218F, 0x4C75, [0x88, 0x76, 0xDD, 0x77, 0x27, 0x3A, 0x89, 0x99]};
@GUID(0x32D186A7, 0x218F, 0x4C75, [0x88, 0x76, 0xDD, 0x77, 0x27, 0x3A, 0x89, 0x99]);
struct CMSAACDecMFT;

const GUID CLSID_AACMFTEncoder = {0x93AF0C51, 0x2275, 0x45D2, [0xA3, 0x5B, 0xF2, 0xBA, 0x21, 0xCA, 0xED, 0x00]};
@GUID(0x93AF0C51, 0x2275, 0x45D2, [0xA3, 0x5B, 0xF2, 0xBA, 0x21, 0xCA, 0xED, 0x00]);
struct AACMFTEncoder;

const GUID CLSID_CMSDDPlusDecMFT = {0x177C0AFE, 0x900B, 0x48D4, [0x9E, 0x4C, 0x57, 0xAD, 0xD2, 0x50, 0xB3, 0xD4]};
@GUID(0x177C0AFE, 0x900B, 0x48D4, [0x9E, 0x4C, 0x57, 0xAD, 0xD2, 0x50, 0xB3, 0xD4]);
struct CMSDDPlusDecMFT;

const GUID CLSID_CMPEG2VideoEncoderMFT = {0xE6335F02, 0x80B7, 0x4DC4, [0xAD, 0xFA, 0xDF, 0xE7, 0x21, 0x0D, 0x20, 0xD5]};
@GUID(0xE6335F02, 0x80B7, 0x4DC4, [0xAD, 0xFA, 0xDF, 0xE7, 0x21, 0x0D, 0x20, 0xD5]);
struct CMPEG2VideoEncoderMFT;

const GUID CLSID_CMPEG2AudioEncoderMFT = {0x46A4DD5C, 0x73F8, 0x4304, [0x94, 0xDF, 0x30, 0x8F, 0x76, 0x09, 0x74, 0xF4]};
@GUID(0x46A4DD5C, 0x73F8, 0x4304, [0x94, 0xDF, 0x30, 0x8F, 0x76, 0x09, 0x74, 0xF4]);
struct CMPEG2AudioEncoderMFT;

const GUID CLSID_CMSMPEGDecoderMFT = {0x2D709E52, 0x123F, 0x49B5, [0x9C, 0xBC, 0x9A, 0xF5, 0xCD, 0xE2, 0x8F, 0xB9]};
@GUID(0x2D709E52, 0x123F, 0x49B5, [0x9C, 0xBC, 0x9A, 0xF5, 0xCD, 0xE2, 0x8F, 0xB9]);
struct CMSMPEGDecoderMFT;

const GUID CLSID_CMSMPEGAudDecMFT = {0x70707B39, 0xB2CA, 0x4015, [0xAB, 0xEA, 0xF8, 0x44, 0x7D, 0x22, 0xD8, 0x8B]};
@GUID(0x70707B39, 0xB2CA, 0x4015, [0xAB, 0xEA, 0xF8, 0x44, 0x7D, 0x22, 0xD8, 0x8B]);
struct CMSMPEGAudDecMFT;

const GUID CLSID_CMSDolbyDigitalEncMFT = {0xAC3315C9, 0xF481, 0x45D7, [0x82, 0x6C, 0x0B, 0x40, 0x6C, 0x1F, 0x64, 0xB8]};
@GUID(0xAC3315C9, 0xF481, 0x45D7, [0x82, 0x6C, 0x0B, 0x40, 0x6C, 0x1F, 0x64, 0xB8]);
struct CMSDolbyDigitalEncMFT;

const GUID CLSID_MP3ACMCodecWrapper = {0x11103421, 0x354C, 0x4CCA, [0xA7, 0xA3, 0x1A, 0xFF, 0x9A, 0x5B, 0x67, 0x01]};
@GUID(0x11103421, 0x354C, 0x4CCA, [0xA7, 0xA3, 0x1A, 0xFF, 0x9A, 0x5B, 0x67, 0x01]);
struct MP3ACMCodecWrapper;

const GUID CLSID_ALawCodecWrapper = {0x36CB6E0C, 0x78C1, 0x42B2, [0x99, 0x43, 0x84, 0x62, 0x62, 0xF3, 0x17, 0x86]};
@GUID(0x36CB6E0C, 0x78C1, 0x42B2, [0x99, 0x43, 0x84, 0x62, 0x62, 0xF3, 0x17, 0x86]);
struct ALawCodecWrapper;

const GUID CLSID_MULawCodecWrapper = {0x92B66080, 0x5E2D, 0x449E, [0x90, 0xC4, 0xC4, 0x1F, 0x26, 0x8E, 0x55, 0x14]};
@GUID(0x92B66080, 0x5E2D, 0x449E, [0x90, 0xC4, 0xC4, 0x1F, 0x26, 0x8E, 0x55, 0x14]);
struct MULawCodecWrapper;

const GUID CLSID_CMSVideoDSPMFT = {0x51571744, 0x7FE4, 0x4FF2, [0xA4, 0x98, 0x2D, 0xC3, 0x4F, 0xF7, 0x4F, 0x1B]};
@GUID(0x51571744, 0x7FE4, 0x4FF2, [0xA4, 0x98, 0x2D, 0xC3, 0x4F, 0xF7, 0x4F, 0x1B]);
struct CMSVideoDSPMFT;

const GUID CLSID_VorbisDecoderMFT = {0x1A198EF2, 0x60E5, 0x4EA8, [0x90, 0xD8, 0xDA, 0x1F, 0x28, 0x32, 0xC2, 0x88]};
@GUID(0x1A198EF2, 0x60E5, 0x4EA8, [0x90, 0xD8, 0xDA, 0x1F, 0x28, 0x32, 0xC2, 0x88]);
struct VorbisDecoderMFT;

const GUID CLSID_CMSFLACDecMFT = {0x6B0B3E6B, 0xA2C5, 0x4514, [0x80, 0x55, 0xAF, 0xE8, 0xA9, 0x52, 0x42, 0xD9]};
@GUID(0x6B0B3E6B, 0xA2C5, 0x4514, [0x80, 0x55, 0xAF, 0xE8, 0xA9, 0x52, 0x42, 0xD9]);
struct CMSFLACDecMFT;

const GUID CLSID_CMSFLACEncMFT = {0x128509E9, 0xC44E, 0x45DC, [0x95, 0xE9, 0xC2, 0x55, 0xB8, 0xF4, 0x66, 0xA6]};
@GUID(0x128509E9, 0xC44E, 0x45DC, [0x95, 0xE9, 0xC2, 0x55, 0xB8, 0xF4, 0x66, 0xA6]);
struct CMSFLACEncMFT;

const GUID CLSID_MFFLACBytestreamHandler = {0x0E41CFB8, 0x0506, 0x40F4, [0xA5, 0x16, 0x77, 0xCC, 0x23, 0x64, 0x2D, 0x91]};
@GUID(0x0E41CFB8, 0x0506, 0x40F4, [0xA5, 0x16, 0x77, 0xCC, 0x23, 0x64, 0x2D, 0x91]);
struct MFFLACBytestreamHandler;

const GUID CLSID_MFFLACSinkClassFactory = {0x7D39C56F, 0x6075, 0x47C9, [0x9B, 0xAE, 0x8C, 0xF9, 0xE5, 0x31, 0xB5, 0xF5]};
@GUID(0x7D39C56F, 0x6075, 0x47C9, [0x9B, 0xAE, 0x8C, 0xF9, 0xE5, 0x31, 0xB5, 0xF5]);
struct MFFLACSinkClassFactory;

const GUID CLSID_CMSALACDecMFT = {0xC0CD7D12, 0x31FC, 0x4BBC, [0xB3, 0x63, 0x73, 0x22, 0xEE, 0x3E, 0x18, 0x79]};
@GUID(0xC0CD7D12, 0x31FC, 0x4BBC, [0xB3, 0x63, 0x73, 0x22, 0xEE, 0x3E, 0x18, 0x79]);
struct CMSALACDecMFT;

const GUID CLSID_CMSALACEncMFT = {0x9AB6A28C, 0x748E, 0x4B6A, [0xBF, 0xFF, 0xCC, 0x44, 0x3B, 0x8E, 0x8F, 0xB4]};
@GUID(0x9AB6A28C, 0x748E, 0x4B6A, [0xBF, 0xFF, 0xCC, 0x44, 0x3B, 0x8E, 0x8F, 0xB4]);
struct CMSALACEncMFT;

const GUID CLSID_CMSOpusDecMFT = {0x63E17C10, 0x2D43, 0x4C42, [0x8F, 0xE3, 0x8D, 0x8B, 0x63, 0xE4, 0x6A, 0x6A]};
@GUID(0x63E17C10, 0x2D43, 0x4C42, [0x8F, 0xE3, 0x8D, 0x8B, 0x63, 0xE4, 0x6A, 0x6A]);
struct CMSOpusDecMFT;

const GUID CLSID_MSAMRNBDecoder = {0x265011AE, 0x5481, 0x4F77, [0xA2, 0x95, 0xAB, 0xB6, 0xFF, 0xE8, 0xD6, 0x3E]};
@GUID(0x265011AE, 0x5481, 0x4F77, [0xA2, 0x95, 0xAB, 0xB6, 0xFF, 0xE8, 0xD6, 0x3E]);
struct MSAMRNBDecoder;

const GUID CLSID_MSAMRNBEncoder = {0x2FAE8AFE, 0x04A3, 0x423A, [0xA8, 0x14, 0x85, 0xDB, 0x45, 0x47, 0x12, 0xB0]};
@GUID(0x2FAE8AFE, 0x04A3, 0x423A, [0xA8, 0x14, 0x85, 0xDB, 0x45, 0x47, 0x12, 0xB0]);
struct MSAMRNBEncoder;

const GUID CLSID_MFAMRNBByteStreamHandler = {0xEFE6208A, 0x0A2C, 0x49FA, [0x8A, 0x01, 0x37, 0x68, 0xB5, 0x59, 0xB6, 0xDA]};
@GUID(0xEFE6208A, 0x0A2C, 0x49FA, [0x8A, 0x01, 0x37, 0x68, 0xB5, 0x59, 0xB6, 0xDA]);
struct MFAMRNBByteStreamHandler;

const GUID CLSID_MFAMRNBSinkClassFactory = {0xB0271158, 0x70D2, 0x4C5B, [0x9F, 0x94, 0x76, 0xF5, 0x49, 0xD9, 0x0F, 0xDF]};
@GUID(0xB0271158, 0x70D2, 0x4C5B, [0x9F, 0x94, 0x76, 0xF5, 0x49, 0xD9, 0x0F, 0xDF]);
struct MFAMRNBSinkClassFactory;

enum _DMO_INPUT_DATA_BUFFER_FLAGS
{
    DMO_INPUT_DATA_BUFFERF_SYNCPOINT = 1,
    DMO_INPUT_DATA_BUFFERF_TIME = 2,
    DMO_INPUT_DATA_BUFFERF_TIMELENGTH = 4,
    DMO_INPUT_DATA_BUFFERF_DISCONTINUITY = 8,
}

enum _DMO_OUTPUT_DATA_BUFFER_FLAGS
{
    DMO_OUTPUT_DATA_BUFFERF_SYNCPOINT = 1,
    DMO_OUTPUT_DATA_BUFFERF_TIME = 2,
    DMO_OUTPUT_DATA_BUFFERF_TIMELENGTH = 4,
    DMO_OUTPUT_DATA_BUFFERF_DISCONTINUITY = 8,
    DMO_OUTPUT_DATA_BUFFERF_INCOMPLETE = 16777216,
}

enum _DMO_INPUT_STATUS_FLAGS
{
    DMO_INPUT_STATUSF_ACCEPT_DATA = 1,
}

enum _DMO_INPUT_STREAM_INFO_FLAGS
{
    DMO_INPUT_STREAMF_WHOLE_SAMPLES = 1,
    DMO_INPUT_STREAMF_SINGLE_SAMPLE_PER_BUFFER = 2,
    DMO_INPUT_STREAMF_FIXED_SAMPLE_SIZE = 4,
    DMO_INPUT_STREAMF_HOLDS_BUFFERS = 8,
}

enum _DMO_OUTPUT_STREAM_INFO_FLAGS
{
    DMO_OUTPUT_STREAMF_WHOLE_SAMPLES = 1,
    DMO_OUTPUT_STREAMF_SINGLE_SAMPLE_PER_BUFFER = 2,
    DMO_OUTPUT_STREAMF_FIXED_SAMPLE_SIZE = 4,
    DMO_OUTPUT_STREAMF_DISCARDABLE = 8,
    DMO_OUTPUT_STREAMF_OPTIONAL = 16,
}

enum _DMO_SET_TYPE_FLAGS
{
    DMO_SET_TYPEF_TEST_ONLY = 1,
    DMO_SET_TYPEF_CLEAR = 2,
}

enum _DMO_PROCESS_OUTPUT_FLAGS
{
    DMO_PROCESS_OUTPUT_DISCARD_WHEN_NO_BUFFER = 1,
}

enum _DMO_INPLACE_PROCESS_FLAGS
{
    DMO_INPLACE_NORMAL = 0,
    DMO_INPLACE_ZERO = 1,
}

enum _DMO_QUALITY_STATUS_FLAGS
{
    DMO_QUALITY_STATUS_ENABLED = 1,
}

enum _DMO_VIDEO_OUTPUT_STREAM_FLAGS
{
    DMO_VOSF_NEEDS_PREVIOUS_SAMPLE = 1,
}

enum WMT_PROP_DATATYPE
{
    WMT_PROP_TYPE_DWORD = 0,
    WMT_PROP_TYPE_STRING = 1,
    WMT_PROP_TYPE_BINARY = 2,
    WMT_PROP_TYPE_BOOL = 3,
    WMT_PROP_TYPE_QWORD = 4,
    WMT_PROP_TYPE_WORD = 5,
    WMT_PROP_TYPE_GUID = 6,
}

const GUID IID_IWMValidate = {0xCEE3DEF2, 0x3808, 0x414D, [0xBE, 0x66, 0xFA, 0xFD, 0x47, 0x22, 0x10, 0xBC]};
@GUID(0xCEE3DEF2, 0x3808, 0x414D, [0xBE, 0x66, 0xFA, 0xFD, 0x47, 0x22, 0x10, 0xBC]);
interface IWMValidate : IUnknown
{
    HRESULT SetIdentifier(Guid guidValidationID);
}

const GUID IID_IValidateBinding = {0x04A578B2, 0xE778, 0x422A, [0xA8, 0x05, 0xB3, 0xEE, 0x54, 0xD9, 0x0B, 0xD9]};
@GUID(0x04A578B2, 0xE778, 0x422A, [0xA8, 0x05, 0xB3, 0xEE, 0x54, 0xD9, 0x0B, 0xD9]);
interface IValidateBinding : IUnknown
{
    HRESULT GetIdentifier(Guid guidLicensorID, char* pbEphemeron, uint cbEphemeron, char* ppbBlobValidationID, uint* pcbBlobSize);
}

const GUID IID_IWMVideoDecoderHurryup = {0x352BB3BD, 0x2D4D, 0x4323, [0x9E, 0x71, 0xDC, 0xDC, 0xFB, 0xD5, 0x3C, 0xA6]};
@GUID(0x352BB3BD, 0x2D4D, 0x4323, [0x9E, 0x71, 0xDC, 0xDC, 0xFB, 0xD5, 0x3C, 0xA6]);
interface IWMVideoDecoderHurryup : IUnknown
{
    HRESULT SetHurryup(int lHurryup);
    HRESULT GetHurryup(int* plHurryup);
}

const GUID IID_IWMVideoForceKeyFrame = {0x9F8496BE, 0x5B9A, 0x41B9, [0xA9, 0xE8, 0xF2, 0x1C, 0xD8, 0x05, 0x96, 0xC2]};
@GUID(0x9F8496BE, 0x5B9A, 0x41B9, [0xA9, 0xE8, 0xF2, 0x1C, 0xD8, 0x05, 0x96, 0xC2]);
interface IWMVideoForceKeyFrame : IUnknown
{
    HRESULT SetKeyFrame();
}

const GUID IID_IWMCodecStrings = {0xA7B2504B, 0xE58A, 0x47FB, [0x95, 0x8B, 0xCA, 0xC7, 0x16, 0x5A, 0x05, 0x7D]};
@GUID(0xA7B2504B, 0xE58A, 0x47FB, [0x95, 0x8B, 0xCA, 0xC7, 0x16, 0x5A, 0x05, 0x7D]);
interface IWMCodecStrings : IUnknown
{
    HRESULT GetName(DMO_MEDIA_TYPE* pmt, uint cchLength, const(wchar)* szName, uint* pcchLength);
    HRESULT GetDescription(DMO_MEDIA_TYPE* pmt, uint cchLength, const(wchar)* szDescription, uint* pcchLength);
}

const GUID IID_IWMCodecProps = {0x2573E11A, 0xF01A, 0x4FDD, [0xA9, 0x8D, 0x63, 0xB8, 0xE0, 0xBA, 0x95, 0x89]};
@GUID(0x2573E11A, 0xF01A, 0x4FDD, [0xA9, 0x8D, 0x63, 0xB8, 0xE0, 0xBA, 0x95, 0x89]);
interface IWMCodecProps : IUnknown
{
    HRESULT GetFormatProp(DMO_MEDIA_TYPE* pmt, const(wchar)* pszName, WMT_PROP_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    HRESULT GetCodecProp(uint dwFormat, const(wchar)* pszName, WMT_PROP_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
}

const GUID IID_IWMCodecLeakyBucket = {0xA81BA647, 0x6227, 0x43B7, [0xB2, 0x31, 0xC7, 0xB1, 0x51, 0x35, 0xDD, 0x7D]};
@GUID(0xA81BA647, 0x6227, 0x43B7, [0xB2, 0x31, 0xC7, 0xB1, 0x51, 0x35, 0xDD, 0x7D]);
interface IWMCodecLeakyBucket : IUnknown
{
    HRESULT SetBufferSizeBits(uint ulBufferSize);
    HRESULT GetBufferSizeBits(uint* pulBufferSize);
    HRESULT SetBufferFullnessBits(uint ulBufferFullness);
    HRESULT GetBufferFullnessBits(uint* pulBufferFullness);
}

const GUID IID_IWMCodecOutputTimestamp = {0xB72ADF95, 0x7ADC, 0x4A72, [0xBC, 0x05, 0x57, 0x7D, 0x8E, 0xA6, 0xBF, 0x68]};
@GUID(0xB72ADF95, 0x7ADC, 0x4A72, [0xBC, 0x05, 0x57, 0x7D, 0x8E, 0xA6, 0xBF, 0x68]);
interface IWMCodecOutputTimestamp : IUnknown
{
    HRESULT GetNextOutputTime(long* prtTime);
}

const GUID IID_IWMVideoDecoderReconBuffer = {0x45BDA2AC, 0x88E2, 0x4923, [0x98, 0xBA, 0x39, 0x49, 0x08, 0x07, 0x11, 0xA3]};
@GUID(0x45BDA2AC, 0x88E2, 0x4923, [0x98, 0xBA, 0x39, 0x49, 0x08, 0x07, 0x11, 0xA3]);
interface IWMVideoDecoderReconBuffer : IUnknown
{
    HRESULT GetReconstructedVideoFrameSize(uint* pdwSize);
    HRESULT GetReconstructedVideoFrame(IMediaBuffer pBuf);
    HRESULT SetReconstructedVideoFrame(IMediaBuffer pBuf);
}

const GUID IID_IWMCodecPrivateData = {0x73F0BE8E, 0x57F7, 0x4F01, [0xAA, 0x66, 0x9F, 0x57, 0x34, 0x0C, 0xFE, 0x0E]};
@GUID(0x73F0BE8E, 0x57F7, 0x4F01, [0xAA, 0x66, 0x9F, 0x57, 0x34, 0x0C, 0xFE, 0x0E]);
interface IWMCodecPrivateData : IUnknown
{
    HRESULT SetPartialOutputType(DMO_MEDIA_TYPE* pmt);
    HRESULT GetPrivateData(ubyte* pbData, uint* pcbData);
}

const GUID IID_IWMSampleExtensionSupport = {0x9BCA9884, 0x0604, 0x4C2A, [0x87, 0xDA, 0x79, 0x3F, 0xF4, 0xD5, 0x86, 0xC3]};
@GUID(0x9BCA9884, 0x0604, 0x4C2A, [0x87, 0xDA, 0x79, 0x3F, 0xF4, 0xD5, 0x86, 0xC3]);
interface IWMSampleExtensionSupport : IUnknown
{
    HRESULT SetUseSampleExtensions(BOOL fUseExtensions);
}

const GUID IID_IWMResamplerProps = {0xE7E9984F, 0xF09F, 0x4DA4, [0x90, 0x3F, 0x6E, 0x2E, 0x0E, 0xFE, 0x56, 0xB5]};
@GUID(0xE7E9984F, 0xF09F, 0x4DA4, [0x90, 0x3F, 0x6E, 0x2E, 0x0E, 0xFE, 0x56, 0xB5]);
interface IWMResamplerProps : IUnknown
{
    HRESULT SetHalfFilterLength(int lhalfFilterLen);
    HRESULT SetUserChannelMtx(float* userChannelMtx);
}

const GUID IID_IWMResizerProps = {0x57665D4C, 0x0414, 0x4FAA, [0x90, 0x5B, 0x10, 0xE5, 0x46, 0xF8, 0x1C, 0x33]};
@GUID(0x57665D4C, 0x0414, 0x4FAA, [0x90, 0x5B, 0x10, 0xE5, 0x46, 0xF8, 0x1C, 0x33]);
interface IWMResizerProps : IUnknown
{
    HRESULT SetResizerQuality(int lquality);
    HRESULT SetInterlaceMode(int lmode);
    HRESULT SetClipRegion(int lClipOriXSrc, int lClipOriYSrc, int lClipWidthSrc, int lClipHeightSrc);
    HRESULT SetFullCropRegion(int lClipOriXSrc, int lClipOriYSrc, int lClipWidthSrc, int lClipHeightSrc, int lClipOriXDst, int lClipOriYDst, int lClipWidthDst, int lClipHeightDst);
    HRESULT GetFullCropRegion(int* lClipOriXSrc, int* lClipOriYSrc, int* lClipWidthSrc, int* lClipHeightSrc, int* lClipOriXDst, int* lClipOriYDst, int* lClipWidthDst, int* lClipHeightDst);
}

const GUID IID_IWMColorLegalizerProps = {0x776C93B3, 0xB72D, 0x4508, [0xB6, 0xD0, 0x20, 0x87, 0x85, 0xF5, 0x53, 0xE7]};
@GUID(0x776C93B3, 0xB72D, 0x4508, [0xB6, 0xD0, 0x20, 0x87, 0x85, 0xF5, 0x53, 0xE7]);
interface IWMColorLegalizerProps : IUnknown
{
    HRESULT SetColorLegalizerQuality(int lquality);
}

const GUID IID_IWMInterlaceProps = {0x7B12E5D1, 0xBD22, 0x48EA, [0xBC, 0x06, 0x98, 0xE8, 0x93, 0x22, 0x1C, 0x89]};
@GUID(0x7B12E5D1, 0xBD22, 0x48EA, [0xBC, 0x06, 0x98, 0xE8, 0x93, 0x22, 0x1C, 0x89]);
interface IWMInterlaceProps : IUnknown
{
    HRESULT SetProcessType(int iProcessType);
    HRESULT SetInitInverseTeleCinePattern(int iInitPattern);
    HRESULT SetLastFrame();
}

const GUID IID_IWMFrameInterpProps = {0x4C06BB9B, 0x626C, 0x4614, [0x83, 0x29, 0xCC, 0x6A, 0x21, 0xB9, 0x3F, 0xA0]};
@GUID(0x4C06BB9B, 0x626C, 0x4614, [0x83, 0x29, 0xCC, 0x6A, 0x21, 0xB9, 0x3F, 0xA0]);
interface IWMFrameInterpProps : IUnknown
{
    HRESULT SetFrameRateIn(int lFrameRate, int lScale);
    HRESULT SetFrameRateOut(int lFrameRate, int lScale);
    HRESULT SetFrameInterpEnabled(BOOL bFIEnabled);
    HRESULT SetComplexityLevel(int iComplexity);
}

const GUID IID_IWMColorConvProps = {0xE6A49E22, 0xC099, 0x421D, [0xAA, 0xD3, 0xC0, 0x61, 0xFB, 0x4A, 0xE8, 0x5B]};
@GUID(0xE6A49E22, 0xC099, 0x421D, [0xAA, 0xD3, 0xC0, 0x61, 0xFB, 0x4A, 0xE8, 0x5B]);
interface IWMColorConvProps : IUnknown
{
    HRESULT SetMode(int lMode);
    HRESULT SetFullCroppingParam(int lSrcCropLeft, int lSrcCropTop, int lDstCropLeft, int lDstCropTop, int lCropWidth, int lCropHeight);
}

enum WMV_DYNAMIC_FLAGS
{
    WMV_DYNAMIC_BITRATE = 1,
    WMV_DYNAMIC_RESOLUTION = 2,
    WMV_DYNAMIC_COMPLEXITY = 4,
}

enum MF_AUVRHP_ROOMMODEL
{
    VRHP_SMALLROOM = 0,
    VRHP_MEDIUMROOM = 1,
    VRHP_BIGROOM = 2,
    VRHP_CUSTUMIZEDROOM = 3,
}

enum AEC_SYSTEM_MODE
{
    SINGLE_CHANNEL_AEC = 0,
    ADAPTIVE_ARRAY_ONLY = 1,
    OPTIBEAM_ARRAY_ONLY = 2,
    ADAPTIVE_ARRAY_AND_AEC = 3,
    OPTIBEAM_ARRAY_AND_AEC = 4,
    SINGLE_CHANNEL_NSAGC = 5,
    MODE_NOT_SET = 6,
}

struct AecQualityMetrics_Struct
{
    long i64Timestamp;
    ubyte ConvergenceFlag;
    ubyte MicClippedFlag;
    ubyte MicSilenceFlag;
    ubyte PstvFeadbackFlag;
    ubyte SpkClippedFlag;
    ubyte SpkMuteFlag;
    ubyte GlitchFlag;
    ubyte DoubleTalkFlag;
    uint uGlitchCount;
    uint uMicClipCount;
    float fDuration;
    float fTSVariance;
    float fTSDriftRate;
    float fVoiceLevel;
    float fNoiseLevel;
    float fERLE;
    float fAvgERLE;
    uint dwReserved;
}

enum AEC_VAD_MODE
{
    AEC_VAD_DISABLED = 0,
    AEC_VAD_NORMAL = 1,
    AEC_VAD_FOR_AGC = 2,
    AEC_VAD_FOR_SILENCE_SUPPRESSION = 3,
}

enum AEC_INPUT_STREAM
{
    AEC_CAPTURE_STREAM = 0,
    AEC_REFERENCE_STREAM = 1,
}

enum MIC_ARRAY_MODE
{
    MICARRAY_SINGLE_CHAN = 0,
    MICARRAY_SIMPLE_SUM = 256,
    MICARRAY_SINGLE_BEAM = 512,
    MICARRAY_FIXED_BEAM = 1024,
    MICARRAY_EXTERN_BEAM = 2048,
}

enum MFVideoDSPMode
{
    MFVideoDSPMode_Passthrough = 1,
    MFVideoDSPMode_Stabilization = 4,
}

struct TOC_DESCRIPTOR
{
    Guid guidID;
    ushort wStreamNumber;
    Guid guidType;
    ushort wLanguageIndex;
}

struct TOC_ENTRY_DESCRIPTOR
{
    ulong qwStartTime;
    ulong qwEndTime;
    ulong qwStartPacketOffset;
    ulong qwEndPacketOffset;
    ulong qwRepresentativeFrameTime;
}

enum TOC_POS_TYPE
{
    TOC_POS_INHEADER = 0,
    TOC_POS_TOPLEVELOBJECT = 1,
}

const GUID IID_ITocEntry = {0xF22F5E06, 0x585C, 0x4DEF, [0x85, 0x23, 0x65, 0x55, 0xCF, 0xBC, 0x0C, 0xB3]};
@GUID(0xF22F5E06, 0x585C, 0x4DEF, [0x85, 0x23, 0x65, 0x55, 0xCF, 0xBC, 0x0C, 0xB3]);
interface ITocEntry : IUnknown
{
    HRESULT SetTitle(const(wchar)* pwszTitle);
    HRESULT GetTitle(ushort* pwTitleSize, const(wchar)* pwszTitle);
    HRESULT SetDescriptor(TOC_ENTRY_DESCRIPTOR* pDescriptor);
    HRESULT GetDescriptor(TOC_ENTRY_DESCRIPTOR* pDescriptor);
    HRESULT SetSubEntries(uint dwNumSubEntries, ushort* pwSubEntryIndices);
    HRESULT GetSubEntries(uint* pdwNumSubEntries, ushort* pwSubEntryIndices);
    HRESULT SetDescriptionData(uint dwDescriptionDataSize, ubyte* pbtDescriptionData, Guid* pguidType);
    HRESULT GetDescriptionData(uint* pdwDescriptionDataSize, ubyte* pbtDescriptionData, Guid* pGuidType);
}

const GUID IID_ITocEntryList = {0x3A8CCCBD, 0x0EFD, 0x43A3, [0xB8, 0x38, 0xF3, 0x8A, 0x55, 0x2B, 0xA2, 0x37]};
@GUID(0x3A8CCCBD, 0x0EFD, 0x43A3, [0xB8, 0x38, 0xF3, 0x8A, 0x55, 0x2B, 0xA2, 0x37]);
interface ITocEntryList : IUnknown
{
    HRESULT GetEntryCount(uint* pdwEntryCount);
    HRESULT GetEntryByIndex(uint dwEntryIndex, ITocEntry* ppEntry);
    HRESULT AddEntry(ITocEntry pEntry, uint* pdwEntryIndex);
    HRESULT AddEntryByIndex(uint dwEntryIndex, ITocEntry pEntry);
    HRESULT RemoveEntryByIndex(uint dwEntryIndex);
}

const GUID IID_IToc = {0xD6F05441, 0xA919, 0x423B, [0x91, 0xA0, 0x89, 0xD5, 0xB4, 0xA8, 0xAB, 0x77]};
@GUID(0xD6F05441, 0xA919, 0x423B, [0x91, 0xA0, 0x89, 0xD5, 0xB4, 0xA8, 0xAB, 0x77]);
interface IToc : IUnknown
{
    HRESULT SetDescriptor(TOC_DESCRIPTOR* pDescriptor);
    HRESULT GetDescriptor(TOC_DESCRIPTOR* pDescriptor);
    HRESULT SetDescription(const(wchar)* pwszDescription);
    HRESULT GetDescription(ushort* pwDescriptionSize, const(wchar)* pwszDescription);
    HRESULT SetContext(uint dwContextSize, ubyte* pbtContext);
    HRESULT GetContext(uint* pdwContextSize, ubyte* pbtContext);
    HRESULT GetEntryListCount(ushort* pwCount);
    HRESULT GetEntryListByIndex(ushort wEntryListIndex, ITocEntryList* ppEntryList);
    HRESULT AddEntryList(ITocEntryList pEntryList, ushort* pwEntryListIndex);
    HRESULT AddEntryListByIndex(ushort wEntryListIndex, ITocEntryList pEntryList);
    HRESULT RemoveEntryListByIndex(ushort wEntryListIndex);
}

const GUID IID_ITocCollection = {0x23FEE831, 0xAE96, 0x42DF, [0xB1, 0x70, 0x25, 0xA0, 0x48, 0x47, 0xA3, 0xCA]};
@GUID(0x23FEE831, 0xAE96, 0x42DF, [0xB1, 0x70, 0x25, 0xA0, 0x48, 0x47, 0xA3, 0xCA]);
interface ITocCollection : IUnknown
{
    HRESULT GetEntryCount(uint* pdwEntryCount);
    HRESULT GetEntryByIndex(uint dwEntryIndex, IToc* ppToc);
    HRESULT AddEntry(IToc pToc, uint* pdwEntryIndex);
    HRESULT AddEntryByIndex(uint dwEntryIndex, IToc pToc);
    HRESULT RemoveEntryByIndex(uint dwEntryIndex);
}

const GUID IID_ITocParser = {0xECFB9A55, 0x9298, 0x4F49, [0x88, 0x7F, 0x0B, 0x36, 0x20, 0x65, 0x99, 0xD2]};
@GUID(0xECFB9A55, 0x9298, 0x4F49, [0x88, 0x7F, 0x0B, 0x36, 0x20, 0x65, 0x99, 0xD2]);
interface ITocParser : IUnknown
{
    HRESULT Init(const(wchar)* pwszFileName);
    HRESULT GetTocCount(TOC_POS_TYPE enumTocPosType, uint* pdwTocCount);
    HRESULT GetTocByIndex(TOC_POS_TYPE enumTocPosType, uint dwTocIndex, IToc* ppToc);
    HRESULT GetTocByType(TOC_POS_TYPE enumTocPosType, Guid guidTocType, ITocCollection* ppTocs);
    HRESULT AddToc(TOC_POS_TYPE enumTocPosType, IToc pToc, uint* pdwTocIndex);
    HRESULT RemoveTocByIndex(TOC_POS_TYPE enumTocPosType, uint dwTocIndex);
    HRESULT RemoveTocByType(TOC_POS_TYPE enumTocPosType, Guid guidTocType);
    HRESULT Commit();
}

enum FILE_OPENMODE
{
    OPENMODE_FAIL_IF_NOT_EXIST = 0,
    OPENMODE_FAIL_IF_EXIST = 1,
    OPENMODE_RESET_IF_EXIST = 2,
    OPENMODE_APPEND_IF_EXIST = 3,
    OPENMODE_DELETE_IF_EXIST = 4,
}

enum SEEK_ORIGIN
{
    _msoBegin = 0,
    _msoCurrent = 1,
}

enum FILE_ACCESSMODE
{
    ACCESSMODE_READ = 1,
    ACCESSMODE_WRITE = 2,
    ACCESSMODE_READWRITE = 3,
    ACCESSMODE_WRITE_EXCLUSIVE = 4,
}

const GUID IID_IFileIo = {0x11993196, 0x1244, 0x4840, [0xAB, 0x44, 0x48, 0x09, 0x75, 0xC4, 0xFF, 0xE4]};
@GUID(0x11993196, 0x1244, 0x4840, [0xAB, 0x44, 0x48, 0x09, 0x75, 0xC4, 0xFF, 0xE4]);
interface IFileIo : IUnknown
{
    HRESULT Initialize(FILE_ACCESSMODE eAccessMode, FILE_OPENMODE eOpenMode, const(wchar)* pwszFileName);
    HRESULT GetLength(ulong* pqwLength);
    HRESULT SetLength(ulong qwLength);
    HRESULT GetCurrentPosition(ulong* pqwPosition);
    HRESULT SetCurrentPosition(ulong qwPosition);
    HRESULT IsEndOfStream(int* pbEndOfStream);
    HRESULT Read(ubyte* pbt, uint ul, uint* pulRead);
    HRESULT Write(ubyte* pbt, uint ul, uint* pulWritten);
    HRESULT Seek(SEEK_ORIGIN eSeekOrigin, ulong qwSeekOffset, uint dwSeekFlags, ulong* pqwCurrentPosition);
    HRESULT Close();
}

const GUID IID_IFileClient = {0xBFCCD196, 0x1244, 0x4840, [0xAB, 0x44, 0x48, 0x09, 0x75, 0xC4, 0xFF, 0xE4]};
@GUID(0xBFCCD196, 0x1244, 0x4840, [0xAB, 0x44, 0x48, 0x09, 0x75, 0xC4, 0xFF, 0xE4]);
interface IFileClient : IUnknown
{
    HRESULT GetObjectDiskSize(ulong* pqwSize);
    HRESULT Write(IFileIo pFio);
    HRESULT Read(IFileIo pFio);
}

const GUID IID_IClusterDetector = {0x3F07F7B7, 0xC680, 0x41D9, [0x94, 0x23, 0x91, 0x51, 0x07, 0xEC, 0x9F, 0xF9]};
@GUID(0x3F07F7B7, 0xC680, 0x41D9, [0x94, 0x23, 0x91, 0x51, 0x07, 0xEC, 0x9F, 0xF9]);
interface IClusterDetector : IUnknown
{
    HRESULT Initialize(ushort wBaseEntryLevel, ushort wClusterEntryLevel);
    HRESULT Detect(uint dwMaxNumClusters, float fMinClusterDuration, float fMaxClusterDuration, IToc pSrcToc, IToc* ppDstToc);
}

struct DXVA_AYUVsample2
{
    ubyte bCrValue;
    ubyte bCbValue;
    ubyte bY_Value;
    ubyte bSampleAlpha8;
}

struct DXVA_BufferDescription
{
    uint dwTypeIndex;
    uint dwBufferIndex;
    uint dwDataOffset;
    uint dwDataSize;
    uint dwFirstMBaddress;
    uint dwNumMBsInBuffer;
    uint dwWidth;
    uint dwHeight;
    uint dwStride;
    uint dwReservedBits;
}

struct DXVA_ConfigPictureDecode
{
    uint dwFunction;
    uint dwReservedBits;
    Guid guidConfigBitstreamEncryption;
    Guid guidConfigMBcontrolEncryption;
    Guid guidConfigResidDiffEncryption;
    ubyte bConfigBitstreamRaw;
    ubyte bConfigMBcontrolRasterOrder;
    ubyte bConfigResidDiffHost;
    ubyte bConfigSpatialResid8;
    ubyte bConfigResid8Subtraction;
    ubyte bConfigSpatialHost8or9Clipping;
    ubyte bConfigSpatialResidInterleaved;
    ubyte bConfigIntraResidUnsigned;
    ubyte bConfigResidDiffAccelerator;
    ubyte bConfigHostInverseScan;
    ubyte bConfigSpecificIDCT;
    ubyte bConfig4GroupedCoefs;
}

struct DXVA_PictureParameters
{
    ushort wDecodedPictureIndex;
    ushort wDeblockedPictureIndex;
    ushort wForwardRefPictureIndex;
    ushort wBackwardRefPictureIndex;
    ushort wPicWidthInMBminus1;
    ushort wPicHeightInMBminus1;
    ubyte bMacroblockWidthMinus1;
    ubyte bMacroblockHeightMinus1;
    ubyte bBlockWidthMinus1;
    ubyte bBlockHeightMinus1;
    ubyte bBPPminus1;
    ubyte bPicStructure;
    ubyte bSecondField;
    ubyte bPicIntra;
    ubyte bPicBackwardPrediction;
    ubyte bBidirectionalAveragingMode;
    ubyte bMVprecisionAndChromaRelation;
    ubyte bChromaFormat;
    ubyte bPicScanFixed;
    ubyte bPicScanMethod;
    ubyte bPicReadbackRequests;
    ubyte bRcontrol;
    ubyte bPicSpatialResid8;
    ubyte bPicOverflowBlocks;
    ubyte bPicExtrapolation;
    ubyte bPicDeblocked;
    ubyte bPicDeblockConfined;
    ubyte bPic4MVallowed;
    ubyte bPicOBMC;
    ubyte bPicBinPB;
    ubyte bMV_RPS;
    ubyte bReservedBits;
    ushort wBitstreamFcodes;
    ushort wBitstreamPCEelements;
    ubyte bBitstreamConcealmentNeed;
    ubyte bBitstreamConcealmentMethod;
}

struct DXVAUncompDataInfo
{
    uint UncompWidth;
    uint UncompHeight;
    D3DFORMAT UncompFormat;
}

struct DXVACompBufferInfo
{
    uint NumCompBuffers;
    uint WidthToCreate;
    uint HeightToCreate;
    uint BytesToAllocate;
    uint Usage;
    D3DPOOL Pool;
    D3DFORMAT Format;
}

struct DXVABufferInfo
{
    void* pCompSurface;
    uint DataOffset;
    uint DataSize;
}

enum DXVA_SampleFormat
{
    DXVA_SampleFormatMask = 255,
    DXVA_SampleUnknown = 0,
    DXVA_SamplePreviousFrame = 1,
    DXVA_SampleProgressiveFrame = 2,
    DXVA_SampleFieldInterleavedEvenFirst = 3,
    DXVA_SampleFieldInterleavedOddFirst = 4,
    DXVA_SampleFieldSingleEven = 5,
    DXVA_SampleFieldSingleOdd = 6,
    DXVA_SampleSubStream = 7,
}

enum DXVA_VideoTransferFunction
{
    DXVA_VideoTransFuncShift = 27,
    DXVA_VideoTransFuncMask = -134217728,
    DXVA_VideoTransFunc_Unknown = 0,
    DXVA_VideoTransFunc_10 = 1,
    DXVA_VideoTransFunc_18 = 2,
    DXVA_VideoTransFunc_20 = 3,
    DXVA_VideoTransFunc_22 = 4,
    DXVA_VideoTransFunc_22_709 = 5,
    DXVA_VideoTransFunc_22_240M = 6,
    DXVA_VideoTransFunc_22_8bit_sRGB = 7,
    DXVA_VideoTransFunc_28 = 8,
}

enum DXVA_VideoPrimaries
{
    DXVA_VideoPrimariesShift = 22,
    DXVA_VideoPrimariesMask = 130023424,
    DXVA_VideoPrimaries_Unknown = 0,
    DXVA_VideoPrimaries_reserved = 1,
    DXVA_VideoPrimaries_BT709 = 2,
    DXVA_VideoPrimaries_BT470_2_SysM = 3,
    DXVA_VideoPrimaries_BT470_2_SysBG = 4,
    DXVA_VideoPrimaries_SMPTE170M = 5,
    DXVA_VideoPrimaries_SMPTE240M = 6,
    DXVA_VideoPrimaries_EBU3213 = 7,
    DXVA_VideoPrimaries_SMPTE_C = 8,
}

enum DXVA_VideoLighting
{
    DXVA_VideoLightingShift = 18,
    DXVA_VideoLightingMask = 3932160,
    DXVA_VideoLighting_Unknown = 0,
    DXVA_VideoLighting_bright = 1,
    DXVA_VideoLighting_office = 2,
    DXVA_VideoLighting_dim = 3,
    DXVA_VideoLighting_dark = 4,
}

enum DXVA_VideoTransferMatrix
{
    DXVA_VideoTransferMatrixShift = 15,
    DXVA_VideoTransferMatrixMask = 229376,
    DXVA_VideoTransferMatrix_Unknown = 0,
    DXVA_VideoTransferMatrix_BT709 = 1,
    DXVA_VideoTransferMatrix_BT601 = 2,
    DXVA_VideoTransferMatrix_SMPTE240M = 3,
}

enum DXVA_NominalRange
{
    DXVA_NominalRangeShift = 12,
    DXVA_NominalRangeMask = 28672,
    DXVA_NominalRange_Unknown = 0,
    DXVA_NominalRange_Normal = 1,
    DXVA_NominalRange_Wide = 2,
    DXVA_NominalRange_0_255 = 1,
    DXVA_NominalRange_16_235 = 2,
    DXVA_NominalRange_48_208 = 3,
}

enum DXVA_VideoChromaSubsampling
{
    DXVA_VideoChromaSubsamplingShift = 8,
    DXVA_VideoChromaSubsamplingMask = 3840,
    DXVA_VideoChromaSubsampling_Unknown = 0,
    DXVA_VideoChromaSubsampling_ProgressiveChroma = 8,
    DXVA_VideoChromaSubsampling_Horizontally_Cosited = 4,
    DXVA_VideoChromaSubsampling_Vertically_Cosited = 2,
    DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes = 1,
    DXVA_VideoChromaSubsampling_MPEG2 = 5,
    DXVA_VideoChromaSubsampling_MPEG1 = 1,
    DXVA_VideoChromaSubsampling_DV_PAL = 6,
    DXVA_VideoChromaSubsampling_Cosited = 7,
}

struct DXVA_ExtendedFormat
{
    uint _bitfield;
}

struct DXVA_Frequency
{
    uint Numerator;
    uint Denominator;
}

struct DXVA_VideoDesc
{
    uint Size;
    uint SampleWidth;
    uint SampleHeight;
    uint SampleFormat;
    D3DFORMAT d3dFormat;
    DXVA_Frequency InputSampleFreq;
    DXVA_Frequency OutputFrameFreq;
}

enum DXVA_VideoProcessCaps
{
    DXVA_VideoProcess_None = 0,
    DXVA_VideoProcess_YUV2RGB = 1,
    DXVA_VideoProcess_StretchX = 2,
    DXVA_VideoProcess_StretchY = 4,
    DXVA_VideoProcess_AlphaBlend = 8,
    DXVA_VideoProcess_SubRects = 16,
    DXVA_VideoProcess_SubStreams = 32,
    DXVA_VideoProcess_SubStreamsExtended = 64,
    DXVA_VideoProcess_YUV2RGBExtended = 128,
    DXVA_VideoProcess_AlphaBlendExtended = 256,
}

enum DXVA_DeinterlaceTech
{
    DXVA_DeinterlaceTech_Unknown = 0,
    DXVA_DeinterlaceTech_BOBLineReplicate = 1,
    DXVA_DeinterlaceTech_BOBVerticalStretch = 2,
    DXVA_DeinterlaceTech_BOBVerticalStretch4Tap = 256,
    DXVA_DeinterlaceTech_MedianFiltering = 4,
    DXVA_DeinterlaceTech_EdgeFiltering = 16,
    DXVA_DeinterlaceTech_FieldAdaptive = 32,
    DXVA_DeinterlaceTech_PixelAdaptive = 64,
    DXVA_DeinterlaceTech_MotionVectorSteered = 128,
}

struct DXVA_VideoSample
{
    long rtStart;
    long rtEnd;
    DXVA_SampleFormat SampleFormat;
    void* lpDDSSrcSurface;
}

enum DXVA_SampleFlags
{
    DXVA_SampleFlagsMask = 15,
    DXVA_SampleFlag_Palette_Changed = 1,
    DXVA_SampleFlag_SrcRect_Changed = 2,
    DXVA_SampleFlag_DstRect_Changed = 4,
    DXVA_SampleFlag_ColorData_Changed = 8,
}

enum DXVA_DestinationFlags
{
    DXVA_DestinationFlagMask = 15,
    DXVA_DestinationFlag_Background_Changed = 1,
    DXVA_DestinationFlag_TargetRect_Changed = 2,
    DXVA_DestinationFlag_ColorData_Changed = 4,
    DXVA_DestinationFlag_Alpha_Changed = 8,
}

struct DXVA_VideoSample2
{
    long rtStart;
    long rtEnd;
    uint SampleFormat;
    uint SampleFlags;
    void* lpDDSSrcSurface;
    RECT rcSrc;
    RECT rcDst;
    DXVA_AYUVsample2 Palette;
}

struct DXVA_DeinterlaceCaps
{
    uint Size;
    uint NumPreviousOutputFrames;
    uint InputPool;
    uint NumForwardRefSamples;
    uint NumBackwardRefSamples;
    D3DFORMAT d3dOutputFormat;
    DXVA_VideoProcessCaps VideoProcessingCaps;
    DXVA_DeinterlaceTech DeinterlaceTechnology;
}

struct DXVA_DeinterlaceBlt
{
    uint Size;
    uint Reserved;
    long rtTarget;
    RECT DstRect;
    RECT SrcRect;
    uint NumSourceSurfaces;
    float Alpha;
    DXVA_VideoSample Source;
}

struct DXVA_DeinterlaceBltEx
{
    uint Size;
    DXVA_AYUVsample2 BackgroundColor;
    RECT rcTarget;
    long rtTarget;
    uint NumSourceSurfaces;
    float Alpha;
    DXVA_VideoSample2 Source;
    uint DestinationFormat;
    uint DestinationFlags;
}

struct DXVA_DeinterlaceQueryAvailableModes
{
    uint Size;
    uint NumGuids;
    Guid Guids;
}

struct DXVA_DeinterlaceQueryModeCaps
{
    uint Size;
    Guid Guid;
    DXVA_VideoDesc VideoDesc;
}

enum DXVA_ProcAmpControlProp
{
    DXVA_ProcAmp_None = 0,
    DXVA_ProcAmp_Brightness = 1,
    DXVA_ProcAmp_Contrast = 2,
    DXVA_ProcAmp_Hue = 4,
    DXVA_ProcAmp_Saturation = 8,
}

struct DXVA_ProcAmpControlCaps
{
    uint Size;
    uint InputPool;
    D3DFORMAT d3dOutputFormat;
    uint ProcAmpControlProps;
    uint VideoProcessingCaps;
}

struct DXVA_ProcAmpControlQueryRange
{
    uint Size;
    DXVA_ProcAmpControlProp ProcAmpControlProp;
    DXVA_VideoDesc VideoDesc;
}

struct DXVA_VideoPropertyRange
{
    float MinValue;
    float MaxValue;
    float DefaultValue;
    float StepSize;
}

struct DXVA_ProcAmpControlBlt
{
    uint Size;
    RECT DstRect;
    RECT SrcRect;
    float Alpha;
    float Brightness;
    float Contrast;
    float Hue;
    float Saturation;
}

struct DXVA_COPPSignature
{
    ubyte Signature;
}

struct DXVA_COPPCommand
{
    Guid macKDI;
    Guid guidCommandID;
    uint dwSequence;
    uint cbSizeData;
    ubyte CommandData;
}

struct DXVA_COPPStatusInput
{
    Guid rApp;
    Guid guidStatusRequestID;
    uint dwSequence;
    uint cbSizeData;
    ubyte StatusData;
}

struct DXVA_COPPStatusOutput
{
    Guid macKDI;
    uint cbSizeData;
    ubyte COPPStatus;
}

enum DXVAHD_FRAME_FORMAT
{
    DXVAHD_FRAME_FORMAT_PROGRESSIVE = 0,
    DXVAHD_FRAME_FORMAT_INTERLACED_TOP_FIELD_FIRST = 1,
    DXVAHD_FRAME_FORMAT_INTERLACED_BOTTOM_FIELD_FIRST = 2,
}

enum DXVAHD_DEVICE_USAGE
{
    DXVAHD_DEVICE_USAGE_PLAYBACK_NORMAL = 0,
    DXVAHD_DEVICE_USAGE_OPTIMAL_SPEED = 1,
    DXVAHD_DEVICE_USAGE_OPTIMAL_QUALITY = 2,
}

enum DXVAHD_SURFACE_TYPE
{
    DXVAHD_SURFACE_TYPE_VIDEO_INPUT = 0,
    DXVAHD_SURFACE_TYPE_VIDEO_INPUT_PRIVATE = 1,
    DXVAHD_SURFACE_TYPE_VIDEO_OUTPUT = 2,
}

enum DXVAHD_DEVICE_TYPE
{
    DXVAHD_DEVICE_TYPE_HARDWARE = 0,
    DXVAHD_DEVICE_TYPE_SOFTWARE = 1,
    DXVAHD_DEVICE_TYPE_REFERENCE = 2,
    DXVAHD_DEVICE_TYPE_OTHER = 3,
}

enum DXVAHD_DEVICE_CAPS
{
    DXVAHD_DEVICE_CAPS_LINEAR_SPACE = 1,
    DXVAHD_DEVICE_CAPS_xvYCC = 2,
    DXVAHD_DEVICE_CAPS_RGB_RANGE_CONVERSION = 4,
    DXVAHD_DEVICE_CAPS_YCbCr_MATRIX_CONVERSION = 8,
}

enum DXVAHD_FEATURE_CAPS
{
    DXVAHD_FEATURE_CAPS_ALPHA_FILL = 1,
    DXVAHD_FEATURE_CAPS_CONSTRICTION = 2,
    DXVAHD_FEATURE_CAPS_LUMA_KEY = 4,
    DXVAHD_FEATURE_CAPS_ALPHA_PALETTE = 8,
}

enum DXVAHD_FILTER_CAPS
{
    DXVAHD_FILTER_CAPS_BRIGHTNESS = 1,
    DXVAHD_FILTER_CAPS_CONTRAST = 2,
    DXVAHD_FILTER_CAPS_HUE = 4,
    DXVAHD_FILTER_CAPS_SATURATION = 8,
    DXVAHD_FILTER_CAPS_NOISE_REDUCTION = 16,
    DXVAHD_FILTER_CAPS_EDGE_ENHANCEMENT = 32,
    DXVAHD_FILTER_CAPS_ANAMORPHIC_SCALING = 64,
}

enum DXVAHD_INPUT_FORMAT_CAPS
{
    DXVAHD_INPUT_FORMAT_CAPS_RGB_INTERLACED = 1,
    DXVAHD_INPUT_FORMAT_CAPS_RGB_PROCAMP = 2,
    DXVAHD_INPUT_FORMAT_CAPS_RGB_LUMA_KEY = 4,
    DXVAHD_INPUT_FORMAT_CAPS_PALETTE_INTERLACED = 8,
}

enum DXVAHD_PROCESSOR_CAPS
{
    DXVAHD_PROCESSOR_CAPS_DEINTERLACE_BLEND = 1,
    DXVAHD_PROCESSOR_CAPS_DEINTERLACE_BOB = 2,
    DXVAHD_PROCESSOR_CAPS_DEINTERLACE_ADAPTIVE = 4,
    DXVAHD_PROCESSOR_CAPS_DEINTERLACE_MOTION_COMPENSATION = 8,
    DXVAHD_PROCESSOR_CAPS_INVERSE_TELECINE = 16,
    DXVAHD_PROCESSOR_CAPS_FRAME_RATE_CONVERSION = 32,
}

enum DXVAHD_ITELECINE_CAPS
{
    DXVAHD_ITELECINE_CAPS_32 = 1,
    DXVAHD_ITELECINE_CAPS_22 = 2,
    DXVAHD_ITELECINE_CAPS_2224 = 4,
    DXVAHD_ITELECINE_CAPS_2332 = 8,
    DXVAHD_ITELECINE_CAPS_32322 = 16,
    DXVAHD_ITELECINE_CAPS_55 = 32,
    DXVAHD_ITELECINE_CAPS_64 = 64,
    DXVAHD_ITELECINE_CAPS_87 = 128,
    DXVAHD_ITELECINE_CAPS_222222222223 = 256,
    DXVAHD_ITELECINE_CAPS_OTHER = -2147483648,
}

enum DXVAHD_FILTER
{
    DXVAHD_FILTER_BRIGHTNESS = 0,
    DXVAHD_FILTER_CONTRAST = 1,
    DXVAHD_FILTER_HUE = 2,
    DXVAHD_FILTER_SATURATION = 3,
    DXVAHD_FILTER_NOISE_REDUCTION = 4,
    DXVAHD_FILTER_EDGE_ENHANCEMENT = 5,
    DXVAHD_FILTER_ANAMORPHIC_SCALING = 6,
}

enum DXVAHD_BLT_STATE
{
    DXVAHD_BLT_STATE_TARGET_RECT = 0,
    DXVAHD_BLT_STATE_BACKGROUND_COLOR = 1,
    DXVAHD_BLT_STATE_OUTPUT_COLOR_SPACE = 2,
    DXVAHD_BLT_STATE_ALPHA_FILL = 3,
    DXVAHD_BLT_STATE_CONSTRICTION = 4,
    DXVAHD_BLT_STATE_PRIVATE = 1000,
}

enum DXVAHD_ALPHA_FILL_MODE
{
    DXVAHD_ALPHA_FILL_MODE_OPAQUE = 0,
    DXVAHD_ALPHA_FILL_MODE_BACKGROUND = 1,
    DXVAHD_ALPHA_FILL_MODE_DESTINATION = 2,
    DXVAHD_ALPHA_FILL_MODE_SOURCE_STREAM = 3,
}

enum DXVAHD_STREAM_STATE
{
    DXVAHD_STREAM_STATE_D3DFORMAT = 0,
    DXVAHD_STREAM_STATE_FRAME_FORMAT = 1,
    DXVAHD_STREAM_STATE_INPUT_COLOR_SPACE = 2,
    DXVAHD_STREAM_STATE_OUTPUT_RATE = 3,
    DXVAHD_STREAM_STATE_SOURCE_RECT = 4,
    DXVAHD_STREAM_STATE_DESTINATION_RECT = 5,
    DXVAHD_STREAM_STATE_ALPHA = 6,
    DXVAHD_STREAM_STATE_PALETTE = 7,
    DXVAHD_STREAM_STATE_LUMA_KEY = 8,
    DXVAHD_STREAM_STATE_ASPECT_RATIO = 9,
    DXVAHD_STREAM_STATE_FILTER_BRIGHTNESS = 100,
    DXVAHD_STREAM_STATE_FILTER_CONTRAST = 101,
    DXVAHD_STREAM_STATE_FILTER_HUE = 102,
    DXVAHD_STREAM_STATE_FILTER_SATURATION = 103,
    DXVAHD_STREAM_STATE_FILTER_NOISE_REDUCTION = 104,
    DXVAHD_STREAM_STATE_FILTER_EDGE_ENHANCEMENT = 105,
    DXVAHD_STREAM_STATE_FILTER_ANAMORPHIC_SCALING = 106,
    DXVAHD_STREAM_STATE_PRIVATE = 1000,
}

enum DXVAHD_OUTPUT_RATE
{
    DXVAHD_OUTPUT_RATE_NORMAL = 0,
    DXVAHD_OUTPUT_RATE_HALF = 1,
    DXVAHD_OUTPUT_RATE_CUSTOM = 2,
}

struct DXVAHD_RATIONAL
{
    uint Numerator;
    uint Denominator;
}

struct DXVAHD_COLOR_RGBA
{
    float R;
    float G;
    float B;
    float A;
}

struct DXVAHD_COLOR_YCbCrA
{
    float Y;
    float Cb;
    float Cr;
    float A;
}

struct DXVAHD_COLOR
{
    DXVAHD_COLOR_RGBA RGB;
    DXVAHD_COLOR_YCbCrA YCbCr;
}

struct DXVAHD_CONTENT_DESC
{
    DXVAHD_FRAME_FORMAT InputFrameFormat;
    DXVAHD_RATIONAL InputFrameRate;
    uint InputWidth;
    uint InputHeight;
    DXVAHD_RATIONAL OutputFrameRate;
    uint OutputWidth;
    uint OutputHeight;
}

struct DXVAHD_VPDEVCAPS
{
    DXVAHD_DEVICE_TYPE DeviceType;
    uint DeviceCaps;
    uint FeatureCaps;
    uint FilterCaps;
    uint InputFormatCaps;
    D3DPOOL InputPool;
    uint OutputFormatCount;
    uint InputFormatCount;
    uint VideoProcessorCount;
    uint MaxInputStreams;
    uint MaxStreamStates;
}

struct DXVAHD_VPCAPS
{
    Guid VPGuid;
    uint PastFrames;
    uint FutureFrames;
    uint ProcessorCaps;
    uint ITelecineCaps;
    uint CustomRateCount;
}

struct DXVAHD_CUSTOM_RATE_DATA
{
    DXVAHD_RATIONAL CustomRate;
    uint OutputFrames;
    BOOL InputInterlaced;
    uint InputFramesOrFields;
}

struct DXVAHD_FILTER_RANGE_DATA
{
    int Minimum;
    int Maximum;
    int Default;
    float Multiplier;
}

struct DXVAHD_BLT_STATE_TARGET_RECT_DATA
{
    BOOL Enable;
    RECT TargetRect;
}

struct DXVAHD_BLT_STATE_BACKGROUND_COLOR_DATA
{
    BOOL YCbCr;
    DXVAHD_COLOR BackgroundColor;
}

struct DXVAHD_BLT_STATE_OUTPUT_COLOR_SPACE_DATA
{
    _Anonymous_e__Union Anonymous;
}

struct DXVAHD_BLT_STATE_ALPHA_FILL_DATA
{
    DXVAHD_ALPHA_FILL_MODE Mode;
    uint StreamNumber;
}

struct DXVAHD_BLT_STATE_CONSTRICTION_DATA
{
    BOOL Enable;
    SIZE Size;
}

struct DXVAHD_BLT_STATE_PRIVATE_DATA
{
    Guid Guid;
    uint DataSize;
    void* pData;
}

struct DXVAHD_STREAM_STATE_D3DFORMAT_DATA
{
    D3DFORMAT Format;
}

struct DXVAHD_STREAM_STATE_FRAME_FORMAT_DATA
{
    DXVAHD_FRAME_FORMAT FrameFormat;
}

struct DXVAHD_STREAM_STATE_INPUT_COLOR_SPACE_DATA
{
    _Anonymous_e__Union Anonymous;
}

struct DXVAHD_STREAM_STATE_OUTPUT_RATE_DATA
{
    BOOL RepeatFrame;
    DXVAHD_OUTPUT_RATE OutputRate;
    DXVAHD_RATIONAL CustomRate;
}

struct DXVAHD_STREAM_STATE_SOURCE_RECT_DATA
{
    BOOL Enable;
    RECT SourceRect;
}

struct DXVAHD_STREAM_STATE_DESTINATION_RECT_DATA
{
    BOOL Enable;
    RECT DestinationRect;
}

struct DXVAHD_STREAM_STATE_ALPHA_DATA
{
    BOOL Enable;
    float Alpha;
}

struct DXVAHD_STREAM_STATE_PALETTE_DATA
{
    uint Count;
    uint* pEntries;
}

struct DXVAHD_STREAM_STATE_LUMA_KEY_DATA
{
    BOOL Enable;
    float Lower;
    float Upper;
}

struct DXVAHD_STREAM_STATE_ASPECT_RATIO_DATA
{
    BOOL Enable;
    DXVAHD_RATIONAL SourceAspectRatio;
    DXVAHD_RATIONAL DestinationAspectRatio;
}

struct DXVAHD_STREAM_STATE_FILTER_DATA
{
    BOOL Enable;
    int Level;
}

struct DXVAHD_STREAM_STATE_PRIVATE_DATA
{
    Guid Guid;
    uint DataSize;
    void* pData;
}

struct DXVAHD_STREAM_DATA
{
    BOOL Enable;
    uint OutputIndex;
    uint InputFrameOrField;
    uint PastFrames;
    uint FutureFrames;
    IDirect3DSurface9* ppPastSurfaces;
    IDirect3DSurface9 pInputSurface;
    IDirect3DSurface9* ppFutureSurfaces;
}

struct DXVAHD_STREAM_STATE_PRIVATE_IVTC_DATA
{
    BOOL Enable;
    uint ITelecineFlags;
    uint Frames;
    uint InputField;
}

const GUID IID_IDXVAHD_Device = {0x95F12DFD, 0xD77E, 0x49BE, [0x81, 0x5F, 0x57, 0xD5, 0x79, 0x63, 0x4D, 0x6D]};
@GUID(0x95F12DFD, 0xD77E, 0x49BE, [0x81, 0x5F, 0x57, 0xD5, 0x79, 0x63, 0x4D, 0x6D]);
interface IDXVAHD_Device : IUnknown
{
    HRESULT CreateVideoSurface(uint Width, uint Height, D3DFORMAT Format, D3DPOOL Pool, uint Usage, DXVAHD_SURFACE_TYPE Type, uint NumSurfaces, char* ppSurfaces, HANDLE* pSharedHandle);
    HRESULT GetVideoProcessorDeviceCaps(DXVAHD_VPDEVCAPS* pCaps);
    HRESULT GetVideoProcessorOutputFormats(uint Count, char* pFormats);
    HRESULT GetVideoProcessorInputFormats(uint Count, char* pFormats);
    HRESULT GetVideoProcessorCaps(uint Count, char* pCaps);
    HRESULT GetVideoProcessorCustomRates(const(Guid)* pVPGuid, uint Count, char* pRates);
    HRESULT GetVideoProcessorFilterRange(DXVAHD_FILTER Filter, DXVAHD_FILTER_RANGE_DATA* pRange);
    HRESULT CreateVideoProcessor(const(Guid)* pVPGuid, IDXVAHD_VideoProcessor* ppVideoProcessor);
}

const GUID IID_IDXVAHD_VideoProcessor = {0x95F4EDF4, 0x6E03, 0x4CD7, [0xBE, 0x1B, 0x30, 0x75, 0xD6, 0x65, 0xAA, 0x52]};
@GUID(0x95F4EDF4, 0x6E03, 0x4CD7, [0xBE, 0x1B, 0x30, 0x75, 0xD6, 0x65, 0xAA, 0x52]);
interface IDXVAHD_VideoProcessor : IUnknown
{
    HRESULT SetVideoProcessBltState(DXVAHD_BLT_STATE State, uint DataSize, char* pData);
    HRESULT GetVideoProcessBltState(DXVAHD_BLT_STATE State, uint DataSize, char* pData);
    HRESULT SetVideoProcessStreamState(uint StreamNumber, DXVAHD_STREAM_STATE State, uint DataSize, char* pData);
    HRESULT GetVideoProcessStreamState(uint StreamNumber, DXVAHD_STREAM_STATE State, uint DataSize, char* pData);
    HRESULT VideoProcessBltHD(IDirect3DSurface9 pOutputSurface, uint OutputFrame, uint StreamCount, char* pStreams);
}

alias PDXVAHDSW_CreateDevice = extern(Windows) HRESULT function(IDirect3DDevice9Ex pD3DDevice, HANDLE* phDevice);
alias PDXVAHDSW_ProposeVideoPrivateFormat = extern(Windows) HRESULT function(HANDLE hDevice, D3DFORMAT* pFormat);
alias PDXVAHDSW_GetVideoProcessorDeviceCaps = extern(Windows) HRESULT function(HANDLE hDevice, const(DXVAHD_CONTENT_DESC)* pContentDesc, DXVAHD_DEVICE_USAGE Usage, DXVAHD_VPDEVCAPS* pCaps);
alias PDXVAHDSW_GetVideoProcessorOutputFormats = extern(Windows) HRESULT function(HANDLE hDevice, const(DXVAHD_CONTENT_DESC)* pContentDesc, DXVAHD_DEVICE_USAGE Usage, uint Count, char* pFormats);
alias PDXVAHDSW_GetVideoProcessorInputFormats = extern(Windows) HRESULT function(HANDLE hDevice, const(DXVAHD_CONTENT_DESC)* pContentDesc, DXVAHD_DEVICE_USAGE Usage, uint Count, char* pFormats);
alias PDXVAHDSW_GetVideoProcessorCaps = extern(Windows) HRESULT function(HANDLE hDevice, const(DXVAHD_CONTENT_DESC)* pContentDesc, DXVAHD_DEVICE_USAGE Usage, uint Count, char* pCaps);
alias PDXVAHDSW_GetVideoProcessorCustomRates = extern(Windows) HRESULT function(HANDLE hDevice, const(Guid)* pVPGuid, uint Count, char* pRates);
alias PDXVAHDSW_GetVideoProcessorFilterRange = extern(Windows) HRESULT function(HANDLE hDevice, DXVAHD_FILTER Filter, DXVAHD_FILTER_RANGE_DATA* pRange);
alias PDXVAHDSW_DestroyDevice = extern(Windows) HRESULT function(HANDLE hDevice);
alias PDXVAHDSW_CreateVideoProcessor = extern(Windows) HRESULT function(HANDLE hDevice, const(Guid)* pVPGuid, HANDLE* phVideoProcessor);
alias PDXVAHDSW_SetVideoProcessBltState = extern(Windows) HRESULT function(HANDLE hVideoProcessor, DXVAHD_BLT_STATE State, uint DataSize, char* pData);
alias PDXVAHDSW_GetVideoProcessBltStatePrivate = extern(Windows) HRESULT function(HANDLE hVideoProcessor, DXVAHD_BLT_STATE_PRIVATE_DATA* pData);
alias PDXVAHDSW_SetVideoProcessStreamState = extern(Windows) HRESULT function(HANDLE hVideoProcessor, uint StreamNumber, DXVAHD_STREAM_STATE State, uint DataSize, char* pData);
alias PDXVAHDSW_GetVideoProcessStreamStatePrivate = extern(Windows) HRESULT function(HANDLE hVideoProcessor, uint StreamNumber, DXVAHD_STREAM_STATE_PRIVATE_DATA* pData);
alias PDXVAHDSW_VideoProcessBltHD = extern(Windows) HRESULT function(HANDLE hVideoProcessor, IDirect3DSurface9 pOutputSurface, uint OutputFrame, uint StreamCount, char* pStreams);
alias PDXVAHDSW_DestroyVideoProcessor = extern(Windows) HRESULT function(HANDLE hVideoProcessor);
struct DXVAHDSW_CALLBACKS
{
    PDXVAHDSW_CreateDevice CreateDevice;
    PDXVAHDSW_ProposeVideoPrivateFormat ProposeVideoPrivateFormat;
    PDXVAHDSW_GetVideoProcessorDeviceCaps GetVideoProcessorDeviceCaps;
    PDXVAHDSW_GetVideoProcessorOutputFormats GetVideoProcessorOutputFormats;
    PDXVAHDSW_GetVideoProcessorInputFormats GetVideoProcessorInputFormats;
    PDXVAHDSW_GetVideoProcessorCaps GetVideoProcessorCaps;
    PDXVAHDSW_GetVideoProcessorCustomRates GetVideoProcessorCustomRates;
    PDXVAHDSW_GetVideoProcessorFilterRange GetVideoProcessorFilterRange;
    PDXVAHDSW_DestroyDevice DestroyDevice;
    PDXVAHDSW_CreateVideoProcessor CreateVideoProcessor;
    PDXVAHDSW_SetVideoProcessBltState SetVideoProcessBltState;
    PDXVAHDSW_GetVideoProcessBltStatePrivate GetVideoProcessBltStatePrivate;
    PDXVAHDSW_SetVideoProcessStreamState SetVideoProcessStreamState;
    PDXVAHDSW_GetVideoProcessStreamStatePrivate GetVideoProcessStreamStatePrivate;
    PDXVAHDSW_VideoProcessBltHD VideoProcessBltHD;
    PDXVAHDSW_DestroyVideoProcessor DestroyVideoProcessor;
}

alias PDXVAHDSW_Plugin = extern(Windows) HRESULT function(uint Size, char* pCallbacks);
struct DXVAHDETW_CREATEVIDEOPROCESSOR
{
    ulong pObject;
    ulong pD3D9Ex;
    Guid VPGuid;
}

struct DXVAHDETW_VIDEOPROCESSBLTSTATE
{
    ulong pObject;
    DXVAHD_BLT_STATE State;
    uint DataSize;
    BOOL SetState;
}

struct DXVAHDETW_VIDEOPROCESSSTREAMSTATE
{
    ulong pObject;
    uint StreamNumber;
    DXVAHD_STREAM_STATE State;
    uint DataSize;
    BOOL SetState;
}

struct DXVAHDETW_VIDEOPROCESSBLTHD
{
    ulong pObject;
    ulong pOutputSurface;
    RECT TargetRect;
    D3DFORMAT OutputFormat;
    uint ColorSpace;
    uint OutputFrame;
    uint StreamCount;
    BOOL Enter;
}

struct DXVAHDETW_VIDEOPROCESSBLTHD_STREAM
{
    ulong pObject;
    ulong pInputSurface;
    RECT SourceRect;
    RECT DestinationRect;
    D3DFORMAT InputFormat;
    DXVAHD_FRAME_FORMAT FrameFormat;
    uint ColorSpace;
    uint StreamNumber;
    uint OutputIndex;
    uint InputFrameOrField;
    uint PastFrames;
    uint FutureFrames;
}

struct DXVAHDETW_DESTROYVIDEOPROCESSOR
{
    ulong pObject;
}

alias PDXVAHD_CreateDevice = extern(Windows) HRESULT function(IDirect3DDevice9Ex pD3DDevice, const(DXVAHD_CONTENT_DESC)* pContentDesc, DXVAHD_DEVICE_USAGE Usage, PDXVAHDSW_Plugin pPlugin, IDXVAHD_Device* ppDevice);
struct DXVA2_ExtendedFormat
{
    _Anonymous_e__Union Anonymous;
}

enum DXVA2_SampleFormat
{
    DXVA2_SampleFormatMask = 255,
    DXVA2_SampleUnknown = 0,
    DXVA2_SampleProgressiveFrame = 2,
    DXVA2_SampleFieldInterleavedEvenFirst = 3,
    DXVA2_SampleFieldInterleavedOddFirst = 4,
    DXVA2_SampleFieldSingleEven = 5,
    DXVA2_SampleFieldSingleOdd = 6,
    DXVA2_SampleSubStream = 7,
}

enum DXVA2_VideoChromaSubSampling
{
    DXVA2_VideoChromaSubsamplingMask = 15,
    DXVA2_VideoChromaSubsampling_Unknown = 0,
    DXVA2_VideoChromaSubsampling_ProgressiveChroma = 8,
    DXVA2_VideoChromaSubsampling_Horizontally_Cosited = 4,
    DXVA2_VideoChromaSubsampling_Vertically_Cosited = 2,
    DXVA2_VideoChromaSubsampling_Vertically_AlignedChromaPlanes = 1,
    DXVA2_VideoChromaSubsampling_MPEG2 = 5,
    DXVA2_VideoChromaSubsampling_MPEG1 = 1,
    DXVA2_VideoChromaSubsampling_DV_PAL = 6,
    DXVA2_VideoChromaSubsampling_Cosited = 7,
}

enum DXVA2_NominalRange
{
    DXVA2_NominalRangeMask = 7,
    DXVA2_NominalRange_Unknown = 0,
    DXVA2_NominalRange_Normal = 1,
    DXVA2_NominalRange_Wide = 2,
    DXVA2_NominalRange_0_255 = 1,
    DXVA2_NominalRange_16_235 = 2,
    DXVA2_NominalRange_48_208 = 3,
}

enum DXVA2_VideoTransferMatrix
{
    DXVA2_VideoTransferMatrixMask = 7,
    DXVA2_VideoTransferMatrix_Unknown = 0,
    DXVA2_VideoTransferMatrix_BT709 = 1,
    DXVA2_VideoTransferMatrix_BT601 = 2,
    DXVA2_VideoTransferMatrix_SMPTE240M = 3,
}

enum DXVA2_VideoLighting
{
    DXVA2_VideoLightingMask = 15,
    DXVA2_VideoLighting_Unknown = 0,
    DXVA2_VideoLighting_bright = 1,
    DXVA2_VideoLighting_office = 2,
    DXVA2_VideoLighting_dim = 3,
    DXVA2_VideoLighting_dark = 4,
}

enum DXVA2_VideoPrimaries
{
    DXVA2_VideoPrimariesMask = 31,
    DXVA2_VideoPrimaries_Unknown = 0,
    DXVA2_VideoPrimaries_reserved = 1,
    DXVA2_VideoPrimaries_BT709 = 2,
    DXVA2_VideoPrimaries_BT470_2_SysM = 3,
    DXVA2_VideoPrimaries_BT470_2_SysBG = 4,
    DXVA2_VideoPrimaries_SMPTE170M = 5,
    DXVA2_VideoPrimaries_SMPTE240M = 6,
    DXVA2_VideoPrimaries_EBU3213 = 7,
    DXVA2_VideoPrimaries_SMPTE_C = 8,
}

enum DXVA2_VideoTransferFunction
{
    DXVA2_VideoTransFuncMask = 31,
    DXVA2_VideoTransFunc_Unknown = 0,
    DXVA2_VideoTransFunc_10 = 1,
    DXVA2_VideoTransFunc_18 = 2,
    DXVA2_VideoTransFunc_20 = 3,
    DXVA2_VideoTransFunc_22 = 4,
    DXVA2_VideoTransFunc_709 = 5,
    DXVA2_VideoTransFunc_240M = 6,
    DXVA2_VideoTransFunc_sRGB = 7,
    DXVA2_VideoTransFunc_28 = 8,
}

struct DXVA2_Frequency
{
    uint Numerator;
    uint Denominator;
}

struct DXVA2_VideoDesc
{
    uint SampleWidth;
    uint SampleHeight;
    DXVA2_ExtendedFormat SampleFormat;
    D3DFORMAT Format;
    DXVA2_Frequency InputSampleFreq;
    DXVA2_Frequency OutputFrameFreq;
    uint UABProtectionLevel;
    uint Reserved;
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0003
{
    DXVA2_DeinterlaceTech_Unknown = 0,
    DXVA2_DeinterlaceTech_BOBLineReplicate = 1,
    DXVA2_DeinterlaceTech_BOBVerticalStretch = 2,
    DXVA2_DeinterlaceTech_BOBVerticalStretch4Tap = 4,
    DXVA2_DeinterlaceTech_MedianFiltering = 8,
    DXVA2_DeinterlaceTech_EdgeFiltering = 16,
    DXVA2_DeinterlaceTech_FieldAdaptive = 32,
    DXVA2_DeinterlaceTech_PixelAdaptive = 64,
    DXVA2_DeinterlaceTech_MotionVectorSteered = 128,
    DXVA2_DeinterlaceTech_InverseTelecine = 256,
    DXVA2_DeinterlaceTech_Mask = 511,
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0004
{
    DXVA2_NoiseFilterLumaLevel = 1,
    DXVA2_NoiseFilterLumaThreshold = 2,
    DXVA2_NoiseFilterLumaRadius = 3,
    DXVA2_NoiseFilterChromaLevel = 4,
    DXVA2_NoiseFilterChromaThreshold = 5,
    DXVA2_NoiseFilterChromaRadius = 6,
    DXVA2_DetailFilterLumaLevel = 7,
    DXVA2_DetailFilterLumaThreshold = 8,
    DXVA2_DetailFilterLumaRadius = 9,
    DXVA2_DetailFilterChromaLevel = 10,
    DXVA2_DetailFilterChromaThreshold = 11,
    DXVA2_DetailFilterChromaRadius = 12,
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0005
{
    DXVA2_NoiseFilterTech_Unsupported = 0,
    DXVA2_NoiseFilterTech_Unknown = 1,
    DXVA2_NoiseFilterTech_Median = 2,
    DXVA2_NoiseFilterTech_Temporal = 4,
    DXVA2_NoiseFilterTech_BlockNoise = 8,
    DXVA2_NoiseFilterTech_MosquitoNoise = 16,
    DXVA2_NoiseFilterTech_Mask = 31,
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0006
{
    DXVA2_DetailFilterTech_Unsupported = 0,
    DXVA2_DetailFilterTech_Unknown = 1,
    DXVA2_DetailFilterTech_Edge = 2,
    DXVA2_DetailFilterTech_Sharpening = 4,
    DXVA2_DetailFilterTech_Mask = 7,
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0007
{
    DXVA2_ProcAmp_None = 0,
    DXVA2_ProcAmp_Brightness = 1,
    DXVA2_ProcAmp_Contrast = 2,
    DXVA2_ProcAmp_Hue = 4,
    DXVA2_ProcAmp_Saturation = 8,
    DXVA2_ProcAmp_Mask = 15,
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0008
{
    DXVA2_VideoProcess_None = 0,
    DXVA2_VideoProcess_YUV2RGB = 1,
    DXVA2_VideoProcess_StretchX = 2,
    DXVA2_VideoProcess_StretchY = 4,
    DXVA2_VideoProcess_AlphaBlend = 8,
    DXVA2_VideoProcess_SubRects = 16,
    DXVA2_VideoProcess_SubStreams = 32,
    DXVA2_VideoProcess_SubStreamsExtended = 64,
    DXVA2_VideoProcess_YUV2RGBExtended = 128,
    DXVA2_VideoProcess_AlphaBlendExtended = 256,
    DXVA2_VideoProcess_Constriction = 512,
    DXVA2_VideoProcess_NoiseFilter = 1024,
    DXVA2_VideoProcess_DetailFilter = 2048,
    DXVA2_VideoProcess_PlanarAlpha = 4096,
    DXVA2_VideoProcess_LinearScaling = 8192,
    DXVA2_VideoProcess_GammaCompensated = 16384,
    DXVA2_VideoProcess_MaintainsOriginalFieldData = 32768,
    DXVA2_VideoProcess_Mask = 65535,
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0009
{
    DXVA2_VPDev_HardwareDevice = 1,
    DXVA2_VPDev_EmulatedDXVA1 = 2,
    DXVA2_VPDev_SoftwareDevice = 4,
    DXVA2_VPDev_Mask = 7,
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0010
{
    DXVA2_SampleData_RFF = 1,
    DXVA2_SampleData_TFF = 2,
    DXVA2_SampleData_RFF_TFF_Present = 4,
    DXVA2_SampleData_Mask = 65535,
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0011
{
    DXVA2_DestData_RFF = 1,
    DXVA2_DestData_TFF = 2,
    DXVA2_DestData_RFF_TFF_Present = 4,
    DXVA2_DestData_Mask = 65535,
}

struct DXVA2_VideoProcessorCaps
{
    uint DeviceCaps;
    D3DPOOL InputPool;
    uint NumForwardRefSamples;
    uint NumBackwardRefSamples;
    uint Reserved;
    uint DeinterlaceTechnology;
    uint ProcAmpControlCaps;
    uint VideoProcessorOperations;
    uint NoiseFilterTechnology;
    uint DetailFilterTechnology;
}

struct DXVA2_Fixed32
{
    _Anonymous_e__Union Anonymous;
}

struct DXVA2_AYUVSample8
{
    ubyte Cr;
    ubyte Cb;
    ubyte Y;
    ubyte Alpha;
}

struct DXVA2_AYUVSample16
{
    ushort Cr;
    ushort Cb;
    ushort Y;
    ushort Alpha;
}

struct DXVA2_VideoSample
{
    long Start;
    long End;
    DXVA2_ExtendedFormat SampleFormat;
    IDirect3DSurface9 SrcSurface;
    RECT SrcRect;
    RECT DstRect;
    DXVA2_AYUVSample8 Pal;
    DXVA2_Fixed32 PlanarAlpha;
    uint SampleData;
}

struct DXVA2_ValueRange
{
    DXVA2_Fixed32 MinValue;
    DXVA2_Fixed32 MaxValue;
    DXVA2_Fixed32 DefaultValue;
    DXVA2_Fixed32 StepSize;
}

struct DXVA2_ProcAmpValues
{
    DXVA2_Fixed32 Brightness;
    DXVA2_Fixed32 Contrast;
    DXVA2_Fixed32 Hue;
    DXVA2_Fixed32 Saturation;
}

struct DXVA2_FilterValues
{
    DXVA2_Fixed32 Level;
    DXVA2_Fixed32 Threshold;
    DXVA2_Fixed32 Radius;
}

struct DXVA2_VideoProcessBltParams
{
    long TargetFrame;
    RECT TargetRect;
    SIZE ConstrictionSize;
    uint StreamingFlags;
    DXVA2_AYUVSample16 BackgroundColor;
    DXVA2_ExtendedFormat DestFormat;
    DXVA2_ProcAmpValues ProcAmpValues;
    DXVA2_Fixed32 Alpha;
    DXVA2_FilterValues NoiseFilterLuma;
    DXVA2_FilterValues NoiseFilterChroma;
    DXVA2_FilterValues DetailFilterLuma;
    DXVA2_FilterValues DetailFilterChroma;
    uint DestData;
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0012
{
    DXVA2_PictureParametersBufferType = 0,
    DXVA2_MacroBlockControlBufferType = 1,
    DXVA2_ResidualDifferenceBufferType = 2,
    DXVA2_DeblockingControlBufferType = 3,
    DXVA2_InverseQuantizationMatrixBufferType = 4,
    DXVA2_SliceControlBufferType = 5,
    DXVA2_BitStreamDateBufferType = 6,
    DXVA2_MotionVectorBuffer = 7,
    DXVA2_FilmGrainBuffer = 8,
}

enum __MIDL___MIDL_itf_dxva2api_0000_0000_0013
{
    DXVA2_VideoDecoderRenderTarget = 0,
    DXVA2_VideoProcessorRenderTarget = 1,
    DXVA2_VideoSoftwareRenderTarget = 2,
}

struct DXVA2_ConfigPictureDecode
{
    Guid guidConfigBitstreamEncryption;
    Guid guidConfigMBcontrolEncryption;
    Guid guidConfigResidDiffEncryption;
    uint ConfigBitstreamRaw;
    uint ConfigMBcontrolRasterOrder;
    uint ConfigResidDiffHost;
    uint ConfigSpatialResid8;
    uint ConfigResid8Subtraction;
    uint ConfigSpatialHost8or9Clipping;
    uint ConfigSpatialResidInterleaved;
    uint ConfigIntraResidUnsigned;
    uint ConfigResidDiffAccelerator;
    uint ConfigHostInverseScan;
    uint ConfigSpecificIDCT;
    uint Config4GroupedCoefs;
    ushort ConfigMinRenderTargetBuffCount;
    ushort ConfigDecoderSpecific;
}

struct DXVA2_DecodeBufferDesc
{
    uint CompressedBufferType;
    uint BufferIndex;
    uint DataOffset;
    uint DataSize;
    uint FirstMBaddress;
    uint NumMBsInBuffer;
    uint Width;
    uint Height;
    uint Stride;
    uint ReservedBits;
    void* pvPVPState;
}

struct DXVA2_AES_CTR_IV
{
    ulong IV;
    ulong Count;
}

struct DXVA2_DecodeExtensionData
{
    uint Function;
    void* pPrivateInputData;
    uint PrivateInputDataSize;
    void* pPrivateOutputData;
    uint PrivateOutputDataSize;
}

struct DXVA2_DecodeExecuteParams
{
    uint NumCompBuffers;
    DXVA2_DecodeBufferDesc* pCompressedBuffers;
    DXVA2_DecodeExtensionData* pExtensionData;
}

const GUID IID_IDirect3DDeviceManager9 = {0xA0CADE0F, 0x06D5, 0x4CF4, [0xA1, 0xC7, 0xF3, 0xCD, 0xD7, 0x25, 0xAA, 0x75]};
@GUID(0xA0CADE0F, 0x06D5, 0x4CF4, [0xA1, 0xC7, 0xF3, 0xCD, 0xD7, 0x25, 0xAA, 0x75]);
interface IDirect3DDeviceManager9 : IUnknown
{
    HRESULT ResetDevice(IDirect3DDevice9 pDevice, uint resetToken);
    HRESULT OpenDeviceHandle(HANDLE* phDevice);
    HRESULT CloseDeviceHandle(HANDLE hDevice);
    HRESULT TestDevice(HANDLE hDevice);
    HRESULT LockDevice(HANDLE hDevice, IDirect3DDevice9* ppDevice, BOOL fBlock);
    HRESULT UnlockDevice(HANDLE hDevice, BOOL fSaveState);
    HRESULT GetVideoService(HANDLE hDevice, const(Guid)* riid, void** ppService);
}

const GUID IID_IDirectXVideoAccelerationService = {0xFC51A550, 0xD5E7, 0x11D9, [0xAF, 0x55, 0x00, 0x05, 0x4E, 0x43, 0xFF, 0x02]};
@GUID(0xFC51A550, 0xD5E7, 0x11D9, [0xAF, 0x55, 0x00, 0x05, 0x4E, 0x43, 0xFF, 0x02]);
interface IDirectXVideoAccelerationService : IUnknown
{
    HRESULT CreateSurface(uint Width, uint Height, uint BackBuffers, D3DFORMAT Format, D3DPOOL Pool, uint Usage, uint DxvaType, char* ppSurface, HANDLE* pSharedHandle);
}

const GUID IID_IDirectXVideoDecoderService = {0xFC51A551, 0xD5E7, 0x11D9, [0xAF, 0x55, 0x00, 0x05, 0x4E, 0x43, 0xFF, 0x02]};
@GUID(0xFC51A551, 0xD5E7, 0x11D9, [0xAF, 0x55, 0x00, 0x05, 0x4E, 0x43, 0xFF, 0x02]);
interface IDirectXVideoDecoderService : IDirectXVideoAccelerationService
{
    HRESULT GetDecoderDeviceGuids(uint* pCount, Guid** pGuids);
    HRESULT GetDecoderRenderTargets(const(Guid)* Guid, uint* pCount, D3DFORMAT** pFormats);
    HRESULT GetDecoderConfigurations(const(Guid)* Guid, const(DXVA2_VideoDesc)* pVideoDesc, void* pReserved, uint* pCount, DXVA2_ConfigPictureDecode** ppConfigs);
    HRESULT CreateVideoDecoder(const(Guid)* Guid, const(DXVA2_VideoDesc)* pVideoDesc, const(DXVA2_ConfigPictureDecode)* pConfig, char* ppDecoderRenderTargets, uint NumRenderTargets, IDirectXVideoDecoder* ppDecode);
}

const GUID IID_IDirectXVideoProcessorService = {0xFC51A552, 0xD5E7, 0x11D9, [0xAF, 0x55, 0x00, 0x05, 0x4E, 0x43, 0xFF, 0x02]};
@GUID(0xFC51A552, 0xD5E7, 0x11D9, [0xAF, 0x55, 0x00, 0x05, 0x4E, 0x43, 0xFF, 0x02]);
interface IDirectXVideoProcessorService : IDirectXVideoAccelerationService
{
    HRESULT RegisterVideoProcessorSoftwareDevice(void* pCallbacks);
    HRESULT GetVideoProcessorDeviceGuids(const(DXVA2_VideoDesc)* pVideoDesc, uint* pCount, Guid** pGuids);
    HRESULT GetVideoProcessorRenderTargets(const(Guid)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, uint* pCount, D3DFORMAT** pFormats);
    HRESULT GetVideoProcessorSubStreamFormats(const(Guid)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, D3DFORMAT RenderTargetFormat, uint* pCount, D3DFORMAT** pFormats);
    HRESULT GetVideoProcessorCaps(const(Guid)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, D3DFORMAT RenderTargetFormat, DXVA2_VideoProcessorCaps* pCaps);
    HRESULT GetProcAmpRange(const(Guid)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, D3DFORMAT RenderTargetFormat, uint ProcAmpCap, DXVA2_ValueRange* pRange);
    HRESULT GetFilterPropertyRange(const(Guid)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, D3DFORMAT RenderTargetFormat, uint FilterSetting, DXVA2_ValueRange* pRange);
    HRESULT CreateVideoProcessor(const(Guid)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, D3DFORMAT RenderTargetFormat, uint MaxNumSubStreams, IDirectXVideoProcessor* ppVidProcess);
}

const GUID IID_IDirectXVideoDecoder = {0xF2B0810A, 0xFD00, 0x43C9, [0x91, 0x8C, 0xDF, 0x94, 0xE2, 0xD8, 0xEF, 0x7D]};
@GUID(0xF2B0810A, 0xFD00, 0x43C9, [0x91, 0x8C, 0xDF, 0x94, 0xE2, 0xD8, 0xEF, 0x7D]);
interface IDirectXVideoDecoder : IUnknown
{
    HRESULT GetVideoDecoderService(IDirectXVideoDecoderService* ppService);
    HRESULT GetCreationParameters(Guid* pDeviceGuid, DXVA2_VideoDesc* pVideoDesc, DXVA2_ConfigPictureDecode* pConfig, char* pDecoderRenderTargets, uint* pNumSurfaces);
    HRESULT GetBuffer(uint BufferType, void** ppBuffer, uint* pBufferSize);
    HRESULT ReleaseBuffer(uint BufferType);
    HRESULT BeginFrame(IDirect3DSurface9 pRenderTarget, void* pvPVPData);
    HRESULT EndFrame(HANDLE* pHandleComplete);
    HRESULT Execute(const(DXVA2_DecodeExecuteParams)* pExecuteParams);
}

const GUID IID_IDirectXVideoProcessor = {0x8C3A39F0, 0x916E, 0x4690, [0x80, 0x4F, 0x4C, 0x80, 0x01, 0x35, 0x5D, 0x25]};
@GUID(0x8C3A39F0, 0x916E, 0x4690, [0x80, 0x4F, 0x4C, 0x80, 0x01, 0x35, 0x5D, 0x25]);
interface IDirectXVideoProcessor : IUnknown
{
    HRESULT GetVideoProcessorService(IDirectXVideoProcessorService* ppService);
    HRESULT GetCreationParameters(Guid* pDeviceGuid, DXVA2_VideoDesc* pVideoDesc, D3DFORMAT* pRenderTargetFormat, uint* pMaxNumSubStreams);
    HRESULT GetVideoProcessorCaps(DXVA2_VideoProcessorCaps* pCaps);
    HRESULT GetProcAmpRange(uint ProcAmpCap, DXVA2_ValueRange* pRange);
    HRESULT GetFilterPropertyRange(uint FilterSetting, DXVA2_ValueRange* pRange);
    HRESULT VideoProcessBlt(IDirect3DSurface9 pRenderTarget, const(DXVA2_VideoProcessBltParams)* pBltParams, char* pSamples, uint NumSamples, HANDLE* pHandleComplete);
}

enum DXVA2_SurfaceType
{
    DXVA2_SurfaceType_DecoderRenderTarget = 0,
    DXVA2_SurfaceType_ProcessorRenderTarget = 1,
    DXVA2_SurfaceType_D3DRenderTargetTexture = 2,
}

const GUID IID_IDirectXVideoMemoryConfiguration = {0xB7F916DD, 0xDB3B, 0x49C1, [0x84, 0xD7, 0xE4, 0x5E, 0xF9, 0x9E, 0xC7, 0x26]};
@GUID(0xB7F916DD, 0xDB3B, 0x49C1, [0x84, 0xD7, 0xE4, 0x5E, 0xF9, 0x9E, 0xC7, 0x26]);
interface IDirectXVideoMemoryConfiguration : IUnknown
{
    HRESULT GetAvailableSurfaceTypeByIndex(uint dwTypeIndex, DXVA2_SurfaceType* pdwType);
    HRESULT SetSurfaceType(DXVA2_SurfaceType dwType);
}

enum __MIDL___MIDL_itf_opmapi_0000_0000_0001
{
    OPM_OMAC_SIZE = 16,
    OPM_128_BIT_RANDOM_NUMBER_SIZE = 16,
    OPM_ENCRYPTED_INITIALIZATION_PARAMETERS_SIZE = 256,
    OPM_CONFIGURE_SETTING_DATA_SIZE = 4056,
    OPM_GET_INFORMATION_PARAMETERS_SIZE = 4056,
    OPM_REQUESTED_INFORMATION_SIZE = 4076,
    OPM_HDCP_KEY_SELECTION_VECTOR_SIZE = 5,
    OPM_PROTECTION_TYPE_SIZE = 4,
    OPM_BUS_TYPE_MASK = 65535,
    OPM_BUS_IMPLEMENTATION_MODIFIER_MASK = 32767,
}

enum OPM_VIDEO_OUTPUT_SEMANTICS
{
    OPM_VOS_COPP_SEMANTICS = 0,
    OPM_VOS_OPM_SEMANTICS = 1,
    OPM_VOS_OPM_INDIRECT_DISPLAY = 2,
}

enum __MIDL___MIDL_itf_opmapi_0000_0000_0002
{
    OPM_HDCP_FLAG_NONE = 0,
    OPM_HDCP_FLAG_REPEATER = 1,
}

enum __MIDL___MIDL_itf_opmapi_0000_0000_0003
{
    OPM_STATUS_NORMAL = 0,
    OPM_STATUS_LINK_LOST = 1,
    OPM_STATUS_RENEGOTIATION_REQUIRED = 2,
    OPM_STATUS_TAMPERING_DETECTED = 4,
    OPM_STATUS_REVOKED_HDCP_DEVICE_ATTACHED = 8,
}

enum __MIDL___MIDL_itf_opmapi_0000_0000_0004
{
    OPM_CONNECTOR_TYPE_OTHER = -1,
    OPM_CONNECTOR_TYPE_VGA = 0,
    OPM_CONNECTOR_TYPE_SVIDEO = 1,
    OPM_CONNECTOR_TYPE_COMPOSITE_VIDEO = 2,
    OPM_CONNECTOR_TYPE_COMPONENT_VIDEO = 3,
    OPM_CONNECTOR_TYPE_DVI = 4,
    OPM_CONNECTOR_TYPE_HDMI = 5,
    OPM_CONNECTOR_TYPE_LVDS = 6,
    OPM_CONNECTOR_TYPE_D_JPN = 8,
    OPM_CONNECTOR_TYPE_SDI = 9,
    OPM_CONNECTOR_TYPE_DISPLAYPORT_EXTERNAL = 10,
    OPM_CONNECTOR_TYPE_DISPLAYPORT_EMBEDDED = 11,
    OPM_CONNECTOR_TYPE_UDI_EXTERNAL = 12,
    OPM_CONNECTOR_TYPE_UDI_EMBEDDED = 13,
    OPM_CONNECTOR_TYPE_RESERVED = 14,
    OPM_CONNECTOR_TYPE_MIRACAST = 15,
    OPM_CONNECTOR_TYPE_TRANSPORT_AGNOSTIC_DIGITAL_MODE_A = 16,
    OPM_CONNECTOR_TYPE_TRANSPORT_AGNOSTIC_DIGITAL_MODE_B = 17,
    OPM_COPP_COMPATIBLE_CONNECTOR_TYPE_INTERNAL = -2147483648,
}

enum __MIDL___MIDL_itf_opmapi_0000_0000_0005
{
    OPM_DVI_CHARACTERISTIC_1_0 = 1,
    OPM_DVI_CHARACTERISTIC_1_1_OR_ABOVE = 2,
}

enum OPM_OUTPUT_HARDWARE_PROTECTION
{
    OPM_OUTPUT_HARDWARE_PROTECTION_NOT_SUPPORTED = 0,
    OPM_OUTPUT_HARDWARE_PROTECTION_SUPPORTED = 1,
}

enum __MIDL___MIDL_itf_opmapi_0000_0000_0006
{
    OPM_BUS_TYPE_OTHER = 0,
    OPM_BUS_TYPE_PCI = 1,
    OPM_BUS_TYPE_PCIX = 2,
    OPM_BUS_TYPE_PCIEXPRESS = 3,
    OPM_BUS_TYPE_AGP = 4,
    OPM_BUS_IMPLEMENTATION_MODIFIER_INSIDE_OF_CHIPSET = 65536,
    OPM_BUS_IMPLEMENTATION_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_CHIP = 131072,
    OPM_BUS_IMPLEMENTATION_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_SOCKET = 196608,
    OPM_BUS_IMPLEMENTATION_MODIFIER_DAUGHTER_BOARD_CONNECTOR = 262144,
    OPM_BUS_IMPLEMENTATION_MODIFIER_DAUGHTER_BOARD_CONNECTOR_INSIDE_OF_NUAE = 327680,
    OPM_BUS_IMPLEMENTATION_MODIFIER_NON_STANDARD = -2147483648,
    OPM_COPP_COMPATIBLE_BUS_TYPE_INTEGRATED = -2147483648,
}

enum OPM_DPCP_PROTECTION_LEVEL
{
    OPM_DPCP_OFF = 0,
    OPM_DPCP_ON = 1,
    OPM_DPCP_FORCE_ULONG = 2147483647,
}

enum OPM_HDCP_PROTECTION_LEVEL
{
    OPM_HDCP_OFF = 0,
    OPM_HDCP_ON = 1,
    OPM_HDCP_FORCE_ULONG = 2147483647,
}

enum OPM_TYPE_ENFORCEMENT_HDCP_PROTECTION_LEVEL
{
    OPM_TYPE_ENFORCEMENT_HDCP_OFF = 0,
    OPM_TYPE_ENFORCEMENT_HDCP_ON_WITH_NO_TYPE_RESTRICTION = 1,
    OPM_TYPE_ENFORCEMENT_HDCP_ON_WITH_TYPE1_RESTRICTION = 2,
    OPM_TYPE_ENFORCEMENT_HDCP_FORCE_ULONG = 2147483647,
}

enum __MIDL___MIDL_itf_opmapi_0000_0000_0007
{
    OPM_CGMSA_OFF = 0,
    OPM_CGMSA_COPY_FREELY = 1,
    OPM_CGMSA_COPY_NO_MORE = 2,
    OPM_CGMSA_COPY_ONE_GENERATION = 3,
    OPM_CGMSA_COPY_NEVER = 4,
    OPM_CGMSA_REDISTRIBUTION_CONTROL_REQUIRED = 8,
}

enum OPM_ACP_PROTECTION_LEVEL
{
    OPM_ACP_OFF = 0,
    OPM_ACP_LEVEL_ONE = 1,
    OPM_ACP_LEVEL_TWO = 2,
    OPM_ACP_LEVEL_THREE = 3,
    OPM_ACP_FORCE_ULONG = 2147483647,
}

enum __MIDL___MIDL_itf_opmapi_0000_0000_0008
{
    OPM_PROTECTION_TYPE_OTHER = -2147483648,
    OPM_PROTECTION_TYPE_NONE = 0,
    OPM_PROTECTION_TYPE_COPP_COMPATIBLE_HDCP = 1,
    OPM_PROTECTION_TYPE_ACP = 2,
    OPM_PROTECTION_TYPE_CGMSA = 4,
    OPM_PROTECTION_TYPE_HDCP = 8,
    OPM_PROTECTION_TYPE_DPCP = 16,
    OPM_PROTECTION_TYPE_TYPE_ENFORCEMENT_HDCP = 32,
}

enum __MIDL___MIDL_itf_opmapi_0000_0000_0009
{
    OPM_PROTECTION_STANDARD_OTHER = -2147483648,
    OPM_PROTECTION_STANDARD_NONE = 0,
    OPM_PROTECTION_STANDARD_IEC61880_525I = 1,
    OPM_PROTECTION_STANDARD_IEC61880_2_525I = 2,
    OPM_PROTECTION_STANDARD_IEC62375_625P = 4,
    OPM_PROTECTION_STANDARD_EIA608B_525 = 8,
    OPM_PROTECTION_STANDARD_EN300294_625I = 16,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEA_525P = 32,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEA_750P = 64,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEA_1125I = 128,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEB_525P = 256,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEB_750P = 512,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEB_1125I = 1024,
    OPM_PROTECTION_STANDARD_ARIBTRB15_525I = 2048,
    OPM_PROTECTION_STANDARD_ARIBTRB15_525P = 4096,
    OPM_PROTECTION_STANDARD_ARIBTRB15_750P = 8192,
    OPM_PROTECTION_STANDARD_ARIBTRB15_1125I = 16384,
}

enum OPM_IMAGE_ASPECT_RATIO_EN300294
{
    OPM_ASPECT_RATIO_EN300294_FULL_FORMAT_4_BY_3 = 0,
    OPM_ASPECT_RATIO_EN300294_BOX_14_BY_9_CENTER = 1,
    OPM_ASPECT_RATIO_EN300294_BOX_14_BY_9_TOP = 2,
    OPM_ASPECT_RATIO_EN300294_BOX_16_BY_9_CENTER = 3,
    OPM_ASPECT_RATIO_EN300294_BOX_16_BY_9_TOP = 4,
    OPM_ASPECT_RATIO_EN300294_BOX_GT_16_BY_9_CENTER = 5,
    OPM_ASPECT_RATIO_EN300294_FULL_FORMAT_4_BY_3_PROTECTED_CENTER = 6,
    OPM_ASPECT_RATIO_EN300294_FULL_FORMAT_16_BY_9_ANAMORPHIC = 7,
    OPM_ASPECT_RATIO_FORCE_ULONG = 2147483647,
}

struct OPM_RANDOM_NUMBER
{
    ubyte abRandomNumber;
}

struct OPM_OMAC
{
    ubyte abOMAC;
}

struct OPM_ENCRYPTED_INITIALIZATION_PARAMETERS
{
    ubyte abEncryptedInitializationParameters;
}

struct OPM_GET_INFO_PARAMETERS
{
    OPM_OMAC omac;
    OPM_RANDOM_NUMBER rnRandomNumber;
    Guid guidInformation;
    uint ulSequenceNumber;
    uint cbParametersSize;
    ubyte abParameters;
}

struct OPM_COPP_COMPATIBLE_GET_INFO_PARAMETERS
{
    OPM_RANDOM_NUMBER rnRandomNumber;
    Guid guidInformation;
    uint ulSequenceNumber;
    uint cbParametersSize;
    ubyte abParameters;
}

struct OPM_HDCP_KEY_SELECTION_VECTOR
{
    ubyte abKeySelectionVector;
}

struct OPM_CONNECTED_HDCP_DEVICE_INFORMATION
{
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint ulStatusFlags;
    uint ulHDCPFlags;
    OPM_HDCP_KEY_SELECTION_VECTOR ksvB;
    ubyte Reserved;
    ubyte Reserved2;
    ubyte Reserved3;
}

struct OPM_REQUESTED_INFORMATION
{
    OPM_OMAC omac;
    uint cbRequestedInformationSize;
    ubyte abRequestedInformation;
}

struct OPM_STANDARD_INFORMATION
{
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint ulStatusFlags;
    uint ulInformation;
    uint ulReserved;
    uint ulReserved2;
}

struct OPM_ACTUAL_OUTPUT_FORMAT
{
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint ulStatusFlags;
    uint ulDisplayWidth;
    uint ulDisplayHeight;
    DXVA2_SampleFormat dsfSampleInterleaveFormat;
    D3DFORMAT d3dFormat;
    uint ulFrequencyNumerator;
    uint ulFrequencyDenominator;
}

struct OPM_ACP_AND_CGMSA_SIGNALING
{
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint ulStatusFlags;
    uint ulAvailableTVProtectionStandards;
    uint ulActiveTVProtectionStandard;
    uint ulReserved;
    uint ulAspectRatioValidMask1;
    uint ulAspectRatioData1;
    uint ulAspectRatioValidMask2;
    uint ulAspectRatioData2;
    uint ulAspectRatioValidMask3;
    uint ulAspectRatioData3;
    uint ulReserved2;
    uint ulReserved3;
}

struct OPM_OUTPUT_ID_DATA
{
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint ulStatusFlags;
    ulong OutputId;
}

struct OPM_CONFIGURE_PARAMETERS
{
    OPM_OMAC omac;
    Guid guidSetting;
    uint ulSequenceNumber;
    uint cbParametersSize;
    ubyte abParameters;
}

struct OPM_SET_PROTECTION_LEVEL_PARAMETERS
{
    uint ulProtectionType;
    uint ulProtectionLevel;
    uint Reserved;
    uint Reserved2;
}

struct OPM_SET_ACP_AND_CGMSA_SIGNALING_PARAMETERS
{
    uint ulNewTVProtectionStandard;
    uint ulAspectRatioChangeMask1;
    uint ulAspectRatioData1;
    uint ulAspectRatioChangeMask2;
    uint ulAspectRatioData2;
    uint ulAspectRatioChangeMask3;
    uint ulAspectRatioData3;
    uint ulReserved;
    uint ulReserved2;
    uint ulReserved3;
}

struct OPM_SET_HDCP_SRM_PARAMETERS
{
    uint ulSRMVersion;
}

struct OPM_GET_CODEC_INFO_PARAMETERS
{
    uint cbVerifier;
    ubyte Verifier;
}

struct OPM_GET_CODEC_INFO_INFORMATION
{
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint Merit;
}

const GUID IID_IOPMVideoOutput = {0x0A15159D, 0x41C7, 0x4456, [0x93, 0xE1, 0x28, 0x4C, 0xD6, 0x1D, 0x4E, 0x8D]};
@GUID(0x0A15159D, 0x41C7, 0x4456, [0x93, 0xE1, 0x28, 0x4C, 0xD6, 0x1D, 0x4E, 0x8D]);
interface IOPMVideoOutput : IUnknown
{
    HRESULT StartInitialization(OPM_RANDOM_NUMBER* prnRandomNumber, ubyte** ppbCertificate, uint* pulCertificateLength);
    HRESULT FinishInitialization(const(OPM_ENCRYPTED_INITIALIZATION_PARAMETERS)* pParameters);
    HRESULT GetInformation(const(OPM_GET_INFO_PARAMETERS)* pParameters, OPM_REQUESTED_INFORMATION* pRequestedInformation);
    HRESULT COPPCompatibleGetInformation(const(OPM_COPP_COMPATIBLE_GET_INFO_PARAMETERS)* pParameters, OPM_REQUESTED_INFORMATION* pRequestedInformation);
    HRESULT Configure(const(OPM_CONFIGURE_PARAMETERS)* pParameters, uint ulAdditionalParametersSize, char* pbAdditionalParameters);
}

const GUID CLSID_KSPROPSETID_OPMVideoOutput = {0x06F414BB, 0xF43A, 0x4FE2, [0xA5, 0x66, 0x77, 0x4B, 0x4C, 0x81, 0xF0, 0xDB]};
@GUID(0x06F414BB, 0xF43A, 0x4FE2, [0xA5, 0x66, 0x77, 0x4B, 0x4C, 0x81, 0xF0, 0xDB]);
struct KSPROPSETID_OPMVideoOutput;

enum KSMETHOD_OPMVIDEOOUTPUT
{
    KSMETHOD_OPMVIDEOOUTPUT_STARTINITIALIZATION = 0,
    KSMETHOD_OPMVIDEOOUTPUT_FINISHINITIALIZATION = 1,
    KSMETHOD_OPMVIDEOOUTPUT_GETINFORMATION = 2,
}

enum MF_ATTRIBUTE_TYPE
{
    MF_ATTRIBUTE_UINT32 = 19,
    MF_ATTRIBUTE_UINT64 = 21,
    MF_ATTRIBUTE_DOUBLE = 5,
    MF_ATTRIBUTE_GUID = 72,
    MF_ATTRIBUTE_STRING = 31,
    MF_ATTRIBUTE_BLOB = 4113,
    MF_ATTRIBUTE_IUNKNOWN = 13,
}

enum MF_ATTRIBUTES_MATCH_TYPE
{
    MF_ATTRIBUTES_MATCH_OUR_ITEMS = 0,
    MF_ATTRIBUTES_MATCH_THEIR_ITEMS = 1,
    MF_ATTRIBUTES_MATCH_ALL_ITEMS = 2,
    MF_ATTRIBUTES_MATCH_INTERSECTION = 3,
    MF_ATTRIBUTES_MATCH_SMALLER = 4,
}

const GUID IID_IMFAttributes = {0x2CD2D921, 0xC447, 0x44A7, [0xA1, 0x3C, 0x4A, 0xDA, 0xBF, 0xC2, 0x47, 0xE3]};
@GUID(0x2CD2D921, 0xC447, 0x44A7, [0xA1, 0x3C, 0x4A, 0xDA, 0xBF, 0xC2, 0x47, 0xE3]);
interface IMFAttributes : IUnknown
{
    HRESULT GetItem(const(Guid)* guidKey, PROPVARIANT* pValue);
    HRESULT GetItemType(const(Guid)* guidKey, MF_ATTRIBUTE_TYPE* pType);
    HRESULT CompareItem(const(Guid)* guidKey, const(PROPVARIANT)* Value, int* pbResult);
    HRESULT Compare(IMFAttributes pTheirs, MF_ATTRIBUTES_MATCH_TYPE MatchType, int* pbResult);
    HRESULT GetUINT32(const(Guid)* guidKey, uint* punValue);
    HRESULT GetUINT64(const(Guid)* guidKey, ulong* punValue);
    HRESULT GetDouble(const(Guid)* guidKey, double* pfValue);
    HRESULT GetGUID(const(Guid)* guidKey, Guid* pguidValue);
    HRESULT GetStringLength(const(Guid)* guidKey, uint* pcchLength);
    HRESULT GetString(const(Guid)* guidKey, const(wchar)* pwszValue, uint cchBufSize, uint* pcchLength);
    HRESULT GetAllocatedString(const(Guid)* guidKey, char* ppwszValue, uint* pcchLength);
    HRESULT GetBlobSize(const(Guid)* guidKey, uint* pcbBlobSize);
    HRESULT GetBlob(const(Guid)* guidKey, char* pBuf, uint cbBufSize, uint* pcbBlobSize);
    HRESULT GetAllocatedBlob(const(Guid)* guidKey, char* ppBuf, uint* pcbSize);
    HRESULT GetUnknown(const(Guid)* guidKey, const(Guid)* riid, void** ppv);
    HRESULT SetItem(const(Guid)* guidKey, const(PROPVARIANT)* Value);
    HRESULT DeleteItem(const(Guid)* guidKey);
    HRESULT DeleteAllItems();
    HRESULT SetUINT32(const(Guid)* guidKey, uint unValue);
    HRESULT SetUINT64(const(Guid)* guidKey, ulong unValue);
    HRESULT SetDouble(const(Guid)* guidKey, double fValue);
    HRESULT SetGUID(const(Guid)* guidKey, const(Guid)* guidValue);
    HRESULT SetString(const(Guid)* guidKey, const(wchar)* wszValue);
    HRESULT SetBlob(const(Guid)* guidKey, char* pBuf, uint cbBufSize);
    HRESULT SetUnknown(const(Guid)* guidKey, IUnknown pUnknown);
    HRESULT LockStore();
    HRESULT UnlockStore();
    HRESULT GetCount(uint* pcItems);
    HRESULT GetItemByIndex(uint unIndex, Guid* pguidKey, PROPVARIANT* pValue);
    HRESULT CopyAllItems(IMFAttributes pDest);
}

enum MF_ATTRIBUTE_SERIALIZE_OPTIONS
{
    MF_ATTRIBUTE_SERIALIZE_UNKNOWN_BYREF = 1,
}

const GUID IID_IMFMediaBuffer = {0x045FA593, 0x8799, 0x42B8, [0xBC, 0x8D, 0x89, 0x68, 0xC6, 0x45, 0x35, 0x07]};
@GUID(0x045FA593, 0x8799, 0x42B8, [0xBC, 0x8D, 0x89, 0x68, 0xC6, 0x45, 0x35, 0x07]);
interface IMFMediaBuffer : IUnknown
{
    HRESULT Lock(char* ppbBuffer, uint* pcbMaxLength, uint* pcbCurrentLength);
    HRESULT Unlock();
    HRESULT GetCurrentLength(uint* pcbCurrentLength);
    HRESULT SetCurrentLength(uint cbCurrentLength);
    HRESULT GetMaxLength(uint* pcbMaxLength);
}

const GUID IID_IMFSample = {0xC40A00F2, 0xB93A, 0x4D80, [0xAE, 0x8C, 0x5A, 0x1C, 0x63, 0x4F, 0x58, 0xE4]};
@GUID(0xC40A00F2, 0xB93A, 0x4D80, [0xAE, 0x8C, 0x5A, 0x1C, 0x63, 0x4F, 0x58, 0xE4]);
interface IMFSample : IMFAttributes
{
    HRESULT GetSampleFlags(uint* pdwSampleFlags);
    HRESULT SetSampleFlags(uint dwSampleFlags);
    HRESULT GetSampleTime(long* phnsSampleTime);
    HRESULT SetSampleTime(long hnsSampleTime);
    HRESULT GetSampleDuration(long* phnsSampleDuration);
    HRESULT SetSampleDuration(long hnsSampleDuration);
    HRESULT GetBufferCount(uint* pdwBufferCount);
    HRESULT GetBufferByIndex(uint dwIndex, IMFMediaBuffer* ppBuffer);
    HRESULT ConvertToContiguousBuffer(IMFMediaBuffer* ppBuffer);
    HRESULT AddBuffer(IMFMediaBuffer pBuffer);
    HRESULT RemoveBufferByIndex(uint dwIndex);
    HRESULT RemoveAllBuffers();
    HRESULT GetTotalLength(uint* pcbTotalLength);
    HRESULT CopyToBuffer(IMFMediaBuffer pBuffer);
}

const GUID IID_IMF2DBuffer = {0x7DC9D5F9, 0x9ED9, 0x44EC, [0x9B, 0xBF, 0x06, 0x00, 0xBB, 0x58, 0x9F, 0xBB]};
@GUID(0x7DC9D5F9, 0x9ED9, 0x44EC, [0x9B, 0xBF, 0x06, 0x00, 0xBB, 0x58, 0x9F, 0xBB]);
interface IMF2DBuffer : IUnknown
{
    HRESULT Lock2D(ubyte** ppbScanline0, int* plPitch);
    HRESULT Unlock2D();
    HRESULT GetScanline0AndPitch(ubyte** pbScanline0, int* plPitch);
    HRESULT IsContiguousFormat(int* pfIsContiguous);
    HRESULT GetContiguousLength(uint* pcbLength);
    HRESULT ContiguousCopyTo(char* pbDestBuffer, uint cbDestBuffer);
    HRESULT ContiguousCopyFrom(char* pbSrcBuffer, uint cbSrcBuffer);
}

enum MF2DBuffer_LockFlags
{
    MF2DBuffer_LockFlags_LockTypeMask = 3,
    MF2DBuffer_LockFlags_Read = 1,
    MF2DBuffer_LockFlags_Write = 2,
    MF2DBuffer_LockFlags_ReadWrite = 3,
    MF2DBuffer_LockFlags_ForceDWORD = 2147483647,
}

const GUID IID_IMF2DBuffer2 = {0x33AE5EA6, 0x4316, 0x436F, [0x8D, 0xDD, 0xD7, 0x3D, 0x22, 0xF8, 0x29, 0xEC]};
@GUID(0x33AE5EA6, 0x4316, 0x436F, [0x8D, 0xDD, 0xD7, 0x3D, 0x22, 0xF8, 0x29, 0xEC]);
interface IMF2DBuffer2 : IMF2DBuffer
{
    HRESULT Lock2DSize(MF2DBuffer_LockFlags lockFlags, ubyte** ppbScanline0, int* plPitch, ubyte** ppbBufferStart, uint* pcbBufferLength);
    HRESULT Copy2DTo(IMF2DBuffer2 pDestBuffer);
}

const GUID IID_IMFDXGIBuffer = {0xE7174CFA, 0x1C9E, 0x48B1, [0x88, 0x66, 0x62, 0x62, 0x26, 0xBF, 0xC2, 0x58]};
@GUID(0xE7174CFA, 0x1C9E, 0x48B1, [0x88, 0x66, 0x62, 0x62, 0x26, 0xBF, 0xC2, 0x58]);
interface IMFDXGIBuffer : IUnknown
{
    HRESULT GetResource(const(Guid)* riid, void** ppvObject);
    HRESULT GetSubresourceIndex(uint* puSubresource);
    HRESULT GetUnknown(const(Guid)* guid, const(Guid)* riid, void** ppvObject);
    HRESULT SetUnknown(const(Guid)* guid, IUnknown pUnkData);
}

const GUID IID_IMFMediaType = {0x44AE0FA8, 0xEA31, 0x4109, [0x8D, 0x2E, 0x4C, 0xAE, 0x49, 0x97, 0xC5, 0x55]};
@GUID(0x44AE0FA8, 0xEA31, 0x4109, [0x8D, 0x2E, 0x4C, 0xAE, 0x49, 0x97, 0xC5, 0x55]);
interface IMFMediaType : IMFAttributes
{
    HRESULT GetMajorType(Guid* pguidMajorType);
    HRESULT IsCompressedFormat(int* pfCompressed);
    HRESULT IsEqual(IMFMediaType pIMediaType, uint* pdwFlags);
    HRESULT GetRepresentation(Guid guidRepresentation, void** ppvRepresentation);
    HRESULT FreeRepresentation(Guid guidRepresentation, void* pvRepresentation);
}

const GUID IID_IMFAudioMediaType = {0x26A0ADC3, 0xCE26, 0x4672, [0x93, 0x04, 0x69, 0x55, 0x2E, 0xDD, 0x3F, 0xAF]};
@GUID(0x26A0ADC3, 0xCE26, 0x4672, [0x93, 0x04, 0x69, 0x55, 0x2E, 0xDD, 0x3F, 0xAF]);
interface IMFAudioMediaType : IMFMediaType
{
    WAVEFORMATEX* GetAudioFormat();
}

struct MFT_REGISTER_TYPE_INFO
{
    Guid guidMajorType;
    Guid guidSubtype;
}

enum MFVideoInterlaceMode
{
    MFVideoInterlace_Unknown = 0,
    MFVideoInterlace_Progressive = 2,
    MFVideoInterlace_FieldInterleavedUpperFirst = 3,
    MFVideoInterlace_FieldInterleavedLowerFirst = 4,
    MFVideoInterlace_FieldSingleUpper = 5,
    MFVideoInterlace_FieldSingleLower = 6,
    MFVideoInterlace_MixedInterlaceOrProgressive = 7,
    MFVideoInterlace_Last = 8,
    MFVideoInterlace_ForceDWORD = 2147483647,
}

enum MFVideoTransferFunction
{
    MFVideoTransFunc_Unknown = 0,
    MFVideoTransFunc_10 = 1,
    MFVideoTransFunc_18 = 2,
    MFVideoTransFunc_20 = 3,
    MFVideoTransFunc_22 = 4,
    MFVideoTransFunc_709 = 5,
    MFVideoTransFunc_240M = 6,
    MFVideoTransFunc_sRGB = 7,
    MFVideoTransFunc_28 = 8,
    MFVideoTransFunc_Log_100 = 9,
    MFVideoTransFunc_Log_316 = 10,
    MFVideoTransFunc_709_sym = 11,
    MFVideoTransFunc_2020_const = 12,
    MFVideoTransFunc_2020 = 13,
    MFVideoTransFunc_26 = 14,
    MFVideoTransFunc_2084 = 15,
    MFVideoTransFunc_HLG = 16,
    MFVideoTransFunc_10_rel = 17,
    MFVideoTransFunc_Last = 18,
    MFVideoTransFunc_ForceDWORD = 2147483647,
}

enum MFVideoPrimaries
{
    MFVideoPrimaries_Unknown = 0,
    MFVideoPrimaries_reserved = 1,
    MFVideoPrimaries_BT709 = 2,
    MFVideoPrimaries_BT470_2_SysM = 3,
    MFVideoPrimaries_BT470_2_SysBG = 4,
    MFVideoPrimaries_SMPTE170M = 5,
    MFVideoPrimaries_SMPTE240M = 6,
    MFVideoPrimaries_EBU3213 = 7,
    MFVideoPrimaries_SMPTE_C = 8,
    MFVideoPrimaries_BT2020 = 9,
    MFVideoPrimaries_XYZ = 10,
    MFVideoPrimaries_DCI_P3 = 11,
    MFVideoPrimaries_ACES = 12,
    MFVideoPrimaries_Last = 13,
    MFVideoPrimaries_ForceDWORD = 2147483647,
}

enum MFVideoLighting
{
    MFVideoLighting_Unknown = 0,
    MFVideoLighting_bright = 1,
    MFVideoLighting_office = 2,
    MFVideoLighting_dim = 3,
    MFVideoLighting_dark = 4,
    MFVideoLighting_Last = 5,
    MFVideoLighting_ForceDWORD = 2147483647,
}

enum MFVideoTransferMatrix
{
    MFVideoTransferMatrix_Unknown = 0,
    MFVideoTransferMatrix_BT709 = 1,
    MFVideoTransferMatrix_BT601 = 2,
    MFVideoTransferMatrix_SMPTE240M = 3,
    MFVideoTransferMatrix_BT2020_10 = 4,
    MFVideoTransferMatrix_BT2020_12 = 5,
    MFVideoTransferMatrix_Last = 6,
    MFVideoTransferMatrix_ForceDWORD = 2147483647,
}

enum MFVideoChromaSubsampling
{
    MFVideoChromaSubsampling_Unknown = 0,
    MFVideoChromaSubsampling_ProgressiveChroma = 8,
    MFVideoChromaSubsampling_Horizontally_Cosited = 4,
    MFVideoChromaSubsampling_Vertically_Cosited = 2,
    MFVideoChromaSubsampling_Vertically_AlignedChromaPlanes = 1,
    MFVideoChromaSubsampling_MPEG2 = 5,
    MFVideoChromaSubsampling_MPEG1 = 1,
    MFVideoChromaSubsampling_DV_PAL = 6,
    MFVideoChromaSubsampling_Cosited = 7,
    MFVideoChromaSubsampling_Last = 8,
    MFVideoChromaSubsampling_ForceDWORD = 2147483647,
}

enum MFNominalRange
{
    MFNominalRange_Unknown = 0,
    MFNominalRange_Normal = 1,
    MFNominalRange_Wide = 2,
    MFNominalRange_0_255 = 1,
    MFNominalRange_16_235 = 2,
    MFNominalRange_48_208 = 3,
    MFNominalRange_64_127 = 4,
    MFNominalRange_Last = 5,
    MFNominalRange_ForceDWORD = 2147483647,
}

enum MFVideoFlags
{
    MFVideoFlag_PAD_TO_Mask = 3,
    MFVideoFlag_PAD_TO_None = 0,
    MFVideoFlag_PAD_TO_4x3 = 1,
    MFVideoFlag_PAD_TO_16x9 = 2,
    MFVideoFlag_SrcContentHintMask = 28,
    MFVideoFlag_SrcContentHintNone = 0,
    MFVideoFlag_SrcContentHint16x9 = 4,
    MFVideoFlag_SrcContentHint235_1 = 8,
    MFVideoFlag_AnalogProtected = 32,
    MFVideoFlag_DigitallyProtected = 64,
    MFVideoFlag_ProgressiveContent = 128,
    MFVideoFlag_FieldRepeatCountMask = 1792,
    MFVideoFlag_FieldRepeatCountShift = 8,
    MFVideoFlag_ProgressiveSeqReset = 2048,
    MFVideoFlag_PanScanEnabled = 131072,
    MFVideoFlag_LowerFieldFirst = 262144,
    MFVideoFlag_BottomUpLinearRep = 524288,
    MFVideoFlags_DXVASurface = 1048576,
    MFVideoFlags_RenderTargetSurface = 4194304,
    MFVideoFlags_ForceQWORD = 2147483647,
}

struct MFRatio
{
    uint Numerator;
    uint Denominator;
}

struct MFOffset
{
    ushort fract;
    short value;
}

struct MFVideoArea
{
    MFOffset OffsetX;
    MFOffset OffsetY;
    SIZE Area;
}

struct MFVideoInfo
{
    uint dwWidth;
    uint dwHeight;
    MFRatio PixelAspectRatio;
    MFVideoChromaSubsampling SourceChromaSubsampling;
    MFVideoInterlaceMode InterlaceMode;
    MFVideoTransferFunction TransferFunction;
    MFVideoPrimaries ColorPrimaries;
    MFVideoTransferMatrix TransferMatrix;
    MFVideoLighting SourceLighting;
    MFRatio FramesPerSecond;
    MFNominalRange NominalRange;
    MFVideoArea GeometricAperture;
    MFVideoArea MinimumDisplayAperture;
    MFVideoArea PanScanAperture;
    ulong VideoFlags;
}

struct MFAYUVSample
{
    ubyte bCrValue;
    ubyte bCbValue;
    ubyte bYValue;
    ubyte bSampleAlpha8;
}

struct MFARGB
{
    ubyte rgbBlue;
    ubyte rgbGreen;
    ubyte rgbRed;
    ubyte rgbAlpha;
}

struct MFPaletteEntry
{
    MFARGB ARGB;
    MFAYUVSample AYCbCr;
}

struct MFVideoSurfaceInfo
{
    uint Format;
    uint PaletteEntries;
    MFPaletteEntry Palette;
}

struct MFVideoCompressedInfo
{
    long AvgBitrate;
    long AvgBitErrorRate;
    uint MaxKeyFrameSpacing;
}

struct MFVIDEOFORMAT
{
    uint dwSize;
    MFVideoInfo videoInfo;
    Guid guidFormat;
    MFVideoCompressedInfo compressedInfo;
    MFVideoSurfaceInfo surfaceInfo;
}

enum MFStandardVideoFormat
{
    MFStdVideoFormat_reserved = 0,
    MFStdVideoFormat_NTSC = 1,
    MFStdVideoFormat_PAL = 2,
    MFStdVideoFormat_DVD_NTSC = 3,
    MFStdVideoFormat_DVD_PAL = 4,
    MFStdVideoFormat_DV_PAL = 5,
    MFStdVideoFormat_DV_NTSC = 6,
    MFStdVideoFormat_ATSC_SD480i = 7,
    MFStdVideoFormat_ATSC_HD1080i = 8,
    MFStdVideoFormat_ATSC_HD720p = 9,
}

const GUID IID_IMFVideoMediaType = {0xB99F381F, 0xA8F9, 0x47A2, [0xA5, 0xAF, 0xCA, 0x3A, 0x22, 0x5A, 0x38, 0x90]};
@GUID(0xB99F381F, 0xA8F9, 0x47A2, [0xA5, 0xAF, 0xCA, 0x3A, 0x22, 0x5A, 0x38, 0x90]);
interface IMFVideoMediaType : IMFMediaType
{
    MFVIDEOFORMAT* GetVideoFormat();
    HRESULT GetVideoRepresentation(Guid guidRepresentation, void** ppvRepresentation, int lStride);
}

const GUID IID_IMFAsyncResult = {0xAC6B7889, 0x0740, 0x4D51, [0x86, 0x19, 0x90, 0x59, 0x94, 0xA5, 0x5C, 0xC6]};
@GUID(0xAC6B7889, 0x0740, 0x4D51, [0x86, 0x19, 0x90, 0x59, 0x94, 0xA5, 0x5C, 0xC6]);
interface IMFAsyncResult : IUnknown
{
    HRESULT GetState(IUnknown* ppunkState);
    HRESULT GetStatus();
    HRESULT SetStatus(HRESULT hrStatus);
    HRESULT GetObjectA(IUnknown* ppObject);
    IUnknown GetStateNoAddRef();
}

const GUID IID_IMFAsyncCallback = {0xA27003CF, 0x2354, 0x4F2A, [0x8D, 0x6A, 0xAB, 0x7C, 0xFF, 0x15, 0x43, 0x7E]};
@GUID(0xA27003CF, 0x2354, 0x4F2A, [0x8D, 0x6A, 0xAB, 0x7C, 0xFF, 0x15, 0x43, 0x7E]);
interface IMFAsyncCallback : IUnknown
{
    HRESULT GetParameters(uint* pdwFlags, uint* pdwQueue);
    HRESULT Invoke(IMFAsyncResult pAsyncResult);
}

const GUID IID_IMFAsyncCallbackLogging = {0xC7A4DCA1, 0xF5F0, 0x47B6, [0xB9, 0x2B, 0xBF, 0x01, 0x06, 0xD2, 0x57, 0x91]};
@GUID(0xC7A4DCA1, 0xF5F0, 0x47B6, [0xB9, 0x2B, 0xBF, 0x01, 0x06, 0xD2, 0x57, 0x91]);
interface IMFAsyncCallbackLogging : IMFAsyncCallback
{
    void* GetObjectPointer();
    uint GetObjectTag();
}

enum __MIDL___MIDL_itf_mfobjects_0000_0012_0001
{
    MEUnknown = 0,
    MEError = 1,
    MEExtendedType = 2,
    MENonFatalError = 3,
    MEGenericV1Anchor = 3,
    MESessionUnknown = 100,
    MESessionTopologySet = 101,
    MESessionTopologiesCleared = 102,
    MESessionStarted = 103,
    MESessionPaused = 104,
    MESessionStopped = 105,
    MESessionClosed = 106,
    MESessionEnded = 107,
    MESessionRateChanged = 108,
    MESessionScrubSampleComplete = 109,
    MESessionCapabilitiesChanged = 110,
    MESessionTopologyStatus = 111,
    MESessionNotifyPresentationTime = 112,
    MENewPresentation = 113,
    MELicenseAcquisitionStart = 114,
    MELicenseAcquisitionCompleted = 115,
    MEIndividualizationStart = 116,
    MEIndividualizationCompleted = 117,
    MEEnablerProgress = 118,
    MEEnablerCompleted = 119,
    MEPolicyError = 120,
    MEPolicyReport = 121,
    MEBufferingStarted = 122,
    MEBufferingStopped = 123,
    MEConnectStart = 124,
    MEConnectEnd = 125,
    MEReconnectStart = 126,
    MEReconnectEnd = 127,
    MERendererEvent = 128,
    MESessionStreamSinkFormatChanged = 129,
    MESessionV1Anchor = 129,
    MESourceUnknown = 200,
    MESourceStarted = 201,
    MEStreamStarted = 202,
    MESourceSeeked = 203,
    MEStreamSeeked = 204,
    MENewStream = 205,
    MEUpdatedStream = 206,
    MESourceStopped = 207,
    MEStreamStopped = 208,
    MESourcePaused = 209,
    MEStreamPaused = 210,
    MEEndOfPresentation = 211,
    MEEndOfStream = 212,
    MEMediaSample = 213,
    MEStreamTick = 214,
    MEStreamThinMode = 215,
    MEStreamFormatChanged = 216,
    MESourceRateChanged = 217,
    MEEndOfPresentationSegment = 218,
    MESourceCharacteristicsChanged = 219,
    MESourceRateChangeRequested = 220,
    MESourceMetadataChanged = 221,
    MESequencerSourceTopologyUpdated = 222,
    MESourceV1Anchor = 222,
    MESinkUnknown = 300,
    MEStreamSinkStarted = 301,
    MEStreamSinkStopped = 302,
    MEStreamSinkPaused = 303,
    MEStreamSinkRateChanged = 304,
    MEStreamSinkRequestSample = 305,
    MEStreamSinkMarker = 306,
    MEStreamSinkPrerolled = 307,
    MEStreamSinkScrubSampleComplete = 308,
    MEStreamSinkFormatChanged = 309,
    MEStreamSinkDeviceChanged = 310,
    MEQualityNotify = 311,
    MESinkInvalidated = 312,
    MEAudioSessionNameChanged = 313,
    MEAudioSessionVolumeChanged = 314,
    MEAudioSessionDeviceRemoved = 315,
    MEAudioSessionServerShutdown = 316,
    MEAudioSessionGroupingParamChanged = 317,
    MEAudioSessionIconChanged = 318,
    MEAudioSessionFormatChanged = 319,
    MEAudioSessionDisconnected = 320,
    MEAudioSessionExclusiveModeOverride = 321,
    MESinkV1Anchor = 321,
    MECaptureAudioSessionVolumeChanged = 322,
    MECaptureAudioSessionDeviceRemoved = 323,
    MECaptureAudioSessionFormatChanged = 324,
    MECaptureAudioSessionDisconnected = 325,
    MECaptureAudioSessionExclusiveModeOverride = 326,
    MECaptureAudioSessionServerShutdown = 327,
    MESinkV2Anchor = 327,
    METrustUnknown = 400,
    MEPolicyChanged = 401,
    MEContentProtectionMessage = 402,
    MEPolicySet = 403,
    METrustV1Anchor = 403,
    MEWMDRMLicenseBackupCompleted = 500,
    MEWMDRMLicenseBackupProgress = 501,
    MEWMDRMLicenseRestoreCompleted = 502,
    MEWMDRMLicenseRestoreProgress = 503,
    MEWMDRMLicenseAcquisitionCompleted = 506,
    MEWMDRMIndividualizationCompleted = 508,
    MEWMDRMIndividualizationProgress = 513,
    MEWMDRMProximityCompleted = 514,
    MEWMDRMLicenseStoreCleaned = 515,
    MEWMDRMRevocationDownloadCompleted = 516,
    MEWMDRMV1Anchor = 516,
    METransformUnknown = 600,
    METransformNeedInput = 601,
    METransformHaveOutput = 602,
    METransformDrainComplete = 603,
    METransformMarker = 604,
    METransformInputStreamStateChanged = 605,
    MEByteStreamCharacteristicsChanged = 700,
    MEVideoCaptureDeviceRemoved = 800,
    MEVideoCaptureDevicePreempted = 801,
    MEStreamSinkFormatInvalidated = 802,
    MEEncodingParameters = 803,
    MEContentProtectionMetadata = 900,
    MEDeviceThermalStateChanged = 950,
    MEReservedMax = 10000,
}

const GUID IID_IMFMediaEvent = {0xDF598932, 0xF10C, 0x4E39, [0xBB, 0xA2, 0xC3, 0x08, 0xF1, 0x01, 0xDA, 0xA3]};
@GUID(0xDF598932, 0xF10C, 0x4E39, [0xBB, 0xA2, 0xC3, 0x08, 0xF1, 0x01, 0xDA, 0xA3]);
interface IMFMediaEvent : IMFAttributes
{
    HRESULT GetType(uint* pmet);
    HRESULT GetExtendedType(Guid* pguidExtendedType);
    HRESULT GetStatus(int* phrStatus);
    HRESULT GetValue(PROPVARIANT* pvValue);
}

const GUID IID_IMFMediaEventGenerator = {0x2CD0BD52, 0xBCD5, 0x4B89, [0xB6, 0x2C, 0xEA, 0xDC, 0x0C, 0x03, 0x1E, 0x7D]};
@GUID(0x2CD0BD52, 0xBCD5, 0x4B89, [0xB6, 0x2C, 0xEA, 0xDC, 0x0C, 0x03, 0x1E, 0x7D]);
interface IMFMediaEventGenerator : IUnknown
{
    HRESULT GetEvent(uint dwFlags, IMFMediaEvent* ppEvent);
    HRESULT BeginGetEvent(IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndGetEvent(IMFAsyncResult pResult, IMFMediaEvent* ppEvent);
    HRESULT QueueEvent(uint met, const(Guid)* guidExtendedType, HRESULT hrStatus, const(PROPVARIANT)* pvValue);
}

const GUID IID_IMFRemoteAsyncCallback = {0xA27003D0, 0x2354, 0x4F2A, [0x8D, 0x6A, 0xAB, 0x7C, 0xFF, 0x15, 0x43, 0x7E]};
@GUID(0xA27003D0, 0x2354, 0x4F2A, [0x8D, 0x6A, 0xAB, 0x7C, 0xFF, 0x15, 0x43, 0x7E]);
interface IMFRemoteAsyncCallback : IUnknown
{
    HRESULT Invoke(HRESULT hr, IUnknown pRemoteResult);
}

enum MFBYTESTREAM_SEEK_ORIGIN
{
    msoBegin = 0,
    msoCurrent = 1,
}

const GUID IID_IMFByteStream = {0xAD4C1B00, 0x4BF7, 0x422F, [0x91, 0x75, 0x75, 0x66, 0x93, 0xD9, 0x13, 0x0D]};
@GUID(0xAD4C1B00, 0x4BF7, 0x422F, [0x91, 0x75, 0x75, 0x66, 0x93, 0xD9, 0x13, 0x0D]);
interface IMFByteStream : IUnknown
{
    HRESULT GetCapabilities(uint* pdwCapabilities);
    HRESULT GetLength(ulong* pqwLength);
    HRESULT SetLength(ulong qwLength);
    HRESULT GetCurrentPosition(ulong* pqwPosition);
    HRESULT SetCurrentPosition(ulong qwPosition);
    HRESULT IsEndOfStream(int* pfEndOfStream);
    HRESULT Read(char* pb, uint cb, uint* pcbRead);
    HRESULT BeginRead(char* pb, uint cb, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndRead(IMFAsyncResult pResult, uint* pcbRead);
    HRESULT Write(char* pb, uint cb, uint* pcbWritten);
    HRESULT BeginWrite(char* pb, uint cb, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndWrite(IMFAsyncResult pResult, uint* pcbWritten);
    HRESULT Seek(MFBYTESTREAM_SEEK_ORIGIN SeekOrigin, long llSeekOffset, uint dwSeekFlags, ulong* pqwCurrentPosition);
    HRESULT Flush();
    HRESULT Close();
}

const GUID IID_IMFByteStreamProxyClassFactory = {0xA6B43F84, 0x5C0A, 0x42E8, [0xA4, 0x4D, 0xB1, 0x85, 0x7A, 0x76, 0x99, 0x2F]};
@GUID(0xA6B43F84, 0x5C0A, 0x42E8, [0xA4, 0x4D, 0xB1, 0x85, 0x7A, 0x76, 0x99, 0x2F]);
interface IMFByteStreamProxyClassFactory : IUnknown
{
    HRESULT CreateByteStreamProxy(IMFByteStream pByteStream, IMFAttributes pAttributes, const(Guid)* riid, void** ppvObject);
}

enum MF_FILE_ACCESSMODE
{
    MF_ACCESSMODE_READ = 1,
    MF_ACCESSMODE_WRITE = 2,
    MF_ACCESSMODE_READWRITE = 3,
}

enum MF_FILE_OPENMODE
{
    MF_OPENMODE_FAIL_IF_NOT_EXIST = 0,
    MF_OPENMODE_FAIL_IF_EXIST = 1,
    MF_OPENMODE_RESET_IF_EXIST = 2,
    MF_OPENMODE_APPEND_IF_EXIST = 3,
    MF_OPENMODE_DELETE_IF_EXIST = 4,
}

enum MF_FILE_FLAGS
{
    MF_FILEFLAGS_NONE = 0,
    MF_FILEFLAGS_NOBUFFERING = 1,
    MF_FILEFLAGS_ALLOW_WRITE_SHARING = 2,
}

const GUID IID_IMFSampleOutputStream = {0x8FEED468, 0x6F7E, 0x440D, [0x86, 0x9A, 0x49, 0xBD, 0xD2, 0x83, 0xAD, 0x0D]};
@GUID(0x8FEED468, 0x6F7E, 0x440D, [0x86, 0x9A, 0x49, 0xBD, 0xD2, 0x83, 0xAD, 0x0D]);
interface IMFSampleOutputStream : IUnknown
{
    HRESULT BeginWriteSample(IMFSample pSample, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndWriteSample(IMFAsyncResult pResult);
    HRESULT Close();
}

const GUID IID_IMFCollection = {0x5BC8A76B, 0x869A, 0x46A3, [0x9B, 0x03, 0xFA, 0x21, 0x8A, 0x66, 0xAE, 0xBE]};
@GUID(0x5BC8A76B, 0x869A, 0x46A3, [0x9B, 0x03, 0xFA, 0x21, 0x8A, 0x66, 0xAE, 0xBE]);
interface IMFCollection : IUnknown
{
    HRESULT GetElementCount(uint* pcElements);
    HRESULT GetElement(uint dwElementIndex, IUnknown* ppUnkElement);
    HRESULT AddElement(IUnknown pUnkElement);
    HRESULT RemoveElement(uint dwElementIndex, IUnknown* ppUnkElement);
    HRESULT InsertElementAt(uint dwIndex, IUnknown pUnknown);
    HRESULT RemoveAllElements();
}

const GUID IID_IMFMediaEventQueue = {0x36F846FC, 0x2256, 0x48B6, [0xB5, 0x8E, 0xE2, 0xB6, 0x38, 0x31, 0x65, 0x81]};
@GUID(0x36F846FC, 0x2256, 0x48B6, [0xB5, 0x8E, 0xE2, 0xB6, 0x38, 0x31, 0x65, 0x81]);
interface IMFMediaEventQueue : IUnknown
{
    HRESULT GetEvent(uint dwFlags, IMFMediaEvent* ppEvent);
    HRESULT BeginGetEvent(IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndGetEvent(IMFAsyncResult pResult, IMFMediaEvent* ppEvent);
    HRESULT QueueEvent(IMFMediaEvent pEvent);
    HRESULT QueueEventParamVar(uint met, const(Guid)* guidExtendedType, HRESULT hrStatus, const(PROPVARIANT)* pvValue);
    HRESULT QueueEventParamUnk(uint met, const(Guid)* guidExtendedType, HRESULT hrStatus, IUnknown pUnk);
    HRESULT Shutdown();
}

const GUID IID_IMFActivate = {0x7FEE9E9A, 0x4A89, 0x47A6, [0x89, 0x9C, 0xB6, 0xA5, 0x3A, 0x70, 0xFB, 0x67]};
@GUID(0x7FEE9E9A, 0x4A89, 0x47A6, [0x89, 0x9C, 0xB6, 0xA5, 0x3A, 0x70, 0xFB, 0x67]);
interface IMFActivate : IMFAttributes
{
    HRESULT ActivateObject(const(Guid)* riid, void** ppv);
    HRESULT ShutdownObject();
    HRESULT DetachObject();
}

const GUID IID_IMFPluginControl = {0x5C6C44BF, 0x1DB6, 0x435B, [0x92, 0x49, 0xE8, 0xCD, 0x10, 0xFD, 0xEC, 0x96]};
@GUID(0x5C6C44BF, 0x1DB6, 0x435B, [0x92, 0x49, 0xE8, 0xCD, 0x10, 0xFD, 0xEC, 0x96]);
interface IMFPluginControl : IUnknown
{
    HRESULT GetPreferredClsid(uint pluginType, const(wchar)* selector, Guid* clsid);
    HRESULT GetPreferredClsidByIndex(uint pluginType, uint index, ushort** selector, Guid* clsid);
    HRESULT SetPreferredClsid(uint pluginType, const(wchar)* selector, const(Guid)* clsid);
    HRESULT IsDisabled(uint pluginType, const(Guid)* clsid);
    HRESULT GetDisabledByIndex(uint pluginType, uint index, Guid* clsid);
    HRESULT SetDisabled(uint pluginType, const(Guid)* clsid, BOOL disabled);
}

enum MF_PLUGIN_CONTROL_POLICY
{
    MF_PLUGIN_CONTROL_POLICY_USE_ALL_PLUGINS = 0,
    MF_PLUGIN_CONTROL_POLICY_USE_APPROVED_PLUGINS = 1,
    MF_PLUGIN_CONTROL_POLICY_USE_WEB_PLUGINS = 2,
    MF_PLUGIN_CONTROL_POLICY_USE_WEB_PLUGINS_EDGEMODE = 3,
}

const GUID IID_IMFPluginControl2 = {0xC6982083, 0x3DDC, 0x45CB, [0xAF, 0x5E, 0x0F, 0x7A, 0x8C, 0xE4, 0xDE, 0x77]};
@GUID(0xC6982083, 0x3DDC, 0x45CB, [0xAF, 0x5E, 0x0F, 0x7A, 0x8C, 0xE4, 0xDE, 0x77]);
interface IMFPluginControl2 : IMFPluginControl
{
    HRESULT SetPolicy(MF_PLUGIN_CONTROL_POLICY policy);
}

const GUID IID_IMFDXGIDeviceManager = {0xEB533D5D, 0x2DB6, 0x40F8, [0x97, 0xA9, 0x49, 0x46, 0x92, 0x01, 0x4F, 0x07]};
@GUID(0xEB533D5D, 0x2DB6, 0x40F8, [0x97, 0xA9, 0x49, 0x46, 0x92, 0x01, 0x4F, 0x07]);
interface IMFDXGIDeviceManager : IUnknown
{
    HRESULT CloseDeviceHandle(HANDLE hDevice);
    HRESULT GetVideoService(HANDLE hDevice, const(Guid)* riid, void** ppService);
    HRESULT LockDevice(HANDLE hDevice, const(Guid)* riid, void** ppUnkDevice, BOOL fBlock);
    HRESULT OpenDeviceHandle(HANDLE* phDevice);
    HRESULT ResetDevice(IUnknown pUnkDevice, uint resetToken);
    HRESULT TestDevice(HANDLE hDevice);
    HRESULT UnlockDevice(HANDLE hDevice, BOOL fSaveState);
}

enum MF_STREAM_STATE
{
    MF_STREAM_STATE_STOPPED = 0,
    MF_STREAM_STATE_PAUSED = 1,
    MF_STREAM_STATE_RUNNING = 2,
}

const GUID IID_IMFMuxStreamAttributesManager = {0xCE8BD576, 0xE440, 0x43B3, [0xBE, 0x34, 0x1E, 0x53, 0xF5, 0x65, 0xF7, 0xE8]};
@GUID(0xCE8BD576, 0xE440, 0x43B3, [0xBE, 0x34, 0x1E, 0x53, 0xF5, 0x65, 0xF7, 0xE8]);
interface IMFMuxStreamAttributesManager : IUnknown
{
    HRESULT GetStreamCount(uint* pdwMuxStreamCount);
    HRESULT GetAttributes(uint dwMuxStreamIndex, IMFAttributes* ppStreamAttributes);
}

const GUID IID_IMFMuxStreamMediaTypeManager = {0x505A2C72, 0x42F7, 0x4690, [0xAE, 0xAB, 0x8F, 0x51, 0x3D, 0x0F, 0xFD, 0xB8]};
@GUID(0x505A2C72, 0x42F7, 0x4690, [0xAE, 0xAB, 0x8F, 0x51, 0x3D, 0x0F, 0xFD, 0xB8]);
interface IMFMuxStreamMediaTypeManager : IUnknown
{
    HRESULT GetStreamCount(uint* pdwMuxStreamCount);
    HRESULT GetMediaType(uint dwMuxStreamIndex, IMFMediaType* ppMediaType);
    HRESULT GetStreamConfigurationCount(uint* pdwCount);
    HRESULT AddStreamConfiguration(ulong ullStreamMask);
    HRESULT RemoveStreamConfiguration(ulong ullStreamMask);
    HRESULT GetStreamConfiguration(uint ulIndex, ulong* pullStreamMask);
}

const GUID IID_IMFMuxStreamSampleManager = {0x74ABBC19, 0xB1CC, 0x4E41, [0xBB, 0x8B, 0x9D, 0x9B, 0x86, 0xA8, 0xF6, 0xCA]};
@GUID(0x74ABBC19, 0xB1CC, 0x4E41, [0xBB, 0x8B, 0x9D, 0x9B, 0x86, 0xA8, 0xF6, 0xCA]);
interface IMFMuxStreamSampleManager : IUnknown
{
    HRESULT GetStreamCount(uint* pdwMuxStreamCount);
    HRESULT GetSample(uint dwMuxStreamIndex, IMFSample* ppSample);
    ulong GetStreamConfiguration();
}

const GUID IID_IMFSecureBuffer = {0xC1209904, 0xE584, 0x4752, [0xA2, 0xD6, 0x7F, 0x21, 0x69, 0x3F, 0x8B, 0x21]};
@GUID(0xC1209904, 0xE584, 0x4752, [0xA2, 0xD6, 0x7F, 0x21, 0x69, 0x3F, 0x8B, 0x21]);
interface IMFSecureBuffer : IUnknown
{
    HRESULT GetIdentifier(Guid* pGuidIdentifier);
}

enum _MFT_INPUT_DATA_BUFFER_FLAGS
{
    MFT_INPUT_DATA_BUFFER_PLACEHOLDER = -1,
}

enum _MFT_OUTPUT_DATA_BUFFER_FLAGS
{
    MFT_OUTPUT_DATA_BUFFER_INCOMPLETE = 16777216,
    MFT_OUTPUT_DATA_BUFFER_FORMAT_CHANGE = 256,
    MFT_OUTPUT_DATA_BUFFER_STREAM_END = 512,
    MFT_OUTPUT_DATA_BUFFER_NO_SAMPLE = 768,
}

enum _MFT_INPUT_STATUS_FLAGS
{
    MFT_INPUT_STATUS_ACCEPT_DATA = 1,
}

enum _MFT_OUTPUT_STATUS_FLAGS
{
    MFT_OUTPUT_STATUS_SAMPLE_READY = 1,
}

enum _MFT_INPUT_STREAM_INFO_FLAGS
{
    MFT_INPUT_STREAM_WHOLE_SAMPLES = 1,
    MFT_INPUT_STREAM_SINGLE_SAMPLE_PER_BUFFER = 2,
    MFT_INPUT_STREAM_FIXED_SAMPLE_SIZE = 4,
    MFT_INPUT_STREAM_HOLDS_BUFFERS = 8,
    MFT_INPUT_STREAM_DOES_NOT_ADDREF = 256,
    MFT_INPUT_STREAM_REMOVABLE = 512,
    MFT_INPUT_STREAM_OPTIONAL = 1024,
    MFT_INPUT_STREAM_PROCESSES_IN_PLACE = 2048,
}

enum _MFT_OUTPUT_STREAM_INFO_FLAGS
{
    MFT_OUTPUT_STREAM_WHOLE_SAMPLES = 1,
    MFT_OUTPUT_STREAM_SINGLE_SAMPLE_PER_BUFFER = 2,
    MFT_OUTPUT_STREAM_FIXED_SAMPLE_SIZE = 4,
    MFT_OUTPUT_STREAM_DISCARDABLE = 8,
    MFT_OUTPUT_STREAM_OPTIONAL = 16,
    MFT_OUTPUT_STREAM_PROVIDES_SAMPLES = 256,
    MFT_OUTPUT_STREAM_CAN_PROVIDE_SAMPLES = 512,
    MFT_OUTPUT_STREAM_LAZY_READ = 1024,
    MFT_OUTPUT_STREAM_REMOVABLE = 2048,
}

enum _MFT_SET_TYPE_FLAGS
{
    MFT_SET_TYPE_TEST_ONLY = 1,
}

enum _MFT_PROCESS_OUTPUT_FLAGS
{
    MFT_PROCESS_OUTPUT_DISCARD_WHEN_NO_BUFFER = 1,
    MFT_PROCESS_OUTPUT_REGENERATE_LAST_OUTPUT = 2,
}

enum _MFT_PROCESS_OUTPUT_STATUS
{
    MFT_PROCESS_OUTPUT_STATUS_NEW_STREAMS = 256,
}

enum MFT_DRAIN_TYPE
{
    MFT_DRAIN_PRODUCE_TAILS = 0,
    MFT_DRAIN_NO_TAILS = 1,
}

enum MFT_MESSAGE_TYPE
{
    MFT_MESSAGE_COMMAND_FLUSH = 0,
    MFT_MESSAGE_COMMAND_DRAIN = 1,
    MFT_MESSAGE_SET_D3D_MANAGER = 2,
    MFT_MESSAGE_DROP_SAMPLES = 3,
    MFT_MESSAGE_COMMAND_TICK = 4,
    MFT_MESSAGE_NOTIFY_BEGIN_STREAMING = 268435456,
    MFT_MESSAGE_NOTIFY_END_STREAMING = 268435457,
    MFT_MESSAGE_NOTIFY_END_OF_STREAM = 268435458,
    MFT_MESSAGE_NOTIFY_START_OF_STREAM = 268435459,
    MFT_MESSAGE_NOTIFY_RELEASE_RESOURCES = 268435460,
    MFT_MESSAGE_NOTIFY_REACQUIRE_RESOURCES = 268435461,
    MFT_MESSAGE_NOTIFY_EVENT = 268435462,
    MFT_MESSAGE_COMMAND_SET_OUTPUT_STREAM_STATE = 268435463,
    MFT_MESSAGE_COMMAND_FLUSH_OUTPUT_STREAM = 268435464,
    MFT_MESSAGE_COMMAND_MARKER = 536870912,
}

struct MFT_INPUT_STREAM_INFO
{
    long hnsMaxLatency;
    uint dwFlags;
    uint cbSize;
    uint cbMaxLookahead;
    uint cbAlignment;
}

struct MFT_OUTPUT_STREAM_INFO
{
    uint dwFlags;
    uint cbSize;
    uint cbAlignment;
}

struct MFT_OUTPUT_DATA_BUFFER
{
    uint dwStreamID;
    IMFSample pSample;
    uint dwStatus;
    IMFCollection pEvents;
}

const GUID IID_IMFTransform = {0xBF94C121, 0x5B05, 0x4E6F, [0x80, 0x00, 0xBA, 0x59, 0x89, 0x61, 0x41, 0x4D]};
@GUID(0xBF94C121, 0x5B05, 0x4E6F, [0x80, 0x00, 0xBA, 0x59, 0x89, 0x61, 0x41, 0x4D]);
interface IMFTransform : IUnknown
{
    HRESULT GetStreamLimits(uint* pdwInputMinimum, uint* pdwInputMaximum, uint* pdwOutputMinimum, uint* pdwOutputMaximum);
    HRESULT GetStreamCount(uint* pcInputStreams, uint* pcOutputStreams);
    HRESULT GetStreamIDs(uint dwInputIDArraySize, char* pdwInputIDs, uint dwOutputIDArraySize, char* pdwOutputIDs);
    HRESULT GetInputStreamInfo(uint dwInputStreamID, MFT_INPUT_STREAM_INFO* pStreamInfo);
    HRESULT GetOutputStreamInfo(uint dwOutputStreamID, MFT_OUTPUT_STREAM_INFO* pStreamInfo);
    HRESULT GetAttributes(IMFAttributes* pAttributes);
    HRESULT GetInputStreamAttributes(uint dwInputStreamID, IMFAttributes* pAttributes);
    HRESULT GetOutputStreamAttributes(uint dwOutputStreamID, IMFAttributes* pAttributes);
    HRESULT DeleteInputStream(uint dwStreamID);
    HRESULT AddInputStreams(uint cStreams, uint* adwStreamIDs);
    HRESULT GetInputAvailableType(uint dwInputStreamID, uint dwTypeIndex, IMFMediaType* ppType);
    HRESULT GetOutputAvailableType(uint dwOutputStreamID, uint dwTypeIndex, IMFMediaType* ppType);
    HRESULT SetInputType(uint dwInputStreamID, IMFMediaType pType, uint dwFlags);
    HRESULT SetOutputType(uint dwOutputStreamID, IMFMediaType pType, uint dwFlags);
    HRESULT GetInputCurrentType(uint dwInputStreamID, IMFMediaType* ppType);
    HRESULT GetOutputCurrentType(uint dwOutputStreamID, IMFMediaType* ppType);
    HRESULT GetInputStatus(uint dwInputStreamID, uint* pdwFlags);
    HRESULT GetOutputStatus(uint* pdwFlags);
    HRESULT SetOutputBounds(long hnsLowerBound, long hnsUpperBound);
    HRESULT ProcessEvent(uint dwInputStreamID, IMFMediaEvent pEvent);
    HRESULT ProcessMessage(MFT_MESSAGE_TYPE eMessage, uint ulParam);
    HRESULT ProcessInput(uint dwInputStreamID, IMFSample pSample, uint dwFlags);
    HRESULT ProcessOutput(uint dwFlags, uint cOutputBufferCount, MFT_OUTPUT_DATA_BUFFER* pOutputSamples, uint* pdwStatus);
}

enum DeviceStreamState
{
    DeviceStreamState_Stop = 0,
    DeviceStreamState_Pause = 1,
    DeviceStreamState_Run = 2,
    DeviceStreamState_Disabled = 3,
}

struct STREAM_MEDIUM
{
    Guid gidMedium;
    uint unMediumInstance;
}

enum MF3DVideoOutputType
{
    MF3DVideoOutputType_BaseView = 0,
    MF3DVideoOutputType_Stereo = 1,
}

enum MFT_AUDIO_DECODER_DEGRADATION_REASON
{
    MFT_AUDIO_DECODER_DEGRADATION_REASON_NONE = 0,
    MFT_AUDIO_DECODER_DEGRADATION_REASON_LICENSING_REQUIREMENT = 1,
}

enum MFT_AUDIO_DECODER_DEGRADATION_TYPE
{
    MFT_AUDIO_DECODER_DEGRADATION_TYPE_NONE = 0,
    MFT_AUDIO_DECODER_DEGRADATION_TYPE_DOWNMIX2CHANNEL = 1,
    MFT_AUDIO_DECODER_DEGRADATION_TYPE_DOWNMIX6CHANNEL = 2,
    MFT_AUDIO_DECODER_DEGRADATION_TYPE_DOWNMIX8CHANNEL = 3,
}

struct MFAudioDecoderDegradationInfo
{
    MFT_AUDIO_DECODER_DEGRADATION_REASON eDegradationReason;
    MFT_AUDIO_DECODER_DEGRADATION_TYPE eType;
}

struct MFT_STREAM_STATE_PARAM
{
    uint StreamId;
    MF_STREAM_STATE State;
}

enum MFSESSION_SETTOPOLOGY_FLAGS
{
    MFSESSION_SETTOPOLOGY_IMMEDIATE = 1,
    MFSESSION_SETTOPOLOGY_NORESOLUTION = 2,
    MFSESSION_SETTOPOLOGY_CLEAR_CURRENT = 4,
}

enum MFSESSION_GETFULLTOPOLOGY_FLAGS
{
    MFSESSION_GETFULLTOPOLOGY_CURRENT = 1,
}

enum MFPMPSESSION_CREATION_FLAGS
{
    MFPMPSESSION_UNPROTECTED_PROCESS = 1,
    MFPMPSESSION_IN_PROCESS = 2,
}

const GUID IID_IMFMediaSession = {0x90377834, 0x21D0, 0x4DEE, [0x82, 0x14, 0xBA, 0x2E, 0x3E, 0x6C, 0x11, 0x27]};
@GUID(0x90377834, 0x21D0, 0x4DEE, [0x82, 0x14, 0xBA, 0x2E, 0x3E, 0x6C, 0x11, 0x27]);
interface IMFMediaSession : IMFMediaEventGenerator
{
    HRESULT SetTopology(uint dwSetTopologyFlags, IMFTopology pTopology);
    HRESULT ClearTopologies();
    HRESULT Start(const(Guid)* pguidTimeFormat, const(PROPVARIANT)* pvarStartPosition);
    HRESULT Pause();
    HRESULT Stop();
    HRESULT Close();
    HRESULT Shutdown();
    HRESULT GetClock(IMFClock* ppClock);
    HRESULT GetSessionCapabilities(uint* pdwCaps);
    HRESULT GetFullTopology(uint dwGetFullTopologyFlags, ulong TopoId, IMFTopology* ppFullTopology);
}

enum MF_OBJECT_TYPE
{
    MF_OBJECT_MEDIASOURCE = 0,
    MF_OBJECT_BYTESTREAM = 1,
    MF_OBJECT_INVALID = 2,
}

enum __MIDL___MIDL_itf_mfidl_0000_0001_0001
{
    MF_RESOLUTION_MEDIASOURCE = 1,
    MF_RESOLUTION_BYTESTREAM = 2,
    MF_RESOLUTION_CONTENT_DOES_NOT_HAVE_TO_MATCH_EXTENSION_OR_MIME_TYPE = 16,
    MF_RESOLUTION_KEEP_BYTE_STREAM_ALIVE_ON_FAIL = 32,
    MF_RESOLUTION_DISABLE_LOCAL_PLUGINS = 64,
    MF_RESOLUTION_PLUGIN_CONTROL_POLICY_APPROVED_ONLY = 128,
    MF_RESOLUTION_PLUGIN_CONTROL_POLICY_WEB_ONLY = 256,
    MF_RESOLUTION_PLUGIN_CONTROL_POLICY_WEB_ONLY_EDGEMODE = 512,
    MF_RESOLUTION_ENABLE_STORE_PLUGINS = 1024,
    MF_RESOLUTION_READ = 65536,
    MF_RESOLUTION_WRITE = 131072,
}

enum MF_CONNECT_METHOD
{
    MF_CONNECT_DIRECT = 0,
    MF_CONNECT_ALLOW_CONVERTER = 1,
    MF_CONNECT_ALLOW_DECODER = 3,
    MF_CONNECT_RESOLVE_INDEPENDENT_OUTPUTTYPES = 4,
    MF_CONNECT_AS_OPTIONAL = 65536,
    MF_CONNECT_AS_OPTIONAL_BRANCH = 131072,
}

enum MF_TOPOLOGY_RESOLUTION_STATUS_FLAGS
{
    MF_TOPOLOGY_RESOLUTION_SUCCEEDED = 0,
    MF_OPTIONAL_NODE_REJECTED_MEDIA_TYPE = 1,
    MF_OPTIONAL_NODE_REJECTED_PROTECTED_PROCESS = 2,
}

const GUID IID_IMFSourceResolver = {0xFBE5A32D, 0xA497, 0x4B61, [0xBB, 0x85, 0x97, 0xB1, 0xA8, 0x48, 0xA6, 0xE3]};
@GUID(0xFBE5A32D, 0xA497, 0x4B61, [0xBB, 0x85, 0x97, 0xB1, 0xA8, 0x48, 0xA6, 0xE3]);
interface IMFSourceResolver : IUnknown
{
    HRESULT CreateObjectFromURL(const(wchar)* pwszURL, uint dwFlags, IPropertyStore pProps, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT CreateObjectFromByteStream(IMFByteStream pByteStream, const(wchar)* pwszURL, uint dwFlags, IPropertyStore pProps, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT BeginCreateObjectFromURL(const(wchar)* pwszURL, uint dwFlags, IPropertyStore pProps, IUnknown* ppIUnknownCancelCookie, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndCreateObjectFromURL(IMFAsyncResult pResult, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT BeginCreateObjectFromByteStream(IMFByteStream pByteStream, const(wchar)* pwszURL, uint dwFlags, IPropertyStore pProps, IUnknown* ppIUnknownCancelCookie, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndCreateObjectFromByteStream(IMFAsyncResult pResult, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT CancelObjectCreation(IUnknown pIUnknownCancelCookie);
}

enum MFMEDIASOURCE_CHARACTERISTICS
{
    MFMEDIASOURCE_IS_LIVE = 1,
    MFMEDIASOURCE_CAN_SEEK = 2,
    MFMEDIASOURCE_CAN_PAUSE = 4,
    MFMEDIASOURCE_HAS_SLOW_SEEK = 8,
    MFMEDIASOURCE_HAS_MULTIPLE_PRESENTATIONS = 16,
    MFMEDIASOURCE_CAN_SKIPFORWARD = 32,
    MFMEDIASOURCE_CAN_SKIPBACKWARD = 64,
    MFMEDIASOURCE_DOES_NOT_USE_NETWORK = 128,
}

const GUID IID_IMFMediaSource = {0x279A808D, 0xAEC7, 0x40C8, [0x9C, 0x6B, 0xA6, 0xB4, 0x92, 0xC7, 0x8A, 0x66]};
@GUID(0x279A808D, 0xAEC7, 0x40C8, [0x9C, 0x6B, 0xA6, 0xB4, 0x92, 0xC7, 0x8A, 0x66]);
interface IMFMediaSource : IMFMediaEventGenerator
{
    HRESULT GetCharacteristics(uint* pdwCharacteristics);
    HRESULT CreatePresentationDescriptor(IMFPresentationDescriptor* ppPresentationDescriptor);
    HRESULT Start(IMFPresentationDescriptor pPresentationDescriptor, const(Guid)* pguidTimeFormat, const(PROPVARIANT)* pvarStartPosition);
    HRESULT Stop();
    HRESULT Pause();
    HRESULT Shutdown();
}

const GUID IID_IMFMediaSourceEx = {0x3C9B2EB9, 0x86D5, 0x4514, [0xA3, 0x94, 0xF5, 0x66, 0x64, 0xF9, 0xF0, 0xD8]};
@GUID(0x3C9B2EB9, 0x86D5, 0x4514, [0xA3, 0x94, 0xF5, 0x66, 0x64, 0xF9, 0xF0, 0xD8]);
interface IMFMediaSourceEx : IMFMediaSource
{
    HRESULT GetSourceAttributes(IMFAttributes* ppAttributes);
    HRESULT GetStreamAttributes(uint dwStreamIdentifier, IMFAttributes* ppAttributes);
    HRESULT SetD3DManager(IUnknown pManager);
}

const GUID IID_IMFClockConsumer = {0x6EF2A662, 0x47C0, 0x4666, [0xB1, 0x3D, 0xCB, 0xB7, 0x17, 0xF2, 0xFA, 0x2C]};
@GUID(0x6EF2A662, 0x47C0, 0x4666, [0xB1, 0x3D, 0xCB, 0xB7, 0x17, 0xF2, 0xFA, 0x2C]);
interface IMFClockConsumer : IUnknown
{
    HRESULT SetPresentationClock(IMFPresentationClock pPresentationClock);
    HRESULT GetPresentationClock(IMFPresentationClock* ppPresentationClock);
}

const GUID IID_IMFMediaStream = {0xD182108F, 0x4EC6, 0x443F, [0xAA, 0x42, 0xA7, 0x11, 0x06, 0xEC, 0x82, 0x5F]};
@GUID(0xD182108F, 0x4EC6, 0x443F, [0xAA, 0x42, 0xA7, 0x11, 0x06, 0xEC, 0x82, 0x5F]);
interface IMFMediaStream : IMFMediaEventGenerator
{
    HRESULT GetMediaSource(IMFMediaSource* ppMediaSource);
    HRESULT GetStreamDescriptor(IMFStreamDescriptor* ppStreamDescriptor);
    HRESULT RequestSample(IUnknown pToken);
}

const GUID IID_IMFMediaSink = {0x6EF2A660, 0x47C0, 0x4666, [0xB1, 0x3D, 0xCB, 0xB7, 0x17, 0xF2, 0xFA, 0x2C]};
@GUID(0x6EF2A660, 0x47C0, 0x4666, [0xB1, 0x3D, 0xCB, 0xB7, 0x17, 0xF2, 0xFA, 0x2C]);
interface IMFMediaSink : IUnknown
{
    HRESULT GetCharacteristics(uint* pdwCharacteristics);
    HRESULT AddStreamSink(uint dwStreamSinkIdentifier, IMFMediaType pMediaType, IMFStreamSink* ppStreamSink);
    HRESULT RemoveStreamSink(uint dwStreamSinkIdentifier);
    HRESULT GetStreamSinkCount(uint* pcStreamSinkCount);
    HRESULT GetStreamSinkByIndex(uint dwIndex, IMFStreamSink* ppStreamSink);
    HRESULT GetStreamSinkById(uint dwStreamSinkIdentifier, IMFStreamSink* ppStreamSink);
    HRESULT SetPresentationClock(IMFPresentationClock pPresentationClock);
    HRESULT GetPresentationClock(IMFPresentationClock* ppPresentationClock);
    HRESULT Shutdown();
}

enum MFSTREAMSINK_MARKER_TYPE
{
    MFSTREAMSINK_MARKER_DEFAULT = 0,
    MFSTREAMSINK_MARKER_ENDOFSEGMENT = 1,
    MFSTREAMSINK_MARKER_TICK = 2,
    MFSTREAMSINK_MARKER_EVENT = 3,
}

const GUID IID_IMFStreamSink = {0x0A97B3CF, 0x8E7C, 0x4A3D, [0x8F, 0x8C, 0x0C, 0x84, 0x3D, 0xC2, 0x47, 0xFB]};
@GUID(0x0A97B3CF, 0x8E7C, 0x4A3D, [0x8F, 0x8C, 0x0C, 0x84, 0x3D, 0xC2, 0x47, 0xFB]);
interface IMFStreamSink : IMFMediaEventGenerator
{
    HRESULT GetMediaSink(IMFMediaSink* ppMediaSink);
    HRESULT GetIdentifier(uint* pdwIdentifier);
    HRESULT GetMediaTypeHandler(IMFMediaTypeHandler* ppHandler);
    HRESULT ProcessSample(IMFSample pSample);
    HRESULT PlaceMarker(MFSTREAMSINK_MARKER_TYPE eMarkerType, const(PROPVARIANT)* pvarMarkerValue, const(PROPVARIANT)* pvarContextValue);
    HRESULT Flush();
}

const GUID IID_IMFVideoSampleAllocator = {0x86CBC910, 0xE533, 0x4751, [0x8E, 0x3B, 0xF1, 0x9B, 0x5B, 0x80, 0x6A, 0x03]};
@GUID(0x86CBC910, 0xE533, 0x4751, [0x8E, 0x3B, 0xF1, 0x9B, 0x5B, 0x80, 0x6A, 0x03]);
interface IMFVideoSampleAllocator : IUnknown
{
    HRESULT SetDirectXManager(IUnknown pManager);
    HRESULT UninitializeSampleAllocator();
    HRESULT InitializeSampleAllocator(uint cRequestedFrames, IMFMediaType pMediaType);
    HRESULT AllocateSample(IMFSample* ppSample);
}

const GUID IID_IMFVideoSampleAllocatorNotify = {0xA792CDBE, 0xC374, 0x4E89, [0x83, 0x35, 0x27, 0x8E, 0x7B, 0x99, 0x56, 0xA4]};
@GUID(0xA792CDBE, 0xC374, 0x4E89, [0x83, 0x35, 0x27, 0x8E, 0x7B, 0x99, 0x56, 0xA4]);
interface IMFVideoSampleAllocatorNotify : IUnknown
{
    HRESULT NotifyRelease();
}

const GUID IID_IMFVideoSampleAllocatorNotifyEx = {0x3978AA1A, 0x6D5B, 0x4B7F, [0xA3, 0x40, 0x90, 0x89, 0x91, 0x89, 0xAE, 0x34]};
@GUID(0x3978AA1A, 0x6D5B, 0x4B7F, [0xA3, 0x40, 0x90, 0x89, 0x91, 0x89, 0xAE, 0x34]);
interface IMFVideoSampleAllocatorNotifyEx : IMFVideoSampleAllocatorNotify
{
    HRESULT NotifyPrune(IMFSample __MIDL__IMFVideoSampleAllocatorNotifyEx0000);
}

const GUID IID_IMFVideoSampleAllocatorCallback = {0x992388B4, 0x3372, 0x4F67, [0x8B, 0x6F, 0xC8, 0x4C, 0x07, 0x1F, 0x47, 0x51]};
@GUID(0x992388B4, 0x3372, 0x4F67, [0x8B, 0x6F, 0xC8, 0x4C, 0x07, 0x1F, 0x47, 0x51]);
interface IMFVideoSampleAllocatorCallback : IUnknown
{
    HRESULT SetCallback(IMFVideoSampleAllocatorNotify pNotify);
    HRESULT GetFreeSampleCount(int* plSamples);
}

const GUID IID_IMFVideoSampleAllocatorEx = {0x545B3A48, 0x3283, 0x4F62, [0x86, 0x6F, 0xA6, 0x2D, 0x8F, 0x59, 0x8F, 0x9F]};
@GUID(0x545B3A48, 0x3283, 0x4F62, [0x86, 0x6F, 0xA6, 0x2D, 0x8F, 0x59, 0x8F, 0x9F]);
interface IMFVideoSampleAllocatorEx : IMFVideoSampleAllocator
{
    HRESULT InitializeSampleAllocatorEx(uint cInitialSamples, uint cMaximumSamples, IMFAttributes pAttributes, IMFMediaType pMediaType);
}

const GUID IID_IMFDXGIDeviceManagerSource = {0x20BC074B, 0x7A8D, 0x4609, [0x8C, 0x3B, 0x64, 0xA0, 0xA3, 0xB5, 0xD7, 0xCE]};
@GUID(0x20BC074B, 0x7A8D, 0x4609, [0x8C, 0x3B, 0x64, 0xA0, 0xA3, 0xB5, 0xD7, 0xCE]);
interface IMFDXGIDeviceManagerSource : IUnknown
{
    HRESULT GetManager(IMFDXGIDeviceManager* ppManager);
}

enum MF_VIDEO_PROCESSOR_ROTATION
{
    ROTATION_NONE = 0,
    ROTATION_NORMAL = 1,
}

enum MF_VIDEO_PROCESSOR_MIRROR
{
    MIRROR_NONE = 0,
    MIRROR_HORIZONTAL = 1,
    MIRROR_VERTICAL = 2,
}

const GUID IID_IMFVideoProcessorControl = {0xA3F675D5, 0x6119, 0x4F7F, [0xA1, 0x00, 0x1D, 0x8B, 0x28, 0x0F, 0x0E, 0xFB]};
@GUID(0xA3F675D5, 0x6119, 0x4F7F, [0xA1, 0x00, 0x1D, 0x8B, 0x28, 0x0F, 0x0E, 0xFB]);
interface IMFVideoProcessorControl : IUnknown
{
    HRESULT SetBorderColor(MFARGB* pBorderColor);
    HRESULT SetSourceRectangle(RECT* pSrcRect);
    HRESULT SetDestinationRectangle(RECT* pDstRect);
    HRESULT SetMirror(MF_VIDEO_PROCESSOR_MIRROR eMirror);
    HRESULT SetRotation(MF_VIDEO_PROCESSOR_ROTATION eRotation);
    HRESULT SetConstrictionSize(SIZE* pConstrictionSize);
}

const GUID IID_IMFVideoProcessorControl2 = {0xBDE633D3, 0xE1DC, 0x4A7F, [0xA6, 0x93, 0xBB, 0xAE, 0x39, 0x9C, 0x4A, 0x20]};
@GUID(0xBDE633D3, 0xE1DC, 0x4A7F, [0xA6, 0x93, 0xBB, 0xAE, 0x39, 0x9C, 0x4A, 0x20]);
interface IMFVideoProcessorControl2 : IMFVideoProcessorControl
{
    HRESULT SetRotationOverride(uint uiRotation);
    HRESULT EnableHardwareEffects(BOOL fEnabled);
    HRESULT GetSupportedHardwareEffects(uint* puiSupport);
}

enum MFVideoSphericalFormat
{
    MFVideoSphericalFormat_Unsupported = 0,
    MFVideoSphericalFormat_Equirectangular = 1,
    MFVideoSphericalFormat_CubeMap = 2,
    MFVideoSphericalFormat_3DMesh = 3,
}

enum MFVideoSphericalProjectionMode
{
    MFVideoSphericalProjectionMode_Spherical = 0,
    MFVideoSphericalProjectionMode_Flat = 1,
}

const GUID IID_IMFVideoProcessorControl3 = {0x2424B3F2, 0xEB23, 0x40F1, [0x91, 0xAA, 0x74, 0xBD, 0xDE, 0xEA, 0x08, 0x83]};
@GUID(0x2424B3F2, 0xEB23, 0x40F1, [0x91, 0xAA, 0x74, 0xBD, 0xDE, 0xEA, 0x08, 0x83]);
interface IMFVideoProcessorControl3 : IMFVideoProcessorControl2
{
    HRESULT GetNaturalOutputType(IMFMediaType* ppType);
    HRESULT EnableSphericalVideoProcessing(BOOL fEnable, MFVideoSphericalFormat eFormat, MFVideoSphericalProjectionMode eProjectionMode);
    HRESULT SetSphericalVideoProperties(float X, float Y, float Z, float W, float fieldOfView);
    HRESULT SetOutputDevice(IUnknown pOutputDevice);
}

const GUID IID_IMFVideoRendererEffectControl = {0x604D33D7, 0xCF23, 0x41D5, [0x82, 0x24, 0x5B, 0xBB, 0xB1, 0xA8, 0x74, 0x75]};
@GUID(0x604D33D7, 0xCF23, 0x41D5, [0x82, 0x24, 0x5B, 0xBB, 0xB1, 0xA8, 0x74, 0x75]);
interface IMFVideoRendererEffectControl : IUnknown
{
    HRESULT OnAppServiceConnectionEstablished(IUnknown pAppServiceConnection);
}

const GUID IID_IMFTopology = {0x83CF873A, 0xF6DA, 0x4BC8, [0x82, 0x3F, 0xBA, 0xCF, 0xD5, 0x5D, 0xC4, 0x33]};
@GUID(0x83CF873A, 0xF6DA, 0x4BC8, [0x82, 0x3F, 0xBA, 0xCF, 0xD5, 0x5D, 0xC4, 0x33]);
interface IMFTopology : IMFAttributes
{
    HRESULT GetTopologyID(ulong* pID);
    HRESULT AddNode(IMFTopologyNode pNode);
    HRESULT RemoveNode(IMFTopologyNode pNode);
    HRESULT GetNodeCount(ushort* pwNodes);
    HRESULT GetNode(ushort wIndex, IMFTopologyNode* ppNode);
    HRESULT Clear();
    HRESULT CloneFrom(IMFTopology pTopology);
    HRESULT GetNodeByID(ulong qwTopoNodeID, IMFTopologyNode* ppNode);
    HRESULT GetSourceNodeCollection(IMFCollection* ppCollection);
    HRESULT GetOutputNodeCollection(IMFCollection* ppCollection);
}

enum MFTOPOLOGY_DXVA_MODE
{
    MFTOPOLOGY_DXVA_DEFAULT = 0,
    MFTOPOLOGY_DXVA_NONE = 1,
    MFTOPOLOGY_DXVA_FULL = 2,
}

enum MFTOPOLOGY_HARDWARE_MODE
{
    MFTOPOLOGY_HWMODE_SOFTWARE_ONLY = 0,
    MFTOPOLOGY_HWMODE_USE_HARDWARE = 1,
    MFTOPOLOGY_HWMODE_USE_ONLY_HARDWARE = 2,
}

enum MF_TOPOLOGY_TYPE
{
    MF_TOPOLOGY_OUTPUT_NODE = 0,
    MF_TOPOLOGY_SOURCESTREAM_NODE = 1,
    MF_TOPOLOGY_TRANSFORM_NODE = 2,
    MF_TOPOLOGY_TEE_NODE = 3,
    MF_TOPOLOGY_MAX = -1,
}

const GUID IID_IMFTopologyNode = {0x83CF873A, 0xF6DA, 0x4BC8, [0x82, 0x3F, 0xBA, 0xCF, 0xD5, 0x5D, 0xC4, 0x30]};
@GUID(0x83CF873A, 0xF6DA, 0x4BC8, [0x82, 0x3F, 0xBA, 0xCF, 0xD5, 0x5D, 0xC4, 0x30]);
interface IMFTopologyNode : IMFAttributes
{
    HRESULT SetObject(IUnknown pObject);
    HRESULT GetObjectA(IUnknown* ppObject);
    HRESULT GetNodeType(MF_TOPOLOGY_TYPE* pType);
    HRESULT GetTopoNodeID(ulong* pID);
    HRESULT SetTopoNodeID(ulong ullTopoID);
    HRESULT GetInputCount(uint* pcInputs);
    HRESULT GetOutputCount(uint* pcOutputs);
    HRESULT ConnectOutput(uint dwOutputIndex, IMFTopologyNode pDownstreamNode, uint dwInputIndexOnDownstreamNode);
    HRESULT DisconnectOutput(uint dwOutputIndex);
    HRESULT GetInput(uint dwInputIndex, IMFTopologyNode* ppUpstreamNode, uint* pdwOutputIndexOnUpstreamNode);
    HRESULT GetOutput(uint dwOutputIndex, IMFTopologyNode* ppDownstreamNode, uint* pdwInputIndexOnDownstreamNode);
    HRESULT SetOutputPrefType(uint dwOutputIndex, IMFMediaType pType);
    HRESULT GetOutputPrefType(uint dwOutputIndex, IMFMediaType* ppType);
    HRESULT SetInputPrefType(uint dwInputIndex, IMFMediaType pType);
    HRESULT GetInputPrefType(uint dwInputIndex, IMFMediaType* ppType);
    HRESULT CloneFrom(IMFTopologyNode pNode);
}

enum MF_TOPONODE_FLUSH_MODE
{
    MF_TOPONODE_FLUSH_ALWAYS = 0,
    MF_TOPONODE_FLUSH_SEEK = 1,
    MF_TOPONODE_FLUSH_NEVER = 2,
}

enum MF_TOPONODE_DRAIN_MODE
{
    MF_TOPONODE_DRAIN_DEFAULT = 0,
    MF_TOPONODE_DRAIN_ALWAYS = 1,
    MF_TOPONODE_DRAIN_NEVER = 2,
}

const GUID IID_IMFGetService = {0xFA993888, 0x4383, 0x415A, [0xA9, 0x30, 0xDD, 0x47, 0x2A, 0x8C, 0xF6, 0xF7]};
@GUID(0xFA993888, 0x4383, 0x415A, [0xA9, 0x30, 0xDD, 0x47, 0x2A, 0x8C, 0xF6, 0xF7]);
interface IMFGetService : IUnknown
{
    HRESULT GetService(const(Guid)* guidService, const(Guid)* riid, void** ppvObject);
}

enum MFCLOCK_CHARACTERISTICS_FLAGS
{
    MFCLOCK_CHARACTERISTICS_FLAG_FREQUENCY_10MHZ = 2,
    MFCLOCK_CHARACTERISTICS_FLAG_ALWAYS_RUNNING = 4,
    MFCLOCK_CHARACTERISTICS_FLAG_IS_SYSTEM_CLOCK = 8,
}

enum MFCLOCK_STATE
{
    MFCLOCK_STATE_INVALID = 0,
    MFCLOCK_STATE_RUNNING = 1,
    MFCLOCK_STATE_STOPPED = 2,
    MFCLOCK_STATE_PAUSED = 3,
}

enum MFCLOCK_RELATIONAL_FLAGS
{
    MFCLOCK_RELATIONAL_FLAG_JITTER_NEVER_AHEAD = 1,
}

struct MFCLOCK_PROPERTIES
{
    ulong qwCorrelationRate;
    Guid guidClockId;
    uint dwClockFlags;
    ulong qwClockFrequency;
    uint dwClockTolerance;
    uint dwClockJitter;
}

const GUID IID_IMFClock = {0x2EB1E945, 0x18B8, 0x4139, [0x9B, 0x1A, 0xD5, 0xD5, 0x84, 0x81, 0x85, 0x30]};
@GUID(0x2EB1E945, 0x18B8, 0x4139, [0x9B, 0x1A, 0xD5, 0xD5, 0x84, 0x81, 0x85, 0x30]);
interface IMFClock : IUnknown
{
    HRESULT GetClockCharacteristics(uint* pdwCharacteristics);
    HRESULT GetCorrelatedTime(uint dwReserved, long* pllClockTime, long* phnsSystemTime);
    HRESULT GetContinuityKey(uint* pdwContinuityKey);
    HRESULT GetState(uint dwReserved, MFCLOCK_STATE* peClockState);
    HRESULT GetProperties(MFCLOCK_PROPERTIES* pClockProperties);
}

const GUID IID_IMFPresentationClock = {0x868CE85C, 0x8EA9, 0x4F55, [0xAB, 0x82, 0xB0, 0x09, 0xA9, 0x10, 0xA8, 0x05]};
@GUID(0x868CE85C, 0x8EA9, 0x4F55, [0xAB, 0x82, 0xB0, 0x09, 0xA9, 0x10, 0xA8, 0x05]);
interface IMFPresentationClock : IMFClock
{
    HRESULT SetTimeSource(IMFPresentationTimeSource pTimeSource);
    HRESULT GetTimeSource(IMFPresentationTimeSource* ppTimeSource);
    HRESULT GetTime(long* phnsClockTime);
    HRESULT AddClockStateSink(IMFClockStateSink pStateSink);
    HRESULT RemoveClockStateSink(IMFClockStateSink pStateSink);
    HRESULT Start(long llClockStartOffset);
    HRESULT Stop();
    HRESULT Pause();
}

const GUID IID_IMFPresentationTimeSource = {0x7FF12CCE, 0xF76F, 0x41C2, [0x86, 0x3B, 0x16, 0x66, 0xC8, 0xE5, 0xE1, 0x39]};
@GUID(0x7FF12CCE, 0xF76F, 0x41C2, [0x86, 0x3B, 0x16, 0x66, 0xC8, 0xE5, 0xE1, 0x39]);
interface IMFPresentationTimeSource : IMFClock
{
    HRESULT GetUnderlyingClock(IMFClock* ppClock);
}

const GUID IID_IMFClockStateSink = {0xF6696E82, 0x74F7, 0x4F3D, [0xA1, 0x78, 0x8A, 0x5E, 0x09, 0xC3, 0x65, 0x9F]};
@GUID(0xF6696E82, 0x74F7, 0x4F3D, [0xA1, 0x78, 0x8A, 0x5E, 0x09, 0xC3, 0x65, 0x9F]);
interface IMFClockStateSink : IUnknown
{
    HRESULT OnClockStart(long hnsSystemTime, long llClockStartOffset);
    HRESULT OnClockStop(long hnsSystemTime);
    HRESULT OnClockPause(long hnsSystemTime);
    HRESULT OnClockRestart(long hnsSystemTime);
    HRESULT OnClockSetRate(long hnsSystemTime, float flRate);
}

const GUID IID_IMFPresentationDescriptor = {0x03CB2711, 0x24D7, 0x4DB6, [0xA1, 0x7F, 0xF3, 0xA7, 0xA4, 0x79, 0xA5, 0x36]};
@GUID(0x03CB2711, 0x24D7, 0x4DB6, [0xA1, 0x7F, 0xF3, 0xA7, 0xA4, 0x79, 0xA5, 0x36]);
interface IMFPresentationDescriptor : IMFAttributes
{
    HRESULT GetStreamDescriptorCount(uint* pdwDescriptorCount);
    HRESULT GetStreamDescriptorByIndex(uint dwIndex, int* pfSelected, IMFStreamDescriptor* ppDescriptor);
    HRESULT SelectStream(uint dwDescriptorIndex);
    HRESULT DeselectStream(uint dwDescriptorIndex);
    HRESULT Clone(IMFPresentationDescriptor* ppPresentationDescriptor);
}

const GUID IID_IMFStreamDescriptor = {0x56C03D9C, 0x9DBB, 0x45F5, [0xAB, 0x4B, 0xD8, 0x0F, 0x47, 0xC0, 0x59, 0x38]};
@GUID(0x56C03D9C, 0x9DBB, 0x45F5, [0xAB, 0x4B, 0xD8, 0x0F, 0x47, 0xC0, 0x59, 0x38]);
interface IMFStreamDescriptor : IMFAttributes
{
    HRESULT GetStreamIdentifier(uint* pdwStreamIdentifier);
    HRESULT GetMediaTypeHandler(IMFMediaTypeHandler* ppMediaTypeHandler);
}

const GUID IID_IMFMediaTypeHandler = {0xE93DCF6C, 0x4B07, 0x4E1E, [0x81, 0x23, 0xAA, 0x16, 0xED, 0x6E, 0xAD, 0xF5]};
@GUID(0xE93DCF6C, 0x4B07, 0x4E1E, [0x81, 0x23, 0xAA, 0x16, 0xED, 0x6E, 0xAD, 0xF5]);
interface IMFMediaTypeHandler : IUnknown
{
    HRESULT IsMediaTypeSupported(IMFMediaType pMediaType, IMFMediaType* ppMediaType);
    HRESULT GetMediaTypeCount(uint* pdwTypeCount);
    HRESULT GetMediaTypeByIndex(uint dwIndex, IMFMediaType* ppType);
    HRESULT SetCurrentMediaType(IMFMediaType pMediaType);
    HRESULT GetCurrentMediaType(IMFMediaType* ppMediaType);
    HRESULT GetMajorType(Guid* pguidMajorType);
}

enum MFTIMER_FLAGS
{
    MFTIMER_RELATIVE = 1,
}

const GUID IID_IMFTimer = {0xE56E4CBD, 0x8F70, 0x49D8, [0xA0, 0xF8, 0xED, 0xB3, 0xD6, 0xAB, 0x9B, 0xF2]};
@GUID(0xE56E4CBD, 0x8F70, 0x49D8, [0xA0, 0xF8, 0xED, 0xB3, 0xD6, 0xAB, 0x9B, 0xF2]);
interface IMFTimer : IUnknown
{
    HRESULT SetTimer(uint dwFlags, long llClockTime, IMFAsyncCallback pCallback, IUnknown punkState, IUnknown* ppunkKey);
    HRESULT CancelTimer(IUnknown punkKey);
}

enum __MIDL___MIDL_itf_mfidl_0000_0029_0001
{
    MF_ACTIVATE_CUSTOM_MIXER_ALLOWFAIL = 1,
}

enum __MIDL___MIDL_itf_mfidl_0000_0029_0002
{
    MF_ACTIVATE_CUSTOM_PRESENTER_ALLOWFAIL = 1,
}

enum MFSHUTDOWN_STATUS
{
    MFSHUTDOWN_INITIATED = 0,
    MFSHUTDOWN_COMPLETED = 1,
}

const GUID IID_IMFShutdown = {0x97EC2EA4, 0x0E42, 0x4937, [0x97, 0xAC, 0x9D, 0x6D, 0x32, 0x88, 0x24, 0xE1]};
@GUID(0x97EC2EA4, 0x0E42, 0x4937, [0x97, 0xAC, 0x9D, 0x6D, 0x32, 0x88, 0x24, 0xE1]);
interface IMFShutdown : IUnknown
{
    HRESULT Shutdown();
    HRESULT GetShutdownStatus(MFSHUTDOWN_STATUS* pStatus);
}

const GUID IID_IMFTopoLoader = {0xDE9A6157, 0xF660, 0x4643, [0xB5, 0x6A, 0xDF, 0x9F, 0x79, 0x98, 0xC7, 0xCD]};
@GUID(0xDE9A6157, 0xF660, 0x4643, [0xB5, 0x6A, 0xDF, 0x9F, 0x79, 0x98, 0xC7, 0xCD]);
interface IMFTopoLoader : IUnknown
{
    HRESULT Load(IMFTopology pInputTopo, IMFTopology* ppOutputTopo, IMFTopology pCurrentTopo);
}

const GUID IID_IMFContentProtectionManager = {0xACF92459, 0x6A61, 0x42BD, [0xB5, 0x7C, 0xB4, 0x3E, 0x51, 0x20, 0x3C, 0xB0]};
@GUID(0xACF92459, 0x6A61, 0x42BD, [0xB5, 0x7C, 0xB4, 0x3E, 0x51, 0x20, 0x3C, 0xB0]);
interface IMFContentProtectionManager : IUnknown
{
    HRESULT BeginEnableContent(IMFActivate pEnablerActivate, IMFTopology pTopo, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndEnableContent(IMFAsyncResult pResult);
}

enum MF_URL_TRUST_STATUS
{
    MF_LICENSE_URL_UNTRUSTED = 0,
    MF_LICENSE_URL_TRUSTED = 1,
    MF_LICENSE_URL_TAMPERED = 2,
}

const GUID IID_IMFContentEnabler = {0xD3C4EF59, 0x49CE, 0x4381, [0x90, 0x71, 0xD5, 0xBC, 0xD0, 0x44, 0xC7, 0x70]};
@GUID(0xD3C4EF59, 0x49CE, 0x4381, [0x90, 0x71, 0xD5, 0xBC, 0xD0, 0x44, 0xC7, 0x70]);
interface IMFContentEnabler : IUnknown
{
    HRESULT GetEnableType(Guid* pType);
    HRESULT GetEnableURL(char* ppwszURL, uint* pcchURL, MF_URL_TRUST_STATUS* pTrustStatus);
    HRESULT GetEnableData(char* ppbData, uint* pcbData);
    HRESULT IsAutomaticSupported(int* pfAutomatic);
    HRESULT AutomaticEnable();
    HRESULT MonitorEnable();
    HRESULT Cancel();
}

struct MFRR_COMPONENT_HASH_INFO
{
    uint ulReason;
    ushort rgHeaderHash;
    ushort rgPublicKeyHash;
    ushort wszName;
}

struct MFRR_COMPONENTS
{
    uint dwRRInfoVersion;
    uint dwRRComponents;
    MFRR_COMPONENT_HASH_INFO* pRRComponents;
}

struct ASF_FLAT_PICTURE
{
    ubyte bPictureType;
    uint dwDataLen;
}

struct ASF_FLAT_SYNCHRONISED_LYRICS
{
    ubyte bTimeStampFormat;
    ubyte bContentType;
    uint dwLyricsLen;
}

const GUID IID_IMFMetadata = {0xF88CFB8C, 0xEF16, 0x4991, [0xB4, 0x50, 0xCB, 0x8C, 0x69, 0xE5, 0x17, 0x04]};
@GUID(0xF88CFB8C, 0xEF16, 0x4991, [0xB4, 0x50, 0xCB, 0x8C, 0x69, 0xE5, 0x17, 0x04]);
interface IMFMetadata : IUnknown
{
    HRESULT SetLanguage(const(wchar)* pwszRFC1766);
    HRESULT GetLanguage(ushort** ppwszRFC1766);
    HRESULT GetAllLanguages(PROPVARIANT* ppvLanguages);
    HRESULT SetProperty(const(wchar)* pwszName, const(PROPVARIANT)* ppvValue);
    HRESULT GetProperty(const(wchar)* pwszName, PROPVARIANT* ppvValue);
    HRESULT DeleteProperty(const(wchar)* pwszName);
    HRESULT GetAllPropertyNames(PROPVARIANT* ppvNames);
}

const GUID IID_IMFMetadataProvider = {0x56181D2D, 0xE221, 0x4ADB, [0xB1, 0xC8, 0x3C, 0xEE, 0x6A, 0x53, 0xF7, 0x6F]};
@GUID(0x56181D2D, 0xE221, 0x4ADB, [0xB1, 0xC8, 0x3C, 0xEE, 0x6A, 0x53, 0xF7, 0x6F]);
interface IMFMetadataProvider : IUnknown
{
    HRESULT GetMFMetadata(IMFPresentationDescriptor pPresentationDescriptor, uint dwStreamIdentifier, uint dwFlags, IMFMetadata* ppMFMetadata);
}

enum MFRATE_DIRECTION
{
    MFRATE_FORWARD = 0,
    MFRATE_REVERSE = 1,
}

const GUID IID_IMFRateSupport = {0x0A9CCDBC, 0xD797, 0x4563, [0x96, 0x67, 0x94, 0xEC, 0x5D, 0x79, 0x29, 0x2D]};
@GUID(0x0A9CCDBC, 0xD797, 0x4563, [0x96, 0x67, 0x94, 0xEC, 0x5D, 0x79, 0x29, 0x2D]);
interface IMFRateSupport : IUnknown
{
    HRESULT GetSlowestRate(MFRATE_DIRECTION eDirection, BOOL fThin, float* pflRate);
    HRESULT GetFastestRate(MFRATE_DIRECTION eDirection, BOOL fThin, float* pflRate);
    HRESULT IsRateSupported(BOOL fThin, float flRate, float* pflNearestSupportedRate);
}

const GUID IID_IMFRateControl = {0x88DDCD21, 0x03C3, 0x4275, [0x91, 0xED, 0x55, 0xEE, 0x39, 0x29, 0x32, 0x8F]};
@GUID(0x88DDCD21, 0x03C3, 0x4275, [0x91, 0xED, 0x55, 0xEE, 0x39, 0x29, 0x32, 0x8F]);
interface IMFRateControl : IUnknown
{
    HRESULT SetRate(BOOL fThin, float flRate);
    HRESULT GetRate(int* pfThin, float* pflRate);
}

const GUID IID_IMFTimecodeTranslate = {0xAB9D8661, 0xF7E8, 0x4EF4, [0x98, 0x61, 0x89, 0xF3, 0x34, 0xF9, 0x4E, 0x74]};
@GUID(0xAB9D8661, 0xF7E8, 0x4EF4, [0x98, 0x61, 0x89, 0xF3, 0x34, 0xF9, 0x4E, 0x74]);
interface IMFTimecodeTranslate : IUnknown
{
    HRESULT BeginConvertTimecodeToHNS(const(PROPVARIANT)* pPropVarTimecode, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndConvertTimecodeToHNS(IMFAsyncResult pResult, long* phnsTime);
    HRESULT BeginConvertHNSToTimecode(long hnsTime, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndConvertHNSToTimecode(IMFAsyncResult pResult, PROPVARIANT* pPropVarTimecode);
}

const GUID IID_IMFSeekInfo = {0x26AFEA53, 0xD9ED, 0x42B5, [0xAB, 0x80, 0xE6, 0x4F, 0x9E, 0xE3, 0x47, 0x79]};
@GUID(0x26AFEA53, 0xD9ED, 0x42B5, [0xAB, 0x80, 0xE6, 0x4F, 0x9E, 0xE3, 0x47, 0x79]);
interface IMFSeekInfo : IUnknown
{
    HRESULT GetNearestKeyFrames(const(Guid)* pguidTimeFormat, const(PROPVARIANT)* pvarStartPosition, PROPVARIANT* pvarPreviousKeyFrame, PROPVARIANT* pvarNextKeyFrame);
}

const GUID IID_IMFSimpleAudioVolume = {0x089EDF13, 0xCF71, 0x4338, [0x8D, 0x13, 0x9E, 0x56, 0x9D, 0xBD, 0xC3, 0x19]};
@GUID(0x089EDF13, 0xCF71, 0x4338, [0x8D, 0x13, 0x9E, 0x56, 0x9D, 0xBD, 0xC3, 0x19]);
interface IMFSimpleAudioVolume : IUnknown
{
    HRESULT SetMasterVolume(float fLevel);
    HRESULT GetMasterVolume(float* pfLevel);
    HRESULT SetMute(const(int) bMute);
    HRESULT GetMute(int* pbMute);
}

const GUID IID_IMFAudioStreamVolume = {0x76B1BBDB, 0x4EC8, 0x4F36, [0xB1, 0x06, 0x70, 0xA9, 0x31, 0x6D, 0xF5, 0x93]};
@GUID(0x76B1BBDB, 0x4EC8, 0x4F36, [0xB1, 0x06, 0x70, 0xA9, 0x31, 0x6D, 0xF5, 0x93]);
interface IMFAudioStreamVolume : IUnknown
{
    HRESULT GetChannelCount(uint* pdwCount);
    HRESULT SetChannelVolume(uint dwIndex, const(float) fLevel);
    HRESULT GetChannelVolume(uint dwIndex, float* pfLevel);
    HRESULT SetAllVolumes(uint dwCount, char* pfVolumes);
    HRESULT GetAllVolumes(uint dwCount, char* pfVolumes);
}

const GUID IID_IMFAudioPolicy = {0xA0638C2B, 0x6465, 0x4395, [0x9A, 0xE7, 0xA3, 0x21, 0xA9, 0xFD, 0x28, 0x56]};
@GUID(0xA0638C2B, 0x6465, 0x4395, [0x9A, 0xE7, 0xA3, 0x21, 0xA9, 0xFD, 0x28, 0x56]);
interface IMFAudioPolicy : IUnknown
{
    HRESULT SetGroupingParam(const(Guid)* rguidClass);
    HRESULT GetGroupingParam(Guid* pguidClass);
    HRESULT SetDisplayName(const(wchar)* pszName);
    HRESULT GetDisplayName(ushort** pszName);
    HRESULT SetIconPath(const(wchar)* pszPath);
    HRESULT GetIconPath(ushort** pszPath);
}

const GUID IID_IMFSampleGrabberSinkCallback = {0x8C7B80BF, 0xEE42, 0x4B59, [0xB1, 0xDF, 0x55, 0x66, 0x8E, 0x1B, 0xDC, 0xA8]};
@GUID(0x8C7B80BF, 0xEE42, 0x4B59, [0xB1, 0xDF, 0x55, 0x66, 0x8E, 0x1B, 0xDC, 0xA8]);
interface IMFSampleGrabberSinkCallback : IMFClockStateSink
{
    HRESULT OnSetPresentationClock(IMFPresentationClock pPresentationClock);
    HRESULT OnProcessSample(const(Guid)* guidMajorMediaType, uint dwSampleFlags, long llSampleTime, long llSampleDuration, char* pSampleBuffer, uint dwSampleSize);
    HRESULT OnShutdown();
}

const GUID IID_IMFSampleGrabberSinkCallback2 = {0xCA86AA50, 0xC46E, 0x429E, [0xAB, 0x27, 0x16, 0xD6, 0xAC, 0x68, 0x44, 0xCB]};
@GUID(0xCA86AA50, 0xC46E, 0x429E, [0xAB, 0x27, 0x16, 0xD6, 0xAC, 0x68, 0x44, 0xCB]);
interface IMFSampleGrabberSinkCallback2 : IMFSampleGrabberSinkCallback
{
    HRESULT OnProcessSampleEx(const(Guid)* guidMajorMediaType, uint dwSampleFlags, long llSampleTime, long llSampleDuration, char* pSampleBuffer, uint dwSampleSize, IMFAttributes pAttributes);
}

const GUID IID_IMFWorkQueueServices = {0x35FE1BB8, 0xA3A9, 0x40FE, [0xBB, 0xEC, 0xEB, 0x56, 0x9C, 0x9C, 0xCC, 0xA3]};
@GUID(0x35FE1BB8, 0xA3A9, 0x40FE, [0xBB, 0xEC, 0xEB, 0x56, 0x9C, 0x9C, 0xCC, 0xA3]);
interface IMFWorkQueueServices : IUnknown
{
    HRESULT BeginRegisterTopologyWorkQueuesWithMMCSS(IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndRegisterTopologyWorkQueuesWithMMCSS(IMFAsyncResult pResult);
    HRESULT BeginUnregisterTopologyWorkQueuesWithMMCSS(IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndUnregisterTopologyWorkQueuesWithMMCSS(IMFAsyncResult pResult);
    HRESULT GetTopologyWorkQueueMMCSSClass(uint dwTopologyWorkQueueId, const(wchar)* pwszClass, uint* pcchClass);
    HRESULT GetTopologyWorkQueueMMCSSTaskId(uint dwTopologyWorkQueueId, uint* pdwTaskId);
    HRESULT BeginRegisterPlatformWorkQueueWithMMCSS(uint dwPlatformWorkQueue, const(wchar)* wszClass, uint dwTaskId, IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndRegisterPlatformWorkQueueWithMMCSS(IMFAsyncResult pResult, uint* pdwTaskId);
    HRESULT BeginUnregisterPlatformWorkQueueWithMMCSS(uint dwPlatformWorkQueue, IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndUnregisterPlatformWorkQueueWithMMCSS(IMFAsyncResult pResult);
    HRESULT GetPlaftormWorkQueueMMCSSClass(uint dwPlatformWorkQueueId, const(wchar)* pwszClass, uint* pcchClass);
    HRESULT GetPlatformWorkQueueMMCSSTaskId(uint dwPlatformWorkQueueId, uint* pdwTaskId);
}

const GUID IID_IMFWorkQueueServicesEx = {0x96BF961B, 0x40FE, 0x42F1, [0xBA, 0x9D, 0x32, 0x02, 0x38, 0xB4, 0x97, 0x00]};
@GUID(0x96BF961B, 0x40FE, 0x42F1, [0xBA, 0x9D, 0x32, 0x02, 0x38, 0xB4, 0x97, 0x00]);
interface IMFWorkQueueServicesEx : IMFWorkQueueServices
{
    HRESULT GetTopologyWorkQueueMMCSSPriority(uint dwTopologyWorkQueueId, int* plPriority);
    HRESULT BeginRegisterPlatformWorkQueueWithMMCSSEx(uint dwPlatformWorkQueue, const(wchar)* wszClass, uint dwTaskId, int lPriority, IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT GetPlatformWorkQueueMMCSSPriority(uint dwPlatformWorkQueueId, int* plPriority);
}

enum MF_QUALITY_DROP_MODE
{
    MF_DROP_MODE_NONE = 0,
    MF_DROP_MODE_1 = 1,
    MF_DROP_MODE_2 = 2,
    MF_DROP_MODE_3 = 3,
    MF_DROP_MODE_4 = 4,
    MF_DROP_MODE_5 = 5,
    MF_NUM_DROP_MODES = 6,
}

enum MF_QUALITY_LEVEL
{
    MF_QUALITY_NORMAL = 0,
    MF_QUALITY_NORMAL_MINUS_1 = 1,
    MF_QUALITY_NORMAL_MINUS_2 = 2,
    MF_QUALITY_NORMAL_MINUS_3 = 3,
    MF_QUALITY_NORMAL_MINUS_4 = 4,
    MF_QUALITY_NORMAL_MINUS_5 = 5,
    MF_NUM_QUALITY_LEVELS = 6,
}

enum MF_QUALITY_ADVISE_FLAGS
{
    MF_QUALITY_CANNOT_KEEP_UP = 1,
}

const GUID IID_IMFQualityManager = {0x8D009D86, 0x5B9F, 0x4115, [0xB1, 0xFC, 0x9F, 0x80, 0xD5, 0x2A, 0xB8, 0xAB]};
@GUID(0x8D009D86, 0x5B9F, 0x4115, [0xB1, 0xFC, 0x9F, 0x80, 0xD5, 0x2A, 0xB8, 0xAB]);
interface IMFQualityManager : IUnknown
{
    HRESULT NotifyTopology(IMFTopology pTopology);
    HRESULT NotifyPresentationClock(IMFPresentationClock pClock);
    HRESULT NotifyProcessInput(IMFTopologyNode pNode, int lInputIndex, IMFSample pSample);
    HRESULT NotifyProcessOutput(IMFTopologyNode pNode, int lOutputIndex, IMFSample pSample);
    HRESULT NotifyQualityEvent(IUnknown pObject, IMFMediaEvent pEvent);
    HRESULT Shutdown();
}

const GUID IID_IMFQualityAdvise = {0xEC15E2E9, 0xE36B, 0x4F7C, [0x87, 0x58, 0x77, 0xD4, 0x52, 0xEF, 0x4C, 0xE7]};
@GUID(0xEC15E2E9, 0xE36B, 0x4F7C, [0x87, 0x58, 0x77, 0xD4, 0x52, 0xEF, 0x4C, 0xE7]);
interface IMFQualityAdvise : IUnknown
{
    HRESULT SetDropMode(MF_QUALITY_DROP_MODE eDropMode);
    HRESULT SetQualityLevel(MF_QUALITY_LEVEL eQualityLevel);
    HRESULT GetDropMode(MF_QUALITY_DROP_MODE* peDropMode);
    HRESULT GetQualityLevel(MF_QUALITY_LEVEL* peQualityLevel);
    HRESULT DropTime(long hnsAmountToDrop);
}

const GUID IID_IMFQualityAdvise2 = {0xF3706F0D, 0x8EA2, 0x4886, [0x80, 0x00, 0x71, 0x55, 0xE9, 0xEC, 0x2E, 0xAE]};
@GUID(0xF3706F0D, 0x8EA2, 0x4886, [0x80, 0x00, 0x71, 0x55, 0xE9, 0xEC, 0x2E, 0xAE]);
interface IMFQualityAdvise2 : IMFQualityAdvise
{
    HRESULT NotifyQualityEvent(IMFMediaEvent pEvent, uint* pdwFlags);
}

const GUID IID_IMFQualityAdviseLimits = {0xDFCD8E4D, 0x30B5, 0x4567, [0xAC, 0xAA, 0x8E, 0xB5, 0xB7, 0x85, 0x3D, 0xC9]};
@GUID(0xDFCD8E4D, 0x30B5, 0x4567, [0xAC, 0xAA, 0x8E, 0xB5, 0xB7, 0x85, 0x3D, 0xC9]);
interface IMFQualityAdviseLimits : IUnknown
{
    HRESULT GetMaximumDropMode(MF_QUALITY_DROP_MODE* peDropMode);
    HRESULT GetMinimumQualityLevel(MF_QUALITY_LEVEL* peQualityLevel);
}

const GUID IID_IMFRealTimeClient = {0x2347D60B, 0x3FB5, 0x480C, [0x88, 0x03, 0x8D, 0xF3, 0xAD, 0xCD, 0x3E, 0xF0]};
@GUID(0x2347D60B, 0x3FB5, 0x480C, [0x88, 0x03, 0x8D, 0xF3, 0xAD, 0xCD, 0x3E, 0xF0]);
interface IMFRealTimeClient : IUnknown
{
    HRESULT RegisterThreads(uint dwTaskIndex, const(wchar)* wszClass);
    HRESULT UnregisterThreads();
    HRESULT SetWorkQueue(uint dwWorkQueueId);
}

const GUID IID_IMFRealTimeClientEx = {0x03910848, 0xAB16, 0x4611, [0xB1, 0x00, 0x17, 0xB8, 0x8A, 0xE2, 0xF2, 0x48]};
@GUID(0x03910848, 0xAB16, 0x4611, [0xB1, 0x00, 0x17, 0xB8, 0x8A, 0xE2, 0xF2, 0x48]);
interface IMFRealTimeClientEx : IUnknown
{
    HRESULT RegisterThreadsEx(uint* pdwTaskIndex, const(wchar)* wszClassName, int lBasePriority);
    HRESULT UnregisterThreads();
    HRESULT SetWorkQueueEx(uint dwMultithreadedWorkQueueId, int lWorkItemBasePriority);
}

enum MFSequencerTopologyFlags
{
    SequencerTopologyFlags_Last = 1,
}

const GUID IID_IMFSequencerSource = {0x197CD219, 0x19CB, 0x4DE1, [0xA6, 0x4C, 0xAC, 0xF2, 0xED, 0xCB, 0xE5, 0x9E]};
@GUID(0x197CD219, 0x19CB, 0x4DE1, [0xA6, 0x4C, 0xAC, 0xF2, 0xED, 0xCB, 0xE5, 0x9E]);
interface IMFSequencerSource : IUnknown
{
    HRESULT AppendTopology(IMFTopology pTopology, uint dwFlags, uint* pdwId);
    HRESULT DeleteTopology(uint dwId);
    HRESULT GetPresentationContext(IMFPresentationDescriptor pPD, uint* pId, IMFTopology* ppTopology);
    HRESULT UpdateTopology(uint dwId, IMFTopology pTopology);
    HRESULT UpdateTopologyFlags(uint dwId, uint dwFlags);
}

const GUID IID_IMFMediaSourceTopologyProvider = {0x0E1D6009, 0xC9F3, 0x442D, [0x8C, 0x51, 0xA4, 0x2D, 0x2D, 0x49, 0x45, 0x2F]};
@GUID(0x0E1D6009, 0xC9F3, 0x442D, [0x8C, 0x51, 0xA4, 0x2D, 0x2D, 0x49, 0x45, 0x2F]);
interface IMFMediaSourceTopologyProvider : IUnknown
{
    HRESULT GetMediaSourceTopology(IMFPresentationDescriptor pPresentationDescriptor, IMFTopology* ppTopology);
}

const GUID IID_IMFMediaSourcePresentationProvider = {0x0E1D600A, 0xC9F3, 0x442D, [0x8C, 0x51, 0xA4, 0x2D, 0x2D, 0x49, 0x45, 0x2F]};
@GUID(0x0E1D600A, 0xC9F3, 0x442D, [0x8C, 0x51, 0xA4, 0x2D, 0x2D, 0x49, 0x45, 0x2F]);
interface IMFMediaSourcePresentationProvider : IUnknown
{
    HRESULT ForceEndOfPresentation(IMFPresentationDescriptor pPresentationDescriptor);
}

struct MFTOPONODE_ATTRIBUTE_UPDATE
{
    ulong NodeId;
    Guid guidAttributeKey;
    MF_ATTRIBUTE_TYPE attrType;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_IMFTopologyNodeAttributeEditor = {0x676AA6DD, 0x238A, 0x410D, [0xBB, 0x99, 0x65, 0x66, 0x8D, 0x01, 0x60, 0x5A]};
@GUID(0x676AA6DD, 0x238A, 0x410D, [0xBB, 0x99, 0x65, 0x66, 0x8D, 0x01, 0x60, 0x5A]);
interface IMFTopologyNodeAttributeEditor : IUnknown
{
    HRESULT UpdateNodeAttributes(ulong TopoId, uint cUpdates, char* pUpdates);
}

struct MF_LEAKY_BUCKET_PAIR
{
    uint dwBitrate;
    uint msBufferWindow;
}

struct MFBYTESTREAM_BUFFERING_PARAMS
{
    ulong cbTotalFileSize;
    ulong cbPlayableDataSize;
    MF_LEAKY_BUCKET_PAIR* prgBuckets;
    uint cBuckets;
    ulong qwNetBufferingTime;
    ulong qwExtraBufferingTimeDuringSeek;
    ulong qwPlayDuration;
    float dRate;
}

const GUID IID_IMFByteStreamBuffering = {0x6D66D782, 0x1D4F, 0x4DB7, [0x8C, 0x63, 0xCB, 0x8C, 0x77, 0xF1, 0xEF, 0x5E]};
@GUID(0x6D66D782, 0x1D4F, 0x4DB7, [0x8C, 0x63, 0xCB, 0x8C, 0x77, 0xF1, 0xEF, 0x5E]);
interface IMFByteStreamBuffering : IUnknown
{
    HRESULT SetBufferingParams(MFBYTESTREAM_BUFFERING_PARAMS* pParams);
    HRESULT EnableBuffering(BOOL fEnable);
    HRESULT StopBuffering();
}

const GUID IID_IMFByteStreamCacheControl = {0xF5042EA4, 0x7A96, 0x4A75, [0xAA, 0x7B, 0x2B, 0xE1, 0xEF, 0x7F, 0x88, 0xD5]};
@GUID(0xF5042EA4, 0x7A96, 0x4A75, [0xAA, 0x7B, 0x2B, 0xE1, 0xEF, 0x7F, 0x88, 0xD5]);
interface IMFByteStreamCacheControl : IUnknown
{
    HRESULT StopBackgroundTransfer();
}

const GUID IID_IMFByteStreamTimeSeek = {0x64976BFA, 0xFB61, 0x4041, [0x90, 0x69, 0x8C, 0x9A, 0x5F, 0x65, 0x9B, 0xEB]};
@GUID(0x64976BFA, 0xFB61, 0x4041, [0x90, 0x69, 0x8C, 0x9A, 0x5F, 0x65, 0x9B, 0xEB]);
interface IMFByteStreamTimeSeek : IUnknown
{
    HRESULT IsTimeSeekSupported(int* pfTimeSeekIsSupported);
    HRESULT TimeSeek(ulong qwTimePosition);
    HRESULT GetTimeSeekResult(ulong* pqwStartTime, ulong* pqwStopTime, ulong* pqwDuration);
}

struct MF_BYTE_STREAM_CACHE_RANGE
{
    ulong qwStartOffset;
    ulong qwEndOffset;
}

const GUID IID_IMFByteStreamCacheControl2 = {0x71CE469C, 0xF34B, 0x49EA, [0xA5, 0x6B, 0x2D, 0x2A, 0x10, 0xE5, 0x11, 0x49]};
@GUID(0x71CE469C, 0xF34B, 0x49EA, [0xA5, 0x6B, 0x2D, 0x2A, 0x10, 0xE5, 0x11, 0x49]);
interface IMFByteStreamCacheControl2 : IMFByteStreamCacheControl
{
    HRESULT GetByteRanges(uint* pcRanges, char* ppRanges);
    HRESULT SetCacheLimit(ulong qwBytes);
    HRESULT IsBackgroundTransferActive(int* pfActive);
}

const GUID IID_IMFNetCredential = {0x5B87EF6A, 0x7ED8, 0x434F, [0xBA, 0x0E, 0x18, 0x4F, 0xAC, 0x16, 0x28, 0xD1]};
@GUID(0x5B87EF6A, 0x7ED8, 0x434F, [0xBA, 0x0E, 0x18, 0x4F, 0xAC, 0x16, 0x28, 0xD1]);
interface IMFNetCredential : IUnknown
{
    HRESULT SetUser(char* pbData, uint cbData, BOOL fDataIsEncrypted);
    HRESULT SetPassword(char* pbData, uint cbData, BOOL fDataIsEncrypted);
    HRESULT GetUser(char* pbData, uint* pcbData, BOOL fEncryptData);
    HRESULT GetPassword(char* pbData, uint* pcbData, BOOL fEncryptData);
    HRESULT LoggedOnUser(int* pfLoggedOnUser);
}

struct MFNetCredentialManagerGetParam
{
    HRESULT hrOp;
    BOOL fAllowLoggedOnUser;
    BOOL fClearTextPackage;
    const(wchar)* pszUrl;
    const(wchar)* pszSite;
    const(wchar)* pszRealm;
    const(wchar)* pszPackage;
    int nRetries;
}

const GUID IID_IMFNetCredentialManager = {0x5B87EF6B, 0x7ED8, 0x434F, [0xBA, 0x0E, 0x18, 0x4F, 0xAC, 0x16, 0x28, 0xD1]};
@GUID(0x5B87EF6B, 0x7ED8, 0x434F, [0xBA, 0x0E, 0x18, 0x4F, 0xAC, 0x16, 0x28, 0xD1]);
interface IMFNetCredentialManager : IUnknown
{
    HRESULT BeginGetCredentials(MFNetCredentialManagerGetParam* pParam, IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndGetCredentials(IMFAsyncResult pResult, IMFNetCredential* ppCred);
    HRESULT SetGood(IMFNetCredential pCred, BOOL fGood);
}

enum MFNetCredentialRequirements
{
    REQUIRE_PROMPT = 1,
    REQUIRE_SAVE_SELECTED = 2,
}

enum MFNetCredentialOptions
{
    MFNET_CREDENTIAL_SAVE = 1,
    MFNET_CREDENTIAL_DONT_CACHE = 2,
    MFNET_CREDENTIAL_ALLOW_CLEAR_TEXT = 4,
}

enum MFNetAuthenticationFlags
{
    MFNET_AUTHENTICATION_PROXY = 1,
    MFNET_AUTHENTICATION_CLEAR_TEXT = 2,
    MFNET_AUTHENTICATION_LOGGED_ON_USER = 4,
}

const GUID IID_IMFNetCredentialCache = {0x5B87EF6C, 0x7ED8, 0x434F, [0xBA, 0x0E, 0x18, 0x4F, 0xAC, 0x16, 0x28, 0xD1]};
@GUID(0x5B87EF6C, 0x7ED8, 0x434F, [0xBA, 0x0E, 0x18, 0x4F, 0xAC, 0x16, 0x28, 0xD1]);
interface IMFNetCredentialCache : IUnknown
{
    HRESULT GetCredential(const(wchar)* pszUrl, const(wchar)* pszRealm, uint dwAuthenticationFlags, IMFNetCredential* ppCred, uint* pdwRequirementsFlags);
    HRESULT SetGood(IMFNetCredential pCred, BOOL fGood);
    HRESULT SetUserOptions(IMFNetCredential pCred, uint dwOptionsFlags);
}

const GUID IID_IMFSSLCertificateManager = {0x61F7D887, 0x1230, 0x4A8B, [0xAE, 0xBA, 0x8A, 0xD4, 0x34, 0xD1, 0xA6, 0x4D]};
@GUID(0x61F7D887, 0x1230, 0x4A8B, [0xAE, 0xBA, 0x8A, 0xD4, 0x34, 0xD1, 0xA6, 0x4D]);
interface IMFSSLCertificateManager : IUnknown
{
    HRESULT GetClientCertificate(const(wchar)* pszURL, ubyte** ppbData, uint* pcbData);
    HRESULT BeginGetClientCertificate(const(wchar)* pszURL, IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndGetClientCertificate(IMFAsyncResult pResult, ubyte** ppbData, uint* pcbData);
    HRESULT GetCertificatePolicy(const(wchar)* pszURL, int* pfOverrideAutomaticCheck, int* pfClientCertificateAvailable);
    HRESULT OnServerCertificate(const(wchar)* pszURL, char* pbData, uint cbData, int* pfIsGood);
}

const GUID IID_IMFNetResourceFilter = {0x091878A3, 0xBF11, 0x4A5C, [0xBC, 0x9F, 0x33, 0x99, 0x5B, 0x06, 0xEF, 0x2D]};
@GUID(0x091878A3, 0xBF11, 0x4A5C, [0xBC, 0x9F, 0x33, 0x99, 0x5B, 0x06, 0xEF, 0x2D]);
interface IMFNetResourceFilter : IUnknown
{
    HRESULT OnRedirect(const(wchar)* pszUrl, short* pvbCancel);
    HRESULT OnSendingRequest(const(wchar)* pszUrl);
}

const GUID IID_IMFSourceOpenMonitor = {0x059054B3, 0x027C, 0x494C, [0xA2, 0x7D, 0x91, 0x13, 0x29, 0x1C, 0xF8, 0x7F]};
@GUID(0x059054B3, 0x027C, 0x494C, [0xA2, 0x7D, 0x91, 0x13, 0x29, 0x1C, 0xF8, 0x7F]);
interface IMFSourceOpenMonitor : IUnknown
{
    HRESULT OnSourceEvent(IMFMediaEvent pEvent);
}

const GUID IID_IMFNetProxyLocator = {0xE9CD0383, 0xA268, 0x4BB4, [0x82, 0xDE, 0x65, 0x8D, 0x53, 0x57, 0x4D, 0x41]};
@GUID(0xE9CD0383, 0xA268, 0x4BB4, [0x82, 0xDE, 0x65, 0x8D, 0x53, 0x57, 0x4D, 0x41]);
interface IMFNetProxyLocator : IUnknown
{
    HRESULT FindFirstProxy(const(wchar)* pszHost, const(wchar)* pszUrl, BOOL fReserved);
    HRESULT FindNextProxy();
    HRESULT RegisterProxyResult(HRESULT hrOp);
    HRESULT GetCurrentProxy(const(wchar)* pszStr, uint* pcchStr);
    HRESULT Clone(IMFNetProxyLocator* ppProxyLocator);
}

const GUID IID_IMFNetProxyLocatorFactory = {0xE9CD0384, 0xA268, 0x4BB4, [0x82, 0xDE, 0x65, 0x8D, 0x53, 0x57, 0x4D, 0x41]};
@GUID(0xE9CD0384, 0xA268, 0x4BB4, [0x82, 0xDE, 0x65, 0x8D, 0x53, 0x57, 0x4D, 0x41]);
interface IMFNetProxyLocatorFactory : IUnknown
{
    HRESULT CreateProxyLocator(const(wchar)* pszProtocol, IMFNetProxyLocator* ppProxyLocator);
}

const GUID IID_IMFSaveJob = {0xE9931663, 0x80BF, 0x4C6E, [0x98, 0xAF, 0x5D, 0xCF, 0x58, 0x74, 0x7D, 0x1F]};
@GUID(0xE9931663, 0x80BF, 0x4C6E, [0x98, 0xAF, 0x5D, 0xCF, 0x58, 0x74, 0x7D, 0x1F]);
interface IMFSaveJob : IUnknown
{
    HRESULT BeginSave(IMFByteStream pStream, IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndSave(IMFAsyncResult pResult);
    HRESULT CancelSave();
    HRESULT GetProgress(uint* pdwPercentComplete);
}

enum MFNETSOURCE_PROTOCOL_TYPE
{
    MFNETSOURCE_UNDEFINED = 0,
    MFNETSOURCE_HTTP = 1,
    MFNETSOURCE_RTSP = 2,
    MFNETSOURCE_FILE = 3,
    MFNETSOURCE_MULTICAST = 4,
}

const GUID IID_IMFNetSchemeHandlerConfig = {0x7BE19E73, 0xC9BF, 0x468A, [0xAC, 0x5A, 0xA5, 0xE8, 0x65, 0x3B, 0xEC, 0x87]};
@GUID(0x7BE19E73, 0xC9BF, 0x468A, [0xAC, 0x5A, 0xA5, 0xE8, 0x65, 0x3B, 0xEC, 0x87]);
interface IMFNetSchemeHandlerConfig : IUnknown
{
    HRESULT GetNumberOfSupportedProtocols(uint* pcProtocols);
    HRESULT GetSupportedProtocolType(uint nProtocolIndex, MFNETSOURCE_PROTOCOL_TYPE* pnProtocolType);
    HRESULT ResetProtocolRolloverSettings();
}

enum MFNETSOURCE_TRANSPORT_TYPE
{
    MFNETSOURCE_UDP = 0,
    MFNETSOURCE_TCP = 1,
}

enum MFNETSOURCE_CACHE_STATE
{
    MFNETSOURCE_CACHE_UNAVAILABLE = 0,
    MFNETSOURCE_CACHE_ACTIVE_WRITING = 1,
    MFNETSOURCE_CACHE_ACTIVE_COMPLETE = 2,
}

enum MFNETSOURCE_STATISTICS_IDS
{
    MFNETSOURCE_RECVPACKETS_ID = 0,
    MFNETSOURCE_LOSTPACKETS_ID = 1,
    MFNETSOURCE_RESENDSREQUESTED_ID = 2,
    MFNETSOURCE_RESENDSRECEIVED_ID = 3,
    MFNETSOURCE_RECOVEREDBYECCPACKETS_ID = 4,
    MFNETSOURCE_RECOVEREDBYRTXPACKETS_ID = 5,
    MFNETSOURCE_OUTPACKETS_ID = 6,
    MFNETSOURCE_RECVRATE_ID = 7,
    MFNETSOURCE_AVGBANDWIDTHBPS_ID = 8,
    MFNETSOURCE_BYTESRECEIVED_ID = 9,
    MFNETSOURCE_PROTOCOL_ID = 10,
    MFNETSOURCE_TRANSPORT_ID = 11,
    MFNETSOURCE_CACHE_STATE_ID = 12,
    MFNETSOURCE_LINKBANDWIDTH_ID = 13,
    MFNETSOURCE_CONTENTBITRATE_ID = 14,
    MFNETSOURCE_SPEEDFACTOR_ID = 15,
    MFNETSOURCE_BUFFERSIZE_ID = 16,
    MFNETSOURCE_BUFFERPROGRESS_ID = 17,
    MFNETSOURCE_LASTBWSWITCHTS_ID = 18,
    MFNETSOURCE_SEEKRANGESTART_ID = 19,
    MFNETSOURCE_SEEKRANGEEND_ID = 20,
    MFNETSOURCE_BUFFERINGCOUNT_ID = 21,
    MFNETSOURCE_INCORRECTLYSIGNEDPACKETS_ID = 22,
    MFNETSOURCE_SIGNEDSESSION_ID = 23,
    MFNETSOURCE_MAXBITRATE_ID = 24,
    MFNETSOURCE_RECEPTION_QUALITY_ID = 25,
    MFNETSOURCE_RECOVEREDPACKETS_ID = 26,
    MFNETSOURCE_VBR_ID = 27,
    MFNETSOURCE_DOWNLOADPROGRESS_ID = 28,
    MFNETSOURCE_UNPREDEFINEDPROTOCOLNAME_ID = 29,
}

enum MFNET_PROXYSETTINGS
{
    MFNET_PROXYSETTING_NONE = 0,
    MFNET_PROXYSETTING_MANUAL = 1,
    MFNET_PROXYSETTING_AUTO = 2,
    MFNET_PROXYSETTING_BROWSER = 3,
}

const GUID IID_IMFSchemeHandler = {0x6D4C7B74, 0x52A0, 0x4BB7, [0xB0, 0xDB, 0x55, 0xF2, 0x9F, 0x47, 0xA6, 0x68]};
@GUID(0x6D4C7B74, 0x52A0, 0x4BB7, [0xB0, 0xDB, 0x55, 0xF2, 0x9F, 0x47, 0xA6, 0x68]);
interface IMFSchemeHandler : IUnknown
{
    HRESULT BeginCreateObject(const(wchar)* pwszURL, uint dwFlags, IPropertyStore pProps, IUnknown* ppIUnknownCancelCookie, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndCreateObject(IMFAsyncResult pResult, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT CancelObjectCreation(IUnknown pIUnknownCancelCookie);
}

const GUID IID_IMFByteStreamHandler = {0xBB420AA4, 0x765B, 0x4A1F, [0x91, 0xFE, 0xD6, 0xA8, 0xA1, 0x43, 0x92, 0x4C]};
@GUID(0xBB420AA4, 0x765B, 0x4A1F, [0x91, 0xFE, 0xD6, 0xA8, 0xA1, 0x43, 0x92, 0x4C]);
interface IMFByteStreamHandler : IUnknown
{
    HRESULT BeginCreateObject(IMFByteStream pByteStream, const(wchar)* pwszURL, uint dwFlags, IPropertyStore pProps, IUnknown* ppIUnknownCancelCookie, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndCreateObject(IMFAsyncResult pResult, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT CancelObjectCreation(IUnknown pIUnknownCancelCookie);
    HRESULT GetMaxNumberOfBytesRequiredForResolution(ulong* pqwBytes);
}

const GUID IID_IMFTrustedInput = {0x542612C4, 0xA1B8, 0x4632, [0xB5, 0x21, 0xDE, 0x11, 0xEA, 0x64, 0xA0, 0xB0]};
@GUID(0x542612C4, 0xA1B8, 0x4632, [0xB5, 0x21, 0xDE, 0x11, 0xEA, 0x64, 0xA0, 0xB0]);
interface IMFTrustedInput : IUnknown
{
    HRESULT GetInputTrustAuthority(uint dwStreamID, const(Guid)* riid, IUnknown* ppunkObject);
}

enum MFPOLICYMANAGER_ACTION
{
    PEACTION_NO = 0,
    PEACTION_PLAY = 1,
    PEACTION_COPY = 2,
    PEACTION_EXPORT = 3,
    PEACTION_EXTRACT = 4,
    PEACTION_RESERVED1 = 5,
    PEACTION_RESERVED2 = 6,
    PEACTION_RESERVED3 = 7,
    PEACTION_LAST = 7,
}

struct MFINPUTTRUSTAUTHORITY_ACCESS_ACTION
{
    MFPOLICYMANAGER_ACTION Action;
    ubyte* pbTicket;
    uint cbTicket;
}

struct MFINPUTTRUSTAUTHORITY_ACCESS_PARAMS
{
    uint dwSize;
    uint dwVer;
    uint cbSignatureOffset;
    uint cbSignatureSize;
    uint cbExtensionOffset;
    uint cbExtensionSize;
    uint cActions;
    MFINPUTTRUSTAUTHORITY_ACCESS_ACTION rgOutputActions;
}

const GUID IID_IMFInputTrustAuthority = {0xD19F8E98, 0xB126, 0x4446, [0x89, 0x0C, 0x5D, 0xCB, 0x7A, 0xD7, 0x14, 0x53]};
@GUID(0xD19F8E98, 0xB126, 0x4446, [0x89, 0x0C, 0x5D, 0xCB, 0x7A, 0xD7, 0x14, 0x53]);
interface IMFInputTrustAuthority : IUnknown
{
    HRESULT GetDecrypter(const(Guid)* riid, void** ppv);
    HRESULT RequestAccess(MFPOLICYMANAGER_ACTION Action, IMFActivate* ppContentEnablerActivate);
    HRESULT GetPolicy(MFPOLICYMANAGER_ACTION Action, IMFOutputPolicy* ppPolicy);
    HRESULT BindAccess(MFINPUTTRUSTAUTHORITY_ACCESS_PARAMS* pParam);
    HRESULT UpdateAccess(MFINPUTTRUSTAUTHORITY_ACCESS_PARAMS* pParam);
    HRESULT Reset();
}

const GUID IID_IMFTrustedOutput = {0xD19F8E95, 0xB126, 0x4446, [0x89, 0x0C, 0x5D, 0xCB, 0x7A, 0xD7, 0x14, 0x53]};
@GUID(0xD19F8E95, 0xB126, 0x4446, [0x89, 0x0C, 0x5D, 0xCB, 0x7A, 0xD7, 0x14, 0x53]);
interface IMFTrustedOutput : IUnknown
{
    HRESULT GetOutputTrustAuthorityCount(uint* pcOutputTrustAuthorities);
    HRESULT GetOutputTrustAuthorityByIndex(uint dwIndex, IMFOutputTrustAuthority* ppauthority);
    HRESULT IsFinal(int* pfIsFinal);
}

const GUID IID_IMFOutputTrustAuthority = {0xD19F8E94, 0xB126, 0x4446, [0x89, 0x0C, 0x5D, 0xCB, 0x7A, 0xD7, 0x14, 0x53]};
@GUID(0xD19F8E94, 0xB126, 0x4446, [0x89, 0x0C, 0x5D, 0xCB, 0x7A, 0xD7, 0x14, 0x53]);
interface IMFOutputTrustAuthority : IUnknown
{
    HRESULT GetAction(MFPOLICYMANAGER_ACTION* pAction);
    HRESULT SetPolicy(char* ppPolicy, uint nPolicy, ubyte** ppbTicket, uint* pcbTicket);
}

const GUID IID_IMFOutputPolicy = {0x7F00F10A, 0xDAED, 0x41AF, [0xAB, 0x26, 0x5F, 0xDF, 0xA4, 0xDF, 0xBA, 0x3C]};
@GUID(0x7F00F10A, 0xDAED, 0x41AF, [0xAB, 0x26, 0x5F, 0xDF, 0xA4, 0xDF, 0xBA, 0x3C]);
interface IMFOutputPolicy : IMFAttributes
{
    HRESULT GenerateRequiredSchemas(uint dwAttributes, Guid guidOutputSubType, Guid* rgGuidProtectionSchemasSupported, uint cProtectionSchemasSupported, IMFCollection* ppRequiredProtectionSchemas);
    HRESULT GetOriginatorID(Guid* pguidOriginatorID);
    HRESULT GetMinimumGRLVersion(uint* pdwMinimumGRLVersion);
}

const GUID IID_IMFOutputSchema = {0x7BE0FC5B, 0xABD9, 0x44FB, [0xA5, 0xC8, 0xF5, 0x01, 0x36, 0xE7, 0x15, 0x99]};
@GUID(0x7BE0FC5B, 0xABD9, 0x44FB, [0xA5, 0xC8, 0xF5, 0x01, 0x36, 0xE7, 0x15, 0x99]);
interface IMFOutputSchema : IMFAttributes
{
    HRESULT GetSchemaType(Guid* pguidSchemaType);
    HRESULT GetConfigurationData(uint* pdwVal);
    HRESULT GetOriginatorID(Guid* pguidOriginatorID);
}

enum MF_OPM_CGMSA_PROTECTION_LEVEL
{
    MF_OPM_CGMSA_OFF = 0,
    MF_OPM_CGMSA_COPY_FREELY = 1,
    MF_OPM_CGMSA_COPY_NO_MORE = 2,
    MF_OPM_CGMSA_COPY_ONE_GENERATION = 3,
    MF_OPM_CGMSA_COPY_NEVER = 4,
    MF_OPM_CGMSA_REDISTRIBUTION_CONTROL_REQUIRED = 8,
}

enum MF_OPM_ACP_PROTECTION_LEVEL
{
    MF_OPM_ACP_OFF = 0,
    MF_OPM_ACP_LEVEL_ONE = 1,
    MF_OPM_ACP_LEVEL_TWO = 2,
    MF_OPM_ACP_LEVEL_THREE = 3,
    MF_OPM_ACP_FORCE_ULONG = 2147483647,
}

enum MFAudioConstriction
{
    MFaudioConstrictionOff = 0,
    MFaudioConstriction48_16 = 1,
    MFaudioConstriction44_16 = 2,
    MFaudioConstriction14_14 = 3,
    MFaudioConstrictionMute = 4,
}

const GUID IID_IMFSecureChannel = {0xD0AE555D, 0x3B12, 0x4D97, [0xB0, 0x60, 0x09, 0x90, 0xBC, 0x5A, 0xEB, 0x67]};
@GUID(0xD0AE555D, 0x3B12, 0x4D97, [0xB0, 0x60, 0x09, 0x90, 0xBC, 0x5A, 0xEB, 0x67]);
interface IMFSecureChannel : IUnknown
{
    HRESULT GetCertificate(ubyte** ppCert, uint* pcbCert);
    HRESULT SetupSession(char* pbEncryptedSessionKey, uint cbSessionKey);
}

enum SAMPLE_PROTECTION_VERSION
{
    SAMPLE_PROTECTION_VERSION_NO = 0,
    SAMPLE_PROTECTION_VERSION_BASIC_LOKI = 1,
    SAMPLE_PROTECTION_VERSION_SCATTER = 2,
    SAMPLE_PROTECTION_VERSION_RC4 = 3,
    SAMPLE_PROTECTION_VERSION_AES128CTR = 4,
}

const GUID IID_IMFSampleProtection = {0x8E36395F, 0xC7B9, 0x43C4, [0xA5, 0x4D, 0x51, 0x2B, 0x4A, 0xF6, 0x3C, 0x95]};
@GUID(0x8E36395F, 0xC7B9, 0x43C4, [0xA5, 0x4D, 0x51, 0x2B, 0x4A, 0xF6, 0x3C, 0x95]);
interface IMFSampleProtection : IUnknown
{
    HRESULT GetInputProtectionVersion(uint* pdwVersion);
    HRESULT GetOutputProtectionVersion(uint* pdwVersion);
    HRESULT GetProtectionCertificate(uint dwVersion, ubyte** ppCert, uint* pcbCert);
    HRESULT InitOutputProtection(uint dwVersion, uint dwOutputId, ubyte* pbCert, uint cbCert, ubyte** ppbSeed, uint* pcbSeed);
    HRESULT InitInputProtection(uint dwVersion, uint dwInputId, ubyte* pbSeed, uint cbSeed);
}

const GUID IID_IMFMediaSinkPreroll = {0x5DFD4B2A, 0x7674, 0x4110, [0xA4, 0xE6, 0x8A, 0x68, 0xFD, 0x5F, 0x36, 0x88]};
@GUID(0x5DFD4B2A, 0x7674, 0x4110, [0xA4, 0xE6, 0x8A, 0x68, 0xFD, 0x5F, 0x36, 0x88]);
interface IMFMediaSinkPreroll : IUnknown
{
    HRESULT NotifyPreroll(long hnsUpcomingStartTime);
}

const GUID IID_IMFFinalizableMediaSink = {0xEAECB74A, 0x9A50, 0x42CE, [0x95, 0x41, 0x6A, 0x7F, 0x57, 0xAA, 0x4A, 0xD7]};
@GUID(0xEAECB74A, 0x9A50, 0x42CE, [0x95, 0x41, 0x6A, 0x7F, 0x57, 0xAA, 0x4A, 0xD7]);
interface IMFFinalizableMediaSink : IMFMediaSink
{
    HRESULT BeginFinalize(IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndFinalize(IMFAsyncResult pResult);
}

const GUID IID_IMFStreamingSinkConfig = {0x9DB7AA41, 0x3CC5, 0x40D4, [0x85, 0x09, 0x55, 0x58, 0x04, 0xAD, 0x34, 0xCC]};
@GUID(0x9DB7AA41, 0x3CC5, 0x40D4, [0x85, 0x09, 0x55, 0x58, 0x04, 0xAD, 0x34, 0xCC]);
interface IMFStreamingSinkConfig : IUnknown
{
    HRESULT StartStreaming(BOOL fSeekOffsetIsByteOffset, ulong qwSeekOffset);
}

const GUID IID_IMFRemoteProxy = {0x994E23AD, 0x1CC2, 0x493C, [0xB9, 0xFA, 0x46, 0xF1, 0xCB, 0x04, 0x0F, 0xA4]};
@GUID(0x994E23AD, 0x1CC2, 0x493C, [0xB9, 0xFA, 0x46, 0xF1, 0xCB, 0x04, 0x0F, 0xA4]);
interface IMFRemoteProxy : IUnknown
{
    HRESULT GetRemoteObject(const(Guid)* riid, void** ppv);
    HRESULT GetRemoteHost(const(Guid)* riid, void** ppv);
}

const GUID IID_IMFObjectReferenceStream = {0x09EF5BE3, 0xC8A7, 0x469E, [0x8B, 0x70, 0x73, 0xBF, 0x25, 0xBB, 0x19, 0x3F]};
@GUID(0x09EF5BE3, 0xC8A7, 0x469E, [0x8B, 0x70, 0x73, 0xBF, 0x25, 0xBB, 0x19, 0x3F]);
interface IMFObjectReferenceStream : IUnknown
{
    HRESULT SaveReference(const(Guid)* riid, IUnknown pUnk);
    HRESULT LoadReference(const(Guid)* riid, void** ppv);
}

const GUID IID_IMFPMPHost = {0xF70CA1A9, 0xFDC7, 0x4782, [0xB9, 0x94, 0xAD, 0xFF, 0xB1, 0xC9, 0x86, 0x06]};
@GUID(0xF70CA1A9, 0xFDC7, 0x4782, [0xB9, 0x94, 0xAD, 0xFF, 0xB1, 0xC9, 0x86, 0x06]);
interface IMFPMPHost : IUnknown
{
    HRESULT LockProcess();
    HRESULT UnlockProcess();
    HRESULT CreateObjectByCLSID(const(Guid)* clsid, IStream pStream, const(Guid)* riid, void** ppv);
}

const GUID IID_IMFPMPClient = {0x6C4E655D, 0xEAD8, 0x4421, [0xB6, 0xB9, 0x54, 0xDC, 0xDB, 0xBD, 0xF8, 0x20]};
@GUID(0x6C4E655D, 0xEAD8, 0x4421, [0xB6, 0xB9, 0x54, 0xDC, 0xDB, 0xBD, 0xF8, 0x20]);
interface IMFPMPClient : IUnknown
{
    HRESULT SetPMPHost(IMFPMPHost pPMPHost);
}

const GUID IID_IMFPMPServer = {0x994E23AF, 0x1CC2, 0x493C, [0xB9, 0xFA, 0x46, 0xF1, 0xCB, 0x04, 0x0F, 0xA4]};
@GUID(0x994E23AF, 0x1CC2, 0x493C, [0xB9, 0xFA, 0x46, 0xF1, 0xCB, 0x04, 0x0F, 0xA4]);
interface IMFPMPServer : IUnknown
{
    HRESULT LockProcess();
    HRESULT UnlockProcess();
    HRESULT CreateObjectByCLSID(const(Guid)* clsid, const(Guid)* riid, void** ppObject);
}

const GUID IID_IMFRemoteDesktopPlugin = {0x1CDE6309, 0xCAE0, 0x4940, [0x90, 0x7E, 0xC1, 0xEC, 0x9C, 0x3D, 0x1D, 0x4A]};
@GUID(0x1CDE6309, 0xCAE0, 0x4940, [0x90, 0x7E, 0xC1, 0xEC, 0x9C, 0x3D, 0x1D, 0x4A]);
interface IMFRemoteDesktopPlugin : IUnknown
{
    HRESULT UpdateTopology(IMFTopology pTopology);
}

const GUID IID_IMFSAMIStyle = {0xA7E025DD, 0x5303, 0x4A62, [0x89, 0xD6, 0xE7, 0x47, 0xE1, 0xEF, 0xAC, 0x73]};
@GUID(0xA7E025DD, 0x5303, 0x4A62, [0x89, 0xD6, 0xE7, 0x47, 0xE1, 0xEF, 0xAC, 0x73]);
interface IMFSAMIStyle : IUnknown
{
    HRESULT GetStyleCount(uint* pdwCount);
    HRESULT GetStyles(PROPVARIANT* pPropVarStyleArray);
    HRESULT SetSelectedStyle(const(wchar)* pwszStyle);
    HRESULT GetSelectedStyle(ushort** ppwszStyle);
}

const GUID IID_IMFTranscodeProfile = {0x4ADFDBA3, 0x7AB0, 0x4953, [0xA6, 0x2B, 0x46, 0x1E, 0x7F, 0xF3, 0xDA, 0x1E]};
@GUID(0x4ADFDBA3, 0x7AB0, 0x4953, [0xA6, 0x2B, 0x46, 0x1E, 0x7F, 0xF3, 0xDA, 0x1E]);
interface IMFTranscodeProfile : IUnknown
{
    HRESULT SetAudioAttributes(IMFAttributes pAttrs);
    HRESULT GetAudioAttributes(IMFAttributes* ppAttrs);
    HRESULT SetVideoAttributes(IMFAttributes pAttrs);
    HRESULT GetVideoAttributes(IMFAttributes* ppAttrs);
    HRESULT SetContainerAttributes(IMFAttributes pAttrs);
    HRESULT GetContainerAttributes(IMFAttributes* ppAttrs);
}

enum MF_TRANSCODE_TOPOLOGYMODE_FLAGS
{
    MF_TRANSCODE_TOPOLOGYMODE_SOFTWARE_ONLY = 0,
    MF_TRANSCODE_TOPOLOGYMODE_HARDWARE_ALLOWED = 1,
}

enum MF_TRANSCODE_ADJUST_PROFILE_FLAGS
{
    MF_TRANSCODE_ADJUST_PROFILE_DEFAULT = 0,
    MF_TRANSCODE_ADJUST_PROFILE_USE_SOURCE_ATTRIBUTES = 1,
}

enum MF_VIDEO_PROCESSOR_ALGORITHM_TYPE
{
    MF_VIDEO_PROCESSOR_ALGORITHM_DEFAULT = 0,
    MF_VIDEO_PROCESSOR_ALGORITHM_MRF_CRF_444 = 1,
}

struct MF_TRANSCODE_SINK_INFO
{
    uint dwVideoStreamID;
    IMFMediaType pVideoMediaType;
    uint dwAudioStreamID;
    IMFMediaType pAudioMediaType;
}

const GUID IID_IMFTranscodeSinkInfoProvider = {0x8CFFCD2E, 0x5A03, 0x4A3A, [0xAF, 0xF7, 0xED, 0xCD, 0x10, 0x7C, 0x62, 0x0E]};
@GUID(0x8CFFCD2E, 0x5A03, 0x4A3A, [0xAF, 0xF7, 0xED, 0xCD, 0x10, 0x7C, 0x62, 0x0E]);
interface IMFTranscodeSinkInfoProvider : IUnknown
{
    HRESULT SetOutputFile(const(wchar)* pwszFileName);
    HRESULT SetOutputByteStream(IMFActivate pByteStreamActivate);
    HRESULT SetProfile(IMFTranscodeProfile pProfile);
    HRESULT GetSinkInfo(MF_TRANSCODE_SINK_INFO* pSinkInfo);
}

const GUID IID_IMFFieldOfUseMFTUnlock = {0x508E71D3, 0xEC66, 0x4FC3, [0x87, 0x75, 0xB4, 0xB9, 0xED, 0x6B, 0xA8, 0x47]};
@GUID(0x508E71D3, 0xEC66, 0x4FC3, [0x87, 0x75, 0xB4, 0xB9, 0xED, 0x6B, 0xA8, 0x47]);
interface IMFFieldOfUseMFTUnlock : IUnknown
{
    HRESULT Unlock(IUnknown pUnkMFT);
}

struct MFT_REGISTRATION_INFO
{
    Guid clsid;
    Guid guidCategory;
    uint uiFlags;
    const(wchar)* pszName;
    uint cInTypes;
    MFT_REGISTER_TYPE_INFO* pInTypes;
    uint cOutTypes;
    MFT_REGISTER_TYPE_INFO* pOutTypes;
}

const GUID IID_IMFLocalMFTRegistration = {0x149C4D73, 0xB4BE, 0x4F8D, [0x8B, 0x87, 0x07, 0x9E, 0x92, 0x6B, 0x6A, 0xDD]};
@GUID(0x149C4D73, 0xB4BE, 0x4F8D, [0x8B, 0x87, 0x07, 0x9E, 0x92, 0x6B, 0x6A, 0xDD]);
interface IMFLocalMFTRegistration : IUnknown
{
    HRESULT RegisterMFTs(char* pMFTs, uint cMFTs);
}

const GUID IID_IMFCapturePhotoConfirmation = {0x19F68549, 0xCA8A, 0x4706, [0xA4, 0xEF, 0x48, 0x1D, 0xBC, 0x95, 0xE1, 0x2C]};
@GUID(0x19F68549, 0xCA8A, 0x4706, [0xA4, 0xEF, 0x48, 0x1D, 0xBC, 0x95, 0xE1, 0x2C]);
interface IMFCapturePhotoConfirmation : IUnknown
{
    HRESULT SetPhotoConfirmationCallback(IMFAsyncCallback pNotificationCallback);
    HRESULT SetPixelFormat(Guid subtype);
    HRESULT GetPixelFormat(Guid* subtype);
}

const GUID IID_IMFPMPHostApp = {0x84D2054A, 0x3AA1, 0x4728, [0xA3, 0xB0, 0x44, 0x0A, 0x41, 0x8C, 0xF4, 0x9C]};
@GUID(0x84D2054A, 0x3AA1, 0x4728, [0xA3, 0xB0, 0x44, 0x0A, 0x41, 0x8C, 0xF4, 0x9C]);
interface IMFPMPHostApp : IUnknown
{
    HRESULT LockProcess();
    HRESULT UnlockProcess();
    HRESULT ActivateClassById(const(wchar)* id, IStream pStream, const(Guid)* riid, void** ppv);
}

const GUID IID_IMFPMPClientApp = {0xC004F646, 0xBE2C, 0x48F3, [0x93, 0xA2, 0xA0, 0x98, 0x3E, 0xBA, 0x11, 0x08]};
@GUID(0xC004F646, 0xBE2C, 0x48F3, [0x93, 0xA2, 0xA0, 0x98, 0x3E, 0xBA, 0x11, 0x08]);
interface IMFPMPClientApp : IUnknown
{
    HRESULT SetPMPHost(IMFPMPHostApp pPMPHost);
}

const GUID IID_IMFMediaStreamSourceSampleRequest = {0x380B9AF9, 0xA85B, 0x4E78, [0xA2, 0xAF, 0xEA, 0x5C, 0xE6, 0x45, 0xC6, 0xB4]};
@GUID(0x380B9AF9, 0xA85B, 0x4E78, [0xA2, 0xAF, 0xEA, 0x5C, 0xE6, 0x45, 0xC6, 0xB4]);
interface IMFMediaStreamSourceSampleRequest : IUnknown
{
    HRESULT SetSample(IMFSample value);
}

const GUID IID_IMFTrackedSample = {0x245BF8E9, 0x0755, 0x40F7, [0x88, 0xA5, 0xAE, 0x0F, 0x18, 0xD5, 0x5E, 0x17]};
@GUID(0x245BF8E9, 0x0755, 0x40F7, [0x88, 0xA5, 0xAE, 0x0F, 0x18, 0xD5, 0x5E, 0x17]);
interface IMFTrackedSample : IUnknown
{
    HRESULT SetAllocator(IMFAsyncCallback pSampleAllocator, IUnknown pUnkState);
}

const GUID IID_IMFProtectedEnvironmentAccess = {0xEF5DC845, 0xF0D9, 0x4EC9, [0xB0, 0x0C, 0xCB, 0x51, 0x83, 0xD3, 0x84, 0x34]};
@GUID(0xEF5DC845, 0xF0D9, 0x4EC9, [0xB0, 0x0C, 0xCB, 0x51, 0x83, 0xD3, 0x84, 0x34]);
interface IMFProtectedEnvironmentAccess : IUnknown
{
    HRESULT Call(uint inputLength, char* input, uint outputLength, char* output);
    HRESULT ReadGRL(uint* outputLength, ubyte** output);
}

const GUID IID_IMFSignedLibrary = {0x4A724BCA, 0xFF6A, 0x4C07, [0x8E, 0x0D, 0x7A, 0x35, 0x84, 0x21, 0xCF, 0x06]};
@GUID(0x4A724BCA, 0xFF6A, 0x4C07, [0x8E, 0x0D, 0x7A, 0x35, 0x84, 0x21, 0xCF, 0x06]);
interface IMFSignedLibrary : IUnknown
{
    HRESULT GetProcedureAddress(const(char)* name, void** address);
}

const GUID IID_IMFSystemId = {0xFFF4AF3A, 0x1FC1, 0x4EF9, [0xA2, 0x9B, 0xD2, 0x6C, 0x49, 0xE2, 0xF3, 0x1A]};
@GUID(0xFFF4AF3A, 0x1FC1, 0x4EF9, [0xA2, 0x9B, 0xD2, 0x6C, 0x49, 0xE2, 0xF3, 0x1A]);
interface IMFSystemId : IUnknown
{
    HRESULT GetData(uint* size, ubyte** data);
    HRESULT Setup(uint stage, uint cbIn, char* pbIn, uint* pcbOut, ubyte** ppbOut);
}

struct MFCONTENTPROTECTIONDEVICE_INPUT_DATA
{
    uint HWProtectionFunctionID;
    uint PrivateDataByteCount;
    uint HWProtectionDataByteCount;
    uint Reserved;
    ubyte InputData;
}

struct MFCONTENTPROTECTIONDEVICE_OUTPUT_DATA
{
    uint PrivateDataByteCount;
    uint MaxHWProtectionDataByteCount;
    uint HWProtectionDataByteCount;
    HRESULT Status;
    long TransportTimeInHundredsOfNanoseconds;
    long ExecutionTimeInHundredsOfNanoseconds;
    ubyte OutputData;
}

struct MFCONTENTPROTECTIONDEVICE_REALTIMECLIENT_DATA
{
    uint TaskIndex;
    ushort ClassName;
    int BasePriority;
}

const GUID IID_IMFContentProtectionDevice = {0xE6257174, 0xA060, 0x4C9A, [0xA0, 0x88, 0x3B, 0x1B, 0x47, 0x1C, 0xAD, 0x28]};
@GUID(0xE6257174, 0xA060, 0x4C9A, [0xA0, 0x88, 0x3B, 0x1B, 0x47, 0x1C, 0xAD, 0x28]);
interface IMFContentProtectionDevice : IUnknown
{
    HRESULT InvokeFunction(uint FunctionId, uint InputBufferByteCount, char* InputBuffer, uint* OutputBufferByteCount, char* OutputBuffer);
    HRESULT GetPrivateDataByteCount(uint* PrivateInputByteCount, uint* PrivateOutputByteCount);
}

const GUID IID_IMFContentDecryptorContext = {0x7EC4B1BD, 0x43FB, 0x4763, [0x85, 0xD2, 0x64, 0xFC, 0xB5, 0xC5, 0xF4, 0xCB]};
@GUID(0x7EC4B1BD, 0x43FB, 0x4763, [0x85, 0xD2, 0x64, 0xFC, 0xB5, 0xC5, 0xF4, 0xCB]);
interface IMFContentDecryptorContext : IUnknown
{
    HRESULT InitializeHardwareKey(uint InputPrivateDataByteCount, char* InputPrivateData, ulong* OutputPrivateData);
}

enum MF_MEDIAKEYSESSION_TYPE
{
    MF_MEDIAKEYSESSION_TYPE_TEMPORARY = 0,
    MF_MEDIAKEYSESSION_TYPE_PERSISTENT_LICENSE = 1,
    MF_MEDIAKEYSESSION_TYPE_PERSISTENT_RELEASE_MESSAGE = 2,
    MF_MEDIAKEYSESSION_TYPE_PERSISTENT_USAGE_RECORD = 3,
}

enum MF_MEDIAKEY_STATUS
{
    MF_MEDIAKEY_STATUS_USABLE = 0,
    MF_MEDIAKEY_STATUS_EXPIRED = 1,
    MF_MEDIAKEY_STATUS_OUTPUT_DOWNSCALED = 2,
    MF_MEDIAKEY_STATUS_OUTPUT_NOT_ALLOWED = 3,
    MF_MEDIAKEY_STATUS_STATUS_PENDING = 4,
    MF_MEDIAKEY_STATUS_INTERNAL_ERROR = 5,
    MF_MEDIAKEY_STATUS_RELEASED = 6,
    MF_MEDIAKEY_STATUS_OUTPUT_RESTRICTED = 7,
}

struct MFMediaKeyStatus
{
    ubyte* pbKeyId;
    uint cbKeyId;
    MF_MEDIAKEY_STATUS eMediaKeyStatus;
}

enum MF_MEDIAKEYSESSION_MESSAGETYPE
{
    MF_MEDIAKEYSESSION_MESSAGETYPE_LICENSE_REQUEST = 0,
    MF_MEDIAKEYSESSION_MESSAGETYPE_LICENSE_RENEWAL = 1,
    MF_MEDIAKEYSESSION_MESSAGETYPE_LICENSE_RELEASE = 2,
    MF_MEDIAKEYSESSION_MESSAGETYPE_INDIVIDUALIZATION_REQUEST = 3,
}

enum MF_CROSS_ORIGIN_POLICY
{
    MF_CROSS_ORIGIN_POLICY_NONE = 0,
    MF_CROSS_ORIGIN_POLICY_ANONYMOUS = 1,
    MF_CROSS_ORIGIN_POLICY_USE_CREDENTIALS = 2,
}

const GUID IID_IMFNetCrossOriginSupport = {0xBC2B7D44, 0xA72D, 0x49D5, [0x83, 0x76, 0x14, 0x80, 0xDE, 0xE5, 0x8B, 0x22]};
@GUID(0xBC2B7D44, 0xA72D, 0x49D5, [0x83, 0x76, 0x14, 0x80, 0xDE, 0xE5, 0x8B, 0x22]);
interface IMFNetCrossOriginSupport : IUnknown
{
    HRESULT GetCrossOriginPolicy(MF_CROSS_ORIGIN_POLICY* pPolicy);
    HRESULT GetSourceOrigin(ushort** wszSourceOrigin);
    HRESULT IsSameOrigin(const(wchar)* wszURL, int* pfIsSameOrigin);
}

const GUID IID_IMFHttpDownloadRequest = {0xF779FDDF, 0x26E7, 0x4270, [0x8A, 0x8B, 0xB9, 0x83, 0xD1, 0x85, 0x9D, 0xE0]};
@GUID(0xF779FDDF, 0x26E7, 0x4270, [0x8A, 0x8B, 0xB9, 0x83, 0xD1, 0x85, 0x9D, 0xE0]);
interface IMFHttpDownloadRequest : IUnknown
{
    HRESULT AddHeader(const(wchar)* szHeader);
    HRESULT BeginSendRequest(char* pbPayload, uint cbPayload, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndSendRequest(IMFAsyncResult pResult);
    HRESULT BeginReceiveResponse(IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndReceiveResponse(IMFAsyncResult pResult);
    HRESULT BeginReadPayload(char* pb, uint cb, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndReadPayload(IMFAsyncResult pResult, ulong* pqwOffset, uint* pcbRead);
    HRESULT QueryHeader(const(wchar)* szHeaderName, uint dwIndex, ushort** ppszHeaderValue);
    HRESULT GetURL(ushort** ppszURL);
    HRESULT HasNullSourceOrigin(int* pfNullSourceOrigin);
    HRESULT GetTimeSeekResult(ulong* pqwStartTime, ulong* pqwStopTime, ulong* pqwDuration);
    HRESULT GetHttpStatus(uint* pdwHttpStatus);
    HRESULT GetAtEndOfPayload(int* pfAtEndOfPayload);
    HRESULT GetTotalLength(ulong* pqwTotalLength);
    HRESULT GetRangeEndOffset(ulong* pqwRangeEnd);
    HRESULT Close();
}

const GUID IID_IMFHttpDownloadSession = {0x71FA9A2C, 0x53CE, 0x4662, [0xA1, 0x32, 0x1A, 0x7E, 0x8C, 0xBF, 0x62, 0xDB]};
@GUID(0x71FA9A2C, 0x53CE, 0x4662, [0xA1, 0x32, 0x1A, 0x7E, 0x8C, 0xBF, 0x62, 0xDB]);
interface IMFHttpDownloadSession : IUnknown
{
    HRESULT SetServer(const(wchar)* szServerName, uint nPort);
    HRESULT CreateRequest(const(wchar)* szObjectName, BOOL fBypassProxyCache, BOOL fSecure, const(wchar)* szVerb, const(wchar)* szReferrer, IMFHttpDownloadRequest* ppRequest);
    HRESULT Close();
}

const GUID IID_IMFHttpDownloadSessionProvider = {0x1B4CF4B9, 0x3A16, 0x4115, [0x83, 0x9D, 0x03, 0xCC, 0x5C, 0x99, 0xDF, 0x01]};
@GUID(0x1B4CF4B9, 0x3A16, 0x4115, [0x83, 0x9D, 0x03, 0xCC, 0x5C, 0x99, 0xDF, 0x01]);
interface IMFHttpDownloadSessionProvider : IUnknown
{
    HRESULT CreateHttpDownloadSession(const(wchar)* wszScheme, IMFHttpDownloadSession* ppDownloadSession);
}

struct MF_VIDEO_SPHERICAL_VIEWDIRECTION
{
    int iHeading;
    int iPitch;
    int iRoll;
}

const GUID IID_IMFMediaSource2 = {0xFBB03414, 0xD13B, 0x4786, [0x83, 0x19, 0x5A, 0xC5, 0x1F, 0xC0, 0xA1, 0x36]};
@GUID(0xFBB03414, 0xD13B, 0x4786, [0x83, 0x19, 0x5A, 0xC5, 0x1F, 0xC0, 0xA1, 0x36]);
interface IMFMediaSource2 : IMFMediaSourceEx
{
    HRESULT SetMediaType(uint dwStreamID, IMFMediaType pMediaType);
}

const GUID IID_IMFMediaStream2 = {0xC5BC37D6, 0x75C7, 0x46A1, [0xA1, 0x32, 0x81, 0xB5, 0xF7, 0x23, 0xC2, 0x0F]};
@GUID(0xC5BC37D6, 0x75C7, 0x46A1, [0xA1, 0x32, 0x81, 0xB5, 0xF7, 0x23, 0xC2, 0x0F]);
interface IMFMediaStream2 : IMFMediaStream
{
    HRESULT SetStreamState(MF_STREAM_STATE value);
    HRESULT GetStreamState(MF_STREAM_STATE* value);
}

enum MFSensorDeviceType
{
    MFSensorDeviceType_Unknown = 0,
    MFSensorDeviceType_Device = 1,
    MFSensorDeviceType_MediaSource = 2,
    MFSensorDeviceType_FrameProvider = 3,
    MFSensorDeviceType_SensorTransform = 4,
}

enum MFSensorStreamType
{
    MFSensorStreamType_Unknown = 0,
    MFSensorStreamType_Input = 1,
    MFSensorStreamType_Output = 2,
}

enum MFSensorDeviceMode
{
    MFSensorDeviceMode_Controller = 0,
    MFSensorDeviceMode_Shared = 1,
}

const GUID IID_IMFSensorDevice = {0xFB9F48F2, 0x2A18, 0x4E28, [0x97, 0x30, 0x78, 0x6F, 0x30, 0xF0, 0x4D, 0xC4]};
@GUID(0xFB9F48F2, 0x2A18, 0x4E28, [0x97, 0x30, 0x78, 0x6F, 0x30, 0xF0, 0x4D, 0xC4]);
interface IMFSensorDevice : IUnknown
{
    HRESULT GetDeviceId(ulong* pDeviceId);
    HRESULT GetDeviceType(MFSensorDeviceType* pType);
    HRESULT GetFlags(ulong* pFlags);
    HRESULT GetSymbolicLink(const(wchar)* SymbolicLink, int cchSymbolicLink, int* pcchWritten);
    HRESULT GetDeviceAttributes(IMFAttributes* ppAttributes);
    HRESULT GetStreamAttributesCount(MFSensorStreamType eType, uint* pdwCount);
    HRESULT GetStreamAttributes(MFSensorStreamType eType, uint dwIndex, IMFAttributes* ppAttributes);
    HRESULT SetSensorDeviceMode(MFSensorDeviceMode eMode);
    HRESULT GetSensorDeviceMode(MFSensorDeviceMode* peMode);
}

const GUID IID_IMFSensorGroup = {0x4110243A, 0x9757, 0x461F, [0x89, 0xF1, 0xF2, 0x23, 0x45, 0xBC, 0xAB, 0x4E]};
@GUID(0x4110243A, 0x9757, 0x461F, [0x89, 0xF1, 0xF2, 0x23, 0x45, 0xBC, 0xAB, 0x4E]);
interface IMFSensorGroup : IUnknown
{
    HRESULT GetSymbolicLink(const(wchar)* SymbolicLink, int cchSymbolicLink, int* pcchWritten);
    HRESULT GetFlags(ulong* pFlags);
    HRESULT GetSensorGroupAttributes(IMFAttributes* ppAttributes);
    HRESULT GetSensorDeviceCount(uint* pdwCount);
    HRESULT GetSensorDevice(uint dwIndex, IMFSensorDevice* ppDevice);
    HRESULT SetDefaultSensorDeviceIndex(uint dwIndex);
    HRESULT GetDefaultSensorDeviceIndex(uint* pdwIndex);
    HRESULT CreateMediaSource(IMFMediaSource* ppSource);
}

const GUID IID_IMFSensorStream = {0xE9A42171, 0xC56E, 0x498A, [0x8B, 0x39, 0xED, 0xA5, 0xA0, 0x70, 0xB7, 0xFC]};
@GUID(0xE9A42171, 0xC56E, 0x498A, [0x8B, 0x39, 0xED, 0xA5, 0xA0, 0x70, 0xB7, 0xFC]);
interface IMFSensorStream : IMFAttributes
{
    HRESULT GetMediaTypeCount(uint* pdwCount);
    HRESULT GetMediaType(uint dwIndex, IMFMediaType* ppMediaType);
    HRESULT CloneSensorStream(IMFSensorStream* ppStream);
}

const GUID IID_IMFSensorTransformFactory = {0xEED9C2EE, 0x66B4, 0x4F18, [0xA6, 0x97, 0xAC, 0x7D, 0x39, 0x60, 0x21, 0x5C]};
@GUID(0xEED9C2EE, 0x66B4, 0x4F18, [0xA6, 0x97, 0xAC, 0x7D, 0x39, 0x60, 0x21, 0x5C]);
interface IMFSensorTransformFactory : IUnknown
{
    HRESULT GetFactoryAttributes(IMFAttributes* ppAttributes);
    HRESULT InitializeFactory(uint dwMaxTransformCount, IMFCollection pSensorDevices, IMFAttributes pAttributes);
    HRESULT GetTransformCount(uint* pdwCount);
    HRESULT GetTransformInformation(uint TransformIndex, Guid* pguidTransformId, IMFAttributes* ppAttributes, IMFCollection* ppStreamInformation);
    HRESULT CreateTransform(const(Guid)* guidSensorTransformID, IMFAttributes pAttributes, IMFDeviceTransform* ppDeviceMFT);
}

struct SENSORPROFILEID
{
    Guid Type;
    uint Index;
    uint Unused;
}

const GUID IID_IMFSensorProfile = {0x22F765D1, 0x8DAB, 0x4107, [0x84, 0x6D, 0x56, 0xBA, 0xF7, 0x22, 0x15, 0xE7]};
@GUID(0x22F765D1, 0x8DAB, 0x4107, [0x84, 0x6D, 0x56, 0xBA, 0xF7, 0x22, 0x15, 0xE7]);
interface IMFSensorProfile : IUnknown
{
    HRESULT GetProfileId(SENSORPROFILEID* pId);
    HRESULT AddProfileFilter(uint StreamId, const(wchar)* wzFilterSetString);
    HRESULT IsMediaTypeSupported(uint StreamId, IMFMediaType pMediaType, int* pfSupported);
    HRESULT AddBlockedControl(const(wchar)* wzBlockedControl);
}

const GUID IID_IMFSensorProfileCollection = {0xC95EA55B, 0x0187, 0x48BE, [0x93, 0x53, 0x8D, 0x25, 0x07, 0x66, 0x23, 0x51]};
@GUID(0xC95EA55B, 0x0187, 0x48BE, [0x93, 0x53, 0x8D, 0x25, 0x07, 0x66, 0x23, 0x51]);
interface IMFSensorProfileCollection : IUnknown
{
    uint GetProfileCount();
    HRESULT GetProfile(uint Index, IMFSensorProfile* ppProfile);
    HRESULT AddProfile(IMFSensorProfile pProfile);
    HRESULT FindProfile(SENSORPROFILEID* ProfileId, IMFSensorProfile* ppProfile);
    void RemoveProfileByIndex(uint Index);
    void RemoveProfile(SENSORPROFILEID* ProfileId);
}

const GUID IID_IMFSensorProcessActivity = {0x39DC7F4A, 0xB141, 0x4719, [0x81, 0x3C, 0xA7, 0xF4, 0x61, 0x62, 0xA2, 0xB8]};
@GUID(0x39DC7F4A, 0xB141, 0x4719, [0x81, 0x3C, 0xA7, 0xF4, 0x61, 0x62, 0xA2, 0xB8]);
interface IMFSensorProcessActivity : IUnknown
{
    HRESULT GetProcessId(uint* pPID);
    HRESULT GetStreamingState(int* pfStreaming);
    HRESULT GetStreamingMode(MFSensorDeviceMode* pMode);
    HRESULT GetReportTime(FILETIME* pft);
}

const GUID IID_IMFSensorActivityReport = {0x3E8C4BE1, 0xA8C2, 0x4528, [0x90, 0xDE, 0x28, 0x51, 0xBD, 0xE5, 0xFE, 0xAD]};
@GUID(0x3E8C4BE1, 0xA8C2, 0x4528, [0x90, 0xDE, 0x28, 0x51, 0xBD, 0xE5, 0xFE, 0xAD]);
interface IMFSensorActivityReport : IUnknown
{
    HRESULT GetFriendlyName(const(wchar)* FriendlyName, uint cchFriendlyName, uint* pcchWritten);
    HRESULT GetSymbolicLink(const(wchar)* SymbolicLink, uint cchSymbolicLink, uint* pcchWritten);
    HRESULT GetProcessCount(uint* pcCount);
    HRESULT GetProcessActivity(uint Index, IMFSensorProcessActivity* ppProcessActivity);
}

const GUID IID_IMFSensorActivitiesReport = {0x683F7A5E, 0x4A19, 0x43CD, [0xB1, 0xA9, 0xDB, 0xF4, 0xAB, 0x3F, 0x77, 0x77]};
@GUID(0x683F7A5E, 0x4A19, 0x43CD, [0xB1, 0xA9, 0xDB, 0xF4, 0xAB, 0x3F, 0x77, 0x77]);
interface IMFSensorActivitiesReport : IUnknown
{
    HRESULT GetCount(uint* pcCount);
    HRESULT GetActivityReport(uint Index, IMFSensorActivityReport* sensorActivityReport);
    HRESULT GetActivityReportByDeviceName(const(wchar)* SymbolicName, IMFSensorActivityReport* sensorActivityReport);
}

const GUID IID_IMFSensorActivitiesReportCallback = {0xDE5072EE, 0xDBE3, 0x46DC, [0x8A, 0x87, 0xB6, 0xF6, 0x31, 0x19, 0x47, 0x51]};
@GUID(0xDE5072EE, 0xDBE3, 0x46DC, [0x8A, 0x87, 0xB6, 0xF6, 0x31, 0x19, 0x47, 0x51]);
interface IMFSensorActivitiesReportCallback : IUnknown
{
    HRESULT OnActivitiesReport(IMFSensorActivitiesReport sensorActivitiesReport);
}

const GUID IID_IMFSensorActivityMonitor = {0xD0CEF145, 0xB3F4, 0x4340, [0xA2, 0xE5, 0x7A, 0x50, 0x80, 0xCA, 0x05, 0xCB]};
@GUID(0xD0CEF145, 0xB3F4, 0x4340, [0xA2, 0xE5, 0x7A, 0x50, 0x80, 0xCA, 0x05, 0xCB]);
interface IMFSensorActivityMonitor : IUnknown
{
    HRESULT Start();
    HRESULT Stop();
}

struct MFCameraIntrinsic_CameraModel
{
    float FocalLength_x;
    float FocalLength_y;
    float PrincipalPoint_x;
    float PrincipalPoint_y;
}

struct MFCameraIntrinsic_DistortionModel6KT
{
    float Radial_k1;
    float Radial_k2;
    float Radial_k3;
    float Radial_k4;
    float Radial_k5;
    float Radial_k6;
    float Tangential_p1;
    float Tangential_p2;
}

struct MFCameraIntrinsic_DistortionModelArcTan
{
    float Radial_k0;
    float DistortionCenter_x;
    float DistortionCenter_y;
    float Tangential_x;
    float Tangential_y;
}

enum MFCameraIntrinsic_DistortionModelType
{
    MFCameraIntrinsic_DistortionModelType_6KT = 0,
    MFCameraIntrinsic_DistortionModelType_ArcTan = 1,
}

struct MFExtendedCameraIntrinsic_IntrinsicModel
{
    uint Width;
    uint Height;
    uint SplitFrameId;
    MFCameraIntrinsic_CameraModel CameraModel;
}

const GUID IID_IMFExtendedCameraIntrinsicModel = {0x5C595E64, 0x4630, 0x4231, [0x85, 0x5A, 0x12, 0x84, 0x2F, 0x73, 0x32, 0x45]};
@GUID(0x5C595E64, 0x4630, 0x4231, [0x85, 0x5A, 0x12, 0x84, 0x2F, 0x73, 0x32, 0x45]);
interface IMFExtendedCameraIntrinsicModel : IUnknown
{
    HRESULT GetModel(MFExtendedCameraIntrinsic_IntrinsicModel* pIntrinsicModel);
    HRESULT SetModel(const(MFExtendedCameraIntrinsic_IntrinsicModel)* pIntrinsicModel);
    HRESULT GetDistortionModelType(MFCameraIntrinsic_DistortionModelType* pDistortionModelType);
}

const GUID IID_IMFExtendedCameraIntrinsicsDistortionModel6KT = {0x74C2653B, 0x5F55, 0x4EB1, [0x9F, 0x0F, 0x18, 0xB8, 0xF6, 0x8B, 0x7D, 0x3D]};
@GUID(0x74C2653B, 0x5F55, 0x4EB1, [0x9F, 0x0F, 0x18, 0xB8, 0xF6, 0x8B, 0x7D, 0x3D]);
interface IMFExtendedCameraIntrinsicsDistortionModel6KT : IUnknown
{
    HRESULT GetDistortionModel(MFCameraIntrinsic_DistortionModel6KT* pDistortionModel);
    HRESULT SetDistortionModel(const(MFCameraIntrinsic_DistortionModel6KT)* pDistortionModel);
}

const GUID IID_IMFExtendedCameraIntrinsicsDistortionModelArcTan = {0x812D5F95, 0xB572, 0x45DC, [0xBA, 0xFC, 0xAE, 0x24, 0x19, 0x9D, 0xDD, 0xA8]};
@GUID(0x812D5F95, 0xB572, 0x45DC, [0xBA, 0xFC, 0xAE, 0x24, 0x19, 0x9D, 0xDD, 0xA8]);
interface IMFExtendedCameraIntrinsicsDistortionModelArcTan : IUnknown
{
    HRESULT GetDistortionModel(MFCameraIntrinsic_DistortionModelArcTan* pDistortionModel);
    HRESULT SetDistortionModel(const(MFCameraIntrinsic_DistortionModelArcTan)* pDistortionModel);
}

const GUID IID_IMFExtendedCameraIntrinsics = {0x687F6DAC, 0x6987, 0x4750, [0xA1, 0x6A, 0x73, 0x4D, 0x1E, 0x7A, 0x10, 0xFE]};
@GUID(0x687F6DAC, 0x6987, 0x4750, [0xA1, 0x6A, 0x73, 0x4D, 0x1E, 0x7A, 0x10, 0xFE]);
interface IMFExtendedCameraIntrinsics : IUnknown
{
    HRESULT InitializeFromBuffer(char* pbBuffer, uint dwBufferSize);
    HRESULT GetBufferSize(uint* pdwBufferSize);
    HRESULT SerializeToBuffer(char* pbBuffer, uint* pdwBufferSize);
    HRESULT GetIntrinsicModelCount(uint* pdwCount);
    HRESULT GetIntrinsicModelByIndex(uint dwIndex, IMFExtendedCameraIntrinsicModel* ppIntrinsicModel);
    HRESULT AddIntrinsicModel(IMFExtendedCameraIntrinsicModel pIntrinsicModel);
}

const GUID IID_IMFExtendedCameraControl = {0x38E33520, 0xFCA1, 0x4845, [0xA2, 0x7A, 0x68, 0xB7, 0xC6, 0xAB, 0x37, 0x89]};
@GUID(0x38E33520, 0xFCA1, 0x4845, [0xA2, 0x7A, 0x68, 0xB7, 0xC6, 0xAB, 0x37, 0x89]);
interface IMFExtendedCameraControl : IUnknown
{
    ulong GetCapabilities();
    HRESULT SetFlags(ulong ulFlags);
    ulong GetFlags();
    HRESULT LockPayload(ubyte** ppPayload, uint* pulPayload);
    HRESULT UnlockPayload();
    HRESULT CommitSettings();
}

const GUID IID_IMFExtendedCameraController = {0xB91EBFEE, 0xCA03, 0x4AF4, [0x8A, 0x82, 0xA3, 0x17, 0x52, 0xF4, 0xA0, 0xFC]};
@GUID(0xB91EBFEE, 0xCA03, 0x4AF4, [0x8A, 0x82, 0xA3, 0x17, 0x52, 0xF4, 0xA0, 0xFC]);
interface IMFExtendedCameraController : IUnknown
{
    HRESULT GetExtendedCameraControl(uint dwStreamIndex, uint ulPropertyId, IMFExtendedCameraControl* ppControl);
}

const GUID IID_IMFRelativePanelReport = {0xF25362EA, 0x2C0E, 0x447F, [0x81, 0xE2, 0x75, 0x59, 0x14, 0xCD, 0xC0, 0xC3]};
@GUID(0xF25362EA, 0x2C0E, 0x447F, [0x81, 0xE2, 0x75, 0x59, 0x14, 0xCD, 0xC0, 0xC3]);
interface IMFRelativePanelReport : IUnknown
{
    HRESULT GetRelativePanel(uint* panel);
}

const GUID IID_IMFRelativePanelWatcher = {0x421AF7F6, 0x573E, 0x4AD0, [0x8F, 0xDA, 0x2E, 0x57, 0xCE, 0xDB, 0x18, 0xC6]};
@GUID(0x421AF7F6, 0x573E, 0x4AD0, [0x8F, 0xDA, 0x2E, 0x57, 0xCE, 0xDB, 0x18, 0xC6]);
interface IMFRelativePanelWatcher : IMFShutdown
{
    HRESULT BeginGetReport(IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndGetReport(IMFAsyncResult pResult, IMFRelativePanelReport* ppRelativePanelReport);
    HRESULT GetReport(IMFRelativePanelReport* ppRelativePanelReport);
}

const GUID IID_IMFVideoCaptureSampleAllocator = {0x725B77C7, 0xCA9F, 0x4FE5, [0x9D, 0x72, 0x99, 0x46, 0xBF, 0x9B, 0x3C, 0x70]};
@GUID(0x725B77C7, 0xCA9F, 0x4FE5, [0x9D, 0x72, 0x99, 0x46, 0xBF, 0x9B, 0x3C, 0x70]);
interface IMFVideoCaptureSampleAllocator : IMFVideoSampleAllocator
{
    HRESULT InitializeCaptureSampleAllocator(uint cbSampleSize, uint cbCaptureMetadataSize, uint cbAlignment, uint cMinimumSamples, IMFAttributes pAttributes, IMFMediaType pMediaType);
}

enum MFSampleAllocatorUsage
{
    MFSampleAllocatorUsage_UsesProvidedAllocator = 0,
    MFSampleAllocatorUsage_UsesCustomAllocator = 1,
    MFSampleAllocatorUsage_DoesNotAllocate = 2,
}

const GUID IID_IMFSampleAllocatorControl = {0xDA62B958, 0x3A38, 0x4A97, [0xBD, 0x27, 0x14, 0x9C, 0x64, 0x0C, 0x07, 0x71]};
@GUID(0xDA62B958, 0x3A38, 0x4A97, [0xBD, 0x27, 0x14, 0x9C, 0x64, 0x0C, 0x07, 0x71]);
interface IMFSampleAllocatorControl : IUnknown
{
    HRESULT SetDefaultAllocator(uint dwOutputStreamID, IUnknown pAllocator);
    HRESULT GetAllocatorUsage(uint dwOutputStreamID, uint* pdwInputStreamID, MFSampleAllocatorUsage* peUsage);
}

const GUID IID_IMFASFContentInfo = {0xB1DCA5CD, 0xD5DA, 0x4451, [0x8E, 0x9E, 0xDB, 0x5C, 0x59, 0x91, 0x4E, 0xAD]};
@GUID(0xB1DCA5CD, 0xD5DA, 0x4451, [0x8E, 0x9E, 0xDB, 0x5C, 0x59, 0x91, 0x4E, 0xAD]);
interface IMFASFContentInfo : IUnknown
{
    HRESULT GetHeaderSize(IMFMediaBuffer pIStartOfContent, ulong* cbHeaderSize);
    HRESULT ParseHeader(IMFMediaBuffer pIHeaderBuffer, ulong cbOffsetWithinHeader);
    HRESULT GenerateHeader(IMFMediaBuffer pIHeader, uint* pcbHeader);
    HRESULT GetProfile(IMFASFProfile* ppIProfile);
    HRESULT SetProfile(IMFASFProfile pIProfile);
    HRESULT GeneratePresentationDescriptor(IMFPresentationDescriptor* ppIPresentationDescriptor);
    HRESULT GetEncodingConfigurationPropertyStore(ushort wStreamNumber, IPropertyStore* ppIStore);
}

const GUID IID_IMFASFProfile = {0xD267BF6A, 0x028B, 0x4E0D, [0x90, 0x3D, 0x43, 0xF0, 0xEF, 0x82, 0xD0, 0xD4]};
@GUID(0xD267BF6A, 0x028B, 0x4E0D, [0x90, 0x3D, 0x43, 0xF0, 0xEF, 0x82, 0xD0, 0xD4]);
interface IMFASFProfile : IMFAttributes
{
    HRESULT GetStreamCount(uint* pcStreams);
    HRESULT GetStream(uint dwStreamIndex, ushort* pwStreamNumber, IMFASFStreamConfig* ppIStream);
    HRESULT GetStreamByNumber(ushort wStreamNumber, IMFASFStreamConfig* ppIStream);
    HRESULT SetStream(IMFASFStreamConfig pIStream);
    HRESULT RemoveStream(ushort wStreamNumber);
    HRESULT CreateStream(IMFMediaType pIMediaType, IMFASFStreamConfig* ppIStream);
    HRESULT GetMutualExclusionCount(uint* pcMutexs);
    HRESULT GetMutualExclusion(uint dwMutexIndex, IMFASFMutualExclusion* ppIMutex);
    HRESULT AddMutualExclusion(IMFASFMutualExclusion pIMutex);
    HRESULT RemoveMutualExclusion(uint dwMutexIndex);
    HRESULT CreateMutualExclusion(IMFASFMutualExclusion* ppIMutex);
    HRESULT GetStreamPrioritization(IMFASFStreamPrioritization* ppIStreamPrioritization);
    HRESULT AddStreamPrioritization(IMFASFStreamPrioritization pIStreamPrioritization);
    HRESULT RemoveStreamPrioritization();
    HRESULT CreateStreamPrioritization(IMFASFStreamPrioritization* ppIStreamPrioritization);
    HRESULT Clone(IMFASFProfile* ppIProfile);
}

const GUID IID_IMFASFStreamConfig = {0x9E8AE8D2, 0xDBBD, 0x4200, [0x9A, 0xCA, 0x06, 0xE6, 0xDF, 0x48, 0x49, 0x13]};
@GUID(0x9E8AE8D2, 0xDBBD, 0x4200, [0x9A, 0xCA, 0x06, 0xE6, 0xDF, 0x48, 0x49, 0x13]);
interface IMFASFStreamConfig : IMFAttributes
{
    HRESULT GetStreamType(Guid* pguidStreamType);
    ushort GetStreamNumber();
    HRESULT SetStreamNumber(ushort wStreamNum);
    HRESULT GetMediaType(IMFMediaType* ppIMediaType);
    HRESULT SetMediaType(IMFMediaType pIMediaType);
    HRESULT GetPayloadExtensionCount(ushort* pcPayloadExtensions);
    HRESULT GetPayloadExtension(ushort wPayloadExtensionNumber, Guid* pguidExtensionSystemID, ushort* pcbExtensionDataSize, ubyte* pbExtensionSystemInfo, uint* pcbExtensionSystemInfo);
    HRESULT AddPayloadExtension(Guid guidExtensionSystemID, ushort cbExtensionDataSize, ubyte* pbExtensionSystemInfo, uint cbExtensionSystemInfo);
    HRESULT RemoveAllPayloadExtensions();
    HRESULT Clone(IMFASFStreamConfig* ppIStreamConfig);
}

const GUID IID_IMFASFMutualExclusion = {0x12558291, 0xE399, 0x11D5, [0xBC, 0x2A, 0x00, 0xB0, 0xD0, 0xF3, 0xF4, 0xAB]};
@GUID(0x12558291, 0xE399, 0x11D5, [0xBC, 0x2A, 0x00, 0xB0, 0xD0, 0xF3, 0xF4, 0xAB]);
interface IMFASFMutualExclusion : IUnknown
{
    HRESULT GetType(Guid* pguidType);
    HRESULT SetType(const(Guid)* guidType);
    HRESULT GetRecordCount(uint* pdwRecordCount);
    HRESULT GetStreamsForRecord(uint dwRecordNumber, ushort* pwStreamNumArray, uint* pcStreams);
    HRESULT AddStreamForRecord(uint dwRecordNumber, ushort wStreamNumber);
    HRESULT RemoveStreamFromRecord(uint dwRecordNumber, ushort wStreamNumber);
    HRESULT RemoveRecord(uint dwRecordNumber);
    HRESULT AddRecord(uint* pdwRecordNumber);
    HRESULT Clone(IMFASFMutualExclusion* ppIMutex);
}

const GUID IID_IMFASFStreamPrioritization = {0x699BDC27, 0xBBAF, 0x49FF, [0x8E, 0x38, 0x9C, 0x39, 0xC9, 0xB5, 0xE0, 0x88]};
@GUID(0x699BDC27, 0xBBAF, 0x49FF, [0x8E, 0x38, 0x9C, 0x39, 0xC9, 0xB5, 0xE0, 0x88]);
interface IMFASFStreamPrioritization : IUnknown
{
    HRESULT GetStreamCount(uint* pdwStreamCount);
    HRESULT GetStream(uint dwStreamIndex, ushort* pwStreamNumber, ushort* pwStreamFlags);
    HRESULT AddStream(ushort wStreamNumber, ushort wStreamFlags);
    HRESULT RemoveStream(uint dwStreamIndex);
    HRESULT Clone(IMFASFStreamPrioritization* ppIStreamPrioritization);
}

enum MFASF_INDEXER_FLAGS
{
    MFASF_INDEXER_WRITE_NEW_INDEX = 1,
    MFASF_INDEXER_READ_FOR_REVERSEPLAYBACK = 2,
    MFASF_INDEXER_WRITE_FOR_LIVEREAD = 4,
}

struct ASF_INDEX_IDENTIFIER
{
    Guid guidIndexType;
    ushort wStreamNumber;
}

struct ASF_INDEX_DESCRIPTOR
{
    ASF_INDEX_IDENTIFIER Identifier;
    ushort cPerEntryBytes;
    ushort szDescription;
    uint dwInterval;
}

const GUID IID_IMFASFIndexer = {0x53590F48, 0xDC3B, 0x4297, [0x81, 0x3F, 0x78, 0x77, 0x61, 0xAD, 0x7B, 0x3E]};
@GUID(0x53590F48, 0xDC3B, 0x4297, [0x81, 0x3F, 0x78, 0x77, 0x61, 0xAD, 0x7B, 0x3E]);
interface IMFASFIndexer : IUnknown
{
    HRESULT SetFlags(uint dwFlags);
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT Initialize(IMFASFContentInfo pIContentInfo);
    HRESULT GetIndexPosition(IMFASFContentInfo pIContentInfo, ulong* pcbIndexOffset);
    HRESULT SetIndexByteStreams(IMFByteStream* ppIByteStreams, uint cByteStreams);
    HRESULT GetIndexByteStreamCount(uint* pcByteStreams);
    HRESULT GetIndexStatus(ASF_INDEX_IDENTIFIER* pIndexIdentifier, int* pfIsIndexed, ubyte* pbIndexDescriptor, uint* pcbIndexDescriptor);
    HRESULT SetIndexStatus(ubyte* pbIndexDescriptor, uint cbIndexDescriptor, BOOL fGenerateIndex);
    HRESULT GetSeekPositionForValue(const(PROPVARIANT)* pvarValue, ASF_INDEX_IDENTIFIER* pIndexIdentifier, ulong* pcbOffsetWithinData, long* phnsApproxTime, uint* pdwPayloadNumberOfStreamWithinPacket);
    HRESULT GenerateIndexEntries(IMFSample pIASFPacketSample);
    HRESULT CommitIndex(IMFASFContentInfo pIContentInfo);
    HRESULT GetIndexWriteSpace(ulong* pcbIndexWriteSpace);
    HRESULT GetCompletedIndex(IMFMediaBuffer pIIndexBuffer, ulong cbOffsetWithinIndex);
}

const GUID IID_IMFASFSplitter = {0x12558295, 0xE399, 0x11D5, [0xBC, 0x2A, 0x00, 0xB0, 0xD0, 0xF3, 0xF4, 0xAB]};
@GUID(0x12558295, 0xE399, 0x11D5, [0xBC, 0x2A, 0x00, 0xB0, 0xD0, 0xF3, 0xF4, 0xAB]);
interface IMFASFSplitter : IUnknown
{
    HRESULT Initialize(IMFASFContentInfo pIContentInfo);
    HRESULT SetFlags(uint dwFlags);
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT SelectStreams(ushort* pwStreamNumbers, ushort wNumStreams);
    HRESULT GetSelectedStreams(ushort* pwStreamNumbers, ushort* pwNumStreams);
    HRESULT ParseData(IMFMediaBuffer pIBuffer, uint cbBufferOffset, uint cbLength);
    HRESULT GetNextSample(uint* pdwStatusFlags, ushort* pwStreamNumber, IMFSample* ppISample);
    HRESULT Flush();
    HRESULT GetLastSendTime(uint* pdwLastSendTime);
}

enum MFASF_SPLITTERFLAGS
{
    MFASF_SPLITTER_REVERSE = 1,
    MFASF_SPLITTER_WMDRM = 2,
}

enum ASF_STATUSFLAGS
{
    ASF_STATUSFLAGS_INCOMPLETE = 1,
    ASF_STATUSFLAGS_NONFATAL_ERROR = 2,
}

enum MFASF_MULTIPLEXERFLAGS
{
    MFASF_MULTIPLEXER_AUTOADJUST_BITRATE = 1,
}

struct ASF_MUX_STATISTICS
{
    uint cFramesWritten;
    uint cFramesDropped;
}

const GUID IID_IMFASFMultiplexer = {0x57BDD80A, 0x9B38, 0x4838, [0xB7, 0x37, 0xC5, 0x8F, 0x67, 0x0D, 0x7D, 0x4F]};
@GUID(0x57BDD80A, 0x9B38, 0x4838, [0xB7, 0x37, 0xC5, 0x8F, 0x67, 0x0D, 0x7D, 0x4F]);
interface IMFASFMultiplexer : IUnknown
{
    HRESULT Initialize(IMFASFContentInfo pIContentInfo);
    HRESULT SetFlags(uint dwFlags);
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT ProcessSample(ushort wStreamNumber, IMFSample pISample, long hnsTimestampAdjust);
    HRESULT GetNextPacket(uint* pdwStatusFlags, IMFSample* ppIPacket);
    HRESULT Flush();
    HRESULT End(IMFASFContentInfo pIContentInfo);
    HRESULT GetStatistics(ushort wStreamNumber, ASF_MUX_STATISTICS* pMuxStats);
    HRESULT SetSyncTolerance(uint msSyncTolerance);
}

enum MFASF_STREAMSELECTOR_FLAGS
{
    MFASF_STREAMSELECTOR_DISABLE_THINNING = 1,
    MFASF_STREAMSELECTOR_USE_AVERAGE_BITRATE = 2,
}

enum ASF_SELECTION_STATUS
{
    ASF_STATUS_NOTSELECTED = 0,
    ASF_STATUS_CLEANPOINTSONLY = 1,
    ASF_STATUS_ALLDATAUNITS = 2,
}

const GUID IID_IMFASFStreamSelector = {0xD01BAD4A, 0x4FA0, 0x4A60, [0x93, 0x49, 0xC2, 0x7E, 0x62, 0xDA, 0x9D, 0x41]};
@GUID(0xD01BAD4A, 0x4FA0, 0x4A60, [0x93, 0x49, 0xC2, 0x7E, 0x62, 0xDA, 0x9D, 0x41]);
interface IMFASFStreamSelector : IUnknown
{
    HRESULT GetStreamCount(uint* pcStreams);
    HRESULT GetOutputCount(uint* pcOutputs);
    HRESULT GetOutputStreamCount(uint dwOutputNum, uint* pcStreams);
    HRESULT GetOutputStreamNumbers(uint dwOutputNum, ushort* rgwStreamNumbers);
    HRESULT GetOutputFromStream(ushort wStreamNum, uint* pdwOutput);
    HRESULT GetOutputOverride(uint dwOutputNum, ASF_SELECTION_STATUS* pSelection);
    HRESULT SetOutputOverride(uint dwOutputNum, ASF_SELECTION_STATUS Selection);
    HRESULT GetOutputMutexCount(uint dwOutputNum, uint* pcMutexes);
    HRESULT GetOutputMutex(uint dwOutputNum, uint dwMutexNum, IUnknown* ppMutex);
    HRESULT SetOutputMutexSelection(uint dwOutputNum, uint dwMutexNum, ushort wSelectedRecord);
    HRESULT GetBandwidthStepCount(uint* pcStepCount);
    HRESULT GetBandwidthStep(uint dwStepNum, uint* pdwBitrate, ushort* rgwStreamNumbers, ASF_SELECTION_STATUS* rgSelections);
    HRESULT BitrateToStepNumber(uint dwBitrate, uint* pdwStepNum);
    HRESULT SetStreamSelectorFlags(uint dwStreamSelectorFlags);
}

enum MFSINK_WMDRMACTION
{
    MFSINK_WMDRMACTION_UNDEFINED = 0,
    MFSINK_WMDRMACTION_ENCODE = 1,
    MFSINK_WMDRMACTION_TRANSCODE = 2,
    MFSINK_WMDRMACTION_TRANSCRYPT = 3,
    MFSINK_WMDRMACTION_LAST = 3,
}

const GUID IID_IMFDRMNetHelper = {0x3D1FF0EA, 0x679A, 0x4190, [0x8D, 0x46, 0x7F, 0xA6, 0x9E, 0x8C, 0x7E, 0x15]};
@GUID(0x3D1FF0EA, 0x679A, 0x4190, [0x8D, 0x46, 0x7F, 0xA6, 0x9E, 0x8C, 0x7E, 0x15]);
interface IMFDRMNetHelper : IUnknown
{
    HRESULT ProcessLicenseRequest(char* pLicenseRequest, uint cbLicenseRequest, char* ppLicenseResponse, uint* pcbLicenseResponse, BSTR* pbstrKID);
    HRESULT GetChainedLicenseResponse(char* ppLicenseResponse, uint* pcbLicenseResponse);
}

struct MFVideoNormalizedRect
{
    float left;
    float top;
    float right;
    float bottom;
}

enum MF_CAPTURE_ENGINE_DEVICE_TYPE
{
    MF_CAPTURE_ENGINE_DEVICE_TYPE_AUDIO = 0,
    MF_CAPTURE_ENGINE_DEVICE_TYPE_VIDEO = 1,
}

enum MF_CAPTURE_ENGINE_SINK_TYPE
{
    MF_CAPTURE_ENGINE_SINK_TYPE_RECORD = 0,
    MF_CAPTURE_ENGINE_SINK_TYPE_PREVIEW = 1,
    MF_CAPTURE_ENGINE_SINK_TYPE_PHOTO = 2,
}

enum __MIDL___MIDL_itf_mfcaptureengine_0000_0000_0001
{
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_VIDEO_PREVIEW = -6,
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_VIDEO_RECORD = -7,
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_PHOTO = -8,
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_AUDIO = -9,
    MF_CAPTURE_ENGINE_MEDIASOURCE = -1,
}

enum MF_CAPTURE_ENGINE_STREAM_CATEGORY
{
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_VIDEO_PREVIEW = 0,
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_VIDEO_CAPTURE = 1,
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_PHOTO_INDEPENDENT = 2,
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_PHOTO_DEPENDENT = 3,
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_AUDIO = 4,
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_UNSUPPORTED = 5,
}

enum MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE
{
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_OTHER = 0,
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_COMMUNICATIONS = 1,
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_MEDIA = 2,
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_GAMECHAT = 3,
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_SPEECH = 4,
}

enum MF_CAPTURE_ENGINE_AUDIO_PROCESSING_MODE
{
    MF_CAPTURE_ENGINE_AUDIO_PROCESSING_DEFAULT = 0,
    MF_CAPTURE_ENGINE_AUDIO_PROCESSING_RAW = 1,
}

const GUID IID_IMFCaptureEngineOnEventCallback = {0xAEDA51C0, 0x9025, 0x4983, [0x90, 0x12, 0xDE, 0x59, 0x7B, 0x88, 0xB0, 0x89]};
@GUID(0xAEDA51C0, 0x9025, 0x4983, [0x90, 0x12, 0xDE, 0x59, 0x7B, 0x88, 0xB0, 0x89]);
interface IMFCaptureEngineOnEventCallback : IUnknown
{
    HRESULT OnEvent(IMFMediaEvent pEvent);
}

const GUID IID_IMFCaptureEngineOnSampleCallback = {0x52150B82, 0xAB39, 0x4467, [0x98, 0x0F, 0xE4, 0x8B, 0xF0, 0x82, 0x2E, 0xCD]};
@GUID(0x52150B82, 0xAB39, 0x4467, [0x98, 0x0F, 0xE4, 0x8B, 0xF0, 0x82, 0x2E, 0xCD]);
interface IMFCaptureEngineOnSampleCallback : IUnknown
{
    HRESULT OnSample(IMFSample pSample);
}

const GUID IID_IMFCaptureSink = {0x72D6135B, 0x35E9, 0x412C, [0xB9, 0x26, 0xFD, 0x52, 0x65, 0xF2, 0xA8, 0x85]};
@GUID(0x72D6135B, 0x35E9, 0x412C, [0xB9, 0x26, 0xFD, 0x52, 0x65, 0xF2, 0xA8, 0x85]);
interface IMFCaptureSink : IUnknown
{
    HRESULT GetOutputMediaType(uint dwSinkStreamIndex, IMFMediaType* ppMediaType);
    HRESULT GetService(uint dwSinkStreamIndex, const(Guid)* rguidService, const(Guid)* riid, IUnknown* ppUnknown);
    HRESULT AddStream(uint dwSourceStreamIndex, IMFMediaType pMediaType, IMFAttributes pAttributes, uint* pdwSinkStreamIndex);
    HRESULT Prepare();
    HRESULT RemoveAllStreams();
}

const GUID IID_IMFCaptureRecordSink = {0x3323B55A, 0xF92A, 0x4FE2, [0x8E, 0xDC, 0xE9, 0xBF, 0xC0, 0x63, 0x4D, 0x77]};
@GUID(0x3323B55A, 0xF92A, 0x4FE2, [0x8E, 0xDC, 0xE9, 0xBF, 0xC0, 0x63, 0x4D, 0x77]);
interface IMFCaptureRecordSink : IMFCaptureSink
{
    HRESULT SetOutputByteStream(IMFByteStream pByteStream, const(Guid)* guidContainerType);
    HRESULT SetOutputFileName(const(wchar)* fileName);
    HRESULT SetSampleCallback(uint dwStreamSinkIndex, IMFCaptureEngineOnSampleCallback pCallback);
    HRESULT SetCustomSink(IMFMediaSink pMediaSink);
    HRESULT GetRotation(uint dwStreamIndex, uint* pdwRotationValue);
    HRESULT SetRotation(uint dwStreamIndex, uint dwRotationValue);
}

const GUID IID_IMFCapturePreviewSink = {0x77346CFD, 0x5B49, 0x4D73, [0xAC, 0xE0, 0x5B, 0x52, 0xA8, 0x59, 0xF2, 0xE0]};
@GUID(0x77346CFD, 0x5B49, 0x4D73, [0xAC, 0xE0, 0x5B, 0x52, 0xA8, 0x59, 0xF2, 0xE0]);
interface IMFCapturePreviewSink : IMFCaptureSink
{
    HRESULT SetRenderHandle(HANDLE handle);
    HRESULT SetRenderSurface(IUnknown pSurface);
    HRESULT UpdateVideo(const(MFVideoNormalizedRect)* pSrc, const(RECT)* pDst, const(uint)* pBorderClr);
    HRESULT SetSampleCallback(uint dwStreamSinkIndex, IMFCaptureEngineOnSampleCallback pCallback);
    HRESULT GetMirrorState(int* pfMirrorState);
    HRESULT SetMirrorState(BOOL fMirrorState);
    HRESULT GetRotation(uint dwStreamIndex, uint* pdwRotationValue);
    HRESULT SetRotation(uint dwStreamIndex, uint dwRotationValue);
    HRESULT SetCustomSink(IMFMediaSink pMediaSink);
}

const GUID IID_IMFCapturePhotoSink = {0xD2D43CC8, 0x48BB, 0x4AA7, [0x95, 0xDB, 0x10, 0xC0, 0x69, 0x77, 0xE7, 0x77]};
@GUID(0xD2D43CC8, 0x48BB, 0x4AA7, [0x95, 0xDB, 0x10, 0xC0, 0x69, 0x77, 0xE7, 0x77]);
interface IMFCapturePhotoSink : IMFCaptureSink
{
    HRESULT SetOutputFileName(const(wchar)* fileName);
    HRESULT SetSampleCallback(IMFCaptureEngineOnSampleCallback pCallback);
    HRESULT SetOutputByteStream(IMFByteStream pByteStream);
}

const GUID IID_IMFCaptureSource = {0x439A42A8, 0x0D2C, 0x4505, [0xBE, 0x83, 0xF7, 0x9B, 0x2A, 0x05, 0xD5, 0xC4]};
@GUID(0x439A42A8, 0x0D2C, 0x4505, [0xBE, 0x83, 0xF7, 0x9B, 0x2A, 0x05, 0xD5, 0xC4]);
interface IMFCaptureSource : IUnknown
{
    HRESULT GetCaptureDeviceSource(MF_CAPTURE_ENGINE_DEVICE_TYPE mfCaptureEngineDeviceType, IMFMediaSource* ppMediaSource);
    HRESULT GetCaptureDeviceActivate(MF_CAPTURE_ENGINE_DEVICE_TYPE mfCaptureEngineDeviceType, IMFActivate* ppActivate);
    HRESULT GetService(const(Guid)* rguidService, const(Guid)* riid, IUnknown* ppUnknown);
    HRESULT AddEffect(uint dwSourceStreamIndex, IUnknown pUnknown);
    HRESULT RemoveEffect(uint dwSourceStreamIndex, IUnknown pUnknown);
    HRESULT RemoveAllEffects(uint dwSourceStreamIndex);
    HRESULT GetAvailableDeviceMediaType(uint dwSourceStreamIndex, uint dwMediaTypeIndex, IMFMediaType* ppMediaType);
    HRESULT SetCurrentDeviceMediaType(uint dwSourceStreamIndex, IMFMediaType pMediaType);
    HRESULT GetCurrentDeviceMediaType(uint dwSourceStreamIndex, IMFMediaType* ppMediaType);
    HRESULT GetDeviceStreamCount(uint* pdwStreamCount);
    HRESULT GetDeviceStreamCategory(uint dwSourceStreamIndex, MF_CAPTURE_ENGINE_STREAM_CATEGORY* pStreamCategory);
    HRESULT GetMirrorState(uint dwStreamIndex, int* pfMirrorState);
    HRESULT SetMirrorState(uint dwStreamIndex, BOOL fMirrorState);
    HRESULT GetStreamIndexFromFriendlyName(uint uifriendlyName, uint* pdwActualStreamIndex);
}

const GUID IID_IMFCaptureEngine = {0xA6BBA433, 0x176B, 0x48B2, [0xB3, 0x75, 0x53, 0xAA, 0x03, 0x47, 0x32, 0x07]};
@GUID(0xA6BBA433, 0x176B, 0x48B2, [0xB3, 0x75, 0x53, 0xAA, 0x03, 0x47, 0x32, 0x07]);
interface IMFCaptureEngine : IUnknown
{
    HRESULT Initialize(IMFCaptureEngineOnEventCallback pEventCallback, IMFAttributes pAttributes, IUnknown pAudioSource, IUnknown pVideoSource);
    HRESULT StartPreview();
    HRESULT StopPreview();
    HRESULT StartRecord();
    HRESULT StopRecord(BOOL bFinalize, BOOL bFlushUnprocessedSamples);
    HRESULT TakePhoto();
    HRESULT GetSink(MF_CAPTURE_ENGINE_SINK_TYPE mfCaptureEngineSinkType, IMFCaptureSink* ppSink);
    HRESULT GetSource(IMFCaptureSource* ppSource);
}

const GUID IID_IMFCaptureEngineClassFactory = {0x8F02D140, 0x56FC, 0x4302, [0xA7, 0x05, 0x3A, 0x97, 0xC7, 0x8B, 0xE7, 0x79]};
@GUID(0x8F02D140, 0x56FC, 0x4302, [0xA7, 0x05, 0x3A, 0x97, 0xC7, 0x8B, 0xE7, 0x79]);
interface IMFCaptureEngineClassFactory : IUnknown
{
    HRESULT CreateInstance(const(Guid)* clsid, const(Guid)* riid, void** ppvObject);
}

const GUID IID_IMFCaptureEngineOnSampleCallback2 = {0xE37CEED7, 0x340F, 0x4514, [0x9F, 0x4D, 0x9C, 0x2A, 0xE0, 0x26, 0x10, 0x0B]};
@GUID(0xE37CEED7, 0x340F, 0x4514, [0x9F, 0x4D, 0x9C, 0x2A, 0xE0, 0x26, 0x10, 0x0B]);
interface IMFCaptureEngineOnSampleCallback2 : IMFCaptureEngineOnSampleCallback
{
    HRESULT OnSynchronizedEvent(IMFMediaEvent pEvent);
}

const GUID IID_IMFCaptureSink2 = {0xF9E4219E, 0x6197, 0x4B5E, [0xB8, 0x88, 0xBE, 0xE3, 0x10, 0xAB, 0x2C, 0x59]};
@GUID(0xF9E4219E, 0x6197, 0x4B5E, [0xB8, 0x88, 0xBE, 0xE3, 0x10, 0xAB, 0x2C, 0x59]);
interface IMFCaptureSink2 : IMFCaptureSink
{
    HRESULT SetOutputMediaType(uint dwStreamIndex, IMFMediaType pMediaType, IMFAttributes pEncodingAttributes);
}

alias MFPERIODICCALLBACK = extern(Windows) void function(IUnknown pContext);
enum MFASYNC_WORKQUEUE_TYPE
{
    MF_STANDARD_WORKQUEUE = 0,
    MF_WINDOW_WORKQUEUE = 1,
    MF_MULTITHREADED_WORKQUEUE = 2,
}

interface MFASYNCRESULT : IMFAsyncResult
{
}

enum MF_TOPOSTATUS
{
    MF_TOPOSTATUS_INVALID = 0,
    MF_TOPOSTATUS_READY = 100,
    MF_TOPOSTATUS_STARTED_SOURCE = 200,
    MF_TOPOSTATUS_DYNAMIC_CHANGED = 210,
    MF_TOPOSTATUS_SINK_SWITCHED = 300,
    MF_TOPOSTATUS_ENDED = 400,
}

enum MFSampleEncryptionProtectionScheme
{
    MF_SAMPLE_ENCRYPTION_PROTECTION_SCHEME_NONE = 0,
    MF_SAMPLE_ENCRYPTION_PROTECTION_SCHEME_AES_CTR = 1,
    MF_SAMPLE_ENCRYPTION_PROTECTION_SCHEME_AES_CBC = 2,
}

struct MOVE_RECT
{
    POINT SourcePoint;
    RECT DestRect;
}

struct DIRTYRECT_INFO
{
    uint FrameNumber;
    uint NumDirtyRects;
    RECT DirtyRects;
}

struct MOVEREGION_INFO
{
    uint FrameNumber;
    uint NumMoveRegions;
    MOVE_RECT MoveRegions;
}

struct ROI_AREA
{
    RECT rect;
    int QPDelta;
}

struct MACROBLOCK_DATA
{
    uint flags;
    short motionVectorX;
    short motionVectorY;
    int QPDelta;
}

enum _MFT_ENUM_FLAG
{
    MFT_ENUM_FLAG_SYNCMFT = 1,
    MFT_ENUM_FLAG_ASYNCMFT = 2,
    MFT_ENUM_FLAG_HARDWARE = 4,
    MFT_ENUM_FLAG_FIELDOFUSE = 8,
    MFT_ENUM_FLAG_LOCALMFT = 16,
    MFT_ENUM_FLAG_TRANSCODE_ONLY = 32,
    MFT_ENUM_FLAG_SORTANDFILTER = 64,
    MFT_ENUM_FLAG_SORTANDFILTER_APPROVED_ONLY = 192,
    MFT_ENUM_FLAG_SORTANDFILTER_WEB_ONLY = 320,
    MFT_ENUM_FLAG_SORTANDFILTER_WEB_ONLY_EDGEMODE = 576,
    MFT_ENUM_FLAG_UNTRUSTED_STOREMFT = 1024,
    MFT_ENUM_FLAG_ALL = 63,
}

enum MFFrameSourceTypes
{
    MFFrameSourceTypes_Color = 1,
    MFFrameSourceTypes_Infrared = 2,
    MFFrameSourceTypes_Depth = 4,
    MFFrameSourceTypes_Image = 8,
    MFFrameSourceTypes_Custom = 128,
}

enum MFVideo3DFormat
{
    MFVideo3DSampleFormat_BaseView = 0,
    MFVideo3DSampleFormat_MultiView = 1,
    MFVideo3DSampleFormat_Packed_LeftRight = 2,
    MFVideo3DSampleFormat_Packed_TopBottom = 3,
}

enum MFVideo3DSampleFormat
{
    MFSampleExtension_3DVideo_MultiView = 1,
    MFSampleExtension_3DVideo_Packed = 0,
}

enum MFVideoRotationFormat
{
    MFVideoRotationFormat_0 = 0,
    MFVideoRotationFormat_90 = 90,
    MFVideoRotationFormat_180 = 180,
    MFVideoRotationFormat_270 = 270,
}

enum MFDepthMeasurement
{
    DistanceToFocalPlane = 0,
    DistanceToOpticalCenter = 1,
}

enum MF_CUSTOM_DECODE_UNIT_TYPE
{
    MF_DECODE_UNIT_NAL = 0,
    MF_DECODE_UNIT_SEI = 1,
}

struct MFFOLDDOWN_MATRIX
{
    uint cbSize;
    uint cSrcChannels;
    uint cDstChannels;
    uint dwChannelMask;
    int Coeff;
}

enum MFVideoDRMFlags
{
    MFVideoDRMFlag_None = 0,
    MFVideoDRMFlag_AnalogProtected = 1,
    MFVideoDRMFlag_DigitallyProtected = 2,
}

enum MFVideoPadFlags
{
    MFVideoPadFlag_PAD_TO_None = 0,
    MFVideoPadFlag_PAD_TO_4x3 = 1,
    MFVideoPadFlag_PAD_TO_16x9 = 2,
}

enum MFVideoSrcContentHintFlags
{
    MFVideoSrcContentHintFlag_None = 0,
    MFVideoSrcContentHintFlag_16x9 = 1,
    MFVideoSrcContentHintFlag_235_1 = 2,
}

struct MT_CUSTOM_VIDEO_PRIMARIES
{
    float fRx;
    float fRy;
    float fGx;
    float fGy;
    float fBx;
    float fBy;
    float fWx;
    float fWy;
}

struct MT_ARBITRARY_HEADER
{
    Guid majortype;
    Guid subtype;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint lSampleSize;
    Guid formattype;
}

struct MF_FLOAT2
{
    float x;
    float y;
}

struct MF_FLOAT3
{
    float x;
    float y;
    float z;
}

struct MF_QUATERNION
{
    float x;
    float y;
    float z;
    float w;
}

struct MFCameraExtrinsic_CalibratedTransform
{
    Guid CalibrationId;
    MF_FLOAT3 Position;
    MF_QUATERNION Orientation;
}

struct MFCameraExtrinsics
{
    uint TransformCount;
    MFCameraExtrinsic_CalibratedTransform CalibratedTransforms;
}

struct MFCameraIntrinsic_PinholeCameraModel
{
    MF_FLOAT2 FocalLength;
    MF_FLOAT2 PrincipalPoint;
}

struct MFCameraIntrinsic_DistortionModel
{
    float Radial_k1;
    float Radial_k2;
    float Radial_k3;
    float Tangential_p1;
    float Tangential_p2;
}

struct MFPinholeCameraIntrinsic_IntrinsicModel
{
    uint Width;
    uint Height;
    MFCameraIntrinsic_PinholeCameraModel CameraModel;
    MFCameraIntrinsic_DistortionModel DistortionModel;
}

struct MFPinholeCameraIntrinsics
{
    uint IntrinsicModelCount;
    MFPinholeCameraIntrinsic_IntrinsicModel IntrinsicModels;
}

enum MFWaveFormatExConvertFlags
{
    MFWaveFormatExConvertFlag_Normal = 0,
    MFWaveFormatExConvertFlag_ForceExtensible = 1,
}

enum EAllocationType
{
    eAllocationTypeDynamic = 0,
    eAllocationTypeRT = 1,
    eAllocationTypePageable = 2,
    eAllocationTypeIgnore = 3,
}

enum MF_MEDIA_ENGINE_ERR
{
    MF_MEDIA_ENGINE_ERR_NOERROR = 0,
    MF_MEDIA_ENGINE_ERR_ABORTED = 1,
    MF_MEDIA_ENGINE_ERR_NETWORK = 2,
    MF_MEDIA_ENGINE_ERR_DECODE = 3,
    MF_MEDIA_ENGINE_ERR_SRC_NOT_SUPPORTED = 4,
    MF_MEDIA_ENGINE_ERR_ENCRYPTED = 5,
}

const GUID IID_IMFMediaError = {0xFC0E10D2, 0xAB2A, 0x4501, [0xA9, 0x51, 0x06, 0xBB, 0x10, 0x75, 0x18, 0x4C]};
@GUID(0xFC0E10D2, 0xAB2A, 0x4501, [0xA9, 0x51, 0x06, 0xBB, 0x10, 0x75, 0x18, 0x4C]);
interface IMFMediaError : IUnknown
{
    ushort GetErrorCode();
    HRESULT GetExtendedErrorCode();
    HRESULT SetErrorCode(MF_MEDIA_ENGINE_ERR error);
    HRESULT SetExtendedErrorCode(HRESULT error);
}

const GUID IID_IMFMediaTimeRange = {0xDB71A2FC, 0x078A, 0x414E, [0x9D, 0xF9, 0x8C, 0x25, 0x31, 0xB0, 0xAA, 0x6C]};
@GUID(0xDB71A2FC, 0x078A, 0x414E, [0x9D, 0xF9, 0x8C, 0x25, 0x31, 0xB0, 0xAA, 0x6C]);
interface IMFMediaTimeRange : IUnknown
{
    uint GetLength();
    HRESULT GetStart(uint index, double* pStart);
    HRESULT GetEnd(uint index, double* pEnd);
    BOOL ContainsTime(double time);
    HRESULT AddRange(double startTime, double endTime);
    HRESULT Clear();
}

enum MF_MEDIA_ENGINE_EVENT
{
    MF_MEDIA_ENGINE_EVENT_LOADSTART = 1,
    MF_MEDIA_ENGINE_EVENT_PROGRESS = 2,
    MF_MEDIA_ENGINE_EVENT_SUSPEND = 3,
    MF_MEDIA_ENGINE_EVENT_ABORT = 4,
    MF_MEDIA_ENGINE_EVENT_ERROR = 5,
    MF_MEDIA_ENGINE_EVENT_EMPTIED = 6,
    MF_MEDIA_ENGINE_EVENT_STALLED = 7,
    MF_MEDIA_ENGINE_EVENT_PLAY = 8,
    MF_MEDIA_ENGINE_EVENT_PAUSE = 9,
    MF_MEDIA_ENGINE_EVENT_LOADEDMETADATA = 10,
    MF_MEDIA_ENGINE_EVENT_LOADEDDATA = 11,
    MF_MEDIA_ENGINE_EVENT_WAITING = 12,
    MF_MEDIA_ENGINE_EVENT_PLAYING = 13,
    MF_MEDIA_ENGINE_EVENT_CANPLAY = 14,
    MF_MEDIA_ENGINE_EVENT_CANPLAYTHROUGH = 15,
    MF_MEDIA_ENGINE_EVENT_SEEKING = 16,
    MF_MEDIA_ENGINE_EVENT_SEEKED = 17,
    MF_MEDIA_ENGINE_EVENT_TIMEUPDATE = 18,
    MF_MEDIA_ENGINE_EVENT_ENDED = 19,
    MF_MEDIA_ENGINE_EVENT_RATECHANGE = 20,
    MF_MEDIA_ENGINE_EVENT_DURATIONCHANGE = 21,
    MF_MEDIA_ENGINE_EVENT_VOLUMECHANGE = 22,
    MF_MEDIA_ENGINE_EVENT_FORMATCHANGE = 1000,
    MF_MEDIA_ENGINE_EVENT_PURGEQUEUEDEVENTS = 1001,
    MF_MEDIA_ENGINE_EVENT_TIMELINE_MARKER = 1002,
    MF_MEDIA_ENGINE_EVENT_BALANCECHANGE = 1003,
    MF_MEDIA_ENGINE_EVENT_DOWNLOADCOMPLETE = 1004,
    MF_MEDIA_ENGINE_EVENT_BUFFERINGSTARTED = 1005,
    MF_MEDIA_ENGINE_EVENT_BUFFERINGENDED = 1006,
    MF_MEDIA_ENGINE_EVENT_FRAMESTEPCOMPLETED = 1007,
    MF_MEDIA_ENGINE_EVENT_NOTIFYSTABLESTATE = 1008,
    MF_MEDIA_ENGINE_EVENT_FIRSTFRAMEREADY = 1009,
    MF_MEDIA_ENGINE_EVENT_TRACKSCHANGE = 1010,
    MF_MEDIA_ENGINE_EVENT_OPMINFO = 1011,
    MF_MEDIA_ENGINE_EVENT_RESOURCELOST = 1012,
    MF_MEDIA_ENGINE_EVENT_DELAYLOADEVENT_CHANGED = 1013,
    MF_MEDIA_ENGINE_EVENT_STREAMRENDERINGERROR = 1014,
    MF_MEDIA_ENGINE_EVENT_SUPPORTEDRATES_CHANGED = 1015,
    MF_MEDIA_ENGINE_EVENT_AUDIOENDPOINTCHANGE = 1016,
}

const GUID IID_IMFMediaEngineNotify = {0xFEE7C112, 0xE776, 0x42B5, [0x9B, 0xBF, 0x00, 0x48, 0x52, 0x4E, 0x2B, 0xD5]};
@GUID(0xFEE7C112, 0xE776, 0x42B5, [0x9B, 0xBF, 0x00, 0x48, 0x52, 0x4E, 0x2B, 0xD5]);
interface IMFMediaEngineNotify : IUnknown
{
    HRESULT EventNotify(uint event, uint param1, uint param2);
}

const GUID IID_IMFMediaEngineSrcElements = {0x7A5E5354, 0xB114, 0x4C72, [0xB9, 0x91, 0x31, 0x31, 0xD7, 0x50, 0x32, 0xEA]};
@GUID(0x7A5E5354, 0xB114, 0x4C72, [0xB9, 0x91, 0x31, 0x31, 0xD7, 0x50, 0x32, 0xEA]);
interface IMFMediaEngineSrcElements : IUnknown
{
    uint GetLength();
    HRESULT GetURL(uint index, BSTR* pURL);
    HRESULT GetType(uint index, BSTR* pType);
    HRESULT GetMedia(uint index, BSTR* pMedia);
    HRESULT AddElement(BSTR pURL, BSTR pType, BSTR pMedia);
    HRESULT RemoveAllElements();
}

enum MF_MEDIA_ENGINE_NETWORK
{
    MF_MEDIA_ENGINE_NETWORK_EMPTY = 0,
    MF_MEDIA_ENGINE_NETWORK_IDLE = 1,
    MF_MEDIA_ENGINE_NETWORK_LOADING = 2,
    MF_MEDIA_ENGINE_NETWORK_NO_SOURCE = 3,
}

enum MF_MEDIA_ENGINE_READY
{
    MF_MEDIA_ENGINE_READY_HAVE_NOTHING = 0,
    MF_MEDIA_ENGINE_READY_HAVE_METADATA = 1,
    MF_MEDIA_ENGINE_READY_HAVE_CURRENT_DATA = 2,
    MF_MEDIA_ENGINE_READY_HAVE_FUTURE_DATA = 3,
    MF_MEDIA_ENGINE_READY_HAVE_ENOUGH_DATA = 4,
}

enum MF_MEDIA_ENGINE_CANPLAY
{
    MF_MEDIA_ENGINE_CANPLAY_NOT_SUPPORTED = 0,
    MF_MEDIA_ENGINE_CANPLAY_MAYBE = 1,
    MF_MEDIA_ENGINE_CANPLAY_PROBABLY = 2,
}

enum MF_MEDIA_ENGINE_PRELOAD
{
    MF_MEDIA_ENGINE_PRELOAD_MISSING = 0,
    MF_MEDIA_ENGINE_PRELOAD_EMPTY = 1,
    MF_MEDIA_ENGINE_PRELOAD_NONE = 2,
    MF_MEDIA_ENGINE_PRELOAD_METADATA = 3,
    MF_MEDIA_ENGINE_PRELOAD_AUTOMATIC = 4,
}

const GUID IID_IMFMediaEngine = {0x98A1B0BB, 0x03EB, 0x4935, [0xAE, 0x7C, 0x93, 0xC1, 0xFA, 0x0E, 0x1C, 0x93]};
@GUID(0x98A1B0BB, 0x03EB, 0x4935, [0xAE, 0x7C, 0x93, 0xC1, 0xFA, 0x0E, 0x1C, 0x93]);
interface IMFMediaEngine : IUnknown
{
    HRESULT GetError(IMFMediaError* ppError);
    HRESULT SetErrorCode(MF_MEDIA_ENGINE_ERR error);
    HRESULT SetSourceElements(IMFMediaEngineSrcElements pSrcElements);
    HRESULT SetSource(BSTR pUrl);
    HRESULT GetCurrentSource(BSTR* ppUrl);
    ushort GetNetworkState();
    MF_MEDIA_ENGINE_PRELOAD GetPreload();
    HRESULT SetPreload(MF_MEDIA_ENGINE_PRELOAD Preload);
    HRESULT GetBuffered(IMFMediaTimeRange* ppBuffered);
    HRESULT Load();
    HRESULT CanPlayType(BSTR type, MF_MEDIA_ENGINE_CANPLAY* pAnswer);
    ushort GetReadyState();
    BOOL IsSeeking();
    double GetCurrentTime();
    HRESULT SetCurrentTime(double seekTime);
    double GetStartTime();
    double GetDuration();
    BOOL IsPaused();
    double GetDefaultPlaybackRate();
    HRESULT SetDefaultPlaybackRate(double Rate);
    double GetPlaybackRate();
    HRESULT SetPlaybackRate(double Rate);
    HRESULT GetPlayed(IMFMediaTimeRange* ppPlayed);
    HRESULT GetSeekable(IMFMediaTimeRange* ppSeekable);
    BOOL IsEnded();
    BOOL GetAutoPlay();
    HRESULT SetAutoPlay(BOOL AutoPlay);
    BOOL GetLoop();
    HRESULT SetLoop(BOOL Loop);
    HRESULT Play();
    HRESULT Pause();
    BOOL GetMuted();
    HRESULT SetMuted(BOOL Muted);
    double GetVolume();
    HRESULT SetVolume(double Volume);
    BOOL HasVideo();
    BOOL HasAudio();
    HRESULT GetNativeVideoSize(uint* cx, uint* cy);
    HRESULT GetVideoAspectRatio(uint* cx, uint* cy);
    HRESULT Shutdown();
    HRESULT TransferVideoFrame(IUnknown pDstSurf, const(MFVideoNormalizedRect)* pSrc, const(RECT)* pDst, const(MFARGB)* pBorderClr);
    HRESULT OnVideoStreamTick(long* pPts);
}

enum MF_MEDIA_ENGINE_S3D_PACKING_MODE
{
    MF_MEDIA_ENGINE_S3D_PACKING_MODE_NONE = 0,
    MF_MEDIA_ENGINE_S3D_PACKING_MODE_SIDE_BY_SIDE = 1,
    MF_MEDIA_ENGINE_S3D_PACKING_MODE_TOP_BOTTOM = 2,
}

enum MF_MEDIA_ENGINE_STATISTIC
{
    MF_MEDIA_ENGINE_STATISTIC_FRAMES_RENDERED = 0,
    MF_MEDIA_ENGINE_STATISTIC_FRAMES_DROPPED = 1,
    MF_MEDIA_ENGINE_STATISTIC_BYTES_DOWNLOADED = 2,
    MF_MEDIA_ENGINE_STATISTIC_BUFFER_PROGRESS = 3,
    MF_MEDIA_ENGINE_STATISTIC_FRAMES_PER_SECOND = 4,
    MF_MEDIA_ENGINE_STATISTIC_PLAYBACK_JITTER = 5,
    MF_MEDIA_ENGINE_STATISTIC_FRAMES_CORRUPTED = 6,
    MF_MEDIA_ENGINE_STATISTIC_TOTAL_FRAME_DELAY = 7,
}

enum MF_MEDIA_ENGINE_SEEK_MODE
{
    MF_MEDIA_ENGINE_SEEK_MODE_NORMAL = 0,
    MF_MEDIA_ENGINE_SEEK_MODE_APPROXIMATE = 1,
}

const GUID IID_IMFMediaEngineEx = {0x83015EAD, 0xB1E6, 0x40D0, [0xA9, 0x8A, 0x37, 0x14, 0x5F, 0xFE, 0x1A, 0xD1]};
@GUID(0x83015EAD, 0xB1E6, 0x40D0, [0xA9, 0x8A, 0x37, 0x14, 0x5F, 0xFE, 0x1A, 0xD1]);
interface IMFMediaEngineEx : IMFMediaEngine
{
    HRESULT SetSourceFromByteStream(IMFByteStream pByteStream, BSTR pURL);
    HRESULT GetStatistics(MF_MEDIA_ENGINE_STATISTIC StatisticID, PROPVARIANT* pStatistic);
    HRESULT UpdateVideoStream(const(MFVideoNormalizedRect)* pSrc, const(RECT)* pDst, const(MFARGB)* pBorderClr);
    double GetBalance();
    HRESULT SetBalance(double balance);
    BOOL IsPlaybackRateSupported(double rate);
    HRESULT FrameStep(BOOL Forward);
    HRESULT GetResourceCharacteristics(uint* pCharacteristics);
    HRESULT GetPresentationAttribute(const(Guid)* guidMFAttribute, PROPVARIANT* pvValue);
    HRESULT GetNumberOfStreams(uint* pdwStreamCount);
    HRESULT GetStreamAttribute(uint dwStreamIndex, const(Guid)* guidMFAttribute, PROPVARIANT* pvValue);
    HRESULT GetStreamSelection(uint dwStreamIndex, int* pEnabled);
    HRESULT SetStreamSelection(uint dwStreamIndex, BOOL Enabled);
    HRESULT ApplyStreamSelections();
    HRESULT IsProtected(int* pProtected);
    HRESULT InsertVideoEffect(IUnknown pEffect, BOOL fOptional);
    HRESULT InsertAudioEffect(IUnknown pEffect, BOOL fOptional);
    HRESULT RemoveAllEffects();
    HRESULT SetTimelineMarkerTimer(double timeToFire);
    HRESULT GetTimelineMarkerTimer(double* pTimeToFire);
    HRESULT CancelTimelineMarkerTimer();
    BOOL IsStereo3D();
    HRESULT GetStereo3DFramePackingMode(MF_MEDIA_ENGINE_S3D_PACKING_MODE* packMode);
    HRESULT SetStereo3DFramePackingMode(MF_MEDIA_ENGINE_S3D_PACKING_MODE packMode);
    HRESULT GetStereo3DRenderMode(MF3DVideoOutputType* outputType);
    HRESULT SetStereo3DRenderMode(MF3DVideoOutputType outputType);
    HRESULT EnableWindowlessSwapchainMode(BOOL fEnable);
    HRESULT GetVideoSwapchainHandle(HANDLE* phSwapchain);
    HRESULT EnableHorizontalMirrorMode(BOOL fEnable);
    HRESULT GetAudioStreamCategory(uint* pCategory);
    HRESULT SetAudioStreamCategory(uint category);
    HRESULT GetAudioEndpointRole(uint* pRole);
    HRESULT SetAudioEndpointRole(uint role);
    HRESULT GetRealTimeMode(int* pfEnabled);
    HRESULT SetRealTimeMode(BOOL fEnable);
    HRESULT SetCurrentTimeEx(double seekTime, MF_MEDIA_ENGINE_SEEK_MODE seekMode);
    HRESULT EnableTimeUpdateTimer(BOOL fEnableTimer);
}

const GUID IID_IMFMediaEngineAudioEndpointId = {0x7A3BAC98, 0x0E76, 0x49FB, [0x8C, 0x20, 0x8A, 0x86, 0xFD, 0x98, 0xEA, 0xF2]};
@GUID(0x7A3BAC98, 0x0E76, 0x49FB, [0x8C, 0x20, 0x8A, 0x86, 0xFD, 0x98, 0xEA, 0xF2]);
interface IMFMediaEngineAudioEndpointId : IUnknown
{
    HRESULT SetAudioEndpointId(const(wchar)* pszEndpointId);
    HRESULT GetAudioEndpointId(ushort** ppszEndpointId);
}

enum MF_MEDIA_ENGINE_EXTENSION_TYPE
{
    MF_MEDIA_ENGINE_EXTENSION_TYPE_MEDIASOURCE = 0,
    MF_MEDIA_ENGINE_EXTENSION_TYPE_BYTESTREAM = 1,
}

const GUID IID_IMFMediaEngineExtension = {0x2F69D622, 0x20B5, 0x41E9, [0xAF, 0xDF, 0x89, 0xCE, 0xD1, 0xDD, 0xA0, 0x4E]};
@GUID(0x2F69D622, 0x20B5, 0x41E9, [0xAF, 0xDF, 0x89, 0xCE, 0xD1, 0xDD, 0xA0, 0x4E]);
interface IMFMediaEngineExtension : IUnknown
{
    HRESULT CanPlayType(BOOL AudioOnly, BSTR MimeType, MF_MEDIA_ENGINE_CANPLAY* pAnswer);
    HRESULT BeginCreateObject(BSTR bstrURL, IMFByteStream pByteStream, MF_OBJECT_TYPE type, IUnknown* ppIUnknownCancelCookie, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT CancelObjectCreation(IUnknown pIUnknownCancelCookie);
    HRESULT EndCreateObject(IMFAsyncResult pResult, IUnknown* ppObject);
}

enum MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAGS
{
    MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_PROTECTED = 1,
    MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_REQUIRES_SURFACE_PROTECTION = 2,
    MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_REQUIRES_ANTI_SCREEN_SCRAPE_PROTECTION = 4,
}

const GUID IID_IMFMediaEngineProtectedContent = {0x9F8021E8, 0x9C8C, 0x487E, [0xBB, 0x5C, 0x79, 0xAA, 0x47, 0x79, 0x93, 0x8C]};
@GUID(0x9F8021E8, 0x9C8C, 0x487E, [0xBB, 0x5C, 0x79, 0xAA, 0x47, 0x79, 0x93, 0x8C]);
interface IMFMediaEngineProtectedContent : IUnknown
{
    HRESULT ShareResources(IUnknown pUnkDeviceContext);
    HRESULT GetRequiredProtections(uint* pFrameProtectionFlags);
    HRESULT SetOPMWindow(HWND hwnd);
    HRESULT TransferVideoFrame(IUnknown pDstSurf, const(MFVideoNormalizedRect)* pSrc, const(RECT)* pDst, const(MFARGB)* pBorderClr, uint* pFrameProtectionFlags);
    HRESULT SetContentProtectionManager(IMFContentProtectionManager pCPM);
    HRESULT SetApplicationCertificate(char* pbBlob, uint cbBlob);
}

const GUID IID_IAudioSourceProvider = {0xEBBAF249, 0xAFC2, 0x4582, [0x91, 0xC6, 0xB6, 0x0D, 0xF2, 0xE8, 0x49, 0x54]};
@GUID(0xEBBAF249, 0xAFC2, 0x4582, [0x91, 0xC6, 0xB6, 0x0D, 0xF2, 0xE8, 0x49, 0x54]);
interface IAudioSourceProvider : IUnknown
{
    HRESULT ProvideInput(uint dwSampleCount, uint* pdwChannelCount, char* pInterleavedAudioData);
}

const GUID IID_IMFMediaEngineWebSupport = {0xBA2743A1, 0x07E0, 0x48EF, [0x84, 0xB6, 0x9A, 0x2E, 0xD0, 0x23, 0xCA, 0x6C]};
@GUID(0xBA2743A1, 0x07E0, 0x48EF, [0x84, 0xB6, 0x9A, 0x2E, 0xD0, 0x23, 0xCA, 0x6C]);
interface IMFMediaEngineWebSupport : IUnknown
{
    BOOL ShouldDelayTheLoadEvent();
    HRESULT ConnectWebAudio(uint dwSampleRate, IAudioSourceProvider* ppSourceProvider);
    HRESULT DisconnectWebAudio();
}

enum MF_MSE_VP9_SUPPORT_TYPE
{
    MF_MSE_VP9_SUPPORT_DEFAULT = 0,
    MF_MSE_VP9_SUPPORT_ON = 1,
    MF_MSE_VP9_SUPPORT_OFF = 2,
}

enum MF_MSE_OPUS_SUPPORT_TYPE
{
    MF_MSE_OPUS_SUPPORT_ON = 0,
    MF_MSE_OPUS_SUPPORT_OFF = 1,
}

const GUID IID_IMFMediaSourceExtensionNotify = {0xA7901327, 0x05DD, 0x4469, [0xA7, 0xB7, 0x0E, 0x01, 0x97, 0x9E, 0x36, 0x1D]};
@GUID(0xA7901327, 0x05DD, 0x4469, [0xA7, 0xB7, 0x0E, 0x01, 0x97, 0x9E, 0x36, 0x1D]);
interface IMFMediaSourceExtensionNotify : IUnknown
{
    void OnSourceOpen();
    void OnSourceEnded();
    void OnSourceClose();
}

const GUID IID_IMFBufferListNotify = {0x24CD47F7, 0x81D8, 0x4785, [0xAD, 0xB2, 0xAF, 0x69, 0x7A, 0x96, 0x3C, 0xD2]};
@GUID(0x24CD47F7, 0x81D8, 0x4785, [0xAD, 0xB2, 0xAF, 0x69, 0x7A, 0x96, 0x3C, 0xD2]);
interface IMFBufferListNotify : IUnknown
{
    void OnAddSourceBuffer();
    void OnRemoveSourceBuffer();
}

const GUID IID_IMFSourceBufferNotify = {0x87E47623, 0x2CEB, 0x45D6, [0x9B, 0x88, 0xD8, 0x52, 0x0C, 0x4D, 0xCB, 0xBC]};
@GUID(0x87E47623, 0x2CEB, 0x45D6, [0x9B, 0x88, 0xD8, 0x52, 0x0C, 0x4D, 0xCB, 0xBC]);
interface IMFSourceBufferNotify : IUnknown
{
    void OnUpdateStart();
    void OnAbort();
    void OnError(HRESULT hr);
    void OnUpdate();
    void OnUpdateEnd();
}

const GUID IID_IMFSourceBuffer = {0xE2CD3A4B, 0xAF25, 0x4D3D, [0x91, 0x10, 0xDA, 0x0E, 0x6F, 0x8E, 0xE8, 0x77]};
@GUID(0xE2CD3A4B, 0xAF25, 0x4D3D, [0x91, 0x10, 0xDA, 0x0E, 0x6F, 0x8E, 0xE8, 0x77]);
interface IMFSourceBuffer : IUnknown
{
    BOOL GetUpdating();
    HRESULT GetBuffered(IMFMediaTimeRange* ppBuffered);
    double GetTimeStampOffset();
    HRESULT SetTimeStampOffset(double offset);
    double GetAppendWindowStart();
    HRESULT SetAppendWindowStart(double time);
    double GetAppendWindowEnd();
    HRESULT SetAppendWindowEnd(double time);
    HRESULT Append(char* pData, uint len);
    HRESULT AppendByteStream(IMFByteStream pStream, ulong* pMaxLen);
    HRESULT Abort();
    HRESULT Remove(double start, double end);
}

enum MF_MSE_APPEND_MODE
{
    MF_MSE_APPEND_MODE_SEGMENTS = 0,
    MF_MSE_APPEND_MODE_SEQUENCE = 1,
}

const GUID IID_IMFSourceBufferAppendMode = {0x19666FB4, 0xBABE, 0x4C55, [0xBC, 0x03, 0x0A, 0x07, 0x4D, 0xA3, 0x7E, 0x2A]};
@GUID(0x19666FB4, 0xBABE, 0x4C55, [0xBC, 0x03, 0x0A, 0x07, 0x4D, 0xA3, 0x7E, 0x2A]);
interface IMFSourceBufferAppendMode : IUnknown
{
    MF_MSE_APPEND_MODE GetAppendMode();
    HRESULT SetAppendMode(MF_MSE_APPEND_MODE mode);
}

const GUID IID_IMFSourceBufferList = {0x249981F8, 0x8325, 0x41F3, [0xB8, 0x0C, 0x3B, 0x9E, 0x3A, 0xAD, 0x0C, 0xBE]};
@GUID(0x249981F8, 0x8325, 0x41F3, [0xB8, 0x0C, 0x3B, 0x9E, 0x3A, 0xAD, 0x0C, 0xBE]);
interface IMFSourceBufferList : IUnknown
{
    uint GetLength();
    IMFSourceBuffer GetSourceBuffer(uint index);
}

enum MF_MSE_READY
{
    MF_MSE_READY_CLOSED = 1,
    MF_MSE_READY_OPEN = 2,
    MF_MSE_READY_ENDED = 3,
}

enum MF_MSE_ERROR
{
    MF_MSE_ERROR_NOERROR = 0,
    MF_MSE_ERROR_NETWORK = 1,
    MF_MSE_ERROR_DECODE = 2,
    MF_MSE_ERROR_UNKNOWN_ERROR = 3,
}

const GUID IID_IMFMediaSourceExtension = {0xE467B94E, 0xA713, 0x4562, [0xA8, 0x02, 0x81, 0x6A, 0x42, 0xE9, 0x00, 0x8A]};
@GUID(0xE467B94E, 0xA713, 0x4562, [0xA8, 0x02, 0x81, 0x6A, 0x42, 0xE9, 0x00, 0x8A]);
interface IMFMediaSourceExtension : IUnknown
{
    IMFSourceBufferList GetSourceBuffers();
    IMFSourceBufferList GetActiveSourceBuffers();
    MF_MSE_READY GetReadyState();
    double GetDuration();
    HRESULT SetDuration(double duration);
    HRESULT AddSourceBuffer(BSTR type, IMFSourceBufferNotify pNotify, IMFSourceBuffer* ppSourceBuffer);
    HRESULT RemoveSourceBuffer(IMFSourceBuffer pSourceBuffer);
    HRESULT SetEndOfStream(MF_MSE_ERROR error);
    BOOL IsTypeSupported(BSTR type);
    IMFSourceBuffer GetSourceBuffer(uint dwStreamIndex);
}

const GUID IID_IMFMediaSourceExtensionLiveSeekableRange = {0x5D1ABFD6, 0x450A, 0x4D92, [0x9E, 0xFC, 0xD6, 0xB6, 0xCB, 0xC1, 0xF4, 0xDA]};
@GUID(0x5D1ABFD6, 0x450A, 0x4D92, [0x9E, 0xFC, 0xD6, 0xB6, 0xCB, 0xC1, 0xF4, 0xDA]);
interface IMFMediaSourceExtensionLiveSeekableRange : IUnknown
{
    HRESULT SetLiveSeekableRange(double start, double end);
    HRESULT ClearLiveSeekableRange();
}

const GUID IID_IMFMediaEngineEME = {0x50DC93E4, 0xBA4F, 0x4275, [0xAE, 0x66, 0x83, 0xE8, 0x36, 0xE5, 0x74, 0x69]};
@GUID(0x50DC93E4, 0xBA4F, 0x4275, [0xAE, 0x66, 0x83, 0xE8, 0x36, 0xE5, 0x74, 0x69]);
interface IMFMediaEngineEME : IUnknown
{
    HRESULT get_Keys(IMFMediaKeys* keys);
    HRESULT SetMediaKeys(IMFMediaKeys keys);
}

const GUID IID_IMFMediaEngineSrcElementsEx = {0x654A6BB3, 0xE1A3, 0x424A, [0x99, 0x08, 0x53, 0xA4, 0x3A, 0x0D, 0xFD, 0xA0]};
@GUID(0x654A6BB3, 0xE1A3, 0x424A, [0x99, 0x08, 0x53, 0xA4, 0x3A, 0x0D, 0xFD, 0xA0]);
interface IMFMediaEngineSrcElementsEx : IMFMediaEngineSrcElements
{
    HRESULT AddElementEx(BSTR pURL, BSTR pType, BSTR pMedia, BSTR keySystem);
    HRESULT GetKeySystem(uint index, BSTR* pType);
}

const GUID IID_IMFMediaEngineNeedKeyNotify = {0x46A30204, 0xA696, 0x4B18, [0x88, 0x04, 0x24, 0x6B, 0x8F, 0x03, 0x1B, 0xB1]};
@GUID(0x46A30204, 0xA696, 0x4B18, [0x88, 0x04, 0x24, 0x6B, 0x8F, 0x03, 0x1B, 0xB1]);
interface IMFMediaEngineNeedKeyNotify : IUnknown
{
    void NeedKey(char* initData, uint cb);
}

const GUID IID_IMFMediaKeys = {0x5CB31C05, 0x61FF, 0x418F, [0xAF, 0xDA, 0xCA, 0xAF, 0x41, 0x42, 0x1A, 0x38]};
@GUID(0x5CB31C05, 0x61FF, 0x418F, [0xAF, 0xDA, 0xCA, 0xAF, 0x41, 0x42, 0x1A, 0x38]);
interface IMFMediaKeys : IUnknown
{
    HRESULT CreateSession(BSTR mimeType, char* initData, uint cb, char* customData, uint cbCustomData, IMFMediaKeySessionNotify notify, IMFMediaKeySession* ppSession);
    HRESULT get_KeySystem(BSTR* keySystem);
    HRESULT Shutdown();
    HRESULT GetSuspendNotify(IMFCdmSuspendNotify* notify);
}

enum MF_MEDIA_ENGINE_KEYERR
{
    MF_MEDIAENGINE_KEYERR_UNKNOWN = 1,
    MF_MEDIAENGINE_KEYERR_CLIENT = 2,
    MF_MEDIAENGINE_KEYERR_SERVICE = 3,
    MF_MEDIAENGINE_KEYERR_OUTPUT = 4,
    MF_MEDIAENGINE_KEYERR_HARDWARECHANGE = 5,
    MF_MEDIAENGINE_KEYERR_DOMAIN = 6,
}

const GUID IID_IMFMediaKeySession = {0x24FA67D5, 0xD1D0, 0x4DC5, [0x99, 0x5C, 0xC0, 0xEF, 0xDC, 0x19, 0x1F, 0xB5]};
@GUID(0x24FA67D5, 0xD1D0, 0x4DC5, [0x99, 0x5C, 0xC0, 0xEF, 0xDC, 0x19, 0x1F, 0xB5]);
interface IMFMediaKeySession : IUnknown
{
    HRESULT GetError(ushort* code, uint* systemCode);
    HRESULT get_KeySystem(BSTR* keySystem);
    HRESULT get_SessionId(BSTR* sessionId);
    HRESULT Update(char* key, uint cb);
    HRESULT Close();
}

const GUID IID_IMFMediaKeySessionNotify = {0x6A0083F9, 0x8947, 0x4C1D, [0x9C, 0xE0, 0xCD, 0xEE, 0x22, 0xB2, 0x31, 0x35]};
@GUID(0x6A0083F9, 0x8947, 0x4C1D, [0x9C, 0xE0, 0xCD, 0xEE, 0x22, 0xB2, 0x31, 0x35]);
interface IMFMediaKeySessionNotify : IUnknown
{
    void KeyMessage(BSTR destinationURL, char* message, uint cb);
    void KeyAdded();
    void KeyError(ushort code, uint systemCode);
}

const GUID IID_IMFCdmSuspendNotify = {0x7A5645D2, 0x43BD, 0x47FD, [0x87, 0xB7, 0xDC, 0xD2, 0x4C, 0xC7, 0xD6, 0x92]};
@GUID(0x7A5645D2, 0x43BD, 0x47FD, [0x87, 0xB7, 0xDC, 0xD2, 0x4C, 0xC7, 0xD6, 0x92]);
interface IMFCdmSuspendNotify : IUnknown
{
    HRESULT Begin();
    HRESULT End();
}

enum MF_HDCP_STATUS
{
    MF_HDCP_STATUS_ON = 0,
    MF_HDCP_STATUS_OFF = 1,
    MF_HDCP_STATUS_ON_WITH_TYPE_ENFORCEMENT = 2,
}

const GUID IID_IMFHDCPStatus = {0xDE400F54, 0x5BF1, 0x40CF, [0x89, 0x64, 0x0B, 0xEA, 0x13, 0x6B, 0x1E, 0x3D]};
@GUID(0xDE400F54, 0x5BF1, 0x40CF, [0x89, 0x64, 0x0B, 0xEA, 0x13, 0x6B, 0x1E, 0x3D]);
interface IMFHDCPStatus : IUnknown
{
    HRESULT Query(MF_HDCP_STATUS* pStatus, int* pfStatus);
    HRESULT Set(MF_HDCP_STATUS status);
}

enum MF_MEDIA_ENGINE_OPM_STATUS
{
    MF_MEDIA_ENGINE_OPM_NOT_REQUESTED = 0,
    MF_MEDIA_ENGINE_OPM_ESTABLISHED = 1,
    MF_MEDIA_ENGINE_OPM_FAILED_VM = 2,
    MF_MEDIA_ENGINE_OPM_FAILED_BDA = 3,
    MF_MEDIA_ENGINE_OPM_FAILED_UNSIGNED_DRIVER = 4,
    MF_MEDIA_ENGINE_OPM_FAILED = 5,
}

const GUID IID_IMFMediaEngineOPMInfo = {0x765763E6, 0x6C01, 0x4B01, [0xBB, 0x0F, 0xB8, 0x29, 0xF6, 0x0E, 0xD2, 0x8C]};
@GUID(0x765763E6, 0x6C01, 0x4B01, [0xBB, 0x0F, 0xB8, 0x29, 0xF6, 0x0E, 0xD2, 0x8C]);
interface IMFMediaEngineOPMInfo : IUnknown
{
    HRESULT GetOPMInfo(MF_MEDIA_ENGINE_OPM_STATUS* pStatus, int* pConstricted);
}

enum MF_MEDIA_ENGINE_CREATEFLAGS
{
    MF_MEDIA_ENGINE_AUDIOONLY = 1,
    MF_MEDIA_ENGINE_WAITFORSTABLE_STATE = 2,
    MF_MEDIA_ENGINE_FORCEMUTE = 4,
    MF_MEDIA_ENGINE_REAL_TIME_MODE = 8,
    MF_MEDIA_ENGINE_DISABLE_LOCAL_PLUGINS = 16,
    MF_MEDIA_ENGINE_CREATEFLAGS_MASK = 31,
}

enum MF_MEDIA_ENGINE_PROTECTION_FLAGS
{
    MF_MEDIA_ENGINE_ENABLE_PROTECTED_CONTENT = 1,
    MF_MEDIA_ENGINE_USE_PMP_FOR_ALL_CONTENT = 2,
    MF_MEDIA_ENGINE_USE_UNPROTECTED_PMP = 4,
}

const GUID IID_IMFMediaEngineClassFactory = {0x4D645ACE, 0x26AA, 0x4688, [0x9B, 0xE1, 0xDF, 0x35, 0x16, 0x99, 0x0B, 0x93]};
@GUID(0x4D645ACE, 0x26AA, 0x4688, [0x9B, 0xE1, 0xDF, 0x35, 0x16, 0x99, 0x0B, 0x93]);
interface IMFMediaEngineClassFactory : IUnknown
{
    HRESULT CreateInstance(uint dwFlags, IMFAttributes pAttr, IMFMediaEngine* ppPlayer);
    HRESULT CreateTimeRange(IMFMediaTimeRange* ppTimeRange);
    HRESULT CreateError(IMFMediaError* ppError);
}

const GUID IID_IMFMediaEngineClassFactoryEx = {0xC56156C6, 0xEA5B, 0x48A5, [0x9D, 0xF8, 0xFB, 0xE0, 0x35, 0xD0, 0x92, 0x9E]};
@GUID(0xC56156C6, 0xEA5B, 0x48A5, [0x9D, 0xF8, 0xFB, 0xE0, 0x35, 0xD0, 0x92, 0x9E]);
interface IMFMediaEngineClassFactoryEx : IMFMediaEngineClassFactory
{
    HRESULT CreateMediaSourceExtension(uint dwFlags, IMFAttributes pAttr, IMFMediaSourceExtension* ppMSE);
    HRESULT CreateMediaKeys(BSTR keySystem, BSTR cdmStorePath, IMFMediaKeys* ppKeys);
    HRESULT IsTypeSupported(BSTR type, BSTR keySystem, int* isSupported);
}

const GUID IID_IMFMediaEngineClassFactory2 = {0x09083CEF, 0x867F, 0x4BF6, [0x87, 0x76, 0xDE, 0xE3, 0xA7, 0xB4, 0x2F, 0xCA]};
@GUID(0x09083CEF, 0x867F, 0x4BF6, [0x87, 0x76, 0xDE, 0xE3, 0xA7, 0xB4, 0x2F, 0xCA]);
interface IMFMediaEngineClassFactory2 : IUnknown
{
    HRESULT CreateMediaKeys2(BSTR keySystem, BSTR defaultCdmStorePath, BSTR inprivateCdmStorePath, IMFMediaKeys* ppKeys);
}

const GUID IID_IMFExtendedDRMTypeSupport = {0x332EC562, 0x3758, 0x468D, [0xA7, 0x84, 0xE3, 0x8F, 0x23, 0x55, 0x21, 0x28]};
@GUID(0x332EC562, 0x3758, 0x468D, [0xA7, 0x84, 0xE3, 0x8F, 0x23, 0x55, 0x21, 0x28]);
interface IMFExtendedDRMTypeSupport : IUnknown
{
    HRESULT IsTypeSupportedEx(BSTR type, BSTR keySystem, MF_MEDIA_ENGINE_CANPLAY* pAnswer);
}

const GUID IID_IMFMediaEngineSupportsSourceTransfer = {0xA724B056, 0x1B2E, 0x4642, [0xA6, 0xF3, 0xDB, 0x94, 0x20, 0xC5, 0x29, 0x08]};
@GUID(0xA724B056, 0x1B2E, 0x4642, [0xA6, 0xF3, 0xDB, 0x94, 0x20, 0xC5, 0x29, 0x08]);
interface IMFMediaEngineSupportsSourceTransfer : IUnknown
{
    HRESULT ShouldTransferSource(int* pfShouldTransfer);
    HRESULT DetachMediaSource(IMFByteStream* ppByteStream, IMFMediaSource* ppMediaSource, IMFMediaSourceExtension* ppMSE);
    HRESULT AttachMediaSource(IMFByteStream pByteStream, IMFMediaSource pMediaSource, IMFMediaSourceExtension pMSE);
}

const GUID IID_IMFMediaEngineTransferSource = {0x24230452, 0xFE54, 0x40CC, [0x94, 0xF3, 0xFC, 0xC3, 0x94, 0xC3, 0x40, 0xD6]};
@GUID(0x24230452, 0xFE54, 0x40CC, [0x94, 0xF3, 0xFC, 0xC3, 0x94, 0xC3, 0x40, 0xD6]);
interface IMFMediaEngineTransferSource : IUnknown
{
    HRESULT TransferSourceToMediaEngine(IMFMediaEngine destination);
}

enum MF_TIMED_TEXT_TRACK_KIND
{
    MF_TIMED_TEXT_TRACK_KIND_UNKNOWN = 0,
    MF_TIMED_TEXT_TRACK_KIND_SUBTITLES = 1,
    MF_TIMED_TEXT_TRACK_KIND_CAPTIONS = 2,
    MF_TIMED_TEXT_TRACK_KIND_METADATA = 3,
}

enum MF_TIMED_TEXT_UNIT_TYPE
{
    MF_TIMED_TEXT_UNIT_TYPE_PIXELS = 0,
    MF_TIMED_TEXT_UNIT_TYPE_PERCENTAGE = 1,
}

enum MF_TIMED_TEXT_FONT_STYLE
{
    MF_TIMED_TEXT_FONT_STYLE_NORMAL = 0,
    MF_TIMED_TEXT_FONT_STYLE_OBLIQUE = 1,
    MF_TIMED_TEXT_FONT_STYLE_ITALIC = 2,
}

enum MF_TIMED_TEXT_ALIGNMENT
{
    MF_TIMED_TEXT_ALIGNMENT_START = 0,
    MF_TIMED_TEXT_ALIGNMENT_END = 1,
    MF_TIMED_TEXT_ALIGNMENT_CENTER = 2,
}

enum MF_TIMED_TEXT_DISPLAY_ALIGNMENT
{
    MF_TIMED_TEXT_DISPLAY_ALIGNMENT_BEFORE = 0,
    MF_TIMED_TEXT_DISPLAY_ALIGNMENT_AFTER = 1,
    MF_TIMED_TEXT_DISPLAY_ALIGNMENT_CENTER = 2,
}

enum MF_TIMED_TEXT_DECORATION
{
    MF_TIMED_TEXT_DECORATION_NONE = 0,
    MF_TIMED_TEXT_DECORATION_UNDERLINE = 1,
    MF_TIMED_TEXT_DECORATION_LINE_THROUGH = 2,
    MF_TIMED_TEXT_DECORATION_OVERLINE = 4,
}

enum MF_TIMED_TEXT_WRITING_MODE
{
    MF_TIMED_TEXT_WRITING_MODE_LRTB = 0,
    MF_TIMED_TEXT_WRITING_MODE_RLTB = 1,
    MF_TIMED_TEXT_WRITING_MODE_TBRL = 2,
    MF_TIMED_TEXT_WRITING_MODE_TBLR = 3,
    MF_TIMED_TEXT_WRITING_MODE_LR = 4,
    MF_TIMED_TEXT_WRITING_MODE_RL = 5,
    MF_TIMED_TEXT_WRITING_MODE_TB = 6,
}

enum MF_TIMED_TEXT_SCROLL_MODE
{
    MF_TIMED_TEXT_SCROLL_MODE_POP_ON = 0,
    MF_TIMED_TEXT_SCROLL_MODE_ROLL_UP = 1,
}

enum MF_TIMED_TEXT_ERROR_CODE
{
    MF_TIMED_TEXT_ERROR_CODE_NOERROR = 0,
    MF_TIMED_TEXT_ERROR_CODE_FATAL = 1,
    MF_TIMED_TEXT_ERROR_CODE_DATA_FORMAT = 2,
    MF_TIMED_TEXT_ERROR_CODE_NETWORK = 3,
    MF_TIMED_TEXT_ERROR_CODE_INTERNAL = 4,
}

enum MF_TIMED_TEXT_CUE_EVENT
{
    MF_TIMED_TEXT_CUE_EVENT_ACTIVE = 0,
    MF_TIMED_TEXT_CUE_EVENT_INACTIVE = 1,
    MF_TIMED_TEXT_CUE_EVENT_CLEAR = 2,
}

enum MF_TIMED_TEXT_TRACK_READY_STATE
{
    MF_TIMED_TEXT_TRACK_READY_STATE_NONE = 0,
    MF_TIMED_TEXT_TRACK_READY_STATE_LOADING = 1,
    MF_TIMED_TEXT_TRACK_READY_STATE_LOADED = 2,
    MF_TIMED_TEXT_TRACK_READY_STATE_ERROR = 3,
}

const GUID IID_IMFTimedText = {0x1F2A94C9, 0xA3DF, 0x430D, [0x9D, 0x0F, 0xAC, 0xD8, 0x5D, 0xDC, 0x29, 0xAF]};
@GUID(0x1F2A94C9, 0xA3DF, 0x430D, [0x9D, 0x0F, 0xAC, 0xD8, 0x5D, 0xDC, 0x29, 0xAF]);
interface IMFTimedText : IUnknown
{
    HRESULT RegisterNotifications(IMFTimedTextNotify notify);
    HRESULT SelectTrack(uint trackId, BOOL selected);
    HRESULT AddDataSource(IMFByteStream byteStream, const(wchar)* label, const(wchar)* language, MF_TIMED_TEXT_TRACK_KIND kind, BOOL isDefault, uint* trackId);
    HRESULT AddDataSourceFromUrl(const(wchar)* url, const(wchar)* label, const(wchar)* language, MF_TIMED_TEXT_TRACK_KIND kind, BOOL isDefault, uint* trackId);
    HRESULT AddTrack(const(wchar)* label, const(wchar)* language, MF_TIMED_TEXT_TRACK_KIND kind, IMFTimedTextTrack* track);
    HRESULT RemoveTrack(IMFTimedTextTrack track);
    HRESULT GetCueTimeOffset(double* offset);
    HRESULT SetCueTimeOffset(double offset);
    HRESULT GetTracks(IMFTimedTextTrackList* tracks);
    HRESULT GetActiveTracks(IMFTimedTextTrackList* activeTracks);
    HRESULT GetTextTracks(IMFTimedTextTrackList* textTracks);
    HRESULT GetMetadataTracks(IMFTimedTextTrackList* metadataTracks);
    HRESULT SetInBandEnabled(BOOL enabled);
    BOOL IsInBandEnabled();
}

const GUID IID_IMFTimedTextNotify = {0xDF6B87B6, 0xCE12, 0x45DB, [0xAB, 0xA7, 0x43, 0x2F, 0xE0, 0x54, 0xE5, 0x7D]};
@GUID(0xDF6B87B6, 0xCE12, 0x45DB, [0xAB, 0xA7, 0x43, 0x2F, 0xE0, 0x54, 0xE5, 0x7D]);
interface IMFTimedTextNotify : IUnknown
{
    void TrackAdded(uint trackId);
    void TrackRemoved(uint trackId);
    void TrackSelected(uint trackId, BOOL selected);
    void TrackReadyStateChanged(uint trackId);
    void Error(MF_TIMED_TEXT_ERROR_CODE errorCode, HRESULT extendedErrorCode, uint sourceTrackId);
    void Cue(MF_TIMED_TEXT_CUE_EVENT cueEvent, double currentTime, IMFTimedTextCue cue);
    void Reset();
}

const GUID IID_IMFTimedTextTrack = {0x8822C32D, 0x654E, 0x4233, [0xBF, 0x21, 0xD7, 0xF2, 0xE6, 0x7D, 0x30, 0xD4]};
@GUID(0x8822C32D, 0x654E, 0x4233, [0xBF, 0x21, 0xD7, 0xF2, 0xE6, 0x7D, 0x30, 0xD4]);
interface IMFTimedTextTrack : IUnknown
{
    uint GetId();
    HRESULT GetLabel(ushort** label);
    HRESULT SetLabel(const(wchar)* label);
    HRESULT GetLanguage(ushort** language);
    MF_TIMED_TEXT_TRACK_KIND GetTrackKind();
    BOOL IsInBand();
    HRESULT GetInBandMetadataTrackDispatchType(ushort** dispatchType);
    BOOL IsActive();
    MF_TIMED_TEXT_ERROR_CODE GetErrorCode();
    HRESULT GetExtendedErrorCode();
    HRESULT GetDataFormat(Guid* format);
    MF_TIMED_TEXT_TRACK_READY_STATE GetReadyState();
    HRESULT GetCueList(IMFTimedTextCueList* cues);
}

const GUID IID_IMFTimedTextTrackList = {0x23FF334C, 0x442C, 0x445F, [0xBC, 0xCC, 0xED, 0xC4, 0x38, 0xAA, 0x11, 0xE2]};
@GUID(0x23FF334C, 0x442C, 0x445F, [0xBC, 0xCC, 0xED, 0xC4, 0x38, 0xAA, 0x11, 0xE2]);
interface IMFTimedTextTrackList : IUnknown
{
    uint GetLength();
    HRESULT GetTrack(uint index, IMFTimedTextTrack* track);
    HRESULT GetTrackById(uint trackId, IMFTimedTextTrack* track);
}

const GUID IID_IMFTimedTextCue = {0x1E560447, 0x9A2B, 0x43E1, [0xA9, 0x4C, 0xB0, 0xAA, 0xAB, 0xFB, 0xFB, 0xC9]};
@GUID(0x1E560447, 0x9A2B, 0x43E1, [0xA9, 0x4C, 0xB0, 0xAA, 0xAB, 0xFB, 0xFB, 0xC9]);
interface IMFTimedTextCue : IUnknown
{
    uint GetId();
    HRESULT GetOriginalId(ushort** originalId);
    MF_TIMED_TEXT_TRACK_KIND GetCueKind();
    double GetStartTime();
    double GetDuration();
    uint GetTrackId();
    HRESULT GetData(IMFTimedTextBinary* data);
    HRESULT GetRegion(IMFTimedTextRegion* region);
    HRESULT GetStyle(IMFTimedTextStyle* style);
    uint GetLineCount();
    HRESULT GetLine(uint index, IMFTimedTextFormattedText* line);
}

const GUID IID_IMFTimedTextFormattedText = {0xE13AF3C1, 0x4D47, 0x4354, [0xB1, 0xF5, 0xE8, 0x3A, 0xE0, 0xEC, 0xAE, 0x60]};
@GUID(0xE13AF3C1, 0x4D47, 0x4354, [0xB1, 0xF5, 0xE8, 0x3A, 0xE0, 0xEC, 0xAE, 0x60]);
interface IMFTimedTextFormattedText : IUnknown
{
    HRESULT GetText(ushort** text);
    uint GetSubformattingCount();
    HRESULT GetSubformatting(uint index, uint* firstChar, uint* charLength, IMFTimedTextStyle* style);
}

const GUID IID_IMFTimedTextStyle = {0x09B2455D, 0xB834, 0x4F01, [0xA3, 0x47, 0x90, 0x52, 0xE2, 0x1C, 0x45, 0x0E]};
@GUID(0x09B2455D, 0xB834, 0x4F01, [0xA3, 0x47, 0x90, 0x52, 0xE2, 0x1C, 0x45, 0x0E]);
interface IMFTimedTextStyle : IUnknown
{
    HRESULT GetName(ushort** name);
    BOOL IsExternal();
    HRESULT GetFontFamily(ushort** fontFamily);
    HRESULT GetFontSize(double* fontSize, MF_TIMED_TEXT_UNIT_TYPE* unitType);
    HRESULT GetColor(MFARGB* color);
    HRESULT GetBackgroundColor(MFARGB* bgColor);
    HRESULT GetShowBackgroundAlways(int* showBackgroundAlways);
    HRESULT GetFontStyle(MF_TIMED_TEXT_FONT_STYLE* fontStyle);
    HRESULT GetBold(int* bold);
    HRESULT GetRightToLeft(int* rightToLeft);
    HRESULT GetTextAlignment(MF_TIMED_TEXT_ALIGNMENT* textAlign);
    HRESULT GetTextDecoration(uint* textDecoration);
    HRESULT GetTextOutline(MFARGB* color, double* thickness, double* blurRadius, MF_TIMED_TEXT_UNIT_TYPE* unitType);
}

const GUID IID_IMFTimedTextRegion = {0xC8D22AFC, 0xBC47, 0x4BDF, [0x9B, 0x04, 0x78, 0x7E, 0x49, 0xCE, 0x3F, 0x58]};
@GUID(0xC8D22AFC, 0xBC47, 0x4BDF, [0x9B, 0x04, 0x78, 0x7E, 0x49, 0xCE, 0x3F, 0x58]);
interface IMFTimedTextRegion : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetPosition(double* pX, double* pY, MF_TIMED_TEXT_UNIT_TYPE* unitType);
    HRESULT GetExtent(double* pWidth, double* pHeight, MF_TIMED_TEXT_UNIT_TYPE* unitType);
    HRESULT GetBackgroundColor(MFARGB* bgColor);
    HRESULT GetWritingMode(MF_TIMED_TEXT_WRITING_MODE* writingMode);
    HRESULT GetDisplayAlignment(MF_TIMED_TEXT_DISPLAY_ALIGNMENT* displayAlign);
    HRESULT GetLineHeight(double* pLineHeight, MF_TIMED_TEXT_UNIT_TYPE* unitType);
    HRESULT GetClipOverflow(int* clipOverflow);
    HRESULT GetPadding(double* before, double* start, double* after, double* end, MF_TIMED_TEXT_UNIT_TYPE* unitType);
    HRESULT GetWrap(int* wrap);
    HRESULT GetZIndex(int* zIndex);
    HRESULT GetScrollMode(MF_TIMED_TEXT_SCROLL_MODE* scrollMode);
}

const GUID IID_IMFTimedTextBinary = {0x4AE3A412, 0x0545, 0x43C4, [0xBF, 0x6F, 0x6B, 0x97, 0xA5, 0xC6, 0xC4, 0x32]};
@GUID(0x4AE3A412, 0x0545, 0x43C4, [0xBF, 0x6F, 0x6B, 0x97, 0xA5, 0xC6, 0xC4, 0x32]);
interface IMFTimedTextBinary : IUnknown
{
    HRESULT GetData(const(ubyte)** data, uint* length);
}

const GUID IID_IMFTimedTextCueList = {0xAD128745, 0x211B, 0x40A0, [0x99, 0x81, 0xFE, 0x65, 0xF1, 0x66, 0xD0, 0xFD]};
@GUID(0xAD128745, 0x211B, 0x40A0, [0x99, 0x81, 0xFE, 0x65, 0xF1, 0x66, 0xD0, 0xFD]);
interface IMFTimedTextCueList : IUnknown
{
    uint GetLength();
    HRESULT GetCueByIndex(uint index, IMFTimedTextCue* cue);
    HRESULT GetCueById(uint id, IMFTimedTextCue* cue);
    HRESULT GetCueByOriginalId(const(wchar)* originalId, IMFTimedTextCue* cue);
    HRESULT AddTextCue(double start, double duration, const(wchar)* text, IMFTimedTextCue* cue);
    HRESULT AddDataCue(double start, double duration, char* data, uint dataSize, IMFTimedTextCue* cue);
    HRESULT RemoveCue(IMFTimedTextCue cue);
}

enum MF_MEDIA_ENGINE_STREAMTYPE_FAILED
{
    MF_MEDIA_ENGINE_STREAMTYPE_FAILED_UNKNOWN = 0,
    MF_MEDIA_ENGINE_STREAMTYPE_FAILED_AUDIO = 1,
    MF_MEDIA_ENGINE_STREAMTYPE_FAILED_VIDEO = 2,
}

const GUID IID_IMFMediaEngineEMENotify = {0x9E184D15, 0xCDB7, 0x4F86, [0xB4, 0x9E, 0x56, 0x66, 0x89, 0xF4, 0xA6, 0x01]};
@GUID(0x9E184D15, 0xCDB7, 0x4F86, [0xB4, 0x9E, 0x56, 0x66, 0x89, 0xF4, 0xA6, 0x01]);
interface IMFMediaEngineEMENotify : IUnknown
{
    void Encrypted(char* pbInitData, uint cb, BSTR bstrInitDataType);
    void WaitingForKey();
}

enum MF_MEDIAKEYS_REQUIREMENT
{
    MF_MEDIAKEYS_REQUIREMENT_REQUIRED = 1,
    MF_MEDIAKEYS_REQUIREMENT_OPTIONAL = 2,
    MF_MEDIAKEYS_REQUIREMENT_NOT_ALLOWED = 3,
}

const GUID IID_IMFMediaKeySessionNotify2 = {0xC3A9E92A, 0xDA88, 0x46B0, [0xA1, 0x10, 0x6C, 0xF9, 0x53, 0x02, 0x6C, 0xB9]};
@GUID(0xC3A9E92A, 0xDA88, 0x46B0, [0xA1, 0x10, 0x6C, 0xF9, 0x53, 0x02, 0x6C, 0xB9]);
interface IMFMediaKeySessionNotify2 : IMFMediaKeySessionNotify
{
    void KeyMessage2(MF_MEDIAKEYSESSION_MESSAGETYPE eMessageType, BSTR destinationURL, char* pbMessage, uint cbMessage);
    void KeyStatusChange();
}

const GUID IID_IMFMediaKeySystemAccess = {0xAEC63FDA, 0x7A97, 0x4944, [0xB3, 0x5C, 0x6C, 0x6D, 0xF8, 0x08, 0x5C, 0xC3]};
@GUID(0xAEC63FDA, 0x7A97, 0x4944, [0xB3, 0x5C, 0x6C, 0x6D, 0xF8, 0x08, 0x5C, 0xC3]);
interface IMFMediaKeySystemAccess : IUnknown
{
    HRESULT CreateMediaKeys(IPropertyStore pCdmCustomConfig, IMFMediaKeys2* ppKeys);
    HRESULT get_SupportedConfiguration(IPropertyStore* ppSupportedConfiguration);
    HRESULT get_KeySystem(BSTR* pKeySystem);
}

const GUID IID_IMFMediaEngineClassFactory3 = {0x3787614F, 0x65F7, 0x4003, [0xB6, 0x73, 0xEA, 0xD8, 0x29, 0x3A, 0x0E, 0x60]};
@GUID(0x3787614F, 0x65F7, 0x4003, [0xB6, 0x73, 0xEA, 0xD8, 0x29, 0x3A, 0x0E, 0x60]);
interface IMFMediaEngineClassFactory3 : IUnknown
{
    HRESULT CreateMediaKeySystemAccess(BSTR keySystem, char* ppSupportedConfigurationsArray, uint uSize, IMFMediaKeySystemAccess* ppKeyAccess);
}

const GUID IID_IMFMediaKeys2 = {0x45892507, 0xAD66, 0x4DE2, [0x83, 0xA2, 0xAC, 0xBB, 0x13, 0xCD, 0x8D, 0x43]};
@GUID(0x45892507, 0xAD66, 0x4DE2, [0x83, 0xA2, 0xAC, 0xBB, 0x13, 0xCD, 0x8D, 0x43]);
interface IMFMediaKeys2 : IMFMediaKeys
{
    HRESULT CreateSession2(MF_MEDIAKEYSESSION_TYPE eSessionType, IMFMediaKeySessionNotify2 pMFMediaKeySessionNotify2, IMFMediaKeySession2* ppSession);
    HRESULT SetServerCertificate(char* pbServerCertificate, uint cb);
    HRESULT GetDOMException(HRESULT systemCode, int* code);
}

const GUID IID_IMFMediaKeySession2 = {0xE9707E05, 0x6D55, 0x4636, [0xB1, 0x85, 0x3D, 0xE2, 0x12, 0x10, 0xBD, 0x75]};
@GUID(0xE9707E05, 0x6D55, 0x4636, [0xB1, 0x85, 0x3D, 0xE2, 0x12, 0x10, 0xBD, 0x75]);
interface IMFMediaKeySession2 : IMFMediaKeySession
{
    HRESULT get_KeyStatuses(MFMediaKeyStatus** pKeyStatusesArray, uint* puSize);
    HRESULT Load(BSTR bstrSessionId, int* pfLoaded);
    HRESULT GenerateRequest(BSTR initDataType, char* pbInitData, uint cb);
    HRESULT get_Expiration(double* dblExpiration);
    HRESULT Remove();
    HRESULT Shutdown();
}

const GUID IID_IMFMediaEngineClassFactory4 = {0xFBE256C1, 0x43CF, 0x4A9B, [0x8C, 0xB8, 0xCE, 0x86, 0x32, 0xA3, 0x41, 0x86]};
@GUID(0xFBE256C1, 0x43CF, 0x4A9B, [0x8C, 0xB8, 0xCE, 0x86, 0x32, 0xA3, 0x41, 0x86]);
interface IMFMediaEngineClassFactory4 : IUnknown
{
    HRESULT CreateContentDecryptionModuleFactory(const(wchar)* keySystem, const(Guid)* riid, void** ppvObject);
}

const GUID IID_IMFDLNASinkInit = {0x0C012799, 0x1B61, 0x4C10, [0xBD, 0xA9, 0x04, 0x44, 0x5B, 0xE5, 0xF5, 0x61]};
@GUID(0x0C012799, 0x1B61, 0x4C10, [0xBD, 0xA9, 0x04, 0x44, 0x5B, 0xE5, 0xF5, 0x61]);
interface IMFDLNASinkInit : IUnknown
{
    HRESULT Initialize(IMFByteStream pByteStream, BOOL fPal);
}

struct MFMPEG2DLNASINKSTATS
{
    ulong cBytesWritten;
    BOOL fPAL;
    uint fccVideo;
    uint dwVideoWidth;
    uint dwVideoHeight;
    ulong cVideoFramesReceived;
    ulong cVideoFramesEncoded;
    ulong cVideoFramesSkipped;
    ulong cBlackVideoFramesEncoded;
    ulong cVideoFramesDuplicated;
    uint cAudioSamplesPerSec;
    uint cAudioChannels;
    ulong cAudioBytesReceived;
    ulong cAudioFramesEncoded;
}

const GUID IID_IMFReadWriteClassFactory = {0xE7FE2E12, 0x661C, 0x40DA, [0x92, 0xF9, 0x4F, 0x00, 0x2A, 0xB6, 0x76, 0x27]};
@GUID(0xE7FE2E12, 0x661C, 0x40DA, [0x92, 0xF9, 0x4F, 0x00, 0x2A, 0xB6, 0x76, 0x27]);
interface IMFReadWriteClassFactory : IUnknown
{
    HRESULT CreateInstanceFromURL(const(Guid)* clsid, const(wchar)* pwszURL, IMFAttributes pAttributes, const(Guid)* riid, void** ppvObject);
    HRESULT CreateInstanceFromObject(const(Guid)* clsid, IUnknown punkObject, IMFAttributes pAttributes, const(Guid)* riid, void** ppvObject);
}

enum MF_SOURCE_READER_FLAG
{
    MF_SOURCE_READERF_ERROR = 1,
    MF_SOURCE_READERF_ENDOFSTREAM = 2,
    MF_SOURCE_READERF_NEWSTREAM = 4,
    MF_SOURCE_READERF_NATIVEMEDIATYPECHANGED = 16,
    MF_SOURCE_READERF_CURRENTMEDIATYPECHANGED = 32,
    MF_SOURCE_READERF_STREAMTICK = 256,
    MF_SOURCE_READERF_ALLEFFECTSREMOVED = 512,
}

enum MF_SOURCE_READER_CONTROL_FLAG
{
    MF_SOURCE_READER_CONTROLF_DRAIN = 1,
}

enum __MIDL___MIDL_itf_mfreadwrite_0000_0001_0001
{
    MF_SOURCE_READER_INVALID_STREAM_INDEX = -1,
    MF_SOURCE_READER_ALL_STREAMS = -2,
    MF_SOURCE_READER_ANY_STREAM = -2,
    MF_SOURCE_READER_FIRST_AUDIO_STREAM = -3,
    MF_SOURCE_READER_FIRST_VIDEO_STREAM = -4,
    MF_SOURCE_READER_MEDIASOURCE = -1,
}

enum __MIDL___MIDL_itf_mfreadwrite_0000_0001_0002
{
    MF_SOURCE_READER_CURRENT_TYPE_INDEX = -1,
}

const GUID IID_IMFSourceReader = {0x70AE66F2, 0xC809, 0x4E4F, [0x89, 0x15, 0xBD, 0xCB, 0x40, 0x6B, 0x79, 0x93]};
@GUID(0x70AE66F2, 0xC809, 0x4E4F, [0x89, 0x15, 0xBD, 0xCB, 0x40, 0x6B, 0x79, 0x93]);
interface IMFSourceReader : IUnknown
{
    HRESULT GetStreamSelection(uint dwStreamIndex, int* pfSelected);
    HRESULT SetStreamSelection(uint dwStreamIndex, BOOL fSelected);
    HRESULT GetNativeMediaType(uint dwStreamIndex, uint dwMediaTypeIndex, IMFMediaType* ppMediaType);
    HRESULT GetCurrentMediaType(uint dwStreamIndex, IMFMediaType* ppMediaType);
    HRESULT SetCurrentMediaType(uint dwStreamIndex, uint* pdwReserved, IMFMediaType pMediaType);
    HRESULT SetCurrentPosition(const(Guid)* guidTimeFormat, const(PROPVARIANT)* varPosition);
    HRESULT ReadSample(uint dwStreamIndex, uint dwControlFlags, uint* pdwActualStreamIndex, uint* pdwStreamFlags, long* pllTimestamp, IMFSample* ppSample);
    HRESULT Flush(uint dwStreamIndex);
    HRESULT GetServiceForStream(uint dwStreamIndex, const(Guid)* guidService, const(Guid)* riid, void** ppvObject);
    HRESULT GetPresentationAttribute(uint dwStreamIndex, const(Guid)* guidAttribute, PROPVARIANT* pvarAttribute);
}

const GUID IID_IMFSourceReaderEx = {0x7B981CF0, 0x560E, 0x4116, [0x98, 0x75, 0xB0, 0x99, 0x89, 0x5F, 0x23, 0xD7]};
@GUID(0x7B981CF0, 0x560E, 0x4116, [0x98, 0x75, 0xB0, 0x99, 0x89, 0x5F, 0x23, 0xD7]);
interface IMFSourceReaderEx : IMFSourceReader
{
    HRESULT SetNativeMediaType(uint dwStreamIndex, IMFMediaType pMediaType, uint* pdwStreamFlags);
    HRESULT AddTransformForStream(uint dwStreamIndex, IUnknown pTransformOrActivate);
    HRESULT RemoveAllTransformsForStream(uint dwStreamIndex);
    HRESULT GetTransformForStream(uint dwStreamIndex, uint dwTransformIndex, Guid* pGuidCategory, IMFTransform* ppTransform);
}

const GUID IID_IMFSourceReaderCallback = {0xDEEC8D99, 0xFA1D, 0x4D82, [0x84, 0xC2, 0x2C, 0x89, 0x69, 0x94, 0x48, 0x67]};
@GUID(0xDEEC8D99, 0xFA1D, 0x4D82, [0x84, 0xC2, 0x2C, 0x89, 0x69, 0x94, 0x48, 0x67]);
interface IMFSourceReaderCallback : IUnknown
{
    HRESULT OnReadSample(HRESULT hrStatus, uint dwStreamIndex, uint dwStreamFlags, long llTimestamp, IMFSample pSample);
    HRESULT OnFlush(uint dwStreamIndex);
    HRESULT OnEvent(uint dwStreamIndex, IMFMediaEvent pEvent);
}

const GUID IID_IMFSourceReaderCallback2 = {0xCF839FE6, 0x8C2A, 0x4DD2, [0xB6, 0xEA, 0xC2, 0x2D, 0x69, 0x61, 0xAF, 0x05]};
@GUID(0xCF839FE6, 0x8C2A, 0x4DD2, [0xB6, 0xEA, 0xC2, 0x2D, 0x69, 0x61, 0xAF, 0x05]);
interface IMFSourceReaderCallback2 : IMFSourceReaderCallback
{
    HRESULT OnTransformChange();
    HRESULT OnStreamError(uint dwStreamIndex, HRESULT hrStatus);
}

enum __MIDL___MIDL_itf_mfreadwrite_0000_0005_0001
{
    MF_SINK_WRITER_INVALID_STREAM_INDEX = -1,
    MF_SINK_WRITER_ALL_STREAMS = -2,
    MF_SINK_WRITER_MEDIASINK = -1,
}

struct MF_SINK_WRITER_STATISTICS
{
    uint cb;
    long llLastTimestampReceived;
    long llLastTimestampEncoded;
    long llLastTimestampProcessed;
    long llLastStreamTickReceived;
    long llLastSinkSampleRequest;
    ulong qwNumSamplesReceived;
    ulong qwNumSamplesEncoded;
    ulong qwNumSamplesProcessed;
    ulong qwNumStreamTicksReceived;
    uint dwByteCountQueued;
    ulong qwByteCountProcessed;
    uint dwNumOutstandingSinkSampleRequests;
    uint dwAverageSampleRateReceived;
    uint dwAverageSampleRateEncoded;
    uint dwAverageSampleRateProcessed;
}

const GUID IID_IMFSinkWriter = {0x3137F1CD, 0xFE5E, 0x4805, [0xA5, 0xD8, 0xFB, 0x47, 0x74, 0x48, 0xCB, 0x3D]};
@GUID(0x3137F1CD, 0xFE5E, 0x4805, [0xA5, 0xD8, 0xFB, 0x47, 0x74, 0x48, 0xCB, 0x3D]);
interface IMFSinkWriter : IUnknown
{
    HRESULT AddStream(IMFMediaType pTargetMediaType, uint* pdwStreamIndex);
    HRESULT SetInputMediaType(uint dwStreamIndex, IMFMediaType pInputMediaType, IMFAttributes pEncodingParameters);
    HRESULT BeginWriting();
    HRESULT WriteSample(uint dwStreamIndex, IMFSample pSample);
    HRESULT SendStreamTick(uint dwStreamIndex, long llTimestamp);
    HRESULT PlaceMarker(uint dwStreamIndex, void* pvContext);
    HRESULT NotifyEndOfSegment(uint dwStreamIndex);
    HRESULT Flush(uint dwStreamIndex);
    HRESULT Finalize();
    HRESULT GetServiceForStream(uint dwStreamIndex, const(Guid)* guidService, const(Guid)* riid, void** ppvObject);
    HRESULT GetStatistics(uint dwStreamIndex, MF_SINK_WRITER_STATISTICS* pStats);
}

const GUID IID_IMFSinkWriterEx = {0x588D72AB, 0x5BC1, 0x496A, [0x87, 0x14, 0xB7, 0x06, 0x17, 0x14, 0x1B, 0x25]};
@GUID(0x588D72AB, 0x5BC1, 0x496A, [0x87, 0x14, 0xB7, 0x06, 0x17, 0x14, 0x1B, 0x25]);
interface IMFSinkWriterEx : IMFSinkWriter
{
    HRESULT GetTransformForStream(uint dwStreamIndex, uint dwTransformIndex, Guid* pGuidCategory, IMFTransform* ppTransform);
}

const GUID IID_IMFSinkWriterEncoderConfig = {0x17C3779E, 0x3CDE, 0x4EDE, [0x8C, 0x60, 0x38, 0x99, 0xF5, 0xF5, 0x3A, 0xD6]};
@GUID(0x17C3779E, 0x3CDE, 0x4EDE, [0x8C, 0x60, 0x38, 0x99, 0xF5, 0xF5, 0x3A, 0xD6]);
interface IMFSinkWriterEncoderConfig : IUnknown
{
    HRESULT SetTargetMediaType(uint dwStreamIndex, IMFMediaType pTargetMediaType, IMFAttributes pEncodingParameters);
    HRESULT PlaceEncodingParameters(uint dwStreamIndex, IMFAttributes pEncodingParameters);
}

const GUID IID_IMFSinkWriterCallback = {0x666F76DE, 0x33D2, 0x41B9, [0xA4, 0x58, 0x29, 0xED, 0x0A, 0x97, 0x2C, 0x58]};
@GUID(0x666F76DE, 0x33D2, 0x41B9, [0xA4, 0x58, 0x29, 0xED, 0x0A, 0x97, 0x2C, 0x58]);
interface IMFSinkWriterCallback : IUnknown
{
    HRESULT OnFinalize(HRESULT hrStatus);
    HRESULT OnMarker(uint dwStreamIndex, void* pvContext);
}

const GUID IID_IMFSinkWriterCallback2 = {0x2456BD58, 0xC067, 0x4513, [0x84, 0xFE, 0x8D, 0x0C, 0x88, 0xFF, 0xDC, 0x61]};
@GUID(0x2456BD58, 0xC067, 0x4513, [0x84, 0xFE, 0x8D, 0x0C, 0x88, 0xFF, 0xDC, 0x61]);
interface IMFSinkWriterCallback2 : IMFSinkWriterCallback
{
    HRESULT OnTransformChange();
    HRESULT OnStreamError(uint dwStreamIndex, HRESULT hrStatus);
}

const GUID IID_IMFVideoPositionMapper = {0x1F6A9F17, 0xE70B, 0x4E24, [0x8A, 0xE4, 0x0B, 0x2C, 0x3B, 0xA7, 0xA4, 0xAE]};
@GUID(0x1F6A9F17, 0xE70B, 0x4E24, [0x8A, 0xE4, 0x0B, 0x2C, 0x3B, 0xA7, 0xA4, 0xAE]);
interface IMFVideoPositionMapper : IUnknown
{
    HRESULT MapOutputCoordinateToInputStream(float xOut, float yOut, uint dwOutputStreamIndex, uint dwInputStreamIndex, float* pxIn, float* pyIn);
}

const GUID IID_IMFVideoDeviceID = {0xA38D9567, 0x5A9C, 0x4F3C, [0xB2, 0x93, 0x8E, 0xB4, 0x15, 0xB2, 0x79, 0xBA]};
@GUID(0xA38D9567, 0x5A9C, 0x4F3C, [0xB2, 0x93, 0x8E, 0xB4, 0x15, 0xB2, 0x79, 0xBA]);
interface IMFVideoDeviceID : IUnknown
{
    HRESULT GetDeviceID(Guid* pDeviceID);
}

enum MFVideoAspectRatioMode
{
    MFVideoARMode_None = 0,
    MFVideoARMode_PreservePicture = 1,
    MFVideoARMode_PreservePixel = 2,
    MFVideoARMode_NonLinearStretch = 4,
    MFVideoARMode_Mask = 7,
}

enum MFVideoRenderPrefs
{
    MFVideoRenderPrefs_DoNotRenderBorder = 1,
    MFVideoRenderPrefs_DoNotClipToDevice = 2,
    MFVideoRenderPrefs_AllowOutputThrottling = 4,
    MFVideoRenderPrefs_ForceOutputThrottling = 8,
    MFVideoRenderPrefs_ForceBatching = 16,
    MFVideoRenderPrefs_AllowBatching = 32,
    MFVideoRenderPrefs_ForceScaling = 64,
    MFVideoRenderPrefs_AllowScaling = 128,
    MFVideoRenderPrefs_DoNotRepaintOnStop = 256,
    MFVideoRenderPrefs_Mask = 511,
}

const GUID IID_IMFVideoDisplayControl = {0xA490B1E4, 0xAB84, 0x4D31, [0xA1, 0xB2, 0x18, 0x1E, 0x03, 0xB1, 0x07, 0x7A]};
@GUID(0xA490B1E4, 0xAB84, 0x4D31, [0xA1, 0xB2, 0x18, 0x1E, 0x03, 0xB1, 0x07, 0x7A]);
interface IMFVideoDisplayControl : IUnknown
{
    HRESULT GetNativeVideoSize(SIZE* pszVideo, SIZE* pszARVideo);
    HRESULT GetIdealVideoSize(SIZE* pszMin, SIZE* pszMax);
    HRESULT SetVideoPosition(const(MFVideoNormalizedRect)* pnrcSource, const(RECT)* prcDest);
    HRESULT GetVideoPosition(MFVideoNormalizedRect* pnrcSource, RECT* prcDest);
    HRESULT SetAspectRatioMode(uint dwAspectRatioMode);
    HRESULT GetAspectRatioMode(uint* pdwAspectRatioMode);
    HRESULT SetVideoWindow(HWND hwndVideo);
    HRESULT GetVideoWindow(HWND* phwndVideo);
    HRESULT RepaintVideo();
    HRESULT GetCurrentImage(BITMAPINFOHEADER* pBih, char* pDib, uint* pcbDib, long* pTimeStamp);
    HRESULT SetBorderColor(uint Clr);
    HRESULT GetBorderColor(uint* pClr);
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    HRESULT GetRenderingPrefs(uint* pdwRenderFlags);
    HRESULT SetFullscreen(BOOL fFullscreen);
    HRESULT GetFullscreen(int* pfFullscreen);
}

enum MFVP_MESSAGE_TYPE
{
    MFVP_MESSAGE_FLUSH = 0,
    MFVP_MESSAGE_INVALIDATEMEDIATYPE = 1,
    MFVP_MESSAGE_PROCESSINPUTNOTIFY = 2,
    MFVP_MESSAGE_BEGINSTREAMING = 3,
    MFVP_MESSAGE_ENDSTREAMING = 4,
    MFVP_MESSAGE_ENDOFSTREAM = 5,
    MFVP_MESSAGE_STEP = 6,
    MFVP_MESSAGE_CANCELSTEP = 7,
}

const GUID IID_IMFVideoPresenter = {0x29AFF080, 0x182A, 0x4A5D, [0xAF, 0x3B, 0x44, 0x8F, 0x3A, 0x63, 0x46, 0xCB]};
@GUID(0x29AFF080, 0x182A, 0x4A5D, [0xAF, 0x3B, 0x44, 0x8F, 0x3A, 0x63, 0x46, 0xCB]);
interface IMFVideoPresenter : IMFClockStateSink
{
    HRESULT ProcessMessage(MFVP_MESSAGE_TYPE eMessage, uint ulParam);
    HRESULT GetCurrentMediaType(IMFVideoMediaType* ppMediaType);
}

const GUID IID_IMFDesiredSample = {0x56C294D0, 0x753E, 0x4260, [0x8D, 0x61, 0xA3, 0xD8, 0x82, 0x0B, 0x1D, 0x54]};
@GUID(0x56C294D0, 0x753E, 0x4260, [0x8D, 0x61, 0xA3, 0xD8, 0x82, 0x0B, 0x1D, 0x54]);
interface IMFDesiredSample : IUnknown
{
    HRESULT GetDesiredSampleTimeAndDuration(long* phnsSampleTime, long* phnsSampleDuration);
    void SetDesiredSampleTimeAndDuration(long hnsSampleTime, long hnsSampleDuration);
    void Clear();
}

const GUID IID_IMFVideoMixerControl = {0xA5C6C53F, 0xC202, 0x4AA5, [0x96, 0x95, 0x17, 0x5B, 0xA8, 0xC5, 0x08, 0xA5]};
@GUID(0xA5C6C53F, 0xC202, 0x4AA5, [0x96, 0x95, 0x17, 0x5B, 0xA8, 0xC5, 0x08, 0xA5]);
interface IMFVideoMixerControl : IUnknown
{
    HRESULT SetStreamZOrder(uint dwStreamID, uint dwZ);
    HRESULT GetStreamZOrder(uint dwStreamID, uint* pdwZ);
    HRESULT SetStreamOutputRect(uint dwStreamID, const(MFVideoNormalizedRect)* pnrcOutput);
    HRESULT GetStreamOutputRect(uint dwStreamID, MFVideoNormalizedRect* pnrcOutput);
}

enum MFVideoMixPrefs
{
    MFVideoMixPrefs_ForceHalfInterlace = 1,
    MFVideoMixPrefs_AllowDropToHalfInterlace = 2,
    MFVideoMixPrefs_AllowDropToBob = 4,
    MFVideoMixPrefs_ForceBob = 8,
    MFVideoMixPrefs_EnableRotation = 16,
    MFVideoMixPrefs_Mask = 31,
}

const GUID IID_IMFVideoMixerControl2 = {0x8459616D, 0x966E, 0x4930, [0xB6, 0x58, 0x54, 0xFA, 0x7E, 0x5A, 0x16, 0xD3]};
@GUID(0x8459616D, 0x966E, 0x4930, [0xB6, 0x58, 0x54, 0xFA, 0x7E, 0x5A, 0x16, 0xD3]);
interface IMFVideoMixerControl2 : IMFVideoMixerControl
{
    HRESULT SetMixingPrefs(uint dwMixFlags);
    HRESULT GetMixingPrefs(uint* pdwMixFlags);
}

const GUID IID_IMFVideoRenderer = {0xDFDFD197, 0xA9CA, 0x43D8, [0xB3, 0x41, 0x6A, 0xF3, 0x50, 0x37, 0x92, 0xCD]};
@GUID(0xDFDFD197, 0xA9CA, 0x43D8, [0xB3, 0x41, 0x6A, 0xF3, 0x50, 0x37, 0x92, 0xCD]);
interface IMFVideoRenderer : IUnknown
{
    HRESULT InitializeRenderer(IMFTransform pVideoMixer, IMFVideoPresenter pVideoPresenter);
}

const GUID IID_IEVRFilterConfig = {0x83E91E85, 0x82C1, 0x4EA7, [0x80, 0x1D, 0x85, 0xDC, 0x50, 0xB7, 0x50, 0x86]};
@GUID(0x83E91E85, 0x82C1, 0x4EA7, [0x80, 0x1D, 0x85, 0xDC, 0x50, 0xB7, 0x50, 0x86]);
interface IEVRFilterConfig : IUnknown
{
    HRESULT SetNumberOfStreams(uint dwMaxStreams);
    HRESULT GetNumberOfStreams(uint* pdwMaxStreams);
}

enum EVRFilterConfigPrefs
{
    EVRFilterConfigPrefs_EnableQoS = 1,
    EVRFilterConfigPrefs_Mask = 1,
}

const GUID IID_IEVRFilterConfigEx = {0xAEA36028, 0x796D, 0x454F, [0xBE, 0xEE, 0xB4, 0x80, 0x71, 0xE2, 0x43, 0x04]};
@GUID(0xAEA36028, 0x796D, 0x454F, [0xBE, 0xEE, 0xB4, 0x80, 0x71, 0xE2, 0x43, 0x04]);
interface IEVRFilterConfigEx : IEVRFilterConfig
{
    HRESULT SetConfigPrefs(uint dwConfigFlags);
    HRESULT GetConfigPrefs(uint* pdwConfigFlags);
}

enum MF_SERVICE_LOOKUP_TYPE
{
    MF_SERVICE_LOOKUP_UPSTREAM = 0,
    MF_SERVICE_LOOKUP_UPSTREAM_DIRECT = 1,
    MF_SERVICE_LOOKUP_DOWNSTREAM = 2,
    MF_SERVICE_LOOKUP_DOWNSTREAM_DIRECT = 3,
    MF_SERVICE_LOOKUP_ALL = 4,
    MF_SERVICE_LOOKUP_GLOBAL = 5,
}

const GUID IID_IMFTopologyServiceLookup = {0xFA993889, 0x4383, 0x415A, [0xA9, 0x30, 0xDD, 0x47, 0x2A, 0x8C, 0xF6, 0xF7]};
@GUID(0xFA993889, 0x4383, 0x415A, [0xA9, 0x30, 0xDD, 0x47, 0x2A, 0x8C, 0xF6, 0xF7]);
interface IMFTopologyServiceLookup : IUnknown
{
    HRESULT LookupService(MF_SERVICE_LOOKUP_TYPE Type, uint dwIndex, const(Guid)* guidService, const(Guid)* riid, char* ppvObjects, uint* pnObjects);
}

const GUID IID_IMFTopologyServiceLookupClient = {0xFA99388A, 0x4383, 0x415A, [0xA9, 0x30, 0xDD, 0x47, 0x2A, 0x8C, 0xF6, 0xF7]};
@GUID(0xFA99388A, 0x4383, 0x415A, [0xA9, 0x30, 0xDD, 0x47, 0x2A, 0x8C, 0xF6, 0xF7]);
interface IMFTopologyServiceLookupClient : IUnknown
{
    HRESULT InitServicePointers(IMFTopologyServiceLookup pLookup);
    HRESULT ReleaseServicePointers();
}

const GUID IID_IEVRTrustedVideoPlugin = {0x83A4CE40, 0x7710, 0x494B, [0xA8, 0x93, 0xA4, 0x72, 0x04, 0x9A, 0xF6, 0x30]};
@GUID(0x83A4CE40, 0x7710, 0x494B, [0xA8, 0x93, 0xA4, 0x72, 0x04, 0x9A, 0xF6, 0x30]);
interface IEVRTrustedVideoPlugin : IUnknown
{
    HRESULT IsInTrustedVideoMode(int* pYes);
    HRESULT CanConstrict(int* pYes);
    HRESULT SetConstriction(uint dwKPix);
    HRESULT DisableImageExport(BOOL bDisable);
}

enum MFP_CREATION_OPTIONS
{
    MFP_OPTION_NONE = 0,
    MFP_OPTION_FREE_THREADED_CALLBACK = 1,
    MFP_OPTION_NO_MMCSS = 2,
    MFP_OPTION_NO_REMOTE_DESKTOP_OPTIMIZATION = 4,
}

enum MFP_MEDIAPLAYER_STATE
{
    MFP_MEDIAPLAYER_STATE_EMPTY = 0,
    MFP_MEDIAPLAYER_STATE_STOPPED = 1,
    MFP_MEDIAPLAYER_STATE_PLAYING = 2,
    MFP_MEDIAPLAYER_STATE_PAUSED = 3,
    MFP_MEDIAPLAYER_STATE_SHUTDOWN = 4,
}

enum _MFP_MEDIAITEM_CHARACTERISTICS
{
    MFP_MEDIAITEM_IS_LIVE = 1,
    MFP_MEDIAITEM_CAN_SEEK = 2,
    MFP_MEDIAITEM_CAN_PAUSE = 4,
    MFP_MEDIAITEM_HAS_SLOW_SEEK = 8,
}

enum _MFP_CREDENTIAL_FLAGS
{
    MFP_CREDENTIAL_PROMPT = 1,
    MFP_CREDENTIAL_SAVE = 2,
    MFP_CREDENTIAL_DO_NOT_CACHE = 4,
    MFP_CREDENTIAL_CLEAR_TEXT = 8,
    MFP_CREDENTIAL_PROXY = 16,
    MFP_CREDENTIAL_LOGGED_ON_USER = 32,
}

const GUID IID_IMFPMediaPlayer = {0xA714590A, 0x58AF, 0x430A, [0x85, 0xBF, 0x44, 0xF5, 0xEC, 0x83, 0x8D, 0x85]};
@GUID(0xA714590A, 0x58AF, 0x430A, [0x85, 0xBF, 0x44, 0xF5, 0xEC, 0x83, 0x8D, 0x85]);
interface IMFPMediaPlayer : IUnknown
{
    HRESULT Play();
    HRESULT Pause();
    HRESULT Stop();
    HRESULT FrameStep();
    HRESULT SetPosition(const(Guid)* guidPositionType, const(PROPVARIANT)* pvPositionValue);
    HRESULT GetPosition(const(Guid)* guidPositionType, PROPVARIANT* pvPositionValue);
    HRESULT GetDuration(const(Guid)* guidPositionType, PROPVARIANT* pvDurationValue);
    HRESULT SetRate(float flRate);
    HRESULT GetRate(float* pflRate);
    HRESULT GetSupportedRates(BOOL fForwardDirection, float* pflSlowestRate, float* pflFastestRate);
    HRESULT GetState(MFP_MEDIAPLAYER_STATE* peState);
    HRESULT CreateMediaItemFromURL(const(wchar)* pwszURL, BOOL fSync, uint dwUserData, IMFPMediaItem* ppMediaItem);
    HRESULT CreateMediaItemFromObject(IUnknown pIUnknownObj, BOOL fSync, uint dwUserData, IMFPMediaItem* ppMediaItem);
    HRESULT SetMediaItem(IMFPMediaItem pIMFPMediaItem);
    HRESULT ClearMediaItem();
    HRESULT GetMediaItem(IMFPMediaItem* ppIMFPMediaItem);
    HRESULT GetVolume(float* pflVolume);
    HRESULT SetVolume(float flVolume);
    HRESULT GetBalance(float* pflBalance);
    HRESULT SetBalance(float flBalance);
    HRESULT GetMute(int* pfMute);
    HRESULT SetMute(BOOL fMute);
    HRESULT GetNativeVideoSize(SIZE* pszVideo, SIZE* pszARVideo);
    HRESULT GetIdealVideoSize(SIZE* pszMin, SIZE* pszMax);
    HRESULT SetVideoSourceRect(const(MFVideoNormalizedRect)* pnrcSource);
    HRESULT GetVideoSourceRect(MFVideoNormalizedRect* pnrcSource);
    HRESULT SetAspectRatioMode(uint dwAspectRatioMode);
    HRESULT GetAspectRatioMode(uint* pdwAspectRatioMode);
    HRESULT GetVideoWindow(HWND* phwndVideo);
    HRESULT UpdateVideo();
    HRESULT SetBorderColor(uint Clr);
    HRESULT GetBorderColor(uint* pClr);
    HRESULT InsertEffect(IUnknown pEffect, BOOL fOptional);
    HRESULT RemoveEffect(IUnknown pEffect);
    HRESULT RemoveAllEffects();
    HRESULT Shutdown();
}

const GUID IID_IMFPMediaItem = {0x90EB3E6B, 0xECBF, 0x45CC, [0xB1, 0xDA, 0xC6, 0xFE, 0x3E, 0xA7, 0x0D, 0x57]};
@GUID(0x90EB3E6B, 0xECBF, 0x45CC, [0xB1, 0xDA, 0xC6, 0xFE, 0x3E, 0xA7, 0x0D, 0x57]);
interface IMFPMediaItem : IUnknown
{
    HRESULT GetMediaPlayer(IMFPMediaPlayer* ppMediaPlayer);
    HRESULT GetURL(ushort** ppwszURL);
    HRESULT GetObjectA(IUnknown* ppIUnknown);
    HRESULT GetUserData(uint* pdwUserData);
    HRESULT SetUserData(uint dwUserData);
    HRESULT GetStartStopPosition(Guid* pguidStartPositionType, PROPVARIANT* pvStartValue, Guid* pguidStopPositionType, PROPVARIANT* pvStopValue);
    HRESULT SetStartStopPosition(const(Guid)* pguidStartPositionType, const(PROPVARIANT)* pvStartValue, const(Guid)* pguidStopPositionType, const(PROPVARIANT)* pvStopValue);
    HRESULT HasVideo(int* pfHasVideo, int* pfSelected);
    HRESULT HasAudio(int* pfHasAudio, int* pfSelected);
    HRESULT IsProtected(int* pfProtected);
    HRESULT GetDuration(const(Guid)* guidPositionType, PROPVARIANT* pvDurationValue);
    HRESULT GetNumberOfStreams(uint* pdwStreamCount);
    HRESULT GetStreamSelection(uint dwStreamIndex, int* pfEnabled);
    HRESULT SetStreamSelection(uint dwStreamIndex, BOOL fEnabled);
    HRESULT GetStreamAttribute(uint dwStreamIndex, const(Guid)* guidMFAttribute, PROPVARIANT* pvValue);
    HRESULT GetPresentationAttribute(const(Guid)* guidMFAttribute, PROPVARIANT* pvValue);
    HRESULT GetCharacteristics(uint* pCharacteristics);
    HRESULT SetStreamSink(uint dwStreamIndex, IUnknown pMediaSink);
    HRESULT GetMetadata(IPropertyStore* ppMetadataStore);
}

enum MFP_EVENT_TYPE
{
    MFP_EVENT_TYPE_PLAY = 0,
    MFP_EVENT_TYPE_PAUSE = 1,
    MFP_EVENT_TYPE_STOP = 2,
    MFP_EVENT_TYPE_POSITION_SET = 3,
    MFP_EVENT_TYPE_RATE_SET = 4,
    MFP_EVENT_TYPE_MEDIAITEM_CREATED = 5,
    MFP_EVENT_TYPE_MEDIAITEM_SET = 6,
    MFP_EVENT_TYPE_FRAME_STEP = 7,
    MFP_EVENT_TYPE_MEDIAITEM_CLEARED = 8,
    MFP_EVENT_TYPE_MF = 9,
    MFP_EVENT_TYPE_ERROR = 10,
    MFP_EVENT_TYPE_PLAYBACK_ENDED = 11,
    MFP_EVENT_TYPE_ACQUIRE_USER_CREDENTIAL = 12,
}

struct MFP_EVENT_HEADER
{
    MFP_EVENT_TYPE eEventType;
    HRESULT hrEvent;
    IMFPMediaPlayer pMediaPlayer;
    MFP_MEDIAPLAYER_STATE eState;
    IPropertyStore pPropertyStore;
}

struct MFP_PLAY_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem pMediaItem;
}

struct MFP_PAUSE_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem pMediaItem;
}

struct MFP_STOP_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem pMediaItem;
}

struct MFP_POSITION_SET_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem pMediaItem;
}

struct MFP_RATE_SET_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem pMediaItem;
    float flRate;
}

struct MFP_MEDIAITEM_CREATED_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem pMediaItem;
    uint dwUserData;
}

struct MFP_MEDIAITEM_SET_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem pMediaItem;
}

struct MFP_FRAME_STEP_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem pMediaItem;
}

struct MFP_MEDIAITEM_CLEARED_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem pMediaItem;
}

struct MFP_MF_EVENT
{
    MFP_EVENT_HEADER header;
    uint MFEventType;
    IMFMediaEvent pMFMediaEvent;
    IMFPMediaItem pMediaItem;
}

struct MFP_ERROR_EVENT
{
    MFP_EVENT_HEADER header;
}

struct MFP_PLAYBACK_ENDED_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem pMediaItem;
}

struct MFP_ACQUIRE_USER_CREDENTIAL_EVENT
{
    MFP_EVENT_HEADER header;
    uint dwUserData;
    BOOL fProceedWithAuthentication;
    HRESULT hrAuthenticationStatus;
    const(wchar)* pwszURL;
    const(wchar)* pwszSite;
    const(wchar)* pwszRealm;
    const(wchar)* pwszPackage;
    int nRetries;
    uint flags;
    IMFNetCredential pCredential;
}

const GUID IID_IMFPMediaPlayerCallback = {0x766C8FFB, 0x5FDB, 0x4FEA, [0xA2, 0x8D, 0xB9, 0x12, 0x99, 0x6F, 0x51, 0xBD]};
@GUID(0x766C8FFB, 0x5FDB, 0x4FEA, [0xA2, 0x8D, 0xB9, 0x12, 0x99, 0x6F, 0x51, 0xBD]);
interface IMFPMediaPlayerCallback : IUnknown
{
    void OnMediaPlayerEvent(MFP_EVENT_HEADER* pEventHeader);
}

struct DEVICE_INFO
{
    BSTR pFriendlyDeviceName;
    BSTR pUniqueDeviceName;
    BSTR pManufacturerName;
    BSTR pModelName;
    BSTR pIconURL;
}

enum MF_SHARING_ENGINE_EVENT
{
    MF_SHARING_ENGINE_EVENT_DISCONNECT = 2000,
    MF_SHARING_ENGINE_EVENT_LOCALRENDERINGSTARTED = 2001,
    MF_SHARING_ENGINE_EVENT_LOCALRENDERINGENDED = 2002,
    MF_SHARING_ENGINE_EVENT_STOPPED = 2003,
    MF_SHARING_ENGINE_EVENT_ERROR = 2501,
}

enum MF_MEDIA_SHARING_ENGINE_EVENT
{
    MF_MEDIA_SHARING_ENGINE_EVENT_DISCONNECT = 2000,
}

const GUID IID_IMFSharingEngineClassFactory = {0x2BA61F92, 0x8305, 0x413B, [0x97, 0x33, 0xFA, 0xF1, 0x5F, 0x25, 0x93, 0x84]};
@GUID(0x2BA61F92, 0x8305, 0x413B, [0x97, 0x33, 0xFA, 0xF1, 0x5F, 0x25, 0x93, 0x84]);
interface IMFSharingEngineClassFactory : IUnknown
{
    HRESULT CreateInstance(uint dwFlags, IMFAttributes pAttr, IUnknown* ppEngine);
}

const GUID IID_IMFMediaSharingEngine = {0x8D3CE1BF, 0x2367, 0x40E0, [0x9E, 0xEE, 0x40, 0xD3, 0x77, 0xCC, 0x1B, 0x46]};
@GUID(0x8D3CE1BF, 0x2367, 0x40E0, [0x9E, 0xEE, 0x40, 0xD3, 0x77, 0xCC, 0x1B, 0x46]);
interface IMFMediaSharingEngine : IMFMediaEngine
{
    HRESULT GetDevice(DEVICE_INFO* pDevice);
}

const GUID IID_IMFMediaSharingEngineClassFactory = {0x524D2BC4, 0xB2B1, 0x4FE5, [0x8F, 0xAC, 0xFA, 0x4E, 0x45, 0x12, 0xB4, 0xE0]};
@GUID(0x524D2BC4, 0xB2B1, 0x4FE5, [0x8F, 0xAC, 0xFA, 0x4E, 0x45, 0x12, 0xB4, 0xE0]);
interface IMFMediaSharingEngineClassFactory : IUnknown
{
    HRESULT CreateInstance(uint dwFlags, IMFAttributes pAttr, IMFMediaSharingEngine* ppEngine);
}

const GUID IID_IMFImageSharingEngine = {0xCFA0AE8E, 0x7E1C, 0x44D2, [0xAE, 0x68, 0xFC, 0x4C, 0x14, 0x8A, 0x63, 0x54]};
@GUID(0xCFA0AE8E, 0x7E1C, 0x44D2, [0xAE, 0x68, 0xFC, 0x4C, 0x14, 0x8A, 0x63, 0x54]);
interface IMFImageSharingEngine : IUnknown
{
    HRESULT SetSource(IUnknown pStream);
    HRESULT GetDevice(DEVICE_INFO* pDevice);
    HRESULT Shutdown();
}

const GUID IID_IMFImageSharingEngineClassFactory = {0x1FC55727, 0xA7FB, 0x4FC8, [0x83, 0xAE, 0x8A, 0xF0, 0x24, 0x99, 0x0A, 0xF1]};
@GUID(0x1FC55727, 0xA7FB, 0x4FC8, [0x83, 0xAE, 0x8A, 0xF0, 0x24, 0x99, 0x0A, 0xF1]);
interface IMFImageSharingEngineClassFactory : IUnknown
{
    HRESULT CreateInstanceFromUDN(BSTR pUniqueDeviceName, IMFImageSharingEngine* ppEngine);
}

enum PLAYTO_SOURCE_CREATEFLAGS
{
    PLAYTO_SOURCE_NONE = 0,
    PLAYTO_SOURCE_IMAGE = 1,
    PLAYTO_SOURCE_AUDIO = 2,
    PLAYTO_SOURCE_VIDEO = 4,
    PLAYTO_SOURCE_PROTECTED = 8,
}

const GUID IID_IPlayToControl = {0x607574EB, 0xF4B6, 0x45C1, [0xB0, 0x8C, 0xCB, 0x71, 0x51, 0x22, 0x90, 0x1D]};
@GUID(0x607574EB, 0xF4B6, 0x45C1, [0xB0, 0x8C, 0xCB, 0x71, 0x51, 0x22, 0x90, 0x1D]);
interface IPlayToControl : IUnknown
{
    HRESULT Connect(IMFSharingEngineClassFactory pFactory);
    HRESULT Disconnect();
}

const GUID IID_IPlayToControlWithCapabilities = {0xAA9DD80F, 0xC50A, 0x4220, [0x91, 0xC1, 0x33, 0x22, 0x87, 0xF8, 0x2A, 0x34]};
@GUID(0xAA9DD80F, 0xC50A, 0x4220, [0x91, 0xC1, 0x33, 0x22, 0x87, 0xF8, 0x2A, 0x34]);
interface IPlayToControlWithCapabilities : IPlayToControl
{
    HRESULT GetCapabilities(PLAYTO_SOURCE_CREATEFLAGS* pCapabilities);
}

const GUID IID_IPlayToSourceClassFactory = {0x842B32A3, 0x9B9B, 0x4D1C, [0xB3, 0xF3, 0x49, 0x19, 0x32, 0x48, 0xA5, 0x54]};
@GUID(0x842B32A3, 0x9B9B, 0x4D1C, [0xB3, 0xF3, 0x49, 0x19, 0x32, 0x48, 0xA5, 0x54]);
interface IPlayToSourceClassFactory : IUnknown
{
    HRESULT CreateInstance(uint dwFlags, IPlayToControl pControl, IInspectable* ppSource);
}

const GUID IID_IEVRVideoStreamControl = {0xD0CFE38B, 0x93E7, 0x4772, [0x89, 0x57, 0x04, 0x00, 0xC4, 0x9A, 0x44, 0x85]};
@GUID(0xD0CFE38B, 0x93E7, 0x4772, [0x89, 0x57, 0x04, 0x00, 0xC4, 0x9A, 0x44, 0x85]);
interface IEVRVideoStreamControl : IUnknown
{
    HRESULT SetStreamActiveState(BOOL fActive);
    HRESULT GetStreamActiveState(int* lpfActive);
}

const GUID IID_IMFVideoProcessor = {0x6AB0000C, 0xFECE, 0x4D1F, [0xA2, 0xAC, 0xA9, 0x57, 0x35, 0x30, 0x65, 0x6E]};
@GUID(0x6AB0000C, 0xFECE, 0x4D1F, [0xA2, 0xAC, 0xA9, 0x57, 0x35, 0x30, 0x65, 0x6E]);
interface IMFVideoProcessor : IUnknown
{
    HRESULT GetAvailableVideoProcessorModes(uint* lpdwNumProcessingModes, char* ppVideoProcessingModes);
    HRESULT GetVideoProcessorCaps(Guid* lpVideoProcessorMode, DXVA2_VideoProcessorCaps* lpVideoProcessorCaps);
    HRESULT GetVideoProcessorMode(Guid* lpMode);
    HRESULT SetVideoProcessorMode(Guid* lpMode);
    HRESULT GetProcAmpRange(uint dwProperty, DXVA2_ValueRange* pPropRange);
    HRESULT GetProcAmpValues(uint dwFlags, DXVA2_ProcAmpValues* Values);
    HRESULT SetProcAmpValues(uint dwFlags, DXVA2_ProcAmpValues* pValues);
    HRESULT GetFilteringRange(uint dwProperty, DXVA2_ValueRange* pPropRange);
    HRESULT GetFilteringValue(uint dwProperty, DXVA2_Fixed32* pValue);
    HRESULT SetFilteringValue(uint dwProperty, DXVA2_Fixed32* pValue);
    HRESULT GetBackgroundColor(uint* lpClrBkg);
    HRESULT SetBackgroundColor(uint ClrBkg);
}

struct MFVideoAlphaBitmapParams
{
    uint dwFlags;
    uint clrSrcKey;
    RECT rcSrc;
    MFVideoNormalizedRect nrcDest;
    float fAlpha;
    uint dwFilterMode;
}

struct MFVideoAlphaBitmap
{
    BOOL GetBitmapFromDC;
    _bitmap_e__Union bitmap;
    MFVideoAlphaBitmapParams params;
}

enum MFVideoAlphaBitmapFlags
{
    MFVideoAlphaBitmap_EntireDDS = 1,
    MFVideoAlphaBitmap_SrcColorKey = 2,
    MFVideoAlphaBitmap_SrcRect = 4,
    MFVideoAlphaBitmap_DestRect = 8,
    MFVideoAlphaBitmap_FilterMode = 16,
    MFVideoAlphaBitmap_Alpha = 32,
    MFVideoAlphaBitmap_BitMask = 63,
}

const GUID IID_IMFVideoMixerBitmap = {0x814C7B20, 0x0FDB, 0x4EEC, [0xAF, 0x8F, 0xF9, 0x57, 0xC8, 0xF6, 0x9E, 0xDC]};
@GUID(0x814C7B20, 0x0FDB, 0x4EEC, [0xAF, 0x8F, 0xF9, 0x57, 0xC8, 0xF6, 0x9E, 0xDC]);
interface IMFVideoMixerBitmap : IUnknown
{
    HRESULT SetAlphaBitmap(const(MFVideoAlphaBitmap)* pBmpParms);
    HRESULT ClearAlphaBitmap();
    HRESULT UpdateAlphaBitmapParameters(const(MFVideoAlphaBitmapParams)* pBmpParms);
    HRESULT GetAlphaBitmapParameters(MFVideoAlphaBitmapParams* pBmpParms);
}

const GUID IID_IAdvancedMediaCaptureInitializationSettings = {0x3DE21209, 0x8BA6, 0x4F2A, [0xA5, 0x77, 0x28, 0x19, 0xB5, 0x6F, 0xF1, 0x4D]};
@GUID(0x3DE21209, 0x8BA6, 0x4F2A, [0xA5, 0x77, 0x28, 0x19, 0xB5, 0x6F, 0xF1, 0x4D]);
interface IAdvancedMediaCaptureInitializationSettings : IUnknown
{
    HRESULT SetDirectxDeviceManager(IMFDXGIDeviceManager value);
}

const GUID IID_IAdvancedMediaCaptureSettings = {0x24E0485F, 0xA33E, 0x4AA1, [0xB5, 0x64, 0x60, 0x19, 0xB1, 0xD1, 0x4F, 0x65]};
@GUID(0x24E0485F, 0xA33E, 0x4AA1, [0xB5, 0x64, 0x60, 0x19, 0xB1, 0xD1, 0x4F, 0x65]);
interface IAdvancedMediaCaptureSettings : IUnknown
{
    HRESULT GetDirectxDeviceManager(IMFDXGIDeviceManager* value);
}

const GUID IID_IAdvancedMediaCapture = {0xD0751585, 0xD216, 0x4344, [0xB5, 0xBF, 0x46, 0x3B, 0x68, 0xF9, 0x77, 0xBB]};
@GUID(0xD0751585, 0xD216, 0x4344, [0xB5, 0xBF, 0x46, 0x3B, 0x68, 0xF9, 0x77, 0xBB]);
interface IAdvancedMediaCapture : IUnknown
{
    HRESULT GetAdvancedMediaCaptureSettings(IAdvancedMediaCaptureSettings* value);
}

const GUID IID_IMFSpatialAudioObjectBuffer = {0xD396EC8C, 0x605E, 0x4249, [0x97, 0x8D, 0x72, 0xAD, 0x1C, 0x31, 0x28, 0x72]};
@GUID(0xD396EC8C, 0x605E, 0x4249, [0x97, 0x8D, 0x72, 0xAD, 0x1C, 0x31, 0x28, 0x72]);
interface IMFSpatialAudioObjectBuffer : IMFMediaBuffer
{
    HRESULT SetID(uint u32ID);
    HRESULT GetID(uint* pu32ID);
    HRESULT SetType(AudioObjectType type);
    HRESULT GetType(AudioObjectType* pType);
    HRESULT GetMetadataItems(ISpatialAudioMetadataItems* ppMetadataItems);
}

const GUID IID_IMFSpatialAudioSample = {0xABF28A9B, 0x3393, 0x4290, [0xBA, 0x79, 0x5F, 0xFC, 0x46, 0xD9, 0x86, 0xB2]};
@GUID(0xABF28A9B, 0x3393, 0x4290, [0xBA, 0x79, 0x5F, 0xFC, 0x46, 0xD9, 0x86, 0xB2]);
interface IMFSpatialAudioSample : IMFSample
{
    HRESULT GetObjectCount(uint* pdwObjectCount);
    HRESULT AddSpatialAudioObject(IMFSpatialAudioObjectBuffer pAudioObjBuffer);
    HRESULT GetSpatialAudioObjectByIndex(uint dwIndex, IMFSpatialAudioObjectBuffer* ppAudioObjBuffer);
}

const GUID IID_IMFContentDecryptionModuleSession = {0x4E233EFD, 0x1DD2, 0x49E8, [0xB5, 0x77, 0xD6, 0x3E, 0xEE, 0x4C, 0x0D, 0x33]};
@GUID(0x4E233EFD, 0x1DD2, 0x49E8, [0xB5, 0x77, 0xD6, 0x3E, 0xEE, 0x4C, 0x0D, 0x33]);
interface IMFContentDecryptionModuleSession : IUnknown
{
    HRESULT GetSessionId(ushort** sessionId);
    HRESULT GetExpiration(double* expiration);
    HRESULT GetKeyStatuses(char* keyStatuses, uint* numKeyStatuses);
    HRESULT Load(const(wchar)* sessionId, int* loaded);
    HRESULT GenerateRequest(const(wchar)* initDataType, char* initData, uint initDataSize);
    HRESULT Update(char* response, uint responseSize);
    HRESULT Close();
    HRESULT Remove();
}

const GUID IID_IMFContentDecryptionModuleSessionCallbacks = {0x3F96EE40, 0xAD81, 0x4096, [0x84, 0x70, 0x59, 0xA4, 0xB7, 0x70, 0xF8, 0x9A]};
@GUID(0x3F96EE40, 0xAD81, 0x4096, [0x84, 0x70, 0x59, 0xA4, 0xB7, 0x70, 0xF8, 0x9A]);
interface IMFContentDecryptionModuleSessionCallbacks : IUnknown
{
    HRESULT KeyMessage(MF_MEDIAKEYSESSION_MESSAGETYPE messageType, char* message, uint messageSize, const(wchar)* destinationURL);
    HRESULT KeyStatusChanged();
}

const GUID IID_IMFContentDecryptionModule = {0x87BE986C, 0x10BE, 0x4943, [0xBF, 0x48, 0x4B, 0x54, 0xCE, 0x19, 0x83, 0xA2]};
@GUID(0x87BE986C, 0x10BE, 0x4943, [0xBF, 0x48, 0x4B, 0x54, 0xCE, 0x19, 0x83, 0xA2]);
interface IMFContentDecryptionModule : IUnknown
{
    HRESULT SetContentEnabler(IMFContentEnabler contentEnabler, IMFAsyncResult result);
    HRESULT GetSuspendNotify(IMFCdmSuspendNotify* notify);
    HRESULT SetPMPHostApp(IMFPMPHostApp pmpHostApp);
    HRESULT CreateSession(MF_MEDIAKEYSESSION_TYPE sessionType, IMFContentDecryptionModuleSessionCallbacks callbacks, IMFContentDecryptionModuleSession* session);
    HRESULT SetServerCertificate(char* certificate, uint certificateSize);
    HRESULT CreateTrustedInput(char* contentInitData, uint contentInitDataSize, IMFTrustedInput* trustedInput);
    HRESULT GetProtectionSystemIds(char* systemIds, uint* count);
}

const GUID IID_IMFContentDecryptionModuleAccess = {0xA853D1F4, 0xE2A0, 0x4303, [0x9E, 0xDC, 0xF1, 0xA6, 0x8E, 0xE4, 0x31, 0x36]};
@GUID(0xA853D1F4, 0xE2A0, 0x4303, [0x9E, 0xDC, 0xF1, 0xA6, 0x8E, 0xE4, 0x31, 0x36]);
interface IMFContentDecryptionModuleAccess : IUnknown
{
    HRESULT CreateContentDecryptionModule(IPropertyStore contentDecryptionModuleProperties, IMFContentDecryptionModule* contentDecryptionModule);
    HRESULT GetConfiguration(IPropertyStore* configuration);
    HRESULT GetKeySystem(ushort** keySystem);
}

const GUID IID_IMFContentDecryptionModuleFactory = {0x7D5ABF16, 0x4CBB, 0x4E08, [0xB9, 0x77, 0x9B, 0xA5, 0x90, 0x49, 0x94, 0x3E]};
@GUID(0x7D5ABF16, 0x4CBB, 0x4E08, [0xB9, 0x77, 0x9B, 0xA5, 0x90, 0x49, 0x94, 0x3E]);
interface IMFContentDecryptionModuleFactory : IUnknown
{
    BOOL IsTypeSupported(const(wchar)* keySystem, const(wchar)* contentType);
    HRESULT CreateContentDecryptionModuleAccess(const(wchar)* keySystem, IPropertyStore* configurations, uint numConfigurations, IMFContentDecryptionModuleAccess* contentDecryptionModuleAccess);
}

@DllImport("dxva2.dll")
HRESULT DXVAHD_CreateDevice(IDirect3DDevice9Ex pD3DDevice, const(DXVAHD_CONTENT_DESC)* pContentDesc, DXVAHD_DEVICE_USAGE Usage, PDXVAHDSW_Plugin pPlugin, IDXVAHD_Device* ppDevice);

@DllImport("dxva2.dll")
HRESULT DXVA2CreateDirect3DDeviceManager9(uint* pResetToken, IDirect3DDeviceManager9* ppDeviceManager);

@DllImport("dxva2.dll")
HRESULT DXVA2CreateVideoService(IDirect3DDevice9 pDD, const(Guid)* riid, void** ppService);

@DllImport("dxva2.dll")
HRESULT OPMGetVideoOutputsFromHMONITOR(int hMonitor, OPM_VIDEO_OUTPUT_SEMANTICS vos, uint* pulNumVideoOutputs, IOPMVideoOutput** pppOPMVideoOutputArray);

@DllImport("dxva2.dll")
HRESULT OPMGetVideoOutputForTarget(LUID* pAdapterLuid, uint VidPnTarget, OPM_VIDEO_OUTPUT_SEMANTICS vos, IOPMVideoOutput* ppOPMVideoOutput);

@DllImport("dxva2.dll")
HRESULT OPMGetVideoOutputsFromIDirect3DDevice9Object(IDirect3DDevice9 pDirect3DDevice9, OPM_VIDEO_OUTPUT_SEMANTICS vos, uint* pulNumVideoOutputs, IOPMVideoOutput** pppOPMVideoOutputArray);

@DllImport("MFPlat.dll")
HRESULT MFSerializeAttributesToStream(IMFAttributes pAttr, uint dwOptions, IStream pStm);

@DllImport("MFPlat.dll")
HRESULT MFDeserializeAttributesFromStream(IMFAttributes pAttr, uint dwOptions, IStream pStm);

@DllImport("MFPlat.dll")
HRESULT MFCreateTransformActivate(IMFActivate* ppActivate);

@DllImport("MF.dll")
HRESULT MFCreateMediaSession(IMFAttributes pConfiguration, IMFMediaSession* ppMediaSession);

@DllImport("MF.dll")
HRESULT MFCreatePMPMediaSession(uint dwCreationFlags, IMFAttributes pConfiguration, IMFMediaSession* ppMediaSession, IMFActivate* ppEnablerActivate);

@DllImport("MFPlat.dll")
HRESULT MFCreateSourceResolver(IMFSourceResolver* ppISourceResolver);

@DllImport("MFPlat.dll")
HRESULT CreatePropertyStore(IPropertyStore* ppStore);

@DllImport("MFPlat.dll")
HRESULT MFGetSupportedSchemes(PROPVARIANT* pPropVarSchemeArray);

@DllImport("MFPlat.dll")
HRESULT MFGetSupportedMimeTypes(PROPVARIANT* pPropVarMimeTypeArray);

@DllImport("MF.dll")
HRESULT MFCreateTopology(IMFTopology* ppTopo);

@DllImport("MF.dll")
HRESULT MFCreateTopologyNode(MF_TOPOLOGY_TYPE NodeType, IMFTopologyNode* ppNode);

@DllImport("MF.dll")
HRESULT MFGetTopoNodeCurrentType(IMFTopologyNode pNode, uint dwStreamIndex, BOOL fOutput, IMFMediaType* ppType);

@DllImport("MF.dll")
HRESULT MFGetService(IUnknown punkObject, const(Guid)* guidService, const(Guid)* riid, void** ppvObject);

@DllImport("MFPlat.dll")
long MFGetSystemTime();

@DllImport("MF.dll")
HRESULT MFCreatePresentationClock(IMFPresentationClock* ppPresentationClock);

@DllImport("MFPlat.dll")
HRESULT MFCreateSystemTimeSource(IMFPresentationTimeSource* ppSystemTimeSource);

@DllImport("MFPlat.dll")
HRESULT MFCreatePresentationDescriptor(uint cStreamDescriptors, char* apStreamDescriptors, IMFPresentationDescriptor* ppPresentationDescriptor);

@DllImport("MF.dll")
HRESULT MFRequireProtectedEnvironment(IMFPresentationDescriptor pPresentationDescriptor);

@DllImport("MFPlat.dll")
HRESULT MFSerializePresentationDescriptor(IMFPresentationDescriptor pPD, uint* pcbData, char* ppbData);

@DllImport("MFPlat.dll")
HRESULT MFDeserializePresentationDescriptor(uint cbData, char* pbData, IMFPresentationDescriptor* ppPD);

@DllImport("MFPlat.dll")
HRESULT MFCreateStreamDescriptor(uint dwStreamIdentifier, uint cMediaTypes, char* apMediaTypes, IMFStreamDescriptor* ppDescriptor);

@DllImport("MF.dll")
HRESULT MFCreateSimpleTypeHandler(IMFMediaTypeHandler* ppHandler);

@DllImport("MF.dll")
HRESULT MFShutdownObject(IUnknown pUnk);

@DllImport("MF.dll")
HRESULT MFCreateAudioRenderer(IMFAttributes pAudioAttributes, IMFMediaSink* ppSink);

@DllImport("MF.dll")
HRESULT MFCreateAudioRendererActivate(IMFActivate* ppActivate);

@DllImport("MF.dll")
HRESULT MFCreateVideoRendererActivate(HWND hwndVideo, IMFActivate* ppActivate);

@DllImport("MF.dll")
HRESULT MFCreateMPEG4MediaSink(IMFByteStream pIByteStream, IMFMediaType pVideoMediaType, IMFMediaType pAudioMediaType, IMFMediaSink* ppIMediaSink);

@DllImport("MF.dll")
HRESULT MFCreate3GPMediaSink(IMFByteStream pIByteStream, IMFMediaType pVideoMediaType, IMFMediaType pAudioMediaType, IMFMediaSink* ppIMediaSink);

@DllImport("MF.dll")
HRESULT MFCreateMP3MediaSink(IMFByteStream pTargetByteStream, IMFMediaSink* ppMediaSink);

@DllImport("MF.dll")
HRESULT MFCreateAC3MediaSink(IMFByteStream pTargetByteStream, IMFMediaType pAudioMediaType, IMFMediaSink* ppMediaSink);

@DllImport("MF.dll")
HRESULT MFCreateADTSMediaSink(IMFByteStream pTargetByteStream, IMFMediaType pAudioMediaType, IMFMediaSink* ppMediaSink);

@DllImport("MF.dll")
HRESULT MFCreateMuxSink(Guid guidOutputSubType, IMFAttributes pOutputAttributes, IMFByteStream pOutputByteStream, IMFMediaSink* ppMuxSink);

@DllImport("MF.dll")
HRESULT MFCreateFMPEG4MediaSink(IMFByteStream pIByteStream, IMFMediaType pVideoMediaType, IMFMediaType pAudioMediaType, IMFMediaSink* ppIMediaSink);

@DllImport("mfsrcsnk.dll")
HRESULT MFCreateAVIMediaSink(IMFByteStream pIByteStream, IMFMediaType pVideoMediaType, IMFMediaType pAudioMediaType, IMFMediaSink* ppIMediaSink);

@DllImport("mfsrcsnk.dll")
HRESULT MFCreateWAVEMediaSink(IMFByteStream pTargetByteStream, IMFMediaType pAudioMediaType, IMFMediaSink* ppMediaSink);

@DllImport("MF.dll")
HRESULT MFCreateTopoLoader(IMFTopoLoader* ppObj);

@DllImport("MF.dll")
HRESULT MFCreateSampleGrabberSinkActivate(IMFMediaType pIMFMediaType, IMFSampleGrabberSinkCallback pIMFSampleGrabberSinkCallback, IMFActivate* ppIActivate);

@DllImport("MF.dll")
HRESULT MFCreateStandardQualityManager(IMFQualityManager* ppQualityManager);

@DllImport("MF.dll")
HRESULT MFCreateSequencerSource(IUnknown pReserved, IMFSequencerSource* ppSequencerSource);

@DllImport("MF.dll")
HRESULT MFCreateSequencerSegmentOffset(uint dwId, long hnsOffset, PROPVARIANT* pvarSegmentOffset);

@DllImport("MF.dll")
HRESULT MFCreateAggregateSource(IMFCollection pSourceCollection, IMFMediaSource* ppAggSource);

@DllImport("MF.dll")
HRESULT MFCreateCredentialCache(IMFNetCredentialCache* ppCache);

@DllImport("MF.dll")
HRESULT MFCreateProxyLocator(const(wchar)* pszProtocol, IPropertyStore pProxyConfig, IMFNetProxyLocator* ppProxyLocator);

@DllImport("MF.dll")
HRESULT MFCreateNetSchemePlugin(const(Guid)* riid, void** ppvHandler);

@DllImport("MF.dll")
HRESULT MFCreatePMPServer(uint dwCreationFlags, IMFPMPServer* ppPMPServer);

@DllImport("MF.dll")
HRESULT MFCreateRemoteDesktopPlugin(IMFRemoteDesktopPlugin* ppPlugin);

@DllImport("MF.dll")
HRESULT CreateNamedPropertyStore(INamedPropertyStore* ppStore);

@DllImport("MF.dll")
HRESULT MFCreateSampleCopierMFT(IMFTransform* ppCopierMFT);

@DllImport("MF.dll")
HRESULT MFCreateTranscodeProfile(IMFTranscodeProfile* ppTranscodeProfile);

@DllImport("MF.dll")
HRESULT MFCreateTranscodeTopology(IMFMediaSource pSrc, const(wchar)* pwszOutputFilePath, IMFTranscodeProfile pProfile, IMFTopology* ppTranscodeTopo);

@DllImport("MF.dll")
HRESULT MFCreateTranscodeTopologyFromByteStream(IMFMediaSource pSrc, IMFByteStream pOutputStream, IMFTranscodeProfile pProfile, IMFTopology* ppTranscodeTopo);

@DllImport("MF.dll")
HRESULT MFTranscodeGetAudioOutputAvailableTypes(const(Guid)* guidSubType, uint dwMFTFlags, IMFAttributes pCodecConfig, IMFCollection* ppAvailableTypes);

@DllImport("MF.dll")
HRESULT MFCreateTranscodeSinkActivate(IMFActivate* ppActivate);

@DllImport("MFPlat.dll")
HRESULT MFCreateTrackedSample(IMFTrackedSample* ppMFSample);

@DllImport("MFPlat.dll")
HRESULT MFCreateMFByteStreamOnStream(IStream pStream, IMFByteStream* ppByteStream);

@DllImport("MFPlat.dll")
HRESULT MFCreateStreamOnMFByteStream(IMFByteStream pByteStream, IStream* ppStream);

@DllImport("MFPlat.dll")
HRESULT MFCreateMFByteStreamOnStreamEx(IUnknown punkStream, IMFByteStream* ppByteStream);

@DllImport("MFPlat.dll")
HRESULT MFCreateStreamOnMFByteStreamEx(IMFByteStream pByteStream, const(Guid)* riid, void** ppv);

@DllImport("MFPlat.dll")
HRESULT MFCreateMediaTypeFromProperties(IUnknown punkStream, IMFMediaType* ppMediaType);

@DllImport("MFPlat.dll")
HRESULT MFCreatePropertiesFromMediaType(IMFMediaType pMediaType, const(Guid)* riid, void** ppv);

@DllImport("MF.dll")
HRESULT MFEnumDeviceSources(IMFAttributes pAttributes, IMFActivate** pppSourceActivate, uint* pcSourceActivate);

@DllImport("MF.dll")
HRESULT MFCreateDeviceSource(IMFAttributes pAttributes, IMFMediaSource* ppSource);

@DllImport("MF.dll")
HRESULT MFCreateDeviceSourceActivate(IMFAttributes pAttributes, IMFActivate* ppActivate);

@DllImport("MF.dll")
HRESULT MFCreateProtectedEnvironmentAccess(IMFProtectedEnvironmentAccess* ppAccess);

@DllImport("MF.dll")
HRESULT MFLoadSignedLibrary(const(wchar)* pszName, IMFSignedLibrary* ppLib);

@DllImport("MF.dll")
HRESULT MFGetSystemId(IMFSystemId* ppId);

@DllImport("MF.dll")
HRESULT MFGetLocalId(char* verifier, uint size, ushort** id);

@DllImport("MFPlat.dll")
HRESULT MFCreateContentProtectionDevice(const(Guid)* ProtectionSystemId, IMFContentProtectionDevice* ContentProtectionDevice);

@DllImport("MFPlat.dll")
HRESULT MFIsContentProtectionDeviceSupported(const(Guid)* ProtectionSystemId, int* isSupported);

@DllImport("MFPlat.dll")
HRESULT MFCreateContentDecryptorContext(const(Guid)* guidMediaProtectionSystemId, IMFDXGIDeviceManager pD3DManager, IMFContentProtectionDevice pContentProtectionDevice, IMFContentDecryptorContext* ppContentDecryptorContext);

@DllImport("MFSENSORGROUP.dll")
HRESULT MFCreateSensorGroup(const(wchar)* SensorGroupSymbolicLink, IMFSensorGroup* ppSensorGroup);

@DllImport("MFSENSORGROUP.dll")
HRESULT MFCreateSensorStream(uint StreamId, IMFAttributes pAttributes, IMFCollection pMediaTypeCollection, IMFSensorStream* ppStream);

@DllImport("MFSENSORGROUP.dll")
HRESULT MFCreateSensorProfile(const(Guid)* ProfileType, uint ProfileIndex, const(wchar)* Constraints, IMFSensorProfile* ppProfile);

@DllImport("MFSENSORGROUP.dll")
HRESULT MFCreateSensorProfileCollection(IMFSensorProfileCollection* ppSensorProfile);

@DllImport("MFSENSORGROUP.dll")
HRESULT MFCreateSensorActivityMonitor(IMFSensorActivitiesReportCallback pCallback, IMFSensorActivityMonitor* ppActivityMonitor);

@DllImport("MFCORE.dll")
HRESULT MFCreateExtendedCameraIntrinsics(IMFExtendedCameraIntrinsics* ppExtendedCameraIntrinsics);

@DllImport("MFCORE.dll")
HRESULT MFCreateExtendedCameraIntrinsicModel(const(MFCameraIntrinsic_DistortionModelType) distortionModelType, IMFExtendedCameraIntrinsicModel* ppExtendedCameraIntrinsicModel);

@DllImport("MFSENSORGROUP.dll")
HRESULT MFCreateRelativePanelWatcher(const(wchar)* videoDeviceId, const(wchar)* displayMonitorDeviceId, IMFRelativePanelWatcher* ppRelativePanelWatcher);

@DllImport("MF.dll")
HRESULT MFCreateASFContentInfo(IMFASFContentInfo* ppIContentInfo);

@DllImport("MF.dll")
HRESULT MFCreateASFIndexer(IMFASFIndexer* ppIIndexer);

@DllImport("MF.dll")
HRESULT MFCreateASFIndexerByteStream(IMFByteStream pIContentByteStream, ulong cbIndexStartOffset, IMFByteStream* pIIndexByteStream);

@DllImport("MF.dll")
HRESULT MFCreateASFSplitter(IMFASFSplitter* ppISplitter);

@DllImport("MF.dll")
HRESULT MFCreateASFProfile(IMFASFProfile* ppIProfile);

@DllImport("MF.dll")
HRESULT MFCreateASFProfileFromPresentationDescriptor(IMFPresentationDescriptor pIPD, IMFASFProfile* ppIProfile);

@DllImport("MF.dll")
HRESULT MFCreatePresentationDescriptorFromASFProfile(IMFASFProfile pIProfile, IMFPresentationDescriptor* ppIPD);

@DllImport("MF.dll")
HRESULT MFCreateASFMultiplexer(IMFASFMultiplexer* ppIMultiplexer);

@DllImport("MF.dll")
HRESULT MFCreateASFStreamSelector(IMFASFProfile pIASFProfile, IMFASFStreamSelector* ppSelector);

@DllImport("MF.dll")
HRESULT MFCreateASFMediaSink(IMFByteStream pIByteStream, IMFMediaSink* ppIMediaSink);

@DllImport("MF.dll")
HRESULT MFCreateASFMediaSinkActivate(const(wchar)* pwszFileName, IMFASFContentInfo pContentInfo, IMFActivate* ppIActivate);

@DllImport("MF.dll")
HRESULT MFCreateWMVEncoderActivate(IMFMediaType pMediaType, IPropertyStore pEncodingConfigurationProperties, IMFActivate* ppActivate);

@DllImport("MF.dll")
HRESULT MFCreateWMAEncoderActivate(IMFMediaType pMediaType, IPropertyStore pEncodingConfigurationProperties, IMFActivate* ppActivate);

@DllImport("MF.dll")
HRESULT MFCreateASFStreamingMediaSink(IMFByteStream pIByteStream, IMFMediaSink* ppIMediaSink);

@DllImport("MF.dll")
HRESULT MFCreateASFStreamingMediaSinkActivate(IMFActivate pByteStreamActivate, IMFASFContentInfo pContentInfo, IMFActivate* ppIActivate);

@DllImport("MFPlat.dll")
HRESULT MFStartup(uint Version, uint dwFlags);

@DllImport("MFPlat.dll")
HRESULT MFShutdown();

@DllImport("MFPlat.dll")
HRESULT MFLockPlatform();

@DllImport("MFPlat.dll")
HRESULT MFUnlockPlatform();

@DllImport("MFPlat.dll")
HRESULT MFPutWorkItem(uint dwQueue, IMFAsyncCallback pCallback, IUnknown pState);

@DllImport("MFPlat.dll")
HRESULT MFPutWorkItem2(uint dwQueue, int Priority, IMFAsyncCallback pCallback, IUnknown pState);

@DllImport("MFPlat.dll")
HRESULT MFPutWorkItemEx(uint dwQueue, IMFAsyncResult pResult);

@DllImport("MFPlat.dll")
HRESULT MFPutWorkItemEx2(uint dwQueue, int Priority, IMFAsyncResult pResult);

@DllImport("MFPlat.dll")
HRESULT MFPutWaitingWorkItem(HANDLE hEvent, int Priority, IMFAsyncResult pResult, ulong* pKey);

@DllImport("MFPlat.dll")
HRESULT MFAllocateSerialWorkQueue(uint dwWorkQueue, uint* pdwWorkQueue);

@DllImport("MFPlat.dll")
HRESULT MFScheduleWorkItemEx(IMFAsyncResult pResult, long Timeout, ulong* pKey);

@DllImport("MFPlat.dll")
HRESULT MFScheduleWorkItem(IMFAsyncCallback pCallback, IUnknown pState, long Timeout, ulong* pKey);

@DllImport("MFPlat.dll")
HRESULT MFCancelWorkItem(ulong Key);

@DllImport("MFPlat.dll")
HRESULT MFGetTimerPeriodicity(uint* Periodicity);

@DllImport("MFPlat.dll")
HRESULT MFAddPeriodicCallback(MFPERIODICCALLBACK Callback, IUnknown pContext, uint* pdwKey);

@DllImport("MFPlat.dll")
HRESULT MFRemovePeriodicCallback(uint dwKey);

@DllImport("MFPlat.dll")
HRESULT MFAllocateWorkQueueEx(MFASYNC_WORKQUEUE_TYPE WorkQueueType, uint* pdwWorkQueue);

@DllImport("MFPlat.dll")
HRESULT MFAllocateWorkQueue(uint* pdwWorkQueue);

@DllImport("MFPlat.dll")
HRESULT MFLockWorkQueue(uint dwWorkQueue);

@DllImport("MFPlat.dll")
HRESULT MFUnlockWorkQueue(uint dwWorkQueue);

@DllImport("MFPlat.dll")
HRESULT MFBeginRegisterWorkQueueWithMMCSS(uint dwWorkQueueId, const(wchar)* wszClass, uint dwTaskId, IMFAsyncCallback pDoneCallback, IUnknown pDoneState);

@DllImport("MFPlat.dll")
HRESULT MFBeginRegisterWorkQueueWithMMCSSEx(uint dwWorkQueueId, const(wchar)* wszClass, uint dwTaskId, int lPriority, IMFAsyncCallback pDoneCallback, IUnknown pDoneState);

@DllImport("MFPlat.dll")
HRESULT MFEndRegisterWorkQueueWithMMCSS(IMFAsyncResult pResult, uint* pdwTaskId);

@DllImport("MFPlat.dll")
HRESULT MFBeginUnregisterWorkQueueWithMMCSS(uint dwWorkQueueId, IMFAsyncCallback pDoneCallback, IUnknown pDoneState);

@DllImport("MFPlat.dll")
HRESULT MFEndUnregisterWorkQueueWithMMCSS(IMFAsyncResult pResult);

@DllImport("MFPlat.dll")
HRESULT MFGetWorkQueueMMCSSClass(uint dwWorkQueueId, const(wchar)* pwszClass, uint* pcchClass);

@DllImport("MFPlat.dll")
HRESULT MFGetWorkQueueMMCSSTaskId(uint dwWorkQueueId, uint* pdwTaskId);

@DllImport("MFPlat.dll")
HRESULT MFRegisterPlatformWithMMCSS(const(wchar)* wszClass, uint* pdwTaskId, int lPriority);

@DllImport("MFPlat.dll")
HRESULT MFUnregisterPlatformFromMMCSS();

@DllImport("MFPlat.dll")
HRESULT MFLockSharedWorkQueue(const(wchar)* wszClass, int BasePriority, uint* pdwTaskId, uint* pID);

@DllImport("MFPlat.dll")
HRESULT MFGetWorkQueueMMCSSPriority(uint dwWorkQueueId, int* lPriority);

@DllImport("MFPlat.dll")
HRESULT MFCreateAsyncResult(IUnknown punkObject, IMFAsyncCallback pCallback, IUnknown punkState, IMFAsyncResult* ppAsyncResult);

@DllImport("MFPlat.dll")
HRESULT MFInvokeCallback(IMFAsyncResult pAsyncResult);

@DllImport("MFPlat.dll")
HRESULT MFCreateFile(MF_FILE_ACCESSMODE AccessMode, MF_FILE_OPENMODE OpenMode, MF_FILE_FLAGS fFlags, const(wchar)* pwszFileURL, IMFByteStream* ppIByteStream);

@DllImport("MFPlat.dll")
HRESULT MFCreateTempFile(MF_FILE_ACCESSMODE AccessMode, MF_FILE_OPENMODE OpenMode, MF_FILE_FLAGS fFlags, IMFByteStream* ppIByteStream);

@DllImport("MFPlat.dll")
HRESULT MFBeginCreateFile(MF_FILE_ACCESSMODE AccessMode, MF_FILE_OPENMODE OpenMode, MF_FILE_FLAGS fFlags, const(wchar)* pwszFilePath, IMFAsyncCallback pCallback, IUnknown pState, IUnknown* ppCancelCookie);

@DllImport("MFPlat.dll")
HRESULT MFEndCreateFile(IMFAsyncResult pResult, IMFByteStream* ppFile);

@DllImport("MFPlat.dll")
HRESULT MFCancelCreateFile(IUnknown pCancelCookie);

@DllImport("MFPlat.dll")
HRESULT MFCreateMemoryBuffer(uint cbMaxLength, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat.dll")
HRESULT MFCreateMediaBufferWrapper(IMFMediaBuffer pBuffer, uint cbOffset, uint dwLength, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat.dll")
HRESULT MFCreateLegacyMediaBufferOnMFMediaBuffer(IMFSample pSample, IMFMediaBuffer pMFMediaBuffer, uint cbOffset, IMediaBuffer* ppMediaBuffer);

@DllImport("MFPlat.dll")
DXGI_FORMAT MFMapDX9FormatToDXGIFormat(uint dx9);

@DllImport("MFPlat.dll")
uint MFMapDXGIFormatToDX9Format(DXGI_FORMAT dx11);

@DllImport("MFPlat.dll")
HRESULT MFLockDXGIDeviceManager(uint* pResetToken, IMFDXGIDeviceManager* ppManager);

@DllImport("MFPlat.dll")
HRESULT MFUnlockDXGIDeviceManager();

@DllImport("MFPlat.dll")
HRESULT MFCreateDXSurfaceBuffer(const(Guid)* riid, IUnknown punkSurface, BOOL fBottomUpWhenLinear, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat.dll")
HRESULT MFCreateWICBitmapBuffer(const(Guid)* riid, IUnknown punkSurface, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat.dll")
HRESULT MFCreateDXGISurfaceBuffer(const(Guid)* riid, IUnknown punkSurface, uint uSubresourceIndex, BOOL fBottomUpWhenLinear, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat.dll")
HRESULT MFCreateVideoSampleAllocatorEx(const(Guid)* riid, void** ppSampleAllocator);

@DllImport("MFPlat.dll")
HRESULT MFCreateDXGIDeviceManager(uint* resetToken, IMFDXGIDeviceManager* ppDeviceManager);

@DllImport("MFPlat.dll")
HRESULT MFCreateAlignedMemoryBuffer(uint cbMaxLength, uint cbAligment, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat.dll")
HRESULT MFCreateMediaEvent(uint met, const(Guid)* guidExtendedType, HRESULT hrStatus, const(PROPVARIANT)* pvValue, IMFMediaEvent* ppEvent);

@DllImport("MFPlat.dll")
HRESULT MFCreateEventQueue(IMFMediaEventQueue* ppMediaEventQueue);

@DllImport("MFPlat.dll")
HRESULT MFCreateSample(IMFSample* ppIMFSample);

@DllImport("MFPlat.dll")
HRESULT MFCreateAttributes(IMFAttributes* ppMFAttributes, uint cInitialSize);

@DllImport("MFPlat.dll")
HRESULT MFInitAttributesFromBlob(IMFAttributes pAttributes, char* pBuf, uint cbBufSize);

@DllImport("MFPlat.dll")
HRESULT MFGetAttributesAsBlobSize(IMFAttributes pAttributes, uint* pcbBufSize);

@DllImport("MFPlat.dll")
HRESULT MFGetAttributesAsBlob(IMFAttributes pAttributes, char* pBuf, uint cbBufSize);

@DllImport("MFPlat.dll")
HRESULT MFTRegister(Guid clsidMFT, Guid guidCategory, const(wchar)* pszName, uint Flags, uint cInputTypes, char* pInputTypes, uint cOutputTypes, char* pOutputTypes, IMFAttributes pAttributes);

@DllImport("MFPlat.dll")
HRESULT MFTUnregister(Guid clsidMFT);

@DllImport("MFPlat.dll")
HRESULT MFTRegisterLocal(IClassFactory pClassFactory, const(Guid)* guidCategory, const(wchar)* pszName, uint Flags, uint cInputTypes, char* pInputTypes, uint cOutputTypes, char* pOutputTypes);

@DllImport("MFPlat.dll")
HRESULT MFTUnregisterLocal(IClassFactory pClassFactory);

@DllImport("MFPlat.dll")
HRESULT MFTRegisterLocalByCLSID(const(Guid)* clisdMFT, const(Guid)* guidCategory, const(wchar)* pszName, uint Flags, uint cInputTypes, char* pInputTypes, uint cOutputTypes, char* pOutputTypes);

@DllImport("MFPlat.dll")
HRESULT MFTUnregisterLocalByCLSID(Guid clsidMFT);

@DllImport("MFPlat.dll")
HRESULT MFTEnum(Guid guidCategory, uint Flags, MFT_REGISTER_TYPE_INFO* pInputType, MFT_REGISTER_TYPE_INFO* pOutputType, IMFAttributes pAttributes, Guid** ppclsidMFT, uint* pcMFTs);

@DllImport("MFPlat.dll")
HRESULT MFTEnumEx(Guid guidCategory, uint Flags, const(MFT_REGISTER_TYPE_INFO)* pInputType, const(MFT_REGISTER_TYPE_INFO)* pOutputType, IMFActivate** pppMFTActivate, uint* pnumMFTActivate);

@DllImport("MFPlat.dll")
HRESULT MFTEnum2(Guid guidCategory, uint Flags, const(MFT_REGISTER_TYPE_INFO)* pInputType, const(MFT_REGISTER_TYPE_INFO)* pOutputType, IMFAttributes pAttributes, IMFActivate** pppMFTActivate, uint* pnumMFTActivate);

@DllImport("MFPlat.dll")
HRESULT MFTGetInfo(Guid clsidMFT, ushort** pszName, MFT_REGISTER_TYPE_INFO** ppInputTypes, uint* pcInputTypes, MFT_REGISTER_TYPE_INFO** ppOutputTypes, uint* pcOutputTypes, IMFAttributes* ppAttributes);

@DllImport("MFPlat.dll")
HRESULT MFGetPluginControl(IMFPluginControl* ppPluginControl);

@DllImport("MFPlat.dll")
HRESULT MFGetMFTMerit(IUnknown pMFT, uint cbVerifier, char* verifier, uint* merit);

@DllImport("MFPlat.dll")
HRESULT MFRegisterLocalSchemeHandler(const(wchar)* szScheme, IMFActivate pActivate);

@DllImport("MFPlat.dll")
HRESULT MFRegisterLocalByteStreamHandler(const(wchar)* szFileExtension, const(wchar)* szMimeType, IMFActivate pActivate);

@DllImport("MFPlat.dll")
HRESULT MFCreateMFByteStreamWrapper(IMFByteStream pStream, IMFByteStream* ppStreamWrapper);

@DllImport("MFPlat.dll")
HRESULT MFCreateMediaExtensionActivate(const(wchar)* szActivatableClassId, IUnknown pConfiguration, const(Guid)* riid, void** ppvObject);

@DllImport("MFPlat.dll")
HRESULT MFCreateMuxStreamAttributes(IMFCollection pAttributesToMux, IMFAttributes* ppMuxAttribs);

@DllImport("MFPlat.dll")
HRESULT MFCreateMuxStreamMediaType(IMFCollection pMediaTypesToMux, IMFMediaType* ppMuxMediaType);

@DllImport("MFPlat.dll")
HRESULT MFCreateMuxStreamSample(IMFCollection pSamplesToMux, IMFSample* ppMuxSample);

@DllImport("MFPlat.dll")
HRESULT MFValidateMediaTypeSize(Guid FormatType, char* pBlock, uint cbSize);

@DllImport("MFPlat.dll")
HRESULT MFCreateMediaType(IMFMediaType* ppMFType);

@DllImport("MFPlat.dll")
HRESULT MFCreateMFVideoFormatFromMFMediaType(IMFMediaType pMFType, MFVIDEOFORMAT** ppMFVF, uint* pcbSize);

@DllImport("MFPlat.dll")
HRESULT MFCreateWaveFormatExFromMFMediaType(IMFMediaType pMFType, WAVEFORMATEX** ppWF, uint* pcbSize, uint Flags);

@DllImport("MFPlat.dll")
HRESULT MFInitMediaTypeFromVideoInfoHeader(IMFMediaType pMFType, char* pVIH, uint cbBufSize, const(Guid)* pSubtype);

@DllImport("MFPlat.dll")
HRESULT MFInitMediaTypeFromVideoInfoHeader2(IMFMediaType pMFType, char* pVIH2, uint cbBufSize, const(Guid)* pSubtype);

@DllImport("MFPlat.dll")
HRESULT MFInitMediaTypeFromMPEG1VideoInfo(IMFMediaType pMFType, char* pMP1VI, uint cbBufSize, const(Guid)* pSubtype);

@DllImport("MFPlat.dll")
HRESULT MFInitMediaTypeFromMPEG2VideoInfo(IMFMediaType pMFType, char* pMP2VI, uint cbBufSize, const(Guid)* pSubtype);

@DllImport("MFPlat.dll")
HRESULT MFCalculateBitmapImageSize(char* pBMIH, uint cbBufSize, uint* pcbImageSize, int* pbKnown);

@DllImport("MFPlat.dll")
HRESULT MFCalculateImageSize(const(Guid)* guidSubtype, uint unWidth, uint unHeight, uint* pcbImageSize);

@DllImport("MFPlat.dll")
HRESULT MFFrameRateToAverageTimePerFrame(uint unNumerator, uint unDenominator, ulong* punAverageTimePerFrame);

@DllImport("MFPlat.dll")
HRESULT MFAverageTimePerFrameToFrameRate(ulong unAverageTimePerFrame, uint* punNumerator, uint* punDenominator);

@DllImport("MFPlat.dll")
HRESULT MFInitMediaTypeFromMFVideoFormat(IMFMediaType pMFType, char* pMFVF, uint cbBufSize);

@DllImport("MFPlat.dll")
HRESULT MFInitMediaTypeFromWaveFormatEx(IMFMediaType pMFType, char* pWaveFormat, uint cbBufSize);

@DllImport("MFPlat.dll")
HRESULT MFInitMediaTypeFromAMMediaType(IMFMediaType pMFType, const(AM_MEDIA_TYPE)* pAMType);

@DllImport("MFPlat.dll")
HRESULT MFInitAMMediaTypeFromMFMediaType(IMFMediaType pMFType, Guid guidFormatBlockType, AM_MEDIA_TYPE* pAMType);

@DllImport("MFPlat.dll")
HRESULT MFCreateAMMediaTypeFromMFMediaType(IMFMediaType pMFType, Guid guidFormatBlockType, AM_MEDIA_TYPE** ppAMType);

@DllImport("MFPlat.dll")
BOOL MFCompareFullToPartialMediaType(IMFMediaType pMFTypeFull, IMFMediaType pMFTypePartial);

@DllImport("MFPlat.dll")
HRESULT MFWrapMediaType(IMFMediaType pOrig, const(Guid)* MajorType, const(Guid)* SubType, IMFMediaType* ppWrap);

@DllImport("MFPlat.dll")
HRESULT MFUnwrapMediaType(IMFMediaType pWrap, IMFMediaType* ppOrig);

@DllImport("MFPlat.dll")
HRESULT MFCreateVideoMediaType(const(MFVIDEOFORMAT)* pVideoFormat, IMFVideoMediaType* ppIVideoMediaType);

@DllImport("MFPlat.dll")
HRESULT MFCreateVideoMediaTypeFromSubtype(const(Guid)* pAMSubtype, IMFVideoMediaType* ppIVideoMediaType);

@DllImport("EVR.dll")
BOOL MFIsFormatYUV(uint Format);

@DllImport("MFPlat.dll")
HRESULT MFCreateVideoMediaTypeFromBitMapInfoHeader(const(BITMAPINFOHEADER)* pbmihBitMapInfoHeader, uint dwPixelAspectRatioX, uint dwPixelAspectRatioY, MFVideoInterlaceMode InterlaceMode, ulong VideoFlags, ulong qwFramesPerSecondNumerator, ulong qwFramesPerSecondDenominator, uint dwMaxBitRate, IMFVideoMediaType* ppIVideoMediaType);

@DllImport("MFPlat.dll")
HRESULT MFGetStrideForBitmapInfoHeader(uint format, uint dwWidth, int* pStride);

@DllImport("MFPlat.dll")
HRESULT MFGetPlaneSize(uint format, uint dwWidth, uint dwHeight, uint* pdwPlaneSize);

@DllImport("MFPlat.dll")
HRESULT MFCreateVideoMediaTypeFromBitMapInfoHeaderEx(char* pbmihBitMapInfoHeader, uint cbBitMapInfoHeader, uint dwPixelAspectRatioX, uint dwPixelAspectRatioY, MFVideoInterlaceMode InterlaceMode, ulong VideoFlags, uint dwFramesPerSecondNumerator, uint dwFramesPerSecondDenominator, uint dwMaxBitRate, IMFVideoMediaType* ppIVideoMediaType);

@DllImport("MFPlat.dll")
HRESULT MFCreateMediaTypeFromRepresentation(Guid guidRepresentation, void* pvRepresentation, IMFMediaType* ppIMediaType);

@DllImport("MFPlat.dll")
HRESULT MFCreateAudioMediaType(const(WAVEFORMATEX)* pAudioFormat, IMFAudioMediaType* ppIAudioMediaType);

@DllImport("MFPlat.dll")
uint MFGetUncompressedVideoFormat(const(MFVIDEOFORMAT)* pVideoFormat);

@DllImport("MFPlat.dll")
HRESULT MFInitVideoFormat(MFVIDEOFORMAT* pVideoFormat, MFStandardVideoFormat type);

@DllImport("MFPlat.dll")
HRESULT MFInitVideoFormat_RGB(MFVIDEOFORMAT* pVideoFormat, uint dwWidth, uint dwHeight, uint D3Dfmt);

@DllImport("MFPlat.dll")
HRESULT MFConvertColorInfoToDXVA(uint* pdwToDXVA, const(MFVIDEOFORMAT)* pFromFormat);

@DllImport("MFPlat.dll")
HRESULT MFConvertColorInfoFromDXVA(MFVIDEOFORMAT* pToFormat, uint dwFromDXVA);

@DllImport("MFPlat.dll")
HRESULT MFCopyImage(char* pDest, int lDestStride, char* pSrc, int lSrcStride, uint dwWidthInBytes, uint dwLines);

@DllImport("MFPlat.dll")
HRESULT MFConvertFromFP16Array(char* pDest, char* pSrc, uint dwCount);

@DllImport("MFPlat.dll")
HRESULT MFConvertToFP16Array(char* pDest, char* pSrc, uint dwCount);

@DllImport("MFPlat.dll")
HRESULT MFCreate2DMediaBuffer(uint dwWidth, uint dwHeight, uint dwFourCC, BOOL fBottomUp, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat.dll")
HRESULT MFCreateMediaBufferFromMediaType(IMFMediaType pMediaType, long llDuration, uint dwMinLength, uint dwMinAlignment, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat.dll")
HRESULT MFCreateCollection(IMFCollection* ppIMFCollection);

@DllImport("MFPlat.dll")
void* MFHeapAlloc(uint nSize, uint dwFlags, byte* pszFile, int line, EAllocationType eat);

@DllImport("MFPlat.dll")
void MFHeapFree(void* pv);

@DllImport("MFPlat.dll")
long MFllMulDiv(long a, long b, long c, long d);

@DllImport("MFPlat.dll")
HRESULT MFGetContentProtectionSystemCLSID(const(Guid)* guidProtectionSystemID, Guid* pclsid);

@DllImport("MFPlat.dll")
HRESULT MFCombineSamples(IMFSample pSample, IMFSample pSampleToAdd, uint dwMaxMergedDurationInMS, int* pMerged);

@DllImport("MFPlat.dll")
HRESULT MFSplitSample(IMFSample pSample, char* pOutputSamples, uint dwOutputSampleMaxCount, uint* pdwOutputSampleCount);

@DllImport("MFReadWrite.dll")
HRESULT MFCreateSourceReaderFromURL(const(wchar)* pwszURL, IMFAttributes pAttributes, IMFSourceReader* ppSourceReader);

@DllImport("MFReadWrite.dll")
HRESULT MFCreateSourceReaderFromByteStream(IMFByteStream pByteStream, IMFAttributes pAttributes, IMFSourceReader* ppSourceReader);

@DllImport("MFReadWrite.dll")
HRESULT MFCreateSourceReaderFromMediaSource(IMFMediaSource pMediaSource, IMFAttributes pAttributes, IMFSourceReader* ppSourceReader);

@DllImport("MFReadWrite.dll")
HRESULT MFCreateSinkWriterFromURL(const(wchar)* pwszOutputURL, IMFByteStream pByteStream, IMFAttributes pAttributes, IMFSinkWriter* ppSinkWriter);

@DllImport("MFReadWrite.dll")
HRESULT MFCreateSinkWriterFromMediaSink(IMFMediaSink pMediaSink, IMFAttributes pAttributes, IMFSinkWriter* ppSinkWriter);

@DllImport("EVR.dll")
HRESULT MFCreateVideoPresenter(IUnknown pOwner, const(Guid)* riidDevice, const(Guid)* riid, void** ppVideoPresenter);

@DllImport("EVR.dll")
HRESULT MFCreateVideoMixer(IUnknown pOwner, const(Guid)* riidDevice, const(Guid)* riid, void** ppv);

@DllImport("EVR.dll")
HRESULT MFCreateVideoMixerAndPresenter(IUnknown pMixerOwner, IUnknown pPresenterOwner, const(Guid)* riidMixer, void** ppvVideoMixer, const(Guid)* riidPresenter, void** ppvVideoPresenter);

@DllImport("MF.dll")
HRESULT MFCreateVideoRenderer(const(Guid)* riidRenderer, void** ppVideoRenderer);

@DllImport("EVR.dll")
HRESULT MFCreateVideoSampleFromSurface(IUnknown pUnkSurface, IMFSample* ppSample);

@DllImport("EVR.dll")
HRESULT MFCreateVideoSampleAllocator(const(Guid)* riid, void** ppSampleAllocator);

@DllImport("MFPlay.dll")
HRESULT MFPCreateMediaPlayer(const(wchar)* pwszURL, BOOL fStartPlayback, uint creationOptions, IMFPMediaPlayerCallback pCallback, HWND hWnd, IMFPMediaPlayer* ppMediaPlayer);

@DllImport("MF.dll")
HRESULT MFCreateEncryptedMediaExtensionsStoreActivate(IMFPMPHostApp pmpHost, IStream objectStream, const(wchar)* classId, IMFActivate* activate);

struct D3D11_VIDEO_DECODER_DESC
{
    Guid Guid;
    uint SampleWidth;
    uint SampleHeight;
    DXGI_FORMAT OutputFormat;
}

struct D3D11_VIDEO_DECODER_CONFIG
{
    Guid guidConfigBitstreamEncryption;
    Guid guidConfigMBcontrolEncryption;
    Guid guidConfigResidDiffEncryption;
    uint ConfigBitstreamRaw;
    uint ConfigMBcontrolRasterOrder;
    uint ConfigResidDiffHost;
    uint ConfigSpatialResid8;
    uint ConfigResid8Subtraction;
    uint ConfigSpatialHost8or9Clipping;
    uint ConfigSpatialResidInterleaved;
    uint ConfigIntraResidUnsigned;
    uint ConfigResidDiffAccelerator;
    uint ConfigHostInverseScan;
    uint ConfigSpecificIDCT;
    uint Config4GroupedCoefs;
    ushort ConfigMinRenderTargetBuffCount;
    ushort ConfigDecoderSpecific;
}

enum D3D11_VIDEO_DECODER_BUFFER_TYPE
{
    D3D11_VIDEO_DECODER_BUFFER_PICTURE_PARAMETERS = 0,
    D3D11_VIDEO_DECODER_BUFFER_MACROBLOCK_CONTROL = 1,
    D3D11_VIDEO_DECODER_BUFFER_RESIDUAL_DIFFERENCE = 2,
    D3D11_VIDEO_DECODER_BUFFER_DEBLOCKING_CONTROL = 3,
    D3D11_VIDEO_DECODER_BUFFER_INVERSE_QUANTIZATION_MATRIX = 4,
    D3D11_VIDEO_DECODER_BUFFER_SLICE_CONTROL = 5,
    D3D11_VIDEO_DECODER_BUFFER_BITSTREAM = 6,
    D3D11_VIDEO_DECODER_BUFFER_MOTION_VECTOR = 7,
    D3D11_VIDEO_DECODER_BUFFER_FILM_GRAIN = 8,
}

struct D3D11_AES_CTR_IV
{
    ulong IV;
    ulong Count;
}

struct D3D11_ENCRYPTED_BLOCK_INFO
{
    uint NumEncryptedBytesAtBeginning;
    uint NumBytesInSkipPattern;
    uint NumBytesInEncryptPattern;
}

struct D3D11_VIDEO_DECODER_BUFFER_DESC
{
    D3D11_VIDEO_DECODER_BUFFER_TYPE BufferType;
    uint BufferIndex;
    uint DataOffset;
    uint DataSize;
    uint FirstMBaddress;
    uint NumMBsInBuffer;
    uint Width;
    uint Height;
    uint Stride;
    uint ReservedBits;
    void* pIV;
    uint IVSize;
    BOOL PartialEncryption;
    D3D11_ENCRYPTED_BLOCK_INFO EncryptedBlockInfo;
}

struct D3D11_VIDEO_DECODER_EXTENSION
{
    uint Function;
    void* pPrivateInputData;
    uint PrivateInputDataSize;
    void* pPrivateOutputData;
    uint PrivateOutputDataSize;
    uint ResourceCount;
    ID3D11Resource* ppResourceList;
}

const GUID IID_ID3D11VideoDecoder = {0x3C9C5B51, 0x995D, 0x48D1, [0x9B, 0x8D, 0xFA, 0x5C, 0xAE, 0xDE, 0xD6, 0x5C]};
@GUID(0x3C9C5B51, 0x995D, 0x48D1, [0x9B, 0x8D, 0xFA, 0x5C, 0xAE, 0xDE, 0xD6, 0x5C]);
interface ID3D11VideoDecoder : ID3D11DeviceChild
{
    HRESULT GetCreationParameters(D3D11_VIDEO_DECODER_DESC* pVideoDesc, D3D11_VIDEO_DECODER_CONFIG* pConfig);
    HRESULT GetDriverHandle(HANDLE* pDriverHandle);
}

enum D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT
{
    D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT_INPUT = 1,
    D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT_OUTPUT = 2,
}

enum D3D11_VIDEO_PROCESSOR_DEVICE_CAPS
{
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_LINEAR_SPACE = 1,
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_xvYCC = 2,
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_RGB_RANGE_CONVERSION = 4,
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_YCbCr_MATRIX_CONVERSION = 8,
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_NOMINAL_RANGE = 16,
}

enum D3D11_VIDEO_PROCESSOR_FEATURE_CAPS
{
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_FILL = 1,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_CONSTRICTION = 2,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_LUMA_KEY = 4,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_PALETTE = 8,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_LEGACY = 16,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_STEREO = 32,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ROTATION = 64,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_STREAM = 128,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_PIXEL_ASPECT_RATIO = 256,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_MIRROR = 512,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_SHADER_USAGE = 1024,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_METADATA_HDR10 = 2048,
}

enum D3D11_VIDEO_PROCESSOR_FILTER_CAPS
{
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_BRIGHTNESS = 1,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_CONTRAST = 2,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_HUE = 4,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_SATURATION = 8,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_NOISE_REDUCTION = 16,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_EDGE_ENHANCEMENT = 32,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_ANAMORPHIC_SCALING = 64,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_STEREO_ADJUSTMENT = 128,
}

enum D3D11_VIDEO_PROCESSOR_FORMAT_CAPS
{
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_INTERLACED = 1,
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_PROCAMP = 2,
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_LUMA_KEY = 4,
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_PALETTE_INTERLACED = 8,
}

enum D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS
{
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_DENOISE = 1,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_DERINGING = 2,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_EDGE_ENHANCEMENT = 4,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_COLOR_CORRECTION = 8,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_FLESH_TONE_MAPPING = 16,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_IMAGE_STABILIZATION = 32,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_SUPER_RESOLUTION = 64,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_ANAMORPHIC_SCALING = 128,
}

enum D3D11_VIDEO_PROCESSOR_STEREO_CAPS
{
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_MONO_OFFSET = 1,
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_ROW_INTERLEAVED = 2,
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_COLUMN_INTERLEAVED = 4,
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_CHECKERBOARD = 8,
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_FLIP_MODE = 16,
}

struct D3D11_VIDEO_PROCESSOR_CAPS
{
    uint DeviceCaps;
    uint FeatureCaps;
    uint FilterCaps;
    uint InputFormatCaps;
    uint AutoStreamCaps;
    uint StereoCaps;
    uint RateConversionCapsCount;
    uint MaxInputStreams;
    uint MaxStreamStates;
}

enum D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS
{
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_BLEND = 1,
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_BOB = 2,
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_ADAPTIVE = 4,
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_MOTION_COMPENSATION = 8,
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_INVERSE_TELECINE = 16,
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_FRAME_RATE_CONVERSION = 32,
}

enum D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS
{
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_32 = 1,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_22 = 2,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_2224 = 4,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_2332 = 8,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_32322 = 16,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_55 = 32,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_64 = 64,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_87 = 128,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_222222222223 = 256,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_OTHER = -2147483648,
}

struct D3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS
{
    uint PastFrames;
    uint FutureFrames;
    uint ProcessorCaps;
    uint ITelecineCaps;
    uint CustomRateCount;
}

enum D3D11_CONTENT_PROTECTION_CAPS
{
    D3D11_CONTENT_PROTECTION_CAPS_SOFTWARE = 1,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE = 2,
    D3D11_CONTENT_PROTECTION_CAPS_PROTECTION_ALWAYS_ON = 4,
    D3D11_CONTENT_PROTECTION_CAPS_PARTIAL_DECRYPTION = 8,
    D3D11_CONTENT_PROTECTION_CAPS_CONTENT_KEY = 16,
    D3D11_CONTENT_PROTECTION_CAPS_FRESHEN_SESSION_KEY = 32,
    D3D11_CONTENT_PROTECTION_CAPS_ENCRYPTED_READ_BACK = 64,
    D3D11_CONTENT_PROTECTION_CAPS_ENCRYPTED_READ_BACK_KEY = 128,
    D3D11_CONTENT_PROTECTION_CAPS_SEQUENTIAL_CTR_IV = 256,
    D3D11_CONTENT_PROTECTION_CAPS_ENCRYPT_SLICEDATA_ONLY = 512,
    D3D11_CONTENT_PROTECTION_CAPS_DECRYPTION_BLT = 1024,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_PROTECT_UNCOMPRESSED = 2048,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_PROTECTED_MEMORY_PAGEABLE = 4096,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_TEARDOWN = 8192,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_DRM_COMMUNICATION = 16384,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_DRM_COMMUNICATION_MULTI_THREADED = 32768,
}

struct D3D11_VIDEO_CONTENT_PROTECTION_CAPS
{
    uint Caps;
    uint KeyExchangeTypeCount;
    uint BlockAlignmentSize;
    ulong ProtectedMemorySize;
}

struct D3D11_VIDEO_PROCESSOR_CUSTOM_RATE
{
    DXGI_RATIONAL CustomRate;
    uint OutputFrames;
    BOOL InputInterlaced;
    uint InputFramesOrFields;
}

enum D3D11_VIDEO_PROCESSOR_FILTER
{
    D3D11_VIDEO_PROCESSOR_FILTER_BRIGHTNESS = 0,
    D3D11_VIDEO_PROCESSOR_FILTER_CONTRAST = 1,
    D3D11_VIDEO_PROCESSOR_FILTER_HUE = 2,
    D3D11_VIDEO_PROCESSOR_FILTER_SATURATION = 3,
    D3D11_VIDEO_PROCESSOR_FILTER_NOISE_REDUCTION = 4,
    D3D11_VIDEO_PROCESSOR_FILTER_EDGE_ENHANCEMENT = 5,
    D3D11_VIDEO_PROCESSOR_FILTER_ANAMORPHIC_SCALING = 6,
    D3D11_VIDEO_PROCESSOR_FILTER_STEREO_ADJUSTMENT = 7,
}

struct D3D11_VIDEO_PROCESSOR_FILTER_RANGE
{
    int Minimum;
    int Maximum;
    int Default;
    float Multiplier;
}

enum D3D11_VIDEO_FRAME_FORMAT
{
    D3D11_VIDEO_FRAME_FORMAT_PROGRESSIVE = 0,
    D3D11_VIDEO_FRAME_FORMAT_INTERLACED_TOP_FIELD_FIRST = 1,
    D3D11_VIDEO_FRAME_FORMAT_INTERLACED_BOTTOM_FIELD_FIRST = 2,
}

enum D3D11_VIDEO_USAGE
{
    D3D11_VIDEO_USAGE_PLAYBACK_NORMAL = 0,
    D3D11_VIDEO_USAGE_OPTIMAL_SPEED = 1,
    D3D11_VIDEO_USAGE_OPTIMAL_QUALITY = 2,
}

struct D3D11_VIDEO_PROCESSOR_CONTENT_DESC
{
    D3D11_VIDEO_FRAME_FORMAT InputFrameFormat;
    DXGI_RATIONAL InputFrameRate;
    uint InputWidth;
    uint InputHeight;
    DXGI_RATIONAL OutputFrameRate;
    uint OutputWidth;
    uint OutputHeight;
    D3D11_VIDEO_USAGE Usage;
}

const GUID IID_ID3D11VideoProcessorEnumerator = {0x31627037, 0x53AB, 0x4200, [0x90, 0x61, 0x05, 0xFA, 0xA9, 0xAB, 0x45, 0xF9]};
@GUID(0x31627037, 0x53AB, 0x4200, [0x90, 0x61, 0x05, 0xFA, 0xA9, 0xAB, 0x45, 0xF9]);
interface ID3D11VideoProcessorEnumerator : ID3D11DeviceChild
{
    HRESULT GetVideoProcessorContentDesc(D3D11_VIDEO_PROCESSOR_CONTENT_DESC* pContentDesc);
    HRESULT CheckVideoProcessorFormat(DXGI_FORMAT Format, uint* pFlags);
    HRESULT GetVideoProcessorCaps(D3D11_VIDEO_PROCESSOR_CAPS* pCaps);
    HRESULT GetVideoProcessorRateConversionCaps(uint TypeIndex, D3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS* pCaps);
    HRESULT GetVideoProcessorCustomRate(uint TypeIndex, uint CustomRateIndex, D3D11_VIDEO_PROCESSOR_CUSTOM_RATE* pRate);
    HRESULT GetVideoProcessorFilterRange(D3D11_VIDEO_PROCESSOR_FILTER Filter, D3D11_VIDEO_PROCESSOR_FILTER_RANGE* pRange);
}

struct D3D11_VIDEO_COLOR_RGBA
{
    float R;
    float G;
    float B;
    float A;
}

struct D3D11_VIDEO_COLOR_YCbCrA
{
    float Y;
    float Cb;
    float Cr;
    float A;
}

struct D3D11_VIDEO_COLOR
{
    _Anonymous_e__Union Anonymous;
}

enum D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE
{
    D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_UNDEFINED = 0,
    D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_16_235 = 1,
    D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_0_255 = 2,
}

struct D3D11_VIDEO_PROCESSOR_COLOR_SPACE
{
    uint _bitfield;
}

enum D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE
{
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_OPAQUE = 0,
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_BACKGROUND = 1,
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_DESTINATION = 2,
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_SOURCE_STREAM = 3,
}

enum D3D11_VIDEO_PROCESSOR_OUTPUT_RATE
{
    D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_NORMAL = 0,
    D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_HALF = 1,
    D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_CUSTOM = 2,
}

enum D3D11_VIDEO_PROCESSOR_STEREO_FORMAT
{
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_MONO = 0,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_HORIZONTAL = 1,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_VERTICAL = 2,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_SEPARATE = 3,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_MONO_OFFSET = 4,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_ROW_INTERLEAVED = 5,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_COLUMN_INTERLEAVED = 6,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_CHECKERBOARD = 7,
}

enum D3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE
{
    D3D11_VIDEO_PROCESSOR_STEREO_FLIP_NONE = 0,
    D3D11_VIDEO_PROCESSOR_STEREO_FLIP_FRAME0 = 1,
    D3D11_VIDEO_PROCESSOR_STEREO_FLIP_FRAME1 = 2,
}

enum D3D11_VIDEO_PROCESSOR_ROTATION
{
    D3D11_VIDEO_PROCESSOR_ROTATION_IDENTITY = 0,
    D3D11_VIDEO_PROCESSOR_ROTATION_90 = 1,
    D3D11_VIDEO_PROCESSOR_ROTATION_180 = 2,
    D3D11_VIDEO_PROCESSOR_ROTATION_270 = 3,
}

struct D3D11_VIDEO_PROCESSOR_STREAM
{
    BOOL Enable;
    uint OutputIndex;
    uint InputFrameOrField;
    uint PastFrames;
    uint FutureFrames;
    ID3D11VideoProcessorInputView* ppPastSurfaces;
    ID3D11VideoProcessorInputView pInputSurface;
    ID3D11VideoProcessorInputView* ppFutureSurfaces;
    ID3D11VideoProcessorInputView* ppPastSurfacesRight;
    ID3D11VideoProcessorInputView pInputSurfaceRight;
    ID3D11VideoProcessorInputView* ppFutureSurfacesRight;
}

const GUID IID_ID3D11VideoProcessor = {0x1D7B0652, 0x185F, 0x41C6, [0x85, 0xCE, 0x0C, 0x5B, 0xE3, 0xD4, 0xAE, 0x6C]};
@GUID(0x1D7B0652, 0x185F, 0x41C6, [0x85, 0xCE, 0x0C, 0x5B, 0xE3, 0xD4, 0xAE, 0x6C]);
interface ID3D11VideoProcessor : ID3D11DeviceChild
{
    void GetContentDesc(D3D11_VIDEO_PROCESSOR_CONTENT_DESC* pDesc);
    void GetRateConversionCaps(D3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS* pCaps);
}

struct D3D11_OMAC
{
    ubyte Omac;
}

enum D3D11_AUTHENTICATED_CHANNEL_TYPE
{
    D3D11_AUTHENTICATED_CHANNEL_D3D11 = 1,
    D3D11_AUTHENTICATED_CHANNEL_DRIVER_SOFTWARE = 2,
    D3D11_AUTHENTICATED_CHANNEL_DRIVER_HARDWARE = 3,
}

const GUID IID_ID3D11AuthenticatedChannel = {0x3015A308, 0xDCBD, 0x47AA, [0xA7, 0x47, 0x19, 0x24, 0x86, 0xD1, 0x4D, 0x4A]};
@GUID(0x3015A308, 0xDCBD, 0x47AA, [0xA7, 0x47, 0x19, 0x24, 0x86, 0xD1, 0x4D, 0x4A]);
interface ID3D11AuthenticatedChannel : ID3D11DeviceChild
{
    HRESULT GetCertificateSize(uint* pCertificateSize);
    HRESULT GetCertificate(uint CertificateSize, char* pCertificate);
    void GetChannelHandle(HANDLE* pChannelHandle);
}

struct D3D11_AUTHENTICATED_QUERY_INPUT
{
    Guid QueryType;
    HANDLE hChannel;
    uint SequenceNumber;
}

struct D3D11_AUTHENTICATED_QUERY_OUTPUT
{
    D3D11_OMAC omac;
    Guid QueryType;
    HANDLE hChannel;
    uint SequenceNumber;
    HRESULT ReturnCode;
}

struct D3D11_AUTHENTICATED_QUERY_PROTECTION_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    D3D11_AUTHENTICATED_PROTECTION_FLAGS ProtectionFlags;
}

struct D3D11_AUTHENTICATED_QUERY_CHANNEL_TYPE_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    D3D11_AUTHENTICATED_CHANNEL_TYPE ChannelType;
}

struct D3D11_AUTHENTICATED_QUERY_DEVICE_HANDLE_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    HANDLE DeviceHandle;
}

struct D3D11_AUTHENTICATED_QUERY_CRYPTO_SESSION_INPUT
{
    D3D11_AUTHENTICATED_QUERY_INPUT Input;
    HANDLE DecoderHandle;
}

struct D3D11_AUTHENTICATED_QUERY_CRYPTO_SESSION_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    HANDLE DecoderHandle;
    HANDLE CryptoSessionHandle;
    HANDLE DeviceHandle;
}

struct D3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_COUNT_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    uint RestrictedSharedResourceProcessCount;
}

struct D3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_INPUT
{
    D3D11_AUTHENTICATED_QUERY_INPUT Input;
    uint ProcessIndex;
}

enum D3D11_AUTHENTICATED_PROCESS_IDENTIFIER_TYPE
{
    D3D11_PROCESSIDTYPE_UNKNOWN = 0,
    D3D11_PROCESSIDTYPE_DWM = 1,
    D3D11_PROCESSIDTYPE_HANDLE = 2,
}

struct D3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    uint ProcessIndex;
    D3D11_AUTHENTICATED_PROCESS_IDENTIFIER_TYPE ProcessIdentifier;
    HANDLE ProcessHandle;
}

struct D3D11_AUTHENTICATED_QUERY_UNRESTRICTED_PROTECTED_SHARED_RESOURCE_COUNT_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    uint UnrestrictedProtectedSharedResourceCount;
}

struct D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_COUNT_INPUT
{
    D3D11_AUTHENTICATED_QUERY_INPUT Input;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
}

struct D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_COUNT_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
    uint OutputIDCount;
}

struct D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_INPUT
{
    D3D11_AUTHENTICATED_QUERY_INPUT Input;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
    uint OutputIDIndex;
}

struct D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
    uint OutputIDIndex;
    ulong OutputID;
}

enum D3D11_BUS_TYPE
{
    D3D11_BUS_TYPE_OTHER = 0,
    D3D11_BUS_TYPE_PCI = 1,
    D3D11_BUS_TYPE_PCIX = 2,
    D3D11_BUS_TYPE_PCIEXPRESS = 3,
    D3D11_BUS_TYPE_AGP = 4,
    D3D11_BUS_IMPL_MODIFIER_INSIDE_OF_CHIPSET = 65536,
    D3D11_BUS_IMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_CHIP = 131072,
    D3D11_BUS_IMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_SOCKET = 196608,
    D3D11_BUS_IMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR = 262144,
    D3D11_BUS_IMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR_INSIDE_OF_NUAE = 327680,
    D3D11_BUS_IMPL_MODIFIER_NON_STANDARD = -2147483648,
}

struct D3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    D3D11_BUS_TYPE BusType;
    BOOL AccessibleInContiguousBlocks;
    BOOL AccessibleInNonContiguousBlocks;
}

struct D3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_ENCRYPTION_GUID_COUNT_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    uint EncryptionGuidCount;
}

struct D3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_ENCRYPTION_GUID_INPUT
{
    D3D11_AUTHENTICATED_QUERY_INPUT Input;
    uint EncryptionGuidIndex;
}

struct D3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_ENCRYPTION_GUID_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    uint EncryptionGuidIndex;
    Guid EncryptionGuid;
}

struct D3D11_AUTHENTICATED_QUERY_CURRENT_ACCESSIBILITY_ENCRYPTION_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    Guid EncryptionGuid;
}

struct D3D11_AUTHENTICATED_CONFIGURE_INPUT
{
    D3D11_OMAC omac;
    Guid ConfigureType;
    HANDLE hChannel;
    uint SequenceNumber;
}

struct D3D11_AUTHENTICATED_CONFIGURE_OUTPUT
{
    D3D11_OMAC omac;
    Guid ConfigureType;
    HANDLE hChannel;
    uint SequenceNumber;
    HRESULT ReturnCode;
}

struct D3D11_AUTHENTICATED_CONFIGURE_INITIALIZE_INPUT
{
    D3D11_AUTHENTICATED_CONFIGURE_INPUT Parameters;
    uint StartSequenceQuery;
    uint StartSequenceConfigure;
}

struct D3D11_AUTHENTICATED_CONFIGURE_PROTECTION_INPUT
{
    D3D11_AUTHENTICATED_CONFIGURE_INPUT Parameters;
    D3D11_AUTHENTICATED_PROTECTION_FLAGS Protections;
}

struct D3D11_AUTHENTICATED_CONFIGURE_CRYPTO_SESSION_INPUT
{
    D3D11_AUTHENTICATED_CONFIGURE_INPUT Parameters;
    HANDLE DecoderHandle;
    HANDLE CryptoSessionHandle;
    HANDLE DeviceHandle;
}

struct D3D11_AUTHENTICATED_CONFIGURE_SHARED_RESOURCE_INPUT
{
    D3D11_AUTHENTICATED_CONFIGURE_INPUT Parameters;
    D3D11_AUTHENTICATED_PROCESS_IDENTIFIER_TYPE ProcessType;
    HANDLE ProcessHandle;
    BOOL AllowAccess;
}

struct D3D11_AUTHENTICATED_CONFIGURE_ACCESSIBLE_ENCRYPTION_INPUT
{
    D3D11_AUTHENTICATED_CONFIGURE_INPUT Parameters;
    Guid EncryptionGuid;
}

const GUID IID_ID3D11CryptoSession = {0x9B32F9AD, 0xBDCC, 0x40A6, [0xA3, 0x9D, 0xD5, 0xC8, 0x65, 0x84, 0x57, 0x20]};
@GUID(0x9B32F9AD, 0xBDCC, 0x40A6, [0xA3, 0x9D, 0xD5, 0xC8, 0x65, 0x84, 0x57, 0x20]);
interface ID3D11CryptoSession : ID3D11DeviceChild
{
    void GetCryptoType(Guid* pCryptoType);
    void GetDecoderProfile(Guid* pDecoderProfile);
    HRESULT GetCertificateSize(uint* pCertificateSize);
    HRESULT GetCertificate(uint CertificateSize, char* pCertificate);
    void GetCryptoSessionHandle(HANDLE* pCryptoSessionHandle);
}

enum D3D11_VDOV_DIMENSION
{
    D3D11_VDOV_DIMENSION_UNKNOWN = 0,
    D3D11_VDOV_DIMENSION_TEXTURE2D = 1,
}

struct D3D11_TEX2D_VDOV
{
    uint ArraySlice;
}

struct D3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC
{
    Guid DecodeProfile;
    D3D11_VDOV_DIMENSION ViewDimension;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_ID3D11VideoDecoderOutputView = {0xC2931AEA, 0x2A85, 0x4F20, [0x86, 0x0F, 0xFB, 0xA1, 0xFD, 0x25, 0x6E, 0x18]};
@GUID(0xC2931AEA, 0x2A85, 0x4F20, [0x86, 0x0F, 0xFB, 0xA1, 0xFD, 0x25, 0x6E, 0x18]);
interface ID3D11VideoDecoderOutputView : ID3D11View
{
    void GetDesc(D3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC* pDesc);
}

enum D3D11_VPIV_DIMENSION
{
    D3D11_VPIV_DIMENSION_UNKNOWN = 0,
    D3D11_VPIV_DIMENSION_TEXTURE2D = 1,
}

struct D3D11_TEX2D_VPIV
{
    uint MipSlice;
    uint ArraySlice;
}

struct D3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC
{
    uint FourCC;
    D3D11_VPIV_DIMENSION ViewDimension;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_ID3D11VideoProcessorInputView = {0x11EC5A5F, 0x51DC, 0x4945, [0xAB, 0x34, 0x6E, 0x8C, 0x21, 0x30, 0x0E, 0xA5]};
@GUID(0x11EC5A5F, 0x51DC, 0x4945, [0xAB, 0x34, 0x6E, 0x8C, 0x21, 0x30, 0x0E, 0xA5]);
interface ID3D11VideoProcessorInputView : ID3D11View
{
    void GetDesc(D3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC* pDesc);
}

enum D3D11_VPOV_DIMENSION
{
    D3D11_VPOV_DIMENSION_UNKNOWN = 0,
    D3D11_VPOV_DIMENSION_TEXTURE2D = 1,
    D3D11_VPOV_DIMENSION_TEXTURE2DARRAY = 2,
}

struct D3D11_TEX2D_VPOV
{
    uint MipSlice;
}

struct D3D11_TEX2D_ARRAY_VPOV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

struct D3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC
{
    D3D11_VPOV_DIMENSION ViewDimension;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_ID3D11VideoProcessorOutputView = {0xA048285E, 0x25A9, 0x4527, [0xBD, 0x93, 0xD6, 0x8B, 0x68, 0xC4, 0x42, 0x54]};
@GUID(0xA048285E, 0x25A9, 0x4527, [0xBD, 0x93, 0xD6, 0x8B, 0x68, 0xC4, 0x42, 0x54]);
interface ID3D11VideoProcessorOutputView : ID3D11View
{
    void GetDesc(D3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC* pDesc);
}

const GUID IID_ID3D11VideoContext = {0x61F21C45, 0x3C0E, 0x4A74, [0x9C, 0xEA, 0x67, 0x10, 0x0D, 0x9A, 0xD5, 0xE4]};
@GUID(0x61F21C45, 0x3C0E, 0x4A74, [0x9C, 0xEA, 0x67, 0x10, 0x0D, 0x9A, 0xD5, 0xE4]);
interface ID3D11VideoContext : ID3D11DeviceChild
{
    HRESULT GetDecoderBuffer(ID3D11VideoDecoder pDecoder, D3D11_VIDEO_DECODER_BUFFER_TYPE Type, uint* pBufferSize, void** ppBuffer);
    HRESULT ReleaseDecoderBuffer(ID3D11VideoDecoder pDecoder, D3D11_VIDEO_DECODER_BUFFER_TYPE Type);
    HRESULT DecoderBeginFrame(ID3D11VideoDecoder pDecoder, ID3D11VideoDecoderOutputView pView, uint ContentKeySize, char* pContentKey);
    HRESULT DecoderEndFrame(ID3D11VideoDecoder pDecoder);
    HRESULT SubmitDecoderBuffers(ID3D11VideoDecoder pDecoder, uint NumBuffers, char* pBufferDesc);
    int DecoderExtension(ID3D11VideoDecoder pDecoder, const(D3D11_VIDEO_DECODER_EXTENSION)* pExtensionData);
    void VideoProcessorSetOutputTargetRect(ID3D11VideoProcessor pVideoProcessor, BOOL Enable, const(RECT)* pRect);
    void VideoProcessorSetOutputBackgroundColor(ID3D11VideoProcessor pVideoProcessor, BOOL YCbCr, const(D3D11_VIDEO_COLOR)* pColor);
    void VideoProcessorSetOutputColorSpace(ID3D11VideoProcessor pVideoProcessor, const(D3D11_VIDEO_PROCESSOR_COLOR_SPACE)* pColorSpace);
    void VideoProcessorSetOutputAlphaFillMode(ID3D11VideoProcessor pVideoProcessor, D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE AlphaFillMode, uint StreamIndex);
    void VideoProcessorSetOutputConstriction(ID3D11VideoProcessor pVideoProcessor, BOOL Enable, SIZE Size);
    void VideoProcessorSetOutputStereoMode(ID3D11VideoProcessor pVideoProcessor, BOOL Enable);
    int VideoProcessorSetOutputExtension(ID3D11VideoProcessor pVideoProcessor, const(Guid)* pExtensionGuid, uint DataSize, void* pData);
    void VideoProcessorGetOutputTargetRect(ID3D11VideoProcessor pVideoProcessor, int* Enabled, RECT* pRect);
    void VideoProcessorGetOutputBackgroundColor(ID3D11VideoProcessor pVideoProcessor, int* pYCbCr, D3D11_VIDEO_COLOR* pColor);
    void VideoProcessorGetOutputColorSpace(ID3D11VideoProcessor pVideoProcessor, D3D11_VIDEO_PROCESSOR_COLOR_SPACE* pColorSpace);
    void VideoProcessorGetOutputAlphaFillMode(ID3D11VideoProcessor pVideoProcessor, D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE* pAlphaFillMode, uint* pStreamIndex);
    void VideoProcessorGetOutputConstriction(ID3D11VideoProcessor pVideoProcessor, int* pEnabled, SIZE* pSize);
    void VideoProcessorGetOutputStereoMode(ID3D11VideoProcessor pVideoProcessor, int* pEnabled);
    int VideoProcessorGetOutputExtension(ID3D11VideoProcessor pVideoProcessor, const(Guid)* pExtensionGuid, uint DataSize, char* pData);
    void VideoProcessorSetStreamFrameFormat(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, D3D11_VIDEO_FRAME_FORMAT FrameFormat);
    void VideoProcessorSetStreamColorSpace(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, const(D3D11_VIDEO_PROCESSOR_COLOR_SPACE)* pColorSpace);
    void VideoProcessorSetStreamOutputRate(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, D3D11_VIDEO_PROCESSOR_OUTPUT_RATE OutputRate, BOOL RepeatFrame, const(DXGI_RATIONAL)* pCustomRate);
    void VideoProcessorSetStreamSourceRect(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, const(RECT)* pRect);
    void VideoProcessorSetStreamDestRect(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, const(RECT)* pRect);
    void VideoProcessorSetStreamAlpha(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, float Alpha);
    void VideoProcessorSetStreamPalette(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, uint Count, char* pEntries);
    void VideoProcessorSetStreamPixelAspectRatio(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, const(DXGI_RATIONAL)* pSourceAspectRatio, const(DXGI_RATIONAL)* pDestinationAspectRatio);
    void VideoProcessorSetStreamLumaKey(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, float Lower, float Upper);
    void VideoProcessorSetStreamStereoFormat(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, D3D11_VIDEO_PROCESSOR_STEREO_FORMAT Format, BOOL LeftViewFrame0, BOOL BaseViewFrame0, D3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE FlipMode, int MonoOffset);
    void VideoProcessorSetStreamAutoProcessingMode(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable);
    void VideoProcessorSetStreamFilter(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, D3D11_VIDEO_PROCESSOR_FILTER Filter, BOOL Enable, int Level);
    int VideoProcessorSetStreamExtension(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, const(Guid)* pExtensionGuid, uint DataSize, void* pData);
    void VideoProcessorGetStreamFrameFormat(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, D3D11_VIDEO_FRAME_FORMAT* pFrameFormat);
    void VideoProcessorGetStreamColorSpace(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, D3D11_VIDEO_PROCESSOR_COLOR_SPACE* pColorSpace);
    void VideoProcessorGetStreamOutputRate(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, D3D11_VIDEO_PROCESSOR_OUTPUT_RATE* pOutputRate, int* pRepeatFrame, DXGI_RATIONAL* pCustomRate);
    void VideoProcessorGetStreamSourceRect(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnabled, RECT* pRect);
    void VideoProcessorGetStreamDestRect(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnabled, RECT* pRect);
    void VideoProcessorGetStreamAlpha(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnabled, float* pAlpha);
    void VideoProcessorGetStreamPalette(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, uint Count, char* pEntries);
    void VideoProcessorGetStreamPixelAspectRatio(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnabled, DXGI_RATIONAL* pSourceAspectRatio, DXGI_RATIONAL* pDestinationAspectRatio);
    void VideoProcessorGetStreamLumaKey(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnabled, float* pLower, float* pUpper);
    void VideoProcessorGetStreamStereoFormat(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnable, D3D11_VIDEO_PROCESSOR_STEREO_FORMAT* pFormat, int* pLeftViewFrame0, int* pBaseViewFrame0, D3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE* pFlipMode, int* MonoOffset);
    void VideoProcessorGetStreamAutoProcessingMode(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnabled);
    void VideoProcessorGetStreamFilter(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, D3D11_VIDEO_PROCESSOR_FILTER Filter, int* pEnabled, int* pLevel);
    int VideoProcessorGetStreamExtension(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, const(Guid)* pExtensionGuid, uint DataSize, char* pData);
    HRESULT VideoProcessorBlt(ID3D11VideoProcessor pVideoProcessor, ID3D11VideoProcessorOutputView pView, uint OutputFrame, uint StreamCount, char* pStreams);
    HRESULT NegotiateCryptoSessionKeyExchange(ID3D11CryptoSession pCryptoSession, uint DataSize, char* pData);
    void EncryptionBlt(ID3D11CryptoSession pCryptoSession, ID3D11Texture2D pSrcSurface, ID3D11Texture2D pDstSurface, uint IVSize, char* pIV);
    void DecryptionBlt(ID3D11CryptoSession pCryptoSession, ID3D11Texture2D pSrcSurface, ID3D11Texture2D pDstSurface, D3D11_ENCRYPTED_BLOCK_INFO* pEncryptedBlockInfo, uint ContentKeySize, char* pContentKey, uint IVSize, char* pIV);
    void StartSessionKeyRefresh(ID3D11CryptoSession pCryptoSession, uint RandomNumberSize, char* pRandomNumber);
    void FinishSessionKeyRefresh(ID3D11CryptoSession pCryptoSession);
    HRESULT GetEncryptionBltKey(ID3D11CryptoSession pCryptoSession, uint KeySize, char* pReadbackKey);
    HRESULT NegotiateAuthenticatedChannelKeyExchange(ID3D11AuthenticatedChannel pChannel, uint DataSize, char* pData);
    HRESULT QueryAuthenticatedChannel(ID3D11AuthenticatedChannel pChannel, uint InputSize, char* pInput, uint OutputSize, char* pOutput);
    HRESULT ConfigureAuthenticatedChannel(ID3D11AuthenticatedChannel pChannel, uint InputSize, char* pInput, D3D11_AUTHENTICATED_CONFIGURE_OUTPUT* pOutput);
    void VideoProcessorSetStreamRotation(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, D3D11_VIDEO_PROCESSOR_ROTATION Rotation);
    void VideoProcessorGetStreamRotation(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnable, D3D11_VIDEO_PROCESSOR_ROTATION* pRotation);
}

const GUID IID_ID3D11VideoDevice = {0x10EC4D5B, 0x975A, 0x4689, [0xB9, 0xE4, 0xD0, 0xAA, 0xC3, 0x0F, 0xE3, 0x33]};
@GUID(0x10EC4D5B, 0x975A, 0x4689, [0xB9, 0xE4, 0xD0, 0xAA, 0xC3, 0x0F, 0xE3, 0x33]);
interface ID3D11VideoDevice : IUnknown
{
    HRESULT CreateVideoDecoder(const(D3D11_VIDEO_DECODER_DESC)* pVideoDesc, const(D3D11_VIDEO_DECODER_CONFIG)* pConfig, ID3D11VideoDecoder* ppDecoder);
    HRESULT CreateVideoProcessor(ID3D11VideoProcessorEnumerator pEnum, uint RateConversionIndex, ID3D11VideoProcessor* ppVideoProcessor);
    HRESULT CreateAuthenticatedChannel(D3D11_AUTHENTICATED_CHANNEL_TYPE ChannelType, ID3D11AuthenticatedChannel* ppAuthenticatedChannel);
    HRESULT CreateCryptoSession(const(Guid)* pCryptoType, const(Guid)* pDecoderProfile, const(Guid)* pKeyExchangeType, ID3D11CryptoSession* ppCryptoSession);
    HRESULT CreateVideoDecoderOutputView(ID3D11Resource pResource, const(D3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC)* pDesc, ID3D11VideoDecoderOutputView* ppVDOVView);
    HRESULT CreateVideoProcessorInputView(ID3D11Resource pResource, ID3D11VideoProcessorEnumerator pEnum, const(D3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC)* pDesc, ID3D11VideoProcessorInputView* ppVPIView);
    HRESULT CreateVideoProcessorOutputView(ID3D11Resource pResource, ID3D11VideoProcessorEnumerator pEnum, const(D3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC)* pDesc, ID3D11VideoProcessorOutputView* ppVPOView);
    HRESULT CreateVideoProcessorEnumerator(const(D3D11_VIDEO_PROCESSOR_CONTENT_DESC)* pDesc, ID3D11VideoProcessorEnumerator* ppEnum);
    uint GetVideoDecoderProfileCount();
    HRESULT GetVideoDecoderProfile(uint Index, Guid* pDecoderProfile);
    HRESULT CheckVideoDecoderFormat(const(Guid)* pDecoderProfile, DXGI_FORMAT Format, int* pSupported);
    HRESULT GetVideoDecoderConfigCount(const(D3D11_VIDEO_DECODER_DESC)* pDesc, uint* pCount);
    HRESULT GetVideoDecoderConfig(const(D3D11_VIDEO_DECODER_DESC)* pDesc, uint Index, D3D11_VIDEO_DECODER_CONFIG* pConfig);
    HRESULT GetContentProtectionCaps(const(Guid)* pCryptoType, const(Guid)* pDecoderProfile, D3D11_VIDEO_CONTENT_PROTECTION_CAPS* pCaps);
    HRESULT CheckCryptoKeyExchange(const(Guid)* pCryptoType, const(Guid)* pDecoderProfile, uint Index, Guid* pKeyExchangeType);
    HRESULT SetPrivateData(const(Guid)* guid, uint DataSize, char* pData);
    HRESULT SetPrivateDataInterface(const(Guid)* guid, const(IUnknown) pData);
}

struct D3D11_VIDEO_DECODER_SUB_SAMPLE_MAPPING_BLOCK
{
    uint ClearSize;
    uint EncryptedSize;
}

struct D3D11_VIDEO_DECODER_BUFFER_DESC1
{
    D3D11_VIDEO_DECODER_BUFFER_TYPE BufferType;
    uint DataOffset;
    uint DataSize;
    void* pIV;
    uint IVSize;
    D3D11_VIDEO_DECODER_SUB_SAMPLE_MAPPING_BLOCK* pSubSampleMappingBlock;
    uint SubSampleMappingCount;
}

struct D3D11_VIDEO_DECODER_BEGIN_FRAME_CRYPTO_SESSION
{
    ID3D11CryptoSession pCryptoSession;
    uint BlobSize;
    void* pBlob;
    Guid* pKeyInfoId;
    uint PrivateDataSize;
    void* pPrivateData;
}

enum D3D11_VIDEO_DECODER_CAPS
{
    D3D11_VIDEO_DECODER_CAPS_DOWNSAMPLE = 1,
    D3D11_VIDEO_DECODER_CAPS_NON_REAL_TIME = 2,
    D3D11_VIDEO_DECODER_CAPS_DOWNSAMPLE_DYNAMIC = 4,
    D3D11_VIDEO_DECODER_CAPS_DOWNSAMPLE_REQUIRED = 8,
    D3D11_VIDEO_DECODER_CAPS_UNSUPPORTED = 16,
}

enum D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINTS
{
    D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_MULTIPLANE_OVERLAY_ROTATION = 1,
    D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_MULTIPLANE_OVERLAY_RESIZE = 2,
    D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_MULTIPLANE_OVERLAY_COLOR_SPACE_CONVERSION = 4,
    D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_TRIPLE_BUFFER_OUTPUT = 8,
}

struct D3D11_VIDEO_PROCESSOR_STREAM_BEHAVIOR_HINT
{
    BOOL Enable;
    uint Width;
    uint Height;
    DXGI_FORMAT Format;
}

enum D3D11_CRYPTO_SESSION_STATUS
{
    D3D11_CRYPTO_SESSION_STATUS_OK = 0,
    D3D11_CRYPTO_SESSION_STATUS_KEY_LOST = 1,
    D3D11_CRYPTO_SESSION_STATUS_KEY_AND_CONTENT_LOST = 2,
}

struct D3D11_KEY_EXCHANGE_HW_PROTECTION_INPUT_DATA
{
    uint PrivateDataSize;
    uint HWProtectionDataSize;
    ubyte pbInput;
}

struct D3D11_KEY_EXCHANGE_HW_PROTECTION_OUTPUT_DATA
{
    uint PrivateDataSize;
    uint MaxHWProtectionDataSize;
    uint HWProtectionDataSize;
    ulong TransportTime;
    ulong ExecutionTime;
    ubyte pbOutput;
}

struct D3D11_KEY_EXCHANGE_HW_PROTECTION_DATA
{
    uint HWProtectionFunctionID;
    D3D11_KEY_EXCHANGE_HW_PROTECTION_INPUT_DATA* pInputData;
    D3D11_KEY_EXCHANGE_HW_PROTECTION_OUTPUT_DATA* pOutputData;
    HRESULT Status;
}

struct D3D11_VIDEO_SAMPLE_DESC
{
    uint Width;
    uint Height;
    DXGI_FORMAT Format;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
}

const GUID IID_ID3D11VideoContext1 = {0xA7F026DA, 0xA5F8, 0x4487, [0xA5, 0x64, 0x15, 0xE3, 0x43, 0x57, 0x65, 0x1E]};
@GUID(0xA7F026DA, 0xA5F8, 0x4487, [0xA5, 0x64, 0x15, 0xE3, 0x43, 0x57, 0x65, 0x1E]);
interface ID3D11VideoContext1 : ID3D11VideoContext
{
    HRESULT SubmitDecoderBuffers1(ID3D11VideoDecoder pDecoder, uint NumBuffers, char* pBufferDesc);
    HRESULT GetDataForNewHardwareKey(ID3D11CryptoSession pCryptoSession, uint PrivateInputSize, char* pPrivatInputData, ulong* pPrivateOutputData);
    HRESULT CheckCryptoSessionStatus(ID3D11CryptoSession pCryptoSession, D3D11_CRYPTO_SESSION_STATUS* pStatus);
    HRESULT DecoderEnableDownsampling(ID3D11VideoDecoder pDecoder, DXGI_COLOR_SPACE_TYPE InputColorSpace, const(D3D11_VIDEO_SAMPLE_DESC)* pOutputDesc, uint ReferenceFrameCount);
    HRESULT DecoderUpdateDownsampling(ID3D11VideoDecoder pDecoder, const(D3D11_VIDEO_SAMPLE_DESC)* pOutputDesc);
    void VideoProcessorSetOutputColorSpace1(ID3D11VideoProcessor pVideoProcessor, DXGI_COLOR_SPACE_TYPE ColorSpace);
    void VideoProcessorSetOutputShaderUsage(ID3D11VideoProcessor pVideoProcessor, BOOL ShaderUsage);
    void VideoProcessorGetOutputColorSpace1(ID3D11VideoProcessor pVideoProcessor, DXGI_COLOR_SPACE_TYPE* pColorSpace);
    void VideoProcessorGetOutputShaderUsage(ID3D11VideoProcessor pVideoProcessor, int* pShaderUsage);
    void VideoProcessorSetStreamColorSpace1(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, DXGI_COLOR_SPACE_TYPE ColorSpace);
    void VideoProcessorSetStreamMirror(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, BOOL FlipHorizontal, BOOL FlipVertical);
    void VideoProcessorGetStreamColorSpace1(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, DXGI_COLOR_SPACE_TYPE* pColorSpace);
    void VideoProcessorGetStreamMirror(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnable, int* pFlipHorizontal, int* pFlipVertical);
    HRESULT VideoProcessorGetBehaviorHints(ID3D11VideoProcessor pVideoProcessor, uint OutputWidth, uint OutputHeight, DXGI_FORMAT OutputFormat, uint StreamCount, char* pStreams, uint* pBehaviorHints);
}

const GUID IID_ID3D11VideoDevice1 = {0x29DA1D51, 0x1321, 0x4454, [0x80, 0x4B, 0xF5, 0xFC, 0x9F, 0x86, 0x1F, 0x0F]};
@GUID(0x29DA1D51, 0x1321, 0x4454, [0x80, 0x4B, 0xF5, 0xFC, 0x9F, 0x86, 0x1F, 0x0F]);
interface ID3D11VideoDevice1 : ID3D11VideoDevice
{
    HRESULT GetCryptoSessionPrivateDataSize(const(Guid)* pCryptoType, const(Guid)* pDecoderProfile, const(Guid)* pKeyExchangeType, uint* pPrivateInputSize, uint* pPrivateOutputSize);
    HRESULT GetVideoDecoderCaps(const(Guid)* pDecoderProfile, uint SampleWidth, uint SampleHeight, const(DXGI_RATIONAL)* pFrameRate, uint BitRate, const(Guid)* pCryptoType, uint* pDecoderCaps);
    HRESULT CheckVideoDecoderDownsampling(const(D3D11_VIDEO_DECODER_DESC)* pInputDesc, DXGI_COLOR_SPACE_TYPE InputColorSpace, const(D3D11_VIDEO_DECODER_CONFIG)* pInputConfig, const(DXGI_RATIONAL)* pFrameRate, const(D3D11_VIDEO_SAMPLE_DESC)* pOutputDesc, int* pSupported, int* pRealTimeHint);
    HRESULT RecommendVideoDecoderDownsampleParameters(const(D3D11_VIDEO_DECODER_DESC)* pInputDesc, DXGI_COLOR_SPACE_TYPE InputColorSpace, const(D3D11_VIDEO_DECODER_CONFIG)* pInputConfig, const(DXGI_RATIONAL)* pFrameRate, D3D11_VIDEO_SAMPLE_DESC* pRecommendedOutputDesc);
}

const GUID IID_ID3D11VideoProcessorEnumerator1 = {0x465217F2, 0x5568, 0x43CF, [0xB5, 0xB9, 0xF6, 0x1D, 0x54, 0x53, 0x1C, 0xA1]};
@GUID(0x465217F2, 0x5568, 0x43CF, [0xB5, 0xB9, 0xF6, 0x1D, 0x54, 0x53, 0x1C, 0xA1]);
interface ID3D11VideoProcessorEnumerator1 : ID3D11VideoProcessorEnumerator
{
    HRESULT CheckVideoProcessorFormatConversion(DXGI_FORMAT InputFormat, DXGI_COLOR_SPACE_TYPE InputColorSpace, DXGI_FORMAT OutputFormat, DXGI_COLOR_SPACE_TYPE OutputColorSpace, int* pSupported);
}

const GUID IID_ID3D11VideoContext2 = {0xC4E7374C, 0x6243, 0x4D1B, [0xAE, 0x87, 0x52, 0xB4, 0xF7, 0x40, 0xE2, 0x61]};
@GUID(0xC4E7374C, 0x6243, 0x4D1B, [0xAE, 0x87, 0x52, 0xB4, 0xF7, 0x40, 0xE2, 0x61]);
interface ID3D11VideoContext2 : ID3D11VideoContext1
{
    void VideoProcessorSetOutputHDRMetaData(ID3D11VideoProcessor pVideoProcessor, DXGI_HDR_METADATA_TYPE Type, uint Size, char* pHDRMetaData);
    void VideoProcessorGetOutputHDRMetaData(ID3D11VideoProcessor pVideoProcessor, DXGI_HDR_METADATA_TYPE* pType, uint Size, char* pMetaData);
    void VideoProcessorSetStreamHDRMetaData(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, DXGI_HDR_METADATA_TYPE Type, uint Size, char* pHDRMetaData);
    void VideoProcessorGetStreamHDRMetaData(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, DXGI_HDR_METADATA_TYPE* pType, uint Size, char* pMetaData);
}

enum D3D11_FEATURE_VIDEO
{
    D3D11_FEATURE_VIDEO_DECODER_HISTOGRAM = 0,
}

struct D3DOVERLAYCAPS
{
    uint Caps;
    uint MaxOverlayDisplayWidth;
    uint MaxOverlayDisplayHeight;
}

struct D3DCONTENTPROTECTIONCAPS
{
    uint Caps;
    Guid KeyExchangeType;
    uint BufferAlignmentStart;
    uint BlockAlignmentSize;
    ulong ProtectedMemorySize;
}

const GUID IID_IDirect3D9ExOverlayExtension = {0x187AEB13, 0xAAF5, 0x4C59, [0x87, 0x6D, 0xE0, 0x59, 0x08, 0x8C, 0x0D, 0xF8]};
@GUID(0x187AEB13, 0xAAF5, 0x4C59, [0x87, 0x6D, 0xE0, 0x59, 0x08, 0x8C, 0x0D, 0xF8]);
interface IDirect3D9ExOverlayExtension : IUnknown
{
    HRESULT CheckDeviceOverlayType(uint Adapter, D3DDEVTYPE DevType, uint OverlayWidth, uint OverlayHeight, D3DFORMAT OverlayFormat, D3DDISPLAYMODEEX* pDisplayMode, D3DDISPLAYROTATION DisplayRotation, D3DOVERLAYCAPS* pOverlayCaps);
}

const GUID IID_IDirect3DDevice9Video = {0x26DC4561, 0xA1EE, 0x4AE7, [0x96, 0xDA, 0x11, 0x8A, 0x36, 0xC0, 0xEC, 0x95]};
@GUID(0x26DC4561, 0xA1EE, 0x4AE7, [0x96, 0xDA, 0x11, 0x8A, 0x36, 0xC0, 0xEC, 0x95]);
interface IDirect3DDevice9Video : IUnknown
{
    HRESULT GetContentProtectionCaps(const(Guid)* pCryptoType, const(Guid)* pDecodeProfile, D3DCONTENTPROTECTIONCAPS* pCaps);
    HRESULT CreateAuthenticatedChannel(D3DAUTHENTICATEDCHANNELTYPE ChannelType, IDirect3DAuthenticatedChannel9* ppAuthenticatedChannel, HANDLE* pChannelHandle);
    HRESULT CreateCryptoSession(const(Guid)* pCryptoType, const(Guid)* pDecodeProfile, IDirect3DCryptoSession9* ppCryptoSession, HANDLE* pCryptoHandle);
}

const GUID IID_IDirect3DAuthenticatedChannel9 = {0xFF24BEEE, 0xDA21, 0x4BEB, [0x98, 0xB5, 0xD2, 0xF8, 0x99, 0xF9, 0x8A, 0xF9]};
@GUID(0xFF24BEEE, 0xDA21, 0x4BEB, [0x98, 0xB5, 0xD2, 0xF8, 0x99, 0xF9, 0x8A, 0xF9]);
interface IDirect3DAuthenticatedChannel9 : IUnknown
{
    HRESULT GetCertificateSize(uint* pCertificateSize);
    HRESULT GetCertificate(uint CertifacteSize, ubyte* ppCertificate);
    HRESULT NegotiateKeyExchange(uint DataSize, void* pData);
    HRESULT Query(uint InputSize, const(void)* pInput, uint OutputSize, void* pOutput);
    HRESULT Configure(uint InputSize, const(void)* pInput, D3DAUTHENTICATEDCHANNEL_CONFIGURE_OUTPUT* pOutput);
}

const GUID IID_IDirect3DCryptoSession9 = {0xFA0AB799, 0x7A9C, 0x48CA, [0x8C, 0x5B, 0x23, 0x7E, 0x71, 0xA5, 0x44, 0x34]};
@GUID(0xFA0AB799, 0x7A9C, 0x48CA, [0x8C, 0x5B, 0x23, 0x7E, 0x71, 0xA5, 0x44, 0x34]);
interface IDirect3DCryptoSession9 : IUnknown
{
    HRESULT GetCertificateSize(uint* pCertificateSize);
    HRESULT GetCertificate(uint CertifacteSize, ubyte* ppCertificate);
    HRESULT NegotiateKeyExchange(uint DataSize, void* pData);
    HRESULT EncryptionBlt(IDirect3DSurface9 pSrcSurface, IDirect3DSurface9 pDstSurface, uint DstSurfaceSize, void* pIV);
    HRESULT DecryptionBlt(IDirect3DSurface9 pSrcSurface, IDirect3DSurface9 pDstSurface, uint SrcSurfaceSize, D3DENCRYPTED_BLOCK_INFO* pEncryptedBlockInfo, void* pContentKey, void* pIV);
    HRESULT GetSurfacePitch(IDirect3DSurface9 pSrcSurface, uint* pSurfacePitch);
    HRESULT StartSessionKeyRefresh(void* pRandomNumber, uint RandomNumberSize);
    HRESULT FinishSessionKeyRefresh();
    HRESULT GetEncryptionBltKey(void* pReadbackKey, uint KeySize);
}

