// Written in the D programming language.

module windows.direct3dhlsl;

public import windows.core;
public import windows.com : HRESULT;
public import windows.direct3d10 : ID3D10Effect;
public import windows.direct3d11 : D3D_SHADER_MACRO, ID3D11FunctionLinkingGraph,
                                   ID3D11Linker, ID3D11Module, ID3DBlob,
                                   ID3DInclude;
public import windows.systemservices : BOOL, PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///Strip flag options.
alias D3DCOMPILER_STRIP_FLAGS = int;
enum : int
{
    ///Remove reflection data.
    D3DCOMPILER_STRIP_REFLECTION_DATA = 0x00000001,
    ///Remove debug information.
    D3DCOMPILER_STRIP_DEBUG_INFO      = 0x00000002,
    ///Remove test blob data.
    D3DCOMPILER_STRIP_TEST_BLOBS      = 0x00000004,
    ///<div class="alert"><b>Note</b> This value is supported by the D3dcompiler_44.dll or later version of the
    ///file.</div> <div> </div> Remove private data.
    D3DCOMPILER_STRIP_PRIVATE_DATA    = 0x00000008,
    ///<div class="alert"><b>Note</b> This value is supported by the D3dcompiler_47.dll or later version of the
    ///file.</div> <div> </div> Remove the root signature. Refer to Specifying Root Signatures in HLSL for more
    ///information on using Direct3D12 with HLSL.
    D3DCOMPILER_STRIP_ROOT_SIGNATURE  = 0x00000010,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    D3DCOMPILER_STRIP_FORCE_DWORD     = 0x7fffffff,
}

///Values that identify parts of the content of an arbitrary length data buffer.
alias D3D_BLOB_PART = int;
enum : int
{
    ///The blob part is an input signature.
    D3D_BLOB_INPUT_SIGNATURE_BLOB            = 0x00000000,
    ///The blob part is an output signature.
    D3D_BLOB_OUTPUT_SIGNATURE_BLOB           = 0x00000001,
    ///The blob part is an input and output signature.
    D3D_BLOB_INPUT_AND_OUTPUT_SIGNATURE_BLOB = 0x00000002,
    ///The blob part is a patch constant signature.
    D3D_BLOB_PATCH_CONSTANT_SIGNATURE_BLOB   = 0x00000003,
    ///The blob part is all signature.
    D3D_BLOB_ALL_SIGNATURE_BLOB              = 0x00000004,
    ///The blob part is debug information.
    D3D_BLOB_DEBUG_INFO                      = 0x00000005,
    ///The blob part is a legacy shader.
    D3D_BLOB_LEGACY_SHADER                   = 0x00000006,
    ///The blob part is an XNA prepass shader.
    D3D_BLOB_XNA_PREPASS_SHADER              = 0x00000007,
    ///The blob part is an XNA shader.
    D3D_BLOB_XNA_SHADER                      = 0x00000008,
    ///The blob part is program database (PDB) information. <div class="alert"><b>Note</b> This value is supported by
    ///the D3dcompiler_44.dll or later version of the file.</div> <div> </div>
    D3D_BLOB_PDB                             = 0x00000009,
    ///The blob part is private data. <div class="alert"><b>Note</b> This value is supported by the D3dcompiler_44.dll
    ///or later version of the file.</div> <div> </div>
    D3D_BLOB_PRIVATE_DATA                    = 0x0000000a,
    ///The blob part is a root signature. Refer to Specifying Root Signatures in HLSL for more information on using
    ///Direct3D12 with HLSL. <div class="alert"><b>Note</b> This value is supported by the D3dcompiler_47.dll or later
    ///version of the file.</div> <div> </div>
    D3D_BLOB_ROOT_SIGNATURE                  = 0x0000000b,
    ///The blob part is the debug name of the shader. If the application does not specify the debug name itself, an
    ///auto-generated name matching the PDB file of the shader is provided instead. <div class="alert"><b>Note</b> This
    ///value is supported by the D3dcompiler_47.dll as available on the Windows 10 Fall Creators Update and its SDK, or
    ///later version of the file.</div> <div> </div>
    D3D_BLOB_DEBUG_NAME                      = 0x0000000c,
    ///The blob part is a test alternate shader. <div class="alert"><b>Note</b> This value identifies a test part and is
    ///only produced by special compiler versions. Therefore, this part type is typically not present in shaders.</div>
    ///<div> </div>
    D3D_BLOB_TEST_ALTERNATE_SHADER           = 0x00008000,
    ///The blob part is test compilation details. <div class="alert"><b>Note</b> This value identifies a test part and
    ///is only produced by special compiler versions. Therefore, this part type is typically not present in
    ///shaders.</div> <div> </div>
    D3D_BLOB_TEST_COMPILE_DETAILS            = 0x00008001,
    ///The blob part is test compilation performance. <div class="alert"><b>Note</b> This value identifies a test part
    ///and is only produced by special compiler versions. Therefore, this part type is typically not present in
    ///shaders.</div> <div> </div>
    D3D_BLOB_TEST_COMPILE_PERF               = 0x00008002,
    ///The blob part is a test compilation report. <div class="alert"><b>Note</b> This value identifies a test part and
    ///is only produced by special compiler versions. Therefore, this part type is typically not present in
    ///shaders.</div> <div> </div> <div class="alert"><b>Note</b> This value is supported by the D3dcompiler_44.dll or
    ///later version of the file.</div> <div> </div>
    D3D_BLOB_TEST_COMPILE_REPORT             = 0x00008003,
}

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

alias pD3DCompile = HRESULT function(const(void)* pSrcData, size_t SrcDataSize, const(PSTR) pFileName, 
                                     const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, 
                                     const(PSTR) pEntrypoint, const(PSTR) pTarget, uint Flags1, uint Flags2, 
                                     ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);
alias pD3DPreprocess = HRESULT function(const(void)* pSrcData, size_t SrcDataSize, const(PSTR) pFileName, 
                                        const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, 
                                        ID3DBlob* ppCodeText, ID3DBlob* ppErrorMsgs);
alias pD3DDisassemble = HRESULT function(const(void)* pSrcData, size_t SrcDataSize, uint Flags, 
                                         const(PSTR) szComments, ID3DBlob* ppDisassembly);

// Structs


///Describes shader data.
struct D3D_SHADER_DATA
{
    ///A pointer to shader data.
    const(void)* pBytecode;
    ///Length of shader data that <b>pBytecode</b> points to.
    size_t       BytecodeLength;
}

// Functions

///<div class="alert"><b>Note</b> You can use this API to develop your Windows Store apps, but you can't use it in apps
///that you submit to the Windows Store.</div><div> </div>Reads a file that is on disk into memory.
///Params:
///    pFileName = A pointer to a constant null-terminated string that contains the name of the file to read into memory.
///    ppContents = A pointer to a variable that receives a pointer to the ID3DBlob interface that contains information that
///                 <b>D3DReadFileToBlob</b> read from the <i>pFileName</i> file. You can use this <b>ID3DBlob</b> interface to
///                 access the file information and pass it to other compiler functions.
///Returns:
///    Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DReadFileToBlob(const(PWSTR) pFileName, ID3DBlob* ppContents);

///<div class="alert"><b>Note</b> You can use this API to develop your Windows Store apps, but you can't use it in apps
///that you submit to the Windows Store.</div><div> </div>Writes a memory blob to a file on disk.
///Params:
///    pBlob = Type: <b>ID3DBlob*</b> A pointer to a ID3DBlob interface that contains the memory blob to write to the file that
///            the <i>pFileName</i> parameter specifies.
///    pFileName = Type: <b>LPCWSTR</b> A pointer to a constant null-terminated string that contains the name of the file to which
///                to write.
///    bOverwrite = Type: <b>BOOL</b> A Boolean value that specifies whether to overwrite information in the <i>pFileName</i> file.
///                 TRUE specifies to overwrite information and FALSE specifies not to overwrite information.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DWriteBlobToFile(ID3DBlob pBlob, const(PWSTR) pFileName, BOOL bOverwrite);

///Compile HLSL code or an effect file into bytecode for a given target.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to uncompiled shader data; either ASCII HLSL code or a compiled effect.
///    SrcDataSize = Type: <b>SIZE_T</b> Length of <i>pSrcData</i>.
///    pSourceName = Type: <b>LPCSTR</b> You can use this parameter for strings that specify error messages. If not used, set to
///                  <b>NULL</b>.
///    pDefines = Type: <b>const D3D_SHADER_MACRO*</b> An array of NULL-terminated macro definitions (see D3D_SHADER_MACRO).
///    pInclude = Type: <b>ID3DInclude*</b> Optional. A pointer to an ID3DInclude for handling include files. Setting this to
///               <b>NULL</b> will cause a compile error if a shader contains a
///    pEntrypoint = Type: <b>LPCSTR</b> The name of the shader entry point function where shader execution begins. When you compile
///                  using a fx profile (for example, fx_4_0, fx_5_0, and so on), <b>D3DCompile</b> ignores <i>pEntrypoint</i>. In
///                  this case, we recommend that you set <i>pEntrypoint</i> to <b>NULL</b> because it is good programming practice to
///                  set a pointer parameter to <b>NULL</b> if the called function will not use it. For all other shader profiles, a
///                  valid <i>pEntrypoint</i> is required.
///    pTarget = Type: <b>LPCSTR</b> A string that specifies the shader target or set of shader features to compile against. The
///              shader target can be shader model 2, shader model 3, shader model 4, or shader model 5. The target can also be an
///              effect type (for example, fx_4_1). For info about the targets that various profiles support, see Specifying
///              Compiler Targets.
///    Flags1 = Type: <b>UINT</b> Flags defined by D3D compile constants.
///    Flags2 = Type: <b>UINT</b> Flags defined by D3D compile effect constants. When you compile a shader and not an effect
///             file, <b>D3DCompile</b> ignores <i>Flags2</i>; we recommend that you set <i>Flags2</i> to zero because it is good
///             programming practice to set a nonpointer parameter to zero if the called function will not use it.
///    ppCode = Type: <b>ID3DBlob**</b> A pointer to a variable that receives a pointer to the ID3DBlob interface that you can
///             use to access the compiled code.
///    ppErrorMsgs = Type: <b>ID3DBlob**</b> A pointer to a variable that receives a pointer to the ID3DBlob interface that you can
///                  use to access compiler error messages, or <b>NULL</b> if there are no errors.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DCompile(const(void)* pSrcData, size_t SrcDataSize, const(PSTR) pSourceName, 
                   const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, const(PSTR) pEntrypoint, 
                   const(PSTR) pTarget, uint Flags1, uint Flags2, ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);

///Compiles Microsoft High Level Shader Language (HLSL) code into bytecode for a given target.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to uncompiled shader data (ASCII HLSL code).
///    SrcDataSize = Type: <b>SIZE_T</b> The size, in bytes, of the block of memory that <i>pSrcData</i> points to.
///    pSourceName = Type: <b>LPCSTR</b> An optional pointer to a constant null-terminated string containing the name that identifies
///                  the source data to use in error messages. If not used, set to <b>NULL</b>.
///    pDefines = Type: <b>const D3D_SHADER_MACRO*</b> An optional array of D3D_SHADER_MACRO structures that define shader macros.
///               Each macro definition contains a name and a NULL-terminated definition. If not used, set to <b>NULL</b>.
///    pInclude = Type: <b>ID3DInclude*</b> A pointer to an ID3DInclude interface that the compiler uses to handle include files.
///               If you set this parameter to <b>NULL</b> and the shader contains a
///    pEntrypoint = Type: <b>LPCSTR</b> A pointer to a constant null-terminated string that contains the name of the shader entry
///                  point function where shader execution begins. When you compile an effect, <b>D3DCompile2</b> ignores
///                  <i>pEntrypoint</i>; we recommend that you set <i>pEntrypoint</i> to <b>NULL</b> because it is good programming
///                  practice to set a pointer parameter to <b>NULL</b> if the called function will not use it.
///    pTarget = Type: <b>LPCSTR</b> A pointer to a constant null-terminated string that specifies the shader target or set of
///              shader features to compile against. The shader target can be a shader model (for example, shader model 2, shader
///              model 3, shader model 4, or shader model 5). The target can also be an effect type (for example, fx_4_1). For
///              info about the targets that various profiles support, see Specifying Compiler Targets.
///    Flags1 = Type: <b>UINT</b> A combination of shader D3D compile constants that are combined by using a bitwise <b>OR</b>
///             operation. The resulting value specifies how the compiler compiles the HLSL code.
///    Flags2 = Type: <b>UINT</b> A combination of effect D3D compile effect constants that are combined by using a bitwise
///             <b>OR</b> operation. The resulting value specifies how the compiler compiles the effect. When you compile a
///             shader and not an effect file, <b>D3DCompile2</b> ignores <i>Flags2</i>; we recommend that you set <i>Flags2</i>
///             to zero because it is good programming practice to set a nonpointer parameter to zero if the called function will
///             not use it.
///    SecondaryDataFlags = Type: <b>UINT</b> A combination of the following flags that are combined by using a bitwise <b>OR</b> operation.
///                         The resulting value specifies how the compiler compiles the HLSL code. <table> <tr> <th>Flag</th>
///                         <th>Description</th> </tr> <tr> <td>D3DCOMPILE_SECDATA_MERGE_UAV_SLOTS (0x01)</td> <td>Merge unordered access
///                         view (UAV) slots in the secondary data that the <i>pSecondaryData</i> parameter points to.</td> </tr> <tr>
///                         <td>D3DCOMPILE_SECDATA_PRESERVE_TEMPLATE_SLOTS (0x02)</td> <td>Preserve template slots in the secondary data that
///                         the <i>pSecondaryData</i> parameter points to.</td> </tr> <tr> <td>D3DCOMPILE_SECDATA_REQUIRE_TEMPLATE_MATCH
///                         (0x04)</td> <td>Require that templates in the secondary data that the <i>pSecondaryData</i> parameter points to
///                         match when the compiler compiles the HLSL code.</td> </tr> </table> If <i>pSecondaryData</i> is <b>NULL</b>, set
///                         to zero.
///    pSecondaryData = Type: <b>LPCVOID</b> A pointer to secondary data. If you don't pass secondary data, set to <b>NULL</b>. Use this
///                     secondary data to align UAV slots in two shaders. Suppose shader A has UAVs and they are bound to some slots. To
///                     compile shader B such that UAVs with the same names are mapped in B to the same slots as in A, pass A’s byte
///                     code to <b>D3DCompile2</b> as the secondary data.
///    SecondaryDataSize = Type: <b>SIZE_T</b> The size, in bytes, of the block of memory that <i>pSecondaryData</i> points to. If
///                        <i>pSecondaryData</i> is <b>NULL</b>, set to zero.
///    ppCode = Type: <b>ID3DBlob**</b> A pointer to a variable that receives a pointer to the ID3DBlob interface that you can
///             use to access the compiled code.
///    ppErrorMsgs = Type: <b>ID3DBlob**</b> A pointer to a variable that receives a pointer to the ID3DBlob interface that you can
///                  use to access compiler error messages, or <b>NULL</b> if there are no errors.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DCompile2(const(void)* pSrcData, size_t SrcDataSize, const(PSTR) pSourceName, 
                    const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, const(PSTR) pEntrypoint, 
                    const(PSTR) pTarget, uint Flags1, uint Flags2, uint SecondaryDataFlags, 
                    const(void)* pSecondaryData, size_t SecondaryDataSize, ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);

///<div class="alert"><b>Note</b> You can use this API to develop your Windows Store apps, but you can't use it in apps
///that you submit to the Windows Store. Refer to the section, "Compiling shaders for UWP", in the remarks for
///D3DCompile2.</div><div> </div>Compiles Microsoft High Level Shader Language (HLSL) code into bytecode for a given
///target.
///Params:
///    pFileName = A pointer to a constant null-terminated string that contains the name of the file that contains the shader code.
///    pDefines = An optional array of D3D_SHADER_MACRO structures that define shader macros. Each macro definition contains a name
///               and a NULL-terminated definition. If not used, set to <b>NULL</b>.
///    pInclude = An optional pointer to an ID3DInclude interface that the compiler uses to handle include files. If you set this
///               parameter to <b>NULL</b> and the shader contains a
///    pEntrypoint = A pointer to a constant null-terminated string that contains the name of the shader entry point function where
///                  shader execution begins. When you compile an effect, <b>D3DCompileFromFile</b> ignores <i>pEntrypoint</i>; we
///                  recommend that you set <i>pEntrypoint</i> to <b>NULL</b> because it is good programming practice to set a pointer
///                  parameter to <b>NULL</b> if the called function will not use it.
///    pTarget = A pointer to a constant null-terminated string that specifies the shader target or set of shader features to
///              compile against. The shader target can be a shader model (for example, shader model 2, shader model 3, shader
///              model 4, or shader model 5 and later). The target can also be an effect type (for example, fx_4_1). For info
///              about the targets that various profiles support, see Specifying Compiler Targets.
///    Flags1 = A combination of shader compile options that are combined by using a bitwise <b>OR</b> operation. The resulting
///             value specifies how the compiler compiles the HLSL code.
///    Flags2 = A combination of effect compile options that are combined by using a bitwise <b>OR</b> operation. The resulting
///             value specifies how the compiler compiles the effect. When you compile a shader and not an effect file,
///             <b>D3DCompileFromFile</b> ignores <i>Flags2</i>; we recommend that you set <i>Flags2</i> to zero because it is
///             good programming practice to set a nonpointer parameter to zero if the called function will not use it.
///    ppCode = A pointer to a variable that receives a pointer to the ID3DBlob interface that you can use to access the compiled
///             code.
///    ppErrorMsgs = An optional pointer to a variable that receives a pointer to the ID3DBlob interface that you can use to access
///                  compiler error messages, or <b>NULL</b> if there are no errors.
///Returns:
///    Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DCompileFromFile(const(PWSTR) pFileName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, 
                           const(PSTR) pEntrypoint, const(PSTR) pTarget, uint Flags1, uint Flags2, ID3DBlob* ppCode, 
                           ID3DBlob* ppErrorMsgs);

///Preprocesses uncompiled HLSL code.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to uncompiled shader data; either ASCII HLSL code or a compiled effect.
///    SrcDataSize = Type: <b>SIZE_T</b> Length of <i>pSrcData</i>.
///    pSourceName = Type: <b>LPCSTR</b> The name of the file that contains the uncompiled HLSL code.
///    pDefines = Type: <b>const D3D_SHADER_MACRO*</b> An array of NULL-terminated macro definitions (see D3D_SHADER_MACRO).
///    pInclude = Type: <b>ID3DInclude*</b> A pointer to an ID3DInclude for handling include files. Setting this to <b>NULL</b>
///               will cause a compile error if a shader contains a
///    ppCodeText = Type: <b>ID3DBlob**</b> The address of a ID3DBlob that contains the compiled code.
///    ppErrorMsgs = Type: <b>ID3DBlob**</b> A pointer to an ID3DBlob that contains compiler error messages, or <b>NULL</b> if there
///                  were no errors.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DPreprocess(const(void)* pSrcData, size_t SrcDataSize, const(PSTR) pSourceName, 
                      const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, ID3DBlob* ppCodeText, 
                      ID3DBlob* ppErrorMsgs);

///<div class="alert"><b>Note</b> You can use this API to develop your Windows Store apps, but you can't use it in apps
///that you submit to the Windows Store.</div><div> </div>Gets shader debug information.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to source data; either uncompiled or compiled HLSL code.
///    SrcDataSize = Type: <b>SIZE_T</b> Length of <i>pSrcData</i>.
///    ppDebugInfo = Type: <b>ID3DBlob**</b> A pointer to a buffer that receives the ID3DBlob interface that contains debug
///                  information.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DGetDebugInfo(const(void)* pSrcData, size_t SrcDataSize, ID3DBlob* ppDebugInfo);

///Gets a pointer to a reflection interface.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to source data as compiled HLSL code.
///    SrcDataSize = Type: <b>SIZE_T</b> Length of <i>pSrcData</i>.
///    pInterface = Type: <b>REFIID</b> The reference GUID of the COM interface to use. For example,
///                 <b>IID_ID3D11ShaderReflection</b>.
///    ppReflector = Type: <b>void**</b> A pointer to a reflection interface.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DReflect(const(void)* pSrcData, size_t SrcDataSize, const(GUID)* pInterface, void** ppReflector);

///Creates a library-reflection interface from source data that contains an HLSL library of functions. <div
///class="alert"><b>Note</b> This function is part of the HLSL shader linking technology that you can use on all
///Direct3D 11 platforms to create precompiled HLSL functions, package them into libraries, and link them into full
///shaders at run time. </div> <div> </div>
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to source data as an HLSL library of functions.
///    SrcDataSize = Type: <b>SIZE_T</b> The size, in bytes, of the block of memory that <i>pSrcData</i> points to.
///    riid = Type: <b>REFIID</b> The reference GUID of the COM interface to use. For example,
///           <b>IID_ID3D11LibraryReflection</b>.
///    ppReflector = Type: <b>LPVOID*</b> A pointer to a variable that receives a pointer to a library-reflection interface,
///                  ID3D11LibraryReflection.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DReflectLibrary(const(void)* pSrcData, size_t SrcDataSize, const(GUID)* riid, void** ppReflector);

///Disassembles compiled HLSL code.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to source data as compiled HLSL code.
///    SrcDataSize = Type: <b>SIZE_T</b> Length of <i>pSrcData</i>.
///    Flags = Type: <b>UINT</b> Flags affecting the behavior of <b>D3DDisassemble</b>. <i>Flags</i> can be a combination of
///            zero or more of the following values. <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr>
///            <td><b>D3D_DISASM_ENABLE_COLOR_CODE</b></td> <td>Enable the output of color codes.</td> </tr> <tr>
///            <td><b>D3D_DISASM_ENABLE_DEFAULT_VALUE_PRINTS</b></td> <td>Enable the output of default values.</td> </tr> <tr>
///            <td><b>D3D_DISASM_ENABLE_INSTRUCTION_NUMBERING</b></td> <td>Enable instruction numbering.</td> </tr> <tr>
///            <td><b>D3D_DISASM_ENABLE_INSTRUCTION_CYCLE</b></td> <td>No effect.</td> </tr> <tr>
///            <td><b>D3D_DISASM_DISABLE_DEBUG_INFO</b></td> <td>Disable debug information.</td> </tr> <tr>
///            <td><b>D3D_DISASM_ENABLE_INSTRUCTION_OFFSET</b></td> <td>Enable instruction offsets.</td> </tr> <tr>
///            <td><b>D3D_DISASM_INSTRUCTION_ONLY</b></td> <td>Disassemble instructions only.</td> </tr> <tr> <td><b>
///            D3D_DISASM_PRINT_HEX_LITERALS</b></td> <td>Use hex symbols in disassemblies.</td> </tr> </table>
///    szComments = Type: <b>LPCSTR</b> The comment string at the top of the shader that identifies the shader constants and
///                 variables.
///    ppDisassembly = Type: <b>ID3DBlob**</b> A pointer to a buffer that receives the ID3DBlob interface that accesses assembly text.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DDisassemble(const(void)* pSrcData, size_t SrcDataSize, uint Flags, const(PSTR) szComments, 
                       ID3DBlob* ppDisassembly);

///Disassembles a specific region of compiled Microsoft High Level Shader Language (HLSL) code.
///Params:
///    pSrcData = A pointer to compiled shader data.
///    SrcDataSize = The size, in bytes, of the block of memory that <i>pSrcData</i> points to.
///    Flags = A combination of zero or more of the following flags that are combined by using a bitwise <b>OR</b> operation.
///            The resulting value specifies how <b>D3DDisassembleRegion</b> disassembles the compiled shader data. <table> <tr>
///            <th>Flag</th> <th>Description</th> </tr> <tr> <td>D3D_DISASM_ENABLE_COLOR_CODE (0x01)</td> <td>Enable the output
///            of color codes.</td> </tr> <tr> <td>D3D_DISASM_ENABLE_DEFAULT_VALUE_PRINTS (0x02)</td> <td>Enable the output of
///            default values.</td> </tr> <tr> <td>D3D_DISASM_ENABLE_INSTRUCTION_NUMBERING (0x04)</td> <td>Enable instruction
///            numbering.</td> </tr> <tr> <td>D3D_DISASM_ENABLE_INSTRUCTION_CYCLE (0x08)</td> <td>No effect.</td> </tr> <tr>
///            <td>D3D_DISASM_DISABLE_DEBUG_INFO (0x10)</td> <td>Disable the output of debug information.</td> </tr> <tr>
///            <td>D3D_DISASM_ENABLE_INSTRUCTION_OFFSET (0x20)</td> <td>Enable the output of instruction offsets.</td> </tr>
///            <tr> <td>D3D_DISASM_INSTRUCTION_ONLY (0x40)</td> <td>This flag has no effect in <b>D3DDisassembleRegion</b>.
///            Cycle information comes from the trace; therefore, cycle information is available only in D3DDisassemble11Trace's
///            trace disassembly.</td> </tr> </table>
///    szComments = A pointer to a constant null-terminated string at the top of the shader that identifies the shader constants and
///                 variables.
///    StartByteOffset = The number of bytes offset into the compiled shader data where <b>D3DDisassembleRegion</b> starts the
///                      disassembly.
///    NumInsts = The number of instructions to disassemble.
///    pFinishByteOffset = A pointer to a variable that receives the number of bytes offset into the compiled shader data where
///                        <b>D3DDisassembleRegion</b> finishes the disassembly.
///    ppDisassembly = A pointer to a buffer that receives the ID3DBlob interface that accesses the disassembled HLSL code.
///Returns:
///    Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DDisassembleRegion(const(void)* pSrcData, size_t SrcDataSize, uint Flags, const(PSTR) szComments, 
                             size_t StartByteOffset, size_t NumInsts, size_t* pFinishByteOffset, 
                             ID3DBlob* ppDisassembly);

///Creates a linker interface. <div class="alert"><b>Note</b> This function is part of the HLSL shader linking
///technology that you can use on all Direct3D 11 platforms to create precompiled HLSL functions, package them into
///libraries, and link them into full shaders at run time. </div> <div> </div>
///Params:
///    ppLinker = Type: <b>ID3D11Linker**</b> A pointer to a variable that receives a pointer to the ID3D11Linker interface that is
///               used to link a shader module.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DCreateLinker(ID3D11Linker* ppLinker);

///Creates a shader module interface from source data for the shader module. <div class="alert"><b>Note</b> This
///function is part of the HLSL shader linking technology that you can use on all Direct3D 11 platforms to create
///precompiled HLSL functions, package them into libraries, and link them into full shaders at run time. </div> <div>
///</div>
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to the source data for the shader module.
///    cbSrcDataSize = Type: <b>SIZE_T</b> The size, in bytes, of the block of memory that <i>pSrcData</i> points to.
///    ppModule = Type: <b>ID3D11Module**</b> A pointer to a variable that receives a pointer to the ID3D11Module interface that is
///               used for shader resource re-binding.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DLoadModule(const(void)* pSrcData, size_t cbSrcDataSize, ID3D11Module* ppModule);

///Creates a function-linking-graph interface. <div class="alert"><b>Note</b> This function is part of the HLSL shader
///linking technology that you can use on all Direct3D 11 platforms to create precompiled HLSL functions, package them
///into libraries, and link them into full shaders at run time. </div> <div> </div>
///Params:
///    uFlags = Type: <b>UINT</b> Reserved
///    ppFunctionLinkingGraph = Type: <b>ID3D11FunctionLinkingGraph**</b> A pointer to a variable that receives a pointer to the
///                             ID3D11FunctionLinkingGraph interface that is used for constructing shaders that consist of a sequence of
///                             precompiled function calls.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DCreateFunctionLinkingGraph(uint uFlags, ID3D11FunctionLinkingGraph* ppFunctionLinkingGraph);

///Retrieves the byte offsets for instructions within a section of shader code.
///Params:
///    pSrcData = A pointer to the compiled shader data.
///    SrcDataSize = The size, in bytes, of the block of memory that <i>pSrcData</i> points to.
///    Flags = A combination of the following flags that are combined by using a bitwise <b>OR</b> operation. The resulting
///            value specifies how <b>D3DGetTraceInstructionOffsets</b> retrieves the instruction offsets. <table> <tr>
///            <th>Flag</th> <th>Description</th> </tr> <tr> <td>D3D_GET_INST_OFFSETS_INCLUDE_NON_EXECUTABLE (0x01)</td>
///            <td>Include non-executable code in the retrieved information.</td> </tr> </table>
///    StartInstIndex = The index of the instruction in the compiled shader data for which <b>D3DGetTraceInstructionOffsets</b> starts to
///                     retrieve the byte offsets.
///    NumInsts = The number of instructions for which <b>D3DGetTraceInstructionOffsets</b> retrieves the byte offsets.
///    pOffsets = A pointer to a variable that receives the actual number of offsets.
///    pTotalInsts = A pointer to a variable that receives the total number of instructions in the section of shader code.
///Returns:
///    Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DGetTraceInstructionOffsets(const(void)* pSrcData, size_t SrcDataSize, uint Flags, size_t StartInstIndex, 
                                      size_t NumInsts, size_t* pOffsets, size_t* pTotalInsts);

///<div class="alert"><b>Note</b> <b>D3DGetInputSignatureBlob</b> may be altered or unavailable for releases after
///Windows 8.1. Instead use D3DGetBlobPart with the D3D_BLOB_INPUT_SIGNATURE_BLOB value. </div><div> </div>Gets the
///input signature from a compilation result.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to source data as compiled HLSL code.
///    SrcDataSize = Type: <b>SIZE_T</b> Length of <i>pSrcData</i>.
///    ppSignatureBlob = Type: <b>ID3DBlob**</b> A pointer to a buffer that receives the ID3DBlob interface that contains a compiled
///                      shader.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DGetInputSignatureBlob(const(void)* pSrcData, size_t SrcDataSize, ID3DBlob* ppSignatureBlob);

///<div class="alert"><b>Note</b> <b>D3DGetOutputSignatureBlob</b> may be altered or unavailable for releases after
///Windows 8.1. Instead use D3DGetBlobPart with the D3D_BLOB_OUTPUT_SIGNATURE_BLOB value. </div><div> </div>Gets the
///output signature from a compilation result.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to source data as compiled HLSL code.
///    SrcDataSize = Type: <b>SIZE_T</b> Length of <i>pSrcData</i>.
///    ppSignatureBlob = Type: <b>ID3DBlob**</b> A pointer to a buffer that receives the ID3DBlob interface that contains a compiled
///                      shader.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DGetOutputSignatureBlob(const(void)* pSrcData, size_t SrcDataSize, ID3DBlob* ppSignatureBlob);

///<div class="alert"><b>Note</b> <b>D3DGetInputAndOutputSignatureBlob</b> may be altered or unavailable for releases
///after Windows 8.1. Instead use D3DGetBlobPart with the D3D_BLOB_INPUT_AND_OUTPUT_SIGNATURE_BLOB value. </div><div>
///</div>Gets the input and output signatures from a compilation result.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to source data as compiled HLSL code.
///    SrcDataSize = Type: <b>SIZE_T</b> Length of <i>pSrcData</i>.
///    ppSignatureBlob = Type: <b>ID3DBlob**</b> A pointer to a buffer that receives the ID3DBlob interface that contains a compiled
///                      shader.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DGetInputAndOutputSignatureBlob(const(void)* pSrcData, size_t SrcDataSize, ID3DBlob* ppSignatureBlob);

///Removes unwanted blobs from a compilation result.
///Params:
///    pShaderBytecode = Type: <b>LPCVOID</b> A pointer to source data as compiled HLSL code.
///    BytecodeLength = Type: <b>SIZE_T</b> Length of <i>pSrcData</i>.
///    uStripFlags = Type: <b>UINT</b> Strip flag options, represented by D3DCOMPILER_STRIP_FLAGS.
///    ppStrippedBlob = Type: <b>ID3DBlob**</b> A pointer to a variable that receives a pointer to the ID3DBlob interface that you can
///                     use to access the unwanted stripped out shader code.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DStripShader(const(void)* pShaderBytecode, size_t BytecodeLength, uint uStripFlags, 
                       ID3DBlob* ppStrippedBlob);

///Retrieves a specific part from a compilation result.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to uncompiled shader data; either ASCII HLSL code or a compiled effect.
///    SrcDataSize = Type: <b>SIZE_T</b> Length of uncompiled shader data that <i>pSrcData</i> points to.
///    Part = Type: <b>D3D_BLOB_PART</b> A D3D_BLOB_PART-typed value that specifies the part of the buffer to retrieve.
///    Flags = Type: <b>UINT</b> Flags that indicate how to retrieve the blob part. Currently, no flags are defined.
///    ppPart = Type: <b>ID3DBlob**</b> The address of a pointer to the ID3DBlob interface that is used to retrieve the specified
///             part of the buffer.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DGetBlobPart(const(void)* pSrcData, size_t SrcDataSize, D3D_BLOB_PART Part, uint Flags, ID3DBlob* ppPart);

///Sets information in a compilation result.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to compiled shader data.
///    SrcDataSize = Type: <b>SIZE_T</b> The length of the compiled shader data that <i>pSrcData</i> points to.
///    Part = Type: <b>D3D_BLOB_PART</b> A D3D_BLOB_PART-typed value that specifies the part to set. Currently, you can update
///           only private data; that is, <b>D3DSetBlobPart</b> currently only supports the D3D_BLOB_PRIVATE_DATA value.
///    Flags = Type: <b>UINT</b> Flags that indicate how to set the blob part. Currently, no flags are defined; therefore, set
///            to zero.
///    pPart = Type: <b>LPCVOID</b> A pointer to data to set in the compilation result.
///    PartSize = Type: <b>SIZE_T</b> The length of the data that <i>pPart</i> points to.
///    ppNewShader = Type: <b>ID3DBlob**</b> A pointer to a buffer that receives the ID3DBlob interface for the new shader in which
///                  the new part data is set.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DSetBlobPart(const(void)* pSrcData, size_t SrcDataSize, D3D_BLOB_PART Part, uint Flags, 
                       const(void)* pPart, size_t PartSize, ID3DBlob* ppNewShader);

///Creates a buffer.
///Params:
///    Size = Type: <b>SIZE_T</b> Number of bytes in the blob.
///    ppBlob = Type: <b>ID3DBlob**</b> The address of a pointer to the ID3DBlob interface that is used to retrieve the buffer.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DCreateBlob(size_t Size, ID3DBlob* ppBlob);

///<div class="alert"><b>Note</b> You can use this API to develop your Windows Store apps, but you can't use it in apps
///that you submit to the Windows Store.</div><div> </div>Compresses a set of shaders into a more compact form.
///Params:
///    uNumShaders = Type: <b>UINT</b> The number of shaders to compress.
///    pShaderData = Type: [D3D_SHADER_DATA](./ns-d3dcompiler-d3d_shader_data.md)*</b> An array of
///                  [D3D_SHADER_DATA](./ns-d3dcompiler-d3d_shader_data.md) structures that describe the set of shaders to compress.
///    uFlags = Type: <b>UINT</b> Flags that indicate how to compress the shaders. Currently, only the
///             D3D_COMPRESS_SHADER_KEEP_ALL_PARTS (0x00000001) flag is defined.
///    ppCompressedData = Type: <b>ID3DBlob**</b> The address of a pointer to the ID3DBlob interface that is used to retrieve the
///                       compressed shader data.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DCompressShaders(uint uNumShaders, D3D_SHADER_DATA* pShaderData, uint uFlags, ID3DBlob* ppCompressedData);

///<div class="alert"><b>Note</b> You can use this API to develop your Windows Store apps, but you can't use it in apps
///that you submit to the Windows Store.</div><div> </div>Decompresses one or more shaders from a compressed set.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to uncompiled shader data; either ASCII HLSL code or a compiled effect.
///    SrcDataSize = Type: <b>SIZE_T</b> Length of uncompiled shader data that <i>pSrcData</i> points to.
///    uNumShaders = Type: <b>UINT</b> The number of shaders to decompress.
///    uStartIndex = Type: <b>UINT</b> The index of the first shader to decompress.
///    pIndices = Type: <b>UINT*</b> An array of indexes that represent the shaders to decompress.
///    uFlags = Type: <b>UINT</b> Flags that indicate how to decompress. Currently, no flags are defined.
///    ppShaders = Type: <b>ID3DBlob**</b> The address of a pointer to the ID3DBlob interface that is used to retrieve the
///                decompressed shader data.
///    pTotalShaders = Type: <b>UINT*</b> A pointer to a variable that receives the total number of shaders that
///                    <b>D3DDecompressShaders</b> decompressed.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DDecompressShaders(const(void)* pSrcData, size_t SrcDataSize, uint uNumShaders, uint uStartIndex, 
                             uint* pIndices, uint uFlags, ID3DBlob* ppShaders, uint* pTotalShaders);

///Disassembles compiled HLSL code from a Direct3D10 effect.
///Params:
///    pEffect = Type: <b>ID3D10Effect*</b> A pointer to source data as compiled HLSL code.
///    Flags = Type: <b>UINT</b> Shader compile options.
///    ppDisassembly = Type: <b>ID3DBlob**</b> A pointer to a buffer that receives the ID3DBlob interface that contains disassembly
///                    text.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 return codes.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DDisassemble10Effect(ID3D10Effect pEffect, uint Flags, ID3DBlob* ppDisassembly);


