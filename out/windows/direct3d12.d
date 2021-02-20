// Written in the D programming language.

module windows.direct3d12;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct3d11 : D3D_CBUFFER_TYPE, D3D_FEATURE_LEVEL, D3D_INTERPOLATION_MODE,
                                   D3D_MIN_PRECISION, D3D_NAME, D3D_PARAMETER_FLAGS,
                                   D3D_PRIMITIVE, D3D_PRIMITIVE_TOPOLOGY,
                                   D3D_REGISTER_COMPONENT_TYPE, D3D_RESOURCE_RETURN_TYPE,
                                   D3D_SHADER_INPUT_TYPE, D3D_SHADER_VARIABLE_CLASS,
                                   D3D_SHADER_VARIABLE_TYPE, D3D_SRV_DIMENSION,
                                   D3D_TESSELLATOR_DOMAIN, D3D_TESSELLATOR_OUTPUT_PRIMITIVE,
                                   D3D_TESSELLATOR_PARTITIONING, ID3D11Device,
                                   ID3D11DeviceContext, ID3D11Resource, ID3DBlob;
public import windows.displaydevices : RECT;
public import windows.dxgi : DXGI_FORMAT, DXGI_SAMPLE_DESC;
public import windows.kernel : LUID;
public import windows.systemservices : BOOL, HANDLE, PSTR, PWSTR, SECURITY_ATTRIBUTES;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;

extern(Windows) @nogc nothrow:


// Enums


///Specifies the type of a command list.
alias D3D12_COMMAND_LIST_TYPE = int;
enum : int
{
    ///Specifies a command buffer that the GPU can execute. A direct command list doesn't inherit any GPU state.
    D3D12_COMMAND_LIST_TYPE_DIRECT        = 0x00000000,
    ///Specifies a command buffer that can be executed only directly via a direct command list. A bundle command list
    ///inherits all GPU state (except for the currently set pipeline state object and primitive topology).
    D3D12_COMMAND_LIST_TYPE_BUNDLE        = 0x00000001,
    ///Specifies a command buffer for computing.
    D3D12_COMMAND_LIST_TYPE_COMPUTE       = 0x00000002,
    ///Specifies a command buffer for copying.
    D3D12_COMMAND_LIST_TYPE_COPY          = 0x00000003,
    ///Specifies a command buffer for video decoding.
    D3D12_COMMAND_LIST_TYPE_VIDEO_DECODE  = 0x00000004,
    ///Specifies a command buffer for video processing.
    D3D12_COMMAND_LIST_TYPE_VIDEO_PROCESS = 0x00000005,
    D3D12_COMMAND_LIST_TYPE_VIDEO_ENCODE  = 0x00000006,
}

///Specifies flags to be used when creating a command queue.
alias D3D12_COMMAND_QUEUE_FLAGS = int;
enum : int
{
    ///Indicates a default command queue.
    D3D12_COMMAND_QUEUE_FLAG_NONE                = 0x00000000,
    ///Indicates that the GPU timeout should be disabled for this command queue.
    D3D12_COMMAND_QUEUE_FLAG_DISABLE_GPU_TIMEOUT = 0x00000001,
}

///Defines priority levels for a command queue.
alias D3D12_COMMAND_QUEUE_PRIORITY = int;
enum : int
{
    ///Normal priority.
    D3D12_COMMAND_QUEUE_PRIORITY_NORMAL          = 0x00000000,
    ///High priority.
    D3D12_COMMAND_QUEUE_PRIORITY_HIGH            = 0x00000064,
    ///Global realtime priority.
    D3D12_COMMAND_QUEUE_PRIORITY_GLOBAL_REALTIME = 0x00002710,
}

///Specifies how the pipeline interprets geometry or hull shader input primitives.
alias D3D12_PRIMITIVE_TOPOLOGY_TYPE = int;
enum : int
{
    ///The shader has not been initialized with an input primitive type.
    D3D12_PRIMITIVE_TOPOLOGY_TYPE_UNDEFINED = 0x00000000,
    ///Interpret the input primitive as a point.
    D3D12_PRIMITIVE_TOPOLOGY_TYPE_POINT     = 0x00000001,
    ///Interpret the input primitive as a line.
    D3D12_PRIMITIVE_TOPOLOGY_TYPE_LINE      = 0x00000002,
    ///Interpret the input primitive as a triangle.
    D3D12_PRIMITIVE_TOPOLOGY_TYPE_TRIANGLE  = 0x00000003,
    ///Interpret the input primitive as a control point patch.
    D3D12_PRIMITIVE_TOPOLOGY_TYPE_PATCH     = 0x00000004,
}

///Identifies the type of data contained in an input slot.
alias D3D12_INPUT_CLASSIFICATION = int;
enum : int
{
    ///Input data is per-vertex data.
    D3D12_INPUT_CLASSIFICATION_PER_VERTEX_DATA   = 0x00000000,
    ///Input data is per-instance data.
    D3D12_INPUT_CLASSIFICATION_PER_INSTANCE_DATA = 0x00000001,
}

///Specifies the fill mode to use when rendering triangles.
alias D3D12_FILL_MODE = int;
enum : int
{
    ///Draw lines connecting the vertices. Adjacent vertices are not drawn.
    D3D12_FILL_MODE_WIREFRAME = 0x00000002,
    ///Fill the triangles formed by the vertices. Adjacent vertices are not drawn.
    D3D12_FILL_MODE_SOLID     = 0x00000003,
}

///Specifies triangles facing a particular direction are not drawn.
alias D3D12_CULL_MODE = int;
enum : int
{
    ///Always draw all triangles.
    D3D12_CULL_MODE_NONE  = 0x00000001,
    ///Do not draw triangles that are front-facing.
    D3D12_CULL_MODE_FRONT = 0x00000002,
    ///Do not draw triangles that are back-facing.
    D3D12_CULL_MODE_BACK  = 0x00000003,
}

///Specifies comparison options.
alias D3D12_COMPARISON_FUNC = int;
enum : int
{
    ///Never pass the comparison.
    D3D12_COMPARISON_FUNC_NEVER         = 0x00000001,
    ///If the source data is less than the destination data, the comparison passes.
    D3D12_COMPARISON_FUNC_LESS          = 0x00000002,
    ///If the source data is equal to the destination data, the comparison passes.
    D3D12_COMPARISON_FUNC_EQUAL         = 0x00000003,
    ///If the source data is less than or equal to the destination data, the comparison passes.
    D3D12_COMPARISON_FUNC_LESS_EQUAL    = 0x00000004,
    ///If the source data is greater than the destination data, the comparison passes.
    D3D12_COMPARISON_FUNC_GREATER       = 0x00000005,
    ///If the source data is not equal to the destination data, the comparison passes.
    D3D12_COMPARISON_FUNC_NOT_EQUAL     = 0x00000006,
    ///If the source data is greater than or equal to the destination data, the comparison passes.
    D3D12_COMPARISON_FUNC_GREATER_EQUAL = 0x00000007,
    ///Always pass the comparison.
    D3D12_COMPARISON_FUNC_ALWAYS        = 0x00000008,
}

///Identifies the portion of a depth-stencil buffer for writing depth data.
alias D3D12_DEPTH_WRITE_MASK = int;
enum : int
{
    ///Turn off writes to the depth-stencil buffer.
    D3D12_DEPTH_WRITE_MASK_ZERO = 0x00000000,
    ///Turn on writes to the depth-stencil buffer.
    D3D12_DEPTH_WRITE_MASK_ALL  = 0x00000001,
}

///Identifies the stencil operations that can be performed during depth-stencil testing.
alias D3D12_STENCIL_OP = int;
enum : int
{
    ///Keep the existing stencil data.
    D3D12_STENCIL_OP_KEEP     = 0x00000001,
    ///Set the stencil data to 0.
    D3D12_STENCIL_OP_ZERO     = 0x00000002,
    ///Set the stencil data to the reference value set by calling ID3D12GraphicsCommandList::OMSetStencilRef.
    D3D12_STENCIL_OP_REPLACE  = 0x00000003,
    ///Increment the stencil value by 1, and clamp the result.
    D3D12_STENCIL_OP_INCR_SAT = 0x00000004,
    ///Decrement the stencil value by 1, and clamp the result.
    D3D12_STENCIL_OP_DECR_SAT = 0x00000005,
    ///Invert the stencil data.
    D3D12_STENCIL_OP_INVERT   = 0x00000006,
    ///Increment the stencil value by 1, and wrap the result if necessary.
    D3D12_STENCIL_OP_INCR     = 0x00000007,
    ///Decrement the stencil value by 1, and wrap the result if necessary.
    D3D12_STENCIL_OP_DECR     = 0x00000008,
}

///Specifies blend factors, which modulate values for the pixel shader and render target.
alias D3D12_BLEND = int;
enum : int
{
    ///The blend factor is (0, 0, 0, 0). No pre-blend operation.
    D3D12_BLEND_ZERO             = 0x00000001,
    ///The blend factor is (1, 1, 1, 1). No pre-blend operation.
    D3D12_BLEND_ONE              = 0x00000002,
    ///The blend factor is (Rₛ, Gₛ, Bₛ, Aₛ), that is color data (RGB) from a pixel shader. No pre-blend
    ///operation.
    D3D12_BLEND_SRC_COLOR        = 0x00000003,
    ///The blend factor is (1 - Rₛ, 1 - Gₛ, 1 - Bₛ, 1 - Aₛ), that is color data (RGB) from a pixel shader. The
    ///pre-blend operation inverts the data, generating 1 - RGB.
    D3D12_BLEND_INV_SRC_COLOR    = 0x00000004,
    ///The blend factor is (Aₛ, Aₛ, Aₛ, Aₛ), that is alpha data (A) from a pixel shader. No pre-blend operation.
    D3D12_BLEND_SRC_ALPHA        = 0x00000005,
    ///The blend factor is ( 1 - Aₛ, 1 - Aₛ, 1 - Aₛ, 1 - Aₛ), that is alpha data (A) from a pixel shader. The
    ///pre-blend operation inverts the data, generating 1 - A.
    D3D12_BLEND_INV_SRC_ALPHA    = 0x00000006,
    ///The blend factor is (A<sub>d</sub> A<sub>d</sub> A<sub>d</sub> A<sub>d</sub>), that is alpha data from a render
    ///target. No pre-blend operation.
    D3D12_BLEND_DEST_ALPHA       = 0x00000007,
    ///The blend factor is (1 - A<sub>d</sub> 1 - A<sub>d</sub> 1 - A<sub>d</sub> 1 - A<sub>d</sub>), that is alpha data
    ///from a render target. The pre-blend operation inverts the data, generating 1 - A.
    D3D12_BLEND_INV_DEST_ALPHA   = 0x00000008,
    ///The blend factor is (R<sub>d</sub>, G<sub>d</sub>, B<sub>d</sub>, A<sub>d</sub>), that is color data from a
    ///render target. No pre-blend operation.
    D3D12_BLEND_DEST_COLOR       = 0x00000009,
    ///The blend factor is (1 - R<sub>d</sub>, 1 - G<sub>d</sub>, 1 - B<sub>d</sub>, 1 - A<sub>d</sub>), that is color
    ///data from a render target. The pre-blend operation inverts the data, generating 1 - RGB.
    D3D12_BLEND_INV_DEST_COLOR   = 0x0000000a,
    ///The blend factor is (f, f, f, 1); where f = min(Aₛ, 1 - A<sub>d</sub>). The pre-blend operation clamps the data
    ///to 1 or less.
    D3D12_BLEND_SRC_ALPHA_SAT    = 0x0000000b,
    ///The blend factor is the blend factor set with ID3D12GraphicsCommandList::OMSetBlendFactor. No pre-blend
    ///operation.
    D3D12_BLEND_BLEND_FACTOR     = 0x0000000e,
    ///The blend factor is the blend factor set with ID3D12GraphicsCommandList::OMSetBlendFactor. The pre-blend
    ///operation inverts the blend factor, generating 1 - blend_factor.
    D3D12_BLEND_INV_BLEND_FACTOR = 0x0000000f,
    ///The blend factor is data sources both as color data output by a pixel shader. There is no pre-blend operation.
    ///This blend factor supports dual-source color blending.
    D3D12_BLEND_SRC1_COLOR       = 0x00000010,
    ///The blend factor is data sources both as color data output by a pixel shader. The pre-blend operation inverts the
    ///data, generating 1 - RGB. This blend factor supports dual-source color blending.
    D3D12_BLEND_INV_SRC1_COLOR   = 0x00000011,
    ///The blend factor is data sources as alpha data output by a pixel shader. There is no pre-blend operation. This
    ///blend factor supports dual-source color blending.
    D3D12_BLEND_SRC1_ALPHA       = 0x00000012,
    ///The blend factor is data sources as alpha data output by a pixel shader. The pre-blend operation inverts the
    ///data, generating 1 - A. This blend factor supports dual-source color blending.
    D3D12_BLEND_INV_SRC1_ALPHA   = 0x00000013,
}

///Specifies RGB or alpha blending operations.
alias D3D12_BLEND_OP = int;
enum : int
{
    ///Add source 1 and source 2.
    D3D12_BLEND_OP_ADD          = 0x00000001,
    ///Subtract source 1 from source 2.
    D3D12_BLEND_OP_SUBTRACT     = 0x00000002,
    ///Subtract source 2 from source 1.
    D3D12_BLEND_OP_REV_SUBTRACT = 0x00000003,
    ///Find the minimum of source 1 and source 2.
    D3D12_BLEND_OP_MIN          = 0x00000004,
    ///Find the maximum of source 1 and source 2.
    D3D12_BLEND_OP_MAX          = 0x00000005,
}

///Identifies which components of each pixel of a render target are writable during blending.
alias D3D12_COLOR_WRITE_ENABLE = int;
enum : int
{
    ///Allow data to be stored in the red component.
    D3D12_COLOR_WRITE_ENABLE_RED   = 0x00000001,
    ///Allow data to be stored in the green component.
    D3D12_COLOR_WRITE_ENABLE_GREEN = 0x00000002,
    ///Allow data to be stored in the blue component.
    D3D12_COLOR_WRITE_ENABLE_BLUE  = 0x00000004,
    ///Allow data to be stored in the alpha component.
    D3D12_COLOR_WRITE_ENABLE_ALPHA = 0x00000008,
    ///Allow data to be stored in all components.
    D3D12_COLOR_WRITE_ENABLE_ALL   = 0x0000000f,
}

///Defines constants that specify logical operations to configure for a render target.
alias D3D12_LOGIC_OP = int;
enum : int
{
    ///Clears the render target (<code>0</code>).
    D3D12_LOGIC_OP_CLEAR         = 0x00000000,
    ///Sets the render target ( <code>1</code>).
    D3D12_LOGIC_OP_SET           = 0x00000001,
    ///Copys the render target (<code>s<code> source from Pixel Shader output).
    D3D12_LOGIC_OP_COPY          = 0x00000002,
    ///Performs an inverted-copy of the render target (<code>~s</code>).
    D3D12_LOGIC_OP_COPY_INVERTED = 0x00000003,
    ///No operation is performed on the render target (<code>d</code> destination in the Render Target View).
    D3D12_LOGIC_OP_NOOP          = 0x00000004,
    ///Inverts the render target (<code>~d</code>).
    D3D12_LOGIC_OP_INVERT        = 0x00000005,
    ///Performs a logical AND operation on the render target (<code>s & d</code>).
    D3D12_LOGIC_OP_AND           = 0x00000006,
    ///Performs a logical NAND operation on the render target (<code>~(s & d)</code>).
    D3D12_LOGIC_OP_NAND          = 0x00000007,
    ///Performs a logical OR operation on the render target (<code>s | d</code>).
    D3D12_LOGIC_OP_OR            = 0x00000008,
    ///Performs a logical NOR operation on the render target (<code>~(s | d)</code>).
    D3D12_LOGIC_OP_NOR           = 0x00000009,
    ///Performs a logical XOR operation on the render target (<code>s ^ d</code>).
    D3D12_LOGIC_OP_XOR           = 0x0000000a,
    ///Performs a logical equal operation on the render target (<code>~(s ^ d)</code>).
    D3D12_LOGIC_OP_EQUIV         = 0x0000000b,
    ///Performs a logical AND and reverse operation on the render target (<code>s & ~d</code>).
    D3D12_LOGIC_OP_AND_REVERSE   = 0x0000000c,
    ///Performs a logical AND and invert operation on the render target (<code>~s & d</code>).
    D3D12_LOGIC_OP_AND_INVERTED  = 0x0000000d,
    ///Performs a logical OR and reverse operation on the render target (<code>s | ~d</code>).
    D3D12_LOGIC_OP_OR_REVERSE    = 0x0000000e,
    ///Performs a logical OR and invert operation on the render target (<code>~s | d</code>).
    D3D12_LOGIC_OP_OR_INVERTED   = 0x0000000f,
}

///Identifies whether conservative rasterization is on or off.
alias D3D12_CONSERVATIVE_RASTERIZATION_MODE = int;
enum : int
{
    ///Conservative rasterization is off.
    D3D12_CONSERVATIVE_RASTERIZATION_MODE_OFF = 0x00000000,
    ///Conservative rasterization is on.
    D3D12_CONSERVATIVE_RASTERIZATION_MODE_ON  = 0x00000001,
}

///When using triangle strip primitive topology, vertex positions are interpreted as vertices of a continuous triangle
///“strip”. There is a special index value that represents the desire to have a discontinuity in the strip, the cut
///index value. This enum lists the supported cut values.
alias D3D12_INDEX_BUFFER_STRIP_CUT_VALUE = int;
enum : int
{
    ///Indicates that there is no cut value.
    D3D12_INDEX_BUFFER_STRIP_CUT_VALUE_DISABLED   = 0x00000000,
    ///Indicates that 0xFFFF should be used as the cut value.
    D3D12_INDEX_BUFFER_STRIP_CUT_VALUE_0xFFFF     = 0x00000001,
    ///Indicates that 0xFFFFFFFF should be used as the cut value.
    D3D12_INDEX_BUFFER_STRIP_CUT_VALUE_0xFFFFFFFF = 0x00000002,
}

///Flags to control pipeline state.
alias D3D12_PIPELINE_STATE_FLAGS = int;
enum : int
{
    ///Indicates no flags.
    D3D12_PIPELINE_STATE_FLAG_NONE       = 0x00000000,
    ///Indicates that the pipeline state should be compiled with additional information to assist debugging. This can
    ///only be set on WARP devices.
    D3D12_PIPELINE_STATE_FLAG_TOOL_DEBUG = 0x00000001,
}

///Specifies the type of a sub-object in a pipeline state stream description.
alias D3D12_PIPELINE_STATE_SUBOBJECT_TYPE = int;
enum : int
{
    ///Indicates a root signature subobject type. The corresponding subobject type is
    ///**[ID3D12RootSignature](/windows/win32/api/d3d12/nn-d3d12-id3d12rootsignature)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_ROOT_SIGNATURE        = 0x00000000,
    ///Indicates a vertex shader subobject type. The corresponding subobject type is
    ///**[D3D12_SHADER_BYTECODE](/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_bytecode)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_VS                    = 0x00000001,
    ///Indicates a pixel shader subobject type. The corresponding subobject type is
    ///**[D3D12_SHADER_BYTECODE](/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_bytecode)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_PS                    = 0x00000002,
    ///Indicates a domain shader subobject type. The corresponding subobject type is
    ///**[D3D12_SHADER_BYTECODE](/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_bytecode)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_DS                    = 0x00000003,
    ///Indicates a hull shader subobject type. The corresponding subobject type is
    ///**[D3D12_SHADER_BYTECODE](/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_bytecode)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_HS                    = 0x00000004,
    ///Indicates a geometry shader subobject type. The corresponding subobject type is
    ///**[D3D12_SHADER_BYTECODE](/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_bytecode)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_GS                    = 0x00000005,
    ///Indicates a compute shader subobject type. The corresponding subobject type is
    ///**[D3D12_SHADER_BYTECODE](/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_bytecode)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_CS                    = 0x00000006,
    ///Indicates a stream-output subobject type. The corresponding subobject type is
    ///**[D3D12_STREAM_OUTPUT_DESC](/windows/win32/api/d3d12/ns-d3d12-d3d12_stream_output_desc)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_STREAM_OUTPUT         = 0x00000007,
    ///Indicates a blend subobject type. The corresponding subobject type is
    ///**[D3D12_BLEND_DESC](/windows/win32/api/d3d12/ns-d3d12-d3d12_blend_desc)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_BLEND                 = 0x00000008,
    ///Indicates a sample mask subobject type. The corresponding subobject type is **UINT**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_SAMPLE_MASK           = 0x00000009,
    ///Indicates indicates a rasterizer subobject type. The corresponding subobject type is
    ///**[D3D12_RASTERIZER_DESC](/windows/win32/api/d3d12/ns-d3d12-d3d12_rasterizer_desc)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_RASTERIZER            = 0x0000000a,
    ///Indicates a depth stencil subobject type. The corresponding subobject type is
    ///**[D3D12_DEPTH_STENCIL_DESC](/windows/win32/api/d3d12/ns-d3d12-d3d12_depth_stencil_desc)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL         = 0x0000000b,
    ///Indicates an input layout subobject type. The corresponding subobject type is
    ///**[D3D12_INPUT_LAYOUT_DESC](/windows/win32/api/d3d12/ns-d3d12-d3d12_input_layout_desc)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_INPUT_LAYOUT          = 0x0000000c,
    ///Indicates an index buffer strip cut value subobject type. The corresponding subobject type is
    ///**[D3D12_INDEX_BUFFER_STRIP_CUT_VALUE](/windows/win32/api/d3d12/ne-d3d12-d3d12_index_buffer_strip_cut_value)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_IB_STRIP_CUT_VALUE    = 0x0000000d,
    ///Indicates a primitive topology subobject type. The corresponding subobject type is
    ///**[D3D12_PRIMITIVE_TOPOLOGY_TYPE](/windows/win32/api/d3d12/ne-d3d12-d3d12_primitive_topology_type)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_PRIMITIVE_TOPOLOGY    = 0x0000000e,
    ///Indicates a render target formats subobject type. The corresponding subobject type is
    ///**[D3D12_RT_FORMAT_ARRAY](/windows/win32/api/d3d12/ne-d3d12-d3d12_rt_format_array)** structure, which wraps an
    ///array of render target formats along with a count of the array elements.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_RENDER_TARGET_FORMATS = 0x0000000f,
    ///Indicates a depth stencil format subobject. The corresponding subobject type is
    ///**[DXGI_FORMAT](/windows/win32/api/dxgiformat/ne-dxgiformat-dxgi_format)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL_FORMAT  = 0x00000010,
    ///Indicates a sample description subobject type. The corresponding subobject type is
    ///**[DXGI_SAMPLE_DESC](/windows/win32/api/dxgicommon/ns-dxgicommon-dxgi_sample_desc)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_SAMPLE_DESC           = 0x00000011,
    ///Indicates a node mask subobject type. The corresponding subobject type is
    ///**[D3D12_NODE_MASK](/windows/win32/api/d3d12/ns-d3d12-d3d12_node_mask)** or **UINT**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_NODE_MASK             = 0x00000012,
    ///Indicates a cached pipeline state object subobject type. The corresponding subobject type is
    ///**[D3D12_CACHED_PIPELINE_STATE](/windows/win32/api/d3d12/ns-d3d12-d3d12_cached_pipeline_state)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_CACHED_PSO            = 0x00000013,
    ///Indicates a flags subobject type. The corresponding subobject type is
    ///**[D3D12_PIPELINE_STATE_FLAGS](/windows/win32/api/d3d12/ne-d3d12-d3d12_pipeline_state_flags)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_FLAGS                 = 0x00000014,
    ///Indicates an expanded depth stencil subobject type. This expansion of the depth stencil subobject supports
    ///optional depth bounds checking. The corresponding subobject type is
    ///**[D3D12_DEPTH_STENCIL1](/windows/win32/api/d3d12/ns-d3d12-d3d12_depth_stencil1)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_DEPTH_STENCIL1        = 0x00000015,
    ///Indicates a view instancing subobject type. The corresponding subobject type is
    ///**[D3D12_VIEW_INSTANCING_DESC](/windows/win32/api/d3d12/ns-d3d12-d3d12_view_instancing_desc)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_VIEW_INSTANCING       = 0x00000016,
    ///Indicates an amplification shader subobject type. The corresponding subobject type is
    ///**[D3D12_SHADER_BYTECODE](/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_bytecode)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_AS                    = 0x00000018,
    ///Indicates a mesh shader subobject type. The corresponding subobject type is
    ///**[D3D12_SHADER_BYTECODE](/windows/win32/api/d3d12/ns-d3d12-d3d12_shader_bytecode)**.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_MS                    = 0x00000019,
    ///A sentinel value that marks the exclusive upper-bound of valid values this enumeration represents.
    D3D12_PIPELINE_STATE_SUBOBJECT_TYPE_MAX_VALID             = 0x0000001a,
}

///Defines constants that specify a Direct3D 12 feature or feature set to query about. When you want to query for the
///level to which an adapter supports a feature, pass one of these values to
///[ID3D12Device::CheckFeatureSupport](./nf-d3d12-id3d12device-checkfeaturesupport.md).
alias D3D12_FEATURE = int;
enum : int
{
    ///Indicates a query for the level of support for basic Direct3D 12 feature options. The corresponding data
    ///structure for this value is D3D12_FEATURE_DATA_D3D12_OPTIONS.
    D3D12_FEATURE_D3D12_OPTIONS                         = 0x00000000,
    ///Indicates a query for the adapter's architectural details, so that your application can better optimize for
    ///certain adapter properties. The corresponding data structure for this value is D3D12_FEATURE_DATA_ARCHITECTURE.
    ///<div class="alert"><b>Note</b> This value has been superseded by the <b>D3D_FEATURE_DATA_ARCHITECTURE1</b> value.
    ///If your application targets Windows 10, version 1703 (Creators' Update) or higher, then use the
    ///<b>D3D_FEATURE_DATA_ARCHITECTURE1</b> value instead.</div> <div> </div>
    D3D12_FEATURE_ARCHITECTURE                          = 0x00000001,
    ///Indicates a query for info about the feature levels supported. The corresponding data structure for this value is
    ///D3D12_FEATURE_DATA_FEATURE_LEVELS.
    D3D12_FEATURE_FEATURE_LEVELS                        = 0x00000002,
    ///Indicates a query for the resources supported by the current graphics driver for a given format. The
    ///corresponding data structure for this value is D3D12_FEATURE_DATA_FORMAT_SUPPORT.
    D3D12_FEATURE_FORMAT_SUPPORT                        = 0x00000003,
    ///Indicates a query for the image quality levels for a given format and sample count. The corresponding data
    ///structure for this value is D3D12_FEATURE_DATA_MULTISAMPLE_QUALITY_LEVELS.
    D3D12_FEATURE_MULTISAMPLE_QUALITY_LEVELS            = 0x00000004,
    ///Indicates a query for the DXGI data format. The corresponding data structure for this value is
    ///D3D12_FEATURE_DATA_FORMAT_INFO.
    D3D12_FEATURE_FORMAT_INFO                           = 0x00000005,
    ///Indicates a query for the GPU's virtual address space limitations. The corresponding data structure for this
    ///value is D3D12_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT.
    D3D12_FEATURE_GPU_VIRTUAL_ADDRESS_SUPPORT           = 0x00000006,
    ///Indicates a query for the supported shader model. The corresponding data structure for this value is
    ///D3D12_FEATURE_DATA_SHADER_MODEL.
    D3D12_FEATURE_SHADER_MODEL                          = 0x00000007,
    ///Indicates a query for the level of support for HLSL 6.0 wave operations. The corresponding data structure for
    ///this value is D3D12_FEATURE_DATA_D3D12_OPTIONS1.
    D3D12_FEATURE_D3D12_OPTIONS1                        = 0x00000008,
    ///Indicates a query for the level of support for protected resource sessions. The corresponding data structure for
    ///this value is D3D12_FEATURE_DATA_PROTECTED_RESOURCE_SESSION_SUPPORT.
    D3D12_FEATURE_PROTECTED_RESOURCE_SESSION_SUPPORT    = 0x0000000a,
    ///Indicates a query for root signature version support. The corresponding data structure for this value is
    ///D3D12_FEATURE_DATA_ROOT_SIGNATURE.
    D3D12_FEATURE_ROOT_SIGNATURE                        = 0x0000000c,
    ///Indicates a query for each adapter's architectural details, so that your application can better optimize for
    ///certain adapter properties. The corresponding data structure for this value is D3D12_FEATURE_DATA_ARCHITECTURE1.
    ///<div class="alert"><b>Note</b> This value supersedes the <b>D3D_FEATURE_DATA_ARCHITECTURE</b> value. If your
    ///application targets Windows 10, version 1703 (Creators' Update) or higher, then use
    ///<b>D3D_FEATURE_DATA_ARCHITECTURE1</b>.</div> <div> </div>
    D3D12_FEATURE_ARCHITECTURE1                         = 0x00000010,
    ///Indicates a query for the level of support for depth-bounds tests and programmable sample positions. The
    ///corresponding data structure for this value is D3D12_FEATURE_DATA_D3D12_OPTIONS2.
    D3D12_FEATURE_D3D12_OPTIONS2                        = 0x00000012,
    ///Indicates a query for the level of support for shader caching. The corresponding data structure for this value is
    ///D3D12_FEATURE_DATA_SHADER_CACHE.
    D3D12_FEATURE_SHADER_CACHE                          = 0x00000013,
    ///Indicates a query for the adapter's support for prioritization of different command queue types. The
    ///corresponding data structure for this value is D3D12_FEATURE_DATA_COMMAND_QUEUE_PRIORITY.
    D3D12_FEATURE_COMMAND_QUEUE_PRIORITY                = 0x00000014,
    ///Indicates a query for the level of support for timestamp queries, format-casting, immediate write, view
    ///instancing, and barycentrics. The corresponding data structure for this value is
    ///D3D12_FEATURE_DATA_D3D12_OPTIONS3.
    D3D12_FEATURE_D3D12_OPTIONS3                        = 0x00000015,
    ///Indicates a query for whether or not the adapter supports creating heaps from existing system memory. The
    ///corresponding data structure for this value is D3D12_FEATURE_DATA_EXISTING_HEAPS.
    D3D12_FEATURE_EXISTING_HEAPS                        = 0x00000016,
    ///Indicates a query for the level of support for 64KB-aligned MSAA textures, cross-API sharing, and native 16-bit
    ///shader operations. The corresponding data structure for this value is D3D12_FEATURE_DATA_D3D12_OPTIONS4.
    D3D12_FEATURE_D3D12_OPTIONS4                        = 0x00000017,
    ///Indicates a query for the level of support for heap serialization. The corresponding data structure for this
    ///value is D3D12_FEATURE_DATA_SERIALIZATION.
    D3D12_FEATURE_SERIALIZATION                         = 0x00000018,
    ///Indicates a query for the level of support for the sharing of resources between different adapters&mdash;for
    ///example, multiple GPUs. The corresponding data structure for this value is D3D12_FEATURE_DATA_CROSS_NODE.
    D3D12_FEATURE_CROSS_NODE                            = 0x00000019,
    ///Starting with Windows 10, version 1809 (10.0; Build 17763), indicates a query for the level of support for render
    ///passes, ray tracing, and shader-resource view tier 3 tiled resources. The corresponding data structure for this
    ///value is D3D12_FEATURE_DATA_D3D12_OPTIONS5.
    D3D12_FEATURE_D3D12_OPTIONS5                        = 0x0000001b,
    ///Starting with Windows 10, version 1903 (10.0; Build 18362), indicates a query for the level of support for
    ///variable-rate shading (VRS), and indicates whether or not background processing is supported. For more info, see
    ///Variable-rate shading (VRS), and the Direct3D 12 background processing spec.
    D3D12_FEATURE_D3D12_OPTIONS6                        = 0x0000001e,
    ///Indicates a query for the level of support for metacommands. The corresponding data structure for this value is
    ///D3D12_FEATURE_DATA_QUERY_META_COMMAND.
    D3D12_FEATURE_QUERY_META_COMMAND                    = 0x0000001f,
    D3D12_FEATURE_D3D12_OPTIONS7                        = 0x00000020,
    D3D12_FEATURE_PROTECTED_RESOURCE_SESSION_TYPE_COUNT = 0x00000021,
    D3D12_FEATURE_PROTECTED_RESOURCE_SESSION_TYPES      = 0x00000022,
}

///Describes minimum precision support options for shaders in the current graphics driver.
alias D3D12_SHADER_MIN_PRECISION_SUPPORT = int;
enum : int
{
    ///The driver supports only full 32-bit precision for all shader stages.
    D3D12_SHADER_MIN_PRECISION_SUPPORT_NONE   = 0x00000000,
    ///The driver supports 10-bit precision.
    D3D12_SHADER_MIN_PRECISION_SUPPORT_10_BIT = 0x00000001,
    ///The driver supports 16-bit precision.
    D3D12_SHADER_MIN_PRECISION_SUPPORT_16_BIT = 0x00000002,
}

///Identifies the tier level at which tiled resources are supported.
alias D3D12_TILED_RESOURCES_TIER = int;
enum : int
{
    ///Indicates that textures cannot be created with the D3D12_TEXTURE_LAYOUT_64KB_UNDEFINED_SWIZZLE layout.
    ///ID3D12Device::CreateReservedResource cannot be used, not even for buffers.
    D3D12_TILED_RESOURCES_TIER_NOT_SUPPORTED = 0x00000000,
    ///Indicates that 2D textures can be created with the D3D12_TEXTURE_LAYOUT_64KB_UNDEFINED_SWIZZLE layout.
    ///Limitations exist for certain resource formats and properties. For more details, see
    ///D3D12_TEXTURE_LAYOUT_64KB_UNDEFINED_SWIZZLE. ID3D12Device::CreateReservedResource can be used. GPU reads or
    ///writes to NULL mappings are undefined. Applications are encouraged to workaround this limitation by repeatedly
    ///mapping the same page to everywhere a NULL mapping would've been used. When the size of a texture mipmap level is
    ///an integer multiple of the standard tile shape for its format, it is guaranteed to be nonpacked.
    D3D12_TILED_RESOURCES_TIER_1             = 0x00000001,
    ///Indicates that a superset of Tier_1 functionality is supported, including this additional support: <ul> <li>When
    ///the size of a texture mipmap level is at least one standard tile shape for its format, the mipmap level is
    ///guaranteed to be nonpacked. For more info, see D3D12_PACKED_MIP_INFO. </li> <li>Shader instructions are available
    ///for clamping level-of-detail (LOD) and for obtaining status about the shader operation. For info about one of
    ///these shader instructions, see Sample(S,float,int,float,uint). Sample(S,float,int,float,uint). </li> <li>Reading
    ///from <b>NULL</b>-mapped tiles treat that sampled value as zero. Writes to <b>NULL</b>-mapped tiles are discarded.
    ///</li> </ul> Adapters that support feature level 12_0 all support TIER_2 or greater.
    D3D12_TILED_RESOURCES_TIER_2             = 0x00000002,
    ///Indicates that a superset of Tier 2 is supported, with the addition that 3D textures (Volume Tiled Resources) are
    ///supported.
    D3D12_TILED_RESOURCES_TIER_3             = 0x00000003,
    D3D12_TILED_RESOURCES_TIER_4             = 0x00000004,
}

///Identifies the tier of resource binding being used.
alias D3D12_RESOURCE_BINDING_TIER = int;
enum : int
{
    ///Tier 1. See Hardware Tiers.
    D3D12_RESOURCE_BINDING_TIER_1 = 0x00000001,
    ///Tier 2. See Hardware Tiers.
    D3D12_RESOURCE_BINDING_TIER_2 = 0x00000002,
    ///Tier 3. See Hardware Tiers.
    D3D12_RESOURCE_BINDING_TIER_3 = 0x00000003,
}

///Identifies the tier level of conservative rasterization.
alias D3D12_CONSERVATIVE_RASTERIZATION_TIER = int;
enum : int
{
    ///Conservative rasterization is not supported.
    D3D12_CONSERVATIVE_RASTERIZATION_TIER_NOT_SUPPORTED = 0x00000000,
    ///Tier 1 enforces a maximum 1/2 pixel uncertainty region and does not support post-snap degenerates. This is good
    ///for tiled rendering, a texture atlas, light map generation and sub-pixel shadow maps.
    D3D12_CONSERVATIVE_RASTERIZATION_TIER_1             = 0x00000001,
    ///Tier 2 reduces the maximum uncertainty region to 1/256 and requires post-snap degenerates not be culled. This
    ///tier is helpful for CPU-based algorithm acceleration (such as voxelization).
    D3D12_CONSERVATIVE_RASTERIZATION_TIER_2             = 0x00000002,
    ///Tier 3 maintains a maximum 1/256 uncertainty region and adds support for inner input coverage. Inner input
    ///coverage adds the new value <code>SV_InnerCoverage</code> to High Level Shading Language (HLSL). This is a 32-bit
    ///scalar integer that can be specified on input to a pixel shader, and represents the underestimated conservative
    ///rasterization information (that is, whether a pixel is guaranteed-to-be-fully covered). This tier is helpful for
    ///occlusion culling.
    D3D12_CONSERVATIVE_RASTERIZATION_TIER_3             = 0x00000003,
}

///Specifies resources that are supported for a provided format.
alias D3D12_FORMAT_SUPPORT1 = int;
enum : int
{
    ///No resources are supported.
    D3D12_FORMAT_SUPPORT1_NONE                        = 0x00000000,
    ///Buffer resources supported.
    D3D12_FORMAT_SUPPORT1_BUFFER                      = 0x00000001,
    ///Vertex buffers supported.
    D3D12_FORMAT_SUPPORT1_IA_VERTEX_BUFFER            = 0x00000002,
    ///Index buffers supported.
    D3D12_FORMAT_SUPPORT1_IA_INDEX_BUFFER             = 0x00000004,
    ///Streaming output buffers supported.
    D3D12_FORMAT_SUPPORT1_SO_BUFFER                   = 0x00000008,
    ///1D texture resources supported.
    D3D12_FORMAT_SUPPORT1_TEXTURE1D                   = 0x00000010,
    ///2D texture resources supported.
    D3D12_FORMAT_SUPPORT1_TEXTURE2D                   = 0x00000020,
    ///3D texture resources supported.
    D3D12_FORMAT_SUPPORT1_TEXTURE3D                   = 0x00000040,
    ///Cube texture resources supported.
    D3D12_FORMAT_SUPPORT1_TEXTURECUBE                 = 0x00000080,
    ///The HLSL Load function for texture objects is supported.
    D3D12_FORMAT_SUPPORT1_SHADER_LOAD                 = 0x00000100,
    ///The HLSL Sample function for texture objects is supported. <div class="alert"><b>Note</b> If the device supports
    ///the format as a resource (1D, 2D, 3D, or cube map) but doesn't support this option, the resource can still use
    ///the Sample method but must use only the point filtering sampler state to perform the sample.</div> <div> </div>
    D3D12_FORMAT_SUPPORT1_SHADER_SAMPLE               = 0x00000200,
    ///The HLSL SampleCmp and SampleCmpLevelZero functions for texture objects are supported. <div
    ///class="alert"><b>Note</b> Windows 8 and later might provide limited support for these functions on Direct3D
    ///feature levels 9_1, 9_2, and 9_3. For more info, see Implementing shadow buffers for Direct3D feature level 9.
    ///</div> <div> </div>
    D3D12_FORMAT_SUPPORT1_SHADER_SAMPLE_COMPARISON    = 0x00000400,
    ///Reserved.
    D3D12_FORMAT_SUPPORT1_SHADER_SAMPLE_MONO_TEXT     = 0x00000800,
    ///Mipmaps are supported.
    D3D12_FORMAT_SUPPORT1_MIP                         = 0x00001000,
    ///Render targets are supported.
    D3D12_FORMAT_SUPPORT1_RENDER_TARGET               = 0x00004000,
    ///Blend operations supported.
    D3D12_FORMAT_SUPPORT1_BLENDABLE                   = 0x00008000,
    ///Depth stencils supported.
    D3D12_FORMAT_SUPPORT1_DEPTH_STENCIL               = 0x00010000,
    ///Multisample antialiasing (MSAA) resolve operations are supported. For more info, see
    ///ID3D12GraphicsCommandList::ResolveSubresource.
    D3D12_FORMAT_SUPPORT1_MULTISAMPLE_RESOLVE         = 0x00040000,
    ///Format can be displayed on screen.
    D3D12_FORMAT_SUPPORT1_DISPLAY                     = 0x00080000,
    ///Format can't be cast to another format.
    D3D12_FORMAT_SUPPORT1_CAST_WITHIN_BIT_LAYOUT      = 0x00100000,
    ///Format can be used as a multi-sampled render target.
    D3D12_FORMAT_SUPPORT1_MULTISAMPLE_RENDERTARGET    = 0x00200000,
    ///Format can be used as a multi-sampled texture and read into a shader with the HLSL Load function.
    D3D12_FORMAT_SUPPORT1_MULTISAMPLE_LOAD            = 0x00400000,
    ///Format can be used with the HLSL gather function. This value is available in DirectX 10.1 or higher.
    D3D12_FORMAT_SUPPORT1_SHADER_GATHER               = 0x00800000,
    ///Format supports casting when the resource is a back buffer.
    D3D12_FORMAT_SUPPORT1_BACK_BUFFER_CAST            = 0x01000000,
    ///Format can be used for an unordered access view.
    D3D12_FORMAT_SUPPORT1_TYPED_UNORDERED_ACCESS_VIEW = 0x02000000,
    ///Format can be used with the HLSL gather with comparison function.
    D3D12_FORMAT_SUPPORT1_SHADER_GATHER_COMPARISON    = 0x04000000,
    ///Format can be used with the decoder output.
    D3D12_FORMAT_SUPPORT1_DECODER_OUTPUT              = 0x08000000,
    ///Format can be used with the video processor output.
    D3D12_FORMAT_SUPPORT1_VIDEO_PROCESSOR_OUTPUT      = 0x10000000,
    ///Format can be used with the video processor input.
    D3D12_FORMAT_SUPPORT1_VIDEO_PROCESSOR_INPUT       = 0x20000000,
    ///Format can be used with the video encoder.
    D3D12_FORMAT_SUPPORT1_VIDEO_ENCODER               = 0x40000000,
}

///Specifies which unordered resource options are supported for a provided format.
alias D3D12_FORMAT_SUPPORT2 = int;
enum : int
{
    ///No unordered resource options are supported.
    D3D12_FORMAT_SUPPORT2_NONE                                         = 0x00000000,
    ///Format supports atomic add.
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_ADD                               = 0x00000001,
    ///Format supports atomic bitwise operations.
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_BITWISE_OPS                       = 0x00000002,
    ///Format supports atomic compare with store or exchange.
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_COMPARE_STORE_OR_COMPARE_EXCHANGE = 0x00000004,
    ///Format supports atomic exchange.
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_EXCHANGE                          = 0x00000008,
    ///Format supports atomic min and max.
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_SIGNED_MIN_OR_MAX                 = 0x00000010,
    ///Format supports atomic unsigned min and max.
    D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_UNSIGNED_MIN_OR_MAX               = 0x00000020,
    ///Format supports a typed load.
    D3D12_FORMAT_SUPPORT2_UAV_TYPED_LOAD                               = 0x00000040,
    ///Format supports a typed store.
    D3D12_FORMAT_SUPPORT2_UAV_TYPED_STORE                              = 0x00000080,
    ///Format supports logic operations in blend state.
    D3D12_FORMAT_SUPPORT2_OUTPUT_MERGER_LOGIC_OP                       = 0x00000100,
    ///Format supports tiled resources. Refer to Volume Tiled Resources.
    D3D12_FORMAT_SUPPORT2_TILED                                        = 0x00000200,
    ///Format supports multi-plane overlays.
    D3D12_FORMAT_SUPPORT2_MULTIPLANE_OVERLAY                           = 0x00004000,
    D3D12_FORMAT_SUPPORT2_SAMPLER_FEEDBACK                             = 0x00008000,
}

///Specifies options for determining quality levels.
alias D3D12_MULTISAMPLE_QUALITY_LEVEL_FLAGS = int;
enum : int
{
    ///No options are supported.
    D3D12_MULTISAMPLE_QUALITY_LEVELS_FLAG_NONE           = 0x00000000,
    ///The number of quality levels can be determined for tiled resources.
    D3D12_MULTISAMPLE_QUALITY_LEVELS_FLAG_TILED_RESOURCE = 0x00000001,
}

///Specifies the level of sharing across nodes of an adapter, such as Tier 1 Emulated, Tier 1, or Tier 2.
alias D3D12_CROSS_NODE_SHARING_TIER = int;
enum : int
{
    ///If an adapter has only 1 node, then cross-node sharing doesn't apply, so the <b>CrossNodeSharingTier</b> member
    ///of the D3D12_FEATURE_DATA_D3D12_OPTIONS structure is set to D3D12_CROSS_NODE_SHARING_NOT_SUPPORTED.
    D3D12_CROSS_NODE_SHARING_TIER_NOT_SUPPORTED = 0x00000000,
    ///Tier 1 Emulated. Devices that set the <b>CrossNodeSharingTier</b> member of the D3D12_FEATURE_DATA_D3D12_OPTIONS
    ///structure to D3D12_CROSS_NODE_SHARING_TIER_1_EMULATED have Tier 1 support. However, drivers stage these copy
    ///operations through a driver-internal system memory allocation. This will cause these copy operations to consume
    ///time on the destination GPU as well as the source.
    D3D12_CROSS_NODE_SHARING_TIER_1_EMULATED    = 0x00000001,
    ///Tier 1. Devices that set the <b>CrossNodeSharingTier</b> member of the D3D12_FEATURE_DATA_D3D12_OPTIONS structure
    ///to D3D12_CROSS_NODE_SHARING_TIER_1 only support the following cross-node copy operations: <ul>
    ///<li>ID3D12CommandList::CopyBufferRegion</li> <li>ID3D12CommandList::CopyTextureRegion</li>
    ///<li>ID3D12CommandList::CopyResource</li> </ul> Additionally, the cross-node resource must be the destination of
    ///the copy operation.
    D3D12_CROSS_NODE_SHARING_TIER_1             = 0x00000002,
    ///Tier 2. Devices that set the <b>CrossNodeSharingTier</b> member of the D3D12_FEATURE_DATA_D3D12_OPTIONS structure
    ///to D3D12_CROSS_NODE_SHARING_TIER_2 support all operations across nodes, except for the following: <ul> <li>Render
    ///target views.</li> <li>Depth stencil views.</li> <li>UAV atomic operations. Similar to CPU/GPU interop, shaders
    ///may perform UAV atomic operations; however, no atomicity across adapters is guaranteed.</li> </ul> Applications
    ///can retrieve the node where a resource/heap exists from the D3D12_HEAP_DESC structure. These values are
    ///retrievable for opened resources. The runtime performs the appropriate re-mapping in case the 2 devices are using
    ///different UMD-specified node re-mappings.
    D3D12_CROSS_NODE_SHARING_TIER_2             = 0x00000003,
    ///Indicates support for [**D3D12_HEAP_FLAG_ALLOW_SHADER_ATOMICS**](./ne-d3d12-d3d12_heap_flags.md) on heaps that
    ///are visible to multiple nodes.
    D3D12_CROSS_NODE_SHARING_TIER_3             = 0x00000004,
}

///Specifies which resource heap tier the hardware and driver support.
alias D3D12_RESOURCE_HEAP_TIER = int;
enum : int
{
    ///Indicates that heaps can only support resources from a single resource category. For the list of resource
    ///categories, see Remarks. In tier 1, these resource categories are mutually exclusive and cannot be used with the
    ///same heap. The resource category must be declared when creating a heap, using the correct D3D12_HEAP_FLAGS
    ///enumeration constant. Applications cannot create heaps with flags that allow all three categories.
    D3D12_RESOURCE_HEAP_TIER_1 = 0x00000001,
    ///Indicates that heaps can support resources from all three categories. For the list of resource categories, see
    ///Remarks. In tier 2, these resource categories can be mixed within the same heap. Applications may create heaps
    ///with flags that allow all three categories; but are not required to do so. Applications may be written to support
    ///tier 1 and seamlessly run on tier 2.
    D3D12_RESOURCE_HEAP_TIER_2 = 0x00000002,
}

///Specifies the level of support for programmable sample positions that's offered by the adapter.
alias D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER = int;
enum : int
{
    ///Indicates that there's no support for programmable sample positions.
    D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER_NOT_SUPPORTED = 0x00000000,
    ///Indicates that there's tier 1 support for programmable sample positions. In tier 1, a single sample pattern can
    ///be specified to repeat for every pixel (SetSamplePosition parameter <i>NumPixels</i> = 1) and ResolveSubResource
    ///is supported.
    D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER_1             = 0x00000001,
    ///Indicates that there's tier 2 support for programmable sample positions. In tier 2, four separate sample patterns
    ///can be specified for each pixel in a 2x2 grid (SetSamplePosition parameter <i>NumPixels</i> = 1) that repeats
    ///over the render-target or viewport, aligned on even coordinates .
    D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER_2             = 0x00000002,
}

///Indicates the tier level at which view instancing is supported.
alias D3D12_VIEW_INSTANCING_TIER = int;
enum : int
{
    ///View instancing is not supported.
    D3D12_VIEW_INSTANCING_TIER_NOT_SUPPORTED = 0x00000000,
    ///View instancing is supported by draw-call level looping only.
    D3D12_VIEW_INSTANCING_TIER_1             = 0x00000001,
    ///View instancing is supported by draw-call level looping at worst, but the GPU can perform view instancing more
    ///efficiently in certain circumstances which are architecture-dependent.
    D3D12_VIEW_INSTANCING_TIER_2             = 0x00000002,
    ///View instancing is supported and instancing begins with the first shader stage that references SV_ViewID or with
    ///rasterization if no shader stage references SV_ViewID. This means that redundant work is eliminated across view
    ///instances when it's not dependent on SV_ViewID. Before rasterization, work that doesn't directly depend on
    ///SV_ViewID is shared across all views; only work that depends on SV_ViewID is repeated for each view. <div
    ///class="alert"><b>Note</b> If a hull shader produces tessellation factors that are dependent on SV_ViewID, then
    ///tessellation and all subsequent work must be repeated per-view. Similarly, if the amount of geometry produced by
    ///the geometry shader depends on SV_ViewID, then the geometry shader must be repeated per-view before proceeding to
    ///rasterization.</div> <div> </div> View instance masking only effects whether work that directly depends on
    ///SV_ViewID is performed, not the entire loop iteration (per-view). If the view instance mask is non-0, some work
    ///that depends on SV_ViewID might still be performed on masked-off pixels but will have no externally-visible
    ///effect; for example, no UAV writes are performed and clipping/rasterzation is not invoked. If the view instance
    ///mask is 0 no work is performed, including work that's not dependent on SV_ViewID.
    D3D12_VIEW_INSTANCING_TIER_3             = 0x00000003,
}

///Specifies the version of root signature layout.
alias D3D_ROOT_SIGNATURE_VERSION = int;
enum : int
{
    ///Version one of root signature layout.
    D3D_ROOT_SIGNATURE_VERSION_1   = 0x00000001,
    ///Version one of root signature layout.
    D3D_ROOT_SIGNATURE_VERSION_1_0 = 0x00000001,
    ///Version 1.1 of root signature layout. Refer to Root Signature Version 1.1.
    D3D_ROOT_SIGNATURE_VERSION_1_1 = 0x00000002,
}

///Specifies a shader model.
alias D3D_SHADER_MODEL = int;
enum : int
{
    ///Indicates shader model 5.1.
    D3D_SHADER_MODEL_5_1 = 0x00000051,
    ///Indicates shader model 6.0.
    D3D_SHADER_MODEL_6_0 = 0x00000060,
    ///Indicates shader model 6.1.
    D3D_SHADER_MODEL_6_1 = 0x00000061,
    D3D_SHADER_MODEL_6_2 = 0x00000062,
    D3D_SHADER_MODEL_6_3 = 0x00000063,
    D3D_SHADER_MODEL_6_4 = 0x00000064,
    D3D_SHADER_MODEL_6_5 = 0x00000065,
    D3D_SHADER_MODEL_6_6 = 0x00000066,
}

///Describes the level of support for shader caching in the current graphics driver.
alias D3D12_SHADER_CACHE_SUPPORT_FLAGS = int;
enum : int
{
    ///Indicates that the driver does not support shader caching.
    D3D12_SHADER_CACHE_SUPPORT_NONE                   = 0x00000000,
    ///Indicates that the driver supports the CachedPSO member of the D3D12_GRAPHICS_PIPELINE_STATE_DESC and
    ///D3D12_COMPUTE_PIPELINE_STATE_DESC structures. This is always supported.
    D3D12_SHADER_CACHE_SUPPORT_SINGLE_PSO             = 0x00000001,
    ///Indicates that the driver supports the ID3D12PipelineLibrary interface, which provides application-controlled PSO
    ///grouping and caching. This is supported by drivers targetting the Windows 10 Anniversary Update.
    D3D12_SHADER_CACHE_SUPPORT_LIBRARY                = 0x00000002,
    ///Indicates that the driver supports an OS-managed shader cache that stores compiled shaders in memory during the
    ///current run of the application.
    D3D12_SHADER_CACHE_SUPPORT_AUTOMATIC_INPROC_CACHE = 0x00000004,
    ///Indicates that the driver supports an OS-managed shader cache that stores compiled shaders on disk to accelerate
    ///future runs of the application.
    D3D12_SHADER_CACHE_SUPPORT_AUTOMATIC_DISK_CACHE   = 0x00000008,
}

///Used to determine which kinds of command lists are capable of supporting various operations. For example, whether a
///command list supports immediate writes.
alias D3D12_COMMAND_LIST_SUPPORT_FLAGS = int;
enum : int
{
    ///Specifies that no command list supports the operation in question.
    D3D12_COMMAND_LIST_SUPPORT_FLAG_NONE          = 0x00000000,
    ///Specifies that direct command lists can support the operation in question.
    D3D12_COMMAND_LIST_SUPPORT_FLAG_DIRECT        = 0x00000001,
    ///Specifies that command list bundles can support the operation in question.
    D3D12_COMMAND_LIST_SUPPORT_FLAG_BUNDLE        = 0x00000002,
    ///Specifies that compute command lists can support the operation in question.
    D3D12_COMMAND_LIST_SUPPORT_FLAG_COMPUTE       = 0x00000004,
    ///Specifies that copy command lists can support the operation in question.
    D3D12_COMMAND_LIST_SUPPORT_FLAG_COPY          = 0x00000008,
    ///Specifies that video-decode command lists can support the operation in question.
    D3D12_COMMAND_LIST_SUPPORT_FLAG_VIDEO_DECODE  = 0x00000010,
    ///Specifies that video-processing command lists can support the operation is question.
    D3D12_COMMAND_LIST_SUPPORT_FLAG_VIDEO_PROCESS = 0x00000020,
    D3D12_COMMAND_LIST_SUPPORT_FLAG_VIDEO_ENCODE  = 0x00000040,
}

///Defines constants that specify a cross-API sharing support tier. The resource data formats mentioned are members of
///the [DXGI_FORMAT enumeration](../dxgiformat/ne-dxgiformat-dxgi_format.md).
alias D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER = int;
enum : int
{
    ///Specifies that the most basic level of cross-API sharing is supported, including the following resource data
    ///formats. * DXGI_FORMAT_R8G8B8A8_UNORM * DXGI_FORMAT_R8G8B8A8_UNORM_SRGB * DXGI_FORMAT_B8G8R8A8_UNORM *
    ///DXGI_FORMAT_B8G8R8A8_UNORM_SRGB * DXGI_FORMAT_B8G8R8X8_UNORM * DXGI_FORMAT_B8G8R8X8_UNORM_SRGB *
    ///DXGI_FORMAT_R10G10B10A2_UNORM * DXGI_FORMAT_R16G16B16A16_FLOAT
    D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER_0 = 0x00000000,
    ///Specifies that cross-API sharing functionality of Tier 0 is supported, plus the following formats. *
    ///DXGI_FORMAT_R16G16B16A16_TYPELESS * DXGI_FORMAT_R10G10B10A2_TYPELESS * DXGI_FORMAT_R8G8B8A8_TYPELESS *
    ///DXGI_FORMAT_R8G8B8X8_TYPELESS * DXGI_FORMAT_R16G16_TYPELESS * DXGI_FORMAT_R8G8_TYPELESS *
    ///DXGI_FORMAT_R32_TYPELESS * DXGI_FORMAT_R16_TYPELESS * DXGI_FORMAT_R8_TYPELESS This level support is built into
    ///WDDM 2.4. Also see [Extended support for shared Texture2D
    ///resources](/windows/win32/direct3d11/direct3d-11-1-features
    D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER_1 = 0x00000001,
    ///Specifies that cross-API sharing functionality of Tier 1 is supported, plus the following formats. *
    ///DXGI_FORMAT_NV12 (also see [Extended NV12 texture support](/windows/win32/direct3d11/direct3d-11-4-features
    D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER_2 = 0x00000002,
}

///Defines constants that specify heap serialization support.
alias D3D12_HEAP_SERIALIZATION_TIER = int;
enum : int
{
    ///Indicates that heap serialization is not supported.
    D3D12_HEAP_SERIALIZATION_TIER_0  = 0x00000000,
    ///Indicates that heap serialization is supported. Your application can serialize resource data in heaps through
    ///copying APIs such as [CopyResource](/windows/desktop/api/d3d12/nf-d3d12-id3d12graphicscommandlist-copyresource),
    ///without necessarily requiring an explicit [state
    ///transition](/windows/desktop/direct3d12/using-resource-barriers-to-synchronize-resource-states-in-direct3d-12
    D3D12_HEAP_SERIALIZATION_TIER_10 = 0x0000000a,
}

///Specifies the level of support for render passes on a graphics device.
alias D3D12_RENDER_PASS_TIER = int;
enum : int
{
    ///The user-mode display driver hasn't implemented render passes, and so the feature is provided only via software
    ///emulation. Render passes might not provide a performance advantage at this level of support.
    D3D12_RENDER_PASS_TIER_0 = 0x00000000,
    ///The render passes feature is implemented by the user-mode display driver, and render target/depth buffer writes
    ///may be accelerated. Unordered access view (UAV) writes are not efficiently supported within the render pass.
    D3D12_RENDER_PASS_TIER_1 = 0x00000001,
    ///The render passes feature is implemented by the user-mode display driver, render target/depth buffer writes may
    ///be accelerated, and unordered access view (UAV) writes (provided that writes in a render pass are not read until
    ///a subsequent render pass) are likely to be more efficient than issuing the same work without using a render pass.
    D3D12_RENDER_PASS_TIER_2 = 0x00000002,
}

///Specifies the level of ray tracing support on the graphics device.
alias D3D12_RAYTRACING_TIER = int;
enum : int
{
    ///No support for ray tracing on the device. Attempts to create any ray tracing-related object will fail, and using
    ///ray tracing-related APIs on command lists results in undefined behavior.
    D3D12_RAYTRACING_TIER_NOT_SUPPORTED = 0x00000000,
    ///The device supports tier 1 ray tracing functionality. In the current release, this tier represents all available
    ///ray tracing features.
    D3D12_RAYTRACING_TIER_1_0           = 0x0000000a,
    D3D12_RAYTRACING_TIER_1_1           = 0x0000000b,
}

///Defines constants that specify a shading rate tier (for variable-rate shading, or VRS). For more info, see
///[Variable-rate shading (VRS)](/windows/desktop/direct3d12/vrs).
alias D3D12_VARIABLE_SHADING_RATE_TIER = int;
enum : int
{
    ///Specifies that variable-rate shading is not supported.
    D3D12_VARIABLE_SHADING_RATE_TIER_NOT_SUPPORTED = 0x00000000,
    ///Specifies that variable-rate shading tier 1 is supported.
    D3D12_VARIABLE_SHADING_RATE_TIER_1             = 0x00000001,
    ///Specifies that variable-rate shading tier 2 is supported.
    D3D12_VARIABLE_SHADING_RATE_TIER_2             = 0x00000002,
}

alias D3D12_MESH_SHADER_TIER = int;
enum : int
{
    D3D12_MESH_SHADER_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_MESH_SHADER_TIER_1             = 0x0000000a,
}

alias D3D12_SAMPLER_FEEDBACK_TIER = int;
enum : int
{
    D3D12_SAMPLER_FEEDBACK_TIER_NOT_SUPPORTED = 0x00000000,
    D3D12_SAMPLER_FEEDBACK_TIER_0_9           = 0x0000005a,
    D3D12_SAMPLER_FEEDBACK_TIER_1_0           = 0x00000064,
}

///Specifies the type of heap. When resident, heaps reside in a particular physical memory pool with certain CPU cache
///properties.
alias D3D12_HEAP_TYPE = int;
enum : int
{
    ///Specifies the default heap. This heap type experiences the most bandwidth for the GPU, but cannot provide CPU
    ///access. The GPU can read and write to the memory from this pool, and resource transition barriers may be changed.
    ///The majority of heaps and resources are expected to be located here, and are typically populated through
    ///resources in upload heaps.
    D3D12_HEAP_TYPE_DEFAULT  = 0x00000001,
    ///Specifies a heap used for uploading. This heap type has CPU access optimized for uploading to the GPU, but does
    ///not experience the maximum amount of bandwidth for the GPU. This heap type is best for CPU-write-once,
    ///GPU-read-once data; but GPU-read-once is stricter than necessary. GPU-read-once-or-from-cache is an acceptable
    ///use-case for the data; but such usages are hard to judge due to differing GPU cache designs and sizes. If in
    ///doubt, stick to the GPU-read-once definition or profile the difference on many GPUs between copying the data to a
    ///_DEFAULT heap vs. reading the data from an _UPLOAD heap. Resources in this heap must be created with
    ///D3D12_RESOURCE_STATE_GENERIC_READ and cannot be changed away from this. The CPU address for such heaps is
    ///commonly not efficient for CPU reads. The following are typical usages for _UPLOAD heaps: <ul> <li>Initializing
    ///resources in a _DEFAULT heap with data from the CPU. </li> <li>Uploading dynamic data in a constant buffer that
    ///is read, repeatedly, by each vertex or pixel. </li> </ul> The following are likely not good usages for _UPLOAD
    ///heaps: <ul> <li>Re-initializing the contents of a resource every frame. </li> <li>Uploading constant data which
    ///is only used every other Draw call, where each Draw uses a non-trivial amount of other data. </li> </ul>
    D3D12_HEAP_TYPE_UPLOAD   = 0x00000002,
    ///Specifies a heap used for reading back. This heap type has CPU access optimized for reading data back from the
    ///GPU, but does not experience the maximum amount of bandwidth for the GPU. This heap type is best for
    ///GPU-write-once, CPU-readable data. The CPU cache behavior is write-back, which is conducive for multiple
    ///sub-cache-line CPU reads. Resources in this heap must be created with D3D12_RESOURCE_STATE_COPY_DEST, and cannot
    ///be changed away from this.
    D3D12_HEAP_TYPE_READBACK = 0x00000003,
    ///Specifies a custom heap. The application may specify the memory pool and CPU cache properties directly, which can
    ///be useful for UMA optimizations, multi-engine, multi-adapter, or other special cases. To do so, the application
    ///is expected to understand the adapter architecture to make the right choice. For more details, see
    ///D3D12_FEATURE_ARCHITECTURE, D3D12_FEATURE_DATA_ARCHITECTURE, and GetCustomHeapProperties.
    D3D12_HEAP_TYPE_CUSTOM   = 0x00000004,
}

///Specifies the CPU-page properties for the heap.
alias D3D12_CPU_PAGE_PROPERTY = int;
enum : int
{
    ///The CPU-page property is unknown.
    D3D12_CPU_PAGE_PROPERTY_UNKNOWN       = 0x00000000,
    ///The CPU cannot access the heap, therefore no page properties are available.
    D3D12_CPU_PAGE_PROPERTY_NOT_AVAILABLE = 0x00000001,
    ///The CPU-page property is write-combined.
    D3D12_CPU_PAGE_PROPERTY_WRITE_COMBINE = 0x00000002,
    ///The CPU-page property is write-back.
    D3D12_CPU_PAGE_PROPERTY_WRITE_BACK    = 0x00000003,
}

///Specifies the memory pool for the heap.
alias D3D12_MEMORY_POOL = int;
enum : int
{
    ///The memory pool is unknown.
    D3D12_MEMORY_POOL_UNKNOWN = 0x00000000,
    ///The memory pool is L0. L0 is the physical system memory pool. When the adapter is discrete/NUMA, this pool has
    ///greater bandwidth for the CPU and less bandwidth for the GPU. When the adapter is UMA, this pool is the only one
    ///which is valid.
    D3D12_MEMORY_POOL_L0      = 0x00000001,
    ///The memory pool is L1. L1 is typically known as the physical video memory pool. L1 is only available when the
    ///adapter is discrete/NUMA, and has greater bandwidth for the GPU and cannot even be accessed by the CPU. When the
    ///adapter is UMA, this pool is not available.
    D3D12_MEMORY_POOL_L1      = 0x00000002,
}

///Specifies heap options, such as whether the heap can contain textures, and whether resources are shared across
///adapters.
alias D3D12_HEAP_FLAGS = int;
enum : int
{
    ///No options are specified.
    D3D12_HEAP_FLAG_NONE                           = 0x00000000,
    ///The heap is shared. Refer to Shared Heaps.
    D3D12_HEAP_FLAG_SHARED                         = 0x00000001,
    ///The heap isn't allowed to contain buffers.
    D3D12_HEAP_FLAG_DENY_BUFFERS                   = 0x00000004,
    ///The heap is allowed to contain swap-chain surfaces.
    D3D12_HEAP_FLAG_ALLOW_DISPLAY                  = 0x00000008,
    ///The heap is allowed to share resources across adapters. Refer to Shared Heaps.
    D3D12_HEAP_FLAG_SHARED_CROSS_ADAPTER           = 0x00000020,
    ///The heap is not allowed to store Render Target (RT) and/or Depth-Stencil (DS) textures.
    D3D12_HEAP_FLAG_DENY_RT_DS_TEXTURES            = 0x00000040,
    ///The heap is not allowed to contain resources with D3D12_RESOURCE_DIMENSION_TEXTURE1D,
    ///D3D12_RESOURCE_DIMENSION_TEXTURE2D, or D3D12_RESOURCE_DIMENSION_TEXTURE3D unless either
    ///D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET or D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL are present. Refer to
    ///D3D12_RESOURCE_DIMENSION and D3D12_RESOURCE_FLAGS.
    D3D12_HEAP_FLAG_DENY_NON_RT_DS_TEXTURES        = 0x00000080,
    ///Unsupported. Do not use.
    D3D12_HEAP_FLAG_HARDWARE_PROTECTED             = 0x00000100,
    ///The heap supports MEM_WRITE_WATCH functionality, which causes the system to track the pages that are written to
    ///in the commited memory region. This flag can't be combined with the D3D12_HEAP_TYPE_DEFAULT or
    ///D3D12_CPU_PAGE_PROPERTY_UNKNOWN flags. Applications are discouraged from using this flag themselves because it
    ///prevents tools from using this functionality.
    D3D12_HEAP_FLAG_ALLOW_WRITE_WATCH              = 0x00000200,
    ///Ensures that atomic operations will be atomic on this heap's memory, according to components able to see the
    ///memory. Creating a heap with this flag will fail under either of these conditions. - The heap type is
    ///**D3D12_HEAP_TYPE_DEFAULT**, and the heap can be visible on multiple nodes, but the device does *not* support
    ///[**D3D12_CROSS_NODE_SHARING_TIER_3**](./ne-d3d12-d3d12_cross_node_sharing_tier.md). - The heap is CPU-visible,
    ///but the heap type is *not* **D3D12_HEAP_TYPE_CUSTOM**. Note that heaps with this flag might be a limited resource
    ///on some systems.
    D3D12_HEAP_FLAG_ALLOW_SHADER_ATOMICS           = 0x00000400,
    ///The heap is created in a non-resident state and must be made resident using
    ///[ID3D12Device::MakeResident](./nf-d3d12-id3d12device-makeresident.md) or
    ///[ID3D12Device3::EnqueueMakeResident](./nf-d3d12-id3d12device3-enqueuemakeresident.md). By default, the final step
    ///of heap creation is to make the heap resident, so this flag skips this step and allows the application to decide
    ///when to do so.
    D3D12_HEAP_FLAG_CREATE_NOT_RESIDENT            = 0x00000800,
    ///Allows the OS to not zero the heap created. By default, committed resources and heaps are almost always zeroed
    ///upon creation. This flag allows this to be elided in some scenarios. However, it doesn't guarantee it. For
    ///example, memory coming from other processes still needs to be zeroed for data protection and process isolation.
    ///This can lower the overhead of creating the heap.
    D3D12_HEAP_FLAG_CREATE_NOT_ZEROED              = 0x00001000,
    ///The heap is allowed to store all types of buffers and/or textures. This is an alias; for more details, see
    ///"Aliases" in the Remarks section.
    D3D12_HEAP_FLAG_ALLOW_ALL_BUFFERS_AND_TEXTURES = 0x00000000,
    ///The heap is only allowed to store buffers. This is an alias; for more details, see "Aliases" in the Remarks
    ///section.
    D3D12_HEAP_FLAG_ALLOW_ONLY_BUFFERS             = 0x000000c0,
    ///The heap is only allowed to store non-RT, non-DS textures. This is an alias; for more details, see "Aliases" in
    ///the Remarks section.
    D3D12_HEAP_FLAG_ALLOW_ONLY_NON_RT_DS_TEXTURES  = 0x00000044,
    ///The heap is only allowed to store RT and/or DS textures. This is an alias; for more details, see "Aliases" in the
    ///Remarks section.
    D3D12_HEAP_FLAG_ALLOW_ONLY_RT_DS_TEXTURES      = 0x00000084,
}

///Identifies the type of resource being used.
alias D3D12_RESOURCE_DIMENSION = int;
enum : int
{
    ///Resource is of unknown type.
    D3D12_RESOURCE_DIMENSION_UNKNOWN   = 0x00000000,
    ///Resource is a buffer.
    D3D12_RESOURCE_DIMENSION_BUFFER    = 0x00000001,
    ///Resource is a 1D texture.
    D3D12_RESOURCE_DIMENSION_TEXTURE1D = 0x00000002,
    ///Resource is a 2D texture.
    D3D12_RESOURCE_DIMENSION_TEXTURE2D = 0x00000003,
    ///Resource is a 3D texture.
    D3D12_RESOURCE_DIMENSION_TEXTURE3D = 0x00000004,
}

///Specifies texture layout options.
alias D3D12_TEXTURE_LAYOUT = int;
enum : int
{
    ///Indicates that the layout is unknown, and is likely adapter-dependent. During creation, the driver chooses the
    ///most efficient layout based on other resource properties, especially resource size and flags. Prefer this choice
    ///unless certain functionality is required from another texture layout. Zero-copy texture upload optimizations
    ///exist for UMA architectures; see ID3D12Resource::WriteToSubresource.
    D3D12_TEXTURE_LAYOUT_UNKNOWN                = 0x00000000,
    ///Indicates that data for the texture is stored in row-major order (sometimes called "pitch-linear order"). This
    ///texture layout locates consecutive texels of a row contiguously in memory, before the texels of the next row.
    ///Similarly, consecutive texels of a particular depth or array slice are contiguous in memory before the texels of
    ///the next depth or array slice. Padding may exist between rows and between depth or array slices to align
    ///collections of data. A stride is the distance in memory between rows, depth, or array slices; and it includes any
    ///padding. This texture layout enables sharing of the texture data between multiple adapters, when other layouts
    ///aren't available. Many restrictions apply, because this layout is generally not efficient for extensive usage:
    ///<ul> <li>The locality of nearby texels is not rotationally invariant. </li> <li>Only the following texture
    ///properties are supported: <ul> <li> D3D12_RESOURCE_DIMENSION_TEXTURE_2D. </li> <li>A single mip level. </li>
    ///<li>A single array slice. </li> <li>64KB alignment. </li> <li>Non-MSAA. </li> <li>No
    ///D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL. </li> <li>The format cannot be a YUV format. </li> </ul> </li> <li>The
    ///texture must be created on a heap with D3D12_HEAP_FLAG_SHARED_CROSS_ADAPTER. </li> </ul> Buffers are created with
    ///D3D12_TEXTURE_LAYOUT_ROW_MAJOR, because row-major texture data can be located in them without creating a texture
    ///object. This is commonly used for uploading or reading back texture data, especially for discrete/NUMA adapters.
    ///However, <b>D3D12_TEXTURE_LAYOUT</b>_ROW_MAJOR can also be used when marshaling texture data between GPUs or
    ///adapters. For examples of usage with ID3D12GraphicsCommandList::CopyTextureRegion, see some of the following
    ///topics: <ul> <li> Default Texture Mapping and Standard Swizzle </li> <li> Predication </li> <li> Multi-engine
    ///synchronization </li> <li> Uploading Texture Data </li> </ul>
    D3D12_TEXTURE_LAYOUT_ROW_MAJOR              = 0x00000001,
    ///Indicates that the layout within 64KB tiles and tail mip packing is up to the driver. No standard swizzle
    ///pattern. This texture layout is arranged into contiguous 64KB regions, also known as tiles, containing near
    ///equilateral amount of consecutive number of texels along each dimension. Tiles are arranged in row-major order.
    ///While there is no padding between tiles, there are typically unused texels within the last tile in each
    ///dimension. The layout of texels within the tile is undefined. Each subresource immediately follows where the
    ///previous subresource end, and the subresource order follows the same sequence as subresource ordinals. However,
    ///tail mip packing is adapter-specific. For more details, see tiled resource tier and
    ///ID3D12Device::GetResourceTiling. This texture layout enables partially resident or sparse texture scenarios when
    ///used together with virtual memory page mapping functionality. This texture layout must be used together with
    ///ID3D12Device::CreateReservedResourceto enable the usage of ID3D12CommandQueue::UpdateTileMappings. Some
    ///restrictions apply to textures with this layout: <ul> <li>The adapter must support D3D12_TILED_RESOURCES_TIER 1
    ///or greater. </li> <li>64KB alignment must be used. </li> <li> D3D12_RESOURCE_DIMENSION_TEXTURE1D is not
    ///supported, nor are all formats. </li> <li>The tiled resource tier indicates whether textures with
    ///D3D12_RESOURCE_DIMENSION_TEXTURE3D is supported. </li> </ul>
    D3D12_TEXTURE_LAYOUT_64KB_UNDEFINED_SWIZZLE = 0x00000002,
    ///Indicates that a default texture uses the standardized swizzle pattern. This texture layout is arranged the same
    ///way that D3D12_TEXTURE_LAYOUT_64KB_UNDEFINED_SWIZZLE is, except that the layout of texels within the tile is
    ///defined. Tail mip packing is adapter-specific. This texture layout enables optimizations when marshaling data
    ///between multiple adapters or between the CPU and GPU. The amount of copying can be reduced when multiple
    ///components understand the texture memory layout. This layout is generally more efficient for extensive usage than
    ///row-major layout, due to the rotationally invariant locality of neighboring texels. This layout can typically
    ///only be used with adapters that support standard swizzle, but exceptions exist for cross-adapter shared heaps.
    ///The restrictions for this layout are that the following aren't supported: <ul> <li>
    ///D3D12_RESOURCE_DIMENSION_TEXTURE1D </li> <li>Multi-sample anti-aliasing (MSAA) </li> <li>
    ///D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL </li> <li>Formats within the DXGI_FORMAT_R32G32B32_TYPELESS group </li>
    ///</ul>
    D3D12_TEXTURE_LAYOUT_64KB_STANDARD_SWIZZLE  = 0x00000003,
}

///Specifies options for working with resources.
alias D3D12_RESOURCE_FLAGS = int;
enum : int
{
    ///No options are specified.
    D3D12_RESOURCE_FLAG_NONE                        = 0x00000000,
    ///Allows a render target view to be created for the resource, as well as enables the resource to transition into
    ///the state of D3D12_RESOURCE_STATE_RENDER_TARGET. Some adapter architectures allocate extra memory for textures
    ///with this flag to reduce the effective bandwidth during common rendering. This characteristic may not be
    ///beneficial for textures that are never rendered to, nor is it available for textures compressed with BC formats.
    ///Applications should avoid setting this flag when rendering will never occur. The following restrictions and
    ///interactions apply: <ul> <li> Either the texture format must support render target capabilities at the current
    ///feature level. Or, when the format is a typeless format, a format within the same typeless group must support
    ///render target capabilities at the current feature level.</li> <li>Cannot be set in conjunction with textures that
    ///have D3D12_TEXTURE_LAYOUT_ROW_MAJOR when
    ///D3D12_FEATURE_DATA_D3D12_OPTIONS::<b>CrossAdapterRowMajorTextureSupported</b> is FALSE nor in conjunction with
    ///textures that have D3D12_TEXTURE_LAYOUT_64KB_STANDARD_SWIZZLE when
    ///<b>D3D12_FEATURE_DATA_D3D12_OPTIONS</b>::<b>StandardSwizzle64KBSupported</b> is FALSE. </li> <li>Cannot be used
    ///with 4KB alignment, D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL, nor usage with heaps that have
    ///D3D12_HEAP_FLAG_DENY_RT_DS_TEXTURES.</li> </ul>
    D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET         = 0x00000001,
    ///Allows a depth stencil view to be created for the resource, as well as enables the resource to transition into
    ///the state of D3D12_RESOURCE_STATE_DEPTH_WRITE and/or D3D12_RESOURCE_STATE_DEPTH_READ. Most adapter architectures
    ///allocate extra memory for textures with this flag to reduce the effective bandwidth and maximize optimizations
    ///for early depth-test. Applications should avoid setting this flag when depth operations will never occur. The
    ///following restrictions and interactions apply: <ul> <li>Either the texture format must support depth stencil
    ///capabilities at the current feature level. Or, when the format is a typeless format, a format within the same
    ///typeless group must support depth stencil capabilities at the current feature level.</li> <li>Cannot be used with
    ///D3D12_RESOURCE_DIMENSION_BUFFER, 4KB alignment, D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET,
    ///D3D12_RESOURCE_FLAG_ALLOW_UNORDERED_ACCESS, D3D12_RESOURCE_FLAG_ALLOW_SIMULTANEOUS_ACCESS,
    ///D3D12_TEXTURE_LAYOUT_64KB_STANDARD_SWIZZLE, D3D12_TEXTURE_LAYOUT_ROW_MAJOR, nor used with heaps that have
    ///D3D12_HEAP_FLAG_DENY_RT_DS_TEXTURES or D3D12_HEAP_FLAG_ALLOW_DISPLAY. </li> <li>Precludes usage of
    ///WriteToSubresource and ReadFromSubresource. </li> <li>Precludes GPU copying of a subregion. CopyTextureRegion
    ///must copy a whole subresource to or from resources with this flag.</li> </ul>
    D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL         = 0x00000002,
    ///Allows an unordered access view to be created for the resource, as well as enables the resource to transition
    ///into the state of D3D12_RESOURCE_STATE_UNORDERED_ACCESS. Some adapter architectures must resort to less efficient
    ///texture layouts in order to provide this functionality. If a texture is rarely used for unordered access, it may
    ///be worth having two textures around and copying between them. One texture would have this flag, while the other
    ///wouldn't. Applications should avoid setting this flag when unordered access operations will never occur. The
    ///following restrictions and interactions apply: <ul> <li>Either the texture format must support unordered access
    ///capabilities at the current feature level. Or, when the format is a typeless format, a format within the same
    ///typeless group must support unordered access capabilities at the current feature level. </li> <li>Cannot be set
    ///in conjunction with textures that have D3D12_TEXTURE_LAYOUT_ROW_MAJOR when
    ///D3D12_FEATURE_DATA_D3D12_OPTIONS::<b>CrossAdapterRowMajorTextureSupported</b> is FALSE nor in conjunction with
    ///textures that have D3D12_TEXTURE_LAYOUT_64KB_STANDARD_SWIZZLE when
    ///<b>D3D12_FEATURE_DATA_D3D12_OPTIONS</b>::<b>StandardSwizzle64KBSupported</b> is FALSE, nor when the feature level
    ///is less than 11.0. </li> <li>Cannot be used with MSAA textures. </li> </ul>
    D3D12_RESOURCE_FLAG_ALLOW_UNORDERED_ACCESS      = 0x00000004,
    ///Disallows a shader resource view to be created for the resource, as well as disables the resource to transition
    ///into the state of D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE or D3D12_RESOURCE_STATE_PIXEL_SHADER_RESOURCE.
    ///Some adapter architectures experience increased bandwidth for depth stencil textures when shader resource views
    ///are precluded. If a texture is rarely used for shader resource, it may be worth having two textures around and
    ///copying between them. One texture would have this flag and the other wouldn't. Applications should set this flag
    ///when depth stencil textures will never be used from shader resource views. The following restrictions and
    ///interactions apply: <ul> <li>Must be used with D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL. </li> </ul>
    D3D12_RESOURCE_FLAG_DENY_SHADER_RESOURCE        = 0x00000008,
    ///Allows the resource to be used for cross-adapter data, as well as the same features enabled by
    ///ALLOW_SIMULTANEOUS_ACCESS. Cross adapter resources commonly preclude techniques that reduce effective texture
    ///bandwidth during usage, and some adapter architectures may require different caching behavior. Applications
    ///should avoid setting this flag when the resource data will never be used with another adapter. The following
    ///restrictions and interactions apply: <ul> <li>Must be used with heaps that have
    ///D3D12_HEAP_FLAG_SHARED_CROSS_ADAPTER.</li> <li>Cannot be used with heaps that have
    ///D3D12_HEAP_FLAG_ALLOW_DISPLAY.</li> </ul>
    D3D12_RESOURCE_FLAG_ALLOW_CROSS_ADAPTER         = 0x00000010,
    ///Allows a resource to be simultaneously accessed by multiple different queues, devices or processes (for example,
    ///allows a resource to be used with ResourceBarrier transitions performed in more than one command list executing
    ///at the same time). Simultaneous access allows multiple readers and one writer, as long as the writer doesn't
    ///concurrently modify the texels that other readers are accessing. Some adapter architectures cannot leverage
    ///techniques to reduce effective texture bandwidth during usage. However, applications should avoid setting this
    ///flag when multiple readers are not required during frequent, non-overlapping writes to textures. Use of this flag
    ///can compromise resource fences to perform waits, and prevents any compression being used with a resource. These
    ///restrictions and interactions apply. - Can't be used with
    ///[D3D12_RESOURCE_DIMENSION_BUFFER](./ne-d3d12-d3d12_resource_dimension.md); but buffers always have the properties
    ///represented by this flag. - Can't be used with MSAA textures. - Can't be used with
    ///[D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL]().
    D3D12_RESOURCE_FLAG_ALLOW_SIMULTANEOUS_ACCESS   = 0x00000020,
    ///This resource may only be used as a decode reference frame. It may only be written to or read by the video decode
    ///operation. [D3D12_VIDEO_DECODE_TIER_1](../d3d12video/ne-d3d12video-d3d12_video_decode_tier) and
    ///[D3D12_VIDEO_DECODE_TIER_2](../d3d12video/ne-d3d12video-d3d12_video_decode_tier) may report
    ///[D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_REFERENCE_ONLY_ALLOCATIONS_REQUIRED](../d3d12video/ne-d3d12video-d3d12_video_decode_configuration_flags)
    ///in the
    ///[D3D12_FEATURE_DATA_VIDEO_DECODE_SUPPORT](../d3d12video/ns-d3d12video-d3d12_feature_data_video_decode_support)
    ///structure configuration flag. If so, the application must allocate reference frames with the new
    ///**D3D12\_RESOURCE\_VIDEO\_DECODE\_REFERENCE\_ONLY** resource flag.
    ///[D3D12_VIDEO_DECODE_TIER_3](../d3d12video/ne-d3d12video-d3d12_video_decode_tier) must not set the
    ///[D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_REFERENCE_ONLY_ALLOCATIONS_REQUIRED]
    ///(../d3d12video/ne-d3d12video-d3d12_video_decode_configuration_flags)) configuration flag and must not require the
    ///use of this resource flag.
    D3D12_RESOURCE_FLAG_VIDEO_DECODE_REFERENCE_ONLY = 0x00000040,
}

///Specifies a range of tile mappings.
alias D3D12_TILE_RANGE_FLAGS = int;
enum : int
{
    ///No tile-mapping flags are specified.
    D3D12_TILE_RANGE_FLAG_NONE              = 0x00000000,
    ///The tile range is <b>NULL</b>.
    D3D12_TILE_RANGE_FLAG_NULL              = 0x00000001,
    ///Skip the tile range.
    D3D12_TILE_RANGE_FLAG_SKIP              = 0x00000002,
    ///Reuse a single tile in the tile range.
    D3D12_TILE_RANGE_FLAG_REUSE_SINGLE_TILE = 0x00000004,
}

///Specifies how to perform a tile-mapping operation.
alias D3D12_TILE_MAPPING_FLAGS = int;
enum : int
{
    ///No tile-mapping flags are specified.
    D3D12_TILE_MAPPING_FLAG_NONE      = 0x00000000,
    ///Unsupported, do not use.
    D3D12_TILE_MAPPING_FLAG_NO_HAZARD = 0x00000001,
}

///Specifies how to copy a tile.
alias D3D12_TILE_COPY_FLAGS = int;
enum : int
{
    ///No tile-copy flags are specified.
    D3D12_TILE_COPY_FLAG_NONE                                     = 0x00000000,
    ///Indicates that the GPU isn't currently referencing any of the portions of destination memory being written.
    D3D12_TILE_COPY_FLAG_NO_HAZARD                                = 0x00000001,
    ///Indicates that the ID3D12GraphicsCommandList::CopyTiles operation involves copying a linear buffer to a swizzled
    ///tiled resource. This means to copy tile data from the specified buffer location, reading tiles sequentially, to
    ///the specified tile region (in x,y,z order if the region is a box), swizzling to optimal hardware memory layout as
    ///needed. In this <b>ID3D12GraphicsCommandList::CopyTiles</b> call, you specify the source data with the
    ///<i>pBuffer</i> parameter and the destination with the <i>pTiledResource</i> parameter.
    D3D12_TILE_COPY_FLAG_LINEAR_BUFFER_TO_SWIZZLED_TILED_RESOURCE = 0x00000002,
    ///Indicates that the ID3D12GraphicsCommandList::CopyTiles operation involves copying a swizzled tiled resource to a
    ///linear buffer. This means to copy tile data from the tile region, reading tiles sequentially (in x,y,z order if
    ///the region is a box), to the specified buffer location, deswizzling to linear memory layout as needed. In this
    ///<b>ID3D12GraphicsCommandList::CopyTiles</b> call, you specify the source data with the <i>pTiledResource</i>
    ///parameter and the destination with the <i>pBuffer</i> parameter.
    D3D12_TILE_COPY_FLAG_SWIZZLED_TILED_RESOURCE_TO_LINEAR_BUFFER = 0x00000004,
}

///Defines constants that specify the state of a resource regarding how the resource is being used.
alias D3D12_RESOURCE_STATES = int;
enum : int
{
    ///Your application should transition to this state only for accessing a resource across different graphics engine
    ///types. Specifically, a resource must be in the COMMON state before being used on a COPY queue (when previous used
    ///on DIRECT/COMPUTE), and before being used on DIRECT/COMPUTE (when previously used on COPY). This restriction does
    ///not exist when accessing data between DIRECT and COMPUTE queues. The COMMON state can be used for all usages on a
    ///Copy queue using the implicit state transitions. For more info, in Multi-engine synchronization, find "common".
    ///Additionally, textures must be in the COMMON state for CPU access to be legal, assuming the texture was created
    ///in a CPU-visible heap in the first place.
    D3D12_RESOURCE_STATE_COMMON                            = 0x00000000,
    ///A subresource must be in this state when it is accessed by the GPU as a vertex buffer or constant buffer. This is
    ///a read-only state.
    D3D12_RESOURCE_STATE_VERTEX_AND_CONSTANT_BUFFER        = 0x00000001,
    ///A subresource must be in this state when it is accessed by the 3D pipeline as an index buffer. This is a
    ///read-only state.
    D3D12_RESOURCE_STATE_INDEX_BUFFER                      = 0x00000002,
    ///The resource is used as a render target. A subresource must be in this state when it is rendered to or when it is
    ///cleared with ID3D12GraphicsCommandList::ClearRenderTargetView. This is a write-only state. To read from a render
    ///target as a shader resource the resource must be in either D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE or
    ///D3D12_RESOURCE_STATE_PIXEL_SHADER_RESOURCE.
    D3D12_RESOURCE_STATE_RENDER_TARGET                     = 0x00000004,
    ///The resource is used for unordered access. A subresource must be in this state when it is accessed by the GPU via
    ///an unordered access view. A subresource must also be in this state when it is cleared with
    ///ID3D12GraphicsCommandList::ClearUnorderedAccessViewInt or
    ///ID3D12GraphicsCommandList::ClearUnorderedAccessViewFloat. This is a read/write state.
    D3D12_RESOURCE_STATE_UNORDERED_ACCESS                  = 0x00000008,
    ///**D3D12_RESOURCE_STATE_DEPTH_WRITE** is a state that is mutually exclusive with other states. You should use it
    ///for ID3D12GraphicsCommandList::ClearDepthStencilView when the flags (see D3D12_CLEAR_FLAGS) indicate a given
    ///subresource should be cleared (otherwise the subresource state doesn't matter), or when using it in a writable
    ///depth stencil view (see D3D12_DSV_FLAGS) when the PSO has depth write enabled (see D3D12_DEPTH_STENCIL_DESC).
    D3D12_RESOURCE_STATE_DEPTH_WRITE                       = 0x00000010,
    ///DEPTH_READ is a state which can be combined with other states. It should be used when the subresource is in a
    ///read-only depth stencil view, or when the <i>DepthEnable</i> parameter of D3D12_DEPTH_STENCIL_DESC is false. It
    ///can be combined with other read states (for example, D3D12_RESOURCE_STATE_PIXEL_SHADER_RESOURCE), such that the
    ///resource can be used for the depth or stencil test, and accessed by a shader within the same draw call. Using it
    ///when depth will be written by a draw call or clear command is invalid.
    D3D12_RESOURCE_STATE_DEPTH_READ                        = 0x00000020,
    ///The resource is used with a shader other than the pixel shader. A subresource must be in this state before being
    ///read by any stage (except for the pixel shader stage) via a shader resource view. You can still use the resource
    ///in a pixel shader with this flag as long as it also has the flag D3D12_RESOURCE_STATE_PIXEL_SHADER_RESOURCE set.
    ///This is a read-only state.
    D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE         = 0x00000040,
    ///The resource is used with a pixel shader. A subresource must be in this state before being read by the pixel
    ///shader via a shader resource view. This is a read-only state.
    D3D12_RESOURCE_STATE_PIXEL_SHADER_RESOURCE             = 0x00000080,
    ///The resource is used with stream output. A subresource must be in this state when it is accessed by the 3D
    ///pipeline as a stream-out target. This is a write-only state.
    D3D12_RESOURCE_STATE_STREAM_OUT                        = 0x00000100,
    ///The resource is used as an indirect argument. Subresources must be in this state when they are used as the
    ///argument buffer passed to the indirect drawing method ID3D12GraphicsCommandList::ExecuteIndirect. This is a
    ///read-only state.
    D3D12_RESOURCE_STATE_INDIRECT_ARGUMENT                 = 0x00000200,
    ///The resource is used as the destination in a copy operation. Subresources must be in this state when they are
    ///used as the destination of copy operation, or a blt operation. This is a write-only state.
    D3D12_RESOURCE_STATE_COPY_DEST                         = 0x00000400,
    ///The resource is used as the source in a copy operation. Subresources must be in this state when they are used as
    ///the source of copy operation, or a blt operation. This is a read-only state.
    D3D12_RESOURCE_STATE_COPY_SOURCE                       = 0x00000800,
    ///The resource is used as the destination in a resolve operation.
    D3D12_RESOURCE_STATE_RESOLVE_DEST                      = 0x00001000,
    ///The resource is used as the source in a resolve operation.
    D3D12_RESOURCE_STATE_RESOLVE_SOURCE                    = 0x00002000,
    ///When a buffer is created with this as its initial state, it indicates that the resource is a raytracing
    ///acceleration structure, for use in ID3D12GraphicsCommandList4::BuildRaytracingAccelerationStructure,
    ///ID3D12GraphicsCommandList4::CopyRaytracingAccelerationStructure, or ID3D12Device::CreateShaderResourceView for
    ///the D3D12_SRV_DIMENSION_RAYTRACING_ACCELERATION_STRUCTURE dimension.
    D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE = 0x00400000,
    ///Starting with Windows 10, version 1903 (10.0; Build 18362), indicates that the resource is a screen-space
    ///shading-rate image for variable-rate shading (VRS). For more info, see Variable-rate shading (VRS).
    D3D12_RESOURCE_STATE_SHADING_RATE_SOURCE               = 0x01000000,
    ///D3D12_RESOURCE_STATE_GENERIC_READ is a logically OR'd combination of other read-state bits. This is the required
    ///starting state for an upload heap. Your application should generally avoid transitioning to
    ///D3D12_RESOURCE_STATE_GENERIC_READ when possible, since that can result in premature cache flushes, or resource
    ///layout changes (for example, compress/decompress), causing unnecessary pipeline stalls. You should instead
    ///transition resources only to the actually-used states.
    D3D12_RESOURCE_STATE_GENERIC_READ                      = 0x00000ac3,
    ///Synonymous with D3D12_RESOURCE_STATE_COMMON.
    D3D12_RESOURCE_STATE_PRESENT                           = 0x00000000,
    ///The resource is used for Predication.
    D3D12_RESOURCE_STATE_PREDICATION                       = 0x00000200,
    ///The resource is used as a source in a decode operation. Examples include reading the compressed bitstream and
    ///reading from decode references,
    D3D12_RESOURCE_STATE_VIDEO_DECODE_READ                 = 0x00010000,
    ///The resource is used as a destination in the decode operation. This state is used for decode output and
    ///histograms.
    D3D12_RESOURCE_STATE_VIDEO_DECODE_WRITE                = 0x00020000,
    ///The resource is used to read video data during video processing; that is, the resource is used as the source in a
    ///processing operation such as video encoding (compression).
    D3D12_RESOURCE_STATE_VIDEO_PROCESS_READ                = 0x00040000,
    ///The resource is used to write video data during video processing; that is, the resource is used as the
    ///destination in a processing operation such as video encoding (compression).
    D3D12_RESOURCE_STATE_VIDEO_PROCESS_WRITE               = 0x00080000,
    ///The resource is used as the source in an encode operation. This state is used for the input and reference of
    ///motion estimation.
    D3D12_RESOURCE_STATE_VIDEO_ENCODE_READ                 = 0x00200000,
    ///This resource is used as the destination in an encode operation. This state is used for the destination texture
    ///of a resolve motion vector heap operation.
    D3D12_RESOURCE_STATE_VIDEO_ENCODE_WRITE                = 0x00800000,
}

///Specifies a type of resource barrier (transition in resource use) description.
alias D3D12_RESOURCE_BARRIER_TYPE = int;
enum : int
{
    ///A transition barrier that indicates a transition of a set of subresources between different usages. The caller
    ///must specify the before and after usages of the subresources.
    D3D12_RESOURCE_BARRIER_TYPE_TRANSITION = 0x00000000,
    ///An aliasing barrier that indicates a transition between usages of 2 different resources that have mappings into
    ///the same tile pool. The caller can specify both the before and the after resource. Note that one or both
    ///resources can be <b>NULL</b>, which indicates that any tiled resource could cause aliasing.
    D3D12_RESOURCE_BARRIER_TYPE_ALIASING   = 0x00000001,
    ///An unordered access view (UAV) barrier that indicates all UAV accesses (reads or writes) to a particular resource
    ///must complete before any future UAV accesses (read or write) can begin.
    D3D12_RESOURCE_BARRIER_TYPE_UAV        = 0x00000002,
}

///Flags for setting split resource barriers.
alias D3D12_RESOURCE_BARRIER_FLAGS = int;
enum : int
{
    ///No flags.
    D3D12_RESOURCE_BARRIER_FLAG_NONE       = 0x00000000,
    ///This starts a barrier transition in a new state, putting a resource in a temporary no-access condition.
    D3D12_RESOURCE_BARRIER_FLAG_BEGIN_ONLY = 0x00000001,
    ///This barrier completes a transition, setting a new state and restoring active access to a resource.
    D3D12_RESOURCE_BARRIER_FLAG_END_ONLY   = 0x00000002,
}

///Specifies what type of texture copy is to take place.
alias D3D12_TEXTURE_COPY_TYPE = int;
enum : int
{
    ///Indicates a subresource, identified by an index, is to be copied.
    D3D12_TEXTURE_COPY_TYPE_SUBRESOURCE_INDEX = 0x00000000,
    ///Indicates a place footprint, identified by a D3D12_PLACED_SUBRESOURCE_FOOTPRINT structure, is to be copied.
    D3D12_TEXTURE_COPY_TYPE_PLACED_FOOTPRINT  = 0x00000001,
}

///Specifies a resolve operation.
alias D3D12_RESOLVE_MODE = int;
enum : int
{
    ///Resolves compressed source samples to their uncompressed values. When using this operation, the source and
    ///destination resources must have the same sample count, unlike the min, max, and average operations that require
    ///the destination to have a sample count of 1.
    D3D12_RESOLVE_MODE_DECOMPRESS              = 0x00000000,
    ///Resolves the source samples to their minimum value. It can be used with any render target or depth stencil
    ///format.
    D3D12_RESOLVE_MODE_MIN                     = 0x00000001,
    ///Resolves the source samples to their maximum value. It can be used with any render target or depth stencil
    ///format.
    D3D12_RESOLVE_MODE_MAX                     = 0x00000002,
    ///Resolves the source samples to their average value. It can be used with any non-integer render target format,
    ///including the depth plane. It can't be used with integer render target formats, including the stencil plane.
    D3D12_RESOLVE_MODE_AVERAGE                 = 0x00000003,
    D3D12_RESOLVE_MODE_ENCODE_SAMPLER_FEEDBACK = 0x00000004,
    D3D12_RESOLVE_MODE_DECODE_SAMPLER_FEEDBACK = 0x00000005,
}

///Specifies options for view instancing.
alias D3D12_VIEW_INSTANCING_FLAGS = int;
enum : int
{
    ///Indicates a default view instancing configuration.
    D3D12_VIEW_INSTANCING_FLAG_NONE                         = 0x00000000,
    ///Enables view instance masking.
    D3D12_VIEW_INSTANCING_FLAG_ENABLE_VIEW_INSTANCE_MASKING = 0x00000001,
}

///Specifies how memory gets routed by a shader resource view (SRV).
alias D3D12_SHADER_COMPONENT_MAPPING = int;
enum : int
{
    ///Indicates return component 0 (red).
    D3D12_SHADER_COMPONENT_MAPPING_FROM_MEMORY_COMPONENT_0 = 0x00000000,
    ///Indicates return component 1 (green).
    D3D12_SHADER_COMPONENT_MAPPING_FROM_MEMORY_COMPONENT_1 = 0x00000001,
    ///Indicates return component 2 (blue).
    D3D12_SHADER_COMPONENT_MAPPING_FROM_MEMORY_COMPONENT_2 = 0x00000002,
    ///Indicates return component 3 (alpha).
    D3D12_SHADER_COMPONENT_MAPPING_FROM_MEMORY_COMPONENT_3 = 0x00000003,
    ///Indicates forcing the resulting value to 0.
    D3D12_SHADER_COMPONENT_MAPPING_FORCE_VALUE_0           = 0x00000004,
    ///Indicates forcing the resulting value 1. The value of forcing 1 is either 0x1 or 1.0f depending on the format
    ///type for that component in the source format.
    D3D12_SHADER_COMPONENT_MAPPING_FORCE_VALUE_1           = 0x00000005,
}

///Identifies how to view a buffer resource.
alias D3D12_BUFFER_SRV_FLAGS = int;
enum : int
{
    ///Indicates a default view.
    D3D12_BUFFER_SRV_FLAG_NONE = 0x00000000,
    ///View the buffer as raw. For more info about raw viewing of buffers, see Raw Views of Buffers.
    D3D12_BUFFER_SRV_FLAG_RAW  = 0x00000001,
}

///Identifies the type of resource that will be viewed as a shader resource.
alias D3D12_SRV_DIMENSION = int;
enum : int
{
    ///The type is unknown.
    D3D12_SRV_DIMENSION_UNKNOWN                           = 0x00000000,
    ///The resource is a buffer.
    D3D12_SRV_DIMENSION_BUFFER                            = 0x00000001,
    ///The resource is a 1D texture.
    D3D12_SRV_DIMENSION_TEXTURE1D                         = 0x00000002,
    ///The resource is an array of 1D textures.
    D3D12_SRV_DIMENSION_TEXTURE1DARRAY                    = 0x00000003,
    ///The resource is a 2D texture.
    D3D12_SRV_DIMENSION_TEXTURE2D                         = 0x00000004,
    ///The resource is an array of 2D textures.
    D3D12_SRV_DIMENSION_TEXTURE2DARRAY                    = 0x00000005,
    ///The resource is a multisampling 2D texture.
    D3D12_SRV_DIMENSION_TEXTURE2DMS                       = 0x00000006,
    ///The resource is an array of multisampling 2D textures.
    D3D12_SRV_DIMENSION_TEXTURE2DMSARRAY                  = 0x00000007,
    ///The resource is a 3D texture.
    D3D12_SRV_DIMENSION_TEXTURE3D                         = 0x00000008,
    ///The resource is a cube texture.
    D3D12_SRV_DIMENSION_TEXTURECUBE                       = 0x00000009,
    ///The resource is an array of cube textures.
    D3D12_SRV_DIMENSION_TEXTURECUBEARRAY                  = 0x0000000a,
    ///The resource is a raytracing acceleration structure.
    D3D12_SRV_DIMENSION_RAYTRACING_ACCELERATION_STRUCTURE = 0x0000000b,
}

///Specifies filtering options during texture sampling.
alias D3D12_FILTER = int;
enum : int
{
    ///Use point sampling for minification, magnification, and mip-level sampling.
    D3D12_FILTER_MIN_MAG_MIP_POINT                          = 0x00000000,
    ///Use point sampling for minification and magnification; use linear interpolation for mip-level sampling.
    D3D12_FILTER_MIN_MAG_POINT_MIP_LINEAR                   = 0x00000001,
    ///Use point sampling for minification; use linear interpolation for magnification; use point sampling for mip-level
    ///sampling.
    D3D12_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT             = 0x00000004,
    ///Use point sampling for minification; use linear interpolation for magnification and mip-level sampling.
    D3D12_FILTER_MIN_POINT_MAG_MIP_LINEAR                   = 0x00000005,
    ///Use linear interpolation for minification; use point sampling for magnification and mip-level sampling.
    D3D12_FILTER_MIN_LINEAR_MAG_MIP_POINT                   = 0x00000010,
    ///Use linear interpolation for minification; use point sampling for magnification; use linear interpolation for
    ///mip-level sampling.
    D3D12_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR            = 0x00000011,
    ///Use linear interpolation for minification and magnification; use point sampling for mip-level sampling.
    D3D12_FILTER_MIN_MAG_LINEAR_MIP_POINT                   = 0x00000014,
    ///Use linear interpolation for minification, magnification, and mip-level sampling.
    D3D12_FILTER_MIN_MAG_MIP_LINEAR                         = 0x00000015,
    ///Use anisotropic interpolation for minification, magnification, and mip-level sampling.
    D3D12_FILTER_ANISOTROPIC                                = 0x00000055,
    ///Use point sampling for minification, magnification, and mip-level sampling. Compare the result to the comparison
    ///value.
    D3D12_FILTER_COMPARISON_MIN_MAG_MIP_POINT               = 0x00000080,
    ///Use point sampling for minification and magnification; use linear interpolation for mip-level sampling. Compare
    ///the result to the comparison value.
    D3D12_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR        = 0x00000081,
    ///Use point sampling for minification; use linear interpolation for magnification; use point sampling for mip-level
    ///sampling. Compare the result to the comparison value.
    D3D12_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT  = 0x00000084,
    ///Use point sampling for minification; use linear interpolation for magnification and mip-level sampling. Compare
    ///the result to the comparison value.
    D3D12_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR        = 0x00000085,
    ///Use linear interpolation for minification; use point sampling for magnification and mip-level sampling. Compare
    ///the result to the comparison value.
    D3D12_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT        = 0x00000090,
    ///Use linear interpolation for minification; use point sampling for magnification; use linear interpolation for
    ///mip-level sampling. Compare the result to the comparison value.
    D3D12_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x00000091,
    ///Use linear interpolation for minification and magnification; use point sampling for mip-level sampling. Compare
    ///the result to the comparison value.
    D3D12_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT        = 0x00000094,
    ///Use linear interpolation for minification, magnification, and mip-level sampling. Compare the result to the
    ///comparison value.
    D3D12_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR              = 0x00000095,
    ///Use anisotropic interpolation for minification, magnification, and mip-level sampling. Compare the result to the
    ///comparison value.
    D3D12_FILTER_COMPARISON_ANISOTROPIC                     = 0x000000d5,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_MAG_MIP_POINT and instead of filtering them return the minimum
    ///of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can query
    ///support for this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1
    ///structure.
    D3D12_FILTER_MINIMUM_MIN_MAG_MIP_POINT                  = 0x00000100,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_MAG_POINT_MIP_LINEAR and instead of filtering them return the
    ///minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MINIMUM_MIN_MAG_POINT_MIP_LINEAR           = 0x00000101,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT and instead of filtering them return
    ///the minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You
    ///can query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MINIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT     = 0x00000104,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_POINT_MAG_MIP_LINEAR and instead of filtering them return the
    ///minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MINIMUM_MIN_POINT_MAG_MIP_LINEAR           = 0x00000105,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_LINEAR_MAG_MIP_POINT and instead of filtering them return the
    ///minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MINIMUM_MIN_LINEAR_MAG_MIP_POINT           = 0x00000110,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR and instead of filtering them return
    ///the minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You
    ///can query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MINIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR    = 0x00000111,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_MAG_LINEAR_MIP_POINT and instead of filtering them return the
    ///minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MINIMUM_MIN_MAG_LINEAR_MIP_POINT           = 0x00000114,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_MAG_MIP_LINEAR and instead of filtering them return the minimum
    ///of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can query
    ///support for this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1
    ///structure.
    D3D12_FILTER_MINIMUM_MIN_MAG_MIP_LINEAR                 = 0x00000115,
    ///Fetch the same set of texels as D3D12_FILTER_ANISOTROPIC and instead of filtering them return the minimum of the
    ///texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can query support for
    ///this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MINIMUM_ANISOTROPIC                        = 0x00000155,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_MAG_MIP_POINT and instead of filtering them return the maximum
    ///of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can query
    ///support for this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1
    ///structure.
    D3D12_FILTER_MAXIMUM_MIN_MAG_MIP_POINT                  = 0x00000180,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_MAG_POINT_MIP_LINEAR and instead of filtering them return the
    ///maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MAXIMUM_MIN_MAG_POINT_MIP_LINEAR           = 0x00000181,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT and instead of filtering them return
    ///the maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You
    ///can query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MAXIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT     = 0x00000184,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_POINT_MAG_MIP_LINEAR and instead of filtering them return the
    ///maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MAXIMUM_MIN_POINT_MAG_MIP_LINEAR           = 0x00000185,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_LINEAR_MAG_MIP_POINT and instead of filtering them return the
    ///maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MAXIMUM_MIN_LINEAR_MAG_MIP_POINT           = 0x00000190,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR and instead of filtering them return
    ///the maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You
    ///can query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MAXIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR    = 0x00000191,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_MAG_LINEAR_MIP_POINT and instead of filtering them return the
    ///maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MAXIMUM_MIN_MAG_LINEAR_MIP_POINT           = 0x00000194,
    ///Fetch the same set of texels as D3D12_FILTER_MIN_MAG_MIP_LINEAR and instead of filtering them return the maximum
    ///of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can query
    ///support for this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1
    ///structure.
    D3D12_FILTER_MAXIMUM_MIN_MAG_MIP_LINEAR                 = 0x00000195,
    ///Fetch the same set of texels as D3D12_FILTER_ANISOTROPIC and instead of filtering them return the maximum of the
    ///texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can query support for
    ///this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D12_FILTER_MAXIMUM_ANISOTROPIC                        = 0x000001d5,
}

///Specifies the type of magnification or minification sampler filters.
alias D3D12_FILTER_TYPE = int;
enum : int
{
    ///Point filtering is used as a texture magnification or minification filter. The texel with coordinates nearest to
    ///the desired pixel value is used. The texture filter to be used between mipmap levels is nearest-point mipmap
    ///filtering. The rasterizer uses the color from the texel of the nearest mipmap texture.
    D3D12_FILTER_TYPE_POINT  = 0x00000000,
    ///Bilinear interpolation filtering is used as a texture magnification or minification filter. A weighted average of
    ///a 2 x 2 area of texels surrounding the desired pixel is used. The texture filter to use between mipmap levels is
    ///trilinear mipmap interpolation. The rasterizer linearly interpolates pixel color, using the texels of the two
    ///nearest mipmap textures.
    D3D12_FILTER_TYPE_LINEAR = 0x00000001,
}

///Specifies the type of filter reduction.
alias D3D12_FILTER_REDUCTION_TYPE = int;
enum : int
{
    ///The filter type is standard.
    D3D12_FILTER_REDUCTION_TYPE_STANDARD   = 0x00000000,
    ///The filter type is comparison.
    D3D12_FILTER_REDUCTION_TYPE_COMPARISON = 0x00000001,
    ///The filter type is minimum.
    D3D12_FILTER_REDUCTION_TYPE_MINIMUM    = 0x00000002,
    ///The filter type is maximum.
    D3D12_FILTER_REDUCTION_TYPE_MAXIMUM    = 0x00000003,
}

///Identifies a technique for resolving texture coordinates that are outside of the boundaries of a texture.
alias D3D12_TEXTURE_ADDRESS_MODE = int;
enum : int
{
    ///Tile the texture at every (u,v) integer junction. For example, for u values between 0 and 3, the texture is
    ///repeated three times.
    D3D12_TEXTURE_ADDRESS_MODE_WRAP        = 0x00000001,
    ///Flip the texture at every (u,v) integer junction. For u values between 0 and 1, for example, the texture is
    ///addressed normally; between 1 and 2, the texture is flipped (mirrored); between 2 and 3, the texture is normal
    ///again; and so on.
    D3D12_TEXTURE_ADDRESS_MODE_MIRROR      = 0x00000002,
    ///Texture coordinates outside the range [0.0, 1.0] are set to the texture color at 0.0 or 1.0, respectively.
    D3D12_TEXTURE_ADDRESS_MODE_CLAMP       = 0x00000003,
    ///Texture coordinates outside the range [0.0, 1.0] are set to the border color specified in D3D12_SAMPLER_DESC or
    ///HLSL code.
    D3D12_TEXTURE_ADDRESS_MODE_BORDER      = 0x00000004,
    ///Similar to D3D12_TEXTURE_ADDRESS_MODE_MIRROR and D3D12_TEXTURE_ADDRESS_MODE_CLAMP. Takes the absolute value of
    ///the texture coordinate (thus, mirroring around 0), and then clamps to the maximum value.
    D3D12_TEXTURE_ADDRESS_MODE_MIRROR_ONCE = 0x00000005,
}

///Identifies unordered-access view options for a buffer resource.
alias D3D12_BUFFER_UAV_FLAGS = int;
enum : int
{
    ///Indicates a default view.
    D3D12_BUFFER_UAV_FLAG_NONE = 0x00000000,
    ///Resource contains raw, unstructured data. Requires the UAV format to be DXGI_FORMAT_R32_TYPELESS. For more info
    ///about raw viewing of buffers, see Raw Views of Buffers.
    D3D12_BUFFER_UAV_FLAG_RAW  = 0x00000001,
}

///Identifies unordered-access view options.
alias D3D12_UAV_DIMENSION = int;
enum : int
{
    ///The view type is unknown.
    D3D12_UAV_DIMENSION_UNKNOWN        = 0x00000000,
    ///View the resource as a buffer.
    D3D12_UAV_DIMENSION_BUFFER         = 0x00000001,
    ///View the resource as a 1D texture.
    D3D12_UAV_DIMENSION_TEXTURE1D      = 0x00000002,
    ///View the resource as a 1D texture array.
    D3D12_UAV_DIMENSION_TEXTURE1DARRAY = 0x00000003,
    ///View the resource as a 2D texture.
    D3D12_UAV_DIMENSION_TEXTURE2D      = 0x00000004,
    ///View the resource as a 2D texture array.
    D3D12_UAV_DIMENSION_TEXTURE2DARRAY = 0x00000005,
    ///View the resource as a 3D texture array.
    D3D12_UAV_DIMENSION_TEXTURE3D      = 0x00000008,
}

///Identifies the type of resource to view as a render target.
alias D3D12_RTV_DIMENSION = int;
enum : int
{
    ///Do not use this value, as it will cause ID3D12Device::CreateRenderTargetView to fail.
    D3D12_RTV_DIMENSION_UNKNOWN          = 0x00000000,
    ///The resource will be accessed as a buffer.
    D3D12_RTV_DIMENSION_BUFFER           = 0x00000001,
    ///The resource will be accessed as a 1D texture.
    D3D12_RTV_DIMENSION_TEXTURE1D        = 0x00000002,
    ///The resource will be accessed as an array of 1D textures.
    D3D12_RTV_DIMENSION_TEXTURE1DARRAY   = 0x00000003,
    ///The resource will be accessed as a 2D texture.
    D3D12_RTV_DIMENSION_TEXTURE2D        = 0x00000004,
    ///The resource will be accessed as an array of 2D textures.
    D3D12_RTV_DIMENSION_TEXTURE2DARRAY   = 0x00000005,
    ///The resource will be accessed as a 2D texture with multisampling.
    D3D12_RTV_DIMENSION_TEXTURE2DMS      = 0x00000006,
    ///The resource will be accessed as an array of 2D textures with multisampling.
    D3D12_RTV_DIMENSION_TEXTURE2DMSARRAY = 0x00000007,
    ///The resource will be accessed as a 3D texture.
    D3D12_RTV_DIMENSION_TEXTURE3D        = 0x00000008,
}

///Specifies depth-stencil view options.
alias D3D12_DSV_FLAGS = int;
enum : int
{
    ///Indicates a default view.
    D3D12_DSV_FLAG_NONE              = 0x00000000,
    ///Indicates that depth values are read only.
    D3D12_DSV_FLAG_READ_ONLY_DEPTH   = 0x00000001,
    ///Indicates that stencil values are read only.
    D3D12_DSV_FLAG_READ_ONLY_STENCIL = 0x00000002,
}

///Specifies how to access a resource used in a depth-stencil view.
alias D3D12_DSV_DIMENSION = int;
enum : int
{
    ///<b>D3D12_DSV_DIMENSION_UNKNOWN</b> is not a valid value for D3D12_DEPTH_STENCIL_VIEW_DESC and is not used.
    D3D12_DSV_DIMENSION_UNKNOWN          = 0x00000000,
    ///The resource will be accessed as a 1D texture.
    D3D12_DSV_DIMENSION_TEXTURE1D        = 0x00000001,
    ///The resource will be accessed as an array of 1D textures.
    D3D12_DSV_DIMENSION_TEXTURE1DARRAY   = 0x00000002,
    ///The resource will be accessed as a 2D texture.
    D3D12_DSV_DIMENSION_TEXTURE2D        = 0x00000003,
    ///The resource will be accessed as an array of 2D textures.
    D3D12_DSV_DIMENSION_TEXTURE2DARRAY   = 0x00000004,
    ///The resource will be accessed as a 2D texture with multi sampling.
    D3D12_DSV_DIMENSION_TEXTURE2DMS      = 0x00000005,
    ///The resource will be accessed as an array of 2D textures with multi sampling.
    D3D12_DSV_DIMENSION_TEXTURE2DMSARRAY = 0x00000006,
}

///Specifies what to clear from the depth stencil view.
alias D3D12_CLEAR_FLAGS = int;
enum : int
{
    ///Indicates the depth buffer should be cleared.
    D3D12_CLEAR_FLAG_DEPTH   = 0x00000001,
    ///Indicates the stencil buffer should be cleared.
    D3D12_CLEAR_FLAG_STENCIL = 0x00000002,
}

///Specifies fence options.
alias D3D12_FENCE_FLAGS = int;
enum : int
{
    ///No options are specified.
    D3D12_FENCE_FLAG_NONE                 = 0x00000000,
    ///The fence is shared.
    D3D12_FENCE_FLAG_SHARED               = 0x00000001,
    ///The fence is shared with another GPU adapter.
    D3D12_FENCE_FLAG_SHARED_CROSS_ADAPTER = 0x00000002,
    ///The fence is of the non-monitored type. Non-monitored fences should only be used when the adapter doesn't support
    ///monitored fences, or when a fence is shared with an adapter that doesn't support monitored fences.
    D3D12_FENCE_FLAG_NON_MONITORED        = 0x00000004,
}

///Specifies a type of descriptor heap.
alias D3D12_DESCRIPTOR_HEAP_TYPE = int;
enum : int
{
    ///The descriptor heap for the combination of constant-buffer, shader-resource, and unordered-access views.
    D3D12_DESCRIPTOR_HEAP_TYPE_CBV_SRV_UAV = 0x00000000,
    ///The descriptor heap for the sampler.
    D3D12_DESCRIPTOR_HEAP_TYPE_SAMPLER     = 0x00000001,
    ///The descriptor heap for the render-target view.
    D3D12_DESCRIPTOR_HEAP_TYPE_RTV         = 0x00000002,
    ///The descriptor heap for the depth-stencil view.
    D3D12_DESCRIPTOR_HEAP_TYPE_DSV         = 0x00000003,
    ///The number of types of descriptor heaps.
    D3D12_DESCRIPTOR_HEAP_TYPE_NUM_TYPES   = 0x00000004,
}

///Specifies options for a heap.
alias D3D12_DESCRIPTOR_HEAP_FLAGS = int;
enum : int
{
    ///Indicates default usage of a heap.
    D3D12_DESCRIPTOR_HEAP_FLAG_NONE           = 0x00000000,
    ///The flag
    ///[D3D12_DESCRIPTOR_HEAP_FLAG_SHADER_VISIBLE](/windows/win32/api/d3d12/ne-d3d12-d3d12_descriptor_heap_flags) can
    ///optionally be set on a descriptor heap to indicate it is be bound on a command list for reference by shaders.
    ///Descriptor heaps created <i>without</i> this flag allow applications the option to stage descriptors in CPU
    ///memory before copying them to a shader visible descriptor heap, as a convenience. But it is also fine for
    ///applications to directly create descriptors into shader visible descriptor heaps with no requirement to stage
    ///anything on the CPU. Descriptor heaps bound via
    ///[ID3D12GraphicsCommandList::SetDescriptorHeaps](/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setdescriptorheaps)
    ///must have the **D3D12_DESCRIPTOR_HEAP_FLAG_SHADER_VISIBLE** flag set, else the debug layer will produce an error.
    ///Descriptor heaps with the **D3D12_DESCRIPTOR_HEAP_FLAG_SHADER_VISIBLE** flag can't be used as the source heaps in
    ///calls to [ID3D12Device::CopyDescriptors](windows/win32/api/d3d12/nf-d3d12-id3d12device-copydescriptors) or
    ///[ID3D12Device::CopyDescriptorsSimple](windows/win32/api/d3d12/nf-d3d12-id3d12device-copydescriptorssimple),
    ///because they could be resident in **WRITE_COMBINE** memory or GPU-local memory, which is very inefficient to read
    ///from. This flag only applies to CBV/SRV/UAV descriptor heaps, and sampler descriptor heaps. It does not apply to
    ///other descriptor heap types since shaders do not directly reference the other types. Attempting to create an
    ///RTV/DSV heap with **D3D12_DESCRIPTOR_HEAP_FLAG_SHADER_VISIBLE** results in a debug layer error.
    D3D12_DESCRIPTOR_HEAP_FLAG_SHADER_VISIBLE = 0x00000001,
}

///Specifies a range so that, for example, if part of a descriptor table has 100 shader-resource views (SRVs) that range
///can be declared in one entry rather than 100.
alias D3D12_DESCRIPTOR_RANGE_TYPE = int;
enum : int
{
    ///Specifies a range of SRVs.
    D3D12_DESCRIPTOR_RANGE_TYPE_SRV     = 0x00000000,
    ///Specifies a range of unordered-access views (UAVs).
    D3D12_DESCRIPTOR_RANGE_TYPE_UAV     = 0x00000001,
    ///Specifies a range of constant-buffer views (CBVs).
    D3D12_DESCRIPTOR_RANGE_TYPE_CBV     = 0x00000002,
    ///Specifies a range of samplers.
    D3D12_DESCRIPTOR_RANGE_TYPE_SAMPLER = 0x00000003,
}

///Specifies the shaders that can access the contents of a given root signature slot.
alias D3D12_SHADER_VISIBILITY = int;
enum : int
{
    ///Specifies that all shader stages can access whatever is bound at the root signature slot.
    D3D12_SHADER_VISIBILITY_ALL           = 0x00000000,
    ///Specifies that the vertex shader stage can access whatever is bound at the root signature slot.
    D3D12_SHADER_VISIBILITY_VERTEX        = 0x00000001,
    ///Specifies that the hull shader stage can access whatever is bound at the root signature slot.
    D3D12_SHADER_VISIBILITY_HULL          = 0x00000002,
    ///Specifies that the domain shader stage can access whatever is bound at the root signature slot.
    D3D12_SHADER_VISIBILITY_DOMAIN        = 0x00000003,
    ///Specifies that the geometry shader stage can access whatever is bound at the root signature slot.
    D3D12_SHADER_VISIBILITY_GEOMETRY      = 0x00000004,
    ///Specifies that the pixel shader stage can access whatever is bound at the root signature slot.
    D3D12_SHADER_VISIBILITY_PIXEL         = 0x00000005,
    ///Specifies that the amplification shader stage can access whatever is bound at the root signature slot.
    D3D12_SHADER_VISIBILITY_AMPLIFICATION = 0x00000006,
    ///Specifies that the mesh shader stage can access whatever is bound at the root signature slot.
    D3D12_SHADER_VISIBILITY_MESH          = 0x00000007,
}

///Specifies the type of root signature slot.
alias D3D12_ROOT_PARAMETER_TYPE = int;
enum : int
{
    ///The slot is for a descriptor table.
    D3D12_ROOT_PARAMETER_TYPE_DESCRIPTOR_TABLE = 0x00000000,
    ///The slot is for root constants.
    D3D12_ROOT_PARAMETER_TYPE_32BIT_CONSTANTS  = 0x00000001,
    ///The slot is for a constant-buffer view (CBV).
    D3D12_ROOT_PARAMETER_TYPE_CBV              = 0x00000002,
    ///The slot is for a shader-resource view (SRV).
    D3D12_ROOT_PARAMETER_TYPE_SRV              = 0x00000003,
    ///The slot is for a unordered-access view (UAV).
    D3D12_ROOT_PARAMETER_TYPE_UAV              = 0x00000004,
}

///Specifies options for root signature layout.
alias D3D12_ROOT_SIGNATURE_FLAGS = int;
enum : int
{
    ///Indicates default behavior.
    D3D12_ROOT_SIGNATURE_FLAG_NONE                                  = 0x00000000,
    ///The app is opting in to using the Input Assembler (requiring an input layout that defines a set of vertex buffer
    ///bindings). Omitting this flag can result in one root argument space being saved on some hardware. Omit this flag
    ///if the Input Assembler is not required, though the optimization is minor.
    D3D12_ROOT_SIGNATURE_FLAG_ALLOW_INPUT_ASSEMBLER_INPUT_LAYOUT    = 0x00000001,
    ///Denies the vertex shader access to the root signature.
    D3D12_ROOT_SIGNATURE_FLAG_DENY_VERTEX_SHADER_ROOT_ACCESS        = 0x00000002,
    ///Denies the hull shader access to the root signature.
    D3D12_ROOT_SIGNATURE_FLAG_DENY_HULL_SHADER_ROOT_ACCESS          = 0x00000004,
    ///Denies the domain shader access to the root signature.
    D3D12_ROOT_SIGNATURE_FLAG_DENY_DOMAIN_SHADER_ROOT_ACCESS        = 0x00000008,
    ///Denies the geometry shader access to the root signature.
    D3D12_ROOT_SIGNATURE_FLAG_DENY_GEOMETRY_SHADER_ROOT_ACCESS      = 0x00000010,
    ///Denies the pixel shader access to the root signature.
    D3D12_ROOT_SIGNATURE_FLAG_DENY_PIXEL_SHADER_ROOT_ACCESS         = 0x00000020,
    ///The app is opting in to using Stream Output. Omitting this flag can result in one root argument space being saved
    ///on some hardware. Omit this flag if Stream Output is not required, though the optimization is minor.
    D3D12_ROOT_SIGNATURE_FLAG_ALLOW_STREAM_OUTPUT                   = 0x00000040,
    ///The root signature is to be used with raytracing shaders to define resource bindings sourced from shader records
    ///in shader tables. This flag cannot be combined with any other root signature flags, which are all related to the
    ///graphics pipeline. The absence of the flag means the root signature can be used with graphics or compute, where
    ///the compute version is also shared with raytracing’s global root signature.
    D3D12_ROOT_SIGNATURE_FLAG_LOCAL_ROOT_SIGNATURE                  = 0x00000080,
    D3D12_ROOT_SIGNATURE_FLAG_DENY_AMPLIFICATION_SHADER_ROOT_ACCESS = 0x00000100,
    D3D12_ROOT_SIGNATURE_FLAG_DENY_MESH_SHADER_ROOT_ACCESS          = 0x00000200,
}

///Specifies the border color for a static sampler.
alias D3D12_STATIC_BORDER_COLOR = int;
enum : int
{
    ///Indicates black, with the alpha component as fully transparent.
    D3D12_STATIC_BORDER_COLOR_TRANSPARENT_BLACK = 0x00000000,
    ///Indicates black, with the alpha component as fully opaque.
    D3D12_STATIC_BORDER_COLOR_OPAQUE_BLACK      = 0x00000001,
    ///Indicates white, with the alpha component as fully opaque.
    D3D12_STATIC_BORDER_COLOR_OPAQUE_WHITE      = 0x00000002,
}

///Specifies the volatility of both descriptors and the data they reference in a Root Signature 1.1 description, which
///can enable some driver optimizations.
alias D3D12_DESCRIPTOR_RANGE_FLAGS = int;
enum : int
{
    ///Default behavior. Descriptors are static, and default assumptions are made for data (for SRV/CBV:
    ///DATA_STATIC_WHILE_SET_AT_EXECUTE, and for UAV: DATA_VOLATILE).
    D3D12_DESCRIPTOR_RANGE_FLAG_NONE                                            = 0x00000000,
    ///If this is the only flag set, then descriptors are volatile and default assumptions are made about data (for
    ///SRV/CBV: DATA_STATIC_WHILE_SET_AT_EXECUTE, and for UAV: DATA_VOLATILE). If this flag is combined with
    ///DATA_VOLATILE, then both descriptors and data are volaille, which is equivalent to Root Signature Version 1.0. If
    ///this flag is combined with DATA_STATIC_WHILE_SET_AT_EXECUTE, then descriptors are volatile. This still doesn’t
    ///allow them to change during command list execution so it is valid to combine the additional declaration that data
    ///is static while set via root descriptor table during execution – the underlying descriptors are effectively
    ///static for longer than the data is being promised to be static.
    D3D12_DESCRIPTOR_RANGE_FLAG_DESCRIPTORS_VOLATILE                            = 0x00000001,
    ///Descriptors are static and the data is volatile.
    D3D12_DESCRIPTOR_RANGE_FLAG_DATA_VOLATILE                                   = 0x00000002,
    ///Descriptors are static and data is static while set at execute.
    D3D12_DESCRIPTOR_RANGE_FLAG_DATA_STATIC_WHILE_SET_AT_EXECUTE                = 0x00000004,
    ///Both descriptors and data are static. This maximizes the potential for driver optimization.
    D3D12_DESCRIPTOR_RANGE_FLAG_DATA_STATIC                                     = 0x00000008,
    ///Provides the same benefits as static descriptors (see **D3D12_DESCRIPTOR_RANGE_FLAG_NONE**), except that the
    ///driver is not allowed to promote buffers to root descriptors as an optimization, because they must maintain
    ///bounds checks and root descriptors do not have those.
    D3D12_DESCRIPTOR_RANGE_FLAG_DESCRIPTORS_STATIC_KEEPING_BUFFER_BOUNDS_CHECKS = 0x00010000,
}

///Specifies the volatility of the data referenced by descriptors in a Root Signature 1.1 description, which can enable
///some driver optimizations.
alias D3D12_ROOT_DESCRIPTOR_FLAGS = int;
enum : int
{
    ///Default assumptions are made for data (for SRV/CBV: DATA_STATIC_WHILE_SET_AT_EXECUTE, and for UAV:
    ///DATA_VOLATILE).
    D3D12_ROOT_DESCRIPTOR_FLAG_NONE                             = 0x00000000,
    ///Data is volatile. Equivalent to Root Signature Version 1.0.
    D3D12_ROOT_DESCRIPTOR_FLAG_DATA_VOLATILE                    = 0x00000002,
    ///Data is static while set at execute.
    D3D12_ROOT_DESCRIPTOR_FLAG_DATA_STATIC_WHILE_SET_AT_EXECUTE = 0x00000004,
    ///Data is static. The best potential for driver optimization.
    D3D12_ROOT_DESCRIPTOR_FLAG_DATA_STATIC                      = 0x00000008,
}

///Specifies the type of query heap to create.
alias D3D12_QUERY_HEAP_TYPE = int;
enum : int
{
    ///This returns a binary 0/1 result: 0 indicates that no samples passed depth and stencil testing, 1 indicates that
    ///at least one sample passed depth and stencil testing. This enables occlusion queries to not interfere with any
    ///GPU performance optimization associated with depth/stencil testing.
    D3D12_QUERY_HEAP_TYPE_OCCLUSION               = 0x00000000,
    ///Indicates that the heap is for high-performance timing data.
    D3D12_QUERY_HEAP_TYPE_TIMESTAMP               = 0x00000001,
    ///Indicates the heap is to contain pipeline data. Refer to D3D12_QUERY_DATA_PIPELINE_STATISTICS.
    D3D12_QUERY_HEAP_TYPE_PIPELINE_STATISTICS     = 0x00000002,
    ///Indicates the heap is to contain stream output data. Refer to D3D12_QUERY_DATA_SO_STATISTICS.
    D3D12_QUERY_HEAP_TYPE_SO_STATISTICS           = 0x00000003,
    ///Indicates the heap is to contain video decode statistics data. Refer to
    ///[D3D12_QUERY_DATA_VIDEO_DECODE_STATISTICS](../d3d12video/ns-d3d12video-d3d12_query_data_video_decode_statistics.md).
    ///Video decode statistics can only be queried from video decode command lists
    ///(D3D12_COMMAND_LIST_TYPE_VIDEO_DECODE). See D3D12_QUERY_TYPE_DECODE_STATISTICS for more details.
    D3D12_QUERY_HEAP_TYPE_VIDEO_DECODE_STATISTICS = 0x00000004,
    ///Indicates the heap is to contain timestamp queries emitted exclusively by copy command lists. Copy queue
    ///timestamps can only be queried from a copy command list, and a copy command list can not emit to a regular
    ///timestamp query Heap. Support for this query heap type is not universal. You must use CheckFeatureSupport with
    ///[D3D12_FEATURE_D3D12_OPTIONS3](./ne-d3d12-d3d12_feature.md) to determine whether the adapter supports copy queue
    ///timestamp queries.
    D3D12_QUERY_HEAP_TYPE_COPY_QUEUE_TIMESTAMP    = 0x00000005,
}

///Specifies the type of query.
alias D3D12_QUERY_TYPE = int;
enum : int
{
    ///Indicates the query is for depth/stencil occlusion counts.
    D3D12_QUERY_TYPE_OCCLUSION               = 0x00000000,
    ///Indicates the query is for a binary depth/stencil occlusion statistics. This new query type acts like
    ///D3D12_QUERY_TYPE_OCCLUSION except that it returns simply a binary 0/1 result: 0 indicates that no samples passed
    ///depth and stencil testing, 1 indicates that at least one sample passed depth and stencil testing. This enables
    ///occlusion queries to not interfere with any GPU performance optimization associated with depth/stencil testing.
    D3D12_QUERY_TYPE_BINARY_OCCLUSION        = 0x00000001,
    ///Indicates the query is for high definition GPU and CPU timestamps.
    D3D12_QUERY_TYPE_TIMESTAMP               = 0x00000002,
    ///Indicates the query type is for graphics pipeline statistics, refer to D3D12_QUERY_DATA_PIPELINE_STATISTICS.
    D3D12_QUERY_TYPE_PIPELINE_STATISTICS     = 0x00000003,
    ///Stream 0 output statistics. In Direct3D 12 there is no single stream output (SO) overflow query for all the
    ///output streams. Apps need to issue multiple single-stream queries, and then correlate the results. Stream output
    ///is the ability of the GPU to write vertices to a buffer. The stream output counters monitor progress.
    D3D12_QUERY_TYPE_SO_STATISTICS_STREAM0   = 0x00000004,
    ///Stream 1 output statistics.
    D3D12_QUERY_TYPE_SO_STATISTICS_STREAM1   = 0x00000005,
    ///Stream 2 output statistics.
    D3D12_QUERY_TYPE_SO_STATISTICS_STREAM2   = 0x00000006,
    ///Stream 3 output statistics.
    D3D12_QUERY_TYPE_SO_STATISTICS_STREAM3   = 0x00000007,
    ///Video decode statistics. Refer to
    ///[D3D12_QUERY_DATA_VIDEO_DECODE_STATISTICS](../d3d12video/ns-d3d12video-d3d12_query_data_video_decode_statistics).
    ///Use this query type to determine if a video was successfully decoded. If decoding fails due to insufficient
    ///BitRate or FrameRate parameters set during creation of the decode heap, then the status field of the query is set
    ///to [D3D12_VIDEO_DECODE_STATUS_RATE_EXCEEDED](../d3d12video/ne-d3d12video-d3d12_video_decode_status) and the query
    ///also contains new BitRate and FrameRate values that would succeed. This query type can only be performed on video
    ///decode command lists (D3D12_COMMAND_LIST_TYPE_VIDEO_DECODE). This query type does not use
    ///[ID3D12VideoDecodeCommandList::BeginQuery](../d3d12video/nf-d3d12video-id3d12videodecodecommandlist-beginquery.md),
    ///only
    ///[ID3D12VideoDecodeCommandList::EndQuery](../d3d12video/nf-d3d12video-id3d12videodecodecommandlist-endquery.md).
    ///Statistics are recorded only for the most recent
    ///[ID3D12VideoDecodeCommandList::DecodeFrame](../d3d12video/nf-d3d12video-id3d12videodecodecommandlist-decodeframe.md)
    ///call in the same command list. Decode status structures are defined by the codec specification.
    D3D12_QUERY_TYPE_VIDEO_DECODE_STATISTICS = 0x00000008,
}

///Specifies the predication operation to apply.
alias D3D12_PREDICATION_OP = int;
enum : int
{
    ///Enables predication if all 64-bits are zero.
    D3D12_PREDICATION_OP_EQUAL_ZERO     = 0x00000000,
    ///Enables predication if at least one of the 64-bits are not zero.
    D3D12_PREDICATION_OP_NOT_EQUAL_ZERO = 0x00000001,
}

///Specifies the type of the indirect parameter.
alias D3D12_INDIRECT_ARGUMENT_TYPE = int;
enum : int
{
    ///Indicates the type is a Draw call.
    D3D12_INDIRECT_ARGUMENT_TYPE_DRAW                  = 0x00000000,
    ///Indicates the type is a DrawIndexed call.
    D3D12_INDIRECT_ARGUMENT_TYPE_DRAW_INDEXED          = 0x00000001,
    ///Indicates the type is a Dispatch call.
    D3D12_INDIRECT_ARGUMENT_TYPE_DISPATCH              = 0x00000002,
    ///Indicates the type is a vertex buffer view.
    D3D12_INDIRECT_ARGUMENT_TYPE_VERTEX_BUFFER_VIEW    = 0x00000003,
    ///Indicates the type is an index buffer view.
    D3D12_INDIRECT_ARGUMENT_TYPE_INDEX_BUFFER_VIEW     = 0x00000004,
    ///Indicates the type is a constant.
    D3D12_INDIRECT_ARGUMENT_TYPE_CONSTANT              = 0x00000005,
    ///Indicates the type is a constant buffer view (CBV).
    D3D12_INDIRECT_ARGUMENT_TYPE_CONSTANT_BUFFER_VIEW  = 0x00000006,
    ///Indicates the type is a shader resource view (SRV).
    D3D12_INDIRECT_ARGUMENT_TYPE_SHADER_RESOURCE_VIEW  = 0x00000007,
    ///Indicates the type is an unordered access view (UAV).
    D3D12_INDIRECT_ARGUMENT_TYPE_UNORDERED_ACCESS_VIEW = 0x00000008,
    D3D12_INDIRECT_ARGUMENT_TYPE_DISPATCH_RAYS         = 0x00000009,
    D3D12_INDIRECT_ARGUMENT_TYPE_DISPATCH_MESH         = 0x0000000a,
}

///Specifies the mode used by a <b>WriteBufferImmediate</b> operation.
alias D3D12_WRITEBUFFERIMMEDIATE_MODE = int;
enum : int
{
    ///The write operation behaves the same as normal copy-write operations.
    D3D12_WRITEBUFFERIMMEDIATE_MODE_DEFAULT    = 0x00000000,
    ///The write operation is guaranteed to occur after all preceding commands in the command stream have started,
    ///including previous <b>WriteBufferImmediate</b> operations.
    D3D12_WRITEBUFFERIMMEDIATE_MODE_MARKER_IN  = 0x00000001,
    ///The write operation is deferred until all previous commands in the command stream have completed through the GPU
    ///pipeline, including previous <b>WriteBufferImmediate</b> operations. Write operations that specify
    ///<b>D3D12_WRITEBUFFERIMMEDIATE_MODE_MARKER_OUT</b> don't block subsequent operations from starting. If there are
    ///no previous operations in the command stream, then the write operation behaves as if
    ///<b>D3D12_WRITEBUFFERIMMEDIATE_MODE_MARKER_IN</b> was specified.
    D3D12_WRITEBUFFERIMMEDIATE_MODE_MARKER_OUT = 0x00000002,
}

///Specifies multiple wait flags for multiple fences.
alias D3D12_MULTIPLE_FENCE_WAIT_FLAGS = int;
enum : int
{
    ///No flags are being passed. This means to use the default behavior, which is to wait for all fences before
    ///signaling the event.
    D3D12_MULTIPLE_FENCE_WAIT_FLAG_NONE = 0x00000000,
    ///Modifies behavior to indicate that the event should be signaled after any one of the fence values has been
    ///reached by its corresponding fence.
    D3D12_MULTIPLE_FENCE_WAIT_FLAG_ANY  = 0x00000001,
    ///An alias for **D3D12_MULTIPLE_FENCE_WAIT_FLAG_NONE**, meaning to use the default behavior and wait for all
    ///fences.
    D3D12_MULTIPLE_FENCE_WAIT_FLAG_ALL  = 0x00000000,
}

///Specifies broad residency priority buckets useful for quickly establishing an application priority scheme.
///Applications can assign priority values other than the five values present in this enumeration.
alias D3D12_RESIDENCY_PRIORITY = int;
enum : int
{
    ///Indicates a minimum priority.
    D3D12_RESIDENCY_PRIORITY_MINIMUM = 0x28000000,
    ///Indicates a low priority.
    D3D12_RESIDENCY_PRIORITY_LOW     = 0x50000000,
    ///Indicates a normal, medium, priority.
    D3D12_RESIDENCY_PRIORITY_NORMAL  = 0x78000000,
    ///Indicates a high priority. Applications are discouraged from using priories greater than this. For more
    ///information see ID3D12Device1::SetResidencyPriority.
    D3D12_RESIDENCY_PRIORITY_HIGH    = 0xa0010000,
    ///Indicates a maximum priority. Applications are discouraged from using priorities greater than this;
    ///<b>D3D12_RESIDENCY_PRIORITY_MAXIMUM</b> is not guaranteed to be available. For more information see
    ///ID3D12Device1::SetResidencyPriority
    D3D12_RESIDENCY_PRIORITY_MAXIMUM = 0xc8000000,
}

///Used with the EnqueuMakeResident function to choose how residency operations proceed when the memory budget is
///exceeded.
alias D3D12_RESIDENCY_FLAGS = int;
enum : int
{
    ///Specifies the default residency policy, which allows residency operations to succeed regardless of the
    ///application's current memory budget. EnqueueMakeResident returns E_OUTOFMEMORY only when there is no memory
    ///available.
    D3D12_RESIDENCY_FLAG_NONE            = 0x00000000,
    ///Specifies that the EnqueueMakeResident function should return E_OUTOFMEMORY when the residency operation would
    ///exceed the application's current memory budget.
    D3D12_RESIDENCY_FLAG_DENY_OVERBUDGET = 0x00000001,
}

///Specifies flags to be used when creating a command list.
alias D3D12_COMMAND_LIST_FLAGS = int;
enum : int
{
    ///No flags specified.
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

///Defines constants that specify protected session status.
alias D3D12_PROTECTED_SESSION_STATUS = int;
enum : int
{
    ///Indicates that the protected session is in a valid state.
    D3D12_PROTECTED_SESSION_STATUS_OK      = 0x00000000,
    ///Indicates that the protected session is not in a valid state.
    D3D12_PROTECTED_SESSION_STATUS_INVALID = 0x00000001,
}

///Defines constants that specify protected resource session support.
alias D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAGS = int;
enum : int
{
    ///Indicates that protected resource sessions are not supported.
    D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAG_NONE      = 0x00000000,
    ///Indicates that protected resource sessions are supported.
    D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAG_SUPPORTED = 0x00000001,
}

///Defines constants that specify protected resource session flags. These flags can be bitwise OR'd together to specify
///multiple flags at once.
alias D3D12_PROTECTED_RESOURCE_SESSION_FLAGS = int;
enum : int
{
    ///Specifies no flag.
    D3D12_PROTECTED_RESOURCE_SESSION_FLAG_NONE = 0x00000000,
}

///Defines constants that specify the lifetime state of a lifetime-tracked object.
alias D3D12_LIFETIME_STATE = int;
enum : int
{
    ///Specifies that the lifetime-tracked object is in use.
    D3D12_LIFETIME_STATE_IN_USE     = 0x00000000,
    ///Specifies that the lifetime-tracked object is not in use.
    D3D12_LIFETIME_STATE_NOT_IN_USE = 0x00000001,
}

///Defines constants that specify the data type of a parameter to a meta command.
alias D3D12_META_COMMAND_PARAMETER_TYPE = int;
enum : int
{
    ///Specifies that the parameter is of type FLOAT.
    D3D12_META_COMMAND_PARAMETER_TYPE_FLOAT                                       = 0x00000000,
    ///Specifies that the parameter is of type UINT64.
    D3D12_META_COMMAND_PARAMETER_TYPE_UINT64                                      = 0x00000001,
    ///Specifies that the parameter is a GPU virtual address.
    D3D12_META_COMMAND_PARAMETER_TYPE_GPU_VIRTUAL_ADDRESS                         = 0x00000002,
    ///Specifies that the parameter is a CPU descriptor handle to a heap containing either constant buffer views, shader
    ///resource views, or unordered access views.
    D3D12_META_COMMAND_PARAMETER_TYPE_CPU_DESCRIPTOR_HANDLE_HEAP_TYPE_CBV_SRV_UAV = 0x00000003,
    D3D12_META_COMMAND_PARAMETER_TYPE_GPU_DESCRIPTOR_HANDLE_HEAP_TYPE_CBV_SRV_UAV = 0x00000004,
}

///Defines constants that specify the flags for a parameter to a meta command. Values can be bitwise OR'd together.
alias D3D12_META_COMMAND_PARAMETER_FLAGS = int;
enum : int
{
    ///Specifies that the parameter is an input resource.
    D3D12_META_COMMAND_PARAMETER_FLAG_INPUT  = 0x00000001,
    D3D12_META_COMMAND_PARAMETER_FLAG_OUTPUT = 0x00000002,
}

///Defines constants that specify the stage of a parameter to a meta command.
alias D3D12_META_COMMAND_PARAMETER_STAGE = int;
enum : int
{
    ///Specifies that the parameter is used at the meta command creation stage.
    D3D12_META_COMMAND_PARAMETER_STAGE_CREATION       = 0x00000000,
    ///Specifies that the parameter is used at the meta command initialization stage.
    D3D12_META_COMMAND_PARAMETER_STAGE_INITIALIZATION = 0x00000001,
    D3D12_META_COMMAND_PARAMETER_STAGE_EXECUTION      = 0x00000002,
}

///Defines flags that specify states related to a graphics command list. Values can be bitwise OR'd together.
alias D3D12_GRAPHICS_STATES = int;
enum : int
{
    ///Specifies no state.
    D3D12_GRAPHICS_STATE_NONE                    = 0x00000000,
    ///Specifies the state of the vertex buffer bindings on the input assembler stage.
    D3D12_GRAPHICS_STATE_IA_VERTEX_BUFFERS       = 0x00000001,
    ///Specifies the state of the index buffer binding on the input assembler stage.
    D3D12_GRAPHICS_STATE_IA_INDEX_BUFFER         = 0x00000002,
    ///Specifies the state of the primitive topology value set on the input assembler stage.
    D3D12_GRAPHICS_STATE_IA_PRIMITIVE_TOPOLOGY   = 0x00000004,
    ///Specifies the state of the currently bound descriptor heaps.
    D3D12_GRAPHICS_STATE_DESCRIPTOR_HEAP         = 0x00000008,
    ///Specifies the state of the currently set graphics root signature.
    D3D12_GRAPHICS_STATE_GRAPHICS_ROOT_SIGNATURE = 0x00000010,
    ///Specifies the state of the currently set compute root signature.
    D3D12_GRAPHICS_STATE_COMPUTE_ROOT_SIGNATURE  = 0x00000020,
    ///Specifies the state of the viewports bound to the rasterizer stage.
    D3D12_GRAPHICS_STATE_RS_VIEWPORTS            = 0x00000040,
    ///Specifies the state of the scissor rectangles bound to the rasterizer stage.
    D3D12_GRAPHICS_STATE_RS_SCISSOR_RECTS        = 0x00000080,
    ///Specifies the predicate state.
    D3D12_GRAPHICS_STATE_PREDICATION             = 0x00000100,
    ///Specifies the state of the render targets bound to the output merger stage.
    D3D12_GRAPHICS_STATE_OM_RENDER_TARGETS       = 0x00000200,
    ///Specifies the state of the reference value for depth stencil tests set on the output merger stage.
    D3D12_GRAPHICS_STATE_OM_STENCIL_REF          = 0x00000400,
    ///Specifies the state of the blend factor set on the output merger stage.
    D3D12_GRAPHICS_STATE_OM_BLEND_FACTOR         = 0x00000800,
    ///Specifies the state of the pipeline state object.
    D3D12_GRAPHICS_STATE_PIPELINE_STATE          = 0x00001000,
    ///Specifies the state of the buffer views bound to the stream output stage.
    D3D12_GRAPHICS_STATE_SO_TARGETS              = 0x00002000,
    ///Specifies the state of the depth bounds set on the output merger stage.
    D3D12_GRAPHICS_STATE_OM_DEPTH_BOUNDS         = 0x00004000,
    ///Specifies the state of the sample positions.
    D3D12_GRAPHICS_STATE_SAMPLE_POSITIONS        = 0x00008000,
    D3D12_GRAPHICS_STATE_VIEW_INSTANCE_MASK      = 0x00010000,
}

///The type of a state subobject. Use with D3D12_STATE_SUBOBJECT.
alias D3D12_STATE_SUBOBJECT_TYPE = int;
enum : int
{
    ///Subobject type is D3D12_STATE_OBJECT_CONFIG.
    D3D12_STATE_SUBOBJECT_TYPE_STATE_OBJECT_CONFIG                   = 0x00000000,
    ///Subobject type is D3D12_GLOBAL_ROOT_SIGNATURE.
    D3D12_STATE_SUBOBJECT_TYPE_GLOBAL_ROOT_SIGNATURE                 = 0x00000001,
    ///Subobject type is D3D12_LOCAL_ROOT_SIGNATURE.
    D3D12_STATE_SUBOBJECT_TYPE_LOCAL_ROOT_SIGNATURE                  = 0x00000002,
    ///Subobject type is D3D12_NODE_MASK. > [!IMPORTANT] > On some versions of the DirectX Runtime, specifying a node
    ///via [**D3D12_NODE_MASK**](/windows/win32/api/d3d12/ns-d3d12-d3d12_node_mask) in a
    ///[**D3D12_STATE_SUBOBJECT**](/windows/win32/api/d3d12/ns-d3d12-d3d12_state_subobject) with type
    ///**D3D12_STATE_SUBOBJECT_TYPE_NODE_MASK**, the runtime will incorrectly handle a node mask value of `0`, which
    ///should use node
    D3D12_STATE_SUBOBJECT_TYPE_NODE_MASK                             = 0x00000003,
    ///Subobject type is D3D12_DXIL_LIBRARY_DESC.
    D3D12_STATE_SUBOBJECT_TYPE_DXIL_LIBRARY                          = 0x00000005,
    ///Subobject type is D3D12_EXISTING_COLLECTION_DESC.
    D3D12_STATE_SUBOBJECT_TYPE_EXISTING_COLLECTION                   = 0x00000006,
    ///Subobject type is D3D12_SUBOBJECT_TO_EXPORTS_ASSOCIATION.
    D3D12_STATE_SUBOBJECT_TYPE_SUBOBJECT_TO_EXPORTS_ASSOCIATION      = 0x00000007,
    ///Subobject type is D3D12_DXIL_SUBOBJECT_TO_EXPORTS_ASSOCIATION.
    D3D12_STATE_SUBOBJECT_TYPE_DXIL_SUBOBJECT_TO_EXPORTS_ASSOCIATION = 0x00000008,
    ///Subobject type is D3D12_RAYTRACING_SHADER_CONFIG.
    D3D12_STATE_SUBOBJECT_TYPE_RAYTRACING_SHADER_CONFIG              = 0x00000009,
    ///Subobject type is D3D12_RAYTRACING_PIPELINE_CONFIG.
    D3D12_STATE_SUBOBJECT_TYPE_RAYTRACING_PIPELINE_CONFIG            = 0x0000000a,
    ///Subobject type is D3D12_HIT_GROUP_DESC
    D3D12_STATE_SUBOBJECT_TYPE_HIT_GROUP                             = 0x0000000b,
    D3D12_STATE_SUBOBJECT_TYPE_RAYTRACING_PIPELINE_CONFIG1           = 0x0000000c,
    D3D12_STATE_SUBOBJECT_TYPE_MAX_VALID                             = 0x0000000d,
}

///Specifies constraints for state objects. Use values from this enumeration in the D3D12_STATE_OBJECT_CONFIG structure.
alias D3D12_STATE_OBJECT_FLAGS = int;
enum : int
{
    ///No state object constraints.
    D3D12_STATE_OBJECT_FLAG_NONE                                             = 0x00000000,
    ///This flag applies to state objects of type collection only. Otherwise this flag is ignored. The exports from this
    ///collection are allowed to have unresolved references (dependencies) that would have to be resolved (defined) when
    ///the collection is included in a containing state object, such as a raytracing pipeline state object (RTPSO). This
    ///includes depending on externally defined subobject associations to associate an external subobject (e.g. root
    ///signature) to a local export. In the absence of this flag, all exports in this collection must have their
    ///dependencies fully locally resolved, including any necessary subobject associations being defined locally.
    ///Advanced implementations/drivers will have enough information to compile the code in the collection and not need
    ///to keep around any uncompiled code (unless the
    ///<b>D3D12_STATE_OBJECT_FLAG_ALLOW_EXTERNAL_DEPENDENCIES_ON_LOCAL_DEFINITIONS</b> flag is set), so that when the
    ///collection is used in a containing state object (e.g. RTPSO), minimal work needs to be done by the driver,
    ///ideally a “cheap” link at most.
    D3D12_STATE_OBJECT_FLAG_ALLOW_LOCAL_DEPENDENCIES_ON_EXTERNAL_DEFINITIONS = 0x00000001,
    D3D12_STATE_OBJECT_FLAG_ALLOW_EXTERNAL_DEPENDENCIES_ON_LOCAL_DEFINITIONS = 0x00000002,
    D3D12_STATE_OBJECT_FLAG_ALLOW_STATE_OBJECT_ADDITIONS                     = 0x00000004,
}

///The flags to apply when exporting symbols from a state subobject.
alias D3D12_EXPORT_FLAGS = int;
enum : int
{
    ///No export flags.
    D3D12_EXPORT_FLAG_NONE = 0x00000000,
}

///Specifies the type of a raytracing hit group state subobject. Use a value from this enumeration with the
///D3D12_HIT_GROUP_DESC structure.
alias D3D12_HIT_GROUP_TYPE = int;
enum : int
{
    ///The hit group uses a list of triangles to calculate ray hits. Hit groups that use triangles can’t contain an
    ///intersection shader.
    D3D12_HIT_GROUP_TYPE_TRIANGLES            = 0x00000000,
    D3D12_HIT_GROUP_TYPE_PROCEDURAL_PRIMITIVE = 0x00000001,
}

alias D3D12_RAYTRACING_PIPELINE_FLAGS = int;
enum : int
{
    D3D12_RAYTRACING_PIPELINE_FLAG_NONE                       = 0x00000000,
    D3D12_RAYTRACING_PIPELINE_FLAG_SKIP_TRIANGLES             = 0x00000100,
    D3D12_RAYTRACING_PIPELINE_FLAG_SKIP_PROCEDURAL_PRIMITIVES = 0x00000200,
}

///Specifies the type of a state object. Use with D3D12_STATE_OBJECT_DESC.
alias D3D12_STATE_OBJECT_TYPE = int;
enum : int
{
    ///Collection state object.
    D3D12_STATE_OBJECT_TYPE_COLLECTION          = 0x00000000,
    D3D12_STATE_OBJECT_TYPE_RAYTRACING_PIPELINE = 0x00000003,
}

///Specifies flags for raytracing geometry in a D3D12_RAYTRACING_GEOMETRY_DESC structure.
alias D3D12_RAYTRACING_GEOMETRY_FLAGS = int;
enum : int
{
    ///No options specified.
    D3D12_RAYTRACING_GEOMETRY_FLAG_NONE                           = 0x00000000,
    ///When rays encounter this geometry, the geometry acts as if no any hit shader is present. It is recommended that
    ///apps use this flag liberally, as it can enable important ray-processing optimizations. Note that this behavior
    ///can be overridden on a per-instance basis with D3D12_RAYTRACING_INSTANCE_FLAGS and on a per-ray basis using ray
    ///flags in <b>TraceRay</b>.
    D3D12_RAYTRACING_GEOMETRY_FLAG_OPAQUE                         = 0x00000001,
    D3D12_RAYTRACING_GEOMETRY_FLAG_NO_DUPLICATE_ANYHIT_INVOCATION = 0x00000002,
}

///Specifies the type of geometry used for raytracing. Use a value from this enumeration to specify the geometry type in
///a D3D12_RAYTRACING_GEOMETRY_DESC.
alias D3D12_RAYTRACING_GEOMETRY_TYPE = int;
enum : int
{
    ///The geometry consists of triangles.
    D3D12_RAYTRACING_GEOMETRY_TYPE_TRIANGLES                  = 0x00000000,
    D3D12_RAYTRACING_GEOMETRY_TYPE_PROCEDURAL_PRIMITIVE_AABBS = 0x00000001,
}

///Flags for a raytracing acceleration structure instance. These flags can be used to override
///D3D12_RAYTRACING_GEOMETRY_FLAGS for individual instances.
alias D3D12_RAYTRACING_INSTANCE_FLAGS = int;
enum : int
{
    ///No options specified.
    D3D12_RAYTRACING_INSTANCE_FLAG_NONE                            = 0x00000000,
    ///Disables front/back face culling for this instance. The Ray flags <b>RAY_FLAG_CULL_BACK_FACING_TRIANGLES</b> and
    ///<b>RAY_FLAG_CULL_FRONT_FACING_TRIANGLES</b> will have no effect on this instance.
    D3D12_RAYTRACING_INSTANCE_FLAG_TRIANGLE_CULL_DISABLE           = 0x00000001,
    ///This flag reverses front and back facings, which is useful if the application’s natural winding order differs
    ///from the default. By default, a triangle is front facing if its vertices appear clockwise from the ray origin and
    ///back facing if its vertices appear counter-clockwise from the ray origin, in object space in a left-handed
    ///coordinate system. Since these winding direction rules are defined in object space, they are unaffected by
    ///instance transforms. For example, an instance transform matrix with negative determinant (e.g. mirroring some
    ///geometry) does not change the facing of the triangles within the instance. Per-geometry transforms defined in
    ///D3D12_RAYTRACING_GEOMETRY_TRIANGLES_DESC , by contrast, get combined with the associated vertex data in object
    ///space, so a negative determinant matrix there does flip triangle winding.
    D3D12_RAYTRACING_INSTANCE_FLAG_TRIANGLE_FRONT_COUNTERCLOCKWISE = 0x00000002,
    ///The instance will act as if D3D12_RAYTRACING_GEOMETRY_FLAG_OPAQUE had been specified for all the geometries in
    ///the bottom-level acceleration structure referenced by the instance. Note that this behavior can be overridden by
    ///the ray flag <b>RAY_FLAG_FORCE_NON_OPAQUE</b>. This flag is mutually exclusive to the
    ///<b>D3D12_RAYTRACING_INSTANCE_FLAG_FORCE_NON_OPAQUE</b> flag.
    D3D12_RAYTRACING_INSTANCE_FLAG_FORCE_OPAQUE                    = 0x00000004,
    D3D12_RAYTRACING_INSTANCE_FLAG_FORCE_NON_OPAQUE                = 0x00000008,
}

///Specifies flags for the build of a raytracing acceleration structure. Use a value from this enumeration with the
///D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS structure that provides input to the acceleration structure
///build operation.
alias D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS = int;
enum : int
{
    ///No options specified for the acceleration structure build.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_NONE              = 0x00000000,
    ///Build the acceleration structure such that it supports future updates (via the flag
    ///<b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PERFORM_UPDATE</b>) instead of the app having to entirely
    ///rebuild the structure. This option may result in increased memory consumption, build times, and lower raytracing
    ///performance. Future updates, however, should be faster than building the equivalent acceleration structure from
    ///scratch. This flag can only be set on an initial acceleration structure build, or on an update where the source
    ///acceleration structure specified <b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_UPDATE</b>. In other
    ///words, after an acceleration structure was been built without
    ///<b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_UPDATE</b>, no other acceleration structures can be
    ///created from it via updates.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_UPDATE      = 0x00000001,
    ///Enables the option to compact the acceleration structure by calling CopyRaytracingAccelerationStructure using
    ///compact mode, specified with D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_COMPACT. This option may result in
    ///increased memory consumption and build times. After future compaction, however, the resulting acceleration
    ///structure should consume a smaller memory footprint than building the acceleration structure from scratch. This
    ///flag is compatible with all other flags. If specified as part of an acceleration structure update, the source
    ///acceleration structure must have also been built with this flag. In other words, after an acceleration structure
    ///was been built without <b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_COMPACTION</b>, no other
    ///acceleration structures can be created from it via updates that specify
    ///<b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_COMPACTION</b>. Specifying ALLOW_COMPACTION may
    ///increase pre-compaction acceleration structure size versus not specifying ALLOW_COMPACTION. If multiple
    ///incremental builds are performed before finally compacting, there may be redundant compaction related work
    ///performed. The size required for the compacted acceleration structure can be queried before compaction via
    ///EmitRaytracingAccelerationStructurePostbuildInfo. See
    ///D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_COMPACTED_SIZE_DESC for more information on properties of
    ///compacted acceleration structure size. <div class="alert"><b>Note</b>
    ///When<b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_UPDATE</b> is specified, there is certain
    ///information that needs to be retained in the acceleration structure, and compaction will only help so much.
    ///However, if the pipeline knows that the acceleration structure will no longer be updated, it can make the
    ///structure more compact. Some apps may benefit from compacting twice - once after the initial build, and again
    ///after the acceleration structure has settled to a static state, if that occurs.</div> <div> </div>
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_COMPACTION  = 0x00000002,
    ///Construct a high quality acceleration structure that maximizes raytracing performance at the expense of
    ///additional build time. Typically, the implementation will take 2-3 times the build time than the default setting
    ///in order to get better tracing performance. This flag is recommended for static geometry in particular. It is
    ///compatible with all other flags except for
    ///<b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PREFER_FAST_BUILD</b>.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PREFER_FAST_TRACE = 0x00000004,
    ///Construct a lower quality acceleration structure, trading raytracing performance for build speed. Typically, the
    ///implementation will take 1/2 to 1/3 the build time than default setting, with a sacrifice in tracing performance.
    ///This flag is compatible with all other flags except for
    ///<b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PREFER_FAST_BUILD</b>.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PREFER_FAST_BUILD = 0x00000008,
    ///Minimize the amount of scratch memory used during the acceleration structure build as well as the size of the
    ///result. This option may result in increased build times and/or raytracing times. This is orthogonal to the
    ///<b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_COMPACTION</b> flag and the explicit acceleration
    ///structure compaction that it enables. Combining the flags can mean both the initial acceleration structure as
    ///well as the result of compacting it use less memory. The impact of using this flag for a build is reflected in
    ///the result of calling GetRaytracingAccelerationStructurePrebuildInfo before doing the build to retrieve memory
    ///requirements for the build. This flag is compatible with all other flags.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_MINIMIZE_MEMORY   = 0x00000010,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PERFORM_UPDATE    = 0x00000020,
}

///Specifies the type of copy operation performed when calling CopyRaytracingAccelerationStructure.
alias D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE = int;
enum : int
{
    ///Copy an acceleration structure while fixing any self-referential pointers that may be present so that the
    ///destination is a self-contained copy of the source. Any external pointers to other acceleration structures remain
    ///unchanged from source to destination in the copy. The size of the destination is identical to the size of the
    ///source. > [!IMPORTANT] > The source memory must be in state
    ///[**D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_resource_states).
    ///> The destination memory must be in state
    ///[**D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_resource_states).
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_CLONE                          = 0x00000000,
    ///Produces a functionally equivalent acceleration structure to source in the destination, similar to the clone
    ///mode, but also fits the destination into a potentially smaller, and certainly not larger, memory footprint. The
    ///size required for the destination can be retrieved beforehand from
    ///EmitRaytracingAccelerationStructurePostbuildInfo. This mode is only valid if the source acceleration structure
    ///was originally built with the D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_COMPACTION flag, otherwise
    ///results are undefined. Compacting geometry requires the entire acceleration structure to be constructed, which is
    ///why you must first build and then compact the structure. > [!IMPORTANT] > The source memory must be in state
    ///[**D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_resource_states).
    ///> The destination memory must be in state
    ///[**D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_resource_states).
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_COMPACT                        = 0x00000001,
    ///The destination is takes the layout described in
    ///D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_TOOLS_VISUALIZATION_HEADER. The size required for the destination
    ///can be retrieved beforehand from EmitRaytracingAccelerationStructurePostbuildInfo. This mode is only intended for
    ///tools such as PIX, though nothing stops any app from using it. The output is essentially the inverse of an
    ///acceleration structure build. This overall structure with is sufficient for tools/PIX to be able to give the
    ///application some visual sense of the acceleration structure the driver made out of the app’s input.
    ///Visualization can help reveal driver bugs in acceleration structures if what is shown grossly mismatches the data
    ///the application used to create the acceleration structure, beyond allowed tolerances. For top-level acceleration
    ///structures, the output includes a set of instance descriptions that are identical to the data used in the
    ///original build and in the same order. For bottom-level acceleration structures, the output includes a set of
    ///geometry descriptions roughly matching the data used in the original build. The output is only a rough match for
    ///the original in part because of the tolerances allowed in the specification for acceleration structures and in
    ///part due to the inherent complexity of reporting exactly the same structure as is conceptually encoded. For
    ///example. axis-aligned bounding boxes (AABBs) returned for procedural primitives could be more conservative
    ///(larger) in volume and even different in number than what is actually in the acceleration structure
    ///representation. Geometries, each with its own geometry description, appear in the same order as in the original
    ///acceleration, as shader table indexing calculations depend on this. > [!IMPORTANT] > The source memory must be in
    ///state
    ///[**D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_resource_states).
    ///> The destination memory must be in state
    ///[**D3D12_RESOURCE_STATE_UNORDERED_ACCESS**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_resource_states). This mode
    ///is only permitted when developer mode is enabled in the OS.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_VISUALIZATION_DECODE_FOR_TOOLS = 0x00000002,
    ///Destination takes the layout and size described in the documentation for
    ///D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_SERIALIZATION_DESC, itself a structure generated with a
    ///call to EmitRaytracingAccelerationStructurePostbuildInfo. This mode serializes an acceleration structure so that
    ///an app or tools can store it to a file for later reuse, typically on a different device instance, via
    ///deserialization. When serializing a top-level acceleration structure, the bottom-level acceleration structures it
    ///refers to do not have to still be present or intact in memory. Likewise, bottom-level acceleration structures can
    ///be serialized independent of whether any top-level acceleration structures are pointing to them. In other words,
    ///the order of serialization of acceleration structures doesn’t matter. > [!IMPORTANT] > The source memory must
    ///be in state
    ///[**D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_resource_states).
    ///> The destination memory must be in state
    ///[**D3D12_RESOURCE_STATE_UNORDERED_ACCESS**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_resource_states).
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_SERIALIZE                      = 0x00000003,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_DESERIALIZE                    = 0x00000004,
}

///Specifies the type of a raytracing acceleration structure.
alias D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE = int;
enum : int
{
    ///Top-level acceleration structure.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE_TOP_LEVEL    = 0x00000000,
    ///Bottom-level acceleration structure.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE_BOTTOM_LEVEL = 0x00000001,
}

///Describes how the locations of elements are identified.
alias D3D12_ELEMENTS_LAYOUT = int;
enum : int
{
    ///For a data set of <i>n</i> elements, the pointer parameter points to the start of <i>n</i> elements in memory.
    D3D12_ELEMENTS_LAYOUT_ARRAY             = 0x00000000,
    D3D12_ELEMENTS_LAYOUT_ARRAY_OF_POINTERS = 0x00000001,
}

///Specifies the type of acceleration structure post-build info that can be retrieved with calls to
///EmitRaytracingAccelerationStructurePostbuildInfo and BuildRaytracingAccelerationStructure.
alias D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TYPE = int;
enum : int
{
    ///The post-build info is space requirements for an acceleration structure after compaction. For more information,
    ///see D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_COMPACTED_SIZE_DESC.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_COMPACTED_SIZE      = 0x00000000,
    ///The post-build info is space requirements for generating tools visualization for an acceleration structure. For
    ///more information, see D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TOOLS_VISUALIZATION_DESC.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TOOLS_VISUALIZATION = 0x00000001,
    ///The post-build info is space requirements for serializing an acceleration structure. For more information, see
    ///D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_SERIALIZATION_DESC.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_SERIALIZATION       = 0x00000002,
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_CURRENT_SIZE        = 0x00000003,
}

///Specifies the type of serialized data. Use a value from this enumeration when calling
///ID3D12Device5::CheckDriverMatchingIdentifier.
alias D3D12_SERIALIZED_DATA_TYPE = int;
enum : int
{
    D3D12_SERIALIZED_DATA_RAYTRACING_ACCELERATION_STRUCTURE = 0x00000000,
}

///Specifies the result of a call to ID3D12Device5::CheckDriverMatchingIdentifier which queries whether serialized data
///is compatible with the current device and driver version.
alias D3D12_DRIVER_MATCHING_IDENTIFIER_STATUS = int;
enum : int
{
    ///Serialized data is compatible with the current device/driver.
    D3D12_DRIVER_MATCHING_IDENTIFIER_COMPATIBLE_WITH_DEVICE = 0x00000000,
    ///The specified D3D12_SERIALIZED_DATA_TYPE specified is unknown or unsupported.
    D3D12_DRIVER_MATCHING_IDENTIFIER_UNSUPPORTED_TYPE       = 0x00000001,
    ///Format of the data in D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER is unrecognized. This could indicate
    ///either corrupt data or the identifier was produced by a different hardware vendor.
    D3D12_DRIVER_MATCHING_IDENTIFIER_UNRECOGNIZED           = 0x00000002,
    ///Serialized data is recognized, but its version is not compatible with the current driver. This result may
    ///indicate that the device is from the same hardware vendor but is an incompatible version.
    D3D12_DRIVER_MATCHING_IDENTIFIER_INCOMPATIBLE_VERSION   = 0x00000003,
    D3D12_DRIVER_MATCHING_IDENTIFIER_INCOMPATIBLE_TYPE      = 0x00000004,
}

///Flags passed to the TraceRay function to override transparency, culling, and early-out behavior.
alias D3D12_RAY_FLAGS = int;
enum : int
{
    ///No options selected.
    D3D12_RAY_FLAG_NONE                            = 0x00000000,
    ///All ray-primitive intersections encountered in a raytrace are treated as opaque. So no any hit shaders will be
    ///executed regardless of whether or not the hit geometry specifies D3D12_RAYTRACING_GEOMETRY_FLAG_OPAQUE, and
    ///regardless of the instance flags on the instance that was hit. This flag is mutually exclusive with
    ///RAY_FLAG_FORCE_NON_OPAQUE, RAY_FLAG_CULL_OPAQUE and RAY_FLAG_CULL_NON_OPAQUE.
    D3D12_RAY_FLAG_FORCE_OPAQUE                    = 0x00000001,
    ///All ray-primitive intersections encountered in a raytrace are treated as non-opaque. So any hit shaders, if
    ///present, will be executed regardless of whether or not the hit geometry specifies
    ///D3D12_RAYTRACING_GEOMETRY_FLAG_OPAQUE, and regardless of the instance flags on the instance that was hit. This
    ///flag is mutually exclusive with RAY_FLAG_FORCE_\OPAQUE, RAY_FLAG_CULL_OPAQUE and RAY_FLAG_CULL_NON_OPAQUE.
    D3D12_RAY_FLAG_FORCE_NON_OPAQUE                = 0x00000002,
    ///The first ray-primitive intersection encountered in a raytrace automatically causes AcceptHitAndEndSearch to be
    ///called immediately after the any hit shader, including if there is no any hit shader. The only exception is when
    ///the preceding any hit shader calls IgnoreHit, in which case the ray continues unaffected such that the next hit
    ///becomes another candidate to be the first hit. For this exception to apply, the any hit shader has to actually be
    ///executed. So if the any hit shader is skipped because the hit is treated as opaque (e.g. due to
    ///RAY_FLAG_FORCE_OPAQUE or D3D12_RAYTRACING_GEOMETRY_FLAG_OPAQUE or D3D12_RAYTRACING_INSTANCE_FLAG_OPAQUE being
    ///set), then <b>AcceptHitAndEndSearch</b> is called. If a closest hit shader is present at the first hit, it gets
    ///invoked unless RAY_FLAG_SKIP_CLOSEST_HIT_SHADER is also present. The one hit that was found is considered
    ///“closest”, even though other potential hits that might be closer on the ray may not have been visited. A
    ///typical use for this flag is for shadows, where only a single hit needs to be found.
    D3D12_RAY_FLAG_ACCEPT_FIRST_HIT_AND_END_SEARCH = 0x00000004,
    ///Even if at least one hit has been committed, and the hit group for the closest hit contains a closest hit shader,
    ///skip execution of that shader.
    D3D12_RAY_FLAG_SKIP_CLOSEST_HIT_SHADER         = 0x00000008,
    ///Enables culling of back facing triangles. See D3D12_RAYTRACING_INSTANCE_FLAGS for selecting which triangles are
    ///back facing, per-instance. On instances that specify D3D12_RAYTRACING_INSTANCE_FLAG_TRIANGLE_CULL_DISABLE, this
    ///flag has no effect. On geometry types other than D3D12_RAYTRACING_GEOMETRY_TYPE_TRIANGLES, this flag has no
    ///effect. This flag is mutually exclusive with RAY_FLAG_CULL_FRONT_FACING_TRIANGLES.
    D3D12_RAY_FLAG_CULL_BACK_FACING_TRIANGLES      = 0x00000010,
    ///Enables culling of front facing triangles. See D3D12_RAYTRACING_INSTANCE_FLAGS for selecting which triangles are
    ///back facing, per-instance. On instances that specify D3D12_RAYTRACING_INSTANCE_FLAG_TRIANGLE_CULL_DISABLE, this
    ///flag has no effect. On geometry types other than D3D12_RAYTRACING_GEOMETRY_TYPE_TRIANGLES, this flag has no
    ///effect. This flag is mutually exclusive with RAY_FLAG_CULL_FRONT_FACING_TRIANGLES.
    D3D12_RAY_FLAG_CULL_FRONT_FACING_TRIANGLES     = 0x00000020,
    ///Culls all primitives that are considered opaque based on their geometry and instance flags. This flag is mutually
    ///exclusive with RAY_FLAG_FORCE_OPAQUE, RAY_FLAG_FORCE_NON_OPAQUE, and RAY_FLAG_CULL_NON_OPAQUE.
    D3D12_RAY_FLAG_CULL_OPAQUE                     = 0x00000040,
    D3D12_RAY_FLAG_CULL_NON_OPAQUE                 = 0x00000080,
    D3D12_RAY_FLAG_SKIP_TRIANGLES                  = 0x00000100,
    D3D12_RAY_FLAG_SKIP_PROCEDURAL_PRIMITIVES      = 0x00000200,
}

alias D3D12_HIT_KIND = int;
enum : int
{
    D3D12_HIT_KIND_TRIANGLE_FRONT_FACE = 0x000000fe,
    D3D12_HIT_KIND_TRIANGLE_BACK_FACE  = 0x000000ff,
}

///Defines constants that specify render/compute GPU operations.
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
}

///Defines constants that specify a version of Device Removed Extended Data (DRED), as used by the
///[D3D12_VERSIONED_DEVICE_REMOVED_EXTENDED_DATA structure](ns-d3d12-d3d12_versioned_device_removed_extended_data.md).
alias D3D12_DRED_VERSION = int;
enum : int
{
    ///Specifies DRED version 1.0.
    D3D12_DRED_VERSION_1_0 = 0x00000001,
    ///Specifies DRED version 1.1.
    D3D12_DRED_VERSION_1_1 = 0x00000002,
    D3D12_DRED_VERSION_1_2 = 0x00000003,
}

///> [!NOTE] > As of Windows 10, version 1903, **D3D12_DRED_FLAGS** is deprecated, and it may not be available in future
///versions of Windows. Defines constants used in the [D3D12_DEVICE_REMOVED_EXTENDED_DATA
///structure](ns-d3d12-d3d12_device_removed_extended_data.md) to specify control flags for the Direct3D runtime. Values
///can be bitwise OR'd together.
alias D3D12_DRED_FLAGS = int;
enum : int
{
    ///Typically specifies that Device Removed Extended Data (DRED) is disabled, except for when user-initiated feedback
    ///is used to produce a repro, or when otherwise enabled by Windows via automatic detection of process-instability
    ///issues. This is the default value.
    D3D12_DRED_FLAG_NONE                    = 0x00000000,
    ///Forces DRED to be enabled, regardless of the system state.
    D3D12_DRED_FLAG_FORCE_ENABLE            = 0x00000001,
    ///Disables DRED auto breadcrumbs.
    D3D12_DRED_FLAG_DISABLE_AUTOBREADCRUMBS = 0x00000002,
}

///Defines constants (used by the [ID3D12DeviceRemovedExtendedDataSettings
///interface](nn-d3d12-id3d12deviceremovedextendeddatasettings.md)) that specify how individual Device Removed Extended
///Data (DRED) features are enabled. As of DRED version 1.1, the default value for all settings is
///**D3D12_DRED_ENABLEMENT_SYSTEM_CONTROLLED**.
alias D3D12_DRED_ENABLEMENT = int;
enum : int
{
    ///Specifies that a DRED feature is enabled only when DRED is turned on by the system automatically (for example,
    ///when a user is reproducing a problem via FeedbackHub).
    D3D12_DRED_ENABLEMENT_SYSTEM_CONTROLLED = 0x00000000,
    ///Specifies that a DRED feature should be force-disabled, regardless of the system state.
    D3D12_DRED_ENABLEMENT_FORCED_OFF        = 0x00000001,
    ///Specifies that a DRED feature should be force-enabled, regardless of the system state.
    D3D12_DRED_ENABLEMENT_FORCED_ON         = 0x00000002,
}

///Congruent with, and numerically equivalent to, [3D12DDI_HANDLETYPE
///enumeration](/windows-hardware/drivers/ddi/content/d3d12umddi/ne-d3d12umddi-d3d12ddi_handletype) values.
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
    D3D12_DRED_ALLOCATION_TYPE_INVALID                  = 0xffffffff,
}

///Defines constants that specify a level of dynamic optimization to apply to GPU work that's subsequently submitted.
alias D3D12_BACKGROUND_PROCESSING_MODE = int;
enum : int
{
    ///The default setting. Specifies that the driver may instrument workloads, and dynamically recompile shaders, in a
    ///low overhead, non-intrusive manner that avoids glitching the foreground workload.
    D3D12_BACKGROUND_PROCESSING_MODE_ALLOWED                      = 0x00000000,
    ///Specifies that the driver may instrument as aggressively as possible. The understanding is that causing glitches
    ///is fine while in this mode, because the current work is being submitted specifically to train the system.
    D3D12_BACKGROUND_PROCESSING_MODE_ALLOW_INTRUSIVE_MEASUREMENTS = 0x00000001,
    ///Specifies that background work should stop. This ensures that background shader recompilation won't consume CPU
    ///cycles. Available only in <b>Developer mode</b>.
    D3D12_BACKGROUND_PROCESSING_MODE_DISABLE_BACKGROUND_WORK      = 0x00000002,
    ///Specifies that all dynamic optimization should be disabled. For example, if you're doing an A/B performance
    ///comparison, then using this constant ensures that the driver doesn't change anything that might interfere with
    ///your results. Available only in <b>Developer mode</b>.
    D3D12_BACKGROUND_PROCESSING_MODE_DISABLE_PROFILING_BY_SYSTEM  = 0x00000003,
}

///Defines constants that specify what should be done with the results of earlier workload instrumentation.
alias D3D12_MEASUREMENTS_ACTION = int;
enum : int
{
    ///The default setting. Specifies that all results should be kept.
    D3D12_MEASUREMENTS_ACTION_KEEP_ALL                     = 0x00000000,
    ///Specifies that the driver has seen all the data that it's ever going to, so it should stop waiting for more and
    ///go ahead compiling optimized shaders.
    D3D12_MEASUREMENTS_ACTION_COMMIT_RESULTS               = 0x00000001,
    ///Like <b>D3D12_MEASUREMENTS_ACTION_COMMIT_RESULTS</b>, but also specifies that your application doesn't care about
    ///glitches, so the runtime should ignore the usual idle priority rules and go ahead using as many threads as
    ///possible to get shader recompiles done fast. Available only in <b>Developer mode</b>.
    D3D12_MEASUREMENTS_ACTION_COMMIT_RESULTS_HIGH_PRIORITY = 0x00000002,
    ///Specifies that the optimization state should be reset; hinting that whatever has previously been measured no
    ///longer applies.
    D3D12_MEASUREMENTS_ACTION_DISCARD_PREVIOUS             = 0x00000003,
}

///Specifies the type of access that an application is given to the specified resource(s) at the transition into a
///render pass.
alias D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE = int;
enum : int
{
    ///Indicates that your application doesn't have any dependency on the prior contents of the resource(s). You also
    ///shouldn't have any expectations about those contents, because a display driver may return the previously-written
    ///contents, or it may return uninitialized data. You can be assured that reading from the resource(s) won't hang
    ///the GPU, even if you do get undefined data back. A read is defined as a traditional read from an unordered access
    ///view (UAV), a shader resource view (SRV), a constant buffer view (CBV), a vertex buffer view (VBV), an index
    ///buffer view (IBV), an IndirectArg binding/read, or a blend/depth-testing-induced read.
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_DISCARD   = 0x00000000,
    ///Indicates that your application has a dependency on the prior contents of the resource(s), so the contents must
    ///be loaded from main memory.
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_PRESERVE  = 0x00000001,
    ///Indicates that your application needs the resource(s) to be cleared to a specific value (a value that your
    ///application specifies). This clear occurs whether or not you interact with the resource(s) during the render
    ///pass. You specify the clear value at BeginRenderPass time, in the <b>Clear</b> member of your
    ///D3D12_RENDER_PASS_BEGINNING_ACCESS structure.
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_CLEAR     = 0x00000002,
    ///Indicates that your application will neither read from nor write to the resource(s) during the render pass. You
    ///would most likely use this value to indicate that you won't be accessing the depth/stencil plane for a
    ///depth/stencil view (DSV). You must pair this value with D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_NO_ACCESS in the
    ///corresponding D3D12_RENDER_PASS_ENDING_ACCESS structure.
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_NO_ACCESS = 0x00000003,
}

///Specifies the type of access that an application is given to the specified resource(s) at the transition out of a
///render pass.
alias D3D12_RENDER_PASS_ENDING_ACCESS_TYPE = int;
enum : int
{
    ///Indicates that your application won't have any future dependency on any data that you wrote to the resource(s)
    ///during this render pass. For example, a depth buffer that won't be textured from before it's written to again.
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_DISCARD   = 0x00000000,
    ///Indicates that your application will have a dependency on the written contents of the resource(s) in the future,
    ///and so they must be preserved.
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_PRESERVE  = 0x00000001,
    ///Indicates that the resource(s)—for example, a multi-sample anti-aliasing (MSAA) surface—should be directly
    ///resolved to a separate resource at the conclusion of the render pass. For a tile-based deferred renderer (TBDR),
    ///this should ideally happenwhile the MSAA contents are still in the tile cache. You should ensure that the resolve
    ///destination is in the D3D12_RESOURCE_STATE_RESOLVE_DEST resource state when the render pass ends. The resolve
    ///source is left in its initial resource state at the time the render pass ends. A resolve operation submitted by a
    ///render pass doesn't implicitly change the state of any resource.
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_RESOLVE   = 0x00000002,
    ///Indicates that your application will neither read from nor write to the resource(s) during the render pass. You
    ///would most likely use this value to indicate that you won't be accessing the depth/stencil plane for a
    ///depth/stencil view (DSV). You must pair this value with D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE_NO_ACCESS in the
    ///corresponding D3D12_RENDER_PASS_BEGINNING_ACCESS structure.
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE_NO_ACCESS = 0x00000003,
}

///Specifies the nature of the render pass; for example, whether it is a suspending or a resuming render pass.
alias D3D12_RENDER_PASS_FLAGS = int;
enum : int
{
    ///Indicates that the render pass has no special requirements.
    D3D12_RENDER_PASS_FLAG_NONE             = 0x00000000,
    ///Indicates that writes to unordered access view(s) should be allowed during the render pass.
    D3D12_RENDER_PASS_FLAG_ALLOW_UAV_WRITES = 0x00000001,
    ///Indicates that this is a suspending render pass.
    D3D12_RENDER_PASS_FLAG_SUSPENDING_PASS  = 0x00000002,
    ///Indicates that this is a resuming render pass.
    D3D12_RENDER_PASS_FLAG_RESUMING_PASS    = 0x00000004,
}

///Describes the level of GPU-based validation to perform at runtime.
alias D3D12_GPU_BASED_VALIDATION_FLAGS = int;
enum : int
{
    ///Default behavior; resource states, descriptors, and descriptor tables are all validated.
    D3D12_GPU_BASED_VALIDATION_FLAGS_NONE                   = 0x00000000,
    ///When set, GPU-based validation does not perform resource state validation which greatly reduces the performance
    ///cost of GPU-based validtion. Descriptors and descriptor heaps are still validated.
    D3D12_GPU_BASED_VALIDATION_FLAGS_DISABLE_STATE_TRACKING = 0x00000001,
}

///Specifies options for the amount of information to report about a live device object's lifetime.
alias D3D12_RLDO_FLAGS = int;
enum : int
{
    D3D12_RLDO_NONE            = 0x00000000,
    ///Obtain a summary about a live device object's lifetime.
    D3D12_RLDO_SUMMARY         = 0x00000001,
    ///Obtain detailed information about a live device object's lifetime.
    D3D12_RLDO_DETAIL          = 0x00000002,
    ///This flag indicates to ignore objects which have no external refcounts keeping them alive. D3D objects are
    ///printed using an external refcount and an internal refcount. Typically, all objects are printed. This flag means
    ///ignore the objects whose external refcount is 0, because the application is not responsible for keeping them
    ///alive.
    D3D12_RLDO_IGNORE_INTERNAL = 0x00000004,
}

///Specifies the data type of the memory pointed to by the <i>pData</i> parameter of
///ID3D12DebugDevice1::SetDebugParameter and ID3D12DebugDevice1::GetDebugParameter.
alias D3D12_DEBUG_DEVICE_PARAMETER_TYPE = int;
enum : int
{
    ///Indicates <i>pData</i> points to a D3D12_DEBUG_FEATURE value.
    D3D12_DEBUG_DEVICE_PARAMETER_FEATURE_FLAGS                   = 0x00000000,
    ///Indicates <i>pData</i> points to a D3D12_DEBUG_DEVICE_GPU_BASED_VALIDATION_SETTINGS structure.
    D3D12_DEBUG_DEVICE_PARAMETER_GPU_BASED_VALIDATION_SETTINGS   = 0x00000001,
    ///Indicates <i>pData</i> points to a D3D12_DEBUG_DEVICE_GPU_SLOWDOWN_PERFORMANCE_FACTOR structure.
    D3D12_DEBUG_DEVICE_PARAMETER_GPU_SLOWDOWN_PERFORMANCE_FACTOR = 0x00000002,
}

///Flags for optional D3D12 Debug Layer features.
alias D3D12_DEBUG_FEATURE = int;
enum : int
{
    ///The default. No optional Debug Layer features.
    D3D12_DEBUG_FEATURE_NONE                                   = 0x00000000,
    ///The Debug Layer is allowed to deliberately change functional behavior of an application in order to help identify
    ///potential errors. By default, the Debug Layer allows most invalid API usage to run the natural course.
    D3D12_DEBUG_FEATURE_ALLOW_BEHAVIOR_CHANGING_DEBUG_AIDS     = 0x00000001,
    ///Performs additional resource state validation of resources set in descriptors at the time
    ///ID3D12CommandQueue::ExecuteCommandLists is called. By design descriptors can be changed even after submitting
    ///command lists assuming proper synchronization. Conservative resource state tracking ignores this allowance and
    ///validates all resources used in descriptor tables when <b>ExecuteCommandLists</b> is called. The result may be
    ///false validation errors.
    D3D12_DEBUG_FEATURE_CONSERVATIVE_RESOURCE_STATE_TRACKING   = 0x00000002,
    ///Disables validation of bundle commands by virtually injecting checks into the calling command list validation
    ///paths.
    D3D12_DEBUG_FEATURE_DISABLE_VIRTUALIZED_BUNDLES_VALIDATION = 0x00000004,
    D3D12_DEBUG_FEATURE_EMULATE_WINDOWS7                       = 0x00000008,
}

///Specifies the type of shader patching used by GPU-Based Validation at either the device or command list level.
alias D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE = int;
enum : int
{
    ///No shader patching is to be done. This will retain the original shader bytecode. Can lead to errors in some of
    ///the GPU-Based Validation state tracking as the unpatched shader may still change resource state (see Common state
    ///promotion) but the promotion will be untracked without patching the shader. This can improve performance but no
    ///validation will be performed and may also lead to misleading GPU-Based Validation errors. Use this mode very
    ///carefully.
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_NONE                 = 0x00000000,
    ///Shaders can be patched with resource state tracking code but no validation. This may improve performance but no
    ///validation will be performed.
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_STATE_TRACKING_ONLY  = 0x00000001,
    ///The default. Shaders are patched with validation code but erroneous instructions will still be executed.
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_UNGUARDED_VALIDATION = 0x00000002,
    ///Shaders are patched with validation code and erroneous instructions are skipped in execution. This can help avoid
    ///crashes or device removal.
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_GUARDED_VALIDATION   = 0x00000003,
    ///Unused, simply the count of the number of modes.
    NUM_D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODES                 = 0x00000004,
}

///Specifies how GPU-Based Validation handles patched pipeline states during ID3D12Device::CreateGraphicsPipelineState
///and ID3D12Device::CreateComputePipelineState.
alias D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS = int;
enum : int
{
    ///This is the default value. Indicates no patching of pipeline states should be done during PSO creation. Instead
    ///PSO’s are patched on first use in a command list. This can help to reduce the up-front cost of PSO creation but
    ///may instead slow down command list recording until a steady-state is reached.
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_NONE                                           = 0x00000000,
    ///Indicates that state-tracking GPU-Based Validation PSO’s should be created along with the original PSO at
    ///create time.
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_FRONT_LOAD_CREATE_TRACKING_ONLY_SHADERS        = 0x00000001,
    ///Indicates that unguarded GPU-Based Validation PSO’s should be created along with the original PSO at create
    ///time.
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_FRONT_LOAD_CREATE_UNGUARDED_VALIDATION_SHADERS = 0x00000002,
    ///Indicates that guarded GPU-Based Validation PSO’s should be created along with the original PSO at create time.
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_FRONT_LOAD_CREATE_GUARDED_VALIDATION_SHADERS   = 0x00000004,
    ///Internal use only.
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS_VALID_MASK                                    = 0x00000007,
}

///Indicates the debug parameter type used by ID3D12DebugCommandList1::SetDebugParameter and
///ID3D12DebugCommandList1::GetDebugParameter.
alias D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE = int;
enum : int
{
    ///Indicates the parameter is type D3D12_DEBUG_COMMAND_LIST_GPU_BASED_VALIDATION_SETTINGS.
    D3D12_DEBUG_COMMAND_LIST_PARAMETER_GPU_BASED_VALIDATION_SETTINGS = 0x00000000,
}

///Specifies categories of debug messages. This will identify the category of a message when retrieving a message with
///ID3D12InfoQueue::GetMessage and when adding a message with ID3D12InfoQueue::AddMessage. When creating an info queue
///filter, these values can be used to allow or deny any categories of messages to pass through the storage and
///retrieval filters.
alias D3D12_MESSAGE_CATEGORY = int;
enum : int
{
    ///Indicates a user defined message, see ID3D12InfoQueue::AddMessage.
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

///Debug message severity levels for an information queue.
alias D3D12_MESSAGE_SEVERITY = int;
enum : int
{
    ///Indicates a corruption error.
    D3D12_MESSAGE_SEVERITY_CORRUPTION = 0x00000000,
    ///Indicates an error.
    D3D12_MESSAGE_SEVERITY_ERROR      = 0x00000001,
    ///Indicates a warning.
    D3D12_MESSAGE_SEVERITY_WARNING    = 0x00000002,
    ///Indicates an information message.
    D3D12_MESSAGE_SEVERITY_INFO       = 0x00000003,
    ///Indicates a message other than corruption, error, warning or information.
    D3D12_MESSAGE_SEVERITY_MESSAGE    = 0x00000004,
}

///Specifies debug message IDs for setting up an info-queue filter (see D3D12_INFO_QUEUE_FILTER); use these messages to
///allow or deny message categories to pass through the storage and retrieval filters. These IDs are used by methods
///such as ID3D12InfoQueue::GetMessage or ID3D12InfoQueue::AddMessage.
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
    D3D12_MESSAGE_ID_D3D12_MESSAGES_END                                                                            = 0x00000500,
}

///Defines constants that specify the shading rate (for variable-rate shading, or VRS) along a horizontal or vertical
///axis. For more info, see [Variable-rate shading (VRS)](/windows/desktop/direct3d12/vrs).
alias D3D12_AXIS_SHADING_RATE = int;
enum : int
{
    ///Specifies a 1x shading rate for the axis.
    D3D12_AXIS_SHADING_RATE_1X = 0x00000000,
    ///Specifies a 2x shading rate for the axis.
    D3D12_AXIS_SHADING_RATE_2X = 0x00000001,
    ///Specifies a 4x shading rate for the axis.
    D3D12_AXIS_SHADING_RATE_4X = 0x00000002,
}

///Defines constants that specify the shading rate (for variable-rate shading, or VRS). For more info, see
///[Variable-rate shading (VRS)](/windows/desktop/direct3d12/vrs).
alias D3D12_SHADING_RATE = int;
enum : int
{
    ///Specifies no change to the shading rate.
    D3D12_SHADING_RATE_1X1 = 0x00000000,
    ///Specifies that the shading rate should reduce vertical resolution 2x.
    D3D12_SHADING_RATE_1X2 = 0x00000001,
    ///Specifies that the shading rate should reduce horizontal resolution 2x.
    D3D12_SHADING_RATE_2X1 = 0x00000004,
    ///Specifies that the shading rate should reduce the resolution of both axes 2x.
    D3D12_SHADING_RATE_2X2 = 0x00000005,
    ///Specifies that the shading rate should reduce horizontal resolution 2x, and reduce vertical resolution 4x.
    D3D12_SHADING_RATE_2X4 = 0x00000006,
    ///Specifies that the shading rate should reduce horizontal resolution 4x, and reduce vertical resolution 2x.
    D3D12_SHADING_RATE_4X2 = 0x00000009,
    ///Specifies that the shading rate should reduce the resolution of both axes 4x.
    D3D12_SHADING_RATE_4X4 = 0x0000000a,
}

///Defines constants that specify a shading rate combiner (for variable-rate shading, or VRS). For more info, see
///[Variable-rate shading (VRS)](/windows/desktop/direct3d12/vrs).
alias D3D12_SHADING_RATE_COMBINER = int;
enum : int
{
    ///Specifies the combiner `C.xy = A.xy`, for combiner (C) and inputs (A and B).
    D3D12_SHADING_RATE_COMBINER_PASSTHROUGH = 0x00000000,
    ///Specifies the combiner `C.xy = B.xy`, for combiner (C) and inputs (A and B).
    D3D12_SHADING_RATE_COMBINER_OVERRIDE    = 0x00000001,
    ///Specifies the combiner `C.xy = max(A.xy, B.xy)`, for combiner (C) and inputs (A and B).
    D3D12_SHADING_RATE_COMBINER_MIN         = 0x00000002,
    ///Specifies the combiner `C.xy = min(A.xy, B.xy)`, for combiner (C) and inputs (A and B).
    D3D12_SHADING_RATE_COMBINER_MAX         = 0x00000003,
    ///Specifies the combiner C.xy = min(maxRate, A.xy + B.xy)`, for combiner (C) and inputs (A and B).
    D3D12_SHADING_RATE_COMBINER_SUM         = 0x00000004,
}

///Enumerates the types of shaders that Direct3D recognizes. Used to encode the <b>Version</b> member of the
///D3D12_SHADER_DESC structure.
alias D3D12_SHADER_VERSION_TYPE = int;
enum : int
{
    ///Pixel shader.
    D3D12_SHVER_PIXEL_SHADER    = 0x00000000,
    ///Vertex shader.
    D3D12_SHVER_VERTEX_SHADER   = 0x00000001,
    ///Geometry shader.
    D3D12_SHVER_GEOMETRY_SHADER = 0x00000002,
    ///Hull shader.
    D3D12_SHVER_HULL_SHADER     = 0x00000003,
    ///Domain shader.
    D3D12_SHVER_DOMAIN_SHADER   = 0x00000004,
    ///Compute shader.
    D3D12_SHVER_COMPUTE_SHADER  = 0x00000005,
    ///Indicates the end of the enumeration.
    D3D12_SHVER_RESERVED0       = 0x0000fff0,
}

// Constants


enum uint D3D12_16BIT_INDEX_STRIP_CUT_VALUE = 0x0000ffff;
enum uint D3D12_8BIT_INDEX_STRIP_CUT_VALUE = 0x000000ff;
enum uint D3D12_ARRAY_AXIS_ADDRESS_RANGE_BIT_COUNT = 0x00000009;
enum uint D3D12_CLIP_OR_CULL_DISTANCE_ELEMENT_COUNT = 0x00000002;

enum : uint
{
    D3D12_COMMONSHADER_CONSTANT_BUFFER_COMPONENTS                            = 0x00000004,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_COMPONENT_BIT_COUNT                   = 0x00000020,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_HW_SLOT_COUNT                         = 0x0000000f,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_PARTIAL_UPDATE_EXTENTS_BYTE_ALIGNMENT = 0x00000010,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_REGISTER_COMPONENTS                   = 0x00000004,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_REGISTER_COUNT                        = 0x0000000f,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_REGISTER_READS_PER_INST               = 0x00000001,
    D3D12_COMMONSHADER_CONSTANT_BUFFER_REGISTER_READ_PORTS                   = 0x00000001,
}

enum : uint
{
    D3D12_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_COMPONENTS     = 0x00000004,
    D3D12_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_COUNT          = 0x00000001,
    D3D12_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_READS_PER_INST = 0x00000001,
    D3D12_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_READ_PORTS     = 0x00000001,
    D3D12_COMMONSHADER_IMMEDIATE_VALUE_COMPONENT_BIT_COUNT               = 0x00000020,
}

enum : uint
{
    D3D12_COMMONSHADER_INPUT_RESOURCE_REGISTER_COUNT          = 0x00000080,
    D3D12_COMMONSHADER_INPUT_RESOURCE_REGISTER_READS_PER_INST = 0x00000001,
    D3D12_COMMONSHADER_INPUT_RESOURCE_REGISTER_READ_PORTS     = 0x00000001,
    D3D12_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT              = 0x00000080,
    D3D12_COMMONSHADER_SAMPLER_REGISTER_COMPONENTS            = 0x00000001,
    D3D12_COMMONSHADER_SAMPLER_REGISTER_COUNT                 = 0x00000010,
    D3D12_COMMONSHADER_SAMPLER_REGISTER_READS_PER_INST        = 0x00000001,
    D3D12_COMMONSHADER_SAMPLER_REGISTER_READ_PORTS            = 0x00000001,
    D3D12_COMMONSHADER_SAMPLER_SLOT_COUNT                     = 0x00000010,
    D3D12_COMMONSHADER_SUBROUTINE_NESTING_LIMIT               = 0x00000020,
    D3D12_COMMONSHADER_TEMP_REGISTER_COMPONENTS               = 0x00000004,
    D3D12_COMMONSHADER_TEMP_REGISTER_COMPONENT_BIT_COUNT      = 0x00000020,
    D3D12_COMMONSHADER_TEMP_REGISTER_COUNT                    = 0x00001000,
    D3D12_COMMONSHADER_TEMP_REGISTER_READS_PER_INST           = 0x00000003,
    D3D12_COMMONSHADER_TEMP_REGISTER_READ_PORTS               = 0x00000003,
    D3D12_COMMONSHADER_TEXCOORD_RANGE_REDUCTION_MAX           = 0x0000000a,
}

enum int D3D12_COMMONSHADER_TEXEL_OFFSET_MAX_NEGATIVE = 0xfffffff8;
enum uint D3D12_CONSTANT_BUFFER_DATA_PLACEMENT_ALIGNMENT = 0x00000100;

enum : uint
{
    D3D12_CS_4_X_BUCKET00_MAX_NUM_THREADS_PER_GROUP          = 0x00000040,
    D3D12_CS_4_X_BUCKET01_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000f0,
    D3D12_CS_4_X_BUCKET01_MAX_NUM_THREADS_PER_GROUP          = 0x00000044,
    D3D12_CS_4_X_BUCKET02_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000e0,
    D3D12_CS_4_X_BUCKET02_MAX_NUM_THREADS_PER_GROUP          = 0x00000048,
    D3D12_CS_4_X_BUCKET03_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000d0,
    D3D12_CS_4_X_BUCKET03_MAX_NUM_THREADS_PER_GROUP          = 0x0000004c,
    D3D12_CS_4_X_BUCKET04_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000c0,
    D3D12_CS_4_X_BUCKET04_MAX_NUM_THREADS_PER_GROUP          = 0x00000054,
    D3D12_CS_4_X_BUCKET05_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000b0,
    D3D12_CS_4_X_BUCKET05_MAX_NUM_THREADS_PER_GROUP          = 0x0000005c,
    D3D12_CS_4_X_BUCKET06_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x000000a0,
    D3D12_CS_4_X_BUCKET06_MAX_NUM_THREADS_PER_GROUP          = 0x00000064,
    D3D12_CS_4_X_BUCKET07_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000090,
    D3D12_CS_4_X_BUCKET07_MAX_NUM_THREADS_PER_GROUP          = 0x00000070,
    D3D12_CS_4_X_BUCKET08_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000080,
    D3D12_CS_4_X_BUCKET08_MAX_NUM_THREADS_PER_GROUP          = 0x00000080,
    D3D12_CS_4_X_BUCKET09_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000070,
    D3D12_CS_4_X_BUCKET09_MAX_NUM_THREADS_PER_GROUP          = 0x00000090,
    D3D12_CS_4_X_BUCKET10_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000060,
    D3D12_CS_4_X_BUCKET10_MAX_NUM_THREADS_PER_GROUP          = 0x000000a8,
    D3D12_CS_4_X_BUCKET11_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000050,
    D3D12_CS_4_X_BUCKET11_MAX_NUM_THREADS_PER_GROUP          = 0x000000cc,
    D3D12_CS_4_X_BUCKET12_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000040,
    D3D12_CS_4_X_BUCKET12_MAX_NUM_THREADS_PER_GROUP          = 0x00000100,
    D3D12_CS_4_X_BUCKET13_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000030,
    D3D12_CS_4_X_BUCKET13_MAX_NUM_THREADS_PER_GROUP          = 0x00000154,
    D3D12_CS_4_X_BUCKET14_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000020,
    D3D12_CS_4_X_BUCKET14_MAX_NUM_THREADS_PER_GROUP          = 0x00000200,
    D3D12_CS_4_X_BUCKET15_MAX_BYTES_TGSM_WRITABLE_PER_THREAD = 0x00000010,
    D3D12_CS_4_X_BUCKET15_MAX_NUM_THREADS_PER_GROUP          = 0x00000300,
}

enum uint D3D12_CS_4_X_RAW_UAV_BYTE_ALIGNMENT = 0x00000100;

enum : uint
{
    D3D12_CS_4_X_THREAD_GROUP_MAX_X = 0x00000300,
    D3D12_CS_4_X_THREAD_GROUP_MAX_Y = 0x00000300,
    D3D12_CS_4_X_UAV_REGISTER_COUNT = 0x00000001,
}

enum : uint
{
    D3D12_CS_TGSM_REGISTER_COUNT               = 0x00002000,
    D3D12_CS_TGSM_REGISTER_READS_PER_INST      = 0x00000001,
    D3D12_CS_TGSM_RESOURCE_REGISTER_COMPONENTS = 0x00000001,
    D3D12_CS_TGSM_RESOURCE_REGISTER_READ_PORTS = 0x00000001,
}

enum : uint
{
    D3D12_CS_THREADGROUPID_REGISTER_COUNT                 = 0x00000001,
    D3D12_CS_THREADIDINGROUPFLATTENED_REGISTER_COMPONENTS = 0x00000001,
    D3D12_CS_THREADIDINGROUPFLATTENED_REGISTER_COUNT      = 0x00000001,
    D3D12_CS_THREADIDINGROUP_REGISTER_COMPONENTS          = 0x00000003,
    D3D12_CS_THREADIDINGROUP_REGISTER_COUNT               = 0x00000001,
    D3D12_CS_THREADID_REGISTER_COMPONENTS                 = 0x00000003,
    D3D12_CS_THREADID_REGISTER_COUNT                      = 0x00000001,
    D3D12_CS_THREAD_GROUP_MAX_THREADS_PER_GROUP           = 0x00000400,
    D3D12_CS_THREAD_GROUP_MAX_X                           = 0x00000400,
    D3D12_CS_THREAD_GROUP_MAX_Y                           = 0x00000400,
    D3D12_CS_THREAD_GROUP_MAX_Z                           = 0x00000040,
    D3D12_CS_THREAD_GROUP_MIN_X                           = 0x00000001,
    D3D12_CS_THREAD_GROUP_MIN_Y                           = 0x00000001,
    D3D12_CS_THREAD_GROUP_MIN_Z                           = 0x00000001,
    D3D12_CS_THREAD_LOCAL_TEMP_REGISTER_POOL              = 0x00004000,
}

enum : float
{
    D3D12_DEFAULT_BLEND_FACTOR_BLUE      = 0x1p+0,
    D3D12_DEFAULT_BLEND_FACTOR_GREEN     = 0x1p+0,
    D3D12_DEFAULT_BLEND_FACTOR_RED       = 0x1p+0,
    D3D12_DEFAULT_BORDER_COLOR_COMPONENT = 0x0p+0,
}

enum float D3D12_DEFAULT_DEPTH_BIAS_CLAMP = 0x0p+0;
enum float D3D12_DEFAULT_MIP_LOD_BIAS = 0x0p+0;

enum : uint
{
    D3D12_DEFAULT_RENDER_TARGET_ARRAY_INDEX    = 0x00000000,
    D3D12_DEFAULT_RESOURCE_PLACEMENT_ALIGNMENT = 0x00010000,
}

enum : uint
{
    D3D12_DEFAULT_SCISSOR_ENDX   = 0x00000000,
    D3D12_DEFAULT_SCISSOR_ENDY   = 0x00000000,
    D3D12_DEFAULT_SCISSOR_STARTX = 0x00000000,
    D3D12_DEFAULT_SCISSOR_STARTY = 0x00000000,
}

enum : uint
{
    D3D12_DEFAULT_STENCIL_READ_MASK              = 0x000000ff,
    D3D12_DEFAULT_STENCIL_REFERENCE              = 0x00000000,
    D3D12_DEFAULT_STENCIL_WRITE_MASK             = 0x000000ff,
    D3D12_DEFAULT_VIEWPORT_AND_SCISSORRECT_INDEX = 0x00000000,
    D3D12_DEFAULT_VIEWPORT_HEIGHT                = 0x00000000,
}

enum float D3D12_DEFAULT_VIEWPORT_MIN_DEPTH = 0x0p+0;

enum : uint
{
    D3D12_DEFAULT_VIEWPORT_TOPLEFTY = 0x00000000,
    D3D12_DEFAULT_VIEWPORT_WIDTH    = 0x00000000,
}

enum : uint
{
    D3D12_DRIVER_RESERVED_REGISTER_SPACE_VALUES_END   = 0xfffffff7,
    D3D12_DRIVER_RESERVED_REGISTER_SPACE_VALUES_START = 0xfffffff0,
}

enum : uint
{
    D3D12_DS_INPUT_CONTROL_POINT_REGISTER_COMPONENTS          = 0x00000004,
    D3D12_DS_INPUT_CONTROL_POINT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_DS_INPUT_CONTROL_POINT_REGISTER_COUNT               = 0x00000020,
    D3D12_DS_INPUT_CONTROL_POINT_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_DS_INPUT_CONTROL_POINT_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_DS_INPUT_DOMAIN_POINT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_DS_INPUT_DOMAIN_POINT_REGISTER_COUNT               = 0x00000001,
    D3D12_DS_INPUT_DOMAIN_POINT_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_DS_INPUT_DOMAIN_POINT_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_DS_INPUT_PATCH_CONSTANT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_DS_INPUT_PATCH_CONSTANT_REGISTER_COUNT               = 0x00000020,
    D3D12_DS_INPUT_PATCH_CONSTANT_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_DS_INPUT_PATCH_CONSTANT_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_DS_INPUT_PRIMITIVE_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_DS_INPUT_PRIMITIVE_ID_REGISTER_COUNT               = 0x00000001,
    D3D12_DS_INPUT_PRIMITIVE_ID_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_DS_INPUT_PRIMITIVE_ID_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_DS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_DS_OUTPUT_REGISTER_COUNT               = 0x00000020,
}

enum : float
{
    D3D12_FLOAT32_MAX                         = 0x1.fffffep+127,
    D3D12_FLOAT32_TO_INTEGER_TOLERANCE_IN_ULP = 0x1.333334p-1,
}

enum : float
{
    D3D12_FLOAT_TO_SRGB_EXPONENT_NUMERATOR = 0x1p+0,
    D3D12_FLOAT_TO_SRGB_OFFSET             = 0x1.c28f5cp-5,
    D3D12_FLOAT_TO_SRGB_SCALE_1            = 0x1.9d70a4p+3,
    D3D12_FLOAT_TO_SRGB_SCALE_2            = 0x1.0e147ap+0,
    D3D12_FLOAT_TO_SRGB_THRESHOLD          = 0x1.9a5c38p-9,
}

enum float D3D12_FTOI_INSTRUCTION_MIN_INPUT = -0x1p+31;
enum float D3D12_FTOU_INSTRUCTION_MIN_INPUT = 0x0p+0;

enum : uint
{
    D3D12_GS_INPUT_INSTANCE_ID_READ_PORTS                   = 0x00000001,
    D3D12_GS_INPUT_INSTANCE_ID_REGISTER_COMPONENTS          = 0x00000001,
    D3D12_GS_INPUT_INSTANCE_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_GS_INPUT_INSTANCE_ID_REGISTER_COUNT               = 0x00000001,
}

enum : uint
{
    D3D12_GS_INPUT_PRIM_CONST_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_GS_INPUT_PRIM_CONST_REGISTER_COUNT               = 0x00000001,
    D3D12_GS_INPUT_PRIM_CONST_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_GS_INPUT_PRIM_CONST_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_GS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_GS_INPUT_REGISTER_COUNT               = 0x00000020,
    D3D12_GS_INPUT_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_GS_INPUT_REGISTER_READ_PORTS          = 0x00000001,
    D3D12_GS_INPUT_REGISTER_VERTICES            = 0x00000020,
}

enum uint D3D12_GS_MAX_OUTPUT_VERTEX_COUNT_ACROSS_INSTANCES = 0x00000400;

enum : uint
{
    D3D12_GS_OUTPUT_REGISTER_COMPONENTS          = 0x00000004,
    D3D12_GS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_GS_OUTPUT_REGISTER_COUNT               = 0x00000020,
}

enum : uint
{
    D3D12_HS_CONTROL_POINT_PHASE_OUTPUT_REGISTER_COUNT  = 0x00000020,
    D3D12_HS_CONTROL_POINT_REGISTER_COMPONENTS          = 0x00000004,
    D3D12_HS_CONTROL_POINT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_HS_CONTROL_POINT_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_HS_CONTROL_POINT_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_HS_INPUT_FORK_INSTANCE_ID_REGISTER_COMPONENTS          = 0x00000001,
    D3D12_HS_INPUT_FORK_INSTANCE_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_HS_INPUT_FORK_INSTANCE_ID_REGISTER_COUNT               = 0x00000001,
    D3D12_HS_INPUT_FORK_INSTANCE_ID_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_HS_INPUT_FORK_INSTANCE_ID_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_COUNT               = 0x00000001,
    D3D12_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_HS_INPUT_PRIMITIVE_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_HS_INPUT_PRIMITIVE_ID_REGISTER_COUNT               = 0x00000001,
    D3D12_HS_INPUT_PRIMITIVE_ID_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_HS_INPUT_PRIMITIVE_ID_REGISTER_READ_PORTS          = 0x00000001,
}

enum : float
{
    D3D12_HS_MAXTESSFACTOR_LOWER_BOUND = 0x1p+0,
    D3D12_HS_MAXTESSFACTOR_UPPER_BOUND = 0x1p+6,
}

enum : uint
{
    D3D12_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_COMPONENTS          = 0x00000001,
    D3D12_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_COUNT               = 0x00000001,
    D3D12_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_COUNT               = 0x00000020,
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_READ_PORTS          = 0x00000001,
    D3D12_HS_OUTPUT_PATCH_CONSTANT_REGISTER_SCALAR_COMPONENTS   = 0x00000080,
}

enum : uint
{
    D3D12_IA_DEFAULT_PRIMITIVE_TOPOLOGY            = 0x00000000,
    D3D12_IA_DEFAULT_VERTEX_BUFFER_OFFSET_IN_BYTES = 0x00000000,
}

enum uint D3D12_IA_INSTANCE_ID_BIT_COUNT = 0x00000020;
enum uint D3D12_IA_PATCH_MAX_CONTROL_POINT_COUNT = 0x00000020;

enum : uint
{
    D3D12_IA_VERTEX_ID_BIT_COUNT                        = 0x00000020,
    D3D12_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT           = 0x00000020,
    D3D12_IA_VERTEX_INPUT_STRUCTURE_ELEMENTS_COMPONENTS = 0x00000080,
    D3D12_IA_VERTEX_INPUT_STRUCTURE_ELEMENT_COUNT       = 0x00000020,
}

enum uint D3D12_INTEGER_DIVIDE_BY_ZERO_REMAINDER = 0xffffffff;
enum uint D3D12_KEEP_UNORDERED_ACCESS_VIEWS = 0xffffffff;
enum uint D3D12_MAJOR_VERSION = 0x0000000c;
enum float D3D12_MAX_DEPTH = 0x1p+0;

enum : uint
{
    D3D12_MAX_MAXANISOTROPY            = 0x00000010,
    D3D12_MAX_MULTISAMPLE_SAMPLE_COUNT = 0x00000020,
}

enum : uint
{
    D3D12_MAX_ROOT_COST                                  = 0x00000040,
    D3D12_MAX_SHADER_VISIBLE_DESCRIPTOR_HEAP_SIZE_TIER_1 = 0x000f4240,
    D3D12_MAX_SHADER_VISIBLE_DESCRIPTOR_HEAP_SIZE_TIER_2 = 0x000f4240,
    D3D12_MAX_SHADER_VISIBLE_SAMPLER_HEAP_SIZE           = 0x00000800,
}

enum uint D3D12_MAX_VIEW_INSTANCE_COUNT = 0x00000004;
enum float D3D12_MIN_BORDER_COLOR_COMPONENT = 0x0p+0;
enum uint D3D12_MIN_MAXANISOTROPY = 0x00000000;
enum float D3D12_MIP_LOD_BIAS_MIN = -0x1p+4;
enum uint D3D12_MIP_LOD_RANGE_BIT_COUNT = 0x00000008;
enum uint D3D12_NONSAMPLE_FETCH_OUT_OF_RANGE_ACCESS_RESULT = 0x00000000;
enum uint D3D12_OS_RESERVED_REGISTER_SPACE_VALUES_START = 0xfffffff8;
enum uint D3D12_PIXEL_ADDRESS_RANGE_BIT_COUNT = 0x0000000f;

enum : uint
{
    D3D12_PS_CS_UAV_REGISTER_COMPONENTS     = 0x00000001,
    D3D12_PS_CS_UAV_REGISTER_COUNT          = 0x00000008,
    D3D12_PS_CS_UAV_REGISTER_READS_PER_INST = 0x00000001,
    D3D12_PS_CS_UAV_REGISTER_READ_PORTS     = 0x00000001,
}

enum : uint
{
    D3D12_PS_FRONTFACING_FALSE_VALUE = 0x00000000,
    D3D12_PS_FRONTFACING_TRUE_VALUE  = 0xffffffff,
}

enum : uint
{
    D3D12_PS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_PS_INPUT_REGISTER_COUNT               = 0x00000020,
    D3D12_PS_INPUT_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_PS_INPUT_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_PS_OUTPUT_DEPTH_REGISTER_COMPONENTS          = 0x00000001,
    D3D12_PS_OUTPUT_DEPTH_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_PS_OUTPUT_DEPTH_REGISTER_COUNT               = 0x00000001,
    D3D12_PS_OUTPUT_MASK_REGISTER_COMPONENTS           = 0x00000001,
    D3D12_PS_OUTPUT_MASK_REGISTER_COMPONENT_BIT_COUNT  = 0x00000020,
    D3D12_PS_OUTPUT_MASK_REGISTER_COUNT                = 0x00000001,
    D3D12_PS_OUTPUT_REGISTER_COMPONENTS                = 0x00000004,
    D3D12_PS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT       = 0x00000020,
    D3D12_PS_OUTPUT_REGISTER_COUNT                     = 0x00000008,
}

enum uint D3D12_RAW_UAV_SRV_BYTE_ALIGNMENT = 0x00000010;
enum uint D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BYTE_ALIGNMENT = 0x00000100;

enum : uint
{
    D3D12_RAYTRACING_MAX_ATTRIBUTE_SIZE_IN_BYTES          = 0x00000020,
    D3D12_RAYTRACING_MAX_DECLARABLE_TRACE_RECURSION_DEPTH = 0x0000001f,
}

enum uint D3D12_RAYTRACING_MAX_INSTANCES_PER_TOP_LEVEL_ACCELERATION_STRUCTURE = 0x01000000;

enum : uint
{
    D3D12_RAYTRACING_MAX_RAY_GENERATION_SHADER_THREADS = 0x40000000,
    D3D12_RAYTRACING_MAX_SHADER_RECORD_STRIDE          = 0x00001000,
    D3D12_RAYTRACING_SHADER_RECORD_BYTE_ALIGNMENT      = 0x00000020,
    D3D12_RAYTRACING_SHADER_TABLE_BYTE_ALIGNMENT       = 0x00000040,
}

enum uint D3D12_REQ_BLEND_OBJECT_COUNT_PER_DEVICE = 0x00001000;
enum uint D3D12_REQ_CONSTANT_BUFFER_ELEMENT_COUNT = 0x00001000;
enum uint D3D12_REQ_DRAWINDEXED_INDEX_COUNT_2_TO_EXP = 0x00000020;
enum uint D3D12_REQ_FILTERING_HW_ADDRESSABLE_RESOURCE_DIMENSION = 0x00004000;
enum uint D3D12_REQ_IMMEDIATE_CONSTANT_BUFFER_ELEMENT_COUNT = 0x00001000;

enum : uint
{
    D3D12_REQ_MIP_LEVELS                            = 0x0000000f,
    D3D12_REQ_MULTI_ELEMENT_STRUCTURE_SIZE_IN_BYTES = 0x00000800,
}

enum uint D3D12_REQ_RENDER_TO_BUFFER_WINDOW_WIDTH = 0x00004000;
enum float D3D12_REQ_RESOURCE_SIZE_IN_MEGABYTES_EXPRESSION_B_TERM = 0x1p-2;
enum uint D3D12_REQ_RESOURCE_VIEW_COUNT_PER_DEVICE_2_TO_EXP = 0x00000014;

enum : uint
{
    D3D12_REQ_SUBRESOURCES                   = 0x00007800,
    D3D12_REQ_TEXTURE1D_ARRAY_AXIS_DIMENSION = 0x00000800,
    D3D12_REQ_TEXTURE1D_U_DIMENSION          = 0x00004000,
    D3D12_REQ_TEXTURE2D_ARRAY_AXIS_DIMENSION = 0x00000800,
    D3D12_REQ_TEXTURE2D_U_OR_V_DIMENSION     = 0x00004000,
    D3D12_REQ_TEXTURE3D_U_V_OR_W_DIMENSION   = 0x00000800,
    D3D12_REQ_TEXTURECUBE_DIMENSION          = 0x00004000,
}

enum uint D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES = 0xffffffff;
enum uint D3D12_SHADER_IDENTIFIER_SIZE_IN_BYTES = 0x00000020;

enum : uint
{
    D3D12_SHADER_MAX_INSTANCES            = 0x0000ffff,
    D3D12_SHADER_MAX_INTERFACES           = 0x000000fd,
    D3D12_SHADER_MAX_INTERFACE_CALL_SITES = 0x00001000,
    D3D12_SHADER_MAX_TYPES                = 0x0000ffff,
    D3D12_SHADER_MINOR_VERSION            = 0x00000001,
}

enum uint D3D12_SHIFT_INSTRUCTION_SHIFT_VALUE_BIT_COUNT = 0x00000005;
enum uint D3D12_SMALL_MSAA_RESOURCE_PLACEMENT_ALIGNMENT = 0x00010000;

enum : uint
{
    D3D12_SO_BUFFER_MAX_STRIDE_IN_BYTES       = 0x00000800,
    D3D12_SO_BUFFER_MAX_WRITE_WINDOW_IN_BYTES = 0x00000200,
}

enum uint D3D12_SO_DDI_REGISTER_INDEX_DENOTING_GAP = 0xffffffff;
enum uint D3D12_SO_OUTPUT_COMPONENT_COUNT = 0x00000080;

enum : uint
{
    D3D12_SPEC_DATE_DAY   = 0x0000000e,
    D3D12_SPEC_DATE_MONTH = 0x0000000b,
    D3D12_SPEC_DATE_YEAR  = 0x000007de,
}

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

enum uint D3D12_STANDARD_COMPONENT_BIT_COUNT_DOUBLED = 0x00000040;

enum : uint
{
    D3D12_STANDARD_PIXEL_COMPONENT_COUNT        = 0x00000080,
    D3D12_STANDARD_PIXEL_ELEMENT_COUNT          = 0x00000020,
    D3D12_STANDARD_VECTOR_SIZE                  = 0x00000004,
    D3D12_STANDARD_VERTEX_ELEMENT_COUNT         = 0x00000020,
    D3D12_STANDARD_VERTEX_TOTAL_COMPONENT_COUNT = 0x00000040,
}

enum uint D3D12_SUBTEXEL_FRACTIONAL_BIT_COUNT = 0x00000008;
enum uint D3D12_SYSTEM_RESERVED_REGISTER_SPACE_VALUES_START = 0xfffffff0;
enum uint D3D12_TESSELLATOR_MAX_ISOLINE_DENSITY_TESSELLATION_FACTOR = 0x00000040;

enum : uint
{
    D3D12_TESSELLATOR_MAX_TESSELLATION_FACTOR                 = 0x00000040,
    D3D12_TESSELLATOR_MIN_EVEN_TESSELLATION_FACTOR            = 0x00000002,
    D3D12_TESSELLATOR_MIN_ISOLINE_DENSITY_TESSELLATION_FACTOR = 0x00000001,
}

enum uint D3D12_TEXEL_ADDRESS_RANGE_BIT_COUNT = 0x00000010;
enum uint D3D12_TEXTURE_DATA_PLACEMENT_ALIGNMENT = 0x00000200;
enum uint D3D12_TRACKED_WORKLOAD_MAX_INSTANCES = 0x00000020;
enum uint D3D12_UAV_SLOT_COUNT = 0x00000040;

enum : uint
{
    D3D12_VIDEO_DECODE_MAX_ARGUMENTS                  = 0x0000000a,
    D3D12_VIDEO_DECODE_MAX_HISTOGRAM_COMPONENTS       = 0x00000004,
    D3D12_VIDEO_DECODE_MIN_BITSTREAM_OFFSET_ALIGNMENT = 0x00000100,
    D3D12_VIDEO_DECODE_MIN_HISTOGRAM_OFFSET_ALIGNMENT = 0x00000100,
}

enum : uint
{
    D3D12_VIDEO_PROCESS_MAX_FILTERS  = 0x00000020,
    D3D12_VIDEO_PROCESS_STEREO_VIEWS = 0x00000002,
}

enum uint D3D12_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE = 0x00000010;
enum int D3D12_VIEWPORT_BOUNDS_MIN = 0xffff8000;

enum : uint
{
    D3D12_VS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_VS_INPUT_REGISTER_COUNT               = 0x00000020,
    D3D12_VS_INPUT_REGISTER_READS_PER_INST      = 0x00000002,
    D3D12_VS_INPUT_REGISTER_READ_PORTS          = 0x00000001,
}

enum : uint
{
    D3D12_VS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020,
    D3D12_VS_OUTPUT_REGISTER_COUNT               = 0x00000020,
}

enum uint D3D12_WHQL_DRAWINDEXED_INDEX_COUNT_2_TO_EXP = 0x00000019;

enum : uint
{
    D3D12_SHADER_COMPONENT_MAPPING_MASK                                     = 0x00000007,
    D3D12_SHADER_COMPONENT_MAPPING_SHIFT                                    = 0x00000003,
    D3D12_SHADER_COMPONENT_MAPPING_ALWAYS_SET_BIT_AVOIDING_ZEROMEM_MISTAKES = 0x00001000,
}

enum : uint
{
    D3D12_FILTER_REDUCTION_TYPE_MASK  = 0x00000003,
    D3D12_FILTER_REDUCTION_TYPE_SHIFT = 0x00000007,
}

enum uint D3D12_MIN_FILTER_SHIFT = 0x00000004;
enum uint D3D12_MIP_FILTER_SHIFT = 0x00000000;

enum : uint
{
    D3D12_SHADING_RATE_X_AXIS_SHIFT = 0x00000002,
    D3D12_SHADING_RATE_VALID_MASK   = 0x00000003,
}

enum GUID D3D12TiledResourceTier4 = GUID("c9c4725f-a81a-4f56-8c5b-c51039d694fb");

// Callbacks

alias PFN_D3D12_SERIALIZE_ROOT_SIGNATURE = HRESULT function(const(D3D12_ROOT_SIGNATURE_DESC)* pRootSignature, 
                                                            D3D_ROOT_SIGNATURE_VERSION Version, ID3DBlob* ppBlob, 
                                                            ID3DBlob* ppErrorBlob);
alias PFN_D3D12_CREATE_ROOT_SIGNATURE_DESERIALIZER = HRESULT function(const(void)* pSrcData, 
                                                                      size_t SrcDataSizeInBytes, 
                                                                      const(GUID)* pRootSignatureDeserializerInterface, 
                                                                      void** ppRootSignatureDeserializer);
alias PFN_D3D12_SERIALIZE_VERSIONED_ROOT_SIGNATURE = HRESULT function(const(D3D12_VERSIONED_ROOT_SIGNATURE_DESC)* pRootSignature, 
                                                                      ID3DBlob* ppBlob, ID3DBlob* ppErrorBlob);
alias PFN_D3D12_CREATE_VERSIONED_ROOT_SIGNATURE_DESERIALIZER = HRESULT function(const(void)* pSrcData, 
                                                                                size_t SrcDataSizeInBytes, 
                                                                                const(GUID)* pRootSignatureDeserializerInterface, 
                                                                                void** ppRootSignatureDeserializer);
alias PFN_D3D12_CREATE_DEVICE = HRESULT function(IUnknown param0, D3D_FEATURE_LEVEL param1, const(GUID)* param2, 
                                                 void** param3);
alias PFN_D3D12_GET_DEBUG_INTERFACE = HRESULT function(const(GUID)* param0, void** param1);
alias PFN_D3D11ON12_CREATE_DEVICE = HRESULT function(IUnknown param0, uint param1, 
                                                     const(D3D_FEATURE_LEVEL)* param2, uint FeatureLevels, 
                                                     IUnknown* param4, uint NumQueues, uint param6, 
                                                     ID3D11Device* param7, ID3D11DeviceContext* param8, 
                                                     D3D_FEATURE_LEVEL* param9);

// Structs


///Describes a command queue.
struct D3D12_COMMAND_QUEUE_DESC
{
    ///Specifies one member of D3D12_COMMAND_LIST_TYPE.
    D3D12_COMMAND_LIST_TYPE Type;
    ///The priority for the command queue, as a D3D12_COMMAND_QUEUE_PRIORITYenumeration constant to select normal or
    ///high priority.
    int  Priority;
    ///Specifies any flags from the D3D12_COMMAND_QUEUE_FLAGS enumeration.
    D3D12_COMMAND_QUEUE_FLAGS Flags;
    ///For single GPU operation, set this to zero. If there are multiple GPU nodes, set a bit to identify the node (the
    ///device's physical adapter) to which the command queue applies. Each bit in the mask corresponds to a single node.
    ///Only 1 bit must be set. Refer to Multi-adapter systems.
    uint NodeMask;
}

///Describes a single element for the input-assembler stage of the graphics pipeline.
struct D3D12_INPUT_ELEMENT_DESC
{
    ///The HLSL semantic associated with this element in a shader input-signature.
    const(PSTR) SemanticName;
    ///The semantic index for the element. A semantic index modifies a semantic, with an integer index number. A
    ///semantic index is only needed in a case where there is more than one element with the same semantic. For example,
    ///a 4x4 matrix would have four components each with the semantic name <b>matrix</b>, however each of the four
    ///component would have different semantic indices (0, 1, 2, and 3).
    uint        SemanticIndex;
    ///A DXGI_FORMAT-typed value that specifies the format of the element data.
    DXGI_FORMAT Format;
    ///An integer value that identifies the input-assembler. For more info, see Input Slots. Valid values are between 0
    ///and 15.
    uint        InputSlot;
    ///Optional. Offset, in bytes, to this element from the start of the vertex. Use D3D12_APPEND_ALIGNED_ELEMENT
    ///(0xffffffff) for convenience to define the current element directly after the previous one, including any packing
    ///if necessary.
    uint        AlignedByteOffset;
    ///A value that identifies the input data class for a single input slot.
    D3D12_INPUT_CLASSIFICATION InputSlotClass;
    ///The number of instances to draw using the same per-instance data before advancing in the buffer by one element.
    ///This value must be 0 for an element that contains per-vertex data (the slot class is set to the
    ///D3D12_INPUT_PER_VERTEX_DATA member of D3D12_INPUT_CLASSIFICATION).
    uint        InstanceDataStepRate;
}

///Describes a vertex element in a vertex buffer in an output slot.
struct D3D12_SO_DECLARATION_ENTRY
{
    ///Zero-based, stream number.
    uint        Stream;
    ///Type of output element; possible values include: <b>"POSITION"</b>, <b>"NORMAL"</b>, or <b>"TEXCOORD0"</b>. Note
    ///that if <b>SemanticName</b> is <b>NULL</b> then <b>ComponentCount</b> can be greater than 4 and the described
    ///entry will be a gap in the stream out where no data will be written.
    const(PSTR) SemanticName;
    ///Output element's zero-based index. Use, for example, if you have more than one texture coordinate stored in each
    ///vertex.
    uint        SemanticIndex;
    ///The component of the entry to begin writing out to. Valid values are 0 to 3. For example, if you only wish to
    ///output to the y and z components of a position, <b>StartComponent</b> is 1 and <b>ComponentCount</b> is 2.
    ubyte       StartComponent;
    ///The number of components of the entry to write out to. Valid values are 1 to 4. For example, if you only wish to
    ///output to the y and z components of a position, <b>StartComponent</b> is 1 and <b>ComponentCount</b> is 2. Note
    ///that if <b>SemanticName</b> is <b>NULL</b> then <b>ComponentCount</b> can be greater than 4 and the described
    ///entry will be a gap in the stream out where no data will be written.
    ubyte       ComponentCount;
    ///The associated stream output buffer that is bound to the pipeline. The valid range for <b>OutputSlot</b> is 0 to
    ///3.
    ubyte       OutputSlot;
}

///Describes the dimensions of a viewport.
struct D3D12_VIEWPORT
{
    ///X position of the left hand side of the viewport.
    float TopLeftX;
    ///Y position of the top of the viewport.
    float TopLeftY;
    ///Width of the viewport.
    float Width;
    ///Height of the viewport.
    float Height;
    ///Minimum depth of the viewport. Ranges between 0 and 1.
    float MinDepth;
    ///Maximum depth of the viewport. Ranges between 0 and 1.
    float MaxDepth;
}

///Describes a 3D box.
struct D3D12_BOX
{
    ///The x position of the left hand side of the box.
    uint left;
    ///The y position of the top of the box.
    uint top;
    ///The z position of the front of the box.
    uint front;
    ///The x position of the right hand side of the box, plus 1. This means that <code>right - left</code> equals the
    ///width of the box.
    uint right;
    ///The y position of the bottom of the box, plus 1. This means that <code>top - bottom</code> equals the height of
    ///the box.
    uint bottom;
    ///The z position of the back of the box, plus 1. This means that <code>front - back</code> equals the depth of the
    ///box.
    uint back;
}

///Describes stencil operations that can be performed based on the results of stencil test.
struct D3D12_DEPTH_STENCILOP_DESC
{
    ///A D3D12_STENCIL_OP-typed value that identifies the stencil operation to perform when stencil testing fails.
    D3D12_STENCIL_OP StencilFailOp;
    ///A D3D12_STENCIL_OP-typed value that identifies the stencil operation to perform when stencil testing passes and
    ///depth testing fails.
    D3D12_STENCIL_OP StencilDepthFailOp;
    ///A D3D12_STENCIL_OP-typed value that identifies the stencil operation to perform when stencil testing and depth
    ///testing both pass.
    D3D12_STENCIL_OP StencilPassOp;
    ///A D3D12_COMPARISON_FUNC-typed value that identifies the function that compares stencil data against existing
    ///stencil data.
    D3D12_COMPARISON_FUNC StencilFunc;
}

///Describes depth-stencil state.
struct D3D12_DEPTH_STENCIL_DESC
{
    ///Specifies whether to enable depth testing. Set this member to <b>TRUE</b> to enable depth testing.
    BOOL  DepthEnable;
    ///A D3D12_DEPTH_WRITE_MASK-typed value that identifies a portion of the depth-stencil buffer that can be modified
    ///by depth data.
    D3D12_DEPTH_WRITE_MASK DepthWriteMask;
    ///A D3D12_COMPARISON_FUNC-typed value that identifies a function that compares depth data against existing depth
    ///data.
    D3D12_COMPARISON_FUNC DepthFunc;
    ///Specifies whether to enable stencil testing. Set this member to <b>TRUE</b> to enable stencil testing.
    BOOL  StencilEnable;
    ///Identify a portion of the depth-stencil buffer for reading stencil data.
    ubyte StencilReadMask;
    ///Identify a portion of the depth-stencil buffer for writing stencil data.
    ubyte StencilWriteMask;
    ///A D3D12_DEPTH_STENCILOP_DESC structure that describes how to use the results of the depth test and the stencil
    ///test for pixels whose surface normal is facing towards the camera.
    D3D12_DEPTH_STENCILOP_DESC FrontFace;
    ///A D3D12_DEPTH_STENCILOP_DESC structure that describes how to use the results of the depth test and the stencil
    ///test for pixels whose surface normal is facing away from the camera.
    D3D12_DEPTH_STENCILOP_DESC BackFace;
}

///Describes depth-stencil state.
struct D3D12_DEPTH_STENCIL_DESC1
{
    ///Specifies whether to enable depth testing. Set this member to <b>TRUE</b> to enable depth testing.
    BOOL  DepthEnable;
    ///A D3D12_DEPTH_WRITE_MASK-typed value that identifies a portion of the depth-stencil buffer that can be modified
    ///by depth data.
    D3D12_DEPTH_WRITE_MASK DepthWriteMask;
    ///A D3D12_COMPARISON_FUNC-typed value that identifies a function that compares depth data against existing depth
    ///data.
    D3D12_COMPARISON_FUNC DepthFunc;
    ///Specifies whether to enable stencil testing. Set this member to <b>TRUE</b> to enable stencil testing.
    BOOL  StencilEnable;
    ///Identify a portion of the depth-stencil buffer for reading stencil data.
    ubyte StencilReadMask;
    ///Identify a portion of the depth-stencil buffer for writing stencil data.
    ubyte StencilWriteMask;
    ///A D3D12_DEPTH_STENCILOP_DESC structure that describes how to use the results of the depth test and the stencil
    ///test for pixels whose surface normal is facing towards the camera.
    D3D12_DEPTH_STENCILOP_DESC FrontFace;
    ///A D3D12_DEPTH_STENCILOP_DESC structure that describes how to use the results of the depth test and the stencil
    ///test for pixels whose surface normal is facing away from the camera.
    D3D12_DEPTH_STENCILOP_DESC BackFace;
    ///TRUE to enable depth-bounds testing; otherwise, FALSE. The default value is FALSE.
    BOOL  DepthBoundsTestEnable;
}

///Describes the blend state for a render target.
struct D3D12_RENDER_TARGET_BLEND_DESC
{
    ///Specifies whether to enable (or disable) blending. Set to <b>TRUE</b> to enable blending. > [!NOTE] > It's not
    ///valid for *LogicOpEnable* and *BlendEnable* to both be **TRUE**.
    BOOL           BlendEnable;
    ///Specifies whether to enable (or disable) a logical operation. Set to <b>TRUE</b> to enable a logical operation. >
    ///[!NOTE] > It's not valid for *LogicOpEnable* and *BlendEnable* to both be **TRUE**.
    BOOL           LogicOpEnable;
    ///A D3D12_BLEND-typed value that specifies the operation to perform on the RGB value that the pixel shader outputs.
    ///The <b>BlendOp</b> member defines how to combine the <b>SrcBlend</b> and <b>DestBlend</b> operations.
    D3D12_BLEND    SrcBlend;
    ///A D3D12_BLEND-typed value that specifies the operation to perform on the current RGB value in the render target.
    ///The <b>BlendOp</b> member defines how to combine the <b>SrcBlend</b> and <b>DestBlend</b> operations.
    D3D12_BLEND    DestBlend;
    ///A D3D12_BLEND_OP-typed value that defines how to combine the <b>SrcBlend</b> and <b>DestBlend</b> operations.
    D3D12_BLEND_OP BlendOp;
    ///A D3D12_BLEND-typed value that specifies the operation to perform on the alpha value that the pixel shader
    ///outputs. Blend options that end in _COLOR are not allowed. The <b>BlendOpAlpha</b> member defines how to combine
    ///the <b>SrcBlendAlpha</b> and <b>DestBlendAlpha</b> operations.
    D3D12_BLEND    SrcBlendAlpha;
    ///A D3D12_BLEND-typed value that specifies the operation to perform on the current alpha value in the render
    ///target. Blend options that end in _COLOR are not allowed. The <b>BlendOpAlpha</b> member defines how to combine
    ///the <b>SrcBlendAlpha</b> and <b>DestBlendAlpha</b> operations.
    D3D12_BLEND    DestBlendAlpha;
    ///A D3D12_BLEND_OP-typed value that defines how to combine the <b>SrcBlendAlpha</b> and <b>DestBlendAlpha</b>
    ///operations.
    D3D12_BLEND_OP BlendOpAlpha;
    ///A D3D12_LOGIC_OP-typed value that specifies the logical operation to configure for the render target.
    D3D12_LOGIC_OP LogicOp;
    ///A combination of D3D12_COLOR_WRITE_ENABLE-typed values that are combined by using a bitwise OR operation. The
    ///resulting value specifies a write mask.
    ubyte          RenderTargetWriteMask;
}

///Describes the blend state.
struct D3D12_BLEND_DESC
{
    ///Specifies whether to use alpha-to-coverage as a multisampling technique when setting a pixel to a render target.
    ///For more info about using alpha-to-coverage, see Alpha-To-Coverage.
    BOOL AlphaToCoverageEnable;
    ///Specifies whether to enable independent blending in simultaneous render targets. Set to <b>TRUE</b> to enable
    ///independent blending. If set to <b>FALSE</b>, only the <b>RenderTarget</b>[0] members are used;
    ///<b>RenderTarget</b>[1..7] are ignored. See the **Remarks** section for restrictions.
    BOOL IndependentBlendEnable;
    ///An array of D3D12_RENDER_TARGET_BLEND_DESC structures that describe the blend states for render targets; these
    ///correspond to the eight render targets that can be bound to the output-merger stage at one time.
    D3D12_RENDER_TARGET_BLEND_DESC[8] RenderTarget;
}

///Describes rasterizer state.
struct D3D12_RASTERIZER_DESC
{
    ///A D3D12_FILL_MODE-typed value that specifies the fill mode to use when rendering.
    D3D12_FILL_MODE FillMode;
    ///A D3D12_CULL_MODE-typed value that specifies that triangles facing the specified direction are not drawn.
    D3D12_CULL_MODE CullMode;
    ///Determines if a triangle is front- or back-facing. If this member is <b>TRUE</b>, a triangle will be considered
    ///front-facing if its vertices are counter-clockwise on the render target and considered back-facing if they are
    ///clockwise. If this parameter is <b>FALSE</b>, the opposite is true.
    BOOL            FrontCounterClockwise;
    ///Depth value added to a given pixel. For info about depth bias, see Depth Bias.
    int             DepthBias;
    ///Maximum depth bias of a pixel. For info about depth bias, see Depth Bias.
    float           DepthBiasClamp;
    ///Scalar on a given pixel's slope. For info about depth bias, see Depth Bias.
    float           SlopeScaledDepthBias;
    ///Specifies whether to enable clipping based on distance. The hardware always performs x and y clipping of
    ///rasterized coordinates. When <b>DepthClipEnable</b> is set to the default–<b>TRUE</b>, the hardware also clips
    ///the z value (that is, the hardware performs the last step of the following algorithm). <pre class="syntax"
    ///xml:space="preserve"><code> 0 &lt; w -w &lt;= x &lt;= w (or arbitrarily wider range if implementation uses a
    ///guard band to reduce clipping burden) -w &lt;= y &lt;= w (or arbitrarily wider range if implementation uses a
    ///guard band to reduce clipping burden) 0 &lt;= z &lt;= w </code></pre> When you set <b>DepthClipEnable</b> to
    ///<b>FALSE</b>, the hardware skips the z clipping (that is, the last step in the preceding algorithm). However, the
    ///hardware still performs the "0 &lt; w" clipping. When z clipping is disabled, improper depth ordering at the
    ///pixel level might result. However, when z clipping is disabled, stencil shadow implementations are simplified. In
    ///other words, you can avoid complex special-case handling for geometry that goes beyond the back clipping plane.
    BOOL            DepthClipEnable;
    ///Specifies whether to use the quadrilateral or alpha line anti-aliasing algorithm on multisample antialiasing
    ///(MSAA) render targets. Set to <b>TRUE</b> to use the quadrilateral line anti-aliasing algorithm and to
    ///<b>FALSE</b> to use the alpha line anti-aliasing algorithm. For more info about this member, see Remarks.
    BOOL            MultisampleEnable;
    ///Specifies whether to enable line antialiasing; only applies if doing line drawing and <b>MultisampleEnable</b> is
    ///<b>FALSE</b>. For more info about this member, see Remarks.
    BOOL            AntialiasedLineEnable;
    ///Type: <b>UINT</b> The sample count that is forced while UAV rendering or rasterizing. Valid values are 0, 1, 2,
    ///4, 8, and optionally 16. 0 indicates that the sample count is not forced. <div class="alert"><b>Note</b> If you
    ///want to render with <b>ForcedSampleCount</b> set to 1 or greater, you must follow these guidelines: <ul>
    ///<li>Don't bind depth-stencil views.</li> <li>Disable depth testing.</li> <li>Ensure the shader doesn't output
    ///depth.</li> <li>If you have any render-target views bound (D3D12_DESCRIPTOR_HEAP_TYPE_RTV) and
    ///<b>ForcedSampleCount</b> is greater than 1, ensure that every render target has only a single sample.</li>
    ///<li>Don't operate the shader at sample frequency. Therefore, ID3D12ShaderReflection::IsSampleFrequencyShader
    ///returns <b>FALSE</b>.</li> </ul>Otherwise, rendering behavior is undefined.</div> <div></div>
    uint            ForcedSampleCount;
    ///A D3D12_CONSERVATIVE_RASTERIZATION_MODE-typed value that identifies whether conservative rasterization is on or
    ///off.
    D3D12_CONSERVATIVE_RASTERIZATION_MODE ConservativeRaster;
}

///Describes shader data.
struct D3D12_SHADER_BYTECODE
{
    ///A pointer to a memory block that contains the shader data.
    const(void)* pShaderBytecode;
    ///The size, in bytes, of the shader data that the <b>pShaderBytecode</b> member points to.
    size_t       BytecodeLength;
}

///Describes a streaming output buffer.
struct D3D12_STREAM_OUTPUT_DESC
{
    ///An array of D3D12_SO_DECLARATION_ENTRY structures. Can't be <b>NULL</b> if <b>NumEntries</b> &gt; 0.
    const(D3D12_SO_DECLARATION_ENTRY)* pSODeclaration;
    ///The number of entries in the stream output declaration array that the <b>pSODeclaration</b> member points to.
    uint         NumEntries;
    ///An array of buffer strides; each stride is the size of an element for that buffer.
    const(uint)* pBufferStrides;
    ///The number of strides (or buffers) that the <b>pBufferStrides</b> member points to.
    uint         NumStrides;
    ///The index number of the stream to be sent to the rasterizer stage.
    uint         RasterizedStream;
}

///Describes the input-buffer data for the input-assembler stage.
struct D3D12_INPUT_LAYOUT_DESC
{
    ///An array of D3D12_INPUT_ELEMENT_DESC structures that describe the data types of the input-assembler stage.
    const(D3D12_INPUT_ELEMENT_DESC)* pInputElementDescs;
    ///The number of input-data types in the array of input elements that the <b>pInputElementDescs</b> member points
    ///to.
    uint NumElements;
}

///Stores a pipeline state.
struct D3D12_CACHED_PIPELINE_STATE
{
    ///Specifies pointer that references the memory location of the cache.
    const(void)* pCachedBlob;
    ///Specifies the size of the cache in bytes.
    size_t       CachedBlobSizeInBytes;
}

///Describes a graphics pipeline state object.
struct D3D12_GRAPHICS_PIPELINE_STATE_DESC
{
    ///A pointer to the ID3D12RootSignature object.
    ID3D12RootSignature pRootSignature;
    ///A D3D12_SHADER_BYTECODE structure that describes the vertex shader.
    D3D12_SHADER_BYTECODE VS;
    ///A D3D12_SHADER_BYTECODE structure that describes the pixel shader.
    D3D12_SHADER_BYTECODE PS;
    ///A D3D12_SHADER_BYTECODE structure that describes the domain shader.
    D3D12_SHADER_BYTECODE DS;
    ///A D3D12_SHADER_BYTECODE structure that describes the hull shader.
    D3D12_SHADER_BYTECODE HS;
    ///A D3D12_SHADER_BYTECODE structure that describes the geometry shader.
    D3D12_SHADER_BYTECODE GS;
    ///A D3D12_STREAM_OUTPUT_DESC structure that describes a streaming output buffer.
    D3D12_STREAM_OUTPUT_DESC StreamOutput;
    ///A D3D12_BLEND_DESC structure that describes the blend state.
    D3D12_BLEND_DESC    BlendState;
    ///The sample mask for the blend state.
    uint                SampleMask;
    ///A D3D12_RASTERIZER_DESC structure that describes the rasterizer state.
    D3D12_RASTERIZER_DESC RasterizerState;
    ///A D3D12_DEPTH_STENCIL_DESC structure that describes the depth-stencil state.
    D3D12_DEPTH_STENCIL_DESC DepthStencilState;
    ///A D3D12_INPUT_LAYOUT_DESC structure that describes the input-buffer data for the input-assembler stage.
    D3D12_INPUT_LAYOUT_DESC InputLayout;
    ///Specifies the properties of the index buffer in a D3D12_INDEX_BUFFER_STRIP_CUT_VALUE structure.
    D3D12_INDEX_BUFFER_STRIP_CUT_VALUE IBStripCutValue;
    ///A D3D12_PRIMITIVE_TOPOLOGY_TYPE-typed value for the type of primitive, and ordering of the primitive data.
    D3D12_PRIMITIVE_TOPOLOGY_TYPE PrimitiveTopologyType;
    ///The number of render target formats in the <b>RTVFormats</b> member.
    uint                NumRenderTargets;
    ///An array of DXGI_FORMAT-typed values for the render target formats.
    DXGI_FORMAT[8]      RTVFormats;
    ///A DXGI_FORMAT-typed value for the depth-stencil format.
    DXGI_FORMAT         DSVFormat;
    ///A DXGI_SAMPLE_DESC structure that specifies multisampling parameters.
    DXGI_SAMPLE_DESC    SampleDesc;
    ///For single GPU operation, set this to zero. If there are multiple GPU nodes, set bits to identify the nodes (the
    ///device's physical adapters) for which the graphics pipeline state is to apply. Each bit in the mask corresponds
    ///to a single node. Refer to Multi-adapter systems.
    uint                NodeMask;
    ///A cached pipeline state object, as a D3D12_CACHED_PIPELINE_STATE structure. pCachedBlob and CachedBlobSizeInBytes
    ///may be set to NULL and 0 respectively.
    D3D12_CACHED_PIPELINE_STATE CachedPSO;
    ///A D3D12_PIPELINE_STATE_FLAGS enumeration constant such as for "tool debug".
    D3D12_PIPELINE_STATE_FLAGS Flags;
}

///Describes a compute pipeline state object.
struct D3D12_COMPUTE_PIPELINE_STATE_DESC
{
    ///A pointer to the ID3D12RootSignature object.
    ID3D12RootSignature pRootSignature;
    ///A D3D12_SHADER_BYTECODE structure that describes the compute shader.
    D3D12_SHADER_BYTECODE CS;
    ///For single GPU operation, set this to zero. If there are multiple GPU nodes, set bits to identify the nodes (the
    ///device's physical adapters) for which the compute pipeline state is to apply. Each bit in the mask corresponds to
    ///a single node. Refer to Multi-adapter systems.
    uint                NodeMask;
    ///A cached pipeline state object, as a D3D12_CACHED_PIPELINE_STATE structure. pCachedBlob and CachedBlobSizeInBytes
    ///may be set to NULL and 0 respectively.
    D3D12_CACHED_PIPELINE_STATE CachedPSO;
    ///A D3D12_PIPELINE_STATE_FLAGS enumeration constant such as for "tool debug".
    D3D12_PIPELINE_STATE_FLAGS Flags;
}

///Wraps an array of render target formats.
struct D3D12_RT_FORMAT_ARRAY
{
    ///Specifies a fixed-size array of DXGI_FORMAT values that define the format of up to 8 render targets.
    DXGI_FORMAT[8] RTFormats;
    ///Specifies the number of render target formats stored in the array.
    uint           NumRenderTargets;
}

///Describes a pipeline state stream.
struct D3D12_PIPELINE_STATE_STREAM_DESC
{
    ///SAL: <code>_In_</code> Specifies the size of the opaque data structure pointed to by the
    ///pPipelineStateSubobjectStream member, in bytes.
    size_t SizeInBytes;
    ///SAL: <code>_In_reads_(_Inexpressible_("Dependentonsizeofsubobjects"))</code> Specifies the address of a data
    ///structure that describes as a bytestream an arbitrary pipeline state subobject.
    void*  pPipelineStateSubobjectStream;
}

///Describes Direct3D 12 feature options in the current graphics driver.
struct D3D12_FEATURE_DATA_D3D12_OPTIONS
{
    ///Specifies whether <b>double</b> types are allowed for shader operations. If <b>TRUE</b>, double types are
    ///allowed; otherwise <b>FALSE</b>. The supported operations are equivalent to Direct3D 11's
    ///<b>ExtendedDoublesShaderInstructions</b> member of the D3D11_FEATURE_DATA_D3D11_OPTIONS structure. To use any
    ///HLSL shader that is compiled with a <b>double</b> type, the runtime must set <b>DoublePrecisionFloatShaderOps</b>
    ///to <b>TRUE</b>.
    BOOL DoublePrecisionFloatShaderOps;
    ///Specifies whether logic operations are available in blend state. The runtime sets this member to <b>TRUE</b> if
    ///logic operations are available in blend state and <b>FALSE</b> otherwise. This member is <b>FALSE</b> for feature
    ///level 9.1, 9.2, and 9.3. This member is optional for feature level 10, 10.1, and 11. This member is <b>TRUE</b>
    ///for feature level 11.1 and 12.
    BOOL OutputMergerLogicOp;
    ///A combination of D3D12_SHADER_MIN_PRECISION_SUPPORT-typed values that are combined by using a bitwise OR
    ///operation. The resulting value specifies minimum precision levels that the driver supports for shader stages. A
    ///value of zero indicates that the driver supports only full 32-bit precision for all shader stages.
    D3D12_SHADER_MIN_PRECISION_SUPPORT MinPrecisionSupport;
    ///Specifies whether the hardware and driver support tiled resources. The runtime sets this member to a
    ///D3D12_TILED_RESOURCES_TIER-typed value that indicates if the hardware and driver support tiled resources and at
    ///what tier level.
    D3D12_TILED_RESOURCES_TIER TiledResourcesTier;
    ///Specifies the level at which the hardware and driver support resource binding. The runtime sets this member to a
    ///D3D12_RESOURCE_BINDING_TIER-typed value that indicates the tier level.
    D3D12_RESOURCE_BINDING_TIER ResourceBindingTier;
    ///Specifies whether pixel shader stencil ref is supported. If <b>TRUE</b>, it's supported; otherwise <b>FALSE</b>.
    BOOL PSSpecifiedStencilRefSupported;
    ///Specifies whether the loading of additional formats for typed unordered-access views (UAVs) is supported. If
    ///<b>TRUE</b>, it's supported; otherwise <b>FALSE</b>.
    BOOL TypedUAVLoadAdditionalFormats;
    ///Specifies whether Rasterizer Order Views (ROVs) are supported. If <b>TRUE</b>, they're supported; otherwise
    ///<b>FALSE</b>.
    BOOL ROVsSupported;
    ///Specifies the level at which the hardware and driver support conservative rasterization. The runtime sets this
    ///member to a D3D12_CONSERVATIVE_RASTERIZATION_TIER-typed value that indicates the tier level.
    D3D12_CONSERVATIVE_RASTERIZATION_TIER ConservativeRasterizationTier;
    ///Don't use this field; instead, use the D3D12_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT query (a structure with a
    ///<b>MaxGPUVirtualAddressBitsPerResource</b> member), which is more accurate.
    uint MaxGPUVirtualAddressBitsPerResource;
    ///TRUE if the hardware supports textures with the 64KB standard swizzle pattern. Support for this pattern enables
    ///zero-copy texture optimizations while providing near-equilateral locality for each dimension within the texture.
    ///For texture swizzle options and restrictions, see D3D12_TEXTURE_LAYOUT.
    BOOL StandardSwizzle64KBSupported;
    ///A D3D12_CROSS_NODE_SHARING_TIER enumeration constant that specifies the level of sharing across nodes of an
    ///adapter that has multiple nodes, such as Tier 1 Emulated, Tier 1, or Tier 2.
    D3D12_CROSS_NODE_SHARING_TIER CrossNodeSharingTier;
    ///FALSE means the device only supports copy operations to and from cross-adapter row-major textures. TRUE means the
    ///device supports shader resource views, unordered access views, and render target views of cross-adapter row-major
    ///textures. "Cross-adapter" means between multiple adapters (even from different IHVs).
    BOOL CrossAdapterRowMajorTextureSupported;
    ///Whether the viewport (VP) and Render Target (RT) array index from any shader feeding the rasterizer are supported
    ///without geometry shader emulation. Compare the <b>VPAndRTArrayIndexFromAnyShaderFeedingRasterizer</b> member of
    ///the D3D11_FEATURE_DATA_D3D11_OPTIONS3 structure. In ID3D12ShaderReflection::GetRequiresFlags, see the
    BOOL VPAndRTArrayIndexFromAnyShaderFeedingRasterizerSupportedWithoutGSEmulation;
    ///Specifies the level at which the hardware and driver require heap attribution related to resource type. The
    ///runtime sets this member to a D3D12_RESOURCE_HEAP_TIER enumeration constant.
    D3D12_RESOURCE_HEAP_TIER ResourceHeapTier;
}

///Describes the level of support for HLSL 6.0 wave operations.
struct D3D12_FEATURE_DATA_D3D12_OPTIONS1
{
    ///True if the driver supports HLSL 6.0 wave operations.
    BOOL WaveOps;
    ///Specifies the baseline number of lanes in the SIMD wave that this implementation can support. This term is
    ///sometimes known as "wavefront size" or "warp width". Currently apps should rely only on this minimum value for
    ///sizing workloads.
    uint WaveLaneCountMin;
    ///Specifies the maximum number of lanes in the SIMD wave that this implementation can support. This capability is
    ///reserved for future expansion, and is not expected to be used by current applications.
    uint WaveLaneCountMax;
    ///Specifies the total number of SIMD lanes on the hardware.
    uint TotalLaneCount;
    ///Indicates transitions are possible in and out of the CBV, and indirect argument states, on compute command lists.
    ///If CheckFeatureSupport succeeds this value will always be true.
    BOOL ExpandedComputeResourceStates;
    ///Indicates that 64bit integer operations are supported.
    BOOL Int64ShaderOps;
}

///Indicates the level of support that the adapter provides for depth-bounds tests and programmable sample positions.
struct D3D12_FEATURE_DATA_D3D12_OPTIONS2
{
    ///SAL: <code>_Out_</code> On return, contains true if depth-bounds tests are supported; otherwise, false.
    BOOL DepthBoundsTestSupported;
    ///SAL: <code>_Out_</code> On return, contains a value that indicates the level of support offered for programmable
    ///sample positions.
    D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER ProgrammableSamplePositionsTier;
}

///Indicates root signature version support.
struct D3D12_FEATURE_DATA_ROOT_SIGNATURE
{
    ///On input, specifies the highest version D3D_ROOT_SIGNATURE_VERSION to check for. On output specifies the highest
    ///version, up to the input version specified, actually available.
    D3D_ROOT_SIGNATURE_VERSION HighestVersion;
}

///Provides detail about the adapter architecture, so that your application can better optimize for certain adapter
///properties. <div class="alert"><b>Note</b> This structure has been superseded by the D3D12_FEATURE_DATA_ARCHITECTURE1
///structure. If your application targets Windows 10, version 1703 (Creators' Update) or higher, then use
///<b>D3D12_FEATURE_DATA_ARCHITECTURE1</b> (and D3D12_FEATURE_ARCHITECTURE1) instead.</div><div> </div>
struct D3D12_FEATURE_DATA_ARCHITECTURE
{
    ///In multi-adapter operation, this indicates which physical adapter of the device is relevant. See Multi-adapter
    ///systems. <b>NodeIndex</b> is filled out by the application before calling CheckFeatureSupport, as the application
    ///can retrieve details about the architecture of each adapter.
    uint NodeIndex;
    ///Specifies whether the hardware and driver support a tile-based renderer. The runtime sets this member to
    ///<b>TRUE</b> if the hardware and driver support a tile-based renderer.
    BOOL TileBasedRenderer;
    ///Specifies whether the hardware and driver support UMA. The runtime sets this member to <b>TRUE</b> if the
    ///hardware and driver support UMA.
    BOOL UMA;
    ///Specifies whether the hardware and driver support cache-coherent UMA. The runtime sets this member to <b>TRUE</b>
    ///if the hardware and driver support cache-coherent UMA.
    BOOL CacheCoherentUMA;
}

///Provides detail about each adapter's architectural details, so that your application can better optimize for certain
///adapter properties. <div class="alert"><b>Note</b> This structure, introduced in Windows 10, version 1703 (Creators'
///Update), supersedes the D3D12_FEATURE_DATA_ARCHITECTURE structure. If your application targets Windows 10, version
///1703 (Creators' Update) or higher, then use <b>D3D12_FEATURE_DATA_ARCHITECTURE1</b> (and
///D3D12_FEATURE_ARCHITECTURE1).</div><div> </div>
struct D3D12_FEATURE_DATA_ARCHITECTURE1
{
    ///In multi-adapter operation, this indicates which physical adapter of the device is relevant. See Multi-adapter
    ///systems. <b>NodeIndex</b> is filled out by the application before calling CheckFeatureSupport, as the application
    ///can retrieve details about the architecture of each adapter.
    uint NodeIndex;
    ///Specifies whether the hardware and driver support a tile-based renderer. The runtime sets this member to
    ///<b>TRUE</b> if the hardware and driver support a tile-based renderer.
    BOOL TileBasedRenderer;
    ///Specifies whether the hardware and driver support UMA. The runtime sets this member to <b>TRUE</b> if the
    ///hardware and driver support UMA.
    BOOL UMA;
    ///Specifies whether the hardware and driver support cache-coherent UMA. The runtime sets this member to <b>TRUE</b>
    ///if the hardware and driver support cache-coherent UMA.
    BOOL CacheCoherentUMA;
    ///SAL: <code>_Out_</code> Specifies whether the hardware and driver support isolated Memory Management Unit (MMU).
    ///The runtime sets this member to <b>TRUE</b> if the GPU honors CPU page table properties like
    ///<b>MEM_WRITE_WATCH</b> (for more information, see VirtualAlloc) and <b>PAGE_READONLY</b> (for more information,
    ///see Memory Protection Constants). If <b>TRUE</b>, the application must take care to no use memory with these page
    ///table properties with the GPU, as the GPU might trigger these page table properties in unexpected ways. For
    ///example, GPU write operations might be coarser than the application expects, particularly writes from within
    ///shaders. Certain write-watch pages migth appear dirty, even when it isn't obvious how GPU writes may have
    ///affected them. GPU operations associated with upload and readback heap usage scenarios work well with write-watch
    ///pages, but might occasionally generate false positives that can be safely ignored.
    BOOL IsolatedMMU;
}

///Describes info about the feature levels supported by the current graphics driver.
struct D3D12_FEATURE_DATA_FEATURE_LEVELS
{
    ///The number of feature levels in the array at <b>pFeatureLevelsRequested</b>.
    uint              NumFeatureLevels;
    ///A pointer to an array of D3D_FEATURE_LEVELs that the application is requesting for the driver and hardware to
    ///evaluate.
    const(D3D_FEATURE_LEVEL)* pFeatureLevelsRequested;
    ///The maximum feature level that the driver and hardware support.
    D3D_FEATURE_LEVEL MaxSupportedFeatureLevel;
}

///Contains the supported shader model.
struct D3D12_FEATURE_DATA_SHADER_MODEL
{
    ///Specifies one member of D3D_SHADER_MODEL that indicates the maximum supported shader model.
    D3D_SHADER_MODEL HighestShaderModel;
}

///Describes which resources are supported by the current graphics driver for a given format.
struct D3D12_FEATURE_DATA_FORMAT_SUPPORT
{
    ///A DXGI_FORMAT-typed value for the format to return info about.
    DXGI_FORMAT Format;
    ///A combination of D3D12_FORMAT_SUPPORT1-typed values that are combined by using a bitwise OR operation. The
    ///resulting value specifies which resources are supported.
    D3D12_FORMAT_SUPPORT1 Support1;
    ///A combination of D3D12_FORMAT_SUPPORT2-typed values that are combined by using a bitwise OR operation. The
    ///resulting value specifies which unordered resource options are supported.
    D3D12_FORMAT_SUPPORT2 Support2;
}

///Describes the multi-sampling image quality levels for a given format and sample count.
struct D3D12_FEATURE_DATA_MULTISAMPLE_QUALITY_LEVELS
{
    ///A DXGI_FORMAT-typed value for the format to return info about.
    DXGI_FORMAT Format;
    ///The number of multi-samples per pixel to return info about.
    uint        SampleCount;
    ///Flags to control quality levels, as a bitwise-OR'd combination of D3D12_MULTISAMPLE_QUALITY_LEVEL_FLAGS
    ///enumeration constants. The resulting value specifies options for determining quality levels.
    D3D12_MULTISAMPLE_QUALITY_LEVEL_FLAGS Flags;
    ///The number of quality levels.
    uint        NumQualityLevels;
}

///Describes a DXGI data format and plane count.
struct D3D12_FEATURE_DATA_FORMAT_INFO
{
    ///A DXGI_FORMAT-typed value for the format to return info about.
    DXGI_FORMAT Format;
    ///The number of planes to provide information about.
    ubyte       PlaneCount;
}

///Details the adapter's GPU virtual address space limitations, including maximum address bits per resource and per
///process.
struct D3D12_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT
{
    ///The maximum GPU virtual address bits per resource. Some adapters have significantly less bits available per
    ///resource than per process, while other adapters have significantly greater bits available per resource than per
    ///process. The latter scenario tends to happen in less common scenarios, like when running a 32-bit process on
    ///certain UMA adapters. When per resource capabilities are greater than per process, the greater per resource
    ///capabilities can only be leveraged by reserved resources or NULL mapped pages.
    uint MaxGPUVirtualAddressBitsPerResource;
    ///The maximum GPU virtual address bits per process. When this value is nearly equal to the available residency
    ///budget, Evict will not be a feasible option to manage residency. See MakeResident for more details.
    uint MaxGPUVirtualAddressBitsPerProcess;
}

///Describes the level of shader caching supported in the current graphics driver.
struct D3D12_FEATURE_DATA_SHADER_CACHE
{
    ///Type: [**D3D12_SHADER_CACHE_SUPPORT_FLAGS**](./ne-d3d12-d3d12_shader_cache_support_flags.md) SAL:
    ///<code>_Out_</code> Indicates the level of caching supported.
    D3D12_SHADER_CACHE_SUPPORT_FLAGS SupportFlags;
}

///Details the adapter's support for prioritization of different command queue types.
struct D3D12_FEATURE_DATA_COMMAND_QUEUE_PRIORITY
{
    ///SAL: <code>_In_</code> The type of the command list you're interested in.
    D3D12_COMMAND_LIST_TYPE CommandListType;
    ///SAL: <code>_In_</code> The priority level you're interested in.
    uint Priority;
    ///SAL: <code>_Out_</code> On return, contains true if the specfied command list type supports the specified
    ///priority level; otherwise, false.
    BOOL PriorityForTypeIsSupported;
}

///Indicates the level of support that the adapter provides for timestamp queries, format-casting, immediate write, view
///instancing, and barycentrics.
struct D3D12_FEATURE_DATA_D3D12_OPTIONS3
{
    ///Indicates whether timestamp queries are supported on copy queues.
    BOOL CopyQueueTimestampQueriesSupported;
    ///Indicates whether casting from one fully typed format to another, compatible, format is supported.
    BOOL CastingFullyTypedFormatSupported;
    ///Indicates the kinds of command lists that support the ability to write an immediate value directly from the
    ///command stream into a specified buffer.
    D3D12_COMMAND_LIST_SUPPORT_FLAGS WriteBufferImmediateSupportFlags;
    ///Indicates the level of support the adapter has for view instancing.
    D3D12_VIEW_INSTANCING_TIER ViewInstancingTier;
    ///Indicates whether barycentrics are supported.
    BOOL BarycentricsSupported;
}

///Provides detail about whether the adapter supports creating heaps from existing system memory. Such heaps are not
///intended for general use, but are exceptionally useful for diagnostic purposes, because they are guaranteed to
///persist even after the adapter faults or experiences a device-removal event. Persistence is not guaranteed for heaps
///returned by ID3D12Device::CreateHeap or ID3D12Device::CreateCommittedResource, even when the heap resides in system
///memory.
struct D3D12_FEATURE_DATA_EXISTING_HEAPS
{
    ///<b>TRUE</b> if the adapter can create a heap from existing system memory. Otherwise, <b>FALSE</b>.
    BOOL Supported;
}

///Indicates the level of support for 64KB-aligned MSAA textures, cross-API sharing, and native 16-bit shader
///operations.
struct D3D12_FEATURE_DATA_D3D12_OPTIONS4
{
    ///Type: **[BOOL](/windows/desktop/winprog/windows-data-types)** Indicates whether 64KB-aligned MSAA textures are
    ///supported.
    BOOL MSAA64KBAlignedTextureSupported;
    ///Type:
    ///**[D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER](/windows/desktop/api/d3d12/ne-d3d12-d3d12_shared_resource_compatibility_tier)**
    ///Indicates the tier of cross-API sharing support.
    D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER SharedResourceCompatibilityTier;
    ///Type: **[BOOL](/windows/desktop/winprog/windows-data-types)** Indicates native 16-bit shader operations are
    ///supported. These operations require shader model 6_2. For more information, see the [16-Bit Scalar
    ///Types](https://github.com/microsoft/DirectXShaderCompiler/wiki/16-Bit-Scalar-Types) HLSL reference.
    BOOL Native16BitShaderOpsSupported;
}

///Indicates the level of support for heap serialization.
struct D3D12_FEATURE_DATA_SERIALIZATION
{
    ///Type: **[UINT](/windows/desktop/WinProg/windows-data-types)** An input field, indicating the adapter index to
    ///query.
    uint NodeIndex;
    ///Type: **[D3D12_HEAP_SERIALIZATION_TIER](/windows/desktop/api/d3d12/ne-d3d12-d3d12_heap_serialization_tier)** An
    ///output field, indicating the tier of heap serialization support.
    D3D12_HEAP_SERIALIZATION_TIER HeapSerializationTier;
}

///Indicates the level of support for the sharing of resources between different adapters&mdash;for example, multiple
///GPUs.
struct D3D12_FEATURE_DATA_CROSS_NODE
{
    ///Type: <b>[D3D12_CROSS_NODE_SHARING_TIER](/windows/desktop/api/d3d12/ne-d3d12-d3d12_cross_node_sharing_tier)</b>
    ///Indicates the tier of cross-adapter sharing support.
    D3D12_CROSS_NODE_SHARING_TIER SharingTier;
    ///Type: <b>[BOOL](/windows/desktop/winprog/windows-data-types)</b> Indicates there is support for shader
    ///instructions which operate across adapters.
    BOOL AtomicShaderInstructions;
}

///Indicates the level of support that the adapter provides for render passes, ray tracing, and shader-resource view
///tier 3 tiled resources.
struct D3D12_FEATURE_DATA_D3D12_OPTIONS5
{
    ///A boolean value indicating whether the options require shader-resource view tier 3 tiled resource support. For
    ///more information, see D3D12_TILED_RESOURCES_TIER.
    BOOL SRVOnlyTiledResourceTier3;
    ///The extent to which a device driver and/or the hardware efficiently supports render passes.
    D3D12_RENDER_PASS_TIER RenderPassesTier;
    D3D12_RAYTRACING_TIER RaytracingTier;
}

///Indicates the level of support that the adapter provides for variable-rate shading (VRS), and indicates whether or
///not background processing is supported. For more info, see [Variable-rate shading
///(VRS)](/windows/desktop/direct3d12/vrs), and the [Direct3D 12 background processing
///spec](https://microsoft.github.io/DirectX-Specs/d3d/BackgroundProcessing.html).
struct D3D12_FEATURE_DATA_D3D12_OPTIONS6
{
    ///Type: <b>[BOOL](/windows/desktop/winprog/windows-data-types)</b> Indicates whether 2x4, 4x2, and 4x4 coarse pixel
    ///sizes are supported for single-sampled rendering; and whether coarse pixel size 2x4 is supported for 2x MSAA.
    ///`true` if those sizes are supported, otherwise `false`.
    BOOL AdditionalShadingRatesSupported;
    ///Type: <b>[BOOL](/windows/desktop/winprog/windows-data-types)</b> Indicates whether the per-provoking-vertex (also
    ///known as per-primitive) rate can be used with more than one viewport. If so, then, in that case, that rate can be
    ///used when `SV_ViewportIndex` is written to. `true` if that rate can be used with more than one viewport,
    ///otherwise `false`.
    BOOL PerPrimitiveShadingRateSupportedWithViewportIndexing;
    ///Type:
    ///<b>[D3D12_VARIABLE_SHADING_RATE_TIER](/windows/desktop/api/d3d12/ne-d3d12-d3d12_variable_shading_rate_tier)</b>
    ///Indicates the shading rate tier.
    D3D12_VARIABLE_SHADING_RATE_TIER VariableShadingRateTier;
    ///Type: <b>[UINT](/windows/desktop/winprog/windows-data-types)</b> Indicates the tile size of the screen-space
    ///image as a **UINT**.
    uint ShadingRateImageTileSize;
    ///Type: <b>[BOOL](/windows/desktop/winprog/windows-data-types)</b> Indicates whether or not background processing
    ///is supported. `true` if background processing is supported, otherwise `false`. For more info, see the [Direct3D
    ///12 background processing spec](https://microsoft.github.io/DirectX-Specs/d3d/BackgroundProcessing.html).
    BOOL BackgroundProcessingSupported;
}

struct D3D12_FEATURE_DATA_D3D12_OPTIONS7
{
    D3D12_MESH_SHADER_TIER MeshShaderTier;
    D3D12_SAMPLER_FEEDBACK_TIER SamplerFeedbackTier;
}

///Indicates the level of support that the adapter provides for metacommands.
struct D3D12_FEATURE_DATA_QUERY_META_COMMAND
{
    ///Type: <b>[GUID](../guiddef/ns-guiddef-guid.md)</b> The fixed GUID that identfies the metacommand to query about.
    GUID         CommandId;
    ///Type: <b>[UINT](/windows/win32/winprog/windows-data-types)</b> For single GPU operation, this is zero. If there
    ///are multiple GPU nodes, a bit is set to identify a node (the device's physical adapter). Each bit in the mask
    ///corresponds to a single node. Only 1 bit must be set. Refer to [Multi-adapter
    ///systems](/windows/win32/direct3d12/multi-engine).
    uint         NodeMask;
    ///Type: <b> const [void](/windows/win32/winprog/windows-data-types)\*</b> A pointer to a buffer containing the
    ///query input data. Allocate *QueryInputDataSizeInBytes* bytes.
    const(void)* pQueryInputData;
    ///Type: <b>[SIZE_T](/windows/win32/winprog/windows-data-types)</b> The size of the buffer pointed to by
    ///*pQueryInputData*, in bytes.
    size_t       QueryInputDataSizeInBytes;
    ///Type: <b>[void](/windows/win32/winprog/windows-data-types)\*</b> A pointer to a buffer containing the query
    ///output data.
    void*        pQueryOutputData;
    ///Type: <b>[SIZE_T](/windows/win32/winprog/windows-data-types)</b> The size of the buffer pointed to by
    ///*pQueryOutputData*, in bytes.
    size_t       QueryOutputDataSizeInBytes;
}

///Describes parameters needed to allocate resources.
struct D3D12_RESOURCE_ALLOCATION_INFO
{
    ///Type: **[UINT64](/windows/win32/WinProg/windows-data-types)** The size, in bytes, of the resource.
    ulong SizeInBytes;
    ///Type: **[UINT64](/windows/win32/WinProg/windows-data-types)** The alignment value for the resource; one of 4KB
    ///(4096), 64KB (65536), or 4MB (4194304) alignment.
    ulong Alignment;
}

///Describes parameters needed to allocate resources, including offset.
struct D3D12_RESOURCE_ALLOCATION_INFO1
{
    ///Type: **[UINT64](/windows/win32/WinProg/windows-data-types)** The offset, in bytes, of the resource.
    ulong Offset;
    ///Type: **[UINT64](/windows/win32/WinProg/windows-data-types)** The alignment value for the resource; one of 4KB
    ///(4096), 64KB (65536), or 4MB (4194304) alignment.
    ulong Alignment;
    ///Type: **[UINT64](/windows/win32/WinProg/windows-data-types)** The size, in bytes, of the resource.
    ulong SizeInBytes;
}

///Describes heap properties.
struct D3D12_HEAP_PROPERTIES
{
    ///A D3D12_HEAP_TYPE-typed value that specifies the type of heap.
    D3D12_HEAP_TYPE   Type;
    ///A D3D12_CPU_PAGE_PROPERTY-typed value that specifies the CPU-page properties for the heap.
    D3D12_CPU_PAGE_PROPERTY CPUPageProperty;
    ///A D3D12_MEMORY_POOL-typed value that specifies the memory pool for the heap.
    D3D12_MEMORY_POOL MemoryPoolPreference;
    ///For multi-adapter operation, this indicates the node where the resource should be created. Exactly one bit of
    ///this UINT must be set. See Multi-adapter systems. Passing zero is equivalent to passing one, in order to simplify
    ///the usage of single-GPU adapters.
    uint              CreationNodeMask;
    ///For multi-adapter operation, this indicates the set of nodes where the resource is visible.
    ///<i>VisibleNodeMask</i> must have the same bit set that is set in <i>CreationNodeMask</i>. <i>VisibleNodeMask</i>
    ///can *also* have additional bits set for cross-node resources, but doing so can potentially reduce performance for
    ///resource accesses, so you should do so only when needed. Passing zero is equivalent to passing one, in order to
    ///simplify the usage of single-GPU adapters.
    uint              VisibleNodeMask;
}

///Describes a heap.
struct D3D12_HEAP_DESC
{
    ///The size, in bytes, of the heap. To avoid wasting memory, applications should pass <i>SizeInBytes</i> values
    ///which are multiples of the effective <i>Alignment</i>; but non-aligned <i>SizeInBytes</i> is also supported, for
    ///convenience. To find out how large a heap must be to support textures with undefined layouts and adapter-specific
    ///sizes, call ID3D12Device::GetResourceAllocationInfo.
    ulong            SizeInBytes;
    ///A D3D12_HEAP_PROPERTIES structure that describes the heap properties.
    D3D12_HEAP_PROPERTIES Properties;
    ///The alignment value for the heap. Valid values: <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>0
    ///</td> <td>An alias for 64KB. </td> </tr> <tr> <td>D3D12_DEFAULT_RESOURCE_PLACEMENT_ALIGNMENT </td> <td>
    ulong            Alignment;
    ///A combination of D3D12_HEAP_FLAGS-typed values that are combined by using a bitwise-OR operation. The resulting
    ///value identifies heap options. When creating heaps to support adapters with resource heap tier 1, an application
    ///must choose some flags.
    D3D12_HEAP_FLAGS Flags;
}

///Describes the dimensions of a mip region.
struct D3D12_MIP_REGION
{
    ///The width of the mip region.
    uint Width;
    ///The height of the mip region.
    uint Height;
    ///The depth of the mip region.
    uint Depth;
}

///Describes a resource, such as a texture. This structure is used extensively.
struct D3D12_RESOURCE_DESC
{
    ///One member of D3D12_RESOURCE_DIMENSION, specifying the dimensions of the resource (for example,
    ///D3D12_RESOURCE_DIMENSION_TEXTURE1D), or whether it is a buffer ((D3D12_RESOURCE_DIMENSION_BUFFER).
    D3D12_RESOURCE_DIMENSION Dimension;
    ///Specifies the alignment.
    ulong                Alignment;
    ///Specifies the width of the resource.
    ulong                Width;
    ///Specifies the height of the resource.
    uint                 Height;
    ///Specifies the depth of the resource, if it is 3D, or the array size if it is an array of 1D or 2D resources.
    ushort               DepthOrArraySize;
    ///Specifies the number of MIP levels.
    ushort               MipLevels;
    ///Specifies one member of DXGI_FORMAT.
    DXGI_FORMAT          Format;
    ///Specifies a DXGI_SAMPLE_DESC structure.
    DXGI_SAMPLE_DESC     SampleDesc;
    ///Specifies one member of D3D12_TEXTURE_LAYOUT.
    D3D12_TEXTURE_LAYOUT Layout;
    ///Bitwise-OR'd flags, as D3D12_RESOURCE_FLAGS enumeration constants.
    D3D12_RESOURCE_FLAGS Flags;
}

///Describes a resource, such as a texture, including a mip region. This structure is used in several methods.
struct D3D12_RESOURCE_DESC1
{
    ///One member of D3D12_RESOURCE_DIMENSION, specifying the dimensions of the resource (for example,
    ///D3D12_RESOURCE_DIMENSION_TEXTURE1D), or whether it is a buffer ((D3D12_RESOURCE_DIMENSION_BUFFER).
    D3D12_RESOURCE_DIMENSION Dimension;
    ///Specifies the alignment.
    ulong                Alignment;
    ///Specifies the width of the resource.
    ulong                Width;
    ///Specifies the height of the resource.
    uint                 Height;
    ///Specifies the depth of the resource, if it is 3D, or the array size if it is an array of 1D or 2D resources.
    ushort               DepthOrArraySize;
    ///Specifies the number of MIP levels.
    ushort               MipLevels;
    ///Specifies one member of DXGI_FORMAT.
    DXGI_FORMAT          Format;
    ///Specifies a DXGI_SAMPLE_DESC structure.
    DXGI_SAMPLE_DESC     SampleDesc;
    ///Specifies one member of D3D12_TEXTURE_LAYOUT.
    D3D12_TEXTURE_LAYOUT Layout;
    ///Bitwise-OR'd flags, as D3D12_RESOURCE_FLAGS enumeration constants.
    D3D12_RESOURCE_FLAGS Flags;
    ///A [D3D12_MIP_REGION](./ns-d3d12-d3d12_mip_region.md) struct.
    D3D12_MIP_REGION     SamplerFeedbackMipRegion;
}

///Specifies a depth and stencil value.
struct D3D12_DEPTH_STENCIL_VALUE
{
    ///Specifies the depth value.
    float Depth;
    ///Specifies the stencil value.
    ubyte Stencil;
}

///Describes a value used to optimize clear operations for a particular resource.
struct D3D12_CLEAR_VALUE
{
    ///Specifies one member of the DXGI_FORMAT enum. The format of the commonly cleared color follows the same
    ///validation rules as a view/ descriptor creation. In general, the format of the clear color can be any format in
    ///the same typeless group that the resource format belongs to. This <i>Format</i> must match the format of the view
    ///used during the clear operation. It indicates whether the <i>Color</i> or the <i>DepthStencil</i> member is valid
    ///and how to convert the values for usage with the resource.
    DXGI_FORMAT Format;
union
    {
        float[4] Color;
        D3D12_DEPTH_STENCIL_VALUE DepthStencil;
    }
}

///Describes a memory range.
struct D3D12_RANGE
{
    ///The offset, in bytes, denoting the beginning of a memory range.
    size_t Begin;
    ///The offset, in bytes, denoting the end of a memory range. <b>End</b> is one-past-the-end.
    size_t End;
}

///Describes a memory range in a 64-bit address space.
struct D3D12_RANGE_UINT64
{
    ///The offset, in bytes, denoting the beginning of a memory range.
    ulong Begin;
    ///The offset, in bytes, denoting the end of a memory range. <b>End</b> is one-past-the-end.
    ulong End;
}

///Describes a subresource memory range.
struct D3D12_SUBRESOURCE_RANGE_UINT64
{
    ///The index of the subresource.
    uint               Subresource;
    ///A memory range within the subresource.
    D3D12_RANGE_UINT64 Range;
}

///Describes subresource data.
struct D3D12_SUBRESOURCE_INFO
{
    ///Offset, in bytes, between the start of the parent resource and this subresource.
    ulong Offset;
    ///The row pitch, or width, or physical size, in bytes, of the subresource data.
    uint  RowPitch;
    ///The depth pitch, or width, or physical size, in bytes, of the subresource data.
    uint  DepthPitch;
}

///Describes the coordinates of a tiled resource.
struct D3D12_TILED_RESOURCE_COORDINATE
{
    ///The x-coordinate of the tiled resource.
    uint X;
    ///The y-coordinate of the tiled resource.
    uint Y;
    ///The z-coordinate of the tiled resource.
    uint Z;
    ///The index of the subresource for the tiled resource.
    uint Subresource;
}

///Describes the size of a tiled region.
struct D3D12_TILE_REGION_SIZE
{
    ///The number of tiles in the tiled region.
    uint   NumTiles;
    ///Specifies whether the runtime uses the <b>Width</b>, <b>Height</b>, and <b>Depth</b> members to define the
    ///region. If <b>TRUE</b>, the runtime uses the <b>Width</b>, <b>Height</b>, and <b>Depth</b> members to define the
    ///region. In this case, <b>NumTiles</b> should be equal to <b>Width</b> * <b>Height</b> * <b>Depth</b>. If
    ///<b>FALSE</b>, the runtime ignores the <b>Width</b>, <b>Height</b>, and <b>Depth</b> members and uses the
    ///<b>NumTiles</b> member to traverse tiles in the resource linearly across x, then y, then z (as applicable) and
    ///then spills over mipmaps/arrays in subresource order. For example, use this technique to map an entire resource
    ///at once. Regardless of whether you specify <b>TRUE</b> or <b>FALSE</b> for <b>UseBox</b>, you use a
    ///D3D12_TILED_RESOURCE_COORDINATE structure to specify the starting location for the region within the resource as
    ///a separate parameter outside of this structure by using x, y, and z coordinates. When the region includes mipmaps
    ///that are packed with nonstandard tiling, <b>UseBox</b> must be <b>FALSE</b> because tile dimensions are not
    ///standard and the app only knows a count of how many tiles are consumed by the packed area, which is per array
    ///slice. The corresponding (separate) starting location parameter uses x to offset into the flat range of tiles in
    ///this case, and y and z coordinates must each be 0.
    BOOL   UseBox;
    ///The width of the tiled region, in tiles. Used for buffer and 1D, 2D, and 3D textures.
    uint   Width;
    ///The height of the tiled region, in tiles. Used for 2D and 3D textures.
    ushort Height;
    ///The depth of the tiled region, in tiles. Used for 3D textures or arrays. For arrays, used for advancing in depth
    ///jumps to next slice of same mipmap size, which isn't contiguous in the subresource counting space if there are
    ///multiple mipmaps.
    ushort Depth;
}

///Describes a tiled subresource volume.
struct D3D12_SUBRESOURCE_TILING
{
    ///The width in tiles of the subresource.
    uint   WidthInTiles;
    ///The height in tiles of the subresource.
    ushort HeightInTiles;
    ///The depth in tiles of the subresource.
    ushort DepthInTiles;
    ///The index of the tile in the overall tiled subresource to start with.
    uint   StartTileIndexInOverallResource;
}

///Describes the shape of a tile by specifying its dimensions.
struct D3D12_TILE_SHAPE
{
    ///The width in texels of the tile.
    uint WidthInTexels;
    ///The height in texels of the tile.
    uint HeightInTexels;
    ///The depth in texels of the tile.
    uint DepthInTexels;
}

///Describes the tile structure of a tiled resource with mipmaps.
struct D3D12_PACKED_MIP_INFO
{
    ///The number of standard mipmaps in the tiled resource.
    ubyte NumStandardMips;
    ///The number of packed mipmaps in the tiled resource. This number starts from the least detailed mipmap (either
    ///sharing tiles or using non standard tile layout). This number is 0 if no such packing is in the resource. For
    ///array surfaces, this value is the number of mipmaps that are packed for a given array slice where each array
    ///slice repeats the same packing. On Tier_2 tiled resources hardware, mipmaps that fill at least one standard
    ///shaped tile in all dimensions are not allowed to be included in the set of packed mipmaps. On Tier_1 hardware,
    ///mipmaps that are an integer multiple of one standard shaped tile in all dimensions are not allowed to be included
    ///in the set of packed mipmaps. Mipmaps with at least one dimension less than the standard tile shape may or may
    ///not be packed. When a given mipmap needs to be packed, all coarser mipmaps for a given array slice are considered
    ///packed as well.
    ubyte NumPackedMips;
    ///The number of tiles for the packed mipmaps in the tiled resource. If there is no packing, this value is
    ///meaningless and is set to 0. Otherwise, it is set to the number of tiles that are needed to represent the set of
    ///packed mipmaps. The pixel layout within the packed mipmaps is hardware specific. If apps define only partial
    ///mappings for the set of tiles in packed mipmaps, read and write behavior is vendor specific and undefined. For
    ///arrays, this value is only the count of packed mipmaps within the subresources for each array slice.
    uint  NumTilesForPackedMips;
    ///The offset of the first packed tile for the resource in the overall range of tiles. If <b>NumPackedMips</b> is 0,
    ///this value is meaningless and is 0. Otherwise, it is the offset of the first packed tile for the resource in the
    ///overall range of tiles for the resource. A value of 0 for <b>StartTileIndexInOverallResource</b> means the entire
    ///resource is packed. For array surfaces, this is the offset for the tiles that contain the packed mipmaps for the
    ///first array slice. Packed mipmaps for each array slice in arrayed surfaces are at this offset past the beginning
    ///of the tiles for each array slice. <div class="alert"><b>Note</b> The number of overall tiles, packed or not, for
    ///a given array slice is simply the total number of tiles for the resource divided by the resource's array size, so
    ///it is easy to locate the range of tiles for any given array slice, out of which
    ///<b>StartTileIndexInOverallResource</b> identifies which of those are packed. </div> <div> </div>
    uint  StartTileIndexInOverallResource;
}

///Describes the transition of subresources between different usages.
struct D3D12_RESOURCE_TRANSITION_BARRIER
{
    ///A pointer to the ID3D12Resource object that represents the resource used in the transition.
    ID3D12Resource pResource;
    ///The index of the subresource for the transition. Use the <b>D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES</b> flag (
    ///0xffffffff ) to transition all subresources in a resource at the same time.
    uint           Subresource;
    ///The "before" usages of the subresources, as a bitwise-OR'd combination of D3D12_RESOURCE_STATES enumeration
    ///constants.
    D3D12_RESOURCE_STATES StateBefore;
    ///The "after" usages of the subresources, as a bitwise-OR'd combination of D3D12_RESOURCE_STATES enumeration
    ///constants.
    D3D12_RESOURCE_STATES StateAfter;
}

///Describes the transition between usages of two different resources that have mappings into the same heap.
struct D3D12_RESOURCE_ALIASING_BARRIER
{
    ///A pointer to the ID3D12Resource object that represents the before resource used in the transition.
    ID3D12Resource pResourceBefore;
    ///A pointer to the ID3D12Resource object that represents the after resource used in the transition.
    ID3D12Resource pResourceAfter;
}

///Represents a resource in which all UAV accesses must complete before any future UAV accesses can begin.
struct D3D12_RESOURCE_UAV_BARRIER
{
    ///The resource used in the transition, as a pointer to ID3D12Resource.
    ID3D12Resource pResource;
}

///Describes a resource barrier (transition in resource use).
struct D3D12_RESOURCE_BARRIER
{
    ///A D3D12_RESOURCE_BARRIER_TYPE-typed value that specifies the type of resource barrier. This member determines
    ///which type to use in the union below.
    D3D12_RESOURCE_BARRIER_TYPE Type;
    ///Specifies a D3D12_RESOURCE_BARRIER_FLAGS enumeration constant such as for "begin only" or "end only".
    D3D12_RESOURCE_BARRIER_FLAGS Flags;
union
    {
        D3D12_RESOURCE_TRANSITION_BARRIER Transition;
        D3D12_RESOURCE_ALIASING_BARRIER Aliasing;
        D3D12_RESOURCE_UAV_BARRIER UAV;
    }
}

///Describes the format, width, height, depth, and row-pitch of the subresource into the parent resource.
struct D3D12_SUBRESOURCE_FOOTPRINT
{
    ///A DXGI_FORMAT-typed value that specifies the viewing format.
    DXGI_FORMAT Format;
    ///The width of the subresource.
    uint        Width;
    ///The height of the subresource.
    uint        Height;
    ///The depth of the subresource.
    uint        Depth;
    ///The row pitch, or width, or physical size, in bytes, of the subresource data. This must be a multiple of
    ///D3D12_TEXTURE_DATA_PITCH_ALIGNMENT (256), and must be greater than or equal to the size of the data within a row.
    uint        RowPitch;
}

///Describes the footprint of a placed subresource, including the offset and the D3D12_SUBRESOURCE_FOOTPRINT.
struct D3D12_PLACED_SUBRESOURCE_FOOTPRINT
{
    ///The offset of the subresource within the parent resource, in bytes. The offset between the start of the parent
    ///resource and this subresource.
    ulong Offset;
    ///The format, width, height, depth, and row-pitch of the subresource, as a D3D12_SUBRESOURCE_FOOTPRINT structure.
    D3D12_SUBRESOURCE_FOOTPRINT Footprint;
}

///Describes a portion of a texture for the purpose of texture copies.
struct D3D12_TEXTURE_COPY_LOCATION
{
    ///Specifies the resource which will be used for the copy operation.<div> </div>When <b>Type</b> is
    ///D3D12_TEXTURE_COPY_TYPE_PLACED_FOOTPRINT, <b>pResource</b> must point to a buffer resource.<div> </div>When
    ///<b>Type</b> is D3D12_TEXTURE_COPY_TYPE_SUBRESOURCE_INDEX, <b>pResource</b> must point to a texture resource.
    ID3D12Resource pResource;
    ///Specifies which type of resource location this is: a subresource of a texture, or a description of a texture
    ///layout which can be applied to a buffer. This D3D12_TEXTURE_COPY_TYPE enum indicates which union member to use.
    D3D12_TEXTURE_COPY_TYPE Type;
union
    {
        D3D12_PLACED_SUBRESOURCE_FOOTPRINT PlacedFootprint;
        uint SubresourceIndex;
    }
}

///Describes a sub-pixel sample position for use with programmable sample positions.
struct D3D12_SAMPLE_POSITION
{
    ///A signed sub-pixel coordinate value in the X axis.
    byte X;
    ///A signed sub-pixel coordinate value in the Y axis.
    byte Y;
}

///Specifies the viewport/stencil and render target associated with a view instance.
struct D3D12_VIEW_INSTANCE_LOCATION
{
    ///The index of the viewport in the viewports array to be used by the view instance associated with this location.
    uint ViewportArrayIndex;
    ///The index of the render target in the render targets array to be used by the view instance associated with this
    ///location.
    uint RenderTargetArrayIndex;
}

///Specifies parameters used during view instancing configuration.
struct D3D12_VIEW_INSTANCING_DESC
{
    ///Specifies the number of views to be used, up to D3D12_MAX_VIEW_INSTANCE_COUNT.
    uint ViewInstanceCount;
    ///The address of a memory location that contains <b>ViewInstanceCount</b> view instance location structures that
    ///specify the location of viewport/scissor and render target details of each view instance.
    const(D3D12_VIEW_INSTANCE_LOCATION)* pViewInstanceLocations;
    ///Configures view instancing with additional options.
    D3D12_VIEW_INSTANCING_FLAGS Flags;
}

///Describes the elements in a buffer resource to use in a shader-resource view.
struct D3D12_BUFFER_SRV
{
    ///The index of the first element to be accessed by the view.
    ulong FirstElement;
    ///The number of elements in the resource.
    uint  NumElements;
    ///The size of each element in the buffer structure (in bytes) when the buffer represents a structured buffer.
    uint  StructureByteStride;
    ///A D3D12_BUFFER_SRV_FLAGS-typed value that identifies view options for the buffer. Currently, the only option is
    ///to identify a raw view of the buffer. For more info about raw viewing of buffers, see Raw Views of Buffers.
    D3D12_BUFFER_SRV_FLAGS Flags;
}

///Specifies the subresource from a 1D texture to use in a shader-resource view.
struct D3D12_TEX1D_SRV
{
    ///Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b> (from the original
    ///Texture1D for which ID3D12Device::CreateShaderResourceView creates a view) -1.
    uint  MostDetailedMip;
    ///The maximum number of mipmap levels for the view of the texture. See the remarks. Set to -1 to indicate all the
    ///mipmap levels from <b>MostDetailedMip</b> on down to least detailed.
    uint  MipLevels;
    ///A value to clamp sample LOD values to. For example, if you specify 2.0f for the clamp value, you ensure that no
    ///individual sample accesses a mip level less than 2.0f.
    float ResourceMinLODClamp;
}

///Describes the subresources from an array of 1D textures to use in a shader-resource view.
struct D3D12_TEX1D_ARRAY_SRV
{
    ///Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b> (from the original
    ///Texture1D for which ID3D12Device::CreateShaderResourceView creates a view) -1.
    uint  MostDetailedMip;
    ///The maximum number of mipmap levels for the view of the texture. See the remarks in D3D12_TEX1D_SRV. Set to -1 to
    ///indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least detailed.
    uint  MipLevels;
    ///The index of the first texture to use in an array of textures.
    uint  FirstArraySlice;
    ///Number of textures in the array.
    uint  ArraySize;
    ///A value to clamp sample LOD values to. For example, if you specify 2.0f for the clamp value, you ensure that no
    ///individual sample accesses a mip level less than 2.0f.
    float ResourceMinLODClamp;
}

///Describes the subresource from a 2D texture to use in a shader-resource view.
struct D3D12_TEX2D_SRV
{
    ///Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b> (from the original
    ///Texture2D for which ID3D12Device::CreateShaderResourceView creates a view) -1.
    uint  MostDetailedMip;
    ///The maximum number of mipmap levels for the view of the texture. See the remarks in D3D12_TEX1D_SRV. Set to -1 to
    ///indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least detailed.
    uint  MipLevels;
    ///The index (plane slice number) of the plane to use in the texture.
    uint  PlaneSlice;
    ///A value to clamp sample LOD values to. For example, if you specify 2.0f for the clamp value, you ensure that no
    ///individual sample accesses a mip level less than 2.0f.
    float ResourceMinLODClamp;
}

///Describes the subresources from an array of 2D textures to use in a shader-resource view.
struct D3D12_TEX2D_ARRAY_SRV
{
    ///Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b> -1 (where
    ///<b>MipLevels</b> is from the original Texture2D for which ID3D12Device::CreateShaderResourceView creates a view).
    uint  MostDetailedMip;
    ///The maximum number of mipmap levels for the view of the texture. See the remarks in D3D12_TEX1D_SRV. Set to -1 to
    ///indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least detailed.
    uint  MipLevels;
    ///The index of the first texture to use in an array of textures.
    uint  FirstArraySlice;
    ///Number of textures in the array.
    uint  ArraySize;
    ///The index (plane slice number) of the plane to use in an array of textures.
    uint  PlaneSlice;
    ///A value to clamp sample LOD values to. For example, if you specify 2.0f for the clamp value, you ensure that no
    ///individual sample accesses a mip level less than 2.0f.
    float ResourceMinLODClamp;
}

///Describes the subresources from a 3D texture to use in a shader-resource view.
struct D3D12_TEX3D_SRV
{
    ///Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b> (from the original
    ///Texture3D for which ID3D12Device::CreateShaderResourceView creates a view) -1.
    uint  MostDetailedMip;
    ///The maximum number of mipmap levels for the view of the texture. See the remarks in D3D12_TEX1D_SRV. Set to -1 to
    ///indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least detailed.
    uint  MipLevels;
    ///A value to clamp sample LOD values to. For example, if you specify 2.0f for the clamp value, you ensure that no
    ///individual sample accesses a mip level less than 2.0f.
    float ResourceMinLODClamp;
}

///Describes the subresource from a cube texture to use in a shader-resource view.
struct D3D12_TEXCUBE_SRV
{
    ///Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b> (from the original
    ///TextureCube for which ID3D12Device::CreateShaderResourceView creates a view) -1.
    uint  MostDetailedMip;
    ///The maximum number of mipmap levels for the view of the texture. See the remarks in D3D12_TEX1D_SRV. Set to -1 to
    ///indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least detailed.
    uint  MipLevels;
    ///A value to clamp sample LOD values to. For example, if you specify 2.0f for the clamp value, you ensure that no
    ///individual sample accesses a mip level less than 2.0f.
    float ResourceMinLODClamp;
}

///Describes the subresources from an array of cube textures to use in a shader-resource view.
struct D3D12_TEXCUBE_ARRAY_SRV
{
    ///Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b> (from the original
    ///TextureCube for which ID3D12Device::CreateShaderResourceView creates a view) -1.
    uint  MostDetailedMip;
    ///The maximum number of mipmap levels for the view of the texture. See the remarks in D3D12_TEX1D_SRV. Set to -1 to
    ///indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least detailed.
    uint  MipLevels;
    ///Index of the first 2D texture to use.
    uint  First2DArrayFace;
    ///Number of cube textures in the array.
    uint  NumCubes;
    ///A value to clamp sample LOD values to. For example, if you specify 2.0f for the clamp value, you ensure that no
    ///individual sample accesses a mip level less than 2.0f.
    float ResourceMinLODClamp;
}

///Describes the subresources from a multi sampled 2D texture to use in a shader-resource view.
struct D3D12_TEX2DMS_SRV
{
    ///Integer of any value. See remarks.
    uint UnusedField_NothingToDefine;
}

///Describes the subresources from an array of multi sampled 2D textures to use in a shader-resource view.
struct D3D12_TEX2DMS_ARRAY_SRV
{
    ///The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Number of textures to use.
    uint ArraySize;
}

///A shader resource view (SRV) structure for storing a raytracing acceleration structure.
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_SRV
{
    ulong Location;
}

///Describes a shader-resource view (SRV).
struct D3D12_SHADER_RESOURCE_VIEW_DESC
{
    ///A DXGI_FORMAT-typed value that specifies the viewing format. See remarks.
    DXGI_FORMAT         Format;
    ///A D3D12_SRV_DIMENSION-typed value that specifies the resource type of the view. This type is the same as the
    ///resource type of the underlying resource. This member also determines which _SRV to use in the union below.
    D3D12_SRV_DIMENSION ViewDimension;
    ///A value, constructed using the D3D12_ENCODE_SHADER_4_COMPONENT_MAPPING macro. The
    ///**D3D12_SHADER_COMPONENT_MAPPING** enumeration specifies what values from memory should be returned when the
    ///texture is accessed in a shader via this shader resource view (SRV). For example, it can route component 1
    ///(green) from memory, or the constant `0`, into component 2 (`.b`) of the value given to the shader.
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
    }
}

///Describes a constant buffer to view.
struct D3D12_CONSTANT_BUFFER_VIEW_DESC
{
    ///The D3D12_GPU_VIRTUAL_ADDRESS of the constant buffer. D3D12_GPU_VIRTUAL_ADDRESS is a typedef'd alias of UINT64.
    ulong BufferLocation;
    ///The size in bytes of the constant buffer.
    uint  SizeInBytes;
}

///Describes a sampler state.
struct D3D12_SAMPLER_DESC
{
    ///A D3D12_FILTER-typed value that specifies the filtering method to use when sampling a texture.
    D3D12_FILTER Filter;
    ///A D3D12_TEXTURE_ADDRESS_MODE-typed value that specifies the method to use for resolving a u texture coordinate
    ///that is outside the 0 to 1 range.
    D3D12_TEXTURE_ADDRESS_MODE AddressU;
    ///A D3D12_TEXTURE_ADDRESS_MODE-typed value that specifies the method to use for resolving a v texture coordinate
    ///that is outside the 0 to 1 range.
    D3D12_TEXTURE_ADDRESS_MODE AddressV;
    ///A D3D12_TEXTURE_ADDRESS_MODE-typed value that specifies the method to use for resolving a w texture coordinate
    ///that is outside the 0 to 1 range.
    D3D12_TEXTURE_ADDRESS_MODE AddressW;
    ///Offset from the calculated mipmap level. For example, if the runtime calculates that a texture should be sampled
    ///at mipmap level 3 and <b>MipLODBias</b> is 2, the texture will be sampled at mipmap level 5.
    float        MipLODBias;
    ///Clamping value used if <b>D3D12_FILTER_ANISOTROPIC</b> or <b>D3D12_FILTER_COMPARISON_ANISOTROPIC</b> is specified
    ///in <b>Filter</b>. Valid values are between 1 and 16.
    uint         MaxAnisotropy;
    ///A D3D12_COMPARISON_FUNC-typed value that specifies a function that compares sampled data against existing sampled
    ///data.
    D3D12_COMPARISON_FUNC ComparisonFunc;
    ///Border color to use if D3D12_TEXTURE_ADDRESS_MODE_BORDER is specified for <b>AddressU</b>, <b>AddressV</b>, or
    ///<b>AddressW</b>. Range must be between 0.0 and 1.0 inclusive.
    float[4]     BorderColor;
    ///Lower end of the mipmap range to clamp access to, where 0 is the largest and most detailed mipmap level and any
    ///level higher than that is less detailed.
    float        MinLOD;
    ///Upper end of the mipmap range to clamp access to, where 0 is the largest and most detailed mipmap level and any
    ///level higher than that is less detailed. This value must be greater than or equal to <b>MinLOD</b>. To have no
    ///upper limit on LOD, set this member to a large value.
    float        MaxLOD;
}

///Describes the elements in a buffer to use in a unordered-access view.
struct D3D12_BUFFER_UAV
{
    ///The zero-based index of the first element to be accessed.
    ulong FirstElement;
    ///The number of elements in the resource. For structured buffers, this is the number of structures in the buffer.
    uint  NumElements;
    ///The size of each element in the buffer structure (in bytes) when the buffer represents a structured buffer.
    uint  StructureByteStride;
    ///The counter offset, in bytes.
    ulong CounterOffsetInBytes;
    ///A D3D12_BUFFER_UAV_FLAGS-typed value that specifies the view options for the resource.
    D3D12_BUFFER_UAV_FLAGS Flags;
}

///Describes a unordered-access 1D texture resource.
struct D3D12_TEX1D_UAV
{
    ///The mipmap slice index.
    uint MipSlice;
}

///Describes an array of unordered-access 1D texture resources.
struct D3D12_TEX1D_ARRAY_UAV
{
    ///The mipmap slice index.
    uint MipSlice;
    ///The zero-based index of the first array slice to be accessed.
    uint FirstArraySlice;
    ///The number of slices in the array.
    uint ArraySize;
}

///Describes a unordered-access 2D texture resource.
struct D3D12_TEX2D_UAV
{
    ///The mipmap slice index.
    uint MipSlice;
    ///The index (plane slice number) of the plane to use in the texture.
    uint PlaneSlice;
}

///Describes an array of unordered-access 2D texture resources.
struct D3D12_TEX2D_ARRAY_UAV
{
    ///The mipmap slice index.
    uint MipSlice;
    ///The zero-based index of the first array slice to be accessed.
    uint FirstArraySlice;
    ///The number of slices in the array.
    uint ArraySize;
    ///The index (plane slice number) of the plane to use in an array of textures.
    uint PlaneSlice;
}

///Describes a unordered-access 3D texture resource.
struct D3D12_TEX3D_UAV
{
    ///The mipmap slice index.
    uint MipSlice;
    ///The zero-based index of the first depth slice to be accessed.
    uint FirstWSlice;
    ///The number of depth slices.
    uint WSize;
}

///Describes the subresources from a resource that are accessible by using an unordered-access view.
struct D3D12_UNORDERED_ACCESS_VIEW_DESC
{
    ///A DXGI_FORMAT-typed value that specifies the viewing format.
    DXGI_FORMAT         Format;
    ///A D3D12_UAV_DIMENSION-typed value that specifies the resource type of the view. This type specifies how the
    ///resource will be accessed. This member also determines which _UAV to use in the union below.
    D3D12_UAV_DIMENSION ViewDimension;
union
    {
        D3D12_BUFFER_UAV Buffer;
        D3D12_TEX1D_UAV  Texture1D;
        D3D12_TEX1D_ARRAY_UAV Texture1DArray;
        D3D12_TEX2D_UAV  Texture2D;
        D3D12_TEX2D_ARRAY_UAV Texture2DArray;
        D3D12_TEX3D_UAV  Texture3D;
    }
}

///Describes the elements in a buffer resource to use in a render-target view.
struct D3D12_BUFFER_RTV
{
    ///Number of bytes between the beginning of the buffer and the first element to access.
    ulong FirstElement;
    ///The total number of elements in the view.
    uint  NumElements;
}

///Describes the subresource from a 1D texture to use in a render-target view.
struct D3D12_TEX1D_RTV
{
    ///The index of the mipmap level to use mip slice.
    uint MipSlice;
}

///Describes the subresources from an array of 1D textures to use in a render-target view.
struct D3D12_TEX1D_ARRAY_RTV
{
    ///The index of the mipmap level to use mip slice.
    uint MipSlice;
    ///The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Number of textures to use.
    uint ArraySize;
}

///Describes the subresource from a 2D texture to use in a render-target view.
struct D3D12_TEX2D_RTV
{
    ///The index of the mipmap level to use.
    uint MipSlice;
    ///The index (plane slice number) of the plane to use in the texture.
    uint PlaneSlice;
}

///Describes the subresource from a multi sampled 2D texture to use in a render-target view.
struct D3D12_TEX2DMS_RTV
{
    ///Integer of any value. See remarks.
    uint UnusedField_NothingToDefine;
}

///Describes the subresources from an array of 2D textures to use in a render-target view.
struct D3D12_TEX2D_ARRAY_RTV
{
    ///The index of the mipmap level to use mip slice.
    uint MipSlice;
    ///The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Number of textures in the array to use in the render target view, starting from <b>FirstArraySlice</b>.
    uint ArraySize;
    ///The index (plane slice number) of the plane to use in an array of textures.
    uint PlaneSlice;
}

///Describes the subresources from an array of multi sampled 2D textures to use in a render-target view.
struct D3D12_TEX2DMS_ARRAY_RTV
{
    ///The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///The number of textures to use.
    uint ArraySize;
}

///Describes the subresources from a 3D texture to use in a render-target view.
struct D3D12_TEX3D_RTV
{
    ///The index of the mipmap level to use mip slice.
    uint MipSlice;
    ///First depth level to use.
    uint FirstWSlice;
    ///Number of depth levels to use in the render-target view, starting from <b>FirstWSlice</b>. A value of -1
    ///indicates all of the slices along the w axis, starting from <b>FirstWSlice</b>.
    uint WSize;
}

///Describes the subresources from a resource that are accessible by using a render-target view.
struct D3D12_RENDER_TARGET_VIEW_DESC
{
    ///A DXGI_FORMAT-typed value that specifies the viewing format.
    DXGI_FORMAT         Format;
    ///A D3D12_RTV_DIMENSION-typed value that specifies how the render-target resource will be accessed. This type
    ///specifies how the resource will be accessed. This member also determines which _RTV to use in the following
    ///union.
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

///Describes the subresource from a 1D texture that is accessible to a depth-stencil view.
struct D3D12_TEX1D_DSV
{
    ///The index of the first mipmap level to use.
    uint MipSlice;
}

///Describes the subresources from an array of 1D textures to use in a depth-stencil view.
struct D3D12_TEX1D_ARRAY_DSV
{
    ///The index of the first mipmap level to use.
    uint MipSlice;
    ///The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Number of textures to use.
    uint ArraySize;
}

///Describes the subresource from a 2D texture that is accessible to a depth-stencil view.
struct D3D12_TEX2D_DSV
{
    ///The index of the first mipmap level to use.
    uint MipSlice;
}

///Describes the subresources from an array of 2D textures that are accessible to a depth-stencil view.
struct D3D12_TEX2D_ARRAY_DSV
{
    ///The index of the first mipmap level to use.
    uint MipSlice;
    ///The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Number of textures to use.
    uint ArraySize;
}

///Describes the subresource from a multi sampled 2D texture that is accessible to a depth-stencil view.
struct D3D12_TEX2DMS_DSV
{
    ///Unused.
    uint UnusedField_NothingToDefine;
}

///Describes the subresources from an array of multi sampled 2D textures for a depth-stencil view.
struct D3D12_TEX2DMS_ARRAY_DSV
{
    ///The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Number of textures to use.
    uint ArraySize;
}

///Describes the subresources of a texture that are accessible from a depth-stencil view.
struct D3D12_DEPTH_STENCIL_VIEW_DESC
{
    ///A DXGI_FORMAT-typed value that specifies the viewing format. For allowable formats, see Remarks.
    DXGI_FORMAT         Format;
    ///A D3D12_DSV_DIMENSION-typed value that specifies how the depth-stencil resource will be accessed. This member
    ///also determines which _DSV to use in the following union.
    D3D12_DSV_DIMENSION ViewDimension;
    ///A combination of D3D12_DSV_FLAGS enumeration constants that are combined by using a bitwise OR operation. The
    ///resulting value specifies whether the texture is read only. Pass 0 to specify that it isn't read only; otherwise,
    ///pass one or more of the members of the <b>D3D12_DSV_FLAGS</b> enumerated type.
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

///Describes the descriptor heap.
struct D3D12_DESCRIPTOR_HEAP_DESC
{
    ///A D3D12_DESCRIPTOR_HEAP_TYPE-typed value that specifies the types of descriptors in the heap.
    D3D12_DESCRIPTOR_HEAP_TYPE Type;
    ///The number of descriptors in the heap.
    uint NumDescriptors;
    ///A combination of D3D12_DESCRIPTOR_HEAP_FLAGS-typed values that are combined by using a bitwise OR operation. The
    ///resulting value specifies options for the heap.
    D3D12_DESCRIPTOR_HEAP_FLAGS Flags;
    ///For single-adapter operation, set this to zero. If there are multiple adapter nodes, set a bit to identify the
    ///node (one of the device's physical adapters) to which the descriptor heap applies. Each bit in the mask
    ///corresponds to a single node. Only one bit must be set. See Multi-adapter systems.
    uint NodeMask;
}

///Describes a descriptor range.
struct D3D12_DESCRIPTOR_RANGE
{
    ///A D3D12_DESCRIPTOR_RANGE_TYPE-typed value that specifies the type of descriptor range.
    D3D12_DESCRIPTOR_RANGE_TYPE RangeType;
    ///The number of descriptors in the range. Use -1 or UINT_MAX to specify an unbounded size. If a given descriptor
    ///range is unbounded, then it must either be the last range in the table definition, or else the following range in
    ///the table definition must have a value for *OffsetInDescriptorsFromTableStart* that is not
    ///[D3D12_DESCRIPTOR_RANGE_OFFSET_APPEND]().
    uint NumDescriptors;
    ///The base shader register in the range. For example, for shader-resource views (SRVs), 3 maps to ": register(t3);"
    ///in HLSL.
    uint BaseShaderRegister;
    ///The register space. Can typically be 0, but allows multiple descriptor arrays of unknown size to not appear to
    ///overlap. For example, for SRVs, by extending the example in the <b>BaseShaderRegister</b> member description, 5
    ///maps to ": register(t3,space5);" in HLSL.
    uint RegisterSpace;
    ///The offset in descriptors, from the start of the descriptor table which was set as the root argument value for
    ///this parameter slot. This value can be <b>D3D12_DESCRIPTOR_RANGE_OFFSET_APPEND</b>, which indicates this range
    ///should immediately follow the preceding range.
    uint OffsetInDescriptorsFromTableStart;
}

///Describes the root signature 1.0 layout of a descriptor table as a collection of descriptor ranges that are all
///relative to a single base descriptor handle.
struct D3D12_ROOT_DESCRIPTOR_TABLE
{
    ///The number of descriptor ranges in the table layout.
    uint NumDescriptorRanges;
    ///An array of D3D12_DESCRIPTOR_RANGE structures that describe the descriptor ranges.
    const(D3D12_DESCRIPTOR_RANGE)* pDescriptorRanges;
}

///Describes constants inline in the root signature that appear in shaders as one constant buffer.
struct D3D12_ROOT_CONSTANTS
{
    ///The shader register.
    uint ShaderRegister;
    ///The register space.
    uint RegisterSpace;
    ///The number of constants that occupy a single shader slot (these constants appear like a single constant buffer).
    ///All constants occupy a single root signature bind slot.
    uint Num32BitValues;
}

///Describes descriptors inline in the root signature version 1.0 that appear in shaders.
struct D3D12_ROOT_DESCRIPTOR
{
    ///The shader register.
    uint ShaderRegister;
    ///The register space.
    uint RegisterSpace;
}

///Describes the slot of a root signature version 1.0.
struct D3D12_ROOT_PARAMETER
{
    ///A D3D12_ROOT_PARAMETER_TYPE-typed value that specifies the type of root signature slot. This member determines
    ///which type to use in the union below.
    D3D12_ROOT_PARAMETER_TYPE ParameterType;
union
    {
        D3D12_ROOT_DESCRIPTOR_TABLE DescriptorTable;
        D3D12_ROOT_CONSTANTS Constants;
        D3D12_ROOT_DESCRIPTOR Descriptor;
    }
    ///A D3D12_SHADER_VISIBILITY-typed value that specifies the shaders that can access the contents of the root
    ///signature slot.
    D3D12_SHADER_VISIBILITY ShaderVisibility;
}

///Describes a static sampler.
struct D3D12_STATIC_SAMPLER_DESC
{
    ///The filtering method to use when sampling a texture, as a D3D12_FILTER enumeration constant.
    D3D12_FILTER Filter;
    ///Specifies the D3D12_TEXTURE_ADDRESS_MODE mode to use for resolving a <i>u</i> texture coordinate that is outside
    ///the 0 to 1 range.
    D3D12_TEXTURE_ADDRESS_MODE AddressU;
    ///Specifies the D3D12_TEXTURE_ADDRESS_MODE mode to use for resolving a <i>v</i> texture coordinate that is outside
    ///the 0 to 1 range.
    D3D12_TEXTURE_ADDRESS_MODE AddressV;
    ///Specifies the D3D12_TEXTURE_ADDRESS_MODE mode to use for resolving a <i>w</i> texture coordinate that is outside
    ///the 0 to 1 range.
    D3D12_TEXTURE_ADDRESS_MODE AddressW;
    ///Offset from the calculated mipmap level. For example, if Direct3D calculates that a texture should be sampled at
    ///mipmap level 3 and MipLODBias is 2, then the texture will be sampled at mipmap level 5.
    float        MipLODBias;
    ///Clamping value used if D3D12_FILTER_ANISOTROPIC or D3D12_FILTER_COMPARISON_ANISOTROPIC is specified as the
    ///filter. Valid values are between 1 and 16.
    uint         MaxAnisotropy;
    ///A function that compares sampled data against existing sampled data. The function options are listed in
    ///D3D12_COMPARISON_FUNC.
    D3D12_COMPARISON_FUNC ComparisonFunc;
    ///One member of D3D12_STATIC_BORDER_COLOR, the border color to use if D3D12_TEXTURE_ADDRESS_MODE_BORDER is
    ///specified for AddressU, AddressV, or AddressW. Range must be between 0.0 and 1.0 inclusive.
    D3D12_STATIC_BORDER_COLOR BorderColor;
    ///Lower end of the mipmap range to clamp access to, where 0 is the largest and most detailed mipmap level and any
    ///level higher than that is less detailed.
    float        MinLOD;
    ///Upper end of the mipmap range to clamp access to, where 0 is the largest and most detailed mipmap level and any
    ///level higher than that is less detailed. This value must be greater than or equal to MinLOD. To have no upper
    ///limit on LOD set this to a large value such as D3D12_FLOAT32_MAX.
    float        MaxLOD;
    ///The <i>ShaderRegister</i> and <i>RegisterSpace</i> parameters correspond to the binding syntax of HLSL. For
    ///example, in HLSL: <pre class="syntax" xml:space="preserve"><code>Texture2D&lt;float4&gt; a : register(t2,
    ///space3);</code></pre> This corresponds to a <i>ShaderRegister</i> of 2 (indicating the type is SRV), and
    ///<i>RegisterSpace</i> is 3. The <i>ShaderRegister</i> and <i>RegisterSpace</i> pair is needed to establish
    ///correspondence between shader resources and runtime heap descriptors, using the root signature data structure.
    uint         ShaderRegister;
    ///See the description for <i>ShaderRegister</i>. Register space is optional; the default register space is 0.
    uint         RegisterSpace;
    ///Specifies the visibility of the sampler to the pipeline shaders, one member of D3D12_SHADER_VISIBILITY.
    D3D12_SHADER_VISIBILITY ShaderVisibility;
}

///Describes the layout of a root signature version 1.0.
struct D3D12_ROOT_SIGNATURE_DESC
{
    ///The number of slots in the root signature. This number is also the number of elements in the <i>pParameters</i>
    ///array.
    uint NumParameters;
    ///An array of D3D12_ROOT_PARAMETER structures for the slots in the root signature.
    const(D3D12_ROOT_PARAMETER)* pParameters;
    ///Specifies the number of static samplers.
    uint NumStaticSamplers;
    ///Pointer to one or more D3D12_STATIC_SAMPLER_DESC structures.
    const(D3D12_STATIC_SAMPLER_DESC)* pStaticSamplers;
    ///A combination of D3D12_ROOT_SIGNATURE_FLAGS-typed values that are combined by using a bitwise OR operation. The
    ///resulting value specifies options for the root signature layout.
    D3D12_ROOT_SIGNATURE_FLAGS Flags;
}

///Describes a descriptor range, with flags to determine their volatility.
struct D3D12_DESCRIPTOR_RANGE1
{
    ///A D3D12_DESCRIPTOR_RANGE_TYPE-typed value that specifies the type of descriptor range.
    D3D12_DESCRIPTOR_RANGE_TYPE RangeType;
    ///The number of descriptors in the range. Use -1 or UINT_MAX to specify unbounded size. Only the last entry in a
    ///table can have unbounded size.
    uint NumDescriptors;
    ///The base shader register in the range. For example, for shader-resource views (SRVs), 3 maps to ": register(t3);"
    ///in HLSL.
    uint BaseShaderRegister;
    ///The register space. Can typically be 0, but allows multiple descriptor arrays of unknown size to not appear to
    ///overlap. For example, for SRVs, by extending the example in the <b>BaseShaderRegister</b> member description, 5
    ///maps to ": register(t3,space5);" in HLSL.
    uint RegisterSpace;
    ///Specifies the D3D12_DESCRIPTOR_RANGE_FLAGS that determine descriptor and data volatility.
    D3D12_DESCRIPTOR_RANGE_FLAGS Flags;
    ///The offset in descriptors from the start of the root signature. This value can be
    ///<b>D3D12_DESCRIPTOR_RANGE_OFFSET_APPEND</b>, which indicates this range should immediately follow the preceding
    ///range.
    uint OffsetInDescriptorsFromTableStart;
}

///Describes the root signature 1.1 layout of a descriptor table as a collection of descriptor ranges that are all
///relative to a single base descriptor handle.
struct D3D12_ROOT_DESCRIPTOR_TABLE1
{
    ///The number of descriptor ranges in the table layout.
    uint NumDescriptorRanges;
    ///An array of D3D12_DESCRIPTOR_RANGE1 structures that describe the descriptor ranges.
    const(D3D12_DESCRIPTOR_RANGE1)* pDescriptorRanges;
}

///Describes descriptors inline in the root signature version 1.1 that appear in shaders.
struct D3D12_ROOT_DESCRIPTOR1
{
    ///The shader register.
    uint ShaderRegister;
    ///The register space.
    uint RegisterSpace;
    ///Specifies the D3D12_ROOT_DESCRIPTOR_FLAGS that determine the volatility of descriptors and the data they
    ///reference.
    D3D12_ROOT_DESCRIPTOR_FLAGS Flags;
}

///Describes the slot of a root signature version 1.1.
struct D3D12_ROOT_PARAMETER1
{
    ///A D3D12_ROOT_PARAMETER_TYPE-typed value that specifies the type of root signature slot. This member determines
    ///which type to use in the union below.
    D3D12_ROOT_PARAMETER_TYPE ParameterType;
union
    {
        D3D12_ROOT_DESCRIPTOR_TABLE1 DescriptorTable;
        D3D12_ROOT_CONSTANTS Constants;
        D3D12_ROOT_DESCRIPTOR1 Descriptor;
    }
    ///A D3D12_SHADER_VISIBILITY-typed value that specifies the shaders that can access the contents of the root
    ///signature slot.
    D3D12_SHADER_VISIBILITY ShaderVisibility;
}

///Describes the layout of a root signature version 1.1.
struct D3D12_ROOT_SIGNATURE_DESC1
{
    ///The number of slots in the root signature. This number is also the number of elements in the <i>pParameters</i>
    ///array.
    uint NumParameters;
    ///An array of D3D12_ROOT_PARAMETER1 structures for the slots in the root signature.
    const(D3D12_ROOT_PARAMETER1)* pParameters;
    ///Specifies the number of static samplers.
    uint NumStaticSamplers;
    ///Pointer to one or more D3D12_STATIC_SAMPLER_DESC structures.
    const(D3D12_STATIC_SAMPLER_DESC)* pStaticSamplers;
    ///Specifies the D3D12_ROOT_SIGNATURE_FLAGS that determine the data volatility.
    D3D12_ROOT_SIGNATURE_FLAGS Flags;
}

///Holds any version of a root signature description, and is designed to be used with serialization/deserialization
///functions.
struct D3D12_VERSIONED_ROOT_SIGNATURE_DESC
{
    ///Specifies one member of D3D_ROOT_SIGNATURE_VERSION that determines the contents of the union.
    D3D_ROOT_SIGNATURE_VERSION Version;
union
    {
        D3D12_ROOT_SIGNATURE_DESC Desc_1_0;
        D3D12_ROOT_SIGNATURE_DESC1 Desc_1_1;
    }
}

///Describes a CPU descriptor handle.
struct D3D12_CPU_DESCRIPTOR_HANDLE
{
    ///The address of the descriptor.
    size_t ptr;
}

///Describes a GPU descriptor handle.
struct D3D12_GPU_DESCRIPTOR_HANDLE
{
    ///The address of the descriptor.
    ulong ptr;
}

///Describes details for the discard-resource operation.
struct D3D12_DISCARD_REGION
{
    ///The number of rectangles in the array that the <b>pRects</b> member specifies.
    uint         NumRects;
    ///An array of <b>D3D12_RECT</b> structures for the rectangles in the resource to discard. If <b>NULL</b>,
    ///DiscardResource discards the entire resource.
    const(RECT)* pRects;
    ///Index of the first subresource in the resource to discard.
    uint         FirstSubresource;
    ///The number of subresources in the resource to discard.
    uint         NumSubresources;
}

///Describes the purpose of a query heap. A query heap contains an array of individual queries.
struct D3D12_QUERY_HEAP_DESC
{
    ///Specifies one member of D3D12_QUERY_HEAP_TYPE.
    D3D12_QUERY_HEAP_TYPE Type;
    ///Specifies the number of queries the heap should contain.
    uint Count;
    ///For single GPU operation, set this to zero. If there are multiple GPU nodes, set a bit to identify the node (the
    ///device's physical adapter) to which the query heap applies. Each bit in the mask corresponds to a single node.
    ///Only 1 bit must be set. Refer to Multi-adapter systems.
    uint NodeMask;
}

///Query information about graphics-pipeline activity in between calls to BeginQuery and EndQuery.
struct D3D12_QUERY_DATA_PIPELINE_STATISTICS
{
    ///Number of vertices read by input assembler.
    ulong IAVertices;
    ///Number of primitives read by the input assembler. This number can be different depending on the primitive
    ///topology used. For example, a triangle strip with 6 vertices will produce 4 triangles, however a triangle list
    ///with 6 vertices will produce 2 triangles.
    ulong IAPrimitives;
    ///Specifies the number of vertex shader invocations. Direct3D invokes the vertex shader once per vertex.
    ulong VSInvocations;
    ///Specifies the number of geometry shader invocations. When the geometry shader is set to NULL, this statistic may
    ///or may not increment depending on the graphics adapter.
    ulong GSInvocations;
    ///Specifies the number of geometry shader output primitives.
    ulong GSPrimitives;
    ///Number of primitives that were sent to the rasterizer. When the rasterizer is disabled, this will not increment.
    ulong CInvocations;
    ///Number of primitives that were rendered. This may be larger or smaller than CInvocations because after a
    ///primitive is clipped sometimes it is either broken up into more than one primitive or completely culled.
    ulong CPrimitives;
    ///Specifies the number of pixel shader invocations.
    ulong PSInvocations;
    ///Specifies the number of hull shader invocations.
    ulong HSInvocations;
    ///Specifies the number of domain shader invocations.
    ulong DSInvocations;
    ///Specifies the number of compute shader invocations.
    ulong CSInvocations;
}

///Describes query data for stream output.
struct D3D12_QUERY_DATA_SO_STATISTICS
{
    ///Specifies the number of primitives written.
    ulong NumPrimitivesWritten;
    ///Specifies the total amount of storage needed by the primitives.
    ulong PrimitivesStorageNeeded;
}

///Describes a stream output buffer.
struct D3D12_STREAM_OUTPUT_BUFFER_VIEW
{
    ///A D3D12_GPU_VIRTUAL_ADDRESS (a UINT64) that points to the stream output buffer. If <b>SizeInBytes</b> is 0, this
    ///member isn't used and can be any value.
    ulong BufferLocation;
    ///The size of the stream output buffer in bytes.
    ulong SizeInBytes;
    ///The location of the value of how much data has been filled into the buffer, as a D3D12_GPU_VIRTUAL_ADDRESS (a
    ///UINT64). This member can't be NULL; a filled size location must be supplied (which the hardware will increment as
    ///data is output). If <b>SizeInBytes</b> is 0, this member isn't used and can be any value.
    ulong BufferFilledSizeLocation;
}

///Describes parameters for drawing instances.
struct D3D12_DRAW_ARGUMENTS
{
    ///Specifies the number of vertices to draw, per instance.
    uint VertexCountPerInstance;
    ///Specifies the number of instances.
    uint InstanceCount;
    ///Specifies an index to the first vertex to start drawing from.
    uint StartVertexLocation;
    ///Specifies an index to the first instance to start drawing from.
    uint StartInstanceLocation;
}

///Describes parameters for drawing indexed instances.
struct D3D12_DRAW_INDEXED_ARGUMENTS
{
    ///The number of indices read from the index buffer for each instance.
    uint IndexCountPerInstance;
    ///The number of instances to draw.
    uint InstanceCount;
    ///The location of the first index read by the GPU from the index buffer.
    uint StartIndexLocation;
    ///A value added to each index before reading a vertex from the vertex buffer.
    int  BaseVertexLocation;
    ///A value added to each index before reading per-instance data from a vertex buffer.
    uint StartInstanceLocation;
}

///Describes dispatch parameters, for use by the compute shader.
struct D3D12_DISPATCH_ARGUMENTS
{
    ///The size, in thread groups, of the x-dimension of the thread-group grid.
    uint ThreadGroupCountX;
    ///The size, in thread groups, of the y-dimension of the thread-group grid.
    uint ThreadGroupCountY;
    ///The size, in thread groups, of the z-dimension of the thread-group grid.
    uint ThreadGroupCountZ;
}

///Describes a vertex buffer view.
struct D3D12_VERTEX_BUFFER_VIEW
{
    ///Specifies a D3D12_GPU_VIRTUAL_ADDRESS that identifies the address of the buffer.
    ulong BufferLocation;
    ///Specifies the size in bytes of the buffer.
    uint  SizeInBytes;
    ///Specifies the size in bytes of each vertex entry.
    uint  StrideInBytes;
}

///Describes the index buffer to view.
struct D3D12_INDEX_BUFFER_VIEW
{
    ///The GPU virtual address of the index buffer. D3D12_GPU_VIRTUAL_ADDRESS is a typedef'd synonym of UINT64.
    ulong       BufferLocation;
    ///The size in bytes of the index buffer.
    uint        SizeInBytes;
    ///A DXGI_FORMAT-typed value for the index-buffer format.
    DXGI_FORMAT Format;
}

///Describes an indirect argument (an indirect parameter), for use with a command signature.
struct D3D12_INDIRECT_ARGUMENT_DESC
{
    ///A single D3D12_INDIRECT_ARGUMENT_TYPE enumeration constant.
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
    }
}

///Describes the arguments (parameters) of a command signature.
struct D3D12_COMMAND_SIGNATURE_DESC
{
    ///Specifies the size of each argument of a command signature, in bytes.
    uint ByteStride;
    ///Specifies the number of arguments in the command signature.
    uint NumArgumentDescs;
    ///An array of D3D12_INDIRECT_ARGUMENT_DESC structures, containing details of the arguments, including whether the
    ///argument is a vertex buffer, constant, constant buffer view, shader resource view, or unordered access view.
    const(D3D12_INDIRECT_ARGUMENT_DESC)* pArgumentDescs;
    ///For single GPU operation, set this to zero. If there are multiple GPU nodes, set bits to identify the nodes (the
    ///device's physical adapters) for which the command signature is to apply. Each bit in the mask corresponds to a
    ///single node. Refer to Multi-adapter systems.
    uint NodeMask;
}

///Specifies the immediate value and destination address written using ID3D12CommandList2::WriteBufferImmediate.
struct D3D12_WRITEBUFFERIMMEDIATE_PARAMETER
{
    ///The GPU virtual address at which to write the value. The address must be aligned to a 32-bit (4-byte) boundary.
    ulong Dest;
    ///The 32-bit value to write.
    uint  Value;
}

///Indicates the level of support for protected resource sessions.
struct D3D12_FEATURE_DATA_PROTECTED_RESOURCE_SESSION_SUPPORT
{
    ///Type: **[UINT](/windows/desktop/WinProg/windows-data-types)** An input field, indicating the adapter index to
    ///query.
    uint NodeIndex;
    D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAGS Support;
}

///Describes flags for a protected resource session, per adapter.
struct D3D12_PROTECTED_RESOURCE_SESSION_DESC
{
    ///Type: **[UINT](/windows/win32/WinProg/windows-data-types)** The node mask. For single GPU operation, set this to
    ///zero. If there are multiple GPU nodes, then set a bit to identify the node (the device's physical adapter) to
    ///which the protected session applies. Each bit in the mask corresponds to a single node. Only 1 bit may be set.
    uint NodeMask;
    ///Type: **[D3D12_PROTECTED_RESOURCE_SESSION_FLAGS](./ne-d3d12-d3d12_protected_resource_session_flags.md)**
    ///Specifies the supported crypto sessions options.
    D3D12_PROTECTED_RESOURCE_SESSION_FLAGS Flags;
}

///Describes a parameter to a meta command.
struct D3D12_META_COMMAND_PARAMETER_DESC
{
    ///Type: <b>LPCWSTR</b> The parameter name.
    const(PWSTR) Name;
    ///Type: <b>D3D12_META_COMMAND_PARAMETER_TYPE</b> A D3D12_META_COMMAND_PARAMETER_TYPE specifying the parameter type.
    D3D12_META_COMMAND_PARAMETER_TYPE Type;
    ///Type: <b>D3D12_META_COMMAND_PARAMETER_FLAGS</b> A D3D12_META_COMMAND_PARAMETER_FLAGS specifying the parameter
    ///flags.
    D3D12_META_COMMAND_PARAMETER_FLAGS Flags;
    ///Type: <b>D3D12_RESOURCE_STATES</b> A D3D12_RESOURCE_STATES specifying the expected state of a resource parameter.
    D3D12_RESOURCE_STATES RequiredResourceState;
    uint         StructureOffset;
}

///Describes a meta command.
struct D3D12_META_COMMAND_DESC
{
    ///Type: <b>GUID</b> A GUID uniquely identifying the meta command.
    GUID         Id;
    ///Type: <b>LPCWSTR</b> The meta command name.
    const(PWSTR) Name;
    ///Type: <b>D3D12_GRAPHICS_STATES</b> Declares the command list states that are modified by the call to initialize
    ///the meta command. If all state bits are set, then that's equivalent to calling
    ///ID3D12GraphicsCommandList::ClearState.
    D3D12_GRAPHICS_STATES InitializationDirtyState;
    D3D12_GRAPHICS_STATES ExecutionDirtyState;
}

///Represents a subobject with in a state object description. Use with D3D12_STATE_OBJECT_DESC.
struct D3D12_STATE_SUBOBJECT
{
    ///The type of the state subobject.
    D3D12_STATE_SUBOBJECT_TYPE Type;
    const(void)* pDesc;
}

///Defines general properties of a state object.
struct D3D12_STATE_OBJECT_CONFIG
{
    ///A value from the D3D12_STATE_OBJECT_FLAGS flags enumeration that specifies the requirements for the state object.
    D3D12_STATE_OBJECT_FLAGS Flags;
}

///Defines a global root signature state suboject that will be used with associated shaders.
struct D3D12_GLOBAL_ROOT_SIGNATURE
{
    ///The root signature that will function as a global root signature. A state object holds a reference to this
    ///signature.
    ID3D12RootSignature pGlobalRootSignature;
}

///Defines a local root signature state subobject that will be used with associated shaders.
struct D3D12_LOCAL_ROOT_SIGNATURE
{
    ///The root signature that will function as a local root signature. A state object holds a reference to this
    ///signature.
    ID3D12RootSignature pLocalRootSignature;
}

///A state subobject that identifies the GPU nodes to which the state object applies.
struct D3D12_NODE_MASK
{
    ///The node mask.
    uint NodeMask;
}

///Describes an export from a state subobject such as a DXIL library or a collection state object.
struct D3D12_EXPORT_DESC
{
    ///The name to be exported. If the name refers to a function that is overloaded, a modified version of the name
    ///(e.g. encoding function parameter information in name string) can be provided to disambiguate which overload to
    ///use. The modified name for a function can be retrieved using HLSL compiler reflection. If the
    ///<i>ExportToRename</i> field is non-null, <i>Name</i> refers to the new name to use for it when exported. In this
    ///case <i>Name</i> must be the unmodified name, whereas <i>ExportToRename</i> can be either a modified or
    ///unmodified name. A given internal name may be exported multiple times with different renames (and/or not
    ///renamed).
    const(PWSTR)       Name;
    ///If non-null, this is the name of an export to use but then rename when exported.
    const(PWSTR)       ExportToRename;
    D3D12_EXPORT_FLAGS Flags;
}

///Describes a DXIL library state subobject that can be included in a state object.
struct D3D12_DXIL_LIBRARY_DESC
{
    ///The library to include in the state object. Must have been compiled with library target 6.3 or higher. It is fine
    ///to specify the same library multiple times either in the same state object / collection or across multiple, as
    ///long as the names exported each time don’t conflict in a given state object.
    D3D12_SHADER_BYTECODE DXILLibrary;
    ///The size of <i>pExports</i> array. If 0, everything gets exported from the library.
    uint               NumExports;
    D3D12_EXPORT_DESC* pExports;
}

///A state subobject describing an existing collection that can be included in a state object.
struct D3D12_EXISTING_COLLECTION_DESC
{
    ///The collection to include in a state object. The enclosing state object holds a reference to the existing
    ///collection.
    ID3D12StateObject  pExistingCollection;
    ///Size of the <i>pExports</i> array. If 0, all of the collection’s exports get exported.
    uint               NumExports;
    D3D12_EXPORT_DESC* pExports;
}

///Associates a subobject defined directly in a state object with shader exports.
struct D3D12_SUBOBJECT_TO_EXPORTS_ASSOCIATION
{
    ///Pointer to the subobject in current state object to define an association to.
    const(D3D12_STATE_SUBOBJECT)* pSubobjectToAssociate;
    ///Size of the <i>pExports</i> array. If 0, this is being explicitly defined as a default association. Another way
    ///to define a default association is to omit this subobject association for that subobject completely.
    uint   NumExports;
    ///The array of exports with which the subobject is associated.
    PWSTR* pExports;
}

///This subobject is unsupported in the current release.
struct D3D12_DXIL_SUBOBJECT_TO_EXPORTS_ASSOCIATION
{
    const(PWSTR) SubobjectToAssociate;
    ///Size of the <i>pExports</i> array. If 0, this is being explicitly defined as a default association. Another way
    ///to define a default association is to omit this subobject association for that subobject completely.
    uint         NumExports;
    PWSTR*       pExports;
}

///Describes a raytracing hit group state subobject that can be included in a state object.
struct D3D12_HIT_GROUP_DESC
{
    ///The name of the hit group.
    const(PWSTR)         HitGroupExport;
    ///A value from the D3D12_HIT_GROUP_TYPE enumeration specifying the type of the hit group.
    D3D12_HIT_GROUP_TYPE Type;
    ///Optional name of the any-hit shader associated with the hit group. This field can be used with all hit group
    ///types.
    const(PWSTR)         AnyHitShaderImport;
    ///Optional name of the closest-hit shader associated with the hit group. This field can be used with all hit group
    ///types.
    const(PWSTR)         ClosestHitShaderImport;
    const(PWSTR)         IntersectionShaderImport;
}

///A state subobject that represents a shader configuration.
struct D3D12_RAYTRACING_SHADER_CONFIG
{
    ///The maximum storage for scalars (counted as 4 bytes each) in ray payloads in raytracing pipelines that contain
    ///this program.
    uint MaxPayloadSizeInBytes;
    ///The maximum number of scalars (counted as 4 bytes each) that can be used for attributes in pipelines that contain
    ///this shader. The value cannot exceed D3D12_RAYTRACING_MAX_ATTRIBUTE_SIZE_IN_BYTES.
    uint MaxAttributeSizeInBytes;
}

///A state subobject that represents a raytracing pipeline configuration.
struct D3D12_RAYTRACING_PIPELINE_CONFIG
{
    ///Limit on ray recursion for the raytracing pipeline. It must be in the range of 0 to 31. Below the maximum
    ///recursion depth, shader invocations such as closest hit or miss shaders can call <b>TraceRay</b> any number of
    ///times. At the maximum recursion depth, <b>TraceRay</b> calls result in the device going into removed state.
    uint MaxTraceRecursionDepth;
}

struct D3D12_RAYTRACING_PIPELINE_CONFIG1
{
    uint MaxTraceRecursionDepth;
    D3D12_RAYTRACING_PIPELINE_FLAGS Flags;
}

///Description of a state object. Pass a value of this structure type to
///[ID3D12Device5::CreateStateObject](./nf-d3d12-id3d12device5-createstateobject.md).
struct D3D12_STATE_OBJECT_DESC
{
    ///The type of the state object.
    D3D12_STATE_OBJECT_TYPE Type;
    ///Size of the <i>pSubobjects</i> array.
    uint NumSubobjects;
    const(D3D12_STATE_SUBOBJECT)* pSubobjects;
}

///Represents a GPU virtual address and indexing stride.
struct D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE
{
    ///The beginning of the virtual address range.
    ulong StartAddress;
    ulong StrideInBytes;
}

///Represents a GPU virtual address range.
struct D3D12_GPU_VIRTUAL_ADDRESS_RANGE
{
    ///The beginning of the virtual address range.
    ulong StartAddress;
    ulong SizeInBytes;
}

///Represents a GPU virtual address range and stride.
struct D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE
{
    ///The beginning of the virtual address range.
    ulong StartAddress;
    ///The size of the virtual address range, in bytes.
    ulong SizeInBytes;
    ulong StrideInBytes;
}

///Describes a set of triangles used as raytracing geometry. The geometry pointed to by this struct are always in
///triangle list form, indexed or non-indexed. Triangle strips are not supported.
struct D3D12_RAYTRACING_GEOMETRY_TRIANGLES_DESC
{
    ///Address of a 3x4 affine transform matrix in row-major layout to be applied to the vertices in the
    ///<i>VertexBuffer</i> during an acceleration structure build. The contents of <i>VertexBuffer</i> are not modified.
    ///If a 2D vertex format is used, the transformation is applied with the third vertex component assumed to be zero.
    ///If <i>Transform3x4</i> is NULL the vertices will not be transformed. Using <i>Transform3x4</i> may result in
    ///increased computation and/or memory requirements for the acceleration structure build. The memory pointed to must
    ///be in state D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE. The address must be aligned to 16 bytes, defined as
    ///D3D12_RAYTRACING_TRANSFORM3X4_BYTE_ALIGNMENT.
    ulong       Transform3x4;
    ///Format of the indices in the <i>IndexBuffer</i>. Must be one of the following: <ul>
    ///<li><b>DXGI_FORMAT_UNKNOWN</b> - when IndexBuffer is NULL</li> <li><b>DXGI_FORMAT_R32_UINT</b></li>
    ///<li><b>DXGI_FORMAT_R16_UINT</b></li> </ul>
    DXGI_FORMAT IndexFormat;
    ///Format of the vertices in <i>VertexBuffer</i>. Must be one of the following: <ul>
    ///<li><b>DXGI_FORMAT_R32G32_FLOAT</b> - third component is assumed 0</li>
    ///<li><b>DXGI_FORMAT_R32G32B32_FLOAT</b></li> <li><b>DXGI_FORMAT_R16G16_FLOAT</b> - third component is assumed
    ///0</li> <li><b>DXGI_FORMAT_R16G16B16A16_FLOAT</b> - A16 component is ignored, other data can be packed there, such
    ///as setting vertex stride to 6 bytes.</li> <li><b>DXGI_FORMAT_R16G16_SNORM</b> - third component is assumed 0</li>
    ///<li><b>DXGI_FORMAT_R16G16B16A16_SNORM</b> - A16 component is ignored, other data can be packed there, such as
    ///setting vertex stride to 6 bytes.</li> </ul>
    DXGI_FORMAT VertexFormat;
    ///Number of indices in <i>IndexBuffer</i>. Must be 0 if <i>IndexBuffer</i> is NULL.
    uint        IndexCount;
    ///Number of vertices in <i>VertexBuffer</i>.
    uint        VertexCount;
    ///Array of vertex indices. If NULL, triangles are non-indexed. Just as with graphics, the address must be aligned
    ///to the size of <i>IndexFormat</i>. The memory pointed to must be in state
    ///D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE. Note that if an app wants to share index buffer inputs between
    ///graphics input assembler and raytracing acceleration structure build input, it can always put a resource into a
    ///combination of read states simultaneously, e.g. <b>D3D12_RESOURCE_STATE_INDEX_BUFFER</b> |
    ///<b>D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE</b>.
    ulong       IndexBuffer;
    D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE VertexBuffer;
}

///Represents an axis-aligned bounding box (AABB) used as raytracing geometry.
struct D3D12_RAYTRACING_AABB
{
    ///The minimum X coordinate of the box.
    float MinX;
    ///The minimum Y coordinate of the box.
    float MinY;
    ///The minimum Z coordinate of the box.
    float MinZ;
    ///The maximum X coordinate of the box.
    float MaxX;
    ///The maximum Y coordinate of the box.
    float MaxY;
    float MaxZ;
}

///Describes a set of Axis-aligned bounding boxes that are used in the
///D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS structure to provide input data to a raytracing acceleration
///structure build operation.
struct D3D12_RAYTRACING_GEOMETRY_AABBS_DESC
{
    ///The number of AABBs pointed to in the contiguous array at <i>AABBs</i>.
    ulong AABBCount;
    D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE AABBs;
}

///Description of the post-build information to generate from an acceleration structure. Use this structure in calls to
///EmitRaytracingAccelerationStructurePostbuildInfo and BuildRaytracingAccelerationStructure.
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC
{
    ///Storage for the post-build info result. Size required and the layout of the contents written by the system depend
    ///on the value of the <i>InfoType</i> field. The memory pointed to must be in state
    ///D3D12_RESOURCE_STATE_UNORDERED_ACCESS. The memory must be aligned to the natural alignment for the members of the
    ///particular output structure being generated (e.g. 8 bytes for a struct with the largest members being UINT64).
    ulong DestBuffer;
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TYPE InfoType;
}

///Describes the space requirement for acceleration structure after compaction.
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_COMPACTED_SIZE_DESC
{
    ulong CompactedSizeInBytes;
}

///Describes the space requirement for decoding an acceleration structure into a form that can be visualized by tools.
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TOOLS_VISUALIZATION_DESC
{
    ulong DecodedSizeInBytes;
}

///Describes the GPU memory layout of an acceleration structure visualization.
struct D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_TOOLS_VISUALIZATION_HEADER
{
    ///The type of acceleration structure.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE Type;
    ///The number of descriptions.
    uint NumDescs;
}

///Describes the size and layout of the serialized acceleration structure and header
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_SERIALIZATION_DESC
{
    ///The size of the serialized acceleration structure, including a header. The header is
    ///D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER followed by followed by a list of pointers to
    ///bottom-level acceleration structures.
    ulong SerializedSizeInBytes;
    ulong NumBottomLevelAccelerationStructurePointers;
}

///Opaque data structure describing driver versioning for a serialized acceleration structure. Pass this structure into
///a call to ID3D12Device5::CheckDriverMatchingIdentifier to determine if a previously serialized acceleration structure
///is compatible with the current driver/device, and can therefore be deserialized and used for raytracing.
struct D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER
{
    ///The opaque identifier of the driver.
    GUID      DriverOpaqueGUID;
    ubyte[16] DriverOpaqueVersioningData;
}

///Defines the header for a serialized raytracing acceleration structure.
struct D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER
{
    ///The driver-matching identifier.
    D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER DriverMatchingIdentifier;
    ///The size of serialized data.
    ulong SerializedSizeInBytesIncludingHeader;
    ///Size of the memory that will be consumed when the acceleration structure is deserialized. This value is less than
    ///or equal to the size of the original acceleration structure before it was serialized.
    ulong DeserializedSizeInBytes;
    ulong NumBottomLevelAccelerationStructurePointersAfterHeader;
}

///Describes the space currently used by an acceleration structure..
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_CURRENT_SIZE_DESC
{
    ///Space currently used by an acceleration structure. If the acceleration structure hasn’t had a compaction
    ///operation performed on it, this size is the same one reported by GetRaytracingAccelerationStructurePrebuildInfo,
    ///and if it has been compacted this size is the same reported for post-build info with
    ///D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_COMPACTED_SIZE.
    ulong CurrentSizeInBytes;
}

///Describes an instance of a raytracing acceleration structure used in GPU memory during the acceleration structure
///build process.
struct D3D12_RAYTRACING_INSTANCE_DESC
{
    ///Type: **[FLOAT](/windows/win32/winprog/windows-data-types) \[3\]\[4\]** A 3x4 transform matrix in row-major
    ///layout representing the instance-to-world transformation. Implementations transform rays, as opposed to
    ///transforming all of the geometry or AABBs. > [!NOTE] > The layout of `Transform` is a transpose of how affine
    ///matrices are typically stored in memory. Instead of four 3-vectors, `Transform` is laid out as three 4-vectors.
    float[12] Transform;
    uint      _bitfield1;
    uint      _bitfield2;
    ///Type: **[D3D12_GPU_VIRTUAL_ADDRESS](/windows/win32/direct3d12/d3d12_gpu_virtual_address)** Address of the
    ///bottom-level acceleration structure that is being instanced. The address must be aligned to 256 bytes, defined as
    ///[D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BYTE_ALIGNMENT](/windows/win32/direct3d12/constants). Any existing
    ///acceleration structure passed in here would already have been required to be placed with such alignment. The
    ///memory pointed to must be in state
    ///[D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE](./ne-d3d12-d3d12_resource_states.md).
    ulong     AccelerationStructure;
}

///Describes a set of geometry that is used in the D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS structure to
///provide input data to a raytracing acceleration structure build operation.
struct D3D12_RAYTRACING_GEOMETRY_DESC
{
    ///The type of geometry.
    D3D12_RAYTRACING_GEOMETRY_TYPE Type;
    ///The geometry flags
    D3D12_RAYTRACING_GEOMETRY_FLAGS Flags;
union
    {
        D3D12_RAYTRACING_GEOMETRY_TRIANGLES_DESC Triangles;
        D3D12_RAYTRACING_GEOMETRY_AABBS_DESC AABBs;
    }
}

///Defines the inputs for a raytracing acceleration structure build operation. This structure is used by
///ID3D12GraphicsCommandList4::BuildRaytracingAccelerationStructure and
///ID3D12Device5::GetRaytracingAccelerationStructurePrebuildInfo.
struct D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS
{
    ///The type of acceleration structure to build.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE Type;
    ///The build flags.
    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS Flags;
    ///If <i>Type</i> is <b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TOP_LEVEL</b>, this value is the number of
    ///instances, laid out based on <i>DescsLayout</i>. If <i>Type</i> is
    ///<b>D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BOTTOM_LEVEL</b>, this value is the number of elements referred to by
    ///<i>pGeometryDescs</i> or <i>ppGeometryDescs</i>. Which of these fields is used depends on <i>DescsLayout</i>.
    uint NumDescs;
    ///How geometry descriptions are specified; either an array of descriptions or an array of pointers to descriptions.
    D3D12_ELEMENTS_LAYOUT DescsLayout;
union
    {
        ulong InstanceDescs;
        const(D3D12_RAYTRACING_GEOMETRY_DESC)* pGeometryDescs;
        const(D3D12_RAYTRACING_GEOMETRY_DESC)** ppGeometryDescs;
    }
}

///Describes a raytracing acceleration structure. Pass this structure into
///ID3D12GraphicsCommandList4::BuildRaytracingAccelerationStructure to describe the acceleration structure to be built.
struct D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC
{
    ///Location to store resulting acceleration structure. ID3D12Device5::GetRaytracingAccelerationStructurePrebuildInfo
    ///reports the amount of memory required for the result here given a set of acceleration structure build parameters.
    ///The address must be aligned to 256 bytes, defined as D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BYTE_ALIGNMENT. >
    ///[!IMPORTANT]] > The memory must be in state
    ///[**D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_resource_states).
    ulong DestAccelerationStructureData;
    ///Description of the input data for the acceleration structure build. This is data is stored in a separate
    ///structure because it is also used with <b>GetRaytracingAccelerationStructurePrebuildInfo</b>.
    D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS Inputs;
    ///Address of an existing acceleration structure if an acceleration structure update (an incremental build) is being
    ///requested, by setting D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PERFORM_UPDATE in the Flags parameter.
    ///Otherwise this address must be NULL. If this address is the same as <i>DestAccelerationStructureData</i>, the
    ///update is to be performed in-place. Any other form of overlap of the source and destination memory is invalid and
    ///produces undefined behavior. The address must be aligned to 256 bytes, defined as
    ///D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BYTE_ALIGNMENT, which should automatically be the case because any
    ///existing acceleration structure passed in here would have already been required to be placed with such alignment.
    ///> [!IMPORTANT]] > The memory must be in state
    ///[**D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_resource_states).
    ulong SourceAccelerationStructureData;
    ulong ScratchAccelerationStructureData;
}

///Represents prebuild information about a raytracing acceleration structure. Get an instance of this stucture by
///calling GetRaytracingAccelerationStructurePrebuildInfo.
struct D3D12_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO
{
    ///Size required to hold the result of an acceleration structure build based on the specified inputs.
    ulong ResultDataMaxSizeInBytes;
    ///Scratch storage on the GPU required during acceleration structure build based on the specified inputs.
    ulong ScratchDataSizeInBytes;
    ulong UpdateScratchDataSizeInBytes;
}

///Represents Device Removed Extended Data (DRED) auto-breadcrumb data as a node in a linked list. Each
///**D3D12_AUTO_BREADCRUMB_NODE** object is singly linked to the next via its `pNext` member; except for the last node
///in the list, which has its `pNext` set to `nullptr`. The Direct3D 12 runtime creates one of these for each graphics
///command list, and tracks them in the command allocator associated with the list. When a command list is executed, the
///command queue information is set. After device removal is detected, the Direct3D 12 runtime links together the
///auto-breadcrumb nodes for any GPU work that is still outstanding.
struct D3D12_AUTO_BREADCRUMB_NODE
{
    ///A pointer to the ANSI debug name of the outstanding command list (if any).
    const(ubyte)*      pCommandListDebugNameA;
    ///A pointer to the wide debug name of the outstanding command list (if any).
    const(PWSTR)       pCommandListDebugNameW;
    ///A pointer to the ANSI debug name of the outstanding command queue (if any).
    const(ubyte)*      pCommandQueueDebugNameA;
    ///A pointer to the wide debug name of the outstanding command queue (if any).
    const(PWSTR)       pCommandQueueDebugNameW;
    ///A pointer to the [ID3D12GraphicsCommandList interface](nn-d3d12-id3d12graphicscommandlist.md) representing the
    ///outstanding command list at the time of execution.
    ID3D12GraphicsCommandList pCommandList;
    ///A pointer to the [ID3D12CommandQueue interface](nn-d3d12-id3d12commandqueue.md) representing the outstanding
    ///command queue.
    ID3D12CommandQueue pCommandQueue;
    ///A **UINT32** containing the count of [D3D12_AUTO_BREADCRUMB_OP](ne-d3d12-d3d12_auto_breadcrumb_op.md) values in
    ///the array pointed to by `pCommandHistory`.
    uint               BreadcrumbCount;
    ///A pointer to a constant **UINT32** containing the index (within the array pointed to by `pCommandHistory`) of the
    ///last render/compute operation that was completed by the GPU while executing the associated command list.
    const(uint)*       pLastBreadcrumbValue;
    ///A pointer to a constant array of [D3D12_AUTO_BREADCRUMB_OP](ne-d3d12-d3d12_auto_breadcrumb_op.md) values
    ///representing all of the render/compute operations recorded into the associated command list.
    const(D3D12_AUTO_BREADCRUMB_OP)* pCommandHistory;
    ///A pointer to a constant **D3D12_AUTO_BREADCRUMB_NODE** representing the next auto-breadcrumb node in the list, or
    ///`nullptr` if this is the last node.
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

///> [!NOTE] > As of Windows 10, version 1903, **D3D12_DEVICE_REMOVED_EXTENDED_DATA** is deprecated, and it may not be
///available in future versions of Windows. Use
///[**D3D12_DEVICE_REMOVED_EXTENDED_DATA1**](ns-d3d12-d3d12_device_removed_extended_data1.md), instead. Represents
///Device Removed Extended Data (DRED) version 1.0 data.
struct D3D12_DEVICE_REMOVED_EXTENDED_DATA
{
    ///An input parameter of type [D3D12_DRED_FLAGS](ne-d3d12-d3d12_dred_flags.md), specifying control flags for the
    ///Direct3D runtime.
    D3D12_DRED_FLAGS Flags;
    ///An output parameter of type pointer to [D3D12_AUTO_BREADCRUMB_NODE](ns-d3d12-d3d12_auto_breadcrumb_node.md)
    ///representing the returned auto-breadcrumb object(s). This is a pointer to the head of a linked list of
    ///auto-breadcrumb objects. All of the nodes in the linked list represent potentially incomplete command list
    ///execution on the GPU at the time of the device-removal event.
    D3D12_AUTO_BREADCRUMB_NODE* pHeadAutoBreadcrumbNode;
}

///Describes, as a node in a linked list, data about an allocation tracked by Device Removed Extended Data (DRED). This
///data includes the GPU VA allocation ranges, and an associated runtime object debug name and type. Each
///**D3D12_DRED_ALLOCATION_NODE** object is singly linked to the next via its `pNext` member; except for the last node
///in the list, which has its `pNext` set to `nullptr`. A linked list structure is necessary because a runtime object
///can share allocation ranges with other objects. If device removal is caused by a GPU page fault&mdash;and DRED page
///fault reporting is enabled&mdash;then DRED builds a list of D3D12_DRED_ALLOCATION_NODE structs that includes all
///matching allocation nodes for active and recently-freed runtime objects.
struct D3D12_DRED_ALLOCATION_NODE
{
    ///A pointer to the ANSI debug name of the allocated runtime object.
    const(ubyte)* ObjectNameA;
    ///A pointer to the wide debug name of the allocated runtime object.
    const(PWSTR)  ObjectNameW;
    ///A [D3D12_DRED_ALLOCATION_TYPE](ne-d3d12-d3d12_dred_allocation_type.md) value representing the runtime object's
    ///allocation type.
    D3D12_DRED_ALLOCATION_TYPE AllocationType;
    ///A pointer to a constant **D3D12_DRED_ALLOCATION_NODE** representing the next allocation node in the list, or
    ///`nullptr` if this is the last node.
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

///Contains a pointer to the head of a linked list of
///[D3D12_AUTO_BREADCRUMB_NODE](ns-d3d12-d3d12_auto_breadcrumb_node.md) objects. The list represents the auto-breadcrumb
///state prior to device removal.
struct D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT
{
    ///A pointer to a constant [D3D12_AUTO_BREADCRUMB_NODE](ns-d3d12-d3d12_auto_breadcrumb_node.md) object representing
    ///the head of a linked list of auto-breadcrumb nodes, or `nullptr` if the list is empty.
    const(D3D12_AUTO_BREADCRUMB_NODE)* pHeadAutoBreadcrumbNode;
}

struct D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1
{
    const(D3D12_AUTO_BREADCRUMB_NODE1)* pHeadAutoBreadcrumbNode;
}

///Describes allocation data related to a GPU page fault on a given virtual address (VA). Contains the VA of a GPU page
///fault, together with a list of matching allocation nodes for active objects, and a list of allocation nodes for
///recently deleted objects.
struct D3D12_DRED_PAGE_FAULT_OUTPUT
{
    ///A [D3D12_GPU_VIRTUAL_ADDRESS](/windows/desktop/direct3d12/d3d12_gpu_virtual_address) containing the GPU virtual
    ///address (VA) of the faulting operation if device removal was due to a GPU page fault.
    ulong PageFaultVA;
    ///A pointer to a constant [D3D12_DRED_ALLOCATION_NODE](ns-d3d12-d3d12_dred_allocation_node.md) object representing
    ///the head of a linked list of allocation nodes for active allocated runtime objects with virtual address (VA)
    ///ranges that match the faulting VA (`PageFaultVA`). Has a value of `nullptr` if the list is empty.
    const(D3D12_DRED_ALLOCATION_NODE)* pHeadExistingAllocationNode;
    ///A pointer to a constant [D3D12_DRED_ALLOCATION_NODE](ns-d3d12-d3d12_dred_allocation_node.md) object representing
    ///the head of a linked list of allocation nodes for recently freed runtime objects with virtual address (VA) ranges
    ///that match the faulting VA (`PageFaultVA`). Has a value of `nullptr` if the list is empty.
    const(D3D12_DRED_ALLOCATION_NODE)* pHeadRecentFreedAllocationNode;
}

struct D3D12_DRED_PAGE_FAULT_OUTPUT1
{
    ulong PageFaultVA;
    const(D3D12_DRED_ALLOCATION_NODE1)* pHeadExistingAllocationNode;
    const(D3D12_DRED_ALLOCATION_NODE1)* pHeadRecentFreedAllocationNode;
}

///Represents Device Removed Extended Data (DRED) version 1.1 device removal data, so that debuggers and debugger
///extensions can access DRED data. Also see
///[D3D12_VERSIONED_DEVICE_REMOVED_EXTENDED_DATA](ns-d3d12-d3d12_versioned_device_removed_extended_data.md). This
///structure is not used by any interface methods, and it provides no runtime API access.
struct D3D12_DEVICE_REMOVED_EXTENDED_DATA1
{
    ///An [HRESULT](/windows/desktop/com/structure-of-com-error-codes) containing the reason the device was removed
    ///(matches the return value of
    ///[GetDeviceRemovedReason](/windows/desktop/api/d3d12/nf-d3d12-id3d12device-getdeviceremovedreason)). Also see [COM
    ///Error Codes (UI, Audio, DirectX, Codec)](/windows/desktop/com/com-error-codes-10).
    HRESULT DeviceRemovedReason;
    ///A [D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT](ns-d3d12-d3d12_auto_breadcrumb_node.md) value that contains the
    ///auto-breadcrumb state prior to device removal.
    D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT AutoBreadcrumbsOutput;
    ///A [D3D12_DRED_PAGE_FAULT_OUTPUT](ns-d3d12-d3d12_auto_breadcrumb_node.md) value that contains page fault data if
    ///device removal was the result of a GPU page fault.
    D3D12_DRED_PAGE_FAULT_OUTPUT PageFaultOutput;
}

struct D3D12_DEVICE_REMOVED_EXTENDED_DATA2
{
    HRESULT DeviceRemovedReason;
    D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1 AutoBreadcrumbsOutput;
    D3D12_DRED_PAGE_FAULT_OUTPUT1 PageFaultOutput;
}

///Represents versioned Device Removed Extended Data (DRED) data, so that debuggers and debugger extensions can access
///DRED data.
struct D3D12_VERSIONED_DEVICE_REMOVED_EXTENDED_DATA
{
    ///A [D3D12_DRED_VERSION](ne-d3d12-d3d12_dred_version.md) value, specifying a DRED version. This value determines
    ///which inner data member (of the union) is active.
    D3D12_DRED_VERSION Version;
union
    {
        D3D12_DEVICE_REMOVED_EXTENDED_DATA Dred_1_0;
        D3D12_DEVICE_REMOVED_EXTENDED_DATA1 Dred_1_1;
        D3D12_DEVICE_REMOVED_EXTENDED_DATA2 Dred_1_2;
    }
}

struct D3D12_FEATURE_DATA_PROTECTED_RESOURCE_SESSION_TYPE_COUNT
{
    uint NodeIndex;
    uint Count;
}

struct D3D12_FEATURE_DATA_PROTECTED_RESOURCE_SESSION_TYPES
{
    uint  NodeIndex;
    uint  Count;
    GUID* pTypes;
}

///Describes flags and protection type for a protected resource session, per adapter.
struct D3D12_PROTECTED_RESOURCE_SESSION_DESC1
{
    ///Type: **[UINT](/windows/win32/WinProg/windows-data-types)** The node mask. For single GPU operation, set this to
    ///zero. If there are multiple GPU nodes, then set a bit to identify the node (the device's physical adapter) to
    ///which the protected session applies. Each bit in the mask corresponds to a single node. Only 1 bit may be set.
    uint NodeMask;
    ///Type: **[D3D12_PROTECTED_RESOURCE_SESSION_FLAGS](./ne-d3d12-d3d12_protected_resource_session_flags.md)**
    ///Specifies the supported crypto sessions options.
    D3D12_PROTECTED_RESOURCE_SESSION_FLAGS Flags;
    ///Type: **[GUID](../guiddef/ns-guiddef-guid.md)** The GUID that represents the protection type. Microsoft defines
    ///**D3D12_PROTECTED_RESOURCES_SESSION_HARDWARE_PROTECTED**. Using the
    ///**D3D12_PROTECTED_RESOURCES_SESSION_HARDWARE_PROTECTED** GUID is equivalent to calling
    ///[**ID3D12Device4::CreateProtectedResourceSession**](./nf-d3d12-id3d12device4-createprotectedresourcesession.md).
    GUID ProtectionType;
}

///Describes the clear value to which resource(s) should be cleared at the beginning of a render pass.
struct D3D12_RENDER_PASS_BEGINNING_ACCESS_CLEAR_PARAMETERS
{
    ///A D3D12_CLEAR_VALUE. The clear value to which the resource(s) should be cleared.
    D3D12_CLEAR_VALUE ClearValue;
}

///Describes the access to resource(s) that is requested by an application at the transition into a render pass.
struct D3D12_RENDER_PASS_BEGINNING_ACCESS
{
    ///A D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE. The type of access being requested.
    D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE Type;
union
    {
        D3D12_RENDER_PASS_BEGINNING_ACCESS_CLEAR_PARAMETERS Clear;
    }
}

///Describes the subresources involved in resolving at the conclusion of a render pass.
struct D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_SUBRESOURCE_PARAMETERS
{
    ///A <b>UINT</b>. The source subresource.
    uint SrcSubresource;
    ///A <b>UINT</b>. The destination subresource.
    uint DstSubresource;
    ///A <b>UINT</b>. The x coordinate within the destination subresource.
    uint DstX;
    ///A <b>UINT</b>. The y coordinate within the destination subresource.
    uint DstY;
    ///A D3D12_RECT. The rectangle within the source subresource.
    RECT SrcRect;
}

///Describes a resource to resolve to at the conclusion of a render pass.
struct D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_PARAMETERS
{
    ///A pointer to an ID3D12Resource. The source resource.
    ID3D12Resource     pSrcResource;
    ///A pointer to an ID3D12Resource. The destination resource.
    ID3D12Resource     pDstResource;
    ///A <b>UINT</b>. The number of subresources.
    uint               SubresourceCount;
    ///A pointer to a constant array of D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_SUBRESOURCE_PARAMETERS. These
    ///subresources can be a subset of the render target's array slices, but you can't target subresources that aren't
    ///part of the render target view (RTV) or the depth/stencil view (DSV). > [!NOTE] > This pointer is directly
    ///referenced by the command list, and the memory for this array must remain alive and intact until
    ///[EndRenderPass](nf-d3d12-id3d12graphicscommandlist4-endrenderpass.md) is called.
    const(D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_SUBRESOURCE_PARAMETERS)* pSubresourceParameters;
    ///A DXGI_FORMAT. The data format of the resources.
    DXGI_FORMAT        Format;
    ///A D3D12_RESOLVE_MODE. The resolve operation.
    D3D12_RESOLVE_MODE ResolveMode;
    ///A <b>BOOL</b>. <b>TRUE</b> to preserve the resolve source, otherwise <b>FALSE</b>.
    BOOL               PreserveResolveSource;
}

///Describes the access to resource(s) that is requested by an application at the transition out of a render pass.
struct D3D12_RENDER_PASS_ENDING_ACCESS
{
    ///A D3D12_RENDER_PASS_ENDING_ACCESS_TYPE. The type of access being requested.
    D3D12_RENDER_PASS_ENDING_ACCESS_TYPE Type;
union
    {
        D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_PARAMETERS Resolve;
    }
}

///Describes bindings (fixed for the duration of the render pass) to one or more render target views (RTVs), as well as
///their beginning and ending access characteristics.
struct D3D12_RENDER_PASS_RENDER_TARGET_DESC
{
    ///A D3D12_CPU_DESCRIPTOR_HANDLE. The CPU descriptor handle corresponding to the render target view(s) (RTVs).
    D3D12_CPU_DESCRIPTOR_HANDLE cpuDescriptor;
    ///A D3D12_RENDER_PASS_BEGINNING_ACCESS. The access to the RTV(s) requested at the transition into a render pass.
    D3D12_RENDER_PASS_BEGINNING_ACCESS BeginningAccess;
    ///A D3D12_RENDER_PASS_ENDING_ACCESS. The access to the RTV(s) requested at the transition out of a render pass.
    D3D12_RENDER_PASS_ENDING_ACCESS EndingAccess;
}

///Describes a binding (fixed for the duration of the render pass) to a depth stencil view (DSV), as well as its
///beginning and ending access characteristics.
struct D3D12_RENDER_PASS_DEPTH_STENCIL_DESC
{
    ///A D3D12_CPU_DESCRIPTOR_HANDLE. The CPU descriptor handle corresponding to the depth stencil view (DSV).
    D3D12_CPU_DESCRIPTOR_HANDLE cpuDescriptor;
    ///A D3D12_RENDER_PASS_BEGINNING_ACCESS. The access to the depth buffer requested at the transition into a render
    ///pass.
    D3D12_RENDER_PASS_BEGINNING_ACCESS DepthBeginningAccess;
    ///A D3D12_RENDER_PASS_BEGINNING_ACCESS. The access to the stencil buffer requested at the transition into a render
    ///pass.
    D3D12_RENDER_PASS_BEGINNING_ACCESS StencilBeginningAccess;
    ///A D3D12_RENDER_PASS_ENDING_ACCESS. The access to the depth buffer requested at the transition out of a render
    ///pass.
    D3D12_RENDER_PASS_ENDING_ACCESS DepthEndingAccess;
    ///A D3D12_RENDER_PASS_ENDING_ACCESS. The access to the stencil buffer requested at the transition out of a render
    ///pass.
    D3D12_RENDER_PASS_ENDING_ACCESS StencilEndingAccess;
}

///Describes the properties of a ray dispatch operation initiated with a call to
///ID3D12GraphicsCommandList4::DispatchRays.
struct D3D12_DISPATCH_RAYS_DESC
{
    ///The shader record for the ray generation shader to use. The memory pointed to must be in state
    ///D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE. The address must be aligned to 64 bytes, defined as
    ///D3D12_RAYTRACING_SHADER_TABLE_BYTE_ALIGNMENT, and in the range [0...4096] bytes.
    D3D12_GPU_VIRTUAL_ADDRESS_RANGE RayGenerationShaderRecord;
    ///The shader table for miss shaders. The stride is record stride, and must be aligned to 32 bytes, defined as
    ///D3D12_RAYTRACING_SHADER_RECORD_BYTE_ALIGNMENT, and in the range [0...4096] bytes. 0 is allowed. The memory
    ///pointed to must be in state D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE. The address must be aligned to 64
    ///bytes, defined as D3D12_RAYTRACING_SHADER_TABLE_BYTE_ALIGNMENT.
    D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE MissShaderTable;
    ///The shader table for hit groups. The stride is record stride, and must be aligned to 32 bytes, defined as
    ///D3D12_RAYTRACING_SHADER_RECORD_BYTE_ALIGNMENT, and in the range [0...4096] bytes. 0 is allowed. The memory
    ///pointed to must be in state D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE. The address must be aligned to 64
    ///bytes, defined as D3D12_RAYTRACING_SHADER_TABLE_BYTE_ALIGNMENT.
    D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE HitGroupTable;
    ///The shader table for callable shaders. The stride is record stride, and must be aligned to 32 bytes, defined as
    ///D3D12_RAYTRACING_SHADER_RECORD_BYTE_ALIGNMENT. 0 is allowed. The memory pointed to must be in state
    ///D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE. The address must be aligned to 64 bytes, defined as
    ///D3D12_RAYTRACING_SHADER_TABLE_BYTE_ALIGNMENT.
    D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE CallableShaderTable;
    ///The width of the generation shader thread grid.
    uint Width;
    ///The height of the generation shader thread grid.
    uint Height;
    uint Depth;
}

///Describes subresource data.
struct D3D12_SUBRESOURCE_DATA
{
    ///A pointer to a memory block that contains the subresource data.
    const(void)* pData;
    ///The row pitch, or width, or physical size, in bytes, of the subresource data.
    ptrdiff_t    RowPitch;
    ///The depth pitch, or width, or physical size, in bytes, of the subresource data.
    ptrdiff_t    SlicePitch;
}

///Describes the destination of a memory copy operation.
struct D3D12_MEMCPY_DEST
{
    ///A pointer to a memory block that receives the copied data.
    void*  pData;
    ///The row pitch, or width, or physical size, in bytes, of the subresource data.
    size_t RowPitch;
    ///The slice pitch, or width, or physical size, in bytes, of the subresource data.
    size_t SlicePitch;
}

///Describes settings used by GPU-Based Validation.
struct D3D12_DEBUG_DEVICE_GPU_BASED_VALIDATION_SETTINGS
{
    ///Specifies a UINT that limits the number of messages that can be stored in the GPU-Based Validation message log.
    ///The default value is 256. Since many identical errors can be produced in a single Draw/Dispatch call it may be
    ///useful to increase this number. Note this can become a memory burden if a large number of command lists are used
    ///as there is a committed message log per command list.
    uint MaxMessagesPerCommandList;
    ///Specifies the D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE that GPU-Based Validation uses when injecting
    ///validation code into shaders, except when overridden by per-command-list GPU-Based Validation settings (see
    ///D3D12_DEBUG_COMMAND_LIST_GPU_BASED_VALIDATION_SETTINGS). The default value is
    ///D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_UNGUARDED_VALIDATION.
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE DefaultShaderPatchMode;
    ///Specifies one of the D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS that indicates how GPU-Based
    ///Validation handles patching pipeline states. The default value is
    ///D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_NONE.
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS PipelineStateCreateFlags;
}

///Describes the amount of artificial slowdown inserted by the debug device to simulate lower-performance graphics
///adapters.
struct D3D12_DEBUG_DEVICE_GPU_SLOWDOWN_PERFORMANCE_FACTOR
{
    ///Specifies the amount of slowdown artificially applied, as a factor of the nominal time for the fence to signal.
    ///The default value is 0.
    float SlowdownFactor;
}

///Describes per-command-list settings used by GPU-Based Validation.
struct D3D12_DEBUG_COMMAND_LIST_GPU_BASED_VALIDATION_SETTINGS
{
    ///Specifies a D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE that overrides the default device-level shader patch
    ///mode (see ID3D12DebugDevice1::SetDebugParameter). By default this value is initialized to the
    ///<i>DefaultShaderPatchMode</i> assigned to the device (see D3D12_DEBUG_DEVICE_GPU_BASED_VALIDATION_SETTINGS.
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE ShaderPatchMode;
}

///A debug message in the Information Queue.
struct D3D12_MESSAGE
{
    ///The category of the message. See D3D12_MESSAGE_CATEGORY.
    D3D12_MESSAGE_CATEGORY Category;
    ///The severity of the message. See D3D12_MESSAGE_SEVERITY.
    D3D12_MESSAGE_SEVERITY Severity;
    ///The ID of the message. See D3D12_MESSAGE_ID.
    D3D12_MESSAGE_ID ID;
    ///The message string.
    const(ubyte)*    pDescription;
    ///The length of <i>pDescription</i>, in bytes.
    size_t           DescriptionByteLength;
}

///Allow or deny certain types of messages to pass through a filter.
struct D3D12_INFO_QUEUE_FILTER_DESC
{
    ///Number of message categories to allow or deny.
    uint              NumCategories;
    ///Array of message categories to allow or deny. Array must have at least <i>NumCategories</i> members (see
    ///D3D12_MESSAGE_CATEGORY).
    D3D12_MESSAGE_CATEGORY* pCategoryList;
    ///Number of message severity levels to allow or deny.
    uint              NumSeverities;
    ///Array of message severity levels to allow or deny. Array must have at least <i>NumSeverities</i> members (see
    ///D3D12_MESSAGE_SEVERITY).
    D3D12_MESSAGE_SEVERITY* pSeverityList;
    ///Number of message IDs to allow or deny.
    uint              NumIDs;
    ///Array of message IDs to allow or deny. Array must have at least <i>NumIDs</i> members (see D3D12_MESSAGE_ID).
    D3D12_MESSAGE_ID* pIDList;
}

///Debug message filter; contains a lists of message types to allow or deny.
struct D3D12_INFO_QUEUE_FILTER
{
    ///Specifies types of messages that you want to allow. See D3D12_INFO_QUEUE_FILTER_DESC.
    D3D12_INFO_QUEUE_FILTER_DESC AllowList;
    ///Specifies types of messages that you want to deny.
    D3D12_INFO_QUEUE_FILTER_DESC DenyList;
}

struct D3D12_DISPATCH_MESH_ARGUMENTS
{
    uint ThreadGroupCountX;
    uint ThreadGroupCountY;
    uint ThreadGroupCountZ;
}

///Used with ID3D11On12Device::CreateWrappedResourceto override flags that would be inferred by the resource properties
///or heap properties, including bind flags, misc flags, and CPU access flags.
struct D3D11_RESOURCE_FLAGS
{
    ///Bind flags must be either completely inferred, or completely specified, to allow the graphics driver to scope a
    ///general D3D12 resource to something that D3D11 can understand. If a bind flag is specified which is not supported
    ///by the provided resource, an error will be returned. The following bind flags (D3D11_BIND_FLAG enumeration
    ///constants) will not be assumed, and must be specified in order for a resource to be used in such a fashion: <ul>
    ///<li>D3D11_BIND_VERTEX_BUFFER </li> <li>D3D11_BIND_INDEX_BUFFER </li> <li>D3D11_BIND_CONSTANT_BUFFER </li>
    ///<li>D3D11_BIND_STREAM_OUTPUT </li> <li>D3D11_BIND_DECODER </li> <li>D3D11_BIND_VIDEO_ENCODER </li> </ul> The
    ///following bind flags will be assumed based on the presence of the corresponding D3D12 resource flag, and can be
    ///removed by specifying bind flags: <ul> <li>D3D11_BIND_SHADER_RESOURCE, as long as
    ///D3D12_RESOURCE_MISC_DENY_SHADER_RESOURCE is not present </li> <li>D3D11_BIND_RENDER_TARGET, if
    ///D3D12_RESOURCE_MISC_ALLOW_RENDER_TARGET is present </li> <li>D3D11_BIND_DEPTH_STENCIL, if
    ///D3D12_RESOURCE_MISC_ALLOW_DEPTH_STENCIL is present </li> <li>D3D11_BIND_UNORDERED_ACCESS, if
    ///D3D12_RESOURCE_MISC_ALLOW_UNORDERED_ACCESS is present</li> </ul> A render target or UAV buffer can be wrapped
    ///without overriding flags; but a VB/IB/CB/SO buffer must have bind flags manually specified, since these are
    ///mutually exclusive in Direct3D 11.
    uint BindFlags;
    ///If misc flags are nonzero, then any specified flags will be OR’d into the final resource desc with inferred
    ///flags. Misc flags can be partially specified in order to add functionality, but misc flags which are implied
    ///cannot be masked out. The following misc flags (D3D11_RESOURCE_MISC_FLAG enumeration constants) will not be
    ///assumed: <ul> <li>D3D11_RESOURCE_MISC_GENERATE_MIPS (conflicts with CLAMP). </li>
    ///<li>D3D11_RESOURCE_MISC_TEXTURECUBE (alters default view behavior). </li>
    ///<li>D3D11_RESOURCE_MISC_DRAWINDIRECT_ARGS (exclusive with some bind flags). </li>
    ///<li>D3D11_RESOURCE_MISC_BUFFER_ALLOW_RAW_VIEWS (exclusive with other types of UAVs). </li>
    ///<li>D3D11_RESOURCE_MISC_BUFFER_STRUCTURED (exclusive with other types of UAVs). </li>
    ///<li>D3D11_RESOURCE_MISC_RESOURCE_CLAMP (prohibits D3D10 QIs, conflicts with GENERATE_MIPS). </li>
    ///<li>D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX. It is possible to create a D3D11 keyed mutex resource, create a shared
    ///handle for it, and open it via 11on12 or D3D11. </li> </ul> The following misc flags will be assumed, and cannot
    ///be removed from the produced resource desc. If one of these is set, and the D3D12 resource does not support it,
    ///creation will fail: <ul> <li>D3D11_RESOURCE_MISC_SHARED, D3D11_RESOURCE_MISC_SHARED_NTHANDLE,
    ///D3D11_RESOURCE_MISC_RESTRICT_SHARED_RESOURCE, if appropriate heap misc flags are present. </li>
    ///<li>D3D11_RESOURCE_MISC_GDI_COMPATIBLE, if D3D12 resource is GDI-compatible. </li> <li>D3D11_RESOURCE_MISC_TILED,
    ///if D3D12 resource was created via CreateReservedResource. </li> <li>D3D11_RESOURCE_MISC_TILE_POOL, if a D3D12
    ///heap was passed in. </li> </ul> The following misc flags are invalid to specify for this API: <ul>
    ///<li>D3D11_RESOURCE_MISC_RESTRICTED_CONTENT, since D3D12 only supports hardware protection. </li>
    ///<li>D3D11_RESOURCE_MISC_RESTRICT_SHARED_RESOURCE_DRIVER does not exist in 12, and cannot be added in after
    ///resource creation. </li> <li>D3D11_RESOURCE_MISC_GUARDED is only meant to be set by an internal creation
    ///mechanism. </li> </ul>
    uint MiscFlags;
    ///The <b>CPUAccessFlags</b> are not inferred from the D3D12 resource. This is because all resources are treated as
    ///D3D11_USAGE_DEFAULT, so <b>CPUAccessFlags</b> force validation which assumes Map of default buffers or textures.
    ///Wrapped resources do not support <b>Map(DISCARD)</b>. Wrapped resources do not support <b>Map(NO_OVERWRITE)</b>,
    ///but that can be implemented by mapping the underlying D3D12 resource instead. Issuing a <b>Map</b> call on a
    ///wrapped resource will synchronize with all D3D11 work submitted against that resource, unless the DO_NOT_WAIT
    ///flag was used.
    uint CPUAccessFlags;
    ///The size of each element in the buffer structure (in bytes) when the buffer represents a structured buffer.
    uint StructureByteStride;
}

///Describes a shader signature.
struct D3D12_SIGNATURE_PARAMETER_DESC
{
    ///A per-parameter string that identifies how the data will be used. For more info, see Semantics.
    const(PSTR)       SemanticName;
    ///Semantic index that modifies the semantic. Used to differentiate different parameters that use the same semantic.
    uint              SemanticIndex;
    ///The register that will contain this variable's data.
    uint              Register;
    ///A D3D_NAME-typed value that identifies a predefined string that determines the functionality of certain pipeline
    ///stages.
    D3D_NAME          SystemValueType;
    ///A D3D_REGISTER_COMPONENT_TYPE-typed value that identifies the per-component-data type that is stored in a
    ///register. Each register can store up to four-components of data.
    D3D_REGISTER_COMPONENT_TYPE ComponentType;
    ///Mask which indicates which components of a register are used.
    ubyte             Mask;
    ///Mask which indicates whether a given component is never written (if the signature is an output signature) or
    ///always read (if the signature is an input signature).
    ubyte             ReadWriteMask;
    ///Indicates which stream the geometry shader is using for the signature parameter.
    uint              Stream;
    ///A D3D_MIN_PRECISION-typed value that indicates the minimum desired interpolation precision. For more info, see
    ///Using HLSL minimum precision.
    D3D_MIN_PRECISION MinPrecision;
}

///Describes a shader constant-buffer.
struct D3D12_SHADER_BUFFER_DESC
{
    ///The name of the buffer.
    const(PSTR)      Name;
    ///A D3D_CBUFFER_TYPE-typed value that indicates the intended use of the constant data.
    D3D_CBUFFER_TYPE Type;
    ///The number of unique variables.
    uint             Variables;
    ///The size of the buffer, in bytes.
    uint             Size;
    ///A combination of D3D_SHADER_CBUFFER_FLAGS-typed values that are combined by using a bitwise OR operation. The
    ///resulting value specifies properties for the shader constant-buffer.
    uint             uFlags;
}

///Describes a shader variable.
struct D3D12_SHADER_VARIABLE_DESC
{
    ///The variable name.
    const(PSTR) Name;
    ///Offset from the start of the parent structure to the beginning of the variable.
    uint        StartOffset;
    ///Size of the variable (in bytes).
    uint        Size;
    ///A combination of D3D_SHADER_VARIABLE_FLAGS-typed values that are combined by using a bitwise-OR operation. The
    ///resulting value identifies shader-variable properties.
    uint        uFlags;
    ///The default value for initializing the variable. Emits default values for reflection.
    void*       DefaultValue;
    ///Offset from the start of the variable to the beginning of the texture.
    uint        StartTexture;
    ///The size of the texture, in bytes.
    uint        TextureSize;
    ///Offset from the start of the variable to the beginning of the sampler.
    uint        StartSampler;
    ///The size of the sampler, in bytes.
    uint        SamplerSize;
}

///Describes a shader-variable type.
struct D3D12_SHADER_TYPE_DESC
{
    ///A D3D_SHADER_VARIABLE_CLASS-typed value that identifies the variable class as one of scalar, vector, matrix,
    ///object, and so on.
    D3D_SHADER_VARIABLE_CLASS Class;
    ///A D3D_SHADER_VARIABLE_TYPE-typed value that identifies the variable type.
    D3D_SHADER_VARIABLE_TYPE Type;
    ///Number of rows in a matrix. Otherwise a numeric type returns 1, any other type returns 0.
    uint        Rows;
    ///Number of columns in a matrix. Otherwise a numeric type returns 1, any other type returns 0.
    uint        Columns;
    ///Number of elements in an array; otherwise 0.
    uint        Elements;
    ///Number of members in the structure; otherwise 0.
    uint        Members;
    ///Offset, in bytes, between the start of the parent structure and this variable. Can be 0 if not a structure
    ///member.
    uint        Offset;
    ///Name of the shader-variable type. This member can be <b>NULL</b> if it isn't used. This member supports dynamic
    ///shader linkage interface types, which have names. For more info about dynamic shader linkage, see Dynamic
    ///Linking.
    const(PSTR) Name;
}

///Describes a shader.
struct D3D12_SHADER_DESC
{
    ///The Shader version, as an encoded UINT that corresponds to a shader model, such as "ps_5_0". <b>Version</b>
    ///describes the program type, a major version number, and a minor version number. The program type is a
    ///D3D12_SHADER_VERSION_TYPE enumeration constant. <b>Version</b> is decoded in the following way: <ul> <li>Program
    ///type = (Version &amp; 0xFFFF0000) &gt;&gt; 16</li> <li>Major version = (Version &amp; 0x000000F0) &gt;&gt; 4</li>
    ///<li>Minor version = (Version &amp; 0x0000000F)</li> </ul>
    uint          Version;
    ///The name of the originator of the shader.
    const(PSTR)   Creator;
    ///Shader compilation/parse flags.
    uint          Flags;
    ///The number of shader-constant buffers.
    uint          ConstantBuffers;
    ///The number of resource (textures and buffers) bound to a shader.
    uint          BoundResources;
    ///The number of parameters in the input signature.
    uint          InputParameters;
    ///The number of parameters in the output signature.
    uint          OutputParameters;
    ///The number of intermediate-language instructions in the compiled shader.
    uint          InstructionCount;
    ///The number of temporary registers in the compiled shader.
    uint          TempRegisterCount;
    ///Number of temporary arrays used.
    uint          TempArrayCount;
    ///Number of constant defines.
    uint          DefCount;
    ///Number of declarations (input + output).
    uint          DclCount;
    ///Number of non-categorized texture instructions.
    uint          TextureNormalInstructions;
    ///Number of texture load instructions
    uint          TextureLoadInstructions;
    ///Number of texture comparison instructions
    uint          TextureCompInstructions;
    ///Number of texture bias instructions
    uint          TextureBiasInstructions;
    ///Number of texture gradient instructions.
    uint          TextureGradientInstructions;
    ///Number of floating point arithmetic instructions used.
    uint          FloatInstructionCount;
    ///Number of signed integer arithmetic instructions used.
    uint          IntInstructionCount;
    ///Number of unsigned integer arithmetic instructions used.
    uint          UintInstructionCount;
    ///Number of static flow control instructions used.
    uint          StaticFlowControlCount;
    ///Number of dynamic flow control instructions used.
    uint          DynamicFlowControlCount;
    ///Number of macro instructions used.
    uint          MacroInstructionCount;
    ///Number of array instructions used.
    uint          ArrayInstructionCount;
    ///Number of cut instructions used.
    uint          CutInstructionCount;
    ///Number of emit instructions used.
    uint          EmitInstructionCount;
    ///The D3D_PRIMITIVE_TOPOLOGY-typed value that represents the geometry shader output topology.
    D3D_PRIMITIVE_TOPOLOGY GSOutputTopology;
    ///Geometry shader maximum output vertex count.
    uint          GSMaxOutputVertexCount;
    ///The D3D_PRIMITIVE-typed value that represents the input primitive for a geometry shader or hull shader.
    D3D_PRIMITIVE InputPrimitive;
    ///Number of parameters in the patch-constant signature.
    uint          PatchConstantParameters;
    ///Number of geometry shader instances.
    uint          cGSInstanceCount;
    ///Number of control points in the hull shader and domain shader.
    uint          cControlPoints;
    ///The D3D_TESSELLATOR_OUTPUT_PRIMITIVE-typed value that represents the tessellator output-primitive type.
    D3D_TESSELLATOR_OUTPUT_PRIMITIVE HSOutputPrimitive;
    ///The D3D_TESSELLATOR_PARTITIONING-typed value that represents the tessellator partitioning mode.
    D3D_TESSELLATOR_PARTITIONING HSPartitioning;
    ///The D3D_TESSELLATOR_DOMAIN-typed value that represents the tessellator domain.
    D3D_TESSELLATOR_DOMAIN TessellatorDomain;
    ///Number of barrier instructions in a compute shader.
    uint          cBarrierInstructions;
    ///Number of interlocked instructions in a compute shader.
    uint          cInterlockedInstructions;
    ///Number of texture writes in a compute shader.
    uint          cTextureStoreInstructions;
}

///Describes how a shader resource is bound to a shader input.
struct D3D12_SHADER_INPUT_BIND_DESC
{
    ///Name of the shader resource.
    const(PSTR)       Name;
    ///A D3D_SHADER_INPUT_TYPE-typed value that identifies the type of data in the resource.
    D3D_SHADER_INPUT_TYPE Type;
    ///Starting bind point.
    uint              BindPoint;
    ///Number of contiguous bind points for arrays.
    uint              BindCount;
    ///A combination of D3D_SHADER_INPUT_FLAGS-typed values for shader input-parameter options.
    uint              uFlags;
    ///If the input is a texture, the D3D_RESOURCE_RETURN_TYPE-typed value that identifies the return type.
    D3D_RESOURCE_RETURN_TYPE ReturnType;
    ///A D3D_SRV_DIMENSION-typed value that identifies the dimensions of the bound resource.
    D3D_SRV_DIMENSION Dimension;
    ///The number of samples for a multisampled texture; when a texture isn't multisampled, the value is set to -1
    ///(0xFFFFFFFF). This is zero if the shader resource is not a recognized texture.
    uint              NumSamples;
    ///The register space.
    uint              Space;
    ///The range ID in the bytecode.
    uint              uID;
}

///Describes a library.
struct D3D12_LIBRARY_DESC
{
    ///The name of the originator of the library.
    const(PSTR) Creator;
    ///A combination of D3DCOMPILE Constants that are combined by using a bitwise OR operation. The resulting value
    ///specifies how the compiler compiles.
    uint        Flags;
    ///The number of functions exported from the library.
    uint        FunctionCount;
}

///Describes a function.
struct D3D12_FUNCTION_DESC
{
    ///The shader version. See also D3D12_SHADER_VERSION_TYPE.
    uint              Version;
    ///The name of the originator of the function.
    const(PSTR)       Creator;
    ///A combination of D3DCOMPILE Constants that are combined by using a bitwise OR operation. The resulting value
    ///specifies shader compilation and parsing.
    uint              Flags;
    ///The number of constant buffers for the function.
    uint              ConstantBuffers;
    ///The number of bound resources for the function.
    uint              BoundResources;
    ///The number of emitted instructions for the function.
    uint              InstructionCount;
    ///The number of temporary registers used by the function.
    uint              TempRegisterCount;
    ///The number of temporary arrays used by the function.
    uint              TempArrayCount;
    ///The number of constant defines for the function.
    uint              DefCount;
    ///The number of declarations (input + output) for the function.
    uint              DclCount;
    ///The number of non-categorized texture instructions for the function.
    uint              TextureNormalInstructions;
    ///The number of texture load instructions for the function.
    uint              TextureLoadInstructions;
    ///The number of texture comparison instructions for the function.
    uint              TextureCompInstructions;
    ///The number of texture bias instructions for the function.
    uint              TextureBiasInstructions;
    ///The number of texture gradient instructions for the function.
    uint              TextureGradientInstructions;
    ///The number of floating point arithmetic instructions used by the function.
    uint              FloatInstructionCount;
    ///The number of signed integer arithmetic instructions used by the function.
    uint              IntInstructionCount;
    ///The number of unsigned integer arithmetic instructions used by the function.
    uint              UintInstructionCount;
    ///The number of static flow control instructions used by the function.
    uint              StaticFlowControlCount;
    ///The number of dynamic flow control instructions used by the function.
    uint              DynamicFlowControlCount;
    ///The number of macro instructions used by the function.
    uint              MacroInstructionCount;
    ///The number of array instructions used by the function.
    uint              ArrayInstructionCount;
    ///The number of mov instructions used by the function.
    uint              MovInstructionCount;
    ///The number of movc instructions used by the function.
    uint              MovcInstructionCount;
    ///The number of type conversion instructions used by the function.
    uint              ConversionInstructionCount;
    ///The number of bitwise arithmetic instructions used by the function.
    uint              BitwiseInstructionCount;
    ///A D3D_FEATURE_LEVEL-typed value that specifies the minimum Direct3D feature level target of the function byte
    ///code.
    D3D_FEATURE_LEVEL MinFeatureLevel;
    ///A value that contains a combination of one or more shader requirements flags; each flag specifies a requirement
    ///of the shader. A default value of 0 means there are no requirements. For a list of values, see
    ///ID3D12ShaderReflection::GetRequiresFlags.
    ulong             RequiredFeatureFlags;
    ///The name of the function.
    const(PSTR)       Name;
    ///The number of logical parameters in the function signature, not including the return value.
    int               FunctionParameterCount;
    ///Indicates whether the function returns a value. <b>TRUE</b> indicates it returns a value; otherwise, <b>FALSE</b>
    ///(it is a subroutine).
    BOOL              HasReturn;
    ///Indicates whether there is a Direct3D 10Level9 vertex shader blob. <b>TRUE</b> indicates there is a 10Level9
    ///vertex shader blob; otherwise, <b>FALSE</b>.
    BOOL              Has10Level9VertexShader;
    ///Indicates whether there is a Direct3D 10Level9 pixel shader blob. <b>TRUE</b> indicates there is a 10Level9 pixel
    ///shader blob; otherwise, <b>FALSE</b>.
    BOOL              Has10Level9PixelShader;
}

///Describes a function parameter.
struct D3D12_PARAMETER_DESC
{
    ///The name of the function parameter.
    const(PSTR)         Name;
    ///The HLSL semantic that is associated with this function parameter. This name includes the index, for example,
    ///SV_Target[n].
    const(PSTR)         SemanticName;
    ///A D3D_SHADER_VARIABLE_TYPE-typed value that identifies the variable type for the parameter.
    D3D_SHADER_VARIABLE_TYPE Type;
    ///A D3D_SHADER_VARIABLE_CLASS-typed value that identifies the variable class for the parameter as one of scalar,
    ///vector, matrix, object, and so on.
    D3D_SHADER_VARIABLE_CLASS Class;
    ///The number of rows for a matrix parameter.
    uint                Rows;
    ///The number of columns for a matrix parameter.
    uint                Columns;
    ///A D3D_INTERPOLATION_MODE-typed value that identifies the interpolation mode for the parameter.
    D3D_INTERPOLATION_MODE InterpolationMode;
    ///A combination of D3D_PARAMETER_FLAGS-typed values that are combined by using a bitwise OR operation. The
    ///resulting value specifies semantic flags for the parameter.
    D3D_PARAMETER_FLAGS Flags;
    ///The first input register for this parameter.
    uint                FirstInRegister;
    ///The first input register component for this parameter.
    uint                FirstInComponent;
    ///The first output register for this parameter.
    uint                FirstOutRegister;
    ///The first output register component for this parameter.
    uint                FirstOutComponent;
}

// Functions

///Serializes a root signature version 1.0 that can be passed to ID3D12Device::CreateRootSignature.
///Params:
///    pRootSignature = Type: <b>const D3D12_ROOT_SIGNATURE_DESC*</b> The description of the root signature, as a pointer to a
///                     D3D12_ROOT_SIGNATURE_DESC structure.
///    Version = Type: <b>D3D_ROOT_SIGNATURE_VERSION</b> A D3D_ROOT_SIGNATURE_VERSION-typed value that specifies the version of
///              root signature.
///    ppBlob = Type: <b>ID3DBlob**</b> A pointer to a memory block that receives a pointer to the ID3DBlob interface that you
///             can use to access the serialized root signature.
///    ppErrorBlob = Type: <b>ID3DBlob**</b> A pointer to a memory block that receives a pointer to the ID3DBlob interface that you
///                  can use to access serializer error messages, or <b>NULL</b> if there are no errors.
///Returns:
///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; otherwise, returns one of the Direct3D 12 Return Codes.
///    
@DllImport("d3d12")
HRESULT D3D12SerializeRootSignature(const(D3D12_ROOT_SIGNATURE_DESC)* pRootSignature, 
                                    D3D_ROOT_SIGNATURE_VERSION Version, ID3DBlob* ppBlob, ID3DBlob* ppErrorBlob);

///Deserializes a root signature so you can determine the layout definition (D3D12_ROOT_SIGNATURE_DESC).
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to the source data for the serialized root signature.
///    SrcDataSizeInBytes = Type: <b>SIZE_T</b> The size, in bytes, of the block of memory that <i>pSrcData</i> points to.
///    pRootSignatureDeserializerInterface = Type: <b><b>REFIID</b></b> The globally unique identifier (<b>GUID</b>) for the root signature deserializer
///                                          interface. See remarks.
///    ppRootSignatureDeserializer = Type: <b><b>void</b>**</b> A pointer to a memory block that receives a pointer to the root signature
///                                  deserializer.
///Returns:
///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; otherwise, returns one of the Direct3D 12 Return Codes.
///    
@DllImport("d3d12")
HRESULT D3D12CreateRootSignatureDeserializer(const(void)* pSrcData, size_t SrcDataSizeInBytes, 
                                             const(GUID)* pRootSignatureDeserializerInterface, 
                                             void** ppRootSignatureDeserializer);

///Serializes a root signature of any version that can be passed to ID3D12Device::CreateRootSignature.
///Params:
///    pRootSignature = Type: <b>const D3D12_VERSIONED_ROOT_SIGNATURE_DESC*</b> Specifies a D3D12_VERSIONED_ROOT_SIGNATURE_DESC that
///                     contains a description of any version of a root signature.
///    ppBlob = Type: <b>ID3DBlob**</b> A pointer to a memory block that receives a pointer to the ID3DBlob interface that you
///             can use to access the serialized root signature.
///    ppErrorBlob = Type: <b>ID3DBlob**</b> A pointer to a memory block that receives a pointer to the ID3DBlob interface that you
///                  can use to access serializer error messages, or <b>NULL</b> if there are no errors.
///Returns:
///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; otherwise, returns one of the Direct3D 12 Return Codes.
///    
@DllImport("d3d12")
HRESULT D3D12SerializeVersionedRootSignature(const(D3D12_VERSIONED_ROOT_SIGNATURE_DESC)* pRootSignature, 
                                             ID3DBlob* ppBlob, ID3DBlob* ppErrorBlob);

///Generates an interface that can return the deserialized data structure, via GetUnconvertedRootSignatureDesc.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to the source data for the serialized root signature.
///    SrcDataSizeInBytes = Type: <b>SIZE_T</b> The size, in bytes, of the block of memory that <i>pSrcData</i> points to.
///    pRootSignatureDeserializerInterface = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the root signature deserializer interface.
///                                          See remarks.
///    ppRootSignatureDeserializer = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the root signature deserializer.
///Returns:
///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; otherwise, returns one of the Direct3D 12 Return Codes.
///    
@DllImport("d3d12")
HRESULT D3D12CreateVersionedRootSignatureDeserializer(const(void)* pSrcData, size_t SrcDataSizeInBytes, 
                                                      const(GUID)* pRootSignatureDeserializerInterface, 
                                                      void** ppRootSignatureDeserializer);

///Creates a device that represents the display adapter.
///Params:
///    pAdapter = Type: <b>IUnknown*</b> A pointer to the video adapter to use when creating a device. Pass <b>NULL</b> to use the
///               default adapter, which is the first adapter that is enumerated by IDXGIFactory1::EnumAdapters. <div
///               class="alert"><b>Note</b> Don't mix the use of DXGI 1.0 (IDXGIFactory) and DXGI 1.1 (IDXGIFactory1) in an
///               application. Use <b>IDXGIFactory</b> or <b>IDXGIFactory1</b>, but not both in an application. </div> <div> </div>
///    MinimumFeatureLevel = Type: <b>D3D_FEATURE_LEVEL</b> The minimum D3D_FEATURE_LEVEL required for successful device creation.
///    riid = Type: <b><b>REFIID</b></b> The globally unique identifier (<b>GUID</b>) for the device interface. This parameter,
///           and <i>ppDevice</i>, can be addressed with the single macro IID_PPV_ARGS.
///    ppDevice = Type: <b><b>void</b>**</b> A pointer to a memory block that receives a pointer to the device. Pass **NULL** to
///               test if device creation would succeed, but to not actually create the device. If **NULL** is passed and device
///               creation would succeed, **S_FALSE** is returned.
///Returns:
///    Type: <b>HRESULT</b> This method can return one of the Direct3D 12 Return Codes. Possible return values include
///    those documented for CreateDXGIFactory1 and IDXGIFactory::EnumAdapters. If **ppDevice** is **NULL** and the
///    function succeeds, **S_FALSE** is returned, rather than **S_OK**.
///    
@DllImport("d3d12")
HRESULT D3D12CreateDevice(IUnknown pAdapter, D3D_FEATURE_LEVEL MinimumFeatureLevel, const(GUID)* riid, 
                          void** ppDevice);

///Gets a debug interface.
///Params:
///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the debug interface. The <b>REFIID</b>, or
///           <b>GUID</b>, of the debug interface can be obtained by using the __uuidof() macro. For example,
///           __uuidof(ID3D12Debug) will get the <b>GUID</b> of the debug interface.
///    ppvDebug = Type: <b>void**</b> The debug interface, as a pointer to pointer to void. See ID3D12Debugand ID3D12DebugDevice.
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
///    
@DllImport("d3d12")
HRESULT D3D12GetDebugInterface(const(GUID)* riid, void** ppvDebug);

///Enables a list of experimental features.
///Params:
///    NumFeatures = Type: <b>UINT</b> The number of experimental features to enable.
///    pIIDs = Type: <b>const IID*</b> SAL: <code>__in_ecount(NumFeatures)</code> A pointer to an array of IDs that specify
///            which of the available experimental features to enable.
///    pConfigurationStructs = Type: <b>void*</b> SAL: <code>__in_ecount(NumFeatures)</code> Structures that contain additional configuration
///                            details that some experimental features might need to be enabled.
///    pConfigurationStructSizes = Type: <b>UINT*</b> SAL: <code>__in_ecount(NumFeatures)</code> The sizes of any configuration structs passed in
///                                pConfigurationStructs parameter.
///Returns:
///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code that can include E_NOINTERFACE if an
///    unrecognized feature is specified or Developer Mode is not enabled, or E_INVALIDARG if the configuration of a
///    feature is in correct, the experimental features specified are not compatible, or other errors.
///    
@DllImport("d3d12")
HRESULT D3D12EnableExperimentalFeatures(uint NumFeatures, const(GUID)* pIIDs, void* pConfigurationStructs, 
                                        uint* pConfigurationStructSizes);

///Creates a device that uses Direct3D 11 functionality in Direct3D 12, specifying a pre-existing Direct3D 12 device to
///use for Direct3D 11 interop.
///Params:
///    pDevice = Type: <b>IUnknown*</b> Specifies a pre-existing Direct3D 12 device to use for Direct3D 11 interop. May not be
///              NULL.
///    Flags = Type: <b>UINT</b> One or more bitwise OR'd flags from D3D11_CREATE_DEVICE_FLAG. These are the same flags as those
///            used by D3D11CreateDeviceAndSwapChain. Specifies which runtime layers to enable. <i>Flags</i> must be compatible
///            with device flags, and its <i>NodeMask</i> must be a subset of the <i>NodeMask</i> provided to the present API.
///    pFeatureLevels = Type: <b>const D3D_FEATURE_LEVEL*</b> An array of any of the following: <ul> <li>D3D_FEATURE_LEVEL_12_1</li>
///                     <li>D3D_FEATURE_LEVEL_12_0</li> <li>D3D_FEATURE_LEVEL_11_1</li> <li>D3D_FEATURE_LEVEL_11_0</li>
///                     <li>D3D_FEATURE_LEVEL_10_1</li> <li>D3D_FEATURE_LEVEL_10_0</li> <li>D3D_FEATURE_LEVEL_9_3</li>
///                     <li>D3D_FEATURE_LEVEL_9_2</li> <li>D3D_FEATURE_LEVEL_9_1</li> </ul> The first feature level that is less than or
///                     equal to the Direct3D 12 device's feature level will be used to perform Direct3D 11 validation. Creation will
///                     fail if no acceptable feature levels are provided. Providing NULL will default to the Direct3D 12 device's
///                     feature level.
///    FeatureLevels = Type: <b>UINT</b> The size of (that is, the number of elements in) the *pFeatureLevels* array.
///    ppCommandQueues = Type: <b>IUnknown* const *</b> An array of unique queues for D3D11On12 to use. The queues must be of the 3D
///                      command queue type.
///    NumQueues = Type: <b>UINT</b> The size of (that is, the number of elements in) the *ppCommandQueues* array.
///    NodeMask = Type: <b>UINT</b> Which node of the Direct3D 12 device to use. Only 1 bit may be set.
///    ppDevice = Type: <b>ID3D11Device**</b> Pointer to the returned ID3D11Device. May be NULL.
///    ppImmediateContext = Type: <b>ID3D11DeviceContext**</b> A pointer to the returned ID3D11DeviceContext. May be NULL.
///    pChosenFeatureLevel = Type: <b>D3D_FEATURE_LEVEL*</b> A pointer to the returned feature level. May be NULL.
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes that are documented for
///    D3D11CreateDevice. This method returns DXGI_ERROR_SDK_COMPONENT_MISSINGif you specify D3D11_CREATE_DEVICE_DEBUGin
///    <i>Flags</i>and the incorrect version of the debug layer is installed on your computer. Install the latest
///    Windows SDK to get the correct version.
///    
@DllImport("d3d11")
HRESULT D3D11On12CreateDevice(IUnknown pDevice, uint Flags, const(D3D_FEATURE_LEVEL)* pFeatureLevels, 
                              uint FeatureLevels, IUnknown* ppCommandQueues, uint NumQueues, uint NodeMask, 
                              ID3D11Device* ppDevice, ID3D11DeviceContext* ppImmediateContext, 
                              D3D_FEATURE_LEVEL* pChosenFeatureLevel);


// Interfaces

///An interface from which ID3D12Device and ID3D12DeviceChild inherit from. It provides methods to associate private
///data and annotate object names.
@GUID("C4FEC28F-7966-4E95-9F94-F431CB56C3B8")
interface ID3D12Object : IUnknown
{
    ///Gets application-defined data from a device object.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> The <b>GUID</b> that is associated with the data.
    ///    pDataSize = Type: <b>UINT*</b> A pointer to a variable that on input contains the size, in bytes, of the buffer that
    ///                <i>pData</i> points to, and on output contains the size, in bytes, of the amount of data that
    ///                <b>GetPrivateData</b> retrieved.
    ///    pData = Type: <b>void*</b> A pointer to a memory block that receives the data from the device object if
    ///            <i>pDataSize</i> points to a value that specifies a buffer large enough to hold the data.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetPrivateData(const(GUID)* guid, uint* pDataSize, void* pData);
    ///Sets application-defined data to a device object and associates that data with an application-defined
    ///<b>GUID</b>.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> The <b>GUID</b> to associate with the data.
    ///    DataSize = Type: <b>UINT</b> The size in bytes of the data.
    ///    pData = Type: <b>const void*</b> A pointer to a memory block that contains the data to be stored with this device
    ///            object. If <i>pData</i> is <b>NULL</b>, <i>DataSize</i> must also be 0, and any data that was previously
    ///            associated with the <b>GUID</b> specified in <i>guid</i> will be destroyed.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetPrivateData(const(GUID)* guid, uint DataSize, const(void)* pData);
    ///Associates an IUnknown-derived interface with the device object and associates that interface with an
    ///application-defined <b>GUID</b>.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> The <b>GUID</b> to associate with the interface.
    ///    pData = Type: <b>const IUnknown*</b> A pointer to the IUnknown-derived interface to be associated with the device
    ///            object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetPrivateDataInterface(const(GUID)* guid, const(IUnknown) pData);
    ///Associates a name with the device object. This name is for use in debug diagnostics and tools.
    ///Params:
    ///    Name = Type: <b>LPCWSTR</b> A <b>NULL</b>-terminated <b>UNICODE</b> string that contains the name to associate with
    ///           the device object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetName(const(PWSTR) Name);
}

///An interface from which other core interfaces inherit from, including (but not limited to) ID3D12PipelineLibrary,
///ID3D12CommandList, ID3D12Pageable, and ID3D12RootSignature. It provides a method to get back to the device object it
///was created against.
@GUID("905DB94B-A00C-4140-9DF5-2B64CA9EA357")
interface ID3D12DeviceChild : ID3D12Object
{
    ///Gets a pointer to the device that created this interface.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the device interface. The <b>REFIID</b>,
    ///           or <b>GUID</b>, of the interface to the device can be obtained by using the __uuidof() macro. For example,
    ///           __uuidof(ID3D12Device) will get the <b>GUID</b> of the interface to a device.
    ///    ppvDevice = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the ID3D12Device interface for the
    ///                device.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetDevice(const(GUID)* riid, void** ppvDevice);
}

///The root signature defines what resources are bound to the graphics pipeline. A root signature is configured by the
///app and links command lists to the resources the shaders require. Currently, there is one graphics and one compute
///root signature per app.
@GUID("C54A6B66-72DF-4EE8-8BE5-A946A1429214")
interface ID3D12RootSignature : ID3D12DeviceChild
{
}

///Contains a method to return the deserialized D3D12_ROOT_SIGNATURE_DESC data structure, of a serialized root signature
///version 1.0.
@GUID("34AB647B-3CC8-46AC-841B-C0965645C046")
interface ID3D12RootSignatureDeserializer : IUnknown
{
    ///Gets the layout of the root signature.
    ///Returns:
    ///    Type: <b>D3D12_ROOT_SIGNATURE_DESC</b> This method returns a deserialized root signature in a
    ///    D3D12_ROOT_SIGNATURE_DESC structure that describes the layout of the root signature.
    ///    
    D3D12_ROOT_SIGNATURE_DESC* GetRootSignatureDesc();
}

///Contains methods to return the deserialized D3D12_ROOT_SIGNATURE_DESC1 data structure, of any version of a serialized
///root signature.
@GUID("7F91CE67-090C-4BB7-B78E-ED8FF2E31DA0")
interface ID3D12VersionedRootSignatureDeserializer : IUnknown
{
    ///Converts root signature description structures to a requested version.
    ///Params:
    ///    convertToVersion = Type: <b>D3D_ROOT_SIGNATURE_VERSION</b> Specifies the required D3D_ROOT_SIGNATURE_VERSION.
    ///    ppDesc = Type: <b>const D3D12_VERSIONED_ROOT_SIGNATURE_DESC**</b> Contains the deserialized root signature in a
    ///             D3D12_VERSIONED_ROOT_SIGNATURE_DESC structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code. The method can fail with
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT GetRootSignatureDescAtVersion(D3D_ROOT_SIGNATURE_VERSION convertToVersion, 
                                          const(D3D12_VERSIONED_ROOT_SIGNATURE_DESC)** ppDesc);
    ///Gets the layout of the root signature, without converting between root signature versions.
    ///Returns:
    ///    Type: <b>D3D12_VERSIONED_ROOT_SIGNATURE_DESC</b> This method returns a deserialized root signature in a
    ///    D3D12_VERSIONED_ROOT_SIGNATURE_DESC structure that describes the layout of the root signature.
    ///    
    D3D12_VERSIONED_ROOT_SIGNATURE_DESC* GetUnconvertedRootSignatureDesc();
}

///An interface from which many other core interfaces inherit from. It indicates that the object type encapsulates some
///amount of GPU-accessible memory; but does not strongly indicate whether the application can manipulate the object's
///residency.
@GUID("63EE58FB-1268-4835-86DA-F008CE62F0D6")
interface ID3D12Pageable : ID3D12DeviceChild
{
}

///A heap is an abstraction of contiguous memory allocation, used to manage physical memory. This heap can be used with
///ID3D12Resource objects to support placed resources or reserved resources.
@GUID("6B3B2502-6E51-45B3-90EE-9884265E8DF3")
interface ID3D12Heap : ID3D12Pageable
{
    ///Gets the heap description.
    ///Returns:
    ///    Type: <b>D3D12_HEAP_DESC</b> Returns the D3D12_HEAP_DESC structure that describes the heap.
    ///    
    D3D12_HEAP_DESC GetDesc();
}

///Encapsulates a generalized ability of the CPU and GPU to read and write to physical memory, or heaps. It contains
///abstractions for organizing and manipulating simple arrays of data as well as multidimensional data optimized for
///shader sampling.
@GUID("696442BE-A72E-4059-BC79-5B5C98040FAD")
interface ID3D12Resource : ID3D12Pageable
{
    ///Gets a CPU pointer to the specified subresource in the resource, but may not disclose the pointer value to
    ///applications. <b>Map</b> also invalidates the CPU cache, when necessary, so that CPU reads to this address
    ///reflect any modifications made by the GPU.
    ///Params:
    ///    Subresource = Type: <b>UINT</b> Specifies the index number of the subresource.
    ///    pReadRange = Type: <b>const D3D12_RANGE*</b> A pointer to a D3D12_RANGE structure that describes the range of memory to
    ///                 access. This indicates the region the CPU might read, and the coordinates are subresource-relative. A null
    ///                 pointer indicates the entire subresource might be read by the CPU. It is valid to specify the CPU won't read
    ///                 any data by passing a range where <b>End</b> is less than or equal to <b>Begin</b>.
    ///    ppData = Type: <b><b>void</b>**</b> A pointer to a memory block that receives a pointer to the resource data. A null
    ///             pointer is valid and is useful to cache a CPU virtual address range for methods like WriteToSubresource. When
    ///             <i>ppData</i> is not NULL, the pointer returned is never offset by any values in <i>pReadRange</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT Map(uint Subresource, const(D3D12_RANGE)* pReadRange, void** ppData);
    ///Invalidates the CPU pointer to the specified subresource in the resource. <b>Unmap</b> also flushes the CPU
    ///cache, when necessary, so that GPU reads to this address reflect any modifications made by the CPU.
    ///Params:
    ///    Subresource = Type: <b>UINT</b> Specifies the index of the subresource.
    ///    pWrittenRange = Type: <b>const D3D12_RANGE*</b> A pointer to a D3D12_RANGE structure that describes the range of memory to
    ///                    unmap. This indicates the region the CPU might have modified, and the coordinates are subresource-relative. A
    ///                    null pointer indicates the entire subresource might have been modified by the CPU. It is valid to specify the
    ///                    CPU didn't write any data by passing a range where <b>End</b> is less than or equal to <b>Begin</b>.
    void    Unmap(uint Subresource, const(D3D12_RANGE)* pWrittenRange);
    ///Gets the resource description.
    ///Returns:
    ///    Type: <b>D3D12_RESOURCE_DESC</b> A Direct3D 12 resource description structure.
    ///    
    D3D12_RESOURCE_DESC GetDesc();
    ///This method returns the GPU virtual address of a buffer resource.
    ///Returns:
    ///    Type: <b>D3D12_GPU_VIRTUAL_ADDRESS</b> This method returns the GPU virtual address. D3D12_GPU_VIRTUAL_ADDRESS
    ///    is a typedef'd synonym of UINT64.
    ///    
    ulong   GetGPUVirtualAddress();
    ///Uses the CPU to copy data into a subresource, enabling the CPU to modify the contents of most textures with
    ///undefined layouts.
    ///Params:
    ///    DstSubresource = Type: <b>UINT</b> Specifies the index of the subresource.
    ///    pDstBox = Type: <b>const D3D12_BOX*</b> A pointer to a box that defines the portion of the destination subresource to
    ///              copy the resource data into. If NULL, the data is written to the destination subresource with no offset. The
    ///              dimensions of the source must fit the destination (see D3D12_BOX). An empty box results in a no-op. A box is
    ///              empty if the top value is greater than or equal to the bottom value, or the left value is greater than or
    ///              equal to the right value, or the front value is greater than or equal to the back value. When the box is
    ///              empty, this method doesn't perform any operation.
    ///    pSrcData = Type: <b>const void*</b> A pointer to the source data in memory.
    ///    SrcRowPitch = Type: <b>UINT</b> The distance from one row of source data to the next row.
    ///    SrcDepthPitch = Type: <b>UINT</b> The distance from one depth slice of source data to the next.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT WriteToSubresource(uint DstSubresource, const(D3D12_BOX)* pDstBox, const(void)* pSrcData, 
                               uint SrcRowPitch, uint SrcDepthPitch);
    ///Uses the CPU to copy data from a subresource, enabling the CPU to read the contents of most textures with
    ///undefined layouts.
    ///Params:
    ///    pDstData = Type: <b>void*</b> A pointer to the destination data in memory.
    ///    DstRowPitch = Type: <b>UINT</b> The distance from one row of destination data to the next row.
    ///    DstDepthPitch = Type: <b>UINT</b> The distance from one depth slice of destination data to the next.
    ///    SrcSubresource = Type: <b>UINT</b> Specifies the index of the subresource to read from.
    ///    pSrcBox = Type: <b>const D3D12_BOX*</b> A pointer to a box that defines the portion of the destination subresource to
    ///              copy the resource data from. If NULL, the data is read from the destination subresource with no offset. The
    ///              dimensions of the destination must fit the destination (see D3D12_BOX). An empty box results in a no-op. A
    ///              box is empty if the top value is greater than or equal to the bottom value, or the left value is greater than
    ///              or equal to the right value, or the front value is greater than or equal to the back value. When the box is
    ///              empty, this method doesn't perform any operation.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT ReadFromSubresource(void* pDstData, uint DstRowPitch, uint DstDepthPitch, uint SrcSubresource, 
                                const(D3D12_BOX)* pSrcBox);
    ///Retrieves the properties of the resource heap, for placed and committed resources.
    ///Params:
    ///    pHeapProperties = Type: <b>D3D12_HEAP_PROPERTIES*</b> Pointer to a D3D12_HEAP_PROPERTIES structure, that on successful
    ///                      completion of the method will contain the resource heap properties.
    ///    pHeapFlags = Type: <b>D3D12_HEAP_FLAGS*</b> Specifies a D3D12_HEAP_FLAGS variable, that on successful completion of the
    ///                 method will contain any miscellaneous heap flags.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes. If the resource was created as
    ///    reserved, E_INVALIDARG is returned.
    ///    
    HRESULT GetHeapProperties(D3D12_HEAP_PROPERTIES* pHeapProperties, D3D12_HEAP_FLAGS* pHeapFlags);
}

///Represents the allocations of storage for graphics processing unit (GPU) commands.
@GUID("6102DEE4-AF59-4B09-B999-B44D73F09B24")
interface ID3D12CommandAllocator : ID3D12Pageable
{
    ///Indicates to re-use the memory that is associated with the command allocator.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_FAIL</b> if there is an actively recording command list
    ///    referencing the command allocator. The debug layer will also issue an error in this case. See Direct3D 12
    ///    Return Codes for other possible return values.
    ///    
    HRESULT Reset();
}

///Represents a fence, an object used for synchronization of the CPU and one or more GPUs.
@GUID("0A753DCF-C4D8-4B91-ADF6-BE5A60D95A76")
interface ID3D12Fence : ID3D12Pageable
{
    ///Gets the current value of the fence.
    ///Returns:
    ///    Type: <b>UINT64</b> Returns the current value of the fence. If the device has been removed, the return value
    ///    will be <b>UINT64_MAX</b>.
    ///    
    ulong   GetCompletedValue();
    ///Specifies an event that should be fired when the fence reaches a certain value.
    ///Params:
    ///    Value = Type: <b>UINT64</b> The fence value when the event is to be signaled.
    ///    hEvent = Type: <b>HANDLE</b> A handle to the event object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_OUTOFMEMORY</b> if the kernel components don’t have
    ///    sufficient memory to store the event in a list. See Direct3D 12 Return Codes for other possible return
    ///    values.
    ///    
    HRESULT SetEventOnCompletion(ulong Value, HANDLE hEvent);
    ///Sets the fence to the specified value.
    ///Params:
    ///    Value = Type: <b>UINT64</b> The value to set the fence to.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT Signal(ulong Value);
}

///Represents a fence. This interface extends ID3D12Fence, and supports the retrieval of the flags used to create the
///original fence. This new feature is useful primarily for opening shared fences. <div class="alert"><b>Note</b>
///<b>ID3D12Fence1</b> was introduced in the Windows 10 Fall Creators Update, and is the latest version of the
///ID3D12Fence interface. Applications targeting Windows 10 Fall Creators Update and later should use
///<b>ID3D12Fence1</b> instead of earlier versions.</div><div> </div>
@GUID("433685FE-E22B-4CA0-A8DB-B5B4F4DD0E4A")
interface ID3D12Fence1 : ID3D12Fence
{
    ///Gets the flags used to create the fence represented by the current instance.
    ///Returns:
    ///    Type: <b>D3D12_FENCE_FLAGS</b> The flags used to create the fence.
    ///    
    D3D12_FENCE_FLAGS GetCreationFlags();
}

///Represents the state of all currently set shaders as well as certain fixed function state objects.
@GUID("765A30F3-F624-4C6F-A828-ACE948622445")
interface ID3D12PipelineState : ID3D12Pageable
{
    ///Gets the cached blob representing the pipeline state.
    ///Params:
    ///    ppBlob = Type: <b>ID3DBlob**</b> After this method returns, points to the cached blob representing the pipeline state.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetCachedBlob(ID3DBlob* ppBlob);
}

///A descriptor heap is a collection of contiguous allocations of descriptors, one allocation for every descriptor.
///Descriptor heaps contain many object types that are not part of a Pipeline State Object (PSO), such as Shader
///Resource Views (SRVs), Unordered Access Views (UAVs), Constant Buffer Views (CBVs), and Samplers.
@GUID("8EFB471D-616C-4F49-90F7-127BB763FA51")
interface ID3D12DescriptorHeap : ID3D12Pageable
{
    ///Gets the descriptor heap description.
    ///Returns:
    ///    Type: <b>D3D12_DESCRIPTOR_HEAP_DESC</b> The description of the descriptor heap, as a
    ///    D3D12_DESCRIPTOR_HEAP_DESC structure.
    ///    
    D3D12_DESCRIPTOR_HEAP_DESC GetDesc();
    ///Gets the CPU descriptor handle that represents the start of the heap.
    ///Returns:
    ///    Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> Returns the CPU descriptor handle that represents the start of the
    ///    heap.
    ///    
    D3D12_CPU_DESCRIPTOR_HANDLE GetCPUDescriptorHandleForHeapStart();
    ///Gets the GPU descriptor handle that represents the start of the heap.
    ///Returns:
    ///    Type: <b>D3D12_GPU_DESCRIPTOR_HANDLE</b> Returns the GPU descriptor handle that represents the start of the
    ///    heap.
    ///    
    D3D12_GPU_DESCRIPTOR_HANDLE GetGPUDescriptorHandleForHeapStart();
}

///Manages a query heap. A query heap holds an array of queries, referenced by indexes.
@GUID("0D9658AE-ED45-469E-A61D-970EC583CAB4")
interface ID3D12QueryHeap : ID3D12Pageable
{
}

///A command signature object enables apps to specify indirect drawing, including the buffer format, command type and
///resource bindings to be used.
@GUID("C36A797C-EC80-4F0A-8985-A7B2475082D1")
interface ID3D12CommandSignature : ID3D12Pageable
{
}

///An interface from which ID3D12GraphicsCommandList inherits. It represents an ordered set of commands that the GPU
///executes, while allowing for extension to support other command lists than just those for graphics (such as compute
///and copy).
@GUID("7116D91C-E7E4-47CE-B8C6-EC8168F437E5")
interface ID3D12CommandList : ID3D12DeviceChild
{
    ///Gets the type of the command list, such as direct, bundle, compute, or copy.
    ///Returns:
    ///    Type: <b>D3D12_COMMAND_LIST_TYPE</b> This method returns the type of the command list, as a
    ///    D3D12_COMMAND_LIST_TYPE enumeration constant, such as direct, bundle, compute, or copy.
    ///    
    D3D12_COMMAND_LIST_TYPE GetType();
}

///Encapsulates a list of graphics commands for rendering. Includes APIs for instrumenting the command list execution,
///and for setting and clearing the pipeline state. <div class="alert"><b>Note</b> The latest version of this interface
///is ID3D12GraphicsCommandList1 introduced in the Windows 10 Creators Update. Applications targetting Windows 10
///Creators Update should use the <b>ID3D12GraphicsCommandList1</b> interface instead of
///<b>ID3D12GraphicsCommandList</b>.</div><div> </div>
@GUID("5B160D0F-AC1B-4185-8BA8-B3AE42A5A455")
interface ID3D12GraphicsCommandList : ID3D12CommandList
{
    ///Indicates that recording to the command list has finished.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; otherwise, returns one of the following values: <ul>
    ///    <li><b>E_FAIL</b> if the command list has already been closed, or an invalid API was called during command
    ///    list recording. </li> <li><b>E_OUTOFMEMORY</b> if the operating system ran out of memory during recording.
    ///    </li> <li><b>E_INVALIDARG</b> if an invalid argument was passed to the command list API during recording.
    ///    </li> </ul> See Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT Close();
    ///Resets a command list back to its initial state as if a new command list was just created.
    ///Params:
    ///    pAllocator = Type: <b>ID3D12CommandAllocator*</b> A pointer to the ID3D12CommandAllocator object that the device creates
    ///                 command lists from.
    ///    pInitialState = Type: <b>ID3D12PipelineState*</b> A pointer to the ID3D12PipelineState object that contains the initial
    ///                    pipeline state for the command list. This is optional and can be NULL. If NULL, the runtime sets a dummy
    ///                    initial pipeline state so that drivers don't have to deal with undefined state. The overhead for this is low,
    ///                    particularly for a command list, for which the overall cost of recording the command list likely dwarfs the
    ///                    cost of one initial state setting. So there is little cost in not setting the initial pipeline state
    ///                    parameter if it isn't convenient. For bundles on the other hand, it might make more sense to try to set the
    ///                    initial state parameter since bundles are likely smaller overall and can be reused frequently.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; otherwise, returns one of the following values: <ul>
    ///    <li><b>E_FAIL</b> if the command list was not in the "closed" state when the <b>Reset</b> call was made, or
    ///    the per-device limit would have been exceeded. </li> <li><b>E_OUTOFMEMORY</b> if the operating system ran out
    ///    of memory. </li> <li><b>E_INVALIDARG</b> if the allocator is currently being used with another command list
    ///    in the "recording" state or if the specified allocator was created with the wrong type. </li> </ul> See
    ///    Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT Reset(ID3D12CommandAllocator pAllocator, ID3D12PipelineState pInitialState);
    ///Resets the state of a direct command list back to the state it was in when the command list was created.
    ///Params:
    ///    pPipelineState = Type: <b>ID3D12PipelineState*</b> A pointer to the ID3D12PipelineState object that contains the initial
    ///                     pipeline state for the command list.
    void    ClearState(ID3D12PipelineState pPipelineState);
    ///Draws non-indexed, instanced primitives.
    ///Params:
    ///    VertexCountPerInstance = Type: <b>UINT</b> Number of vertices to draw.
    ///    InstanceCount = Type: <b>UINT</b> Number of instances to draw.
    ///    StartVertexLocation = Type: <b>UINT</b> Index of the first vertex.
    ///    StartInstanceLocation = Type: <b>UINT</b> A value added to each index before reading per-instance data from a vertex buffer.
    void    DrawInstanced(uint VertexCountPerInstance, uint InstanceCount, uint StartVertexLocation, 
                          uint StartInstanceLocation);
    ///Draws indexed, instanced primitives.
    ///Params:
    ///    IndexCountPerInstance = Type: <b>UINT</b> Number of indices read from the index buffer for each instance.
    ///    InstanceCount = Type: <b>UINT</b> Number of instances to draw.
    ///    StartIndexLocation = Type: <b>UINT</b> The location of the first index read by the GPU from the index buffer.
    ///    BaseVertexLocation = Type: <b>INT</b> A value added to each index before reading a vertex from the vertex buffer.
    ///    StartInstanceLocation = Type: <b>UINT</b> A value added to each index before reading per-instance data from a vertex buffer.
    void    DrawIndexedInstanced(uint IndexCountPerInstance, uint InstanceCount, uint StartIndexLocation, 
                                 int BaseVertexLocation, uint StartInstanceLocation);
    ///Executes a command list from a thread group.
    ///Params:
    ///    ThreadGroupCountX = Type: <b>UINT</b> The number of groups dispatched in the x direction. <i>ThreadGroupCountX</i> must be less
    ///                        than or equal to D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION (65535).
    ///    ThreadGroupCountY = Type: <b>UINT</b> The number of groups dispatched in the y direction. <i>ThreadGroupCountY</i> must be less
    ///                        than or equal to D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION (65535).
    ///    ThreadGroupCountZ = Type: <b>UINT</b> The number of groups dispatched in the z direction. <i>ThreadGroupCountZ</i> must be less
    ///                        than or equal to D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION (65535). In feature level 10 the value for
    ///                        <i>ThreadGroupCountZ</i> must be 1.
    void    Dispatch(uint ThreadGroupCountX, uint ThreadGroupCountY, uint ThreadGroupCountZ);
    ///Copies a region of a buffer from one resource to another.
    ///Params:
    ///    pDstBuffer = Type: <b>ID3D12Resource*</b> Specifies the destination ID3D12Resource.
    ///    DstOffset = Type: <b>UINT64</b> Specifies a UINT64 offset (in bytes) into the destination resource.
    ///    pSrcBuffer = Type: <b>ID3D12Resource*</b> Specifies the source ID3D12Resource.
    ///    SrcOffset = Type: <b>UINT64</b> Specifies a UINT64 offset (in bytes) into the source resource, to start the copy from.
    ///    NumBytes = Type: <b>UINT64</b> Specifies the number of bytes to copy.
    void    CopyBufferRegion(ID3D12Resource pDstBuffer, ulong DstOffset, ID3D12Resource pSrcBuffer, 
                             ulong SrcOffset, ulong NumBytes);
    ///This method uses the GPU to copy texture data between two locations. Both the source and the destination may
    ///reference texture data located within either a buffer resource or a texture resource.
    ///Params:
    ///    pDst = Type: <b>const D3D12_TEXTURE_COPY_LOCATION*</b> Specifies the destination D3D12_TEXTURE_COPY_LOCATION. The
    ///           subresource referred to must be in the D3D12_RESOURCE_STATE_COPY_DEST state.
    ///    DstX = Type: <b>UINT</b> The x-coordinate of the upper left corner of the destination region.
    ///    DstY = Type: <b>UINT</b> The y-coordinate of the upper left corner of the destination region. For a 1D subresource,
    ///           this must be zero.
    ///    DstZ = Type: <b>UINT</b> The z-coordinate of the upper left corner of the destination region. For a 1D or 2D
    ///           subresource, this must be zero.
    ///    pSrc = Type: <b>const D3D12_TEXTURE_COPY_LOCATION*</b> Specifies the source D3D12_TEXTURE_COPY_LOCATION. The
    ///           subresource referred to must be in the D3D12_RESOURCE_STATE_COPY_SOURCE state.
    ///    pSrcBox = Type: <b>const D3D12_BOX*</b> Specifies an optional D3D12_BOX that sets the size of the source texture to
    ///              copy.
    void    CopyTextureRegion(const(D3D12_TEXTURE_COPY_LOCATION)* pDst, uint DstX, uint DstY, uint DstZ, 
                              const(D3D12_TEXTURE_COPY_LOCATION)* pSrc, const(D3D12_BOX)* pSrcBox);
    ///Copies the entire contents of the source resource to the destination resource.
    ///Params:
    ///    pDstResource = Type: <b>ID3D12Resource*</b> A pointer to the ID3D12Resourceinterface that represents the destination
    ///                   resource.
    ///    pSrcResource = Type: <b>ID3D12Resource*</b> A pointer to the ID3D12Resourceinterface that represents the source resource.
    void    CopyResource(ID3D12Resource pDstResource, ID3D12Resource pSrcResource);
    ///Copies tiles from buffer to tiled resource or vice versa.
    ///Params:
    ///    pTiledResource = Type: <b>ID3D12Resource*</b> A pointer to a tiled resource.
    ///    pTileRegionStartCoordinate = Type: <b>const D3D12_TILED_RESOURCE_COORDINATE*</b> A pointer to a D3D12_TILED_RESOURCE_COORDINATE structure
    ///                                 that describes the starting coordinates of the tiled resource.
    ///    pTileRegionSize = Type: <b>const D3D12_TILE_REGION_SIZE*</b> A pointer to a D3D12_TILE_REGION_SIZE structure that describes the
    ///                      size of the tiled region.
    ///    pBuffer = Type: <b>ID3D12Resource*</b> A pointer to an ID3D12Resource that represents a default, dynamic, or staging
    ///              buffer.
    ///    BufferStartOffsetInBytes = Type: <b>UINT64</b> The offset in bytes into the buffer at <i>pBuffer</i> to start the operation.
    ///    Flags = Type: <b>D3D12_TILE_COPY_FLAGS</b> A combination of D3D12_TILE_COPY_FLAGS-typed values that are combined by
    ///            using a bitwise OR operation and that identifies how to copy tiles.
    void    CopyTiles(ID3D12Resource pTiledResource, 
                      const(D3D12_TILED_RESOURCE_COORDINATE)* pTileRegionStartCoordinate, 
                      const(D3D12_TILE_REGION_SIZE)* pTileRegionSize, ID3D12Resource pBuffer, 
                      ulong BufferStartOffsetInBytes, D3D12_TILE_COPY_FLAGS Flags);
    ///Copy a multi-sampled resource into a non-multi-sampled resource.
    ///Params:
    ///    pDstResource = Type: [in] <b>ID3D12Resource*</b> Destination resource. Must be a created on a D3D12_HEAP_TYPE_DEFAULT heap
    ///                   and be single-sampled. See ID3D12Resource.
    ///    DstSubresource = Type: [in] <b>UINT</b> A zero-based index, that identifies the destination subresource. Use
    ///                     D3D12CalcSubresource to calculate the subresource index if the parent resource is complex.
    ///    pSrcResource = Type: [in] <b>ID3D12Resource*</b> Source resource. Must be multisampled.
    ///    SrcSubresource = Type: [in] <b>UINT</b> The source subresource of the source resource.
    ///    Format = Type: [in] <b>DXGI_FORMAT</b> A DXGI_FORMAT that indicates how the multisampled resource will be resolved to
    ///             a single-sampled resource. See remarks.
    void    ResolveSubresource(ID3D12Resource pDstResource, uint DstSubresource, ID3D12Resource pSrcResource, 
                               uint SrcSubresource, DXGI_FORMAT Format);
    ///Bind information about the primitive type, and data order that describes input data for the input assembler
    ///stage.
    ///Params:
    ///    PrimitiveTopology = Type: <b>D3D12_PRIMITIVE_TOPOLOGY</b> The type of primitive and ordering of the primitive data (see
    ///                        D3D_PRIMITIVE_TOPOLOGY).
    void    IASetPrimitiveTopology(D3D_PRIMITIVE_TOPOLOGY PrimitiveTopology);
    ///Bind an array of viewports to the rasterizer stage of the pipeline.
    ///Params:
    ///    NumViewports = Type: <b>UINT</b> Number of viewports to bind. The range of valid values is (0,
    ///                   D3D12_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE).
    ///    pViewports = Type: <b>const D3D12_VIEWPORT*</b> An array of D3D12_VIEWPORT structures to bind to the device.
    void    RSSetViewports(uint NumViewports, const(D3D12_VIEWPORT)* pViewports);
    ///Binds an array of scissor rectangles to the rasterizer stage.
    ///Params:
    ///    NumRects = Type: <b>UINT</b> The number of scissor rectangles to bind.
    ///    pRects = Type: <b>const D3D12_RECT*</b> An array of scissor rectangles.
    void    RSSetScissorRects(uint NumRects, const(RECT)* pRects);
    ///Sets the blend factor that modulate values for a pixel shader, render target, or both.
    ///Params:
    ///    BlendFactor = Type: <b>const FLOAT[4]</b> Array of blend factors, one for each RGBA component.
    void    OMSetBlendFactor(const(float)* BlendFactor);
    ///Sets the reference value for depth stencil tests.
    ///Params:
    ///    StencilRef = Type: <b>UINT</b> Reference value to perform against when doing a depth-stencil test.
    void    OMSetStencilRef(uint StencilRef);
    ///Sets all shaders and programs most of the fixed-function state of the graphics processing unit (GPU) pipeline.
    ///Params:
    ///    pPipelineState = Type: <b>ID3D12PipelineState*</b> Pointer to the ID3D12PipelineState containing the pipeline state data.
    void    SetPipelineState(ID3D12PipelineState pPipelineState);
    ///Notifies the driver that it needs to synchronize multiple accesses to resources.
    ///Params:
    ///    NumBarriers = Type: <b>UINT</b> The number of submitted barrier descriptions.
    ///    pBarriers = Type: <b>const D3D12_RESOURCE_BARRIER*</b> Pointer to an array of barrier descriptions.
    void    ResourceBarrier(uint NumBarriers, const(D3D12_RESOURCE_BARRIER)* pBarriers);
    ///Executes a bundle.
    ///Params:
    ///    pCommandList = Type: <b>ID3D12GraphicsCommandList*</b> Specifies the ID3D12GraphicsCommandList that determines the bundle to
    ///                   be executed.
    void    ExecuteBundle(ID3D12GraphicsCommandList pCommandList);
    ///Changes the currently bound descriptor heaps that are associated with a command list.
    ///Params:
    ///    NumDescriptorHeaps = Type: [in] <b>UINT</b> Number of descriptor heaps to bind.
    ///    ppDescriptorHeaps = Type: [in] <b>ID3D12DescriptorHeap*</b> A pointer to an array of ID3D12DescriptorHeap objects for the heaps
    ///                        to set on the command list. You can only bind descriptor heaps of type
    ///                        [**D3D12_DESCRIPTOR_HEAP_TYPE_CBV_SRV_UAV**](/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setdescriptorheaps)
    ///                        and
    ///                        [**D3D12_DESCRIPTOR_HEAP_TYPE_SAMPLER**](/windows/win32/api/d3d12/nf-d3d12-id3d12graphicscommandlist-setdescriptorheaps).
    ///                        Only one descriptor heap of each type can be set at one time, which means a maximum of 2 heaps (one sampler,
    ///                        one CBV/SRV/UAV) can be set at one time.
    void    SetDescriptorHeaps(uint NumDescriptorHeaps, ID3D12DescriptorHeap* ppDescriptorHeaps);
    ///Sets the layout of the compute root signature.
    ///Params:
    ///    pRootSignature = Type: <b>ID3D12RootSignature*</b> A pointer to the ID3D12RootSignature object.
    void    SetComputeRootSignature(ID3D12RootSignature pRootSignature);
    ///Sets the layout of the graphics root signature.
    ///Params:
    ///    pRootSignature = Type: <b>ID3D12RootSignature*</b> A pointer to the ID3D12RootSignature object.
    void    SetGraphicsRootSignature(ID3D12RootSignature pRootSignature);
    ///Sets a descriptor table into the compute root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    BaseDescriptor = Type: <b>D3D12_GPU_DESCRIPTOR_HANDLE</b> A GPU_descriptor_handle object for the base descriptor to set.
    void    SetComputeRootDescriptorTable(uint RootParameterIndex, D3D12_GPU_DESCRIPTOR_HANDLE BaseDescriptor);
    ///Sets a descriptor table into the graphics root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    BaseDescriptor = Type: <b>D3D12_GPU_DESCRIPTOR_HANDLE</b> A GPU_descriptor_handle object for the base descriptor to set.
    void    SetGraphicsRootDescriptorTable(uint RootParameterIndex, D3D12_GPU_DESCRIPTOR_HANDLE BaseDescriptor);
    ///Sets a constant in the compute root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    SrcData = Type: <b>UINT</b> The source data for the constant to set.
    ///    DestOffsetIn32BitValues = Type: <b>UINT</b> The offset, in 32-bit values, to set the constant in the root signature.
    void    SetComputeRoot32BitConstant(uint RootParameterIndex, uint SrcData, uint DestOffsetIn32BitValues);
    ///Sets a constant in the graphics root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    SrcData = Type: <b>UINT</b> The source data for the constant to set.
    ///    DestOffsetIn32BitValues = Type: <b>UINT</b> The offset, in 32-bit values, to set the constant in the root signature.
    void    SetGraphicsRoot32BitConstant(uint RootParameterIndex, uint SrcData, uint DestOffsetIn32BitValues);
    ///Sets a group of constants in the compute root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    Num32BitValuesToSet = Type: <b>UINT</b> The number of constants to set in the root signature.
    ///    pSrcData = Type: <b>const void*</b> The source data for the group of constants to set.
    ///    DestOffsetIn32BitValues = Type: <b>UINT</b> The offset, in 32-bit values, to set the first constant of the group in the root signature.
    void    SetComputeRoot32BitConstants(uint RootParameterIndex, uint Num32BitValuesToSet, const(void)* pSrcData, 
                                         uint DestOffsetIn32BitValues);
    ///Sets a group of constants in the graphics root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    Num32BitValuesToSet = Type: <b>UINT</b> The number of constants to set in the root signature.
    ///    pSrcData = Type: <b>const void*</b> The source data for the group of constants to set.
    ///    DestOffsetIn32BitValues = Type: <b>UINT</b> The offset, in 32-bit values, to set the first constant of the group in the root signature.
    void    SetGraphicsRoot32BitConstants(uint RootParameterIndex, uint Num32BitValuesToSet, const(void)* pSrcData, 
                                          uint DestOffsetIn32BitValues);
    ///Sets a CPU descriptor handle for the constant buffer in the compute root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    BufferLocation = Type: <b>D3D12_GPU_VIRTUAL_ADDRESS</b> Specifies the D3D12_GPU_VIRTUAL_ADDRESS of the constant buffer.
    void    SetComputeRootConstantBufferView(uint RootParameterIndex, ulong BufferLocation);
    ///Sets a CPU descriptor handle for the constant buffer in the graphics root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    BufferLocation = Type: <b>D3D12_GPU_VIRTUAL_ADDRESS</b> The GPU virtual address of the constant buffer.
    ///                     D3D12_GPU_VIRTUAL_ADDRESS is a typedef'd alias of UINT64.
    void    SetGraphicsRootConstantBufferView(uint RootParameterIndex, ulong BufferLocation);
    ///Sets a CPU descriptor handle for the shader resource in the compute root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    BufferLocation = Type: <b>D3D12_GPU_VIRTUAL_ADDRESS</b> The GPU virtual address of the buffer. D3D12_GPU_VIRTUAL_ADDRESS is a
    ///                     typedef'd alias of UINT64.
    void    SetComputeRootShaderResourceView(uint RootParameterIndex, ulong BufferLocation);
    ///Sets a CPU descriptor handle for the shader resource in the graphics root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    BufferLocation = Type: <b>D3D12_GPU_VIRTUAL_ADDRESS</b> The GPU virtual address of the Buffer. Textures are not supported.
    ///                     D3D12_GPU_VIRTUAL_ADDRESS is a typedef'd alias of UINT64.
    void    SetGraphicsRootShaderResourceView(uint RootParameterIndex, ulong BufferLocation);
    ///Sets a CPU descriptor handle for the unordered-access-view resource in the compute root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    BufferLocation = Type: <b>D3D12_GPU_VIRTUAL_ADDRESS</b> The GPU virtual address of the buffer. D3D12_GPU_VIRTUAL_ADDRESS is a
    ///                     typedef'd alias of UINT64.
    void    SetComputeRootUnorderedAccessView(uint RootParameterIndex, ulong BufferLocation);
    ///Sets a CPU descriptor handle for the unordered-access-view resource in the graphics root signature.
    ///Params:
    ///    RootParameterIndex = Type: <b>UINT</b> The slot number for binding.
    ///    BufferLocation = Type: <b>D3D12_GPU_VIRTUAL_ADDRESS</b> The GPU virtual address of the buffer. D3D12_GPU_VIRTUAL_ADDRESS is a
    ///                     typedef'd alias of UINT64.
    void    SetGraphicsRootUnorderedAccessView(uint RootParameterIndex, ulong BufferLocation);
    ///Sets the view for the index buffer.
    ///Params:
    ///    pView = Type: <b>const D3D12_INDEX_BUFFER_VIEW*</b> The view specifies the index buffer's address, size, and
    ///            DXGI_FORMAT, as a pointer to a D3D12_INDEX_BUFFER_VIEW structure.
    void    IASetIndexBuffer(const(D3D12_INDEX_BUFFER_VIEW)* pView);
    ///Sets a CPU descriptor handle for the vertex buffers.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting vertex buffers.
    ///    NumViews = Type: <b>UINT</b> The number of views in the <i>pViews</i> array.
    ///    pViews = Type: <b>const D3D12_VERTEX_BUFFER_VIEW*</b> Specifies the vertex buffer views in an array of
    ///             D3D12_VERTEX_BUFFER_VIEW structures.
    void    IASetVertexBuffers(uint StartSlot, uint NumViews, const(D3D12_VERTEX_BUFFER_VIEW)* pViews);
    ///Sets the stream output buffer views.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting stream output buffers.
    ///    NumViews = Type: <b>UINT</b> The number of entries in the <i>pViews</i> array.
    ///    pViews = Type: <b>const D3D12_STREAM_OUTPUT_BUFFER_VIEW*</b> Specifies an array of D3D12_STREAM_OUTPUT_BUFFER_VIEW
    ///             structures.
    void    SOSetTargets(uint StartSlot, uint NumViews, const(D3D12_STREAM_OUTPUT_BUFFER_VIEW)* pViews);
    ///Sets CPU descriptor handles for the render targets and depth stencil.
    ///Params:
    ///    NumRenderTargetDescriptors = Type: <b>UINT</b> The number of entries in the <i>pRenderTargetDescriptors</i> array (ranges between 0 and
    ///                                 <b>D3D12_SIMULTANEOUS_RENDER_TARGET_COUNT</b>). If this parameter is nonzero, the number of entries in the
    ///                                 array to which pRenderTargetDescriptors points must equal the number in this parameter.
    ///    pRenderTargetDescriptors = Type: <b>const D3D12_CPU_DESCRIPTOR_HANDLE*</b> Specifies an array of D3D12_CPU_DESCRIPTOR_HANDLE structures
    ///                               that describe the CPU descriptor handles that represents the start of the heap of render target descriptors.
    ///                               If this parameter is NULL and NumRenderTargetDescriptors is 0, no render targets are bound.
    ///    RTsSingleHandleToDescriptorRange = Type: <b>BOOL</b> <b>True</b> means the handle passed in is the pointer to a contiguous range of
    ///                                       <i>NumRenderTargetDescriptors</i> descriptors. This case is useful if the set of descriptors to bind already
    ///                                       happens to be contiguous in memory (so all that’s needed is a handle to the first one). For example, if
    ///                                       <i>NumRenderTargetDescriptors</i> is 3 then the memory layout is taken as follows: <img alt="Memory layout
    ///                                       with parameter set to true" src="./images/oms_true.png"/> In this case the driver dereferences the handle and
    ///                                       then increments the memory being pointed to. <b>False</b> means that the handle is the first of an array of
    ///                                       <i>NumRenderTargetDescriptors</i> handles. The false case allows an application to bind a set of descriptors
    ///                                       from different locations at once. Again assuming that <i>NumRenderTargetDescriptors</i> is 3, the memory
    ///                                       layout is taken as follows: <img alt="Memory layout with parameter set to false"
    ///                                       src="./images/oms_false.png"/> In this case the driver dereferences three handles that are expected to be
    ///                                       adjacent to each other in memory.
    ///    pDepthStencilDescriptor = Type: <b>const D3D12_CPU_DESCRIPTOR_HANDLE*</b> A pointer to a D3D12_CPU_DESCRIPTOR_HANDLE structure that
    ///                              describes the CPU descriptor handle that represents the start of the heap that holds the depth stencil
    ///                              descriptor. If this parameter is NULL, no depth stencil descriptor is bound.
    void    OMSetRenderTargets(uint NumRenderTargetDescriptors, 
                               const(D3D12_CPU_DESCRIPTOR_HANDLE)* pRenderTargetDescriptors, 
                               BOOL RTsSingleHandleToDescriptorRange, 
                               const(D3D12_CPU_DESCRIPTOR_HANDLE)* pDepthStencilDescriptor);
    ///Clears the depth-stencil resource.
    ///Params:
    ///    DepthStencilView = Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> Describes the CPU descriptor handle that represents the start of the
    ///                       heap for the depth stencil to be cleared.
    ///    ClearFlags = Type: <b>D3D12_CLEAR_FLAGS</b> A combination of D3D12_CLEAR_FLAGS values that are combined by using a bitwise
    ///                 OR operation. The resulting value identifies the type of data to clear (depth buffer, stencil buffer, or
    ///                 both).
    ///    Depth = Type: <b>FLOAT</b> A value to clear the depth buffer with. This value will be clamped between 0 and 1.
    ///    Stencil = Type: <b>UINT8</b> A value to clear the stencil buffer with.
    ///    NumRects = Type: <b>UINT</b> The number of rectangles in the array that the <i>pRects</i> parameter specifies.
    ///    pRects = Type: <b>const <b>D3D12_RECT</b>*</b> An array of <b>D3D12_RECT</b> structures for the rectangles in the
    ///             resource view to clear. If <b>NULL</b>, <b>ClearDepthStencilView</b> clears the entire resource view.
    void    ClearDepthStencilView(D3D12_CPU_DESCRIPTOR_HANDLE DepthStencilView, D3D12_CLEAR_FLAGS ClearFlags, 
                                  float Depth, ubyte Stencil, uint NumRects, const(RECT)* pRects);
    ///Sets all the elements in a render target to one value.
    ///Params:
    ///    RenderTargetView = Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> Specifies a D3D12_CPU_DESCRIPTOR_HANDLE structure that describes the
    ///                       CPU descriptor handle that represents the start of the heap for the render target to be cleared.
    ///    ColorRGBA = Type: <b>const FLOAT[4]</b> A 4-component array that represents the color to fill the render target with.
    ///    NumRects = Type: <b>UINT</b> The number of rectangles in the array that the <i>pRects</i> parameter specifies.
    ///    pRects = Type: <b>const D3D12_RECT*</b> An array of <b>D3D12_RECT</b> structures for the rectangles in the resource
    ///             view to clear. If <b>NULL</b>, <b>ClearRenderTargetView</b> clears the entire resource view.
    void    ClearRenderTargetView(D3D12_CPU_DESCRIPTOR_HANDLE RenderTargetView, const(float)* ColorRGBA, 
                                  uint NumRects, const(RECT)* pRects);
    ///Sets all the elements in a unordered-access view (UAV) to the specified integer values.
    ///Params:
    ///    ViewGPUHandleInCurrentHeap = Type: [in] **[D3D12_GPU_DESCRIPTOR_HANDLE](./ns-d3d12-d3d12_gpu_descriptor_handle.md)** A
    ///                                 [D3D12_GPU_DESCRIPTOR_HANDLE](./ns-d3d12-d3d12_gpu_descriptor_handle.md) that references an initialized
    ///                                 descriptor for the unordered-access view (UAV) that is to be cleared. This descriptor must be in a
    ///                                 shader-visible descriptor heap, which must be set on the command list via
    ///                                 [SetDescriptorHeaps](nf-d3d12-id3d12graphicscommandlist-setdescriptorheaps.md).
    ///    ViewCPUHandle = Type: [in] **[D3D12_CPU_DESCRIPTOR_HANDLE](./ns-d3d12-d3d12_cpu_descriptor_handle.md)** A
    ///                    [D3D12_CPU_DESCRIPTOR_HANDLE](./ns-d3d12-d3d12_cpu_descriptor_handle.md) in a non-shader visible descriptor
    ///                    heap that references an initialized descriptor for the unordered-access view (UAV) that is to be cleared. >
    ///                    [!IMPORTANT] > This descriptor must not be in a shader-visible descriptor heap. This is to allow drivers
    ///                    thath implement the clear as fixed-function hardware (rather than via a dispatch) to efficiently read from
    ///                    the descriptor, as shader-visible heaps may be created in **WRITE_BACK** memory (similar to
    ///                    **D3D12_HEAP_TYPE_UPLOAD** heap types), and CPU reads from this type of memory are prohibitively slow.
    ///    pResource = Type: [in] **[ID3D12Resource](./nn-d3d12-id3d12resource.md)\*** A pointer to the
    ///                [ID3D12Resource](./nn-d3d12-id3d12resource.md) interface that represents the unordered-access-view (UAV)
    ///                resource to clear.
    ///    Values = Type: [in] **const UINT[4]** A 4-component array that containing the values to fill the unordered-access-view
    ///             resource with.
    ///    NumRects = Type: [in] **UINT** The number of rectangles in the array that the *pRects* parameter specifies.
    ///    pRects = Type: [in] **const [D3D12_RECT](/windows/win32/direct3d12/d3d12-rect)\*** An array of **D3D12_RECT**
    ///             structures for the rectangles in the resource view to clear. If **NULL**, **ClearUnorderedAccessViewUint**
    ///             clears the entire resource view.
    void    ClearUnorderedAccessViewUint(D3D12_GPU_DESCRIPTOR_HANDLE ViewGPUHandleInCurrentHeap, 
                                         D3D12_CPU_DESCRIPTOR_HANDLE ViewCPUHandle, ID3D12Resource pResource, 
                                         const(uint)* Values, uint NumRects, const(RECT)* pRects);
    ///Sets all of the elements in an unordered-access view (UAV) to the specified float values.
    ///Params:
    ///    ViewGPUHandleInCurrentHeap = Type: [in] **[D3D12_GPU_DESCRIPTOR_HANDLE](./ns-d3d12-d3d12_gpu_descriptor_handle.md)** A
    ///                                 [D3D12_GPU_DESCRIPTOR_HANDLE](./ns-d3d12-d3d12_gpu_descriptor_handle.md) that references an initialized
    ///                                 descriptor for the unordered-access view (UAV) that is to be cleared. This descriptor must be in a
    ///                                 shader-visible descriptor heap, which must be set on the command list via
    ///                                 [SetDescriptorHeaps](nf-d3d12-id3d12graphicscommandlist-setdescriptorheaps.md).
    ///    ViewCPUHandle = Type: [in] **[D3D12_CPU_DESCRIPTOR_HANDLE](./ns-d3d12-d3d12_cpu_descriptor_handle.md)** A
    ///                    [D3D12_CPU_DESCRIPTOR_HANDLE](./ns-d3d12-d3d12_cpu_descriptor_handle.md) in a non-shader visible descriptor
    ///                    heap that references an initialized descriptor for the unordered-access view (UAV) that is to be cleared. >
    ///                    [!IMPORTANT] > This descriptor must not be in a shader-visible descriptor heap. This is to allow drivers
    ///                    thath implement the clear as fixed-function hardware (rather than via a dispatch) to efficiently read from
    ///                    the descriptor, as shader-visible heaps may be created in **WRITE_BACK** memory (similar to
    ///                    **D3D12_HEAP_TYPE_UPLOAD** heap types), and CPU reads from this type of memory are prohibitively slow.
    ///    pResource = Type: [in] **[ID3D12Resource](./nn-d3d12-id3d12resource.md)\*** A pointer to the
    ///                [ID3D12Resource](./nn-d3d12-id3d12resource.md) interface that represents the unordered-access-view (UAV)
    ///                resource to clear.
    ///    Values = Type: [in] **const FLOAT[4]** A 4-component array that containing the values to fill the
    ///             unordered-access-view resource with.
    ///    NumRects = Type: [in] **UINT** The number of rectangles in the array that the *pRects* parameter specifies.
    ///    pRects = Type: [in] **const [D3D12_RECT](/windows/win32/direct3d12/d3d12-rect)\*** An array of **D3D12_RECT**
    ///             structures for the rectangles in the resource view to clear. If **NULL**, **ClearUnorderedAccessViewFloat**
    ///             clears the entire resource view.
    void    ClearUnorderedAccessViewFloat(D3D12_GPU_DESCRIPTOR_HANDLE ViewGPUHandleInCurrentHeap, 
                                          D3D12_CPU_DESCRIPTOR_HANDLE ViewCPUHandle, ID3D12Resource pResource, 
                                          const(float)* Values, uint NumRects, const(RECT)* pRects);
    ///Indicates that the contents of a resource don't need to be preserved. The function may re-initialize resource
    ///metadata in some cases.
    ///Params:
    ///    pResource = Type: [in] <b>ID3D12Resource*</b> A pointer to the ID3D12Resource interface for the resource to discard.
    ///    pRegion = Type: [in, optional] <b>const D3D12_DISCARD_REGION*</b> A pointer to a D3D12_DISCARD_REGION structure that
    ///              describes details for the discard-resource operation.
    void    DiscardResource(ID3D12Resource pResource, const(D3D12_DISCARD_REGION)* pRegion);
    ///Starts a query running.
    ///Params:
    ///    pQueryHeap = Type: <b>ID3D12QueryHeap*</b> Specifies the ID3D12QueryHeap containing the query.
    ///    Type = Type: <b>D3D12_QUERY_TYPE</b> Specifies one member of D3D12_QUERY_TYPE.
    ///    Index = Type: <b>UINT</b> Specifies the index of the query within the query heap.
    void    BeginQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    ///Ends a running query.
    ///Params:
    ///    pQueryHeap = Type: <b>ID3D12QueryHeap*</b> Specifies the ID3D12QueryHeap containing the query.
    ///    Type = Type: <b>D3D12_QUERY_TYPE</b> Specifies one member of D3D12_QUERY_TYPE.
    ///    Index = Type: <b>UINT</b> Specifies the index of the query in the query heap.
    void    EndQuery(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint Index);
    ///Extracts data from a query. <b>ResolveQueryData</b> works with all heap types (default, upload, and readback).
    ///Params:
    ///    pQueryHeap = Type: <b>ID3D12QueryHeap*</b> Specifies the ID3D12QueryHeap containing the queries to resolve.
    ///    Type = Type: <b>D3D12_QUERY_TYPE</b> Specifies the type of query, one member of D3D12_QUERY_TYPE.
    ///    StartIndex = Type: <b>UINT</b> Specifies an index of the first query to resolve.
    ///    NumQueries = Type: <b>UINT</b> Specifies the number of queries to resolve.
    ///    pDestinationBuffer = Type: <b>ID3D12Resource*</b> Specifies an ID3D12Resource destination buffer, which must be in the state
    ///                         D3D12_RESOURCE_STATE_COPY_DEST.
    ///    AlignedDestinationBufferOffset = Type: <b>UINT64</b> Specifies an alignment offset into the destination buffer. Must be a multiple of 8 bytes.
    void    ResolveQueryData(ID3D12QueryHeap pQueryHeap, D3D12_QUERY_TYPE Type, uint StartIndex, uint NumQueries, 
                             ID3D12Resource pDestinationBuffer, ulong AlignedDestinationBufferOffset);
    ///Sets a rendering predicate.
    ///Params:
    ///    pBuffer = Type: <b>ID3D12Resource*</b> The buffer, as an ID3D12Resource, which must be in the
    ///              [**D3D12_RESOURCE_STATE_PREDICATION**](/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_states) or
    ///              [**D3D21_RESOURCE_STATE_INDIRECT_ARGUMENT**](/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_states) state
    ///              (both values are identical, and provided as aliases for clarity), or **NULL** to disable predication.
    ///    AlignedBufferOffset = Type: <b>UINT64</b> The aligned buffer offset, as a UINT64.
    ///    Operation = Type: <b>D3D12_PREDICATION_OP</b> Specifies a D3D12_PREDICATION_OP, such as D3D12_PREDICATION_OP_EQUAL_ZERO
    ///                or D3D12_PREDICATION_OP_NOT_EQUAL_ZERO.
    void    SetPredication(ID3D12Resource pBuffer, ulong AlignedBufferOffset, D3D12_PREDICATION_OP Operation);
    ///Not intended to be called directly. Use the PIX event runtime to insert events into a command list.
    ///Params:
    ///    Metadata = Type: <b>UINT</b> Internal.
    ///    pData = Type: <b>const void*</b> Internal.
    ///    Size = Type: <b>UINT</b> Internal.
    void    SetMarker(uint Metadata, const(void)* pData, uint Size);
    ///Not intended to be called directly. Use the PIX event runtime to insert events into a command list.
    ///Params:
    ///    Metadata = Type: <b>UINT</b> Internal.
    ///    pData = Type: <b>const void*</b> Internal.
    ///    Size = Type: <b>UINT</b> Internal.
    void    BeginEvent(uint Metadata, const(void)* pData, uint Size);
    ///Not intended to be called directly. Use the PIX event runtime to insert events into a command list.
    void    EndEvent();
    ///Apps perform indirect draws/dispatches using the <b>ExecuteIndirect</b> method.
    ///Params:
    ///    pCommandSignature = Type: <b>ID3D12CommandSignature*</b> Specifies a ID3D12CommandSignature. The data referenced by
    ///                        <i>pArgumentBuffer</i> will be interpreted depending on the contents of the command signature. Refer to
    ///                        Indirect Drawing for the APIs that are used to create a command signature.
    ///    MaxCommandCount = Type: <b>UINT</b> There are two ways that command counts can be specified: <ul> <li>If <i>pCountBuffer</i> is
    ///                      not NULL, then <i>MaxCommandCount</i> specifies the maximum number of operations which will be performed. The
    ///                      actual number of operations to be performed are defined by the minimum of this value, and a 32-bit unsigned
    ///                      integer contained in <i>pCountBuffer</i> (at the byte offset specified by <i>CountBufferOffset</i>). </li>
    ///                      <li>If <i>pCountBuffer</i> is NULL, the <i>MaxCommandCount</i> specifies the exact number of operations which
    ///                      will be performed. </li> </ul>
    ///    pArgumentBuffer = Type: <b>ID3D12Resource*</b> Specifies one or more ID3D12Resource objects, containing the command arguments.
    ///    ArgumentBufferOffset = Type: <b>UINT64</b> Specifies an offset into <i>pArgumentBuffer</i> to identify the first command argument.
    ///    pCountBuffer = Type: <b>ID3D12Resource*</b> Specifies a pointer to a ID3D12Resource.
    ///    CountBufferOffset = Type: <b>UINT64</b> Specifies a UINT64 that is the offset into <i>pCountBuffer</i>, identifying the argument
    ///                        count.
    void    ExecuteIndirect(ID3D12CommandSignature pCommandSignature, uint MaxCommandCount, 
                            ID3D12Resource pArgumentBuffer, ulong ArgumentBufferOffset, ID3D12Resource pCountBuffer, 
                            ulong CountBufferOffset);
}

///Encapsulates a list of graphics commands for rendering, extending the interface to support programmable sample
///positions, atomic copies for implementing late-latch techniques, and optional depth-bounds testing. <div
///class="alert"><b>Note</b> This interface, introduced in the Windows 10 Creators Update, is the latest version of the
///ID3D12GraphicsCommandList interface. Applications targetting Windows 10 Creators Update should use this interface
///instead of <b>ID3D12GraphicsCommandList</b>.</div><div> </div>
@GUID("553103FB-1FE7-4557-BB38-946D7D0E7CA7")
interface ID3D12GraphicsCommandList1 : ID3D12GraphicsCommandList
{
    ///Atomically copies a primary data element of type UINT from one resource to another, along with optional dependent
    ///resources. These 'dependent resourses' are so-named because they depend upon the primary data element to locate
    ///them, typically the key element is an address, index, or other handle that refers to one or more the dependent
    ///resources indirectly. This function supports a primary data element of type UINT (32bit). A different version of
    ///this function, AtomicCopyBufferUINT64, supports a primary data element of type UINT64 (64bit).
    ///Params:
    ///    pDstBuffer = Type: <b>ID3D12Resource*</b> SAL: <code>_In_</code> The resource that the UINT primary data element is copied
    ///                 into.
    ///    DstOffset = Type: <b>UINT64</b> An offset into the destination resource buffer that specifies where the primary data
    ///                element is copied into, in bytes. This offset combined with the base address of the resource buffer must
    ///                result in a memory address that's naturally aligned for UINT values.
    ///    pSrcBuffer = Type: <b>ID3D12Resource*</b> SAL: <code>_In_</code> The resource that the UINT primary data element is copied
    ///                 from. This data is typically an address, index, or other handle that shader code can use to locate the
    ///                 most-recent version of latency-sensitive information.
    ///    SrcOffset = Type: <b>UINT64</b> An offset into the source resource buffer that specifies where the primary data element
    ///                is copied from, in bytes. This offset combined with the base address of the resource buffer must result in a
    ///                memory address that's naturally aligned for UINT values.
    ///    Dependencies = Type: <b>UINT</b> The number of dependent resources.
    ///    ppDependentResources = Type: <b>ID3D12Resource*</b> SAL: <code>_In_reads_(Dependencies)</code> An array of resources that contain
    ///                           the dependent elements of the data payload.
    ///    pDependentSubresourceRanges = Type: <b>const D3D12_SUBRESOURCE_RANGE_UINT64*</b> SAL: <code>_In_reads_(Dependencies)</code> An array of
    ///                                  subresource ranges that specify the dependent elements of the data payload. These elements are completely
    ///                                  updated before the primary data element is itself atomically copied. This ensures that the entire operation
    ///                                  is logically atomic; that is, the primary data element never refers to an incomplete data payload.
    void AtomicCopyBufferUINT(ID3D12Resource pDstBuffer, ulong DstOffset, ID3D12Resource pSrcBuffer, 
                              ulong SrcOffset, uint Dependencies, ID3D12Resource* ppDependentResources, 
                              const(D3D12_SUBRESOURCE_RANGE_UINT64)* pDependentSubresourceRanges);
    ///Atomically copies a primary data element of type UINT64 from one resource to another, along with optional
    ///dependent resources. These 'dependent resourses' are so-named because they depend upon the primary data element
    ///to locate them, typically the key element is an address, index, or other handle that refers to one or more the
    ///dependent resources indirectly. This function supports a primary data element of type UINT64 (64bit). A different
    ///version of this function, AtomicCopyBufferUINT, supports a primary data element of type UINT (32bit).
    ///Params:
    ///    pDstBuffer = Type: <b>ID3D12Resource*</b> SAL: <code>_In_</code> The resource that the UINT64 primary data element is
    ///                 copied into.
    ///    DstOffset = Type: <b>UINT64</b> An offset into the destination resource buffer that specifies where the primary data
    ///                element is copied into, in bytes. This offset combined with the base address of the resource buffer must
    ///                result in a memory address that's naturally aligned for UINT64 values.
    ///    pSrcBuffer = Type: <b>ID3D12Resource*</b> SAL: <code>_In_</code> The resource that the UINT64 primary data element is
    ///                 copied from. This data is typically an address, index, or other handle that shader code can use to locate the
    ///                 most-recent version of latency-sensitive information.
    ///    SrcOffset = Type: <b>UINT64</b> An offset into the source resource buffer that specifies where the primary data element
    ///                is copied from, in bytes. This offset combined with the base address of the resource buffer must result in a
    ///                memory address that's naturally aligned for UINT64 values.
    ///    Dependencies = Type: <b>UINT</b> The number of dependent resources.
    ///    ppDependentResources = Type: <b>ID3D12Resource*</b> SAL: <code>_In_reads_(Dependencies)</code> An array of resources that contain
    ///                           the dependent elements of the data payload.
    ///    pDependentSubresourceRanges = Type: <b>const D3D12_SUBRESOURCE_RANGE_UINT64*</b> SAL: <code>_In_reads_(Dependencies)</code> An array of
    ///                                  subresource ranges that specify the dependent elements of the data payload. These elements are completely
    ///                                  updated before the primary data element is itself atomically copied. This ensures that the entire operation
    ///                                  is logically atomic; that is, the primary data element never refers to an incomplete data payload.
    void AtomicCopyBufferUINT64(ID3D12Resource pDstBuffer, ulong DstOffset, ID3D12Resource pSrcBuffer, 
                                ulong SrcOffset, uint Dependencies, ID3D12Resource* ppDependentResources, 
                                const(D3D12_SUBRESOURCE_RANGE_UINT64)* pDependentSubresourceRanges);
    ///This method enables you to change the depth bounds dynamically.
    ///Params:
    ///    Min = Type: <b>FLOAT</b> SAL: <code>_In_</code> Specifies the minimum depth bounds. The default value is 0. NaN
    ///          values silently convert to 0.
    ///    Max = Type: <b>FLOAT</b> SAL: <code>_In_</code> Specifies the maximum depth bounds. The default value is 1. NaN
    ///          values silently convert to 0.
    void OMSetDepthBounds(float Min, float Max);
    ///This method configures the sample positions used by subsequent draw, copy, resolve, and similar operations.
    ///Params:
    ///    NumSamplesPerPixel = Type: <b>UINT</b> SAL: <code>_In_</code> Specifies the number of samples to take, per pixel. This value can
    ///                         be 1, 2, 4, 8, or 16, otherwise the SetSamplePosition call is dropped. The number of samples must match the
    ///                         sample count configured in the PSO at draw time, otherwise the behavior is undefined.
    ///    NumPixels = Type: <b>UINT</b> SAL: <code>_In_</code> Specifies the number of pixels that sample patterns are being
    ///                specified for. This value can be either 1 or 4, otherwise the SetSamplePosition call is dropped. A value of 1
    ///                configures a single sample pattern to be used for each pixel; a value of 4 configures separate sample
    ///                patterns for each pixel in a 2x2 pixel grid which is repeated over the render-target or viewport space,
    ///                aligned to even coordintes. Note that the maximum number of combined samples can't exceed 16, otherwise the
    ///                call is dropped. If NumPixels is set to 4, NumSamplesPerPixel can specify no more than 4 samples.
    ///    pSamplePositions = Type: <b>D3D12_SAMPLE_POSITION*</b> SAL: <code>_In_reads_(NumSamplesPerPixel*NumPixels)</code> Specifies an
    ///                       array of D3D12_SAMPLE_POSITION elements. The size of the array is NumPixels * NumSamplesPerPixel. If
    ///                       NumPixels is set to 4, then the first group of sample positions corresponds to the upper-left pixel in the
    ///                       2x2 grid of pixels; the next group of sample positions corresponds to the upper-right pixel, the next group
    ///                       to the lower-left pixel, and the final group to the lower-right pixel. If centroid interpolation is used
    ///                       during rendering, the order of positions for each pixel determines centroid-sampling prioritiy. That is, the
    ///                       first covered sample in the order specified is chosen as the centroid sample location.
    void SetSamplePositions(uint NumSamplesPerPixel, uint NumPixels, D3D12_SAMPLE_POSITION* pSamplePositions);
    ///Copy a region of a multisampled or compressed resource into a non-multisampled or non-compressed resource.
    ///Params:
    ///    pDstResource = Type: <b>ID3D12Resource*</b> SAL: <code>_In_</code> Destination resource. Must be created with the
    ///                   <b>D3D11_USAGE_DEFAULT</b> flag and must be single-sampled unless its to be resolved from a compressed
    ///                   resource (<b>D3D12_RESOLVE_MODE_DECOMPRESS</b>); in this case it must have the same sample count as the
    ///                   compressed source.
    ///    DstSubresource = Type: <b>UINT</b> SAL: <code>_In_</code> A zero-based index that identifies the destination subresource. Use
    ///                     D3D12CalcSubresource to calculate the subresource index if the parent resource is complex.
    ///    DstX = Type: <b>UINT</b> SAL: <code>_In_</code> The X coordinate of the left-most edge of the destination region.
    ///           The width of the destination region is the same as the width of the source rect.
    ///    DstY = Type: <b>UINT</b> SAL: <code>_In_</code> The Y coordinate of the top-most edge of the destination region. The
    ///           height of the destination region is the same as the height of the source rect.
    ///    pSrcResource = Type: <b>ID3D12Resource*</b> SAL: <code>_In_</code> Source resource. Must be multisampled or compressed.
    ///    SrcSubresource = Type: <b>UINT</b> SAL: <code>_In_</code> A zero-based index that identifies the source subresource.
    ///    pSrcRect = Type: <b>D3D12_RECT*</b> SAL: <code>_In_opt_</code> Specifies the rectangular region of the source resource
    ///               to be resolved. Passing NULL for <i>pSrcRect</i> specifies that the entire subresource is to be resolved.
    ///    Format = Type: <b>DXGI_FORMAT</b> SAL: <code>_In_</code> A DXGI_FORMAT that specifies how the source and destination
    ///             resource formats are consolidated.
    ///    ResolveMode = Type: <b>D3D12_RESOLVE_MODE</b> SAL: <code>_In_</code> Specifies the operation used to resolve the source
    ///                  samples. When using the <b>D3D12_RESOLVE_MODE_DECOMPRESS</b> operation, the sample count can be larger than 1
    ///                  as long as the source and destination have the same sample count, and source and destination may specify the
    ///                  same resource as long as the source rect aligns with the destination X and Y coordinates, in which case
    ///                  decompression occurs in place. When using the <b>D3D12_RESOLVE_MODE_MIN</b>, <b>D3D12_RESOLVE_MODE_MAX</b>,
    ///                  or <b>D3D12_RESOLVE_MODE_AVERAGE</b> operation, the destination must have a sample count of 1.
    void ResolveSubresourceRegion(ID3D12Resource pDstResource, uint DstSubresource, uint DstX, uint DstY, 
                                  ID3D12Resource pSrcResource, uint SrcSubresource, RECT* pSrcRect, 
                                  DXGI_FORMAT Format, D3D12_RESOLVE_MODE ResolveMode);
    ///Set a mask that controls which view instances are enabled for subsequent draws.
    ///Params:
    ///    Mask = Type: <b>UINT</b> A mask that specifies which views are enabled or disabled. If bit <i>i</i> starting from
    ///           the least-significant bit is set, view instance <i>i</i> is enabled.
    void SetViewInstanceMask(uint Mask);
}

///Encapsulates a list of graphics commands for rendering, extending the interface to support writing immediate values
///directly to a buffer. <div class="alert"><b>Note</b> This interface was introduced in the Windows 10 Fall Creators
///Update, and as such is the latest version of the <b>ID3D12GraphicsCommandList</b> interface. Applications targeting
///the Windows 10 Fall Creators Update and later should use this interface instead of ID3D12GraphicsCommandList1 or
///ID3D12GraphicsCommandList.</div><div> </div>
@GUID("38C3E585-FF17-412C-9150-4FC6F9D72A28")
interface ID3D12GraphicsCommandList2 : ID3D12GraphicsCommandList1
{
    ///Writes a number of 32-bit immediate values to the specified buffer locations directly from the command stream.
    ///Params:
    ///    Count = The number of D3D12_WRITEBUFFERIMMEDIATE_PARAMETER structures that are pointed to by <i>pParams</i> and
    ///            <i>pModes</i>.
    ///    pParams = The address of an array containing a number of D3D12_WRITEBUFFERIMMEDIATE_PARAMETER structures equal to
    ///              <i>Count</i>.
    ///    pModes = The address of an array containing a number of D3D12_WRITEBUFFERIMMEDIATE_MODE structures equal to
    ///             <i>Count</i>. The default value is <b>null</b>; passing <b>null</b> causes the system to write all immediate
    ///             values using <b>D3D12_WRITEBUFFERIMMEDIATE_MODE_DEFAULT</b>.
    void WriteBufferImmediate(uint Count, const(D3D12_WRITEBUFFERIMMEDIATE_PARAMETER)* pParams, 
                              const(D3D12_WRITEBUFFERIMMEDIATE_MODE)* pModes);
}

///Provides methods for submitting command lists, synchronizing command list execution, instrumenting the command queue,
///and updating resource tile mappings.
@GUID("0EC870A6-5D7E-4C22-8CFC-5BAAE07616ED")
interface ID3D12CommandQueue : ID3D12Pageable
{
    ///Updates mappings of tile locations in reserved resources to memory locations in a resource heap.
    ///Params:
    ///    pResource = A pointer to the reserved resource.
    ///    NumResourceRegions = The number of reserved resource regions.
    ///    pResourceRegionStartCoordinates = An array of D3D12_TILED_RESOURCE_COORDINATE structures that describe the starting coordinates of the reserved
    ///                                      resource regions. The <i>NumResourceRegions</i> parameter specifies the number of
    ///                                      <b>D3D12_TILED_RESOURCE_COORDINATE</b> structures in the array.
    ///    pResourceRegionSizes = An array of D3D12_TILE_REGION_SIZE structures that describe the sizes of the reserved resource regions. The
    ///                           <i>NumResourceRegions</i> parameter specifies the number of <b>D3D12_TILE_REGION_SIZE</b> structures in the
    ///                           array.
    ///    pHeap = A pointer to the resource heap.
    ///    NumRanges = The number of tile ranges.
    ///    pRangeFlags = A pointer to an array of D3D12_TILE_RANGE_FLAGS values that describes each tile range. The <i>NumRanges</i>
    ///                  parameter specifies the number of values in the array.
    ///    pHeapRangeStartOffsets = An array of offsets into the resource heap. These are 0-based tile offsets, counting in tiles (not bytes).
    ///    pRangeTileCounts = An array of tiles. An array of values that specify the number of tiles in each tile range. The
    ///                       <i>NumRanges</i> parameter specifies the number of values in the array.
    ///    Flags = A combination of D3D12_TILE_MAPPING_FLAGS values that are combined by using a bitwise OR operation.
    void    UpdateTileMappings(ID3D12Resource pResource, uint NumResourceRegions, 
                               const(D3D12_TILED_RESOURCE_COORDINATE)* pResourceRegionStartCoordinates, 
                               const(D3D12_TILE_REGION_SIZE)* pResourceRegionSizes, ID3D12Heap pHeap, uint NumRanges, 
                               const(D3D12_TILE_RANGE_FLAGS)* pRangeFlags, const(uint)* pHeapRangeStartOffsets, 
                               const(uint)* pRangeTileCounts, D3D12_TILE_MAPPING_FLAGS Flags);
    ///Copies mappings from a source reserved resource to a destination reserved resource.
    ///Params:
    ///    pDstResource = A pointer to the destination reserved resource.
    ///    pDstRegionStartCoordinate = A pointer to a D3D12_TILED_RESOURCE_COORDINATE structure that describes the starting coordinates of the
    ///                                destination reserved resource.
    ///    pSrcResource = A pointer to the source reserved resource.
    ///    pSrcRegionStartCoordinate = A pointer to a D3D12_TILED_RESOURCE_COORDINATE structure that describes the starting coordinates of the
    ///                                source reserved resource.
    ///    pRegionSize = A pointer to a D3D12_TILE_REGION_SIZE structure that describes the size of the reserved region.
    ///    Flags = One member of D3D12_TILE_MAPPING_FLAGS.
    void    CopyTileMappings(ID3D12Resource pDstResource, 
                             const(D3D12_TILED_RESOURCE_COORDINATE)* pDstRegionStartCoordinate, 
                             ID3D12Resource pSrcResource, 
                             const(D3D12_TILED_RESOURCE_COORDINATE)* pSrcRegionStartCoordinate, 
                             const(D3D12_TILE_REGION_SIZE)* pRegionSize, D3D12_TILE_MAPPING_FLAGS Flags);
    ///Submits an array of command lists for execution.
    ///Params:
    ///    NumCommandLists = The number of command lists to be executed.
    ///    ppCommandLists = The array of ID3D12CommandList command lists to be executed.
    void    ExecuteCommandLists(uint NumCommandLists, ID3D12CommandList* ppCommandLists);
    ///Not intended to be called directly. Use the PIX event runtime to insert events into a command queue.
    ///Params:
    ///    Metadata = Type: <b>UINT</b> Internal.
    ///    pData = Type: <b>const void*</b> Internal.
    ///    Size = Type: <b>UINT</b> Internal.
    void    SetMarker(uint Metadata, const(void)* pData, uint Size);
    ///Not intended to be called directly. Use the PIX event runtime to insert events into a command queue.
    ///Params:
    ///    Metadata = Type: <b>UINT</b> Internal.
    ///    pData = Type: <b>const void*</b> Internal.
    ///    Size = Type: <b>UINT</b> Internal.
    void    BeginEvent(uint Metadata, const(void)* pData, uint Size);
    ///Not intended to be called directly. Use the PIX event runtime to insert events into a command queue.
    void    EndEvent();
    ///Updates a fence to a specified value.
    ///Params:
    ///    pFence = Type: <b>ID3D12Fence*</b> A pointer to the ID3D12Fence object.
    ///    Value = Type: <b>UINT64</b> The value to set the fence to.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT Signal(ID3D12Fence pFence, ulong Value);
    ///Queues a GPU-side wait, and returns immediately. A GPU-side wait is where the GPU waits until the specified fence
    ///reaches or exceeds the specified value.
    ///Params:
    ///    pFence = Type: <b>ID3D12Fence*</b> A pointer to the ID3D12Fence object.
    ///    Value = Type: <b>UINT64</b> The value that the command queue is waiting for the fence to reach or exceed. So when
    ///            ID3D12Fence::GetCompletedValue is greater than or equal to <i>Value</i>, the wait is terminated.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT Wait(ID3D12Fence pFence, ulong Value);
    ///This method is used to determine the rate at which the GPU timestamp counter increments.
    ///Params:
    ///    pFrequency = Type: <b>UINT64*</b> The GPU timestamp counter frequency (in ticks/second).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetTimestampFrequency(ulong* pFrequency);
    ///This method samples the CPU and GPU timestamp counters at the same moment in time.
    ///Params:
    ///    pGpuTimestamp = Type: <b>UINT64*</b> The value of the GPU timestamp counter.
    ///    pCpuTimestamp = Type: <b>UINT64*</b> The value of the CPU timestamp counter.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetClockCalibration(ulong* pGpuTimestamp, ulong* pCpuTimestamp);
    ///Gets the description of the command queue.
    ///Returns:
    ///    Type: <b>D3D12_COMMAND_QUEUE_DESC</b> The description of the command queue, as a D3D12_COMMAND_QUEUE_DESC
    ///    structure.
    ///    
    D3D12_COMMAND_QUEUE_DESC GetDesc();
}

///Represents a virtual adapter; it is used to create command allocators, command lists, command queues, fences,
///resources, pipeline state objects, heaps, root signatures, samplers, and many resource views. <div
///class="alert"><b>Note</b> This interface was introduced in Windows 10. Applications targetting Windows 10 should use
///this interface instead of later versions. Applications targetting a later version of Windows 10 should use the
///appropriate version of the <b>ID3D12Device</b> interface. The latest version of this interface is ID3D12Device3
///introduced in Windows 10 Fall Creators Update.</div><div> </div>
@GUID("189819F1-1DB6-4B57-BE54-1821339B85F7")
interface ID3D12Device : ID3D12Object
{
    ///Reports the number of physical adapters (nodes) that are associated with this device.
    ///Returns:
    ///    Type: <b>UINT</b> The number of physical adapters (nodes) that this device has.
    ///    
    uint    GetNodeCount();
    ///Creates a command queue.
    ///Params:
    ///    pDesc = Type: <b>const D3D12_COMMAND_QUEUE_DESC*</b> Specifies a D3D12_COMMAND_QUEUE_DESC that describes the command
    ///            queue.
    ///    riid = Type: <b><b>REFIID</b></b> The globally unique identifier (GUID) for the command queue interface. See
    ///           remarks. An input parameter.
    ///    ppCommandQueue = Type: <b><b>void</b>**</b> A pointer to a memory block that receives a pointer to the ID3D12CommandQueue
    ///                     interface for the command queue.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_OUTOFMEMORY</b> if there is insufficient memory to create the
    ///    command queue. See Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT CreateCommandQueue(const(D3D12_COMMAND_QUEUE_DESC)* pDesc, const(GUID)* riid, void** ppCommandQueue);
    ///Creates a command allocator object.
    ///Params:
    ///    type = Type: <b>D3D12_COMMAND_LIST_TYPE</b> A D3D12_COMMAND_LIST_TYPE-typed value that specifies the type of command
    ///           allocator to create. The type of command allocator can be the type that records either direct command lists
    ///           or bundles.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the command allocator interface
    ///           (ID3D12CommandAllocator). The <b>REFIID</b>, or <b>GUID</b>, of the interface to the command allocator can be
    ///           obtained by using the __uuidof() macro. For example, __uuidof(ID3D12CommandAllocator) will get the
    ///           <b>GUID</b> of the interface to a command allocator.
    ///    ppCommandAllocator = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the ID3D12CommandAllocator
    ///                         interface for the command allocator.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_OUTOFMEMORY</b> if there is insufficient memory to create the
    ///    command allocator. See Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT CreateCommandAllocator(D3D12_COMMAND_LIST_TYPE type, const(GUID)* riid, void** ppCommandAllocator);
    ///Creates a graphics pipeline state object.
    ///Params:
    ///    pDesc = Type: <b>const D3D12_GRAPHICS_PIPELINE_STATE_DESC*</b> A pointer to a D3D12_GRAPHICS_PIPELINE_STATE_DESC
    ///            structure that describes graphics pipeline state.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the pipeline state interface
    ///           (ID3D12PipelineState). The <b>REFIID</b>, or <b>GUID</b>, of the interface to the pipeline state can be
    ///           obtained by using the __uuidof() macro. For example, __uuidof(ID3D12PipelineState) will get the <b>GUID</b>
    ///           of the interface to a pipeline state.
    ///    ppPipelineState = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the ID3D12PipelineState interface
    ///                      for the pipeline state object. The pipeline state object is an immutable state object. It contains no
    ///                      methods.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_OUTOFMEMORY</b> if there is insufficient memory to create the
    ///    pipeline state object. See Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT CreateGraphicsPipelineState(const(D3D12_GRAPHICS_PIPELINE_STATE_DESC)* pDesc, const(GUID)* riid, 
                                        void** ppPipelineState);
    ///Creates a compute pipeline state object.
    ///Params:
    ///    pDesc = Type: <b>const D3D12_COMPUTE_PIPELINE_STATE_DESC*</b> A pointer to a D3D12_COMPUTE_PIPELINE_STATE_DESC
    ///            structure that describes compute pipeline state.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the pipeline state interface
    ///           (ID3D12PipelineState). The <b>REFIID</b>, or <b>GUID</b>, of the interface to the pipeline state can be
    ///           obtained by using the __uuidof() macro. For example, __uuidof(ID3D12PipelineState) will get the <b>GUID</b>
    ///           of the interface to a pipeline state.
    ///    ppPipelineState = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the ID3D12PipelineState interface
    ///                      for the pipeline state object. The pipeline state object is an immutable state object. It contains no
    ///                      methods.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_OUTOFMEMORY</b> if there is insufficient memory to create the
    ///    pipeline state object. See Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT CreateComputePipelineState(const(D3D12_COMPUTE_PIPELINE_STATE_DESC)* pDesc, const(GUID)* riid, 
                                       void** ppPipelineState);
    ///Creates a command list.
    ///Params:
    ///    nodeMask = Type: **[UINT](/windows/win32/WinProg/windows-data-types)** For single-GPU operation, set this to zero. If
    ///               there are multiple GPU nodes, then set a bit to identify the node (the device's physical adapter) for which
    ///               to create the command list. Each bit in the mask corresponds to a single node. Only one bit must be set. Also
    ///               see [Multi-adapter systems](/windows/win32/direct3d12/multi-engine).
    ///    type = Type: **[D3D12_COMMAND_LIST_TYPE](./ne-d3d12-d3d12_command_list_type.md)** Specifies the type of command list
    ///           to create.
    ///    pCommandAllocator = Type: **[ID3D12CommandAllocator](./nn-d3d12-id3d12commandallocator.md)\*** A pointer to the command allocator
    ///                        object from which the device creates command lists.
    ///    pInitialState = Type: **[ID3D12PipelineState](./nn-d3d12-id3d12pipelinestate.md)\*** An optional pointer to the pipeline
    ///                    state object that contains the initial pipeline state for the command list. If it is `nulltpr`, then the
    ///                    runtime sets a dummy initial pipeline state, so that drivers don't have to deal with undefined state. The
    ///                    overhead for this is low, particularly for a command list, for which the overall cost of recording the
    ///                    command list likely dwarfs the cost of a single initial state setting. So there's little cost in not setting
    ///                    the initial pipeline state parameter, if doing so is inconvenient. For bundles, on the other hand, it might
    ///                    make more sense to try to set the initial state parameter (since bundles are likely smaller overall, and can
    ///                    be reused frequently).
    ///    riid = Type: **REFIID** A reference to the globally unique identifier (**GUID**) of the command list interface to
    ///           return in *ppCommandList*.
    ///    ppCommandList = Type: **void\*\*** A pointer to a memory block that receives a pointer to the
    ///                    [ID3D12CommandList](./nn-d3d12-id3d12commandlist.md) or
    ///                    [ID3D12GraphicsCommandList](./nn-d3d12-id3d12graphicscommandlist.md) interface for the command list.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_OUTOFMEMORY|There is
    ///    insufficient memory to create the command list.| See [Direct3D 12 return
    ///    codes](/windows/win32/direct3d12/d3d12-graphics-reference-returnvalues) for other possible return values.
    ///    
    HRESULT CreateCommandList(uint nodeMask, D3D12_COMMAND_LIST_TYPE type, 
                              ID3D12CommandAllocator pCommandAllocator, ID3D12PipelineState pInitialState, 
                              const(GUID)* riid, void** ppCommandList);
    ///Gets information about the features that are supported by the current graphics driver.
    ///Params:
    ///    Feature = Type: <b>D3D12_FEATURE</b> A constant from the D3D12_FEATURE enumeration describing the feature(s) that you
    ///              want to query for support.
    ///    pFeatureSupportData = Type: <b>void*</b> A pointer to a data structure that corresponds to the value of the <i>Feature</i>
    ///                          parameter. To determine the corresponding data structure for each constant, see D3D12_FEATURE.
    ///    FeatureSupportDataSize = Type: <b>UINT</b> The size of the structure pointed to by the <i>pFeatureSupportData</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful. Returns <b>E_INVALIDARG</b> if an unsupported data
    ///    type is passed to the <i>pFeatureSupportData</i> parameter or if a size mismatch is detected for the
    ///    <i>FeatureSupportDataSize</i> parameter.
    ///    
    HRESULT CheckFeatureSupport(D3D12_FEATURE Feature, void* pFeatureSupportData, uint FeatureSupportDataSize);
    ///Creates a descriptor heap object.
    ///Params:
    ///    pDescriptorHeapDesc = Type: <b>const D3D12_DESCRIPTOR_HEAP_DESC*</b> A pointer to a D3D12_DESCRIPTOR_HEAP_DESC structure that
    ///                          describes the heap.
    ///    riid = Type: <b><b>REFIID</b></b> The globally unique identifier (<b>GUID</b>) for the descriptor heap interface.
    ///           See Remarks. An input parameter.
    ///    ppvHeap = Type: <b><b>void</b>**</b> A pointer to a memory block that receives a pointer to the descriptor heap.
    ///              <i>ppvHeap</i> can be NULL, to enable capability testing. When <i>ppvHeap</i> is NULL, no object will be
    ///              created and S_FALSE will be returned when <i>pDescriptorHeapDesc</i> is valid.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_OUTOFMEMORY</b> if there is insufficient memory to create the
    ///    descriptor heap object. See Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT CreateDescriptorHeap(const(D3D12_DESCRIPTOR_HEAP_DESC)* pDescriptorHeapDesc, const(GUID)* riid, 
                                 void** ppvHeap);
    ///Gets the size of the handle increment for the given type of descriptor heap. This value is typically used to
    ///increment a handle into a descriptor array by the correct amount.
    ///Params:
    ///    DescriptorHeapType = The D3D12_DESCRIPTOR_HEAP_TYPE-typed value that specifies the type of descriptor heap to get the size of the
    ///                         handle increment for.
    ///Returns:
    ///    Returns the size of the handle increment for the given type of descriptor heap, including any necessary
    ///    padding.
    ///    
    uint    GetDescriptorHandleIncrementSize(D3D12_DESCRIPTOR_HEAP_TYPE DescriptorHeapType);
    ///Creates a root signature layout.
    ///Params:
    ///    nodeMask = Type: <b>UINT</b> For single GPU operation, set this to zero. If there are multiple GPU nodes, set bits to
    ///               identify the nodes (the device's physical adapters) to which the root signature is to apply. Each bit in the
    ///               mask corresponds to a single node. Refer to Multi-adapter systems.
    ///    pBlobWithRootSignature = Type: <b>const void*</b> A pointer to the source data for the serialized signature.
    ///    blobLengthInBytes = Type: <b>SIZE_T</b> The size, in bytes, of the block of memory that <i>pBlobWithRootSignature</i> points to.
    ///    riid = Type: <b><b>REFIID</b></b> The globally unique identifier (<b>GUID</b>) for the root signature interface. See
    ///           Remarks. An input parameter.
    ///    ppvRootSignature = Type: <b><b>void</b>**</b> A pointer to a memory block that receives a pointer to the root signature.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; otherwise, returns one of the Direct3D 12 Return
    ///    Codes. This method returns <b>E_INVALIDARG</b> if the blob that <i>pBlobWithRootSignature</i> points to is
    ///    invalid.
    ///    
    HRESULT CreateRootSignature(uint nodeMask, const(void)* pBlobWithRootSignature, size_t blobLengthInBytes, 
                                const(GUID)* riid, void** ppvRootSignature);
    ///Creates a constant-buffer view for accessing resource data.
    ///Params:
    ///    pDesc = Type: <b>const D3D12_CONSTANT_BUFFER_VIEW_DESC*</b> A pointer to a D3D12_CONSTANT_BUFFER_VIEW_DESC structure
    ///            that describes the constant-buffer view.
    ///    DestDescriptor = Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> Describes the CPU descriptor handle that represents the start of the
    ///                     heap that holds the constant-buffer view.
    void    CreateConstantBufferView(const(D3D12_CONSTANT_BUFFER_VIEW_DESC)* pDesc, 
                                     D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    ///Creates a shader-resource view for accessing data in a resource.
    ///Params:
    ///    pResource = Type: <b>ID3D12Resource*</b> A pointer to the ID3D12Resource object that represents the shader resource. At
    ///                least one of <i>pResource</i> or <i>pDesc</i> must be provided. A null <i>pResource</i> is used to initialize
    ///                a null descriptor, which guarantees D3D11-like null binding behavior (reading 0s, writes are discarded), but
    ///                must have a valid <i>pDesc</i> in order to determine the descriptor type.
    ///    pDesc = Type: <b>const D3D12_SHADER_RESOURCE_VIEW_DESC*</b> A pointer to a D3D12_SHADER_RESOURCE_VIEW_DESC structure
    ///            that describes the shader-resource view. A null <i>pDesc</i> is used to initialize a default descriptor, if
    ///            possible. This behavior is identical to the D3D11 null descriptor behavior, where defaults are filled in.
    ///            This behavior inherits the resource format and dimension (if not typeless) and for buffers SRVs target a full
    ///            buffer and are typed (not raw or structured), and for textures SRVs target a full texture, all mips and all
    ///            array slices. Not all resources support null descriptor initialization.
    ///    DestDescriptor = Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> Describes the CPU descriptor handle that represents the
    ///                     shader-resource view. This handle can be created in a shader-visible or non-shader-visible descriptor heap.
    void    CreateShaderResourceView(ID3D12Resource pResource, const(D3D12_SHADER_RESOURCE_VIEW_DESC)* pDesc, 
                                     D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    ///Creates a view for unordered accessing.
    ///Params:
    ///    pResource = Type: <b>ID3D12Resource*</b> A pointer to the ID3D12Resource object that represents the unordered access. At
    ///                least one of <i>pResource</i> or <i>pDesc</i> must be provided. A null <i>pResource</i> is used to initialize
    ///                a null descriptor, which guarantees D3D11-like null binding behavior (reading 0s, writes are discarded), but
    ///                must have a valid <i>pDesc</i> in order to determine the descriptor type.
    ///    pCounterResource = Type: <b>ID3D12Resource*</b> The ID3D12Resource for the counter (if any) associated with the UAV. If
    ///                       <i>pCounterResource</i> is not specified, the <b>CounterOffsetInBytes</b> member of the D3D12_BUFFER_UAV
    ///                       structure must be 0. If <i>pCounterResource</i> is specified, then there is a counter associated with the
    ///                       UAV, and the runtime performs validation of the following requirements: <ul> <li>The
    ///                       <b>StructureByteStride</b> member of the D3D12_BUFFER_UAV structure must be greater than 0. </li> <li>The
    ///                       format must be DXGI_FORMAT_UNKNOWN. </li> <li>The D3D12_BUFFER_UAV_FLAG_RAW flag (a D3D12_BUFFER_UAV_FLAGS
    ///                       enumeration constant) must not be set. </li> <li>Both of the resources (<i>pResource</i> and
    ///                       <i>pCounterResource</i>) must be buffers. </li> <li>The <b>CounterOffsetInBytes</b> member of the
    ///                       D3D12_BUFFER_UAV structure must be a multiple of 4 bytes, and must be within the range of the counter
    ///                       resource. </li> <li><i>pResource</i> cannot be NULL </li> <li><i>pDesc</i> cannot be NULL. </li> </ul>
    ///    pDesc = Type: <b>const D3D12_UNORDERED_ACCESS_VIEW_DESC*</b> A pointer to a D3D12_UNORDERED_ACCESS_VIEW_DESC
    ///            structure that describes the unordered-access view. A null <i>pDesc</i> is used to initialize a default
    ///            descriptor, if possible. This behavior is identical to the D3D11 null descriptor behavior, where defaults are
    ///            filled in. This behavior inherits the resource format and dimension (if not typeless) and for buffers UAVs
    ///            target a full buffer and are typed, and for textures UAVs target the first mip and all array slices. Not all
    ///            resources support null descriptor initialization.
    ///    DestDescriptor = Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> Describes the CPU descriptor handle that represents the start of the
    ///                     heap that holds the unordered-access view.
    void    CreateUnorderedAccessView(ID3D12Resource pResource, ID3D12Resource pCounterResource, 
                                      const(D3D12_UNORDERED_ACCESS_VIEW_DESC)* pDesc, 
                                      D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    ///Creates a render-target view for accessing resource data.
    ///Params:
    ///    pResource = Type: <b>ID3D12Resource*</b> A pointer to the ID3D12Resource object that represents the render target. At
    ///                least one of <i>pResource</i> or <i>pDesc</i> must be provided. A null <i>pResource</i> is used to initialize
    ///                a null descriptor, which guarantees D3D11-like null binding behavior (reading 0s, writes are discarded), but
    ///                must have a valid <i>pDesc</i> in order to determine the descriptor type.
    ///    pDesc = Type: <b>const D3D12_RENDER_TARGET_VIEW_DESC*</b> A pointer to a D3D12_RENDER_TARGET_VIEW_DESC structure that
    ///            describes the render-target view. A null <i>pDesc</i> is used to initialize a default descriptor, if
    ///            possible. This behavior is identical to the D3D11 null descriptor behavior, where defaults are filled in.
    ///            This behavior inherits the resource format and dimension (if not typeless) and RTVs target the first mip and
    ///            all array slices. Not all resources support null descriptor initialization.
    ///    DestDescriptor = Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> Describes the CPU descriptor handle that represents the destination
    ///                     where the newly-created render target view will reside.
    void    CreateRenderTargetView(ID3D12Resource pResource, const(D3D12_RENDER_TARGET_VIEW_DESC)* pDesc, 
                                   D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    ///Creates a depth-stencil view for accessing resource data.
    ///Params:
    ///    pResource = Type: <b>ID3D12Resource*</b> A pointer to the ID3D12Resource object that represents the depth stencil. At
    ///                least one of <i>pResource</i> or <i>pDesc</i> must be provided. A null <i>pResource</i> is used to initialize
    ///                a null descriptor, which guarantees D3D11-like null binding behavior (reading 0s, writes are discarded), but
    ///                must have a valid <i>pDesc</i> in order to determine the descriptor type.
    ///    pDesc = Type: <b>const D3D12_DEPTH_STENCIL_VIEW_DESC*</b> A pointer to a D3D12_DEPTH_STENCIL_VIEW_DESC structure that
    ///            describes the depth-stencil view. A null <i>pDesc</i> is used to initialize a default descriptor, if
    ///            possible. This behavior is identical to the D3D11 null descriptor behavior, where defaults are filled in.
    ///            This behavior inherits the resource format and dimension (if not typeless) and DSVs target the first mip and
    ///            all array slices. Not all resources support null descriptor initialization.
    ///    DestDescriptor = Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> Describes the CPU descriptor handle that represents the start of the
    ///                     heap that holds the depth-stencil view.
    void    CreateDepthStencilView(ID3D12Resource pResource, const(D3D12_DEPTH_STENCIL_VIEW_DESC)* pDesc, 
                                   D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    ///Create a sampler object that encapsulates sampling information for a texture.
    ///Params:
    ///    pDesc = Type: <b>const D3D12_SAMPLER_DESC*</b> A pointer to a D3D12_SAMPLER_DESC structure that describes the
    ///            sampler.
    ///    DestDescriptor = Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> Describes the CPU descriptor handle that represents the start of the
    ///                     heap that holds the sampler.
    void    CreateSampler(const(D3D12_SAMPLER_DESC)* pDesc, D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    ///Copies descriptors from a source to a destination.
    ///Params:
    ///    NumDestDescriptorRanges = Type: <b>UINT</b> The number of destination descriptor ranges to copy to.
    ///    pDestDescriptorRangeStarts = Type: <b>const D3D12_CPU_DESCRIPTOR_HANDLE*</b> An array of <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> objects to
    ///                                 copy to. All the destination and source descriptors must be in heaps of the same
    ///                                 [D3D12_DESCRIPTOR_HEAP_TYPE](/windows/win32/api/d3d12/ne-d3d12-d3d12_descriptor_heap_type).
    ///    pDestDescriptorRangeSizes = Type: <b>const UINT*</b> An array of destination descriptor range sizes to copy to.
    ///    NumSrcDescriptorRanges = Type: <b>UINT</b> The number of source descriptor ranges to copy from.
    ///    pSrcDescriptorRangeStarts = Type: <b>const D3D12_CPU_DESCRIPTOR_HANDLE*</b> An array of <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> objects to
    ///                                copy from. > [!IMPORTANT] > All elements in the *pSrcDescriptorRangeStarts* parameter must be in a non
    ///                                shader-visible descriptor heap. This is because shader-visible descriptor heaps may be created in
    ///                                **WRITE_COMBINE** memory or GPU local memory, which is prohibitively slow to read from. If your application
    ///                                manages descriptor heaps via copying the descriptors required for a given pass or frame from local "storage"
    ///                                descriptor heaps to the GPU-bound descriptor heap, use shader-opaque heaps for the storage heaps and copy
    ///                                into the GPU-visible heap as required.
    ///    pSrcDescriptorRangeSizes = Type: <b>const UINT*</b> An array of source descriptor range sizes to copy from.
    ///    DescriptorHeapsType = Type: <b>D3D12_DESCRIPTOR_HEAP_TYPE</b> The D3D12_DESCRIPTOR_HEAP_TYPE-typed value that specifies the type of
    ///                          descriptor heap to copy with. This is required as different descriptor types may have different sizes. Both
    ///                          the source and destination descriptor heaps must have the same type, else the debug layer will emit an error.
    void    CopyDescriptors(uint NumDestDescriptorRanges, 
                            const(D3D12_CPU_DESCRIPTOR_HANDLE)* pDestDescriptorRangeStarts, 
                            const(uint)* pDestDescriptorRangeSizes, uint NumSrcDescriptorRanges, 
                            const(D3D12_CPU_DESCRIPTOR_HANDLE)* pSrcDescriptorRangeStarts, 
                            const(uint)* pSrcDescriptorRangeSizes, D3D12_DESCRIPTOR_HEAP_TYPE DescriptorHeapsType);
    ///Copies descriptors from a source to a destination.
    ///Params:
    ///    NumDescriptors = Type: <b>UINT</b> The number of descriptors to copy.
    ///    DestDescriptorRangeStart = Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> A <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> that describes the destination
    ///                               descriptors to start to copy to. The destination and source descriptors must be in heaps of the same
    ///                               [D3D12_DESCRIPTOR_HEAP_TYPE](/windows/win32/api/d3d12/ne-d3d12-d3d12_descriptor_heap_type).
    ///    SrcDescriptorRangeStart = Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> A <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> that describes the source
    ///                              descriptors to start to copy from. > [!IMPORTANT] > The *SrcDescriptorRangeStart* parameter must be in a non
    ///                              shader-visible descriptor heap. This is because shader-visible descriptor heaps may be created in
    ///                              **WRITE_COMBINE** memory or GPU local memory, which is prohibitively slow to read from. If your application
    ///                              manages descriptor heaps via copying the descriptors required for a given pass or frame from local "storage"
    ///                              descriptor heaps to the GPU-bound descriptor heap, then use shader-opaque heaps for the storage heaps and
    ///                              copy into the GPU-visible heap as required.
    ///    DescriptorHeapsType = Type: <b>D3D12_DESCRIPTOR_HEAP_TYPE</b> The D3D12_DESCRIPTOR_HEAP_TYPE-typed value that specifies the type of
    ///                          descriptor heap to copy with. This is required as different descriptor types may have different sizes. Both
    ///                          the source and destination descriptor heaps must have the same type, else the debug layer will emit an error.
    void    CopyDescriptorsSimple(uint NumDescriptors, D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptorRangeStart, 
                                  D3D12_CPU_DESCRIPTOR_HANDLE SrcDescriptorRangeStart, 
                                  D3D12_DESCRIPTOR_HEAP_TYPE DescriptorHeapsType);
    ///Gets the size and alignment of memory required for a collection of resources on this adapter.
    ///Params:
    ///    visibleMask = Type: **[UINT](/windows/win32/WinProg/windows-data-types)** For single-GPU operation, set this to zero. If
    ///                  there are multiple GPU nodes, then set bits to identify the nodes (the device's physical adapters). Each bit
    ///                  in the mask corresponds to a single node. Also see [Multi-adapter
    ///                  systems](/windows/win32/direct3d12/multi-engine).
    ///    numResourceDescs = Type: **[UINT](/windows/win32/WinProg/windows-data-types)** The number of resource descriptors in the
    ///                       *pResourceDescs* array.
    ///    pResourceDescs = Type: **const [D3D12_RESOURCE_DESC](./ns-d3d12-d3d12_resource_desc.md)\*** An array of
    ///                     **D3D12_RESOURCE_DESC** structures that described the resources to get info about.
    ///Returns:
    ///    Type: **[D3D12_RESOURCE_ALLOCATION_INFO](./ns-d3d12-d3d12_resource_allocation_info.md)** A
    ///    [D3D12_RESOURCE_ALLOCATION_INFO](./ns-d3d12-d3d12_resource_allocation_info.md) structure that provides info
    ///    about video memory allocated for the specified array of resources.
    ///    
    D3D12_RESOURCE_ALLOCATION_INFO GetResourceAllocationInfo(uint visibleMask, uint numResourceDescs, 
                                                             const(D3D12_RESOURCE_DESC)* pResourceDescs);
    ///Divulges the equivalent custom heap properties that are used for non-custom heap types, based on the adapter's
    ///architectural properties.
    ///Params:
    ///    nodeMask = Type: <b>UINT</b> For single-GPU operation, set this to zero. If there are multiple GPU nodes, set a bit to
    ///               identify the node (the device's physical adapter). Each bit in the mask corresponds to a single node. Only 1
    ///               bit must be set. See Multi-adapter systems.
    ///    heapType = Type: <b>D3D12_HEAP_TYPE</b> A D3D12_HEAP_TYPE-typed value that specifies the heap to get properties for.
    ///               D3D12_HEAP_TYPE_CUSTOM is not supported as a parameter value.
    ///Returns:
    ///    Type: <b>D3D12_HEAP_PROPERTIES</b> Returns a D3D12_HEAP_PROPERTIES structure that provides properties for the
    ///    specified heap. The <b>Type</b> member of the returned D3D12_HEAP_PROPERTIES is always
    ///    D3D12_HEAP_TYPE_CUSTOM. When D3D12_FEATURE_DATA_ARCHITECTURE::UMA is FALSE, the returned
    ///    D3D12_HEAP_PROPERTIES members convert as follows: <table> <tr> <th>Heap Type</th> <th>How the returned
    ///    D3D12_HEAP_PROPERTIES members convert</th> </tr> <tr> <td>D3D12_HEAP_TYPE_UPLOAD</td>
    ///    <td><b>CPUPageProperty</b> = WRITE_COMBINE, <b>MemoryPoolPreference</b> = L0. </td> </tr> <tr>
    ///    <td>D3D12_HEAP_TYPE_DEFAULT</td> <td><b>CPUPageProperty</b> = NOT_AVAILABLE, <b>MemoryPoolPreference</b> =
    ///    L1. </td> </tr> <tr> <td>D3D12_HEAP_TYPE_READBACK</td> <td><b>CPUPageProperty</b> = WRITE_BACK,
    ///    <b>MemoryPoolPreference</b> = L0. </td> </tr> </table> When D3D12_FEATURE_DATA_ARCHITECTURE::UMA is TRUE and
    ///    D3D12_FEATURE_DATA_ARCHITECTURE::CacheCoherentUMA is FALSE, the returned D3D12_HEAP_PROPERTIES members
    ///    convert as follows: <table> <tr> <th>Heap Type</th> <th>How the returned D3D12_HEAP_PROPERTIES members
    ///    convert</th> </tr> <tr> <td>D3D12_HEAP_TYPE_UPLOAD</td> <td><b>CPUPageProperty</b> = WRITE_COMBINE,
    ///    <b>MemoryPoolPreference</b> = L0. </td> </tr> <tr> <td>D3D12_HEAP_TYPE_DEFAULT</td>
    ///    <td><b>CPUPageProperty</b> = NOT_AVAILABLE, <b>MemoryPoolPreference</b> = L0. </td> </tr> <tr>
    ///    <td>D3D12_HEAP_TYPE_READBACK</td> <td><b>CPUPageProperty</b> = WRITE_BACK, <b>MemoryPoolPreference</b> = L0.
    ///    </td> </tr> </table> When D3D12_FEATURE_DATA_ARCHITECTURE::UMA is TRUE and
    ///    D3D12_FEATURE_DATA_ARCHITECTURE::CacheCoherentUMA is TRUE, the returned D3D12_HEAP_PROPERTIES members convert
    ///    as follows: <table> <tr> <th>Heap Type</th> <th>How the returned D3D12_HEAP_PROPERTIES members convert</th>
    ///    </tr> <tr> <td>D3D12_HEAP_TYPE_UPLOAD</td> <td><b>CPUPageProperty</b> = WRITE_BACK,
    ///    <b>MemoryPoolPreference</b> = L0. </td> </tr> <tr> <td>D3D12_HEAP_TYPE_DEFAULT</td>
    ///    <td><b>CPUPageProperty</b> = NOT_AVAILABLE, <b>MemoryPoolPreference</b> = L0. </td> </tr> <tr>
    ///    <td>D3D12_HEAP_TYPE_READBACK</td> <td><b>CPUPageProperty</b> = WRITE_BACK, <b>MemoryPoolPreference</b> = L0.
    ///    </td> </tr> </table>
    ///    
    D3D12_HEAP_PROPERTIES GetCustomHeapProperties(uint nodeMask, D3D12_HEAP_TYPE heapType);
    ///Creates both a resource and an implicit heap, such that the heap is big enough to contain the entire resource,
    ///and the resource is mapped to the heap.
    ///Params:
    ///    pHeapProperties = Type: **const [D3D12_HEAP_PROPERTIES](./ns-d3d12-d3d12_heap_properties.md)\*** A pointer to a
    ///                      **D3D12_HEAP_PROPERTIES** structure that provides properties for the resource's heap.
    ///    HeapFlags = Type: **[D3D12_HEAP_FLAGS](./ne-d3d12-d3d12_heap_flags.md)** Heap options, as a bitwise-OR'd combination of
    ///                **D3D12_HEAP_FLAGS** enumeration constants.
    ///    pDesc = Type: **const [D3D12_RESOURCE_DESC](./ns-d3d12-d3d12_resource_desc.md)\*** A pointer to a
    ///            **D3D12_RESOURCE_DESC** structure that describes the resource.
    ///    InitialResourceState = Type: **[D3D12_RESOURCE_STATES](./ne-d3d12-d3d12_resource_states.md)** The initial state of the resource, as
    ///                           a bitwise-OR'd combination of **D3D12_RESOURCE_STATES** enumeration constants. When you create a resource
    ///                           together with a [D3D12_HEAP_TYPE_UPLOAD](./ne-d3d12-d3d12_heap_type.md) heap, you must set
    ///                           *InitialResourceState* to [D3D12_RESOURCE_STATE_GENERIC_READ](./ne-d3d12-d3d12_resource_states.md). When you
    ///                           create a resource together with a [D3D12_HEAP_TYPE_READBACK](./ne-d3d12-d3d12_heap_type.md) heap, you must
    ///                           set *InitialResourceState* to [D3D12_RESOURCE_STATE_COPY_DEST](./ne-d3d12-d3d12_resource_states.md).
    ///    pOptimizedClearValue = Type: **const [D3D12_CLEAR_VALUE](./ns-d3d12-d3d12_clear_value.md)\*** Specifies a **D3D12_CLEAR_VALUE**
    ///                           structure that describes the default value for a clear color. *pOptimizedClearValue* specifies a value for
    ///                           which clear operations are most optimal. When the created resource is a texture with either the
    ///                           [D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET](./ne-d3d12-d3d12_resource_flags.md) or
    ///                           **D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL** flags, you should choose the value with which the clear operation
    ///                           will most commonly be called. You can call the clear operation with other values, but those operations won't
    ///                           be as efficient as when the value matches the one passed in to resource creation. When you use
    ///                           [D3D12_RESOURCE_DIMENSION_BUFFER](./ne-d3d12-d3d12_resource_dimension.md), you must set
    ///                           *pOptimizedClearValue* to `nullptr`.
    ///    riidResource = Type: **REFIID** A reference to the globally unique identifier (**GUID**) of the resource interface to return
    ///                   in *ppvResource*. While *riidResource* is most commonly the **GUID** of
    ///                   [ID3D12Resource](./nn-d3d12-id3d12resource.md), it may be the **GUID** of any interface. If the resource
    ///                   object doesn't support the interface for this **GUID**, then creation fails with **E_NOINTERFACE**.
    ///    ppvResource = Type: **void\*\*** An optional pointer to a memory block that receives the requested interface pointer to the
    ///                  created resource object. *ppvResource* can be `nullptr`, to enable capability testing. When *ppvResource* is
    ///                  `nullptr`, no object is created, and **S_FALSE** is returned when *pDesc* is valid.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_OUTOFMEMORY|There is
    ///    insufficient memory to create the resource.| See [Direct3D 12 return
    ///    codes](/windows/win32/direct3d12/d3d12-graphics-reference-returnvalues) for other possible return values.
    ///    
    HRESULT CreateCommittedResource(const(D3D12_HEAP_PROPERTIES)* pHeapProperties, D3D12_HEAP_FLAGS HeapFlags, 
                                    const(D3D12_RESOURCE_DESC)* pDesc, D3D12_RESOURCE_STATES InitialResourceState, 
                                    const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, const(GUID)* riidResource, 
                                    void** ppvResource);
    ///Creates a heap that can be used with placed resources and reserved resources.
    ///Params:
    ///    pDesc = Type: **const [D3D12_HEAP_DESC](./ns-d3d12-d3d12_heap_desc.md)\*** A pointer to a constant
    ///            **D3D12_HEAP_DESC** structure that describes the heap.
    ///    riid = Type: **REFIID** A reference to the globally unique identifier (**GUID**) of the heap interface to return in
    ///           *ppvHeap*. While *riidResource* is most commonly the **GUID** of [ID3D12Heap](./nn-d3d12-id3d12heap.md), it
    ///           may be the **GUID** of any interface. If the resource object doesn't support the interface for this **GUID**,
    ///           then creation fails with **E_NOINTERFACE**.
    ///    ppvHeap = Type: **void\*\*** An optional pointer to a memory block that receives the requested interface pointer to the
    ///              created heap object. *ppvHeap* can be `nullptr`, to enable capability testing. When *ppvHeap* is `nullptr`,
    ///              no object is created, and **S_FALSE** is returned when *pDesc* is valid.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_OUTOFMEMORY|There is
    ///    insufficient memory to create the heap.| See [Direct3D 12 return
    ///    codes](/windows/win32/direct3d12/d3d12-graphics-reference-returnvalues) for other possible return values.
    ///    
    HRESULT CreateHeap(const(D3D12_HEAP_DESC)* pDesc, const(GUID)* riid, void** ppvHeap);
    ///Creates a resource that is placed in a specific heap. Placed resources are the lightest weight resource objects
    ///available, and are the fastest to create and destroy. Your application can re-use video memory by overlapping
    ///multiple Direct3D placed and reserved resources on heap regions. The simple memory re-use model (described in
    ///[Remarks](#remarks)) exists to clarify which overlapping resource is valid at any given time. To maximize
    ///graphics tool support, with the simple model data-inheritance isn't supported; and finer-grained tile and
    ///sub-resource invalidation isn't supported. Only full overlapping resource invalidation occurs.
    ///Params:
    ///    pHeap = Type: [in] **ID3D12Heap*** A pointer to the **ID3D12Heap** interface that represents the heap in which the
    ///            resource is placed.
    ///    HeapOffset = Type: **UINT64** The offset, in bytes, to the resource. The *HeapOffset* must be a multiple of the resource's
    ///                 alignment, and *HeapOffset* plus the resource size must be smaller than or equal to the heap size.
    ///                 **GetResourceAllocationInfo** must be used to understand the sizes of texture resources.
    ///    pDesc = Type: [in] **const D3D12_RESOURCE_DESC*** A pointer to a **D3D12_RESOURCE_DESC** structure that describes the
    ///            resource.
    ///    InitialState = Type: **D3D12_RESOURCE_STATES** The initial state of the resource, as a bitwise-OR'd combination of
    ///                   **D3D12_RESOURCE_STATES** enumeration constants. When a resource is created together with a
    ///                   **D3D12_HEAP_TYPE_UPLOAD** heap, *InitialState* must be **D3D12_RESOURCE_STATE_GENERIC_READ**. When a
    ///                   resource is created together with a **D3D12_HEAP_TYPE_READBACK** heap, *InitialState* must be
    ///                   **D3D12_RESOURCE_STATE_COPY_DEST**.
    ///    pOptimizedClearValue = Type: [in, optional] **const D3D12_CLEAR_VALUE*** Specifies a **D3D12_CLEAR_VALUE** that describes the
    ///                           default value for a clear color. *pOptimizedClearValue* specifies a value for which clear operations are most
    ///                           optimal. When the created resource is a texture with either the **D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET**
    ///                           or **D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL** flags, your application should choose the value that the clear
    ///                           operation will most commonly be called with. Clear operations can be called with other values, but those
    ///                           operations will not be as efficient as when the value matches the one passed into resource creation.
    ///                           *pOptimizedClearValue* must be NULL when used with **D3D12_RESOURCE_DIMENSION_BUFFER**.
    ///    riid = Type: **REFIID** The globally unique identifier (**GUID**) for the resource interface. This is an input
    ///           parameter. The **REFIID**, or **GUID**, of the interface to the resource can be obtained by using the
    ///           `__uuidof` macro. For example, `__uuidof(ID3D12Resource)` gets the **GUID** of the interface to a resource.
    ///           Although **riid** is, most commonly, the GUID for **ID3D12Resource**, it may be any **GUID** for any
    ///           interface. If the resource object doesn't support the interface for this **GUID**, then creation fails with
    ///           **E_NOINTERFACE**.
    ///    ppvResource = Type: [out, optional] **void**** A pointer to a memory block that receives a pointer to the resource.
    ///                  *ppvResource* can be NULL, to enable capability testing. When *ppvResource* is NULL, no object will be
    ///                  created and S_FALSE will be returned when *pResourceDesc* and other parameters are valid.
    ///Returns:
    ///    Type: **HRESULT** This method returns **E_OUTOFMEMORY** if there is insufficient memory to create the
    ///    resource. See Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT CreatePlacedResource(ID3D12Heap pHeap, ulong HeapOffset, const(D3D12_RESOURCE_DESC)* pDesc, 
                                 D3D12_RESOURCE_STATES InitialState, const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                 const(GUID)* riid, void** ppvResource);
    ///Creates a resource that is reserved, and not yet mapped to any pages in a heap.
    ///Params:
    ///    pDesc = Type: **const [D3D12_RESOURCE_DESC](./ns-d3d12-d3d12_resource_desc.md)\*** A pointer to a
    ///            **D3D12_RESOURCE_DESC** structure that describes the resource.
    ///    InitialState = Type: **[D3D12_RESOURCE_STATES](./ne-d3d12-d3d12_resource_states.md)** The initial state of the resource, as
    ///                   a bitwise-OR'd combination of **D3D12_RESOURCE_STATES** enumeration constants.
    ///    pOptimizedClearValue = Type: **const [D3D12_CLEAR_VALUE](./ns-d3d12-d3d12_clear_value.md)\*** Specifies a **D3D12_CLEAR_VALUE**
    ///                           structure that describes the default value for a clear color. *pOptimizedClearValue* specifies a value for
    ///                           which clear operations are most optimal. When the created resource is a texture with either the
    ///                           [D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET](./ne-d3d12-d3d12_resource_flags.md) or
    ///                           **D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL** flags, you should choose the value with which the clear operation
    ///                           will most commonly be called. You can call the clear operation with other values, but those operations won't
    ///                           be as efficient as when the value matches the one passed in to resource creation. When you use
    ///                           [D3D12_RESOURCE_DIMENSION_BUFFER](./ne-d3d12-d3d12_resource_dimension.md), you must set
    ///                           *pOptimizedClearValue* to `nullptr`.
    ///    riid = Type: **REFIID** A reference to the globally unique identifier (**GUID**) of the resource interface to return
    ///           in *ppvResource*. See **Remarks**. While *riidResource* is most commonly the **GUID** of
    ///           [ID3D12Resource](./nn-d3d12-id3d12resource.md), it may be the **GUID** of any interface. If the resource
    ///           object doesn't support the interface for this **GUID**, then creation fails with **E_NOINTERFACE**.
    ///    ppvResource = Type: **void\*\*** An optional pointer to a memory block that receives the requested interface pointer to the
    ///                  created resource object. *ppvResource* can be `nullptr`, to enable capability testing. When *ppvResource* is
    ///                  `nullptr`, no object is created, and **S_FALSE** is returned when *pDesc* is valid.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_OUTOFMEMORY|There is
    ///    insufficient memory to create the resource.| See [Direct3D 12 return
    ///    codes](/windows/win32/direct3d12/d3d12-graphics-reference-returnvalues) for other possible return values.
    ///    
    HRESULT CreateReservedResource(const(D3D12_RESOURCE_DESC)* pDesc, D3D12_RESOURCE_STATES InitialState, 
                                   const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, const(GUID)* riid, 
                                   void** ppvResource);
    ///Creates a shared handle to an heap, resource, or fence object.
    ///Params:
    ///    pObject = Type: <b>ID3D12DeviceChild*</b> A pointer to the ID3D12DeviceChild interface that represents the heap,
    ///              resource, or fence object to create for sharing. The following interfaces (derived from
    ///              <b>ID3D12DeviceChild</b>) are supported: <ul> <li> ID3D12Heap </li> <li> ID3D12Resource </li> <li>
    ///              ID3D12Fence </li> </ul>
    ///    pAttributes = Type: <b>const SECURITY_ATTRIBUTES*</b> A pointer to a SECURITY_ATTRIBUTESstructure that contains two
    ///                  separate but related data members: an optional security descriptor, and a <b>Boolean</b>value that determines
    ///                  whether child processes can inherit the returned handle. Set this parameter to <b>NULL</b> if you want child
    ///                  processes that the application might create to not inherit the handle returned by <b>CreateSharedHandle</b>,
    ///                  and if you want the resource that is associated with the returned handle to get a default security
    ///                  descriptor. The <b>lpSecurityDescriptor</b> member of the structure specifies a SECURITY_DESCRIPTOR for the
    ///                  resource. Set this member to <b>NULL</b> if you want the runtime to assign a default security descriptor to
    ///                  the resource that is associated with the returned handle. The ACLs in the default security descriptor for the
    ///                  resource come from the primary or impersonation token of the creator. For more info, see Synchronization
    ///                  Object Security and Access Rights.
    ///    Access = Type: <b>DWORD</b> Currently the only value this parameter accepts is GENERIC_ALL.
    ///    Name = Type: <b>LPCWSTR</b> A <b>NULL</b>-terminated <b>UNICODE</b> string that contains the name to associate with
    ///           the shared heap. The name is limited to MAX_PATH characters. Name comparison is case-sensitive. If
    ///           <i>Name</i> matches the name of an existing resource, <b>CreateSharedHandle</b> fails with
    ///           DXGI_ERROR_NAME_ALREADY_EXISTS. This occurs because these objects share the same namespace. The name can have
    ///           a "Global\" or "Local\" prefix to explicitly create the object in the global or session namespace. The
    ///           remainder of the name can contain any character except the backslash character (\\). For more information,
    ///           see Kernel Object Namespaces. Fast user switching is implemented using Terminal Services sessions. Kernel
    ///           object names must follow the guidelines outlined for Terminal Services so that applications can support
    ///           multiple users. The object can be created in a private namespace. For more information, see Object
    ///           Namespaces.
    ///    pHandle = Type: <b>HANDLE*</b> A pointer to a variable that receives the NT HANDLE value to the resource to share. You
    ///              can use this handle in calls to access the resource.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following values: <ul>
    ///    <li>DXGI_ERROR_INVALID_CALL if one of the parameters is invalid. </li> <li>DXGI_ERROR_NAME_ALREADY_EXISTS if
    ///    the supplied name of the resource to share is already associated with another resource. </li>
    ///    <li>E_ACCESSDENIED if the object is being created in a protected namespace.</li> <li>E_OUTOFMEMORY if
    ///    sufficient memory is not available to create the handle.</li> <li>Possibly other error codes that are
    ///    described in the Direct3D 12 Return Codes topic. </li> </ul>
    ///    
    HRESULT CreateSharedHandle(ID3D12DeviceChild pObject, const(SECURITY_ATTRIBUTES)* pAttributes, uint Access, 
                               const(PWSTR) Name, HANDLE* pHandle);
    ///Opens a handle for shared resources, shared heaps, and shared fences, by using HANDLE and REFIID.
    ///Params:
    ///    NTHandle = Type: <b>HANDLE</b> The handle that was output by the call to ID3D12Device::CreateSharedHandle.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for one of the following interfaces: <ul>
    ///           <li> ID3D12Heap </li> <li> ID3D12Resource </li> <li> ID3D12Fence </li> </ul> The <b>REFIID</b>, or
    ///           <b>GUID</b>, of the interface can be obtained by using the __uuidof() macro. For example,
    ///           __uuidof(ID3D12Heap) will get the <b>GUID</b> of the interface to a resource.
    ///    ppvObj = Type: <b>void**</b> A pointer to a memory block that receives a pointer to one of the following interfaces:
    ///             <ul> <li> ID3D12Heap </li> <li> ID3D12Resource </li> <li> ID3D12Fence </li> </ul>
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT OpenSharedHandle(HANDLE NTHandle, const(GUID)* riid, void** ppvObj);
    ///Opens a handle for shared resources, shared heaps, and shared fences, by using Name and Access.
    ///Params:
    ///    Name = Type: <b>LPCWSTR</b> The name that was optionally passed as the <i>Name</i> parameter in the call to
    ///           ID3D12Device::CreateSharedHandle.
    ///    Access = Type: <b>DWORD</b> The access level that was specified in the <i>Access</i> parameter in the call to
    ///             ID3D12Device::CreateSharedHandle.
    ///    pNTHandle = Type: <b>HANDLE*</b> Pointer to the shared handle.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT OpenSharedHandleByName(const(PWSTR) Name, uint Access, HANDLE* pNTHandle);
    ///Makes objects resident for the device.
    ///Params:
    ///    NumObjects = Type: <b>UINT</b> The number of objects in the <i>ppObjects</i> array to make resident for the device.
    ///    ppObjects = Type: <b>ID3D12Pageable*</b> A pointer to a memory block that contains an array of ID3D12Pageable interface
    ///                pointers for the objects. Even though most D3D12 objects inherit from ID3D12Pageable, residency changes are
    ///                only supported on the following objects: Descriptor Heaps, Heaps, Committed Resources, and Query Heaps
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT MakeResident(uint NumObjects, ID3D12Pageable* ppObjects);
    ///Enables the page-out of data, which precludes GPU access of that data.
    ///Params:
    ///    NumObjects = Type: <b>UINT</b> The number of objects in the <i>ppObjects</i> array to evict from the device.
    ///    ppObjects = Type: <b>ID3D12Pageable*</b> A pointer to a memory block that contains an array of ID3D12Pageable interface
    ///                pointers for the objects. Even though most D3D12 objects inherit from ID3D12Pageable, residency changes are
    ///                only supported on the following objects: Descriptor Heaps, Heaps, Committed Resources, and Query Heaps
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT Evict(uint NumObjects, ID3D12Pageable* ppObjects);
    ///Creates a fence object.
    ///Params:
    ///    InitialValue = Type: <b>UINT64</b> The initial value for the fence.
    ///    Flags = Type: <b>D3D12_FENCE_FLAGS</b> A combination of D3D12_FENCE_FLAGS-typed values that are combined by using a
    ///            bitwise OR operation. The resulting value specifies options for the fence.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the fence interface (ID3D12Fence). The
    ///           <b>REFIID</b>, or <b>GUID</b>, of the interface to the fence can be obtained by using the __uuidof() macro.
    ///           For example, __uuidof(ID3D12Fence) will get the <b>GUID</b> of the interface to a fence.
    ///    ppFence = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the ID3D12Fence interface that is
    ///              used to access the fence.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; otherwise, returns one of the Direct3D 12 Return
    ///    Codes.
    ///    
    HRESULT CreateFence(ulong InitialValue, D3D12_FENCE_FLAGS Flags, const(GUID)* riid, void** ppFence);
    ///Gets the reason that the device was removed.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns the reason that the device was removed.
    ///    
    HRESULT GetDeviceRemovedReason();
    ///Gets a resource layout that can be copied. Helps the app fill-in D3D12_PLACED_SUBRESOURCE_FOOTPRINT and
    ///D3D12_SUBRESOURCE_FOOTPRINT when suballocating space in upload heaps.
    ///Params:
    ///    pResourceDesc = Type: <b>const D3D12_RESOURCE_DESC*</b> A description of the resource, as a pointer to a D3D12_RESOURCE_DESC
    ///                    structure.
    ///    FirstSubresource = Type: <b>UINT</b> Index of the first subresource in the resource. The range of valid values is 0 to
    ///                       D3D12_REQ_SUBRESOURCES.
    ///    NumSubresources = Type: <b>UINT</b> The number of subresources in the resource. The range of valid values is 0 to
    ///                      (D3D12_REQ_SUBRESOURCES - <i>FirstSubresource</i>).
    ///    BaseOffset = Type: <b>UINT64</b> The offset, in bytes, to the resource.
    ///    pLayouts = Type: <b>D3D12_PLACED_SUBRESOURCE_FOOTPRINT*</b> A pointer to an array (of length <i>NumSubresources</i>) of
    ///               D3D12_PLACED_SUBRESOURCE_FOOTPRINT structures, to be filled with the description and placement of each
    ///               subresource.
    ///    pNumRows = Type: <b>UINT*</b> A pointer to an array (of length <i>NumSubresources</i>) of integer variables, to be
    ///               filled with the number of rows for each subresource.
    ///    pRowSizeInBytes = Type: <b>UINT64*</b> A pointer to an array (of length <i>NumSubresources</i>) of integer variables, each
    ///                      entry to be filled with the unpadded size in bytes of a row, of each subresource. For example, if a Texture2D
    ///                      resource has a width of 32 and bytes per pixel of 4, then <i>pRowSizeInBytes</i> returns 128.
    ///                      <i>pRowSizeInBytes</i> should not be confused with <b>row pitch</b>, as examining <i>pLayouts</i> and getting
    ///                      the row pitch from that will give you 256 as it is aligned to D3D12_TEXTURE_DATA_PITCH_ALIGNMENT.
    ///    pTotalBytes = Type: <b>UINT64*</b> A pointer to an integer variable, to be filled with the total size, in bytes.
    void    GetCopyableFootprints(const(D3D12_RESOURCE_DESC)* pResourceDesc, uint FirstSubresource, 
                                  uint NumSubresources, ulong BaseOffset, 
                                  D3D12_PLACED_SUBRESOURCE_FOOTPRINT* pLayouts, uint* pNumRows, 
                                  ulong* pRowSizeInBytes, ulong* pTotalBytes);
    ///Creates a query heap. A query heap contains an array of queries.
    ///Params:
    ///    pDesc = Type: <b>const D3D12_QUERY_HEAP_DESC*</b> Specifies the query heap in a D3D12_QUERY_HEAP_DESC structure.
    ///    riid = Type: <b>REFIID</b> Specifies a REFIID that uniquely identifies the heap.
    ///    ppvHeap = Type: <b>void**</b> Specifies a pointer to the heap, that will be returned on successful completion of the
    ///              method. <i>ppvHeap</i> can be NULL, to enable capability testing. When <i>ppvHeap</i> is NULL, no object will
    ///              be created and S_FALSE will be returned when <i>pDesc</i> is valid.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT CreateQueryHeap(const(D3D12_QUERY_HEAP_DESC)* pDesc, const(GUID)* riid, void** ppvHeap);
    ///A development-time aid for certain types of profiling and experimental prototyping.
    ///Params:
    ///    Enable = Type: <b>BOOL</b> Specifies a BOOL that turns the stable power state on or off.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetStablePowerState(BOOL Enable);
    ///This method creates a command signature.
    ///Params:
    ///    pDesc = Type: <b>const D3D12_COMMAND_SIGNATURE_DESC*</b> Describes the command signature to be created with the
    ///            D3D12_COMMAND_SIGNATURE_DESC structure.
    ///    pRootSignature = Type: <b>ID3D12RootSignature*</b> Specifies the ID3D12RootSignature that the command signature applies to.
    ///                     The root signature is required if any of the commands in the signature will update bindings on the pipeline.
    ///                     If the only command present is a draw or dispatch, the root signature parameter can be set to NULL.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the command signature interface
    ///           (ID3D12CommandSignature). The <b>REFIID</b>, or <b>GUID</b>, of the interface to the command signature can be
    ///           obtained by using the __uuidof() macro. For example, __uuidof(<b>ID3D12CommandSignature</b>) will get the
    ///           <b>GUID</b> of the interface to a command signature.
    ///    ppvCommandSignature = Type: <b>void**</b> Specifies a pointer, that on successful completion of the method will point to the
    ///                          created command signature (ID3D12CommandSignature).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT CreateCommandSignature(const(D3D12_COMMAND_SIGNATURE_DESC)* pDesc, ID3D12RootSignature pRootSignature, 
                                   const(GUID)* riid, void** ppvCommandSignature);
    ///Gets info about how a tiled resource is broken into tiles.
    ///Params:
    ///    pTiledResource = Type: <b>ID3D12Resource*</b> Specifies a tiled ID3D12Resource to get info about.
    ///    pNumTilesForEntireResource = Type: <b>UINT*</b> A pointer to a variable that receives the number of tiles needed to store the entire tiled
    ///                                 resource.
    ///    pPackedMipDesc = Type: <b>D3D12_PACKED_MIP_INFO*</b> A pointer to a D3D12_PACKED_MIP_INFO structure that
    ///                     <b>GetResourceTiling</b> fills with info about how the tiled resource's mipmaps are packed.
    ///    pStandardTileShapeForNonPackedMips = Type: <b>D3D12_TILE_SHAPE*</b> Specifies a D3D12_TILE_SHAPE structure that <b>GetResourceTiling</b> fills
    ///                                         with info about the tile shape. This is info about how pixels fit in the tiles, independent of tiled
    ///                                         resource's dimensions, not including packed mipmaps. If the entire tiled resource is packed, this parameter
    ///                                         is meaningless because the tiled resource has no defined layout for packed mipmaps. In this situation,
    ///                                         <b>GetResourceTiling</b> sets the members of D3D12_TILE_SHAPE to zeros.
    ///    pNumSubresourceTilings = Type: <b>UINT*</b> A pointer to a variable that contains the number of tiles in the subresource. On input,
    ///                             this is the number of subresources to query tilings for; on output, this is the number that was actually
    ///                             retrieved at <i>pSubresourceTilingsForNonPackedMips</i> (clamped to what's available).
    ///    FirstSubresourceTilingToGet = Type: <b>UINT</b> The number of the first subresource tile to get. <b>GetResourceTiling</b> ignores this
    ///                                  parameter if the number that <i>pNumSubresourceTilings</i> points to is 0.
    ///    pSubresourceTilingsForNonPackedMips = Type: <b>D3D12_SUBRESOURCE_TILING*</b> Specifies a D3D12_SUBRESOURCE_TILING structure that
    ///                                          <b>GetResourceTiling</b> fills with info about subresource tiles. If subresource tiles are part of packed
    ///                                          mipmaps, <b>GetResourceTiling</b> sets the members of D3D12_SUBRESOURCE_TILING to zeros, except the
    ///                                          <i>StartTileIndexInOverallResource</i> member, which <b>GetResourceTiling</b> sets to D3D12_PACKED_TILE
    ///                                          (0xffffffff). The D3D12_PACKED_TILE constant indicates that the whole <b>D3D12_SUBRESOURCE_TILING</b>
    ///                                          structure is meaningless for this situation, and the info that the <i>pPackedMipDesc</i> parameter points to
    ///                                          applies.
    void    GetResourceTiling(ID3D12Resource pTiledResource, uint* pNumTilesForEntireResource, 
                              D3D12_PACKED_MIP_INFO* pPackedMipDesc, 
                              D3D12_TILE_SHAPE* pStandardTileShapeForNonPackedMips, uint* pNumSubresourceTilings, 
                              uint FirstSubresourceTilingToGet, 
                              D3D12_SUBRESOURCE_TILING* pSubresourceTilingsForNonPackedMips);
    ///Gets a locally unique identifier for the current device (adapter).
    ///Returns:
    ///    Type: <b>LUID</b> The locally unique identifier for the adapter.
    ///    
    LUID    GetAdapterLuid();
}

///Manages a pipeline library, in particular loading and retrieving individual PSOs.
@GUID("C64226A8-9201-46AF-B4CC-53FB9FF7414F")
interface ID3D12PipelineLibrary : ID3D12DeviceChild
{
    ///Adds the input PSO to an internal database with the corresponding name.
    ///Params:
    ///    pName = Type: <b>LPCWSTR</b> Specifies a unique name for the library. Overwriting is not supported.
    ///    pPipeline = Type: <b>ID3D12PipelineState*</b> Specifies the ID3D12PipelineState to add.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code, including E_INVALIDARG if the name
    ///    already exists, E_OUTOFMEMORY if unable to allocate storage in the library.
    ///    
    HRESULT StorePipeline(const(PWSTR) pName, ID3D12PipelineState pPipeline);
    ///Retrieves the requested PSO from the library.
    ///Params:
    ///    pName = Type: <b>LPCWSTR</b> The unique name of the PSO.
    ///    pDesc = Type: <b>const D3D12_GRAPHICS_PIPELINE_STATE_DESC*</b> Specifies a description of the required PSO in a
    ///            D3D12_GRAPHICS_PIPELINE_STATE_DESC structure. This input description is matched against the data in the
    ///            current library database, and stored in order to prevent duplication of PSO contents.
    ///    riid = Type: <b>REFIID</b> Specifies a REFIID for the ID3D12PipelineState object. Typically set this, and the
    ///           following parameter, with the macro <code>IID_PPV_ARGS(&amp;PSO1)</code>, where <i>PSO1</i> is the name of
    ///           the object.
    ///    ppPipelineState = Type: <b>void**</b> Specifies a pointer that will reference the returned PSO.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code, which can include E_INVALIDARG if
    ///    the name doesn’t exist, or if the input description doesn’t match the data in the library, and
    ///    E_OUTOFMEMORY if unable to allocate the return PSO.
    ///    
    HRESULT LoadGraphicsPipeline(const(PWSTR) pName, const(D3D12_GRAPHICS_PIPELINE_STATE_DESC)* pDesc, 
                                 const(GUID)* riid, void** ppPipelineState);
    ///Retrieves the requested PSO from the library. The input desc is matched against the data in the current library
    ///database, and remembered in order to prevent duplication of PSO contents.
    ///Params:
    ///    pName = Type: <b>LPCWSTR</b> The unique name of the PSO.
    ///    pDesc = Type: <b>const D3D12_COMPUTE_PIPELINE_STATE_DESC*</b> Specifies a description of the required PSO in a
    ///            D3D12_COMPUTE_PIPELINE_STATE_DESC structure. This input description is matched against the data in the
    ///            current library database, and stored in order to prevent duplication of PSO contents.
    ///    riid = Type: <b>REFIID</b> Specifies a REFIID for the ID3D12PipelineState object. Typically set this, and the
    ///           following parameter, with the macro <code>IID_PPV_ARGS(&amp;PSO1)</code>, where <i>PSO1</i> is the name of
    ///           the object.
    ///    ppPipelineState = Type: <b>void**</b> Specifies a pointer that will reference the returned PSO.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code, which can include E_INVALIDARG if
    ///    the name doesn’t exist, or if the input description doesn’t match the data in the library, and
    ///    E_OUTOFMEMORY if unable to allocate the return PSO.
    ///    
    HRESULT LoadComputePipeline(const(PWSTR) pName, const(D3D12_COMPUTE_PIPELINE_STATE_DESC)* pDesc, 
                                const(GUID)* riid, void** ppPipelineState);
    ///Returns the amount of memory required to serialize the current contents of the database.
    ///Returns:
    ///    Type: <b>SIZE_T</b> This method returns a SIZE_T object, containing the size required in bytes.
    ///    
    size_t  GetSerializedSize();
    ///Writes the contents of the library to the provided memory, to be provided back to the runtime at a later time.
    ///Params:
    ///    pData = Type: <b>void*</b> Specifies a pointer to the data. This memory must be readable and writeable up to the
    ///            input size. This data can be saved and provided to CreatePipelineLibrary at a later time, including future
    ///            instances of this or other processes. The data becomes invalidated if the runtime or driver is updated, and
    ///            is not portable to other hardware or devices.
    ///    DataSizeInBytes = Type: <b>SIZE_T</b> The size provided must be at least the size returned from GetSerializedSize.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code, including E_INVALIDARG if the
    ///    buffer provided isn’t big enough.
    ///    
    HRESULT Serialize(void* pData, size_t DataSizeInBytes);
}

///Manages a pipeline library. This interface extends ID3D12PipelineLibrary to load PSOs from a pipeline state stream
///description.
@GUID("80EABF42-2568-4E5E-BD82-C37F86961DC3")
interface ID3D12PipelineLibrary1 : ID3D12PipelineLibrary
{
    ///Retrieves the requested PSO from the library. The pipeline stream description is matched against the library
    ///database and remembered in order to prevent duplication of PSO contents.
    ///Params:
    ///    pName = Type: <b>LPCWSTR</b> SAL: <code>_In_</code> The unique name of the PSO.
    ///    pDesc = Type: <b>const D3D12_PIPELINE_STATE_STREAM_DESC*</b> SAL: <code>_In_</code> Describes the required PSO using
    ///            a D3D12_PIPELINE_STATE_STREAM_DESC structure. This description is matched against the library database and
    ///            stored in order to prevent duplication of PSO contents.
    ///    riid = Type: <b>REFIID</b> Specifies a REFIID for the ID3D12PipelineStateState object. Applications should typically
    ///           set this argument and the following argument, ppPipelineState, by using the macro IID_PPV_ARGS(&amp;PSO1),
    ///           where PSO1 is the name of the object.
    ///    ppPipelineState = Type: <b>void**</b> SAL: <code>_COM_Outptr_</code> Specifies the pointer that will reference the PSO after
    ///                      the function successfully returns.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code, which can include E_INVALIDARG if
    ///    the name doesn't exist or the stream description doesn't match the data in the library, and E_OUTOFMEMORY if
    ///    the function is unable to allocate the resulting PSO.
    ///    
    HRESULT LoadPipeline(const(PWSTR) pName, const(D3D12_PIPELINE_STATE_STREAM_DESC)* pDesc, const(GUID)* riid, 
                         void** ppPipelineState);
}

///Represents a virtual adapter, and expands on the range of methods provided by ID3D12Device. <div
///class="alert"><b>Note</b> This interface was introduced in Windows 10 Anniversary Update. Applications targetting
///Windows 10 Anniversary Update should use this interface instead of earlier or later versions. Applications targetting
///an earlier or later version of Windows 10 should use the appropriate version of the <b>ID3D12Device</b>
///interface.</div><div> </div>
@GUID("77ACCE80-638E-4E65-8895-C1F23386863E")
interface ID3D12Device1 : ID3D12Device
{
    ///Creates a cached pipeline library. For pipeline state objects (PSOs) that are expected to share data together,
    ///grouping them into a library before serializing them means that there's less overhead due to metadata, as well as
    ///the opportunity to avoid redundant or duplicated data from being written to disk. You can query for
    ///**ID3D12PipelineLibrary** support with <b>ID3D12Device::CheckFeatureSupport</b>, with
    ///<b>D3D12_FEATURE_SHADER_CACHE</b> and <b>D3D12_FEATURE_DATA_SHADER_CACHE</b>. If the *Flags* member of
    ///<b>D3D12_FEATURE_DATA_SHADER_CACHE</b> contains the flag <b>D3D12_SHADER_CACHE_SUPPORT_LIBRARY</b>, the
    ///**ID3D12PipelineLibrary** interface is supported. If not, **DXGI_ERROR_NOT_SUPPORTED** will always be returned
    ///when this function is called.
    ///Params:
    ///    pLibraryBlob = Type: **const void\*** If the input library blob is empty, then the initial content of the library is empty.
    ///                   If the input library blob is not empty, then it is validated for integrity, parsed, and the pointer is
    ///                   stored. The pointer provided as input to this method must remain valid for the lifetime of the object
    ///                   returned. For efficiency reasons, the data is not copied.
    ///    BlobLength = Type: **[SIZE_T](/windows/win32/winprog/windows-data-types)** Specifies the length of *pLibraryBlob* in
    ///                 bytes.
    ///    riid = Type: **REFIID** Specifies a unique REFIID for the
    ///           [ID3D12PipelineLibrary](./nn-d3d12-id3d12pipelinelibrary.md) object. Typically set this and the following
    ///           parameter with the macro `IID_PPV_ARGS(&Library)`, where **Library** is the name of the object.
    ///    ppPipelineLibrary = Type: **void\*\*** Returns a pointer to the created library.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10), including **E_INVALIDARG** if the blob is corrupted or
    ///    unrecognized, **D3D12_ERROR_DRIVER_VERSION_MISMATCH** if the provided data came from an old driver or
    ///    runtime, and **D3D12_ERROR_ADAPTER_NOT_FOUND** if the data came from different hardware. If you pass
    ///    `nullptr` for *pPipelineLibrary* then the runtime still performs the validation of the blob but avoid
    ///    creating the actual library and returns S_FALSE if the library would have been created. Also, the feature
    ///    requires an updated driver, and attempting to use it on old drivers will return DXGI_ERROR_UNSUPPORTED.
    ///    
    HRESULT CreatePipelineLibrary(const(void)* pLibraryBlob, size_t BlobLength, const(GUID)* riid, 
                                  void** ppPipelineLibrary);
    ///Specifies an event that should be fired when one or more of a collection of fences reach specific values.
    ///Params:
    ///    ppFences = Type: <b>ID3D12Fence*</b> An array of length <i>NumFences</i> that specifies the ID3D12Fence objects.
    ///    pFenceValues = Type: <b>const UINT64*</b> An array of length <i>NumFences</i> that specifies the fence values required for
    ///                   the event is to be signaled.
    ///    NumFences = Type: <b>UINT</b> Specifies the number of fences to be included.
    ///    Flags = Type: <b>D3D12_MULTIPLE_FENCE_WAIT_FLAGS</b> Specifies one of the D3D12_MULTIPLE_FENCE_WAIT_FLAGS that
    ///            determines how to proceed.
    ///    hEvent = Type: <b>HANDLE</b> A handle to the event object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT SetEventOnMultipleFenceCompletion(ID3D12Fence* ppFences, const(ulong)* pFenceValues, uint NumFences, 
                                              D3D12_MULTIPLE_FENCE_WAIT_FLAGS Flags, HANDLE hEvent);
    ///This method sets residency priorities of a specified list of objects.
    ///Params:
    ///    NumObjects = Type: <b>UINT</b> Specifies the number of objects in the <i>ppObjects</i> and <i>pPriorities</i> arrays.
    ///    ppObjects = Type: <b>ID3D12Pageable*</b> Specifies an array, of length <i>NumObjects</i>, containing references to
    ///                ID3D12Pageable objects.
    ///    pPriorities = Type: <b>const D3D12_RESIDENCY_PRIORITY*</b> Specifies an array, of length <i>NumObjects</i>, of
    ///                  D3D12_RESIDENCY_PRIORITY values for the list of objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT SetResidencyPriority(uint NumObjects, ID3D12Pageable* ppObjects, 
                                 const(D3D12_RESIDENCY_PRIORITY)* pPriorities);
}

///Represents a virtual adapter. This interface extends ID3D12Device1 to create pipeline state objects from pipeline
///state stream descriptions. <div class="alert"><b>Note</b> This interface was introduced in Windows 10 Creators
///Update. Applications targeting Windows 10 Creators Update should use this interface instead of earlier or later
///versions. Applications targeting an earlier or later version of Windows 10 should use the appropriate version of the
///<b>ID3D12Device</b> interface.</div><div> </div>
@GUID("30BAA41E-B15B-475C-A0BB-1AF5C5B64328")
interface ID3D12Device2 : ID3D12Device1
{
    ///Creates a pipeline state object from a pipeline state stream description.
    ///Params:
    ///    pDesc = Type: <b>const D3D12_PIPELINE_STATE_STREAM_DESC*</b> The address of a D3D12_PIPELINE_STATE_STREAM_DESC
    ///            structure that describes the pipeline state.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the pipeline state interface
    ///           (ID3D12PipelineState). The <b>REFIID</b>, or <b>GUID</b>, of the interface to the pipeline state can be
    ///           obtained by using the __uuidof() macro. For example, __uuidof(ID3D12PipelineState) will get the <b>GUID</b>
    ///           of the interface to a pipeline state.
    ///    ppPipelineState = Type: <b>void**</b> SAL: <code>_COM_Outptr_</code> A pointer to a memory block that receives a pointer to the
    ///                      ID3D12PipelineState interface for the pipeline state object. The pipeline state object is an immutable state
    ///                      object. It contains no methods.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_OUTOFMEMORY</b> if there is insufficient memory to create the
    ///    pipeline state object. See Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT CreatePipelineState(const(D3D12_PIPELINE_STATE_STREAM_DESC)* pDesc, const(GUID)* riid, 
                                void** ppPipelineState);
}

///Represents a virtual adapter. This interface extends ID3D12Device2 to support the creation of special-purpose
///diagnostic heaps in system memory that persist even in the event of a GPU-fault or device-removed scenario. <div
///class="alert"><b>Note</b> This interface, introduced in the Windows 10 Fall Creators Update, is the latest version of
///the ID3D12Device interface. Applications targeting the Windows 10 Fall Creators Update and later should use this
///interface instead of earlier versions.</div><div> </div>
@GUID("81DADC15-2BAD-4392-93C5-101345C4AA98")
interface ID3D12Device3 : ID3D12Device2
{
    ///Creates a special-purpose diagnostic heap in system memory from an address. The created heap can persist even in
    ///the event of a GPU-fault or device-removed scenario.
    ///Params:
    ///    pAddress = Type: <b>const void*</b> The address used to create the heap.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the heap interface (ID3D12Heap). The
    ///           <b>REFIID</b>, or <b>GUID</b>, of the interface to the heap can be obtained by using the <b>__uuidof()</b>
    ///           macro. For example, <b>__uuidof(ID3D12Heap)</b> will retrieve the <b>GUID</b> of the interface to a heap.
    ///    ppvHeap = Type: <b>void**</b> SAL: <code>_COM_Outptr_</code> A pointer to a memory block. On success, the D3D12 runtime
    ///              will write a pointer to the newly-opened heap into the memory block. The type of the pointer depends on the
    ///              provided <b>riid</b> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_OUTOFMEMORY</b> if there is insufficient memory to open the
    ///    existing heap. See Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT OpenExistingHeapFromAddress(const(void)* pAddress, const(GUID)* riid, void** ppvHeap);
    ///Creates a special-purpose diagnostic heap in system memory from a file mapping object. The created heap can
    ///persist even in the event of a GPU-fault or device-removed scenario.
    ///Params:
    ///    hFileMapping = Type: **[HANDLE](/windows/win32/winprog/windows-data-types)** The handle to the file mapping object to use to
    ///                   create the heap.
    ///    riid = Type: **REFIID** The globally unique identifier (**GUID**) for the heap interface (ID3D12Heap). The
    ///           **REFIID**, or **GUID**, of the interface to the heap can be obtained by using the **__uuidof()** macro. For
    ///           example, **__uuidof(ID3D12Heap)** will retrieve the **GUID** of the interface to a heap.
    ///    ppvHeap = Type: **void\*\*** SAL: <code>_COM_Outptr_</code> A pointer to a memory block. On success, the D3D12 runtime
    ///              will write a pointer to the newly-opened heap into the memory block. The type of the pointer depends on the
    ///              provided **riid** parameter.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** This method returns **E_OUTOFMEMORY** if
    ///    there is insufficient memory to open the existing heap. See Direct3D 12 Return Codes for other possible
    ///    return values.
    ///    
    HRESULT OpenExistingHeapFromFileMapping(HANDLE hFileMapping, const(GUID)* riid, void** ppvHeap);
    ///Asynchronously makes objects resident for the device.
    ///Params:
    ///    Flags = Type: <b>D3D12_RESIDENCY_FLAGS</b> Controls whether the objects should be made resident if the application is
    ///            over its memory budget.
    ///    NumObjects = Type: <b>UINT</b> The number of objects in the <i>ppObjects</i> array to make resident for the device.
    ///    ppObjects = Type: <b>ID3D12Pageable*</b> A pointer to a memory block; contains an array of ID3D12Pageable interface
    ///                pointers for the objects. Even though most D3D12 objects inherit from ID3D12Pageable, residency changes are
    ///                only supported on the following: <ul> <li>descriptor heaps</li> <li>heaps</li> <li>committed resources</li>
    ///                <li>query heaps</li> </ul>
    ///    pFenceToSignal = Type: <b>ID3D12Fence*</b> A pointer to the fence used to signal when the work is done.
    ///    FenceValueToSignal = Type: <b>UINT64</b> An unsigned 64-bit value signaled to the fence when the work is done.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT EnqueueMakeResident(D3D12_RESIDENCY_FLAGS Flags, uint NumObjects, ID3D12Pageable* ppObjects, 
                                ID3D12Fence pFenceToSignal, ulong FenceValueToSignal);
}

///Offers base functionality that allows for a consistent way to monitor the validity of a session across the different
///types of sessions. The only type of session currently available is of type
///[ID3D12ProtectedResourceSession](./nn-d3d12-id3d12protectedresourcesession.md).
@GUID("A1533D18-0AC1-4084-85B9-89A96116806B")
interface ID3D12ProtectedSession : ID3D12DeviceChild
{
    ///Retrieves the fence for the protected session. From the fence, you can retrieve the current uniqueness validity
    ///value (using ID3D12Fence::GetCompletedValue), and add monitors for changes to its value. This is a read-only
    ///fence.
    ///Params:
    ///    riid = The GUID of the interface to a fence. Most commonly, ID3D12Fence, although it may be any GUID for any
    ///           interface. If the protected session object doesn’t support the interface for this GUID, the function
    ///           returns <b>E_NOINTERFACE</b>.
    ///    ppFence = A pointer to a memory block that receives a pointer to the fence for the given protected session.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStatusFence(const(GUID)* riid, void** ppFence);
    ///Gets the status of the protected session.
    ///Returns:
    ///    Type:
    ///    **[D3D12_PROTECTED_SESSION_STATUS](/windows/desktop/api/d3d12/ne-d3d12-d3d12_protected_session_status)** The
    ///    status of the protected session. If the returned value is
    ///    [D3D12_PROTECTED_SESSION_STATUS_INVALID](/windows/desktop/api/d3d12/ne-d3d12-d3d12_protected_session_status),
    ///    then you need to wait for a uniqueness value bump to reuse the resource if the session is an
    ///    [ID3D12ProtectedResourceSession](/windows/desktop/api/d3d12/nn-d3d12-id3d12protectedresourcesession).
    ///    
    D3D12_PROTECTED_SESSION_STATUS GetSessionStatus();
}

///Monitors the validity of a protected resource session. This interface extends [ID3D12ProtectedSession](). You can
///obtain an **ID3D12ProtectedResourceSession** by calling
///[ID3D12Device4::CreateProtectedResourceSession](./nf-d3d12-id3d12device4-createprotectedresourcesession.md).
@GUID("6CD696F4-F289-40CC-8091-5A6C0A099C3D")
interface ID3D12ProtectedResourceSession : ID3D12ProtectedSession
{
    ///Retrieves a description of the protected resource session.
    ///Returns:
    ///    A [D3D12_PROTECTED_RESOURCE_SESSION_DESC](./ns-d3d12-d3d12_protected_resource_session_desc.md) that describes
    ///    the protected resource session.
    ///    
    D3D12_PROTECTED_RESOURCE_SESSION_DESC GetDesc();
}

///Represents a virtual adapter. This interface extends [ID3D12Device3](./nn-d3d12-id3d12device3.md).
@GUID("E865DF17-A9EE-46F9-A463-3098315AA2E5")
interface ID3D12Device4 : ID3D12Device3
{
    ///Creates a command list in the closed state. Also see
    ///[ID3D12Device::CreateCommandList](./nf-d3d12-id3d12device-createcommandlist.md).
    ///Params:
    ///    nodeMask = Type: **[UINT](/windows/win32/WinProg/windows-data-types)** For single-GPU operation, set this to zero. If
    ///               there are multiple GPU nodes, then set a bit to identify the node (the device's physical adapter) for which
    ///               to create the command list. Each bit in the mask corresponds to a single node. Only one bit must be set. Also
    ///               see [Multi-adapter systems](/windows/win32/direct3d12/multi-engine).
    ///    type = Type: **[D3D12_COMMAND_LIST_TYPE](./ne-d3d12-d3d12_command_list_type.md)** Specifies the type of command list
    ///           to create.
    ///    flags = Type: **[D3D12_COMMAND_LIST_FLAGS](./ne-d3d12-d3d12_command_list_flags.md)** Specifies creation flags.
    ///    riid = Type: **REFIID** A reference to the globally unique identifier (**GUID**) of the command list interface to
    ///           return in *ppCommandList*.
    ///    ppCommandList = Type: **void\*\*** A pointer to a memory block that receives a pointer to the
    ///                    [ID3D12CommandList](./nn-d3d12-id3d12commandlist.md) or
    ///                    [ID3D12GraphicsCommandList](./nn-d3d12-id3d12graphicscommandlist.md) interface for the command list.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_OUTOFMEMORY|There is
    ///    insufficient memory to create the command list.| See [Direct3D 12 return
    ///    codes](/windows/win32/direct3d12/d3d12-graphics-reference-returnvalues) for other possible return values.
    ///    
    HRESULT CreateCommandList1(uint nodeMask, D3D12_COMMAND_LIST_TYPE type, D3D12_COMMAND_LIST_FLAGS flags, 
                               const(GUID)* riid, void** ppCommandList);
    ///Creates an object that represents a session for content protection. You can then provide that session when you're
    ///creating resource or heap objects, to indicate that they should be protected. > [!NOTE] > Memory contents can't
    ///be transferred from a protected resource to an unprotected resource.
    ///Params:
    ///    pDesc = Type: **const
    ///            [D3D12_PROTECTED_RESOURCE_SESSION_DESC](./ns-d3d12-d3d12_protected_resource_session_desc.md)\*** A pointer to
    ///            a constant **D3D12_PROTECTED_RESOURCE_SESSION_DESC** structure, describing the session to create.
    ///    riid = Type: **REFIID** A reference to the globally unique identifier (**GUID**) of the
    ///           [ID3D12ProtectedResourceSession](./nn-d3d12-id3d12protectedresourcesession.md) interface.
    ///    ppSession = Type: **void\*\*** A pointer to a memory block that receives an
    ///                [ID3D12ProtectedResourceSession](./nn-d3d12-id3d12protectedresourcesession.md) interface pointer to the
    ///                created session object.
    ///Returns:
    ///    
    ///    
    HRESULT CreateProtectedResourceSession(const(D3D12_PROTECTED_RESOURCE_SESSION_DESC)* pDesc, const(GUID)* riid, 
                                           void** ppSession);
    ///Creates both a resource and an implicit heap (optionally for a protected session), such that the heap is big
    ///enough to contain the entire resource, and the resource is mapped to the heap. Also see
    ///[ID3D12Device::CreateCommittedResource](./nf-d3d12-id3d12device-createcommittedresource.md) for a code example.
    ///Params:
    ///    pHeapProperties = Type: **const [D3D12_HEAP_PROPERTIES](./ns-d3d12-d3d12_heap_properties.md)\*** A pointer to a
    ///                      **D3D12_HEAP_PROPERTIES** structure that provides properties for the resource's heap.
    ///    HeapFlags = Type: **[D3D12_HEAP_FLAGS](./ne-d3d12-d3d12_heap_flags.md)** Heap options, as a bitwise-OR'd combination of
    ///                **D3D12_HEAP_FLAGS** enumeration constants.
    ///    pDesc = Type: **const [D3D12_RESOURCE_DESC](./ns-d3d12-d3d12_resource_desc.md)\*** A pointer to a
    ///            **D3D12_RESOURCE_DESC** structure that describes the resource.
    ///    InitialResourceState = Type: **[D3D12_RESOURCE_STATES](./ne-d3d12-d3d12_resource_states.md)** The initial state of the resource, as
    ///                           a bitwise-OR'd combination of **D3D12_RESOURCE_STATES** enumeration constants. When you create a resource
    ///                           together with a [D3D12_HEAP_TYPE_UPLOAD](./ne-d3d12-d3d12_heap_type.md) heap, you must set
    ///                           *InitialResourceState* to [D3D12_RESOURCE_STATE_GENERIC_READ](./ne-d3d12-d3d12_resource_states.md). When you
    ///                           create a resource together with a [D3D12_HEAP_TYPE_READBACK](./ne-d3d12-d3d12_heap_type.md) heap, you must
    ///                           set *InitialResourceState* to [D3D12_RESOURCE_STATE_COPY_DEST](./ne-d3d12-d3d12_resource_states.md).
    ///    pOptimizedClearValue = Type: **const [D3D12_CLEAR_VALUE](./ns-d3d12-d3d12_clear_value.md)\*** Specifies a **D3D12_CLEAR_VALUE**
    ///                           structure that describes the default value for a clear color. *pOptimizedClearValue* specifies a value for
    ///                           which clear operations are most optimal. When the created resource is a texture with either the
    ///                           [D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET](./ne-d3d12-d3d12_resource_flags.md) or
    ///                           **D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL** flags, you should choose the value with which the clear operation
    ///                           will most commonly be called. You can call the clear operation with other values, but those operations won't
    ///                           be as efficient as when the value matches the one passed in to resource creation. When you use
    ///                           [D3D12_RESOURCE_DIMENSION_BUFFER](./ne-d3d12-d3d12_resource_dimension.md), you must set
    ///                           *pOptimizedClearValue* to `nullptr`.
    ///    pProtectedSession = Type: **[ID3D12ProtectedResourceSession](./nn-d3d12-id3d12protectedresourcesession.md)\*** An optional
    ///                        pointer to an object that represents a session for content protection. If provided, this session indicates
    ///                        that the resource should be protected. You can obtain an **ID3D12ProtectedResourceSession** by calling
    ///                        [ID3D12Device4::CreateProtectedResourceSession](./nf-d3d12-id3d12device4-createprotectedresourcesession.md).
    ///    riidResource = Type: **REFIID** A reference to the globally unique identifier (**GUID**) of the resource interface to return
    ///                   in *ppvResource*. While *riidResource* is most commonly the **GUID** of
    ///                   [ID3D12Resource](./nn-d3d12-id3d12resource.md), it may be the **GUID** of any interface. If the resource
    ///                   object doesn't support the interface for this **GUID**, then creation fails with **E_NOINTERFACE**.
    ///    ppvResource = Type: **void\*\*** An optional pointer to a memory block that receives the requested interface pointer to the
    ///                  created resource object. *ppvResource* can be `nullptr`, to enable capability testing. When *ppvResource* is
    ///                  `nullptr`, no object is created, and **S_FALSE** is returned when *pDesc* is valid.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_OUTOFMEMORY|There is
    ///    insufficient memory to create the resource.| See [Direct3D 12 return
    ///    codes](/windows/win32/direct3d12/d3d12-graphics-reference-returnvalues) for other possible return values.
    ///    
    HRESULT CreateCommittedResource1(const(D3D12_HEAP_PROPERTIES)* pHeapProperties, D3D12_HEAP_FLAGS HeapFlags, 
                                     const(D3D12_RESOURCE_DESC)* pDesc, D3D12_RESOURCE_STATES InitialResourceState, 
                                     const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                     ID3D12ProtectedResourceSession pProtectedSession, const(GUID)* riidResource, 
                                     void** ppvResource);
    ///Creates a heap (optionally for a protected session) that can be used with placed resources and reserved
    ///resources. Also see [ID3D12Device::CreateHeap](./nf-d3d12-id3d12device-createheap.md).
    ///Params:
    ///    pDesc = Type: **const [D3D12_HEAP_DESC](./ns-d3d12-d3d12_heap_desc.md)\*** A pointer to a constant
    ///            **D3D12_HEAP_DESC** structure that describes the heap.
    ///    pProtectedSession = Type: **[ID3D12ProtectedResourceSession](./nn-d3d12-id3d12protectedresourcesession.md)\*** An optional
    ///                        pointer to an object that represents a session for content protection. If provided, this session indicates
    ///                        that the heap should be protected. You can obtain an **ID3D12ProtectedResourceSession** by calling
    ///                        [ID3D12Device4::CreateProtectedResourceSession](./nf-d3d12-id3d12device4-createprotectedresourcesession.md).
    ///    riid = Type: **REFIID** A reference to the globally unique identifier (**GUID**) of the heap interface to return in
    ///           *ppvHeap*. While *riidResource* is most commonly the **GUID** of [ID3D12Heap](./nn-d3d12-id3d12heap.md), it
    ///           may be the **GUID** of any interface. If the resource object doesn't support the interface for this **GUID**,
    ///           then creation fails with **E_NOINTERFACE**.
    ///    ppvHeap = Type: **void\*\*** An optional pointer to a memory block that receives the requested interface pointer to the
    ///              created heap object. *ppvHeap* can be `nullptr`, to enable capability testing. When *ppvHeap* is `nullptr`,
    ///              no object is created, and **S_FALSE** is returned when *pDesc* is valid.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_OUTOFMEMORY|There is
    ///    insufficient memory to create the heap.| See [Direct3D 12 return
    ///    codes](/windows/win32/direct3d12/d3d12-graphics-reference-returnvalues) for other possible return values.
    ///    
    HRESULT CreateHeap1(const(D3D12_HEAP_DESC)* pDesc, ID3D12ProtectedResourceSession pProtectedSession, 
                        const(GUID)* riid, void** ppvHeap);
    ///Creates a resource (optionally for a protected session) that is reserved, and not yet mapped to any pages in a
    ///heap. Also see [ID3D12Device::CreateReservedResource](./nf-d3d12-id3d12device-createreservedresource.md). >
    ///[!NOTE] > Only tiles from heaps created with the same protected resource session can be mapped into a protected
    ///reserved resource.
    ///Params:
    ///    pDesc = Type: **const [D3D12_RESOURCE_DESC](./ns-d3d12-d3d12_resource_desc.md)\*** A pointer to a
    ///            **D3D12_RESOURCE_DESC** structure that describes the resource.
    ///    InitialState = Type: **[D3D12_RESOURCE_STATES](./ne-d3d12-d3d12_resource_states.md)** The initial state of the resource, as
    ///                   a bitwise-OR'd combination of **D3D12_RESOURCE_STATES** enumeration constants.
    ///    pOptimizedClearValue = Type: **const [D3D12_CLEAR_VALUE](./ns-d3d12-d3d12_clear_value.md)\*** Specifies a **D3D12_CLEAR_VALUE**
    ///                           structure that describes the default value for a clear color. *pOptimizedClearValue* specifies a value for
    ///                           which clear operations are most optimal. When the created resource is a texture with either the
    ///                           [D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET](./ne-d3d12-d3d12_resource_flags.md) or
    ///                           **D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL** flags, you should choose the value with which the clear operation
    ///                           will most commonly be called. You can call the clear operation with other values, but those operations won't
    ///                           be as efficient as when the value matches the one passed in to resource creation. When you use
    ///                           [D3D12_RESOURCE_DIMENSION_BUFFER](./ne-d3d12-d3d12_resource_dimension.md), you must set
    ///                           *pOptimizedClearValue* to `nullptr`.
    ///    pProtectedSession = Type: **[ID3D12ProtectedResourceSession](./nn-d3d12-id3d12protectedresourcesession.md)\*** An optional
    ///                        pointer to an object that represents a session for content protection. If provided, this session indicates
    ///                        that the resource should be protected. You can obtain an **ID3D12ProtectedResourceSession** by calling
    ///                        [ID3D12Device4::CreateProtectedResourceSession](./nf-d3d12-id3d12device4-createprotectedresourcesession.md).
    ///    riid = Type: **REFIID** A reference to the globally unique identifier (**GUID**) of the resource interface to return
    ///           in *ppvResource*. See **Remarks**. While *riidResource* is most commonly the **GUID** of
    ///           [ID3D12Resource](./nn-d3d12-id3d12resource.md), it may be the **GUID** of any interface. If the resource
    ///           object doesn't support the interface for this **GUID**, then creation fails with **E_NOINTERFACE**.
    ///    ppvResource = Type: **void\*\*** An optional pointer to a memory block that receives the requested interface pointer to the
    ///                  created resource object. *ppvResource* can be `nullptr`, to enable capability testing. When *ppvResource* is
    ///                  `nullptr`, no object is created, and **S_FALSE** is returned when *pDesc* is valid.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_OUTOFMEMORY|There is
    ///    insufficient memory to create the resource.| See [Direct3D 12 return
    ///    codes](/windows/win32/direct3d12/d3d12-graphics-reference-returnvalues) for other possible return values.
    ///    
    HRESULT CreateReservedResource1(const(D3D12_RESOURCE_DESC)* pDesc, D3D12_RESOURCE_STATES InitialState, 
                                    const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                    ID3D12ProtectedResourceSession pProtectedSession, const(GUID)* riid, 
                                    void** ppvResource);
    ///Gets rich info about the size and alignment of memory required for a collection of resources on this adapter.
    ///Also see [ID3D12Device::GetResourceAllocationInfo](./nf-d3d12-id3d12device-getresourceallocationinfo.md). In
    ///addition to the [D3D12_RESOURCE_ALLOCATION_INFO](./ns-d3d12-d3d12_resource_allocation_info.md) returned from the
    ///method, this version also returns an array of
    ///[D3D12_RESOURCE_ALLOCATION_INFO1](./ns-d3d12-d3d12_resource_allocation_info1.md) structures, which provide
    ///additional details for each resource description passed as input. See the *pResourceAllocationInfo1* parameter.
    ///Params:
    ///    visibleMask = Type: **[UINT](/windows/win32/WinProg/windows-data-types)** For single-GPU operation, set this to zero. If
    ///                  there are multiple GPU nodes, then set bits to identify the nodes (the device's physical adapters). Each bit
    ///                  in the mask corresponds to a single node. Also see [Multi-adapter
    ///                  systems](/windows/win32/direct3d12/multi-engine).
    ///    numResourceDescs = Type: **[UINT](/windows/win32/WinProg/windows-data-types)** The number of resource descriptors in the
    ///                       *pResourceDescs* array. This is also the size (the number of elements in) *pResourceAllocationInfo1*.
    ///    pResourceDescs = Type: **const [D3D12_RESOURCE_DESC](./ns-d3d12-d3d12_resource_desc.md)\*** An array of
    ///                     **D3D12_RESOURCE_DESC** structures that described the resources to get info about.
    ///    pResourceAllocationInfo1 = Type: **[D3D12_RESOURCE_ALLOCATION_INFO1](./ns-d3d12-d3d12_resource_allocation_info1.md)\*** An array of
    ///                               [D3D12_RESOURCE_ALLOCATION_INFO1](./ns-d3d12-d3d12_resource_allocation_info1.md) structures, containing
    ///                               additional details for each resource description passed as input. This makes it simpler for your application
    ///                               to allocate a heap for multiple resources, and without manually computing offsets for where each resource
    ///                               should be placed.
    ///Returns:
    ///    Type: **[D3D12_RESOURCE_ALLOCATION_INFO](./ns-d3d12-d3d12_resource_allocation_info.md)** A
    ///    [D3D12_RESOURCE_ALLOCATION_INFO](./ns-d3d12-d3d12_resource_allocation_info.md) structure that provides info
    ///    about video memory allocated for the specified array of resources.
    ///    
    D3D12_RESOURCE_ALLOCATION_INFO GetResourceAllocationInfo1(uint visibleMask, uint numResourceDescs, 
                                                              const(D3D12_RESOURCE_DESC)* pResourceDescs, 
                                                              D3D12_RESOURCE_ALLOCATION_INFO1* pResourceAllocationInfo1);
}

///Represents an application-defined callback used for being notified of lifetime changes of an object.
@GUID("E667AF9F-CD56-4F46-83CE-032E595D70A8")
interface ID3D12LifetimeOwner : IUnknown
{
    ///Called when the lifetime state of a lifetime-tracked object changes.
    ///Params:
    ///    NewState = Type: **[D3D12_LIFETIME_STATE](./ne-d3d12-d3d12_lifetime_state.md)** The new state.
    void LifetimeStateUpdated(D3D12_LIFETIME_STATE NewState);
}

@GUID("F1DF64B6-57FD-49CD-8807-C0EB88B45C8F")
interface ID3D12SwapChainAssistant : IUnknown
{
    LUID    GetLUID();
    HRESULT GetSwapChainObject(const(GUID)* riid, void** ppv);
    HRESULT GetCurrentResourceAndCommandQueue(const(GUID)* riidResource, void** ppvResource, 
                                              const(GUID)* riidQueue, void** ppvQueue);
    HRESULT InsertImplicitSync();
}

///Represents facilities for controlling the lifetime a lifetime-tracked object.
@GUID("3FD03D36-4EB1-424A-A582-494ECB8BA813")
interface ID3D12LifetimeTracker : ID3D12DeviceChild
{
    ///Destroys a lifetime-tracked object.
    ///Params:
    ///    pObject = Type: **[ID3D12DeviceChild](./nn-d3d12-id3d12devicechild.md)\*** A pointer to an **ID3D12DeviceChild**
    ///              interface representing the lifetime-tracked object.
    ///Returns:
    ///    
    ///    
    HRESULT DestroyOwnedObject(ID3D12DeviceChild pObject);
}

///Represents a variable amount of configuration state, including shaders, that an application manages as a single unit
///and which is given to a driver atomically to process, such as compile or optimize. Create a state object by calling
///ID3D12Device5::CreateStateObject.
@GUID("47016943-FCA8-4594-93EA-AF258B55346D")
interface ID3D12StateObject : ID3D12Pageable
{
}

///Provides methods for getting and setting the properties of an
///[**ID3D12StateObject**](/windows/win32/api/d3d12/nn-d3d12-id3d12stateobject). To retrieve an instance of this type,
///call
///[**ID3D12StateObject::QueryInterface**](/windows/win32/api/unknwn/nf-unknwn-iunknown-queryinterface%28refiid_void%29)
///with the IID of **ID3D12StateObjectProperties**.
@GUID("DE5FA827-9BF9-4F26-89FF-D7F56FDE3860")
interface ID3D12StateObjectProperties : IUnknown
{
    ///Retrieves the unique identifier for a shader that can be used in a shader record.
    ///Params:
    ///    pExportName = Entrypoint in the state object for which to retrieve an identifier.
    ///Returns:
    ///    A pointer to the shader identifier. The data referenced by this pointer is valid as long as the state object
    ///    it came from is valid. The size of the data returned is D3D12_SHADER_IDENTIFIER_SIZE_IN_BYTES. Applications
    ///    should copy and cache this data to avoid the cost of searching for it in the state object if it will need to
    ///    be retrieved many times. The identifier is used in shader records within shader tables in GPU memory, which
    ///    the app must populate. The data itself globally identifies the shader, so even if the shader appears in a
    ///    different state object with same associations, like any root signatures, it will have the same identifier. If
    ///    the shader isn’t fully resolved in the state object, the return value is <b>nullptr</b>.
    ///    
    void* GetShaderIdentifier(const(PWSTR) pExportName);
    ///Gets the amount of stack memory required to invoke a raytracing shader in HLSL.
    ///Params:
    ///    pExportName = The shader entrypoint in the state object for which to retrieve stack size. For hit groups, an individual
    ///                  shader within the hit group must be specified using the syntax: hitGroupName::shaderType Where
    ///                  <i>hitGroupName</i> is the entrypoint name for the hit group and <i>shaderType</i> is one of: <ul>
    ///                  <li>intersection</li> <li>anyhit</li> <li>closesthit</li> </ul> These values are all case-sensitive. An
    ///                  example value is: "myTreeLeafHitGroup::anyhit".
    ///Returns:
    ///    Amount of stack memory, in bytes, required to invoke the shader. If the shader isn’t fully resolved in the
    ///    state object, or the shader is unknown or of a type for which a stack size isn’t relevant, such as a hit
    ///    group, the return value is 0xffffffff. The 32-bit 0xffffffff value is used for the UINT64 return value to
    ///    ensure that bad return values don’t get lost when summed up with other values as part of calculating an
    ///    overall pipeline stack size.
    ///    
    ulong GetShaderStackSize(const(PWSTR) pExportName);
    ///Gets the current pipeline stack size.
    ///Returns:
    ///    The current pipeline stack size in bytes. When called on non-executable state objects, such as collections,
    ///    the return value is 0.
    ///    
    ulong GetPipelineStackSize();
    ///Set the current pipeline stack size.
    ///Params:
    ///    PipelineStackSizeInBytes = Stack size in bytes to use during pipeline execution for each shader thread. There can be many thousands of
    ///                               threads in flight at once on the GPU. If the value is greater than 0xffffffff (the maximum value of a 32-bit
    ///                               UINT) the runtime will drop the call, and the debug layer will print an error, as this is likely the result
    ///                               of summing up invalid stack sizes returned from GetShaderStackSize called with invalid parameters, which
    ///                               return 0xffffffff. In this case, the previously set stack size, or the default, remains.
    void  SetPipelineStackSize(ulong PipelineStackSizeInBytes);
}

///Represents a virtual adapter. This interface extends [ID3D12Device4](./nn-d3d12-id3d12device4.md). > [!NOTE] > This
///interface, introduced in Windows 10, version 1809, is the latest version of the
///[ID3D12Device](./nn-d3d12-id3d12device.md) interface. Applications targeting Windows 10, version 1809 and later
///should use this interface instead of earlier versions.
@GUID("8B4F173B-2FEA-4B80-8F58-4307191AB95D")
interface ID3D12Device5 : ID3D12Device4
{
    ///Creates a lifetime tracker associated with an application-defined callback; the callback receives notifications
    ///when the lifetime of a tracked object is changed.
    ///Params:
    ///    pOwner = Type: **[ID3D12LifetimeOwner](./nn-d3d12-id3d12lifetimeowner.md)\*** A pointer to an **ID3D12LifetimeOwner**
    ///             interface representing the application-defined callback.
    ///    riid = Type: **REFIID** A reference to the interface identifier (IID) of the interface to return in *ppvTracker*.
    ///    ppvTracker = Type: **void\*\*** A pointer to a memory block that receives the requested interface pointer to the created
    ///                 object.
    ///Returns:
    ///    
    ///    
    HRESULT CreateLifetimeTracker(ID3D12LifetimeOwner pOwner, const(GUID)* riid, void** ppvTracker);
    ///You can call **RemoveDevice** to indicate to the Direct3D 12 runtime that the GPU device encountered a problem,
    ///and can no longer be used. Doing so will cause all devices' monitored fences to be signaled. Your application
    ///typically doesn't need to explicitly call **RemoveDevice**.
    void    RemoveDevice();
    ///Queries reflection metadata about available meta commands.
    ///Params:
    ///    pNumMetaCommands = Type: [in, out] <b>UINT*</b> A pointer to a UINT containing the number of meta commands to query for. This
    ///                       field determines the size of the <i>pDescs</i> array, unless <i>pDescs</i> is <b>nullptr</b>.
    ///    pDescs = Type: [out, optional] **[D3D12_META_COMMAND_DESC](./ns-d3d12-d3d12_meta_command_desc.md)\*** An optional
    ///             pointer to an array of [D3D12_META_COMMAND_DESC](./ns-d3d12-d3d12_meta_command_desc.md) containing the
    ///             descriptions of the available meta commands. Pass `nullptr` to have the number of available meta commands
    ///             returned in <i>pNumMetaCommands</i>.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If this method succeeds, it returns
    ///    <b>S_OK</b>. Otherwise, it returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT EnumerateMetaCommands(uint* pNumMetaCommands, D3D12_META_COMMAND_DESC* pDescs);
    ///Queries reflection metadata about the parameters of the specified meta command.
    ///Params:
    ///    CommandId = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the meta command whose parameters
    ///                you wish to be returned in <i>pParameterDescs</i>.
    ///    Stage = Type: <b>D3D12_META_COMMAND_PARAMETER_STAGE</b> A D3D12_META_COMMAND_PARAMETER_STAGE specifying the stage of
    ///            the parameters that you wish to be included in the query.
    ///    pTotalStructureSizeInBytes = Type: <b>UINT*</b> An optional pointer to a UINT containing the size of the structure containing the
    ///                                 parameter values, which you pass when creating/initializing/executing the meta command, as appropriate.
    ///    pParameterCount = Type: <b>UINT*</b> A pointer to a UINT containing the number of parameters to query for. This field
    ///                      determines the size of the <i>pParameterDescs</i> array, unless <i>pParameterDescs</i> is <b>nullptr</b>.
    ///    pParameterDescs = Type: <b>D3D12_META_COMMAND_PARAMETER_DESC*</b> An optional pointer to an array of
    ///                      D3D12_META_COMMAND_PARAMETER_DESC containing the descriptions of the parameters. Pass <b>nullptr</b> to have
    ///                      the parameter count returned in <i>pParameterCount</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateMetaCommandParameters(const(GUID)* CommandId, D3D12_META_COMMAND_PARAMETER_STAGE Stage, 
                                           uint* pTotalStructureSizeInBytes, uint* pParameterCount, 
                                           D3D12_META_COMMAND_PARAMETER_DESC* pParameterDescs);
    ///Creates an instance of the specified meta command.
    ///Params:
    ///    CommandId = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the meta command that you wish to
    ///                instantiate.
    ///    NodeMask = Type: <b>UINT</b> For single-adapter operation, set this to zero. If there are multiple adapter nodes, set a
    ///               bit to identify the node (one of the device's physical adapters) to which the meta command applies. Each bit
    ///               in the mask corresponds to a single node. Only one bit must be set. See Multi-adapter systems.
    ///    pCreationParametersData = Type: <b>const void*</b> An optional pointer to a constant structure containing the values of the parameters
    ///                              for creating the meta command.
    ///    CreationParametersDataSizeInBytes = Type: <b>SIZE_T</b> A SIZE_T containing the size of the structure pointed to by
    ///                                        <i>pCreationParametersData</i>, if set, otherwise 0.
    ///    riid = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the interface that you wish to be
    ///           returned in <i>ppMetaCommand</i>. This is expected to be the GUID of ID3D12MetaCommand.
    ///    ppMetaCommand = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the meta command. This is the
    ///                    address of a pointer to an ID3D12MetaCommand, representing the meta command created.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b>
    ///    error code. <table> <tr> <th>Return value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt>DXGI_ERROR_UNSUPPORTED</dt> </dl> </td> <td width="60%"> The current hardware does not support the
    ///    algorithm being requested </td> </tr> </table>
    ///    
    HRESULT CreateMetaCommand(const(GUID)* CommandId, uint NodeMask, const(void)* pCreationParametersData, 
                              size_t CreationParametersDataSizeInBytes, const(GUID)* riid, void** ppMetaCommand);
    ///Creates an [ID3D12StateObject](/windows/win32/api/d3d12/nn-d3d12-id3d12stateobject).
    ///Params:
    ///    pDesc = The description of the state object to create.
    ///    riid = The GUID of the interface to create. Use <i>__uuidof(ID3D12StateObject)</i>.
    ///    ppStateObject = The returned state object.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, returns one of the following values: <ul> <li>E_INVALIDARG if one of
    ///    the input parameters is invalid.</li> <li>E_OUTOFMEMORY if sufficient memory is not available to create the
    ///    handle.</li> <li>Possibly other error codes that are described in the Direct3D 12 Return Codes topic. </li>
    ///    </ul>
    ///    
    HRESULT CreateStateObject(const(D3D12_STATE_OBJECT_DESC)* pDesc, const(GUID)* riid, void** ppStateObject);
    ///Query the driver for resource requirements to build an acceleration structure.
    ///Params:
    ///    pDesc = Description of the acceleration structure build. This structure is shared with
    ///            BuildRaytracingAccelerationStructure. For more information, see
    ///            D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS. The implementation is allowed to look at all the CPU
    ///            parameters in this struct and nested structs. It may not inspect/dereference any GPU virtual addresses, other
    ///            than to check to see if a pointer is NULL or not, such as the optional transform in
    ///            D3D12_RAYTRACING_GEOMETRY_TRIANGLES_DESC, without dereferencing it. In other words, the calculation of
    ///            resource requirements for the acceleration structure does not depend on the actual geometry data (such as
    ///            vertex positions), rather it can only depend on overall properties, such as the number of triangles, number
    ///            of instances etc.
    ///    pInfo = The result of the query.
    void    GetRaytracingAccelerationStructurePrebuildInfo(const(D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS)* pDesc, 
                                                           D3D12_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO* pInfo);
    ///Reports the compatibility of serialized data, such as a serialized raytracing acceleration structure resulting
    ///from a call to CopyRaytracingAccelerationStructure with mode
    ///D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE_SERIALIZE, with the current device/driver.
    ///Params:
    ///    SerializedDataType = The type of the serialized data. For more information, see D3D12_SERIALIZED_DATA_TYPE.
    ///    pIdentifierToCheck = Identifier from the header of the serialized data to check with the driver. For more information, see
    ///                         D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER.
    ///Returns:
    ///    The returned compatibility status. For more information, see D3D12_DRIVER_MATCHING_IDENTIFIER_STATUS.
    ///    
    D3D12_DRIVER_MATCHING_IDENTIFIER_STATUS CheckDriverMatchingIdentifier(D3D12_SERIALIZED_DATA_TYPE SerializedDataType, 
                                                                          const(D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER)* pIdentifierToCheck);
}

///This interface controls Device Removed Extended Data (DRED) settings. You should configure all DRED settings before
///you create a Direct3D 12 device. To retrieve the **ID3D12DeviceRemovedExtendedDataSettings** interface, call
///[D3D12GetDebugInterface](/windows/desktop/api/d3d12/nf-d3d12-d3d12getdebuginterface), passing the interface
///identifier (IID) of **ID3D12DeviceRemovedExtendedDataSettings**.
@GUID("82BC481C-6B9B-4030-AEDB-7EE3D1DF1E63")
interface ID3D12DeviceRemovedExtendedDataSettings : IUnknown
{
    ///Configures the enablement settings for Device Removed Extended Data (DRED) auto-breadcrumbs.
    ///Params:
    ///    Enablement = A [D3D12_DRED_ENABLEMENT](ne-d3d12-d3d12_dred_enablement.md) value. The default is
    ///                 **D3D12_DRED_ENABLEMENT_SYSTEM_CONTROLLED**.
    void SetAutoBreadcrumbsEnablement(D3D12_DRED_ENABLEMENT Enablement);
    ///Configures the enablement settings for Device Removed Extended Data (DRED) page fault reporting.
    ///Params:
    ///    Enablement = A [D3D12_DRED_ENABLEMENT](ne-d3d12-d3d12_dred_enablement.md) value. The default is
    ///                 **D3D12_DRED_ENABLEMENT_SYSTEM_CONTROLLED**.
    void SetPageFaultEnablement(D3D12_DRED_ENABLEMENT Enablement);
    ///Configures the enablement settings for Device Removed Extended Data (DRED) dump creation for [Windows Error
    ///Reporting (WER)](/windows/desktop/wer/windows-error-reporting), also known as Watson.
    ///Params:
    ///    Enablement = A [D3D12_DRED_ENABLEMENT](ne-d3d12-d3d12_dred_enablement.md) value. The default is
    ///                 **D3D12_DRED_ENABLEMENT_SYSTEM_CONTROLLED**.
    void SetWatsonDumpEnablement(D3D12_DRED_ENABLEMENT Enablement);
}

@GUID("DBD5AE51-3317-4F0A-ADF9-1D7CEDCAAE0B")
interface ID3D12DeviceRemovedExtendedDataSettings1 : ID3D12DeviceRemovedExtendedDataSettings
{
    void SetBreadcrumbContextEnablement(D3D12_DRED_ENABLEMENT Enablement);
}

///Provides runtime access to Device Removed Extended Data (DRED) data. To retrieve the
///**ID3D12DeviceRemovedExtendedData** interface, call
///[QueryInterface](/windows/desktop/api/unknwn/nf-unknwn-iunknown-queryinterface(refiid_void)) on an
///[ID3D12Device](nn-d3d12-id3d12device.md) (or derived) interface, passing the interface identifier (IID) of
///**ID3D12DeviceRemovedExtendedData**.
@GUID("98931D33-5AE8-4791-AA3C-1A73A2934E71")
interface ID3D12DeviceRemovedExtendedData : IUnknown
{
    ///Retrieves the Device Removed Extended Data (DRED) auto-breadcrumbs output after device removal.
    ///Params:
    ///    pOutput = An output parameter that takes the address of a
    ///              [D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT](ns-d3d12-d3d12_dred_auto_breadcrumbs_output.md) object. The object whose
    ///              address is passed receives the data.
    ///Returns:
    ///    If the function succeeds, it returns **S_OK**. Otherwise, it returns an
    ///    [HRESULT](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/desktop/com/com-error-codes-10). Returns **DXGI_ERROR_NOT_CURRENTLY_AVAILABLE** if the device
    ///    is *not* in a removed state. Returns **DXGI_ERROR_UNSUPPORTED** if auto-breadcrumbs have not been enabled
    ///    with
    ///    [ID3D12DeviceRemovedExtendedDataSettings::SetAutoBreadcrumbsEnablement](nf-d3d12-id3d12deviceremovedextendeddatasettings-setautobreadcrumbsenablement.md).
    ///    
    HRESULT GetAutoBreadcrumbsOutput(D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT* pOutput);
    ///Retrieves the Device Removed Extended Data (DRED) page fault data, including matching allocation for both living
    ///and recently-deleted runtime objects. The object whose address is passed receives the data.
    ///Params:
    ///    pOutput = An output parameter that takes the address of a
    ///              [D3D12_DRED_PAGE_FAULT_OUTPUT](ns-d3d12-d3d12_dred_page_fault_output.md) object.
    ///Returns:
    ///    If the function succeeds, it returns **S_OK**. Otherwise, it returns an
    ///    [HRESULT](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/desktop/com/com-error-codes-10). Returns **DXGI_ERROR_NOT_CURRENTLY_AVAILABLE** if the device
    ///    is *not* in a removed state. Returns **DXGI_ERROR_UNSUPPORTED** if page fault reporting has not been enabled
    ///    with
    ///    [ID3D12DeviceRemovedExtendedDataSettings::SetPageFaultEnablement](nf-d3d12-id3d12deviceremovedextendeddatasettings-setpagefaultenablement.md).
    ///    
    HRESULT GetPageFaultAllocationOutput(D3D12_DRED_PAGE_FAULT_OUTPUT* pOutput);
}

@GUID("9727A022-CF1D-4DDA-9EBA-EFFA653FC506")
interface ID3D12DeviceRemovedExtendedData1 : ID3D12DeviceRemovedExtendedData
{
    HRESULT GetAutoBreadcrumbsOutput1(D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1* pOutput);
    HRESULT GetPageFaultAllocationOutput1(D3D12_DRED_PAGE_FAULT_OUTPUT1* pOutput);
}

///Represents a virtual adapter. This interface extends [ID3D12Device5](./nn-d3d12-id3d12device5.md).
@GUID("C70B221B-40E4-4A17-89AF-025A0727A6DC")
interface ID3D12Device6 : ID3D12Device5
{
    ///Sets the mode for driver background processing optimizations.
    ///Params:
    ///    Mode = Type: **[D3D12_BACKGROUND_PROCESSING_MODE](./ne-d3d12-d3d12_background_processing_mode.md)** The level of
    ///           dynamic optimization to apply to GPU work that's subsequently submitted.
    ///    MeasurementsAction = Type: **[D3D12_MEASUREMENTS_ACTION](./ne-d3d12-d3d12_measurements_action.md)** The action to take with the
    ///                         results of earlier workload instrumentation.
    ///    hEventToSignalUponCompletion = Type: **[HANDLE](/windows/win32/winprog/windows-data-types)** An optional handle to signal when the function
    ///                                   is complete. For example, if *MeasurementsAction* is set to
    ///                                   [D3D12_MEASUREMENTS_ACTION_COMMIT_RESULTS](./ne-d3d12-d3d12_measurements_action.md), then
    ///                                   *hEventToSignalUponCompletion* is signaled when all resulting compilations have finished.
    ///    pbFurtherMeasurementsDesired = Type: **[BOOL](/windows/win32/winprog/windows-data-types)\*** An optional pointer to a Boolean value. The
    ///                                   function sets the value to `true` to indicate that you should continue profiling, otherwise, `false`.
    ///Returns:
    ///    
    ///    
    HRESULT SetBackgroundProcessingMode(D3D12_BACKGROUND_PROCESSING_MODE Mode, 
                                        D3D12_MEASUREMENTS_ACTION MeasurementsAction, 
                                        HANDLE hEventToSignalUponCompletion, BOOL* pbFurtherMeasurementsDesired);
}

///Monitors the validity of a protected resource session. This interface extends
///[ID3D12ProtectedSession](./nn-d3d12-id3d12protectedsession.md). You can obtain an **ID3D12ProtectedResourceSession1**
///by calling
///[ID3D12Device7::CreateProtectedResourceSession1](./nf-d3d12-id3d12device7-createprotectedresourcesession1.md).
@GUID("D6F12DD6-76FB-406E-8961-4296EEFC0409")
interface ID3D12ProtectedResourceSession1 : ID3D12ProtectedResourceSession
{
    ///Retrieves a description of the protected resource session.
    ///Returns:
    ///    A [D3D12_PROTECTED_RESOURCE_SESSION_DESC1](./ns-d3d12-d3d12_protected_resource_session_desc1.md) that
    ///    describes the protected resource session.
    ///    
    D3D12_PROTECTED_RESOURCE_SESSION_DESC1 GetDesc1();
}

///Represents a virtual adapter. This interface extends [ID3D12Device6](./nn-d3d12-id3d12device6.md).
@GUID("5C014B53-68A1-4B9B-8BD1-DD6046B9358B")
interface ID3D12Device7 : ID3D12Device6
{
    ///Incrementally add to an existing state object. This incurs lower CPU overhead than creating a state object from
    ///scratch that is a superset of an existing one (for example, adding a few more shaders).
    ///Params:
    ///    pAddition = Type: \_In\_ **const [D3D12_STATE_OBJECT_DESC](./ns-d3d12-d3d12_state_object_desc.md)\*** Description of
    ///                state object contents to add to existing state object. To help generate this see the
    ///                **CD3D12_STATE_OBJECT_DESC** helper in class in `d3dx12.h`.
    ///    pStateObjectToGrowFrom = Type: \_In\_ **[ID3D12StateObject](./nn-d3d12-id3d12stateobject.md)\*** Existing state object, which can be
    ///                             in use (for example, active raytracing) during this operation. The existing state object must not be of type
    ///                             **Collection**.
    ///    riid = Type: \_In\_ **REFIID** Must be the IID of the [ID3D12StateObject](./nn-d3d12-id3d12stateobject.md)
    ///           interface.
    ///    ppNewStateObject = Type: \_COM\_Outptr\_ **void\*\*** Returned state object. Behavior is undefined if shader identifiers are
    ///                       retrieved for new shaders from this call and they are accessed via shader tables by any already existing or
    ///                       in-flight command list that references some older state object. Use of the new shaders added to the state
    ///                       object can occur only from commands (such as **DispatchRays** or **ExecuteIndirect** calls) recorded in a
    ///                       command list after the call to **AddToStateObject**.
    ///Returns:
    ///    **S_OK** for success. **E_INVALIDARG**, **E_OUTOFMEMORY** on failure. The debug layer provides detailed
    ///    status information.
    ///    
    HRESULT AddToStateObject(const(D3D12_STATE_OBJECT_DESC)* pAddition, ID3D12StateObject pStateObjectToGrowFrom, 
                             const(GUID)* riid, void** ppNewStateObject);
    ///**CreateProtectedResourceSession1** revises the
    ///[**ID3D12Device4::CreateProtectedResourceSession**](./nf-d3d12-id3d12device4-createprotectedresourcesession.md)
    ///method with provision (in the structure passed via the *pDesc* parameter) for a globally unique identifier
    ///(**GUID**) that indicates the type of protected resource session. Calling
    ///**ID3D12Device4::CreateProtectedResourceSession** is equivalent to calling
    ///**ID3D12Device7::CreateProtectedResourceSession1** with the
    ///**D3D12_PROTECTED_RESOURCES_SESSION_HARDWARE_PROTECTED** GUID.
    ///Params:
    ///    pDesc = Type: \_In\_ **const
    ///            [D3D12_PROTECTED_RESOURCE_SESSION_DESC1](./ns-d3d12-d3d12_protected_resource_session_desc1.md)\*** A pointer
    ///            to a constant **D3D12_PROTECTED_RESOURCE_SESSION_DESC1** structure, describing the session to create.
    ///    riid = Type: \_In\_ **REFIID** The GUID of the interface to a protected session. Most commonly,
    ///           [ID3D12ProtectedResourceSession1](./nn-d3d12-id3d12protectedresourcesession1.md), although it may be any
    ///           **GUID** for any interface. If the protected session object doesn't support the interface for this **GUID**,
    ///           the getter will return **E_NOINTERFACE**.
    ///    ppSession = Type: \_COM\_Outptr\_ **void\*\*** A pointer to a memory block that receives a pointer to the session for the
    ///                given protected session (the specific interface type returned depends on *riid*).
    ///Returns:
    ///    
    ///    
    HRESULT CreateProtectedResourceSession1(const(D3D12_PROTECTED_RESOURCE_SESSION_DESC1)* pDesc, 
                                            const(GUID)* riid, void** ppSession);
}

///Represents a virtual adapter. This interface extends [ID3D12Device7](./nn-d3d12-id3d12device7.md).
@GUID("9218E6BB-F944-4F7E-A75C-B1B2C7B701F3")
interface ID3D12Device8 : ID3D12Device7
{
    ///Gets rich info about the size and alignment of memory required for a collection of resources on this adapter.
    ///Also see [ID3D12Device4::GetResourceAllocationInfo1](./nf-d3d12-id3d12device4-getresourceallocationinfo1.md).
    ///This version also returns an array of [D3D12_RESOURCE_DESC1](./ns-d3d12-d3d12_resource_desc1.md) structures.
    ///Params:
    ///    visibleMask = Type: **[UINT](/windows/win32/WinProg/windows-data-types)** For single-GPU operation, set this to zero. If
    ///                  there are multiple GPU nodes, then set bits to identify the nodes (the device's physical adapters). Each bit
    ///                  in the mask corresponds to a single node. Also see [Multi-adapter
    ///                  systems](/windows/win32/direct3d12/multi-engine).
    ///    numResourceDescs = Type: **[UINT](/windows/win32/WinProg/windows-data-types)** The number of resource descriptors in the
    ///                       *pResourceDescs* array. This is also the size (the number of elements in) *pResourceAllocationInfo1*.
    ///    pResourceDescs = Type: **const [D3D12_RESOURCE_DESC1](./ns-d3d12-d3d12_resource_desc1.md)\*** An array of
    ///                     **D3D12_RESOURCE_DESC1** structures that described the resources to get info about.
    ///    pResourceAllocationInfo1 = Type: **[D3D12_RESOURCE_ALLOCATION_INFO1](./ns-d3d12-d3d12_resource_allocation_info1.md)\*** An array of
    ///                               [D3D12_RESOURCE_ALLOCATION_INFO1](./ns-d3d12-d3d12_resource_allocation_info1.md) structures, containing
    ///                               additional details for each resource description passed as input. This makes it simpler for your application
    ///                               to allocate a heap for multiple resources, and without manually computing offsets for where each resource
    ///                               should be placed.
    ///Returns:
    ///    Type: **[D3D12_RESOURCE_ALLOCATION_INFO](./ns-d3d12-d3d12_resource_allocation_info.md)** A
    ///    [D3D12_RESOURCE_ALLOCATION_INFO](./ns-d3d12-d3d12_resource_allocation_info.md) structure that provides info
    ///    about video memory allocated for the specified array of resources.
    ///    
    D3D12_RESOURCE_ALLOCATION_INFO GetResourceAllocationInfo2(uint visibleMask, uint numResourceDescs, 
                                                              const(D3D12_RESOURCE_DESC1)* pResourceDescs, 
                                                              D3D12_RESOURCE_ALLOCATION_INFO1* pResourceAllocationInfo1);
    ///Creates both a resource and an implicit heap (optionally for a protected session), such that the heap is big
    ///enough to contain the entire resource, and the resource is mapped to the heap. Also see
    ///[ID3D12Device::CreateCommittedResource](/windows/win32/api/d3d12/nf-d3d12-id3d12device-createcommittedresource)
    ///for a code example.
    ///Params:
    ///    pHeapProperties = Type: \_In\_ **const [D3D12_HEAP_PROPERTIES](/windows/win32/api/d3d12/ns-d3d12-d3d12_heap_properties)\*** A
    ///                      pointer to a **D3D12_HEAP_PROPERTIES** structure that provides properties for the resource's heap.
    ///    HeapFlags = Type: **[D3D12_HEAP_FLAGS](/windows/win32/api/d3d12/ne-d3d12-d3d12_heap_flags)** Heap options, as a
    ///                bitwise-OR'd combination of **D3D12_HEAP_FLAGS** enumeration constants.
    ///    pDesc = _In_ const D3D12_RESOURCE_DESC1 *pDesc, Type: **const
    ///            [D3D12_RESOURCE_DESC1](/windows/win32/api/d3d12/ns-d3d12-d3d12_resource_desc1)\*** A pointer to a
    ///            **D3D12_RESOURCE_DESC1** structure that describes the resource, including a mip region.
    ///    InitialResourceState = Type: **[D3D12_RESOURCE_STATES](/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_states)** The initial state
    ///                           of the resource, as a bitwise-OR'd combination of **D3D12_RESOURCE_STATES** enumeration constants. When you
    ///                           create a resource together with a [D3D12_HEAP_TYPE_UPLOAD](/windows/win32/api/d3d12/ne-d3d12-d3d12_heap_type)
    ///                           heap, you must set *InitialResourceState* to
    ///                           [D3D12_RESOURCE_STATE_GENERIC_READ](/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_states). When you create
    ///                           a resource together with a [D3D12_HEAP_TYPE_READBACK](/windows/win32/api/d3d12/ne-d3d12-d3d12_heap_type)
    ///                           heap, you must set *InitialResourceState* to
    ///                           [D3D12_RESOURCE_STATE_COPY_DEST](/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_states).
    ///    pOptimizedClearValue = Type: **const [D3D12_CLEAR_VALUE](/windows/win32/api/d3d12/ns-d3d12-d3d12_clear_value)\*** Specifies a
    ///                           **D3D12_CLEAR_VALUE** structure that describes the default value for a clear color. *pOptimizedClearValue*
    ///                           specifies a value for which clear operations are most optimal. When the created resource is a texture with
    ///                           either the [D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET](/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_flags)
    ///                           or **D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL** flags, you should choose the value with which the clear
    ///                           operation will most commonly be called. You can call the clear operation with other values, but those
    ///                           operations won't be as efficient as when the value matches the one passed in to resource creation. When you
    ///                           use [D3D12_RESOURCE_DIMENSION_BUFFER](/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_dimension), you must
    ///                           set *pOptimizedClearValue* to `nullptr`.
    ///    pProtectedSession = Type:
    ///                        **[ID3D12ProtectedResourceSession](/windows/win32/api/d3d12/nn-d3d12-id3d12protectedresourcesession)\*** An
    ///                        optional pointer to an object that represents a session for content protection. If provided, this session
    ///                        indicates that the resource should be protected. You can obtain an **ID3D12ProtectedResourceSession** by
    ///                        calling
    ///                        [ID3D12Device4::CreateProtectedResourceSession](/windows/win32/api/d3d12/nf-d3d12-id3d12device4-createprotectedresourcesession).
    ///    riidResource = Type: **REFIID** A reference to the globally unique identifier (**GUID**) of the resource interface to return
    ///                   in *ppvResource*. While *riidResource* is most commonly the **GUID** of
    ///                   [ID3D12Resource](/windows/win32/api/d3d12/nn-d3d12-id3d12resource), it may be the **GUID** of any interface.
    ///                   If the resource object doesn't support the interface for this **GUID**, then creation fails with
    ///                   **E_NOINTERFACE**.
    ///    ppvResource = Type: **void\*\*** An optional pointer to a memory block that receives the requested interface pointer to the
    ///                  created resource object. *ppvResource* can be `nullptr`, to enable capability testing. When *ppvResource* is
    ///                  `nullptr`, no object is created, and **S_FALSE** is returned when *pDesc* is valid.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_OUTOFMEMORY|There is
    ///    insufficient memory to create the resource.| See [Direct3D 12 return
    ///    codes](/windows/win32/direct3d12/d3d12-graphics-reference-returnvalues) for other possible return values.
    ///    
    HRESULT CreateCommittedResource2(const(D3D12_HEAP_PROPERTIES)* pHeapProperties, D3D12_HEAP_FLAGS HeapFlags, 
                                     const(D3D12_RESOURCE_DESC1)* pDesc, D3D12_RESOURCE_STATES InitialResourceState, 
                                     const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                     ID3D12ProtectedResourceSession pProtectedSession, const(GUID)* riidResource, 
                                     void** ppvResource);
    ///Creates a resource that is placed in a specific heap. Placed resources are the lightest weight resource objects
    ///available, and are the fastest to create and destroy. Your application can re-use video memory by overlapping
    ///multiple Direct3D placed and reserved resources on heap regions. The simple memory re-use model (described in
    ///[Remarks](#remarks)) exists to clarify which overlapping resource is valid at any given time. To maximize
    ///graphics tool support, with the simple model data-inheritance isn't supported; and finer-grained tile and
    ///sub-resource invalidation isn't supported. Only full overlapping resource invalidation occurs.
    ///Params:
    ///    pHeap = Type: [in] **ID3D12Heap*** A pointer to the **ID3D12Heap** interface that represents the heap in which the
    ///            resource is placed.
    ///    HeapOffset = Type: **UINT64** The offset, in bytes, to the resource. The *HeapOffset* must be a multiple of the resource's
    ///                 alignment, and *HeapOffset* plus the resource size must be smaller than or equal to the heap size.
    ///                 **GetResourceAllocationInfo** must be used to understand the sizes of texture resources.
    ///    pDesc = Type: [in] **const D3D12_RESOURCE_DESC1*** A pointer to a **D3D12_RESOURCE_DESC1** structure that describes
    ///            the resource, including a mip region.
    ///    InitialState = Type: **D3D12_RESOURCE_STATES** The initial state of the resource, as a bitwise-OR'd combination of
    ///                   **D3D12_RESOURCE_STATES** enumeration constants. When a resource is created together with a
    ///                   **D3D12_HEAP_TYPE_UPLOAD** heap, *InitialState* must be **D3D12_RESOURCE_STATE_GENERIC_READ**. When a
    ///                   resource is created together with a **D3D12_HEAP_TYPE_READBACK** heap, *InitialState* must be
    ///                   **D3D12_RESOURCE_STATE_COPY_DEST**.
    ///    pOptimizedClearValue = Type: [in, optional] **const D3D12_CLEAR_VALUE*** Specifies a **D3D12_CLEAR_VALUE** that describes the
    ///                           default value for a clear color. *pOptimizedClearValue* specifies a value for which clear operations are most
    ///                           optimal. When the created resource is a texture with either the **D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET**
    ///                           or **D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL** flags, your application should choose the value that the clear
    ///                           operation will most commonly be called with. Clear operations can be called with other values, but those
    ///                           operations will not be as efficient as when the value matches the one passed into resource creation.
    ///                           *pOptimizedClearValue* must be NULL when used with **D3D12_RESOURCE_DIMENSION_BUFFER**.
    ///    riid = Type: **REFIID** The globally unique identifier (**GUID**) for the resource interface. This is an input
    ///           parameter. The **REFIID**, or **GUID**, of the interface to the resource can be obtained by using the
    ///           `__uuidof` macro. For example, `__uuidof(ID3D12Resource)` gets the **GUID** of the interface to a resource.
    ///           Although **riid** is, most commonly, the GUID for **ID3D12Resource**, it may be any **GUID** for any
    ///           interface. If the resource object doesn't support the interface for this **GUID**, then creation fails with
    ///           **E_NOINTERFACE**.
    ///    ppvResource = Type: [out, optional] **void**** A pointer to a memory block that receives a pointer to the resource.
    ///                  *ppvResource* can be NULL, to enable capability testing. When *ppvResource* is NULL, no object will be
    ///                  created and S_FALSE will be returned when *pResourceDesc* and other parameters are valid.
    ///Returns:
    ///    Type: **HRESULT** This method returns **E_OUTOFMEMORY** if there is insufficient memory to create the
    ///    resource. See Direct3D 12 Return Codes for other possible return values.
    ///    
    HRESULT CreatePlacedResource1(ID3D12Heap pHeap, ulong HeapOffset, const(D3D12_RESOURCE_DESC1)* pDesc, 
                                  D3D12_RESOURCE_STATES InitialState, const(D3D12_CLEAR_VALUE)* pOptimizedClearValue, 
                                  const(GUID)* riid, void** ppvResource);
    ///For purposes of sampler feedback, creates a descriptor suitable for binding.
    ///Params:
    ///    pTargetedResource = Type: \_In\_opt\_ **[ID3D12Resource](./nn-d3d12-id3d12heap.md)\*** The targeted resource, such as a texture,
    ///                        to create a descriptor for.
    ///    pFeedbackResource = Type: \_In\_opt\_ **[ID3D12Resource](./nn-d3d12-id3d12heap.md)\*** The feedback resource, such as a texture,
    ///                        to create a descriptor for.
    ///    DestDescriptor = Type: \_In\_ **[D3D12_CPU_DESCRIPTOR_HANDLE](./ns-d3d12-d3d12_cpu_descriptor_handle.md)** The CPU descriptor
    ///                     handle.
    void    CreateSamplerFeedbackUnorderedAccessView(ID3D12Resource pTargetedResource, 
                                                     ID3D12Resource pFeedbackResource, 
                                                     D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    ///Gets a resource layout that can be copied. Helps your app fill in
    ///[D3D12_PLACED_SUBRESOURCE_FOOTPRINT](./ns-d3d12-d3d12_placed_subresource_footprint.md) and
    ///[D3D12_SUBRESOURCE_FOOTPRINT](./ns-d3d12-d3d12_subresource_footprint.md) when suballocating space in upload
    ///heaps.
    ///Params:
    ///    pResourceDesc = Type: <b>const D3D12_RESOURCE_DESC1*</b> A description of the resource, as a pointer to a
    ///                    **D3D12_RESOURCE_DESC1** structure.
    ///    FirstSubresource = Type: [in] <b>UINT</b> Index of the first subresource in the resource. The range of valid values is 0 to
    ///                       D3D12_REQ_SUBRESOURCES.
    ///    NumSubresources = Type: [in] <b>UINT</b> The number of subresources in the resource. The range of valid values is 0 to
    ///                      (D3D12_REQ_SUBRESOURCES - <i>FirstSubresource</i>).
    ///    BaseOffset = Type: <b>UINT64</b> The offset, in bytes, to the resource.
    ///    pLayouts = Type: [out, optional] <b>D3D12_PLACED_SUBRESOURCE_FOOTPRINT*</b> A pointer to an array (of length
    ///               <i>NumSubresources</i>) of D3D12_PLACED_SUBRESOURCE_FOOTPRINT structures, to be filled with the description
    ///               and placement of each subresource.
    ///    pNumRows = Type: [out, optional] <b>UINT*</b> A pointer to an array (of length <i>NumSubresources</i>) of integer
    ///               variables, to be filled with the number of rows for each subresource.
    ///    pRowSizeInBytes = Type: [out, optional] <b>UINT64*</b> A pointer to an array (of length <i>NumSubresources</i>) of integer
    ///                      variables, each entry to be filled with the unpadded size in bytes of a row, of each subresource. For
    ///                      example, if a Texture2D resource has a width of 32 and bytes per pixel of 4, then <i>pRowSizeInBytes</i>
    ///                      returns 128. <i>pRowSizeInBytes</i> should not be confused with <b>row pitch</b>, as examining
    ///                      <i>pLayouts</i> and getting the row pitch from that will give you 256 as it is aligned to
    ///                      D3D12_TEXTURE_DATA_PITCH_ALIGNMENT.
    ///    pTotalBytes = Type: [out, optional] <b>UINT64*</b> A pointer to an integer variable, to be filled with the total size, in
    ///                  bytes.
    void    GetCopyableFootprints1(const(D3D12_RESOURCE_DESC1)* pResourceDesc, uint FirstSubresource, 
                                   uint NumSubresources, ulong BaseOffset, 
                                   D3D12_PLACED_SUBRESOURCE_FOOTPRINT* pLayouts, uint* pNumRows, 
                                   ulong* pRowSizeInBytes, ulong* pTotalBytes);
}

@GUID("9D5E227A-4430-4161-88B3-3ECA6BB16E19")
interface ID3D12Resource1 : ID3D12Resource
{
    HRESULT GetProtectedResourceSession(const(GUID)* riid, void** ppProtectedSession);
}

@GUID("BE36EC3B-EA85-4AEB-A45A-E9D76404A495")
interface ID3D12Resource2 : ID3D12Resource1
{
    D3D12_RESOURCE_DESC1 GetDesc1();
}

@GUID("572F7389-2168-49E3-9693-D6DF5871BF6D")
interface ID3D12Heap1 : ID3D12Heap
{
    HRESULT GetProtectedResourceSession(const(GUID)* riid, void** ppProtectedSession);
}

///Encapsulates a list of graphics commands for rendering.
@GUID("6FDA83A7-B84C-4E38-9AC8-C7BD22016B3D")
interface ID3D12GraphicsCommandList3 : ID3D12GraphicsCommandList2
{
    ///Specifies whether or not protected resources can be accessed by subsequent commands in the command list. By
    ///default, no protected resources are enabled. After calling <b>SetProtectedResourceSession</b> with a valid
    ///session, protected resources of the same type can refer to that session. After calling
    ///<b>SetProtectedResourceSession</b> with <b>NULL</b>, no protected resources can be accessed.
    ///Params:
    ///    pProtectedResourceSession = Type: **[ID3D12ProtectedResourceSession](./nn-d3d12-id3d12protectedresourcesession.md)\*** An optional
    ///                                pointer to an **ID3D12ProtectedResourceSession**. You can obtain an **ID3D12ProtectedResourceSession** by
    ///                                calling
    ///                                [ID3D12Device4::CreateProtectedResourceSession](./nf-d3d12-id3d12device4-createprotectedresourcesession.md).
    ///Returns:
    ///    If set, indicates that protected resources can be accessed with the given session. Access to protected
    ///    resources can only happen after <b>SetProtectedResourceSession</b> is called with a valid session. The
    ///    command list state is cleared when calling this method. If you pass <b>NULL</b>, then no protected resources
    ///    can be accessed.
    ///    
    void SetProtectedResourceSession(ID3D12ProtectedResourceSession pProtectedResourceSession);
}

///Represents a meta command. A meta command is a Direct3D 12 object representing an algorithm that is accelerated by
///independent hardware vendors (IHVs). It's an opaque reference to a command generator that is implemented by the
///driver. The lifetime of a meta command is tied to the lifetime of the command list that references it. So, you should
///only free a meta command if no command list referencing it is currently executing on the GPU. A meta command can
///encapsulate a set of pipeline state objects (PSOs), bindings, intermediate resource states, and Draw/Dispatch calls.
///You can think of the signature of a meta command as being similar to a C-style function, with multiple in/out
///parameters, and no return value.
@GUID("DBB84C27-36CE-4FC9-B801-F048C46AC570")
interface ID3D12MetaCommand : ID3D12Pageable
{
    ///Retrieves the amount of memory required for the specified runtime parameter resource for a meta command, for the
    ///specified stage.
    ///Params:
    ///    Stage = Type: <b>D3D12_META_COMMAND_PARAMETER_STAGE</b> A <b>D3D12_META_COMMAND_PARAMETER_STAGE</b> specifying the
    ///            stage to which the parameter belongs.
    ///    ParameterIndex = Type: <b>UINT</b> The zero-based index of the parameter within the stage.
    ///Returns:
    ///    Type: <b>UINT64</b> The number of bytes required for the specified runtime parameter resource.
    ///    
    ulong GetRequiredParameterResourceSize(D3D12_META_COMMAND_PARAMETER_STAGE Stage, uint ParameterIndex);
}

///Encapsulates a list of graphics commands for rendering, extending the interface to support ray tracing and render
///passes.
@GUID("8754318E-D3A9-4541-98CF-645B50DC4874")
interface ID3D12GraphicsCommandList4 : ID3D12GraphicsCommandList3
{
    ///Marks the beginning of a render pass by binding a set of output resources for the duration of the render pass.
    ///These bindings are to one or more render target views (RTVs), and/or to a depth stencil view (DSV).
    ///Params:
    ///    NumRenderTargets = A <b>UINT</b>. The number of render targets being bound.
    ///    pRenderTargets = A pointer to a constant D3D12_RENDER_PASS_RENDER_TARGET_DESC, which describes bindings (fixed for the
    ///                     duration of the render pass) to one or more render target views (RTVs), as well as their beginning and ending
    ///                     access characteristics.
    ///    pDepthStencil = A pointer to a constant D3D12_RENDER_PASS_DEPTH_STENCIL_DESC, which describes a binding (fixed for the
    ///                    duration of the render pass) to a depth stencil view (DSV), as well as its beginning and ending access
    ///                    characteristics.
    ///    Flags = A D3D12_RENDER_PASS_FLAGS. The nature/requirements of the render pass; for example, whether it is a
    ///            suspending or a resuming render pass, or whether it wants to write to unordered access view(s).
    void BeginRenderPass(uint NumRenderTargets, const(D3D12_RENDER_PASS_RENDER_TARGET_DESC)* pRenderTargets, 
                         const(D3D12_RENDER_PASS_DEPTH_STENCIL_DESC)* pDepthStencil, D3D12_RENDER_PASS_FLAGS Flags);
    ///Marks the ending of a render pass.
    void EndRenderPass();
    ///Initializes the specified meta command. You must initialize a meta command at least once prior (on the GPU's
    ///timeline) to executing it. Initializing gives the implementation the chance to perform any work necessary to
    ///accelerate the invocation of the meta command. You must supply the sufficient resource parameters, including the
    ///persistent cache resource.
    ///Params:
    ///    pMetaCommand = A pointer to an ID3D12MetaCommand representing the meta command to initialize.
    ///    pInitializationParametersData = An optional pointer to a constant structure containing the values of the parameters for initializing the meta
    ///                                    command.
    ///    InitializationParametersDataSizeInBytes = A SIZE_T containing the size of the structure pointed to by <i>pInitializationParametersData</i>, if set,
    ///                                              otherwise 0.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    void InitializeMetaCommand(ID3D12MetaCommand pMetaCommand, const(void)* pInitializationParametersData, 
                               size_t InitializationParametersDataSizeInBytes);
    ///Records the execution (or invocation) of the specified meta command into a graphics command list. Call
    ///ID3D12GraphicsCommandList4::InitializeMetaCommand before executing a meta command. During invocation, you can
    ///specify overrides for values of any of the runtime parameters. You can execute multiple meta commands on the same
    ///graphics command list. And you can execute the same meta command multiple times on the same command list. With a
    ///PIX capture taken with the use of meta commands, you can play that back on the same hardware configuration. But,
    ///by design, it's not portable to other GPUs.
    ///Params:
    ///    pMetaCommand = A pointer to an <b>ID3D12MetaCommand</b> representing the meta command to initialize.
    ///    pExecutionParametersData = An optional pointer to a constant structure containing the values of the parameters for executing the meta
    ///                               command.
    ///    ExecutionParametersDataSizeInBytes = A SIZE_T containing the size of the structure pointed to by <i>pExecutionParametersData</i>, if set,
    ///                                         otherwise 0.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    void ExecuteMetaCommand(ID3D12MetaCommand pMetaCommand, const(void)* pExecutionParametersData, 
                            size_t ExecutionParametersDataSizeInBytes);
    ///Performs a raytracing acceleration structure build on the GPU and optionally outputs post-build information
    ///immediately after the build.
    ///Params:
    ///    pDesc = Description of the acceleration structure to build.
    ///    NumPostbuildInfoDescs = Size of the <i>pPostbuildInfoDescs</i> array. Set to 0 if no post-build info is needed.
    ///    pPostbuildInfoDescs = Optional array of descriptions for post-build info to generate describing properties of the acceleration
    ///                          structure that was built.
    void BuildRaytracingAccelerationStructure(const(D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC)* pDesc, 
                                              uint NumPostbuildInfoDescs, 
                                              const(D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC)* pPostbuildInfoDescs);
    ///Emits post-build properties for a set of acceleration structures. This enables applications to know the output
    ///resource requirements for performing acceleration structure operations via
    ///ID3D12GraphicsCommandList4::CopyRaytracingAccelerationStructure.
    ///Params:
    ///    pDesc = Description of pos-tbuild information to generate.
    ///    NumSourceAccelerationStructures = Number of pointers to acceleration structure GPU virtual addresses pointed to by
    ///                                      <i>pSourceAccelerationStructureData</i>. This number also affects the destination (output), which will be a
    ///                                      contiguous array of <b>NumSourceAccelerationStructures</b> output structures, where the type of the
    ///                                      structures depends on <i>InfoType</i> field of the supplied in the <i>pDesc</i> description.
    ///    pSourceAccelerationStructureData = Pointer to array of GPU virtual addresses of size <i>NumSourceAccelerationStructures</i>. The address must be
    ///                                       aligned to 256 bytes, defined as D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BYTE_ALIGNMENT. The memory pointed
    ///                                       to must be in state D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE.
    void EmitRaytracingAccelerationStructurePostbuildInfo(const(D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC)* pDesc, 
                                                          uint NumSourceAccelerationStructures, 
                                                          const(ulong)* pSourceAccelerationStructureData);
    ///Copies a source acceleration structure to destination memory while applying the specified transformation.
    ///Params:
    ///    DestAccelerationStructureData = The destination memory. The required size can be discovered by calling
    ///                                    EmitRaytracingAccelerationStructurePostbuildInfo beforehand, if necessary for the specified <i>Mode</i>. The
    ///                                    destination start address must be aligned to 256 bytes, defined as
    ///                                    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BYTE_ALIGNMENT, regardless of the specified <i>Mode</i>. The
    ///                                    destination memory range cannot overlap source. Otherwise, results are undefined. The resource state that the
    ///                                    memory pointed to must be in depends on the <i>Mode</i> parameter. For more information, see
    ///                                    D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE.
    ///    SourceAccelerationStructureData = The address of the acceleration structure or other type of data to copy/transform based on the specified
    ///                                      <i>Mode</i>. The data remains unchanged and usable. The operation only copies the data pointed to by
    ///                                      <i>SourceAccelerationStructureData</i> and not any other data, such as acceleration structures, that the
    ///                                      source data may point to. For example, in the case of a top-level acceleration structure, any bottom-level
    ///                                      acceleration structures that it points to are not copied in the operation. The source memory must be aligned
    ///                                      to 256 bytes, defined as D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BYTE_ALIGNMENT, regardless of the specified
    ///                                      <i>Mode</i>. The resource state that the memory pointed to must be in depends on the <i>Mode</i> parameter.
    ///                                      For more information, see D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE.
    ///    Mode = The type of copy operation to perform. For more information, see
    ///           D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE.
    void CopyRaytracingAccelerationStructure(ulong DestAccelerationStructureData, 
                                             ulong SourceAccelerationStructureData, 
                                             D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE Mode);
    ///Sets a state object on the command list.
    ///Params:
    ///    pStateObject = The state object to set on the command list. In the current release, this can only be of type
    ///                   D3D12_STATE_OBJECT_TYPE_RAYTRACING_PIPELINE.
    void SetPipelineState1(ID3D12StateObject pStateObject);
    ///Launch the threads of a ray generation shader.
    ///Params:
    ///    pDesc = A description of the ray dispatch
    void DispatchRays(const(D3D12_DISPATCH_RAYS_DESC)* pDesc);
}

///This interface is used to configure the runtime for tools such as PIX. Its not intended or supported for any other
///scenario.
@GUID("7071E1F0-E84B-4B33-974F-12FA49DE65C5")
interface ID3D12Tools : IUnknown
{
    ///This method enables tools such as PIX to instrument shaders.
    ///Params:
    ///    bEnable = Type: <b>BOOL</b> TRUE to enable shader instrumentation; otherwise, FALSE.
    void EnableShaderInstrumentation(BOOL bEnable);
    ///Determines whether shader instrumentation is enabled.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns TRUE if shader instrumentation is enabled; otherwise FALSE.
    ///    
    BOOL ShaderInstrumentationEnabled();
}

///An interface used to turn on the debug layer. See EnableDebugLayer for more information.
@GUID("344488B7-6846-474B-B989-F027448245E0")
interface ID3D12Debug : IUnknown
{
    ///Enables the debug layer.
    void EnableDebugLayer();
}

///Adds GPU-Based Validation and Dependent Command Queue Synchronization to the debug layer.
@GUID("AFFAA4CA-63FE-4D8E-B8AD-159000AF4304")
interface ID3D12Debug1 : IUnknown
{
    ///Enables the debug layer.
    void EnableDebugLayer();
    ///This method enables or disables GPU-Based Validation (GBV) before creating a device with the debug layer enabled.
    ///Params:
    ///    Enable = Type: <b>BOOL</b> TRUE to enable GPU-Based Validation, otherwise FALSE.
    void SetEnableGPUBasedValidation(BOOL Enable);
    ///Enables or disables dependent command queue synchronization when using a D3D12 device with the debug layer
    ///enabled.
    ///Params:
    ///    Enable = Type: <b>BOOL</b> TRUE to enable Dependent Command Queue Synchronization, otherwise FALSE.
    void SetEnableSynchronizedCommandQueueValidation(BOOL Enable);
}

///Adds configurable levels of GPU-based validation to the debug layer.
@GUID("93A665C4-A3B2-4E5D-B692-A26AE14E3374")
interface ID3D12Debug2 : IUnknown
{
    ///This method configures the level of GPU-based validation that the debug device is to perform at runtime.
    ///Params:
    ///    Flags = Type: <b>D3D12_GPU_BASED_VALIDATION_FLAGS</b> Specifies the level of GPU-based validation to perform at
    ///            runtime.
    void SetGPUBasedValidationFlags(D3D12_GPU_BASED_VALIDATION_FLAGS Flags);
}

///Adds configurable levels of GPU-based validation to the debug layer.
@GUID("5CF4E58F-F671-4FF1-A542-3686E3D153D1")
interface ID3D12Debug3 : ID3D12Debug
{
    ///This method enables or disables GPU-based validation (GBV) before creating a device with the debug layer enabled.
    ///Params:
    ///    Enable = Type: <b>BOOL</b> TRUE to enable GPU-based validation, otherwise FALSE.
    void SetEnableGPUBasedValidation(BOOL Enable);
    ///Enables or disables dependent command queue synchronization when using a Direct3D 12 device with the debug layer
    ///enabled.
    ///Params:
    ///    Enable = Type: <b>BOOL</b> TRUE to enable Dependent Command Queue Synchronization, otherwise FALSE.
    void SetEnableSynchronizedCommandQueueValidation(BOOL Enable);
    ///This method configures the level of GPU-based validation that the debug device is to perform at runtime.
    ///Params:
    ///    Flags = Type: <b>D3D12_GPU_BASED_VALIDATION_FLAGS</b> Specifies the level of GPU-based validation to perform at
    ///            runtime.
    void SetGPUBasedValidationFlags(D3D12_GPU_BASED_VALIDATION_FLAGS Flags);
}

///Specifies device-wide debug layer settings.
@GUID("A9B71770-D099-4A65-A698-3DEE10020F88")
interface ID3D12DebugDevice1 : IUnknown
{
    ///Modifies the D3D12 optional device-wide Debug Layer settings.
    ///Params:
    ///    Type = Type: <b>D3D12_DEBUG_DEVICE_PARAMETER_TYPE</b> Specifies a D3D12_DEBUG_DEVICE_PARAMETER_TYPE value that
    ///           indicates which debug parameter data to get.
    ///    pData = Type: <b>const void*</b> Debug parameter data to set.
    ///    DataSize = Type: <b>UINT</b> Size in bytes of the data pointed to by <i>pData</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetDebugParameter(D3D12_DEBUG_DEVICE_PARAMETER_TYPE Type, const(void)* pData, uint DataSize);
    ///Gets optional device-wide Debug Layer settings.
    ///Params:
    ///    Type = Type: <b>D3D12_DEBUG_DEVICE_PARAMETER_TYPE</b> Specifies a D3D12_DEBUG_DEVICE_PARAMETER_TYPE value that
    ///           indicates which debug parameter data to set.
    ///    pData = Type: <b>void*</b> Points to the memory that will be filled with a copy of the debug parameter data. The
    ///            interpretation of this data depends on the D3D12_DEBUG_DEVICE_PARAMETER_TYPE given in the <i>Type</i>
    ///            parameter.
    ///    DataSize = Type: <b>UINT</b> Size in bytes of the memory buffer pointed to by <i>pData</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetDebugParameter(D3D12_DEBUG_DEVICE_PARAMETER_TYPE Type, void* pData, uint DataSize);
    ///Specifies the amount of information to report on a device object's lifetime.
    ///Params:
    ///    Flags = Type: <b>D3D12_RLDO_FLAGS</b> A value from the D3D12_RLDO_FLAGS enumeration. This method uses the value in
    ///            <i>Flags</i> to determine the amount of information to report about a device object's lifetime.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT ReportLiveDeviceObjects(D3D12_RLDO_FLAGS Flags);
}

///This interface represents a graphics device for debugging.
@GUID("3FEBD6DD-4973-4787-8194-E45F9E28923E")
interface ID3D12DebugDevice : IUnknown
{
    ///Set a bit field of flags that will turn debug features on and off.
    ///Params:
    ///    Mask = Type: <b>D3D12_DEBUG_FEATURE</b> Feature-mask flags, as a bitwise-OR'd combination of D3D12_DEBUG_FEATURE
    ///           enumeration constants. If a flag is present, that feature will be set to on; otherwise, the feature will be
    ///           set to off.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes. HRESULT
    ///    
    HRESULT SetFeatureMask(D3D12_DEBUG_FEATURE Mask);
    ///Gets a bit field of flags that indicates which debug features are on or off.
    ///Returns:
    ///    Type: <b>D3D12_DEBUG_FEATURE</b> Mask of feature-mask flags, as a bitwise OR'ed combination of
    ///    D3D12_DEBUG_FEATURE enumeration constants. If a flag is present, then that feature will be set to on,
    ///    otherwise the feature will be set to off.
    ///    
    D3D12_DEBUG_FEATURE GetFeatureMask();
    ///Reports information about a device object's lifetime.
    ///Params:
    ///    Flags = Type: <b>D3D12_RLDO_FLAGS</b> A value from the D3D12_RLDO_FLAGS enumeration. This method uses the value in
    ///            <i>Flags</i> to determine the amount of information to report about a device object's lifetime.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes. HRESULT
    ///    
    HRESULT ReportLiveDeviceObjects(D3D12_RLDO_FLAGS Flags);
}

@GUID("60ECCBC1-378D-4DF1-894C-F8AC5CE4D7DD")
interface ID3D12DebugDevice2 : ID3D12DebugDevice
{
    HRESULT SetDebugParameter(D3D12_DEBUG_DEVICE_PARAMETER_TYPE Type, const(void)* pData, uint DataSize);
    HRESULT GetDebugParameter(D3D12_DEBUG_DEVICE_PARAMETER_TYPE Type, void* pData, uint DataSize);
}

///Provides methods to monitor and debug a command queue.
@GUID("09E0BF36-54AC-484F-8847-4BAEEAB6053A")
interface ID3D12DebugCommandQueue : IUnknown
{
    ///Checks whether a resource, or subresource, is in a specified state, or not.
    ///Params:
    ///    pResource = Type: <b>ID3D12Resource*</b> Specifies the ID3D12Resource to check.
    ///    Subresource = Type: <b>UINT</b> The index of the subresource to check. This can be set to an index, or
    ///                  D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES.
    ///    State = Type: <b>UINT</b> Specifies the state to check for. This can be one or more D3D12_RESOURCE_STATES flags Or'ed
    ///            together.
    ///Returns:
    ///    Type: <b>BOOL</b> This method returns true if the resource or subresource is in the specified state, false
    ///    otherwise.
    ///    
    BOOL AssertResourceState(ID3D12Resource pResource, uint Subresource, uint State);
}

///This interface enables modification of additional command list debug layer settings.
@GUID("102CA951-311B-4B01-B11F-ECB83E061B37")
interface ID3D12DebugCommandList1 : IUnknown
{
    ///Validates that the given state matches the state of the subresource, assuming the state of the given subresource
    ///is known during recording of a command list (e.g. the resource was transitioned earlier in the same command list
    ///recording). If the state is not yet known this method sets the known state for further validation later in the
    ///same command list recording.
    ///Params:
    ///    pResource = Type: <b>ID3D12Resource*</b> Specifies the ID3D12Resource to check.
    ///    Subresource = Type: <b>UINT</b> The index of the subresource to check. This can be set to an index, or
    ///                  D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES.
    ///    State = Type: <b>UINT</b> Specifies the state to check for. This can be one or more D3D12_RESOURCE_STATES flags Or'ed
    ///            together.
    ///Returns:
    ///    Type: <b>BOOL</b> This method returns <b>true</b> if the tracked state of the resource or subresource matches
    ///    the specified state, <b>false</b> otherwise.
    ///    
    BOOL    AssertResourceState(ID3D12Resource pResource, uint Subresource, uint State);
    ///Modifies optional Debug Layer settings of a command list.
    ///Params:
    ///    Type = Type: <b>D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE</b> Specifies a D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE
    ///           value that indicates which debug parameter data to set.
    ///    pData = Type: <b>const void*</b> Pointer to debug parameter data to set. The interpretation of this data depends on
    ///            the D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE given in the <i>Type</i> parameter.
    ///    DataSize = Type: <b>UINT</b> Specifies the size in bytes of the debug parameter <i>pData</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetDebugParameter(D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE Type, const(void)* pData, uint DataSize);
    ///Gets optional Command List Debug Layer settings.
    ///Params:
    ///    Type = Type: <b>D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE</b> Specifies a D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE
    ///           value that determines which debug parameter data to copy to the memory pointed to by <i>pData</i>.
    ///    pData = Type: <b>void*</b> Points to the memory that will be filled with a copy of the debug parameter data. The
    ///            interpretation of this data depends on the D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE given in the <i>Type</i>
    ///            parameter.
    ///    DataSize = Type: <b>UINT</b> Size in bytes of the memory buffer pointed to by <i>pData</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, otherwise E_INVALIDARG.
    ///    
    HRESULT GetDebugParameter(D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE Type, void* pData, uint DataSize);
}

///Provides methods to monitor and debug a command list.
@GUID("09E0BF36-54AC-484F-8847-4BAEEAB6053F")
interface ID3D12DebugCommandList : IUnknown
{
    ///Checks whether a resource, or subresource, is in a specified state, or not.
    ///Params:
    ///    pResource = Type: <b>ID3D12Resource*</b> Specifies the ID3D12Resource to check.
    ///    Subresource = Type: <b>UINT</b> The index of the subresource to check. This can be set to an index, or
    ///                  D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES.
    ///    State = Type: <b>UINT</b> Specifies the state to check for. This can be one or more D3D12_RESOURCE_STATES flags Or'ed
    ///            together.
    ///Returns:
    ///    Type: <b>BOOL</b> This method returns true if the resource or subresource is in the specified state, false
    ///    otherwise.
    ///    
    BOOL    AssertResourceState(ID3D12Resource pResource, uint Subresource, uint State);
    ///Turns the debug features for a command list on or off.
    ///Params:
    ///    Mask = Type: <b>D3D12_DEBUG_FEATURE</b> A combination of feature-mask flags that are combined by using a bitwise OR
    ///           operation. If a flag is present, that feature will be set to on, otherwise the feature will be set to off.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetFeatureMask(D3D12_DEBUG_FEATURE Mask);
    ///Returns the debug feature flags that have been set on a command list.
    ///Returns:
    ///    Type: <b>D3D12_DEBUG_FEATURE</b> A bit mask containing the set debug features.
    ///    
    D3D12_DEBUG_FEATURE GetFeatureMask();
}

@GUID("AEB575CF-4E06-48BE-BA3B-C450FC96652E")
interface ID3D12DebugCommandList2 : ID3D12DebugCommandList
{
    HRESULT SetDebugParameter(D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE Type, const(void)* pData, uint DataSize);
    HRESULT GetDebugParameter(D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE Type, void* pData, uint DataSize);
}

///Part of a contract between D3D11On12 diagnostic layers and graphics diagnostics tools. This interface facilitates
///diagnostics tools to capture information at a lower level than the DXGI swapchain. You may want to use this interface
///to enable diagnostic tools to capture usage patterns that don't use DXGI swap chains for presentation. If so, you can
///access this interface via **QueryInterface** from a D3D12 command queue. Note that this interface is not supported
///when there are no diagnostic tools present, so your application mustn't rely on it existing.
@GUID("0ADF7D52-929C-4E61-ADDB-FFED30DE66EF")
interface ID3D12SharingContract : IUnknown
{
    ///Notifies diagnostic tools about an end-of-frame operation without the use of a swap chain. Calling this API
    ///enables usage of tools like PIX with applications that either don't render to a window, or that do so in
    ///non-traditional ways.
    ///Params:
    ///    pResource = Type: <b>ID3D12Resource*</b> A pointer to the resource that contains the final frame contents. This resource
    ///                is treated as the *back buffer* of the **Present**.
    ///    Subresource = Type: <b>UINT</b> An unsigned 32bit subresource id.
    ///    window = If provided, indicates which window the tools should use for displaying additional diagnostic information.
    void Present(ID3D12Resource pResource, uint Subresource, HWND window);
    ///Signals a shared fence between the D3D layers and diagnostics tools.
    ///Params:
    ///    pFence = Type: <b>ID3D12Fence*</b> A pointer to the shared fence to signal.
    ///    FenceValue = Type: <b>UINT64</b> An unsigned 64bit value to signal the shared fence with.
    void SharedFenceSignal(ID3D12Fence pFence, ulong FenceValue);
    void BeginCapturableWork(const(GUID)* guid);
    void EndCapturableWork(const(GUID)* guid);
}

///An information-queue interface stores, retrieves, and filters debug messages. The queue consists of a message queue,
///an optional storage filter stack, and a optional retrieval filter stack.
@GUID("0742A90B-C387-483F-B946-30A7E4E61458")
interface ID3D12InfoQueue : IUnknown
{
    ///Set the maximum number of messages that can be added to the message queue.
    ///Params:
    ///    MessageCountLimit = Type: <b>UINT64</b> Maximum number of messages that can be added to the message queue. -1 means no limit.
    ///                        When the number of messages in the message queue has reached the maximum limit, new messages coming in will
    ///                        push old messages out.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetMessageCountLimit(ulong MessageCountLimit);
    ///Clear all messages from the message queue.
    void    ClearStoredMessages();
    HRESULT GetMessageA(ulong MessageIndex, D3D12_MESSAGE* pMessage, size_t* pMessageByteLength);
    ///Get the number of messages that were allowed to pass through a storage filter.
    ///Returns:
    ///    Type: <b>UINT64</b> Number of messages allowed by a storage filter.
    ///    
    ulong   GetNumMessagesAllowedByStorageFilter();
    ///Get the number of messages that were denied passage through a storage filter.
    ///Returns:
    ///    Type: <b>UINT64</b> Number of messages denied by a storage filter.
    ///    
    ulong   GetNumMessagesDeniedByStorageFilter();
    ///Get the number of messages currently stored in the message queue.
    ///Returns:
    ///    Type: <b>UINT64</b> Number of messages currently stored in the message queue.
    ///    
    ulong   GetNumStoredMessages();
    ///Get the number of messages that are able to pass through a retrieval filter.
    ///Returns:
    ///    Type: <b>UINT64</b> Number of messages allowed by a retrieval filter.
    ///    
    ulong   GetNumStoredMessagesAllowedByRetrievalFilter();
    ///Get the number of messages that were discarded due to the message count limit.
    ///Returns:
    ///    Type: <b>UINT64</b> Number of messages discarded.
    ///    
    ulong   GetNumMessagesDiscardedByMessageCountLimit();
    ///Get the maximum number of messages that can be added to the message queue.
    ///Returns:
    ///    Type: <b>UINT64</b> Maximum number of messages that can be added to the queue. -1 means no limit. When the
    ///    number of messages in the message queue has reached the maximum limit, new messages coming in will push old
    ///    messages out.
    ///    
    ulong   GetMessageCountLimit();
    ///Add storage filters to the top of the storage-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D12_INFO_QUEUE_FILTER*</b> Array of storage filters.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT AddStorageFilterEntries(D3D12_INFO_QUEUE_FILTER* pFilter);
    ///Get the storage filter at the top of the storage-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D12_INFO_QUEUE_FILTER*</b> Storage filter at the top of the storage-filter stack.
    ///    pFilterByteLength = Type: <b>SIZE_T*</b> Size of the storage filter in bytes. If <i>pFilter</i> is NULL, the size of the storage
    ///                        filter will be output to this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetStorageFilter(D3D12_INFO_QUEUE_FILTER* pFilter, size_t* pFilterByteLength);
    ///Remove a storage filter from the top of the storage-filter stack.
    void    ClearStorageFilter();
    ///Push an empty storage filter onto the storage-filter stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT PushEmptyStorageFilter();
    ///Push a copy of storage filter currently on the top of the storage-filter stack onto the storage-filter stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT PushCopyOfStorageFilter();
    ///Push a storage filter onto the storage-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D12_INFO_QUEUE_FILTER*</b> Pointer to a storage filter.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT PushStorageFilter(D3D12_INFO_QUEUE_FILTER* pFilter);
    ///Pop a storage filter from the top of the storage-filter stack.
    void    PopStorageFilter();
    ///Get the size of the storage-filter stack in bytes.
    ///Returns:
    ///    Type: <b>UINT</b> Size of the storage-filter stack in bytes.
    ///    
    uint    GetStorageFilterStackSize();
    ///Add storage filters to the top of the retrieval-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D12_INFO_QUEUE_FILTER*</b> Array of retrieval filters.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT AddRetrievalFilterEntries(D3D12_INFO_QUEUE_FILTER* pFilter);
    ///Get the retrieval filter at the top of the retrieval-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D12_INFO_QUEUE_FILTER*</b> Retrieval filter at the top of the retrieval-filter stack.
    ///    pFilterByteLength = Type: <b>SIZE_T*</b> Size of the retrieval filter in bytes. If <i>pFilter</i> is NULL, the size of the
    ///                        retrieval filter will be output to this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetRetrievalFilter(D3D12_INFO_QUEUE_FILTER* pFilter, size_t* pFilterByteLength);
    ///Remove a retrieval filter from the top of the retrieval-filter stack.
    void    ClearRetrievalFilter();
    ///Push an empty retrieval filter onto the retrieval-filter stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT PushEmptyRetrievalFilter();
    ///Push a copy of retrieval filter currently on the top of the retrieval-filter stack onto the retrieval-filter
    ///stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT PushCopyOfRetrievalFilter();
    ///Push a retrieval filter onto the retrieval-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D12_INFO_QUEUE_FILTER*</b> Pointer to a retrieval filter.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT PushRetrievalFilter(D3D12_INFO_QUEUE_FILTER* pFilter);
    ///Pop a retrieval filter from the top of the retrieval-filter stack.
    void    PopRetrievalFilter();
    ///Get the size of the retrieval-filter stack in bytes.
    ///Returns:
    ///    Type: <b>UINT</b> Size of the retrieval-filter stack in bytes.
    ///    
    uint    GetRetrievalFilterStackSize();
    ///Adds a debug message to the message queue and sends that message to debug output.
    ///Params:
    ///    Category = Type: <b>D3D12_MESSAGE_CATEGORY</b> Category of a message.
    ///    Severity = Type: <b>D3D12_MESSAGE_SEVERITY</b> Severity of a message.
    ///    ID = Type: <b>D3D12_MESSAGE_ID</b> Unique identifier of a message.
    ///    pDescription = Type: <b>LPCSTR</b> User-defined message.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT AddMessage(D3D12_MESSAGE_CATEGORY Category, D3D12_MESSAGE_SEVERITY Severity, D3D12_MESSAGE_ID ID, 
                       const(PSTR) pDescription);
    ///Adds a user-defined message to the message queue and sends that message to debug output.
    ///Params:
    ///    Severity = Type: <b>D3D12_MESSAGE_SEVERITY</b> Severity of a message.
    ///    pDescription = Type: <b>LPCSTR</b> Specifies the message string.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT AddApplicationMessage(D3D12_MESSAGE_SEVERITY Severity, const(PSTR) pDescription);
    ///Set a message category to break on when a message with that category passes through the storage filter.
    ///Params:
    ///    Category = Type: <b>D3D12_MESSAGE_CATEGORY</b> Message category to break on.
    ///    bEnable = Type: <b>BOOL</b> Turns this breaking condition on or off (true for on, false for off).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetBreakOnCategory(D3D12_MESSAGE_CATEGORY Category, BOOL bEnable);
    ///Set a message severity level to break on when a message with that severity level passes through the storage
    ///filter.
    ///Params:
    ///    Severity = Type: <b>D3D12_MESSAGE_SEVERITY</b> A message severity level to break on.
    ///    bEnable = Type: <b>BOOL</b> Turns this breaking condition on or off (true for on, false for off).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetBreakOnSeverity(D3D12_MESSAGE_SEVERITY Severity, BOOL bEnable);
    ///Set a message identifier to break on when a message with that identifier passes through the storage filter.
    ///Params:
    ///    ID = Type: <b>D3D12_MESSAGE_ID</b> Message identifier to break on.
    ///    bEnable = Type: <b>BOOL</b> Turns this breaking condition on or off (true for on, false for off).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT SetBreakOnID(D3D12_MESSAGE_ID ID, BOOL bEnable);
    ///Get a message category to break on when a message with that category passes through the storage filter.
    ///Params:
    ///    Category = Type: <b>D3D12_MESSAGE_CATEGORY</b> Message category to break on.
    ///Returns:
    ///    Type: <b>BOOL</b> Whether this breaking condition is turned on or off (true for on, false for off).
    ///    
    BOOL    GetBreakOnCategory(D3D12_MESSAGE_CATEGORY Category);
    ///Get a message severity level to break on when a message with that severity level passes through the storage
    ///filter.
    ///Params:
    ///    Severity = Type: <b>D3D12_MESSAGE_SEVERITY</b> Message severity level to break on.
    ///Returns:
    ///    Type: <b>BOOL</b> Whether this breaking condition is turned on or off (true for on, false for off).
    ///    
    BOOL    GetBreakOnSeverity(D3D12_MESSAGE_SEVERITY Severity);
    ///Get a message identifier to break on when a message with that identifier passes through the storage filter.
    ///Params:
    ///    ID = Type: <b>D3D12_MESSAGE_ID</b> Message identifier to break on.
    ///Returns:
    ///    Type: <b>BOOL</b> Whether this breaking condition is turned on or off (true for on, false for off).
    ///    
    BOOL    GetBreakOnID(D3D12_MESSAGE_ID ID);
    ///Set a boolean that turns the debug output on or off.
    ///Params:
    ///    bMute = Type: <b>BOOL</b> Disable/Enable the debug output (true to disable or mute the output, false to enable the
    ///            output).
    void    SetMuteDebugOutput(BOOL bMute);
    ///Get a boolean that determines if debug output is on or off.
    ///Returns:
    ///    Type: <b>BOOL</b> Whether the debug output is on or off (true for on, false for off).
    ///    
    BOOL    GetMuteDebugOutput();
}

///Encapsulates a list of graphics commands for rendering, extending the interface to support variable-rate shading
///(VRS). For more info, see [Variable-rate shading (VRS)](/windows/desktop/direct3d12/vrs).
@GUID("55050859-4024-474C-87F5-6472EAEE44EA")
interface ID3D12GraphicsCommandList5 : ID3D12GraphicsCommandList4
{
    ///Sets the base shading rate, and combiners, for variable-rate shading (VRS). For more info, see [Variable-rate
    ///shading (VRS)](/windows/desktop/direct3d12/vrs).
    ///Params:
    ///    baseShadingRate = Type: [**D3D12_SHADING_RATE**](/windows/desktop/api/d3d12/ne-d3d12-d3d12_shading_rate) A constant from the
    ///                      [D3D12_SHADING_RATE](/windows/desktop/api/d3d12/ne-d3d12-d3d12_shading_rate) enumeration describing the base
    ///                      shading rate to set.
    ///    combiners = Type: **const
    ///                [D3D12_SHADING_RATE_COMBINER](/windows/desktop/api/d3d12/ne-d3d12-d3d12_shading_rate_combiner)\*** An
    ///                optional pointer to a constant array of
    ///                [**D3D12_SHADING_RATE_COMBINER**](/windows/win32/api/d3d12/ne-d3d12-d3d12_shading_rate_combiner) containing
    ///                the shading rate combiners to set. The count of
    ///                [**D3D12_SHADING_RATE_COMBINER**](/windows/win32/api/d3d12/ne-d3d12-d3d12_shading_rate_combiner) elements in
    ///                the array must be equal to the constant
    ///                [**D3D12_RS_SET_SHADING_RATE_COMBINER_COUNT**](/windows/win32/direct3d12/constants), which is equal to **2**.
    ///                Because per-primitive and screen-space image-based VRS isn't supported on Tier1 [Variable-rate shading
    ///                (VRS)](/windows/win32/direct3d12/vrs), for these values to be meaningful, the adapter requires Tier2 VRS
    ///                support. See
    ///                [**D3D12_FEATURE_DATA_D3D12_OPTIONS6**](/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options6)
    ///                and
    ///                [**D3D12_VARIABLE_SHADING_RATE_TIER**](/windows/win32/api/d3d12/ne-d3d12-d3d12_variable_shading_rate_tier). A
    ///                **NULL** pointer is equivalent to the default shading combiners, which are both
    ///                [**D3D12_SHADING_RATE_COMBINER_PASSTHROUGH**](/windows/win32/api/d3d12/ne-d3d12-d3d12_shading_rate_combiner).
    ///                The algorithm for final shading-rate is determined by the following. ```cpp postRasterizerRate =
    ///                ApplyCombiner(Combiners[0], CommandListShadingRate, Primitive->PrimitiveSpecifiedShadingRate); finalRate =
    ///                ApplyCombiner(Combiners[1], postRasterizerRate, ScreenSpaceImage[xy]); ``` where `ApplyCombiner` is ```cpp
    ///                UINT ApplyCombiner(D3D12_SHADING_RATE_COMBINER combiner, UINT a, UINT b) { MaxShadingRate =
    ///                options6.AdditionalShadingRatesSupported ? 4 : 2; switch (combiner) { case
    ///                D3D12_SHADING_RATE_COMBINER_PASSTHROUGH: // default return a; case D3D12_SHADING_RATE_COMBINER_OVERRIDE:
    ///                return b; case D3D12_SHADING_RATE_COMBINER_MAX: return max(a, b); case D3D12_SHADING_RATE_COMBINER_MIN:
    ///                return min(a, b); case D3D12_SHADING_RATE_COMBINER_SUM: return min(MaxShadingRate, a + b); case default:
    ///                return a; } } ```
    void RSSetShadingRate(D3D12_SHADING_RATE baseShadingRate, const(D3D12_SHADING_RATE_COMBINER)* combiners);
    ///Sets the screen-space shading-rate image for variable-rate shading (VRS). For more info, see [Variable-rate
    ///shading (VRS)](/windows/desktop/direct3d12/vrs). This method requires Tier2 [Variable-rate shading
    ///(VRS)](/windows/desktop/direct3d12/vrs) support. See
    ///[**D3D12_FEATURE_DATA_D3D12_OPTIONS6**](/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options6) and
    ///[**D3D12_VARIABLE_SHADING_RATE_TIER**](/windows/win32/api/d3d12/ne-d3d12-d3d12_variable_shading_rate_tier).
    ///Params:
    ///    shadingRateImage = Type: **[ID3D12Resource](/windows/desktop/api/d3d12/nn-d3d12-id3d12resource)\*** An optional pointer to an
    ///                       [ID3D12Resource](/windows/desktop/api/d3d12/nn-d3d12-id3d12resource) representing a screen-space shading-rate
    ///                       image. If **NULL**, the effect is the same as having a shading-rate image where all values are a shading rate
    ///                       of 1x1. This texture must have the
    ///                       [**D3D12_RESOURCE_STATE_SHADING_RATE_SOURCE**](/windows/win32/api/d3d12/ne-d3d12-d3d12_resource_states) state
    ///                       applied. The tile-size of the shading-rate image can be determined via
    ///                       [**D3D12_FEATURE_DATA_D3D12_OPTIONS6**](/windows/win32/api/d3d12/ns-d3d12-d3d12_feature_data_d3d12_options6).
    ///                       The size of the shading-rate image should therefore be ``` ceil((float)rtWidth / VRSTileSize),
    ///                       ceil((float)rtHeight / VRSTileSize) ``` The shading-rate image must be a 2D texture with a single mip, and
    ///                       format [**DXGI_FORMAT_R8_UINT**](/windows/win32/api/dxgiformat/ne-dxgiformat-dxgi_format). Each texel must be
    ///                       a value corresponding to [**D3D12_SHADING_RATE**](/windows/win32/api/d3d12/ne-d3d12-d3d12_shading_rate). It
    ///                       must have layout [**D3D12_TEXTURE_LAYOUT_UNKNOWN**](/windows/win32/api/d3d12/ne-d3d12-d3d12_texture_layout)
    ///                       and can't be a depth-stencil, render-target, simultaneous-access, or cross-adapter resource. As (0, 0) is the
    ///                       top left in DirectX, a too-small or large shading-rate image results in the bottom or right having no
    ///                       shading-rate image area, or the image extending in these directions. When there is excess, it is ignored (but
    ///                       legal), and when the image is too small, all out-of-bounds areas in the bottom and right will have the
    ///                       default shading rate of 1x1 from the image (however, this does not mean that is the final shading rate. The
    ///                       combiners will still be applied to this 1x1 default value).
    void RSSetShadingRateImage(ID3D12Resource shadingRateImage);
}

@GUID("C3827890-E548-4CFA-96CF-5689A9370F80")
interface ID3D12GraphicsCommandList6 : ID3D12GraphicsCommandList5
{
    void DispatchMesh(uint ThreadGroupCountX, uint ThreadGroupCountY, uint ThreadGroupCountZ);
}

///Handles the creation, wrapping, and releasing of Direct3D 11 resources for Direct3D11on12.
@GUID("85611E73-70A9-490E-9614-A9E302777904")
interface ID3D11On12Device : IUnknown
{
    ///This method creates D3D11 resources for use with D3D 11on12.
    ///Params:
    ///    pResource12 = Type: <b>IUnknown*</b> A pointer to an already-created D3D12 resource or heap.
    ///    pFlags11 = Type: <b>const D3D11_RESOURCE_FLAGS*</b> A D3D11_RESOURCE_FLAGS structure that enables an application to
    ///               override flags that would be inferred by the resource/heap properties. The D3D11_RESOURCE_FLAGS structure
    ///               contains bind flags, misc flags, and CPU access flags.
    ///    InState = Type: <b>D3D12_RESOURCE_STATES</b> The use of the resource on input, as a bitwise-OR'd combination of
    ///              D3D12_RESOURCE_STATES enumeration constants.
    ///    OutState = Type: <b>D3D12_RESOURCE_STATES</b> The use of the resource on output, as a bitwise-OR'd combination of
    ///               D3D12_RESOURCE_STATES enumeration constants.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the wrapped resource interface. The
    ///           <b>REFIID</b>, or <b>GUID</b>, of the interface to the wrapped resource can be obtained by using the
    ///           __uuidof() macro. For example, __uuidof(ID3D12Resource) will get the <b>GUID</b> of the interface to a
    ///           wrapped resource.
    ///    ppResource11 = Type: <b>void**</b> After the method returns, points to the newly created wrapped D3D11 resource or heap.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT CreateWrappedResource(IUnknown pResource12, const(D3D11_RESOURCE_FLAGS)* pFlags11, 
                                  D3D12_RESOURCE_STATES InState, D3D12_RESOURCE_STATES OutState, const(GUID)* riid, 
                                  void** ppResource11);
    ///Releases D3D11 resources that were wrapped for D3D 11on12.
    ///Params:
    ///    ppResources = Type: <b>ID3D11Resource*</b> Specifies a pointer to a set of D3D11 resources, defined by ID3D11Resource.
    ///    NumResources = Type: <b>UINT</b> Count of the number of resources.
    void    ReleaseWrappedResources(ID3D11Resource* ppResources, uint NumResources);
    ///Acquires D3D11 resources for use with D3D 11on12. Indicates that rendering to the wrapped resources can begin
    ///again.
    ///Params:
    ///    ppResources = Type: <b>ID3D11Resource*</b> Specifies a pointer to a set of D3D11 resources, defined by ID3D11Resource.
    ///    NumResources = Type: <b>UINT</b> Count of the number of resources.
    void    AcquireWrappedResources(ID3D11Resource* ppResources, uint NumResources);
}

///Enables better interoperability with a component that might be handed a Direct3D 11 device, but which wants to
///leverage Direct3D 12 instead. This interface extends [ID3D11On12Device](nn-d3d11on12-id3d11on12device.md) to retrieve
///the [Direct3D 12 device](/windows/desktop/api/d3d12/nn-d3d12-id3d12device) being interoperated with.
@GUID("BDB64DF4-EA2F-4C70-B861-AAAB1258BB5D")
interface ID3D11On12Device1 : ID3D11On12Device
{
    ///Retrieves the [Direct3D 12 device](/windows/desktop/api/d3d12/nn-d3d12-id3d12device) being interoperated with.
    ///This enables better interoperability with a component that might be handed a Direct3D 11 device, but which wants
    ///to leverage Direct3D 12 instead.
    ///Params:
    ///    riid = Type: **REFIID** A reference to the globally unique identifier (GUID) of the interface that you wish to be
    ///           returned in `ppvDevice`. This is expected to be the GUID of
    ///           [ID3D12Device](/windows/desktop/api/d3d12/nn-d3d12-id3d12device).
    ///    ppvDevice = Type: **[void](/windows/desktop/winprog/windows-data-types)\*\*** A pointer to a memory block that receives a
    ///                pointer to the device. This is the address of a pointer to an
    ///                [ID3D12Device](/windows/desktop/api/d3d12/nn-d3d12-id3d12device), representing the Direct3D 12 device.
    ///Returns:
    ///    Type: **[HRESULT](/windows/desktop/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [HRESULT](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/desktop/com/com-error-codes-10).
    ///    
    HRESULT GetD3D12Device(const(GUID)* riid, void** ppvDevice);
}

///Enables you to take resources created through the Direct3D 11 APIs, and use them in Direct3D 12. This interface
///extends [ID3D11On12Device1](nn-d3d11on12-id3d11on12device1.md).
@GUID("DC90F331-4740-43FA-866E-67F12CB58223")
interface ID3D11On12Device2 : ID3D11On12Device1
{
    ///Unwraps a Direct3D 11 resource object, and retrieves it as a Direct3D 12 resource object.
    ///Params:
    ///    pResource11 = Type: **[ID3D11Resource](../d3d11/nn-d3d11-id3d11resource.md)\*** The Direct3D 11 resource object to unwrap.
    ///    pCommandQueue = Type: **[ID3D12CommandQueue](../d3d12/nn-d3d12-id3d12commandqueue.md)\*** The command queue on which your
    ///                    application plans to use the resource. Any pending work accessing the resource causes fence waits to be
    ///                    scheduled on this queue. You can then queue further work on this queue, including a signal on a caller-owned
    ///                    fence.
    ///    riid = Type: **REFIID** A reference to the globally unique identifier (GUID) of the interface that you wish to be
    ///           returned in `ppvResource12`.
    ///    ppvResource12 = Type: **[void](/windows/desktop/winprog/windows-data-types)\*\*** A pointer to a memory block that receives a
    ///                    pointer to the Direct3D 12 resource.
    ///Returns:
    ///    Type: **[HRESULT](/windows/desktop/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [HRESULT](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/desktop/com/com-error-codes-10).
    ///    
    HRESULT UnwrapUnderlyingResource(ID3D11Resource pResource11, ID3D12CommandQueue pCommandQueue, 
                                     const(GUID)* riid, void** ppvResource12);
    ///With this method, you can return a Direct3D 11 resource object to Direct3D11On12, and indicate (by way of fences
    ///and fence signal values) when the resource will be ready for Direct3D11On12 to consume. You should call
    ///**ReturnUnderlyingResource** once Direct3D 12 work has been scheduled.
    ///Params:
    ///    pResource11 = Type: **[ID3D11Resource](../d3d11/nn-d3d11-id3d11resource.md)\*** The Direct3D 11 resource object that you
    ///                  wish to return.
    ///    NumSync = Type: **[UINT](/windows/win32/winprog/windows-data-types)** The number of elements in the arrays pointed to
    ///              by *pSignalValues* and *ppFences*.
    ///    pSignalValues = Type: **[UINT64](/windows/win32/winprog/windows-data-types)\*** A pointer to an array of fence signal values.
    ///    ppFences = Type: **[ID3D12Fence](../d3d12/nn-d3d12-id3d12fence.md)\*\*** A pointer to an array of fence objects.
    ///Returns:
    ///    Type: **[HRESULT](/windows/desktop/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [HRESULT](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/desktop/com/com-error-codes-10).
    ///    
    HRESULT ReturnUnderlyingResource(ID3D11Resource pResource11, uint NumSync, ulong* pSignalValues, 
                                     ID3D12Fence* ppFences);
}

///This shader-reflection interface provides access to variable type.
@GUID("E913C351-783D-48CA-A1D1-4F306284AD56")
interface ID3D12ShaderReflectionType
{
    ///Gets the description of a shader-reflection-variable type.
    ///Params:
    ///    pDesc = Type: <b>D3D12_SHADER_TYPE_DESC*</b> A pointer to a shader-type description (see D3D12_SHADER_TYPE_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetDesc(D3D12_SHADER_TYPE_DESC* pDesc);
    ///Gets a shader-reflection-variable type by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionType*</b> A pointer to a ID3D12ShaderReflectionType Interface.
    ///    
    ID3D12ShaderReflectionType GetMemberTypeByIndex(uint Index);
    ///Gets a shader-reflection-variable type by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> Member name.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionType*</b> A pointer to a ID3D12ShaderReflectionType Interface.
    ///    
    ID3D12ShaderReflectionType GetMemberTypeByName(const(PSTR) Name);
    ///Gets a shader-reflection-variable type.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>LPCSTR</b> The variable type.
    ///    
    PSTR    GetMemberTypeName(uint Index);
    ///Indicates whether two ID3D12ShaderReflectionType Interface pointers have the same underlying type.
    ///Params:
    ///    pType = Type: <b>ID3D12ShaderReflectionType*</b> A pointer to a ID3D12ShaderReflectionType Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if the pointers have the same underlying type; otherwise returns S_FALSE.
    ///    
    HRESULT IsEqual(ID3D12ShaderReflectionType pType);
    ///Gets the base class of a class.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionType*</b> Returns a pointer to an ID3D12ShaderReflectionType containing the
    ///    base class type. Returns <b>NULL</b> if the class does not have a base class.
    ///    
    ID3D12ShaderReflectionType GetSubType();
    ///Gets an ID3D12ShaderReflectionType Interface interface containing the variable base class type.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionType*</b> Returns A pointer to a ID3D12ShaderReflectionType Interface.
    ///    
    ID3D12ShaderReflectionType GetBaseClass();
    ///Gets the number of interfaces.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the number of interfaces.
    ///    
    uint    GetNumInterfaces();
    ///Gets an interface by index.
    ///Params:
    ///    uIndex = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionType*</b> A pointer to a ID3D12ShaderReflectionType Interface.
    ///    
    ID3D12ShaderReflectionType GetInterfaceByIndex(uint uIndex);
    ///Indicates whether a variable is of the specified type.
    ///Params:
    ///    pType = Type: <b>ID3D12ShaderReflectionType*</b> A pointer to a ID3D12ShaderReflectionType Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if object being queried is equal to or inherits from the type in the
    ///    <i>pType</i> parameter; otherwise returns S_FALSE.
    ///    
    HRESULT IsOfType(ID3D12ShaderReflectionType pType);
    ///Indicates whether a class type implements an interface.
    ///Params:
    ///    pBase = Type: <b>ID3D12ShaderReflectionType*</b> A pointer to a ID3D12ShaderReflectionType Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if the interface is implemented; otherwise return S_FALSE.
    ///    
    HRESULT ImplementsInterface(ID3D12ShaderReflectionType pBase);
}

///This shader-reflection interface provides access to a variable.
@GUID("8337A8A6-A216-444A-B2F4-314733A73AEA")
interface ID3D12ShaderReflectionVariable
{
    ///Gets a shader-variable description.
    ///Params:
    ///    pDesc = Type: <b>D3D12_SHADER_VARIABLE_DESC*</b> A pointer to a shader-variable description (see
    ///            D3D12_SHADER_VARIABLE_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetDesc(D3D12_SHADER_VARIABLE_DESC* pDesc);
    ///Gets a shader-variable type.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionType*</b> A pointer to a ID3D12ShaderReflectionType Interface.
    ///    
    ID3D12ShaderReflectionType GetType();
    ///Returns the ID3D12ShaderReflectionConstantBuffer of the present ID3D12ShaderReflectionVariable.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionConstantBuffer*</b> Returns a pointer to the
    ///    ID3D12ShaderReflectionConstantBuffer of the present ID3D12ShaderReflectionVariable.
    ///    
    ID3D12ShaderReflectionConstantBuffer GetBuffer();
    ///Gets the corresponding interface slot for a variable that represents an interface pointer.
    ///Params:
    ///    uArrayIndex = Type: <b>UINT</b> The index of the array element to get the slot number for. For a non-array variable this
    ///                  value will be zero.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the index of the interface in the interface array.
    ///    
    uint    GetInterfaceSlot(uint uArrayIndex);
}

///This shader-reflection interface provides access to a constant buffer.
@GUID("C59598B4-48B3-4869-B9B1-B1618B14A8B7")
interface ID3D12ShaderReflectionConstantBuffer
{
    ///Gets a constant-buffer description.
    ///Params:
    ///    pDesc = Type: <b>D3D12_SHADER_BUFFER_DESC*</b> A shader-buffer description, as a pointer to a
    ///            D3D12_SHADER_BUFFER_DESC structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetDesc(D3D12_SHADER_BUFFER_DESC* pDesc);
    ///Gets a shader-reflection variable by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionVariable*</b> A pointer to a shader-reflection variable interface (see
    ///    ID3D12ShaderReflectionVariable Interface).
    ///    
    ID3D12ShaderReflectionVariable GetVariableByIndex(uint Index);
    ///Gets a shader-reflection variable by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> Variable name.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionVariable*</b> Returns a sentinel object (end of list marker). To determine if
    ///    GetVariableByName successfully completed, call ID3D12ShaderReflectionVariable::GetDesc and check the returned
    ///    <b>HRESULT</b>; any return value other than success means that GetVariableByName failed.
    ///    
    ID3D12ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
}

///A shader-reflection interface accesses shader information.
@GUID("5A58797D-A72C-478D-8BA2-EFC6B0EFE88E")
interface ID3D12ShaderReflection : IUnknown
{
    ///Gets a shader description.
    ///Params:
    ///    pDesc = Type: <b>D3D12_SHADER_DESC*</b> A shader description, as a pointer to a D3D12_SHADER_DESC structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 12 Return Codes.
    ///    
    HRESULT GetDesc(D3D12_SHADER_DESC* pDesc);
    ///Gets a constant buffer by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionConstantBuffer*</b> A pointer to a constant buffer (see
    ///    ID3D12ShaderReflectionConstantBuffer Interface).
    ///    
    ID3D12ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint Index);
    ///Gets a constant buffer by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The constant-buffer name.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionConstantBuffer*</b> A pointer to a constant buffer (see
    ///    ID3D12ShaderReflectionConstantBuffer Interface).
    ///    
    ID3D12ShaderReflectionConstantBuffer GetConstantBufferByName(const(PSTR) Name);
    ///Gets a description of how a resource is bound to a shader.
    ///Params:
    ///    ResourceIndex = Type: <b>UINT</b> A zero-based resource index.
    ///    pDesc = Type: <b>D3D12_SHADER_INPUT_BIND_DESC*</b> A pointer to an input-binding description. See
    ///            D3D12_SHADER_INPUT_BIND_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D12_SHADER_INPUT_BIND_DESC* pDesc);
    ///Gets an input-parameter description for a shader.
    ///Params:
    ///    ParameterIndex = Type: <b>UINT</b> A zero-based parameter index.
    ///    pDesc = Type: <b>D3D12_SIGNATURE_PARAMETER_DESC*</b> A pointer to a shader-input-signature description. See
    ///            D3D12_SIGNATURE_PARAMETER_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetInputParameterDesc(uint ParameterIndex, D3D12_SIGNATURE_PARAMETER_DESC* pDesc);
    ///Gets an output-parameter description for a shader.
    ///Params:
    ///    ParameterIndex = Type: <b>UINT</b> A zero-based parameter index.
    ///    pDesc = Type: <b>D3D12_SIGNATURE_PARAMETER_DESC*</b> A shader-output-parameter description, as a pointer to a
    ///            D3D12_SIGNATURE_PARAMETER_DESC structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetOutputParameterDesc(uint ParameterIndex, D3D12_SIGNATURE_PARAMETER_DESC* pDesc);
    ///Gets a patch-constant parameter description for a shader.
    ///Params:
    ///    ParameterIndex = Type: <b>UINT</b> A zero-based parameter index.
    ///    pDesc = Type: <b>D3D12_SIGNATURE_PARAMETER_DESC*</b> A pointer to a shader-input-signature description. See
    ///            D3D12_SIGNATURE_PARAMETER_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetPatchConstantParameterDesc(uint ParameterIndex, D3D12_SIGNATURE_PARAMETER_DESC* pDesc);
    ///Gets a variable by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> A pointer to a string containing the variable name.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionVariable*</b> Returns a ID3D12ShaderReflectionVariable Interface interface.
    ///    
    ID3D12ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
    ///Gets a description of how a resource is bound to a shader.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The constant-buffer name of the resource.
    ///    pDesc = Type: <b>D3D12_SHADER_INPUT_BIND_DESC*</b> A pointer to an input-binding description. See
    ///            D3D12_SHADER_INPUT_BIND_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetResourceBindingDescByName(const(PSTR) Name, D3D12_SHADER_INPUT_BIND_DESC* pDesc);
    ///Gets the number of Mov instructions.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the number of Mov instructions.
    ///    
    uint    GetMovInstructionCount();
    ///Gets the number of Movc instructions.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the number of Movc instructions.
    ///    
    uint    GetMovcInstructionCount();
    ///Gets the number of conversion instructions.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the number of conversion instructions.
    ///    
    uint    GetConversionInstructionCount();
    ///Gets the number of bitwise instructions.
    ///Returns:
    ///    Type: <b>UINT</b> The number of bitwise instructions.
    ///    
    uint    GetBitwiseInstructionCount();
    ///Gets the geometry-shader input-primitive description.
    ///Returns:
    ///    Type: <b>D3D_PRIMITIVE</b> The input-primitive description. See D3D_PRIMITIVE_TOPOLOGY.
    ///    
    D3D_PRIMITIVE GetGSInputPrimitive();
    ///Indicates whether a shader is a sample frequency shader.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns true if the shader is a sample frequency shader; otherwise returns false.
    ///    
    BOOL    IsSampleFrequencyShader();
    ///Gets the number of interface slots in a shader.
    ///Returns:
    ///    Type: <b>UINT</b> The number of interface slots in the shader.
    ///    
    uint    GetNumInterfaceSlots();
    ///Gets the minimum feature level.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetMinFeatureLevel(D3D_FEATURE_LEVEL* pLevel);
    ///Retrieves the sizes, in units of threads, of the X, Y, and Z dimensions of the shader's thread-group grid.
    ///Params:
    ///    pSizeX = Type: <b>UINT*</b> A pointer to the size, in threads, of the x-dimension of the thread-group grid. The
    ///             maximum size is 1024.
    ///    pSizeY = Type: <b>UINT*</b> A pointer to the size, in threads, of the y-dimension of the thread-group grid. The
    ///             maximum size is 1024.
    ///    pSizeZ = Type: <b>UINT*</b> A pointer to the size, in threads, of the z-dimension of the thread-group grid. The
    ///             maximum size is 64.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the total size, in threads, of the thread-group grid by calculating the product of
    ///    the size of each dimension. <pre class="syntax" xml:space="preserve"><code>*pSizeX * *pSizeY *
    ///    *pSizeZ;</code></pre>
    ///    
    uint    GetThreadGroupSize(uint* pSizeX, uint* pSizeY, uint* pSizeZ);
    ///Gets a group of flags that indicates the requirements of a shader.
    ///Returns:
    ///    Type: <b>UINT64</b> A value that contains a combination of one or more shader requirements #define flags;
    ///    each flag specifies a requirement of the shader. A default value of 0 means there are no requirements.
    ///    <table> <tr> <th>Shader requirement #define flag</th> <th>Description</th> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_DOUBLES</b></td> <td>Shader requires that the graphics driver and hardware support
    ///    double data type. </td> </tr> <tr> <td><b>D3D_SHADER_REQUIRES_EARLY_DEPTH_STENCIL</b></td> <td>Shader
    ///    requires an early depth stencil. </td> </tr> <tr> <td><b>D3D_SHADER_REQUIRES_UAVS_AT_EVERY_STAGE</b></td>
    ///    <td>Shader requires unordered access views (UAVs) at every pipeline stage. </td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_64_UAVS</b></td> <td>Shader requires 64 UAVs. </td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_MINIMUM_PRECISION</b></td> <td>Shader requires the graphics driver and hardware to
    ///    support minimum precision. For more info, see Using HLSL minimum precision. </td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_11_1_DOUBLE_EXTENSIONS</b></td> <td>Shader requires that the graphics driver and
    ///    hardware support extended doubles instructions. For more info, see the
    ///    <b>ExtendedDoublesShaderInstructions</b> member of D3D12_FEATURE_DATA_D3D12_OPTIONS. </td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_11_1_SHADER_EXTENSIONS</b></td> <td>Shader requires that the graphics driver and
    ///    hardware support the msad4 intrinsic function in shaders. For more info, see the
    ///    <b>SAD4ShaderInstructions</b> member of D3D12_FEATURE_DATA_D3D12_OPTIONS. </td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_LEVEL_9_COMPARISON_FILTERING</b></td> <td>Shader requires that the graphics driver
    ///    and hardware support Direct3D 9 shadow support. </td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_TILED_RESOURCES</b></td> <td>Shader requires that the graphics driver and hardware
    ///    support tiled resources. </td> </tr> <tr> <td><b>D3D_SHADER_REQUIRES_STENCIL_REF</b></td> <td>Shader requires
    ///    a reference value for depth stencil tests. For more info, see the <b>PSSpecifiedStencilRefSupported</b>
    ///    member of the D3D12_FEATURE_DATA_D3D12_OPTIONS structure, and ID3D12GraphicsCommandList::OMSetStencilRef.
    ///    </td> </tr> <tr> <td><b>D3D_SHADER_REQUIRES_INNER_COVERAGE</b></td> <td>Shader requires that the graphics
    ///    driver and hardware support inner coverage.For more info, see the enumeration constants
    ///    D3D_NAME_INNER_COVERAGE and D3D11_NAME_INNER_COVERAGE in D3D_NAME. </td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_TYPED_UAV_LOAD_ADDITIONAL_FORMATS</b></td> <td>Shader requires that the graphics
    ///    driver and hardware support the loading of additional formats for typed unordered-access views (UAVs). See
    ///    the <b>TypedUAVLoadAdditionalFormats</b> member of the D3D12_FEATURE_DATA_D3D12_OPTIONS structure. </td>
    ///    </tr> <tr> <td><b>D3D_SHADER_REQUIRES_ROVS</b></td> <td>Shader requires that the graphics driver and hardware
    ///    support rasterizer ordered views (ROVs). See Rasterizer Ordered Views. </td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_VIEWPORT_AND_RT_ARRAY_INDEX_FROM_ANY_SHADER_FEEDING_RASTERIZER</b></td> <td>Shader
    ///    requires that the graphics driver and hardware support viewport and render target array index values from any
    ///    shader-feeding rasterizer.For more info, see the member
    ///    <b>VPAndRTArrayIndexFromAnyShaderFeedingRasterizerSupportedWithoutGSEmulation</b>of the
    ///    D3D12_FEATURE_DATA_D3D12_OPTIONS structure. </td> </tr> </table>
    ///    
    ulong   GetRequiresFlags();
}

///A library-reflection interface accesses library info. <div class="alert"><b>Note</b> This interface is part of the
///HLSL shader linking technology that you can use on all Direct3D 12 platforms to create precompiled HLSL functions,
///package them into libraries, and link them into full shaders at run time. </div> <div> </div>
@GUID("8E349D19-54DB-4A56-9DC9-119D87BDB804")
interface ID3D12LibraryReflection : IUnknown
{
    ///Fills the library descriptor structure for the library reflection.
    ///Params:
    ///    pDesc = Type: <b>D3D12_LIBRARY_DESC*</b> A pointer to a D3D12_LIBRARY_DESC structure that receives a description of
    ///            the library reflection.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetDesc(D3D12_LIBRARY_DESC* pDesc);
    ///Gets the function reflector.
    ///Params:
    ///    FunctionIndex = Type: <b>INT</b> The zero-based index of the function reflector to retrieve.
    ///Returns:
    ///    Type: <b>ID3D12FunctionReflection*</b> The function reflector, as a pointer to ID3D12FunctionReflection.
    ///    
    ID3D12FunctionReflection GetFunctionByIndex(int FunctionIndex);
}

///A function-reflection interface accesses function info. <div class="alert"><b>Note</b> This interface is part of the
///HLSL shader linking technology that you can use on all Direct3D 12 platforms to create precompiled HLSL functions,
///package them into libraries, and link them into full shaders at run time. </div> <div> </div>
@GUID("1108795C-2772-4BA9-B2A8-D464DC7E2799")
interface ID3D12FunctionReflection
{
    ///Fills the function descriptor structure for the function.
    ///Params:
    ///    pDesc = Type: <b>D3D12_FUNCTION_DESC*</b> A pointer to a D3D12_FUNCTION_DESC structure that receives a description of
    ///            the function.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetDesc(D3D12_FUNCTION_DESC* pDesc);
    ///Gets a constant buffer by index for a function.
    ///Params:
    ///    BufferIndex = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionConstantBuffer*</b> A pointer to a ID3D12ShaderReflectionConstantBuffer
    ///    interface that represents the constant buffer.
    ///    
    ID3D12ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint BufferIndex);
    ///Gets a constant buffer by name for a function.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The constant-buffer name.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionConstantBuffer*</b> A pointer to a ID3D12ShaderReflectionConstantBuffer
    ///    interface that represents the constant buffer.
    ///    
    ID3D12ShaderReflectionConstantBuffer GetConstantBufferByName(const(PSTR) Name);
    ///Gets a description of how a resource is bound to a function.
    ///Params:
    ///    ResourceIndex = Type: <b>UINT</b> A zero-based resource index.
    ///    pDesc = Type: <b>D3D12_SHADER_INPUT_BIND_DESC*</b> A pointer to a D3D12_SHADER_INPUT_BIND_DESC structure that
    ///            describes input binding of the resource.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D12_SHADER_INPUT_BIND_DESC* pDesc);
    ///Gets a variable by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> A pointer to a string containing the variable name.
    ///Returns:
    ///    Type: <b>ID3D12ShaderReflectionVariable*</b> Returns a ID3D12ShaderReflectionVariable Interface interface.
    ///    
    ID3D12ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
    ///Gets a description of how a resource is bound to a function.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The constant-buffer name of the resource.
    ///    pDesc = Type: <b>D3D12_SHADER_INPUT_BIND_DESC*</b> A pointer to a D3D12_SHADER_INPUT_BIND_DESC structure that
    ///            describes input binding of the resource.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetResourceBindingDescByName(const(PSTR) Name, D3D12_SHADER_INPUT_BIND_DESC* pDesc);
    ///Gets the function parameter reflector.
    ///Params:
    ///    ParameterIndex = Type: <b>INT</b> The zero-based index of the function parameter reflector to retrieve.
    ///Returns:
    ///    Type: <b>ID3D12FunctionParameterReflection*</b> A pointer to a ID3D12FunctionParameterReflection interface
    ///    that represents the function parameter reflector.
    ///    
    ID3D12FunctionParameterReflection GetFunctionParameter(int ParameterIndex);
}

///A function-parameter-reflection interface accesses function-parameter info. <div class="alert"><b>Note</b> This
///interface is part of the HLSL shader linking technology that you can use on all Direct3D 12 platforms to create
///precompiled HLSL functions, package them into libraries, and link them into full shaders at run time. </div> <div>
///</div>
@GUID("EC25F42D-7006-4F2B-B33E-02CC3375733F")
interface ID3D12FunctionParameterReflection
{
    ///Fills the parameter descriptor structure for the function's parameter.
    ///Params:
    ///    pDesc = Type: <b>D3D12_PARAMETER_DESC*</b> A pointer to a D3D12_PARAMETER_DESC structure that receives a description
    ///            of the function's parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 12 Return Codes.
    ///    
    HRESULT GetDesc(D3D12_PARAMETER_DESC* pDesc);
}

///The **IHolographicCameraInterop** interface is a nano-COM interface, used to create Direct3D 12 back buffer resources
///for a [HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera) Windows Runtime object. This is an
///initialization step for using Direct3D 12 with Windows Mixed Reality. This interface also allows your application to
///acquire ownership of content buffers for rendering, prior to committing them with the
///[HolographicCameraRenderingParametersInterop](./nn-windows-graphics-holographic-interop-iholographiccamerarenderingparametersinterop.md)
///interface. Your application can use this interface to initialize holographic rendering using Direct3D 12. Nano-COM
///allows pointers to Direct3D 12 objects to be passed directly as parameters for API calls, instead of using a Windows
///Runtime container object. Your application manages its own pool of holographic buffer resources for use as render
///targets (back buffers) for each [HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera). It can
///create additional buffers as needed in order to continue rendering smoothly. On most devices, this will be three or
///four surfaces. Your application should start with at least two buffers in the pool. Your application can dynamically
///detect when it needs to create a new buffer by looking for unsuccessful attempts to immediately acquire buffers that
///were previously committed for presentation. Your application must commit a buffer for a **HolographicCamera** that is
///included on the [HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe) unless the primary layer
///is disabled for that camera, in which case your application must not commit a buffer for that camera. A buffer
///created by a [HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera) object can be used only
///with that object. It should be released when the **HolographicCamera** is released, or when the Direct3D 12 device
///needs to be recreated&mdash;whichever happens first. The buffer must not be in the GPU pipeline when it is
///released&mdash;Direct3D 12 fences should be used to ensure that this condition is met prior to releasing the buffer
///object.
@GUID("7CC1F9C5-6D02-41FA-9500-E1809EB48EEC")
interface IHolographicCameraInterop : IInspectable
{
    ///The **CreateDirect3D12BackBufferResource** method creates a Direct3D 12 resource for use as a back buffer for the
    ///corresponding [HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera) API object. The
    ///[D3D12_RESOURCE_DESC](../d3d12/ns-d3d12-d3d12_resource_desc.md) structure can contain any set of valid initial
    ///values. Any values that won't work with this
    ///[HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera) will be overridden in the struct
    ///indicated by *pTexture2DDesc*, which is not an optional parameter. The resource is created so that it is already
    ///committed to a heap.
    ///Params:
    ///    pDevice = Type: **[ID3D12Device](../d3d12/nn-d3d12-id3d12device.md)\*** A Direct3D 12 device, which will be used to
    ///              create the resource.
    ///    pTexture2DDesc = Type: **[D3D12_RESOURCE_DESC](../d3d12/ns-d3d12-d3d12_resource_desc.md)\*** The Direct3D 12 resource
    ///                     description. This parameter is not optional. **CreateDirect3D12BackBufferResource** adjusts the description
    ///                     as needed to comply with platform requirements, such as buffer size or format restrictions, which are
    ///                     determined at runtime. Your application should inspect the descriptor for the texture returned in
    ///                     *ppCreatedTexture2DResource*, and respond appropriately to any differences from what was specified.
    ///    ppCreatedTexture2DResource = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*\*** If successful, the Direct3D 12 2D texture
    ///                                 resource for use as a content buffer. Otherwise, `nullptr`.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CreateDirect3D12BackBufferResource(ID3D12Device pDevice, D3D12_RESOURCE_DESC* pTexture2DDesc, 
                                               ID3D12Resource* ppCreatedTexture2DResource);
    ///The **CreateDirect3D12HardwareProtectedBackBufferResource** method creates a Direct3D 12 resource for use as a
    ///back buffer for the corresponding [HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera)
    ///API object, with optional hardware-based content protection. The behavior of
    ///**CreateDirect3D12HardwareProtectedBackBufferResource** is the same as that of
    ///[CreateDirect3D12BackBufferResource](./nf-windows-graphics-holographic-interop-iholographiccamerainterop-createdirect3d12backbufferresource.md),
    ///except that it accepts an optional
    ///[ID3D12ProtectedResourceSession](../d3d12/nn-d3d12-id3d12protectedresourcesession.md) API object interface
    ///pointer. Provide a Direct3D 12 protected resource session via this optional parameter to create a resource buffer
    ///with hardware-based content protection enabled.
    ///Params:
    ///    pDevice = Type: **[ID3D12Device](../d3d12/nn-d3d12-id3d12device.md)\*** A Direct3D 12 device, which will be used to
    ///              create the resource.
    ///    pTexture2DDesc = Type: **[D3D12_RESOURCE_DESC](../d3d12/ns-d3d12-d3d12_resource_desc.md)\*** The Direct3D 12 resource
    ///                     description. **CreateDirect3D12HardwareProtectedBackBufferResource** adjusts the description as needed to
    ///                     comply with platform requirements, such as buffer size or format restrictions, which are determined at
    ///                     runtime. Your application should inspect the descriptor for the texture returned in
    ///                     *ppCreatedTexture2DResource* and respond appropriately to any differences from what was specified.
    ///    pProtectedResourceSession = Type: **[ID3D12ProtectedResourceSession](../d3d12/nn-d3d12-id3d12protectedresourcesession.md)\*** An optional
    ///                                Direct3D 12 protected resource session. Passing in a valid protected session will cause this method to create
    ///                                a Direct3D 12 hardware-protected resource.
    ///    ppCreatedTexture2DResource = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*\*** If successful, the hardware-protected
    ///                                 Direct3D 12 2D texture resource for use as a back buffer. Otherwise, `nullptr`.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CreateDirect3D12HardwareProtectedBackBufferResource(ID3D12Device pDevice, 
                                                                D3D12_RESOURCE_DESC* pTexture2DDesc, 
                                                                ID3D12ProtectedResourceSession pProtectedResourceSession, 
                                                                ID3D12Resource* ppCreatedTexture2DResource);
    ///The **AcquireDirect3D12BufferResource** method transitions ownership of a Direct3D 12 back buffer resource from
    ///the platform to your application. If your application already owns control of the resource, then the acquisition
    ///is still considered to be a success. After committing a resource to a
    ///[HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe) by calling
    ///[IHolographicQuadLayerUpdateParametersInterop::CommitDirect3D12Resource](/windows/win32/api/windows.graphics.holographic.interop/nn-windows-graphics-holographic-interop-iholographicquadlayerupdateparametersinterop),
    ///your application should consider control of that resource to be owned by the system until such a time as the
    ///resource is reacquired by your application using this method. The system owns the buffer until the frame that the
    ///buffer was committed to makes its way through the presentation queue. To determine whether the system has
    ///relinquished control of the buffer, call **AcquireDirect3D12BufferResource** or
    ///**AcquireDirect3D12BufferResourceWithTimeout**. If the buffer can't be acquired by the time your application is
    ///ready to start rendering a new [HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe), then
    ///you should create a new resource and add it to the buffer queue, or limit the queue size by waiting for a buffer
    ///to become available. If the buffer isn't ready to be acquired when **AcquireDirect3D12BufferResource** is called,
    ///then the method call will fail and immediately return the error code **E_NOTREADY**. Your application can limit
    ///the queue size by calling
    ///[AcquireDirect3D12BufferResourceWithTimeout](./nf-windows-graphics-holographic-interop-iholographiccamerainterop-acquiredirect3d12bufferresourcewithtimeout.md)
    ///to wait until a resource becomes available before queuing more work.
    ///Params:
    ///    pResourceToAcquire = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*** The Direct3D 12 resource to acquire.
    ///    pCommandQueue = Type: **[ID3D12CommandQueue](../d3d12/nn-d3d12-id3d12commandqueue.md)\*** The Direct3D 12 command queue to
    ///                    use for transitioning the state of this resource when acquiring it for your application. The resource will be
    ///                    in the **D3D12_RESOURCE_STATE_COMMON** state when it is acquired. The resource transition command may not be
    ///                    queued if the resource is already in the common state when it is being acquired.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT AcquireDirect3D12BufferResource(ID3D12Resource pResourceToAcquire, ID3D12CommandQueue pCommandQueue);
    ///The **AcquireDirect3D12BufferResourceWithTimeout** method transitions ownership of a Direct3D 12 back buffer
    ///resource from the platform to your application, waiting up to the amount of time indicated by the *duration*
    ///argument for the resource to become available. If your application already owns control of the resource, the
    ///acquisition is considered to be a success, and the method returns immediately. After committing a resource to a
    ///[HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe) by calling
    ///[IHolographicQuadLayerUpdateParametersInterop::CommitDirect3D12Resource](./nf-windows-graphics-holographic-interop-iholographicquadlayerupdateparametersinterop-commitdirect3d12resource.md),
    ///your application should consider control of that resource to be owned by the system until such a time as it is
    ///reacquired by your application using **AcquireDirect3D12BufferResourceWithTimeout**. The system owns the buffer
    ///until the frame that the buffer was committed to makes its way through the presentation queue. To determine
    ///whether the system has relinquished control of the buffer, call **AcquireDirect3D12BufferResource** or
    ///**AcquireDirect3D12BufferResourceWithTimeout**. If the buffer can't be acquired by the time your application is
    ///ready to start rendering a new [HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe), then
    ///you should create a new resource and add it to the buffer queue, or limit the queue size by waiting for a buffer
    ///to become available. This method accepts an optional timeout value. When a nonzero value is present in the
    ///*duration* argument, the system waits for that many milliseconds for the buffer to become available. The default
    ///behavior is to not wait. When a timeout value of zero is specified and the buffer is not ready to be acquired,
    ///the method call fails with the error code **E_NOTREADY**.
    ///Params:
    ///    pResourceToAcquire = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*** The Direct3D 12 resource to acquire.
    ///    pCommandQueue = Type: **[ID3D12CommandQueue](../d3d12/nn-d3d12-id3d12commandqueue.md)\*** The Direct3D 12 command queue to
    ///                    use for transitioning the state of this resource when acquiring it for your application. The resource will be
    ///                    in the **D3D12_RESOURCE_STATE_COMMON** state when it is acquired.
    ///    duration = Type: **[UINT64](/windows/win32/winprog/windows-data-types)** If this parameter is set to a non-zero value,
    ///               the call will wait for that amount of time for the buffer to be acquired. If the timeout period elapses
    ///               before the buffer can be acquired, the method will fail with the error code **E_TIMEOUT**. This parameter is
    ///               specified in 100-nanosecond units, similar to the
    ///               [TimeSpan.Duration](/uwp/api/windows.foundation.timespan.duration) field.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT AcquireDirect3D12BufferResourceWithTimeout(ID3D12Resource pResourceToAcquire, 
                                                       ID3D12CommandQueue pCommandQueue, ulong duration);
    ///The **UnacquireDirect3D12BufferResource** method relinquishes control of a Direct3D 12 buffer resource to the
    ///platform. A resource that has been acquired, but not submitted, can be un-acquired to return control of the
    ///buffer back to the platform. A resource that has been un-acquired can be re-acquired at a later time.
    ///Params:
    ///    pResourceToUnacquire = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*** The Direct3D 12 resource to relinquish
    ///                           control of.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT UnacquireDirect3D12BufferResource(ID3D12Resource pResourceToUnacquire);
}

///The **IHolographicCameraRenderingParametersInterop** interface is a nano-COM interface, used to commit Direct3D 12
///buffer resources for presentation during the corresponding
///[HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe). The interface allows COM interop with the
///[HolographicCameraRenderingParameters](/uwp/api/windows.graphics.holographic.holographiccamerarenderingparameters)
///Windows Runtime class for applications that use Direct3D 12 for holographic rendering. Nano-COM allows Direct3D 12
///objects to be used directly as parameters for API calls, rather than going through a container object.
@GUID("F75B68D6-D1FD-4707-AAFD-FA6F4C0E3BF4")
interface IHolographicCameraRenderingParametersInterop : IInspectable
{
    ///The **CommitDirect3D12Resource** method commits a Direct3D 12 buffer for presentation on outputs associated with
    ///a [HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera) during a specific
    ///[HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe). The buffer must have been created by
    ///calling
    ///[CreateDirect3D12BackBufferResource](./nf-windows-graphics-holographic-interop-iholographiccamerainterop-createdirect3d12backbufferresource.md)
    ///or
    ///[CreateDirect3D12HardwareProtectedBackBufferResource](nf-windows-graphics-holographic-interop-iholographiccamerainterop-createdirect3d12hardwareprotectedbackbufferresource.md)
    ///on the same [HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera) corresponding to this
    ///rendering parameters object, and the buffer must have been acquired by your application prior to rendering.
    ///Params:
    ///    pColorResourceToCommit = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*** The Direct3D 12 texture resource with
    ///                             content to display when presenting the
    ///                             [HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe) used to retrieve this rendering
    ///                             parameters object.
    ///    pColorResourceFence = Type: **[ID3D12Fence](../d3d12/nn-d3d12-id3d12fence.md)\*** A fence used to signal app work completion on the
    ///                          color buffer resource indicated by *pColorResourceToCommit*. Completion of this fence at the value indicated
    ///                          by *colorResourceFenceSignalValue* signals transfer of control of the color resource from your application to
    ///                          the platform in the GPU work queue. The platform relies upon this fence, and the value indicated in
    ///                          *colorResourceFenceSignalValue*, to queue work on the GPU that reads from the color buffer.
    ///    colorResourceFenceSignalValue = Type: **[UINT64](/windows/win32/winprog/windows-data-types)** The value used to signal work completion on
    ///                                    *pColorResourceFence*. The platform relies upon this fence value to queue work on the GPU that reads from the
    ///                                    color buffer.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CommitDirect3D12Resource(ID3D12Resource pColorResourceToCommit, ID3D12Fence pColorResourceFence, 
                                     ulong colorResourceFenceSignalValue);
    ///Commits a Direct3D 12 buffer for presentation on outputs associated with the
    ///[HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera). The buffer must have been created
    ///by calling
    ///[CreateDirect3D12BackBufferResource](./nf-windows-graphics-holographic-interop-iholographiccamerainterop-createdirect3d12backbufferresource.md)
    ///or
    ///[CreateDirect3D12HardwareProtectedBackBufferResource](nf-windows-graphics-holographic-interop-iholographiccamerainterop-createdirect3d12hardwareprotectedbackbufferresource.md)
    ///on the same [HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera) that it is committed
    ///for. This method also accepts an optional depth buffer parameter, along with fence and fence value for app work
    ///completion on that buffer. This depth buffer will be used for image stabilization when showing the frame it is
    ///committed to. The depth buffer must contain depth data correlated with geometry used to draw holograms in the
    ///color buffer, which is submitted at the same time. The depth buffer should not contain depth data for invisible
    ///content, such as depth data used for occlusion.
    ///Params:
    ///    pColorResourceToCommit = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*** The Direct3D 12 texture resource with
    ///                             content to display when presenting the
    ///                             [HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe) used to retrieve this rendering
    ///                             parameters object.
    ///    pColorResourceFence = Type: **[ID3D12Fence](../d3d12/nn-d3d12-id3d12fence.md)\*** A fence used to signal app work completion on the
    ///                          color buffer resource indicated by *pColorResourceToCommit*. Completion of this fence at the value indicated
    ///                          by *colorResourceFenceSignalValue* signals transfer of control of the color resource from your application to
    ///                          the platform in the GPU work queue. The platform relies upon this fence, and the value indicated in
    ///                          *colorResourceFenceSignalValue*, to queue work on the GPU that reads from the color buffer.
    ///    colorResourceFenceSignalValue = Type: **[UINT64](/windows/win32/winprog/windows-data-types)** The value used to signal work completion on
    ///                                    *pColorResourceFence*. The platform relies upon this fence value to queue work on the GPU that reads from the
    ///                                    color buffer.
    ///    pDepthResourceToCommit = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*** The Direct3D 12 depth buffer with depth
    ///                             data to use for image stabilization when presenting the
    ///                             [HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe) used to retrieve this rendering
    ///                             parameters object. Applications typically submit the depth stencil used when rendering to
    ///                             *pColorResourceToCommit*, or a depth buffer that is derived from the same rendering pass. The depth buffer
    ///                             should only include data corresponding to geometry used to render holograms in the color buffer; for example,
    ///                             occlusion data shouldn't be included, and may be ignored by the platform.
    ///    pDepthResourceFence = Type: **[ID3D12Fence](../d3d12/nn-d3d12-id3d12fence.md)\*** A fence used to signal work completion on the
    ///                          depth buffer resource indicated by *pDepthResourceToCommit*. Completion of this fence at the value indicated
    ///                          by *depthResourceFenceSignalValue* signals transfer of control of the depth resource from your application to
    ///                          the platform in the GPU work queue. The platform relies upon this fence, and the value indicated in
    ///                          *colorResourceFenceSignalValue*, to queue work on the GPU that reads from the depth buffer.
    ///    depthResourceFenceSignalValue = Type: **[UINT64](/windows/win32/winprog/windows-data-types)** The value used to signal work completion on
    ///                                    *pDepthResourceFence*. The platform relies upon this fence value to queue work on the GPU that reads from the
    ///                                    depth buffer.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CommitDirect3D12ResourceWithDepthData(ID3D12Resource pColorResourceToCommit, 
                                                  ID3D12Fence pColorResourceFence, 
                                                  ulong colorResourceFenceSignalValue, 
                                                  ID3D12Resource pDepthResourceToCommit, 
                                                  ID3D12Fence pDepthResourceFence, 
                                                  ulong depthResourceFenceSignalValue);
}

///The **IHolographicQuadLayerInterop** interface is a nano-COM interface, used to create Direct3D 12 content buffers
///for a [HolographicQuadLayer](/uwp/api/windows.graphics.holographic.holographicquadlayer) Windows Runtime object. This
///is an initialization step for using Direct3D 12 with Windows Mixed Reality quad layers. It also allows your
///application to acquire ownership of content buffers for rendering, prior to committing them with the
///[**IHolographicQuadLayerUpdateParametersInterop**](./nn-windows-graphics-holographic-interop-iholographicquadlayerupdateparametersinterop.md)
///interface. Your application can use **IHolographicQuadLayerInterop** to initialize Direct3D 12 content buffer
///resources for holographic quad layers. Nano-COM allows pointers to Direct3D 12 objects to be passed directly as
///parameters for API calls, instead of using a Windows Runtime container object. Your application manages its own pool
///of holographic content buffer resources. It can create additional buffers as needed in order to continue rendering
///smoothly. On most devices, this will be three or four buffers. Your application should start with at least two
///buffers in the pool. Your application can dynamically detect when it needs to create a new buffer by looking for
///failed attempts to immediately acquire buffers that were previously committed for presentation. A quad layer content
///buffer will continue to be presented each frame until a new buffer is committed. A buffer created by a
///[HolographicQuadLayer](/uwp/api/windows.graphics.holographic.holographicquadlayer) object can be used only with that
///object. It should be released when the **HolographicQuadLayer** is released, or when the Direct3D 12 device needs to
///be recreated&mdash;whichever happens first. The buffer must not be in the GPU pipeline when it is
///released&mdash;Direct3D 12 fences should be used to ensure that this condition is met prior to releasing the buffer
///object.
@GUID("CFA688F0-639E-4A47-83D7-6B7F5EBF7FED")
interface IHolographicQuadLayerInterop : IInspectable
{
    ///The **CreateDirect3D12ContentBufferResource** method creates a Direct3D 12 resource for use as a back buffer for
    ///the corresponding [HolographicQuadLayer](/uwp/api/windows.graphics.holographic.holographicquadlayer) API object.
    ///The [D3D12_RESOURCE_DESC](../d3d12/ns-d3d12-d3d12_resource_desc.md) structure can contain any set of valid
    ///initial values. Any values that won't work with this quad layer object will be overridden in the struct indicated
    ///by *pTexture2DDesc*, which is not an optional parameter. The resource is created so that it is already committed
    ///to a heap.
    ///Params:
    ///    pDevice = Type: **[ID3D12Device](../d3d12/nn-d3d12-id3d12device.md)\*** A Direct3D 12 device, which will be used to
    ///              create the resource.
    ///    pTexture2DDesc = Type: **[D3D12_RESOURCE_DESC](../d3d12/ns-d3d12-d3d12_resource_desc.md)\*** The Direct3D 12 resource
    ///                     description. This parameter is not optional. **CreateDirect3D12ContentBufferResource** adjusts the
    ///                     description as needed to comply with platform requirements, such as buffer size or format restrictions, which
    ///                     are determined at runtime. Your application should inspect the descriptor for the texture returned in
    ///                     *ppCreatedTexture2DResource*, and respond appropriately to any differences from what was specified.
    ///    ppTexture2DResource = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*\*** If successful, the Direct3D 12 2D texture
    ///                          resource for use as a content buffer. Otherwise, `nullptr`.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CreateDirect3D12ContentBufferResource(ID3D12Device pDevice, D3D12_RESOURCE_DESC* pTexture2DDesc, 
                                                  ID3D12Resource* ppTexture2DResource);
    ///The **CreateDirect3D12HardwareProtectedContentBufferResource** method creates a Direct3D 12 resource for use as a
    ///back buffer for the corresponding
    ///[HolographicQuadLayer](/uwp/api/windows.graphics.holographic.holographicquadlayer) API object, with optional
    ///hardware-based content protection. The behavior of **CreateDirect3D12HardwareProtectedContentBufferResource** is
    ///the same as that of
    ///[CreateDirect3D12ContentBufferResource](./nf-windows-graphics-holographic-interop-iholographicquadlayerinterop-createdirect3d12contentbufferresource.md),
    ///except that it accepts an optional
    ///[ID3D12ProtectedResourceSession](../d3d12/nn-d3d12-id3d12protectedresourcesession.md) API object interface
    ///pointer. Provide a Direct3D 12 protected resource session via this optional parameter to create a resource buffer
    ///with hardware-based content protection enabled.
    ///Params:
    ///    pDevice = Type: **[ID3D12Device](../d3d12/nn-d3d12-id3d12device.md)\*** A Direct3D 12 device, which will be used to
    ///              create the resource.
    ///    pTexture2DDesc = Type: **[D3D12_RESOURCE_DESC](../d3d12/ns-d3d12-d3d12_resource_desc.md)\*** The Direct3D 12 resource
    ///                     description. **CreateDirect3D12HardwareProtectedContentBufferResource** adjusts the description as needed to
    ///                     comply with platform requirements, such as buffer size or format restrictions, which are determined at
    ///                     runtime. Your application should inspect the descriptor for the texture returned in
    ///                     `ppCreatedTexture2DResource` and respond appropriately to any differences from what was specified.
    ///    pProtectedResourceSession = Type: **[ID3D12ProtectedResourceSession](../d3d12/nn-d3d12-id3d12protectedresourcesession.md)\*** An optional
    ///                                Direct3D 12 protected resource session. Passing in a valid protected session causes this method to create a
    ///                                Direct3D 12 hardware-protected resource.
    ///    ppCreatedTexture2DResource = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*\*** If successful, the hardware-protected
    ///                                 Direct3D 12 2D texture resource for use as a content buffer. Otherwise, `nullptr`.
    ///Returns:
    ///    S_OK if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the error code reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CreateDirect3D12HardwareProtectedContentBufferResource(ID3D12Device pDevice, 
                                                                   D3D12_RESOURCE_DESC* pTexture2DDesc, 
                                                                   ID3D12ProtectedResourceSession pProtectedResourceSession, 
                                                                   ID3D12Resource* ppCreatedTexture2DResource);
    ///The **AcquireDirect3D12BufferResource** method transitions ownership of a Direct3D 12 content buffer resource
    ///from the platform to your application. If your application already owns control of the resource, then the
    ///acquisition is still considered to be a success. After committing a resource to a
    ///[HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe) by calling
    ///[IHolographicQuadLayerUpdateParametersInterop::CommitDirect3D12Resource](./nf-windows-graphics-holographic-interop-iholographicquadlayerupdateparametersinterop-commitdirect3d12resource.md),
    ///your application should consider control of that resource to be relinquished to the system until such a time as
    ///it is reacquired by your application using **AcquireDirect3D12BufferResource**. The system owns the buffer until
    ///it is no longer needed for presenting the quad layer. To determine whether the system has relinquished control of
    ///the buffer, call **AcquireDirect3D12BufferResource** or **AcquireDirect3D12BufferResourceWithTimeout**. If the
    ///buffer can't be acquired by the time your application is ready to start rendering a new update for the quad
    ///layer, then you should create a new resource and add it to the buffer queue, or limit the queue size by waiting
    ///for a buffer to become available. If the buffer is not ready to be acquired when this method is called, the
    ///method call fails and immediately returns the error code **E_NOTREADY**. Your application can limit the queue
    ///size by calling
    ///[AcquireDirect3D12BufferResourceWithTimeout](./nf-windows-graphics-holographic-interop-iholographicquadlayerinterop-acquiredirect3d12bufferresourcewithtimeout.md)
    ///to wait until a resource becomes available before queuing more work.
    ///Params:
    ///    pResourceToAcquire = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*** The Direct3D 12 resource to acquire. The
    ///                         resource will be in the **D3D12_RESOURCE_STATE_COMMON** state when it is acquired.
    ///    pCommandQueue = Type: **[ID3D12CommandQueue](../d3d12/nn-d3d12-id3d12commandqueue.md)\*** The Direct3D 12 command queue to
    ///                    use for transitioning the state of this resource when acquiring it for your application.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT AcquireDirect3D12BufferResource(ID3D12Resource pResourceToAcquire, ID3D12CommandQueue pCommandQueue);
    ///The **AcquireDirect3D12BufferResourceWithTimeout** method transitions ownership of a Direct3D 12 back buffer
    ///resource from the platform to your application, waiting up to the amount of time indicated by the *duration*
    ///argument for the resource to become available. If your application already owns control of the resource, then the
    ///acquisition is still considered to be a success, and the method returns immediately. After committing a resource
    ///to a [HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe) by calling
    ///[IHolographicQuadLayerUpdateParametersInterop::CommitDirect3D12Resource](./nf-windows-graphics-holographic-interop-iholographicquadlayerupdateparametersinterop-commitdirect3d12resource.md),
    ///your application should consider control of that resource to be relinquished to the system until such a time as
    ///it is reacquired by your application using **AcquireDirect3D12BufferResourceWithTimeout**. The system owns the
    ///buffer until it is no longer needed for presenting the quad layer. To determine whether the system has
    ///relinquished control of the buffer, call **AcquireDirect3D12BufferResource** or
    ///**AcquireDirect3D12BufferResourceWithTimeout**. If the buffer can't be acquired by the time your application is
    ///ready to start rendering a new update for the quad layer, then you should create a new resource and add it to the
    ///buffer queue, or limit the queue size by waiting for a buffer to become available. This method accepts an
    ///optional timeout value. When a non-zero value is present in the *duration* argument, the system waits for that
    ///many milliseconds for the buffer to become available. The default behavior is to not wait. When a timeout value
    ///of zero is specified, and the buffer is not ready to be acquired, the method call fails with the error code
    ///**E_NOTREADY**.
    ///Params:
    ///    pResourceToAcquire = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*** The Direct3D 12 resource to acquire. The
    ///                         resource will be in the **D3D12_RESOURCE_STATE_COMMON** state when it is acquired.
    ///    pCommandQueue = Type: **[ID3D12CommandQueue](../d3d12/nn-d3d12-id3d12commandqueue.md)\*** The Direct3D 12 command queue to
    ///                    use for transitioning the state of this resource when acquiring it for your application.
    ///    duration = Type: **[UINT64](/windows/win32/winprog/windows-data-types)** If this parameter is set, the call will wait
    ///               for that amount of time for the buffer to be acquired. If the timeout period elapses before the buffer can be
    ///               acquired, the method fails with the error code **E_TIMEOUT**. This parameter is in 100-nanosecond units,
    ///               similar to the [TimeSpan.Duration](/uwp/api/windows.foundation.timespan.duration) field.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10). When no timeout value is specified, if this method is called
    ///    and the buffer is not ready to be acquired, the method call will fail with the error code **E_NOTREADY**.
    ///    
    HRESULT AcquireDirect3D12BufferResourceWithTimeout(ID3D12Resource pResourceToAcquire, 
                                                       ID3D12CommandQueue pCommandQueue, ulong duration);
    ///The **UnacquireDirect3D12BufferResource** method relinquishes control of a Direct3D 12 buffer resource to the
    ///platform. A resource that has been acquired, but not submitted, can be un-acquired to return control of the
    ///buffer back to the platform. A resource that has been un-acquired can be re-acquired at a later time.
    ///Params:
    ///    pResourceToUnacquire = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*** The Direct3D 12 resource to relinquish
    ///                           control of.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT UnacquireDirect3D12BufferResource(ID3D12Resource pResourceToUnacquire);
}

///The **IHolographicQuadLayerUpdateParametersInterop** interface is a nano-COM interface, used to commit Direct3D 12
///buffer resources for quad layer rendering in the corresponding
///[HolographicFrame](/uwp/api/windows.graphics.holographic.holographicframe). The interface allows COM interop with the
///[HolographicQuadLayerUpdateParameters](/uwp/api/windows.graphics.holographic.holographicquadlayerupdateparameters)
///class for applications that use Direct3D 12 for holographic rendering. Nano-COM allows Direct3D 12 objects to be used
///directly as parameters for API calls, rather than going through a container object.
@GUID("E5F549CD-C909-444F-8809-7CC18A9C8920")
interface IHolographicQuadLayerUpdateParametersInterop : IInspectable
{
    ///The **CommitDirect3D12Resource** method commits a Direct3D 12 buffer for presentation on outputs associated with
    ///any [HolographicCamera](/uwp/api/windows.graphics.holographic.holographiccamera) to which the quad layer is
    ///attached. The buffer must have been created by calling
    ///[CreateDirect3D12ContentBufferResource](./nf-windows-graphics-holographic-interop-iholographicquadlayerinterop-createdirect3d12contentbufferresource.md)
    ///or
    ///[CreateDirect3D12HardwareProtectedContentBufferResource](nf-windows-graphics-holographic-interop-iholographicquadlayerinterop-createdirect3d12hardwareprotectedcontentbufferresource.md)
    ///on the same [HolographicQuadLayer](/uwp/api/windows.graphics.holographic.holographicquadlayer) corresponding to
    ///this update parameters object, and the buffer must have been acquired by your application prior to rendering.
    ///Params:
    ///    pColorResourceToCommit = Type: **[ID3D12Resource](../d3d12/nn-d3d12-id3d12resource.md)\*** The Direct3D 12 texture resource with
    ///                             content to display when rendering the
    ///                             [HolographicQuadLayer](/uwp/api/windows.graphics.holographic.holographicquadlayer) corresponding to this
    ///                             update parameters object. The content will also be displayed during any subsequent frames, until another
    ///                             content buffer update is provided for this
    ///                             [HolographicQuadLayer](/uwp/api/windows.graphics.holographic.holographicquadlayer).
    ///    pColorResourceFence = Type: **[ID3D12Fence](../d3d12/nn-d3d12-id3d12fence.md)\*** A fence used to signal app work completion on the
    ///                          content buffer resource indicated by *pColorResourceToCommit*. Completion of this fence at the value
    ///                          indicated by *colorResourceFenceSignalValue* signals transfer of control of the content buffer resource from
    ///                          your application to the platform in the GPU work queue. The platform relies upon this fence, and the value
    ///                          indicated in *colorResourceFenceSignalValue*, to queue work on the GPU that reads from the content buffer.
    ///    colorResourceFenceSignalValue = Type: **[UINT64](/windows/win32/winprog/windows-data-types)** The value used to signal work completion on
    ///                                    *pColorResourceFence*. The platform relies upon this fence value to queue work on the GPU that reads from the
    ///                                    content buffer.
    ///Returns:
    ///    **S_OK** if successful, otherwise returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error
    ///    code indicating the reason for failure. Also see [COM Error Codes (UI, Audio, DirectX,
    ///    Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CommitDirect3D12Resource(ID3D12Resource pColorResourceToCommit, ID3D12Fence pColorResourceFence, 
                                     ulong colorResourceFenceSignalValue);
}


// GUIDs


const GUID IID_ID3D11On12Device                             = GUIDOF!ID3D11On12Device;
const GUID IID_ID3D11On12Device1                            = GUIDOF!ID3D11On12Device1;
const GUID IID_ID3D11On12Device2                            = GUIDOF!ID3D11On12Device2;
const GUID IID_ID3D12CommandAllocator                       = GUIDOF!ID3D12CommandAllocator;
const GUID IID_ID3D12CommandList                            = GUIDOF!ID3D12CommandList;
const GUID IID_ID3D12CommandQueue                           = GUIDOF!ID3D12CommandQueue;
const GUID IID_ID3D12CommandSignature                       = GUIDOF!ID3D12CommandSignature;
const GUID IID_ID3D12Debug                                  = GUIDOF!ID3D12Debug;
const GUID IID_ID3D12Debug1                                 = GUIDOF!ID3D12Debug1;
const GUID IID_ID3D12Debug2                                 = GUIDOF!ID3D12Debug2;
const GUID IID_ID3D12Debug3                                 = GUIDOF!ID3D12Debug3;
const GUID IID_ID3D12DebugCommandList                       = GUIDOF!ID3D12DebugCommandList;
const GUID IID_ID3D12DebugCommandList1                      = GUIDOF!ID3D12DebugCommandList1;
const GUID IID_ID3D12DebugCommandList2                      = GUIDOF!ID3D12DebugCommandList2;
const GUID IID_ID3D12DebugCommandQueue                      = GUIDOF!ID3D12DebugCommandQueue;
const GUID IID_ID3D12DebugDevice                            = GUIDOF!ID3D12DebugDevice;
const GUID IID_ID3D12DebugDevice1                           = GUIDOF!ID3D12DebugDevice1;
const GUID IID_ID3D12DebugDevice2                           = GUIDOF!ID3D12DebugDevice2;
const GUID IID_ID3D12DescriptorHeap                         = GUIDOF!ID3D12DescriptorHeap;
const GUID IID_ID3D12Device                                 = GUIDOF!ID3D12Device;
const GUID IID_ID3D12Device1                                = GUIDOF!ID3D12Device1;
const GUID IID_ID3D12Device2                                = GUIDOF!ID3D12Device2;
const GUID IID_ID3D12Device3                                = GUIDOF!ID3D12Device3;
const GUID IID_ID3D12Device4                                = GUIDOF!ID3D12Device4;
const GUID IID_ID3D12Device5                                = GUIDOF!ID3D12Device5;
const GUID IID_ID3D12Device6                                = GUIDOF!ID3D12Device6;
const GUID IID_ID3D12Device7                                = GUIDOF!ID3D12Device7;
const GUID IID_ID3D12Device8                                = GUIDOF!ID3D12Device8;
const GUID IID_ID3D12DeviceChild                            = GUIDOF!ID3D12DeviceChild;
const GUID IID_ID3D12DeviceRemovedExtendedData              = GUIDOF!ID3D12DeviceRemovedExtendedData;
const GUID IID_ID3D12DeviceRemovedExtendedData1             = GUIDOF!ID3D12DeviceRemovedExtendedData1;
const GUID IID_ID3D12DeviceRemovedExtendedDataSettings      = GUIDOF!ID3D12DeviceRemovedExtendedDataSettings;
const GUID IID_ID3D12DeviceRemovedExtendedDataSettings1     = GUIDOF!ID3D12DeviceRemovedExtendedDataSettings1;
const GUID IID_ID3D12Fence                                  = GUIDOF!ID3D12Fence;
const GUID IID_ID3D12Fence1                                 = GUIDOF!ID3D12Fence1;
const GUID IID_ID3D12FunctionParameterReflection            = GUIDOF!ID3D12FunctionParameterReflection;
const GUID IID_ID3D12FunctionReflection                     = GUIDOF!ID3D12FunctionReflection;
const GUID IID_ID3D12GraphicsCommandList                    = GUIDOF!ID3D12GraphicsCommandList;
const GUID IID_ID3D12GraphicsCommandList1                   = GUIDOF!ID3D12GraphicsCommandList1;
const GUID IID_ID3D12GraphicsCommandList2                   = GUIDOF!ID3D12GraphicsCommandList2;
const GUID IID_ID3D12GraphicsCommandList3                   = GUIDOF!ID3D12GraphicsCommandList3;
const GUID IID_ID3D12GraphicsCommandList4                   = GUIDOF!ID3D12GraphicsCommandList4;
const GUID IID_ID3D12GraphicsCommandList5                   = GUIDOF!ID3D12GraphicsCommandList5;
const GUID IID_ID3D12GraphicsCommandList6                   = GUIDOF!ID3D12GraphicsCommandList6;
const GUID IID_ID3D12Heap                                   = GUIDOF!ID3D12Heap;
const GUID IID_ID3D12Heap1                                  = GUIDOF!ID3D12Heap1;
const GUID IID_ID3D12InfoQueue                              = GUIDOF!ID3D12InfoQueue;
const GUID IID_ID3D12LibraryReflection                      = GUIDOF!ID3D12LibraryReflection;
const GUID IID_ID3D12LifetimeOwner                          = GUIDOF!ID3D12LifetimeOwner;
const GUID IID_ID3D12LifetimeTracker                        = GUIDOF!ID3D12LifetimeTracker;
const GUID IID_ID3D12MetaCommand                            = GUIDOF!ID3D12MetaCommand;
const GUID IID_ID3D12Object                                 = GUIDOF!ID3D12Object;
const GUID IID_ID3D12Pageable                               = GUIDOF!ID3D12Pageable;
const GUID IID_ID3D12PipelineLibrary                        = GUIDOF!ID3D12PipelineLibrary;
const GUID IID_ID3D12PipelineLibrary1                       = GUIDOF!ID3D12PipelineLibrary1;
const GUID IID_ID3D12PipelineState                          = GUIDOF!ID3D12PipelineState;
const GUID IID_ID3D12ProtectedResourceSession               = GUIDOF!ID3D12ProtectedResourceSession;
const GUID IID_ID3D12ProtectedResourceSession1              = GUIDOF!ID3D12ProtectedResourceSession1;
const GUID IID_ID3D12ProtectedSession                       = GUIDOF!ID3D12ProtectedSession;
const GUID IID_ID3D12QueryHeap                              = GUIDOF!ID3D12QueryHeap;
const GUID IID_ID3D12Resource                               = GUIDOF!ID3D12Resource;
const GUID IID_ID3D12Resource1                              = GUIDOF!ID3D12Resource1;
const GUID IID_ID3D12Resource2                              = GUIDOF!ID3D12Resource2;
const GUID IID_ID3D12RootSignature                          = GUIDOF!ID3D12RootSignature;
const GUID IID_ID3D12RootSignatureDeserializer              = GUIDOF!ID3D12RootSignatureDeserializer;
const GUID IID_ID3D12ShaderReflection                       = GUIDOF!ID3D12ShaderReflection;
const GUID IID_ID3D12ShaderReflectionConstantBuffer         = GUIDOF!ID3D12ShaderReflectionConstantBuffer;
const GUID IID_ID3D12ShaderReflectionType                   = GUIDOF!ID3D12ShaderReflectionType;
const GUID IID_ID3D12ShaderReflectionVariable               = GUIDOF!ID3D12ShaderReflectionVariable;
const GUID IID_ID3D12SharingContract                        = GUIDOF!ID3D12SharingContract;
const GUID IID_ID3D12StateObject                            = GUIDOF!ID3D12StateObject;
const GUID IID_ID3D12StateObjectProperties                  = GUIDOF!ID3D12StateObjectProperties;
const GUID IID_ID3D12SwapChainAssistant                     = GUIDOF!ID3D12SwapChainAssistant;
const GUID IID_ID3D12Tools                                  = GUIDOF!ID3D12Tools;
const GUID IID_ID3D12VersionedRootSignatureDeserializer     = GUIDOF!ID3D12VersionedRootSignatureDeserializer;
const GUID IID_IHolographicCameraInterop                    = GUIDOF!IHolographicCameraInterop;
const GUID IID_IHolographicCameraRenderingParametersInterop = GUIDOF!IHolographicCameraRenderingParametersInterop;
const GUID IID_IHolographicQuadLayerInterop                 = GUIDOF!IHolographicQuadLayerInterop;
const GUID IID_IHolographicQuadLayerUpdateParametersInterop = GUIDOF!IHolographicQuadLayerUpdateParametersInterop;
