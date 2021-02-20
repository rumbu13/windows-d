// Written in the D programming language.

module windows.direct3d9;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : POINT, RECT;
public import windows.dxgi : DXGI_RGBA;
public import windows.gdi : HDC, HMONITOR, PALETTEENTRY, RGNDATA;
public import windows.kernel : LUID;
public import windows.systemservices : BOOL, D3DLIGHTTYPE, D3DPRIMITIVETYPE, D3DRECT,
                                       D3DRENDERSTATETYPE, D3DSTATEBLOCKTYPE,
                                       D3DTEXTURESTAGESTATETYPE, D3DTRANSFORMSTATETYPE,
                                       D3DVECTOR, HANDLE, LARGE_INTEGER, PWSTR;
public import windows.windowsandmessaging : HWND;

extern(Windows) @nogc nothrow:


// Enums


alias D3DBLENDOP = uint;
enum : uint
{
    D3DBLENDOP_ADD         = 0x00000001,
    D3DBLENDOP_SUBTRACT    = 0x00000002,
    D3DBLENDOP_REVSUBTRACT = 0x00000003,
    D3DBLENDOP_MIN         = 0x00000004,
    D3DBLENDOP_MAX         = 0x00000005,
    D3DBLENDOP_FORCE_DWORD = 0x7fffffff,
}

alias D3DSAMPLERSTATETYPE = int;
enum : int
{
    D3DSAMP_ADDRESSU      = 0x00000001,
    D3DSAMP_ADDRESSV      = 0x00000002,
    D3DSAMP_ADDRESSW      = 0x00000003,
    D3DSAMP_BORDERCOLOR   = 0x00000004,
    D3DSAMP_MAGFILTER     = 0x00000005,
    D3DSAMP_MINFILTER     = 0x00000006,
    D3DSAMP_MIPFILTER     = 0x00000007,
    D3DSAMP_MIPMAPLODBIAS = 0x00000008,
    D3DSAMP_MAXMIPLEVEL   = 0x00000009,
    D3DSAMP_MAXANISOTROPY = 0x0000000a,
    D3DSAMP_SRGBTEXTURE   = 0x0000000b,
    D3DSAMP_ELEMENTINDEX  = 0x0000000c,
    D3DSAMP_DMAPOFFSET    = 0x0000000d,
    D3DSAMP_FORCE_DWORD   = 0x7fffffff,
}

alias D3DTEXTUREFILTERTYPE = int;
enum : int
{
    D3DTEXF_NONE            = 0x00000000,
    D3DTEXF_POINT           = 0x00000001,
    D3DTEXF_LINEAR          = 0x00000002,
    D3DTEXF_ANISOTROPIC     = 0x00000003,
    D3DTEXF_PYRAMIDALQUAD   = 0x00000006,
    D3DTEXF_GAUSSIANQUAD    = 0x00000007,
    D3DTEXF_CONVOLUTIONMONO = 0x00000008,
    D3DTEXF_FORCE_DWORD     = 0x7fffffff,
}

alias D3DDECLUSAGE = int;
enum : int
{
    D3DDECLUSAGE_POSITION     = 0x00000000,
    D3DDECLUSAGE_BLENDWEIGHT  = 0x00000001,
    D3DDECLUSAGE_BLENDINDICES = 0x00000002,
    D3DDECLUSAGE_NORMAL       = 0x00000003,
    D3DDECLUSAGE_PSIZE        = 0x00000004,
    D3DDECLUSAGE_TEXCOORD     = 0x00000005,
    D3DDECLUSAGE_TANGENT      = 0x00000006,
    D3DDECLUSAGE_BINORMAL     = 0x00000007,
    D3DDECLUSAGE_TESSFACTOR   = 0x00000008,
    D3DDECLUSAGE_POSITIONT    = 0x00000009,
    D3DDECLUSAGE_COLOR        = 0x0000000a,
    D3DDECLUSAGE_FOG          = 0x0000000b,
    D3DDECLUSAGE_DEPTH        = 0x0000000c,
    D3DDECLUSAGE_SAMPLE       = 0x0000000d,
}

alias D3DDECLMETHOD = int;
enum : int
{
    D3DDECLMETHOD_DEFAULT          = 0x00000000,
    D3DDECLMETHOD_PARTIALU         = 0x00000001,
    D3DDECLMETHOD_PARTIALV         = 0x00000002,
    D3DDECLMETHOD_CROSSUV          = 0x00000003,
    D3DDECLMETHOD_UV               = 0x00000004,
    D3DDECLMETHOD_LOOKUP           = 0x00000005,
    D3DDECLMETHOD_LOOKUPPRESAMPLED = 0x00000006,
}

alias D3DDECLTYPE = int;
enum : int
{
    D3DDECLTYPE_FLOAT1    = 0x00000000,
    D3DDECLTYPE_FLOAT2    = 0x00000001,
    D3DDECLTYPE_FLOAT3    = 0x00000002,
    D3DDECLTYPE_FLOAT4    = 0x00000003,
    D3DDECLTYPE_D3DCOLOR  = 0x00000004,
    D3DDECLTYPE_UBYTE4    = 0x00000005,
    D3DDECLTYPE_SHORT2    = 0x00000006,
    D3DDECLTYPE_SHORT4    = 0x00000007,
    D3DDECLTYPE_UBYTE4N   = 0x00000008,
    D3DDECLTYPE_SHORT2N   = 0x00000009,
    D3DDECLTYPE_SHORT4N   = 0x0000000a,
    D3DDECLTYPE_USHORT2N  = 0x0000000b,
    D3DDECLTYPE_USHORT4N  = 0x0000000c,
    D3DDECLTYPE_UDEC3     = 0x0000000d,
    D3DDECLTYPE_DEC3N     = 0x0000000e,
    D3DDECLTYPE_FLOAT16_2 = 0x0000000f,
    D3DDECLTYPE_FLOAT16_4 = 0x00000010,
    D3DDECLTYPE_UNUSED    = 0x00000011,
}

alias D3DSHADER_INSTRUCTION_OPCODE_TYPE = int;
enum : int
{
    D3DSIO_NOP          = 0x00000000,
    D3DSIO_MOV          = 0x00000001,
    D3DSIO_ADD          = 0x00000002,
    D3DSIO_SUB          = 0x00000003,
    D3DSIO_MAD          = 0x00000004,
    D3DSIO_MUL          = 0x00000005,
    D3DSIO_RCP          = 0x00000006,
    D3DSIO_RSQ          = 0x00000007,
    D3DSIO_DP3          = 0x00000008,
    D3DSIO_DP4          = 0x00000009,
    D3DSIO_MIN          = 0x0000000a,
    D3DSIO_MAX          = 0x0000000b,
    D3DSIO_SLT          = 0x0000000c,
    D3DSIO_SGE          = 0x0000000d,
    D3DSIO_EXP          = 0x0000000e,
    D3DSIO_LOG          = 0x0000000f,
    D3DSIO_LIT          = 0x00000010,
    D3DSIO_DST          = 0x00000011,
    D3DSIO_LRP          = 0x00000012,
    D3DSIO_FRC          = 0x00000013,
    D3DSIO_M4x4         = 0x00000014,
    D3DSIO_M4x3         = 0x00000015,
    D3DSIO_M3x4         = 0x00000016,
    D3DSIO_M3x3         = 0x00000017,
    D3DSIO_M3x2         = 0x00000018,
    D3DSIO_CALL         = 0x00000019,
    D3DSIO_CALLNZ       = 0x0000001a,
    D3DSIO_LOOP         = 0x0000001b,
    D3DSIO_RET          = 0x0000001c,
    D3DSIO_ENDLOOP      = 0x0000001d,
    D3DSIO_LABEL        = 0x0000001e,
    D3DSIO_DCL          = 0x0000001f,
    D3DSIO_POW          = 0x00000020,
    D3DSIO_CRS          = 0x00000021,
    D3DSIO_SGN          = 0x00000022,
    D3DSIO_ABS          = 0x00000023,
    D3DSIO_NRM          = 0x00000024,
    D3DSIO_SINCOS       = 0x00000025,
    D3DSIO_REP          = 0x00000026,
    D3DSIO_ENDREP       = 0x00000027,
    D3DSIO_IF           = 0x00000028,
    D3DSIO_IFC          = 0x00000029,
    D3DSIO_ELSE         = 0x0000002a,
    D3DSIO_ENDIF        = 0x0000002b,
    D3DSIO_BREAK        = 0x0000002c,
    D3DSIO_BREAKC       = 0x0000002d,
    D3DSIO_MOVA         = 0x0000002e,
    D3DSIO_DEFB         = 0x0000002f,
    D3DSIO_DEFI         = 0x00000030,
    D3DSIO_TEXCOORD     = 0x00000040,
    D3DSIO_TEXKILL      = 0x00000041,
    D3DSIO_TEX          = 0x00000042,
    D3DSIO_TEXBEM       = 0x00000043,
    D3DSIO_TEXBEML      = 0x00000044,
    D3DSIO_TEXREG2AR    = 0x00000045,
    D3DSIO_TEXREG2GB    = 0x00000046,
    D3DSIO_TEXM3x2PAD   = 0x00000047,
    D3DSIO_TEXM3x2TEX   = 0x00000048,
    D3DSIO_TEXM3x3PAD   = 0x00000049,
    D3DSIO_TEXM3x3TEX   = 0x0000004a,
    D3DSIO_RESERVED0    = 0x0000004b,
    D3DSIO_TEXM3x3SPEC  = 0x0000004c,
    D3DSIO_TEXM3x3VSPEC = 0x0000004d,
    D3DSIO_EXPP         = 0x0000004e,
    D3DSIO_LOGP         = 0x0000004f,
    D3DSIO_CND          = 0x00000050,
    D3DSIO_DEF          = 0x00000051,
    D3DSIO_TEXREG2RGB   = 0x00000052,
    D3DSIO_TEXDP3TEX    = 0x00000053,
    D3DSIO_TEXM3x2DEPTH = 0x00000054,
    D3DSIO_TEXDP3       = 0x00000055,
    D3DSIO_TEXM3x3      = 0x00000056,
    D3DSIO_TEXDEPTH     = 0x00000057,
    D3DSIO_CMP          = 0x00000058,
    D3DSIO_BEM          = 0x00000059,
    D3DSIO_DP2ADD       = 0x0000005a,
    D3DSIO_DSX          = 0x0000005b,
    D3DSIO_DSY          = 0x0000005c,
    D3DSIO_TEXLDD       = 0x0000005d,
    D3DSIO_SETP         = 0x0000005e,
    D3DSIO_TEXLDL       = 0x0000005f,
    D3DSIO_BREAKP       = 0x00000060,
    D3DSIO_PHASE        = 0x0000fffd,
    D3DSIO_COMMENT      = 0x0000fffe,
    D3DSIO_END          = 0x0000ffff,
    D3DSIO_FORCE_DWORD  = 0x7fffffff,
}

alias D3DSHADER_COMPARISON = int;
enum : int
{
    D3DSPC_RESERVED0 = 0x00000000,
    D3DSPC_GT        = 0x00000001,
    D3DSPC_EQ        = 0x00000002,
    D3DSPC_GE        = 0x00000003,
    D3DSPC_LT        = 0x00000004,
    D3DSPC_NE        = 0x00000005,
    D3DSPC_LE        = 0x00000006,
    D3DSPC_RESERVED1 = 0x00000007,
}

alias D3DSAMPLER_TEXTURE_TYPE = int;
enum : int
{
    D3DSTT_UNKNOWN     = 0x00000000,
    D3DSTT_2D          = 0x10000000,
    D3DSTT_CUBE        = 0x18000000,
    D3DSTT_VOLUME      = 0x20000000,
    D3DSTT_FORCE_DWORD = 0x7fffffff,
}

alias D3DSHADER_PARAM_REGISTER_TYPE = int;
enum : int
{
    D3DSPR_TEMP        = 0x00000000,
    D3DSPR_INPUT       = 0x00000001,
    D3DSPR_CONST       = 0x00000002,
    D3DSPR_ADDR        = 0x00000003,
    D3DSPR_TEXTURE     = 0x00000003,
    D3DSPR_RASTOUT     = 0x00000004,
    D3DSPR_ATTROUT     = 0x00000005,
    D3DSPR_TEXCRDOUT   = 0x00000006,
    D3DSPR_OUTPUT      = 0x00000006,
    D3DSPR_CONSTINT    = 0x00000007,
    D3DSPR_COLOROUT    = 0x00000008,
    D3DSPR_DEPTHOUT    = 0x00000009,
    D3DSPR_SAMPLER     = 0x0000000a,
    D3DSPR_CONST2      = 0x0000000b,
    D3DSPR_CONST3      = 0x0000000c,
    D3DSPR_CONST4      = 0x0000000d,
    D3DSPR_CONSTBOOL   = 0x0000000e,
    D3DSPR_LOOP        = 0x0000000f,
    D3DSPR_TEMPFLOAT16 = 0x00000010,
    D3DSPR_MISCTYPE    = 0x00000011,
    D3DSPR_LABEL       = 0x00000012,
    D3DSPR_PREDICATE   = 0x00000013,
    D3DSPR_FORCE_DWORD = 0x7fffffff,
}

alias D3DSHADER_MISCTYPE_OFFSETS = int;
enum : int
{
    D3DSMO_POSITION = 0x00000000,
    D3DSMO_FACE     = 0x00000001,
}

alias D3DVS_RASTOUT_OFFSETS = int;
enum : int
{
    D3DSRO_POSITION    = 0x00000000,
    D3DSRO_FOG         = 0x00000001,
    D3DSRO_POINT_SIZE  = 0x00000002,
    D3DSRO_FORCE_DWORD = 0x7fffffff,
}

alias D3DVS_ADDRESSMODE_TYPE = int;
enum : int
{
    D3DVS_ADDRMODE_ABSOLUTE    = 0x00000000,
    D3DVS_ADDRMODE_RELATIVE    = 0x00002000,
    D3DVS_ADDRMODE_FORCE_DWORD = 0x7fffffff,
}

alias D3DSHADER_ADDRESSMODE_TYPE = int;
enum : int
{
    D3DSHADER_ADDRMODE_ABSOLUTE    = 0x00000000,
    D3DSHADER_ADDRMODE_RELATIVE    = 0x00002000,
    D3DSHADER_ADDRMODE_FORCE_DWORD = 0x7fffffff,
}

alias D3DSHADER_PARAM_SRCMOD_TYPE = int;
enum : int
{
    D3DSPSM_NONE        = 0x00000000,
    D3DSPSM_NEG         = 0x01000000,
    D3DSPSM_BIAS        = 0x02000000,
    D3DSPSM_BIASNEG     = 0x03000000,
    D3DSPSM_SIGN        = 0x04000000,
    D3DSPSM_SIGNNEG     = 0x05000000,
    D3DSPSM_COMP        = 0x06000000,
    D3DSPSM_X2          = 0x07000000,
    D3DSPSM_X2NEG       = 0x08000000,
    D3DSPSM_DZ          = 0x09000000,
    D3DSPSM_DW          = 0x0a000000,
    D3DSPSM_ABS         = 0x0b000000,
    D3DSPSM_ABSNEG      = 0x0c000000,
    D3DSPSM_NOT         = 0x0d000000,
    D3DSPSM_FORCE_DWORD = 0x7fffffff,
}

alias D3DSHADER_MIN_PRECISION = int;
enum : int
{
    D3DMP_DEFAULT = 0x00000000,
    D3DMP_16      = 0x00000001,
    D3DMP_2_8     = 0x00000002,
}

alias D3DBASISTYPE = int;
enum : int
{
    D3DBASIS_BEZIER      = 0x00000000,
    D3DBASIS_BSPLINE     = 0x00000001,
    D3DBASIS_CATMULL_ROM = 0x00000002,
    D3DBASIS_FORCE_DWORD = 0x7fffffff,
}

alias D3DDEGREETYPE = int;
enum : int
{
    D3DDEGREE_LINEAR      = 0x00000001,
    D3DDEGREE_QUADRATIC   = 0x00000002,
    D3DDEGREE_CUBIC       = 0x00000003,
    D3DDEGREE_QUINTIC     = 0x00000005,
    D3DDEGREE_FORCE_DWORD = 0x7fffffff,
}

alias D3DPATCHEDGESTYLE = int;
enum : int
{
    D3DPATCHEDGE_DISCRETE    = 0x00000000,
    D3DPATCHEDGE_CONTINUOUS  = 0x00000001,
    D3DPATCHEDGE_FORCE_DWORD = 0x7fffffff,
}

alias D3DDEVTYPE = uint;
enum : uint
{
    D3DDEVTYPE_HAL         = 0x00000001,
    D3DDEVTYPE_REF         = 0x00000002,
    D3DDEVTYPE_SW          = 0x00000003,
    D3DDEVTYPE_NULLREF     = 0x00000004,
    D3DDEVTYPE_FORCE_DWORD = 0x7fffffff,
}

alias D3DMULTISAMPLE_TYPE = int;
enum : int
{
    D3DMULTISAMPLE_NONE        = 0x00000000,
    D3DMULTISAMPLE_NONMASKABLE = 0x00000001,
    D3DMULTISAMPLE_2_SAMPLES   = 0x00000002,
    D3DMULTISAMPLE_3_SAMPLES   = 0x00000003,
    D3DMULTISAMPLE_4_SAMPLES   = 0x00000004,
    D3DMULTISAMPLE_5_SAMPLES   = 0x00000005,
    D3DMULTISAMPLE_6_SAMPLES   = 0x00000006,
    D3DMULTISAMPLE_7_SAMPLES   = 0x00000007,
    D3DMULTISAMPLE_8_SAMPLES   = 0x00000008,
    D3DMULTISAMPLE_9_SAMPLES   = 0x00000009,
    D3DMULTISAMPLE_10_SAMPLES  = 0x0000000a,
    D3DMULTISAMPLE_11_SAMPLES  = 0x0000000b,
    D3DMULTISAMPLE_12_SAMPLES  = 0x0000000c,
    D3DMULTISAMPLE_13_SAMPLES  = 0x0000000d,
    D3DMULTISAMPLE_14_SAMPLES  = 0x0000000e,
    D3DMULTISAMPLE_15_SAMPLES  = 0x0000000f,
    D3DMULTISAMPLE_16_SAMPLES  = 0x00000010,
    D3DMULTISAMPLE_FORCE_DWORD = 0x7fffffff,
}

alias D3DFORMAT = uint;
enum : uint
{
    D3DFMT_UNKNOWN             = 0x00000000,
    D3DFMT_R8G8B8              = 0x00000014,
    D3DFMT_A8R8G8B8            = 0x00000015,
    D3DFMT_X8R8G8B8            = 0x00000016,
    D3DFMT_R5G6B5              = 0x00000017,
    D3DFMT_X1R5G5B5            = 0x00000018,
    D3DFMT_A1R5G5B5            = 0x00000019,
    D3DFMT_A4R4G4B4            = 0x0000001a,
    D3DFMT_R3G3B2              = 0x0000001b,
    D3DFMT_A8                  = 0x0000001c,
    D3DFMT_A8R3G3B2            = 0x0000001d,
    D3DFMT_X4R4G4B4            = 0x0000001e,
    D3DFMT_A2B10G10R10         = 0x0000001f,
    D3DFMT_A8B8G8R8            = 0x00000020,
    D3DFMT_X8B8G8R8            = 0x00000021,
    D3DFMT_G16R16              = 0x00000022,
    D3DFMT_A2R10G10B10         = 0x00000023,
    D3DFMT_A16B16G16R16        = 0x00000024,
    D3DFMT_A8P8                = 0x00000028,
    D3DFMT_P8                  = 0x00000029,
    D3DFMT_L8                  = 0x00000032,
    D3DFMT_A8L8                = 0x00000033,
    D3DFMT_A4L4                = 0x00000034,
    D3DFMT_V8U8                = 0x0000003c,
    D3DFMT_L6V5U5              = 0x0000003d,
    D3DFMT_X8L8V8U8            = 0x0000003e,
    D3DFMT_Q8W8V8U8            = 0x0000003f,
    D3DFMT_V16U16              = 0x00000040,
    D3DFMT_A2W10V10U10         = 0x00000043,
    D3DFMT_UYVY                = 0x59565955,
    D3DFMT_R8G8_B8G8           = 0x47424752,
    D3DFMT_YUY2                = 0x32595559,
    D3DFMT_G8R8_G8B8           = 0x42475247,
    D3DFMT_DXT1                = 0x31545844,
    D3DFMT_DXT2                = 0x32545844,
    D3DFMT_DXT3                = 0x33545844,
    D3DFMT_DXT4                = 0x34545844,
    D3DFMT_DXT5                = 0x35545844,
    D3DFMT_D16_LOCKABLE        = 0x00000046,
    D3DFMT_D32                 = 0x00000047,
    D3DFMT_D15S1               = 0x00000049,
    D3DFMT_D24S8               = 0x0000004b,
    D3DFMT_D24X8               = 0x0000004d,
    D3DFMT_D24X4S4             = 0x0000004f,
    D3DFMT_D16                 = 0x00000050,
    D3DFMT_D32F_LOCKABLE       = 0x00000052,
    D3DFMT_D24FS8              = 0x00000053,
    D3DFMT_D32_LOCKABLE        = 0x00000054,
    D3DFMT_S8_LOCKABLE         = 0x00000055,
    D3DFMT_L16                 = 0x00000051,
    D3DFMT_VERTEXDATA          = 0x00000064,
    D3DFMT_INDEX16             = 0x00000065,
    D3DFMT_INDEX32             = 0x00000066,
    D3DFMT_Q16W16V16U16        = 0x0000006e,
    D3DFMT_MULTI2_ARGB8        = 0x3154454d,
    D3DFMT_R16F                = 0x0000006f,
    D3DFMT_G16R16F             = 0x00000070,
    D3DFMT_A16B16G16R16F       = 0x00000071,
    D3DFMT_R32F                = 0x00000072,
    D3DFMT_G32R32F             = 0x00000073,
    D3DFMT_A32B32G32R32F       = 0x00000074,
    D3DFMT_CxV8U8              = 0x00000075,
    D3DFMT_A1                  = 0x00000076,
    D3DFMT_A2B10G10R10_XR_BIAS = 0x00000077,
    D3DFMT_BINARYBUFFER        = 0x000000c7,
    D3DFMT_FORCE_DWORD         = 0x7fffffff,
}

alias D3DSWAPEFFECT = uint;
enum : uint
{
    D3DSWAPEFFECT_DISCARD     = 0x00000001,
    D3DSWAPEFFECT_FLIP        = 0x00000002,
    D3DSWAPEFFECT_COPY        = 0x00000003,
    D3DSWAPEFFECT_OVERLAY     = 0x00000004,
    D3DSWAPEFFECT_FLIPEX      = 0x00000005,
    D3DSWAPEFFECT_FORCE_DWORD = 0x7fffffff,
}

alias D3DPOOL = uint;
enum : uint
{
    D3DPOOL_DEFAULT     = 0x00000000,
    D3DPOOL_MANAGED     = 0x00000001,
    D3DPOOL_SYSTEMMEM   = 0x00000002,
    D3DPOOL_SCRATCH     = 0x00000003,
    D3DPOOL_FORCE_DWORD = 0x7fffffff,
}

alias D3DBACKBUFFER_TYPE = uint;
enum : uint
{
    D3DBACKBUFFER_TYPE_MONO        = 0x00000000,
    D3DBACKBUFFER_TYPE_LEFT        = 0x00000001,
    D3DBACKBUFFER_TYPE_RIGHT       = 0x00000002,
    D3DBACKBUFFER_TYPE_FORCE_DWORD = 0x7fffffff,
}

alias D3DRESOURCETYPE = int;
enum : int
{
    D3DRTYPE_SURFACE       = 0x00000001,
    D3DRTYPE_VOLUME        = 0x00000002,
    D3DRTYPE_TEXTURE       = 0x00000003,
    D3DRTYPE_VOLUMETEXTURE = 0x00000004,
    D3DRTYPE_CUBETEXTURE   = 0x00000005,
    D3DRTYPE_VERTEXBUFFER  = 0x00000006,
    D3DRTYPE_INDEXBUFFER   = 0x00000007,
    D3DRTYPE_FORCE_DWORD   = 0x7fffffff,
}

alias D3DCUBEMAP_FACES = int;
enum : int
{
    D3DCUBEMAP_FACE_POSITIVE_X  = 0x00000000,
    D3DCUBEMAP_FACE_NEGATIVE_X  = 0x00000001,
    D3DCUBEMAP_FACE_POSITIVE_Y  = 0x00000002,
    D3DCUBEMAP_FACE_NEGATIVE_Y  = 0x00000003,
    D3DCUBEMAP_FACE_POSITIVE_Z  = 0x00000004,
    D3DCUBEMAP_FACE_NEGATIVE_Z  = 0x00000005,
    D3DCUBEMAP_FACE_FORCE_DWORD = 0x7fffffff,
}

alias D3DDEBUGMONITORTOKENS = int;
enum : int
{
    D3DDMT_ENABLE      = 0x00000000,
    D3DDMT_DISABLE     = 0x00000001,
    D3DDMT_FORCE_DWORD = 0x7fffffff,
}

alias D3DQUERYTYPE = int;
enum : int
{
    D3DQUERYTYPE_VCACHE            = 0x00000004,
    D3DQUERYTYPE_RESOURCEMANAGER   = 0x00000005,
    D3DQUERYTYPE_VERTEXSTATS       = 0x00000006,
    D3DQUERYTYPE_EVENT             = 0x00000008,
    D3DQUERYTYPE_OCCLUSION         = 0x00000009,
    D3DQUERYTYPE_TIMESTAMP         = 0x0000000a,
    D3DQUERYTYPE_TIMESTAMPDISJOINT = 0x0000000b,
    D3DQUERYTYPE_TIMESTAMPFREQ     = 0x0000000c,
    D3DQUERYTYPE_PIPELINETIMINGS   = 0x0000000d,
    D3DQUERYTYPE_INTERFACETIMINGS  = 0x0000000e,
    D3DQUERYTYPE_VERTEXTIMINGS     = 0x0000000f,
    D3DQUERYTYPE_PIXELTIMINGS      = 0x00000010,
    D3DQUERYTYPE_BANDWIDTHTIMINGS  = 0x00000011,
    D3DQUERYTYPE_CACHEUTILIZATION  = 0x00000012,
    D3DQUERYTYPE_MEMORYPRESSURE    = 0x00000013,
}

alias D3DCOMPOSERECTSOP = int;
enum : int
{
    D3DCOMPOSERECTS_COPY        = 0x00000001,
    D3DCOMPOSERECTS_OR          = 0x00000002,
    D3DCOMPOSERECTS_AND         = 0x00000003,
    D3DCOMPOSERECTS_NEG         = 0x00000004,
    D3DCOMPOSERECTS_FORCE_DWORD = 0x7fffffff,
}

alias D3DSCANLINEORDERING = int;
enum : int
{
    D3DSCANLINEORDERING_UNKNOWN     = 0x00000000,
    D3DSCANLINEORDERING_PROGRESSIVE = 0x00000001,
    D3DSCANLINEORDERING_INTERLACED  = 0x00000002,
}

alias D3DDISPLAYROTATION = int;
enum : int
{
    D3DDISPLAYROTATION_IDENTITY = 0x00000001,
    D3DDISPLAYROTATION_90       = 0x00000002,
    D3DDISPLAYROTATION_180      = 0x00000003,
    D3DDISPLAYROTATION_270      = 0x00000004,
}

alias D3DAUTHENTICATEDCHANNELTYPE = int;
enum : int
{
    D3DAUTHENTICATEDCHANNEL_D3D9            = 0x00000001,
    D3DAUTHENTICATEDCHANNEL_DRIVER_SOFTWARE = 0x00000002,
    D3DAUTHENTICATEDCHANNEL_DRIVER_HARDWARE = 0x00000003,
}

alias D3DAUTHENTICATEDCHANNEL_PROCESSIDENTIFIERTYPE = int;
enum : int
{
    PROCESSIDTYPE_UNKNOWN = 0x00000000,
    PROCESSIDTYPE_DWM     = 0x00000001,
    PROCESSIDTYPE_HANDLE  = 0x00000002,
}

alias D3DBUSTYPE = int;
enum : int
{
    D3DBUSTYPE_OTHER                                            = 0x00000000,
    D3DBUSTYPE_PCI                                              = 0x00000001,
    D3DBUSTYPE_PCIX                                             = 0x00000002,
    D3DBUSTYPE_PCIEXPRESS                                       = 0x00000003,
    D3DBUSTYPE_AGP                                              = 0x00000004,
    D3DBUSIMPL_MODIFIER_INSIDE_OF_CHIPSET                       = 0x00010000,
    D3DBUSIMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_CHIP          = 0x00020000,
    D3DBUSIMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_SOCKET        = 0x00030000,
    D3DBUSIMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR                = 0x00040000,
    D3DBUSIMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR_INSIDE_OF_NUAE = 0x00050000,
    D3DBUSIMPL_MODIFIER_NON_STANDARD                            = 0x80000000,
}

// Structs


struct D3DMATRIX
{
union
    {
struct
        {
            float _11;
            float _12;
            float _13;
            float _14;
            float _21;
            float _22;
            float _23;
            float _24;
            float _31;
            float _32;
            float _33;
            float _34;
            float _41;
            float _42;
            float _43;
            float _44;
        }
        float[16] m;
    }
}

struct D3DVIEWPORT9
{
    uint  X;
    uint  Y;
    uint  Width;
    uint  Height;
    float MinZ;
    float MaxZ;
}

struct D3DCLIPSTATUS9
{
    uint ClipUnion;
    uint ClipIntersection;
}

struct D3DMATERIAL9
{
    DXGI_RGBA Diffuse;
    DXGI_RGBA Ambient;
    DXGI_RGBA Specular;
    DXGI_RGBA Emissive;
    float     Power;
}

struct D3DLIGHT9
{
    D3DLIGHTTYPE Type;
    DXGI_RGBA    Diffuse;
    DXGI_RGBA    Specular;
    DXGI_RGBA    Ambient;
    D3DVECTOR    Position;
    D3DVECTOR    Direction;
    float        Range;
    float        Falloff;
    float        Attenuation0;
    float        Attenuation1;
    float        Attenuation2;
    float        Theta;
    float        Phi;
}

struct D3DVERTEXELEMENT9
{
    ushort Stream;
    ushort Offset;
    ubyte  Type;
    ubyte  Method;
    ubyte  Usage;
    ubyte  UsageIndex;
}

struct D3DDISPLAYMODE
{
    uint      Width;
    uint      Height;
    uint      RefreshRate;
    D3DFORMAT Format;
}

struct D3DDEVICE_CREATION_PARAMETERS
{
    uint       AdapterOrdinal;
    D3DDEVTYPE DeviceType;
    HWND       hFocusWindow;
    uint       BehaviorFlags;
}

struct D3DPRESENT_PARAMETERS
{
    uint                BackBufferWidth;
    uint                BackBufferHeight;
    D3DFORMAT           BackBufferFormat;
    uint                BackBufferCount;
    D3DMULTISAMPLE_TYPE MultiSampleType;
    uint                MultiSampleQuality;
    D3DSWAPEFFECT       SwapEffect;
    HWND                hDeviceWindow;
    BOOL                Windowed;
    BOOL                EnableAutoDepthStencil;
    D3DFORMAT           AutoDepthStencilFormat;
    uint                Flags;
    uint                FullScreen_RefreshRateInHz;
    uint                PresentationInterval;
}

struct D3DGAMMARAMP
{
    ushort[256] red;
    ushort[256] green;
    ushort[256] blue;
}

struct D3DVERTEXBUFFER_DESC
{
    D3DFORMAT       Format;
    D3DRESOURCETYPE Type;
    uint            Usage;
    D3DPOOL         Pool;
    uint            Size;
    uint            FVF;
}

struct D3DINDEXBUFFER_DESC
{
    D3DFORMAT       Format;
    D3DRESOURCETYPE Type;
    uint            Usage;
    D3DPOOL         Pool;
    uint            Size;
}

struct D3DSURFACE_DESC
{
    D3DFORMAT           Format;
    D3DRESOURCETYPE     Type;
    uint                Usage;
    D3DPOOL             Pool;
    D3DMULTISAMPLE_TYPE MultiSampleType;
    uint                MultiSampleQuality;
    uint                Width;
    uint                Height;
}

struct D3DVOLUME_DESC
{
    D3DFORMAT       Format;
    D3DRESOURCETYPE Type;
    uint            Usage;
    D3DPOOL         Pool;
    uint            Width;
    uint            Height;
    uint            Depth;
}

struct D3DLOCKED_RECT
{
    int   Pitch;
    void* pBits;
}

struct D3DBOX
{
    uint Left;
    uint Top;
    uint Right;
    uint Bottom;
    uint Front;
    uint Back;
}

struct D3DLOCKED_BOX
{
    int   RowPitch;
    int   SlicePitch;
    void* pBits;
}

struct D3DRANGE
{
    uint Offset;
    uint Size;
}

struct D3DRECTPATCH_INFO
{
    uint          StartVertexOffsetWidth;
    uint          StartVertexOffsetHeight;
    uint          Width;
    uint          Height;
    uint          Stride;
    D3DBASISTYPE  Basis;
    D3DDEGREETYPE Degree;
}

struct D3DTRIPATCH_INFO
{
    uint          StartVertexOffset;
    uint          NumVertices;
    D3DBASISTYPE  Basis;
    D3DDEGREETYPE Degree;
}

struct D3DADAPTER_IDENTIFIER9
{
align (4):
    byte[512]     Driver;
    byte[512]     Description;
    byte[32]      DeviceName;
    LARGE_INTEGER DriverVersion;
    uint          VendorId;
    uint          DeviceId;
    uint          SubSysId;
    uint          Revision;
    GUID          DeviceIdentifier;
    uint          WHQLLevel;
}

struct D3DRASTER_STATUS
{
    BOOL InVBlank;
    uint ScanLine;
}

struct D3DRESOURCESTATS
{
    BOOL bThrashing;
    uint ApproxBytesDownloaded;
    uint NumEvicts;
    uint NumVidCreates;
    uint LastPri;
    uint NumUsed;
    uint NumUsedInVidMem;
    uint WorkingSet;
    uint WorkingSetBytes;
    uint TotalManaged;
    uint TotalBytes;
}

struct D3DDEVINFO_RESOURCEMANAGER
{
    D3DRESOURCESTATS[8] stats;
}

struct D3DDEVINFO_D3DVERTEXSTATS
{
    uint NumRenderedTriangles;
    uint NumExtraClippingTriangles;
}

struct D3DDEVINFO_VCACHE
{
    uint Pattern;
    uint OptMethod;
    uint CacheSize;
    uint MagicNumber;
}

struct D3DDEVINFO_D3D9PIPELINETIMINGS
{
    float VertexProcessingTimePercent;
    float PixelProcessingTimePercent;
    float OtherGPUProcessingTimePercent;
    float GPUIdleTimePercent;
}

struct D3DDEVINFO_D3D9INTERFACETIMINGS
{
    float WaitingForGPUToUseApplicationResourceTimePercent;
    float WaitingForGPUToAcceptMoreCommandsTimePercent;
    float WaitingForGPUToStayWithinLatencyTimePercent;
    float WaitingForGPUExclusiveResourceTimePercent;
    float WaitingForGPUOtherTimePercent;
}

struct D3DDEVINFO_D3D9STAGETIMINGS
{
    float MemoryProcessingPercent;
    float ComputationProcessingPercent;
}

struct D3DDEVINFO_D3D9BANDWIDTHTIMINGS
{
    float MaxBandwidthUtilized;
    float FrontEndUploadMemoryUtilizedPercent;
    float VertexRateUtilizedPercent;
    float TriangleSetupRateUtilizedPercent;
    float FillRateUtilizedPercent;
}

struct D3DDEVINFO_D3D9CACHEUTILIZATION
{
    float TextureCacheHitRate;
    float PostTransformVertexCacheHitRate;
}

struct D3DMEMORYPRESSURE
{
align (4):
    ulong BytesEvictedFromProcess;
    ulong SizeOfInefficientAllocation;
    uint  LevelOfEfficiency;
}

struct D3DCOMPOSERECTDESC
{
    ushort X;
    ushort Y;
    ushort Width;
    ushort Height;
}

struct D3DCOMPOSERECTDESTINATION
{
    ushort SrcRectIndex;
    ushort Reserved;
    short  X;
    short  Y;
}

struct D3DPRESENTSTATS
{
align (4):
    uint          PresentCount;
    uint          PresentRefreshCount;
    uint          SyncRefreshCount;
    LARGE_INTEGER SyncQPCTime;
    LARGE_INTEGER SyncGPUTime;
}

struct D3DDISPLAYMODEEX
{
    uint                Size;
    uint                Width;
    uint                Height;
    uint                RefreshRate;
    D3DFORMAT           Format;
    D3DSCANLINEORDERING ScanLineOrdering;
}

struct D3DDISPLAYMODEFILTER
{
    uint                Size;
    D3DFORMAT           Format;
    D3DSCANLINEORDERING ScanLineOrdering;
}

struct D3D_OMAC
{
    ubyte[16] Omac;
}

struct D3DAUTHENTICATEDCHANNEL_QUERY_INPUT
{
    GUID   QueryType;
    HANDLE hChannel;
    uint   SequenceNumber;
}

struct D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
{
    D3D_OMAC omac;
    GUID     QueryType;
    HANDLE   hChannel;
    uint     SequenceNumber;
    HRESULT  ReturnCode;
}

struct D3DAUTHENTICATEDCHANNEL_PROTECTION_FLAGS
{
union
    {
struct
        {
            uint _bitfield13;
        }
        uint Value;
    }
}

struct D3DAUTHENTICATEDCHANNEL_QUERYPROTECTION_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    D3DAUTHENTICATEDCHANNEL_PROTECTION_FLAGS ProtectionFlags;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYCHANNELTYPE_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    D3DAUTHENTICATEDCHANNELTYPE ChannelType;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYDEVICEHANDLE_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    HANDLE DeviceHandle;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYCRYPTOSESSION_INPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_INPUT Input;
    HANDLE DXVA2DecodeHandle;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYCRYPTOSESSION_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    HANDLE DXVA2DecodeHandle;
    HANDLE CryptoSessionHandle;
    HANDLE DeviceHandle;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYRESTRICTEDSHAREDRESOURCEPROCESSCOUNT_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    uint NumRestrictedSharedResourceProcesses;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYRESTRICTEDSHAREDRESOURCEPROCESS_INPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_INPUT Input;
    uint ProcessIndex;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYRESTRICTEDSHAREDRESOURCEPROCESS_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    uint   ProcessIndex;
    D3DAUTHENTICATEDCHANNEL_PROCESSIDENTIFIERTYPE ProcessIdentifer;
    HANDLE ProcessHandle;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYUNRESTRICTEDPROTECTEDSHAREDRESOURCECOUNT_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    uint NumUnrestrictedProtectedSharedResources;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTIDCOUNT_INPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_INPUT Input;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTIDCOUNT_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
    uint   NumOutputIDs;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTID_INPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_INPUT Input;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
    uint   OutputIDIndex;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTID_OUTPUT
{
align (4):
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
    uint   OutputIDIndex;
    ulong  OutputID;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYINFOBUSTYPE_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    D3DBUSTYPE BusType;
    BOOL       bAccessibleInContiguousBlocks;
    BOOL       bAccessibleInNonContiguousBlocks;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYEVICTIONENCRYPTIONGUIDCOUNT_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    uint NumEncryptionGuids;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYEVICTIONENCRYPTIONGUID_INPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_INPUT Input;
    uint EncryptionGuidIndex;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYEVICTIONENCRYPTIONGUID_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    uint EncryptionGuidIndex;
    GUID EncryptionGuid;
}

struct D3DAUTHENTICATEDCHANNEL_QUERYUNCOMPRESSEDENCRYPTIONLEVEL_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    GUID EncryptionGuid;
}

struct D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT
{
    D3D_OMAC omac;
    GUID     ConfigureType;
    HANDLE   hChannel;
    uint     SequenceNumber;
}

struct D3DAUTHENTICATEDCHANNEL_CONFIGURE_OUTPUT
{
    D3D_OMAC omac;
    GUID     ConfigureType;
    HANDLE   hChannel;
    uint     SequenceNumber;
    HRESULT  ReturnCode;
}

struct D3DAUTHENTICATEDCHANNEL_CONFIGUREINITIALIZE
{
    D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT Parameters;
    uint StartSequenceQuery;
    uint StartSequenceConfigure;
}

struct D3DAUTHENTICATEDCHANNEL_CONFIGUREPROTECTION
{
    D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT Parameters;
    D3DAUTHENTICATEDCHANNEL_PROTECTION_FLAGS Protections;
}

struct D3DAUTHENTICATEDCHANNEL_CONFIGURECRYPTOSESSION
{
    D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT Parameters;
    HANDLE DXVA2DecodeHandle;
    HANDLE CryptoSessionHandle;
    HANDLE DeviceHandle;
}

struct D3DAUTHENTICATEDCHANNEL_CONFIGURESHAREDRESOURCE
{
    D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT Parameters;
    D3DAUTHENTICATEDCHANNEL_PROCESSIDENTIFIERTYPE ProcessIdentiferType;
    HANDLE ProcessHandle;
    BOOL   AllowAccess;
}

struct D3DAUTHENTICATEDCHANNEL_CONFIGUREUNCOMPRESSEDENCRYPTION
{
    D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT Parameters;
    GUID EncryptionGuid;
}

struct D3DENCRYPTED_BLOCK_INFO
{
    uint NumEncryptedBytesAtBeginning;
    uint NumBytesInSkipPattern;
    uint NumBytesInEncryptPattern;
}

struct D3DAES_CTR_IV
{
align (4):
    ulong IV;
    ulong Count;
}

///Vertex shader caps.
struct D3DVSHADERCAPS2_0
{
    ///Type: <b>DWORD</b> Instruction predication is supported if this value is nonzero. See setp_comp - vs.
    uint Caps;
    ///Type: <b>INT</b> Either 0 or 24, which represents the depth of the dynamic flow control instruction nesting. See
    ///D3DVS20CAPS.
    int  DynamicFlowControlDepth;
    ///Type: <b>INT</b> The number of temporary registers supported. See D3DVS20CAPS.
    int  NumTemps;
    ///Type: <b>INT</b> The depth of nesting of the loop - vs/rep - vs and call - vs/callnz bool - vs instructions. See
    ///D3DVS20CAPS.
    int  StaticFlowControlDepth;
}

///Pixel shader driver caps.
struct D3DPSHADERCAPS2_0
{
    ///Type: <b>DWORD</b> Instruction predication is supported if this value is nonzero. See setp_comp - vs.
    uint Caps;
    ///Type: <b>INT</b> Either 0 or 24, which represents the depth of the dynamic flow control instruction nesting. See
    ///<b>D3DPSHADERCAPS2_0</b>.
    int  DynamicFlowControlDepth;
    ///Type: <b>INT</b> The number of temporary registers supported. See <b>D3DPSHADERCAPS2_0</b>.
    int  NumTemps;
    ///Type: <b>INT</b> The depth of nesting of the loop - vs/rep - vs and call - vs/callnz bool - vs instructions. See
    ///<b>D3DPSHADERCAPS2_0</b>.
    int  StaticFlowControlDepth;
    ///Type: <b>INT</b> The number of instruction slots supported. See <b>D3DPSHADERCAPS2_0</b>.
    int  NumInstructionSlots;
}

///Represents the capabilities of the hardware exposed through the Direct3D object.
struct D3DCAPS9
{
    ///Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type, which identifies what type of resources are
    ///used for processing vertices.
    D3DDEVTYPE        DeviceType;
    ///Type: <b>UINT</b> Adapter on which this Direct3D device was created. This ordinal is valid only to pass to
    ///methods of the IDirect3D9 interface that created this Direct3D device. The <b>IDirect3D9</b> interface can always
    ///be retrieved by calling GetDirect3D.
    uint              AdapterOrdinal;
    ///Type: <b>DWORD</b> The following driver-specific capability. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="D3DCAPS_READ_SCANLINE"></a><a id="d3dcaps_read_scanline"></a><dl>
    ///<dt><b>D3DCAPS_READ_SCANLINE</b></dt> </dl> </td> <td width="60%"> Display hardware is capable of returning the
    ///current scan line. </td> </tr> <tr> <td width="40%"><a id="D3DCAPS_OVERLAY"></a><a id="d3dcaps_overlay"></a><dl>
    ///<dt><b>D3DCAPS_OVERLAY</b></dt> </dl> </td> <td width="60%"> The display driver supports an overlay DDI that
    ///allows for verification of overlay capabilities. For more information about the overlay DDI, see Overlay DDI.
    ///<table> <tr> <td> Differences between Direct3D 9 and Direct3D 9Ex: This flag is available in Direct3D 9Ex only.
    ///</td> </tr> </table> </td> </tr> </table>
    uint              Caps;
    ///Type: <b>DWORD</b> Driver-specific capabilities identified in D3DCAPS2.
    uint              Caps2;
    ///Type: <b>DWORD</b> Driver-specific capabilities identified in D3DCAPS3.
    uint              Caps3;
    ///Type: <b>DWORD</b> Bit mask of values representing what presentation swap intervals are available. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DPRESENT_INTERVAL_IMMEDIATE"></a><a
    ///id="d3dpresent_interval_immediate"></a><dl> <dt><b>D3DPRESENT_INTERVAL_IMMEDIATE</b></dt> </dl> </td> <td
    ///width="60%"> The driver supports an immediate presentation swap interval. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRESENT_INTERVAL_ONE"></a><a id="d3dpresent_interval_one"></a><dl> <dt><b>D3DPRESENT_INTERVAL_ONE</b></dt>
    ///</dl> </td> <td width="60%"> The driver supports a presentation swap interval of every screen refresh. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPRESENT_INTERVAL_TWO"></a><a id="d3dpresent_interval_two"></a><dl>
    ///<dt><b>D3DPRESENT_INTERVAL_TWO</b></dt> </dl> </td> <td width="60%"> The driver supports a presentation swap
    ///interval of every second screen refresh. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRESENT_INTERVAL_THREE"></a><a id="d3dpresent_interval_three"></a><dl>
    ///<dt><b>D3DPRESENT_INTERVAL_THREE</b></dt> </dl> </td> <td width="60%"> The driver supports a presentation swap
    ///interval of every third screen refresh. </td> </tr> <tr> <td width="40%"><a id="D3DPRESENT_INTERVAL_FOUR"></a><a
    ///id="d3dpresent_interval_four"></a><dl> <dt><b>D3DPRESENT_INTERVAL_FOUR</b></dt> </dl> </td> <td width="60%"> The
    ///driver supports a presentation swap interval of every fourth screen refresh. </td> </tr> </table>
    uint              PresentationIntervals;
    ///Type: <b>DWORD</b> Bit mask indicating what hardware support is available for cursors. Direct3D 9 does not define
    ///alpha-blending cursor capabilities. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="D3DCURSORCAPS_COLOR"></a><a id="d3dcursorcaps_color"></a><dl> <dt><b>D3DCURSORCAPS_COLOR</b></dt> </dl> </td>
    ///<td width="60%"> A full-color cursor is supported in hardware. Specifically, this flag indicates that the driver
    ///supports at least a hardware color cursor in high-resolution modes (with scan lines greater than or equal to
    ///400). </td> </tr> <tr> <td width="40%"><a id="D3DCURSORCAPS_LOWRES"></a><a id="d3dcursorcaps_lowres"></a><dl>
    ///<dt><b>D3DCURSORCAPS_LOWRES</b></dt> </dl> </td> <td width="60%"> A full-color cursor is supported in hardware.
    ///Specifically, this flag indicates that the driver supports a hardware color cursor in both high-resolution and
    ///low-resolution modes (with scan lines less than 400). </td> </tr> </table>
    uint              CursorCaps;
    ///Type: <b>DWORD</b> Flags identifying the capabilities of the device. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="D3DDEVCAPS_CANBLTSYSTONONLOCAL"></a><a
    ///id="d3ddevcaps_canbltsystononlocal"></a><dl> <dt><b>D3DDEVCAPS_CANBLTSYSTONONLOCAL</b></dt> </dl> </td> <td
    ///width="60%"> Device supports blits from system-memory textures to nonlocal video-memory textures. </td> </tr>
    ///<tr> <td width="40%"><a id="D3DDEVCAPS_CANRENDERAFTERFLIP"></a><a id="d3ddevcaps_canrenderafterflip"></a><dl>
    ///<dt><b>D3DDEVCAPS_CANRENDERAFTERFLIP</b></dt> </dl> </td> <td width="60%"> Device can queue rendering commands
    ///after a page flip. Applications do not change their behavior if this flag is set; this capability means that the
    ///device is relatively fast. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_DRAWPRIMITIVES2"></a><a
    ///id="d3ddevcaps_drawprimitives2"></a><dl> <dt><b>D3DDEVCAPS_DRAWPRIMITIVES2</b></dt> </dl> </td> <td width="60%">
    ///Device can support at least a DirectX 5-compliant driver. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_DRAWPRIMITIVES2EX"></a><a id="d3ddevcaps_drawprimitives2ex"></a><dl>
    ///<dt><b>D3DDEVCAPS_DRAWPRIMITIVES2EX</b></dt> </dl> </td> <td width="60%"> Device can support at least a DirectX
    ///7-compliant driver. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_DRAWPRIMTLVERTEX"></a><a
    ///id="d3ddevcaps_drawprimtlvertex"></a><dl> <dt><b>D3DDEVCAPS_DRAWPRIMTLVERTEX</b></dt> </dl> </td> <td
    ///width="60%"> Device exports an IDirect3DDevice9::DrawPrimitive-aware hal. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_EXECUTESYSTEMMEMORY"></a><a id="d3ddevcaps_executesystemmemory"></a><dl>
    ///<dt><b>D3DDEVCAPS_EXECUTESYSTEMMEMORY</b></dt> </dl> </td> <td width="60%"> Device can use execute buffers from
    ///system memory. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_EXECUTEVIDEOMEMORY"></a><a
    ///id="d3ddevcaps_executevideomemory"></a><dl> <dt><b>D3DDEVCAPS_EXECUTEVIDEOMEMORY</b></dt> </dl> </td> <td
    ///width="60%"> Device can use execute buffers from video memory. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_HWRASTERIZATION"></a><a id="d3ddevcaps_hwrasterization"></a><dl>
    ///<dt><b>D3DDEVCAPS_HWRASTERIZATION</b></dt> </dl> </td> <td width="60%"> Device has hardware acceleration for
    ///scene rasterization. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_HWTRANSFORMANDLIGHT"></a><a
    ///id="d3ddevcaps_hwtransformandlight"></a><dl> <dt><b>D3DDEVCAPS_HWTRANSFORMANDLIGHT</b></dt> </dl> </td> <td
    ///width="60%"> Device can support transformation and lighting in hardware. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_NPATCHES"></a><a id="d3ddevcaps_npatches"></a><dl> <dt><b>D3DDEVCAPS_NPATCHES</b></dt> </dl> </td>
    ///<td width="60%"> Device supports N patches. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_PUREDEVICE"></a><a
    ///id="d3ddevcaps_puredevice"></a><dl> <dt><b>D3DDEVCAPS_PUREDEVICE</b></dt> </dl> </td> <td width="60%"> Device can
    ///support rasterization, transform, lighting, and shading in hardware. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_QUINTICRTPATCHES"></a><a id="d3ddevcaps_quinticrtpatches"></a><dl>
    ///<dt><b>D3DDEVCAPS_QUINTICRTPATCHES</b></dt> </dl> </td> <td width="60%"> Device supports quintic Bézier curves
    ///and B-splines. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_RTPATCHES"></a><a
    ///id="d3ddevcaps_rtpatches"></a><dl> <dt><b>D3DDEVCAPS_RTPATCHES</b></dt> </dl> </td> <td width="60%"> Device
    ///supports rectangular and triangular patches. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_RTPATCHHANDLEZERO"></a><a id="d3ddevcaps_rtpatchhandlezero"></a><dl>
    ///<dt><b>D3DDEVCAPS_RTPATCHHANDLEZERO</b></dt> </dl> </td> <td width="60%"> When this device capability is set, the
    ///hardware architecture does not require caching of any information, and uncached patches (handle zero) will be
    ///drawn as efficiently as cached ones. Note that setting D3DDEVCAPS_RTPATCHHANDLEZERO does not mean that a patch
    ///with handle zero can be drawn. A handle-zero patch can always be drawn whether this cap is set or not. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DDEVCAPS_SEPARATETEXTUREMEMORIES"></a><a
    ///id="d3ddevcaps_separatetexturememories"></a><dl> <dt><b>D3DDEVCAPS_SEPARATETEXTUREMEMORIES</b></dt> </dl> </td>
    ///<td width="60%"> Device is texturing from separate memory pools. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_TEXTURENONLOCALVIDMEM"></a><a id="d3ddevcaps_texturenonlocalvidmem"></a><dl>
    ///<dt><b>D3DDEVCAPS_TEXTURENONLOCALVIDMEM</b></dt> </dl> </td> <td width="60%"> Device can retrieve textures from
    ///non-local video memory. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_TEXTURESYSTEMMEMORY"></a><a
    ///id="d3ddevcaps_texturesystemmemory"></a><dl> <dt><b>D3DDEVCAPS_TEXTURESYSTEMMEMORY</b></dt> </dl> </td> <td
    ///width="60%"> Device can retrieve textures from system memory. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_TEXTUREVIDEOMEMORY"></a><a id="d3ddevcaps_texturevideomemory"></a><dl>
    ///<dt><b>D3DDEVCAPS_TEXTUREVIDEOMEMORY</b></dt> </dl> </td> <td width="60%"> Device can retrieve textures from
    ///device memory. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_TLVERTEXSYSTEMMEMORY"></a><a
    ///id="d3ddevcaps_tlvertexsystemmemory"></a><dl> <dt><b>D3DDEVCAPS_TLVERTEXSYSTEMMEMORY</b></dt> </dl> </td> <td
    ///width="60%"> Device can use buffers from system memory for transformed and lit vertices. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DDEVCAPS_TLVERTEXVIDEOMEMORY"></a><a id="d3ddevcaps_tlvertexvideomemory"></a><dl>
    ///<dt><b>D3DDEVCAPS_TLVERTEXVIDEOMEMORY</b></dt> </dl> </td> <td width="60%"> Device can use buffers from video
    ///memory for transformed and lit vertices. </td> </tr> </table>
    uint              DevCaps;
    ///Type: <b>DWORD</b> Miscellaneous driver primitive capabilities. See D3DPMISCCAPS.
    uint              PrimitiveMiscCaps;
    ///Type: <b>DWORD</b> Information on raster-drawing capabilities. This member can be one or more of the following
    ///flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_ANISOTROPY"></a><a id="d3dprastercaps_anisotropy"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_ANISOTROPY</b></dt> </dl> </td> <td width="60%"> Device supports anisotropic filtering.
    ///</td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_COLORPERSPECTIVE"></a><a
    ///id="d3dprastercaps_colorperspective"></a><dl> <dt><b>D3DPRASTERCAPS_COLORPERSPECTIVE</b></dt> </dl> </td> <td
    ///width="60%"> Device iterates colors perspective correctly. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_DITHER"></a><a id="d3dprastercaps_dither"></a><dl> <dt><b>D3DPRASTERCAPS_DITHER</b></dt> </dl>
    ///</td> <td width="60%"> Device can dither to improve color resolution. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_DEPTHBIAS"></a><a id="d3dprastercaps_depthbias"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_DEPTHBIAS</b></dt> </dl> </td> <td width="60%"> Device supports legacy depth bias. For true
    ///depth bias, see D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_FOGRANGE"></a><a id="d3dprastercaps_fogrange"></a><dl> <dt><b>D3DPRASTERCAPS_FOGRANGE</b></dt>
    ///</dl> </td> <td width="60%"> Device supports range-based fog. In range-based fog, the distance of an object from
    ///the viewer is used to compute fog effects, not the depth of the object (that is, the z-coordinate) in the scene.
    ///</td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_FOGTABLE"></a><a id="d3dprastercaps_fogtable"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_FOGTABLE</b></dt> </dl> </td> <td width="60%"> Device calculates the fog value by referring
    ///to a lookup table containing fog values that are indexed to the depth of a given pixel. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPRASTERCAPS_FOGVERTEX"></a><a id="d3dprastercaps_fogvertex"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_FOGVERTEX</b></dt> </dl> </td> <td width="60%"> Device calculates the fog value during the
    ///lighting operation and interpolates the fog value during rasterization. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_MIPMAPLODBIAS"></a><a id="d3dprastercaps_mipmaplodbias"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_MIPMAPLODBIAS</b></dt> </dl> </td> <td width="60%"> Device supports level-of-detail bias
    ///adjustments. These bias adjustments enable an application to make a mipmap appear crisper or less sharp than it
    ///normally would. For more information about level-of-detail bias in mipmaps, see D3DSAMP_MIPMAPLODBIAS. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_MULTISAMPLE_TOGGLE"></a><a
    ///id="d3dprastercaps_multisample_toggle"></a><dl> <dt><b>D3DPRASTERCAPS_MULTISAMPLE_TOGGLE</b></dt> </dl> </td> <td
    ///width="60%"> Device supports toggling multisampling on and off between IDirect3DDevice9::BeginScene and
    ///IDirect3DDevice9::EndScene (using D3DRS_MULTISAMPLEANTIALIAS). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_SCISSORTEST"></a><a id="d3dprastercaps_scissortest"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_SCISSORTEST</b></dt> </dl> </td> <td width="60%"> Device supports scissor test. See Scissor
    ///Test (Direct3D 9). </td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS"></a><a
    ///id="d3dprastercaps_slopescaledepthbias"></a><dl> <dt><b>D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS</b></dt> </dl> </td>
    ///<td width="60%"> Device performs true slope-scale based depth bias. This is in contrast to the legacy style depth
    ///bias. </td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_WBUFFER"></a><a id="d3dprastercaps_wbuffer"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_WBUFFER</b></dt> </dl> </td> <td width="60%"> Device supports depth buffering using w.
    ///</td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_WFOG"></a><a id="d3dprastercaps_wfog"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_WFOG</b></dt> </dl> </td> <td width="60%"> Device supports w-based fog. W-based fog is used
    ///when a perspective projection matrix is specified, but affine projections still use z-based fog. The system
    ///considers a projection matrix that contains a nonzero value in the [3][4] element to be a perspective projection
    ///matrix. </td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_ZBUFFERLESSHSR"></a><a
    ///id="d3dprastercaps_zbufferlesshsr"></a><dl> <dt><b>D3DPRASTERCAPS_ZBUFFERLESSHSR</b></dt> </dl> </td> <td
    ///width="60%"> Device can perform hidden-surface removal (HSR) without requiring the application to sort polygons
    ///and without requiring the allocation of a depth-buffer. This leaves more video memory for textures. The method
    ///used to perform HSR is hardware-dependent and is transparent to the application. Z-bufferless HSR is performed if
    ///no depth-buffer surface is associated with the rendering-target surface and the depth-buffer comparison test is
    ///enabled (that is, when the state value associated with the D3DRS_ZENABLE enumeration constant is set to
    ///<b>TRUE</b>). </td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_ZFOG"></a><a
    ///id="d3dprastercaps_zfog"></a><dl> <dt><b>D3DPRASTERCAPS_ZFOG</b></dt> </dl> </td> <td width="60%"> Device
    ///supports z-based fog. </td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_ZTEST"></a><a
    ///id="d3dprastercaps_ztest"></a><dl> <dt><b>D3DPRASTERCAPS_ZTEST</b></dt> </dl> </td> <td width="60%"> Device can
    ///perform z-test operations. This effectively renders a primitive and indicates whether any z pixels have been
    ///rendered. </td> </tr> </table>
    uint              RasterCaps;
    ///Type: <b>DWORD</b> Z-buffer comparison capabilities. This member can be one or more of the following flags.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DPCMPCAPS_ALWAYS"></a><a
    ///id="d3dpcmpcaps_always"></a><dl> <dt><b>D3DPCMPCAPS_ALWAYS</b></dt> </dl> </td> <td width="60%"> Always pass the
    ///z-test. </td> </tr> <tr> <td width="40%"><a id="D3DPCMPCAPS_EQUAL"></a><a id="d3dpcmpcaps_equal"></a><dl>
    ///<dt><b>D3DPCMPCAPS_EQUAL</b></dt> </dl> </td> <td width="60%"> Pass the z-test if the new z equals the current z.
    ///</td> </tr> <tr> <td width="40%"><a id="D3DPCMPCAPS_GREATER"></a><a id="d3dpcmpcaps_greater"></a><dl>
    ///<dt><b>D3DPCMPCAPS_GREATER</b></dt> </dl> </td> <td width="60%"> Pass the z-test if the new z is greater than the
    ///current z. </td> </tr> <tr> <td width="40%"><a id="D3DPCMPCAPS_GREATEREQUAL"></a><a
    ///id="d3dpcmpcaps_greaterequal"></a><dl> <dt><b>D3DPCMPCAPS_GREATEREQUAL</b></dt> </dl> </td> <td width="60%"> Pass
    ///the z-test if the new z is greater than or equal to the current z. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPCMPCAPS_LESS"></a><a id="d3dpcmpcaps_less"></a><dl> <dt><b>D3DPCMPCAPS_LESS</b></dt> </dl> </td> <td
    ///width="60%"> Pass the z-test if the new z is less than the current z. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPCMPCAPS_LESSEQUAL"></a><a id="d3dpcmpcaps_lessequal"></a><dl> <dt><b>D3DPCMPCAPS_LESSEQUAL</b></dt> </dl>
    ///</td> <td width="60%"> Pass the z-test if the new z is less than or equal to the current z. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPCMPCAPS_NEVER"></a><a id="d3dpcmpcaps_never"></a><dl> <dt><b>D3DPCMPCAPS_NEVER</b></dt>
    ///</dl> </td> <td width="60%"> Always fail the z-test. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPCMPCAPS_NOTEQUAL"></a><a id="d3dpcmpcaps_notequal"></a><dl> <dt><b>D3DPCMPCAPS_NOTEQUAL</b></dt> </dl>
    ///</td> <td width="60%"> Pass the z-test if the new z does not equal the current z. </td> </tr> </table>
    uint              ZCmpCaps;
    ///Type: <b>DWORD</b> Source-blending capabilities. This member can be one or more of the following flags. (The RGBA
    ///values of the source and destination are indicated by the subscripts s and d.) <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_BLENDFACTOR"></a><a
    ///id="d3dpblendcaps_blendfactor"></a><dl> <dt><b>D3DPBLENDCAPS_BLENDFACTOR</b></dt> </dl> </td> <td width="60%">
    ///The driver supports both D3DBLEND_BLENDFACTOR and D3DBLEND_INVBLENDFACTOR. See D3DBLEND. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPBLENDCAPS_BOTHINVSRCALPHA"></a><a id="d3dpblendcaps_bothinvsrcalpha"></a><dl>
    ///<dt><b>D3DPBLENDCAPS_BOTHINVSRCALPHA</b></dt> </dl> </td> <td width="60%"> Source blend factor is (1 - Aₛ, 1 -
    ///Aₛ, 1 - Aₛ, 1 - Aₛ) and destination blend factor is (Aₛ, Aₛ, Aₛ, Aₛ); the destination blend
    ///selection is overridden. </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_BOTHSRCALPHA"></a><a
    ///id="d3dpblendcaps_bothsrcalpha"></a><dl> <dt><b>D3DPBLENDCAPS_BOTHSRCALPHA</b></dt> </dl> </td> <td width="60%">
    ///The driver supports the D3DBLEND_BOTHSRCALPHA blend mode. (This blend mode is obsolete. For more information, see
    ///D3DBLEND.) </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_DESTALPHA"></a><a
    ///id="d3dpblendcaps_destalpha"></a><dl> <dt><b>D3DPBLENDCAPS_DESTALPHA</b></dt> </dl> </td> <td width="60%"> Blend
    ///factor is (A<sub>d</sub>, A<sub>d</sub>, A<sub>d</sub>, A<sub>d</sub>). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_DESTCOLOR"></a><a id="d3dpblendcaps_destcolor"></a><dl> <dt><b>D3DPBLENDCAPS_DESTCOLOR</b></dt>
    ///</dl> </td> <td width="60%"> Blend factor is (R<sub>d</sub>, G<sub>d</sub>, B<sub>d</sub>, A<sub>d</sub>). </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_INVDESTALPHA"></a><a id="d3dpblendcaps_invdestalpha"></a><dl>
    ///<dt><b>D3DPBLENDCAPS_INVDESTALPHA</b></dt> </dl> </td> <td width="60%"> Blend factor is (1 - A<sub>d</sub>, 1 -
    ///A<sub>d</sub>, 1 - A<sub>d</sub>, 1 - A<sub>d</sub>). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_INVDESTCOLOR"></a><a id="d3dpblendcaps_invdestcolor"></a><dl>
    ///<dt><b>D3DPBLENDCAPS_INVDESTCOLOR</b></dt> </dl> </td> <td width="60%"> Blend factor is (1 - R<sub>d</sub>, 1 -
    ///G<sub>d</sub>, 1 - B<sub>d</sub>, 1 - A<sub>d</sub>). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_INVSRCALPHA"></a><a id="d3dpblendcaps_invsrcalpha"></a><dl>
    ///<dt><b>D3DPBLENDCAPS_INVSRCALPHA</b></dt> </dl> </td> <td width="60%"> Blend factor is (1 - Aₛ, 1 - Aₛ, 1 -
    ///Aₛ, 1 - Aₛ). </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_INVSRCCOLOR"></a><a
    ///id="d3dpblendcaps_invsrccolor"></a><dl> <dt><b>D3DPBLENDCAPS_INVSRCCOLOR</b></dt> </dl> </td> <td width="60%">
    ///Blend factor is (1 - Rₛ, 1 - Gₛ, 1 - Bₛ, 1 - Aₛ). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_INVSRCCOLOR2"></a><a id="d3dpblendcaps_invsrccolor2"></a><dl>
    ///<dt><b>D3DPBLENDCAPS_INVSRCCOLOR2</b></dt> </dl> </td> <td width="60%"> Blend factor is (1 -
    ///PSOutColor[1]<sub>r</sub>, 1 - PSOutColor[1]<sub>g</sub>, 1 - PSOutColor[1]<sub>b</sub>, not used)). See Render
    ///Target Blending. <table> <tr> <td> Differences between Direct3D 9 and Direct3D 9Ex: This flag is available in
    ///Direct3D 9Ex only. </td> </tr> </table> </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_ONE"></a><a
    ///id="d3dpblendcaps_one"></a><dl> <dt><b>D3DPBLENDCAPS_ONE</b></dt> </dl> </td> <td width="60%"> Blend factor is
    ///(1, 1, 1, 1). </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_SRCALPHA"></a><a
    ///id="d3dpblendcaps_srcalpha"></a><dl> <dt><b>D3DPBLENDCAPS_SRCALPHA</b></dt> </dl> </td> <td width="60%"> Blend
    ///factor is (Aₛ, Aₛ, Aₛ, Aₛ). </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_SRCALPHASAT"></a><a
    ///id="d3dpblendcaps_srcalphasat"></a><dl> <dt><b>D3DPBLENDCAPS_SRCALPHASAT</b></dt> </dl> </td> <td width="60%">
    ///Blend factor is (f, f, f, 1); f = min(Aₛ, 1 - A<sub>d</sub>). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_SRCCOLOR"></a><a id="d3dpblendcaps_srccolor"></a><dl> <dt><b>D3DPBLENDCAPS_SRCCOLOR</b></dt>
    ///</dl> </td> <td width="60%"> Blend factor is (Rₛ, Gₛ, Bₛ, Aₛ). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_SRCCOLOR2"></a><a id="d3dpblendcaps_srccolor2"></a><dl> <dt><b>D3DPBLENDCAPS_SRCCOLOR2</b></dt>
    ///</dl> </td> <td width="60%"> Blend factor is (PSOutColor[1]<sub>r</sub>, PSOutColor[1]<sub>g</sub>,
    ///PSOutColor[1]<sub>b</sub>, not used). See Render Target Blending. <table> <tr> <td> Differences between Direct3D
    ///9 and Direct3D 9Ex: This flag is available in Direct3D 9Ex only. </td> </tr> </table> </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPBLENDCAPS_ZERO"></a><a id="d3dpblendcaps_zero"></a><dl> <dt><b>D3DPBLENDCAPS_ZERO</b></dt>
    ///</dl> </td> <td width="60%"> Blend factor is (0, 0, 0, 0). </td> </tr> </table>
    uint              SrcBlendCaps;
    ///Type: <b>DWORD</b> Destination-blending capabilities. This member can be the same capabilities that are defined
    ///for the SrcBlendCaps member.
    uint              DestBlendCaps;
    ///Type: <b>DWORD</b> Alpha-test comparison capabilities. This member can include the same capability flags defined
    ///for the ZCmpCaps member. If this member contains only the D3DPCMPCAPS_ALWAYS capability or only the
    ///D3DPCMPCAPS_NEVER capability, the driver does not support alpha tests. Otherwise, the flags identify the
    ///individual comparisons that are supported for alpha testing.
    uint              AlphaCmpCaps;
    ///Type: <b>DWORD</b> Shading operations capabilities. It is assumed, in general, that if a device supports a given
    ///command at all, it supports the D3DSHADE_FLAT mode (as specified in the D3DSHADEMODE enumerated type). This flag
    ///specifies whether the driver can also support Gouraud shading and whether alpha color components are supported.
    ///When alpha components are not supported, the alpha value of colors generated is implicitly 255. This is the
    ///maximum possible alpha (that is, the alpha component is at full intensity). The color, specular highlights, fog,
    ///and alpha interpolants of a triangle each have capability flags that an application can use to find out how they
    ///are implemented by the device driver. This member can be one or more of the following flags. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DPSHADECAPS_ALPHAGOURAUDBLEND"></a><a
    ///id="d3dpshadecaps_alphagouraudblend"></a><dl> <dt><b>D3DPSHADECAPS_ALPHAGOURAUDBLEND</b></dt> </dl> </td> <td
    ///width="60%"> Device can support an alpha component for Gouraud-blended transparency (the D3DSHADE_GOURAUD state
    ///for the D3DSHADEMODE enumerated type). In this mode, the alpha color component of a primitive is provided at
    ///vertices and interpolated across a face along with the other color components. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPSHADECAPS_COLORGOURAUDRGB"></a><a id="d3dpshadecaps_colorgouraudrgb"></a><dl>
    ///<dt><b>D3DPSHADECAPS_COLORGOURAUDRGB</b></dt> </dl> </td> <td width="60%"> Device can support colored Gouraud
    ///shading. In this mode, the per-vertex color components (red, green, and blue) are interpolated across a triangle
    ///face. </td> </tr> <tr> <td width="40%"><a id="D3DPSHADECAPS_FOGGOURAUD"></a><a
    ///id="d3dpshadecaps_foggouraud"></a><dl> <dt><b>D3DPSHADECAPS_FOGGOURAUD</b></dt> </dl> </td> <td width="60%">
    ///Device can support fog in the Gouraud shading mode. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPSHADECAPS_SPECULARGOURAUDRGB"></a><a id="d3dpshadecaps_speculargouraudrgb"></a><dl>
    ///<dt><b>D3DPSHADECAPS_SPECULARGOURAUDRGB</b></dt> </dl> </td> <td width="60%"> Device supports Gouraud shading of
    ///specular highlights. </td> </tr> </table>
    uint              ShadeCaps;
    ///Type: <b>DWORD</b> Miscellaneous texture-mapping capabilities. This member can be one or more of the following
    ///flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="D3DPTEXTURECAPS_ALPHA"></a><a id="d3dptexturecaps_alpha"></a><dl> <dt><b>D3DPTEXTURECAPS_ALPHA</b></dt> </dl>
    ///</td> <td width="60%"> Alpha in texture pixels is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTEXTURECAPS_ALPHAPALETTE"></a><a id="d3dptexturecaps_alphapalette"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_ALPHAPALETTE</b></dt> </dl> </td> <td width="60%"> Device can draw alpha from texture
    ///palettes. </td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_CUBEMAP"></a><a
    ///id="d3dptexturecaps_cubemap"></a><dl> <dt><b>D3DPTEXTURECAPS_CUBEMAP</b></dt> </dl> </td> <td width="60%">
    ///Supports cube textures. </td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_CUBEMAP_POW2"></a><a
    ///id="d3dptexturecaps_cubemap_pow2"></a><dl> <dt><b>D3DPTEXTURECAPS_CUBEMAP_POW2</b></dt> </dl> </td> <td
    ///width="60%"> Device requires that cube texture maps have dimensions specified as powers of two. </td> </tr> <tr>
    ///<td width="40%"><a id="D3DPTEXTURECAPS_MIPCUBEMAP"></a><a id="d3dptexturecaps_mipcubemap"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_MIPCUBEMAP</b></dt> </dl> </td> <td width="60%"> Device supports mipmapped cube textures.
    ///</td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_MIPMAP"></a><a id="d3dptexturecaps_mipmap"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_MIPMAP</b></dt> </dl> </td> <td width="60%"> Device supports mipmapped textures. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_MIPVOLUMEMAP"></a><a id="d3dptexturecaps_mipvolumemap"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_MIPVOLUMEMAP</b></dt> </dl> </td> <td width="60%"> Device supports mipmapped volume
    ///textures. </td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_NONPOW2CONDITIONAL"></a><a
    ///id="d3dptexturecaps_nonpow2conditional"></a><dl> <dt><b>D3DPTEXTURECAPS_NONPOW2CONDITIONAL</b></dt> </dl> </td>
    ///<td width="60%"> D3DPTEXTURECAPS_POW2 is also set, conditionally supports the use of 2D textures with dimensions
    ///that are not powers of two. A device that exposes this capability can use such a texture if all of the following
    ///requirements are met. <ul> <li>The texture addressing mode for the texture stage is set to
    ///D3DTADDRESS_CLAMP.</li> <li>Texture wrapping for the texture stage is disabled (D3DRS_WRAP n set to 0).</li>
    ///<li>Mipmapping is not in use (use magnification filter only).</li> <li>Texture formats must not be D3DFMT_DXT1
    ///through D3DFMT_DXT5.</li> </ul> If this flag is not set, and D3DPTEXTURECAPS_POW2 is also not set, then
    ///unconditional support is provided for 2D textures with dimensions that are not powers of two. A texture that is
    ///not a power of two cannot be set at a stage that will be read based on a shader computation (such as the bem - ps
    ///and texm3x3 - ps instructions in pixel shaders versions 1_0 to 1_3). For example, these textures can be used to
    ///store bumps that will be fed into texture reads, but not the environment maps that are used in texbem - ps,
    ///texbeml - ps, and texm3x3spec - ps. This means that a texture with dimensions that are not powers of two cannot
    ///be addressed or sampled using texture coordinates computed within the shader. This type of operation is known as
    ///a dependent read and cannot be performed on these types of textures. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTEXTURECAPS_NOPROJECTEDBUMPENV"></a><a id="d3dptexturecaps_noprojectedbumpenv"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_NOPROJECTEDBUMPENV</b></dt> </dl> </td> <td width="60%"> Device does not support a
    ///projected bump-environment loopkup operation in programmable and fixed function shaders. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPTEXTURECAPS_PERSPECTIVE"></a><a id="d3dptexturecaps_perspective"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_PERSPECTIVE</b></dt> </dl> </td> <td width="60%"> Perspective correction texturing is
    ///supported. </td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_POW2"></a><a
    ///id="d3dptexturecaps_pow2"></a><dl> <dt><b>D3DPTEXTURECAPS_POW2</b></dt> </dl> </td> <td width="60%"> If
    ///D3DPTEXTURECAPS_NONPOW2CONDITIONAL is not set, all textures must have widths and heights specified as powers of
    ///two. This requirement does not apply to either cube textures or volume textures. If
    ///D3DPTEXTURECAPS_NONPOW2CONDITIONAL is also set, conditionally supports the use of 2D textures with dimensions
    ///that are not powers of two. See D3DPTEXTURECAPS_NONPOW2CONDITIONAL description. If this flag is not set, and
    ///D3DPTEXTURECAPS_NONPOW2CONDITIONAL is also not set, then unconditional support is provided for 2D textures with
    ///dimensions that are not powers of two. </td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_PROJECTED"></a><a
    ///id="d3dptexturecaps_projected"></a><dl> <dt><b>D3DPTEXTURECAPS_PROJECTED</b></dt> </dl> </td> <td width="60%">
    ///Supports the D3DTTFF_PROJECTED texture transformation flag. When applied, the device divides transformed texture
    ///coordinates by the last texture coordinate. If this capability is present, then the projective divide occurs per
    ///pixel. If this capability is not present, but the projective divide needs to occur anyway, then it is performed
    ///on a per-vertex basis by the Direct3D runtime. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTEXTURECAPS_SQUAREONLY"></a><a id="d3dptexturecaps_squareonly"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_SQUAREONLY</b></dt> </dl> </td> <td width="60%"> All textures must be square. </td> </tr>
    ///<tr> <td width="40%"><a id="D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE"></a><a
    ///id="d3dptexturecaps_texrepeatnotscaledbysize"></a><dl> <dt><b>D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE</b></dt>
    ///</dl> </td> <td width="60%"> Texture indices are not scaled by the texture size prior to interpolation. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_VOLUMEMAP"></a><a id="d3dptexturecaps_volumemap"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_VOLUMEMAP</b></dt> </dl> </td> <td width="60%"> Device supports volume textures. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_VOLUMEMAP_POW2"></a><a
    ///id="d3dptexturecaps_volumemap_pow2"></a><dl> <dt><b>D3DPTEXTURECAPS_VOLUMEMAP_POW2</b></dt> </dl> </td> <td
    ///width="60%"> Device requires that volume texture maps have dimensions specified as powers of two. </td> </tr>
    ///</table>
    uint              TextureCaps;
    ///Type: <b>DWORD</b> Texture-filtering capabilities for a texture. Per-stage filtering capabilities reflect which
    ///filtering modes are supported for texture stages when performing multiple-texture blending. This member can be
    ///any combination of the per-stage texture-filtering flags defined in D3DPTFILTERCAPS.
    uint              TextureFilterCaps;
    ///Type: <b>DWORD</b> Texture-filtering capabilities for a cube texture. Per-stage filtering capabilities reflect
    ///which filtering modes are supported for texture stages when performing multiple-texture blending. This member can
    ///be any combination of the per-stage texture-filtering flags defined in D3DPTFILTERCAPS.
    uint              CubeTextureFilterCaps;
    ///Type: <b>DWORD</b> Texture-filtering capabilities for a volume texture. Per-stage filtering capabilities reflect
    ///which filtering modes are supported for texture stages when performing multiple-texture blending. This member can
    ///be any combination of the per-stage texture-filtering flags defined in D3DPTFILTERCAPS.
    uint              VolumeTextureFilterCaps;
    ///Type: <b>DWORD</b> Texture-addressing capabilities for texture objects. This member can be one or more of the
    ///following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="D3DPTADDRESSCAPS_BORDER"></a><a id="d3dptaddresscaps_border"></a><dl> <dt><b>D3DPTADDRESSCAPS_BORDER</b></dt>
    ///</dl> </td> <td width="60%"> Device supports setting coordinates outside the range [0.0, 1.0] to the border
    ///color, as specified by the D3DSAMP_BORDERCOLOR texture-stage state. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTADDRESSCAPS_CLAMP"></a><a id="d3dptaddresscaps_clamp"></a><dl> <dt><b>D3DPTADDRESSCAPS_CLAMP</b></dt>
    ///</dl> </td> <td width="60%"> Device can clamp textures to addresses. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTADDRESSCAPS_INDEPENDENTUV"></a><a id="d3dptaddresscaps_independentuv"></a><dl>
    ///<dt><b>D3DPTADDRESSCAPS_INDEPENDENTUV</b></dt> </dl> </td> <td width="60%"> Device can separate the
    ///texture-addressing modes of the u and v coordinates of the texture. This ability corresponds to the
    ///D3DSAMP_ADDRESSU and D3DSAMP_ADDRESSV render-state values. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTADDRESSCAPS_MIRROR"></a><a id="d3dptaddresscaps_mirror"></a><dl> <dt><b>D3DPTADDRESSCAPS_MIRROR</b></dt>
    ///</dl> </td> <td width="60%"> Device can mirror textures to addresses. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTADDRESSCAPS_MIRRORONCE"></a><a id="d3dptaddresscaps_mirroronce"></a><dl>
    ///<dt><b>D3DPTADDRESSCAPS_MIRRORONCE</b></dt> </dl> </td> <td width="60%"> Device can take the absolute value of
    ///the texture coordinate (thus, mirroring around 0) and then clamp to the maximum value. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPTADDRESSCAPS_WRAP"></a><a id="d3dptaddresscaps_wrap"></a><dl>
    ///<dt><b>D3DPTADDRESSCAPS_WRAP</b></dt> </dl> </td> <td width="60%"> Device can wrap textures to addresses. </td>
    ///</tr> </table>
    uint              TextureAddressCaps;
    ///Type: <b>DWORD</b> Texture-addressing capabilities for a volume texture. This member can be one or more of the
    ///flags defined for the TextureAddressCaps member.
    uint              VolumeTextureAddressCaps;
    ///Type: <b>DWORD</b> Defines the capabilities for line-drawing primitives. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DLINECAPS_ALPHACMP"></a><a
    ///id="d3dlinecaps_alphacmp"></a><dl> <dt><b>D3DLINECAPS_ALPHACMP</b></dt> </dl> </td> <td width="60%"> Supports
    ///alpha-test comparisons. </td> </tr> <tr> <td width="40%"><a id="D3DLINECAPS_ANTIALIAS"></a><a
    ///id="d3dlinecaps_antialias"></a><dl> <dt><b>D3DLINECAPS_ANTIALIAS</b></dt> </dl> </td> <td width="60%">
    ///Antialiased lines are supported. </td> </tr> <tr> <td width="40%"><a id="D3DLINECAPS_BLEND"></a><a
    ///id="d3dlinecaps_blend"></a><dl> <dt><b>D3DLINECAPS_BLEND</b></dt> </dl> </td> <td width="60%"> Supports
    ///source-blending. </td> </tr> <tr> <td width="40%"><a id="D3DLINECAPS_FOG"></a><a id="d3dlinecaps_fog"></a><dl>
    ///<dt><b>D3DLINECAPS_FOG</b></dt> </dl> </td> <td width="60%"> Supports fog. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DLINECAPS_TEXTURE"></a><a id="d3dlinecaps_texture"></a><dl> <dt><b>D3DLINECAPS_TEXTURE</b></dt> </dl> </td>
    ///<td width="60%"> Supports texture-mapping. </td> </tr> <tr> <td width="40%"><a id="D3DLINECAPS_ZTEST"></a><a
    ///id="d3dlinecaps_ztest"></a><dl> <dt><b>D3DLINECAPS_ZTEST</b></dt> </dl> </td> <td width="60%"> Supports z-buffer
    ///comparisons. </td> </tr> </table>
    uint              LineCaps;
    ///Type: <b>DWORD</b> Maximum texture width for this device.
    uint              MaxTextureWidth;
    ///Type: <b>DWORD</b> Maximum texture height for this device.
    uint              MaxTextureHeight;
    ///Type: <b>DWORD</b> Maximum value for any of the three dimensions (width, height, and depth) of a volume texture.
    uint              MaxVolumeExtent;
    ///Type: <b>DWORD</b> This number represents the maximum range of the integer bits of the post-normalized texture
    ///coordinates. A texture coordinate is stored as a 32-bit signed integer using 27 bits to store the integer part
    ///and 5 bits for the floating point fraction. The maximum integer index, 2²⁷, is used to determine the maximum
    ///texture coordinate, depending on how the hardware does texture-coordinate scaling. Some hardware reports the cap
    ///D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE. For this case, the device defers scaling texture coordinates by the
    ///texture size until after interpolation and application of the texture address mode, so the number of times a
    ///texture can be wrapped is given by the integer value in MaxTextureRepeat. Less desirably, on some hardware
    ///D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE is not set and the device scales the texture coordinates by the texture
    ///size (using the highest level of detail) prior to interpolation. This limits the number of times a texture can be
    ///wrapped to MaxTextureRepeat / texture size. For example, assume that MaxTextureRepeat is equal to 32k and the
    ///size of the texture is 4k. If the hardware sets D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE, then the number of
    ///times a texture can be wrapped is equal to MaxTextureRepeat, which is 32k in this example. Otherwise, the number
    ///of times a texture can be wrapped is equal to MaxTextureRepeat divided by texture size, which is 32k/4k in this
    ///example.
    uint              MaxTextureRepeat;
    ///Type: <b>DWORD</b> Maximum texture aspect ratio supported by the hardware, typically a power of 2.
    uint              MaxTextureAspectRatio;
    ///Type: <b>DWORD</b> Maximum valid value for the D3DSAMP_MAXANISOTROPY texture-stage state.
    uint              MaxAnisotropy;
    ///Type: <b>float</b> Maximum W-based depth value that the device supports.
    float             MaxVertexW;
    ///Type: <b>float</b> Screen-space coordinate of the guard-band clipping region. Coordinates inside this rectangle
    ///but outside the viewport rectangle are automatically clipped.
    float             GuardBandLeft;
    ///Type: <b>float</b> Screen-space coordinate of the guard-band clipping region. Coordinates inside this rectangle
    ///but outside the viewport rectangle are automatically clipped.
    float             GuardBandTop;
    ///Type: <b>float</b> Screen-space coordinate of the guard-band clipping region. Coordinates inside this rectangle
    ///but outside the viewport rectangle are automatically clipped.
    float             GuardBandRight;
    ///Type: <b>float</b> Screen-space coordinate of the guard-band clipping region. Coordinates inside this rectangle
    ///but outside the viewport rectangle are automatically clipped.
    float             GuardBandBottom;
    ///Type: <b>float</b> Number of pixels to adjust the extents rectangle outward to accommodate antialiasing kernels.
    float             ExtentsAdjust;
    ///Type: <b>DWORD</b> Flags specifying supported stencil-buffer operations. Stencil operations are assumed to be
    ///valid for all three stencil-buffer operation render states (D3DRS_STENCILFAIL, D3DRS_STENCILPASS, and
    ///D3DRS_STENCILZFAIL). For more information, see D3DSTENCILCAPS.
    uint              StencilCaps;
    ///Type: <b>DWORD</b> Flexible vertex format capabilities. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="D3DFVFCAPS_DONOTSTRIPELEMENTS"></a><a id="d3dfvfcaps_donotstripelements"></a><dl>
    ///<dt><b>D3DFVFCAPS_DONOTSTRIPELEMENTS</b></dt> </dl> </td> <td width="60%"> It is preferable that vertex elements
    ///not be stripped. That is, if the vertex format contains elements that are not used with the current render
    ///states, there is no need to regenerate the vertices. If this capability flag is not present, stripping extraneous
    ///elements from the vertex format provides better performance. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DFVFCAPS_PSIZE"></a><a id="d3dfvfcaps_psize"></a><dl> <dt><b>D3DFVFCAPS_PSIZE</b></dt> </dl> </td> <td
    ///width="60%"> Point size is determined by either the render state or the vertex data. If an FVF is used, point
    ///size can come from point size data in the vertex declaration. Otherwise, point size is determined by the render
    ///state D3DRS_POINTSIZE. If the application provides point size in both (the render state and the vertex
    ///declaration), the vertex data overrides the render-state data. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DFVFCAPS_TEXCOORDCOUNTMASK"></a><a id="d3dfvfcaps_texcoordcountmask"></a><dl>
    ///<dt><b>D3DFVFCAPS_TEXCOORDCOUNTMASK</b></dt> </dl> </td> <td width="60%"> Masks the low WORD of FVFCaps. These
    ///bits, cast to the WORD data type, describe the total number of texture coordinate sets that the device can
    ///simultaneously use for multiple texture blending. (You can use up to eight texture coordinate sets for any
    ///vertex, but the device can blend using only the specified number of texture coordinate sets.) </td> </tr>
    ///</table>
    uint              FVFCaps;
    ///Type: <b>DWORD</b> Combination of flags describing the texture operations supported by this device. The following
    ///flags are defined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_ADD"></a><a id="d3dtexopcaps_add"></a><dl> <dt><b>D3DTEXOPCAPS_ADD</b></dt> </dl> </td> <td
    ///width="60%"> The D3DTOP_ADD texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_ADDSIGNED"></a><a id="d3dtexopcaps_addsigned"></a><dl> <dt><b>D3DTEXOPCAPS_ADDSIGNED</b></dt>
    ///</dl> </td> <td width="60%"> The D3DTOP_ADDSIGNED texture-blending operation is supported. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DTEXOPCAPS_ADDSIGNED2X"></a><a id="d3dtexopcaps_addsigned2x"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_ADDSIGNED2X</b></dt> </dl> </td> <td width="60%"> The D3DTOP_ADDSIGNED2X texture-blending
    ///operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_ADDSMOOTH"></a><a
    ///id="d3dtexopcaps_addsmooth"></a><dl> <dt><b>D3DTEXOPCAPS_ADDSMOOTH</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_ADDSMOOTH texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BLENDCURRENTALPHA"></a><a id="d3dtexopcaps_blendcurrentalpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BLENDCURRENTALPHA</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BLENDCURRENTALPHA
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BLENDDIFFUSEALPHA"></a><a id="d3dtexopcaps_blenddiffusealpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BLENDDIFFUSEALPHA</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BLENDDIFFUSEALPHA
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BLENDFACTORALPHA"></a><a id="d3dtexopcaps_blendfactoralpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BLENDFACTORALPHA</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BLENDFACTORALPHA
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BLENDTEXTUREALPHA"></a><a id="d3dtexopcaps_blendtexturealpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BLENDTEXTUREALPHA</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BLENDTEXTUREALPHA
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BLENDTEXTUREALPHAPM"></a><a id="d3dtexopcaps_blendtexturealphapm"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BLENDTEXTUREALPHAPM</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BLENDTEXTUREALPHAPM
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_BUMPENVMAP"></a><a
    ///id="d3dtexopcaps_bumpenvmap"></a><dl> <dt><b>D3DTEXOPCAPS_BUMPENVMAP</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_BUMPENVMAP texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BUMPENVMAPLUMINANCE"></a><a id="d3dtexopcaps_bumpenvmapluminance"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BUMPENVMAPLUMINANCE</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BUMPENVMAPLUMINANCE
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_DISABLE"></a><a
    ///id="d3dtexopcaps_disable"></a><dl> <dt><b>D3DTEXOPCAPS_DISABLE</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_DISABLE texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_DOTPRODUCT3"></a><a id="d3dtexopcaps_dotproduct3"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_DOTPRODUCT3</b></dt> </dl> </td> <td width="60%"> The D3DTOP_DOTPRODUCT3 texture-blending
    ///operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_LERP"></a><a
    ///id="d3dtexopcaps_lerp"></a><dl> <dt><b>D3DTEXOPCAPS_LERP</b></dt> </dl> </td> <td width="60%"> The D3DTOP_LERP
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_MODULATE"></a><a
    ///id="d3dtexopcaps_modulate"></a><dl> <dt><b>D3DTEXOPCAPS_MODULATE</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_MODULATE texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_MODULATE2X"></a><a id="d3dtexopcaps_modulate2x"></a><dl> <dt><b>D3DTEXOPCAPS_MODULATE2X</b></dt>
    ///</dl> </td> <td width="60%"> The D3DTOP_MODULATE2X texture-blending operation is supported. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DTEXOPCAPS_MODULATE4X"></a><a id="d3dtexopcaps_modulate4x"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_MODULATE4X</b></dt> </dl> </td> <td width="60%"> The D3DTOP_MODULATE4X texture-blending
    ///operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR"></a><a
    ///id="d3dtexopcaps_modulatealpha_addcolor"></a><dl> <dt><b>D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR</b></dt> </dl> </td>
    ///<td width="60%"> The D3DTOP_MODULATEALPHA_ADDCOLOR texture-blending operation is supported. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA"></a><a id="d3dtexopcaps_modulatecolor_addalpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_MODULATECOLOR_ADDALPHA texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR"></a><a id="d3dtexopcaps_modulateinvalpha_addcolor"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_MODULATEINVALPHA_ADDCOLOR texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA"></a><a id="d3dtexopcaps_modulateinvcolor_addalpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_MODULATEINVCOLOR_ADDALPHA texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_MULTIPLYADD"></a><a id="d3dtexopcaps_multiplyadd"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_MULTIPLYADD</b></dt> </dl> </td> <td width="60%"> The D3DTOP_MULTIPLYADD texture-blending
    ///operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_PREMODULATE"></a><a
    ///id="d3dtexopcaps_premodulate"></a><dl> <dt><b>D3DTEXOPCAPS_PREMODULATE</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_PREMODULATE texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_SELECTARG1"></a><a id="d3dtexopcaps_selectarg1"></a><dl> <dt><b>D3DTEXOPCAPS_SELECTARG1</b></dt>
    ///</dl> </td> <td width="60%"> The D3DTOP_SELECTARG1 texture-blending operation is supported. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DTEXOPCAPS_SELECTARG2"></a><a id="d3dtexopcaps_selectarg2"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_SELECTARG2</b></dt> </dl> </td> <td width="60%"> The D3DTOP_SELECTARG2 texture-blending
    ///operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_SUBTRACT"></a><a
    ///id="d3dtexopcaps_subtract"></a><dl> <dt><b>D3DTEXOPCAPS_SUBTRACT</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_SUBTRACT texture-blending operation is supported. </td> </tr> </table>
    uint              TextureOpCaps;
    ///Type: <b>DWORD</b> Maximum number of texture-blending stages supported in the fixed function pipeline. This value
    ///is the number of blenders available. In the programmable pixel pipeline, this corresponds to the number of unique
    ///texture registers used by pixel shader instructions.
    uint              MaxTextureBlendStages;
    ///Type: <b>DWORD</b> Maximum number of textures that can be simultaneously bound to the fixed-function pipeline
    ///sampler stages. If the same texture is bound to two sampler stages, it counts as two textures. This value has no
    ///meaning in the programmable pipeline where the number of sampler stages is determined by each pixel shader
    ///version. Each pixel shader version also determines the number of texture declaration instructions. See Pixel
    ///Shaders.
    uint              MaxSimultaneousTextures;
    ///Type: <b>DWORD</b> Vertex processing capabilities. For a given physical device, this capability might vary across
    ///Direct3D devices depending on the parameters supplied to CreateDevice. See D3DVTXPCAPS.
    uint              VertexProcessingCaps;
    ///Type: <b>DWORD</b> Maximum number of lights that can be active simultaneously. For a given physical device, this
    ///capability might vary across Direct3D devices depending on the parameters supplied to CreateDevice.
    uint              MaxActiveLights;
    ///Type: <b>DWORD</b> Maximum number of user-defined clipping planes supported. This member can be 0. For a given
    ///physical device, this capability may vary across Direct3D devices depending on the parameters supplied to
    ///CreateDevice.
    uint              MaxUserClipPlanes;
    ///Type: <b>DWORD</b> Maximum number of matrices that this device can apply when performing multimatrix vertex
    ///blending. For a given physical device, this capability may vary across Direct3D devices depending on the
    ///parameters supplied to CreateDevice.
    uint              MaxVertexBlendMatrices;
    ///Type: <b>DWORD</b> DWORD value that specifies the maximum matrix index that can be indexed into using the
    ///per-vertex indices. The number of matrices is MaxVertexBlendMatrixIndex + 1, which is the size of the matrix
    ///palette. If normals are present in the vertex data that needs to be blended for lighting, then the number of
    ///matrices is half the number specified by this capability flag. If MaxVertexBlendMatrixIndex is set to zero, the
    ///driver does not support indexed vertex blending. If this value is not zero then the valid range of indices is
    ///zero through MaxVertexBlendMatrixIndex. A zero value for MaxVertexBlendMatrixIndex indicates that the driver does
    ///not support indexed matrices. When software vertex processing is used, 256 matrices could be used for indexed
    ///vertex blending, with or without normal blending. For a given physical device, this capability may vary across
    ///Direct3D devices depending on the parameters supplied to CreateDevice.
    uint              MaxVertexBlendMatrixIndex;
    ///Type: <b>float</b> Maximum size of a point primitive. If set to 1.0f then device does not support point size
    ///control. The range is greater than or equal to 1.0f.
    float             MaxPointSize;
    ///Type: <b>DWORD</b> Maximum number of primitives for each DrawPrimitive call. There are two cases: <ul> <li>If
    ///MaxPrimitiveCount is not equal to 0xffff, you can draw at most MaxPrimitiveCount primitives with each draw
    ///call.</li> <li>However, if MaxPrimitiveCount equals 0xffff, you can still draw at most MaxPrimitiveCount
    ///primitive, but you may also use no more than MaxPrimitiveCount unique vertices (since each primitive can
    ///potentially use three different vertices).</li> </ul>
    uint              MaxPrimitiveCount;
    ///Type: <b>DWORD</b> Maximum size of indices supported for hardware vertex processing. It is possible to create
    ///32-bit index buffers; however, you will not be able to render with the index buffer unless this value is greater
    ///than 0x0000FFFF.
    uint              MaxVertexIndex;
    ///Type: <b>DWORD</b> Maximum number of concurrent data streams for SetStreamSource. The valid range is 1 to 16.
    ///Note that if this value is 0, then the driver is not a Direct3D 9 driver.
    uint              MaxStreams;
    ///Type: <b>DWORD</b> Maximum stride for SetStreamSource.
    uint              MaxStreamStride;
    ///Type: <b>DWORD</b> Two numbers that represent the vertex shader main and sub versions. For more information about
    ///the instructions supported for each vertex shader version, see Version 1_x, Version 2_0, Version 2_0 Extended, or
    ///Version 3_0.
    uint              VertexShaderVersion;
    ///Type: <b>DWORD</b> The number of vertex shader Vertex Shader Registers that are reserved for constants.
    uint              MaxVertexShaderConst;
    ///Type: <b>DWORD</b> Two numbers that represent the pixel shader main and sub versions. For more information about
    ///the instructions supported for each pixel shader version, see Version 1_x, Version 2_0, Version 2_0 Extended, or
    ///Version 3_0.
    uint              PixelShaderVersion;
    ///Type: <b>float</b> Maximum value of pixel shader arithmetic component. This value indicates the internal range of
    ///values supported for pixel color blending operations. Within the range that they report to, implementations must
    ///allow data to pass through pixel processing unmodified (unclamped). Normally, the value of this member is an
    ///absolute value. For example, a 1.0 indicates that the range is -1.0 to 1, and an 8.0 indicates that the range is
    ///-8.0 to 8.0. The value must be &gt;= 1.0 for any hardware that supports pixel shaders.
    float             PixelShader1xMaxValue;
    ///Type: <b>DWORD</b> Device driver capabilities for adaptive tessellation. For more information, see D3DDEVCAPS2
    uint              DevCaps2;
    ///TBD
    float             MaxNpatchTessellationLevel;
    ///TBD
    uint              Reserved5;
    ///Type: <b>UINT</b> This number indicates which device is the master for this subordinate. This number is taken
    ///from the same space as the adapter values. For multihead support, one head will be denoted the master head, and
    ///all other heads on the same card will be denoted subordinate heads. If more than one multihead adapter is present
    ///in a system, the master and its subordinates from one multihead adapter are called a group.
    uint              MasterAdapterOrdinal;
    ///Type: <b>UINT</b> This number indicates the order in which heads are referenced by the API. The value for the
    ///master adapter is always 0. These values do not correspond to the adapter ordinals. They apply only to heads
    ///within a group.
    uint              AdapterOrdinalInGroup;
    ///Type: <b>UINT</b> Number of adapters in this adapter group (only if master). This will be 1 for conventional
    ///adapters. The value will be greater than 1 for the master adapter of a multihead card. The value will be 0 for a
    ///subordinate adapter of a multihead card. Each card can have at most one master, but may have many subordinates.
    uint              NumberOfAdaptersInGroup;
    ///Type: <b>DWORD</b> A combination of one or more data types contained in a vertex declaration. See D3DDTCAPS.
    uint              DeclTypes;
    ///Type: <b>DWORD</b> Number of simultaneous render targets. This number must be at least one.
    uint              NumSimultaneousRTs;
    ///Type: <b>DWORD</b> Combination of constants that describe the operations supported by StretchRect. The flags that
    ///may be set in this field are: <table> <tr> <th>Constant</th> <th>Description</th> </tr> <tr>
    ///<td>D3DPTFILTERCAPS_MINFPOINT</td> <td>Device supports point-sample filtering for minifying rectangles. This
    ///filter type is requested by calling StretchRect using D3DTEXF_POINT.</td> </tr> <tr>
    ///<td>D3DPTFILTERCAPS_MAGFPOINT</td> <td>Device supports point-sample filtering for magnifying rectangles. This
    ///filter type is requested by calling StretchRect using D3DTEXF_POINT.</td> </tr> <tr>
    ///<td>D3DPTFILTERCAPS_MINFLINEAR</td> <td>Device supports bilinear interpolation filtering for minifying
    ///rectangles. This filter type is requested by calling StretchRect using D3DTEXF_LINEAR.</td> </tr> <tr>
    ///<td>D3DPTFILTERCAPS_MAGFLINEAR</td> <td>Device supports bilinear interpolation filtering for magnifying
    ///rectangles. This filter type is requested by calling StretchRect using D3DTEXF_LINEAR.</td> </tr> </table> For
    ///more information, see D3DTEXTUREFILTERTYPE and <b>D3DTEXTUREFILTERTYPE</b>.
    uint              StretchRectFilterCaps;
    ///Type: <b>D3DVSHADERCAPS2_0</b> Device supports vertex shader version 2_0 extended capability. See
    ///D3DVSHADERCAPS2_0.
    D3DVSHADERCAPS2_0 VS20Caps;
    ///Type: <b>D3DPSHADERCAPS2_0</b> Device supports pixel shader version 2_0 extended capability. See
    ///D3DPSHADERCAPS2_0.
    D3DPSHADERCAPS2_0 PS20Caps;
    ///Type: <b>DWORD</b> Device supports vertex shader texture filter capability. See D3DPTFILTERCAPS.
    uint              VertexTextureFilterCaps;
    ///Type: <b>DWORD</b> Maximum number of vertex shader instructions that can be run when using flow control. The
    ///maximum number of instructions that can be programmed is MaxVertexShader30InstructionSlots.
    uint              MaxVShaderInstructionsExecuted;
    ///Type: <b>DWORD</b> Maximum number of pixel shader instructions that can be run when using flow control. The
    ///maximum number of instructions that can be programmed is MaxPixelShader30InstructionSlots.
    uint              MaxPShaderInstructionsExecuted;
    ///Type: <b>DWORD</b> Maximum number of vertex shader instruction slots supported. The maximum value that can be set
    ///on this cap is 32768. Devices that support vs_3_0 are required to support at least 512 instruction slots.
    uint              MaxVertexShader30InstructionSlots;
    ///Type: <b>DWORD</b> Maximum number of pixel shader instruction slots supported. The maximum value that can be set
    ///on this cap is 32768. Devices that support ps_3_0 are required to support at least 512 instruction slots.
    uint              MaxPixelShader30InstructionSlots;
}

// Functions

///Create an IDirect3D9 object and return an interface to it.
///Params:
///    SDKVersion = Type: <b>UINT</b> The value of this parameter should be D3D_SDK_VERSION. See Remarks.
///Returns:
///    Type: <b>IDirect3D9*</b> If successful, this function returns a pointer to an IDirect3D9 interface; otherwise, a
///    <b>NULL</b> pointer is returned.
///    
@DllImport("d3d9")
IDirect3D9 Direct3DCreate9(uint SDKVersion);

@DllImport("d3d9")
int D3DPERF_BeginEvent(uint col, const(PWSTR) wszName);

@DllImport("d3d9")
int D3DPERF_EndEvent();

@DllImport("d3d9")
void D3DPERF_SetMarker(uint col, const(PWSTR) wszName);

@DllImport("d3d9")
void D3DPERF_SetRegion(uint col, const(PWSTR) wszName);

@DllImport("d3d9")
BOOL D3DPERF_QueryRepeatFrame();

@DllImport("d3d9")
void D3DPERF_SetOptions(uint dwOptions);

@DllImport("d3d9")
uint D3DPERF_GetStatus();

///Creates an IDirect3D9Ex object and returns an interface to it.
///Params:
///    SDKVersion = Type: <b>UINT</b> The value of this parameter should be <b>D3D_SDK_VERSION</b>. See Remarks.
///    arg2 = Type: <b>IDirect3D9Ex**</b> Address of a pointer to an IDirect3D9Ex interface, representing the created
///           <b>IDirect3D9Ex</b> object. If the function fails, <b>NULL</b> is inserted here.
///Returns:
///    Type: <b>HRESULT</b> <ul> <li><b>D3DERR_NOTAVAILABLE</b> if Direct3DEx features are not supported (no WDDM driver
///    is installed) or if the <b>SDKVersion</b> does not match the version of the DLL.</li>
///    <li><b>D3DERR_OUTOFMEMORY</b> if out-of-memory conditions are detected when creating the enumerator object.</li>
///    <li><b>S_OK</b> if the creation of the enumerator object is successful.</li> </ul>
///    
@DllImport("d3d9")
HRESULT Direct3DCreate9Ex(uint SDKVersion, IDirect3D9Ex* param1);


// Interfaces

///Applications use the methods of the IDirect3D9 interface to create Microsoft Direct3D objects and set up the
///environment. This interface includes methods for enumerating and retrieving capabilities of the device.
@GUID("81BDCBCA-64D4-426D-AE8D-AD0147F4275C")
interface IDirect3D9 : IUnknown
{
    ///Registers a pluggable software device. Software devices provide software rasterization enabling applications to
    ///access a variety of software rasterizers.
    ///Params:
    ///    pInitializeFunction = Type: <b>void*</b> Pointer to the initialization function for the software device to be registered.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL. The method call is invalid. For example, a method's
    ///    parameter may have an invalid value: D3DERR_OUTOFVIDEOMEMORY.
    ///    
    HRESULT  RegisterSoftwareDevice(void* pInitializeFunction);
    ///Returns the number of adapters on the system.
    ///Returns:
    ///    Type: <b>UINT</b> A UINT value that denotes the number of adapters on the system at the time this IDirect3D9
    ///    interface was instantiated.
    ///    
    uint     GetAdapterCount();
    ///Describes the physical display adapters present in the system when the IDirect3D9 interface was instantiated.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter. The minimum value for this parameter is 0, and the maximum value for this parameter is one
    ///              less than the value returned by GetAdapterCount.
    ///    Flags = Type: <b>DWORD</b> Flags sets the <b>WHQLLevel</b> member of D3DADAPTER_IDENTIFIER9. Flags can be set to
    ///            either 0 or D3DENUM_WHQL_LEVEL. If D3DENUM_WHQL_LEVEL is specified, this call can connect to the Internet to
    ///            download new Microsoft Windows Hardware Quality Labs (WHQL) certificates. Differences between Direct3D 9 and
    ///            Direct3D 9Ex: D3DENUM_WHQL_LEVEL is deprecated for Direct3D9Ex running on Windows Vista, Windows Server 2008,
    ///            Windows 7, and Windows Server 2008 R2 (or more current operating system). Any of these operating systems
    ///            return 1 in the <b>WHQLLevel</b> member of D3DADAPTER_IDENTIFIER9 without checking the status of the driver.
    ///    pIdentifier = Type: <b>D3DADAPTER_IDENTIFIER9*</b> Pointer to a D3DADAPTER_IDENTIFIER9 structure to be filled with
    ///                  information describing this adapter. If <i>Adapter</i> is greater than or equal to the number of adapters in
    ///                  the system, this structure will be zeroed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    Adapter is out of range, if Flags contains unrecognized parameters, or if pIdentifier is <b>NULL</b> or
    ///    points to unwriteable memory.
    ///    
    HRESULT  GetAdapterIdentifier(uint Adapter, uint Flags, D3DADAPTER_IDENTIFIER9* pIdentifier);
    ///Returns the number of display modes available on this adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter.
    ///    Format = Type: <b>D3DFORMAT</b> Identifies the format of the surface type using D3DFORMAT. Use EnumAdapterModes to see
    ///             the valid formats.
    ///Returns:
    ///    Type: <b>UINT</b> This method returns the number of display modes on this adapter or zero if Adapter is
    ///    greater than or equal to the number of adapters on the system.
    ///    
    uint     GetAdapterModeCount(uint Adapter, D3DFORMAT Format);
    ///Queries the device to determine whether the specified adapter supports the requested format and display mode.
    ///This method could be used in a loop to enumerate all the available adapter modes.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to enumerate. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter. This method returns D3DERR_INVALIDCALL when this value equals or exceeds the number
    ///              of display adapters in the system.
    ///    Format = Type: <b>D3DFORMAT</b> Allowable pixel formats. See Remarks.
    ///    Mode = Type: <b>UINT</b> Represents the display-mode index which is an unsigned integer between zero and the value
    ///           returned by GetAdapterModeCount minus one.
    ///    pMode = Type: <b>D3DDISPLAYMODE*</b> A pointer to the available display mode of type D3DDISPLAYMODE. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> <ul> <li>If the device can be used on this adapter, D3D_OK is returned.</li> <li>If the
    ///    Adapter equals or exceeds the number of display adapters in the system, D3DERR_INVALIDCALL is returned.</li>
    ///    <li>If either surface format is not supported or if hardware acceleration is not available for the specified
    ///    formats, D3DERR_NOTAVAILABLE is returned.</li> </ul>
    ///    
    HRESULT  EnumAdapterModes(uint Adapter, D3DFORMAT Format, uint Mode, D3DDISPLAYMODE* pMode);
    ///Retrieves the current display mode of the adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter to query. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter.
    ///    pMode = Type: <b>D3DDISPLAYMODE*</b> Pointer to a D3DDISPLAYMODE structure, to be filled with information describing
    ///            the current adapter's mode.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If Adapter is out of range or pMode
    ///    is invalid, this method returns D3DERR_INVALIDCALL.
    ///    
    HRESULT  GetAdapterDisplayMode(uint Adapter, D3DDISPLAYMODE* pMode);
    ///Verifies whether a hardware accelerated device type can be used on this adapter.
    ///Params:
    ///    iAdapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to enumerate. D3DADAPTER_DEFAULT is always the
    ///               primary display adapter. This method returns D3DERR_INVALIDCALL when this value equals or exceeds the number
    ///               of display adapters in the system.
    ///    DevType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type, indicating the device type to check.
    ///    DisplayFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, indicating the format of the adapter display
    ///                    mode for which the device type is to be checked. For example, some devices will operate only in
    ///                    16-bits-per-pixel modes.
    ///    BackBufferFormat = Type: <b>D3DFORMAT</b> Back buffer format. For more information about formats, see D3DFORMAT. This value must
    ///                       be one of the render-target formats. You can use GetAdapterDisplayMode to obtain the current format. For
    ///                       windowed applications, the back buffer format does not need to match the display mode format if the hardware
    ///                       supports color conversion. The set of possible back buffer formats is constrained, but the runtime will allow
    ///                       any valid back buffer format to be presented to any desktop format. There is the additional requirement that
    ///                       the device be operable in the desktop because devices typically do not operate in 8 bits per pixel modes.
    ///                       Full-screen applications cannot do color conversion. D3DFMT_UNKNOWN is allowed for windowed mode.
    ///    bWindowed = Type: <b>BOOL</b> Value indicating whether the device type will be used in full-screen or windowed mode. If
    ///                set to <b>TRUE</b>, the query is performed for windowed applications; otherwise, this value should be set
    ///                <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the device can be used on this adapter, D3D_OK is returned. D3DERR_INVALIDCALL is
    ///    returned if Adapter equals or exceeds the number of display adapters in the system. D3DERR_INVALIDCALL is
    ///    also returned if <b>CheckDeviceType</b> specified a device that does not exist. D3DERR_NOTAVAILABLE is
    ///    returned if the requested back buffer format is not supported, or if hardware acceleration is not available
    ///    for the specified formats.
    ///    
    HRESULT  CheckDeviceType(uint Adapter, D3DDEVTYPE DevType, D3DFORMAT AdapterFormat, D3DFORMAT BackBufferFormat, 
                             BOOL bWindowed);
    ///Determines whether a surface format is available as a specified resource type and can be used as a texture,
    ///depth-stencil buffer, or render target, or any combination of the three, on a device representing this adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to query. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter. This method returns D3DERR_INVALIDCALL when this value equals or exceeds the number
    ///              of display adapters in the system.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type, identifying the device type.
    ///    AdapterFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, identifying the format of the display mode
    ///                    into which the adapter will be placed.
    ///    Usage = Type: <b>DWORD</b> Requested usage options for the surface. Usage options are any combination of D3DUSAGE and
    ///            D3DUSAGE_QUERY constants (only a subset of the D3DUSAGE constants are valid for <b>CheckDeviceFormat</b>; see
    ///            the table on the D3DUSAGE page).
    ///    RType = Type: <b>D3DRESOURCETYPE</b> Resource type requested for use with the queried format. Member of
    ///            D3DRESOURCETYPE.
    ///    CheckFormat = Type: <b>D3DFORMAT</b> Format of the surfaces which may be used, as defined by Usage. Member of D3DFORMAT.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the format is compatible with the specified device for the requested usage, this
    ///    method returns D3D_OK. D3DERR_INVALIDCALL is returned if Adapter equals or exceeds the number of display
    ///    adapters in the system, or if DeviceType is unsupported. D3DERR_NOTAVAILABLE is returned if the format is not
    ///    acceptable to the device for this usage.
    ///    
    HRESULT  CheckDeviceFormat(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT AdapterFormat, uint Usage, 
                               D3DRESOURCETYPE RType, D3DFORMAT CheckFormat);
    ///Determines if a multisampling technique is available on this device.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to query. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter. This method returns <b>FALSE</b> when this value equals or exceeds the number of
    ///              display adapters in the system. See Remarks.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type, identifying the device type.
    ///    SurfaceFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type that specifies the format of the surface to be
    ///                    multisampled. For more information, see Remarks.
    ///    Windowed = Type: <b>BOOL</b> bool value. Specify <b>TRUE</b> to inquire about windowed multisampling, and specify
    ///               <b>FALSE</b> to inquire about full-screen multisampling.
    ///    MultiSampleType = Type: <b>D3DMULTISAMPLE_TYPE</b> Member of the D3DMULTISAMPLE_TYPE enumerated type, identifying the
    ///                      multisampling technique to test.
    ///    pQualityLevels = Type: <b>DWORD*</b> <b>pQualityLevels</b> returns the number of device-specific sampling variations available
    ///                     with the given sample type. For example, if the returned value is 3, then quality levels 0, 1 and 2 can be
    ///                     used when creating resources with the given sample count. The meanings of these quality levels are defined by
    ///                     the device manufacturer and cannot be queried through D3D. For example, for a particular device different
    ///                     quality levels at a fixed sample count might refer to different spatial layouts of the sample locations or
    ///                     different methods of resolving. This can be <b>NULL</b> if it is not necessary to return the quality levels.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the device can perform the specified multisampling method, this method returns
    ///    D3D_OK. D3DERR_INVALIDCALL is returned if the Adapter or MultiSampleType parameters are invalid. This method
    ///    returns D3DERR_NOTAVAILABLE if the queried multisampling technique is not supported by this device.
    ///    D3DERR_INVALIDDEVICE is returned if DeviceType does not apply to this adapter.
    ///    
    HRESULT  CheckDeviceMultiSampleType(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT SurfaceFormat, 
                                        BOOL Windowed, D3DMULTISAMPLE_TYPE MultiSampleType, uint* pQualityLevels);
    ///Determines whether a depth-stencil format is compatible with a render-target format in a particular display mode.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to query. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type, identifying the device type.
    ///    AdapterFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, identifying the format of the display mode
    ///                    into which the adapter will be placed.
    ///    RenderTargetFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, identifying the format of the render-target
    ///                         surface to be tested.
    ///    DepthStencilFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, identifying the format of the depth-stencil
    ///                         surface to be tested.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the depth-stencil format is compatible with the render-target format in the display
    ///    mode, this method returns D3D_OK. D3DERR_INVALIDCALL can be returned if one or more of the parameters is
    ///    invalid. If a depth-stencil format is not compatible with the render target in the display mode, then this
    ///    method returns D3DERR_NOTAVAILABLE.
    ///    
    HRESULT  CheckDepthStencilMatch(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT AdapterFormat, 
                                    D3DFORMAT RenderTargetFormat, D3DFORMAT DepthStencilFormat);
    ///Tests the device to see if it supports conversion from one display format to another.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Display adapter ordinal number. D3DADAPTER_DEFAULT is always the primary display adapter.
    ///              This method returns D3DERR_INVALIDCALL when this value equals or exceeds the number of display adapters in
    ///              the system.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Device type. Member of the D3DDEVTYPE enumerated type.
    ///    SourceFormat = Type: <b>D3DFORMAT</b> Source adapter format. Member of the D3DFORMAT enumerated type.
    ///    TargetFormat = Type: <b>D3DFORMAT</b> Target adapter format. Member of the D3DFORMAT enumerated type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value is D3DERR_INVALIDCALL. The method will return D3DERR_NOTAVAILABLE when the hardware does not support
    ///    conversion between the two formats.
    ///    
    HRESULT  CheckDeviceFormatConversion(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT SourceFormat, 
                                         D3DFORMAT TargetFormat);
    ///Retrieves device-specific information about a device.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type. Denotes the device type.
    ///    pCaps = Type: <b>D3DCAPS9*</b> Pointer to a D3DCAPS9 structure to be filled with information describing the
    ///            capabilities of the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_INVALIDDEVICE, D3DERR_OUTOFVIDEOMEMORY, and
    ///    D3DERR_NOTAVAILABLE.
    ///    
    HRESULT  GetDeviceCaps(uint Adapter, D3DDEVTYPE DeviceType, D3DCAPS9* pCaps);
    ///Returns the handle of the monitor associated with the Direct3D object.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter.
    ///Returns:
    ///    Type: <b>HMONITOR</b> Handle of the monitor associated with the Direct3D object.
    ///    
    HMONITOR GetAdapterMonitor(uint Adapter);
    ///Creates a device to represent the display adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type that denotes the desired device type. If the
    ///                 desired device type is not available, the method will fail.
    ///    hFocusWindow = Type: <b>HWND</b> The focus window alerts Direct3D when an application switches from foreground mode to
    ///                   background mode. See Remarks. <ul> <li>For full-screen mode, the window specified must be a top-level
    ///                   window.</li> <li>For windowed mode, this parameter may be <b>NULL</b> only if the hDeviceWindow member of
    ///                   <i>pPresentationParameters</i> is set to a valid, non-<b>NULL</b> value.</li> </ul>
    ///    BehaviorFlags = Type: <b>DWORD</b> Combination of one or more options that control device creation. For more information, see
    ///                    D3DCREATE.
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to a D3DPRESENT_PARAMETERS structure, describing the presentation
    ///                              parameters for the device to be created. If BehaviorFlags specifies D3DCREATE_ADAPTERGROUP_DEVICE,
    ///                              pPresentationParameters is an array. Regardless of the number of heads that exist, only one depth/stencil
    ///                              surface is automatically created. For Windows 2000 and Windows XP, the full-screen device display refresh
    ///                              rate is set in the following order: <ol> <li>User-specified nonzero ForcedRefreshRate registry key, if
    ///                              supported by the device.</li> <li>Application-specified nonzero refresh rate value in the presentation
    ///                              parameter.</li> <li>Refresh rate of the latest desktop, if supported by the device.</li> <li>75 hertz if
    ///                              supported by the device.</li> <li>60 hertz if supported by the device.</li> <li>Device default.</li> </ol> An
    ///                              unsupported refresh rate will default to the closest supported refresh rate below it. For example, if the
    ///                              application specifies 63 hertz, 60 hertz will be used. There are no supported refresh rates below 57 hertz.
    ///                              pPresentationParameters is both an input and an output parameter. Calling this method may change several
    ///                              members including: <ul> <li>If BackBufferCount, BackBufferWidth, and BackBufferHeight are 0 before the method
    ///                              is called, they will be changed when the method returns.</li> <li>If BackBufferFormat equals D3DFMT_UNKNOWN
    ///                              before the method is called, it will be changed when the method returns.</li> </ul>
    ///    ppReturnedDeviceInterface = Type: <b>IDirect3DDevice9**</b> Address of a pointer to the returned IDirect3DDevice9 interface, which
    ///                                represents the created device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_DEVICELOST, D3DERR_INVALIDCALL, D3DERR_NOTAVAILABLE,
    ///    D3DERR_OUTOFVIDEOMEMORY.
    ///    
    HRESULT  CreateDevice(uint Adapter, D3DDEVTYPE DeviceType, HWND hFocusWindow, uint BehaviorFlags, 
                          D3DPRESENT_PARAMETERS* pPresentationParameters, 
                          IDirect3DDevice9* ppReturnedDeviceInterface);
}

///Applications use the methods of the IDirect3DDevice9 interface to perform DrawPrimitive-based rendering, create
///resources, work with system-level variables, adjust gamma ramp levels, work with palettes, and create shaders.
@GUID("D0223B96-BF7A-43FD-92BD-A43B0D82B9EB")
interface IDirect3DDevice9 : IUnknown
{
    ///Reports the current cooperative-level status of the Direct3D device for a windowed or full-screen application.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK, indicating that the device is
    ///    operational and the calling application can continue. If the method fails, the return value can be one of the
    ///    following values: D3DERR_DEVICELOST, D3DERR_DEVICENOTRESET, D3DERR_DRIVERINTERNALERROR.
    ///    
    HRESULT TestCooperativeLevel();
    ///Returns an estimate of the amount of available texture memory.
    ///Returns:
    ///    Type: <b>UINT</b> The function returns an estimate of the available texture memory.
    ///    
    uint    GetAvailableTextureMem();
    ///Evicts all managed resources, including both Direct3D and driver-managed resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_OUTOFVIDEOMEMORY, D3DERR_COMMAND_UNPARSED.
    ///    
    HRESULT EvictManagedResources();
    ///Returns an interface to the instance of the Direct3D object that created the device.
    ///Params:
    ///    ppD3D9 = Type: <b>IDirect3D9**</b> Address of a pointer to an IDirect3D9 interface, representing the interface of the
    ///             Direct3D object that created the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDirect3D(IDirect3D9* ppD3D9);
    ///Retrieves the capabilities of the rendering device.
    ///Params:
    ///    pCaps = Type: <b>D3DCAPS9*</b> Pointer to a D3DCAPS9 structure, describing the returned device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDeviceCaps(D3DCAPS9* pCaps);
    ///Retrieves the display mode's spatial resolution, color resolution, and refresh frequency.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    pMode = Type: <b>D3DDISPLAYMODE*</b> Pointer to a D3DDISPLAYMODE structure containing data about the display mode of
    ///            the adapter. As opposed to the display mode of the device, which may not be active if the device does not own
    ///            full-screen mode.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDisplayMode(uint iSwapChain, D3DDISPLAYMODE* pMode);
    ///Retrieves the creation parameters of the device.
    ///Params:
    ///    pParameters = Type: <b>D3DDEVICE_CREATION_PARAMETERS*</b> Pointer to a D3DDEVICE_CREATION_PARAMETERS structure, describing
    ///                  the creation parameters of the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetCreationParameters(D3DDEVICE_CREATION_PARAMETERS* pParameters);
    ///Sets properties for the cursor.
    ///Params:
    ///    XHotSpot = Type: <b>UINT</b> X-coordinate offset (in pixels) that marks the center of the cursor. The offset is relative
    ///               to the upper-left corner of the cursor. When the cursor is given a new position, the image is drawn at an
    ///               offset from this new position determined by subtracting the hot spot coordinates from the position.
    ///    YHotSpot = Type: <b>UINT</b> Y-coordinate offset (in pixels) that marks the center of the cursor. The offset is relative
    ///               to the upper-left corner of the cursor. When the cursor is given a new position, the image is drawn at an
    ///               offset from this new position determined by subtracting the hot spot coordinates from the position.
    ///    pCursorBitmap = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 interface. This parameter must point to an
    ///                    8888 ARGB surface (format D3DFMT_A8R8G8B8). The contents of this surface will be copied and potentially
    ///                    format-converted into an internal buffer from which the cursor is displayed. The dimensions of this surface
    ///                    must be less than the dimensions of the display mode, and must be a power of two in each direction, although
    ///                    not necessarily the same power of two. The alpha channel must be either 0.0 or 1.0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetCursorProperties(uint XHotSpot, uint YHotSpot, IDirect3DSurface9 pCursorBitmap);
    ///Sets the cursor position and update options.
    ///Params:
    ///    X = Type: <b>INT</b> The new X-position of the cursor in virtual desktop coordinates. See Remarks.
    ///    Y = Type: <b>INT</b> The new Y-position of the cursor in virtual desktop coordinates. See Remarks.
    ///    Flags = Type: <b>DWORD</b> Specifies the update options for the cursor. Currently, only one flag is defined. <table>
    ///            <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DCURSOR_IMMEDIATE_UPDATE"></a><a
    ///            id="d3dcursor_immediate_update"></a><dl> <dt><b>D3DCURSOR_IMMEDIATE_UPDATE</b></dt> </dl> </td> <td
    ///            width="60%"> Update cursor at the refresh rate. If this flag is specified, the system guarantees that the
    ///            cursor will be updated at a minimum of half the display refresh rate, but never more frequently than the
    ///            display refresh rate. Otherwise, the method delays cursor updates until the next IDirect3DDevice9::Present
    ///            call. Not setting this flag usually results in better performance than if the flag is set. However,
    ///            applications should set this flag if the rate of calls to Present is low enough that users would notice a
    ///            significant delay in cursor motion. This flag has no effect in a windowed-mode application. Some video cards
    ///            implement hardware color cursors. This flag does not have an effect on these cards. </td> </tr> </table>
    void    SetCursorPosition(int X, int Y, uint Flags);
    ///Displays or hides the cursor.
    ///Params:
    ///    bShow = Type: <b>BOOL</b> If bShow is <b>TRUE</b>, the cursor is shown. If bShow is <b>FALSE</b>, the cursor is
    ///            hidden.
    ///Returns:
    ///    Type: <b>BOOL</b> Value indicating whether the cursor was previously visible. <b>TRUE</b> if the cursor was
    ///    previously visible, or <b>FALSE</b> if the cursor was not previously visible.
    ///    
    BOOL    ShowCursor(BOOL bShow);
    ///Creates an additional swap chain for rendering multiple views.
    ///Params:
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to a D3DPRESENT_PARAMETERS structure, containing the presentation
    ///                              parameters for the new swap chain. This value cannot be <b>NULL</b>. Calling this method changes the value of
    ///                              members of the D3DPRESENT_PARAMETERS structure. <ul> <li>If BackBufferCount == 0, calling
    ///                              CreateAdditionalSwapChain will increase it to 1.</li> <li>If the application is in windowed mode, and if
    ///                              either the BackBufferWidth or the BackBufferHeight == 0, they will be set to the client area width and height
    ///                              of the hwnd.</li> </ul>
    ///    pSwapChain = Type: <b>IDirect3DSwapChain9**</b> Address of a pointer to an IDirect3DSwapChain9 interface, representing the
    ///                 additional swap chain.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_NOTAVAILABLE, D3DERR_DEVICELOST, D3DERR_INVALIDCALL,
    ///    D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateAdditionalSwapChain(D3DPRESENT_PARAMETERS* pPresentationParameters, 
                                      IDirect3DSwapChain9* pSwapChain);
    ///Gets a pointer to a swap chain.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> The swap chain ordinal value. For more information, see NumberOfAdaptersInGroup in
    ///                 D3DCAPS9.
    ///    pSwapChain = Type: <b>IDirect3DSwapChain9**</b> Pointer to an IDirect3DSwapChain9 interface that will receive a copy of
    ///                 swap chain.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetSwapChain(uint iSwapChain, IDirect3DSwapChain9* pSwapChain);
    ///Gets the number of implicit swap chains.
    ///Returns:
    ///    Type: <b>UINT</b> Number of implicit swap chains. See Remarks.
    ///    
    uint    GetNumberOfSwapChains();
    ///Resets the type, size, and format of the swap chain.
    ///Params:
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to a D3DPRESENT_PARAMETERS structure, describing the new
    ///                              presentation parameters. This value cannot be <b>NULL</b>. When switching to full-screen mode, Direct3D will
    ///                              try to find a desktop format that matches the back buffer format, so that back buffer and front buffer
    ///                              formats will be identical (to eliminate the need for color conversion). When this method returns: <ul>
    ///                              <li>BackBufferCount, BackBufferWidth, and BackBufferHeight are set to zero.</li> <li>BackBufferFormat is set
    ///                              to D3DFMT_UNKNOWN for windowed mode only; a full-screen mode must specify a format.</li> </ul>
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK, D3DERR_DEVICELOST, D3DERR_DEVICEREMOVED,
    ///    D3DERR_DRIVERINTERNALERROR, or D3DERR_OUTOFVIDEOMEMORY (see D3DERR).
    ///    
    HRESULT Reset(D3DPRESENT_PARAMETERS* pPresentationParameters);
    ///Presents the contents of the next buffer in the sequence of back buffers owned by the device.
    ///Params:
    ///    pSourceRect = Type: <b>const RECT*</b> Pointer to a value that must be <b>NULL</b> unless the swap chain was created with
    ///                  D3DSWAPEFFECT_COPY. pSourceRect is a pointer to a RECT structure containing the source rectangle. If
    ///                  <b>NULL</b>, the entire source surface is presented. If the rectangle exceeds the source surface, the
    ///                  rectangle is clipped to the source surface.
    ///    pDestRect = Type: <b>const RECT*</b> Pointer to a value that must be <b>NULL</b> unless the swap chain was created with
    ///                D3DSWAPEFFECT_COPY. pDestRect is a pointer to a RECT structure containing the destination rectangle, in
    ///                window client coordinates. If <b>NULL</b>, the entire client area is filled. If the rectangle exceeds the
    ///                destination client area, the rectangle is clipped to the destination client area.
    ///    hDestWindowOverride = Type: <b>HWND</b> Pointer to a destination window whose client area is taken as the target for this
    ///                          presentation. If this value is <b>NULL</b>, the runtime uses the <b>hDeviceWindow</b> member of
    ///                          D3DPRESENT_PARAMETERS for the presentation.
    ///    pDirtyRegion = Type: <b>const RGNDATA*</b> Value must be <b>NULL</b> unless the swap chain was created with
    ///                   D3DSWAPEFFECT_COPY. For more information about swap chains, see Flipping Surfaces (Direct3D 9) and
    ///                   D3DSWAPEFFECT. If this value is non-<b>NULL</b>, the contained region is expressed in back buffer
    ///                   coordinates. The rectangles within the region are the minimal set of pixels that need to be updated. This
    ///                   method takes these rectangles into account when optimizing the presentation by copying only the pixels within
    ///                   the region, or some suitably expanded set of rectangles. This is an aid to optimization only, and the
    ///                   application should not rely on the region being copied exactly. The implementation can choose to copy the
    ///                   whole source rectangle.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK or D3DERR_DEVICEREMOVED (see D3DERR).
    ///    
    HRESULT Present(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, 
                    const(RGNDATA)* pDirtyRegion);
    ///Retrieves a back buffer from the device's swap chain.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    iBackBuffer = Type: <b>UINT</b> Index of the back buffer object to return. Back buffers are numbered from 0 to the total
    ///                  number of back buffers minus one. A value of 0 returns the first back buffer, not the front buffer. The front
    ///                  buffer is not accessible through this method. Use IDirect3DDevice9::GetFrontBufferData to retrieve a copy of
    ///                  the front buffer.
    ///    Type = Type: <b>D3DBACKBUFFER_TYPE</b> Stereo view is not supported in Direct3D 9, so the only valid value for this
    ///           parameter is D3DBACKBUFFER_TYPE_MONO.
    ///    ppBackBuffer = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                   returned back buffer surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If BackBuffer equals or exceeds the
    ///    total number of back buffers, then the function fails and returns D3DERR_INVALIDCALL.
    ///    
    HRESULT GetBackBuffer(uint iSwapChain, uint iBackBuffer, D3DBACKBUFFER_TYPE Type, 
                          IDirect3DSurface9* ppBackBuffer);
    ///Returns information describing the raster of the monitor on which the swap chain is presented.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    pRasterStatus = Type: <b>D3DRASTER_STATUS*</b> Pointer to a D3DRASTER_STATUS structure filled with information about the
    ///                    position or other status of the raster on the monitor driven by this adapter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    pRasterStatus is invalid or if the device does not support reading the current scan line. To determine if the
    ///    device supports reading the scan line, check for the D3DCAPS_READ_SCANLINE flag in the Caps member of
    ///    D3DCAPS9.
    ///    
    HRESULT GetRasterStatus(uint iSwapChain, D3DRASTER_STATUS* pRasterStatus);
    ///This method allows the use of GDI dialog boxes in full-screen mode applications.
    ///Params:
    ///    bEnableDialogs = Type: <b>BOOL</b> <b>TRUE</b> to enable GDI dialog boxes, and <b>FALSE</b> to disable them.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL unless all of the following are true. <ul> <li>The application specified a
    ///    back buffer format compatible with GDI, in other words, one of D3DFMT_X1R5G5B5, D3DFMT_R5G6B5, or
    ///    D3DFMT_X8R8G8B8.</li> <li>The application specified no multisampling.</li> <li>The application specified
    ///    D3DSWAPEFFECT_DISCARD.</li> <li>The application specified D3DPRESENTFLAG_LOCKABLE_BACKBUFFER.</li> <li>The
    ///    application did not specify D3DCREATE_ADAPTERGROUP_DEVICE.</li> <li>The application is not between BeginScene
    ///    and EndScene.</li> </ul>
    ///    
    HRESULT SetDialogBoxMode(BOOL bEnableDialogs);
    ///Sets the gamma correction ramp for the implicit swap chain. This method will affect the entire screen (not just
    ///the active window if you are running in windowed mode).
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> Unsigned integer specifying the swap chain.
    ///    Flags = Type: <b>DWORD</b> Indicates whether correction should be applied. Gamma correction results in a more
    ///            consistent display, but can incur processing overhead and should not be used frequently. Short-duration
    ///            effects, such as flashing the whole screen red, should not be calibrated, but long-duration gamma changes
    ///            should be calibrated. One of the following values can be set: <table> <tr> <th>Item</th> <th>Description</th>
    ///            </tr> <tr> <td width="40%"> <a id="D3DSGR_CALIBRATE"></a><a id="d3dsgr_calibrate"></a>D3DSGR_CALIBRATE </td>
    ///            <td width="60%"> If a gamma calibrator is installed, the ramp will be modified before being sent to the
    ///            device to account for the system and monitor response curves. If a calibrator is not installed, the ramp will
    ///            be passed directly to the device. </td> </tr> <tr> <td width="40%"> <a id="D3DSGR_NO_CALIBRATION"></a><a
    ///            id="d3dsgr_no_calibration"></a>D3DSGR_NO_CALIBRATION </td> <td width="60%"> No gamma correction is applied.
    ///            The supplied gamma table is transferred directly to the device. </td> </tr> </table>
    ///    pRamp = Type: <b>const D3DGAMMARAMP*</b> Pointer to a D3DGAMMARAMP structure, representing the gamma correction ramp
    ///            to be set for the implicit swap chain.
    void    SetGammaRamp(uint iSwapChain, uint Flags, const(D3DGAMMARAMP)* pRamp);
    ///Retrieves the gamma correction ramp for the swap chain.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    pRamp = Type: <b>D3DGAMMARAMP*</b> Pointer to an application-supplied D3DGAMMARAMP structure to fill with the gamma
    ///            correction ramp.
    void    GetGammaRamp(uint iSwapChain, D3DGAMMARAMP* pRamp);
    ///Creates a texture resource.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the top-level of the texture, in pixels. The pixel dimensions of subsequent levels
    ///            will be the truncated value of half of the previous level's pixel dimension (independently). Each dimension
    ///            clamps at a size of 1 pixel. Thus, if the division by 2 results in 0, 1 will be taken instead.
    ///    Height = Type: <b>UINT</b> Height of the top-level of the texture, in pixels. The pixel dimensions of subsequent
    ///             levels will be the truncated value of half of the previous level's pixel dimension (independently). Each
    ///             dimension clamps at a size of 1 pixel. Thus, if the division by 2 results in 0, 1 will be taken instead.
    ///    Levels = Type: <b>UINT</b> Number of levels in the texture. If this is zero, Direct3D will generate all texture
    ///             sublevels down to 1 by 1 pixels for hardware that supports mipmapped textures. Call
    ///             IDirect3DBaseTexture9::GetLevelCount to see the number of levels generated.
    ///    Usage = Type: <b>DWORD</b> Usage can be 0, which indicates no usage value. However, if usage is desired, use a
    ///            combination of one or more D3DUSAGE constants. It is good practice to match the usage parameter with the
    ///            behavior flags in IDirect3D9::CreateDevice.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of all levels in the
    ///             texture.
    ///    Pool = Type: <b>D3DPOOL</b> Member of the D3DPOOL enumerated type, describing the memory class into which the
    ///           texture should be placed.
    ///    ppTexture = Type: <b>IDirect3DTexture9**</b> Pointer to an IDirect3DTexture9 interface, representing the created texture
    ///                resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateTexture(uint Width, uint Height, uint Levels, uint Usage, D3DFORMAT Format, D3DPOOL Pool, 
                          IDirect3DTexture9* ppTexture, HANDLE* pSharedHandle);
    ///Creates a volume texture resource.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the top-level of the volume texture, in pixels. This value must be a power of two
    ///            if the D3DPTEXTURECAPS_VOLUMEMAP_POW2 member of D3DCAPS9 is set. The pixel dimensions of subsequent levels
    ///            will be the truncated value of half of the previous level's pixel dimension (independently). Each dimension
    ///            clamps at a size of 1 pixel. Thus, if the division by two results in 0 (zero), 1 will be taken instead. The
    ///            maximum dimension that a driver supports (for width, height, and depth) can be found in MaxVolumeExtent in
    ///            <b>D3DCAPS9</b>.
    ///    Height = Type: <b>UINT</b> Height of the top-level of the volume texture, in pixels. This value must be a power of two
    ///             if the D3DPTEXTURECAPS_VOLUMEMAP_POW2 member of D3DCAPS9 is set. The pixel dimensions of subsequent levels
    ///             will be the truncated value of half of the previous level's pixel dimension (independently). Each dimension
    ///             clamps at a size of 1 pixel. Thus, if the division by 2 results in 0 (zero), 1 will be taken instead. The
    ///             maximum dimension that a driver supports (for width, height, and depth) can be found in MaxVolumeExtent in
    ///             <b>D3DCAPS9</b>.
    ///    Depth = Type: <b>UINT</b> Depth of the top-level of the volume texture, in pixels. This value must be a power of two
    ///            if the D3DPTEXTURECAPS_VOLUMEMAP_POW2 member of D3DCAPS9 is set. The pixel dimensions of subsequent levels
    ///            will be the truncated value of half of the previous level's pixel dimension (independently). Each dimension
    ///            clamps at a size of 1 pixel. Thus, if the division by 2 results in 0 (zero), 1 will be taken instead. The
    ///            maximum dimension that a driver supports (for width, height, and depth) can be found in MaxVolumeExtent in
    ///            <b>D3DCAPS9</b>.
    ///    Levels = Type: <b>UINT</b> Number of levels in the texture. If this is zero, Direct3D will generate all texture
    ///             sublevels down to 1x1 pixels for hardware that supports mipmapped volume textures. Call
    ///             IDirect3DBaseTexture9::GetLevelCount to see the number of levels generated.
    ///    Usage = Type: <b>DWORD</b> Usage can be 0, which indicates no usage value. If usage is desired, use D3DUSAGE_DYNAMIC
    ///            or D3DUSAGE_SOFTWAREPROCESSING. For more information, see D3DUSAGE.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of all levels in the
    ///             volume texture.
    ///    Pool = Type: <b>D3DPOOL</b> Member of the D3DPOOL enumerated type, describing the memory class into which the volume
    ///           texture should be placed.
    ///    ppVolumeTexture = Type: <b>IDirect3DVolumeTexture9**</b> Address of a pointer to an IDirect3DVolumeTexture9 interface,
    ///                      representing the created volume texture resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateVolumeTexture(uint Width, uint Height, uint Depth, uint Levels, uint Usage, D3DFORMAT Format, 
                                D3DPOOL Pool, IDirect3DVolumeTexture9* ppVolumeTexture, HANDLE* pSharedHandle);
    ///Creates a cube texture resource.
    ///Params:
    ///    EdgeLength = Type: <b>UINT</b> Size of the edges of all the top-level faces of the cube texture. The pixel dimensions of
    ///                 subsequent levels of each face will be the truncated value of half of the previous level's pixel dimension
    ///                 (independently). Each dimension clamps at a size of 1 pixel. Thus, if the division by 2 results in 0 (zero),
    ///                 1 will be taken instead.
    ///    Levels = Type: <b>UINT</b> Number of levels in each face of the cube texture. If this is zero, Direct3D will generate
    ///             all cube texture sublevels down to 1x1 pixels for each face for hardware that supports mipmapped cube
    ///             textures. Call IDirect3DBaseTexture9::GetLevelCount to see the number of levels generated.
    ///    Usage = Type: <b>DWORD</b> Usage can be 0, which indicates no usage value. However, if usage is desired, use a
    ///            combination of one or more D3DUSAGE constants. It is good practice to match the usage parameter in
    ///            CreateCubeTexture with the behavior flags in IDirect3D9::CreateDevice. For more information, see Remarks.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of all levels in all
    ///             faces of the cube texture.
    ///    Pool = Type: <b>D3DPOOL</b> Member of the D3DPOOL enumerated type, describing the memory class into which the cube
    ///           texture should be placed.
    ///    ppCubeTexture = Type: <b>IDirect3DCubeTexture9**</b> Address of a pointer to an IDirect3DCubeTexture9 interface, representing
    ///                    the created cube texture resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateCubeTexture(uint EdgeLength, uint Levels, uint Usage, D3DFORMAT Format, D3DPOOL Pool, 
                              IDirect3DCubeTexture9* ppCubeTexture, HANDLE* pSharedHandle);
    ///Creates a vertex buffer.
    ///Params:
    ///    Length = Type: <b>UINT</b> Size of the vertex buffer, in bytes. For FVF vertex buffers, Length must be large enough to
    ///             contain at least one vertex, but it need not be a multiple of the vertex size. Length is not validated for
    ///             non-FVF buffers. See Remarks.
    ///    Usage = Type: <b>DWORD</b> Usage can be 0, which indicates no usage value. However, if usage is desired, use a
    ///            combination of one or more D3DUSAGE constants. It is good practice to match the usage parameter in
    ///            CreateVertexBuffer with the behavior flags in IDirect3D9::CreateDevice. For more information, see Remarks.
    ///    FVF = Type: <b>DWORD</b> Combination of D3DFVF, a usage specifier that describes the vertex format of the vertices
    ///          in this buffer. If this parameter is set to a valid FVF code, the created vertex buffer is an FVF vertex
    ///          buffer (see Remarks). Otherwise, if this parameter is set to zero, the vertex buffer is a non-FVF vertex
    ///          buffer.
    ///    Pool = Type: <b>D3DPOOL</b> Member of the D3DPOOL enumerated type, describing a valid memory class into which to
    ///           place the resource. Do not set to D3DPOOL_SCRATCH.
    ///    ppVertexBuffer = Type: <b>IDirect3DVertexBuffer9**</b> Address of a pointer to an IDirect3DVertexBuffer9 interface,
    ///                     representing the created vertex buffer resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateVertexBuffer(uint Length, uint Usage, uint FVF, D3DPOOL Pool, 
                               IDirect3DVertexBuffer9* ppVertexBuffer, HANDLE* pSharedHandle);
    ///Creates an index buffer.
    ///Params:
    ///    Length = Type: <b>UINT</b> Size of the index buffer, in bytes.
    ///    Usage = Type: <b>DWORD</b> Usage can be 0, which indicates no usage value. However, if usage is desired, use a
    ///            combination of one or more D3DUSAGE constants. It is good practice to match the usage parameter in
    ///            CreateIndexBuffer with the behavior flags in IDirect3D9::CreateDevice. For more information, see Remarks.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the index buffer.
    ///             For more information, see Remarks. The valid settings are the following: <table> <tr> <th>Item</th>
    ///             <th>Description</th> </tr> <tr> <td width="40%"> <a id="D3DFMT_INDEX16"></a><a
    ///             id="d3dfmt_index16"></a>D3DFMT_INDEX16 </td> <td width="60%"> Indices are 16 bits each. </td> </tr> <tr> <td
    ///             width="40%"> <a id="D3DFMT_INDEX32"></a><a id="d3dfmt_index32"></a>D3DFMT_INDEX32 </td> <td width="60%">
    ///             Indices are 32 bits each. </td> </tr> </table>
    ///    Pool = Type: <b>D3DPOOL</b> Member of the D3DPOOL enumerated type, describing a valid memory class into which to
    ///           place the resource.
    ///    ppIndexBuffer = Type: <b>IDirect3DIndexBuffer9**</b> Address of a pointer to an IDirect3DIndexBuffer9 interface, representing
    ///                    the created index buffer resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> This parameter can be used in Direct3D 9 for Windows Vista to share resources; set it to
    ///                    <b>NULL</b> to not share a resource. This parameter is not used in Direct3D 9 for operating systems earlier
    ///                    than Windows Vista; set it to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, D3DXERR_INVALIDDATA,
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT CreateIndexBuffer(uint Length, uint Usage, D3DFORMAT Format, D3DPOOL Pool, 
                              IDirect3DIndexBuffer9* ppIndexBuffer, HANDLE* pSharedHandle);
    ///Creates a render-target surface.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the render-target surface, in pixels.
    ///    Height = Type: <b>UINT</b> Height of the render-target surface, in pixels.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the render target.
    ///    MultiSample = Type: <b>D3DMULTISAMPLE_TYPE</b> Member of the D3DMULTISAMPLE_TYPE enumerated type, which describes the
    ///                  multisampling buffer type. This parameter specifies the antialiasing type for this render target. When this
    ///                  surface is passed to IDirect3DDevice9::SetRenderTarget, its multisample type must be the same as that of the
    ///                  depth-stencil set by IDirect3DDevice9::SetDepthStencilSurface.
    ///    MultisampleQuality = Type: <b>DWORD</b> Quality level. The valid range is between zero and one less than the level returned by
    ///                         pQualityLevels used by IDirect3D9::CheckDeviceMultiSampleType. Passing a larger value returns the error,
    ///                         D3DERR_INVALIDCALL. The MultisampleQuality values of paired render targets, depth stencil surfaces, and the
    ///                         multisample type must all match.
    ///    Lockable = Type: <b>BOOL</b> Render targets are not lockable unless the application specifies <b>TRUE</b> for Lockable.
    ///               Note that lockable render targets reduce performance on some graphics hardware. The readback performance
    ///               (moving data from video memory to system memory) depends on the type of hardware used (AGP vs. PCI Express)
    ///               and is usually far lower than upload performance (moving data from system to video memory). If you need read
    ///               access to render targets, use GetRenderTargetData instead of lockable render targets.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_NOTAVAILABLE, D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY,
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT CreateRenderTarget(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                               uint MultisampleQuality, BOOL Lockable, IDirect3DSurface9* ppSurface, 
                               HANDLE* pSharedHandle);
    ///Creates a depth-stencil resource.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the depth-stencil surface, in pixels.
    ///    Height = Type: <b>UINT</b> Height of the depth-stencil surface, in pixels.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the depth-stencil
    ///             surface. This value must be one of the enumerated depth-stencil formats for this device.
    ///    MultiSample = Type: <b>D3DMULTISAMPLE_TYPE</b> Member of the D3DMULTISAMPLE_TYPE enumerated type, describing the
    ///                  multisampling buffer type. This value must be one of the allowed multisample types. When this surface is
    ///                  passed to IDirect3DDevice9::SetDepthStencilSurface, its multisample type must be the same as that of the
    ///                  render target set by IDirect3DDevice9::SetRenderTarget.
    ///    MultisampleQuality = Type: <b>DWORD</b> Quality level. The valid range is between zero and one less than the level returned by
    ///                         pQualityLevels used by IDirect3D9::CheckDeviceMultiSampleType. Passing a larger value returns the error
    ///                         D3DERR_INVALIDCALL. The MultisampleQuality values of paired render targets, depth stencil surfaces, and the
    ///                         MultiSample type must all match.
    ///    Discard = Type: <b>BOOL</b> Set this flag to <b>TRUE</b> to enable z-buffer discarding, and <b>FALSE</b> otherwise. If
    ///              this flag is set, the contents of the depth stencil buffer will be invalid after calling either
    ///              IDirect3DDevice9::Present or IDirect3DDevice9::SetDepthStencilSurface with a different depth surface. This
    ///              flag has the same behavior as the constant, D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL, in D3DPRESENTFLAG.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                created depth-stencil surface resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_NOTAVAILABLE, D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY,
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT CreateDepthStencilSurface(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                                      uint MultisampleQuality, BOOL Discard, IDirect3DSurface9* ppSurface, 
                                      HANDLE* pSharedHandle);
    ///Copies rectangular subsets of pixels from one surface to another.
    ///Params:
    ///    pSourceSurface = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 interface, representing the source surface.
    ///                     This parameter must point to a different surface than pDestinationSurface.
    ///    pSourceRect = Type: <b>const RECT*</b> Pointer to a rectangle on the source surface. Specifying <b>NULL</b> for this
    ///                  parameter causes the entire surface to be copied.
    ///    pDestinationSurface = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 interface, representing the destination
    ///                          surface.
    ///    pDestPoint = Type: <b>const POINT*</b> Pointer to the upper left corner of the destination rectangle. Specifying
    ///                 <b>NULL</b> for this parameter causes the entire surface to be copied.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT UpdateSurface(IDirect3DSurface9 pSourceSurface, const(RECT)* pSourceRect, 
                          IDirect3DSurface9 pDestinationSurface, const(POINT)* pDestPoint);
    ///Updates the dirty portions of a texture.
    ///Params:
    ///    pSourceTexture = Type: <b>IDirect3DBaseTexture9*</b> Pointer to an IDirect3DBaseTexture9 interface, representing the source
    ///                     texture. The source texture must be in system memory (D3DPOOL_SYSTEMMEM).
    ///    pDestinationTexture = Type: <b>IDirect3DBaseTexture9*</b> Pointer to an IDirect3DBaseTexture9 interface, representing the
    ///                          destination texture. The destination texture must be in the D3DPOOL_DEFAULT memory pool.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT UpdateTexture(IDirect3DBaseTexture9 pSourceTexture, IDirect3DBaseTexture9 pDestinationTexture);
    ///Copies the render-target data from device memory to system memory.
    ///Params:
    ///    pRenderTarget = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 object, representing a render target.
    ///    pDestSurface = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 object, representing a destination surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_DRIVERINTERNALERROR, D3DERR_DEVICELOST, D3DERR_INVALIDCALL.
    ///    
    HRESULT GetRenderTargetData(IDirect3DSurface9 pRenderTarget, IDirect3DSurface9 pDestSurface);
    ///Generates a copy of the device's front buffer and places that copy in a system memory buffer provided by the
    ///application.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    pDestSurface = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 interface that will receive a copy of the
    ///                   contents of the front buffer. The data is returned in successive rows with no intervening space, starting
    ///                   from the vertically highest row on the device's output to the lowest. For windowed mode, the size of the
    ///                   destination surface should be the size of the desktop. For full-screen mode, the size of the destination
    ///                   surface should be the screen size.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_DRIVERINTERNALERROR, D3DERR_DEVICELOST, D3DERR_INVALIDCALL
    ///    
    HRESULT GetFrontBufferData(uint iSwapChain, IDirect3DSurface9 pDestSurface);
    ///Copy the contents of the source rectangle to the destination rectangle. The source rectangle can be stretched and
    ///filtered by the copy. This function is often used to change the aspect ratio of a video stream.
    ///Params:
    ///    pSourceSurface = Type: <b>IDirect3DSurface9*</b> Pointer to the source surface. See IDirect3DSurface9.
    ///    pSourceRect = Type: <b>const RECT*</b> Pointer to the source rectangle. A <b>NULL</b> for this parameter causes the entire
    ///                  source surface to be used.
    ///    pDestSurface = Type: <b>IDirect3DSurface9*</b> Pointer to the destination surface. See IDirect3DSurface9.
    ///    pDestRect = Type: <b>const RECT*</b> Pointer to the destination rectangle. A <b>NULL</b> for this parameter causes the
    ///                entire destination surface to be used.
    ///    Filter = Type: <b>D3DTEXTUREFILTERTYPE</b> Filter type. Allowable values are D3DTEXF_NONE, D3DTEXF_POINT, or
    ///             D3DTEXF_LINEAR. For more information, see D3DTEXTUREFILTERTYPE.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT StretchRect(IDirect3DSurface9 pSourceSurface, const(RECT)* pSourceRect, IDirect3DSurface9 pDestSurface, 
                        const(RECT)* pDestRect, D3DTEXTUREFILTERTYPE Filter);
    ///Allows an application to fill a rectangular area of a D3DPOOL_DEFAULT surface with a specified color.
    ///Params:
    ///    pSurface = Type: <b>IDirect3DSurface9*</b> Pointer to the surface to be filled.
    ///    pRect = Type: <b>const RECT*</b> Pointer to the source rectangle. Using <b>NULL</b> means that the entire surface
    ///            will be filled.
    ///    color = Type: <b>D3DCOLOR</b> Color used for filling.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT ColorFill(IDirect3DSurface9 pSurface, const(RECT)* pRect, uint color);
    ///Create an off-screen surface.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the surface.
    ///    Height = Type: <b>UINT</b> Height of the surface.
    ///    Format = Type: <b>D3DFORMAT</b> Format of the surface. See D3DFORMAT.
    ///    Pool = Type: <b>D3DPOOL</b> Surface pool type. See D3DPOOL.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Pointer to the IDirect3DSurface9 interface created.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT CreateOffscreenPlainSurface(uint Width, uint Height, D3DFORMAT Format, D3DPOOL Pool, 
                                        IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle);
    ///Sets a new color buffer for the device.
    ///Params:
    ///    RenderTargetIndex = Type: <b>DWORD</b> Index of the render target. See Remarks.
    ///    pRenderTarget = Type: <b>IDirect3DSurface9*</b> Pointer to a new color buffer. If <b>NULL</b>, the color buffer for the
    ///                    corresponding RenderTargetIndex is disabled. Devices always must be associated with a color buffer. The new
    ///                    render-target surface must have at least D3DUSAGE_RENDERTARGET specified.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. This method will return
    ///    D3DERR_INVALIDCALL if either: <ul> <li>pRenderTarget = <b>NULL</b> and RenderTargetIndex = 0</li>
    ///    <li>pRenderTarget is != <b>NULL</b> and the render target is invalid.</li> </ul>
    ///    
    HRESULT SetRenderTarget(uint RenderTargetIndex, IDirect3DSurface9 pRenderTarget);
    ///Retrieves a render-target surface.
    ///Params:
    ///    RenderTargetIndex = Type: <b>DWORD</b> Index of the render target. See Remarks.
    ///    ppRenderTarget = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                     returned render-target surface for this device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL if one of the arguments is invalid, or D3DERR_NOTFOUND if there's no render
    ///    target available for the given index.
    ///    
    HRESULT GetRenderTarget(uint RenderTargetIndex, IDirect3DSurface9* ppRenderTarget);
    ///Sets the depth stencil surface.
    ///Params:
    ///    pNewZStencil = Type: <b>IDirect3DSurface9*</b> Address of a pointer to an IDirect3DSurface9 interface representing the depth
    ///                   stencil surface. Setting this to <b>NULL</b> disables the depth stencil operation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If pZStencilSurface is other than
    ///    <b>NULL</b>, the return value is D3DERR_INVALIDCALL when the stencil surface is invalid.
    ///    
    HRESULT SetDepthStencilSurface(IDirect3DSurface9 pNewZStencil);
    ///Gets the depth-stencil surface owned by the Direct3DDevice object.
    ///Params:
    ///    ppZStencilSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                        returned depth-stencil surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK.If the device doesn't have a depth
    ///    stencil buffer associated with it, the return value will be D3DERR_NOTFOUND. Otherwise, if the method fails,
    ///    the return value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDepthStencilSurface(IDirect3DSurface9* ppZStencilSurface);
    ///Begins a scene.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. The method will fail with
    ///    D3DERR_INVALIDCALL if <b>IDirect3DDevice9::BeginScene</b> is called while already in a
    ///    <b>IDirect3DDevice9::BeginScene</b>/IDirect3DDevice9::EndScene pair. This happens only when
    ///    <b>IDirect3DDevice9::BeginScene</b> is called twice without first calling <b>IDirect3DDevice9::EndScene</b>.
    ///    
    HRESULT BeginScene();
    ///Ends a scene that was begun by calling IDirect3DDevice9::BeginScene.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. The method will fail with
    ///    D3DERR_INVALIDCALL if IDirect3DDevice9::BeginScene is called while already in a
    ///    <b>IDirect3DDevice9::BeginScene</b>/<b>IDirect3DDevice9::EndScene</b> pair. This happens only when
    ///    <b>IDirect3DDevice9::BeginScene</b> is called twice without first calling <b>IDirect3DDevice9::EndScene</b>.
    ///    
    HRESULT EndScene();
    ///Clears one or more surfaces such as a render target, multiple render targets, a stencil buffer, and a depth
    ///buffer.
    ///Params:
    ///    Count = Type: <b>DWORD</b> Number of rectangles in the array at pRects. Must be set to 0 if pRects is <b>NULL</b>.
    ///            May not be 0 if pRects is a valid pointer.
    ///    pRects = Type: <b>const D3DRECT*</b> Pointer to an array of D3DRECT structures that describe the rectangles to clear.
    ///             Set a rectangle to the dimensions of the rendering target to clear the entire surface. Each rectangle uses
    ///             screen coordinates that correspond to points on the render target. Coordinates are clipped to the bounds of
    ///             the viewport rectangle. To indicate that the entire viewport rectangle is to be cleared, set this parameter
    ///             to <b>NULL</b> and Count to 0.
    ///    Flags = Type: <b>DWORD</b> Combination of one or more D3DCLEAR flags that specify the surface(s) that will be
    ///            cleared.
    ///    Color = Type: <b>D3DCOLOR</b> Clear a render target to this ARGB color.
    ///    Z = Type: <b>float</b> Clear the depth buffer to this new z value which ranges from 0 to 1. See remarks.
    ///    Stencil = Type: <b>DWORD</b> Clear the stencil buffer to this new value which ranges from 0 to 2ⁿ-1 (n is the bit
    ///              depth of the stencil buffer). See remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT Clear(uint Count, const(D3DRECT)* pRects, uint Flags, uint Color, float Z, uint Stencil);
    ///Sets a single device transformation-related state.
    ///Params:
    ///    State = Type: <b>D3DTRANSFORMSTATETYPE</b> Device-state variable that is being modified. This parameter can be any
    ///            member of the D3DTRANSFORMSTATETYPE enumerated type, or the D3DTS_WORLDMATRIX macro.
    ///    pMatrix = Type: <b>const D3DMATRIX*</b> Pointer to a D3DMATRIX structure that modifies the current transformation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    one of the arguments is invalid.
    ///    
    HRESULT SetTransform(D3DTRANSFORMSTATETYPE State, const(D3DMATRIX)* pMatrix);
    ///Retrieves a matrix describing a transformation state.
    ///Params:
    ///    State = Type: <b>D3DTRANSFORMSTATETYPE</b> Device state variable that is being modified. This parameter can be any
    ///            member of the D3DTRANSFORMSTATETYPE enumerated type, or the D3DTS_WORLDMATRIX macro.
    ///    pMatrix = Type: <b>D3DMATRIX*</b> Pointer to a D3DMATRIX structure, describing the returned transformation state.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL if one of the
    ///    arguments is invalid.
    ///    
    HRESULT GetTransform(D3DTRANSFORMSTATETYPE State, D3DMATRIX* pMatrix);
    ///Multiplies a device's world, view, or projection matrices by a specified matrix.
    ///Params:
    ///    arg1 = Type: <b>D3DTRANSFORMSTATETYPE</b> Member of the D3DTRANSFORMSTATETYPE enumerated type, or the
    ///           D3DTS_WORLDMATRIX macro that identifies which device matrix is to be modified. The most common setting,
    ///           <b>D3DTS_WORLDMATRIX</b>(0), modifies the world matrix, but you can specify that the method modify the view
    ///           or projection matrices, if needed.
    ///    arg2 = Type: <b>const D3DMATRIX*</b> Pointer to a D3DMATRIX structure that modifies the current transformation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL if one of the
    ///    arguments is invalid.
    ///    
    HRESULT MultiplyTransform(D3DTRANSFORMSTATETYPE param0, const(D3DMATRIX)* param1);
    ///Sets the viewport parameters for the device.
    ///Params:
    ///    pViewport = Type: <b>const D3DVIEWPORT9*</b> Pointer to a D3DVIEWPORT9 structure, specifying the viewport parameters to
    ///                set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, it will return
    ///    D3DERR_INVALIDCALL. This will happen if pViewport is invalid, or if pViewport describes a region that cannot
    ///    exist within the render target surface.
    ///    
    HRESULT SetViewport(const(D3DVIEWPORT9)* pViewport);
    ///Retrieves the viewport parameters currently set for the device.
    ///Params:
    ///    pViewport = Type: <b>D3DVIEWPORT9*</b> Pointer to a D3DVIEWPORT9 structure, representing the returned viewport
    ///                parameters.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the pViewport parameter is invalid.
    ///    
    HRESULT GetViewport(D3DVIEWPORT9* pViewport);
    ///Sets the material properties for the device.
    ///Params:
    ///    pMaterial = Type: <b>const D3DMATERIAL9*</b> Pointer to a D3DMATERIAL9 structure, describing the material properties to
    ///                set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL if the pMaterial
    ///    parameter is invalid.
    ///    
    HRESULT SetMaterial(const(D3DMATERIAL9)* pMaterial);
    ///Retrieves the current material properties for the device.
    ///Params:
    ///    pMaterial = Type: <b>D3DMATERIAL9*</b> Pointer to a D3DMATERIAL9 structure to fill with the currently set material
    ///                properties.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL if the pMaterial
    ///    parameter is invalid.
    ///    
    HRESULT GetMaterial(D3DMATERIAL9* pMaterial);
    ///Assigns a set of lighting properties for this device.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Zero-based index of the set of lighting properties to set. If a set of lighting properties
    ///            exists at this index, it is overwritten by the new properties specified in pLight.
    ///    arg2 = Type: <b>const D3DLIGHT9*</b> Pointer to a D3DLIGHT9 structure, containing the lighting parameters to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetLight(uint Index, const(D3DLIGHT9)* param1);
    ///Retrieves a set of lighting properties that this device uses.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Zero-based index of the lighting property set to retrieve. This method will fail if a
    ///            lighting property has not been set for this index by calling the IDirect3DDevice9::SetLight method.
    ///    arg2 = Type: <b>D3DLight9*</b> Pointer to a D3DLIGHT9 structure that is filled with the retrieved lighting-parameter
    ///           set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetLight(uint Index, D3DLIGHT9* param1);
    ///Enables or disables a set of lighting parameters within a device.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Zero-based index of the set of lighting parameters that are the target of this method.
    ///    Enable = Type: <b>BOOL</b> Value that indicates if the set of lighting parameters are being enabled or disabled. Set
    ///             this parameter to <b>TRUE</b> to enable lighting with the parameters at the specified index, or <b>FALSE</b>
    ///             to disable it.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT LightEnable(uint Index, BOOL Enable);
    ///Retrieves the activity status - enabled or disabled - for a set of lighting parameters within a device.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Zero-based index of the set of lighting parameters that are the target of this method.
    ///    pEnable = Type: <b>BOOL*</b> Pointer to a variable to fill with the status of the specified lighting parameters. After
    ///              the call, a nonzero value at this address indicates that the specified lighting parameters are enabled; a
    ///              value of 0 indicates that they are disabled.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetLightEnable(uint Index, BOOL* pEnable);
    ///Sets the coefficients of a user-defined clipping plane for the device.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Index of the clipping plane for which the plane equation coefficients are to be set.
    ///    pPlane = Type: <b>const float*</b> Pointer to an address of a four-element array of values that represent the clipping
    ///             plane coefficients to be set, in the form of the general plane equation. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value is D3DERR_INVALIDCALL. This error indicates that the value in Index exceeds the maximum clipping plane
    ///    index supported by the device or that the array at pPlane is not large enough to contain four floating-point
    ///    values.
    ///    
    HRESULT SetClipPlane(uint Index, const(float)* pPlane);
    ///Retrieves the coefficients of a user-defined clipping plane for the device.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Index of the clipping plane for which the plane equation coefficients are retrieved.
    ///    pPlane = Type: <b>float*</b> Pointer to a four-element array of values that represent the coefficients of the clipping
    ///             plane in the form of the general plane equation. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value is D3DERR_INVALIDCALL. This error indicates that the value in Index exceeds the maximum clipping plane
    ///    index supported by the device, or that the array at pPlane is not large enough to contain four floating-point
    ///    values.
    ///    
    HRESULT GetClipPlane(uint Index, float* pPlane);
    ///Sets a single device render-state parameter.
    ///Params:
    ///    State = Type: <b>D3DRENDERSTATETYPE</b> Device state variable that is being modified. This parameter can be any
    ///            member of the D3DRENDERSTATETYPE enumerated type.
    ///    Value = Type: <b>DWORD</b> New value for the device render state to be set. The meaning of this parameter is
    ///            dependent on the value specified for <i>State</i>. For example, if <i>State</i> were D3DRS_SHADEMODE, the
    ///            second parameter would be one member of the D3DSHADEMODE enumerated type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    one of the arguments is invalid.
    ///    
    HRESULT SetRenderState(D3DRENDERSTATETYPE State, uint Value);
    ///Retrieves a render-state value for a device.
    ///Params:
    ///    State = Type: <b>D3DRENDERSTATETYPE</b> Device state variable that is being queried. This parameter can be any member
    ///            of the D3DRENDERSTATETYPE enumerated type.
    ///    pValue = Type: <b>DWORD*</b> Pointer to a variable that receives the value of the queried render state variable when
    ///             the method returns.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL if one of the
    ///    arguments is invalid.
    ///    
    HRESULT GetRenderState(D3DRENDERSTATETYPE State, uint* pValue);
    ///Creates a new state block that contains the values for all device states, vertex-related states, or pixel-related
    ///states.
    ///Params:
    ///    Type = Type: <b>D3DSTATEBLOCKTYPE</b> Type of state data that the method should capture. This parameter can be set
    ///           to a value defined in the D3DSTATEBLOCKTYPE enumerated type.
    ///    ppSB = Type: <b>IDirect3DStateBlock9**</b> Pointer to a state block interface. See IDirect3DStateBlock9.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateStateBlock(D3DSTATEBLOCKTYPE Type, IDirect3DStateBlock9* ppSB);
    ///Signals Direct3D to begin recording a device-state block.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, E_OUTOFMEMORY.
    ///    
    HRESULT BeginStateBlock();
    ///Signals Direct3D to stop recording a device-state block and retrieve a pointer to the state block interface.
    ///Params:
    ///    ppSB = Type: <b>IDirect3DStateBlock9**</b> Pointer to a state block interface. See IDirect3DStateBlock9.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT EndStateBlock(IDirect3DStateBlock9* ppSB);
    ///Sets the clip status.
    ///Params:
    ///    pClipStatus = Type: <b>const D3DCLIPSTATUS9*</b> Pointer to a D3DCLIPSTATUS9 structure, describing the clip status settings
    ///                  to be set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If one of the arguments is invalid,
    ///    the return value is D3DERR_INVALIDCALL.
    ///    
    HRESULT SetClipStatus(const(D3DCLIPSTATUS9)* pClipStatus);
    ///Retrieves the clip status.
    ///Params:
    ///    pClipStatus = Type: <b>D3DCLIPSTATUS9*</b> Pointer to a D3DCLIPSTATUS9 structure that describes the clip status.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetClipStatus(D3DCLIPSTATUS9* pClipStatus);
    ///Retrieves a texture assigned to a stage for a device.
    ///Params:
    ///    Stage = Type: <b>DWORD</b> Stage identifier of the texture to retrieve. Stage identifiers are zero-based.
    ///    ppTexture = Type: <b>IDirect3DBaseTexture9**</b> Address of a pointer to an IDirect3DBaseTexture9 interface, representing
    ///                the returned texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetTexture(uint Stage, IDirect3DBaseTexture9* ppTexture);
    ///Assigns a texture to a stage for a device.
    ///Params:
    ///    Stage = Type: <b>DWORD</b> Zero based sampler number. Textures are bound to samplers; samplers define sampling state
    ///            such as the filtering mode and the address wrapping mode. Textures are referenced differently by the
    ///            programmable and the fixed function pipeline: <ul> <li>Programmable shaders reference textures using the
    ///            sampler number. The number of samplers available to a programmable shader is dependent on the shader version.
    ///            For vertex shaders, see Sampler (Direct3D 9 asm-vs). For pixel shaders see Sampler (Direct3D 9 asm-ps).</li>
    ///            <li>The fixed function pipeline on the other hand, references textures by texture stage number. The maximum
    ///            number of samplers is determined from two caps: MaxSimultaneousTextures and MaxTextureBlendStages of the
    ///            D3DCAPS9 structure.</li> </ul> There are two other special cases for stage/sampler numbers. <ul> <li>A
    ///            special number called D3DDMAPSAMPLER is used for Displacement Mapping (Direct3D 9).</li> <li>A programmable
    ///            vertex shader uses a special number defined by a D3DVERTEXTEXTURESAMPLER when accessing Vertex Textures in
    ///            vs_3_0 (DirectX HLSL).</li> </ul>
    ///    pTexture = Type: <b>IDirect3DBaseTexture9*</b> Pointer to an IDirect3DBaseTexture9 interface, representing the texture
    ///               being set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetTexture(uint Stage, IDirect3DBaseTexture9 pTexture);
    ///Retrieves a state value for an assigned texture.
    ///Params:
    ///    Stage = Type: <b>DWORD</b> Stage identifier of the texture for which the state is retrieved. Stage identifiers are
    ///            zero-based. Devices can have up to eight set textures, so the maximum value allowed for Stage is 7.
    ///    Type = Type: <b>D3DTEXTURESTAGESTATETYPE</b> Texture state to retrieve. This parameter can be any member of the
    ///           D3DTEXTURESTAGESTATETYPE enumerated type.
    ///    pValue = Type: <b>DWORD*</b> Pointer a variable to fill with the retrieved state value. The meaning of the retrieved
    ///             value is determined by the Type parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetTextureStageState(uint Stage, D3DTEXTURESTAGESTATETYPE Type, uint* pValue);
    ///Sets the state value for the currently assigned texture.
    ///Params:
    ///    Stage = Type: <b>DWORD</b> Stage identifier of the texture for which the state value is set. Stage identifiers are
    ///            zero-based. Devices can have up to eight set textures, so the maximum value allowed for Stage is 7.
    ///    Type = Type: <b>D3DTEXTURESTAGESTATETYPE</b> Texture state to set. This parameter can be any member of the
    ///           D3DTEXTURESTAGESTATETYPE enumerated type.
    ///    Value = Type: <b>DWORD</b> State value to set. The meaning of this value is determined by the Type parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetTextureStageState(uint Stage, D3DTEXTURESTAGESTATETYPE Type, uint Value);
    ///Gets the sampler state value.
    ///Params:
    ///    Sampler = Type: <b>DWORD</b> The sampler stage index.
    ///    Type = Type: <b>D3DSAMPLERSTATETYPE</b> This parameter can be any member of the D3DSAMPLERSTATETYPE enumerated type.
    ///    pValue = Type: <b>DWORD*</b> State value to get. The meaning of this value is determined by the Type parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetSamplerState(uint Sampler, D3DSAMPLERSTATETYPE Type, uint* pValue);
    ///Sets the sampler state value.
    ///Params:
    ///    Sampler = Type: <b>DWORD</b> The sampler stage index. For more info about sampler stage, see Sampling Stage Registers
    ///              in vs_3_0 (DirectX HLSL).
    ///    Type = Type: <b>D3DSAMPLERSTATETYPE</b> This parameter can be any member of the D3DSAMPLERSTATETYPE enumerated type.
    ///    Value = Type: <b>DWORD</b> State value to set. The meaning of this value is determined by the Type parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetSamplerState(uint Sampler, D3DSAMPLERSTATETYPE Type, uint Value);
    ///Reports the device's ability to render the current texture-blending operations and arguments in a single pass.
    ///Params:
    ///    pNumPasses = Type: <b>DWORD*</b> Pointer to a DWORD value to fill with the number of rendering passes needed to complete
    ///                 the desired effect through multipass rendering.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_CONFLICTINGRENDERSTATE, D3DERR_CONFLICTINGTEXTUREFILTER,
    ///    D3DERR_DEVICELOST, D3DERR_DRIVERINTERNALERROR, D3DERR_TOOMANYOPERATIONS, D3DERR_UNSUPPORTEDALPHAARG,
    ///    D3DERR_UNSUPPORTEDALPHAOPERATION, D3DERR_UNSUPPORTEDCOLORARG, D3DERR_UNSUPPORTEDCOLOROPERATION,
    ///    D3DERR_UNSUPPORTEDFACTORVALUE, D3DERR_UNSUPPORTEDTEXTUREFILTER, D3DERR_WRONGTEXTUREFORMAT,.
    ///    
    HRESULT ValidateDevice(uint* pNumPasses);
    ///Sets palette entries.
    ///Params:
    ///    PaletteNumber = Type: <b>UINT</b> An ordinal value identifying the particular palette upon which the operation is to be
    ///                    performed.
    ///    pEntries = Type: <b>const PALETTEENTRY*</b> Pointer to a PALETTEENTRY structure, representing the palette entries to
    ///               set. The number of <b>PALETTEENTRY</b> structures pointed to by pEntries is assumed to be 256. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetPaletteEntries(uint PaletteNumber, const(PALETTEENTRY)* pEntries);
    ///Retrieves palette entries.
    ///Params:
    ///    PaletteNumber = Type: <b>UINT</b> An ordinal value identifying the particular palette to retrieve.
    ///    pEntries = Type: <b>PALETTEENTRY*</b> Pointer to a PALETTEENTRY structure, representing the returned palette entries.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPaletteEntries(uint PaletteNumber, PALETTEENTRY* pEntries);
    ///Sets the current texture palette.
    ///Params:
    ///    PaletteNumber = Type: <b>UINT</b> Value that specifies the texture palette to set as the current texture palette.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetCurrentTexturePalette(uint PaletteNumber);
    ///Retrieves the current texture palette.
    ///Params:
    ///    PaletteNumber = Type: <b>UINT*</b> Pointer to a returned value that identifies the current texture palette.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetCurrentTexturePalette(uint* PaletteNumber);
    ///Sets the scissor rectangle.
    ///Params:
    ///    pRect = Type: <b>const RECT*</b> Pointer to a RECT structure that defines the rendering area within the render target
    ///            if scissor test is enabled. This parameter may not be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetScissorRect(const(RECT)* pRect);
    ///Gets the scissor rectangle.
    ///Params:
    ///    pRect = Type: <b>RECT*</b> Returns a pointer to a RECT structure that defines the rendering area within the render
    ///            target if scissor test is enabled.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetScissorRect(RECT* pRect);
    ///Use this method to switch between software and hardware vertex processing.
    ///Params:
    ///    bSoftware = Type: <b>BOOL</b> <b>TRUE</b> to specify software vertex processing; <b>FALSE</b> to specify hardware vertex
    ///                processing.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetSoftwareVertexProcessing(BOOL bSoftware);
    ///Gets the vertex processing (hardware or software) mode.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns <b>TRUE</b> if software vertex processing is set. Otherwise, it returns
    ///    <b>FALSE</b>.
    ///    
    BOOL    GetSoftwareVertexProcessing();
    ///Enable or disable N-patches.
    ///Params:
    ///    nSegments = Type: <b>float</b> Specifies the number of subdivision segments. If the number of segments is less than 1.0,
    ///                N-patches are disabled. The default value is 0.0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK.
    ///    
    HRESULT SetNPatchMode(float nSegments);
    ///Gets the N-patch mode segments.
    ///Returns:
    ///    Type: <b>FLOAT</b> Specifies the number of subdivision segments. If the number of segments is less than 1.0,
    ///    N-patches are disabled. The default value is 0.0.
    ///    
    float   GetNPatchMode();
    ///Renders a sequence of nonindexed, geometric primitives of the specified type from the current set of data input
    ///streams.
    ///Params:
    ///    PrimitiveType = Type: <b>D3DPRIMITIVETYPE</b> Member of the D3DPRIMITIVETYPE enumerated type, describing the type of
    ///                    primitive to render.
    ///    StartVertex = Type: <b>UINT</b> Index of the first vertex to load. Beginning at StartVertex the correct number of vertices
    ///                  will be read out of the vertex buffer.
    ///    PrimitiveCount = Type: <b>UINT</b> Number of primitives to render. The maximum number of primitives allowed is determined by
    ///                     checking the MaxPrimitiveCount member of the D3DCAPS9 structure. PrimitiveCount is the number of primitives
    ///                     as determined by the primitive type. If it is a line list, each primitive has two vertices. If it is a
    ///                     triangle list, each primitive has three vertices.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawPrimitive(D3DPRIMITIVETYPE PrimitiveType, uint StartVertex, uint PrimitiveCount);
    ///Based on indexing, renders the specified geometric primitive into an array of vertices.
    ///Params:
    ///    arg1 = Type: <b>D3DPRIMITIVETYPE</b> Member of the D3DPRIMITIVETYPE enumerated type, describing the type of
    ///           primitive to render. D3DPT_POINTLIST is not supported with this method. See Remarks.
    ///    BaseVertexIndex = Type: <b>INT</b> Offset from the start of the vertex buffer to the first vertex. See Scenario 4.
    ///    MinVertexIndex = Type: <b>UINT</b> Minimum vertex index for vertices used during this call. This is a zero based index
    ///                     relative to BaseVertexIndex.
    ///    NumVertices = Type: <b>UINT</b> Number of vertices used during this call. The first vertex is located at index:
    ///                  BaseVertexIndex + MinIndex.
    ///    startIndex = Type: <b>UINT</b> Index of the first index to use when accesssing the vertex buffer. Beginning at StartIndex
    ///                 to index vertices from the vertex buffer.
    ///    primCount = Type: <b>UINT</b> Number of primitives to render. The number of vertices used is a function of the primitive
    ///                count and the primitive type. The maximum number of primitives allowed is determined by checking the
    ///                MaxPrimitiveCount member of the D3DCAPS9 structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawIndexedPrimitive(D3DPRIMITIVETYPE param0, int BaseVertexIndex, uint MinVertexIndex, 
                                 uint NumVertices, uint startIndex, uint primCount);
    ///Renders data specified by a user memory pointer as a sequence of geometric primitives of the specified type.
    ///Params:
    ///    PrimitiveType = Type: <b>D3DPRIMITIVETYPE</b> Member of the D3DPRIMITIVETYPE enumerated type, describing the type of
    ///                    primitive to render.
    ///    PrimitiveCount = Type: <b>UINT</b> Number of primitives to render. The maximum number of primitives allowed is determined by
    ///                     checking the MaxPrimitiveCount member of the D3DCAPS9 structure.
    ///    pVertexStreamZeroData = Type: <b>const void*</b> User memory pointer to the vertex data.
    ///    VertexStreamZeroStride = Type: <b>UINT</b> The number of bytes of data for each vertex. This value may not be 0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawPrimitiveUP(D3DPRIMITIVETYPE PrimitiveType, uint PrimitiveCount, 
                            const(void)* pVertexStreamZeroData, uint VertexStreamZeroStride);
    ///Renders the specified geometric primitive with data specified by a user memory pointer.
    ///Params:
    ///    PrimitiveType = Type: <b>D3DPRIMITIVETYPE</b> Member of the D3DPRIMITIVETYPE enumerated type, describing the type of
    ///                    primitive to render.
    ///    MinVertexIndex = Type: <b>UINT</b> Minimum vertex index. This is a zero-based index.
    ///    NumVertices = Type: <b>UINT</b> Number of vertices used during this call. The first vertex is located at index:
    ///                  MinVertexIndex.
    ///    PrimitiveCount = Type: <b>UINT</b> Number of primitives to render. The maximum number of primitives allowed is determined by
    ///                     checking the MaxPrimitiveCount member of the D3DCAPS9 structure (the number of indices is a function of the
    ///                     primitive count and the primitive type).
    ///    pIndexData = Type: <b>const void*</b> User memory pointer to the index data.
    ///    IndexDataFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the index data. The
    ///                      valid settings are either: <ul> <li> D3DFMT_INDEX16 </li> <li> D3DFMT_INDEX32 </li> </ul>
    ///    pVertexStreamZeroData = Type: <b>const void*</b> User memory pointer to the vertex data. The vertex data must be in stream 0.
    ///    VertexStreamZeroStride = Type: <b>UINT</b> The number of bytes of data for each vertex. This value may not be 0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawIndexedPrimitiveUP(D3DPRIMITIVETYPE PrimitiveType, uint MinVertexIndex, uint NumVertices, 
                                   uint PrimitiveCount, const(void)* pIndexData, D3DFORMAT IndexDataFormat, 
                                   const(void)* pVertexStreamZeroData, uint VertexStreamZeroStride);
    ///Applies the vertex processing defined by the vertex shader to the set of input data streams, generating a single
    ///stream of interleaved vertex data to the destination vertex buffer.
    ///Params:
    ///    SrcStartIndex = Type: <b>UINT</b> Index of first vertex to load.
    ///    DestIndex = Type: <b>UINT</b> Index of first vertex in the destination vertex buffer into which the results are placed.
    ///    VertexCount = Type: <b>UINT</b> Number of vertices to process.
    ///    pDestBuffer = Type: <b>IDirect3DVertexBuffer9*</b> Pointer to an IDirect3DVertexBuffer9 interface, the destination vertex
    ///                  buffer representing the stream of interleaved vertex data.
    ///    pVertexDecl = Type: <b>IDirect3DVertexDeclaration9*</b> Pointer to an IDirect3DVertexDeclaration9 interface that represents
    ///                  the output vertex data declaration. When vertex shader 3.0 or above is set as the current vertex shader, the
    ///                  output vertex declaration must be present.
    ///    Flags = Type: <b>DWORD</b> Processing options. Set this parameter to 0 for default processing. Set to
    ///            D3DPV_DONOTCOPYDATA to prevent the system from copying vertex data not affected by the vertex operation into
    ///            the destination buffer. The D3DPV_DONOTCOPYDATA value may be combined with one or more D3DLOCK values
    ///            appropriate for the destination buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT ProcessVertices(uint SrcStartIndex, uint DestIndex, uint VertexCount, 
                            IDirect3DVertexBuffer9 pDestBuffer, IDirect3DVertexDeclaration9 pVertexDecl, uint Flags);
    ///Create a vertex shader declaration from the device and the vertex elements.
    ///Params:
    ///    pVertexElements = Type: <b>const D3DVERTEXELEMENT9*</b> An array of D3DVERTEXELEMENT9 vertex elements.
    ///    ppDecl = Type: <b>IDirect3DVertexDeclaration9**</b> Pointer to an IDirect3DVertexDeclaration9 pointer that returns the
    ///             created vertex shader declaration.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT CreateVertexDeclaration(const(D3DVERTEXELEMENT9)* pVertexElements, IDirect3DVertexDeclaration9* ppDecl);
    ///Sets a Vertex Declaration (Direct3D 9).
    ///Params:
    ///    pDecl = Type: <b>IDirect3DVertexDeclaration9*</b> Pointer to an IDirect3DVertexDeclaration9 object, which contains
    ///            the vertex declaration.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. The return value can be
    ///    D3DERR_INVALIDCALL.
    ///    
    HRESULT SetVertexDeclaration(IDirect3DVertexDeclaration9 pDecl);
    ///Gets a vertex shader declaration.
    ///Params:
    ///    ppDecl = Type: <b>IDirect3DVertexDeclaration9**</b> Pointer to an IDirect3DVertexDeclaration9 object that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. The return value can be
    ///    D3DERR_INVALIDCALL.
    ///    
    HRESULT GetVertexDeclaration(IDirect3DVertexDeclaration9* ppDecl);
    ///Sets the current vertex stream declaration.
    ///Params:
    ///    FVF = Type: <b>DWORD</b> DWORD containing the fixed function vertex type. For more information, see D3DFVF.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT SetFVF(uint FVF);
    ///Gets the fixed vertex function declaration.
    ///Params:
    ///    pFVF = Type: <b>DWORD*</b> A DWORD pointer to the fixed function vertex type. For more information, see D3DFVF.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetFVF(uint* pFVF);
    ///Creates a vertex shader.
    ///Params:
    ///    pFunction = Type: <b>const DWORD*</b> Pointer to an array of tokens that represents the vertex shader, including any
    ///                embedded debug and symbol table information. <ul> <li>Use a function such as D3DXCompileShader to create the
    ///                array from a HLSL shader.</li> <li>Use a function like D3DXAssembleShader to create the token array from an
    ///                assembly language shader.</li> <li>Use a function like ID3DXEffectCompiler::CompileShader to create the array
    ///                from an effect.</li> </ul>
    ///    ppShader = Type: <b>IDirect3DVertexShader9**</b> Pointer to the returned vertex shader interface (see
    ///               IDirect3DVertexShader9).
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateVertexShader(const(uint)* pFunction, IDirect3DVertexShader9* ppShader);
    ///Sets the vertex shader.
    ///Params:
    ///    pShader = Type: <b>IDirect3DVertexShader9*</b> Vertex shader interface. For more information, see
    ///              IDirect3DVertexShader9.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetVertexShader(IDirect3DVertexShader9 pShader);
    ///Retrieves the currently set vertex shader.
    ///Params:
    ///    ppShader = Type: <b>IDirect3DVertexShader9**</b> Pointer to a vertex shader interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If ppShader is invalid,
    ///    D3DERR_INVALIDCALL is returned.
    ///    
    HRESULT GetVertexShader(IDirect3DVertexShader9* ppShader);
    ///Sets a floating-point vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const float*</b> Pointer to an array of constants.
    ///    Vector4fCount = Type: <b>UINT</b> Number of four float vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetVertexShaderConstantF(uint StartRegister, const(float)* pConstantData, uint Vector4fCount);
    ///Gets a floating-point vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>float*</b> Pointer to an array of constants.
    ///    Vector4fCount = Type: <b>UINT</b> Number of four float vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetVertexShaderConstantF(uint StartRegister, float* pConstantData, uint Vector4fCount);
    ///Sets an integer vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const int*</b> Pointer to an array of constants.
    ///    Vector4iCount = Type: <b>UINT</b> Number of four integer vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetVertexShaderConstantI(uint StartRegister, const(int)* pConstantData, uint Vector4iCount);
    ///Gets an integer vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>int*</b> Pointer to an array of constants.
    ///    Vector4iCount = Type: <b>UINT</b> Number of four integer vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetVertexShaderConstantI(uint StartRegister, int* pConstantData, uint Vector4iCount);
    ///Sets a Boolean vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const BOOL*</b> Pointer to an array of constants.
    ///    BoolCount = Type: <b>UINT</b> Number of boolean values in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetVertexShaderConstantB(uint StartRegister, const(BOOL)* pConstantData, uint BoolCount);
    ///Gets a Boolean vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>BOOL*</b> Pointer to an array of constants.
    ///    BoolCount = Type: <b>UINT</b> Number of Boolean values in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetVertexShaderConstantB(uint StartRegister, BOOL* pConstantData, uint BoolCount);
    ///Binds a vertex buffer to a device data stream. For more information, see Setting the Stream Source (Direct3D 9).
    ///Params:
    ///    StreamNumber = Type: <b>UINT</b> Specifies the data stream, in the range from 0 to the maximum number of streams -1.
    ///    pStreamData = Type: <b>IDirect3DVertexBuffer9*</b> Pointer to an IDirect3DVertexBuffer9 interface, representing the vertex
    ///                  buffer to bind to the specified data stream.
    ///    OffsetInBytes = Type: <b>UINT</b> Offset from the beginning of the stream to the beginning of the vertex data, in bytes. To
    ///                    find out if the device supports stream offsets, see the D3DDEVCAPS2_STREAMOFFSET constant in D3DDEVCAPS2.
    ///    Stride = Type: <b>UINT</b> Stride of the component, in bytes. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetStreamSource(uint StreamNumber, IDirect3DVertexBuffer9 pStreamData, uint OffsetInBytes, uint Stride);
    ///Retrieves a vertex buffer bound to the specified data stream.
    ///Params:
    ///    StreamNumber = Type: [in] <b>UINT</b> Specifies the data stream, in the range from 0 to the maximum number of streams minus
    ///                   one.
    ///    ppStreamData = Type: [in, out] <b>IDirect3DVertexBuffer9**</b> Address of a pointer to an IDirect3DVertexBuffer9 interface,
    ///                   representing the returned vertex buffer bound to the specified data stream.
    ///    OffsetInBytes = Type: [out] <b>UINT*</b> Pointer containing the offset from the beginning of the stream to the beginning of
    ///                    the vertex data. The offset is measured in bytes. See Remarks.
    ///    pStride = Type: [out] <b>UINT*</b> Pointer to a returned stride of the component, in bytes. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetStreamSource(uint StreamNumber, IDirect3DVertexBuffer9* ppStreamData, uint* pOffsetInBytes, 
                            uint* pStride);
    ///Sets the stream source frequency divider value. This may be used to draw several instances of geometry.
    ///Params:
    ///    StreamNumber = Type: [in] <b>UINT</b> Stream source number.
    ///    Divider = Type: [in] <b>UINT</b> This parameter may have two different values. See remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetStreamSourceFreq(uint StreamNumber, uint Setting);
    ///Gets the stream source frequency divider value.
    ///Params:
    ///    StreamNumber = Type: [in] <b>UINT</b> Stream source number.
    ///    Divider = Type: [out] <b>UINT*</b> Returns the frequency divider value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetStreamSourceFreq(uint StreamNumber, uint* pSetting);
    ///Sets index data.
    ///Params:
    ///    pIndexData = Type: <b>IDirect3DIndexBuffer9*</b> Pointer to an IDirect3DIndexBuffer9 interface, representing the index
    ///                 data to be set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT SetIndices(IDirect3DIndexBuffer9 pIndexData);
    ///Retrieves index data.
    ///Params:
    ///    ppIndexData = Type: [out] <b>IDirect3DIndexBuffer9**</b> Address of a pointer to an IDirect3DIndexBuffer9 interface,
    ///                  representing the returned index data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetIndices(IDirect3DIndexBuffer9* ppIndexData);
    ///Creates a pixel shader.
    ///Params:
    ///    pFunction = Type: <b>const DWORD*</b> Pointer to the pixel shader function token array, specifying the blending
    ///                operations. This value cannot be <b>NULL</b>.
    ///    ppShader = Type: <b>IDirect3DPixelShader9**</b> Pointer to the returned pixel shader interface. See
    ///               IDirect3DPixelShader9.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreatePixelShader(const(uint)* pFunction, IDirect3DPixelShader9* ppShader);
    ///Sets the current pixel shader to a previously created pixel shader.
    ///Params:
    ///    pShader = Type: <b>IDirect3DPixelShader9*</b> Pixel shader interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetPixelShader(IDirect3DPixelShader9 pShader);
    ///Retrieves the currently set pixel shader.
    ///Params:
    ///    ppShader = Type: <b>IDirect3DPixelShader9**</b> Pointer to a pixel shader interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPixelShader(IDirect3DPixelShader9* ppShader);
    ///Sets a floating-point shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const float*</b> Pointer to an array of constants.
    ///    Vector4fCount = Type: <b>UINT</b> Number of four float vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetPixelShaderConstantF(uint StartRegister, const(float)* pConstantData, uint Vector4fCount);
    ///Gets a floating-point shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>float*</b> Pointer to an array of constants.
    ///    Vector4fCount = Type: <b>UINT</b> Number of four float vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPixelShaderConstantF(uint StartRegister, float* pConstantData, uint Vector4fCount);
    ///Sets an integer shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const int*</b> Pointer to an array of constants.
    ///    Vector4iCount = Type: <b>UINT</b> Number of four integer vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetPixelShaderConstantI(uint StartRegister, const(int)* pConstantData, uint Vector4iCount);
    ///Gets an integer shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>int*</b> Pointer to an array of constants.
    ///    Vector4iCount = Type: <b>UINT</b> Number of four integer vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPixelShaderConstantI(uint StartRegister, int* pConstantData, uint Vector4iCount);
    ///Sets a Boolean shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const BOOL*</b> Pointer to an array of constants.
    ///    BoolCount = Type: <b>UINT</b> Number of boolean values in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetPixelShaderConstantB(uint StartRegister, const(BOOL)* pConstantData, uint BoolCount);
    ///Gets a Boolean shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>BOOL*</b> Pointer to an array of constants.
    ///    BoolCount = Type: <b>UINT</b> Number of Boolean values in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPixelShaderConstantB(uint StartRegister, BOOL* pConstantData, uint BoolCount);
    ///Draws a rectangular patch using the currently set streams.
    ///Params:
    ///    Handle = Type: <b>UINT</b> Handle to the rectangular patch to draw.
    ///    pNumSegs = Type: <b>const float*</b> Pointer to an array of four floating-point values that identify the number of
    ///               segments each edge of the rectangle patch should be divided into when tessellated. See D3DRECTPATCH_INFO.
    ///    pRectPatchInfo = Type: <b>const D3DRECTPATCH_INFO*</b> Pointer to a D3DRECTPATCH_INFO structure, describing the rectangular
    ///                     patch to draw.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawRectPatch(uint Handle, const(float)* pNumSegs, const(D3DRECTPATCH_INFO)* pRectPatchInfo);
    ///Draws a triangular patch using the currently set streams.
    ///Params:
    ///    Handle = Type: <b>UINT</b> Handle to the triangular patch to draw.
    ///    pNumSegs = Type: <b>const float*</b> Pointer to an array of three floating-point values that identify the number of
    ///               segments each edge of the triangle patch should be divided into when tessellated. See D3DTRIPATCH_INFO.
    ///    pTriPatchInfo = Type: <b>const D3DTRIPATCH_INFO*</b> Pointer to a D3DTRIPATCH_INFO structure, describing the triangular
    ///                    high-order patch to draw.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawTriPatch(uint Handle, const(float)* pNumSegs, const(D3DTRIPATCH_INFO)* pTriPatchInfo);
    ///Frees a cached high-order patch.
    ///Params:
    ///    Handle = Type: <b>UINT</b> Handle of the cached high-order patch to delete.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT DeletePatch(uint Handle);
    ///Creates a status query.
    ///Params:
    ///    Type = Type: <b>D3DQUERYTYPE</b> Identifies the query type. For more information, see D3DQUERYTYPE.
    ///    ppQuery = Type: <b>IDirect3DQuery9**</b> Returns a pointer to the query interface that manages the query object. See
    ///              IDirect3DQuery9. This parameter can be set to <b>NULL</b> to see if a query is supported. If the query is not
    ///              supported, the method returns D3DERR_NOTAVAILABLE.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_NOTAVAILABLE or E_OUTOFMEMORY.
    ///    
    HRESULT CreateQuery(D3DQUERYTYPE Type, IDirect3DQuery9* ppQuery);
}

///Applications use the methods of the IDirect3DStateBlock9 interface to encapsulate render states.
@GUID("B07C4FE5-310D-4BA8-A23C-4F0F206F218B")
interface IDirect3DStateBlock9 : IUnknown
{
    ///Gets the device.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Pointer to the IDirect3DDevice9 interface that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Capture the current value of states that are included in a stateblock.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails because capture
    ///    cannot be done while in record mode, the return value is D3DERR_INVALIDCALL.
    ///    
    HRESULT Capture();
    ///Apply the state block to the current device state.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails while in record
    ///    mode, the return value is D3DERR_INVALIDCALL.
    ///    
    HRESULT Apply();
}

///Applications use the methods of the IDirect3DSwapChain9 interface to manipulate a swap chain.
@GUID("794950F2-ADFC-458A-905E-10A10B0B503B")
interface IDirect3DSwapChain9 : IUnknown
{
    ///Presents the contents of the next buffer in the sequence of back buffers owned by the swap chain.
    ///Params:
    ///    pSourceRect = Type: <b>const RECT*</b> Pointer to the source rectangle (see RECT). Use <b>NULL</b> to present the entire
    ///                  surface. This value must be <b>NULL</b> unless the swap chain was created with D3DSWAPEFFECT_COPY. If the
    ///                  rectangle exceeds the source surface, the rectangle is clipped to the source surface.
    ///    pDestRect = Type: <b>const RECT*</b> Pointer to the destination rectangle in client coordinates (see RECT). This value
    ///                must be <b>NULL</b> unless the swap chain was created with D3DSWAPEFFECT_COPY. Use <b>NULL</b> to fill the
    ///                entire client area. If the rectangle exceeds the destination client area, the rectangle is clipped to the
    ///                destination client area.
    ///    hDestWindowOverride = Type: <b>HWND</b> Destination window whose client area is taken as the target for this presentation. If this
    ///                          value is <b>NULL</b>, the runtime uses the <b>hDeviceWindow</b> member of D3DPRESENT_PARAMETERS for the
    ///                          presentation.
    ///    pDirtyRegion = Type: <b>const RGNDATA*</b> This value must be <b>NULL</b> unless the swap chain was created with
    ///                   D3DSWAPEFFECT_COPY. See Flipping Surfaces (Direct3D 9). If this value is non-<b>NULL</b>, the contained
    ///                   region is expressed in back buffer coordinates. The rectangles within the region are the minimal set of
    ///                   pixels that need to be updated. This method takes these rectangles into account when optimizing the
    ///                   presentation by copying only the pixels within the region, or some suitably expanded set of rectangles. This
    ///                   is an aid to optimization only, and the application should not rely on the region being copied exactly. The
    ///                   implementation may choose to copy the whole source rectangle.
    ///    dwFlags = Type: <b>DWORD</b> Allows the application to request that the method return immediately when the driver
    ///              reports that it cannot schedule a presentation. Valid values are 0, or any combination of
    ///              D3DPRESENT_DONOTWAIT or D3DPRESENT_LINEAR_CONTENT. <ul> <li>If dwFlags = 0, this method behaves as it did
    ///              prior to Direct3D 9. Present will spin until the hardware is free, without returning an error.</li> <li>If
    ///              dwFlags = D3DPRESENT_DONOTWAIT, and the hardware is busy processing or waiting for a vertical sync interval,
    ///              the method will return D3DERR_WASSTILLDRAWING.</li> <li>If dwFlags = D3DPRESENT_LINEAR_CONTENT, gamma
    ///              correction is performed from linear space to sRGB for windowed swap chains. This flag will take effect only
    ///              when the driver exposes D3DCAPS3_LINEAR_TO_SRGB_PRESENTATION (see Gamma (Direct3D 9)). Appliations should
    ///              specify this flag if the backbuffer format is 16-bit floating point in order to match windowed mode present
    ///              to fullscreen gamma behavior.</li> </ul>
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_DEVICELOST, D3DERR_DRIVERINTERNALERROR, D3DERR_INVALIDCALL,
    ///    D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT Present(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, 
                    const(RGNDATA)* pDirtyRegion, uint dwFlags);
    ///Generates a copy of the swapchain's front buffer and places that copy in a system memory buffer provided by the
    ///application.
    ///Params:
    ///    pDestSurface = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 interface that will receive a copy of the
    ///                   swapchain's front buffer. The data is returned in successive rows with no intervening space, starting from
    ///                   the vertically highest row to the lowest. For windowed mode, the size of the destination surface should be
    ///                   the size of the desktop. For full screen mode, the size of the destination surface should be the screen size.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If BackBuffer exceeds or equals the
    ///    total number of back buffers, the function fails and returns D3DERR_INVALIDCALL.
    ///    
    HRESULT GetFrontBufferData(IDirect3DSurface9 pDestSurface);
    ///Retrieves a back buffer from the swap chain of the device.
    ///Params:
    ///    iBackBuffer = Type: <b>UINT</b> Index of the back buffer object to return. Back buffers are numbered from 0 to the total
    ///                  number of back buffers - 1. A value of 0 returns the first back buffer, not the front buffer. The front
    ///                  buffer is not accessible through this method. Use IDirect3DSwapChain9::GetFrontBufferData to retrieve a copy
    ///                  of the front buffer.
    ///    Type = Type: <b>D3DBACKBUFFER_TYPE</b> Stereo view is not supported in Direct3D 9, so the only valid value for this
    ///           parameter is D3DBACKBUFFER_TYPE_MONO.
    ///    ppBackBuffer = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                   returned back buffer surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If BackBuffer exceeds or equals the
    ///    total number of back buffers, then the function fails and returns D3DERR_INVALIDCALL.
    ///    
    HRESULT GetBackBuffer(uint iBackBuffer, D3DBACKBUFFER_TYPE Type, IDirect3DSurface9* ppBackBuffer);
    ///Returns information describing the raster of the monitor on which the swap chain is presented.
    ///Params:
    ///    pRasterStatus = Type: <b>D3DRASTER_STATUS*</b> Pointer to a D3DRASTER_STATUS structure filled with information about the
    ///                    position or other status of the raster on the monitor driven by this adapter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    pRasterStatus is invalid or if the device does not support reading the current scan line. To determine if the
    ///    device supports reading the scan line, check for the D3DCAPS_READ_SCANLINE flag in the Caps member of
    ///    D3DCAPS9.
    ///    
    HRESULT GetRasterStatus(D3DRASTER_STATUS* pRasterStatus);
    ///Retrieves the display mode's spatial resolution, color resolution, and refresh frequency.
    ///Params:
    ///    pMode = Type: <b>D3DDISPLAYMODE*</b> Pointer to a D3DDISPLAYMODE structure containing data about the display mode of
    ///            the adapter. As opposed to the display mode of the device, which may not be active if the device does not own
    ///            full-screen mode.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDisplayMode(D3DDISPLAYMODE* pMode);
    ///Retrieves the device associated with the swap chain.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Address of a pointer to an IDirect3DDevice9 interface to fill with the device
    ///               pointer, if the query succeeds.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Retrieves the presentation parameters associated with a swap chain.
    ///Params:
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to the presentation parameters. See D3DPRESENT_PARAMETERS.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPresentParameters(D3DPRESENT_PARAMETERS* pPresentationParameters);
}

///Applications use the methods of the <b>IDirect3DResource9</b> interface to query and prepare resources.
@GUID("05EEC05D-8F7D-4362-B999-D1BAF357C704")
interface IDirect3DResource9 : IUnknown
{
    ///Retrieves the device associated with a resource.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Address of a pointer to an IDirect3DDevice9 interface to fill with the device
    ///               pointer, if the query succeeds.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Associates data with the resource that is intended for use by the application, not by Direct3D. Data is passed by
    ///value, and multiple sets of data can be associated with a single resource.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> Reference to the globally unique identifier that identifies the private data to set.
    ///    pData = Type: <b>const void*</b> Pointer to a buffer that contains the data to be associated with the resource.
    ///    SizeOfData = Type: <b>DWORD</b> Size of the buffer at pData, in bytes.
    ///    Flags = Type: <b>DWORD</b> Value that describes the type of data being passed, or indicates to the application that
    ///            the data should be invalidated when the resource changes. <table> <tr> <th>Item</th> <th>Description</th>
    ///            </tr> <tr> <td width="40%"> <a id="_none_"></a><a id="_NONE_"></a>(none) </td> <td width="60%"> If no flags
    ///            are specified, Direct3D allocates memory to hold the data within the buffer and copies the data into the new
    ///            buffer. The buffer allocated by Direct3D is automatically freed, as appropriate. </td> </tr> <tr> <td
    ///            width="40%"> <a id="D3DSPD_IUNKNOWN"></a><a id="d3dspd_iunknown"></a>D3DSPD_IUNKNOWN </td> <td width="60%">
    ///            The data at pData is a pointer to an IUnknown interface. SizeOfData must be set to the size of a pointer to
    ///            IUnknown, that is, sizeof(IUnknown*). Direct3D automatically callsIUnknown through pData when the private
    ///            data is destroyed. Private data will be destroyed by a subsequent call to
    ///            <b>IDirect3DResource9::SetPrivateData</b> with the same GUID, a subsequent call to
    ///            IDirect3DResource9::FreePrivateData, or when the IDirect3D9 object is released. For more information, see
    ///            Remarks. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, E_OUTOFMEMORY.
    ///    
    HRESULT SetPrivateData(const(GUID)* refguid, const(void)* pData, uint SizeOfData, uint Flags);
    ///Copies the private data associated with the resource to a provided buffer.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> The globally unique identifier that identifies the private data to retrieve.
    ///    pData = Type: <b>void*</b> Pointer to a previously allocated buffer to fill with the requested private data if the
    ///            call succeeds. The application calling this method is responsible for allocating and releasing this buffer.
    ///            If this parameter is <b>NULL</b>, this method will return the buffer size in pSizeOfData.
    ///    pSizeOfData = Type: <b>DWORD*</b> Pointer to the size of the buffer at pData, in bytes. If this value is less than the
    ///                  actual size of the private data (such as 0), the method sets this parameter to the required buffer size and
    ///                  the method returns D3DERR_MOREDATA.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_MOREDATA, D3DERR_NOTFOUND.
    ///    
    HRESULT GetPrivateData(const(GUID)* refguid, void* pData, uint* pSizeOfData);
    ///Frees the specified private data associated with this resource.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> Reference to the globally unique identifier that identifies the private data to free.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_NOTFOUND.
    ///    
    HRESULT FreePrivateData(const(GUID)* refguid);
    ///Assigns the priority of a resource for scheduling purposes.
    ///Params:
    ///    PriorityNew = Type: <b>DWORD</b> Priority to assign to a resource. <table> <tr> <td> Differences between Direct3D 9 and
    ///                  Direct3D 9 for Windows Vista The priority can be any DWORD value; Direct3D 9 for Windows Vista also supports
    ///                  any of these pre-defined values D3D9_RESOURCE_PRIORITY. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>DWORD</b> Returns the previous priority value for the resource.
    ///    
    uint    SetPriority(uint PriorityNew);
    ///Retrieves the priority for this resource.
    ///Returns:
    ///    Type: <b>DWORD</b> Returns a DWORD value, indicating the priority of the resource.
    ///    
    uint    GetPriority();
    ///Preloads a managed resource.
    void    PreLoad();
    ///Returns the type of the resource.
    ///Returns:
    ///    Type: <b>D3DRESOURCETYPE</b> Returns a member of the D3DRESOURCETYPE enumerated type, identifying the type of
    ///    the resource.
    ///    
    D3DRESOURCETYPE GetType();
}

///Applications use the methods of the IDirect3DVertexDeclaration9 interface to encapsulate the vertex shader
///declaration.
@GUID("DD13C59C-36FA-4098-A8FB-C7ED39DC8546")
interface IDirect3DVertexDeclaration9 : IUnknown
{
    ///Gets the current device.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Pointer to the IDirect3DDevice9 interface that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Gets the vertex shader declaration.
    ///Params:
    ///    pElement = Type: [in, out] <b>D3DVERTEXELEMENT9*</b> Array of vertex elements (see D3DVERTEXELEMENT9) that make up a
    ///               vertex shader declaration. The application needs to allocate enough room for this. The vertex element array
    ///               ends with the D3DDECL_END macro.
    ///    pNumElements = Type: [out] <b>UINT*</b> Number of elements in the array. The application needs to allocate enough room for
    ///                   this.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDeclaration(D3DVERTEXELEMENT9* pElement, uint* pNumElements);
}

///Applications use the methods of the IDirect3DVertexShader9 interface to encapsulate the functionality of a vertex
///shader.
@GUID("EFC5557E-6265-4613-8A94-43857889EB36")
interface IDirect3DVertexShader9 : IUnknown
{
    ///Gets the device.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Pointer to the IDirect3DDevice9 interface that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Gets a pointer to the shader data.
    ///Params:
    ///    arg1 = Type: <b>void*</b> Pointer to a buffer that contains the shader data. The application needs to allocate
    ///           enough room for this.
    ///    pSizeOfData = Type: <b>UINT*</b> Size of the data, in bytes. To get the buffer size that is needed to retrieve the data,
    ///                  set pData = <b>NULL</b> when calling GetFunction. Then call GetFunction with the returned size, to get the
    ///                  buffer data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetFunction(void* param0, uint* pSizeOfData);
}

///Applications use the methods of the IDirect3DPixelShader9 interface to encapsulate the functionality of a pixel
///shader.
@GUID("6D3BDBDC-5B02-4415-B852-CE5E8BCCB289")
interface IDirect3DPixelShader9 : IUnknown
{
    ///Gets the device.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Pointer to the IDirect3DDevice9 interface that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Gets a pointer to the shader data.
    ///Params:
    ///    arg1 = Type: <b>void*</b> Pointer to a buffer that contains the shader data. The application needs to allocate
    ///           enough room for this.
    ///    pSizeOfData = Type: <b>UINT*</b> Size of the data, in bytes. To get the buffer size that is needed to retrieve the data,
    ///                  set pData = <b>NULL</b> when calling GetFunction. Then call GetFunction with the returned size, to get the
    ///                  buffer data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetFunction(void* param0, uint* pSizeOfData);
}

///Applications use the methods of the IDirect3DBaseTexture9 interface to manipulate texture resources including cube
///and volume textures.
@GUID("580CA87E-1D3C-4D54-991D-B7D3E3C298CE")
interface IDirect3DBaseTexture9 : IDirect3DResource9
{
    ///Sets the most detailed level-of-detail for a managed texture.
    ///Params:
    ///    LODNew = Type: <b>DWORD</b> Most detailed level-of-detail value to set for the mipmap chain.
    ///Returns:
    ///    Type: <b>DWORD</b> A DWORD value, clamped to the maximum level-of-detail value (one less than the total
    ///    number of levels). Subsequent calls to this method will return the clamped value, not the level-of-detail
    ///    value that was previously set.
    ///    
    uint    SetLOD(uint LODNew);
    ///Returns a value clamped to the maximum level-of-detail set for a managed texture (this method is not supported
    ///for an unmanaged texture).
    ///Returns:
    ///    Type: <b>DWORD</b> A DWORD value, clamped to the maximum level-of-detail value (one less than the total
    ///    number of levels). Calling <b>GetLOD</b> on an unmanaged texture is not supported and will result in a D3DERR
    ///    error code being returned.
    ///    
    uint    GetLOD();
    ///Returns the number of texture levels in a multilevel texture.
    ///Returns:
    ///    Type: <b>DWORD</b> A DWORD value that indicates the number of texture levels in a multilevel texture.
    ///    
    uint    GetLevelCount();
    ///Set the filter type that is used for automatically generated mipmap sublevels.
    ///Params:
    ///    FilterType = Type: <b>D3DTEXTUREFILTERTYPE</b> Filter type. See D3DTEXTUREFILTERTYPE. This method will fail if the filter
    ///                 type is invalid or not supported.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetAutoGenFilterType(D3DTEXTUREFILTERTYPE FilterType);
    ///Get the filter type that is used for automatically generated mipmap sublevels.
    ///Returns:
    ///    Type: <b>D3DTEXTUREFILTERTYPE</b> Filter type. See D3DTEXTUREFILTERTYPE. A texture must be created with
    ///    D3DUSAGE_AUTOGENMIPMAP to use this method. Any other usage value will cause this method to return
    ///    D3DTEXF_NONE.
    ///    
    D3DTEXTUREFILTERTYPE GetAutoGenFilterType();
    ///Generate mipmap sublevels.
    void    GenerateMipSubLevels();
}

///Applications use the methods of the IDirect3DTexture9 interface to manipulate a texture resource.
@GUID("85C31227-3DE5-4F00-9B3A-F11AC38C18B5")
interface IDirect3DTexture9 : IDirect3DBaseTexture9
{
    ///Retrieves a level description of a texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Identifies a level of the texture resource. This method returns a surface description for
    ///            the level specified by this parameter.
    ///    pDesc = Type: <b>D3DSURFACE_DESC*</b> Pointer to a D3DSURFACE_DESC structure, describing the returned level.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    one of the arguments is invalid.
    ///    
    HRESULT GetLevelDesc(uint Level, D3DSURFACE_DESC* pDesc);
    ///Retrieves the specified texture surface level.
    ///Params:
    ///    Level = Type: <b>UINT</b> Identifies a level of the texture resource. This method returns a surface for the level
    ///            specified by this parameter. The top-level surface is denoted by 0.
    ///    ppSurfaceLevel = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                     returned surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one D3DERR_INVALIDCALL.
    ///    
    HRESULT GetSurfaceLevel(uint Level, IDirect3DSurface9* ppSurfaceLevel);
    ///Locks a rectangle on a texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Specifies the level of the texture resource to lock.
    ///    pLockedRect = Type: <b>D3DLOCKED_RECT*</b> Pointer to a D3DLOCKED_RECT structure, describing the locked region.
    ///    pRect = Type: <b>const RECT*</b> Pointer to a rectangle to lock. Specified by a pointer to a RECT structure.
    ///            Specifying <b>NULL</b> for this parameter expands the dirty region to cover the entire texture.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> </ul> You may not specify a subrect when using
    ///            D3DLOCK_DISCARD. For a description of the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT LockRect(uint Level, D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, uint Flags);
    ///Unlocks a rectangle on a texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Specifies the level of the texture resource to unlock.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT UnlockRect(uint Level);
    ///Adds a dirty region to a texture resource.
    ///Params:
    ///    pDirtyRect = Type: <b>const RECT*</b> Pointer to a RECT structure, specifying the dirty region to add. Specifying
    ///                 <b>NULL</b> expands the dirty region to cover the entire texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT AddDirtyRect(const(RECT)* pDirtyRect);
}

///Applications use the methods of the IDirect3DVolumeTexture9 interface to manipulate a volume texture resource.
@GUID("2518526C-E789-4111-A7B9-47EF328D13E6")
interface IDirect3DVolumeTexture9 : IDirect3DBaseTexture9
{
    ///Retrieves a level description of a volume texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Identifies a level of the volume texture resource. This method returns a volume description
    ///            for the level specified by this parameter.
    ///    pDesc = Type: <b>D3DVOLUME_DESC*</b> Pointer to a D3DVOLUME_DESC structure, describing the returned volume texture
    ///            level.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    one or more of the arguments are invalid.
    ///    
    HRESULT GetLevelDesc(uint Level, D3DVOLUME_DESC* pDesc);
    ///Retrieves the specified volume texture level.
    ///Params:
    ///    Level = Type: <b>UINT</b> Identifies a level of the volume texture resource. This method returns a volume for the
    ///            level specified by this parameter.
    ///    ppVolumeLevel = Type: <b>IDirect3DVolume9**</b> Address of a pointer to an IDirect3DVolume9 interface, representing the
    ///                    returned volume level.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetVolumeLevel(uint Level, IDirect3DVolume9* ppVolumeLevel);
    ///Locks a box on a volume texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Specifies the level of the volume texture resource to lock.
    ///    pLockedVolume = Type: <b>D3DLOCKED_BOX*</b> Pointer to a D3DLOCKED_BOX structure, describing the locked region.
    ///    pBox = Type: <b>const D3DBOX*</b> Pointer to the volume to lock. This parameter is specified by a pointer to a
    ///           D3DBOX structure. Specifying <b>NULL</b> for this parameter locks the entire volume level.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> </ul> For a description of the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT LockBox(uint Level, D3DLOCKED_BOX* pLockedVolume, const(D3DBOX)* pBox, uint Flags);
    ///Unlocks a box on a volume texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Specifies the level of the volume texture resource to unlock.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT UnlockBox(uint Level);
    ///Adds a dirty region to a volume texture resource.
    ///Params:
    ///    pDirtyBox = Type: <b>const D3DBOX*</b> Pointer to a D3DBOX structure, specifying the dirty region to add. Specifying
    ///                <b>NULL</b> expands the dirty region to cover the entire volume texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT AddDirtyBox(const(D3DBOX)* pDirtyBox);
}

///Applications use the methods of the IDirect3DCubeTexture9 interface to manipulate a cube texture resource.
@GUID("FFF32F81-D953-473A-9223-93D652ABA93F")
interface IDirect3DCubeTexture9 : IDirect3DBaseTexture9
{
    ///Retrieves a description of one face of the specified cube texture level.
    ///Params:
    ///    Level = Type: <b>UINT</b> Specifies a level of a mipmapped cube texture.
    ///    pDesc = Type: <b>D3DSURFACE_DESC*</b> Pointer to a D3DSURFACE_DESC structure, describing one face of the specified
    ///            cube texture level.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetLevelDesc(uint Level, D3DSURFACE_DESC* pDesc);
    ///Retrieves a cube texture map surface.
    ///Params:
    ///    FaceType = Type: <b>D3DCUBEMAP_FACES</b> Member of the D3DCUBEMAP_FACES enumerated type, identifying a cube map face.
    ///    Level = Type: <b>UINT</b> Specifies a level of a mipmapped cube texture.
    ///    ppCubeMapSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                       returned cube texture map surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetCubeMapSurface(D3DCUBEMAP_FACES FaceType, uint Level, IDirect3DSurface9* ppCubeMapSurface);
    ///Locks a rectangle on a cube texture resource.
    ///Params:
    ///    FaceType = Type: <b>D3DCUBEMAP_FACES</b> Member of the D3DCUBEMAP_FACES enumerated type, identifying a cube map face.
    ///    Level = Type: <b>UINT</b> Specifies a level of a mipmapped cube texture.
    ///    pLockedRect = Type: <b>D3DLOCKED_RECT*</b> Pointer to a D3DLOCKED_RECT structure, describing the region to lock.
    ///    pRect = Type: <b>const RECT*</b> Pointer to a rectangle to lock. Specified by a pointer to a RECT structure.
    ///            Specifying <b>NULL</b> for this parameter expands the dirty region to cover the entire cube texture.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> </ul> You may not specify a subrect when using
    ///            D3DLOCK_DISCARD. For a description of the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    one or more of the arguments is invalid.
    ///    
    HRESULT LockRect(D3DCUBEMAP_FACES FaceType, uint Level, D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, 
                     uint Flags);
    ///Unlocks a rectangle on a cube texture resource.
    ///Params:
    ///    FaceType = Type: <b>D3DCUBEMAP_FACES</b> Member of the D3DCUBEMAP_FACES enumerated type, identifying a cube map face.
    ///    Level = Type: <b>UINT</b> Specifies a level of a mipmapped cube texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT UnlockRect(D3DCUBEMAP_FACES FaceType, uint Level);
    ///Adds a dirty region to a cube texture resource.
    ///Params:
    ///    FaceType = Type: <b>D3DCUBEMAP_FACES</b> Member of the D3DCUBEMAP_FACES enumerated type, identifying the cube map face.
    ///    pDirtyRect = Type: <b>const RECT*</b> Pointer to a RECT structure, specifying the dirty region. Specifying <b>NULL</b>
    ///                 expands the dirty region to cover the entire cube texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT AddDirtyRect(D3DCUBEMAP_FACES FaceType, const(RECT)* pDirtyRect);
}

///Applications use the methods of the IDirect3DVertexBuffer9 interface to manipulate vertex buffer resources.
@GUID("B64BB1B5-FD70-4DF6-BF91-19D0A12455E3")
interface IDirect3DVertexBuffer9 : IDirect3DResource9
{
    ///Locks a range of vertex data and obtains a pointer to the vertex buffer memory.
    ///Params:
    ///    OffsetToLock = Type: <b>UINT</b> Offset into the vertex data to lock, in bytes. To lock the entire vertex buffer, specify 0
    ///                   for both parameters, SizeToLock and OffsetToLock.
    ///    SizeToLock = Type: <b>UINT</b> Size of the vertex data to lock, in bytes. To lock the entire vertex buffer, specify 0 for
    ///                 both parameters, SizeToLock and OffsetToLock.
    ///    ppbData = Type: <b>VOID**</b> VOID* pointer to a memory buffer containing the returned vertex data.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> <li>D3DLOCK_NOOVERWRITE</li> </ul> For a description of
    ///            the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT Lock(uint OffsetToLock, uint SizeToLock, void** ppbData, uint Flags);
    ///Unlocks vertex data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT Unlock();
    ///Retrieves a description of the vertex buffer resource.
    ///Params:
    ///    pDesc = Type: <b>D3DVERTEXBUFFER_DESC*</b> Pointer to a D3DVERTEXBUFFER_DESC structure, describing the returned
    ///            vertex buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetDesc(D3DVERTEXBUFFER_DESC* pDesc);
}

///Applications use the methods of the IDirect3DIndexBuffer9 interface to manipulate an index buffer resource.
@GUID("7C9DD65E-D3F7-4529-ACEE-785830ACDE35")
interface IDirect3DIndexBuffer9 : IDirect3DResource9
{
    ///Locks a range of index data and obtains a pointer to the index buffer memory.
    ///Params:
    ///    OffsetToLock = Type: <b>UINT</b> Offset into the index data to lock, in bytes. Lock the entire index buffer by specifying 0
    ///                   for both parameters, SizeToLock and OffsetToLock.
    ///    SizeToLock = Type: <b>UINT</b> Size of the index data to lock, in bytes. Lock the entire index buffer by specifying 0 for
    ///                 both parameters, SizeToLock and OffsetToLock.
    ///    ppbData = Type: <b>VOID**</b> VOID* pointer to a memory buffer containing the returned index data.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> <li>D3DLOCK_NOOVERWRITE</li> </ul> For a description of
    ///            the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT Lock(uint OffsetToLock, uint SizeToLock, void** ppbData, uint Flags);
    ///Unlocks index data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT Unlock();
    ///Retrieves a description of the index buffer resource.
    ///Params:
    ///    pDesc = Type: <b>D3DINDEXBUFFER_DESC*</b> Pointer to a D3DINDEXBUFFER_DESC structure, describing the returned index
    ///            buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetDesc(D3DINDEXBUFFER_DESC* pDesc);
}

///Applications use the methods of the IDirect3DSurface9 interface to query and prepare surfaces.
@GUID("0CFBAF3A-9FF6-429A-99B3-A2796AF8B89B")
interface IDirect3DSurface9 : IDirect3DResource9
{
    ///Provides access to the parent cube texture or texture (mipmap) object, if this surface is a child level of a cube
    ///texture or a mipmap. This method can also provide access to the parent swap chain if the surface is a back-buffer
    ///child.
    ///Params:
    ///    riid = Type: <b>REFIID</b> Reference identifier of the container being requested.
    ///    ppContainer = Type: <b>void**</b> Address of a pointer to fill with the container pointer if the query succeeds. See
    ///                  Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetContainer(const(GUID)* riid, void** ppContainer);
    ///Retrieves a description of the surface.
    ///Params:
    ///    pDesc = Type: <b>D3DSURFACE_DESC*</b> Pointer to a D3DSURFACE_DESC structure, describing the surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetDesc(D3DSURFACE_DESC* pDesc);
    ///Locks a rectangle on a surface.
    ///Params:
    ///    pLockedRect = Type: <b>D3DLOCKED_RECT*</b> Pointer to a D3DLOCKED_RECT structure that describes the locked region.
    ///    pRect = Type: <b>const RECT*</b> Pointer to a rectangle to lock. Specified by a pointer to a RECT structure.
    ///            Specifying <b>NULL</b> for this parameter expands the dirty region to cover the entire surface.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_DONOTWAIT</li>
    ///            <li>D3DLOCK_NO_DIRTY_UPDATE</li> <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> </ul> You may not
    ///            specify a subrect when using D3DLOCK_DISCARD. For a description of the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL or D3DERR_WASSTILLDRAWING.
    ///    
    HRESULT LockRect(D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, uint Flags);
    ///Unlocks a rectangle on a surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT UnlockRect();
    ///Retrieves a device context.
    ///Params:
    ///    phdc = Type: <b>HDC*</b> Pointer to the device context for the surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetDC(HDC* phdc);
    ///Release a device context handle.
    ///Params:
    ///    hdc = Type: <b>HDC</b> Handle to a device context.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT ReleaseDC(HDC hdc);
}

///Applications use the methods of the <b>IDirect3DVolume9</b> interface to manipulate volume resources.
@GUID("24F416E6-1F67-4AA7-B88E-D33F6F3128A1")
interface IDirect3DVolume9 : IUnknown
{
    ///Retrieves the device associated with a volume.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Address of a pointer to an IDirect3DDevice9 interface to fill with the device
    ///               pointer, if the query succeeds.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Associates data with the volume that is intended for use by the application, not by Direct3D.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> Reference to the globally unique identifier that identifies the private data to set.
    ///    pData = Type: <b>const void*</b> Pointer to a buffer that contains the data to associate with the volume.
    ///    SizeOfData = Type: <b>DWORD</b> Size of the buffer at pData in bytes.
    ///    Flags = Type: <b>DWORD</b> Value that describes the type of data being passed, or indicates to the application that
    ///            the data should be invalidated when the resource changes. <table> <tr> <th>Item</th> <th>Description</th>
    ///            </tr> <tr> <td width="40%"> <a id="_none_"></a><a id="_NONE_"></a>(none) </td> <td width="60%"> If no flags
    ///            are specified, Direct3D allocates memory to hold the data within the buffer and copies the data into the new
    ///            buffer. The buffer allocated by Direct3D is automatically freed, as appropriate. </td> </tr> <tr> <td
    ///            width="40%"> <a id="D3DSPD_IUNKNOWN"></a><a id="d3dspd_iunknown"></a>D3DSPD_IUNKNOWN </td> <td width="60%">
    ///            The data at pData is a pointer to an IUnknown interface. SizeOfData must be set to the size of a pointer to
    ///            an <b>IUnknown</b> interface, sizeof(IUnknown*). Direct3D automatically calls <b>IUnknown</b> through pData
    ///            and IUnknown when the private data is destroyed. Private data will be destroyed by a subsequent call to
    ///            <b>IDirect3DVolume9::SetPrivateData</b> with the same GUID, a subsequent call to
    ///            IDirect3DVolume9::FreePrivateData, or when the IDirect3D9 object is released. For more information, see
    ///            Remarks. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, E_OUTOFMEMORY.
    ///    
    HRESULT SetPrivateData(const(GUID)* refguid, const(void)* pData, uint SizeOfData, uint Flags);
    ///Copies the private data associated with the volume to a provided buffer.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> Reference to (C++) or address of (C) the globally unique identifier that identifies the
    ///              private data to retrieve.
    ///    pData = Type: <b>void*</b> Pointer to a previously allocated buffer to fill with the requested private data if the
    ///            call succeeds. The application calling this method is responsible for allocating and releasing this buffer.
    ///            If this parameter is <b>NULL</b>, this method will return the buffer size in pSizeOfData.
    ///    pSizeOfData = Type: <b>DWORD*</b> Pointer to the size of the buffer at pData, in bytes. If this value is less than the
    ///                  actual size of the private data, such as 0, the method sets this parameter to the required buffer size, and
    ///                  the method returns D3DERR_MOREDATA.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_MOREDATA, D3DERR_NOTFOUND.
    ///    
    HRESULT GetPrivateData(const(GUID)* refguid, void* pData, uint* pSizeOfData);
    ///Frees the specified private data associated with this volume.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> Reference to the globally unique identifier that identifies the private data to free.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_NOTFOUND.
    ///    
    HRESULT FreePrivateData(const(GUID)* refguid);
    ///Provides access to the parent volume texture object, if this surface is a child level of a volume texture.
    ///Params:
    ///    riid = Type: <b>REFIID</b> Reference identifier of the volume being requested.
    ///    ppContainer = Type: <b>void**</b> Address of a pointer to fill with the container pointer, if the query succeeds.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetContainer(const(GUID)* riid, void** ppContainer);
    ///Retrieves a description of the volume.
    ///Params:
    ///    pDesc = Type: <b>D3DVOLUME_DESC*</b> Pointer to a D3DVOLUME_DESC structure, describing the volume.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetDesc(D3DVOLUME_DESC* pDesc);
    ///Locks a box on a volume resource.
    ///Params:
    ///    pLockedVolume = Type: <b>D3DLOCKED_BOX*</b> Pointer to a D3DLOCKED_BOX structure, describing the locked region.
    ///    pBox = Type: <b>const D3DBOX*</b> Pointer to a box to lock. Specified by a pointer to a D3DBOX structure. Specifying
    ///           <b>NULL</b> for this parameter locks the entire volume.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> </ul> For a description of the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT LockBox(D3DLOCKED_BOX* pLockedVolume, const(D3DBOX)* pBox, uint Flags);
    ///Unlocks a box on a volume resource.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT UnlockBox();
}

///Applications use the methods of the IDirect3DQuery9 interface to perform asynchronous queries on a driver.
@GUID("D9771460-A695-4F26-BBD3-27B840B541CC")
interface IDirect3DQuery9 : IUnknown
{
    ///Gets the device that is being queried.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Pointer to the device being queried. See IDirect3DDevice9.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Gets the query type.
    ///Returns:
    ///    Type: <b>D3DQUERYTYPE</b> Returns the query type. See D3DQUERYTYPE.
    ///    
    D3DQUERYTYPE GetType();
    ///Gets the number of bytes in the query data.
    ///Returns:
    ///    Type: <b>DWORD</b> Returns the number of bytes of query data.
    ///    
    uint    GetDataSize();
    ///Issue a query.
    ///Params:
    ///    dwIssueFlags = Type: <b>DWORD</b> Query flags specify the type of state change for the query. See D3DISSUE_BEGIN and
    ///                   D3DISSUE_END.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT Issue(uint dwIssueFlags);
    ///Polls a queried resource to get the query state or a query result. For more information about queries, see
    ///Queries (Direct3D 9).
    ///Params:
    ///    pData = Type: <b>void*</b> Pointer to a buffer containing the query data. The user is responsible for allocating
    ///            this. <i>pData</i> may be <b>NULL</b> only if dwSize is 0.
    ///    dwSize = Type: <b>DWORD</b> Number of bytes of data in <i>pData</i>. If you set dwSize to zero, you can use this
    ///             method to poll the resource for the query status. See remarks.
    ///    dwGetDataFlags = Type: <b>DWORD</b> Data flags specifying the query type. Valid values are either 0 or D3DGETDATA_FLUSH. Use 0
    ///                     to avoid flushing batched queries to the driver and use D3DGETDATA_FLUSH to go ahead and flush them. For
    ///                     applications writing their own version of waiting, a query result is not realized until the driver receives a
    ///                     flush.
    ///Returns:
    ///    Type: <b>HRESULT</b> The return type identifies the query state (see Queries (Direct3D 9)). The method
    ///    returns S_OK if the query data is available and S_FALSE if it is not. These are considered successful return
    ///    values. If the method fails when D3DGETDATA_FLUSH is used, the return value can be D3DERR_DEVICELOST.
    ///    
    HRESULT GetData(void* pData, uint dwSize, uint dwGetDataFlags);
}

///Applications use the methods of the <b>IDirect3D9Ex</b> interface (which inherits from IDirect3D9) to create
///Microsoft Direct3D 9Ex objects and set up the environment. This interface includes methods for enumerating and
///retrieving capabilities of the device and is available when the underlying device implementation is compliant with
///Windows Vista.
@GUID("02177241-69FC-400C-8FF1-93A44DF6861D")
interface IDirect3D9Ex : IDirect3D9
{
    ///Returns the number of display modes available.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter from which to retrieve the display mode count.
    ///    pFilter = Type: <b>const D3DDISPLAYMODEFILTER*</b> Specifies the characteristics of the desired display mode. See
    ///              D3DDISPLAYMODEFILTER.
    ///Returns:
    ///    Type: <b>UINT</b> The number of display modes available. A return of value zero from this method is an
    ///    indication that no such display mode is supported or simply this monitor is no longer available.
    ///    
    uint    GetAdapterModeCountEx(uint Adapter, const(D3DDISPLAYMODEFILTER)* pFilter);
    ///This method returns the actual display mode info based on the given mode index.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to enumerate. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter. This method returns D3DERR_INVALIDCALL when this value equals or exceeds the number
    ///              of display adapters in the system.
    ///    pFilter = Type: <b>const D3DDISPLAYMODEFILTER*</b> See D3DDISPLAYMODEFILTER.
    ///    Mode = Type: <b>UINT</b> Represents the display-mode index which is an unsigned integer between zero and the value
    ///           returned by GetAdapterModeCount minus one.
    ///    pMode = Type: <b>D3DDISPLAYMODEEX*</b> A pointer to the available display mode of type D3DDISPLAYMODEEX.
    ///Returns:
    ///    Type: <b>HRESULT</b> <ul> <li>If the device can be used on this adapter, D3D_OK is returned.</li> <li>If the
    ///    Adapter equals or exceeds the number of display adapters in the system, D3DERR_INVALIDCALL is returned.</li>
    ///    </ul>
    ///    
    HRESULT EnumAdapterModesEx(uint Adapter, const(D3DDISPLAYMODEFILTER)* pFilter, uint Mode, 
                               D3DDISPLAYMODEEX* pMode);
    ///Retrieves the current display mode and rotation settings of the adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter to query. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter.
    ///    pMode = Type: <b>D3DDISPLAYMODEEX*</b> Pointer to a D3DDISPLAYMODEEX structure containing data about the display mode
    ///            of the adapter. As opposed to the display mode of the device, which may not be active if the device does not
    ///            own full-screen mode. Can be set to <b>NULL</b>.
    ///    pRotation = Type: <b>D3DDISPLAYROTATION*</b> Pointer to a D3DDISPLAYROTATION structure indicating the type of screen
    ///                rotation the application will do. The value returned through this pointer is important when the
    ///                D3DPRESENTFLAG_NOAUTOROTATE flag is used; otherwise, it can be set to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If <i>Adapter</i> is out of range or
    ///    <i>pMode</i> is invalid, this method returns D3DERR_INVALIDCALL.
    ///    
    HRESULT GetAdapterDisplayModeEx(uint Adapter, D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
    ///Creates a device to represent the display adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Specifies the type of device. See D3DDEVTYPE. If the desired device type is not
    ///                 available, the method will fail.
    ///    hFocusWindow = Type: <b>HWND</b> The focus window alerts Direct3D when an application switches from foreground mode to
    ///                   background mode. For full-screen mode, the window specified must be a top-level window. For windowed mode,
    ///                   this parameter may be <b>NULL</b> only if the hDeviceWindow member of pPresentationParameters is set to a
    ///                   valid, non-<b>NULL</b> value.
    ///    BehaviorFlags = Type: <b>DWORD</b> Combination of one or more options (see D3DCREATE) that control device creation.
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to a D3DPRESENT_PARAMETERS structure, describing the presentation
    ///                              parameters for the device to be created. If <i>BehaviorFlags</i> specifies D3DCREATE_ADAPTERGROUP_DEVICE,
    ///                              this parameter is an array. Regardless of the number of heads that exist, only one depth/stencil surface is
    ///                              automatically created. This parameter is both an input and an output parameter. Calling this method may
    ///                              change several members including: <ul> <li>If BackBufferCount, BackBufferWidth, and BackBufferHeight are 0
    ///                              before the method is called, they will be changed when the method returns.</li> <li>If BackBufferFormat
    ///                              equals D3DFMT_UNKNOWN before the method is called, it will be changed when the method returns.</li> </ul>
    ///    pFullscreenDisplayMode = Type: <b>D3DDISPLAYMODEEX*</b> The display mode for when the device is set to fullscreen. See
    ///                             D3DDISPLAYMODEEX. If <i>BehaviorFlags</i> specifies D3DCREATE_ADAPTERGROUP_DEVICE, this parameter is an
    ///                             array. This parameter must be <b>NULL</b> for windowed mode.
    ///    ppReturnedDeviceInterface = Type: <b>IDirect3DDevice9Ex**</b> Address of a pointer to the returned IDirect3DDevice9Ex, which represents
    ///                                the created device.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns S_OK when rendering device along with swapchain buffers are created
    ///    successfully. D3DERR_DEVICELOST is returned when any error other than invalid caller input is encountered.
    ///    
    HRESULT CreateDeviceEx(uint Adapter, D3DDEVTYPE DeviceType, HWND hFocusWindow, uint BehaviorFlags, 
                           D3DPRESENT_PARAMETERS* pPresentationParameters, D3DDISPLAYMODEEX* pFullscreenDisplayMode, 
                           IDirect3DDevice9Ex* ppReturnedDeviceInterface);
    ///This method returns a unique identifier for the adapter that is specific to the adapter hardware. Applications
    ///can use this identifier to define robust mappings across various APIs (Direct3D 9, DXGI).
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter from which to retrieve the LUID.
    ///    pLUID = Type: <b>LUID*</b> A unique identifier for the given adapter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAdapterLUID(uint Adapter, LUID* pLUID);
}

///Applications use the methods of the IDirect3DDevice9Ex interface to render primitives, create resources, work with
///system-level variables, adjust gamma ramp levels, work with palettes, and create shaders. The IDirect3DDevice9Ex
///interface derives from the IDirect3DDevice9 interface.
@GUID("B18B10CE-2649-405A-870F-95F777D4313A")
interface IDirect3DDevice9Ex : IDirect3DDevice9
{
    ///Prepare the texture sampler for monochrome convolution filtering on a single-color texture.
    ///Params:
    ///    width = Type: <b>UINT</b> The width of the filter kernel; ranging from 1 - D3DCONVOLUTIONMONO_MAXWIDTH. The default
    ///            value is 1.
    ///    height = Type: <b>UINT</b> The height of the filter kernel; ranging from 1 - D3DCONVOLUTIONMONO_MAXHEIGHT. The default
    ///             value is 1.
    ///    rows = Type: <b>float*</b> An array of weights, one weight for each kernel sub-element in the width. This parameter
    ///           must be <b>NULL</b>, which will set the weights equal to the default value.
    ///    columns = Type: <b>float*</b> An array of weights, one weight for each kernel sub-element in the height. This parameter
    ///              must be <b>NULL</b>, which will set the weights equal to the default value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK.
    ///    
    HRESULT SetConvolutionMonoKernel(uint width, uint height, float* rows, float* columns);
    ///Copy a text string to one surface using an alphabet of glyphs on another surface. Composition is done by the GPU
    ///using bitwise operations.
    ///Params:
    ///    pSrc = Type: <b>IDirect3DSurface9*</b> A pointer to a source surface (prepared by IDirect3DSurface9) that supplies
    ///           the alphabet glyphs. This surface must be created with the D3DUSAGE_TEXTAPI flag.
    ///    pDst = Type: <b>IDirect3DSurface9*</b> A pointer to the destination surface (prepared by IDirect3DSurface9) that
    ///           receives the glyph data. The surface must be part of a texture.
    ///    pSrcRectDescs = Type: <b>IDirect3DVertexBuffer9*</b> A pointer to a vertex buffer (see IDirect3DVertexBuffer9) containing
    ///                    rectangles (see D3DCOMPOSERECTDESC) that enclose the desired glyphs in the source surface.
    ///    NumRects = Type: <b>UINT</b> The number of rectangles or glyphs that are used in the operation. The number applies to
    ///               both the source and destination surfaces. The range is 0 to D3DCOMPOSERECTS_MAXNUMRECTS.
    ///    pDstRectDescs = Type: <b>IDirect3DVertexBuffer9*</b> A pointer to a vertex buffer (see IDirect3DVertexBuffer9) containing
    ///                    rectangles (see D3DCOMPOSERECTDESTINATION) that describe the destination to which the indicated glyph from
    ///                    the source surface will be copied.
    ///    Operation = Type: <b>D3DCOMPOSERECTSOP</b> Specifies how to combine the source and destination surfaces. See
    ///                D3DCOMPOSERECTSOP.
    ///    Xoffset = Type: <b>INT</b> A value added to the <i>x</i> coordinates of all destination rectangles. This value can be
    ///              negative, which may cause the glyph to be rejected or clipped if the result is beyond the bounds of the
    ///              surface.
    ///    Yoffset = Type: <b>INT</b> A value added to the <i>y</i> coordinates of all destination rectangles. This value can be
    ///              negative, which may cause the glyph to be rejected or clipped if the result is beyond the bounds of the
    ///              surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK.
    ///    
    HRESULT ComposeRects(IDirect3DSurface9 pSrc, IDirect3DSurface9 pDst, IDirect3DVertexBuffer9 pSrcRectDescs, 
                         uint NumRects, IDirect3DVertexBuffer9 pDstRectDescs, D3DCOMPOSERECTSOP Operation, 
                         int Xoffset, int Yoffset);
    ///Swap the swapchain's next buffer with the front buffer.
    ///Params:
    ///    pSourceRect = Type: <b>const RECT*</b> Pointer to a RECT structure indicating region on the source surface to copy in
    ///                  window client coordinates. Only applies when the swapchain was created with the D3DSWAPEFFECT_COPY flag. If
    ///                  <b>NULL</b>, the entire source surface is presented. If the rectangle exceeds the source surface, it is
    ///                  clipped to the source surface.
    ///    pDestRect = Type: <b>const RECT*</b> Pointer to RECT structure indicating the target region on the destination surface in
    ///                window client coordinates. Only applies when the swapchain was created with the D3DSWAPEFFECT_COPY flag. If
    ///                <b>NULL</b>, the entire client area is filled. If the rectangle exceeds the destination client area, it is
    ///                clipped to the destination client area.
    ///    hDestWindowOverride = Type: <b>HWND</b> Pointer to a destination window whose client area is taken as the target for this
    ///                          presentation. If this value is <b>NULL</b>, the runtime uses the <b>hDeviceWindow</b> member of
    ///                          D3DPRESENT_PARAMETERS for the presentation. <div class="alert"><b>Note</b> If you create a swap chain with
    ///                          D3DSWAPEFFECT_FLIPEX, you must pass <b>NULL</b> to <i>hDestWindowOverride</i></div> <div> </div>
    ///    pDirtyRegion = Type: <b>const RGNDATA*</b> Pointer to a RGNDATA structure indicating the smallest set of pixels that need to
    ///                   be transferred. This value must be <b>NULL</b> unless the swapchain was created with the D3DSWAPEFFECT_COPY
    ///                   flag. For more information about swapchains, see Flipping Surfaces (Direct3D 9). If this value is
    ///                   non-<b>NULL</b>, the contained region is expressed in back buffer coordinates. The method takes these
    ///                   rectangles into account when optimizing the presentation by copying only the pixels within the region, or
    ///                   some suitably expanded set of rectangles. This is an aid to optimization only, and the application should not
    ///                   rely on the region being copied exactly. The implementation can choose to copy the whole source rectangle.
    ///    dwFlags = Type: <b>DWORD</b> Allows the application to request that the method return immediately when the driver
    ///              reports that it cannot schedule a presentation. Valid values are 0, or any combination of D3DPRESENT flags.
    ///              <ul> <li>If dwFlags = 0, this method behaves as it did prior to Direct3D 9. Present will spin until the
    ///              hardware is free, without returning an error.</li> <li>If dwFlags = D3DPRESENT_DONOTFLIP the display driver
    ///              is called with the front buffer as both the source and target surface. The driver responds by scheduling a
    ///              frame synch, but not changing the displayed surface. This flag is only available in full-screen mode or when
    ///              using D3DSWAPEFFECT_FLIPEX in windowed mode.</li> <li>If dwFlags = D3DPRESENT_DONOTWAIT, and the hardware is
    ///              busy processing or waiting for a vertical sync interval, the method will return D3DERR_WASSTILLDRAWING.</li>
    ///              <li>If dwFlags = D3DPRESENT_FORCEIMMEDIATE, D3DPRESENT_INTERVAL_IMMEDIATE is enforced on this Present call.
    ///              This flag can only be specified when using D3DSWAPEFFECT_FLIPEX. This behavior is the same for windowed and
    ///              full-screen modes.</li> <li>If dwFlags = D3DPRESENT_LINEAR_CONTENT, gamma correction is performed from linear
    ///              space to sRGB for windowed swap chains. This flag will take effect only when the driver exposes
    ///              D3DCAPS3_LINEAR_TO_SRGB_PRESENTATION (see Gamma (Direct3D 9)).</li> </ul>
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: S_OK, D3DERR_DEVICELOST, D3DERR_DEVICEHUNG,
    ///    D3DERR_DEVICEREMOVED, or D3DERR_OUTOFVIDEOMEMORY (see D3DERR). See Lost Device Behavior Changes for more
    ///    information about lost, hung, and removed devices. <table> <tr> <td> Differences between Direct3D 9 and
    ///    Direct3D 9Ex: D3DSWAPEFFECT_FLIPEX is only available in Direct3D9Ex running on Windows 7 (or more current
    ///    operating system). </td> </tr> </table>
    ///    
    HRESULT PresentEx(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, 
                      const(RGNDATA)* pDirtyRegion, uint dwFlags);
    ///Get the priority of the GPU thread.
    ///Params:
    ///    pPriority = Type: <b>INT*</b> Current GPU priority. Valid values range from -7 to 7.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK or D3DERR_DEVICEREMOVED (see D3DERR).
    ///    
    HRESULT GetGPUThreadPriority(int* pPriority);
    ///Set the priority on the GPU thread.
    ///Params:
    ///    Priority = Type: <b>INT</b> The thread priority, ranging from -7 to 7.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK, D3DERR_INVALIDCALL, or D3DERR_DEVICEREMOVED (see
    ///    D3DERR).
    ///    
    HRESULT SetGPUThreadPriority(int Priority);
    ///Suspend execution of the calling thread until the next vertical blank signal.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> Swap chain index. This is an optional, zero-based index used to specify a swap chain on a
    ///                 multihead card.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method will always return D3D_OK.
    ///    
    HRESULT WaitForVBlank(uint iSwapChain);
    ///Checks an array of resources to determine if it is likely that they will cause a large stall at Draw time because
    ///the system must make the resources GPU-accessible.
    ///Params:
    ///    pResourceArray = Type: <b>IDirect3DResource9**</b> An array of IDirect3DResource9 pointers that indicate the resources to
    ///                     check.
    ///    NumResources = Type: <b>UINT32</b> A value indicating the number of resources passed into the <i>pResourceArray</i>
    ///                   parameter up to a maximum of 65535.
    ///Returns:
    ///    Type: <b>HRESULT</b> If all the resources are in GPU-accessible memory, the method will return S_OK. The
    ///    system may need to perform a remapping operation to promote the resources, but will not have to copy data. If
    ///    no allocation that comprises the resources is on disk, but at least one allocation is not in GPU-accessible
    ///    memory, the method will return S_RESIDENT_IN_SHARED_MEMORY. The system may need to perform a copy to promote
    ///    the resource. If at least one allocation that comprises the resources is on disk, this method will return
    ///    S_NOT_RESIDENT. The system may need to perform a copy to promote the resource.
    ///    
    HRESULT CheckResourceResidency(IDirect3DResource9* pResourceArray, uint NumResources);
    ///Set the number of frames that the system is allowed to queue for rendering.
    ///Params:
    ///    MaxLatency = Type: <b>UINT</b> The maximum number of back buffer frames that a driver can queue. The value is typically 3,
    ///                 but can range from 1 to 20. A value of 0 will reset latency to the default. For multi-head devices,
    ///                 <i>MaxLatency</i> is specified per-head.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK or D3DERR_DEVICEREMOVED (see D3DERR).
    ///    
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
    ///Retrieves the number of frames of data that the system is allowed to queue.
    ///Params:
    ///    pMaxLatency = Type: <b>UINT*</b> Returns the number of frames that can be queued for render. The value is typically 3, but
    ///                  can range from 1 to 20.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK, D3DERR_DEVICELOST, D3DERR_DEVICEREMOVED,
    ///    D3DERR_DRIVERINTERNALERROR, D3DERR_INVALIDCALL, or D3DERR_OUTOFVIDEOMEMORY (see D3DERR).
    ///    
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
    ///Reports the current cooperative-level status of the Direct3D device for a windowed or full-screen application.
    ///Params:
    ///    hDestinationWindow = Type: <b>HWND</b> The destination window handle to check for occlusion. When this parameter is <b>NULL</b>,
    ///                         S_PRESENT_OCCLUDED is returned when another device has fullscreen ownership. When the window handle is not
    ///                         <b>NULL</b>, window's client area is checked for occlusion. A window is occluded if any part of it is
    ///                         obscured by another application.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK, D3DERR_DEVICELOST, D3DERR_DEVICEHUNG,
    ///    D3DERR_DEVICEREMOVED, or D3DERR_OUTOFVIDEOMEMORY (see D3DERR), or S_PRESENT_MODE_CHANGED, or
    ///    S_PRESENT_OCCLUDED (see S_PRESENT).
    ///    
    HRESULT CheckDeviceState(HWND hDestinationWindow);
    ///Creates a render-target surface.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the render-target surface, in pixels.
    ///    Height = Type: <b>UINT</b> Height of the render-target surface, in pixels.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the render target.
    ///    MultiSample = Type: <b>D3DMULTISAMPLE_TYPE</b> Member of the D3DMULTISAMPLE_TYPE enumerated type, which describes the
    ///                  multisampling buffer type. This parameter specifies the antialiasing type for this render target. When this
    ///                  surface is passed to IDirect3DDevice9::SetRenderTarget, its multisample type must be the same as that of the
    ///                  depth-stencil set by IDirect3DDevice9::SetDepthStencilSurface.
    ///    MultisampleQuality = Type: <b>DWORD</b> Quality level. The valid range is between zero and one less than the level returned by
    ///                         pQualityLevels used by IDirect3D9::CheckDeviceMultiSampleType. Passing a larger value returns the error,
    ///                         D3DERR_INVALIDCALL. The MultisampleQuality values of paired render targets, depth stencil surfaces, and the
    ///                         multisample type must all match.
    ///    Lockable = Type: <b>BOOL</b> Render targets are not lockable unless the application specifies <b>TRUE</b> for Lockable.
    ///               Note that lockable render targets reduce performance on some graphics hardware. The readback performance
    ///               (moving data from video memory to system memory) depends on the type of hardware used (AGP vs. PCI Express)
    ///               and is usually far lower than upload performance (moving data from system to video memory). If you need read
    ///               access to render targets, use GetRenderTargetData instead of lockable render targets.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///    Usage = Type: <b>DWORD</b> Combination of one or more D3DUSAGE constants which can be OR'd together. Value of 0
    ///            indicates no usage.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_NOTAVAILABLE, D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY,
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT CreateRenderTargetEx(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                                 uint MultisampleQuality, BOOL Lockable, IDirect3DSurface9* ppSurface, 
                                 HANDLE* pSharedHandle, uint Usage);
    ///Create an off-screen surface.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the surface.
    ///    Height = Type: <b>UINT</b> Height of the surface.
    ///    Format = Type: <b>D3DFORMAT</b> Format of the surface. See D3DFORMAT.
    ///    Pool = Type: <b>D3DPOOL</b> Surface pool type. See D3DPOOL.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Pointer to the IDirect3DSurface9 interface created.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///    Usage = Type: <b>DWORD</b> Combination of one or more D3DUSAGE constants which can be OR'd together. Value of 0
    ///            indicates no usage.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT CreateOffscreenPlainSurfaceEx(uint Width, uint Height, D3DFORMAT Format, D3DPOOL Pool, 
                                          IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle, uint Usage);
    ///Creates a depth-stencil surface.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the depth-stencil surface, in pixels.
    ///    Height = Type: <b>UINT</b> Height of the depth-stencil surface, in pixels.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the depth-stencil
    ///             surface. This value must be one of the enumerated depth-stencil formats for this device.
    ///    MultiSample = Type: <b>D3DMULTISAMPLE_TYPE</b> Member of the D3DMULTISAMPLE_TYPE enumerated type, describing the
    ///                  multisampling buffer type. This value must be one of the allowed multisample types. When this surface is
    ///                  passed to IDirect3DDevice9::SetDepthStencilSurface, its multisample type must be the same as that of the
    ///                  render target set by IDirect3DDevice9::SetRenderTarget.
    ///    MultisampleQuality = Type: <b>DWORD</b> Quality level. The valid range is between zero and one less than the level returned by
    ///                         pQualityLevels used by IDirect3D9::CheckDeviceMultiSampleType. Passing a larger value returns the error
    ///                         D3DERR_INVALIDCALL. The MultisampleQuality values of paired render targets, depth stencil surfaces, and the
    ///                         MultiSample type must all match.
    ///    Discard = Type: <b>BOOL</b> Set this flag to <b>TRUE</b> to enable z-buffer discarding, and <b>FALSE</b> otherwise. If
    ///              this flag is set, the contents of the depth stencil buffer will be invalid after calling either
    ///              IDirect3DDevice9::Present or IDirect3DDevice9::SetDepthStencilSurface with a different depth surface. This
    ///              flag has the same behavior as the constant, D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL, in D3DPRESENTFLAG.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                created depth-stencil surface resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///    Usage = Type: <b>DWORD</b> Combination of one or more D3DUSAGE constants which can be OR'd together. Value of 0
    ///            indicates no usage.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_NOTAVAILABLE, D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY,
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT CreateDepthStencilSurfaceEx(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                                        uint MultisampleQuality, BOOL Discard, IDirect3DSurface9* ppSurface, 
                                        HANDLE* pSharedHandle, uint Usage);
    ///Resets the type, size, and format of the swap chain with all other surfaces persistent.
    ///Params:
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to a D3DPRESENT_PARAMETERS structure, describing the new
    ///                              presentation parameters. This value cannot be <b>NULL</b>. When switching to full-screen mode, Direct3D will
    ///                              try to find a desktop format that matches the back buffer format, so that back buffer and front buffer
    ///                              formats will be identical (to eliminate the need for color conversion). When this method returns: <ul>
    ///                              <li>BackBufferCount, BackBufferWidth, and BackBufferHeight are set to zero.</li> <li>BackBufferFormat is set
    ///                              to D3DFORMAT for windowed mode only; a full-screen mode must specify a format.</li> </ul>
    ///    pFullscreenDisplayMode = Type: <b>D3DDISPLAYMODEEX*</b> Pointer to a D3DDISPLAYMODEEX structure that describes the properties of the
    ///                             desired display mode. This value must be provided for fullscreen applications, but can be <b>NULL</b> for
    ///                             windowed applications.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method can return: D3D_OK, D3DERR_DEVICELOST or D3DERR_DEVICEHUNG (see D3DERR). If
    ///    this method returns D3DERR_DEVICELOST or D3DERR_DEVICEHUNG then the application can only call
    ///    <b>IDirect3DDevice9Ex::ResetEx</b>, IDirect3DDevice9Ex::CheckDeviceState or release the interface pointer;
    ///    any other API call will cause an exception.
    ///    
    HRESULT ResetEx(D3DPRESENT_PARAMETERS* pPresentationParameters, D3DDISPLAYMODEEX* pFullscreenDisplayMode);
    ///Retrieves the display mode's spatial resolution, color resolution, refresh frequency, and rotation settings.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    pMode = Type: <b>D3DDISPLAYMODEEX*</b> Pointer to a D3DDISPLAYMODEEX structure containing data about the display mode
    ///            of the adapter. As opposed to the display mode of the device, which may not be active if the device does not
    ///            own full-screen mode. Can be set to <b>NULL</b>.
    ///    pRotation = Type: <b>D3DDISPLAYROTATION*</b> Pointer to a D3DDISPLAYROTATION indicating the type of screen rotation the
    ///                application will do. The value returned through this pointer is important when the
    ///                D3DPRESENTFLAG_NOAUTOROTATE flag is used; otherwise, it can be set to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDisplayModeEx(uint iSwapChain, D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
}

///Applications use the methods of the <b>IDirect3DSwapChain9Ex</b> interface to manipulate a swap chain.
@GUID("91886CAF-1C3D-4D2E-A0AB-3E4C7D8D3303")
interface IDirect3DSwapChain9Ex : IDirect3DSwapChain9
{
    ///Returns the number of times the swapchain has been processed.
    ///Params:
    ///    pLastPresentCount = Type: <b>UINT*</b> Pointer to a UINT to be filled with the number of times the IDirect3DDevice9Ex::PresentEx
    ///                        method has been called. The count will also be incremented by calling some other APIs such as
    ///                        IDirect3DDevice9::SetDialogBoxMode.
    ///Returns:
    ///    Type: <b>HRESULT</b> S_OK the method was successful.
    ///    
    HRESULT GetLastPresentCount(uint* pLastPresentCount);
    HRESULT GetPresentStats(D3DPRESENTSTATS* pPresentationStatistics);
    ///Retrieves the display mode's spatial resolution, color resolution, refresh frequency, and rotation settings.
    ///Params:
    ///    pMode = Type: <b>D3DDISPLAYMODEEX*</b> Pointer to a D3DDISPLAYMODEEX structure containing data about the display mode
    ///            of the adapter. As opposed to the display mode of the device, which may not be active if the device does not
    ///            own full-screen mode.
    ///    pRotation = Type: <b>D3DDISPLAYROTATION*</b> Pointer to a D3DDISPLAYROTATION indicating the type of screen rotation the
    ///                application will do. The value returned through this pointer is important when the
    ///                D3DPRESENTFLAG_NOAUTOROTATE flag is used; otherwise, it can be set to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDisplayModeEx(D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
}


// GUIDs


const GUID IID_IDirect3D9                  = GUIDOF!IDirect3D9;
const GUID IID_IDirect3D9Ex                = GUIDOF!IDirect3D9Ex;
const GUID IID_IDirect3DBaseTexture9       = GUIDOF!IDirect3DBaseTexture9;
const GUID IID_IDirect3DCubeTexture9       = GUIDOF!IDirect3DCubeTexture9;
const GUID IID_IDirect3DDevice9            = GUIDOF!IDirect3DDevice9;
const GUID IID_IDirect3DDevice9Ex          = GUIDOF!IDirect3DDevice9Ex;
const GUID IID_IDirect3DIndexBuffer9       = GUIDOF!IDirect3DIndexBuffer9;
const GUID IID_IDirect3DPixelShader9       = GUIDOF!IDirect3DPixelShader9;
const GUID IID_IDirect3DQuery9             = GUIDOF!IDirect3DQuery9;
const GUID IID_IDirect3DResource9          = GUIDOF!IDirect3DResource9;
const GUID IID_IDirect3DStateBlock9        = GUIDOF!IDirect3DStateBlock9;
const GUID IID_IDirect3DSurface9           = GUIDOF!IDirect3DSurface9;
const GUID IID_IDirect3DSwapChain9         = GUIDOF!IDirect3DSwapChain9;
const GUID IID_IDirect3DSwapChain9Ex       = GUIDOF!IDirect3DSwapChain9Ex;
const GUID IID_IDirect3DTexture9           = GUIDOF!IDirect3DTexture9;
const GUID IID_IDirect3DVertexBuffer9      = GUIDOF!IDirect3DVertexBuffer9;
const GUID IID_IDirect3DVertexDeclaration9 = GUIDOF!IDirect3DVertexDeclaration9;
const GUID IID_IDirect3DVertexShader9      = GUIDOF!IDirect3DVertexShader9;
const GUID IID_IDirect3DVolume9            = GUIDOF!IDirect3DVolume9;
const GUID IID_IDirect3DVolumeTexture9     = GUIDOF!IDirect3DVolumeTexture9;
