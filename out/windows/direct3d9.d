// Written in the D programming language.

module windows.direct3d9;

public import windows.core;
public import windows.com : HRESULT;
public import windows.dxgi : DXGI_RGBA;
public import windows.systemservices : BOOL, D3DLIGHTTYPE, D3DVECTOR, HANDLE,
                                       LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;

extern(Windows):


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

struct _D3DPRESENT_PARAMETERS_
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

// Functions

@DllImport("d3d9")
int D3DPERF_BeginEvent(uint col, const(wchar)* wszName);

@DllImport("d3d9")
int D3DPERF_EndEvent();

@DllImport("d3d9")
void D3DPERF_SetMarker(uint col, const(wchar)* wszName);

@DllImport("d3d9")
void D3DPERF_SetRegion(uint col, const(wchar)* wszName);

@DllImport("d3d9")
BOOL D3DPERF_QueryRepeatFrame();

@DllImport("d3d9")
void D3DPERF_SetOptions(uint dwOptions);

@DllImport("d3d9")
uint D3DPERF_GetStatus();


