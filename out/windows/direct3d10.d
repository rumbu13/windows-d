// Written in the D programming language.

module windows.direct3d10;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct3d11 : D3D_CBUFFER_TYPE, D3D_NAME, D3D_PRIMITIVE,
                                   D3D_PRIMITIVE_TOPOLOGY, D3D_REGISTER_COMPONENT_TYPE,
                                   D3D_RESOURCE_RETURN_TYPE, D3D_SHADER_INPUT_TYPE,
                                   D3D_SHADER_MACRO, D3D_SHADER_VARIABLE_CLASS,
                                   D3D_SHADER_VARIABLE_TYPE, D3D_SRV_DIMENSION,
                                   ID3DBlob, ID3DInclude;
public import windows.displaydevices : RECT;
public import windows.dxgi : DXGI_FORMAT, DXGI_SAMPLE_DESC, DXGI_SWAP_CHAIN_DESC,
                             IDXGIAdapter, IDXGISwapChain;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


///Type of data contained in an input slot.
alias D3D10_INPUT_CLASSIFICATION = int;
enum : int
{
    ///Input data is per-vertex data.
    D3D10_INPUT_PER_VERTEX_DATA   = 0x00000000,
    ///Input data is per-instance data.
    D3D10_INPUT_PER_INSTANCE_DATA = 0x00000001,
}

///Determines the fill mode to use when rendering triangles.
alias D3D10_FILL_MODE = int;
enum : int
{
    ///Draw lines connecting the vertices. Adjacent vertices are not drawn.
    D3D10_FILL_WIREFRAME = 0x00000002,
    ///Fill the triangles formed by the vertices. Adjacent vertices are not drawn.
    D3D10_FILL_SOLID     = 0x00000003,
}

///Indicates triangles facing a particular direction are not drawn.
alias D3D10_CULL_MODE = int;
enum : int
{
    ///Always draw all triangles.
    D3D10_CULL_NONE  = 0x00000001,
    ///Do not draw triangles that are front-facing.
    D3D10_CULL_FRONT = 0x00000002,
    ///Do not draw triangles that are back-facing.
    D3D10_CULL_BACK  = 0x00000003,
}

///Identifies the type of resource being used.
alias D3D10_RESOURCE_DIMENSION = int;
enum : int
{
    ///Resource is of unknown type.
    D3D10_RESOURCE_DIMENSION_UNKNOWN   = 0x00000000,
    ///Resource is a buffer.
    D3D10_RESOURCE_DIMENSION_BUFFER    = 0x00000001,
    ///Resource is a 1D texture.
    D3D10_RESOURCE_DIMENSION_TEXTURE1D = 0x00000002,
    ///Resource is a 2D texture.
    D3D10_RESOURCE_DIMENSION_TEXTURE2D = 0x00000003,
    ///Resource is a 3D texture.
    D3D10_RESOURCE_DIMENSION_TEXTURE3D = 0x00000004,
}

///Specifies how to access a resource used in a depth-stencil view.
alias D3D10_DSV_DIMENSION = int;
enum : int
{
    ///The resource will be accessed according to its type as determined from the actual instance this enumeration is
    ///paired with when the depth-stencil view is created.
    D3D10_DSV_DIMENSION_UNKNOWN          = 0x00000000,
    ///The resource will be accessed as a 1D texture.
    D3D10_DSV_DIMENSION_TEXTURE1D        = 0x00000001,
    ///The resource will be accessed as an array of 1D textures.
    D3D10_DSV_DIMENSION_TEXTURE1DARRAY   = 0x00000002,
    ///The resource will be accessed as a 2D texture.
    D3D10_DSV_DIMENSION_TEXTURE2D        = 0x00000003,
    ///The resource will be accessed as an array of 2D texture.
    D3D10_DSV_DIMENSION_TEXTURE2DARRAY   = 0x00000004,
    ///The resource will be accessed as a 2D texture with multisampling.
    D3D10_DSV_DIMENSION_TEXTURE2DMS      = 0x00000005,
    ///The resource will be accessed as an array of 2D textures with multisampling.
    D3D10_DSV_DIMENSION_TEXTURE2DMSARRAY = 0x00000006,
}

///Specifies how to access a resource used in a render-target view.
alias D3D10_RTV_DIMENSION = int;
enum : int
{
    ///The resource will be accessed according to its type as determined from the actual instance this enumeration is
    ///paired with when the render-target view is created.
    D3D10_RTV_DIMENSION_UNKNOWN          = 0x00000000,
    ///The resource will be accessed as a buffer.
    D3D10_RTV_DIMENSION_BUFFER           = 0x00000001,
    ///The resource will be accessed as a 1D texture.
    D3D10_RTV_DIMENSION_TEXTURE1D        = 0x00000002,
    ///The resource will be accessed as an array of 1D textures.
    D3D10_RTV_DIMENSION_TEXTURE1DARRAY   = 0x00000003,
    ///The resource will be accessed as a 2D texture.
    D3D10_RTV_DIMENSION_TEXTURE2D        = 0x00000004,
    ///The resource will be accessed as an array of 2D textures.
    D3D10_RTV_DIMENSION_TEXTURE2DARRAY   = 0x00000005,
    ///The resource will be accessed as a 2D texture with multisampling.
    D3D10_RTV_DIMENSION_TEXTURE2DMS      = 0x00000006,
    ///The resource will be accessed as an array of 2D textures with multisampling.
    D3D10_RTV_DIMENSION_TEXTURE2DMSARRAY = 0x00000007,
    ///The resource will be accessed as a 3D texture.
    D3D10_RTV_DIMENSION_TEXTURE3D        = 0x00000008,
}

///Identifies expected resource use during rendering. The usage directly reflects whether a resource is accessible by
///the CPU and/or the GPU.
alias D3D10_USAGE = int;
enum : int
{
    ///A resource that requires read and write access by the GPU. This is likely to be the most common usage choice.
    D3D10_USAGE_DEFAULT   = 0x00000000,
    ///A resource that can only be read by the GPU. It cannot be written by the GPU, and cannot be accessed at all by
    ///the CPU. This type of resource must be initialized when it is created, since it cannot be changed after creation.
    D3D10_USAGE_IMMUTABLE = 0x00000001,
    ///A resource that is accessible by both the GPU and the CPU (write only). A dynamic resource is a good choice for a
    ///resource that will be updated by the CPU at least once per frame. To write to a dynamic resource on the CPU, use
    ///a <b>Map</b> method. You can write to a dynamic resource on the GPU using CopyResource or CopySubresourceRegion.
    D3D10_USAGE_DYNAMIC   = 0x00000002,
    ///A resource that supports data transfer (copy) from the GPU to the CPU.
    D3D10_USAGE_STAGING   = 0x00000003,
}

///Identifies how to bind a resource to the pipeline.
alias D3D10_BIND_FLAG = int;
enum : int
{
    ///Bind a buffer as a vertex buffer to the input-assembler stage.
    D3D10_BIND_VERTEX_BUFFER   = 0x00000001,
    ///Bind a buffer as an index buffer to the input-assembler stage.
    D3D10_BIND_INDEX_BUFFER    = 0x00000002,
    ///Bind a buffer as a constant buffer to a shader stage; this flag may NOT be combined with any other bind flag.
    D3D10_BIND_CONSTANT_BUFFER = 0x00000004,
    ///Bind a buffer or texture to a shader stage; this flag cannot be used with the D3D10_MAP_WRITE_NO_OVERWRITE flag.
    D3D10_BIND_SHADER_RESOURCE = 0x00000008,
    ///Bind an output buffer for the stream-output stage.
    D3D10_BIND_STREAM_OUTPUT   = 0x00000010,
    ///Bind a texture as a render target for the output-merger stage.
    D3D10_BIND_RENDER_TARGET   = 0x00000020,
    ///Bind a texture as a depth-stencil target for the output-merger stage.
    D3D10_BIND_DEPTH_STENCIL   = 0x00000040,
}

///Specifies the types of CPU access allowed for a resource.
alias D3D10_CPU_ACCESS_FLAG = int;
enum : int
{
    ///The resource is to be mappable so that the CPU can change its contents. Resources created with this flag cannot
    ///be set as outputs of the pipeline and must be created with either dynamic or staging usage (see D3D10_USAGE).
    D3D10_CPU_ACCESS_WRITE = 0x00010000,
    ///The resource is to be mappable so that the CPU can read its contents. Resources created with this flag cannot be
    ///set as either inputs or outputs to the pipeline and must be created with staging usage (see D3D10_USAGE).
    D3D10_CPU_ACCESS_READ  = 0x00020000,
}

///Identifies other, less common options for resources.
alias D3D10_RESOURCE_MISC_FLAG = int;
enum : int
{
    ///Enables an application to call ID3D10Device::GenerateMips on a texture resource. The resource must be created
    ///with the bind flags that specify that the resource is a render target and a shader resource.
    D3D10_RESOURCE_MISC_GENERATE_MIPS     = 0x00000001,
    ///Enables the sharing of resource data between two or more Direct3D devices. The only resources that can be shared
    ///are 2D non-mipmapped textures. WARP and REF devices do not support shared resources. Attempting to create a
    ///resource with this flag on either a WARP or REF device will cause the create method to return an E_OUTOFMEMORY
    ///error code.
    D3D10_RESOURCE_MISC_SHARED            = 0x00000002,
    ///Enables an application to create a cube texture from a Texture2DArray that contains 6 textures.
    D3D10_RESOURCE_MISC_TEXTURECUBE       = 0x00000004,
    ///Enables the resource created to be synchronized using the IDXGIKeyedMutex::AcquireSync and ReleaseSync APIs. The
    ///following resource creation D3D10 APIs, that all take a D3D10_RESOURCE_MISC_FLAG parameter, have been extended to
    ///support the new flag. <ul> <li>ID3D10Device1::CreateTexture1D</li> <li>ID3D10Device1::CreateTexture2D</li>
    ///<li>ID3D10Device1::CreateTexture3D</li> <li>ID3D10Device1::CreateBuffer</li> </ul> If any of the listed functions
    ///are called with the D3D10_RESOURCE_MISC_SHARED_KEYEDMUTEX flag set, the interface returned can be queried for an
    ///IDXGIKeyedMutex interface, which implements AcquireSync and ReleaseSync APIs to synchronize access to the
    ///surface. The device creating the surface, and any other device opening the surface (using OpenSharedResource) is
    ///required to call IDXGIKeyedMutex::AcquireSync before any rendering commands to the surface, and
    ///IDXGIKeyedMutex::ReleaseSync when it is done rendering. WARP and REF devices do not support shared resources.
    ///Attempting to create a resource with this flag on either a WARP or REF device will cause the create method to
    ///return an E_OUTOFMEMORY error code.
    D3D10_RESOURCE_MISC_SHARED_KEYEDMUTEX = 0x00000010,
    ///Enables a surface to be used for GDI interoperability. Setting this flag enables rendering on the surface via
    ///IDXGISurface1::GetDC.
    D3D10_RESOURCE_MISC_GDI_COMPATIBLE    = 0x00000020,
}

///Identifies a resource to be accessed for reading and writing by the CPU. Applications may combine one or more of
///these flags.
alias D3D10_MAP = int;
enum : int
{
    ///Resource is mapped for reading. The resource must have been created with read access (see D3D10_CPU_ACCESS_READ).
    D3D10_MAP_READ               = 0x00000001,
    ///Resource is mapped for writing. The resource must have been created with write access (see
    ///D3D10_CPU_ACCESS_WRITE).
    D3D10_MAP_WRITE              = 0x00000002,
    ///Resource is mapped for reading and writing. The resource must have been created with read and write access (see
    ///D3D10_CPU_ACCESS_READ and D3D10_CPU_ACCESS_WRITE).
    D3D10_MAP_READ_WRITE         = 0x00000003,
    ///Resource is mapped for writing; the previous contents of the resource will be undefined. The resource must have
    ///been created with write access (see D3D10_CPU_ACCESS_WRITE).
    D3D10_MAP_WRITE_DISCARD      = 0x00000004,
    ///Resource is mapped for writing; the existing contents of the resource cannot be overwritten (see Remarks). This
    ///flag is only valid on vertex and index buffers. The resource must have been created with write access (see
    ///D3D10_CPU_ACCESS_WRITE). Cannot be used on a resource created with the D3D10_BIND_CONSTANT_BUFFER flag.
    D3D10_MAP_WRITE_NO_OVERWRITE = 0x00000005,
}

///Specifies how the CPU should respond when Map is called on a resource being used by the GPU.
alias D3D10_MAP_FLAG = int;
enum : int
{
    ///Specifies that Map should return <b>DXGI_ERROR_WAS_STILL_DRAWING</b> when the GPU blocks the CPU from accessing a
    ///resource.
    D3D10_MAP_FLAG_DO_NOT_WAIT = 0x00100000,
}

///Option(s) for raising an error to a non-continuable exception.
alias D3D10_RAISE_FLAG = int;
enum : int
{
    ///Raise an internal driver error to a non-continuable exception.
    D3D10_RAISE_FLAG_DRIVER_INTERNAL_ERROR = 0x00000001,
}

///Specifies the parts of the depth stencil to clear. Usually used with ID3D10Device::ClearDepthStencilView.
alias D3D10_CLEAR_FLAG = int;
enum : int
{
    ///Clear the depth buffer.
    D3D10_CLEAR_DEPTH   = 0x00000001,
    ///Clear the stencil buffer.
    D3D10_CLEAR_STENCIL = 0x00000002,
}

///Comparison options.
alias D3D10_COMPARISON_FUNC = int;
enum : int
{
    ///Never pass the comparison.
    D3D10_COMPARISON_NEVER         = 0x00000001,
    ///If the source data is less than the destination data, the comparison passes.
    D3D10_COMPARISON_LESS          = 0x00000002,
    ///If the source data is equal to the destination data, the comparison passes.
    D3D10_COMPARISON_EQUAL         = 0x00000003,
    ///If the source data is less than or equal to the destination data, the comparison passes.
    D3D10_COMPARISON_LESS_EQUAL    = 0x00000004,
    ///If the source data is greater than the destination data, the comparison passes.
    D3D10_COMPARISON_GREATER       = 0x00000005,
    ///If the source data is not equal to the destination data, the comparison passes.
    D3D10_COMPARISON_NOT_EQUAL     = 0x00000006,
    ///If the source data is greater than or equal to the destination data, the comparison passes.
    D3D10_COMPARISON_GREATER_EQUAL = 0x00000007,
    ///Always pass the comparison.
    D3D10_COMPARISON_ALWAYS        = 0x00000008,
}

///Identify the portion of a depth-stencil buffer for writing depth data.
alias D3D10_DEPTH_WRITE_MASK = int;
enum : int
{
    ///Turn off writes to the depth-stencil buffer.
    D3D10_DEPTH_WRITE_MASK_ZERO = 0x00000000,
    ///Turn on writes to the depth-stencil buffer.
    D3D10_DEPTH_WRITE_MASK_ALL  = 0x00000001,
}

///The stencil operations that can be performed during depth-stencil testing.
alias D3D10_STENCIL_OP = int;
enum : int
{
    ///Keep the existing stencil data.
    D3D10_STENCIL_OP_KEEP     = 0x00000001,
    ///Set the stencil data to 0.
    D3D10_STENCIL_OP_ZERO     = 0x00000002,
    ///Set the stencil data to the reference value set by calling ID3D10Device::OMSetDepthStencilState.
    D3D10_STENCIL_OP_REPLACE  = 0x00000003,
    ///Increment the stencil value by 1, and clamp the result.
    D3D10_STENCIL_OP_INCR_SAT = 0x00000004,
    ///Decrement the stencil value by 1, and clamp the result.
    D3D10_STENCIL_OP_DECR_SAT = 0x00000005,
    ///Invert the stencil data.
    D3D10_STENCIL_OP_INVERT   = 0x00000006,
    ///Increment the stencil value by 1, and wrap the result if necessary.
    D3D10_STENCIL_OP_INCR     = 0x00000007,
    ///Increment the stencil value by 1, and wrap the result if necessary.
    D3D10_STENCIL_OP_DECR     = 0x00000008,
}

///Blend options. A blend option identifies the data source and an optional pre-blend operation.
alias D3D10_BLEND = int;
enum : int
{
    ///The data source is the color black (0, 0, 0, 0). No pre-blend operation.
    D3D10_BLEND_ZERO             = 0x00000001,
    ///The data source is the color white (1, 1, 1, 1). No pre-blend operation.
    D3D10_BLEND_ONE              = 0x00000002,
    ///The data source is color data (RGB) from a pixel shader. No pre-blend operation.
    D3D10_BLEND_SRC_COLOR        = 0x00000003,
    ///The data source is color data (RGB) from a pixel shader. The pre-blend operation inverts the data, generating 1 -
    ///RGB.
    D3D10_BLEND_INV_SRC_COLOR    = 0x00000004,
    ///The data source is alpha data (A) from a pixel shader. No pre-blend operation.
    D3D10_BLEND_SRC_ALPHA        = 0x00000005,
    ///The data source is alpha data (A) from a pixel shader. The pre-blend operation inverts the data, generating 1 -
    ///A.
    D3D10_BLEND_INV_SRC_ALPHA    = 0x00000006,
    ///The data source is alpha data from a rendertarget. No pre-blend operation.
    D3D10_BLEND_DEST_ALPHA       = 0x00000007,
    ///The data source is alpha data from a rendertarget. The pre-blend operation inverts the data, generating 1 - A.
    D3D10_BLEND_INV_DEST_ALPHA   = 0x00000008,
    ///The data source is color data from a rendertarget. No pre-blend operation.
    D3D10_BLEND_DEST_COLOR       = 0x00000009,
    ///The data source is color data from a rendertarget. The pre-blend operation inverts the data, generating 1 - RGB.
    D3D10_BLEND_INV_DEST_COLOR   = 0x0000000a,
    ///The data source is alpha data from a pixel shader. The pre-blend operation clamps the data to 1 or less.
    D3D10_BLEND_SRC_ALPHA_SAT    = 0x0000000b,
    ///The data source is the blend factor set with ID3D10Device::OMSetBlendState. No pre-blend operation.
    D3D10_BLEND_BLEND_FACTOR     = 0x0000000e,
    ///The data source is the blend factor set with ID3D10Device::OMSetBlendState. The pre-blend operation inverts the
    ///blend factor, generating 1 - blend_factor.
    D3D10_BLEND_INV_BLEND_FACTOR = 0x0000000f,
    ///The data sources are both color data output by a pixel shader. There is no pre-blend operation. This options
    ///supports dual-source color blending.
    D3D10_BLEND_SRC1_COLOR       = 0x00000010,
    ///The data sources are both color data output by a pixel shader. The pre-blend operation inverts the data,
    ///generating 1 - RGB. This options supports dual-source color blending.
    D3D10_BLEND_INV_SRC1_COLOR   = 0x00000011,
    ///The data sources are alpha data output by a pixel shader. There is no pre-blend operation. This options supports
    ///dual-source color blending.
    D3D10_BLEND_SRC1_ALPHA       = 0x00000012,
    ///The data sources are alpha data output by a pixel shader. The pre-blend operation inverts the data, generating 1
    ///- A. This options supports dual-source color blending.
    D3D10_BLEND_INV_SRC1_ALPHA   = 0x00000013,
}

///RGB or alpha blending operation.
alias D3D10_BLEND_OP = int;
enum : int
{
    ///Add source 1 and source 2.
    D3D10_BLEND_OP_ADD          = 0x00000001,
    ///Subtract source 1 from source 2.
    D3D10_BLEND_OP_SUBTRACT     = 0x00000002,
    ///Subtract source 2 from source 1.
    D3D10_BLEND_OP_REV_SUBTRACT = 0x00000003,
    ///Find the minimum of source 1 and source 2.
    D3D10_BLEND_OP_MIN          = 0x00000004,
    ///Find the maximum of source 1 and source 2.
    D3D10_BLEND_OP_MAX          = 0x00000005,
}

///Identify which components of each pixel of a render target are writable during blending.
alias D3D10_COLOR_WRITE_ENABLE = int;
enum : int
{
    ///Allow data to be stored in the red component.
    D3D10_COLOR_WRITE_ENABLE_RED   = 0x00000001,
    ///Allow data to be stored in the green component.
    D3D10_COLOR_WRITE_ENABLE_GREEN = 0x00000002,
    ///Allow data to be stored in the blue component.
    D3D10_COLOR_WRITE_ENABLE_BLUE  = 0x00000004,
    ///Allow data to be stored in the alpha component.
    D3D10_COLOR_WRITE_ENABLE_ALPHA = 0x00000008,
    ///Allow data to be stored in all components.
    D3D10_COLOR_WRITE_ENABLE_ALL   = 0x0000000f,
}

///The different faces of a cube texture.
alias D3D10_TEXTURECUBE_FACE = int;
enum : int
{
    ///Positive X face.
    D3D10_TEXTURECUBE_FACE_POSITIVE_X = 0x00000000,
    ///Negative X face.
    D3D10_TEXTURECUBE_FACE_NEGATIVE_X = 0x00000001,
    ///Positive Y face.
    D3D10_TEXTURECUBE_FACE_POSITIVE_Y = 0x00000002,
    ///Negative Y face.
    D3D10_TEXTURECUBE_FACE_NEGATIVE_Y = 0x00000003,
    ///Positive Z face.
    D3D10_TEXTURECUBE_FACE_POSITIVE_Z = 0x00000004,
    ///Negative Z face.
    D3D10_TEXTURECUBE_FACE_NEGATIVE_Z = 0x00000005,
}

///Filtering options during texture sampling.
alias D3D10_FILTER = int;
enum : int
{
    ///Use point sampling for minification, magnification, and mip-level sampling.
    D3D10_FILTER_MIN_MAG_MIP_POINT                          = 0x00000000,
    ///Use point sampling for minification and magnification; use linear interpolation for mip-level sampling.
    D3D10_FILTER_MIN_MAG_POINT_MIP_LINEAR                   = 0x00000001,
    ///Use point sampling for minification; use linear interpolation for magnification; use point sampling for mip-level
    ///sampling.
    D3D10_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT             = 0x00000004,
    ///Use point sampling for minification; use linear interpolation for magnification and mip-level sampling.
    D3D10_FILTER_MIN_POINT_MAG_MIP_LINEAR                   = 0x00000005,
    ///Use linear interpolation for minification; use point sampling for magnification and mip-level sampling.
    D3D10_FILTER_MIN_LINEAR_MAG_MIP_POINT                   = 0x00000010,
    ///Use linear interpolation for minification; use point sampling for magnification; use linear interpolation for
    ///mip-level sampling.
    D3D10_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR            = 0x00000011,
    ///Use linear interpolation for minification and magnification; use point sampling for mip-level sampling.
    D3D10_FILTER_MIN_MAG_LINEAR_MIP_POINT                   = 0x00000014,
    ///Use linear interpolation for minification, magnification, and mip-level sampling.
    D3D10_FILTER_MIN_MAG_MIP_LINEAR                         = 0x00000015,
    ///Use anisotropic interpolation for minification, magnification, and mip-level sampling.
    D3D10_FILTER_ANISOTROPIC                                = 0x00000055,
    ///Use point sampling for minification, magnification, and mip-level sampling. Compare the result to the comparison
    ///value.
    D3D10_FILTER_COMPARISON_MIN_MAG_MIP_POINT               = 0x00000080,
    ///Use point sampling for minification and magnification; use linear interpolation for mip-level sampling. Compare
    ///the result to the comparison value.
    D3D10_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR        = 0x00000081,
    ///Use point sampling for minification; use linear interpolation for magnification; use point sampling for mip-level
    ///sampling. Compare the result to the comparison value.
    D3D10_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT  = 0x00000084,
    ///Use point sampling for minification; use linear interpolation for magnification and mip-level sampling. Compare
    ///the result to the comparison value.
    D3D10_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR        = 0x00000085,
    ///Use linear interpolation for minification; use point sampling for magnification and mip-level sampling. Compare
    ///the result to the comparison value.
    D3D10_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT        = 0x00000090,
    ///Use linear interpolation for minification; use point sampling for magnification; use linear interpolation for
    ///mip-level sampling. Compare the result to the comparison value.
    D3D10_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x00000091,
    ///Use linear interpolation for minification and magnification; use point sampling for mip-level sampling. Compare
    ///the result to the comparison value.
    D3D10_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT        = 0x00000094,
    ///Use linear interpolation for minification, magnification, and mip-level sampling. Compare the result to the
    ///comparison value.
    D3D10_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR              = 0x00000095,
    ///Use anisotropic interpolation for minification, magnification, and mip-level sampling. Compare the result to the
    ///comparison value.
    D3D10_FILTER_COMPARISON_ANISOTROPIC                     = 0x000000d5,
    ///For use in pixel shaders with textures that have the R1_UNORM format.
    D3D10_FILTER_TEXT_1BIT                                  = 0x80000000,
}

///Types of magnification or minification sampler filters.
alias D3D10_FILTER_TYPE = int;
enum : int
{
    ///Point filtering used as a texture magnification or minification filter. The texel with coordinates nearest to the
    ///desired pixel value is used. The texture filter to be used between mipmap levels is nearest-point mipmap
    ///filtering. The rasterizer uses the color from the texel of the nearest mipmap texture.
    D3D10_FILTER_TYPE_POINT  = 0x00000000,
    ///Bilinear interpolation filtering used as a texture magnification or minification filter. A weighted average of a
    ///2 x 2 area of texels surrounding the desired pixel is used. The texture filter to use between mipmap levels is
    ///trilinear mipmap interpolation. The rasterizer linearly interpolates pixel color, using the texels of the two
    ///nearest mipmap textures.
    D3D10_FILTER_TYPE_LINEAR = 0x00000001,
}

///Identify a technique for resolving texture coordinates that are outside of the boundaries of a texture.
alias D3D10_TEXTURE_ADDRESS_MODE = int;
enum : int
{
    ///Tile the texture at every integer junction. For example, for u values between 0 and 3, the texture is repeated
    ///three times.
    D3D10_TEXTURE_ADDRESS_WRAP        = 0x00000001,
    ///Flip the texture at every integer junction. For u values between 0 and 1, for example, the texture is addressed
    ///normally; between 1 and 2, the texture is flipped (mirrored); between 2 and 3, the texture is normal again; and
    ///so on.
    D3D10_TEXTURE_ADDRESS_MIRROR      = 0x00000002,
    ///Texture coordinates outside the range [0.0, 1.0] are set to the texture color at 0.0 or 1.0, respectively.
    D3D10_TEXTURE_ADDRESS_CLAMP       = 0x00000003,
    ///Texture coordinates outside the range [0.0, 1.0] are set to the border color specified in D3D10_SAMPLER_DESC or
    ///HLSL code.
    D3D10_TEXTURE_ADDRESS_BORDER      = 0x00000004,
    ///Similar to D3D10_TEXTURE_ADDRESS_MIRROR and D3D10_TEXTURE_ADDRESS_CLAMP. Takes the absolute value of the texture
    ///coordinate (thus, mirroring around 0), and then clamps to the maximum value.
    D3D10_TEXTURE_ADDRESS_MIRROR_ONCE = 0x00000005,
}

///Which resources are supported for a given format and given device (see ID3D10Device::CheckFormatSupport).
alias D3D10_FORMAT_SUPPORT = int;
enum : int
{
    ///Buffer resources supported.
    D3D10_FORMAT_SUPPORT_BUFFER                   = 0x00000001,
    ///Vertex buffers supported.
    D3D10_FORMAT_SUPPORT_IA_VERTEX_BUFFER         = 0x00000002,
    ///Index buffers supported.
    D3D10_FORMAT_SUPPORT_IA_INDEX_BUFFER          = 0x00000004,
    ///Streaming output buffers supported.
    D3D10_FORMAT_SUPPORT_SO_BUFFER                = 0x00000008,
    ///1D texture resources supported.
    D3D10_FORMAT_SUPPORT_TEXTURE1D                = 0x00000010,
    ///2D texture resources supported.
    D3D10_FORMAT_SUPPORT_TEXTURE2D                = 0x00000020,
    ///3D texture resources supported.
    D3D10_FORMAT_SUPPORT_TEXTURE3D                = 0x00000040,
    ///Cube texture resources supported.
    D3D10_FORMAT_SUPPORT_TEXTURECUBE              = 0x00000080,
    ///The intrinsic HLSL function load is supported.
    D3D10_FORMAT_SUPPORT_SHADER_LOAD              = 0x00000100,
    ///The intrinsic HLSL functions Sample supported.
    D3D10_FORMAT_SUPPORT_SHADER_SAMPLE            = 0x00000200,
    ///The intrinsic HLSL functions SampleCmp and SampleCmpLevelZero are supported.
    D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON = 0x00000400,
    ///Reserved.
    D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT  = 0x00000800,
    ///Mipmaps are supported.
    D3D10_FORMAT_SUPPORT_MIP                      = 0x00001000,
    ///Automatic generation of mipmaps is supported.
    D3D10_FORMAT_SUPPORT_MIP_AUTOGEN              = 0x00002000,
    ///Rendertargets are supported.
    D3D10_FORMAT_SUPPORT_RENDER_TARGET            = 0x00004000,
    ///Render target blend operations supported.
    D3D10_FORMAT_SUPPORT_BLENDABLE                = 0x00008000,
    ///Depth stencils supported.
    D3D10_FORMAT_SUPPORT_DEPTH_STENCIL            = 0x00010000,
    ///CPU locking supported.
    D3D10_FORMAT_SUPPORT_CPU_LOCKABLE             = 0x00020000,
    ///Multisampling resolution supported.
    D3D10_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE      = 0x00040000,
    ///Format can be displayed on screen.
    D3D10_FORMAT_SUPPORT_DISPLAY                  = 0x00080000,
    ///Format cannot be cast to another format.
    D3D10_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT   = 0x00100000,
    ///Format can be used as a multisampled rendertarget.
    D3D10_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET = 0x00200000,
    ///Format can be used as a multisampled texture and read into a shader with the load function.
    D3D10_FORMAT_SUPPORT_MULTISAMPLE_LOAD         = 0x00400000,
    ///Format can be used with the gather function. This value is available in DirectX 10.1 or higher.
    D3D10_FORMAT_SUPPORT_SHADER_GATHER            = 0x00800000,
    D3D10_FORMAT_SUPPORT_BACK_BUFFER_CAST         = 0x01000000,
}

///Optional flags that control the behavior of ID3D10Asynchronous::GetData.
alias D3D10_ASYNC_GETDATA_FLAG = int;
enum : int
{
    ///Do not flush the command buffer. This can potentially cause an infinite loop if GetData is continually called
    ///until it returns S_OK as there may still be commands in the command buffer that need to be processed in order for
    ///GetData to return S_OK. Since the commands in the command buffer are not flushed they will not be processed and
    ///therefore GetData will never return S_OK.
    D3D10_ASYNC_GETDATA_DONOTFLUSH = 0x00000001,
}

///Query types.
alias D3D10_QUERY = int;
enum : int
{
    ///Determines whether or not the GPU is finished processing commands. When the GPU is finished processing commands
    ///GetData will return S_OK, and pData will point to a BOOL with a value of <b>TRUE</b>. When using this type of
    ///query, Begin is disabled.
    D3D10_QUERY_EVENT                 = 0x00000000,
    ///Get the number of samples that passed the depth and stencil tests in between Begin and End. GetData returns a
    ///UINT64. If a depth or stencil test is disabled, then each of those tests will be counted as a pass.
    D3D10_QUERY_OCCLUSION             = 0x00000001,
    ///Get a timestamp value where GetData returns a UINT64. This kind of query is only useful if two timestamp queries
    ///are done in the middle of a D3D10_QUERY_TIMESTAMP_DISJOINT query. The difference of two timestamps can be used to
    ///determine how many ticks have elapsed, and the D3D10_QUERY_TIMESTAMP_DISJOINT query will determine if that
    ///difference is a reliable value and also has a value that shows how to convert the number of ticks into seconds.
    ///See D3D10_QUERY_DATA_TIMESTAMP_DISJOINT. When using this type of query, Begin is disabled.
    D3D10_QUERY_TIMESTAMP             = 0x00000002,
    ///Determines whether or not a D3D10_QUERY_TIMESTAMP is returning reliable values, and also gives the frequency of
    ///the processor enabling you to convert the number of elapsed ticks into seconds. GetData will return a
    ///D3D10_QUERY_DATA_TIMESTAMP_DISJOINT. This type of query should only be invoked once per frame or less.
    D3D10_QUERY_TIMESTAMP_DISJOINT    = 0x00000003,
    ///Get pipeline statistics, such as the number of pixel shader invocations in between Begin and End. GetData will
    ///return a D3D10_QUERY_DATA_PIPELINE_STATISTICS.
    D3D10_QUERY_PIPELINE_STATISTICS   = 0x00000004,
    ///Similar to D3D10_QUERY_OCCLUSION, except GetData returns a BOOL indicating whether or not any samples passed the
    ///depth and stencil tests - <b>TRUE</b> meaning at least one passed, <b>FALSE</b> meaning none passed.
    D3D10_QUERY_OCCLUSION_PREDICATE   = 0x00000005,
    ///Get streaming output statistics, such as the number of primitives streamed out in between Begin and End. GetData
    ///will return a D3D10_QUERY_DATA_SO_STATISTICS structure.
    D3D10_QUERY_SO_STATISTICS         = 0x00000006,
    ///Determines whether or not any of the streaming output buffers overflowed in between Begin and End. GetData
    ///returns a BOOL - <b>TRUE</b> meaning there was an overflow, <b>FALSE</b> meaning there was not an overflow. If
    ///streaming output writes to multiple buffers, and one of the buffers overflows, then it will stop writing to all
    ///the output buffers. When an overflow is detected by Direct3D it is prevented from happening - no memory is
    ///corrupted. This predication may be used in conjunction with an SO_STATISTICS query so that when an overflow
    ///occurs the SO_STATISTIC query will let the application know how much memory was needed to prevent an overflow.
    D3D10_QUERY_SO_OVERFLOW_PREDICATE = 0x00000007,
}

///Flags that describe miscellaneous query behavior.
alias D3D10_QUERY_MISC_FLAG = int;
enum : int
{
    ///Tell the hardware that if it is not yet sure if something is hidden or not to draw it anyway. This is only used
    ///with an occlusion predicate. Predication data cannot be returned to your application via
    ///ID3D10Asynchronous::GetData when using this flag.
    D3D10_QUERY_MISC_PREDICATEHINT = 0x00000001,
}

///Performance counter types.
alias D3D10_COUNTER = int;
enum : int
{
    ///Percentage of the time that the GPU is idle.
    D3D10_COUNTER_GPU_IDLE                              = 0x00000000,
    ///Percentage of the time that the GPU does vertex processing.
    D3D10_COUNTER_VERTEX_PROCESSING                     = 0x00000001,
    ///Percentage of the time that the GPU does geometry processing.
    D3D10_COUNTER_GEOMETRY_PROCESSING                   = 0x00000002,
    ///Percentage of the time that the GPU does pixel processing.
    D3D10_COUNTER_PIXEL_PROCESSING                      = 0x00000003,
    ///Percentage of the time that the GPU does other processing (not vertex, geometry, or pixel processing).
    D3D10_COUNTER_OTHER_GPU_PROCESSING                  = 0x00000004,
    ///Percentage of bandwidth used on a host adapter. Value returned by ID3D10Asynchronous::GetData between 0.0 and 1.0
    ///when using this counter.
    D3D10_COUNTER_HOST_ADAPTER_BANDWIDTH_UTILIZATION    = 0x00000005,
    ///Percentage of bandwidth used by the local video memory. Value returned by ID3D10Asynchronous::GetData between 0.0
    ///and 1.0 when using this counter
    D3D10_COUNTER_LOCAL_VIDMEM_BANDWIDTH_UTILIZATION    = 0x00000006,
    ///Percentage of throughput used for vertices. Value returned by ID3D10Asynchronous::GetData between 0.0 and 1.0
    ///when using this counter
    D3D10_COUNTER_VERTEX_THROUGHPUT_UTILIZATION         = 0x00000007,
    ///Percentage of throughput used for triangle setup. Value returned by ID3D10Asynchronous::GetData between 0.0 and
    ///1.0 when using this counter
    D3D10_COUNTER_TRIANGLE_SETUP_THROUGHPUT_UTILIZATION = 0x00000008,
    ///Percentage of throughput used for the fillrate. Value returned by ID3D10Asynchronous::GetData between 0.0 and 1.0
    ///when using this counter.
    D3D10_COUNTER_FILLRATE_THROUGHPUT_UTILIZATION       = 0x00000009,
    ///Percentage of time that a vertex shader spends sampling resources.
    D3D10_COUNTER_VS_MEMORY_LIMITED                     = 0x0000000a,
    ///Percentage of time that a vertex shader spends doing computations.
    D3D10_COUNTER_VS_COMPUTATION_LIMITED                = 0x0000000b,
    ///Percentage of time that a geometry shader spends sampling resources.
    D3D10_COUNTER_GS_MEMORY_LIMITED                     = 0x0000000c,
    ///Percentage of time that a geometry shader spends doing computations.
    D3D10_COUNTER_GS_COMPUTATION_LIMITED                = 0x0000000d,
    ///Percentage of time that a pixel shader spends sampling resources.
    D3D10_COUNTER_PS_MEMORY_LIMITED                     = 0x0000000e,
    ///Percentage of time that a pixel shader spends doing computations.
    D3D10_COUNTER_PS_COMPUTATION_LIMITED                = 0x0000000f,
    ///Percentage of vertex data that was read from the vertex cache. For example, if 6 vertices were added to the cache
    ///and 3 of them were read from the cache, then the hit rate would be 0.5.
    D3D10_COUNTER_POST_TRANSFORM_CACHE_HIT_RATE         = 0x00000010,
    ///Percentage of texel data that was read from the vertex cache. For example, if 6 texels were added to the cache
    ///and 3 of them were read from the cache, then the hit rate would be 0.5.
    D3D10_COUNTER_TEXTURE_CACHE_HIT_RATE                = 0x00000011,
    ///Start of the device-dependent counters. See remarks.
    D3D10_COUNTER_DEVICE_DEPENDENT_0                    = 0x40000000,
}

///Data type of a performance counter.
alias D3D10_COUNTER_TYPE = int;
enum : int
{
    ///32-bit floating point.
    D3D10_COUNTER_TYPE_FLOAT32 = 0x00000000,
    ///16-bit unsigned integer.
    D3D10_COUNTER_TYPE_UINT16  = 0x00000001,
    ///32-bit unsigned integer.
    D3D10_COUNTER_TYPE_UINT32  = 0x00000002,
    ///64-bit unsigned integer.
    D3D10_COUNTER_TYPE_UINT64  = 0x00000003,
}

///Device creation flags.
alias D3D10_CREATE_DEVICE_FLAG = int;
enum : int
{
    ///Use this flag if an application will only be calling D3D10 from a single thread. If this flag is not specified,
    ///the default behavior of D3D10 is to enter a lock during each API call to prevent multiple threads altering
    ///internal state. By using this flag no locks will be taken which can slightly increase performance, but could
    ///result in undefine behavior if D3D10 is called from multiple threads.
    D3D10_CREATE_DEVICE_SINGLETHREADED                                = 0x00000001,
    ///Create a device that supports the debug layer.
    D3D10_CREATE_DEVICE_DEBUG                                         = 0x00000002,
    ///Create both a software (REF) and hardware (HAL) version of the device simultaneously, which allows an application
    ///to switch to a reference device to enable debugging. See ID3D10SwitchToRef Interface for more information.
    D3D10_CREATE_DEVICE_SWITCH_TO_REF                                 = 0x00000004,
    ///Prevents multiple threads from being created. When this flag is used with a WARP device, no additional threads
    ///will be created by WARP and all rasterization will occur on the calling thread. This flag is not recommended for
    ///general use. See remarks.
    D3D10_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS      = 0x00000008,
    ///Return a <b>NULL</b> pointer instead of triggering an exception on memory exhaustion during invocations to Map.
    ///Without this flag an exception will be raised on memory exhaustion. Only valid on Winodws 7.
    D3D10_CREATE_DEVICE_ALLOW_NULL_FROM_MAP                           = 0x00000010,
    ///Causes device creation to fail if BGRA support is not available. BGRA support enables the following formats. <ul>
    ///<li>DXGI_FORMAT_B8G8R8A8_TYPELESS</li> <li>DXGI_FORMAT_B8G8R8A8_UNORM</li>
    ///<li>DXGI_FORMAT_B8G8R8A8_UNORM_SRGB</li> <li>DXGI_FORMAT_B8G8R8X8_TYPELESS</li>
    ///<li>DXGI_FORMAT_B8G8R8X8_UNORM</li> <li>DXGI_FORMAT_B8G8R8X8_UNORM_SRGB</li> </ul>
    ///D3D10_CREATE_DEVICE_BGRA_SUPPORT is only relevant when a device is created with D3D10CreateDevice1 or
    ///D3D10CreateDeviceAndSwapChain1 using the <b>D3D10_FEATURE_LEVEL_10_0</b> or <b>D3D10_FEATURE_LEVEL_10_1</b>
    ///feature levels, the flag will be ignored when a device is created with other feature levels. Note that BGRA
    ///support may be present even if the application didn't specify D3D10_CREATE_DEVICE_BGRA_SUPPORT. The flag merely
    ///causes device creation to fail if BGRA support isn't available. D3D10_CREATE_DEVICE_BGRA_SUPPORT is only valid on
    ///Windows 7, Windows Server 2008 R2, and updated Windows Vista (KB971644) systems.
    D3D10_CREATE_DEVICE_BGRA_SUPPORT                                  = 0x00000020,
    ///Causes the Direct3D runtime to ignore registry settings that turn on the debug layer. You can turn on the debug
    ///layer by using the DirectX Control Panel that was included as part of the DirectX SDK. We shipped the last
    ///version of the DirectX SDK in June 2010; you can download it from the Microsoft Download Center. You can set this
    ///flag in your app, typically in release builds only, to prevent end users from using the DirectX Control Panel to
    ///monitor how the app uses Direct3D. <div class="alert"><b>Note</b> You can also set this flag in your app to
    ///prevent Direct3D debugging tools, such as Visual Studio Ultimate 2012, from hooking your app.</div> <div> </div>
    ///<b>Windows 8.1: </b>This flag doesn't prevent Visual Studio 2013 and later running on Windows 8.1 and later from
    ///hooking your app. But, this flag still prevents Visual Studio 2013 and later running on Windows 8 and earlier
    ///from hooking your app. <b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D10_CREATE_DEVICE_PREVENT_ALTERING_LAYER_SETTINGS_FROM_REGISTRY = 0x00000080,
    ///Reserved. This flag is currently not supported. Do not use.
    D3D10_CREATE_DEVICE_STRICT_VALIDATION                             = 0x00000200,
    ///Causes the device and driver to keep information that you can use for shader debugging. The exact impact from
    ///this flag will vary from driver to driver. To use this flag, you must have D3D11_1SDKLayers.dll installed;
    ///otherwise, device creation fails. The created device supports the debug layer. To get D3D11_1SDKLayers.dll, you
    ///must install the SDK for Windows 8. <b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D10_CREATE_DEVICE_DEBUGGABLE                                    = 0x00000400,
}

///Categories of debug messages. This will identify the category of a message when retrieving a message with
///ID3D10InfoQueue::GetMessage and when adding a message with ID3D10InfoQueue::AddMessage. When creating an info queue
///filter, these values can be used to allow or deny any categories of messages to pass through the storage and
///retrieval filters.
alias D3D10_MESSAGE_CATEGORY = int;
enum : int
{
    ///User defined message. See ID3D10InfoQueue::AddMessage.
    D3D10_MESSAGE_CATEGORY_APPLICATION_DEFINED   = 0x00000000,
    D3D10_MESSAGE_CATEGORY_MISCELLANEOUS         = 0x00000001,
    D3D10_MESSAGE_CATEGORY_INITIALIZATION        = 0x00000002,
    D3D10_MESSAGE_CATEGORY_CLEANUP               = 0x00000003,
    D3D10_MESSAGE_CATEGORY_COMPILATION           = 0x00000004,
    D3D10_MESSAGE_CATEGORY_STATE_CREATION        = 0x00000005,
    D3D10_MESSAGE_CATEGORY_STATE_SETTING         = 0x00000006,
    D3D10_MESSAGE_CATEGORY_STATE_GETTING         = 0x00000007,
    D3D10_MESSAGE_CATEGORY_RESOURCE_MANIPULATION = 0x00000008,
    D3D10_MESSAGE_CATEGORY_EXECUTION             = 0x00000009,
    D3D10_MESSAGE_CATEGORY_SHADER                = 0x0000000a,
}

///Debug message severity levels for an information queue.
alias D3D10_MESSAGE_SEVERITY = int;
enum : int
{
    ///Defines some type of corruption which has occurred.
    D3D10_MESSAGE_SEVERITY_CORRUPTION = 0x00000000,
    ///Defines an error message.
    D3D10_MESSAGE_SEVERITY_ERROR      = 0x00000001,
    ///Defines a warning message.
    D3D10_MESSAGE_SEVERITY_WARNING    = 0x00000002,
    ///Defines an information message.
    D3D10_MESSAGE_SEVERITY_INFO       = 0x00000003,
    D3D10_MESSAGE_SEVERITY_MESSAGE    = 0x00000004,
}

///Debug messages for setting up an info-queue filter (see D3D10_INFO_QUEUE_FILTER); use these messages to allow or deny
///message categories to pass through the storage and retrieval filters. These IDs are used by methods such as
///ID3D10InfoQueue::GetMessage or ID3D10InfoQueue::AddMessage.
alias D3D10_MESSAGE_ID = int;
enum : int
{
    D3D10_MESSAGE_ID_UNKNOWN                                                                     = 0x00000000,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_HAZARD                                            = 0x00000001,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_HAZARD                                              = 0x00000002,
    D3D10_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_HAZARD                                          = 0x00000003,
    D3D10_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_HAZARD                                          = 0x00000004,
    D3D10_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_HAZARD                                          = 0x00000005,
    D3D10_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_HAZARD                                          = 0x00000006,
    D3D10_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_HAZARD                                          = 0x00000007,
    D3D10_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_HAZARD                                          = 0x00000008,
    D3D10_MESSAGE_ID_DEVICE_OMSETRENDERTARGETS_HAZARD                                            = 0x00000009,
    D3D10_MESSAGE_ID_DEVICE_SOSETTARGETS_HAZARD                                                  = 0x0000000a,
    D3D10_MESSAGE_ID_STRING_FROM_APPLICATION                                                     = 0x0000000b,
    D3D10_MESSAGE_ID_CORRUPTED_THIS                                                              = 0x0000000c,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER1                                                        = 0x0000000d,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER2                                                        = 0x0000000e,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER3                                                        = 0x0000000f,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER4                                                        = 0x00000010,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER5                                                        = 0x00000011,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER6                                                        = 0x00000012,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER7                                                        = 0x00000013,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER8                                                        = 0x00000014,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER9                                                        = 0x00000015,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER10                                                       = 0x00000016,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER11                                                       = 0x00000017,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER12                                                       = 0x00000018,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER13                                                       = 0x00000019,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER14                                                       = 0x0000001a,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER15                                                       = 0x0000001b,
    D3D10_MESSAGE_ID_CORRUPTED_MULTITHREADING                                                    = 0x0000001c,
    D3D10_MESSAGE_ID_MESSAGE_REPORTING_OUTOFMEMORY                                               = 0x0000001d,
    D3D10_MESSAGE_ID_IASETINPUTLAYOUT_UNBINDDELETINGOBJECT                                       = 0x0000001e,
    D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_UNBINDDELETINGOBJECT                                     = 0x0000001f,
    D3D10_MESSAGE_ID_IASETINDEXBUFFER_UNBINDDELETINGOBJECT                                       = 0x00000020,
    D3D10_MESSAGE_ID_VSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x00000021,
    D3D10_MESSAGE_ID_VSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x00000022,
    D3D10_MESSAGE_ID_VSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x00000023,
    D3D10_MESSAGE_ID_VSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x00000024,
    D3D10_MESSAGE_ID_GSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x00000025,
    D3D10_MESSAGE_ID_GSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x00000026,
    D3D10_MESSAGE_ID_GSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x00000027,
    D3D10_MESSAGE_ID_GSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x00000028,
    D3D10_MESSAGE_ID_SOSETTARGETS_UNBINDDELETINGOBJECT                                           = 0x00000029,
    D3D10_MESSAGE_ID_PSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x0000002a,
    D3D10_MESSAGE_ID_PSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x0000002b,
    D3D10_MESSAGE_ID_PSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x0000002c,
    D3D10_MESSAGE_ID_PSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x0000002d,
    D3D10_MESSAGE_ID_RSSETSTATE_UNBINDDELETINGOBJECT                                             = 0x0000002e,
    D3D10_MESSAGE_ID_OMSETBLENDSTATE_UNBINDDELETINGOBJECT                                        = 0x0000002f,
    D3D10_MESSAGE_ID_OMSETDEPTHSTENCILSTATE_UNBINDDELETINGOBJECT                                 = 0x00000030,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_UNBINDDELETINGOBJECT                                     = 0x00000031,
    D3D10_MESSAGE_ID_SETPREDICATION_UNBINDDELETINGOBJECT                                         = 0x00000032,
    D3D10_MESSAGE_ID_GETPRIVATEDATA_MOREDATA                                                     = 0x00000033,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDFREEDATA                                              = 0x00000034,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDIUNKNOWN                                              = 0x00000035,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDFLAGS                                                 = 0x00000036,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_CHANGINGPARAMS                                               = 0x00000037,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_OUTOFMEMORY                                                  = 0x00000038,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDFORMAT                                             = 0x00000039,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDSAMPLES                                                 = 0x0000003a,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDUSAGE                                              = 0x0000003b,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDBINDFLAGS                                          = 0x0000003c,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDCPUACCESSFLAGS                                     = 0x0000003d,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDMISCFLAGS                                          = 0x0000003e,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDCPUACCESSFLAGS                                          = 0x0000003f,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDBINDFLAGS                                               = 0x00000040,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDINITIALDATA                                             = 0x00000041,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDDIMENSIONS                                              = 0x00000042,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDMIPLEVELS                                               = 0x00000043,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDMISCFLAGS                                               = 0x00000044,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDARG_RETURN                                              = 0x00000045,
    D3D10_MESSAGE_ID_CREATEBUFFER_OUTOFMEMORY_RETURN                                             = 0x00000046,
    D3D10_MESSAGE_ID_CREATEBUFFER_NULLDESC                                                       = 0x00000047,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDCONSTANTBUFFERBINDINGS                                  = 0x00000048,
    D3D10_MESSAGE_ID_CREATEBUFFER_LARGEALLOCATION                                                = 0x00000049,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDFORMAT                                          = 0x0000004a,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNSUPPORTEDFORMAT                                           = 0x0000004b,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDSAMPLES                                              = 0x0000004c,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDUSAGE                                           = 0x0000004d,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDBINDFLAGS                                       = 0x0000004e,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDCPUACCESSFLAGS                                  = 0x0000004f,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDMISCFLAGS                                       = 0x00000050,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDCPUACCESSFLAGS                                       = 0x00000051,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDBINDFLAGS                                            = 0x00000052,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDINITIALDATA                                          = 0x00000053,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDDIMENSIONS                                           = 0x00000054,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDMIPLEVELS                                            = 0x00000055,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDMISCFLAGS                                            = 0x00000056,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDARG_RETURN                                           = 0x00000057,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_OUTOFMEMORY_RETURN                                          = 0x00000058,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_NULLDESC                                                    = 0x00000059,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_LARGEALLOCATION                                             = 0x0000005a,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDFORMAT                                          = 0x0000005b,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNSUPPORTEDFORMAT                                           = 0x0000005c,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDSAMPLES                                              = 0x0000005d,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDUSAGE                                           = 0x0000005e,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDBINDFLAGS                                       = 0x0000005f,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDCPUACCESSFLAGS                                  = 0x00000060,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDMISCFLAGS                                       = 0x00000061,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDCPUACCESSFLAGS                                       = 0x00000062,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDBINDFLAGS                                            = 0x00000063,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDINITIALDATA                                          = 0x00000064,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDDIMENSIONS                                           = 0x00000065,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDMIPLEVELS                                            = 0x00000066,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDMISCFLAGS                                            = 0x00000067,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDARG_RETURN                                           = 0x00000068,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_OUTOFMEMORY_RETURN                                          = 0x00000069,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_NULLDESC                                                    = 0x0000006a,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_LARGEALLOCATION                                             = 0x0000006b,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDFORMAT                                          = 0x0000006c,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNSUPPORTEDFORMAT                                           = 0x0000006d,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDSAMPLES                                              = 0x0000006e,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDUSAGE                                           = 0x0000006f,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDBINDFLAGS                                       = 0x00000070,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDCPUACCESSFLAGS                                  = 0x00000071,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDMISCFLAGS                                       = 0x00000072,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDCPUACCESSFLAGS                                       = 0x00000073,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDBINDFLAGS                                            = 0x00000074,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDINITIALDATA                                          = 0x00000075,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDDIMENSIONS                                           = 0x00000076,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDMIPLEVELS                                            = 0x00000077,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDMISCFLAGS                                            = 0x00000078,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDARG_RETURN                                           = 0x00000079,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_OUTOFMEMORY_RETURN                                          = 0x0000007a,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_NULLDESC                                                    = 0x0000007b,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_LARGEALLOCATION                                             = 0x0000007c,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT                                 = 0x0000007d,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDESC                                        = 0x0000007e,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFORMAT                                      = 0x0000007f,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS                                  = 0x00000080,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDRESOURCE                                    = 0x00000081,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_TOOMANYOBJECTS                                     = 0x00000082,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDARG_RETURN                                  = 0x00000083,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_OUTOFMEMORY_RETURN                                 = 0x00000084,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT                                   = 0x00000085,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT                                    = 0x00000086,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDESC                                          = 0x00000087,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDFORMAT                                        = 0x00000088,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDIMENSIONS                                    = 0x00000089,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDRESOURCE                                      = 0x0000008a,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_TOOMANYOBJECTS                                       = 0x0000008b,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDARG_RETURN                                    = 0x0000008c,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_OUTOFMEMORY_RETURN                                   = 0x0000008d,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT                                   = 0x0000008e,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDESC                                          = 0x0000008f,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFORMAT                                        = 0x00000090,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS                                    = 0x00000091,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE                                      = 0x00000092,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_TOOMANYOBJECTS                                       = 0x00000093,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDARG_RETURN                                    = 0x00000094,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_OUTOFMEMORY_RETURN                                   = 0x00000095,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_OUTOFMEMORY                                               = 0x00000096,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TOOMANYELEMENTS                                           = 0x00000097,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDFORMAT                                             = 0x00000098,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT                                        = 0x00000099,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOT                                               = 0x0000009a,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS                                     = 0x0000009b,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH                                 = 0x0000009c,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE                                    = 0x0000009d,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE                                     = 0x0000009e,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDALIGNMENT                                          = 0x0000009f,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_DUPLICATESEMANTIC                                         = 0x000000a0,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE                                 = 0x000000a1,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_NULLSEMANTIC                                              = 0x000000a2,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_MISSINGELEMENT                                            = 0x000000a3,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_NULLDESC                                                  = 0x000000a4,
    D3D10_MESSAGE_ID_CREATEVERTEXSHADER_OUTOFMEMORY                                              = 0x000000a5,
    D3D10_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERBYTECODE                                    = 0x000000a6,
    D3D10_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERTYPE                                        = 0x000000a7,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_OUTOFMEMORY                                            = 0x000000a8,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE                                  = 0x000000a9,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERTYPE                                      = 0x000000aa,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY                            = 0x000000ab,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE                  = 0x000000ac,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE                      = 0x000000ad,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES                      = 0x000000ae,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED               = 0x000000af,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDDECL                         = 0x000000b0,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_EXPECTEDDECL                           = 0x000000b1,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED                    = 0x000000b2,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT                      = 0x000000b3,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT                  = 0x000000b4,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT                  = 0x000000b5,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT = 0x000000b6,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION                   = 0x000000b7,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT                         = 0x000000b8,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE              = 0x000000b9,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC                        = 0x000000ba,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH                           = 0x000000bb,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS                       = 0x000000bc,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX                         = 0x000000bd,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE                 = 0x000000be,
    D3D10_MESSAGE_ID_CREATEPIXELSHADER_OUTOFMEMORY                                               = 0x000000bf,
    D3D10_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERBYTECODE                                     = 0x000000c0,
    D3D10_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERTYPE                                         = 0x000000c1,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFILLMODE                                       = 0x000000c2,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDCULLMODE                                       = 0x000000c3,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP                                 = 0x000000c4,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS                           = 0x000000c5,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_TOOMANYOBJECTS                                        = 0x000000c6,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_NULLDESC                                              = 0x000000c7,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK                               = 0x000000c8,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC                                    = 0x000000c9,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP                       = 0x000000ca,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP                      = 0x000000cb,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP                       = 0x000000cc,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC                         = 0x000000cd,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP                        = 0x000000ce,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP                       = 0x000000cf,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP                        = 0x000000d0,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC                          = 0x000000d1,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_TOOMANYOBJECTS                                      = 0x000000d2,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_NULLDESC                                            = 0x000000d3,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLEND                                            = 0x000000d4,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLEND                                           = 0x000000d5,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOP                                             = 0x000000d6,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLENDALPHA                                       = 0x000000d7,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLENDALPHA                                      = 0x000000d8,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOPALPHA                                        = 0x000000d9,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK                               = 0x000000da,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_TOOMANYOBJECTS                                             = 0x000000db,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NULLDESC                                                   = 0x000000dc,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDFILTER                                            = 0x000000dd,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSU                                          = 0x000000de,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSV                                          = 0x000000df,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSW                                          = 0x000000e0,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMIPLODBIAS                                        = 0x000000e1,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXANISOTROPY                                     = 0x000000e2,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDCOMPARISONFUNC                                    = 0x000000e3,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMINLOD                                            = 0x000000e4,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXLOD                                            = 0x000000e5,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_TOOMANYOBJECTS                                           = 0x000000e6,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NULLDESC                                                 = 0x000000e7,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDQUERY                                         = 0x000000e8,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDMISCFLAGS                                     = 0x000000e9,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_UNEXPECTEDMISCFLAG                                   = 0x000000ea,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_NULLDESC                                             = 0x000000eb,
    D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNRECOGNIZED                         = 0x000000ec,
    D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNDEFINED                            = 0x000000ed,
    D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_INVALIDBUFFER                                            = 0x000000ee,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_OFFSET_TOO_LARGE                                  = 0x000000ef,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_BUFFERS_EMPTY                                     = 0x000000f0,
    D3D10_MESSAGE_ID_IASETINDEXBUFFER_INVALIDBUFFER                                              = 0x000000f1,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_FORMAT_INVALID                                      = 0x000000f2,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_TOO_LARGE                                    = 0x000000f3,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_UNALIGNED                                    = 0x000000f4,
    D3D10_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x000000f5,
    D3D10_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x000000f6,
    D3D10_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x000000f7,
    D3D10_MESSAGE_ID_DEVICE_VSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x000000f8,
    D3D10_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x000000f9,
    D3D10_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x000000fa,
    D3D10_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x000000fb,
    D3D10_MESSAGE_ID_DEVICE_GSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x000000fc,
    D3D10_MESSAGE_ID_SOSETTARGETS_INVALIDBUFFER                                                  = 0x000000fd,
    D3D10_MESSAGE_ID_DEVICE_SOSETTARGETS_OFFSET_UNALIGNED                                        = 0x000000fe,
    D3D10_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x000000ff,
    D3D10_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x00000100,
    D3D10_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x00000101,
    D3D10_MESSAGE_ID_DEVICE_PSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x00000102,
    D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_INVALIDVIEWPORT                                       = 0x00000103,
    D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_INVALIDSCISSOR                                     = 0x00000104,
    D3D10_MESSAGE_ID_CLEARRENDERTARGETVIEW_DENORMFLUSH                                           = 0x00000105,
    D3D10_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DENORMFLUSH                                           = 0x00000106,
    D3D10_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_INVALID                                               = 0x00000107,
    D3D10_MESSAGE_ID_DEVICE_IAGETVERTEXBUFFERS_BUFFERS_EMPTY                                     = 0x00000108,
    D3D10_MESSAGE_ID_DEVICE_VSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x00000109,
    D3D10_MESSAGE_ID_DEVICE_VSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x0000010a,
    D3D10_MESSAGE_ID_DEVICE_VSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x0000010b,
    D3D10_MESSAGE_ID_DEVICE_GSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x0000010c,
    D3D10_MESSAGE_ID_DEVICE_GSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x0000010d,
    D3D10_MESSAGE_ID_DEVICE_GSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x0000010e,
    D3D10_MESSAGE_ID_DEVICE_SOGETTARGETS_BUFFERS_EMPTY                                           = 0x0000010f,
    D3D10_MESSAGE_ID_DEVICE_PSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x00000110,
    D3D10_MESSAGE_ID_DEVICE_PSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x00000111,
    D3D10_MESSAGE_ID_DEVICE_PSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x00000112,
    D3D10_MESSAGE_ID_DEVICE_RSGETVIEWPORTS_VIEWPORTS_EMPTY                                       = 0x00000113,
    D3D10_MESSAGE_ID_DEVICE_RSGETSCISSORRECTS_RECTS_EMPTY                                        = 0x00000114,
    D3D10_MESSAGE_ID_DEVICE_GENERATEMIPS_RESOURCE_INVALID                                        = 0x00000115,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSUBRESOURCE                         = 0x00000116,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESUBRESOURCE                              = 0x00000117,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCEBOX                                      = 0x00000118,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCE                                         = 0x00000119,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSTATE                               = 0x0000011a,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESTATE                                    = 0x0000011b,
    D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCE                                                  = 0x0000011c,
    D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDDESTINATIONSTATE                                        = 0x0000011d,
    D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCESTATE                                             = 0x0000011e,
    D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSUBRESOURCE                             = 0x0000011f,
    D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONBOX                                     = 0x00000120,
    D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSTATE                                   = 0x00000121,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_INVALID                               = 0x00000122,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_SUBRESOURCE_INVALID                   = 0x00000123,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_INVALID                                    = 0x00000124,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_SUBRESOURCE_INVALID                        = 0x00000125,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_FORMAT_INVALID                                    = 0x00000126,
    D3D10_MESSAGE_ID_BUFFER_MAP_INVALIDMAPTYPE                                                   = 0x00000127,
    D3D10_MESSAGE_ID_BUFFER_MAP_INVALIDFLAGS                                                     = 0x00000128,
    D3D10_MESSAGE_ID_BUFFER_MAP_ALREADYMAPPED                                                    = 0x00000129,
    D3D10_MESSAGE_ID_BUFFER_MAP_DEVICEREMOVED_RETURN                                             = 0x0000012a,
    D3D10_MESSAGE_ID_BUFFER_UNMAP_NOTMAPPED                                                      = 0x0000012b,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDMAPTYPE                                                = 0x0000012c,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDSUBRESOURCE                                            = 0x0000012d,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDFLAGS                                                  = 0x0000012e,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_ALREADYMAPPED                                                 = 0x0000012f,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_DEVICEREMOVED_RETURN                                          = 0x00000130,
    D3D10_MESSAGE_ID_TEXTURE1D_UNMAP_INVALIDSUBRESOURCE                                          = 0x00000131,
    D3D10_MESSAGE_ID_TEXTURE1D_UNMAP_NOTMAPPED                                                   = 0x00000132,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDMAPTYPE                                                = 0x00000133,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDSUBRESOURCE                                            = 0x00000134,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDFLAGS                                                  = 0x00000135,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_ALREADYMAPPED                                                 = 0x00000136,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_DEVICEREMOVED_RETURN                                          = 0x00000137,
    D3D10_MESSAGE_ID_TEXTURE2D_UNMAP_INVALIDSUBRESOURCE                                          = 0x00000138,
    D3D10_MESSAGE_ID_TEXTURE2D_UNMAP_NOTMAPPED                                                   = 0x00000139,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDMAPTYPE                                                = 0x0000013a,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDSUBRESOURCE                                            = 0x0000013b,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDFLAGS                                                  = 0x0000013c,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_ALREADYMAPPED                                                 = 0x0000013d,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_DEVICEREMOVED_RETURN                                          = 0x0000013e,
    D3D10_MESSAGE_ID_TEXTURE3D_UNMAP_INVALIDSUBRESOURCE                                          = 0x0000013f,
    D3D10_MESSAGE_ID_TEXTURE3D_UNMAP_NOTMAPPED                                                   = 0x00000140,
    D3D10_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_DEPRECATED                                        = 0x00000141,
    D3D10_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_FORMAT_DEPRECATED                             = 0x00000142,
    D3D10_MESSAGE_ID_SETEXCEPTIONMODE_UNRECOGNIZEDFLAGS                                          = 0x00000143,
    D3D10_MESSAGE_ID_SETEXCEPTIONMODE_INVALIDARG_RETURN                                          = 0x00000144,
    D3D10_MESSAGE_ID_SETEXCEPTIONMODE_DEVICEREMOVED_RETURN                                       = 0x00000145,
    D3D10_MESSAGE_ID_REF_SIMULATING_INFINITELY_FAST_HARDWARE                                     = 0x00000146,
    D3D10_MESSAGE_ID_REF_THREADING_MODE                                                          = 0x00000147,
    D3D10_MESSAGE_ID_REF_UMDRIVER_EXCEPTION                                                      = 0x00000148,
    D3D10_MESSAGE_ID_REF_KMDRIVER_EXCEPTION                                                      = 0x00000149,
    D3D10_MESSAGE_ID_REF_HARDWARE_EXCEPTION                                                      = 0x0000014a,
    D3D10_MESSAGE_ID_REF_ACCESSING_INDEXABLE_TEMP_OUT_OF_RANGE                                   = 0x0000014b,
    D3D10_MESSAGE_ID_REF_PROBLEM_PARSING_SHADER                                                  = 0x0000014c,
    D3D10_MESSAGE_ID_REF_OUT_OF_MEMORY                                                           = 0x0000014d,
    D3D10_MESSAGE_ID_REF_INFO                                                                    = 0x0000014e,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEXPOS_OVERFLOW                                              = 0x0000014f,
    D3D10_MESSAGE_ID_DEVICE_DRAWINDEXED_INDEXPOS_OVERFLOW                                        = 0x00000150,
    D3D10_MESSAGE_ID_DEVICE_DRAWINSTANCED_VERTEXPOS_OVERFLOW                                     = 0x00000151,
    D3D10_MESSAGE_ID_DEVICE_DRAWINSTANCED_INSTANCEPOS_OVERFLOW                                   = 0x00000152,
    D3D10_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INSTANCEPOS_OVERFLOW                            = 0x00000153,
    D3D10_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INDEXPOS_OVERFLOW                               = 0x00000154,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_SHADER_NOT_SET                                           = 0x00000155,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND                                = 0x00000156,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERINDEX                                         = 0x00000157,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_COMPONENTTYPE                                         = 0x00000158,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERMASK                                          = 0x00000159,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SYSTEMVALUE                                           = 0x0000015a,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS                              = 0x0000015b,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_NOT_SET                                           = 0x0000015c,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INPUTLAYOUT_NOT_SET                                             = 0x0000015d,
    D3D10_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_NOT_SET                                         = 0x0000015e,
    D3D10_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_TOO_SMALL                                       = 0x0000015f,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SAMPLER_NOT_SET                                                 = 0x00000160,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SHADERRESOURCEVIEW_NOT_SET                                      = 0x00000161,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VIEW_DIMENSION_MISMATCH                                         = 0x00000162,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL                                  = 0x00000163,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_TOO_SMALL                                         = 0x00000164,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_NOT_SET                                            = 0x00000165,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_FORMAT_INVALID                                     = 0x00000166,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_TOO_SMALL                                          = 0x00000167,
    D3D10_MESSAGE_ID_DEVICE_DRAW_GS_INPUT_PRIMITIVE_MISMATCH                                     = 0x00000168,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_RETURN_TYPE_MISMATCH                                   = 0x00000169,
    D3D10_MESSAGE_ID_DEVICE_DRAW_POSITION_NOT_PRESENT                                            = 0x0000016a,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_NOT_SET                                           = 0x0000016b,
    D3D10_MESSAGE_ID_DEVICE_DRAW_BOUND_RESOURCE_MAPPED                                           = 0x0000016c,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INVALID_PRIMITIVETOPOLOGY                                       = 0x0000016d,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_OFFSET_UNALIGNED                                         = 0x0000016e,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_STRIDE_UNALIGNED                                         = 0x0000016f,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_OFFSET_UNALIGNED                                          = 0x00000170,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_OFFSET_UNALIGNED                                  = 0x00000171,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_LD_UNSUPPORTED                                  = 0x00000172,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_UNSUPPORTED                              = 0x00000173,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_C_UNSUPPORTED                            = 0x00000174,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_MULTISAMPLE_UNSUPPORTED                                = 0x00000175,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SO_TARGETS_BOUND_WITHOUT_SOURCE                                 = 0x00000176,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SO_STRIDE_LARGER_THAN_BUFFER                                    = 0x00000177,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING                      = 0x00000178,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0           = 0x00000179,
    D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_AT_FAULT                                             = 0x0000017a,
    D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT                                    = 0x0000017b,
    D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT                                         = 0x0000017c,
    D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_INVALIDARG_RETURN                               = 0x0000017d,
    D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_OUTOFMEMORY_RETURN                              = 0x0000017e,
    D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BADINTERFACE_RETURN                             = 0x0000017f,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VIEWPORT_NOT_SET                                                = 0x00000180,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC                                = 0x00000181,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC             = 0x00000182,
    D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_DENORMFLUSH                                           = 0x00000183,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_INVALIDVIEW                                              = 0x00000184,
    D3D10_MESSAGE_ID_DEVICE_SETTEXTFILTERSIZE_INVALIDDIMENSIONS                                  = 0x00000185,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SAMPLER_MISMATCH                                                = 0x00000186,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TYPE_MISMATCH                                             = 0x00000187,
    D3D10_MESSAGE_ID_BLENDSTATE_GETDESC_LEGACY                                                   = 0x00000188,
    D3D10_MESSAGE_ID_SHADERRESOURCEVIEW_GETDESC_LEGACY                                           = 0x00000189,
    D3D10_MESSAGE_ID_CREATEQUERY_OUTOFMEMORY_RETURN                                              = 0x0000018a,
    D3D10_MESSAGE_ID_CREATEPREDICATE_OUTOFMEMORY_RETURN                                          = 0x0000018b,
    D3D10_MESSAGE_ID_CREATECOUNTER_OUTOFRANGE_COUNTER                                            = 0x0000018c,
    D3D10_MESSAGE_ID_CREATECOUNTER_SIMULTANEOUS_ACTIVE_COUNTERS_EXHAUSTED                        = 0x0000018d,
    D3D10_MESSAGE_ID_CREATECOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER                                 = 0x0000018e,
    D3D10_MESSAGE_ID_CREATECOUNTER_OUTOFMEMORY_RETURN                                            = 0x0000018f,
    D3D10_MESSAGE_ID_CREATECOUNTER_NONEXCLUSIVE_RETURN                                           = 0x00000190,
    D3D10_MESSAGE_ID_CREATECOUNTER_NULLDESC                                                      = 0x00000191,
    D3D10_MESSAGE_ID_CHECKCOUNTER_OUTOFRANGE_COUNTER                                             = 0x00000192,
    D3D10_MESSAGE_ID_CHECKCOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER                                  = 0x00000193,
    D3D10_MESSAGE_ID_SETPREDICATION_INVALID_PREDICATE_STATE                                      = 0x00000194,
    D3D10_MESSAGE_ID_QUERY_BEGIN_UNSUPPORTED                                                     = 0x00000195,
    D3D10_MESSAGE_ID_PREDICATE_BEGIN_DURING_PREDICATION                                          = 0x00000196,
    D3D10_MESSAGE_ID_QUERY_BEGIN_DUPLICATE                                                       = 0x00000197,
    D3D10_MESSAGE_ID_QUERY_BEGIN_ABANDONING_PREVIOUS_RESULTS                                     = 0x00000198,
    D3D10_MESSAGE_ID_PREDICATE_END_DURING_PREDICATION                                            = 0x00000199,
    D3D10_MESSAGE_ID_QUERY_END_ABANDONING_PREVIOUS_RESULTS                                       = 0x0000019a,
    D3D10_MESSAGE_ID_QUERY_END_WITHOUT_BEGIN                                                     = 0x0000019b,
    D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_DATASIZE                                              = 0x0000019c,
    D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_FLAGS                                                 = 0x0000019d,
    D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_CALL                                                  = 0x0000019e,
    D3D10_MESSAGE_ID_DEVICE_DRAW_PS_OUTPUT_TYPE_MISMATCH                                         = 0x0000019f,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_GATHER_UNSUPPORTED                              = 0x000001a0,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN                       = 0x000001a1,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_STRIDE_TOO_LARGE                                  = 0x000001a2,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_INVALIDRANGE                                      = 0x000001a3,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_EMPTY_LAYOUT                                              = 0x000001a4,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_SAMPLE_COUNT_MISMATCH                                  = 0x000001a5,
    D3D10_MESSAGE_ID_LIVE_OBJECT_SUMMARY                                                         = 0x000001a6,
    D3D10_MESSAGE_ID_LIVE_BUFFER                                                                 = 0x000001a7,
    D3D10_MESSAGE_ID_LIVE_TEXTURE1D                                                              = 0x000001a8,
    D3D10_MESSAGE_ID_LIVE_TEXTURE2D                                                              = 0x000001a9,
    D3D10_MESSAGE_ID_LIVE_TEXTURE3D                                                              = 0x000001aa,
    D3D10_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW                                                     = 0x000001ab,
    D3D10_MESSAGE_ID_LIVE_RENDERTARGETVIEW                                                       = 0x000001ac,
    D3D10_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW                                                       = 0x000001ad,
    D3D10_MESSAGE_ID_LIVE_VERTEXSHADER                                                           = 0x000001ae,
    D3D10_MESSAGE_ID_LIVE_GEOMETRYSHADER                                                         = 0x000001af,
    D3D10_MESSAGE_ID_LIVE_PIXELSHADER                                                            = 0x000001b0,
    D3D10_MESSAGE_ID_LIVE_INPUTLAYOUT                                                            = 0x000001b1,
    D3D10_MESSAGE_ID_LIVE_SAMPLER                                                                = 0x000001b2,
    D3D10_MESSAGE_ID_LIVE_BLENDSTATE                                                             = 0x000001b3,
    D3D10_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE                                                      = 0x000001b4,
    D3D10_MESSAGE_ID_LIVE_RASTERIZERSTATE                                                        = 0x000001b5,
    D3D10_MESSAGE_ID_LIVE_QUERY                                                                  = 0x000001b6,
    D3D10_MESSAGE_ID_LIVE_PREDICATE                                                              = 0x000001b7,
    D3D10_MESSAGE_ID_LIVE_COUNTER                                                                = 0x000001b8,
    D3D10_MESSAGE_ID_LIVE_DEVICE                                                                 = 0x000001b9,
    D3D10_MESSAGE_ID_LIVE_SWAPCHAIN                                                              = 0x000001ba,
    D3D10_MESSAGE_ID_D3D10_MESSAGES_END                                                          = 0x000001bb,
    D3D10_MESSAGE_ID_D3D10L9_MESSAGES_START                                                      = 0x00100000,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_STENCIL_NO_TWO_SIDED                                = 0x00100001,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_DepthBiasClamp_NOT_SUPPORTED                          = 0x00100002,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NO_COMPARISON_SUPPORT                                    = 0x00100003,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_EXCESSIVE_ANISOTROPY                                     = 0x00100004,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_OUT_OF_RANGE                                      = 0x00100005,
    D3D10_MESSAGE_ID_VSSETSAMPLERS_NOT_SUPPORTED                                                 = 0x00100006,
    D3D10_MESSAGE_ID_VSSETSAMPLERS_TOO_MANY_SAMPLERS                                             = 0x00100007,
    D3D10_MESSAGE_ID_PSSETSAMPLERS_TOO_MANY_SAMPLERS                                             = 0x00100008,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_ARRAYS                                                    = 0x00100009,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_VB_AND_IB_BIND                                            = 0x0010000a,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_TEXTURE_1D                                                = 0x0010000b,
    D3D10_MESSAGE_ID_CREATERESOURCE_DIMENSION_OUT_OF_RANGE                                       = 0x0010000c,
    D3D10_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_SHADER_RESOURCE                              = 0x0010000d,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_TOO_MANY_RENDER_TARGETS                                  = 0x0010000e,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_NO_DIFFERING_BIT_DEPTHS                                  = 0x0010000f,
    D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_BAD_BUFFER_INDEX                                         = 0x00100010,
    D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_TOO_MANY_VIEWPORTS                                    = 0x00100011,
    D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_ADJACENCY_UNSUPPORTED                         = 0x00100012,
    D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_TOO_MANY_SCISSORS                                  = 0x00100013,
    D3D10_MESSAGE_ID_COPYRESOURCE_ONLY_TEXTURE_2D_WITHIN_GPU_MEMORY                              = 0x00100014,
    D3D10_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_3D_READBACK                                         = 0x00100015,
    D3D10_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_ONLY_READBACK                                       = 0x00100016,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_UNSUPPORTED_FORMAT                                        = 0x00100017,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_ALPHA_TO_COVERAGE                                       = 0x00100018,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_DepthClipEnable_MUST_BE_TRUE                          = 0x00100019,
    D3D10_MESSAGE_ID_DRAWINDEXED_STARTINDEXLOCATION_MUST_BE_POSITIVE                             = 0x0010001a,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_MUST_USE_LOWEST_LOD                                = 0x0010001b,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_MINLOD_MUST_NOT_BE_FRACTIONAL                            = 0x0010001c,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_MAXLOD_MUST_BE_FLT_MAX                                   = 0x0010001d,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_FIRSTARRAYSLICE_MUST_BE_ZERO                       = 0x0010001e,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_CUBES_MUST_HAVE_6_SIDES                            = 0x0010001f,
    D3D10_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_RENDER_TARGET                                = 0x00100020,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_DWORD_INDEX_BUFFER                                        = 0x00100021,
    D3D10_MESSAGE_ID_CREATERESOURCE_MSAA_PRECLUDES_SHADER_RESOURCE                               = 0x00100022,
    D3D10_MESSAGE_ID_CREATERESOURCE_PRESENTATION_PRECLUDES_SHADER_RESOURCE                       = 0x00100023,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_BLEND_ENABLE                                = 0x00100024,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_WRITE_MASKS                                 = 0x00100025,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_STREAM_OUT                                                = 0x00100026,
    D3D10_MESSAGE_ID_CREATERESOURCE_ONLY_VB_IB_FOR_BUFFERS                                       = 0x00100027,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_AUTOGEN_FOR_VOLUMES                                       = 0x00100028,
    D3D10_MESSAGE_ID_CREATERESOURCE_DXGI_FORMAT_R8G8B8A8_CANNOT_BE_SHARED                        = 0x00100029,
    D3D10_MESSAGE_ID_VSSHADERRESOURCES_NOT_SUPPORTED                                             = 0x0010002a,
    D3D10_MESSAGE_ID_GEOMETRY_SHADER_NOT_SUPPORTED                                               = 0x0010002b,
    D3D10_MESSAGE_ID_STREAM_OUT_NOT_SUPPORTED                                                    = 0x0010002c,
    D3D10_MESSAGE_ID_TEXT_FILTER_NOT_SUPPORTED                                                   = 0x0010002d,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_SEPARATE_ALPHA_BLEND                                    = 0x0010002e,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_MRT_BLEND                                               = 0x0010002f,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_OPERATION_NOT_SUPPORTED                                    = 0x00100030,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NO_MIRRORONCE                                            = 0x00100031,
    D3D10_MESSAGE_ID_DRAWINSTANCED_NOT_SUPPORTED                                                 = 0x00100032,
    D3D10_MESSAGE_ID_DRAWINDEXEDINSTANCED_NOT_SUPPORTED_BELOW_9_3                                = 0x00100033,
    D3D10_MESSAGE_ID_DRAWINDEXED_POINTLIST_UNSUPPORTED                                           = 0x00100034,
    D3D10_MESSAGE_ID_SETBLENDSTATE_SAMPLE_MASK_CANNOT_BE_ZERO                                    = 0x00100035,
    D3D10_MESSAGE_ID_CREATERESOURCE_DIMENSION_EXCEEDS_FEATURE_LEVEL_DEFINITION                   = 0x00100036,
    D3D10_MESSAGE_ID_CREATERESOURCE_ONLY_SINGLE_MIP_LEVEL_DEPTH_STENCIL_SUPPORTED                = 0x00100037,
    D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_NEGATIVESCISSOR                                    = 0x00100038,
    D3D10_MESSAGE_ID_SLOT_ZERO_MUST_BE_D3D10_INPUT_PER_VERTEX_DATA                               = 0x00100039,
    D3D10_MESSAGE_ID_CREATERESOURCE_NON_POW_2_MIPMAP                                             = 0x0010003a,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_NOT_SUPPORTED                                     = 0x0010003b,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_NO_SRGB_MRT                                              = 0x0010003c,
    D3D10_MESSAGE_ID_COPYRESOURCE_NO_3D_MISMATCHED_UPDATES                                       = 0x0010003d,
    D3D10_MESSAGE_ID_D3D10L9_MESSAGES_END                                                        = 0x0010003e,
}

///The device-driver type.
alias D3D10_DRIVER_TYPE = int;
enum : int
{
    ///A hardware device; commonly called a HAL device.
    D3D10_DRIVER_TYPE_HARDWARE  = 0x00000000,
    ///A reference device; commonly called a REF device.
    D3D10_DRIVER_TYPE_REFERENCE = 0x00000001,
    ///A NULL device; which is a reference device without render capability.
    D3D10_DRIVER_TYPE_NULL      = 0x00000002,
    ///Reserved for later use.
    D3D10_DRIVER_TYPE_SOFTWARE  = 0x00000003,
    ///A WARP driver, which is a high-performance software rasterizer. The rasterizer supports feature level 9_1 through
    ///level 10.1 with a high performance software implementation when hardware is not available. For more information
    ///about using a WARP driver, see Windows Advanced Rasterization Platform (WARP) In-Depth Guide. Note that WARP is
    ///only available with the DirectX 11 Runtime (Windows 7, Windows Server 2008 R2, updated Windows Vista [KB971644]).
    D3D10_DRIVER_TYPE_WARP      = 0x00000005,
}

///Effect device-state types.
alias D3D10_DEVICE_STATE_TYPES = int;
enum : int
{
    ///Stream-output buffer.
    D3D10_DST_SO_BUFFERS             = 0x00000001,
    ///Render target.
    D3D10_DST_OM_RENDER_TARGETS      = 0x00000002,
    ///Depth-stencil state.
    D3D10_DST_OM_DEPTH_STENCIL_STATE = 0x00000003,
    ///Blend state.
    D3D10_DST_OM_BLEND_STATE         = 0x00000004,
    ///Vertex shader.
    D3D10_DST_VS                     = 0x00000005,
    ///Vertex shader sampler.
    D3D10_DST_VS_SAMPLERS            = 0x00000006,
    ///Vertex shader resource.
    D3D10_DST_VS_SHADER_RESOURCES    = 0x00000007,
    ///Vertex shader constant buffer.
    D3D10_DST_VS_CONSTANT_BUFFERS    = 0x00000008,
    ///Geometry shader.
    D3D10_DST_GS                     = 0x00000009,
    ///Geometry shader sampler.
    D3D10_DST_GS_SAMPLERS            = 0x0000000a,
    ///Geometry shader resource.
    D3D10_DST_GS_SHADER_RESOURCES    = 0x0000000b,
    ///Geometry shader constant buffer.
    D3D10_DST_GS_CONSTANT_BUFFERS    = 0x0000000c,
    ///Pixel shader.
    D3D10_DST_PS                     = 0x0000000d,
    ///Pixel shader sampler.
    D3D10_DST_PS_SAMPLERS            = 0x0000000e,
    ///Pixel shader resource.
    D3D10_DST_PS_SHADER_RESOURCES    = 0x0000000f,
    ///Pixel shader constant buffer.
    D3D10_DST_PS_CONSTANT_BUFFERS    = 0x00000010,
    ///Input-assembler vertex buffer.
    D3D10_DST_IA_VERTEX_BUFFERS      = 0x00000011,
    ///Input-assembler index buffer.
    D3D10_DST_IA_INDEX_BUFFER        = 0x00000012,
    ///Input-assembler input layout.
    D3D10_DST_IA_INPUT_LAYOUT        = 0x00000013,
    ///Input-assembler primitive topology.
    D3D10_DST_IA_PRIMITIVE_TOPOLOGY  = 0x00000014,
    ///Viewport.
    D3D10_DST_RS_VIEWPORTS           = 0x00000015,
    ///Scissor rectangle.
    D3D10_DST_RS_SCISSOR_RECTS       = 0x00000016,
    ///Rasterizer state.
    D3D10_DST_RS_RASTERIZER_STATE    = 0x00000017,
    ///Predication state.
    D3D10_DST_PREDICATION            = 0x00000018,
}

///The version of hardware acceleration requested.
alias D3D10_FEATURE_LEVEL1 = int;
enum : int
{
    ///The hardware supports Direct3D 10.0 features.
    D3D10_FEATURE_LEVEL_10_0 = 0x0000a000,
    ///The hardware supports Direct3D 10.1 features.
    D3D10_FEATURE_LEVEL_10_1 = 0x0000a100,
    ///The hardware supports 9.1 feature level.
    D3D10_FEATURE_LEVEL_9_1  = 0x00009100,
    ///The hardware supports 9.2 feature level.
    D3D10_FEATURE_LEVEL_9_2  = 0x00009200,
    ///The hardware supports 9.3 feature level.
    D3D10_FEATURE_LEVEL_9_3  = 0x00009300,
}

alias D3D10_STANDARD_MULTISAMPLE_QUALITY_LEVELS = int;
enum : int
{
    D3D10_STANDARD_MULTISAMPLE_PATTERN = 0xffffffff,
    D3D10_CENTER_MULTISAMPLE_PATTERN   = 0xfffffffe,
}

///Shader register types.
alias D3D10_SHADER_DEBUG_REGTYPE = int;
enum : int
{
    ///Input register.
    D3D10_SHADER_DEBUG_REG_INPUT              = 0x00000000,
    ///Output register.
    D3D10_SHADER_DEBUG_REG_OUTPUT             = 0x00000001,
    ///Constant buffer register.
    D3D10_SHADER_DEBUG_REG_CBUFFER            = 0x00000002,
    ///Texture buffer register.
    D3D10_SHADER_DEBUG_REG_TBUFFER            = 0x00000003,
    ///Temporary register.
    D3D10_SHADER_DEBUG_REG_TEMP               = 0x00000004,
    ///Array of temporary registers.
    D3D10_SHADER_DEBUG_REG_TEMPARRAY          = 0x00000005,
    ///Texture register.
    D3D10_SHADER_DEBUG_REG_TEXTURE            = 0x00000006,
    ///Sampler register.
    D3D10_SHADER_DEBUG_REG_SAMPLER            = 0x00000007,
    ///Immediate constant buffer register.
    D3D10_SHADER_DEBUG_REG_IMMEDIATECBUFFER   = 0x00000008,
    ///Literal register.
    D3D10_SHADER_DEBUG_REG_LITERAL            = 0x00000009,
    ///Unused register.
    D3D10_SHADER_DEBUG_REG_UNUSED             = 0x0000000a,
    ///Interface register.
    D3D11_SHADER_DEBUG_REG_INTERFACE_POINTERS = 0x0000000b,
    ///Unordered Access View (UAV) register.
    D3D11_SHADER_DEBUG_REG_UAV                = 0x0000000c,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    D3D10_SHADER_DEBUG_REG_FORCE_DWORD        = 0x7fffffff,
}

///Scope types.
alias D3D10_SHADER_DEBUG_SCOPETYPE = int;
enum : int
{
    ///Global scope.
    D3D10_SHADER_DEBUG_SCOPE_GLOBAL      = 0x00000000,
    ///Block scope.
    D3D10_SHADER_DEBUG_SCOPE_BLOCK       = 0x00000001,
    ///For loop scope.
    D3D10_SHADER_DEBUG_SCOPE_FORLOOP     = 0x00000002,
    ///Structure scope.
    D3D10_SHADER_DEBUG_SCOPE_STRUCT      = 0x00000003,
    ///Function parameter scope.
    D3D10_SHADER_DEBUG_SCOPE_FUNC_PARAMS = 0x00000004,
    ///State block scope.
    D3D10_SHADER_DEBUG_SCOPE_STATEBLOCK  = 0x00000005,
    ///Name space scope.
    D3D10_SHADER_DEBUG_SCOPE_NAMESPACE   = 0x00000006,
    ///Annotation scope.
    D3D10_SHADER_DEBUG_SCOPE_ANNOTATION  = 0x00000007,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    D3D10_SHADER_DEBUG_SCOPE_FORCE_DWORD = 0x7fffffff,
}

///Distinguishes variables from functions in a scope.
alias D3D10_SHADER_DEBUG_VARTYPE = int;
enum : int
{
    ///Element is a variable.
    D3D10_SHADER_DEBUG_VAR_VARIABLE    = 0x00000000,
    ///Element is a function.
    D3D10_SHADER_DEBUG_VAR_FUNCTION    = 0x00000001,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    D3D10_SHADER_DEBUG_VAR_FORCE_DWORD = 0x7fffffff,
}

// Callbacks

alias PFN_D3D10_CREATE_DEVICE1 = HRESULT function(IDXGIAdapter param0, D3D10_DRIVER_TYPE param1, ptrdiff_t param2, 
                                                  uint param3, D3D10_FEATURE_LEVEL1 param4, uint param5, 
                                                  ID3D10Device1* param6);
alias PFN_D3D10_CREATE_DEVICE_AND_SWAP_CHAIN1 = HRESULT function(IDXGIAdapter param0, D3D10_DRIVER_TYPE param1, 
                                                                 ptrdiff_t param2, uint param3, 
                                                                 D3D10_FEATURE_LEVEL1 param4, uint param5, 
                                                                 DXGI_SWAP_CHAIN_DESC* param6, 
                                                                 IDXGISwapChain* param7, ID3D10Device1* param8);

// Structs


///A description of a single element for the input-assembler stage.
struct D3D10_INPUT_ELEMENT_DESC
{
    ///Type: <b>LPCSTR</b> The HLSL semantic associated with this element in a shader input-signature.
    const(char)* SemanticName;
    ///Type: <b>UINT</b> The semantic index for the element. A semantic index modifies a semantic, with an integer index
    ///number. A semantic index is only needed in a case where there is more than one element with the same semantic.
    ///For example, a 4x4 matrix would have four components each with the semantic name <b>matrix</b>, however each of
    ///the four component would have different semantic indices (0, 1, 2, and 3).
    uint         SemanticIndex;
    ///Type: <b>DXGI_FORMAT</b> The data type of the element data. See DXGI_FORMAT.
    DXGI_FORMAT  Format;
    ///Type: <b>UINT</b> An integer value that identifies the input-assembler (see input slot). Valid values are between
    ///0 and 15, defined in D3D10.h.
    uint         InputSlot;
    ///Type: <b>UINT</b> Optional. Offset (in bytes) between each element. Use D3D10_APPEND_ALIGNED_ELEMENT for
    ///convenience to define the current element directly after the previous one, including any packing if necessary.
    uint         AlignedByteOffset;
    ///Type: <b>D3D10_INPUT_CLASSIFICATION</b> Identifies the input data class for a single input slot (see
    ///D3D10_INPUT_CLASSIFICATION).
    D3D10_INPUT_CLASSIFICATION InputSlotClass;
    ///Type: <b>UINT</b> The number of instances to draw before stepping one unit forward in a vertex buffer filled with
    ///instance data. Can be any unsigned integer value (0 means do not step) when the slot class is
    ///D3D10_INPUT_PER_INSTANCE_DATA; must be 0 when the slot class is D3D10_INPUT_PER_VERTEX_DATA.
    uint         InstanceDataStepRate;
}

///Description of a vertex element in a vertex buffer in an output slot.
struct D3D10_SO_DECLARATION_ENTRY
{
    ///Type: <b>LPCSTR</b> Type of output element. Possible values: "POSITION", "NORMAL", or "TEXCOORD0".
    const(char)* SemanticName;
    ///Type: <b>UINT</b> Output element's zero-based index. Should be used if, for example, you have more than one
    ///texture coordinate stored in each vertex.
    uint         SemanticIndex;
    ///Type: <b>BYTE</b> Which component of the entry to begin writing out to. Valid values are 0 ~ 3. For example, if
    ///you only wish to output to the y and z components of a position, then StartComponent should be 1 and
    ///ComponentCount should be 2.
    ubyte        StartComponent;
    ///Type: <b>BYTE</b> The number of components of the entry to write out to. Valid values are 1 ~ 4. For example, if
    ///you only wish to output to the y and z components of a position, then StartComponent should be 1 and
    ///ComponentCount should be 2.
    ubyte        ComponentCount;
    ///Type: <b>BYTE</b> The output slot that contains the vertex buffer that contains this output entry.
    ubyte        OutputSlot;
}

///Defines the dimensions of a viewport.
struct D3D10_VIEWPORT
{
    ///Type: <b>INT</b> X position of the left hand side of the viewport. Ranges between D3D10_VIEWPORT_BOUNDS_MIN and
    ///D3D10_VIEWPORT_BOUNDS_MAX.
    int   TopLeftX;
    ///Type: <b>INT</b> Y position of the top of the viewport. Ranges between D3D10_VIEWPORT_BOUNDS_MIN and
    ///D3D10_VIEWPORT_BOUNDS_MAX.
    int   TopLeftY;
    ///Type: <b>UINT</b> Width of the viewport.
    uint  Width;
    ///Type: <b>UINT</b> Height of the viewport.
    uint  Height;
    ///Type: <b>FLOAT</b> Minimum depth of the viewport. Ranges between 0 and 1.
    float MinDepth;
    ///Type: <b>FLOAT</b> Maximum depth of the viewport. Ranges between 0 and 1.
    float MaxDepth;
}

///Defines a 3D box.
struct D3D10_BOX
{
    ///Type: <b>UINT</b> The x position of the left hand side of the box.
    uint left;
    ///Type: <b>UINT</b> The y position of the top of the box.
    uint top;
    ///Type: <b>UINT</b> The z position of the front of the box.
    uint front;
    ///Type: <b>UINT</b> The x position of the right hand side of the box.
    uint right;
    ///Type: <b>UINT</b> The y position of the bottom of the box.
    uint bottom;
    ///Type: <b>UINT</b> The z position of the back of the box.
    uint back;
}

///Describes the stencil operations that can be performed based on the results of stencil test.
struct D3D10_DEPTH_STENCILOP_DESC
{
    ///Type: <b>D3D10_STENCIL_OP</b> A member of the D3D10_STENCIL_OP enumerated type that describes the stencil
    ///operation to perform when stencil testing fails. The default value is <b>D3D10_STENCIL_OP_KEEP</b>.
    D3D10_STENCIL_OP StencilFailOp;
    ///Type: <b>D3D10_STENCIL_OP</b> A member of the D3D10_STENCIL_OP enumerated type that describes the stencil
    ///operation to perform when stencil testing passes and depth testing fails. The default value is
    ///<b>D3D10_STENCIL_OP_KEEP</b>.
    D3D10_STENCIL_OP StencilDepthFailOp;
    ///Type: <b>D3D10_STENCIL_OP</b> A member of the D3D10_STENCIL_OP enumerated type that describes the stencil
    ///operation to perform when stencil testing and depth testing both pass. The default value is
    ///<b>D3D10_STENCIL_OP_KEEP</b>.
    D3D10_STENCIL_OP StencilPassOp;
    ///Type: <b>D3D10_COMPARISON_FUNC</b> A member of the D3D10_COMPARISON_FUNC enumerated type that describes how
    ///stencil data is compared against existing stencil data. The default value is <b>D3D10_COMPARISON_ALWAYS</b>.
    D3D10_COMPARISON_FUNC StencilFunc;
}

///Describes depth-stencil state.
struct D3D10_DEPTH_STENCIL_DESC
{
    ///Type: <b>BOOL</b> A Boolean value that enables depth testing. The default value is <b>TRUE</b>.
    BOOL  DepthEnable;
    ///Type: <b>D3D10_DEPTH_WRITE_MASK</b> A member of the D3D10_DEPTH_WRITE_MASK enumerated type that identifies a
    ///portion of the depth-stencil buffer that can be modified by depth data. The default value is
    ///<b>D3D10_DEPTH_WRITE_MASK_ALL</b>.
    D3D10_DEPTH_WRITE_MASK DepthWriteMask;
    ///Type: <b>D3D10_COMPARISON_FUNC</b> A member of the D3D10_COMPARISON_FUNC enumerated type that defines how depth
    ///data is compared against existing depth data. The default value is <b>D3D10_COMPARISON_LESS</b>
    D3D10_COMPARISON_FUNC DepthFunc;
    ///Type: <b>BOOL</b> A Boolean value that enables stencil testing. The default value is <b>FALSE</b>.
    BOOL  StencilEnable;
    ///Type: <b>UINT8</b> A value that identifies a portion of the depth-stencil buffer for reading stencil data. The
    ///default value is <b>D3D10_DEFAULT_STENCIL_READ_MASK</b>.
    ubyte StencilReadMask;
    ///Type: <b>UINT8</b> A value that identifies a portion of the depth-stencil buffer for writing stencil data. The
    ///default value is <b>D3D10_DEFAULT_STENCIL_WRITE_MASK</b>.
    ubyte StencilWriteMask;
    ///Type: <b>D3D10_DEPTH_STENCILOP_DESC</b> A D3D10_DEPTH_STENCILOP_DESC structure that identifies how to use the
    ///results of the depth test and the stencil test for pixels whose surface normal is facing toward the camera.
    D3D10_DEPTH_STENCILOP_DESC FrontFace;
    ///Type: <b>D3D10_DEPTH_STENCILOP_DESC</b> A D3D10_DEPTH_STENCILOP_DESC structure that identifies how to use the
    ///results of the depth test and the stencil test for pixels whose surface normal is facing away from the camera.
    D3D10_DEPTH_STENCILOP_DESC BackFace;
}

///Describes the blend state.
struct D3D10_BLEND_DESC
{
    ///Type: <b>BOOL</b> Determines whether or not to use alpha-to-coverage as a multisampling technique when setting a
    ///pixel to a rendertarget.
    BOOL           AlphaToCoverageEnable;
    ///Type: <b>BOOL</b> Enable (or disable) blending. There are eight elements in this array; these correspond to the
    ///eight rendertargets that can be set to output-merger stage at one time.
    BOOL[8]***     BlendEnable;
    ///Type: <b>D3D10_BLEND</b> This blend option specifies the first RGB data source and includes an optional pre-blend
    ///operation.
    D3D10_BLEND    SrcBlend;
    ///Type: <b>D3D10_BLEND</b> This blend option specifies the second RGB data source and includes an optional
    ///pre-blend operation.
    D3D10_BLEND    DestBlend;
    ///Type: <b>D3D10_BLEND_OP</b> This blend operation defines how to combine the RGB data sources.
    D3D10_BLEND_OP BlendOp;
    ///Type: <b>D3D10_BLEND</b> This blend option specifies the first alpha data source and includes an optional
    ///pre-blend operation. Blend options that end in _COLOR are not allowed.
    D3D10_BLEND    SrcBlendAlpha;
    ///Type: <b>D3D10_BLEND</b> This blend option specifies the second alpha data source and includes an optional
    ///pre-blend operation. Blend options that end in _COLOR are not allowed.
    D3D10_BLEND    DestBlendAlpha;
    ///Type: <b>D3D10_BLEND_OP</b> This blend operation defines how to combine the alpha data sources.
    D3D10_BLEND_OP BlendOpAlpha;
    ///Type: <b>UINT8</b> A per-pixel write mask that allows control over which components can be written (see
    ///D3D10_COLOR_WRITE_ENABLE).
    ubyte[8]       RenderTargetWriteMask;
}

///Describes the rasterizer state.
struct D3D10_RASTERIZER_DESC
{
    ///Type: <b>D3D10_FILL_MODE</b> A member of the D3D10_FILL_MODE enumerated type that determines the fill mode to use
    ///when rendering. The default value is <b>D3D10_FILL_SOLID</b>.
    D3D10_FILL_MODE FillMode;
    ///Type: <b>D3D10_CULL_MODE</b> A member of the D3D10_CULL_MODE enumerated type that indicates whether triangles
    ///facing the specified direction are drawn. The default value is <b>D3D10_CULL_BACK</b>.
    D3D10_CULL_MODE CullMode;
    ///Type: <b>BOOL</b> Determines if a triangle is front-facing or back-facing. If this parameter is <b>TRUE</b>, then
    ///a triangle is considered front-facing if its vertices are counter-clockwise on the render target, and considered
    ///back-facing if they are clockwise. If this parameter is <b>FALSE</b>, then the opposite is true. The default
    ///value is <b>FALSE</b>.
    BOOL            FrontCounterClockwise;
    ///Type: <b>INT</b> Specifies the depth value added to a given pixel. The default value is 0. For info about depth
    ///bias, see Depth Bias.
    int             DepthBias;
    ///Type: <b>FLOAT</b> Specifies the maximum depth bias of a pixel. The default value is 0.0f. For info about depth
    ///bias, see Depth Bias.
    float           DepthBiasClamp;
    ///Type: <b>FLOAT</b> Specifies a scalar on a given pixel's slope. The default value is 0.0f. For info about depth
    ///bias, see Depth Bias.
    float           SlopeScaledDepthBias;
    ///Type: <b>BOOL</b> Enables or disables clipping based on distance. The default value is <b>TRUE</b>. The hardware
    ///always performs x and y clipping of rasterized coordinates. When <b>DepthClipEnable</b> is set to the default
    ///value, the hardware also clips the z value (that is, the hardware performs the last step of the following
    ///algorithm). <pre class="syntax" xml:space="preserve"><code> 0 &lt; w -w &lt;= x &lt;= w (or arbitrarily wider
    ///range if implementation uses a guard band to reduce clipping burden) -w &lt;= y &lt;= w (or arbitrarily wider
    ///range if implementation uses a guard band to reduce clipping burden) 0 &lt;= z &lt;= w </code></pre> When you set
    ///<b>DepthClipEnable</b> to FALSE, the hardware skips the z clipping (that is, the last step in the preceding
    ///algorithm). However, the hardware still performs the "0 &lt; w" clipping. When z clipping is disabled, improper
    ///depth ordering at the pixel level might result. However, when z clipping is disabled, stencil shadow
    ///implementations are simplified. In other words, you can avoid complex special-case handling for geometry that
    ///goes beyond the back clipping plane.
    BOOL            DepthClipEnable;
    ///Type: <b>BOOL</b> Enable or disables scissor-rectangle culling. All pixels outside an active scissor rectangle
    ///are culled. The default value is <b>FALSE</b>. For more information, see Set the Scissor Rectangle.
    BOOL            ScissorEnable;
    ///Type: <b>BOOL</b> Specifies whether to use the quadrilateral or alpha line anti-aliasing algorithm on multisample
    ///antialiasing (MSAA) render targets. The default value is <b>FALSE</b>. Set to <b>TRUE</b> to use the
    ///quadrilateral line anti-aliasing algorithm and to <b>FALSE</b> to use the alpha line anti-aliasing algorithm. For
    ///more info about this member, see Remarks.
    BOOL            MultisampleEnable;
    ///Type: <b>BOOL</b> Specifies whether to enable line antialiasing; only applies when alpha blending is enabled, you
    ///are drawing lines, and the <b>MultisampleEnable</b> member is <b>FALSE</b>. The default value is <b>FALSE</b>.
    ///For more info about this member, see Remarks.
    BOOL            AntialiasedLineEnable;
}

///Specifies data for initializing a subresource.
struct D3D10_SUBRESOURCE_DATA
{
    ///Type: <b>const void*</b> Pointer to the initialization data.
    const(void)* pSysMem;
    ///Type: <b>UINT</b> The distance (in bytes) from the beginning of one line of a texture to the next line.
    ///System-memory pitch is used only for 2D and 3D texture data as it is has no meaning for the other resource types.
    uint         SysMemPitch;
    ///Type: <b>UINT</b> The distance (in bytes) from the beginning of one depth level to the next. System-memory-slice
    ///pitch is only used for 3D texture data as it has no meaning for the other resource types.
    uint         SysMemSlicePitch;
}

///Describes a buffer resource.
struct D3D10_BUFFER_DESC
{
    ///Type: <b>UINT</b> Size of the buffer in bytes.
    uint        ByteWidth;
    ///Type: <b>D3D10_USAGE</b> Identify how the buffer is expected to be read from and written to. Frequency of update
    ///is a key factor. The most common value is typically D3D10_USAGE_DEFAULT; see D3D10_USAGE for all possible values.
    D3D10_USAGE Usage;
    ///Type: <b>UINT</b> Identify how the buffer will be bound to the pipeline. Applications can logicaly OR flags
    ///together (see D3D10_BIND_FLAG) to indicate that the buffer can be accessed in different ways.
    uint        BindFlags;
    ///Type: <b>UINT</b> CPU access flags (see D3D10_CPU_ACCESS_FLAG) or 0 if no CPU access is necessary. Applications
    ///can logicaly OR flags together.
    uint        CPUAccessFlags;
    ///Type: <b>UINT</b> Miscellaneous flags (see D3D10_RESOURCE_MISC_FLAG) or 0 if unused. Applications can logically
    ///OR flags together.
    uint        MiscFlags;
}

///Describes a 1D texture.
struct D3D10_TEXTURE1D_DESC
{
    ///Type: <b>UINT</b> Texture width (in texels). The range is from 1 to D3D10_REQ_TEXTURE1D_U_DIMENSION (8192).
    uint        Width;
    ///Type: <b>UINT</b> Number of subtextures (also called mipmap levels). Use 1 for a multisampled texture; or 0 to
    ///generate a full set of subtextures.
    uint        MipLevels;
    ///Type: <b>UINT</b> Number of textures in the array. The range is from 1 to
    ///D3D10_REQ_TEXTURE1D_ARRAY_AXIS_DIMENSION (512).
    uint        ArraySize;
    ///Type: <b>DXGI_FORMAT</b> Texture format (see DXGI_FORMAT).
    DXGI_FORMAT Format;
    ///Type: <b>D3D10_USAGE</b> Value that identifies how the texture is to be read from and written to. The most common
    ///value is D3D10_USAGE-DEFAULT; see D3D10_USAGE for all possible values.
    D3D10_USAGE Usage;
    ///Type: <b>UINT</b> Flags (see D3D10_BIND_FLAG) for binding to pipeline stages. The flags can be combined by a
    ///logical OR.
    uint        BindFlags;
    ///Type: <b>UINT</b> Flags (see D3D10_CPU_ACCESS_FLAG) to specify the types of CPU access allowed. Use 0 if CPU
    ///access is not required. These flags can be combined with a logical OR.
    uint        CPUAccessFlags;
    ///Type: <b>UINT</b> Flags (see D3D10_RESOURCE_MISC_FLAG) that identify other, less common resource options. Use 0
    ///if none of these flags apply. These flags can be combined with a logical OR.
    uint        MiscFlags;
}

///Describes a 2D texture.
struct D3D10_TEXTURE2D_DESC
{
    ///Type: <b>UINT</b> Texture width (in texels). The range is from 1 to D3D10_REQ_TEXTURE2D_U_OR_V_DIMENSION (8192).
    ///For a texture cube-map, the range is from 1 to D3D10_REQ_TEXTURECUBE_DIMENSION (8192). For more information about
    ///restrictions, see Remarks.
    uint             Width;
    ///Type: <b>UINT</b> Texture height (in texels). The range is from 1 to D3D10_REQ_TEXTURE2D_U_OR_V_DIMENSION (8192).
    ///For a texture cube-map, the range is from 1 to D3D10_REQ_TEXTURECUBE_DIMENSION (8192). For more information about
    ///restrictions, see Remarks.
    uint             Height;
    ///Type: <b>UINT</b> Number of subtextures (also called mipmap levels). Use 1 for a multisampled texture; or 0 to
    ///generate a full set of subtextures.
    uint             MipLevels;
    ///Type: <b>UINT</b> Number of textures in the texture array. The range is from 1 to
    ///D3D10_REQ_TEXTURE2D_ARRAY_AXIS_DIMENSION (512). For a texture cube-map, this value is a multiple of 6 (that is, 6
    ///* the value in the <b>NumCubes</b> member of D3D10_TEXCUBE_ARRAY_SRV1), and the range is from 6 to
    ///D3D10_REQ_TEXTURECUBE_DIMENSION.
    uint             ArraySize;
    ///Type: <b>DXGI_FORMAT</b> Texture format (see DXGI_FORMAT).
    DXGI_FORMAT      Format;
    ///Type: <b>DXGI_SAMPLE_DESC</b> Structure that specifies multisampling parameters for the texture. See
    ///DXGI_SAMPLE_DESC.
    DXGI_SAMPLE_DESC SampleDesc;
    ///Type: <b>D3D10_USAGE</b> Value that identifies how the texture is to be read from and written to. The most common
    ///value is D3D10_USAGE-DEFAULT; see D3D10_USAGE for all possible values.
    D3D10_USAGE      Usage;
    ///Type: <b>UINT</b> Flags (see D3D10_BIND_FLAG) for binding to pipeline stages. The flags can be combined by a
    ///logical OR.
    uint             BindFlags;
    ///Type: <b>UINT</b> Flags (see D3D10_CPU_ACCESS_FLAG) to specify the types of CPU access allowed. Use 0 if CPU
    ///access is not required. These flags can be combined with a logical OR.
    uint             CPUAccessFlags;
    ///Type: <b>UINT</b> Flags (see D3D10_RESOURCE_MISC_FLAG) that identify other, less common resource options. Use 0
    ///if none of these flags apply. These flags can be combined with a logical OR. For a texture cube-map, set the
    ///D3D10_RESOURCE_MISC_TEXTURECUBE flag. Cube-map arrays (that is, <b>ArraySize</b> &gt; 6) require feature level
    ///D3D_FEATURE_LEVEL_10_1.
    uint             MiscFlags;
}

///Provides access to subresource data in a 2D texture.
struct D3D10_MAPPED_TEXTURE2D
{
    ///Type: <b>void*</b> Pointer to the data.
    void* pData;
    ///Type: <b>UINT</b> The pitch, or width, or physical size (in bytes), of one row of an uncompressed texture. A
    ///block-compressed texture is encoded in 4x4 blocks (see virtual size vs physical size) ; therefore,
    ///<b>RowPitch</b> is the number of bytes in a block of 4x4 texels.
    uint  RowPitch;
}

///Describes a 3D texture.
struct D3D10_TEXTURE3D_DESC
{
    ///Type: <b>UINT</b> Texture width (in texels). The range is from 1 to D3D10_REQ_TEXTURE3D_U_V_OR_W_DIMENSION
    ///(2048). For more information about restrictions, see Remarks.
    uint        Width;
    ///Type: <b>UINT</b> Texture height (in texels). The range is from 1 to D3D10_REQ_TEXTURE3D_U_V_OR_W_DIMENSION
    ///(2048). For more information about restrictions, see Remarks.
    uint        Height;
    ///Type: <b>UINT</b> Texture depth (in texels). The range is from 1 to D3D10_REQ_TEXTURE3D_U_V_OR_W_DIMENSION
    ///(2048).
    uint        Depth;
    ///Type: <b>UINT</b> Number of subtextures (also called mipmap levels). Use 1 for a multisampled texture; or 0 to
    ///generate a full set of subtextures.
    uint        MipLevels;
    ///Type: <b>DXGI_FORMAT</b> Texture format (see DXGI_FORMAT).
    DXGI_FORMAT Format;
    ///Type: <b>D3D10_USAGE</b> Value that identifies how the texture is to be read from and written to. The most common
    ///value is D3D10_USAGE-DEFAULT; see D3D10_USAGE for all possible values.
    D3D10_USAGE Usage;
    ///Type: <b>UINT</b> Flags (see D3D10_BIND_FLAG) for binding to pipeline stages. The flags can be combined by a
    ///logical OR.
    uint        BindFlags;
    ///Type: <b>UINT</b> Flags (see D3D10_CPU_ACCESS_FLAG) to specify the types of CPU access allowed. Use 0 if CPU
    ///access is not required. These flags can be combined with a logical OR.
    uint        CPUAccessFlags;
    ///Type: <b>UINT</b> Flags (see D3D10_RESOURCE_MISC_FLAG) that identify other, less common resource options. Use 0
    ///if none of these flags apply. These flags can be combined with a logical OR.
    uint        MiscFlags;
}

///Provides access to subresource data in a 3D texture.
struct D3D10_MAPPED_TEXTURE3D
{
    ///Type: <b>void*</b> Pointer to the data.
    void* pData;
    ///Type: <b>UINT</b> The pitch, or width, or physical size (in bytes) of one row of an uncompressed texture. Since a
    ///block-compressed texture is encoded in 4x4 blocks, the <b>RowPitch</b> for a compressed texture is the number of
    ///bytes in a block of 4x4 texels. See virtual size vs physical size for more information on block compression.
    uint  RowPitch;
    ///Type: <b>UINT</b> The pitch or number of bytes in all rows for a single depth.
    uint  DepthPitch;
}

///Specifies the elements in a buffer resource to use in a shader-resource view.
struct D3D10_BUFFER_SRV
{
    union
    {
        uint FirstElement;
        uint ElementOffset;
    }
    union
    {
        uint NumElements;
        uint ElementWidth;
    }
}

///Specifies the subresource from a 1D texture to use in a shader-resource view.
struct D3D10_TEX1D_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///-1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> Number of mipmap levels to use.
    uint MipLevels;
}

///Specifies the subresource(s) from an array of 1D textures to use in a shader-resource view.
struct D3D10_TEX1D_ARRAY_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///-1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> Number of subtextures to access.
    uint MipLevels;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures (see array slice)
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures in the array.
    uint ArraySize;
}

///Specifies the subresource from a 2D texture to use in a shader-resource view.
struct D3D10_TEX2D_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///-1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> Number of mipmap levels to use.
    uint MipLevels;
}

///Specifies the subresource(s) from an array of 2D textures to use in a shader-resource view.
struct D3D10_TEX2D_ARRAY_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///-1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> Number of subtextures to access.
    uint MipLevels;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures (see array slice)
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures in the array.
    uint ArraySize;
}

///Specifies the subresource(s) from a 3D texture to use in a shader-resource view.
struct D3D10_TEX3D_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///-1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> Number of mipmap levels to use.
    uint MipLevels;
}

///Specifies the subresource from a cube texture to use in a shader-resource view.
struct D3D10_TEXCUBE_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///-1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> Number of mipmap levels to use.
    uint MipLevels;
}

///Specifies the subresource(s) from a multisampled 2D texture to use in a shader-resource view.
struct D3D10_TEX2DMS_SRV
{
    ///Type: <b>UINT</b> Integer of any value. See remarks.
    uint UnusedField_NothingToDefine;
}

///Specifies the subresource(s) from an array of multisampled 2D textures to use in a shader-resource view.
struct D3D10_TEX2DMS_ARRAY_SRV
{
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures (see array slice)
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Describes a shader-resource view.
struct D3D10_SHADER_RESOURCE_VIEW_DESC
{
    ///Type: <b>DXGI_FORMAT</b> The viewing format. See remarks.
    DXGI_FORMAT       Format;
    ///Type: <b>D3D10_SRV_DIMENSION</b> The resource type of the view. See D3D10_SRV_DIMENSION. This should be the same
    ///as the resource type of the underlying resource. This parameter also determines which _SRV to use in the union
    ///below.
    D3D_SRV_DIMENSION ViewDimension;
    union
    {
        D3D10_BUFFER_SRV  Buffer;
        D3D10_TEX1D_SRV   Texture1D;
        D3D10_TEX1D_ARRAY_SRV Texture1DArray;
        D3D10_TEX2D_SRV   Texture2D;
        D3D10_TEX2D_ARRAY_SRV Texture2DArray;
        D3D10_TEX2DMS_SRV Texture2DMS;
        D3D10_TEX2DMS_ARRAY_SRV Texture2DMSArray;
        D3D10_TEX3D_SRV   Texture3D;
        D3D10_TEXCUBE_SRV TextureCube;
    }
}

///Specifies the elements from a buffer resource to use in a render-target view.
struct D3D10_BUFFER_RTV
{
    union
    {
        uint FirstElement;
        uint ElementOffset;
    }
    union
    {
        uint NumElements;
        uint ElementWidth;
    }
}

///Specifies the subresource from a 1D texture to use in a render-target view.
struct D3D10_TEX1D_RTV
{
    ///Type: <b>UINT</b> The index of the mipmap level to use (see mip slice).
    uint MipSlice;
}

///Specifies the subresource(s) from an array of 1D textures to use in a render-target view.
struct D3D10_TEX1D_ARRAY_RTV
{
    ///Type: <b>UINT</b> The index of the mipmap level to use (see mip slice).
    uint MipSlice;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures (see array slice)
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Specifies the subresource from a 2D texture to use in a render-target view.
struct D3D10_TEX2D_RTV
{
    ///Type: <b>UINT</b> The index of the mipmap level to use (see mip slice).
    uint MipSlice;
}

///Specifies the subresource from a multisampled 2D texture to use in a render-target view.
struct D3D10_TEX2DMS_RTV
{
    ///Type: <b>UINT</b> Integer of any value. See remarks.
    uint UnusedField_NothingToDefine;
}

///Specifies the subresource(s) from an array of 2D textures to use in a render-target view.
struct D3D10_TEX2D_ARRAY_RTV
{
    ///Type: <b>UINT</b> The index of the mipmap level to use (see mip slice).
    uint MipSlice;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures (see array slice)
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures in the array to use in the render target view, starting from
    ///<b>FirstArraySlice</b>.
    uint ArraySize;
}

///Specifies the subresource(s) from a an array of multisampled 2D textures to use in a render-target view.
struct D3D10_TEX2DMS_ARRAY_RTV
{
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures (see array slice)
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Specifies the subresource(s) from a 3D texture to use in a render-target view.
struct D3D10_TEX3D_RTV
{
    ///Type: <b>UINT</b> The index of the mipmap level to use (see mip slice).
    uint MipSlice;
    ///Type: <b>UINT</b> First depth level to use.
    uint FirstWSlice;
    ///Type: <b>UINT</b> Number of depth levels to use in the render-target view, starting from <b>FirstWSlice</b>. A
    ///value of -1 indicates all of the slices along the w axis, starting from <b>FirstWSlice</b>.
    uint WSize;
}

///Specifies the subresource(s) from a resource that are accessible using a render-target view.
struct D3D10_RENDER_TARGET_VIEW_DESC
{
    ///Type: <b>DXGI_FORMAT</b> The data format (see DXGI_FORMAT).
    DXGI_FORMAT         Format;
    ///Type: <b>D3D10_RTV_DIMENSION</b> The resource type (see D3D10_RTV_DIMENSION), which specifies how the
    ///render-target resource will be accessed.
    D3D10_RTV_DIMENSION ViewDimension;
    union
    {
        D3D10_BUFFER_RTV  Buffer;
        D3D10_TEX1D_RTV   Texture1D;
        D3D10_TEX1D_ARRAY_RTV Texture1DArray;
        D3D10_TEX2D_RTV   Texture2D;
        D3D10_TEX2D_ARRAY_RTV Texture2DArray;
        D3D10_TEX2DMS_RTV Texture2DMS;
        D3D10_TEX2DMS_ARRAY_RTV Texture2DMSArray;
        D3D10_TEX3D_RTV   Texture3D;
    }
}

///Specifies the subresource from a 1D texture that is accessible to a depth-stencil view.
struct D3D10_TEX1D_DSV
{
    ///Type: <b>UINT</b> The index of the first mipmap level to use (see mip slice).
    uint MipSlice;
}

///Specifies the subresource(s) from an array of 1D textures to use in a depth-stencil view.
struct D3D10_TEX1D_ARRAY_DSV
{
    ///Type: <b>UINT</b> The index of the first mipmap level to use (see mip slice).
    uint MipSlice;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures (see array slice)
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Specifies the subresource from a 2D texture that is accessible to a depth-stencil view.
struct D3D10_TEX2D_DSV
{
    ///Type: <b>UINT</b> The index of the first mipmap level to use (see mip slice).
    uint MipSlice;
}

///Specifies the subresource(s) from an array 2D textures that are accessible to a depth-stencil view.
struct D3D10_TEX2D_ARRAY_DSV
{
    ///Type: <b>UINT</b> The index of the first mipmap level to use (see mip slice).
    uint MipSlice;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures (see array slice)
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Specifies the subresource from a multisampled 2D texture that is accessible to a depth-stencil view.
struct D3D10_TEX2DMS_DSV
{
    ///Type: <b>UINT</b> Unused.
    uint UnusedField_NothingToDefine;
}

///Specifies the subresource(s) from an array of multisampled 2D textures for a depth-stencil view.
struct D3D10_TEX2DMS_ARRAY_DSV
{
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures (see array slice)
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Specifies the subresource(s) from a texture that are accessible using a depth-stencil view.
struct D3D10_DEPTH_STENCIL_VIEW_DESC
{
    ///Type: <b>DXGI_FORMAT</b> Resource data format (see DXGI_FORMAT). See remarks for allowable formats.
    DXGI_FORMAT         Format;
    ///Type: <b>D3D10_DSV_DIMENSION</b> Type of resource (see D3D10_DSV_DIMENSION). Specifies how a depth-stencil
    ///resource will be accessed; the value is stored in the union in this structure.
    D3D10_DSV_DIMENSION ViewDimension;
    union
    {
        D3D10_TEX1D_DSV   Texture1D;
        D3D10_TEX1D_ARRAY_DSV Texture1DArray;
        D3D10_TEX2D_DSV   Texture2D;
        D3D10_TEX2D_ARRAY_DSV Texture2DArray;
        D3D10_TEX2DMS_DSV Texture2DMS;
        D3D10_TEX2DMS_ARRAY_DSV Texture2DMSArray;
    }
}

///Describes a sampler state.
struct D3D10_SAMPLER_DESC
{
    ///Type: <b>D3D10_FILTER</b> Filtering method to use when sampling a texture (see D3D10_FILTER).
    D3D10_FILTER Filter;
    ///Type: <b>D3D10_TEXTURE_ADDRESS_MODE</b> Method to use for resolving a u texture coordinate that is outside the 0
    ///to 1 range (see D3D10_TEXTURE_ADDRESS_MODE).
    D3D10_TEXTURE_ADDRESS_MODE AddressU;
    ///Type: <b>D3D10_TEXTURE_ADDRESS_MODE</b> Method to use for resolving a v texture coordinate that is outside the 0
    ///to 1 range.
    D3D10_TEXTURE_ADDRESS_MODE AddressV;
    ///Type: <b>D3D10_TEXTURE_ADDRESS_MODE</b> Method to use for resolving a w texture coordinate that is outside the 0
    ///to 1 range.
    D3D10_TEXTURE_ADDRESS_MODE AddressW;
    ///Type: <b>FLOAT</b> Offset from the calculated mipmap level. For example, if Direct3D calculates that a texture
    ///should be sampled at mipmap level 3 and MipLODBias is 2, then the texture will be sampled at mipmap level 5.
    float        MipLODBias;
    ///Type: <b>UINT</b> Clamping value used if D3D10_FILTER_ANISOTROPIC or D3D10_FILTER_COMPARISON_ANISOTROPIC is
    ///specified in Filter. Valid values are between 1 and 16.
    uint         MaxAnisotropy;
    ///Type: <b>D3D10_COMPARISON_FUNC</b> A function that compares sampled data against existing sampled data. The
    ///function options are listed in D3D10_COMPARISON_FUNC.
    D3D10_COMPARISON_FUNC ComparisonFunc;
    ///Type: <b>FLOAT</b> Border color to use if D3D10_TEXTURE_ADDRESS_BORDER is specified for AddressU, AddressV, or
    ///AddressW. Range must be between 0.0 and 1.0 inclusive.
    float[4]     BorderColor;
    ///Type: <b>FLOAT</b> Lower end of the mipmap range to clamp access to, where 0 is the largest and most detailed
    ///mipmap level and any level higher than that is less detailed.
    float        MinLOD;
    ///Type: <b>FLOAT</b> Upper end of the mipmap range to clamp access to, where 0 is the largest and most detailed
    ///mipmap level and any level higher than that is less detailed. This value must be greater than or equal to MinLOD.
    ///To have no upper limit on LOD set this to a large value such as D3D10_FLOAT32_MAX.
    float        MaxLOD;
}

///Describes a query.
struct D3D10_QUERY_DESC
{
    ///Type: <b>D3D10_QUERY</b> Type of query (see D3D10_QUERY).
    D3D10_QUERY Query;
    ///Type: <b>UINT</b> Miscellaneous flags (see D3D10_QUERY_MISC_FLAG).
    uint        MiscFlags;
}

///Query information about the reliability of a timestamp query.
struct D3D10_QUERY_DATA_TIMESTAMP_DISJOINT
{
    ///Type: <b>UINT64</b> How frequently the GPU counter increments in Hz.
    ulong Frequency;
    ///Type: <b>BOOL</b> If this is <b>TRUE</b>, something occurred in between the query's ID3D10Asynchronous::Begin and
    ///ID3D10Asynchronous::End calls that caused the timestamp counter to become discontinuous or disjoint, such as
    ///unplugging the AC chord on a laptop, overheating, or throttling up/down due to laptop savings events. The
    ///timestamp returned by ID3D10Asynchronous::GetData for a timestamp query is only reliable if Disjoint is
    ///<b>FALSE</b>.
    BOOL  Disjoint;
}

///Query information about graphics-pipeline activity in between calls to ID3D10Asynchronous::Begin and
///ID3D10Asynchronous::End.
struct D3D10_QUERY_DATA_PIPELINE_STATISTICS
{
    ///Type: <b>UINT64</b> Number of vertices read by input assembler.
    ulong IAVertices;
    ///Type: <b>UINT64</b> Number of primitives read by the input assembler. This number can be different depending on
    ///the primitive topology used. For example, a triangle strip with 6 vertices will produce 4 triangles, however a
    ///triangle list with 6 vertices will produce 2 triangles.
    ulong IAPrimitives;
    ///Type: <b>UINT64</b> Number of times a vertex shader was invoked. Direct3D invokes the vertex shader once per
    ///vertex.
    ulong VSInvocations;
    ///Type: <b>UINT64</b> Number of times a geometry shader was invoked. When the geometry shader is set to
    ///<b>NULL</b>, this statistic may or may not increment depending on the hardware manufacturer.
    ulong GSInvocations;
    ///Type: <b>UINT64</b> Number of primitives output by a geometry shader.
    ulong GSPrimitives;
    ///Type: <b>UINT64</b> Number of primitives that were sent to the rasterizer. When the rasterizer is disabled, this
    ///will not increment.
    ulong CInvocations;
    ///Type: <b>UINT64</b> Number of primitives that were rendered. This may be larger or smaller than CInvocations
    ///because after a primitive is clipped sometimes it is either broken up into more than one primitive or completely
    ///culled.
    ulong CPrimitives;
    ///Type: <b>UINT64</b> Number of times a pixel shader was invoked.
    ulong PSInvocations;
}

///Query information about the amount of data streamed out to the stream-output buffers in between
///ID3D10Asynchronous::Begin and ID3D10Asynchronous::End.
struct D3D10_QUERY_DATA_SO_STATISTICS
{
    ///Type: <b>UINT64</b> Number of primitives (that is, points, lines, and triangles) written to the stream-output
    ///buffers.
    ulong NumPrimitivesWritten;
    ///Type: <b>UINT64</b> Number of primitives that would have been written to the stream-output buffers if there had
    ///been enough space for them all.
    ulong PrimitivesStorageNeeded;
}

///Describes a counter.
struct D3D10_COUNTER_DESC
{
    ///Type: <b>D3D10_COUNTER</b> Type of counter (see D3D10_COUNTER).
    D3D10_COUNTER Counter;
    ///Type: <b>UINT</b> Reserved.
    uint          MiscFlags;
}

///Information about the video card's performance counter capabilities.
struct D3D10_COUNTER_INFO
{
    ///Type: <b>D3D10_COUNTER</b> Largest device-dependent counter ID that the device supports. If none are supported,
    ///this value will be 0. Otherwise it will be greater than or equal to D3D10_COUNTER_DEVICE_DEPENDENT_0. See
    ///D3D10_COUNTER.
    D3D10_COUNTER LastDeviceDependentCounter;
    ///Type: <b>UINT</b> Number of counters that can be simultaneously supported.
    uint          NumSimultaneousCounters;
    ///Type: <b>UINT8</b> Number of detectable parallel units that the counter is able to discern. Values are 1 ~ 4. Use
    ///NumDetectableParallelUnits to interpret the values of the VERTEX_PROCESSING, GEOMETRY_PROCESSING,
    ///PIXEL_PROCESSING, and OTHER_GPU_PROCESSING counters. See ID3D10Asynchronous::GetData for an equation.
    ubyte         NumDetectableParallelUnits;
}

///A debug message in the Information Queue.
struct D3D10_MESSAGE
{
    ///Type: <b>D3D10_MESSAGE_CATEGORY</b> The category of the message. See D3D10_MESSAGE_CATEGORY.
    D3D10_MESSAGE_CATEGORY Category;
    ///Type: <b>D3D10_MESSAGE_SEVERITY</b> The severity of the message. See D3D10_MESSAGE_SEVERITY.
    D3D10_MESSAGE_SEVERITY Severity;
    ///Type: <b>D3D10_MESSAGE_ID</b> The ID of the message. See D3D10_MESSAGE_ID.
    D3D10_MESSAGE_ID ID;
    ///Type: <b>const char*</b> The message string.
    const(byte)*     pDescription;
    ///Type: <b>SIZE_T</b> The length of pDescription in bytes.
    size_t           DescriptionByteLength;
}

///Allow or deny certain types of messages to pass through a filter.
struct D3D10_INFO_QUEUE_FILTER_DESC
{
    ///Type: <b>UINT</b> Number of message categories to allow or deny.
    uint              NumCategories;
    ///Type: <b>D3D10_MESSAGE_CATEGORY*</b> Array of message categories to allow or deny. Array must have at least
    ///NumCategories members (see D3D10_MESSAGE_CATEGORY).
    D3D10_MESSAGE_CATEGORY* pCategoryList;
    ///Type: <b>UINT</b> Number of message severity levels to allow or deny.
    uint              NumSeverities;
    ///Type: <b>D3D10_MESSAGE_SEVERITY*</b> Array of message severity levels to allow or deny. Array must have at least
    ///NumSeverities members (see D3D10_MESSAGE_SEVERITY).
    D3D10_MESSAGE_SEVERITY* pSeverityList;
    ///Type: <b>UINT</b> Number of message IDs to allow or deny.
    uint              NumIDs;
    ///Type: <b>D3D10_MESSAGE_ID*</b> Array of message IDs to allow or deny. Array must have at least NumIDs members
    ///(see D3D10_MESSAGE_ID).
    D3D10_MESSAGE_ID* pIDList;
}

///Debug message filter; contains a lists of message types to allow or deny.
struct D3D10_INFO_QUEUE_FILTER
{
    ///Type: <b>D3D10_INFO_QUEUE_FILTER_DESC</b> A D3D10_INFO_QUEUE_FILTER_DESC structure describing the types of
    ///messages the info queue should allow.
    D3D10_INFO_QUEUE_FILTER_DESC AllowList;
    ///Type: <b>D3D10_INFO_QUEUE_FILTER_DESC</b> A D3D10_INFO_QUEUE_FILTER_DESC structure describing the types of
    ///messages the info queue should reject.
    D3D10_INFO_QUEUE_FILTER_DESC DenyList;
}

///Describes a shader.
struct D3D10_SHADER_DESC
{
    ///Type: <b>UINT</b> Shader version.
    uint         Version;
    ///Type: <b>LPCSTR</b> The name of the originator of the shader.
    const(char)* Creator;
    ///Type: <b>UINT</b> Shader compilation/parse flags.
    uint         Flags;
    ///Type: <b>UINT</b> The number of shader-constant buffers.
    uint         ConstantBuffers;
    ///Type: <b>UINT</b> The number of resource (textures and buffers) bound to a shader.
    uint         BoundResources;
    ///Type: <b>UINT</b> The number of parameters in the input signature.
    uint         InputParameters;
    ///Type: <b>UINT</b> The number of parameters in the output signature.
    uint         OutputParameters;
    ///Type: <b>UINT</b> The number of intermediate-language instructions in the compiled shader.
    uint         InstructionCount;
    ///Type: <b>UINT</b> The number of temporary registers in the compiled shader.
    uint         TempRegisterCount;
    ///Type: <b>UINT</b> Number of temporary arrays used.
    uint         TempArrayCount;
    ///Type: <b>UINT</b> Number of constant defines.
    uint         DefCount;
    ///Type: <b>UINT</b> Number of declarations (input + output).
    uint         DclCount;
    ///Type: <b>UINT</b> Number of non-categorized texture instructions.
    uint         TextureNormalInstructions;
    ///Type: <b>UINT</b> Number of texture load instructions
    uint         TextureLoadInstructions;
    ///Type: <b>UINT</b> Number of texture comparison instructions
    uint         TextureCompInstructions;
    ///Type: <b>UINT</b> Number of texture bias instructions
    uint         TextureBiasInstructions;
    ///Type: <b>UINT</b> Number of texture gradient instructions.
    uint         TextureGradientInstructions;
    ///Type: <b>UINT</b> Number of floating point arithmetic instructions used.
    uint         FloatInstructionCount;
    ///Type: <b>UINT</b> Number of signed integer arithmetic instructions used.
    uint         IntInstructionCount;
    ///Type: <b>UINT</b> Number of unsigned integer arithmetic instructions used.
    uint         UintInstructionCount;
    ///Type: <b>UINT</b> Number of static flow control instructions used.
    uint         StaticFlowControlCount;
    ///Type: <b>UINT</b> Number of dynamic flow control instructions used.
    uint         DynamicFlowControlCount;
    ///Type: <b>UINT</b> Number of macro instructions used.
    uint         MacroInstructionCount;
    ///Type: <b>UINT</b> Number of array instructions used.
    uint         ArrayInstructionCount;
    ///Type: <b>UINT</b> Number of cut instructions used.
    uint         CutInstructionCount;
    ///Type: <b>UINT</b> Number of emit instructions used.
    uint         EmitInstructionCount;
    ///Type: <b>D3D10_PRIMITIVE_TOPOLOGY</b> Geometry shader output topology.
    D3D_PRIMITIVE_TOPOLOGY GSOutputTopology;
    ///Type: <b>UINT</b> Geometry shader maximum output vertex count.
    uint         GSMaxOutputVertexCount;
}

///Describes a shader constant-buffer.
struct D3D10_SHADER_BUFFER_DESC
{
    ///Type: <b>LPCSTR</b> The name of the buffer.
    const(char)*     Name;
    ///Type: <b>D3D10_CBUFFER_TYPE</b> The intended use of the constant data. See D3D10_CBUFFER_TYPE.
    D3D_CBUFFER_TYPE Type;
    ///Type: <b>UINT</b> The number of unique variables.
    uint             Variables;
    ///Type: <b>UINT</b> Buffer size (in bytes).
    uint             Size;
    ///Type: <b>UINT</b> Shader buffer properties. See D3D10_SHADER_CBUFFER_FLAGS.
    uint             uFlags;
}

///Describes a shader variable.
struct D3D10_SHADER_VARIABLE_DESC
{
    ///Type: <b>LPCSTR</b> The variable name.
    const(char)* Name;
    ///Type: <b>UINT</b> Offset from the start of the parent structure, to the beginning of the variable.
    uint         StartOffset;
    ///Type: <b>UINT</b> Size of the variable (in bytes).
    uint         Size;
    ///Type: <b>UINT</b> Flags, which identify shader-variable properties (see D3D10_SHADER_VARIABLE_FLAGS).
    uint         uFlags;
    ///Type: <b>LPVOID</b> The default value for initializing the variable.
    void*        DefaultValue;
}

///Describes a shader-variable type.
struct D3D10_SHADER_TYPE_DESC
{
    ///Type: <b>D3D10_SHADER_VARIABLE_CLASS</b> Identifies the variable class as one of scalar, vector, matrix or
    ///object. See D3D10_SHADER_VARIABLE_CLASS.
    D3D_SHADER_VARIABLE_CLASS Class;
    ///Type: <b>D3D10_SHADER_VARIABLE_TYPE</b> The variable type. See D3D10_SHADER_VARIABLE_TYPE.
    D3D_SHADER_VARIABLE_TYPE Type;
    ///Type: <b>UINT</b> Number of rows in a matrix. Otherwise a numeric type returns 1, any other type returns 0.
    uint Rows;
    ///Type: <b>UINT</b> Number of columns in a matrix. Otherwise a numeric type returns 1, any other type returns 0.
    uint Columns;
    ///Type: <b>UINT</b> Number of elements in an array; otherwise 0.
    uint Elements;
    ///Type: <b>UINT</b> Number of members in the structure; otherwise 0.
    uint Members;
    ///Type: <b>UINT</b> Offset, in bytes, between the start of the parent structure and this variable.
    uint Offset;
}

///Describes how a shader resource is bound to a shader input.
struct D3D10_SHADER_INPUT_BIND_DESC
{
    ///Type: <b>LPCSTR</b> Name of the shader resource.
    const(char)*      Name;
    ///Type: <b>D3D10_SHADER_INPUT_TYPE</b> Identifies the type of data in the resource. See D3D10_SHADER_INPUT_TYPE.
    D3D_SHADER_INPUT_TYPE Type;
    ///Type: <b>UINT</b> Starting bind point.
    uint              BindPoint;
    ///Type: <b>UINT</b> Number of contiguous bind points for arrays.
    uint              BindCount;
    ///Type: <b>UINT</b> Shader input-parameter options. See D3D10_SHADER_INPUT_FLAGS.
    uint              uFlags;
    ///Type: <b>D3D10_RESOURCE_RETURN_TYPE</b> If the input is a texture, the return type. See
    ///D3D10_RESOURCE_RETURN_TYPE.
    D3D_RESOURCE_RETURN_TYPE ReturnType;
    ///Type: <b>D3D10_SRV_DIMENSION</b> Identifies the amount of data in the resource. See D3D10_SRV_DIMENSION.
    D3D_SRV_DIMENSION Dimension;
    ///Type: <b>UINT</b> The number of samples for a multisampled texture; otherwise 0.
    uint              NumSamples;
}

///Describes a shader signature.
struct D3D10_SIGNATURE_PARAMETER_DESC
{
    ///Type: <b>LPCSTR</b> A per-parameter string that identifies how the data will be used. See Semantics (DirectX
    ///HLSL).
    const(char)* SemanticName;
    ///Type: <b>UINT</b> Semantic index that modifies the semantic. Used to differentiate different parameters that use
    ///the same semantic.
    uint         SemanticIndex;
    ///Type: <b>UINT</b> The register that will contain this variable's data.
    uint         Register;
    ///Type: <b>D3D10_NAME</b> A predefined string that determines the functionality of certain pipeline stages. See
    ///D3D10_NAME.
    D3D_NAME     SystemValueType;
    ///Type: <b>D3D10_REGISTER_COMPONENT_TYPE</b> The per-component-data type that is stored in a register. See
    ///D3D10_REGISTER_COMPONENT_TYPE. Each register can store up to four-components of data.
    D3D_REGISTER_COMPONENT_TYPE ComponentType;
    ///Type: <b>BYTE</b> Mask which indicates which components of a register are used.
    ubyte        Mask;
    ///Type: <b>BYTE</b> Mask which indicates whether a given component is never written (if the signature is an output
    ///signature) or always read (if the signature is an input signature). The mask is a combination of
    ///D3D10_REGISTER_COMPONENT_TYPE values.
    ubyte        ReadWriteMask;
}

///Indicates the device state.
struct D3D10_STATE_BLOCK_MASK
{
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the vertex shader state.
    ubyte     VS;
    ///Type: <b>BYTE</b> Array of vertex-shader samplers. The array is a multi-byte bitmask where each bit represents
    ///one sampler slot.
    ubyte[2]  VSSamplers;
    ///Type: <b>BYTE</b> Array of vertex-shader resources. The array is a multi-byte bitmask where each bit represents
    ///one resource slot.
    ubyte[16] VSShaderResources;
    ///Type: <b>BYTE</b> Array of vertex-shader constant buffers. The array is a multi-byte bitmask where each bit
    ///represents one constant buffer slot.
    ubyte[2]  VSConstantBuffers;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the geometry shader state.
    ubyte     GS;
    ///Type: <b>BYTE</b> Array of geometry-shader samplers. The array is a multi-byte bitmask where each bit represents
    ///one sampler slot.
    ubyte[2]  GSSamplers;
    ///Type: <b>BYTE</b> Array of geometry-shader resources. The array is a multi-byte bitmask where each bit represents
    ///one resource slot.
    ubyte[16] GSShaderResources;
    ///Type: <b>BYTE</b> Array of geometry-shader constant buffers. The array is a multi-byte bitmask where each bit
    ///represents one buffer slot.
    ubyte[2]  GSConstantBuffers;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the pixel shader state.
    ubyte     PS;
    ///Type: <b>BYTE</b> Array of pixel-shader samplers. The array is a multi-byte bitmask where each bit represents one
    ///sampler slot.
    ubyte[2]  PSSamplers;
    ///Type: <b>BYTE</b> Array of pixel-shader resources. The array is a multi-byte bitmask where each bit represents
    ///one resource slot.
    ubyte[16] PSShaderResources;
    ///Type: <b>BYTE</b> Array of pixel-shader constant buffers. The array is a multi-byte bitmask where each bit
    ///represents one constant buffer slot.
    ubyte[2]  PSConstantBuffers;
    ///Type: <b>BYTE</b> Array of vertex buffers. The array is a multi-byte bitmask where each bit represents one
    ///resource slot.
    ubyte[2]  IAVertexBuffers;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the index buffer state.
    ubyte     IAIndexBuffer;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the input layout state.
    ubyte     IAInputLayout;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the primitive topology state.
    ubyte     IAPrimitiveTopology;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the render targets states.
    ubyte     OMRenderTargets;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the depth-stencil state.
    ubyte     OMDepthStencilState;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the blend state.
    ubyte     OMBlendState;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the viewports states.
    ubyte     RSViewports;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the scissor rectangles states.
    ubyte     RSScissorRects;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the rasterizer state.
    ubyte     RSRasterizerState;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the stream-out buffers states.
    ubyte     SOBuffers;
    ///Type: <b>BYTE</b> Boolean value indicating whether to save the predication state.
    ubyte     Predication;
}

///Describes an effect-variable type.
struct D3D10_EFFECT_TYPE_DESC
{
    ///Type: <b>LPCSTR</b> A string that contains the variable name.
    const(char)* TypeName;
    ///Type: <b>D3D10_SHADER_VARIABLE_CLASS</b> The variable class (see D3D10_SHADER_VARIABLE_CLASS).
    D3D_SHADER_VARIABLE_CLASS Class;
    ///Type: <b>D3D10_SHADER_VARIABLE_TYPE</b> The variable type (see D3D10_SHADER_VARIABLE_TYPE).
    D3D_SHADER_VARIABLE_TYPE Type;
    ///Type: <b>UINT</b> The number of elements if the variable is an array; otherwise 0.
    uint         Elements;
    ///Type: <b>UINT</b> The number of members if the variable is a structure; otherwise 0.
    uint         Members;
    ///Type: <b>UINT</b> The number of rows if the variable is a matrix; otherwise 0.
    uint         Rows;
    ///Type: <b>UINT</b> The number of columns if the variable is a matrix; otherwise 0.
    uint         Columns;
    ///Type: <b>UINT</b> The number of bytes that the variable consumes when it is packed tightly by the compiler.
    uint         PackedSize;
    ///Type: <b>UINT</b> The number of bytes that the variable consumes before it is packed by the compiler.
    uint         UnpackedSize;
    ///Type: <b>UINT</b> The number of bytes between elements.
    uint         Stride;
}

///Describes an effect variable.
struct D3D10_EFFECT_VARIABLE_DESC
{
    ///Type: <b>LPCSTR</b> A string that contains the variable name.
    const(char)* Name;
    ///Type: <b>LPCSTR</b> The semantic attached to the variable; otherwise <b>NULL</b>.
    const(char)* Semantic;
    ///Type: <b>UINT</b> Optional flags for effect variables.
    uint         Flags;
    ///Type: <b>UINT</b> The number of annotations; otherwise 0.
    uint         Annotations;
    ///Type: <b>UINT</b> The offset between the beginning of the constant buffer and this variable; otherwise 0.
    uint         BufferOffset;
    ///Type: <b>UINT</b> The register that this variable is bound to. To bind a variable explicitly use the
    ///D3D10_EFFECT_VARIABLE_EXPLICIT_BIND_POINT flag.
    uint         ExplicitBindPoint;
}

///Describes an effect shader.
struct D3D10_EFFECT_SHADER_DESC
{
    ///Type: <b>const BYTE*</b> Passed into CreateInputLayout. Only valid on a vertex shader or geometry shader. See
    ///ID3D10Device_CreateInputLayout.
    const(ubyte)* pInputSignature;
    ///Type: <b>BOOL</b> <b>TRUE</b> is the shader is defined inline; otherwise <b>FALSE</b>.
    BOOL          IsInline;
    ///Type: <b>const BYTE*</b> A pointer to the compiled shader.
    const(ubyte)* pBytecode;
    ///Type: <b>UINT</b> The length of pBytecode.
    uint          BytecodeLength;
    ///Type: <b>LPCSTR</b> A string that constains a declaration of the stream output from a geometry shader.
    const(char)*  SODecl;
    ///Type: <b>UINT</b> The number of entries in the input signature.
    uint          NumInputSignatureEntries;
    ///Type: <b>UINT</b> The number of entries in the output signature.
    uint          NumOutputSignatureEntries;
}

///Describes an effect pass, which contains pipeline state.
struct D3D10_PASS_DESC
{
    ///Type: <b>LPCSTR</b> A string that contains the name of the pass; otherwise <b>NULL</b>.
    const(char)* Name;
    ///Type: <b>UINT</b> The number of annotations.
    uint         Annotations;
    ///Type: <b>BYTE*</b> A pointer to the input signature or the vertex shader; otherwise <b>NULL</b>.
    ubyte*       pIAInputSignature;
    ///Type: <b>SIZE_T</b> The size of the input signature (in bytes).
    size_t       IAInputSignatureSize;
    ///Type: <b>UINT</b> The stencil-reference value used in the depth-stencil state (see Configuring Depth-Stencil
    ///Functionality (Direct3D 10)).
    uint         StencilRef;
    ///Type: <b>UINT</b> The sample mask for the blend state (see Configuring Blending Functionality (Direct3D 10)).
    uint         SampleMask;
    ///Type: <b>FLOAT</b> The per-component blend factors (RGBA) for the blend state (see Configuring Blending
    ///Functionality (Direct3D 10)).
    float[4]     BlendFactor;
}

///Describes an effect variable that contains a shader.
struct D3D10_PASS_SHADER_DESC
{
    ///Type: <b>ID3D10EffectShaderVariable*</b> A pointer to the variable that the shader came from. If it is an inline
    ///shader assignment, the returned interface will be an anonymous shader variable, which is not retrievable any
    ///other way. Its name in the variable description will be "$Anonymous". If there is no assignment of this type in
    ///the pass block, this will point to a shader variable that returns false when IsValid is called.
    ID3D10EffectShaderVariable pShaderVariable;
    ///Type: <b>UINT</b> A zero-based array index; otherwise 0.
    uint ShaderIndex;
}

///Describes an effect technique.
struct D3D10_TECHNIQUE_DESC
{
    ///Type: <b>LPCSTR</b> A string that contains the technique name; otherwise <b>NULL</b>.
    const(char)* Name;
    ///Type: <b>UINT</b> The number of passes in the technique.
    uint         Passes;
    ///Type: <b>UINT</b> The number of annotations.
    uint         Annotations;
}

///Describes an effect.
struct D3D10_EFFECT_DESC
{
    ///Type: <b>BOOL</b> <b>TRUE</b> if the effect is a child effect; otherwise <b>FALSE</b>.
    BOOL IsChildEffect;
    ///Type: <b>UINT</b> The number of constant buffers.
    uint ConstantBuffers;
    ///Type: <b>UINT</b> The number of constant buffers shared in an effect pool.
    uint SharedConstantBuffers;
    ///Type: <b>UINT</b> The number of global variables.
    uint GlobalVariables;
    ///Type: <b>UINT</b> The number of global variables shared in an effect pool.
    uint SharedGlobalVariables;
    ///Type: <b>UINT</b> The number of techniques.
    uint Techniques;
}

///Describes the blend state for a render target for a Direct3D 10.1 device
struct D3D10_RENDER_TARGET_BLEND_DESC1
{
    ///Type: <b>BOOL</b> Enable (or disable) blending.
    BOOL           BlendEnable;
    ///Type: <b>D3D10_BLEND</b> This blend option specifies the first RGB data source and includes an optional pre-blend
    ///operation.
    D3D10_BLEND    SrcBlend;
    ///Type: <b>D3D10_BLEND</b> This blend option specifies the second RGB data source and includes an optional
    ///pre-blend operation.
    D3D10_BLEND    DestBlend;
    ///Type: <b>D3D10_BLEND_OP</b> This blend operation defines how to combine the RGB data sources.
    D3D10_BLEND_OP BlendOp;
    ///Type: <b>D3D10_BLEND</b> This blend option specifies the first alpha data source and includes an optional
    ///pre-blend operation. Blend options that end in _COLOR are not allowed.
    D3D10_BLEND    SrcBlendAlpha;
    ///Type: <b>D3D10_BLEND</b> This blend option specifies the second alpha data source and includes an optional
    ///pre-blend operation. Blend options that end in _COLOR are not allowed.
    D3D10_BLEND    DestBlendAlpha;
    ///Type: <b>D3D10_BLEND_OP</b> This blend operation defines how to combine the alpha data sources.
    D3D10_BLEND_OP BlendOpAlpha;
    ///Type: <b>UINT8</b> A write mask.
    ubyte          RenderTargetWriteMask;
}

///Describes the blend state for a Direct3D 10.1 device.
struct D3D10_BLEND_DESC1
{
    ///Type: <b>BOOL</b> Determines whether or not to use the alpha-to-coveragemultisampling technique when setting a
    ///render-target pixel.
    BOOL AlphaToCoverageEnable;
    ///Type: <b>BOOL</b> Set to <b>TRUE</b> to enable independent blending in simultaneous render targets. If set to
    ///<b>FALSE</b>, only the RenderTarget[0] members are used. RenderTarget[1..7] are ignored.
    BOOL IndependentBlendEnable;
    ///Type: <b>D3D10_RENDER_TARGET_BLEND_DESC1</b> An array of render-target-blend descriptions (see
    ///D3D10_RENDER_TARGET_BLEND_DESC1); these correspond to the eight rendertargets that can be set to the
    ///output-merger stage at one time.
    D3D10_RENDER_TARGET_BLEND_DESC1[8] RenderTarget;
}

///Specifies the subresource(s) from an array of cube textures to use in a shader-resource view.
struct D3D10_TEXCUBE_ARRAY_SRV1
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> Number of mipmap levels to use.
    uint MipLevels;
    ///Type: <b>UINT</b> Index of the first 2D texture to use.
    uint First2DArrayFace;
    ///Type: <b>UINT</b> Number of cube textures in the array.
    uint NumCubes;
}

///Describes a shader-resource view.
struct D3D10_SHADER_RESOURCE_VIEW_DESC1
{
    ///Type: <b>DXGI_FORMAT</b> The viewing format. See remarks.
    DXGI_FORMAT       Format;
    ///Type: <b>D3D10_SRV_DIMENSION1</b> The resource type of the view. See D3D10_SRV_DIMENSION1. This should be the
    ///same as the resource type of the underlying resource. This parameter also determines which _SRV to use in the
    ///union below.
    D3D_SRV_DIMENSION ViewDimension;
    union
    {
        D3D10_BUFFER_SRV  Buffer;
        D3D10_TEX1D_SRV   Texture1D;
        D3D10_TEX1D_ARRAY_SRV Texture1DArray;
        D3D10_TEX2D_SRV   Texture2D;
        D3D10_TEX2D_ARRAY_SRV Texture2DArray;
        D3D10_TEX2DMS_SRV Texture2DMS;
        D3D10_TEX2DMS_ARRAY_SRV Texture2DMSArray;
        D3D10_TEX3D_SRV   Texture3D;
        D3D10_TEXCUBE_SRV TextureCube;
        D3D10_TEXCUBE_ARRAY_SRV1 TextureCubeArray;
    }
}

///Gives the source location for a shader element.
struct D3D10_SHADER_DEBUG_TOKEN_INFO
{
    ///Type: <b>UINT</b> Offset into file list.
    uint File;
    ///Type: <b>UINT</b> Line number.
    uint Line;
    ///Type: <b>UINT</b> Column number.
    uint Column;
    ///Type: <b>UINT</b> Length of the token.
    uint TokenLength;
    ///Type: <b>UINT</b> Offset to LPCSTR of length <b>TokenLength</b> in string datastore.
    uint TokenId;
}

///Represents information about a shader source variable.
struct D3D10_SHADER_DEBUG_VAR_INFO
{
    ///Type: <b>UINT</b> Index into token list for declaring identifier.
    uint TokenId;
    ///Type: <b>D3D10_SHADER_VARIABLE_TYPE</b> The variable type. <b>Type</b> is only required for arrays.
    D3D_SHADER_VARIABLE_TYPE Type;
    ///Type: <b>UINT</b> Register the variable is stored in.
    uint Register;
    ///Type: <b>UINT</b> The original variable that declared this variable.
    uint Component;
    ///Type: <b>UINT</b> Offset into the scope variable array defined in D3D10_SHADER_DEBUG_INFO.
    uint ScopeVar;
    ///Type: <b>UINT</b> This variable's offset in its <b>ScopeVar</b>.
    uint ScopeVarOffset;
}

///Describes a shader input.
struct D3D10_SHADER_DEBUG_INPUT_INFO
{
    ///Type: <b>UINT</b> Index into array of variables to initialize.
    uint Var;
    ///Type: <b>D3D10_SHADER_DEBUG_REGTYPE</b> Must be D3D10_SHADER_DEBUG_REG_INPUT, D3D10_SHADER_DEBUG_REG_CBUFFER or
    ///D3D10_SHADER_DEBUG_REG_TBUFFER.
    D3D10_SHADER_DEBUG_REGTYPE InitialRegisterSet;
    ///Type: <b>UINT</b> Will contain a cbuffer or tbuffer slot, geometry shader input primitive number, identifying
    ///register for an indexable temp, or -1.
    uint InitialBank;
    ///Type: <b>UINT</b> Register in register set. <b>InitialRegister</b> will be -1 if it is temporary.
    uint InitialRegister;
    ///Type: <b>UINT</b> Gives the component. <b>InitialComponent</b> will be -1 it is temporary.
    uint InitialComponent;
    ///Type: <b>UINT</b> Initial value if the variable is a literal.
    uint InitialValue;
}

///Describes a shader scope variable.
struct D3D10_SHADER_DEBUG_SCOPEVAR_INFO
{
    ///Type: <b>UINT</b> Index into variable token.
    uint TokenId;
    ///Type: <b>D3D10_SHADER_DEBUG_VARTYPE</b> Indicates whether this is a variable or function.
    D3D10_SHADER_DEBUG_VARTYPE VarType;
    ///Type: <b>D3D10_SHADER_VARIABLE_CLASS</b> Indicates the variable class.
    D3D_SHADER_VARIABLE_CLASS Class;
    ///Type: <b>UINT</b> Number of row for matrices.
    uint Rows;
    ///Type: <b>UINT</b> Number of columns for vectors or matrices.
    uint Columns;
    ///Type: <b>UINT</b> Gives a scope to look up struct members. This member will be -1 if
    ///<b>D3D10_SHADER_DEBUG_SCOPEVAR_INFO</b> does not refer to a struct.
    uint StructMemberScope;
    ///Type: <b>UINT</b> Number of array indices. For example a three dimensional array would have a value of 3 for
    ///<b>uArrayIndices</b>.
    uint uArrayIndices;
    ///Type: <b>UINT</b> Offset to an array of UINT values <b>uArrayIndices</b> long. The array contains the maximum
    ///value for each index. For example an array a[3][2][1] would have the values {3,2,1} at the offset pointed to by
    ///<b>ArrayElements</b>.
    uint ArrayElements;
    ///Type: <b>UINT</b> Offset to an array of UINT values <b>uArrayIndices</b> long. The array contains the stride for
    ///each array index. For example an array a[3][2][1] would have the values {2,1,1} at the offset pointed to by
    ///<b>ArrayStrides</b>.
    uint ArrayStrides;
    ///Type: <b>UINT</b> Number of variables.
    uint uVariables;
    ///Type: <b>UINT</b> Index of the first variable, later variables are offsets from this one.
    uint uFirstVariable;
}

///Contains scope data that maps variable names to debug variables.
struct D3D10_SHADER_DEBUG_SCOPE_INFO
{
    ///Type: <b>D3D10_SHADER_DEBUG_SCOPETYPE</b> Specifies the scope type.
    D3D10_SHADER_DEBUG_SCOPETYPE ScopeType;
    ///Type: <b>UINT</b> Offset to the name of scope in the strings list.
    uint Name;
    ///Type: <b>UINT</b> Length of the string pointed to by <b>Name</b>.
    uint uNameLen;
    ///Type: <b>UINT</b> Number of variables.
    uint uVariables;
    ///Type: <b>UINT</b> Offset an array of UINT values with <b>uVariables</b> members contianing the scope variable
    ///list.
    uint VariableData;
}

///Describes a shader output variable.
struct D3D10_SHADER_DEBUG_OUTPUTVAR
{
    ///Type: <b>UINT</b> The index variable being written to or if -1 it's not going to a variable.
    uint  Var;
    ///Type: <b>UINT</b> Minimum UINT value.
    uint  uValueMin;
    ///Type: <b>UINT</b> Maximum UINT value.
    uint  uValueMax;
    ///Type: <b>INT</b> Minimum INT value.
    int   iValueMin;
    ///Type: <b>INT</b> Maximum UINT value.
    int   iValueMax;
    ///Type: <b>FLOAT</b> Minimum FLOAT value.
    float fValueMin;
    ///Type: <b>FLOAT</b> Maximum FLOAT value.
    float fValueMax;
    ///Type: <b>BOOL</b> Indicates whether the output variable can evaluate to not a number.
    BOOL  bNaNPossible;
    ///Type: <b>BOOL</b> Indicates whether the output variable can evaluate to infinity.
    BOOL  bInfPossible;
}

///Describes a shader output register.
struct D3D10_SHADER_DEBUG_OUTPUTREG_INFO
{
    ///Type: <b>D3D10_SHADER_DEBUG_REGTYPE</b> Must be D3D10_SHADER_DEBUG_REG_TEMP, D3D10_SHADER_DEBUG_REG_TEMPARRAY or
    ///D3D10_SHADER_DEBUG_REG_OUTPUT.
    D3D10_SHADER_DEBUG_REGTYPE OutputRegisterSet;
    ///Type: <b>UINT</b> A value of -1 indicates no output.
    uint    OutputReg;
    ///Type: <b>UINT</b> If <b>OutputRegisterSet</b> is D3D10_SHADER_DEBUG_REG_TEMPARRAY this indicates which temp
    ///array.
    uint    TempArrayReg;
    ///Type: <b>UINT</b> A value of -1 means the component is masked out.
    uint[4] OutputComponents;
    ///Type: <b>D3D10_SHADER_DEBUG_OUTPUTVAR</b> Indicates which variable the instruction is writing per-component.
    D3D10_SHADER_DEBUG_OUTPUTVAR[4] OutputVars;
    ///Type: <b>UINT</b> Offset from OutputReg of the element being written to. Used when writing to an indexable temp
    ///array or an output.
    uint    IndexReg;
    ///Type: <b>UINT</b> Offset from OutputReg of the element being written to. Used when writing to an indexable temp
    ///array or an output.
    uint    IndexComp;
}

///Contains instruction data.
struct D3D10_SHADER_DEBUG_INST_INFO
{
    ///Type: <b>UINT</b> Id of the instruction.
    uint Id;
    ///Type: <b>UINT</b> Type of instruction.
    uint Opcode;
    ///Type: <b>UINT</b> Must be 0, 1 or 2.
    uint uOutputs;
    ///Type: <b>D3D10_SHADER_DEBUG_OUTPUTREG_INFO</b> Array containing the outputs of the instruction.
    D3D10_SHADER_DEBUG_OUTPUTREG_INFO[2] pOutputs;
    ///Type: <b>UINT</b> Index into the list of tokens for this instruction's token.
    uint TokenId;
    ///Type: <b>UINT</b> Number of function calls deep this instruction is.
    uint NestingLevel;
    ///Type: <b>UINT</b> Number of scopes.
    uint Scopes;
    ///Type: <b>UINT</b> Offset to an array of UINT values with <b>Scopes</b> elements.
    uint ScopeInfo;
    uint AccessedVars;
    uint AccessedVarsInfo;
}

///Describes files included by a shader.
struct D3D10_SHADER_DEBUG_FILE_INFO
{
    ///Type: <b>UINT</b> Offset to the LPCSTR for the file name.
    uint FileName;
    ///Type: <b>UINT</b> Length of the file name.
    uint FileNameLen;
    ///Type: <b>UINT</b> Offset to the file data.
    uint FileData;
    ///Type: <b>UINT</b> Length of the file.
    uint FileLen;
}

///Describes the format of the ID3D10Blob Interface returned by D3D10GetShaderDebugInfo.
struct D3D10_SHADER_DEBUG_INFO
{
    ///Type: <b>UINT</b> Size of this structure.
    uint Size;
    ///Type: <b>UINT</b> Offset to LPCSTR for compiler version.
    uint Creator;
    ///Type: <b>UINT</b> Offset to LPCSTR for Entry point name.
    uint EntrypointName;
    ///Type: <b>UINT</b> Offset to LPCSTR for shader target.
    uint ShaderTarget;
    ///Type: <b>UINT</b> Flags used to compile.
    uint CompileFlags;
    ///Type: <b>UINT</b> Number of included files.
    uint Files;
    ///Type: <b>UINT</b> Offset to array of D3D10_SHADER_DEBUG_FILE_INFO structures that has <b>Files</b> elements.
    uint FileInfo;
    ///Type: <b>UINT</b> Number of instructions.
    uint Instructions;
    ///Type: <b>UINT</b> Offset to array of D3D10_SHADER_DEBUG_INST_INFO structures that has <b>Instructions</b>
    ///elements.
    uint InstructionInfo;
    ///Type: <b>UINT</b> Number of variables.
    uint Variables;
    ///Type: <b>UINT</b> Offset to array of D3D10_SHADER_DEBUG_VAR_INFO structures that has <b>Variables</b> elements.
    uint VariableInfo;
    ///Type: <b>UINT</b> Number of variables to initialize before running.
    uint InputVariables;
    ///Type: <b>UINT</b> Offset to array of D3D10_SHADER_DEBUG_INPUT_INFO structures that has <b>InputVariables</b>
    ///elements.
    uint InputVariableInfo;
    ///Type: <b>UINT</b> Number of tokens to initialize.
    uint Tokens;
    ///Type: <b>UINT</b> Offset to array of D3D10_SHADER_DEBUG_TOKEN_INFO structures that has <b>Tokens</b> elements.
    uint TokenInfo;
    ///Type: <b>UINT</b> Number of scopes.
    uint Scopes;
    ///Type: <b>UINT</b> Offset to array of D3D10_SHADER_DEBUG_SCOPE_INFO structures that has <b>Scopes</b> elements.
    uint ScopeInfo;
    ///Type: <b>UINT</b> Number of variables declared.
    uint ScopeVariables;
    ///Type: <b>UINT</b> Offset to array of D3D10_SHADER_DEBUG_SCOPEVAR_INFO structures that has <b>Scopes</b> elements.
    uint ScopeVariableInfo;
    ///Type: <b>UINT</b> Offset to the UINT datastore, all UINT offsets are from this offset.
    uint UintOffset;
    ///Type: <b>UINT</b> Offset to the string datastore, all string offsets are from this offset.
    uint StringOffset;
}

// Functions

///Create a Direct3D 10.0 device that represents the display adapter.
///Params:
///    pAdapter = Type: <b>IDXGIAdapter*</b> Pointer to the display adapter (see IDXGIAdapter) when creating a hardware device;
///               otherwise set this parameter to <b>NULL</b>. If <b>NULL</b> is specified when creating a hardware device,
///               Direct3D will use the first adapter enumerated by EnumAdapters.
///    DriverType = Type: <b>D3D10_DRIVER_TYPE</b> The device-driver type (see D3D10_DRIVER_TYPE). The driver type determines the
///                 type of device you will create.
///    Software = Type: <b>HMODULE</b> Reserved. Set to <b>NULL</b>.
///    Flags = Type: <b>UINT</b> Optional. Device creation flags (see D3D10_CREATE_DEVICE_FLAG) that enable API layers. These
///            flags can be bitwise OR'd together.
///    SDKVersion = Type: <b>UINT</b> Bit flag that indicates the version of the SDK. Should always be D3D10_SDK_VERSION.
///    ppDevice = Type: <b>ID3D10Device**</b> Address of a pointer to the device created (see ID3D10Device Interface).
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10CreateDevice(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, ptrdiff_t Software, uint Flags, 
                          uint SDKVersion, ID3D10Device* ppDevice);

///Create a Direct3D 10.0 device and a swap chain.
///Params:
///    pAdapter = Type: <b>IDXGIAdapter*</b> Pointer to a IDXGIAdapter.
///    DriverType = Type: <b>D3D10_DRIVER_TYPE</b> The type of driver for the device. See D3D10_DRIVER_TYPE.
///    Software = Type: <b>HMODULE</b> A handle to the DLL that implements a software rasterizer. Must be <b>NULL</b> if DriverType
///               is non-software. The HMODULE of a DLL can be obtained with LoadLibrary, LoadLibraryEx, or GetModuleHandle.
///    Flags = Type: <b>UINT</b> Optional. Device creation flags (see D3D10_CREATE_DEVICE_FLAG) that enable API layers. These
///            flags can be bitwise OR'd together.
///    SDKVersion = Type: <b>UINT</b> Bit flag that indicates the version of the SDK. Should be D3D10_SDK_VERSION, defined in
///                 d3d10.h.
///    pSwapChainDesc = Type: <b>DXGI_SWAP_CHAIN_DESC*</b> Description of the swap chain. See DXGI_SWAP_CHAIN_DESC.
///    ppSwapChain = Type: <b>IDXGISwapChain**</b> Address of a pointer to an IDXGISwapChain.
///    ppDevice = Type: <b>ID3D10Device**</b> Address of a pointer to an ID3D10Device Interface that will receive the newly created
///               device.
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10CreateDeviceAndSwapChain(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, ptrdiff_t Software, 
                                      uint Flags, uint SDKVersion, DXGI_SWAP_CHAIN_DESC* pSwapChainDesc, 
                                      IDXGISwapChain* ppSwapChain, ID3D10Device* ppDevice);

///Create a buffer. <div class="alert"><b>Note</b> Instead of using this function, we recommend that you use the
///D3DCreateBlob API.</div><div> </div>
///Params:
///    NumBytes = Type: <b>SIZE_T</b> Number of bytes in the blob.
///    ppBuffer = Type: <b>LPD3D10BLOB*</b> The address of a pointer to the buffer (see ID3D10Blob Interface).
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10CreateBlob(size_t NumBytes, ID3DBlob* ppBuffer);

///Compile an HLSL shader. <div class="alert"><b>Note</b> Use D3DX10CompileFromMemory instead of this
///function.</div><div> </div>
///Params:
///    pSrcData = Type: <b>LPCSTR</b> Pointer to a string containing the shader source code.
///    SrcDataSize = Type: <b>SIZE_T</b> Size of pSrcData, in bytes.
///    pFileName = Type: <b>LPCSTR</b> The name of the file that contains the shader code.
///    pDefines = Type: <b>const D3D10_SHADER_MACRO*</b> Optional. Pointer to an array of macro definitions (see
///               D3D10_SHADER_MACRO). The last structure in the array serves as a terminator and must have all members set to 0.
///               If not used, set <i>pDefines</i> to <b>NULL</b>.
///    pInclude = Type: <b>LPD3D10INCLUDE*</b> Optional. Pointer to an ID3D10Include Interface interface for handling include
///               files. Setting this to <b>NULL</b> will cause a compile error if a shader contains a
///    pFunctionName = Type: <b>LPCSTR</b> Name of the shader-entry point function where shader execution begins.
///    pProfile = Type: <b>LPCSTR</b> A string that specifies the shader profile or shader model.
///    Flags = Type: <b>UINT</b> Shader compile options.
///    ppShader = Type: <b>ID3D10Blob**</b> A pointer to an ID3D10Blob Interface that contains the compiled shader, as well as any
///               embedded debug and symbol-table information.
///    ppErrorMsgs = Type: <b>ID3D10Blob**</b> A pointer to an ID3D10Blob Interface that contains a listing of errors and warnings
///                  that occurred during compilation. These errors and warnings are identical to the debug output from a debugger.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10CompileShader(const(char)* pSrcData, size_t SrcDataSize, const(char)* pFileName, 
                           const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, const(char)* pFunctionName, 
                           const(char)* pProfile, uint Flags, ID3DBlob* ppShader, ID3DBlob* ppErrorMsgs);

///This function -- which disassembles a compiled shader into a text string that contains assembly instructions and
///register assignments -- has been deprecated. Instead, use D3DDisassemble.
///Params:
///    pShader = Type: <b>const void*</b> A pointer to the compiled shader.
///    BytecodeLength = Type: <b>SIZE_T</b> The size of pShader.
///    EnableColorCode = Type: <b>BOOL</b> Include HTML tags in the output to color code the result.
///    pComments = Type: <b>LPCSTR</b> The comment string at the top of the shader that identifies the shader constants and
///                variables.
///    ppDisassembly = Type: <b>ID3D10Blob**</b> Address of a buffer which contains the disassembled shader.
///Returns:
///    Type: <b>HRESULT</b> Return value
///    
@DllImport("d3d10")
HRESULT D3D10DisassembleShader(char* pShader, size_t BytecodeLength, BOOL EnableColorCode, const(char)* pComments, 
                               ID3DBlob* ppDisassembly);

///Get the pixel shader profile best suited to a given device.
///Params:
///    pDevice = Type: <b>ID3D10Device*</b> Pointer to the device (see ID3D10Device Interface).
///Returns:
///    Type: <b>LPCSTR</b> The shader profile.
///    
@DllImport("d3d10")
byte* D3D10GetPixelShaderProfile(ID3D10Device pDevice);

///Get the vertex shader profile best suited to a given device.
///Params:
///    pDevice = Type: <b>ID3D10Device*</b> Pointer to the device (see ID3D10Device Interface).
///Returns:
///    Type: <b>LPCSTR</b> The shader profile.
///    
@DllImport("d3d10")
byte* D3D10GetVertexShaderProfile(ID3D10Device pDevice);

///Get the geometry shader profile best suited to a given device.
///Params:
///    pDevice = Type: <b>ID3D10Device*</b> Pointer to the device (see ID3D10Device Interface).
///Returns:
///    Type: <b>LPCSTR</b> The shader profile.
///    
@DllImport("d3d10")
byte* D3D10GetGeometryShaderProfile(ID3D10Device pDevice);

///This function -- which creates a shader-reflection object for retrieving information about a compiled shader -- has
///been deprecated. Instead, use D3DReflect.
///Params:
///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader.
///    BytecodeLength = Type: <b>SIZE_T</b> Length of pShaderBytecode.
///    ppReflector = Type: <b>ID3D10ShaderReflection**</b> Address of a reflection interface.
///Returns:
///    Type: <b>HRESULT</b> Return value.
///    
@DllImport("d3d10")
HRESULT D3D10ReflectShader(char* pShaderBytecode, size_t BytecodeLength, ID3D10ShaderReflection* ppReflector);

///Generate a shader-text string that contains the shader tokens that would be found in a compiled shader.
///Params:
///    pSrcData = Type: <b>LPCSTR</b> Pointer to a string containing the shader source code.
///    SrcDataSize = Type: <b>SIZE_T</b> Size of pSrcData, in bytes.
///    pFileName = Type: <b>LPCSTR</b> The name of the file that contains the shader code.
///    pDefines = Type: <b>const D3D10_SHADER_MACRO*</b> Optional. Pointer to an array of macro definitions (see
///               D3D10_SHADER_MACRO). The last structure in the array serves as a terminator and must have all members set to 0.
///               If not used, set <i>pDefines</i> to <b>NULL</b>.
///    pInclude = Type: <b>LPD3D10INCLUDE</b> Optional. Pointer to an ID3D10Include Interface interface for handling include files.
///               Setting this to <b>NULL</b> will cause a compile error if a shader contains a
///    ppShaderText = Type: <b>ID3D10Blob**</b> A pointer to a buffer that receives a pointer to an ID3D10Blob Interface that contains
///                   a single string containing shader-tokens.
///    ppErrorMsgs = Type: <b>ID3D10Blob**</b> A pointer to a buffer that receives a pointer to an ID3D10Blob Interface that contains
///                  a listing of errors and warnings that occurred during compilation. These errors and warnings are identical to the
///                  debug output from a debugger.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10PreprocessShader(const(char)* pSrcData, size_t SrcDataSize, const(char)* pFileName, 
                              const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, ID3DBlob* ppShaderText, 
                              ID3DBlob* ppErrorMsgs);

///Get a buffer that contains shader-input signatures.
///Params:
///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader. To get this pointer see Getting a Pointer to a
///                      Compiled Shader.
///    BytecodeLength = Type: <b>SIZE_T</b> The size of the shader bytecode in bytes.
///    ppSignatureBlob = Type: <b>ID3D10Blob**</b> The address of a pointer to the buffer (see ID3D10Blob Interface).
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10GetInputSignatureBlob(char* pShaderBytecode, size_t BytecodeLength, ID3DBlob* ppSignatureBlob);

///Get a buffer that contains shader-output signatures.
///Params:
///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader. To get this pointer see Getting a Pointer to a
///                      Compiled Shader.
///    BytecodeLength = Type: <b>SIZE_T</b> The size of the shader bytecode in bytes.
///    ppSignatureBlob = Type: <b>ID3D10Blob**</b> The address of a pointer to the buffer (see ID3D10Blob Interface).
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10GetOutputSignatureBlob(char* pShaderBytecode, size_t BytecodeLength, ID3DBlob* ppSignatureBlob);

///Get a buffer that contains shader signatures.
///Params:
///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader. To get this pointer see Getting a Pointer to a
///                      Compiled Shader.
///    BytecodeLength = Type: <b>SIZE_T</b> The size of the shader bytecode in bytes.
///    ppSignatureBlob = Type: <b>ID3D10Blob**</b> The address of a pointer to the buffer (see ID3D10Blob Interface).
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10GetInputAndOutputSignatureBlob(char* pShaderBytecode, size_t BytecodeLength, 
                                            ID3DBlob* ppSignatureBlob);

///Get shader debug info. Debug info is generated by D3D10CompileShader and is embedded in the body of the shader.
///Params:
///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader. To get this pointer see Getting a Pointer to a
///                      Compiled Shader.
///    BytecodeLength = Type: <b>SIZE_T</b> Length of the shader bytecode buffer.
///    ppDebugInfo = Type: <b>ID3D10Blob**</b> Pointer to an ID3D10Blob Interface used to return debug info. For information about the
///                  layout of this buffer, see D3D10_SHADER_DEBUG_INFO.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10GetShaderDebugInfo(char* pShaderBytecode, size_t BytecodeLength, ID3DBlob* ppDebugInfo);

///Combine two state-block masks with a bitwise OR.
///Params:
///    pA = Type: <b>D3D10_STATE_BLOCK_MASK*</b> State block mask on the left side of the bitwise OR operation. See
///         D3D10_STATE_BLOCK_MASK.
///    pB = Type: <b>D3D10_STATE_BLOCK_MASK*</b> State block mask on the right side of the bitwise OR operation.
///    pResult = Type: <b>D3D10_STATE_BLOCK_MASK*</b> The result of the bitwise OR operation.
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10StateBlockMaskUnion(D3D10_STATE_BLOCK_MASK* pA, D3D10_STATE_BLOCK_MASK* pB, 
                                 D3D10_STATE_BLOCK_MASK* pResult);

///Combine two state-block masks with a bitwise AND.
///Params:
///    pA = Type: <b>D3D10_STATE_BLOCK_MASK*</b> State block mask on the left side of the bitwise AND operation. See
///         D3D10_STATE_BLOCK_MASK.
///    pB = Type: <b>D3D10_STATE_BLOCK_MASK*</b> State block mask on the right side of the bitwise AND operation.
///    pResult = Type: <b>D3D10_STATE_BLOCK_MASK*</b> The result of the bitwise AND operation.
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10StateBlockMaskIntersect(D3D10_STATE_BLOCK_MASK* pA, D3D10_STATE_BLOCK_MASK* pB, 
                                     D3D10_STATE_BLOCK_MASK* pResult);

///Combine two state-block masks with a bitwise XOR.
///Params:
///    pA = Type: <b>D3D10_STATE_BLOCK_MASK*</b> State block mask on the left side of the bitwise XOR operation. See
///         D3D10_STATE_BLOCK_MASK.
///    pB = Type: <b>D3D10_STATE_BLOCK_MASK*</b> State block mask on the right side of the bitwise XOR operation.
///    pResult = Type: <b>D3D10_STATE_BLOCK_MASK*</b> The result of the bitwise XOR operation.
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10StateBlockMaskDifference(D3D10_STATE_BLOCK_MASK* pA, D3D10_STATE_BLOCK_MASK* pB, 
                                      D3D10_STATE_BLOCK_MASK* pResult);

///Enable a range of state values in a state block mask.
///Params:
///    pMask = Type: <b>D3D10_STATE_BLOCK_MASK*</b> A state block mask (see D3D10_STATE_BLOCK_MASK).
///    StateType = Type: <b>D3D10_DEVICE_STATE_TYPES</b> The type of device state to enable (see D3D10_DEVICE_STATE_TYPES.
///    RangeStart = Type: <b>UINT</b> The lower end of the range of values to set to true.
///    RangeLength = Type: <b>UINT</b> The upper end of the range of values to set to true.
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10StateBlockMaskEnableCapture(D3D10_STATE_BLOCK_MASK* pMask, D3D10_DEVICE_STATE_TYPES StateType, 
                                         uint RangeStart, uint RangeLength);

///Disable state capturing with a state-block mask.
///Params:
///    pMask = Type: <b>D3D10_STATE_BLOCK_MASK*</b> A state block mask (see D3D10_STATE_BLOCK_MASK).
///    StateType = Type: <b>D3D10_DEVICE_STATE_TYPES</b> The type of device state to disable (see D3D10_DEVICE_STATE_TYPES).
///    RangeStart = Type: <b>UINT</b> The lower end of the range of values to set to false.
///    RangeLength = Type: <b>UINT</b> The upper end of the range of values to set to false.
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10StateBlockMaskDisableCapture(D3D10_STATE_BLOCK_MASK* pMask, D3D10_DEVICE_STATE_TYPES StateType, 
                                          uint RangeStart, uint RangeLength);

///Enable a state-block mask to capture and apply all state variables.
///Params:
///    pMask = Type: <b>D3D10_STATE_BLOCK_MASK*</b> A mask with everything turned on.
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10StateBlockMaskEnableAll(D3D10_STATE_BLOCK_MASK* pMask);

///Disable all state capturing with a state-block mask.
///Params:
///    pMask = Type: <b>D3D10_STATE_BLOCK_MASK*</b> A mask filled with all zeroes (see D3D10_STATE_BLOCK_MASK).
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10StateBlockMaskDisableAll(D3D10_STATE_BLOCK_MASK* pMask);

///Get an element in a state-block mask; determine if an element is allowed by the mask for capturing and applying.
///Params:
///    pMask = Type: <b>D3D10_STATE_BLOCK_MASK*</b> State block mask. See D3D10_STATE_BLOCK_MASK.
///    StateType = Type: <b>D3D10_DEVICE_STATE_TYPES</b> The type of device state. See D3D10_DEVICE_STATE_TYPES.
///    Entry = Type: <b>UINT</b> The entry within the device state. This is only relevant for state types that have more than
///            one entry, such as D3D10_DST_GS_SAMPLERS.
///Returns:
///    Type: <b>BOOL</b> Returns true if the specified feature is allowed by the mask for capturing and applying, and
///    false otherwise.
///    
@DllImport("d3d10")
BOOL D3D10StateBlockMaskGetSetting(D3D10_STATE_BLOCK_MASK* pMask, D3D10_DEVICE_STATE_TYPES StateType, uint Entry);

///Create a state block.
///Params:
///    pDevice = Type: <b>ID3D10Device*</b> The device for which the state block will be created.
///    pStateBlockMask = Type: <b>D3D10_STATE_BLOCK_MASK*</b> Indicates which parts of the device state will be captured when calling
///                      ID3D10StateBlock::Capture and reapplied when calling ID3D10StateBlock::Apply. See remarks.
///    ppStateBlock = Type: <b>ID3D10StateBlock**</b> Address of a pointer to the buffer created (see ID3D10StateBlock Interface).
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10CreateStateBlock(ID3D10Device pDevice, D3D10_STATE_BLOCK_MASK* pStateBlockMask, 
                              ID3D10StateBlock* ppStateBlock);

///Compile an effect. <div class="alert"><b>Note</b> Use D3DX10CompileFromMemory instead of this function.</div><div>
///</div>
///Params:
///    pData = Type: <b>void*</b> A pointer to effect data; either ASCII HLSL code or a compiled effect.
///    DataLength = Type: <b>SIZE_T</b> Length of <i>pData</i>.
///    pSrcFileName = Type: <b>LPCSTR</b> The name of the effect file.
///    pDefines = Type: <b>const D3D10_SHADER_MACRO*</b> Optional. An array of NULL-terminated macro definitions (see
///               D3D10_SHADER_MACRO).
///    pInclude = Type: <b>ID3D10Include*</b> Optional. A pointer to an ID3D10Include Interface for handling include files. Setting
///               this to <b>NULL</b> will cause a compile error if a shader contains a
///    HLSLFlags = Type: <b>UINT</b> Shader compile options.
///    FXFlags = Type: <b>UINT</b> Effect compile options.
///    ppCompiledEffect = Type: <b>ID3D10Blob**</b> The address of a ID3D10Blob Interface that contains the compiled effect.
///    ppErrors = Type: <b>ID3D10Blob**</b> Optional. A pointer to an ID3D10Blob Interface that contains compiler error messages,
///               or <b>NULL</b> if there were no errors.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10CompileEffectFromMemory(char* pData, size_t DataLength, const(char)* pSrcFileName, 
                                     const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, uint HLSLFlags, 
                                     uint FXFlags, ID3DBlob* ppCompiledEffect, ID3DBlob* ppErrors);

///Creates an ID3D10Effect from a buffer containing a compiled effect.
///Params:
///    pData = Type: <b>void*</b> A pointer to a compiled effect.
///    DataLength = Type: <b>SIZE_T</b> Length of <i>pData</i>.
///    FXFlags = Type: <b>UINT</b> Effect compile options.
///    pDevice = Type: <b>ID3D10Device*</b> A pointer to the device (see ID3D10Device Interface).
///    pEffectPool = Type: <b>ID3D10EffectPool*</b> Optional. A pointer to an memory space for effect variables that are shared across
///                  effects (see ID3D10EffectPool Interface).
///    ppEffect = Type: <b>ID3D10Effect**</b> A pointer to an ID3D10Effect Interface which contains the created effect.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10CreateEffectFromMemory(char* pData, size_t DataLength, uint FXFlags, ID3D10Device pDevice, 
                                    ID3D10EffectPool pEffectPool, ID3D10Effect* ppEffect);

///Create an effect pool (or shared memory location), to enable sharing variables between effects.
///Params:
///    pData = Type: <b>void*</b> A pointer to a compiled effect.
///    DataLength = Type: <b>SIZE_T</b> Length of <i>pData</i>.
///    FXFlags = Type: <b>UINT</b> Effect compile options.
///    pDevice = Type: <b>ID3D10Device*</b> A pointer to the device (see ID3D10Device Interface).
///    ppEffectPool = Type: <b>ID3D10EffectPool**</b> A pointer to the ID3D10EffectPool Interface that contains the effect pool.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10CreateEffectPoolFromMemory(char* pData, size_t DataLength, uint FXFlags, ID3D10Device pDevice, 
                                        ID3D10EffectPool* ppEffectPool);

///This function -- which disassembles a compiled effect into a text string that contains assembly instructions and
///register assignments -- has been deprecated. Instead, use D3DDisassemble10Effect.
///Params:
///    pEffect = Type: <b>ID3D10Effect*</b> A pointer to an ID3D10Effect Interface, which contains the compiled effect.
///    EnableColorCode = Type: <b>BOOL</b> Include HTML tags in the output to color code the result.
///    ppDisassembly = Type: <b>ID3D10Blob**</b> A pointer to an ID3D10Blob Interface which contains the disassembled shader.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10")
HRESULT D3D10DisassembleEffect(ID3D10Effect pEffect, BOOL EnableColorCode, ID3DBlob* ppDisassembly);

///Create a Direct3D 10.1 device that represents the display adapter.
///Params:
///    pAdapter = Type: <b>IDXGIAdapter*</b> Pointer to the display adapter (see IDXGIAdapter) when creating a hardware device;
///               otherwise set this parameter to <b>NULL</b>. If <b>NULL</b> is specified when creating a hardware device,
///               Direct3D will use the first adapter enumerated by EnumAdapters.
///    DriverType = Type: <b>D3D10_DRIVER_TYPE</b> The device-driver type (see D3D10_DRIVER_TYPE). The driver type determines the
///                 type of device you will create.
///    Software = Type: <b>HMODULE</b> This is set to <b>NULL</b> except for D3D10_DRIVER_TYPE_SOFTWARE driver types.
///    Flags = Type: <b>UINT</b> Optional. Device creation flags (see D3D10_CREATE_DEVICE_FLAG) that enable API layers. These
///            flags can be bitwise OR'd together.
///    HardwareLevel = Type: <b>D3D10_FEATURE_LEVEL1</b> The version of hardware that is available for acceleration (see
///                    D3D10_FEATURE_LEVEL1).
///    SDKVersion = Type: <b>UINT</b> Bit flag that indicates the version of the SDK. Should be D3D10_1_SDK_VERSION, defined in
///                 D3D10.h.
///    ppDevice = Type: <b>ID3D10Device1**</b> Address of a pointer to the device created (see ID3D10Device1 Interface).
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10_1")
HRESULT D3D10CreateDevice1(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, ptrdiff_t Software, uint Flags, 
                           D3D10_FEATURE_LEVEL1 HardwareLevel, uint SDKVersion, ID3D10Device1* ppDevice);

///Create a Direct3D 10.1 device and a swap chain.
///Params:
///    pAdapter = Type: <b>IDXGIAdapter*</b> Pointer to a IDXGIAdapter.
///    DriverType = Type: <b>D3D10_DRIVER_TYPE</b> The type of driver for the device. See D3D10_DRIVER_TYPE.
///    Software = Type: <b>HMODULE</b> A handle to the DLL that implements a software rasterizer. Must be <b>NULL</b> if DriverType
///               is non-software. The HMODULE of a DLL can be obtained with LoadLibrary, LoadLibraryEx, or GetModuleHandle.
///    Flags = Type: <b>UINT</b> Optional. Device creation flags (see D3D10_CREATE_DEVICE_FLAG) that enable API layers. These
///            flags can be bitwise OR'd together.
///    HardwareLevel = Type: <b>D3D10_FEATURE_LEVEL1</b> The version of hardware that is available for acceleration (see
///                    D3D10_FEATURE_LEVEL1).
///    SDKVersion = Type: <b>UINT</b> Bit flag that indicates the version of the SDK. Should be D3D10_1_SDK_VERSION, defined in
///                 D3D10.h.
///    pSwapChainDesc = Type: <b>DXGI_SWAP_CHAIN_DESC*</b> Description of the swap chain. See DXGI_SWAP_CHAIN_DESC.
///    ppSwapChain = Type: <b>IDXGISwapChain**</b> Address of a pointer to an IDXGISwapChain.
///    ppDevice = Type: <b>ID3D10Device1**</b> Address of a pointer to an ID3D10Device1 Interface that will receive the newly
///               created device.
///Returns:
///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
///    
@DllImport("d3d10_1")
HRESULT D3D10CreateDeviceAndSwapChain1(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, ptrdiff_t Software, 
                                       uint Flags, D3D10_FEATURE_LEVEL1 HardwareLevel, uint SDKVersion, 
                                       DXGI_SWAP_CHAIN_DESC* pSwapChainDesc, IDXGISwapChain* ppSwapChain, 
                                       ID3D10Device1* ppDevice);


// Interfaces

///A device-child interface accesses data used by a device.
@GUID("9B7E4C00-342C-4106-A19F-4F2704F689F0")
interface ID3D10DeviceChild : IUnknown
{
    ///Get a pointer to the device that created this interface.
    ///Params:
    ///    ppDevice = Type: <b>ID3D10Device**</b> Address of a pointer to a device (see ID3D10Device Interface).
    void    GetDevice(ID3D10Device* ppDevice);
    ///Get application-defined data from a device child.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the data.
    ///    pDataSize = Type: <b>UINT*</b> Size of the data.
    ///    pData = Type: <b>void*</b> Pointer to the data stored with the device child. If pData is <b>NULL</b>, DataSize must
    ///            also be 0, and any data previously associated with the guid will be destroyed.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetPrivateData(const(GUID)* guid, uint* pDataSize, char* pData);
    ///Set application-defined data to a device child and associate that data with an application-defined guid.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the data.
    ///    DataSize = Type: <b>UINT</b> Size of the data.
    ///    pData = Type: <b>const void*</b> Pointer to the data to be stored with this device child. If pData is <b>NULL</b>,
    ///            DataSize must also be 0, and any data previously associated with the specified guid will be destroyed.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetPrivateData(const(GUID)* guid, uint DataSize, char* pData);
    ///Associate an IUnknown-derived interface with this device child and associate that interface with an
    ///application-defined guid.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the interface.
    ///    pData = Type: <b>const IUnknown*</b> Pointer to an IUnknown-derived interface to be associated with the device child.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetPrivateDataInterface(const(GUID)* guid, const(IUnknown) pData);
}

///A depth-stencil-state interface accesses depth-stencil state which sets up the depth-stencil test for the
///output-merger stage.
@GUID("2B4B1CC8-A4AD-41F8-8322-CA86FC3EC675")
interface ID3D10DepthStencilState : ID3D10DeviceChild
{
    ///Get the depth-stencil state.
    ///Params:
    ///    pDesc = Type: <b>D3D10_DEPTH_STENCIL_DESC*</b> A pointer to the depth-stencil state (see D3D10_DEPTH_STENCIL_DESC).
    void GetDesc(D3D10_DEPTH_STENCIL_DESC* pDesc);
}

///This blend-state interface accesses blending state for a Direct3D 10.0 device for the output-merger stage.
@GUID("EDAD8D19-8A35-4D6D-8566-2EA276CDE161")
interface ID3D10BlendState : ID3D10DeviceChild
{
    ///Get the blend state.
    ///Params:
    ///    pDesc = Type: <b>D3D10_BLEND_DESC*</b> A pointer to the blend state (see D3D10_BLEND_DESC).
    void GetDesc(D3D10_BLEND_DESC* pDesc);
}

///A rasterizer-state interface accesses rasterizer state for the rasterizer stage.
@GUID("A2A07292-89AF-4345-BE2E-C53D9FBB6E9F")
interface ID3D10RasterizerState : ID3D10DeviceChild
{
    ///Get the properties of a rasterizer-state object.
    ///Params:
    ///    pDesc = Type: <b>D3D10_RASTERIZER_DESC*</b> Pointer to a rasterizer-state description (see D3D10_RASTERIZER_DESC).
    void GetDesc(D3D10_RASTERIZER_DESC* pDesc);
}

///A resource interface provides common actions on all resources.
@GUID("9B7E4C01-342C-4106-A19F-4F2704F689F0")
interface ID3D10Resource : ID3D10DeviceChild
{
    ///Get the type of the resource.
    ///Params:
    ///    rType = Type: <b>D3D10_RESOURCE_DIMENSION*</b> Pointer to the resource type (see D3D10_RESOURCE_DIMENSION).
    void GetType(D3D10_RESOURCE_DIMENSION* rType);
    ///Set the eviction priority of a resource.
    ///Params:
    ///    EvictionPriority = Type: <b>UINT</b> Eviction priority for the resource, which is one of the following values: <ul>
    ///                       <li>DXGI_RESOURCE_PRIORITY_MINIMUM</li> <li>DXGI_RESOURCE_PRIORITY_LOW</li>
    ///                       <li>DXGI_RESOURCE_PRIORITY_NORMAL</li> <li>DXGI_RESOURCE_PRIORITY_HIGH</li>
    ///                       <li>DXGI_RESOURCE_PRIORITY_MAXIMUM</li> </ul>
    void SetEvictionPriority(uint EvictionPriority);
    ///Get the eviction priority of a resource.
    ///Returns:
    ///    Type: <b>UINT</b> One of the following values, which specifies the eviction priority for the resource: <ul>
    ///    <li>DXGI_RESOURCE_PRIORITY_MINIMUM</li> <li>DXGI_RESOURCE_PRIORITY_LOW</li>
    ///    <li>DXGI_RESOURCE_PRIORITY_NORMAL</li> <li>DXGI_RESOURCE_PRIORITY_HIGH</li>
    ///    <li>DXGI_RESOURCE_PRIORITY_MAXIMUM</li> </ul>
    ///    
    uint GetEvictionPriority();
}

///A buffer interface accesses a buffer resource, which is unstructured memory. Buffers typically store vertex or index
///data.
@GUID("9B7E4C02-342C-4106-A19F-4F2704F689F0")
interface ID3D10Buffer : ID3D10Resource
{
    ///Get a pointer to the data contained in the resource and deny GPU access to the resource.
    ///Params:
    ///    MapType = Type: <b>D3D10_MAP</b> Flag that specifies the CPU's permissions for the reading and writing of a resource.
    ///              For possible values, see D3D10_MAP.
    ///    MapFlags = Type: <b>UINT</b> Flag that specifies what the CPU should do when the GPU is busy (see D3D10_MAP_FLAG). This
    ///               flag is optional.
    ///    ppData = Type: <b>void**</b> Pointer to the buffer resource data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this function succeeds, it returns S_OK. The following list contains some of the
    ///    reasons that <b>Map</b> can fail: <ul> <li>If <i>MapFlags</i> specifies D3D10_MAP_FLAG_DO_NOT_WAIT and the
    ///    GPU is not yet finished with the resource, <b>ID3D10Buffer::Map</b> returns
    ///    DXGI_ERROR_WAS_STILL_DRAWING.</li> <li><b>ID3D10Buffer::Map</b> returns DXGI_ERROR_DEVICE_REMOVED if
    ///    <i>MapType</i> includes any flags that permit reading and the hardware device (that is, the video card) has
    ///    been removed.</li> </ul> For more information about the preceding return values, see DXGI_ERROR.
    ///    
    HRESULT Map(D3D10_MAP MapType, uint MapFlags, void** ppData);
    ///Invalidate the pointer to the resource retrieved by ID3D10Buffer::Map and reenable GPU access to the resource.
    void    Unmap();
    ///Get the properties of a buffer resource.
    ///Params:
    ///    pDesc = Type: <b>D3D10_BUFFER_DESC*</b> Pointer to a resource description (see D3D10_BUFFER_DESC) filled in by the
    ///            method. This pointer cannot be <b>NULL</b>.
    void    GetDesc(D3D10_BUFFER_DESC* pDesc);
}

///A 1D texture interface accesses texel data, which is structured memory.
@GUID("9B7E4C03-342C-4106-A19F-4F2704F689F0")
interface ID3D10Texture1D : ID3D10Resource
{
    ///Get a pointer to the data contained in a subresource, and deny the GPU access to that subresource.
    ///Params:
    ///    Subresource = Type: <b>UINT</b> Index number of the subresource. See D3D10CalcSubresource for more details.
    ///    MapType = Type: <b>D3D10_MAP</b> Specifies the CPU's read and write permissions for a resource. For possible values,
    ///              see D3D10_MAP.
    ///    MapFlags = Type: <b>UINT</b> Flag that specifies what the CPU should do when the GPU is busy. This flag is optional.
    ///    ppData = Type: <b>void**</b> Pointer to the texture resource data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this function succeeds, it returns S_OK. For other restrictions, and a listing of
    ///    error values that can be returned by any of the <b>Map</b> methods, see Remarks.
    ///    
    HRESULT Map(uint Subresource, D3D10_MAP MapType, uint MapFlags, void** ppData);
    ///Invalidate the pointer to a resource that was retrieved by ID3D10Texture1D::Map, and re-enable the GPU's access
    ///to that resource.
    ///Params:
    ///    Subresource = Type: <b>UINT</b> Subresource to be unmapped. See D3D10CalcSubresource for more details.
    void    Unmap(uint Subresource);
    ///Get the properties of the texture resource.
    ///Params:
    ///    pDesc = Type: <b>D3D10_TEXTURE1D_DESC*</b> Pointer to a resource description (see D3D10_TEXTURE1D_DESC).
    void    GetDesc(D3D10_TEXTURE1D_DESC* pDesc);
}

///A 2D texture interface manages texel data, which is structured memory.
@GUID("9B7E4C04-342C-4106-A19F-4F2704F689F0")
interface ID3D10Texture2D : ID3D10Resource
{
    ///Get a pointer to the data contained in a subresource, and deny GPU access to that subresource.
    ///Params:
    ///    Subresource = Type: <b>UINT</b> Index number of the subresource. See D3D10CalcSubresource for more details.
    ///    MapType = Type: <b>D3D10_MAP</b> Integer that specifies the CPU's read and write permissions for a resource. For
    ///              possible values, see D3D10_MAP.
    ///    MapFlags = Type: <b>UINT</b> Flag that specifies what the CPU should do when the GPU is busy. This flag is optional.
    ///    pMappedTex2D = Type: <b>D3D10_MAPPED_TEXTURE2D*</b> Pointer to a structure (D3D10_MAPPED_TEXTURE2D) that is filled in by the
    ///                   function and contains a pointer to the resource data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this function succeeds, it returns S_OK. All of the Map methods have identical return
    ///    values and operating restrictions. These are listed in the remarks section of ID3D10Texture1D::Map.
    ///    
    HRESULT Map(uint Subresource, D3D10_MAP MapType, uint MapFlags, D3D10_MAPPED_TEXTURE2D* pMappedTex2D);
    ///Invalidate the pointer to the resource that was retrieved by ID3D10Texture2D::Map, and re-enable GPU access to
    ///the resource.
    ///Params:
    ///    Subresource = Type: <b>UINT</b> Subresource to be unmapped. See D3D10CalcSubresource for more details.
    void    Unmap(uint Subresource);
    ///Get the properties of the texture resource.
    ///Params:
    ///    pDesc = Type: <b>D3D10_TEXTURE2D_DESC*</b> Pointer to a resource description (see D3D10_TEXTURE2D_DESC).
    void    GetDesc(D3D10_TEXTURE2D_DESC* pDesc);
}

///A 3D texture interface accesses texel data, which is structured memory.
@GUID("9B7E4C05-342C-4106-A19F-4F2704F689F0")
interface ID3D10Texture3D : ID3D10Resource
{
    ///Get a pointer to the data contained in a subresource, and deny GPU access to that subresource.
    ///Params:
    ///    Subresource = Type: <b>UINT</b> Index number of the subresource. See D3D10CalcSubresourcefor more details.
    ///    MapType = Type: <b>D3D10_MAP</b> Specifies the CPU's read and write permissions for a resource. For possible values,
    ///              see D3D10_MAP.
    ///    MapFlags = Type: <b>UINT</b> Flag that specifies what the CPU should do when the GPU is busy. This flag is optional.
    ///    pMappedTex3D = Type: <b>D3D10_MAPPED_TEXTURE3D*</b> Pointer to a structure (D3D10_MAPPED_TEXTURE3D) that is filled in by the
    ///                   function and contains a pointer to the resource data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this function succeeds, it returns S_OK. All of the Map methods have identical return
    ///    values and operating restrictions. These are listed in the remarks section of ID3D10Texture1D::Map.
    ///    
    HRESULT Map(uint Subresource, D3D10_MAP MapType, uint MapFlags, D3D10_MAPPED_TEXTURE3D* pMappedTex3D);
    ///Invalidate the pointer to the resource retrieved by ID3D10Texture3D::Map, and re-enable the GPU's access to the
    ///resource.
    ///Params:
    ///    Subresource = Type: <b>UINT</b> Subresource to be unmapped. See D3D10CalcSubresource for more details.
    void    Unmap(uint Subresource);
    ///Get the properties of the texture resource.
    ///Params:
    ///    pDesc = Type: <b>D3D10_TEXTURE3D_DESC*</b> Pointer to a resource description (see D3D10_TEXTURE3D_DESC).
    void    GetDesc(D3D10_TEXTURE3D_DESC* pDesc);
}

///A view interface specifies the parts of a resource the pipeline can access during rendering (see view).
@GUID("C902B03F-60A7-49BA-9936-2A3AB37A7E33")
interface ID3D10View : ID3D10DeviceChild
{
    ///Get the resource that is accessed through this view.
    ///Params:
    ///    ppResource = Type: <b>ID3D10Resource**</b> Address of a pointer to the resource that is accessed through this view. (See
    ///                 ID3D10Resource.)
    void GetResource(ID3D10Resource* ppResource);
}

///A shader-resource-view interface specifies the subresources a shader can access during rendering. Examples of shader
///resources include a constant buffer, a texture buffer, a texture or a sampler.
@GUID("9B7E4C07-342C-4106-A19F-4F2704F689F0")
interface ID3D10ShaderResourceView : ID3D10View
{
    ///Get the shader resource view's description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_SHADER_RESOURCE_VIEW_DESC*</b> A pointer to a D3D10_SHADER_RESOURCE_VIEW_DESC structure to be
    ///            filled with data about the shader resource view.
    void GetDesc(D3D10_SHADER_RESOURCE_VIEW_DESC* pDesc);
}

///A render-target-view interface identifies the render-target subresources that can be accessed during rendering.
@GUID("9B7E4C08-342C-4106-A19F-4F2704F689F0")
interface ID3D10RenderTargetView : ID3D10View
{
    ///Get the properties of a render target view.
    ///Params:
    ///    pDesc = Type: <b>D3D10_RENDER_TARGET_VIEW_DESC*</b> Pointer to the description of a render target view (see
    ///            D3D10_RENDER_TARGET_VIEW_DESC).
    void GetDesc(D3D10_RENDER_TARGET_VIEW_DESC* pDesc);
}

///A depth-stencil-view interface accesses a texture resource during depth-stencil testing.
@GUID("9B7E4C09-342C-4106-A19F-4F2704F689F0")
interface ID3D10DepthStencilView : ID3D10View
{
    ///Get the depth-stencil view.
    ///Params:
    ///    pDesc = Type: <b>D3D10_DEPTH_STENCIL_VIEW_DESC*</b> Pointer to a depth-stencil-view description (see
    ///            D3D10_DEPTH_STENCIL_VIEW_DESC).
    void GetDesc(D3D10_DEPTH_STENCIL_VIEW_DESC* pDesc);
}

///A vertex-shader interface manages an executable program (a vertex shader) that controls the vertex-shader stage.
@GUID("9B7E4C0A-342C-4106-A19F-4F2704F689F0")
interface ID3D10VertexShader : ID3D10DeviceChild
{
}

///A geometry-shader interface manages an executable program (a geometry shader) that controls the geometry-shader
///stage.
@GUID("6316BE88-54CD-4040-AB44-20461BC81F68")
interface ID3D10GeometryShader : ID3D10DeviceChild
{
}

///A pixel-shader interface manages an executable program (a pixel shader) that controls the pixel-shader stage.
@GUID("4968B601-9D00-4CDE-8346-8E7F675819B6")
interface ID3D10PixelShader : ID3D10DeviceChild
{
}

///An input-layout interface accesses the input data for the input-assembler stage.
@GUID("9B7E4C0B-342C-4106-A19F-4F2704F689F0")
interface ID3D10InputLayout : ID3D10DeviceChild
{
}

///A sampler-state interface accesses sampler state for a texture.
@GUID("9B7E4C0C-342C-4106-A19F-4F2704F689F0")
interface ID3D10SamplerState : ID3D10DeviceChild
{
    ///Get the sampler state.
    ///Params:
    ///    pDesc = Type: <b>D3D10_SAMPLER_DESC*</b> A pointer to the sampler state (see D3D10_SAMPLER_DESC).
    void GetDesc(D3D10_SAMPLER_DESC* pDesc);
}

///This interface encapsulates methods for retrieving data from the GPU asynchronously.
@GUID("9B7E4C0D-342C-4106-A19F-4F2704F689F0")
interface ID3D10Asynchronous : ID3D10DeviceChild
{
    ///Starts the collection of GPU data.
    void    Begin();
    ///Ends the collection of GPU data.
    void    End();
    ///Get data from the GPU asynchronously.
    ///Params:
    ///    pData = Type: <b>void*</b> Address of memory that will receive the data. If <b>NULL</b>, <b>GetData</b> will be used
    ///            only to check status. The type of data output depends on the type of asynchronous interface. See Remarks.
    ///    DataSize = Type: <b>UINT</b> Size of the data to retrieve or 0. This value can be obtained with
    ///               ID3D10Asynchronous::GetDataSize. Must be 0 when <i>pData</i> is <b>NULL</b>.
    ///    GetDataFlags = Type: <b>UINT</b> Optional flags. Can be 0 or any combination of the flags enumerated by
    ///                   D3D10_ASYNC_GETDATA_FLAG.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this function succeeds, it returns S_OK. Otherwise, possible return values are the
    ///    following: <ul> <li>S_FALSE</li> <li>DXGI_ERROR_DEVICE_REMOVED</li> <li>DXGI_ERROR_INVALID_CALL</li> </ul>
    ///    
    HRESULT GetData(char* pData, uint DataSize, uint GetDataFlags);
    ///Get the size of the data (in bytes) that is output when calling ID3D10Asynchronous::GetData.
    ///Returns:
    ///    Type: <b>UINT</b> Size of the data (in bytes) that is output when calling GetData.
    ///    
    uint    GetDataSize();
}

///A query interface queries information from the GPU.
@GUID("9B7E4C0E-342C-4106-A19F-4F2704F689F0")
interface ID3D10Query : ID3D10Asynchronous
{
    ///Get a query description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_QUERY_DESC*</b> Pointer to a query description (see D3D10_QUERY_DESC).
    void GetDesc(D3D10_QUERY_DESC* pDesc);
}

///A predicate interface determines whether geometry should be processed depending on the results of a previous draw
///call.
@GUID("9B7E4C10-342C-4106-A19F-4F2704F689F0")
interface ID3D10Predicate : ID3D10Query
{
}

///This interface encapsulates methods for measuring GPU performance.
@GUID("9B7E4C11-342C-4106-A19F-4F2704F689F0")
interface ID3D10Counter : ID3D10Asynchronous
{
    ///Get a counter description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_COUNTER_DESC*</b> Pointer to a counter description (see D3D10_COUNTER_DESC).
    void GetDesc(D3D10_COUNTER_DESC* pDesc);
}

///The device interface represents a virtual adapter for Direct3D 10.0; it is used to perform rendering and create
///Direct3D resources.
@GUID("9B7E4C0F-342C-4106-A19F-4F2704F689F0")
interface ID3D10Device : IUnknown
{
    ///Set the constant buffers used by the vertex shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting constant buffers to.
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set.
    ///    ppConstantBuffers = Type: <b>ID3D10Buffer*</b> Array of constant buffers (see ID3D10Buffer) being given to the device.
    void    VSSetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    ///Bind an array of shader resources to the pixel shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting shader resources to.
    ///    NumViews = Type: <b>UINT</b> Number of shader resources to set. Up to a maximum of 128 slots are available for shader
    ///               resources.
    ///    ppShaderResourceViews = Type: <b>ID3D10ShaderResourceView*</b> Array of shader resource view interfaces to set to the device.
    void    PSSetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    ///Sets a pixel shader to the device.
    ///Params:
    ///    pPixelShader = Type: <b>ID3D10PixelShader*</b> Pointer to a pixel shader (see ID3D10PixelShader). Passing in <b>NULL</b>
    ///                   disables the shader for this pipeline stage.
    void    PSSetShader(ID3D10PixelShader pPixelShader);
    ///Set an array of sampler states to the pixel shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting samplers to.
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers in the array. Each pipeline stage has a total of 16 sampler slots
    ///                  available.
    ///    ppSamplers = Type: <b>ID3D10SamplerState*</b> Pointer to an array of sampler-state interfaces (see ID3D10SamplerState).
    ///                 See Remarks.
    void    PSSetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    ///Set a vertex shader to the device.
    ///Params:
    ///    pVertexShader = Type: <b>ID3D10VertexShader*</b> Pointer to a vertex shader (see ID3D10VertexShader). Passing in <b>NULL</b>
    ///                    disables the shader for this pipeline stage.
    void    VSSetShader(ID3D10VertexShader pVertexShader);
    ///Draw indexed, non-instanced primitives.
    ///Params:
    ///    IndexCount = Type: <b>UINT</b> Number of indices to draw.
    ///    StartIndexLocation = Type: <b>UINT</b> Index of the first index to use when accesssing the vertex buffer; begin at
    ///                         <i>StartIndexLocation</i> to index vertices from the vertex buffer.
    ///    BaseVertexLocation = Type: <b>INT</b> Offset from the start of the vertex buffer to the first vertex.
    void    DrawIndexed(uint IndexCount, uint StartIndexLocation, int BaseVertexLocation);
    ///Draw non-indexed, non-instanced primitives.
    ///Params:
    ///    VertexCount = Type: <b>UINT</b> Number of vertices to draw.
    ///    StartVertexLocation = Type: <b>UINT</b> Index of the first vertex, which is usually an offset in a vertex buffer; it could also be
    ///                          used as the first vertex id generated for a shader parameter marked with the <b>SV_TargetId</b> system-value
    ///                          semantic.
    void    Draw(uint VertexCount, uint StartVertexLocation);
    ///Set the constant buffers used by the pixel shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting constant buffers to.
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set.
    ///    ppConstantBuffers = Type: <b>ID3D10Buffer*</b> Array of constant buffers (see ID3D10Buffer) being given to the device.
    void    PSSetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    ///Bind an input-layout object to the input-assembler stage.
    ///Params:
    ///    pInputLayout = Type: <b>ID3D10InputLayout*</b> A pointer to the input-layout object (see ID3D10InputLayout), which describes
    ///                   the input buffers that will be read by the IA stage.
    void    IASetInputLayout(ID3D10InputLayout pInputLayout);
    ///Bind an array of vertex buffers to the input-assembler stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> The first input slot for binding. The first vertex buffer is explicitly bound to the start
    ///                slot; this causes each additional vertex buffer in the array to be implicitly bound to each subsequent input
    ///                slot. A maximum of 16 or 32 input slots (ranges from 0 to either D3D10_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT -
    ///                1 or D3D10_1_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT - 1) are available; the maximum number of input slots
    ///                depends on the feature level.
    ///    NumBuffers = Type: <b>UINT</b> The number of vertex buffers in the array. The number of buffers (plus the starting slot)
    ///                 cannot exceed the total number of IA-stage input slots.
    ///    ppVertexBuffers = Type: <b>ID3D10Buffer*</b> A pointer to an array of vertex buffers (see ID3D10Buffer). The vertex buffers
    ///                      must have been created with the D3D10_BIND_VERTEX_BUFFER flag.
    ///    pStrides = Type: <b>const UINT*</b> Pointer to an array of stride values; one stride value for each buffer in the
    ///               vertex-buffer array. Each stride is the size (in bytes) of the elements that are to be used from that vertex
    ///               buffer.
    ///    pOffsets = Type: <b>const UINT*</b> Pointer to an array of offset values; one offset value for each buffer in the
    ///               vertex-buffer array. Each offset is the number of bytes between the first element of a vertex buffer and the
    ///               first element that will be used.
    void    IASetVertexBuffers(uint StartSlot, uint NumBuffers, char* ppVertexBuffers, char* pStrides, 
                               char* pOffsets);
    ///Bind an index buffer to the input-assembler stage.
    ///Params:
    ///    pIndexBuffer = Type: <b>ID3D10Buffer*</b> A pointer to a buffer (see ID3D10Buffer) that contains indices. The index buffer
    ///                   must have been created with the D3D10_BIND_INDEX_BUFFER flag.
    ///    Format = Type: <b>DXGI_FORMAT</b> Specifies format of the data in the index buffer. The only formats allowed for index
    ///             buffer data are 16-bit (DXGI_FORMAT_R16_UINT) and 32-bit (<b>DXGI_FORMAT_R32_UINT</b>) integers.
    ///    Offset = Type: <b>UINT</b> Offset (in bytes) from the start of the index buffer to the first index to use.
    void    IASetIndexBuffer(ID3D10Buffer pIndexBuffer, DXGI_FORMAT Format, uint Offset);
    ///Draw indexed, instanced primitives.
    ///Params:
    ///    IndexCountPerInstance = Type: <b>UINT</b> Size of the index buffer used in each instance.
    ///    InstanceCount = Type: <b>UINT</b> Number of instances to draw.
    ///    StartIndexLocation = Type: <b>UINT</b> Index of the first index.
    ///    BaseVertexLocation = Type: <b>INT</b> Index of the first vertex. The index is signed, which allows a negative index. If the
    ///                         negative index plus the index value from the index buffer are less than 0, the result is undefined.
    ///    StartInstanceLocation = Type: <b>UINT</b> Index of the first instance.
    void    DrawIndexedInstanced(uint IndexCountPerInstance, uint InstanceCount, uint StartIndexLocation, 
                                 int BaseVertexLocation, uint StartInstanceLocation);
    ///Draw non-indexed, instanced primitives.
    ///Params:
    ///    VertexCountPerInstance = Type: <b>UINT</b> Number of vertices to draw.
    ///    InstanceCount = Type: <b>UINT</b> Number of instances to draw.
    ///    StartVertexLocation = Type: <b>UINT</b> Index of the first vertex.
    ///    StartInstanceLocation = Type: <b>UINT</b> Index of the first instance.
    void    DrawInstanced(uint VertexCountPerInstance, uint InstanceCount, uint StartVertexLocation, 
                          uint StartInstanceLocation);
    ///Set the constant buffers used by the geometry shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting constant buffers to.
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set.
    ///    ppConstantBuffers = Type: <b>ID3D10Buffer*</b> Array of constant buffers (see ID3D10Buffer) being given to the device.
    void    GSSetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    ///Set a geometry shader to the device.
    ///Params:
    ///    pShader = Type: <b>ID3D10GeometryShader*</b> Pointer to a geometry shader (see ID3D10GeometryShader). Passing in
    ///              <b>NULL</b> disables the shader for this pipeline stage.
    void    GSSetShader(ID3D10GeometryShader pShader);
    ///Bind information about the primitive type, and data order that describes input data for the input assembler
    ///stage.
    ///Params:
    ///    Topology = Type: <b>D3D10_PRIMITIVE_TOPOLOGY</b> The type of primitive and ordering of the primitive data (see
    ///               D3D10_PRIMITIVE_TOPOLOGY).
    void    IASetPrimitiveTopology(D3D_PRIMITIVE_TOPOLOGY Topology);
    ///Bind an array of shader resources to the vertex shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting shader resources to.
    ///    NumViews = Type: <b>UINT</b> Number of shader resources to set. Up to a maximum of 128 slots are available for shader
    ///               resources.
    ///    ppShaderResourceViews = Type: <b>ID3D10ShaderResourceView*</b> Array of shader resource view interfaces to set to the device.
    void    VSSetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    ///Set an array of sampler states to the vertex shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting samplers to.
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers in the array. Each pipeline stage has a total of 16 sampler slots
    ///                  available.
    ///    ppSamplers = Type: <b>ID3D10SamplerState*</b> Pointer to an array of sampler-state interfaces (see ID3D10SamplerState).
    ///                 See Remarks.
    void    VSSetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    ///Set a rendering predicate.
    ///Params:
    ///    pPredicate = Type: <b>ID3D10Predicate*</b> Pointer to a predicate (see ID3D10Predicate). A <b>NULL</b> value indicates
    ///                 "no" predication; in this case, the value of PredicateValue is irrelevent but will be preserved for
    ///                 ID3D10Device::GetPredication.
    ///    PredicateValue = Type: <b>BOOL</b> If <b>TRUE</b>, rendering will be affected by when the predicate's conditions are met. If
    ///                     <b>FALSE</b>, rendering will be affected when the conditions are not met.
    void    SetPredication(ID3D10Predicate pPredicate, BOOL PredicateValue);
    ///Bind an array of shader resources to the geometry shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting shader resources to.
    ///    NumViews = Type: <b>UINT</b> Number of shader resources to set. Up to a maximum of 128 slots are available for shader
    ///               resources.
    ///    ppShaderResourceViews = Type: <b>ID3D10ShaderResourceView*</b> Array of shader resource view interfaces to set to the device.
    void    GSSetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    ///Set an array of sampler states to the geometry shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting samplers to.
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers in the array. Each pipeline stage has a total of 16 sampler slots
    ///                  available.
    ///    ppSamplers = Type: <b>ID3D10SamplerState*</b> Pointer to an array of sampler-state interfaces (see ID3D10SamplerState).
    ///                 See Remarks.
    void    GSSetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    ///Bind one or more render targets and the depth-stencil buffer to the output-merger stage.
    ///Params:
    ///    NumViews = Type: <b>UINT</b> Number of render targets to bind.
    ///    ppRenderTargetViews = Type: <b>ID3D10RenderTargetView*</b> Pointer to an array of render targets (see ID3D10RenderTargetView) to
    ///                          bind to the device. If this parameter is <b>NULL</b>, no render targets are bound. See Remarks.
    ///    pDepthStencilView = Type: <b>ID3D10DepthStencilView*</b> Pointer to a depth-stencil view (see ID3D10DepthStencilView) to bind to
    ///                        the device. If this parameter is <b>NULL</b>, the depth-stencil state is not bound.
    void    OMSetRenderTargets(uint NumViews, char* ppRenderTargetViews, ID3D10DepthStencilView pDepthStencilView);
    ///Set the blend state of the output-merger stage.
    ///Params:
    ///    pBlendState = Type: <b>ID3D10BlendState*</b> Pointer to a blend-state interface (see ID3D10BlendState). Passing in
    ///                  <b>NULL</b> implies a default blend state. See remarks for further details.
    ///    BlendFactor = Type: <b>const FLOAT</b> Array of blend factors, one for each RGBA component. The blend factors modulate
    ///                  values for the pixel shader, render target, or both. If you created the blend-state object with
    ///                  D3D10_BLEND_BLEND_FACTOR or D3D10_BLEND_INV_BLEND_FACTOR, the blending stage uses the non-NULL array of blend
    ///                  factors. If you didn't create the blend-state object with <b>D3D10_BLEND_BLEND_FACTOR</b> or
    ///                  <b>D3D10_BLEND_INV_BLEND_FACTOR</b>, the blending stage does not use the non-NULL array of blend factors; the
    ///                  runtime stores the blend factors, and you can later call ID3D11DeviceContext::OMGetBlendState to retrieve the
    ///                  blend factors. If you pass <b>NULL</b>, the runtime uses or stores a blend factor equal to { 1, 1, 1, 1 }.
    ///    SampleMask = Type: <b>UINT</b> 32-bit sample coverage. The default value is 0xffffffff. See remarks.
    void    OMSetBlendState(ID3D10BlendState pBlendState, const(float)* BlendFactor, uint SampleMask);
    ///Sets the depth-stencil state of the output-merger stage.
    ///Params:
    ///    pDepthStencilState = Type: <b>ID3D10DepthStencilState*</b> Pointer to a depth-stencil state interface (see
    ///                         ID3D10DepthStencilState) to bind to the device.
    ///    StencilRef = Type: <b>UINT</b> Reference value to perform against when doing a depth-stencil test. See remarks.
    void    OMSetDepthStencilState(ID3D10DepthStencilState pDepthStencilState, uint StencilRef);
    ///Set the target output buffers for the StreamOutput stage, which enables/disables the pipeline to stream-out data.
    ///Params:
    ///    NumBuffers = Type: <b>UINT</b> The number of buffer to bind to the device. A maximum of four output buffers can be set. If
    ///                 less than four are defined by the call, the remaining buffer slots are set to <b>NULL</b>. See Remarks.
    ///    ppSOTargets = Type: <b>ID3D10Buffer*</b> The array of output buffers (see ID3D10Buffer) to bind to the device. The buffers
    ///                  must have been created with the D3D10_BIND_STREAM_OUTPUT flag.
    ///    pOffsets = Type: <b>const UINT*</b> Array of offsets to the output buffers from <i>ppSOTargets</i>, one offset for each
    ///               buffer. The offset values must be in bytes.
    void    SOSetTargets(uint NumBuffers, char* ppSOTargets, char* pOffsets);
    ///Draw geometry of an unknown size that was created by the geometry shader stage. See remarks.
    void    DrawAuto();
    ///Set the rasterizer state for the rasterizer stage of the pipeline.
    ///Params:
    ///    pRasterizerState = Type: <b>ID3D10RasterizerState*</b> Pointer to a rasterizer-state interface (see ID3D10RasterizerState) to
    ///                       bind to the pipeline.
    void    RSSetState(ID3D10RasterizerState pRasterizerState);
    ///Bind an array of viewports to the rasterizer stage of the pipeline.
    ///Params:
    ///    NumViewports = Type: <b>UINT</b> Number of viewports to bind.
    ///    pViewports = Type: <b>const D3D10_VIEWPORT*</b> An array of viewports (see D3D10_VIEWPORT) to bind to the device. Each
    ///                 viewport must have its extents within the allowed ranges: D3D10_VIEWPORT_BOUNDS_MIN,
    ///                 D3D10_VIEWPORT_BOUNDS_MAX, D3D10_MIN_DEPTH, and D3D10_MAX_DEPTH.
    void    RSSetViewports(uint NumViewports, char* pViewports);
    ///Bind an array of scissor rectangles to the rasterizer stage.
    ///Params:
    ///    NumRects = Type: <b>UINT</b> Number of scissor rectangles to bind.
    ///    pRects = Type: <b>const D3D10_RECT*</b> An array of scissor rectangles (see D3D10_RECT).
    void    RSSetScissorRects(uint NumRects, char* pRects);
    ///Copy a region from a source resource to a destination resource.
    ///Params:
    ///    pDstResource = Type: <b>ID3D10Resource*</b> A pointer to the destination resource (see ID3D10Resource).
    ///    DstSubresource = Type: <b>UINT</b> Subresource index of the destination.
    ///    DstX = Type: <b>UINT</b> The x coordinate of the upper left corner of the destination region.
    ///    DstY = Type: <b>UINT</b> The y coordinate of the upper left corner of the destination region.
    ///    DstZ = Type: <b>UINT</b> The z coordinate of the upper left corner of the destination region. For a 1D or 2D
    ///           subresource, this must be zero.
    ///    pSrcResource = Type: <b>ID3D10Resource*</b> A pointer to the source resource (see ID3D10Resource).
    ///    SrcSubresource = Type: <b>UINT</b> Subresource index of the source.
    ///    pSrcBox = Type: <b>const D3D10_BOX*</b> A 3D box (see D3D10_BOX) that defines the source subresource that can be
    ///              copied. If <b>NULL</b>, the entire source subresource is copied. The box must fit within the source resource.
    ///              An empty box results in a no-op. A box is empty if the top value is greater than or equal to the bottom
    ///              value, or the left value is greater than or equal to the right value, or the front value is greater than or
    ///              equal to the back value. When the box is empty, <b>CopySubresourceRegion</b> doesn't perform a copy
    ///              operation.
    void    CopySubresourceRegion(ID3D10Resource pDstResource, uint DstSubresource, uint DstX, uint DstY, 
                                  uint DstZ, ID3D10Resource pSrcResource, uint SrcSubresource, 
                                  const(D3D10_BOX)* pSrcBox);
    ///Copy the entire contents of the source resource to the destination resource using the GPU.
    ///Params:
    ///    pDstResource = Type: <b>ID3D10Resource*</b> A pointer to the destination resource (see ID3D10Resource).
    ///    pSrcResource = Type: <b>ID3D10Resource*</b> A pointer to the source resource (see ID3D10Resource).
    void    CopyResource(ID3D10Resource pDstResource, ID3D10Resource pSrcResource);
    ///The CPU copies data from memory to a subresource created in non-mappable memory. See remarks.
    ///Params:
    ///    pDstResource = Type: <b>ID3D10Resource*</b> A pointer to the destination resource (see ID3D10Resource Interface).
    ///    DstSubresource = Type: <b>UINT</b> A zero-based index, that identifies the destination subresource. See D3D10CalcSubresource
    ///                     for more details.
    ///    pDstBox = Type: <b>const D3D10_BOX*</b> A box that defines the portion of the destination subresource to copy the
    ///              resource data into. Coordinates are in bytes for buffers and in texels for textures. If <b>NULL</b>, the data
    ///              is written to the destination subresource with no offset. The dimensions of the source must fit the
    ///              destination (see D3D10_BOX). An empty box results in a no-op. A box is empty if the top value is greater than
    ///              or equal to the bottom value, or the left value is greater than or equal to the right value, or the front
    ///              value is greater than or equal to the back value. When the box is empty, <b>UpdateSubresource</b> doesn't
    ///              perform an update operation.
    ///    pSrcData = Type: <b>const void*</b> A pointer to the source data in memory.
    ///    SrcRowPitch = Type: <b>UINT</b> The size of one row of the source data.
    ///    SrcDepthPitch = Type: <b>UINT</b> The size of one depth slice of source data.
    void    UpdateSubresource(ID3D10Resource pDstResource, uint DstSubresource, const(D3D10_BOX)* pDstBox, 
                              const(void)* pSrcData, uint SrcRowPitch, uint SrcDepthPitch);
    ///Set all the elements in a render target to one value.
    ///Params:
    ///    pRenderTargetView = Type: <b>ID3D10RenderTargetView*</b> Pointer to the render target.
    ///    ColorRGBA = Type: <b>const FLOAT</b> A 4-component array that represents the color to fill the render target with.
    void    ClearRenderTargetView(ID3D10RenderTargetView pRenderTargetView, const(float)* ColorRGBA);
    ///Clears the depth-stencil resource.
    ///Params:
    ///    pDepthStencilView = Type: <b>ID3D10DepthStencilView*</b> Pointer to the depth stencil to be cleared.
    ///    ClearFlags = Type: <b>UINT</b> Which parts of the buffer to clear. See D3D10_CLEAR_FLAG.
    ///    Depth = Type: <b>FLOAT</b> Clear the depth buffer with this value. This value will be clamped between 0 and 1.
    ///    Stencil = Type: <b>UINT8</b> Clear the stencil buffer with this value.
    void    ClearDepthStencilView(ID3D10DepthStencilView pDepthStencilView, uint ClearFlags, float Depth, 
                                  ubyte Stencil);
    ///Generates mipmaps for the given shader resource.
    ///Params:
    ///    pShaderResourceView = Type: <b>ID3D10ShaderResourceView*</b> A pointer to an ID3D10ShaderResourceView. The mipmaps will be
    ///                          generated for this shader resource.
    void    GenerateMips(ID3D10ShaderResourceView pShaderResourceView);
    ///Copy a multisampled resource into a non-multisampled resource. This API is most useful when re-using the
    ///resulting rendertarget of one render pass as an input to a second render pass.
    ///Params:
    ///    pDstResource = Type: <b>ID3D10Resource*</b> Destination resource. Must be a created with the D3D10_USAGE_DEFAULT flag and be
    ///                   single-sampled. See ID3D10Resource.
    ///    DstSubresource = Type: <b>UINT</b> A zero-based index, that identifies the destination subresource. See D3D10CalcSubresource
    ///                     for more details.
    ///    pSrcResource = Type: <b>ID3D10Resource*</b> Source resource. Must be multisampled.
    ///    SrcSubresource = Type: <b>UINT</b> The source subresource of the source resource.
    ///    Format = Type: <b>DXGI_FORMAT</b> DXGI_FORMAT that indicates how the multisampled resource will be resolved to a
    ///             single-sampled resource. See remarks.
    void    ResolveSubresource(ID3D10Resource pDstResource, uint DstSubresource, ID3D10Resource pSrcResource, 
                               uint SrcSubresource, DXGI_FORMAT Format);
    ///Get the constant buffers used by the vertex shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin retrieving constant buffers from.
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to retrieve.
    ///    ppConstantBuffers = Type: <b>ID3D10Buffer**</b> Array of constant buffer interface pointers (see ID3D10Buffer) to be returned by
    ///                        the method.
    void    VSGetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    ///Get the pixel shader resources.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting shader resources from.
    ///    NumViews = Type: <b>UINT</b> The number of resources to get from the device. Up to a maximum of 128 slots are available
    ///               for shader resources.
    ///    ppShaderResourceViews = Type: <b>ID3D10ShaderResourceView**</b> Array of shader resource view interfaces to be returned by the
    ///                            device.
    void    PSGetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    ///Get the pixel shader currently set on the device.
    ///Params:
    ///    ppPixelShader = Type: <b>ID3D10PixelShader**</b> Address of a pointer to a pixel shader (see ID3D10PixelShader) to be
    ///                    returned by the method.
    void    PSGetShader(ID3D10PixelShader* ppPixelShader);
    ///Get an array of sampler states from the pixel shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting samplers from.
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers to get from the device. Each pipeline stage has a total of 16 sampler
    ///                  slots available.
    ///    ppSamplers = Type: <b>ID3D10SamplerState**</b> Arry of sampler-state interface pointers (see ID3D10SamplerState) to be
    ///                 returned by the device.
    void    PSGetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    ///Get the vertex shader currently set on the device.
    ///Params:
    ///    ppVertexShader = Type: <b>ID3D10VertexShader**</b> Address of a pointer to a vertex shader (see ID3D10VertexShader) to be
    ///                     returned by the method.
    void    VSGetShader(ID3D10VertexShader* ppVertexShader);
    ///Get the constant buffers used by the pixel shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin retrieving constant buffers from.
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to retrieve.
    ///    ppConstantBuffers = Type: <b>ID3D10Buffer**</b> Array of constant buffer interface pointers (see ID3D10Buffer) to be returned by
    ///                        the method.
    void    PSGetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    ///Get a pointer to the input-layout object that is bound to the input-assembler stage.
    ///Params:
    ///    ppInputLayout = Type: <b>ID3D10InputLayout**</b> A pointer to the input-layout object (see ID3D10InputLayout), which
    ///                    describes the input buffers that will be read by the IA stage.
    void    IAGetInputLayout(ID3D10InputLayout* ppInputLayout);
    ///Get the vertex buffers bound to the input-assembler stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> The input slot of the first vertex buffer to get. The first vertex buffer is explicitly
    ///                bound to the start slot; this causes each additional vertex buffer in the array to be implicitly bound to
    ///                each subsequent input slot. A maximum of 16 or 32 input slots (ranges from 0 to either
    ///                D3D10_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT - 1 or D3D10_1_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT - 1) are
    ///                available; the maximum number of input slots depends on the feature level.
    ///    NumBuffers = Type: <b>UINT</b> The number of vertex buffers to get starting at the offset. The number of buffers (plus the
    ///                 starting slot) cannot exceed the total number of IA-stage input slots.
    ///    ppVertexBuffers = Type: <b>ID3D10Buffer**</b> A pointer to an array of vertex buffers returned by the method (see
    ///                      ID3D10Buffer).
    ///    pStrides = Type: <b>UINT*</b> Pointer to an array of stride values returned by the method; one stride value for each
    ///               buffer in the vertex-buffer array. Each stride value is the size (in bytes) of the elements that are to be
    ///               used from that vertex buffer.
    ///    pOffsets = Type: <b>UINT*</b> Pointer to an array of offset values returned by the method; one offset value for each
    ///               buffer in the vertex-buffer array. Each offset is the number of bytes between the first element of a vertex
    ///               buffer and the first element that will be used.
    void    IAGetVertexBuffers(uint StartSlot, uint NumBuffers, char* ppVertexBuffers, char* pStrides, 
                               char* pOffsets);
    ///Get a pointer to the index buffer that is bound to the input-assembler stage.
    ///Params:
    ///    pIndexBuffer = Type: <b>ID3D10Buffer**</b> A pointer to an index buffer returned by the method (see ID3D10Buffer).
    ///    Format = Type: <b>DXGI_FORMAT*</b> Specifies format of the data in the index buffer (see DXGI_FORMAT). These formats
    ///             provide the size and type of the data in the buffer. The only formats allowed for index buffer data are
    ///             16-bit (DXGI_FORMAT_R16_UINT) and 32-bit (DXGI_FORMAT_R32_UINT) integers.
    ///    Offset = Type: <b>UINT*</b> Offset (in bytes) from the start of the index buffer, to the first index to use.
    void    IAGetIndexBuffer(ID3D10Buffer* pIndexBuffer, DXGI_FORMAT* Format, uint* Offset);
    ///Get the constant buffers used by the geometry shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin retrieving constant buffers from.
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to retrieve.
    ///    ppConstantBuffers = Type: <b>ID3D10Buffer**</b> Array of constant buffer interface pointers (see ID3D10Buffer) to be returned by
    ///                        the method.
    void    GSGetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    ///Get the geometry shader currently set on the device.
    ///Params:
    ///    ppGeometryShader = Type: <b>ID3D10GeometryShader**</b> Address of a pointer to a geometry shader (see ID3D10GeometryShader) to
    ///                       be returned by the method.
    void    GSGetShader(ID3D10GeometryShader* ppGeometryShader);
    ///Get information about the primitive type, and data order that describes input data for the input assembler stage.
    ///Params:
    ///    pTopology = Type: <b>D3D10_PRIMITIVE_TOPOLOGY*</b> A pointer to the type of primitive, and ordering of the primitive data
    ///                (see D3D10_PRIMITIVE_TOPOLOGY).
    void    IAGetPrimitiveTopology(D3D_PRIMITIVE_TOPOLOGY* pTopology);
    ///Get the vertex shader resources.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting shader resources from.
    ///    NumViews = Type: <b>UINT</b> The number of resources to get from the device. Up to a maximum of 128 slots are available
    ///               for shader resources.
    ///    ppShaderResourceViews = Type: <b>ID3D10ShaderResourceView**</b> Array of shader resource view interfaces to be returned by the
    ///                            device.
    void    VSGetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    ///Get an array of sampler states from the vertex shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting samplers from.
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers to get from the device. Each pipeline stage has a total of 16 sampler
    ///                  slots available.
    ///    ppSamplers = Type: <b>ID3D10SamplerState**</b> Arry of sampler-state interface pointers (see ID3D10SamplerState) to be
    ///                 returned by the device.
    void    VSGetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    ///Get the rendering predicate state.
    ///Params:
    ///    ppPredicate = Type: <b>ID3D10Predicate**</b> Address of a pointer to a predicate (see ID3D10Predicate). Value stored here
    ///                  will be <b>NULL</b> upon device creation.
    ///    pPredicateValue = Type: <b>BOOL*</b> Address of a boolean to fill with the predicate comparison value. <b>FALSE</b> upon device
    ///                      creation.
    void    GetPredication(ID3D10Predicate* ppPredicate, int* pPredicateValue);
    ///Get the geometry shader resources.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting shader resources from.
    ///    NumViews = Type: <b>UINT</b> The number of resources to get from the device. Up to a maximum of 128 slots are available
    ///               for shader resources.
    ///    ppShaderResourceViews = Type: <b>ID3D10ShaderResourceView**</b> Array of shader resource view interfaces to be returned by the
    ///                            device.
    void    GSGetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    ///Get an array of sampler states from the geometry shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting samplers from.
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers to get from the device. Each pipeline stage has a total of 16 sampler
    ///                  slots available.
    ///    ppSamplers = Type: <b>ID3D10SamplerState**</b> Arry of sampler-state pointers (see ID3D10SamplerState) to be returned by
    ///                 the device.
    void    GSGetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    ///Get pointers to the render targets and the depth-stencil buffer that are available to the output-merger stage.
    ///Params:
    ///    NumViews = Type: <b>UINT</b> Number of render targets to retrieve.
    ///    ppRenderTargetViews = Type: <b>ID3D10RenderTargetView**</b> Pointer to an array of render targets views (see
    ///                          ID3D10RenderTargetView) to be filled with the render targets from the device. Specify <b>NULL</b> for this
    ///                          parameter when retrieval of a render target is not needed.
    ///    ppDepthStencilView = Type: <b>ID3D10DepthStencilView**</b> Pointer to a depth-stencil view (see ID3D10DepthStencilView) to be
    ///                         filled with the depth-stencil information from the device. Specify <b>NULL</b> for this parameter when
    ///                         retrieval of the depth-stencil view is not needed.
    void    OMGetRenderTargets(uint NumViews, char* ppRenderTargetViews, 
                               ID3D10DepthStencilView* ppDepthStencilView);
    ///Get the blend state of the output-merger stage.
    ///Params:
    ///    ppBlendState = Type: <b>ID3D10BlendState**</b> Address of a pointer to a blend-state interface (see ID3D10BlendState).
    ///    BlendFactor = Type: <b>FLOAT</b> Array of blend factors, one for each RGBA component.
    ///    pSampleMask = Type: <b>UINT*</b> Pointer to a sample mask.
    void    OMGetBlendState(ID3D10BlendState* ppBlendState, float* BlendFactor, uint* pSampleMask);
    ///Gets the depth-stencil state of the output-merger stage.
    ///Params:
    ///    ppDepthStencilState = Type: <b>ID3D10DepthStencilState**</b> Address of a pointer to a depth-stencil state interface (see
    ///                          ID3D10DepthStencilState) to be filled with information from the device.
    ///    pStencilRef = Type: <b>UINT*</b> Pointer to the stencil reference value used in the depth-stencil test.
    void    OMGetDepthStencilState(ID3D10DepthStencilState* ppDepthStencilState, uint* pStencilRef);
    ///Get the target output buffers for the StreamOutput stage of the pipeline.
    ///Params:
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to get. A maximum of four output buffers can be retrieved.
    ///    ppSOTargets = Type: <b>ID3D10Buffer**</b> An array of output buffers (see ID3D10Buffer) to be retrieved from the device.
    ///    pOffsets = Type: <b>UINT*</b> Array of offsets to the output buffers from <i>ppSOTargets</i>, one offset for each
    ///               buffer. The offset values are in bytes.
    void    SOGetTargets(uint NumBuffers, char* ppSOTargets, char* pOffsets);
    ///Get the rasterizer state from the rasterizer stage of the pipeline.
    ///Params:
    ///    ppRasterizerState = Type: <b>ID3D10RasterizerState**</b> Address of a pointer to a rasterizer-state interface (see
    ///                        ID3D10RasterizerState) to fill with information from the device.
    void    RSGetState(ID3D10RasterizerState* ppRasterizerState);
    ///Get the array of viewports bound to the rasterizer stage
    ///Params:
    ///    NumViewports = Type: <b>UINT*</b> Number of viewports in <i>pViewports</i>. If <i>pViewports</i> is <b>NULL</b>, this will
    ///                   be filled with the number of viewports currently bound.
    ///    pViewports = Type: <b>D3D10_VIEWPORT*</b> An array of viewports (see D3D10_VIEWPORT) to be filled with information from
    ///                 the device. If NumViewports is greater than the actual number of viewports currently bound, then unused
    ///                 members of the array will contain 0.
    void    RSGetViewports(uint* NumViewports, char* pViewports);
    ///Get the array of scissor rectangles bound to the rasterizer stage.
    ///Params:
    ///    NumRects = Type: <b>UINT*</b> Number of scissor rectangles to get. If pRects is <b>NULL</b>, this will be filled with
    ///               the number of scissor rectangles currently bound.
    ///    pRects = Type: <b>D3D10_RECT*</b> An array of scissor rectangles (see D3D10_RECT). If NumRects is greater than the
    ///             number of scissor rects currently bound, then unused members of the array will contain 0.
    void    RSGetScissorRects(uint* NumRects, char* pRects);
    ///Get the reason why the device was removed.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: <ul> <li>DXGI_ERROR_DEVICE_HUNG</li>
    ///    <li>DXGI_ERROR_DEVICE_REMOVED</li> <li>DXGI_ERROR_DEVICE_RESET</li> <li>DXGI_ERROR_DRIVER_INTERNAL_ERROR</li>
    ///    <li>DXGI_ERROR_INVALID_CALL</li> <li>S_OK</li> </ul> For more detail on these return codes, see DXGI_ERROR.
    ///    
    HRESULT GetDeviceRemovedReason();
    ///Get the exception-mode flags.
    ///Params:
    ///    RaiseFlags = Type: <b>UINT</b> A value that contains one or more exception flags; each flag specifies a condition which
    ///                 will cause an exception to be raised. The flags are listed in D3D10_RAISE_FLAG. A default value of 0 means
    ///                 there are no flags.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetExceptionMode(uint RaiseFlags);
    ///Get the exception-mode flags.
    ///Returns:
    ///    Type: <b>UINT</b> A value that contains one or more exception flags; each flag specifies a condition which
    ///    will cause an exception to be raised. The flags are listed in D3D10_RAISE_FLAG. A default value of 0 means
    ///    there are no flags.
    ///    
    uint    GetExceptionMode();
    ///Get data from a device that is associated with a guid.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the data.
    ///    pDataSize = Type: <b>UINT*</b> Size of the data.
    ///    pData = Type: <b>void*</b> Pointer to the data stored with the device. If pData is <b>NULL</b>, DataSize must also be
    ///            0, and any data previously associated with the guid will be destroyed.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetPrivateData(const(GUID)* guid, uint* pDataSize, char* pData);
    ///Set data to a device and associate that data with a guid.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the data.
    ///    DataSize = Type: <b>UINT</b> Size of the data.
    ///    pData = Type: <b>const void*</b> Pointer to the data to be stored with this device. If pData is <b>NULL</b>, DataSize
    ///            must also be 0, and any data previously associated with the guid will be destroyed.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetPrivateData(const(GUID)* guid, uint DataSize, char* pData);
    ///Associate an IUnknown-derived interface with this device and associate that interface with an application-defined
    ///guid.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the interface.
    ///    pData = Type: <b>const IUnknown*</b> Pointer to an IUnknown-derived interface to be associated with the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetPrivateDataInterface(const(GUID)* guid, const(IUnknown) pData);
    ///Restore all default device settings; return the device to the state it was in when it was created. This will set
    ///all set all input/output resource slots, shaders, input layouts, predications, scissor rectangles, depth-stencil
    ///state, rasterizer state, blend state, sampler state, and viewports to <b>NULL</b>. The primitive topology will be
    ///set to UNDEFINED.
    void    ClearState();
    ///Send queued-up commands in the command buffer to the GPU.
    void    Flush();
    ///Create a buffer (vertex buffer, index buffer, or shader-constant buffer).
    ///Params:
    ///    pDesc = Type: <b>const D3D10_BUFFER_DESC*</b> Pointer to a buffer description (see D3D10_BUFFER_DESC).
    ///    pInitialData = Type: <b>const D3D10_SUBRESOURCE_DATA*</b> Pointer to the initialization data (see D3D10_SUBRESOURCE_DATA);
    ///                   use <b>NULL</b> to allocate space only.
    ///    ppBuffer = Type: <b>ID3D10Buffer**</b> Address of a pointer to the buffer created (see ID3D10Buffer Interface). Set this
    ///               parameter to <b>NULL</b> to validate the other input parameters (S_FALSE indicates a pass).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateBuffer(const(D3D10_BUFFER_DESC)* pDesc, const(D3D10_SUBRESOURCE_DATA)* pInitialData, 
                         ID3D10Buffer* ppBuffer);
    ///Create an array of 1D textures (see Texture1D).
    ///Params:
    ///    pDesc = Type: <b>const D3D10_TEXTURE1D_DESC*</b> Pointer to a 1D texture description (see D3D10_TEXTURE1D_DESC). To
    ///            create a typeless resource that can be interpreted at runtime into different, compatible formats, specify a
    ///            typeless format in the texture description. To generate mipmap levels automatically, set the number of mipmap
    ///            levels to 0.
    ///    pInitialData = Type: <b>const D3D10_SUBRESOURCE_DATA*</b> Pointer to an array of subresource descriptions (see
    ///                   D3D10_SUBRESOURCE_DATA); one for each subresource (ordered by texture array index). Applications may not
    ///                   specify <b>NULL</b> for pInitialData when creating IMMUTABLE resources (see D3D10_USAGE). If the resource is
    ///                   multisampled, pInitialData must be <b>NULL</b> because multisampled resources cannot be initialized with data
    ///                   when they are created.
    ///    ppTexture1D = Type: <b>ID3D10Texture1D**</b> Address of a pointer to the created texture (see ID3D10Texture1D Interface).
    ///                  Set this parameter to <b>NULL</b> to validate the other input parameters (the method will return S_FALSE if
    ///                  the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return code is S_OK. See Direct3D 10 Return Codes for
    ///    failing error codes.
    ///    
    HRESULT CreateTexture1D(const(D3D10_TEXTURE1D_DESC)* pDesc, char* pInitialData, ID3D10Texture1D* ppTexture1D);
    ///Create an array of 2D textures (see Texture2D).
    ///Params:
    ///    pDesc = Type: <b>const D3D10_TEXTURE2D_DESC*</b> Pointer to a 2D texture description (see D3D10_TEXTURE2D_DESC). To
    ///            create a typeless resource that can be interpreted at runtime into different, compatible formats, specify a
    ///            typeless format in the texture description. To generate mipmap levels automatically, set the number of mipmap
    ///            levels to 0.
    ///    pInitialData = Type: <b>const D3D10_SUBRESOURCE_DATA*</b> Pointer to an array of subresource descriptions (see
    ///                   D3D10_SUBRESOURCE_DATA); one for each subresource (ordered by texture array index, then mip level).
    ///                   Applications may not specify <b>NULL</b> for pInitialData when creating IMMUTABLE resources (see
    ///                   D3D10_USAGE). If the resource is multisampled, pInitialData must be <b>NULL</b> because multisampled
    ///                   resources cannot be initialized with data when they are created.
    ///    ppTexture2D = Type: <b>ID3D10Texture2D**</b> Address of a pointer to the created texture (see ID3D10Texture2D Interface).
    ///                  Set this parameter to <b>NULL</b> to validate the other input parameters (the method will return S_FALSE if
    ///                  the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return code is S_OK. See Direct3D 10 Return Codes for
    ///    failing error codes.
    ///    
    HRESULT CreateTexture2D(const(D3D10_TEXTURE2D_DESC)* pDesc, char* pInitialData, ID3D10Texture2D* ppTexture2D);
    ///Create a single 3D texture (see Texture3D).
    ///Params:
    ///    pDesc = Type: <b>const D3D10_TEXTURE3D_DESC*</b> Pointer to a 3D texture description (see D3D10_TEXTURE3D_DESC). To
    ///            create a typeless resource that can be interpreted at runtime into different, compatible formats, specify a
    ///            typeless format in the texture description. To generate mipmap levels automatically, set the number of mipmap
    ///            levels to 0.
    ///    pInitialData = Type: <b>const D3D10_SUBRESOURCE_DATA*</b> Pointer to an array of subresource descriptions (see
    ///                   D3D10_SUBRESOURCE_DATA); one for each subresource (ordered by texture array index, then slice index, then mip
    ///                   level). Applications may not specify <b>NULL</b> for pInitialData when creating IMMUTABLE resources (see
    ///                   D3D10_USAGE). If the resource is multisampled, pInitialData must be <b>NULL</b> because multisampled
    ///                   resources cannot be initialized with data when they are created.
    ///    ppTexture3D = Type: <b>ID3D10Texture3D**</b> Address of a pointer to the created texture (see ID3D10Texture3D Interface).
    ///                  Set this parameter to <b>NULL</b> to validate the other input parameters (the method will return S_FALSE if
    ///                  the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return code is S_OK. See Direct3D 10 Return Codes for
    ///    failing error codes.
    ///    
    HRESULT CreateTexture3D(const(D3D10_TEXTURE3D_DESC)* pDesc, char* pInitialData, ID3D10Texture3D* ppTexture3D);
    ///Create a shader-resource view for accessing data in a resource.
    ///Params:
    ///    pResource = Type: <b>ID3D10Resource*</b> Pointer to the resource that will serve as input to a shader. This resource must
    ///                have been created with the D3D10_BIND_SHADER_RESOURCE flag.
    ///    pDesc = Type: <b>const D3D10_SHADER_RESOURCE_VIEW_DESC*</b> Pointer to a shader-resource-view description (see
    ///            D3D10_SHADER_RESOURCE_VIEW_DESC). Set this parameter to <b>NULL</b> to create a view that accesses the entire
    ///            resource (using the format the resource was created with).
    ///    ppSRView = Type: <b>ID3D10ShaderResourceView**</b> Address of a pointer to an ID3D10ShaderResourceView. Set this
    ///               parameter to <b>NULL</b> to validate the other input parameters (the method will return S_FALSE if the other
    ///               input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateShaderResourceView(ID3D10Resource pResource, const(D3D10_SHADER_RESOURCE_VIEW_DESC)* pDesc, 
                                     ID3D10ShaderResourceView* ppSRView);
    ///Create a render-target view for accessing resource data.
    ///Params:
    ///    pResource = Type: <b>ID3D10Resource*</b> Pointer to the resource that will serve as the render target. This resource must
    ///                have been created with the D3D10_BIND_RENDER_TARGET flag.
    ///    pDesc = Type: <b>const D3D10_RENDER_TARGET_VIEW_DESC*</b> Pointer to a render-target-view description (see
    ///            D3D10_RENDER_TARGET_VIEW_DESC). Set this parameter to <b>NULL</b> to create a view that accesses mipmap level
    ///            0 of the entire resource (using the format the resource was created with).
    ///    ppRTView = Type: <b>ID3D10RenderTargetView**</b> Address of a pointer to an ID3D10RenderTargetView. Set this parameter
    ///               to <b>NULL</b> to validate the other input parameters (the method will return S_FALSE if the other input
    ///               parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateRenderTargetView(ID3D10Resource pResource, const(D3D10_RENDER_TARGET_VIEW_DESC)* pDesc, 
                                   ID3D10RenderTargetView* ppRTView);
    ///Create a depth-stencil view for accessing resource data.
    ///Params:
    ///    pResource = Type: <b>ID3D10Resource*</b> Pointer to the resource that will serve as the depth-stencil surface. This
    ///                resource must have been created with the D3D10_BIND_DEPTH_STENCIL flag.
    ///    pDesc = Type: <b>const D3D10_DEPTH_STENCIL_VIEW_DESC*</b> Pointer to a depth-stencil-view description (see
    ///            D3D10_DEPTH_STENCIL_VIEW_DESC). Set this parameter to <b>NULL</b> to create a view that accesses mipmap level
    ///            0 of the entire resource (using the format the resource was created with).
    ///    ppDepthStencilView = Type: <b>ID3D10DepthStencilView**</b> Address of a pointer to an ID3D10DepthStencilView. Set this parameter
    ///                         to <b>NULL</b> to validate the other input parameters (the method will return S_FALSE if the other input
    ///                         parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateDepthStencilView(ID3D10Resource pResource, const(D3D10_DEPTH_STENCIL_VIEW_DESC)* pDesc, 
                                   ID3D10DepthStencilView* ppDepthStencilView);
    ///Create an input-layout object to describe the input-buffer data for the input-assembler stage.
    ///Params:
    ///    pInputElementDescs = Type: <b>const D3D10_INPUT_ELEMENT_DESC*</b> An array of the input-assembler stage input data types; each
    ///                         type is described by an element description (see D3D10_INPUT_ELEMENT_DESC).
    ///    NumElements = Type: <b>UINT</b> The number of input-data types in the array of input-elements.
    ///    pShaderBytecodeWithInputSignature = Type: <b>const void*</b> A pointer to the compiled shader. To get this pointer see Getting a Pointer to a
    ///                                        Compiled Shader. The compiled shader code contains a input signature which is validated against the array of
    ///                                        elements. See remarks.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled shader.
    ///    ppInputLayout = Type: <b>ID3D10InputLayout**</b> A pointer to the input-layout object created (see ID3D10InputLayout
    ///                    Interface). To validate the other input parameters, set this pointer to be <b>NULL</b> and verify that the
    ///                    method returns S_FALSE.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return code is S_OK. See Direct3D 10 Return Codes for
    ///    failing error codes.
    ///    
    HRESULT CreateInputLayout(char* pInputElementDescs, uint NumElements, char* pShaderBytecodeWithInputSignature, 
                              size_t BytecodeLength, ID3D10InputLayout* ppInputLayout);
    ///Create a vertex-shader object from a compiled shader.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader. To get this pointer see Getting a Pointer to a
    ///                      Compiled Shader.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled vertex shader.
    ///    ppVertexShader = Type: <b>ID3D10VertexShader**</b> Address of a pointer to an ID3D10VertexShader Interface. If this is
    ///                     <b>NULL</b>, all other parameters will be validated, and if all parameters pass validation this API will
    ///                     return S_FALSE instead of S_OK.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateVertexShader(char* pShaderBytecode, size_t BytecodeLength, ID3D10VertexShader* ppVertexShader);
    ///Create a geometry shader.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader. To get this pointer see Getting a Pointer to a
    ///                      Compiled Shader.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled geometry shader.
    ///    ppGeometryShader = Type: <b>ID3D10GeometryShader**</b> Address of a pointer to an ID3D10GeometryShader Interface. If this is
    ///                       <b>NULL</b>, all other parameters will be validated, and if all parameters pass validation this API will
    ///                       return S_FALSE instead of S_OK.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateGeometryShader(char* pShaderBytecode, size_t BytecodeLength, 
                                 ID3D10GeometryShader* ppGeometryShader);
    ///Creates a geometry shader that can write to streaming output buffers.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled geometry shader for a standard geometry shader plus stream
    ///                      output. For info on how to get this pointer, see Getting a Pointer to a Compiled Shader. To create the stream
    ///                      output without using a geometry shader, pass a pointer to the output signature for the prior stage. To obtain
    ///                      this output signature, call the D3DGetOutputSignatureBlob compiler function. You can also pass a pointer to
    ///                      the compiled vertex shader that is used in the prior stage. This compiled shader provides the output
    ///                      signature for the data.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled geometry shader.
    ///    pSODeclaration = Type: <b>const D3D10_SO_DECLARATION_ENTRY*</b> Pointer to a D3D10_SO_DECLARATION_ENTRY array. Cannot be
    ///                     <b>NULL</b> if <i>NumEntries</i>&gt; 0.
    ///    NumEntries = Type: <b>UINT</b> The number of entries in the array pointed to by <i>pSODeclaration</i>. Minimum 0, maximum
    ///                 64.
    ///    OutputStreamStride = Type: <b>UINT</b> The size, in bytes, of each element in the array pointed to by <i>pSODeclaration</i>. This
    ///                         parameter is only used when the output slot is 0 for all entries in <i>pSODeclaration</i>.
    ///    ppGeometryShader = Type: <b>ID3D10GeometryShader**</b> Address of a pointer to an ID3D10GeometryShader Interface. If this is
    ///                       <b>NULL</b>, all other parameters will be validated, and if all parameters pass validation this API will
    ///                       return S_FALSE instead of S_OK.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 10 Return Codes.
    ///    
    HRESULT CreateGeometryShaderWithStreamOutput(char* pShaderBytecode, size_t BytecodeLength, 
                                                 char* pSODeclaration, uint NumEntries, uint OutputStreamStride, 
                                                 ID3D10GeometryShader* ppGeometryShader);
    ///Create a pixel shader.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader. To get this pointer see Getting a Pointer to a
    ///                      Compiled Shader.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled pixel shader.
    ///    ppPixelShader = Type: <b>ID3D10PixelShader**</b> Address of a pointer to an ID3D10PixelShader Interface. If this is
    ///                    <b>NULL</b>, all other parameters will be validated, and if all parameters pass validation this API will
    ///                    return S_FALSE instead of S_OK.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreatePixelShader(char* pShaderBytecode, size_t BytecodeLength, ID3D10PixelShader* ppPixelShader);
    ///Create a blend-state object that encapsules blend state for the output-merger stage.
    ///Params:
    ///    pBlendStateDesc = Type: <b>const D3D10_BLEND_DESC*</b> Pointer to a blend-state description (see D3D10_BLEND_DESC).
    ///    ppBlendState = Type: <b>ID3D10BlendState**</b> Address of a pointer to the blend-state object created (see ID3D10BlendState
    ///                   Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateBlendState(const(D3D10_BLEND_DESC)* pBlendStateDesc, ID3D10BlendState* ppBlendState);
    ///Create a depth-stencil state object that encapsulates depth-stencil test information for the output-merger stage.
    ///Params:
    ///    pDepthStencilDesc = Type: <b>const D3D10_DEPTH_STENCIL_DESC*</b> Pointer to a depth-stencil state description (see
    ///                        D3D10_DEPTH_STENCIL_DESC).
    ///    ppDepthStencilState = Type: <b>ID3D10DepthStencilState**</b> Address of a pointer to the depth-stencil state object created (see
    ///                          ID3D10DepthStencilState Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateDepthStencilState(const(D3D10_DEPTH_STENCIL_DESC)* pDepthStencilDesc, 
                                    ID3D10DepthStencilState* ppDepthStencilState);
    ///Create a rasterizer state object that tells the rasterizer stage how to behave.
    ///Params:
    ///    pRasterizerDesc = Type: <b>const D3D10_RASTERIZER_DESC*</b> Pointer to a rasterizer state description (see
    ///                      D3D10_RASTERIZER_DESC).
    ///    ppRasterizerState = Type: <b>ID3D10RasterizerState**</b> Address of a pointer to the rasterizer state object created (see
    ///                        ID3D10RasterizerState Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateRasterizerState(const(D3D10_RASTERIZER_DESC)* pRasterizerDesc, 
                                  ID3D10RasterizerState* ppRasterizerState);
    ///Create a sampler-state object that encapsulates sampling information for a texture.
    ///Params:
    ///    pSamplerDesc = Type: <b>const D3D10_SAMPLER_DESC*</b> Pointer to a sampler state description (see D3D10_SAMPLER_DESC).
    ///    ppSamplerState = Type: <b>ID3D10SamplerState**</b> Address of a pointer to the sampler state object created (see
    ///                     ID3D10SamplerState Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateSamplerState(const(D3D10_SAMPLER_DESC)* pSamplerDesc, ID3D10SamplerState* ppSamplerState);
    ///This interface encapsulates methods for querying information from the GPU.
    ///Params:
    ///    pQueryDesc = Type: <b>const D3D10_QUERY_DESC*</b> Pointer to a query description (see D3D10_QUERY_DESC).
    ///    ppQuery = Type: <b>ID3D10Query**</b> Address of a pointer to the query object created (see ID3D10Query Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateQuery(const(D3D10_QUERY_DESC)* pQueryDesc, ID3D10Query* ppQuery);
    ///Creates a predicate.
    ///Params:
    ///    pPredicateDesc = Type: <b>const D3D10_QUERY_DESC*</b> Pointer to a query description where the type of query must be a
    ///                     D3D10_QUERY_SO_OVERFLOW_PREDICATE or D3D10_QUERY_OCCLUSION_PREDICATE (see D3D10_QUERY_DESC).
    ///    ppPredicate = Type: <b>ID3D10Predicate**</b> Address of a pointer to a predicate (see ID3D10Predicate Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreatePredicate(const(D3D10_QUERY_DESC)* pPredicateDesc, ID3D10Predicate* ppPredicate);
    ///Create a counter object for measuring GPU performance.
    ///Params:
    ///    pCounterDesc = Type: <b>const D3D10_COUNTER_DESC*</b> Pointer to a counter description (see D3D10_COUNTER_DESC).
    ///    ppCounter = Type: <b>ID3D10Counter**</b> Address of a pointer to a counter (see ID3D10Counter Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this function succeeds, it will return S_OK. If it fails, possible return values are:
    ///    S_FALSE, E_OUTOFMEMORY, DXGI_ERROR_UNSUPPORTED, DXGI_ERROR_NONEXCLUSIVE, or E_INVALIDARG.
    ///    DXGI_ERROR_UNSUPPORTED is returned whenever the application requests to create a well-known counter, but the
    ///    current device does not support it. DXGI_ERROR_NONEXCLUSIVE indicates that another device object is currently
    ///    using the counters, so they cannot be used by this device at the moment. E_INVALIDARG is returned whenever an
    ///    out-of-range well-known or device-dependent counter is requested, or when the simulataneously active counters
    ///    have been exhausted.
    ///    
    HRESULT CreateCounter(const(D3D10_COUNTER_DESC)* pCounterDesc, ID3D10Counter* ppCounter);
    ///Get the support of a given format on the installed video device.
    ///Params:
    ///    Format = Type: <b>DXGI_FORMAT</b> A DXGI_FORMAT enumeration that describes a format for which to check for support.
    ///    pFormatSupport = Type: <b>UINT*</b> A bitfield of D3D10_FORMAT_SUPPORT enumeration values describing how the specified format
    ///                     is supported on the installed device. The values are ORed together.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns E_INVALIDARG if the <i>Format</i>
    ///    parameter is <b>NULL</b>, or returns E_FAIL if the described format does not exist.
    ///    
    HRESULT CheckFormatSupport(DXGI_FORMAT Format, uint* pFormatSupport);
    ///Get the number of quality levels available during multisampling.
    ///Params:
    ///    Format = Type: <b>DXGI_FORMAT</b> The texture format. See DXGI_FORMAT.
    ///    SampleCount = Type: <b>UINT</b> The number of samples during multisampling.
    ///    pNumQualityLevels = Type: <b>UINT*</b> Number of quality levels supported by the adapter. See remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CheckMultisampleQualityLevels(DXGI_FORMAT Format, uint SampleCount, uint* pNumQualityLevels);
    ///Get a counter's information.
    ///Params:
    ///    pCounterInfo = Type: <b>D3D10_COUNTER_INFO*</b> Pointer to counter information (see D3D10_COUNTER_INFO).
    void    CheckCounterInfo(D3D10_COUNTER_INFO* pCounterInfo);
    ///Get the type, name, units of measure, and a description of an existing counter.
    ///Params:
    ///    pDesc = Type: <b>const D3D10_COUNTER_DESC*</b> Pointer to a counter description (see D3D10_COUNTER_DESC). Specifies
    ///            which counter information is to be retrieved about.
    ///    pType = Type: <b>D3D10_COUNTER_TYPE*</b> Pointer to the data type of a counter (see D3D10_COUNTER_TYPE). Specifies
    ///            the data type of the counter being retrieved.
    ///    pActiveCounters = Type: <b>UINT*</b> Pointer to the number of hardware counters that are needed for this counter type to be
    ///                      created. All instances of the same counter type use the same hardware counters.
    ///    szName = Type: <b>LPSTR</b> String to be filled with a brief name for the counter. May be <b>NULL</b> if the
    ///             application is not interested in the name of the counter.
    ///    pNameLength = Type: <b>UINT*</b> Length of the string returned to szName. Can be <b>NULL</b>.
    ///    szUnits = Type: <b>LPSTR</b> Name of the units a counter measures, provided the memory the pointer points to has enough
    ///              room to hold the string. Can be <b>NULL</b>. The returned string will always be in English.
    ///    pUnitsLength = Type: <b>UINT*</b> Length of the string returned to szUnits. Can be <b>NULL</b>.
    ///    szDescription = Type: <b>LPSTR</b> A description of the counter, provided the memory the pointer points to has enough room to
    ///                    hold the string. Can be <b>NULL</b>. The returned string will always be in English.
    ///    pDescriptionLength = Type: <b>UINT*</b> Length of the string returned to szDescription. Can be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CheckCounter(const(D3D10_COUNTER_DESC)* pDesc, D3D10_COUNTER_TYPE* pType, uint* pActiveCounters, 
                         const(char)* szName, uint* pNameLength, const(char)* szUnits, uint* pUnitsLength, 
                         const(char)* szDescription, uint* pDescriptionLength);
    ///Get the flags used during the call to create the device with D3D10CreateDevice.
    ///Returns:
    ///    Type: <b>UINT</b> A bitfield containing the flags used to create the device. See D3D10_CREATE_DEVICE_FLAG.
    ///    
    uint    GetCreationFlags();
    ///Give a device access to a shared resource created on a different Direct3d device.
    ///Params:
    ///    hResource = Type: <b>HANDLE</b> A resource handle. See remarks.
    ///    ReturnedInterface = Type: <b>REFIID</b> The globally unique identifier (GUID) for the resource interface. See remarks.
    ///    ppResource = Type: <b>void**</b> Address of a pointer to the resource we are gaining access to.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT OpenSharedResource(HANDLE hResource, const(GUID)* ReturnedInterface, void** ppResource);
    ///This method is not implemented.
    ///Params:
    ///    Width = Type: <b>UINT</b> Not applicable
    ///    Height = Type: <b>UINT</b> Not applicable
    void    SetTextFilterSize(uint Width, uint Height);
    ///This method is not implemented.
    ///Params:
    ///    pWidth = Type: <b>UINT*</b> Not applicable
    ///    pHeight = Type: <b>UINT*</b> Not applicable
    void    GetTextFilterSize(uint* pWidth, uint* pHeight);
}

///A multithread interface accesses multithread settings and can only be used if the thread-safe layer is turned on.
@GUID("9B7E4E00-342C-4106-A19F-4F2704F689F0")
interface ID3D10Multithread : IUnknown
{
    ///Enter a device's critical section.
    void Enter();
    ///Leave a device's critical section.
    void Leave();
    ///Turn multithreading on or off.
    ///Params:
    ///    bMTProtect = Type: <b>BOOL</b> True to turn multithreading on, false to turn it off.
    ///Returns:
    ///    Type: <b>BOOL</b> True if multithreading was turned on prior to calling this method, false otherwise.
    ///    
    BOOL SetMultithreadProtected(BOOL bMTProtect);
    ///Find out if multithreading is turned on or not.
    ///Returns:
    ///    Type: <b>BOOL</b> Whether or not multithreading is turned on. True means on, false means off.
    ///    
    BOOL GetMultithreadProtected();
}

///A debug interface controls debug settings, validates pipeline state and can only be used if the debug layer is turned
///on.
@GUID("9B7E4E01-342C-4106-A19F-4F2704F689F0")
interface ID3D10Debug : IUnknown
{
    ///Set a bitfield of flags that will turn debug features on and off.
    ///Params:
    ///    Mask = Type: <b>UINT</b> Feature-mask flags bitwise ORed together. If a flag is present, then that feature will be
    ///           set to on, otherwise the feature will be set to off. See remarks for a list of flags.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetFeatureMask(uint Mask);
    ///Get a bitfield of flags that indicates which debug features are on or off.
    ///Returns:
    ///    Type: <b>UINT</b> Mask of feature-mask flags bitwise ORed together. If a flag is present, then that feature
    ///    will be set to on, otherwise the feature will be set to off. See ID3D10Debug::SetFeatureMask for a list of
    ///    possible feature-mask flags.
    ///    
    uint    GetFeatureMask();
    ///Set the number of milliseconds to sleep after Present is called.
    ///Params:
    ///    Milliseconds = Type: <b>UINT</b> Number of milliseconds to sleep after Present is called.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetPresentPerRenderOpDelay(uint Milliseconds);
    ///Get the number of milliseconds to sleep after Present is called.
    ///Returns:
    ///    Type: <b>UINT</b> Number of milliseconds to sleep after Present is called.
    ///    
    uint    GetPresentPerRenderOpDelay();
    ///Set a swap chain that the runtime will use for automatically calling Present.
    ///Params:
    ///    pSwapChain = Type: <b>IDXGISwapChain*</b> Swap chain that the runtime will use for automatically calling Present; must
    ///                 have been created with the DXGI_SWAP_EFFECT_SEQUENTIAL swap-effect flag.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetSwapChain(IDXGISwapChain pSwapChain);
    ///Get the swap chain that the runtime will use for automatically calling Present.
    ///Params:
    ///    ppSwapChain = Type: <b>IDXGISwapChain**</b> Swap chain that the runtime will use for automatically calling Present.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetSwapChain(IDXGISwapChain* ppSwapChain);
    ///Check the validity of pipeline state.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT Validate();
}

///A switch-to-reference interface (see the switch-to-reference layer) enables an application to switch between a
///hardware and software device.
@GUID("9B7E4E02-342C-4106-A19F-4F2704F689F0")
interface ID3D10SwitchToRef : IUnknown
{
    ///Switch between a hardware and a software device.
    ///Params:
    ///    UseRef = Type: <b>BOOL</b> A boolean value. Set this to <b>TRUE</b> to change to a software device, set this to
    ///             <b>FALSE</b> to change to a hardware device.
    ///Returns:
    ///    Type: <b>BOOL</b> The previous value of <i>UseRef</i>.
    ///    
    BOOL SetUseRef(BOOL UseRef);
    ///Get a boolean value that indicates the type of device being used.
    ///Returns:
    ///    Type: <b>BOOL</b> <b>TRUE</b> if the device is a software device, <b>FALSE</b> if the device is a hardware
    ///    device. See remarks.
    ///    
    BOOL GetUseRef();
}

///An information-queue interface stores, retrieves, and filters debug messages. The queue consists of a message queue,
///an optional storage filter stack, and a optional retrieval filter stack.
@GUID("1B940B17-2642-4D1F-AB1F-B99BAD0C395F")
interface ID3D10InfoQueue : IUnknown
{
    ///Set the maximum number of messages that can be added to the message queue.
    ///Params:
    ///    MessageCountLimit = Type: <b>UINT64</b> Maximum number of messages that can be added to the message queue. -1 means no limit.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetMessageCountLimit(ulong MessageCountLimit);
    ///Clear all messages from the message queue.
    void    ClearStoredMessages();
    HRESULT GetMessageA(ulong MessageIndex, char* pMessage, size_t* pMessageByteLength);
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
    ///    Type: <b>UINT64</b> Maximum number of messages that can be added to the queue. -1 means no limit.
    ///    
    ulong   GetMessageCountLimit();
    ///Add storage filters to the top of the storage-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D10_INFO_QUEUE_FILTER*</b> Array of storage filters (see D3D10_INFO_QUEUE_FILTER).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT AddStorageFilterEntries(D3D10_INFO_QUEUE_FILTER* pFilter);
    ///Get the storage filter at the top of the storage-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D10_INFO_QUEUE_FILTER*</b> Storage filter at the top of the storage-filter stack.
    ///    pFilterByteLength = Type: <b>SIZE_T*</b> Size of the storage filter in bytes. If pFilter is <b>NULL</b>, the size of the storage
    ///                        filter will be output to this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetStorageFilter(char* pFilter, size_t* pFilterByteLength);
    ///Remove a storage filter from the top of the storage-filter stack.
    void    ClearStorageFilter();
    ///Push an empty storage filter onto the storage-filter stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT PushEmptyStorageFilter();
    ///Push a copy of storage filter currently on the top of the storage-filter stack onto the storage-filter stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT PushCopyOfStorageFilter();
    ///Push a storage filter onto the storage-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D10_INFO_QUEUE_FILTER*</b> Pointer to a storage filter (see D3D10_INFO_QUEUE_FILTER).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT PushStorageFilter(D3D10_INFO_QUEUE_FILTER* pFilter);
    ///Pop a storage filter from the top of the storage-filter stack.
    void    PopStorageFilter();
    ///Get the size of the storage-filter stack in bytes.
    ///Returns:
    ///    Type: <b>UINT</b> Size of the storage-filter stack in bytes.
    ///    
    uint    GetStorageFilterStackSize();
    ///Add storage filters to the top of the retrieval-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D10_INFO_QUEUE_FILTER*</b> Array of retrieval filters (see D3D10_INFO_QUEUE_FILTER).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT AddRetrievalFilterEntries(D3D10_INFO_QUEUE_FILTER* pFilter);
    ///Get the retrieval filter at the top of the retrieval-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D10_INFO_QUEUE_FILTER*</b> Retrieval filter at the top of the retrieval-filter stack.
    ///    pFilterByteLength = Type: <b>SIZE_T*</b> Size of the retrieval filter in bytes. If pFilter is <b>NULL</b>, the size of the
    ///                        retrieval filter will be output to this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetRetrievalFilter(char* pFilter, size_t* pFilterByteLength);
    ///Remove a retrieval filter from the top of the retrieval-filter stack.
    void    ClearRetrievalFilter();
    ///Push an empty retrieval filter onto the retrieval-filter stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT PushEmptyRetrievalFilter();
    ///Push a copy of retrieval filter currently on the top of the retrieval-filter stack onto the retrieval-filter
    ///stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT PushCopyOfRetrievalFilter();
    ///Push a retrieval filter onto the retrieval-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D10_INFO_QUEUE_FILTER*</b> Pointer to a retrieval filter (see D3D10_INFO_QUEUE_FILTER).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT PushRetrievalFilter(D3D10_INFO_QUEUE_FILTER* pFilter);
    ///Pop a retrieval filter from the top of the retrieval-filter stack.
    void    PopRetrievalFilter();
    ///Get the size of the retrieval-filter stack in bytes.
    ///Returns:
    ///    Type: <b>UINT</b> Size of the retrieval-filter stack in bytes.
    ///    
    uint    GetRetrievalFilterStackSize();
    ///Add a Direct3D 10 debug message to the message queue and send that message to debug output.
    ///Params:
    ///    Category = Type: <b>D3D10_MESSAGE_CATEGORY</b> Category of a message (see D3D10_MESSAGE_CATEGORY).
    ///    Severity = Type: <b>D3D10_MESSAGE_SEVERITY</b> Severity of a message (see D3D10_MESSAGE_SEVERITY).
    ///    ID = Type: <b>D3D10_MESSAGE_ID</b> Unique identifier of a message (see D3D10_MESSAGE_ID).
    ///    pDescription = Type: <b>LPCSTR</b> User-defined message.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT AddMessage(D3D10_MESSAGE_CATEGORY Category, D3D10_MESSAGE_SEVERITY Severity, D3D10_MESSAGE_ID ID, 
                       const(char)* pDescription);
    ///Add a user-defined message to the message queue and send that message to debug output.
    ///Params:
    ///    Severity = Type: <b>D3D10_MESSAGE_SEVERITY</b> Severity of a message (see D3D10_MESSAGE_SEVERITY).
    ///    pDescription = Type: <b>LPCSTR</b> Message string.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT AddApplicationMessage(D3D10_MESSAGE_SEVERITY Severity, const(char)* pDescription);
    ///Set a message category to break on when a message with that category passes through the storage filter.
    ///Params:
    ///    Category = Type: <b>D3D10_MESSAGE_CATEGORY</b> Message category to break on (see D3D10_MESSAGE_CATEGORY).
    ///    bEnable = Type: <b>BOOL</b> Turns this breaking condition on or off (true for on, false for off).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetBreakOnCategory(D3D10_MESSAGE_CATEGORY Category, BOOL bEnable);
    ///Set a message severity level to break on when a message with that severity level passes through the storage
    ///filter.
    ///Params:
    ///    Severity = Type: <b>D3D10_MESSAGE_SEVERITY</b> Message severity level to break on (see D3D10_MESSAGE_SEVERITY).
    ///    bEnable = Type: <b>BOOL</b> Turns this breaking condition on or off (true for on, false for off).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetBreakOnSeverity(D3D10_MESSAGE_SEVERITY Severity, BOOL bEnable);
    ///Set a message identifier to break on when a message with that identifier passes through the storage filter.
    ///Params:
    ///    ID = Type: <b>D3D10_MESSAGE_ID</b> Message identifier to break on (see D3D10_MESSAGE_ID).
    ///    bEnable = Type: <b>BOOL</b> Turns this breaking condition on or off (true for on, false for off).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetBreakOnID(D3D10_MESSAGE_ID ID, BOOL bEnable);
    ///Get a message category to break on when a message with that category passes through the storage filter.
    ///Params:
    ///    Category = Type: <b>D3D10_MESSAGE_CATEGORY</b> Message category to break on (see D3D10_MESSAGE_CATEGORY).
    ///Returns:
    ///    Type: <b>BOOL</b> Whether this breaking condition is turned on or off (true for on, false for off).
    ///    
    BOOL    GetBreakOnCategory(D3D10_MESSAGE_CATEGORY Category);
    ///Get a message severity level to break on when a message with that severity level passes through the storage
    ///filter.
    ///Params:
    ///    Severity = Type: <b>D3D10_MESSAGE_SEVERITY</b> Message severity level to break on (see D3D10_MESSAGE_SEVERITY).
    ///Returns:
    ///    Type: <b>BOOL</b> Whether this breaking condition is turned on or off (true for on, false for off).
    ///    
    BOOL    GetBreakOnSeverity(D3D10_MESSAGE_SEVERITY Severity);
    ///Get a message identifier to break on when a message with that identifier passes through the storage filter.
    ///Params:
    ///    ID = Type: <b>D3D10_MESSAGE_ID</b> Message identifier to break on (see D3D10_MESSAGE_ID).
    ///Returns:
    ///    Type: <b>BOOL</b> Whether this breaking condition is turned on or off (true for on, false for off).
    ///    
    BOOL    GetBreakOnID(D3D10_MESSAGE_ID ID);
    ///Set a boolean that turns the debug output on or off.
    ///Params:
    ///    bMute = Type: <b>BOOL</b> Disable/Enable the debug output (<b>TRUE</b> to disable or mute the output, <b>FALSE</b> to
    ///            enable the output).
    void    SetMuteDebugOutput(BOOL bMute);
    ///Get a boolean that turns the debug output on or off.
    ///Returns:
    ///    Type: <b>BOOL</b> Whether the debug output is on or off (true for on, false for off).
    ///    
    BOOL    GetMuteDebugOutput();
}

///This shader-reflection interface provides access to variable type.
@GUID("C530AD7D-9B16-4395-A979-BA2ECFF83ADD")
interface ID3D10ShaderReflectionType
{
    ///Get the description of a shader-reflection-variable type.
    ///Params:
    ///    pDesc = Type: <b>D3D10_SHADER_TYPE_DESC*</b> A pointer to a shader-type description (see D3D10_SHADER_TYPE_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDesc(D3D10_SHADER_TYPE_DESC* pDesc);
    ///Get a shader-reflection-variable type by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10ShaderReflectionType*</b> A pointer to a ID3D10ShaderReflectionType Interface.
    ///    
    ID3D10ShaderReflectionType GetMemberTypeByIndex(uint Index);
    ///Get a shader-reflection-variable type by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> Member name.
    ///Returns:
    ///    Type: <b>ID3D10ShaderReflectionType*</b> A pointer to a ID3D10ShaderReflectionType Interface.
    ///    
    ID3D10ShaderReflectionType GetMemberTypeByName(const(char)* Name);
    ///Retrieves a shader-reflection-variable name given the index to that member of the struct type.
    ///Params:
    ///    Index = Type: **[UINT](/windows/desktop/winprog/windows-data-types)** A zero-based index to a member of the struct
    ///            type.
    ///Returns:
    ///    Type: **[LPCSTR](/windows/desktop/winprog/windows-data-types)** The member name in the form of a stringified
    ///    value of the [D3D_SHADER_VARIABLE_TYPE](../d3dcommon/ne-d3dcommon-d3d_shader_variable_type.md) enumeration.
    ///    
    byte*   GetMemberTypeName(uint Index);
}

///This shader-reflection interface provides access to a variable.
@GUID("1BF63C95-2650-405D-99C1-3636BD1DA0A1")
interface ID3D10ShaderReflectionVariable
{
    ///Get a shader-variable description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_SHADER_VARIABLE_DESC*</b> A pointer to a shader-variable description (see
    ///            D3D10_SHADER_VARIABLE_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDesc(D3D10_SHADER_VARIABLE_DESC* pDesc);
    ///Get a shader-variable type.
    ///Returns:
    ///    Type: <b>ID3D10ShaderReflectionType*</b> A pointer to a ID3D10ShaderReflectionType Interface.
    ///    
    ID3D10ShaderReflectionType GetType();
}

///This shader-reflection interface provides access to a constant buffer.
@GUID("66C66A94-DDDD-4B62-A66A-F0DA33C2B4D0")
interface ID3D10ShaderReflectionConstantBuffer
{
    ///Get a constant-buffer description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_SHADER_BUFFER_DESC*</b> A pointer to a shader-buffer description (see
    ///            D3D10_SHADER_BUFFER_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDesc(D3D10_SHADER_BUFFER_DESC* pDesc);
    ///Get a shader-reflection variable by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10ShaderReflectionVariable*</b> A pointer to a shader-reflection variable interface (see
    ///    ID3D10ShaderReflectionVariable Interface).
    ///    
    ID3D10ShaderReflectionVariable GetVariableByIndex(uint Index);
    ///Get a shader-reflection variable by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> Variable name.
    ///Returns:
    ///    Type: <b>ID3D10ShaderReflectionVariable*</b> A pointer to a shader-reflection variable interface (see
    ///    ID3D10ShaderReflectionVariable Interface).
    ///    
    ID3D10ShaderReflectionVariable GetVariableByName(const(char)* Name);
}

///A shader-reflection interface accesses shader information.
@GUID("D40E20B6-F8F7-42AD-AB20-4BAF8F15DFAA")
interface ID3D10ShaderReflection : IUnknown
{
    ///Get a shader description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_SHADER_DESC*</b> A pointer to a shader description. See D3D10_SHADER_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDesc(D3D10_SHADER_DESC* pDesc);
    ///Get a constant buffer by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10ShaderReflectionConstantBuffer*</b> A pointer to a constant buffer (see
    ///    ID3D10ShaderReflectionConstantBuffer Interface).
    ///    
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint Index);
    ///Get a constant buffer by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The constant-buffer name.
    ///Returns:
    ///    Type: <b>ID3D10ShaderReflectionConstantBuffer*</b> A pointer to a constant buffer (see
    ///    ID3D10ShaderReflectionConstantBuffer Interface).
    ///    
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByName(const(char)* Name);
    ///Get a description of the resources bound to a shader.
    ///Params:
    ///    ResourceIndex = Type: <b>UINT</b> A zero-based resource index.
    ///    pDesc = Type: <b>D3D10_SHADER_INPUT_BIND_DESC*</b> A pointer to an input-binding description. See
    ///            D3D10_SHADER_INPUT_BIND_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D10_SHADER_INPUT_BIND_DESC* pDesc);
    ///Get an input-parameter description for a shader.
    ///Params:
    ///    ParameterIndex = Type: <b>UINT</b> A zero-based parameter index.
    ///    pDesc = Type: <b>D3D10_SIGNATURE_PARAMETER_DESC*</b> A pointer to a shader-input-signature description. See
    ///            D3D10_SIGNATURE_PARAMETER_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetInputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    ///Get an output-parameter description for a shader.
    ///Params:
    ///    ParameterIndex = Type: <b>UINT</b> A zero-based parameter index.
    ///    pDesc = Type: <b>D3D10_SIGNATURE_PARAMETER_DESC*</b> A pointer to a shader-output-parameter description. See
    ///            D3D10_SIGNATURE_PARAMETER_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetOutputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
}

///A state-block interface encapsulates render states.
interface ID3D10StateBlock : IUnknown
{
    ///Capture the current value of states that are included in a stateblock.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT Capture();
    ///Apply the state block to the current device state.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT Apply();
    ///Release all references to device objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT ReleaseAllDeviceObjects();
    ///Get the device.
    ///Params:
    ///    ppDevice = Type: <b>ID3D10Device**</b> Pointer to the ID3D10Device interface that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDevice(ID3D10Device* ppDevice);
}

///The <b>ID3D10EffectType</b> interface accesses effect variables by type. The lifetime of an <b>ID3D10EffectType</b>
///object is equal to the lifetime of its parent ID3D10Effect object. <ul> <li>Methods</li> </ul><h3><a
///id="methods"></a>Methods</h3>The <b>ID3D10EffectType</b> interface has these methods. <table class="members"
///id="memberListMethods"> <tr> <th align="left" width="37%">Method</th> <th align="left" width="63%">Description</th>
///</tr> <tr data="declared;"> <td align="left" width="37%"> GetDesc </td> <td align="left" width="63%"> Get an
///effect-type description. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetMemberName </td> <td
///align="left" width="63%"> Get the name of a member. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///GetMemberSemantic </td> <td align="left" width="63%"> Get the semantic attached to a member. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> GetMemberTypeByIndex </td> <td align="left" width="63%"> Get a member
///type by index. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetMemberTypeByName </td> <td
///align="left" width="63%"> Get an member type by name. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///GetMemberTypeBySemantic </td> <td align="left" width="63%"> Get a member type by semantic. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> IsValid </td> <td align="left" width="63%"> Tests that the effect
///type is valid. </td> </tr> </table>
interface ID3D10EffectType
{
    ///Tests that the effect type is valid.
    ///Returns:
    ///    Type: <b>BOOL</b> <b>TRUE</b> if it is valid; otherwise <b>FALSE</b>.
    ///    
    BOOL    IsValid();
    ///Get an effect-type description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_EFFECT_TYPE_DESC*</b> A pointer to an effect-type description. See D3D10_EFFECT_TYPE_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDesc(D3D10_EFFECT_TYPE_DESC* pDesc);
    ///Get a member type by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10EffectType*</b> A pointer to an ID3D10EffectType Interface.
    ///    
    ID3D10EffectType GetMemberTypeByIndex(uint Index);
    ///Get an member type by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> A member's name.
    ///Returns:
    ///    Type: <b>ID3D10EffectType*</b> A pointer to an ID3D10EffectType Interface.
    ///    
    ID3D10EffectType GetMemberTypeByName(const(char)* Name);
    ///Get a member type by semantic.
    ///Params:
    ///    Semantic = Type: <b>LPCSTR</b> A semantic.
    ///Returns:
    ///    Type: <b>ID3D10EffectType*</b> A pointer to an ID3D10EffectType Interface.
    ///    
    ID3D10EffectType GetMemberTypeBySemantic(const(char)* Semantic);
    ///Get the name of a member.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index.
    ///Returns:
    ///    Type: <b>LPCSTR</b> The name of the member.
    ///    
    byte*   GetMemberName(uint Index);
    ///Get the semantic attached to a member.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index.
    ///Returns:
    ///    Type: <b>LPCSTR</b> A string that contains the semantic.
    ///    
    byte*   GetMemberSemantic(uint Index);
}

///The <b>ID3D10EffectVariable</b> interface is the base class for all effect variables. The lifetime of an
///<b>ID3D10EffectVariable</b> object is equal to the lifetime of its parent ID3D10Effect object. <ul> <li>Methods</li>
///</ul><h3><a id="methods"></a>Methods</h3>The <b>ID3D10EffectVariable</b> interface has these methods. <table
///class="members" id="memberListMethods"> <tr> <th align="left" width="37%">Method</th> <th align="left"
///width="63%">Description</th> </tr> <tr data="declared;"> <td align="left" width="37%"> AsBlend </td> <td align="left"
///width="63%"> Get a effect-blend variable. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///AsConstantBuffer </td> <td align="left" width="63%"> Get a constant buffer. </td> </tr> <tr data="declared;"> <td
///align="left" width="37%"> AsDepthStencil </td> <td align="left" width="63%"> Get a depth-stencil variable. </td>
///</tr> <tr data="declared;"> <td align="left" width="37%"> AsDepthStencilView </td> <td align="left" width="63%"> Get
///a depth-stencil-view variable. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> AsMatrix </td> <td
///align="left" width="63%"> Get a matrix variable. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///AsRasterizer </td> <td align="left" width="63%"> Get a rasterizer variable. </td> </tr> <tr data="declared;"> <td
///align="left" width="37%"> AsRenderTargetView </td> <td align="left" width="63%"> Get a render-target-view variable.
///</td> </tr> <tr data="declared;"> <td align="left" width="37%"> AsSampler </td> <td align="left" width="63%"> Get a
///sampler variable. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> AsScalar </td> <td align="left"
///width="63%"> Get a scalar variable. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> AsShader </td>
///<td align="left" width="63%"> Get a shader variable. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///AsShaderResource </td> <td align="left" width="63%"> Get a shader-resource variable. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> AsString </td> <td align="left" width="63%"> Get a string variable.
///</td> </tr> <tr data="declared;"> <td align="left" width="37%"> AsVector </td> <td align="left" width="63%"> Get a
///vector variable. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetAnnotationByIndex </td> <td
///align="left" width="63%"> Get an annotation by index. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///GetAnnotationByName </td> <td align="left" width="63%"> Get an annotation by name. </td> </tr> <tr data="declared;">
///<td align="left" width="37%"> GetDesc </td> <td align="left" width="63%"> Get a description. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> GetElement </td> <td align="left" width="63%"> Get an array element.
///</td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetMemberByIndex </td> <td align="left" width="63%">
///Get a structure member by index. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetMemberByName
///</td> <td align="left" width="63%"> Get a structure member by name. </td> </tr> <tr data="declared;"> <td
///align="left" width="37%"> GetMemberBySemantic </td> <td align="left" width="63%"> Get a structure member by semantic.
///</td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetParentConstantBuffer </td> <td align="left"
///width="63%"> Get a constant buffer. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetRawValue </td>
///<td align="left" width="63%"> Get data. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetType </td>
///<td align="left" width="63%"> Get type information. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///IsValid </td> <td align="left" width="63%"> Compare the data type with the data stored. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> SetRawValue </td> <td align="left" width="63%"> Set data. </td> </tr>
///</table>
interface ID3D10EffectVariable
{
    ///Compare the data type with the data stored.
    ///Returns:
    ///    Type: <b>BOOL</b> <b>TRUE</b> if the syntax is valid; otherwise <b>FALSE</b>.
    ///    
    BOOL    IsValid();
    ///Get type information.
    ///Returns:
    ///    Type: <b>ID3D10EffectType*</b> A pointer to an ID3D10EffectType Interface.
    ///    
    ID3D10EffectType GetType();
    ///Get a description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_EFFECT_VARIABLE_DESC*</b> A pointer to an effect-variable description (see
    ///            D3D10_EFFECT_VARIABLE_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDesc(D3D10_EFFECT_VARIABLE_DESC* pDesc);
    ///Get an annotation by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetAnnotationByIndex(uint Index);
    ///Get an annotation by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The annotation name.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface. Note that if the
    ///    annotation is not found the <b>ID3D10EffectVariable Interface</b> returned will be empty. The
    ///    ID3D10EffectVariable::IsValid method should be called to determine whether the annotation was found.
    ///    
    ID3D10EffectVariable GetAnnotationByName(const(char)* Name);
    ///Get a structure member by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetMemberByIndex(uint Index);
    ///Get a structure member by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> Member name.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetMemberByName(const(char)* Name);
    ///Get a structure member by semantic.
    ///Params:
    ///    Semantic = Type: <b>LPCSTR</b> The semantic.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetMemberBySemantic(const(char)* Semantic);
    ///Get an array element.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index; otherwise 0.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetElement(uint Index);
    ///Get a constant buffer.
    ///Returns:
    ///    Type: <b>ID3D10EffectConstantBuffer*</b> A pointer to a ID3D10EffectConstantBuffer Interface.
    ///    
    ID3D10EffectConstantBuffer GetParentConstantBuffer();
    ///Get a scalar variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectScalarVariable*</b> A pointer to a scalar variable. See ID3D10EffectScalarVariable.
    ///    
    ID3D10EffectScalarVariable AsScalar();
    ///Get a vector variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectVectorVariable*</b> A pointer to a vector variable. See ID3D10EffectVectorVariable.
    ///    
    ID3D10EffectVectorVariable AsVector();
    ///Get a matrix variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectMatrixVariable*</b> A pointer to a matrix variable. See ID3D10EffectMatrixVariable.
    ///    
    ID3D10EffectMatrixVariable AsMatrix();
    ///Get a string variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectStringVariable*</b> A pointer to a string variable. See ID3D10EffectStringVariable.
    ///    
    ID3D10EffectStringVariable AsString();
    ///Get a shader-resource variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectShaderResourceVariable*</b> A pointer to a shader-resource variable. See
    ///    ID3D10EffectShaderResourceVariable.
    ///    
    ID3D10EffectShaderResourceVariable AsShaderResource();
    ///Get a render-target-view variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectRenderTargetViewVariable*</b> A pointer to a render-target-view variable. See
    ///    ID3D10EffectRenderTargetViewVariable Interface.
    ///    
    ID3D10EffectRenderTargetViewVariable AsRenderTargetView();
    ///Get a depth-stencil-view variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectDepthStencilViewVariable*</b> A pointer to a depth-stencil-view variable. See
    ///    ID3D10EffectDepthStencilViewVariable Interface.
    ///    
    ID3D10EffectDepthStencilViewVariable AsDepthStencilView();
    ///Get a constant buffer.
    ///Returns:
    ///    Type: <b>ID3D10EffectConstantBuffer*</b> A pointer to a constant buffer. See ID3D10EffectConstantBuffer.
    ///    
    ID3D10EffectConstantBuffer AsConstantBuffer();
    ///Get a shader variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectShaderVariable*</b> A pointer to a shader variable. See ID3D10EffectShaderVariable.
    ///    
    ID3D10EffectShaderVariable AsShader();
    ///Get a effect-blend variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectBlendVariable*</b> A pointer to an effect blend variable. See ID3D10EffectBlendVariable.
    ///    
    ID3D10EffectBlendVariable AsBlend();
    ///Get a depth-stencil variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectDepthStencilVariable*</b> A pointer to a depth-stencil variable. See
    ///    ID3D10EffectDepthStencilVariable.
    ///    
    ID3D10EffectDepthStencilVariable AsDepthStencil();
    ///Get a rasterizer variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectRasterizerVariable*</b> A pointer to a rasterizer variable. See
    ///    ID3D10EffectRasterizerVariable.
    ///    
    ID3D10EffectRasterizerVariable AsRasterizer();
    ///Get a sampler variable.
    ///Returns:
    ///    Type: <b>ID3D10EffectSamplerVariable*</b> A pointer to a sampler variable. See ID3D10EffectSamplerVariable.
    ///    
    ID3D10EffectSamplerVariable AsSampler();
    ///Set data.
    ///Params:
    ///    pData = Type: <b>void*</b> A pointer to the variable.
    ///    Offset = Type: <b>UINT</b> The offset (in bytes) from the beginning of the pointer to the data.
    ///    ByteCount = Type: <b>UINT</b> The number of bytes to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetRawValue(char* pData, uint Offset, uint ByteCount);
    ///Get data.
    ///Params:
    ///    pData = Type: <b>void*</b> A pointer to the variable.
    ///    Offset = Type: <b>UINT</b> The offset (in bytes) from the beginning of the pointer to the data.
    ///    ByteCount = Type: <b>UINT</b> The number of bytes to get.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetRawValue(char* pData, uint Offset, uint ByteCount);
}

///An effect-scalar-variable interface accesses scalar values.
interface ID3D10EffectScalarVariable : ID3D10EffectVariable
{
    ///Set a floating-point variable.
    ///Params:
    ///    Value = Type: <b>float</b> A pointer to the variable.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetFloat(float Value);
    ///Get a floating-point variable.
    ///Params:
    ///    pValue = Type: <b>float*</b> A pointer to the variable.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetFloat(float* pValue);
    ///Set an array of floating-point variables.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetFloatArray(char* pData, uint Offset, uint Count);
    ///Get an array of floating-point variables.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetFloatArray(char* pData, uint Offset, uint Count);
    ///Set an integer variable.
    ///Params:
    ///    Value = Type: <b>int</b> A pointer to the variable.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetInt(int Value);
    ///Get an integer variable.
    ///Params:
    ///    pValue = Type: <b>int*</b> A pointer to the variable.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetInt(int* pValue);
    ///Set an array of integer variables.
    ///Params:
    ///    pData = Type: <b>int*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetIntArray(char* pData, uint Offset, uint Count);
    ///Get an array of integer variables.
    ///Params:
    ///    pData = Type: <b>int*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetIntArray(char* pData, uint Offset, uint Count);
    ///Set a boolean variable.
    ///Params:
    ///    Value = Type: <b>BOOL</b> A pointer to the variable.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetBool(BOOL Value);
    ///Get a boolean variable.
    ///Params:
    ///    pValue = Type: <b>BOOL*</b> A pointer to the variable.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetBool(int* pValue);
    ///Set an array of boolean variables.
    ///Params:
    ///    pData = Type: <b>BOOL*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetBoolArray(char* pData, uint Offset, uint Count);
    ///Get an array of boolean variables.
    ///Params:
    ///    pData = Type: <b>BOOL*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetBoolArray(char* pData, uint Offset, uint Count);
}

///A vector-variable interface accesses a four-component vector.
interface ID3D10EffectVectorVariable : ID3D10EffectVariable
{
    ///Set a four-component vector that contains boolean data.
    ///Params:
    ///    pData = Type: <b>BOOL*</b> A pointer to the first component.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetBoolVector(int* pData);
    ///Set a four-component vector that contains integer data.
    ///Params:
    ///    pData = Type: <b>int*</b> A pointer to the first component.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetIntVector(int* pData);
    ///Set a four-component vector that contains floating-point data.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the first component.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetFloatVector(float* pData);
    ///Get a four-component vector that contains boolean data.
    ///Params:
    ///    pData = Type: <b>BOOL*</b> A pointer to the first component.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetBoolVector(int* pData);
    ///Get a four-component vector that contains integer data.
    ///Params:
    ///    pData = Type: <b>int*</b> A pointer to the first component.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetIntVector(int* pData);
    ///Get a four-component vector that contains floating-point data.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the first component.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetFloatVector(float* pData);
    ///Set an array of four-component vectors that contain boolean data.
    ///Params:
    ///    pData = Type: <b>BOOL*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetBoolVectorArray(int* pData, uint Offset, uint Count);
    ///Set an array of four-component vectors that contain integer data.
    ///Params:
    ///    pData = Type: <b>int*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetIntVectorArray(int* pData, uint Offset, uint Count);
    ///Set an array of four-component vectors that contain floating-point data.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetFloatVectorArray(float* pData, uint Offset, uint Count);
    ///Get an array of four-component vectors that contain boolean data.
    ///Params:
    ///    pData = Type: <b>BOOL*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetBoolVectorArray(int* pData, uint Offset, uint Count);
    ///Get an array of four-component vectors that contain integer data.
    ///Params:
    ///    pData = Type: <b>int*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetIntVectorArray(int* pData, uint Offset, uint Count);
    ///Get an array of four-component vectors that contain floating-point data.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the start of the data to set.
    ///    Offset = Type: <b>UINT</b> Must be set to 0; this is reserved for future use.
    ///    Count = Type: <b>UINT</b> The number of array elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetFloatVectorArray(float* pData, uint Offset, uint Count);
}

///A matrix-variable interface accesses a matrix.
interface ID3D10EffectMatrixVariable : ID3D10EffectVariable
{
    ///Set a floating-point matrix.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the first element in the matrix.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetMatrix(float* pData);
    ///Get a matrix.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the first element in a matrix.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetMatrix(float* pData);
    ///Set an array of floating-point matrices.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the first matrix.
    ///    Offset = Type: <b>UINT</b> The number of matrix elements to skip from the start of the array.
    ///    Count = Type: <b>UINT</b> The number of elements to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetMatrixArray(float* pData, uint Offset, uint Count);
    ///Get an array of matrices.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the first element of the first matrix in an array of matrices.
    ///    Offset = Type: <b>UINT</b> The offset (in number of matrices) between the start of the array and the first matrix
    ///             returned.
    ///    Count = Type: <b>UINT</b> The number of matrices in the returned array.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetMatrixArray(float* pData, uint Offset, uint Count);
    ///Transpose and set a floating-point matrix.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the first element of a matrix.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetMatrixTranspose(float* pData);
    ///Transpose and get a floating-point matrix.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the first element of a transposed matrix.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetMatrixTranspose(float* pData);
    ///Transpose and set an array of floating-point matrices.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to an array of matrices.
    ///    Offset = Type: <b>UINT</b> The offset (in number of matrices) between the start of the array and the first matrix to
    ///             set.
    ///    Count = Type: <b>UINT</b> The number of matrices in the array to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetMatrixTransposeArray(float* pData, uint Offset, uint Count);
    ///Transpose and get an array of floating-point matrices.
    ///Params:
    ///    pData = Type: <b>float*</b> A pointer to the first element of an array of tranposed matrices.
    ///    Offset = Type: <b>UINT</b> The offset (in number of matrices) between the start of the array and the first matrix to
    ///             get.
    ///    Count = Type: <b>UINT</b> The number of matrices in the array to get.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetMatrixTransposeArray(float* pData, uint Offset, uint Count);
}

///A string-variable interface accesses a string variable.
interface ID3D10EffectStringVariable : ID3D10EffectVariable
{
    ///Get the string.
    ///Params:
    ///    ppString = Type: <b>LPCSTR*</b> A pointer to the string.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetString(byte** ppString);
    ///Get an array of strings.
    ///Params:
    ///    ppStrings = Type: <b>LPCSTR*</b> A pointer to the first string in the array.
    ///    Offset = Type: <b>UINT</b> The offset (in number of strings) between the start of the array and the first string to
    ///             get.
    ///    Count = Type: <b>UINT</b> The number of strings in the returned array.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetStringArray(char* ppStrings, uint Offset, uint Count);
}

///A shader-resource interface accesses a shader resource.
interface ID3D10EffectShaderResourceVariable : ID3D10EffectVariable
{
    ///Set a shader resource.
    ///Params:
    ///    pResource = Type: <b>ID3D10ShaderResourceView*</b> The address of a pointer to a shader-resource-view interface. See
    ///                ID3D10ShaderResourceView Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetResource(ID3D10ShaderResourceView pResource);
    ///Get a shader resource.
    ///Params:
    ///    ppResource = Type: <b>ID3D10ShaderResourceView**</b> The address of a pointer to a shader-resource-view interface. See
    ///                 ID3D10ShaderResourceView Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetResource(ID3D10ShaderResourceView* ppResource);
    ///Set an array of shader resources.
    ///Params:
    ///    ppResources = Type: <b>ID3D10ShaderResourceView**</b> The address of an array of shader-resource-view interfaces. See
    ///                  ID3D10ShaderResourceView Interface.
    ///    Offset = Type: <b>UINT</b> The zero-based array index to get the first interface.
    ///    Count = Type: <b>UINT</b> The number of elements in the array.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetResourceArray(char* ppResources, uint Offset, uint Count);
    ///Get an array of shader resources.
    ///Params:
    ///    ppResources = Type: <b>ID3D10ShaderResourceView**</b> The address of an array of shader-resource-view interfaces. See
    ///                  ID3D10ShaderResourceView Interface.
    ///    Offset = Type: <b>UINT</b> The zero-based array index to get the first interface.
    ///    Count = Type: <b>UINT</b> The number of elements in the array.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetResourceArray(char* ppResources, uint Offset, uint Count);
}

///A render-target-view interface accesses a render target.
interface ID3D10EffectRenderTargetViewVariable : ID3D10EffectVariable
{
    ///Set a render-target.
    ///Params:
    ///    pResource = Type: <b>ID3D10RenderTargetView*</b> A pointer to a render-target-view interface. See ID3D10RenderTargetView
    ///                Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetRenderTarget(ID3D10RenderTargetView pResource);
    ///Get a render-target.
    ///Params:
    ///    ppResource = Type: <b>ID3D10RenderTargetView**</b> The address of a pointer to a render-target-view interface. See
    ///                 ID3D10RenderTargetView Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetRenderTarget(ID3D10RenderTargetView* ppResource);
    ///Set an array of render-targets.
    ///Params:
    ///    ppResources = Type: <b>ID3D10RenderTargetView**</b> Set an array of render-target-view interfaces. See
    ///                  ID3D10RenderTargetView Interface.
    ///    Offset = Type: <b>UINT</b> The zero-based array index to store the first interface.
    ///    Count = Type: <b>UINT</b> The number of elements in the array.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetRenderTargetArray(char* ppResources, uint Offset, uint Count);
    ///Get an array of render-targets.
    ///Params:
    ///    ppResources = Type: <b>ID3D10RenderTargetView**</b> A pointer to an array of render-target-view interfaces. See
    ///                  ID3D10RenderTargetView Interface.
    ///    Offset = Type: <b>UINT</b> The zero-based array index to get the first interface.
    ///    Count = Type: <b>UINT</b> The number of elements in the array.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetRenderTargetArray(char* ppResources, uint Offset, uint Count);
}

///A depth-stencil-view-variable interface accesses a depth-stencil view.
interface ID3D10EffectDepthStencilViewVariable : ID3D10EffectVariable
{
    ///Set a depth-stencil-view resource.
    ///Params:
    ///    pResource = Type: <b>ID3D10DepthStencilView*</b> A pointer to a depth-stencil-view interface. See ID3D10DepthStencilView
    ///                Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetDepthStencil(ID3D10DepthStencilView pResource);
    ///Get a depth-stencil-view resource.
    ///Params:
    ///    ppResource = Type: <b>ID3D10DepthStencilView**</b> The address of a pointer to a depth-stencil-view interface. See
    ///                 ID3D10DepthStencilView Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDepthStencil(ID3D10DepthStencilView* ppResource);
    ///Set an array of depth-stencil-view resources.
    ///Params:
    ///    ppResources = Type: <b>ID3D10DepthStencilView**</b> A pointer to an array of depth-stencil-view interfaces. See
    ///                  ID3D10DepthStencilView Interface.
    ///    Offset = Type: <b>UINT</b> The zero-based array index to set the first interface.
    ///    Count = Type: <b>UINT</b> The number of elements in the array.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetDepthStencilArray(char* ppResources, uint Offset, uint Count);
    ///Get an array of depth-stencil-view resources.
    ///Params:
    ///    ppResources = Type: <b>ID3D10DepthStencilView**</b> A pointer to an array of depth-stencil-view interfaces. See
    ///                  ID3D10DepthStencilView Interface.
    ///    Offset = Type: <b>UINT</b> The zero-based array index to get the first interface.
    ///    Count = Type: <b>UINT</b> The number of elements in the array.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDepthStencilArray(char* ppResources, uint Offset, uint Count);
}

///A constant-buffer interface accesses constant buffers or texture buffers.
interface ID3D10EffectConstantBuffer : ID3D10EffectVariable
{
    ///Set a constant-buffer.
    ///Params:
    ///    pConstantBuffer = Type: <b>ID3D10Buffer*</b> A pointer to a constant-buffer interface. See ID3D10Buffer Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetConstantBuffer(ID3D10Buffer pConstantBuffer);
    ///Get a constant-buffer.
    ///Params:
    ///    ppConstantBuffer = Type: <b>ID3D10Buffer**</b> The address of a pointer to a constant-buffer interface. See ID3D10Buffer
    ///                       Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetConstantBuffer(ID3D10Buffer* ppConstantBuffer);
    ///Set a texture-buffer.
    ///Params:
    ///    pTextureBuffer = Type: <b>ID3D10ShaderResourceView*</b> A pointer to a shader-resource-view interface for accessing a texture
    ///                     buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT SetTextureBuffer(ID3D10ShaderResourceView pTextureBuffer);
    ///Get a texture-buffer.
    ///Params:
    ///    ppTextureBuffer = Type: <b>ID3D10ShaderResourceView**</b> The address of a pointer to a shader-resource-view interface for
    ///                      accessing a texture buffer. See ID3D10ShaderResourceView Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetTextureBuffer(ID3D10ShaderResourceView* ppTextureBuffer);
}

///A shader-variable interface accesses a shader variable.
interface ID3D10EffectShaderVariable : ID3D10EffectVariable
{
    ///Get a shader description.
    ///Params:
    ///    ShaderIndex = Type: <b>UINT</b> A zero-based index.
    ///    pDesc = Type: <b>D3D10_EFFECT_SHADER_DESC*</b> A pointer to a shader description (see D3D10_EFFECT_SHADER_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetShaderDesc(uint ShaderIndex, D3D10_EFFECT_SHADER_DESC* pDesc);
    ///Get a vertex shader.
    ///Params:
    ///    ShaderIndex = Type: <b>UINT</b> A zero-based index.
    ///    ppVS = Type: <b>ID3D10VertexShader**</b> A pointer to a ID3D10VertexShader Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetVertexShader(uint ShaderIndex, ID3D10VertexShader* ppVS);
    ///Get a geometry shader.
    ///Params:
    ///    ShaderIndex = Type: <b>UINT</b> A zero-based index.
    ///    ppGS = Type: <b>ID3D10GeometryShader**</b> A pointer to a ID3D10GeometryShader Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetGeometryShader(uint ShaderIndex, ID3D10GeometryShader* ppGS);
    ///Get a pixel shader.
    ///Params:
    ///    ShaderIndex = Type: <b>UINT</b> A zero-based index.
    ///    ppPS = Type: <b>ID3D10PixelShader**</b> A pointer to a ID3D10PixelShader Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetPixelShader(uint ShaderIndex, ID3D10PixelShader* ppPS);
    ///Get an input-signature description.
    ///Params:
    ///    ShaderIndex = Type: <b>UINT</b> A zero-based shader index.
    ///    Element = Type: <b>UINT</b> A zero-based shader-element index.
    ///    pDesc = Type: <b>D3D10_SIGNATURE_PARAMETER_DESC*</b> A pointer to a parameter description (see
    ///            D3D10_SIGNATURE_PARAMETER_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetInputSignatureElementDesc(uint ShaderIndex, uint Element, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    ///Get an output-signature description.
    ///Params:
    ///    ShaderIndex = Type: <b>UINT</b> A zero-based shader index.
    ///    Element = Type: <b>UINT</b> A zero-based element index.
    ///    pDesc = Type: <b>D3D10_SIGNATURE_PARAMETER_DESC*</b> A pointer to a parameter description (see
    ///            D3D10_SIGNATURE_PARAMETER_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetOutputSignatureElementDesc(uint ShaderIndex, uint Element, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
}

///The blend-variable interface accesses blend state.
interface ID3D10EffectBlendVariable : ID3D10EffectVariable
{
    ///Get a pointer to a blend-state interface.
    ///Params:
    ///    Index = Type: <b>UINT</b> Index into an array of blend-state interfaces. If there is only one blend-state interface,
    ///            use 0.
    ///    ppBlendState = Type: <b>ID3D10BlendState**</b> The address of a pointer to a blend-state interface (see ID3D10BlendState
    ///                   Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetBlendState(uint Index, ID3D10BlendState* ppBlendState);
    ///Get a pointer to a blend-state variable.
    ///Params:
    ///    Index = Type: <b>UINT</b> Index into an array of blend-state descriptions. If there is only one blend-state variable
    ///            in the effect, use 0.
    ///    pBlendDesc = Type: <b>D3D10_BLEND_DESC*</b> A pointer to a blend-state description (see D3D10_BLEND_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetBackingStore(uint Index, D3D10_BLEND_DESC* pBlendDesc);
}

///A depth-stencil-variable interface accesses depth-stencil state.
interface ID3D10EffectDepthStencilVariable : ID3D10EffectVariable
{
    ///Get a pointer to a depth-stencil interface.
    ///Params:
    ///    Index = Type: <b>UINT</b> Index into an array of depth-stencil interfaces. If there is only one depth-stencil
    ///            interface, use 0.
    ///    ppDepthStencilState = Type: <b>ID3D10DepthStencilState**</b> The address of a pointer to a blend-state interface (see
    ///                          ID3D10DepthStencilState Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDepthStencilState(uint Index, ID3D10DepthStencilState* ppDepthStencilState);
    ///Get a pointer to a variable that contains depth-stencil state.
    ///Params:
    ///    Index = Type: <b>UINT</b> Index into an array of depth-stencil-state descriptions. If there is only one depth-stencil
    ///            variable in the effect, use 0.
    ///    pDepthStencilDesc = Type: <b>D3D10_DEPTH_STENCIL_DESC*</b> A pointer to a depth-stencil-state description (see
    ///                        D3D10_DEPTH_STENCIL_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetBackingStore(uint Index, D3D10_DEPTH_STENCIL_DESC* pDepthStencilDesc);
}

///A rasterizer-variable interface accesses rasterizer state.
interface ID3D10EffectRasterizerVariable : ID3D10EffectVariable
{
    ///Get a pointer to a rasterizer interface.
    ///Params:
    ///    Index = Type: <b>UINT</b> Index into an array of rasterizer interfaces. If there is only one rasterizer interface,
    ///            use 0.
    ///    ppRasterizerState = Type: <b>ID3D10RasterizerState**</b> The address of a pointer to a rasterizer interface (see
    ///                        ID3D10RasterizerState Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetRasterizerState(uint Index, ID3D10RasterizerState* ppRasterizerState);
    ///Get a pointer to a variable that contains rasteriser state.
    ///Params:
    ///    Index = Type: <b>UINT</b> Index into an array of rasteriser-state descriptions. If there is only one rasteriser
    ///            variable in the effect, use 0.
    ///    pRasterizerDesc = Type: <b>D3D10_RASTERIZER_DESC*</b> A pointer to a rasteriser-state description (see D3D10_RASTERIZER_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetBackingStore(uint Index, D3D10_RASTERIZER_DESC* pRasterizerDesc);
}

///A sampler interface accesses sampler state.
interface ID3D10EffectSamplerVariable : ID3D10EffectVariable
{
    ///Get a pointer to a sampler interface.
    ///Params:
    ///    Index = Type: <b>UINT</b> Index into an array of sampler interfaces. If there is only one sampler interface, use 0.
    ///    ppSampler = Type: <b>ID3D10SamplerState**</b> The address of a pointer to a sampler interface (see ID3D10SamplerState
    ///                Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetSampler(uint Index, ID3D10SamplerState* ppSampler);
    ///Get a pointer to a variable that contains sampler state.
    ///Params:
    ///    Index = Type: <b>UINT</b> Index into an array of sampler descriptions. If there is only one sampler variable in the
    ///            effect, use 0.
    ///    pSamplerDesc = Type: <b>D3D10_SAMPLER_DESC*</b> A pointer to a sampler description (see D3D10_SAMPLER_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetBackingStore(uint Index, D3D10_SAMPLER_DESC* pSamplerDesc);
}

///A pass interface encapsulates state assignments within a technique. The lifetime of an <b>ID3D10EffectPass</b> object
///is equal to the lifetime of its parent ID3D10Effect object. <ul> <li>Methods</li> </ul><h3><a
///id="methods"></a>Methods</h3>The <b>ID3D10EffectPass</b> interface has these methods. <table class="members"
///id="memberListMethods"> <tr> <th align="left" width="37%">Method</th> <th align="left" width="63%">Description</th>
///</tr> <tr data="declared;"> <td align="left" width="37%"> Apply </td> <td align="left" width="63%"> Set the state
///contained in a pass to the device. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///ComputeStateBlockMask </td> <td align="left" width="63%"> Generate a mask for allowing/preventing state changes.
///</td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetAnnotationByIndex </td> <td align="left"
///width="63%"> Get an annotation by index. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///GetAnnotationByName </td> <td align="left" width="63%"> Get an annotation by name. </td> </tr> <tr data="declared;">
///<td align="left" width="37%"> GetDesc </td> <td align="left" width="63%"> Get a pass description. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> GetGeometryShaderDesc </td> <td align="left" width="63%"> Get a
///geometry-shader description. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetPixelShaderDesc </td>
///<td align="left" width="63%"> Get a pixel-shader description. </td> </tr> <tr data="declared;"> <td align="left"
///width="37%"> GetVertexShaderDesc </td> <td align="left" width="63%"> Get a vertex-shader description. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> IsValid </td> <td align="left" width="63%"> Test a pass to see if it
///contains valid syntax. </td> </tr> </table>
interface ID3D10EffectPass
{
    ///Test a pass to see if it contains valid syntax.
    ///Returns:
    ///    Type: <b>BOOL</b> <b>TRUE</b> if the code syntax is valid; otherwise <b>FALSE</b>.
    ///    
    BOOL    IsValid();
    ///Get a pass description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_PASS_DESC*</b> A pointer to a pass description (see D3D10_PASS_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDesc(D3D10_PASS_DESC* pDesc);
    ///Get a vertex-shader description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_PASS_SHADER_DESC*</b> A pointer to a vertex-shader description (see D3D10_PASS_SHADER_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetVertexShaderDesc(D3D10_PASS_SHADER_DESC* pDesc);
    ///Get a geometry-shader description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_PASS_SHADER_DESC*</b> A pointer to a geometry-shader description (see D3D10_PASS_SHADER_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetGeometryShaderDesc(D3D10_PASS_SHADER_DESC* pDesc);
    ///Get a pixel-shader description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_PASS_SHADER_DESC*</b> A pointer to a pixel-shader description (see D3D10_PASS_SHADER_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetPixelShaderDesc(D3D10_PASS_SHADER_DESC* pDesc);
    ///Get an annotation by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetAnnotationByIndex(uint Index);
    ///Get an annotation by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The name of the annotation.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetAnnotationByName(const(char)* Name);
    ///Set the state contained in a pass to the device.
    ///Params:
    ///    Flags = Type: <b>UINT</b> Unused.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT Apply(uint Flags);
    ///Generate a mask for allowing/preventing state changes.
    ///Params:
    ///    pStateBlockMask = Type: <b>D3D10_STATE_BLOCK_MASK*</b> A pointer to a state-block mask (see D3D10_STATE_BLOCK_MASK).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT ComputeStateBlockMask(D3D10_STATE_BLOCK_MASK* pStateBlockMask);
}

///An <b>ID3D10EffectTechnique</b> interface is a collection of passes. The lifetime of an <b>ID3D10EffectTechnique</b>
///object is equal to the lifetime of its parent ID3D10Effect object. <ul> <li>Methods</li> </ul><h3><a
///id="methods"></a>Methods</h3>The <b>ID3D10EffectTechnique</b> interface has these methods. <table class="members"
///id="memberListMethods"> <tr> <th align="left" width="37%">Method</th> <th align="left" width="63%">Description</th>
///</tr> <tr data="declared;"> <td align="left" width="37%"> ComputeStateBlockMask </td> <td align="left" width="63%">
///Compute a state-block mask to allow/prevent state changes. </td> </tr> <tr data="declared;"> <td align="left"
///width="37%"> GetAnnotationByIndex </td> <td align="left" width="63%"> Get an annotation by index. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> GetAnnotationByName </td> <td align="left" width="63%"> Get an
///annotation by name. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetDesc </td> <td align="left"
///width="63%"> Get a technique description. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///GetPassByIndex </td> <td align="left" width="63%"> Get a pass by index. </td> </tr> <tr data="declared;"> <td
///align="left" width="37%"> GetPassByName </td> <td align="left" width="63%"> Get a pass by name. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> IsValid </td> <td align="left" width="63%"> Test a technique to see
///if it contains valid syntax. </td> </tr> </table>
interface ID3D10EffectTechnique
{
    ///Test a technique to see if it contains valid syntax.
    ///Returns:
    ///    Type: <b>BOOL</b> <b>TRUE</b> if the code syntax is valid; otherwise <b>FALSE</b>.
    ///    
    BOOL    IsValid();
    ///Get a technique description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_TECHNIQUE_DESC*</b> A pointer to a technique description (see D3D10_TECHNIQUE_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDesc(D3D10_TECHNIQUE_DESC* pDesc);
    ///Get an annotation by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> The zero-based index of the interface pointer.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetAnnotationByIndex(uint Index);
    ///Get an annotation by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> Name of the annotation.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetAnnotationByName(const(char)* Name);
    ///Get a pass by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10EffectPass*</b> A pointer to a ID3D10EffectPass Interface.
    ///    
    ID3D10EffectPass GetPassByIndex(uint Index);
    ///Get a pass by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The name of the pass.
    ///Returns:
    ///    Type: <b>ID3D10EffectPass*</b> A pointer to an ID3D10EffectPass Interface.
    ///    
    ID3D10EffectPass GetPassByName(const(char)* Name);
    ///Compute a state-block mask to allow/prevent state changes.
    ///Params:
    ///    pStateBlockMask = Type: <b>D3D10_STATE_BLOCK_MASK*</b> A pointer to a state-block mask (see D3D10_STATE_BLOCK_MASK).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT ComputeStateBlockMask(D3D10_STATE_BLOCK_MASK* pStateBlockMask);
}

///An <b>ID3D10Effect</b> interface manages a set of state objects, resources, and shaders for implementing a rendering
///effect.
interface ID3D10Effect : IUnknown
{
    ///Test an effect to see if it contains valid syntax.
    ///Returns:
    ///    Type: <b>BOOL</b> <b>TRUE</b> if the code syntax is valid; otherwise <b>FALSE</b>.
    ///    
    BOOL    IsValid();
    ///Test an effect to see if it is part of a memory pool.
    ///Returns:
    ///    Type: <b>BOOL</b> <b>TRUE</b> if the effect is pooled; otherwise <b>FALSE</b>. See ID3D10EffectPool
    ///    Interface.
    ///    
    BOOL    IsPool();
    ///Get the device that created the effect.
    ///Params:
    ///    ppDevice = Type: <b>ID3D10Device**</b> A pointer to an ID3D10Device Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDevice(ID3D10Device* ppDevice);
    ///Get an effect description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_EFFECT_DESC*</b> A pointer to an effect description (see D3D10_EFFECT_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetDesc(D3D10_EFFECT_DESC* pDesc);
    ///Get a constant buffer by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10EffectConstantBuffer*</b> A pointer to a ID3D10EffectConstantBuffer Interface.
    ///    
    ID3D10EffectConstantBuffer GetConstantBufferByIndex(uint Index);
    ///Get a constant buffer by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The constant-buffer name.
    ///Returns:
    ///    Type: <b>ID3D10EffectConstantBuffer*</b> A pointer to the constant buffer indicated by the Name. See
    ///    ID3D10EffectConstantBuffer.
    ///    
    ID3D10EffectConstantBuffer GetConstantBufferByName(const(char)* Name);
    ///Get a variable by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to a ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetVariableByIndex(uint Index);
    ///Get a variable by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The variable name.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to an ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetVariableByName(const(char)* Name);
    ///Get a variable by semantic.
    ///Params:
    ///    Semantic = Type: <b>LPCSTR</b> The semantic name.
    ///Returns:
    ///    Type: <b>ID3D10EffectVariable*</b> A pointer to the effect variable indicated by the Semantic. See
    ///    ID3D10EffectVariable Interface.
    ///    
    ID3D10EffectVariable GetVariableBySemantic(const(char)* Semantic);
    ///Get a technique by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> A zero-based index.
    ///Returns:
    ///    Type: <b>ID3D10EffectTechnique*</b> A pointer to an ID3D10EffectTechnique Interface.
    ///    
    ID3D10EffectTechnique GetTechniqueByIndex(uint Index);
    ///Get a technique by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The name of the technique.
    ///Returns:
    ///    Type: <b>ID3D10EffectTechnique*</b> A pointer to an ID3D10EffectTechnique Interface, or <b>NULL</b> if the
    ///    technique is not found.
    ///    
    ID3D10EffectTechnique GetTechniqueByName(const(char)* Name);
    ///Minimize the amount of memory required for an effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT Optimize();
    ///Test an effect to see if the reflection metadata has been removed from memory.
    ///Returns:
    ///    Type: <b>BOOL</b> <b>TRUE</b> if the effect is optimized; otherwise <b>FALSE</b>.
    ///    
    BOOL    IsOptimized();
}

///A pool interface represents a common memory space (or pool) for sharing variables between effects.
interface ID3D10EffectPool : IUnknown
{
    ///Get the effect that created the effect pool.
    ///Returns:
    ///    Type: <b>ID3D10Effect*</b> A pointer to an ID3D10Effect Interface interface.
    ///    
    ID3D10Effect AsEffect();
}

///This blend-state interface accesses blending state for a Direct3D 10.1 device for the output-merger stage.
@GUID("EDAD8D99-8A35-4D6D-8566-2EA276CDE161")
interface ID3D10BlendState1 : ID3D10BlendState
{
    ///Get the blend state.
    ///Params:
    ///    pDesc = Type: <b>D3D10_BLEND_DESC1*</b> A pointer to the blend state (see D3D10_BLEND_DESC1).
    void GetDesc1(D3D10_BLEND_DESC1* pDesc);
}

///A shader-resource-view interface specifies the subresources a shader can access during rendering. Examples of shader
///resources include a constant buffer, a texture buffer, a texture or a sampler.
@GUID("9B7E4C87-342C-4106-A19F-4F2704F689F0")
interface ID3D10ShaderResourceView1 : ID3D10ShaderResourceView
{
    ///Get the shader resource view's description.
    ///Params:
    ///    pDesc = Type: <b>D3D10_SHADER_RESOURCE_VIEW_DESC1*</b> A pointer to a D3D10_SHADER_RESOURCE_VIEW_DESC1 structure to
    ///            be filled with data about the shader resource view.
    void GetDesc1(D3D10_SHADER_RESOURCE_VIEW_DESC1* pDesc);
}

///The device interface represents a virtual adapter for Direct3D 10.1; it is used to perform rendering and create
///Direct3D resources.
@GUID("9B7E4C8F-342C-4106-A19F-4F2704F689F0")
interface ID3D10Device1 : ID3D10Device
{
    ///Create a shader-resource view for accessing data in a resource.
    ///Params:
    ///    pResource = Type: <b>ID3D10Resource*</b> Pointer to the resource that will serve as input to a shader. This resource must
    ///                have been created with the D3D10_BIND_SHADER_RESOURCE flag.
    ///    pDesc = Type: <b>const D3D10_SHADER_RESOURCE_VIEW_DESC1*</b> Pointer to a shader-resource-view description (see
    ///            D3D10_SHADER_RESOURCE_VIEW_DESC1). Set this parameter to <b>NULL</b> to create a view that accesses the
    ///            entire resource (using the format the resource was created with).
    ///    ppSRView = Type: <b>ID3D10ShaderResourceView1**</b> Address of a pointer to a shader-resource view (see
    ///               ID3D10ShaderResourceView1 Interface). Set this parameter to <b>NULL</b> to validate the other input
    ///               parameters (the method will return S_FALSE if the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateShaderResourceView1(ID3D10Resource pResource, const(D3D10_SHADER_RESOURCE_VIEW_DESC1)* pDesc, 
                                      ID3D10ShaderResourceView1* ppSRView);
    ///Create a blend-state object that encapsules blend state for the output-merger stage.
    ///Params:
    ///    pBlendStateDesc = Type: <b>const D3D10_BLEND_DESC1*</b> Pointer to a blend-state description (see D3D10_BLEND_DESC1).
    ///    ppBlendState = Type: <b>ID3D10BlendState1**</b> Address of a pointer to the blend-state object created (see
    ///                   ID3D10BlendState1 Interface).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT CreateBlendState1(const(D3D10_BLEND_DESC1)* pBlendStateDesc, ID3D10BlendState1* ppBlendState);
    ///Gets the feature level of the hardware device.
    ///Returns:
    ///    Type: <b>D3D10_FEATURE_LEVEL1</b> The feature level (see D3D10_FEATURE_LEVEL1).
    ///    
    D3D10_FEATURE_LEVEL1 GetFeatureLevel();
}

///A shader-reflection interface accesses shader information.
interface ID3D10ShaderReflection1 : IUnknown
{
    HRESULT GetDesc(D3D10_SHADER_DESC* pDesc);
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint Index);
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByName(const(char)* Name);
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D10_SHADER_INPUT_BIND_DESC* pDesc);
    HRESULT GetInputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    HRESULT GetOutputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    ///Gets a variable by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR*</b> A pointer to a string containing the variable name.
    ///Returns:
    ///    Type: <b>ID3D10ShaderReflectionVariable*</b> Returns a ID3D10ShaderReflectionVariable Interface interface.
    ///    
    ID3D10ShaderReflectionVariable GetVariableByName(const(char)* Name);
    ///Gets a resource binding description by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR*</b> A pointer to a string containing the variable name.
    ///    pDesc = Type: <b>D3D10_SHADER_INPUT_BIND_DESC*</b> Pointer to a D3D10_SHADER_INPUT_BIND_DESC structure that will be
    ///            populated with resource binding information.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetResourceBindingDescByName(const(char)* Name, D3D10_SHADER_INPUT_BIND_DESC* pDesc);
    ///Gets the number of Mov instructions.
    ///Params:
    ///    pCount = Type: <b>UINT*</b> A pointer to the number of Mov instructions.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetMovInstructionCount(uint* pCount);
    ///Gets the number of Movc instructions.
    ///Params:
    ///    pCount = Type: <b>UINT*</b> A pointer to the number of Movc instructions.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetMovcInstructionCount(uint* pCount);
    ///Gets the number of conversion instructions used in a shader.
    ///Params:
    ///    pCount = Type: <b>UINT*</b> A pointer to a UINT that will contain the conversion instruction count when the method
    ///             returns.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetConversionInstructionCount(uint* pCount);
    ///Gets the number of bitwise instructions.
    ///Params:
    ///    pCount = Type: <b>UINT*</b> A pointer to the number of bitwise instructions.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetBitwiseInstructionCount(uint* pCount);
    ///Gets the geometry-shader input-primitive description.
    ///Params:
    ///    pPrim = Type: <b>D3D10_PRIMITIVE*</b> A pointer to the input-primitive type (see D3D10_PRIMITIVE).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT GetGSInputPrimitive(D3D_PRIMITIVE* pPrim);
    ///Indicates whether a shader was compiled in Direct3D 10 on Direct3D 9 mode.
    ///Params:
    ///    pbLevel9Shader = Type: <b>BOOL*</b> Pointer to a BOOL variable that will be set true if the shader was compiled in Direct3D 10
    ///                     on Direct3D 9 mode; otherwise false.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT IsLevel9Shader(int* pbLevel9Shader);
    ///Indicates whether a pixel shader is intended to run a pixel frequency or sample frequency.
    ///Params:
    ///    pbSampleFrequency = Type: <b>BOOL*</b> A pointer to a BOOL variable that will be set to true if the shader is intended to run at
    ///                        sample frequency; false otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 10 Return Codes.
    ///    
    HRESULT IsSampleFrequencyShader(int* pbSampleFrequency);
}


// GUIDs


const GUID IID_ID3D10Asynchronous                   = GUIDOF!ID3D10Asynchronous;
const GUID IID_ID3D10BlendState                     = GUIDOF!ID3D10BlendState;
const GUID IID_ID3D10BlendState1                    = GUIDOF!ID3D10BlendState1;
const GUID IID_ID3D10Buffer                         = GUIDOF!ID3D10Buffer;
const GUID IID_ID3D10Counter                        = GUIDOF!ID3D10Counter;
const GUID IID_ID3D10Debug                          = GUIDOF!ID3D10Debug;
const GUID IID_ID3D10DepthStencilState              = GUIDOF!ID3D10DepthStencilState;
const GUID IID_ID3D10DepthStencilView               = GUIDOF!ID3D10DepthStencilView;
const GUID IID_ID3D10Device                         = GUIDOF!ID3D10Device;
const GUID IID_ID3D10Device1                        = GUIDOF!ID3D10Device1;
const GUID IID_ID3D10DeviceChild                    = GUIDOF!ID3D10DeviceChild;
const GUID IID_ID3D10GeometryShader                 = GUIDOF!ID3D10GeometryShader;
const GUID IID_ID3D10InfoQueue                      = GUIDOF!ID3D10InfoQueue;
const GUID IID_ID3D10InputLayout                    = GUIDOF!ID3D10InputLayout;
const GUID IID_ID3D10Multithread                    = GUIDOF!ID3D10Multithread;
const GUID IID_ID3D10PixelShader                    = GUIDOF!ID3D10PixelShader;
const GUID IID_ID3D10Predicate                      = GUIDOF!ID3D10Predicate;
const GUID IID_ID3D10Query                          = GUIDOF!ID3D10Query;
const GUID IID_ID3D10RasterizerState                = GUIDOF!ID3D10RasterizerState;
const GUID IID_ID3D10RenderTargetView               = GUIDOF!ID3D10RenderTargetView;
const GUID IID_ID3D10Resource                       = GUIDOF!ID3D10Resource;
const GUID IID_ID3D10SamplerState                   = GUIDOF!ID3D10SamplerState;
const GUID IID_ID3D10ShaderReflection               = GUIDOF!ID3D10ShaderReflection;
const GUID IID_ID3D10ShaderReflectionConstantBuffer = GUIDOF!ID3D10ShaderReflectionConstantBuffer;
const GUID IID_ID3D10ShaderReflectionType           = GUIDOF!ID3D10ShaderReflectionType;
const GUID IID_ID3D10ShaderReflectionVariable       = GUIDOF!ID3D10ShaderReflectionVariable;
const GUID IID_ID3D10ShaderResourceView             = GUIDOF!ID3D10ShaderResourceView;
const GUID IID_ID3D10ShaderResourceView1            = GUIDOF!ID3D10ShaderResourceView1;
const GUID IID_ID3D10SwitchToRef                    = GUIDOF!ID3D10SwitchToRef;
const GUID IID_ID3D10Texture1D                      = GUIDOF!ID3D10Texture1D;
const GUID IID_ID3D10Texture2D                      = GUIDOF!ID3D10Texture2D;
const GUID IID_ID3D10Texture3D                      = GUIDOF!ID3D10Texture3D;
const GUID IID_ID3D10VertexShader                   = GUIDOF!ID3D10VertexShader;
const GUID IID_ID3D10View                           = GUIDOF!ID3D10View;
