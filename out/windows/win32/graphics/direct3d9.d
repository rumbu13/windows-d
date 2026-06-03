// Written in the D programming language.

module windows.win32.graphics.direct3d9;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, HANDLE, HRESULT, HWND, LUID,
                                         POINT, PSTR, PWSTR, RECT;
public import windows.win32.graphics.direct3d : D3DMATRIX, D3DVECTOR;
public import windows.win32.graphics.directdraw : DDPIXELFORMAT, DDSURFACEDESC;
public import windows.win32.graphics.gdi : HDC, HMONITOR, PALETTEENTRY, RGNDATA;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dlighttype
alias D3DLIGHTTYPE = int;
enum : int
{
    D3DLIGHT_POINT       = 0x00000001,
    D3DLIGHT_SPOT        = 0x00000002,
    D3DLIGHT_DIRECTIONAL = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dshademode
alias D3DSHADEMODE = int;
enum : int
{
    D3DSHADE_FLAT    = 0x00000001,
    D3DSHADE_GOURAUD = 0x00000002,
    D3DSHADE_PHONG   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dfillmode
alias D3DFILLMODE = int;
enum : int
{
    D3DFILL_POINT     = 0x00000001,
    D3DFILL_WIREFRAME = 0x00000002,
    D3DFILL_SOLID     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dblend
alias D3DBLEND = int;
enum : int
{
    D3DBLEND_ZERO            = 0x00000001,
    D3DBLEND_ONE             = 0x00000002,
    D3DBLEND_SRCCOLOR        = 0x00000003,
    D3DBLEND_INVSRCCOLOR     = 0x00000004,
    D3DBLEND_SRCALPHA        = 0x00000005,
    D3DBLEND_INVSRCALPHA     = 0x00000006,
    D3DBLEND_DESTALPHA       = 0x00000007,
    D3DBLEND_INVDESTALPHA    = 0x00000008,
    D3DBLEND_DESTCOLOR       = 0x00000009,
    D3DBLEND_INVDESTCOLOR    = 0x0000000a,
    D3DBLEND_SRCALPHASAT     = 0x0000000b,
    D3DBLEND_BOTHSRCALPHA    = 0x0000000c,
    D3DBLEND_BOTHINVSRCALPHA = 0x0000000d,
    D3DBLEND_BLENDFACTOR     = 0x0000000e,
    D3DBLEND_INVBLENDFACTOR  = 0x0000000f,
    D3DBLEND_SRCCOLOR2       = 0x00000010,
    D3DBLEND_INVSRCCOLOR2    = 0x00000011,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dblendop
alias D3DBLENDOP = int;
enum : int
{
    D3DBLENDOP_ADD         = 0x00000001,
    D3DBLENDOP_SUBTRACT    = 0x00000002,
    D3DBLENDOP_REVSUBTRACT = 0x00000003,
    D3DBLENDOP_MIN         = 0x00000004,
    D3DBLENDOP_MAX         = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dtextureaddress
alias D3DTEXTUREADDRESS = int;
enum : int
{
    D3DTADDRESS_WRAP       = 0x00000001,
    D3DTADDRESS_MIRROR     = 0x00000002,
    D3DTADDRESS_CLAMP      = 0x00000003,
    D3DTADDRESS_BORDER     = 0x00000004,
    D3DTADDRESS_MIRRORONCE = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dcull
alias D3DCULL = int;
enum : int
{
    D3DCULL_NONE = 0x00000001,
    D3DCULL_CW   = 0x00000002,
    D3DCULL_CCW  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dcmpfunc
alias D3DCMPFUNC = int;
enum : int
{
    D3DCMP_NEVER        = 0x00000001,
    D3DCMP_LESS         = 0x00000002,
    D3DCMP_EQUAL        = 0x00000003,
    D3DCMP_LESSEQUAL    = 0x00000004,
    D3DCMP_GREATER      = 0x00000005,
    D3DCMP_NOTEQUAL     = 0x00000006,
    D3DCMP_GREATEREQUAL = 0x00000007,
    D3DCMP_ALWAYS       = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dstencilop
alias D3DSTENCILOP = int;
enum : int
{
    D3DSTENCILOP_KEEP    = 0x00000001,
    D3DSTENCILOP_ZERO    = 0x00000002,
    D3DSTENCILOP_REPLACE = 0x00000003,
    D3DSTENCILOP_INCRSAT = 0x00000004,
    D3DSTENCILOP_DECRSAT = 0x00000005,
    D3DSTENCILOP_INVERT  = 0x00000006,
    D3DSTENCILOP_INCR    = 0x00000007,
    D3DSTENCILOP_DECR    = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dfogmode
alias D3DFOGMODE = int;
enum : int
{
    D3DFOG_NONE   = 0x00000000,
    D3DFOG_EXP    = 0x00000001,
    D3DFOG_EXP2   = 0x00000002,
    D3DFOG_LINEAR = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dzbuffertype
alias D3DZBUFFERTYPE = int;
enum : int
{
    D3DZB_FALSE = 0x00000000,
    D3DZB_TRUE  = 0x00000001,
    D3DZB_USEW  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dprimitivetype
alias D3DPRIMITIVETYPE = int;
enum : int
{
    D3DPT_POINTLIST     = 0x00000001,
    D3DPT_LINELIST      = 0x00000002,
    D3DPT_LINESTRIP     = 0x00000003,
    D3DPT_TRIANGLELIST  = 0x00000004,
    D3DPT_TRIANGLESTRIP = 0x00000005,
    D3DPT_TRIANGLEFAN   = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dtransformstatetype
alias D3DTRANSFORMSTATETYPE = int;
enum : int
{
    D3DTS_VIEW       = 0x00000002,
    D3DTS_PROJECTION = 0x00000003,
    D3DTS_TEXTURE0   = 0x00000010,
    D3DTS_TEXTURE1   = 0x00000011,
    D3DTS_TEXTURE2   = 0x00000012,
    D3DTS_TEXTURE3   = 0x00000013,
    D3DTS_TEXTURE4   = 0x00000014,
    D3DTS_TEXTURE5   = 0x00000015,
    D3DTS_TEXTURE6   = 0x00000016,
    D3DTS_TEXTURE7   = 0x00000017,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3drenderstatetype
alias D3DRENDERSTATETYPE = int;
enum : int
{
    D3DRS_ZENABLE                    = 0x00000007,
    D3DRS_FILLMODE                   = 0x00000008,
    D3DRS_SHADEMODE                  = 0x00000009,
    D3DRS_ZWRITEENABLE               = 0x0000000e,
    D3DRS_ALPHATESTENABLE            = 0x0000000f,
    D3DRS_LASTPIXEL                  = 0x00000010,
    D3DRS_SRCBLEND                   = 0x00000013,
    D3DRS_DESTBLEND                  = 0x00000014,
    D3DRS_CULLMODE                   = 0x00000016,
    D3DRS_ZFUNC                      = 0x00000017,
    D3DRS_ALPHAREF                   = 0x00000018,
    D3DRS_ALPHAFUNC                  = 0x00000019,
    D3DRS_DITHERENABLE               = 0x0000001a,
    D3DRS_ALPHABLENDENABLE           = 0x0000001b,
    D3DRS_FOGENABLE                  = 0x0000001c,
    D3DRS_SPECULARENABLE             = 0x0000001d,
    D3DRS_FOGCOLOR                   = 0x00000022,
    D3DRS_FOGTABLEMODE               = 0x00000023,
    D3DRS_FOGSTART                   = 0x00000024,
    D3DRS_FOGEND                     = 0x00000025,
    D3DRS_FOGDENSITY                 = 0x00000026,
    D3DRS_RANGEFOGENABLE             = 0x00000030,
    D3DRS_STENCILENABLE              = 0x00000034,
    D3DRS_STENCILFAIL                = 0x00000035,
    D3DRS_STENCILZFAIL               = 0x00000036,
    D3DRS_STENCILPASS                = 0x00000037,
    D3DRS_STENCILFUNC                = 0x00000038,
    D3DRS_STENCILREF                 = 0x00000039,
    D3DRS_STENCILMASK                = 0x0000003a,
    D3DRS_STENCILWRITEMASK           = 0x0000003b,
    D3DRS_TEXTUREFACTOR              = 0x0000003c,
    D3DRS_WRAP0                      = 0x00000080,
    D3DRS_WRAP1                      = 0x00000081,
    D3DRS_WRAP2                      = 0x00000082,
    D3DRS_WRAP3                      = 0x00000083,
    D3DRS_WRAP4                      = 0x00000084,
    D3DRS_WRAP5                      = 0x00000085,
    D3DRS_WRAP6                      = 0x00000086,
    D3DRS_WRAP7                      = 0x00000087,
    D3DRS_CLIPPING                   = 0x00000088,
    D3DRS_LIGHTING                   = 0x00000089,
    D3DRS_AMBIENT                    = 0x0000008b,
    D3DRS_FOGVERTEXMODE              = 0x0000008c,
    D3DRS_COLORVERTEX                = 0x0000008d,
    D3DRS_LOCALVIEWER                = 0x0000008e,
    D3DRS_NORMALIZENORMALS           = 0x0000008f,
    D3DRS_DIFFUSEMATERIALSOURCE      = 0x00000091,
    D3DRS_SPECULARMATERIALSOURCE     = 0x00000092,
    D3DRS_AMBIENTMATERIALSOURCE      = 0x00000093,
    D3DRS_EMISSIVEMATERIALSOURCE     = 0x00000094,
    D3DRS_VERTEXBLEND                = 0x00000097,
    D3DRS_CLIPPLANEENABLE            = 0x00000098,
    D3DRS_POINTSIZE                  = 0x0000009a,
    D3DRS_POINTSIZE_MIN              = 0x0000009b,
    D3DRS_POINTSPRITEENABLE          = 0x0000009c,
    D3DRS_POINTSCALEENABLE           = 0x0000009d,
    D3DRS_POINTSCALE_A               = 0x0000009e,
    D3DRS_POINTSCALE_B               = 0x0000009f,
    D3DRS_POINTSCALE_C               = 0x000000a0,
    D3DRS_MULTISAMPLEANTIALIAS       = 0x000000a1,
    D3DRS_MULTISAMPLEMASK            = 0x000000a2,
    D3DRS_PATCHEDGESTYLE             = 0x000000a3,
    D3DRS_DEBUGMONITORTOKEN          = 0x000000a5,
    D3DRS_POINTSIZE_MAX              = 0x000000a6,
    D3DRS_INDEXEDVERTEXBLENDENABLE   = 0x000000a7,
    D3DRS_COLORWRITEENABLE           = 0x000000a8,
    D3DRS_TWEENFACTOR                = 0x000000aa,
    D3DRS_BLENDOP                    = 0x000000ab,
    D3DRS_POSITIONDEGREE             = 0x000000ac,
    D3DRS_NORMALDEGREE               = 0x000000ad,
    D3DRS_SCISSORTESTENABLE          = 0x000000ae,
    D3DRS_SLOPESCALEDEPTHBIAS        = 0x000000af,
    D3DRS_ANTIALIASEDLINEENABLE      = 0x000000b0,
    D3DRS_MINTESSELLATIONLEVEL       = 0x000000b2,
    D3DRS_MAXTESSELLATIONLEVEL       = 0x000000b3,
    D3DRS_ADAPTIVETESS_X             = 0x000000b4,
    D3DRS_ADAPTIVETESS_Y             = 0x000000b5,
    D3DRS_ADAPTIVETESS_Z             = 0x000000b6,
    D3DRS_ADAPTIVETESS_W             = 0x000000b7,
    D3DRS_ENABLEADAPTIVETESSELLATION = 0x000000b8,
    D3DRS_TWOSIDEDSTENCILMODE        = 0x000000b9,
    D3DRS_CCW_STENCILFAIL            = 0x000000ba,
    D3DRS_CCW_STENCILZFAIL           = 0x000000bb,
    D3DRS_CCW_STENCILPASS            = 0x000000bc,
    D3DRS_CCW_STENCILFUNC            = 0x000000bd,
    D3DRS_COLORWRITEENABLE1          = 0x000000be,
    D3DRS_COLORWRITEENABLE2          = 0x000000bf,
    D3DRS_COLORWRITEENABLE3          = 0x000000c0,
    D3DRS_BLENDFACTOR                = 0x000000c1,
    D3DRS_SRGBWRITEENABLE            = 0x000000c2,
    D3DRS_DEPTHBIAS                  = 0x000000c3,
    D3DRS_WRAP8                      = 0x000000c6,
    D3DRS_WRAP9                      = 0x000000c7,
    D3DRS_WRAP10                     = 0x000000c8,
    D3DRS_WRAP11                     = 0x000000c9,
    D3DRS_WRAP12                     = 0x000000ca,
    D3DRS_WRAP13                     = 0x000000cb,
    D3DRS_WRAP14                     = 0x000000cc,
    D3DRS_WRAP15                     = 0x000000cd,
    D3DRS_SEPARATEALPHABLENDENABLE   = 0x000000ce,
    D3DRS_SRCBLENDALPHA              = 0x000000cf,
    D3DRS_DESTBLENDALPHA             = 0x000000d0,
    D3DRS_BLENDOPALPHA               = 0x000000d1,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dmaterialcolorsource
alias D3DMATERIALCOLORSOURCE = int;
enum : int
{
    D3DMCS_MATERIAL = 0x00000000,
    D3DMCS_COLOR1   = 0x00000001,
    D3DMCS_COLOR2   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dtexturestagestatetype
alias D3DTEXTURESTAGESTATETYPE = int;
enum : int
{
    D3DTSS_COLOROP               = 0x00000001,
    D3DTSS_COLORARG1             = 0x00000002,
    D3DTSS_COLORARG2             = 0x00000003,
    D3DTSS_ALPHAOP               = 0x00000004,
    D3DTSS_ALPHAARG1             = 0x00000005,
    D3DTSS_ALPHAARG2             = 0x00000006,
    D3DTSS_BUMPENVMAT00          = 0x00000007,
    D3DTSS_BUMPENVMAT01          = 0x00000008,
    D3DTSS_BUMPENVMAT10          = 0x00000009,
    D3DTSS_BUMPENVMAT11          = 0x0000000a,
    D3DTSS_TEXCOORDINDEX         = 0x0000000b,
    D3DTSS_BUMPENVLSCALE         = 0x00000016,
    D3DTSS_BUMPENVLOFFSET        = 0x00000017,
    D3DTSS_TEXTURETRANSFORMFLAGS = 0x00000018,
    D3DTSS_COLORARG0             = 0x0000001a,
    D3DTSS_ALPHAARG0             = 0x0000001b,
    D3DTSS_RESULTARG             = 0x0000001c,
    D3DTSS_CONSTANT              = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dsamplerstatetype
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
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dtextureop
alias D3DTEXTUREOP = int;
enum : int
{
    D3DTOP_DISABLE                   = 0x00000001,
    D3DTOP_SELECTARG1                = 0x00000002,
    D3DTOP_SELECTARG2                = 0x00000003,
    D3DTOP_MODULATE                  = 0x00000004,
    D3DTOP_MODULATE2X                = 0x00000005,
    D3DTOP_MODULATE4X                = 0x00000006,
    D3DTOP_ADD                       = 0x00000007,
    D3DTOP_ADDSIGNED                 = 0x00000008,
    D3DTOP_ADDSIGNED2X               = 0x00000009,
    D3DTOP_SUBTRACT                  = 0x0000000a,
    D3DTOP_ADDSMOOTH                 = 0x0000000b,
    D3DTOP_BLENDDIFFUSEALPHA         = 0x0000000c,
    D3DTOP_BLENDTEXTUREALPHA         = 0x0000000d,
    D3DTOP_BLENDFACTORALPHA          = 0x0000000e,
    D3DTOP_BLENDTEXTUREALPHAPM       = 0x0000000f,
    D3DTOP_BLENDCURRENTALPHA         = 0x00000010,
    D3DTOP_PREMODULATE               = 0x00000011,
    D3DTOP_MODULATEALPHA_ADDCOLOR    = 0x00000012,
    D3DTOP_MODULATECOLOR_ADDALPHA    = 0x00000013,
    D3DTOP_MODULATEINVALPHA_ADDCOLOR = 0x00000014,
    D3DTOP_MODULATEINVCOLOR_ADDALPHA = 0x00000015,
    D3DTOP_BUMPENVMAP                = 0x00000016,
    D3DTOP_BUMPENVMAPLUMINANCE       = 0x00000017,
    D3DTOP_DOTPRODUCT3               = 0x00000018,
    D3DTOP_MULTIPLYADD               = 0x00000019,
    D3DTOP_LERP                      = 0x0000001a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dtexturefiltertype
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
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddeclusage
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddeclmethod
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddecltype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dsampler-texture-type
alias D3DSAMPLER_TEXTURE_TYPE = int;
enum : int
{
    D3DSTT_UNKNOWN = 0x00000000,
    D3DSTT_2D      = 0x10000000,
    D3DSTT_CUBE    = 0x18000000,
    D3DSTT_VOLUME  = 0x20000000,
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
    D3DSRO_POSITION   = 0x00000000,
    D3DSRO_FOG        = 0x00000001,
    D3DSRO_POINT_SIZE = 0x00000002,
}

alias D3DVS_ADDRESSMODE_TYPE = int;
enum : int
{
    D3DVS_ADDRMODE_ABSOLUTE = 0x00000000,
    D3DVS_ADDRMODE_RELATIVE = 0x00002000,
}

alias D3DSHADER_ADDRESSMODE_TYPE = int;
enum : int
{
    D3DSHADER_ADDRMODE_ABSOLUTE = 0x00000000,
    D3DSHADER_ADDRMODE_RELATIVE = 0x00002000,
}

alias D3DSHADER_PARAM_SRCMOD_TYPE = int;
enum : int
{
    D3DSPSM_NONE    = 0x00000000,
    D3DSPSM_NEG     = 0x01000000,
    D3DSPSM_BIAS    = 0x02000000,
    D3DSPSM_BIASNEG = 0x03000000,
    D3DSPSM_SIGN    = 0x04000000,
    D3DSPSM_SIGNNEG = 0x05000000,
    D3DSPSM_COMP    = 0x06000000,
    D3DSPSM_X2      = 0x07000000,
    D3DSPSM_X2NEG   = 0x08000000,
    D3DSPSM_DZ      = 0x09000000,
    D3DSPSM_DW      = 0x0a000000,
    D3DSPSM_ABS     = 0x0b000000,
    D3DSPSM_ABSNEG  = 0x0c000000,
    D3DSPSM_NOT     = 0x0d000000,
}

alias D3DSHADER_MIN_PRECISION = int;
enum : int
{
    D3DMP_DEFAULT = 0x00000000,
    D3DMP_16      = 0x00000001,
    D3DMP_2_8     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dbasistype
alias D3DBASISTYPE = int;
enum : int
{
    D3DBASIS_BEZIER      = 0x00000000,
    D3DBASIS_BSPLINE     = 0x00000001,
    D3DBASIS_CATMULL_ROM = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddegreetype
alias D3DDEGREETYPE = int;
enum : int
{
    D3DDEGREE_LINEAR    = 0x00000001,
    D3DDEGREE_QUADRATIC = 0x00000002,
    D3DDEGREE_CUBIC     = 0x00000003,
    D3DDEGREE_QUINTIC   = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dpatchedgestyle
alias D3DPATCHEDGESTYLE = int;
enum : int
{
    D3DPATCHEDGE_DISCRETE   = 0x00000000,
    D3DPATCHEDGE_CONTINUOUS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dstateblocktype
alias D3DSTATEBLOCKTYPE = int;
enum : int
{
    D3DSBT_ALL         = 0x00000001,
    D3DSBT_PIXELSTATE  = 0x00000002,
    D3DSBT_VERTEXSTATE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dvertexblendflags
alias D3DVERTEXBLENDFLAGS = int;
enum : int
{
    D3DVBF_DISABLE  = 0x00000000,
    D3DVBF_1WEIGHTS = 0x00000001,
    D3DVBF_2WEIGHTS = 0x00000002,
    D3DVBF_3WEIGHTS = 0x00000003,
    D3DVBF_TWEENING = 0x000000ff,
    D3DVBF_0WEIGHTS = 0x00000100,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dtexturetransformflags
alias D3DTEXTURETRANSFORMFLAGS = int;
enum : int
{
    D3DTTFF_DISABLE   = 0x00000000,
    D3DTTFF_COUNT1    = 0x00000001,
    D3DTTFF_COUNT2    = 0x00000002,
    D3DTTFF_COUNT3    = 0x00000003,
    D3DTTFF_COUNT4    = 0x00000004,
    D3DTTFF_PROJECTED = 0x00000100,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddevtype
alias D3DDEVTYPE = int;
enum : int
{
    D3DDEVTYPE_HAL     = 0x00000001,
    D3DDEVTYPE_REF     = 0x00000002,
    D3DDEVTYPE_SW      = 0x00000003,
    D3DDEVTYPE_NULLREF = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dmultisample-type
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
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dformat
alias D3DFORMAT = uint;
enum : uint
{
    D3DFMT_UNKNOWN             = 0x00000000U,
    D3DFMT_R8G8B8              = 0x00000014U,
    D3DFMT_A8R8G8B8            = 0x00000015U,
    D3DFMT_X8R8G8B8            = 0x00000016U,
    D3DFMT_R5G6B5              = 0x00000017U,
    D3DFMT_X1R5G5B5            = 0x00000018U,
    D3DFMT_A1R5G5B5            = 0x00000019U,
    D3DFMT_A4R4G4B4            = 0x0000001aU,
    D3DFMT_R3G3B2              = 0x0000001bU,
    D3DFMT_A8                  = 0x0000001cU,
    D3DFMT_A8R3G3B2            = 0x0000001dU,
    D3DFMT_X4R4G4B4            = 0x0000001eU,
    D3DFMT_A2B10G10R10         = 0x0000001fU,
    D3DFMT_A8B8G8R8            = 0x00000020U,
    D3DFMT_X8B8G8R8            = 0x00000021U,
    D3DFMT_G16R16              = 0x00000022U,
    D3DFMT_A2R10G10B10         = 0x00000023U,
    D3DFMT_A16B16G16R16        = 0x00000024U,
    D3DFMT_A8P8                = 0x00000028U,
    D3DFMT_P8                  = 0x00000029U,
    D3DFMT_L8                  = 0x00000032U,
    D3DFMT_A8L8                = 0x00000033U,
    D3DFMT_A4L4                = 0x00000034U,
    D3DFMT_V8U8                = 0x0000003cU,
    D3DFMT_L6V5U5              = 0x0000003dU,
    D3DFMT_X8L8V8U8            = 0x0000003eU,
    D3DFMT_Q8W8V8U8            = 0x0000003fU,
    D3DFMT_V16U16              = 0x00000040U,
    D3DFMT_A2W10V10U10         = 0x00000043U,
    D3DFMT_UYVY                = 0x59565955U,
    D3DFMT_R8G8_B8G8           = 0x47424752U,
    D3DFMT_YUY2                = 0x32595559U,
    D3DFMT_G8R8_G8B8           = 0x42475247U,
    D3DFMT_DXT1                = 0x31545844U,
    D3DFMT_DXT2                = 0x32545844U,
    D3DFMT_DXT3                = 0x33545844U,
    D3DFMT_DXT4                = 0x34545844U,
    D3DFMT_DXT5                = 0x35545844U,
    D3DFMT_D16_LOCKABLE        = 0x00000046U,
    D3DFMT_D32                 = 0x00000047U,
    D3DFMT_D15S1               = 0x00000049U,
    D3DFMT_D24S8               = 0x0000004bU,
    D3DFMT_D24X8               = 0x0000004dU,
    D3DFMT_D24X4S4             = 0x0000004fU,
    D3DFMT_D16                 = 0x00000050U,
    D3DFMT_D32F_LOCKABLE       = 0x00000052U,
    D3DFMT_D24FS8              = 0x00000053U,
    D3DFMT_D32_LOCKABLE        = 0x00000054U,
    D3DFMT_S8_LOCKABLE         = 0x00000055U,
    D3DFMT_L16                 = 0x00000051U,
    D3DFMT_VERTEXDATA          = 0x00000064U,
    D3DFMT_INDEX16             = 0x00000065U,
    D3DFMT_INDEX32             = 0x00000066U,
    D3DFMT_Q16W16V16U16        = 0x0000006eU,
    D3DFMT_MULTI2_ARGB8        = 0x3154454dU,
    D3DFMT_R16F                = 0x0000006fU,
    D3DFMT_G16R16F             = 0x00000070U,
    D3DFMT_A16B16G16R16F       = 0x00000071U,
    D3DFMT_R32F                = 0x00000072U,
    D3DFMT_G32R32F             = 0x00000073U,
    D3DFMT_A32B32G32R32F       = 0x00000074U,
    D3DFMT_CxV8U8              = 0x00000075U,
    D3DFMT_A1                  = 0x00000076U,
    D3DFMT_A2B10G10R10_XR_BIAS = 0x00000077U,
    D3DFMT_BINARYBUFFER        = 0x000000c7U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dswapeffect
alias D3DSWAPEFFECT = int;
enum : int
{
    D3DSWAPEFFECT_DISCARD = 0x00000001,
    D3DSWAPEFFECT_FLIP    = 0x00000002,
    D3DSWAPEFFECT_COPY    = 0x00000003,
    D3DSWAPEFFECT_OVERLAY = 0x00000004,
    D3DSWAPEFFECT_FLIPEX  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dpool
alias D3DPOOL = int;
enum : int
{
    D3DPOOL_DEFAULT   = 0x00000000,
    D3DPOOL_MANAGED   = 0x00000001,
    D3DPOOL_SYSTEMMEM = 0x00000002,
    D3DPOOL_SCRATCH   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dbackbuffer-type
alias D3DBACKBUFFER_TYPE = int;
enum : int
{
    D3DBACKBUFFER_TYPE_MONO  = 0x00000000,
    D3DBACKBUFFER_TYPE_LEFT  = 0x00000001,
    D3DBACKBUFFER_TYPE_RIGHT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dresourcetype
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
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dcubemap-faces
alias D3DCUBEMAP_FACES = int;
enum : int
{
    D3DCUBEMAP_FACE_POSITIVE_X = 0x00000000,
    D3DCUBEMAP_FACE_NEGATIVE_X = 0x00000001,
    D3DCUBEMAP_FACE_POSITIVE_Y = 0x00000002,
    D3DCUBEMAP_FACE_NEGATIVE_Y = 0x00000003,
    D3DCUBEMAP_FACE_POSITIVE_Z = 0x00000004,
    D3DCUBEMAP_FACE_NEGATIVE_Z = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddebugmonitortokens
alias D3DDEBUGMONITORTOKENS = int;
enum : int
{
    D3DDMT_ENABLE  = 0x00000000,
    D3DDMT_DISABLE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dquerytype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dcomposerectsop
alias D3DCOMPOSERECTSOP = int;
enum : int
{
    D3DCOMPOSERECTS_COPY = 0x00000001,
    D3DCOMPOSERECTS_OR   = 0x00000002,
    D3DCOMPOSERECTS_AND  = 0x00000003,
    D3DCOMPOSERECTS_NEG  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dscanlineordering
alias D3DSCANLINEORDERING = int;
enum : int
{
    D3DSCANLINEORDERING_UNKNOWN     = 0x00000000,
    D3DSCANLINEORDERING_PROGRESSIVE = 0x00000001,
    D3DSCANLINEORDERING_INTERLACED  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddisplayrotation
alias D3DDISPLAYROTATION = int;
enum : int
{
    D3DDISPLAYROTATION_IDENTITY = 0x00000001,
    D3DDISPLAYROTATION_90       = 0x00000002,
    D3DDISPLAYROTATION_180      = 0x00000003,
    D3DDISPLAYROTATION_270      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchanneltype
alias D3DAUTHENTICATEDCHANNELTYPE = int;
enum : int
{
    D3DAUTHENTICATEDCHANNEL_D3D9            = 0x00000001,
    D3DAUTHENTICATEDCHANNEL_DRIVER_SOFTWARE = 0x00000002,
    D3DAUTHENTICATEDCHANNEL_DRIVER_HARDWARE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-processidentifiertype
alias D3DAUTHENTICATEDCHANNEL_PROCESSIDENTIFIERTYPE = int;
enum : int
{
    PROCESSIDTYPE_UNKNOWN = 0x00000000,
    PROCESSIDTYPE_DWM     = 0x00000001,
    PROCESSIDTYPE_HANDLE  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dbustype
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

alias D3DOPCODE = int;
enum : int
{
    D3DOP_POINT           = 0x00000001,
    D3DOP_LINE            = 0x00000002,
    D3DOP_TRIANGLE        = 0x00000003,
    D3DOP_MATRIXLOAD      = 0x00000004,
    D3DOP_MATRIXMULTIPLY  = 0x00000005,
    D3DOP_STATETRANSFORM  = 0x00000006,
    D3DOP_STATELIGHT      = 0x00000007,
    D3DOP_STATERENDER     = 0x00000008,
    D3DOP_PROCESSVERTICES = 0x00000009,
    D3DOP_TEXTURELOAD     = 0x0000000a,
    D3DOP_EXIT            = 0x0000000b,
    D3DOP_BRANCHFORWARD   = 0x0000000c,
    D3DOP_SPAN            = 0x0000000d,
    D3DOP_SETSTATUS       = 0x0000000e,
}

alias D3DTEXTUREFILTER = int;
enum : int
{
    D3DFILTER_NEAREST          = 0x00000001,
    D3DFILTER_LINEAR           = 0x00000002,
    D3DFILTER_MIPNEAREST       = 0x00000003,
    D3DFILTER_MIPLINEAR        = 0x00000004,
    D3DFILTER_LINEARMIPNEAREST = 0x00000005,
    D3DFILTER_LINEARMIPLINEAR  = 0x00000006,
}

alias D3DTEXTUREBLEND = int;
enum : int
{
    D3DTBLEND_DECAL         = 0x00000001,
    D3DTBLEND_MODULATE      = 0x00000002,
    D3DTBLEND_DECALALPHA    = 0x00000003,
    D3DTBLEND_MODULATEALPHA = 0x00000004,
    D3DTBLEND_DECALMASK     = 0x00000005,
    D3DTBLEND_MODULATEMASK  = 0x00000006,
    D3DTBLEND_COPY          = 0x00000007,
    D3DTBLEND_ADD           = 0x00000008,
}

alias D3DANTIALIASMODE = int;
enum : int
{
    D3DANTIALIAS_NONE            = 0x00000000,
    D3DANTIALIAS_SORTDEPENDENT   = 0x00000001,
    D3DANTIALIAS_SORTINDEPENDENT = 0x00000002,
}

alias D3DVERTEXTYPE = int;
enum : int
{
    D3DVT_VERTEX   = 0x00000001,
    D3DVT_LVERTEX  = 0x00000002,
    D3DVT_TLVERTEX = 0x00000003,
}

alias D3DLIGHTSTATETYPE = int;
enum : int
{
    D3DLIGHTSTATE_MATERIAL    = 0x00000001,
    D3DLIGHTSTATE_AMBIENT     = 0x00000002,
    D3DLIGHTSTATE_COLORMODEL  = 0x00000003,
    D3DLIGHTSTATE_FOGMODE     = 0x00000004,
    D3DLIGHTSTATE_FOGSTART    = 0x00000005,
    D3DLIGHTSTATE_FOGEND      = 0x00000006,
    D3DLIGHTSTATE_FOGDENSITY  = 0x00000007,
    D3DLIGHTSTATE_COLORVERTEX = 0x00000008,
}

alias D3DTEXTUREMAGFILTER = int;
enum : int
{
    D3DTFG_POINT         = 0x00000001,
    D3DTFG_LINEAR        = 0x00000002,
    D3DTFG_FLATCUBIC     = 0x00000003,
    D3DTFG_GAUSSIANCUBIC = 0x00000004,
    D3DTFG_ANISOTROPIC   = 0x00000005,
}

alias D3DTEXTUREMINFILTER = int;
enum : int
{
    D3DTFN_POINT       = 0x00000001,
    D3DTFN_LINEAR      = 0x00000002,
    D3DTFN_ANISOTROPIC = 0x00000003,
}

alias D3DTEXTUREMIPFILTER = int;
enum : int
{
    D3DTFP_NONE   = 0x00000001,
    D3DTFP_POINT  = 0x00000002,
    D3DTFP_LINEAR = 0x00000003,
}

// Constants


enum uint D3DRTYPECOUNT = 0x00000008U;
enum uint DIRECT3D_VERSION = 0x00000900U;
enum uint D3D_SDK_VERSION = 0x00000020U;
enum uint D3D9b_SDK_VERSION = 0x0000001fU;
enum int D3DSPD_IUNKNOWN = 0x00000001;

enum : int
{
    D3DCREATE_FPU_PRESERVE              = 0x00000002,
    D3DCREATE_MULTITHREADED             = 0x00000004,
    D3DCREATE_PUREDEVICE                = 0x00000010,
    D3DCREATE_SOFTWARE_VERTEXPROCESSING = 0x00000020,
}

enum int D3DCREATE_HARDWARE_VERTEXPROCESSING = 0x00000040;
enum int D3DCREATE_MIXED_VERTEXPROCESSING = 0x00000080;
enum int D3DCREATE_DISABLE_DRIVER_MANAGEMENT = 0x00000100;
enum int D3DCREATE_ADAPTERGROUP_DEVICE = 0x00000200;
enum int D3DCREATE_DISABLE_DRIVER_MANAGEMENT_EX = 0x00000400;
enum int D3DCREATE_NOWINDOWCHANGES = 0x00000800;
enum int D3DCREATE_DISABLE_PSGP_THREADING = 0x00002000;
enum int D3DCREATE_ENABLE_PRESENTSTATS = 0x00004000;
enum int D3DCREATE_DISABLE_PRINTSCREEN = 0x00008000;
enum int D3DCREATE_SCREENSAVER = 0x10000000;
enum uint D3DADAPTER_DEFAULT = 0x00000000U;

enum : int
{
    D3DENUM_WHQL_LEVEL       = 0x00000002,
    D3DENUM_NO_DRIVERVERSION = 0x00000004,
}

enum : int
{
    D3DPRESENT_BACK_BUFFERS_MAX    = 0x00000003,
    D3DPRESENT_BACK_BUFFERS_MAX_EX = 0x0000001e,
}

enum int D3DSGR_NO_CALIBRATION = 0x00000000;
enum int D3DSGR_CALIBRATE = 0x00000001;
enum int D3DCURSOR_IMMEDIATE_UPDATE = 0x00000001;

enum : int
{
    D3DPRESENT_DONOTWAIT                 = 0x00000001,
    D3DPRESENT_LINEAR_CONTENT            = 0x00000002,
    D3DPRESENT_DONOTFLIP                 = 0x00000004,
    D3DPRESENT_FLIPRESTART               = 0x00000008,
    D3DPRESENT_VIDEO_RESTRICT_TO_MONITOR = 0x00000010,
}

enum int D3DPRESENT_UPDATEOVERLAYONLY = 0x00000020;

enum : int
{
    D3DPRESENT_HIDEOVERLAY    = 0x00000040,
    D3DPRESENT_UPDATECOLORKEY = 0x00000080,
    D3DPRESENT_FORCEIMMEDIATE = 0x00000100,
}

enum uint _FACD3D = 0x00000876U;
enum uint D3DVS20CAPS_PREDICATION = 0x00000001U;
enum uint D3DVS20_MAX_DYNAMICFLOWCONTROLDEPTH = 0x00000018U;
enum uint D3DVS20_MIN_DYNAMICFLOWCONTROLDEPTH = 0x00000000U;

enum : uint
{
    D3DVS20_MAX_NUMTEMPS               = 0x00000020U,
    D3DVS20_MIN_NUMTEMPS               = 0x0000000cU,
    D3DVS20_MAX_STATICFLOWCONTROLDEPTH = 0x00000004U,
}

enum uint D3DVS20_MIN_STATICFLOWCONTROLDEPTH = 0x00000001U;

enum : uint
{
    D3DPS20CAPS_ARBITRARYSWIZZLE     = 0x00000001U,
    D3DPS20CAPS_GRADIENTINSTRUCTIONS = 0x00000002U,
}

enum : uint
{
    D3DPS20CAPS_PREDICATION           = 0x00000004U,
    D3DPS20CAPS_NODEPENDENTREADLIMIT  = 0x00000008U,
    D3DPS20CAPS_NOTEXINSTRUCTIONLIMIT = 0x00000010U,
}

enum uint D3DPS20_MAX_DYNAMICFLOWCONTROLDEPTH = 0x00000018U;
enum uint D3DPS20_MIN_DYNAMICFLOWCONTROLDEPTH = 0x00000000U;

enum : uint
{
    D3DPS20_MAX_NUMTEMPS               = 0x00000020U,
    D3DPS20_MIN_NUMTEMPS               = 0x0000000cU,
    D3DPS20_MAX_STATICFLOWCONTROLDEPTH = 0x00000004U,
}

enum uint D3DPS20_MIN_STATICFLOWCONTROLDEPTH = 0x00000000U;
enum uint D3DPS20_MAX_NUMINSTRUCTIONSLOTS = 0x00000200U;
enum uint D3DPS20_MIN_NUMINSTRUCTIONSLOTS = 0x00000060U;
enum uint D3DMIN30SHADERINSTRUCTIONS = 0x00000200U;
enum uint D3DMAX30SHADERINSTRUCTIONS = 0x00008000U;

enum : uint
{
    D3DOVERLAYCAPS_FULLRANGERGB      = 0x00000001U,
    D3DOVERLAYCAPS_LIMITEDRANGERGB   = 0x00000002U,
    D3DOVERLAYCAPS_YCbCr_BT601       = 0x00000004U,
    D3DOVERLAYCAPS_YCbCr_BT709       = 0x00000008U,
    D3DOVERLAYCAPS_YCbCr_BT601_xvYCC = 0x00000010U,
    D3DOVERLAYCAPS_YCbCr_BT709_xvYCC = 0x00000020U,
    D3DOVERLAYCAPS_STRETCHX          = 0x00000040U,
    D3DOVERLAYCAPS_STRETCHY          = 0x00000080U,
}

enum : uint
{
    D3DCPCAPS_SOFTWARE           = 0x00000001U,
    D3DCPCAPS_HARDWARE           = 0x00000002U,
    D3DCPCAPS_PROTECTIONALWAYSON = 0x00000004U,
}

enum uint D3DCPCAPS_PARTIALDECRYPTION = 0x00000008U;

enum : uint
{
    D3DCPCAPS_CONTENTKEY        = 0x00000010U,
    D3DCPCAPS_FRESHENSESSIONKEY = 0x00000020U,
}

enum : uint
{
    D3DCPCAPS_ENCRYPTEDREADBACK    = 0x00000040U,
    D3DCPCAPS_ENCRYPTEDREADBACKKEY = 0x00000080U,
}

enum uint D3DCPCAPS_SEQUENTIAL_CTR_IV = 0x00000100U;
enum uint D3DCPCAPS_ENCRYPTSLICEDATAONLY = 0x00000200U;

enum : GUID
{
    D3DCRYPTOTYPE_AES128_CTR  = GUID("9b6bd711-4f74-41c9-9e7b-0be2d7d93b4f"),
    D3DCRYPTOTYPE_PROPRIETARY = GUID("ab4e9afd-1d1c-46e6-a72f-0869917b0de8"),
}

enum : GUID
{
    D3DKEYEXCHANGE_RSAES_OAEP = GUID("c1949895-d72a-4a1d-8e5d-ed857d171520"),
    D3DKEYEXCHANGE_DXVA       = GUID("43d3775c-38e5-4924-8d86-d3fccf153e9b"),
}

enum : int
{
    D3DCAPS_OVERLAY       = 0x00000800,
    D3DCAPS_READ_SCANLINE = 0x00020000,
}

enum int D3DCAPS2_FULLSCREENGAMMA = 0x00020000;
enum int D3DCAPS2_CANCALIBRATEGAMMA = 0x00100000;

enum : int
{
    D3DCAPS2_RESERVED          = 0x02000000,
    D3DCAPS2_CANMANAGERESOURCE = 0x10000000,
}

enum int D3DCAPS2_DYNAMICTEXTURES = 0x20000000;

enum : int
{
    D3DCAPS2_CANAUTOGENMIPMAP = 0x40000000,
    D3DCAPS2_CANSHARERESOURCE = 0x80000000,
}

enum : int
{
    D3DCAPS3_RESERVED                         = 0x8000001f,
    D3DCAPS3_ALPHA_FULLSCREEN_FLIP_OR_DISCARD = 0x00000020,
}

enum int D3DCAPS3_LINEAR_TO_SRGB_PRESENTATION = 0x00000080;

enum : int
{
    D3DCAPS3_COPY_TO_VIDMEM    = 0x00000100,
    D3DCAPS3_COPY_TO_SYSTEMMEM = 0x00000200,
}

enum : int
{
    D3DCAPS3_DXVAHD         = 0x00000400,
    D3DCAPS3_DXVAHD_LIMITED = 0x00000800,
}

enum : int
{
    D3DPRESENT_INTERVAL_DEFAULT   = 0x00000000,
    D3DPRESENT_INTERVAL_ONE       = 0x00000001,
    D3DPRESENT_INTERVAL_TWO       = 0x00000002,
    D3DPRESENT_INTERVAL_THREE     = 0x00000004,
    D3DPRESENT_INTERVAL_FOUR      = 0x00000008,
    D3DPRESENT_INTERVAL_IMMEDIATE = 0x80000000,
}

enum : int
{
    D3DCURSORCAPS_COLOR  = 0x00000001,
    D3DCURSORCAPS_LOWRES = 0x00000002,
}

enum : int
{
    D3DDEVCAPS_EXECUTESYSTEMMEMORY = 0x00000010,
    D3DDEVCAPS_EXECUTEVIDEOMEMORY  = 0x00000020,
}

enum : int
{
    D3DDEVCAPS_TLVERTEXSYSTEMMEMORY = 0x00000040,
    D3DDEVCAPS_TLVERTEXVIDEOMEMORY  = 0x00000080,
}

enum : int
{
    D3DDEVCAPS_TEXTURESYSTEMMEMORY = 0x00000100,
    D3DDEVCAPS_TEXTUREVIDEOMEMORY  = 0x00000200,
}

enum : int
{
    D3DDEVCAPS_DRAWPRIMTLVERTEX   = 0x00000400,
    D3DDEVCAPS_CANRENDERAFTERFLIP = 0x00000800,
}

enum int D3DDEVCAPS_TEXTURENONLOCALVIDMEM = 0x00001000;

enum : int
{
    D3DDEVCAPS_DRAWPRIMITIVES2         = 0x00002000,
    D3DDEVCAPS_SEPARATETEXTUREMEMORIES = 0x00004000,
}

enum int D3DDEVCAPS_DRAWPRIMITIVES2EX = 0x00008000;
enum int D3DDEVCAPS_HWTRANSFORMANDLIGHT = 0x00010000;
enum int D3DDEVCAPS_CANBLTSYSTONONLOCAL = 0x00020000;

enum : int
{
    D3DDEVCAPS_HWRASTERIZATION   = 0x00080000,
    D3DDEVCAPS_PUREDEVICE        = 0x00100000,
    D3DDEVCAPS_QUINTICRTPATCHES  = 0x00200000,
    D3DDEVCAPS_RTPATCHES         = 0x00400000,
    D3DDEVCAPS_RTPATCHHANDLEZERO = 0x00800000,
}

enum int D3DDEVCAPS_NPATCHES = 0x01000000;

enum : int
{
    D3DPMISCCAPS_MASKZ                 = 0x00000002,
    D3DPMISCCAPS_CULLNONE              = 0x00000010,
    D3DPMISCCAPS_CULLCW                = 0x00000020,
    D3DPMISCCAPS_CULLCCW               = 0x00000040,
    D3DPMISCCAPS_COLORWRITEENABLE      = 0x00000080,
    D3DPMISCCAPS_CLIPPLANESCALEDPOINTS = 0x00000100,
    D3DPMISCCAPS_CLIPTLVERTS           = 0x00000200,
    D3DPMISCCAPS_TSSARGTEMP            = 0x00000400,
    D3DPMISCCAPS_BLENDOP               = 0x00000800,
    D3DPMISCCAPS_NULLREFERENCE         = 0x00001000,
    D3DPMISCCAPS_INDEPENDENTWRITEMASKS = 0x00004000,
}

enum : int
{
    D3DPMISCCAPS_PERSTAGECONSTANT           = 0x00008000,
    D3DPMISCCAPS_FOGANDSPECULARALPHA        = 0x00010000,
    D3DPMISCCAPS_SEPARATEALPHABLEND         = 0x00020000,
    D3DPMISCCAPS_MRTINDEPENDENTBITDEPTHS    = 0x00040000,
    D3DPMISCCAPS_MRTPOSTPIXELSHADERBLENDING = 0x00080000,
}

enum : int
{
    D3DPMISCCAPS_FOGVERTEXCLAMPED     = 0x00100000,
    D3DPMISCCAPS_POSTBLENDSRGBCONVERT = 0x00200000,
}

enum : int
{
    D3DLINECAPS_TEXTURE   = 0x00000001,
    D3DLINECAPS_ZTEST     = 0x00000002,
    D3DLINECAPS_BLEND     = 0x00000004,
    D3DLINECAPS_ALPHACMP  = 0x00000008,
    D3DLINECAPS_FOG       = 0x00000010,
    D3DLINECAPS_ANTIALIAS = 0x00000020,
}

enum : int
{
    D3DPRASTERCAPS_DITHER              = 0x00000001,
    D3DPRASTERCAPS_ZTEST               = 0x00000010,
    D3DPRASTERCAPS_FOGVERTEX           = 0x00000080,
    D3DPRASTERCAPS_FOGTABLE            = 0x00000100,
    D3DPRASTERCAPS_MIPMAPLODBIAS       = 0x00002000,
    D3DPRASTERCAPS_ZBUFFERLESSHSR      = 0x00008000,
    D3DPRASTERCAPS_FOGRANGE            = 0x00010000,
    D3DPRASTERCAPS_ANISOTROPY          = 0x00020000,
    D3DPRASTERCAPS_WBUFFER             = 0x00040000,
    D3DPRASTERCAPS_WFOG                = 0x00100000,
    D3DPRASTERCAPS_ZFOG                = 0x00200000,
    D3DPRASTERCAPS_COLORPERSPECTIVE    = 0x00400000,
    D3DPRASTERCAPS_SCISSORTEST         = 0x01000000,
    D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS = 0x02000000,
    D3DPRASTERCAPS_DEPTHBIAS           = 0x04000000,
    D3DPRASTERCAPS_MULTISAMPLE_TOGGLE  = 0x08000000,
}

enum : int
{
    D3DPCMPCAPS_NEVER        = 0x00000001,
    D3DPCMPCAPS_LESS         = 0x00000002,
    D3DPCMPCAPS_EQUAL        = 0x00000004,
    D3DPCMPCAPS_LESSEQUAL    = 0x00000008,
    D3DPCMPCAPS_GREATER      = 0x00000010,
    D3DPCMPCAPS_NOTEQUAL     = 0x00000020,
    D3DPCMPCAPS_GREATEREQUAL = 0x00000040,
    D3DPCMPCAPS_ALWAYS       = 0x00000080,
}

enum : int
{
    D3DPBLENDCAPS_ZERO            = 0x00000001,
    D3DPBLENDCAPS_ONE             = 0x00000002,
    D3DPBLENDCAPS_SRCCOLOR        = 0x00000004,
    D3DPBLENDCAPS_INVSRCCOLOR     = 0x00000008,
    D3DPBLENDCAPS_SRCALPHA        = 0x00000010,
    D3DPBLENDCAPS_INVSRCALPHA     = 0x00000020,
    D3DPBLENDCAPS_DESTALPHA       = 0x00000040,
    D3DPBLENDCAPS_INVDESTALPHA    = 0x00000080,
    D3DPBLENDCAPS_DESTCOLOR       = 0x00000100,
    D3DPBLENDCAPS_INVDESTCOLOR    = 0x00000200,
    D3DPBLENDCAPS_SRCALPHASAT     = 0x00000400,
    D3DPBLENDCAPS_BOTHSRCALPHA    = 0x00000800,
    D3DPBLENDCAPS_BOTHINVSRCALPHA = 0x00001000,
    D3DPBLENDCAPS_BLENDFACTOR     = 0x00002000,
    D3DPBLENDCAPS_SRCCOLOR2       = 0x00004000,
    D3DPBLENDCAPS_INVSRCCOLOR2    = 0x00008000,
}

enum : int
{
    D3DPSHADECAPS_COLORGOURAUDRGB    = 0x00000008,
    D3DPSHADECAPS_SPECULARGOURAUDRGB = 0x00000200,
    D3DPSHADECAPS_ALPHAGOURAUDBLEND  = 0x00004000,
    D3DPSHADECAPS_FOGGOURAUD         = 0x00080000,
}

enum : int
{
    D3DPTEXTURECAPS_PERSPECTIVE              = 0x00000001,
    D3DPTEXTURECAPS_POW2                     = 0x00000002,
    D3DPTEXTURECAPS_ALPHA                    = 0x00000004,
    D3DPTEXTURECAPS_SQUAREONLY               = 0x00000020,
    D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE = 0x00000040,
}

enum : int
{
    D3DPTEXTURECAPS_ALPHAPALETTE       = 0x00000080,
    D3DPTEXTURECAPS_NONPOW2CONDITIONAL = 0x00000100,
    D3DPTEXTURECAPS_PROJECTED          = 0x00000400,
    D3DPTEXTURECAPS_CUBEMAP            = 0x00000800,
    D3DPTEXTURECAPS_VOLUMEMAP          = 0x00002000,
    D3DPTEXTURECAPS_MIPMAP             = 0x00004000,
    D3DPTEXTURECAPS_MIPVOLUMEMAP       = 0x00008000,
    D3DPTEXTURECAPS_MIPCUBEMAP         = 0x00010000,
    D3DPTEXTURECAPS_CUBEMAP_POW2       = 0x00020000,
    D3DPTEXTURECAPS_VOLUMEMAP_POW2     = 0x00040000,
    D3DPTEXTURECAPS_NOPROJECTEDBUMPENV = 0x00200000,
}

enum : int
{
    D3DPTFILTERCAPS_MINFPOINT         = 0x00000100,
    D3DPTFILTERCAPS_MINFLINEAR        = 0x00000200,
    D3DPTFILTERCAPS_MINFANISOTROPIC   = 0x00000400,
    D3DPTFILTERCAPS_MINFPYRAMIDALQUAD = 0x00000800,
    D3DPTFILTERCAPS_MINFGAUSSIANQUAD  = 0x00001000,
    D3DPTFILTERCAPS_MIPFPOINT         = 0x00010000,
    D3DPTFILTERCAPS_MIPFLINEAR        = 0x00020000,
    D3DPTFILTERCAPS_CONVOLUTIONMONO   = 0x00040000,
    D3DPTFILTERCAPS_MAGFPOINT         = 0x01000000,
    D3DPTFILTERCAPS_MAGFLINEAR        = 0x02000000,
    D3DPTFILTERCAPS_MAGFANISOTROPIC   = 0x04000000,
    D3DPTFILTERCAPS_MAGFPYRAMIDALQUAD = 0x08000000,
    D3DPTFILTERCAPS_MAGFGAUSSIANQUAD  = 0x10000000,
}

enum : int
{
    D3DPTADDRESSCAPS_WRAP          = 0x00000001,
    D3DPTADDRESSCAPS_MIRROR        = 0x00000002,
    D3DPTADDRESSCAPS_CLAMP         = 0x00000004,
    D3DPTADDRESSCAPS_BORDER        = 0x00000008,
    D3DPTADDRESSCAPS_INDEPENDENTUV = 0x00000010,
    D3DPTADDRESSCAPS_MIRRORONCE    = 0x00000020,
}

enum : int
{
    D3DSTENCILCAPS_KEEP     = 0x00000001,
    D3DSTENCILCAPS_ZERO     = 0x00000002,
    D3DSTENCILCAPS_REPLACE  = 0x00000004,
    D3DSTENCILCAPS_INCRSAT  = 0x00000008,
    D3DSTENCILCAPS_DECRSAT  = 0x00000010,
    D3DSTENCILCAPS_INVERT   = 0x00000020,
    D3DSTENCILCAPS_INCR     = 0x00000040,
    D3DSTENCILCAPS_DECR     = 0x00000080,
    D3DSTENCILCAPS_TWOSIDED = 0x00000100,
}

enum : int
{
    D3DTEXOPCAPS_DISABLE                   = 0x00000001,
    D3DTEXOPCAPS_SELECTARG1                = 0x00000002,
    D3DTEXOPCAPS_SELECTARG2                = 0x00000004,
    D3DTEXOPCAPS_MODULATE                  = 0x00000008,
    D3DTEXOPCAPS_MODULATE2X                = 0x00000010,
    D3DTEXOPCAPS_MODULATE4X                = 0x00000020,
    D3DTEXOPCAPS_ADD                       = 0x00000040,
    D3DTEXOPCAPS_ADDSIGNED                 = 0x00000080,
    D3DTEXOPCAPS_ADDSIGNED2X               = 0x00000100,
    D3DTEXOPCAPS_SUBTRACT                  = 0x00000200,
    D3DTEXOPCAPS_ADDSMOOTH                 = 0x00000400,
    D3DTEXOPCAPS_BLENDDIFFUSEALPHA         = 0x00000800,
    D3DTEXOPCAPS_BLENDTEXTUREALPHA         = 0x00001000,
    D3DTEXOPCAPS_BLENDFACTORALPHA          = 0x00002000,
    D3DTEXOPCAPS_BLENDTEXTUREALPHAPM       = 0x00004000,
    D3DTEXOPCAPS_BLENDCURRENTALPHA         = 0x00008000,
    D3DTEXOPCAPS_PREMODULATE               = 0x00010000,
    D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR    = 0x00020000,
    D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA    = 0x00040000,
    D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR = 0x00080000,
    D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA = 0x00100000,
}

enum : int
{
    D3DTEXOPCAPS_BUMPENVMAP          = 0x00200000,
    D3DTEXOPCAPS_BUMPENVMAPLUMINANCE = 0x00400000,
    D3DTEXOPCAPS_DOTPRODUCT3         = 0x00800000,
    D3DTEXOPCAPS_MULTIPLYADD         = 0x01000000,
    D3DTEXOPCAPS_LERP                = 0x02000000,
}

enum int D3DFVFCAPS_TEXCOORDCOUNTMASK = 0x0000ffff;
enum int D3DFVFCAPS_DONOTSTRIPELEMENTS = 0x00080000;
enum int D3DFVFCAPS_PSIZE = 0x00100000;

enum : int
{
    D3DVTXPCAPS_TEXGEN                   = 0x00000001,
    D3DVTXPCAPS_MATERIALSOURCE7          = 0x00000002,
    D3DVTXPCAPS_DIRECTIONALLIGHTS        = 0x00000008,
    D3DVTXPCAPS_POSITIONALLIGHTS         = 0x00000010,
    D3DVTXPCAPS_LOCALVIEWER              = 0x00000020,
    D3DVTXPCAPS_TWEENING                 = 0x00000040,
    D3DVTXPCAPS_TEXGEN_SPHEREMAP         = 0x00000100,
    D3DVTXPCAPS_NO_TEXGEN_NONLOCALVIEWER = 0x00000200,
}

enum : int
{
    D3DDEVCAPS2_STREAMOFFSET        = 0x00000001,
    D3DDEVCAPS2_DMAPNPATCH          = 0x00000002,
    D3DDEVCAPS2_ADAPTIVETESSRTPATCH = 0x00000004,
    D3DDEVCAPS2_ADAPTIVETESSNPATCH  = 0x00000008,
}

enum int D3DDEVCAPS2_CAN_STRETCHRECT_FROM_TEXTURES = 0x00000010;
enum int D3DDEVCAPS2_PRESAMPLEDDMAPNPATCH = 0x00000020;
enum int D3DDEVCAPS2_VERTEXELEMENTSCANSHARESTREAMOFFSET = 0x00000040;

enum : int
{
    D3DDTCAPS_UBYTE4    = 0x00000001,
    D3DDTCAPS_UBYTE4N   = 0x00000002,
    D3DDTCAPS_SHORT2N   = 0x00000004,
    D3DDTCAPS_SHORT4N   = 0x00000008,
    D3DDTCAPS_USHORT2N  = 0x00000010,
    D3DDTCAPS_USHORT4N  = 0x00000020,
    D3DDTCAPS_UDEC3     = 0x00000040,
    D3DDTCAPS_DEC3N     = 0x00000080,
    D3DDTCAPS_FLOAT16_2 = 0x00000100,
    D3DDTCAPS_FLOAT16_4 = 0x00000200,
}

enum uint D3DMAXUSERCLIPPLANES = 0x00000020U;

enum : uint
{
    D3DCLIPPLANE0 = 0x00000001U,
    D3DCLIPPLANE1 = 0x00000002U,
    D3DCLIPPLANE2 = 0x00000004U,
    D3DCLIPPLANE3 = 0x00000008U,
    D3DCLIPPLANE4 = 0x00000010U,
    D3DCLIPPLANE5 = 0x00000020U,
}

enum : int
{
    D3DCS_LEFT   = 0x00000001,
    D3DCS_RIGHT  = 0x00000002,
    D3DCS_TOP    = 0x00000004,
    D3DCS_BOTTOM = 0x00000008,
    D3DCS_FRONT  = 0x00000010,
    D3DCS_BACK   = 0x00000020,
    D3DCS_PLANE0 = 0x00000040,
    D3DCS_PLANE1 = 0x00000080,
    D3DCS_PLANE2 = 0x00000100,
    D3DCS_PLANE3 = 0x00000200,
    D3DCS_PLANE4 = 0x00000400,
    D3DCS_PLANE5 = 0x00000800,
}

enum : int
{
    D3DCLEAR_TARGET  = 0x00000001,
    D3DCLEAR_ZBUFFER = 0x00000002,
    D3DCLEAR_STENCIL = 0x00000004,
}

enum uint D3D_MAX_SIMULTANEOUS_RENDERTARGETS = 0x00000004U;
enum uint D3DRENDERSTATE_WRAPBIAS = 0x00000080U;

enum : int
{
    D3DWRAP_U      = 0x00000001,
    D3DWRAP_V      = 0x00000002,
    D3DWRAP_W      = 0x00000004,
    D3DWRAPCOORD_0 = 0x00000001,
    D3DWRAPCOORD_1 = 0x00000002,
    D3DWRAPCOORD_2 = 0x00000004,
    D3DWRAPCOORD_3 = 0x00000008,
}

enum uint D3DDMAPSAMPLER = 0x00000100U;

enum : uint
{
    D3DVERTEXTEXTURESAMPLER0 = 0x00000101U,
    D3DVERTEXTEXTURESAMPLER1 = 0x00000102U,
    D3DVERTEXTEXTURESAMPLER2 = 0x00000103U,
    D3DVERTEXTEXTURESAMPLER3 = 0x00000104U,
}

enum : uint
{
    D3DTSS_TCI_PASSTHRU                    = 0x00000000U,
    D3DTSS_TCI_CAMERASPACENORMAL           = 0x00010000U,
    D3DTSS_TCI_CAMERASPACEPOSITION         = 0x00020000U,
    D3DTSS_TCI_CAMERASPACEREFLECTIONVECTOR = 0x00030000U,
}

enum uint D3DTSS_TCI_SPHEREMAP = 0x00040000U;
enum uint D3DTA_SELECTMASK = 0x0000000fU;

enum : uint
{
    D3DTA_DIFFUSE    = 0x00000000U,
    D3DTA_CURRENT    = 0x00000001U,
    D3DTA_TEXTURE    = 0x00000002U,
    D3DTA_TFACTOR    = 0x00000003U,
    D3DTA_SPECULAR   = 0x00000004U,
    D3DTA_TEMP       = 0x00000005U,
    D3DTA_CONSTANT   = 0x00000006U,
    D3DTA_COMPLEMENT = 0x00000010U,
}

enum uint D3DTA_ALPHAREPLICATE = 0x00000020U;
enum uint D3DPV_DONOTCOPYDATA = 0x00000001U;

enum : uint
{
    D3DFVF_RESERVED0     = 0x00000001U,
    D3DFVF_POSITION_MASK = 0x0000400eU,
}

enum : uint
{
    D3DFVF_XYZ               = 0x00000002U,
    D3DFVF_XYZRHW            = 0x00000004U,
    D3DFVF_XYZB1             = 0x00000006U,
    D3DFVF_XYZB2             = 0x00000008U,
    D3DFVF_XYZB3             = 0x0000000aU,
    D3DFVF_XYZB4             = 0x0000000cU,
    D3DFVF_XYZB5             = 0x0000000eU,
    D3DFVF_XYZW              = 0x00004002U,
    D3DFVF_NORMAL            = 0x00000010U,
    D3DFVF_PSIZE             = 0x00000020U,
    D3DFVF_DIFFUSE           = 0x00000040U,
    D3DFVF_SPECULAR          = 0x00000080U,
    D3DFVF_TEXCOUNT_MASK     = 0x00000f00U,
    D3DFVF_TEXCOUNT_SHIFT    = 0x00000008U,
    D3DFVF_TEX0              = 0x00000000U,
    D3DFVF_TEX1              = 0x00000100U,
    D3DFVF_TEX2              = 0x00000200U,
    D3DFVF_TEX3              = 0x00000300U,
    D3DFVF_TEX4              = 0x00000400U,
    D3DFVF_TEX5              = 0x00000500U,
    D3DFVF_TEX6              = 0x00000600U,
    D3DFVF_TEX7              = 0x00000700U,
    D3DFVF_TEX8              = 0x00000800U,
    D3DFVF_LASTBETA_UBYTE4   = 0x00001000U,
    D3DFVF_LASTBETA_D3DCOLOR = 0x00008000U,
}

enum uint D3DFVF_RESERVED2 = 0x00006000U;

enum : uint
{
    MAXD3DDECLUSAGEINDEX = 0x0000000fU,
    MAXD3DDECLLENGTH     = 0x00000040U,
}

enum uint D3DDP_MAXTEXCOORD = 0x00000008U;

enum : uint
{
    D3DSTREAMSOURCE_INDEXEDDATA  = 0x40000000U,
    D3DSTREAMSOURCE_INSTANCEDATA = 0x80000000U,
}

enum uint D3DSI_OPCODE_MASK = 0x0000ffffU;

enum : uint
{
    D3DSI_INSTLENGTH_MASK  = 0x0f000000U,
    D3DSI_INSTLENGTH_SHIFT = 0x00000018U,
}

enum uint D3DSI_COISSUE = 0x40000000U;

enum : uint
{
    D3DSP_OPCODESPECIFICCONTROL_MASK  = 0x00ff0000U,
    D3DSP_OPCODESPECIFICCONTROL_SHIFT = 0x00000010U,
}

enum uint D3DSHADER_COMPARISON_SHIFT = 0x00000010U;
enum uint D3DSHADER_INSTRUCTION_PREDICATED = 0x10000000U;

enum : uint
{
    D3DSP_DCL_USAGE_SHIFT      = 0x00000000U,
    D3DSP_DCL_USAGE_MASK       = 0x0000000fU,
    D3DSP_DCL_USAGEINDEX_SHIFT = 0x00000010U,
    D3DSP_DCL_USAGEINDEX_MASK  = 0x000f0000U,
}

enum : uint
{
    D3DSP_TEXTURETYPE_SHIFT = 0x0000001bU,
    D3DSP_TEXTURETYPE_MASK  = 0x78000000U,
}

enum uint D3DSP_REGNUM_MASK = 0x000007ffU;

enum : uint
{
    D3DSP_WRITEMASK_0   = 0x00010000U,
    D3DSP_WRITEMASK_1   = 0x00020000U,
    D3DSP_WRITEMASK_2   = 0x00040000U,
    D3DSP_WRITEMASK_3   = 0x00080000U,
    D3DSP_WRITEMASK_ALL = 0x000f0000U,
}

enum : uint
{
    D3DSP_DSTMOD_SHIFT   = 0x00000014U,
    D3DSP_DSTMOD_MASK    = 0x00f00000U,
    D3DSP_DSTSHIFT_SHIFT = 0x00000018U,
    D3DSP_DSTSHIFT_MASK  = 0x0f000000U,
}

enum : uint
{
    D3DSP_REGTYPE_SHIFT  = 0x0000001cU,
    D3DSP_REGTYPE_SHIFT2 = 0x00000008U,
    D3DSP_REGTYPE_MASK   = 0x70000000U,
    D3DSP_REGTYPE_MASK2  = 0x00001800U,
}

enum uint D3DVS_ADDRESSMODE_SHIFT = 0x0000000dU;
enum uint D3DSHADER_ADDRESSMODE_SHIFT = 0x0000000dU;

enum : uint
{
    D3DVS_SWIZZLE_SHIFT = 0x00000010U,
    D3DVS_SWIZZLE_MASK  = 0x00ff0000U,
}

enum : uint
{
    D3DSP_SWIZZLE_SHIFT = 0x00000010U,
    D3DSP_SWIZZLE_MASK  = 0x00ff0000U,
}

enum : uint
{
    D3DSP_SRCMOD_SHIFT = 0x00000018U,
    D3DSP_SRCMOD_MASK  = 0x0f000000U,
}

enum : uint
{
    D3DSP_MIN_PRECISION_SHIFT = 0x0000000eU,
    D3DSP_MIN_PRECISION_MASK  = 0x0000c000U,
}

enum : uint
{
    D3DSI_COMMENTSIZE_SHIFT = 0x00000010U,
    D3DSI_COMMENTSIZE_MASK  = 0x7fff0000U,
}

enum : uint
{
    D3DFVF_TEXTUREFORMAT2 = 0x00000000U,
    D3DFVF_TEXTUREFORMAT1 = 0x00000003U,
    D3DFVF_TEXTUREFORMAT3 = 0x00000001U,
    D3DFVF_TEXTUREFORMAT4 = 0x00000002U,
}

enum : uint
{
    D3DPRESENT_RATE_DEFAULT                        = 0x00000000U,
    D3DPRESENTFLAG_LOCKABLE_BACKBUFFER             = 0x00000001U,
    D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL            = 0x00000002U,
    D3DPRESENTFLAG_DEVICECLIP                      = 0x00000004U,
    D3DPRESENTFLAG_VIDEO                           = 0x00000010U,
    D3DPRESENTFLAG_NOAUTOROTATE                    = 0x00000020U,
    D3DPRESENTFLAG_UNPRUNEDMODE                    = 0x00000040U,
    D3DPRESENTFLAG_OVERLAY_LIMITEDRGB              = 0x00000080U,
    D3DPRESENTFLAG_OVERLAY_YCbCr_BT709             = 0x00000100U,
    D3DPRESENTFLAG_OVERLAY_YCbCr_xvYCC             = 0x00000200U,
    D3DPRESENTFLAG_RESTRICTED_CONTENT              = 0x00000400U,
    D3DPRESENTFLAG_RESTRICT_SHARED_RESOURCE_DRIVER = 0x00000800U,
}

enum : int
{
    D3DUSAGE_RENDERTARGET                   = 0x00000001,
    D3DUSAGE_DEPTHSTENCIL                   = 0x00000002,
    D3DUSAGE_DYNAMIC                        = 0x00000200,
    D3DUSAGE_NONSECURE                      = 0x00800000,
    D3DUSAGE_AUTOGENMIPMAP                  = 0x00000400,
    D3DUSAGE_DMAP                           = 0x00004000,
    D3DUSAGE_QUERY_LEGACYBUMPMAP            = 0x00008000,
    D3DUSAGE_QUERY_SRGBREAD                 = 0x00010000,
    D3DUSAGE_QUERY_FILTER                   = 0x00020000,
    D3DUSAGE_QUERY_SRGBWRITE                = 0x00040000,
    D3DUSAGE_QUERY_POSTPIXELSHADER_BLENDING = 0x00080000,
}

enum : int
{
    D3DUSAGE_QUERY_VERTEXTEXTURE = 0x00100000,
    D3DUSAGE_QUERY_WRAPANDMIP    = 0x00200000,
}

enum : int
{
    D3DUSAGE_WRITEONLY          = 0x00000008,
    D3DUSAGE_SOFTWAREPROCESSING = 0x00000010,
}

enum : int
{
    D3DUSAGE_DONOTCLIP                       = 0x00000020,
    D3DUSAGE_POINTS                          = 0x00000040,
    D3DUSAGE_RTPATCHES                       = 0x00000080,
    D3DUSAGE_NPATCHES                        = 0x00000100,
    D3DUSAGE_TEXTAPI                         = 0x10000000,
    D3DUSAGE_RESTRICTED_CONTENT              = 0x00000800,
    D3DUSAGE_RESTRICT_SHARED_RESOURCE        = 0x00002000,
    D3DUSAGE_RESTRICT_SHARED_RESOURCE_DRIVER = 0x00001000,
}

enum : int
{
    D3DLOCK_READONLY        = 0x00000010,
    D3DLOCK_DISCARD         = 0x00002000,
    D3DLOCK_NOOVERWRITE     = 0x00001000,
    D3DLOCK_NOSYSLOCK       = 0x00000800,
    D3DLOCK_DONOTWAIT       = 0x00004000,
    D3DLOCK_NO_DIRTY_UPDATE = 0x00008000,
}

enum uint MAX_DEVICE_IDENTIFIER_STRING = 0x00000200U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dissue-end
    D3DISSUE_END   = 0x00000001U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dissue-begin
    D3DISSUE_BEGIN = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dgetdata-flush
enum uint D3DGETDATA_FLUSH = 0x00000001U;
enum uint D3DCOMPOSERECTS_MAXNUMRECTS = 0x0000ffffU;

enum : uint
{
    D3DCONVOLUTIONMONO_MAXWIDTH  = 0x00000007U,
    D3DCONVOLUTIONMONO_MAXHEIGHT = 0x00000007U,
}

enum : uint
{
    D3DFMT_A1_SURFACE_MAXWIDTH  = 0x00002000U,
    D3DFMT_A1_SURFACE_MAXHEIGHT = 0x00000800U,
}

enum : uint
{
    D3D9_RESOURCE_PRIORITY_MINIMUM = 0x28000000U,
    D3D9_RESOURCE_PRIORITY_LOW     = 0x50000000U,
    D3D9_RESOURCE_PRIORITY_NORMAL  = 0x78000000U,
    D3D9_RESOURCE_PRIORITY_HIGH    = 0xa0000000U,
    D3D9_RESOURCE_PRIORITY_MAXIMUM = 0xc8000000U,
}

enum uint D3D_OMAC_SIZE = 0x00000010U;

enum : GUID
{
    D3DAUTHENTICATEDQUERY_PROTECTION                               = GUID("a84eb584-c495-48aa-b94d-8bd2d6fbce05"),
    D3DAUTHENTICATEDQUERY_CHANNELTYPE                              = GUID("bc1b18a5-b1fb-42ab-bd94-b5828b4bf7be"),
    D3DAUTHENTICATEDQUERY_DEVICEHANDLE                             = GUID("ec1c539d-8cff-4e2a-bcc4-f5692f99f480"),
    D3DAUTHENTICATEDQUERY_CRYPTOSESSION                            = GUID("2634499e-d018-4d74-ac17-7f724059528d"),
    D3DAUTHENTICATEDQUERY_RESTRICTEDSHAREDRESOURCEPROCESSCOUNT     = GUID("0db207b3-9450-46a6-82de-1b96d44f9cf2"),
    D3DAUTHENTICATEDQUERY_RESTRICTEDSHAREDRESOURCEPROCESS          = GUID("649bbadb-f0f4-4639-a15b-24393fc3abac"),
    D3DAUTHENTICATEDQUERY_UNRESTRICTEDPROTECTEDSHAREDRESOURCECOUNT = GUID("012f0bd6-e662-4474-befd-aa53e5143c6d"),
}

enum : GUID
{
    D3DAUTHENTICATEDQUERY_OUTPUTIDCOUNT                     = GUID("2c042b5e-8c07-46d5-aabe-8f75cbad4c31"),
    D3DAUTHENTICATEDQUERY_OUTPUTID                          = GUID("839ddca3-9b4e-41e4-b053-892bd2a11ee7"),
    D3DAUTHENTICATEDQUERY_ACCESSIBILITYATTRIBUTES           = GUID("6214d9d2-432c-4abb-9fce-216eea269e3b"),
    D3DAUTHENTICATEDQUERY_ENCRYPTIONWHENACCESSIBLEGUIDCOUNT = GUID("b30f7066-203c-4b07-93fc-ceaafd61241e"),
    D3DAUTHENTICATEDQUERY_ENCRYPTIONWHENACCESSIBLEGUID      = GUID("f83a5958-e986-4bda-beb0-411f6a7a01b7"),
    D3DAUTHENTICATEDQUERY_CURRENTENCRYPTIONWHENACCESSIBLE   = GUID("ec1791c7-dad3-4f15-9ec3-faa93d60d4f0"),
}

enum : GUID
{
    D3DAUTHENTICATEDCONFIGURE_INITIALIZE               = GUID("06114bdb-3523-470a-8dca-fbc2845154f0"),
    D3DAUTHENTICATEDCONFIGURE_PROTECTION               = GUID("50455658-3f47-4362-bf99-bfdfcde9ed29"),
    D3DAUTHENTICATEDCONFIGURE_CRYPTOSESSION            = GUID("6346cc54-2cfc-4ad4-8224-d15837de7700"),
    D3DAUTHENTICATEDCONFIGURE_SHAREDRESOURCE           = GUID("0772d047-1b40-48e8-9ca6-b5f510de9f01"),
    D3DAUTHENTICATEDCONFIGURE_ENCRYPTIONWHENACCESSIBLE = GUID("41fff286-6ae0-4d43-9d55-a46e9efd158a"),
}

enum int D3DTRANSFORMCAPS_CLIP = 0x00000001;

enum : int
{
    D3DLIGHTINGMODEL_RGB  = 0x00000001,
    D3DLIGHTINGMODEL_MONO = 0x00000002,
}

enum : int
{
    D3DLIGHTCAPS_POINT         = 0x00000001,
    D3DLIGHTCAPS_SPOT          = 0x00000002,
    D3DLIGHTCAPS_DIRECTIONAL   = 0x00000004,
    D3DLIGHTCAPS_PARALLELPOINT = 0x00000008,
    D3DLIGHTCAPS_GLSPOT        = 0x00000010,
}

enum : int
{
    D3DPMISCCAPS_MASKPLANES     = 0x00000001,
    D3DPMISCCAPS_LINEPATTERNREP = 0x00000004,
    D3DPMISCCAPS_CONFORMANT     = 0x00000008,
}

enum : int
{
    D3DPRASTERCAPS_ROP2                       = 0x00000002,
    D3DPRASTERCAPS_XOR                        = 0x00000004,
    D3DPRASTERCAPS_PAT                        = 0x00000008,
    D3DPRASTERCAPS_SUBPIXEL                   = 0x00000020,
    D3DPRASTERCAPS_SUBPIXELX                  = 0x00000040,
    D3DPRASTERCAPS_STIPPLE                    = 0x00000200,
    D3DPRASTERCAPS_ANTIALIASSORTDEPENDENT     = 0x00000400,
    D3DPRASTERCAPS_ANTIALIASSORTINDEPENDENT   = 0x00000800,
    D3DPRASTERCAPS_ANTIALIASEDGES             = 0x00001000,
    D3DPRASTERCAPS_ZBIAS                      = 0x00004000,
    D3DPRASTERCAPS_TRANSLUCENTSORTINDEPENDENT = 0x00080000,
}

enum : int
{
    D3DPSHADECAPS_COLORFLATMONO        = 0x00000001,
    D3DPSHADECAPS_COLORFLATRGB         = 0x00000002,
    D3DPSHADECAPS_COLORGOURAUDMONO     = 0x00000004,
    D3DPSHADECAPS_COLORPHONGMONO       = 0x00000010,
    D3DPSHADECAPS_COLORPHONGRGB        = 0x00000020,
    D3DPSHADECAPS_SPECULARFLATMONO     = 0x00000040,
    D3DPSHADECAPS_SPECULARFLATRGB      = 0x00000080,
    D3DPSHADECAPS_SPECULARGOURAUDMONO  = 0x00000100,
    D3DPSHADECAPS_SPECULARPHONGMONO    = 0x00000400,
    D3DPSHADECAPS_SPECULARPHONGRGB     = 0x00000800,
    D3DPSHADECAPS_ALPHAFLATBLEND       = 0x00001000,
    D3DPSHADECAPS_ALPHAFLATSTIPPLED    = 0x00002000,
    D3DPSHADECAPS_ALPHAGOURAUDSTIPPLED = 0x00008000,
    D3DPSHADECAPS_ALPHAPHONGBLEND      = 0x00010000,
    D3DPSHADECAPS_ALPHAPHONGSTIPPLED   = 0x00020000,
    D3DPSHADECAPS_FOGFLAT              = 0x00040000,
    D3DPSHADECAPS_FOGPHONG             = 0x00100000,
}

enum : int
{
    D3DPTEXTURECAPS_TRANSPARENCY  = 0x00000008,
    D3DPTEXTURECAPS_BORDER        = 0x00000010,
    D3DPTEXTURECAPS_COLORKEYBLEND = 0x00001000,
}

enum : int
{
    D3DPTFILTERCAPS_NEAREST           = 0x00000001,
    D3DPTFILTERCAPS_LINEAR            = 0x00000002,
    D3DPTFILTERCAPS_MIPNEAREST        = 0x00000004,
    D3DPTFILTERCAPS_MIPLINEAR         = 0x00000008,
    D3DPTFILTERCAPS_LINEARMIPNEAREST  = 0x00000010,
    D3DPTFILTERCAPS_LINEARMIPLINEAR   = 0x00000020,
    D3DPTFILTERCAPS_MAGFAFLATCUBIC    = 0x08000000,
    D3DPTFILTERCAPS_MAGFGAUSSIANCUBIC = 0x10000000,
}

enum : int
{
    D3DPTBLENDCAPS_DECAL         = 0x00000001,
    D3DPTBLENDCAPS_MODULATE      = 0x00000002,
    D3DPTBLENDCAPS_DECALALPHA    = 0x00000004,
    D3DPTBLENDCAPS_MODULATEALPHA = 0x00000008,
    D3DPTBLENDCAPS_DECALMASK     = 0x00000010,
    D3DPTBLENDCAPS_MODULATEMASK  = 0x00000020,
    D3DPTBLENDCAPS_COPY          = 0x00000040,
    D3DPTBLENDCAPS_ADD           = 0x00000080,
}

enum int D3DDD_COLORMODEL = 0x00000001;

enum : int
{
    D3DDD_DEVCAPS       = 0x00000002,
    D3DDD_TRANSFORMCAPS = 0x00000004,
}

enum int D3DDD_LIGHTINGCAPS = 0x00000008;
enum int D3DDD_BCLIPPING = 0x00000010;

enum : int
{
    D3DDD_LINECAPS              = 0x00000020,
    D3DDD_TRICAPS               = 0x00000040,
    D3DDD_DEVICERENDERBITDEPTH  = 0x00000080,
    D3DDD_DEVICEZBUFFERBITDEPTH = 0x00000100,
}

enum : int
{
    D3DDD_MAXBUFFERSIZE  = 0x00000200,
    D3DDD_MAXVERTEXCOUNT = 0x00000400,
}

enum : int
{
    D3DDEVCAPS_FLOATTLVERTEX   = 0x00000001,
    D3DDEVCAPS_SORTINCREASINGZ = 0x00000002,
    D3DDEVCAPS_SORTDECREASINGZ = 0x00000004,
    D3DDEVCAPS_SORTEXACT       = 0x00000008,
}

enum int D3DVTXPCAPS_VERTEXFOG = 0x00000004;

enum : int
{
    D3DFDS_COLORMODEL   = 0x00000001,
    D3DFDS_GUID         = 0x00000002,
    D3DFDS_HARDWARE     = 0x00000004,
    D3DFDS_TRIANGLES    = 0x00000008,
    D3DFDS_LINES        = 0x00000010,
    D3DFDS_MISCCAPS     = 0x00000020,
    D3DFDS_RASTERCAPS   = 0x00000040,
    D3DFDS_ZCMPCAPS     = 0x00000080,
    D3DFDS_ALPHACMPCAPS = 0x00000100,
}

enum int D3DFDS_SRCBLENDCAPS = 0x00000200;
enum int D3DFDS_DSTBLENDCAPS = 0x00000400;

enum : int
{
    D3DFDS_SHADECAPS          = 0x00000800,
    D3DFDS_TEXTURECAPS        = 0x00001000,
    D3DFDS_TEXTUREFILTERCAPS  = 0x00002000,
    D3DFDS_TEXTUREBLENDCAPS   = 0x00004000,
    D3DFDS_TEXTUREADDRESSCAPS = 0x00008000,
}

enum : int
{
    D3DDEB_BUFSIZE          = 0x00000001,
    D3DDEB_CAPS             = 0x00000002,
    D3DDEB_LPDATA           = 0x00000004,
    D3DDEBCAPS_SYSTEMMEMORY = 0x00000001,
    D3DDEBCAPS_VIDEOMEMORY  = 0x00000002,
}

enum : int
{
    D3DCLIP_LEFT   = 0x00000001,
    D3DCLIP_RIGHT  = 0x00000002,
    D3DCLIP_TOP    = 0x00000004,
    D3DCLIP_BOTTOM = 0x00000008,
    D3DCLIP_FRONT  = 0x00000010,
    D3DCLIP_BACK   = 0x00000020,
    D3DCLIP_GEN0   = 0x00000040,
    D3DCLIP_GEN1   = 0x00000080,
    D3DCLIP_GEN2   = 0x00000100,
    D3DCLIP_GEN3   = 0x00000200,
    D3DCLIP_GEN4   = 0x00000400,
    D3DCLIP_GEN5   = 0x00000800,
}

enum : int
{
    D3DSTATUS_CLIPUNIONLEFT          = 0x00000001,
    D3DSTATUS_CLIPUNIONRIGHT         = 0x00000002,
    D3DSTATUS_CLIPUNIONTOP           = 0x00000004,
    D3DSTATUS_CLIPUNIONBOTTOM        = 0x00000008,
    D3DSTATUS_CLIPUNIONFRONT         = 0x00000010,
    D3DSTATUS_CLIPUNIONBACK          = 0x00000020,
    D3DSTATUS_CLIPUNIONGEN0          = 0x00000040,
    D3DSTATUS_CLIPUNIONGEN1          = 0x00000080,
    D3DSTATUS_CLIPUNIONGEN2          = 0x00000100,
    D3DSTATUS_CLIPUNIONGEN3          = 0x00000200,
    D3DSTATUS_CLIPUNIONGEN4          = 0x00000400,
    D3DSTATUS_CLIPUNIONGEN5          = 0x00000800,
    D3DSTATUS_CLIPINTERSECTIONLEFT   = 0x00001000,
    D3DSTATUS_CLIPINTERSECTIONRIGHT  = 0x00002000,
    D3DSTATUS_CLIPINTERSECTIONTOP    = 0x00004000,
    D3DSTATUS_CLIPINTERSECTIONBOTTOM = 0x00008000,
    D3DSTATUS_CLIPINTERSECTIONFRONT  = 0x00010000,
    D3DSTATUS_CLIPINTERSECTIONBACK   = 0x00020000,
    D3DSTATUS_CLIPINTERSECTIONGEN0   = 0x00040000,
    D3DSTATUS_CLIPINTERSECTIONGEN1   = 0x00080000,
    D3DSTATUS_CLIPINTERSECTIONGEN2   = 0x00100000,
    D3DSTATUS_CLIPINTERSECTIONGEN3   = 0x00200000,
    D3DSTATUS_CLIPINTERSECTIONGEN4   = 0x00400000,
    D3DSTATUS_CLIPINTERSECTIONGEN5   = 0x00800000,
}

enum int D3DSTATUS_ZNOTVISIBLE = 0x01000000;

enum : int
{
    D3DTRANSFORM_CLIPPED   = 0x00000001,
    D3DTRANSFORM_UNCLIPPED = 0x00000002,
}

enum : uint
{
    D3DLIGHT_ACTIVE      = 0x00000001U,
    D3DLIGHT_NO_SPECULAR = 0x00000002U,
}

enum : uint
{
    D3DCOLOR_MONO = 0x00000001U,
    D3DCOLOR_RGB  = 0x00000002U,
}

enum uint D3DSTATE_OVERRIDE_BIAS = 0x00000100U;

enum : int
{
    D3DPROCESSVERTICES_TRANSFORMLIGHT = 0x00000000,
    D3DPROCESSVERTICES_TRANSFORM      = 0x00000001,
    D3DPROCESSVERTICES_COPY           = 0x00000002,
    D3DPROCESSVERTICES_OPMASK         = 0x00000007,
    D3DPROCESSVERTICES_UPDATEEXTENTS  = 0x00000008,
    D3DPROCESSVERTICES_NOCOLOR        = 0x00000010,
}

enum : int
{
    D3DTRIFLAG_START       = 0x00000000,
    D3DTRIFLAG_ODD         = 0x0000001e,
    D3DTRIFLAG_EVEN        = 0x0000001f,
    D3DTRIFLAG_EDGEENABLE1 = 0x00000100,
    D3DTRIFLAG_EDGEENABLE2 = 0x00000200,
    D3DTRIFLAG_EDGEENABLE3 = 0x00000400,
}

enum : int
{
    D3DSETSTATUS_STATUS  = 0x00000001,
    D3DSETSTATUS_EXTENTS = 0x00000002,
}

enum : int
{
    D3DCLIPSTATUS_STATUS   = 0x00000001,
    D3DCLIPSTATUS_EXTENTS2 = 0x00000002,
    D3DCLIPSTATUS_EXTENTS3 = 0x00000004,
}

enum : int
{
    D3DEXECUTE_CLIPPED   = 0x00000001,
    D3DEXECUTE_UNCLIPPED = 0x00000002,
}

enum : uint
{
    D3DPAL_FREE     = 0x00000000U,
    D3DPAL_READONLY = 0x00000040U,
    D3DPAL_RESERVED = 0x00000080U,
}

enum : int
{
    D3DVBCAPS_SYSTEMMEMORY = 0x00000800,
    D3DVBCAPS_WRITEONLY    = 0x00010000,
    D3DVBCAPS_OPTIMIZED    = 0x80000000,
    D3DVBCAPS_DONOTCLIP    = 0x00000001,
}

enum : uint
{
    D3DVOP_LIGHT     = 0x00000400U,
    D3DVOP_TRANSFORM = 0x00000001U,
    D3DVOP_CLIP      = 0x00000004U,
    D3DVOP_EXTENTS   = 0x00000008U,
}

enum uint D3DFVF_RESERVED1 = 0x00000020U;

enum : uint
{
    D3DVIS_INSIDE_FRUSTUM    = 0x00000000U,
    D3DVIS_INTERSECT_FRUSTUM = 0x00000001U,
}

enum uint D3DVIS_OUTSIDE_FRUSTUM = 0x00000002U;

enum : uint
{
    D3DVIS_INSIDE_LEFT    = 0x00000000U,
    D3DVIS_INTERSECT_LEFT = 0x00000004U,
}

enum uint D3DVIS_OUTSIDE_LEFT = 0x00000008U;

enum : uint
{
    D3DVIS_INSIDE_RIGHT    = 0x00000000U,
    D3DVIS_INTERSECT_RIGHT = 0x00000010U,
}

enum uint D3DVIS_OUTSIDE_RIGHT = 0x00000020U;

enum : uint
{
    D3DVIS_INSIDE_TOP    = 0x00000000U,
    D3DVIS_INTERSECT_TOP = 0x00000040U,
}

enum uint D3DVIS_OUTSIDE_TOP = 0x00000080U;

enum : uint
{
    D3DVIS_INSIDE_BOTTOM    = 0x00000000U,
    D3DVIS_INTERSECT_BOTTOM = 0x00000100U,
}

enum uint D3DVIS_OUTSIDE_BOTTOM = 0x00000200U;

enum : uint
{
    D3DVIS_INSIDE_NEAR    = 0x00000000U,
    D3DVIS_INTERSECT_NEAR = 0x00000400U,
}

enum uint D3DVIS_OUTSIDE_NEAR = 0x00000800U;

enum : uint
{
    D3DVIS_INSIDE_FAR    = 0x00000000U,
    D3DVIS_INTERSECT_FAR = 0x00001000U,
}

enum uint D3DVIS_OUTSIDE_FAR = 0x00002000U;

enum : uint
{
    D3DVIS_MASK_FRUSTUM = 0x00000003U,
    D3DVIS_MASK_LEFT    = 0x0000000cU,
    D3DVIS_MASK_RIGHT   = 0x00000030U,
    D3DVIS_MASK_TOP     = 0x000000c0U,
    D3DVIS_MASK_BOTTOM  = 0x00000300U,
    D3DVIS_MASK_NEAR    = 0x00000c00U,
    D3DVIS_MASK_FAR     = 0x00003000U,
}

enum : uint
{
    D3DDEVINFOID_TEXTUREMANAGER    = 0x00000001U,
    D3DDEVINFOID_D3DTEXTUREMANAGER = 0x00000002U,
    D3DDEVINFOID_TEXTURING         = 0x00000003U,
}

// Callbacks

alias LPD3DVALIDATECALLBACK = HRESULT function(void* lpUserArg, uint dwOffset);
alias LPD3DENUMTEXTUREFORMATSCALLBACK = HRESULT function(DDSURFACEDESC* lpDdsd, void* lpContext);
alias LPD3DENUMPIXELFORMATSCALLBACK = HRESULT function(DDPIXELFORMAT* lpDDPixFmt, void* lpContext);
alias LPD3DENUMDEVICESCALLBACK = HRESULT function(GUID* lpGuid, PSTR lpDeviceDescription, PSTR lpDeviceName, 
                                                  D3DDEVICEDESC* param3, D3DDEVICEDESC* param4, void* param5);
alias LPD3DENUMDEVICESCALLBACK7 = HRESULT function(PSTR lpDeviceDescription, PSTR lpDeviceName, 
                                                   D3DDEVICEDESC7* param2, void* param3);

// Structs


version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dadapter-identifier9
    struct D3DADAPTER_IDENTIFIER9
    {
        CHAR[512] Driver;
        CHAR[512] Description;
        CHAR[32]  DeviceName;
        long      DriverVersion;
        uint      VendorId;
        uint      DeviceId;
        uint      SubSysId;
        uint      Revision;
        GUID      DeviceIdentifier;
        uint      WHQLLevel;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dadapter-identifier9
    struct D3DADAPTER_IDENTIFIER9
    {
        CHAR[512] Driver;
        CHAR[512] Description;
        CHAR[32]  DeviceName;
        long      DriverVersion;
        uint      VendorId;
        uint      DeviceId;
        uint      SubSysId;
        uint      Revision;
        GUID      DeviceIdentifier;
        uint      WHQLLevel;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dmemorypressure
    struct D3DMEMORYPRESSURE
    {
        ulong BytesEvictedFromProcess;
        ulong SizeOfInefficientAllocation;
        uint  LevelOfEfficiency;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dmemorypressure
    struct D3DMEMORYPRESSURE
    {
        ulong BytesEvictedFromProcess;
        ulong SizeOfInefficientAllocation;
        uint  LevelOfEfficiency;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dpresentstats
    struct D3DPRESENTSTATS
    {
        uint PresentCount;
        uint PresentRefreshCount;
        uint SyncRefreshCount;
        long SyncQPCTime;
        long SyncGPUTime;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dpresentstats
    struct D3DPRESENTSTATS
    {
        uint PresentCount;
        uint PresentRefreshCount;
        uint SyncRefreshCount;
        long SyncQPCTime;
        long SyncGPUTime;
    }
}

version(X86_64)
{
    struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTID_OUTPUT
    {
        D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
        HANDLE DeviceHandle;
        HANDLE CryptoSessionHandle;
        uint   OutputIDIndex;
        ulong  OutputID;
    }
}

version(AArch64)
{
    struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTID_OUTPUT
    {
        D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
        HANDLE DeviceHandle;
        HANDLE CryptoSessionHandle;
        uint   OutputIDIndex;
        ulong  OutputID;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3daes-ctr-iv
    struct D3DAES_CTR_IV
    {
        ulong IV;
        ulong Count;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3daes-ctr-iv
    struct D3DAES_CTR_IV
    {
        ulong IV;
        ulong Count;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3ddxgi/d3dcolorvalue
struct D3DCOLORVALUE
{
    float r;
    float g;
    float b;
    float a;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3drect
struct D3DRECT
{
    int x1;
    int y1;
    int x2;
    int y2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dviewport9
struct D3DVIEWPORT9
{
    uint  X;
    uint  Y;
    uint  Width;
    uint  Height;
    float MinZ;
    float MaxZ;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dclipstatus9
struct D3DCLIPSTATUS9
{
    uint ClipUnion;
    uint ClipIntersection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dmaterial9
struct D3DMATERIAL9
{
    D3DCOLORVALUE Diffuse;
    D3DCOLORVALUE Ambient;
    D3DCOLORVALUE Specular;
    D3DCOLORVALUE Emissive;
    float         Power;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dlight9
struct D3DLIGHT9
{
    D3DLIGHTTYPE  Type;
    D3DCOLORVALUE Diffuse;
    D3DCOLORVALUE Specular;
    D3DCOLORVALUE Ambient;
    D3DVECTOR     Position;
    D3DVECTOR     Direction;
    float         Range;
    float         Falloff;
    float         Attenuation0;
    float         Attenuation1;
    float         Attenuation2;
    float         Theta;
    float         Phi;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dvertexelement9
struct D3DVERTEXELEMENT9
{
    ushort Stream;
    ushort Offset;
    ubyte  Type;
    ubyte  Method;
    ubyte  Usage;
    ubyte  UsageIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddisplaymode
struct D3DDISPLAYMODE
{
    uint      Width;
    uint      Height;
    uint      RefreshRate;
    D3DFORMAT Format;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddevice-creation-parameters
struct D3DDEVICE_CREATION_PARAMETERS
{
    uint       AdapterOrdinal;
    D3DDEVTYPE DeviceType;
    HWND       hFocusWindow;
    uint       BehaviorFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dpresent-parameters
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dgammaramp
struct D3DGAMMARAMP
{
    ushort[256] red;
    ushort[256] green;
    ushort[256] blue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dvertexbuffer-desc
struct D3DVERTEXBUFFER_DESC
{
    D3DFORMAT       Format;
    D3DRESOURCETYPE Type;
    uint            Usage;
    D3DPOOL         Pool;
    uint            Size;
    uint            FVF;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dindexbuffer-desc
struct D3DINDEXBUFFER_DESC
{
    D3DFORMAT       Format;
    D3DRESOURCETYPE Type;
    uint            Usage;
    D3DPOOL         Pool;
    uint            Size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dsurface-desc
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dvolume-desc
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dlocked-rect
struct D3DLOCKED_RECT
{
    int   Pitch;
    void* pBits;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dbox
struct D3DBOX
{
    uint Left;
    uint Top;
    uint Right;
    uint Bottom;
    uint Front;
    uint Back;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dlocked-box
struct D3DLOCKED_BOX
{
    int   RowPitch;
    int   SlicePitch;
    void* pBits;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3drange
struct D3DRANGE
{
    uint Offset;
    uint Size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3drectpatch-info
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dtripatch-info
struct D3DTRIPATCH_INFO
{
    uint          StartVertexOffset;
    uint          NumVertices;
    D3DBASISTYPE  Basis;
    D3DDEGREETYPE Degree;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dadapter-identifier9
    struct D3DADAPTER_IDENTIFIER9
    {
    align (4):
        CHAR[512] Driver;
        CHAR[512] Description;
        CHAR[32]  DeviceName;
        long      DriverVersion;
        uint      VendorId;
        uint      DeviceId;
        uint      SubSysId;
        uint      Revision;
        GUID      DeviceIdentifier;
        uint      WHQLLevel;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3draster-status
struct D3DRASTER_STATUS
{
    BOOL InVBlank;
    uint ScanLine;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dresourcestats
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddevinfo-resourcemanager
struct D3DDEVINFO_RESOURCEMANAGER
{
    D3DRESOURCESTATS[8] stats;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddevinfo-d3dvertexstats
struct D3DDEVINFO_D3DVERTEXSTATS
{
    uint NumRenderedTriangles;
    uint NumExtraClippingTriangles;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddevinfo-vcache
struct D3DDEVINFO_VCACHE
{
    uint Pattern;
    uint OptMethod;
    uint CacheSize;
    uint MagicNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddevinfo-d3d9pipelinetimings
struct D3DDEVINFO_D3D9PIPELINETIMINGS
{
    float VertexProcessingTimePercent;
    float PixelProcessingTimePercent;
    float OtherGPUProcessingTimePercent;
    float GPUIdleTimePercent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddevinfo-d3d9interfacetimings
struct D3DDEVINFO_D3D9INTERFACETIMINGS
{
    float WaitingForGPUToUseApplicationResourceTimePercent;
    float WaitingForGPUToAcceptMoreCommandsTimePercent;
    float WaitingForGPUToStayWithinLatencyTimePercent;
    float WaitingForGPUExclusiveResourceTimePercent;
    float WaitingForGPUOtherTimePercent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddevinfo-d3d9stagetimings
struct D3DDEVINFO_D3D9STAGETIMINGS
{
    float MemoryProcessingPercent;
    float ComputationProcessingPercent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddevinfo-d3d9bandwidthtimings
struct D3DDEVINFO_D3D9BANDWIDTHTIMINGS
{
    float MaxBandwidthUtilized;
    float FrontEndUploadMemoryUtilizedPercent;
    float VertexRateUtilizedPercent;
    float TriangleSetupRateUtilizedPercent;
    float FillRateUtilizedPercent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddevinfo-d3d9cacheutilization
struct D3DDEVINFO_D3D9CACHEUTILIZATION
{
    float TextureCacheHitRate;
    float PostTransformVertexCacheHitRate;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dmemorypressure
    struct D3DMEMORYPRESSURE
    {
    align (4):
        ulong BytesEvictedFromProcess;
        ulong SizeOfInefficientAllocation;
        uint  LevelOfEfficiency;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dcomposerectdesc
struct D3DCOMPOSERECTDESC
{
    ushort X;
    ushort Y;
    ushort Width;
    ushort Height;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dcomposerectdestination
struct D3DCOMPOSERECTDESTINATION
{
    ushort SrcRectIndex;
    ushort Reserved;
    short  X;
    short  Y;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3dpresentstats
    struct D3DPRESENTSTATS
    {
    align (4):
        uint PresentCount;
        uint PresentRefreshCount;
        uint SyncRefreshCount;
        long SyncQPCTime;
        long SyncGPUTime;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddisplaymodeex
struct D3DDISPLAYMODEEX
{
    uint                Size;
    uint                Width;
    uint                Height;
    uint                RefreshRate;
    D3DFORMAT           Format;
    D3DSCANLINEORDERING ScanLineOrdering;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3ddisplaymodefilter
struct D3DDISPLAYMODEFILTER
{
    uint                Size;
    D3DFORMAT           Format;
    D3DSCANLINEORDERING ScanLineOrdering;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3d-omac
struct D3D_OMAC
{
    ubyte[16] Omac;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-query-input
struct D3DAUTHENTICATEDCHANNEL_QUERY_INPUT
{
    GUID   QueryType;
    HANDLE hChannel;
    uint   SequenceNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-query-output
struct D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
{
    D3D_OMAC omac;
    GUID     QueryType;
    HANDLE   hChannel;
    uint     SequenceNumber;
    HRESULT  ReturnCode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-protection-flags
struct D3DAUTHENTICATEDCHANNEL_PROTECTION_FLAGS
{
    union
    {
        struct
        {
            // Native bit field: ProtectionEnabled: [0], OverlayOrFullscreenRequired: [1], Reserved: [2-31]
            uint _bitfield0;
        }
        uint Value;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryprotection-output
struct D3DAUTHENTICATEDCHANNEL_QUERYPROTECTION_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    D3DAUTHENTICATEDCHANNEL_PROTECTION_FLAGS ProtectionFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-querychanneltype-output
struct D3DAUTHENTICATEDCHANNEL_QUERYCHANNELTYPE_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    D3DAUTHENTICATEDCHANNELTYPE ChannelType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-querydevicehandle-output
struct D3DAUTHENTICATEDCHANNEL_QUERYDEVICEHANDLE_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    HANDLE DeviceHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-querycryptosession-input
struct D3DAUTHENTICATEDCHANNEL_QUERYCRYPTOSESSION_INPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_INPUT Input;
    HANDLE DXVA2DecodeHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-querycryptosession-output
struct D3DAUTHENTICATEDCHANNEL_QUERYCRYPTOSESSION_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    HANDLE DXVA2DecodeHandle;
    HANDLE CryptoSessionHandle;
    HANDLE DeviceHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryrestrictedsharedresourceprocesscount-output
struct D3DAUTHENTICATEDCHANNEL_QUERYRESTRICTEDSHAREDRESOURCEPROCESSCOUNT_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    uint NumRestrictedSharedResourceProcesses;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryrestrictedsharedresourceprocess-input
struct D3DAUTHENTICATEDCHANNEL_QUERYRESTRICTEDSHAREDRESOURCEPROCESS_INPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_INPUT Input;
    uint ProcessIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryrestrictedsharedresourceprocess-output
struct D3DAUTHENTICATEDCHANNEL_QUERYRESTRICTEDSHAREDRESOURCEPROCESS_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    uint   ProcessIndex;
    D3DAUTHENTICATEDCHANNEL_PROCESSIDENTIFIERTYPE ProcessIdentifer;
    HANDLE ProcessHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryunrestrictedprotectedsharedresourcecount-output
struct D3DAUTHENTICATEDCHANNEL_QUERYUNRESTRICTEDPROTECTEDSHAREDRESOURCECOUNT_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    uint NumUnrestrictedProtectedSharedResources;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryoutputidcount-input
struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTIDCOUNT_INPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_INPUT Input;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryoutputidcount-output
struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTIDCOUNT_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
    uint   NumOutputIDs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryoutputid-input
struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTID_INPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_INPUT Input;
    HANDLE DeviceHandle;
    HANDLE CryptoSessionHandle;
    uint   OutputIDIndex;
}

version(X86)
{
    struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTID_OUTPUT
    {
    align (4):
        D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
        HANDLE DeviceHandle;
        HANDLE CryptoSessionHandle;
        uint   OutputIDIndex;
        ulong  OutputID;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryinfobustype-output
struct D3DAUTHENTICATEDCHANNEL_QUERYINFOBUSTYPE_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    D3DBUSTYPE BusType;
    BOOL       bAccessibleInContiguousBlocks;
    BOOL       bAccessibleInNonContiguousBlocks;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryevictionencryptionguidcount-output
struct D3DAUTHENTICATEDCHANNEL_QUERYEVICTIONENCRYPTIONGUIDCOUNT_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    uint NumEncryptionGuids;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryevictionencryptionguid-input
struct D3DAUTHENTICATEDCHANNEL_QUERYEVICTIONENCRYPTIONGUID_INPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_INPUT Input;
    uint EncryptionGuidIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryevictionencryptionguid-output
struct D3DAUTHENTICATEDCHANNEL_QUERYEVICTIONENCRYPTIONGUID_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    uint EncryptionGuidIndex;
    GUID EncryptionGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-queryuncompressedencryptionlevel-output
struct D3DAUTHENTICATEDCHANNEL_QUERYUNCOMPRESSEDENCRYPTIONLEVEL_OUTPUT
{
    D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT Output;
    GUID EncryptionGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-configure-input
struct D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT
{
    D3D_OMAC omac;
    GUID     ConfigureType;
    HANDLE   hChannel;
    uint     SequenceNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-configure-output
struct D3DAUTHENTICATEDCHANNEL_CONFIGURE_OUTPUT
{
    D3D_OMAC omac;
    GUID     ConfigureType;
    HANDLE   hChannel;
    uint     SequenceNumber;
    HRESULT  ReturnCode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-configureinitialize
struct D3DAUTHENTICATEDCHANNEL_CONFIGUREINITIALIZE
{
    D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT Parameters;
    uint StartSequenceQuery;
    uint StartSequenceConfigure;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-configureprotection
struct D3DAUTHENTICATEDCHANNEL_CONFIGUREPROTECTION
{
    D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT Parameters;
    D3DAUTHENTICATEDCHANNEL_PROTECTION_FLAGS Protections;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-configurecryptosession
struct D3DAUTHENTICATEDCHANNEL_CONFIGURECRYPTOSESSION
{
    D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT Parameters;
    HANDLE DXVA2DecodeHandle;
    HANDLE CryptoSessionHandle;
    HANDLE DeviceHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-configuresharedresource
struct D3DAUTHENTICATEDCHANNEL_CONFIGURESHAREDRESOURCE
{
    D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT Parameters;
    D3DAUTHENTICATEDCHANNEL_PROCESSIDENTIFIERTYPE ProcessIdentiferType;
    HANDLE ProcessHandle;
    BOOL   AllowAccess;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dauthenticatedchannel-configureuncompressedencryption
struct D3DAUTHENTICATEDCHANNEL_CONFIGUREUNCOMPRESSEDENCRYPTION
{
    D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT Parameters;
    GUID EncryptionGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3dencrypted-block-info
struct D3DENCRYPTED_BLOCK_INFO
{
    uint NumEncryptedBytesAtBeginning;
    uint NumBytesInSkipPattern;
    uint NumBytesInEncryptPattern;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/d3daes-ctr-iv
    struct D3DAES_CTR_IV
    {
    align (4):
        ulong IV;
        ulong Count;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9caps/ns-d3d9caps-d3dvshadercaps2_0
struct D3DVSHADERCAPS2_0
{
    uint Caps;
    int  DynamicFlowControlDepth;
    int  NumTemps;
    int  StaticFlowControlDepth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9caps/ns-d3d9caps-d3dpshadercaps2_0
struct D3DPSHADERCAPS2_0
{
    uint Caps;
    int  DynamicFlowControlDepth;
    int  NumTemps;
    int  StaticFlowControlDepth;
    int  NumInstructionSlots;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9caps/ns-d3d9caps-d3dcaps9
struct D3DCAPS9
{
    D3DDEVTYPE        DeviceType;
    uint              AdapterOrdinal;
    uint              Caps;
    uint              Caps2;
    uint              Caps3;
    uint              PresentationIntervals;
    uint              CursorCaps;
    uint              DevCaps;
    uint              PrimitiveMiscCaps;
    uint              RasterCaps;
    uint              ZCmpCaps;
    uint              SrcBlendCaps;
    uint              DestBlendCaps;
    uint              AlphaCmpCaps;
    uint              ShadeCaps;
    uint              TextureCaps;
    uint              TextureFilterCaps;
    uint              CubeTextureFilterCaps;
    uint              VolumeTextureFilterCaps;
    uint              TextureAddressCaps;
    uint              VolumeTextureAddressCaps;
    uint              LineCaps;
    uint              MaxTextureWidth;
    uint              MaxTextureHeight;
    uint              MaxVolumeExtent;
    uint              MaxTextureRepeat;
    uint              MaxTextureAspectRatio;
    uint              MaxAnisotropy;
    float             MaxVertexW;
    float             GuardBandLeft;
    float             GuardBandTop;
    float             GuardBandRight;
    float             GuardBandBottom;
    float             ExtentsAdjust;
    uint              StencilCaps;
    uint              FVFCaps;
    uint              TextureOpCaps;
    uint              MaxTextureBlendStages;
    uint              MaxSimultaneousTextures;
    uint              VertexProcessingCaps;
    uint              MaxActiveLights;
    uint              MaxUserClipPlanes;
    uint              MaxVertexBlendMatrices;
    uint              MaxVertexBlendMatrixIndex;
    float             MaxPointSize;
    uint              MaxPrimitiveCount;
    uint              MaxVertexIndex;
    uint              MaxStreams;
    uint              MaxStreamStride;
    uint              VertexShaderVersion;
    uint              MaxVertexShaderConst;
    uint              PixelShaderVersion;
    float             PixelShader1xMaxValue;
    uint              DevCaps2;
    float             MaxNpatchTessellationLevel;
    uint              Reserved5;
    uint              MasterAdapterOrdinal;
    uint              AdapterOrdinalInGroup;
    uint              NumberOfAdaptersInGroup;
    uint              DeclTypes;
    uint              NumSimultaneousRTs;
    uint              StretchRectFilterCaps;
    D3DVSHADERCAPS2_0 VS20Caps;
    D3DPSHADERCAPS2_0 PS20Caps;
    uint              VertexTextureFilterCaps;
    uint              MaxVShaderInstructionsExecuted;
    uint              MaxPShaderInstructionsExecuted;
    uint              MaxVertexShader30InstructionSlots;
    uint              MaxPixelShader30InstructionSlots;
}

struct D3DHVERTEX
{
    uint dwFlags;
    union
    {
        float hx;
        float dvHX;
    }
    union
    {
        float hy;
        float dvHY;
    }
    union
    {
        float hz;
        float dvHZ;
    }
}

struct D3DTLVERTEX
{
    union
    {
        float sx;
        float dvSX;
    }
    union
    {
        float sy;
        float dvSY;
    }
    union
    {
        float sz;
        float dvSZ;
    }
    union
    {
        float rhw;
        float dvRHW;
    }
    union
    {
        uint color;
        uint dcColor;
    }
    union
    {
        uint specular;
        uint dcSpecular;
    }
    union
    {
        float tu;
        float dvTU;
    }
    union
    {
        float tv;
        float dvTV;
    }
}

struct D3DLVERTEX
{
    union
    {
        float x;
        float dvX;
    }
    union
    {
        float y;
        float dvY;
    }
    union
    {
        float z;
        float dvZ;
    }
    uint dwReserved;
    union
    {
        uint color;
        uint dcColor;
    }
    union
    {
        uint specular;
        uint dcSpecular;
    }
    union
    {
        float tu;
        float dvTU;
    }
    union
    {
        float tv;
        float dvTV;
    }
}

struct D3DVERTEX
{
    union
    {
        float x;
        float dvX;
    }
    union
    {
        float y;
        float dvY;
    }
    union
    {
        float z;
        float dvZ;
    }
    union
    {
        float nx;
        float dvNX;
    }
    union
    {
        float ny;
        float dvNY;
    }
    union
    {
        float nz;
        float dvNZ;
    }
    union
    {
        float tu;
        float dvTU;
    }
    union
    {
        float tv;
        float dvTV;
    }
}

struct D3DVIEWPORT
{
    uint  dwSize;
    uint  dwX;
    uint  dwY;
    uint  dwWidth;
    uint  dwHeight;
    float dvScaleX;
    float dvScaleY;
    float dvMaxX;
    float dvMaxY;
    float dvMinZ;
    float dvMaxZ;
}

struct D3DVIEWPORT2
{
    uint  dwSize;
    uint  dwX;
    uint  dwY;
    uint  dwWidth;
    uint  dwHeight;
    float dvClipX;
    float dvClipY;
    float dvClipWidth;
    float dvClipHeight;
    float dvMinZ;
    float dvMaxZ;
}

struct D3DVIEWPORT7
{
    uint  dwX;
    uint  dwY;
    uint  dwWidth;
    uint  dwHeight;
    float dvMinZ;
    float dvMaxZ;
}

struct D3DTRANSFORMDATA
{
    uint        dwSize;
    void*       lpIn;
    uint        dwInSize;
    void*       lpOut;
    uint        dwOutSize;
    D3DHVERTEX* lpHOut;
    uint        dwClip;
    uint        dwClipIntersection;
    uint        dwClipUnion;
    D3DRECT     drExtent;
}

struct D3DLIGHTINGELEMENT
{
    D3DVECTOR dvPosition;
    D3DVECTOR dvNormal;
}

struct D3DMATERIAL
{
    uint dwSize;
    union
    {
        D3DCOLORVALUE diffuse;
        D3DCOLORVALUE dcvDiffuse;
    }
    union
    {
        D3DCOLORVALUE ambient;
        D3DCOLORVALUE dcvAmbient;
    }
    union
    {
        D3DCOLORVALUE specular;
        D3DCOLORVALUE dcvSpecular;
    }
    union
    {
        D3DCOLORVALUE emissive;
        D3DCOLORVALUE dcvEmissive;
    }
    union
    {
        float power;
        float dvPower;
    }
    uint hTexture;
    uint dwRampSize;
}

struct D3DMATERIAL7
{
    union
    {
        D3DCOLORVALUE diffuse;
        D3DCOLORVALUE dcvDiffuse;
    }
    union
    {
        D3DCOLORVALUE ambient;
        D3DCOLORVALUE dcvAmbient;
    }
    union
    {
        D3DCOLORVALUE specular;
        D3DCOLORVALUE dcvSpecular;
    }
    union
    {
        D3DCOLORVALUE emissive;
        D3DCOLORVALUE dcvEmissive;
    }
    union
    {
        float power;
        float dvPower;
    }
}

struct D3DLIGHT
{
    uint          dwSize;
    D3DLIGHTTYPE  dltType;
    D3DCOLORVALUE dcvColor;
    D3DVECTOR     dvPosition;
    D3DVECTOR     dvDirection;
    float         dvRange;
    float         dvFalloff;
    float         dvAttenuation0;
    float         dvAttenuation1;
    float         dvAttenuation2;
    float         dvTheta;
    float         dvPhi;
}

struct D3DLIGHT7
{
    D3DLIGHTTYPE  dltType;
    D3DCOLORVALUE dcvDiffuse;
    D3DCOLORVALUE dcvSpecular;
    D3DCOLORVALUE dcvAmbient;
    D3DVECTOR     dvPosition;
    D3DVECTOR     dvDirection;
    float         dvRange;
    float         dvFalloff;
    float         dvAttenuation0;
    float         dvAttenuation1;
    float         dvAttenuation2;
    float         dvTheta;
    float         dvPhi;
}

struct D3DLIGHT2
{
    uint          dwSize;
    D3DLIGHTTYPE  dltType;
    D3DCOLORVALUE dcvColor;
    D3DVECTOR     dvPosition;
    D3DVECTOR     dvDirection;
    float         dvRange;
    float         dvFalloff;
    float         dvAttenuation0;
    float         dvAttenuation1;
    float         dvAttenuation2;
    float         dvTheta;
    float         dvPhi;
    uint          dwFlags;
}

struct D3DLIGHTDATA
{
    uint                dwSize;
    D3DLIGHTINGELEMENT* lpIn;
    uint                dwInSize;
    D3DTLVERTEX*        lpOut;
    uint                dwOutSize;
}

struct D3DINSTRUCTION
{
    ubyte  bOpcode;
    ubyte  bSize;
    ushort wCount;
}

struct D3DTEXTURELOAD
{
    uint hDestTexture;
    uint hSrcTexture;
}

struct D3DPICKRECORD
{
    ubyte bOpcode;
    ubyte bPad;
    uint  dwOffset;
    float dvZ;
}

struct D3DSTATE
{
    union
    {
        D3DLIGHTSTATETYPE  dlstLightStateType;
        D3DRENDERSTATETYPE drstRenderStateType;
    }
    union
    {
        uint[1]  dwArg;
        float[1] dvArg; // Flexible array
    }
}

struct D3DMATRIXLOAD
{
    uint hDestMatrix;
    uint hSrcMatrix;
}

struct D3DMATRIXMULTIPLY
{
    uint hDestMatrix;
    uint hSrcMatrix1;
    uint hSrcMatrix2;
}

struct D3DPROCESSVERTICES
{
    uint   dwFlags;
    ushort wStart;
    ushort wDest;
    uint   dwCount;
    uint   dwReserved;
}

struct D3DTRIANGLE
{
    union
    {
        ushort v1;
        ushort wV1;
    }
    union
    {
        ushort v2;
        ushort wV2;
    }
    union
    {
        ushort v3;
        ushort wV3;
    }
    ushort wFlags;
}

struct D3DLINE
{
    union
    {
        ushort v1;
        ushort wV1;
    }
    union
    {
        ushort v2;
        ushort wV2;
    }
}

struct D3DSPAN
{
    ushort wCount;
    ushort wFirst;
}

struct D3DPOINT
{
    ushort wCount;
    ushort wFirst;
}

struct D3DBRANCH
{
    uint dwMask;
    uint dwValue;
    BOOL bNegate;
    uint dwOffset;
}

struct D3DSTATUS
{
    uint    dwFlags;
    uint    dwStatus;
    D3DRECT drExtent;
}

struct D3DCLIPSTATUS
{
    uint  dwFlags;
    uint  dwStatus;
    float minx;
    float maxx;
    float miny;
    float maxy;
    float minz;
    float maxz;
}

struct D3DSTATS
{
    uint dwSize;
    uint dwTrianglesDrawn;
    uint dwLinesDrawn;
    uint dwPointsDrawn;
    uint dwSpansDrawn;
    uint dwVerticesProcessed;
}

struct D3DEXECUTEDATA
{
    uint      dwSize;
    uint      dwVertexOffset;
    uint      dwVertexCount;
    uint      dwInstructionOffset;
    uint      dwInstructionLength;
    uint      dwHVertexOffset;
    D3DSTATUS dsStatus;
}

struct D3DVERTEXBUFFERDESC
{
    uint dwSize;
    uint dwCaps;
    uint dwFVF;
    uint dwNumVertices;
}

struct D3DDP_PTRSTRIDE
{
    void* lpvData;
    uint  dwStride;
}

struct D3DDRAWPRIMITIVESTRIDEDDATA
{
    D3DDP_PTRSTRIDE    position;
    D3DDP_PTRSTRIDE    normal;
    D3DDP_PTRSTRIDE    diffuse;
    D3DDP_PTRSTRIDE    specular;
    D3DDP_PTRSTRIDE[8] textureCoords;
}

struct D3DTRANSFORMCAPS
{
    uint dwSize;
    uint dwCaps;
}

struct D3DLIGHTINGCAPS
{
    uint dwSize;
    uint dwCaps;
    uint dwLightingModel;
    uint dwNumLights;
}

struct D3DPRIMCAPS
{
    uint dwSize;
    uint dwMiscCaps;
    uint dwRasterCaps;
    uint dwZCmpCaps;
    uint dwSrcBlendCaps;
    uint dwDestBlendCaps;
    uint dwAlphaCmpCaps;
    uint dwShadeCaps;
    uint dwTextureCaps;
    uint dwTextureFilterCaps;
    uint dwTextureBlendCaps;
    uint dwTextureAddressCaps;
    uint dwStippleWidth;
    uint dwStippleHeight;
}

struct D3DDEVICEDESC
{
    uint             dwSize;
    uint             dwFlags;
    uint             dcmColorModel;
    uint             dwDevCaps;
    D3DTRANSFORMCAPS dtcTransformCaps;
    BOOL             bClipping;
    D3DLIGHTINGCAPS  dlcLightingCaps;
    D3DPRIMCAPS      dpcLineCaps;
    D3DPRIMCAPS      dpcTriCaps;
    uint             dwDeviceRenderBitDepth;
    uint             dwDeviceZBufferBitDepth;
    uint             dwMaxBufferSize;
    uint             dwMaxVertexCount;
    uint             dwMinTextureWidth;
    uint             dwMinTextureHeight;
    uint             dwMaxTextureWidth;
    uint             dwMaxTextureHeight;
    uint             dwMinStippleWidth;
    uint             dwMaxStippleWidth;
    uint             dwMinStippleHeight;
    uint             dwMaxStippleHeight;
    uint             dwMaxTextureRepeat;
    uint             dwMaxTextureAspectRatio;
    uint             dwMaxAnisotropy;
    float            dvGuardBandLeft;
    float            dvGuardBandTop;
    float            dvGuardBandRight;
    float            dvGuardBandBottom;
    float            dvExtentsAdjust;
    uint             dwStencilCaps;
    uint             dwFVFCaps;
    uint             dwTextureOpCaps;
    ushort           wMaxTextureBlendStages;
    ushort           wMaxSimultaneousTextures;
}

struct D3DDEVICEDESC7
{
    uint        dwDevCaps;
    D3DPRIMCAPS dpcLineCaps;
    D3DPRIMCAPS dpcTriCaps;
    uint        dwDeviceRenderBitDepth;
    uint        dwDeviceZBufferBitDepth;
    uint        dwMinTextureWidth;
    uint        dwMinTextureHeight;
    uint        dwMaxTextureWidth;
    uint        dwMaxTextureHeight;
    uint        dwMaxTextureRepeat;
    uint        dwMaxTextureAspectRatio;
    uint        dwMaxAnisotropy;
    float       dvGuardBandLeft;
    float       dvGuardBandTop;
    float       dvGuardBandRight;
    float       dvGuardBandBottom;
    float       dvExtentsAdjust;
    uint        dwStencilCaps;
    uint        dwFVFCaps;
    uint        dwTextureOpCaps;
    ushort      wMaxTextureBlendStages;
    ushort      wMaxSimultaneousTextures;
    uint        dwMaxActiveLights;
    float       dvMaxVertexW;
    GUID        deviceGUID;
    ushort      wMaxUserClipPlanes;
    ushort      wMaxVertexBlendMatrices;
    uint        dwVertexProcessingCaps;
    uint        dwReserved1;
    uint        dwReserved2;
    uint        dwReserved3;
    uint        dwReserved4;
}

struct D3DFINDDEVICESEARCH
{
    uint        dwSize;
    uint        dwFlags;
    BOOL        bHardware;
    uint        dcmColorModel;
    GUID        guid;
    uint        dwCaps;
    D3DPRIMCAPS dpcPrimCaps;
}

struct D3DFINDDEVICERESULT
{
    uint          dwSize;
    GUID          guid;
    D3DDEVICEDESC ddHwDesc;
    D3DDEVICEDESC ddSwDesc;
}

struct D3DEXECUTEBUFFERDESC
{
    uint  dwSize;
    uint  dwFlags;
    uint  dwCaps;
    uint  dwBufferSize;
    void* lpData;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-direct3dcreate9
@DllImport("d3d9.dll")
IDirect3D9 Direct3DCreate9(uint SDKVersion);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3d9/nf-d3d9-d3dperf_beginevent
@DllImport("d3d9.dll")
int D3DPERF_BeginEvent(uint col, const(PWSTR) wszName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3d9/nf-d3d9-d3dperf_endevent
@DllImport("d3d9.dll")
int D3DPERF_EndEvent();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3d9/nf-d3d9-d3dperf_setmarker
@DllImport("d3d9.dll")
void D3DPERF_SetMarker(uint col, const(PWSTR) wszName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3d9/nf-d3d9-d3dperf_setregion
@DllImport("d3d9.dll")
void D3DPERF_SetRegion(uint col, const(PWSTR) wszName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3d9/nf-d3d9-d3dperf_queryrepeatframe
@DllImport("d3d9.dll")
BOOL D3DPERF_QueryRepeatFrame();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3d9/nf-d3d9-d3dperf_setoptions
@DllImport("d3d9.dll")
void D3DPERF_SetOptions(uint dwOptions);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/direct3d9/d3d9/nf-d3d9-d3dperf_getstatus
@DllImport("d3d9.dll")
uint D3DPERF_GetStatus();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-direct3dcreate9ex
@DllImport("d3d9.dll")
HRESULT Direct3DCreate9Ex(uint SDKVersion, IDirect3D9Ex* param1);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3d9
@GUID("81bdcbca-64d4-426d-ae8d-ad0147f4275c")
interface IDirect3D9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-registersoftwaredevice
    HRESULT  RegisterSoftwareDevice(void* pInitializeFunction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-getadaptercount
    uint     GetAdapterCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-getadapteridentifier
    HRESULT  GetAdapterIdentifier(uint Adapter, uint Flags, D3DADAPTER_IDENTIFIER9* pIdentifier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-getadaptermodecount
    uint     GetAdapterModeCount(uint Adapter, D3DFORMAT Format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-enumadaptermodes
    HRESULT  EnumAdapterModes(uint Adapter, D3DFORMAT Format, uint Mode, D3DDISPLAYMODE* pMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-getadapterdisplaymode
    HRESULT  GetAdapterDisplayMode(uint Adapter, D3DDISPLAYMODE* pMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-checkdevicetype
    HRESULT  CheckDeviceType(uint Adapter, D3DDEVTYPE DevType, D3DFORMAT AdapterFormat, D3DFORMAT BackBufferFormat, 
                             BOOL bWindowed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-checkdeviceformat
    HRESULT  CheckDeviceFormat(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT AdapterFormat, uint Usage, 
                               D3DRESOURCETYPE RType, D3DFORMAT CheckFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-checkdevicemultisampletype
    HRESULT  CheckDeviceMultiSampleType(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT SurfaceFormat, 
                                        BOOL Windowed, D3DMULTISAMPLE_TYPE MultiSampleType, uint* pQualityLevels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-checkdepthstencilmatch
    HRESULT  CheckDepthStencilMatch(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT AdapterFormat, 
                                    D3DFORMAT RenderTargetFormat, D3DFORMAT DepthStencilFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-checkdeviceformatconversion
    HRESULT  CheckDeviceFormatConversion(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT SourceFormat, 
                                         D3DFORMAT TargetFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-getdevicecaps
    HRESULT  GetDeviceCaps(uint Adapter, D3DDEVTYPE DeviceType, D3DCAPS9* pCaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-getadaptermonitor
    HMONITOR GetAdapterMonitor(uint Adapter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9-createdevice
    HRESULT  CreateDevice(uint Adapter, D3DDEVTYPE DeviceType, HWND hFocusWindow, uint BehaviorFlags, 
                          D3DPRESENT_PARAMETERS* pPresentationParameters, 
                          IDirect3DDevice9* ppReturnedDeviceInterface);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3ddevice9
@GUID("d0223b96-bf7a-43fd-92bd-a43b0d82b9eb")
interface IDirect3DDevice9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-testcooperativelevel
    HRESULT TestCooperativeLevel();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getavailabletexturemem
    uint    GetAvailableTextureMem();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-evictmanagedresources
    HRESULT EvictManagedResources();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getdirect3d
    HRESULT GetDirect3D(IDirect3D9* ppD3D9);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getdevicecaps
    HRESULT GetDeviceCaps(D3DCAPS9* pCaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getdisplaymode
    HRESULT GetDisplayMode(uint iSwapChain, D3DDISPLAYMODE* pMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getcreationparameters
    HRESULT GetCreationParameters(D3DDEVICE_CREATION_PARAMETERS* pParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setcursorproperties
    HRESULT SetCursorProperties(uint XHotSpot, uint YHotSpot, IDirect3DSurface9 pCursorBitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setcursorposition
    void    SetCursorPosition(int X, int Y, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-showcursor
    BOOL    ShowCursor(BOOL bShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createadditionalswapchain
    HRESULT CreateAdditionalSwapChain(D3DPRESENT_PARAMETERS* pPresentationParameters, 
                                      IDirect3DSwapChain9* pSwapChain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getswapchain
    HRESULT GetSwapChain(uint iSwapChain, IDirect3DSwapChain9* pSwapChain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getnumberofswapchains
    uint    GetNumberOfSwapChains();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-reset
    HRESULT Reset(D3DPRESENT_PARAMETERS* pPresentationParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-present
    HRESULT Present(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, 
                    const(RGNDATA)* pDirtyRegion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getbackbuffer
    HRESULT GetBackBuffer(uint iSwapChain, uint iBackBuffer, D3DBACKBUFFER_TYPE Type, 
                          IDirect3DSurface9* ppBackBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getrasterstatus
    HRESULT GetRasterStatus(uint iSwapChain, D3DRASTER_STATUS* pRasterStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setdialogboxmode
    HRESULT SetDialogBoxMode(BOOL bEnableDialogs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setgammaramp
    void    SetGammaRamp(uint iSwapChain, uint Flags, const(D3DGAMMARAMP)* pRamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getgammaramp
    void    GetGammaRamp(uint iSwapChain, D3DGAMMARAMP* pRamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createtexture
    HRESULT CreateTexture(uint Width, uint Height, uint Levels, uint Usage, D3DFORMAT Format, D3DPOOL Pool, 
                          IDirect3DTexture9* ppTexture, HANDLE* pSharedHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createvolumetexture
    HRESULT CreateVolumeTexture(uint Width, uint Height, uint Depth, uint Levels, uint Usage, D3DFORMAT Format, 
                                D3DPOOL Pool, IDirect3DVolumeTexture9* ppVolumeTexture, HANDLE* pSharedHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createcubetexture
    HRESULT CreateCubeTexture(uint EdgeLength, uint Levels, uint Usage, D3DFORMAT Format, D3DPOOL Pool, 
                              IDirect3DCubeTexture9* ppCubeTexture, HANDLE* pSharedHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createvertexbuffer
    HRESULT CreateVertexBuffer(uint Length, uint Usage, uint FVF, D3DPOOL Pool, 
                               IDirect3DVertexBuffer9* ppVertexBuffer, HANDLE* pSharedHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createindexbuffer
    HRESULT CreateIndexBuffer(uint Length, uint Usage, D3DFORMAT Format, D3DPOOL Pool, 
                              IDirect3DIndexBuffer9* ppIndexBuffer, HANDLE* pSharedHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createrendertarget
    HRESULT CreateRenderTarget(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                               uint MultisampleQuality, BOOL Lockable, IDirect3DSurface9* ppSurface, 
                               HANDLE* pSharedHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createdepthstencilsurface
    HRESULT CreateDepthStencilSurface(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                                      uint MultisampleQuality, BOOL Discard, IDirect3DSurface9* ppSurface, 
                                      HANDLE* pSharedHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-updatesurface
    HRESULT UpdateSurface(IDirect3DSurface9 pSourceSurface, const(RECT)* pSourceRect, 
                          IDirect3DSurface9 pDestinationSurface, const(POINT)* pDestPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-updatetexture
    HRESULT UpdateTexture(IDirect3DBaseTexture9 pSourceTexture, IDirect3DBaseTexture9 pDestinationTexture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getrendertargetdata
    HRESULT GetRenderTargetData(IDirect3DSurface9 pRenderTarget, IDirect3DSurface9 pDestSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getfrontbufferdata
    HRESULT GetFrontBufferData(uint iSwapChain, IDirect3DSurface9 pDestSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-stretchrect
    HRESULT StretchRect(IDirect3DSurface9 pSourceSurface, const(RECT)* pSourceRect, IDirect3DSurface9 pDestSurface, 
                        const(RECT)* pDestRect, D3DTEXTUREFILTERTYPE Filter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-colorfill
    HRESULT ColorFill(IDirect3DSurface9 pSurface, const(RECT)* pRect, uint color);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createoffscreenplainsurface
    HRESULT CreateOffscreenPlainSurface(uint Width, uint Height, D3DFORMAT Format, D3DPOOL Pool, 
                                        IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setrendertarget
    HRESULT SetRenderTarget(uint RenderTargetIndex, IDirect3DSurface9 pRenderTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getrendertarget
    HRESULT GetRenderTarget(uint RenderTargetIndex, IDirect3DSurface9* ppRenderTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setdepthstencilsurface
    HRESULT SetDepthStencilSurface(IDirect3DSurface9 pNewZStencil);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getdepthstencilsurface
    HRESULT GetDepthStencilSurface(IDirect3DSurface9* ppZStencilSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-beginscene
    HRESULT BeginScene();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-endscene
    HRESULT EndScene();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-clear
    HRESULT Clear(uint Count, const(D3DRECT)* pRects, uint Flags, uint Color, float Z, uint Stencil);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-settransform
    HRESULT SetTransform(D3DTRANSFORMSTATETYPE State, const(D3DMATRIX)* pMatrix);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-gettransform
    HRESULT GetTransform(D3DTRANSFORMSTATETYPE State, D3DMATRIX* pMatrix);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-multiplytransform
    HRESULT MultiplyTransform(D3DTRANSFORMSTATETYPE param0, const(D3DMATRIX)* param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setviewport
    HRESULT SetViewport(const(D3DVIEWPORT9)* pViewport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getviewport
    HRESULT GetViewport(D3DVIEWPORT9* pViewport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setmaterial
    HRESULT SetMaterial(const(D3DMATERIAL9)* pMaterial);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getmaterial
    HRESULT GetMaterial(D3DMATERIAL9* pMaterial);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setlight
    HRESULT SetLight(uint Index, const(D3DLIGHT9)* param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getlight
    HRESULT GetLight(uint Index, D3DLIGHT9* param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-lightenable
    HRESULT LightEnable(uint Index, BOOL Enable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getlightenable
    HRESULT GetLightEnable(uint Index, BOOL* pEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setclipplane
    HRESULT SetClipPlane(uint Index, const(float)* pPlane);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getclipplane
    HRESULT GetClipPlane(uint Index, float* pPlane);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setrenderstate
    HRESULT SetRenderState(D3DRENDERSTATETYPE State, uint Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getrenderstate
    HRESULT GetRenderState(D3DRENDERSTATETYPE State, uint* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createstateblock
    HRESULT CreateStateBlock(D3DSTATEBLOCKTYPE Type, IDirect3DStateBlock9* ppSB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-beginstateblock
    HRESULT BeginStateBlock();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-endstateblock
    HRESULT EndStateBlock(IDirect3DStateBlock9* ppSB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setclipstatus
    HRESULT SetClipStatus(const(D3DCLIPSTATUS9)* pClipStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getclipstatus
    HRESULT GetClipStatus(D3DCLIPSTATUS9* pClipStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-gettexture
    HRESULT GetTexture(uint Stage, IDirect3DBaseTexture9* ppTexture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-settexture
    HRESULT SetTexture(uint Stage, IDirect3DBaseTexture9 pTexture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-gettexturestagestate
    HRESULT GetTextureStageState(uint Stage, D3DTEXTURESTAGESTATETYPE Type, uint* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-settexturestagestate
    HRESULT SetTextureStageState(uint Stage, D3DTEXTURESTAGESTATETYPE Type, uint Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getsamplerstate
    HRESULT GetSamplerState(uint Sampler, D3DSAMPLERSTATETYPE Type, uint* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setsamplerstate
    HRESULT SetSamplerState(uint Sampler, D3DSAMPLERSTATETYPE Type, uint Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-validatedevice
    HRESULT ValidateDevice(uint* pNumPasses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setpaletteentries
    HRESULT SetPaletteEntries(uint PaletteNumber, const(PALETTEENTRY)* pEntries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getpaletteentries
    HRESULT GetPaletteEntries(uint PaletteNumber, PALETTEENTRY* pEntries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setcurrenttexturepalette
    HRESULT SetCurrentTexturePalette(uint PaletteNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getcurrenttexturepalette
    HRESULT GetCurrentTexturePalette(uint* PaletteNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setscissorrect
    HRESULT SetScissorRect(const(RECT)* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getscissorrect
    HRESULT GetScissorRect(RECT* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setsoftwarevertexprocessing
    HRESULT SetSoftwareVertexProcessing(BOOL bSoftware);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getsoftwarevertexprocessing
    BOOL    GetSoftwareVertexProcessing();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setnpatchmode
    HRESULT SetNPatchMode(float nSegments);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getnpatchmode
    float   GetNPatchMode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-drawprimitive
    HRESULT DrawPrimitive(D3DPRIMITIVETYPE PrimitiveType, uint StartVertex, uint PrimitiveCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-drawindexedprimitive
    HRESULT DrawIndexedPrimitive(D3DPRIMITIVETYPE param0, int BaseVertexIndex, uint MinVertexIndex, 
                                 uint NumVertices, uint startIndex, uint primCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-drawprimitiveup
    HRESULT DrawPrimitiveUP(D3DPRIMITIVETYPE PrimitiveType, uint PrimitiveCount, 
                            const(void)* pVertexStreamZeroData, uint VertexStreamZeroStride);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-drawindexedprimitiveup
    HRESULT DrawIndexedPrimitiveUP(D3DPRIMITIVETYPE PrimitiveType, uint MinVertexIndex, uint NumVertices, 
                                   uint PrimitiveCount, const(void)* pIndexData, D3DFORMAT IndexDataFormat, 
                                   const(void)* pVertexStreamZeroData, uint VertexStreamZeroStride);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-processvertices
    HRESULT ProcessVertices(uint SrcStartIndex, uint DestIndex, uint VertexCount, 
                            IDirect3DVertexBuffer9 pDestBuffer, IDirect3DVertexDeclaration9 pVertexDecl, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createvertexdeclaration
    HRESULT CreateVertexDeclaration(const(D3DVERTEXELEMENT9)* pVertexElements, IDirect3DVertexDeclaration9* ppDecl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setvertexdeclaration
    HRESULT SetVertexDeclaration(IDirect3DVertexDeclaration9 pDecl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getvertexdeclaration
    HRESULT GetVertexDeclaration(IDirect3DVertexDeclaration9* ppDecl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setfvf
    HRESULT SetFVF(uint FVF);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getfvf
    HRESULT GetFVF(uint* pFVF);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createvertexshader
    HRESULT CreateVertexShader(const(uint)* pFunction, IDirect3DVertexShader9* ppShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setvertexshader
    HRESULT SetVertexShader(IDirect3DVertexShader9 pShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getvertexshader
    HRESULT GetVertexShader(IDirect3DVertexShader9* ppShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setvertexshaderconstantf
    HRESULT SetVertexShaderConstantF(uint StartRegister, const(float)* pConstantData, uint Vector4fCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getvertexshaderconstantf
    HRESULT GetVertexShaderConstantF(uint StartRegister, float* pConstantData, uint Vector4fCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setvertexshaderconstanti
    HRESULT SetVertexShaderConstantI(uint StartRegister, const(int)* pConstantData, uint Vector4iCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getvertexshaderconstanti
    HRESULT GetVertexShaderConstantI(uint StartRegister, int* pConstantData, uint Vector4iCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setvertexshaderconstantb
    HRESULT SetVertexShaderConstantB(uint StartRegister, const(BOOL)* pConstantData, uint BoolCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getvertexshaderconstantb
    HRESULT GetVertexShaderConstantB(uint StartRegister, BOOL* pConstantData, uint BoolCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setstreamsource
    HRESULT SetStreamSource(uint StreamNumber, IDirect3DVertexBuffer9 pStreamData, uint OffsetInBytes, uint Stride);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getstreamsource
    HRESULT GetStreamSource(uint StreamNumber, IDirect3DVertexBuffer9* ppStreamData, uint* pOffsetInBytes, 
                            uint* pStride);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setstreamsourcefreq
    HRESULT SetStreamSourceFreq(uint StreamNumber, uint Setting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getstreamsourcefreq
    HRESULT GetStreamSourceFreq(uint StreamNumber, uint* pSetting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setindices
    HRESULT SetIndices(IDirect3DIndexBuffer9 pIndexData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getindices
    HRESULT GetIndices(IDirect3DIndexBuffer9* ppIndexData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createpixelshader
    HRESULT CreatePixelShader(const(uint)* pFunction, IDirect3DPixelShader9* ppShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setpixelshader
    HRESULT SetPixelShader(IDirect3DPixelShader9 pShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getpixelshader
    HRESULT GetPixelShader(IDirect3DPixelShader9* ppShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setpixelshaderconstantf
    HRESULT SetPixelShaderConstantF(uint StartRegister, const(float)* pConstantData, uint Vector4fCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getpixelshaderconstantf
    HRESULT GetPixelShaderConstantF(uint StartRegister, float* pConstantData, uint Vector4fCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setpixelshaderconstanti
    HRESULT SetPixelShaderConstantI(uint StartRegister, const(int)* pConstantData, uint Vector4iCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getpixelshaderconstanti
    HRESULT GetPixelShaderConstantI(uint StartRegister, int* pConstantData, uint Vector4iCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-setpixelshaderconstantb
    HRESULT SetPixelShaderConstantB(uint StartRegister, const(BOOL)* pConstantData, uint BoolCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-getpixelshaderconstantb
    HRESULT GetPixelShaderConstantB(uint StartRegister, BOOL* pConstantData, uint BoolCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-drawrectpatch
    HRESULT DrawRectPatch(uint Handle, const(float)* pNumSegs, const(D3DRECTPATCH_INFO)* pRectPatchInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-drawtripatch
    HRESULT DrawTriPatch(uint Handle, const(float)* pNumSegs, const(D3DTRIPATCH_INFO)* pTriPatchInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-deletepatch
    HRESULT DeletePatch(uint Handle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9-createquery
    HRESULT CreateQuery(D3DQUERYTYPE Type, IDirect3DQuery9* ppQuery);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dstateblock9
@GUID("b07c4fe5-310d-4ba8-a23c-4f0f206f218b")
interface IDirect3DStateBlock9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dstateblock9-getdevice
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dstateblock9-capture
    HRESULT Capture();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dstateblock9-apply
    HRESULT Apply();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dswapchain9
@GUID("794950f2-adfc-458a-905e-10a10b0b503b")
interface IDirect3DSwapChain9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dswapchain9-present
    HRESULT Present(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, 
                    const(RGNDATA)* pDirtyRegion, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dswapchain9-getfrontbufferdata
    HRESULT GetFrontBufferData(IDirect3DSurface9 pDestSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dswapchain9-getbackbuffer
    HRESULT GetBackBuffer(uint iBackBuffer, D3DBACKBUFFER_TYPE Type, IDirect3DSurface9* ppBackBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dswapchain9-getrasterstatus
    HRESULT GetRasterStatus(D3DRASTER_STATUS* pRasterStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dswapchain9-getdisplaymode
    HRESULT GetDisplayMode(D3DDISPLAYMODE* pMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dswapchain9-getdevice
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dswapchain9-getpresentparameters
    HRESULT GetPresentParameters(D3DPRESENT_PARAMETERS* pPresentationParameters);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dresource9
@GUID("05eec05d-8f7d-4362-b999-d1baf357c704")
interface IDirect3DResource9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dresource9-getdevice
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dresource9-setprivatedata
    HRESULT SetPrivateData(const(GUID)* refguid, const(void)* pData, uint SizeOfData, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dresource9-getprivatedata
    HRESULT GetPrivateData(const(GUID)* refguid, void* pData, uint* pSizeOfData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dresource9-freeprivatedata
    HRESULT FreePrivateData(const(GUID)* refguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dresource9-setpriority
    uint    SetPriority(uint PriorityNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dresource9-getpriority
    uint    GetPriority();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dresource9-preload
    void    PreLoad();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dresource9-gettype
    D3DRESOURCETYPE GetType();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dvertexdeclaration9
@GUID("dd13c59c-36fa-4098-a8fb-c7ed39dc8546")
interface IDirect3DVertexDeclaration9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvertexdeclaration9-getdevice
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvertexdeclaration9-getdeclaration
    HRESULT GetDeclaration(D3DVERTEXELEMENT9* pElement, uint* pNumElements);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dvertexshader9
@GUID("efc5557e-6265-4613-8a94-43857889eb36")
interface IDirect3DVertexShader9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvertexshader9-getdevice
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvertexshader9-getfunction
    HRESULT GetFunction(void* param0, uint* pSizeOfData);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dpixelshader9
@GUID("6d3bdbdc-5b02-4415-b852-ce5e8bccb289")
interface IDirect3DPixelShader9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dpixelshader9-getdevice
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dpixelshader9-getfunction
    HRESULT GetFunction(void* param0, uint* pSizeOfData);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dbasetexture9
@GUID("580ca87e-1d3c-4d54-991d-b7d3e3c298ce")
interface IDirect3DBaseTexture9 : IDirect3DResource9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dbasetexture9-setlod
    uint    SetLOD(uint LODNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dbasetexture9-getlod
    uint    GetLOD();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dbasetexture9-getlevelcount
    uint    GetLevelCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dbasetexture9-setautogenfiltertype
    HRESULT SetAutoGenFilterType(D3DTEXTUREFILTERTYPE FilterType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dbasetexture9-getautogenfiltertype
    D3DTEXTUREFILTERTYPE GetAutoGenFilterType();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dbasetexture9-generatemipsublevels
    void    GenerateMipSubLevels();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dtexture9
@GUID("85c31227-3de5-4f00-9b3a-f11ac38c18b5")
interface IDirect3DTexture9 : IDirect3DBaseTexture9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dtexture9-getleveldesc
    HRESULT GetLevelDesc(uint Level, D3DSURFACE_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dtexture9-getsurfacelevel
    HRESULT GetSurfaceLevel(uint Level, IDirect3DSurface9* ppSurfaceLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dtexture9-lockrect
    HRESULT LockRect(uint Level, D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dtexture9-unlockrect
    HRESULT UnlockRect(uint Level);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dtexture9-adddirtyrect
    HRESULT AddDirtyRect(const(RECT)* pDirtyRect);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dvolumetexture9
@GUID("2518526c-e789-4111-a7b9-47ef328d13e6")
interface IDirect3DVolumeTexture9 : IDirect3DBaseTexture9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolumetexture9-getleveldesc
    HRESULT GetLevelDesc(uint Level, D3DVOLUME_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolumetexture9-getvolumelevel
    HRESULT GetVolumeLevel(uint Level, IDirect3DVolume9* ppVolumeLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolumetexture9-lockbox
    HRESULT LockBox(uint Level, D3DLOCKED_BOX* pLockedVolume, const(D3DBOX)* pBox, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolumetexture9-unlockbox
    HRESULT UnlockBox(uint Level);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolumetexture9-adddirtybox
    HRESULT AddDirtyBox(const(D3DBOX)* pDirtyBox);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dcubetexture9
@GUID("fff32f81-d953-473a-9223-93d652aba93f")
interface IDirect3DCubeTexture9 : IDirect3DBaseTexture9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dcubetexture9-getleveldesc
    HRESULT GetLevelDesc(uint Level, D3DSURFACE_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dcubetexture9-getcubemapsurface
    HRESULT GetCubeMapSurface(D3DCUBEMAP_FACES FaceType, uint Level, IDirect3DSurface9* ppCubeMapSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dcubetexture9-lockrect
    HRESULT LockRect(D3DCUBEMAP_FACES FaceType, uint Level, D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, 
                     uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dcubetexture9-unlockrect
    HRESULT UnlockRect(D3DCUBEMAP_FACES FaceType, uint Level);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dcubetexture9-adddirtyrect
    HRESULT AddDirtyRect(D3DCUBEMAP_FACES FaceType, const(RECT)* pDirtyRect);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dvertexbuffer9
@GUID("b64bb1b5-fd70-4df6-bf91-19d0a12455e3")
interface IDirect3DVertexBuffer9 : IDirect3DResource9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvertexbuffer9-lock
    HRESULT Lock(uint OffsetToLock, uint SizeToLock, void** ppbData, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvertexbuffer9-unlock
    HRESULT Unlock();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvertexbuffer9-getdesc
    HRESULT GetDesc(D3DVERTEXBUFFER_DESC* pDesc);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dindexbuffer9
@GUID("7c9dd65e-d3f7-4529-acee-785830acde35")
interface IDirect3DIndexBuffer9 : IDirect3DResource9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dindexbuffer9-lock
    HRESULT Lock(uint OffsetToLock, uint SizeToLock, void** ppbData, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dindexbuffer9-unlock
    HRESULT Unlock();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dindexbuffer9-getdesc
    HRESULT GetDesc(D3DINDEXBUFFER_DESC* pDesc);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dsurface9
@GUID("0cfbaf3a-9ff6-429a-99b3-a2796af8b89b")
interface IDirect3DSurface9 : IDirect3DResource9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dsurface9-getcontainer
    HRESULT GetContainer(const(GUID)* riid, void** ppContainer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dsurface9-getdesc
    HRESULT GetDesc(D3DSURFACE_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dsurface9-lockrect
    HRESULT LockRect(D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dsurface9-unlockrect
    HRESULT UnlockRect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dsurface9-getdc
    HRESULT GetDC(HDC* phdc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dsurface9-releasedc
    HRESULT ReleaseDC(HDC hdc);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dvolume9
@GUID("24f416e6-1f67-4aa7-b88e-d33f6f3128a1")
interface IDirect3DVolume9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolume9-getdevice
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolume9-setprivatedata
    HRESULT SetPrivateData(const(GUID)* refguid, const(void)* pData, uint SizeOfData, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolume9-getprivatedata
    HRESULT GetPrivateData(const(GUID)* refguid, void* pData, uint* pSizeOfData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolume9-freeprivatedata
    HRESULT FreePrivateData(const(GUID)* refguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolume9-getcontainer
    HRESULT GetContainer(const(GUID)* riid, void** ppContainer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolume9-getdesc
    HRESULT GetDesc(D3DVOLUME_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolume9-lockbox
    HRESULT LockBox(D3DLOCKED_BOX* pLockedVolume, const(D3DBOX)* pBox, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dvolume9-unlockbox
    HRESULT UnlockBox();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dquery9
@GUID("d9771460-a695-4f26-bbd3-27b840b541cc")
interface IDirect3DQuery9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dquery9-getdevice
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dquery9-gettype
    D3DQUERYTYPE GetType();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dquery9-getdatasize
    uint    GetDataSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dquery9-issue
    HRESULT Issue(uint dwIssueFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dquery9-getdata
    HRESULT GetData(void* pData, uint dwSize, uint dwGetDataFlags);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3d9ex
@GUID("02177241-69fc-400c-8ff1-93a44df6861d")
interface IDirect3D9Ex : IDirect3D9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9ex-getadaptermodecountex
    uint    GetAdapterModeCountEx(uint Adapter, const(D3DDISPLAYMODEFILTER)* pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9ex-enumadaptermodesex
    HRESULT EnumAdapterModesEx(uint Adapter, const(D3DDISPLAYMODEFILTER)* pFilter, uint Mode, 
                               D3DDISPLAYMODEEX* pMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9ex-getadapterdisplaymodeex
    HRESULT GetAdapterDisplayModeEx(uint Adapter, D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9ex-createdeviceex
    HRESULT CreateDeviceEx(uint Adapter, D3DDEVTYPE DeviceType, HWND hFocusWindow, uint BehaviorFlags, 
                           D3DPRESENT_PARAMETERS* pPresentationParameters, D3DDISPLAYMODEEX* pFullscreenDisplayMode, 
                           IDirect3DDevice9Ex* ppReturnedDeviceInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3d9ex-getadapterluid
    HRESULT GetAdapterLUID(uint Adapter, LUID* pLUID);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3ddevice9ex
@GUID("b18b10ce-2649-405a-870f-95f777d4313a")
interface IDirect3DDevice9Ex : IDirect3DDevice9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-setconvolutionmonokernel
    HRESULT SetConvolutionMonoKernel(uint width, uint height, float* rows, float* columns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-composerects
    HRESULT ComposeRects(IDirect3DSurface9 pSrc, IDirect3DSurface9 pDst, IDirect3DVertexBuffer9 pSrcRectDescs, 
                         uint NumRects, IDirect3DVertexBuffer9 pDstRectDescs, D3DCOMPOSERECTSOP Operation, 
                         int Xoffset, int Yoffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-presentex
    HRESULT PresentEx(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, 
                      const(RGNDATA)* pDirtyRegion, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-getgputhreadpriority
    HRESULT GetGPUThreadPriority(int* pPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-setgputhreadpriority
    HRESULT SetGPUThreadPriority(int Priority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-waitforvblank
    HRESULT WaitForVBlank(uint iSwapChain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-checkresourceresidency
    HRESULT CheckResourceResidency(IDirect3DResource9* pResourceArray, uint NumResources);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-setmaximumframelatency
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-getmaximumframelatency
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-checkdevicestate
    HRESULT CheckDeviceState(HWND hDestinationWindow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-createrendertargetex
    HRESULT CreateRenderTargetEx(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                                 uint MultisampleQuality, BOOL Lockable, IDirect3DSurface9* ppSurface, 
                                 HANDLE* pSharedHandle, uint Usage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-createoffscreenplainsurfaceex
    HRESULT CreateOffscreenPlainSurfaceEx(uint Width, uint Height, D3DFORMAT Format, D3DPOOL Pool, 
                                          IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle, uint Usage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-createdepthstencilsurfaceex
    HRESULT CreateDepthStencilSurfaceEx(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                                        uint MultisampleQuality, BOOL Discard, IDirect3DSurface9* ppSurface, 
                                        HANDLE* pSharedHandle, uint Usage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-resetex
    HRESULT ResetEx(D3DPRESENT_PARAMETERS* pPresentationParameters, D3DDISPLAYMODEEX* pFullscreenDisplayMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3ddevice9ex-getdisplaymodeex
    HRESULT GetDisplayModeEx(uint iSwapChain, D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nn-d3d9-idirect3dswapchain9ex
@GUID("91886caf-1c3d-4d2e-a0ab-3e4c7d8d3303")
interface IDirect3DSwapChain9Ex : IDirect3DSwapChain9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dswapchain9ex-getlastpresentcount
    HRESULT GetLastPresentCount(uint* pLastPresentCount);
    HRESULT GetPresentStats(D3DPRESENTSTATS* pPresentationStatistics);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d9/nf-d3d9-idirect3dswapchain9ex-getdisplaymodeex
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
