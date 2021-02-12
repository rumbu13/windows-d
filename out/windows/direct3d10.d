module windows.direct3d10;

public import system;
public import windows.com;
public import windows.direct3d11;
public import windows.displaydevices;
public import windows.dxgi;
public import windows.systemservices;

extern(Windows):

enum D3D10_INPUT_CLASSIFICATION
{
    D3D10_INPUT_PER_VERTEX_DATA = 0,
    D3D10_INPUT_PER_INSTANCE_DATA = 1,
}

struct D3D10_INPUT_ELEMENT_DESC
{
    const(char)* SemanticName;
    uint SemanticIndex;
    DXGI_FORMAT Format;
    uint InputSlot;
    uint AlignedByteOffset;
    D3D10_INPUT_CLASSIFICATION InputSlotClass;
    uint InstanceDataStepRate;
}

enum D3D10_FILL_MODE
{
    D3D10_FILL_WIREFRAME = 2,
    D3D10_FILL_SOLID = 3,
}

enum D3D10_CULL_MODE
{
    D3D10_CULL_NONE = 1,
    D3D10_CULL_FRONT = 2,
    D3D10_CULL_BACK = 3,
}

struct D3D10_SO_DECLARATION_ENTRY
{
    const(char)* SemanticName;
    uint SemanticIndex;
    ubyte StartComponent;
    ubyte ComponentCount;
    ubyte OutputSlot;
}

struct D3D10_VIEWPORT
{
    int TopLeftX;
    int TopLeftY;
    uint Width;
    uint Height;
    float MinDepth;
    float MaxDepth;
}

enum D3D10_RESOURCE_DIMENSION
{
    D3D10_RESOURCE_DIMENSION_UNKNOWN = 0,
    D3D10_RESOURCE_DIMENSION_BUFFER = 1,
    D3D10_RESOURCE_DIMENSION_TEXTURE1D = 2,
    D3D10_RESOURCE_DIMENSION_TEXTURE2D = 3,
    D3D10_RESOURCE_DIMENSION_TEXTURE3D = 4,
}

enum D3D10_DSV_DIMENSION
{
    D3D10_DSV_DIMENSION_UNKNOWN = 0,
    D3D10_DSV_DIMENSION_TEXTURE1D = 1,
    D3D10_DSV_DIMENSION_TEXTURE1DARRAY = 2,
    D3D10_DSV_DIMENSION_TEXTURE2D = 3,
    D3D10_DSV_DIMENSION_TEXTURE2DARRAY = 4,
    D3D10_DSV_DIMENSION_TEXTURE2DMS = 5,
    D3D10_DSV_DIMENSION_TEXTURE2DMSARRAY = 6,
}

enum D3D10_RTV_DIMENSION
{
    D3D10_RTV_DIMENSION_UNKNOWN = 0,
    D3D10_RTV_DIMENSION_BUFFER = 1,
    D3D10_RTV_DIMENSION_TEXTURE1D = 2,
    D3D10_RTV_DIMENSION_TEXTURE1DARRAY = 3,
    D3D10_RTV_DIMENSION_TEXTURE2D = 4,
    D3D10_RTV_DIMENSION_TEXTURE2DARRAY = 5,
    D3D10_RTV_DIMENSION_TEXTURE2DMS = 6,
    D3D10_RTV_DIMENSION_TEXTURE2DMSARRAY = 7,
    D3D10_RTV_DIMENSION_TEXTURE3D = 8,
}

enum D3D10_USAGE
{
    D3D10_USAGE_DEFAULT = 0,
    D3D10_USAGE_IMMUTABLE = 1,
    D3D10_USAGE_DYNAMIC = 2,
    D3D10_USAGE_STAGING = 3,
}

enum D3D10_BIND_FLAG
{
    D3D10_BIND_VERTEX_BUFFER = 1,
    D3D10_BIND_INDEX_BUFFER = 2,
    D3D10_BIND_CONSTANT_BUFFER = 4,
    D3D10_BIND_SHADER_RESOURCE = 8,
    D3D10_BIND_STREAM_OUTPUT = 16,
    D3D10_BIND_RENDER_TARGET = 32,
    D3D10_BIND_DEPTH_STENCIL = 64,
}

enum D3D10_CPU_ACCESS_FLAG
{
    D3D10_CPU_ACCESS_WRITE = 65536,
    D3D10_CPU_ACCESS_READ = 131072,
}

enum D3D10_RESOURCE_MISC_FLAG
{
    D3D10_RESOURCE_MISC_GENERATE_MIPS = 1,
    D3D10_RESOURCE_MISC_SHARED = 2,
    D3D10_RESOURCE_MISC_TEXTURECUBE = 4,
    D3D10_RESOURCE_MISC_SHARED_KEYEDMUTEX = 16,
    D3D10_RESOURCE_MISC_GDI_COMPATIBLE = 32,
}

enum D3D10_MAP
{
    D3D10_MAP_READ = 1,
    D3D10_MAP_WRITE = 2,
    D3D10_MAP_READ_WRITE = 3,
    D3D10_MAP_WRITE_DISCARD = 4,
    D3D10_MAP_WRITE_NO_OVERWRITE = 5,
}

enum D3D10_MAP_FLAG
{
    D3D10_MAP_FLAG_DO_NOT_WAIT = 1048576,
}

enum D3D10_RAISE_FLAG
{
    D3D10_RAISE_FLAG_DRIVER_INTERNAL_ERROR = 1,
}

enum D3D10_CLEAR_FLAG
{
    D3D10_CLEAR_DEPTH = 1,
    D3D10_CLEAR_STENCIL = 2,
}

struct D3D10_BOX
{
    uint left;
    uint top;
    uint front;
    uint right;
    uint bottom;
    uint back;
}

const GUID IID_ID3D10DeviceChild = {0x9B7E4C00, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C00, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10DeviceChild : IUnknown
{
    void GetDevice(ID3D10Device* ppDevice);
    HRESULT GetPrivateData(const(Guid)* guid, uint* pDataSize, char* pData);
    HRESULT SetPrivateData(const(Guid)* guid, uint DataSize, char* pData);
    HRESULT SetPrivateDataInterface(const(Guid)* guid, const(IUnknown) pData);
}

enum D3D10_COMPARISON_FUNC
{
    D3D10_COMPARISON_NEVER = 1,
    D3D10_COMPARISON_LESS = 2,
    D3D10_COMPARISON_EQUAL = 3,
    D3D10_COMPARISON_LESS_EQUAL = 4,
    D3D10_COMPARISON_GREATER = 5,
    D3D10_COMPARISON_NOT_EQUAL = 6,
    D3D10_COMPARISON_GREATER_EQUAL = 7,
    D3D10_COMPARISON_ALWAYS = 8,
}

enum D3D10_DEPTH_WRITE_MASK
{
    D3D10_DEPTH_WRITE_MASK_ZERO = 0,
    D3D10_DEPTH_WRITE_MASK_ALL = 1,
}

enum D3D10_STENCIL_OP
{
    D3D10_STENCIL_OP_KEEP = 1,
    D3D10_STENCIL_OP_ZERO = 2,
    D3D10_STENCIL_OP_REPLACE = 3,
    D3D10_STENCIL_OP_INCR_SAT = 4,
    D3D10_STENCIL_OP_DECR_SAT = 5,
    D3D10_STENCIL_OP_INVERT = 6,
    D3D10_STENCIL_OP_INCR = 7,
    D3D10_STENCIL_OP_DECR = 8,
}

struct D3D10_DEPTH_STENCILOP_DESC
{
    D3D10_STENCIL_OP StencilFailOp;
    D3D10_STENCIL_OP StencilDepthFailOp;
    D3D10_STENCIL_OP StencilPassOp;
    D3D10_COMPARISON_FUNC StencilFunc;
}

struct D3D10_DEPTH_STENCIL_DESC
{
    BOOL DepthEnable;
    D3D10_DEPTH_WRITE_MASK DepthWriteMask;
    D3D10_COMPARISON_FUNC DepthFunc;
    BOOL StencilEnable;
    ubyte StencilReadMask;
    ubyte StencilWriteMask;
    D3D10_DEPTH_STENCILOP_DESC FrontFace;
    D3D10_DEPTH_STENCILOP_DESC BackFace;
}

const GUID IID_ID3D10DepthStencilState = {0x2B4B1CC8, 0xA4AD, 0x41F8, [0x83, 0x22, 0xCA, 0x86, 0xFC, 0x3E, 0xC6, 0x75]};
@GUID(0x2B4B1CC8, 0xA4AD, 0x41F8, [0x83, 0x22, 0xCA, 0x86, 0xFC, 0x3E, 0xC6, 0x75]);
interface ID3D10DepthStencilState : ID3D10DeviceChild
{
    void GetDesc(D3D10_DEPTH_STENCIL_DESC* pDesc);
}

enum D3D10_BLEND
{
    D3D10_BLEND_ZERO = 1,
    D3D10_BLEND_ONE = 2,
    D3D10_BLEND_SRC_COLOR = 3,
    D3D10_BLEND_INV_SRC_COLOR = 4,
    D3D10_BLEND_SRC_ALPHA = 5,
    D3D10_BLEND_INV_SRC_ALPHA = 6,
    D3D10_BLEND_DEST_ALPHA = 7,
    D3D10_BLEND_INV_DEST_ALPHA = 8,
    D3D10_BLEND_DEST_COLOR = 9,
    D3D10_BLEND_INV_DEST_COLOR = 10,
    D3D10_BLEND_SRC_ALPHA_SAT = 11,
    D3D10_BLEND_BLEND_FACTOR = 14,
    D3D10_BLEND_INV_BLEND_FACTOR = 15,
    D3D10_BLEND_SRC1_COLOR = 16,
    D3D10_BLEND_INV_SRC1_COLOR = 17,
    D3D10_BLEND_SRC1_ALPHA = 18,
    D3D10_BLEND_INV_SRC1_ALPHA = 19,
}

enum D3D10_BLEND_OP
{
    D3D10_BLEND_OP_ADD = 1,
    D3D10_BLEND_OP_SUBTRACT = 2,
    D3D10_BLEND_OP_REV_SUBTRACT = 3,
    D3D10_BLEND_OP_MIN = 4,
    D3D10_BLEND_OP_MAX = 5,
}

enum D3D10_COLOR_WRITE_ENABLE
{
    D3D10_COLOR_WRITE_ENABLE_RED = 1,
    D3D10_COLOR_WRITE_ENABLE_GREEN = 2,
    D3D10_COLOR_WRITE_ENABLE_BLUE = 4,
    D3D10_COLOR_WRITE_ENABLE_ALPHA = 8,
    D3D10_COLOR_WRITE_ENABLE_ALL = 15,
}

struct D3D10_BLEND_DESC
{
    BOOL AlphaToCoverageEnable;
    BOOL*** BlendEnable;
    D3D10_BLEND SrcBlend;
    D3D10_BLEND DestBlend;
    D3D10_BLEND_OP BlendOp;
    D3D10_BLEND SrcBlendAlpha;
    D3D10_BLEND DestBlendAlpha;
    D3D10_BLEND_OP BlendOpAlpha;
    ubyte RenderTargetWriteMask;
}

const GUID IID_ID3D10BlendState = {0xEDAD8D19, 0x8A35, 0x4D6D, [0x85, 0x66, 0x2E, 0xA2, 0x76, 0xCD, 0xE1, 0x61]};
@GUID(0xEDAD8D19, 0x8A35, 0x4D6D, [0x85, 0x66, 0x2E, 0xA2, 0x76, 0xCD, 0xE1, 0x61]);
interface ID3D10BlendState : ID3D10DeviceChild
{
    void GetDesc(D3D10_BLEND_DESC* pDesc);
}

struct D3D10_RASTERIZER_DESC
{
    D3D10_FILL_MODE FillMode;
    D3D10_CULL_MODE CullMode;
    BOOL FrontCounterClockwise;
    int DepthBias;
    float DepthBiasClamp;
    float SlopeScaledDepthBias;
    BOOL DepthClipEnable;
    BOOL ScissorEnable;
    BOOL MultisampleEnable;
    BOOL AntialiasedLineEnable;
}

const GUID IID_ID3D10RasterizerState = {0xA2A07292, 0x89AF, 0x4345, [0xBE, 0x2E, 0xC5, 0x3D, 0x9F, 0xBB, 0x6E, 0x9F]};
@GUID(0xA2A07292, 0x89AF, 0x4345, [0xBE, 0x2E, 0xC5, 0x3D, 0x9F, 0xBB, 0x6E, 0x9F]);
interface ID3D10RasterizerState : ID3D10DeviceChild
{
    void GetDesc(D3D10_RASTERIZER_DESC* pDesc);
}

struct D3D10_SUBRESOURCE_DATA
{
    const(void)* pSysMem;
    uint SysMemPitch;
    uint SysMemSlicePitch;
}

const GUID IID_ID3D10Resource = {0x9B7E4C01, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C01, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Resource : ID3D10DeviceChild
{
    void GetType(D3D10_RESOURCE_DIMENSION* rType);
    void SetEvictionPriority(uint EvictionPriority);
    uint GetEvictionPriority();
}

struct D3D10_BUFFER_DESC
{
    uint ByteWidth;
    D3D10_USAGE Usage;
    uint BindFlags;
    uint CPUAccessFlags;
    uint MiscFlags;
}

const GUID IID_ID3D10Buffer = {0x9B7E4C02, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C02, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Buffer : ID3D10Resource
{
    HRESULT Map(D3D10_MAP MapType, uint MapFlags, void** ppData);
    void Unmap();
    void GetDesc(D3D10_BUFFER_DESC* pDesc);
}

struct D3D10_TEXTURE1D_DESC
{
    uint Width;
    uint MipLevels;
    uint ArraySize;
    DXGI_FORMAT Format;
    D3D10_USAGE Usage;
    uint BindFlags;
    uint CPUAccessFlags;
    uint MiscFlags;
}

const GUID IID_ID3D10Texture1D = {0x9B7E4C03, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C03, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Texture1D : ID3D10Resource
{
    HRESULT Map(uint Subresource, D3D10_MAP MapType, uint MapFlags, void** ppData);
    void Unmap(uint Subresource);
    void GetDesc(D3D10_TEXTURE1D_DESC* pDesc);
}

struct D3D10_TEXTURE2D_DESC
{
    uint Width;
    uint Height;
    uint MipLevels;
    uint ArraySize;
    DXGI_FORMAT Format;
    DXGI_SAMPLE_DESC SampleDesc;
    D3D10_USAGE Usage;
    uint BindFlags;
    uint CPUAccessFlags;
    uint MiscFlags;
}

struct D3D10_MAPPED_TEXTURE2D
{
    void* pData;
    uint RowPitch;
}

const GUID IID_ID3D10Texture2D = {0x9B7E4C04, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C04, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Texture2D : ID3D10Resource
{
    HRESULT Map(uint Subresource, D3D10_MAP MapType, uint MapFlags, D3D10_MAPPED_TEXTURE2D* pMappedTex2D);
    void Unmap(uint Subresource);
    void GetDesc(D3D10_TEXTURE2D_DESC* pDesc);
}

struct D3D10_TEXTURE3D_DESC
{
    uint Width;
    uint Height;
    uint Depth;
    uint MipLevels;
    DXGI_FORMAT Format;
    D3D10_USAGE Usage;
    uint BindFlags;
    uint CPUAccessFlags;
    uint MiscFlags;
}

struct D3D10_MAPPED_TEXTURE3D
{
    void* pData;
    uint RowPitch;
    uint DepthPitch;
}

const GUID IID_ID3D10Texture3D = {0x9B7E4C05, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C05, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Texture3D : ID3D10Resource
{
    HRESULT Map(uint Subresource, D3D10_MAP MapType, uint MapFlags, D3D10_MAPPED_TEXTURE3D* pMappedTex3D);
    void Unmap(uint Subresource);
    void GetDesc(D3D10_TEXTURE3D_DESC* pDesc);
}

enum D3D10_TEXTURECUBE_FACE
{
    D3D10_TEXTURECUBE_FACE_POSITIVE_X = 0,
    D3D10_TEXTURECUBE_FACE_NEGATIVE_X = 1,
    D3D10_TEXTURECUBE_FACE_POSITIVE_Y = 2,
    D3D10_TEXTURECUBE_FACE_NEGATIVE_Y = 3,
    D3D10_TEXTURECUBE_FACE_POSITIVE_Z = 4,
    D3D10_TEXTURECUBE_FACE_NEGATIVE_Z = 5,
}

const GUID IID_ID3D10View = {0xC902B03F, 0x60A7, 0x49BA, [0x99, 0x36, 0x2A, 0x3A, 0xB3, 0x7A, 0x7E, 0x33]};
@GUID(0xC902B03F, 0x60A7, 0x49BA, [0x99, 0x36, 0x2A, 0x3A, 0xB3, 0x7A, 0x7E, 0x33]);
interface ID3D10View : ID3D10DeviceChild
{
    void GetResource(ID3D10Resource* ppResource);
}

struct D3D10_BUFFER_SRV
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct D3D10_TEX1D_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
}

struct D3D10_TEX1D_ARRAY_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
    uint FirstArraySlice;
    uint ArraySize;
}

struct D3D10_TEX2D_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
}

struct D3D10_TEX2D_ARRAY_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
    uint FirstArraySlice;
    uint ArraySize;
}

struct D3D10_TEX3D_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
}

struct D3D10_TEXCUBE_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
}

struct D3D10_TEX2DMS_SRV
{
    uint UnusedField_NothingToDefine;
}

struct D3D10_TEX2DMS_ARRAY_SRV
{
    uint FirstArraySlice;
    uint ArraySize;
}

struct D3D10_SHADER_RESOURCE_VIEW_DESC
{
    DXGI_FORMAT Format;
    D3D_SRV_DIMENSION ViewDimension;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_ID3D10ShaderResourceView = {0x9B7E4C07, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C07, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10ShaderResourceView : ID3D10View
{
    void GetDesc(D3D10_SHADER_RESOURCE_VIEW_DESC* pDesc);
}

struct D3D10_BUFFER_RTV
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct D3D10_TEX1D_RTV
{
    uint MipSlice;
}

struct D3D10_TEX1D_ARRAY_RTV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

struct D3D10_TEX2D_RTV
{
    uint MipSlice;
}

struct D3D10_TEX2DMS_RTV
{
    uint UnusedField_NothingToDefine;
}

struct D3D10_TEX2D_ARRAY_RTV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

struct D3D10_TEX2DMS_ARRAY_RTV
{
    uint FirstArraySlice;
    uint ArraySize;
}

struct D3D10_TEX3D_RTV
{
    uint MipSlice;
    uint FirstWSlice;
    uint WSize;
}

struct D3D10_RENDER_TARGET_VIEW_DESC
{
    DXGI_FORMAT Format;
    D3D10_RTV_DIMENSION ViewDimension;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_ID3D10RenderTargetView = {0x9B7E4C08, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C08, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10RenderTargetView : ID3D10View
{
    void GetDesc(D3D10_RENDER_TARGET_VIEW_DESC* pDesc);
}

struct D3D10_TEX1D_DSV
{
    uint MipSlice;
}

struct D3D10_TEX1D_ARRAY_DSV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

struct D3D10_TEX2D_DSV
{
    uint MipSlice;
}

struct D3D10_TEX2D_ARRAY_DSV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

struct D3D10_TEX2DMS_DSV
{
    uint UnusedField_NothingToDefine;
}

struct D3D10_TEX2DMS_ARRAY_DSV
{
    uint FirstArraySlice;
    uint ArraySize;
}

struct D3D10_DEPTH_STENCIL_VIEW_DESC
{
    DXGI_FORMAT Format;
    D3D10_DSV_DIMENSION ViewDimension;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_ID3D10DepthStencilView = {0x9B7E4C09, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C09, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10DepthStencilView : ID3D10View
{
    void GetDesc(D3D10_DEPTH_STENCIL_VIEW_DESC* pDesc);
}

const GUID IID_ID3D10VertexShader = {0x9B7E4C0A, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C0A, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10VertexShader : ID3D10DeviceChild
{
}

const GUID IID_ID3D10GeometryShader = {0x6316BE88, 0x54CD, 0x4040, [0xAB, 0x44, 0x20, 0x46, 0x1B, 0xC8, 0x1F, 0x68]};
@GUID(0x6316BE88, 0x54CD, 0x4040, [0xAB, 0x44, 0x20, 0x46, 0x1B, 0xC8, 0x1F, 0x68]);
interface ID3D10GeometryShader : ID3D10DeviceChild
{
}

const GUID IID_ID3D10PixelShader = {0x4968B601, 0x9D00, 0x4CDE, [0x83, 0x46, 0x8E, 0x7F, 0x67, 0x58, 0x19, 0xB6]};
@GUID(0x4968B601, 0x9D00, 0x4CDE, [0x83, 0x46, 0x8E, 0x7F, 0x67, 0x58, 0x19, 0xB6]);
interface ID3D10PixelShader : ID3D10DeviceChild
{
}

const GUID IID_ID3D10InputLayout = {0x9B7E4C0B, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C0B, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10InputLayout : ID3D10DeviceChild
{
}

enum D3D10_FILTER
{
    D3D10_FILTER_MIN_MAG_MIP_POINT = 0,
    D3D10_FILTER_MIN_MAG_POINT_MIP_LINEAR = 1,
    D3D10_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT = 4,
    D3D10_FILTER_MIN_POINT_MAG_MIP_LINEAR = 5,
    D3D10_FILTER_MIN_LINEAR_MAG_MIP_POINT = 16,
    D3D10_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 17,
    D3D10_FILTER_MIN_MAG_LINEAR_MIP_POINT = 20,
    D3D10_FILTER_MIN_MAG_MIP_LINEAR = 21,
    D3D10_FILTER_ANISOTROPIC = 85,
    D3D10_FILTER_COMPARISON_MIN_MAG_MIP_POINT = 128,
    D3D10_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR = 129,
    D3D10_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT = 132,
    D3D10_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR = 133,
    D3D10_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT = 144,
    D3D10_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 145,
    D3D10_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT = 148,
    D3D10_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR = 149,
    D3D10_FILTER_COMPARISON_ANISOTROPIC = 213,
    D3D10_FILTER_TEXT_1BIT = -2147483648,
}

enum D3D10_FILTER_TYPE
{
    D3D10_FILTER_TYPE_POINT = 0,
    D3D10_FILTER_TYPE_LINEAR = 1,
}

enum D3D10_TEXTURE_ADDRESS_MODE
{
    D3D10_TEXTURE_ADDRESS_WRAP = 1,
    D3D10_TEXTURE_ADDRESS_MIRROR = 2,
    D3D10_TEXTURE_ADDRESS_CLAMP = 3,
    D3D10_TEXTURE_ADDRESS_BORDER = 4,
    D3D10_TEXTURE_ADDRESS_MIRROR_ONCE = 5,
}

struct D3D10_SAMPLER_DESC
{
    D3D10_FILTER Filter;
    D3D10_TEXTURE_ADDRESS_MODE AddressU;
    D3D10_TEXTURE_ADDRESS_MODE AddressV;
    D3D10_TEXTURE_ADDRESS_MODE AddressW;
    float MipLODBias;
    uint MaxAnisotropy;
    D3D10_COMPARISON_FUNC ComparisonFunc;
    float BorderColor;
    float MinLOD;
    float MaxLOD;
}

const GUID IID_ID3D10SamplerState = {0x9B7E4C0C, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C0C, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10SamplerState : ID3D10DeviceChild
{
    void GetDesc(D3D10_SAMPLER_DESC* pDesc);
}

enum D3D10_FORMAT_SUPPORT
{
    D3D10_FORMAT_SUPPORT_BUFFER = 1,
    D3D10_FORMAT_SUPPORT_IA_VERTEX_BUFFER = 2,
    D3D10_FORMAT_SUPPORT_IA_INDEX_BUFFER = 4,
    D3D10_FORMAT_SUPPORT_SO_BUFFER = 8,
    D3D10_FORMAT_SUPPORT_TEXTURE1D = 16,
    D3D10_FORMAT_SUPPORT_TEXTURE2D = 32,
    D3D10_FORMAT_SUPPORT_TEXTURE3D = 64,
    D3D10_FORMAT_SUPPORT_TEXTURECUBE = 128,
    D3D10_FORMAT_SUPPORT_SHADER_LOAD = 256,
    D3D10_FORMAT_SUPPORT_SHADER_SAMPLE = 512,
    D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON = 1024,
    D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT = 2048,
    D3D10_FORMAT_SUPPORT_MIP = 4096,
    D3D10_FORMAT_SUPPORT_MIP_AUTOGEN = 8192,
    D3D10_FORMAT_SUPPORT_RENDER_TARGET = 16384,
    D3D10_FORMAT_SUPPORT_BLENDABLE = 32768,
    D3D10_FORMAT_SUPPORT_DEPTH_STENCIL = 65536,
    D3D10_FORMAT_SUPPORT_CPU_LOCKABLE = 131072,
    D3D10_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE = 262144,
    D3D10_FORMAT_SUPPORT_DISPLAY = 524288,
    D3D10_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT = 1048576,
    D3D10_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET = 2097152,
    D3D10_FORMAT_SUPPORT_MULTISAMPLE_LOAD = 4194304,
    D3D10_FORMAT_SUPPORT_SHADER_GATHER = 8388608,
    D3D10_FORMAT_SUPPORT_BACK_BUFFER_CAST = 16777216,
}

const GUID IID_ID3D10Asynchronous = {0x9B7E4C0D, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C0D, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Asynchronous : ID3D10DeviceChild
{
    void Begin();
    void End();
    HRESULT GetData(char* pData, uint DataSize, uint GetDataFlags);
    uint GetDataSize();
}

enum D3D10_ASYNC_GETDATA_FLAG
{
    D3D10_ASYNC_GETDATA_DONOTFLUSH = 1,
}

enum D3D10_QUERY
{
    D3D10_QUERY_EVENT = 0,
    D3D10_QUERY_OCCLUSION = 1,
    D3D10_QUERY_TIMESTAMP = 2,
    D3D10_QUERY_TIMESTAMP_DISJOINT = 3,
    D3D10_QUERY_PIPELINE_STATISTICS = 4,
    D3D10_QUERY_OCCLUSION_PREDICATE = 5,
    D3D10_QUERY_SO_STATISTICS = 6,
    D3D10_QUERY_SO_OVERFLOW_PREDICATE = 7,
}

enum D3D10_QUERY_MISC_FLAG
{
    D3D10_QUERY_MISC_PREDICATEHINT = 1,
}

struct D3D10_QUERY_DESC
{
    D3D10_QUERY Query;
    uint MiscFlags;
}

const GUID IID_ID3D10Query = {0x9B7E4C0E, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C0E, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Query : ID3D10Asynchronous
{
    void GetDesc(D3D10_QUERY_DESC* pDesc);
}

const GUID IID_ID3D10Predicate = {0x9B7E4C10, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C10, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Predicate : ID3D10Query
{
}

struct D3D10_QUERY_DATA_TIMESTAMP_DISJOINT
{
    ulong Frequency;
    BOOL Disjoint;
}

struct D3D10_QUERY_DATA_PIPELINE_STATISTICS
{
    ulong IAVertices;
    ulong IAPrimitives;
    ulong VSInvocations;
    ulong GSInvocations;
    ulong GSPrimitives;
    ulong CInvocations;
    ulong CPrimitives;
    ulong PSInvocations;
}

struct D3D10_QUERY_DATA_SO_STATISTICS
{
    ulong NumPrimitivesWritten;
    ulong PrimitivesStorageNeeded;
}

enum D3D10_COUNTER
{
    D3D10_COUNTER_GPU_IDLE = 0,
    D3D10_COUNTER_VERTEX_PROCESSING = 1,
    D3D10_COUNTER_GEOMETRY_PROCESSING = 2,
    D3D10_COUNTER_PIXEL_PROCESSING = 3,
    D3D10_COUNTER_OTHER_GPU_PROCESSING = 4,
    D3D10_COUNTER_HOST_ADAPTER_BANDWIDTH_UTILIZATION = 5,
    D3D10_COUNTER_LOCAL_VIDMEM_BANDWIDTH_UTILIZATION = 6,
    D3D10_COUNTER_VERTEX_THROUGHPUT_UTILIZATION = 7,
    D3D10_COUNTER_TRIANGLE_SETUP_THROUGHPUT_UTILIZATION = 8,
    D3D10_COUNTER_FILLRATE_THROUGHPUT_UTILIZATION = 9,
    D3D10_COUNTER_VS_MEMORY_LIMITED = 10,
    D3D10_COUNTER_VS_COMPUTATION_LIMITED = 11,
    D3D10_COUNTER_GS_MEMORY_LIMITED = 12,
    D3D10_COUNTER_GS_COMPUTATION_LIMITED = 13,
    D3D10_COUNTER_PS_MEMORY_LIMITED = 14,
    D3D10_COUNTER_PS_COMPUTATION_LIMITED = 15,
    D3D10_COUNTER_POST_TRANSFORM_CACHE_HIT_RATE = 16,
    D3D10_COUNTER_TEXTURE_CACHE_HIT_RATE = 17,
    D3D10_COUNTER_DEVICE_DEPENDENT_0 = 1073741824,
}

enum D3D10_COUNTER_TYPE
{
    D3D10_COUNTER_TYPE_FLOAT32 = 0,
    D3D10_COUNTER_TYPE_UINT16 = 1,
    D3D10_COUNTER_TYPE_UINT32 = 2,
    D3D10_COUNTER_TYPE_UINT64 = 3,
}

struct D3D10_COUNTER_DESC
{
    D3D10_COUNTER Counter;
    uint MiscFlags;
}

struct D3D10_COUNTER_INFO
{
    D3D10_COUNTER LastDeviceDependentCounter;
    uint NumSimultaneousCounters;
    ubyte NumDetectableParallelUnits;
}

const GUID IID_ID3D10Counter = {0x9B7E4C11, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C11, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Counter : ID3D10Asynchronous
{
    void GetDesc(D3D10_COUNTER_DESC* pDesc);
}

const GUID IID_ID3D10Device = {0x9B7E4C0F, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C0F, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Device : IUnknown
{
    void VSSetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    void PSSetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    void PSSetShader(ID3D10PixelShader pPixelShader);
    void PSSetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    void VSSetShader(ID3D10VertexShader pVertexShader);
    void DrawIndexed(uint IndexCount, uint StartIndexLocation, int BaseVertexLocation);
    void Draw(uint VertexCount, uint StartVertexLocation);
    void PSSetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    void IASetInputLayout(ID3D10InputLayout pInputLayout);
    void IASetVertexBuffers(uint StartSlot, uint NumBuffers, char* ppVertexBuffers, char* pStrides, char* pOffsets);
    void IASetIndexBuffer(ID3D10Buffer pIndexBuffer, DXGI_FORMAT Format, uint Offset);
    void DrawIndexedInstanced(uint IndexCountPerInstance, uint InstanceCount, uint StartIndexLocation, int BaseVertexLocation, uint StartInstanceLocation);
    void DrawInstanced(uint VertexCountPerInstance, uint InstanceCount, uint StartVertexLocation, uint StartInstanceLocation);
    void GSSetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    void GSSetShader(ID3D10GeometryShader pShader);
    void IASetPrimitiveTopology(D3D_PRIMITIVE_TOPOLOGY Topology);
    void VSSetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    void VSSetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    void SetPredication(ID3D10Predicate pPredicate, BOOL PredicateValue);
    void GSSetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    void GSSetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    void OMSetRenderTargets(uint NumViews, char* ppRenderTargetViews, ID3D10DepthStencilView pDepthStencilView);
    void OMSetBlendState(ID3D10BlendState pBlendState, const(float)* BlendFactor, uint SampleMask);
    void OMSetDepthStencilState(ID3D10DepthStencilState pDepthStencilState, uint StencilRef);
    void SOSetTargets(uint NumBuffers, char* ppSOTargets, char* pOffsets);
    void DrawAuto();
    void RSSetState(ID3D10RasterizerState pRasterizerState);
    void RSSetViewports(uint NumViewports, char* pViewports);
    void RSSetScissorRects(uint NumRects, char* pRects);
    void CopySubresourceRegion(ID3D10Resource pDstResource, uint DstSubresource, uint DstX, uint DstY, uint DstZ, ID3D10Resource pSrcResource, uint SrcSubresource, const(D3D10_BOX)* pSrcBox);
    void CopyResource(ID3D10Resource pDstResource, ID3D10Resource pSrcResource);
    void UpdateSubresource(ID3D10Resource pDstResource, uint DstSubresource, const(D3D10_BOX)* pDstBox, const(void)* pSrcData, uint SrcRowPitch, uint SrcDepthPitch);
    void ClearRenderTargetView(ID3D10RenderTargetView pRenderTargetView, const(float)* ColorRGBA);
    void ClearDepthStencilView(ID3D10DepthStencilView pDepthStencilView, uint ClearFlags, float Depth, ubyte Stencil);
    void GenerateMips(ID3D10ShaderResourceView pShaderResourceView);
    void ResolveSubresource(ID3D10Resource pDstResource, uint DstSubresource, ID3D10Resource pSrcResource, uint SrcSubresource, DXGI_FORMAT Format);
    void VSGetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    void PSGetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    void PSGetShader(ID3D10PixelShader* ppPixelShader);
    void PSGetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    void VSGetShader(ID3D10VertexShader* ppVertexShader);
    void PSGetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    void IAGetInputLayout(ID3D10InputLayout* ppInputLayout);
    void IAGetVertexBuffers(uint StartSlot, uint NumBuffers, char* ppVertexBuffers, char* pStrides, char* pOffsets);
    void IAGetIndexBuffer(ID3D10Buffer* pIndexBuffer, DXGI_FORMAT* Format, uint* Offset);
    void GSGetConstantBuffers(uint StartSlot, uint NumBuffers, char* ppConstantBuffers);
    void GSGetShader(ID3D10GeometryShader* ppGeometryShader);
    void IAGetPrimitiveTopology(D3D_PRIMITIVE_TOPOLOGY* pTopology);
    void VSGetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    void VSGetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    void GetPredication(ID3D10Predicate* ppPredicate, int* pPredicateValue);
    void GSGetShaderResources(uint StartSlot, uint NumViews, char* ppShaderResourceViews);
    void GSGetSamplers(uint StartSlot, uint NumSamplers, char* ppSamplers);
    void OMGetRenderTargets(uint NumViews, char* ppRenderTargetViews, ID3D10DepthStencilView* ppDepthStencilView);
    void OMGetBlendState(ID3D10BlendState* ppBlendState, float* BlendFactor, uint* pSampleMask);
    void OMGetDepthStencilState(ID3D10DepthStencilState* ppDepthStencilState, uint* pStencilRef);
    void SOGetTargets(uint NumBuffers, char* ppSOTargets, char* pOffsets);
    void RSGetState(ID3D10RasterizerState* ppRasterizerState);
    void RSGetViewports(uint* NumViewports, char* pViewports);
    void RSGetScissorRects(uint* NumRects, char* pRects);
    HRESULT GetDeviceRemovedReason();
    HRESULT SetExceptionMode(uint RaiseFlags);
    uint GetExceptionMode();
    HRESULT GetPrivateData(const(Guid)* guid, uint* pDataSize, char* pData);
    HRESULT SetPrivateData(const(Guid)* guid, uint DataSize, char* pData);
    HRESULT SetPrivateDataInterface(const(Guid)* guid, const(IUnknown) pData);
    void ClearState();
    void Flush();
    HRESULT CreateBuffer(const(D3D10_BUFFER_DESC)* pDesc, const(D3D10_SUBRESOURCE_DATA)* pInitialData, ID3D10Buffer* ppBuffer);
    HRESULT CreateTexture1D(const(D3D10_TEXTURE1D_DESC)* pDesc, char* pInitialData, ID3D10Texture1D* ppTexture1D);
    HRESULT CreateTexture2D(const(D3D10_TEXTURE2D_DESC)* pDesc, char* pInitialData, ID3D10Texture2D* ppTexture2D);
    HRESULT CreateTexture3D(const(D3D10_TEXTURE3D_DESC)* pDesc, char* pInitialData, ID3D10Texture3D* ppTexture3D);
    HRESULT CreateShaderResourceView(ID3D10Resource pResource, const(D3D10_SHADER_RESOURCE_VIEW_DESC)* pDesc, ID3D10ShaderResourceView* ppSRView);
    HRESULT CreateRenderTargetView(ID3D10Resource pResource, const(D3D10_RENDER_TARGET_VIEW_DESC)* pDesc, ID3D10RenderTargetView* ppRTView);
    HRESULT CreateDepthStencilView(ID3D10Resource pResource, const(D3D10_DEPTH_STENCIL_VIEW_DESC)* pDesc, ID3D10DepthStencilView* ppDepthStencilView);
    HRESULT CreateInputLayout(char* pInputElementDescs, uint NumElements, char* pShaderBytecodeWithInputSignature, uint BytecodeLength, ID3D10InputLayout* ppInputLayout);
    HRESULT CreateVertexShader(char* pShaderBytecode, uint BytecodeLength, ID3D10VertexShader* ppVertexShader);
    HRESULT CreateGeometryShader(char* pShaderBytecode, uint BytecodeLength, ID3D10GeometryShader* ppGeometryShader);
    HRESULT CreateGeometryShaderWithStreamOutput(char* pShaderBytecode, uint BytecodeLength, char* pSODeclaration, uint NumEntries, uint OutputStreamStride, ID3D10GeometryShader* ppGeometryShader);
    HRESULT CreatePixelShader(char* pShaderBytecode, uint BytecodeLength, ID3D10PixelShader* ppPixelShader);
    HRESULT CreateBlendState(const(D3D10_BLEND_DESC)* pBlendStateDesc, ID3D10BlendState* ppBlendState);
    HRESULT CreateDepthStencilState(const(D3D10_DEPTH_STENCIL_DESC)* pDepthStencilDesc, ID3D10DepthStencilState* ppDepthStencilState);
    HRESULT CreateRasterizerState(const(D3D10_RASTERIZER_DESC)* pRasterizerDesc, ID3D10RasterizerState* ppRasterizerState);
    HRESULT CreateSamplerState(const(D3D10_SAMPLER_DESC)* pSamplerDesc, ID3D10SamplerState* ppSamplerState);
    HRESULT CreateQuery(const(D3D10_QUERY_DESC)* pQueryDesc, ID3D10Query* ppQuery);
    HRESULT CreatePredicate(const(D3D10_QUERY_DESC)* pPredicateDesc, ID3D10Predicate* ppPredicate);
    HRESULT CreateCounter(const(D3D10_COUNTER_DESC)* pCounterDesc, ID3D10Counter* ppCounter);
    HRESULT CheckFormatSupport(DXGI_FORMAT Format, uint* pFormatSupport);
    HRESULT CheckMultisampleQualityLevels(DXGI_FORMAT Format, uint SampleCount, uint* pNumQualityLevels);
    void CheckCounterInfo(D3D10_COUNTER_INFO* pCounterInfo);
    HRESULT CheckCounter(const(D3D10_COUNTER_DESC)* pDesc, D3D10_COUNTER_TYPE* pType, uint* pActiveCounters, const(char)* szName, uint* pNameLength, const(char)* szUnits, uint* pUnitsLength, const(char)* szDescription, uint* pDescriptionLength);
    uint GetCreationFlags();
    HRESULT OpenSharedResource(HANDLE hResource, const(Guid)* ReturnedInterface, void** ppResource);
    void SetTextFilterSize(uint Width, uint Height);
    void GetTextFilterSize(uint* pWidth, uint* pHeight);
}

const GUID IID_ID3D10Multithread = {0x9B7E4E00, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4E00, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Multithread : IUnknown
{
    void Enter();
    void Leave();
    BOOL SetMultithreadProtected(BOOL bMTProtect);
    BOOL GetMultithreadProtected();
}

enum D3D10_CREATE_DEVICE_FLAG
{
    D3D10_CREATE_DEVICE_SINGLETHREADED = 1,
    D3D10_CREATE_DEVICE_DEBUG = 2,
    D3D10_CREATE_DEVICE_SWITCH_TO_REF = 4,
    D3D10_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS = 8,
    D3D10_CREATE_DEVICE_ALLOW_NULL_FROM_MAP = 16,
    D3D10_CREATE_DEVICE_BGRA_SUPPORT = 32,
    D3D10_CREATE_DEVICE_PREVENT_ALTERING_LAYER_SETTINGS_FROM_REGISTRY = 128,
    D3D10_CREATE_DEVICE_STRICT_VALIDATION = 512,
    D3D10_CREATE_DEVICE_DEBUGGABLE = 1024,
}

const GUID IID_ID3D10Debug = {0x9B7E4E01, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4E01, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Debug : IUnknown
{
    HRESULT SetFeatureMask(uint Mask);
    uint GetFeatureMask();
    HRESULT SetPresentPerRenderOpDelay(uint Milliseconds);
    uint GetPresentPerRenderOpDelay();
    HRESULT SetSwapChain(IDXGISwapChain pSwapChain);
    HRESULT GetSwapChain(IDXGISwapChain* ppSwapChain);
    HRESULT Validate();
}

const GUID IID_ID3D10SwitchToRef = {0x9B7E4E02, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4E02, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10SwitchToRef : IUnknown
{
    BOOL SetUseRef(BOOL UseRef);
    BOOL GetUseRef();
}

enum D3D10_MESSAGE_CATEGORY
{
    D3D10_MESSAGE_CATEGORY_APPLICATION_DEFINED = 0,
    D3D10_MESSAGE_CATEGORY_MISCELLANEOUS = 1,
    D3D10_MESSAGE_CATEGORY_INITIALIZATION = 2,
    D3D10_MESSAGE_CATEGORY_CLEANUP = 3,
    D3D10_MESSAGE_CATEGORY_COMPILATION = 4,
    D3D10_MESSAGE_CATEGORY_STATE_CREATION = 5,
    D3D10_MESSAGE_CATEGORY_STATE_SETTING = 6,
    D3D10_MESSAGE_CATEGORY_STATE_GETTING = 7,
    D3D10_MESSAGE_CATEGORY_RESOURCE_MANIPULATION = 8,
    D3D10_MESSAGE_CATEGORY_EXECUTION = 9,
    D3D10_MESSAGE_CATEGORY_SHADER = 10,
}

enum D3D10_MESSAGE_SEVERITY
{
    D3D10_MESSAGE_SEVERITY_CORRUPTION = 0,
    D3D10_MESSAGE_SEVERITY_ERROR = 1,
    D3D10_MESSAGE_SEVERITY_WARNING = 2,
    D3D10_MESSAGE_SEVERITY_INFO = 3,
    D3D10_MESSAGE_SEVERITY_MESSAGE = 4,
}

enum D3D10_MESSAGE_ID
{
    D3D10_MESSAGE_ID_UNKNOWN = 0,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_HAZARD = 1,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_HAZARD = 2,
    D3D10_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_HAZARD = 3,
    D3D10_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_HAZARD = 4,
    D3D10_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_HAZARD = 5,
    D3D10_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_HAZARD = 6,
    D3D10_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_HAZARD = 7,
    D3D10_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_HAZARD = 8,
    D3D10_MESSAGE_ID_DEVICE_OMSETRENDERTARGETS_HAZARD = 9,
    D3D10_MESSAGE_ID_DEVICE_SOSETTARGETS_HAZARD = 10,
    D3D10_MESSAGE_ID_STRING_FROM_APPLICATION = 11,
    D3D10_MESSAGE_ID_CORRUPTED_THIS = 12,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER1 = 13,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER2 = 14,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER3 = 15,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER4 = 16,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER5 = 17,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER6 = 18,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER7 = 19,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER8 = 20,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER9 = 21,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER10 = 22,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER11 = 23,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER12 = 24,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER13 = 25,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER14 = 26,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER15 = 27,
    D3D10_MESSAGE_ID_CORRUPTED_MULTITHREADING = 28,
    D3D10_MESSAGE_ID_MESSAGE_REPORTING_OUTOFMEMORY = 29,
    D3D10_MESSAGE_ID_IASETINPUTLAYOUT_UNBINDDELETINGOBJECT = 30,
    D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_UNBINDDELETINGOBJECT = 31,
    D3D10_MESSAGE_ID_IASETINDEXBUFFER_UNBINDDELETINGOBJECT = 32,
    D3D10_MESSAGE_ID_VSSETSHADER_UNBINDDELETINGOBJECT = 33,
    D3D10_MESSAGE_ID_VSSETSHADERRESOURCES_UNBINDDELETINGOBJECT = 34,
    D3D10_MESSAGE_ID_VSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT = 35,
    D3D10_MESSAGE_ID_VSSETSAMPLERS_UNBINDDELETINGOBJECT = 36,
    D3D10_MESSAGE_ID_GSSETSHADER_UNBINDDELETINGOBJECT = 37,
    D3D10_MESSAGE_ID_GSSETSHADERRESOURCES_UNBINDDELETINGOBJECT = 38,
    D3D10_MESSAGE_ID_GSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT = 39,
    D3D10_MESSAGE_ID_GSSETSAMPLERS_UNBINDDELETINGOBJECT = 40,
    D3D10_MESSAGE_ID_SOSETTARGETS_UNBINDDELETINGOBJECT = 41,
    D3D10_MESSAGE_ID_PSSETSHADER_UNBINDDELETINGOBJECT = 42,
    D3D10_MESSAGE_ID_PSSETSHADERRESOURCES_UNBINDDELETINGOBJECT = 43,
    D3D10_MESSAGE_ID_PSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT = 44,
    D3D10_MESSAGE_ID_PSSETSAMPLERS_UNBINDDELETINGOBJECT = 45,
    D3D10_MESSAGE_ID_RSSETSTATE_UNBINDDELETINGOBJECT = 46,
    D3D10_MESSAGE_ID_OMSETBLENDSTATE_UNBINDDELETINGOBJECT = 47,
    D3D10_MESSAGE_ID_OMSETDEPTHSTENCILSTATE_UNBINDDELETINGOBJECT = 48,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_UNBINDDELETINGOBJECT = 49,
    D3D10_MESSAGE_ID_SETPREDICATION_UNBINDDELETINGOBJECT = 50,
    D3D10_MESSAGE_ID_GETPRIVATEDATA_MOREDATA = 51,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDFREEDATA = 52,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDIUNKNOWN = 53,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDFLAGS = 54,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_CHANGINGPARAMS = 55,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_OUTOFMEMORY = 56,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDFORMAT = 57,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDSAMPLES = 58,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDUSAGE = 59,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDBINDFLAGS = 60,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDCPUACCESSFLAGS = 61,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDMISCFLAGS = 62,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDCPUACCESSFLAGS = 63,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDBINDFLAGS = 64,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDINITIALDATA = 65,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDDIMENSIONS = 66,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDMIPLEVELS = 67,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDMISCFLAGS = 68,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDARG_RETURN = 69,
    D3D10_MESSAGE_ID_CREATEBUFFER_OUTOFMEMORY_RETURN = 70,
    D3D10_MESSAGE_ID_CREATEBUFFER_NULLDESC = 71,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDCONSTANTBUFFERBINDINGS = 72,
    D3D10_MESSAGE_ID_CREATEBUFFER_LARGEALLOCATION = 73,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDFORMAT = 74,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNSUPPORTEDFORMAT = 75,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDSAMPLES = 76,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDUSAGE = 77,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDBINDFLAGS = 78,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDCPUACCESSFLAGS = 79,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDMISCFLAGS = 80,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDCPUACCESSFLAGS = 81,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDBINDFLAGS = 82,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDINITIALDATA = 83,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDDIMENSIONS = 84,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDMIPLEVELS = 85,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDMISCFLAGS = 86,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDARG_RETURN = 87,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_OUTOFMEMORY_RETURN = 88,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_NULLDESC = 89,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_LARGEALLOCATION = 90,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDFORMAT = 91,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNSUPPORTEDFORMAT = 92,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDSAMPLES = 93,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDUSAGE = 94,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDBINDFLAGS = 95,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDCPUACCESSFLAGS = 96,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDMISCFLAGS = 97,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDCPUACCESSFLAGS = 98,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDBINDFLAGS = 99,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDINITIALDATA = 100,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDDIMENSIONS = 101,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDMIPLEVELS = 102,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDMISCFLAGS = 103,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDARG_RETURN = 104,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_OUTOFMEMORY_RETURN = 105,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_NULLDESC = 106,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_LARGEALLOCATION = 107,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDFORMAT = 108,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNSUPPORTEDFORMAT = 109,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDSAMPLES = 110,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDUSAGE = 111,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDBINDFLAGS = 112,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDCPUACCESSFLAGS = 113,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDMISCFLAGS = 114,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDCPUACCESSFLAGS = 115,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDBINDFLAGS = 116,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDINITIALDATA = 117,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDDIMENSIONS = 118,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDMIPLEVELS = 119,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDMISCFLAGS = 120,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDARG_RETURN = 121,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_OUTOFMEMORY_RETURN = 122,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_NULLDESC = 123,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_LARGEALLOCATION = 124,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT = 125,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDESC = 126,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFORMAT = 127,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS = 128,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDRESOURCE = 129,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_TOOMANYOBJECTS = 130,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDARG_RETURN = 131,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_OUTOFMEMORY_RETURN = 132,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT = 133,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT = 134,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDESC = 135,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDFORMAT = 136,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDIMENSIONS = 137,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDRESOURCE = 138,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_TOOMANYOBJECTS = 139,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDARG_RETURN = 140,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_OUTOFMEMORY_RETURN = 141,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT = 142,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDESC = 143,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFORMAT = 144,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS = 145,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE = 146,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_TOOMANYOBJECTS = 147,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDARG_RETURN = 148,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_OUTOFMEMORY_RETURN = 149,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_OUTOFMEMORY = 150,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TOOMANYELEMENTS = 151,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDFORMAT = 152,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT = 153,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOT = 154,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS = 155,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH = 156,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE = 157,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE = 158,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDALIGNMENT = 159,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_DUPLICATESEMANTIC = 160,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE = 161,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_NULLSEMANTIC = 162,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_MISSINGELEMENT = 163,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_NULLDESC = 164,
    D3D10_MESSAGE_ID_CREATEVERTEXSHADER_OUTOFMEMORY = 165,
    D3D10_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERBYTECODE = 166,
    D3D10_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERTYPE = 167,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_OUTOFMEMORY = 168,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE = 169,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERTYPE = 170,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY = 171,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE = 172,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE = 173,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES = 174,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED = 175,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDDECL = 176,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_EXPECTEDDECL = 177,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED = 178,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT = 179,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT = 180,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT = 181,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT = 182,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION = 183,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT = 184,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE = 185,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC = 186,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH = 187,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS = 188,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX = 189,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE = 190,
    D3D10_MESSAGE_ID_CREATEPIXELSHADER_OUTOFMEMORY = 191,
    D3D10_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERBYTECODE = 192,
    D3D10_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERTYPE = 193,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFILLMODE = 194,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDCULLMODE = 195,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP = 196,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS = 197,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_TOOMANYOBJECTS = 198,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_NULLDESC = 199,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK = 200,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC = 201,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP = 202,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP = 203,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP = 204,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC = 205,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP = 206,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP = 207,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP = 208,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC = 209,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_TOOMANYOBJECTS = 210,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_NULLDESC = 211,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLEND = 212,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLEND = 213,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOP = 214,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLENDALPHA = 215,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLENDALPHA = 216,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOPALPHA = 217,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK = 218,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_TOOMANYOBJECTS = 219,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NULLDESC = 220,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDFILTER = 221,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSU = 222,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSV = 223,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSW = 224,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMIPLODBIAS = 225,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXANISOTROPY = 226,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDCOMPARISONFUNC = 227,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMINLOD = 228,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXLOD = 229,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_TOOMANYOBJECTS = 230,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NULLDESC = 231,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDQUERY = 232,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDMISCFLAGS = 233,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_UNEXPECTEDMISCFLAG = 234,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_NULLDESC = 235,
    D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNRECOGNIZED = 236,
    D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNDEFINED = 237,
    D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_INVALIDBUFFER = 238,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_OFFSET_TOO_LARGE = 239,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_BUFFERS_EMPTY = 240,
    D3D10_MESSAGE_ID_IASETINDEXBUFFER_INVALIDBUFFER = 241,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_FORMAT_INVALID = 242,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_TOO_LARGE = 243,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_UNALIGNED = 244,
    D3D10_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_VIEWS_EMPTY = 245,
    D3D10_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFER = 246,
    D3D10_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_BUFFERS_EMPTY = 247,
    D3D10_MESSAGE_ID_DEVICE_VSSETSAMPLERS_SAMPLERS_EMPTY = 248,
    D3D10_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_VIEWS_EMPTY = 249,
    D3D10_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFER = 250,
    D3D10_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_BUFFERS_EMPTY = 251,
    D3D10_MESSAGE_ID_DEVICE_GSSETSAMPLERS_SAMPLERS_EMPTY = 252,
    D3D10_MESSAGE_ID_SOSETTARGETS_INVALIDBUFFER = 253,
    D3D10_MESSAGE_ID_DEVICE_SOSETTARGETS_OFFSET_UNALIGNED = 254,
    D3D10_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_VIEWS_EMPTY = 255,
    D3D10_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFER = 256,
    D3D10_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_BUFFERS_EMPTY = 257,
    D3D10_MESSAGE_ID_DEVICE_PSSETSAMPLERS_SAMPLERS_EMPTY = 258,
    D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_INVALIDVIEWPORT = 259,
    D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_INVALIDSCISSOR = 260,
    D3D10_MESSAGE_ID_CLEARRENDERTARGETVIEW_DENORMFLUSH = 261,
    D3D10_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DENORMFLUSH = 262,
    D3D10_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_INVALID = 263,
    D3D10_MESSAGE_ID_DEVICE_IAGETVERTEXBUFFERS_BUFFERS_EMPTY = 264,
    D3D10_MESSAGE_ID_DEVICE_VSGETSHADERRESOURCES_VIEWS_EMPTY = 265,
    D3D10_MESSAGE_ID_DEVICE_VSGETCONSTANTBUFFERS_BUFFERS_EMPTY = 266,
    D3D10_MESSAGE_ID_DEVICE_VSGETSAMPLERS_SAMPLERS_EMPTY = 267,
    D3D10_MESSAGE_ID_DEVICE_GSGETSHADERRESOURCES_VIEWS_EMPTY = 268,
    D3D10_MESSAGE_ID_DEVICE_GSGETCONSTANTBUFFERS_BUFFERS_EMPTY = 269,
    D3D10_MESSAGE_ID_DEVICE_GSGETSAMPLERS_SAMPLERS_EMPTY = 270,
    D3D10_MESSAGE_ID_DEVICE_SOGETTARGETS_BUFFERS_EMPTY = 271,
    D3D10_MESSAGE_ID_DEVICE_PSGETSHADERRESOURCES_VIEWS_EMPTY = 272,
    D3D10_MESSAGE_ID_DEVICE_PSGETCONSTANTBUFFERS_BUFFERS_EMPTY = 273,
    D3D10_MESSAGE_ID_DEVICE_PSGETSAMPLERS_SAMPLERS_EMPTY = 274,
    D3D10_MESSAGE_ID_DEVICE_RSGETVIEWPORTS_VIEWPORTS_EMPTY = 275,
    D3D10_MESSAGE_ID_DEVICE_RSGETSCISSORRECTS_RECTS_EMPTY = 276,
    D3D10_MESSAGE_ID_DEVICE_GENERATEMIPS_RESOURCE_INVALID = 277,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSUBRESOURCE = 278,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESUBRESOURCE = 279,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCEBOX = 280,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCE = 281,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSTATE = 282,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESTATE = 283,
    D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCE = 284,
    D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDDESTINATIONSTATE = 285,
    D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCESTATE = 286,
    D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSUBRESOURCE = 287,
    D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONBOX = 288,
    D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSTATE = 289,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_INVALID = 290,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_SUBRESOURCE_INVALID = 291,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_INVALID = 292,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_SUBRESOURCE_INVALID = 293,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_FORMAT_INVALID = 294,
    D3D10_MESSAGE_ID_BUFFER_MAP_INVALIDMAPTYPE = 295,
    D3D10_MESSAGE_ID_BUFFER_MAP_INVALIDFLAGS = 296,
    D3D10_MESSAGE_ID_BUFFER_MAP_ALREADYMAPPED = 297,
    D3D10_MESSAGE_ID_BUFFER_MAP_DEVICEREMOVED_RETURN = 298,
    D3D10_MESSAGE_ID_BUFFER_UNMAP_NOTMAPPED = 299,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDMAPTYPE = 300,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDSUBRESOURCE = 301,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDFLAGS = 302,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_ALREADYMAPPED = 303,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_DEVICEREMOVED_RETURN = 304,
    D3D10_MESSAGE_ID_TEXTURE1D_UNMAP_INVALIDSUBRESOURCE = 305,
    D3D10_MESSAGE_ID_TEXTURE1D_UNMAP_NOTMAPPED = 306,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDMAPTYPE = 307,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDSUBRESOURCE = 308,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDFLAGS = 309,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_ALREADYMAPPED = 310,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_DEVICEREMOVED_RETURN = 311,
    D3D10_MESSAGE_ID_TEXTURE2D_UNMAP_INVALIDSUBRESOURCE = 312,
    D3D10_MESSAGE_ID_TEXTURE2D_UNMAP_NOTMAPPED = 313,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDMAPTYPE = 314,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDSUBRESOURCE = 315,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDFLAGS = 316,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_ALREADYMAPPED = 317,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_DEVICEREMOVED_RETURN = 318,
    D3D10_MESSAGE_ID_TEXTURE3D_UNMAP_INVALIDSUBRESOURCE = 319,
    D3D10_MESSAGE_ID_TEXTURE3D_UNMAP_NOTMAPPED = 320,
    D3D10_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_DEPRECATED = 321,
    D3D10_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_FORMAT_DEPRECATED = 322,
    D3D10_MESSAGE_ID_SETEXCEPTIONMODE_UNRECOGNIZEDFLAGS = 323,
    D3D10_MESSAGE_ID_SETEXCEPTIONMODE_INVALIDARG_RETURN = 324,
    D3D10_MESSAGE_ID_SETEXCEPTIONMODE_DEVICEREMOVED_RETURN = 325,
    D3D10_MESSAGE_ID_REF_SIMULATING_INFINITELY_FAST_HARDWARE = 326,
    D3D10_MESSAGE_ID_REF_THREADING_MODE = 327,
    D3D10_MESSAGE_ID_REF_UMDRIVER_EXCEPTION = 328,
    D3D10_MESSAGE_ID_REF_KMDRIVER_EXCEPTION = 329,
    D3D10_MESSAGE_ID_REF_HARDWARE_EXCEPTION = 330,
    D3D10_MESSAGE_ID_REF_ACCESSING_INDEXABLE_TEMP_OUT_OF_RANGE = 331,
    D3D10_MESSAGE_ID_REF_PROBLEM_PARSING_SHADER = 332,
    D3D10_MESSAGE_ID_REF_OUT_OF_MEMORY = 333,
    D3D10_MESSAGE_ID_REF_INFO = 334,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEXPOS_OVERFLOW = 335,
    D3D10_MESSAGE_ID_DEVICE_DRAWINDEXED_INDEXPOS_OVERFLOW = 336,
    D3D10_MESSAGE_ID_DEVICE_DRAWINSTANCED_VERTEXPOS_OVERFLOW = 337,
    D3D10_MESSAGE_ID_DEVICE_DRAWINSTANCED_INSTANCEPOS_OVERFLOW = 338,
    D3D10_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INSTANCEPOS_OVERFLOW = 339,
    D3D10_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INDEXPOS_OVERFLOW = 340,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_SHADER_NOT_SET = 341,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND = 342,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERINDEX = 343,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_COMPONENTTYPE = 344,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERMASK = 345,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SYSTEMVALUE = 346,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS = 347,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_NOT_SET = 348,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INPUTLAYOUT_NOT_SET = 349,
    D3D10_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_NOT_SET = 350,
    D3D10_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_TOO_SMALL = 351,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SAMPLER_NOT_SET = 352,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SHADERRESOURCEVIEW_NOT_SET = 353,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VIEW_DIMENSION_MISMATCH = 354,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL = 355,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_TOO_SMALL = 356,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_NOT_SET = 357,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_FORMAT_INVALID = 358,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_TOO_SMALL = 359,
    D3D10_MESSAGE_ID_DEVICE_DRAW_GS_INPUT_PRIMITIVE_MISMATCH = 360,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_RETURN_TYPE_MISMATCH = 361,
    D3D10_MESSAGE_ID_DEVICE_DRAW_POSITION_NOT_PRESENT = 362,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_NOT_SET = 363,
    D3D10_MESSAGE_ID_DEVICE_DRAW_BOUND_RESOURCE_MAPPED = 364,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INVALID_PRIMITIVETOPOLOGY = 365,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_OFFSET_UNALIGNED = 366,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_STRIDE_UNALIGNED = 367,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_OFFSET_UNALIGNED = 368,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_OFFSET_UNALIGNED = 369,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_LD_UNSUPPORTED = 370,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_UNSUPPORTED = 371,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_C_UNSUPPORTED = 372,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_MULTISAMPLE_UNSUPPORTED = 373,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SO_TARGETS_BOUND_WITHOUT_SOURCE = 374,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SO_STRIDE_LARGER_THAN_BUFFER = 375,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING = 376,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0 = 377,
    D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_AT_FAULT = 378,
    D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT = 379,
    D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT = 380,
    D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_INVALIDARG_RETURN = 381,
    D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_OUTOFMEMORY_RETURN = 382,
    D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BADINTERFACE_RETURN = 383,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VIEWPORT_NOT_SET = 384,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC = 385,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC = 386,
    D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_DENORMFLUSH = 387,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_INVALIDVIEW = 388,
    D3D10_MESSAGE_ID_DEVICE_SETTEXTFILTERSIZE_INVALIDDIMENSIONS = 389,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SAMPLER_MISMATCH = 390,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TYPE_MISMATCH = 391,
    D3D10_MESSAGE_ID_BLENDSTATE_GETDESC_LEGACY = 392,
    D3D10_MESSAGE_ID_SHADERRESOURCEVIEW_GETDESC_LEGACY = 393,
    D3D10_MESSAGE_ID_CREATEQUERY_OUTOFMEMORY_RETURN = 394,
    D3D10_MESSAGE_ID_CREATEPREDICATE_OUTOFMEMORY_RETURN = 395,
    D3D10_MESSAGE_ID_CREATECOUNTER_OUTOFRANGE_COUNTER = 396,
    D3D10_MESSAGE_ID_CREATECOUNTER_SIMULTANEOUS_ACTIVE_COUNTERS_EXHAUSTED = 397,
    D3D10_MESSAGE_ID_CREATECOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER = 398,
    D3D10_MESSAGE_ID_CREATECOUNTER_OUTOFMEMORY_RETURN = 399,
    D3D10_MESSAGE_ID_CREATECOUNTER_NONEXCLUSIVE_RETURN = 400,
    D3D10_MESSAGE_ID_CREATECOUNTER_NULLDESC = 401,
    D3D10_MESSAGE_ID_CHECKCOUNTER_OUTOFRANGE_COUNTER = 402,
    D3D10_MESSAGE_ID_CHECKCOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER = 403,
    D3D10_MESSAGE_ID_SETPREDICATION_INVALID_PREDICATE_STATE = 404,
    D3D10_MESSAGE_ID_QUERY_BEGIN_UNSUPPORTED = 405,
    D3D10_MESSAGE_ID_PREDICATE_BEGIN_DURING_PREDICATION = 406,
    D3D10_MESSAGE_ID_QUERY_BEGIN_DUPLICATE = 407,
    D3D10_MESSAGE_ID_QUERY_BEGIN_ABANDONING_PREVIOUS_RESULTS = 408,
    D3D10_MESSAGE_ID_PREDICATE_END_DURING_PREDICATION = 409,
    D3D10_MESSAGE_ID_QUERY_END_ABANDONING_PREVIOUS_RESULTS = 410,
    D3D10_MESSAGE_ID_QUERY_END_WITHOUT_BEGIN = 411,
    D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_DATASIZE = 412,
    D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_FLAGS = 413,
    D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_CALL = 414,
    D3D10_MESSAGE_ID_DEVICE_DRAW_PS_OUTPUT_TYPE_MISMATCH = 415,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_GATHER_UNSUPPORTED = 416,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN = 417,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_STRIDE_TOO_LARGE = 418,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_INVALIDRANGE = 419,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_EMPTY_LAYOUT = 420,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_SAMPLE_COUNT_MISMATCH = 421,
    D3D10_MESSAGE_ID_LIVE_OBJECT_SUMMARY = 422,
    D3D10_MESSAGE_ID_LIVE_BUFFER = 423,
    D3D10_MESSAGE_ID_LIVE_TEXTURE1D = 424,
    D3D10_MESSAGE_ID_LIVE_TEXTURE2D = 425,
    D3D10_MESSAGE_ID_LIVE_TEXTURE3D = 426,
    D3D10_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW = 427,
    D3D10_MESSAGE_ID_LIVE_RENDERTARGETVIEW = 428,
    D3D10_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW = 429,
    D3D10_MESSAGE_ID_LIVE_VERTEXSHADER = 430,
    D3D10_MESSAGE_ID_LIVE_GEOMETRYSHADER = 431,
    D3D10_MESSAGE_ID_LIVE_PIXELSHADER = 432,
    D3D10_MESSAGE_ID_LIVE_INPUTLAYOUT = 433,
    D3D10_MESSAGE_ID_LIVE_SAMPLER = 434,
    D3D10_MESSAGE_ID_LIVE_BLENDSTATE = 435,
    D3D10_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE = 436,
    D3D10_MESSAGE_ID_LIVE_RASTERIZERSTATE = 437,
    D3D10_MESSAGE_ID_LIVE_QUERY = 438,
    D3D10_MESSAGE_ID_LIVE_PREDICATE = 439,
    D3D10_MESSAGE_ID_LIVE_COUNTER = 440,
    D3D10_MESSAGE_ID_LIVE_DEVICE = 441,
    D3D10_MESSAGE_ID_LIVE_SWAPCHAIN = 442,
    D3D10_MESSAGE_ID_D3D10_MESSAGES_END = 443,
    D3D10_MESSAGE_ID_D3D10L9_MESSAGES_START = 1048576,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_STENCIL_NO_TWO_SIDED = 1048577,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_DepthBiasClamp_NOT_SUPPORTED = 1048578,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NO_COMPARISON_SUPPORT = 1048579,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_EXCESSIVE_ANISOTROPY = 1048580,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_OUT_OF_RANGE = 1048581,
    D3D10_MESSAGE_ID_VSSETSAMPLERS_NOT_SUPPORTED = 1048582,
    D3D10_MESSAGE_ID_VSSETSAMPLERS_TOO_MANY_SAMPLERS = 1048583,
    D3D10_MESSAGE_ID_PSSETSAMPLERS_TOO_MANY_SAMPLERS = 1048584,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_ARRAYS = 1048585,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_VB_AND_IB_BIND = 1048586,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_TEXTURE_1D = 1048587,
    D3D10_MESSAGE_ID_CREATERESOURCE_DIMENSION_OUT_OF_RANGE = 1048588,
    D3D10_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_SHADER_RESOURCE = 1048589,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_TOO_MANY_RENDER_TARGETS = 1048590,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_NO_DIFFERING_BIT_DEPTHS = 1048591,
    D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_BAD_BUFFER_INDEX = 1048592,
    D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_TOO_MANY_VIEWPORTS = 1048593,
    D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_ADJACENCY_UNSUPPORTED = 1048594,
    D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_TOO_MANY_SCISSORS = 1048595,
    D3D10_MESSAGE_ID_COPYRESOURCE_ONLY_TEXTURE_2D_WITHIN_GPU_MEMORY = 1048596,
    D3D10_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_3D_READBACK = 1048597,
    D3D10_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_ONLY_READBACK = 1048598,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_UNSUPPORTED_FORMAT = 1048599,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_ALPHA_TO_COVERAGE = 1048600,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_DepthClipEnable_MUST_BE_TRUE = 1048601,
    D3D10_MESSAGE_ID_DRAWINDEXED_STARTINDEXLOCATION_MUST_BE_POSITIVE = 1048602,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_MUST_USE_LOWEST_LOD = 1048603,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_MINLOD_MUST_NOT_BE_FRACTIONAL = 1048604,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_MAXLOD_MUST_BE_FLT_MAX = 1048605,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_FIRSTARRAYSLICE_MUST_BE_ZERO = 1048606,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_CUBES_MUST_HAVE_6_SIDES = 1048607,
    D3D10_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_RENDER_TARGET = 1048608,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_DWORD_INDEX_BUFFER = 1048609,
    D3D10_MESSAGE_ID_CREATERESOURCE_MSAA_PRECLUDES_SHADER_RESOURCE = 1048610,
    D3D10_MESSAGE_ID_CREATERESOURCE_PRESENTATION_PRECLUDES_SHADER_RESOURCE = 1048611,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_BLEND_ENABLE = 1048612,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_WRITE_MASKS = 1048613,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_STREAM_OUT = 1048614,
    D3D10_MESSAGE_ID_CREATERESOURCE_ONLY_VB_IB_FOR_BUFFERS = 1048615,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_AUTOGEN_FOR_VOLUMES = 1048616,
    D3D10_MESSAGE_ID_CREATERESOURCE_DXGI_FORMAT_R8G8B8A8_CANNOT_BE_SHARED = 1048617,
    D3D10_MESSAGE_ID_VSSHADERRESOURCES_NOT_SUPPORTED = 1048618,
    D3D10_MESSAGE_ID_GEOMETRY_SHADER_NOT_SUPPORTED = 1048619,
    D3D10_MESSAGE_ID_STREAM_OUT_NOT_SUPPORTED = 1048620,
    D3D10_MESSAGE_ID_TEXT_FILTER_NOT_SUPPORTED = 1048621,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_SEPARATE_ALPHA_BLEND = 1048622,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_MRT_BLEND = 1048623,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_OPERATION_NOT_SUPPORTED = 1048624,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NO_MIRRORONCE = 1048625,
    D3D10_MESSAGE_ID_DRAWINSTANCED_NOT_SUPPORTED = 1048626,
    D3D10_MESSAGE_ID_DRAWINDEXEDINSTANCED_NOT_SUPPORTED_BELOW_9_3 = 1048627,
    D3D10_MESSAGE_ID_DRAWINDEXED_POINTLIST_UNSUPPORTED = 1048628,
    D3D10_MESSAGE_ID_SETBLENDSTATE_SAMPLE_MASK_CANNOT_BE_ZERO = 1048629,
    D3D10_MESSAGE_ID_CREATERESOURCE_DIMENSION_EXCEEDS_FEATURE_LEVEL_DEFINITION = 1048630,
    D3D10_MESSAGE_ID_CREATERESOURCE_ONLY_SINGLE_MIP_LEVEL_DEPTH_STENCIL_SUPPORTED = 1048631,
    D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_NEGATIVESCISSOR = 1048632,
    D3D10_MESSAGE_ID_SLOT_ZERO_MUST_BE_D3D10_INPUT_PER_VERTEX_DATA = 1048633,
    D3D10_MESSAGE_ID_CREATERESOURCE_NON_POW_2_MIPMAP = 1048634,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_NOT_SUPPORTED = 1048635,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_NO_SRGB_MRT = 1048636,
    D3D10_MESSAGE_ID_COPYRESOURCE_NO_3D_MISMATCHED_UPDATES = 1048637,
    D3D10_MESSAGE_ID_D3D10L9_MESSAGES_END = 1048638,
}

struct D3D10_MESSAGE
{
    D3D10_MESSAGE_CATEGORY Category;
    D3D10_MESSAGE_SEVERITY Severity;
    D3D10_MESSAGE_ID ID;
    const(byte)* pDescription;
    uint DescriptionByteLength;
}

struct D3D10_INFO_QUEUE_FILTER_DESC
{
    uint NumCategories;
    D3D10_MESSAGE_CATEGORY* pCategoryList;
    uint NumSeverities;
    D3D10_MESSAGE_SEVERITY* pSeverityList;
    uint NumIDs;
    D3D10_MESSAGE_ID* pIDList;
}

struct D3D10_INFO_QUEUE_FILTER
{
    D3D10_INFO_QUEUE_FILTER_DESC AllowList;
    D3D10_INFO_QUEUE_FILTER_DESC DenyList;
}

const GUID IID_ID3D10InfoQueue = {0x1B940B17, 0x2642, 0x4D1F, [0xAB, 0x1F, 0xB9, 0x9B, 0xAD, 0x0C, 0x39, 0x5F]};
@GUID(0x1B940B17, 0x2642, 0x4D1F, [0xAB, 0x1F, 0xB9, 0x9B, 0xAD, 0x0C, 0x39, 0x5F]);
interface ID3D10InfoQueue : IUnknown
{
    HRESULT SetMessageCountLimit(ulong MessageCountLimit);
    void ClearStoredMessages();
    HRESULT GetMessageA(ulong MessageIndex, char* pMessage, uint* pMessageByteLength);
    ulong GetNumMessagesAllowedByStorageFilter();
    ulong GetNumMessagesDeniedByStorageFilter();
    ulong GetNumStoredMessages();
    ulong GetNumStoredMessagesAllowedByRetrievalFilter();
    ulong GetNumMessagesDiscardedByMessageCountLimit();
    ulong GetMessageCountLimit();
    HRESULT AddStorageFilterEntries(D3D10_INFO_QUEUE_FILTER* pFilter);
    HRESULT GetStorageFilter(char* pFilter, uint* pFilterByteLength);
    void ClearStorageFilter();
    HRESULT PushEmptyStorageFilter();
    HRESULT PushCopyOfStorageFilter();
    HRESULT PushStorageFilter(D3D10_INFO_QUEUE_FILTER* pFilter);
    void PopStorageFilter();
    uint GetStorageFilterStackSize();
    HRESULT AddRetrievalFilterEntries(D3D10_INFO_QUEUE_FILTER* pFilter);
    HRESULT GetRetrievalFilter(char* pFilter, uint* pFilterByteLength);
    void ClearRetrievalFilter();
    HRESULT PushEmptyRetrievalFilter();
    HRESULT PushCopyOfRetrievalFilter();
    HRESULT PushRetrievalFilter(D3D10_INFO_QUEUE_FILTER* pFilter);
    void PopRetrievalFilter();
    uint GetRetrievalFilterStackSize();
    HRESULT AddMessage(D3D10_MESSAGE_CATEGORY Category, D3D10_MESSAGE_SEVERITY Severity, D3D10_MESSAGE_ID ID, const(char)* pDescription);
    HRESULT AddApplicationMessage(D3D10_MESSAGE_SEVERITY Severity, const(char)* pDescription);
    HRESULT SetBreakOnCategory(D3D10_MESSAGE_CATEGORY Category, BOOL bEnable);
    HRESULT SetBreakOnSeverity(D3D10_MESSAGE_SEVERITY Severity, BOOL bEnable);
    HRESULT SetBreakOnID(D3D10_MESSAGE_ID ID, BOOL bEnable);
    BOOL GetBreakOnCategory(D3D10_MESSAGE_CATEGORY Category);
    BOOL GetBreakOnSeverity(D3D10_MESSAGE_SEVERITY Severity);
    BOOL GetBreakOnID(D3D10_MESSAGE_ID ID);
    void SetMuteDebugOutput(BOOL bMute);
    BOOL GetMuteDebugOutput();
}

enum D3D10_DRIVER_TYPE
{
    D3D10_DRIVER_TYPE_HARDWARE = 0,
    D3D10_DRIVER_TYPE_REFERENCE = 1,
    D3D10_DRIVER_TYPE_NULL = 2,
    D3D10_DRIVER_TYPE_SOFTWARE = 3,
    D3D10_DRIVER_TYPE_WARP = 5,
}

struct D3D10_SHADER_DESC
{
    uint Version;
    const(char)* Creator;
    uint Flags;
    uint ConstantBuffers;
    uint BoundResources;
    uint InputParameters;
    uint OutputParameters;
    uint InstructionCount;
    uint TempRegisterCount;
    uint TempArrayCount;
    uint DefCount;
    uint DclCount;
    uint TextureNormalInstructions;
    uint TextureLoadInstructions;
    uint TextureCompInstructions;
    uint TextureBiasInstructions;
    uint TextureGradientInstructions;
    uint FloatInstructionCount;
    uint IntInstructionCount;
    uint UintInstructionCount;
    uint StaticFlowControlCount;
    uint DynamicFlowControlCount;
    uint MacroInstructionCount;
    uint ArrayInstructionCount;
    uint CutInstructionCount;
    uint EmitInstructionCount;
    D3D_PRIMITIVE_TOPOLOGY GSOutputTopology;
    uint GSMaxOutputVertexCount;
}

struct D3D10_SHADER_BUFFER_DESC
{
    const(char)* Name;
    D3D_CBUFFER_TYPE Type;
    uint Variables;
    uint Size;
    uint uFlags;
}

struct D3D10_SHADER_VARIABLE_DESC
{
    const(char)* Name;
    uint StartOffset;
    uint Size;
    uint uFlags;
    void* DefaultValue;
}

struct D3D10_SHADER_TYPE_DESC
{
    D3D_SHADER_VARIABLE_CLASS Class;
    D3D_SHADER_VARIABLE_TYPE Type;
    uint Rows;
    uint Columns;
    uint Elements;
    uint Members;
    uint Offset;
}

struct D3D10_SHADER_INPUT_BIND_DESC
{
    const(char)* Name;
    D3D_SHADER_INPUT_TYPE Type;
    uint BindPoint;
    uint BindCount;
    uint uFlags;
    D3D_RESOURCE_RETURN_TYPE ReturnType;
    D3D_SRV_DIMENSION Dimension;
    uint NumSamples;
}

struct D3D10_SIGNATURE_PARAMETER_DESC
{
    const(char)* SemanticName;
    uint SemanticIndex;
    uint Register;
    D3D_NAME SystemValueType;
    D3D_REGISTER_COMPONENT_TYPE ComponentType;
    ubyte Mask;
    ubyte ReadWriteMask;
}

const GUID IID_ID3D10ShaderReflectionType = {0xC530AD7D, 0x9B16, 0x4395, [0xA9, 0x79, 0xBA, 0x2E, 0xCF, 0xF8, 0x3A, 0xDD]};
@GUID(0xC530AD7D, 0x9B16, 0x4395, [0xA9, 0x79, 0xBA, 0x2E, 0xCF, 0xF8, 0x3A, 0xDD]);
interface ID3D10ShaderReflectionType
{
    HRESULT GetDesc(D3D10_SHADER_TYPE_DESC* pDesc);
    ID3D10ShaderReflectionType GetMemberTypeByIndex(uint Index);
    ID3D10ShaderReflectionType GetMemberTypeByName(const(char)* Name);
    byte* GetMemberTypeName(uint Index);
}

const GUID IID_ID3D10ShaderReflectionVariable = {0x1BF63C95, 0x2650, 0x405D, [0x99, 0xC1, 0x36, 0x36, 0xBD, 0x1D, 0xA0, 0xA1]};
@GUID(0x1BF63C95, 0x2650, 0x405D, [0x99, 0xC1, 0x36, 0x36, 0xBD, 0x1D, 0xA0, 0xA1]);
interface ID3D10ShaderReflectionVariable
{
    HRESULT GetDesc(D3D10_SHADER_VARIABLE_DESC* pDesc);
    ID3D10ShaderReflectionType GetType();
}

const GUID IID_ID3D10ShaderReflectionConstantBuffer = {0x66C66A94, 0xDDDD, 0x4B62, [0xA6, 0x6A, 0xF0, 0xDA, 0x33, 0xC2, 0xB4, 0xD0]};
@GUID(0x66C66A94, 0xDDDD, 0x4B62, [0xA6, 0x6A, 0xF0, 0xDA, 0x33, 0xC2, 0xB4, 0xD0]);
interface ID3D10ShaderReflectionConstantBuffer
{
    HRESULT GetDesc(D3D10_SHADER_BUFFER_DESC* pDesc);
    ID3D10ShaderReflectionVariable GetVariableByIndex(uint Index);
    ID3D10ShaderReflectionVariable GetVariableByName(const(char)* Name);
}

const GUID IID_ID3D10ShaderReflection = {0xD40E20B6, 0xF8F7, 0x42AD, [0xAB, 0x20, 0x4B, 0xAF, 0x8F, 0x15, 0xDF, 0xAA]};
@GUID(0xD40E20B6, 0xF8F7, 0x42AD, [0xAB, 0x20, 0x4B, 0xAF, 0x8F, 0x15, 0xDF, 0xAA]);
interface ID3D10ShaderReflection : IUnknown
{
    HRESULT GetDesc(D3D10_SHADER_DESC* pDesc);
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint Index);
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByName(const(char)* Name);
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D10_SHADER_INPUT_BIND_DESC* pDesc);
    HRESULT GetInputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    HRESULT GetOutputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
}

enum D3D10_DEVICE_STATE_TYPES
{
    D3D10_DST_SO_BUFFERS = 1,
    D3D10_DST_OM_RENDER_TARGETS = 2,
    D3D10_DST_OM_DEPTH_STENCIL_STATE = 3,
    D3D10_DST_OM_BLEND_STATE = 4,
    D3D10_DST_VS = 5,
    D3D10_DST_VS_SAMPLERS = 6,
    D3D10_DST_VS_SHADER_RESOURCES = 7,
    D3D10_DST_VS_CONSTANT_BUFFERS = 8,
    D3D10_DST_GS = 9,
    D3D10_DST_GS_SAMPLERS = 10,
    D3D10_DST_GS_SHADER_RESOURCES = 11,
    D3D10_DST_GS_CONSTANT_BUFFERS = 12,
    D3D10_DST_PS = 13,
    D3D10_DST_PS_SAMPLERS = 14,
    D3D10_DST_PS_SHADER_RESOURCES = 15,
    D3D10_DST_PS_CONSTANT_BUFFERS = 16,
    D3D10_DST_IA_VERTEX_BUFFERS = 17,
    D3D10_DST_IA_INDEX_BUFFER = 18,
    D3D10_DST_IA_INPUT_LAYOUT = 19,
    D3D10_DST_IA_PRIMITIVE_TOPOLOGY = 20,
    D3D10_DST_RS_VIEWPORTS = 21,
    D3D10_DST_RS_SCISSOR_RECTS = 22,
    D3D10_DST_RS_RASTERIZER_STATE = 23,
    D3D10_DST_PREDICATION = 24,
}

struct D3D10_STATE_BLOCK_MASK
{
    ubyte VS;
    ubyte VSSamplers;
    ubyte VSShaderResources;
    ubyte VSConstantBuffers;
    ubyte GS;
    ubyte GSSamplers;
    ubyte GSShaderResources;
    ubyte GSConstantBuffers;
    ubyte PS;
    ubyte PSSamplers;
    ubyte PSShaderResources;
    ubyte PSConstantBuffers;
    ubyte IAVertexBuffers;
    ubyte IAIndexBuffer;
    ubyte IAInputLayout;
    ubyte IAPrimitiveTopology;
    ubyte OMRenderTargets;
    ubyte OMDepthStencilState;
    ubyte OMBlendState;
    ubyte RSViewports;
    ubyte RSScissorRects;
    ubyte RSRasterizerState;
    ubyte SOBuffers;
    ubyte Predication;
}

interface ID3D10StateBlock : IUnknown
{
    HRESULT Capture();
    HRESULT Apply();
    HRESULT ReleaseAllDeviceObjects();
    HRESULT GetDevice(ID3D10Device* ppDevice);
}

struct D3D10_EFFECT_TYPE_DESC
{
    const(char)* TypeName;
    D3D_SHADER_VARIABLE_CLASS Class;
    D3D_SHADER_VARIABLE_TYPE Type;
    uint Elements;
    uint Members;
    uint Rows;
    uint Columns;
    uint PackedSize;
    uint UnpackedSize;
    uint Stride;
}

interface ID3D10EffectType
{
    BOOL IsValid();
    HRESULT GetDesc(D3D10_EFFECT_TYPE_DESC* pDesc);
    ID3D10EffectType GetMemberTypeByIndex(uint Index);
    ID3D10EffectType GetMemberTypeByName(const(char)* Name);
    ID3D10EffectType GetMemberTypeBySemantic(const(char)* Semantic);
    byte* GetMemberName(uint Index);
    byte* GetMemberSemantic(uint Index);
}

struct D3D10_EFFECT_VARIABLE_DESC
{
    const(char)* Name;
    const(char)* Semantic;
    uint Flags;
    uint Annotations;
    uint BufferOffset;
    uint ExplicitBindPoint;
}

interface ID3D10EffectVariable
{
    BOOL IsValid();
    ID3D10EffectType GetType();
    HRESULT GetDesc(D3D10_EFFECT_VARIABLE_DESC* pDesc);
    ID3D10EffectVariable GetAnnotationByIndex(uint Index);
    ID3D10EffectVariable GetAnnotationByName(const(char)* Name);
    ID3D10EffectVariable GetMemberByIndex(uint Index);
    ID3D10EffectVariable GetMemberByName(const(char)* Name);
    ID3D10EffectVariable GetMemberBySemantic(const(char)* Semantic);
    ID3D10EffectVariable GetElement(uint Index);
    ID3D10EffectConstantBuffer GetParentConstantBuffer();
    ID3D10EffectScalarVariable AsScalar();
    ID3D10EffectVectorVariable AsVector();
    ID3D10EffectMatrixVariable AsMatrix();
    ID3D10EffectStringVariable AsString();
    ID3D10EffectShaderResourceVariable AsShaderResource();
    ID3D10EffectRenderTargetViewVariable AsRenderTargetView();
    ID3D10EffectDepthStencilViewVariable AsDepthStencilView();
    ID3D10EffectConstantBuffer AsConstantBuffer();
    ID3D10EffectShaderVariable AsShader();
    ID3D10EffectBlendVariable AsBlend();
    ID3D10EffectDepthStencilVariable AsDepthStencil();
    ID3D10EffectRasterizerVariable AsRasterizer();
    ID3D10EffectSamplerVariable AsSampler();
    HRESULT SetRawValue(char* pData, uint Offset, uint ByteCount);
    HRESULT GetRawValue(char* pData, uint Offset, uint ByteCount);
}

interface ID3D10EffectScalarVariable : ID3D10EffectVariable
{
    HRESULT SetFloat(float Value);
    HRESULT GetFloat(float* pValue);
    HRESULT SetFloatArray(char* pData, uint Offset, uint Count);
    HRESULT GetFloatArray(char* pData, uint Offset, uint Count);
    HRESULT SetInt(int Value);
    HRESULT GetInt(int* pValue);
    HRESULT SetIntArray(char* pData, uint Offset, uint Count);
    HRESULT GetIntArray(char* pData, uint Offset, uint Count);
    HRESULT SetBool(BOOL Value);
    HRESULT GetBool(int* pValue);
    HRESULT SetBoolArray(char* pData, uint Offset, uint Count);
    HRESULT GetBoolArray(char* pData, uint Offset, uint Count);
}

interface ID3D10EffectVectorVariable : ID3D10EffectVariable
{
    HRESULT SetBoolVector(int* pData);
    HRESULT SetIntVector(int* pData);
    HRESULT SetFloatVector(float* pData);
    HRESULT GetBoolVector(int* pData);
    HRESULT GetIntVector(int* pData);
    HRESULT GetFloatVector(float* pData);
    HRESULT SetBoolVectorArray(int* pData, uint Offset, uint Count);
    HRESULT SetIntVectorArray(int* pData, uint Offset, uint Count);
    HRESULT SetFloatVectorArray(float* pData, uint Offset, uint Count);
    HRESULT GetBoolVectorArray(int* pData, uint Offset, uint Count);
    HRESULT GetIntVectorArray(int* pData, uint Offset, uint Count);
    HRESULT GetFloatVectorArray(float* pData, uint Offset, uint Count);
}

interface ID3D10EffectMatrixVariable : ID3D10EffectVariable
{
    HRESULT SetMatrix(float* pData);
    HRESULT GetMatrix(float* pData);
    HRESULT SetMatrixArray(float* pData, uint Offset, uint Count);
    HRESULT GetMatrixArray(float* pData, uint Offset, uint Count);
    HRESULT SetMatrixTranspose(float* pData);
    HRESULT GetMatrixTranspose(float* pData);
    HRESULT SetMatrixTransposeArray(float* pData, uint Offset, uint Count);
    HRESULT GetMatrixTransposeArray(float* pData, uint Offset, uint Count);
}

interface ID3D10EffectStringVariable : ID3D10EffectVariable
{
    HRESULT GetString(byte** ppString);
    HRESULT GetStringArray(char* ppStrings, uint Offset, uint Count);
}

interface ID3D10EffectShaderResourceVariable : ID3D10EffectVariable
{
    HRESULT SetResource(ID3D10ShaderResourceView pResource);
    HRESULT GetResource(ID3D10ShaderResourceView* ppResource);
    HRESULT SetResourceArray(char* ppResources, uint Offset, uint Count);
    HRESULT GetResourceArray(char* ppResources, uint Offset, uint Count);
}

interface ID3D10EffectRenderTargetViewVariable : ID3D10EffectVariable
{
    HRESULT SetRenderTarget(ID3D10RenderTargetView pResource);
    HRESULT GetRenderTarget(ID3D10RenderTargetView* ppResource);
    HRESULT SetRenderTargetArray(char* ppResources, uint Offset, uint Count);
    HRESULT GetRenderTargetArray(char* ppResources, uint Offset, uint Count);
}

interface ID3D10EffectDepthStencilViewVariable : ID3D10EffectVariable
{
    HRESULT SetDepthStencil(ID3D10DepthStencilView pResource);
    HRESULT GetDepthStencil(ID3D10DepthStencilView* ppResource);
    HRESULT SetDepthStencilArray(char* ppResources, uint Offset, uint Count);
    HRESULT GetDepthStencilArray(char* ppResources, uint Offset, uint Count);
}

interface ID3D10EffectConstantBuffer : ID3D10EffectVariable
{
    HRESULT SetConstantBuffer(ID3D10Buffer pConstantBuffer);
    HRESULT GetConstantBuffer(ID3D10Buffer* ppConstantBuffer);
    HRESULT SetTextureBuffer(ID3D10ShaderResourceView pTextureBuffer);
    HRESULT GetTextureBuffer(ID3D10ShaderResourceView* ppTextureBuffer);
}

struct D3D10_EFFECT_SHADER_DESC
{
    const(ubyte)* pInputSignature;
    BOOL IsInline;
    const(ubyte)* pBytecode;
    uint BytecodeLength;
    const(char)* SODecl;
    uint NumInputSignatureEntries;
    uint NumOutputSignatureEntries;
}

interface ID3D10EffectShaderVariable : ID3D10EffectVariable
{
    HRESULT GetShaderDesc(uint ShaderIndex, D3D10_EFFECT_SHADER_DESC* pDesc);
    HRESULT GetVertexShader(uint ShaderIndex, ID3D10VertexShader* ppVS);
    HRESULT GetGeometryShader(uint ShaderIndex, ID3D10GeometryShader* ppGS);
    HRESULT GetPixelShader(uint ShaderIndex, ID3D10PixelShader* ppPS);
    HRESULT GetInputSignatureElementDesc(uint ShaderIndex, uint Element, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    HRESULT GetOutputSignatureElementDesc(uint ShaderIndex, uint Element, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
}

interface ID3D10EffectBlendVariable : ID3D10EffectVariable
{
    HRESULT GetBlendState(uint Index, ID3D10BlendState* ppBlendState);
    HRESULT GetBackingStore(uint Index, D3D10_BLEND_DESC* pBlendDesc);
}

interface ID3D10EffectDepthStencilVariable : ID3D10EffectVariable
{
    HRESULT GetDepthStencilState(uint Index, ID3D10DepthStencilState* ppDepthStencilState);
    HRESULT GetBackingStore(uint Index, D3D10_DEPTH_STENCIL_DESC* pDepthStencilDesc);
}

interface ID3D10EffectRasterizerVariable : ID3D10EffectVariable
{
    HRESULT GetRasterizerState(uint Index, ID3D10RasterizerState* ppRasterizerState);
    HRESULT GetBackingStore(uint Index, D3D10_RASTERIZER_DESC* pRasterizerDesc);
}

interface ID3D10EffectSamplerVariable : ID3D10EffectVariable
{
    HRESULT GetSampler(uint Index, ID3D10SamplerState* ppSampler);
    HRESULT GetBackingStore(uint Index, D3D10_SAMPLER_DESC* pSamplerDesc);
}

struct D3D10_PASS_DESC
{
    const(char)* Name;
    uint Annotations;
    ubyte* pIAInputSignature;
    uint IAInputSignatureSize;
    uint StencilRef;
    uint SampleMask;
    float BlendFactor;
}

struct D3D10_PASS_SHADER_DESC
{
    ID3D10EffectShaderVariable pShaderVariable;
    uint ShaderIndex;
}

interface ID3D10EffectPass
{
    BOOL IsValid();
    HRESULT GetDesc(D3D10_PASS_DESC* pDesc);
    HRESULT GetVertexShaderDesc(D3D10_PASS_SHADER_DESC* pDesc);
    HRESULT GetGeometryShaderDesc(D3D10_PASS_SHADER_DESC* pDesc);
    HRESULT GetPixelShaderDesc(D3D10_PASS_SHADER_DESC* pDesc);
    ID3D10EffectVariable GetAnnotationByIndex(uint Index);
    ID3D10EffectVariable GetAnnotationByName(const(char)* Name);
    HRESULT Apply(uint Flags);
    HRESULT ComputeStateBlockMask(D3D10_STATE_BLOCK_MASK* pStateBlockMask);
}

struct D3D10_TECHNIQUE_DESC
{
    const(char)* Name;
    uint Passes;
    uint Annotations;
}

interface ID3D10EffectTechnique
{
    BOOL IsValid();
    HRESULT GetDesc(D3D10_TECHNIQUE_DESC* pDesc);
    ID3D10EffectVariable GetAnnotationByIndex(uint Index);
    ID3D10EffectVariable GetAnnotationByName(const(char)* Name);
    ID3D10EffectPass GetPassByIndex(uint Index);
    ID3D10EffectPass GetPassByName(const(char)* Name);
    HRESULT ComputeStateBlockMask(D3D10_STATE_BLOCK_MASK* pStateBlockMask);
}

struct D3D10_EFFECT_DESC
{
    BOOL IsChildEffect;
    uint ConstantBuffers;
    uint SharedConstantBuffers;
    uint GlobalVariables;
    uint SharedGlobalVariables;
    uint Techniques;
}

interface ID3D10Effect : IUnknown
{
    BOOL IsValid();
    BOOL IsPool();
    HRESULT GetDevice(ID3D10Device* ppDevice);
    HRESULT GetDesc(D3D10_EFFECT_DESC* pDesc);
    ID3D10EffectConstantBuffer GetConstantBufferByIndex(uint Index);
    ID3D10EffectConstantBuffer GetConstantBufferByName(const(char)* Name);
    ID3D10EffectVariable GetVariableByIndex(uint Index);
    ID3D10EffectVariable GetVariableByName(const(char)* Name);
    ID3D10EffectVariable GetVariableBySemantic(const(char)* Semantic);
    ID3D10EffectTechnique GetTechniqueByIndex(uint Index);
    ID3D10EffectTechnique GetTechniqueByName(const(char)* Name);
    HRESULT Optimize();
    BOOL IsOptimized();
}

interface ID3D10EffectPool : IUnknown
{
    ID3D10Effect AsEffect();
}

enum D3D10_FEATURE_LEVEL1
{
    D3D10_FEATURE_LEVEL_10_0 = 40960,
    D3D10_FEATURE_LEVEL_10_1 = 41216,
    D3D10_FEATURE_LEVEL_9_1 = 37120,
    D3D10_FEATURE_LEVEL_9_2 = 37376,
    D3D10_FEATURE_LEVEL_9_3 = 37632,
}

struct D3D10_RENDER_TARGET_BLEND_DESC1
{
    BOOL BlendEnable;
    D3D10_BLEND SrcBlend;
    D3D10_BLEND DestBlend;
    D3D10_BLEND_OP BlendOp;
    D3D10_BLEND SrcBlendAlpha;
    D3D10_BLEND DestBlendAlpha;
    D3D10_BLEND_OP BlendOpAlpha;
    ubyte RenderTargetWriteMask;
}

struct D3D10_BLEND_DESC1
{
    BOOL AlphaToCoverageEnable;
    BOOL IndependentBlendEnable;
    D3D10_RENDER_TARGET_BLEND_DESC1 RenderTarget;
}

const GUID IID_ID3D10BlendState1 = {0xEDAD8D99, 0x8A35, 0x4D6D, [0x85, 0x66, 0x2E, 0xA2, 0x76, 0xCD, 0xE1, 0x61]};
@GUID(0xEDAD8D99, 0x8A35, 0x4D6D, [0x85, 0x66, 0x2E, 0xA2, 0x76, 0xCD, 0xE1, 0x61]);
interface ID3D10BlendState1 : ID3D10BlendState
{
    void GetDesc1(D3D10_BLEND_DESC1* pDesc);
}

struct D3D10_TEXCUBE_ARRAY_SRV1
{
    uint MostDetailedMip;
    uint MipLevels;
    uint First2DArrayFace;
    uint NumCubes;
}

struct D3D10_SHADER_RESOURCE_VIEW_DESC1
{
    DXGI_FORMAT Format;
    D3D_SRV_DIMENSION ViewDimension;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_ID3D10ShaderResourceView1 = {0x9B7E4C87, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C87, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10ShaderResourceView1 : ID3D10ShaderResourceView
{
    void GetDesc1(D3D10_SHADER_RESOURCE_VIEW_DESC1* pDesc);
}

enum D3D10_STANDARD_MULTISAMPLE_QUALITY_LEVELS
{
    D3D10_STANDARD_MULTISAMPLE_PATTERN = -1,
    D3D10_CENTER_MULTISAMPLE_PATTERN = -2,
}

const GUID IID_ID3D10Device1 = {0x9B7E4C8F, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]};
@GUID(0x9B7E4C8F, 0x342C, 0x4106, [0xA1, 0x9F, 0x4F, 0x27, 0x04, 0xF6, 0x89, 0xF0]);
interface ID3D10Device1 : ID3D10Device
{
    HRESULT CreateShaderResourceView1(ID3D10Resource pResource, const(D3D10_SHADER_RESOURCE_VIEW_DESC1)* pDesc, ID3D10ShaderResourceView1* ppSRView);
    HRESULT CreateBlendState1(const(D3D10_BLEND_DESC1)* pBlendStateDesc, ID3D10BlendState1* ppBlendState);
    D3D10_FEATURE_LEVEL1 GetFeatureLevel();
}

enum D3D10_SHADER_DEBUG_REGTYPE
{
    D3D10_SHADER_DEBUG_REG_INPUT = 0,
    D3D10_SHADER_DEBUG_REG_OUTPUT = 1,
    D3D10_SHADER_DEBUG_REG_CBUFFER = 2,
    D3D10_SHADER_DEBUG_REG_TBUFFER = 3,
    D3D10_SHADER_DEBUG_REG_TEMP = 4,
    D3D10_SHADER_DEBUG_REG_TEMPARRAY = 5,
    D3D10_SHADER_DEBUG_REG_TEXTURE = 6,
    D3D10_SHADER_DEBUG_REG_SAMPLER = 7,
    D3D10_SHADER_DEBUG_REG_IMMEDIATECBUFFER = 8,
    D3D10_SHADER_DEBUG_REG_LITERAL = 9,
    D3D10_SHADER_DEBUG_REG_UNUSED = 10,
    D3D11_SHADER_DEBUG_REG_INTERFACE_POINTERS = 11,
    D3D11_SHADER_DEBUG_REG_UAV = 12,
    D3D10_SHADER_DEBUG_REG_FORCE_DWORD = 2147483647,
}

enum D3D10_SHADER_DEBUG_SCOPETYPE
{
    D3D10_SHADER_DEBUG_SCOPE_GLOBAL = 0,
    D3D10_SHADER_DEBUG_SCOPE_BLOCK = 1,
    D3D10_SHADER_DEBUG_SCOPE_FORLOOP = 2,
    D3D10_SHADER_DEBUG_SCOPE_STRUCT = 3,
    D3D10_SHADER_DEBUG_SCOPE_FUNC_PARAMS = 4,
    D3D10_SHADER_DEBUG_SCOPE_STATEBLOCK = 5,
    D3D10_SHADER_DEBUG_SCOPE_NAMESPACE = 6,
    D3D10_SHADER_DEBUG_SCOPE_ANNOTATION = 7,
    D3D10_SHADER_DEBUG_SCOPE_FORCE_DWORD = 2147483647,
}

enum D3D10_SHADER_DEBUG_VARTYPE
{
    D3D10_SHADER_DEBUG_VAR_VARIABLE = 0,
    D3D10_SHADER_DEBUG_VAR_FUNCTION = 1,
    D3D10_SHADER_DEBUG_VAR_FORCE_DWORD = 2147483647,
}

struct D3D10_SHADER_DEBUG_TOKEN_INFO
{
    uint File;
    uint Line;
    uint Column;
    uint TokenLength;
    uint TokenId;
}

struct D3D10_SHADER_DEBUG_VAR_INFO
{
    uint TokenId;
    D3D_SHADER_VARIABLE_TYPE Type;
    uint Register;
    uint Component;
    uint ScopeVar;
    uint ScopeVarOffset;
}

struct D3D10_SHADER_DEBUG_INPUT_INFO
{
    uint Var;
    D3D10_SHADER_DEBUG_REGTYPE InitialRegisterSet;
    uint InitialBank;
    uint InitialRegister;
    uint InitialComponent;
    uint InitialValue;
}

struct D3D10_SHADER_DEBUG_SCOPEVAR_INFO
{
    uint TokenId;
    D3D10_SHADER_DEBUG_VARTYPE VarType;
    D3D_SHADER_VARIABLE_CLASS Class;
    uint Rows;
    uint Columns;
    uint StructMemberScope;
    uint uArrayIndices;
    uint ArrayElements;
    uint ArrayStrides;
    uint uVariables;
    uint uFirstVariable;
}

struct D3D10_SHADER_DEBUG_SCOPE_INFO
{
    D3D10_SHADER_DEBUG_SCOPETYPE ScopeType;
    uint Name;
    uint uNameLen;
    uint uVariables;
    uint VariableData;
}

struct D3D10_SHADER_DEBUG_OUTPUTVAR
{
    uint Var;
    uint uValueMin;
    uint uValueMax;
    int iValueMin;
    int iValueMax;
    float fValueMin;
    float fValueMax;
    BOOL bNaNPossible;
    BOOL bInfPossible;
}

struct D3D10_SHADER_DEBUG_OUTPUTREG_INFO
{
    D3D10_SHADER_DEBUG_REGTYPE OutputRegisterSet;
    uint OutputReg;
    uint TempArrayReg;
    uint OutputComponents;
    D3D10_SHADER_DEBUG_OUTPUTVAR OutputVars;
    uint IndexReg;
    uint IndexComp;
}

struct D3D10_SHADER_DEBUG_INST_INFO
{
    uint Id;
    uint Opcode;
    uint uOutputs;
    D3D10_SHADER_DEBUG_OUTPUTREG_INFO pOutputs;
    uint TokenId;
    uint NestingLevel;
    uint Scopes;
    uint ScopeInfo;
    uint AccessedVars;
    uint AccessedVarsInfo;
}

struct D3D10_SHADER_DEBUG_FILE_INFO
{
    uint FileName;
    uint FileNameLen;
    uint FileData;
    uint FileLen;
}

struct D3D10_SHADER_DEBUG_INFO
{
    uint Size;
    uint Creator;
    uint EntrypointName;
    uint ShaderTarget;
    uint CompileFlags;
    uint Files;
    uint FileInfo;
    uint Instructions;
    uint InstructionInfo;
    uint Variables;
    uint VariableInfo;
    uint InputVariables;
    uint InputVariableInfo;
    uint Tokens;
    uint TokenInfo;
    uint Scopes;
    uint ScopeInfo;
    uint ScopeVariables;
    uint ScopeVariableInfo;
    uint UintOffset;
    uint StringOffset;
}

interface ID3D10ShaderReflection1 : IUnknown
{
    HRESULT GetDesc(D3D10_SHADER_DESC* pDesc);
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint Index);
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByName(const(char)* Name);
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D10_SHADER_INPUT_BIND_DESC* pDesc);
    HRESULT GetInputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    HRESULT GetOutputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    ID3D10ShaderReflectionVariable GetVariableByName(const(char)* Name);
    HRESULT GetResourceBindingDescByName(const(char)* Name, D3D10_SHADER_INPUT_BIND_DESC* pDesc);
    HRESULT GetMovInstructionCount(uint* pCount);
    HRESULT GetMovcInstructionCount(uint* pCount);
    HRESULT GetConversionInstructionCount(uint* pCount);
    HRESULT GetBitwiseInstructionCount(uint* pCount);
    HRESULT GetGSInputPrimitive(D3D_PRIMITIVE* pPrim);
    HRESULT IsLevel9Shader(int* pbLevel9Shader);
    HRESULT IsSampleFrequencyShader(int* pbSampleFrequency);
}

alias PFN_D3D10_CREATE_DEVICE1 = extern(Windows) HRESULT function(IDXGIAdapter param0, D3D10_DRIVER_TYPE param1, int param2, uint param3, D3D10_FEATURE_LEVEL1 param4, uint param5, ID3D10Device1* param6);
alias PFN_D3D10_CREATE_DEVICE_AND_SWAP_CHAIN1 = extern(Windows) HRESULT function(IDXGIAdapter param0, D3D10_DRIVER_TYPE param1, int param2, uint param3, D3D10_FEATURE_LEVEL1 param4, uint param5, DXGI_SWAP_CHAIN_DESC* param6, IDXGISwapChain* param7, ID3D10Device1* param8);
@DllImport("d3d10.dll")
HRESULT D3D10CreateDevice(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, int Software, uint Flags, uint SDKVersion, ID3D10Device* ppDevice);

@DllImport("d3d10.dll")
HRESULT D3D10CreateDeviceAndSwapChain(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, int Software, uint Flags, uint SDKVersion, DXGI_SWAP_CHAIN_DESC* pSwapChainDesc, IDXGISwapChain* ppSwapChain, ID3D10Device* ppDevice);

@DllImport("d3d10.dll")
HRESULT D3D10CreateBlob(uint NumBytes, ID3DBlob* ppBuffer);

@DllImport("d3d10.dll")
HRESULT D3D10CompileShader(const(char)* pSrcData, uint SrcDataSize, const(char)* pFileName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, const(char)* pFunctionName, const(char)* pProfile, uint Flags, ID3DBlob* ppShader, ID3DBlob* ppErrorMsgs);

@DllImport("d3d10.dll")
HRESULT D3D10DisassembleShader(char* pShader, uint BytecodeLength, BOOL EnableColorCode, const(char)* pComments, ID3DBlob* ppDisassembly);

@DllImport("d3d10.dll")
byte* D3D10GetPixelShaderProfile(ID3D10Device pDevice);

@DllImport("d3d10.dll")
byte* D3D10GetVertexShaderProfile(ID3D10Device pDevice);

@DllImport("d3d10.dll")
byte* D3D10GetGeometryShaderProfile(ID3D10Device pDevice);

@DllImport("d3d10.dll")
HRESULT D3D10ReflectShader(char* pShaderBytecode, uint BytecodeLength, ID3D10ShaderReflection* ppReflector);

@DllImport("d3d10.dll")
HRESULT D3D10PreprocessShader(const(char)* pSrcData, uint SrcDataSize, const(char)* pFileName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, ID3DBlob* ppShaderText, ID3DBlob* ppErrorMsgs);

@DllImport("d3d10.dll")
HRESULT D3D10GetInputSignatureBlob(char* pShaderBytecode, uint BytecodeLength, ID3DBlob* ppSignatureBlob);

@DllImport("d3d10.dll")
HRESULT D3D10GetOutputSignatureBlob(char* pShaderBytecode, uint BytecodeLength, ID3DBlob* ppSignatureBlob);

@DllImport("d3d10.dll")
HRESULT D3D10GetInputAndOutputSignatureBlob(char* pShaderBytecode, uint BytecodeLength, ID3DBlob* ppSignatureBlob);

@DllImport("d3d10.dll")
HRESULT D3D10GetShaderDebugInfo(char* pShaderBytecode, uint BytecodeLength, ID3DBlob* ppDebugInfo);

@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskUnion(D3D10_STATE_BLOCK_MASK* pA, D3D10_STATE_BLOCK_MASK* pB, D3D10_STATE_BLOCK_MASK* pResult);

@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskIntersect(D3D10_STATE_BLOCK_MASK* pA, D3D10_STATE_BLOCK_MASK* pB, D3D10_STATE_BLOCK_MASK* pResult);

@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskDifference(D3D10_STATE_BLOCK_MASK* pA, D3D10_STATE_BLOCK_MASK* pB, D3D10_STATE_BLOCK_MASK* pResult);

@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskEnableCapture(D3D10_STATE_BLOCK_MASK* pMask, D3D10_DEVICE_STATE_TYPES StateType, uint RangeStart, uint RangeLength);

@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskDisableCapture(D3D10_STATE_BLOCK_MASK* pMask, D3D10_DEVICE_STATE_TYPES StateType, uint RangeStart, uint RangeLength);

@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskEnableAll(D3D10_STATE_BLOCK_MASK* pMask);

@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskDisableAll(D3D10_STATE_BLOCK_MASK* pMask);

@DllImport("d3d10.dll")
BOOL D3D10StateBlockMaskGetSetting(D3D10_STATE_BLOCK_MASK* pMask, D3D10_DEVICE_STATE_TYPES StateType, uint Entry);

@DllImport("d3d10.dll")
HRESULT D3D10CreateStateBlock(ID3D10Device pDevice, D3D10_STATE_BLOCK_MASK* pStateBlockMask, ID3D10StateBlock* ppStateBlock);

@DllImport("d3d10.dll")
HRESULT D3D10CompileEffectFromMemory(char* pData, uint DataLength, const(char)* pSrcFileName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, uint HLSLFlags, uint FXFlags, ID3DBlob* ppCompiledEffect, ID3DBlob* ppErrors);

@DllImport("d3d10.dll")
HRESULT D3D10CreateEffectFromMemory(char* pData, uint DataLength, uint FXFlags, ID3D10Device pDevice, ID3D10EffectPool pEffectPool, ID3D10Effect* ppEffect);

@DllImport("d3d10.dll")
HRESULT D3D10CreateEffectPoolFromMemory(char* pData, uint DataLength, uint FXFlags, ID3D10Device pDevice, ID3D10EffectPool* ppEffectPool);

@DllImport("d3d10.dll")
HRESULT D3D10DisassembleEffect(ID3D10Effect pEffect, BOOL EnableColorCode, ID3DBlob* ppDisassembly);

@DllImport("d3d10_1.dll")
HRESULT D3D10CreateDevice1(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, int Software, uint Flags, D3D10_FEATURE_LEVEL1 HardwareLevel, uint SDKVersion, ID3D10Device1* ppDevice);

@DllImport("d3d10_1.dll")
HRESULT D3D10CreateDeviceAndSwapChain1(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, int Software, uint Flags, D3D10_FEATURE_LEVEL1 HardwareLevel, uint SDKVersion, DXGI_SWAP_CHAIN_DESC* pSwapChainDesc, IDXGISwapChain* ppSwapChain, ID3D10Device1* ppDevice);

