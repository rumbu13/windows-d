// Written in the D programming language.

module windows.win32.graphics.direct3d12;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, HWND, LUID, PSTR,
                                         PWSTR, RECT;
public import windows.win32.graphics.direct3d : D3D_CBUFFER_TYPE, D3D_FEATURE_LEVEL,
                                                D3D_INTERPOLATION_MODE, D3D_MIN_PRECISION,
                                                D3D_NAME, D3D_PARAMETER_FLAGS,
                                                D3D_PRIMITIVE, D3D_PRIMITIVE_TOPOLOGY,
                                                D3D_REGISTER_COMPONENT_TYPE,
                                                D3D_RESOURCE_RETURN_TYPE,
                                                D3D_SHADER_INPUT_TYPE,
                                                D3D_SHADER_VARIABLE_CLASS,
                                                D3D_SHADER_VARIABLE_TYPE, D3D_SRV_DIMENSION,
                                                D3D_TESSELLATOR_DOMAIN,
                                                D3D_TESSELLATOR_OUTPUT_PRIMITIVE,
                                                D3D_TESSELLATOR_PARTITIONING, ID3DBlob;
public import windows.win32.graphics.dxgi.common : DXGI_FORMAT, DXGI_SAMPLE_DESC;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_command_list_type
alias D3D12_COMMAND_LIST_TYPE = int;
enum : int
{
    D3D12_COMMAND_LIST_TYPE_DIRECT        = 0x00000000,
    D3D12_COMMAND_LIST_TYPE_BUNDLE        = 0x00000001,
    D3D12_COMMAND_LIST_TYPE_COMPUTE       = 0x00000002,
    D3D12_COMMAND_LIST_TYPE_COPY          = 0x00000003,
    D3D12_COMMAND_LIST_TYPE_VIDEO_DECODE  = 0x00000004,
    D3D12_COMMAND_LIST_TYPE_VIDEO_PROCESS = 0x00000005,
    D3D12_COMMAND_LIST_TYPE_VIDEO_ENCODE  = 0x00000006,
    D3D12_COMMAND_LIST_TYPE_NONE          = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_command_queue_flags
alias D3D12_COMMAND_QUEUE_FLAGS = int;
enum : int
{
    D3D12_COMMAND_QUEUE_FLAG_NONE                   = 0x00000000,
    D3D12_COMMAND_QUEUE_FLAG_DISABLE_GPU_TIMEOUT    = 0x00000001,
    D3D12_COMMAND_QUEUE_FLAG_ALLOW_DYNAMIC_PRIORITY = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_command_queue_priority
alias D3D12_COMMAND_QUEUE_PRIORITY = int;
enum : int
{
    D3D12_COMMAND_QUEUE_PRIORITY_NORMAL          = 0x00000000,
    D3D12_COMMAND_QUEUE_PRIORITY_HIGH            = 0x00000064,
    D3D12_COMMAND_QUEUE_PRIORITY_GLOBAL_REALTIME = 0x00002710,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_primitive_topology_type
alias D3D12_PRIMITIVE_TOPOLOGY_TYPE = int;
enum : int
{
    D3D12_PRIMITIVE_TOPOLOGY_TYPE_UNDEFINED = 0x00000000,
    D3D12_PRIMITIVE_TOPOLOGY_TYPE_POINT     = 0x00000001,
    D3D12_PRIMITIVE_TOPOLOGY_TYPE_LINE      = 0x00000002,
    D3D12_PRIMITIVE_TOPOLOGY_TYPE_TRIANGLE  = 0x00000003,
    D3D12_PRIMITIVE_TOPOLOGY_TYPE_PATCH     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_input_classification
alias D3D12_INPUT_CLASSIFICATION = int;
enum : int
{
    D3D12_INPUT_CLASSIFICATION_PER_VERTEX_DATA   = 0x00000000,
    D3D12_INPUT_CLASSIFICATION_PER_INSTANCE_DATA = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_fill_mode
alias D3D12_FILL_MODE = int;
enum : int
{
    D3D12_FILL_MODE_WIREFRAME = 0x00000002,
    D3D12_FILL_MODE_SOLID     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_cull_mode
alias D3D12_CULL_MODE = int;
enum : int
{
    D3D12_CULL_MODE_NONE  = 0x00000001,
    D3D12_CULL_MODE_FRONT = 0x00000002,
    D3D12_CULL_MODE_BACK  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_comparison_func
alias D3D12_COMPARISON_FUNC = int;
enum : int
{
    D3D12_COMPARISON_FUNC_NONE          = 0x00000000,
    D3D12_COMPARISON_FUNC_NEVER         = 0x00000001,
    D3D12_COMPARISON_FUNC_LESS          = 0x00000002,
    D3D12_COMPARISON_FUNC_EQUAL         = 0x00000003,
    D3D12_COMPARISON_FUNC_LESS_EQUAL    = 0x00000004,
    D3D12_COMPARISON_FUNC_GREATER       = 0x00000005,
    D3D12_COMPARISON_FUNC_NOT_EQUAL     = 0x00000006,
    D3D12_COMPARISON_FUNC_GREATER_EQUAL = 0x00000007,
    D3D12_COMPARISON_FUNC_ALWAYS        = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_depth_write_mask
alias D3D12_DEPTH_WRITE_MASK = int;
enum : int
{
    D3D12_DEPTH_WRITE_MASK_ZERO = 0x00000000,
    D3D12_DEPTH_WRITE_MASK_ALL  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_stencil_op
alias D3D12_STENCIL_OP = int;
enum : int
{
    D3D12_STENCIL_OP_KEEP     = 0x00000001,
    D3D12_STENCIL_OP_ZERO     = 0x00000002,
    D3D12_STENCIL_OP_REPLACE  = 0x00000003,
    D3D12_STENCIL_OP_INCR_SAT = 0x00000004,
    D3D12_STENCIL_OP_DECR_SAT = 0x00000005,
    D3D12_STENCIL_OP_INVERT   = 0x00000006,
    D3D12_STENCIL_OP_INCR     = 0x00000007,
    D3D12_STENCIL_OP_DECR     = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_blend
alias D3D12_BLEND = int;
enum : int
{
    D3D12_BLEND_ZERO             = 0x00000001,
    D3D12_BLEND_ONE              = 0x00000002,
    D3D12_BLEND_SRC_COLOR        = 0x00000003,
    D3D12_BLEND_INV_SRC_COLOR    = 0x00000004,
    D3D12_BLEND_SRC_ALPHA        = 0x00000005,
    D3D12_BLEND_INV_SRC_ALPHA    = 0x00000006,
    D3D12_BLEND_DEST_ALPHA       = 0x00000007,
    D3D12_BLEND_INV_DEST_ALPHA   = 0x00000008,
    D3D12_BLEND_DEST_COLOR       = 0x00000009,
    D3D12_BLEND_INV_DEST_COLOR   = 0x0000000a,
    D3D12_BLEND_SRC_ALPHA_SAT    = 0x0000000b,
    D3D12_BLEND_BLEND_FACTOR     = 0x0000000e,
    D3D12_BLEND_INV_BLEND_FACTOR = 0x0000000f,
    D3D12_BLEND_SRC1_COLOR       = 0x00000010,
    D3D12_BLEND_INV_SRC1_COLOR   = 0x00000011,
    D3D12_BLEND_SRC1_ALPHA       = 0x00000012,
    D3D12_BLEND_INV_SRC1_ALPHA   = 0x00000013,
    D3D12_BLEND_ALPHA_FACTOR     = 0x00000014,
    D3D12_BLEND_INV_ALPHA_FACTOR = 0x00000015,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_blend_op
alias D3D12_BLEND_OP = int;
enum : int
{
    D3D12_BLEND_OP_ADD          = 0x00000001,
    D3D12_BLEND_OP_SUBTRACT     = 0x00000002,
    D3D12_BLEND_OP_REV_SUBTRACT = 0x00000003,
    D3D12_BLEND_OP_MIN          = 0x00000004,
    D3D12_BLEND_OP_MAX          = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_color_write_enable
alias D3D12_COLOR_WRITE_ENABLE = int;
enum : int
{
    D3D12_COLOR_WRITE_ENABLE_RED   = 0x00000001,
    D3D12_COLOR_WRITE_ENABLE_GREEN = 0x00000002,
    D3D12_COLOR_WRITE_ENABLE_BLUE  = 0x00000004,
    D3D12_COLOR_WRITE_ENABLE_ALPHA = 0x00000008,
    D3D12_COLOR_WRITE_ENABLE_ALL   = 0x0000000f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_logic_op
alias D3D12_LOGIC_OP = int;
enum : int
{
    D3D12_LOGIC_OP_CLEAR         = 0x00000000,
    D3D12_LOGIC_OP_SET           = 0x00000001,
    D3D12_LOGIC_OP_COPY          = 0x00000002,
    D3D12_LOGIC_OP_COPY_INVERTED = 0x00000003,
    D3D12_LOGIC_OP_NOOP          = 0x00000004,
    D3D12_LOGIC_OP_INVERT        = 0x00000005,
    D3D12_LOGIC_OP_AND           = 0x00000006,
    D3D12_LOGIC_OP_NAND          = 0x00000007,
    D3D12_LOGIC_OP_OR            = 0x00000008,
    D3D12_LOGIC_OP_NOR           = 0x00000009,
    D3D12_LOGIC_OP_XOR           = 0x0000000a,
    D3D12_LOGIC_OP_EQUIV         = 0x0000000b,
    D3D12_LOGIC_OP_AND_REVERSE   = 0x0000000c,
    D3D12_LOGIC_OP_AND_INVERTED  = 0x0000000d,
    D3D12_LOGIC_OP_OR_REVERSE    = 0x0000000e,
    D3D12_LOGIC_OP_OR_INVERTED   = 0x0000000f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_conservative_rasterization_mode
alias D3D12_CONSERVATIVE_RASTERIZATION_MODE = int;
enum : int
{
    D3D12_CONSERVATIVE_RASTERIZATION_MODE_OFF = 0x00000000,
    D3D12_CONSERVATIVE_RASTERIZATION_MODE_ON  = 0x00000001,
}

alias D3D12_LINE_RASTERIZATION_MODE = int;
enum : int
{
    D3D12_LINE_RASTERIZATION_MODE_ALIASED              = 0x00000000,
    D3D12_LINE_RASTERIZATION_MODE_ALPHA_ANTIALIASED    = 0x00000001,
    D3D12_LINE_RASTERIZATION_MODE_QUADRILATERAL_WIDE   = 0x00000002,
    D3D12_LINE_RASTERIZATION_MODE_QUADRILATERAL_NARROW = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_index_buffer_strip_cut_value
alias D3D12_INDEX_BUFFER_STRIP_CUT_VALUE = int;
enum : int
{
    D3D12_INDEX_BUFFER_STRIP_CUT_VALUE_DISABLED   = 0x00000000,
    D3D12_INDEX_BUFFER_STRIP_CUT_VALUE_0xFFFF     = 0x00000001,
    D3D12_INDEX_BUFFER_STRIP_CUT_VALUE_0xFFFFFFFF = 0x00000002,
}

alias D3D12_STANDARD_MULTISAMPLE_QUALITY_LEVELS = int;
enum : int
{
    D3D12_STANDARD_MULTISAMPLE_PATTERN = 0xffffffff,
    D3D12_CENTER_MULTISAMPLE_PATTERN   = 0xfffffffe,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_pipeline_state_flags
alias D3D12_PIPELINE_STATE_FLAGS = int;
enum : int
{
    D3D12_PIPELINE_STATE_FLAG_NONE                           = 0x00000000,
    D3D12_PIPELINE_STATE_FLAG_TOOL_DEBUG                     = 0x00000001,
    D3D12_PIPELINE_STATE_FLAG_DYNAMIC_DEPTH_BIAS             = 0x00000004,
    D3D12_PIPELINE_STATE_FLAG_DYNAMIC_INDEX_BUFFER_STRIP_CUT = 0x00000008,
    D3D12_PIPELINE_STATE_FLAG_DISABLE_CACHED_BLOB            = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d_root_signature_version
alias D3D_ROOT_SIGNATURE_VERSION = int;
enum : int
{
    D3D_ROOT_SIGNATURE_VERSION_1   = 0x00000001,
    D3D_ROOT_SIGNATURE_VERSION_1_0 = 0x00000001,
    D3D_ROOT_SIGNATURE_VERSION_1_1 = 0x00000002,
    D3D_ROOT_SIGNATURE_VERSION_1_2 = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_pipeline_state_subobject_type
alias D3D12_PIPELINE_STATE_SUBOBJECT_TYPE = int;
enum : int
{
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_ROOT_SIGNATURE            = 0x00000000,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_VS                        = 0x00000001,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_PS                        = 0x00000002,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_DS                        = 0x00000003,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_HS                        = 0x00000004,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_GS                        = 0x00000005,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_CS                        = 0x00000006,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_STREAM_OUTPUT             = 0x00000007,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_BLEND                     = 0x00000008,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_SAMPLE_MASK               = 0x00000009,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_RASTERIZER                = 0x0000000a,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL             = 0x0000000b,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_INPUT_LAYOUT              = 0x0000000c,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_IB_STRIP_CUT_VALUE        = 0x0000000d,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_PRIMITIVE_TOPOLOGY        = 0x0000000e,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_RENDER_TARGET_FORMATS     = 0x0000000f,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL_FORMAT      = 0x00000010,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_SAMPLE_DESC               = 0x00000011,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_NODE_MASK                 = 0x00000012,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_CACHED_PSO                = 0x00000013,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_FLAGS                     = 0x00000014,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL1            = 0x00000015,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_VIEW_INSTANCING           = 0x00000016,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_AS                        = 0x00000018,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_MS                        = 0x00000019,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL2            = 0x0000001a,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_RASTERIZER1               = 0x0000001b,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_RASTERIZER2               = 0x0000001c,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_SERIALIZED_ROOT_SIGNATURE = 0x0000001d,
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_MAX_VALID                 = 0x0000001e,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_feature
alias D3D12_FEATURE = int;
enum : int
{
    D3D12_FEATURE_D3D12_OPTIONS                         = 0x00000000,
    D3D12_FEATURE_ARCHITECTURE                          = 0x00000001,
    D3D12_FEATURE_FEATURE_LEVELS                        = 0x00000002,
    D3D12_FEATURE_FORMAT_SUPPORT                        = 0x00000003,
    D3D12_FEATURE_MULTISAMPLE_QUALITY_LEVELS            = 0x00000004,
    D3D12_FEATURE_FORMAT_INFO                           = 0x00000005,
    D3D12_FEATURE_GPU_VIRTUAL_ADDRESS_SUPPORT           = 0x00000006,
    D3D12_FEATURE_SHADER_MODEL                          = 0x00000007,
    D3D12_FEATURE_D3D12_OPTIONS1                        = 0x00000008,
    D3D12_FEATURE_PROTECTED_RESOURCE_SESSION_SUPPORT    = 0x0000000a,
    D3D12_FEATURE_ROOT_SIGNATURE                        = 0x0000000c,
    D3D12_FEATURE_ARCHITECTURE1                         = 0x00000010,
    D3D12_FEATURE_D3D12_OPTIONS2                        = 0x00000012,
    D3D12_FEATURE_SHADER_CACHE                          = 0x00000013,
    D3D12_FEATURE_COMMAND_QUEUE_PRIORITY                = 0x00000014,
    D3D12_FEATURE_D3D12_OPTIONS3                        = 0x00000015,
    D3D12_FEATURE_EXISTING_HEAPS                        = 0x00000016,
    D3D12_FEATURE_D3D12_OPTIONS4                        = 0x00000017,
    D3D12_FEATURE_SERIALIZATION                         = 0x00000018,
    D3D12_FEATURE_CROSS_NODE                            = 0x00000019,
    D3D12_FEATURE_D3D12_OPTIONS5                        = 0x0000001b,
    D3D12_FEATURE_DISPLAYABLE                           = 0x0000001c,
    D3D12_FEATURE_D3D12_OPTIONS6                        = 0x0000001e,
    D3D12_FEATURE_QUERY_META_COMMAND                    = 0x0000001f,
    D3D12_FEATURE_D3D12_OPTIONS7                        = 0x00000020,
    D3D12_FEATURE_PROTECTED_RESOURCE_SESSION_TYPE_COUNT = 0x00000021,
    D3D12_FEATURE_PROTECTED_RESOURCE_SESSION_TYPES      = 0x00000022,
    D3D12_FEATURE_D3D12_OPTIONS8                        = 0x00000024,
    D3D12_FEATURE_D3D12_OPTIONS9                        = 0x00000025,
    D3D12_FEATURE_D3D12_OPTIONS10                       = 0x00000027,
    D3D12_FEATURE_D3D12_OPTIONS11                       = 0x00000028,
    D3D12_FEATURE_D3D12_OPTIONS12                       = 0x00000029,
    D3D12_FEATURE_D3D12_OPTIONS13                       = 0x0000002a,
    D3D12_FEATURE_D3D12_OPTIONS14                       = 0x0000002b,
    D3D12_FEATURE_D3D12_OPTIONS15                       = 0x0000002c,
    D3D12_FEATURE_D3D12_OPTIONS16                       = 0x0000002d,
    D3D12_FEATURE_D3D12_OPTIONS17                       = 0x0000002e,
    D3D12_FEATURE_D3D12_OPTIONS18                       = 0x0000002f,
    D3D12_FEATURE_D3D12_OPTIONS19                       = 0x00000030,
    D3D12_FEATURE_D3D12_OPTIONS20                       = 0x00000031,
    D3D12_FEATURE_PREDICATION                           = 0x00000032,
    D3D12_FEATURE_PLACED_RESOURCE_SUPPORT_INFO          = 0x00000033,
    D3D12_FEATURE_HARDWARE_COPY                         = 0x00000034,
    D3D12_FEATURE_D3D12_OPTIONS21                       = 0x00000035,
    D3D12_FEATURE_D3D12_TIGHT_ALIGNMENT                 = 0x00000036,
    D3D12_FEATURE_APPLICATION_SPECIFIC_DRIVER_STATE     = 0x00000038,
    D3D12_FEATURE_BYTECODE_BYPASS_HASH_SUPPORTED        = 0x00000039,
    D3D12_FEATURE_SHADER_CACHE_ABI_SUPPORT              = 0x0000003d,
    D3D12_FEATURE_BARRIER_LAYOUT                        = 0x00000040,
    D3D12_FEATURE_D3D12_OPTIONS22                       = 0x00000041,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shader_min_precision_support
alias D3D12_SHADER_MIN_PRECISION_SUPPORT = int;
enum : int
{
    D3D12_SHADER_MIN_PRECISION_SUPPORT_NONE   = 0x00000000,
    D3D12_SHADER_MIN_PRECISION_SUPPORT_10_BIT = 0x00000001,
    D3D12_SHADER_MIN_PRECISION_SUPPORT_16_BIT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_tiled_resources_tier
alias D3D12_TILED_RESOURCES_TIER = int;
enum : int
{
    D3D12_TILED_RESOURCES_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_TILED_RESOURCES_TIER_1             = 0x00000001,
    D3D12_TILED_RESOURCES_TIER_2             = 0x00000002,
    D3D12_TILED_RESOURCES_TIER_3             = 0x00000003,
    D3D12_TILED_RESOURCES_TIER_4             = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_binding_tier
alias D3D12_RESOURCE_BINDING_TIER = int;
enum : int
{
    D3D12_RESOURCE_BINDING_TIER_1 = 0x00000001,
    D3D12_RESOURCE_BINDING_TIER_2 = 0x00000002,
    D3D12_RESOURCE_BINDING_TIER_3 = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_conservative_rasterization_tier
alias D3D12_CONSERVATIVE_RASTERIZATION_TIER = int;
enum : int
{
    D3D12_CONSERVATIVE_RASTERIZATION_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_CONSERVATIVE_RASTERIZATION_TIER_1             = 0x00000001,
    D3D12_CONSERVATIVE_RASTERIZATION_TIER_2             = 0x00000002,
    D3D12_CONSERVATIVE_RASTERIZATION_TIER_3             = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_format_support1
alias D3D12_FORMAT_SUPPORT1 = int;
enum : int
{
    D3D12_FORMAT_SUPPORT1_NONE                        = 0x00000000,
    D3D12_FORMAT_SUPPORT1_BUFFER                      = 0x00000001,
    D3D12_FORMAT_SUPPORT1_IA_VERTEX_BUFFER            = 0x00000002,
    D3D12_FORMAT_SUPPORT1_IA_INDEX_BUFFER             = 0x00000004,
    D3D12_FORMAT_SUPPORT1_SO_BUFFER                   = 0x00000008,
    D3D12_FORMAT_SUPPORT1_TEXTURE1D                   = 0x00000010,
    D3D12_FORMAT_SUPPORT1_TEXTURE2D                   = 0x00000020,
    D3D12_FORMAT_SUPPORT1_TEXTURE3D                   = 0x00000040,
    D3D12_FORMAT_SUPPORT1_TEXTURECUBE                 = 0x00000080,
    D3D12_FORMAT_SUPPORT1_SHADER_LOAD                 = 0x00000100,
    D3D12_FORMAT_SUPPORT1_SHADER_SAMPLE               = 0x00000200,
    D3D12_FORMAT_SUPPORT1_SHADER_SAMPLE_COMPARISON    = 0x00000400,
    D3D12_FORMAT_SUPPORT1_SHADER_SAMPLE_MONO_TEXT     = 0x00000800,
    D3D12_FORMAT_SUPPORT1_MIP                         = 0x00001000,
    D3D12_FORMAT_SUPPORT1_RENDER_TARGET               = 0x00004000,
    D3D12_FORMAT_SUPPORT1_BLENDABLE                   = 0x00008000,
    D3D12_FORMAT_SUPPORT1_DEPTH_STENCIL               = 0x00010000,
    D3D12_FORMAT_SUPPORT1_MULTISAMPLE_RESOLVE         = 0x00040000,
    D3D12_FORMAT_SUPPORT1_DISPLAY                     = 0x00080000,
    D3D12_FORMAT_SUPPORT1_CAST_WITHIN_BIT_LAYOUT      = 0x00100000,
    D3D12_FORMAT_SUPPORT1_MULTISAMPLE_RENDERTARGET    = 0x00200000,
    D3D12_FORMAT_SUPPORT1_MULTISAMPLE_LOAD            = 0x00400000,
    D3D12_FORMAT_SUPPORT1_SHADER_GATHER               = 0x00800000,
    D3D12_FORMAT_SUPPORT1_BACK_BUFFER_CAST            = 0x01000000,
    D3D12_FORMAT_SUPPORT1_TYPED_UNORDERED_ACCESS_VIEW = 0x02000000,
    D3D12_FORMAT_SUPPORT1_SHADER_GATHER_COMPARISON    = 0x04000000,
    D3D12_FORMAT_SUPPORT1_DECODER_OUTPUT              = 0x08000000,
    D3D12_FORMAT_SUPPORT1_VIDEO_PROCESSOR_OUTPUT      = 0x10000000,
    D3D12_FORMAT_SUPPORT1_VIDEO_PROCESSOR_INPUT       = 0x20000000,
    D3D12_FORMAT_SUPPORT1_VIDEO_ENCODER               = 0x40000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_format_support2
alias D3D12_FORMAT_SUPPORT2 = int;
enum : int
{
    D3D12_FORMAT_SUPPORT2_NONE                                         = 0x00000000,
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_ADD                               = 0x00000001,
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_BITWISE_OPS                       = 0x00000002,
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_COMPARE_STORE_OR_COMPARE_EXCHANGE = 0x00000004,
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_EXCHANGE                          = 0x00000008,
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_SIGNED_MIN_OR_MAX                 = 0x00000010,
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_UNSIGNED_MIN_OR_MAX               = 0x00000020,
    D3D12_FORMAT_SUPPORT2_UAV_TYPED_LOAD                               = 0x00000040,
    D3D12_FORMAT_SUPPORT2_UAV_TYPED_STORE                              = 0x00000080,
    D3D12_FORMAT_SUPPORT2_OUTPUT_MERGER_LOGIC_OP                       = 0x00000100,
    D3D12_FORMAT_SUPPORT2_TILED                                        = 0x00000200,
    D3D12_FORMAT_SUPPORT2_MULTIPLANE_OVERLAY                           = 0x00004000,
    D3D12_FORMAT_SUPPORT2_SAMPLER_FEEDBACK                             = 0x00008000,
    D3D12_FORMAT_SUPPORT2_DISPLAYABLE                                  = 0x00010000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_multisample_quality_level_flags
alias D3D12_MULTISAMPLE_QUALITY_LEVEL_FLAGS = int;
enum : int
{
    D3D12_MULTISAMPLE_QUALITY_LEVELS_FLAG_NONE           = 0x00000000,
    D3D12_MULTISAMPLE_QUALITY_LEVELS_FLAG_TILED_RESOURCE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_cross_node_sharing_tier
alias D3D12_CROSS_NODE_SHARING_TIER = int;
enum : int
{
    D3D12_CROSS_NODE_SHARING_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_CROSS_NODE_SHARING_TIER_1_EMULATED    = 0x00000001,
    D3D12_CROSS_NODE_SHARING_TIER_1             = 0x00000002,
    D3D12_CROSS_NODE_SHARING_TIER_2             = 0x00000003,
    D3D12_CROSS_NODE_SHARING_TIER_3             = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_heap_tier
alias D3D12_RESOURCE_HEAP_TIER = int;
enum : int
{
    D3D12_RESOURCE_HEAP_TIER_1 = 0x00000001,
    D3D12_RESOURCE_HEAP_TIER_2 = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_programmable_sample_positions_tier
alias D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER = int;
enum : int
{
    D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER_1             = 0x00000001,
    D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER_2             = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_view_instancing_tier
alias D3D12_VIEW_INSTANCING_TIER = int;
enum : int
{
    D3D12_VIEW_INSTANCING_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_VIEW_INSTANCING_TIER_1             = 0x00000001,
    D3D12_VIEW_INSTANCING_TIER_2             = 0x00000002,
    D3D12_VIEW_INSTANCING_TIER_3             = 0x00000003,
}

alias D3D12_WORK_GRAPHS_TIER = int;
enum : int
{
    D3D12_WORK_GRAPHS_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_WORK_GRAPHS_TIER_1_0           = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d_shader_model
alias D3D_SHADER_MODEL = int;
enum : int
{
    D3D_SHADER_MODEL_NONE    = 0x00000000,
    D3D_SHADER_MODEL_5_1     = 0x00000051,
    D3D_SHADER_MODEL_6_0     = 0x00000060,
    D3D_SHADER_MODEL_6_1     = 0x00000061,
    D3D_SHADER_MODEL_6_2     = 0x00000062,
    D3D_SHADER_MODEL_6_3     = 0x00000063,
    D3D_SHADER_MODEL_6_4     = 0x00000064,
    D3D_SHADER_MODEL_6_5     = 0x00000065,
    D3D_SHADER_MODEL_6_6     = 0x00000066,
    D3D_SHADER_MODEL_6_7     = 0x00000067,
    D3D_SHADER_MODEL_6_8     = 0x00000068,
    D3D_SHADER_MODEL_6_9     = 0x00000069,
    D3D_SHADER_MODEL_6_10    = 0x0000006a,
    D3D_HIGHEST_SHADER_MODEL = 0x0000006a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shader_cache_support_flags
alias D3D12_SHADER_CACHE_SUPPORT_FLAGS = int;
enum : int
{
    D3D12_SHADER_CACHE_SUPPORT_NONE                   = 0x00000000,
    D3D12_SHADER_CACHE_SUPPORT_SINGLE_PSO             = 0x00000001,
    D3D12_SHADER_CACHE_SUPPORT_LIBRARY                = 0x00000002,
    D3D12_SHADER_CACHE_SUPPORT_AUTOMATIC_INPROC_CACHE = 0x00000004,
    D3D12_SHADER_CACHE_SUPPORT_AUTOMATIC_DISK_CACHE   = 0x00000008,
    D3D12_SHADER_CACHE_SUPPORT_DRIVER_MANAGED_CACHE   = 0x00000010,
    D3D12_SHADER_CACHE_SUPPORT_SHADER_CONTROL_CLEAR   = 0x00000020,
    D3D12_SHADER_CACHE_SUPPORT_SHADER_SESSION_DELETE  = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_command_list_support_flags
alias D3D12_COMMAND_LIST_SUPPORT_FLAGS = int;
enum : int
{
    D3D12_COMMAND_LIST_SUPPORT_FLAG_NONE          = 0x00000000,
    D3D12_COMMAND_LIST_SUPPORT_FLAG_DIRECT        = 0x00000001,
    D3D12_COMMAND_LIST_SUPPORT_FLAG_BUNDLE        = 0x00000002,
    D3D12_COMMAND_LIST_SUPPORT_FLAG_COMPUTE       = 0x00000004,
    D3D12_COMMAND_LIST_SUPPORT_FLAG_COPY          = 0x00000008,
    D3D12_COMMAND_LIST_SUPPORT_FLAG_VIDEO_DECODE  = 0x00000010,
    D3D12_COMMAND_LIST_SUPPORT_FLAG_VIDEO_PROCESS = 0x00000020,
    D3D12_COMMAND_LIST_SUPPORT_FLAG_VIDEO_ENCODE  = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shared_resource_compatibility_tier
alias D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER = int;
enum : int
{
    D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER_0 = 0x00000000,
    D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER_1 = 0x00000001,
    D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER_2 = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_heap_serialization_tier
alias D3D12_HEAP_SERIALIZATION_TIER = int;
enum : int
{
    D3D12_HEAP_SERIALIZATION_TIER_0  = 0x00000000,
    D3D12_HEAP_SERIALIZATION_TIER_10 = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_render_pass_tier
alias D3D12_RENDER_PASS_TIER = int;
enum : int
{
    D3D12_RENDER_PASS_TIER_0 = 0x00000000,
    D3D12_RENDER_PASS_TIER_1 = 0x00000001,
    D3D12_RENDER_PASS_TIER_2 = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_raytracing_tier
alias D3D12_RAYTRACING_TIER = int;
enum : int
{
    D3D12_RAYTRACING_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_RAYTRACING_TIER_1_0           = 0x0000000a,
    D3D12_RAYTRACING_TIER_1_1           = 0x0000000b,
    D3D12_RAYTRACING_TIER_1_2           = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_variable_shading_rate_tier
alias D3D12_VARIABLE_SHADING_RATE_TIER = int;
enum : int
{
    D3D12_VARIABLE_SHADING_RATE_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_VARIABLE_SHADING_RATE_TIER_1             = 0x00000001,
    D3D12_VARIABLE_SHADING_RATE_TIER_2             = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_mesh_shader_tier
alias D3D12_MESH_SHADER_TIER = int;
enum : int
{
    D3D12_MESH_SHADER_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_MESH_SHADER_TIER_1             = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_sampler_feedback_tier
alias D3D12_SAMPLER_FEEDBACK_TIER = int;
enum : int
{
    D3D12_SAMPLER_FEEDBACK_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_SAMPLER_FEEDBACK_TIER_0_9           = 0x0000005a,
    D3D12_SAMPLER_FEEDBACK_TIER_1_0           = 0x00000064,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_wave_mma_tier
alias D3D12_WAVE_MMA_TIER = int;
enum : int
{
    D3D12_WAVE_MMA_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_WAVE_MMA_TIER_1_0           = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_tri_state
alias D3D12_TRI_STATE = int;
enum : int
{
    D3D12_TRI_STATE_UNKNOWN = 0xffffffff,
    D3D12_TRI_STATE_FALSE   = 0x00000000,
    D3D12_TRI_STATE_TRUE    = 0x00000001,
}

alias D3D12_RECREATE_AT_TIER = int;
enum : int
{
    D3D12_RECREATE_AT_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_RECREATE_AT_TIER_1             = 0x00000001,
}

alias D3D12_EXECUTE_INDIRECT_TIER = int;
enum : int
{
    D3D12_EXECUTE_INDIRECT_TIER_1_0 = 0x0000000a,
    D3D12_EXECUTE_INDIRECT_TIER_1_1 = 0x0000000b,
}

alias D3D12_TIGHT_ALIGNMENT_TIER = int;
enum : int
{
    D3D12_TIGHT_ALIGNMENT_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_TIGHT_ALIGNMENT_TIER_1             = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_heap_type
alias D3D12_HEAP_TYPE = int;
enum : int
{
    D3D12_HEAP_TYPE_DEFAULT    = 0x00000001,
    D3D12_HEAP_TYPE_UPLOAD     = 0x00000002,
    D3D12_HEAP_TYPE_READBACK   = 0x00000003,
    D3D12_HEAP_TYPE_CUSTOM     = 0x00000004,
    D3D12_HEAP_TYPE_GPU_UPLOAD = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_cpu_page_property
alias D3D12_CPU_PAGE_PROPERTY = int;
enum : int
{
    D3D12_CPU_PAGE_PROPERTY_UNKNOWN       = 0x00000000,
    D3D12_CPU_PAGE_PROPERTY_NOT_AVAILABLE = 0x00000001,
    D3D12_CPU_PAGE_PROPERTY_WRITE_COMBINE = 0x00000002,
    D3D12_CPU_PAGE_PROPERTY_WRITE_BACK    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_memory_pool
alias D3D12_MEMORY_POOL = int;
enum : int
{
    D3D12_MEMORY_POOL_UNKNOWN = 0x00000000,
    D3D12_MEMORY_POOL_L0      = 0x00000001,
    D3D12_MEMORY_POOL_L1      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_heap_flags
alias D3D12_HEAP_FLAGS = int;
enum : int
{
    D3D12_HEAP_FLAG_NONE                            = 0x00000000,
    D3D12_HEAP_FLAG_SHARED                          = 0x00000001,
    D3D12_HEAP_FLAG_DENY_BUFFERS                    = 0x00000004,
    D3D12_HEAP_FLAG_ALLOW_DISPLAY                   = 0x00000008,
    D3D12_HEAP_FLAG_SHARED_CROSS_ADAPTER            = 0x00000020,
    D3D12_HEAP_FLAG_DENY_RT_DS_TEXTURES             = 0x00000040,
    D3D12_HEAP_FLAG_DENY_NON_RT_DS_TEXTURES         = 0x00000080,
    D3D12_HEAP_FLAG_HARDWARE_PROTECTED              = 0x00000100,
    D3D12_HEAP_FLAG_ALLOW_WRITE_WATCH               = 0x00000200,
    D3D12_HEAP_FLAG_ALLOW_SHADER_ATOMICS            = 0x00000400,
    D3D12_HEAP_FLAG_CREATE_NOT_RESIDENT             = 0x00000800,
    D3D12_HEAP_FLAG_CREATE_NOT_ZEROED               = 0x00001000,
    D3D12_HEAP_FLAG_TOOLS_USE_MANUAL_WRITE_TRACKING = 0x00002000,
    D3D12_HEAP_FLAG_ALLOW_ALL_BUFFERS_AND_TEXTURES  = 0x00000000,
    D3D12_HEAP_FLAG_ALLOW_ONLY_BUFFERS              = 0x000000c0,
    D3D12_HEAP_FLAG_ALLOW_ONLY_NON_RT_DS_TEXTURES   = 0x00000044,
    D3D12_HEAP_FLAG_ALLOW_ONLY_RT_DS_TEXTURES       = 0x00000084,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_dimension
alias D3D12_RESOURCE_DIMENSION = int;
enum : int
{
    D3D12_RESOURCE_DIMENSION_UNKNOWN   = 0x00000000,
    D3D12_RESOURCE_DIMENSION_BUFFER    = 0x00000001,
    D3D12_RESOURCE_DIMENSION_TEXTURE1D = 0x00000002,
    D3D12_RESOURCE_DIMENSION_TEXTURE2D = 0x00000003,
    D3D12_RESOURCE_DIMENSION_TEXTURE3D = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_texture_layout
alias D3D12_TEXTURE_LAYOUT = int;
enum : int
{
    D3D12_TEXTURE_LAYOUT_UNKNOWN                = 0x00000000,
    D3D12_TEXTURE_LAYOUT_ROW_MAJOR              = 0x00000001,
    D3D12_TEXTURE_LAYOUT_64KB_UNDEFINED_SWIZZLE = 0x00000002,
    D3D12_TEXTURE_LAYOUT_64KB_STANDARD_SWIZZLE  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_flags
alias D3D12_RESOURCE_FLAGS = int;
enum : int
{
    D3D12_RESOURCE_FLAG_NONE                              = 0x00000000,
    D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET               = 0x00000001,
    D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL               = 0x00000002,
    D3D12_RESOURCE_FLAG_ALLOW_UNORDERED_ACCESS            = 0x00000004,
    D3D12_RESOURCE_FLAG_DENY_SHADER_RESOURCE              = 0x00000008,
    D3D12_RESOURCE_FLAG_ALLOW_CROSS_ADAPTER               = 0x00000010,
    D3D12_RESOURCE_FLAG_ALLOW_SIMULTANEOUS_ACCESS         = 0x00000020,
    D3D12_RESOURCE_FLAG_VIDEO_DECODE_REFERENCE_ONLY       = 0x00000040,
    D3D12_RESOURCE_FLAG_VIDEO_ENCODE_REFERENCE_ONLY       = 0x00000080,
    D3D12_RESOURCE_FLAG_RAYTRACING_ACCELERATION_STRUCTURE = 0x00000100,
    D3D12_RESOURCE_FLAG_USE_TIGHT_ALIGNMENT               = 0x00000400,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_tile_range_flags
alias D3D12_TILE_RANGE_FLAGS = int;
enum : int
{
    D3D12_TILE_RANGE_FLAG_NONE              = 0x00000000,
    D3D12_TILE_RANGE_FLAG_NULL              = 0x00000001,
    D3D12_TILE_RANGE_FLAG_SKIP              = 0x00000002,
    D3D12_TILE_RANGE_FLAG_REUSE_SINGLE_TILE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_tile_mapping_flags
alias D3D12_TILE_MAPPING_FLAGS = int;
enum : int
{
    D3D12_TILE_MAPPING_FLAG_NONE      = 0x00000000,
    D3D12_TILE_MAPPING_FLAG_NO_HAZARD = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_tile_copy_flags
alias D3D12_TILE_COPY_FLAGS = int;
enum : int
{
    D3D12_TILE_COPY_FLAG_NONE                                     = 0x00000000,
    D3D12_TILE_COPY_FLAG_NO_HAZARD                                = 0x00000001,
    D3D12_TILE_COPY_FLAG_LINEAR_BUFFER_TO_SWIZZLED_TILED_RESOURCE = 0x00000002,
    D3D12_TILE_COPY_FLAG_SWIZZLED_TILED_RESOURCE_TO_LINEAR_BUFFER = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_states
alias D3D12_RESOURCE_STATES = int;
enum : int
{
    D3D12_RESOURCE_STATE_COMMON                            = 0x00000000,
    D3D12_RESOURCE_STATE_VERTEX_AND_CONSTANT_BUFFER        = 0x00000001,
    D3D12_RESOURCE_STATE_INDEX_BUFFER                      = 0x00000002,
    D3D12_RESOURCE_STATE_RENDER_TARGET                     = 0x00000004,
    D3D12_RESOURCE_STATE_UNORDERED_ACCESS                  = 0x00000008,
    D3D12_RESOURCE_STATE_DEPTH_WRITE                       = 0x00000010,
    D3D12_RESOURCE_STATE_DEPTH_READ                        = 0x00000020,
    D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE         = 0x00000040,
    D3D12_RESOURCE_STATE_PIXEL_SHADER_RESOURCE             = 0x00000080,
    D3D12_RESOURCE_STATE_STREAM_OUT                        = 0x00000100,
    D3D12_RESOURCE_STATE_INDIRECT_ARGUMENT                 = 0x00000200,
    D3D12_RESOURCE_STATE_COPY_DEST                         = 0x00000400,
    D3D12_RESOURCE_STATE_COPY_SOURCE                       = 0x00000800,
    D3D12_RESOURCE_STATE_RESOLVE_DEST                      = 0x00001000,
    D3D12_RESOURCE_STATE_RESOLVE_SOURCE                    = 0x00002000,
    D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE = 0x00400000,
    D3D12_RESOURCE_STATE_SHADING_RATE_SOURCE               = 0x01000000,
    D3D12_RESOURCE_STATE_RESERVED_INTERNAL_8000            = 0x00008000,
    D3D12_RESOURCE_STATE_RESERVED_INTERNAL_4000            = 0x00004000,
    D3D12_RESOURCE_STATE_RESERVED_INTERNAL_100000          = 0x00100000,
    D3D12_RESOURCE_STATE_RESERVED_INTERNAL_40000000        = 0x40000000,
    D3D12_RESOURCE_STATE_RESERVED_INTERNAL_80000000        = 0x80000000,
    D3D12_RESOURCE_STATE_GENERIC_READ                      = 0x00000ac3,
    D3D12_RESOURCE_STATE_ALL_SHADER_RESOURCE               = 0x000000c0,
    D3D12_RESOURCE_STATE_PRESENT                           = 0x00000000,
    D3D12_RESOURCE_STATE_PREDICATION                       = 0x00000200,
    D3D12_RESOURCE_STATE_VIDEO_DECODE_READ                 = 0x00010000,
    D3D12_RESOURCE_STATE_VIDEO_DECODE_WRITE                = 0x00020000,
    D3D12_RESOURCE_STATE_VIDEO_PROCESS_READ                = 0x00040000,
    D3D12_RESOURCE_STATE_VIDEO_PROCESS_WRITE               = 0x00080000,
    D3D12_RESOURCE_STATE_VIDEO_ENCODE_READ                 = 0x00200000,
    D3D12_RESOURCE_STATE_VIDEO_ENCODE_WRITE                = 0x00800000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_barrier_type
alias D3D12_RESOURCE_BARRIER_TYPE = int;
enum : int
{
    D3D12_RESOURCE_BARRIER_TYPE_TRANSITION = 0x00000000,
    D3D12_RESOURCE_BARRIER_TYPE_ALIASING   = 0x00000001,
    D3D12_RESOURCE_BARRIER_TYPE_UAV        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_barrier_flags
alias D3D12_RESOURCE_BARRIER_FLAGS = int;
enum : int
{
    D3D12_RESOURCE_BARRIER_FLAG_NONE       = 0x00000000,
    D3D12_RESOURCE_BARRIER_FLAG_BEGIN_ONLY = 0x00000001,
    D3D12_RESOURCE_BARRIER_FLAG_END_ONLY   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_texture_copy_type
alias D3D12_TEXTURE_COPY_TYPE = int;
enum : int
{
    D3D12_TEXTURE_COPY_TYPE_SUBRESOURCE_INDEX = 0x00000000,
    D3D12_TEXTURE_COPY_TYPE_PLACED_FOOTPRINT  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_resolve_mode
alias D3D12_RESOLVE_MODE = int;
enum : int
{
    D3D12_RESOLVE_MODE_DECOMPRESS              = 0x00000000,
    D3D12_RESOLVE_MODE_MIN                     = 0x00000001,
    D3D12_RESOLVE_MODE_MAX                     = 0x00000002,
    D3D12_RESOLVE_MODE_AVERAGE                 = 0x00000003,
    D3D12_RESOLVE_MODE_ENCODE_SAMPLER_FEEDBACK = 0x00000004,
    D3D12_RESOLVE_MODE_DECODE_SAMPLER_FEEDBACK = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_view_instancing_flags
alias D3D12_VIEW_INSTANCING_FLAGS = int;
enum : int
{
    D3D12_VIEW_INSTANCING_FLAG_NONE                         = 0x00000000,
    D3D12_VIEW_INSTANCING_FLAG_ENABLE_VIEW_INSTANCE_MASKING = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shader_component_mapping
alias D3D12_SHADER_COMPONENT_MAPPING = int;
enum : int
{
    D3D12_SHADER_COMPONENT_MAPPING_FROM_MEMORY_COMPONENT_0 = 0x00000000,
    D3D12_SHADER_COMPONENT_MAPPING_FROM_MEMORY_COMPONENT_1 = 0x00000001,
    D3D12_SHADER_COMPONENT_MAPPING_FROM_MEMORY_COMPONENT_2 = 0x00000002,
    D3D12_SHADER_COMPONENT_MAPPING_FROM_MEMORY_COMPONENT_3 = 0x00000003,
    D3D12_SHADER_COMPONENT_MAPPING_FORCE_VALUE_0           = 0x00000004,
    D3D12_SHADER_COMPONENT_MAPPING_FORCE_VALUE_1           = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_buffer_srv_flags
alias D3D12_BUFFER_SRV_FLAGS = int;
enum : int
{
    D3D12_BUFFER_SRV_FLAG_NONE = 0x00000000,
    D3D12_BUFFER_SRV_FLAG_RAW  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_srv_dimension
alias D3D12_SRV_DIMENSION = int;
enum : int
{
    D3D12_SRV_DIMENSION_UNKNOWN                           = 0x00000000,
    D3D12_SRV_DIMENSION_BUFFER                            = 0x00000001,
    D3D12_SRV_DIMENSION_TEXTURE1D                         = 0x00000002,
    D3D12_SRV_DIMENSION_TEXTURE1DARRAY                    = 0x00000003,
    D3D12_SRV_DIMENSION_TEXTURE2D                         = 0x00000004,
    D3D12_SRV_DIMENSION_TEXTURE2DARRAY                    = 0x00000005,
    D3D12_SRV_DIMENSION_TEXTURE2DMS                       = 0x00000006,
    D3D12_SRV_DIMENSION_TEXTURE2DMSARRAY                  = 0x00000007,
    D3D12_SRV_DIMENSION_TEXTURE3D                         = 0x00000008,
    D3D12_SRV_DIMENSION_TEXTURECUBE                       = 0x00000009,
    D3D12_SRV_DIMENSION_TEXTURECUBEARRAY                  = 0x0000000a,
    D3D12_SRV_DIMENSION_RAYTRACING_ACCELERATION_STRUCTURE = 0x0000000b,
    D3D12_SRV_DIMENSION_BUFFER_BYTE_OFFSET                = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_filter
alias D3D12_FILTER = int;
enum : int
{
    D3D12_FILTER_MIN_MAG_MIP_POINT                          = 0x00000000,
    D3D12_FILTER_MIN_MAG_POINT_MIP_LINEAR                   = 0x00000001,
    D3D12_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT             = 0x00000004,
    D3D12_FILTER_MIN_POINT_MAG_MIP_LINEAR                   = 0x00000005,
    D3D12_FILTER_MIN_LINEAR_MAG_MIP_POINT                   = 0x00000010,
    D3D12_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR            = 0x00000011,
    D3D12_FILTER_MIN_MAG_LINEAR_MIP_POINT                   = 0x00000014,
    D3D12_FILTER_MIN_MAG_MIP_LINEAR                         = 0x00000015,
    D3D12_FILTER_MIN_MAG_ANISOTROPIC_MIP_POINT              = 0x00000054,
    D3D12_FILTER_ANISOTROPIC                                = 0x00000055,
    D3D12_FILTER_COMPARISON_MIN_MAG_MIP_POINT               = 0x00000080,
    D3D12_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR        = 0x00000081,
    D3D12_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT  = 0x00000084,
    D3D12_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR        = 0x00000085,
    D3D12_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT        = 0x00000090,
    D3D12_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x00000091,
    D3D12_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT        = 0x00000094,
    D3D12_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR              = 0x00000095,
    D3D12_FILTER_COMPARISON_MIN_MAG_ANISOTROPIC_MIP_POINT   = 0x000000d4,
    D3D12_FILTER_COMPARISON_ANISOTROPIC                     = 0x000000d5,
    D3D12_FILTER_MINIMUM_MIN_MAG_MIP_POINT                  = 0x00000100,
    D3D12_FILTER_MINIMUM_MIN_MAG_POINT_MIP_LINEAR           = 0x00000101,
    D3D12_FILTER_MINIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT     = 0x00000104,
    D3D12_FILTER_MINIMUM_MIN_POINT_MAG_MIP_LINEAR           = 0x00000105,
    D3D12_FILTER_MINIMUM_MIN_LINEAR_MAG_MIP_POINT           = 0x00000110,
    D3D12_FILTER_MINIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR    = 0x00000111,
    D3D12_FILTER_MINIMUM_MIN_MAG_LINEAR_MIP_POINT           = 0x00000114,
    D3D12_FILTER_MINIMUM_MIN_MAG_MIP_LINEAR                 = 0x00000115,
    D3D12_FILTER_MINIMUM_MIN_MAG_ANISOTROPIC_MIP_POINT      = 0x00000154,
    D3D12_FILTER_MINIMUM_ANISOTROPIC                        = 0x00000155,
    D3D12_FILTER_MAXIMUM_MIN_MAG_MIP_POINT                  = 0x00000180,
    D3D12_FILTER_MAXIMUM_MIN_MAG_POINT_MIP_LINEAR           = 0x00000181,
    D3D12_FILTER_MAXIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT     = 0x00000184,
    D3D12_FILTER_MAXIMUM_MIN_POINT_MAG_MIP_LINEAR           = 0x00000185,
    D3D12_FILTER_MAXIMUM_MIN_LINEAR_MAG_MIP_POINT           = 0x00000190,
    D3D12_FILTER_MAXIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR    = 0x00000191,
    D3D12_FILTER_MAXIMUM_MIN_MAG_LINEAR_MIP_POINT           = 0x00000194,
    D3D12_FILTER_MAXIMUM_MIN_MAG_MIP_LINEAR                 = 0x00000195,
    D3D12_FILTER_MAXIMUM_MIN_MAG_ANISOTROPIC_MIP_POINT      = 0x000001d4,
    D3D12_FILTER_MAXIMUM_ANISOTROPIC                        = 0x000001d5,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_filter_type
alias D3D12_FILTER_TYPE = int;
enum : int
{
    D3D12_FILTER_TYPE_POINT  = 0x00000000,
    D3D12_FILTER_TYPE_LINEAR = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_filter_reduction_type
alias D3D12_FILTER_REDUCTION_TYPE = int;
enum : int
{
    D3D12_FILTER_REDUCTION_TYPE_STANDARD   = 0x00000000,
    D3D12_FILTER_REDUCTION_TYPE_COMPARISON = 0x00000001,
    D3D12_FILTER_REDUCTION_TYPE_MINIMUM    = 0x00000002,
    D3D12_FILTER_REDUCTION_TYPE_MAXIMUM    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_texture_address_mode
alias D3D12_TEXTURE_ADDRESS_MODE = int;
enum : int
{
    D3D12_TEXTURE_ADDRESS_MODE_WRAP        = 0x00000001,
    D3D12_TEXTURE_ADDRESS_MODE_MIRROR      = 0x00000002,
    D3D12_TEXTURE_ADDRESS_MODE_CLAMP       = 0x00000003,
    D3D12_TEXTURE_ADDRESS_MODE_BORDER      = 0x00000004,
    D3D12_TEXTURE_ADDRESS_MODE_MIRROR_ONCE = 0x00000005,
}

alias D3D12_SAMPLER_FLAGS = int;
enum : int
{
    D3D12_SAMPLER_FLAG_NONE                       = 0x00000000,
    D3D12_SAMPLER_FLAG_UINT_BORDER_COLOR          = 0x00000001,
    D3D12_SAMPLER_FLAG_NON_NORMALIZED_COORDINATES = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_buffer_uav_flags
alias D3D12_BUFFER_UAV_FLAGS = int;
enum : int
{
    D3D12_BUFFER_UAV_FLAG_NONE = 0x00000000,
    D3D12_BUFFER_UAV_FLAG_RAW  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_uav_dimension
alias D3D12_UAV_DIMENSION = int;
enum : int
{
    D3D12_UAV_DIMENSION_UNKNOWN            = 0x00000000,
    D3D12_UAV_DIMENSION_BUFFER             = 0x00000001,
    D3D12_UAV_DIMENSION_TEXTURE1D          = 0x00000002,
    D3D12_UAV_DIMENSION_TEXTURE1DARRAY     = 0x00000003,
    D3D12_UAV_DIMENSION_TEXTURE2D          = 0x00000004,
    D3D12_UAV_DIMENSION_TEXTURE2DARRAY     = 0x00000005,
    D3D12_UAV_DIMENSION_TEXTURE2DMS        = 0x00000006,
    D3D12_UAV_DIMENSION_TEXTURE2DMSARRAY   = 0x00000007,
    D3D12_UAV_DIMENSION_TEXTURE3D          = 0x00000008,
    D3D12_UAV_DIMENSION_BUFFER_BYTE_OFFSET = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_rtv_dimension
alias D3D12_RTV_DIMENSION = int;
enum : int
{
    D3D12_RTV_DIMENSION_UNKNOWN          = 0x00000000,
    D3D12_RTV_DIMENSION_BUFFER           = 0x00000001,
    D3D12_RTV_DIMENSION_TEXTURE1D        = 0x00000002,
    D3D12_RTV_DIMENSION_TEXTURE1DARRAY   = 0x00000003,
    D3D12_RTV_DIMENSION_TEXTURE2D        = 0x00000004,
    D3D12_RTV_DIMENSION_TEXTURE2DARRAY   = 0x00000005,
    D3D12_RTV_DIMENSION_TEXTURE2DMS      = 0x00000006,
    D3D12_RTV_DIMENSION_TEXTURE2DMSARRAY = 0x00000007,
    D3D12_RTV_DIMENSION_TEXTURE3D        = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_dsv_flags
alias D3D12_DSV_FLAGS = int;
enum : int
{
    D3D12_DSV_FLAG_NONE              = 0x00000000,
    D3D12_DSV_FLAG_READ_ONLY_DEPTH   = 0x00000001,
    D3D12_DSV_FLAG_READ_ONLY_STENCIL = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_dsv_dimension
alias D3D12_DSV_DIMENSION = int;
enum : int
{
    D3D12_DSV_DIMENSION_UNKNOWN          = 0x00000000,
    D3D12_DSV_DIMENSION_TEXTURE1D        = 0x00000001,
    D3D12_DSV_DIMENSION_TEXTURE1DARRAY   = 0x00000002,
    D3D12_DSV_DIMENSION_TEXTURE2D        = 0x00000003,
    D3D12_DSV_DIMENSION_TEXTURE2DARRAY   = 0x00000004,
    D3D12_DSV_DIMENSION_TEXTURE2DMS      = 0x00000005,
    D3D12_DSV_DIMENSION_TEXTURE2DMSARRAY = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_clear_flags
alias D3D12_CLEAR_FLAGS = int;
enum : int
{
    D3D12_CLEAR_FLAG_DEPTH   = 0x00000001,
    D3D12_CLEAR_FLAG_STENCIL = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_fence_flags
alias D3D12_FENCE_FLAGS = int;
enum : int
{
    D3D12_FENCE_FLAG_NONE                 = 0x00000000,
    D3D12_FENCE_FLAG_SHARED               = 0x00000001,
    D3D12_FENCE_FLAG_SHARED_CROSS_ADAPTER = 0x00000002,
    D3D12_FENCE_FLAG_NON_MONITORED        = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_descriptor_heap_type
alias D3D12_DESCRIPTOR_HEAP_TYPE = int;
enum : int
{
    D3D12_DESCRIPTOR_HEAP_TYPE_CBV_SRV_UAV = 0x00000000,
    D3D12_DESCRIPTOR_HEAP_TYPE_SAMPLER     = 0x00000001,
    D3D12_DESCRIPTOR_HEAP_TYPE_RTV         = 0x00000002,
    D3D12_DESCRIPTOR_HEAP_TYPE_DSV         = 0x00000003,
    D3D12_DESCRIPTOR_HEAP_TYPE_NUM_TYPES   = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_descriptor_heap_flags
alias D3D12_DESCRIPTOR_HEAP_FLAGS = int;
enum : int
{
    D3D12_DESCRIPTOR_HEAP_FLAG_NONE           = 0x00000000,
    D3D12_DESCRIPTOR_HEAP_FLAG_SHADER_VISIBLE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_descriptor_range_type
alias D3D12_DESCRIPTOR_RANGE_TYPE = int;
enum : int
{
    D3D12_DESCRIPTOR_RANGE_TYPE_SRV     = 0x00000000,
    D3D12_DESCRIPTOR_RANGE_TYPE_UAV     = 0x00000001,
    D3D12_DESCRIPTOR_RANGE_TYPE_CBV     = 0x00000002,
    D3D12_DESCRIPTOR_RANGE_TYPE_SAMPLER = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shader_visibility
alias D3D12_SHADER_VISIBILITY = int;
enum : int
{
    D3D12_SHADER_VISIBILITY_ALL           = 0x00000000,
    D3D12_SHADER_VISIBILITY_VERTEX        = 0x00000001,
    D3D12_SHADER_VISIBILITY_HULL          = 0x00000002,
    D3D12_SHADER_VISIBILITY_DOMAIN        = 0x00000003,
    D3D12_SHADER_VISIBILITY_GEOMETRY      = 0x00000004,
    D3D12_SHADER_VISIBILITY_PIXEL         = 0x00000005,
    D3D12_SHADER_VISIBILITY_AMPLIFICATION = 0x00000006,
    D3D12_SHADER_VISIBILITY_MESH          = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_root_parameter_type
alias D3D12_ROOT_PARAMETER_TYPE = int;
enum : int
{
    D3D12_ROOT_PARAMETER_TYPE_DESCRIPTOR_TABLE = 0x00000000,
    D3D12_ROOT_PARAMETER_TYPE_32BIT_CONSTANTS  = 0x00000001,
    D3D12_ROOT_PARAMETER_TYPE_CBV              = 0x00000002,
    D3D12_ROOT_PARAMETER_TYPE_SRV              = 0x00000003,
    D3D12_ROOT_PARAMETER_TYPE_UAV              = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_root_signature_flags
alias D3D12_ROOT_SIGNATURE_FLAGS = int;
enum : int
{
    D3D12_ROOT_SIGNATURE_FLAG_NONE                                  = 0x00000000,
    D3D12_ROOT_SIGNATURE_FLAG_ALLOW_INPUT_ASSEMBLER_INPUT_LAYOUT    = 0x00000001,
    D3D12_ROOT_SIGNATURE_FLAG_DENY_VERTEX_SHADER_ROOT_ACCESS        = 0x00000002,
    D3D12_ROOT_SIGNATURE_FLAG_DENY_HULL_SHADER_ROOT_ACCESS          = 0x00000004,
    D3D12_ROOT_SIGNATURE_FLAG_DENY_DOMAIN_SHADER_ROOT_ACCESS        = 0x00000008,
    D3D12_ROOT_SIGNATURE_FLAG_DENY_GEOMETRY_SHADER_ROOT_ACCESS      = 0x00000010,
    D3D12_ROOT_SIGNATURE_FLAG_DENY_PIXEL_SHADER_ROOT_ACCESS         = 0x00000020,
    D3D12_ROOT_SIGNATURE_FLAG_ALLOW_STREAM_OUTPUT                   = 0x00000040,
    D3D12_ROOT_SIGNATURE_FLAG_LOCAL_ROOT_SIGNATURE                  = 0x00000080,
    D3D12_ROOT_SIGNATURE_FLAG_DENY_AMPLIFICATION_SHADER_ROOT_ACCESS = 0x00000100,
    D3D12_ROOT_SIGNATURE_FLAG_DENY_MESH_SHADER_ROOT_ACCESS          = 0x00000200,
    D3D12_ROOT_SIGNATURE_FLAG_CBV_SRV_UAV_HEAP_DIRECTLY_INDEXED     = 0x00000400,
    D3D12_ROOT_SIGNATURE_FLAG_SAMPLER_HEAP_DIRECTLY_INDEXED         = 0x00000800,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_static_border_color
alias D3D12_STATIC_BORDER_COLOR = int;
enum : int
{
    D3D12_STATIC_BORDER_COLOR_TRANSPARENT_BLACK = 0x00000000,
    D3D12_STATIC_BORDER_COLOR_OPAQUE_BLACK      = 0x00000001,
    D3D12_STATIC_BORDER_COLOR_OPAQUE_WHITE      = 0x00000002,
    D3D12_STATIC_BORDER_COLOR_OPAQUE_BLACK_UINT = 0x00000003,
    D3D12_STATIC_BORDER_COLOR_OPAQUE_WHITE_UINT = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_descriptor_range_flags
alias D3D12_DESCRIPTOR_RANGE_FLAGS = int;
enum : int
{
    D3D12_DESCRIPTOR_RANGE_FLAG_NONE                                            = 0x00000000,
    D3D12_DESCRIPTOR_RANGE_FLAG_DESCRIPTORS_VOLATILE                            = 0x00000001,
    D3D12_DESCRIPTOR_RANGE_FLAG_DATA_VOLATILE                                   = 0x00000002,
    D3D12_DESCRIPTOR_RANGE_FLAG_DATA_STATIC_WHILE_SET_AT_EXECUTE                = 0x00000004,
    D3D12_DESCRIPTOR_RANGE_FLAG_DATA_STATIC                                     = 0x00000008,
    D3D12_DESCRIPTOR_RANGE_FLAG_DESCRIPTORS_STATIC_KEEPING_BUFFER_BOUNDS_CHECKS = 0x00010000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_root_descriptor_flags
alias D3D12_ROOT_DESCRIPTOR_FLAGS = int;
enum : int
{
    D3D12_ROOT_DESCRIPTOR_FLAG_NONE                             = 0x00000000,
    D3D12_ROOT_DESCRIPTOR_FLAG_DATA_VOLATILE                    = 0x00000002,
    D3D12_ROOT_DESCRIPTOR_FLAG_DATA_STATIC_WHILE_SET_AT_EXECUTE = 0x00000004,
    D3D12_ROOT_DESCRIPTOR_FLAG_DATA_STATIC                      = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_query_heap_type
alias D3D12_QUERY_HEAP_TYPE = int;
enum : int
{
    D3D12_QUERY_HEAP_TYPE_OCCLUSION               = 0x00000000,
    D3D12_QUERY_HEAP_TYPE_TIMESTAMP               = 0x00000001,
    D3D12_QUERY_HEAP_TYPE_PIPELINE_STATISTICS     = 0x00000002,
    D3D12_QUERY_HEAP_TYPE_SO_STATISTICS           = 0x00000003,
    D3D12_QUERY_HEAP_TYPE_VIDEO_DECODE_STATISTICS = 0x00000004,
    D3D12_QUERY_HEAP_TYPE_COPY_QUEUE_TIMESTAMP    = 0x00000005,
    D3D12_QUERY_HEAP_TYPE_PIPELINE_STATISTICS1    = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_query_type
alias D3D12_QUERY_TYPE = int;
enum : int
{
    D3D12_QUERY_TYPE_OCCLUSION               = 0x00000000,
    D3D12_QUERY_TYPE_BINARY_OCCLUSION        = 0x00000001,
    D3D12_QUERY_TYPE_TIMESTAMP               = 0x00000002,
    D3D12_QUERY_TYPE_PIPELINE_STATISTICS     = 0x00000003,
    D3D12_QUERY_TYPE_SO_STATISTICS_STREAM0   = 0x00000004,
    D3D12_QUERY_TYPE_SO_STATISTICS_STREAM1   = 0x00000005,
    D3D12_QUERY_TYPE_SO_STATISTICS_STREAM2   = 0x00000006,
    D3D12_QUERY_TYPE_SO_STATISTICS_STREAM3   = 0x00000007,
    D3D12_QUERY_TYPE_VIDEO_DECODE_STATISTICS = 0x00000008,
    D3D12_QUERY_TYPE_PIPELINE_STATISTICS1    = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_predication_op
alias D3D12_PREDICATION_OP = int;
enum : int
{
    D3D12_PREDICATION_OP_EQUAL_ZERO     = 0x00000000,
    D3D12_PREDICATION_OP_NOT_EQUAL_ZERO = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_indirect_argument_type
alias D3D12_INDIRECT_ARGUMENT_TYPE = int;
enum : int
{
    D3D12_INDIRECT_ARGUMENT_TYPE_DRAW                  = 0x00000000,
    D3D12_INDIRECT_ARGUMENT_TYPE_DRAW_INDEXED          = 0x00000001,
    D3D12_INDIRECT_ARGUMENT_TYPE_DISPATCH              = 0x00000002,
    D3D12_INDIRECT_ARGUMENT_TYPE_VERTEX_BUFFER_VIEW    = 0x00000003,
    D3D12_INDIRECT_ARGUMENT_TYPE_INDEX_BUFFER_VIEW     = 0x00000004,
    D3D12_INDIRECT_ARGUMENT_TYPE_CONSTANT              = 0x00000005,
    D3D12_INDIRECT_ARGUMENT_TYPE_CONSTANT_BUFFER_VIEW  = 0x00000006,
    D3D12_INDIRECT_ARGUMENT_TYPE_SHADER_RESOURCE_VIEW  = 0x00000007,
    D3D12_INDIRECT_ARGUMENT_TYPE_UNORDERED_ACCESS_VIEW = 0x00000008,
    D3D12_INDIRECT_ARGUMENT_TYPE_DISPATCH_RAYS         = 0x00000009,
    D3D12_INDIRECT_ARGUMENT_TYPE_DISPATCH_MESH         = 0x0000000a,
    D3D12_INDIRECT_ARGUMENT_TYPE_INCREMENTING_CONSTANT = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_writebufferimmediate_mode
alias D3D12_WRITEBUFFERIMMEDIATE_MODE = int;
enum : int
{
    D3D12_WRITEBUFFERIMMEDIATE_MODE_DEFAULT    = 0x00000000,
    D3D12_WRITEBUFFERIMMEDIATE_MODE_MARKER_IN  = 0x00000001,
    D3D12_WRITEBUFFERIMMEDIATE_MODE_MARKER_OUT = 0x00000002,
}

alias D3D12_COMMAND_QUEUE_PROCESS_PRIORITY = int;
enum : int
{
    D3D12_COMMAND_QUEUE_PROCESS_PRIORITY_NORMAL = 0x00000000,
    D3D12_COMMAND_QUEUE_PROCESS_PRIORITY_HIGH   = 0x00000001,
}

alias D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY = int;
enum : int
{
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_IDLE             = 0x00000000,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_DEFAULT          = 0x00000001,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_NORMAL_0         = 0x00000002,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_0  = 0x00000012,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_1  = 0x00000013,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_2  = 0x00000014,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_3  = 0x00000015,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_4  = 0x00000016,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_5  = 0x00000017,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_6  = 0x00000018,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_7  = 0x00000019,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_8  = 0x0000001a,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_9  = 0x0000001b,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_10 = 0x0000001c,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_11 = 0x0000001d,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_12 = 0x0000001e,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_SOFT_REALTIME_13 = 0x0000001f,
    D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY_HARD_REALTIME    = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_multiple_fence_wait_flags
alias D3D12_MULTIPLE_FENCE_WAIT_FLAGS = int;
enum : int
{
    D3D12_MULTIPLE_FENCE_WAIT_FLAG_NONE = 0x00000000,
    D3D12_MULTIPLE_FENCE_WAIT_FLAG_ANY  = 0x00000001,
    D3D12_MULTIPLE_FENCE_WAIT_FLAG_ALL  = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_residency_priority
alias D3D12_RESIDENCY_PRIORITY = int;
enum : int
{
    D3D12_RESIDENCY_PRIORITY_MINIMUM = 0x28000000,
    D3D12_RESIDENCY_PRIORITY_LOW     = 0x50000000,
    D3D12_RESIDENCY_PRIORITY_NORMAL  = 0x78000000,
    D3D12_RESIDENCY_PRIORITY_HIGH    = 0xa0010000,
    D3D12_RESIDENCY_PRIORITY_MAXIMUM = 0xc8000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_residency_flags
alias D3D12_RESIDENCY_FLAGS = int;
enum : int
{
    D3D12_RESIDENCY_FLAG_NONE            = 0x00000000,
    D3D12_RESIDENCY_FLAG_DENY_OVERBUDGET = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_command_list_flags
alias D3D12_COMMAND_LIST_FLAGS = int;
enum : int
{
    D3D12_COMMAND_LIST_FLAG_NONE = 0x00000000,
}

alias D3D12_COMMAND_POOL_FLAGS = int;
enum : int
{
    D3D12_COMMAND_POOL_FLAG_NONE = 0x00000000,
}

alias D3D12_COMMAND_RECORDER_FLAGS = int;
enum : int
{
    D3D12_COMMAND_RECORDER_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_protected_session_status
alias D3D12_PROTECTED_SESSION_STATUS = int;
enum : int
{
    D3D12_PROTECTED_SESSION_STATUS_OK      = 0x00000000,
    D3D12_PROTECTED_SESSION_STATUS_INVALID = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_protected_resource_session_support_flags
alias D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAGS = int;
enum : int
{
    D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAG_NONE      = 0x00000000,
    D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAG_SUPPORTED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_protected_resource_session_flags
alias D3D12_PROTECTED_RESOURCE_SESSION_FLAGS = int;
enum : int
{
    D3D12_PROTECTED_RESOURCE_SESSION_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_lifetime_state
alias D3D12_LIFETIME_STATE = int;
enum : int
{
    D3D12_LIFETIME_STATE_IN_USE     = 0x00000000,
    D3D12_LIFETIME_STATE_NOT_IN_USE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_meta_command_parameter_type
alias D3D12_META_COMMAND_PARAMETER_TYPE = int;
enum : int
{
    D3D12_META_COMMAND_PARAMETER_TYPE_FLOAT                                       = 0x00000000,
    D3D12_META_COMMAND_PARAMETER_TYPE_UINT64                                      = 0x00000001,
    D3D12_META_COMMAND_PARAMETER_TYPE_GPU_VIRTUAL_ADDRESS                         = 0x00000002,
    D3D12_META_COMMAND_PARAMETER_TYPE_CPU_DESCRIPTOR_HANDLE_HEAP_TYPE_CBV_SRV_UAV = 0x00000003,
    D3D12_META_COMMAND_PARAMETER_TYPE_GPU_DESCRIPTOR_HANDLE_HEAP_TYPE_CBV_SRV_UAV = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_meta_command_parameter_flags
alias D3D12_META_COMMAND_PARAMETER_FLAGS = int;
enum : int
{
    D3D12_META_COMMAND_PARAMETER_FLAG_INPUT  = 0x00000001,
    D3D12_META_COMMAND_PARAMETER_FLAG_OUTPUT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_meta_command_parameter_stage
alias D3D12_META_COMMAND_PARAMETER_STAGE = int;
enum : int
{
    D3D12_META_COMMAND_PARAMETER_STAGE_CREATION       = 0x00000000,
    D3D12_META_COMMAND_PARAMETER_STAGE_INITIALIZATION = 0x00000001,
    D3D12_META_COMMAND_PARAMETER_STAGE_EXECUTION      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_graphics_states
alias D3D12_GRAPHICS_STATES = int;
enum : int
{
    D3D12_GRAPHICS_STATE_NONE                    = 0x00000000,
    D3D12_GRAPHICS_STATE_IA_VERTEX_BUFFERS       = 0x00000001,
    D3D12_GRAPHICS_STATE_IA_INDEX_BUFFER         = 0x00000002,
    D3D12_GRAPHICS_STATE_IA_PRIMITIVE_TOPOLOGY   = 0x00000004,
    D3D12_GRAPHICS_STATE_DESCRIPTOR_HEAP         = 0x00000008,
    D3D12_GRAPHICS_STATE_GRAPHICS_ROOT_SIGNATURE = 0x00000010,
    D3D12_GRAPHICS_STATE_COMPUTE_ROOT_SIGNATURE  = 0x00000020,
    D3D12_GRAPHICS_STATE_RS_VIEWPORTS            = 0x00000040,
    D3D12_GRAPHICS_STATE_RS_SCISSOR_RECTS        = 0x00000080,
    D3D12_GRAPHICS_STATE_PREDICATION             = 0x00000100,
    D3D12_GRAPHICS_STATE_OM_RENDER_TARGETS       = 0x00000200,
    D3D12_GRAPHICS_STATE_OM_STENCIL_REF          = 0x00000400,
    D3D12_GRAPHICS_STATE_OM_BLEND_FACTOR         = 0x00000800,
    D3D12_GRAPHICS_STATE_PIPELINE_STATE          = 0x00001000,
    D3D12_GRAPHICS_STATE_SO_TARGETS              = 0x00002000,
    D3D12_GRAPHICS_STATE_OM_DEPTH_BOUNDS         = 0x00004000,
    D3D12_GRAPHICS_STATE_SAMPLE_POSITIONS        = 0x00008000,
    D3D12_GRAPHICS_STATE_VIEW_INSTANCE_MASK      = 0x00010000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_state_subobject_type
alias D3D12_STATE_SUBOBJECT_TYPE = int;
enum : int
{
    D3D12_STATE_SUBOBJECT_TYPE_STATE_OBJECT_CONFIG                   = 0x00000000,
    D3D12_STATE_SUBOBJECT_TYPE_GLOBAL_ROOT_SIGNATURE                 = 0x00000001,
    D3D12_STATE_SUBOBJECT_TYPE_LOCAL_ROOT_SIGNATURE                  = 0x00000002,
    D3D12_STATE_SUBOBJECT_TYPE_NODE_MASK                             = 0x00000003,
    D3D12_STATE_SUBOBJECT_TYPE_DXIL_LIBRARY                          = 0x00000005,
    D3D12_STATE_SUBOBJECT_TYPE_EXISTING_COLLECTION                   = 0x00000006,
    D3D12_STATE_SUBOBJECT_TYPE_SUBOBJECT_TO_EXPORTS_ASSOCIATION      = 0x00000007,
    D3D12_STATE_SUBOBJECT_TYPE_DXIL_SUBOBJECT_TO_EXPORTS_ASSOCIATION = 0x00000008,
    D3D12_STATE_SUBOBJECT_TYPE_RAYTRACING_SHADER_CONFIG              = 0x00000009,
    D3D12_STATE_SUBOBJECT_TYPE_RAYTRACING_PIPELINE_CONFIG            = 0x0000000a,
    D3D12_STATE_SUBOBJECT_TYPE_HIT_GROUP                             = 0x0000000b,
    D3D12_STATE_SUBOBJECT_TYPE_RAYTRACING_PIPELINE_CONFIG1           = 0x0000000c,
    D3D12_STATE_SUBOBJECT_TYPE_WORK_GRAPH                            = 0x0000000d,
    D3D12_STATE_SUBOBJECT_TYPE_STREAM_OUTPUT                         = 0x0000000e,
    D3D12_STATE_SUBOBJECT_TYPE_BLEND                                 = 0x0000000f,
    D3D12_STATE_SUBOBJECT_TYPE_SAMPLE_MASK                           = 0x00000010,
    D3D12_STATE_SUBOBJECT_TYPE_RASTERIZER                            = 0x00000011,
    D3D12_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL                         = 0x00000012,
    D3D12_STATE_SUBOBJECT_TYPE_INPUT_LAYOUT                          = 0x00000013,
    D3D12_STATE_SUBOBJECT_TYPE_IB_STRIP_CUT_VALUE                    = 0x00000014,
    D3D12_STATE_SUBOBJECT_TYPE_PRIMITIVE_TOPOLOGY                    = 0x00000015,
    D3D12_STATE_SUBOBJECT_TYPE_RENDER_TARGET_FORMATS                 = 0x00000016,
    D3D12_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL_FORMAT                  = 0x00000017,
    D3D12_STATE_SUBOBJECT_TYPE_SAMPLE_DESC                           = 0x00000018,
    D3D12_STATE_SUBOBJECT_TYPE_FLAGS                                 = 0x0000001a,
    D3D12_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL1                        = 0x0000001b,
    D3D12_STATE_SUBOBJECT_TYPE_VIEW_INSTANCING                       = 0x0000001c,
    D3D12_STATE_SUBOBJECT_TYPE_GENERIC_PROGRAM                       = 0x0000001d,
    D3D12_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL2                        = 0x0000001e,
    D3D12_STATE_SUBOBJECT_TYPE_GLOBAL_SERIALIZED_ROOT_SIGNATURE      = 0x0000001f,
    D3D12_STATE_SUBOBJECT_TYPE_LOCAL_SERIALIZED_ROOT_SIGNATURE       = 0x00000020,
    D3D12_STATE_SUBOBJECT_TYPE_COMPILER_EXISTING_COLLECTION          = 0x00000021,
    D3D12_STATE_SUBOBJECT_TYPE_EXISTING_COLLECTION_BY_KEY            = 0x00000024,
    D3D12_STATE_SUBOBJECT_TYPE_MAX_VALID                             = 0x00000025,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_state_object_flags
alias D3D12_STATE_OBJECT_FLAGS = int;
enum : int
{
    D3D12_STATE_OBJECT_FLAG_NONE                                             = 0x00000000,
    D3D12_STATE_OBJECT_FLAG_ALLOW_LOCAL_DEPENDENCIES_ON_EXTERNAL_DEFINITIONS = 0x00000001,
    D3D12_STATE_OBJECT_FLAG_ALLOW_EXTERNAL_DEPENDENCIES_ON_LOCAL_DEFINITIONS = 0x00000002,
    D3D12_STATE_OBJECT_FLAG_ALLOW_STATE_OBJECT_ADDITIONS                     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_export_flags
alias D3D12_EXPORT_FLAGS = int;
enum : int
{
    D3D12_EXPORT_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_hit_group_type
alias D3D12_HIT_GROUP_TYPE = int;
enum : int
{
    D3D12_HIT_GROUP_TYPE_TRIANGLES            = 0x00000000,
    D3D12_HIT_GROUP_TYPE_PROCEDURAL_PRIMITIVE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_raytracing_pipeline_flags
alias D3D12_RAYTRACING_PIPELINE_FLAGS = int;
enum : int
{
    D3D12_RAYTRACING_PIPELINE_FLAG_NONE                       = 0x00000000,
    D3D12_RAYTRACING_PIPELINE_FLAG_SKIP_TRIANGLES             = 0x00000100,
    D3D12_RAYTRACING_PIPELINE_FLAG_SKIP_PROCEDURAL_PRIMITIVES = 0x00000200,
    D3D12_RAYTRACING_PIPELINE_FLAG_ALLOW_OPACITY_MICROMAPS    = 0x00000400,
}

alias D3D12_NODE_OVERRIDES_TYPE = int;
enum : int
{
    D3D12_NODE_OVERRIDES_TYPE_NONE                = 0x00000000,
    D3D12_NODE_OVERRIDES_TYPE_BROADCASTING_LAUNCH = 0x00000001,
    D3D12_NODE_OVERRIDES_TYPE_COALESCING_LAUNCH   = 0x00000002,
    D3D12_NODE_OVERRIDES_TYPE_THREAD_LAUNCH       = 0x00000003,
    D3D12_NODE_OVERRIDES_TYPE_COMMON_COMPUTE      = 0x00000004,
}

alias D3D12_NODE_TYPE = int;
enum : int
{
    D3D12_NODE_TYPE_SHADER = 0x00000000,
}

alias D3D12_WORK_GRAPH_FLAGS = int;
enum : int
{
    D3D12_WORK_GRAPH_FLAG_NONE                        = 0x00000000,
    D3D12_WORK_GRAPH_FLAG_INCLUDE_ALL_AVAILABLE_NODES = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_state_object_type
alias D3D12_STATE_OBJECT_TYPE = int;
enum : int
{
    D3D12_STATE_OBJECT_TYPE_COLLECTION          = 0x00000000,
    D3D12_STATE_OBJECT_TYPE_RAYTRACING_PIPELINE = 0x00000003,
    D3D12_STATE_OBJECT_TYPE_EXECUTABLE          = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_raytracing_geometry_flags
alias D3D12_RAYTRACING_GEOMETRY_FLAGS = int;
enum : int
{
    D3D12_RAYTRACING_GEOMETRY_FLAG_NONE                           = 0x00000000,
    D3D12_RAYTRACING_GEOMETRY_FLAG_OPAQUE                         = 0x00000001,
    D3D12_RAYTRACING_GEOMETRY_FLAG_NO_DUPLICATE_ANYHIT_INVOCATION = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_raytracing_geometry_type
alias D3D12_RAYTRACING_GEOMETRY_TYPE = int;
enum : int
{
    D3D12_RAYTRACING_GEOMETRY_TYPE_TRIANGLES                  = 0x00000000,
    D3D12_RAYTRACING_GEOMETRY_TYPE_PROCEDURAL_PRIMITIVE_AABBS = 0x00000001,
    D3D12_RAYTRACING_GEOMETRY_TYPE_OMM_TRIANGLES              = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_raytracing_instance_flags
alias D3D12_RAYTRACING_INSTANCE_FLAGS = int;
enum : int
{
    D3D12_RAYTRACING_INSTANCE_FLAG_NONE                            = 0x00000000,
    D3D12_RAYTRACING_INSTANCE_FLAG_TRIANGLE_CULL_DISABLE           = 0x00000001,
    D3D12_RAYTRACING_INSTANCE_FLAG_TRIANGLE_FRONT_COUNTERCLOCKWISE = 0x00000002,
    D3D12_RAYTRACING_INSTANCE_FLAG_FORCE_OPAQUE                    = 0x00000004,
    D3D12_RAYTRACING_INSTANCE_FLAG_FORCE_NON_OPAQUE                = 0x00000008,
    D3D12_RAYTRACING_INSTANCE_FLAG_FORCE_OMM_2_STATE               = 0x00000010,
    D3D12_RAYTRACING_INSTANCE_FLAG_DISABLE_OMMS                    = 0x00000020,
}

alias D3D12_RAYTRACING_OPACITY_MICROMAP_SPECIAL_INDEX = int;
enum : int
{
    D3D12_RAYTRACING_OPACITY_MICROMAP_SPECIAL_INDEX_FULLY_TRANSPARENT         = 0xffffffff,
    D3D12_RAYTRACING_OPACITY_MICROMAP_SPECIAL_INDEX_FULLY_OPAQUE              = 0xfffffffe,
    D3D12_RAYTRACING_OPACITY_MICROMAP_SPECIAL_INDEX_FULLY_UNKNOWN_TRANSPARENT = 0xfffffffd,
    D3D12_RAYTRACING_OPACITY_MICROMAP_SPECIAL_INDEX_FULLY_UNKNOWN_OPAQUE      = 0xfffffffc,
}

alias D3D12_RAYTRACING_OPACITY_MICROMAP_STATE = int;
enum : int
{
    D3D12_RAYTRACING_OPACITY_MICROMAP_STATE_TRANSPARENT         = 0x00000000,
    D3D12_RAYTRACING_OPACITY_MICROMAP_STATE_OPAQUE              = 0x00000001,
    D3D12_RAYTRACING_OPACITY_MICROMAP_STATE_UNKNOWN_TRANSPARENT = 0x00000002,
    D3D12_RAYTRACING_OPACITY_MICROMAP_STATE_UNKNOWN_OPAQUE      = 0x00000003,
}

alias D3D12_RAYTRACING_OPACITY_MICROMAP_FORMAT = int;
enum : int
{
    D3D12_RAYTRACING_OPACITY_MICROMAP_FORMAT_OC1_2_STATE = 0x00000001,
    D3D12_RAYTRACING_OPACITY_MICROMAP_FORMAT_OC1_4_STATE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_raytracing_acceleration_structure_build_flags
alias D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS = int;
enum : int
{
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_NONE               = 0x00000000,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_UPDATE       = 0x00000001,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_COMPACTION   = 0x00000002,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PREFER_FAST_TRACE  = 0x00000004,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PREFER_FAST_BUILD  = 0x00000008,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_MINIMIZE_MEMORY    = 0x00000010,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PERFORM_UPDATE     = 0x00000020,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_OMM_UPDATE   = 0x00000040,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_DISABLE_OMMS = 0x00000080,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_raytracing_acceleration_structure_copy_mode
alias D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE = int;
enum : int
{
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_CLONE                          = 0x00000000,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_COMPACT                        = 0x00000001,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_VISUALIZATION_DECODE_FOR_TOOLS = 0x00000002,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_SERIALIZE                      = 0x00000003,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_DESERIALIZE                    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_raytracing_acceleration_structure_type
alias D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE = int;
enum : int
{
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE_TOP_LEVEL              = 0x00000000,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE_BOTTOM_LEVEL           = 0x00000001,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE_OPACITY_MICROMAP_ARRAY = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_elements_layout
alias D3D12_ELEMENTS_LAYOUT = int;
enum : int
{
    D3D12_ELEMENTS_LAYOUT_ARRAY             = 0x00000000,
    D3D12_ELEMENTS_LAYOUT_ARRAY_OF_POINTERS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_raytracing_acceleration_structure_postbuild_info_type
alias D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TYPE = int;
enum : int
{
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_COMPACTED_SIZE      = 0x00000000,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TOOLS_VISUALIZATION = 0x00000001,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_SERIALIZATION       = 0x00000002,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_CURRENT_SIZE        = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_serialized_data_type
alias D3D12_SERIALIZED_DATA_TYPE = int;
enum : int
{
    D3D12_SERIALIZED_DATA_RAYTRACING_ACCELERATION_STRUCTURE = 0x00000000,
    D3D12_SERIALIZED_DATA_APPLICATION_SPECIFIC_DRIVER_STATE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_driver_matching_identifier_status
alias D3D12_DRIVER_MATCHING_IDENTIFIER_STATUS = int;
enum : int
{
    D3D12_DRIVER_MATCHING_IDENTIFIER_COMPATIBLE_WITH_DEVICE = 0x00000000,
    D3D12_DRIVER_MATCHING_IDENTIFIER_UNSUPPORTED_TYPE       = 0x00000001,
    D3D12_DRIVER_MATCHING_IDENTIFIER_UNRECOGNIZED           = 0x00000002,
    D3D12_DRIVER_MATCHING_IDENTIFIER_INCOMPATIBLE_VERSION   = 0x00000003,
    D3D12_DRIVER_MATCHING_IDENTIFIER_INCOMPATIBLE_TYPE      = 0x00000004,
}

alias D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER_POSTAMBLE_TYPE = int;
enum : int
{
    D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER_POSTAMBLE_TYPE_NONE                  = 0x00000000,
    D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER_POSTAMBLE_TYPE_BOTTOM_LEVEL_POINTERS = 0x00000000,
    D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER_POSTAMBLE_TYPE_BLOCKS                = 0xffffffff,
}

alias D3D12_SERIALIZED_BLOCK_TYPE = int;
enum : int
{
    D3D12_RAYTRACING_SERIALIZED_BLOCK_TYPE_OPACITY_MICROMAPS = 0x00000000,
}

alias D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_TYPE = int;
enum : int
{
    D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_CURRENT_SIZE        = 0x00000000,
    D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_TOOLS_VISUALIZATION = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_ray_flags
alias D3D12_RAY_FLAGS = int;
enum : int
{
    D3D12_RAY_FLAG_NONE                            = 0x00000000,
    D3D12_RAY_FLAG_FORCE_OPAQUE                    = 0x00000001,
    D3D12_RAY_FLAG_FORCE_NON_OPAQUE                = 0x00000002,
    D3D12_RAY_FLAG_ACCEPT_FIRST_HIT_AND_END_SEARCH = 0x00000004,
    D3D12_RAY_FLAG_SKIP_CLOSEST_HIT_SHADER         = 0x00000008,
    D3D12_RAY_FLAG_CULL_BACK_FACING_TRIANGLES      = 0x00000010,
    D3D12_RAY_FLAG_CULL_FRONT_FACING_TRIANGLES     = 0x00000020,
    D3D12_RAY_FLAG_CULL_OPAQUE                     = 0x00000040,
    D3D12_RAY_FLAG_CULL_NON_OPAQUE                 = 0x00000080,
    D3D12_RAY_FLAG_SKIP_TRIANGLES                  = 0x00000100,
    D3D12_RAY_FLAG_SKIP_PROCEDURAL_PRIMITIVES      = 0x00000200,
    D3D12_RAY_FLAG_FORCE_OMM_2_STATE               = 0x00000400,
}

alias D3D12_HIT_KIND = int;
enum : int
{
    D3D12_HIT_KIND_TRIANGLE_FRONT_FACE = 0x000000fe,
    D3D12_HIT_KIND_TRIANGLE_BACK_FACE  = 0x000000ff,
}

alias D3D12_MARKER_API = int;
enum : int
{
    D3D12_MARKER_API_SETMARKER                                        = 0x00000000,
    D3D12_MARKER_API_BEGINEVENT                                       = 0x00000001,
    D3D12_MARKER_API_ENDEVENT                                         = 0x00000002,
    D3D12_MARKER_API_DRAWINSTANCED                                    = 0x00000003,
    D3D12_MARKER_API_DRAWINDEXEDINSTANCED                             = 0x00000004,
    D3D12_MARKER_API_EXECUTEINDIRECT                                  = 0x00000005,
    D3D12_MARKER_API_DISPATCH                                         = 0x00000006,
    D3D12_MARKER_API_COPYBUFFERREGION                                 = 0x00000007,
    D3D12_MARKER_API_COPYTEXTUREREGION                                = 0x00000008,
    D3D12_MARKER_API_COPYRESOURCE                                     = 0x00000009,
    D3D12_MARKER_API_COPYTILES                                        = 0x0000000a,
    D3D12_MARKER_API_RESOLVESUBRESOURCE                               = 0x0000000b,
    D3D12_MARKER_API_CLEARRENDERTARGETVIEW                            = 0x0000000c,
    D3D12_MARKER_API_CLEARUNORDEREDACCESSVIEW                         = 0x0000000d,
    D3D12_MARKER_API_CLEARDEPTHSTENCILVIEW                            = 0x0000000e,
    D3D12_MARKER_API_RESOURCEBARRIER                                  = 0x0000000f,
    D3D12_MARKER_API_EXECUTEBUNDLE                                    = 0x00000010,
    D3D12_MARKER_API_PRESENT                                          = 0x00000011,
    D3D12_MARKER_API_RESOLVEQUERYDATA                                 = 0x00000012,
    D3D12_MARKER_API_BEGINSUBMISSION                                  = 0x00000013,
    D3D12_MARKER_API_ENDSUBMISSION                                    = 0x00000014,
    D3D12_MARKER_API_DECODEFRAME                                      = 0x00000015,
    D3D12_MARKER_API_PROCESSFRAMES                                    = 0x00000016,
    D3D12_MARKER_API_ATOMICCOPYBUFFERUINT                             = 0x00000017,
    D3D12_MARKER_API_ATOMICCOPYBUFFERUINT64                           = 0x00000018,
    D3D12_MARKER_API_RESOLVESUBRESOURCEREGION                         = 0x00000019,
    D3D12_MARKER_API_WRITEBUFFERIMMEDIATE                             = 0x0000001a,
    D3D12_MARKER_API_DECODEFRAME1                                     = 0x0000001b,
    D3D12_MARKER_API_SETPROTECTEDRESOURCESESSION                      = 0x0000001c,
    D3D12_MARKER_API_DECODEFRAME2                                     = 0x0000001d,
    D3D12_MARKER_API_PROCESSFRAMES1                                   = 0x0000001e,
    D3D12_MARKER_API_BUILDRAYTRACINGACCELERATIONSTRUCTURE             = 0x0000001f,
    D3D12_MARKER_API_EMITRAYTRACINGACCELERATIONSTRUCTUREPOSTBUILDINFO = 0x00000020,
    D3D12_MARKER_API_COPYRAYTRACINGACCELERATIONSTRUCTURE              = 0x00000021,
    D3D12_MARKER_API_DISPATCHRAYS                                     = 0x00000022,
    D3D12_MARKER_API_INITIALIZEMETACOMMAND                            = 0x00000023,
    D3D12_MARKER_API_EXECUTEMETACOMMAND                               = 0x00000024,
    D3D12_MARKER_API_ESTIMATEMOTION                                   = 0x00000025,
    D3D12_MARKER_API_RESOLVEMOTIONVECTORHEAP                          = 0x00000026,
    D3D12_MARKER_API_SETPIPELINESTATE1                                = 0x00000027,
    D3D12_MARKER_API_INITIALIZEEXTENSIONCOMMAND                       = 0x00000028,
    D3D12_MARKER_API_EXECUTEEXTENSIONCOMMAND                          = 0x00000029,
    D3D12_MARKER_API_DISPATCHMESH                                     = 0x0000002a,
    D3D12_MARKER_API_ENCODEFRAME                                      = 0x0000002b,
    D3D12_MARKER_API_RESOLVEENCODEROUTPUTMETADATA                     = 0x0000002c,
    D3D12_MARKER_API_BARRIER                                          = 0x0000002d,
    D3D12_MARKER_API_BEGIN_COMMAND_LIST                               = 0x0000002e,
    D3D12_MARKER_API_DISPATCHGRAPH                                    = 0x0000002f,
    D3D12_MARKER_API_SETPROGRAM                                       = 0x00000030,
    D3D12_MARKER_API_ENCODEFRAME1                                     = 0x00000031,
    D3D12_MARKER_API_RESOLVEENCODEROUTPUTMETADATA1                    = 0x00000032,
    D3D12_MARKER_API_RESOLVEINPUTPARAMLAYOUT                          = 0x00000033,
    D3D12_MARKER_API_PROCESSFRAMES2                                   = 0x00000034,
    D3D12_MARKER_API_SET_WORK_GRAPH_MAXIMUM_GPU_INPUT_RECORDS         = 0x00000035,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_auto_breadcrumb_op
alias D3D12_AUTO_BREADCRUMB_OP = int;
enum : int
{
    D3D12_AUTO_BREADCRUMB_OP_SETMARKER                                        = 0x00000000,
    D3D12_AUTO_BREADCRUMB_OP_BEGINEVENT                                       = 0x00000001,
    D3D12_AUTO_BREADCRUMB_OP_ENDEVENT                                         = 0x00000002,
    D3D12_AUTO_BREADCRUMB_OP_DRAWINSTANCED                                    = 0x00000003,
    D3D12_AUTO_BREADCRUMB_OP_DRAWINDEXEDINSTANCED                             = 0x00000004,
    D3D12_AUTO_BREADCRUMB_OP_EXECUTEINDIRECT                                  = 0x00000005,
    D3D12_AUTO_BREADCRUMB_OP_DISPATCH                                         = 0x00000006,
    D3D12_AUTO_BREADCRUMB_OP_COPYBUFFERREGION                                 = 0x00000007,
    D3D12_AUTO_BREADCRUMB_OP_COPYTEXTUREREGION                                = 0x00000008,
    D3D12_AUTO_BREADCRUMB_OP_COPYRESOURCE                                     = 0x00000009,
    D3D12_AUTO_BREADCRUMB_OP_COPYTILES                                        = 0x0000000a,
    D3D12_AUTO_BREADCRUMB_OP_RESOLVESUBRESOURCE                               = 0x0000000b,
    D3D12_AUTO_BREADCRUMB_OP_CLEARRENDERTARGETVIEW                            = 0x0000000c,
    D3D12_AUTO_BREADCRUMB_OP_CLEARUNORDEREDACCESSVIEW                         = 0x0000000d,
    D3D12_AUTO_BREADCRUMB_OP_CLEARDEPTHSTENCILVIEW                            = 0x0000000e,
    D3D12_AUTO_BREADCRUMB_OP_RESOURCEBARRIER                                  = 0x0000000f,
    D3D12_AUTO_BREADCRUMB_OP_EXECUTEBUNDLE                                    = 0x00000010,
    D3D12_AUTO_BREADCRUMB_OP_PRESENT                                          = 0x00000011,
    D3D12_AUTO_BREADCRUMB_OP_RESOLVEQUERYDATA                                 = 0x00000012,
    D3D12_AUTO_BREADCRUMB_OP_BEGINSUBMISSION                                  = 0x00000013,
    D3D12_AUTO_BREADCRUMB_OP_ENDSUBMISSION                                    = 0x00000014,
    D3D12_AUTO_BREADCRUMB_OP_DECODEFRAME                                      = 0x00000015,
    D3D12_AUTO_BREADCRUMB_OP_PROCESSFRAMES                                    = 0x00000016,
    D3D12_AUTO_BREADCRUMB_OP_ATOMICCOPYBUFFERUINT                             = 0x00000017,
    D3D12_AUTO_BREADCRUMB_OP_ATOMICCOPYBUFFERUINT64                           = 0x00000018,
    D3D12_AUTO_BREADCRUMB_OP_RESOLVESUBRESOURCEREGION                         = 0x00000019,
    D3D12_AUTO_BREADCRUMB_OP_WRITEBUFFERIMMEDIATE                             = 0x0000001a,
    D3D12_AUTO_BREADCRUMB_OP_DECODEFRAME1                                     = 0x0000001b,
    D3D12_AUTO_BREADCRUMB_OP_SETPROTECTEDRESOURCESESSION                      = 0x0000001c,
    D3D12_AUTO_BREADCRUMB_OP_DECODEFRAME2                                     = 0x0000001d,
    D3D12_AUTO_BREADCRUMB_OP_PROCESSFRAMES1                                   = 0x0000001e,
    D3D12_AUTO_BREADCRUMB_OP_BUILDRAYTRACINGACCELERATIONSTRUCTURE             = 0x0000001f,
    D3D12_AUTO_BREADCRUMB_OP_EMITRAYTRACINGACCELERATIONSTRUCTUREPOSTBUILDINFO = 0x00000020,
    D3D12_AUTO_BREADCRUMB_OP_COPYRAYTRACINGACCELERATIONSTRUCTURE              = 0x00000021,
    D3D12_AUTO_BREADCRUMB_OP_DISPATCHRAYS                                     = 0x00000022,
    D3D12_AUTO_BREADCRUMB_OP_INITIALIZEMETACOMMAND                            = 0x00000023,
    D3D12_AUTO_BREADCRUMB_OP_EXECUTEMETACOMMAND                               = 0x00000024,
    D3D12_AUTO_BREADCRUMB_OP_ESTIMATEMOTION                                   = 0x00000025,
    D3D12_AUTO_BREADCRUMB_OP_RESOLVEMOTIONVECTORHEAP                          = 0x00000026,
    D3D12_AUTO_BREADCRUMB_OP_SETPIPELINESTATE1                                = 0x00000027,
    D3D12_AUTO_BREADCRUMB_OP_INITIALIZEEXTENSIONCOMMAND                       = 0x00000028,
    D3D12_AUTO_BREADCRUMB_OP_EXECUTEEXTENSIONCOMMAND                          = 0x00000029,
    D3D12_AUTO_BREADCRUMB_OP_DISPATCHMESH                                     = 0x0000002a,
    D3D12_AUTO_BREADCRUMB_OP_ENCODEFRAME                                      = 0x0000002b,
    D3D12_AUTO_BREADCRUMB_OP_RESOLVEENCODEROUTPUTMETADATA                     = 0x0000002c,
    D3D12_AUTO_BREADCRUMB_OP_BARRIER                                          = 0x0000002d,
    D3D12_AUTO_BREADCRUMB_OP_BEGIN_COMMAND_LIST                               = 0x0000002e,
    D3D12_AUTO_BREADCRUMB_OP_DISPATCHGRAPH                                    = 0x0000002f,
    D3D12_AUTO_BREADCRUMB_OP_SETPROGRAM                                       = 0x00000030,
    D3D12_AUTO_BREADCRUMB_OP_ENCODEFRAME1                                     = 0x00000031,
    D3D12_AUTO_BREADCRUMB_OP_RESOLVEENCODEROUTPUTMETADATA1                    = 0x00000032,
    D3D12_AUTO_BREADCRUMB_OP_RESOLVEINPUTPARAMLAYOUT                          = 0x00000033,
    D3D12_AUTO_BREADCRUMB_OP_PROCESSFRAMES2                                   = 0x00000034,
    D3D12_AUTO_BREADCRUMB_OP_SET_WORK_GRAPH_MAXIMUM_GPU_INPUT_RECORDS         = 0x00000035,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_dred_version
alias D3D12_DRED_VERSION = int;
enum : int
{
    D3D12_DRED_VERSION_1_0 = 0x00000001,
    D3D12_DRED_VERSION_1_1 = 0x00000002,
    D3D12_DRED_VERSION_1_2 = 0x00000003,
    D3D12_DRED_VERSION_1_3 = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_dred_flags
alias D3D12_DRED_FLAGS = int;
enum : int
{
    D3D12_DRED_FLAG_NONE                    = 0x00000000,
    D3D12_DRED_FLAG_FORCE_ENABLE            = 0x00000001,
    D3D12_DRED_FLAG_DISABLE_AUTOBREADCRUMBS = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_dred_enablement
alias D3D12_DRED_ENABLEMENT = int;
enum : int
{
    D3D12_DRED_ENABLEMENT_SYSTEM_CONTROLLED = 0x00000000,
    D3D12_DRED_ENABLEMENT_FORCED_OFF        = 0x00000001,
    D3D12_DRED_ENABLEMENT_FORCED_ON         = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_dred_allocation_type
alias D3D12_DRED_ALLOCATION_TYPE = int;
enum : int
{
    D3D12_DRED_ALLOCATION_TYPE_COMMAND_QUEUE            = 0x00000013,
    D3D12_DRED_ALLOCATION_TYPE_COMMAND_ALLOCATOR        = 0x00000014,
    D3D12_DRED_ALLOCATION_TYPE_PIPELINE_STATE           = 0x00000015,
    D3D12_DRED_ALLOCATION_TYPE_COMMAND_LIST             = 0x00000016,
    D3D12_DRED_ALLOCATION_TYPE_FENCE                    = 0x00000017,
    D3D12_DRED_ALLOCATION_TYPE_DESCRIPTOR_HEAP          = 0x00000018,
    D3D12_DRED_ALLOCATION_TYPE_HEAP                     = 0x00000019,
    D3D12_DRED_ALLOCATION_TYPE_QUERY_HEAP               = 0x0000001b,
    D3D12_DRED_ALLOCATION_TYPE_COMMAND_SIGNATURE        = 0x0000001c,
    D3D12_DRED_ALLOCATION_TYPE_PIPELINE_LIBRARY         = 0x0000001d,
    D3D12_DRED_ALLOCATION_TYPE_VIDEO_DECODER            = 0x0000001e,
    D3D12_DRED_ALLOCATION_TYPE_VIDEO_PROCESSOR          = 0x00000020,
    D3D12_DRED_ALLOCATION_TYPE_RESOURCE                 = 0x00000022,
    D3D12_DRED_ALLOCATION_TYPE_PASS                     = 0x00000023,
    D3D12_DRED_ALLOCATION_TYPE_CRYPTOSESSION            = 0x00000024,
    D3D12_DRED_ALLOCATION_TYPE_CRYPTOSESSIONPOLICY      = 0x00000025,
    D3D12_DRED_ALLOCATION_TYPE_PROTECTEDRESOURCESESSION = 0x00000026,
    D3D12_DRED_ALLOCATION_TYPE_VIDEO_DECODER_HEAP       = 0x00000027,
    D3D12_DRED_ALLOCATION_TYPE_COMMAND_POOL             = 0x00000028,
    D3D12_DRED_ALLOCATION_TYPE_COMMAND_RECORDER         = 0x00000029,
    D3D12_DRED_ALLOCATION_TYPE_STATE_OBJECT             = 0x0000002a,
    D3D12_DRED_ALLOCATION_TYPE_METACOMMAND              = 0x0000002b,
    D3D12_DRED_ALLOCATION_TYPE_SCHEDULINGGROUP          = 0x0000002c,
    D3D12_DRED_ALLOCATION_TYPE_VIDEO_MOTION_ESTIMATOR   = 0x0000002d,
    D3D12_DRED_ALLOCATION_TYPE_VIDEO_MOTION_VECTOR_HEAP = 0x0000002e,
    D3D12_DRED_ALLOCATION_TYPE_VIDEO_EXTENSION_COMMAND  = 0x0000002f,
    D3D12_DRED_ALLOCATION_TYPE_VIDEO_ENCODER            = 0x00000030,
    D3D12_DRED_ALLOCATION_TYPE_VIDEO_ENCODER_HEAP       = 0x00000031,
    D3D12_DRED_ALLOCATION_TYPE_INVALID                  = 0xffffffff,
}

alias D3D12_DRED_PAGE_FAULT_FLAGS = int;
enum : int
{
    D3D12_DRED_PAGE_FAULT_FLAGS_NONE = 0x00000000,
}

alias D3D12_DRED_DEVICE_STATE = int;
enum : int
{
    D3D12_DRED_DEVICE_STATE_UNKNOWN   = 0x00000000,
    D3D12_DRED_DEVICE_STATE_HUNG      = 0x00000003,
    D3D12_DRED_DEVICE_STATE_FAULT     = 0x00000006,
    D3D12_DRED_DEVICE_STATE_PAGEFAULT = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_background_processing_mode
alias D3D12_BACKGROUND_PROCESSING_MODE = int;
enum : int
{
    D3D12_BACKGROUND_PROCESSING_MODE_ALLOWED                      = 0x00000000,
    D3D12_BACKGROUND_PROCESSING_MODE_ALLOW_INTRUSIVE_MEASUREMENTS = 0x00000001,
    D3D12_BACKGROUND_PROCESSING_MODE_DISABLE_BACKGROUND_WORK      = 0x00000002,
    D3D12_BACKGROUND_PROCESSING_MODE_DISABLE_PROFILING_BY_SYSTEM  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_measurements_action
alias D3D12_MEASUREMENTS_ACTION = int;
enum : int
{
    D3D12_MEASUREMENTS_ACTION_KEEP_ALL                     = 0x00000000,
    D3D12_MEASUREMENTS_ACTION_COMMIT_RESULTS               = 0x00000001,
    D3D12_MEASUREMENTS_ACTION_COMMIT_RESULTS_HIGH_PRIORITY = 0x00000002,
    D3D12_MEASUREMENTS_ACTION_DISCARD_PREVIOUS             = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_render_pass_beginning_access_type
alias D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE = int;
enum : int
{
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_DISCARD               = 0x00000000,
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_PRESERVE              = 0x00000001,
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_CLEAR                 = 0x00000002,
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_NO_ACCESS             = 0x00000003,
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_PRESERVE_LOCAL_RENDER = 0x00000004,
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_PRESERVE_LOCAL_SRV    = 0x00000005,
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_PRESERVE_LOCAL_UAV    = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_render_pass_ending_access_type
alias D3D12_RENDER_PASS_ENDING_ACCESS_TYPE = int;
enum : int
{
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_DISCARD               = 0x00000000,
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_PRESERVE              = 0x00000001,
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_RESOLVE               = 0x00000002,
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_NO_ACCESS             = 0x00000003,
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_PRESERVE_LOCAL_RENDER = 0x00000004,
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_PRESERVE_LOCAL_SRV    = 0x00000005,
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_PRESERVE_LOCAL_UAV    = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_render_pass_flags
alias D3D12_RENDER_PASS_FLAGS = int;
enum : int
{
    D3D12_RENDER_PASS_FLAG_NONE                   = 0x00000000,
    D3D12_RENDER_PASS_FLAG_ALLOW_UAV_WRITES       = 0x00000001,
    D3D12_RENDER_PASS_FLAG_SUSPENDING_PASS        = 0x00000002,
    D3D12_RENDER_PASS_FLAG_RESUMING_PASS          = 0x00000004,
    D3D12_RENDER_PASS_FLAG_BIND_READ_ONLY_DEPTH   = 0x00000008,
    D3D12_RENDER_PASS_FLAG_BIND_READ_ONLY_STENCIL = 0x00000010,
}

alias D3D12_SET_WORK_GRAPH_FLAGS = int;
enum : int
{
    D3D12_SET_WORK_GRAPH_FLAG_NONE       = 0x00000000,
    D3D12_SET_WORK_GRAPH_FLAG_INITIALIZE = 0x00000001,
}

alias D3D12_PROGRAM_TYPE = int;
enum : int
{
    D3D12_PROGRAM_TYPE_GENERIC_PIPELINE    = 0x00000001,
    D3D12_PROGRAM_TYPE_RAYTRACING_PIPELINE = 0x00000004,
    D3D12_PROGRAM_TYPE_WORK_GRAPH          = 0x00000005,
}

alias D3D12_DISPATCH_MODE = int;
enum : int
{
    D3D12_DISPATCH_MODE_NODE_CPU_INPUT       = 0x00000000,
    D3D12_DISPATCH_MODE_NODE_GPU_INPUT       = 0x00000001,
    D3D12_DISPATCH_MODE_MULTI_NODE_CPU_INPUT = 0x00000002,
    D3D12_DISPATCH_MODE_MULTI_NODE_GPU_INPUT = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shader_cache_mode
alias D3D12_SHADER_CACHE_MODE = int;
enum : int
{
    D3D12_SHADER_CACHE_MODE_MEMORY = 0x00000000,
    D3D12_SHADER_CACHE_MODE_DISK   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shader_cache_flags
alias D3D12_SHADER_CACHE_FLAGS = int;
enum : int
{
    D3D12_SHADER_CACHE_FLAG_NONE             = 0x00000000,
    D3D12_SHADER_CACHE_FLAG_DRIVER_VERSIONED = 0x00000001,
    D3D12_SHADER_CACHE_FLAG_USE_WORKING_DIR  = 0x00000002,
}

alias D3D12_BARRIER_LAYOUT = int;
enum : int
{
    D3D12_BARRIER_LAYOUT_UNDEFINED                                          = 0xffffffff,
    D3D12_BARRIER_LAYOUT_COMMON                                             = 0x00000000,
    D3D12_BARRIER_LAYOUT_PRESENT                                            = 0x00000000,
    D3D12_BARRIER_LAYOUT_GENERIC_READ                                       = 0x00000001,
    D3D12_BARRIER_LAYOUT_RENDER_TARGET                                      = 0x00000002,
    D3D12_BARRIER_LAYOUT_UNORDERED_ACCESS                                   = 0x00000003,
    D3D12_BARRIER_LAYOUT_DEPTH_STENCIL_WRITE                                = 0x00000004,
    D3D12_BARRIER_LAYOUT_DEPTH_STENCIL_READ                                 = 0x00000005,
    D3D12_BARRIER_LAYOUT_SHADER_RESOURCE                                    = 0x00000006,
    D3D12_BARRIER_LAYOUT_COPY_SOURCE                                        = 0x00000007,
    D3D12_BARRIER_LAYOUT_COPY_DEST                                          = 0x00000008,
    D3D12_BARRIER_LAYOUT_RESOLVE_SOURCE                                     = 0x00000009,
    D3D12_BARRIER_LAYOUT_RESOLVE_DEST                                       = 0x0000000a,
    D3D12_BARRIER_LAYOUT_SHADING_RATE_SOURCE                                = 0x0000000b,
    D3D12_BARRIER_LAYOUT_VIDEO_DECODE_READ                                  = 0x0000000c,
    D3D12_BARRIER_LAYOUT_VIDEO_DECODE_WRITE                                 = 0x0000000d,
    D3D12_BARRIER_LAYOUT_VIDEO_PROCESS_READ                                 = 0x0000000e,
    D3D12_BARRIER_LAYOUT_VIDEO_PROCESS_WRITE                                = 0x0000000f,
    D3D12_BARRIER_LAYOUT_VIDEO_ENCODE_READ                                  = 0x00000010,
    D3D12_BARRIER_LAYOUT_VIDEO_ENCODE_WRITE                                 = 0x00000011,
    D3D12_BARRIER_LAYOUT_DIRECT_QUEUE_COMMON                                = 0x00000012,
    D3D12_BARRIER_LAYOUT_DIRECT_QUEUE_GENERIC_READ                          = 0x00000013,
    D3D12_BARRIER_LAYOUT_DIRECT_QUEUE_UNORDERED_ACCESS                      = 0x00000014,
    D3D12_BARRIER_LAYOUT_DIRECT_QUEUE_SHADER_RESOURCE                       = 0x00000015,
    D3D12_BARRIER_LAYOUT_DIRECT_QUEUE_COPY_SOURCE                           = 0x00000016,
    D3D12_BARRIER_LAYOUT_DIRECT_QUEUE_COPY_DEST                             = 0x00000017,
    D3D12_BARRIER_LAYOUT_COMPUTE_QUEUE_COMMON                               = 0x00000018,
    D3D12_BARRIER_LAYOUT_COMPUTE_QUEUE_GENERIC_READ                         = 0x00000019,
    D3D12_BARRIER_LAYOUT_COMPUTE_QUEUE_UNORDERED_ACCESS                     = 0x0000001a,
    D3D12_BARRIER_LAYOUT_COMPUTE_QUEUE_SHADER_RESOURCE                      = 0x0000001b,
    D3D12_BARRIER_LAYOUT_COMPUTE_QUEUE_COPY_SOURCE                          = 0x0000001c,
    D3D12_BARRIER_LAYOUT_COMPUTE_QUEUE_COPY_DEST                            = 0x0000001d,
    D3D12_BARRIER_LAYOUT_DIRECT_QUEUE_GENERIC_READ_COMPUTE_QUEUE_ACCESSIBLE = 0x0000001f,
}

alias D3D12_BARRIER_SYNC = int;
enum : int
{
    D3D12_BARRIER_SYNC_NONE                                                  = 0x00000000,
    D3D12_BARRIER_SYNC_ALL                                                   = 0x00000001,
    D3D12_BARRIER_SYNC_DRAW                                                  = 0x00000002,
    D3D12_BARRIER_SYNC_INDEX_INPUT                                           = 0x00000004,
    D3D12_BARRIER_SYNC_VERTEX_SHADING                                        = 0x00000008,
    D3D12_BARRIER_SYNC_PIXEL_SHADING                                         = 0x00000010,
    D3D12_BARRIER_SYNC_DEPTH_STENCIL                                         = 0x00000020,
    D3D12_BARRIER_SYNC_RENDER_TARGET                                         = 0x00000040,
    D3D12_BARRIER_SYNC_COMPUTE_SHADING                                       = 0x00000080,
    D3D12_BARRIER_SYNC_RAYTRACING                                            = 0x00000100,
    D3D12_BARRIER_SYNC_COPY                                                  = 0x00000200,
    D3D12_BARRIER_SYNC_RESOLVE                                               = 0x00000400,
    D3D12_BARRIER_SYNC_EXECUTE_INDIRECT                                      = 0x00000800,
    D3D12_BARRIER_SYNC_PREDICATION                                           = 0x00000800,
    D3D12_BARRIER_SYNC_ALL_SHADING                                           = 0x00001000,
    D3D12_BARRIER_SYNC_NON_PIXEL_SHADING                                     = 0x00002000,
    D3D12_BARRIER_SYNC_EMIT_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO = 0x00004000,
    D3D12_BARRIER_SYNC_CLEAR_UNORDERED_ACCESS_VIEW                           = 0x00008000,
    D3D12_BARRIER_SYNC_VIDEO_DECODE                                          = 0x00100000,
    D3D12_BARRIER_SYNC_VIDEO_PROCESS                                         = 0x00200000,
    D3D12_BARRIER_SYNC_VIDEO_ENCODE                                          = 0x00400000,
    D3D12_BARRIER_SYNC_BUILD_RAYTRACING_ACCELERATION_STRUCTURE               = 0x00800000,
    D3D12_BARRIER_SYNC_COPY_RAYTRACING_ACCELERATION_STRUCTURE                = 0x01000000,
    D3D12_BARRIER_SYNC_SPLIT                                                 = 0x80000000,
}

alias D3D12_BARRIER_ACCESS = int;
enum : int
{
    D3D12_BARRIER_ACCESS_COMMON                                  = 0x00000000,
    D3D12_BARRIER_ACCESS_VERTEX_BUFFER                           = 0x00000001,
    D3D12_BARRIER_ACCESS_CONSTANT_BUFFER                         = 0x00000002,
    D3D12_BARRIER_ACCESS_INDEX_BUFFER                            = 0x00000004,
    D3D12_BARRIER_ACCESS_RENDER_TARGET                           = 0x00000008,
    D3D12_BARRIER_ACCESS_UNORDERED_ACCESS                        = 0x00000010,
    D3D12_BARRIER_ACCESS_DEPTH_STENCIL_WRITE                     = 0x00000020,
    D3D12_BARRIER_ACCESS_DEPTH_STENCIL_READ                      = 0x00000040,
    D3D12_BARRIER_ACCESS_SHADER_RESOURCE                         = 0x00000080,
    D3D12_BARRIER_ACCESS_STREAM_OUTPUT                           = 0x00000100,
    D3D12_BARRIER_ACCESS_INDIRECT_ARGUMENT                       = 0x00000200,
    D3D12_BARRIER_ACCESS_PREDICATION                             = 0x00000200,
    D3D12_BARRIER_ACCESS_COPY_DEST                               = 0x00000400,
    D3D12_BARRIER_ACCESS_COPY_SOURCE                             = 0x00000800,
    D3D12_BARRIER_ACCESS_RESOLVE_DEST                            = 0x00001000,
    D3D12_BARRIER_ACCESS_RESOLVE_SOURCE                          = 0x00002000,
    D3D12_BARRIER_ACCESS_RAYTRACING_ACCELERATION_STRUCTURE_READ  = 0x00004000,
    D3D12_BARRIER_ACCESS_RAYTRACING_ACCELERATION_STRUCTURE_WRITE = 0x00008000,
    D3D12_BARRIER_ACCESS_SHADING_RATE_SOURCE                     = 0x00010000,
    D3D12_BARRIER_ACCESS_VIDEO_DECODE_READ                       = 0x00020000,
    D3D12_BARRIER_ACCESS_VIDEO_DECODE_WRITE                      = 0x00040000,
    D3D12_BARRIER_ACCESS_VIDEO_PROCESS_READ                      = 0x00080000,
    D3D12_BARRIER_ACCESS_VIDEO_PROCESS_WRITE                     = 0x00100000,
    D3D12_BARRIER_ACCESS_VIDEO_ENCODE_READ                       = 0x00200000,
    D3D12_BARRIER_ACCESS_VIDEO_ENCODE_WRITE                      = 0x00400000,
    D3D12_BARRIER_ACCESS_NO_ACCESS                               = 0x80000000,
}

alias D3D12_BARRIER_TYPE = int;
enum : int
{
    D3D12_BARRIER_TYPE_GLOBAL  = 0x00000000,
    D3D12_BARRIER_TYPE_TEXTURE = 0x00000001,
    D3D12_BARRIER_TYPE_BUFFER  = 0x00000002,
}

alias D3D12_TEXTURE_BARRIER_FLAGS = int;
enum : int
{
    D3D12_TEXTURE_BARRIER_FLAG_NONE    = 0x00000000,
    D3D12_TEXTURE_BARRIER_FLAG_DISCARD = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shader_cache_kind_flags
alias D3D12_SHADER_CACHE_KIND_FLAGS = int;
enum : int
{
    D3D12_SHADER_CACHE_KIND_FLAG_IMPLICIT_D3D_CACHE_FOR_DRIVER = 0x00000001,
    D3D12_SHADER_CACHE_KIND_FLAG_IMPLICIT_D3D_CONVERSIONS      = 0x00000002,
    D3D12_SHADER_CACHE_KIND_FLAG_IMPLICIT_DRIVER_MANAGED       = 0x00000004,
    D3D12_SHADER_CACHE_KIND_FLAG_APPLICATION_MANAGED           = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shader_cache_control_flags
alias D3D12_SHADER_CACHE_CONTROL_FLAGS = int;
enum : int
{
    D3D12_SHADER_CACHE_CONTROL_FLAG_DISABLE = 0x00000001,
    D3D12_SHADER_CACHE_CONTROL_FLAG_ENABLE  = 0x00000002,
    D3D12_SHADER_CACHE_CONTROL_FLAG_CLEAR   = 0x00000004,
}

alias D3D12_TRIM_NOTIFICATION_FLAGS = int;
enum : int
{
    D3D12_TRIM_NOTIFICATION_FLAG_NONE                  = 0x00000000,
    D3D12_TRIM_NOTIFICATION_FLAG_PERIODIC_TRIM         = 0x00000001,
    D3D12_TRIM_NOTIFICATION_FLAG_RESTART_PERIODIC_TRIM = 0x00000002,
    D3D12_TRIM_NOTIFICATION_FLAG_TRIM_TO_BUDGET        = 0x00000004,
}

alias D3D12_QUERY_HEAP_FLAGS = int;
enum : int
{
    D3D12_QUERY_HEAP_FLAG_NONE        = 0x00000000,
    D3D12_QUERY_HEAP_FLAG_CPU_RESOLVE = 0x00000001,
}

alias D3D12_APPLICATION_SPECIFIC_DRIVER_BLOB_STATUS = int;
enum : int
{
    D3D12_APPLICATION_SPECIFIC_DRIVER_BLOB_UNKNOWN       = 0x00000001,
    D3D12_APPLICATION_SPECIFIC_DRIVER_BLOB_USED          = 0x00000002,
    D3D12_APPLICATION_SPECIFIC_DRIVER_BLOB_IGNORED       = 0x00000003,
    D3D12_APPLICATION_SPECIFIC_DRIVER_BLOB_NOT_SPECIFIED = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ne-d3d12sdklayers-d3d12_gpu_based_validation_flags
alias D3D12_GPU_BASED_VALIDATION_FLAGS = int;
enum : int
{
    D3D12_GPU_BASED_VALIDATION_FLAGS_NONE                   = 0x00000000,
    D3D12_GPU_BASED_VALIDATION_FLAGS_DISABLE_STATE_TRACKING = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ne-d3d12sdklayers-d3d12_rldo_flags
alias D3D12_RLDO_FLAGS = int;
enum : int
{
    D3D12_RLDO_NONE            = 0x00000000,
    D3D12_RLDO_SUMMARY         = 0x00000001,
    D3D12_RLDO_DETAIL          = 0x00000002,
    D3D12_RLDO_IGNORE_INTERNAL = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ne-d3d12sdklayers-d3d12_debug_device_parameter_type
alias D3D12_DEBUG_DEVICE_PARAMETER_TYPE = int;
enum : int
{
    D3D12_DEBUG_DEVICE_PARAMETER_FEATURE_FLAGS                   = 0x00000000,
    D3D12_DEBUG_DEVICE_PARAMETER_GPU_BASED_VALIDATION_SETTINGS   = 0x00000001,
    D3D12_DEBUG_DEVICE_PARAMETER_GPU_SLOWDOWN_PERFORMANCE_FACTOR = 0x00000002,
    D3D12_DEBUG_DEVICE_PARAMETER_BYTECODE_VALIDATION_MODE        = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ne-d3d12sdklayers-d3d12_debug_feature
alias D3D12_DEBUG_FEATURE = int;
enum : int
{
    D3D12_DEBUG_FEATURE_NONE                                   = 0x00000000,
    D3D12_DEBUG_FEATURE_ALLOW_BEHAVIOR_CHANGING_DEBUG_AIDS     = 0x00000001,
    D3D12_DEBUG_FEATURE_CONSERVATIVE_RESOURCE_STATE_TRACKING   = 0x00000002,
    D3D12_DEBUG_FEATURE_DISABLE_VIRTUALIZED_BUNDLES_VALIDATION = 0x00000004,
    D3D12_DEBUG_FEATURE_EMULATE_WINDOWS7                       = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ne-d3d12sdklayers-d3d12_gpu_based_validation_shader_patch_mode
alias D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE = int;
enum : int
{
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_NONE                 = 0x00000000,
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_STATE_TRACKING_ONLY  = 0x00000001,
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_UNGUARDED_VALIDATION = 0x00000002,
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_GUARDED_VALIDATION   = 0x00000003,
    NUM_D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODES                 = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ne-d3d12sdklayers-d3d12_gpu_based_validation_pipeline_state_create_flags
alias D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS = int;
enum : int
{
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_NONE                                           = 0x00000000,
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_FRONT_LOAD_CREATE_TRACKING_ONLY_SHADERS        = 0x00000001,
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_FRONT_LOAD_CREATE_UNGUARDED_VALIDATION_SHADERS = 0x00000002,
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_FRONT_LOAD_CREATE_GUARDED_VALIDATION_SHADERS   = 0x00000004,
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS_VALID_MASK                                    = 0x00000007,
}

alias D3D12_DEBUG_DEVICE_BYTECODE_VALIDATION_MODE = int;
enum : int
{
    D3D12_DEBUG_DEVICE_BYTECODE_VALIDATION_DISABLED           = 0x00000000,
    D3D12_DEBUG_DEVICE_BYTECODE_VALIDATION_WHEN_HASH_BYPASSED = 0x00000001,
    D3D12_DEBUG_DEVICE_BYTECODE_VALIDATION_ALL_BYTECODE       = 0x00000002,
    D3D12_DEBUG_DEVICE_BYTECODE_VALIDATION_MODE_DEFAULT       = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ne-d3d12sdklayers-d3d12_debug_command_list_parameter_type
alias D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE = int;
enum : int
{
    D3D12_DEBUG_COMMAND_LIST_PARAMETER_GPU_BASED_VALIDATION_SETTINGS = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ne-d3d12sdklayers-d3d12_message_category
alias D3D12_MESSAGE_CATEGORY = int;
enum : int
{
    D3D12_MESSAGE_CATEGORY_APPLICATION_DEFINED   = 0x00000000,
    D3D12_MESSAGE_CATEGORY_MISCELLANEOUS         = 0x00000001,
    D3D12_MESSAGE_CATEGORY_INITIALIZATION        = 0x00000002,
    D3D12_MESSAGE_CATEGORY_CLEANUP               = 0x00000003,
    D3D12_MESSAGE_CATEGORY_COMPILATION           = 0x00000004,
    D3D12_MESSAGE_CATEGORY_STATE_CREATION        = 0x00000005,
    D3D12_MESSAGE_CATEGORY_STATE_SETTING         = 0x00000006,
    D3D12_MESSAGE_CATEGORY_STATE_GETTING         = 0x00000007,
    D3D12_MESSAGE_CATEGORY_RESOURCE_MANIPULATION = 0x00000008,
    D3D12_MESSAGE_CATEGORY_EXECUTION             = 0x00000009,
    D3D12_MESSAGE_CATEGORY_SHADER                = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ne-d3d12sdklayers-d3d12_message_severity
alias D3D12_MESSAGE_SEVERITY = int;
enum : int
{
    D3D12_MESSAGE_SEVERITY_CORRUPTION = 0x00000000,
    D3D12_MESSAGE_SEVERITY_ERROR      = 0x00000001,
    D3D12_MESSAGE_SEVERITY_WARNING    = 0x00000002,
    D3D12_MESSAGE_SEVERITY_INFO       = 0x00000003,
    D3D12_MESSAGE_SEVERITY_MESSAGE    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ne-d3d12sdklayers-d3d12_message_id
alias D3D12_MESSAGE_ID = int;
enum : int
{
    D3D12_MESSAGE_ID_UNKNOWN                                                                                       = 0x00000000,
    D3D12_MESSAGE_ID_STRING_FROM_APPLICATION                                                                       = 0x00000001,
    D3D12_MESSAGE_ID_CORRUPTED_THIS                                                                                = 0x00000002,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER1                                                                          = 0x00000003,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER2                                                                          = 0x00000004,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER3                                                                          = 0x00000005,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER4                                                                          = 0x00000006,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER5                                                                          = 0x00000007,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER6                                                                          = 0x00000008,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER7                                                                          = 0x00000009,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER8                                                                          = 0x0000000a,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER9                                                                          = 0x0000000b,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER10                                                                         = 0x0000000c,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER11                                                                         = 0x0000000d,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER12                                                                         = 0x0000000e,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER13                                                                         = 0x0000000f,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER14                                                                         = 0x00000010,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER15                                                                         = 0x00000011,
    D3D12_MESSAGE_ID_CORRUPTED_MULTITHREADING                                                                      = 0x00000012,
    D3D12_MESSAGE_ID_MESSAGE_REPORTING_OUTOFMEMORY                                                                 = 0x00000013,
    D3D12_MESSAGE_ID_GETPRIVATEDATA_MOREDATA                                                                       = 0x00000014,
    D3D12_MESSAGE_ID_SETPRIVATEDATA_INVALIDFREEDATA                                                                = 0x00000015,
    D3D12_MESSAGE_ID_SETPRIVATEDATA_CHANGINGPARAMS                                                                 = 0x00000018,
    D3D12_MESSAGE_ID_SETPRIVATEDATA_OUTOFMEMORY                                                                    = 0x00000019,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT                                                   = 0x0000001a,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDESC                                                          = 0x0000001b,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFORMAT                                                        = 0x0000001c,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDVIDEOPLANESLICE                                               = 0x0000001d,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDPLANESLICE                                                    = 0x0000001e,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS                                                    = 0x0000001f,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDRESOURCE                                                      = 0x00000020,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT                                                     = 0x00000023,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT                                                      = 0x00000024,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDESC                                                            = 0x00000025,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDFORMAT                                                          = 0x00000026,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDVIDEOPLANESLICE                                                 = 0x00000027,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDPLANESLICE                                                      = 0x00000028,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDIMENSIONS                                                      = 0x00000029,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDRESOURCE                                                        = 0x0000002a,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT                                                     = 0x0000002d,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDESC                                                            = 0x0000002e,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFORMAT                                                          = 0x0000002f,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS                                                      = 0x00000030,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE                                                        = 0x00000031,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_OUTOFMEMORY                                                                 = 0x00000034,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_TOOMANYELEMENTS                                                             = 0x00000035,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDFORMAT                                                               = 0x00000036,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT                                                          = 0x00000037,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOT                                                                 = 0x00000038,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS                                                       = 0x00000039,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH                                                   = 0x0000003a,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE                                                      = 0x0000003b,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE                                                       = 0x0000003c,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDALIGNMENT                                                            = 0x0000003d,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_DUPLICATESEMANTIC                                                           = 0x0000003e,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE                                                   = 0x0000003f,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_NULLSEMANTIC                                                                = 0x00000040,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_MISSINGELEMENT                                                              = 0x00000041,
    D3D12_MESSAGE_ID_CREATEVERTEXSHADER_OUTOFMEMORY                                                                = 0x00000042,
    D3D12_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERBYTECODE                                                      = 0x00000043,
    D3D12_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERTYPE                                                          = 0x00000044,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADER_OUTOFMEMORY                                                              = 0x00000045,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE                                                    = 0x00000046,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERTYPE                                                        = 0x00000047,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY                                              = 0x00000048,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE                                    = 0x00000049,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE                                        = 0x0000004a,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES                                        = 0x0000004b,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED                                 = 0x0000004c,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED                                      = 0x0000004f,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT                                        = 0x00000050,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT                                    = 0x00000051,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT                                    = 0x00000052,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT                   = 0x00000053,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION                                     = 0x00000054,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT                                           = 0x00000055,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE                                = 0x00000056,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC                                          = 0x00000057,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH                                             = 0x00000058,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS                                         = 0x00000059,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX                                           = 0x0000005a,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE                                   = 0x0000005b,
    D3D12_MESSAGE_ID_CREATEPIXELSHADER_OUTOFMEMORY                                                                 = 0x0000005c,
    D3D12_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERBYTECODE                                                       = 0x0000005d,
    D3D12_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERTYPE                                                           = 0x0000005e,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFILLMODE                                                         = 0x0000005f,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDCULLMODE                                                         = 0x00000060,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP                                                   = 0x00000061,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS                                             = 0x00000062,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK                                                 = 0x00000064,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC                                                      = 0x00000065,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP                                         = 0x00000066,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP                                        = 0x00000067,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP                                         = 0x00000068,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC                                           = 0x00000069,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP                                          = 0x0000006a,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP                                         = 0x0000006b,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP                                          = 0x0000006c,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC                                            = 0x0000006d,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLEND                                                              = 0x0000006f,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLEND                                                             = 0x00000070,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOP                                                               = 0x00000071,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLENDALPHA                                                         = 0x00000072,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLENDALPHA                                                        = 0x00000073,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOPALPHA                                                          = 0x00000074,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK                                                 = 0x00000075,
    D3D12_MESSAGE_ID_GET_PROGRAM_IDENTIFIER_ERROR                                                                  = 0x00000076,
    D3D12_MESSAGE_ID_GET_WORK_GRAPH_PROPERTIES_ERROR                                                               = 0x00000077,
    D3D12_MESSAGE_ID_SET_PROGRAM_ERROR                                                                             = 0x00000078,
    D3D12_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_INVALID                                                                 = 0x00000087,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_ROOT_SIGNATURE_NOT_SET                                                      = 0x000000c8,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_ROOT_SIGNATURE_MISMATCH                                                     = 0x000000c9,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_VERTEX_BUFFER_NOT_SET                                                       = 0x000000ca,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL                                              = 0x000000d1,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_VERTEX_BUFFER_TOO_SMALL                                                     = 0x000000d2,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INDEX_BUFFER_NOT_SET                                                        = 0x000000d3,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INDEX_BUFFER_FORMAT_INVALID                                                 = 0x000000d4,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INDEX_BUFFER_TOO_SMALL                                                      = 0x000000d5,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INVALID_PRIMITIVETOPOLOGY                                                   = 0x000000db,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_VERTEX_STRIDE_UNALIGNED                                                     = 0x000000dd,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INDEX_OFFSET_UNALIGNED                                                      = 0x000000de,
    D3D12_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_AT_FAULT                                                               = 0x000000e8,
    D3D12_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT                                                      = 0x000000e9,
    D3D12_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT                                                           = 0x000000ea,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC                                                  = 0x000000ef,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC                               = 0x000000f0,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_TYPE_MISMATCH                                                               = 0x000000f5,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_EMPTY_LAYOUT                                                                = 0x000000fd,
    D3D12_MESSAGE_ID_LIVE_OBJECT_SUMMARY                                                                           = 0x000000ff,
    D3D12_MESSAGE_ID_LIVE_DEVICE                                                                                   = 0x00000112,
    D3D12_MESSAGE_ID_LIVE_SWAPCHAIN                                                                                = 0x00000113,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFLAGS                                                           = 0x00000114,
    D3D12_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDCLASSLINKAGE                                                        = 0x00000115,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDCLASSLINKAGE                                                      = 0x00000116,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAMTORASTERIZER                                = 0x00000118,
    D3D12_MESSAGE_ID_CREATEPIXELSHADER_INVALIDCLASSLINKAGE                                                         = 0x0000011b,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAM                                            = 0x0000011c,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDENTRIES                                        = 0x0000011d,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTRIDES                                        = 0x0000011e,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTRIDES                                        = 0x0000011f,
    D3D12_MESSAGE_ID_CREATEHULLSHADER_OUTOFMEMORY                                                                  = 0x00000121,
    D3D12_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERBYTECODE                                                        = 0x00000122,
    D3D12_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERTYPE                                                            = 0x00000123,
    D3D12_MESSAGE_ID_CREATEHULLSHADER_INVALIDCLASSLINKAGE                                                          = 0x00000124,
    D3D12_MESSAGE_ID_CREATEDOMAINSHADER_OUTOFMEMORY                                                                = 0x00000126,
    D3D12_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERBYTECODE                                                      = 0x00000127,
    D3D12_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERTYPE                                                          = 0x00000128,
    D3D12_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDCLASSLINKAGE                                                        = 0x00000129,
    D3D12_MESSAGE_ID_RESOURCE_UNMAP_NOTMAPPED                                                                      = 0x00000136,
    D3D12_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_MISMATCHED_DATA_SIZE                                               = 0x0000013e,
    D3D12_MESSAGE_ID_CREATECOMPUTESHADER_OUTOFMEMORY                                                               = 0x00000141,
    D3D12_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDSHADERBYTECODE                                                     = 0x00000142,
    D3D12_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDCLASSLINKAGE                                                       = 0x00000143,
    D3D12_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEFLOATOPSNOTSUPPORTED                                          = 0x0000014b,
    D3D12_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEFLOATOPSNOTSUPPORTED                                            = 0x0000014c,
    D3D12_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEFLOATOPSNOTSUPPORTED                                          = 0x0000014d,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEFLOATOPSNOTSUPPORTED                                        = 0x0000014e,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEFLOATOPSNOTSUPPORTED                        = 0x0000014f,
    D3D12_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEFLOATOPSNOTSUPPORTED                                           = 0x00000150,
    D3D12_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEFLOATOPSNOTSUPPORTED                                         = 0x00000151,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDRESOURCE                                                     = 0x00000154,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDESC                                                         = 0x00000155,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFORMAT                                                       = 0x00000156,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDVIDEOPLANESLICE                                              = 0x00000157,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDPLANESLICE                                                   = 0x00000158,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDIMENSIONS                                                   = 0x00000159,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_UNRECOGNIZEDFORMAT                                                  = 0x0000015a,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFLAGS                                                        = 0x00000162,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFORCEDSAMPLECOUNT                                                = 0x00000191,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDLOGICOPS                                                              = 0x00000193,
    D3D12_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                        = 0x0000019a,
    D3D12_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                          = 0x0000019c,
    D3D12_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                        = 0x0000019e,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                      = 0x000001a0,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEEXTENSIONSNOTSUPPORTED                      = 0x000001a2,
    D3D12_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                         = 0x000001a4,
    D3D12_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                       = 0x000001a6,
    D3D12_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_UAVSNOTSUPPORTED                                                    = 0x000001a9,
    D3D12_MESSAGE_ID_DEVICE_CREATEHULLSHADER_UAVSNOTSUPPORTED                                                      = 0x000001aa,
    D3D12_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_UAVSNOTSUPPORTED                                                    = 0x000001ab,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_UAVSNOTSUPPORTED                                                  = 0x000001ac,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UAVSNOTSUPPORTED                                  = 0x000001ad,
    D3D12_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_UAVSNOTSUPPORTED                                                     = 0x000001ae,
    D3D12_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_UAVSNOTSUPPORTED                                                   = 0x000001af,
    D3D12_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDSOURCERECT                                                            = 0x000001bf,
    D3D12_MESSAGE_ID_DEVICE_CLEARVIEW_EMPTYRECT                                                                    = 0x000001c0,
    D3D12_MESSAGE_ID_UPDATETILEMAPPINGS_INVALID_PARAMETER                                                          = 0x000001ed,
    D3D12_MESSAGE_ID_COPYTILEMAPPINGS_INVALID_PARAMETER                                                            = 0x000001ee,
    D3D12_MESSAGE_ID_CREATEDEVICE_INVALIDARGS                                                                      = 0x000001fa,
    D3D12_MESSAGE_ID_CREATEDEVICE_WARNING                                                                          = 0x000001fb,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_TYPE                                                                 = 0x00000207,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_NULL_POINTER                                                                 = 0x00000208,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_SUBRESOURCE                                                          = 0x00000209,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_RESERVED_BITS                                                                = 0x0000020a,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_MISSING_BIND_FLAGS                                                           = 0x0000020b,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_MISMATCHING_MISC_FLAGS                                                       = 0x0000020c,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_MATCHING_STATES                                                              = 0x0000020d,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_COMBINATION                                                          = 0x0000020e,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_BEFORE_AFTER_MISMATCH                                                        = 0x0000020f,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_RESOURCE                                                             = 0x00000210,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_SAMPLE_COUNT                                                                 = 0x00000211,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_FLAGS                                                                = 0x00000212,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_COMBINED_FLAGS                                                       = 0x00000213,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_FLAGS_FOR_FORMAT                                                     = 0x00000214,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_SPLIT_BARRIER                                                        = 0x00000215,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_UNMATCHED_END                                                                = 0x00000216,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_UNMATCHED_BEGIN                                                              = 0x00000217,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_FLAG                                                                 = 0x00000218,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_COMMAND_LIST_TYPE                                                    = 0x00000219,
    D3D12_MESSAGE_ID_INVALID_SUBRESOURCE_STATE                                                                     = 0x0000021a,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_CONTENTION                                                                  = 0x0000021c,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_RESET                                                                       = 0x0000021d,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_RESET_BUNDLE                                                                = 0x0000021e,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_CANNOT_RESET                                                                = 0x0000021f,
    D3D12_MESSAGE_ID_COMMAND_LIST_OPEN                                                                             = 0x00000220,
    D3D12_MESSAGE_ID_INVALID_BUNDLE_API                                                                            = 0x00000222,
    D3D12_MESSAGE_ID_COMMAND_LIST_CLOSED                                                                           = 0x00000223,
    D3D12_MESSAGE_ID_WRONG_COMMAND_ALLOCATOR_TYPE                                                                  = 0x00000225,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_SYNC                                                                        = 0x00000228,
    D3D12_MESSAGE_ID_COMMAND_LIST_SYNC                                                                             = 0x00000229,
    D3D12_MESSAGE_ID_SET_DESCRIPTOR_HEAP_INVALID                                                                   = 0x0000022a,
    D3D12_MESSAGE_ID_CREATE_COMMANDQUEUE                                                                           = 0x0000022d,
    D3D12_MESSAGE_ID_CREATE_COMMANDALLOCATOR                                                                       = 0x0000022e,
    D3D12_MESSAGE_ID_CREATE_PIPELINESTATE                                                                          = 0x0000022f,
    D3D12_MESSAGE_ID_CREATE_COMMANDLIST12                                                                          = 0x00000230,
    D3D12_MESSAGE_ID_CREATE_RESOURCE                                                                               = 0x00000232,
    D3D12_MESSAGE_ID_CREATE_DESCRIPTORHEAP                                                                         = 0x00000233,
    D3D12_MESSAGE_ID_CREATE_ROOTSIGNATURE                                                                          = 0x00000234,
    D3D12_MESSAGE_ID_CREATE_LIBRARY                                                                                = 0x00000235,
    D3D12_MESSAGE_ID_CREATE_HEAP                                                                                   = 0x00000236,
    D3D12_MESSAGE_ID_CREATE_MONITOREDFENCE                                                                         = 0x00000237,
    D3D12_MESSAGE_ID_CREATE_QUERYHEAP                                                                              = 0x00000238,
    D3D12_MESSAGE_ID_CREATE_COMMANDSIGNATURE                                                                       = 0x00000239,
    D3D12_MESSAGE_ID_LIVE_COMMANDQUEUE                                                                             = 0x0000023a,
    D3D12_MESSAGE_ID_LIVE_COMMANDALLOCATOR                                                                         = 0x0000023b,
    D3D12_MESSAGE_ID_LIVE_PIPELINESTATE                                                                            = 0x0000023c,
    D3D12_MESSAGE_ID_LIVE_COMMANDLIST12                                                                            = 0x0000023d,
    D3D12_MESSAGE_ID_LIVE_RESOURCE                                                                                 = 0x0000023f,
    D3D12_MESSAGE_ID_LIVE_DESCRIPTORHEAP                                                                           = 0x00000240,
    D3D12_MESSAGE_ID_LIVE_ROOTSIGNATURE                                                                            = 0x00000241,
    D3D12_MESSAGE_ID_LIVE_LIBRARY                                                                                  = 0x00000242,
    D3D12_MESSAGE_ID_LIVE_HEAP                                                                                     = 0x00000243,
    D3D12_MESSAGE_ID_LIVE_MONITOREDFENCE                                                                           = 0x00000244,
    D3D12_MESSAGE_ID_LIVE_QUERYHEAP                                                                                = 0x00000245,
    D3D12_MESSAGE_ID_LIVE_COMMANDSIGNATURE                                                                         = 0x00000246,
    D3D12_MESSAGE_ID_DESTROY_COMMANDQUEUE                                                                          = 0x00000247,
    D3D12_MESSAGE_ID_DESTROY_COMMANDALLOCATOR                                                                      = 0x00000248,
    D3D12_MESSAGE_ID_DESTROY_PIPELINESTATE                                                                         = 0x00000249,
    D3D12_MESSAGE_ID_DESTROY_COMMANDLIST12                                                                         = 0x0000024a,
    D3D12_MESSAGE_ID_DESTROY_RESOURCE                                                                              = 0x0000024c,
    D3D12_MESSAGE_ID_DESTROY_DESCRIPTORHEAP                                                                        = 0x0000024d,
    D3D12_MESSAGE_ID_DESTROY_ROOTSIGNATURE                                                                         = 0x0000024e,
    D3D12_MESSAGE_ID_DESTROY_LIBRARY                                                                               = 0x0000024f,
    D3D12_MESSAGE_ID_DESTROY_HEAP                                                                                  = 0x00000250,
    D3D12_MESSAGE_ID_DESTROY_MONITOREDFENCE                                                                        = 0x00000251,
    D3D12_MESSAGE_ID_DESTROY_QUERYHEAP                                                                             = 0x00000252,
    D3D12_MESSAGE_ID_DESTROY_COMMANDSIGNATURE                                                                      = 0x00000253,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDDIMENSIONS                                                              = 0x00000255,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDMISCFLAGS                                                               = 0x00000257,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDARG_RETURN                                                              = 0x0000025a,
    D3D12_MESSAGE_ID_CREATERESOURCE_OUTOFMEMORY_RETURN                                                             = 0x0000025b,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDDESC                                                                    = 0x0000025c,
    D3D12_MESSAGE_ID_POSSIBLY_INVALID_SUBRESOURCE_STATE                                                            = 0x0000025f,
    D3D12_MESSAGE_ID_INVALID_USE_OF_NON_RESIDENT_RESOURCE                                                          = 0x00000260,
    D3D12_MESSAGE_ID_POSSIBLE_INVALID_USE_OF_NON_RESIDENT_RESOURCE                                                 = 0x00000261,
    D3D12_MESSAGE_ID_BUNDLE_PIPELINE_STATE_MISMATCH                                                                = 0x00000262,
    D3D12_MESSAGE_ID_PRIMITIVE_TOPOLOGY_MISMATCH_PIPELINE_STATE                                                    = 0x00000263,
    D3D12_MESSAGE_ID_RENDER_TARGET_FORMAT_MISMATCH_PIPELINE_STATE                                                  = 0x00000265,
    D3D12_MESSAGE_ID_RENDER_TARGET_SAMPLE_DESC_MISMATCH_PIPELINE_STATE                                             = 0x00000266,
    D3D12_MESSAGE_ID_DEPTH_STENCIL_FORMAT_MISMATCH_PIPELINE_STATE                                                  = 0x00000267,
    D3D12_MESSAGE_ID_DEPTH_STENCIL_SAMPLE_DESC_MISMATCH_PIPELINE_STATE                                             = 0x00000268,
    D3D12_MESSAGE_ID_CREATESHADER_INVALIDBYTECODE                                                                  = 0x0000026e,
    D3D12_MESSAGE_ID_CREATEHEAP_NULLDESC                                                                           = 0x0000026f,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDSIZE                                                                        = 0x00000270,
    D3D12_MESSAGE_ID_CREATEHEAP_UNRECOGNIZEDHEAPTYPE                                                               = 0x00000271,
    D3D12_MESSAGE_ID_CREATEHEAP_UNRECOGNIZEDCPUPAGEPROPERTIES                                                      = 0x00000272,
    D3D12_MESSAGE_ID_CREATEHEAP_UNRECOGNIZEDMEMORYPOOL                                                             = 0x00000273,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDPROPERTIES                                                                  = 0x00000274,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDALIGNMENT                                                                   = 0x00000275,
    D3D12_MESSAGE_ID_CREATEHEAP_UNRECOGNIZEDMISCFLAGS                                                              = 0x00000276,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDMISCFLAGS                                                                   = 0x00000277,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDARG_RETURN                                                                  = 0x00000278,
    D3D12_MESSAGE_ID_CREATEHEAP_OUTOFMEMORY_RETURN                                                                 = 0x00000279,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_NULLHEAPPROPERTIES                                                      = 0x0000027a,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_UNRECOGNIZEDHEAPTYPE                                                    = 0x0000027b,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_UNRECOGNIZEDCPUPAGEPROPERTIES                                           = 0x0000027c,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_UNRECOGNIZEDMEMORYPOOL                                                  = 0x0000027d,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_INVALIDHEAPPROPERTIES                                                   = 0x0000027e,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_UNRECOGNIZEDHEAPMISCFLAGS                                               = 0x0000027f,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_INVALIDHEAPMISCFLAGS                                                    = 0x00000280,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_INVALIDARG_RETURN                                                       = 0x00000281,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_OUTOFMEMORY_RETURN                                                      = 0x00000282,
    D3D12_MESSAGE_ID_GETCUSTOMHEAPPROPERTIES_UNRECOGNIZEDHEAPTYPE                                                  = 0x00000283,
    D3D12_MESSAGE_ID_GETCUSTOMHEAPPROPERTIES_INVALIDHEAPTYPE                                                       = 0x00000284,
    D3D12_MESSAGE_ID_CREATE_DESCRIPTOR_HEAP_INVALID_DESC                                                           = 0x00000285,
    D3D12_MESSAGE_ID_INVALID_DESCRIPTOR_HANDLE                                                                     = 0x00000286,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALID_CONSERVATIVERASTERMODE                                          = 0x00000287,
    D3D12_MESSAGE_ID_CREATE_CONSTANT_BUFFER_VIEW_INVALID_RESOURCE                                                  = 0x00000289,
    D3D12_MESSAGE_ID_CREATE_CONSTANT_BUFFER_VIEW_INVALID_DESC                                                      = 0x0000028a,
    D3D12_MESSAGE_ID_CREATE_UNORDEREDACCESS_VIEW_INVALID_COUNTER_USAGE                                             = 0x0000028c,
    D3D12_MESSAGE_ID_COPY_DESCRIPTORS_INVALID_RANGES                                                               = 0x0000028d,
    D3D12_MESSAGE_ID_COPY_DESCRIPTORS_WRITE_ONLY_DESCRIPTOR                                                        = 0x0000028e,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_RTV_FORMAT_NOT_UNKNOWN                                            = 0x0000028f,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_RENDER_TARGET_COUNT                                       = 0x00000290,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_VERTEX_SHADER_NOT_SET                                             = 0x00000291,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INPUTLAYOUT_NOT_SET                                               = 0x00000292,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_HS_DS_SIGNATURE_MISMATCH                           = 0x00000293,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_REGISTERINDEX                                      = 0x00000294,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_COMPONENTTYPE                                      = 0x00000295,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_REGISTERMASK                                       = 0x00000296,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_SYSTEMVALUE                                        = 0x00000297,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS                           = 0x00000298,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_MINPRECISION                                       = 0x00000299,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND                             = 0x0000029a,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_HS_XOR_DS_MISMATCH                                                = 0x0000029b,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_HULL_SHADER_INPUT_TOPOLOGY_MISMATCH                               = 0x0000029c,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_HS_DS_CONTROL_POINT_COUNT_MISMATCH                                = 0x0000029d,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_HS_DS_TESSELLATOR_DOMAIN_MISMATCH                                 = 0x0000029e,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN                         = 0x0000029f,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_USE_OF_FORCED_SAMPLE_COUNT                                = 0x000002a0,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_PRIMITIVETOPOLOGY                                         = 0x000002a1,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_SYSTEMVALUE                                               = 0x000002a2,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0             = 0x000002a3,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING                        = 0x000002a4,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_PS_OUTPUT_TYPE_MISMATCH                                           = 0x000002a5,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_OM_RENDER_TARGET_DOES_NOT_SUPPORT_LOGIC_OPS                       = 0x000002a6,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_RENDERTARGETVIEW_NOT_SET                                          = 0x000002a7,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_DEPTHSTENCILVIEW_NOT_SET                                          = 0x000002a8,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_GS_INPUT_PRIMITIVE_MISMATCH                                       = 0x000002a9,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_POSITION_NOT_PRESENT                                              = 0x000002aa,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_MISSING_ROOT_SIGNATURE_FLAGS                                      = 0x000002ab,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_INDEX_BUFFER_PROPERTIES                                   = 0x000002ac,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_SAMPLE_DESC                                               = 0x000002ad,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_HS_ROOT_SIGNATURE_MISMATCH                                        = 0x000002ae,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_DS_ROOT_SIGNATURE_MISMATCH                                        = 0x000002af,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_VS_ROOT_SIGNATURE_MISMATCH                                        = 0x000002b0,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_GS_ROOT_SIGNATURE_MISMATCH                                        = 0x000002b1,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_PS_ROOT_SIGNATURE_MISMATCH                                        = 0x000002b2,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_MISSING_ROOT_SIGNATURE                                            = 0x000002b3,
    D3D12_MESSAGE_ID_EXECUTE_BUNDLE_OPEN_BUNDLE                                                                    = 0x000002b4,
    D3D12_MESSAGE_ID_EXECUTE_BUNDLE_DESCRIPTOR_HEAP_MISMATCH                                                       = 0x000002b5,
    D3D12_MESSAGE_ID_EXECUTE_BUNDLE_TYPE                                                                           = 0x000002b6,
    D3D12_MESSAGE_ID_DRAW_EMPTY_SCISSOR_RECTANGLE                                                                  = 0x000002b7,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_BLOB_NOT_FOUND                                                          = 0x000002b8,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_DESERIALIZE_FAILED                                                      = 0x000002b9,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_INVALID_CONFIGURATION                                                   = 0x000002ba,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_NOT_SUPPORTED_ON_DEVICE                                                 = 0x000002bb,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_NULLRESOURCEPROPERTIES                                                  = 0x000002bc,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_NULLHEAP                                                                = 0x000002bd,
    D3D12_MESSAGE_ID_GETRESOURCEALLOCATIONINFO_INVALIDRDESCS                                                       = 0x000002be,
    D3D12_MESSAGE_ID_MAKERESIDENT_NULLOBJECTARRAY                                                                  = 0x000002bf,
    D3D12_MESSAGE_ID_EVICT_NULLOBJECTARRAY                                                                         = 0x000002c1,
    D3D12_MESSAGE_ID_SET_DESCRIPTOR_TABLE_INVALID                                                                  = 0x000002c4,
    D3D12_MESSAGE_ID_SET_ROOT_CONSTANT_INVALID                                                                     = 0x000002c5,
    D3D12_MESSAGE_ID_SET_ROOT_CONSTANT_BUFFER_VIEW_INVALID                                                         = 0x000002c6,
    D3D12_MESSAGE_ID_SET_ROOT_SHADER_RESOURCE_VIEW_INVALID                                                         = 0x000002c7,
    D3D12_MESSAGE_ID_SET_ROOT_UNORDERED_ACCESS_VIEW_INVALID                                                        = 0x000002c8,
    D3D12_MESSAGE_ID_SET_VERTEX_BUFFERS_INVALID_DESC                                                               = 0x000002c9,
    D3D12_MESSAGE_ID_SET_INDEX_BUFFER_INVALID_DESC                                                                 = 0x000002cb,
    D3D12_MESSAGE_ID_SET_STREAM_OUTPUT_BUFFERS_INVALID_DESC                                                        = 0x000002cd,
    D3D12_MESSAGE_ID_CREATERESOURCE_UNRECOGNIZEDDIMENSIONALITY                                                     = 0x000002ce,
    D3D12_MESSAGE_ID_CREATERESOURCE_UNRECOGNIZEDLAYOUT                                                             = 0x000002cf,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDDIMENSIONALITY                                                          = 0x000002d0,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDALIGNMENT                                                               = 0x000002d1,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDMIPLEVELS                                                               = 0x000002d2,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDSAMPLEDESC                                                              = 0x000002d3,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDLAYOUT                                                                  = 0x000002d4,
    D3D12_MESSAGE_ID_SET_INDEX_BUFFER_INVALID                                                                      = 0x000002d5,
    D3D12_MESSAGE_ID_SET_VERTEX_BUFFERS_INVALID                                                                    = 0x000002d6,
    D3D12_MESSAGE_ID_SET_STREAM_OUTPUT_BUFFERS_INVALID                                                             = 0x000002d7,
    D3D12_MESSAGE_ID_SET_RENDER_TARGETS_INVALID                                                                    = 0x000002d8,
    D3D12_MESSAGE_ID_CREATEQUERY_HEAP_INVALID_PARAMETERS                                                           = 0x000002d9,
    D3D12_MESSAGE_ID_BEGIN_END_QUERY_INVALID_PARAMETERS                                                            = 0x000002db,
    D3D12_MESSAGE_ID_CLOSE_COMMAND_LIST_OPEN_QUERY                                                                 = 0x000002dc,
    D3D12_MESSAGE_ID_RESOLVE_QUERY_DATA_INVALID_PARAMETERS                                                         = 0x000002dd,
    D3D12_MESSAGE_ID_SET_PREDICATION_INVALID_PARAMETERS                                                            = 0x000002de,
    D3D12_MESSAGE_ID_TIMESTAMPS_NOT_SUPPORTED                                                                      = 0x000002df,
    D3D12_MESSAGE_ID_CREATERESOURCE_UNRECOGNIZEDFORMAT                                                             = 0x000002e1,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDFORMAT                                                                  = 0x000002e2,
    D3D12_MESSAGE_ID_GETCOPYABLEFOOTPRINTS_INVALIDSUBRESOURCERANGE                                                 = 0x000002e3,
    D3D12_MESSAGE_ID_GETCOPYABLEFOOTPRINTS_INVALIDBASEOFFSET                                                       = 0x000002e4,
    D3D12_MESSAGE_ID_GETCOPYABLELAYOUT_INVALIDSUBRESOURCERANGE                                                     = 0x000002e3,
    D3D12_MESSAGE_ID_GETCOPYABLELAYOUT_INVALIDBASEOFFSET                                                           = 0x000002e4,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_HEAP                                                                 = 0x000002e5,
    D3D12_MESSAGE_ID_CREATE_SAMPLER_INVALID                                                                        = 0x000002e6,
    D3D12_MESSAGE_ID_CREATECOMMANDSIGNATURE_INVALID                                                                = 0x000002e7,
    D3D12_MESSAGE_ID_EXECUTE_INDIRECT_INVALID_PARAMETERS                                                           = 0x000002e8,
    D3D12_MESSAGE_ID_GETGPUVIRTUALADDRESS_INVALID_RESOURCE_DIMENSION                                               = 0x000002e9,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDCLEARVALUE                                                              = 0x0000032f,
    D3D12_MESSAGE_ID_CREATERESOURCE_UNRECOGNIZEDCLEARVALUEFORMAT                                                   = 0x00000330,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDCLEARVALUEFORMAT                                                        = 0x00000331,
    D3D12_MESSAGE_ID_CREATERESOURCE_CLEARVALUEDENORMFLUSH                                                          = 0x00000332,
    D3D12_MESSAGE_ID_CLEARRENDERTARGETVIEW_MISMATCHINGCLEARVALUE                                                   = 0x00000334,
    D3D12_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_MISMATCHINGCLEARVALUE                                                   = 0x00000335,
    D3D12_MESSAGE_ID_MAP_INVALIDHEAP                                                                               = 0x00000336,
    D3D12_MESSAGE_ID_UNMAP_INVALIDHEAP                                                                             = 0x00000337,
    D3D12_MESSAGE_ID_MAP_INVALIDRESOURCE                                                                           = 0x00000338,
    D3D12_MESSAGE_ID_UNMAP_INVALIDRESOURCE                                                                         = 0x00000339,
    D3D12_MESSAGE_ID_MAP_INVALIDSUBRESOURCE                                                                        = 0x0000033a,
    D3D12_MESSAGE_ID_UNMAP_INVALIDSUBRESOURCE                                                                      = 0x0000033b,
    D3D12_MESSAGE_ID_MAP_INVALIDRANGE                                                                              = 0x0000033c,
    D3D12_MESSAGE_ID_UNMAP_INVALIDRANGE                                                                            = 0x0000033d,
    D3D12_MESSAGE_ID_MAP_INVALIDDATAPOINTER                                                                        = 0x00000340,
    D3D12_MESSAGE_ID_MAP_INVALIDARG_RETURN                                                                         = 0x00000341,
    D3D12_MESSAGE_ID_MAP_OUTOFMEMORY_RETURN                                                                        = 0x00000342,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_BUNDLENOTSUPPORTED                                                        = 0x00000343,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_COMMANDLISTMISMATCH                                                       = 0x00000344,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_OPENCOMMANDLIST                                                           = 0x00000345,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_FAILEDCOMMANDLIST                                                         = 0x00000346,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_NULLDST                                                                      = 0x00000347,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_INVALIDDSTRESOURCEDIMENSION                                                  = 0x00000348,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_DSTRANGEOUTOFBOUNDS                                                          = 0x00000349,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_NULLSRC                                                                      = 0x0000034a,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_INVALIDSRCRESOURCEDIMENSION                                                  = 0x0000034b,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_SRCRANGEOUTOFBOUNDS                                                          = 0x0000034c,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_INVALIDCOPYFLAGS                                                             = 0x0000034d,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_NULLDST                                                                     = 0x0000034e,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_UNRECOGNIZEDDSTTYPE                                                         = 0x0000034f,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTRESOURCEDIMENSION                                                 = 0x00000350,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTRESOURCE                                                          = 0x00000351,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTSUBRESOURCE                                                       = 0x00000352,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTOFFSET                                                            = 0x00000353,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_UNRECOGNIZEDDSTFORMAT                                                       = 0x00000354,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTFORMAT                                                            = 0x00000355,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTDIMENSIONS                                                        = 0x00000356,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTROWPITCH                                                          = 0x00000357,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTPLACEMENT                                                         = 0x00000358,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTDSPLACEDFOOTPRINTFORMAT                                           = 0x00000359,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_DSTREGIONOUTOFBOUNDS                                                        = 0x0000035a,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_NULLSRC                                                                     = 0x0000035b,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_UNRECOGNIZEDSRCTYPE                                                         = 0x0000035c,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCRESOURCEDIMENSION                                                 = 0x0000035d,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCRESOURCE                                                          = 0x0000035e,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCSUBRESOURCE                                                       = 0x0000035f,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCOFFSET                                                            = 0x00000360,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_UNRECOGNIZEDSRCFORMAT                                                       = 0x00000361,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCFORMAT                                                            = 0x00000362,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCDIMENSIONS                                                        = 0x00000363,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCROWPITCH                                                          = 0x00000364,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCPLACEMENT                                                         = 0x00000365,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCDSPLACEDFOOTPRINTFORMAT                                           = 0x00000366,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_SRCREGIONOUTOFBOUNDS                                                        = 0x00000367,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTCOORDINATES                                                       = 0x00000368,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCBOX                                                               = 0x00000369,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_FORMATMISMATCH                                                              = 0x0000036a,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_EMPTYBOX                                                                    = 0x0000036b,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDCOPYFLAGS                                                            = 0x0000036c,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_INVALID_SUBRESOURCE_INDEX                                                  = 0x0000036d,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_INVALID_FORMAT                                                             = 0x0000036e,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_RESOURCE_MISMATCH                                                          = 0x0000036f,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_INVALID_SAMPLE_COUNT                                                       = 0x00000370,
    D3D12_MESSAGE_ID_CREATECOMPUTEPIPELINESTATE_INVALID_SHADER                                                     = 0x00000371,
    D3D12_MESSAGE_ID_CREATECOMPUTEPIPELINESTATE_CS_ROOT_SIGNATURE_MISMATCH                                         = 0x00000372,
    D3D12_MESSAGE_ID_CREATECOMPUTEPIPELINESTATE_MISSING_ROOT_SIGNATURE                                             = 0x00000373,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_INVALIDCACHEDBLOB                                                         = 0x00000374,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_CACHEDBLOBADAPTERMISMATCH                                                 = 0x00000375,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_CACHEDBLOBDRIVERVERSIONMISMATCH                                           = 0x00000376,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_CACHEDBLOBDESCMISMATCH                                                    = 0x00000377,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_CACHEDBLOBIGNORED                                                         = 0x00000378,
    D3D12_MESSAGE_ID_WRITETOSUBRESOURCE_INVALIDHEAP                                                                = 0x00000379,
    D3D12_MESSAGE_ID_WRITETOSUBRESOURCE_INVALIDRESOURCE                                                            = 0x0000037a,
    D3D12_MESSAGE_ID_WRITETOSUBRESOURCE_INVALIDBOX                                                                 = 0x0000037b,
    D3D12_MESSAGE_ID_WRITETOSUBRESOURCE_INVALIDSUBRESOURCE                                                         = 0x0000037c,
    D3D12_MESSAGE_ID_WRITETOSUBRESOURCE_EMPTYBOX                                                                   = 0x0000037d,
    D3D12_MESSAGE_ID_READFROMSUBRESOURCE_INVALIDHEAP                                                               = 0x0000037e,
    D3D12_MESSAGE_ID_READFROMSUBRESOURCE_INVALIDRESOURCE                                                           = 0x0000037f,
    D3D12_MESSAGE_ID_READFROMSUBRESOURCE_INVALIDBOX                                                                = 0x00000380,
    D3D12_MESSAGE_ID_READFROMSUBRESOURCE_INVALIDSUBRESOURCE                                                        = 0x00000381,
    D3D12_MESSAGE_ID_READFROMSUBRESOURCE_EMPTYBOX                                                                  = 0x00000382,
    D3D12_MESSAGE_ID_TOO_MANY_NODES_SPECIFIED                                                                      = 0x00000383,
    D3D12_MESSAGE_ID_INVALID_NODE_INDEX                                                                            = 0x00000384,
    D3D12_MESSAGE_ID_GETHEAPPROPERTIES_INVALIDRESOURCE                                                             = 0x00000385,
    D3D12_MESSAGE_ID_NODE_MASK_MISMATCH                                                                            = 0x00000386,
    D3D12_MESSAGE_ID_COMMAND_LIST_OUTOFMEMORY                                                                      = 0x00000387,
    D3D12_MESSAGE_ID_COMMAND_LIST_MULTIPLE_SWAPCHAIN_BUFFER_REFERENCES                                             = 0x00000388,
    D3D12_MESSAGE_ID_COMMAND_LIST_TOO_MANY_SWAPCHAIN_REFERENCES                                                    = 0x00000389,
    D3D12_MESSAGE_ID_COMMAND_QUEUE_TOO_MANY_SWAPCHAIN_REFERENCES                                                   = 0x0000038a,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_WRONGSWAPCHAINBUFFERREFERENCE                                             = 0x0000038b,
    D3D12_MESSAGE_ID_COMMAND_LIST_SETRENDERTARGETS_INVALIDNUMRENDERTARGETS                                         = 0x0000038c,
    D3D12_MESSAGE_ID_CREATE_QUEUE_INVALID_TYPE                                                                     = 0x0000038d,
    D3D12_MESSAGE_ID_CREATE_QUEUE_INVALID_FLAGS                                                                    = 0x0000038e,
    D3D12_MESSAGE_ID_CREATESHAREDRESOURCE_INVALIDFLAGS                                                             = 0x0000038f,
    D3D12_MESSAGE_ID_CREATESHAREDRESOURCE_INVALIDFORMAT                                                            = 0x00000390,
    D3D12_MESSAGE_ID_CREATESHAREDHEAP_INVALIDFLAGS                                                                 = 0x00000391,
    D3D12_MESSAGE_ID_REFLECTSHAREDPROPERTIES_UNRECOGNIZEDPROPERTIES                                                = 0x00000392,
    D3D12_MESSAGE_ID_REFLECTSHAREDPROPERTIES_INVALIDSIZE                                                           = 0x00000393,
    D3D12_MESSAGE_ID_REFLECTSHAREDPROPERTIES_INVALIDOBJECT                                                         = 0x00000394,
    D3D12_MESSAGE_ID_KEYEDMUTEX_INVALIDOBJECT                                                                      = 0x00000395,
    D3D12_MESSAGE_ID_KEYEDMUTEX_INVALIDKEY                                                                         = 0x00000396,
    D3D12_MESSAGE_ID_KEYEDMUTEX_WRONGSTATE                                                                         = 0x00000397,
    D3D12_MESSAGE_ID_CREATE_QUEUE_INVALID_PRIORITY                                                                 = 0x00000398,
    D3D12_MESSAGE_ID_OBJECT_DELETED_WHILE_STILL_IN_USE                                                             = 0x00000399,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_INVALID_FLAGS                                                             = 0x0000039a,
    D3D12_MESSAGE_ID_HEAP_ADDRESS_RANGE_HAS_NO_RESOURCE                                                            = 0x0000039b,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_RENDER_TARGET_DELETED                                                       = 0x0000039c,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_ALL_RENDER_TARGETS_HAVE_UNKNOWN_FORMAT                            = 0x0000039d,
    D3D12_MESSAGE_ID_HEAP_ADDRESS_RANGE_INTERSECTS_MULTIPLE_BUFFERS                                                = 0x0000039e,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_GPU_WRITTEN_READBACK_RESOURCE_MAPPED                                      = 0x0000039f,
    D3D12_MESSAGE_ID_UNMAP_RANGE_NOT_EMPTY                                                                         = 0x000003a1,
    D3D12_MESSAGE_ID_MAP_INVALID_NULLRANGE                                                                         = 0x000003a2,
    D3D12_MESSAGE_ID_UNMAP_INVALID_NULLRANGE                                                                       = 0x000003a3,
    D3D12_MESSAGE_ID_NO_GRAPHICS_API_SUPPORT                                                                       = 0x000003a4,
    D3D12_MESSAGE_ID_NO_COMPUTE_API_SUPPORT                                                                        = 0x000003a5,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_RESOURCE_FLAGS_NOT_SUPPORTED                                               = 0x000003a6,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_ROOT_ARGUMENT_UNINITIALIZED                                              = 0x000003a7,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_DESCRIPTOR_HEAP_INDEX_OUT_OF_BOUNDS                                      = 0x000003a8,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_DESCRIPTOR_TABLE_REGISTER_INDEX_OUT_OF_BOUNDS                            = 0x000003a9,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_DESCRIPTOR_UNINITIALIZED                                                 = 0x000003aa,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_DESCRIPTOR_TYPE_MISMATCH                                                 = 0x000003ab,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_SRV_RESOURCE_DIMENSION_MISMATCH                                          = 0x000003ac,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_UAV_RESOURCE_DIMENSION_MISMATCH                                          = 0x000003ad,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_INCOMPATIBLE_RESOURCE_STATE                                              = 0x000003ae,
    D3D12_MESSAGE_ID_COPYRESOURCE_NULLDST                                                                          = 0x000003af,
    D3D12_MESSAGE_ID_COPYRESOURCE_INVALIDDSTRESOURCE                                                               = 0x000003b0,
    D3D12_MESSAGE_ID_COPYRESOURCE_NULLSRC                                                                          = 0x000003b1,
    D3D12_MESSAGE_ID_COPYRESOURCE_INVALIDSRCRESOURCE                                                               = 0x000003b2,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_NULLDST                                                                    = 0x000003b3,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_INVALIDDSTRESOURCE                                                         = 0x000003b4,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_NULLSRC                                                                    = 0x000003b5,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_INVALIDSRCRESOURCE                                                         = 0x000003b6,
    D3D12_MESSAGE_ID_PIPELINE_STATE_TYPE_MISMATCH                                                                  = 0x000003b7,
    D3D12_MESSAGE_ID_COMMAND_LIST_DISPATCH_ROOT_SIGNATURE_NOT_SET                                                  = 0x000003b8,
    D3D12_MESSAGE_ID_COMMAND_LIST_DISPATCH_ROOT_SIGNATURE_MISMATCH                                                 = 0x000003b9,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_ZERO_BARRIERS                                                                = 0x000003ba,
    D3D12_MESSAGE_ID_BEGIN_END_EVENT_MISMATCH                                                                      = 0x000003bb,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_POSSIBLE_BEFORE_AFTER_MISMATCH                                               = 0x000003bc,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_MISMATCHING_BEGIN_END                                                        = 0x000003bd,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_INVALID_RESOURCE                                                         = 0x000003be,
    D3D12_MESSAGE_ID_USE_OF_ZERO_REFCOUNT_OBJECT                                                                   = 0x000003bf,
    D3D12_MESSAGE_ID_OBJECT_EVICTED_WHILE_STILL_IN_USE                                                             = 0x000003c0,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_ROOT_DESCRIPTOR_ACCESS_OUT_OF_BOUNDS                                     = 0x000003c1,
    D3D12_MESSAGE_ID_CREATEPIPELINELIBRARY_INVALIDLIBRARYBLOB                                                      = 0x000003c2,
    D3D12_MESSAGE_ID_CREATEPIPELINELIBRARY_DRIVERVERSIONMISMATCH                                                   = 0x000003c3,
    D3D12_MESSAGE_ID_CREATEPIPELINELIBRARY_ADAPTERVERSIONMISMATCH                                                  = 0x000003c4,
    D3D12_MESSAGE_ID_CREATEPIPELINELIBRARY_UNSUPPORTED                                                             = 0x000003c5,
    D3D12_MESSAGE_ID_CREATE_PIPELINELIBRARY                                                                        = 0x000003c6,
    D3D12_MESSAGE_ID_LIVE_PIPELINELIBRARY                                                                          = 0x000003c7,
    D3D12_MESSAGE_ID_DESTROY_PIPELINELIBRARY                                                                       = 0x000003c8,
    D3D12_MESSAGE_ID_STOREPIPELINE_NONAME                                                                          = 0x000003c9,
    D3D12_MESSAGE_ID_STOREPIPELINE_DUPLICATENAME                                                                   = 0x000003ca,
    D3D12_MESSAGE_ID_LOADPIPELINE_NAMENOTFOUND                                                                     = 0x000003cb,
    D3D12_MESSAGE_ID_LOADPIPELINE_INVALIDDESC                                                                      = 0x000003cc,
    D3D12_MESSAGE_ID_PIPELINELIBRARY_SERIALIZE_NOTENOUGHMEMORY                                                     = 0x000003cd,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_PS_OUTPUT_RT_OUTPUT_MISMATCH                                      = 0x000003ce,
    D3D12_MESSAGE_ID_SETEVENTONMULTIPLEFENCECOMPLETION_INVALIDFLAGS                                                = 0x000003cf,
    D3D12_MESSAGE_ID_CREATE_QUEUE_VIDEO_NOT_SUPPORTED                                                              = 0x000003d0,
    D3D12_MESSAGE_ID_CREATE_COMMAND_ALLOCATOR_VIDEO_NOT_SUPPORTED                                                  = 0x000003d1,
    D3D12_MESSAGE_ID_CREATEQUERY_HEAP_VIDEO_DECODE_STATISTICS_NOT_SUPPORTED                                        = 0x000003d2,
    D3D12_MESSAGE_ID_CREATE_VIDEODECODECOMMANDLIST                                                                 = 0x000003d3,
    D3D12_MESSAGE_ID_CREATE_VIDEODECODER                                                                           = 0x000003d4,
    D3D12_MESSAGE_ID_CREATE_VIDEODECODESTREAM                                                                      = 0x000003d5,
    D3D12_MESSAGE_ID_LIVE_VIDEODECODECOMMANDLIST                                                                   = 0x000003d6,
    D3D12_MESSAGE_ID_LIVE_VIDEODECODER                                                                             = 0x000003d7,
    D3D12_MESSAGE_ID_LIVE_VIDEODECODESTREAM                                                                        = 0x000003d8,
    D3D12_MESSAGE_ID_DESTROY_VIDEODECODECOMMANDLIST                                                                = 0x000003d9,
    D3D12_MESSAGE_ID_DESTROY_VIDEODECODER                                                                          = 0x000003da,
    D3D12_MESSAGE_ID_DESTROY_VIDEODECODESTREAM                                                                     = 0x000003db,
    D3D12_MESSAGE_ID_DECODE_FRAME_INVALID_PARAMETERS                                                               = 0x000003dc,
    D3D12_MESSAGE_ID_DEPRECATED_API                                                                                = 0x000003dd,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_MISMATCHING_COMMAND_LIST_TYPE                                                = 0x000003de,
    D3D12_MESSAGE_ID_COMMAND_LIST_DESCRIPTOR_TABLE_NOT_SET                                                         = 0x000003df,
    D3D12_MESSAGE_ID_COMMAND_LIST_ROOT_CONSTANT_BUFFER_VIEW_NOT_SET                                                = 0x000003e0,
    D3D12_MESSAGE_ID_COMMAND_LIST_ROOT_SHADER_RESOURCE_VIEW_NOT_SET                                                = 0x000003e1,
    D3D12_MESSAGE_ID_COMMAND_LIST_ROOT_UNORDERED_ACCESS_VIEW_NOT_SET                                               = 0x000003e2,
    D3D12_MESSAGE_ID_DISCARD_INVALID_SUBRESOURCE_RANGE                                                             = 0x000003e3,
    D3D12_MESSAGE_ID_DISCARD_ONE_SUBRESOURCE_FOR_MIPS_WITH_RECTS                                                   = 0x000003e4,
    D3D12_MESSAGE_ID_DISCARD_NO_RECTS_FOR_NON_TEXTURE2D                                                            = 0x000003e5,
    D3D12_MESSAGE_ID_COPY_ON_SAME_SUBRESOURCE                                                                      = 0x000003e6,
    D3D12_MESSAGE_ID_SETRESIDENCYPRIORITY_INVALID_PAGEABLE                                                         = 0x000003e7,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_UNSUPPORTED                                                              = 0x000003e8,
    D3D12_MESSAGE_ID_STATIC_DESCRIPTOR_INVALID_DESCRIPTOR_CHANGE                                                   = 0x000003e9,
    D3D12_MESSAGE_ID_DATA_STATIC_DESCRIPTOR_INVALID_DATA_CHANGE                                                    = 0x000003ea,
    D3D12_MESSAGE_ID_DATA_STATIC_WHILE_SET_AT_EXECUTE_DESCRIPTOR_INVALID_DATA_CHANGE                               = 0x000003eb,
    D3D12_MESSAGE_ID_EXECUTE_BUNDLE_STATIC_DESCRIPTOR_DATA_STATIC_NOT_SET                                          = 0x000003ec,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_RESOURCE_ACCESS_OUT_OF_BOUNDS                                            = 0x000003ed,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_SAMPLER_MODE_MISMATCH                                                    = 0x000003ee,
    D3D12_MESSAGE_ID_CREATE_FENCE_INVALID_FLAGS                                                                    = 0x000003ef,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_DUPLICATE_SUBRESOURCE_TRANSITIONS                                            = 0x000003f0,
    D3D12_MESSAGE_ID_SETRESIDENCYPRIORITY_INVALID_PRIORITY                                                         = 0x000003f1,
    D3D12_MESSAGE_ID_CREATE_DESCRIPTOR_HEAP_LARGE_NUM_DESCRIPTORS                                                  = 0x000003f5,
    D3D12_MESSAGE_ID_BEGIN_EVENT                                                                                   = 0x000003f6,
    D3D12_MESSAGE_ID_END_EVENT                                                                                     = 0x000003f7,
    D3D12_MESSAGE_ID_CREATEDEVICE_DEBUG_LAYER_STARTUP_OPTIONS                                                      = 0x000003f8,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_DEPTHBOUNDSTEST_UNSUPPORTED                                           = 0x000003f9,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_DUPLICATE_SUBOBJECT                                                       = 0x000003fa,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_UNKNOWN_SUBOBJECT                                                         = 0x000003fb,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_ZERO_SIZE_STREAM                                                          = 0x000003fc,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_INVALID_STREAM                                                            = 0x000003fd,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_CANNOT_DEDUCE_TYPE                                                        = 0x000003fe,
    D3D12_MESSAGE_ID_COMMAND_LIST_STATIC_DESCRIPTOR_RESOURCE_DIMENSION_MISMATCH                                    = 0x000003ff,
    D3D12_MESSAGE_ID_CREATE_COMMAND_QUEUE_INSUFFICIENT_PRIVILEGE_FOR_GLOBAL_REALTIME                               = 0x00000400,
    D3D12_MESSAGE_ID_CREATE_COMMAND_QUEUE_INSUFFICIENT_HARDWARE_SUPPORT_FOR_GLOBAL_REALTIME                        = 0x00000401,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_ARCHITECTURE                                                         = 0x00000402,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_NULL_DST                                                                     = 0x00000403,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_DST_RESOURCE_DIMENSION                                               = 0x00000404,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_DST_RANGE_OUT_OF_BOUNDS                                                      = 0x00000405,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_NULL_SRC                                                                     = 0x00000406,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_SRC_RESOURCE_DIMENSION                                               = 0x00000407,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_SRC_RANGE_OUT_OF_BOUNDS                                                      = 0x00000408,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_OFFSET_ALIGNMENT                                                     = 0x00000409,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_NULL_DEPENDENT_RESOURCES                                                     = 0x0000040a,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_NULL_DEPENDENT_SUBRESOURCE_RANGES                                            = 0x0000040b,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_DEPENDENT_RESOURCE                                                   = 0x0000040c,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_DEPENDENT_SUBRESOURCE_RANGE                                          = 0x0000040d,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_DEPENDENT_SUBRESOURCE_OUT_OF_BOUNDS                                          = 0x0000040e,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_DEPENDENT_RANGE_OUT_OF_BOUNDS                                                = 0x0000040f,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_ZERO_DEPENDENCIES                                                            = 0x00000410,
    D3D12_MESSAGE_ID_DEVICE_CREATE_SHARED_HANDLE_INVALIDARG                                                        = 0x00000411,
    D3D12_MESSAGE_ID_DESCRIPTOR_HANDLE_WITH_INVALID_RESOURCE                                                       = 0x00000412,
    D3D12_MESSAGE_ID_SETDEPTHBOUNDS_INVALIDARGS                                                                    = 0x00000413,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_RESOURCE_STATE_IMPRECISE                                                 = 0x00000414,
    D3D12_MESSAGE_ID_COMMAND_LIST_PIPELINE_STATE_NOT_SET                                                           = 0x00000415,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_MODEL_MISMATCH                                             = 0x00000416,
    D3D12_MESSAGE_ID_OBJECT_ACCESSED_WHILE_STILL_IN_USE                                                            = 0x00000417,
    D3D12_MESSAGE_ID_PROGRAMMABLE_MSAA_UNSUPPORTED                                                                 = 0x00000418,
    D3D12_MESSAGE_ID_SETSAMPLEPOSITIONS_INVALIDARGS                                                                = 0x00000419,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCEREGION_INVALID_RECT                                                         = 0x0000041a,
    D3D12_MESSAGE_ID_CREATE_VIDEODECODECOMMANDQUEUE                                                                = 0x0000041b,
    D3D12_MESSAGE_ID_CREATE_VIDEOPROCESSCOMMANDLIST                                                                = 0x0000041c,
    D3D12_MESSAGE_ID_CREATE_VIDEOPROCESSCOMMANDQUEUE                                                               = 0x0000041d,
    D3D12_MESSAGE_ID_LIVE_VIDEODECODECOMMANDQUEUE                                                                  = 0x0000041e,
    D3D12_MESSAGE_ID_LIVE_VIDEOPROCESSCOMMANDLIST                                                                  = 0x0000041f,
    D3D12_MESSAGE_ID_LIVE_VIDEOPROCESSCOMMANDQUEUE                                                                 = 0x00000420,
    D3D12_MESSAGE_ID_DESTROY_VIDEODECODECOMMANDQUEUE                                                               = 0x00000421,
    D3D12_MESSAGE_ID_DESTROY_VIDEOPROCESSCOMMANDLIST                                                               = 0x00000422,
    D3D12_MESSAGE_ID_DESTROY_VIDEOPROCESSCOMMANDQUEUE                                                              = 0x00000423,
    D3D12_MESSAGE_ID_CREATE_VIDEOPROCESSOR                                                                         = 0x00000424,
    D3D12_MESSAGE_ID_CREATE_VIDEOPROCESSSTREAM                                                                     = 0x00000425,
    D3D12_MESSAGE_ID_LIVE_VIDEOPROCESSOR                                                                           = 0x00000426,
    D3D12_MESSAGE_ID_LIVE_VIDEOPROCESSSTREAM                                                                       = 0x00000427,
    D3D12_MESSAGE_ID_DESTROY_VIDEOPROCESSOR                                                                        = 0x00000428,
    D3D12_MESSAGE_ID_DESTROY_VIDEOPROCESSSTREAM                                                                    = 0x00000429,
    D3D12_MESSAGE_ID_PROCESS_FRAME_INVALID_PARAMETERS                                                              = 0x0000042a,
    D3D12_MESSAGE_ID_COPY_INVALIDLAYOUT                                                                            = 0x0000042b,
    D3D12_MESSAGE_ID_CREATE_CRYPTO_SESSION                                                                         = 0x0000042c,
    D3D12_MESSAGE_ID_CREATE_CRYPTO_SESSION_POLICY                                                                  = 0x0000042d,
    D3D12_MESSAGE_ID_CREATE_PROTECTED_RESOURCE_SESSION                                                             = 0x0000042e,
    D3D12_MESSAGE_ID_LIVE_CRYPTO_SESSION                                                                           = 0x0000042f,
    D3D12_MESSAGE_ID_LIVE_CRYPTO_SESSION_POLICY                                                                    = 0x00000430,
    D3D12_MESSAGE_ID_LIVE_PROTECTED_RESOURCE_SESSION                                                               = 0x00000431,
    D3D12_MESSAGE_ID_DESTROY_CRYPTO_SESSION                                                                        = 0x00000432,
    D3D12_MESSAGE_ID_DESTROY_CRYPTO_SESSION_POLICY                                                                 = 0x00000433,
    D3D12_MESSAGE_ID_DESTROY_PROTECTED_RESOURCE_SESSION                                                            = 0x00000434,
    D3D12_MESSAGE_ID_PROTECTED_RESOURCE_SESSION_UNSUPPORTED                                                        = 0x00000435,
    D3D12_MESSAGE_ID_FENCE_INVALIDOPERATION                                                                        = 0x00000436,
    D3D12_MESSAGE_ID_CREATEQUERY_HEAP_COPY_QUEUE_TIMESTAMPS_NOT_SUPPORTED                                          = 0x00000437,
    D3D12_MESSAGE_ID_SAMPLEPOSITIONS_MISMATCH_DEFERRED                                                             = 0x00000438,
    D3D12_MESSAGE_ID_SAMPLEPOSITIONS_MISMATCH_RECORDTIME_ASSUMEDFROMFIRSTUSE                                       = 0x00000439,
    D3D12_MESSAGE_ID_SAMPLEPOSITIONS_MISMATCH_RECORDTIME_ASSUMEDFROMCLEAR                                          = 0x0000043a,
    D3D12_MESSAGE_ID_CREATE_VIDEODECODERHEAP                                                                       = 0x0000043b,
    D3D12_MESSAGE_ID_LIVE_VIDEODECODERHEAP                                                                         = 0x0000043c,
    D3D12_MESSAGE_ID_DESTROY_VIDEODECODERHEAP                                                                      = 0x0000043d,
    D3D12_MESSAGE_ID_OPENEXISTINGHEAP_INVALIDARG_RETURN                                                            = 0x0000043e,
    D3D12_MESSAGE_ID_OPENEXISTINGHEAP_OUTOFMEMORY_RETURN                                                           = 0x0000043f,
    D3D12_MESSAGE_ID_OPENEXISTINGHEAP_INVALIDADDRESS                                                               = 0x00000440,
    D3D12_MESSAGE_ID_OPENEXISTINGHEAP_INVALIDHANDLE                                                                = 0x00000441,
    D3D12_MESSAGE_ID_WRITEBUFFERIMMEDIATE_INVALID_DEST                                                             = 0x00000442,
    D3D12_MESSAGE_ID_WRITEBUFFERIMMEDIATE_INVALID_MODE                                                             = 0x00000443,
    D3D12_MESSAGE_ID_WRITEBUFFERIMMEDIATE_INVALID_ALIGNMENT                                                        = 0x00000444,
    D3D12_MESSAGE_ID_WRITEBUFFERIMMEDIATE_NOT_SUPPORTED                                                            = 0x00000445,
    D3D12_MESSAGE_ID_SETVIEWINSTANCEMASK_INVALIDARGS                                                               = 0x00000446,
    D3D12_MESSAGE_ID_VIEW_INSTANCING_UNSUPPORTED                                                                   = 0x00000447,
    D3D12_MESSAGE_ID_VIEW_INSTANCING_INVALIDARGS                                                                   = 0x00000448,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_MISMATCH_DECODE_REFERENCE_ONLY_FLAG                                         = 0x00000449,
    D3D12_MESSAGE_ID_COPYRESOURCE_MISMATCH_DECODE_REFERENCE_ONLY_FLAG                                              = 0x0000044a,
    D3D12_MESSAGE_ID_CREATE_VIDEO_DECODE_HEAP_CAPS_FAILURE                                                         = 0x0000044b,
    D3D12_MESSAGE_ID_CREATE_VIDEO_DECODE_HEAP_CAPS_UNSUPPORTED                                                     = 0x0000044c,
    D3D12_MESSAGE_ID_VIDEO_DECODE_SUPPORT_INVALID_INPUT                                                            = 0x0000044d,
    D3D12_MESSAGE_ID_CREATE_VIDEO_DECODER_UNSUPPORTED                                                              = 0x0000044e,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_METADATA_ERROR                                                    = 0x0000044f,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_VIEW_INSTANCING_VERTEX_SIZE_EXCEEDED                              = 0x00000450,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_RUNTIME_INTERNAL_ERROR                                            = 0x00000451,
    D3D12_MESSAGE_ID_NO_VIDEO_API_SUPPORT                                                                          = 0x00000452,
    D3D12_MESSAGE_ID_VIDEO_PROCESS_SUPPORT_INVALID_INPUT                                                           = 0x00000453,
    D3D12_MESSAGE_ID_CREATE_VIDEO_PROCESSOR_CAPS_FAILURE                                                           = 0x00000454,
    D3D12_MESSAGE_ID_VIDEO_PROCESS_SUPPORT_UNSUPPORTED_FORMAT                                                      = 0x00000455,
    D3D12_MESSAGE_ID_VIDEO_DECODE_FRAME_INVALID_ARGUMENT                                                           = 0x00000456,
    D3D12_MESSAGE_ID_ENQUEUE_MAKE_RESIDENT_INVALID_FLAGS                                                           = 0x00000457,
    D3D12_MESSAGE_ID_OPENEXISTINGHEAP_UNSUPPORTED                                                                  = 0x00000458,
    D3D12_MESSAGE_ID_VIDEO_PROCESS_FRAMES_INVALID_ARGUMENT                                                         = 0x00000459,
    D3D12_MESSAGE_ID_VIDEO_DECODE_SUPPORT_UNSUPPORTED                                                              = 0x0000045a,
    D3D12_MESSAGE_ID_CREATE_COMMANDRECORDER                                                                        = 0x0000045b,
    D3D12_MESSAGE_ID_LIVE_COMMANDRECORDER                                                                          = 0x0000045c,
    D3D12_MESSAGE_ID_DESTROY_COMMANDRECORDER                                                                       = 0x0000045d,
    D3D12_MESSAGE_ID_CREATE_COMMAND_RECORDER_VIDEO_NOT_SUPPORTED                                                   = 0x0000045e,
    D3D12_MESSAGE_ID_CREATE_COMMAND_RECORDER_INVALID_SUPPORT_FLAGS                                                 = 0x0000045f,
    D3D12_MESSAGE_ID_CREATE_COMMAND_RECORDER_INVALID_FLAGS                                                         = 0x00000460,
    D3D12_MESSAGE_ID_CREATE_COMMAND_RECORDER_MORE_RECORDERS_THAN_LOGICAL_PROCESSORS                                = 0x00000461,
    D3D12_MESSAGE_ID_CREATE_COMMANDPOOL                                                                            = 0x00000462,
    D3D12_MESSAGE_ID_LIVE_COMMANDPOOL                                                                              = 0x00000463,
    D3D12_MESSAGE_ID_DESTROY_COMMANDPOOL                                                                           = 0x00000464,
    D3D12_MESSAGE_ID_CREATE_COMMAND_POOL_INVALID_FLAGS                                                             = 0x00000465,
    D3D12_MESSAGE_ID_CREATE_COMMAND_LIST_VIDEO_NOT_SUPPORTED                                                       = 0x00000466,
    D3D12_MESSAGE_ID_COMMAND_RECORDER_SUPPORT_FLAGS_MISMATCH                                                       = 0x00000467,
    D3D12_MESSAGE_ID_COMMAND_RECORDER_CONTENTION                                                                   = 0x00000468,
    D3D12_MESSAGE_ID_COMMAND_RECORDER_USAGE_WITH_CREATECOMMANDLIST_COMMAND_LIST                                    = 0x00000469,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_USAGE_WITH_CREATECOMMANDLIST1_COMMAND_LIST                                  = 0x0000046a,
    D3D12_MESSAGE_ID_CANNOT_EXECUTE_EMPTY_COMMAND_LIST                                                             = 0x0000046b,
    D3D12_MESSAGE_ID_CANNOT_RESET_COMMAND_POOL_WITH_OPEN_COMMAND_LISTS                                             = 0x0000046c,
    D3D12_MESSAGE_ID_CANNOT_USE_COMMAND_RECORDER_WITHOUT_CURRENT_TARGET                                            = 0x0000046d,
    D3D12_MESSAGE_ID_CANNOT_CHANGE_COMMAND_RECORDER_TARGET_WHILE_RECORDING                                         = 0x0000046e,
    D3D12_MESSAGE_ID_COMMAND_POOL_SYNC                                                                             = 0x0000046f,
    D3D12_MESSAGE_ID_EVICT_UNDERFLOW                                                                               = 0x00000470,
    D3D12_MESSAGE_ID_CREATE_META_COMMAND                                                                           = 0x00000471,
    D3D12_MESSAGE_ID_LIVE_META_COMMAND                                                                             = 0x00000472,
    D3D12_MESSAGE_ID_DESTROY_META_COMMAND                                                                          = 0x00000473,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_INVALID_DST_RESOURCE                                                         = 0x00000474,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_INVALID_SRC_RESOURCE                                                         = 0x00000475,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_DST_RESOURCE                                                         = 0x00000476,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_SRC_RESOURCE                                                         = 0x00000477,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_NULL_BUFFER                                                      = 0x00000478,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_NULL_RESOURCE_DESC                                               = 0x00000479,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_UNSUPPORTED                                                      = 0x0000047a,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_INVALID_BUFFER_DIMENSION                                         = 0x0000047b,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_INVALID_BUFFER_FLAGS                                             = 0x0000047c,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_INVALID_BUFFER_OFFSET                                            = 0x0000047d,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_INVALID_RESOURCE_DIMENSION                                       = 0x0000047e,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_INVALID_RESOURCE_FLAGS                                           = 0x0000047f,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_OUTOFMEMORY_RETURN                                               = 0x00000480,
    D3D12_MESSAGE_ID_CANNOT_CREATE_GRAPHICS_AND_VIDEO_COMMAND_RECORDER                                             = 0x00000481,
    D3D12_MESSAGE_ID_UPDATETILEMAPPINGS_POSSIBLY_MISMATCHING_PROPERTIES                                            = 0x00000482,
    D3D12_MESSAGE_ID_CREATE_COMMAND_LIST_INVALID_COMMAND_LIST_TYPE                                                 = 0x00000483,
    D3D12_MESSAGE_ID_CLEARUNORDEREDACCESSVIEW_INCOMPATIBLE_WITH_STRUCTURED_BUFFERS                                 = 0x00000484,
    D3D12_MESSAGE_ID_COMPUTE_ONLY_DEVICE_OPERATION_UNSUPPORTED                                                     = 0x00000485,
    D3D12_MESSAGE_ID_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INVALID                                               = 0x00000486,
    D3D12_MESSAGE_ID_EMIT_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_INVALID                                 = 0x00000487,
    D3D12_MESSAGE_ID_COPY_RAYTRACING_ACCELERATION_STRUCTURE_INVALID                                                = 0x00000488,
    D3D12_MESSAGE_ID_DISPATCH_RAYS_INVALID                                                                         = 0x00000489,
    D3D12_MESSAGE_ID_GET_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO_INVALID                                   = 0x0000048a,
    D3D12_MESSAGE_ID_CREATE_LIFETIMETRACKER                                                                        = 0x0000048b,
    D3D12_MESSAGE_ID_LIVE_LIFETIMETRACKER                                                                          = 0x0000048c,
    D3D12_MESSAGE_ID_DESTROY_LIFETIMETRACKER                                                                       = 0x0000048d,
    D3D12_MESSAGE_ID_DESTROYOWNEDOBJECT_OBJECTNOTOWNED                                                             = 0x0000048e,
    D3D12_MESSAGE_ID_CREATE_TRACKEDWORKLOAD                                                                        = 0x0000048f,
    D3D12_MESSAGE_ID_LIVE_TRACKEDWORKLOAD                                                                          = 0x00000490,
    D3D12_MESSAGE_ID_DESTROY_TRACKEDWORKLOAD                                                                       = 0x00000491,
    D3D12_MESSAGE_ID_RENDER_PASS_ERROR                                                                             = 0x00000492,
    D3D12_MESSAGE_ID_META_COMMAND_ID_INVALID                                                                       = 0x00000493,
    D3D12_MESSAGE_ID_META_COMMAND_UNSUPPORTED_PARAMS                                                               = 0x00000494,
    D3D12_MESSAGE_ID_META_COMMAND_FAILED_ENUMERATION                                                               = 0x00000495,
    D3D12_MESSAGE_ID_META_COMMAND_PARAMETER_SIZE_MISMATCH                                                          = 0x00000496,
    D3D12_MESSAGE_ID_UNINITIALIZED_META_COMMAND                                                                    = 0x00000497,
    D3D12_MESSAGE_ID_META_COMMAND_INVALID_GPU_VIRTUAL_ADDRESS                                                      = 0x00000498,
    D3D12_MESSAGE_ID_CREATE_VIDEOENCODECOMMANDLIST                                                                 = 0x00000499,
    D3D12_MESSAGE_ID_LIVE_VIDEOENCODECOMMANDLIST                                                                   = 0x0000049a,
    D3D12_MESSAGE_ID_DESTROY_VIDEOENCODECOMMANDLIST                                                                = 0x0000049b,
    D3D12_MESSAGE_ID_CREATE_VIDEOENCODECOMMANDQUEUE                                                                = 0x0000049c,
    D3D12_MESSAGE_ID_LIVE_VIDEOENCODECOMMANDQUEUE                                                                  = 0x0000049d,
    D3D12_MESSAGE_ID_DESTROY_VIDEOENCODECOMMANDQUEUE                                                               = 0x0000049e,
    D3D12_MESSAGE_ID_CREATE_VIDEOMOTIONESTIMATOR                                                                   = 0x0000049f,
    D3D12_MESSAGE_ID_LIVE_VIDEOMOTIONESTIMATOR                                                                     = 0x000004a0,
    D3D12_MESSAGE_ID_DESTROY_VIDEOMOTIONESTIMATOR                                                                  = 0x000004a1,
    D3D12_MESSAGE_ID_CREATE_VIDEOMOTIONVECTORHEAP                                                                  = 0x000004a2,
    D3D12_MESSAGE_ID_LIVE_VIDEOMOTIONVECTORHEAP                                                                    = 0x000004a3,
    D3D12_MESSAGE_ID_DESTROY_VIDEOMOTIONVECTORHEAP                                                                 = 0x000004a4,
    D3D12_MESSAGE_ID_MULTIPLE_TRACKED_WORKLOADS                                                                    = 0x000004a5,
    D3D12_MESSAGE_ID_MULTIPLE_TRACKED_WORKLOAD_PAIRS                                                               = 0x000004a6,
    D3D12_MESSAGE_ID_OUT_OF_ORDER_TRACKED_WORKLOAD_PAIR                                                            = 0x000004a7,
    D3D12_MESSAGE_ID_CANNOT_ADD_TRACKED_WORKLOAD                                                                   = 0x000004a8,
    D3D12_MESSAGE_ID_INCOMPLETE_TRACKED_WORKLOAD_PAIR                                                              = 0x000004a9,
    D3D12_MESSAGE_ID_CREATE_STATE_OBJECT_ERROR                                                                     = 0x000004aa,
    D3D12_MESSAGE_ID_GET_SHADER_IDENTIFIER_ERROR                                                                   = 0x000004ab,
    D3D12_MESSAGE_ID_GET_SHADER_STACK_SIZE_ERROR                                                                   = 0x000004ac,
    D3D12_MESSAGE_ID_GET_PIPELINE_STACK_SIZE_ERROR                                                                 = 0x000004ad,
    D3D12_MESSAGE_ID_SET_PIPELINE_STACK_SIZE_ERROR                                                                 = 0x000004ae,
    D3D12_MESSAGE_ID_GET_SHADER_IDENTIFIER_SIZE_INVALID                                                            = 0x000004af,
    D3D12_MESSAGE_ID_CHECK_DRIVER_MATCHING_IDENTIFIER_INVALID                                                      = 0x000004b0,
    D3D12_MESSAGE_ID_CHECK_DRIVER_MATCHING_IDENTIFIER_DRIVER_REPORTED_ISSUE                                        = 0x000004b1,
    D3D12_MESSAGE_ID_RENDER_PASS_INVALID_RESOURCE_BARRIER                                                          = 0x000004b2,
    D3D12_MESSAGE_ID_RENDER_PASS_DISALLOWED_API_CALLED                                                             = 0x000004b3,
    D3D12_MESSAGE_ID_RENDER_PASS_CANNOT_NEST_RENDER_PASSES                                                         = 0x000004b4,
    D3D12_MESSAGE_ID_RENDER_PASS_CANNOT_END_WITHOUT_BEGIN                                                          = 0x000004b5,
    D3D12_MESSAGE_ID_RENDER_PASS_CANNOT_CLOSE_COMMAND_LIST                                                         = 0x000004b6,
    D3D12_MESSAGE_ID_RENDER_PASS_GPU_WORK_WHILE_SUSPENDED                                                          = 0x000004b7,
    D3D12_MESSAGE_ID_RENDER_PASS_MISMATCHING_SUSPEND_RESUME                                                        = 0x000004b8,
    D3D12_MESSAGE_ID_RENDER_PASS_NO_PRIOR_SUSPEND_WITHIN_EXECUTECOMMANDLISTS                                       = 0x000004b9,
    D3D12_MESSAGE_ID_RENDER_PASS_NO_SUBSEQUENT_RESUME_WITHIN_EXECUTECOMMANDLISTS                                   = 0x000004ba,
    D3D12_MESSAGE_ID_TRACKED_WORKLOAD_COMMAND_QUEUE_MISMATCH                                                       = 0x000004bb,
    D3D12_MESSAGE_ID_TRACKED_WORKLOAD_NOT_SUPPORTED                                                                = 0x000004bc,
    D3D12_MESSAGE_ID_RENDER_PASS_MISMATCHING_NO_ACCESS                                                             = 0x000004bd,
    D3D12_MESSAGE_ID_RENDER_PASS_UNSUPPORTED_RESOLVE                                                               = 0x000004be,
    D3D12_MESSAGE_ID_CLEARUNORDEREDACCESSVIEW_INVALID_RESOURCE_PTR                                                 = 0x000004bf,
    D3D12_MESSAGE_ID_WINDOWS7_FENCE_OUTOFORDER_SIGNAL                                                              = 0x000004c0,
    D3D12_MESSAGE_ID_WINDOWS7_FENCE_OUTOFORDER_WAIT                                                                = 0x000004c1,
    D3D12_MESSAGE_ID_VIDEO_CREATE_MOTION_ESTIMATOR_INVALID_ARGUMENT                                                = 0x000004c2,
    D3D12_MESSAGE_ID_VIDEO_CREATE_MOTION_VECTOR_HEAP_INVALID_ARGUMENT                                              = 0x000004c3,
    D3D12_MESSAGE_ID_ESTIMATE_MOTION_INVALID_ARGUMENT                                                              = 0x000004c4,
    D3D12_MESSAGE_ID_RESOLVE_MOTION_VECTOR_HEAP_INVALID_ARGUMENT                                                   = 0x000004c5,
    D3D12_MESSAGE_ID_GETGPUVIRTUALADDRESS_INVALID_HEAP_TYPE                                                        = 0x000004c6,
    D3D12_MESSAGE_ID_SET_BACKGROUND_PROCESSING_MODE_INVALID_ARGUMENT                                               = 0x000004c7,
    D3D12_MESSAGE_ID_CREATE_COMMAND_LIST_INVALID_COMMAND_LIST_TYPE_FOR_FEATURE_LEVEL                               = 0x000004c8,
    D3D12_MESSAGE_ID_CREATE_VIDEOEXTENSIONCOMMAND                                                                  = 0x000004c9,
    D3D12_MESSAGE_ID_LIVE_VIDEOEXTENSIONCOMMAND                                                                    = 0x000004ca,
    D3D12_MESSAGE_ID_DESTROY_VIDEOEXTENSIONCOMMAND                                                                 = 0x000004cb,
    D3D12_MESSAGE_ID_INVALID_VIDEO_EXTENSION_COMMAND_ID                                                            = 0x000004cc,
    D3D12_MESSAGE_ID_VIDEO_EXTENSION_COMMAND_INVALID_ARGUMENT                                                      = 0x000004cd,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_NOT_UNIQUE_IN_DXIL_LIBRARY                                              = 0x000004ce,
    D3D12_MESSAGE_ID_VARIABLE_SHADING_RATE_NOT_ALLOWED_WITH_TIR                                                    = 0x000004cf,
    D3D12_MESSAGE_ID_GEOMETRY_SHADER_OUTPUTTING_BOTH_VIEWPORT_ARRAY_INDEX_AND_SHADING_RATE_NOT_SUPPORTED_ON_DEVICE = 0x000004d0,
    D3D12_MESSAGE_ID_RSSETSHADING_RATE_INVALID_SHADING_RATE                                                        = 0x000004d1,
    D3D12_MESSAGE_ID_RSSETSHADING_RATE_SHADING_RATE_NOT_PERMITTED_BY_CAP                                           = 0x000004d2,
    D3D12_MESSAGE_ID_RSSETSHADING_RATE_INVALID_COMBINER                                                            = 0x000004d3,
    D3D12_MESSAGE_ID_RSSETSHADINGRATEIMAGE_REQUIRES_TIER_2                                                         = 0x000004d4,
    D3D12_MESSAGE_ID_RSSETSHADINGRATE_REQUIRES_TIER_1                                                              = 0x000004d5,
    D3D12_MESSAGE_ID_SHADING_RATE_IMAGE_INCORRECT_FORMAT                                                           = 0x000004d6,
    D3D12_MESSAGE_ID_SHADING_RATE_IMAGE_INCORRECT_ARRAY_SIZE                                                       = 0x000004d7,
    D3D12_MESSAGE_ID_SHADING_RATE_IMAGE_INCORRECT_MIP_LEVEL                                                        = 0x000004d8,
    D3D12_MESSAGE_ID_SHADING_RATE_IMAGE_INCORRECT_SAMPLE_COUNT                                                     = 0x000004d9,
    D3D12_MESSAGE_ID_SHADING_RATE_IMAGE_INCORRECT_SAMPLE_QUALITY                                                   = 0x000004da,
    D3D12_MESSAGE_ID_NON_RETAIL_SHADER_MODEL_WONT_VALIDATE                                                         = 0x000004db,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_AS_ROOT_SIGNATURE_MISMATCH                                        = 0x000004dc,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_MS_ROOT_SIGNATURE_MISMATCH                                        = 0x000004dd,
    D3D12_MESSAGE_ID_ADD_TO_STATE_OBJECT_ERROR                                                                     = 0x000004de,
    D3D12_MESSAGE_ID_CREATE_PROTECTED_RESOURCE_SESSION_INVALID_ARGUMENT                                            = 0x000004df,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_MS_PSO_DESC_MISMATCH                                              = 0x000004e0,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_MS_INCOMPLETE_TYPE                                                        = 0x000004e1,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_AS_NOT_MS_MISMATCH                                                = 0x000004e2,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_MS_NOT_PS_MISMATCH                                                = 0x000004e3,
    D3D12_MESSAGE_ID_NONZERO_SAMPLER_FEEDBACK_MIP_REGION_WITH_INCOMPATIBLE_FORMAT                                  = 0x000004e4,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INPUTLAYOUT_SHADER_MISMATCH                                       = 0x000004e5,
    D3D12_MESSAGE_ID_EMPTY_DISPATCH                                                                                = 0x000004e6,
    D3D12_MESSAGE_ID_RESOURCE_FORMAT_REQUIRES_SAMPLER_FEEDBACK_CAPABILITY                                          = 0x000004e7,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_INVALID_MIP_REGION                                                       = 0x000004e8,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_INVALID_DIMENSION                                                        = 0x000004e9,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_INVALID_SAMPLE_COUNT                                                     = 0x000004ea,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_INVALID_SAMPLE_QUALITY                                                   = 0x000004eb,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_INVALID_LAYOUT                                                           = 0x000004ec,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_REQUIRES_UNORDERED_ACCESS_FLAG                                           = 0x000004ed,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_CREATE_UAV_NULL_ARGUMENTS                                                    = 0x000004ee,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_UAV_REQUIRES_SAMPLER_FEEDBACK_CAPABILITY                                     = 0x000004ef,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_CREATE_UAV_REQUIRES_FEEDBACK_MAP_FORMAT                                      = 0x000004f0,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_INVALIDSHADERBYTECODE                                                        = 0x000004f1,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_OUTOFMEMORY                                                                  = 0x000004f2,
    D3D12_MESSAGE_ID_CREATEMESHSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE                                            = 0x000004f3,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_SAMPLER_FEEDBACK_TRANSCODE_INVALID_FORMAT                                  = 0x000004f4,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_SAMPLER_FEEDBACK_INVALID_MIP_LEVEL_COUNT                                   = 0x000004f5,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_SAMPLER_FEEDBACK_TRANSCODE_ARRAY_SIZE_MISMATCH                             = 0x000004f6,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_CREATE_UAV_MISMATCHING_TARGETED_RESOURCE                                     = 0x000004f7,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_OUTPUTEXCEEDSMAXSIZE                                                         = 0x000004f8,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_GROUPSHAREDEXCEEDSMAXSIZE                                                    = 0x000004f9,
    D3D12_MESSAGE_ID_VERTEX_SHADER_OUTPUTTING_BOTH_VIEWPORT_ARRAY_INDEX_AND_SHADING_RATE_NOT_SUPPORTED_ON_DEVICE   = 0x000004fa,
    D3D12_MESSAGE_ID_MESH_SHADER_OUTPUTTING_BOTH_VIEWPORT_ARRAY_INDEX_AND_SHADING_RATE_NOT_SUPPORTED_ON_DEVICE     = 0x000004fb,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_MISMATCHEDASMSPAYLOADSIZE                                                    = 0x000004fc,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_UNBOUNDED_STATIC_DESCRIPTORS                                            = 0x000004fd,
    D3D12_MESSAGE_ID_CREATEAMPLIFICATIONSHADER_INVALIDSHADERBYTECODE                                               = 0x000004fe,
    D3D12_MESSAGE_ID_CREATEAMPLIFICATIONSHADER_OUTOFMEMORY                                                         = 0x000004ff,
    D3D12_MESSAGE_ID_CREATE_SHADERCACHESESSION                                                                     = 0x00000500,
    D3D12_MESSAGE_ID_LIVE_SHADERCACHESESSION                                                                       = 0x00000501,
    D3D12_MESSAGE_ID_DESTROY_SHADERCACHESESSION                                                                    = 0x00000502,
    D3D12_MESSAGE_ID_CREATESHADERCACHESESSION_INVALIDARGS                                                          = 0x00000503,
    D3D12_MESSAGE_ID_CREATESHADERCACHESESSION_DISABLED                                                             = 0x00000504,
    D3D12_MESSAGE_ID_CREATESHADERCACHESESSION_ALREADYOPEN                                                          = 0x00000505,
    D3D12_MESSAGE_ID_SHADERCACHECONTROL_DEVELOPERMODE                                                              = 0x00000506,
    D3D12_MESSAGE_ID_SHADERCACHECONTROL_INVALIDFLAGS                                                               = 0x00000507,
    D3D12_MESSAGE_ID_SHADERCACHECONTROL_STATEALREADYSET                                                            = 0x00000508,
    D3D12_MESSAGE_ID_SHADERCACHECONTROL_IGNOREDFLAG                                                                = 0x00000509,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_STOREVALUE_ALREADYPRESENT                                                  = 0x0000050a,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_STOREVALUE_HASHCOLLISION                                                   = 0x0000050b,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_STOREVALUE_CACHEFULL                                                       = 0x0000050c,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_FINDVALUE_NOTFOUND                                                         = 0x0000050d,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_CORRUPT                                                                    = 0x0000050e,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_DISABLED                                                                   = 0x0000050f,
    D3D12_MESSAGE_ID_OVERSIZED_DISPATCH                                                                            = 0x00000510,
    D3D12_MESSAGE_ID_CREATE_VIDEOENCODER                                                                           = 0x00000511,
    D3D12_MESSAGE_ID_LIVE_VIDEOENCODER                                                                             = 0x00000512,
    D3D12_MESSAGE_ID_DESTROY_VIDEOENCODER                                                                          = 0x00000513,
    D3D12_MESSAGE_ID_CREATE_VIDEOENCODERHEAP                                                                       = 0x00000514,
    D3D12_MESSAGE_ID_LIVE_VIDEOENCODERHEAP                                                                         = 0x00000515,
    D3D12_MESSAGE_ID_DESTROY_VIDEOENCODERHEAP                                                                      = 0x00000516,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_MISMATCH_ENCODE_REFERENCE_ONLY_FLAG                                         = 0x00000517,
    D3D12_MESSAGE_ID_COPYRESOURCE_MISMATCH_ENCODE_REFERENCE_ONLY_FLAG                                              = 0x00000518,
    D3D12_MESSAGE_ID_ENCODE_FRAME_INVALID_PARAMETERS                                                               = 0x00000519,
    D3D12_MESSAGE_ID_ENCODE_FRAME_UNSUPPORTED_PARAMETERS                                                           = 0x0000051a,
    D3D12_MESSAGE_ID_RESOLVE_ENCODER_OUTPUT_METADATA_INVALID_PARAMETERS                                            = 0x0000051b,
    D3D12_MESSAGE_ID_RESOLVE_ENCODER_OUTPUT_METADATA_UNSUPPORTED_PARAMETERS                                        = 0x0000051c,
    D3D12_MESSAGE_ID_CREATE_VIDEO_ENCODER_INVALID_PARAMETERS                                                       = 0x0000051d,
    D3D12_MESSAGE_ID_CREATE_VIDEO_ENCODER_UNSUPPORTED_PARAMETERS                                                   = 0x0000051e,
    D3D12_MESSAGE_ID_CREATE_VIDEO_ENCODER_HEAP_INVALID_PARAMETERS                                                  = 0x0000051f,
    D3D12_MESSAGE_ID_CREATE_VIDEO_ENCODER_HEAP_UNSUPPORTED_PARAMETERS                                              = 0x00000520,
    D3D12_MESSAGE_ID_CREATECOMMANDLIST_NULL_COMMANDALLOCATOR                                                       = 0x00000521,
    D3D12_MESSAGE_ID_CLEAR_UNORDERED_ACCESS_VIEW_INVALID_DESCRIPTOR_HANDLE                                         = 0x00000522,
    D3D12_MESSAGE_ID_DESCRIPTOR_HEAP_NOT_SHADER_VISIBLE                                                            = 0x00000523,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_BLENDOP_WARNING                                                              = 0x00000524,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_BLENDOPALPHA_WARNING                                                         = 0x00000525,
    D3D12_MESSAGE_ID_WRITE_COMBINE_PERFORMANCE_WARNING                                                             = 0x00000526,
    D3D12_MESSAGE_ID_RESOLVE_QUERY_INVALID_QUERY_STATE                                                             = 0x00000527,
    D3D12_MESSAGE_ID_SETPRIVATEDATA_NO_ACCESS                                                                      = 0x00000528,
    D3D12_MESSAGE_ID_COMMAND_LIST_STATIC_DESCRIPTOR_SAMPLER_MODE_MISMATCH                                          = 0x00000529,
    D3D12_MESSAGE_ID_GETCOPYABLEFOOTPRINTS_UNSUPPORTED_BUFFER_WIDTH                                                = 0x0000052a,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_TOPOLOGY_MISMATCH                                                            = 0x0000052b,
    D3D12_MESSAGE_ID_VRS_SUM_COMBINER_REQUIRES_CAPABILITY                                                          = 0x0000052c,
    D3D12_MESSAGE_ID_SETTING_SHADING_RATE_FROM_MS_REQUIRES_CAPABILITY                                              = 0x0000052d,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_SHADERCACHEDELETE_NOTSUPPORTED                                             = 0x0000052e,
    D3D12_MESSAGE_ID_SHADERCACHECONTROL_SHADERCACHECLEAR_NOTSUPPORTED                                              = 0x0000052f,
    D3D12_MESSAGE_ID_CREATERESOURCE_STATE_IGNORED                                                                  = 0x00000530,
    D3D12_MESSAGE_ID_UNUSED_CROSS_EXECUTE_SPLIT_BARRIER                                                            = 0x00000531,
    D3D12_MESSAGE_ID_DEVICE_OPEN_SHARED_HANDLE_ACCESS_DENIED                                                       = 0x00000532,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_VALUES                                                                   = 0x00000533,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_ACCESS                                                                   = 0x00000534,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_SYNC                                                                     = 0x00000535,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_LAYOUT                                                                   = 0x00000536,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_TYPE                                                                     = 0x00000537,
    D3D12_MESSAGE_ID_OUT_OF_BOUNDS_BARRIER_SUBRESOURCE_RANGE                                                       = 0x00000538,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_RESOURCE_DIMENSION                                                       = 0x00000539,
    D3D12_MESSAGE_ID_SET_SCISSOR_RECTS_INVALID_RECT                                                                = 0x0000053a,
    D3D12_MESSAGE_ID_SHADING_RATE_SOURCE_REQUIRES_DIMENSION_TEXTURE2D                                              = 0x0000053b,
    D3D12_MESSAGE_ID_BUFFER_BARRIER_SUBREGION_OUT_OF_BOUNDS                                                        = 0x0000053c,
    D3D12_MESSAGE_ID_UNSUPPORTED_BARRIER_LAYOUT                                                                    = 0x0000053d,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_INVALID_PARAMETERS                                                      = 0x0000053e,
    D3D12_MESSAGE_ID_ENHANCED_BARRIERS_NOT_SUPPORTED                                                               = 0x0000053f,
    D3D12_MESSAGE_ID_LEGACY_BARRIER_VALIDATION_FORCED_ON                                                           = 0x00000542,
    D3D12_MESSAGE_ID_EMPTY_ROOT_DESCRIPTOR_TABLE                                                                   = 0x00000543,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_ELEMENT_OFFSET_UNALIGNED                                                    = 0x00000544,
    D3D12_MESSAGE_ID_ALPHA_BLEND_FACTOR_NOT_SUPPORTED                                                              = 0x00000545,
    D3D12_MESSAGE_ID_BARRIER_INTEROP_INVALID_LAYOUT                                                                = 0x00000546,
    D3D12_MESSAGE_ID_BARRIER_INTEROP_INVALID_STATE                                                                 = 0x00000547,
    D3D12_MESSAGE_ID_GRAPHICS_PIPELINE_STATE_DESC_ZERO_SAMPLE_MASK                                                 = 0x00000548,
    D3D12_MESSAGE_ID_INDEPENDENT_STENCIL_REF_NOT_SUPPORTED                                                         = 0x00000549,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INDEPENDENT_MASKS_UNSUPPORTED                                         = 0x0000054a,
    D3D12_MESSAGE_ID_TEXTURE_BARRIER_SUBRESOURCES_OUT_OF_BOUNDS                                                    = 0x0000054b,
    D3D12_MESSAGE_ID_NON_OPTIMAL_BARRIER_ONLY_EXECUTE_COMMAND_LISTS                                                = 0x0000054c,
    D3D12_MESSAGE_ID_EXECUTE_INDIRECT_ZERO_COMMAND_COUNT                                                           = 0x0000054d,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_INCOMPATIBLE_TEXTURE_LAYOUT                                              = 0x0000054e,
    D3D12_MESSAGE_ID_DYNAMIC_INDEX_BUFFER_STRIP_CUT_NOT_SUPPORTED                                                  = 0x0000054f,
    D3D12_MESSAGE_ID_PRIMITIVE_TOPOLOGY_TRIANGLE_FANS_NOT_SUPPORTED                                                = 0x00000550,
    D3D12_MESSAGE_ID_CREATE_SAMPLER_COMPARISON_FUNC_IGNORED                                                        = 0x00000551,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDHEAPTYPE                                                                    = 0x00000552,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_INVALIDHEAPTYPE                                                         = 0x00000553,
    D3D12_MESSAGE_ID_DYNAMIC_DEPTH_BIAS_NOT_SUPPORTED                                                              = 0x00000554,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_NON_WHOLE_DYNAMIC_DEPTH_BIAS                                            = 0x00000555,
    D3D12_MESSAGE_ID_DYNAMIC_DEPTH_BIAS_FLAG_MISSING                                                               = 0x00000556,
    D3D12_MESSAGE_ID_DYNAMIC_DEPTH_BIAS_NO_PIPELINE                                                                = 0x00000557,
    D3D12_MESSAGE_ID_DYNAMIC_INDEX_BUFFER_STRIP_CUT_FLAG_MISSING                                                   = 0x00000558,
    D3D12_MESSAGE_ID_DYNAMIC_INDEX_BUFFER_STRIP_CUT_NO_PIPELINE                                                    = 0x00000559,
    D3D12_MESSAGE_ID_NONNORMALIZED_COORDINATE_SAMPLING_NOT_SUPPORTED                                               = 0x0000055a,
    D3D12_MESSAGE_ID_INVALID_CAST_TARGET                                                                           = 0x0000055b,
    D3D12_MESSAGE_ID_RENDER_PASS_COMMANDLIST_INVALID_END_STATE                                                     = 0x0000055c,
    D3D12_MESSAGE_ID_RENDER_PASS_COMMANDLIST_INVALID_START_STATE                                                   = 0x0000055d,
    D3D12_MESSAGE_ID_RENDER_PASS_MISMATCHING_ACCESS                                                                = 0x0000055e,
    D3D12_MESSAGE_ID_RENDER_PASS_MISMATCHING_LOCAL_PRESERVE_PARAMETERS                                             = 0x0000055f,
    D3D12_MESSAGE_ID_RENDER_PASS_LOCAL_PRESERVE_RENDER_PARAMETERS_ERROR                                            = 0x00000560,
    D3D12_MESSAGE_ID_RENDER_PASS_LOCAL_DEPTH_STENCIL_ERROR                                                         = 0x00000561,
    D3D12_MESSAGE_ID_DRAW_POTENTIALLY_OUTSIDE_OF_VALID_RENDER_AREA                                                 = 0x00000562,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALID_LINERASTERIZATIONMODE                                           = 0x00000563,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDALIGNMENT_SMALLRESOURCE                                                 = 0x00000564,
    D3D12_MESSAGE_ID_GENERIC_DEVICE_OPERATION_UNSUPPORTED                                                          = 0x00000565,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_RENDER_TARGET_WRONG_WRITE_MASK                                    = 0x00000566,
    D3D12_MESSAGE_ID_PROBABLE_PIX_EVENT_LEAK                                                                       = 0x00000567,
    D3D12_MESSAGE_ID_PIX_EVENT_UNDERFLOW                                                                           = 0x00000568,
    D3D12_MESSAGE_ID_RECREATEAT_INVALID_TARGET                                                                     = 0x00000569,
    D3D12_MESSAGE_ID_RECREATEAT_INSUFFICIENT_SUPPORT                                                               = 0x0000056a,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_STRUCTURED_BUFFER_STRIDE_MISMATCH                                        = 0x0000056b,
    D3D12_MESSAGE_ID_DISPATCH_GRAPH_INVALID                                                                        = 0x0000056c,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_TARGET_FORMAT_INVALID                                                       = 0x0000056d,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_TARGET_DIMENSION_INVALID                                                    = 0x0000056e,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_SOURCE_COLOR_FORMAT_INVALID                                                 = 0x0000056f,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_SOURCE_DEPTH_FORMAT_INVALID                                                 = 0x00000570,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_EXPOSURE_SCALE_FORMAT_INVALID                                               = 0x00000571,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_ENGINE_CREATE_FLAGS_INVALID                                                 = 0x00000572,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_EXTENSION_INTERNAL_LOAD_FAILURE                                             = 0x00000573,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_EXTENSION_INTERNAL_ENGINE_CREATION_ERROR                                    = 0x00000574,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_EXTENSION_INTERNAL_UPSCALER_CREATION_ERROR                                  = 0x00000575,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_EXTENSION_INTERNAL_UPSCALER_EXECUTION_ERROR                                 = 0x00000576,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EXECUTE_REGION_INVALID                                             = 0x00000577,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EXECUTE_TIME_DELTA_INVALID                                         = 0x00000578,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EXECUTE_REQUIRED_TEXTURE_IS_NULL                                   = 0x00000579,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EXECUTE_MOTION_VECTORS_FORMAT_INVALID                              = 0x0000057a,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EXECUTE_FLAGS_INVALID                                              = 0x0000057b,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EXECUTE_FORMAT_INVALID                                             = 0x0000057c,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EXECUTE_EXPOSURE_SCALE_TEXTURE_SIZE_INVALID                        = 0x0000057d,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_VARIANT_INDEX_OUT_OF_BOUNDS                                                 = 0x0000057e,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_VARIANT_ID_NOT_FOUND                                                        = 0x0000057f,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_DUPLICATE_VARIANT_ID                                                        = 0x00000580,
    D3D12_MESSAGE_ID_DIRECTSR_OUT_OF_MEMORY                                                                        = 0x00000581,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EXECUTE_UNEXPECTED_TEXTURE_IS_IGNORED                              = 0x00000582,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EVICT_UNDERFLOW                                                    = 0x00000583,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EXECUTE_OPTIONAL_TEXTURE_IS_NULL                                   = 0x00000584,
    D3D12_MESSAGE_ID_DIRECTSR_SUPERRES_UPSCALER_EXECUTE_INVALID_CAMERA_JITTER                                      = 0x00000585,
    D3D12_MESSAGE_ID_CREATE_STATE_OBJECT_WARNING                                                                   = 0x00000586,
    D3D12_MESSAGE_ID_GUID_TEXTURE_LAYOUT_UNSUPPORTED                                                               = 0x00000587,
    D3D12_MESSAGE_ID_RESOLVE_ENCODER_INPUT_PARAM_LAYOUT_INVALID_PARAMETERS                                         = 0x00000588,
    D3D12_MESSAGE_ID_INVALID_BARRIER_ACCESS                                                                        = 0x00000589,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INSTANCE_COUNT_ZERO                                                         = 0x0000058a,
    D3D12_MESSAGE_ID_DESCRIPTOR_HEAP_NOT_SET_BEFORE_ROOT_SIGNATURE_WITH_DIRECTLY_INDEXED_FLAG                      = 0x0000058b,
    D3D12_MESSAGE_ID_DIFFERENT_DESCRIPTOR_HEAP_SET_AFTER_ROOT_SIGNATURE_WITH_DIRECTLY_INDEXED_FLAG                 = 0x0000058c,
    D3D12_MESSAGE_ID_APPLICATION_SPECIFIC_DRIVER_STATE_NOT_SUPPORTED                                               = 0x0000058d,
    D3D12_MESSAGE_ID_RENDER_TARGET_OR_DEPTH_STENCIL_RESOUCE_NOT_INITIALIZED                                        = 0x0000058e,
    D3D12_MESSAGE_ID_BYTECODE_VALIDATION_ERROR                                                                     = 0x0000058f,
    D3D12_MESSAGE_ID_FENCE_ZERO_WAIT                                                                               = 0x00000590,
    D3D12_MESSAGE_ID_NON_COMMON_RESOURCE_IN_COPY_QUEUE                                                             = 0x00000597,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_MULTIPLE_ROOT_SIGNATURES_DEFINED                                          = 0x0000059b,
    D3D12_MESSAGE_ID_TEXTURE_BARRIER_INVALID_FLAGS                                                                 = 0x0000059c,
    D3D12_MESSAGE_ID_STOREPIPELINE_CACHED_BLOB_DISABLED                                                            = 0x000005a2,
    D3D12_MESSAGE_ID_CREATEQUERYHEAP_INVALID_FLAGS                                                                 = 0x000005a3,
    D3D12_MESSAGE_ID_RESOLVEQUERYDATA_INVALID_QUERYHEAP                                                            = 0x000005a4,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_NON_UNIFORM_RESOURCE_INDEX                                               = 0x000005ab,
    D3D12_MESSAGE_ID_DEGENERATE_SPLIT_BARRIER                                                                      = 0x000005ba,
    D3D12_MESSAGE_ID_D3D12_MESSAGES_END                                                                            = 0x000005bb,
}

alias D3D12_MESSAGE_CALLBACK_FLAGS = int;
enum : int
{
    D3D12_MESSAGE_CALLBACK_FLAG_NONE      = 0x00000000,
    D3D12_MESSAGE_CALLBACK_IGNORE_FILTERS = 0x00000001,
}

alias D3D12_DEVICE_FACTORY_FLAGS = int;
enum : int
{
    D3D12_DEVICE_FACTORY_FLAG_NONE                                         = 0x00000000,
    D3D12_DEVICE_FACTORY_FLAG_ALLOW_RETURNING_EXISTING_DEVICE              = 0x00000001,
    D3D12_DEVICE_FACTORY_FLAG_ALLOW_RETURNING_INCOMPATIBLE_EXISTING_DEVICE = 0x00000002,
    D3D12_DEVICE_FACTORY_FLAG_DISALLOW_STORING_NEW_DEVICE_AS_SINGLETON     = 0x00000004,
}

alias D3D12_DEVICE_FLAGS = int;
enum : int
{
    D3D12_DEVICE_FLAG_NONE                                           = 0x00000000,
    D3D12_DEVICE_FLAG_DEBUG_LAYER_ENABLED                            = 0x00000001,
    D3D12_DEVICE_FLAG_GPU_BASED_VALIDATION_ENABLED                   = 0x00000002,
    D3D12_DEVICE_FLAG_SYNCHRONIZED_COMMAND_QUEUE_VALIDATION_DISABLED = 0x00000004,
    D3D12_DEVICE_FLAG_DRED_AUTO_BREADCRUMBS_ENABLED                  = 0x00000008,
    D3D12_DEVICE_FLAG_DRED_PAGE_FAULT_REPORTING_ENABLED              = 0x00000010,
    D3D12_DEVICE_FLAG_DRED_WATSON_REPORTING_ENABLED                  = 0x00000020,
    D3D12_DEVICE_FLAG_DRED_BREADCRUMB_CONTEXT_ENABLED                = 0x00000040,
    D3D12_DEVICE_FLAG_DRED_USE_MARKERS_ONLY_BREADCRUMBS              = 0x00000080,
    D3D12_DEVICE_FLAG_SHADER_INSTRUMENTATION_ENABLED                 = 0x00000100,
    D3D12_DEVICE_FLAG_AUTO_DEBUG_NAME_ENABLED                        = 0x00000200,
    D3D12_DEVICE_FLAG_FORCE_LEGACY_STATE_VALIDATION                  = 0x00000400,
}

alias D3D12_STATE_OBJECT_DATABASE_FLAGS = int;
enum : int
{
    D3D12_STATE_OBJECT_DATABASE_FLAG_NONE      = 0x00000000,
    D3D12_STATE_OBJECT_DATABASE_FLAG_READ_ONLY = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_axis_shading_rate
alias D3D12_AXIS_SHADING_RATE = int;
enum : int
{
    D3D12_AXIS_SHADING_RATE_1X = 0x00000000,
    D3D12_AXIS_SHADING_RATE_2X = 0x00000001,
    D3D12_AXIS_SHADING_RATE_4X = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shading_rate
alias D3D12_SHADING_RATE = int;
enum : int
{
    D3D12_SHADING_RATE_1X1 = 0x00000000,
    D3D12_SHADING_RATE_1X2 = 0x00000001,
    D3D12_SHADING_RATE_2X1 = 0x00000004,
    D3D12_SHADING_RATE_2X2 = 0x00000005,
    D3D12_SHADING_RATE_2X4 = 0x00000006,
    D3D12_SHADING_RATE_4X2 = 0x00000009,
    D3D12_SHADING_RATE_4X4 = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ne-d3d12-d3d12_shading_rate_combiner
alias D3D12_SHADING_RATE_COMBINER = int;
enum : int
{
    D3D12_SHADING_RATE_COMBINER_PASSTHROUGH = 0x00000000,
    D3D12_SHADING_RATE_COMBINER_OVERRIDE    = 0x00000001,
    D3D12_SHADING_RATE_COMBINER_MIN         = 0x00000002,
    D3D12_SHADING_RATE_COMBINER_MAX         = 0x00000003,
    D3D12_SHADING_RATE_COMBINER_SUM         = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/ne-d3d12shader-d3d12_shader_version_type
alias D3D12_SHADER_VERSION_TYPE = int;
enum : int
{
    D3D12_SHVER_PIXEL_SHADER          = 0x00000000,
    D3D12_SHVER_VERTEX_SHADER         = 0x00000001,
    D3D12_SHVER_GEOMETRY_SHADER       = 0x00000002,
    D3D12_SHVER_HULL_SHADER           = 0x00000003,
    D3D12_SHVER_DOMAIN_SHADER         = 0x00000004,
    D3D12_SHVER_COMPUTE_SHADER        = 0x00000005,
    D3D12_SHVER_LIBRARY               = 0x00000006,
    D3D12_SHVER_RAY_GENERATION_SHADER = 0x00000007,
    D3D12_SHVER_INTERSECTION_SHADER   = 0x00000008,
    D3D12_SHVER_ANY_HIT_SHADER        = 0x00000009,
    D3D12_SHVER_CLOSEST_HIT_SHADER    = 0x0000000a,
    D3D12_SHVER_MISS_SHADER           = 0x0000000b,
    D3D12_SHVER_CALLABLE_SHADER       = 0x0000000c,
    D3D12_SHVER_MESH_SHADER           = 0x0000000d,
    D3D12_SHVER_AMPLIFICATION_SHADER  = 0x0000000e,
    D3D12_SHVER_NODE_SHADER           = 0x0000000f,
    D3D12_SHVER_RESERVED0             = 0x0000fff0,
}

alias D3D12_COMPILER_VALUE_TYPE = int;
enum : int
{
    D3D12_COMPILER_VALUE_TYPE_OBJECT_CODE      = 0x00000000,
    D3D12_COMPILER_VALUE_TYPE_METADATA         = 0x00000001,
    D3D12_COMPILER_VALUE_TYPE_DEBUG_PDB        = 0x00000002,
    D3D12_COMPILER_VALUE_TYPE_PERFORMANCE_DATA = 0x00000003,
}

alias D3D12_COMPILER_VALUE_TYPE_FLAGS = int;
enum : int
{
    D3D12_COMPILER_VALUE_TYPE_FLAGS_NONE             = 0x00000000,
    D3D12_COMPILER_VALUE_TYPE_FLAGS_OBJECT_CODE      = 0x00000001,
    D3D12_COMPILER_VALUE_TYPE_FLAGS_METADATA         = 0x00000002,
    D3D12_COMPILER_VALUE_TYPE_FLAGS_DEBUG_PDB        = 0x00000004,
    D3D12_COMPILER_VALUE_TYPE_FLAGS_PERFORMANCE_DATA = 0x00000008,
}

// Constants


enum uint D3D12_SHADER_COMPONENT_MAPPING_ALWAYS_SET_BIT_AVOIDING_ZEROMEM_MISTAKES = 0x00001000U;
enum uint D3D12_DEFAULT_SHADER_4_COMPONENT_MAPPING = 0x00001688U;
enum uint D3D12_16BIT_INDEX_STRIP_CUT_VALUE = 0x0000ffffU;
enum uint D3D12_32BIT_INDEX_STRIP_CUT_VALUE = 0xffffffffU;
enum uint D3D12_8BIT_INDEX_STRIP_CUT_VALUE = 0x000000ffU;
enum uint D3D12_APPEND_ALIGNED_ELEMENT = 0xffffffffU;
enum uint D3D12_ARRAY_AXIS_ADDRESS_RANGE_BIT_COUNT = 0x00000009U;
enum uint D3D12_AS_TGSM_BYTES_MINIMUM_SUPPORT = 0x00008000U;

enum : uint
{
    D3D12_CLIP_OR_CULL_DISTANCE_COUNT         = 0x00000008U,
    D3D12_CLIP_OR_CULL_DISTANCE_ELEMENT_COUNT = 0x00000002U,
}

enum : uint
{
    D3D12_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT                        = 0x0000000eU,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_COMPONENTS                            = 0x00000004U,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_COMPONENT_BIT_COUNT                   = 0x00000020U,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_HW_SLOT_COUNT                         = 0x0000000fU,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_PARTIAL_UPDATE_EXTENTS_BYTE_ALIGNMENT = 0x00000010U,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_REGISTER_COMPONENTS                   = 0x00000004U,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_REGISTER_COUNT                        = 0x0000000fU,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_REGISTER_READS_PER_INST               = 0x00000001U,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_REGISTER_READ_PORTS                   = 0x00000001U,
}

enum : uint
{
    D3D12_COMMONSHADER_FLOWCONTROL_NESTING_LIMIT                         = 0x00000040U,
    D3D12_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_COMPONENTS     = 0x00000004U,
    D3D12_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_COUNT          = 0x00000001U,
    D3D12_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_READS_PER_INST = 0x00000001U,
    D3D12_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_READ_PORTS     = 0x00000001U,
    D3D12_COMMONSHADER_IMMEDIATE_VALUE_COMPONENT_BIT_COUNT               = 0x00000020U,
}

enum : uint
{
    D3D12_COMMONSHADER_INPUT_RESOURCE_REGISTER_COMPONENTS     = 0x00000001U,
    D3D12_COMMONSHADER_INPUT_RESOURCE_REGISTER_COUNT          = 0x00000080U,
    D3D12_COMMONSHADER_INPUT_RESOURCE_REGISTER_READS_PER_INST = 0x00000001U,
    D3D12_COMMONSHADER_INPUT_RESOURCE_REGISTER_READ_PORTS     = 0x00000001U,
    D3D12_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT              = 0x00000080U,
    D3D12_COMMONSHADER_SAMPLER_REGISTER_COMPONENTS            = 0x00000001U,
    D3D12_COMMONSHADER_SAMPLER_REGISTER_COUNT                 = 0x00000010U,
    D3D12_COMMONSHADER_SAMPLER_REGISTER_READS_PER_INST        = 0x00000001U,
    D3D12_COMMONSHADER_SAMPLER_REGISTER_READ_PORTS            = 0x00000001U,
    D3D12_COMMONSHADER_SAMPLER_SLOT_COUNT                     = 0x00000010U,
    D3D12_COMMONSHADER_SUBROUTINE_NESTING_LIMIT               = 0x00000020U,
    D3D12_COMMONSHADER_TEMP_REGISTER_COMPONENTS               = 0x00000004U,
    D3D12_COMMONSHADER_TEMP_REGISTER_COMPONENT_BIT_COUNT      = 0x00000020U,
    D3D12_COMMONSHADER_TEMP_REGISTER_COUNT                    = 0x00001000U,
    D3D12_COMMONSHADER_TEMP_REGISTER_READS_PER_INST           = 0x00000003U,
    D3D12_COMMONSHADER_TEMP_REGISTER_READ_PORTS               = 0x00000003U,
    D3D12_COMMONSHADER_TEXCOORD_RANGE_REDUCTION_MAX           = 0x0000000aU,
}

enum : int
{
    D3D12_COMMONSHADER_TEXCOORD_RANGE_REDUCTION_MIN = 0xfffffff6,
    D3D12_COMMONSHADER_TEXEL_OFFSET_MAX_NEGATIVE    = 0xfffffff8,
}

enum uint D3D12_COMMONSHADER_TEXEL_OFFSET_MAX_POSITIVE = 0x00000007U;
enum uint D3D12_CONSTANT_BUFFER_DATA_PLACEMENT_ALIGNMENT = 0x00000100U;

enum : uint
{
    D3D12_CS_4_X_BUCKET00_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000100U,
    D3D12_CS_4_X_BUCKET00_MAX_NUM_THREADS_PER_GROUP          = 0x00000040U,
    D3D12_CS_4_X_BUCKET01_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000f0U,
    D3D12_CS_4_X_BUCKET01_MAX_NUM_THREADS_PER_GROUP          = 0x00000044U,
    D3D12_CS_4_X_BUCKET02_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000e0U,
    D3D12_CS_4_X_BUCKET02_MAX_NUM_THREADS_PER_GROUP          = 0x00000048U,
    D3D12_CS_4_X_BUCKET03_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000d0U,
    D3D12_CS_4_X_BUCKET03_MAX_NUM_THREADS_PER_GROUP          = 0x0000004cU,
    D3D12_CS_4_X_BUCKET04_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000c0U,
    D3D12_CS_4_X_BUCKET04_MAX_NUM_THREADS_PER_GROUP          = 0x00000054U,
    D3D12_CS_4_X_BUCKET05_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000b0U,
    D3D12_CS_4_X_BUCKET05_MAX_NUM_THREADS_PER_GROUP          = 0x0000005cU,
    D3D12_CS_4_X_BUCKET06_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000a0U,
    D3D12_CS_4_X_BUCKET06_MAX_NUM_THREADS_PER_GROUP          = 0x00000064U,
    D3D12_CS_4_X_BUCKET07_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000090U,
    D3D12_CS_4_X_BUCKET07_MAX_NUM_THREADS_PER_GROUP          = 0x00000070U,
    D3D12_CS_4_X_BUCKET08_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000080U,
    D3D12_CS_4_X_BUCKET08_MAX_NUM_THREADS_PER_GROUP          = 0x00000080U,
    D3D12_CS_4_X_BUCKET09_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000070U,
    D3D12_CS_4_X_BUCKET09_MAX_NUM_THREADS_PER_GROUP          = 0x00000090U,
    D3D12_CS_4_X_BUCKET10_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000060U,
    D3D12_CS_4_X_BUCKET10_MAX_NUM_THREADS_PER_GROUP          = 0x000000a8U,
    D3D12_CS_4_X_BUCKET11_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000050U,
    D3D12_CS_4_X_BUCKET11_MAX_NUM_THREADS_PER_GROUP          = 0x000000ccU,
    D3D12_CS_4_X_BUCKET12_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000040U,
    D3D12_CS_4_X_BUCKET12_MAX_NUM_THREADS_PER_GROUP          = 0x00000100U,
    D3D12_CS_4_X_BUCKET13_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000030U,
    D3D12_CS_4_X_BUCKET13_MAX_NUM_THREADS_PER_GROUP          = 0x00000154U,
    D3D12_CS_4_X_BUCKET14_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000020U,
    D3D12_CS_4_X_BUCKET14_MAX_NUM_THREADS_PER_GROUP          = 0x00000200U,
    D3D12_CS_4_X_BUCKET15_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000010U,
    D3D12_CS_4_X_BUCKET15_MAX_NUM_THREADS_PER_GROUP          = 0x00000300U,
}

enum uint D3D12_CS_4_X_DISPATCH_MAX_THREAD_GROUPS_IN_Z_DIMENSION = 0x00000001U;
enum uint D3D12_CS_4_X_RAW_UAV_BYTE_ALIGNMENT = 0x00000100U;

enum : uint
{
    D3D12_CS_4_X_THREAD_GROUP_MAX_THREADS_PER_GROUP = 0x00000300U,
    D3D12_CS_4_X_THREAD_GROUP_MAX_X                 = 0x00000300U,
    D3D12_CS_4_X_THREAD_GROUP_MAX_Y                 = 0x00000300U,
    D3D12_CS_4_X_UAV_REGISTER_COUNT                 = 0x00000001U,
}

enum uint D3D12_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION = 0x0000ffffU;
enum uint D3D12_CS_TGSM_BYTES_MINIMUM_SUPPORT = 0x00008000U;

enum : uint
{
    D3D12_CS_TGSM_REGISTER_COUNT               = 0x00002000U,
    D3D12_CS_TGSM_REGISTER_READS_PER_INST      = 0x00000001U,
    D3D12_CS_TGSM_RESOURCE_REGISTER_COMPONENTS = 0x00000001U,
    D3D12_CS_TGSM_RESOURCE_REGISTER_READ_PORTS = 0x00000001U,
}

enum : uint
{
    D3D12_CS_THREADGROUPID_REGISTER_COMPONENTS            = 0x00000003U,
    D3D12_CS_THREADGROUPID_REGISTER_COUNT                 = 0x00000001U,
    D3D12_CS_THREADIDINGROUPFLATTENED_REGISTER_COMPONENTS = 0x00000001U,
    D3D12_CS_THREADIDINGROUPFLATTENED_REGISTER_COUNT      = 0x00000001U,
    D3D12_CS_THREADIDINGROUP_REGISTER_COMPONENTS          = 0x00000003U,
    D3D12_CS_THREADIDINGROUP_REGISTER_COUNT               = 0x00000001U,
    D3D12_CS_THREADID_REGISTER_COMPONENTS                 = 0x00000003U,
    D3D12_CS_THREADID_REGISTER_COUNT                      = 0x00000001U,
    D3D12_CS_THREAD_GROUP_MAX_THREADS_PER_GROUP           = 0x00000400U,
    D3D12_CS_THREAD_GROUP_MAX_X                           = 0x00000400U,
    D3D12_CS_THREAD_GROUP_MAX_Y                           = 0x00000400U,
    D3D12_CS_THREAD_GROUP_MAX_Z                           = 0x00000040U,
    D3D12_CS_THREAD_GROUP_MIN_X                           = 0x00000001U,
    D3D12_CS_THREAD_GROUP_MIN_Y                           = 0x00000001U,
    D3D12_CS_THREAD_GROUP_MIN_Z                           = 0x00000001U,
    D3D12_CS_THREAD_LOCAL_TEMP_REGISTER_POOL              = 0x00004000U,
}

enum : float
{
    D3D12_DEFAULT_BLEND_FACTOR_ALPHA     = 0x1p+0,
    D3D12_DEFAULT_BLEND_FACTOR_BLUE      = 0x1p+0,
    D3D12_DEFAULT_BLEND_FACTOR_GREEN     = 0x1p+0,
    D3D12_DEFAULT_BLEND_FACTOR_RED       = 0x1p+0,
    D3D12_DEFAULT_BORDER_COLOR_COMPONENT = 0x0p+0,
}

enum int D3D12_DEFAULT_DEPTH_BIAS = 0x00000000;
enum float D3D12_DEFAULT_DEPTH_BIAS_CLAMP = 0x0p+0;
enum uint D3D12_DEFAULT_MAX_ANISOTROPY = 0x00000010U;
enum float D3D12_DEFAULT_MIP_LOD_BIAS = 0x0p+0;
enum uint D3D12_DEFAULT_MSAA_RESOURCE_PLACEMENT_ALIGNMENT = 0x00400000U;

enum : uint
{
    D3D12_DEFAULT_RENDER_TARGET_ARRAY_INDEX    = 0x00000000U,
    D3D12_DEFAULT_RESOURCE_PLACEMENT_ALIGNMENT = 0x00010000U,
}

enum : uint
{
    D3D12_DEFAULT_SAMPLE_MASK    = 0xffffffffU,
    D3D12_DEFAULT_SCISSOR_ENDX   = 0x00000000U,
    D3D12_DEFAULT_SCISSOR_ENDY   = 0x00000000U,
    D3D12_DEFAULT_SCISSOR_STARTX = 0x00000000U,
    D3D12_DEFAULT_SCISSOR_STARTY = 0x00000000U,
}

enum float D3D12_DEFAULT_SLOPE_SCALED_DEPTH_BIAS = 0x0p+0;

enum : uint
{
    D3D12_DEFAULT_STENCIL_READ_MASK              = 0x000000ffU,
    D3D12_DEFAULT_STENCIL_REFERENCE              = 0x00000000U,
    D3D12_DEFAULT_STENCIL_WRITE_MASK             = 0x000000ffU,
    D3D12_DEFAULT_VIEWPORT_AND_SCISSORRECT_INDEX = 0x00000000U,
    D3D12_DEFAULT_VIEWPORT_HEIGHT                = 0x00000000U,
}

enum : float
{
    D3D12_DEFAULT_VIEWPORT_MAX_DEPTH = 0x0p+0,
    D3D12_DEFAULT_VIEWPORT_MIN_DEPTH = 0x0p+0,
}

enum : uint
{
    D3D12_DEFAULT_VIEWPORT_TOPLEFTX = 0x00000000U,
    D3D12_DEFAULT_VIEWPORT_TOPLEFTY = 0x00000000U,
    D3D12_DEFAULT_VIEWPORT_WIDTH    = 0x00000000U,
}

enum uint D3D12_DESCRIPTOR_RANGE_OFFSET_APPEND = 0xffffffffU;

enum : uint
{
    D3D12_DRIVER_RESERVED_REGISTER_SPACE_VALUES_END   = 0xfffffff7U,
    D3D12_DRIVER_RESERVED_REGISTER_SPACE_VALUES_START = 0xfffffff0U,
}

enum : uint
{
    D3D12_DS_INPUT_CONTROL_POINTS_MAX_TOTAL_SCALARS           = 0x00000f80U,
    D3D12_DS_INPUT_CONTROL_POINT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D12_DS_INPUT_CONTROL_POINT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_DS_INPUT_CONTROL_POINT_REGISTER_COUNT               = 0x00000020U,
    D3D12_DS_INPUT_CONTROL_POINT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_DS_INPUT_CONTROL_POINT_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D12_DS_INPUT_DOMAIN_POINT_REGISTER_COMPONENTS          = 0x00000003U,
    D3D12_DS_INPUT_DOMAIN_POINT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_DS_INPUT_DOMAIN_POINT_REGISTER_COUNT               = 0x00000001U,
    D3D12_DS_INPUT_DOMAIN_POINT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_DS_INPUT_DOMAIN_POINT_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D12_DS_INPUT_PATCH_CONSTANT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D12_DS_INPUT_PATCH_CONSTANT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_DS_INPUT_PATCH_CONSTANT_REGISTER_COUNT               = 0x00000020U,
    D3D12_DS_INPUT_PATCH_CONSTANT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_DS_INPUT_PATCH_CONSTANT_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D12_DS_INPUT_PRIMITIVE_ID_REGISTER_COMPONENTS          = 0x00000001U,
    D3D12_DS_INPUT_PRIMITIVE_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_DS_INPUT_PRIMITIVE_ID_REGISTER_COUNT               = 0x00000001U,
    D3D12_DS_INPUT_PRIMITIVE_ID_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_DS_INPUT_PRIMITIVE_ID_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D12_DS_OUTPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D12_DS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_DS_OUTPUT_REGISTER_COUNT               = 0x00000020U,
}

enum double D3D12_FLOAT16_FUSED_TOLERANCE_IN_ULP = 0x1.3333333333333p-1;

enum : float
{
    D3D12_FLOAT32_MAX                         = 0x1.fffffep+127,
    D3D12_FLOAT32_TO_INTEGER_TOLERANCE_IN_ULP = 0x1.333334p-1,
}

enum : float
{
    D3D12_FLOAT_TO_SRGB_EXPONENT_DENOMINATOR = 0x1.333334p+1,
    D3D12_FLOAT_TO_SRGB_EXPONENT_NUMERATOR   = 0x1p+0,
    D3D12_FLOAT_TO_SRGB_OFFSET               = 0x1.c28f5cp-5,
    D3D12_FLOAT_TO_SRGB_SCALE_1              = 0x1.9d70a4p+3,
    D3D12_FLOAT_TO_SRGB_SCALE_2              = 0x1.0e147ap+0,
    D3D12_FLOAT_TO_SRGB_THRESHOLD            = 0x1.9a5c38p-9,
}

enum : float
{
    D3D12_FTOI_INSTRUCTION_MAX_INPUT = 0x1p+31,
    D3D12_FTOI_INSTRUCTION_MIN_INPUT = -0x1p+31,
}

enum : float
{
    D3D12_FTOU_INSTRUCTION_MAX_INPUT = 0x1p+32,
    D3D12_FTOU_INSTRUCTION_MIN_INPUT = 0x0p+0,
}

enum : uint
{
    D3D12_GS_INPUT_INSTANCE_ID_READS_PER_INST               = 0x00000002U,
    D3D12_GS_INPUT_INSTANCE_ID_READ_PORTS                   = 0x00000001U,
    D3D12_GS_INPUT_INSTANCE_ID_REGISTER_COMPONENTS          = 0x00000001U,
    D3D12_GS_INPUT_INSTANCE_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_GS_INPUT_INSTANCE_ID_REGISTER_COUNT               = 0x00000001U,
}

enum : uint
{
    D3D12_GS_INPUT_PRIM_CONST_REGISTER_COMPONENTS          = 0x00000001U,
    D3D12_GS_INPUT_PRIM_CONST_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_GS_INPUT_PRIM_CONST_REGISTER_COUNT               = 0x00000001U,
    D3D12_GS_INPUT_PRIM_CONST_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_GS_INPUT_PRIM_CONST_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D12_GS_INPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D12_GS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_GS_INPUT_REGISTER_COUNT               = 0x00000020U,
    D3D12_GS_INPUT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_GS_INPUT_REGISTER_READ_PORTS          = 0x00000001U,
    D3D12_GS_INPUT_REGISTER_VERTICES            = 0x00000020U,
}

enum : uint
{
    D3D12_GS_MAX_INSTANCE_COUNT                       = 0x00000020U,
    D3D12_GS_MAX_OUTPUT_VERTEX_COUNT_ACROSS_INSTANCES = 0x00000400U,
}

enum : uint
{
    D3D12_GS_OUTPUT_ELEMENTS                     = 0x00000020U,
    D3D12_GS_OUTPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D12_GS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_GS_OUTPUT_REGISTER_COUNT               = 0x00000020U,
}

enum : uint
{
    D3D12_GUID_TEXTURE_LAYOUT_ROW_MAJOR_HEIGHT_ALIGNMENT = 0x00000004U,
    D3D12_GUID_TEXTURE_LAYOUT_ROW_MAJOR_PITCH_ALIGNMENT  = 0x00000100U,
    D3D12_GUID_TEXTURE_LAYOUT_ROW_MAJOR_PLANE_ALIGNMENT  = 0x00001000U,
}

enum : uint
{
    D3D12_HS_CONTROL_POINT_PHASE_INPUT_REGISTER_COUNT   = 0x00000020U,
    D3D12_HS_CONTROL_POINT_PHASE_OUTPUT_REGISTER_COUNT  = 0x00000020U,
    D3D12_HS_CONTROL_POINT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D12_HS_CONTROL_POINT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_HS_CONTROL_POINT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_HS_CONTROL_POINT_REGISTER_READ_PORTS          = 0x00000001U,
}

enum uint D3D12_HS_FORK_PHASE_INSTANCE_COUNT_UPPER_BOUND = 0xffffffffU;

enum : uint
{
    D3D12_HS_INPUT_FORK_INSTANCE_ID_REGISTER_COMPONENTS          = 0x00000001U,
    D3D12_HS_INPUT_FORK_INSTANCE_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_HS_INPUT_FORK_INSTANCE_ID_REGISTER_COUNT               = 0x00000001U,
    D3D12_HS_INPUT_FORK_INSTANCE_ID_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_HS_INPUT_FORK_INSTANCE_ID_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D12_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_COMPONENTS          = 0x00000001U,
    D3D12_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_COUNT               = 0x00000001U,
    D3D12_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D12_HS_INPUT_PRIMITIVE_ID_REGISTER_COMPONENTS          = 0x00000001U,
    D3D12_HS_INPUT_PRIMITIVE_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_HS_INPUT_PRIMITIVE_ID_REGISTER_COUNT               = 0x00000001U,
    D3D12_HS_INPUT_PRIMITIVE_ID_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_HS_INPUT_PRIMITIVE_ID_REGISTER_READ_PORTS          = 0x00000001U,
}

enum uint D3D12_HS_JOIN_PHASE_INSTANCE_COUNT_UPPER_BOUND = 0xffffffffU;

enum : float
{
    D3D12_HS_MAXTESSFACTOR_LOWER_BOUND = 0x1p+0,
    D3D12_HS_MAXTESSFACTOR_UPPER_BOUND = 0x1p+6,
}

enum : uint
{
    D3D12_HS_OUTPUT_CONTROL_POINTS_MAX_TOTAL_SCALARS              = 0x00000f80U,
    D3D12_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_COMPONENTS          = 0x00000001U,
    D3D12_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_COUNT               = 0x00000001U,
    D3D12_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_COUNT               = 0x00000020U,
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_READ_PORTS          = 0x00000001U,
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_SCALAR_COMPONENTS   = 0x00000080U,
}

enum uint D3D12_IA_DEFAULT_INDEX_BUFFER_OFFSET_IN_BYTES = 0x00000000U;

enum : uint
{
    D3D12_IA_DEFAULT_PRIMITIVE_TOPOLOGY            = 0x00000000U,
    D3D12_IA_DEFAULT_VERTEX_BUFFER_OFFSET_IN_BYTES = 0x00000000U,
}

enum uint D3D12_IA_INDEX_INPUT_RESOURCE_SLOT_COUNT = 0x00000001U;
enum uint D3D12_IA_INSTANCE_ID_BIT_COUNT = 0x00000020U;
enum uint D3D12_IA_INTEGER_ARITHMETIC_BIT_COUNT = 0x00000020U;
enum uint D3D12_IA_PATCH_MAX_CONTROL_POINT_COUNT = 0x00000020U;
enum uint D3D12_IA_PRIMITIVE_ID_BIT_COUNT = 0x00000020U;

enum : uint
{
    D3D12_IA_VERTEX_ID_BIT_COUNT                        = 0x00000020U,
    D3D12_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT           = 0x00000020U,
    D3D12_IA_VERTEX_INPUT_STRUCTURE_ELEMENTS_COMPONENTS = 0x00000080U,
    D3D12_IA_VERTEX_INPUT_STRUCTURE_ELEMENT_COUNT       = 0x00000020U,
}

enum : uint
{
    D3D12_INTEGER_DIVIDE_BY_ZERO_QUOTIENT  = 0xffffffffU,
    D3D12_INTEGER_DIVIDE_BY_ZERO_REMAINDER = 0xffffffffU,
}

enum uint D3D12_KEEP_RENDER_TARGETS_AND_DEPTH_STENCIL = 0xffffffffU;
enum uint D3D12_KEEP_UNORDERED_ACCESS_VIEWS = 0xffffffffU;
enum float D3D12_LINEAR_GAMMA = 0x1p+0;
enum uint D3D12_MAJOR_VERSION = 0x0000000cU;
enum float D3D12_MAX_BORDER_COLOR_COMPONENT = 0x1p+0;
enum float D3D12_MAX_DEPTH = 0x1p+0;
enum uint D3D12_MAX_LIVE_STATIC_SAMPLERS = 0x000007f0U;

enum : uint
{
    D3D12_MAX_MAXANISOTROPY            = 0x00000010U,
    D3D12_MAX_MULTISAMPLE_SAMPLE_COUNT = 0x00000020U,
}

enum float D3D12_MAX_POSITION_VALUE = 0x1.a36e2ep+114;

enum : uint
{
    D3D12_MAX_ROOT_COST                                  = 0x00000040U,
    D3D12_MAX_SHADER_VISIBLE_DESCRIPTOR_HEAP_SIZE_TIER_1 = 0x000f4240U,
    D3D12_MAX_SHADER_VISIBLE_DESCRIPTOR_HEAP_SIZE_TIER_2 = 0x000f4240U,
    D3D12_MAX_SHADER_VISIBLE_SAMPLER_HEAP_SIZE           = 0x00000800U,
}

enum uint D3D12_MAX_TEXTURE_DIMENSION_2_TO_EXP = 0x00000011U;
enum uint D3D12_MAX_VIEW_INSTANCE_COUNT = 0x00000004U;
enum uint D3D12_MINOR_VERSION = 0x00000000U;
enum float D3D12_MIN_BORDER_COLOR_COMPONENT = 0x0p+0;
enum float D3D12_MIN_DEPTH = 0x0p+0;
enum uint D3D12_MIN_MAXANISOTROPY = 0x00000000U;

enum : float
{
    D3D12_MIP_LOD_BIAS_MAX = 0x1.ffae14p+3,
    D3D12_MIP_LOD_BIAS_MIN = -0x1p+4,
}

enum : uint
{
    D3D12_MIP_LOD_FRACTIONAL_BIT_COUNT = 0x00000008U,
    D3D12_MIP_LOD_RANGE_BIT_COUNT      = 0x00000008U,
}

enum uint D3D12_MS_DISPATCH_MAX_THREAD_GROUPS_PER_GRID = 0x003fffffU;
enum uint D3D12_MS_TGSM_BYTES_MINIMUM_SUPPORT = 0x00007000U;
enum float D3D12_MULTISAMPLE_ANTIALIAS_LINE_WIDTH = 0x1.666666p+0;
enum uint D3D12_NONSAMPLE_FETCH_OUT_OF_RANGE_ACCESS_RESULT = 0x00000000U;

enum : uint
{
    D3D12_OS_RESERVED_REGISTER_SPACE_VALUES_END   = 0xffffffffU,
    D3D12_OS_RESERVED_REGISTER_SPACE_VALUES_START = 0xfffffff8U,
}

enum : uint
{
    D3D12_PACKED_TILE                   = 0xffffffffU,
    D3D12_PIXEL_ADDRESS_RANGE_BIT_COUNT = 0x0000000fU,
}

enum uint D3D12_PREVIEW_SDK_VERSION = 0x000002cfU;
enum uint D3D12_PRE_SCISSOR_PIXEL_ADDRESS_RANGE_BIT_COUNT = 0x00000010U;

enum : uint
{
    D3D12_PS_CS_UAV_REGISTER_COMPONENTS     = 0x00000001U,
    D3D12_PS_CS_UAV_REGISTER_COUNT          = 0x00000008U,
    D3D12_PS_CS_UAV_REGISTER_READS_PER_INST = 0x00000001U,
    D3D12_PS_CS_UAV_REGISTER_READ_PORTS     = 0x00000001U,
}

enum : uint
{
    D3D12_PS_FRONTFACING_DEFAULT_VALUE = 0xffffffffU,
    D3D12_PS_FRONTFACING_FALSE_VALUE   = 0x00000000U,
    D3D12_PS_FRONTFACING_TRUE_VALUE    = 0xffffffffU,
}

enum : uint
{
    D3D12_PS_INPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D12_PS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_PS_INPUT_REGISTER_COUNT               = 0x00000020U,
    D3D12_PS_INPUT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_PS_INPUT_REGISTER_READ_PORTS          = 0x00000001U,
}

enum float D3D12_PS_LEGACY_PIXEL_CENTER_FRACTIONAL_COMPONENT = 0x0p+0;

enum : uint
{
    D3D12_PS_OUTPUT_DEPTH_REGISTER_COMPONENTS          = 0x00000001U,
    D3D12_PS_OUTPUT_DEPTH_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_PS_OUTPUT_DEPTH_REGISTER_COUNT               = 0x00000001U,
    D3D12_PS_OUTPUT_MASK_REGISTER_COMPONENTS           = 0x00000001U,
    D3D12_PS_OUTPUT_MASK_REGISTER_COMPONENT_BIT_COUNT  = 0x00000020U,
    D3D12_PS_OUTPUT_MASK_REGISTER_COUNT                = 0x00000001U,
    D3D12_PS_OUTPUT_REGISTER_COMPONENTS                = 0x00000004U,
    D3D12_PS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT       = 0x00000020U,
    D3D12_PS_OUTPUT_REGISTER_COUNT                     = 0x00000008U,
}

enum float D3D12_PS_PIXEL_CENTER_FRACTIONAL_COMPONENT = 0x1p-1;
enum uint D3D12_RAW_UAV_SRV_BYTE_ALIGNMENT = 0x00000010U;

enum : uint
{
    D3D12_RAYTRACING_AABB_BYTE_ALIGNMENT                   = 0x00000008U,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BYTE_ALIGNMENT = 0x00000100U,
}

enum uint D3D12_RAYTRACING_INSTANCE_DESCS_BYTE_ALIGNMENT = 0x00000010U;

enum : uint
{
    D3D12_RAYTRACING_MAX_ATTRIBUTE_SIZE_IN_BYTES          = 0x00000020U,
    D3D12_RAYTRACING_MAX_DECLARABLE_TRACE_RECURSION_DEPTH = 0x0000001fU,
}

enum uint D3D12_RAYTRACING_MAX_GEOMETRIES_PER_BOTTOM_LEVEL_ACCELERATION_STRUCTURE = 0x01000000U;
enum uint D3D12_RAYTRACING_MAX_INSTANCES_PER_TOP_LEVEL_ACCELERATION_STRUCTURE = 0x01000000U;
enum uint D3D12_RAYTRACING_MAX_PRIMITIVES_PER_BOTTOM_LEVEL_ACCELERATION_STRUCTURE = 0x20000000U;

enum : uint
{
    D3D12_RAYTRACING_MAX_RAY_GENERATION_SHADER_THREADS          = 0x40000000U,
    D3D12_RAYTRACING_MAX_SHADER_RECORD_STRIDE                   = 0x00001000U,
    D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_BYTE_ALIGNMENT      = 0x00000080U,
    D3D12_RAYTRACING_OPACITY_MICROMAP_OC1_MAX_SUBDIVISION_LEVEL = 0x0000000cU,
}

enum : uint
{
    D3D12_RAYTRACING_SHADER_RECORD_BYTE_ALIGNMENT = 0x00000020U,
    D3D12_RAYTRACING_SHADER_TABLE_BYTE_ALIGNMENT  = 0x00000040U,
}

enum uint D3D12_RAYTRACING_TRANSFORM3X4_BYTE_ALIGNMENT = 0x00000010U;
enum uint D3D12_REQ_BLEND_OBJECT_COUNT_PER_DEVICE = 0x00001000U;
enum uint D3D12_REQ_BUFFER_RESOURCE_TEXEL_COUNT_2_TO_EXP = 0x0000001bU;
enum uint D3D12_REQ_CONSTANT_BUFFER_ELEMENT_COUNT = 0x00001000U;
enum uint D3D12_REQ_DEPTH_STENCIL_OBJECT_COUNT_PER_DEVICE = 0x00001000U;
enum uint D3D12_REQ_DRAWINDEXED_INDEX_COUNT_2_TO_EXP = 0x00000020U;
enum uint D3D12_REQ_DRAW_VERTEX_COUNT_2_TO_EXP = 0x00000020U;
enum uint D3D12_REQ_FILTERING_HW_ADDRESSABLE_RESOURCE_DIMENSION = 0x00004000U;
enum uint D3D12_REQ_GS_INVOCATION_32BIT_OUTPUT_COMPONENT_LIMIT = 0x00000400U;
enum uint D3D12_REQ_IMMEDIATE_CONSTANT_BUFFER_ELEMENT_COUNT = 0x00001000U;

enum : uint
{
    D3D12_REQ_MAXANISOTROPY                         = 0x00000010U,
    D3D12_REQ_MIP_LEVELS                            = 0x0000000fU,
    D3D12_REQ_MULTI_ELEMENT_STRUCTURE_SIZE_IN_BYTES = 0x00000800U,
}

enum uint D3D12_REQ_RASTERIZER_OBJECT_COUNT_PER_DEVICE = 0x00001000U;
enum uint D3D12_REQ_RENDER_TO_BUFFER_WINDOW_WIDTH = 0x00004000U;
enum uint D3D12_REQ_RESOURCE_SIZE_IN_MEGABYTES_EXPRESSION_A_TERM = 0x00000080U;
enum float D3D12_REQ_RESOURCE_SIZE_IN_MEGABYTES_EXPRESSION_B_TERM = 0x1p-2;
enum uint D3D12_REQ_RESOURCE_SIZE_IN_MEGABYTES_EXPRESSION_C_TERM = 0x00000800U;
enum uint D3D12_REQ_RESOURCE_VIEW_COUNT_PER_DEVICE_2_TO_EXP = 0x00000014U;
enum uint D3D12_REQ_SAMPLER_OBJECT_COUNT_PER_DEVICE = 0x00001000U;

enum : uint
{
    D3D12_REQ_SUBRESOURCES                   = 0x00007800U,
    D3D12_REQ_TEXTURE1D_ARRAY_AXIS_DIMENSION = 0x00000800U,
    D3D12_REQ_TEXTURE1D_U_DIMENSION          = 0x00004000U,
    D3D12_REQ_TEXTURE2D_ARRAY_AXIS_DIMENSION = 0x00000800U,
    D3D12_REQ_TEXTURE2D_U_OR_V_DIMENSION     = 0x00004000U,
    D3D12_REQ_TEXTURE3D_U_V_OR_W_DIMENSION   = 0x00000800U,
    D3D12_REQ_TEXTURECUBE_DIMENSION          = 0x00004000U,
}

enum uint D3D12_RESINFO_INSTRUCTION_MISSING_COMPONENT_RETVAL = 0x00000000U;
enum uint D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES = 0xffffffffU;
enum uint D3D12_RS_SET_SHADING_RATE_COMBINER_COUNT = 0x00000002U;

enum : uint
{
    D3D12_SDK_VERSION                     = 0x0000026bU,
    D3D12_SHADER_IDENTIFIER_SIZE_IN_BYTES = 0x00000020U,
}

enum : uint
{
    D3D12_SHADER_MAJOR_VERSION            = 0x00000005U,
    D3D12_SHADER_MAX_INSTANCES            = 0x0000ffffU,
    D3D12_SHADER_MAX_INTERFACES           = 0x000000fdU,
    D3D12_SHADER_MAX_INTERFACE_CALL_SITES = 0x00001000U,
    D3D12_SHADER_MAX_TYPES                = 0x0000ffffU,
    D3D12_SHADER_MINOR_VERSION            = 0x00000001U,
}

enum : uint
{
    D3D12_SHIFT_INSTRUCTION_PAD_VALUE             = 0x00000000U,
    D3D12_SHIFT_INSTRUCTION_SHIFT_VALUE_BIT_COUNT = 0x00000005U,
}

enum uint D3D12_SIMULTANEOUS_RENDER_TARGET_COUNT = 0x00000008U;
enum uint D3D12_SMALL_MSAA_RESOURCE_PLACEMENT_ALIGNMENT = 0x00010000U;
enum uint D3D12_SMALL_RESOURCE_PLACEMENT_ALIGNMENT = 0x00001000U;

enum : uint
{
    D3D12_SO_BUFFER_MAX_STRIDE_IN_BYTES       = 0x00000800U,
    D3D12_SO_BUFFER_MAX_WRITE_WINDOW_IN_BYTES = 0x00000200U,
}

enum uint D3D12_SO_BUFFER_SLOT_COUNT = 0x00000004U;
enum uint D3D12_SO_DDI_REGISTER_INDEX_DENOTING_GAP = 0xffffffffU;
enum uint D3D12_SO_NO_RASTERIZED_STREAM = 0xffffffffU;
enum uint D3D12_SO_OUTPUT_COMPONENT_COUNT = 0x00000080U;
enum uint D3D12_SO_STREAM_COUNT = 0x00000004U;

enum : uint
{
    D3D12_SPEC_DATE_DAY   = 0x0000000eU,
    D3D12_SPEC_DATE_MONTH = 0x0000000bU,
    D3D12_SPEC_DATE_YEAR  = 0x000007deU,
}

enum double D3D12_SPEC_VERSION = 0x1.28f5c28f5c28fp+0;

enum : float
{
    D3D12_SRGB_GAMMA                     = 0x1.19999ap+1,
    D3D12_SRGB_TO_FLOAT_DENOMINATOR_1    = 0x1.9d70a4p+3,
    D3D12_SRGB_TO_FLOAT_DENOMINATOR_2    = 0x1.0e147ap+0,
    D3D12_SRGB_TO_FLOAT_EXPONENT         = 0x1.333334p+1,
    D3D12_SRGB_TO_FLOAT_OFFSET           = 0x1.c28f5cp-5,
    D3D12_SRGB_TO_FLOAT_THRESHOLD        = 0x1.4b5dccp-5,
    D3D12_SRGB_TO_FLOAT_TOLERANCE_IN_ULP = 0x1p-1,
}

enum : uint
{
    D3D12_STANDARD_COMPONENT_BIT_COUNT         = 0x00000020U,
    D3D12_STANDARD_COMPONENT_BIT_COUNT_DOUBLED = 0x00000040U,
}

enum uint D3D12_STANDARD_MAXIMUM_ELEMENT_ALIGNMENT_BYTE_MULTIPLE = 0x00000004U;

enum : uint
{
    D3D12_STANDARD_PIXEL_COMPONENT_COUNT        = 0x00000080U,
    D3D12_STANDARD_PIXEL_ELEMENT_COUNT          = 0x00000020U,
    D3D12_STANDARD_VECTOR_SIZE                  = 0x00000004U,
    D3D12_STANDARD_VERTEX_ELEMENT_COUNT         = 0x00000020U,
    D3D12_STANDARD_VERTEX_TOTAL_COMPONENT_COUNT = 0x00000040U,
}

enum uint D3D12_SUBPIXEL_FRACTIONAL_BIT_COUNT = 0x00000008U;
enum uint D3D12_SUBTEXEL_FRACTIONAL_BIT_COUNT = 0x00000008U;

enum : uint
{
    D3D12_SYSTEM_RESERVED_REGISTER_SPACE_VALUES_END   = 0xffffffffU,
    D3D12_SYSTEM_RESERVED_REGISTER_SPACE_VALUES_START = 0xfffffff0U,
}

enum : uint
{
    D3D12_TESSELLATOR_MAX_EVEN_TESSELLATION_FACTOR            = 0x00000040U,
    D3D12_TESSELLATOR_MAX_ISOLINE_DENSITY_TESSELLATION_FACTOR = 0x00000040U,
}

enum : uint
{
    D3D12_TESSELLATOR_MAX_ODD_TESSELLATION_FACTOR             = 0x0000003fU,
    D3D12_TESSELLATOR_MAX_TESSELLATION_FACTOR                 = 0x00000040U,
    D3D12_TESSELLATOR_MIN_EVEN_TESSELLATION_FACTOR            = 0x00000002U,
    D3D12_TESSELLATOR_MIN_ISOLINE_DENSITY_TESSELLATION_FACTOR = 0x00000001U,
}

enum uint D3D12_TESSELLATOR_MIN_ODD_TESSELLATION_FACTOR = 0x00000001U;
enum uint D3D12_TEXEL_ADDRESS_RANGE_BIT_COUNT = 0x00000010U;

enum : uint
{
    D3D12_TEXTURE_DATA_PITCH_ALIGNMENT     = 0x00000100U,
    D3D12_TEXTURE_DATA_PLACEMENT_ALIGNMENT = 0x00000200U,
}

enum : uint
{
    D3D12_TIGHT_ALIGNMENT_MIN_COMMITTED_RESOURCE_ALIGNMENT = 0x00001000U,
    D3D12_TIGHT_ALIGNMENT_MIN_PLACED_RESOURCE_ALIGNMENT    = 0x00000008U,
}

enum uint D3D12_TILED_RESOURCE_TILE_SIZE_IN_BYTES = 0x00010000U;
enum uint D3D12_TRACKED_WORKLOAD_MAX_INSTANCES = 0x00000020U;
enum uint D3D12_UAV_COUNTER_PLACEMENT_ALIGNMENT = 0x00001000U;
enum uint D3D12_UAV_SLOT_COUNT = 0x00000040U;
enum uint D3D12_UNBOUND_MEMORY_ACCESS_RESULT = 0x00000000U;

enum : uint
{
    D3D12_VIDEO_DECODE_MAX_ARGUMENTS                  = 0x0000000aU,
    D3D12_VIDEO_DECODE_MAX_HISTOGRAM_COMPONENTS       = 0x00000004U,
    D3D12_VIDEO_DECODE_MIN_BITSTREAM_OFFSET_ALIGNMENT = 0x00000100U,
    D3D12_VIDEO_DECODE_MIN_HISTOGRAM_OFFSET_ALIGNMENT = 0x00000100U,
}

enum uint D3D12_VIDEO_DECODE_STATUS_MACROBLOCKS_AFFECTED_UNKNOWN = 0xffffffffU;

enum : uint
{
    D3D12_VIDEO_ENCODER_AV1_INVALID_DPB_RESOURCE_INDEX = 0x000000ffU,
    D3D12_VIDEO_ENCODER_AV1_MAX_TILE_COLS              = 0x00000040U,
    D3D12_VIDEO_ENCODER_AV1_MAX_TILE_ROWS              = 0x00000040U,
    D3D12_VIDEO_ENCODER_AV1_SUPERRES_DENOM_MIN         = 0x00000009U,
    D3D12_VIDEO_ENCODER_AV1_SUPERRES_NUM               = 0x00000008U,
}

enum : uint
{
    D3D12_VIDEO_PROCESS_MAX_FILTERS  = 0x00000020U,
    D3D12_VIDEO_PROCESS_STEREO_VIEWS = 0x00000002U,
}

enum : uint
{
    D3D12_VIEWPORT_AND_SCISSORRECT_MAX_INDEX                 = 0x0000000fU,
    D3D12_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE = 0x00000010U,
}

enum uint D3D12_VIEWPORT_BOUNDS_MAX = 0x00007fffU;
enum int D3D12_VIEWPORT_BOUNDS_MIN = 0xffff8000;

enum : uint
{
    D3D12_VS_INPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D12_VS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_VS_INPUT_REGISTER_COUNT               = 0x00000020U,
    D3D12_VS_INPUT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D12_VS_INPUT_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D12_VS_OUTPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D12_VS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D12_VS_OUTPUT_REGISTER_COUNT               = 0x00000020U,
}

enum uint D3D12_WHQL_CONTEXT_COUNT_FOR_RESOURCE_LIMIT = 0x0000000aU;
enum uint D3D12_WHQL_DRAWINDEXED_INDEX_COUNT_2_TO_EXP = 0x00000019U;
enum uint D3D12_WHQL_DRAW_VERTEX_COUNT_2_TO_EXP = 0x00000019U;
enum uint D3D12_WORK_GRAPHS_BACKING_MEMORY_ALIGNMENT_IN_BYTES = 0x00000008U;
enum uint D3D12_WORK_GRAPHS_DISPATCH_MAX_THREAD_GROUPS_PER_GRID = 0x00ffffffU;
enum uint D3D12_WORK_GRAPHS_MAX_NODE_DEPTH = 0x00000020U;
enum uint LUID_DEFINED = 0x00000001U;

enum : uint
{
    D3D12_SHADER_COMPONENT_MAPPING_MASK  = 0x00000007U,
    D3D12_SHADER_COMPONENT_MAPPING_SHIFT = 0x00000003U,
}

enum : uint
{
    D3D12_FILTER_REDUCTION_TYPE_MASK  = 0x00000003U,
    D3D12_FILTER_REDUCTION_TYPE_SHIFT = 0x00000007U,
}

enum uint D3D12_FILTER_TYPE_MASK = 0x00000003U;
enum uint D3D12_MIN_FILTER_SHIFT = 0x00000004U;
enum uint D3D12_MAG_FILTER_SHIFT = 0x00000002U;
enum uint D3D12_MIP_FILTER_SHIFT = 0x00000000U;
enum uint D3D12_ANISOTROPIC_FILTERING_BIT = 0x00000040U;
enum GUID D3D12_PROTECTED_RESOURCES_SESSION_HARDWARE_PROTECTED = GUID("62b0084e-c70e-4daa-a109-30ff8d5a0482");

enum : GUID
{
    CLSID_D3D12Debug                     = GUID("f2352aeb-dd84-49fe-b97b-a9dcfdcc1b4f"),
    CLSID_D3D12Tools                     = GUID("e38216b1-3c8c-4833-aa09-0a06b65d96c8"),
    CLSID_D3D12DeviceRemovedExtendedData = GUID("4a75bbc4-9ff4-4ad8-9f18-abae84dc5ff2"),
}

enum : GUID
{
    CLSID_D3D12SDKConfiguration   = GUID("7cda6aca-a03e-49c8-9458-0334d20e07ce"),
    CLSID_D3D12DeviceFactory      = GUID("114863bf-c386-4aee-b39d-8f0bbb062955"),
    CLSID_D3D12DSRDeviceFactory   = GUID("bb6dd27e-94a9-41a6-9f1b-133772172428"),
    CLSID_D3D12StateObjectFactory = GUID("54e1c9f3-1303-4112-bf8e-7bf2bb606a73"),
}

enum GUID CLSID_D3D12RuntimeValidationControl = GUID("e5b53e74-3fca-47b4-88b9-a8b41ef8fb73");
enum GUID CLSID_D3D12ApplicationIdentity = GUID("08d8e1e8-75a6-42a7-bf3a-d05fe529c47c");

enum : uint
{
    D3D12_SHADING_RATE_X_AXIS_SHIFT = 0x00000002U,
    D3D12_SHADING_RATE_VALID_MASK   = 0x00000003U,
}

enum GUID WKPDID_D3DAutoDebugObjectNameW = GUID("d4902e36-757a-4942-9594-b6769afa43cd");
enum GUID DXGI_DEBUG_D3D12 = GUID("cf59a98c-a950-4326-91ef-9bbaa17bfd95");
enum uint D3D12_INFO_QUEUE_DEFAULT_MESSAGE_COUNT_LIMIT = 0x00000400U;

enum : uint
{
    D3D_SHADER_REQUIRES_STENCIL_REF                       = 0x00000200U,
    D3D_SHADER_REQUIRES_INNER_COVERAGE                    = 0x00000400U,
    D3D_SHADER_REQUIRES_TYPED_UAV_LOAD_ADDITIONAL_FORMATS = 0x00000800U,
}

enum : uint
{
    D3D_SHADER_REQUIRES_ROVS                                                           = 0x00001000U,
    D3D_SHADER_REQUIRES_VIEWPORT_AND_RT_ARRAY_INDEX_FROM_ANY_SHADER_FEEDING_RASTERIZER = 0x00002000U,
}

enum : uint
{
    D3D_SHADER_REQUIRES_WAVE_OPS                                      = 0x00004000U,
    D3D_SHADER_REQUIRES_INT64_OPS                                     = 0x00008000U,
    D3D_SHADER_REQUIRES_VIEW_ID                                       = 0x00010000U,
    D3D_SHADER_REQUIRES_BARYCENTRICS                                  = 0x00020000U,
    D3D_SHADER_REQUIRES_NATIVE_16BIT_OPS                              = 0x00040000U,
    D3D_SHADER_REQUIRES_SHADING_RATE                                  = 0x00080000U,
    D3D_SHADER_REQUIRES_RAYTRACING_TIER_1_1                           = 0x00100000U,
    D3D_SHADER_REQUIRES_SAMPLER_FEEDBACK                              = 0x00200000U,
    D3D_SHADER_REQUIRES_ATOMIC_INT64_ON_TYPED_RESOURCE                = 0x00400000U,
    D3D_SHADER_REQUIRES_ATOMIC_INT64_ON_GROUP_SHARED                  = 0x00800000U,
    D3D_SHADER_REQUIRES_DERIVATIVES_IN_MESH_AND_AMPLIFICATION_SHADERS = 0x01000000U,
}

enum uint D3D_SHADER_REQUIRES_RESOURCE_DESCRIPTOR_HEAP_INDEXING = 0x02000000U;
enum uint D3D_SHADER_REQUIRES_SAMPLER_DESCRIPTOR_HEAP_INDEXING = 0x04000000U;

enum : uint
{
    D3D_SHADER_REQUIRES_WAVE_MMA                                 = 0x08000000U,
    D3D_SHADER_REQUIRES_ATOMIC_INT64_ON_DESCRIPTOR_HEAP_RESOURCE = 0x10000000U,
}

enum : uint
{
    D3D_SHADER_REQUIRES_ADVANCED_TEXTURE_OPS        = 0x20000000U,
    D3D_SHADER_REQUIRES_WRITEABLE_MSAA_TEXTURES     = 0x40000000U,
    D3D_SHADER_REQUIRES_SAMPLE_CMP_GRADIENT_OR_BIAS = 0x80000000U,
}

enum GUID D3D12ExperimentalShaderModels = GUID("76f5573e-f13a-40f5-b297-81ce9e18933f");
enum GUID D3D12GPUUploadHeapsOnUnsupportedOS = GUID("45dc51f3-767f-4588-b206-0baa2b16fbae");

// Callbacks

alias PFN_D3D12_SERIALIZE_ROOT_SIGNATURE = HRESULT function(const(D3D12_ROOT_SIGNATURE_DESC)* pRootSignature, 
                                                            D3D_ROOT_SIGNATURE_VERSION Version, ID3DBlob* ppBlob, 
                                                            ID3DBlob* ppErrorBlob);
alias PFN_D3D12_CREATE_ROOT_SIGNATURE_DESERIALIZER = HRESULT function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                                                                      size_t SrcDataSizeInBytes, 
                                                                      const(GUID)* pRootSignatureDeserializerInterface, 
                                                                      void** ppRootSignatureDeserializer);
alias PFN_D3D12_SERIALIZE_VERSIONED_ROOT_SIGNATURE = HRESULT function(const(D3D12_VERSIONED_ROOT_SIGNATURE_DESC)* pRootSignature, 
                                                                      ID3DBlob* ppBlob, ID3DBlob* ppErrorBlob);
alias PFN_D3D12_CREATE_VERSIONED_ROOT_SIGNATURE_DESERIALIZER = HRESULT function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                                                                                size_t SrcDataSizeInBytes, 
                                                                                const(GUID)* pRootSignatureDeserializerInterface, 
                                                                                void** ppRootSignatureDeserializer);
alias PFN_D3D12_CREATE_VERSIONED_ROOT_SIGNATURE_DESERIALIZER_FROM_SUBOBJECT_IN_LIBRARY = HRESULT function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                                                                                                          size_t SrcDataSizeInBytes, 
                                                                                                          const(PWSTR) RootSignatureSubobjectName, 
                                                                                                          const(GUID)* pRootSignatureDeserializerInterface, 
                                                                                                          void** ppRootSignatureDeserializer);
alias D3D12_PFN_TRIM_NOTIFICATION_CALLBACK = void function(const(D3D12_TRIM_NOTIFICATION)* __MIDL____MIDL_itf_d3d12_0000_00640000);
alias D3D12PipelineStateFunc = void function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pKey, 
                                             uint KeySize, uint Version, 
                                             const(D3D12_PIPELINE_STATE_STREAM_DESC)* pDesc, void* pContext);
alias D3D12StateObjectFunc = void function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pKey, 
                                           uint KeySize, uint Version, const(D3D12_STATE_OBJECT_DESC)* pDesc, 
                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* pParentKey, 
                                           uint ParentKeySize, void* pContext);
alias D3D12ApplicationDescFunc = void function(const(D3D12_APPLICATION_DESC)* pApplicationDesc, void* pContext);
alias D3D12MessageFunc = void function(D3D12_MESSAGE_CATEGORY Category, D3D12_MESSAGE_SEVERITY Severity, 
                                       D3D12_MESSAGE_ID ID, const(PSTR) pDescription, void* pContext);
alias PFN_D3D12_CREATE_DEVICE = HRESULT function(IUnknown param0, D3D_FEATURE_LEVEL param1, const(GUID)* param2, 
                                                 void** param3);
alias PFN_D3D12_GET_DEBUG_INTERFACE = HRESULT function(const(GUID)* param0, void** param1);
alias PFN_D3D12_GET_INTERFACE = HRESULT function(const(GUID)* param0, const(GUID)* param1, void** param2);
alias PFN_D3D12_COMPILER_CREATE_FACTORY = HRESULT function(const(PWSTR) pPluginCompilerDllPath, const(GUID)* riid, 
                                                           void** ppFactory);
alias PFN_D3D12_COMPILER_SERIALIZE_VERSIONED_ROOT_SIGNATURE = HRESULT function(const(D3D12_VERSIONED_ROOT_SIGNATURE_DESC)* pRootSignature, 
                                                                               ID3DBlob* ppBlob, 
                                                                               ID3DBlob* ppErrorBlob);
alias D3D12CompilerCacheSessionAllocationFunc = void* function(size_t SizeInBytes, void* pContext);
alias D3D12CompilerCacheSessionGroupValueKeysFunc = void function(const(D3D12_COMPILER_CACHE_VALUE_KEY)* pValueKey, 
                                                                  void* pContext);
alias D3D12CompilerCacheSessionGroupValuesFunc = void function(uint ValueKeyIndex, 
                                                               const(D3D12_COMPILER_CACHE_TYPED_CONST_VALUE)* pTypedValue, 
                                                               void* pContext);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_command_queue_desc
struct D3D12_COMMAND_QUEUE_DESC
{
    D3D12_COMMAND_LIST_TYPE Type;
    int  Priority;
    D3D12_COMMAND_QUEUE_FLAGS Flags;
    uint NodeMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_input_element_desc
struct D3D12_INPUT_ELEMENT_DESC
{
    const(PSTR) SemanticName;
    uint        SemanticIndex;
    DXGI_FORMAT Format;
    uint        InputSlot;
    uint        AlignedByteOffset;
    D3D12_INPUT_CLASSIFICATION InputSlotClass;
    uint        InstanceDataStepRate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_so_declaration_entry
struct D3D12_SO_DECLARATION_ENTRY
{
    uint        Stream;
    const(PSTR) SemanticName;
    uint        SemanticIndex;
    ubyte       StartComponent;
    ubyte       ComponentCount;
    ubyte       OutputSlot;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_viewport
struct D3D12_VIEWPORT
{
    float TopLeftX;
    float TopLeftY;
    float Width;
    float Height;
    float MinDepth;
    float MaxDepth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_box
struct D3D12_BOX
{
    uint left;
    uint top;
    uint front;
    uint right;
    uint bottom;
    uint back;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_depth_stencilop_desc
struct D3D12_DEPTH_STENCILOP_DESC
{
    D3D12_STENCIL_OP StencilFailOp;
    D3D12_STENCIL_OP StencilDepthFailOp;
    D3D12_STENCIL_OP StencilPassOp;
    D3D12_COMPARISON_FUNC StencilFunc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_depth_stencil_desc
struct D3D12_DEPTH_STENCIL_DESC
{
    BOOL  DepthEnable;
    D3D12_DEPTH_WRITE_MASK DepthWriteMask;
    D3D12_COMPARISON_FUNC DepthFunc;
    BOOL  StencilEnable;
    ubyte StencilReadMask;
    ubyte StencilWriteMask;
    D3D12_DEPTH_STENCILOP_DESC FrontFace;
    D3D12_DEPTH_STENCILOP_DESC BackFace;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_depth_stencil_desc1
struct D3D12_DEPTH_STENCIL_DESC1
{
    BOOL  DepthEnable;
    D3D12_DEPTH_WRITE_MASK DepthWriteMask;
    D3D12_COMPARISON_FUNC DepthFunc;
    BOOL  StencilEnable;
    ubyte StencilReadMask;
    ubyte StencilWriteMask;
    D3D12_DEPTH_STENCILOP_DESC FrontFace;
    D3D12_DEPTH_STENCILOP_DESC BackFace;
    BOOL  DepthBoundsTestEnable;
}

struct D3D12_DEPTH_STENCILOP_DESC1
{
    D3D12_STENCIL_OP StencilFailOp;
    D3D12_STENCIL_OP StencilDepthFailOp;
    D3D12_STENCIL_OP StencilPassOp;
    D3D12_COMPARISON_FUNC StencilFunc;
    ubyte            StencilReadMask;
    ubyte            StencilWriteMask;
}

struct D3D12_DEPTH_STENCIL_DESC2
{
    BOOL DepthEnable;
    D3D12_DEPTH_WRITE_MASK DepthWriteMask;
    D3D12_COMPARISON_FUNC DepthFunc;
    BOOL StencilEnable;
    D3D12_DEPTH_STENCILOP_DESC1 FrontFace;
    D3D12_DEPTH_STENCILOP_DESC1 BackFace;
    BOOL DepthBoundsTestEnable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_render_target_blend_desc
struct D3D12_RENDER_TARGET_BLEND_DESC
{
    BOOL           BlendEnable;
    BOOL           LogicOpEnable;
    D3D12_BLEND    SrcBlend;
    D3D12_BLEND    DestBlend;
    D3D12_BLEND_OP BlendOp;
    D3D12_BLEND    SrcBlendAlpha;
    D3D12_BLEND    DestBlendAlpha;
    D3D12_BLEND_OP BlendOpAlpha;
    D3D12_LOGIC_OP LogicOp;
    ubyte          RenderTargetWriteMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_blend_desc
struct D3D12_BLEND_DESC
{
    BOOL AlphaToCoverageEnable;
    BOOL IndependentBlendEnable;
    D3D12_RENDER_TARGET_BLEND_DESC[8] RenderTarget;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_rasterizer_desc
struct D3D12_RASTERIZER_DESC
{
    D3D12_FILL_MODE FillMode;
    D3D12_CULL_MODE CullMode;
    BOOL            FrontCounterClockwise;
    int             DepthBias;
    float           DepthBiasClamp;
    float           SlopeScaledDepthBias;
    BOOL            DepthClipEnable;
    BOOL            MultisampleEnable;
    BOOL            AntialiasedLineEnable;
    uint            ForcedSampleCount;
    D3D12_CONSERVATIVE_RASTERIZATION_MODE ConservativeRaster;
}

struct D3D12_RASTERIZER_DESC1
{
    D3D12_FILL_MODE FillMode;
    D3D12_CULL_MODE CullMode;
    BOOL            FrontCounterClockwise;
    float           DepthBias;
    float           DepthBiasClamp;
    float           SlopeScaledDepthBias;
    BOOL            DepthClipEnable;
    BOOL            MultisampleEnable;
    BOOL            AntialiasedLineEnable;
    uint            ForcedSampleCount;
    D3D12_CONSERVATIVE_RASTERIZATION_MODE ConservativeRaster;
}

struct D3D12_RASTERIZER_DESC2
{
    D3D12_FILL_MODE FillMode;
    D3D12_CULL_MODE CullMode;
    BOOL            FrontCounterClockwise;
    float           DepthBias;
    float           DepthBiasClamp;
    float           SlopeScaledDepthBias;
    BOOL            DepthClipEnable;
    D3D12_LINE_RASTERIZATION_MODE LineRasterizationMode;
    uint            ForcedSampleCount;
    D3D12_CONSERVATIVE_RASTERIZATION_MODE ConservativeRaster;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_bytecode
struct D3D12_SHADER_BYTECODE
{
    const(void)* pShaderBytecode;
    size_t       BytecodeLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_stream_output_desc
struct D3D12_STREAM_OUTPUT_DESC
{
    const(D3D12_SO_DECLARATION_ENTRY)* pSODeclaration;
    uint         NumEntries;
    const(uint)* pBufferStrides;
    uint         NumStrides;
    uint         RasterizedStream;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_input_layout_desc
struct D3D12_INPUT_LAYOUT_DESC
{
    const(D3D12_INPUT_ELEMENT_DESC)* pInputElementDescs;
    uint NumElements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_cached_pipeline_state
struct D3D12_CACHED_PIPELINE_STATE
{
    const(void)* pCachedBlob;
    size_t       CachedBlobSizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_graphics_pipeline_state_desc
struct D3D12_GRAPHICS_PIPELINE_STATE_DESC
{
    ID3D12RootSignature pRootSignature;
    D3D12_SHADER_BYTECODE VS;
    D3D12_SHADER_BYTECODE PS;
    D3D12_SHADER_BYTECODE DS;
    D3D12_SHADER_BYTECODE HS;
    D3D12_SHADER_BYTECODE GS;
    D3D12_STREAM_OUTPUT_DESC StreamOutput;
    D3D12_BLEND_DESC    BlendState;
    uint                SampleMask;
    D3D12_RASTERIZER_DESC RasterizerState;
    D3D12_DEPTH_STENCIL_DESC DepthStencilState;
    D3D12_INPUT_LAYOUT_DESC InputLayout;
    D3D12_INDEX_BUFFER_STRIP_CUT_VALUE IBStripCutValue;
    D3D12_PRIMITIVE_TOPOLOGY_TYPE PrimitiveTopologyType;
    uint                NumRenderTargets;
    DXGI_FORMAT[8]      RTVFormats;
    DXGI_FORMAT         DSVFormat;
    DXGI_SAMPLE_DESC    SampleDesc;
    uint                NodeMask;
    D3D12_CACHED_PIPELINE_STATE CachedPSO;
    D3D12_PIPELINE_STATE_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_compute_pipeline_state_desc
struct D3D12_COMPUTE_PIPELINE_STATE_DESC
{
    ID3D12RootSignature pRootSignature;
    D3D12_SHADER_BYTECODE CS;
    uint                NodeMask;
    D3D12_CACHED_PIPELINE_STATE CachedPSO;
    D3D12_PIPELINE_STATE_FLAGS Flags;
}

struct D3D12_SERIALIZED_ROOT_SIGNATURE_DESC
{
    const(void)* pSerializedBlob;
    size_t       SerializedBlobSizeInBytes;
}

struct D3D12_GLOBAL_SERIALIZED_ROOT_SIGNATURE
{
    D3D12_SERIALIZED_ROOT_SIGNATURE_DESC Desc;
}

struct D3D12_LOCAL_SERIALIZED_ROOT_SIGNATURE
{
    D3D12_SERIALIZED_ROOT_SIGNATURE_DESC Desc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_rt_format_array
struct D3D12_RT_FORMAT_ARRAY
{
    DXGI_FORMAT[8] RTFormats;
    uint           NumRenderTargets;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_pipeline_state_stream_desc
struct D3D12_PIPELINE_STATE_STREAM_DESC
{
    size_t SizeInBytes;
    void*  pPipelineStateSubobjectStream;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options
struct D3D12_FEATURE_DATA_D3D12_OPTIONS
{
    BOOL DoublePrecisionFloatShaderOps;
    BOOL OutputMergerLogicOp;
    D3D12_SHADER_MIN_PRECISION_SUPPORT MinPrecisionSupport;
    D3D12_TILED_RESOURCES_TIER TiledResourcesTier;
    D3D12_RESOURCE_BINDING_TIER ResourceBindingTier;
    BOOL PSSpecifiedStencilRefSupported;
    BOOL TypedUAVLoadAdditionalFormats;
    BOOL ROVsSupported;
    D3D12_CONSERVATIVE_RASTERIZATION_TIER ConservativeRasterizationTier;
    uint MaxGPUVirtualAddressBitsPerResource;
    BOOL StandardSwizzle64KBSupported;
    D3D12_CROSS_NODE_SHARING_TIER CrossNodeSharingTier;
    BOOL CrossAdapterRowMajorTextureSupported;
    BOOL VPAndRTArrayIndexFromAnyShaderFeedingRasterizerSupportedWithoutGSEmulation;
    D3D12_RESOURCE_HEAP_TIER ResourceHeapTier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options1
struct D3D12_FEATURE_DATA_D3D12_OPTIONS1
{
    BOOL WaveOps;
    uint WaveLaneCountMin;
    uint WaveLaneCountMax;
    uint TotalLaneCount;
    BOOL ExpandedComputeResourceStates;
    BOOL Int64ShaderOps;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options2
struct D3D12_FEATURE_DATA_D3D12_OPTIONS2
{
    BOOL DepthBoundsTestSupported;
    D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER ProgrammableSamplePositionsTier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_root_signature
struct D3D12_FEATURE_DATA_ROOT_SIGNATURE
{
    D3D_ROOT_SIGNATURE_VERSION HighestVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_architecture
struct D3D12_FEATURE_DATA_ARCHITECTURE
{
    uint NodeIndex;
    BOOL TileBasedRenderer;
    BOOL UMA;
    BOOL CacheCoherentUMA;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_architecture1
struct D3D12_FEATURE_DATA_ARCHITECTURE1
{
    uint NodeIndex;
    BOOL TileBasedRenderer;
    BOOL UMA;
    BOOL CacheCoherentUMA;
    BOOL IsolatedMMU;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_feature_levels
struct D3D12_FEATURE_DATA_FEATURE_LEVELS
{
    uint              NumFeatureLevels;
    const(D3D_FEATURE_LEVEL)* pFeatureLevelsRequested;
    D3D_FEATURE_LEVEL MaxSupportedFeatureLevel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_shader_model
struct D3D12_FEATURE_DATA_SHADER_MODEL
{
    D3D_SHADER_MODEL HighestShaderModel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_format_support
struct D3D12_FEATURE_DATA_FORMAT_SUPPORT
{
    DXGI_FORMAT Format;
    D3D12_FORMAT_SUPPORT1 Support1;
    D3D12_FORMAT_SUPPORT2 Support2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_multisample_quality_levels
struct D3D12_FEATURE_DATA_MULTISAMPLE_QUALITY_LEVELS
{
    DXGI_FORMAT Format;
    uint        SampleCount;
    D3D12_MULTISAMPLE_QUALITY_LEVEL_FLAGS Flags;
    uint        NumQualityLevels;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_format_info
struct D3D12_FEATURE_DATA_FORMAT_INFO
{
    DXGI_FORMAT Format;
    ubyte       PlaneCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_gpu_virtual_address_support
struct D3D12_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT
{
    uint MaxGPUVirtualAddressBitsPerResource;
    uint MaxGPUVirtualAddressBitsPerProcess;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_shader_cache
struct D3D12_FEATURE_DATA_SHADER_CACHE
{
    D3D12_SHADER_CACHE_SUPPORT_FLAGS SupportFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_command_queue_priority
struct D3D12_FEATURE_DATA_COMMAND_QUEUE_PRIORITY
{
    D3D12_COMMAND_LIST_TYPE CommandListType;
    uint Priority;
    BOOL PriorityForTypeIsSupported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options3
struct D3D12_FEATURE_DATA_D3D12_OPTIONS3
{
    BOOL CopyQueueTimestampQueriesSupported;
    BOOL CastingFullyTypedFormatSupported;
    D3D12_COMMAND_LIST_SUPPORT_FLAGS WriteBufferImmediateSupportFlags;
    D3D12_VIEW_INSTANCING_TIER ViewInstancingTier;
    BOOL BarycentricsSupported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_existing_heaps
struct D3D12_FEATURE_DATA_EXISTING_HEAPS
{
    BOOL Supported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_displayable
struct D3D12_FEATURE_DATA_DISPLAYABLE
{
    BOOL DisplayableTexture;
    D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER SharedResourceCompatibilityTier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options4
struct D3D12_FEATURE_DATA_D3D12_OPTIONS4
{
    BOOL MSAA64KBAlignedTextureSupported;
    D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER SharedResourceCompatibilityTier;
    BOOL Native16BitShaderOpsSupported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_serialization
struct D3D12_FEATURE_DATA_SERIALIZATION
{
    uint NodeIndex;
    D3D12_HEAP_SERIALIZATION_TIER HeapSerializationTier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_cross_node
struct D3D12_FEATURE_DATA_CROSS_NODE
{
    D3D12_CROSS_NODE_SHARING_TIER SharingTier;
    BOOL AtomicShaderInstructions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options5
struct D3D12_FEATURE_DATA_D3D12_OPTIONS5
{
    BOOL SRVOnlyTiledResourceTier3;
    D3D12_RENDER_PASS_TIER RenderPassesTier;
    D3D12_RAYTRACING_TIER RaytracingTier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options6
struct D3D12_FEATURE_DATA_D3D12_OPTIONS6
{
    BOOL AdditionalShadingRatesSupported;
    BOOL PerPrimitiveShadingRateSupportedWithViewportIndexing;
    D3D12_VARIABLE_SHADING_RATE_TIER VariableShadingRateTier;
    uint ShadingRateImageTileSize;
    BOOL BackgroundProcessingSupported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options7
struct D3D12_FEATURE_DATA_D3D12_OPTIONS7
{
    D3D12_MESH_SHADER_TIER MeshShaderTier;
    D3D12_SAMPLER_FEEDBACK_TIER SamplerFeedbackTier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_query_meta_command
struct D3D12_FEATURE_DATA_QUERY_META_COMMAND
{
    GUID         CommandId;
    uint         NodeMask;
    const(void)* pQueryInputData;
    size_t       QueryInputDataSizeInBytes;
    void*        pQueryOutputData;
    size_t       QueryOutputDataSizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options8
struct D3D12_FEATURE_DATA_D3D12_OPTIONS8
{
    BOOL UnalignedBlockTexturesSupported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options9
struct D3D12_FEATURE_DATA_D3D12_OPTIONS9
{
    BOOL                MeshShaderPipelineStatsSupported;
    BOOL                MeshShaderSupportsFullRangeRenderTargetArrayIndex;
    BOOL                AtomicInt64OnTypedResourceSupported;
    BOOL                AtomicInt64OnGroupSharedSupported;
    BOOL                DerivativesInMeshAndAmplificationShadersSupported;
    D3D12_WAVE_MMA_TIER WaveMMATier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options10
struct D3D12_FEATURE_DATA_D3D12_OPTIONS10
{
    BOOL VariableRateShadingSumCombinerSupported;
    BOOL MeshShaderPerPrimitiveShadingRateSupported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options11
struct D3D12_FEATURE_DATA_D3D12_OPTIONS11
{
    BOOL AtomicInt64OnDescriptorHeapResourceSupported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options12
struct D3D12_FEATURE_DATA_D3D12_OPTIONS12
{
    D3D12_TRI_STATE MSPrimitivesPipelineStatisticIncludesCulledPrimitives;
    BOOL            EnhancedBarriersSupported;
    BOOL            RelaxedFormatCastingSupported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options13
struct D3D12_FEATURE_DATA_D3D12_OPTIONS13
{
    BOOL UnrestrictedBufferTextureCopyPitchSupported;
    BOOL UnrestrictedVertexElementAlignmentSupported;
    BOOL InvertedViewportHeightFlipsYSupported;
    BOOL InvertedViewportDepthFlipsZSupported;
    BOOL TextureCopyBetweenDimensionsSupported;
    BOOL AlphaBlendFactorSupported;
}

struct D3D12_FEATURE_DATA_D3D12_OPTIONS14
{
    BOOL AdvancedTextureOpsSupported;
    BOOL WriteableMSAATexturesSupported;
    BOOL IndependentFrontAndBackStencilRefMaskSupported;
}

struct D3D12_FEATURE_DATA_D3D12_OPTIONS15
{
    BOOL TriangleFanSupported;
    BOOL DynamicIndexBufferStripCutSupported;
}

struct D3D12_FEATURE_DATA_D3D12_OPTIONS16
{
    BOOL DynamicDepthBiasSupported;
    BOOL GPUUploadHeapSupported;
}

struct D3D12_FEATURE_DATA_D3D12_OPTIONS17
{
    BOOL NonNormalizedCoordinateSamplersSupported;
    BOOL ManualWriteTrackingResourceSupported;
}

struct D3D12_FEATURE_DATA_D3D12_OPTIONS18
{
    BOOL RenderPassesValid;
}

struct D3D12_FEATURE_DATA_D3D12_OPTIONS19
{
    BOOL MismatchingOutputDimensionsSupported;
    uint SupportedSampleCountsWithNoOutputs;
    BOOL PointSamplingAddressesNeverRoundUp;
    BOOL RasterizerDesc2Supported;
    BOOL NarrowQuadrilateralLinesSupported;
    BOOL AnisoFilterWithPointMipSupported;
    uint MaxSamplerDescriptorHeapSize;
    uint MaxSamplerDescriptorHeapSizeWithStaticSamplers;
    uint MaxViewDescriptorHeapSize;
    BOOL ComputeOnlyCustomHeapSupported;
}

struct D3D12_FEATURE_DATA_D3D12_OPTIONS20
{
    BOOL ComputeOnlyWriteWatchSupported;
    D3D12_RECREATE_AT_TIER RecreateAtTier;
}

struct D3D12_FEATURE_DATA_D3D12_OPTIONS21
{
    D3D12_WORK_GRAPHS_TIER WorkGraphsTier;
    D3D12_EXECUTE_INDIRECT_TIER ExecuteIndirectTier;
    BOOL SampleCmpGradientAndBiasSupported;
    BOOL ExtendedCommandInfoSupported;
}

struct D3D12_FEATURE_DATA_D3D12_OPTIONS22
{
    BOOL ShaderExecutionReorderingActuallyReorders;
    BOOL CreateByteOffsetViewsSupported;
    uint Max1DDispatchSize;
    uint Max1DDispatchMeshSize;
}

struct D3D12_FEATURE_DATA_TIGHT_ALIGNMENT
{
    D3D12_TIGHT_ALIGNMENT_TIER SupportTier;
}

struct D3D12_FEATURE_DATA_PREDICATION
{
    BOOL Supported;
}

struct D3D12_FEATURE_DATA_HARDWARE_COPY
{
    BOOL Supported;
}

struct D3D12_FEATURE_DATA_APPLICATION_SPECIFIC_DRIVER_STATE
{
    BOOL Supported;
}

struct D3D12_FEATURE_DATA_BYTECODE_BYPASS_HASH_SUPPORTED
{
    BOOL Supported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_resource_allocation_info
struct D3D12_RESOURCE_ALLOCATION_INFO
{
    ulong SizeInBytes;
    ulong Alignment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_resource_allocation_info1
struct D3D12_RESOURCE_ALLOCATION_INFO1
{
    ulong Offset;
    ulong Alignment;
    ulong SizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_heap_properties
struct D3D12_HEAP_PROPERTIES
{
    D3D12_HEAP_TYPE   Type;
    D3D12_CPU_PAGE_PROPERTY CPUPageProperty;
    D3D12_MEMORY_POOL MemoryPoolPreference;
    uint              CreationNodeMask;
    uint              VisibleNodeMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_heap_desc
struct D3D12_HEAP_DESC
{
    ulong            SizeInBytes;
    D3D12_HEAP_PROPERTIES Properties;
    ulong            Alignment;
    D3D12_HEAP_FLAGS Flags;
}

struct D3D12_FEATURE_DATA_PLACED_RESOURCE_SUPPORT_INFO
{
    DXGI_FORMAT Format;
    D3D12_RESOURCE_DIMENSION Dimension;
    D3D12_HEAP_PROPERTIES DestHeapProperties;
    BOOL        Supported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_mip_region
struct D3D12_MIP_REGION
{
    uint Width;
    uint Height;
    uint Depth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_resource_desc
struct D3D12_RESOURCE_DESC
{
    D3D12_RESOURCE_DIMENSION Dimension;
    ulong                Alignment;
    ulong                Width;
    uint                 Height;
    ushort               DepthOrArraySize;
    ushort               MipLevels;
    DXGI_FORMAT          Format;
    DXGI_SAMPLE_DESC     SampleDesc;
    D3D12_TEXTURE_LAYOUT Layout;
    D3D12_RESOURCE_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_resource_desc1
struct D3D12_RESOURCE_DESC1
{
    D3D12_RESOURCE_DIMENSION Dimension;
    ulong                Alignment;
    ulong                Width;
    uint                 Height;
    ushort               DepthOrArraySize;
    ushort               MipLevels;
    DXGI_FORMAT          Format;
    DXGI_SAMPLE_DESC     SampleDesc;
    D3D12_TEXTURE_LAYOUT Layout;
    D3D12_RESOURCE_FLAGS Flags;
    D3D12_MIP_REGION     SamplerFeedbackMipRegion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_depth_stencil_value
struct D3D12_DEPTH_STENCIL_VALUE
{
    float Depth;
    ubyte Stencil;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_clear_value
struct D3D12_CLEAR_VALUE
{
    DXGI_FORMAT Format;
    union
    {
        float[4] Color;
        D3D12_DEPTH_STENCIL_VALUE DepthStencil;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_range
struct D3D12_RANGE
{
    size_t Begin;
    size_t End;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_range_uint64
struct D3D12_RANGE_UINT64
{
    ulong Begin;
    ulong End;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_subresource_range_uint64
struct D3D12_SUBRESOURCE_RANGE_UINT64
{
    uint               Subresource;
    D3D12_RANGE_UINT64 Range;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_subresource_info
struct D3D12_SUBRESOURCE_INFO
{
    ulong Offset;
    uint  RowPitch;
    uint  DepthPitch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tiled_resource_coordinate
struct D3D12_TILED_RESOURCE_COORDINATE
{
    uint X;
    uint Y;
    uint Z;
    uint Subresource;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tile_region_size
struct D3D12_TILE_REGION_SIZE
{
    uint   NumTiles;
    BOOL   UseBox;
    uint   Width;
    ushort Height;
    ushort Depth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_subresource_tiling
struct D3D12_SUBRESOURCE_TILING
{
    uint   WidthInTiles;
    ushort HeightInTiles;
    ushort DepthInTiles;
    uint   StartTileIndexInOverallResource;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tile_shape
struct D3D12_TILE_SHAPE
{
    uint WidthInTexels;
    uint HeightInTexels;
    uint DepthInTexels;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_packed_mip_info
struct D3D12_PACKED_MIP_INFO
{
    ubyte NumStandardMips;
    ubyte NumPackedMips;
    uint  NumTilesForPackedMips;
    uint  StartTileIndexInOverallResource;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_resource_transition_barrier
struct D3D12_RESOURCE_TRANSITION_BARRIER
{
    ID3D12Resource pResource;
    uint           Subresource;
    D3D12_RESOURCE_STATES StateBefore;
    D3D12_RESOURCE_STATES StateAfter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_resource_aliasing_barrier
struct D3D12_RESOURCE_ALIASING_BARRIER
{
    ID3D12Resource pResourceBefore;
    ID3D12Resource pResourceAfter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_resource_uav_barrier
struct D3D12_RESOURCE_UAV_BARRIER
{
    ID3D12Resource pResource;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_resource_barrier
struct D3D12_RESOURCE_BARRIER
{
    D3D12_RESOURCE_BARRIER_TYPE Type;
    D3D12_RESOURCE_BARRIER_FLAGS Flags;
    union
    {
        D3D12_RESOURCE_TRANSITION_BARRIER Transition;
        D3D12_RESOURCE_ALIASING_BARRIER Aliasing;
        D3D12_RESOURCE_UAV_BARRIER UAV;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_subresource_footprint
struct D3D12_SUBRESOURCE_FOOTPRINT
{
    DXGI_FORMAT Format;
    uint        Width;
    uint        Height;
    uint        Depth;
    uint        RowPitch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_placed_subresource_footprint
struct D3D12_PLACED_SUBRESOURCE_FOOTPRINT
{
    ulong Offset;
    D3D12_SUBRESOURCE_FOOTPRINT Footprint;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_texture_copy_location
struct D3D12_TEXTURE_COPY_LOCATION
{
    ID3D12Resource pResource;
    D3D12_TEXTURE_COPY_TYPE Type;
    union
    {
        D3D12_PLACED_SUBRESOURCE_FOOTPRINT PlacedFootprint;
        uint SubresourceIndex;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_sample_position
struct D3D12_SAMPLE_POSITION
{
    byte X;
    byte Y;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_view_instance_location
struct D3D12_VIEW_INSTANCE_LOCATION
{
    uint ViewportArrayIndex;
    uint RenderTargetArrayIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_view_instancing_desc
struct D3D12_VIEW_INSTANCING_DESC
{
    uint ViewInstanceCount;
    const(D3D12_VIEW_INSTANCE_LOCATION)* pViewInstanceLocations;
    D3D12_VIEW_INSTANCING_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_buffer_srv
struct D3D12_BUFFER_SRV
{
    ulong FirstElement;
    uint  NumElements;
    uint  StructureByteStride;
    D3D12_BUFFER_SRV_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex1d_srv
struct D3D12_TEX1D_SRV
{
    uint  MostDetailedMip;
    uint  MipLevels;
    float ResourceMinLODClamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex1d_array_srv
struct D3D12_TEX1D_ARRAY_SRV
{
    uint  MostDetailedMip;
    uint  MipLevels;
    uint  FirstArraySlice;
    uint  ArraySize;
    float ResourceMinLODClamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2d_srv
struct D3D12_TEX2D_SRV
{
    uint  MostDetailedMip;
    uint  MipLevels;
    uint  PlaneSlice;
    float ResourceMinLODClamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2d_array_srv
struct D3D12_TEX2D_ARRAY_SRV
{
    uint  MostDetailedMip;
    uint  MipLevels;
    uint  FirstArraySlice;
    uint  ArraySize;
    uint  PlaneSlice;
    float ResourceMinLODClamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex3d_srv
struct D3D12_TEX3D_SRV
{
    uint  MostDetailedMip;
    uint  MipLevels;
    float ResourceMinLODClamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_texcube_srv
struct D3D12_TEXCUBE_SRV
{
    uint  MostDetailedMip;
    uint  MipLevels;
    float ResourceMinLODClamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_texcube_array_srv
struct D3D12_TEXCUBE_ARRAY_SRV
{
    uint  MostDetailedMip;
    uint  MipLevels;
    uint  First2DArrayFace;
    uint  NumCubes;
    float ResourceMinLODClamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2dms_srv
struct D3D12_TEX2DMS_SRV
{
    uint UnusedField_NothingToDefine;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2dms_array_srv
struct D3D12_TEX2DMS_ARRAY_SRV
{
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_acceleration_structure_srv
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_SRV
{
    ulong Location;
}

struct D3D12_BUFFER_SRV_BYTE_OFFSET
{
    ulong Offset;
    ulong Size;
    uint  StructureByteStride;
    D3D12_BUFFER_SRV_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_resource_view_desc
struct D3D12_SHADER_RESOURCE_VIEW_DESC
{
    DXGI_FORMAT         Format;
    D3D12_SRV_DIMENSION ViewDimension;
    uint                Shader4ComponentMapping;
    union
    {
        D3D12_BUFFER_SRV  Buffer;
        D3D12_TEX1D_SRV   Texture1D;
        D3D12_TEX1D_ARRAY_SRV Texture1DArray;
        D3D12_TEX2D_SRV   Texture2D;
        D3D12_TEX2D_ARRAY_SRV Texture2DArray;
        D3D12_TEX2DMS_SRV Texture2DMS;
        D3D12_TEX2DMS_ARRAY_SRV Texture2DMSArray;
        D3D12_TEX3D_SRV   Texture3D;
        D3D12_TEXCUBE_SRV TextureCube;
        D3D12_TEXCUBE_ARRAY_SRV TextureCubeArray;
        D3D12_RAYTRACING_ACCELERATION_STRUCTURE_SRV RaytracingAccelerationStructure;
        D3D12_BUFFER_SRV_BYTE_OFFSET BufferByteOffset;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_constant_buffer_view_desc
struct D3D12_CONSTANT_BUFFER_VIEW_DESC
{
    ulong BufferLocation;
    uint  SizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_sampler_desc
struct D3D12_SAMPLER_DESC
{
    D3D12_FILTER Filter;
    D3D12_TEXTURE_ADDRESS_MODE AddressU;
    D3D12_TEXTURE_ADDRESS_MODE AddressV;
    D3D12_TEXTURE_ADDRESS_MODE AddressW;
    float        MipLODBias;
    uint         MaxAnisotropy;
    D3D12_COMPARISON_FUNC ComparisonFunc;
    float[4]     BorderColor;
    float        MinLOD;
    float        MaxLOD;
}

struct D3D12_SAMPLER_DESC2
{
    D3D12_FILTER        Filter;
    D3D12_TEXTURE_ADDRESS_MODE AddressU;
    D3D12_TEXTURE_ADDRESS_MODE AddressV;
    D3D12_TEXTURE_ADDRESS_MODE AddressW;
    float               MipLODBias;
    uint                MaxAnisotropy;
    D3D12_COMPARISON_FUNC ComparisonFunc;
    union
    {
        float[4] FloatBorderColor;
        uint[4]  UintBorderColor;
    }
    float               MinLOD;
    float               MaxLOD;
    D3D12_SAMPLER_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_buffer_uav
struct D3D12_BUFFER_UAV
{
    ulong FirstElement;
    uint  NumElements;
    uint  StructureByteStride;
    ulong CounterOffsetInBytes;
    D3D12_BUFFER_UAV_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex1d_uav
struct D3D12_TEX1D_UAV
{
    uint MipSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex1d_array_uav
struct D3D12_TEX1D_ARRAY_UAV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2d_uav
struct D3D12_TEX2D_UAV
{
    uint MipSlice;
    uint PlaneSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2d_array_uav
struct D3D12_TEX2D_ARRAY_UAV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
    uint PlaneSlice;
}

struct D3D12_TEX2DMS_UAV
{
    uint UnusedField_NothingToDefine;
}

struct D3D12_TEX2DMS_ARRAY_UAV
{
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex3d_uav
struct D3D12_TEX3D_UAV
{
    uint MipSlice;
    uint FirstWSlice;
    uint WSize;
}

struct D3D12_BUFFER_UAV_BYTE_OFFSET
{
    ulong Offset;
    ulong Size;
    uint  StructureByteStride;
    ulong CounterOffsetInBytes;
    D3D12_BUFFER_UAV_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_unordered_access_view_desc
struct D3D12_UNORDERED_ACCESS_VIEW_DESC
{
    DXGI_FORMAT         Format;
    D3D12_UAV_DIMENSION ViewDimension;
    union
    {
        D3D12_BUFFER_UAV  Buffer;
        D3D12_TEX1D_UAV   Texture1D;
        D3D12_TEX1D_ARRAY_UAV Texture1DArray;
        D3D12_TEX2D_UAV   Texture2D;
        D3D12_TEX2D_ARRAY_UAV Texture2DArray;
        D3D12_TEX2DMS_UAV Texture2DMS;
        D3D12_TEX2DMS_ARRAY_UAV Texture2DMSArray;
        D3D12_TEX3D_UAV   Texture3D;
        D3D12_BUFFER_UAV_BYTE_OFFSET BufferByteOffset;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_buffer_rtv
struct D3D12_BUFFER_RTV
{
    ulong FirstElement;
    uint  NumElements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex1d_rtv
struct D3D12_TEX1D_RTV
{
    uint MipSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex1d_array_rtv
struct D3D12_TEX1D_ARRAY_RTV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2d_rtv
struct D3D12_TEX2D_RTV
{
    uint MipSlice;
    uint PlaneSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2dms_rtv
struct D3D12_TEX2DMS_RTV
{
    uint UnusedField_NothingToDefine;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2d_array_rtv
struct D3D12_TEX2D_ARRAY_RTV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
    uint PlaneSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2dms_array_rtv
struct D3D12_TEX2DMS_ARRAY_RTV
{
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex3d_rtv
struct D3D12_TEX3D_RTV
{
    uint MipSlice;
    uint FirstWSlice;
    uint WSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_render_target_view_desc
struct D3D12_RENDER_TARGET_VIEW_DESC
{
    DXGI_FORMAT         Format;
    D3D12_RTV_DIMENSION ViewDimension;
    union
    {
        D3D12_BUFFER_RTV  Buffer;
        D3D12_TEX1D_RTV   Texture1D;
        D3D12_TEX1D_ARRAY_RTV Texture1DArray;
        D3D12_TEX2D_RTV   Texture2D;
        D3D12_TEX2D_ARRAY_RTV Texture2DArray;
        D3D12_TEX2DMS_RTV Texture2DMS;
        D3D12_TEX2DMS_ARRAY_RTV Texture2DMSArray;
        D3D12_TEX3D_RTV   Texture3D;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex1d_dsv
struct D3D12_TEX1D_DSV
{
    uint MipSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex1d_array_dsv
struct D3D12_TEX1D_ARRAY_DSV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2d_dsv
struct D3D12_TEX2D_DSV
{
    uint MipSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2d_array_dsv
struct D3D12_TEX2D_ARRAY_DSV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2dms_dsv
struct D3D12_TEX2DMS_DSV
{
    uint UnusedField_NothingToDefine;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_tex2dms_array_dsv
struct D3D12_TEX2DMS_ARRAY_DSV
{
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_depth_stencil_view_desc
struct D3D12_DEPTH_STENCIL_VIEW_DESC
{
    DXGI_FORMAT         Format;
    D3D12_DSV_DIMENSION ViewDimension;
    D3D12_DSV_FLAGS     Flags;
    union
    {
        D3D12_TEX1D_DSV   Texture1D;
        D3D12_TEX1D_ARRAY_DSV Texture1DArray;
        D3D12_TEX2D_DSV   Texture2D;
        D3D12_TEX2D_ARRAY_DSV Texture2DArray;
        D3D12_TEX2DMS_DSV Texture2DMS;
        D3D12_TEX2DMS_ARRAY_DSV Texture2DMSArray;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_descriptor_heap_desc
struct D3D12_DESCRIPTOR_HEAP_DESC
{
    D3D12_DESCRIPTOR_HEAP_TYPE Type;
    uint NumDescriptors;
    D3D12_DESCRIPTOR_HEAP_FLAGS Flags;
    uint NodeMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_descriptor_range
struct D3D12_DESCRIPTOR_RANGE
{
    D3D12_DESCRIPTOR_RANGE_TYPE RangeType;
    uint NumDescriptors;
    uint BaseShaderRegister;
    uint RegisterSpace;
    uint OffsetInDescriptorsFromTableStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_root_descriptor_table
struct D3D12_ROOT_DESCRIPTOR_TABLE
{
    uint NumDescriptorRanges;
    const(D3D12_DESCRIPTOR_RANGE)* pDescriptorRanges;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_root_constants
struct D3D12_ROOT_CONSTANTS
{
    uint ShaderRegister;
    uint RegisterSpace;
    uint Num32BitValues;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_root_descriptor
struct D3D12_ROOT_DESCRIPTOR
{
    uint ShaderRegister;
    uint RegisterSpace;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_root_parameter
struct D3D12_ROOT_PARAMETER
{
    D3D12_ROOT_PARAMETER_TYPE ParameterType;
    union
    {
        D3D12_ROOT_DESCRIPTOR_TABLE DescriptorTable;
        D3D12_ROOT_CONSTANTS Constants;
        D3D12_ROOT_DESCRIPTOR Descriptor;
    }
    D3D12_SHADER_VISIBILITY ShaderVisibility;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_static_sampler_desc
struct D3D12_STATIC_SAMPLER_DESC
{
    D3D12_FILTER Filter;
    D3D12_TEXTURE_ADDRESS_MODE AddressU;
    D3D12_TEXTURE_ADDRESS_MODE AddressV;
    D3D12_TEXTURE_ADDRESS_MODE AddressW;
    float        MipLODBias;
    uint         MaxAnisotropy;
    D3D12_COMPARISON_FUNC ComparisonFunc;
    D3D12_STATIC_BORDER_COLOR BorderColor;
    float        MinLOD;
    float        MaxLOD;
    uint         ShaderRegister;
    uint         RegisterSpace;
    D3D12_SHADER_VISIBILITY ShaderVisibility;
}

struct D3D12_STATIC_SAMPLER_DESC1
{
    D3D12_FILTER        Filter;
    D3D12_TEXTURE_ADDRESS_MODE AddressU;
    D3D12_TEXTURE_ADDRESS_MODE AddressV;
    D3D12_TEXTURE_ADDRESS_MODE AddressW;
    float               MipLODBias;
    uint                MaxAnisotropy;
    D3D12_COMPARISON_FUNC ComparisonFunc;
    D3D12_STATIC_BORDER_COLOR BorderColor;
    float               MinLOD;
    float               MaxLOD;
    uint                ShaderRegister;
    uint                RegisterSpace;
    D3D12_SHADER_VISIBILITY ShaderVisibility;
    D3D12_SAMPLER_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_root_signature_desc
struct D3D12_ROOT_SIGNATURE_DESC
{
    uint NumParameters;
    const(D3D12_ROOT_PARAMETER)* pParameters;
    uint NumStaticSamplers;
    const(D3D12_STATIC_SAMPLER_DESC)* pStaticSamplers;
    D3D12_ROOT_SIGNATURE_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_descriptor_range1
struct D3D12_DESCRIPTOR_RANGE1
{
    D3D12_DESCRIPTOR_RANGE_TYPE RangeType;
    uint NumDescriptors;
    uint BaseShaderRegister;
    uint RegisterSpace;
    D3D12_DESCRIPTOR_RANGE_FLAGS Flags;
    uint OffsetInDescriptorsFromTableStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_root_descriptor_table1
struct D3D12_ROOT_DESCRIPTOR_TABLE1
{
    uint NumDescriptorRanges;
    const(D3D12_DESCRIPTOR_RANGE1)* pDescriptorRanges;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_root_descriptor1
struct D3D12_ROOT_DESCRIPTOR1
{
    uint ShaderRegister;
    uint RegisterSpace;
    D3D12_ROOT_DESCRIPTOR_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_root_parameter1
struct D3D12_ROOT_PARAMETER1
{
    D3D12_ROOT_PARAMETER_TYPE ParameterType;
    union
    {
        D3D12_ROOT_DESCRIPTOR_TABLE1 DescriptorTable;
        D3D12_ROOT_CONSTANTS Constants;
        D3D12_ROOT_DESCRIPTOR1 Descriptor;
    }
    D3D12_SHADER_VISIBILITY ShaderVisibility;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_root_signature_desc1
struct D3D12_ROOT_SIGNATURE_DESC1
{
    uint NumParameters;
    const(D3D12_ROOT_PARAMETER1)* pParameters;
    uint NumStaticSamplers;
    const(D3D12_STATIC_SAMPLER_DESC)* pStaticSamplers;
    D3D12_ROOT_SIGNATURE_FLAGS Flags;
}

struct D3D12_ROOT_SIGNATURE_DESC2
{
    uint NumParameters;
    const(D3D12_ROOT_PARAMETER1)* pParameters;
    uint NumStaticSamplers;
    const(D3D12_STATIC_SAMPLER_DESC1)* pStaticSamplers;
    D3D12_ROOT_SIGNATURE_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_versioned_root_signature_desc
struct D3D12_VERSIONED_ROOT_SIGNATURE_DESC
{
    D3D_ROOT_SIGNATURE_VERSION Version;
    union
    {
        D3D12_ROOT_SIGNATURE_DESC Desc_1_0;
        D3D12_ROOT_SIGNATURE_DESC1 Desc_1_1;
        D3D12_ROOT_SIGNATURE_DESC2 Desc_1_2;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_cpu_descriptor_handle
struct D3D12_CPU_DESCRIPTOR_HANDLE
{
    size_t ptr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_gpu_descriptor_handle
struct D3D12_GPU_DESCRIPTOR_HANDLE
{
    ulong ptr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_discard_region
struct D3D12_DISCARD_REGION
{
    uint         NumRects;
    const(RECT)* pRects;
    uint         FirstSubresource;
    uint         NumSubresources;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_query_heap_desc
struct D3D12_QUERY_HEAP_DESC
{
    D3D12_QUERY_HEAP_TYPE Type;
    uint Count;
    uint NodeMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_query_data_pipeline_statistics
struct D3D12_QUERY_DATA_PIPELINE_STATISTICS
{
    ulong IAVertices;
    ulong IAPrimitives;
    ulong VSInvocations;
    ulong GSInvocations;
    ulong GSPrimitives;
    ulong CInvocations;
    ulong CPrimitives;
    ulong PSInvocations;
    ulong HSInvocations;
    ulong DSInvocations;
    ulong CSInvocations;
}

struct D3D12_QUERY_DATA_PIPELINE_STATISTICS1
{
    ulong IAVertices;
    ulong IAPrimitives;
    ulong VSInvocations;
    ulong GSInvocations;
    ulong GSPrimitives;
    ulong CInvocations;
    ulong CPrimitives;
    ulong PSInvocations;
    ulong HSInvocations;
    ulong DSInvocations;
    ulong CSInvocations;
    ulong ASInvocations;
    ulong MSInvocations;
    ulong MSPrimitives;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_query_data_so_statistics
struct D3D12_QUERY_DATA_SO_STATISTICS
{
    ulong NumPrimitivesWritten;
    ulong PrimitivesStorageNeeded;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_stream_output_buffer_view
struct D3D12_STREAM_OUTPUT_BUFFER_VIEW
{
    ulong BufferLocation;
    ulong SizeInBytes;
    ulong BufferFilledSizeLocation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_draw_arguments
struct D3D12_DRAW_ARGUMENTS
{
    uint VertexCountPerInstance;
    uint InstanceCount;
    uint StartVertexLocation;
    uint StartInstanceLocation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_draw_indexed_arguments
struct D3D12_DRAW_INDEXED_ARGUMENTS
{
    uint IndexCountPerInstance;
    uint InstanceCount;
    uint StartIndexLocation;
    int  BaseVertexLocation;
    uint StartInstanceLocation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_dispatch_arguments
struct D3D12_DISPATCH_ARGUMENTS
{
    uint ThreadGroupCountX;
    uint ThreadGroupCountY;
    uint ThreadGroupCountZ;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_vertex_buffer_view
struct D3D12_VERTEX_BUFFER_VIEW
{
    ulong BufferLocation;
    uint  SizeInBytes;
    uint  StrideInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_index_buffer_view
struct D3D12_INDEX_BUFFER_VIEW
{
    ulong       BufferLocation;
    uint        SizeInBytes;
    DXGI_FORMAT Format;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_indirect_argument_desc
struct D3D12_INDIRECT_ARGUMENT_DESC
{
    D3D12_INDIRECT_ARGUMENT_TYPE Type;
    union
    {
        struct VertexBuffer
        {
            uint Slot;
        }
        struct Constant
        {
            uint RootParameterIndex;
            uint DestOffsetIn32BitValues;
            uint Num32BitValuesToSet;
        }
        struct ConstantBufferView
        {
            uint RootParameterIndex;
        }
        struct ShaderResourceView
        {
            uint RootParameterIndex;
        }
        struct UnorderedAccessView
        {
            uint RootParameterIndex;
        }
        struct IncrementingConstant
        {
            uint RootParameterIndex;
            uint DestOffsetIn32BitValues;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_command_signature_desc
struct D3D12_COMMAND_SIGNATURE_DESC
{
    uint ByteStride;
    uint NumArgumentDescs;
    const(D3D12_INDIRECT_ARGUMENT_DESC)* pArgumentDescs;
    uint NodeMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_writebufferimmediate_parameter
struct D3D12_WRITEBUFFERIMMEDIATE_PARAMETER
{
    ulong Dest;
    uint  Value;
}

struct D3D12_FEATURE_DATA_HARDWARE_SCHEDULING_QUEUE_GROUPINGS
{
    uint ComputeQueuesPer3DQueue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_protected_resource_session_support
struct D3D12_FEATURE_DATA_PROTECTED_RESOURCE_SESSION_SUPPORT
{
    uint NodeIndex;
    D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAGS Support;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_protected_resource_session_desc
struct D3D12_PROTECTED_RESOURCE_SESSION_DESC
{
    uint NodeMask;
    D3D12_PROTECTED_RESOURCE_SESSION_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_meta_command_parameter_desc
struct D3D12_META_COMMAND_PARAMETER_DESC
{
    const(PWSTR) Name;
    D3D12_META_COMMAND_PARAMETER_TYPE Type;
    D3D12_META_COMMAND_PARAMETER_FLAGS Flags;
    D3D12_RESOURCE_STATES RequiredResourceState;
    uint         StructureOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_meta_command_desc
struct D3D12_META_COMMAND_DESC
{
    GUID         Id;
    const(PWSTR) Name;
    D3D12_GRAPHICS_STATES InitializationDirtyState;
    D3D12_GRAPHICS_STATES ExecutionDirtyState;
}

struct D3D12_PROGRAM_IDENTIFIER
{
    ulong[4] OpaqueData;
}

struct D3D12_NODE_ID
{
    const(PWSTR) Name;
    uint         ArrayIndex;
}

struct D3D12_WORK_GRAPH_MEMORY_REQUIREMENTS
{
    ulong MinSizeInBytes;
    ulong MaxSizeInBytes;
    uint  SizeGranularityInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_state_subobject
struct D3D12_STATE_SUBOBJECT
{
    D3D12_STATE_SUBOBJECT_TYPE Type;
    const(void)* pDesc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_state_object_config
struct D3D12_STATE_OBJECT_CONFIG
{
    D3D12_STATE_OBJECT_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_global_root_signature
struct D3D12_GLOBAL_ROOT_SIGNATURE
{
    ID3D12RootSignature pGlobalRootSignature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_local_root_signature
struct D3D12_LOCAL_ROOT_SIGNATURE
{
    ID3D12RootSignature pLocalRootSignature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_node_mask
struct D3D12_NODE_MASK
{
    uint NodeMask;
}

struct D3D12_SAMPLE_MASK
{
    uint SampleMask;
}

struct D3D12_IB_STRIP_CUT_VALUE
{
    D3D12_INDEX_BUFFER_STRIP_CUT_VALUE IndexBufferStripCutValue;
}

struct D3D12_PRIMITIVE_TOPOLOGY_DESC
{
    D3D12_PRIMITIVE_TOPOLOGY_TYPE PrimitiveTopology;
}

struct D3D12_DEPTH_STENCIL_FORMAT
{
    DXGI_FORMAT DepthStencilFormat;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_export_desc
struct D3D12_EXPORT_DESC
{
    const(PWSTR)       Name;
    const(PWSTR)       ExportToRename;
    D3D12_EXPORT_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_dxil_library_desc
struct D3D12_DXIL_LIBRARY_DESC
{
    D3D12_SHADER_BYTECODE DXILLibrary;
    uint NumExports;
    const(D3D12_EXPORT_DESC)* pExports;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_existing_collection_desc
struct D3D12_EXISTING_COLLECTION_DESC
{
    ID3D12StateObject pExistingCollection;
    uint              NumExports;
    const(D3D12_EXPORT_DESC)* pExports;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_subobject_to_exports_association
struct D3D12_SUBOBJECT_TO_EXPORTS_ASSOCIATION
{
    const(D3D12_STATE_SUBOBJECT)* pSubobjectToAssociate;
    uint          NumExports;
    const(PWSTR)* pExports;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_dxil_subobject_to_exports_association
struct D3D12_DXIL_SUBOBJECT_TO_EXPORTS_ASSOCIATION
{
    const(PWSTR)  SubobjectToAssociate;
    uint          NumExports;
    const(PWSTR)* pExports;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_hit_group_desc
struct D3D12_HIT_GROUP_DESC
{
    const(PWSTR)         HitGroupExport;
    D3D12_HIT_GROUP_TYPE Type;
    const(PWSTR)         AnyHitShaderImport;
    const(PWSTR)         ClosestHitShaderImport;
    const(PWSTR)         IntersectionShaderImport;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_shader_config
struct D3D12_RAYTRACING_SHADER_CONFIG
{
    uint MaxPayloadSizeInBytes;
    uint MaxAttributeSizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_pipeline_config
struct D3D12_RAYTRACING_PIPELINE_CONFIG
{
    uint MaxTraceRecursionDepth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_pipeline_config1
struct D3D12_RAYTRACING_PIPELINE_CONFIG1
{
    uint MaxTraceRecursionDepth;
    D3D12_RAYTRACING_PIPELINE_FLAGS Flags;
}

struct D3D12_NODE_OUTPUT_OVERRIDES
{
    uint         OutputIndex;
    const(D3D12_NODE_ID)* pNewName;
    const(BOOL)* pAllowSparseNodes;
    const(uint)* pMaxRecords;
    const(uint)* pMaxRecordsSharedWithOutputIndex;
}

struct D3D12_BROADCASTING_LAUNCH_OVERRIDES
{
    const(uint)* pLocalRootArgumentsTableIndex;
    const(BOOL)* pProgramEntry;
    const(D3D12_NODE_ID)* pNewName;
    const(D3D12_NODE_ID)* pShareInputOf;
    const(uint)* pDispatchGrid;
    const(uint)* pMaxDispatchGrid;
    uint         NumOutputOverrides;
    const(D3D12_NODE_OUTPUT_OVERRIDES)* pOutputOverrides;
}

struct D3D12_COALESCING_LAUNCH_OVERRIDES
{
    const(uint)* pLocalRootArgumentsTableIndex;
    const(BOOL)* pProgramEntry;
    const(D3D12_NODE_ID)* pNewName;
    const(D3D12_NODE_ID)* pShareInputOf;
    uint         NumOutputOverrides;
    const(D3D12_NODE_OUTPUT_OVERRIDES)* pOutputOverrides;
}

struct D3D12_THREAD_LAUNCH_OVERRIDES
{
    const(uint)* pLocalRootArgumentsTableIndex;
    const(BOOL)* pProgramEntry;
    const(D3D12_NODE_ID)* pNewName;
    const(D3D12_NODE_ID)* pShareInputOf;
    uint         NumOutputOverrides;
    const(D3D12_NODE_OUTPUT_OVERRIDES)* pOutputOverrides;
}

struct D3D12_COMMON_COMPUTE_NODE_OVERRIDES
{
    const(uint)* pLocalRootArgumentsTableIndex;
    const(BOOL)* pProgramEntry;
    const(D3D12_NODE_ID)* pNewName;
    const(D3D12_NODE_ID)* pShareInputOf;
    uint         NumOutputOverrides;
    const(D3D12_NODE_OUTPUT_OVERRIDES)* pOutputOverrides;
}

struct D3D12_SHADER_NODE
{
    const(PWSTR) Shader;
    D3D12_NODE_OVERRIDES_TYPE OverridesType;
    union
    {
        const(D3D12_BROADCASTING_LAUNCH_OVERRIDES)* pBroadcastingLaunchOverrides;
        const(D3D12_COALESCING_LAUNCH_OVERRIDES)* pCoalescingLaunchOverrides;
        const(D3D12_THREAD_LAUNCH_OVERRIDES)* pThreadLaunchOverrides;
        const(D3D12_COMMON_COMPUTE_NODE_OVERRIDES)* pCommonComputeNodeOverrides;
    }
}

struct D3D12_NODE
{
    D3D12_NODE_TYPE NodeType;
    union
    {
        D3D12_SHADER_NODE Shader;
    }
}

struct D3D12_WORK_GRAPH_DESC
{
    const(PWSTR)       ProgramName;
    D3D12_WORK_GRAPH_FLAGS Flags;
    uint               NumEntrypoints;
    const(D3D12_NODE_ID)* pEntrypoints;
    uint               NumExplicitlyDefinedNodes;
    const(D3D12_NODE)* pExplicitlyDefinedNodes;
}

struct D3D12_GENERIC_PROGRAM_DESC
{
    const(PWSTR)  ProgramName;
    uint          NumExports;
    const(PWSTR)* pExports;
    uint          NumSubobjects;
    const(D3D12_STATE_SUBOBJECT)** ppSubobjects;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_state_object_desc
struct D3D12_STATE_OBJECT_DESC
{
    D3D12_STATE_OBJECT_TYPE Type;
    uint NumSubobjects;
    const(D3D12_STATE_SUBOBJECT)* pSubobjects;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_gpu_virtual_address_and_stride
struct D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE
{
    ulong StartAddress;
    ulong StrideInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_gpu_virtual_address_range
struct D3D12_GPU_VIRTUAL_ADDRESS_RANGE
{
    ulong StartAddress;
    ulong SizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_gpu_virtual_address_range_and_stride
struct D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE
{
    ulong StartAddress;
    ulong SizeInBytes;
    ulong StrideInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_geometry_triangles_desc
struct D3D12_RAYTRACING_GEOMETRY_TRIANGLES_DESC
{
    ulong       Transform3x4;
    DXGI_FORMAT IndexFormat;
    DXGI_FORMAT VertexFormat;
    uint        IndexCount;
    uint        VertexCount;
    ulong       IndexBuffer;
    D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE VertexBuffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_aabb
struct D3D12_RAYTRACING_AABB
{
    float MinX;
    float MinY;
    float MinZ;
    float MaxX;
    float MaxY;
    float MaxZ;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_geometry_aabbs_desc
struct D3D12_RAYTRACING_GEOMETRY_AABBS_DESC
{
    ulong AABBCount;
    D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE AABBs;
}

struct D3D12_RAYTRACING_OPACITY_MICROMAP_DESC
{
    uint ByteOffset;
    // Native bit field: SubdivisionLevel: [0-15], Format: [16-31]
    uint _bitfield0;
}

struct D3D12_RAYTRACING_GEOMETRY_OMM_LINKAGE_DESC
{
    D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE OpacityMicromapIndexBuffer;
    DXGI_FORMAT OpacityMicromapIndexFormat;
    uint        OpacityMicromapBaseLocation;
    ulong       OpacityMicromapArray;
}

struct D3D12_RAYTRACING_GEOMETRY_OMM_TRIANGLES_DESC
{
    const(D3D12_RAYTRACING_GEOMETRY_TRIANGLES_DESC)* pTriangles;
    const(D3D12_RAYTRACING_GEOMETRY_OMM_LINKAGE_DESC)* pOmmLinkage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_acceleration_structure_postbuild_info_desc
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC
{
    ulong DestBuffer;
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TYPE InfoType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_acceleration_structure_postbuild_info_compacted_size_desc
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_COMPACTED_SIZE_DESC
{
    ulong CompactedSizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_acceleration_structure_postbuild_info_tools_visualization_desc
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TOOLS_VISUALIZATION_DESC
{
    ulong DecodedSizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_build_raytracing_acceleration_structure_tools_visualization_header
struct D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_TOOLS_VISUALIZATION_HEADER
{
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE Type;
    uint NumDescs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_acceleration_structure_postbuild_info_serialization_desc
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_SERIALIZATION_DESC
{
    ulong SerializedSizeInBytes;
    union
    {
        ulong NumBottomLevelAccelerationStructurePointers;
        ulong NumBottomLevelAccelerationStructureHeaderAndPointerListPairs;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_serialized_data_driver_matching_identifier
struct D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER
{
    GUID      DriverOpaqueGUID;
    ubyte[16] DriverOpaqueVersioningData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_serialized_raytracing_acceleration_structure_header
struct D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER
{
    D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER DriverMatchingIdentifier;
    ulong SerializedSizeInBytesIncludingHeader;
    ulong DeserializedSizeInBytes;
    ulong NumBottomLevelAccelerationStructurePointersAfterHeader;
}

struct D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER1
{
    D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER DriverMatchingIdentifier;
    ulong SerializedSizeInBytesIncludingHeader;
    ulong DeserializedSizeInBytes;
    union
    {
        uint NumBottomLevelAccelerationStructurePointersAfterHeader;
        uint NumBlocks;
    }
    D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER_POSTAMBLE_TYPE HeaderPostambleType;
}

struct D3D12_RAYTRACING_SERIALIZED_BLOCK
{
    D3D12_SERIALIZED_BLOCK_TYPE Type;
    ulong NumBlockPointersAfterHeader;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_acceleration_structure_postbuild_info_current_size_desc
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_CURRENT_SIZE_DESC
{
    ulong CurrentSizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_instance_desc
struct D3D12_RAYTRACING_INSTANCE_DESC
{
    float[12] Transform;
    // Native bit field: InstanceID: [0-23], InstanceMask: [24-31]
    uint      _bitfield1;
    // Native bit field: InstanceContributionToHitGroupIndex: [0-23], Flags: [24-31]
    uint      _bitfield2;
    ulong     AccelerationStructure;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_geometry_desc
struct D3D12_RAYTRACING_GEOMETRY_DESC
{
    D3D12_RAYTRACING_GEOMETRY_TYPE Type;
    D3D12_RAYTRACING_GEOMETRY_FLAGS Flags;
    union
    {
        D3D12_RAYTRACING_GEOMETRY_TRIANGLES_DESC Triangles;
        D3D12_RAYTRACING_GEOMETRY_AABBS_DESC AABBs;
        D3D12_RAYTRACING_GEOMETRY_OMM_TRIANGLES_DESC OmmTriangles;
    }
}

struct D3D12_RAYTRACING_OPACITY_MICROMAP_HISTOGRAM_ENTRY
{
    uint Count;
    uint SubdivisionLevel;
    D3D12_RAYTRACING_OPACITY_MICROMAP_FORMAT Format;
}

struct D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_DESC
{
    uint  NumOmmHistogramEntries;
    const(D3D12_RAYTRACING_OPACITY_MICROMAP_HISTOGRAM_ENTRY)* pOmmHistogram;
    ulong InputBuffer;
    D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE PerOmmDescs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_build_raytracing_acceleration_structure_inputs
struct D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS
{
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE Type;
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS Flags;
    uint NumDescs;
    D3D12_ELEMENTS_LAYOUT DescsLayout;
    union
    {
        ulong InstanceDescs;
        const(D3D12_RAYTRACING_GEOMETRY_DESC)* pGeometryDescs;
        const(D3D12_RAYTRACING_GEOMETRY_DESC)** ppGeometryDescs;
        const(D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_DESC)* pOpacityMicromapArrayDesc;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_build_raytracing_acceleration_structure_desc
struct D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC
{
    ulong DestAccelerationStructureData;
    D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS Inputs;
    ulong SourceAccelerationStructureData;
    ulong ScratchAccelerationStructureData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_raytracing_acceleration_structure_prebuild_info
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO
{
    ulong ResultDataMaxSizeInBytes;
    ulong ScratchDataSizeInBytes;
    ulong UpdateScratchDataSizeInBytes;
}

struct D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_DESC
{
    ulong DestBuffer;
    D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_TYPE InfoType;
}

struct D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_CURRENT_SIZE_DESC
{
    ulong CurrentSizeInBytes;
}

struct D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_TOOLS_VISUALIZATION_DESC
{
    ulong DecodedSizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_auto_breadcrumb_node
struct D3D12_AUTO_BREADCRUMB_NODE
{
    const(ubyte)*      pCommandListDebugNameA;
    const(PWSTR)       pCommandListDebugNameW;
    const(ubyte)*      pCommandQueueDebugNameA;
    const(PWSTR)       pCommandQueueDebugNameW;
    ID3D12GraphicsCommandList pCommandList;
    ID3D12CommandQueue pCommandQueue;
    uint               BreadcrumbCount;
    const(uint)*       pLastBreadcrumbValue;
    const(D3D12_AUTO_BREADCRUMB_OP)* pCommandHistory;
    const(D3D12_AUTO_BREADCRUMB_NODE)* pNext;
}

struct D3D12_DRED_BREADCRUMB_CONTEXT
{
    uint         BreadcrumbIndex;
    const(PWSTR) pContextString;
}

struct D3D12_AUTO_BREADCRUMB_NODE1
{
    const(ubyte)*      pCommandListDebugNameA;
    const(PWSTR)       pCommandListDebugNameW;
    const(ubyte)*      pCommandQueueDebugNameA;
    const(PWSTR)       pCommandQueueDebugNameW;
    ID3D12GraphicsCommandList pCommandList;
    ID3D12CommandQueue pCommandQueue;
    uint               BreadcrumbCount;
    const(uint)*       pLastBreadcrumbValue;
    const(D3D12_AUTO_BREADCRUMB_OP)* pCommandHistory;
    const(D3D12_AUTO_BREADCRUMB_NODE1)* pNext;
    uint               BreadcrumbContextsCount;
    D3D12_DRED_BREADCRUMB_CONTEXT* pBreadcrumbContexts;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_device_removed_extended_data
struct D3D12_DEVICE_REMOVED_EXTENDED_DATA
{
    D3D12_DRED_FLAGS Flags;
    D3D12_AUTO_BREADCRUMB_NODE* pHeadAutoBreadcrumbNode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_dred_allocation_node
struct D3D12_DRED_ALLOCATION_NODE
{
    const(ubyte)* ObjectNameA;
    const(PWSTR)  ObjectNameW;
    D3D12_DRED_ALLOCATION_TYPE AllocationType;
    const(D3D12_DRED_ALLOCATION_NODE)* pNext;
}

struct D3D12_DRED_ALLOCATION_NODE1
{
    const(ubyte)*   ObjectNameA;
    const(PWSTR)    ObjectNameW;
    D3D12_DRED_ALLOCATION_TYPE AllocationType;
    const(D3D12_DRED_ALLOCATION_NODE1)* pNext;
    const(IUnknown) pObject;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_dred_auto_breadcrumbs_output
struct D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT
{
    const(D3D12_AUTO_BREADCRUMB_NODE)* pHeadAutoBreadcrumbNode;
}

struct D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1
{
    const(D3D12_AUTO_BREADCRUMB_NODE1)* pHeadAutoBreadcrumbNode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_dred_page_fault_output
struct D3D12_DRED_PAGE_FAULT_OUTPUT
{
    ulong PageFaultVA;
    const(D3D12_DRED_ALLOCATION_NODE)* pHeadExistingAllocationNode;
    const(D3D12_DRED_ALLOCATION_NODE)* pHeadRecentFreedAllocationNode;
}

struct D3D12_DRED_PAGE_FAULT_OUTPUT1
{
    ulong PageFaultVA;
    const(D3D12_DRED_ALLOCATION_NODE1)* pHeadExistingAllocationNode;
    const(D3D12_DRED_ALLOCATION_NODE1)* pHeadRecentFreedAllocationNode;
}

struct D3D12_DRED_PAGE_FAULT_OUTPUT2
{
    ulong PageFaultVA;
    const(D3D12_DRED_ALLOCATION_NODE1)* pHeadExistingAllocationNode;
    const(D3D12_DRED_ALLOCATION_NODE1)* pHeadRecentFreedAllocationNode;
    D3D12_DRED_PAGE_FAULT_FLAGS PageFaultFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_device_removed_extended_data1
struct D3D12_DEVICE_REMOVED_EXTENDED_DATA1
{
    HRESULT DeviceRemovedReason;
    D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT AutoBreadcrumbsOutput;
    D3D12_DRED_PAGE_FAULT_OUTPUT PageFaultOutput;
}

struct D3D12_DEVICE_REMOVED_EXTENDED_DATA2
{
    HRESULT DeviceRemovedReason;
    D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1 AutoBreadcrumbsOutput;
    D3D12_DRED_PAGE_FAULT_OUTPUT1 PageFaultOutput;
}

struct D3D12_DEVICE_REMOVED_EXTENDED_DATA3
{
    HRESULT DeviceRemovedReason;
    D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1 AutoBreadcrumbsOutput;
    D3D12_DRED_PAGE_FAULT_OUTPUT2 PageFaultOutput;
    D3D12_DRED_DEVICE_STATE DeviceState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_versioned_device_removed_extended_data
struct D3D12_VERSIONED_DEVICE_REMOVED_EXTENDED_DATA
{
    D3D12_DRED_VERSION Version;
    union
    {
        D3D12_DEVICE_REMOVED_EXTENDED_DATA Dred_1_0;
        D3D12_DEVICE_REMOVED_EXTENDED_DATA1 Dred_1_1;
        D3D12_DEVICE_REMOVED_EXTENDED_DATA2 Dred_1_2;
        D3D12_DEVICE_REMOVED_EXTENDED_DATA3 Dred_1_3;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_protected_resource_session_type_count
struct D3D12_FEATURE_DATA_PROTECTED_RESOURCE_SESSION_TYPE_COUNT
{
    uint NodeIndex;
    uint Count;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_protected_resource_session_types
struct D3D12_FEATURE_DATA_PROTECTED_RESOURCE_SESSION_TYPES
{
    uint  NodeIndex;
    uint  Count;
    GUID* pTypes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_protected_resource_session_desc1
struct D3D12_PROTECTED_RESOURCE_SESSION_DESC1
{
    uint NodeMask;
    D3D12_PROTECTED_RESOURCE_SESSION_FLAGS Flags;
    GUID ProtectionType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_render_pass_beginning_access_clear_parameters
struct D3D12_RENDER_PASS_BEGINNING_ACCESS_CLEAR_PARAMETERS
{
    D3D12_CLEAR_VALUE ClearValue;
}

struct D3D12_RENDER_PASS_BEGINNING_ACCESS_PRESERVE_LOCAL_PARAMETERS
{
    uint AdditionalWidth;
    uint AdditionalHeight;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_render_pass_beginning_access
struct D3D12_RENDER_PASS_BEGINNING_ACCESS
{
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE Type;
    union
    {
        D3D12_RENDER_PASS_BEGINNING_ACCESS_CLEAR_PARAMETERS Clear;
        D3D12_RENDER_PASS_BEGINNING_ACCESS_PRESERVE_LOCAL_PARAMETERS PreserveLocal;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_render_pass_ending_access_resolve_subresource_parameters
struct D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_SUBRESOURCE_PARAMETERS
{
    uint SrcSubresource;
    uint DstSubresource;
    uint DstX;
    uint DstY;
    RECT SrcRect;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_render_pass_ending_access_resolve_parameters
struct D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_PARAMETERS
{
    ID3D12Resource     pSrcResource;
    ID3D12Resource     pDstResource;
    uint               SubresourceCount;
    const(D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_SUBRESOURCE_PARAMETERS)* pSubresourceParameters;
    DXGI_FORMAT        Format;
    D3D12_RESOLVE_MODE ResolveMode;
    BOOL               PreserveResolveSource;
}

struct D3D12_RENDER_PASS_ENDING_ACCESS_PRESERVE_LOCAL_PARAMETERS
{
    uint AdditionalWidth;
    uint AdditionalHeight;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_render_pass_ending_access
struct D3D12_RENDER_PASS_ENDING_ACCESS
{
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE Type;
    union
    {
        D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_PARAMETERS Resolve;
        D3D12_RENDER_PASS_ENDING_ACCESS_PRESERVE_LOCAL_PARAMETERS PreserveLocal;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_render_pass_render_target_desc
struct D3D12_RENDER_PASS_RENDER_TARGET_DESC
{
    D3D12_CPU_DESCRIPTOR_HANDLE cpuDescriptor;
    D3D12_RENDER_PASS_BEGINNING_ACCESS BeginningAccess;
    D3D12_RENDER_PASS_ENDING_ACCESS EndingAccess;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_render_pass_depth_stencil_desc
struct D3D12_RENDER_PASS_DEPTH_STENCIL_DESC
{
    D3D12_CPU_DESCRIPTOR_HANDLE cpuDescriptor;
    D3D12_RENDER_PASS_BEGINNING_ACCESS DepthBeginningAccess;
    D3D12_RENDER_PASS_BEGINNING_ACCESS StencilBeginningAccess;
    D3D12_RENDER_PASS_ENDING_ACCESS DepthEndingAccess;
    D3D12_RENDER_PASS_ENDING_ACCESS StencilEndingAccess;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_dispatch_rays_desc
struct D3D12_DISPATCH_RAYS_DESC
{
    D3D12_GPU_VIRTUAL_ADDRESS_RANGE RayGenerationShaderRecord;
    D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE MissShaderTable;
    D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE HitGroupTable;
    D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE CallableShaderTable;
    uint Width;
    uint Height;
    uint Depth;
}

struct D3D12_SET_WORK_GRAPH_DESC
{
    D3D12_PROGRAM_IDENTIFIER ProgramIdentifier;
    D3D12_SET_WORK_GRAPH_FLAGS Flags;
    D3D12_GPU_VIRTUAL_ADDRESS_RANGE BackingMemory;
    D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE NodeLocalRootArgumentsTable;
}

struct D3D12_SET_RAYTRACING_PIPELINE_DESC
{
    D3D12_PROGRAM_IDENTIFIER ProgramIdentifier;
}

struct D3D12_SET_GENERIC_PIPELINE_DESC
{
    D3D12_PROGRAM_IDENTIFIER ProgramIdentifier;
}

struct D3D12_SET_PROGRAM_DESC
{
    D3D12_PROGRAM_TYPE Type;
    union
    {
        D3D12_SET_GENERIC_PIPELINE_DESC GenericPipeline;
        D3D12_SET_RAYTRACING_PIPELINE_DESC RaytracingPipeline;
        D3D12_SET_WORK_GRAPH_DESC WorkGraph;
    }
}

struct D3D12_NODE_CPU_INPUT
{
    uint         EntrypointIndex;
    uint         NumRecords;
    const(void)* pRecords;
    ulong        RecordStrideInBytes;
}

struct D3D12_NODE_GPU_INPUT
{
    uint EntrypointIndex;
    uint NumRecords;
    D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE Records;
}

struct D3D12_MULTI_NODE_CPU_INPUT
{
    uint  NumNodeInputs;
    const(D3D12_NODE_CPU_INPUT)* pNodeInputs;
    ulong NodeInputStrideInBytes;
}

struct D3D12_MULTI_NODE_GPU_INPUT
{
    uint NumNodeInputs;
    D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE NodeInputs;
}

struct D3D12_DISPATCH_GRAPH_DESC
{
    D3D12_DISPATCH_MODE Mode;
    union
    {
        D3D12_NODE_CPU_INPUT NodeCPUInput;
        ulong                NodeGPUInput;
        D3D12_MULTI_NODE_CPU_INPUT MultiNodeCPUInput;
        ulong                MultiNodeGPUInput;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_cache_session_desc
struct D3D12_SHADER_CACHE_SESSION_DESC
{
    GUID  Identifier;
    D3D12_SHADER_CACHE_MODE Mode;
    D3D12_SHADER_CACHE_FLAGS Flags;
    uint  MaximumInMemoryCacheSizeBytes;
    uint  MaximumInMemoryCacheEntries;
    uint  MaximumValueFileSizeBytes;
    ulong Version;
}

struct D3D12_FEATURE_DATA_BARRIER_LAYOUT
{
    D3D12_COMMAND_LIST_TYPE CommandListType;
    D3D12_BARRIER_LAYOUT Layout;
    BOOL                 Supported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_barrier_subresource_range
struct D3D12_BARRIER_SUBRESOURCE_RANGE
{
    uint IndexOrFirstMipLevel;
    uint NumMipLevels;
    uint FirstArraySlice;
    uint NumArraySlices;
    uint FirstPlane;
    uint NumPlanes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_global_barrier
struct D3D12_GLOBAL_BARRIER
{
    D3D12_BARRIER_SYNC   SyncBefore;
    D3D12_BARRIER_SYNC   SyncAfter;
    D3D12_BARRIER_ACCESS AccessBefore;
    D3D12_BARRIER_ACCESS AccessAfter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_texture_barrier
struct D3D12_TEXTURE_BARRIER
{
    D3D12_BARRIER_SYNC   SyncBefore;
    D3D12_BARRIER_SYNC   SyncAfter;
    D3D12_BARRIER_ACCESS AccessBefore;
    D3D12_BARRIER_ACCESS AccessAfter;
    D3D12_BARRIER_LAYOUT LayoutBefore;
    D3D12_BARRIER_LAYOUT LayoutAfter;
    ID3D12Resource       pResource;
    D3D12_BARRIER_SUBRESOURCE_RANGE Subresources;
    D3D12_TEXTURE_BARRIER_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_buffer_barrier
struct D3D12_BUFFER_BARRIER
{
    D3D12_BARRIER_SYNC   SyncBefore;
    D3D12_BARRIER_SYNC   SyncAfter;
    D3D12_BARRIER_ACCESS AccessBefore;
    D3D12_BARRIER_ACCESS AccessAfter;
    ID3D12Resource       pResource;
    ulong                Offset;
    ulong                Size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_barrier_group
struct D3D12_BARRIER_GROUP
{
    D3D12_BARRIER_TYPE Type;
    uint               NumBarriers;
    union
    {
        const(D3D12_GLOBAL_BARRIER)* pGlobalBarriers;
        const(D3D12_TEXTURE_BARRIER)* pTextureBarriers;
        const(D3D12_BUFFER_BARRIER)* pBufferBarriers;
    }
}

struct D3D12_TRIM_NOTIFICATION
{
    void* pContext;
    D3D12_TRIM_NOTIFICATION_FLAGS Flags;
    ulong NumBytesToTrim;
}

struct D3D12_REGISTER_TRIM_NOTIFICATION
{
    D3D12_PFN_TRIM_NOTIFICATION_CALLBACK pfnCallback;
    void* pContext;
    uint  CallbackCookie;
}

union D3D12_VERSION_NUMBER
{
    ulong     Version;
    ushort[4] VersionParts;
}

struct D3D12_FEATURE_DATA_SHADERCACHE_ABI_SUPPORT
{
    wchar[128]           szAdapterFamily;
    ulong                MinimumABISupportVersion;
    ulong                MaximumABISupportVersion;
    D3D12_VERSION_NUMBER CompilerVersion;
    D3D12_VERSION_NUMBER ApplicationProfileVersion;
}

struct D3D12_APPLICATION_DESC
{
    const(PWSTR)         pExeFilename;
    const(PWSTR)         pName;
    D3D12_VERSION_NUMBER Version;
    const(PWSTR)         pEngineName;
    D3D12_VERSION_NUMBER EngineVersion;
}

struct D3D12_EXISTING_COLLECTION_BY_KEY_DESC
{
    const(void)* pKey;
    uint         KeySize;
    uint         NumExports;
    const(D3D12_EXPORT_DESC)* pExports;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_subresource_data
struct D3D12_SUBRESOURCE_DATA
{
    const(void)* pData;
    ptrdiff_t    RowPitch;
    ptrdiff_t    SlicePitch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/ns-d3d12-d3d12_memcpy_dest
struct D3D12_MEMCPY_DEST
{
    void*  pData;
    size_t RowPitch;
    size_t SlicePitch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ns-d3d12sdklayers-d3d12_debug_device_gpu_based_validation_settings
struct D3D12_DEBUG_DEVICE_GPU_BASED_VALIDATION_SETTINGS
{
    uint MaxMessagesPerCommandList;
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE DefaultShaderPatchMode;
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS PipelineStateCreateFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ns-d3d12sdklayers-d3d12_debug_device_gpu_slowdown_performance_factor
struct D3D12_DEBUG_DEVICE_GPU_SLOWDOWN_PERFORMANCE_FACTOR
{
    float SlowdownFactor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ns-d3d12sdklayers-d3d12_debug_command_list_gpu_based_validation_settings
struct D3D12_DEBUG_COMMAND_LIST_GPU_BASED_VALIDATION_SETTINGS
{
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE ShaderPatchMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ns-d3d12sdklayers-d3d12_message
struct D3D12_MESSAGE
{
    D3D12_MESSAGE_CATEGORY Category;
    D3D12_MESSAGE_SEVERITY Severity;
    D3D12_MESSAGE_ID ID;
    const(ubyte)*    pDescription;
    size_t           DescriptionByteLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ns-d3d12sdklayers-d3d12_info_queue_filter_desc
struct D3D12_INFO_QUEUE_FILTER_DESC
{
    uint              NumCategories;
    D3D12_MESSAGE_CATEGORY* pCategoryList;
    uint              NumSeverities;
    D3D12_MESSAGE_SEVERITY* pSeverityList;
    uint              NumIDs;
    D3D12_MESSAGE_ID* pIDList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/ns-d3d12sdklayers-d3d12_info_queue_filter
struct D3D12_INFO_QUEUE_FILTER
{
    D3D12_INFO_QUEUE_FILTER_DESC AllowList;
    D3D12_INFO_QUEUE_FILTER_DESC DenyList;
}

struct D3D12_DEVICE_CONFIGURATION_DESC
{
    D3D12_DEVICE_FLAGS Flags;
    uint               GpuBasedValidationFlags;
    uint               SDKVersion;
    uint               NumEnabledExperimentalFeatures;
}

struct D3D12_DISPATCH_MESH_ARGUMENTS
{
    uint ThreadGroupCountX;
    uint ThreadGroupCountY;
    uint ThreadGroupCountZ;
}

struct D3D12_CREATE_STATE_OBJECT_STATISTICS
{
    uint NumCreated;
    uint NumPSDBCacheMissed;
    uint NumTotalCacheMissed;
    uint NumCacheUnknown;
}

struct D3D12_STATE_OBJECT_STATISTICS
{
    BOOL DefaultPSDBRegistered;
    D3D12_CREATE_STATE_OBJECT_STATISTICS PipelineStateObjectStatistics;
    D3D12_CREATE_STATE_OBJECT_STATISTICS StateObjectStatistics;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/ns-d3d12shader-d3d12_signature_parameter_desc
struct D3D12_SIGNATURE_PARAMETER_DESC
{
    const(PSTR)       SemanticName;
    uint              SemanticIndex;
    uint              Register;
    D3D_NAME          SystemValueType;
    D3D_REGISTER_COMPONENT_TYPE ComponentType;
    ubyte             Mask;
    ubyte             ReadWriteMask;
    uint              Stream;
    D3D_MIN_PRECISION MinPrecision;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/ns-d3d12shader-d3d12_shader_buffer_desc
struct D3D12_SHADER_BUFFER_DESC
{
    const(PSTR)      Name;
    D3D_CBUFFER_TYPE Type;
    uint             Variables;
    uint             Size;
    uint             uFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/ns-d3d12shader-d3d12_shader_variable_desc
struct D3D12_SHADER_VARIABLE_DESC
{
    const(PSTR) Name;
    uint        StartOffset;
    uint        Size;
    uint        uFlags;
    void*       DefaultValue;
    uint        StartTexture;
    uint        TextureSize;
    uint        StartSampler;
    uint        SamplerSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/ns-d3d12shader-d3d12_shader_type_desc
struct D3D12_SHADER_TYPE_DESC
{
    D3D_SHADER_VARIABLE_CLASS Class;
    D3D_SHADER_VARIABLE_TYPE Type;
    uint        Rows;
    uint        Columns;
    uint        Elements;
    uint        Members;
    uint        Offset;
    const(PSTR) Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/ns-d3d12shader-d3d12_shader_desc
struct D3D12_SHADER_DESC
{
    uint          Version;
    const(PSTR)   Creator;
    uint          Flags;
    uint          ConstantBuffers;
    uint          BoundResources;
    uint          InputParameters;
    uint          OutputParameters;
    uint          InstructionCount;
    uint          TempRegisterCount;
    uint          TempArrayCount;
    uint          DefCount;
    uint          DclCount;
    uint          TextureNormalInstructions;
    uint          TextureLoadInstructions;
    uint          TextureCompInstructions;
    uint          TextureBiasInstructions;
    uint          TextureGradientInstructions;
    uint          FloatInstructionCount;
    uint          IntInstructionCount;
    uint          UintInstructionCount;
    uint          StaticFlowControlCount;
    uint          DynamicFlowControlCount;
    uint          MacroInstructionCount;
    uint          ArrayInstructionCount;
    uint          CutInstructionCount;
    uint          EmitInstructionCount;
    D3D_PRIMITIVE_TOPOLOGY GSOutputTopology;
    uint          GSMaxOutputVertexCount;
    D3D_PRIMITIVE InputPrimitive;
    uint          PatchConstantParameters;
    uint          cGSInstanceCount;
    uint          cControlPoints;
    D3D_TESSELLATOR_OUTPUT_PRIMITIVE HSOutputPrimitive;
    D3D_TESSELLATOR_PARTITIONING HSPartitioning;
    D3D_TESSELLATOR_DOMAIN TessellatorDomain;
    uint          cBarrierInstructions;
    uint          cInterlockedInstructions;
    uint          cTextureStoreInstructions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/ns-d3d12shader-d3d12_shader_input_bind_desc
struct D3D12_SHADER_INPUT_BIND_DESC
{
    const(PSTR)       Name;
    D3D_SHADER_INPUT_TYPE Type;
    uint              BindPoint;
    uint              BindCount;
    uint              uFlags;
    D3D_RESOURCE_RETURN_TYPE ReturnType;
    D3D_SRV_DIMENSION Dimension;
    uint              NumSamples;
    uint              Space;
    uint              uID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/ns-d3d12shader-d3d12_library_desc
struct D3D12_LIBRARY_DESC
{
    const(PSTR) Creator;
    uint        Flags;
    uint        FunctionCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/ns-d3d12shader-d3d12_function_desc
struct D3D12_FUNCTION_DESC
{
    uint              Version;
    const(PSTR)       Creator;
    uint              Flags;
    uint              ConstantBuffers;
    uint              BoundResources;
    uint              InstructionCount;
    uint              TempRegisterCount;
    uint              TempArrayCount;
    uint              DefCount;
    uint              DclCount;
    uint              TextureNormalInstructions;
    uint              TextureLoadInstructions;
    uint              TextureCompInstructions;
    uint              TextureBiasInstructions;
    uint              TextureGradientInstructions;
    uint              FloatInstructionCount;
    uint              IntInstructionCount;
    uint              UintInstructionCount;
    uint              StaticFlowControlCount;
    uint              DynamicFlowControlCount;
    uint              MacroInstructionCount;
    uint              ArrayInstructionCount;
    uint              MovInstructionCount;
    uint              MovcInstructionCount;
    uint              ConversionInstructionCount;
    uint              BitwiseInstructionCount;
    D3D_FEATURE_LEVEL MinFeatureLevel;
    ulong             RequiredFeatureFlags;
    const(PSTR)       Name;
    int               FunctionParameterCount;
    BOOL              HasReturn;
    BOOL              Has10Level9VertexShader;
    BOOL              Has10Level9PixelShader;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/ns-d3d12shader-d3d12_parameter_desc
struct D3D12_PARAMETER_DESC
{
    const(PSTR)         Name;
    const(PSTR)         SemanticName;
    D3D_SHADER_VARIABLE_TYPE Type;
    D3D_SHADER_VARIABLE_CLASS Class;
    uint                Rows;
    uint                Columns;
    D3D_INTERPOLATION_MODE InterpolationMode;
    D3D_PARAMETER_FLAGS Flags;
    uint                FirstInRegister;
    uint                FirstInComponent;
    uint                FirstOutRegister;
    uint                FirstOutComponent;
}

struct D3D12_ADAPTER_FAMILY
{
    wchar[128] szAdapterFamily;
}

struct D3D12_COMPILER_DATABASE_PATH
{
    D3D12_COMPILER_VALUE_TYPE_FLAGS Types;
    const(PWSTR) pPath;
}

struct D3D12_COMPILER_CACHE_GROUP_KEY
{
    const(void)* pKey;
    uint         KeySize;
}

struct D3D12_COMPILER_CACHE_VALUE_KEY
{
    const(void)* pKey;
    uint         KeySize;
}

struct D3D12_COMPILER_CACHE_VALUE
{
    void* pValue;
    uint  ValueSize;
}

struct D3D12_COMPILER_CACHE_TYPED_VALUE
{
    D3D12_COMPILER_VALUE_TYPE Type;
    D3D12_COMPILER_CACHE_VALUE Value;
}

struct D3D12_COMPILER_CACHE_CONST_VALUE
{
    const(void)* pValue;
    uint         ValueSize;
}

struct D3D12_COMPILER_CACHE_TYPED_CONST_VALUE
{
    D3D12_COMPILER_VALUE_TYPE Type;
    D3D12_COMPILER_CACHE_CONST_VALUE Value;
}

struct D3D12_COMPILER_TARGET
{
    uint  AdapterFamilyIndex;
    ulong ABIVersion;
}

struct D3D12_COMPILER_EXISTING_COLLECTION_DESC
{
    ID3D12CompilerStateObject pExistingCollection;
    uint NumExports;
    const(D3D12_EXPORT_DESC)* pExports;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-d3d12serializerootsignature
@DllImport("d3d12.dll")
HRESULT D3D12SerializeRootSignature(const(D3D12_ROOT_SIGNATURE_DESC)* pRootSignature, 
                                    D3D_ROOT_SIGNATURE_VERSION Version, ID3DBlob* ppBlob, ID3DBlob* ppErrorBlob);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-d3d12createrootsignaturedeserializer
@DllImport("d3d12.dll")
HRESULT D3D12CreateRootSignatureDeserializer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                                             size_t SrcDataSizeInBytes, 
                                             const(GUID)* pRootSignatureDeserializerInterface, 
                                             void** ppRootSignatureDeserializer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-d3d12serializeversionedrootsignature
@DllImport("d3d12.dll")
HRESULT D3D12SerializeVersionedRootSignature(const(D3D12_VERSIONED_ROOT_SIGNATURE_DESC)* pRootSignature, 
                                             ID3DBlob* ppBlob, ID3DBlob* ppErrorBlob);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-d3d12createversionedrootsignaturedeserializer
@DllImport("d3d12.dll")
HRESULT D3D12CreateVersionedRootSignatureDeserializer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                                                      size_t SrcDataSizeInBytes, 
                                                      const(GUID)* pRootSignatureDeserializerInterface, 
                                                      void** ppRootSignatureDeserializer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-d3d12createdevice
@DllImport("d3d12.dll")
HRESULT D3D12CreateDevice(IUnknown pAdapter, D3D_FEATURE_LEVEL MinimumFeatureLevel, const(GUID)* riid, 
                          void** ppDevice);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-d3d12getdebuginterface
@DllImport("d3d12.dll")
HRESULT D3D12GetDebugInterface(const(GUID)* riid, void** ppvDebug);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-d3d12enableexperimentalfeatures
@DllImport("d3d12.dll")
HRESULT D3D12EnableExperimentalFeatures(uint NumFeatures, const(GUID)* pIIDs, void* pConfigurationStructs, 
                                        uint* pConfigurationStructSizes);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-d3d12getinterface
@DllImport("d3d12.dll")
HRESULT D3D12GetInterface(const(GUID)* rclsid, const(GUID)* riid, void** ppvDebug);


// Interfaces

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12object
@GUID("c4fec28f-7966-4e95-9f94-f431cb56c3b8")
interface ID3D12Object : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12object-getprivatedata
    HRESULT GetPrivateData(const(GUID)* guid, uint* pDataSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12object-setprivatedata
    HRESULT SetPrivateData(const(GUID)* guid, uint DataSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12object-setprivatedatainterface
    HRESULT SetPrivateDataInterface(const(GUID)* guid, const(IUnknown) pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12object-setname
    HRESULT SetName(const(PWSTR) Name);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12devicechild
@GUID("905db94b-a00c-4140-9df5-2b64ca9ea357")
interface ID3D12DeviceChild : ID3D12Object
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12devicechild-getdevice
    HRESULT GetDevice(const(GUID)* riid, void** ppvDevice);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12rootsignature
@GUID("c54a6b66-72df-4ee8-8be5-a946a1429214")
interface ID3D12RootSignature : ID3D12DeviceChild
{
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("c390bd7d-9142-4a95-b072-6d3439ade5c4")
interface ID3D12RootSignature1 : ID3D12RootSignature
{
    size_t  GetSerializedSize();
    HRESULT GetSerializedData(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pData, 
                              size_t Size);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12rootsignaturedeserializer
@GUID("34ab647b-3cc8-46ac-841b-c0965645c046")
interface ID3D12RootSignatureDeserializer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12rootsignaturedeserializer-getrootsignaturedesc
    D3D12_ROOT_SIGNATURE_DESC* GetRootSignatureDesc();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12versionedrootsignaturedeserializer
@GUID("7f91ce67-090c-4bb7-b78e-ed8ff2e31da0")
interface ID3D12VersionedRootSignatureDeserializer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12versionedrootsignaturedeserializer-getrootsignaturedescatversion
    HRESULT GetRootSignatureDescAtVersion(D3D_ROOT_SIGNATURE_VERSION convertToVersion, 
                                          const(D3D12_VERSIONED_ROOT_SIGNATURE_DESC)** ppDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12versionedrootsignaturedeserializer-getunconvertedrootsignaturedesc
    D3D12_VERSIONED_ROOT_SIGNATURE_DESC* GetUnconvertedRootSignatureDesc();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12pageable
@GUID("63ee58fb-1268-4835-86da-f008ce62f0d6")
interface ID3D12Pageable : ID3D12DeviceChild
{
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12heap
@GUID("6b3b2502-6e51-45b3-90ee-9884265e8df3")
interface ID3D12Heap : ID3D12Pageable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d12/id3d12heap-getdesc
    D3D12_HEAP_DESC GetDesc();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12resource
@GUID("696442be-a72e-4059-bc79-5b5c98040fad")
interface ID3D12Resource : ID3D12Pageable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12resource-map
    HRESULT Map(uint Subresource, const(D3D12_RANGE)* pReadRange, void** ppData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12resource-unmap
    void    Unmap(uint Subresource, const(D3D12_RANGE)* pWrittenRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d12/id3d12resource-getdesc
    D3D12_RESOURCE_DESC GetDesc();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12resource-getgpuvirtualaddress
    ulong   GetGPUVirtualAddress();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12resource-writetosubresource
    HRESULT WriteToSubresource(uint DstSubresource, const(D3D12_BOX)* pDstBox, const(void)* pSrcData, 
                               uint SrcRowPitch, uint SrcDepthPitch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12resource-readfromsubresource
    HRESULT ReadFromSubresource(void* pDstData, uint DstRowPitch, uint DstDepthPitch, uint SrcSubresource, 
                                const(D3D12_BOX)* pSrcBox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12resource-getheapproperties
    HRESULT GetHeapProperties(D3D12_HEAP_PROPERTIES* pHeapProperties, D3D12_HEAP_FLAGS* pHeapFlags);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12commandallocator
@GUID("6102dee4-af59-4b09-b999-b44d73f09b24")
interface ID3D12CommandAllocator : ID3D12Pageable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandallocator-reset
    HRESULT Reset();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12fence
@GUID("0a753dcf-c4d8-4b91-adf6-be5a60d95a76")
interface ID3D12Fence : ID3D12Pageable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12fence-getcompletedvalue
    ulong   GetCompletedValue();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12fence-seteventoncompletion
    HRESULT SetEventOnCompletion(ulong Value, HANDLE hEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12fence-signal
    HRESULT Signal(ulong Value);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12fence1
@GUID("433685fe-e22b-4ca0-a8db-b5b4f4dd0e4a")
interface ID3D12Fence1 : ID3D12Fence
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12fence1-getcreationflags
    D3D12_FENCE_FLAGS GetCreationFlags();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12pipelinestate
@GUID("765a30f3-f624-4c6f-a828-ace948622445")
interface ID3D12PipelineState : ID3D12Pageable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12pipelinestate-getcachedblob
    HRESULT GetCachedBlob(ID3DBlob* ppBlob);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("5646804c-9638-48f7-9182-b3ee5a6b60fb")
interface ID3D12PipelineState1 : ID3D12PipelineState
{
    HRESULT GetRootSignature(const(GUID)* riid, void** ppvRootSignature);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12descriptorheap
@GUID("8efb471d-616c-4f49-90f7-127bb763fa51")
interface ID3D12DescriptorHeap : ID3D12Pageable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12descriptorheap-getdesc
    D3D12_DESCRIPTOR_HEAP_DESC GetDesc();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12descriptorheap-getcpudescriptorhandleforheapstart
    D3D12_CPU_DESCRIPTOR_HANDLE GetCPUDescriptorHandleForHeapStart();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12descriptorheap-getgpudescriptorhandleforheapstart
    D3D12_GPU_DESCRIPTOR_HANDLE GetGPUDescriptorHandleForHeapStart();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12queryheap
@GUID("0d9658ae-ed45-469e-a61d-970ec583cab4")
interface ID3D12QueryHeap : ID3D12Pageable
{
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12commandsignature
@GUID("c36a797c-ec80-4f0a-8985-a7b2475082d1")
interface ID3D12CommandSignature : ID3D12Pageable
{
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12commandlist
@GUID("7116d91c-e7e4-47ce-b8c6-ec8168f437e5")
interface ID3D12CommandList : ID3D12DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandlist-gettype
    D3D12_COMMAND_LIST_TYPE GetType();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12graphicscommandlist
@GUID("5b160d0f-ac1b-4185-8ba8-b3ae42a5a455")
interface ID3D12GraphicsCommandList : ID3D12CommandList
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-reset
    HRESULT Reset(ID3D12CommandAllocator pAllocator, ID3D12PipelineState pInitialState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-clearstate
    void    ClearState(ID3D12PipelineState pPipelineState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-drawinstanced
    void    DrawInstanced(uint VertexCountPerInstance, uint InstanceCount, uint StartVertexLocation, 
                          uint StartInstanceLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-drawindexedinstanced
    void    DrawIndexedInstanced(uint IndexCountPerInstance, uint InstanceCount, uint StartIndexLocation, 
                                 int BaseVertexLocation, uint StartInstanceLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-dispatch
    void    Dispatch(uint ThreadGroupCountX, uint ThreadGroupCountY, uint ThreadGroupCountZ);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-copybufferregion
    void    CopyBufferRegion(ID3D12Resource pDstBuffer, ulong DstOffset, ID3D12Resource pSrcBuffer, 
                             ulong SrcOffset, ulong NumBytes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-copytextureregion
    void    CopyTextureRegion(const(D3D12_TEXTURE_COPY_LOCATION)* pDst, uint DstX, uint DstY, uint DstZ, 
                              const(D3D12_TEXTURE_COPY_LOCATION)* pSrc, const(D3D12_BOX)* pSrcBox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-copyresource
    void    CopyResource(ID3D12Resource pDstResource, ID3D12Resource pSrcResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-copytiles
    void    CopyTiles(ID3D12Resource pTiledResource, 
                      const(D3D12_TILED_RESOURCE_COORDINATE)* pTileRegionStartCoordinate, 
                      const(D3D12_TILE_REGION_SIZE)* pTileRegionSize, ID3D12Resource pBuffer, 
                      ulong BufferStartOffsetInBytes, D3D12_TILE_COPY_FLAGS Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-resolvesubresource
    void    ResolveSubresource(ID3D12Resource pDstResource, uint DstSubresource, ID3D12Resource pSrcResource, 
                               uint SrcSubresource, DXGI_FORMAT Format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-iasetprimitivetopology
    void    IASetPrimitiveTopology(D3D_PRIMITIVE_TOPOLOGY PrimitiveTopology);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-rssetviewports
    void    RSSetViewports(uint NumViewports, const(D3D12_VIEWPORT)* pViewports);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-rssetscissorrects
    void    RSSetScissorRects(uint NumRects, const(RECT)* pRects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-omsetblendfactor
    void    OMSetBlendFactor(const(float)* BlendFactor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-omsetstencilref
    void    OMSetStencilRef(uint StencilRef);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setpipelinestate
    void    SetPipelineState(ID3D12PipelineState pPipelineState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-resourcebarrier
    void    ResourceBarrier(uint NumBarriers, const(D3D12_RESOURCE_BARRIER)* pBarriers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-executebundle
    void    ExecuteBundle(ID3D12GraphicsCommandList pCommandList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setdescriptorheaps
    void    SetDescriptorHeaps(uint NumDescriptorHeaps, ID3D12DescriptorHeap* ppDescriptorHeaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setcomputerootsignature
    void    SetComputeRootSignature(ID3D12RootSignature pRootSignature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setgraphicsrootsignature
    void    SetGraphicsRootSignature(ID3D12RootSignature pRootSignature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setcomputerootdescriptortable
    void    SetComputeRootDescriptorTable(uint RootParameterIndex, D3D12_GPU_DESCRIPTOR_HANDLE BaseDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setgraphicsrootdescriptortable
    void    SetGraphicsRootDescriptorTable(uint RootParameterIndex, D3D12_GPU_DESCRIPTOR_HANDLE BaseDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setcomputeroot32bitconstant
    void    SetComputeRoot32BitConstant(uint RootParameterIndex, uint SrcData, uint DestOffsetIn32BitValues);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setgraphicsroot32bitconstant
    void    SetGraphicsRoot32BitConstant(uint RootParameterIndex, uint SrcData, uint DestOffsetIn32BitValues);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setcomputeroot32bitconstants
    void    SetComputeRoot32BitConstants(uint RootParameterIndex, uint Num32BitValuesToSet, const(void)* pSrcData, 
                                         uint DestOffsetIn32BitValues);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setgraphicsroot32bitconstants
    void    SetGraphicsRoot32BitConstants(uint RootParameterIndex, uint Num32BitValuesToSet, const(void)* pSrcData, 
                                          uint DestOffsetIn32BitValues);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setcomputerootconstantbufferview
    void    SetComputeRootConstantBufferView(uint RootParameterIndex, ulong BufferLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setgraphicsrootconstantbufferview
    void    SetGraphicsRootConstantBufferView(uint RootParameterIndex, ulong BufferLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setcomputerootshaderresourceview
    void    SetComputeRootShaderResourceView(uint RootParameterIndex, ulong BufferLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setgraphicsrootshaderresourceview
    void    SetGraphicsRootShaderResourceView(uint RootParameterIndex, ulong BufferLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setcomputerootunorderedaccessview
    void    SetComputeRootUnorderedAccessView(uint RootParameterIndex, ulong BufferLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setgraphicsrootunorderedaccessview
    void    SetGraphicsRootUnorderedAccessView(uint RootParameterIndex, ulong BufferLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-iasetindexbuffer
    void    IASetIndexBuffer(const(D3D12_INDEX_BUFFER_VIEW)* pView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-iasetvertexbuffers
    void    IASetVertexBuffers(uint StartSlot, uint NumViews, const(D3D12_VERTEX_BUFFER_VIEW)* pViews);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-sosettargets
    void    SOSetTargets(uint StartSlot, uint NumViews, const(D3D12_STREAM_OUTPUT_BUFFER_VIEW)* pViews);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-omsetrendertargets
    void    OMSetRenderTargets(uint NumRenderTargetDescriptors, 
                               const(D3D12_CPU_DESCRIPTOR_HANDLE)* pRenderTargetDescriptors, 
                               BOOL RTsSingleHandleToDescriptorRange, 
                               const(D3D12_CPU_DESCRIPTOR_HANDLE)* pDepthStencilDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-cleardepthstencilview
    void    ClearDepthStencilView(D3D12_CPU_DESCRIPTOR_HANDLE DepthStencilView, D3D12_CLEAR_FLAGS ClearFlags, 
                                  float Depth, ubyte Stencil, uint NumRects, const(RECT)* pRects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-clearrendertargetview
    void    ClearRenderTargetView(D3D12_CPU_DESCRIPTOR_HANDLE RenderTargetView, const(float)* ColorRGBA, 
                                  uint NumRects, const(RECT)* pRects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-clearunorderedaccessviewuint
    void    ClearUnorderedAccessViewUint(D3D12_GPU_DESCRIPTOR_HANDLE ViewGPUHandleInCurrentHeap, 
                                         D3D12_CPU_DESCRIPTOR_HANDLE ViewCPUHandle, ID3D12Resource pResource, 
                                         const(uint)* Values, uint NumRects, const(RECT)* pRects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-clearunorderedaccessviewfloat
    void    ClearUnorderedAccessViewFloat(D3D12_GPU_DESCRIPTOR_HANDLE ViewGPUHandleInCurrentHeap, 
                                          D3D12_CPU_DESCRIPTOR_HANDLE ViewCPUHandle, ID3D12Resource pResource, 
                                          const(float)* Values, uint NumRects, const(RECT)* pRects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-discardresource
    void    DiscardResource(ID3D12Resource pResource, const(D3D12_DISCARD_REGION)* pRegion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-beginquery
    void    BeginQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-endquery
    void    EndQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-resolvequerydata
    void    ResolveQueryData(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint StartIndex, uint NumQueries, 
                             ID3D12Resource pDestinationBuffer, ulong AlignedDestinationBufferOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setpredication
    void    SetPredication(ID3D12Resource pBuffer, ulong AlignedBufferOffset, D3D12_PREDICATION_OP Operation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setmarker
    void    SetMarker(uint Metadata, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pData, 
                      uint Size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-beginevent
    void    BeginEvent(uint Metadata, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pData, 
                       uint Size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-endevent
    void    EndEvent();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-executeindirect
    void    ExecuteIndirect(ID3D12CommandSignature pCommandSignature, uint MaxCommandCount, 
                            ID3D12Resource pArgumentBuffer, ulong ArgumentBufferOffset, ID3D12Resource pCountBuffer, 
                            ulong CountBufferOffset);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12graphicscommandlist1
@GUID("553103fb-1fe7-4557-bb38-946d7d0e7ca7")
interface ID3D12GraphicsCommandList1 : ID3D12GraphicsCommandList
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist1-atomiccopybufferuint
    void AtomicCopyBufferUINT(ID3D12Resource pDstBuffer, ulong DstOffset, ID3D12Resource pSrcBuffer, 
                              ulong SrcOffset, uint Dependencies, ID3D12Resource* ppDependentResources, 
                              const(D3D12_SUBRESOURCE_RANGE_UINT64)* pDependentSubresourceRanges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist1-atomiccopybufferuint64
    void AtomicCopyBufferUINT64(ID3D12Resource pDstBuffer, ulong DstOffset, ID3D12Resource pSrcBuffer, 
                                ulong SrcOffset, uint Dependencies, ID3D12Resource* ppDependentResources, 
                                const(D3D12_SUBRESOURCE_RANGE_UINT64)* pDependentSubresourceRanges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist1-omsetdepthbounds
    void OMSetDepthBounds(float Min, float Max);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist1-setsamplepositions
    void SetSamplePositions(uint NumSamplesPerPixel, uint NumPixels, D3D12_SAMPLE_POSITION* pSamplePositions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist1-resolvesubresourceregion
    void ResolveSubresourceRegion(ID3D12Resource pDstResource, uint DstSubresource, uint DstX, uint DstY, 
                                  ID3D12Resource pSrcResource, uint SrcSubresource, RECT* pSrcRect, 
                                  DXGI_FORMAT Format, D3D12_RESOLVE_MODE ResolveMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist1-setviewinstancemask
    void SetViewInstanceMask(uint Mask);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12graphicscommandlist2
@GUID("38c3e585-ff17-412c-9150-4fc6f9d72a28")
interface ID3D12GraphicsCommandList2 : ID3D12GraphicsCommandList1
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist2-writebufferimmediate
    void WriteBufferImmediate(uint Count, const(D3D12_WRITEBUFFERIMMEDIATE_PARAMETER)* pParams, 
                              const(D3D12_WRITEBUFFERIMMEDIATE_MODE)* pModes);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12commandqueue
@GUID("0ec870a6-5d7e-4c22-8cfc-5baae07616ed")
interface ID3D12CommandQueue : ID3D12Pageable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-updatetilemappings
    void    UpdateTileMappings(ID3D12Resource pResource, uint NumResourceRegions, 
                               const(D3D12_TILED_RESOURCE_COORDINATE)* pResourceRegionStartCoordinates, 
                               const(D3D12_TILE_REGION_SIZE)* pResourceRegionSizes, ID3D12Heap pHeap, uint NumRanges, 
                               const(D3D12_TILE_RANGE_FLAGS)* pRangeFlags, const(uint)* pHeapRangeStartOffsets, 
                               const(uint)* pRangeTileCounts, D3D12_TILE_MAPPING_FLAGS Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-copytilemappings
    void    CopyTileMappings(ID3D12Resource pDstResource, 
                             const(D3D12_TILED_RESOURCE_COORDINATE)* pDstRegionStartCoordinate, 
                             ID3D12Resource pSrcResource, 
                             const(D3D12_TILED_RESOURCE_COORDINATE)* pSrcRegionStartCoordinate, 
                             const(D3D12_TILE_REGION_SIZE)* pRegionSize, D3D12_TILE_MAPPING_FLAGS Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-executecommandlists
    void    ExecuteCommandLists(uint NumCommandLists, ID3D12CommandList* ppCommandLists);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-setmarker
    void    SetMarker(uint Metadata, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pData, 
                      uint Size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-beginevent
    void    BeginEvent(uint Metadata, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pData, 
                       uint Size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-endevent
    void    EndEvent();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-signal
    HRESULT Signal(ID3D12Fence pFence, ulong Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-wait
    HRESULT Wait(ID3D12Fence pFence, ulong Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-gettimestampfrequency
    HRESULT GetTimestampFrequency(ulong* pFrequency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-getclockcalibration
    HRESULT GetClockCalibration(ulong* pGpuTimestamp, ulong* pCpuTimestamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12commandqueue-getdesc
    D3D12_COMMAND_QUEUE_DESC GetDesc();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("3a3c3165-0ee7-4b8e-a0af-6356b4c3bbb9")
interface ID3D12CommandQueue1 : ID3D12CommandQueue
{
    HRESULT SetProcessPriority(D3D12_COMMAND_QUEUE_PROCESS_PRIORITY Priority);
    HRESULT GetProcessPriority(D3D12_COMMAND_QUEUE_PROCESS_PRIORITY* pOutValue);
    HRESULT SetGlobalPriority(D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY Priority);
    HRESULT GetGlobalPriority(D3D12_COMMAND_QUEUE_GLOBAL_PRIORITY* pOutValue);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device
@GUID("189819f1-1db6-4b57-be54-1821339b85f7")
interface ID3D12Device : ID3D12Object
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-getnodecount
    uint    GetNodeCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createcommandqueue
    HRESULT CreateCommandQueue(const(D3D12_COMMAND_QUEUE_DESC)* pDesc, const(GUID)* riid, void** ppCommandQueue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createcommandallocator
    HRESULT CreateCommandAllocator(D3D12_COMMAND_LIST_TYPE type, const(GUID)* riid, void** ppCommandAllocator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-creategraphicspipelinestate
    HRESULT CreateGraphicsPipelineState(const(D3D12_GRAPHICS_PIPELINE_STATE_DESC)* pDesc, const(GUID)* riid, 
                                        void** ppPipelineState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createcomputepipelinestate
    HRESULT CreateComputePipelineState(const(D3D12_COMPUTE_PIPELINE_STATE_DESC)* pDesc, const(GUID)* riid, 
                                       void** ppPipelineState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createcommandlist
    HRESULT CreateCommandList(uint nodeMask, D3D12_COMMAND_LIST_TYPE type, 
                              ID3D12CommandAllocator pCommandAllocator, ID3D12PipelineState pInitialState, 
                              const(GUID)* riid, void** ppCommandList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-checkfeaturesupport
    HRESULT CheckFeatureSupport(D3D12_FEATURE Feature, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pFeatureSupportData, 
                                uint FeatureSupportDataSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createdescriptorheap
    HRESULT CreateDescriptorHeap(const(D3D12_DESCRIPTOR_HEAP_DESC)* pDescriptorHeapDesc, const(GUID)* riid, 
                                 void** ppvHeap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-getdescriptorhandleincrementsize
    uint    GetDescriptorHandleIncrementSize(D3D12_DESCRIPTOR_HEAP_TYPE DescriptorHeapType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createrootsignature
    HRESULT CreateRootSignature(uint nodeMask, const(void)* pBlobWithRootSignature, size_t blobLengthInBytes, 
                                const(GUID)* riid, void** ppvRootSignature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createconstantbufferview
    void    CreateConstantBufferView(const(D3D12_CONSTANT_BUFFER_VIEW_DESC)* pDesc, 
                                     D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createshaderresourceview
    void    CreateShaderResourceView(ID3D12Resource pResource, const(D3D12_SHADER_RESOURCE_VIEW_DESC)* pDesc, 
                                     D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createunorderedaccessview
    void    CreateUnorderedAccessView(ID3D12Resource pResource, ID3D12Resource pCounterResource, 
                                      const(D3D12_UNORDERED_ACCESS_VIEW_DESC)* pDesc, 
                                      D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createrendertargetview
    void    CreateRenderTargetView(ID3D12Resource pResource, const(D3D12_RENDER_TARGET_VIEW_DESC)* pDesc, 
                                   D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createdepthstencilview
    void    CreateDepthStencilView(ID3D12Resource pResource, const(D3D12_DEPTH_STENCIL_VIEW_DESC)* pDesc, 
                                   D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createsampler
    void    CreateSampler(const(D3D12_SAMPLER_DESC)* pDesc, D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-copydescriptors
    void    CopyDescriptors(uint NumDestDescriptorRanges, 
                            const(D3D12_CPU_DESCRIPTOR_HANDLE)* pDestDescriptorRangeStarts, 
                            const(uint)* pDestDescriptorRangeSizes, uint NumSrcDescriptorRanges, 
                            const(D3D12_CPU_DESCRIPTOR_HANDLE)* pSrcDescriptorRangeStarts, 
                            const(uint)* pSrcDescriptorRangeSizes, D3D12_DESCRIPTOR_HEAP_TYPE DescriptorHeapsType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-copydescriptorssimple
    void    CopyDescriptorsSimple(uint NumDescriptors, D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptorRangeStart, 
                                  D3D12_CPU_DESCRIPTOR_HANDLE SrcDescriptorRangeStart, 
                                  D3D12_DESCRIPTOR_HEAP_TYPE DescriptorHeapsType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-getresourceallocationinfo
    D3D12_RESOURCE_ALLOCATION_INFO GetResourceAllocationInfo(uint visibleMask, uint numResourceDescs, 
                                                             const(D3D12_RESOURCE_DESC)* pResourceDescs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-getcustomheapproperties
    D3D12_HEAP_PROPERTIES GetCustomHeapProperties(uint nodeMask, D3D12_HEAP_TYPE heapType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createcommittedresource
    HRESULT CreateCommittedResource(const(D3D12_HEAP_PROPERTIES)* pHeapProperties, D3D12_HEAP_FLAGS HeapFlags, 
                                    const(D3D12_RESOURCE_DESC)* pDesc, D3D12_RESOURCE_STATES InitialResourceState, 
                                    const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, const(GUID)* riidResource, 
                                    void** ppvResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createheap
    HRESULT CreateHeap(const(D3D12_HEAP_DESC)* pDesc, const(GUID)* riid, void** ppvHeap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createplacedresource
    HRESULT CreatePlacedResource(ID3D12Heap pHeap, ulong HeapOffset, const(D3D12_RESOURCE_DESC)* pDesc, 
                                 D3D12_RESOURCE_STATES InitialState, const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                 const(GUID)* riid, void** ppvResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createreservedresource
    HRESULT CreateReservedResource(const(D3D12_RESOURCE_DESC)* pDesc, D3D12_RESOURCE_STATES InitialState, 
                                   const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, const(GUID)* riid, 
                                   void** ppvResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createsharedhandle
    HRESULT CreateSharedHandle(ID3D12DeviceChild pObject, const(SECURITY_ATTRIBUTES)* pAttributes, uint Access, 
                               const(PWSTR) Name, HANDLE* pHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-opensharedhandle
    HRESULT OpenSharedHandle(HANDLE NTHandle, const(GUID)* riid, void** ppvObj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-opensharedhandlebyname
    HRESULT OpenSharedHandleByName(const(PWSTR) Name, uint Access, HANDLE* pNTHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-makeresident
    HRESULT MakeResident(uint NumObjects, ID3D12Pageable* ppObjects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-evict
    HRESULT Evict(uint NumObjects, ID3D12Pageable* ppObjects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createfence
    HRESULT CreateFence(ulong InitialValue, D3D12_FENCE_FLAGS Flags, const(GUID)* riid, void** ppFence);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-getdeviceremovedreason
    HRESULT GetDeviceRemovedReason();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-getcopyablefootprints
    void    GetCopyableFootprints(const(D3D12_RESOURCE_DESC)* pResourceDesc, uint FirstSubresource, 
                                  uint NumSubresources, ulong BaseOffset, 
                                  D3D12_PLACED_SUBRESOURCE_FOOTPRINT* pLayouts, uint* pNumRows, 
                                  ulong* pRowSizeInBytes, ulong* pTotalBytes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createqueryheap
    HRESULT CreateQueryHeap(const(D3D12_QUERY_HEAP_DESC)* pDesc, const(GUID)* riid, void** ppvHeap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-setstablepowerstate
    HRESULT SetStablePowerState(BOOL Enable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-createcommandsignature
    HRESULT CreateCommandSignature(const(D3D12_COMMAND_SIGNATURE_DESC)* pDesc, ID3D12RootSignature pRootSignature, 
                                   const(GUID)* riid, void** ppvCommandSignature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-getresourcetiling
    void    GetResourceTiling(ID3D12Resource pTiledResource, uint* pNumTilesForEntireResource, 
                              D3D12_PACKED_MIP_INFO* pPackedMipDesc, 
                              D3D12_TILE_SHAPE* pStandardTileShapeForNonPackedMips, uint* pNumSubresourceTilings, 
                              uint FirstSubresourceTilingToGet, 
                              D3D12_SUBRESOURCE_TILING* pSubresourceTilingsForNonPackedMips);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device-getadapterluid
    LUID    GetAdapterLuid();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12pipelinelibrary
@GUID("c64226a8-9201-46af-b4cc-53fb9ff7414f")
interface ID3D12PipelineLibrary : ID3D12DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12pipelinelibrary-storepipeline
    HRESULT StorePipeline(const(PWSTR) pName, ID3D12PipelineState pPipeline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12pipelinelibrary-loadgraphicspipeline
    HRESULT LoadGraphicsPipeline(const(PWSTR) pName, const(D3D12_GRAPHICS_PIPELINE_STATE_DESC)* pDesc, 
                                 const(GUID)* riid, void** ppPipelineState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12pipelinelibrary-loadcomputepipeline
    HRESULT LoadComputePipeline(const(PWSTR) pName, const(D3D12_COMPUTE_PIPELINE_STATE_DESC)* pDesc, 
                                const(GUID)* riid, void** ppPipelineState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12pipelinelibrary-getserializedsize
    size_t  GetSerializedSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12pipelinelibrary-serialize
    HRESULT Serialize(void* pData, size_t DataSizeInBytes);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12pipelinelibrary1
@GUID("80eabf42-2568-4e5e-bd82-c37f86961dc3")
interface ID3D12PipelineLibrary1 : ID3D12PipelineLibrary
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12pipelinelibrary1-loadpipeline
    HRESULT LoadPipeline(const(PWSTR) pName, const(D3D12_PIPELINE_STATE_STREAM_DESC)* pDesc, const(GUID)* riid, 
                         void** ppPipelineState);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device1
@GUID("77acce80-638e-4e65-8895-c1f23386863e")
interface ID3D12Device1 : ID3D12Device
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device1-createpipelinelibrary
    HRESULT CreatePipelineLibrary(const(void)* pLibraryBlob, size_t BlobLength, const(GUID)* riid, 
                                  void** ppPipelineLibrary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device1-seteventonmultiplefencecompletion
    HRESULT SetEventOnMultipleFenceCompletion(ID3D12Fence* ppFences, const(ulong)* pFenceValues, uint NumFences, 
                                              D3D12_MULTIPLE_FENCE_WAIT_FLAGS Flags, HANDLE hEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device1-setresidencypriority
    HRESULT SetResidencyPriority(uint NumObjects, ID3D12Pageable* ppObjects, 
                                 const(D3D12_RESIDENCY_PRIORITY)* pPriorities);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device2
@GUID("30baa41e-b15b-475c-a0bb-1af5c5b64328")
interface ID3D12Device2 : ID3D12Device1
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device2-createpipelinestate
    HRESULT CreatePipelineState(const(D3D12_PIPELINE_STATE_STREAM_DESC)* pDesc, const(GUID)* riid, 
                                void** ppPipelineState);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device3
@GUID("81dadc15-2bad-4392-93c5-101345c4aa98")
interface ID3D12Device3 : ID3D12Device2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device3-openexistingheapfromaddress
    HRESULT OpenExistingHeapFromAddress(const(void)* pAddress, const(GUID)* riid, void** ppvHeap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device3-openexistingheapfromfilemapping
    HRESULT OpenExistingHeapFromFileMapping(HANDLE hFileMapping, const(GUID)* riid, void** ppvHeap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device3-enqueuemakeresident
    HRESULT EnqueueMakeResident(D3D12_RESIDENCY_FLAGS Flags, uint NumObjects, ID3D12Pageable* ppObjects, 
                                ID3D12Fence pFenceToSignal, ulong FenceValueToSignal);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12protectedsession
@GUID("a1533d18-0ac1-4084-85b9-89a96116806b")
interface ID3D12ProtectedSession : ID3D12DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12protectedsession-getstatusfence
    HRESULT GetStatusFence(const(GUID)* riid, void** ppFence);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12protectedsession-getsessionstatus
    D3D12_PROTECTED_SESSION_STATUS GetSessionStatus();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12protectedresourcesession
@GUID("6cd696f4-f289-40cc-8091-5a6c0a099c3d")
interface ID3D12ProtectedResourceSession : ID3D12ProtectedSession
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12protectedresourcesession-getdesc
    D3D12_PROTECTED_RESOURCE_SESSION_DESC GetDesc();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device4
@GUID("e865df17-a9ee-46f9-a463-3098315aa2e5")
interface ID3D12Device4 : ID3D12Device3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device4-createcommandlist1
    HRESULT CreateCommandList1(uint nodeMask, D3D12_COMMAND_LIST_TYPE type, D3D12_COMMAND_LIST_FLAGS flags, 
                               const(GUID)* riid, void** ppCommandList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device4-createprotectedresourcesession
    HRESULT CreateProtectedResourceSession(const(D3D12_PROTECTED_RESOURCE_SESSION_DESC)* pDesc, const(GUID)* riid, 
                                           void** ppSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device4-createcommittedresource1
    HRESULT CreateCommittedResource1(const(D3D12_HEAP_PROPERTIES)* pHeapProperties, D3D12_HEAP_FLAGS HeapFlags, 
                                     const(D3D12_RESOURCE_DESC)* pDesc, D3D12_RESOURCE_STATES InitialResourceState, 
                                     const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                     ID3D12ProtectedResourceSession pProtectedSession, const(GUID)* riidResource, 
                                     void** ppvResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device4-createheap1
    HRESULT CreateHeap1(const(D3D12_HEAP_DESC)* pDesc, ID3D12ProtectedResourceSession pProtectedSession, 
                        const(GUID)* riid, void** ppvHeap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device4-createreservedresource1
    HRESULT CreateReservedResource1(const(D3D12_RESOURCE_DESC)* pDesc, D3D12_RESOURCE_STATES InitialState, 
                                    const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                    ID3D12ProtectedResourceSession pProtectedSession, const(GUID)* riid, 
                                    void** ppvResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device4-getresourceallocationinfo1
    D3D12_RESOURCE_ALLOCATION_INFO GetResourceAllocationInfo1(uint visibleMask, uint numResourceDescs, 
                                                              const(D3D12_RESOURCE_DESC)* pResourceDescs, 
                                                              D3D12_RESOURCE_ALLOCATION_INFO1* pResourceAllocationInfo1);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12lifetimeowner
@GUID("e667af9f-cd56-4f46-83ce-032e595d70a8")
interface ID3D12LifetimeOwner : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12lifetimeowner-lifetimestateupdated
    void LifetimeStateUpdated(D3D12_LIFETIME_STATE NewState);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("f1df64b6-57fd-49cd-8807-c0eb88b45c8f")
interface ID3D12SwapChainAssistant : IUnknown
{
    LUID    GetLUID();
    HRESULT GetSwapChainObject(const(GUID)* riid, void** ppv);
    HRESULT GetCurrentResourceAndCommandQueue(const(GUID)* riidResource, void** ppvResource, 
                                              const(GUID)* riidQueue, void** ppvQueue);
    HRESULT InsertImplicitSync();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12lifetimetracker
@GUID("3fd03d36-4eb1-424a-a582-494ecb8ba813")
interface ID3D12LifetimeTracker : ID3D12DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12lifetimetracker-destroyownedobject
    HRESULT DestroyOwnedObject(ID3D12DeviceChild pObject);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12stateobject
@GUID("47016943-fca8-4594-93ea-af258b55346d")
interface ID3D12StateObject : ID3D12Pageable
{
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12stateobjectproperties
@GUID("de5fa827-9bf9-4f26-89ff-d7f56fde3860")
interface ID3D12StateObjectProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12stateobjectproperties-getshaderidentifier
    void* GetShaderIdentifier(const(PWSTR) pExportName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12stateobjectproperties-getshaderstacksize
    ulong GetShaderStackSize(const(PWSTR) pExportName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12stateobjectproperties-getpipelinestacksize
    ulong GetPipelineStackSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12stateobjectproperties-setpipelinestacksize
    void  SetPipelineStackSize(ulong PipelineStackSizeInBytes);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("460caac7-1d24-446a-a184-ca67db494138")
interface ID3D12StateObjectProperties1 : ID3D12StateObjectProperties
{
    D3D12_PROGRAM_IDENTIFIER GetProgramIdentifier(const(PWSTR) pProgramName);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("d5e82917-f0f1-44cf-ae5e-ce222dd0b884")
interface ID3D12StateObjectProperties2 : ID3D12StateObjectProperties1
{
    HRESULT GetGlobalRootSignatureForProgram(const(PWSTR) pProgramName, const(GUID)* riid, void** ppvRootSignature);
    HRESULT GetGlobalRootSignatureForShader(const(PWSTR) pExportName, const(GUID)* riid, void** ppvRootSignature);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("065acf71-f863-4b89-82f4-02e4d5886757")
interface ID3D12WorkGraphProperties : IUnknown
{
    uint  GetNumWorkGraphs();
    PWSTR GetProgramName(uint WorkGraphIndex);
    uint  GetWorkGraphIndex(const(PWSTR) pProgramName);
    uint  GetNumNodes(uint WorkGraphIndex);
    D3D12_NODE_ID GetNodeID(uint WorkGraphIndex, uint NodeIndex);
    uint  GetNodeIndex(uint WorkGraphIndex, D3D12_NODE_ID NodeID);
    uint  GetNodeLocalRootArgumentsTableIndex(uint WorkGraphIndex, uint NodeIndex);
    uint  GetNumEntrypoints(uint WorkGraphIndex);
    D3D12_NODE_ID GetEntrypointID(uint WorkGraphIndex, uint EntrypointIndex);
    uint  GetEntrypointIndex(uint WorkGraphIndex, D3D12_NODE_ID NodeID);
    uint  GetEntrypointRecordSizeInBytes(uint WorkGraphIndex, uint EntrypointIndex);
    void  GetWorkGraphMemoryRequirements(uint WorkGraphIndex, 
                                         D3D12_WORK_GRAPH_MEMORY_REQUIREMENTS* pWorkGraphMemoryRequirements);
    uint  GetEntrypointRecordAlignmentInBytes(uint WorkGraphIndex, uint EntrypointIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device5
@GUID("8b4f173b-2fea-4b80-8f58-4307191ab95d")
interface ID3D12Device5 : ID3D12Device4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device5-createlifetimetracker
    HRESULT CreateLifetimeTracker(ID3D12LifetimeOwner pOwner, const(GUID)* riid, void** ppvTracker);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device5-removedevice
    void    RemoveDevice();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device5-enumeratemetacommands
    HRESULT EnumerateMetaCommands(uint* pNumMetaCommands, D3D12_META_COMMAND_DESC* pDescs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device5-enumeratemetacommandparameters
    HRESULT EnumerateMetaCommandParameters(const(GUID)* CommandId, D3D12_META_COMMAND_PARAMETER_STAGE Stage, 
                                           uint* pTotalStructureSizeInBytes, uint* pParameterCount, 
                                           D3D12_META_COMMAND_PARAMETER_DESC* pParameterDescs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device5-createmetacommand
    HRESULT CreateMetaCommand(const(GUID)* CommandId, uint NodeMask, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* pCreationParametersData, 
                              size_t CreationParametersDataSizeInBytes, const(GUID)* riid, void** ppMetaCommand);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device5-createstateobject
    HRESULT CreateStateObject(const(D3D12_STATE_OBJECT_DESC)* pDesc, const(GUID)* riid, void** ppStateObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device5-getraytracingaccelerationstructureprebuildinfo
    void    GetRaytracingAccelerationStructurePrebuildInfo(const(D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS)* pDesc, 
                                                           D3D12_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device5-checkdrivermatchingidentifier
    D3D12_DRIVER_MATCHING_IDENTIFIER_STATUS CheckDriverMatchingIdentifier(D3D12_SERIALIZED_DATA_TYPE SerializedDataType, 
                                                                          const(D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER)* pIdentifierToCheck);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12deviceremovedextendeddatasettings
@GUID("82bc481c-6b9b-4030-aedb-7ee3d1df1e63")
interface ID3D12DeviceRemovedExtendedDataSettings : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12deviceremovedextendeddatasettings-setautobreadcrumbsenablement
    void SetAutoBreadcrumbsEnablement(D3D12_DRED_ENABLEMENT Enablement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12deviceremovedextendeddatasettings-setpagefaultenablement
    void SetPageFaultEnablement(D3D12_DRED_ENABLEMENT Enablement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12deviceremovedextendeddatasettings-setwatsondumpenablement
    void SetWatsonDumpEnablement(D3D12_DRED_ENABLEMENT Enablement);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("dbd5ae51-3317-4f0a-adf9-1d7cedcaae0b")
interface ID3D12DeviceRemovedExtendedDataSettings1 : ID3D12DeviceRemovedExtendedDataSettings
{
    void SetBreadcrumbContextEnablement(D3D12_DRED_ENABLEMENT Enablement);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("61552388-01ab-4008-a436-83db189566ea")
interface ID3D12DeviceRemovedExtendedDataSettings2 : ID3D12DeviceRemovedExtendedDataSettings1
{
    void UseMarkersOnlyAutoBreadcrumbs(BOOL MarkersOnly);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12deviceremovedextendeddata
@GUID("98931d33-5ae8-4791-aa3c-1a73a2934e71")
interface ID3D12DeviceRemovedExtendedData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12deviceremovedextendeddata-getautobreadcrumbsoutput
    HRESULT GetAutoBreadcrumbsOutput(D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT* pOutput);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12deviceremovedextendeddata-getpagefaultallocationoutput
    HRESULT GetPageFaultAllocationOutput(D3D12_DRED_PAGE_FAULT_OUTPUT* pOutput);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("9727a022-cf1d-4dda-9eba-effa653fc506")
interface ID3D12DeviceRemovedExtendedData1 : ID3D12DeviceRemovedExtendedData
{
    HRESULT GetAutoBreadcrumbsOutput1(D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1* pOutput);
    HRESULT GetPageFaultAllocationOutput1(D3D12_DRED_PAGE_FAULT_OUTPUT1* pOutput);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("67fc5816-e4ca-4915-bf18-42541272da54")
interface ID3D12DeviceRemovedExtendedData2 : ID3D12DeviceRemovedExtendedData1
{
    HRESULT GetPageFaultAllocationOutput2(D3D12_DRED_PAGE_FAULT_OUTPUT2* pOutput);
    D3D12_DRED_DEVICE_STATE GetDeviceState();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device6
@GUID("c70b221b-40e4-4a17-89af-025a0727a6dc")
interface ID3D12Device6 : ID3D12Device5
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device6-setbackgroundprocessingmode
    HRESULT SetBackgroundProcessingMode(D3D12_BACKGROUND_PROCESSING_MODE Mode, 
                                        D3D12_MEASUREMENTS_ACTION MeasurementsAction, 
                                        HANDLE hEventToSignalUponCompletion, BOOL* pbFurtherMeasurementsDesired);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12protectedresourcesession1
@GUID("d6f12dd6-76fb-406e-8961-4296eefc0409")
interface ID3D12ProtectedResourceSession1 : ID3D12ProtectedResourceSession
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12protectedresourcesession1-getdesc1
    D3D12_PROTECTED_RESOURCE_SESSION_DESC1 GetDesc1();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device7
@GUID("5c014b53-68a1-4b9b-8bd1-dd6046b9358b")
interface ID3D12Device7 : ID3D12Device6
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device7-addtostateobject
    HRESULT AddToStateObject(const(D3D12_STATE_OBJECT_DESC)* pAddition, ID3D12StateObject pStateObjectToGrowFrom, 
                             const(GUID)* riid, void** ppNewStateObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device7-createprotectedresourcesession1
    HRESULT CreateProtectedResourceSession1(const(D3D12_PROTECTED_RESOURCE_SESSION_DESC1)* pDesc, 
                                            const(GUID)* riid, void** ppSession);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device8
@GUID("9218e6bb-f944-4f7e-a75c-b1b2c7b701f3")
interface ID3D12Device8 : ID3D12Device7
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device8-getresourceallocationinfo2
    D3D12_RESOURCE_ALLOCATION_INFO GetResourceAllocationInfo2(uint visibleMask, uint numResourceDescs, 
                                                              const(D3D12_RESOURCE_DESC1)* pResourceDescs, 
                                                              D3D12_RESOURCE_ALLOCATION_INFO1* pResourceAllocationInfo1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device8-createcommittedresource2
    HRESULT CreateCommittedResource2(const(D3D12_HEAP_PROPERTIES)* pHeapProperties, D3D12_HEAP_FLAGS HeapFlags, 
                                     const(D3D12_RESOURCE_DESC1)* pDesc, D3D12_RESOURCE_STATES InitialResourceState, 
                                     const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                     ID3D12ProtectedResourceSession pProtectedSession, const(GUID)* riidResource, 
                                     void** ppvResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device8-createplacedresource1
    HRESULT CreatePlacedResource1(ID3D12Heap pHeap, ulong HeapOffset, const(D3D12_RESOURCE_DESC1)* pDesc, 
                                  D3D12_RESOURCE_STATES InitialState, const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                  const(GUID)* riid, void** ppvResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device8-createsamplerfeedbackunorderedaccessview
    void    CreateSamplerFeedbackUnorderedAccessView(ID3D12Resource pTargetedResource, 
                                                     ID3D12Resource pFeedbackResource, 
                                                     D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device8-getcopyablefootprints1
    void    GetCopyableFootprints1(const(D3D12_RESOURCE_DESC1)* pResourceDesc, uint FirstSubresource, 
                                   uint NumSubresources, ulong BaseOffset, 
                                   D3D12_PLACED_SUBRESOURCE_FOOTPRINT* pLayouts, uint* pNumRows, 
                                   ulong* pRowSizeInBytes, ulong* pTotalBytes);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("9d5e227a-4430-4161-88b3-3eca6bb16e19")
interface ID3D12Resource1 : ID3D12Resource
{
    HRESULT GetProtectedResourceSession(const(GUID)* riid, void** ppProtectedSession);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("be36ec3b-ea85-4aeb-a45a-e9d76404a495")
interface ID3D12Resource2 : ID3D12Resource1
{
    D3D12_RESOURCE_DESC1 GetDesc1();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("572f7389-2168-49e3-9693-d6df5871bf6d")
interface ID3D12Heap1 : ID3D12Heap
{
    HRESULT GetProtectedResourceSession(const(GUID)* riid, void** ppProtectedSession);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12graphicscommandlist3
@GUID("6fda83a7-b84c-4e38-9ac8-c7bd22016b3d")
interface ID3D12GraphicsCommandList3 : ID3D12GraphicsCommandList2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist3-setprotectedresourcesession
    void SetProtectedResourceSession(ID3D12ProtectedResourceSession pProtectedResourceSession);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12metacommand
@GUID("dbb84c27-36ce-4fc9-b801-f048c46ac570")
interface ID3D12MetaCommand : ID3D12Pageable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12metacommand-getrequiredparameterresourcesize
    ulong GetRequiredParameterResourceSize(D3D12_META_COMMAND_PARAMETER_STAGE Stage, uint ParameterIndex);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12graphicscommandlist4
@GUID("8754318e-d3a9-4541-98cf-645b50dc4874")
interface ID3D12GraphicsCommandList4 : ID3D12GraphicsCommandList3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist4-beginrenderpass
    void BeginRenderPass(uint NumRenderTargets, const(D3D12_RENDER_PASS_RENDER_TARGET_DESC)* pRenderTargets, 
                         const(D3D12_RENDER_PASS_DEPTH_STENCIL_DESC)* pDepthStencil, D3D12_RENDER_PASS_FLAGS Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist4-endrenderpass
    void EndRenderPass();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist4-initializemetacommand
    void InitializeMetaCommand(ID3D12MetaCommand pMetaCommand, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pInitializationParametersData, 
                               size_t InitializationParametersDataSizeInBytes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist4-executemetacommand
    void ExecuteMetaCommand(ID3D12MetaCommand pMetaCommand, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pExecutionParametersData, 
                            size_t ExecutionParametersDataSizeInBytes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist4-buildraytracingaccelerationstructure
    void BuildRaytracingAccelerationStructure(const(D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC)* pDesc, 
                                              uint NumPostbuildInfoDescs, 
                                              const(D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC)* pPostbuildInfoDescs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist4-emitraytracingaccelerationstructurepostbuildinfo
    void EmitRaytracingAccelerationStructurePostbuildInfo(const(D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC)* pDesc, 
                                                          uint NumSourceAccelerationStructures, 
                                                          const(ulong)* pSourceAccelerationStructureData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist4-copyraytracingaccelerationstructure
    void CopyRaytracingAccelerationStructure(ulong DestAccelerationStructureData, 
                                             ulong SourceAccelerationStructureData, 
                                             D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE Mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist4-setpipelinestate1
    void SetPipelineState1(ID3D12StateObject pStateObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist4-dispatchrays
    void DispatchRays(const(D3D12_DISPATCH_RAYS_DESC)* pDesc);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12shadercachesession
@GUID("28e2495d-0f64-4ae4-a6ec-129255dc49a8")
interface ID3D12ShaderCacheSession : ID3D12DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12shadercachesession-findvalue
    HRESULT FindValue(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pKey, 
                      uint KeySize, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pValue, 
                      uint* pValueSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12shadercachesession-storevalue
    HRESULT StoreValue(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pKey, 
                       uint KeySize, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* pValue, 
                       uint ValueSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12shadercachesession-setdeleteondestroy
    void    SetDeleteOnDestroy();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12shadercachesession-getdesc
    D3D12_SHADER_CACHE_SESSION_DESC GetDesc();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device9
@GUID("4c80e962-f032-4f60-bc9e-ebc2cfa1d83c")
interface ID3D12Device9 : ID3D12Device8
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device9-createshadercachesession
    HRESULT CreateShaderCacheSession(const(D3D12_SHADER_CACHE_SESSION_DESC)* pDesc, const(GUID)* riid, 
                                     void** ppvSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device9-shadercachecontrol
    HRESULT ShaderCacheControl(D3D12_SHADER_CACHE_KIND_FLAGS Kinds, D3D12_SHADER_CACHE_CONTROL_FLAGS Control);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device9-createcommandqueue1
    HRESULT CreateCommandQueue1(const(D3D12_COMMAND_QUEUE_DESC)* pDesc, const(GUID)* CreatorID, const(GUID)* riid, 
                                void** ppCommandQueue);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12device10
@GUID("517f8718-aa66-49f9-b02b-a7ab89c06031")
interface ID3D12Device10 : ID3D12Device9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device10-createcommittedresource3
    HRESULT CreateCommittedResource3(const(D3D12_HEAP_PROPERTIES)* pHeapProperties, D3D12_HEAP_FLAGS HeapFlags, 
                                     const(D3D12_RESOURCE_DESC1)* pDesc, D3D12_BARRIER_LAYOUT InitialLayout, 
                                     const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                     ID3D12ProtectedResourceSession pProtectedSession, uint NumCastableFormats, 
                                     const(DXGI_FORMAT)* pCastableFormats, const(GUID)* riidResource, 
                                     void** ppvResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device10-createplacedresource2
    HRESULT CreatePlacedResource2(ID3D12Heap pHeap, ulong HeapOffset, const(D3D12_RESOURCE_DESC1)* pDesc, 
                                  D3D12_BARRIER_LAYOUT InitialLayout, const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                  uint NumCastableFormats, const(DXGI_FORMAT)* pCastableFormats, const(GUID)* riid, 
                                  void** ppvResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12device10-createreservedresource2
    HRESULT CreateReservedResource2(const(D3D12_RESOURCE_DESC)* pDesc, D3D12_BARRIER_LAYOUT InitialLayout, 
                                    const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                    ID3D12ProtectedResourceSession pProtectedSession, uint NumCastableFormats, 
                                    const(DXGI_FORMAT)* pCastableFormats, const(GUID)* riid, void** ppvResource);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("5405c344-d457-444e-b4dd-2366e45aee39")
interface ID3D12Device11 : ID3D12Device10
{
    void CreateSampler2(const(D3D12_SAMPLER_DESC2)* pDesc, D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("5af5c532-4c91-4cd0-b541-15a405395fc5")
interface ID3D12Device12 : ID3D12Device11
{
    D3D12_RESOURCE_ALLOCATION_INFO GetResourceAllocationInfo3(uint visibleMask, uint numResourceDescs, 
                                                              const(D3D12_RESOURCE_DESC1)* pResourceDescs, 
                                                              const(uint)* pNumCastableFormats, 
                                                              const(DXGI_FORMAT)** ppCastableFormats, 
                                                              D3D12_RESOURCE_ALLOCATION_INFO1* pResourceAllocationInfo1);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("14eecffc-4df8-40f7-a118-5c816f45695e")
interface ID3D12Device13 : ID3D12Device12
{
    HRESULT OpenExistingHeapFromAddress1(const(void)* pAddress, size_t size, const(GUID)* riid, void** ppvHeap);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("5f6e592d-d895-44c2-8e4a-88ad4926d323")
interface ID3D12Device14 : ID3D12Device13
{
    HRESULT CreateRootSignatureFromSubobjectInLibrary(uint nodeMask, const(void)* pLibraryBlob, 
                                                      size_t blobLengthInBytes, const(PWSTR) subobjectName, 
                                                      const(GUID)* riid, void** ppvRootSignature);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("76cff76f-1e9b-4450-8cdc-34f1af788e5b")
interface ID3D12Device15 : ID3D12Device14
{
    HRESULT RegisterTrimNotificationCallback(D3D12_REGISTER_TRIM_NOTIFICATION* pData);
    HRESULT UnregisterTrimNotificationCallback(uint CallbackCookie);
    HRESULT TryCreateShaderResourceView(ID3D12Resource pResource, const(D3D12_SHADER_RESOURCE_VIEW_DESC)* pDesc, 
                                        D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    HRESULT TryCreateUnorderedAccessView(ID3D12Resource pResource, ID3D12Resource pCounterResource, 
                                         const(D3D12_UNORDERED_ACCESS_VIEW_DESC)* pDesc, 
                                         D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    HRESULT TryCreateConstantBufferView(const(D3D12_CONSTANT_BUFFER_VIEW_DESC)* pDesc, 
                                        D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    HRESULT TryCreateSampler2(const(D3D12_SAMPLER_DESC2)* pDesc, D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    HRESULT TryCreateRenderTargetView(ID3D12Resource pResource, const(D3D12_RENDER_TARGET_VIEW_DESC)* pDesc, 
                                      D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    HRESULT TryCreateDepthStencilView(ID3D12Resource pResource, const(D3D12_DEPTH_STENCIL_VIEW_DESC)* pDesc, 
                                      D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    HRESULT TryCreateSamplerFeedbackUnorderedAccessView(ID3D12Resource pTargetedResource, 
                                                        ID3D12Resource pFeedbackResource, 
                                                        D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    HRESULT CreateQueryHeap1(const(D3D12_QUERY_HEAP_DESC)* pDesc, D3D12_QUERY_HEAP_FLAGS Flags, const(GUID)* riid, 
                             void** ppvHeap);
    HRESULT ResolveQueryData(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint StartIndex, uint NumQueries, 
                             void* pResolvedQueryData);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("c56060b7-b5fc-4135-98e0-a1e9997eace0")
interface ID3D12StateObjectDatabase : IUnknown
{
    HRESULT SetApplicationDesc(const(D3D12_APPLICATION_DESC)* pApplicationDesc);
    HRESULT GetApplicationDesc(D3D12ApplicationDescFunc CallbackFunc, void* pContext);
    HRESULT StorePipelineStateDesc(const(void)* pKey, uint KeySize, uint Version, 
                                   const(D3D12_PIPELINE_STATE_STREAM_DESC)* pDesc);
    HRESULT FindPipelineStateDesc(const(void)* pKey, uint KeySize, D3D12PipelineStateFunc CallbackFunc, 
                                  void* pContext);
    HRESULT StoreStateObjectDesc(const(void)* pKey, uint KeySize, uint Version, 
                                 const(D3D12_STATE_OBJECT_DESC)* pDesc, const(void)* pStateObjectToGrowFromKey, 
                                 uint StateObjectToGrowFromKeySize);
    HRESULT FindStateObjectDesc(const(void)* pKey, uint KeySize, D3D12StateObjectFunc CallbackFunc, void* pContext);
    HRESULT FindObjectVersion(const(void)* pKey, uint KeySize, uint* pVersion);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12virtualizationguestdevice
@GUID("bc66d368-7373-4943-8757-fc87dc79e476")
interface ID3D12VirtualizationGuestDevice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12virtualizationguestdevice-sharewithhost
    HRESULT ShareWithHost(ID3D12DeviceChild pObject, HANDLE* pHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12virtualizationguestdevice-createfencefd
    HRESULT CreateFenceFd(ID3D12Fence pFence, ulong FenceValue, int* pFenceFd);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12tools
@GUID("7071e1f0-e84b-4b33-974f-12fa49de65c5")
interface ID3D12Tools : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12tools-enableshaderinstrumentation
    void EnableShaderInstrumentation(BOOL bEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12tools-shaderinstrumentationenabled
    BOOL ShaderInstrumentationEnabled();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("e4fbc019-dd3c-43e1-8f32-7f649575f0a0")
interface ID3D12Tools1 : ID3D12Tools
{
    HRESULT ReserveGPUVARangesAtCreate(D3D12_GPU_VIRTUAL_ADDRESS_RANGE* pRanges, uint uiNumRanges);
    void    ClearReservedGPUVARangesList();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("01d393c5-c9b0-42a1-958c-c26b02d4d097")
interface ID3D12Tools2 : ID3D12Tools1
{
    HRESULT SetApplicationSpecificDriverState(IUnknown pAdapter, ID3DBlob pBlob);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("c706c811-3663-4bf1-91b9-1e8a7c114ab9")
interface ID3D12RuntimeValidationControl : IUnknown
{
    void DisableFailuresFromStricterValidationInAppLocalRuntime(BOOL bDisable);
    BOOL FailuresFromStricterValidationInAppLocalRuntimeDisabled();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("8f1359db-d8d1-42f9-b5cf-79f4cbad0d3d")
interface ID3D12PageableTools : IUnknown
{
    HRESULT GetAllocation(D3D12_GPU_VIRTUAL_ADDRESS_RANGE* pAllocation);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("2ea68e9c-19c3-4e47-a109-6cdadff0aca9")
interface ID3D12DeviceTools : IUnknown
{
    void SetNextAllocationAddress(ulong nextAllocationVirtualAddress);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("e30e9fc7-e641-4d6e-8a81-9dd9206ec47a")
interface ID3D12DeviceTools1 : ID3D12DeviceTools
{
    HRESULT GetApplicationSpecificDriverState(ID3DBlob* ppBlob);
    D3D12_APPLICATION_SPECIFIC_DRIVER_BLOB_STATUS GetApplicationSpecificDriverBlobStatus();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debug
@GUID("344488b7-6846-474b-b989-f027448245e0")
interface ID3D12Debug : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug-enabledebuglayer
    void EnableDebugLayer();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debug1
@GUID("affaa4ca-63fe-4d8e-b8ad-159000af4304")
interface ID3D12Debug1 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug1-enabledebuglayer
    void EnableDebugLayer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug1-setenablegpubasedvalidation
    void SetEnableGPUBasedValidation(BOOL Enable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug1-setenablesynchronizedcommandqueuevalidation
    void SetEnableSynchronizedCommandQueueValidation(BOOL Enable);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debug2
@GUID("93a665c4-a3b2-4e5d-b692-a26ae14e3374")
interface ID3D12Debug2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug2-setgpubasedvalidationflags
    void SetGPUBasedValidationFlags(D3D12_GPU_BASED_VALIDATION_FLAGS Flags);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debug3
@GUID("5cf4e58f-f671-4ff1-a542-3686e3d153d1")
interface ID3D12Debug3 : ID3D12Debug
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug3-setenablegpubasedvalidation
    void SetEnableGPUBasedValidation(BOOL Enable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug3-setenablesynchronizedcommandqueuevalidation
    void SetEnableSynchronizedCommandQueueValidation(BOOL Enable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug3-setgpubasedvalidationflags
    void SetGPUBasedValidationFlags(D3D12_GPU_BASED_VALIDATION_FLAGS Flags);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debug4
@GUID("014b816e-9ec5-4a2f-a845-ffbe441ce13a")
interface ID3D12Debug4 : ID3D12Debug3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug4-disabledebuglayer
    void DisableDebugLayer();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debug5
@GUID("548d6b12-09fa-40e0-9069-5dcd589a52c9")
interface ID3D12Debug5 : ID3D12Debug4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug5-setenableautoname
    void SetEnableAutoName(BOOL Enable);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debug6
@GUID("82a816d6-5d01-4157-97d0-4975463fd1ed")
interface ID3D12Debug6 : ID3D12Debug5
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debug6-setforcelegacybarriervalidation
    void SetForceLegacyBarrierValidation(BOOL Enable);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debugdevice1
@GUID("a9b71770-d099-4a65-a698-3dee10020f88")
interface ID3D12DebugDevice1 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugdevice1-setdebugparameter
    HRESULT SetDebugParameter(D3D12_DEBUG_DEVICE_PARAMETER_TYPE Type, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pData, 
                              uint DataSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugdevice1-getdebugparameter
    HRESULT GetDebugParameter(D3D12_DEBUG_DEVICE_PARAMETER_TYPE Type, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pData, 
                              uint DataSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugdevice1-reportlivedeviceobjects
    HRESULT ReportLiveDeviceObjects(D3D12_RLDO_FLAGS Flags);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debugdevice
@GUID("3febd6dd-4973-4787-8194-e45f9e28923e")
interface ID3D12DebugDevice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugdevice-setfeaturemask
    HRESULT SetFeatureMask(D3D12_DEBUG_FEATURE Mask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugdevice-getfeaturemask
    D3D12_DEBUG_FEATURE GetFeatureMask();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugdevice-reportlivedeviceobjects
    HRESULT ReportLiveDeviceObjects(D3D12_RLDO_FLAGS Flags);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("60eccbc1-378d-4df1-894c-f8ac5ce4d7dd")
interface ID3D12DebugDevice2 : ID3D12DebugDevice
{
    HRESULT SetDebugParameter(D3D12_DEBUG_DEVICE_PARAMETER_TYPE Type, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pData, 
                              uint DataSize);
    HRESULT GetDebugParameter(D3D12_DEBUG_DEVICE_PARAMETER_TYPE Type, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pData, 
                              uint DataSize);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debugcommandqueue
@GUID("09e0bf36-54ac-484f-8847-4baeeab6053a")
interface ID3D12DebugCommandQueue : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugcommandqueue-assertresourcestate
    BOOL AssertResourceState(ID3D12Resource pResource, uint Subresource, uint State);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("16be35a2-bfd6-49f2-bcae-eaae4aff862d")
interface ID3D12DebugCommandQueue1 : ID3D12DebugCommandQueue
{
    void AssertResourceAccess(ID3D12Resource pResource, uint Subresource, D3D12_BARRIER_ACCESS Access);
    void AssertTextureLayout(ID3D12Resource pResource, uint Subresource, D3D12_BARRIER_LAYOUT Layout);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debugcommandlist1
@GUID("102ca951-311b-4b01-b11f-ecb83e061b37")
interface ID3D12DebugCommandList1 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugcommandlist1-assertresourcestate
    BOOL    AssertResourceState(ID3D12Resource pResource, uint Subresource, uint State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugcommandlist1-setdebugparameter
    HRESULT SetDebugParameter(D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE Type, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pData, 
                              uint DataSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugcommandlist1-getdebugparameter
    HRESULT GetDebugParameter(D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE Type, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pData, 
                              uint DataSize);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12debugcommandlist
@GUID("09e0bf36-54ac-484f-8847-4baeeab6053f")
interface ID3D12DebugCommandList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugcommandlist-assertresourcestate
    BOOL    AssertResourceState(ID3D12Resource pResource, uint Subresource, uint State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugcommandlist-setfeaturemask
    HRESULT SetFeatureMask(D3D12_DEBUG_FEATURE Mask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12debugcommandlist-getfeaturemask
    D3D12_DEBUG_FEATURE GetFeatureMask();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("aeb575cf-4e06-48be-ba3b-c450fc96652e")
interface ID3D12DebugCommandList2 : ID3D12DebugCommandList
{
    HRESULT SetDebugParameter(D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE Type, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pData, 
                              uint DataSize);
    HRESULT GetDebugParameter(D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE Type, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pData, 
                              uint DataSize);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("197d5e15-4d37-4d34-af78-724cd70fdb1f")
interface ID3D12DebugCommandList3 : ID3D12DebugCommandList2
{
    void AssertResourceAccess(ID3D12Resource pResource, uint Subresource, D3D12_BARRIER_ACCESS Access);
    void AssertTextureLayout(ID3D12Resource pResource, uint Subresource, D3D12_BARRIER_LAYOUT Layout);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12sharingcontract
@GUID("0adf7d52-929c-4e61-addb-ffed30de66ef")
interface ID3D12SharingContract : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12sharingcontract-present
    void Present(ID3D12Resource pResource, uint Subresource, HWND window);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12sharingcontract-sharedfencesignal
    void SharedFenceSignal(ID3D12Fence pFence, ulong FenceValue);
    void BeginCapturableWork(const(GUID)* guid);
    void EndCapturableWork(const(GUID)* guid);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("86ca3b85-49ad-4b6e-aed5-eddb18540f41")
interface ID3D12ManualWriteTrackingResource : IUnknown
{
    void TrackWrite(uint Subresource, const(D3D12_RANGE)* pWrittenRange);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nn-d3d12sdklayers-id3d12infoqueue
@GUID("0742a90b-c387-483f-b946-30a7e4e61458")
interface ID3D12InfoQueue : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-setmessagecountlimit
    HRESULT SetMessageCountLimit(ulong MessageCountLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-clearstoredmessages
    void    ClearStoredMessages();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getmessage
    HRESULT GetMessage(ulong MessageIndex, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/D3D12_MESSAGE* pMessage, 
                       size_t* pMessageByteLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getnummessagesallowedbystoragefilter
    ulong   GetNumMessagesAllowedByStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getnummessagesdeniedbystoragefilter
    ulong   GetNumMessagesDeniedByStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getnumstoredmessages
    ulong   GetNumStoredMessages();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getnumstoredmessagesallowedbyretrievalfilter
    ulong   GetNumStoredMessagesAllowedByRetrievalFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getnummessagesdiscardedbymessagecountlimit
    ulong   GetNumMessagesDiscardedByMessageCountLimit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getmessagecountlimit
    ulong   GetMessageCountLimit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-addstoragefilterentries
    HRESULT AddStorageFilterEntries(D3D12_INFO_QUEUE_FILTER* pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getstoragefilter
    HRESULT GetStorageFilter(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/D3D12_INFO_QUEUE_FILTER* pFilter, 
                             size_t* pFilterByteLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-clearstoragefilter
    void    ClearStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-pushemptystoragefilter
    HRESULT PushEmptyStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-pushcopyofstoragefilter
    HRESULT PushCopyOfStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-pushstoragefilter
    HRESULT PushStorageFilter(D3D12_INFO_QUEUE_FILTER* pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-popstoragefilter
    void    PopStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getstoragefilterstacksize
    uint    GetStorageFilterStackSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-addretrievalfilterentries
    HRESULT AddRetrievalFilterEntries(D3D12_INFO_QUEUE_FILTER* pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getretrievalfilter
    HRESULT GetRetrievalFilter(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/D3D12_INFO_QUEUE_FILTER* pFilter, 
                               size_t* pFilterByteLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-clearretrievalfilter
    void    ClearRetrievalFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-pushemptyretrievalfilter
    HRESULT PushEmptyRetrievalFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-pushcopyofretrievalfilter
    HRESULT PushCopyOfRetrievalFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-pushretrievalfilter
    HRESULT PushRetrievalFilter(D3D12_INFO_QUEUE_FILTER* pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-popretrievalfilter
    void    PopRetrievalFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getretrievalfilterstacksize
    uint    GetRetrievalFilterStackSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-addmessage
    HRESULT AddMessage(D3D12_MESSAGE_CATEGORY Category, D3D12_MESSAGE_SEVERITY Severity, D3D12_MESSAGE_ID ID, 
                       const(PSTR) pDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-addapplicationmessage
    HRESULT AddApplicationMessage(D3D12_MESSAGE_SEVERITY Severity, const(PSTR) pDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-setbreakoncategory
    HRESULT SetBreakOnCategory(D3D12_MESSAGE_CATEGORY Category, BOOL bEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-setbreakonseverity
    HRESULT SetBreakOnSeverity(D3D12_MESSAGE_SEVERITY Severity, BOOL bEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-setbreakonid
    HRESULT SetBreakOnID(D3D12_MESSAGE_ID ID, BOOL bEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getbreakoncategory
    BOOL    GetBreakOnCategory(D3D12_MESSAGE_CATEGORY Category);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getbreakonseverity
    BOOL    GetBreakOnSeverity(D3D12_MESSAGE_SEVERITY Severity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getbreakonid
    BOOL    GetBreakOnID(D3D12_MESSAGE_ID ID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-setmutedebugoutput
    void    SetMuteDebugOutput(BOOL bMute);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12sdklayers/nf-d3d12sdklayers-id3d12infoqueue-getmutedebugoutput
    BOOL    GetMuteDebugOutput();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("2852dd88-b484-4c0c-b6b1-67168500e600")
interface ID3D12InfoQueue1 : ID3D12InfoQueue
{
    HRESULT RegisterMessageCallback(D3D12MessageFunc CallbackFunc, 
                                    D3D12_MESSAGE_CALLBACK_FLAGS CallbackFilterFlags, void* pContext, 
                                    uint* pCallbackCookie);
    HRESULT UnregisterMessageCallback(uint CallbackCookie);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12sdkconfiguration
@GUID("e9eb5314-33aa-42b2-a718-d77f58b1f1c7")
interface ID3D12SDKConfiguration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12sdkconfiguration-setsdkversion
    HRESULT SetSDKVersion(uint SDKVersion, const(PSTR) SDKPath);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("8aaf9303-ad25-48b9-9a57-d9c37e009d9f")
interface ID3D12SDKConfiguration1 : ID3D12SDKConfiguration
{
    HRESULT CreateDeviceFactory(uint SDKVersion, const(PSTR) SDKPath, const(GUID)* riid, void** ppvFactory);
    void    FreeUnusedSDKs();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("61f307d3-d34e-4e7c-8374-3ba4de23cccb")
interface ID3D12DeviceFactory : IUnknown
{
    HRESULT InitializeFromGlobalState();
    HRESULT ApplyToGlobalState();
    HRESULT SetFlags(D3D12_DEVICE_FACTORY_FLAGS flags);
    D3D12_DEVICE_FACTORY_FLAGS GetFlags();
    HRESULT GetConfigurationInterface(const(GUID)* clsid, const(GUID)* iid, void** ppv);
    HRESULT EnableExperimentalFeatures(uint NumFeatures, const(GUID)* pIIDs, void* pConfigurationStructs, 
                                       uint* pConfigurationStructSizes);
    HRESULT CreateDevice(IUnknown adapter, D3D_FEATURE_LEVEL FeatureLevel, const(GUID)* riid, void** ppvDevice);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("78dbf87b-f766-422b-a61c-c8c446bdb9ad")
interface ID3D12DeviceConfiguration : IUnknown
{
    D3D12_DEVICE_CONFIGURATION_DESC GetDesc();
    HRESULT GetEnabledExperimentalFeatures(GUID* pGuids, uint NumGuids);
    HRESULT SerializeVersionedRootSignature(const(D3D12_VERSIONED_ROOT_SIGNATURE_DESC)* pDesc, ID3DBlob* ppResult, 
                                            ID3DBlob* ppError);
    HRESULT CreateVersionedRootSignatureDeserializer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pBlob, 
                                                     size_t Size, const(GUID)* riid, void** ppvDeserializer);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("ed342442-6343-4e16-bb82-a3a577874e56")
interface ID3D12DeviceConfiguration1 : ID3D12DeviceConfiguration
{
    HRESULT CreateVersionedRootSignatureDeserializerFromSubobjectInLibrary(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pLibraryBlob, 
                                                                           size_t Size, 
                                                                           const(PWSTR) RootSignatureSubobjectName, 
                                                                           const(GUID)* riid, void** ppvDeserializer);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("f5b066f0-648a-4611-bd41-27fd0948b9eb")
interface ID3D12StateObjectDatabaseFactory : IUnknown
{
    HRESULT CreateStateObjectDatabaseFromFile(const(PWSTR) pDatabaseFile, D3D12_STATE_OBJECT_DATABASE_FLAGS flags, 
                                              const(GUID)* riid, void** ppvStateObjectDatabase);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("82dc6c85-727b-4a8d-9169-db6ce3e975a0")
interface ID3D12ApplicationIdentity : IUnknown
{
    HRESULT SetApplicationIdentity(const(D3D12_APPLICATION_DESC)* pDesc, const(GUID)* AppId);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12graphicscommandlist5
@GUID("55050859-4024-474c-87f5-6472eaee44ea")
interface ID3D12GraphicsCommandList5 : ID3D12GraphicsCommandList4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist5-rssetshadingrate
    void RSSetShadingRate(D3D12_SHADING_RATE baseShadingRate, const(D3D12_SHADING_RATE_COMBINER)* combiners);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist5-rssetshadingrateimage
    void RSSetShadingRateImage(ID3D12Resource shadingRateImage);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("c3827890-e548-4cfa-96cf-5689a9370f80")
interface ID3D12GraphicsCommandList6 : ID3D12GraphicsCommandList5
{
    void DispatchMesh(uint ThreadGroupCountX, uint ThreadGroupCountY, uint ThreadGroupCountZ);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nn-d3d12-id3d12graphicscommandlist7
@GUID("dd171223-8b61-4769-90e3-160ccde4e2c1")
interface ID3D12GraphicsCommandList7 : ID3D12GraphicsCommandList6
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist7-barrier
    void Barrier(uint NumBarrierGroups, const(D3D12_BARRIER_GROUP)* pBarrierGroups);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("ee936ef9-599d-4d28-938e-23c4ad05ce51")
interface ID3D12GraphicsCommandList8 : ID3D12GraphicsCommandList7
{
    void OMSetFrontAndBackStencilRef(uint FrontStencilRef, uint BackStencilRef);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("34ed2808-ffe6-4c2b-b11a-cabd2b0c59e1")
interface ID3D12GraphicsCommandList9 : ID3D12GraphicsCommandList8
{
    void RSSetDepthBias(float DepthBias, float DepthBiasClamp, float SlopeScaledDepthBias);
    void IASetIndexBufferStripCutValue(D3D12_INDEX_BUFFER_STRIP_CUT_VALUE IBStripCutValue);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("7013c015-d161-4b63-a08c-238552dd8acc")
interface ID3D12GraphicsCommandList10 : ID3D12GraphicsCommandList9
{
    void SetProgram(const(D3D12_SET_PROGRAM_DESC)* pDesc);
    void DispatchGraph(const(D3D12_DISPATCH_GRAPH_DESC)* pDesc);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("f343d1a0-afe3-439f-b13d-cd87a43b70ca")
interface ID3D12DSRDeviceFactory : IUnknown
{
    HRESULT CreateDSRDevice(ID3D12Device pD3D12Device, uint NodeMask, const(GUID)* riid, void** ppvDSRDevice);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("597985ab-9b75-4dbb-be23-0761195bebee")
interface ID3D12GBVDiagnostics : IUnknown
{
    HRESULT GetGBVEntireSubresourceStatesData(ID3D12Resource pResource, 
                                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/int* pData, 
                                              uint DataSize);
    HRESULT GetGBVSubresourceState(ID3D12Resource pResource, uint Subresource, int* pData);
    HRESULT GetGBVResourceUniformState(ID3D12Resource pResource, int* pData);
    HRESULT GetGBVResourceInfo(ID3D12Resource pResource, D3D12_RESOURCE_DESC* pResourceDesc, uint* pResourceHash, 
                               uint* pSubresourceStatesByteOffset);
    void    GBVReserved0();
    void    GBVReserved1();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("3d5ca1a8-a39e-4619-95e0-f9b0a40340f5")
interface ID3D12DeviceStatistics : IUnknown
{
    HRESULT GetStateObjectStatistics(D3D12_STATE_OBJECT_STATISTICS* pStatistics);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nn-d3d12shader-id3d12shaderreflectiontype
@GUID("e913c351-783d-48ca-a1d1-4f306284ad56")
interface ID3D12ShaderReflectionType
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-getdesc
    HRESULT GetDesc(D3D12_SHADER_TYPE_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-getmembertypebyindex
    ID3D12ShaderReflectionType GetMemberTypeByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-getmembertypebyname
    ID3D12ShaderReflectionType GetMemberTypeByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-getmembertypename
    PSTR    GetMemberTypeName(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-isequal
    HRESULT IsEqual(ID3D12ShaderReflectionType pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-getsubtype
    ID3D12ShaderReflectionType GetSubType();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-getbaseclass
    ID3D12ShaderReflectionType GetBaseClass();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-getnuminterfaces
    uint    GetNumInterfaces();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-getinterfacebyindex
    ID3D12ShaderReflectionType GetInterfaceByIndex(uint uIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-isoftype
    HRESULT IsOfType(ID3D12ShaderReflectionType pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectiontype-implementsinterface
    HRESULT ImplementsInterface(ID3D12ShaderReflectionType pBase);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nn-d3d12shader-id3d12shaderreflectionvariable
@GUID("8337a8a6-a216-444a-b2f4-314733a73aea")
interface ID3D12ShaderReflectionVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectionvariable-getdesc
    HRESULT GetDesc(D3D12_SHADER_VARIABLE_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectionvariable-gettype
    ID3D12ShaderReflectionType GetType();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectionvariable-getbuffer
    ID3D12ShaderReflectionConstantBuffer GetBuffer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectionvariable-getinterfaceslot
    uint    GetInterfaceSlot(uint uArrayIndex);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nn-d3d12shader-id3d12shaderreflectionconstantbuffer
@GUID("c59598b4-48b3-4869-b9b1-b1618b14a8b7")
interface ID3D12ShaderReflectionConstantBuffer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectionconstantbuffer-getdesc
    HRESULT GetDesc(D3D12_SHADER_BUFFER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectionconstantbuffer-getvariablebyindex
    ID3D12ShaderReflectionVariable GetVariableByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflectionconstantbuffer-getvariablebyname
    ID3D12ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nn-d3d12shader-id3d12shaderreflection
@GUID("5a58797d-a72c-478d-8ba2-efc6b0efe88e")
interface ID3D12ShaderReflection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getdesc
    HRESULT GetDesc(D3D12_SHADER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getconstantbufferbyindex
    ID3D12ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getconstantbufferbyname
    ID3D12ShaderReflectionConstantBuffer GetConstantBufferByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getresourcebindingdesc
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D12_SHADER_INPUT_BIND_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getinputparameterdesc
    HRESULT GetInputParameterDesc(uint ParameterIndex, D3D12_SIGNATURE_PARAMETER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getoutputparameterdesc
    HRESULT GetOutputParameterDesc(uint ParameterIndex, D3D12_SIGNATURE_PARAMETER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getpatchconstantparameterdesc
    HRESULT GetPatchConstantParameterDesc(uint ParameterIndex, D3D12_SIGNATURE_PARAMETER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getvariablebyname
    ID3D12ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getresourcebindingdescbyname
    HRESULT GetResourceBindingDescByName(const(PSTR) Name, D3D12_SHADER_INPUT_BIND_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getmovinstructioncount
    uint    GetMovInstructionCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getmovcinstructioncount
    uint    GetMovcInstructionCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getconversioninstructioncount
    uint    GetConversionInstructionCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getbitwiseinstructioncount
    uint    GetBitwiseInstructionCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getgsinputprimitive
    D3D_PRIMITIVE GetGSInputPrimitive();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-issamplefrequencyshader
    BOOL    IsSampleFrequencyShader();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getnuminterfaceslots
    uint    GetNumInterfaceSlots();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getminfeaturelevel
    HRESULT GetMinFeatureLevel(D3D_FEATURE_LEVEL* pLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getthreadgroupsize
    uint    GetThreadGroupSize(uint* pSizeX, uint* pSizeY, uint* pSizeZ);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12shaderreflection-getrequiresflags
    ulong   GetRequiresFlags();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nn-d3d12shader-id3d12libraryreflection
@GUID("8e349d19-54db-4a56-9dc9-119d87bdb804")
interface ID3D12LibraryReflection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12libraryreflection-getdesc
    HRESULT GetDesc(D3D12_LIBRARY_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12libraryreflection-getfunctionbyindex
    ID3D12FunctionReflection GetFunctionByIndex(int FunctionIndex);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nn-d3d12shader-id3d12functionreflection
@GUID("1108795c-2772-4ba9-b2a8-d464dc7e2799")
interface ID3D12FunctionReflection
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12functionreflection-getdesc
    HRESULT GetDesc(D3D12_FUNCTION_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12functionreflection-getconstantbufferbyindex
    ID3D12ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint BufferIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12functionreflection-getconstantbufferbyname
    ID3D12ShaderReflectionConstantBuffer GetConstantBufferByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12functionreflection-getresourcebindingdesc
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D12_SHADER_INPUT_BIND_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12functionreflection-getvariablebyname
    ID3D12ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12functionreflection-getresourcebindingdescbyname
    HRESULT GetResourceBindingDescByName(const(PSTR) Name, D3D12_SHADER_INPUT_BIND_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12functionreflection-getfunctionparameter
    ID3D12FunctionParameterReflection GetFunctionParameter(int ParameterIndex);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nn-d3d12shader-id3d12functionparameterreflection
@GUID("ec25f42d-7006-4f2b-b33e-02cc3375733f")
interface ID3D12FunctionParameterReflection
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d12shader/nf-d3d12shader-id3d12functionparameterreflection-getdesc
    HRESULT GetDesc(D3D12_PARAMETER_DESC* pDesc);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("e0d06420-9f31-47e8-ae9a-dd2ba25ac0bc")
interface ID3D12CompilerFactoryChild : IUnknown
{
    HRESULT GetFactory(const(GUID)* riid, void** ppCompilerFactory);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("5704e5e6-054b-4738-b661-7b0d68d8dde2")
interface ID3D12CompilerCacheSession : ID3D12CompilerFactoryChild
{
    HRESULT FindGroup(const(D3D12_COMPILER_CACHE_GROUP_KEY)* pGroupKey, uint* pGroupVersion);
    HRESULT FindGroupValueKeys(const(D3D12_COMPILER_CACHE_GROUP_KEY)* pGroupKey, 
                               const(uint)* pExpectedGroupVersion, 
                               D3D12CompilerCacheSessionGroupValueKeysFunc CallbackFunc, void* pContext);
    HRESULT FindGroupValues(const(D3D12_COMPILER_CACHE_GROUP_KEY)* pGroupKey, const(uint)* pExpectedGroupVersion, 
                            D3D12_COMPILER_VALUE_TYPE_FLAGS ValueTypeFlags, 
                            D3D12CompilerCacheSessionGroupValuesFunc CallbackFunc, void* pContext);
    HRESULT FindValue(const(D3D12_COMPILER_CACHE_VALUE_KEY)* pValueKey, 
                      D3D12_COMPILER_CACHE_TYPED_VALUE* pTypedValues, uint NumTypedValues, 
                      D3D12CompilerCacheSessionAllocationFunc pCallbackFunc, void* pContext);
    D3D12_APPLICATION_DESC* GetApplicationDesc();
    D3D12_COMPILER_TARGET GetCompilerTarget();
    D3D12_COMPILER_VALUE_TYPE_FLAGS GetValueTypes();
    HRESULT StoreGroupValueKeys(const(D3D12_COMPILER_CACHE_GROUP_KEY)* pGroupKey, uint GroupVersion, 
                                const(D3D12_COMPILER_CACHE_VALUE_KEY)* pValueKeys, uint NumValueKeys);
    HRESULT StoreValue(const(D3D12_COMPILER_CACHE_VALUE_KEY)* pValueKey, 
                       const(D3D12_COMPILER_CACHE_TYPED_CONST_VALUE)* pTypedValues, uint NumTypedValues);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("5981cca4-e8ae-44ca-9b92-4fa86f5a3a3a")
interface ID3D12CompilerStateObject : IUnknown
{
    HRESULT GetCompiler(const(GUID)* riid, void** ppCompiler);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("8c403c12-993b-4583-80f1-6824138fa68e")
interface ID3D12Compiler : ID3D12CompilerFactoryChild
{
    HRESULT CompilePipelineState(const(D3D12_COMPILER_CACHE_GROUP_KEY)* pGroupKey, uint GroupVersion, 
                                 const(D3D12_PIPELINE_STATE_STREAM_DESC)* pDesc);
    HRESULT CompileStateObject(const(D3D12_COMPILER_CACHE_GROUP_KEY)* pGroupKey, uint GroupVersion, 
                               const(D3D12_STATE_OBJECT_DESC)* pDesc, const(GUID)* riid, 
                               void** ppCompilerStateObject);
    HRESULT CompileAddToStateObject(const(D3D12_COMPILER_CACHE_GROUP_KEY)* pGroupKey, uint GroupVersion, 
                                    const(D3D12_STATE_OBJECT_DESC)* pAddition, 
                                    ID3D12CompilerStateObject pCompilerStateObjectToGrowFrom, const(GUID)* riid, 
                                    void** ppNewCompilerStateObject);
    HRESULT GetCacheSession(const(GUID)* riid, void** ppCompilerCacheSession);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("c1ee4b59-3f59-47a5-9b4e-a855c858a878")
interface ID3D12CompilerFactory : IUnknown
{
    HRESULT EnumerateAdapterFamilies(uint AdapterFamilyIndex, D3D12_ADAPTER_FAMILY* pAdapterFamily);
    HRESULT EnumerateAdapterFamilyABIVersions(uint AdapterFamilyIndex, uint* pNumABIVersions, ulong* pABIVersions);
    HRESULT EnumerateAdapterFamilyCompilerVersion(uint AdapterFamilyIndex, D3D12_VERSION_NUMBER* pCompilerVersion);
    HRESULT GetApplicationProfileVersion(const(D3D12_COMPILER_TARGET)* pTarget, 
                                         const(D3D12_APPLICATION_DESC)* pApplicationDesc, 
                                         D3D12_VERSION_NUMBER* pApplicationProfileVersion);
    HRESULT CreateCompilerCacheSession(const(D3D12_COMPILER_DATABASE_PATH)* pPaths, uint NumPaths, 
                                       const(D3D12_COMPILER_TARGET)* pTarget, 
                                       const(D3D12_APPLICATION_DESC)* pApplicationDesc, const(GUID)* riid, 
                                       void** ppCompilerCacheSession);
    HRESULT CreateCompiler(ID3D12CompilerCacheSession pCompilerCacheSession, const(GUID)* riid, void** ppCompiler);
}


// GUIDs


const GUID IID_ID3D12ApplicationIdentity                = GUIDOF!ID3D12ApplicationIdentity;
const GUID IID_ID3D12CommandAllocator                   = GUIDOF!ID3D12CommandAllocator;
const GUID IID_ID3D12CommandList                        = GUIDOF!ID3D12CommandList;
const GUID IID_ID3D12CommandQueue                       = GUIDOF!ID3D12CommandQueue;
const GUID IID_ID3D12CommandQueue1                      = GUIDOF!ID3D12CommandQueue1;
const GUID IID_ID3D12CommandSignature                   = GUIDOF!ID3D12CommandSignature;
const GUID IID_ID3D12Compiler                           = GUIDOF!ID3D12Compiler;
const GUID IID_ID3D12CompilerCacheSession               = GUIDOF!ID3D12CompilerCacheSession;
const GUID IID_ID3D12CompilerFactory                    = GUIDOF!ID3D12CompilerFactory;
const GUID IID_ID3D12CompilerFactoryChild               = GUIDOF!ID3D12CompilerFactoryChild;
const GUID IID_ID3D12CompilerStateObject                = GUIDOF!ID3D12CompilerStateObject;
const GUID IID_ID3D12DSRDeviceFactory                   = GUIDOF!ID3D12DSRDeviceFactory;
const GUID IID_ID3D12Debug                              = GUIDOF!ID3D12Debug;
const GUID IID_ID3D12Debug1                             = GUIDOF!ID3D12Debug1;
const GUID IID_ID3D12Debug2                             = GUIDOF!ID3D12Debug2;
const GUID IID_ID3D12Debug3                             = GUIDOF!ID3D12Debug3;
const GUID IID_ID3D12Debug4                             = GUIDOF!ID3D12Debug4;
const GUID IID_ID3D12Debug5                             = GUIDOF!ID3D12Debug5;
const GUID IID_ID3D12Debug6                             = GUIDOF!ID3D12Debug6;
const GUID IID_ID3D12DebugCommandList                   = GUIDOF!ID3D12DebugCommandList;
const GUID IID_ID3D12DebugCommandList1                  = GUIDOF!ID3D12DebugCommandList1;
const GUID IID_ID3D12DebugCommandList2                  = GUIDOF!ID3D12DebugCommandList2;
const GUID IID_ID3D12DebugCommandList3                  = GUIDOF!ID3D12DebugCommandList3;
const GUID IID_ID3D12DebugCommandQueue                  = GUIDOF!ID3D12DebugCommandQueue;
const GUID IID_ID3D12DebugCommandQueue1                 = GUIDOF!ID3D12DebugCommandQueue1;
const GUID IID_ID3D12DebugDevice                        = GUIDOF!ID3D12DebugDevice;
const GUID IID_ID3D12DebugDevice1                       = GUIDOF!ID3D12DebugDevice1;
const GUID IID_ID3D12DebugDevice2                       = GUIDOF!ID3D12DebugDevice2;
const GUID IID_ID3D12DescriptorHeap                     = GUIDOF!ID3D12DescriptorHeap;
const GUID IID_ID3D12Device                             = GUIDOF!ID3D12Device;
const GUID IID_ID3D12Device1                            = GUIDOF!ID3D12Device1;
const GUID IID_ID3D12Device10                           = GUIDOF!ID3D12Device10;
const GUID IID_ID3D12Device11                           = GUIDOF!ID3D12Device11;
const GUID IID_ID3D12Device12                           = GUIDOF!ID3D12Device12;
const GUID IID_ID3D12Device13                           = GUIDOF!ID3D12Device13;
const GUID IID_ID3D12Device14                           = GUIDOF!ID3D12Device14;
const GUID IID_ID3D12Device15                           = GUIDOF!ID3D12Device15;
const GUID IID_ID3D12Device2                            = GUIDOF!ID3D12Device2;
const GUID IID_ID3D12Device3                            = GUIDOF!ID3D12Device3;
const GUID IID_ID3D12Device4                            = GUIDOF!ID3D12Device4;
const GUID IID_ID3D12Device5                            = GUIDOF!ID3D12Device5;
const GUID IID_ID3D12Device6                            = GUIDOF!ID3D12Device6;
const GUID IID_ID3D12Device7                            = GUIDOF!ID3D12Device7;
const GUID IID_ID3D12Device8                            = GUIDOF!ID3D12Device8;
const GUID IID_ID3D12Device9                            = GUIDOF!ID3D12Device9;
const GUID IID_ID3D12DeviceChild                        = GUIDOF!ID3D12DeviceChild;
const GUID IID_ID3D12DeviceConfiguration                = GUIDOF!ID3D12DeviceConfiguration;
const GUID IID_ID3D12DeviceConfiguration1               = GUIDOF!ID3D12DeviceConfiguration1;
const GUID IID_ID3D12DeviceFactory                      = GUIDOF!ID3D12DeviceFactory;
const GUID IID_ID3D12DeviceRemovedExtendedData          = GUIDOF!ID3D12DeviceRemovedExtendedData;
const GUID IID_ID3D12DeviceRemovedExtendedData1         = GUIDOF!ID3D12DeviceRemovedExtendedData1;
const GUID IID_ID3D12DeviceRemovedExtendedData2         = GUIDOF!ID3D12DeviceRemovedExtendedData2;
const GUID IID_ID3D12DeviceRemovedExtendedDataSettings  = GUIDOF!ID3D12DeviceRemovedExtendedDataSettings;
const GUID IID_ID3D12DeviceRemovedExtendedDataSettings1 = GUIDOF!ID3D12DeviceRemovedExtendedDataSettings1;
const GUID IID_ID3D12DeviceRemovedExtendedDataSettings2 = GUIDOF!ID3D12DeviceRemovedExtendedDataSettings2;
const GUID IID_ID3D12DeviceStatistics                   = GUIDOF!ID3D12DeviceStatistics;
const GUID IID_ID3D12DeviceTools                        = GUIDOF!ID3D12DeviceTools;
const GUID IID_ID3D12DeviceTools1                       = GUIDOF!ID3D12DeviceTools1;
const GUID IID_ID3D12Fence                              = GUIDOF!ID3D12Fence;
const GUID IID_ID3D12Fence1                             = GUIDOF!ID3D12Fence1;
const GUID IID_ID3D12FunctionParameterReflection        = GUIDOF!ID3D12FunctionParameterReflection;
const GUID IID_ID3D12FunctionReflection                 = GUIDOF!ID3D12FunctionReflection;
const GUID IID_ID3D12GBVDiagnostics                     = GUIDOF!ID3D12GBVDiagnostics;
const GUID IID_ID3D12GraphicsCommandList                = GUIDOF!ID3D12GraphicsCommandList;
const GUID IID_ID3D12GraphicsCommandList1               = GUIDOF!ID3D12GraphicsCommandList1;
const GUID IID_ID3D12GraphicsCommandList10              = GUIDOF!ID3D12GraphicsCommandList10;
const GUID IID_ID3D12GraphicsCommandList2               = GUIDOF!ID3D12GraphicsCommandList2;
const GUID IID_ID3D12GraphicsCommandList3               = GUIDOF!ID3D12GraphicsCommandList3;
const GUID IID_ID3D12GraphicsCommandList4               = GUIDOF!ID3D12GraphicsCommandList4;
const GUID IID_ID3D12GraphicsCommandList5               = GUIDOF!ID3D12GraphicsCommandList5;
const GUID IID_ID3D12GraphicsCommandList6               = GUIDOF!ID3D12GraphicsCommandList6;
const GUID IID_ID3D12GraphicsCommandList7               = GUIDOF!ID3D12GraphicsCommandList7;
const GUID IID_ID3D12GraphicsCommandList8               = GUIDOF!ID3D12GraphicsCommandList8;
const GUID IID_ID3D12GraphicsCommandList9               = GUIDOF!ID3D12GraphicsCommandList9;
const GUID IID_ID3D12Heap                               = GUIDOF!ID3D12Heap;
const GUID IID_ID3D12Heap1                              = GUIDOF!ID3D12Heap1;
const GUID IID_ID3D12InfoQueue                          = GUIDOF!ID3D12InfoQueue;
const GUID IID_ID3D12InfoQueue1                         = GUIDOF!ID3D12InfoQueue1;
const GUID IID_ID3D12LibraryReflection                  = GUIDOF!ID3D12LibraryReflection;
const GUID IID_ID3D12LifetimeOwner                      = GUIDOF!ID3D12LifetimeOwner;
const GUID IID_ID3D12LifetimeTracker                    = GUIDOF!ID3D12LifetimeTracker;
const GUID IID_ID3D12ManualWriteTrackingResource        = GUIDOF!ID3D12ManualWriteTrackingResource;
const GUID IID_ID3D12MetaCommand                        = GUIDOF!ID3D12MetaCommand;
const GUID IID_ID3D12Object                             = GUIDOF!ID3D12Object;
const GUID IID_ID3D12Pageable                           = GUIDOF!ID3D12Pageable;
const GUID IID_ID3D12PageableTools                      = GUIDOF!ID3D12PageableTools;
const GUID IID_ID3D12PipelineLibrary                    = GUIDOF!ID3D12PipelineLibrary;
const GUID IID_ID3D12PipelineLibrary1                   = GUIDOF!ID3D12PipelineLibrary1;
const GUID IID_ID3D12PipelineState                      = GUIDOF!ID3D12PipelineState;
const GUID IID_ID3D12PipelineState1                     = GUIDOF!ID3D12PipelineState1;
const GUID IID_ID3D12ProtectedResourceSession           = GUIDOF!ID3D12ProtectedResourceSession;
const GUID IID_ID3D12ProtectedResourceSession1          = GUIDOF!ID3D12ProtectedResourceSession1;
const GUID IID_ID3D12ProtectedSession                   = GUIDOF!ID3D12ProtectedSession;
const GUID IID_ID3D12QueryHeap                          = GUIDOF!ID3D12QueryHeap;
const GUID IID_ID3D12Resource                           = GUIDOF!ID3D12Resource;
const GUID IID_ID3D12Resource1                          = GUIDOF!ID3D12Resource1;
const GUID IID_ID3D12Resource2                          = GUIDOF!ID3D12Resource2;
const GUID IID_ID3D12RootSignature                      = GUIDOF!ID3D12RootSignature;
const GUID IID_ID3D12RootSignature1                     = GUIDOF!ID3D12RootSignature1;
const GUID IID_ID3D12RootSignatureDeserializer          = GUIDOF!ID3D12RootSignatureDeserializer;
const GUID IID_ID3D12RuntimeValidationControl           = GUIDOF!ID3D12RuntimeValidationControl;
const GUID IID_ID3D12SDKConfiguration                   = GUIDOF!ID3D12SDKConfiguration;
const GUID IID_ID3D12SDKConfiguration1                  = GUIDOF!ID3D12SDKConfiguration1;
const GUID IID_ID3D12ShaderCacheSession                 = GUIDOF!ID3D12ShaderCacheSession;
const GUID IID_ID3D12ShaderReflection                   = GUIDOF!ID3D12ShaderReflection;
const GUID IID_ID3D12ShaderReflectionConstantBuffer     = GUIDOF!ID3D12ShaderReflectionConstantBuffer;
const GUID IID_ID3D12ShaderReflectionType               = GUIDOF!ID3D12ShaderReflectionType;
const GUID IID_ID3D12ShaderReflectionVariable           = GUIDOF!ID3D12ShaderReflectionVariable;
const GUID IID_ID3D12SharingContract                    = GUIDOF!ID3D12SharingContract;
const GUID IID_ID3D12StateObject                        = GUIDOF!ID3D12StateObject;
const GUID IID_ID3D12StateObjectDatabase                = GUIDOF!ID3D12StateObjectDatabase;
const GUID IID_ID3D12StateObjectDatabaseFactory         = GUIDOF!ID3D12StateObjectDatabaseFactory;
const GUID IID_ID3D12StateObjectProperties              = GUIDOF!ID3D12StateObjectProperties;
const GUID IID_ID3D12StateObjectProperties1             = GUIDOF!ID3D12StateObjectProperties1;
const GUID IID_ID3D12StateObjectProperties2             = GUIDOF!ID3D12StateObjectProperties2;
const GUID IID_ID3D12SwapChainAssistant                 = GUIDOF!ID3D12SwapChainAssistant;
const GUID IID_ID3D12Tools                              = GUIDOF!ID3D12Tools;
const GUID IID_ID3D12Tools1                             = GUIDOF!ID3D12Tools1;
const GUID IID_ID3D12Tools2                             = GUIDOF!ID3D12Tools2;
const GUID IID_ID3D12VersionedRootSignatureDeserializer = GUIDOF!ID3D12VersionedRootSignatureDeserializer;
const GUID IID_ID3D12VirtualizationGuestDevice          = GUIDOF!ID3D12VirtualizationGuestDevice;
const GUID IID_ID3D12WorkGraphProperties                = GUIDOF!ID3D12WorkGraphProperties;
