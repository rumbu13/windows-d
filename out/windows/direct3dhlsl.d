module windows.direct3dhlsl;

public import system;
public import windows.com;
public import windows.direct3d10;
public import windows.direct3d11;
public import windows.systemservices;

extern(Windows):

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DReadFileToBlob(const(wchar)* pFileName, ID3DBlob* ppContents);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DWriteBlobToFile(ID3DBlob pBlob, const(wchar)* pFileName, BOOL bOverwrite);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCompile(char* pSrcData, uint SrcDataSize, const(char)* pSourceName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, const(char)* pEntrypoint, const(char)* pTarget, uint Flags1, uint Flags2, ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCompile2(char* pSrcData, uint SrcDataSize, const(char)* pSourceName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, const(char)* pEntrypoint, const(char)* pTarget, uint Flags1, uint Flags2, uint SecondaryDataFlags, char* pSecondaryData, uint SecondaryDataSize, ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCompileFromFile(const(wchar)* pFileName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, const(char)* pEntrypoint, const(char)* pTarget, uint Flags1, uint Flags2, ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DPreprocess(char* pSrcData, uint SrcDataSize, const(char)* pSourceName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, ID3DBlob* ppCodeText, ID3DBlob* ppErrorMsgs);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetDebugInfo(char* pSrcData, uint SrcDataSize, ID3DBlob* ppDebugInfo);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DReflect(char* pSrcData, uint SrcDataSize, const(Guid)* pInterface, void** ppReflector);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DReflectLibrary(char* pSrcData, uint SrcDataSize, const(Guid)* riid, void** ppReflector);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DDisassemble(char* pSrcData, uint SrcDataSize, uint Flags, const(char)* szComments, ID3DBlob* ppDisassembly);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DDisassembleRegion(char* pSrcData, uint SrcDataSize, uint Flags, const(char)* szComments, uint StartByteOffset, uint NumInsts, uint* pFinishByteOffset, ID3DBlob* ppDisassembly);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCreateLinker(ID3D11Linker* ppLinker);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DLoadModule(void* pSrcData, uint cbSrcDataSize, ID3D11Module* ppModule);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCreateFunctionLinkingGraph(uint uFlags, ID3D11FunctionLinkingGraph* ppFunctionLinkingGraph);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetTraceInstructionOffsets(char* pSrcData, uint SrcDataSize, uint Flags, uint StartInstIndex, uint NumInsts, char* pOffsets, uint* pTotalInsts);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetInputSignatureBlob(char* pSrcData, uint SrcDataSize, ID3DBlob* ppSignatureBlob);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetOutputSignatureBlob(char* pSrcData, uint SrcDataSize, ID3DBlob* ppSignatureBlob);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetInputAndOutputSignatureBlob(char* pSrcData, uint SrcDataSize, ID3DBlob* ppSignatureBlob);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DStripShader(char* pShaderBytecode, uint BytecodeLength, uint uStripFlags, ID3DBlob* ppStrippedBlob);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetBlobPart(char* pSrcData, uint SrcDataSize, D3D_BLOB_PART Part, uint Flags, ID3DBlob* ppPart);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DSetBlobPart(char* pSrcData, uint SrcDataSize, D3D_BLOB_PART Part, uint Flags, char* pPart, uint PartSize, ID3DBlob* ppNewShader);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCreateBlob(uint Size, ID3DBlob* ppBlob);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCompressShaders(uint uNumShaders, char* pShaderData, uint uFlags, ID3DBlob* ppCompressedData);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DDecompressShaders(char* pSrcData, uint SrcDataSize, uint uNumShaders, uint uStartIndex, char* pIndices, uint uFlags, char* ppShaders, uint* pTotalShaders);

@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DDisassemble10Effect(ID3D10Effect pEffect, uint Flags, ID3DBlob* ppDisassembly);

alias pD3DCompile = extern(Windows) HRESULT function(void* pSrcData, uint SrcDataSize, const(char)* pFileName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, const(char)* pEntrypoint, const(char)* pTarget, uint Flags1, uint Flags2, ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);
alias pD3DPreprocess = extern(Windows) HRESULT function(void* pSrcData, uint SrcDataSize, const(char)* pFileName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, ID3DBlob* ppCodeText, ID3DBlob* ppErrorMsgs);
alias pD3DDisassemble = extern(Windows) HRESULT function(char* pSrcData, uint SrcDataSize, uint Flags, const(char)* szComments, ID3DBlob* ppDisassembly);
enum D3DCOMPILER_STRIP_FLAGS
{
    D3DCOMPILER_STRIP_REFLECTION_DATA = 1,
    D3DCOMPILER_STRIP_DEBUG_INFO = 2,
    D3DCOMPILER_STRIP_TEST_BLOBS = 4,
    D3DCOMPILER_STRIP_PRIVATE_DATA = 8,
    D3DCOMPILER_STRIP_ROOT_SIGNATURE = 16,
    D3DCOMPILER_STRIP_FORCE_DWORD = 2147483647,
}

enum D3D_BLOB_PART
{
    D3D_BLOB_INPUT_SIGNATURE_BLOB = 0,
    D3D_BLOB_OUTPUT_SIGNATURE_BLOB = 1,
    D3D_BLOB_INPUT_AND_OUTPUT_SIGNATURE_BLOB = 2,
    D3D_BLOB_PATCH_CONSTANT_SIGNATURE_BLOB = 3,
    D3D_BLOB_ALL_SIGNATURE_BLOB = 4,
    D3D_BLOB_DEBUG_INFO = 5,
    D3D_BLOB_LEGACY_SHADER = 6,
    D3D_BLOB_XNA_PREPASS_SHADER = 7,
    D3D_BLOB_XNA_SHADER = 8,
    D3D_BLOB_PDB = 9,
    D3D_BLOB_PRIVATE_DATA = 10,
    D3D_BLOB_ROOT_SIGNATURE = 11,
    D3D_BLOB_DEBUG_NAME = 12,
    D3D_BLOB_TEST_ALTERNATE_SHADER = 32768,
    D3D_BLOB_TEST_COMPILE_DETAILS = 32769,
    D3D_BLOB_TEST_COMPILE_PERF = 32770,
    D3D_BLOB_TEST_COMPILE_REPORT = 32771,
}

struct D3D_SHADER_DATA
{
    void* pBytecode;
    uint BytecodeLength;
}

