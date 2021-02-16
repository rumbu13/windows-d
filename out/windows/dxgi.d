module windows.dxgi;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : POINT, RECT;
public import windows.gdi : HDC;
public import windows.kernel : LUID;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P709           = 0x00000000,
    DXGI_COLOR_SPACE_RGB_FULL_G10_NONE_P709           = 0x00000001,
    DXGI_COLOR_SPACE_RGB_STUDIO_G22_NONE_P709         = 0x00000002,
    DXGI_COLOR_SPACE_RGB_STUDIO_G22_NONE_P2020        = 0x00000003,
    DXGI_COLOR_SPACE_RESERVED                         = 0x00000004,
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_NONE_P709_X601    = 0x00000005,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P601       = 0x00000006,
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P601         = 0x00000007,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P709       = 0x00000008,
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P709         = 0x00000009,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P2020      = 0x0000000a,
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P2020        = 0x0000000b,
    DXGI_COLOR_SPACE_RGB_FULL_G2084_NONE_P2020        = 0x0000000c,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G2084_LEFT_P2020    = 0x0000000d,
    DXGI_COLOR_SPACE_RGB_STUDIO_G2084_NONE_P2020      = 0x0000000e,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_TOPLEFT_P2020   = 0x0000000f,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G2084_TOPLEFT_P2020 = 0x00000010,
    DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P2020          = 0x00000011,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_GHLG_TOPLEFT_P2020  = 0x00000012,
    DXGI_COLOR_SPACE_YCBCR_FULL_GHLG_TOPLEFT_P2020    = 0x00000013,
    DXGI_COLOR_SPACE_RGB_STUDIO_G24_NONE_P709         = 0x00000014,
    DXGI_COLOR_SPACE_RGB_STUDIO_G24_NONE_P2020        = 0x00000015,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_LEFT_P709       = 0x00000016,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_LEFT_P2020      = 0x00000017,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_TOPLEFT_P2020   = 0x00000018,
    DXGI_COLOR_SPACE_CUSTOM                           = 0xffffffff,
}
alias DXGI_COLOR_SPACE_TYPE = int;

enum : uint
{
    DXGI_FORMAT_UNKNOWN                                 = 0x00000000,
    DXGI_FORMAT_R32G32B32A32_TYPELESS                   = 0x00000001,
    DXGI_FORMAT_R32G32B32A32_FLOAT                      = 0x00000002,
    DXGI_FORMAT_R32G32B32A32_UINT                       = 0x00000003,
    DXGI_FORMAT_R32G32B32A32_SINT                       = 0x00000004,
    DXGI_FORMAT_R32G32B32_TYPELESS                      = 0x00000005,
    DXGI_FORMAT_R32G32B32_FLOAT                         = 0x00000006,
    DXGI_FORMAT_R32G32B32_UINT                          = 0x00000007,
    DXGI_FORMAT_R32G32B32_SINT                          = 0x00000008,
    DXGI_FORMAT_R16G16B16A16_TYPELESS                   = 0x00000009,
    DXGI_FORMAT_R16G16B16A16_FLOAT                      = 0x0000000a,
    DXGI_FORMAT_R16G16B16A16_UNORM                      = 0x0000000b,
    DXGI_FORMAT_R16G16B16A16_UINT                       = 0x0000000c,
    DXGI_FORMAT_R16G16B16A16_SNORM                      = 0x0000000d,
    DXGI_FORMAT_R16G16B16A16_SINT                       = 0x0000000e,
    DXGI_FORMAT_R32G32_TYPELESS                         = 0x0000000f,
    DXGI_FORMAT_R32G32_FLOAT                            = 0x00000010,
    DXGI_FORMAT_R32G32_UINT                             = 0x00000011,
    DXGI_FORMAT_R32G32_SINT                             = 0x00000012,
    DXGI_FORMAT_R32G8X24_TYPELESS                       = 0x00000013,
    DXGI_FORMAT_D32_FLOAT_S8X24_UINT                    = 0x00000014,
    DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS                = 0x00000015,
    DXGI_FORMAT_X32_TYPELESS_G8X24_UINT                 = 0x00000016,
    DXGI_FORMAT_R10G10B10A2_TYPELESS                    = 0x00000017,
    DXGI_FORMAT_R10G10B10A2_UNORM                       = 0x00000018,
    DXGI_FORMAT_R10G10B10A2_UINT                        = 0x00000019,
    DXGI_FORMAT_R11G11B10_FLOAT                         = 0x0000001a,
    DXGI_FORMAT_R8G8B8A8_TYPELESS                       = 0x0000001b,
    DXGI_FORMAT_R8G8B8A8_UNORM                          = 0x0000001c,
    DXGI_FORMAT_R8G8B8A8_UNORM_SRGB                     = 0x0000001d,
    DXGI_FORMAT_R8G8B8A8_UINT                           = 0x0000001e,
    DXGI_FORMAT_R8G8B8A8_SNORM                          = 0x0000001f,
    DXGI_FORMAT_R8G8B8A8_SINT                           = 0x00000020,
    DXGI_FORMAT_R16G16_TYPELESS                         = 0x00000021,
    DXGI_FORMAT_R16G16_FLOAT                            = 0x00000022,
    DXGI_FORMAT_R16G16_UNORM                            = 0x00000023,
    DXGI_FORMAT_R16G16_UINT                             = 0x00000024,
    DXGI_FORMAT_R16G16_SNORM                            = 0x00000025,
    DXGI_FORMAT_R16G16_SINT                             = 0x00000026,
    DXGI_FORMAT_R32_TYPELESS                            = 0x00000027,
    DXGI_FORMAT_D32_FLOAT                               = 0x00000028,
    DXGI_FORMAT_R32_FLOAT                               = 0x00000029,
    DXGI_FORMAT_R32_UINT                                = 0x0000002a,
    DXGI_FORMAT_R32_SINT                                = 0x0000002b,
    DXGI_FORMAT_R24G8_TYPELESS                          = 0x0000002c,
    DXGI_FORMAT_D24_UNORM_S8_UINT                       = 0x0000002d,
    DXGI_FORMAT_R24_UNORM_X8_TYPELESS                   = 0x0000002e,
    DXGI_FORMAT_X24_TYPELESS_G8_UINT                    = 0x0000002f,
    DXGI_FORMAT_R8G8_TYPELESS                           = 0x00000030,
    DXGI_FORMAT_R8G8_UNORM                              = 0x00000031,
    DXGI_FORMAT_R8G8_UINT                               = 0x00000032,
    DXGI_FORMAT_R8G8_SNORM                              = 0x00000033,
    DXGI_FORMAT_R8G8_SINT                               = 0x00000034,
    DXGI_FORMAT_R16_TYPELESS                            = 0x00000035,
    DXGI_FORMAT_R16_FLOAT                               = 0x00000036,
    DXGI_FORMAT_D16_UNORM                               = 0x00000037,
    DXGI_FORMAT_R16_UNORM                               = 0x00000038,
    DXGI_FORMAT_R16_UINT                                = 0x00000039,
    DXGI_FORMAT_R16_SNORM                               = 0x0000003a,
    DXGI_FORMAT_R16_SINT                                = 0x0000003b,
    DXGI_FORMAT_R8_TYPELESS                             = 0x0000003c,
    DXGI_FORMAT_R8_UNORM                                = 0x0000003d,
    DXGI_FORMAT_R8_UINT                                 = 0x0000003e,
    DXGI_FORMAT_R8_SNORM                                = 0x0000003f,
    DXGI_FORMAT_R8_SINT                                 = 0x00000040,
    DXGI_FORMAT_A8_UNORM                                = 0x00000041,
    DXGI_FORMAT_R1_UNORM                                = 0x00000042,
    DXGI_FORMAT_R9G9B9E5_SHAREDEXP                      = 0x00000043,
    DXGI_FORMAT_R8G8_B8G8_UNORM                         = 0x00000044,
    DXGI_FORMAT_G8R8_G8B8_UNORM                         = 0x00000045,
    DXGI_FORMAT_BC1_TYPELESS                            = 0x00000046,
    DXGI_FORMAT_BC1_UNORM                               = 0x00000047,
    DXGI_FORMAT_BC1_UNORM_SRGB                          = 0x00000048,
    DXGI_FORMAT_BC2_TYPELESS                            = 0x00000049,
    DXGI_FORMAT_BC2_UNORM                               = 0x0000004a,
    DXGI_FORMAT_BC2_UNORM_SRGB                          = 0x0000004b,
    DXGI_FORMAT_BC3_TYPELESS                            = 0x0000004c,
    DXGI_FORMAT_BC3_UNORM                               = 0x0000004d,
    DXGI_FORMAT_BC3_UNORM_SRGB                          = 0x0000004e,
    DXGI_FORMAT_BC4_TYPELESS                            = 0x0000004f,
    DXGI_FORMAT_BC4_UNORM                               = 0x00000050,
    DXGI_FORMAT_BC4_SNORM                               = 0x00000051,
    DXGI_FORMAT_BC5_TYPELESS                            = 0x00000052,
    DXGI_FORMAT_BC5_UNORM                               = 0x00000053,
    DXGI_FORMAT_BC5_SNORM                               = 0x00000054,
    DXGI_FORMAT_B5G6R5_UNORM                            = 0x00000055,
    DXGI_FORMAT_B5G5R5A1_UNORM                          = 0x00000056,
    DXGI_FORMAT_B8G8R8A8_UNORM                          = 0x00000057,
    DXGI_FORMAT_B8G8R8X8_UNORM                          = 0x00000058,
    DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM              = 0x00000059,
    DXGI_FORMAT_B8G8R8A8_TYPELESS                       = 0x0000005a,
    DXGI_FORMAT_B8G8R8A8_UNORM_SRGB                     = 0x0000005b,
    DXGI_FORMAT_B8G8R8X8_TYPELESS                       = 0x0000005c,
    DXGI_FORMAT_B8G8R8X8_UNORM_SRGB                     = 0x0000005d,
    DXGI_FORMAT_BC6H_TYPELESS                           = 0x0000005e,
    DXGI_FORMAT_BC6H_UF16                               = 0x0000005f,
    DXGI_FORMAT_BC6H_SF16                               = 0x00000060,
    DXGI_FORMAT_BC7_TYPELESS                            = 0x00000061,
    DXGI_FORMAT_BC7_UNORM                               = 0x00000062,
    DXGI_FORMAT_BC7_UNORM_SRGB                          = 0x00000063,
    DXGI_FORMAT_AYUV                                    = 0x00000064,
    DXGI_FORMAT_Y410                                    = 0x00000065,
    DXGI_FORMAT_Y416                                    = 0x00000066,
    DXGI_FORMAT_NV12                                    = 0x00000067,
    DXGI_FORMAT_P010                                    = 0x00000068,
    DXGI_FORMAT_P016                                    = 0x00000069,
    DXGI_FORMAT_420_OPAQUE                              = 0x0000006a,
    DXGI_FORMAT_YUY2                                    = 0x0000006b,
    DXGI_FORMAT_Y210                                    = 0x0000006c,
    DXGI_FORMAT_Y216                                    = 0x0000006d,
    DXGI_FORMAT_NV11                                    = 0x0000006e,
    DXGI_FORMAT_AI44                                    = 0x0000006f,
    DXGI_FORMAT_IA44                                    = 0x00000070,
    DXGI_FORMAT_P8                                      = 0x00000071,
    DXGI_FORMAT_A8P8                                    = 0x00000072,
    DXGI_FORMAT_B4G4R4A4_UNORM                          = 0x00000073,
    DXGI_FORMAT_P208                                    = 0x00000082,
    DXGI_FORMAT_V208                                    = 0x00000083,
    DXGI_FORMAT_V408                                    = 0x00000084,
    DXGI_FORMAT_SAMPLER_FEEDBACK_MIN_MIP_OPAQUE         = 0x000000bd,
    DXGI_FORMAT_SAMPLER_FEEDBACK_MIP_REGION_USED_OPAQUE = 0x000000be,
    DXGI_FORMAT_FORCE_UINT                              = 0xffffffff,
}
alias DXGI_FORMAT = uint;

enum : int
{
    DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED       = 0x00000000,
    DXGI_MODE_SCANLINE_ORDER_PROGRESSIVE       = 0x00000001,
    DXGI_MODE_SCANLINE_ORDER_UPPER_FIELD_FIRST = 0x00000002,
    DXGI_MODE_SCANLINE_ORDER_LOWER_FIELD_FIRST = 0x00000003,
}
alias DXGI_MODE_SCANLINE_ORDER = int;

enum : int
{
    DXGI_MODE_SCALING_UNSPECIFIED = 0x00000000,
    DXGI_MODE_SCALING_CENTERED    = 0x00000001,
    DXGI_MODE_SCALING_STRETCHED   = 0x00000002,
}
alias DXGI_MODE_SCALING = int;

enum : int
{
    DXGI_MODE_ROTATION_UNSPECIFIED = 0x00000000,
    DXGI_MODE_ROTATION_IDENTITY    = 0x00000001,
    DXGI_MODE_ROTATION_ROTATE90    = 0x00000002,
    DXGI_MODE_ROTATION_ROTATE180   = 0x00000003,
    DXGI_MODE_ROTATION_ROTATE270   = 0x00000004,
}
alias DXGI_MODE_ROTATION = int;

enum : int
{
    DXGI_RESIDENCY_FULLY_RESIDENT            = 0x00000001,
    DXGI_RESIDENCY_RESIDENT_IN_SHARED_MEMORY = 0x00000002,
    DXGI_RESIDENCY_EVICTED_TO_DISK           = 0x00000003,
}
alias DXGI_RESIDENCY = int;

enum : int
{
    DXGI_SWAP_EFFECT_DISCARD         = 0x00000000,
    DXGI_SWAP_EFFECT_SEQUENTIAL      = 0x00000001,
    DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL = 0x00000003,
    DXGI_SWAP_EFFECT_FLIP_DISCARD    = 0x00000004,
}
alias DXGI_SWAP_EFFECT = int;

enum : int
{
    DXGI_SWAP_CHAIN_FLAG_NONPREROTATED                          = 0x00000001,
    DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH                      = 0x00000002,
    DXGI_SWAP_CHAIN_FLAG_GDI_COMPATIBLE                         = 0x00000004,
    DXGI_SWAP_CHAIN_FLAG_RESTRICTED_CONTENT                     = 0x00000008,
    DXGI_SWAP_CHAIN_FLAG_RESTRICT_SHARED_RESOURCE_DRIVER        = 0x00000010,
    DXGI_SWAP_CHAIN_FLAG_DISPLAY_ONLY                           = 0x00000020,
    DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT          = 0x00000040,
    DXGI_SWAP_CHAIN_FLAG_FOREGROUND_LAYER                       = 0x00000080,
    DXGI_SWAP_CHAIN_FLAG_FULLSCREEN_VIDEO                       = 0x00000100,
    DXGI_SWAP_CHAIN_FLAG_YUV_VIDEO                              = 0x00000200,
    DXGI_SWAP_CHAIN_FLAG_HW_PROTECTED                           = 0x00000400,
    DXGI_SWAP_CHAIN_FLAG_ALLOW_TEARING                          = 0x00000800,
    DXGI_SWAP_CHAIN_FLAG_RESTRICTED_TO_ALL_HOLOGRAPHIC_DISPLAYS = 0x00001000,
}
alias DXGI_SWAP_CHAIN_FLAG = int;

enum : uint
{
    DXGI_ADAPTER_FLAG_NONE     = 0x00000000,
    DXGI_ADAPTER_FLAG_REMOTE   = 0x00000001,
    DXGI_ADAPTER_FLAG_SOFTWARE = 0x00000002,
}
alias DXGI_ADAPTER_FLAG = uint;

enum : int
{
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MONOCHROME   = 0x00000001,
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_COLOR        = 0x00000002,
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MASKED_COLOR = 0x00000004,
}
alias DXGI_OUTDUPL_POINTER_SHAPE_TYPE = int;

enum : uint
{
    DXGI_ALPHA_MODE_UNSPECIFIED   = 0x00000000,
    DXGI_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    DXGI_ALPHA_MODE_STRAIGHT      = 0x00000002,
    DXGI_ALPHA_MODE_IGNORE        = 0x00000003,
    DXGI_ALPHA_MODE_FORCE_DWORD   = 0xffffffff,
}
alias DXGI_ALPHA_MODE = uint;

enum : int
{
    DXGI_OFFER_RESOURCE_PRIORITY_LOW    = 0x00000001,
    DXGI_OFFER_RESOURCE_PRIORITY_NORMAL = 0x00000002,
    DXGI_OFFER_RESOURCE_PRIORITY_HIGH   = 0x00000003,
}
alias DXGI_OFFER_RESOURCE_PRIORITY = int;

enum : int
{
    DXGI_SCALING_STRETCH              = 0x00000000,
    DXGI_SCALING_NONE                 = 0x00000001,
    DXGI_SCALING_ASPECT_RATIO_STRETCH = 0x00000002,
}
alias DXGI_SCALING = int;

enum : int
{
    DXGI_GRAPHICS_PREEMPTION_DMA_BUFFER_BOUNDARY  = 0x00000000,
    DXGI_GRAPHICS_PREEMPTION_PRIMITIVE_BOUNDARY   = 0x00000001,
    DXGI_GRAPHICS_PREEMPTION_TRIANGLE_BOUNDARY    = 0x00000002,
    DXGI_GRAPHICS_PREEMPTION_PIXEL_BOUNDARY       = 0x00000003,
    DXGI_GRAPHICS_PREEMPTION_INSTRUCTION_BOUNDARY = 0x00000004,
}
alias DXGI_GRAPHICS_PREEMPTION_GRANULARITY = int;

enum : int
{
    DXGI_COMPUTE_PREEMPTION_DMA_BUFFER_BOUNDARY   = 0x00000000,
    DXGI_COMPUTE_PREEMPTION_DISPATCH_BOUNDARY     = 0x00000001,
    DXGI_COMPUTE_PREEMPTION_THREAD_GROUP_BOUNDARY = 0x00000002,
    DXGI_COMPUTE_PREEMPTION_THREAD_BOUNDARY       = 0x00000003,
    DXGI_COMPUTE_PREEMPTION_INSTRUCTION_BOUNDARY  = 0x00000004,
}
alias DXGI_COMPUTE_PREEMPTION_GRANULARITY = int;

enum : int
{
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_NOMINAL_RANGE = 0x00000001,
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_BT709         = 0x00000002,
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_xvYCC         = 0x00000004,
}
alias DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS = int;

enum : int
{
    DXGI_FRAME_PRESENTATION_MODE_COMPOSED            = 0x00000000,
    DXGI_FRAME_PRESENTATION_MODE_OVERLAY             = 0x00000001,
    DXGI_FRAME_PRESENTATION_MODE_NONE                = 0x00000002,
    DXGI_FRAME_PRESENTATION_MODE_COMPOSITION_FAILURE = 0x00000003,
}
alias DXGI_FRAME_PRESENTATION_MODE = int;

enum : int
{
    DXGI_OVERLAY_SUPPORT_FLAG_DIRECT  = 0x00000001,
    DXGI_OVERLAY_SUPPORT_FLAG_SCALING = 0x00000002,
}
alias DXGI_OVERLAY_SUPPORT_FLAG = int;

enum : int
{
    DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_PRESENT         = 0x00000001,
    DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_OVERLAY_PRESENT = 0x00000002,
}
alias DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG = int;

enum : int
{
    DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG_PRESENT = 0x00000001,
}
alias DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG = int;

enum : int
{
    DXGI_MEMORY_SEGMENT_GROUP_LOCAL     = 0x00000000,
    DXGI_MEMORY_SEGMENT_GROUP_NON_LOCAL = 0x00000001,
}
alias DXGI_MEMORY_SEGMENT_GROUP = int;

enum : int
{
    DXGI_OUTDUPL_COMPOSITED_UI_CAPTURE_ONLY = 0x00000001,
}
alias DXGI_OUTDUPL_FLAG = int;

enum : int
{
    DXGI_HDR_METADATA_TYPE_NONE      = 0x00000000,
    DXGI_HDR_METADATA_TYPE_HDR10     = 0x00000001,
    DXGI_HDR_METADATA_TYPE_HDR10PLUS = 0x00000002,
}
alias DXGI_HDR_METADATA_TYPE = int;

enum : int
{
    DXGI_OFFER_RESOURCE_FLAG_ALLOW_DECOMMIT = 0x00000001,
}
alias DXGI_OFFER_RESOURCE_FLAGS = int;

enum : int
{
    DXGI_RECLAIM_RESOURCE_RESULT_OK            = 0x00000000,
    DXGI_RECLAIM_RESOURCE_RESULT_DISCARDED     = 0x00000001,
    DXGI_RECLAIM_RESOURCE_RESULT_NOT_COMMITTED = 0x00000002,
}
alias DXGI_RECLAIM_RESOURCE_RESULTS = int;

enum : int
{
    DXGI_FEATURE_PRESENT_ALLOW_TEARING = 0x00000000,
}
alias DXGI_FEATURE = int;

enum : uint
{
    DXGI_ADAPTER_FLAG3_NONE                         = 0x00000000,
    DXGI_ADAPTER_FLAG3_REMOTE                       = 0x00000001,
    DXGI_ADAPTER_FLAG3_SOFTWARE                     = 0x00000002,
    DXGI_ADAPTER_FLAG3_ACG_COMPATIBLE               = 0x00000004,
    DXGI_ADAPTER_FLAG3_SUPPORT_MONITORED_FENCES     = 0x00000008,
    DXGI_ADAPTER_FLAG3_SUPPORT_NON_MONITORED_FENCES = 0x00000010,
    DXGI_ADAPTER_FLAG3_KEYED_MUTEX_CONFORMANCE      = 0x00000020,
    DXGI_ADAPTER_FLAG3_FORCE_DWORD                  = 0xffffffff,
}
alias DXGI_ADAPTER_FLAG3 = uint;

enum : int
{
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_FULLSCREEN       = 0x00000001,
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_WINDOWED         = 0x00000002,
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_CURSOR_STRETCHED = 0x00000004,
}
alias DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS = int;

enum : int
{
    DXGI_GPU_PREFERENCE_UNSPECIFIED      = 0x00000000,
    DXGI_GPU_PREFERENCE_MINIMUM_POWER    = 0x00000001,
    DXGI_GPU_PREFERENCE_HIGH_PERFORMANCE = 0x00000002,
}
alias DXGI_GPU_PREFERENCE = int;

enum : int
{
    DXGI_DEBUG_RLO_SUMMARY         = 0x00000001,
    DXGI_DEBUG_RLO_DETAIL          = 0x00000002,
    DXGI_DEBUG_RLO_IGNORE_INTERNAL = 0x00000004,
    DXGI_DEBUG_RLO_ALL             = 0x00000007,
}
alias DXGI_DEBUG_RLO_FLAGS = int;

enum : int
{
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_UNKNOWN               = 0x00000000,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_MISCELLANEOUS         = 0x00000001,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_INITIALIZATION        = 0x00000002,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_CLEANUP               = 0x00000003,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_COMPILATION           = 0x00000004,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_CREATION        = 0x00000005,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_SETTING         = 0x00000006,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_GETTING         = 0x00000007,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_RESOURCE_MANIPULATION = 0x00000008,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_EXECUTION             = 0x00000009,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_SHADER                = 0x0000000a,
}
alias DXGI_INFO_QUEUE_MESSAGE_CATEGORY = int;

enum : int
{
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_CORRUPTION = 0x00000000,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_ERROR      = 0x00000001,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_WARNING    = 0x00000002,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_INFO       = 0x00000003,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_MESSAGE    = 0x00000004,
}
alias DXGI_INFO_QUEUE_MESSAGE_SEVERITY = int;

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


struct DXGI_RATIONAL
{
    uint Numerator;
    uint Denominator;
}

struct DXGI_SAMPLE_DESC
{
    uint Count;
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

struct DXGI_FRAME_STATISTICS
{
    uint          PresentCount;
    uint          PresentRefreshCount;
    uint          SyncRefreshCount;
    LARGE_INTEGER SyncQPCTime;
    LARGE_INTEGER SyncGPUTime;
}

struct DXGI_MAPPED_RECT
{
    int    Pitch;
    ubyte* pBits;
}

struct DXGI_ADAPTER_DESC
{
    ushort[128] Description;
    uint        VendorId;
    uint        DeviceId;
    uint        SubSysId;
    uint        Revision;
    size_t      DedicatedVideoMemory;
    size_t      DedicatedSystemMemory;
    size_t      SharedSystemMemory;
    LUID        AdapterLuid;
}

struct DXGI_OUTPUT_DESC
{
    ushort[32]         DeviceName;
    RECT               DesktopCoordinates;
    BOOL               AttachedToDesktop;
    DXGI_MODE_ROTATION Rotation;
    ptrdiff_t          Monitor;
}

struct DXGI_SHARED_RESOURCE
{
    HANDLE Handle;
}

struct DXGI_SURFACE_DESC
{
    uint             Width;
    uint             Height;
    DXGI_FORMAT      Format;
    DXGI_SAMPLE_DESC SampleDesc;
}

struct DXGI_SWAP_CHAIN_DESC
{
    DXGI_MODE_DESC   BufferDesc;
    DXGI_SAMPLE_DESC SampleDesc;
    uint             BufferUsage;
    uint             BufferCount;
    HWND             OutputWindow;
    BOOL             Windowed;
    DXGI_SWAP_EFFECT SwapEffect;
    uint             Flags;
}

struct DXGI_ADAPTER_DESC1
{
    ushort[128] Description;
    uint        VendorId;
    uint        DeviceId;
    uint        SubSysId;
    uint        Revision;
    size_t      DedicatedVideoMemory;
    size_t      DedicatedSystemMemory;
    size_t      SharedSystemMemory;
    LUID        AdapterLuid;
    uint        Flags;
}

struct DXGI_DISPLAY_COLOR_SPACE
{
    float[16] PrimaryCoordinates;
    float[32] WhitePoints;
}

struct DXGI_OUTDUPL_MOVE_RECT
{
    POINT SourcePoint;
    RECT  DestinationRect;
}

struct DXGI_OUTDUPL_DESC
{
    DXGI_MODE_DESC     ModeDesc;
    DXGI_MODE_ROTATION Rotation;
    BOOL               DesktopImageInSystemMemory;
}

struct DXGI_OUTDUPL_POINTER_POSITION
{
    POINT Position;
    BOOL  Visible;
}

struct DXGI_OUTDUPL_POINTER_SHAPE_INFO
{
    uint  Type;
    uint  Width;
    uint  Height;
    uint  Pitch;
    POINT HotSpot;
}

struct DXGI_OUTDUPL_FRAME_INFO
{
    LARGE_INTEGER LastPresentTime;
    LARGE_INTEGER LastMouseUpdateTime;
    uint          AccumulatedFrames;
    BOOL          RectsCoalesced;
    BOOL          ProtectedContentMaskedOut;
    DXGI_OUTDUPL_POINTER_POSITION PointerPosition;
    uint          TotalMetadataBufferSize;
    uint          PointerShapeBufferSize;
}

struct DXGI_MODE_DESC1
{
    uint              Width;
    uint              Height;
    DXGI_RATIONAL     RefreshRate;
    DXGI_FORMAT       Format;
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    DXGI_MODE_SCALING Scaling;
    BOOL              Stereo;
}

struct DXGI_SWAP_CHAIN_DESC1
{
    uint             Width;
    uint             Height;
    DXGI_FORMAT      Format;
    BOOL             Stereo;
    DXGI_SAMPLE_DESC SampleDesc;
    uint             BufferUsage;
    uint             BufferCount;
    DXGI_SCALING     Scaling;
    DXGI_SWAP_EFFECT SwapEffect;
    DXGI_ALPHA_MODE  AlphaMode;
    uint             Flags;
}

struct DXGI_SWAP_CHAIN_FULLSCREEN_DESC
{
    DXGI_RATIONAL     RefreshRate;
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    DXGI_MODE_SCALING Scaling;
    BOOL              Windowed;
}

struct DXGI_PRESENT_PARAMETERS
{
    uint   DirtyRectsCount;
    RECT*  pDirtyRects;
    RECT*  pScrollRect;
    POINT* pScrollOffset;
}

struct DXGI_ADAPTER_DESC2
{
    ushort[128] Description;
    uint        VendorId;
    uint        DeviceId;
    uint        SubSysId;
    uint        Revision;
    size_t      DedicatedVideoMemory;
    size_t      DedicatedSystemMemory;
    size_t      SharedSystemMemory;
    LUID        AdapterLuid;
    uint        Flags;
    DXGI_GRAPHICS_PREEMPTION_GRANULARITY GraphicsPreemptionGranularity;
    DXGI_COMPUTE_PREEMPTION_GRANULARITY ComputePreemptionGranularity;
}

struct DXGI_MATRIX_3X2_F
{
    float _11;
    float _12;
    float _21;
    float _22;
    float _31;
    float _32;
}

struct DXGI_DECODE_SWAP_CHAIN_DESC
{
    uint Flags;
}

struct DXGI_FRAME_STATISTICS_MEDIA
{
    uint          PresentCount;
    uint          PresentRefreshCount;
    uint          SyncRefreshCount;
    LARGE_INTEGER SyncQPCTime;
    LARGE_INTEGER SyncGPUTime;
    DXGI_FRAME_PRESENTATION_MODE CompositionMode;
    uint          ApprovedPresentDuration;
}

struct DXGI_QUERY_VIDEO_MEMORY_INFO
{
    ulong Budget;
    ulong CurrentUsage;
    ulong AvailableForReservation;
    ulong CurrentReservation;
}

struct DXGI_HDR_METADATA_HDR10
{
    ushort[2] RedPrimary;
    ushort[2] GreenPrimary;
    ushort[2] BluePrimary;
    ushort[2] WhitePoint;
    uint      MaxMasteringLuminance;
    uint      MinMasteringLuminance;
    ushort    MaxContentLightLevel;
    ushort    MaxFrameAverageLightLevel;
}

struct DXGI_HDR_METADATA_HDR10PLUS
{
    ubyte[72] Data;
}

struct DXGI_ADAPTER_DESC3
{
    ushort[128]        Description;
    uint               VendorId;
    uint               DeviceId;
    uint               SubSysId;
    uint               Revision;
    size_t             DedicatedVideoMemory;
    size_t             DedicatedSystemMemory;
    size_t             SharedSystemMemory;
    LUID               AdapterLuid;
    DXGI_ADAPTER_FLAG3 Flags;
    DXGI_GRAPHICS_PREEMPTION_GRANULARITY GraphicsPreemptionGranularity;
    DXGI_COMPUTE_PREEMPTION_GRANULARITY ComputePreemptionGranularity;
}

struct DXGI_OUTPUT_DESC1
{
    ushort[32]         DeviceName;
    RECT               DesktopCoordinates;
    BOOL               AttachedToDesktop;
    DXGI_MODE_ROTATION Rotation;
    ptrdiff_t          Monitor;
    uint               BitsPerColor;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
    float[2]           RedPrimary;
    float[2]           GreenPrimary;
    float[2]           BluePrimary;
    float[2]           WhitePoint;
    float              MinLuminance;
    float              MaxLuminance;
    float              MaxFullFrameLuminance;
}

struct DXGI_INFO_QUEUE_MESSAGE
{
    GUID         Producer;
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category;
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity;
    int          ID;
    const(byte)* pDescription;
    size_t       DescriptionByteLength;
}

struct DXGI_INFO_QUEUE_FILTER_DESC
{
    uint NumCategories;
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY* pCategoryList;
    uint NumSeverities;
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY* pSeverityList;
    uint NumIDs;
    int* pIDList;
}

struct DXGI_INFO_QUEUE_FILTER
{
    DXGI_INFO_QUEUE_FILTER_DESC AllowList;
    DXGI_INFO_QUEUE_FILTER_DESC DenyList;
}

// Functions

@DllImport("dxgi")
HRESULT CreateDXGIFactory(const(GUID)* riid, void** ppFactory);

@DllImport("dxgi")
HRESULT CreateDXGIFactory1(const(GUID)* riid, void** ppFactory);

@DllImport("dxgi")
HRESULT CreateDXGIFactory2(uint Flags, const(GUID)* riid, void** ppFactory);

@DllImport("dxgi")
HRESULT DXGIGetDebugInterface1(uint Flags, const(GUID)* riid, void** pDebug);

@DllImport("dxgi")
HRESULT DXGIDeclareAdapterRemovalSupport();


// Interfaces

@GUID("AEC22FB8-76F3-4639-9BE0-28EB43A67A2E")
interface IDXGIObject : IUnknown
{
    HRESULT SetPrivateData(const(GUID)* Name, uint DataSize, char* pData);
    HRESULT SetPrivateDataInterface(const(GUID)* Name, const(IUnknown) pUnknown);
    HRESULT GetPrivateData(const(GUID)* Name, uint* pDataSize, char* pData);
    HRESULT GetParent(const(GUID)* riid, void** ppParent);
}

@GUID("3D3E0379-F9DE-4D58-BB6C-18D62992F1A6")
interface IDXGIDeviceSubObject : IDXGIObject
{
    HRESULT GetDevice(const(GUID)* riid, void** ppDevice);
}

@GUID("035F3AB4-482E-4E50-B41F-8A7F8BD8960B")
interface IDXGIResource : IDXGIDeviceSubObject
{
    HRESULT GetSharedHandle(HANDLE* pSharedHandle);
    HRESULT GetUsage(uint* pUsage);
    HRESULT SetEvictionPriority(uint EvictionPriority);
    HRESULT GetEvictionPriority(uint* pEvictionPriority);
}

@GUID("9D8E1289-D7B3-465F-8126-250E349AF85D")
interface IDXGIKeyedMutex : IDXGIDeviceSubObject
{
    HRESULT AcquireSync(ulong Key, uint dwMilliseconds);
    HRESULT ReleaseSync(ulong Key);
}

@GUID("CAFCB56C-6AC3-4889-BF47-9E23BBD260EC")
interface IDXGISurface : IDXGIDeviceSubObject
{
    HRESULT GetDesc(DXGI_SURFACE_DESC* pDesc);
    HRESULT Map(DXGI_MAPPED_RECT* pLockedRect, uint MapFlags);
    HRESULT Unmap();
}

@GUID("4AE63092-6327-4C1B-80AE-BFE12EA32B86")
interface IDXGISurface1 : IDXGISurface
{
    HRESULT GetDC(BOOL Discard, HDC* phdc);
    HRESULT ReleaseDC(RECT* pDirtyRect);
}

@GUID("2411E7E1-12AC-4CCF-BD14-9798E8534DC0")
interface IDXGIAdapter : IDXGIObject
{
    HRESULT EnumOutputs(uint Output, IDXGIOutput* ppOutput);
    HRESULT GetDesc(DXGI_ADAPTER_DESC* pDesc);
    HRESULT CheckInterfaceSupport(const(GUID)* InterfaceName, LARGE_INTEGER* pUMDVersion);
}

@GUID("AE02EEDB-C735-4690-8D52-5A8DC20213AA")
interface IDXGIOutput : IDXGIObject
{
    HRESULT GetDesc(DXGI_OUTPUT_DESC* pDesc);
    HRESULT GetDisplayModeList(DXGI_FORMAT EnumFormat, uint Flags, uint* pNumModes, char* pDesc);
    HRESULT FindClosestMatchingMode(const(DXGI_MODE_DESC)* pModeToMatch, DXGI_MODE_DESC* pClosestMatch, 
                                    IUnknown pConcernedDevice);
    HRESULT WaitForVBlank();
    HRESULT TakeOwnership(IUnknown pDevice, BOOL Exclusive);
    void    ReleaseOwnership();
    HRESULT GetGammaControlCapabilities(DXGI_GAMMA_CONTROL_CAPABILITIES* pGammaCaps);
    HRESULT SetGammaControl(const(DXGI_GAMMA_CONTROL)* pArray);
    HRESULT GetGammaControl(DXGI_GAMMA_CONTROL* pArray);
    HRESULT SetDisplaySurface(IDXGISurface pScanoutSurface);
    HRESULT GetDisplaySurfaceData(IDXGISurface pDestination);
    HRESULT GetFrameStatistics(DXGI_FRAME_STATISTICS* pStats);
}

@GUID("310D36A0-D2E7-4C0A-AA04-6A9D23B8886A")
interface IDXGISwapChain : IDXGIDeviceSubObject
{
    HRESULT Present(uint SyncInterval, uint Flags);
    HRESULT GetBuffer(uint Buffer, const(GUID)* riid, void** ppSurface);
    HRESULT SetFullscreenState(BOOL Fullscreen, IDXGIOutput pTarget);
    HRESULT GetFullscreenState(int* pFullscreen, IDXGIOutput* ppTarget);
    HRESULT GetDesc(DXGI_SWAP_CHAIN_DESC* pDesc);
    HRESULT ResizeBuffers(uint BufferCount, uint Width, uint Height, DXGI_FORMAT NewFormat, uint SwapChainFlags);
    HRESULT ResizeTarget(const(DXGI_MODE_DESC)* pNewTargetParameters);
    HRESULT GetContainingOutput(IDXGIOutput* ppOutput);
    HRESULT GetFrameStatistics(DXGI_FRAME_STATISTICS* pStats);
    HRESULT GetLastPresentCount(uint* pLastPresentCount);
}

@GUID("7B7166EC-21C7-44AE-B21A-C9AE321AE369")
interface IDXGIFactory : IDXGIObject
{
    HRESULT EnumAdapters(uint Adapter, IDXGIAdapter* ppAdapter);
    HRESULT MakeWindowAssociation(HWND WindowHandle, uint Flags);
    HRESULT GetWindowAssociation(HWND* pWindowHandle);
    HRESULT CreateSwapChain(IUnknown pDevice, DXGI_SWAP_CHAIN_DESC* pDesc, IDXGISwapChain* ppSwapChain);
    HRESULT CreateSoftwareAdapter(ptrdiff_t Module, IDXGIAdapter* ppAdapter);
}

@GUID("54EC77FA-1377-44E6-8C32-88FD5F44C84C")
interface IDXGIDevice : IDXGIObject
{
    HRESULT GetAdapter(IDXGIAdapter* pAdapter);
    HRESULT CreateSurface(const(DXGI_SURFACE_DESC)* pDesc, uint NumSurfaces, uint Usage, 
                          const(DXGI_SHARED_RESOURCE)* pSharedResource, IDXGISurface* ppSurface);
    HRESULT QueryResourceResidency(char* ppResources, char* pResidencyStatus, uint NumResources);
    HRESULT SetGPUThreadPriority(int Priority);
    HRESULT GetGPUThreadPriority(int* pPriority);
}

@GUID("770AAE78-F26F-4DBA-A829-253C83D1B387")
interface IDXGIFactory1 : IDXGIFactory
{
    HRESULT EnumAdapters1(uint Adapter, IDXGIAdapter1* ppAdapter);
    BOOL    IsCurrent();
}

@GUID("29038F61-3839-4626-91FD-086879011A05")
interface IDXGIAdapter1 : IDXGIAdapter
{
    HRESULT GetDesc1(DXGI_ADAPTER_DESC1* pDesc);
}

@GUID("77DB970F-6276-48BA-BA28-070143B4392C")
interface IDXGIDevice1 : IDXGIDevice
{
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
}

@GUID("EA9DBF1A-C88E-4486-854A-98AA0138F30C")
interface IDXGIDisplayControl : IUnknown
{
    BOOL IsStereoEnabled();
    void SetStereoEnabled(BOOL enabled);
}

@GUID("191CFAC3-A341-470D-B26E-A864F428319C")
interface IDXGIOutputDuplication : IDXGIObject
{
    void    GetDesc(DXGI_OUTDUPL_DESC* pDesc);
    HRESULT AcquireNextFrame(uint TimeoutInMilliseconds, DXGI_OUTDUPL_FRAME_INFO* pFrameInfo, 
                             IDXGIResource* ppDesktopResource);
    HRESULT GetFrameDirtyRects(uint DirtyRectsBufferSize, char* pDirtyRectsBuffer, 
                               uint* pDirtyRectsBufferSizeRequired);
    HRESULT GetFrameMoveRects(uint MoveRectsBufferSize, char* pMoveRectBuffer, uint* pMoveRectsBufferSizeRequired);
    HRESULT GetFramePointerShape(uint PointerShapeBufferSize, char* pPointerShapeBuffer, 
                                 uint* pPointerShapeBufferSizeRequired, 
                                 DXGI_OUTDUPL_POINTER_SHAPE_INFO* pPointerShapeInfo);
    HRESULT MapDesktopSurface(DXGI_MAPPED_RECT* pLockedRect);
    HRESULT UnMapDesktopSurface();
    HRESULT ReleaseFrame();
}

@GUID("ABA496DD-B617-4CB8-A866-BC44D7EB1FA2")
interface IDXGISurface2 : IDXGISurface1
{
    HRESULT GetResource(const(GUID)* riid, void** ppParentResource, uint* pSubresourceIndex);
}

@GUID("30961379-4609-4A41-998E-54FE567EE0C1")
interface IDXGIResource1 : IDXGIResource
{
    HRESULT CreateSubresourceSurface(uint index, IDXGISurface2* ppSurface);
    HRESULT CreateSharedHandle(const(SECURITY_ATTRIBUTES)* pAttributes, uint dwAccess, const(wchar)* lpName, 
                               HANDLE* pHandle);
}

@GUID("05008617-FBFD-4051-A790-144884B4F6A9")
interface IDXGIDevice2 : IDXGIDevice1
{
    HRESULT OfferResources(uint NumResources, char* ppResources, DXGI_OFFER_RESOURCE_PRIORITY Priority);
    HRESULT ReclaimResources(uint NumResources, char* ppResources, char* pDiscarded);
    HRESULT EnqueueSetEvent(HANDLE hEvent);
}

@GUID("790A45F7-0D42-4876-983A-0A55CFE6F4AA")
interface IDXGISwapChain1 : IDXGISwapChain
{
    HRESULT GetDesc1(DXGI_SWAP_CHAIN_DESC1* pDesc);
    HRESULT GetFullscreenDesc(DXGI_SWAP_CHAIN_FULLSCREEN_DESC* pDesc);
    HRESULT GetHwnd(HWND* pHwnd);
    HRESULT GetCoreWindow(const(GUID)* refiid, void** ppUnk);
    HRESULT Present1(uint SyncInterval, uint PresentFlags, const(DXGI_PRESENT_PARAMETERS)* pPresentParameters);
    BOOL    IsTemporaryMonoSupported();
    HRESULT GetRestrictToOutput(IDXGIOutput* ppRestrictToOutput);
    HRESULT SetBackgroundColor(const(DXGI_RGBA)* pColor);
    HRESULT GetBackgroundColor(DXGI_RGBA* pColor);
    HRESULT SetRotation(DXGI_MODE_ROTATION Rotation);
    HRESULT GetRotation(DXGI_MODE_ROTATION* pRotation);
}

@GUID("50C83A1C-E072-4C48-87B0-3630FA36A6D0")
interface IDXGIFactory2 : IDXGIFactory1
{
    BOOL    IsWindowedStereoEnabled();
    HRESULT CreateSwapChainForHwnd(IUnknown pDevice, HWND hWnd, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                   const(DXGI_SWAP_CHAIN_FULLSCREEN_DESC)* pFullscreenDesc, 
                                   IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
    HRESULT CreateSwapChainForCoreWindow(IUnknown pDevice, IUnknown pWindow, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                         IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
    HRESULT GetSharedResourceAdapterLuid(HANDLE hResource, LUID* pLuid);
    HRESULT RegisterStereoStatusWindow(HWND WindowHandle, uint wMsg, uint* pdwCookie);
    HRESULT RegisterStereoStatusEvent(HANDLE hEvent, uint* pdwCookie);
    void    UnregisterStereoStatus(uint dwCookie);
    HRESULT RegisterOcclusionStatusWindow(HWND WindowHandle, uint wMsg, uint* pdwCookie);
    HRESULT RegisterOcclusionStatusEvent(HANDLE hEvent, uint* pdwCookie);
    void    UnregisterOcclusionStatus(uint dwCookie);
    HRESULT CreateSwapChainForComposition(IUnknown pDevice, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                          IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
}

@GUID("0AA1AE0A-FA0E-4B84-8644-E05FF8E5ACB5")
interface IDXGIAdapter2 : IDXGIAdapter1
{
    HRESULT GetDesc2(DXGI_ADAPTER_DESC2* pDesc);
}

@GUID("00CDDEA8-939B-4B83-A340-A685226666CC")
interface IDXGIOutput1 : IDXGIOutput
{
    HRESULT GetDisplayModeList1(DXGI_FORMAT EnumFormat, uint Flags, uint* pNumModes, char* pDesc);
    HRESULT FindClosestMatchingMode1(const(DXGI_MODE_DESC1)* pModeToMatch, DXGI_MODE_DESC1* pClosestMatch, 
                                     IUnknown pConcernedDevice);
    HRESULT GetDisplaySurfaceData1(IDXGIResource pDestination);
    HRESULT DuplicateOutput(IUnknown pDevice, IDXGIOutputDuplication* ppOutputDuplication);
}

@GUID("6007896C-3244-4AFD-BF18-A6D3BEDA5023")
interface IDXGIDevice3 : IDXGIDevice2
{
    void Trim();
}

@GUID("A8BE2AC4-199F-4946-B331-79599FB98DE7")
interface IDXGISwapChain2 : IDXGISwapChain1
{
    HRESULT SetSourceSize(uint Width, uint Height);
    HRESULT GetSourceSize(uint* pWidth, uint* pHeight);
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
    HANDLE  GetFrameLatencyWaitableObject();
    HRESULT SetMatrixTransform(const(DXGI_MATRIX_3X2_F)* pMatrix);
    HRESULT GetMatrixTransform(DXGI_MATRIX_3X2_F* pMatrix);
}

@GUID("595E39D1-2724-4663-99B1-DA969DE28364")
interface IDXGIOutput2 : IDXGIOutput1
{
    BOOL SupportsOverlays();
}

@GUID("25483823-CD46-4C7D-86CA-47AA95B837BD")
interface IDXGIFactory3 : IDXGIFactory2
{
    uint GetCreationFlags();
}

@GUID("2633066B-4514-4C7A-8FD8-12EA98059D18")
interface IDXGIDecodeSwapChain : IUnknown
{
    HRESULT PresentBuffer(uint BufferToPresent, uint SyncInterval, uint Flags);
    HRESULT SetSourceRect(const(RECT)* pRect);
    HRESULT SetTargetRect(const(RECT)* pRect);
    HRESULT SetDestSize(uint Width, uint Height);
    HRESULT GetSourceRect(RECT* pRect);
    HRESULT GetTargetRect(RECT* pRect);
    HRESULT GetDestSize(uint* pWidth, uint* pHeight);
    HRESULT SetColorSpace(DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS ColorSpace);
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS GetColorSpace();
}

@GUID("41E7D1F2-A591-4F7B-A2E5-FA9C843E1C12")
interface IDXGIFactoryMedia : IUnknown
{
    HRESULT CreateSwapChainForCompositionSurfaceHandle(IUnknown pDevice, HANDLE hSurface, 
                                                       const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                                       IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
    HRESULT CreateDecodeSwapChainForCompositionSurfaceHandle(IUnknown pDevice, HANDLE hSurface, 
                                                             DXGI_DECODE_SWAP_CHAIN_DESC* pDesc, 
                                                             IDXGIResource pYuvDecodeBuffers, 
                                                             IDXGIOutput pRestrictToOutput, 
                                                             IDXGIDecodeSwapChain* ppSwapChain);
}

@GUID("DD95B90B-F05F-4F6A-BD65-25BFB264BD84")
interface IDXGISwapChainMedia : IUnknown
{
    HRESULT GetFrameStatisticsMedia(DXGI_FRAME_STATISTICS_MEDIA* pStats);
    HRESULT SetPresentDuration(uint Duration);
    HRESULT CheckPresentDurationSupport(uint DesiredPresentDuration, uint* pClosestSmallerPresentDuration, 
                                        uint* pClosestLargerPresentDuration);
}

@GUID("8A6BB301-7E7E-41F4-A8E0-5B32F7F99B18")
interface IDXGIOutput3 : IDXGIOutput2
{
    HRESULT CheckOverlaySupport(DXGI_FORMAT EnumFormat, IUnknown pConcernedDevice, uint* pFlags);
}

@GUID("94D99BDB-F1F8-4AB0-B236-7DA0170EDAB1")
interface IDXGISwapChain3 : IDXGISwapChain2
{
    uint    GetCurrentBackBufferIndex();
    HRESULT CheckColorSpaceSupport(DXGI_COLOR_SPACE_TYPE ColorSpace, uint* pColorSpaceSupport);
    HRESULT SetColorSpace1(DXGI_COLOR_SPACE_TYPE ColorSpace);
    HRESULT ResizeBuffers1(uint BufferCount, uint Width, uint Height, DXGI_FORMAT Format, uint SwapChainFlags, 
                           char* pCreationNodeMask, char* ppPresentQueue);
}

@GUID("DC7DCA35-2196-414D-9F53-617884032A60")
interface IDXGIOutput4 : IDXGIOutput3
{
    HRESULT CheckOverlayColorSpaceSupport(DXGI_FORMAT Format, DXGI_COLOR_SPACE_TYPE ColorSpace, 
                                          IUnknown pConcernedDevice, uint* pFlags);
}

@GUID("1BC6EA02-EF36-464F-BF0C-21CA39E5168A")
interface IDXGIFactory4 : IDXGIFactory3
{
    HRESULT EnumAdapterByLuid(LUID AdapterLuid, const(GUID)* riid, void** ppvAdapter);
    HRESULT EnumWarpAdapter(const(GUID)* riid, void** ppvAdapter);
}

@GUID("645967A4-1392-4310-A798-8053CE3E93FD")
interface IDXGIAdapter3 : IDXGIAdapter2
{
    HRESULT RegisterHardwareContentProtectionTeardownStatusEvent(HANDLE hEvent, uint* pdwCookie);
    void    UnregisterHardwareContentProtectionTeardownStatus(uint dwCookie);
    HRESULT QueryVideoMemoryInfo(uint NodeIndex, DXGI_MEMORY_SEGMENT_GROUP MemorySegmentGroup, 
                                 DXGI_QUERY_VIDEO_MEMORY_INFO* pVideoMemoryInfo);
    HRESULT SetVideoMemoryReservation(uint NodeIndex, DXGI_MEMORY_SEGMENT_GROUP MemorySegmentGroup, 
                                      ulong Reservation);
    HRESULT RegisterVideoMemoryBudgetChangeNotificationEvent(HANDLE hEvent, uint* pdwCookie);
    void    UnregisterVideoMemoryBudgetChangeNotification(uint dwCookie);
}

@GUID("80A07424-AB52-42EB-833C-0C42FD282D98")
interface IDXGIOutput5 : IDXGIOutput4
{
    HRESULT DuplicateOutput1(IUnknown pDevice, uint Flags, uint SupportedFormatsCount, char* pSupportedFormats, 
                             IDXGIOutputDuplication* ppOutputDuplication);
}

@GUID("3D585D5A-BD4A-489E-B1F4-3DBCB6452FFB")
interface IDXGISwapChain4 : IDXGISwapChain3
{
    HRESULT SetHDRMetaData(DXGI_HDR_METADATA_TYPE Type, uint Size, char* pMetaData);
}

@GUID("95B4F95F-D8DA-4CA4-9EE6-3B76D5968A10")
interface IDXGIDevice4 : IDXGIDevice3
{
    HRESULT OfferResources1(uint NumResources, char* ppResources, DXGI_OFFER_RESOURCE_PRIORITY Priority, 
                            uint Flags);
    HRESULT ReclaimResources1(uint NumResources, char* ppResources, char* pResults);
}

@GUID("7632E1F5-EE65-4DCA-87FD-84CD75F8838D")
interface IDXGIFactory5 : IDXGIFactory4
{
    HRESULT CheckFeatureSupport(DXGI_FEATURE Feature, char* pFeatureSupportData, uint FeatureSupportDataSize);
}

@GUID("3C8D99D1-4FBF-4181-A82C-AF66BF7BD24E")
interface IDXGIAdapter4 : IDXGIAdapter3
{
    HRESULT GetDesc3(DXGI_ADAPTER_DESC3* pDesc);
}

@GUID("068346E8-AAEC-4B84-ADD7-137F513F77A1")
interface IDXGIOutput6 : IDXGIOutput5
{
    HRESULT GetDesc1(DXGI_OUTPUT_DESC1* pDesc);
    HRESULT CheckHardwareCompositionSupport(uint* pFlags);
}

@GUID("C1B6694F-FF09-44A9-B03C-77900A0A1D17")
interface IDXGIFactory6 : IDXGIFactory5
{
    HRESULT EnumAdapterByGpuPreference(uint Adapter, DXGI_GPU_PREFERENCE GpuPreference, const(GUID)* riid, 
                                       void** ppvAdapter);
}

@GUID("A4966EED-76DB-44DA-84C1-EE9A7AFB20A8")
interface IDXGIFactory7 : IDXGIFactory6
{
    HRESULT RegisterAdaptersChangedEvent(HANDLE hEvent, uint* pdwCookie);
    HRESULT UnregisterAdaptersChangedEvent(uint dwCookie);
}

@GUID("D67441C7-672A-476F-9E82-CD55B44949CE")
interface IDXGIInfoQueue : IUnknown
{
    HRESULT SetMessageCountLimit(GUID Producer, ulong MessageCountLimit);
    void    ClearStoredMessages(GUID Producer);
    HRESULT GetMessageA(GUID Producer, ulong MessageIndex, char* pMessage, size_t* pMessageByteLength);
    ulong   GetNumStoredMessagesAllowedByRetrievalFilters(GUID Producer);
    ulong   GetNumStoredMessages(GUID Producer);
    ulong   GetNumMessagesDiscardedByMessageCountLimit(GUID Producer);
    ulong   GetMessageCountLimit(GUID Producer);
    ulong   GetNumMessagesAllowedByStorageFilter(GUID Producer);
    ulong   GetNumMessagesDeniedByStorageFilter(GUID Producer);
    HRESULT AddStorageFilterEntries(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    HRESULT GetStorageFilter(GUID Producer, char* pFilter, size_t* pFilterByteLength);
    void    ClearStorageFilter(GUID Producer);
    HRESULT PushEmptyStorageFilter(GUID Producer);
    HRESULT PushDenyAllStorageFilter(GUID Producer);
    HRESULT PushCopyOfStorageFilter(GUID Producer);
    HRESULT PushStorageFilter(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    void    PopStorageFilter(GUID Producer);
    uint    GetStorageFilterStackSize(GUID Producer);
    HRESULT AddRetrievalFilterEntries(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    HRESULT GetRetrievalFilter(GUID Producer, char* pFilter, size_t* pFilterByteLength);
    void    ClearRetrievalFilter(GUID Producer);
    HRESULT PushEmptyRetrievalFilter(GUID Producer);
    HRESULT PushDenyAllRetrievalFilter(GUID Producer);
    HRESULT PushCopyOfRetrievalFilter(GUID Producer);
    HRESULT PushRetrievalFilter(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    void    PopRetrievalFilter(GUID Producer);
    uint    GetRetrievalFilterStackSize(GUID Producer);
    HRESULT AddMessage(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category, 
                       DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, int ID, const(char)* pDescription);
    HRESULT AddApplicationMessage(DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, const(char)* pDescription);
    HRESULT SetBreakOnCategory(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category, BOOL bEnable);
    HRESULT SetBreakOnSeverity(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, BOOL bEnable);
    HRESULT SetBreakOnID(GUID Producer, int ID, BOOL bEnable);
    BOOL    GetBreakOnCategory(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category);
    BOOL    GetBreakOnSeverity(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity);
    BOOL    GetBreakOnID(GUID Producer, int ID);
    void    SetMuteDebugOutput(GUID Producer, BOOL bMute);
    BOOL    GetMuteDebugOutput(GUID Producer);
}

@GUID("119E7452-DE9E-40FE-8806-88F90C12B441")
interface IDXGIDebug : IUnknown
{
    HRESULT ReportLiveObjects(GUID apiid, DXGI_DEBUG_RLO_FLAGS flags);
}

@GUID("C5A05F0C-16F2-4ADF-9F4D-A8C4D58AC550")
interface IDXGIDebug1 : IDXGIDebug
{
    void EnableLeakTrackingForThread();
    void DisableLeakTrackingForThread();
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
