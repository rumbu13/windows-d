module windows.mediafoundation;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.automation : BSTR, VARIANT;
public import windows.com : HRESULT, IClassFactory, IUnknown;
public import windows.coreaudio : AudioObjectType, ISpatialAudioMetadataItems;
public import windows.direct2d : IDirect3DDevice9, IDirect3DDevice9Ex, IDirect3DSurface9;
public import windows.direct3d11 : D3D11_AUTHENTICATED_PROTECTION_FLAGS, ID3D11DeviceChild, ID3D11Resource,
                                   ID3D11Texture2D, ID3D11View;
public import windows.direct3d12 : D3D12_COMMAND_LIST_SUPPORT_FLAGS, D3D12_DISCARD_REGION, D3D12_PREDICATION_OP,
                                   D3D12_QUERY_TYPE, D3D12_RESOURCE_BARRIER, D3D12_WRITEBUFFERIMMEDIATE_MODE,
                                   D3D12_WRITEBUFFERIMMEDIATE_PARAMETER, ID3D12CommandAllocator, ID3D12CommandList,
                                   ID3D12Pageable, ID3D12ProtectedResourceSession, ID3D12QueryHeap, ID3D12Resource;
public import windows.direct3d9 : D3DAUTHENTICATEDCHANNELTYPE, D3DAUTHENTICATEDCHANNEL_CONFIGURE_OUTPUT, D3DDEVTYPE,
                                  D3DDISPLAYMODEEX, D3DDISPLAYROTATION, D3DENCRYPTED_BLOCK_INFO, D3DFORMAT, D3DPOOL;
public import windows.directshow : AM_MEDIA_TYPE, BITMAPINFOHEADER, DMO_MEDIA_TYPE, IMediaBuffer, MPEG1VIDEOINFO,
                                   MPEG2VIDEOINFO, VIDEOINFOHEADER, VIDEOINFOHEADER2;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.dxgi : DXGI_COLOR_SPACE_TYPE, DXGI_FORMAT, DXGI_HDR_METADATA_TYPE, DXGI_RATIONAL;
public import windows.gdi : HDC;
public import windows.kernel : LUID;
public import windows.multimedia : WAVEFORMATEX;
public import windows.shell : INamedPropertyStore;
public import windows.streamingmedia : IMFDeviceTransform;
public import windows.structuredstorage : IStream, PROPVARIANT;
public import windows.systemservices : BOOL, HANDLE;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    MF_Plugin_Type_MFT                 = 0x00000000,
    MF_Plugin_Type_MediaSource         = 0x00000001,
    MF_Plugin_Type_MFT_MatchOutputType = 0x00000002,
    MF_Plugin_Type_Other               = 0xffffffff,
}
alias MF_Plugin_Type = int;

enum : int
{
    D3D12_VIDEO_FIELD_TYPE_NONE                          = 0x00000000,
    D3D12_VIDEO_FIELD_TYPE_INTERLACED_TOP_FIELD_FIRST    = 0x00000001,
    D3D12_VIDEO_FIELD_TYPE_INTERLACED_BOTTOM_FIELD_FIRST = 0x00000002,
}
alias D3D12_VIDEO_FIELD_TYPE = int;

enum : int
{
    D3D12_VIDEO_FRAME_STEREO_FORMAT_NONE       = 0x00000000,
    D3D12_VIDEO_FRAME_STEREO_FORMAT_MONO       = 0x00000001,
    D3D12_VIDEO_FRAME_STEREO_FORMAT_HORIZONTAL = 0x00000002,
    D3D12_VIDEO_FRAME_STEREO_FORMAT_VERTICAL   = 0x00000003,
    D3D12_VIDEO_FRAME_STEREO_FORMAT_SEPARATE   = 0x00000004,
}
alias D3D12_VIDEO_FRAME_STEREO_FORMAT = int;

enum : int
{
    D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE_NONE        = 0x00000000,
    D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE_FIELD_BASED = 0x00000001,
}
alias D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE = int;

enum : int
{
    D3D12_FEATURE_VIDEO_DECODE_SUPPORT                       = 0x00000000,
    D3D12_FEATURE_VIDEO_DECODE_PROFILES                      = 0x00000001,
    D3D12_FEATURE_VIDEO_DECODE_FORMATS                       = 0x00000002,
    D3D12_FEATURE_VIDEO_DECODE_CONVERSION_SUPPORT            = 0x00000003,
    D3D12_FEATURE_VIDEO_PROCESS_SUPPORT                      = 0x00000005,
    D3D12_FEATURE_VIDEO_PROCESS_MAX_INPUT_STREAMS            = 0x00000006,
    D3D12_FEATURE_VIDEO_PROCESS_REFERENCE_INFO               = 0x00000007,
    D3D12_FEATURE_VIDEO_DECODER_HEAP_SIZE                    = 0x00000008,
    D3D12_FEATURE_VIDEO_PROCESSOR_SIZE                       = 0x00000009,
    D3D12_FEATURE_VIDEO_DECODE_PROFILE_COUNT                 = 0x0000000a,
    D3D12_FEATURE_VIDEO_DECODE_FORMAT_COUNT                  = 0x0000000b,
    D3D12_FEATURE_VIDEO_ARCHITECTURE                         = 0x00000011,
    D3D12_FEATURE_VIDEO_DECODE_HISTOGRAM                     = 0x00000012,
    D3D12_FEATURE_VIDEO_FEATURE_AREA_SUPPORT                 = 0x00000013,
    D3D12_FEATURE_VIDEO_MOTION_ESTIMATOR                     = 0x00000014,
    D3D12_FEATURE_VIDEO_MOTION_ESTIMATOR_SIZE                = 0x00000015,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_COUNT              = 0x00000016,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMANDS                   = 0x00000017,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_PARAMETER_COUNT    = 0x00000018,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_PARAMETERS         = 0x00000019,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_SUPPORT            = 0x0000001a,
    D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_SIZE               = 0x0000001b,
    D3D12_FEATURE_VIDEO_DECODE_PROTECTED_RESOURCES           = 0x0000001c,
    D3D12_FEATURE_VIDEO_PROCESS_PROTECTED_RESOURCES          = 0x0000001d,
    D3D12_FEATURE_VIDEO_MOTION_ESTIMATOR_PROTECTED_RESOURCES = 0x0000001e,
    D3D12_FEATURE_VIDEO_DECODER_HEAP_SIZE1                   = 0x0000001f,
    D3D12_FEATURE_VIDEO_PROCESSOR_SIZE1                      = 0x00000020,
}
alias D3D12_FEATURE_VIDEO = int;

enum : int
{
    D3D12_BITSTREAM_ENCRYPTION_TYPE_NONE = 0x00000000,
}
alias D3D12_BITSTREAM_ENCRYPTION_TYPE = int;

enum : int
{
    D3D12_VIDEO_PROCESS_FILTER_BRIGHTNESS         = 0x00000000,
    D3D12_VIDEO_PROCESS_FILTER_CONTRAST           = 0x00000001,
    D3D12_VIDEO_PROCESS_FILTER_HUE                = 0x00000002,
    D3D12_VIDEO_PROCESS_FILTER_SATURATION         = 0x00000003,
    D3D12_VIDEO_PROCESS_FILTER_NOISE_REDUCTION    = 0x00000004,
    D3D12_VIDEO_PROCESS_FILTER_EDGE_ENHANCEMENT   = 0x00000005,
    D3D12_VIDEO_PROCESS_FILTER_ANAMORPHIC_SCALING = 0x00000006,
    D3D12_VIDEO_PROCESS_FILTER_STEREO_ADJUSTMENT  = 0x00000007,
}
alias D3D12_VIDEO_PROCESS_FILTER = int;

enum : int
{
    D3D12_VIDEO_PROCESS_FILTER_FLAG_NONE               = 0x00000000,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_BRIGHTNESS         = 0x00000001,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_CONTRAST           = 0x00000002,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_HUE                = 0x00000004,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_SATURATION         = 0x00000008,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_NOISE_REDUCTION    = 0x00000010,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_EDGE_ENHANCEMENT   = 0x00000020,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_ANAMORPHIC_SCALING = 0x00000040,
    D3D12_VIDEO_PROCESS_FILTER_FLAG_STEREO_ADJUSTMENT  = 0x00000080,
}
alias D3D12_VIDEO_PROCESS_FILTER_FLAGS = int;

enum : int
{
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_NONE   = 0x00000000,
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_BOB    = 0x00000001,
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_CUSTOM = 0x80000000,
}
alias D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS = int;

enum : int
{
    D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_OPAQUE        = 0x00000000,
    D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_BACKGROUND    = 0x00000001,
    D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_DESTINATION   = 0x00000002,
    D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_SOURCE_STREAM = 0x00000003,
}
alias D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE = int;

enum : int
{
    D3D12_VIDEO_DECODE_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_VIDEO_DECODE_TIER_1             = 0x00000001,
    D3D12_VIDEO_DECODE_TIER_2             = 0x00000002,
    D3D12_VIDEO_DECODE_TIER_3             = 0x00000003,
}
alias D3D12_VIDEO_DECODE_TIER = int;

enum : int
{
    D3D12_VIDEO_DECODE_SUPPORT_FLAG_NONE      = 0x00000000,
    D3D12_VIDEO_DECODE_SUPPORT_FLAG_SUPPORTED = 0x00000001,
}
alias D3D12_VIDEO_DECODE_SUPPORT_FLAGS = int;

enum : int
{
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_NONE                                     = 0x00000000,
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_HEIGHT_ALIGNMENT_MULTIPLE_32_REQUIRED    = 0x00000001,
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_POST_PROCESSING_SUPPORTED                = 0x00000002,
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_REFERENCE_ONLY_ALLOCATIONS_REQUIRED      = 0x00000004,
    D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_ALLOW_RESOLUTION_CHANGE_ON_NON_KEY_FRAME = 0x00000008,
}
alias D3D12_VIDEO_DECODE_CONFIGURATION_FLAGS = int;

enum : int
{
    D3D12_VIDEO_DECODE_STATUS_OK                    = 0x00000000,
    D3D12_VIDEO_DECODE_STATUS_CONTINUE              = 0x00000001,
    D3D12_VIDEO_DECODE_STATUS_CONTINUE_SKIP_DISPLAY = 0x00000002,
    D3D12_VIDEO_DECODE_STATUS_RESTART               = 0x00000003,
    D3D12_VIDEO_DECODE_STATUS_RATE_EXCEEDED         = 0x00000004,
}
alias D3D12_VIDEO_DECODE_STATUS = int;

enum : int
{
    D3D12_VIDEO_DECODE_ARGUMENT_TYPE_PICTURE_PARAMETERS          = 0x00000000,
    D3D12_VIDEO_DECODE_ARGUMENT_TYPE_INVERSE_QUANTIZATION_MATRIX = 0x00000001,
    D3D12_VIDEO_DECODE_ARGUMENT_TYPE_SLICE_CONTROL               = 0x00000002,
    D3D12_VIDEO_DECODE_ARGUMENT_TYPE_MAX_VALID                   = 0x00000003,
}
alias D3D12_VIDEO_DECODE_ARGUMENT_TYPE = int;

enum : int
{
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_Y = 0x00000000,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_U = 0x00000001,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_V = 0x00000002,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_R = 0x00000000,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_G = 0x00000001,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_B = 0x00000002,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_A = 0x00000003,
}
alias D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT = int;

enum : int
{
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_NONE = 0x00000000,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_Y    = 0x00000001,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_U    = 0x00000002,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_V    = 0x00000004,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_R    = 0x00000001,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_G    = 0x00000002,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_B    = 0x00000004,
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_A    = 0x00000008,
}
alias D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAGS = int;

enum : int
{
    D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAG_NONE      = 0x00000000,
    D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAG_SUPPORTED = 0x00000001,
}
alias D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAGS = int;

enum : int
{
    D3D12_VIDEO_SCALE_SUPPORT_FLAG_NONE                 = 0x00000000,
    D3D12_VIDEO_SCALE_SUPPORT_FLAG_POW2_ONLY            = 0x00000001,
    D3D12_VIDEO_SCALE_SUPPORT_FLAG_EVEN_DIMENSIONS_ONLY = 0x00000002,
}
alias D3D12_VIDEO_SCALE_SUPPORT_FLAGS = int;

enum : int
{
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_NONE               = 0x00000000,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_ALPHA_FILL         = 0x00000001,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_LUMA_KEY           = 0x00000002,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_STEREO             = 0x00000004,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_ROTATION           = 0x00000008,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_FLIP               = 0x00000010,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_ALPHA_BLENDING     = 0x00000020,
    D3D12_VIDEO_PROCESS_FEATURE_FLAG_PIXEL_ASPECT_RATIO = 0x00000040,
}
alias D3D12_VIDEO_PROCESS_FEATURE_FLAGS = int;

enum : int
{
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_NONE                = 0x00000000,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_DENOISE             = 0x00000001,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_DERINGING           = 0x00000002,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_EDGE_ENHANCEMENT    = 0x00000004,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_COLOR_CORRECTION    = 0x00000008,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_FLESH_TONE_MAPPING  = 0x00000010,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_IMAGE_STABILIZATION = 0x00000020,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_SUPER_RESOLUTION    = 0x00000040,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_ANAMORPHIC_SCALING  = 0x00000080,
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_CUSTOM              = 0x80000000,
}
alias D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAGS = int;

enum : int
{
    D3D12_VIDEO_PROCESS_ORIENTATION_DEFAULT                       = 0x00000000,
    D3D12_VIDEO_PROCESS_ORIENTATION_FLIP_HORIZONTAL               = 0x00000001,
    D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_90                  = 0x00000002,
    D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_90_FLIP_HORIZONTAL  = 0x00000003,
    D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_180                 = 0x00000004,
    D3D12_VIDEO_PROCESS_ORIENTATION_FLIP_VERTICAL                 = 0x00000005,
    D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_270                 = 0x00000006,
    D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_270_FLIP_HORIZONTAL = 0x00000007,
}
alias D3D12_VIDEO_PROCESS_ORIENTATION = int;

enum : int
{
    D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_NONE                = 0x00000000,
    D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_FRAME_DISCONTINUITY = 0x00000001,
    D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_FRAME_REPEAT        = 0x00000002,
}
alias D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS = int;

enum : int
{
    D3D12_VIDEO_PROCESS_SUPPORT_FLAG_NONE      = 0x00000000,
    D3D12_VIDEO_PROCESS_SUPPORT_FLAG_SUPPORTED = 0x00000001,
}
alias D3D12_VIDEO_PROCESS_SUPPORT_FLAGS = int;

enum : int
{
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_8X8   = 0x00000000,
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_16X16 = 0x00000001,
}
alias D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE = int;

enum : int
{
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAG_NONE  = 0x00000000,
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAG_8X8   = 0x00000001,
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAG_16X16 = 0x00000002,
}
alias D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAGS = int;

enum : int
{
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_QUARTER_PEL = 0x00000000,
}
alias D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION = int;

enum : int
{
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAG_NONE        = 0x00000000,
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAG_QUARTER_PEL = 0x00000001,
}
alias D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAGS = int;

enum : int
{
    D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAG_NONE      = 0x00000000,
    D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAG_SUPPORTED = 0x00000001,
}
alias D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAGS = int;

enum : int
{
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_CREATION              = 0x00000000,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_INITIALIZATION        = 0x00000001,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_EXECUTION             = 0x00000002,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_CAPS_INPUT            = 0x00000003,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_CAPS_OUTPUT           = 0x00000004,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_DEVICE_EXECUTE_INPUT  = 0x00000005,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_DEVICE_EXECUTE_OUTPUT = 0x00000006,
}
alias D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE = int;

enum : int
{
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT8    = 0x00000000,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT16   = 0x00000001,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT32   = 0x00000002,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT64   = 0x00000003,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT8    = 0x00000004,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT16   = 0x00000005,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT32   = 0x00000006,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT64   = 0x00000007,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_FLOAT    = 0x00000008,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_DOUBLE   = 0x00000009,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_RESOURCE = 0x0000000a,
}
alias D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE = int;

enum : int
{
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAG_NONE  = 0x00000000,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAG_READ  = 0x00000001,
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAG_WRITE = 0x00000002,
}
alias D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAGS = int;

enum : int
{
    DMO_INPUT_DATA_BUFFERF_SYNCPOINT     = 0x00000001,
    DMO_INPUT_DATA_BUFFERF_TIME          = 0x00000002,
    DMO_INPUT_DATA_BUFFERF_TIMELENGTH    = 0x00000004,
    DMO_INPUT_DATA_BUFFERF_DISCONTINUITY = 0x00000008,
}
alias _DMO_INPUT_DATA_BUFFER_FLAGS = int;

enum : int
{
    DMO_OUTPUT_DATA_BUFFERF_SYNCPOINT     = 0x00000001,
    DMO_OUTPUT_DATA_BUFFERF_TIME          = 0x00000002,
    DMO_OUTPUT_DATA_BUFFERF_TIMELENGTH    = 0x00000004,
    DMO_OUTPUT_DATA_BUFFERF_DISCONTINUITY = 0x00000008,
    DMO_OUTPUT_DATA_BUFFERF_INCOMPLETE    = 0x01000000,
}
alias _DMO_OUTPUT_DATA_BUFFER_FLAGS = int;

enum : int
{
    DMO_INPUT_STATUSF_ACCEPT_DATA = 0x00000001,
}
alias _DMO_INPUT_STATUS_FLAGS = int;

enum : int
{
    DMO_INPUT_STREAMF_WHOLE_SAMPLES            = 0x00000001,
    DMO_INPUT_STREAMF_SINGLE_SAMPLE_PER_BUFFER = 0x00000002,
    DMO_INPUT_STREAMF_FIXED_SAMPLE_SIZE        = 0x00000004,
    DMO_INPUT_STREAMF_HOLDS_BUFFERS            = 0x00000008,
}
alias _DMO_INPUT_STREAM_INFO_FLAGS = int;

enum : int
{
    DMO_OUTPUT_STREAMF_WHOLE_SAMPLES            = 0x00000001,
    DMO_OUTPUT_STREAMF_SINGLE_SAMPLE_PER_BUFFER = 0x00000002,
    DMO_OUTPUT_STREAMF_FIXED_SAMPLE_SIZE        = 0x00000004,
    DMO_OUTPUT_STREAMF_DISCARDABLE              = 0x00000008,
    DMO_OUTPUT_STREAMF_OPTIONAL                 = 0x00000010,
}
alias _DMO_OUTPUT_STREAM_INFO_FLAGS = int;

enum : int
{
    DMO_SET_TYPEF_TEST_ONLY = 0x00000001,
    DMO_SET_TYPEF_CLEAR     = 0x00000002,
}
alias _DMO_SET_TYPE_FLAGS = int;

enum : int
{
    DMO_PROCESS_OUTPUT_DISCARD_WHEN_NO_BUFFER = 0x00000001,
}
alias _DMO_PROCESS_OUTPUT_FLAGS = int;

enum : int
{
    DMO_INPLACE_NORMAL = 0x00000000,
    DMO_INPLACE_ZERO   = 0x00000001,
}
alias _DMO_INPLACE_PROCESS_FLAGS = int;

enum : int
{
    DMO_QUALITY_STATUS_ENABLED = 0x00000001,
}
alias _DMO_QUALITY_STATUS_FLAGS = int;

enum : int
{
    DMO_VOSF_NEEDS_PREVIOUS_SAMPLE = 0x00000001,
}
alias _DMO_VIDEO_OUTPUT_STREAM_FLAGS = int;

enum : int
{
    WMT_PROP_TYPE_DWORD  = 0x00000000,
    WMT_PROP_TYPE_STRING = 0x00000001,
    WMT_PROP_TYPE_BINARY = 0x00000002,
    WMT_PROP_TYPE_BOOL   = 0x00000003,
    WMT_PROP_TYPE_QWORD  = 0x00000004,
    WMT_PROP_TYPE_WORD   = 0x00000005,
    WMT_PROP_TYPE_GUID   = 0x00000006,
}
alias WMT_PROP_DATATYPE = int;

enum : int
{
    WMV_DYNAMIC_BITRATE    = 0x00000001,
    WMV_DYNAMIC_RESOLUTION = 0x00000002,
    WMV_DYNAMIC_COMPLEXITY = 0x00000004,
}
alias WMV_DYNAMIC_FLAGS = int;

enum : int
{
    VRHP_SMALLROOM      = 0x00000000,
    VRHP_MEDIUMROOM     = 0x00000001,
    VRHP_BIGROOM        = 0x00000002,
    VRHP_CUSTUMIZEDROOM = 0x00000003,
}
alias MF_AUVRHP_ROOMMODEL = int;

enum : int
{
    SINGLE_CHANNEL_AEC     = 0x00000000,
    ADAPTIVE_ARRAY_ONLY    = 0x00000001,
    OPTIBEAM_ARRAY_ONLY    = 0x00000002,
    ADAPTIVE_ARRAY_AND_AEC = 0x00000003,
    OPTIBEAM_ARRAY_AND_AEC = 0x00000004,
    SINGLE_CHANNEL_NSAGC   = 0x00000005,
    MODE_NOT_SET           = 0x00000006,
}
alias AEC_SYSTEM_MODE = int;

enum : int
{
    AEC_VAD_DISABLED                = 0x00000000,
    AEC_VAD_NORMAL                  = 0x00000001,
    AEC_VAD_FOR_AGC                 = 0x00000002,
    AEC_VAD_FOR_SILENCE_SUPPRESSION = 0x00000003,
}
alias AEC_VAD_MODE = int;

enum : int
{
    AEC_CAPTURE_STREAM   = 0x00000000,
    AEC_REFERENCE_STREAM = 0x00000001,
}
alias AEC_INPUT_STREAM = int;

enum : int
{
    MICARRAY_SINGLE_CHAN = 0x00000000,
    MICARRAY_SIMPLE_SUM  = 0x00000100,
    MICARRAY_SINGLE_BEAM = 0x00000200,
    MICARRAY_FIXED_BEAM  = 0x00000400,
    MICARRAY_EXTERN_BEAM = 0x00000800,
}
alias MIC_ARRAY_MODE = int;

enum : int
{
    MFVideoDSPMode_Passthrough   = 0x00000001,
    MFVideoDSPMode_Stabilization = 0x00000004,
}
alias MFVideoDSPMode = int;

enum : int
{
    TOC_POS_INHEADER       = 0x00000000,
    TOC_POS_TOPLEVELOBJECT = 0x00000001,
}
alias TOC_POS_TYPE = int;

enum : int
{
    OPENMODE_FAIL_IF_NOT_EXIST = 0x00000000,
    OPENMODE_FAIL_IF_EXIST     = 0x00000001,
    OPENMODE_RESET_IF_EXIST    = 0x00000002,
    OPENMODE_APPEND_IF_EXIST   = 0x00000003,
    OPENMODE_DELETE_IF_EXIST   = 0x00000004,
}
alias FILE_OPENMODE = int;

enum : int
{
    _msoBegin   = 0x00000000,
    _msoCurrent = 0x00000001,
}
alias SEEK_ORIGIN = int;

enum : int
{
    ACCESSMODE_READ            = 0x00000001,
    ACCESSMODE_WRITE           = 0x00000002,
    ACCESSMODE_READWRITE       = 0x00000003,
    ACCESSMODE_WRITE_EXCLUSIVE = 0x00000004,
}
alias FILE_ACCESSMODE = int;

enum : int
{
    DXVA_SampleFormatMask                = 0x000000ff,
    DXVA_SampleUnknown                   = 0x00000000,
    DXVA_SamplePreviousFrame             = 0x00000001,
    DXVA_SampleProgressiveFrame          = 0x00000002,
    DXVA_SampleFieldInterleavedEvenFirst = 0x00000003,
    DXVA_SampleFieldInterleavedOddFirst  = 0x00000004,
    DXVA_SampleFieldSingleEven           = 0x00000005,
    DXVA_SampleFieldSingleOdd            = 0x00000006,
    DXVA_SampleSubStream                 = 0x00000007,
}
alias DXVA_SampleFormat = int;

enum : int
{
    DXVA_VideoTransFuncShift         = 0x0000001b,
    DXVA_VideoTransFuncMask          = 0xf8000000,
    DXVA_VideoTransFunc_Unknown      = 0x00000000,
    DXVA_VideoTransFunc_10           = 0x00000001,
    DXVA_VideoTransFunc_18           = 0x00000002,
    DXVA_VideoTransFunc_20           = 0x00000003,
    DXVA_VideoTransFunc_22           = 0x00000004,
    DXVA_VideoTransFunc_22_709       = 0x00000005,
    DXVA_VideoTransFunc_22_240M      = 0x00000006,
    DXVA_VideoTransFunc_22_8bit_sRGB = 0x00000007,
    DXVA_VideoTransFunc_28           = 0x00000008,
}
alias DXVA_VideoTransferFunction = int;

enum : int
{
    DXVA_VideoPrimariesShift          = 0x00000016,
    DXVA_VideoPrimariesMask           = 0x07c00000,
    DXVA_VideoPrimaries_Unknown       = 0x00000000,
    DXVA_VideoPrimaries_reserved      = 0x00000001,
    DXVA_VideoPrimaries_BT709         = 0x00000002,
    DXVA_VideoPrimaries_BT470_2_SysM  = 0x00000003,
    DXVA_VideoPrimaries_BT470_2_SysBG = 0x00000004,
    DXVA_VideoPrimaries_SMPTE170M     = 0x00000005,
    DXVA_VideoPrimaries_SMPTE240M     = 0x00000006,
    DXVA_VideoPrimaries_EBU3213       = 0x00000007,
    DXVA_VideoPrimaries_SMPTE_C       = 0x00000008,
}
alias DXVA_VideoPrimaries = int;

enum : int
{
    DXVA_VideoLightingShift    = 0x00000012,
    DXVA_VideoLightingMask     = 0x003c0000,
    DXVA_VideoLighting_Unknown = 0x00000000,
    DXVA_VideoLighting_bright  = 0x00000001,
    DXVA_VideoLighting_office  = 0x00000002,
    DXVA_VideoLighting_dim     = 0x00000003,
    DXVA_VideoLighting_dark    = 0x00000004,
}
alias DXVA_VideoLighting = int;

enum : int
{
    DXVA_VideoTransferMatrixShift      = 0x0000000f,
    DXVA_VideoTransferMatrixMask       = 0x00038000,
    DXVA_VideoTransferMatrix_Unknown   = 0x00000000,
    DXVA_VideoTransferMatrix_BT709     = 0x00000001,
    DXVA_VideoTransferMatrix_BT601     = 0x00000002,
    DXVA_VideoTransferMatrix_SMPTE240M = 0x00000003,
}
alias DXVA_VideoTransferMatrix = int;

enum : int
{
    DXVA_NominalRangeShift    = 0x0000000c,
    DXVA_NominalRangeMask     = 0x00007000,
    DXVA_NominalRange_Unknown = 0x00000000,
    DXVA_NominalRange_Normal  = 0x00000001,
    DXVA_NominalRange_Wide    = 0x00000002,
    DXVA_NominalRange_0_255   = 0x00000001,
    DXVA_NominalRange_16_235  = 0x00000002,
    DXVA_NominalRange_48_208  = 0x00000003,
}
alias DXVA_NominalRange = int;

enum : int
{
    DXVA_VideoChromaSubsamplingShift                           = 0x00000008,
    DXVA_VideoChromaSubsamplingMask                            = 0x00000f00,
    DXVA_VideoChromaSubsampling_Unknown                        = 0x00000000,
    DXVA_VideoChromaSubsampling_ProgressiveChroma              = 0x00000008,
    DXVA_VideoChromaSubsampling_Horizontally_Cosited           = 0x00000004,
    DXVA_VideoChromaSubsampling_Vertically_Cosited             = 0x00000002,
    DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes = 0x00000001,
    DXVA_VideoChromaSubsampling_MPEG2                          = 0x00000005,
    DXVA_VideoChromaSubsampling_MPEG1                          = 0x00000001,
    DXVA_VideoChromaSubsampling_DV_PAL                         = 0x00000006,
    DXVA_VideoChromaSubsampling_Cosited                        = 0x00000007,
}
alias DXVA_VideoChromaSubsampling = int;

enum : int
{
    DXVA_VideoProcess_None               = 0x00000000,
    DXVA_VideoProcess_YUV2RGB            = 0x00000001,
    DXVA_VideoProcess_StretchX           = 0x00000002,
    DXVA_VideoProcess_StretchY           = 0x00000004,
    DXVA_VideoProcess_AlphaBlend         = 0x00000008,
    DXVA_VideoProcess_SubRects           = 0x00000010,
    DXVA_VideoProcess_SubStreams         = 0x00000020,
    DXVA_VideoProcess_SubStreamsExtended = 0x00000040,
    DXVA_VideoProcess_YUV2RGBExtended    = 0x00000080,
    DXVA_VideoProcess_AlphaBlendExtended = 0x00000100,
}
alias DXVA_VideoProcessCaps = int;

enum : int
{
    DXVA_DeinterlaceTech_Unknown                = 0x00000000,
    DXVA_DeinterlaceTech_BOBLineReplicate       = 0x00000001,
    DXVA_DeinterlaceTech_BOBVerticalStretch     = 0x00000002,
    DXVA_DeinterlaceTech_BOBVerticalStretch4Tap = 0x00000100,
    DXVA_DeinterlaceTech_MedianFiltering        = 0x00000004,
    DXVA_DeinterlaceTech_EdgeFiltering          = 0x00000010,
    DXVA_DeinterlaceTech_FieldAdaptive          = 0x00000020,
    DXVA_DeinterlaceTech_PixelAdaptive          = 0x00000040,
    DXVA_DeinterlaceTech_MotionVectorSteered    = 0x00000080,
}
alias DXVA_DeinterlaceTech = int;

enum : int
{
    DXVA_SampleFlagsMask              = 0x0000000f,
    DXVA_SampleFlag_Palette_Changed   = 0x00000001,
    DXVA_SampleFlag_SrcRect_Changed   = 0x00000002,
    DXVA_SampleFlag_DstRect_Changed   = 0x00000004,
    DXVA_SampleFlag_ColorData_Changed = 0x00000008,
}
alias DXVA_SampleFlags = int;

enum : int
{
    DXVA_DestinationFlagMask                = 0x0000000f,
    DXVA_DestinationFlag_Background_Changed = 0x00000001,
    DXVA_DestinationFlag_TargetRect_Changed = 0x00000002,
    DXVA_DestinationFlag_ColorData_Changed  = 0x00000004,
    DXVA_DestinationFlag_Alpha_Changed      = 0x00000008,
}
alias DXVA_DestinationFlags = int;

enum : int
{
    DXVA_ProcAmp_None       = 0x00000000,
    DXVA_ProcAmp_Brightness = 0x00000001,
    DXVA_ProcAmp_Contrast   = 0x00000002,
    DXVA_ProcAmp_Hue        = 0x00000004,
    DXVA_ProcAmp_Saturation = 0x00000008,
}
alias DXVA_ProcAmpControlProp = int;

enum : int
{
    DXVAHD_FRAME_FORMAT_PROGRESSIVE                   = 0x00000000,
    DXVAHD_FRAME_FORMAT_INTERLACED_TOP_FIELD_FIRST    = 0x00000001,
    DXVAHD_FRAME_FORMAT_INTERLACED_BOTTOM_FIELD_FIRST = 0x00000002,
}
alias DXVAHD_FRAME_FORMAT = int;

enum : int
{
    DXVAHD_DEVICE_USAGE_PLAYBACK_NORMAL = 0x00000000,
    DXVAHD_DEVICE_USAGE_OPTIMAL_SPEED   = 0x00000001,
    DXVAHD_DEVICE_USAGE_OPTIMAL_QUALITY = 0x00000002,
}
alias DXVAHD_DEVICE_USAGE = int;

enum : int
{
    DXVAHD_SURFACE_TYPE_VIDEO_INPUT         = 0x00000000,
    DXVAHD_SURFACE_TYPE_VIDEO_INPUT_PRIVATE = 0x00000001,
    DXVAHD_SURFACE_TYPE_VIDEO_OUTPUT        = 0x00000002,
}
alias DXVAHD_SURFACE_TYPE = int;

enum : int
{
    DXVAHD_DEVICE_TYPE_HARDWARE  = 0x00000000,
    DXVAHD_DEVICE_TYPE_SOFTWARE  = 0x00000001,
    DXVAHD_DEVICE_TYPE_REFERENCE = 0x00000002,
    DXVAHD_DEVICE_TYPE_OTHER     = 0x00000003,
}
alias DXVAHD_DEVICE_TYPE = int;

enum : int
{
    DXVAHD_DEVICE_CAPS_LINEAR_SPACE            = 0x00000001,
    DXVAHD_DEVICE_CAPS_xvYCC                   = 0x00000002,
    DXVAHD_DEVICE_CAPS_RGB_RANGE_CONVERSION    = 0x00000004,
    DXVAHD_DEVICE_CAPS_YCbCr_MATRIX_CONVERSION = 0x00000008,
}
alias DXVAHD_DEVICE_CAPS = int;

enum : int
{
    DXVAHD_FEATURE_CAPS_ALPHA_FILL    = 0x00000001,
    DXVAHD_FEATURE_CAPS_CONSTRICTION  = 0x00000002,
    DXVAHD_FEATURE_CAPS_LUMA_KEY      = 0x00000004,
    DXVAHD_FEATURE_CAPS_ALPHA_PALETTE = 0x00000008,
}
alias DXVAHD_FEATURE_CAPS = int;

enum : int
{
    DXVAHD_FILTER_CAPS_BRIGHTNESS         = 0x00000001,
    DXVAHD_FILTER_CAPS_CONTRAST           = 0x00000002,
    DXVAHD_FILTER_CAPS_HUE                = 0x00000004,
    DXVAHD_FILTER_CAPS_SATURATION         = 0x00000008,
    DXVAHD_FILTER_CAPS_NOISE_REDUCTION    = 0x00000010,
    DXVAHD_FILTER_CAPS_EDGE_ENHANCEMENT   = 0x00000020,
    DXVAHD_FILTER_CAPS_ANAMORPHIC_SCALING = 0x00000040,
}
alias DXVAHD_FILTER_CAPS = int;

enum : int
{
    DXVAHD_INPUT_FORMAT_CAPS_RGB_INTERLACED     = 0x00000001,
    DXVAHD_INPUT_FORMAT_CAPS_RGB_PROCAMP        = 0x00000002,
    DXVAHD_INPUT_FORMAT_CAPS_RGB_LUMA_KEY       = 0x00000004,
    DXVAHD_INPUT_FORMAT_CAPS_PALETTE_INTERLACED = 0x00000008,
}
alias DXVAHD_INPUT_FORMAT_CAPS = int;

enum : int
{
    DXVAHD_PROCESSOR_CAPS_DEINTERLACE_BLEND               = 0x00000001,
    DXVAHD_PROCESSOR_CAPS_DEINTERLACE_BOB                 = 0x00000002,
    DXVAHD_PROCESSOR_CAPS_DEINTERLACE_ADAPTIVE            = 0x00000004,
    DXVAHD_PROCESSOR_CAPS_DEINTERLACE_MOTION_COMPENSATION = 0x00000008,
    DXVAHD_PROCESSOR_CAPS_INVERSE_TELECINE                = 0x00000010,
    DXVAHD_PROCESSOR_CAPS_FRAME_RATE_CONVERSION           = 0x00000020,
}
alias DXVAHD_PROCESSOR_CAPS = int;

enum : int
{
    DXVAHD_ITELECINE_CAPS_32           = 0x00000001,
    DXVAHD_ITELECINE_CAPS_22           = 0x00000002,
    DXVAHD_ITELECINE_CAPS_2224         = 0x00000004,
    DXVAHD_ITELECINE_CAPS_2332         = 0x00000008,
    DXVAHD_ITELECINE_CAPS_32322        = 0x00000010,
    DXVAHD_ITELECINE_CAPS_55           = 0x00000020,
    DXVAHD_ITELECINE_CAPS_64           = 0x00000040,
    DXVAHD_ITELECINE_CAPS_87           = 0x00000080,
    DXVAHD_ITELECINE_CAPS_222222222223 = 0x00000100,
    DXVAHD_ITELECINE_CAPS_OTHER        = 0x80000000,
}
alias DXVAHD_ITELECINE_CAPS = int;

enum : int
{
    DXVAHD_FILTER_BRIGHTNESS         = 0x00000000,
    DXVAHD_FILTER_CONTRAST           = 0x00000001,
    DXVAHD_FILTER_HUE                = 0x00000002,
    DXVAHD_FILTER_SATURATION         = 0x00000003,
    DXVAHD_FILTER_NOISE_REDUCTION    = 0x00000004,
    DXVAHD_FILTER_EDGE_ENHANCEMENT   = 0x00000005,
    DXVAHD_FILTER_ANAMORPHIC_SCALING = 0x00000006,
}
alias DXVAHD_FILTER = int;

enum : int
{
    DXVAHD_BLT_STATE_TARGET_RECT        = 0x00000000,
    DXVAHD_BLT_STATE_BACKGROUND_COLOR   = 0x00000001,
    DXVAHD_BLT_STATE_OUTPUT_COLOR_SPACE = 0x00000002,
    DXVAHD_BLT_STATE_ALPHA_FILL         = 0x00000003,
    DXVAHD_BLT_STATE_CONSTRICTION       = 0x00000004,
    DXVAHD_BLT_STATE_PRIVATE            = 0x000003e8,
}
alias DXVAHD_BLT_STATE = int;

enum : int
{
    DXVAHD_ALPHA_FILL_MODE_OPAQUE        = 0x00000000,
    DXVAHD_ALPHA_FILL_MODE_BACKGROUND    = 0x00000001,
    DXVAHD_ALPHA_FILL_MODE_DESTINATION   = 0x00000002,
    DXVAHD_ALPHA_FILL_MODE_SOURCE_STREAM = 0x00000003,
}
alias DXVAHD_ALPHA_FILL_MODE = int;

enum : int
{
    DXVAHD_STREAM_STATE_D3DFORMAT                 = 0x00000000,
    DXVAHD_STREAM_STATE_FRAME_FORMAT              = 0x00000001,
    DXVAHD_STREAM_STATE_INPUT_COLOR_SPACE         = 0x00000002,
    DXVAHD_STREAM_STATE_OUTPUT_RATE               = 0x00000003,
    DXVAHD_STREAM_STATE_SOURCE_RECT               = 0x00000004,
    DXVAHD_STREAM_STATE_DESTINATION_RECT          = 0x00000005,
    DXVAHD_STREAM_STATE_ALPHA                     = 0x00000006,
    DXVAHD_STREAM_STATE_PALETTE                   = 0x00000007,
    DXVAHD_STREAM_STATE_LUMA_KEY                  = 0x00000008,
    DXVAHD_STREAM_STATE_ASPECT_RATIO              = 0x00000009,
    DXVAHD_STREAM_STATE_FILTER_BRIGHTNESS         = 0x00000064,
    DXVAHD_STREAM_STATE_FILTER_CONTRAST           = 0x00000065,
    DXVAHD_STREAM_STATE_FILTER_HUE                = 0x00000066,
    DXVAHD_STREAM_STATE_FILTER_SATURATION         = 0x00000067,
    DXVAHD_STREAM_STATE_FILTER_NOISE_REDUCTION    = 0x00000068,
    DXVAHD_STREAM_STATE_FILTER_EDGE_ENHANCEMENT   = 0x00000069,
    DXVAHD_STREAM_STATE_FILTER_ANAMORPHIC_SCALING = 0x0000006a,
    DXVAHD_STREAM_STATE_PRIVATE                   = 0x000003e8,
}
alias DXVAHD_STREAM_STATE = int;

enum : int
{
    DXVAHD_OUTPUT_RATE_NORMAL = 0x00000000,
    DXVAHD_OUTPUT_RATE_HALF   = 0x00000001,
    DXVAHD_OUTPUT_RATE_CUSTOM = 0x00000002,
}
alias DXVAHD_OUTPUT_RATE = int;

enum : int
{
    DXVA2_SampleFormatMask                = 0x000000ff,
    DXVA2_SampleUnknown                   = 0x00000000,
    DXVA2_SampleProgressiveFrame          = 0x00000002,
    DXVA2_SampleFieldInterleavedEvenFirst = 0x00000003,
    DXVA2_SampleFieldInterleavedOddFirst  = 0x00000004,
    DXVA2_SampleFieldSingleEven           = 0x00000005,
    DXVA2_SampleFieldSingleOdd            = 0x00000006,
    DXVA2_SampleSubStream                 = 0x00000007,
}
alias DXVA2_SampleFormat = int;

enum : int
{
    DXVA2_VideoChromaSubsamplingMask                            = 0x0000000f,
    DXVA2_VideoChromaSubsampling_Unknown                        = 0x00000000,
    DXVA2_VideoChromaSubsampling_ProgressiveChroma              = 0x00000008,
    DXVA2_VideoChromaSubsampling_Horizontally_Cosited           = 0x00000004,
    DXVA2_VideoChromaSubsampling_Vertically_Cosited             = 0x00000002,
    DXVA2_VideoChromaSubsampling_Vertically_AlignedChromaPlanes = 0x00000001,
    DXVA2_VideoChromaSubsampling_MPEG2                          = 0x00000005,
    DXVA2_VideoChromaSubsampling_MPEG1                          = 0x00000001,
    DXVA2_VideoChromaSubsampling_DV_PAL                         = 0x00000006,
    DXVA2_VideoChromaSubsampling_Cosited                        = 0x00000007,
}
alias DXVA2_VideoChromaSubSampling = int;

enum : int
{
    DXVA2_NominalRangeMask     = 0x00000007,
    DXVA2_NominalRange_Unknown = 0x00000000,
    DXVA2_NominalRange_Normal  = 0x00000001,
    DXVA2_NominalRange_Wide    = 0x00000002,
    DXVA2_NominalRange_0_255   = 0x00000001,
    DXVA2_NominalRange_16_235  = 0x00000002,
    DXVA2_NominalRange_48_208  = 0x00000003,
}
alias DXVA2_NominalRange = int;

enum : int
{
    DXVA2_VideoTransferMatrixMask       = 0x00000007,
    DXVA2_VideoTransferMatrix_Unknown   = 0x00000000,
    DXVA2_VideoTransferMatrix_BT709     = 0x00000001,
    DXVA2_VideoTransferMatrix_BT601     = 0x00000002,
    DXVA2_VideoTransferMatrix_SMPTE240M = 0x00000003,
}
alias DXVA2_VideoTransferMatrix = int;

enum : int
{
    DXVA2_VideoLightingMask     = 0x0000000f,
    DXVA2_VideoLighting_Unknown = 0x00000000,
    DXVA2_VideoLighting_bright  = 0x00000001,
    DXVA2_VideoLighting_office  = 0x00000002,
    DXVA2_VideoLighting_dim     = 0x00000003,
    DXVA2_VideoLighting_dark    = 0x00000004,
}
alias DXVA2_VideoLighting = int;

enum : int
{
    DXVA2_VideoPrimariesMask           = 0x0000001f,
    DXVA2_VideoPrimaries_Unknown       = 0x00000000,
    DXVA2_VideoPrimaries_reserved      = 0x00000001,
    DXVA2_VideoPrimaries_BT709         = 0x00000002,
    DXVA2_VideoPrimaries_BT470_2_SysM  = 0x00000003,
    DXVA2_VideoPrimaries_BT470_2_SysBG = 0x00000004,
    DXVA2_VideoPrimaries_SMPTE170M     = 0x00000005,
    DXVA2_VideoPrimaries_SMPTE240M     = 0x00000006,
    DXVA2_VideoPrimaries_EBU3213       = 0x00000007,
    DXVA2_VideoPrimaries_SMPTE_C       = 0x00000008,
}
alias DXVA2_VideoPrimaries = int;

enum : int
{
    DXVA2_VideoTransFuncMask     = 0x0000001f,
    DXVA2_VideoTransFunc_Unknown = 0x00000000,
    DXVA2_VideoTransFunc_10      = 0x00000001,
    DXVA2_VideoTransFunc_18      = 0x00000002,
    DXVA2_VideoTransFunc_20      = 0x00000003,
    DXVA2_VideoTransFunc_22      = 0x00000004,
    DXVA2_VideoTransFunc_709     = 0x00000005,
    DXVA2_VideoTransFunc_240M    = 0x00000006,
    DXVA2_VideoTransFunc_sRGB    = 0x00000007,
    DXVA2_VideoTransFunc_28      = 0x00000008,
}
alias DXVA2_VideoTransferFunction = int;

enum : int
{
    DXVA2_DeinterlaceTech_Unknown                = 0x00000000,
    DXVA2_DeinterlaceTech_BOBLineReplicate       = 0x00000001,
    DXVA2_DeinterlaceTech_BOBVerticalStretch     = 0x00000002,
    DXVA2_DeinterlaceTech_BOBVerticalStretch4Tap = 0x00000004,
    DXVA2_DeinterlaceTech_MedianFiltering        = 0x00000008,
    DXVA2_DeinterlaceTech_EdgeFiltering          = 0x00000010,
    DXVA2_DeinterlaceTech_FieldAdaptive          = 0x00000020,
    DXVA2_DeinterlaceTech_PixelAdaptive          = 0x00000040,
    DXVA2_DeinterlaceTech_MotionVectorSteered    = 0x00000080,
    DXVA2_DeinterlaceTech_InverseTelecine        = 0x00000100,
    DXVA2_DeinterlaceTech_Mask                   = 0x000001ff,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0003 = int;

enum : int
{
    DXVA2_NoiseFilterLumaLevel        = 0x00000001,
    DXVA2_NoiseFilterLumaThreshold    = 0x00000002,
    DXVA2_NoiseFilterLumaRadius       = 0x00000003,
    DXVA2_NoiseFilterChromaLevel      = 0x00000004,
    DXVA2_NoiseFilterChromaThreshold  = 0x00000005,
    DXVA2_NoiseFilterChromaRadius     = 0x00000006,
    DXVA2_DetailFilterLumaLevel       = 0x00000007,
    DXVA2_DetailFilterLumaThreshold   = 0x00000008,
    DXVA2_DetailFilterLumaRadius      = 0x00000009,
    DXVA2_DetailFilterChromaLevel     = 0x0000000a,
    DXVA2_DetailFilterChromaThreshold = 0x0000000b,
    DXVA2_DetailFilterChromaRadius    = 0x0000000c,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0004 = int;

enum : int
{
    DXVA2_NoiseFilterTech_Unsupported   = 0x00000000,
    DXVA2_NoiseFilterTech_Unknown       = 0x00000001,
    DXVA2_NoiseFilterTech_Median        = 0x00000002,
    DXVA2_NoiseFilterTech_Temporal      = 0x00000004,
    DXVA2_NoiseFilterTech_BlockNoise    = 0x00000008,
    DXVA2_NoiseFilterTech_MosquitoNoise = 0x00000010,
    DXVA2_NoiseFilterTech_Mask          = 0x0000001f,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0005 = int;

enum : int
{
    DXVA2_DetailFilterTech_Unsupported = 0x00000000,
    DXVA2_DetailFilterTech_Unknown     = 0x00000001,
    DXVA2_DetailFilterTech_Edge        = 0x00000002,
    DXVA2_DetailFilterTech_Sharpening  = 0x00000004,
    DXVA2_DetailFilterTech_Mask        = 0x00000007,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0006 = int;

enum : int
{
    DXVA2_ProcAmp_None       = 0x00000000,
    DXVA2_ProcAmp_Brightness = 0x00000001,
    DXVA2_ProcAmp_Contrast   = 0x00000002,
    DXVA2_ProcAmp_Hue        = 0x00000004,
    DXVA2_ProcAmp_Saturation = 0x00000008,
    DXVA2_ProcAmp_Mask       = 0x0000000f,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0007 = int;

enum : int
{
    DXVA2_VideoProcess_None                       = 0x00000000,
    DXVA2_VideoProcess_YUV2RGB                    = 0x00000001,
    DXVA2_VideoProcess_StretchX                   = 0x00000002,
    DXVA2_VideoProcess_StretchY                   = 0x00000004,
    DXVA2_VideoProcess_AlphaBlend                 = 0x00000008,
    DXVA2_VideoProcess_SubRects                   = 0x00000010,
    DXVA2_VideoProcess_SubStreams                 = 0x00000020,
    DXVA2_VideoProcess_SubStreamsExtended         = 0x00000040,
    DXVA2_VideoProcess_YUV2RGBExtended            = 0x00000080,
    DXVA2_VideoProcess_AlphaBlendExtended         = 0x00000100,
    DXVA2_VideoProcess_Constriction               = 0x00000200,
    DXVA2_VideoProcess_NoiseFilter                = 0x00000400,
    DXVA2_VideoProcess_DetailFilter               = 0x00000800,
    DXVA2_VideoProcess_PlanarAlpha                = 0x00001000,
    DXVA2_VideoProcess_LinearScaling              = 0x00002000,
    DXVA2_VideoProcess_GammaCompensated           = 0x00004000,
    DXVA2_VideoProcess_MaintainsOriginalFieldData = 0x00008000,
    DXVA2_VideoProcess_Mask                       = 0x0000ffff,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0008 = int;

enum : int
{
    DXVA2_VPDev_HardwareDevice = 0x00000001,
    DXVA2_VPDev_EmulatedDXVA1  = 0x00000002,
    DXVA2_VPDev_SoftwareDevice = 0x00000004,
    DXVA2_VPDev_Mask           = 0x00000007,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0009 = int;

enum : int
{
    DXVA2_SampleData_RFF             = 0x00000001,
    DXVA2_SampleData_TFF             = 0x00000002,
    DXVA2_SampleData_RFF_TFF_Present = 0x00000004,
    DXVA2_SampleData_Mask            = 0x0000ffff,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0010 = int;

enum : int
{
    DXVA2_DestData_RFF             = 0x00000001,
    DXVA2_DestData_TFF             = 0x00000002,
    DXVA2_DestData_RFF_TFF_Present = 0x00000004,
    DXVA2_DestData_Mask            = 0x0000ffff,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0011 = int;

enum : int
{
    DXVA2_PictureParametersBufferType         = 0x00000000,
    DXVA2_MacroBlockControlBufferType         = 0x00000001,
    DXVA2_ResidualDifferenceBufferType        = 0x00000002,
    DXVA2_DeblockingControlBufferType         = 0x00000003,
    DXVA2_InverseQuantizationMatrixBufferType = 0x00000004,
    DXVA2_SliceControlBufferType              = 0x00000005,
    DXVA2_BitStreamDateBufferType             = 0x00000006,
    DXVA2_MotionVectorBuffer                  = 0x00000007,
    DXVA2_FilmGrainBuffer                     = 0x00000008,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0012 = int;

enum : int
{
    DXVA2_VideoDecoderRenderTarget   = 0x00000000,
    DXVA2_VideoProcessorRenderTarget = 0x00000001,
    DXVA2_VideoSoftwareRenderTarget  = 0x00000002,
}
alias __MIDL___MIDL_itf_dxva2api_0000_0000_0013 = int;

enum : int
{
    DXVA2_SurfaceType_DecoderRenderTarget    = 0x00000000,
    DXVA2_SurfaceType_ProcessorRenderTarget  = 0x00000001,
    DXVA2_SurfaceType_D3DRenderTargetTexture = 0x00000002,
}
alias DXVA2_SurfaceType = int;

enum : int
{
    OPM_OMAC_SIZE                                = 0x00000010,
    OPM_128_BIT_RANDOM_NUMBER_SIZE               = 0x00000010,
    OPM_ENCRYPTED_INITIALIZATION_PARAMETERS_SIZE = 0x00000100,
    OPM_CONFIGURE_SETTING_DATA_SIZE              = 0x00000fd8,
    OPM_GET_INFORMATION_PARAMETERS_SIZE          = 0x00000fd8,
    OPM_REQUESTED_INFORMATION_SIZE               = 0x00000fec,
    OPM_HDCP_KEY_SELECTION_VECTOR_SIZE           = 0x00000005,
    OPM_PROTECTION_TYPE_SIZE                     = 0x00000004,
    OPM_BUS_TYPE_MASK                            = 0x0000ffff,
    OPM_BUS_IMPLEMENTATION_MODIFIER_MASK         = 0x00007fff,
}
alias __MIDL___MIDL_itf_opmapi_0000_0000_0001 = int;

enum : int
{
    OPM_VOS_COPP_SEMANTICS       = 0x00000000,
    OPM_VOS_OPM_SEMANTICS        = 0x00000001,
    OPM_VOS_OPM_INDIRECT_DISPLAY = 0x00000002,
}
alias OPM_VIDEO_OUTPUT_SEMANTICS = int;

enum : int
{
    OPM_HDCP_FLAG_NONE     = 0x00000000,
    OPM_HDCP_FLAG_REPEATER = 0x00000001,
}
alias __MIDL___MIDL_itf_opmapi_0000_0000_0002 = int;

enum : int
{
    OPM_STATUS_NORMAL                       = 0x00000000,
    OPM_STATUS_LINK_LOST                    = 0x00000001,
    OPM_STATUS_RENEGOTIATION_REQUIRED       = 0x00000002,
    OPM_STATUS_TAMPERING_DETECTED           = 0x00000004,
    OPM_STATUS_REVOKED_HDCP_DEVICE_ATTACHED = 0x00000008,
}
alias __MIDL___MIDL_itf_opmapi_0000_0000_0003 = int;

enum : int
{
    OPM_CONNECTOR_TYPE_OTHER                             = 0xffffffff,
    OPM_CONNECTOR_TYPE_VGA                               = 0x00000000,
    OPM_CONNECTOR_TYPE_SVIDEO                            = 0x00000001,
    OPM_CONNECTOR_TYPE_COMPOSITE_VIDEO                   = 0x00000002,
    OPM_CONNECTOR_TYPE_COMPONENT_VIDEO                   = 0x00000003,
    OPM_CONNECTOR_TYPE_DVI                               = 0x00000004,
    OPM_CONNECTOR_TYPE_HDMI                              = 0x00000005,
    OPM_CONNECTOR_TYPE_LVDS                              = 0x00000006,
    OPM_CONNECTOR_TYPE_D_JPN                             = 0x00000008,
    OPM_CONNECTOR_TYPE_SDI                               = 0x00000009,
    OPM_CONNECTOR_TYPE_DISPLAYPORT_EXTERNAL              = 0x0000000a,
    OPM_CONNECTOR_TYPE_DISPLAYPORT_EMBEDDED              = 0x0000000b,
    OPM_CONNECTOR_TYPE_UDI_EXTERNAL                      = 0x0000000c,
    OPM_CONNECTOR_TYPE_UDI_EMBEDDED                      = 0x0000000d,
    OPM_CONNECTOR_TYPE_RESERVED                          = 0x0000000e,
    OPM_CONNECTOR_TYPE_MIRACAST                          = 0x0000000f,
    OPM_CONNECTOR_TYPE_TRANSPORT_AGNOSTIC_DIGITAL_MODE_A = 0x00000010,
    OPM_CONNECTOR_TYPE_TRANSPORT_AGNOSTIC_DIGITAL_MODE_B = 0x00000011,
    OPM_COPP_COMPATIBLE_CONNECTOR_TYPE_INTERNAL          = 0x80000000,
}
alias __MIDL___MIDL_itf_opmapi_0000_0000_0004 = int;

enum : int
{
    OPM_DVI_CHARACTERISTIC_1_0          = 0x00000001,
    OPM_DVI_CHARACTERISTIC_1_1_OR_ABOVE = 0x00000002,
}
alias __MIDL___MIDL_itf_opmapi_0000_0000_0005 = int;

enum : int
{
    OPM_OUTPUT_HARDWARE_PROTECTION_NOT_SUPPORTED = 0x00000000,
    OPM_OUTPUT_HARDWARE_PROTECTION_SUPPORTED     = 0x00000001,
}
alias OPM_OUTPUT_HARDWARE_PROTECTION = int;

enum : int
{
    OPM_BUS_TYPE_OTHER                                                      = 0x00000000,
    OPM_BUS_TYPE_PCI                                                        = 0x00000001,
    OPM_BUS_TYPE_PCIX                                                       = 0x00000002,
    OPM_BUS_TYPE_PCIEXPRESS                                                 = 0x00000003,
    OPM_BUS_TYPE_AGP                                                        = 0x00000004,
    OPM_BUS_IMPLEMENTATION_MODIFIER_INSIDE_OF_CHIPSET                       = 0x00010000,
    OPM_BUS_IMPLEMENTATION_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_CHIP          = 0x00020000,
    OPM_BUS_IMPLEMENTATION_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_SOCKET        = 0x00030000,
    OPM_BUS_IMPLEMENTATION_MODIFIER_DAUGHTER_BOARD_CONNECTOR                = 0x00040000,
    OPM_BUS_IMPLEMENTATION_MODIFIER_DAUGHTER_BOARD_CONNECTOR_INSIDE_OF_NUAE = 0x00050000,
    OPM_BUS_IMPLEMENTATION_MODIFIER_NON_STANDARD                            = 0x80000000,
    OPM_COPP_COMPATIBLE_BUS_TYPE_INTEGRATED                                 = 0x80000000,
}
alias __MIDL___MIDL_itf_opmapi_0000_0000_0006 = int;

enum : int
{
    OPM_DPCP_OFF         = 0x00000000,
    OPM_DPCP_ON          = 0x00000001,
    OPM_DPCP_FORCE_ULONG = 0x7fffffff,
}
alias OPM_DPCP_PROTECTION_LEVEL = int;

enum : int
{
    OPM_HDCP_OFF         = 0x00000000,
    OPM_HDCP_ON          = 0x00000001,
    OPM_HDCP_FORCE_ULONG = 0x7fffffff,
}
alias OPM_HDCP_PROTECTION_LEVEL = int;

enum : int
{
    OPM_TYPE_ENFORCEMENT_HDCP_OFF                         = 0x00000000,
    OPM_TYPE_ENFORCEMENT_HDCP_ON_WITH_NO_TYPE_RESTRICTION = 0x00000001,
    OPM_TYPE_ENFORCEMENT_HDCP_ON_WITH_TYPE1_RESTRICTION   = 0x00000002,
    OPM_TYPE_ENFORCEMENT_HDCP_FORCE_ULONG                 = 0x7fffffff,
}
alias OPM_TYPE_ENFORCEMENT_HDCP_PROTECTION_LEVEL = int;

enum : int
{
    OPM_CGMSA_OFF                             = 0x00000000,
    OPM_CGMSA_COPY_FREELY                     = 0x00000001,
    OPM_CGMSA_COPY_NO_MORE                    = 0x00000002,
    OPM_CGMSA_COPY_ONE_GENERATION             = 0x00000003,
    OPM_CGMSA_COPY_NEVER                      = 0x00000004,
    OPM_CGMSA_REDISTRIBUTION_CONTROL_REQUIRED = 0x00000008,
}
alias __MIDL___MIDL_itf_opmapi_0000_0000_0007 = int;

enum : int
{
    OPM_ACP_OFF         = 0x00000000,
    OPM_ACP_LEVEL_ONE   = 0x00000001,
    OPM_ACP_LEVEL_TWO   = 0x00000002,
    OPM_ACP_LEVEL_THREE = 0x00000003,
    OPM_ACP_FORCE_ULONG = 0x7fffffff,
}
alias OPM_ACP_PROTECTION_LEVEL = int;

enum : int
{
    OPM_PROTECTION_TYPE_OTHER                 = 0x80000000,
    OPM_PROTECTION_TYPE_NONE                  = 0x00000000,
    OPM_PROTECTION_TYPE_COPP_COMPATIBLE_HDCP  = 0x00000001,
    OPM_PROTECTION_TYPE_ACP                   = 0x00000002,
    OPM_PROTECTION_TYPE_CGMSA                 = 0x00000004,
    OPM_PROTECTION_TYPE_HDCP                  = 0x00000008,
    OPM_PROTECTION_TYPE_DPCP                  = 0x00000010,
    OPM_PROTECTION_TYPE_TYPE_ENFORCEMENT_HDCP = 0x00000020,
}
alias __MIDL___MIDL_itf_opmapi_0000_0000_0008 = int;

enum : int
{
    OPM_PROTECTION_STANDARD_OTHER               = 0x80000000,
    OPM_PROTECTION_STANDARD_NONE                = 0x00000000,
    OPM_PROTECTION_STANDARD_IEC61880_525I       = 0x00000001,
    OPM_PROTECTION_STANDARD_IEC61880_2_525I     = 0x00000002,
    OPM_PROTECTION_STANDARD_IEC62375_625P       = 0x00000004,
    OPM_PROTECTION_STANDARD_EIA608B_525         = 0x00000008,
    OPM_PROTECTION_STANDARD_EN300294_625I       = 0x00000010,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEA_525P  = 0x00000020,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEA_750P  = 0x00000040,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEA_1125I = 0x00000080,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEB_525P  = 0x00000100,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEB_750P  = 0x00000200,
    OPM_PROTECTION_STANDARD_CEA805A_TYPEB_1125I = 0x00000400,
    OPM_PROTECTION_STANDARD_ARIBTRB15_525I      = 0x00000800,
    OPM_PROTECTION_STANDARD_ARIBTRB15_525P      = 0x00001000,
    OPM_PROTECTION_STANDARD_ARIBTRB15_750P      = 0x00002000,
    OPM_PROTECTION_STANDARD_ARIBTRB15_1125I     = 0x00004000,
}
alias __MIDL___MIDL_itf_opmapi_0000_0000_0009 = int;

enum : int
{
    OPM_ASPECT_RATIO_EN300294_FULL_FORMAT_4_BY_3                  = 0x00000000,
    OPM_ASPECT_RATIO_EN300294_BOX_14_BY_9_CENTER                  = 0x00000001,
    OPM_ASPECT_RATIO_EN300294_BOX_14_BY_9_TOP                     = 0x00000002,
    OPM_ASPECT_RATIO_EN300294_BOX_16_BY_9_CENTER                  = 0x00000003,
    OPM_ASPECT_RATIO_EN300294_BOX_16_BY_9_TOP                     = 0x00000004,
    OPM_ASPECT_RATIO_EN300294_BOX_GT_16_BY_9_CENTER               = 0x00000005,
    OPM_ASPECT_RATIO_EN300294_FULL_FORMAT_4_BY_3_PROTECTED_CENTER = 0x00000006,
    OPM_ASPECT_RATIO_EN300294_FULL_FORMAT_16_BY_9_ANAMORPHIC      = 0x00000007,
    OPM_ASPECT_RATIO_FORCE_ULONG                                  = 0x7fffffff,
}
alias OPM_IMAGE_ASPECT_RATIO_EN300294 = int;

enum : int
{
    KSMETHOD_OPMVIDEOOUTPUT_STARTINITIALIZATION  = 0x00000000,
    KSMETHOD_OPMVIDEOOUTPUT_FINISHINITIALIZATION = 0x00000001,
    KSMETHOD_OPMVIDEOOUTPUT_GETINFORMATION       = 0x00000002,
}
alias KSMETHOD_OPMVIDEOOUTPUT = int;

enum : int
{
    MF_ATTRIBUTE_UINT32   = 0x00000013,
    MF_ATTRIBUTE_UINT64   = 0x00000015,
    MF_ATTRIBUTE_DOUBLE   = 0x00000005,
    MF_ATTRIBUTE_GUID     = 0x00000048,
    MF_ATTRIBUTE_STRING   = 0x0000001f,
    MF_ATTRIBUTE_BLOB     = 0x00001011,
    MF_ATTRIBUTE_IUNKNOWN = 0x0000000d,
}
alias MF_ATTRIBUTE_TYPE = int;

enum : int
{
    MF_ATTRIBUTES_MATCH_OUR_ITEMS    = 0x00000000,
    MF_ATTRIBUTES_MATCH_THEIR_ITEMS  = 0x00000001,
    MF_ATTRIBUTES_MATCH_ALL_ITEMS    = 0x00000002,
    MF_ATTRIBUTES_MATCH_INTERSECTION = 0x00000003,
    MF_ATTRIBUTES_MATCH_SMALLER      = 0x00000004,
}
alias MF_ATTRIBUTES_MATCH_TYPE = int;

enum : int
{
    MF_ATTRIBUTE_SERIALIZE_UNKNOWN_BYREF = 0x00000001,
}
alias MF_ATTRIBUTE_SERIALIZE_OPTIONS = int;

enum : int
{
    MF2DBuffer_LockFlags_LockTypeMask = 0x00000003,
    MF2DBuffer_LockFlags_Read         = 0x00000001,
    MF2DBuffer_LockFlags_Write        = 0x00000002,
    MF2DBuffer_LockFlags_ReadWrite    = 0x00000003,
    MF2DBuffer_LockFlags_ForceDWORD   = 0x7fffffff,
}
alias MF2DBuffer_LockFlags = int;

enum MFVideoInterlaceMode : int
{
    MFVideoInterlace_Unknown                     = 0x00000000,
    MFVideoInterlace_Progressive                 = 0x00000002,
    MFVideoInterlace_FieldInterleavedUpperFirst  = 0x00000003,
    MFVideoInterlace_FieldInterleavedLowerFirst  = 0x00000004,
    MFVideoInterlace_FieldSingleUpper            = 0x00000005,
    MFVideoInterlace_FieldSingleLower            = 0x00000006,
    MFVideoInterlace_MixedInterlaceOrProgressive = 0x00000007,
    MFVideoInterlace_Last                        = 0x00000008,
    MFVideoInterlace_ForceDWORD                  = 0x7fffffff,
}

enum MFVideoTransferFunction : int
{
    MFVideoTransFunc_Unknown    = 0x00000000,
    MFVideoTransFunc_10         = 0x00000001,
    MFVideoTransFunc_18         = 0x00000002,
    MFVideoTransFunc_20         = 0x00000003,
    MFVideoTransFunc_22         = 0x00000004,
    MFVideoTransFunc_709        = 0x00000005,
    MFVideoTransFunc_240M       = 0x00000006,
    MFVideoTransFunc_sRGB       = 0x00000007,
    MFVideoTransFunc_28         = 0x00000008,
    MFVideoTransFunc_Log_100    = 0x00000009,
    MFVideoTransFunc_Log_316    = 0x0000000a,
    MFVideoTransFunc_709_sym    = 0x0000000b,
    MFVideoTransFunc_2020_const = 0x0000000c,
    MFVideoTransFunc_2020       = 0x0000000d,
    MFVideoTransFunc_26         = 0x0000000e,
    MFVideoTransFunc_2084       = 0x0000000f,
    MFVideoTransFunc_HLG        = 0x00000010,
    MFVideoTransFunc_10_rel     = 0x00000011,
    MFVideoTransFunc_Last       = 0x00000012,
    MFVideoTransFunc_ForceDWORD = 0x7fffffff,
}

enum MFVideoPrimaries : int
{
    MFVideoPrimaries_Unknown       = 0x00000000,
    MFVideoPrimaries_reserved      = 0x00000001,
    MFVideoPrimaries_BT709         = 0x00000002,
    MFVideoPrimaries_BT470_2_SysM  = 0x00000003,
    MFVideoPrimaries_BT470_2_SysBG = 0x00000004,
    MFVideoPrimaries_SMPTE170M     = 0x00000005,
    MFVideoPrimaries_SMPTE240M     = 0x00000006,
    MFVideoPrimaries_EBU3213       = 0x00000007,
    MFVideoPrimaries_SMPTE_C       = 0x00000008,
    MFVideoPrimaries_BT2020        = 0x00000009,
    MFVideoPrimaries_XYZ           = 0x0000000a,
    MFVideoPrimaries_DCI_P3        = 0x0000000b,
    MFVideoPrimaries_ACES          = 0x0000000c,
    MFVideoPrimaries_Last          = 0x0000000d,
    MFVideoPrimaries_ForceDWORD    = 0x7fffffff,
}

enum MFVideoLighting : int
{
    MFVideoLighting_Unknown    = 0x00000000,
    MFVideoLighting_bright     = 0x00000001,
    MFVideoLighting_office     = 0x00000002,
    MFVideoLighting_dim        = 0x00000003,
    MFVideoLighting_dark       = 0x00000004,
    MFVideoLighting_Last       = 0x00000005,
    MFVideoLighting_ForceDWORD = 0x7fffffff,
}

enum MFVideoTransferMatrix : int
{
    MFVideoTransferMatrix_Unknown    = 0x00000000,
    MFVideoTransferMatrix_BT709      = 0x00000001,
    MFVideoTransferMatrix_BT601      = 0x00000002,
    MFVideoTransferMatrix_SMPTE240M  = 0x00000003,
    MFVideoTransferMatrix_BT2020_10  = 0x00000004,
    MFVideoTransferMatrix_BT2020_12  = 0x00000005,
    MFVideoTransferMatrix_Last       = 0x00000006,
    MFVideoTransferMatrix_ForceDWORD = 0x7fffffff,
}

enum MFVideoChromaSubsampling : int
{
    MFVideoChromaSubsampling_Unknown                        = 0x00000000,
    MFVideoChromaSubsampling_ProgressiveChroma              = 0x00000008,
    MFVideoChromaSubsampling_Horizontally_Cosited           = 0x00000004,
    MFVideoChromaSubsampling_Vertically_Cosited             = 0x00000002,
    MFVideoChromaSubsampling_Vertically_AlignedChromaPlanes = 0x00000001,
    MFVideoChromaSubsampling_MPEG2                          = 0x00000005,
    MFVideoChromaSubsampling_MPEG1                          = 0x00000001,
    MFVideoChromaSubsampling_DV_PAL                         = 0x00000006,
    MFVideoChromaSubsampling_Cosited                        = 0x00000007,
    MFVideoChromaSubsampling_Last                           = 0x00000008,
    MFVideoChromaSubsampling_ForceDWORD                     = 0x7fffffff,
}

enum MFNominalRange : int
{
    MFNominalRange_Unknown    = 0x00000000,
    MFNominalRange_Normal     = 0x00000001,
    MFNominalRange_Wide       = 0x00000002,
    MFNominalRange_0_255      = 0x00000001,
    MFNominalRange_16_235     = 0x00000002,
    MFNominalRange_48_208     = 0x00000003,
    MFNominalRange_64_127     = 0x00000004,
    MFNominalRange_Last       = 0x00000005,
    MFNominalRange_ForceDWORD = 0x7fffffff,
}

enum MFVideoFlags : int
{
    MFVideoFlag_PAD_TO_Mask           = 0x00000003,
    MFVideoFlag_PAD_TO_None           = 0x00000000,
    MFVideoFlag_PAD_TO_4x3            = 0x00000001,
    MFVideoFlag_PAD_TO_16x9           = 0x00000002,
    MFVideoFlag_SrcContentHintMask    = 0x0000001c,
    MFVideoFlag_SrcContentHintNone    = 0x00000000,
    MFVideoFlag_SrcContentHint16x9    = 0x00000004,
    MFVideoFlag_SrcContentHint235_1   = 0x00000008,
    MFVideoFlag_AnalogProtected       = 0x00000020,
    MFVideoFlag_DigitallyProtected    = 0x00000040,
    MFVideoFlag_ProgressiveContent    = 0x00000080,
    MFVideoFlag_FieldRepeatCountMask  = 0x00000700,
    MFVideoFlag_FieldRepeatCountShift = 0x00000008,
    MFVideoFlag_ProgressiveSeqReset   = 0x00000800,
    MFVideoFlag_PanScanEnabled        = 0x00020000,
    MFVideoFlag_LowerFieldFirst       = 0x00040000,
    MFVideoFlag_BottomUpLinearRep     = 0x00080000,
    MFVideoFlags_DXVASurface          = 0x00100000,
    MFVideoFlags_RenderTargetSurface  = 0x00400000,
    MFVideoFlags_ForceQWORD           = 0x7fffffff,
}

enum MFStandardVideoFormat : int
{
    MFStdVideoFormat_reserved     = 0x00000000,
    MFStdVideoFormat_NTSC         = 0x00000001,
    MFStdVideoFormat_PAL          = 0x00000002,
    MFStdVideoFormat_DVD_NTSC     = 0x00000003,
    MFStdVideoFormat_DVD_PAL      = 0x00000004,
    MFStdVideoFormat_DV_PAL       = 0x00000005,
    MFStdVideoFormat_DV_NTSC      = 0x00000006,
    MFStdVideoFormat_ATSC_SD480i  = 0x00000007,
    MFStdVideoFormat_ATSC_HD1080i = 0x00000008,
    MFStdVideoFormat_ATSC_HD720p  = 0x00000009,
}

enum : int
{
    MEUnknown                                  = 0x00000000,
    MEError                                    = 0x00000001,
    MEExtendedType                             = 0x00000002,
    MENonFatalError                            = 0x00000003,
    MEGenericV1Anchor                          = 0x00000003,
    MESessionUnknown                           = 0x00000064,
    MESessionTopologySet                       = 0x00000065,
    MESessionTopologiesCleared                 = 0x00000066,
    MESessionStarted                           = 0x00000067,
    MESessionPaused                            = 0x00000068,
    MESessionStopped                           = 0x00000069,
    MESessionClosed                            = 0x0000006a,
    MESessionEnded                             = 0x0000006b,
    MESessionRateChanged                       = 0x0000006c,
    MESessionScrubSampleComplete               = 0x0000006d,
    MESessionCapabilitiesChanged               = 0x0000006e,
    MESessionTopologyStatus                    = 0x0000006f,
    MESessionNotifyPresentationTime            = 0x00000070,
    MENewPresentation                          = 0x00000071,
    MELicenseAcquisitionStart                  = 0x00000072,
    MELicenseAcquisitionCompleted              = 0x00000073,
    MEIndividualizationStart                   = 0x00000074,
    MEIndividualizationCompleted               = 0x00000075,
    MEEnablerProgress                          = 0x00000076,
    MEEnablerCompleted                         = 0x00000077,
    MEPolicyError                              = 0x00000078,
    MEPolicyReport                             = 0x00000079,
    MEBufferingStarted                         = 0x0000007a,
    MEBufferingStopped                         = 0x0000007b,
    MEConnectStart                             = 0x0000007c,
    MEConnectEnd                               = 0x0000007d,
    MEReconnectStart                           = 0x0000007e,
    MEReconnectEnd                             = 0x0000007f,
    MERendererEvent                            = 0x00000080,
    MESessionStreamSinkFormatChanged           = 0x00000081,
    MESessionV1Anchor                          = 0x00000081,
    MESourceUnknown                            = 0x000000c8,
    MESourceStarted                            = 0x000000c9,
    MEStreamStarted                            = 0x000000ca,
    MESourceSeeked                             = 0x000000cb,
    MEStreamSeeked                             = 0x000000cc,
    MENewStream                                = 0x000000cd,
    MEUpdatedStream                            = 0x000000ce,
    MESourceStopped                            = 0x000000cf,
    MEStreamStopped                            = 0x000000d0,
    MESourcePaused                             = 0x000000d1,
    MEStreamPaused                             = 0x000000d2,
    MEEndOfPresentation                        = 0x000000d3,
    MEEndOfStream                              = 0x000000d4,
    MEMediaSample                              = 0x000000d5,
    MEStreamTick                               = 0x000000d6,
    MEStreamThinMode                           = 0x000000d7,
    MEStreamFormatChanged                      = 0x000000d8,
    MESourceRateChanged                        = 0x000000d9,
    MEEndOfPresentationSegment                 = 0x000000da,
    MESourceCharacteristicsChanged             = 0x000000db,
    MESourceRateChangeRequested                = 0x000000dc,
    MESourceMetadataChanged                    = 0x000000dd,
    MESequencerSourceTopologyUpdated           = 0x000000de,
    MESourceV1Anchor                           = 0x000000de,
    MESinkUnknown                              = 0x0000012c,
    MEStreamSinkStarted                        = 0x0000012d,
    MEStreamSinkStopped                        = 0x0000012e,
    MEStreamSinkPaused                         = 0x0000012f,
    MEStreamSinkRateChanged                    = 0x00000130,
    MEStreamSinkRequestSample                  = 0x00000131,
    MEStreamSinkMarker                         = 0x00000132,
    MEStreamSinkPrerolled                      = 0x00000133,
    MEStreamSinkScrubSampleComplete            = 0x00000134,
    MEStreamSinkFormatChanged                  = 0x00000135,
    MEStreamSinkDeviceChanged                  = 0x00000136,
    MEQualityNotify                            = 0x00000137,
    MESinkInvalidated                          = 0x00000138,
    MEAudioSessionNameChanged                  = 0x00000139,
    MEAudioSessionVolumeChanged                = 0x0000013a,
    MEAudioSessionDeviceRemoved                = 0x0000013b,
    MEAudioSessionServerShutdown               = 0x0000013c,
    MEAudioSessionGroupingParamChanged         = 0x0000013d,
    MEAudioSessionIconChanged                  = 0x0000013e,
    MEAudioSessionFormatChanged                = 0x0000013f,
    MEAudioSessionDisconnected                 = 0x00000140,
    MEAudioSessionExclusiveModeOverride        = 0x00000141,
    MESinkV1Anchor                             = 0x00000141,
    MECaptureAudioSessionVolumeChanged         = 0x00000142,
    MECaptureAudioSessionDeviceRemoved         = 0x00000143,
    MECaptureAudioSessionFormatChanged         = 0x00000144,
    MECaptureAudioSessionDisconnected          = 0x00000145,
    MECaptureAudioSessionExclusiveModeOverride = 0x00000146,
    MECaptureAudioSessionServerShutdown        = 0x00000147,
    MESinkV2Anchor                             = 0x00000147,
    METrustUnknown                             = 0x00000190,
    MEPolicyChanged                            = 0x00000191,
    MEContentProtectionMessage                 = 0x00000192,
    MEPolicySet                                = 0x00000193,
    METrustV1Anchor                            = 0x00000193,
    MEWMDRMLicenseBackupCompleted              = 0x000001f4,
    MEWMDRMLicenseBackupProgress               = 0x000001f5,
    MEWMDRMLicenseRestoreCompleted             = 0x000001f6,
    MEWMDRMLicenseRestoreProgress              = 0x000001f7,
    MEWMDRMLicenseAcquisitionCompleted         = 0x000001fa,
    MEWMDRMIndividualizationCompleted          = 0x000001fc,
    MEWMDRMIndividualizationProgress           = 0x00000201,
    MEWMDRMProximityCompleted                  = 0x00000202,
    MEWMDRMLicenseStoreCleaned                 = 0x00000203,
    MEWMDRMRevocationDownloadCompleted         = 0x00000204,
    MEWMDRMV1Anchor                            = 0x00000204,
    METransformUnknown                         = 0x00000258,
    METransformNeedInput                       = 0x00000259,
    METransformHaveOutput                      = 0x0000025a,
    METransformDrainComplete                   = 0x0000025b,
    METransformMarker                          = 0x0000025c,
    METransformInputStreamStateChanged         = 0x0000025d,
    MEByteStreamCharacteristicsChanged         = 0x000002bc,
    MEVideoCaptureDeviceRemoved                = 0x00000320,
    MEVideoCaptureDevicePreempted              = 0x00000321,
    MEStreamSinkFormatInvalidated              = 0x00000322,
    MEEncodingParameters                       = 0x00000323,
    MEContentProtectionMetadata                = 0x00000384,
    MEDeviceThermalStateChanged                = 0x000003b6,
    MEReservedMax                              = 0x00002710,
}
alias __MIDL___MIDL_itf_mfobjects_0000_0012_0001 = int;

enum : int
{
    msoBegin   = 0x00000000,
    msoCurrent = 0x00000001,
}
alias MFBYTESTREAM_SEEK_ORIGIN = int;

enum : int
{
    MF_ACCESSMODE_READ      = 0x00000001,
    MF_ACCESSMODE_WRITE     = 0x00000002,
    MF_ACCESSMODE_READWRITE = 0x00000003,
}
alias MF_FILE_ACCESSMODE = int;

enum : int
{
    MF_OPENMODE_FAIL_IF_NOT_EXIST = 0x00000000,
    MF_OPENMODE_FAIL_IF_EXIST     = 0x00000001,
    MF_OPENMODE_RESET_IF_EXIST    = 0x00000002,
    MF_OPENMODE_APPEND_IF_EXIST   = 0x00000003,
    MF_OPENMODE_DELETE_IF_EXIST   = 0x00000004,
}
alias MF_FILE_OPENMODE = int;

enum : int
{
    MF_FILEFLAGS_NONE                = 0x00000000,
    MF_FILEFLAGS_NOBUFFERING         = 0x00000001,
    MF_FILEFLAGS_ALLOW_WRITE_SHARING = 0x00000002,
}
alias MF_FILE_FLAGS = int;

enum : int
{
    MF_PLUGIN_CONTROL_POLICY_USE_ALL_PLUGINS          = 0x00000000,
    MF_PLUGIN_CONTROL_POLICY_USE_APPROVED_PLUGINS     = 0x00000001,
    MF_PLUGIN_CONTROL_POLICY_USE_WEB_PLUGINS          = 0x00000002,
    MF_PLUGIN_CONTROL_POLICY_USE_WEB_PLUGINS_EDGEMODE = 0x00000003,
}
alias MF_PLUGIN_CONTROL_POLICY = int;

enum : int
{
    MF_STREAM_STATE_STOPPED = 0x00000000,
    MF_STREAM_STATE_PAUSED  = 0x00000001,
    MF_STREAM_STATE_RUNNING = 0x00000002,
}
alias MF_STREAM_STATE = int;

enum : int
{
    MFT_INPUT_DATA_BUFFER_PLACEHOLDER = 0xffffffff,
}
alias _MFT_INPUT_DATA_BUFFER_FLAGS = int;

enum : int
{
    MFT_OUTPUT_DATA_BUFFER_INCOMPLETE    = 0x01000000,
    MFT_OUTPUT_DATA_BUFFER_FORMAT_CHANGE = 0x00000100,
    MFT_OUTPUT_DATA_BUFFER_STREAM_END    = 0x00000200,
    MFT_OUTPUT_DATA_BUFFER_NO_SAMPLE     = 0x00000300,
}
alias _MFT_OUTPUT_DATA_BUFFER_FLAGS = int;

enum : int
{
    MFT_INPUT_STATUS_ACCEPT_DATA = 0x00000001,
}
alias _MFT_INPUT_STATUS_FLAGS = int;

enum : int
{
    MFT_OUTPUT_STATUS_SAMPLE_READY = 0x00000001,
}
alias _MFT_OUTPUT_STATUS_FLAGS = int;

enum : int
{
    MFT_INPUT_STREAM_WHOLE_SAMPLES            = 0x00000001,
    MFT_INPUT_STREAM_SINGLE_SAMPLE_PER_BUFFER = 0x00000002,
    MFT_INPUT_STREAM_FIXED_SAMPLE_SIZE        = 0x00000004,
    MFT_INPUT_STREAM_HOLDS_BUFFERS            = 0x00000008,
    MFT_INPUT_STREAM_DOES_NOT_ADDREF          = 0x00000100,
    MFT_INPUT_STREAM_REMOVABLE                = 0x00000200,
    MFT_INPUT_STREAM_OPTIONAL                 = 0x00000400,
    MFT_INPUT_STREAM_PROCESSES_IN_PLACE       = 0x00000800,
}
alias _MFT_INPUT_STREAM_INFO_FLAGS = int;

enum : int
{
    MFT_OUTPUT_STREAM_WHOLE_SAMPLES            = 0x00000001,
    MFT_OUTPUT_STREAM_SINGLE_SAMPLE_PER_BUFFER = 0x00000002,
    MFT_OUTPUT_STREAM_FIXED_SAMPLE_SIZE        = 0x00000004,
    MFT_OUTPUT_STREAM_DISCARDABLE              = 0x00000008,
    MFT_OUTPUT_STREAM_OPTIONAL                 = 0x00000010,
    MFT_OUTPUT_STREAM_PROVIDES_SAMPLES         = 0x00000100,
    MFT_OUTPUT_STREAM_CAN_PROVIDE_SAMPLES      = 0x00000200,
    MFT_OUTPUT_STREAM_LAZY_READ                = 0x00000400,
    MFT_OUTPUT_STREAM_REMOVABLE                = 0x00000800,
}
alias _MFT_OUTPUT_STREAM_INFO_FLAGS = int;

enum : int
{
    MFT_SET_TYPE_TEST_ONLY = 0x00000001,
}
alias _MFT_SET_TYPE_FLAGS = int;

enum : int
{
    MFT_PROCESS_OUTPUT_DISCARD_WHEN_NO_BUFFER = 0x00000001,
    MFT_PROCESS_OUTPUT_REGENERATE_LAST_OUTPUT = 0x00000002,
}
alias _MFT_PROCESS_OUTPUT_FLAGS = int;

enum : int
{
    MFT_PROCESS_OUTPUT_STATUS_NEW_STREAMS = 0x00000100,
}
alias _MFT_PROCESS_OUTPUT_STATUS = int;

enum : int
{
    MFT_DRAIN_PRODUCE_TAILS = 0x00000000,
    MFT_DRAIN_NO_TAILS      = 0x00000001,
}
alias MFT_DRAIN_TYPE = int;

enum : int
{
    MFT_MESSAGE_COMMAND_FLUSH                   = 0x00000000,
    MFT_MESSAGE_COMMAND_DRAIN                   = 0x00000001,
    MFT_MESSAGE_SET_D3D_MANAGER                 = 0x00000002,
    MFT_MESSAGE_DROP_SAMPLES                    = 0x00000003,
    MFT_MESSAGE_COMMAND_TICK                    = 0x00000004,
    MFT_MESSAGE_NOTIFY_BEGIN_STREAMING          = 0x10000000,
    MFT_MESSAGE_NOTIFY_END_STREAMING            = 0x10000001,
    MFT_MESSAGE_NOTIFY_END_OF_STREAM            = 0x10000002,
    MFT_MESSAGE_NOTIFY_START_OF_STREAM          = 0x10000003,
    MFT_MESSAGE_NOTIFY_RELEASE_RESOURCES        = 0x10000004,
    MFT_MESSAGE_NOTIFY_REACQUIRE_RESOURCES      = 0x10000005,
    MFT_MESSAGE_NOTIFY_EVENT                    = 0x10000006,
    MFT_MESSAGE_COMMAND_SET_OUTPUT_STREAM_STATE = 0x10000007,
    MFT_MESSAGE_COMMAND_FLUSH_OUTPUT_STREAM     = 0x10000008,
    MFT_MESSAGE_COMMAND_MARKER                  = 0x20000000,
}
alias MFT_MESSAGE_TYPE = int;

enum DeviceStreamState : int
{
    DeviceStreamState_Stop     = 0x00000000,
    DeviceStreamState_Pause    = 0x00000001,
    DeviceStreamState_Run      = 0x00000002,
    DeviceStreamState_Disabled = 0x00000003,
}

enum MF3DVideoOutputType : int
{
    MF3DVideoOutputType_BaseView = 0x00000000,
    MF3DVideoOutputType_Stereo   = 0x00000001,
}

enum : int
{
    MFT_AUDIO_DECODER_DEGRADATION_REASON_NONE                  = 0x00000000,
    MFT_AUDIO_DECODER_DEGRADATION_REASON_LICENSING_REQUIREMENT = 0x00000001,
}
alias MFT_AUDIO_DECODER_DEGRADATION_REASON = int;

enum : int
{
    MFT_AUDIO_DECODER_DEGRADATION_TYPE_NONE            = 0x00000000,
    MFT_AUDIO_DECODER_DEGRADATION_TYPE_DOWNMIX2CHANNEL = 0x00000001,
    MFT_AUDIO_DECODER_DEGRADATION_TYPE_DOWNMIX6CHANNEL = 0x00000002,
    MFT_AUDIO_DECODER_DEGRADATION_TYPE_DOWNMIX8CHANNEL = 0x00000003,
}
alias MFT_AUDIO_DECODER_DEGRADATION_TYPE = int;

enum : int
{
    MFSESSION_SETTOPOLOGY_IMMEDIATE     = 0x00000001,
    MFSESSION_SETTOPOLOGY_NORESOLUTION  = 0x00000002,
    MFSESSION_SETTOPOLOGY_CLEAR_CURRENT = 0x00000004,
}
alias MFSESSION_SETTOPOLOGY_FLAGS = int;

enum : int
{
    MFSESSION_GETFULLTOPOLOGY_CURRENT = 0x00000001,
}
alias MFSESSION_GETFULLTOPOLOGY_FLAGS = int;

enum : int
{
    MFPMPSESSION_UNPROTECTED_PROCESS = 0x00000001,
    MFPMPSESSION_IN_PROCESS          = 0x00000002,
}
alias MFPMPSESSION_CREATION_FLAGS = int;

enum : int
{
    MF_OBJECT_MEDIASOURCE = 0x00000000,
    MF_OBJECT_BYTESTREAM  = 0x00000001,
    MF_OBJECT_INVALID     = 0x00000002,
}
alias MF_OBJECT_TYPE = int;

enum : int
{
    MF_RESOLUTION_MEDIASOURCE                                           = 0x00000001,
    MF_RESOLUTION_BYTESTREAM                                            = 0x00000002,
    MF_RESOLUTION_CONTENT_DOES_NOT_HAVE_TO_MATCH_EXTENSION_OR_MIME_TYPE = 0x00000010,
    MF_RESOLUTION_KEEP_BYTE_STREAM_ALIVE_ON_FAIL                        = 0x00000020,
    MF_RESOLUTION_DISABLE_LOCAL_PLUGINS                                 = 0x00000040,
    MF_RESOLUTION_PLUGIN_CONTROL_POLICY_APPROVED_ONLY                   = 0x00000080,
    MF_RESOLUTION_PLUGIN_CONTROL_POLICY_WEB_ONLY                        = 0x00000100,
    MF_RESOLUTION_PLUGIN_CONTROL_POLICY_WEB_ONLY_EDGEMODE               = 0x00000200,
    MF_RESOLUTION_ENABLE_STORE_PLUGINS                                  = 0x00000400,
    MF_RESOLUTION_READ                                                  = 0x00010000,
    MF_RESOLUTION_WRITE                                                 = 0x00020000,
}
alias __MIDL___MIDL_itf_mfidl_0000_0001_0001 = int;

enum : int
{
    MF_CONNECT_DIRECT                          = 0x00000000,
    MF_CONNECT_ALLOW_CONVERTER                 = 0x00000001,
    MF_CONNECT_ALLOW_DECODER                   = 0x00000003,
    MF_CONNECT_RESOLVE_INDEPENDENT_OUTPUTTYPES = 0x00000004,
    MF_CONNECT_AS_OPTIONAL                     = 0x00010000,
    MF_CONNECT_AS_OPTIONAL_BRANCH              = 0x00020000,
}
alias MF_CONNECT_METHOD = int;

enum : int
{
    MF_TOPOLOGY_RESOLUTION_SUCCEEDED            = 0x00000000,
    MF_OPTIONAL_NODE_REJECTED_MEDIA_TYPE        = 0x00000001,
    MF_OPTIONAL_NODE_REJECTED_PROTECTED_PROCESS = 0x00000002,
}
alias MF_TOPOLOGY_RESOLUTION_STATUS_FLAGS = int;

enum : int
{
    MFMEDIASOURCE_IS_LIVE                    = 0x00000001,
    MFMEDIASOURCE_CAN_SEEK                   = 0x00000002,
    MFMEDIASOURCE_CAN_PAUSE                  = 0x00000004,
    MFMEDIASOURCE_HAS_SLOW_SEEK              = 0x00000008,
    MFMEDIASOURCE_HAS_MULTIPLE_PRESENTATIONS = 0x00000010,
    MFMEDIASOURCE_CAN_SKIPFORWARD            = 0x00000020,
    MFMEDIASOURCE_CAN_SKIPBACKWARD           = 0x00000040,
    MFMEDIASOURCE_DOES_NOT_USE_NETWORK       = 0x00000080,
}
alias MFMEDIASOURCE_CHARACTERISTICS = int;

enum : int
{
    MFSTREAMSINK_MARKER_DEFAULT      = 0x00000000,
    MFSTREAMSINK_MARKER_ENDOFSEGMENT = 0x00000001,
    MFSTREAMSINK_MARKER_TICK         = 0x00000002,
    MFSTREAMSINK_MARKER_EVENT        = 0x00000003,
}
alias MFSTREAMSINK_MARKER_TYPE = int;

enum : int
{
    ROTATION_NONE   = 0x00000000,
    ROTATION_NORMAL = 0x00000001,
}
alias MF_VIDEO_PROCESSOR_ROTATION = int;

enum : int
{
    MIRROR_NONE       = 0x00000000,
    MIRROR_HORIZONTAL = 0x00000001,
    MIRROR_VERTICAL   = 0x00000002,
}
alias MF_VIDEO_PROCESSOR_MIRROR = int;

enum MFVideoSphericalFormat : int
{
    MFVideoSphericalFormat_Unsupported     = 0x00000000,
    MFVideoSphericalFormat_Equirectangular = 0x00000001,
    MFVideoSphericalFormat_CubeMap         = 0x00000002,
    MFVideoSphericalFormat_3DMesh          = 0x00000003,
}

enum MFVideoSphericalProjectionMode : int
{
    MFVideoSphericalProjectionMode_Spherical = 0x00000000,
    MFVideoSphericalProjectionMode_Flat      = 0x00000001,
}

enum : int
{
    MFTOPOLOGY_DXVA_DEFAULT = 0x00000000,
    MFTOPOLOGY_DXVA_NONE    = 0x00000001,
    MFTOPOLOGY_DXVA_FULL    = 0x00000002,
}
alias MFTOPOLOGY_DXVA_MODE = int;

enum : int
{
    MFTOPOLOGY_HWMODE_SOFTWARE_ONLY     = 0x00000000,
    MFTOPOLOGY_HWMODE_USE_HARDWARE      = 0x00000001,
    MFTOPOLOGY_HWMODE_USE_ONLY_HARDWARE = 0x00000002,
}
alias MFTOPOLOGY_HARDWARE_MODE = int;

enum : int
{
    MF_TOPOLOGY_OUTPUT_NODE       = 0x00000000,
    MF_TOPOLOGY_SOURCESTREAM_NODE = 0x00000001,
    MF_TOPOLOGY_TRANSFORM_NODE    = 0x00000002,
    MF_TOPOLOGY_TEE_NODE          = 0x00000003,
    MF_TOPOLOGY_MAX               = 0xffffffff,
}
alias MF_TOPOLOGY_TYPE = int;

enum : int
{
    MF_TOPONODE_FLUSH_ALWAYS = 0x00000000,
    MF_TOPONODE_FLUSH_SEEK   = 0x00000001,
    MF_TOPONODE_FLUSH_NEVER  = 0x00000002,
}
alias MF_TOPONODE_FLUSH_MODE = int;

enum : int
{
    MF_TOPONODE_DRAIN_DEFAULT = 0x00000000,
    MF_TOPONODE_DRAIN_ALWAYS  = 0x00000001,
    MF_TOPONODE_DRAIN_NEVER   = 0x00000002,
}
alias MF_TOPONODE_DRAIN_MODE = int;

enum : int
{
    MFCLOCK_CHARACTERISTICS_FLAG_FREQUENCY_10MHZ = 0x00000002,
    MFCLOCK_CHARACTERISTICS_FLAG_ALWAYS_RUNNING  = 0x00000004,
    MFCLOCK_CHARACTERISTICS_FLAG_IS_SYSTEM_CLOCK = 0x00000008,
}
alias MFCLOCK_CHARACTERISTICS_FLAGS = int;

enum : int
{
    MFCLOCK_STATE_INVALID = 0x00000000,
    MFCLOCK_STATE_RUNNING = 0x00000001,
    MFCLOCK_STATE_STOPPED = 0x00000002,
    MFCLOCK_STATE_PAUSED  = 0x00000003,
}
alias MFCLOCK_STATE = int;

enum : int
{
    MFCLOCK_RELATIONAL_FLAG_JITTER_NEVER_AHEAD = 0x00000001,
}
alias MFCLOCK_RELATIONAL_FLAGS = int;

enum : int
{
    MFTIMER_RELATIVE = 0x00000001,
}
alias MFTIMER_FLAGS = int;

enum : int
{
    MF_ACTIVATE_CUSTOM_MIXER_ALLOWFAIL = 0x00000001,
}
alias __MIDL___MIDL_itf_mfidl_0000_0029_0001 = int;

enum : int
{
    MF_ACTIVATE_CUSTOM_PRESENTER_ALLOWFAIL = 0x00000001,
}
alias __MIDL___MIDL_itf_mfidl_0000_0029_0002 = int;

enum : int
{
    MFSHUTDOWN_INITIATED = 0x00000000,
    MFSHUTDOWN_COMPLETED = 0x00000001,
}
alias MFSHUTDOWN_STATUS = int;

enum : int
{
    MF_LICENSE_URL_UNTRUSTED = 0x00000000,
    MF_LICENSE_URL_TRUSTED   = 0x00000001,
    MF_LICENSE_URL_TAMPERED  = 0x00000002,
}
alias MF_URL_TRUST_STATUS = int;

enum : int
{
    MFRATE_FORWARD = 0x00000000,
    MFRATE_REVERSE = 0x00000001,
}
alias MFRATE_DIRECTION = int;

enum : int
{
    MF_DROP_MODE_NONE = 0x00000000,
    MF_DROP_MODE_1    = 0x00000001,
    MF_DROP_MODE_2    = 0x00000002,
    MF_DROP_MODE_3    = 0x00000003,
    MF_DROP_MODE_4    = 0x00000004,
    MF_DROP_MODE_5    = 0x00000005,
    MF_NUM_DROP_MODES = 0x00000006,
}
alias MF_QUALITY_DROP_MODE = int;

enum : int
{
    MF_QUALITY_NORMAL         = 0x00000000,
    MF_QUALITY_NORMAL_MINUS_1 = 0x00000001,
    MF_QUALITY_NORMAL_MINUS_2 = 0x00000002,
    MF_QUALITY_NORMAL_MINUS_3 = 0x00000003,
    MF_QUALITY_NORMAL_MINUS_4 = 0x00000004,
    MF_QUALITY_NORMAL_MINUS_5 = 0x00000005,
    MF_NUM_QUALITY_LEVELS     = 0x00000006,
}
alias MF_QUALITY_LEVEL = int;

enum : int
{
    MF_QUALITY_CANNOT_KEEP_UP = 0x00000001,
}
alias MF_QUALITY_ADVISE_FLAGS = int;

enum MFSequencerTopologyFlags : int
{
    SequencerTopologyFlags_Last = 0x00000001,
}

enum MFNetCredentialRequirements : int
{
    REQUIRE_PROMPT        = 0x00000001,
    REQUIRE_SAVE_SELECTED = 0x00000002,
}

enum MFNetCredentialOptions : int
{
    MFNET_CREDENTIAL_SAVE             = 0x00000001,
    MFNET_CREDENTIAL_DONT_CACHE       = 0x00000002,
    MFNET_CREDENTIAL_ALLOW_CLEAR_TEXT = 0x00000004,
}

enum MFNetAuthenticationFlags : int
{
    MFNET_AUTHENTICATION_PROXY          = 0x00000001,
    MFNET_AUTHENTICATION_CLEAR_TEXT     = 0x00000002,
    MFNET_AUTHENTICATION_LOGGED_ON_USER = 0x00000004,
}

enum : int
{
    MFNETSOURCE_UNDEFINED = 0x00000000,
    MFNETSOURCE_HTTP      = 0x00000001,
    MFNETSOURCE_RTSP      = 0x00000002,
    MFNETSOURCE_FILE      = 0x00000003,
    MFNETSOURCE_MULTICAST = 0x00000004,
}
alias MFNETSOURCE_PROTOCOL_TYPE = int;

enum : int
{
    MFNETSOURCE_UDP = 0x00000000,
    MFNETSOURCE_TCP = 0x00000001,
}
alias MFNETSOURCE_TRANSPORT_TYPE = int;

enum : int
{
    MFNETSOURCE_CACHE_UNAVAILABLE     = 0x00000000,
    MFNETSOURCE_CACHE_ACTIVE_WRITING  = 0x00000001,
    MFNETSOURCE_CACHE_ACTIVE_COMPLETE = 0x00000002,
}
alias MFNETSOURCE_CACHE_STATE = int;

enum : int
{
    MFNETSOURCE_RECVPACKETS_ID              = 0x00000000,
    MFNETSOURCE_LOSTPACKETS_ID              = 0x00000001,
    MFNETSOURCE_RESENDSREQUESTED_ID         = 0x00000002,
    MFNETSOURCE_RESENDSRECEIVED_ID          = 0x00000003,
    MFNETSOURCE_RECOVEREDBYECCPACKETS_ID    = 0x00000004,
    MFNETSOURCE_RECOVEREDBYRTXPACKETS_ID    = 0x00000005,
    MFNETSOURCE_OUTPACKETS_ID               = 0x00000006,
    MFNETSOURCE_RECVRATE_ID                 = 0x00000007,
    MFNETSOURCE_AVGBANDWIDTHBPS_ID          = 0x00000008,
    MFNETSOURCE_BYTESRECEIVED_ID            = 0x00000009,
    MFNETSOURCE_PROTOCOL_ID                 = 0x0000000a,
    MFNETSOURCE_TRANSPORT_ID                = 0x0000000b,
    MFNETSOURCE_CACHE_STATE_ID              = 0x0000000c,
    MFNETSOURCE_LINKBANDWIDTH_ID            = 0x0000000d,
    MFNETSOURCE_CONTENTBITRATE_ID           = 0x0000000e,
    MFNETSOURCE_SPEEDFACTOR_ID              = 0x0000000f,
    MFNETSOURCE_BUFFERSIZE_ID               = 0x00000010,
    MFNETSOURCE_BUFFERPROGRESS_ID           = 0x00000011,
    MFNETSOURCE_LASTBWSWITCHTS_ID           = 0x00000012,
    MFNETSOURCE_SEEKRANGESTART_ID           = 0x00000013,
    MFNETSOURCE_SEEKRANGEEND_ID             = 0x00000014,
    MFNETSOURCE_BUFFERINGCOUNT_ID           = 0x00000015,
    MFNETSOURCE_INCORRECTLYSIGNEDPACKETS_ID = 0x00000016,
    MFNETSOURCE_SIGNEDSESSION_ID            = 0x00000017,
    MFNETSOURCE_MAXBITRATE_ID               = 0x00000018,
    MFNETSOURCE_RECEPTION_QUALITY_ID        = 0x00000019,
    MFNETSOURCE_RECOVEREDPACKETS_ID         = 0x0000001a,
    MFNETSOURCE_VBR_ID                      = 0x0000001b,
    MFNETSOURCE_DOWNLOADPROGRESS_ID         = 0x0000001c,
    MFNETSOURCE_UNPREDEFINEDPROTOCOLNAME_ID = 0x0000001d,
}
alias MFNETSOURCE_STATISTICS_IDS = int;

enum : int
{
    MFNET_PROXYSETTING_NONE    = 0x00000000,
    MFNET_PROXYSETTING_MANUAL  = 0x00000001,
    MFNET_PROXYSETTING_AUTO    = 0x00000002,
    MFNET_PROXYSETTING_BROWSER = 0x00000003,
}
alias MFNET_PROXYSETTINGS = int;

enum : int
{
    PEACTION_NO        = 0x00000000,
    PEACTION_PLAY      = 0x00000001,
    PEACTION_COPY      = 0x00000002,
    PEACTION_EXPORT    = 0x00000003,
    PEACTION_EXTRACT   = 0x00000004,
    PEACTION_RESERVED1 = 0x00000005,
    PEACTION_RESERVED2 = 0x00000006,
    PEACTION_RESERVED3 = 0x00000007,
    PEACTION_LAST      = 0x00000007,
}
alias MFPOLICYMANAGER_ACTION = int;

enum : int
{
    MF_OPM_CGMSA_OFF                             = 0x00000000,
    MF_OPM_CGMSA_COPY_FREELY                     = 0x00000001,
    MF_OPM_CGMSA_COPY_NO_MORE                    = 0x00000002,
    MF_OPM_CGMSA_COPY_ONE_GENERATION             = 0x00000003,
    MF_OPM_CGMSA_COPY_NEVER                      = 0x00000004,
    MF_OPM_CGMSA_REDISTRIBUTION_CONTROL_REQUIRED = 0x00000008,
}
alias MF_OPM_CGMSA_PROTECTION_LEVEL = int;

enum : int
{
    MF_OPM_ACP_OFF         = 0x00000000,
    MF_OPM_ACP_LEVEL_ONE   = 0x00000001,
    MF_OPM_ACP_LEVEL_TWO   = 0x00000002,
    MF_OPM_ACP_LEVEL_THREE = 0x00000003,
    MF_OPM_ACP_FORCE_ULONG = 0x7fffffff,
}
alias MF_OPM_ACP_PROTECTION_LEVEL = int;

enum MFAudioConstriction : int
{
    MFaudioConstrictionOff   = 0x00000000,
    MFaudioConstriction48_16 = 0x00000001,
    MFaudioConstriction44_16 = 0x00000002,
    MFaudioConstriction14_14 = 0x00000003,
    MFaudioConstrictionMute  = 0x00000004,
}

enum : int
{
    SAMPLE_PROTECTION_VERSION_NO         = 0x00000000,
    SAMPLE_PROTECTION_VERSION_BASIC_LOKI = 0x00000001,
    SAMPLE_PROTECTION_VERSION_SCATTER    = 0x00000002,
    SAMPLE_PROTECTION_VERSION_RC4        = 0x00000003,
    SAMPLE_PROTECTION_VERSION_AES128CTR  = 0x00000004,
}
alias SAMPLE_PROTECTION_VERSION = int;

enum : int
{
    MF_TRANSCODE_TOPOLOGYMODE_SOFTWARE_ONLY    = 0x00000000,
    MF_TRANSCODE_TOPOLOGYMODE_HARDWARE_ALLOWED = 0x00000001,
}
alias MF_TRANSCODE_TOPOLOGYMODE_FLAGS = int;

enum : int
{
    MF_TRANSCODE_ADJUST_PROFILE_DEFAULT               = 0x00000000,
    MF_TRANSCODE_ADJUST_PROFILE_USE_SOURCE_ATTRIBUTES = 0x00000001,
}
alias MF_TRANSCODE_ADJUST_PROFILE_FLAGS = int;

enum : int
{
    MF_VIDEO_PROCESSOR_ALGORITHM_DEFAULT     = 0x00000000,
    MF_VIDEO_PROCESSOR_ALGORITHM_MRF_CRF_444 = 0x00000001,
}
alias MF_VIDEO_PROCESSOR_ALGORITHM_TYPE = int;

enum : int
{
    MF_MEDIAKEYSESSION_TYPE_TEMPORARY                  = 0x00000000,
    MF_MEDIAKEYSESSION_TYPE_PERSISTENT_LICENSE         = 0x00000001,
    MF_MEDIAKEYSESSION_TYPE_PERSISTENT_RELEASE_MESSAGE = 0x00000002,
    MF_MEDIAKEYSESSION_TYPE_PERSISTENT_USAGE_RECORD    = 0x00000003,
}
alias MF_MEDIAKEYSESSION_TYPE = int;

enum : int
{
    MF_MEDIAKEY_STATUS_USABLE             = 0x00000000,
    MF_MEDIAKEY_STATUS_EXPIRED            = 0x00000001,
    MF_MEDIAKEY_STATUS_OUTPUT_DOWNSCALED  = 0x00000002,
    MF_MEDIAKEY_STATUS_OUTPUT_NOT_ALLOWED = 0x00000003,
    MF_MEDIAKEY_STATUS_STATUS_PENDING     = 0x00000004,
    MF_MEDIAKEY_STATUS_INTERNAL_ERROR     = 0x00000005,
    MF_MEDIAKEY_STATUS_RELEASED           = 0x00000006,
    MF_MEDIAKEY_STATUS_OUTPUT_RESTRICTED  = 0x00000007,
}
alias MF_MEDIAKEY_STATUS = int;

enum : int
{
    MF_MEDIAKEYSESSION_MESSAGETYPE_LICENSE_REQUEST           = 0x00000000,
    MF_MEDIAKEYSESSION_MESSAGETYPE_LICENSE_RENEWAL           = 0x00000001,
    MF_MEDIAKEYSESSION_MESSAGETYPE_LICENSE_RELEASE           = 0x00000002,
    MF_MEDIAKEYSESSION_MESSAGETYPE_INDIVIDUALIZATION_REQUEST = 0x00000003,
}
alias MF_MEDIAKEYSESSION_MESSAGETYPE = int;

enum : int
{
    MF_CROSS_ORIGIN_POLICY_NONE            = 0x00000000,
    MF_CROSS_ORIGIN_POLICY_ANONYMOUS       = 0x00000001,
    MF_CROSS_ORIGIN_POLICY_USE_CREDENTIALS = 0x00000002,
}
alias MF_CROSS_ORIGIN_POLICY = int;

enum MFSensorDeviceType : int
{
    MFSensorDeviceType_Unknown         = 0x00000000,
    MFSensorDeviceType_Device          = 0x00000001,
    MFSensorDeviceType_MediaSource     = 0x00000002,
    MFSensorDeviceType_FrameProvider   = 0x00000003,
    MFSensorDeviceType_SensorTransform = 0x00000004,
}

enum MFSensorStreamType : int
{
    MFSensorStreamType_Unknown = 0x00000000,
    MFSensorStreamType_Input   = 0x00000001,
    MFSensorStreamType_Output  = 0x00000002,
}

enum MFSensorDeviceMode : int
{
    MFSensorDeviceMode_Controller = 0x00000000,
    MFSensorDeviceMode_Shared     = 0x00000001,
}

enum : int
{
    MFCameraIntrinsic_DistortionModelType_6KT    = 0x00000000,
    MFCameraIntrinsic_DistortionModelType_ArcTan = 0x00000001,
}
alias MFCameraIntrinsic_DistortionModelType = int;

enum MFSampleAllocatorUsage : int
{
    MFSampleAllocatorUsage_UsesProvidedAllocator = 0x00000000,
    MFSampleAllocatorUsage_UsesCustomAllocator   = 0x00000001,
    MFSampleAllocatorUsage_DoesNotAllocate       = 0x00000002,
}

enum : int
{
    MFASF_INDEXER_WRITE_NEW_INDEX          = 0x00000001,
    MFASF_INDEXER_READ_FOR_REVERSEPLAYBACK = 0x00000002,
    MFASF_INDEXER_WRITE_FOR_LIVEREAD       = 0x00000004,
}
alias MFASF_INDEXER_FLAGS = int;

enum : int
{
    MFASF_SPLITTER_REVERSE = 0x00000001,
    MFASF_SPLITTER_WMDRM   = 0x00000002,
}
alias MFASF_SPLITTERFLAGS = int;

enum : int
{
    ASF_STATUSFLAGS_INCOMPLETE     = 0x00000001,
    ASF_STATUSFLAGS_NONFATAL_ERROR = 0x00000002,
}
alias ASF_STATUSFLAGS = int;

enum : int
{
    MFASF_MULTIPLEXER_AUTOADJUST_BITRATE = 0x00000001,
}
alias MFASF_MULTIPLEXERFLAGS = int;

enum : int
{
    MFASF_STREAMSELECTOR_DISABLE_THINNING    = 0x00000001,
    MFASF_STREAMSELECTOR_USE_AVERAGE_BITRATE = 0x00000002,
}
alias MFASF_STREAMSELECTOR_FLAGS = int;

enum : int
{
    ASF_STATUS_NOTSELECTED     = 0x00000000,
    ASF_STATUS_CLEANPOINTSONLY = 0x00000001,
    ASF_STATUS_ALLDATAUNITS    = 0x00000002,
}
alias ASF_SELECTION_STATUS = int;

enum : int
{
    MFSINK_WMDRMACTION_UNDEFINED  = 0x00000000,
    MFSINK_WMDRMACTION_ENCODE     = 0x00000001,
    MFSINK_WMDRMACTION_TRANSCODE  = 0x00000002,
    MFSINK_WMDRMACTION_TRANSCRYPT = 0x00000003,
    MFSINK_WMDRMACTION_LAST       = 0x00000003,
}
alias MFSINK_WMDRMACTION = int;

enum : int
{
    MF_CAPTURE_ENGINE_DEVICE_TYPE_AUDIO = 0x00000000,
    MF_CAPTURE_ENGINE_DEVICE_TYPE_VIDEO = 0x00000001,
}
alias MF_CAPTURE_ENGINE_DEVICE_TYPE = int;

enum : int
{
    MF_CAPTURE_ENGINE_SINK_TYPE_RECORD  = 0x00000000,
    MF_CAPTURE_ENGINE_SINK_TYPE_PREVIEW = 0x00000001,
    MF_CAPTURE_ENGINE_SINK_TYPE_PHOTO   = 0x00000002,
}
alias MF_CAPTURE_ENGINE_SINK_TYPE = int;

enum : int
{
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_VIDEO_PREVIEW = 0xfffffffa,
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_VIDEO_RECORD  = 0xfffffff9,
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_PHOTO         = 0xfffffff8,
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_AUDIO         = 0xfffffff7,
    MF_CAPTURE_ENGINE_MEDIASOURCE                               = 0xffffffff,
}
alias __MIDL___MIDL_itf_mfcaptureengine_0000_0000_0001 = int;

enum : int
{
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_VIDEO_PREVIEW     = 0x00000000,
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_VIDEO_CAPTURE     = 0x00000001,
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_PHOTO_INDEPENDENT = 0x00000002,
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_PHOTO_DEPENDENT   = 0x00000003,
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_AUDIO             = 0x00000004,
    MF_CAPTURE_ENGINE_STREAM_CATEGORY_UNSUPPORTED       = 0x00000005,
}
alias MF_CAPTURE_ENGINE_STREAM_CATEGORY = int;

enum : int
{
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_OTHER          = 0x00000000,
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_COMMUNICATIONS = 0x00000001,
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_MEDIA          = 0x00000002,
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_GAMECHAT       = 0x00000003,
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_SPEECH         = 0x00000004,
}
alias MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE = int;

enum : int
{
    MF_CAPTURE_ENGINE_AUDIO_PROCESSING_DEFAULT = 0x00000000,
    MF_CAPTURE_ENGINE_AUDIO_PROCESSING_RAW     = 0x00000001,
}
alias MF_CAPTURE_ENGINE_AUDIO_PROCESSING_MODE = int;

enum : int
{
    MF_STANDARD_WORKQUEUE      = 0x00000000,
    MF_WINDOW_WORKQUEUE        = 0x00000001,
    MF_MULTITHREADED_WORKQUEUE = 0x00000002,
}
alias MFASYNC_WORKQUEUE_TYPE = int;

enum : int
{
    MF_TOPOSTATUS_INVALID         = 0x00000000,
    MF_TOPOSTATUS_READY           = 0x00000064,
    MF_TOPOSTATUS_STARTED_SOURCE  = 0x000000c8,
    MF_TOPOSTATUS_DYNAMIC_CHANGED = 0x000000d2,
    MF_TOPOSTATUS_SINK_SWITCHED   = 0x0000012c,
    MF_TOPOSTATUS_ENDED           = 0x00000190,
}
alias MF_TOPOSTATUS = int;

enum MFSampleEncryptionProtectionScheme : int
{
    MF_SAMPLE_ENCRYPTION_PROTECTION_SCHEME_NONE    = 0x00000000,
    MF_SAMPLE_ENCRYPTION_PROTECTION_SCHEME_AES_CTR = 0x00000001,
    MF_SAMPLE_ENCRYPTION_PROTECTION_SCHEME_AES_CBC = 0x00000002,
}

enum : int
{
    MFT_ENUM_FLAG_SYNCMFT                         = 0x00000001,
    MFT_ENUM_FLAG_ASYNCMFT                        = 0x00000002,
    MFT_ENUM_FLAG_HARDWARE                        = 0x00000004,
    MFT_ENUM_FLAG_FIELDOFUSE                      = 0x00000008,
    MFT_ENUM_FLAG_LOCALMFT                        = 0x00000010,
    MFT_ENUM_FLAG_TRANSCODE_ONLY                  = 0x00000020,
    MFT_ENUM_FLAG_SORTANDFILTER                   = 0x00000040,
    MFT_ENUM_FLAG_SORTANDFILTER_APPROVED_ONLY     = 0x000000c0,
    MFT_ENUM_FLAG_SORTANDFILTER_WEB_ONLY          = 0x00000140,
    MFT_ENUM_FLAG_SORTANDFILTER_WEB_ONLY_EDGEMODE = 0x00000240,
    MFT_ENUM_FLAG_UNTRUSTED_STOREMFT              = 0x00000400,
    MFT_ENUM_FLAG_ALL                             = 0x0000003f,
}
alias _MFT_ENUM_FLAG = int;

enum MFFrameSourceTypes : int
{
    MFFrameSourceTypes_Color    = 0x00000001,
    MFFrameSourceTypes_Infrared = 0x00000002,
    MFFrameSourceTypes_Depth    = 0x00000004,
    MFFrameSourceTypes_Image    = 0x00000008,
    MFFrameSourceTypes_Custom   = 0x00000080,
}

enum MFVideo3DFormat : int
{
    MFVideo3DSampleFormat_BaseView         = 0x00000000,
    MFVideo3DSampleFormat_MultiView        = 0x00000001,
    MFVideo3DSampleFormat_Packed_LeftRight = 0x00000002,
    MFVideo3DSampleFormat_Packed_TopBottom = 0x00000003,
}

enum MFVideo3DSampleFormat : int
{
    MFSampleExtension_3DVideo_MultiView = 0x00000001,
    MFSampleExtension_3DVideo_Packed    = 0x00000000,
}

enum MFVideoRotationFormat : int
{
    MFVideoRotationFormat_0   = 0x00000000,
    MFVideoRotationFormat_90  = 0x0000005a,
    MFVideoRotationFormat_180 = 0x000000b4,
    MFVideoRotationFormat_270 = 0x0000010e,
}

enum MFDepthMeasurement : int
{
    DistanceToFocalPlane    = 0x00000000,
    DistanceToOpticalCenter = 0x00000001,
}

enum : int
{
    MF_DECODE_UNIT_NAL = 0x00000000,
    MF_DECODE_UNIT_SEI = 0x00000001,
}
alias MF_CUSTOM_DECODE_UNIT_TYPE = int;

enum MFVideoDRMFlags : int
{
    MFVideoDRMFlag_None               = 0x00000000,
    MFVideoDRMFlag_AnalogProtected    = 0x00000001,
    MFVideoDRMFlag_DigitallyProtected = 0x00000002,
}

enum MFVideoPadFlags : int
{
    MFVideoPadFlag_PAD_TO_None = 0x00000000,
    MFVideoPadFlag_PAD_TO_4x3  = 0x00000001,
    MFVideoPadFlag_PAD_TO_16x9 = 0x00000002,
}

enum MFVideoSrcContentHintFlags : int
{
    MFVideoSrcContentHintFlag_None  = 0x00000000,
    MFVideoSrcContentHintFlag_16x9  = 0x00000001,
    MFVideoSrcContentHintFlag_235_1 = 0x00000002,
}

enum MFWaveFormatExConvertFlags : int
{
    MFWaveFormatExConvertFlag_Normal          = 0x00000000,
    MFWaveFormatExConvertFlag_ForceExtensible = 0x00000001,
}

enum EAllocationType : int
{
    eAllocationTypeDynamic  = 0x00000000,
    eAllocationTypeRT       = 0x00000001,
    eAllocationTypePageable = 0x00000002,
    eAllocationTypeIgnore   = 0x00000003,
}

enum : int
{
    MF_MEDIA_ENGINE_ERR_NOERROR           = 0x00000000,
    MF_MEDIA_ENGINE_ERR_ABORTED           = 0x00000001,
    MF_MEDIA_ENGINE_ERR_NETWORK           = 0x00000002,
    MF_MEDIA_ENGINE_ERR_DECODE            = 0x00000003,
    MF_MEDIA_ENGINE_ERR_SRC_NOT_SUPPORTED = 0x00000004,
    MF_MEDIA_ENGINE_ERR_ENCRYPTED         = 0x00000005,
}
alias MF_MEDIA_ENGINE_ERR = int;

enum : int
{
    MF_MEDIA_ENGINE_EVENT_LOADSTART              = 0x00000001,
    MF_MEDIA_ENGINE_EVENT_PROGRESS               = 0x00000002,
    MF_MEDIA_ENGINE_EVENT_SUSPEND                = 0x00000003,
    MF_MEDIA_ENGINE_EVENT_ABORT                  = 0x00000004,
    MF_MEDIA_ENGINE_EVENT_ERROR                  = 0x00000005,
    MF_MEDIA_ENGINE_EVENT_EMPTIED                = 0x00000006,
    MF_MEDIA_ENGINE_EVENT_STALLED                = 0x00000007,
    MF_MEDIA_ENGINE_EVENT_PLAY                   = 0x00000008,
    MF_MEDIA_ENGINE_EVENT_PAUSE                  = 0x00000009,
    MF_MEDIA_ENGINE_EVENT_LOADEDMETADATA         = 0x0000000a,
    MF_MEDIA_ENGINE_EVENT_LOADEDDATA             = 0x0000000b,
    MF_MEDIA_ENGINE_EVENT_WAITING                = 0x0000000c,
    MF_MEDIA_ENGINE_EVENT_PLAYING                = 0x0000000d,
    MF_MEDIA_ENGINE_EVENT_CANPLAY                = 0x0000000e,
    MF_MEDIA_ENGINE_EVENT_CANPLAYTHROUGH         = 0x0000000f,
    MF_MEDIA_ENGINE_EVENT_SEEKING                = 0x00000010,
    MF_MEDIA_ENGINE_EVENT_SEEKED                 = 0x00000011,
    MF_MEDIA_ENGINE_EVENT_TIMEUPDATE             = 0x00000012,
    MF_MEDIA_ENGINE_EVENT_ENDED                  = 0x00000013,
    MF_MEDIA_ENGINE_EVENT_RATECHANGE             = 0x00000014,
    MF_MEDIA_ENGINE_EVENT_DURATIONCHANGE         = 0x00000015,
    MF_MEDIA_ENGINE_EVENT_VOLUMECHANGE           = 0x00000016,
    MF_MEDIA_ENGINE_EVENT_FORMATCHANGE           = 0x000003e8,
    MF_MEDIA_ENGINE_EVENT_PURGEQUEUEDEVENTS      = 0x000003e9,
    MF_MEDIA_ENGINE_EVENT_TIMELINE_MARKER        = 0x000003ea,
    MF_MEDIA_ENGINE_EVENT_BALANCECHANGE          = 0x000003eb,
    MF_MEDIA_ENGINE_EVENT_DOWNLOADCOMPLETE       = 0x000003ec,
    MF_MEDIA_ENGINE_EVENT_BUFFERINGSTARTED       = 0x000003ed,
    MF_MEDIA_ENGINE_EVENT_BUFFERINGENDED         = 0x000003ee,
    MF_MEDIA_ENGINE_EVENT_FRAMESTEPCOMPLETED     = 0x000003ef,
    MF_MEDIA_ENGINE_EVENT_NOTIFYSTABLESTATE      = 0x000003f0,
    MF_MEDIA_ENGINE_EVENT_FIRSTFRAMEREADY        = 0x000003f1,
    MF_MEDIA_ENGINE_EVENT_TRACKSCHANGE           = 0x000003f2,
    MF_MEDIA_ENGINE_EVENT_OPMINFO                = 0x000003f3,
    MF_MEDIA_ENGINE_EVENT_RESOURCELOST           = 0x000003f4,
    MF_MEDIA_ENGINE_EVENT_DELAYLOADEVENT_CHANGED = 0x000003f5,
    MF_MEDIA_ENGINE_EVENT_STREAMRENDERINGERROR   = 0x000003f6,
    MF_MEDIA_ENGINE_EVENT_SUPPORTEDRATES_CHANGED = 0x000003f7,
    MF_MEDIA_ENGINE_EVENT_AUDIOENDPOINTCHANGE    = 0x000003f8,
}
alias MF_MEDIA_ENGINE_EVENT = int;

enum : int
{
    MF_MEDIA_ENGINE_NETWORK_EMPTY     = 0x00000000,
    MF_MEDIA_ENGINE_NETWORK_IDLE      = 0x00000001,
    MF_MEDIA_ENGINE_NETWORK_LOADING   = 0x00000002,
    MF_MEDIA_ENGINE_NETWORK_NO_SOURCE = 0x00000003,
}
alias MF_MEDIA_ENGINE_NETWORK = int;

enum : int
{
    MF_MEDIA_ENGINE_READY_HAVE_NOTHING      = 0x00000000,
    MF_MEDIA_ENGINE_READY_HAVE_METADATA     = 0x00000001,
    MF_MEDIA_ENGINE_READY_HAVE_CURRENT_DATA = 0x00000002,
    MF_MEDIA_ENGINE_READY_HAVE_FUTURE_DATA  = 0x00000003,
    MF_MEDIA_ENGINE_READY_HAVE_ENOUGH_DATA  = 0x00000004,
}
alias MF_MEDIA_ENGINE_READY = int;

enum : int
{
    MF_MEDIA_ENGINE_CANPLAY_NOT_SUPPORTED = 0x00000000,
    MF_MEDIA_ENGINE_CANPLAY_MAYBE         = 0x00000001,
    MF_MEDIA_ENGINE_CANPLAY_PROBABLY      = 0x00000002,
}
alias MF_MEDIA_ENGINE_CANPLAY = int;

enum : int
{
    MF_MEDIA_ENGINE_PRELOAD_MISSING   = 0x00000000,
    MF_MEDIA_ENGINE_PRELOAD_EMPTY     = 0x00000001,
    MF_MEDIA_ENGINE_PRELOAD_NONE      = 0x00000002,
    MF_MEDIA_ENGINE_PRELOAD_METADATA  = 0x00000003,
    MF_MEDIA_ENGINE_PRELOAD_AUTOMATIC = 0x00000004,
}
alias MF_MEDIA_ENGINE_PRELOAD = int;

enum : int
{
    MF_MEDIA_ENGINE_S3D_PACKING_MODE_NONE         = 0x00000000,
    MF_MEDIA_ENGINE_S3D_PACKING_MODE_SIDE_BY_SIDE = 0x00000001,
    MF_MEDIA_ENGINE_S3D_PACKING_MODE_TOP_BOTTOM   = 0x00000002,
}
alias MF_MEDIA_ENGINE_S3D_PACKING_MODE = int;

enum : int
{
    MF_MEDIA_ENGINE_STATISTIC_FRAMES_RENDERED   = 0x00000000,
    MF_MEDIA_ENGINE_STATISTIC_FRAMES_DROPPED    = 0x00000001,
    MF_MEDIA_ENGINE_STATISTIC_BYTES_DOWNLOADED  = 0x00000002,
    MF_MEDIA_ENGINE_STATISTIC_BUFFER_PROGRESS   = 0x00000003,
    MF_MEDIA_ENGINE_STATISTIC_FRAMES_PER_SECOND = 0x00000004,
    MF_MEDIA_ENGINE_STATISTIC_PLAYBACK_JITTER   = 0x00000005,
    MF_MEDIA_ENGINE_STATISTIC_FRAMES_CORRUPTED  = 0x00000006,
    MF_MEDIA_ENGINE_STATISTIC_TOTAL_FRAME_DELAY = 0x00000007,
}
alias MF_MEDIA_ENGINE_STATISTIC = int;

enum : int
{
    MF_MEDIA_ENGINE_SEEK_MODE_NORMAL      = 0x00000000,
    MF_MEDIA_ENGINE_SEEK_MODE_APPROXIMATE = 0x00000001,
}
alias MF_MEDIA_ENGINE_SEEK_MODE = int;

enum : int
{
    MF_MEDIA_ENGINE_EXTENSION_TYPE_MEDIASOURCE = 0x00000000,
    MF_MEDIA_ENGINE_EXTENSION_TYPE_BYTESTREAM  = 0x00000001,
}
alias MF_MEDIA_ENGINE_EXTENSION_TYPE = int;

enum : int
{
    MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_PROTECTED                              = 0x00000001,
    MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_REQUIRES_SURFACE_PROTECTION            = 0x00000002,
    MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_REQUIRES_ANTI_SCREEN_SCRAPE_PROTECTION = 0x00000004,
}
alias MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAGS = int;

enum : int
{
    MF_MSE_VP9_SUPPORT_DEFAULT = 0x00000000,
    MF_MSE_VP9_SUPPORT_ON      = 0x00000001,
    MF_MSE_VP9_SUPPORT_OFF     = 0x00000002,
}
alias MF_MSE_VP9_SUPPORT_TYPE = int;

enum : int
{
    MF_MSE_OPUS_SUPPORT_ON  = 0x00000000,
    MF_MSE_OPUS_SUPPORT_OFF = 0x00000001,
}
alias MF_MSE_OPUS_SUPPORT_TYPE = int;

enum : int
{
    MF_MSE_APPEND_MODE_SEGMENTS = 0x00000000,
    MF_MSE_APPEND_MODE_SEQUENCE = 0x00000001,
}
alias MF_MSE_APPEND_MODE = int;

enum : int
{
    MF_MSE_READY_CLOSED = 0x00000001,
    MF_MSE_READY_OPEN   = 0x00000002,
    MF_MSE_READY_ENDED  = 0x00000003,
}
alias MF_MSE_READY = int;

enum : int
{
    MF_MSE_ERROR_NOERROR       = 0x00000000,
    MF_MSE_ERROR_NETWORK       = 0x00000001,
    MF_MSE_ERROR_DECODE        = 0x00000002,
    MF_MSE_ERROR_UNKNOWN_ERROR = 0x00000003,
}
alias MF_MSE_ERROR = int;

enum : int
{
    MF_MEDIAENGINE_KEYERR_UNKNOWN        = 0x00000001,
    MF_MEDIAENGINE_KEYERR_CLIENT         = 0x00000002,
    MF_MEDIAENGINE_KEYERR_SERVICE        = 0x00000003,
    MF_MEDIAENGINE_KEYERR_OUTPUT         = 0x00000004,
    MF_MEDIAENGINE_KEYERR_HARDWARECHANGE = 0x00000005,
    MF_MEDIAENGINE_KEYERR_DOMAIN         = 0x00000006,
}
alias MF_MEDIA_ENGINE_KEYERR = int;

enum : int
{
    MF_HDCP_STATUS_ON                       = 0x00000000,
    MF_HDCP_STATUS_OFF                      = 0x00000001,
    MF_HDCP_STATUS_ON_WITH_TYPE_ENFORCEMENT = 0x00000002,
}
alias MF_HDCP_STATUS = int;

enum : int
{
    MF_MEDIA_ENGINE_OPM_NOT_REQUESTED          = 0x00000000,
    MF_MEDIA_ENGINE_OPM_ESTABLISHED            = 0x00000001,
    MF_MEDIA_ENGINE_OPM_FAILED_VM              = 0x00000002,
    MF_MEDIA_ENGINE_OPM_FAILED_BDA             = 0x00000003,
    MF_MEDIA_ENGINE_OPM_FAILED_UNSIGNED_DRIVER = 0x00000004,
    MF_MEDIA_ENGINE_OPM_FAILED                 = 0x00000005,
}
alias MF_MEDIA_ENGINE_OPM_STATUS = int;

enum : int
{
    MF_MEDIA_ENGINE_AUDIOONLY             = 0x00000001,
    MF_MEDIA_ENGINE_WAITFORSTABLE_STATE   = 0x00000002,
    MF_MEDIA_ENGINE_FORCEMUTE             = 0x00000004,
    MF_MEDIA_ENGINE_REAL_TIME_MODE        = 0x00000008,
    MF_MEDIA_ENGINE_DISABLE_LOCAL_PLUGINS = 0x00000010,
    MF_MEDIA_ENGINE_CREATEFLAGS_MASK      = 0x0000001f,
}
alias MF_MEDIA_ENGINE_CREATEFLAGS = int;

enum : int
{
    MF_MEDIA_ENGINE_ENABLE_PROTECTED_CONTENT = 0x00000001,
    MF_MEDIA_ENGINE_USE_PMP_FOR_ALL_CONTENT  = 0x00000002,
    MF_MEDIA_ENGINE_USE_UNPROTECTED_PMP      = 0x00000004,
}
alias MF_MEDIA_ENGINE_PROTECTION_FLAGS = int;

enum : int
{
    MF_TIMED_TEXT_TRACK_KIND_UNKNOWN   = 0x00000000,
    MF_TIMED_TEXT_TRACK_KIND_SUBTITLES = 0x00000001,
    MF_TIMED_TEXT_TRACK_KIND_CAPTIONS  = 0x00000002,
    MF_TIMED_TEXT_TRACK_KIND_METADATA  = 0x00000003,
}
alias MF_TIMED_TEXT_TRACK_KIND = int;

enum : int
{
    MF_TIMED_TEXT_UNIT_TYPE_PIXELS     = 0x00000000,
    MF_TIMED_TEXT_UNIT_TYPE_PERCENTAGE = 0x00000001,
}
alias MF_TIMED_TEXT_UNIT_TYPE = int;

enum : int
{
    MF_TIMED_TEXT_FONT_STYLE_NORMAL  = 0x00000000,
    MF_TIMED_TEXT_FONT_STYLE_OBLIQUE = 0x00000001,
    MF_TIMED_TEXT_FONT_STYLE_ITALIC  = 0x00000002,
}
alias MF_TIMED_TEXT_FONT_STYLE = int;

enum : int
{
    MF_TIMED_TEXT_ALIGNMENT_START  = 0x00000000,
    MF_TIMED_TEXT_ALIGNMENT_END    = 0x00000001,
    MF_TIMED_TEXT_ALIGNMENT_CENTER = 0x00000002,
}
alias MF_TIMED_TEXT_ALIGNMENT = int;

enum : int
{
    MF_TIMED_TEXT_DISPLAY_ALIGNMENT_BEFORE = 0x00000000,
    MF_TIMED_TEXT_DISPLAY_ALIGNMENT_AFTER  = 0x00000001,
    MF_TIMED_TEXT_DISPLAY_ALIGNMENT_CENTER = 0x00000002,
}
alias MF_TIMED_TEXT_DISPLAY_ALIGNMENT = int;

enum : int
{
    MF_TIMED_TEXT_DECORATION_NONE         = 0x00000000,
    MF_TIMED_TEXT_DECORATION_UNDERLINE    = 0x00000001,
    MF_TIMED_TEXT_DECORATION_LINE_THROUGH = 0x00000002,
    MF_TIMED_TEXT_DECORATION_OVERLINE     = 0x00000004,
}
alias MF_TIMED_TEXT_DECORATION = int;

enum : int
{
    MF_TIMED_TEXT_WRITING_MODE_LRTB = 0x00000000,
    MF_TIMED_TEXT_WRITING_MODE_RLTB = 0x00000001,
    MF_TIMED_TEXT_WRITING_MODE_TBRL = 0x00000002,
    MF_TIMED_TEXT_WRITING_MODE_TBLR = 0x00000003,
    MF_TIMED_TEXT_WRITING_MODE_LR   = 0x00000004,
    MF_TIMED_TEXT_WRITING_MODE_RL   = 0x00000005,
    MF_TIMED_TEXT_WRITING_MODE_TB   = 0x00000006,
}
alias MF_TIMED_TEXT_WRITING_MODE = int;

enum : int
{
    MF_TIMED_TEXT_SCROLL_MODE_POP_ON  = 0x00000000,
    MF_TIMED_TEXT_SCROLL_MODE_ROLL_UP = 0x00000001,
}
alias MF_TIMED_TEXT_SCROLL_MODE = int;

enum : int
{
    MF_TIMED_TEXT_ERROR_CODE_NOERROR     = 0x00000000,
    MF_TIMED_TEXT_ERROR_CODE_FATAL       = 0x00000001,
    MF_TIMED_TEXT_ERROR_CODE_DATA_FORMAT = 0x00000002,
    MF_TIMED_TEXT_ERROR_CODE_NETWORK     = 0x00000003,
    MF_TIMED_TEXT_ERROR_CODE_INTERNAL    = 0x00000004,
}
alias MF_TIMED_TEXT_ERROR_CODE = int;

enum : int
{
    MF_TIMED_TEXT_CUE_EVENT_ACTIVE   = 0x00000000,
    MF_TIMED_TEXT_CUE_EVENT_INACTIVE = 0x00000001,
    MF_TIMED_TEXT_CUE_EVENT_CLEAR    = 0x00000002,
}
alias MF_TIMED_TEXT_CUE_EVENT = int;

enum : int
{
    MF_TIMED_TEXT_TRACK_READY_STATE_NONE    = 0x00000000,
    MF_TIMED_TEXT_TRACK_READY_STATE_LOADING = 0x00000001,
    MF_TIMED_TEXT_TRACK_READY_STATE_LOADED  = 0x00000002,
    MF_TIMED_TEXT_TRACK_READY_STATE_ERROR   = 0x00000003,
}
alias MF_TIMED_TEXT_TRACK_READY_STATE = int;

enum : int
{
    MF_MEDIA_ENGINE_STREAMTYPE_FAILED_UNKNOWN = 0x00000000,
    MF_MEDIA_ENGINE_STREAMTYPE_FAILED_AUDIO   = 0x00000001,
    MF_MEDIA_ENGINE_STREAMTYPE_FAILED_VIDEO   = 0x00000002,
}
alias MF_MEDIA_ENGINE_STREAMTYPE_FAILED = int;

enum : int
{
    MF_MEDIAKEYS_REQUIREMENT_REQUIRED    = 0x00000001,
    MF_MEDIAKEYS_REQUIREMENT_OPTIONAL    = 0x00000002,
    MF_MEDIAKEYS_REQUIREMENT_NOT_ALLOWED = 0x00000003,
}
alias MF_MEDIAKEYS_REQUIREMENT = int;

enum : int
{
    MF_SOURCE_READERF_ERROR                   = 0x00000001,
    MF_SOURCE_READERF_ENDOFSTREAM             = 0x00000002,
    MF_SOURCE_READERF_NEWSTREAM               = 0x00000004,
    MF_SOURCE_READERF_NATIVEMEDIATYPECHANGED  = 0x00000010,
    MF_SOURCE_READERF_CURRENTMEDIATYPECHANGED = 0x00000020,
    MF_SOURCE_READERF_STREAMTICK              = 0x00000100,
    MF_SOURCE_READERF_ALLEFFECTSREMOVED       = 0x00000200,
}
alias MF_SOURCE_READER_FLAG = int;

enum : int
{
    MF_SOURCE_READER_CONTROLF_DRAIN = 0x00000001,
}
alias MF_SOURCE_READER_CONTROL_FLAG = int;

enum : int
{
    MF_SOURCE_READER_INVALID_STREAM_INDEX = 0xffffffff,
    MF_SOURCE_READER_ALL_STREAMS          = 0xfffffffe,
    MF_SOURCE_READER_ANY_STREAM           = 0xfffffffe,
    MF_SOURCE_READER_FIRST_AUDIO_STREAM   = 0xfffffffd,
    MF_SOURCE_READER_FIRST_VIDEO_STREAM   = 0xfffffffc,
    MF_SOURCE_READER_MEDIASOURCE          = 0xffffffff,
}
alias __MIDL___MIDL_itf_mfreadwrite_0000_0001_0001 = int;

enum : int
{
    MF_SOURCE_READER_CURRENT_TYPE_INDEX = 0xffffffff,
}
alias __MIDL___MIDL_itf_mfreadwrite_0000_0001_0002 = int;

enum : int
{
    MF_SINK_WRITER_INVALID_STREAM_INDEX = 0xffffffff,
    MF_SINK_WRITER_ALL_STREAMS          = 0xfffffffe,
    MF_SINK_WRITER_MEDIASINK            = 0xffffffff,
}
alias __MIDL___MIDL_itf_mfreadwrite_0000_0005_0001 = int;

enum MFVideoAspectRatioMode : int
{
    MFVideoARMode_None             = 0x00000000,
    MFVideoARMode_PreservePicture  = 0x00000001,
    MFVideoARMode_PreservePixel    = 0x00000002,
    MFVideoARMode_NonLinearStretch = 0x00000004,
    MFVideoARMode_Mask             = 0x00000007,
}

enum MFVideoRenderPrefs : int
{
    MFVideoRenderPrefs_DoNotRenderBorder     = 0x00000001,
    MFVideoRenderPrefs_DoNotClipToDevice     = 0x00000002,
    MFVideoRenderPrefs_AllowOutputThrottling = 0x00000004,
    MFVideoRenderPrefs_ForceOutputThrottling = 0x00000008,
    MFVideoRenderPrefs_ForceBatching         = 0x00000010,
    MFVideoRenderPrefs_AllowBatching         = 0x00000020,
    MFVideoRenderPrefs_ForceScaling          = 0x00000040,
    MFVideoRenderPrefs_AllowScaling          = 0x00000080,
    MFVideoRenderPrefs_DoNotRepaintOnStop    = 0x00000100,
    MFVideoRenderPrefs_Mask                  = 0x000001ff,
}

enum : int
{
    MFVP_MESSAGE_FLUSH               = 0x00000000,
    MFVP_MESSAGE_INVALIDATEMEDIATYPE = 0x00000001,
    MFVP_MESSAGE_PROCESSINPUTNOTIFY  = 0x00000002,
    MFVP_MESSAGE_BEGINSTREAMING      = 0x00000003,
    MFVP_MESSAGE_ENDSTREAMING        = 0x00000004,
    MFVP_MESSAGE_ENDOFSTREAM         = 0x00000005,
    MFVP_MESSAGE_STEP                = 0x00000006,
    MFVP_MESSAGE_CANCELSTEP          = 0x00000007,
}
alias MFVP_MESSAGE_TYPE = int;

enum MFVideoMixPrefs : int
{
    MFVideoMixPrefs_ForceHalfInterlace       = 0x00000001,
    MFVideoMixPrefs_AllowDropToHalfInterlace = 0x00000002,
    MFVideoMixPrefs_AllowDropToBob           = 0x00000004,
    MFVideoMixPrefs_ForceBob                 = 0x00000008,
    MFVideoMixPrefs_EnableRotation           = 0x00000010,
    MFVideoMixPrefs_Mask                     = 0x0000001f,
}

enum EVRFilterConfigPrefs : int
{
    EVRFilterConfigPrefs_EnableQoS = 0x00000001,
    EVRFilterConfigPrefs_Mask      = 0x00000001,
}

enum : int
{
    MF_SERVICE_LOOKUP_UPSTREAM          = 0x00000000,
    MF_SERVICE_LOOKUP_UPSTREAM_DIRECT   = 0x00000001,
    MF_SERVICE_LOOKUP_DOWNSTREAM        = 0x00000002,
    MF_SERVICE_LOOKUP_DOWNSTREAM_DIRECT = 0x00000003,
    MF_SERVICE_LOOKUP_ALL               = 0x00000004,
    MF_SERVICE_LOOKUP_GLOBAL            = 0x00000005,
}
alias MF_SERVICE_LOOKUP_TYPE = int;

enum : int
{
    MFP_OPTION_NONE                           = 0x00000000,
    MFP_OPTION_FREE_THREADED_CALLBACK         = 0x00000001,
    MFP_OPTION_NO_MMCSS                       = 0x00000002,
    MFP_OPTION_NO_REMOTE_DESKTOP_OPTIMIZATION = 0x00000004,
}
alias MFP_CREATION_OPTIONS = int;

enum : int
{
    MFP_MEDIAPLAYER_STATE_EMPTY    = 0x00000000,
    MFP_MEDIAPLAYER_STATE_STOPPED  = 0x00000001,
    MFP_MEDIAPLAYER_STATE_PLAYING  = 0x00000002,
    MFP_MEDIAPLAYER_STATE_PAUSED   = 0x00000003,
    MFP_MEDIAPLAYER_STATE_SHUTDOWN = 0x00000004,
}
alias MFP_MEDIAPLAYER_STATE = int;

enum : int
{
    MFP_MEDIAITEM_IS_LIVE       = 0x00000001,
    MFP_MEDIAITEM_CAN_SEEK      = 0x00000002,
    MFP_MEDIAITEM_CAN_PAUSE     = 0x00000004,
    MFP_MEDIAITEM_HAS_SLOW_SEEK = 0x00000008,
}
alias _MFP_MEDIAITEM_CHARACTERISTICS = int;

enum : int
{
    MFP_CREDENTIAL_PROMPT         = 0x00000001,
    MFP_CREDENTIAL_SAVE           = 0x00000002,
    MFP_CREDENTIAL_DO_NOT_CACHE   = 0x00000004,
    MFP_CREDENTIAL_CLEAR_TEXT     = 0x00000008,
    MFP_CREDENTIAL_PROXY          = 0x00000010,
    MFP_CREDENTIAL_LOGGED_ON_USER = 0x00000020,
}
alias _MFP_CREDENTIAL_FLAGS = int;

enum : int
{
    MFP_EVENT_TYPE_PLAY                    = 0x00000000,
    MFP_EVENT_TYPE_PAUSE                   = 0x00000001,
    MFP_EVENT_TYPE_STOP                    = 0x00000002,
    MFP_EVENT_TYPE_POSITION_SET            = 0x00000003,
    MFP_EVENT_TYPE_RATE_SET                = 0x00000004,
    MFP_EVENT_TYPE_MEDIAITEM_CREATED       = 0x00000005,
    MFP_EVENT_TYPE_MEDIAITEM_SET           = 0x00000006,
    MFP_EVENT_TYPE_FRAME_STEP              = 0x00000007,
    MFP_EVENT_TYPE_MEDIAITEM_CLEARED       = 0x00000008,
    MFP_EVENT_TYPE_MF                      = 0x00000009,
    MFP_EVENT_TYPE_ERROR                   = 0x0000000a,
    MFP_EVENT_TYPE_PLAYBACK_ENDED          = 0x0000000b,
    MFP_EVENT_TYPE_ACQUIRE_USER_CREDENTIAL = 0x0000000c,
}
alias MFP_EVENT_TYPE = int;

enum : int
{
    MF_SHARING_ENGINE_EVENT_DISCONNECT            = 0x000007d0,
    MF_SHARING_ENGINE_EVENT_LOCALRENDERINGSTARTED = 0x000007d1,
    MF_SHARING_ENGINE_EVENT_LOCALRENDERINGENDED   = 0x000007d2,
    MF_SHARING_ENGINE_EVENT_STOPPED               = 0x000007d3,
    MF_SHARING_ENGINE_EVENT_ERROR                 = 0x000009c5,
}
alias MF_SHARING_ENGINE_EVENT = int;

enum : int
{
    MF_MEDIA_SHARING_ENGINE_EVENT_DISCONNECT = 0x000007d0,
}
alias MF_MEDIA_SHARING_ENGINE_EVENT = int;

enum : int
{
    PLAYTO_SOURCE_NONE      = 0x00000000,
    PLAYTO_SOURCE_IMAGE     = 0x00000001,
    PLAYTO_SOURCE_AUDIO     = 0x00000002,
    PLAYTO_SOURCE_VIDEO     = 0x00000004,
    PLAYTO_SOURCE_PROTECTED = 0x00000008,
}
alias PLAYTO_SOURCE_CREATEFLAGS = int;

enum MFVideoAlphaBitmapFlags : int
{
    MFVideoAlphaBitmap_EntireDDS   = 0x00000001,
    MFVideoAlphaBitmap_SrcColorKey = 0x00000002,
    MFVideoAlphaBitmap_SrcRect     = 0x00000004,
    MFVideoAlphaBitmap_DestRect    = 0x00000008,
    MFVideoAlphaBitmap_FilterMode  = 0x00000010,
    MFVideoAlphaBitmap_Alpha       = 0x00000020,
    MFVideoAlphaBitmap_BitMask     = 0x0000003f,
}

enum : int
{
    D3D11_VIDEO_DECODER_BUFFER_PICTURE_PARAMETERS          = 0x00000000,
    D3D11_VIDEO_DECODER_BUFFER_MACROBLOCK_CONTROL          = 0x00000001,
    D3D11_VIDEO_DECODER_BUFFER_RESIDUAL_DIFFERENCE         = 0x00000002,
    D3D11_VIDEO_DECODER_BUFFER_DEBLOCKING_CONTROL          = 0x00000003,
    D3D11_VIDEO_DECODER_BUFFER_INVERSE_QUANTIZATION_MATRIX = 0x00000004,
    D3D11_VIDEO_DECODER_BUFFER_SLICE_CONTROL               = 0x00000005,
    D3D11_VIDEO_DECODER_BUFFER_BITSTREAM                   = 0x00000006,
    D3D11_VIDEO_DECODER_BUFFER_MOTION_VECTOR               = 0x00000007,
    D3D11_VIDEO_DECODER_BUFFER_FILM_GRAIN                  = 0x00000008,
}
alias D3D11_VIDEO_DECODER_BUFFER_TYPE = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT_INPUT  = 0x00000001,
    D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT_OUTPUT = 0x00000002,
}
alias D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_LINEAR_SPACE            = 0x00000001,
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_xvYCC                   = 0x00000002,
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_RGB_RANGE_CONVERSION    = 0x00000004,
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_YCbCr_MATRIX_CONVERSION = 0x00000008,
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_NOMINAL_RANGE           = 0x00000010,
}
alias D3D11_VIDEO_PROCESSOR_DEVICE_CAPS = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_FILL         = 0x00000001,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_CONSTRICTION       = 0x00000002,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_LUMA_KEY           = 0x00000004,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_PALETTE      = 0x00000008,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_LEGACY             = 0x00000010,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_STEREO             = 0x00000020,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ROTATION           = 0x00000040,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_STREAM       = 0x00000080,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_PIXEL_ASPECT_RATIO = 0x00000100,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_MIRROR             = 0x00000200,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_SHADER_USAGE       = 0x00000400,
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_METADATA_HDR10     = 0x00000800,
}
alias D3D11_VIDEO_PROCESSOR_FEATURE_CAPS = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_BRIGHTNESS         = 0x00000001,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_CONTRAST           = 0x00000002,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_HUE                = 0x00000004,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_SATURATION         = 0x00000008,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_NOISE_REDUCTION    = 0x00000010,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_EDGE_ENHANCEMENT   = 0x00000020,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_ANAMORPHIC_SCALING = 0x00000040,
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_STEREO_ADJUSTMENT  = 0x00000080,
}
alias D3D11_VIDEO_PROCESSOR_FILTER_CAPS = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_INTERLACED     = 0x00000001,
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_PROCAMP        = 0x00000002,
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_LUMA_KEY       = 0x00000004,
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_PALETTE_INTERLACED = 0x00000008,
}
alias D3D11_VIDEO_PROCESSOR_FORMAT_CAPS = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_DENOISE             = 0x00000001,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_DERINGING           = 0x00000002,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_EDGE_ENHANCEMENT    = 0x00000004,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_COLOR_CORRECTION    = 0x00000008,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_FLESH_TONE_MAPPING  = 0x00000010,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_IMAGE_STABILIZATION = 0x00000020,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_SUPER_RESOLUTION    = 0x00000040,
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_ANAMORPHIC_SCALING  = 0x00000080,
}
alias D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_MONO_OFFSET        = 0x00000001,
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_ROW_INTERLEAVED    = 0x00000002,
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_COLUMN_INTERLEAVED = 0x00000004,
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_CHECKERBOARD       = 0x00000008,
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_FLIP_MODE          = 0x00000010,
}
alias D3D11_VIDEO_PROCESSOR_STEREO_CAPS = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_BLEND               = 0x00000001,
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_BOB                 = 0x00000002,
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_ADAPTIVE            = 0x00000004,
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_MOTION_COMPENSATION = 0x00000008,
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_INVERSE_TELECINE                = 0x00000010,
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_FRAME_RATE_CONVERSION           = 0x00000020,
}
alias D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_32           = 0x00000001,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_22           = 0x00000002,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_2224         = 0x00000004,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_2332         = 0x00000008,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_32322        = 0x00000010,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_55           = 0x00000020,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_64           = 0x00000040,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_87           = 0x00000080,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_222222222223 = 0x00000100,
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_OTHER        = 0x80000000,
}
alias D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS = int;

enum : int
{
    D3D11_CONTENT_PROTECTION_CAPS_SOFTWARE                                  = 0x00000001,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE                                  = 0x00000002,
    D3D11_CONTENT_PROTECTION_CAPS_PROTECTION_ALWAYS_ON                      = 0x00000004,
    D3D11_CONTENT_PROTECTION_CAPS_PARTIAL_DECRYPTION                        = 0x00000008,
    D3D11_CONTENT_PROTECTION_CAPS_CONTENT_KEY                               = 0x00000010,
    D3D11_CONTENT_PROTECTION_CAPS_FRESHEN_SESSION_KEY                       = 0x00000020,
    D3D11_CONTENT_PROTECTION_CAPS_ENCRYPTED_READ_BACK                       = 0x00000040,
    D3D11_CONTENT_PROTECTION_CAPS_ENCRYPTED_READ_BACK_KEY                   = 0x00000080,
    D3D11_CONTENT_PROTECTION_CAPS_SEQUENTIAL_CTR_IV                         = 0x00000100,
    D3D11_CONTENT_PROTECTION_CAPS_ENCRYPT_SLICEDATA_ONLY                    = 0x00000200,
    D3D11_CONTENT_PROTECTION_CAPS_DECRYPTION_BLT                            = 0x00000400,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_PROTECT_UNCOMPRESSED             = 0x00000800,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_PROTECTED_MEMORY_PAGEABLE        = 0x00001000,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_TEARDOWN                         = 0x00002000,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_DRM_COMMUNICATION                = 0x00004000,
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_DRM_COMMUNICATION_MULTI_THREADED = 0x00008000,
}
alias D3D11_CONTENT_PROTECTION_CAPS = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_FILTER_BRIGHTNESS         = 0x00000000,
    D3D11_VIDEO_PROCESSOR_FILTER_CONTRAST           = 0x00000001,
    D3D11_VIDEO_PROCESSOR_FILTER_HUE                = 0x00000002,
    D3D11_VIDEO_PROCESSOR_FILTER_SATURATION         = 0x00000003,
    D3D11_VIDEO_PROCESSOR_FILTER_NOISE_REDUCTION    = 0x00000004,
    D3D11_VIDEO_PROCESSOR_FILTER_EDGE_ENHANCEMENT   = 0x00000005,
    D3D11_VIDEO_PROCESSOR_FILTER_ANAMORPHIC_SCALING = 0x00000006,
    D3D11_VIDEO_PROCESSOR_FILTER_STEREO_ADJUSTMENT  = 0x00000007,
}
alias D3D11_VIDEO_PROCESSOR_FILTER = int;

enum : int
{
    D3D11_VIDEO_FRAME_FORMAT_PROGRESSIVE                   = 0x00000000,
    D3D11_VIDEO_FRAME_FORMAT_INTERLACED_TOP_FIELD_FIRST    = 0x00000001,
    D3D11_VIDEO_FRAME_FORMAT_INTERLACED_BOTTOM_FIELD_FIRST = 0x00000002,
}
alias D3D11_VIDEO_FRAME_FORMAT = int;

enum : int
{
    D3D11_VIDEO_USAGE_PLAYBACK_NORMAL = 0x00000000,
    D3D11_VIDEO_USAGE_OPTIMAL_SPEED   = 0x00000001,
    D3D11_VIDEO_USAGE_OPTIMAL_QUALITY = 0x00000002,
}
alias D3D11_VIDEO_USAGE = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_UNDEFINED = 0x00000000,
    D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_16_235    = 0x00000001,
    D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_0_255     = 0x00000002,
}
alias D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_OPAQUE        = 0x00000000,
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_BACKGROUND    = 0x00000001,
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_DESTINATION   = 0x00000002,
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_SOURCE_STREAM = 0x00000003,
}
alias D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_NORMAL = 0x00000000,
    D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_HALF   = 0x00000001,
    D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_CUSTOM = 0x00000002,
}
alias D3D11_VIDEO_PROCESSOR_OUTPUT_RATE = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_MONO               = 0x00000000,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_HORIZONTAL         = 0x00000001,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_VERTICAL           = 0x00000002,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_SEPARATE           = 0x00000003,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_MONO_OFFSET        = 0x00000004,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_ROW_INTERLEAVED    = 0x00000005,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_COLUMN_INTERLEAVED = 0x00000006,
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_CHECKERBOARD       = 0x00000007,
}
alias D3D11_VIDEO_PROCESSOR_STEREO_FORMAT = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_STEREO_FLIP_NONE   = 0x00000000,
    D3D11_VIDEO_PROCESSOR_STEREO_FLIP_FRAME0 = 0x00000001,
    D3D11_VIDEO_PROCESSOR_STEREO_FLIP_FRAME1 = 0x00000002,
}
alias D3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_ROTATION_IDENTITY = 0x00000000,
    D3D11_VIDEO_PROCESSOR_ROTATION_90       = 0x00000001,
    D3D11_VIDEO_PROCESSOR_ROTATION_180      = 0x00000002,
    D3D11_VIDEO_PROCESSOR_ROTATION_270      = 0x00000003,
}
alias D3D11_VIDEO_PROCESSOR_ROTATION = int;

enum : int
{
    D3D11_AUTHENTICATED_CHANNEL_D3D11           = 0x00000001,
    D3D11_AUTHENTICATED_CHANNEL_DRIVER_SOFTWARE = 0x00000002,
    D3D11_AUTHENTICATED_CHANNEL_DRIVER_HARDWARE = 0x00000003,
}
alias D3D11_AUTHENTICATED_CHANNEL_TYPE = int;

enum : int
{
    D3D11_PROCESSIDTYPE_UNKNOWN = 0x00000000,
    D3D11_PROCESSIDTYPE_DWM     = 0x00000001,
    D3D11_PROCESSIDTYPE_HANDLE  = 0x00000002,
}
alias D3D11_AUTHENTICATED_PROCESS_IDENTIFIER_TYPE = int;

enum : int
{
    D3D11_BUS_TYPE_OTHER                                            = 0x00000000,
    D3D11_BUS_TYPE_PCI                                              = 0x00000001,
    D3D11_BUS_TYPE_PCIX                                             = 0x00000002,
    D3D11_BUS_TYPE_PCIEXPRESS                                       = 0x00000003,
    D3D11_BUS_TYPE_AGP                                              = 0x00000004,
    D3D11_BUS_IMPL_MODIFIER_INSIDE_OF_CHIPSET                       = 0x00010000,
    D3D11_BUS_IMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_CHIP          = 0x00020000,
    D3D11_BUS_IMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_SOCKET        = 0x00030000,
    D3D11_BUS_IMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR                = 0x00040000,
    D3D11_BUS_IMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR_INSIDE_OF_NUAE = 0x00050000,
    D3D11_BUS_IMPL_MODIFIER_NON_STANDARD                            = 0x80000000,
}
alias D3D11_BUS_TYPE = int;

enum : int
{
    D3D11_VDOV_DIMENSION_UNKNOWN   = 0x00000000,
    D3D11_VDOV_DIMENSION_TEXTURE2D = 0x00000001,
}
alias D3D11_VDOV_DIMENSION = int;

enum : int
{
    D3D11_VPIV_DIMENSION_UNKNOWN   = 0x00000000,
    D3D11_VPIV_DIMENSION_TEXTURE2D = 0x00000001,
}
alias D3D11_VPIV_DIMENSION = int;

enum : int
{
    D3D11_VPOV_DIMENSION_UNKNOWN        = 0x00000000,
    D3D11_VPOV_DIMENSION_TEXTURE2D      = 0x00000001,
    D3D11_VPOV_DIMENSION_TEXTURE2DARRAY = 0x00000002,
}
alias D3D11_VPOV_DIMENSION = int;

enum : int
{
    D3D11_VIDEO_DECODER_CAPS_DOWNSAMPLE          = 0x00000001,
    D3D11_VIDEO_DECODER_CAPS_NON_REAL_TIME       = 0x00000002,
    D3D11_VIDEO_DECODER_CAPS_DOWNSAMPLE_DYNAMIC  = 0x00000004,
    D3D11_VIDEO_DECODER_CAPS_DOWNSAMPLE_REQUIRED = 0x00000008,
    D3D11_VIDEO_DECODER_CAPS_UNSUPPORTED         = 0x00000010,
}
alias D3D11_VIDEO_DECODER_CAPS = int;

enum : int
{
    D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_MULTIPLANE_OVERLAY_ROTATION               = 0x00000001,
    D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_MULTIPLANE_OVERLAY_RESIZE                 = 0x00000002,
    D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_MULTIPLANE_OVERLAY_COLOR_SPACE_CONVERSION = 0x00000004,
    D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_TRIPLE_BUFFER_OUTPUT                      = 0x00000008,
}
alias D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINTS = int;

enum : int
{
    D3D11_CRYPTO_SESSION_STATUS_OK                   = 0x00000000,
    D3D11_CRYPTO_SESSION_STATUS_KEY_LOST             = 0x00000001,
    D3D11_CRYPTO_SESSION_STATUS_KEY_AND_CONTENT_LOST = 0x00000002,
}
alias D3D11_CRYPTO_SESSION_STATUS = int;

enum : int
{
    D3D11_FEATURE_VIDEO_DECODER_HISTOGRAM = 0x00000000,
}
alias D3D11_FEATURE_VIDEO = int;

// Constants


enum const(wchar)* g_wszSpeechFormatCaps = "SpeechFormatCap";
enum const(wchar)* g_wszWMCPSupportedVBRModes = "_SUPPORTEDVBRMODES";
enum const(wchar)* g_wszWMCPAudioVBRQuality = "_VBRQUALITY";
enum const(wchar)* g_wszWMCPDefaultCrisp = "_DEFAULTCRISP";

enum : int
{
    COPP_ProtectionType_None     = 0x00000000,
    COPP_ProtectionType_HDCP     = 0x00000001,
    COPP_ProtectionType_ACP      = 0x00000002,
    COPP_ProtectionType_CGMSA    = 0x00000004,
    COPP_ProtectionType_Mask     = 0x80000007,
    COPP_ProtectionType_Reserved = 0x7ffffff8,
}

// Callbacks

alias PDXVAHDSW_CreateDevice = HRESULT function(IDirect3DDevice9Ex pD3DDevice, HANDLE* phDevice);
alias PDXVAHDSW_ProposeVideoPrivateFormat = HRESULT function(HANDLE hDevice, D3DFORMAT* pFormat);
alias PDXVAHDSW_GetVideoProcessorDeviceCaps = HRESULT function(HANDLE hDevice, 
                                                               const(DXVAHD_CONTENT_DESC)* pContentDesc, 
                                                               DXVAHD_DEVICE_USAGE Usage, DXVAHD_VPDEVCAPS* pCaps);
alias PDXVAHDSW_GetVideoProcessorOutputFormats = HRESULT function(HANDLE hDevice, 
                                                                  const(DXVAHD_CONTENT_DESC)* pContentDesc, 
                                                                  DXVAHD_DEVICE_USAGE Usage, uint Count, 
                                                                  char* pFormats);
alias PDXVAHDSW_GetVideoProcessorInputFormats = HRESULT function(HANDLE hDevice, 
                                                                 const(DXVAHD_CONTENT_DESC)* pContentDesc, 
                                                                 DXVAHD_DEVICE_USAGE Usage, uint Count, 
                                                                 char* pFormats);
alias PDXVAHDSW_GetVideoProcessorCaps = HRESULT function(HANDLE hDevice, const(DXVAHD_CONTENT_DESC)* pContentDesc, 
                                                         DXVAHD_DEVICE_USAGE Usage, uint Count, char* pCaps);
alias PDXVAHDSW_GetVideoProcessorCustomRates = HRESULT function(HANDLE hDevice, const(GUID)* pVPGuid, uint Count, 
                                                                char* pRates);
alias PDXVAHDSW_GetVideoProcessorFilterRange = HRESULT function(HANDLE hDevice, DXVAHD_FILTER Filter, 
                                                                DXVAHD_FILTER_RANGE_DATA* pRange);
alias PDXVAHDSW_DestroyDevice = HRESULT function(HANDLE hDevice);
alias PDXVAHDSW_CreateVideoProcessor = HRESULT function(HANDLE hDevice, const(GUID)* pVPGuid, 
                                                        HANDLE* phVideoProcessor);
alias PDXVAHDSW_SetVideoProcessBltState = HRESULT function(HANDLE hVideoProcessor, DXVAHD_BLT_STATE State, 
                                                           uint DataSize, char* pData);
alias PDXVAHDSW_GetVideoProcessBltStatePrivate = HRESULT function(HANDLE hVideoProcessor, 
                                                                  DXVAHD_BLT_STATE_PRIVATE_DATA* pData);
alias PDXVAHDSW_SetVideoProcessStreamState = HRESULT function(HANDLE hVideoProcessor, uint StreamNumber, 
                                                              DXVAHD_STREAM_STATE State, uint DataSize, char* pData);
alias PDXVAHDSW_GetVideoProcessStreamStatePrivate = HRESULT function(HANDLE hVideoProcessor, uint StreamNumber, 
                                                                     DXVAHD_STREAM_STATE_PRIVATE_DATA* pData);
alias PDXVAHDSW_VideoProcessBltHD = HRESULT function(HANDLE hVideoProcessor, IDirect3DSurface9 pOutputSurface, 
                                                     uint OutputFrame, uint StreamCount, char* pStreams);
alias PDXVAHDSW_DestroyVideoProcessor = HRESULT function(HANDLE hVideoProcessor);
alias PDXVAHDSW_Plugin = HRESULT function(uint Size, char* pCallbacks);
alias PDXVAHD_CreateDevice = HRESULT function(IDirect3DDevice9Ex pD3DDevice, 
                                              const(DXVAHD_CONTENT_DESC)* pContentDesc, DXVAHD_DEVICE_USAGE Usage, 
                                              PDXVAHDSW_Plugin pPlugin, IDXVAHD_Device* ppDevice);
alias MFPERIODICCALLBACK = void function(IUnknown pContext);

// Structs


struct CodecAPIEventData
{
    GUID    guid;
    uint    dataLength;
    uint[3] reserved;
}

struct D3D12_VIDEO_FORMAT
{
    DXGI_FORMAT Format;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
}

struct D3D12_VIDEO_SAMPLE
{
    uint               Width;
    uint               Height;
    D3D12_VIDEO_FORMAT Format;
}

struct D3D12_VIDEO_DECODE_CONFIGURATION
{
    GUID DecodeProfile;
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
    uint          NodeMask;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    uint          DecodeWidth;
    uint          DecodeHeight;
    DXGI_FORMAT   Format;
    DXGI_RATIONAL FrameRate;
    uint          BitRate;
    uint          MaxDecodePictureBufferCount;
}

struct D3D12_VIDEO_SIZE_RANGE
{
    uint MaxWidth;
    uint MaxHeight;
    uint MinWidth;
    uint MinHeight;
}

struct D3D12_VIDEO_PROCESS_ALPHA_BLENDING
{
    BOOL  Enable;
    float Alpha;
}

struct D3D12_VIDEO_PROCESS_LUMA_KEY
{
    BOOL  Enable;
    float Lower;
    float Upper;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC
{
    DXGI_FORMAT   Format;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
    DXGI_RATIONAL SourceAspectRatio;
    DXGI_RATIONAL DestinationAspectRatio;
    DXGI_RATIONAL FrameRate;
    D3D12_VIDEO_SIZE_RANGE SourceSizeRange;
    D3D12_VIDEO_SIZE_RANGE DestinationSizeRange;
    BOOL          EnableOrientation;
    D3D12_VIDEO_PROCESS_FILTER_FLAGS FilterFlags;
    D3D12_VIDEO_FRAME_STEREO_FORMAT StereoFormat;
    D3D12_VIDEO_FIELD_TYPE FieldType;
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS DeinterlaceMode;
    BOOL          EnableAlphaBlending;
    D3D12_VIDEO_PROCESS_LUMA_KEY LumaKey;
    uint          NumPastFrames;
    uint          NumFutureFrames;
    BOOL          EnableAutoProcessing;
}

struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC
{
    DXGI_FORMAT   Format;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
    D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE AlphaFillMode;
    uint          AlphaFillModeSourceStreamIndex;
    float[4]      BackgroundColor;
    DXGI_RATIONAL FrameRate;
    BOOL          EnableStereo;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_SUPPORT
{
    uint          NodeIndex;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    uint          Width;
    uint          Height;
    DXGI_FORMAT   DecodeFormat;
    DXGI_RATIONAL FrameRate;
    uint          BitRate;
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
    uint  NodeIndex;
    uint  ProfileCount;
    GUID* pProfiles;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_FORMAT_COUNT
{
    uint NodeIndex;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    uint FormatCount;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_FORMATS
{
    uint         NodeIndex;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    uint         FormatCount;
    DXGI_FORMAT* pOutputFormats;
}

struct D3D12_FEATURE_DATA_VIDEO_ARCHITECTURE
{
    BOOL IOCoherent;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_HISTOGRAM
{
    uint        NodeIndex;
    GUID        DecodeProfile;
    uint        Width;
    uint        Height;
    DXGI_FORMAT DecodeFormat;
    D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAGS Components;
    uint        BinCount;
    uint        CounterBitDepth;
}

struct D3D12_VIDEO_SCALE_SUPPORT
{
    D3D12_VIDEO_SIZE_RANGE OutputSizeRange;
    D3D12_VIDEO_SCALE_SUPPORT_FLAGS Flags;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_CONVERSION_SUPPORT
{
    uint               NodeIndex;
    D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
    D3D12_VIDEO_SAMPLE DecodeSample;
    D3D12_VIDEO_FORMAT OutputFormat;
    DXGI_RATIONAL      FrameRate;
    uint               BitRate;
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
    uint  NodeMask;
    const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC)* pOutputStreamDesc;
    uint  NumInputStreamDescs;
    const(D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC)* pInputStreamDescs;
    ulong MemoryPoolL0Size;
    ulong MemoryPoolL1Size;
}

struct D3D12_QUERY_DATA_VIDEO_DECODE_STATISTICS
{
    ulong         Status;
    ulong         NumMacroblocksAffected;
    DXGI_RATIONAL FrameRate;
    uint          BitRate;
}

struct D3D12_VIDEO_DECODE_FRAME_ARGUMENT
{
    D3D12_VIDEO_DECODE_ARGUMENT_TYPE Type;
    uint  Size;
    void* pData;
}

struct D3D12_VIDEO_DECODE_REFERENCE_FRAMES
{
    uint            NumTexture2Ds;
    ID3D12Resource* ppTexture2Ds;
    uint*           pSubresources;
    ID3D12VideoDecoderHeap* ppHeaps;
}

struct D3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM
{
    ID3D12Resource pBuffer;
    ulong          Offset;
    ulong          Size;
}

struct D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS
{
    BOOL           Enable;
    ID3D12Resource pReferenceTexture2D;
    uint           ReferenceSubresource;
    DXGI_COLOR_SPACE_TYPE OutputColorSpace;
    DXGI_COLOR_SPACE_TYPE DecodeColorSpace;
}

struct D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS
{
    uint NumFrameArguments;
    D3D12_VIDEO_DECODE_FRAME_ARGUMENT[10] FrameArguments;
    D3D12_VIDEO_DECODE_REFERENCE_FRAMES ReferenceFrames;
    D3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM CompressedBitstream;
    ID3D12VideoDecoderHeap pHeap;
}

struct D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS
{
    ID3D12Resource pOutputTexture2D;
    uint           OutputSubresource;
    D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS ConversionArguments;
}

struct D3D12_VIDEO_PROCESS_FILTER_RANGE
{
    int   Minimum;
    int   Maximum;
    int   Default;
    float Multiplier;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESS_SUPPORT
{
    uint               NodeIndex;
    D3D12_VIDEO_SAMPLE InputSample;
    D3D12_VIDEO_FIELD_TYPE InputFieldType;
    D3D12_VIDEO_FRAME_STEREO_FORMAT InputStereoFormat;
    DXGI_RATIONAL      InputFrameRate;
    D3D12_VIDEO_FORMAT OutputFormat;
    D3D12_VIDEO_FRAME_STEREO_FORMAT OutputStereoFormat;
    DXGI_RATIONAL      OutputFrameRate;
    D3D12_VIDEO_PROCESS_SUPPORT_FLAGS SupportFlags;
    D3D12_VIDEO_SCALE_SUPPORT ScaleSupport;
    D3D12_VIDEO_PROCESS_FEATURE_FLAGS FeatureSupport;
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS DeinterlaceSupport;
    D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAGS AutoProcessingSupport;
    D3D12_VIDEO_PROCESS_FILTER_FLAGS FilterSupport;
    D3D12_VIDEO_PROCESS_FILTER_RANGE[32] FilterRangeSupport;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESS_MAX_INPUT_STREAMS
{
    uint NodeIndex;
    uint MaxInputStreams;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESS_REFERENCE_INFO
{
    uint          NodeIndex;
    D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS DeinterlaceMode;
    D3D12_VIDEO_PROCESS_FILTER_FLAGS Filters;
    D3D12_VIDEO_PROCESS_FEATURE_FLAGS FeatureSupport;
    DXGI_RATIONAL InputFrameRate;
    DXGI_RATIONAL OutputFrameRate;
    BOOL          EnableAutoProcessing;
    uint          PastFrames;
    uint          FutureFrames;
}

struct D3D12_VIDEO_PROCESS_REFERENCE_SET
{
    uint            NumPastFrames;
    ID3D12Resource* ppPastFrames;
    uint*           pPastSubresources;
    uint            NumFutureFrames;
    ID3D12Resource* ppFutureFrames;
    uint*           pFutureSubresources;
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
    uint           Subresource;
    D3D12_VIDEO_PROCESS_REFERENCE_SET ReferenceSet;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS
{
    D3D12_VIDEO_PROCESS_INPUT_STREAM[2] InputStream;
    D3D12_VIDEO_PROCESS_TRANSFORM Transform;
    D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS Flags;
    D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE RateInfo;
    int[32] FilterLevels;
    D3D12_VIDEO_PROCESS_ALPHA_BLENDING AlphaBlending;
}

struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM
{
    ID3D12Resource pTexture2D;
    uint           Subresource;
}

struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS
{
    D3D12_VIDEO_PROCESS_OUTPUT_STREAM[2] OutputStream;
    RECT TargetRectangle;
}

struct D3D12_VIDEO_DECODE_OUTPUT_HISTOGRAM
{
    ulong          Offset;
    ID3D12Resource pBuffer;
}

struct D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS1
{
    BOOL           Enable;
    ID3D12Resource pReferenceTexture2D;
    uint           ReferenceSubresource;
    DXGI_COLOR_SPACE_TYPE OutputColorSpace;
    DXGI_COLOR_SPACE_TYPE DecodeColorSpace;
    uint           OutputWidth;
    uint           OutputHeight;
}

struct D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS1
{
    ID3D12Resource pOutputTexture2D;
    uint           OutputSubresource;
    D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS1 ConversionArguments;
    D3D12_VIDEO_DECODE_OUTPUT_HISTOGRAM[4] Histograms;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS1
{
    D3D12_VIDEO_PROCESS_INPUT_STREAM[2] InputStream;
    D3D12_VIDEO_PROCESS_TRANSFORM Transform;
    D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS Flags;
    D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE RateInfo;
    int[32] FilterLevels;
    D3D12_VIDEO_PROCESS_ALPHA_BLENDING AlphaBlending;
    D3D12_VIDEO_FIELD_TYPE FieldType;
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
    uint        NodeIndex;
    DXGI_FORMAT InputFormat;
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAGS BlockSizeFlags;
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAGS PrecisionFlags;
    D3D12_VIDEO_SIZE_RANGE SizeRange;
}

struct D3D12_FEATURE_DATA_VIDEO_MOTION_ESTIMATOR_SIZE
{
    uint        NodeIndex;
    DXGI_FORMAT InputFormat;
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE BlockSize;
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION Precision;
    D3D12_VIDEO_SIZE_RANGE SizeRange;
    BOOL        Protected;
    ulong       MotionVectorHeapMemoryPoolL0Size;
    ulong       MotionVectorHeapMemoryPoolL1Size;
    ulong       MotionEstimatorMemoryPoolL0Size;
    ulong       MotionEstimatorMemoryPoolL1Size;
}

struct D3D12_VIDEO_MOTION_ESTIMATOR_DESC
{
    uint        NodeMask;
    DXGI_FORMAT InputFormat;
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE BlockSize;
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION Precision;
    D3D12_VIDEO_SIZE_RANGE SizeRange;
}

struct D3D12_VIDEO_MOTION_VECTOR_HEAP_DESC
{
    uint        NodeMask;
    DXGI_FORMAT InputFormat;
    D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE BlockSize;
    D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION Precision;
    D3D12_VIDEO_SIZE_RANGE SizeRange;
}

struct D3D12_RESOURCE_COORDINATE
{
    ulong X;
    uint  Y;
    uint  Z;
    uint  SubresourceIndex;
}

struct D3D12_VIDEO_MOTION_ESTIMATOR_OUTPUT
{
    ID3D12VideoMotionVectorHeap pMotionVectorHeap;
}

struct D3D12_VIDEO_MOTION_ESTIMATOR_INPUT
{
    ID3D12Resource pInputTexture2D;
    uint           InputSubresourceIndex;
    ID3D12Resource pReferenceTexture2D;
    uint           ReferenceSubresourceIndex;
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
    BOOL  Protected;
    ulong MemoryPoolL0Size;
    ulong MemoryPoolL1Size;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESSOR_SIZE1
{
    uint  NodeMask;
    const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC)* pOutputStreamDesc;
    uint  NumInputStreamDescs;
    const(D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC)* pInputStreamDescs;
    BOOL  Protected;
    ulong MemoryPoolL0Size;
    ulong MemoryPoolL1Size;
}

struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_COUNT
{
    uint NodeIndex;
    uint CommandCount;
}

struct D3D12_VIDEO_EXTENSION_COMMAND_INFO
{
    GUID          CommandId;
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
    GUID CommandId;
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
    GUID CommandId;
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE Stage;
    uint ParameterCount;
    D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_INFO* pParameterInfos;
}

struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_SUPPORT
{
    uint         NodeIndex;
    GUID         CommandId;
    const(void)* pInputData;
    size_t       InputDataSizeInBytes;
    void*        pOutputData;
    size_t       OutputDataSizeInBytes;
}

struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_SIZE
{
    uint         NodeIndex;
    GUID         CommandId;
    const(void)* pCreationParameters;
    size_t       CreationParametersSizeInBytes;
    ulong        MemoryPoolL0Size;
    ulong        MemoryPoolL1Size;
}

struct D3D12_VIDEO_EXTENSION_COMMAND_DESC
{
    uint NodeMask;
    GUID CommandId;
}

struct AecQualityMetrics_Struct
{
    long  i64Timestamp;
    ubyte ConvergenceFlag;
    ubyte MicClippedFlag;
    ubyte MicSilenceFlag;
    ubyte PstvFeadbackFlag;
    ubyte SpkClippedFlag;
    ubyte SpkMuteFlag;
    ubyte GlitchFlag;
    ubyte DoubleTalkFlag;
    uint  uGlitchCount;
    uint  uMicClipCount;
    float fDuration;
    float fTSVariance;
    float fTSDriftRate;
    float fVoiceLevel;
    float fNoiseLevel;
    float fERLE;
    float fAvgERLE;
    uint  dwReserved;
}

struct TOC_DESCRIPTOR
{
    GUID   guidID;
    ushort wStreamNumber;
    GUID   guidType;
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

struct DXVA_AYUVsample2
{
    ubyte bCrValue;
    ubyte bCbValue;
    ubyte bY_Value;
    ubyte bSampleAlpha8;
}

struct DXVA_BufferDescription
{
align (1):
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
align (1):
    uint    dwFunction;
    uint[3] dwReservedBits;
    GUID    guidConfigBitstreamEncryption;
    GUID    guidConfigMBcontrolEncryption;
    GUID    guidConfigResidDiffEncryption;
    ubyte   bConfigBitstreamRaw;
    ubyte   bConfigMBcontrolRasterOrder;
    ubyte   bConfigResidDiffHost;
    ubyte   bConfigSpatialResid8;
    ubyte   bConfigResid8Subtraction;
    ubyte   bConfigSpatialHost8or9Clipping;
    ubyte   bConfigSpatialResidInterleaved;
    ubyte   bConfigIntraResidUnsigned;
    ubyte   bConfigResidDiffAccelerator;
    ubyte   bConfigHostInverseScan;
    ubyte   bConfigSpecificIDCT;
    ubyte   bConfig4GroupedCoefs;
}

struct DXVA_PictureParameters
{
align (1):
    ushort wDecodedPictureIndex;
    ushort wDeblockedPictureIndex;
    ushort wForwardRefPictureIndex;
    ushort wBackwardRefPictureIndex;
    ushort wPicWidthInMBminus1;
    ushort wPicHeightInMBminus1;
    ubyte  bMacroblockWidthMinus1;
    ubyte  bMacroblockHeightMinus1;
    ubyte  bBlockWidthMinus1;
    ubyte  bBlockHeightMinus1;
    ubyte  bBPPminus1;
    ubyte  bPicStructure;
    ubyte  bSecondField;
    ubyte  bPicIntra;
    ubyte  bPicBackwardPrediction;
    ubyte  bBidirectionalAveragingMode;
    ubyte  bMVprecisionAndChromaRelation;
    ubyte  bChromaFormat;
    ubyte  bPicScanFixed;
    ubyte  bPicScanMethod;
    ubyte  bPicReadbackRequests;
    ubyte  bRcontrol;
    ubyte  bPicSpatialResid8;
    ubyte  bPicOverflowBlocks;
    ubyte  bPicExtrapolation;
    ubyte  bPicDeblocked;
    ubyte  bPicDeblockConfined;
    ubyte  bPic4MVallowed;
    ubyte  bPicOBMC;
    ubyte  bPicBinPB;
    ubyte  bMV_RPS;
    ubyte  bReservedBits;
    ushort wBitstreamFcodes;
    ushort wBitstreamPCEelements;
    ubyte  bBitstreamConcealmentNeed;
    ubyte  bBitstreamConcealmentMethod;
}

struct DXVAUncompDataInfo
{
    uint      UncompWidth;
    uint      UncompHeight;
    D3DFORMAT UncompFormat;
}

struct DXVACompBufferInfo
{
    uint      NumCompBuffers;
    uint      WidthToCreate;
    uint      HeightToCreate;
    uint      BytesToAllocate;
    uint      Usage;
    D3DPOOL   Pool;
    D3DFORMAT Format;
}

struct DXVABufferInfo
{
    void* pCompSurface;
    uint  DataOffset;
    uint  DataSize;
}

struct DXVA_ExtendedFormat
{
    uint _bitfield64;
}

struct DXVA_Frequency
{
    uint Numerator;
    uint Denominator;
}

struct DXVA_VideoDesc
{
    uint           Size;
    uint           SampleWidth;
    uint           SampleHeight;
    uint           SampleFormat;
    D3DFORMAT      d3dFormat;
    DXVA_Frequency InputSampleFreq;
    DXVA_Frequency OutputFrameFreq;
}

struct DXVA_VideoSample
{
    long              rtStart;
    long              rtEnd;
    DXVA_SampleFormat SampleFormat;
    void*             lpDDSSrcSurface;
}

struct DXVA_VideoSample2
{
    long                 rtStart;
    long                 rtEnd;
    uint                 SampleFormat;
    uint                 SampleFlags;
    void*                lpDDSSrcSurface;
    RECT                 rcSrc;
    RECT                 rcDst;
    DXVA_AYUVsample2[16] Palette;
}

struct DXVA_DeinterlaceCaps
{
    uint                 Size;
    uint                 NumPreviousOutputFrames;
    uint                 InputPool;
    uint                 NumForwardRefSamples;
    uint                 NumBackwardRefSamples;
    D3DFORMAT            d3dOutputFormat;
    DXVA_VideoProcessCaps VideoProcessingCaps;
    DXVA_DeinterlaceTech DeinterlaceTechnology;
}

struct DXVA_DeinterlaceBlt
{
    uint                 Size;
    uint                 Reserved;
    long                 rtTarget;
    RECT                 DstRect;
    RECT                 SrcRect;
    uint                 NumSourceSurfaces;
    float                Alpha;
    DXVA_VideoSample[32] Source;
}

struct DXVA_DeinterlaceBltEx
{
    uint             Size;
    DXVA_AYUVsample2 BackgroundColor;
    RECT             rcTarget;
    long             rtTarget;
    uint             NumSourceSurfaces;
    float            Alpha;
    DXVA_VideoSample2[32] Source;
    uint             DestinationFormat;
    uint             DestinationFlags;
}

struct DXVA_DeinterlaceQueryAvailableModes
{
    uint     Size;
    uint     NumGuids;
    GUID[32] Guids;
}

struct DXVA_DeinterlaceQueryModeCaps
{
    uint           Size;
    GUID           Guid;
    DXVA_VideoDesc VideoDesc;
}

struct DXVA_ProcAmpControlCaps
{
    uint      Size;
    uint      InputPool;
    D3DFORMAT d3dOutputFormat;
    uint      ProcAmpControlProps;
    uint      VideoProcessingCaps;
}

struct DXVA_ProcAmpControlQueryRange
{
    uint           Size;
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
    uint  Size;
    RECT  DstRect;
    RECT  SrcRect;
    float Alpha;
    float Brightness;
    float Contrast;
    float Hue;
    float Saturation;
}

struct DXVA_COPPSignature
{
    ubyte[256] Signature;
}

struct DXVA_COPPCommand
{
    GUID        macKDI;
    GUID        guidCommandID;
    uint        dwSequence;
    uint        cbSizeData;
    ubyte[4056] CommandData;
}

struct DXVA_COPPStatusInput
{
    GUID        rApp;
    GUID        guidStatusRequestID;
    uint        dwSequence;
    uint        cbSizeData;
    ubyte[4056] StatusData;
}

struct DXVA_COPPStatusOutput
{
    GUID        macKDI;
    uint        cbSizeData;
    ubyte[4076] COPPStatus;
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

union DXVAHD_COLOR
{
    DXVAHD_COLOR_RGBA   RGB;
    DXVAHD_COLOR_YCbCrA YCbCr;
}

struct DXVAHD_CONTENT_DESC
{
    DXVAHD_FRAME_FORMAT InputFrameFormat;
    DXVAHD_RATIONAL     InputFrameRate;
    uint                InputWidth;
    uint                InputHeight;
    DXVAHD_RATIONAL     OutputFrameRate;
    uint                OutputWidth;
    uint                OutputHeight;
}

struct DXVAHD_VPDEVCAPS
{
    DXVAHD_DEVICE_TYPE DeviceType;
    uint               DeviceCaps;
    uint               FeatureCaps;
    uint               FilterCaps;
    uint               InputFormatCaps;
    D3DPOOL            InputPool;
    uint               OutputFormatCount;
    uint               InputFormatCount;
    uint               VideoProcessorCount;
    uint               MaxInputStreams;
    uint               MaxStreamStates;
}

struct DXVAHD_VPCAPS
{
    GUID VPGuid;
    uint PastFrames;
    uint FutureFrames;
    uint ProcessorCaps;
    uint ITelecineCaps;
    uint CustomRateCount;
}

struct DXVAHD_CUSTOM_RATE_DATA
{
    DXVAHD_RATIONAL CustomRate;
    uint            OutputFrames;
    BOOL            InputInterlaced;
    uint            InputFramesOrFields;
}

struct DXVAHD_FILTER_RANGE_DATA
{
    int   Minimum;
    int   Maximum;
    int   Default;
    float Multiplier;
}

struct DXVAHD_BLT_STATE_TARGET_RECT_DATA
{
    BOOL Enable;
    RECT TargetRect;
}

struct DXVAHD_BLT_STATE_BACKGROUND_COLOR_DATA
{
    BOOL         YCbCr;
    DXVAHD_COLOR BackgroundColor;
}

struct DXVAHD_BLT_STATE_OUTPUT_COLOR_SPACE_DATA
{
    union
    {
        struct
        {
            uint _bitfield65;
        }
        uint Value;
    }
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
    GUID  Guid;
    uint  DataSize;
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
    union
    {
        struct
        {
            uint _bitfield66;
        }
        uint Value;
    }
}

struct DXVAHD_STREAM_STATE_OUTPUT_RATE_DATA
{
    BOOL               RepeatFrame;
    DXVAHD_OUTPUT_RATE OutputRate;
    DXVAHD_RATIONAL    CustomRate;
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
    BOOL  Enable;
    float Alpha;
}

struct DXVAHD_STREAM_STATE_PALETTE_DATA
{
    uint  Count;
    uint* pEntries;
}

struct DXVAHD_STREAM_STATE_LUMA_KEY_DATA
{
    BOOL  Enable;
    float Lower;
    float Upper;
}

struct DXVAHD_STREAM_STATE_ASPECT_RATIO_DATA
{
    BOOL            Enable;
    DXVAHD_RATIONAL SourceAspectRatio;
    DXVAHD_RATIONAL DestinationAspectRatio;
}

struct DXVAHD_STREAM_STATE_FILTER_DATA
{
    BOOL Enable;
    int  Level;
}

struct DXVAHD_STREAM_STATE_PRIVATE_DATA
{
    GUID  Guid;
    uint  DataSize;
    void* pData;
}

struct DXVAHD_STREAM_DATA
{
    BOOL               Enable;
    uint               OutputIndex;
    uint               InputFrameOrField;
    uint               PastFrames;
    uint               FutureFrames;
    IDirect3DSurface9* ppPastSurfaces;
    IDirect3DSurface9  pInputSurface;
    IDirect3DSurface9* ppFutureSurfaces;
}

struct DXVAHD_STREAM_STATE_PRIVATE_IVTC_DATA
{
    BOOL Enable;
    uint ITelecineFlags;
    uint Frames;
    uint InputField;
}

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

struct DXVAHDETW_CREATEVIDEOPROCESSOR
{
    ulong pObject;
    ulong pD3D9Ex;
    GUID  VPGuid;
}

struct DXVAHDETW_VIDEOPROCESSBLTSTATE
{
    ulong            pObject;
    DXVAHD_BLT_STATE State;
    uint             DataSize;
    BOOL             SetState;
}

struct DXVAHDETW_VIDEOPROCESSSTREAMSTATE
{
    ulong               pObject;
    uint                StreamNumber;
    DXVAHD_STREAM_STATE State;
    uint                DataSize;
    BOOL                SetState;
}

struct DXVAHDETW_VIDEOPROCESSBLTHD
{
    ulong     pObject;
    ulong     pOutputSurface;
    RECT      TargetRect;
    D3DFORMAT OutputFormat;
    uint      ColorSpace;
    uint      OutputFrame;
    uint      StreamCount;
    BOOL      Enter;
}

struct DXVAHDETW_VIDEOPROCESSBLTHD_STREAM
{
    ulong               pObject;
    ulong               pInputSurface;
    RECT                SourceRect;
    RECT                DestinationRect;
    D3DFORMAT           InputFormat;
    DXVAHD_FRAME_FORMAT FrameFormat;
    uint                ColorSpace;
    uint                StreamNumber;
    uint                OutputIndex;
    uint                InputFrameOrField;
    uint                PastFrames;
    uint                FutureFrames;
}

struct DXVAHDETW_DESTROYVIDEOPROCESSOR
{
    ulong pObject;
}

struct DXVA2_ExtendedFormat
{
    union
    {
        struct
        {
            uint _bitfield67;
        }
        uint value;
    }
}

struct DXVA2_Frequency
{
    uint Numerator;
    uint Denominator;
}

struct DXVA2_VideoDesc
{
    uint                 SampleWidth;
    uint                 SampleHeight;
    DXVA2_ExtendedFormat SampleFormat;
    D3DFORMAT            Format;
    DXVA2_Frequency      InputSampleFreq;
    DXVA2_Frequency      OutputFrameFreq;
    uint                 UABProtectionLevel;
    uint                 Reserved;
}

struct DXVA2_VideoProcessorCaps
{
    uint    DeviceCaps;
    D3DPOOL InputPool;
    uint    NumForwardRefSamples;
    uint    NumBackwardRefSamples;
    uint    Reserved;
    uint    DeinterlaceTechnology;
    uint    ProcAmpControlCaps;
    uint    VideoProcessorOperations;
    uint    NoiseFilterTechnology;
    uint    DetailFilterTechnology;
}

struct DXVA2_Fixed32
{
    union
    {
        struct
        {
            ushort Fraction;
            short  Value;
        }
        int ll;
    }
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
    long                 Start;
    long                 End;
    DXVA2_ExtendedFormat SampleFormat;
    IDirect3DSurface9    SrcSurface;
    RECT                 SrcRect;
    RECT                 DstRect;
    DXVA2_AYUVSample8[16] Pal;
    DXVA2_Fixed32        PlanarAlpha;
    uint                 SampleData;
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
    long                 TargetFrame;
    RECT                 TargetRect;
    SIZE                 ConstrictionSize;
    uint                 StreamingFlags;
    DXVA2_AYUVSample16   BackgroundColor;
    DXVA2_ExtendedFormat DestFormat;
    DXVA2_ProcAmpValues  ProcAmpValues;
    DXVA2_Fixed32        Alpha;
    DXVA2_FilterValues   NoiseFilterLuma;
    DXVA2_FilterValues   NoiseFilterChroma;
    DXVA2_FilterValues   DetailFilterLuma;
    DXVA2_FilterValues   DetailFilterChroma;
    uint                 DestData;
}

struct DXVA2_ConfigPictureDecode
{
    GUID   guidConfigBitstreamEncryption;
    GUID   guidConfigMBcontrolEncryption;
    GUID   guidConfigResidDiffEncryption;
    uint   ConfigBitstreamRaw;
    uint   ConfigMBcontrolRasterOrder;
    uint   ConfigResidDiffHost;
    uint   ConfigSpatialResid8;
    uint   ConfigResid8Subtraction;
    uint   ConfigSpatialHost8or9Clipping;
    uint   ConfigSpatialResidInterleaved;
    uint   ConfigIntraResidUnsigned;
    uint   ConfigResidDiffAccelerator;
    uint   ConfigHostInverseScan;
    uint   ConfigSpecificIDCT;
    uint   Config4GroupedCoefs;
    ushort ConfigMinRenderTargetBuffCount;
    ushort ConfigDecoderSpecific;
}

struct DXVA2_DecodeBufferDesc
{
    uint  CompressedBufferType;
    uint  BufferIndex;
    uint  DataOffset;
    uint  DataSize;
    uint  FirstMBaddress;
    uint  NumMBsInBuffer;
    uint  Width;
    uint  Height;
    uint  Stride;
    uint  ReservedBits;
    void* pvPVPState;
}

struct DXVA2_AES_CTR_IV
{
    ulong IV;
    ulong Count;
}

struct DXVA2_DecodeExtensionData
{
    uint  Function;
    void* pPrivateInputData;
    uint  PrivateInputDataSize;
    void* pPrivateOutputData;
    uint  PrivateOutputDataSize;
}

struct DXVA2_DecodeExecuteParams
{
    uint NumCompBuffers;
    DXVA2_DecodeBufferDesc* pCompressedBuffers;
    DXVA2_DecodeExtensionData* pExtensionData;
}

struct OPM_RANDOM_NUMBER
{
    ubyte[16] abRandomNumber;
}

struct OPM_OMAC
{
    ubyte[16] abOMAC;
}

struct OPM_ENCRYPTED_INITIALIZATION_PARAMETERS
{
    ubyte[256] abEncryptedInitializationParameters;
}

struct OPM_GET_INFO_PARAMETERS
{
align (1):
    OPM_OMAC          omac;
    OPM_RANDOM_NUMBER rnRandomNumber;
    GUID              guidInformation;
    uint              ulSequenceNumber;
    uint              cbParametersSize;
    ubyte[4056]       abParameters;
}

struct OPM_COPP_COMPATIBLE_GET_INFO_PARAMETERS
{
align (1):
    OPM_RANDOM_NUMBER rnRandomNumber;
    GUID              guidInformation;
    uint              ulSequenceNumber;
    uint              cbParametersSize;
    ubyte[4056]       abParameters;
}

struct OPM_HDCP_KEY_SELECTION_VECTOR
{
    ubyte[5] abKeySelectionVector;
}

struct OPM_CONNECTED_HDCP_DEVICE_INFORMATION
{
align (1):
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint              ulStatusFlags;
    uint              ulHDCPFlags;
    OPM_HDCP_KEY_SELECTION_VECTOR ksvB;
    ubyte[11]         Reserved;
    ubyte[16]         Reserved2;
    ubyte[16]         Reserved3;
}

struct OPM_REQUESTED_INFORMATION
{
align (1):
    OPM_OMAC    omac;
    uint        cbRequestedInformationSize;
    ubyte[4076] abRequestedInformation;
}

struct OPM_STANDARD_INFORMATION
{
align (1):
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint              ulStatusFlags;
    uint              ulInformation;
    uint              ulReserved;
    uint              ulReserved2;
}

struct OPM_ACTUAL_OUTPUT_FORMAT
{
align (1):
    OPM_RANDOM_NUMBER  rnRandomNumber;
    uint               ulStatusFlags;
    uint               ulDisplayWidth;
    uint               ulDisplayHeight;
    DXVA2_SampleFormat dsfSampleInterleaveFormat;
    D3DFORMAT          d3dFormat;
    uint               ulFrequencyNumerator;
    uint               ulFrequencyDenominator;
}

struct OPM_ACP_AND_CGMSA_SIGNALING
{
align (1):
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint              ulStatusFlags;
    uint              ulAvailableTVProtectionStandards;
    uint              ulActiveTVProtectionStandard;
    uint              ulReserved;
    uint              ulAspectRatioValidMask1;
    uint              ulAspectRatioData1;
    uint              ulAspectRatioValidMask2;
    uint              ulAspectRatioData2;
    uint              ulAspectRatioValidMask3;
    uint              ulAspectRatioData3;
    uint[4]           ulReserved2;
    uint[4]           ulReserved3;
}

struct OPM_OUTPUT_ID_DATA
{
align (1):
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint              ulStatusFlags;
    ulong             OutputId;
}

struct OPM_CONFIGURE_PARAMETERS
{
align (1):
    OPM_OMAC    omac;
    GUID        guidSetting;
    uint        ulSequenceNumber;
    uint        cbParametersSize;
    ubyte[4056] abParameters;
}

struct OPM_SET_PROTECTION_LEVEL_PARAMETERS
{
align (1):
    uint ulProtectionType;
    uint ulProtectionLevel;
    uint Reserved;
    uint Reserved2;
}

struct OPM_SET_ACP_AND_CGMSA_SIGNALING_PARAMETERS
{
align (1):
    uint    ulNewTVProtectionStandard;
    uint    ulAspectRatioChangeMask1;
    uint    ulAspectRatioData1;
    uint    ulAspectRatioChangeMask2;
    uint    ulAspectRatioData2;
    uint    ulAspectRatioChangeMask3;
    uint    ulAspectRatioData3;
    uint[4] ulReserved;
    uint[4] ulReserved2;
    uint    ulReserved3;
}

struct OPM_SET_HDCP_SRM_PARAMETERS
{
align (1):
    uint ulSRMVersion;
}

struct OPM_GET_CODEC_INFO_PARAMETERS
{
align (1):
    uint        cbVerifier;
    ubyte[4052] Verifier;
}

struct OPM_GET_CODEC_INFO_INFORMATION
{
align (1):
    OPM_RANDOM_NUMBER rnRandomNumber;
    uint              Merit;
}

struct MFT_REGISTER_TYPE_INFO
{
    GUID guidMajorType;
    GUID guidSubtype;
}

struct MFRatio
{
    uint Numerator;
    uint Denominator;
}

struct MFOffset
{
    ushort fract;
    short  value;
}

struct MFVideoArea
{
    MFOffset OffsetX;
    MFOffset OffsetY;
    SIZE     Area;
}

struct MFVideoInfo
{
    uint                 dwWidth;
    uint                 dwHeight;
    MFRatio              PixelAspectRatio;
    MFVideoChromaSubsampling SourceChromaSubsampling;
    MFVideoInterlaceMode InterlaceMode;
    MFVideoTransferFunction TransferFunction;
    MFVideoPrimaries     ColorPrimaries;
    MFVideoTransferMatrix TransferMatrix;
    MFVideoLighting      SourceLighting;
    MFRatio              FramesPerSecond;
    MFNominalRange       NominalRange;
    MFVideoArea          GeometricAperture;
    MFVideoArea          MinimumDisplayAperture;
    MFVideoArea          PanScanAperture;
    ulong                VideoFlags;
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

union MFPaletteEntry
{
    MFARGB       ARGB;
    MFAYUVSample AYCbCr;
}

struct MFVideoSurfaceInfo
{
    uint              Format;
    uint              PaletteEntries;
    MFPaletteEntry[1] Palette;
}

struct MFVideoCompressedInfo
{
    long AvgBitrate;
    long AvgBitErrorRate;
    uint MaxKeyFrameSpacing;
}

struct MFVIDEOFORMAT
{
    uint               dwSize;
    MFVideoInfo        videoInfo;
    GUID               guidFormat;
    MFVideoCompressedInfo compressedInfo;
    MFVideoSurfaceInfo surfaceInfo;
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
    uint          dwStreamID;
    IMFSample     pSample;
    uint          dwStatus;
    IMFCollection pEvents;
}

struct STREAM_MEDIUM
{
    GUID gidMedium;
    uint unMediumInstance;
}

struct MFAudioDecoderDegradationInfo
{
    MFT_AUDIO_DECODER_DEGRADATION_REASON eDegradationReason;
    MFT_AUDIO_DECODER_DEGRADATION_TYPE eType;
}

struct MFT_STREAM_STATE_PARAM
{
    uint            StreamId;
    MF_STREAM_STATE State;
}

struct MFCLOCK_PROPERTIES
{
    ulong qwCorrelationRate;
    GUID  guidClockId;
    uint  dwClockFlags;
    ulong qwClockFrequency;
    uint  dwClockTolerance;
    uint  dwClockJitter;
}

struct MFRR_COMPONENT_HASH_INFO
{
    uint        ulReason;
    ushort[43]  rgHeaderHash;
    ushort[43]  rgPublicKeyHash;
    ushort[260] wszName;
}

struct MFRR_COMPONENTS
{
    uint dwRRInfoVersion;
    uint dwRRComponents;
    MFRR_COMPONENT_HASH_INFO* pRRComponents;
}

struct ASF_FLAT_PICTURE
{
align (1):
    ubyte bPictureType;
    uint  dwDataLen;
}

struct ASF_FLAT_SYNCHRONISED_LYRICS
{
align (1):
    ubyte bTimeStampFormat;
    ubyte bContentType;
    uint  dwLyricsLen;
}

struct MFTOPONODE_ATTRIBUTE_UPDATE
{
    ulong             NodeId;
    GUID              guidAttributeKey;
    MF_ATTRIBUTE_TYPE attrType;
    union
    {
        uint   u32;
        ulong  u64;
        double d;
    }
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
    uint  cBuckets;
    ulong qwNetBufferingTime;
    ulong qwExtraBufferingTimeDuringSeek;
    ulong qwPlayDuration;
    float dRate;
}

struct MF_BYTE_STREAM_CACHE_RANGE
{
    ulong qwStartOffset;
    ulong qwEndOffset;
}

struct MFNetCredentialManagerGetParam
{
    HRESULT       hrOp;
    BOOL          fAllowLoggedOnUser;
    BOOL          fClearTextPackage;
    const(wchar)* pszUrl;
    const(wchar)* pszSite;
    const(wchar)* pszRealm;
    const(wchar)* pszPackage;
    int           nRetries;
}

struct MFINPUTTRUSTAUTHORITY_ACCESS_ACTION
{
    MFPOLICYMANAGER_ACTION Action;
    ubyte* pbTicket;
    uint   cbTicket;
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
    MFINPUTTRUSTAUTHORITY_ACCESS_ACTION[1] rgOutputActions;
}

struct MF_TRANSCODE_SINK_INFO
{
    uint         dwVideoStreamID;
    IMFMediaType pVideoMediaType;
    uint         dwAudioStreamID;
    IMFMediaType pAudioMediaType;
}

struct MFT_REGISTRATION_INFO
{
    GUID          clsid;
    GUID          guidCategory;
    uint          uiFlags;
    const(wchar)* pszName;
    uint          cInTypes;
    MFT_REGISTER_TYPE_INFO* pInTypes;
    uint          cOutTypes;
    MFT_REGISTER_TYPE_INFO* pOutTypes;
}

struct MFCONTENTPROTECTIONDEVICE_INPUT_DATA
{
    uint     HWProtectionFunctionID;
    uint     PrivateDataByteCount;
    uint     HWProtectionDataByteCount;
    uint     Reserved;
    ubyte[4] InputData;
}

struct MFCONTENTPROTECTIONDEVICE_OUTPUT_DATA
{
    uint     PrivateDataByteCount;
    uint     MaxHWProtectionDataByteCount;
    uint     HWProtectionDataByteCount;
    HRESULT  Status;
    long     TransportTimeInHundredsOfNanoseconds;
    long     ExecutionTimeInHundredsOfNanoseconds;
    ubyte[4] OutputData;
}

struct MFCONTENTPROTECTIONDEVICE_REALTIMECLIENT_DATA
{
    uint        TaskIndex;
    ushort[260] ClassName;
    int         BasePriority;
}

struct MFMediaKeyStatus
{
    ubyte*             pbKeyId;
    uint               cbKeyId;
    MF_MEDIAKEY_STATUS eMediaKeyStatus;
}

struct MF_VIDEO_SPHERICAL_VIEWDIRECTION
{
    int iHeading;
    int iPitch;
    int iRoll;
}

struct SENSORPROFILEID
{
    GUID Type;
    uint Index;
    uint Unused;
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

struct MFExtendedCameraIntrinsic_IntrinsicModel
{
    uint Width;
    uint Height;
    uint SplitFrameId;
    MFCameraIntrinsic_CameraModel CameraModel;
}

struct ASF_INDEX_IDENTIFIER
{
    GUID   guidIndexType;
    ushort wStreamNumber;
}

struct ASF_INDEX_DESCRIPTOR
{
    ASF_INDEX_IDENTIFIER Identifier;
    ushort               cPerEntryBytes;
    ushort[32]           szDescription;
    uint                 dwInterval;
}

struct ASF_MUX_STATISTICS
{
    uint cFramesWritten;
    uint cFramesDropped;
}

struct MFVideoNormalizedRect
{
    float left;
    float top;
    float right;
    float bottom;
}

struct MOVE_RECT
{
    POINT SourcePoint;
    RECT  DestRect;
}

struct DIRTYRECT_INFO
{
    uint    FrameNumber;
    uint    NumDirtyRects;
    RECT[1] DirtyRects;
}

struct MOVEREGION_INFO
{
    uint         FrameNumber;
    uint         NumMoveRegions;
    MOVE_RECT[1] MoveRegions;
}

struct ROI_AREA
{
    RECT rect;
    int  QPDelta;
}

struct MACROBLOCK_DATA
{
    uint  flags;
    short motionVectorX;
    short motionVectorY;
    int   QPDelta;
}

struct MFFOLDDOWN_MATRIX
{
    uint    cbSize;
    uint    cSrcChannels;
    uint    cDstChannels;
    uint    dwChannelMask;
    int[64] Coeff;
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
    GUID majortype;
    GUID subtype;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint lSampleSize;
    GUID formattype;
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
    GUID          CalibrationId;
    MF_FLOAT3     Position;
    MF_QUATERNION Orientation;
}

struct MFCameraExtrinsics
{
    uint TransformCount;
    MFCameraExtrinsic_CalibratedTransform[1] CalibratedTransforms;
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
    MFPinholeCameraIntrinsic_IntrinsicModel[1] IntrinsicModels;
}

struct MFMPEG2DLNASINKSTATS
{
    ulong cBytesWritten;
    BOOL  fPAL;
    uint  fccVideo;
    uint  dwVideoWidth;
    uint  dwVideoHeight;
    ulong cVideoFramesReceived;
    ulong cVideoFramesEncoded;
    ulong cVideoFramesSkipped;
    ulong cBlackVideoFramesEncoded;
    ulong cVideoFramesDuplicated;
    uint  cAudioSamplesPerSec;
    uint  cAudioChannels;
    ulong cAudioBytesReceived;
    ulong cAudioFramesEncoded;
}

struct MF_SINK_WRITER_STATISTICS
{
    uint  cb;
    long  llLastTimestampReceived;
    long  llLastTimestampEncoded;
    long  llLastTimestampProcessed;
    long  llLastStreamTickReceived;
    long  llLastSinkSampleRequest;
    ulong qwNumSamplesReceived;
    ulong qwNumSamplesEncoded;
    ulong qwNumSamplesProcessed;
    ulong qwNumStreamTicksReceived;
    uint  dwByteCountQueued;
    ulong qwByteCountProcessed;
    uint  dwNumOutstandingSinkSampleRequests;
    uint  dwAverageSampleRateReceived;
    uint  dwAverageSampleRateEncoded;
    uint  dwAverageSampleRateProcessed;
}

struct MFP_EVENT_HEADER
{
    MFP_EVENT_TYPE  eEventType;
    HRESULT         hrEvent;
    IMFPMediaPlayer pMediaPlayer;
    MFP_MEDIAPLAYER_STATE eState;
    IPropertyStore  pPropertyStore;
}

struct MFP_PLAY_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem    pMediaItem;
}

struct MFP_PAUSE_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem    pMediaItem;
}

struct MFP_STOP_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem    pMediaItem;
}

struct MFP_POSITION_SET_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem    pMediaItem;
}

struct MFP_RATE_SET_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem    pMediaItem;
    float            flRate;
}

struct MFP_MEDIAITEM_CREATED_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem    pMediaItem;
    size_t           dwUserData;
}

struct MFP_MEDIAITEM_SET_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem    pMediaItem;
}

struct MFP_FRAME_STEP_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem    pMediaItem;
}

struct MFP_MEDIAITEM_CLEARED_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem    pMediaItem;
}

struct MFP_MF_EVENT
{
    MFP_EVENT_HEADER header;
    uint             MFEventType;
    IMFMediaEvent    pMFMediaEvent;
    IMFPMediaItem    pMediaItem;
}

struct MFP_ERROR_EVENT
{
    MFP_EVENT_HEADER header;
}

struct MFP_PLAYBACK_ENDED_EVENT
{
    MFP_EVENT_HEADER header;
    IMFPMediaItem    pMediaItem;
}

struct MFP_ACQUIRE_USER_CREDENTIAL_EVENT
{
    MFP_EVENT_HEADER header;
    size_t           dwUserData;
    BOOL             fProceedWithAuthentication;
    HRESULT          hrAuthenticationStatus;
    const(wchar)*    pwszURL;
    const(wchar)*    pwszSite;
    const(wchar)*    pwszRealm;
    const(wchar)*    pwszPackage;
    int              nRetries;
    uint             flags;
    IMFNetCredential pCredential;
}

struct DEVICE_INFO
{
    BSTR pFriendlyDeviceName;
    BSTR pUniqueDeviceName;
    BSTR pManufacturerName;
    BSTR pModelName;
    BSTR pIconURL;
}

struct MFVideoAlphaBitmapParams
{
    uint  dwFlags;
    uint  clrSrcKey;
    RECT  rcSrc;
    MFVideoNormalizedRect nrcDest;
    float fAlpha;
    uint  dwFilterMode;
}

struct MFVideoAlphaBitmap
{
    BOOL GetBitmapFromDC;
    union bitmap
    {
        HDC               hdc;
        IDirect3DSurface9 pDDS;
    }
    MFVideoAlphaBitmapParams params;
}

struct D3D11_VIDEO_DECODER_DESC
{
    GUID        Guid;
    uint        SampleWidth;
    uint        SampleHeight;
    DXGI_FORMAT OutputFormat;
}

struct D3D11_VIDEO_DECODER_CONFIG
{
    GUID   guidConfigBitstreamEncryption;
    GUID   guidConfigMBcontrolEncryption;
    GUID   guidConfigResidDiffEncryption;
    uint   ConfigBitstreamRaw;
    uint   ConfigMBcontrolRasterOrder;
    uint   ConfigResidDiffHost;
    uint   ConfigSpatialResid8;
    uint   ConfigResid8Subtraction;
    uint   ConfigSpatialHost8or9Clipping;
    uint   ConfigSpatialResidInterleaved;
    uint   ConfigIntraResidUnsigned;
    uint   ConfigResidDiffAccelerator;
    uint   ConfigHostInverseScan;
    uint   ConfigSpecificIDCT;
    uint   Config4GroupedCoefs;
    ushort ConfigMinRenderTargetBuffCount;
    ushort ConfigDecoderSpecific;
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
    uint  BufferIndex;
    uint  DataOffset;
    uint  DataSize;
    uint  FirstMBaddress;
    uint  NumMBsInBuffer;
    uint  Width;
    uint  Height;
    uint  Stride;
    uint  ReservedBits;
    void* pIV;
    uint  IVSize;
    BOOL  PartialEncryption;
    D3D11_ENCRYPTED_BLOCK_INFO EncryptedBlockInfo;
}

struct D3D11_VIDEO_DECODER_EXTENSION
{
    uint            Function;
    void*           pPrivateInputData;
    uint            PrivateInputDataSize;
    void*           pPrivateOutputData;
    uint            PrivateOutputDataSize;
    uint            ResourceCount;
    ID3D11Resource* ppResourceList;
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

struct D3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS
{
    uint PastFrames;
    uint FutureFrames;
    uint ProcessorCaps;
    uint ITelecineCaps;
    uint CustomRateCount;
}

struct D3D11_VIDEO_CONTENT_PROTECTION_CAPS
{
    uint  Caps;
    uint  KeyExchangeTypeCount;
    uint  BlockAlignmentSize;
    ulong ProtectedMemorySize;
}

struct D3D11_VIDEO_PROCESSOR_CUSTOM_RATE
{
    DXGI_RATIONAL CustomRate;
    uint          OutputFrames;
    BOOL          InputInterlaced;
    uint          InputFramesOrFields;
}

struct D3D11_VIDEO_PROCESSOR_FILTER_RANGE
{
    int   Minimum;
    int   Maximum;
    int   Default;
    float Multiplier;
}

struct D3D11_VIDEO_PROCESSOR_CONTENT_DESC
{
    D3D11_VIDEO_FRAME_FORMAT InputFrameFormat;
    DXGI_RATIONAL     InputFrameRate;
    uint              InputWidth;
    uint              InputHeight;
    DXGI_RATIONAL     OutputFrameRate;
    uint              OutputWidth;
    uint              OutputHeight;
    D3D11_VIDEO_USAGE Usage;
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
    union
    {
        D3D11_VIDEO_COLOR_YCbCrA YCbCr;
        D3D11_VIDEO_COLOR_RGBA RGBA;
    }
}

struct D3D11_VIDEO_PROCESSOR_COLOR_SPACE
{
    uint _bitfield68;
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

struct D3D11_OMAC
{
    ubyte[16] Omac;
}

struct D3D11_AUTHENTICATED_QUERY_INPUT
{
    GUID   QueryType;
    HANDLE hChannel;
    uint   SequenceNumber;
}

struct D3D11_AUTHENTICATED_QUERY_OUTPUT
{
    D3D11_OMAC omac;
    GUID       QueryType;
    HANDLE     hChannel;
    uint       SequenceNumber;
    HRESULT    ReturnCode;
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

struct D3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    uint   ProcessIndex;
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
    uint   OutputIDCount;
}

struct D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_INPUT
{
    D3D11_AUTHENTICATED_QUERY_INPUT Input;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
    uint   OutputIDIndex;
}

struct D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
    uint   OutputIDIndex;
    ulong  OutputID;
}

struct D3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    D3D11_BUS_TYPE BusType;
    BOOL           AccessibleInContiguousBlocks;
    BOOL           AccessibleInNonContiguousBlocks;
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
    GUID EncryptionGuid;
}

struct D3D11_AUTHENTICATED_QUERY_CURRENT_ACCESSIBILITY_ENCRYPTION_OUTPUT
{
    D3D11_AUTHENTICATED_QUERY_OUTPUT Output;
    GUID EncryptionGuid;
}

struct D3D11_AUTHENTICATED_CONFIGURE_INPUT
{
    D3D11_OMAC omac;
    GUID       ConfigureType;
    HANDLE     hChannel;
    uint       SequenceNumber;
}

struct D3D11_AUTHENTICATED_CONFIGURE_OUTPUT
{
    D3D11_OMAC omac;
    GUID       ConfigureType;
    HANDLE     hChannel;
    uint       SequenceNumber;
    HRESULT    ReturnCode;
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
    BOOL   AllowAccess;
}

struct D3D11_AUTHENTICATED_CONFIGURE_ACCESSIBLE_ENCRYPTION_INPUT
{
    D3D11_AUTHENTICATED_CONFIGURE_INPUT Parameters;
    GUID EncryptionGuid;
}

struct D3D11_TEX2D_VDOV
{
    uint ArraySlice;
}

struct D3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC
{
    GUID                 DecodeProfile;
    D3D11_VDOV_DIMENSION ViewDimension;
    union
    {
        D3D11_TEX2D_VDOV Texture2D;
    }
}

struct D3D11_TEX2D_VPIV
{
    uint MipSlice;
    uint ArraySlice;
}

struct D3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC
{
    uint                 FourCC;
    D3D11_VPIV_DIMENSION ViewDimension;
    union
    {
        D3D11_TEX2D_VPIV Texture2D;
    }
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
    union
    {
        D3D11_TEX2D_VPOV Texture2D;
        D3D11_TEX2D_ARRAY_VPOV Texture2DArray;
    }
}

struct D3D11_VIDEO_DECODER_SUB_SAMPLE_MAPPING_BLOCK
{
    uint ClearSize;
    uint EncryptedSize;
}

struct D3D11_VIDEO_DECODER_BUFFER_DESC1
{
    D3D11_VIDEO_DECODER_BUFFER_TYPE BufferType;
    uint  DataOffset;
    uint  DataSize;
    void* pIV;
    uint  IVSize;
    D3D11_VIDEO_DECODER_SUB_SAMPLE_MAPPING_BLOCK* pSubSampleMappingBlock;
    uint  SubSampleMappingCount;
}

struct D3D11_VIDEO_DECODER_BEGIN_FRAME_CRYPTO_SESSION
{
    ID3D11CryptoSession pCryptoSession;
    uint                BlobSize;
    void*               pBlob;
    GUID*               pKeyInfoId;
    uint                PrivateDataSize;
    void*               pPrivateData;
}

struct D3D11_VIDEO_PROCESSOR_STREAM_BEHAVIOR_HINT
{
    BOOL        Enable;
    uint        Width;
    uint        Height;
    DXGI_FORMAT Format;
}

struct D3D11_KEY_EXCHANGE_HW_PROTECTION_INPUT_DATA
{
    uint     PrivateDataSize;
    uint     HWProtectionDataSize;
    ubyte[4] pbInput;
}

struct D3D11_KEY_EXCHANGE_HW_PROTECTION_OUTPUT_DATA
{
    uint     PrivateDataSize;
    uint     MaxHWProtectionDataSize;
    uint     HWProtectionDataSize;
    ulong    TransportTime;
    ulong    ExecutionTime;
    ubyte[4] pbOutput;
}

struct D3D11_KEY_EXCHANGE_HW_PROTECTION_DATA
{
    uint    HWProtectionFunctionID;
    D3D11_KEY_EXCHANGE_HW_PROTECTION_INPUT_DATA* pInputData;
    D3D11_KEY_EXCHANGE_HW_PROTECTION_OUTPUT_DATA* pOutputData;
    HRESULT Status;
}

struct D3D11_VIDEO_SAMPLE_DESC
{
    uint        Width;
    uint        Height;
    DXGI_FORMAT Format;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
}

struct D3DOVERLAYCAPS
{
    uint Caps;
    uint MaxOverlayDisplayWidth;
    uint MaxOverlayDisplayHeight;
}

struct D3DCONTENTPROTECTIONCAPS
{
align (4):
    uint  Caps;
    GUID  KeyExchangeType;
    uint  BufferAlignmentStart;
    uint  BlockAlignmentSize;
    ulong ProtectedMemorySize;
}

// Functions

@DllImport("dxva2")
HRESULT DXVAHD_CreateDevice(IDirect3DDevice9Ex pD3DDevice, const(DXVAHD_CONTENT_DESC)* pContentDesc, 
                            DXVAHD_DEVICE_USAGE Usage, PDXVAHDSW_Plugin pPlugin, IDXVAHD_Device* ppDevice);

@DllImport("dxva2")
HRESULT DXVA2CreateDirect3DDeviceManager9(uint* pResetToken, IDirect3DDeviceManager9* ppDeviceManager);

@DllImport("dxva2")
HRESULT DXVA2CreateVideoService(IDirect3DDevice9 pDD, const(GUID)* riid, void** ppService);

@DllImport("dxva2")
HRESULT OPMGetVideoOutputsFromHMONITOR(ptrdiff_t hMonitor, OPM_VIDEO_OUTPUT_SEMANTICS vos, 
                                       uint* pulNumVideoOutputs, IOPMVideoOutput** pppOPMVideoOutputArray);

@DllImport("dxva2")
HRESULT OPMGetVideoOutputForTarget(LUID* pAdapterLuid, uint VidPnTarget, OPM_VIDEO_OUTPUT_SEMANTICS vos, 
                                   IOPMVideoOutput* ppOPMVideoOutput);

@DllImport("dxva2")
HRESULT OPMGetVideoOutputsFromIDirect3DDevice9Object(IDirect3DDevice9 pDirect3DDevice9, 
                                                     OPM_VIDEO_OUTPUT_SEMANTICS vos, uint* pulNumVideoOutputs, 
                                                     IOPMVideoOutput** pppOPMVideoOutputArray);

@DllImport("MFPlat")
HRESULT MFSerializeAttributesToStream(IMFAttributes pAttr, uint dwOptions, IStream pStm);

@DllImport("MFPlat")
HRESULT MFDeserializeAttributesFromStream(IMFAttributes pAttr, uint dwOptions, IStream pStm);

@DllImport("MFPlat")
HRESULT MFCreateTransformActivate(IMFActivate* ppActivate);

@DllImport("MF")
HRESULT MFCreateMediaSession(IMFAttributes pConfiguration, IMFMediaSession* ppMediaSession);

@DllImport("MF")
HRESULT MFCreatePMPMediaSession(uint dwCreationFlags, IMFAttributes pConfiguration, 
                                IMFMediaSession* ppMediaSession, IMFActivate* ppEnablerActivate);

@DllImport("MFPlat")
HRESULT MFCreateSourceResolver(IMFSourceResolver* ppISourceResolver);

@DllImport("MFPlat")
HRESULT CreatePropertyStore(IPropertyStore* ppStore);

@DllImport("MFPlat")
HRESULT MFGetSupportedSchemes(PROPVARIANT* pPropVarSchemeArray);

@DllImport("MFPlat")
HRESULT MFGetSupportedMimeTypes(PROPVARIANT* pPropVarMimeTypeArray);

@DllImport("MF")
HRESULT MFCreateTopology(IMFTopology* ppTopo);

@DllImport("MF")
HRESULT MFCreateTopologyNode(MF_TOPOLOGY_TYPE NodeType, IMFTopologyNode* ppNode);

@DllImport("MF")
HRESULT MFGetTopoNodeCurrentType(IMFTopologyNode pNode, uint dwStreamIndex, BOOL fOutput, IMFMediaType* ppType);

@DllImport("MF")
HRESULT MFGetService(IUnknown punkObject, const(GUID)* guidService, const(GUID)* riid, void** ppvObject);

@DllImport("MFPlat")
long MFGetSystemTime();

@DllImport("MF")
HRESULT MFCreatePresentationClock(IMFPresentationClock* ppPresentationClock);

@DllImport("MFPlat")
HRESULT MFCreateSystemTimeSource(IMFPresentationTimeSource* ppSystemTimeSource);

@DllImport("MFPlat")
HRESULT MFCreatePresentationDescriptor(uint cStreamDescriptors, char* apStreamDescriptors, 
                                       IMFPresentationDescriptor* ppPresentationDescriptor);

@DllImport("MF")
HRESULT MFRequireProtectedEnvironment(IMFPresentationDescriptor pPresentationDescriptor);

@DllImport("MFPlat")
HRESULT MFSerializePresentationDescriptor(IMFPresentationDescriptor pPD, uint* pcbData, char* ppbData);

@DllImport("MFPlat")
HRESULT MFDeserializePresentationDescriptor(uint cbData, char* pbData, IMFPresentationDescriptor* ppPD);

@DllImport("MFPlat")
HRESULT MFCreateStreamDescriptor(uint dwStreamIdentifier, uint cMediaTypes, char* apMediaTypes, 
                                 IMFStreamDescriptor* ppDescriptor);

@DllImport("MF")
HRESULT MFCreateSimpleTypeHandler(IMFMediaTypeHandler* ppHandler);

@DllImport("MF")
HRESULT MFShutdownObject(IUnknown pUnk);

@DllImport("MF")
HRESULT MFCreateAudioRenderer(IMFAttributes pAudioAttributes, IMFMediaSink* ppSink);

@DllImport("MF")
HRESULT MFCreateAudioRendererActivate(IMFActivate* ppActivate);

@DllImport("MF")
HRESULT MFCreateVideoRendererActivate(HWND hwndVideo, IMFActivate* ppActivate);

@DllImport("MF")
HRESULT MFCreateMPEG4MediaSink(IMFByteStream pIByteStream, IMFMediaType pVideoMediaType, 
                               IMFMediaType pAudioMediaType, IMFMediaSink* ppIMediaSink);

@DllImport("MF")
HRESULT MFCreate3GPMediaSink(IMFByteStream pIByteStream, IMFMediaType pVideoMediaType, 
                             IMFMediaType pAudioMediaType, IMFMediaSink* ppIMediaSink);

@DllImport("MF")
HRESULT MFCreateMP3MediaSink(IMFByteStream pTargetByteStream, IMFMediaSink* ppMediaSink);

@DllImport("MF")
HRESULT MFCreateAC3MediaSink(IMFByteStream pTargetByteStream, IMFMediaType pAudioMediaType, 
                             IMFMediaSink* ppMediaSink);

@DllImport("MF")
HRESULT MFCreateADTSMediaSink(IMFByteStream pTargetByteStream, IMFMediaType pAudioMediaType, 
                              IMFMediaSink* ppMediaSink);

@DllImport("MF")
HRESULT MFCreateMuxSink(GUID guidOutputSubType, IMFAttributes pOutputAttributes, IMFByteStream pOutputByteStream, 
                        IMFMediaSink* ppMuxSink);

@DllImport("MF")
HRESULT MFCreateFMPEG4MediaSink(IMFByteStream pIByteStream, IMFMediaType pVideoMediaType, 
                                IMFMediaType pAudioMediaType, IMFMediaSink* ppIMediaSink);

@DllImport("mfsrcsnk")
HRESULT MFCreateAVIMediaSink(IMFByteStream pIByteStream, IMFMediaType pVideoMediaType, 
                             IMFMediaType pAudioMediaType, IMFMediaSink* ppIMediaSink);

@DllImport("mfsrcsnk")
HRESULT MFCreateWAVEMediaSink(IMFByteStream pTargetByteStream, IMFMediaType pAudioMediaType, 
                              IMFMediaSink* ppMediaSink);

@DllImport("MF")
HRESULT MFCreateTopoLoader(IMFTopoLoader* ppObj);

@DllImport("MF")
HRESULT MFCreateSampleGrabberSinkActivate(IMFMediaType pIMFMediaType, 
                                          IMFSampleGrabberSinkCallback pIMFSampleGrabberSinkCallback, 
                                          IMFActivate* ppIActivate);

@DllImport("MF")
HRESULT MFCreateStandardQualityManager(IMFQualityManager* ppQualityManager);

@DllImport("MF")
HRESULT MFCreateSequencerSource(IUnknown pReserved, IMFSequencerSource* ppSequencerSource);

@DllImport("MF")
HRESULT MFCreateSequencerSegmentOffset(uint dwId, long hnsOffset, PROPVARIANT* pvarSegmentOffset);

@DllImport("MF")
HRESULT MFCreateAggregateSource(IMFCollection pSourceCollection, IMFMediaSource* ppAggSource);

@DllImport("MF")
HRESULT MFCreateCredentialCache(IMFNetCredentialCache* ppCache);

@DllImport("MF")
HRESULT MFCreateProxyLocator(const(wchar)* pszProtocol, IPropertyStore pProxyConfig, 
                             IMFNetProxyLocator* ppProxyLocator);

@DllImport("MF")
HRESULT MFCreateNetSchemePlugin(const(GUID)* riid, void** ppvHandler);

@DllImport("MF")
HRESULT MFCreatePMPServer(uint dwCreationFlags, IMFPMPServer* ppPMPServer);

@DllImport("MF")
HRESULT MFCreateRemoteDesktopPlugin(IMFRemoteDesktopPlugin* ppPlugin);

@DllImport("MF")
HRESULT CreateNamedPropertyStore(INamedPropertyStore* ppStore);

@DllImport("MF")
HRESULT MFCreateSampleCopierMFT(IMFTransform* ppCopierMFT);

@DllImport("MF")
HRESULT MFCreateTranscodeProfile(IMFTranscodeProfile* ppTranscodeProfile);

@DllImport("MF")
HRESULT MFCreateTranscodeTopology(IMFMediaSource pSrc, const(wchar)* pwszOutputFilePath, 
                                  IMFTranscodeProfile pProfile, IMFTopology* ppTranscodeTopo);

@DllImport("MF")
HRESULT MFCreateTranscodeTopologyFromByteStream(IMFMediaSource pSrc, IMFByteStream pOutputStream, 
                                                IMFTranscodeProfile pProfile, IMFTopology* ppTranscodeTopo);

@DllImport("MF")
HRESULT MFTranscodeGetAudioOutputAvailableTypes(const(GUID)* guidSubType, uint dwMFTFlags, 
                                                IMFAttributes pCodecConfig, IMFCollection* ppAvailableTypes);

@DllImport("MF")
HRESULT MFCreateTranscodeSinkActivate(IMFActivate* ppActivate);

@DllImport("MFPlat")
HRESULT MFCreateTrackedSample(IMFTrackedSample* ppMFSample);

@DllImport("MFPlat")
HRESULT MFCreateMFByteStreamOnStream(IStream pStream, IMFByteStream* ppByteStream);

@DllImport("MFPlat")
HRESULT MFCreateStreamOnMFByteStream(IMFByteStream pByteStream, IStream* ppStream);

@DllImport("MFPlat")
HRESULT MFCreateMFByteStreamOnStreamEx(IUnknown punkStream, IMFByteStream* ppByteStream);

@DllImport("MFPlat")
HRESULT MFCreateStreamOnMFByteStreamEx(IMFByteStream pByteStream, const(GUID)* riid, void** ppv);

@DllImport("MFPlat")
HRESULT MFCreateMediaTypeFromProperties(IUnknown punkStream, IMFMediaType* ppMediaType);

@DllImport("MFPlat")
HRESULT MFCreatePropertiesFromMediaType(IMFMediaType pMediaType, const(GUID)* riid, void** ppv);

@DllImport("MF")
HRESULT MFEnumDeviceSources(IMFAttributes pAttributes, IMFActivate** pppSourceActivate, uint* pcSourceActivate);

@DllImport("MF")
HRESULT MFCreateDeviceSource(IMFAttributes pAttributes, IMFMediaSource* ppSource);

@DllImport("MF")
HRESULT MFCreateDeviceSourceActivate(IMFAttributes pAttributes, IMFActivate* ppActivate);

@DllImport("MF")
HRESULT MFCreateProtectedEnvironmentAccess(IMFProtectedEnvironmentAccess* ppAccess);

@DllImport("MF")
HRESULT MFLoadSignedLibrary(const(wchar)* pszName, IMFSignedLibrary* ppLib);

@DllImport("MF")
HRESULT MFGetSystemId(IMFSystemId* ppId);

@DllImport("MF")
HRESULT MFGetLocalId(char* verifier, uint size, ushort** id);

@DllImport("MFPlat")
HRESULT MFCreateContentProtectionDevice(const(GUID)* ProtectionSystemId, 
                                        IMFContentProtectionDevice* ContentProtectionDevice);

@DllImport("MFPlat")
HRESULT MFIsContentProtectionDeviceSupported(const(GUID)* ProtectionSystemId, int* isSupported);

@DllImport("MFPlat")
HRESULT MFCreateContentDecryptorContext(const(GUID)* guidMediaProtectionSystemId, IMFDXGIDeviceManager pD3DManager, 
                                        IMFContentProtectionDevice pContentProtectionDevice, 
                                        IMFContentDecryptorContext* ppContentDecryptorContext);

@DllImport("MFSENSORGROUP")
HRESULT MFCreateSensorGroup(const(wchar)* SensorGroupSymbolicLink, IMFSensorGroup* ppSensorGroup);

@DllImport("MFSENSORGROUP")
HRESULT MFCreateSensorStream(uint StreamId, IMFAttributes pAttributes, IMFCollection pMediaTypeCollection, 
                             IMFSensorStream* ppStream);

@DllImport("MFSENSORGROUP")
HRESULT MFCreateSensorProfile(const(GUID)* ProfileType, uint ProfileIndex, const(wchar)* Constraints, 
                              IMFSensorProfile* ppProfile);

@DllImport("MFSENSORGROUP")
HRESULT MFCreateSensorProfileCollection(IMFSensorProfileCollection* ppSensorProfile);

@DllImport("MFSENSORGROUP")
HRESULT MFCreateSensorActivityMonitor(IMFSensorActivitiesReportCallback pCallback, 
                                      IMFSensorActivityMonitor* ppActivityMonitor);

@DllImport("MFCORE")
HRESULT MFCreateExtendedCameraIntrinsics(IMFExtendedCameraIntrinsics* ppExtendedCameraIntrinsics);

@DllImport("MFCORE")
HRESULT MFCreateExtendedCameraIntrinsicModel(const(MFCameraIntrinsic_DistortionModelType) distortionModelType, 
                                             IMFExtendedCameraIntrinsicModel* ppExtendedCameraIntrinsicModel);

@DllImport("MFSENSORGROUP")
HRESULT MFCreateRelativePanelWatcher(const(wchar)* videoDeviceId, const(wchar)* displayMonitorDeviceId, 
                                     IMFRelativePanelWatcher* ppRelativePanelWatcher);

@DllImport("MF")
HRESULT MFCreateASFContentInfo(IMFASFContentInfo* ppIContentInfo);

@DllImport("MF")
HRESULT MFCreateASFIndexer(IMFASFIndexer* ppIIndexer);

@DllImport("MF")
HRESULT MFCreateASFIndexerByteStream(IMFByteStream pIContentByteStream, ulong cbIndexStartOffset, 
                                     IMFByteStream* pIIndexByteStream);

@DllImport("MF")
HRESULT MFCreateASFSplitter(IMFASFSplitter* ppISplitter);

@DllImport("MF")
HRESULT MFCreateASFProfile(IMFASFProfile* ppIProfile);

@DllImport("MF")
HRESULT MFCreateASFProfileFromPresentationDescriptor(IMFPresentationDescriptor pIPD, IMFASFProfile* ppIProfile);

@DllImport("MF")
HRESULT MFCreatePresentationDescriptorFromASFProfile(IMFASFProfile pIProfile, IMFPresentationDescriptor* ppIPD);

@DllImport("MF")
HRESULT MFCreateASFMultiplexer(IMFASFMultiplexer* ppIMultiplexer);

@DllImport("MF")
HRESULT MFCreateASFStreamSelector(IMFASFProfile pIASFProfile, IMFASFStreamSelector* ppSelector);

@DllImport("MF")
HRESULT MFCreateASFMediaSink(IMFByteStream pIByteStream, IMFMediaSink* ppIMediaSink);

@DllImport("MF")
HRESULT MFCreateASFMediaSinkActivate(const(wchar)* pwszFileName, IMFASFContentInfo pContentInfo, 
                                     IMFActivate* ppIActivate);

@DllImport("MF")
HRESULT MFCreateWMVEncoderActivate(IMFMediaType pMediaType, IPropertyStore pEncodingConfigurationProperties, 
                                   IMFActivate* ppActivate);

@DllImport("MF")
HRESULT MFCreateWMAEncoderActivate(IMFMediaType pMediaType, IPropertyStore pEncodingConfigurationProperties, 
                                   IMFActivate* ppActivate);

@DllImport("MF")
HRESULT MFCreateASFStreamingMediaSink(IMFByteStream pIByteStream, IMFMediaSink* ppIMediaSink);

@DllImport("MF")
HRESULT MFCreateASFStreamingMediaSinkActivate(IMFActivate pByteStreamActivate, IMFASFContentInfo pContentInfo, 
                                              IMFActivate* ppIActivate);

@DllImport("MFPlat")
HRESULT MFStartup(uint Version, uint dwFlags);

@DllImport("MFPlat")
HRESULT MFShutdown();

@DllImport("MFPlat")
HRESULT MFLockPlatform();

@DllImport("MFPlat")
HRESULT MFUnlockPlatform();

@DllImport("MFPlat")
HRESULT MFPutWorkItem(uint dwQueue, IMFAsyncCallback pCallback, IUnknown pState);

@DllImport("MFPlat")
HRESULT MFPutWorkItem2(uint dwQueue, int Priority, IMFAsyncCallback pCallback, IUnknown pState);

@DllImport("MFPlat")
HRESULT MFPutWorkItemEx(uint dwQueue, IMFAsyncResult pResult);

@DllImport("MFPlat")
HRESULT MFPutWorkItemEx2(uint dwQueue, int Priority, IMFAsyncResult pResult);

@DllImport("MFPlat")
HRESULT MFPutWaitingWorkItem(HANDLE hEvent, int Priority, IMFAsyncResult pResult, ulong* pKey);

@DllImport("MFPlat")
HRESULT MFAllocateSerialWorkQueue(uint dwWorkQueue, uint* pdwWorkQueue);

@DllImport("MFPlat")
HRESULT MFScheduleWorkItemEx(IMFAsyncResult pResult, long Timeout, ulong* pKey);

@DllImport("MFPlat")
HRESULT MFScheduleWorkItem(IMFAsyncCallback pCallback, IUnknown pState, long Timeout, ulong* pKey);

@DllImport("MFPlat")
HRESULT MFCancelWorkItem(ulong Key);

@DllImport("MFPlat")
HRESULT MFGetTimerPeriodicity(uint* Periodicity);

@DllImport("MFPlat")
HRESULT MFAddPeriodicCallback(MFPERIODICCALLBACK Callback, IUnknown pContext, uint* pdwKey);

@DllImport("MFPlat")
HRESULT MFRemovePeriodicCallback(uint dwKey);

@DllImport("MFPlat")
HRESULT MFAllocateWorkQueueEx(MFASYNC_WORKQUEUE_TYPE WorkQueueType, uint* pdwWorkQueue);

@DllImport("MFPlat")
HRESULT MFAllocateWorkQueue(uint* pdwWorkQueue);

@DllImport("MFPlat")
HRESULT MFLockWorkQueue(uint dwWorkQueue);

@DllImport("MFPlat")
HRESULT MFUnlockWorkQueue(uint dwWorkQueue);

@DllImport("MFPlat")
HRESULT MFBeginRegisterWorkQueueWithMMCSS(uint dwWorkQueueId, const(wchar)* wszClass, uint dwTaskId, 
                                          IMFAsyncCallback pDoneCallback, IUnknown pDoneState);

@DllImport("MFPlat")
HRESULT MFBeginRegisterWorkQueueWithMMCSSEx(uint dwWorkQueueId, const(wchar)* wszClass, uint dwTaskId, 
                                            int lPriority, IMFAsyncCallback pDoneCallback, IUnknown pDoneState);

@DllImport("MFPlat")
HRESULT MFEndRegisterWorkQueueWithMMCSS(IMFAsyncResult pResult, uint* pdwTaskId);

@DllImport("MFPlat")
HRESULT MFBeginUnregisterWorkQueueWithMMCSS(uint dwWorkQueueId, IMFAsyncCallback pDoneCallback, 
                                            IUnknown pDoneState);

@DllImport("MFPlat")
HRESULT MFEndUnregisterWorkQueueWithMMCSS(IMFAsyncResult pResult);

@DllImport("MFPlat")
HRESULT MFGetWorkQueueMMCSSClass(uint dwWorkQueueId, const(wchar)* pwszClass, uint* pcchClass);

@DllImport("MFPlat")
HRESULT MFGetWorkQueueMMCSSTaskId(uint dwWorkQueueId, uint* pdwTaskId);

@DllImport("MFPlat")
HRESULT MFRegisterPlatformWithMMCSS(const(wchar)* wszClass, uint* pdwTaskId, int lPriority);

@DllImport("MFPlat")
HRESULT MFUnregisterPlatformFromMMCSS();

@DllImport("MFPlat")
HRESULT MFLockSharedWorkQueue(const(wchar)* wszClass, int BasePriority, uint* pdwTaskId, uint* pID);

@DllImport("MFPlat")
HRESULT MFGetWorkQueueMMCSSPriority(uint dwWorkQueueId, int* lPriority);

@DllImport("MFPlat")
HRESULT MFCreateAsyncResult(IUnknown punkObject, IMFAsyncCallback pCallback, IUnknown punkState, 
                            IMFAsyncResult* ppAsyncResult);

@DllImport("MFPlat")
HRESULT MFInvokeCallback(IMFAsyncResult pAsyncResult);

@DllImport("MFPlat")
HRESULT MFCreateFile(MF_FILE_ACCESSMODE AccessMode, MF_FILE_OPENMODE OpenMode, MF_FILE_FLAGS fFlags, 
                     const(wchar)* pwszFileURL, IMFByteStream* ppIByteStream);

@DllImport("MFPlat")
HRESULT MFCreateTempFile(MF_FILE_ACCESSMODE AccessMode, MF_FILE_OPENMODE OpenMode, MF_FILE_FLAGS fFlags, 
                         IMFByteStream* ppIByteStream);

@DllImport("MFPlat")
HRESULT MFBeginCreateFile(MF_FILE_ACCESSMODE AccessMode, MF_FILE_OPENMODE OpenMode, MF_FILE_FLAGS fFlags, 
                          const(wchar)* pwszFilePath, IMFAsyncCallback pCallback, IUnknown pState, 
                          IUnknown* ppCancelCookie);

@DllImport("MFPlat")
HRESULT MFEndCreateFile(IMFAsyncResult pResult, IMFByteStream* ppFile);

@DllImport("MFPlat")
HRESULT MFCancelCreateFile(IUnknown pCancelCookie);

@DllImport("MFPlat")
HRESULT MFCreateMemoryBuffer(uint cbMaxLength, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat")
HRESULT MFCreateMediaBufferWrapper(IMFMediaBuffer pBuffer, uint cbOffset, uint dwLength, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat")
HRESULT MFCreateLegacyMediaBufferOnMFMediaBuffer(IMFSample pSample, IMFMediaBuffer pMFMediaBuffer, uint cbOffset, 
                                                 IMediaBuffer* ppMediaBuffer);

@DllImport("MFPlat")
DXGI_FORMAT MFMapDX9FormatToDXGIFormat(uint dx9);

@DllImport("MFPlat")
uint MFMapDXGIFormatToDX9Format(DXGI_FORMAT dx11);

@DllImport("MFPlat")
HRESULT MFLockDXGIDeviceManager(uint* pResetToken, IMFDXGIDeviceManager* ppManager);

@DllImport("MFPlat")
HRESULT MFUnlockDXGIDeviceManager();

@DllImport("MFPlat")
HRESULT MFCreateDXSurfaceBuffer(const(GUID)* riid, IUnknown punkSurface, BOOL fBottomUpWhenLinear, 
                                IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat")
HRESULT MFCreateWICBitmapBuffer(const(GUID)* riid, IUnknown punkSurface, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat")
HRESULT MFCreateDXGISurfaceBuffer(const(GUID)* riid, IUnknown punkSurface, uint uSubresourceIndex, 
                                  BOOL fBottomUpWhenLinear, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat")
HRESULT MFCreateVideoSampleAllocatorEx(const(GUID)* riid, void** ppSampleAllocator);

@DllImport("MFPlat")
HRESULT MFCreateDXGIDeviceManager(uint* resetToken, IMFDXGIDeviceManager* ppDeviceManager);

@DllImport("MFPlat")
HRESULT MFCreateAlignedMemoryBuffer(uint cbMaxLength, uint cbAligment, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat")
HRESULT MFCreateMediaEvent(uint met, const(GUID)* guidExtendedType, HRESULT hrStatus, const(PROPVARIANT)* pvValue, 
                           IMFMediaEvent* ppEvent);

@DllImport("MFPlat")
HRESULT MFCreateEventQueue(IMFMediaEventQueue* ppMediaEventQueue);

@DllImport("MFPlat")
HRESULT MFCreateSample(IMFSample* ppIMFSample);

@DllImport("MFPlat")
HRESULT MFCreateAttributes(IMFAttributes* ppMFAttributes, uint cInitialSize);

@DllImport("MFPlat")
HRESULT MFInitAttributesFromBlob(IMFAttributes pAttributes, char* pBuf, uint cbBufSize);

@DllImport("MFPlat")
HRESULT MFGetAttributesAsBlobSize(IMFAttributes pAttributes, uint* pcbBufSize);

@DllImport("MFPlat")
HRESULT MFGetAttributesAsBlob(IMFAttributes pAttributes, char* pBuf, uint cbBufSize);

@DllImport("MFPlat")
HRESULT MFTRegister(GUID clsidMFT, GUID guidCategory, const(wchar)* pszName, uint Flags, uint cInputTypes, 
                    char* pInputTypes, uint cOutputTypes, char* pOutputTypes, IMFAttributes pAttributes);

@DllImport("MFPlat")
HRESULT MFTUnregister(GUID clsidMFT);

@DllImport("MFPlat")
HRESULT MFTRegisterLocal(IClassFactory pClassFactory, const(GUID)* guidCategory, const(wchar)* pszName, uint Flags, 
                         uint cInputTypes, char* pInputTypes, uint cOutputTypes, char* pOutputTypes);

@DllImport("MFPlat")
HRESULT MFTUnregisterLocal(IClassFactory pClassFactory);

@DllImport("MFPlat")
HRESULT MFTRegisterLocalByCLSID(const(GUID)* clisdMFT, const(GUID)* guidCategory, const(wchar)* pszName, 
                                uint Flags, uint cInputTypes, char* pInputTypes, uint cOutputTypes, 
                                char* pOutputTypes);

@DllImport("MFPlat")
HRESULT MFTUnregisterLocalByCLSID(GUID clsidMFT);

@DllImport("MFPlat")
HRESULT MFTEnum(GUID guidCategory, uint Flags, MFT_REGISTER_TYPE_INFO* pInputType, 
                MFT_REGISTER_TYPE_INFO* pOutputType, IMFAttributes pAttributes, GUID** ppclsidMFT, uint* pcMFTs);

@DllImport("MFPlat")
HRESULT MFTEnumEx(GUID guidCategory, uint Flags, const(MFT_REGISTER_TYPE_INFO)* pInputType, 
                  const(MFT_REGISTER_TYPE_INFO)* pOutputType, IMFActivate** pppMFTActivate, uint* pnumMFTActivate);

@DllImport("MFPlat")
HRESULT MFTEnum2(GUID guidCategory, uint Flags, const(MFT_REGISTER_TYPE_INFO)* pInputType, 
                 const(MFT_REGISTER_TYPE_INFO)* pOutputType, IMFAttributes pAttributes, IMFActivate** pppMFTActivate, 
                 uint* pnumMFTActivate);

@DllImport("MFPlat")
HRESULT MFTGetInfo(GUID clsidMFT, ushort** pszName, MFT_REGISTER_TYPE_INFO** ppInputTypes, uint* pcInputTypes, 
                   MFT_REGISTER_TYPE_INFO** ppOutputTypes, uint* pcOutputTypes, IMFAttributes* ppAttributes);

@DllImport("MFPlat")
HRESULT MFGetPluginControl(IMFPluginControl* ppPluginControl);

@DllImport("MFPlat")
HRESULT MFGetMFTMerit(IUnknown pMFT, uint cbVerifier, char* verifier, uint* merit);

@DllImport("MFPlat")
HRESULT MFRegisterLocalSchemeHandler(const(wchar)* szScheme, IMFActivate pActivate);

@DllImport("MFPlat")
HRESULT MFRegisterLocalByteStreamHandler(const(wchar)* szFileExtension, const(wchar)* szMimeType, 
                                         IMFActivate pActivate);

@DllImport("MFPlat")
HRESULT MFCreateMFByteStreamWrapper(IMFByteStream pStream, IMFByteStream* ppStreamWrapper);

@DllImport("MFPlat")
HRESULT MFCreateMediaExtensionActivate(const(wchar)* szActivatableClassId, IUnknown pConfiguration, 
                                       const(GUID)* riid, void** ppvObject);

@DllImport("MFPlat")
HRESULT MFCreateMuxStreamAttributes(IMFCollection pAttributesToMux, IMFAttributes* ppMuxAttribs);

@DllImport("MFPlat")
HRESULT MFCreateMuxStreamMediaType(IMFCollection pMediaTypesToMux, IMFMediaType* ppMuxMediaType);

@DllImport("MFPlat")
HRESULT MFCreateMuxStreamSample(IMFCollection pSamplesToMux, IMFSample* ppMuxSample);

@DllImport("MFPlat")
HRESULT MFValidateMediaTypeSize(GUID FormatType, char* pBlock, uint cbSize);

@DllImport("MFPlat")
HRESULT MFCreateMediaType(IMFMediaType* ppMFType);

@DllImport("MFPlat")
HRESULT MFCreateMFVideoFormatFromMFMediaType(IMFMediaType pMFType, MFVIDEOFORMAT** ppMFVF, uint* pcbSize);

@DllImport("MFPlat")
HRESULT MFCreateWaveFormatExFromMFMediaType(IMFMediaType pMFType, WAVEFORMATEX** ppWF, uint* pcbSize, uint Flags);

@DllImport("MFPlat")
HRESULT MFInitMediaTypeFromVideoInfoHeader(IMFMediaType pMFType, char* pVIH, uint cbBufSize, const(GUID)* pSubtype);

@DllImport("MFPlat")
HRESULT MFInitMediaTypeFromVideoInfoHeader2(IMFMediaType pMFType, char* pVIH2, uint cbBufSize, 
                                            const(GUID)* pSubtype);

@DllImport("MFPlat")
HRESULT MFInitMediaTypeFromMPEG1VideoInfo(IMFMediaType pMFType, char* pMP1VI, uint cbBufSize, 
                                          const(GUID)* pSubtype);

@DllImport("MFPlat")
HRESULT MFInitMediaTypeFromMPEG2VideoInfo(IMFMediaType pMFType, char* pMP2VI, uint cbBufSize, 
                                          const(GUID)* pSubtype);

@DllImport("MFPlat")
HRESULT MFCalculateBitmapImageSize(char* pBMIH, uint cbBufSize, uint* pcbImageSize, int* pbKnown);

@DllImport("MFPlat")
HRESULT MFCalculateImageSize(const(GUID)* guidSubtype, uint unWidth, uint unHeight, uint* pcbImageSize);

@DllImport("MFPlat")
HRESULT MFFrameRateToAverageTimePerFrame(uint unNumerator, uint unDenominator, ulong* punAverageTimePerFrame);

@DllImport("MFPlat")
HRESULT MFAverageTimePerFrameToFrameRate(ulong unAverageTimePerFrame, uint* punNumerator, uint* punDenominator);

@DllImport("MFPlat")
HRESULT MFInitMediaTypeFromMFVideoFormat(IMFMediaType pMFType, char* pMFVF, uint cbBufSize);

@DllImport("MFPlat")
HRESULT MFInitMediaTypeFromWaveFormatEx(IMFMediaType pMFType, char* pWaveFormat, uint cbBufSize);

@DllImport("MFPlat")
HRESULT MFInitMediaTypeFromAMMediaType(IMFMediaType pMFType, const(AM_MEDIA_TYPE)* pAMType);

@DllImport("MFPlat")
HRESULT MFInitAMMediaTypeFromMFMediaType(IMFMediaType pMFType, GUID guidFormatBlockType, AM_MEDIA_TYPE* pAMType);

@DllImport("MFPlat")
HRESULT MFCreateAMMediaTypeFromMFMediaType(IMFMediaType pMFType, GUID guidFormatBlockType, 
                                           AM_MEDIA_TYPE** ppAMType);

@DllImport("MFPlat")
BOOL MFCompareFullToPartialMediaType(IMFMediaType pMFTypeFull, IMFMediaType pMFTypePartial);

@DllImport("MFPlat")
HRESULT MFWrapMediaType(IMFMediaType pOrig, const(GUID)* MajorType, const(GUID)* SubType, IMFMediaType* ppWrap);

@DllImport("MFPlat")
HRESULT MFUnwrapMediaType(IMFMediaType pWrap, IMFMediaType* ppOrig);

@DllImport("MFPlat")
HRESULT MFCreateVideoMediaType(const(MFVIDEOFORMAT)* pVideoFormat, IMFVideoMediaType* ppIVideoMediaType);

@DllImport("MFPlat")
HRESULT MFCreateVideoMediaTypeFromSubtype(const(GUID)* pAMSubtype, IMFVideoMediaType* ppIVideoMediaType);

@DllImport("EVR")
BOOL MFIsFormatYUV(uint Format);

@DllImport("MFPlat")
HRESULT MFCreateVideoMediaTypeFromBitMapInfoHeader(const(BITMAPINFOHEADER)* pbmihBitMapInfoHeader, 
                                                   uint dwPixelAspectRatioX, uint dwPixelAspectRatioY, 
                                                   MFVideoInterlaceMode InterlaceMode, ulong VideoFlags, 
                                                   ulong qwFramesPerSecondNumerator, 
                                                   ulong qwFramesPerSecondDenominator, uint dwMaxBitRate, 
                                                   IMFVideoMediaType* ppIVideoMediaType);

@DllImport("MFPlat")
HRESULT MFGetStrideForBitmapInfoHeader(uint format, uint dwWidth, int* pStride);

@DllImport("MFPlat")
HRESULT MFGetPlaneSize(uint format, uint dwWidth, uint dwHeight, uint* pdwPlaneSize);

@DllImport("MFPlat")
HRESULT MFCreateVideoMediaTypeFromBitMapInfoHeaderEx(char* pbmihBitMapInfoHeader, uint cbBitMapInfoHeader, 
                                                     uint dwPixelAspectRatioX, uint dwPixelAspectRatioY, 
                                                     MFVideoInterlaceMode InterlaceMode, ulong VideoFlags, 
                                                     uint dwFramesPerSecondNumerator, 
                                                     uint dwFramesPerSecondDenominator, uint dwMaxBitRate, 
                                                     IMFVideoMediaType* ppIVideoMediaType);

@DllImport("MFPlat")
HRESULT MFCreateMediaTypeFromRepresentation(GUID guidRepresentation, void* pvRepresentation, 
                                            IMFMediaType* ppIMediaType);

@DllImport("MFPlat")
HRESULT MFCreateAudioMediaType(const(WAVEFORMATEX)* pAudioFormat, IMFAudioMediaType* ppIAudioMediaType);

@DllImport("MFPlat")
uint MFGetUncompressedVideoFormat(const(MFVIDEOFORMAT)* pVideoFormat);

@DllImport("MFPlat")
HRESULT MFInitVideoFormat(MFVIDEOFORMAT* pVideoFormat, MFStandardVideoFormat type);

@DllImport("MFPlat")
HRESULT MFInitVideoFormat_RGB(MFVIDEOFORMAT* pVideoFormat, uint dwWidth, uint dwHeight, uint D3Dfmt);

@DllImport("MFPlat")
HRESULT MFConvertColorInfoToDXVA(uint* pdwToDXVA, const(MFVIDEOFORMAT)* pFromFormat);

@DllImport("MFPlat")
HRESULT MFConvertColorInfoFromDXVA(MFVIDEOFORMAT* pToFormat, uint dwFromDXVA);

@DllImport("MFPlat")
HRESULT MFCopyImage(char* pDest, int lDestStride, char* pSrc, int lSrcStride, uint dwWidthInBytes, uint dwLines);

@DllImport("MFPlat")
HRESULT MFConvertFromFP16Array(char* pDest, char* pSrc, uint dwCount);

@DllImport("MFPlat")
HRESULT MFConvertToFP16Array(char* pDest, char* pSrc, uint dwCount);

@DllImport("MFPlat")
HRESULT MFCreate2DMediaBuffer(uint dwWidth, uint dwHeight, uint dwFourCC, BOOL fBottomUp, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat")
HRESULT MFCreateMediaBufferFromMediaType(IMFMediaType pMediaType, long llDuration, uint dwMinLength, 
                                         uint dwMinAlignment, IMFMediaBuffer* ppBuffer);

@DllImport("MFPlat")
HRESULT MFCreateCollection(IMFCollection* ppIMFCollection);

@DllImport("MFPlat")
void* MFHeapAlloc(size_t nSize, uint dwFlags, byte* pszFile, int line, EAllocationType eat);

@DllImport("MFPlat")
void MFHeapFree(void* pv);

@DllImport("MFPlat")
long MFllMulDiv(long a, long b, long c, long d);

@DllImport("MFPlat")
HRESULT MFGetContentProtectionSystemCLSID(const(GUID)* guidProtectionSystemID, GUID* pclsid);

@DllImport("MFPlat")
HRESULT MFCombineSamples(IMFSample pSample, IMFSample pSampleToAdd, uint dwMaxMergedDurationInMS, int* pMerged);

@DllImport("MFPlat")
HRESULT MFSplitSample(IMFSample pSample, char* pOutputSamples, uint dwOutputSampleMaxCount, 
                      uint* pdwOutputSampleCount);

@DllImport("MFReadWrite")
HRESULT MFCreateSourceReaderFromURL(const(wchar)* pwszURL, IMFAttributes pAttributes, 
                                    IMFSourceReader* ppSourceReader);

@DllImport("MFReadWrite")
HRESULT MFCreateSourceReaderFromByteStream(IMFByteStream pByteStream, IMFAttributes pAttributes, 
                                           IMFSourceReader* ppSourceReader);

@DllImport("MFReadWrite")
HRESULT MFCreateSourceReaderFromMediaSource(IMFMediaSource pMediaSource, IMFAttributes pAttributes, 
                                            IMFSourceReader* ppSourceReader);

@DllImport("MFReadWrite")
HRESULT MFCreateSinkWriterFromURL(const(wchar)* pwszOutputURL, IMFByteStream pByteStream, 
                                  IMFAttributes pAttributes, IMFSinkWriter* ppSinkWriter);

@DllImport("MFReadWrite")
HRESULT MFCreateSinkWriterFromMediaSink(IMFMediaSink pMediaSink, IMFAttributes pAttributes, 
                                        IMFSinkWriter* ppSinkWriter);

@DllImport("EVR")
HRESULT MFCreateVideoPresenter(IUnknown pOwner, const(GUID)* riidDevice, const(GUID)* riid, 
                               void** ppVideoPresenter);

@DllImport("EVR")
HRESULT MFCreateVideoMixer(IUnknown pOwner, const(GUID)* riidDevice, const(GUID)* riid, void** ppv);

@DllImport("EVR")
HRESULT MFCreateVideoMixerAndPresenter(IUnknown pMixerOwner, IUnknown pPresenterOwner, const(GUID)* riidMixer, 
                                       void** ppvVideoMixer, const(GUID)* riidPresenter, void** ppvVideoPresenter);

@DllImport("MF")
HRESULT MFCreateVideoRenderer(const(GUID)* riidRenderer, void** ppVideoRenderer);

@DllImport("EVR")
HRESULT MFCreateVideoSampleFromSurface(IUnknown pUnkSurface, IMFSample* ppSample);

@DllImport("EVR")
HRESULT MFCreateVideoSampleAllocator(const(GUID)* riid, void** ppSampleAllocator);

@DllImport("MFPlay")
HRESULT MFPCreateMediaPlayer(const(wchar)* pwszURL, BOOL fStartPlayback, uint creationOptions, 
                             IMFPMediaPlayerCallback pCallback, HWND hWnd, IMFPMediaPlayer* ppMediaPlayer);

@DllImport("MF")
HRESULT MFCreateEncryptedMediaExtensionsStoreActivate(IMFPMPHostApp pmpHost, IStream objectStream, 
                                                      const(wchar)* classId, IMFActivate* activate);


// Interfaces

@GUID("F371728A-6052-4D47-827C-D039335DFE0A")
struct CMpeg4DecMediaObject;

@GUID("CBA9E78B-49A3-49EA-93D4-6BCBA8C4DE07")
struct CMpeg43DecMediaObject;

@GUID("2A11BAE2-FE6E-4249-864B-9E9ED6E8DBC2")
struct CMpeg4sDecMediaObject;

@GUID("5686A0D9-FE39-409F-9DFF-3FDBC849F9F5")
struct CMpeg4sDecMFT;

@GUID("C56FC25C-0FC6-404A-9503-B10BF51A8AB9")
struct CZuneM4S2DecMediaObject;

@GUID("24F258D8-C651-4042-93E4-CA654ABB682C")
struct CMpeg4EncMediaObject;

@GUID("6EC5A7BE-D81E-4F9E-ADA3-CD1BF262B6D8")
struct CMpeg4sEncMediaObject;

@GUID("7BAFB3B1-D8F4-4279-9253-27DA423108DE")
struct CMSSCDecMediaObject;

@GUID("8CB9CC06-D139-4AE6-8BB4-41E612E141D5")
struct CMSSCEncMediaObject;

@GUID("F7FFE0A0-A4F5-44B5-949E-15ED2BC66F9D")
struct CMSSCEncMediaObject2;

@GUID("2EEB4ADF-4578-4D10-BCA7-BB955F56320A")
struct CWMADecMediaObject;

@GUID("70F598E9-F4AB-495A-99E2-A7C4D3D89ABF")
struct CWMAEncMediaObject;

@GUID("EDCAD9CB-3127-40DF-B527-0152CCB3F6F5")
struct CWMATransMediaObject;

@GUID("874131CB-4ECC-443B-8948-746B89595D20")
struct CWMSPDecMediaObject;

@GUID("67841B03-C689-4188-AD3F-4C9EBEEC710B")
struct CWMSPEncMediaObject;

@GUID("1F1F4E1A-2252-4063-84BB-EEE75F8856D5")
struct CWMSPEncMediaObject2;

@GUID("F9DBC64E-2DD0-45DD-9B52-66642EF94431")
struct CWMTDecMediaObject;

@GUID("60B67652-E46B-4E44-8609-F74BFFDC083C")
struct CWMTEncMediaObject;

@GUID("82D353DF-90BD-4382-8BC2-3F6192B76E34")
struct CWMVDecMediaObject;

@GUID("96B57CDD-8966-410C-BB1F-C97EEA765C04")
struct CWMVEncMediaObject2;

@GUID("7E320092-596A-41B2-BBEB-175D10504EB6")
struct CWMVXEncMediaObject;

@GUID("D23B90D0-144F-46BD-841D-59E4EB19DC59")
struct CWMV9EncMediaObject;

@GUID("C9BFBCCF-E60E-4588-A3DF-5A03B1FD9585")
struct CWVC1DecMediaObject;

@GUID("44653D0D-8CCA-41E7-BACA-884337B747AC")
struct CWVC1EncMediaObject;

@GUID("49034C05-F43C-400F-84C1-90A683195A3A")
struct CDeColorConvMediaObject;

@GUID("E54709C5-1E17-4C8D-94E7-478940433584")
struct CDVDecoderMediaObject;

@GUID("C82AE729-C327-4CCE-914D-8171FEFEBEFB")
struct CDVEncoderMediaObject;

@GUID("863D66CD-CDCE-4617-B47F-C8929CFC28A6")
struct CMpeg2DecMediaObject;

@GUID("9910C5CD-95C9-4E06-865A-EFA1C8016BF4")
struct CPK_DS_MPEG2Decoder;

@GUID("03D7C802-ECFA-47D9-B268-5FB3E310DEE4")
struct CAC3DecMediaObject;

@GUID("6C9C69D6-0FFC-4481-AFDB-CDF1C79C6F3E")
struct CPK_DS_AC3Decoder;

@GUID("BBEEA841-0A63-4F52-A7AB-A9B3A84ED38A")
struct CMP3DecMediaObject;

@GUID("F447B69E-1884-4A7E-8055-346F74D6EDB3")
struct CResamplerMediaObject;

@GUID("D3EC8B8B-7728-4FD8-9FE0-7B67D19F73A3")
struct CResizerMediaObject;

@GUID("B5A89C80-4901-407B-9ABC-90D9A644BB46")
struct CInterlaceMediaObject;

@GUID("62DC1A93-AE24-464C-A43E-452F824C4250")
struct CWMAudioLFXAPO;

@GUID("637C490D-EEE3-4C0A-973F-371958802DA2")
struct CWMAudioGFXAPO;

@GUID("5210F8E4-B0BB-47C3-A8D9-7B2282CC79ED")
struct CWMAudioSpdTxDMO;

@GUID("745057C7-F353-4F2D-A7EE-58434477730E")
struct CWMAudioAEC;

@GUID("36E820C4-165A-4521-863C-619E1160D4D4")
struct CClusterDetectorDmo;

@GUID("798059F0-89CA-4160-B325-AEB48EFE4F9A")
struct CColorControlDmo;

@GUID("98230571-0087-4204-B020-3282538E57D3")
struct CColorConvertDMO;

@GUID("FDFAA753-E48E-4E33-9C74-98A27FC6726A")
struct CColorLegalizerDmo;

@GUID("0A7CFE1B-6AB5-4334-9ED8-3F97CB37DAA1")
struct CFrameInterpDMO;

@GUID("01F36CE2-0907-4D8B-979D-F151BE91C883")
struct CFrameRateConvertDmo;

@GUID("1EA1EA14-48F4-4054-AD1A-E8AEE10AC805")
struct CResizerDMO;

@GUID("56AEFACD-110C-4397-9292-B0A0C61B6750")
struct CShotDetectorDmo;

@GUID("BDE6388B-DA25-485D-BA7F-FABC28B20318")
struct CSmpteTransformsDmo;

@GUID("559C6BAD-1EA8-4963-A087-8A6810F9218B")
struct CThumbnailGeneratorDmo;

@GUID("4DDA1941-77A0-4FB1-A518-E2185041D70C")
struct CTocGeneratorDmo;

@GUID("8DDE1772-EDAD-41C3-B4BE-1F30FB4EE0D6")
struct CMPEGAACDecMediaObject;

@GUID("3CB2BDE4-4E29-4C44-A73E-2D7C2C46D6EC")
struct CNokiaAACDecMediaObject;

@GUID("7F36F942-DCF3-4D82-9289-5B1820278F7C")
struct CVodafoneAACDecMediaObject;

@GUID("A74E98F2-52D6-4B4E-885B-E0A6CA4F187A")
struct CZuneAACCCDecMediaObject;

@GUID("EABF7A6F-CCBA-4D60-8620-B152CC977263")
struct CNokiaAACCCDecMediaObject;

@GUID("7E76BF7F-C993-4E26-8FAB-470A70C0D59C")
struct CVodafoneAACCCDecMediaObject;

@GUID("5F5AFF4A-2F7F-4279-88C2-CD88EB39D144")
struct CMPEG2EncoderDS;

@GUID("42150CD9-CA9A-4EA5-9939-30EE037F6E74")
struct CMPEG2EncoderVideoDS;

@GUID("ACD453BC-C58A-44D1-BBF5-BFB325BE2D78")
struct CMPEG2EncoderAudioDS;

@GUID("E1F1A0B8-BEEE-490D-BA7C-066C40B5E2B9")
struct CMPEG2AudDecoderDS;

@GUID("212690FB-83E5-4526-8FD7-74478B7939CD")
struct CMPEG2VidDecoderDS;

@GUID("8E269032-FE03-4753-9B17-18253C21722E")
struct CDTVAudDecoderDS;

@GUID("64777DC8-4E24-4BEB-9D19-60A35BE1DAAF")
struct CDTVVidDecoderDS;

@GUID("C6B400E2-20A7-4E58-A2FE-24619682CE6C")
struct CMSAC3Enc;

@GUID("62CE7E72-4C71-4D20-B15D-452831A87D9D")
struct CMSH264DecoderMFT;

@GUID("BC47FCFE-98A0-4F27-BB07-698AF24F2B38")
struct CMSH263EncoderMFT;

@GUID("6CA50344-051A-4DED-9779-A43305165E35")
struct CMSH264EncoderMFT;

@GUID("F2F84074-8BCA-40BD-9159-E880F673DD3B")
struct CMSH265EncoderMFT;

@GUID("AEB6C755-2546-4881-82CC-E15AE5EBFF3D")
struct CMSVPXEncoderMFT;

@GUID("05A47EBB-8BF0-4CBF-AD2F-3B71D75866F5")
struct CMSH264RemuxMFT;

@GUID("32D186A7-218F-4C75-8876-DD77273A8999")
struct CMSAACDecMFT;

@GUID("93AF0C51-2275-45D2-A35B-F2BA21CAED00")
struct AACMFTEncoder;

@GUID("177C0AFE-900B-48D4-9E4C-57ADD250B3D4")
struct CMSDDPlusDecMFT;

@GUID("E6335F02-80B7-4DC4-ADFA-DFE7210D20D5")
struct CMPEG2VideoEncoderMFT;

@GUID("46A4DD5C-73F8-4304-94DF-308F760974F4")
struct CMPEG2AudioEncoderMFT;

@GUID("2D709E52-123F-49B5-9CBC-9AF5CDE28FB9")
struct CMSMPEGDecoderMFT;

@GUID("70707B39-B2CA-4015-ABEA-F8447D22D88B")
struct CMSMPEGAudDecMFT;

@GUID("AC3315C9-F481-45D7-826C-0B406C1F64B8")
struct CMSDolbyDigitalEncMFT;

@GUID("11103421-354C-4CCA-A7A3-1AFF9A5B6701")
struct MP3ACMCodecWrapper;

@GUID("36CB6E0C-78C1-42B2-9943-846262F31786")
struct ALawCodecWrapper;

@GUID("92B66080-5E2D-449E-90C4-C41F268E5514")
struct MULawCodecWrapper;

@GUID("51571744-7FE4-4FF2-A498-2DC34FF74F1B")
struct CMSVideoDSPMFT;

@GUID("1A198EF2-60E5-4EA8-90D8-DA1F2832C288")
struct VorbisDecoderMFT;

@GUID("6B0B3E6B-A2C5-4514-8055-AFE8A95242D9")
struct CMSFLACDecMFT;

@GUID("128509E9-C44E-45DC-95E9-C255B8F466A6")
struct CMSFLACEncMFT;

@GUID("0E41CFB8-0506-40F4-A516-77CC23642D91")
struct MFFLACBytestreamHandler;

@GUID("7D39C56F-6075-47C9-9BAE-8CF9E531B5F5")
struct MFFLACSinkClassFactory;

@GUID("C0CD7D12-31FC-4BBC-B363-7322EE3E1879")
struct CMSALACDecMFT;

@GUID("9AB6A28C-748E-4B6A-BFFF-CC443B8E8FB4")
struct CMSALACEncMFT;

@GUID("63E17C10-2D43-4C42-8FE3-8D8B63E46A6A")
struct CMSOpusDecMFT;

@GUID("265011AE-5481-4F77-A295-ABB6FFE8D63E")
struct MSAMRNBDecoder;

@GUID("2FAE8AFE-04A3-423A-A814-85DB454712B0")
struct MSAMRNBEncoder;

@GUID("EFE6208A-0A2C-49FA-8A01-3768B559B6DA")
struct MFAMRNBByteStreamHandler;

@GUID("B0271158-70D2-4C5B-9F94-76F549D90FDF")
struct MFAMRNBSinkClassFactory;

@GUID("06F414BB-F43A-4FE2-A566-774B4C81F0DB")
struct KSPROPSETID_OPMVideoOutput;

@GUID("901DB4C7-31CE-41A2-85DC-8FA0BF41B8DA")
interface ICodecAPI : IUnknown
{
    HRESULT IsSupported(const(GUID)* Api);
    HRESULT IsModifiable(const(GUID)* Api);
    HRESULT GetParameterRange(const(GUID)* Api, VARIANT* ValueMin, VARIANT* ValueMax, VARIANT* SteppingDelta);
    HRESULT GetParameterValues(const(GUID)* Api, char* Values, uint* ValuesCount);
    HRESULT GetDefaultValue(const(GUID)* Api, VARIANT* Value);
    HRESULT GetValue(const(GUID)* Api, VARIANT* Value);
    HRESULT SetValue(const(GUID)* Api, VARIANT* Value);
    HRESULT RegisterForEvent(const(GUID)* Api, ptrdiff_t userData);
    HRESULT UnregisterForEvent(const(GUID)* Api);
    HRESULT SetAllDefaults();
    HRESULT SetValueWithNotify(const(GUID)* Api, VARIANT* Value, char* ChangedParam, uint* ChangedParamCount);
    HRESULT SetAllDefaultsWithNotify(char* ChangedParam, uint* ChangedParamCount);
    HRESULT GetAllSettings(IStream __MIDL__ICodecAPI0000);
    HRESULT SetAllSettings(IStream __MIDL__ICodecAPI0001);
    HRESULT SetAllSettingsWithNotify(IStream __MIDL__ICodecAPI0002, char* ChangedParam, uint* ChangedParamCount);
}

@GUID("0946B7C9-EBF6-4047-BB73-8683E27DBB1F")
interface ID3D12VideoDecoderHeap : ID3D12Pageable
{
    D3D12_VIDEO_DECODER_HEAP_DESC GetDesc();
}

@GUID("1F052807-0B46-4ACC-8A89-364F793718A4")
interface ID3D12VideoDevice : IUnknown
{
    HRESULT CheckFeatureSupport(D3D12_FEATURE_VIDEO FeatureVideo, char* pFeatureSupportData, 
                                uint FeatureSupportDataSize);
    HRESULT CreateVideoDecoder(const(D3D12_VIDEO_DECODER_DESC)* pDesc, const(GUID)* riid, void** ppVideoDecoder);
    HRESULT CreateVideoDecoderHeap(const(D3D12_VIDEO_DECODER_HEAP_DESC)* pVideoDecoderHeapDesc, const(GUID)* riid, 
                                   void** ppVideoDecoderHeap);
    HRESULT CreateVideoProcessor(uint NodeMask, const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC)* pOutputStreamDesc, 
                                 uint NumInputStreamDescs, char* pInputStreamDescs, const(GUID)* riid, 
                                 void** ppVideoProcessor);
}

@GUID("C59B6BDC-7720-4074-A136-17A156037470")
interface ID3D12VideoDecoder : ID3D12Pageable
{
    D3D12_VIDEO_DECODER_DESC GetDesc();
}

@GUID("304FDB32-BEDE-410A-8545-943AC6A46138")
interface ID3D12VideoProcessor : ID3D12Pageable
{
    uint    GetNodeMask();
    uint    GetNumInputStreamDescs();
    HRESULT GetInputStreamDescs(uint NumInputStreamDescs, char* pInputStreamDescs);
    D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC GetOutputStreamDesc();
}

@GUID("3B60536E-AD29-4E64-A269-F853837E5E53")
interface ID3D12VideoDecodeCommandList : ID3D12CommandList
{
    HRESULT Close();
    HRESULT Reset(ID3D12CommandAllocator pAllocator);
    void    ClearState();
    void    ResourceBarrier(uint NumBarriers, char* pBarriers);
    void    DiscardResource(ID3D12Resource pResource, const(D3D12_DISCARD_REGION)* pRegion);
    void    BeginQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void    EndQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void    ResolveQueryData(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint StartIndex, uint NumQueries, 
                             ID3D12Resource pDestinationBuffer, ulong AlignedDestinationBufferOffset);
    void    SetPredication(ID3D12Resource pBuffer, ulong AlignedBufferOffset, D3D12_PREDICATION_OP Operation);
    void    SetMarker(uint Metadata, char* pData, uint Size);
    void    BeginEvent(uint Metadata, char* pData, uint Size);
    void    EndEvent();
    void    DecodeFrame(ID3D12VideoDecoder pDecoder, 
                        const(D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS)* pOutputArguments, 
                        const(D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS)* pInputArguments);
    void    WriteBufferImmediate(uint Count, char* pParams, char* pModes);
}

@GUID("AEB2543A-167F-4682-ACC8-D159ED4A6209")
interface ID3D12VideoProcessCommandList : ID3D12CommandList
{
    HRESULT Close();
    HRESULT Reset(ID3D12CommandAllocator pAllocator);
    void    ClearState();
    void    ResourceBarrier(uint NumBarriers, char* pBarriers);
    void    DiscardResource(ID3D12Resource pResource, const(D3D12_DISCARD_REGION)* pRegion);
    void    BeginQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void    EndQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void    ResolveQueryData(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint StartIndex, uint NumQueries, 
                             ID3D12Resource pDestinationBuffer, ulong AlignedDestinationBufferOffset);
    void    SetPredication(ID3D12Resource pBuffer, ulong AlignedBufferOffset, D3D12_PREDICATION_OP Operation);
    void    SetMarker(uint Metadata, char* pData, uint Size);
    void    BeginEvent(uint Metadata, char* pData, uint Size);
    void    EndEvent();
    void    ProcessFrames(ID3D12VideoProcessor pVideoProcessor, 
                          const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS)* pOutputArguments, uint NumInputStreams, 
                          char* pInputArguments);
    void    WriteBufferImmediate(uint Count, char* pParams, char* pModes);
}

@GUID("D52F011B-B56E-453C-A05A-A7F311C8F472")
interface ID3D12VideoDecodeCommandList1 : ID3D12VideoDecodeCommandList
{
    void DecodeFrame1(ID3D12VideoDecoder pDecoder, 
                      const(D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS1)* pOutputArguments, 
                      const(D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS)* pInputArguments);
}

@GUID("542C5C4D-7596-434F-8C93-4EFA6766F267")
interface ID3D12VideoProcessCommandList1 : ID3D12VideoProcessCommandList
{
    void ProcessFrames1(ID3D12VideoProcessor pVideoProcessor, 
                        const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS)* pOutputArguments, uint NumInputStreams, 
                        char* pInputArguments);
}

@GUID("33FDAE0E-098B-428F-87BB-34B695DE08F8")
interface ID3D12VideoMotionEstimator : ID3D12Pageable
{
    D3D12_VIDEO_MOTION_ESTIMATOR_DESC GetDesc();
    HRESULT GetProtectedResourceSession(const(GUID)* riid, void** ppProtectedSession);
}

@GUID("5BE17987-743A-4061-834B-23D22DAEA505")
interface ID3D12VideoMotionVectorHeap : ID3D12Pageable
{
    D3D12_VIDEO_MOTION_VECTOR_HEAP_DESC GetDesc();
    HRESULT GetProtectedResourceSession(const(GUID)* riid, void** ppProtectedSession);
}

@GUID("981611AD-A144-4C83-9890-F30E26D658AB")
interface ID3D12VideoDevice1 : ID3D12VideoDevice
{
    HRESULT CreateVideoMotionEstimator(const(D3D12_VIDEO_MOTION_ESTIMATOR_DESC)* pDesc, 
                                       ID3D12ProtectedResourceSession pProtectedResourceSession, const(GUID)* riid, 
                                       void** ppVideoMotionEstimator);
    HRESULT CreateVideoMotionVectorHeap(const(D3D12_VIDEO_MOTION_VECTOR_HEAP_DESC)* pDesc, 
                                        ID3D12ProtectedResourceSession pProtectedResourceSession, const(GUID)* riid, 
                                        void** ppVideoMotionVectorHeap);
}

@GUID("8455293A-0CBD-4831-9B39-FBDBAB724723")
interface ID3D12VideoEncodeCommandList : ID3D12CommandList
{
    HRESULT Close();
    HRESULT Reset(ID3D12CommandAllocator pAllocator);
    void    ClearState();
    void    ResourceBarrier(uint NumBarriers, char* pBarriers);
    void    DiscardResource(ID3D12Resource pResource, const(D3D12_DISCARD_REGION)* pRegion);
    void    BeginQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void    EndQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    void    ResolveQueryData(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint StartIndex, uint NumQueries, 
                             ID3D12Resource pDestinationBuffer, ulong AlignedDestinationBufferOffset);
    void    SetPredication(ID3D12Resource pBuffer, ulong AlignedBufferOffset, D3D12_PREDICATION_OP Operation);
    void    SetMarker(uint Metadata, char* pData, uint Size);
    void    BeginEvent(uint Metadata, char* pData, uint Size);
    void    EndEvent();
    void    EstimateMotion(ID3D12VideoMotionEstimator pMotionEstimator, 
                           const(D3D12_VIDEO_MOTION_ESTIMATOR_OUTPUT)* pOutputArguments, 
                           const(D3D12_VIDEO_MOTION_ESTIMATOR_INPUT)* pInputArguments);
    void    ResolveMotionVectorHeap(const(D3D12_RESOLVE_VIDEO_MOTION_VECTOR_HEAP_OUTPUT)* pOutputArguments, 
                                    const(D3D12_RESOLVE_VIDEO_MOTION_VECTOR_HEAP_INPUT)* pInputArguments);
    void    WriteBufferImmediate(uint Count, char* pParams, char* pModes);
    void    SetProtectedResourceSession(ID3D12ProtectedResourceSession pProtectedResourceSession);
}

@GUID("79A2E5FB-CCD2-469A-9FDE-195D10951F7E")
interface ID3D12VideoDecoder1 : ID3D12VideoDecoder
{
    HRESULT GetProtectedResourceSession(const(GUID)* riid, void** ppProtectedSession);
}

@GUID("DA1D98C5-539F-41B2-BF6B-1198A03B6D26")
interface ID3D12VideoDecoderHeap1 : ID3D12VideoDecoderHeap
{
    HRESULT GetProtectedResourceSession(const(GUID)* riid, void** ppProtectedSession);
}

@GUID("F3CFE615-553F-425C-86D8-EE8C1B1FB01C")
interface ID3D12VideoProcessor1 : ID3D12VideoProcessor
{
    HRESULT GetProtectedResourceSession(const(GUID)* riid, void** ppProtectedSession);
}

@GUID("554E41E8-AE8E-4A8C-B7D2-5B4F274A30E4")
interface ID3D12VideoExtensionCommand : ID3D12Pageable
{
    D3D12_VIDEO_EXTENSION_COMMAND_DESC GetDesc();
    HRESULT GetProtectedResourceSession(const(GUID)* riid, void** ppProtectedSession);
}

@GUID("F019AC49-F838-4A95-9B17-579437C8F513")
interface ID3D12VideoDevice2 : ID3D12VideoDevice1
{
    HRESULT CreateVideoDecoder1(const(D3D12_VIDEO_DECODER_DESC)* pDesc, 
                                ID3D12ProtectedResourceSession pProtectedResourceSession, const(GUID)* riid, 
                                void** ppVideoDecoder);
    HRESULT CreateVideoDecoderHeap1(const(D3D12_VIDEO_DECODER_HEAP_DESC)* pVideoDecoderHeapDesc, 
                                    ID3D12ProtectedResourceSession pProtectedResourceSession, const(GUID)* riid, 
                                    void** ppVideoDecoderHeap);
    HRESULT CreateVideoProcessor1(uint NodeMask, const(D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC)* pOutputStreamDesc, 
                                  uint NumInputStreamDescs, char* pInputStreamDescs, 
                                  ID3D12ProtectedResourceSession pProtectedResourceSession, const(GUID)* riid, 
                                  void** ppVideoProcessor);
    HRESULT CreateVideoExtensionCommand(const(D3D12_VIDEO_EXTENSION_COMMAND_DESC)* pDesc, 
                                        char* pCreationParameters, size_t CreationParametersDataSizeInBytes, 
                                        ID3D12ProtectedResourceSession pProtectedResourceSession, const(GUID)* riid, 
                                        void** ppVideoExtensionCommand);
    HRESULT ExecuteExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pExecutionParameters, 
                                    size_t ExecutionParametersSizeInBytes, char* pOutputData, 
                                    size_t OutputDataSizeInBytes);
}

@GUID("6E120880-C114-4153-8036-D247051E1729")
interface ID3D12VideoDecodeCommandList2 : ID3D12VideoDecodeCommandList1
{
    void SetProtectedResourceSession(ID3D12ProtectedResourceSession pProtectedResourceSession);
    void InitializeExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pInitializationParameters, 
                                    size_t InitializationParametersSizeInBytes);
    void ExecuteExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pExecutionParameters, 
                                 size_t ExecutionParametersSizeInBytes);
}

@GUID("DB525AE4-6AD6-473C-BAA7-59B2E37082E4")
interface ID3D12VideoProcessCommandList2 : ID3D12VideoProcessCommandList1
{
    void SetProtectedResourceSession(ID3D12ProtectedResourceSession pProtectedResourceSession);
    void InitializeExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pInitializationParameters, 
                                    size_t InitializationParametersSizeInBytes);
    void ExecuteExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pExecutionParameters, 
                                 size_t ExecutionParametersSizeInBytes);
}

@GUID("94971ECA-2BDB-4769-88CF-3675EA757EBC")
interface ID3D12VideoEncodeCommandList1 : ID3D12VideoEncodeCommandList
{
    void InitializeExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pInitializationParameters, 
                                    size_t InitializationParametersSizeInBytes);
    void ExecuteExtensionCommand(ID3D12VideoExtensionCommand pExtensionCommand, char* pExecutionParameters, 
                                 size_t ExecutionParametersSizeInBytes);
}

@GUID("CEE3DEF2-3808-414D-BE66-FAFD472210BC")
interface IWMValidate : IUnknown
{
    HRESULT SetIdentifier(GUID guidValidationID);
}

@GUID("04A578B2-E778-422A-A805-B3EE54D90BD9")
interface IValidateBinding : IUnknown
{
    HRESULT GetIdentifier(GUID guidLicensorID, char* pbEphemeron, uint cbEphemeron, char* ppbBlobValidationID, 
                          uint* pcbBlobSize);
}

@GUID("352BB3BD-2D4D-4323-9E71-DCDCFBD53CA6")
interface IWMVideoDecoderHurryup : IUnknown
{
    HRESULT SetHurryup(int lHurryup);
    HRESULT GetHurryup(int* plHurryup);
}

@GUID("9F8496BE-5B9A-41B9-A9E8-F21CD80596C2")
interface IWMVideoForceKeyFrame : IUnknown
{
    HRESULT SetKeyFrame();
}

@GUID("A7B2504B-E58A-47FB-958B-CAC7165A057D")
interface IWMCodecStrings : IUnknown
{
    HRESULT GetName(DMO_MEDIA_TYPE* pmt, uint cchLength, const(wchar)* szName, uint* pcchLength);
    HRESULT GetDescription(DMO_MEDIA_TYPE* pmt, uint cchLength, const(wchar)* szDescription, uint* pcchLength);
}

@GUID("2573E11A-F01A-4FDD-A98D-63B8E0BA9589")
interface IWMCodecProps : IUnknown
{
    HRESULT GetFormatProp(DMO_MEDIA_TYPE* pmt, const(wchar)* pszName, WMT_PROP_DATATYPE* pType, ubyte* pValue, 
                          uint* pdwSize);
    HRESULT GetCodecProp(uint dwFormat, const(wchar)* pszName, WMT_PROP_DATATYPE* pType, ubyte* pValue, 
                         uint* pdwSize);
}

@GUID("A81BA647-6227-43B7-B231-C7B15135DD7D")
interface IWMCodecLeakyBucket : IUnknown
{
    HRESULT SetBufferSizeBits(uint ulBufferSize);
    HRESULT GetBufferSizeBits(uint* pulBufferSize);
    HRESULT SetBufferFullnessBits(uint ulBufferFullness);
    HRESULT GetBufferFullnessBits(uint* pulBufferFullness);
}

@GUID("B72ADF95-7ADC-4A72-BC05-577D8EA6BF68")
interface IWMCodecOutputTimestamp : IUnknown
{
    HRESULT GetNextOutputTime(long* prtTime);
}

@GUID("45BDA2AC-88E2-4923-98BA-3949080711A3")
interface IWMVideoDecoderReconBuffer : IUnknown
{
    HRESULT GetReconstructedVideoFrameSize(uint* pdwSize);
    HRESULT GetReconstructedVideoFrame(IMediaBuffer pBuf);
    HRESULT SetReconstructedVideoFrame(IMediaBuffer pBuf);
}

@GUID("73F0BE8E-57F7-4F01-AA66-9F57340CFE0E")
interface IWMCodecPrivateData : IUnknown
{
    HRESULT SetPartialOutputType(DMO_MEDIA_TYPE* pmt);
    HRESULT GetPrivateData(ubyte* pbData, uint* pcbData);
}

@GUID("9BCA9884-0604-4C2A-87DA-793FF4D586C3")
interface IWMSampleExtensionSupport : IUnknown
{
    HRESULT SetUseSampleExtensions(BOOL fUseExtensions);
}

@GUID("E7E9984F-F09F-4DA4-903F-6E2E0EFE56B5")
interface IWMResamplerProps : IUnknown
{
    HRESULT SetHalfFilterLength(int lhalfFilterLen);
    HRESULT SetUserChannelMtx(float* userChannelMtx);
}

@GUID("57665D4C-0414-4FAA-905B-10E546F81C33")
interface IWMResizerProps : IUnknown
{
    HRESULT SetResizerQuality(int lquality);
    HRESULT SetInterlaceMode(int lmode);
    HRESULT SetClipRegion(int lClipOriXSrc, int lClipOriYSrc, int lClipWidthSrc, int lClipHeightSrc);
    HRESULT SetFullCropRegion(int lClipOriXSrc, int lClipOriYSrc, int lClipWidthSrc, int lClipHeightSrc, 
                              int lClipOriXDst, int lClipOriYDst, int lClipWidthDst, int lClipHeightDst);
    HRESULT GetFullCropRegion(int* lClipOriXSrc, int* lClipOriYSrc, int* lClipWidthSrc, int* lClipHeightSrc, 
                              int* lClipOriXDst, int* lClipOriYDst, int* lClipWidthDst, int* lClipHeightDst);
}

@GUID("776C93B3-B72D-4508-B6D0-208785F553E7")
interface IWMColorLegalizerProps : IUnknown
{
    HRESULT SetColorLegalizerQuality(int lquality);
}

@GUID("7B12E5D1-BD22-48EA-BC06-98E893221C89")
interface IWMInterlaceProps : IUnknown
{
    HRESULT SetProcessType(int iProcessType);
    HRESULT SetInitInverseTeleCinePattern(int iInitPattern);
    HRESULT SetLastFrame();
}

@GUID("4C06BB9B-626C-4614-8329-CC6A21B93FA0")
interface IWMFrameInterpProps : IUnknown
{
    HRESULT SetFrameRateIn(int lFrameRate, int lScale);
    HRESULT SetFrameRateOut(int lFrameRate, int lScale);
    HRESULT SetFrameInterpEnabled(BOOL bFIEnabled);
    HRESULT SetComplexityLevel(int iComplexity);
}

@GUID("E6A49E22-C099-421D-AAD3-C061FB4AE85B")
interface IWMColorConvProps : IUnknown
{
    HRESULT SetMode(int lMode);
    HRESULT SetFullCroppingParam(int lSrcCropLeft, int lSrcCropTop, int lDstCropLeft, int lDstCropTop, 
                                 int lCropWidth, int lCropHeight);
}

@GUID("F22F5E06-585C-4DEF-8523-6555CFBC0CB3")
interface ITocEntry : IUnknown
{
    HRESULT SetTitle(const(wchar)* pwszTitle);
    HRESULT GetTitle(ushort* pwTitleSize, const(wchar)* pwszTitle);
    HRESULT SetDescriptor(TOC_ENTRY_DESCRIPTOR* pDescriptor);
    HRESULT GetDescriptor(TOC_ENTRY_DESCRIPTOR* pDescriptor);
    HRESULT SetSubEntries(uint dwNumSubEntries, ushort* pwSubEntryIndices);
    HRESULT GetSubEntries(uint* pdwNumSubEntries, ushort* pwSubEntryIndices);
    HRESULT SetDescriptionData(uint dwDescriptionDataSize, ubyte* pbtDescriptionData, GUID* pguidType);
    HRESULT GetDescriptionData(uint* pdwDescriptionDataSize, ubyte* pbtDescriptionData, GUID* pGuidType);
}

@GUID("3A8CCCBD-0EFD-43A3-B838-F38A552BA237")
interface ITocEntryList : IUnknown
{
    HRESULT GetEntryCount(uint* pdwEntryCount);
    HRESULT GetEntryByIndex(uint dwEntryIndex, ITocEntry* ppEntry);
    HRESULT AddEntry(ITocEntry pEntry, uint* pdwEntryIndex);
    HRESULT AddEntryByIndex(uint dwEntryIndex, ITocEntry pEntry);
    HRESULT RemoveEntryByIndex(uint dwEntryIndex);
}

@GUID("D6F05441-A919-423B-91A0-89D5B4A8AB77")
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

@GUID("23FEE831-AE96-42DF-B170-25A04847A3CA")
interface ITocCollection : IUnknown
{
    HRESULT GetEntryCount(uint* pdwEntryCount);
    HRESULT GetEntryByIndex(uint dwEntryIndex, IToc* ppToc);
    HRESULT AddEntry(IToc pToc, uint* pdwEntryIndex);
    HRESULT AddEntryByIndex(uint dwEntryIndex, IToc pToc);
    HRESULT RemoveEntryByIndex(uint dwEntryIndex);
}

@GUID("ECFB9A55-9298-4F49-887F-0B36206599D2")
interface ITocParser : IUnknown
{
    HRESULT Init(const(wchar)* pwszFileName);
    HRESULT GetTocCount(TOC_POS_TYPE enumTocPosType, uint* pdwTocCount);
    HRESULT GetTocByIndex(TOC_POS_TYPE enumTocPosType, uint dwTocIndex, IToc* ppToc);
    HRESULT GetTocByType(TOC_POS_TYPE enumTocPosType, GUID guidTocType, ITocCollection* ppTocs);
    HRESULT AddToc(TOC_POS_TYPE enumTocPosType, IToc pToc, uint* pdwTocIndex);
    HRESULT RemoveTocByIndex(TOC_POS_TYPE enumTocPosType, uint dwTocIndex);
    HRESULT RemoveTocByType(TOC_POS_TYPE enumTocPosType, GUID guidTocType);
    HRESULT Commit();
}

@GUID("11993196-1244-4840-AB44-480975C4FFE4")
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

@GUID("BFCCD196-1244-4840-AB44-480975C4FFE4")
interface IFileClient : IUnknown
{
    HRESULT GetObjectDiskSize(ulong* pqwSize);
    HRESULT Write(IFileIo pFio);
    HRESULT Read(IFileIo pFio);
}

@GUID("3F07F7B7-C680-41D9-9423-915107EC9FF9")
interface IClusterDetector : IUnknown
{
    HRESULT Initialize(ushort wBaseEntryLevel, ushort wClusterEntryLevel);
    HRESULT Detect(uint dwMaxNumClusters, float fMinClusterDuration, float fMaxClusterDuration, IToc pSrcToc, 
                   IToc* ppDstToc);
}

@GUID("95F12DFD-D77E-49BE-815F-57D579634D6D")
interface IDXVAHD_Device : IUnknown
{
    HRESULT CreateVideoSurface(uint Width, uint Height, D3DFORMAT Format, D3DPOOL Pool, uint Usage, 
                               DXVAHD_SURFACE_TYPE Type, uint NumSurfaces, char* ppSurfaces, HANDLE* pSharedHandle);
    HRESULT GetVideoProcessorDeviceCaps(DXVAHD_VPDEVCAPS* pCaps);
    HRESULT GetVideoProcessorOutputFormats(uint Count, char* pFormats);
    HRESULT GetVideoProcessorInputFormats(uint Count, char* pFormats);
    HRESULT GetVideoProcessorCaps(uint Count, char* pCaps);
    HRESULT GetVideoProcessorCustomRates(const(GUID)* pVPGuid, uint Count, char* pRates);
    HRESULT GetVideoProcessorFilterRange(DXVAHD_FILTER Filter, DXVAHD_FILTER_RANGE_DATA* pRange);
    HRESULT CreateVideoProcessor(const(GUID)* pVPGuid, IDXVAHD_VideoProcessor* ppVideoProcessor);
}

@GUID("95F4EDF4-6E03-4CD7-BE1B-3075D665AA52")
interface IDXVAHD_VideoProcessor : IUnknown
{
    HRESULT SetVideoProcessBltState(DXVAHD_BLT_STATE State, uint DataSize, char* pData);
    HRESULT GetVideoProcessBltState(DXVAHD_BLT_STATE State, uint DataSize, char* pData);
    HRESULT SetVideoProcessStreamState(uint StreamNumber, DXVAHD_STREAM_STATE State, uint DataSize, char* pData);
    HRESULT GetVideoProcessStreamState(uint StreamNumber, DXVAHD_STREAM_STATE State, uint DataSize, char* pData);
    HRESULT VideoProcessBltHD(IDirect3DSurface9 pOutputSurface, uint OutputFrame, uint StreamCount, char* pStreams);
}

@GUID("A0CADE0F-06D5-4CF4-A1C7-F3CDD725AA75")
interface IDirect3DDeviceManager9 : IUnknown
{
    HRESULT ResetDevice(IDirect3DDevice9 pDevice, uint resetToken);
    HRESULT OpenDeviceHandle(HANDLE* phDevice);
    HRESULT CloseDeviceHandle(HANDLE hDevice);
    HRESULT TestDevice(HANDLE hDevice);
    HRESULT LockDevice(HANDLE hDevice, IDirect3DDevice9* ppDevice, BOOL fBlock);
    HRESULT UnlockDevice(HANDLE hDevice, BOOL fSaveState);
    HRESULT GetVideoService(HANDLE hDevice, const(GUID)* riid, void** ppService);
}

@GUID("FC51A550-D5E7-11D9-AF55-00054E43FF02")
interface IDirectXVideoAccelerationService : IUnknown
{
    HRESULT CreateSurface(uint Width, uint Height, uint BackBuffers, D3DFORMAT Format, D3DPOOL Pool, uint Usage, 
                          uint DxvaType, char* ppSurface, HANDLE* pSharedHandle);
}

@GUID("FC51A551-D5E7-11D9-AF55-00054E43FF02")
interface IDirectXVideoDecoderService : IDirectXVideoAccelerationService
{
    HRESULT GetDecoderDeviceGuids(uint* pCount, GUID** pGuids);
    HRESULT GetDecoderRenderTargets(const(GUID)* Guid, uint* pCount, D3DFORMAT** pFormats);
    HRESULT GetDecoderConfigurations(const(GUID)* Guid, const(DXVA2_VideoDesc)* pVideoDesc, void* pReserved, 
                                     uint* pCount, DXVA2_ConfigPictureDecode** ppConfigs);
    HRESULT CreateVideoDecoder(const(GUID)* Guid, const(DXVA2_VideoDesc)* pVideoDesc, 
                               const(DXVA2_ConfigPictureDecode)* pConfig, char* ppDecoderRenderTargets, 
                               uint NumRenderTargets, IDirectXVideoDecoder* ppDecode);
}

@GUID("FC51A552-D5E7-11D9-AF55-00054E43FF02")
interface IDirectXVideoProcessorService : IDirectXVideoAccelerationService
{
    HRESULT RegisterVideoProcessorSoftwareDevice(void* pCallbacks);
    HRESULT GetVideoProcessorDeviceGuids(const(DXVA2_VideoDesc)* pVideoDesc, uint* pCount, GUID** pGuids);
    HRESULT GetVideoProcessorRenderTargets(const(GUID)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, 
                                           uint* pCount, D3DFORMAT** pFormats);
    HRESULT GetVideoProcessorSubStreamFormats(const(GUID)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, 
                                              D3DFORMAT RenderTargetFormat, uint* pCount, D3DFORMAT** pFormats);
    HRESULT GetVideoProcessorCaps(const(GUID)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, 
                                  D3DFORMAT RenderTargetFormat, DXVA2_VideoProcessorCaps* pCaps);
    HRESULT GetProcAmpRange(const(GUID)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, 
                            D3DFORMAT RenderTargetFormat, uint ProcAmpCap, DXVA2_ValueRange* pRange);
    HRESULT GetFilterPropertyRange(const(GUID)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, 
                                   D3DFORMAT RenderTargetFormat, uint FilterSetting, DXVA2_ValueRange* pRange);
    HRESULT CreateVideoProcessor(const(GUID)* VideoProcDeviceGuid, const(DXVA2_VideoDesc)* pVideoDesc, 
                                 D3DFORMAT RenderTargetFormat, uint MaxNumSubStreams, 
                                 IDirectXVideoProcessor* ppVidProcess);
}

@GUID("F2B0810A-FD00-43C9-918C-DF94E2D8EF7D")
interface IDirectXVideoDecoder : IUnknown
{
    HRESULT GetVideoDecoderService(IDirectXVideoDecoderService* ppService);
    HRESULT GetCreationParameters(GUID* pDeviceGuid, DXVA2_VideoDesc* pVideoDesc, 
                                  DXVA2_ConfigPictureDecode* pConfig, char* pDecoderRenderTargets, 
                                  uint* pNumSurfaces);
    HRESULT GetBuffer(uint BufferType, void** ppBuffer, uint* pBufferSize);
    HRESULT ReleaseBuffer(uint BufferType);
    HRESULT BeginFrame(IDirect3DSurface9 pRenderTarget, void* pvPVPData);
    HRESULT EndFrame(HANDLE* pHandleComplete);
    HRESULT Execute(const(DXVA2_DecodeExecuteParams)* pExecuteParams);
}

@GUID("8C3A39F0-916E-4690-804F-4C8001355D25")
interface IDirectXVideoProcessor : IUnknown
{
    HRESULT GetVideoProcessorService(IDirectXVideoProcessorService* ppService);
    HRESULT GetCreationParameters(GUID* pDeviceGuid, DXVA2_VideoDesc* pVideoDesc, D3DFORMAT* pRenderTargetFormat, 
                                  uint* pMaxNumSubStreams);
    HRESULT GetVideoProcessorCaps(DXVA2_VideoProcessorCaps* pCaps);
    HRESULT GetProcAmpRange(uint ProcAmpCap, DXVA2_ValueRange* pRange);
    HRESULT GetFilterPropertyRange(uint FilterSetting, DXVA2_ValueRange* pRange);
    HRESULT VideoProcessBlt(IDirect3DSurface9 pRenderTarget, const(DXVA2_VideoProcessBltParams)* pBltParams, 
                            char* pSamples, uint NumSamples, HANDLE* pHandleComplete);
}

@GUID("B7F916DD-DB3B-49C1-84D7-E45EF99EC726")
interface IDirectXVideoMemoryConfiguration : IUnknown
{
    HRESULT GetAvailableSurfaceTypeByIndex(uint dwTypeIndex, DXVA2_SurfaceType* pdwType);
    HRESULT SetSurfaceType(DXVA2_SurfaceType dwType);
}

@GUID("0A15159D-41C7-4456-93E1-284CD61D4E8D")
interface IOPMVideoOutput : IUnknown
{
    HRESULT StartInitialization(OPM_RANDOM_NUMBER* prnRandomNumber, ubyte** ppbCertificate, 
                                uint* pulCertificateLength);
    HRESULT FinishInitialization(const(OPM_ENCRYPTED_INITIALIZATION_PARAMETERS)* pParameters);
    HRESULT GetInformation(const(OPM_GET_INFO_PARAMETERS)* pParameters, 
                           OPM_REQUESTED_INFORMATION* pRequestedInformation);
    HRESULT COPPCompatibleGetInformation(const(OPM_COPP_COMPATIBLE_GET_INFO_PARAMETERS)* pParameters, 
                                         OPM_REQUESTED_INFORMATION* pRequestedInformation);
    HRESULT Configure(const(OPM_CONFIGURE_PARAMETERS)* pParameters, uint ulAdditionalParametersSize, 
                      char* pbAdditionalParameters);
}

@GUID("2CD2D921-C447-44A7-A13C-4ADABFC247E3")
interface IMFAttributes : IUnknown
{
    HRESULT GetItem(const(GUID)* guidKey, PROPVARIANT* pValue);
    HRESULT GetItemType(const(GUID)* guidKey, MF_ATTRIBUTE_TYPE* pType);
    HRESULT CompareItem(const(GUID)* guidKey, const(PROPVARIANT)* Value, int* pbResult);
    HRESULT Compare(IMFAttributes pTheirs, MF_ATTRIBUTES_MATCH_TYPE MatchType, int* pbResult);
    HRESULT GetUINT32(const(GUID)* guidKey, uint* punValue);
    HRESULT GetUINT64(const(GUID)* guidKey, ulong* punValue);
    HRESULT GetDouble(const(GUID)* guidKey, double* pfValue);
    HRESULT GetGUID(const(GUID)* guidKey, GUID* pguidValue);
    HRESULT GetStringLength(const(GUID)* guidKey, uint* pcchLength);
    HRESULT GetString(const(GUID)* guidKey, const(wchar)* pwszValue, uint cchBufSize, uint* pcchLength);
    HRESULT GetAllocatedString(const(GUID)* guidKey, char* ppwszValue, uint* pcchLength);
    HRESULT GetBlobSize(const(GUID)* guidKey, uint* pcbBlobSize);
    HRESULT GetBlob(const(GUID)* guidKey, char* pBuf, uint cbBufSize, uint* pcbBlobSize);
    HRESULT GetAllocatedBlob(const(GUID)* guidKey, char* ppBuf, uint* pcbSize);
    HRESULT GetUnknown(const(GUID)* guidKey, const(GUID)* riid, void** ppv);
    HRESULT SetItem(const(GUID)* guidKey, const(PROPVARIANT)* Value);
    HRESULT DeleteItem(const(GUID)* guidKey);
    HRESULT DeleteAllItems();
    HRESULT SetUINT32(const(GUID)* guidKey, uint unValue);
    HRESULT SetUINT64(const(GUID)* guidKey, ulong unValue);
    HRESULT SetDouble(const(GUID)* guidKey, double fValue);
    HRESULT SetGUID(const(GUID)* guidKey, const(GUID)* guidValue);
    HRESULT SetString(const(GUID)* guidKey, const(wchar)* wszValue);
    HRESULT SetBlob(const(GUID)* guidKey, char* pBuf, uint cbBufSize);
    HRESULT SetUnknown(const(GUID)* guidKey, IUnknown pUnknown);
    HRESULT LockStore();
    HRESULT UnlockStore();
    HRESULT GetCount(uint* pcItems);
    HRESULT GetItemByIndex(uint unIndex, GUID* pguidKey, PROPVARIANT* pValue);
    HRESULT CopyAllItems(IMFAttributes pDest);
}

@GUID("045FA593-8799-42B8-BC8D-8968C6453507")
interface IMFMediaBuffer : IUnknown
{
    HRESULT Lock(char* ppbBuffer, uint* pcbMaxLength, uint* pcbCurrentLength);
    HRESULT Unlock();
    HRESULT GetCurrentLength(uint* pcbCurrentLength);
    HRESULT SetCurrentLength(uint cbCurrentLength);
    HRESULT GetMaxLength(uint* pcbMaxLength);
}

@GUID("C40A00F2-B93A-4D80-AE8C-5A1C634F58E4")
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

@GUID("7DC9D5F9-9ED9-44EC-9BBF-0600BB589FBB")
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

@GUID("33AE5EA6-4316-436F-8DDD-D73D22F829EC")
interface IMF2DBuffer2 : IMF2DBuffer
{
    HRESULT Lock2DSize(MF2DBuffer_LockFlags lockFlags, ubyte** ppbScanline0, int* plPitch, ubyte** ppbBufferStart, 
                       uint* pcbBufferLength);
    HRESULT Copy2DTo(IMF2DBuffer2 pDestBuffer);
}

@GUID("E7174CFA-1C9E-48B1-8866-626226BFC258")
interface IMFDXGIBuffer : IUnknown
{
    HRESULT GetResource(const(GUID)* riid, void** ppvObject);
    HRESULT GetSubresourceIndex(uint* puSubresource);
    HRESULT GetUnknown(const(GUID)* guid, const(GUID)* riid, void** ppvObject);
    HRESULT SetUnknown(const(GUID)* guid, IUnknown pUnkData);
}

@GUID("44AE0FA8-EA31-4109-8D2E-4CAE4997C555")
interface IMFMediaType : IMFAttributes
{
    HRESULT GetMajorType(GUID* pguidMajorType);
    HRESULT IsCompressedFormat(int* pfCompressed);
    HRESULT IsEqual(IMFMediaType pIMediaType, uint* pdwFlags);
    HRESULT GetRepresentation(GUID guidRepresentation, void** ppvRepresentation);
    HRESULT FreeRepresentation(GUID guidRepresentation, void* pvRepresentation);
}

@GUID("26A0ADC3-CE26-4672-9304-69552EDD3FAF")
interface IMFAudioMediaType : IMFMediaType
{
    WAVEFORMATEX* GetAudioFormat();
}

@GUID("B99F381F-A8F9-47A2-A5AF-CA3A225A3890")
interface IMFVideoMediaType : IMFMediaType
{
    MFVIDEOFORMAT* GetVideoFormat();
    HRESULT GetVideoRepresentation(GUID guidRepresentation, void** ppvRepresentation, int lStride);
}

@GUID("AC6B7889-0740-4D51-8619-905994A55CC6")
interface IMFAsyncResult : IUnknown
{
    HRESULT  GetState(IUnknown* ppunkState);
    HRESULT  GetStatus();
    HRESULT  SetStatus(HRESULT hrStatus);
    HRESULT  GetObjectA(IUnknown* ppObject);
    IUnknown GetStateNoAddRef();
}

@GUID("A27003CF-2354-4F2A-8D6A-AB7CFF15437E")
interface IMFAsyncCallback : IUnknown
{
    HRESULT GetParameters(uint* pdwFlags, uint* pdwQueue);
    HRESULT Invoke(IMFAsyncResult pAsyncResult);
}

@GUID("C7A4DCA1-F5F0-47B6-B92B-BF0106D25791")
interface IMFAsyncCallbackLogging : IMFAsyncCallback
{
    void* GetObjectPointer();
    uint  GetObjectTag();
}

@GUID("DF598932-F10C-4E39-BBA2-C308F101DAA3")
interface IMFMediaEvent : IMFAttributes
{
    HRESULT GetType(uint* pmet);
    HRESULT GetExtendedType(GUID* pguidExtendedType);
    HRESULT GetStatus(int* phrStatus);
    HRESULT GetValue(PROPVARIANT* pvValue);
}

@GUID("2CD0BD52-BCD5-4B89-B62C-EADC0C031E7D")
interface IMFMediaEventGenerator : IUnknown
{
    HRESULT GetEvent(uint dwFlags, IMFMediaEvent* ppEvent);
    HRESULT BeginGetEvent(IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndGetEvent(IMFAsyncResult pResult, IMFMediaEvent* ppEvent);
    HRESULT QueueEvent(uint met, const(GUID)* guidExtendedType, HRESULT hrStatus, const(PROPVARIANT)* pvValue);
}

@GUID("A27003D0-2354-4F2A-8D6A-AB7CFF15437E")
interface IMFRemoteAsyncCallback : IUnknown
{
    HRESULT Invoke(HRESULT hr, IUnknown pRemoteResult);
}

@GUID("AD4C1B00-4BF7-422F-9175-756693D9130D")
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
    HRESULT Seek(MFBYTESTREAM_SEEK_ORIGIN SeekOrigin, long llSeekOffset, uint dwSeekFlags, 
                 ulong* pqwCurrentPosition);
    HRESULT Flush();
    HRESULT Close();
}

@GUID("A6B43F84-5C0A-42E8-A44D-B1857A76992F")
interface IMFByteStreamProxyClassFactory : IUnknown
{
    HRESULT CreateByteStreamProxy(IMFByteStream pByteStream, IMFAttributes pAttributes, const(GUID)* riid, 
                                  void** ppvObject);
}

@GUID("8FEED468-6F7E-440D-869A-49BDD283AD0D")
interface IMFSampleOutputStream : IUnknown
{
    HRESULT BeginWriteSample(IMFSample pSample, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndWriteSample(IMFAsyncResult pResult);
    HRESULT Close();
}

@GUID("5BC8A76B-869A-46A3-9B03-FA218A66AEBE")
interface IMFCollection : IUnknown
{
    HRESULT GetElementCount(uint* pcElements);
    HRESULT GetElement(uint dwElementIndex, IUnknown* ppUnkElement);
    HRESULT AddElement(IUnknown pUnkElement);
    HRESULT RemoveElement(uint dwElementIndex, IUnknown* ppUnkElement);
    HRESULT InsertElementAt(uint dwIndex, IUnknown pUnknown);
    HRESULT RemoveAllElements();
}

@GUID("36F846FC-2256-48B6-B58E-E2B638316581")
interface IMFMediaEventQueue : IUnknown
{
    HRESULT GetEvent(uint dwFlags, IMFMediaEvent* ppEvent);
    HRESULT BeginGetEvent(IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndGetEvent(IMFAsyncResult pResult, IMFMediaEvent* ppEvent);
    HRESULT QueueEvent(IMFMediaEvent pEvent);
    HRESULT QueueEventParamVar(uint met, const(GUID)* guidExtendedType, HRESULT hrStatus, 
                               const(PROPVARIANT)* pvValue);
    HRESULT QueueEventParamUnk(uint met, const(GUID)* guidExtendedType, HRESULT hrStatus, IUnknown pUnk);
    HRESULT Shutdown();
}

@GUID("7FEE9E9A-4A89-47A6-899C-B6A53A70FB67")
interface IMFActivate : IMFAttributes
{
    HRESULT ActivateObject(const(GUID)* riid, void** ppv);
    HRESULT ShutdownObject();
    HRESULT DetachObject();
}

@GUID("5C6C44BF-1DB6-435B-9249-E8CD10FDEC96")
interface IMFPluginControl : IUnknown
{
    HRESULT GetPreferredClsid(uint pluginType, const(wchar)* selector, GUID* clsid);
    HRESULT GetPreferredClsidByIndex(uint pluginType, uint index, ushort** selector, GUID* clsid);
    HRESULT SetPreferredClsid(uint pluginType, const(wchar)* selector, const(GUID)* clsid);
    HRESULT IsDisabled(uint pluginType, const(GUID)* clsid);
    HRESULT GetDisabledByIndex(uint pluginType, uint index, GUID* clsid);
    HRESULT SetDisabled(uint pluginType, const(GUID)* clsid, BOOL disabled);
}

@GUID("C6982083-3DDC-45CB-AF5E-0F7A8CE4DE77")
interface IMFPluginControl2 : IMFPluginControl
{
    HRESULT SetPolicy(MF_PLUGIN_CONTROL_POLICY policy);
}

@GUID("EB533D5D-2DB6-40F8-97A9-494692014F07")
interface IMFDXGIDeviceManager : IUnknown
{
    HRESULT CloseDeviceHandle(HANDLE hDevice);
    HRESULT GetVideoService(HANDLE hDevice, const(GUID)* riid, void** ppService);
    HRESULT LockDevice(HANDLE hDevice, const(GUID)* riid, void** ppUnkDevice, BOOL fBlock);
    HRESULT OpenDeviceHandle(HANDLE* phDevice);
    HRESULT ResetDevice(IUnknown pUnkDevice, uint resetToken);
    HRESULT TestDevice(HANDLE hDevice);
    HRESULT UnlockDevice(HANDLE hDevice, BOOL fSaveState);
}

@GUID("CE8BD576-E440-43B3-BE34-1E53F565F7E8")
interface IMFMuxStreamAttributesManager : IUnknown
{
    HRESULT GetStreamCount(uint* pdwMuxStreamCount);
    HRESULT GetAttributes(uint dwMuxStreamIndex, IMFAttributes* ppStreamAttributes);
}

@GUID("505A2C72-42F7-4690-AEAB-8F513D0FFDB8")
interface IMFMuxStreamMediaTypeManager : IUnknown
{
    HRESULT GetStreamCount(uint* pdwMuxStreamCount);
    HRESULT GetMediaType(uint dwMuxStreamIndex, IMFMediaType* ppMediaType);
    HRESULT GetStreamConfigurationCount(uint* pdwCount);
    HRESULT AddStreamConfiguration(ulong ullStreamMask);
    HRESULT RemoveStreamConfiguration(ulong ullStreamMask);
    HRESULT GetStreamConfiguration(uint ulIndex, ulong* pullStreamMask);
}

@GUID("74ABBC19-B1CC-4E41-BB8B-9D9B86A8F6CA")
interface IMFMuxStreamSampleManager : IUnknown
{
    HRESULT GetStreamCount(uint* pdwMuxStreamCount);
    HRESULT GetSample(uint dwMuxStreamIndex, IMFSample* ppSample);
    ulong   GetStreamConfiguration();
}

@GUID("C1209904-E584-4752-A2D6-7F21693F8B21")
interface IMFSecureBuffer : IUnknown
{
    HRESULT GetIdentifier(GUID* pGuidIdentifier);
}

@GUID("BF94C121-5B05-4E6F-8000-BA598961414D")
interface IMFTransform : IUnknown
{
    HRESULT GetStreamLimits(uint* pdwInputMinimum, uint* pdwInputMaximum, uint* pdwOutputMinimum, 
                            uint* pdwOutputMaximum);
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
    HRESULT ProcessMessage(MFT_MESSAGE_TYPE eMessage, size_t ulParam);
    HRESULT ProcessInput(uint dwInputStreamID, IMFSample pSample, uint dwFlags);
    HRESULT ProcessOutput(uint dwFlags, uint cOutputBufferCount, MFT_OUTPUT_DATA_BUFFER* pOutputSamples, 
                          uint* pdwStatus);
}

@GUID("90377834-21D0-4DEE-8214-BA2E3E6C1127")
interface IMFMediaSession : IMFMediaEventGenerator
{
    HRESULT SetTopology(uint dwSetTopologyFlags, IMFTopology pTopology);
    HRESULT ClearTopologies();
    HRESULT Start(const(GUID)* pguidTimeFormat, const(PROPVARIANT)* pvarStartPosition);
    HRESULT Pause();
    HRESULT Stop();
    HRESULT Close();
    HRESULT Shutdown();
    HRESULT GetClock(IMFClock* ppClock);
    HRESULT GetSessionCapabilities(uint* pdwCaps);
    HRESULT GetFullTopology(uint dwGetFullTopologyFlags, ulong TopoId, IMFTopology* ppFullTopology);
}

@GUID("FBE5A32D-A497-4B61-BB85-97B1A848A6E3")
interface IMFSourceResolver : IUnknown
{
    HRESULT CreateObjectFromURL(const(wchar)* pwszURL, uint dwFlags, IPropertyStore pProps, 
                                MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT CreateObjectFromByteStream(IMFByteStream pByteStream, const(wchar)* pwszURL, uint dwFlags, 
                                       IPropertyStore pProps, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT BeginCreateObjectFromURL(const(wchar)* pwszURL, uint dwFlags, IPropertyStore pProps, 
                                     IUnknown* ppIUnknownCancelCookie, IMFAsyncCallback pCallback, 
                                     IUnknown punkState);
    HRESULT EndCreateObjectFromURL(IMFAsyncResult pResult, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT BeginCreateObjectFromByteStream(IMFByteStream pByteStream, const(wchar)* pwszURL, uint dwFlags, 
                                            IPropertyStore pProps, IUnknown* ppIUnknownCancelCookie, 
                                            IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndCreateObjectFromByteStream(IMFAsyncResult pResult, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT CancelObjectCreation(IUnknown pIUnknownCancelCookie);
}

@GUID("279A808D-AEC7-40C8-9C6B-A6B492C78A66")
interface IMFMediaSource : IMFMediaEventGenerator
{
    HRESULT GetCharacteristics(uint* pdwCharacteristics);
    HRESULT CreatePresentationDescriptor(IMFPresentationDescriptor* ppPresentationDescriptor);
    HRESULT Start(IMFPresentationDescriptor pPresentationDescriptor, const(GUID)* pguidTimeFormat, 
                  const(PROPVARIANT)* pvarStartPosition);
    HRESULT Stop();
    HRESULT Pause();
    HRESULT Shutdown();
}

@GUID("3C9B2EB9-86D5-4514-A394-F56664F9F0D8")
interface IMFMediaSourceEx : IMFMediaSource
{
    HRESULT GetSourceAttributes(IMFAttributes* ppAttributes);
    HRESULT GetStreamAttributes(uint dwStreamIdentifier, IMFAttributes* ppAttributes);
    HRESULT SetD3DManager(IUnknown pManager);
}

@GUID("6EF2A662-47C0-4666-B13D-CBB717F2FA2C")
interface IMFClockConsumer : IUnknown
{
    HRESULT SetPresentationClock(IMFPresentationClock pPresentationClock);
    HRESULT GetPresentationClock(IMFPresentationClock* ppPresentationClock);
}

@GUID("D182108F-4EC6-443F-AA42-A71106EC825F")
interface IMFMediaStream : IMFMediaEventGenerator
{
    HRESULT GetMediaSource(IMFMediaSource* ppMediaSource);
    HRESULT GetStreamDescriptor(IMFStreamDescriptor* ppStreamDescriptor);
    HRESULT RequestSample(IUnknown pToken);
}

@GUID("6EF2A660-47C0-4666-B13D-CBB717F2FA2C")
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

@GUID("0A97B3CF-8E7C-4A3D-8F8C-0C843DC247FB")
interface IMFStreamSink : IMFMediaEventGenerator
{
    HRESULT GetMediaSink(IMFMediaSink* ppMediaSink);
    HRESULT GetIdentifier(uint* pdwIdentifier);
    HRESULT GetMediaTypeHandler(IMFMediaTypeHandler* ppHandler);
    HRESULT ProcessSample(IMFSample pSample);
    HRESULT PlaceMarker(MFSTREAMSINK_MARKER_TYPE eMarkerType, const(PROPVARIANT)* pvarMarkerValue, 
                        const(PROPVARIANT)* pvarContextValue);
    HRESULT Flush();
}

@GUID("86CBC910-E533-4751-8E3B-F19B5B806A03")
interface IMFVideoSampleAllocator : IUnknown
{
    HRESULT SetDirectXManager(IUnknown pManager);
    HRESULT UninitializeSampleAllocator();
    HRESULT InitializeSampleAllocator(uint cRequestedFrames, IMFMediaType pMediaType);
    HRESULT AllocateSample(IMFSample* ppSample);
}

@GUID("A792CDBE-C374-4E89-8335-278E7B9956A4")
interface IMFVideoSampleAllocatorNotify : IUnknown
{
    HRESULT NotifyRelease();
}

@GUID("3978AA1A-6D5B-4B7F-A340-90899189AE34")
interface IMFVideoSampleAllocatorNotifyEx : IMFVideoSampleAllocatorNotify
{
    HRESULT NotifyPrune(IMFSample __MIDL__IMFVideoSampleAllocatorNotifyEx0000);
}

@GUID("992388B4-3372-4F67-8B6F-C84C071F4751")
interface IMFVideoSampleAllocatorCallback : IUnknown
{
    HRESULT SetCallback(IMFVideoSampleAllocatorNotify pNotify);
    HRESULT GetFreeSampleCount(int* plSamples);
}

@GUID("545B3A48-3283-4F62-866F-A62D8F598F9F")
interface IMFVideoSampleAllocatorEx : IMFVideoSampleAllocator
{
    HRESULT InitializeSampleAllocatorEx(uint cInitialSamples, uint cMaximumSamples, IMFAttributes pAttributes, 
                                        IMFMediaType pMediaType);
}

@GUID("20BC074B-7A8D-4609-8C3B-64A0A3B5D7CE")
interface IMFDXGIDeviceManagerSource : IUnknown
{
    HRESULT GetManager(IMFDXGIDeviceManager* ppManager);
}

@GUID("A3F675D5-6119-4F7F-A100-1D8B280F0EFB")
interface IMFVideoProcessorControl : IUnknown
{
    HRESULT SetBorderColor(MFARGB* pBorderColor);
    HRESULT SetSourceRectangle(RECT* pSrcRect);
    HRESULT SetDestinationRectangle(RECT* pDstRect);
    HRESULT SetMirror(MF_VIDEO_PROCESSOR_MIRROR eMirror);
    HRESULT SetRotation(MF_VIDEO_PROCESSOR_ROTATION eRotation);
    HRESULT SetConstrictionSize(SIZE* pConstrictionSize);
}

@GUID("BDE633D3-E1DC-4A7F-A693-BBAE399C4A20")
interface IMFVideoProcessorControl2 : IMFVideoProcessorControl
{
    HRESULT SetRotationOverride(uint uiRotation);
    HRESULT EnableHardwareEffects(BOOL fEnabled);
    HRESULT GetSupportedHardwareEffects(uint* puiSupport);
}

@GUID("2424B3F2-EB23-40F1-91AA-74BDDEEA0883")
interface IMFVideoProcessorControl3 : IMFVideoProcessorControl2
{
    HRESULT GetNaturalOutputType(IMFMediaType* ppType);
    HRESULT EnableSphericalVideoProcessing(BOOL fEnable, MFVideoSphericalFormat eFormat, 
                                           MFVideoSphericalProjectionMode eProjectionMode);
    HRESULT SetSphericalVideoProperties(float X, float Y, float Z, float W, float fieldOfView);
    HRESULT SetOutputDevice(IUnknown pOutputDevice);
}

@GUID("604D33D7-CF23-41D5-8224-5BBBB1A87475")
interface IMFVideoRendererEffectControl : IUnknown
{
    HRESULT OnAppServiceConnectionEstablished(IUnknown pAppServiceConnection);
}

@GUID("83CF873A-F6DA-4BC8-823F-BACFD55DC433")
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

@GUID("83CF873A-F6DA-4BC8-823F-BACFD55DC430")
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

@GUID("FA993888-4383-415A-A930-DD472A8CF6F7")
interface IMFGetService : IUnknown
{
    HRESULT GetService(const(GUID)* guidService, const(GUID)* riid, void** ppvObject);
}

@GUID("2EB1E945-18B8-4139-9B1A-D5D584818530")
interface IMFClock : IUnknown
{
    HRESULT GetClockCharacteristics(uint* pdwCharacteristics);
    HRESULT GetCorrelatedTime(uint dwReserved, long* pllClockTime, long* phnsSystemTime);
    HRESULT GetContinuityKey(uint* pdwContinuityKey);
    HRESULT GetState(uint dwReserved, MFCLOCK_STATE* peClockState);
    HRESULT GetProperties(MFCLOCK_PROPERTIES* pClockProperties);
}

@GUID("868CE85C-8EA9-4F55-AB82-B009A910A805")
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

@GUID("7FF12CCE-F76F-41C2-863B-1666C8E5E139")
interface IMFPresentationTimeSource : IMFClock
{
    HRESULT GetUnderlyingClock(IMFClock* ppClock);
}

@GUID("F6696E82-74F7-4F3D-A178-8A5E09C3659F")
interface IMFClockStateSink : IUnknown
{
    HRESULT OnClockStart(long hnsSystemTime, long llClockStartOffset);
    HRESULT OnClockStop(long hnsSystemTime);
    HRESULT OnClockPause(long hnsSystemTime);
    HRESULT OnClockRestart(long hnsSystemTime);
    HRESULT OnClockSetRate(long hnsSystemTime, float flRate);
}

@GUID("03CB2711-24D7-4DB6-A17F-F3A7A479A536")
interface IMFPresentationDescriptor : IMFAttributes
{
    HRESULT GetStreamDescriptorCount(uint* pdwDescriptorCount);
    HRESULT GetStreamDescriptorByIndex(uint dwIndex, int* pfSelected, IMFStreamDescriptor* ppDescriptor);
    HRESULT SelectStream(uint dwDescriptorIndex);
    HRESULT DeselectStream(uint dwDescriptorIndex);
    HRESULT Clone(IMFPresentationDescriptor* ppPresentationDescriptor);
}

@GUID("56C03D9C-9DBB-45F5-AB4B-D80F47C05938")
interface IMFStreamDescriptor : IMFAttributes
{
    HRESULT GetStreamIdentifier(uint* pdwStreamIdentifier);
    HRESULT GetMediaTypeHandler(IMFMediaTypeHandler* ppMediaTypeHandler);
}

@GUID("E93DCF6C-4B07-4E1E-8123-AA16ED6EADF5")
interface IMFMediaTypeHandler : IUnknown
{
    HRESULT IsMediaTypeSupported(IMFMediaType pMediaType, IMFMediaType* ppMediaType);
    HRESULT GetMediaTypeCount(uint* pdwTypeCount);
    HRESULT GetMediaTypeByIndex(uint dwIndex, IMFMediaType* ppType);
    HRESULT SetCurrentMediaType(IMFMediaType pMediaType);
    HRESULT GetCurrentMediaType(IMFMediaType* ppMediaType);
    HRESULT GetMajorType(GUID* pguidMajorType);
}

@GUID("E56E4CBD-8F70-49D8-A0F8-EDB3D6AB9BF2")
interface IMFTimer : IUnknown
{
    HRESULT SetTimer(uint dwFlags, long llClockTime, IMFAsyncCallback pCallback, IUnknown punkState, 
                     IUnknown* ppunkKey);
    HRESULT CancelTimer(IUnknown punkKey);
}

@GUID("97EC2EA4-0E42-4937-97AC-9D6D328824E1")
interface IMFShutdown : IUnknown
{
    HRESULT Shutdown();
    HRESULT GetShutdownStatus(MFSHUTDOWN_STATUS* pStatus);
}

@GUID("DE9A6157-F660-4643-B56A-DF9F7998C7CD")
interface IMFTopoLoader : IUnknown
{
    HRESULT Load(IMFTopology pInputTopo, IMFTopology* ppOutputTopo, IMFTopology pCurrentTopo);
}

@GUID("ACF92459-6A61-42BD-B57C-B43E51203CB0")
interface IMFContentProtectionManager : IUnknown
{
    HRESULT BeginEnableContent(IMFActivate pEnablerActivate, IMFTopology pTopo, IMFAsyncCallback pCallback, 
                               IUnknown punkState);
    HRESULT EndEnableContent(IMFAsyncResult pResult);
}

@GUID("D3C4EF59-49CE-4381-9071-D5BCD044C770")
interface IMFContentEnabler : IUnknown
{
    HRESULT GetEnableType(GUID* pType);
    HRESULT GetEnableURL(char* ppwszURL, uint* pcchURL, MF_URL_TRUST_STATUS* pTrustStatus);
    HRESULT GetEnableData(char* ppbData, uint* pcbData);
    HRESULT IsAutomaticSupported(int* pfAutomatic);
    HRESULT AutomaticEnable();
    HRESULT MonitorEnable();
    HRESULT Cancel();
}

@GUID("F88CFB8C-EF16-4991-B450-CB8C69E51704")
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

@GUID("56181D2D-E221-4ADB-B1C8-3CEE6A53F76F")
interface IMFMetadataProvider : IUnknown
{
    HRESULT GetMFMetadata(IMFPresentationDescriptor pPresentationDescriptor, uint dwStreamIdentifier, uint dwFlags, 
                          IMFMetadata* ppMFMetadata);
}

@GUID("0A9CCDBC-D797-4563-9667-94EC5D79292D")
interface IMFRateSupport : IUnknown
{
    HRESULT GetSlowestRate(MFRATE_DIRECTION eDirection, BOOL fThin, float* pflRate);
    HRESULT GetFastestRate(MFRATE_DIRECTION eDirection, BOOL fThin, float* pflRate);
    HRESULT IsRateSupported(BOOL fThin, float flRate, float* pflNearestSupportedRate);
}

@GUID("88DDCD21-03C3-4275-91ED-55EE3929328F")
interface IMFRateControl : IUnknown
{
    HRESULT SetRate(BOOL fThin, float flRate);
    HRESULT GetRate(int* pfThin, float* pflRate);
}

@GUID("AB9D8661-F7E8-4EF4-9861-89F334F94E74")
interface IMFTimecodeTranslate : IUnknown
{
    HRESULT BeginConvertTimecodeToHNS(const(PROPVARIANT)* pPropVarTimecode, IMFAsyncCallback pCallback, 
                                      IUnknown punkState);
    HRESULT EndConvertTimecodeToHNS(IMFAsyncResult pResult, long* phnsTime);
    HRESULT BeginConvertHNSToTimecode(long hnsTime, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndConvertHNSToTimecode(IMFAsyncResult pResult, PROPVARIANT* pPropVarTimecode);
}

@GUID("26AFEA53-D9ED-42B5-AB80-E64F9EE34779")
interface IMFSeekInfo : IUnknown
{
    HRESULT GetNearestKeyFrames(const(GUID)* pguidTimeFormat, const(PROPVARIANT)* pvarStartPosition, 
                                PROPVARIANT* pvarPreviousKeyFrame, PROPVARIANT* pvarNextKeyFrame);
}

@GUID("089EDF13-CF71-4338-8D13-9E569DBDC319")
interface IMFSimpleAudioVolume : IUnknown
{
    HRESULT SetMasterVolume(float fLevel);
    HRESULT GetMasterVolume(float* pfLevel);
    HRESULT SetMute(const(int) bMute);
    HRESULT GetMute(int* pbMute);
}

@GUID("76B1BBDB-4EC8-4F36-B106-70A9316DF593")
interface IMFAudioStreamVolume : IUnknown
{
    HRESULT GetChannelCount(uint* pdwCount);
    HRESULT SetChannelVolume(uint dwIndex, const(float) fLevel);
    HRESULT GetChannelVolume(uint dwIndex, float* pfLevel);
    HRESULT SetAllVolumes(uint dwCount, char* pfVolumes);
    HRESULT GetAllVolumes(uint dwCount, char* pfVolumes);
}

@GUID("A0638C2B-6465-4395-9AE7-A321A9FD2856")
interface IMFAudioPolicy : IUnknown
{
    HRESULT SetGroupingParam(const(GUID)* rguidClass);
    HRESULT GetGroupingParam(GUID* pguidClass);
    HRESULT SetDisplayName(const(wchar)* pszName);
    HRESULT GetDisplayName(ushort** pszName);
    HRESULT SetIconPath(const(wchar)* pszPath);
    HRESULT GetIconPath(ushort** pszPath);
}

@GUID("8C7B80BF-EE42-4B59-B1DF-55668E1BDCA8")
interface IMFSampleGrabberSinkCallback : IMFClockStateSink
{
    HRESULT OnSetPresentationClock(IMFPresentationClock pPresentationClock);
    HRESULT OnProcessSample(const(GUID)* guidMajorMediaType, uint dwSampleFlags, long llSampleTime, 
                            long llSampleDuration, char* pSampleBuffer, uint dwSampleSize);
    HRESULT OnShutdown();
}

@GUID("CA86AA50-C46E-429E-AB27-16D6AC6844CB")
interface IMFSampleGrabberSinkCallback2 : IMFSampleGrabberSinkCallback
{
    HRESULT OnProcessSampleEx(const(GUID)* guidMajorMediaType, uint dwSampleFlags, long llSampleTime, 
                              long llSampleDuration, char* pSampleBuffer, uint dwSampleSize, 
                              IMFAttributes pAttributes);
}

@GUID("35FE1BB8-A3A9-40FE-BBEC-EB569C9CCCA3")
interface IMFWorkQueueServices : IUnknown
{
    HRESULT BeginRegisterTopologyWorkQueuesWithMMCSS(IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndRegisterTopologyWorkQueuesWithMMCSS(IMFAsyncResult pResult);
    HRESULT BeginUnregisterTopologyWorkQueuesWithMMCSS(IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndUnregisterTopologyWorkQueuesWithMMCSS(IMFAsyncResult pResult);
    HRESULT GetTopologyWorkQueueMMCSSClass(uint dwTopologyWorkQueueId, const(wchar)* pwszClass, uint* pcchClass);
    HRESULT GetTopologyWorkQueueMMCSSTaskId(uint dwTopologyWorkQueueId, uint* pdwTaskId);
    HRESULT BeginRegisterPlatformWorkQueueWithMMCSS(uint dwPlatformWorkQueue, const(wchar)* wszClass, 
                                                    uint dwTaskId, IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndRegisterPlatformWorkQueueWithMMCSS(IMFAsyncResult pResult, uint* pdwTaskId);
    HRESULT BeginUnregisterPlatformWorkQueueWithMMCSS(uint dwPlatformWorkQueue, IMFAsyncCallback pCallback, 
                                                      IUnknown pState);
    HRESULT EndUnregisterPlatformWorkQueueWithMMCSS(IMFAsyncResult pResult);
    HRESULT GetPlaftormWorkQueueMMCSSClass(uint dwPlatformWorkQueueId, const(wchar)* pwszClass, uint* pcchClass);
    HRESULT GetPlatformWorkQueueMMCSSTaskId(uint dwPlatformWorkQueueId, uint* pdwTaskId);
}

@GUID("96BF961B-40FE-42F1-BA9D-320238B49700")
interface IMFWorkQueueServicesEx : IMFWorkQueueServices
{
    HRESULT GetTopologyWorkQueueMMCSSPriority(uint dwTopologyWorkQueueId, int* plPriority);
    HRESULT BeginRegisterPlatformWorkQueueWithMMCSSEx(uint dwPlatformWorkQueue, const(wchar)* wszClass, 
                                                      uint dwTaskId, int lPriority, IMFAsyncCallback pCallback, 
                                                      IUnknown pState);
    HRESULT GetPlatformWorkQueueMMCSSPriority(uint dwPlatformWorkQueueId, int* plPriority);
}

@GUID("8D009D86-5B9F-4115-B1FC-9F80D52AB8AB")
interface IMFQualityManager : IUnknown
{
    HRESULT NotifyTopology(IMFTopology pTopology);
    HRESULT NotifyPresentationClock(IMFPresentationClock pClock);
    HRESULT NotifyProcessInput(IMFTopologyNode pNode, int lInputIndex, IMFSample pSample);
    HRESULT NotifyProcessOutput(IMFTopologyNode pNode, int lOutputIndex, IMFSample pSample);
    HRESULT NotifyQualityEvent(IUnknown pObject, IMFMediaEvent pEvent);
    HRESULT Shutdown();
}

@GUID("EC15E2E9-E36B-4F7C-8758-77D452EF4CE7")
interface IMFQualityAdvise : IUnknown
{
    HRESULT SetDropMode(MF_QUALITY_DROP_MODE eDropMode);
    HRESULT SetQualityLevel(MF_QUALITY_LEVEL eQualityLevel);
    HRESULT GetDropMode(MF_QUALITY_DROP_MODE* peDropMode);
    HRESULT GetQualityLevel(MF_QUALITY_LEVEL* peQualityLevel);
    HRESULT DropTime(long hnsAmountToDrop);
}

@GUID("F3706F0D-8EA2-4886-8000-7155E9EC2EAE")
interface IMFQualityAdvise2 : IMFQualityAdvise
{
    HRESULT NotifyQualityEvent(IMFMediaEvent pEvent, uint* pdwFlags);
}

@GUID("DFCD8E4D-30B5-4567-ACAA-8EB5B7853DC9")
interface IMFQualityAdviseLimits : IUnknown
{
    HRESULT GetMaximumDropMode(MF_QUALITY_DROP_MODE* peDropMode);
    HRESULT GetMinimumQualityLevel(MF_QUALITY_LEVEL* peQualityLevel);
}

@GUID("2347D60B-3FB5-480C-8803-8DF3ADCD3EF0")
interface IMFRealTimeClient : IUnknown
{
    HRESULT RegisterThreads(uint dwTaskIndex, const(wchar)* wszClass);
    HRESULT UnregisterThreads();
    HRESULT SetWorkQueue(uint dwWorkQueueId);
}

@GUID("03910848-AB16-4611-B100-17B88AE2F248")
interface IMFRealTimeClientEx : IUnknown
{
    HRESULT RegisterThreadsEx(uint* pdwTaskIndex, const(wchar)* wszClassName, int lBasePriority);
    HRESULT UnregisterThreads();
    HRESULT SetWorkQueueEx(uint dwMultithreadedWorkQueueId, int lWorkItemBasePriority);
}

@GUID("197CD219-19CB-4DE1-A64C-ACF2EDCBE59E")
interface IMFSequencerSource : IUnknown
{
    HRESULT AppendTopology(IMFTopology pTopology, uint dwFlags, uint* pdwId);
    HRESULT DeleteTopology(uint dwId);
    HRESULT GetPresentationContext(IMFPresentationDescriptor pPD, uint* pId, IMFTopology* ppTopology);
    HRESULT UpdateTopology(uint dwId, IMFTopology pTopology);
    HRESULT UpdateTopologyFlags(uint dwId, uint dwFlags);
}

@GUID("0E1D6009-C9F3-442D-8C51-A42D2D49452F")
interface IMFMediaSourceTopologyProvider : IUnknown
{
    HRESULT GetMediaSourceTopology(IMFPresentationDescriptor pPresentationDescriptor, IMFTopology* ppTopology);
}

@GUID("0E1D600A-C9F3-442D-8C51-A42D2D49452F")
interface IMFMediaSourcePresentationProvider : IUnknown
{
    HRESULT ForceEndOfPresentation(IMFPresentationDescriptor pPresentationDescriptor);
}

@GUID("676AA6DD-238A-410D-BB99-65668D01605A")
interface IMFTopologyNodeAttributeEditor : IUnknown
{
    HRESULT UpdateNodeAttributes(ulong TopoId, uint cUpdates, char* pUpdates);
}

@GUID("6D66D782-1D4F-4DB7-8C63-CB8C77F1EF5E")
interface IMFByteStreamBuffering : IUnknown
{
    HRESULT SetBufferingParams(MFBYTESTREAM_BUFFERING_PARAMS* pParams);
    HRESULT EnableBuffering(BOOL fEnable);
    HRESULT StopBuffering();
}

@GUID("F5042EA4-7A96-4A75-AA7B-2BE1EF7F88D5")
interface IMFByteStreamCacheControl : IUnknown
{
    HRESULT StopBackgroundTransfer();
}

@GUID("64976BFA-FB61-4041-9069-8C9A5F659BEB")
interface IMFByteStreamTimeSeek : IUnknown
{
    HRESULT IsTimeSeekSupported(int* pfTimeSeekIsSupported);
    HRESULT TimeSeek(ulong qwTimePosition);
    HRESULT GetTimeSeekResult(ulong* pqwStartTime, ulong* pqwStopTime, ulong* pqwDuration);
}

@GUID("71CE469C-F34B-49EA-A56B-2D2A10E51149")
interface IMFByteStreamCacheControl2 : IMFByteStreamCacheControl
{
    HRESULT GetByteRanges(uint* pcRanges, char* ppRanges);
    HRESULT SetCacheLimit(ulong qwBytes);
    HRESULT IsBackgroundTransferActive(int* pfActive);
}

@GUID("5B87EF6A-7ED8-434F-BA0E-184FAC1628D1")
interface IMFNetCredential : IUnknown
{
    HRESULT SetUser(char* pbData, uint cbData, BOOL fDataIsEncrypted);
    HRESULT SetPassword(char* pbData, uint cbData, BOOL fDataIsEncrypted);
    HRESULT GetUser(char* pbData, uint* pcbData, BOOL fEncryptData);
    HRESULT GetPassword(char* pbData, uint* pcbData, BOOL fEncryptData);
    HRESULT LoggedOnUser(int* pfLoggedOnUser);
}

@GUID("5B87EF6B-7ED8-434F-BA0E-184FAC1628D1")
interface IMFNetCredentialManager : IUnknown
{
    HRESULT BeginGetCredentials(MFNetCredentialManagerGetParam* pParam, IMFAsyncCallback pCallback, 
                                IUnknown pState);
    HRESULT EndGetCredentials(IMFAsyncResult pResult, IMFNetCredential* ppCred);
    HRESULT SetGood(IMFNetCredential pCred, BOOL fGood);
}

@GUID("5B87EF6C-7ED8-434F-BA0E-184FAC1628D1")
interface IMFNetCredentialCache : IUnknown
{
    HRESULT GetCredential(const(wchar)* pszUrl, const(wchar)* pszRealm, uint dwAuthenticationFlags, 
                          IMFNetCredential* ppCred, uint* pdwRequirementsFlags);
    HRESULT SetGood(IMFNetCredential pCred, BOOL fGood);
    HRESULT SetUserOptions(IMFNetCredential pCred, uint dwOptionsFlags);
}

@GUID("61F7D887-1230-4A8B-AEBA-8AD434D1A64D")
interface IMFSSLCertificateManager : IUnknown
{
    HRESULT GetClientCertificate(const(wchar)* pszURL, ubyte** ppbData, uint* pcbData);
    HRESULT BeginGetClientCertificate(const(wchar)* pszURL, IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndGetClientCertificate(IMFAsyncResult pResult, ubyte** ppbData, uint* pcbData);
    HRESULT GetCertificatePolicy(const(wchar)* pszURL, int* pfOverrideAutomaticCheck, 
                                 int* pfClientCertificateAvailable);
    HRESULT OnServerCertificate(const(wchar)* pszURL, char* pbData, uint cbData, int* pfIsGood);
}

@GUID("091878A3-BF11-4A5C-BC9F-33995B06EF2D")
interface IMFNetResourceFilter : IUnknown
{
    HRESULT OnRedirect(const(wchar)* pszUrl, short* pvbCancel);
    HRESULT OnSendingRequest(const(wchar)* pszUrl);
}

@GUID("059054B3-027C-494C-A27D-9113291CF87F")
interface IMFSourceOpenMonitor : IUnknown
{
    HRESULT OnSourceEvent(IMFMediaEvent pEvent);
}

@GUID("E9CD0383-A268-4BB4-82DE-658D53574D41")
interface IMFNetProxyLocator : IUnknown
{
    HRESULT FindFirstProxy(const(wchar)* pszHost, const(wchar)* pszUrl, BOOL fReserved);
    HRESULT FindNextProxy();
    HRESULT RegisterProxyResult(HRESULT hrOp);
    HRESULT GetCurrentProxy(const(wchar)* pszStr, uint* pcchStr);
    HRESULT Clone(IMFNetProxyLocator* ppProxyLocator);
}

@GUID("E9CD0384-A268-4BB4-82DE-658D53574D41")
interface IMFNetProxyLocatorFactory : IUnknown
{
    HRESULT CreateProxyLocator(const(wchar)* pszProtocol, IMFNetProxyLocator* ppProxyLocator);
}

@GUID("E9931663-80BF-4C6E-98AF-5DCF58747D1F")
interface IMFSaveJob : IUnknown
{
    HRESULT BeginSave(IMFByteStream pStream, IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndSave(IMFAsyncResult pResult);
    HRESULT CancelSave();
    HRESULT GetProgress(uint* pdwPercentComplete);
}

@GUID("7BE19E73-C9BF-468A-AC5A-A5E8653BEC87")
interface IMFNetSchemeHandlerConfig : IUnknown
{
    HRESULT GetNumberOfSupportedProtocols(uint* pcProtocols);
    HRESULT GetSupportedProtocolType(uint nProtocolIndex, MFNETSOURCE_PROTOCOL_TYPE* pnProtocolType);
    HRESULT ResetProtocolRolloverSettings();
}

@GUID("6D4C7B74-52A0-4BB7-B0DB-55F29F47A668")
interface IMFSchemeHandler : IUnknown
{
    HRESULT BeginCreateObject(const(wchar)* pwszURL, uint dwFlags, IPropertyStore pProps, 
                              IUnknown* ppIUnknownCancelCookie, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndCreateObject(IMFAsyncResult pResult, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT CancelObjectCreation(IUnknown pIUnknownCancelCookie);
}

@GUID("BB420AA4-765B-4A1F-91FE-D6A8A143924C")
interface IMFByteStreamHandler : IUnknown
{
    HRESULT BeginCreateObject(IMFByteStream pByteStream, const(wchar)* pwszURL, uint dwFlags, 
                              IPropertyStore pProps, IUnknown* ppIUnknownCancelCookie, IMFAsyncCallback pCallback, 
                              IUnknown punkState);
    HRESULT EndCreateObject(IMFAsyncResult pResult, MF_OBJECT_TYPE* pObjectType, IUnknown* ppObject);
    HRESULT CancelObjectCreation(IUnknown pIUnknownCancelCookie);
    HRESULT GetMaxNumberOfBytesRequiredForResolution(ulong* pqwBytes);
}

@GUID("542612C4-A1B8-4632-B521-DE11EA64A0B0")
interface IMFTrustedInput : IUnknown
{
    HRESULT GetInputTrustAuthority(uint dwStreamID, const(GUID)* riid, IUnknown* ppunkObject);
}

@GUID("D19F8E98-B126-4446-890C-5DCB7AD71453")
interface IMFInputTrustAuthority : IUnknown
{
    HRESULT GetDecrypter(const(GUID)* riid, void** ppv);
    HRESULT RequestAccess(MFPOLICYMANAGER_ACTION Action, IMFActivate* ppContentEnablerActivate);
    HRESULT GetPolicy(MFPOLICYMANAGER_ACTION Action, IMFOutputPolicy* ppPolicy);
    HRESULT BindAccess(MFINPUTTRUSTAUTHORITY_ACCESS_PARAMS* pParam);
    HRESULT UpdateAccess(MFINPUTTRUSTAUTHORITY_ACCESS_PARAMS* pParam);
    HRESULT Reset();
}

@GUID("D19F8E95-B126-4446-890C-5DCB7AD71453")
interface IMFTrustedOutput : IUnknown
{
    HRESULT GetOutputTrustAuthorityCount(uint* pcOutputTrustAuthorities);
    HRESULT GetOutputTrustAuthorityByIndex(uint dwIndex, IMFOutputTrustAuthority* ppauthority);
    HRESULT IsFinal(int* pfIsFinal);
}

@GUID("D19F8E94-B126-4446-890C-5DCB7AD71453")
interface IMFOutputTrustAuthority : IUnknown
{
    HRESULT GetAction(MFPOLICYMANAGER_ACTION* pAction);
    HRESULT SetPolicy(char* ppPolicy, uint nPolicy, ubyte** ppbTicket, uint* pcbTicket);
}

@GUID("7F00F10A-DAED-41AF-AB26-5FDFA4DFBA3C")
interface IMFOutputPolicy : IMFAttributes
{
    HRESULT GenerateRequiredSchemas(uint dwAttributes, GUID guidOutputSubType, 
                                    GUID* rgGuidProtectionSchemasSupported, uint cProtectionSchemasSupported, 
                                    IMFCollection* ppRequiredProtectionSchemas);
    HRESULT GetOriginatorID(GUID* pguidOriginatorID);
    HRESULT GetMinimumGRLVersion(uint* pdwMinimumGRLVersion);
}

@GUID("7BE0FC5B-ABD9-44FB-A5C8-F50136E71599")
interface IMFOutputSchema : IMFAttributes
{
    HRESULT GetSchemaType(GUID* pguidSchemaType);
    HRESULT GetConfigurationData(uint* pdwVal);
    HRESULT GetOriginatorID(GUID* pguidOriginatorID);
}

@GUID("D0AE555D-3B12-4D97-B060-0990BC5AEB67")
interface IMFSecureChannel : IUnknown
{
    HRESULT GetCertificate(ubyte** ppCert, uint* pcbCert);
    HRESULT SetupSession(char* pbEncryptedSessionKey, uint cbSessionKey);
}

@GUID("8E36395F-C7B9-43C4-A54D-512B4AF63C95")
interface IMFSampleProtection : IUnknown
{
    HRESULT GetInputProtectionVersion(uint* pdwVersion);
    HRESULT GetOutputProtectionVersion(uint* pdwVersion);
    HRESULT GetProtectionCertificate(uint dwVersion, ubyte** ppCert, uint* pcbCert);
    HRESULT InitOutputProtection(uint dwVersion, uint dwOutputId, ubyte* pbCert, uint cbCert, ubyte** ppbSeed, 
                                 uint* pcbSeed);
    HRESULT InitInputProtection(uint dwVersion, uint dwInputId, ubyte* pbSeed, uint cbSeed);
}

@GUID("5DFD4B2A-7674-4110-A4E6-8A68FD5F3688")
interface IMFMediaSinkPreroll : IUnknown
{
    HRESULT NotifyPreroll(long hnsUpcomingStartTime);
}

@GUID("EAECB74A-9A50-42CE-9541-6A7F57AA4AD7")
interface IMFFinalizableMediaSink : IMFMediaSink
{
    HRESULT BeginFinalize(IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT EndFinalize(IMFAsyncResult pResult);
}

@GUID("9DB7AA41-3CC5-40D4-8509-555804AD34CC")
interface IMFStreamingSinkConfig : IUnknown
{
    HRESULT StartStreaming(BOOL fSeekOffsetIsByteOffset, ulong qwSeekOffset);
}

@GUID("994E23AD-1CC2-493C-B9FA-46F1CB040FA4")
interface IMFRemoteProxy : IUnknown
{
    HRESULT GetRemoteObject(const(GUID)* riid, void** ppv);
    HRESULT GetRemoteHost(const(GUID)* riid, void** ppv);
}

@GUID("09EF5BE3-C8A7-469E-8B70-73BF25BB193F")
interface IMFObjectReferenceStream : IUnknown
{
    HRESULT SaveReference(const(GUID)* riid, IUnknown pUnk);
    HRESULT LoadReference(const(GUID)* riid, void** ppv);
}

@GUID("F70CA1A9-FDC7-4782-B994-ADFFB1C98606")
interface IMFPMPHost : IUnknown
{
    HRESULT LockProcess();
    HRESULT UnlockProcess();
    HRESULT CreateObjectByCLSID(const(GUID)* clsid, IStream pStream, const(GUID)* riid, void** ppv);
}

@GUID("6C4E655D-EAD8-4421-B6B9-54DCDBBDF820")
interface IMFPMPClient : IUnknown
{
    HRESULT SetPMPHost(IMFPMPHost pPMPHost);
}

@GUID("994E23AF-1CC2-493C-B9FA-46F1CB040FA4")
interface IMFPMPServer : IUnknown
{
    HRESULT LockProcess();
    HRESULT UnlockProcess();
    HRESULT CreateObjectByCLSID(const(GUID)* clsid, const(GUID)* riid, void** ppObject);
}

@GUID("1CDE6309-CAE0-4940-907E-C1EC9C3D1D4A")
interface IMFRemoteDesktopPlugin : IUnknown
{
    HRESULT UpdateTopology(IMFTopology pTopology);
}

@GUID("A7E025DD-5303-4A62-89D6-E747E1EFAC73")
interface IMFSAMIStyle : IUnknown
{
    HRESULT GetStyleCount(uint* pdwCount);
    HRESULT GetStyles(PROPVARIANT* pPropVarStyleArray);
    HRESULT SetSelectedStyle(const(wchar)* pwszStyle);
    HRESULT GetSelectedStyle(ushort** ppwszStyle);
}

@GUID("4ADFDBA3-7AB0-4953-A62B-461E7FF3DA1E")
interface IMFTranscodeProfile : IUnknown
{
    HRESULT SetAudioAttributes(IMFAttributes pAttrs);
    HRESULT GetAudioAttributes(IMFAttributes* ppAttrs);
    HRESULT SetVideoAttributes(IMFAttributes pAttrs);
    HRESULT GetVideoAttributes(IMFAttributes* ppAttrs);
    HRESULT SetContainerAttributes(IMFAttributes pAttrs);
    HRESULT GetContainerAttributes(IMFAttributes* ppAttrs);
}

@GUID("8CFFCD2E-5A03-4A3A-AFF7-EDCD107C620E")
interface IMFTranscodeSinkInfoProvider : IUnknown
{
    HRESULT SetOutputFile(const(wchar)* pwszFileName);
    HRESULT SetOutputByteStream(IMFActivate pByteStreamActivate);
    HRESULT SetProfile(IMFTranscodeProfile pProfile);
    HRESULT GetSinkInfo(MF_TRANSCODE_SINK_INFO* pSinkInfo);
}

@GUID("508E71D3-EC66-4FC3-8775-B4B9ED6BA847")
interface IMFFieldOfUseMFTUnlock : IUnknown
{
    HRESULT Unlock(IUnknown pUnkMFT);
}

@GUID("149C4D73-B4BE-4F8D-8B87-079E926B6ADD")
interface IMFLocalMFTRegistration : IUnknown
{
    HRESULT RegisterMFTs(char* pMFTs, uint cMFTs);
}

@GUID("19F68549-CA8A-4706-A4EF-481DBC95E12C")
interface IMFCapturePhotoConfirmation : IUnknown
{
    HRESULT SetPhotoConfirmationCallback(IMFAsyncCallback pNotificationCallback);
    HRESULT SetPixelFormat(GUID subtype);
    HRESULT GetPixelFormat(GUID* subtype);
}

@GUID("84D2054A-3AA1-4728-A3B0-440A418CF49C")
interface IMFPMPHostApp : IUnknown
{
    HRESULT LockProcess();
    HRESULT UnlockProcess();
    HRESULT ActivateClassById(const(wchar)* id, IStream pStream, const(GUID)* riid, void** ppv);
}

@GUID("C004F646-BE2C-48F3-93A2-A0983EBA1108")
interface IMFPMPClientApp : IUnknown
{
    HRESULT SetPMPHost(IMFPMPHostApp pPMPHost);
}

@GUID("380B9AF9-A85B-4E78-A2AF-EA5CE645C6B4")
interface IMFMediaStreamSourceSampleRequest : IUnknown
{
    HRESULT SetSample(IMFSample value);
}

@GUID("245BF8E9-0755-40F7-88A5-AE0F18D55E17")
interface IMFTrackedSample : IUnknown
{
    HRESULT SetAllocator(IMFAsyncCallback pSampleAllocator, IUnknown pUnkState);
}

@GUID("EF5DC845-F0D9-4EC9-B00C-CB5183D38434")
interface IMFProtectedEnvironmentAccess : IUnknown
{
    HRESULT Call(uint inputLength, char* input, uint outputLength, char* output);
    HRESULT ReadGRL(uint* outputLength, ubyte** output);
}

@GUID("4A724BCA-FF6A-4C07-8E0D-7A358421CF06")
interface IMFSignedLibrary : IUnknown
{
    HRESULT GetProcedureAddress(const(char)* name, void** address);
}

@GUID("FFF4AF3A-1FC1-4EF9-A29B-D26C49E2F31A")
interface IMFSystemId : IUnknown
{
    HRESULT GetData(uint* size, ubyte** data);
    HRESULT Setup(uint stage, uint cbIn, char* pbIn, uint* pcbOut, ubyte** ppbOut);
}

@GUID("E6257174-A060-4C9A-A088-3B1B471CAD28")
interface IMFContentProtectionDevice : IUnknown
{
    HRESULT InvokeFunction(uint FunctionId, uint InputBufferByteCount, char* InputBuffer, 
                           uint* OutputBufferByteCount, char* OutputBuffer);
    HRESULT GetPrivateDataByteCount(uint* PrivateInputByteCount, uint* PrivateOutputByteCount);
}

@GUID("7EC4B1BD-43FB-4763-85D2-64FCB5C5F4CB")
interface IMFContentDecryptorContext : IUnknown
{
    HRESULT InitializeHardwareKey(uint InputPrivateDataByteCount, char* InputPrivateData, ulong* OutputPrivateData);
}

@GUID("BC2B7D44-A72D-49D5-8376-1480DEE58B22")
interface IMFNetCrossOriginSupport : IUnknown
{
    HRESULT GetCrossOriginPolicy(MF_CROSS_ORIGIN_POLICY* pPolicy);
    HRESULT GetSourceOrigin(ushort** wszSourceOrigin);
    HRESULT IsSameOrigin(const(wchar)* wszURL, int* pfIsSameOrigin);
}

@GUID("F779FDDF-26E7-4270-8A8B-B983D1859DE0")
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

@GUID("71FA9A2C-53CE-4662-A132-1A7E8CBF62DB")
interface IMFHttpDownloadSession : IUnknown
{
    HRESULT SetServer(const(wchar)* szServerName, uint nPort);
    HRESULT CreateRequest(const(wchar)* szObjectName, BOOL fBypassProxyCache, BOOL fSecure, const(wchar)* szVerb, 
                          const(wchar)* szReferrer, IMFHttpDownloadRequest* ppRequest);
    HRESULT Close();
}

@GUID("1B4CF4B9-3A16-4115-839D-03CC5C99DF01")
interface IMFHttpDownloadSessionProvider : IUnknown
{
    HRESULT CreateHttpDownloadSession(const(wchar)* wszScheme, IMFHttpDownloadSession* ppDownloadSession);
}

@GUID("FBB03414-D13B-4786-8319-5AC51FC0A136")
interface IMFMediaSource2 : IMFMediaSourceEx
{
    HRESULT SetMediaType(uint dwStreamID, IMFMediaType pMediaType);
}

@GUID("C5BC37D6-75C7-46A1-A132-81B5F723C20F")
interface IMFMediaStream2 : IMFMediaStream
{
    HRESULT SetStreamState(MF_STREAM_STATE value);
    HRESULT GetStreamState(MF_STREAM_STATE* value);
}

@GUID("FB9F48F2-2A18-4E28-9730-786F30F04DC4")
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

@GUID("4110243A-9757-461F-89F1-F22345BCAB4E")
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

@GUID("E9A42171-C56E-498A-8B39-EDA5A070B7FC")
interface IMFSensorStream : IMFAttributes
{
    HRESULT GetMediaTypeCount(uint* pdwCount);
    HRESULT GetMediaType(uint dwIndex, IMFMediaType* ppMediaType);
    HRESULT CloneSensorStream(IMFSensorStream* ppStream);
}

@GUID("EED9C2EE-66B4-4F18-A697-AC7D3960215C")
interface IMFSensorTransformFactory : IUnknown
{
    HRESULT GetFactoryAttributes(IMFAttributes* ppAttributes);
    HRESULT InitializeFactory(uint dwMaxTransformCount, IMFCollection pSensorDevices, IMFAttributes pAttributes);
    HRESULT GetTransformCount(uint* pdwCount);
    HRESULT GetTransformInformation(uint TransformIndex, GUID* pguidTransformId, IMFAttributes* ppAttributes, 
                                    IMFCollection* ppStreamInformation);
    HRESULT CreateTransform(const(GUID)* guidSensorTransformID, IMFAttributes pAttributes, 
                            IMFDeviceTransform* ppDeviceMFT);
}

@GUID("22F765D1-8DAB-4107-846D-56BAF72215E7")
interface IMFSensorProfile : IUnknown
{
    HRESULT GetProfileId(SENSORPROFILEID* pId);
    HRESULT AddProfileFilter(uint StreamId, const(wchar)* wzFilterSetString);
    HRESULT IsMediaTypeSupported(uint StreamId, IMFMediaType pMediaType, int* pfSupported);
    HRESULT AddBlockedControl(const(wchar)* wzBlockedControl);
}

@GUID("C95EA55B-0187-48BE-9353-8D2507662351")
interface IMFSensorProfileCollection : IUnknown
{
    uint    GetProfileCount();
    HRESULT GetProfile(uint Index, IMFSensorProfile* ppProfile);
    HRESULT AddProfile(IMFSensorProfile pProfile);
    HRESULT FindProfile(SENSORPROFILEID* ProfileId, IMFSensorProfile* ppProfile);
    void    RemoveProfileByIndex(uint Index);
    void    RemoveProfile(SENSORPROFILEID* ProfileId);
}

@GUID("39DC7F4A-B141-4719-813C-A7F46162A2B8")
interface IMFSensorProcessActivity : IUnknown
{
    HRESULT GetProcessId(uint* pPID);
    HRESULT GetStreamingState(int* pfStreaming);
    HRESULT GetStreamingMode(MFSensorDeviceMode* pMode);
    HRESULT GetReportTime(FILETIME* pft);
}

@GUID("3E8C4BE1-A8C2-4528-90DE-2851BDE5FEAD")
interface IMFSensorActivityReport : IUnknown
{
    HRESULT GetFriendlyName(const(wchar)* FriendlyName, uint cchFriendlyName, uint* pcchWritten);
    HRESULT GetSymbolicLink(const(wchar)* SymbolicLink, uint cchSymbolicLink, uint* pcchWritten);
    HRESULT GetProcessCount(uint* pcCount);
    HRESULT GetProcessActivity(uint Index, IMFSensorProcessActivity* ppProcessActivity);
}

@GUID("683F7A5E-4A19-43CD-B1A9-DBF4AB3F7777")
interface IMFSensorActivitiesReport : IUnknown
{
    HRESULT GetCount(uint* pcCount);
    HRESULT GetActivityReport(uint Index, IMFSensorActivityReport* sensorActivityReport);
    HRESULT GetActivityReportByDeviceName(const(wchar)* SymbolicName, 
                                          IMFSensorActivityReport* sensorActivityReport);
}

@GUID("DE5072EE-DBE3-46DC-8A87-B6F631194751")
interface IMFSensorActivitiesReportCallback : IUnknown
{
    HRESULT OnActivitiesReport(IMFSensorActivitiesReport sensorActivitiesReport);
}

@GUID("D0CEF145-B3F4-4340-A2E5-7A5080CA05CB")
interface IMFSensorActivityMonitor : IUnknown
{
    HRESULT Start();
    HRESULT Stop();
}

@GUID("5C595E64-4630-4231-855A-12842F733245")
interface IMFExtendedCameraIntrinsicModel : IUnknown
{
    HRESULT GetModel(MFExtendedCameraIntrinsic_IntrinsicModel* pIntrinsicModel);
    HRESULT SetModel(const(MFExtendedCameraIntrinsic_IntrinsicModel)* pIntrinsicModel);
    HRESULT GetDistortionModelType(MFCameraIntrinsic_DistortionModelType* pDistortionModelType);
}

@GUID("74C2653B-5F55-4EB1-9F0F-18B8F68B7D3D")
interface IMFExtendedCameraIntrinsicsDistortionModel6KT : IUnknown
{
    HRESULT GetDistortionModel(MFCameraIntrinsic_DistortionModel6KT* pDistortionModel);
    HRESULT SetDistortionModel(const(MFCameraIntrinsic_DistortionModel6KT)* pDistortionModel);
}

@GUID("812D5F95-B572-45DC-BAFC-AE24199DDDA8")
interface IMFExtendedCameraIntrinsicsDistortionModelArcTan : IUnknown
{
    HRESULT GetDistortionModel(MFCameraIntrinsic_DistortionModelArcTan* pDistortionModel);
    HRESULT SetDistortionModel(const(MFCameraIntrinsic_DistortionModelArcTan)* pDistortionModel);
}

@GUID("687F6DAC-6987-4750-A16A-734D1E7A10FE")
interface IMFExtendedCameraIntrinsics : IUnknown
{
    HRESULT InitializeFromBuffer(char* pbBuffer, uint dwBufferSize);
    HRESULT GetBufferSize(uint* pdwBufferSize);
    HRESULT SerializeToBuffer(char* pbBuffer, uint* pdwBufferSize);
    HRESULT GetIntrinsicModelCount(uint* pdwCount);
    HRESULT GetIntrinsicModelByIndex(uint dwIndex, IMFExtendedCameraIntrinsicModel* ppIntrinsicModel);
    HRESULT AddIntrinsicModel(IMFExtendedCameraIntrinsicModel pIntrinsicModel);
}

@GUID("38E33520-FCA1-4845-A27A-68B7C6AB3789")
interface IMFExtendedCameraControl : IUnknown
{
    ulong   GetCapabilities();
    HRESULT SetFlags(ulong ulFlags);
    ulong   GetFlags();
    HRESULT LockPayload(ubyte** ppPayload, uint* pulPayload);
    HRESULT UnlockPayload();
    HRESULT CommitSettings();
}

@GUID("B91EBFEE-CA03-4AF4-8A82-A31752F4A0FC")
interface IMFExtendedCameraController : IUnknown
{
    HRESULT GetExtendedCameraControl(uint dwStreamIndex, uint ulPropertyId, IMFExtendedCameraControl* ppControl);
}

@GUID("F25362EA-2C0E-447F-81E2-755914CDC0C3")
interface IMFRelativePanelReport : IUnknown
{
    HRESULT GetRelativePanel(uint* panel);
}

@GUID("421AF7F6-573E-4AD0-8FDA-2E57CEDB18C6")
interface IMFRelativePanelWatcher : IMFShutdown
{
    HRESULT BeginGetReport(IMFAsyncCallback pCallback, IUnknown pState);
    HRESULT EndGetReport(IMFAsyncResult pResult, IMFRelativePanelReport* ppRelativePanelReport);
    HRESULT GetReport(IMFRelativePanelReport* ppRelativePanelReport);
}

@GUID("725B77C7-CA9F-4FE5-9D72-9946BF9B3C70")
interface IMFVideoCaptureSampleAllocator : IMFVideoSampleAllocator
{
    HRESULT InitializeCaptureSampleAllocator(uint cbSampleSize, uint cbCaptureMetadataSize, uint cbAlignment, 
                                             uint cMinimumSamples, IMFAttributes pAttributes, 
                                             IMFMediaType pMediaType);
}

@GUID("DA62B958-3A38-4A97-BD27-149C640C0771")
interface IMFSampleAllocatorControl : IUnknown
{
    HRESULT SetDefaultAllocator(uint dwOutputStreamID, IUnknown pAllocator);
    HRESULT GetAllocatorUsage(uint dwOutputStreamID, uint* pdwInputStreamID, MFSampleAllocatorUsage* peUsage);
}

@GUID("B1DCA5CD-D5DA-4451-8E9E-DB5C59914EAD")
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

@GUID("D267BF6A-028B-4E0D-903D-43F0EF82D0D4")
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

@GUID("9E8AE8D2-DBBD-4200-9ACA-06E6DF484913")
interface IMFASFStreamConfig : IMFAttributes
{
    HRESULT GetStreamType(GUID* pguidStreamType);
    ushort  GetStreamNumber();
    HRESULT SetStreamNumber(ushort wStreamNum);
    HRESULT GetMediaType(IMFMediaType* ppIMediaType);
    HRESULT SetMediaType(IMFMediaType pIMediaType);
    HRESULT GetPayloadExtensionCount(ushort* pcPayloadExtensions);
    HRESULT GetPayloadExtension(ushort wPayloadExtensionNumber, GUID* pguidExtensionSystemID, 
                                ushort* pcbExtensionDataSize, ubyte* pbExtensionSystemInfo, 
                                uint* pcbExtensionSystemInfo);
    HRESULT AddPayloadExtension(GUID guidExtensionSystemID, ushort cbExtensionDataSize, 
                                ubyte* pbExtensionSystemInfo, uint cbExtensionSystemInfo);
    HRESULT RemoveAllPayloadExtensions();
    HRESULT Clone(IMFASFStreamConfig* ppIStreamConfig);
}

@GUID("12558291-E399-11D5-BC2A-00B0D0F3F4AB")
interface IMFASFMutualExclusion : IUnknown
{
    HRESULT GetType(GUID* pguidType);
    HRESULT SetType(const(GUID)* guidType);
    HRESULT GetRecordCount(uint* pdwRecordCount);
    HRESULT GetStreamsForRecord(uint dwRecordNumber, ushort* pwStreamNumArray, uint* pcStreams);
    HRESULT AddStreamForRecord(uint dwRecordNumber, ushort wStreamNumber);
    HRESULT RemoveStreamFromRecord(uint dwRecordNumber, ushort wStreamNumber);
    HRESULT RemoveRecord(uint dwRecordNumber);
    HRESULT AddRecord(uint* pdwRecordNumber);
    HRESULT Clone(IMFASFMutualExclusion* ppIMutex);
}

@GUID("699BDC27-BBAF-49FF-8E38-9C39C9B5E088")
interface IMFASFStreamPrioritization : IUnknown
{
    HRESULT GetStreamCount(uint* pdwStreamCount);
    HRESULT GetStream(uint dwStreamIndex, ushort* pwStreamNumber, ushort* pwStreamFlags);
    HRESULT AddStream(ushort wStreamNumber, ushort wStreamFlags);
    HRESULT RemoveStream(uint dwStreamIndex);
    HRESULT Clone(IMFASFStreamPrioritization* ppIStreamPrioritization);
}

@GUID("53590F48-DC3B-4297-813F-787761AD7B3E")
interface IMFASFIndexer : IUnknown
{
    HRESULT SetFlags(uint dwFlags);
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT Initialize(IMFASFContentInfo pIContentInfo);
    HRESULT GetIndexPosition(IMFASFContentInfo pIContentInfo, ulong* pcbIndexOffset);
    HRESULT SetIndexByteStreams(IMFByteStream* ppIByteStreams, uint cByteStreams);
    HRESULT GetIndexByteStreamCount(uint* pcByteStreams);
    HRESULT GetIndexStatus(ASF_INDEX_IDENTIFIER* pIndexIdentifier, int* pfIsIndexed, ubyte* pbIndexDescriptor, 
                           uint* pcbIndexDescriptor);
    HRESULT SetIndexStatus(ubyte* pbIndexDescriptor, uint cbIndexDescriptor, BOOL fGenerateIndex);
    HRESULT GetSeekPositionForValue(const(PROPVARIANT)* pvarValue, ASF_INDEX_IDENTIFIER* pIndexIdentifier, 
                                    ulong* pcbOffsetWithinData, long* phnsApproxTime, 
                                    uint* pdwPayloadNumberOfStreamWithinPacket);
    HRESULT GenerateIndexEntries(IMFSample pIASFPacketSample);
    HRESULT CommitIndex(IMFASFContentInfo pIContentInfo);
    HRESULT GetIndexWriteSpace(ulong* pcbIndexWriteSpace);
    HRESULT GetCompletedIndex(IMFMediaBuffer pIIndexBuffer, ulong cbOffsetWithinIndex);
}

@GUID("12558295-E399-11D5-BC2A-00B0D0F3F4AB")
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

@GUID("57BDD80A-9B38-4838-B737-C58F670D7D4F")
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

@GUID("D01BAD4A-4FA0-4A60-9349-C27E62DA9D41")
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
    HRESULT GetBandwidthStep(uint dwStepNum, uint* pdwBitrate, ushort* rgwStreamNumbers, 
                             ASF_SELECTION_STATUS* rgSelections);
    HRESULT BitrateToStepNumber(uint dwBitrate, uint* pdwStepNum);
    HRESULT SetStreamSelectorFlags(uint dwStreamSelectorFlags);
}

@GUID("3D1FF0EA-679A-4190-8D46-7FA69E8C7E15")
interface IMFDRMNetHelper : IUnknown
{
    HRESULT ProcessLicenseRequest(char* pLicenseRequest, uint cbLicenseRequest, char* ppLicenseResponse, 
                                  uint* pcbLicenseResponse, BSTR* pbstrKID);
    HRESULT GetChainedLicenseResponse(char* ppLicenseResponse, uint* pcbLicenseResponse);
}

@GUID("AEDA51C0-9025-4983-9012-DE597B88B089")
interface IMFCaptureEngineOnEventCallback : IUnknown
{
    HRESULT OnEvent(IMFMediaEvent pEvent);
}

@GUID("52150B82-AB39-4467-980F-E48BF0822ECD")
interface IMFCaptureEngineOnSampleCallback : IUnknown
{
    HRESULT OnSample(IMFSample pSample);
}

@GUID("72D6135B-35E9-412C-B926-FD5265F2A885")
interface IMFCaptureSink : IUnknown
{
    HRESULT GetOutputMediaType(uint dwSinkStreamIndex, IMFMediaType* ppMediaType);
    HRESULT GetService(uint dwSinkStreamIndex, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppUnknown);
    HRESULT AddStream(uint dwSourceStreamIndex, IMFMediaType pMediaType, IMFAttributes pAttributes, 
                      uint* pdwSinkStreamIndex);
    HRESULT Prepare();
    HRESULT RemoveAllStreams();
}

@GUID("3323B55A-F92A-4FE2-8EDC-E9BFC0634D77")
interface IMFCaptureRecordSink : IMFCaptureSink
{
    HRESULT SetOutputByteStream(IMFByteStream pByteStream, const(GUID)* guidContainerType);
    HRESULT SetOutputFileName(const(wchar)* fileName);
    HRESULT SetSampleCallback(uint dwStreamSinkIndex, IMFCaptureEngineOnSampleCallback pCallback);
    HRESULT SetCustomSink(IMFMediaSink pMediaSink);
    HRESULT GetRotation(uint dwStreamIndex, uint* pdwRotationValue);
    HRESULT SetRotation(uint dwStreamIndex, uint dwRotationValue);
}

@GUID("77346CFD-5B49-4D73-ACE0-5B52A859F2E0")
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

@GUID("D2D43CC8-48BB-4AA7-95DB-10C06977E777")
interface IMFCapturePhotoSink : IMFCaptureSink
{
    HRESULT SetOutputFileName(const(wchar)* fileName);
    HRESULT SetSampleCallback(IMFCaptureEngineOnSampleCallback pCallback);
    HRESULT SetOutputByteStream(IMFByteStream pByteStream);
}

@GUID("439A42A8-0D2C-4505-BE83-F79B2A05D5C4")
interface IMFCaptureSource : IUnknown
{
    HRESULT GetCaptureDeviceSource(MF_CAPTURE_ENGINE_DEVICE_TYPE mfCaptureEngineDeviceType, 
                                   IMFMediaSource* ppMediaSource);
    HRESULT GetCaptureDeviceActivate(MF_CAPTURE_ENGINE_DEVICE_TYPE mfCaptureEngineDeviceType, 
                                     IMFActivate* ppActivate);
    HRESULT GetService(const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppUnknown);
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

@GUID("A6BBA433-176B-48B2-B375-53AA03473207")
interface IMFCaptureEngine : IUnknown
{
    HRESULT Initialize(IMFCaptureEngineOnEventCallback pEventCallback, IMFAttributes pAttributes, 
                       IUnknown pAudioSource, IUnknown pVideoSource);
    HRESULT StartPreview();
    HRESULT StopPreview();
    HRESULT StartRecord();
    HRESULT StopRecord(BOOL bFinalize, BOOL bFlushUnprocessedSamples);
    HRESULT TakePhoto();
    HRESULT GetSink(MF_CAPTURE_ENGINE_SINK_TYPE mfCaptureEngineSinkType, IMFCaptureSink* ppSink);
    HRESULT GetSource(IMFCaptureSource* ppSource);
}

@GUID("8F02D140-56FC-4302-A705-3A97C78BE779")
interface IMFCaptureEngineClassFactory : IUnknown
{
    HRESULT CreateInstance(const(GUID)* clsid, const(GUID)* riid, void** ppvObject);
}

@GUID("E37CEED7-340F-4514-9F4D-9C2AE026100B")
interface IMFCaptureEngineOnSampleCallback2 : IMFCaptureEngineOnSampleCallback
{
    HRESULT OnSynchronizedEvent(IMFMediaEvent pEvent);
}

@GUID("F9E4219E-6197-4B5E-B888-BEE310AB2C59")
interface IMFCaptureSink2 : IMFCaptureSink
{
    HRESULT SetOutputMediaType(uint dwStreamIndex, IMFMediaType pMediaType, IMFAttributes pEncodingAttributes);
}

interface MFASYNCRESULT : IMFAsyncResult
{
}

@GUID("FC0E10D2-AB2A-4501-A951-06BB1075184C")
interface IMFMediaError : IUnknown
{
    ushort  GetErrorCode();
    HRESULT GetExtendedErrorCode();
    HRESULT SetErrorCode(MF_MEDIA_ENGINE_ERR error);
    HRESULT SetExtendedErrorCode(HRESULT error);
}

@GUID("DB71A2FC-078A-414E-9DF9-8C2531B0AA6C")
interface IMFMediaTimeRange : IUnknown
{
    uint    GetLength();
    HRESULT GetStart(uint index, double* pStart);
    HRESULT GetEnd(uint index, double* pEnd);
    BOOL    ContainsTime(double time);
    HRESULT AddRange(double startTime, double endTime);
    HRESULT Clear();
}

@GUID("FEE7C112-E776-42B5-9BBF-0048524E2BD5")
interface IMFMediaEngineNotify : IUnknown
{
    HRESULT EventNotify(uint event, size_t param1, uint param2);
}

@GUID("7A5E5354-B114-4C72-B991-3131D75032EA")
interface IMFMediaEngineSrcElements : IUnknown
{
    uint    GetLength();
    HRESULT GetURL(uint index, BSTR* pURL);
    HRESULT GetType(uint index, BSTR* pType);
    HRESULT GetMedia(uint index, BSTR* pMedia);
    HRESULT AddElement(BSTR pURL, BSTR pType, BSTR pMedia);
    HRESULT RemoveAllElements();
}

@GUID("98A1B0BB-03EB-4935-AE7C-93C1FA0E1C93")
interface IMFMediaEngine : IUnknown
{
    HRESULT GetError(IMFMediaError* ppError);
    HRESULT SetErrorCode(MF_MEDIA_ENGINE_ERR error);
    HRESULT SetSourceElements(IMFMediaEngineSrcElements pSrcElements);
    HRESULT SetSource(BSTR pUrl);
    HRESULT GetCurrentSource(BSTR* ppUrl);
    ushort  GetNetworkState();
    MF_MEDIA_ENGINE_PRELOAD GetPreload();
    HRESULT SetPreload(MF_MEDIA_ENGINE_PRELOAD Preload);
    HRESULT GetBuffered(IMFMediaTimeRange* ppBuffered);
    HRESULT Load();
    HRESULT CanPlayType(BSTR type, MF_MEDIA_ENGINE_CANPLAY* pAnswer);
    ushort  GetReadyState();
    BOOL    IsSeeking();
    double  GetCurrentTime();
    HRESULT SetCurrentTime(double seekTime);
    double  GetStartTime();
    double  GetDuration();
    BOOL    IsPaused();
    double  GetDefaultPlaybackRate();
    HRESULT SetDefaultPlaybackRate(double Rate);
    double  GetPlaybackRate();
    HRESULT SetPlaybackRate(double Rate);
    HRESULT GetPlayed(IMFMediaTimeRange* ppPlayed);
    HRESULT GetSeekable(IMFMediaTimeRange* ppSeekable);
    BOOL    IsEnded();
    BOOL    GetAutoPlay();
    HRESULT SetAutoPlay(BOOL AutoPlay);
    BOOL    GetLoop();
    HRESULT SetLoop(BOOL Loop);
    HRESULT Play();
    HRESULT Pause();
    BOOL    GetMuted();
    HRESULT SetMuted(BOOL Muted);
    double  GetVolume();
    HRESULT SetVolume(double Volume);
    BOOL    HasVideo();
    BOOL    HasAudio();
    HRESULT GetNativeVideoSize(uint* cx, uint* cy);
    HRESULT GetVideoAspectRatio(uint* cx, uint* cy);
    HRESULT Shutdown();
    HRESULT TransferVideoFrame(IUnknown pDstSurf, const(MFVideoNormalizedRect)* pSrc, const(RECT)* pDst, 
                               const(MFARGB)* pBorderClr);
    HRESULT OnVideoStreamTick(long* pPts);
}

@GUID("83015EAD-B1E6-40D0-A98A-37145FFE1AD1")
interface IMFMediaEngineEx : IMFMediaEngine
{
    HRESULT SetSourceFromByteStream(IMFByteStream pByteStream, BSTR pURL);
    HRESULT GetStatistics(MF_MEDIA_ENGINE_STATISTIC StatisticID, PROPVARIANT* pStatistic);
    HRESULT UpdateVideoStream(const(MFVideoNormalizedRect)* pSrc, const(RECT)* pDst, const(MFARGB)* pBorderClr);
    double  GetBalance();
    HRESULT SetBalance(double balance);
    BOOL    IsPlaybackRateSupported(double rate);
    HRESULT FrameStep(BOOL Forward);
    HRESULT GetResourceCharacteristics(uint* pCharacteristics);
    HRESULT GetPresentationAttribute(const(GUID)* guidMFAttribute, PROPVARIANT* pvValue);
    HRESULT GetNumberOfStreams(uint* pdwStreamCount);
    HRESULT GetStreamAttribute(uint dwStreamIndex, const(GUID)* guidMFAttribute, PROPVARIANT* pvValue);
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
    BOOL    IsStereo3D();
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

@GUID("7A3BAC98-0E76-49FB-8C20-8A86FD98EAF2")
interface IMFMediaEngineAudioEndpointId : IUnknown
{
    HRESULT SetAudioEndpointId(const(wchar)* pszEndpointId);
    HRESULT GetAudioEndpointId(ushort** ppszEndpointId);
}

@GUID("2F69D622-20B5-41E9-AFDF-89CED1DDA04E")
interface IMFMediaEngineExtension : IUnknown
{
    HRESULT CanPlayType(BOOL AudioOnly, BSTR MimeType, MF_MEDIA_ENGINE_CANPLAY* pAnswer);
    HRESULT BeginCreateObject(BSTR bstrURL, IMFByteStream pByteStream, MF_OBJECT_TYPE type, 
                              IUnknown* ppIUnknownCancelCookie, IMFAsyncCallback pCallback, IUnknown punkState);
    HRESULT CancelObjectCreation(IUnknown pIUnknownCancelCookie);
    HRESULT EndCreateObject(IMFAsyncResult pResult, IUnknown* ppObject);
}

@GUID("9F8021E8-9C8C-487E-BB5C-79AA4779938C")
interface IMFMediaEngineProtectedContent : IUnknown
{
    HRESULT ShareResources(IUnknown pUnkDeviceContext);
    HRESULT GetRequiredProtections(uint* pFrameProtectionFlags);
    HRESULT SetOPMWindow(HWND hwnd);
    HRESULT TransferVideoFrame(IUnknown pDstSurf, const(MFVideoNormalizedRect)* pSrc, const(RECT)* pDst, 
                               const(MFARGB)* pBorderClr, uint* pFrameProtectionFlags);
    HRESULT SetContentProtectionManager(IMFContentProtectionManager pCPM);
    HRESULT SetApplicationCertificate(char* pbBlob, uint cbBlob);
}

@GUID("EBBAF249-AFC2-4582-91C6-B60DF2E84954")
interface IAudioSourceProvider : IUnknown
{
    HRESULT ProvideInput(uint dwSampleCount, uint* pdwChannelCount, char* pInterleavedAudioData);
}

@GUID("BA2743A1-07E0-48EF-84B6-9A2ED023CA6C")
interface IMFMediaEngineWebSupport : IUnknown
{
    BOOL    ShouldDelayTheLoadEvent();
    HRESULT ConnectWebAudio(uint dwSampleRate, IAudioSourceProvider* ppSourceProvider);
    HRESULT DisconnectWebAudio();
}

@GUID("A7901327-05DD-4469-A7B7-0E01979E361D")
interface IMFMediaSourceExtensionNotify : IUnknown
{
    void OnSourceOpen();
    void OnSourceEnded();
    void OnSourceClose();
}

@GUID("24CD47F7-81D8-4785-ADB2-AF697A963CD2")
interface IMFBufferListNotify : IUnknown
{
    void OnAddSourceBuffer();
    void OnRemoveSourceBuffer();
}

@GUID("87E47623-2CEB-45D6-9B88-D8520C4DCBBC")
interface IMFSourceBufferNotify : IUnknown
{
    void OnUpdateStart();
    void OnAbort();
    void OnError(HRESULT hr);
    void OnUpdate();
    void OnUpdateEnd();
}

@GUID("E2CD3A4B-AF25-4D3D-9110-DA0E6F8EE877")
interface IMFSourceBuffer : IUnknown
{
    BOOL    GetUpdating();
    HRESULT GetBuffered(IMFMediaTimeRange* ppBuffered);
    double  GetTimeStampOffset();
    HRESULT SetTimeStampOffset(double offset);
    double  GetAppendWindowStart();
    HRESULT SetAppendWindowStart(double time);
    double  GetAppendWindowEnd();
    HRESULT SetAppendWindowEnd(double time);
    HRESULT Append(char* pData, uint len);
    HRESULT AppendByteStream(IMFByteStream pStream, ulong* pMaxLen);
    HRESULT Abort();
    HRESULT Remove(double start, double end);
}

@GUID("19666FB4-BABE-4C55-BC03-0A074DA37E2A")
interface IMFSourceBufferAppendMode : IUnknown
{
    MF_MSE_APPEND_MODE GetAppendMode();
    HRESULT SetAppendMode(MF_MSE_APPEND_MODE mode);
}

@GUID("249981F8-8325-41F3-B80C-3B9E3AAD0CBE")
interface IMFSourceBufferList : IUnknown
{
    uint GetLength();
    IMFSourceBuffer GetSourceBuffer(uint index);
}

@GUID("E467B94E-A713-4562-A802-816A42E9008A")
interface IMFMediaSourceExtension : IUnknown
{
    IMFSourceBufferList GetSourceBuffers();
    IMFSourceBufferList GetActiveSourceBuffers();
    MF_MSE_READY GetReadyState();
    double  GetDuration();
    HRESULT SetDuration(double duration);
    HRESULT AddSourceBuffer(BSTR type, IMFSourceBufferNotify pNotify, IMFSourceBuffer* ppSourceBuffer);
    HRESULT RemoveSourceBuffer(IMFSourceBuffer pSourceBuffer);
    HRESULT SetEndOfStream(MF_MSE_ERROR error);
    BOOL    IsTypeSupported(BSTR type);
    IMFSourceBuffer GetSourceBuffer(uint dwStreamIndex);
}

@GUID("5D1ABFD6-450A-4D92-9EFC-D6B6CBC1F4DA")
interface IMFMediaSourceExtensionLiveSeekableRange : IUnknown
{
    HRESULT SetLiveSeekableRange(double start, double end);
    HRESULT ClearLiveSeekableRange();
}

@GUID("50DC93E4-BA4F-4275-AE66-83E836E57469")
interface IMFMediaEngineEME : IUnknown
{
    HRESULT get_Keys(IMFMediaKeys* keys);
    HRESULT SetMediaKeys(IMFMediaKeys keys);
}

@GUID("654A6BB3-E1A3-424A-9908-53A43A0DFDA0")
interface IMFMediaEngineSrcElementsEx : IMFMediaEngineSrcElements
{
    HRESULT AddElementEx(BSTR pURL, BSTR pType, BSTR pMedia, BSTR keySystem);
    HRESULT GetKeySystem(uint index, BSTR* pType);
}

@GUID("46A30204-A696-4B18-8804-246B8F031BB1")
interface IMFMediaEngineNeedKeyNotify : IUnknown
{
    void NeedKey(char* initData, uint cb);
}

@GUID("5CB31C05-61FF-418F-AFDA-CAAF41421A38")
interface IMFMediaKeys : IUnknown
{
    HRESULT CreateSession(BSTR mimeType, char* initData, uint cb, char* customData, uint cbCustomData, 
                          IMFMediaKeySessionNotify notify, IMFMediaKeySession* ppSession);
    HRESULT get_KeySystem(BSTR* keySystem);
    HRESULT Shutdown();
    HRESULT GetSuspendNotify(IMFCdmSuspendNotify* notify);
}

@GUID("24FA67D5-D1D0-4DC5-995C-C0EFDC191FB5")
interface IMFMediaKeySession : IUnknown
{
    HRESULT GetError(ushort* code, uint* systemCode);
    HRESULT get_KeySystem(BSTR* keySystem);
    HRESULT get_SessionId(BSTR* sessionId);
    HRESULT Update(char* key, uint cb);
    HRESULT Close();
}

@GUID("6A0083F9-8947-4C1D-9CE0-CDEE22B23135")
interface IMFMediaKeySessionNotify : IUnknown
{
    void KeyMessage(BSTR destinationURL, char* message, uint cb);
    void KeyAdded();
    void KeyError(ushort code, uint systemCode);
}

@GUID("7A5645D2-43BD-47FD-87B7-DCD24CC7D692")
interface IMFCdmSuspendNotify : IUnknown
{
    HRESULT Begin();
    HRESULT End();
}

@GUID("DE400F54-5BF1-40CF-8964-0BEA136B1E3D")
interface IMFHDCPStatus : IUnknown
{
    HRESULT Query(MF_HDCP_STATUS* pStatus, int* pfStatus);
    HRESULT Set(MF_HDCP_STATUS status);
}

@GUID("765763E6-6C01-4B01-BB0F-B829F60ED28C")
interface IMFMediaEngineOPMInfo : IUnknown
{
    HRESULT GetOPMInfo(MF_MEDIA_ENGINE_OPM_STATUS* pStatus, int* pConstricted);
}

@GUID("4D645ACE-26AA-4688-9BE1-DF3516990B93")
interface IMFMediaEngineClassFactory : IUnknown
{
    HRESULT CreateInstance(uint dwFlags, IMFAttributes pAttr, IMFMediaEngine* ppPlayer);
    HRESULT CreateTimeRange(IMFMediaTimeRange* ppTimeRange);
    HRESULT CreateError(IMFMediaError* ppError);
}

@GUID("C56156C6-EA5B-48A5-9DF8-FBE035D0929E")
interface IMFMediaEngineClassFactoryEx : IMFMediaEngineClassFactory
{
    HRESULT CreateMediaSourceExtension(uint dwFlags, IMFAttributes pAttr, IMFMediaSourceExtension* ppMSE);
    HRESULT CreateMediaKeys(BSTR keySystem, BSTR cdmStorePath, IMFMediaKeys* ppKeys);
    HRESULT IsTypeSupported(BSTR type, BSTR keySystem, int* isSupported);
}

@GUID("09083CEF-867F-4BF6-8776-DEE3A7B42FCA")
interface IMFMediaEngineClassFactory2 : IUnknown
{
    HRESULT CreateMediaKeys2(BSTR keySystem, BSTR defaultCdmStorePath, BSTR inprivateCdmStorePath, 
                             IMFMediaKeys* ppKeys);
}

@GUID("332EC562-3758-468D-A784-E38F23552128")
interface IMFExtendedDRMTypeSupport : IUnknown
{
    HRESULT IsTypeSupportedEx(BSTR type, BSTR keySystem, MF_MEDIA_ENGINE_CANPLAY* pAnswer);
}

@GUID("A724B056-1B2E-4642-A6F3-DB9420C52908")
interface IMFMediaEngineSupportsSourceTransfer : IUnknown
{
    HRESULT ShouldTransferSource(int* pfShouldTransfer);
    HRESULT DetachMediaSource(IMFByteStream* ppByteStream, IMFMediaSource* ppMediaSource, 
                              IMFMediaSourceExtension* ppMSE);
    HRESULT AttachMediaSource(IMFByteStream pByteStream, IMFMediaSource pMediaSource, IMFMediaSourceExtension pMSE);
}

@GUID("24230452-FE54-40CC-94F3-FCC394C340D6")
interface IMFMediaEngineTransferSource : IUnknown
{
    HRESULT TransferSourceToMediaEngine(IMFMediaEngine destination);
}

@GUID("1F2A94C9-A3DF-430D-9D0F-ACD85DDC29AF")
interface IMFTimedText : IUnknown
{
    HRESULT RegisterNotifications(IMFTimedTextNotify notify);
    HRESULT SelectTrack(uint trackId, BOOL selected);
    HRESULT AddDataSource(IMFByteStream byteStream, const(wchar)* label, const(wchar)* language, 
                          MF_TIMED_TEXT_TRACK_KIND kind, BOOL isDefault, uint* trackId);
    HRESULT AddDataSourceFromUrl(const(wchar)* url, const(wchar)* label, const(wchar)* language, 
                                 MF_TIMED_TEXT_TRACK_KIND kind, BOOL isDefault, uint* trackId);
    HRESULT AddTrack(const(wchar)* label, const(wchar)* language, MF_TIMED_TEXT_TRACK_KIND kind, 
                     IMFTimedTextTrack* track);
    HRESULT RemoveTrack(IMFTimedTextTrack track);
    HRESULT GetCueTimeOffset(double* offset);
    HRESULT SetCueTimeOffset(double offset);
    HRESULT GetTracks(IMFTimedTextTrackList* tracks);
    HRESULT GetActiveTracks(IMFTimedTextTrackList* activeTracks);
    HRESULT GetTextTracks(IMFTimedTextTrackList* textTracks);
    HRESULT GetMetadataTracks(IMFTimedTextTrackList* metadataTracks);
    HRESULT SetInBandEnabled(BOOL enabled);
    BOOL    IsInBandEnabled();
}

@GUID("DF6B87B6-CE12-45DB-ABA7-432FE054E57D")
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

@GUID("8822C32D-654E-4233-BF21-D7F2E67D30D4")
interface IMFTimedTextTrack : IUnknown
{
    uint    GetId();
    HRESULT GetLabel(ushort** label);
    HRESULT SetLabel(const(wchar)* label);
    HRESULT GetLanguage(ushort** language);
    MF_TIMED_TEXT_TRACK_KIND GetTrackKind();
    BOOL    IsInBand();
    HRESULT GetInBandMetadataTrackDispatchType(ushort** dispatchType);
    BOOL    IsActive();
    MF_TIMED_TEXT_ERROR_CODE GetErrorCode();
    HRESULT GetExtendedErrorCode();
    HRESULT GetDataFormat(GUID* format);
    MF_TIMED_TEXT_TRACK_READY_STATE GetReadyState();
    HRESULT GetCueList(IMFTimedTextCueList* cues);
}

@GUID("23FF334C-442C-445F-BCCC-EDC438AA11E2")
interface IMFTimedTextTrackList : IUnknown
{
    uint    GetLength();
    HRESULT GetTrack(uint index, IMFTimedTextTrack* track);
    HRESULT GetTrackById(uint trackId, IMFTimedTextTrack* track);
}

@GUID("1E560447-9A2B-43E1-A94C-B0AAABFBFBC9")
interface IMFTimedTextCue : IUnknown
{
    uint    GetId();
    HRESULT GetOriginalId(ushort** originalId);
    MF_TIMED_TEXT_TRACK_KIND GetCueKind();
    double  GetStartTime();
    double  GetDuration();
    uint    GetTrackId();
    HRESULT GetData(IMFTimedTextBinary* data);
    HRESULT GetRegion(IMFTimedTextRegion* region);
    HRESULT GetStyle(IMFTimedTextStyle* style);
    uint    GetLineCount();
    HRESULT GetLine(uint index, IMFTimedTextFormattedText* line);
}

@GUID("E13AF3C1-4D47-4354-B1F5-E83AE0ECAE60")
interface IMFTimedTextFormattedText : IUnknown
{
    HRESULT GetText(ushort** text);
    uint    GetSubformattingCount();
    HRESULT GetSubformatting(uint index, uint* firstChar, uint* charLength, IMFTimedTextStyle* style);
}

@GUID("09B2455D-B834-4F01-A347-9052E21C450E")
interface IMFTimedTextStyle : IUnknown
{
    HRESULT GetName(ushort** name);
    BOOL    IsExternal();
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

@GUID("C8D22AFC-BC47-4BDF-9B04-787E49CE3F58")
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
    HRESULT GetPadding(double* before, double* start, double* after, double* end, 
                       MF_TIMED_TEXT_UNIT_TYPE* unitType);
    HRESULT GetWrap(int* wrap);
    HRESULT GetZIndex(int* zIndex);
    HRESULT GetScrollMode(MF_TIMED_TEXT_SCROLL_MODE* scrollMode);
}

@GUID("4AE3A412-0545-43C4-BF6F-6B97A5C6C432")
interface IMFTimedTextBinary : IUnknown
{
    HRESULT GetData(const(ubyte)** data, uint* length);
}

@GUID("AD128745-211B-40A0-9981-FE65F166D0FD")
interface IMFTimedTextCueList : IUnknown
{
    uint    GetLength();
    HRESULT GetCueByIndex(uint index, IMFTimedTextCue* cue);
    HRESULT GetCueById(uint id, IMFTimedTextCue* cue);
    HRESULT GetCueByOriginalId(const(wchar)* originalId, IMFTimedTextCue* cue);
    HRESULT AddTextCue(double start, double duration, const(wchar)* text, IMFTimedTextCue* cue);
    HRESULT AddDataCue(double start, double duration, char* data, uint dataSize, IMFTimedTextCue* cue);
    HRESULT RemoveCue(IMFTimedTextCue cue);
}

@GUID("9E184D15-CDB7-4F86-B49E-566689F4A601")
interface IMFMediaEngineEMENotify : IUnknown
{
    void Encrypted(char* pbInitData, uint cb, BSTR bstrInitDataType);
    void WaitingForKey();
}

@GUID("C3A9E92A-DA88-46B0-A110-6CF953026CB9")
interface IMFMediaKeySessionNotify2 : IMFMediaKeySessionNotify
{
    void KeyMessage2(MF_MEDIAKEYSESSION_MESSAGETYPE eMessageType, BSTR destinationURL, char* pbMessage, 
                     uint cbMessage);
    void KeyStatusChange();
}

@GUID("AEC63FDA-7A97-4944-B35C-6C6DF8085CC3")
interface IMFMediaKeySystemAccess : IUnknown
{
    HRESULT CreateMediaKeys(IPropertyStore pCdmCustomConfig, IMFMediaKeys2* ppKeys);
    HRESULT get_SupportedConfiguration(IPropertyStore* ppSupportedConfiguration);
    HRESULT get_KeySystem(BSTR* pKeySystem);
}

@GUID("3787614F-65F7-4003-B673-EAD8293A0E60")
interface IMFMediaEngineClassFactory3 : IUnknown
{
    HRESULT CreateMediaKeySystemAccess(BSTR keySystem, char* ppSupportedConfigurationsArray, uint uSize, 
                                       IMFMediaKeySystemAccess* ppKeyAccess);
}

@GUID("45892507-AD66-4DE2-83A2-ACBB13CD8D43")
interface IMFMediaKeys2 : IMFMediaKeys
{
    HRESULT CreateSession2(MF_MEDIAKEYSESSION_TYPE eSessionType, 
                           IMFMediaKeySessionNotify2 pMFMediaKeySessionNotify2, IMFMediaKeySession2* ppSession);
    HRESULT SetServerCertificate(char* pbServerCertificate, uint cb);
    HRESULT GetDOMException(HRESULT systemCode, int* code);
}

@GUID("E9707E05-6D55-4636-B185-3DE21210BD75")
interface IMFMediaKeySession2 : IMFMediaKeySession
{
    HRESULT get_KeyStatuses(MFMediaKeyStatus** pKeyStatusesArray, uint* puSize);
    HRESULT Load(BSTR bstrSessionId, int* pfLoaded);
    HRESULT GenerateRequest(BSTR initDataType, char* pbInitData, uint cb);
    HRESULT get_Expiration(double* dblExpiration);
    HRESULT Remove();
    HRESULT Shutdown();
}

@GUID("FBE256C1-43CF-4A9B-8CB8-CE8632A34186")
interface IMFMediaEngineClassFactory4 : IUnknown
{
    HRESULT CreateContentDecryptionModuleFactory(const(wchar)* keySystem, const(GUID)* riid, void** ppvObject);
}

@GUID("0C012799-1B61-4C10-BDA9-04445BE5F561")
interface IMFDLNASinkInit : IUnknown
{
    HRESULT Initialize(IMFByteStream pByteStream, BOOL fPal);
}

@GUID("E7FE2E12-661C-40DA-92F9-4F002AB67627")
interface IMFReadWriteClassFactory : IUnknown
{
    HRESULT CreateInstanceFromURL(const(GUID)* clsid, const(wchar)* pwszURL, IMFAttributes pAttributes, 
                                  const(GUID)* riid, void** ppvObject);
    HRESULT CreateInstanceFromObject(const(GUID)* clsid, IUnknown punkObject, IMFAttributes pAttributes, 
                                     const(GUID)* riid, void** ppvObject);
}

@GUID("70AE66F2-C809-4E4F-8915-BDCB406B7993")
interface IMFSourceReader : IUnknown
{
    HRESULT GetStreamSelection(uint dwStreamIndex, int* pfSelected);
    HRESULT SetStreamSelection(uint dwStreamIndex, BOOL fSelected);
    HRESULT GetNativeMediaType(uint dwStreamIndex, uint dwMediaTypeIndex, IMFMediaType* ppMediaType);
    HRESULT GetCurrentMediaType(uint dwStreamIndex, IMFMediaType* ppMediaType);
    HRESULT SetCurrentMediaType(uint dwStreamIndex, uint* pdwReserved, IMFMediaType pMediaType);
    HRESULT SetCurrentPosition(const(GUID)* guidTimeFormat, const(PROPVARIANT)* varPosition);
    HRESULT ReadSample(uint dwStreamIndex, uint dwControlFlags, uint* pdwActualStreamIndex, uint* pdwStreamFlags, 
                       long* pllTimestamp, IMFSample* ppSample);
    HRESULT Flush(uint dwStreamIndex);
    HRESULT GetServiceForStream(uint dwStreamIndex, const(GUID)* guidService, const(GUID)* riid, void** ppvObject);
    HRESULT GetPresentationAttribute(uint dwStreamIndex, const(GUID)* guidAttribute, PROPVARIANT* pvarAttribute);
}

@GUID("7B981CF0-560E-4116-9875-B099895F23D7")
interface IMFSourceReaderEx : IMFSourceReader
{
    HRESULT SetNativeMediaType(uint dwStreamIndex, IMFMediaType pMediaType, uint* pdwStreamFlags);
    HRESULT AddTransformForStream(uint dwStreamIndex, IUnknown pTransformOrActivate);
    HRESULT RemoveAllTransformsForStream(uint dwStreamIndex);
    HRESULT GetTransformForStream(uint dwStreamIndex, uint dwTransformIndex, GUID* pGuidCategory, 
                                  IMFTransform* ppTransform);
}

@GUID("DEEC8D99-FA1D-4D82-84C2-2C8969944867")
interface IMFSourceReaderCallback : IUnknown
{
    HRESULT OnReadSample(HRESULT hrStatus, uint dwStreamIndex, uint dwStreamFlags, long llTimestamp, 
                         IMFSample pSample);
    HRESULT OnFlush(uint dwStreamIndex);
    HRESULT OnEvent(uint dwStreamIndex, IMFMediaEvent pEvent);
}

@GUID("CF839FE6-8C2A-4DD2-B6EA-C22D6961AF05")
interface IMFSourceReaderCallback2 : IMFSourceReaderCallback
{
    HRESULT OnTransformChange();
    HRESULT OnStreamError(uint dwStreamIndex, HRESULT hrStatus);
}

@GUID("3137F1CD-FE5E-4805-A5D8-FB477448CB3D")
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
    HRESULT GetServiceForStream(uint dwStreamIndex, const(GUID)* guidService, const(GUID)* riid, void** ppvObject);
    HRESULT GetStatistics(uint dwStreamIndex, MF_SINK_WRITER_STATISTICS* pStats);
}

@GUID("588D72AB-5BC1-496A-8714-B70617141B25")
interface IMFSinkWriterEx : IMFSinkWriter
{
    HRESULT GetTransformForStream(uint dwStreamIndex, uint dwTransformIndex, GUID* pGuidCategory, 
                                  IMFTransform* ppTransform);
}

@GUID("17C3779E-3CDE-4EDE-8C60-3899F5F53AD6")
interface IMFSinkWriterEncoderConfig : IUnknown
{
    HRESULT SetTargetMediaType(uint dwStreamIndex, IMFMediaType pTargetMediaType, 
                               IMFAttributes pEncodingParameters);
    HRESULT PlaceEncodingParameters(uint dwStreamIndex, IMFAttributes pEncodingParameters);
}

@GUID("666F76DE-33D2-41B9-A458-29ED0A972C58")
interface IMFSinkWriterCallback : IUnknown
{
    HRESULT OnFinalize(HRESULT hrStatus);
    HRESULT OnMarker(uint dwStreamIndex, void* pvContext);
}

@GUID("2456BD58-C067-4513-84FE-8D0C88FFDC61")
interface IMFSinkWriterCallback2 : IMFSinkWriterCallback
{
    HRESULT OnTransformChange();
    HRESULT OnStreamError(uint dwStreamIndex, HRESULT hrStatus);
}

@GUID("1F6A9F17-E70B-4E24-8AE4-0B2C3BA7A4AE")
interface IMFVideoPositionMapper : IUnknown
{
    HRESULT MapOutputCoordinateToInputStream(float xOut, float yOut, uint dwOutputStreamIndex, 
                                             uint dwInputStreamIndex, float* pxIn, float* pyIn);
}

@GUID("A38D9567-5A9C-4F3C-B293-8EB415B279BA")
interface IMFVideoDeviceID : IUnknown
{
    HRESULT GetDeviceID(GUID* pDeviceID);
}

@GUID("A490B1E4-AB84-4D31-A1B2-181E03B1077A")
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

@GUID("29AFF080-182A-4A5D-AF3B-448F3A6346CB")
interface IMFVideoPresenter : IMFClockStateSink
{
    HRESULT ProcessMessage(MFVP_MESSAGE_TYPE eMessage, size_t ulParam);
    HRESULT GetCurrentMediaType(IMFVideoMediaType* ppMediaType);
}

@GUID("56C294D0-753E-4260-8D61-A3D8820B1D54")
interface IMFDesiredSample : IUnknown
{
    HRESULT GetDesiredSampleTimeAndDuration(long* phnsSampleTime, long* phnsSampleDuration);
    void    SetDesiredSampleTimeAndDuration(long hnsSampleTime, long hnsSampleDuration);
    void    Clear();
}

@GUID("A5C6C53F-C202-4AA5-9695-175BA8C508A5")
interface IMFVideoMixerControl : IUnknown
{
    HRESULT SetStreamZOrder(uint dwStreamID, uint dwZ);
    HRESULT GetStreamZOrder(uint dwStreamID, uint* pdwZ);
    HRESULT SetStreamOutputRect(uint dwStreamID, const(MFVideoNormalizedRect)* pnrcOutput);
    HRESULT GetStreamOutputRect(uint dwStreamID, MFVideoNormalizedRect* pnrcOutput);
}

@GUID("8459616D-966E-4930-B658-54FA7E5A16D3")
interface IMFVideoMixerControl2 : IMFVideoMixerControl
{
    HRESULT SetMixingPrefs(uint dwMixFlags);
    HRESULT GetMixingPrefs(uint* pdwMixFlags);
}

@GUID("DFDFD197-A9CA-43D8-B341-6AF3503792CD")
interface IMFVideoRenderer : IUnknown
{
    HRESULT InitializeRenderer(IMFTransform pVideoMixer, IMFVideoPresenter pVideoPresenter);
}

@GUID("83E91E85-82C1-4EA7-801D-85DC50B75086")
interface IEVRFilterConfig : IUnknown
{
    HRESULT SetNumberOfStreams(uint dwMaxStreams);
    HRESULT GetNumberOfStreams(uint* pdwMaxStreams);
}

@GUID("AEA36028-796D-454F-BEEE-B48071E24304")
interface IEVRFilterConfigEx : IEVRFilterConfig
{
    HRESULT SetConfigPrefs(uint dwConfigFlags);
    HRESULT GetConfigPrefs(uint* pdwConfigFlags);
}

@GUID("FA993889-4383-415A-A930-DD472A8CF6F7")
interface IMFTopologyServiceLookup : IUnknown
{
    HRESULT LookupService(MF_SERVICE_LOOKUP_TYPE Type, uint dwIndex, const(GUID)* guidService, const(GUID)* riid, 
                          char* ppvObjects, uint* pnObjects);
}

@GUID("FA99388A-4383-415A-A930-DD472A8CF6F7")
interface IMFTopologyServiceLookupClient : IUnknown
{
    HRESULT InitServicePointers(IMFTopologyServiceLookup pLookup);
    HRESULT ReleaseServicePointers();
}

@GUID("83A4CE40-7710-494B-A893-A472049AF630")
interface IEVRTrustedVideoPlugin : IUnknown
{
    HRESULT IsInTrustedVideoMode(int* pYes);
    HRESULT CanConstrict(int* pYes);
    HRESULT SetConstriction(uint dwKPix);
    HRESULT DisableImageExport(BOOL bDisable);
}

@GUID("A714590A-58AF-430A-85BF-44F5EC838D85")
interface IMFPMediaPlayer : IUnknown
{
    HRESULT Play();
    HRESULT Pause();
    HRESULT Stop();
    HRESULT FrameStep();
    HRESULT SetPosition(const(GUID)* guidPositionType, const(PROPVARIANT)* pvPositionValue);
    HRESULT GetPosition(const(GUID)* guidPositionType, PROPVARIANT* pvPositionValue);
    HRESULT GetDuration(const(GUID)* guidPositionType, PROPVARIANT* pvDurationValue);
    HRESULT SetRate(float flRate);
    HRESULT GetRate(float* pflRate);
    HRESULT GetSupportedRates(BOOL fForwardDirection, float* pflSlowestRate, float* pflFastestRate);
    HRESULT GetState(MFP_MEDIAPLAYER_STATE* peState);
    HRESULT CreateMediaItemFromURL(const(wchar)* pwszURL, BOOL fSync, size_t dwUserData, 
                                   IMFPMediaItem* ppMediaItem);
    HRESULT CreateMediaItemFromObject(IUnknown pIUnknownObj, BOOL fSync, size_t dwUserData, 
                                      IMFPMediaItem* ppMediaItem);
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

@GUID("90EB3E6B-ECBF-45CC-B1DA-C6FE3EA70D57")
interface IMFPMediaItem : IUnknown
{
    HRESULT GetMediaPlayer(IMFPMediaPlayer* ppMediaPlayer);
    HRESULT GetURL(ushort** ppwszURL);
    HRESULT GetObjectA(IUnknown* ppIUnknown);
    HRESULT GetUserData(size_t* pdwUserData);
    HRESULT SetUserData(size_t dwUserData);
    HRESULT GetStartStopPosition(GUID* pguidStartPositionType, PROPVARIANT* pvStartValue, 
                                 GUID* pguidStopPositionType, PROPVARIANT* pvStopValue);
    HRESULT SetStartStopPosition(const(GUID)* pguidStartPositionType, const(PROPVARIANT)* pvStartValue, 
                                 const(GUID)* pguidStopPositionType, const(PROPVARIANT)* pvStopValue);
    HRESULT HasVideo(int* pfHasVideo, int* pfSelected);
    HRESULT HasAudio(int* pfHasAudio, int* pfSelected);
    HRESULT IsProtected(int* pfProtected);
    HRESULT GetDuration(const(GUID)* guidPositionType, PROPVARIANT* pvDurationValue);
    HRESULT GetNumberOfStreams(uint* pdwStreamCount);
    HRESULT GetStreamSelection(uint dwStreamIndex, int* pfEnabled);
    HRESULT SetStreamSelection(uint dwStreamIndex, BOOL fEnabled);
    HRESULT GetStreamAttribute(uint dwStreamIndex, const(GUID)* guidMFAttribute, PROPVARIANT* pvValue);
    HRESULT GetPresentationAttribute(const(GUID)* guidMFAttribute, PROPVARIANT* pvValue);
    HRESULT GetCharacteristics(uint* pCharacteristics);
    HRESULT SetStreamSink(uint dwStreamIndex, IUnknown pMediaSink);
    HRESULT GetMetadata(IPropertyStore* ppMetadataStore);
}

@GUID("766C8FFB-5FDB-4FEA-A28D-B912996F51BD")
interface IMFPMediaPlayerCallback : IUnknown
{
    void OnMediaPlayerEvent(MFP_EVENT_HEADER* pEventHeader);
}

@GUID("2BA61F92-8305-413B-9733-FAF15F259384")
interface IMFSharingEngineClassFactory : IUnknown
{
    HRESULT CreateInstance(uint dwFlags, IMFAttributes pAttr, IUnknown* ppEngine);
}

@GUID("8D3CE1BF-2367-40E0-9EEE-40D377CC1B46")
interface IMFMediaSharingEngine : IMFMediaEngine
{
    HRESULT GetDevice(DEVICE_INFO* pDevice);
}

@GUID("524D2BC4-B2B1-4FE5-8FAC-FA4E4512B4E0")
interface IMFMediaSharingEngineClassFactory : IUnknown
{
    HRESULT CreateInstance(uint dwFlags, IMFAttributes pAttr, IMFMediaSharingEngine* ppEngine);
}

@GUID("CFA0AE8E-7E1C-44D2-AE68-FC4C148A6354")
interface IMFImageSharingEngine : IUnknown
{
    HRESULT SetSource(IUnknown pStream);
    HRESULT GetDevice(DEVICE_INFO* pDevice);
    HRESULT Shutdown();
}

@GUID("1FC55727-A7FB-4FC8-83AE-8AF024990AF1")
interface IMFImageSharingEngineClassFactory : IUnknown
{
    HRESULT CreateInstanceFromUDN(BSTR pUniqueDeviceName, IMFImageSharingEngine* ppEngine);
}

@GUID("607574EB-F4B6-45C1-B08C-CB715122901D")
interface IPlayToControl : IUnknown
{
    HRESULT Connect(IMFSharingEngineClassFactory pFactory);
    HRESULT Disconnect();
}

@GUID("AA9DD80F-C50A-4220-91C1-332287F82A34")
interface IPlayToControlWithCapabilities : IPlayToControl
{
    HRESULT GetCapabilities(PLAYTO_SOURCE_CREATEFLAGS* pCapabilities);
}

@GUID("842B32A3-9B9B-4D1C-B3F3-49193248A554")
interface IPlayToSourceClassFactory : IUnknown
{
    HRESULT CreateInstance(uint dwFlags, IPlayToControl pControl, IInspectable* ppSource);
}

@GUID("D0CFE38B-93E7-4772-8957-0400C49A4485")
interface IEVRVideoStreamControl : IUnknown
{
    HRESULT SetStreamActiveState(BOOL fActive);
    HRESULT GetStreamActiveState(int* lpfActive);
}

@GUID("6AB0000C-FECE-4D1F-A2AC-A9573530656E")
interface IMFVideoProcessor : IUnknown
{
    HRESULT GetAvailableVideoProcessorModes(uint* lpdwNumProcessingModes, char* ppVideoProcessingModes);
    HRESULT GetVideoProcessorCaps(GUID* lpVideoProcessorMode, DXVA2_VideoProcessorCaps* lpVideoProcessorCaps);
    HRESULT GetVideoProcessorMode(GUID* lpMode);
    HRESULT SetVideoProcessorMode(GUID* lpMode);
    HRESULT GetProcAmpRange(uint dwProperty, DXVA2_ValueRange* pPropRange);
    HRESULT GetProcAmpValues(uint dwFlags, DXVA2_ProcAmpValues* Values);
    HRESULT SetProcAmpValues(uint dwFlags, DXVA2_ProcAmpValues* pValues);
    HRESULT GetFilteringRange(uint dwProperty, DXVA2_ValueRange* pPropRange);
    HRESULT GetFilteringValue(uint dwProperty, DXVA2_Fixed32* pValue);
    HRESULT SetFilteringValue(uint dwProperty, DXVA2_Fixed32* pValue);
    HRESULT GetBackgroundColor(uint* lpClrBkg);
    HRESULT SetBackgroundColor(uint ClrBkg);
}

@GUID("814C7B20-0FDB-4EEC-AF8F-F957C8F69EDC")
interface IMFVideoMixerBitmap : IUnknown
{
    HRESULT SetAlphaBitmap(const(MFVideoAlphaBitmap)* pBmpParms);
    HRESULT ClearAlphaBitmap();
    HRESULT UpdateAlphaBitmapParameters(const(MFVideoAlphaBitmapParams)* pBmpParms);
    HRESULT GetAlphaBitmapParameters(MFVideoAlphaBitmapParams* pBmpParms);
}

@GUID("3DE21209-8BA6-4F2A-A577-2819B56FF14D")
interface IAdvancedMediaCaptureInitializationSettings : IUnknown
{
    HRESULT SetDirectxDeviceManager(IMFDXGIDeviceManager value);
}

@GUID("24E0485F-A33E-4AA1-B564-6019B1D14F65")
interface IAdvancedMediaCaptureSettings : IUnknown
{
    HRESULT GetDirectxDeviceManager(IMFDXGIDeviceManager* value);
}

@GUID("D0751585-D216-4344-B5BF-463B68F977BB")
interface IAdvancedMediaCapture : IUnknown
{
    HRESULT GetAdvancedMediaCaptureSettings(IAdvancedMediaCaptureSettings* value);
}

@GUID("D396EC8C-605E-4249-978D-72AD1C312872")
interface IMFSpatialAudioObjectBuffer : IMFMediaBuffer
{
    HRESULT SetID(uint u32ID);
    HRESULT GetID(uint* pu32ID);
    HRESULT SetType(AudioObjectType type);
    HRESULT GetType(AudioObjectType* pType);
    HRESULT GetMetadataItems(ISpatialAudioMetadataItems* ppMetadataItems);
}

@GUID("ABF28A9B-3393-4290-BA79-5FFC46D986B2")
interface IMFSpatialAudioSample : IMFSample
{
    HRESULT GetObjectCount(uint* pdwObjectCount);
    HRESULT AddSpatialAudioObject(IMFSpatialAudioObjectBuffer pAudioObjBuffer);
    HRESULT GetSpatialAudioObjectByIndex(uint dwIndex, IMFSpatialAudioObjectBuffer* ppAudioObjBuffer);
}

@GUID("4E233EFD-1DD2-49E8-B577-D63EEE4C0D33")
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

@GUID("3F96EE40-AD81-4096-8470-59A4B770F89A")
interface IMFContentDecryptionModuleSessionCallbacks : IUnknown
{
    HRESULT KeyMessage(MF_MEDIAKEYSESSION_MESSAGETYPE messageType, char* message, uint messageSize, 
                       const(wchar)* destinationURL);
    HRESULT KeyStatusChanged();
}

@GUID("87BE986C-10BE-4943-BF48-4B54CE1983A2")
interface IMFContentDecryptionModule : IUnknown
{
    HRESULT SetContentEnabler(IMFContentEnabler contentEnabler, IMFAsyncResult result);
    HRESULT GetSuspendNotify(IMFCdmSuspendNotify* notify);
    HRESULT SetPMPHostApp(IMFPMPHostApp pmpHostApp);
    HRESULT CreateSession(MF_MEDIAKEYSESSION_TYPE sessionType, 
                          IMFContentDecryptionModuleSessionCallbacks callbacks, 
                          IMFContentDecryptionModuleSession* session);
    HRESULT SetServerCertificate(char* certificate, uint certificateSize);
    HRESULT CreateTrustedInput(char* contentInitData, uint contentInitDataSize, IMFTrustedInput* trustedInput);
    HRESULT GetProtectionSystemIds(char* systemIds, uint* count);
}

@GUID("A853D1F4-E2A0-4303-9EDC-F1A68EE43136")
interface IMFContentDecryptionModuleAccess : IUnknown
{
    HRESULT CreateContentDecryptionModule(IPropertyStore contentDecryptionModuleProperties, 
                                          IMFContentDecryptionModule* contentDecryptionModule);
    HRESULT GetConfiguration(IPropertyStore* configuration);
    HRESULT GetKeySystem(ushort** keySystem);
}

@GUID("7D5ABF16-4CBB-4E08-B977-9BA59049943E")
interface IMFContentDecryptionModuleFactory : IUnknown
{
    BOOL    IsTypeSupported(const(wchar)* keySystem, const(wchar)* contentType);
    HRESULT CreateContentDecryptionModuleAccess(const(wchar)* keySystem, IPropertyStore* configurations, 
                                                uint numConfigurations, 
                                                IMFContentDecryptionModuleAccess* contentDecryptionModuleAccess);
}

@GUID("3C9C5B51-995D-48D1-9B8D-FA5CAEDED65C")
interface ID3D11VideoDecoder : ID3D11DeviceChild
{
    HRESULT GetCreationParameters(D3D11_VIDEO_DECODER_DESC* pVideoDesc, D3D11_VIDEO_DECODER_CONFIG* pConfig);
    HRESULT GetDriverHandle(HANDLE* pDriverHandle);
}

@GUID("31627037-53AB-4200-9061-05FAA9AB45F9")
interface ID3D11VideoProcessorEnumerator : ID3D11DeviceChild
{
    HRESULT GetVideoProcessorContentDesc(D3D11_VIDEO_PROCESSOR_CONTENT_DESC* pContentDesc);
    HRESULT CheckVideoProcessorFormat(DXGI_FORMAT Format, uint* pFlags);
    HRESULT GetVideoProcessorCaps(D3D11_VIDEO_PROCESSOR_CAPS* pCaps);
    HRESULT GetVideoProcessorRateConversionCaps(uint TypeIndex, D3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS* pCaps);
    HRESULT GetVideoProcessorCustomRate(uint TypeIndex, uint CustomRateIndex, 
                                        D3D11_VIDEO_PROCESSOR_CUSTOM_RATE* pRate);
    HRESULT GetVideoProcessorFilterRange(D3D11_VIDEO_PROCESSOR_FILTER Filter, 
                                         D3D11_VIDEO_PROCESSOR_FILTER_RANGE* pRange);
}

@GUID("1D7B0652-185F-41C6-85CE-0C5BE3D4AE6C")
interface ID3D11VideoProcessor : ID3D11DeviceChild
{
    void GetContentDesc(D3D11_VIDEO_PROCESSOR_CONTENT_DESC* pDesc);
    void GetRateConversionCaps(D3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS* pCaps);
}

@GUID("3015A308-DCBD-47AA-A747-192486D14D4A")
interface ID3D11AuthenticatedChannel : ID3D11DeviceChild
{
    HRESULT GetCertificateSize(uint* pCertificateSize);
    HRESULT GetCertificate(uint CertificateSize, char* pCertificate);
    void    GetChannelHandle(HANDLE* pChannelHandle);
}

@GUID("9B32F9AD-BDCC-40A6-A39D-D5C865845720")
interface ID3D11CryptoSession : ID3D11DeviceChild
{
    void    GetCryptoType(GUID* pCryptoType);
    void    GetDecoderProfile(GUID* pDecoderProfile);
    HRESULT GetCertificateSize(uint* pCertificateSize);
    HRESULT GetCertificate(uint CertificateSize, char* pCertificate);
    void    GetCryptoSessionHandle(HANDLE* pCryptoSessionHandle);
}

@GUID("C2931AEA-2A85-4F20-860F-FBA1FD256E18")
interface ID3D11VideoDecoderOutputView : ID3D11View
{
    void GetDesc(D3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC* pDesc);
}

@GUID("11EC5A5F-51DC-4945-AB34-6E8C21300EA5")
interface ID3D11VideoProcessorInputView : ID3D11View
{
    void GetDesc(D3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC* pDesc);
}

@GUID("A048285E-25A9-4527-BD93-D68B68C44254")
interface ID3D11VideoProcessorOutputView : ID3D11View
{
    void GetDesc(D3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC* pDesc);
}

@GUID("61F21C45-3C0E-4A74-9CEA-67100D9AD5E4")
interface ID3D11VideoContext : ID3D11DeviceChild
{
    HRESULT GetDecoderBuffer(ID3D11VideoDecoder pDecoder, D3D11_VIDEO_DECODER_BUFFER_TYPE Type, uint* pBufferSize, 
                             void** ppBuffer);
    HRESULT ReleaseDecoderBuffer(ID3D11VideoDecoder pDecoder, D3D11_VIDEO_DECODER_BUFFER_TYPE Type);
    HRESULT DecoderBeginFrame(ID3D11VideoDecoder pDecoder, ID3D11VideoDecoderOutputView pView, uint ContentKeySize, 
                              char* pContentKey);
    HRESULT DecoderEndFrame(ID3D11VideoDecoder pDecoder);
    HRESULT SubmitDecoderBuffers(ID3D11VideoDecoder pDecoder, uint NumBuffers, char* pBufferDesc);
    int     DecoderExtension(ID3D11VideoDecoder pDecoder, const(D3D11_VIDEO_DECODER_EXTENSION)* pExtensionData);
    void    VideoProcessorSetOutputTargetRect(ID3D11VideoProcessor pVideoProcessor, BOOL Enable, 
                                              const(RECT)* pRect);
    void    VideoProcessorSetOutputBackgroundColor(ID3D11VideoProcessor pVideoProcessor, BOOL YCbCr, 
                                                   const(D3D11_VIDEO_COLOR)* pColor);
    void    VideoProcessorSetOutputColorSpace(ID3D11VideoProcessor pVideoProcessor, 
                                              const(D3D11_VIDEO_PROCESSOR_COLOR_SPACE)* pColorSpace);
    void    VideoProcessorSetOutputAlphaFillMode(ID3D11VideoProcessor pVideoProcessor, 
                                                 D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE AlphaFillMode, 
                                                 uint StreamIndex);
    void    VideoProcessorSetOutputConstriction(ID3D11VideoProcessor pVideoProcessor, BOOL Enable, SIZE Size);
    void    VideoProcessorSetOutputStereoMode(ID3D11VideoProcessor pVideoProcessor, BOOL Enable);
    int     VideoProcessorSetOutputExtension(ID3D11VideoProcessor pVideoProcessor, const(GUID)* pExtensionGuid, 
                                             uint DataSize, void* pData);
    void    VideoProcessorGetOutputTargetRect(ID3D11VideoProcessor pVideoProcessor, int* Enabled, RECT* pRect);
    void    VideoProcessorGetOutputBackgroundColor(ID3D11VideoProcessor pVideoProcessor, int* pYCbCr, 
                                                   D3D11_VIDEO_COLOR* pColor);
    void    VideoProcessorGetOutputColorSpace(ID3D11VideoProcessor pVideoProcessor, 
                                              D3D11_VIDEO_PROCESSOR_COLOR_SPACE* pColorSpace);
    void    VideoProcessorGetOutputAlphaFillMode(ID3D11VideoProcessor pVideoProcessor, 
                                                 D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE* pAlphaFillMode, 
                                                 uint* pStreamIndex);
    void    VideoProcessorGetOutputConstriction(ID3D11VideoProcessor pVideoProcessor, int* pEnabled, SIZE* pSize);
    void    VideoProcessorGetOutputStereoMode(ID3D11VideoProcessor pVideoProcessor, int* pEnabled);
    int     VideoProcessorGetOutputExtension(ID3D11VideoProcessor pVideoProcessor, const(GUID)* pExtensionGuid, 
                                             uint DataSize, char* pData);
    void    VideoProcessorSetStreamFrameFormat(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                               D3D11_VIDEO_FRAME_FORMAT FrameFormat);
    void    VideoProcessorSetStreamColorSpace(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                              const(D3D11_VIDEO_PROCESSOR_COLOR_SPACE)* pColorSpace);
    void    VideoProcessorSetStreamOutputRate(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                              D3D11_VIDEO_PROCESSOR_OUTPUT_RATE OutputRate, BOOL RepeatFrame, 
                                              const(DXGI_RATIONAL)* pCustomRate);
    void    VideoProcessorSetStreamSourceRect(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, 
                                              const(RECT)* pRect);
    void    VideoProcessorSetStreamDestRect(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, 
                                            const(RECT)* pRect);
    void    VideoProcessorSetStreamAlpha(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, 
                                         float Alpha);
    void    VideoProcessorSetStreamPalette(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, uint Count, 
                                           char* pEntries);
    void    VideoProcessorSetStreamPixelAspectRatio(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                                    BOOL Enable, const(DXGI_RATIONAL)* pSourceAspectRatio, 
                                                    const(DXGI_RATIONAL)* pDestinationAspectRatio);
    void    VideoProcessorSetStreamLumaKey(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, 
                                           float Lower, float Upper);
    void    VideoProcessorSetStreamStereoFormat(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                                BOOL Enable, D3D11_VIDEO_PROCESSOR_STEREO_FORMAT Format, 
                                                BOOL LeftViewFrame0, BOOL BaseViewFrame0, 
                                                D3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE FlipMode, int MonoOffset);
    void    VideoProcessorSetStreamAutoProcessingMode(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                                      BOOL Enable);
    void    VideoProcessorSetStreamFilter(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                          D3D11_VIDEO_PROCESSOR_FILTER Filter, BOOL Enable, int Level);
    int     VideoProcessorSetStreamExtension(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                             const(GUID)* pExtensionGuid, uint DataSize, void* pData);
    void    VideoProcessorGetStreamFrameFormat(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                               D3D11_VIDEO_FRAME_FORMAT* pFrameFormat);
    void    VideoProcessorGetStreamColorSpace(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                              D3D11_VIDEO_PROCESSOR_COLOR_SPACE* pColorSpace);
    void    VideoProcessorGetStreamOutputRate(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                              D3D11_VIDEO_PROCESSOR_OUTPUT_RATE* pOutputRate, int* pRepeatFrame, 
                                              DXGI_RATIONAL* pCustomRate);
    void    VideoProcessorGetStreamSourceRect(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                              int* pEnabled, RECT* pRect);
    void    VideoProcessorGetStreamDestRect(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnabled, 
                                            RECT* pRect);
    void    VideoProcessorGetStreamAlpha(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnabled, 
                                         float* pAlpha);
    void    VideoProcessorGetStreamPalette(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, uint Count, 
                                           char* pEntries);
    void    VideoProcessorGetStreamPixelAspectRatio(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                                    int* pEnabled, DXGI_RATIONAL* pSourceAspectRatio, 
                                                    DXGI_RATIONAL* pDestinationAspectRatio);
    void    VideoProcessorGetStreamLumaKey(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnabled, 
                                           float* pLower, float* pUpper);
    void    VideoProcessorGetStreamStereoFormat(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                                int* pEnable, D3D11_VIDEO_PROCESSOR_STEREO_FORMAT* pFormat, 
                                                int* pLeftViewFrame0, int* pBaseViewFrame0, 
                                                D3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE* pFlipMode, int* MonoOffset);
    void    VideoProcessorGetStreamAutoProcessingMode(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                                      int* pEnabled);
    void    VideoProcessorGetStreamFilter(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                          D3D11_VIDEO_PROCESSOR_FILTER Filter, int* pEnabled, int* pLevel);
    int     VideoProcessorGetStreamExtension(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                             const(GUID)* pExtensionGuid, uint DataSize, char* pData);
    HRESULT VideoProcessorBlt(ID3D11VideoProcessor pVideoProcessor, ID3D11VideoProcessorOutputView pView, 
                              uint OutputFrame, uint StreamCount, char* pStreams);
    HRESULT NegotiateCryptoSessionKeyExchange(ID3D11CryptoSession pCryptoSession, uint DataSize, char* pData);
    void    EncryptionBlt(ID3D11CryptoSession pCryptoSession, ID3D11Texture2D pSrcSurface, 
                          ID3D11Texture2D pDstSurface, uint IVSize, char* pIV);
    void    DecryptionBlt(ID3D11CryptoSession pCryptoSession, ID3D11Texture2D pSrcSurface, 
                          ID3D11Texture2D pDstSurface, D3D11_ENCRYPTED_BLOCK_INFO* pEncryptedBlockInfo, 
                          uint ContentKeySize, char* pContentKey, uint IVSize, char* pIV);
    void    StartSessionKeyRefresh(ID3D11CryptoSession pCryptoSession, uint RandomNumberSize, char* pRandomNumber);
    void    FinishSessionKeyRefresh(ID3D11CryptoSession pCryptoSession);
    HRESULT GetEncryptionBltKey(ID3D11CryptoSession pCryptoSession, uint KeySize, char* pReadbackKey);
    HRESULT NegotiateAuthenticatedChannelKeyExchange(ID3D11AuthenticatedChannel pChannel, uint DataSize, 
                                                     char* pData);
    HRESULT QueryAuthenticatedChannel(ID3D11AuthenticatedChannel pChannel, uint InputSize, char* pInput, 
                                      uint OutputSize, char* pOutput);
    HRESULT ConfigureAuthenticatedChannel(ID3D11AuthenticatedChannel pChannel, uint InputSize, char* pInput, 
                                          D3D11_AUTHENTICATED_CONFIGURE_OUTPUT* pOutput);
    void    VideoProcessorSetStreamRotation(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, 
                                            D3D11_VIDEO_PROCESSOR_ROTATION Rotation);
    void    VideoProcessorGetStreamRotation(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnable, 
                                            D3D11_VIDEO_PROCESSOR_ROTATION* pRotation);
}

@GUID("10EC4D5B-975A-4689-B9E4-D0AAC30FE333")
interface ID3D11VideoDevice : IUnknown
{
    HRESULT CreateVideoDecoder(const(D3D11_VIDEO_DECODER_DESC)* pVideoDesc, 
                               const(D3D11_VIDEO_DECODER_CONFIG)* pConfig, ID3D11VideoDecoder* ppDecoder);
    HRESULT CreateVideoProcessor(ID3D11VideoProcessorEnumerator pEnum, uint RateConversionIndex, 
                                 ID3D11VideoProcessor* ppVideoProcessor);
    HRESULT CreateAuthenticatedChannel(D3D11_AUTHENTICATED_CHANNEL_TYPE ChannelType, 
                                       ID3D11AuthenticatedChannel* ppAuthenticatedChannel);
    HRESULT CreateCryptoSession(const(GUID)* pCryptoType, const(GUID)* pDecoderProfile, 
                                const(GUID)* pKeyExchangeType, ID3D11CryptoSession* ppCryptoSession);
    HRESULT CreateVideoDecoderOutputView(ID3D11Resource pResource, 
                                         const(D3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC)* pDesc, 
                                         ID3D11VideoDecoderOutputView* ppVDOVView);
    HRESULT CreateVideoProcessorInputView(ID3D11Resource pResource, ID3D11VideoProcessorEnumerator pEnum, 
                                          const(D3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC)* pDesc, 
                                          ID3D11VideoProcessorInputView* ppVPIView);
    HRESULT CreateVideoProcessorOutputView(ID3D11Resource pResource, ID3D11VideoProcessorEnumerator pEnum, 
                                           const(D3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC)* pDesc, 
                                           ID3D11VideoProcessorOutputView* ppVPOView);
    HRESULT CreateVideoProcessorEnumerator(const(D3D11_VIDEO_PROCESSOR_CONTENT_DESC)* pDesc, 
                                           ID3D11VideoProcessorEnumerator* ppEnum);
    uint    GetVideoDecoderProfileCount();
    HRESULT GetVideoDecoderProfile(uint Index, GUID* pDecoderProfile);
    HRESULT CheckVideoDecoderFormat(const(GUID)* pDecoderProfile, DXGI_FORMAT Format, int* pSupported);
    HRESULT GetVideoDecoderConfigCount(const(D3D11_VIDEO_DECODER_DESC)* pDesc, uint* pCount);
    HRESULT GetVideoDecoderConfig(const(D3D11_VIDEO_DECODER_DESC)* pDesc, uint Index, 
                                  D3D11_VIDEO_DECODER_CONFIG* pConfig);
    HRESULT GetContentProtectionCaps(const(GUID)* pCryptoType, const(GUID)* pDecoderProfile, 
                                     D3D11_VIDEO_CONTENT_PROTECTION_CAPS* pCaps);
    HRESULT CheckCryptoKeyExchange(const(GUID)* pCryptoType, const(GUID)* pDecoderProfile, uint Index, 
                                   GUID* pKeyExchangeType);
    HRESULT SetPrivateData(const(GUID)* guid, uint DataSize, char* pData);
    HRESULT SetPrivateDataInterface(const(GUID)* guid, const(IUnknown) pData);
}

@GUID("A7F026DA-A5F8-4487-A564-15E34357651E")
interface ID3D11VideoContext1 : ID3D11VideoContext
{
    HRESULT SubmitDecoderBuffers1(ID3D11VideoDecoder pDecoder, uint NumBuffers, char* pBufferDesc);
    HRESULT GetDataForNewHardwareKey(ID3D11CryptoSession pCryptoSession, uint PrivateInputSize, 
                                     char* pPrivatInputData, ulong* pPrivateOutputData);
    HRESULT CheckCryptoSessionStatus(ID3D11CryptoSession pCryptoSession, D3D11_CRYPTO_SESSION_STATUS* pStatus);
    HRESULT DecoderEnableDownsampling(ID3D11VideoDecoder pDecoder, DXGI_COLOR_SPACE_TYPE InputColorSpace, 
                                      const(D3D11_VIDEO_SAMPLE_DESC)* pOutputDesc, uint ReferenceFrameCount);
    HRESULT DecoderUpdateDownsampling(ID3D11VideoDecoder pDecoder, const(D3D11_VIDEO_SAMPLE_DESC)* pOutputDesc);
    void    VideoProcessorSetOutputColorSpace1(ID3D11VideoProcessor pVideoProcessor, 
                                               DXGI_COLOR_SPACE_TYPE ColorSpace);
    void    VideoProcessorSetOutputShaderUsage(ID3D11VideoProcessor pVideoProcessor, BOOL ShaderUsage);
    void    VideoProcessorGetOutputColorSpace1(ID3D11VideoProcessor pVideoProcessor, 
                                               DXGI_COLOR_SPACE_TYPE* pColorSpace);
    void    VideoProcessorGetOutputShaderUsage(ID3D11VideoProcessor pVideoProcessor, int* pShaderUsage);
    void    VideoProcessorSetStreamColorSpace1(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                               DXGI_COLOR_SPACE_TYPE ColorSpace);
    void    VideoProcessorSetStreamMirror(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, BOOL Enable, 
                                          BOOL FlipHorizontal, BOOL FlipVertical);
    void    VideoProcessorGetStreamColorSpace1(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                               DXGI_COLOR_SPACE_TYPE* pColorSpace);
    void    VideoProcessorGetStreamMirror(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, int* pEnable, 
                                          int* pFlipHorizontal, int* pFlipVertical);
    HRESULT VideoProcessorGetBehaviorHints(ID3D11VideoProcessor pVideoProcessor, uint OutputWidth, 
                                           uint OutputHeight, DXGI_FORMAT OutputFormat, uint StreamCount, 
                                           char* pStreams, uint* pBehaviorHints);
}

@GUID("29DA1D51-1321-4454-804B-F5FC9F861F0F")
interface ID3D11VideoDevice1 : ID3D11VideoDevice
{
    HRESULT GetCryptoSessionPrivateDataSize(const(GUID)* pCryptoType, const(GUID)* pDecoderProfile, 
                                            const(GUID)* pKeyExchangeType, uint* pPrivateInputSize, 
                                            uint* pPrivateOutputSize);
    HRESULT GetVideoDecoderCaps(const(GUID)* pDecoderProfile, uint SampleWidth, uint SampleHeight, 
                                const(DXGI_RATIONAL)* pFrameRate, uint BitRate, const(GUID)* pCryptoType, 
                                uint* pDecoderCaps);
    HRESULT CheckVideoDecoderDownsampling(const(D3D11_VIDEO_DECODER_DESC)* pInputDesc, 
                                          DXGI_COLOR_SPACE_TYPE InputColorSpace, 
                                          const(D3D11_VIDEO_DECODER_CONFIG)* pInputConfig, 
                                          const(DXGI_RATIONAL)* pFrameRate, 
                                          const(D3D11_VIDEO_SAMPLE_DESC)* pOutputDesc, int* pSupported, 
                                          int* pRealTimeHint);
    HRESULT RecommendVideoDecoderDownsampleParameters(const(D3D11_VIDEO_DECODER_DESC)* pInputDesc, 
                                                      DXGI_COLOR_SPACE_TYPE InputColorSpace, 
                                                      const(D3D11_VIDEO_DECODER_CONFIG)* pInputConfig, 
                                                      const(DXGI_RATIONAL)* pFrameRate, 
                                                      D3D11_VIDEO_SAMPLE_DESC* pRecommendedOutputDesc);
}

@GUID("465217F2-5568-43CF-B5B9-F61D54531CA1")
interface ID3D11VideoProcessorEnumerator1 : ID3D11VideoProcessorEnumerator
{
    HRESULT CheckVideoProcessorFormatConversion(DXGI_FORMAT InputFormat, DXGI_COLOR_SPACE_TYPE InputColorSpace, 
                                                DXGI_FORMAT OutputFormat, DXGI_COLOR_SPACE_TYPE OutputColorSpace, 
                                                int* pSupported);
}

@GUID("C4E7374C-6243-4D1B-AE87-52B4F740E261")
interface ID3D11VideoContext2 : ID3D11VideoContext1
{
    void VideoProcessorSetOutputHDRMetaData(ID3D11VideoProcessor pVideoProcessor, DXGI_HDR_METADATA_TYPE Type, 
                                            uint Size, char* pHDRMetaData);
    void VideoProcessorGetOutputHDRMetaData(ID3D11VideoProcessor pVideoProcessor, DXGI_HDR_METADATA_TYPE* pType, 
                                            uint Size, char* pMetaData);
    void VideoProcessorSetStreamHDRMetaData(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                            DXGI_HDR_METADATA_TYPE Type, uint Size, char* pHDRMetaData);
    void VideoProcessorGetStreamHDRMetaData(ID3D11VideoProcessor pVideoProcessor, uint StreamIndex, 
                                            DXGI_HDR_METADATA_TYPE* pType, uint Size, char* pMetaData);
}

@GUID("187AEB13-AAF5-4C59-876D-E059088C0DF8")
interface IDirect3D9ExOverlayExtension : IUnknown
{
    HRESULT CheckDeviceOverlayType(uint Adapter, D3DDEVTYPE DevType, uint OverlayWidth, uint OverlayHeight, 
                                   D3DFORMAT OverlayFormat, D3DDISPLAYMODEEX* pDisplayMode, 
                                   D3DDISPLAYROTATION DisplayRotation, D3DOVERLAYCAPS* pOverlayCaps);
}

@GUID("26DC4561-A1EE-4AE7-96DA-118A36C0EC95")
interface IDirect3DDevice9Video : IUnknown
{
    HRESULT GetContentProtectionCaps(const(GUID)* pCryptoType, const(GUID)* pDecodeProfile, 
                                     D3DCONTENTPROTECTIONCAPS* pCaps);
    HRESULT CreateAuthenticatedChannel(D3DAUTHENTICATEDCHANNELTYPE ChannelType, 
                                       IDirect3DAuthenticatedChannel9* ppAuthenticatedChannel, 
                                       HANDLE* pChannelHandle);
    HRESULT CreateCryptoSession(const(GUID)* pCryptoType, const(GUID)* pDecodeProfile, 
                                IDirect3DCryptoSession9* ppCryptoSession, HANDLE* pCryptoHandle);
}

@GUID("FF24BEEE-DA21-4BEB-98B5-D2F899F98AF9")
interface IDirect3DAuthenticatedChannel9 : IUnknown
{
    HRESULT GetCertificateSize(uint* pCertificateSize);
    HRESULT GetCertificate(uint CertifacteSize, ubyte* ppCertificate);
    HRESULT NegotiateKeyExchange(uint DataSize, void* pData);
    HRESULT Query(uint InputSize, const(void)* pInput, uint OutputSize, void* pOutput);
    HRESULT Configure(uint InputSize, const(void)* pInput, D3DAUTHENTICATEDCHANNEL_CONFIGURE_OUTPUT* pOutput);
}

@GUID("FA0AB799-7A9C-48CA-8C5B-237E71A54434")
interface IDirect3DCryptoSession9 : IUnknown
{
    HRESULT GetCertificateSize(uint* pCertificateSize);
    HRESULT GetCertificate(uint CertifacteSize, ubyte* ppCertificate);
    HRESULT NegotiateKeyExchange(uint DataSize, void* pData);
    HRESULT EncryptionBlt(IDirect3DSurface9 pSrcSurface, IDirect3DSurface9 pDstSurface, uint DstSurfaceSize, 
                          void* pIV);
    HRESULT DecryptionBlt(IDirect3DSurface9 pSrcSurface, IDirect3DSurface9 pDstSurface, uint SrcSurfaceSize, 
                          D3DENCRYPTED_BLOCK_INFO* pEncryptedBlockInfo, void* pContentKey, void* pIV);
    HRESULT GetSurfacePitch(IDirect3DSurface9 pSrcSurface, uint* pSurfacePitch);
    HRESULT StartSessionKeyRefresh(void* pRandomNumber, uint RandomNumberSize);
    HRESULT FinishSessionKeyRefresh();
    HRESULT GetEncryptionBltKey(void* pReadbackKey, uint KeySize);
}


// GUIDs

const GUID CLSID_AACMFTEncoder                = GUIDOF!AACMFTEncoder;
const GUID CLSID_ALawCodecWrapper             = GUIDOF!ALawCodecWrapper;
const GUID CLSID_CAC3DecMediaObject           = GUIDOF!CAC3DecMediaObject;
const GUID CLSID_CClusterDetectorDmo          = GUIDOF!CClusterDetectorDmo;
const GUID CLSID_CColorControlDmo             = GUIDOF!CColorControlDmo;
const GUID CLSID_CColorConvertDMO             = GUIDOF!CColorConvertDMO;
const GUID CLSID_CColorLegalizerDmo           = GUIDOF!CColorLegalizerDmo;
const GUID CLSID_CDTVAudDecoderDS             = GUIDOF!CDTVAudDecoderDS;
const GUID CLSID_CDTVVidDecoderDS             = GUIDOF!CDTVVidDecoderDS;
const GUID CLSID_CDVDecoderMediaObject        = GUIDOF!CDVDecoderMediaObject;
const GUID CLSID_CDVEncoderMediaObject        = GUIDOF!CDVEncoderMediaObject;
const GUID CLSID_CDeColorConvMediaObject      = GUIDOF!CDeColorConvMediaObject;
const GUID CLSID_CFrameInterpDMO              = GUIDOF!CFrameInterpDMO;
const GUID CLSID_CFrameRateConvertDmo         = GUIDOF!CFrameRateConvertDmo;
const GUID CLSID_CInterlaceMediaObject        = GUIDOF!CInterlaceMediaObject;
const GUID CLSID_CMP3DecMediaObject           = GUIDOF!CMP3DecMediaObject;
const GUID CLSID_CMPEG2AudDecoderDS           = GUIDOF!CMPEG2AudDecoderDS;
const GUID CLSID_CMPEG2AudioEncoderMFT        = GUIDOF!CMPEG2AudioEncoderMFT;
const GUID CLSID_CMPEG2EncoderAudioDS         = GUIDOF!CMPEG2EncoderAudioDS;
const GUID CLSID_CMPEG2EncoderDS              = GUIDOF!CMPEG2EncoderDS;
const GUID CLSID_CMPEG2EncoderVideoDS         = GUIDOF!CMPEG2EncoderVideoDS;
const GUID CLSID_CMPEG2VidDecoderDS           = GUIDOF!CMPEG2VidDecoderDS;
const GUID CLSID_CMPEG2VideoEncoderMFT        = GUIDOF!CMPEG2VideoEncoderMFT;
const GUID CLSID_CMPEGAACDecMediaObject       = GUIDOF!CMPEGAACDecMediaObject;
const GUID CLSID_CMSAACDecMFT                 = GUIDOF!CMSAACDecMFT;
const GUID CLSID_CMSAC3Enc                    = GUIDOF!CMSAC3Enc;
const GUID CLSID_CMSALACDecMFT                = GUIDOF!CMSALACDecMFT;
const GUID CLSID_CMSALACEncMFT                = GUIDOF!CMSALACEncMFT;
const GUID CLSID_CMSDDPlusDecMFT              = GUIDOF!CMSDDPlusDecMFT;
const GUID CLSID_CMSDolbyDigitalEncMFT        = GUIDOF!CMSDolbyDigitalEncMFT;
const GUID CLSID_CMSFLACDecMFT                = GUIDOF!CMSFLACDecMFT;
const GUID CLSID_CMSFLACEncMFT                = GUIDOF!CMSFLACEncMFT;
const GUID CLSID_CMSH263EncoderMFT            = GUIDOF!CMSH263EncoderMFT;
const GUID CLSID_CMSH264DecoderMFT            = GUIDOF!CMSH264DecoderMFT;
const GUID CLSID_CMSH264EncoderMFT            = GUIDOF!CMSH264EncoderMFT;
const GUID CLSID_CMSH264RemuxMFT              = GUIDOF!CMSH264RemuxMFT;
const GUID CLSID_CMSH265EncoderMFT            = GUIDOF!CMSH265EncoderMFT;
const GUID CLSID_CMSMPEGAudDecMFT             = GUIDOF!CMSMPEGAudDecMFT;
const GUID CLSID_CMSMPEGDecoderMFT            = GUIDOF!CMSMPEGDecoderMFT;
const GUID CLSID_CMSOpusDecMFT                = GUIDOF!CMSOpusDecMFT;
const GUID CLSID_CMSSCDecMediaObject          = GUIDOF!CMSSCDecMediaObject;
const GUID CLSID_CMSSCEncMediaObject          = GUIDOF!CMSSCEncMediaObject;
const GUID CLSID_CMSSCEncMediaObject2         = GUIDOF!CMSSCEncMediaObject2;
const GUID CLSID_CMSVPXEncoderMFT             = GUIDOF!CMSVPXEncoderMFT;
const GUID CLSID_CMSVideoDSPMFT               = GUIDOF!CMSVideoDSPMFT;
const GUID CLSID_CMpeg2DecMediaObject         = GUIDOF!CMpeg2DecMediaObject;
const GUID CLSID_CMpeg43DecMediaObject        = GUIDOF!CMpeg43DecMediaObject;
const GUID CLSID_CMpeg4DecMediaObject         = GUIDOF!CMpeg4DecMediaObject;
const GUID CLSID_CMpeg4EncMediaObject         = GUIDOF!CMpeg4EncMediaObject;
const GUID CLSID_CMpeg4sDecMFT                = GUIDOF!CMpeg4sDecMFT;
const GUID CLSID_CMpeg4sDecMediaObject        = GUIDOF!CMpeg4sDecMediaObject;
const GUID CLSID_CMpeg4sEncMediaObject        = GUIDOF!CMpeg4sEncMediaObject;
const GUID CLSID_CNokiaAACCCDecMediaObject    = GUIDOF!CNokiaAACCCDecMediaObject;
const GUID CLSID_CNokiaAACDecMediaObject      = GUIDOF!CNokiaAACDecMediaObject;
const GUID CLSID_CPK_DS_AC3Decoder            = GUIDOF!CPK_DS_AC3Decoder;
const GUID CLSID_CPK_DS_MPEG2Decoder          = GUIDOF!CPK_DS_MPEG2Decoder;
const GUID CLSID_CResamplerMediaObject        = GUIDOF!CResamplerMediaObject;
const GUID CLSID_CResizerDMO                  = GUIDOF!CResizerDMO;
const GUID CLSID_CResizerMediaObject          = GUIDOF!CResizerMediaObject;
const GUID CLSID_CShotDetectorDmo             = GUIDOF!CShotDetectorDmo;
const GUID CLSID_CSmpteTransformsDmo          = GUIDOF!CSmpteTransformsDmo;
const GUID CLSID_CThumbnailGeneratorDmo       = GUIDOF!CThumbnailGeneratorDmo;
const GUID CLSID_CTocGeneratorDmo             = GUIDOF!CTocGeneratorDmo;
const GUID CLSID_CVodafoneAACCCDecMediaObject = GUIDOF!CVodafoneAACCCDecMediaObject;
const GUID CLSID_CVodafoneAACDecMediaObject   = GUIDOF!CVodafoneAACDecMediaObject;
const GUID CLSID_CWMADecMediaObject           = GUIDOF!CWMADecMediaObject;
const GUID CLSID_CWMAEncMediaObject           = GUIDOF!CWMAEncMediaObject;
const GUID CLSID_CWMATransMediaObject         = GUIDOF!CWMATransMediaObject;
const GUID CLSID_CWMAudioAEC                  = GUIDOF!CWMAudioAEC;
const GUID CLSID_CWMAudioGFXAPO               = GUIDOF!CWMAudioGFXAPO;
const GUID CLSID_CWMAudioLFXAPO               = GUIDOF!CWMAudioLFXAPO;
const GUID CLSID_CWMAudioSpdTxDMO             = GUIDOF!CWMAudioSpdTxDMO;
const GUID CLSID_CWMSPDecMediaObject          = GUIDOF!CWMSPDecMediaObject;
const GUID CLSID_CWMSPEncMediaObject          = GUIDOF!CWMSPEncMediaObject;
const GUID CLSID_CWMSPEncMediaObject2         = GUIDOF!CWMSPEncMediaObject2;
const GUID CLSID_CWMTDecMediaObject           = GUIDOF!CWMTDecMediaObject;
const GUID CLSID_CWMTEncMediaObject           = GUIDOF!CWMTEncMediaObject;
const GUID CLSID_CWMV9EncMediaObject          = GUIDOF!CWMV9EncMediaObject;
const GUID CLSID_CWMVDecMediaObject           = GUIDOF!CWMVDecMediaObject;
const GUID CLSID_CWMVEncMediaObject2          = GUIDOF!CWMVEncMediaObject2;
const GUID CLSID_CWMVXEncMediaObject          = GUIDOF!CWMVXEncMediaObject;
const GUID CLSID_CWVC1DecMediaObject          = GUIDOF!CWVC1DecMediaObject;
const GUID CLSID_CWVC1EncMediaObject          = GUIDOF!CWVC1EncMediaObject;
const GUID CLSID_CZuneAACCCDecMediaObject     = GUIDOF!CZuneAACCCDecMediaObject;
const GUID CLSID_CZuneM4S2DecMediaObject      = GUIDOF!CZuneM4S2DecMediaObject;
const GUID CLSID_KSPROPSETID_OPMVideoOutput   = GUIDOF!KSPROPSETID_OPMVideoOutput;
const GUID CLSID_MFAMRNBByteStreamHandler     = GUIDOF!MFAMRNBByteStreamHandler;
const GUID CLSID_MFAMRNBSinkClassFactory      = GUIDOF!MFAMRNBSinkClassFactory;
const GUID CLSID_MFFLACBytestreamHandler      = GUIDOF!MFFLACBytestreamHandler;
const GUID CLSID_MFFLACSinkClassFactory       = GUIDOF!MFFLACSinkClassFactory;
const GUID CLSID_MP3ACMCodecWrapper           = GUIDOF!MP3ACMCodecWrapper;
const GUID CLSID_MSAMRNBDecoder               = GUIDOF!MSAMRNBDecoder;
const GUID CLSID_MSAMRNBEncoder               = GUIDOF!MSAMRNBEncoder;
const GUID CLSID_MULawCodecWrapper            = GUIDOF!MULawCodecWrapper;
const GUID CLSID_VorbisDecoderMFT             = GUIDOF!VorbisDecoderMFT;

const GUID IID_IAdvancedMediaCapture                            = GUIDOF!IAdvancedMediaCapture;
const GUID IID_IAdvancedMediaCaptureInitializationSettings      = GUIDOF!IAdvancedMediaCaptureInitializationSettings;
const GUID IID_IAdvancedMediaCaptureSettings                    = GUIDOF!IAdvancedMediaCaptureSettings;
const GUID IID_IAudioSourceProvider                             = GUIDOF!IAudioSourceProvider;
const GUID IID_IClusterDetector                                 = GUIDOF!IClusterDetector;
const GUID IID_ICodecAPI                                        = GUIDOF!ICodecAPI;
const GUID IID_ID3D11AuthenticatedChannel                       = GUIDOF!ID3D11AuthenticatedChannel;
const GUID IID_ID3D11CryptoSession                              = GUIDOF!ID3D11CryptoSession;
const GUID IID_ID3D11VideoContext                               = GUIDOF!ID3D11VideoContext;
const GUID IID_ID3D11VideoContext1                              = GUIDOF!ID3D11VideoContext1;
const GUID IID_ID3D11VideoContext2                              = GUIDOF!ID3D11VideoContext2;
const GUID IID_ID3D11VideoDecoder                               = GUIDOF!ID3D11VideoDecoder;
const GUID IID_ID3D11VideoDecoderOutputView                     = GUIDOF!ID3D11VideoDecoderOutputView;
const GUID IID_ID3D11VideoDevice                                = GUIDOF!ID3D11VideoDevice;
const GUID IID_ID3D11VideoDevice1                               = GUIDOF!ID3D11VideoDevice1;
const GUID IID_ID3D11VideoProcessor                             = GUIDOF!ID3D11VideoProcessor;
const GUID IID_ID3D11VideoProcessorEnumerator                   = GUIDOF!ID3D11VideoProcessorEnumerator;
const GUID IID_ID3D11VideoProcessorEnumerator1                  = GUIDOF!ID3D11VideoProcessorEnumerator1;
const GUID IID_ID3D11VideoProcessorInputView                    = GUIDOF!ID3D11VideoProcessorInputView;
const GUID IID_ID3D11VideoProcessorOutputView                   = GUIDOF!ID3D11VideoProcessorOutputView;
const GUID IID_ID3D12VideoDecodeCommandList                     = GUIDOF!ID3D12VideoDecodeCommandList;
const GUID IID_ID3D12VideoDecodeCommandList1                    = GUIDOF!ID3D12VideoDecodeCommandList1;
const GUID IID_ID3D12VideoDecodeCommandList2                    = GUIDOF!ID3D12VideoDecodeCommandList2;
const GUID IID_ID3D12VideoDecoder                               = GUIDOF!ID3D12VideoDecoder;
const GUID IID_ID3D12VideoDecoder1                              = GUIDOF!ID3D12VideoDecoder1;
const GUID IID_ID3D12VideoDecoderHeap                           = GUIDOF!ID3D12VideoDecoderHeap;
const GUID IID_ID3D12VideoDecoderHeap1                          = GUIDOF!ID3D12VideoDecoderHeap1;
const GUID IID_ID3D12VideoDevice                                = GUIDOF!ID3D12VideoDevice;
const GUID IID_ID3D12VideoDevice1                               = GUIDOF!ID3D12VideoDevice1;
const GUID IID_ID3D12VideoDevice2                               = GUIDOF!ID3D12VideoDevice2;
const GUID IID_ID3D12VideoEncodeCommandList                     = GUIDOF!ID3D12VideoEncodeCommandList;
const GUID IID_ID3D12VideoEncodeCommandList1                    = GUIDOF!ID3D12VideoEncodeCommandList1;
const GUID IID_ID3D12VideoExtensionCommand                      = GUIDOF!ID3D12VideoExtensionCommand;
const GUID IID_ID3D12VideoMotionEstimator                       = GUIDOF!ID3D12VideoMotionEstimator;
const GUID IID_ID3D12VideoMotionVectorHeap                      = GUIDOF!ID3D12VideoMotionVectorHeap;
const GUID IID_ID3D12VideoProcessCommandList                    = GUIDOF!ID3D12VideoProcessCommandList;
const GUID IID_ID3D12VideoProcessCommandList1                   = GUIDOF!ID3D12VideoProcessCommandList1;
const GUID IID_ID3D12VideoProcessCommandList2                   = GUIDOF!ID3D12VideoProcessCommandList2;
const GUID IID_ID3D12VideoProcessor                             = GUIDOF!ID3D12VideoProcessor;
const GUID IID_ID3D12VideoProcessor1                            = GUIDOF!ID3D12VideoProcessor1;
const GUID IID_IDXVAHD_Device                                   = GUIDOF!IDXVAHD_Device;
const GUID IID_IDXVAHD_VideoProcessor                           = GUIDOF!IDXVAHD_VideoProcessor;
const GUID IID_IDirect3D9ExOverlayExtension                     = GUIDOF!IDirect3D9ExOverlayExtension;
const GUID IID_IDirect3DAuthenticatedChannel9                   = GUIDOF!IDirect3DAuthenticatedChannel9;
const GUID IID_IDirect3DCryptoSession9                          = GUIDOF!IDirect3DCryptoSession9;
const GUID IID_IDirect3DDevice9Video                            = GUIDOF!IDirect3DDevice9Video;
const GUID IID_IDirect3DDeviceManager9                          = GUIDOF!IDirect3DDeviceManager9;
const GUID IID_IDirectXVideoAccelerationService                 = GUIDOF!IDirectXVideoAccelerationService;
const GUID IID_IDirectXVideoDecoder                             = GUIDOF!IDirectXVideoDecoder;
const GUID IID_IDirectXVideoDecoderService                      = GUIDOF!IDirectXVideoDecoderService;
const GUID IID_IDirectXVideoMemoryConfiguration                 = GUIDOF!IDirectXVideoMemoryConfiguration;
const GUID IID_IDirectXVideoProcessor                           = GUIDOF!IDirectXVideoProcessor;
const GUID IID_IDirectXVideoProcessorService                    = GUIDOF!IDirectXVideoProcessorService;
const GUID IID_IEVRFilterConfig                                 = GUIDOF!IEVRFilterConfig;
const GUID IID_IEVRFilterConfigEx                               = GUIDOF!IEVRFilterConfigEx;
const GUID IID_IEVRTrustedVideoPlugin                           = GUIDOF!IEVRTrustedVideoPlugin;
const GUID IID_IEVRVideoStreamControl                           = GUIDOF!IEVRVideoStreamControl;
const GUID IID_IFileClient                                      = GUIDOF!IFileClient;
const GUID IID_IFileIo                                          = GUIDOF!IFileIo;
const GUID IID_IMF2DBuffer                                      = GUIDOF!IMF2DBuffer;
const GUID IID_IMF2DBuffer2                                     = GUIDOF!IMF2DBuffer2;
const GUID IID_IMFASFContentInfo                                = GUIDOF!IMFASFContentInfo;
const GUID IID_IMFASFIndexer                                    = GUIDOF!IMFASFIndexer;
const GUID IID_IMFASFMultiplexer                                = GUIDOF!IMFASFMultiplexer;
const GUID IID_IMFASFMutualExclusion                            = GUIDOF!IMFASFMutualExclusion;
const GUID IID_IMFASFProfile                                    = GUIDOF!IMFASFProfile;
const GUID IID_IMFASFSplitter                                   = GUIDOF!IMFASFSplitter;
const GUID IID_IMFASFStreamConfig                               = GUIDOF!IMFASFStreamConfig;
const GUID IID_IMFASFStreamPrioritization                       = GUIDOF!IMFASFStreamPrioritization;
const GUID IID_IMFASFStreamSelector                             = GUIDOF!IMFASFStreamSelector;
const GUID IID_IMFActivate                                      = GUIDOF!IMFActivate;
const GUID IID_IMFAsyncCallback                                 = GUIDOF!IMFAsyncCallback;
const GUID IID_IMFAsyncCallbackLogging                          = GUIDOF!IMFAsyncCallbackLogging;
const GUID IID_IMFAsyncResult                                   = GUIDOF!IMFAsyncResult;
const GUID IID_IMFAttributes                                    = GUIDOF!IMFAttributes;
const GUID IID_IMFAudioMediaType                                = GUIDOF!IMFAudioMediaType;
const GUID IID_IMFAudioPolicy                                   = GUIDOF!IMFAudioPolicy;
const GUID IID_IMFAudioStreamVolume                             = GUIDOF!IMFAudioStreamVolume;
const GUID IID_IMFBufferListNotify                              = GUIDOF!IMFBufferListNotify;
const GUID IID_IMFByteStream                                    = GUIDOF!IMFByteStream;
const GUID IID_IMFByteStreamBuffering                           = GUIDOF!IMFByteStreamBuffering;
const GUID IID_IMFByteStreamCacheControl                        = GUIDOF!IMFByteStreamCacheControl;
const GUID IID_IMFByteStreamCacheControl2                       = GUIDOF!IMFByteStreamCacheControl2;
const GUID IID_IMFByteStreamHandler                             = GUIDOF!IMFByteStreamHandler;
const GUID IID_IMFByteStreamProxyClassFactory                   = GUIDOF!IMFByteStreamProxyClassFactory;
const GUID IID_IMFByteStreamTimeSeek                            = GUIDOF!IMFByteStreamTimeSeek;
const GUID IID_IMFCaptureEngine                                 = GUIDOF!IMFCaptureEngine;
const GUID IID_IMFCaptureEngineClassFactory                     = GUIDOF!IMFCaptureEngineClassFactory;
const GUID IID_IMFCaptureEngineOnEventCallback                  = GUIDOF!IMFCaptureEngineOnEventCallback;
const GUID IID_IMFCaptureEngineOnSampleCallback                 = GUIDOF!IMFCaptureEngineOnSampleCallback;
const GUID IID_IMFCaptureEngineOnSampleCallback2                = GUIDOF!IMFCaptureEngineOnSampleCallback2;
const GUID IID_IMFCapturePhotoConfirmation                      = GUIDOF!IMFCapturePhotoConfirmation;
const GUID IID_IMFCapturePhotoSink                              = GUIDOF!IMFCapturePhotoSink;
const GUID IID_IMFCapturePreviewSink                            = GUIDOF!IMFCapturePreviewSink;
const GUID IID_IMFCaptureRecordSink                             = GUIDOF!IMFCaptureRecordSink;
const GUID IID_IMFCaptureSink                                   = GUIDOF!IMFCaptureSink;
const GUID IID_IMFCaptureSink2                                  = GUIDOF!IMFCaptureSink2;
const GUID IID_IMFCaptureSource                                 = GUIDOF!IMFCaptureSource;
const GUID IID_IMFCdmSuspendNotify                              = GUIDOF!IMFCdmSuspendNotify;
const GUID IID_IMFClock                                         = GUIDOF!IMFClock;
const GUID IID_IMFClockConsumer                                 = GUIDOF!IMFClockConsumer;
const GUID IID_IMFClockStateSink                                = GUIDOF!IMFClockStateSink;
const GUID IID_IMFCollection                                    = GUIDOF!IMFCollection;
const GUID IID_IMFContentDecryptionModule                       = GUIDOF!IMFContentDecryptionModule;
const GUID IID_IMFContentDecryptionModuleAccess                 = GUIDOF!IMFContentDecryptionModuleAccess;
const GUID IID_IMFContentDecryptionModuleFactory                = GUIDOF!IMFContentDecryptionModuleFactory;
const GUID IID_IMFContentDecryptionModuleSession                = GUIDOF!IMFContentDecryptionModuleSession;
const GUID IID_IMFContentDecryptionModuleSessionCallbacks       = GUIDOF!IMFContentDecryptionModuleSessionCallbacks;
const GUID IID_IMFContentDecryptorContext                       = GUIDOF!IMFContentDecryptorContext;
const GUID IID_IMFContentEnabler                                = GUIDOF!IMFContentEnabler;
const GUID IID_IMFContentProtectionDevice                       = GUIDOF!IMFContentProtectionDevice;
const GUID IID_IMFContentProtectionManager                      = GUIDOF!IMFContentProtectionManager;
const GUID IID_IMFDLNASinkInit                                  = GUIDOF!IMFDLNASinkInit;
const GUID IID_IMFDRMNetHelper                                  = GUIDOF!IMFDRMNetHelper;
const GUID IID_IMFDXGIBuffer                                    = GUIDOF!IMFDXGIBuffer;
const GUID IID_IMFDXGIDeviceManager                             = GUIDOF!IMFDXGIDeviceManager;
const GUID IID_IMFDXGIDeviceManagerSource                       = GUIDOF!IMFDXGIDeviceManagerSource;
const GUID IID_IMFDesiredSample                                 = GUIDOF!IMFDesiredSample;
const GUID IID_IMFExtendedCameraControl                         = GUIDOF!IMFExtendedCameraControl;
const GUID IID_IMFExtendedCameraController                      = GUIDOF!IMFExtendedCameraController;
const GUID IID_IMFExtendedCameraIntrinsicModel                  = GUIDOF!IMFExtendedCameraIntrinsicModel;
const GUID IID_IMFExtendedCameraIntrinsics                      = GUIDOF!IMFExtendedCameraIntrinsics;
const GUID IID_IMFExtendedCameraIntrinsicsDistortionModel6KT    = GUIDOF!IMFExtendedCameraIntrinsicsDistortionModel6KT;
const GUID IID_IMFExtendedCameraIntrinsicsDistortionModelArcTan = GUIDOF!IMFExtendedCameraIntrinsicsDistortionModelArcTan;
const GUID IID_IMFExtendedDRMTypeSupport                        = GUIDOF!IMFExtendedDRMTypeSupport;
const GUID IID_IMFFieldOfUseMFTUnlock                           = GUIDOF!IMFFieldOfUseMFTUnlock;
const GUID IID_IMFFinalizableMediaSink                          = GUIDOF!IMFFinalizableMediaSink;
const GUID IID_IMFGetService                                    = GUIDOF!IMFGetService;
const GUID IID_IMFHDCPStatus                                    = GUIDOF!IMFHDCPStatus;
const GUID IID_IMFHttpDownloadRequest                           = GUIDOF!IMFHttpDownloadRequest;
const GUID IID_IMFHttpDownloadSession                           = GUIDOF!IMFHttpDownloadSession;
const GUID IID_IMFHttpDownloadSessionProvider                   = GUIDOF!IMFHttpDownloadSessionProvider;
const GUID IID_IMFImageSharingEngine                            = GUIDOF!IMFImageSharingEngine;
const GUID IID_IMFImageSharingEngineClassFactory                = GUIDOF!IMFImageSharingEngineClassFactory;
const GUID IID_IMFInputTrustAuthority                           = GUIDOF!IMFInputTrustAuthority;
const GUID IID_IMFLocalMFTRegistration                          = GUIDOF!IMFLocalMFTRegistration;
const GUID IID_IMFMediaBuffer                                   = GUIDOF!IMFMediaBuffer;
const GUID IID_IMFMediaEngine                                   = GUIDOF!IMFMediaEngine;
const GUID IID_IMFMediaEngineAudioEndpointId                    = GUIDOF!IMFMediaEngineAudioEndpointId;
const GUID IID_IMFMediaEngineClassFactory                       = GUIDOF!IMFMediaEngineClassFactory;
const GUID IID_IMFMediaEngineClassFactory2                      = GUIDOF!IMFMediaEngineClassFactory2;
const GUID IID_IMFMediaEngineClassFactory3                      = GUIDOF!IMFMediaEngineClassFactory3;
const GUID IID_IMFMediaEngineClassFactory4                      = GUIDOF!IMFMediaEngineClassFactory4;
const GUID IID_IMFMediaEngineClassFactoryEx                     = GUIDOF!IMFMediaEngineClassFactoryEx;
const GUID IID_IMFMediaEngineEME                                = GUIDOF!IMFMediaEngineEME;
const GUID IID_IMFMediaEngineEMENotify                          = GUIDOF!IMFMediaEngineEMENotify;
const GUID IID_IMFMediaEngineEx                                 = GUIDOF!IMFMediaEngineEx;
const GUID IID_IMFMediaEngineExtension                          = GUIDOF!IMFMediaEngineExtension;
const GUID IID_IMFMediaEngineNeedKeyNotify                      = GUIDOF!IMFMediaEngineNeedKeyNotify;
const GUID IID_IMFMediaEngineNotify                             = GUIDOF!IMFMediaEngineNotify;
const GUID IID_IMFMediaEngineOPMInfo                            = GUIDOF!IMFMediaEngineOPMInfo;
const GUID IID_IMFMediaEngineProtectedContent                   = GUIDOF!IMFMediaEngineProtectedContent;
const GUID IID_IMFMediaEngineSrcElements                        = GUIDOF!IMFMediaEngineSrcElements;
const GUID IID_IMFMediaEngineSrcElementsEx                      = GUIDOF!IMFMediaEngineSrcElementsEx;
const GUID IID_IMFMediaEngineSupportsSourceTransfer             = GUIDOF!IMFMediaEngineSupportsSourceTransfer;
const GUID IID_IMFMediaEngineTransferSource                     = GUIDOF!IMFMediaEngineTransferSource;
const GUID IID_IMFMediaEngineWebSupport                         = GUIDOF!IMFMediaEngineWebSupport;
const GUID IID_IMFMediaError                                    = GUIDOF!IMFMediaError;
const GUID IID_IMFMediaEvent                                    = GUIDOF!IMFMediaEvent;
const GUID IID_IMFMediaEventGenerator                           = GUIDOF!IMFMediaEventGenerator;
const GUID IID_IMFMediaEventQueue                               = GUIDOF!IMFMediaEventQueue;
const GUID IID_IMFMediaKeySession                               = GUIDOF!IMFMediaKeySession;
const GUID IID_IMFMediaKeySession2                              = GUIDOF!IMFMediaKeySession2;
const GUID IID_IMFMediaKeySessionNotify                         = GUIDOF!IMFMediaKeySessionNotify;
const GUID IID_IMFMediaKeySessionNotify2                        = GUIDOF!IMFMediaKeySessionNotify2;
const GUID IID_IMFMediaKeySystemAccess                          = GUIDOF!IMFMediaKeySystemAccess;
const GUID IID_IMFMediaKeys                                     = GUIDOF!IMFMediaKeys;
const GUID IID_IMFMediaKeys2                                    = GUIDOF!IMFMediaKeys2;
const GUID IID_IMFMediaSession                                  = GUIDOF!IMFMediaSession;
const GUID IID_IMFMediaSharingEngine                            = GUIDOF!IMFMediaSharingEngine;
const GUID IID_IMFMediaSharingEngineClassFactory                = GUIDOF!IMFMediaSharingEngineClassFactory;
const GUID IID_IMFMediaSink                                     = GUIDOF!IMFMediaSink;
const GUID IID_IMFMediaSinkPreroll                              = GUIDOF!IMFMediaSinkPreroll;
const GUID IID_IMFMediaSource                                   = GUIDOF!IMFMediaSource;
const GUID IID_IMFMediaSource2                                  = GUIDOF!IMFMediaSource2;
const GUID IID_IMFMediaSourceEx                                 = GUIDOF!IMFMediaSourceEx;
const GUID IID_IMFMediaSourceExtension                          = GUIDOF!IMFMediaSourceExtension;
const GUID IID_IMFMediaSourceExtensionLiveSeekableRange         = GUIDOF!IMFMediaSourceExtensionLiveSeekableRange;
const GUID IID_IMFMediaSourceExtensionNotify                    = GUIDOF!IMFMediaSourceExtensionNotify;
const GUID IID_IMFMediaSourcePresentationProvider               = GUIDOF!IMFMediaSourcePresentationProvider;
const GUID IID_IMFMediaSourceTopologyProvider                   = GUIDOF!IMFMediaSourceTopologyProvider;
const GUID IID_IMFMediaStream                                   = GUIDOF!IMFMediaStream;
const GUID IID_IMFMediaStream2                                  = GUIDOF!IMFMediaStream2;
const GUID IID_IMFMediaStreamSourceSampleRequest                = GUIDOF!IMFMediaStreamSourceSampleRequest;
const GUID IID_IMFMediaTimeRange                                = GUIDOF!IMFMediaTimeRange;
const GUID IID_IMFMediaType                                     = GUIDOF!IMFMediaType;
const GUID IID_IMFMediaTypeHandler                              = GUIDOF!IMFMediaTypeHandler;
const GUID IID_IMFMetadata                                      = GUIDOF!IMFMetadata;
const GUID IID_IMFMetadataProvider                              = GUIDOF!IMFMetadataProvider;
const GUID IID_IMFMuxStreamAttributesManager                    = GUIDOF!IMFMuxStreamAttributesManager;
const GUID IID_IMFMuxStreamMediaTypeManager                     = GUIDOF!IMFMuxStreamMediaTypeManager;
const GUID IID_IMFMuxStreamSampleManager                        = GUIDOF!IMFMuxStreamSampleManager;
const GUID IID_IMFNetCredential                                 = GUIDOF!IMFNetCredential;
const GUID IID_IMFNetCredentialCache                            = GUIDOF!IMFNetCredentialCache;
const GUID IID_IMFNetCredentialManager                          = GUIDOF!IMFNetCredentialManager;
const GUID IID_IMFNetCrossOriginSupport                         = GUIDOF!IMFNetCrossOriginSupport;
const GUID IID_IMFNetProxyLocator                               = GUIDOF!IMFNetProxyLocator;
const GUID IID_IMFNetProxyLocatorFactory                        = GUIDOF!IMFNetProxyLocatorFactory;
const GUID IID_IMFNetResourceFilter                             = GUIDOF!IMFNetResourceFilter;
const GUID IID_IMFNetSchemeHandlerConfig                        = GUIDOF!IMFNetSchemeHandlerConfig;
const GUID IID_IMFObjectReferenceStream                         = GUIDOF!IMFObjectReferenceStream;
const GUID IID_IMFOutputPolicy                                  = GUIDOF!IMFOutputPolicy;
const GUID IID_IMFOutputSchema                                  = GUIDOF!IMFOutputSchema;
const GUID IID_IMFOutputTrustAuthority                          = GUIDOF!IMFOutputTrustAuthority;
const GUID IID_IMFPMPClient                                     = GUIDOF!IMFPMPClient;
const GUID IID_IMFPMPClientApp                                  = GUIDOF!IMFPMPClientApp;
const GUID IID_IMFPMPHost                                       = GUIDOF!IMFPMPHost;
const GUID IID_IMFPMPHostApp                                    = GUIDOF!IMFPMPHostApp;
const GUID IID_IMFPMPServer                                     = GUIDOF!IMFPMPServer;
const GUID IID_IMFPMediaItem                                    = GUIDOF!IMFPMediaItem;
const GUID IID_IMFPMediaPlayer                                  = GUIDOF!IMFPMediaPlayer;
const GUID IID_IMFPMediaPlayerCallback                          = GUIDOF!IMFPMediaPlayerCallback;
const GUID IID_IMFPluginControl                                 = GUIDOF!IMFPluginControl;
const GUID IID_IMFPluginControl2                                = GUIDOF!IMFPluginControl2;
const GUID IID_IMFPresentationClock                             = GUIDOF!IMFPresentationClock;
const GUID IID_IMFPresentationDescriptor                        = GUIDOF!IMFPresentationDescriptor;
const GUID IID_IMFPresentationTimeSource                        = GUIDOF!IMFPresentationTimeSource;
const GUID IID_IMFProtectedEnvironmentAccess                    = GUIDOF!IMFProtectedEnvironmentAccess;
const GUID IID_IMFQualityAdvise                                 = GUIDOF!IMFQualityAdvise;
const GUID IID_IMFQualityAdvise2                                = GUIDOF!IMFQualityAdvise2;
const GUID IID_IMFQualityAdviseLimits                           = GUIDOF!IMFQualityAdviseLimits;
const GUID IID_IMFQualityManager                                = GUIDOF!IMFQualityManager;
const GUID IID_IMFRateControl                                   = GUIDOF!IMFRateControl;
const GUID IID_IMFRateSupport                                   = GUIDOF!IMFRateSupport;
const GUID IID_IMFReadWriteClassFactory                         = GUIDOF!IMFReadWriteClassFactory;
const GUID IID_IMFRealTimeClient                                = GUIDOF!IMFRealTimeClient;
const GUID IID_IMFRealTimeClientEx                              = GUIDOF!IMFRealTimeClientEx;
const GUID IID_IMFRelativePanelReport                           = GUIDOF!IMFRelativePanelReport;
const GUID IID_IMFRelativePanelWatcher                          = GUIDOF!IMFRelativePanelWatcher;
const GUID IID_IMFRemoteAsyncCallback                           = GUIDOF!IMFRemoteAsyncCallback;
const GUID IID_IMFRemoteDesktopPlugin                           = GUIDOF!IMFRemoteDesktopPlugin;
const GUID IID_IMFRemoteProxy                                   = GUIDOF!IMFRemoteProxy;
const GUID IID_IMFSAMIStyle                                     = GUIDOF!IMFSAMIStyle;
const GUID IID_IMFSSLCertificateManager                         = GUIDOF!IMFSSLCertificateManager;
const GUID IID_IMFSample                                        = GUIDOF!IMFSample;
const GUID IID_IMFSampleAllocatorControl                        = GUIDOF!IMFSampleAllocatorControl;
const GUID IID_IMFSampleGrabberSinkCallback                     = GUIDOF!IMFSampleGrabberSinkCallback;
const GUID IID_IMFSampleGrabberSinkCallback2                    = GUIDOF!IMFSampleGrabberSinkCallback2;
const GUID IID_IMFSampleOutputStream                            = GUIDOF!IMFSampleOutputStream;
const GUID IID_IMFSampleProtection                              = GUIDOF!IMFSampleProtection;
const GUID IID_IMFSaveJob                                       = GUIDOF!IMFSaveJob;
const GUID IID_IMFSchemeHandler                                 = GUIDOF!IMFSchemeHandler;
const GUID IID_IMFSecureBuffer                                  = GUIDOF!IMFSecureBuffer;
const GUID IID_IMFSecureChannel                                 = GUIDOF!IMFSecureChannel;
const GUID IID_IMFSeekInfo                                      = GUIDOF!IMFSeekInfo;
const GUID IID_IMFSensorActivitiesReport                        = GUIDOF!IMFSensorActivitiesReport;
const GUID IID_IMFSensorActivitiesReportCallback                = GUIDOF!IMFSensorActivitiesReportCallback;
const GUID IID_IMFSensorActivityMonitor                         = GUIDOF!IMFSensorActivityMonitor;
const GUID IID_IMFSensorActivityReport                          = GUIDOF!IMFSensorActivityReport;
const GUID IID_IMFSensorDevice                                  = GUIDOF!IMFSensorDevice;
const GUID IID_IMFSensorGroup                                   = GUIDOF!IMFSensorGroup;
const GUID IID_IMFSensorProcessActivity                         = GUIDOF!IMFSensorProcessActivity;
const GUID IID_IMFSensorProfile                                 = GUIDOF!IMFSensorProfile;
const GUID IID_IMFSensorProfileCollection                       = GUIDOF!IMFSensorProfileCollection;
const GUID IID_IMFSensorStream                                  = GUIDOF!IMFSensorStream;
const GUID IID_IMFSensorTransformFactory                        = GUIDOF!IMFSensorTransformFactory;
const GUID IID_IMFSequencerSource                               = GUIDOF!IMFSequencerSource;
const GUID IID_IMFSharingEngineClassFactory                     = GUIDOF!IMFSharingEngineClassFactory;
const GUID IID_IMFShutdown                                      = GUIDOF!IMFShutdown;
const GUID IID_IMFSignedLibrary                                 = GUIDOF!IMFSignedLibrary;
const GUID IID_IMFSimpleAudioVolume                             = GUIDOF!IMFSimpleAudioVolume;
const GUID IID_IMFSinkWriter                                    = GUIDOF!IMFSinkWriter;
const GUID IID_IMFSinkWriterCallback                            = GUIDOF!IMFSinkWriterCallback;
const GUID IID_IMFSinkWriterCallback2                           = GUIDOF!IMFSinkWriterCallback2;
const GUID IID_IMFSinkWriterEncoderConfig                       = GUIDOF!IMFSinkWriterEncoderConfig;
const GUID IID_IMFSinkWriterEx                                  = GUIDOF!IMFSinkWriterEx;
const GUID IID_IMFSourceBuffer                                  = GUIDOF!IMFSourceBuffer;
const GUID IID_IMFSourceBufferAppendMode                        = GUIDOF!IMFSourceBufferAppendMode;
const GUID IID_IMFSourceBufferList                              = GUIDOF!IMFSourceBufferList;
const GUID IID_IMFSourceBufferNotify                            = GUIDOF!IMFSourceBufferNotify;
const GUID IID_IMFSourceOpenMonitor                             = GUIDOF!IMFSourceOpenMonitor;
const GUID IID_IMFSourceReader                                  = GUIDOF!IMFSourceReader;
const GUID IID_IMFSourceReaderCallback                          = GUIDOF!IMFSourceReaderCallback;
const GUID IID_IMFSourceReaderCallback2                         = GUIDOF!IMFSourceReaderCallback2;
const GUID IID_IMFSourceReaderEx                                = GUIDOF!IMFSourceReaderEx;
const GUID IID_IMFSourceResolver                                = GUIDOF!IMFSourceResolver;
const GUID IID_IMFSpatialAudioObjectBuffer                      = GUIDOF!IMFSpatialAudioObjectBuffer;
const GUID IID_IMFSpatialAudioSample                            = GUIDOF!IMFSpatialAudioSample;
const GUID IID_IMFStreamDescriptor                              = GUIDOF!IMFStreamDescriptor;
const GUID IID_IMFStreamSink                                    = GUIDOF!IMFStreamSink;
const GUID IID_IMFStreamingSinkConfig                           = GUIDOF!IMFStreamingSinkConfig;
const GUID IID_IMFSystemId                                      = GUIDOF!IMFSystemId;
const GUID IID_IMFTimecodeTranslate                             = GUIDOF!IMFTimecodeTranslate;
const GUID IID_IMFTimedText                                     = GUIDOF!IMFTimedText;
const GUID IID_IMFTimedTextBinary                               = GUIDOF!IMFTimedTextBinary;
const GUID IID_IMFTimedTextCue                                  = GUIDOF!IMFTimedTextCue;
const GUID IID_IMFTimedTextCueList                              = GUIDOF!IMFTimedTextCueList;
const GUID IID_IMFTimedTextFormattedText                        = GUIDOF!IMFTimedTextFormattedText;
const GUID IID_IMFTimedTextNotify                               = GUIDOF!IMFTimedTextNotify;
const GUID IID_IMFTimedTextRegion                               = GUIDOF!IMFTimedTextRegion;
const GUID IID_IMFTimedTextStyle                                = GUIDOF!IMFTimedTextStyle;
const GUID IID_IMFTimedTextTrack                                = GUIDOF!IMFTimedTextTrack;
const GUID IID_IMFTimedTextTrackList                            = GUIDOF!IMFTimedTextTrackList;
const GUID IID_IMFTimer                                         = GUIDOF!IMFTimer;
const GUID IID_IMFTopoLoader                                    = GUIDOF!IMFTopoLoader;
const GUID IID_IMFTopology                                      = GUIDOF!IMFTopology;
const GUID IID_IMFTopologyNode                                  = GUIDOF!IMFTopologyNode;
const GUID IID_IMFTopologyNodeAttributeEditor                   = GUIDOF!IMFTopologyNodeAttributeEditor;
const GUID IID_IMFTopologyServiceLookup                         = GUIDOF!IMFTopologyServiceLookup;
const GUID IID_IMFTopologyServiceLookupClient                   = GUIDOF!IMFTopologyServiceLookupClient;
const GUID IID_IMFTrackedSample                                 = GUIDOF!IMFTrackedSample;
const GUID IID_IMFTranscodeProfile                              = GUIDOF!IMFTranscodeProfile;
const GUID IID_IMFTranscodeSinkInfoProvider                     = GUIDOF!IMFTranscodeSinkInfoProvider;
const GUID IID_IMFTransform                                     = GUIDOF!IMFTransform;
const GUID IID_IMFTrustedInput                                  = GUIDOF!IMFTrustedInput;
const GUID IID_IMFTrustedOutput                                 = GUIDOF!IMFTrustedOutput;
const GUID IID_IMFVideoCaptureSampleAllocator                   = GUIDOF!IMFVideoCaptureSampleAllocator;
const GUID IID_IMFVideoDeviceID                                 = GUIDOF!IMFVideoDeviceID;
const GUID IID_IMFVideoDisplayControl                           = GUIDOF!IMFVideoDisplayControl;
const GUID IID_IMFVideoMediaType                                = GUIDOF!IMFVideoMediaType;
const GUID IID_IMFVideoMixerBitmap                              = GUIDOF!IMFVideoMixerBitmap;
const GUID IID_IMFVideoMixerControl                             = GUIDOF!IMFVideoMixerControl;
const GUID IID_IMFVideoMixerControl2                            = GUIDOF!IMFVideoMixerControl2;
const GUID IID_IMFVideoPositionMapper                           = GUIDOF!IMFVideoPositionMapper;
const GUID IID_IMFVideoPresenter                                = GUIDOF!IMFVideoPresenter;
const GUID IID_IMFVideoProcessor                                = GUIDOF!IMFVideoProcessor;
const GUID IID_IMFVideoProcessorControl                         = GUIDOF!IMFVideoProcessorControl;
const GUID IID_IMFVideoProcessorControl2                        = GUIDOF!IMFVideoProcessorControl2;
const GUID IID_IMFVideoProcessorControl3                        = GUIDOF!IMFVideoProcessorControl3;
const GUID IID_IMFVideoRenderer                                 = GUIDOF!IMFVideoRenderer;
const GUID IID_IMFVideoRendererEffectControl                    = GUIDOF!IMFVideoRendererEffectControl;
const GUID IID_IMFVideoSampleAllocator                          = GUIDOF!IMFVideoSampleAllocator;
const GUID IID_IMFVideoSampleAllocatorCallback                  = GUIDOF!IMFVideoSampleAllocatorCallback;
const GUID IID_IMFVideoSampleAllocatorEx                        = GUIDOF!IMFVideoSampleAllocatorEx;
const GUID IID_IMFVideoSampleAllocatorNotify                    = GUIDOF!IMFVideoSampleAllocatorNotify;
const GUID IID_IMFVideoSampleAllocatorNotifyEx                  = GUIDOF!IMFVideoSampleAllocatorNotifyEx;
const GUID IID_IMFWorkQueueServices                             = GUIDOF!IMFWorkQueueServices;
const GUID IID_IMFWorkQueueServicesEx                           = GUIDOF!IMFWorkQueueServicesEx;
const GUID IID_IOPMVideoOutput                                  = GUIDOF!IOPMVideoOutput;
const GUID IID_IPlayToControl                                   = GUIDOF!IPlayToControl;
const GUID IID_IPlayToControlWithCapabilities                   = GUIDOF!IPlayToControlWithCapabilities;
const GUID IID_IPlayToSourceClassFactory                        = GUIDOF!IPlayToSourceClassFactory;
const GUID IID_IToc                                             = GUIDOF!IToc;
const GUID IID_ITocCollection                                   = GUIDOF!ITocCollection;
const GUID IID_ITocEntry                                        = GUIDOF!ITocEntry;
const GUID IID_ITocEntryList                                    = GUIDOF!ITocEntryList;
const GUID IID_ITocParser                                       = GUIDOF!ITocParser;
const GUID IID_IValidateBinding                                 = GUIDOF!IValidateBinding;
const GUID IID_IWMCodecLeakyBucket                              = GUIDOF!IWMCodecLeakyBucket;
const GUID IID_IWMCodecOutputTimestamp                          = GUIDOF!IWMCodecOutputTimestamp;
const GUID IID_IWMCodecPrivateData                              = GUIDOF!IWMCodecPrivateData;
const GUID IID_IWMCodecProps                                    = GUIDOF!IWMCodecProps;
const GUID IID_IWMCodecStrings                                  = GUIDOF!IWMCodecStrings;
const GUID IID_IWMColorConvProps                                = GUIDOF!IWMColorConvProps;
const GUID IID_IWMColorLegalizerProps                           = GUIDOF!IWMColorLegalizerProps;
const GUID IID_IWMFrameInterpProps                              = GUIDOF!IWMFrameInterpProps;
const GUID IID_IWMInterlaceProps                                = GUIDOF!IWMInterlaceProps;
const GUID IID_IWMResamplerProps                                = GUIDOF!IWMResamplerProps;
const GUID IID_IWMResizerProps                                  = GUIDOF!IWMResizerProps;
const GUID IID_IWMSampleExtensionSupport                        = GUIDOF!IWMSampleExtensionSupport;
const GUID IID_IWMValidate                                      = GUIDOF!IWMValidate;
const GUID IID_IWMVideoDecoderHurryup                           = GUIDOF!IWMVideoDecoderHurryup;
const GUID IID_IWMVideoDecoderReconBuffer                       = GUIDOF!IWMVideoDecoderReconBuffer;
const GUID IID_IWMVideoForceKeyFrame                            = GUIDOF!IWMVideoForceKeyFrame;
