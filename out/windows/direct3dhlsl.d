module windows.direct3dhlsl;

public import windows.core;
public import windows.com : HRESULT;
public import windows.direct3d10 : ID3D10Effect;
public import windows.direct3d11 : D3D_SHADER_MACRO, ID3D11FunctionLinkingGraph, ID3D11Linker, ID3D11Module, ID3DBlob,
                                   ID3DInclude;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum : int
{
    D3DCOMPILER_STRIP_REFLECTION_DATA = 0x00000001,
    D3DCOMPILER_STRIP_DEBUG_INFO      = 0x00000002,
    D3DCOMPILER_STRIP_TEST_BLOBS      = 0x00000004,
    D3DCOMPILER_STRIP_PRIVATE_DATA    = 0x00000008,
    D3DCOMPILER_STRIP_ROOT_SIGNATURE  = 0x00000010,
    D3DCOMPILER_STRIP_FORCE_DWORD     = 0x7fffffff,
}
alias D3DCOMPILER_STRIP_FLAGS = int;

enum : int
{
    D3D_BLOB_INPUT_SIGNATURE_BLOB            = 0x00000000,
    D3D_BLOB_OUTPUT_SIGNATURE_BLOB           = 0x00000001,
    D3D_BLOB_INPUT_AND_OUTPUT_SIGNATURE_BLOB = 0x00000002,
    D3D_BLOB_PATCH_CONSTANT_SIGNATURE_BLOB   = 0x00000003,
    D3D_BLOB_ALL_SIGNATURE_BLOB              = 0x00000004,
    D3D_BLOB_DEBUG_INFO                      = 0x00000005,
    D3D_BLOB_LEGACY_SHADER                   = 0x00000006,
    D3D_BLOB_XNA_PREPASS_SHADER              = 0x00000007,
    D3D_BLOB_XNA_SHADER                      = 0x00000008,
    D3D_BLOB_PDB                             = 0x00000009,
    D3D_BLOB_PRIVATE_DATA                    = 0x0000000a,
    D3D_BLOB_ROOT_SIGNATURE                  = 0x0000000b,
    D3D_BLOB_DEBUG_NAME                      = 0x0000000c,
    D3D_BLOB_TEST_ALTERNATE_SHADER           = 0x00008000,
    D3D_BLOB_TEST_COMPILE_DETAILS            = 0x00008001,
    D3D_BLOB_TEST_COMPILE_PERF               = 0x00008002,
    D3D_BLOB_TEST_COMPILE_REPORT             = 0x00008003,
}
alias D3D_BLOB_PART = int;

// Constants


enum const(wchar)* D3DCOMPILER_DLL = "d3dcompiler_47.dll";

enum : uint
{
    D3DCOMPILE_DEBUG             = 0x00000001,
    D3DCOMPILE_SKIP_VALIDATION   = 0x00000002,
    D3DCOMPILE_SKIP_OPTIMIZATION = 0x00000004,
}

enum uint D3DCOMPILE_PACK_MATRIX_COLUMN_MAJOR = 0x00000010;

enum : uint
{
    D3DCOMPILE_FORCE_VS_SOFTWARE_NO_OPT = 0x00000040,
    D3DCOMPILE_FORCE_PS_SOFTWARE_NO_OPT = 0x00000080,
}

enum uint D3DCOMPILE_AVOID_FLOW_CONTROL = 0x00000200;

enum : uint
{
    D3DCOMPILE_ENABLE_STRICTNESS              = 0x00000800,
    D3DCOMPILE_ENABLE_BACKWARDS_COMPATIBILITY = 0x00001000,
}

enum : uint
{
    D3DCOMPILE_OPTIMIZATION_LEVEL0 = 0x00004000,
    D3DCOMPILE_OPTIMIZATION_LEVEL1 = 0x00000000,
    D3DCOMPILE_OPTIMIZATION_LEVEL2 = 0x0000c000,
    D3DCOMPILE_OPTIMIZATION_LEVEL3 = 0x00008000,
}

enum : uint
{
    D3DCOMPILE_RESERVED17          = 0x00020000,
    D3DCOMPILE_WARNINGS_ARE_ERRORS = 0x00040000,
}

enum uint D3DCOMPILE_ENABLE_UNBOUNDED_DESCRIPTOR_TABLES = 0x00100000;

enum : uint
{
    D3DCOMPILE_DEBUG_NAME_FOR_SOURCE = 0x00400000,
    D3DCOMPILE_DEBUG_NAME_FOR_BINARY = 0x00800000,
}

enum uint D3DCOMPILE_EFFECT_ALLOW_SLOW_OPS = 0x00000002;

enum : uint
{
    D3DCOMPILE_FLAGS2_FORCE_ROOT_SIGNATURE_1_0 = 0x00000010,
    D3DCOMPILE_FLAGS2_FORCE_ROOT_SIGNATURE_1_1 = 0x00000020,
}

enum : uint
{
    D3DCOMPILE_SECDATA_MERGE_UAV_SLOTS         = 0x00000001,
    D3DCOMPILE_SECDATA_PRESERVE_TEMPLATE_SLOTS = 0x00000002,
    D3DCOMPILE_SECDATA_REQUIRE_TEMPLATE_MATCH  = 0x00000004,
}

enum : uint
{
    D3D_DISASM_ENABLE_DEFAULT_VALUE_PRINTS  = 0x00000002,
    D3D_DISASM_ENABLE_INSTRUCTION_NUMBERING = 0x00000004,
    D3D_DISASM_ENABLE_INSTRUCTION_CYCLE     = 0x00000008,
}

enum uint D3D_DISASM_ENABLE_INSTRUCTION_OFFSET = 0x00000020;
enum uint D3D_DISASM_PRINT_HEX_LITERALS = 0x00000080;
enum uint D3D_COMPRESS_SHADER_KEEP_ALL_PARTS = 0x00000001;

// Callbacks

alias pD3DCompile = HRESULT function(void* pSrcData, size_t SrcDataSize, const(char)* pFileName, 
                                     const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, 
                                     const(char)* pEntrypoint, const(char)* pTarget, uint Flags1, uint Flags2, 
                                     ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);
alias pD3DPreprocess = HRESULT function(void* pSrcData, size_t SrcDataSize, const(char)* pFileName, 
                                        const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, 
                                        ID3DBlob* ppCodeText, ID3DBlob* ppErrorMsgs);
alias pD3DDisassemble = HRESULT function(char* pSrcData, size_t SrcDataSize, uint Flags, const(char)* szComments, 
                                         ID3DBlob* ppDisassembly);

// Structs


struct D3D_SHADER_DATA
{
    void*  pBytecode;
    size_t BytecodeLength;
}

// Functions

@DllImport("D3DCOMPILER_47")
HRESULT D3DReadFileToBlob(const(wchar)* pFileName, ID3DBlob* ppContents);

@DllImport("D3DCOMPILER_47")
HRESULT D3DWriteBlobToFile(ID3DBlob pBlob, const(wchar)* pFileName, BOOL bOverwrite);

@DllImport("D3DCOMPILER_47")
HRESULT D3DCompile(char* pSrcData, size_t SrcDataSize, const(char)* pSourceName, const(D3D_SHADER_MACRO)* pDefines, 
                   ID3DInclude pInclude, const(char)* pEntrypoint, const(char)* pTarget, uint Flags1, uint Flags2, 
                   ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);

@DllImport("D3DCOMPILER_47")
HRESULT D3DCompile2(char* pSrcData, size_t SrcDataSize, const(char)* pSourceName, 
                    const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, const(char)* pEntrypoint, 
                    const(char)* pTarget, uint Flags1, uint Flags2, uint SecondaryDataFlags, char* pSecondaryData, 
                    size_t SecondaryDataSize, ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);

@DllImport("D3DCOMPILER_47")
HRESULT D3DCompileFromFile(const(wchar)* pFileName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, 
                           const(char)* pEntrypoint, const(char)* pTarget, uint Flags1, uint Flags2, 
                           ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);

@DllImport("D3DCOMPILER_47")
HRESULT D3DPreprocess(char* pSrcData, size_t SrcDataSize, const(char)* pSourceName, 
                      const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, ID3DBlob* ppCodeText, 
                      ID3DBlob* ppErrorMsgs);

@DllImport("D3DCOMPILER_47")
HRESULT D3DGetDebugInfo(char* pSrcData, size_t SrcDataSize, ID3DBlob* ppDebugInfo);

@DllImport("D3DCOMPILER_47")
HRESULT D3DReflect(char* pSrcData, size_t SrcDataSize, const(GUID)* pInterface, void** ppReflector);

@DllImport("D3DCOMPILER_47")
HRESULT D3DReflectLibrary(char* pSrcData, size_t SrcDataSize, const(GUID)* riid, void** ppReflector);

@DllImport("D3DCOMPILER_47")
HRESULT D3DDisassemble(char* pSrcData, size_t SrcDataSize, uint Flags, const(char)* szComments, 
                       ID3DBlob* ppDisassembly);

@DllImport("D3DCOMPILER_47")
HRESULT D3DDisassembleRegion(char* pSrcData, size_t SrcDataSize, uint Flags, const(char)* szComments, 
                             size_t StartByteOffset, size_t NumInsts, size_t* pFinishByteOffset, 
                             ID3DBlob* ppDisassembly);

@DllImport("D3DCOMPILER_47")
HRESULT D3DCreateLinker(ID3D11Linker* ppLinker);

@DllImport("D3DCOMPILER_47")
HRESULT D3DLoadModule(void* pSrcData, size_t cbSrcDataSize, ID3D11Module* ppModule);

@DllImport("D3DCOMPILER_47")
HRESULT D3DCreateFunctionLinkingGraph(uint uFlags, ID3D11FunctionLinkingGraph* ppFunctionLinkingGraph);

@DllImport("D3DCOMPILER_47")
HRESULT D3DGetTraceInstructionOffsets(char* pSrcData, size_t SrcDataSize, uint Flags, size_t StartInstIndex, 
                                      size_t NumInsts, char* pOffsets, size_t* pTotalInsts);

@DllImport("D3DCOMPILER_47")
HRESULT D3DGetInputSignatureBlob(char* pSrcData, size_t SrcDataSize, ID3DBlob* ppSignatureBlob);

@DllImport("D3DCOMPILER_47")
HRESULT D3DGetOutputSignatureBlob(char* pSrcData, size_t SrcDataSize, ID3DBlob* ppSignatureBlob);

@DllImport("D3DCOMPILER_47")
HRESULT D3DGetInputAndOutputSignatureBlob(char* pSrcData, size_t SrcDataSize, ID3DBlob* ppSignatureBlob);

@DllImport("D3DCOMPILER_47")
HRESULT D3DStripShader(char* pShaderBytecode, size_t BytecodeLength, uint uStripFlags, ID3DBlob* ppStrippedBlob);

@DllImport("D3DCOMPILER_47")
HRESULT D3DGetBlobPart(char* pSrcData, size_t SrcDataSize, D3D_BLOB_PART Part, uint Flags, ID3DBlob* ppPart);

@DllImport("D3DCOMPILER_47")
HRESULT D3DSetBlobPart(char* pSrcData, size_t SrcDataSize, D3D_BLOB_PART Part, uint Flags, char* pPart, 
                       size_t PartSize, ID3DBlob* ppNewShader);

@DllImport("D3DCOMPILER_47")
HRESULT D3DCreateBlob(size_t Size, ID3DBlob* ppBlob);

@DllImport("D3DCOMPILER_47")
HRESULT D3DCompressShaders(uint uNumShaders, char* pShaderData, uint uFlags, ID3DBlob* ppCompressedData);

@DllImport("D3DCOMPILER_47")
HRESULT D3DDecompressShaders(char* pSrcData, size_t SrcDataSize, uint uNumShaders, uint uStartIndex, 
                             char* pIndices, uint uFlags, char* ppShaders, uint* pTotalShaders);

@DllImport("D3DCOMPILER_47")
HRESULT D3DDisassemble10Effect(ID3D10Effect pEffect, uint Flags, ID3DBlob* ppDisassembly);


