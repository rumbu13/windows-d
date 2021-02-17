// Written in the D programming language.

module out.windows.compression;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


///The values of this enumeration identify the type of information class being set or retrieved.
alias COMPRESS_INFORMATION_CLASS = int;
enum : int
{
    ///Invalid information class
    COMPRESS_INFORMATION_CLASS_INVALID    = 0x00000000,
    ///Customized block size. The value specified may be from 65536 to 67108864 bytes. This value can be used only with
    ///the LZMS compression algorithm. A minimum size of 1 MB is suggested to get a better compression ratio. An
    ///information class of this type is sizeof(DWORD).
    COMPRESS_INFORMATION_CLASS_BLOCK_SIZE = 0x00000001,
    COMPRESS_INFORMATION_CLASS_LEVEL      = 0x00000002,
}

// Callbacks

alias PFN_COMPRESS_ALLOCATE = void* function(void* UserContext, size_t Size);
alias PFN_COMPRESS_FREE = void function(void* UserContext, void* Memory);

// Structs


alias COMPRESSOR_HANDLE = ptrdiff_t;

///A structure containing optional memory allocation and deallocation routines.
struct COMPRESS_ALLOCATION_ROUTINES
{
    ///Callback that allocates memory.
    PFN_COMPRESS_ALLOCATE Allocate;
    ///Callback that deallocates memory.
    PFN_COMPRESS_FREE Free;
    void*             UserContext;
}

// Functions

///Generates a new <b>COMPRESSOR_HANDLE</b>.
///Params:
///    Algorithm = The type of compression algorithm and mode to be used by this compressor. This parameter can have one of the
///                following values optionally combined with the <b>COMPRESS_RAW</b> flag. Use a "bitwise OR" operator to include
///                <b>COMPRESS_RAW</b> and to create a block mode compressor. If <b>COMPRESS_RAW</b> is not included, the
///                Compression API creates a buffer mode compressor. For more information about selecting a compression algorithm
///                and mode, see Using the Compression API. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="COMPRESS_ALGORITHM_MSZIP"></a><a id="compress_algorithm_mszip"></a><dl>
///                <dt><b>COMPRESS_ALGORITHM_MSZIP</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> MSZIP compression algorithm
///                </td> </tr> <tr> <td width="40%"><a id="COMPRESS_ALGORITHM_XPRESS"></a><a id="compress_algorithm_xpress"></a><dl>
///                <dt><b>COMPRESS_ALGORITHM_XPRESS</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> XPRESS compression algorithm
///                </td> </tr> <tr> <td width="40%"><a id="COMPRESS_ALGORITHM_XPRESS_HUFF"></a><a
///                id="compress_algorithm_xpress_huff"></a><dl> <dt><b>COMPRESS_ALGORITHM_XPRESS_HUFF</b></dt> <dt>4</dt> </dl>
///                </td> <td width="60%"> XPRESS compression algorithm with Huffman encoding </td> </tr> <tr> <td width="40%"><a
///                id="COMPRESS_ALGORITHM_LZMS"></a><a id="compress_algorithm_lzms"></a><dl> <dt><b>COMPRESS_ALGORITHM_LZMS</b></dt>
///                <dt>5</dt> </dl> </td> <td width="60%"> LZMS compression algorithm </td> </tr> </table>
///    AllocationRoutines = Optional memory allocation and deallocation routines in a COMPRESS_ALLOCATION_ROUTINES structure.
///    CompressorHandle = If the function succeeds, the handle to the specified compressor.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL CreateCompressor(uint Algorithm, COMPRESS_ALLOCATION_ROUTINES* AllocationRoutines, 
                      COMPRESSOR_HANDLE* CompressorHandle);

///Sets information in a compressor for a particular compression algorithm.
///Params:
///    CompressorHandle = Handle to the compressor.
///    CompressInformationClass = A value that identifies the type of information. of the enumeration that identifies the type of information.
///    CompressInformation = The information being set read as bytes. The maximum size in bytes is given by <i>CompressInformationSize</i>.
///    CompressInformationSize = Maximum size of the information in bytes.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL SetCompressorInformation(COMPRESSOR_HANDLE CompressorHandle, 
                              COMPRESS_INFORMATION_CLASS CompressInformationClass, char* CompressInformation, 
                              size_t CompressInformationSize);

///Queries a compressor for information for a particular compression algorithm.
///Params:
///    CompressorHandle = Handle to the compressor being queried for information.
///    CompressInformationClass = A value of the COMPRESS_INFORMATION_CLASS enumeration that identifies the type of information.
///    CompressInformation = Information for the compression algorithm written as bytes. The maximum size in bytes of this information is
///                          given by <i>CompressInformationSize</i>.
///    CompressInformationSize = Maximum size in bytes of the information.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL QueryCompressorInformation(COMPRESSOR_HANDLE CompressorHandle, 
                                COMPRESS_INFORMATION_CLASS CompressInformationClass, char* CompressInformation, 
                                size_t CompressInformationSize);

///Takes a block of information and compresses it.
///Params:
///    CompressorHandle = Handle to a compressor returned by CreateCompressor.
///    UncompressedData = Contains the block of information that is to be compressed. The size in bytes of the uncompressed block is given
///                       by <i>UncompressedDataSize</i>.
///    UncompressedDataSize = Size in bytes of the uncompressed information.
///    CompressedBuffer = The buffer that receives the compressed information. The maximum size in bytes of the buffer is given by
///                       <i>CompressedBufferSize</i>.
///    CompressedBufferSize = Maximum size in bytes of the buffer that receives the compressed information.
///    CompressedDataSize = Actual size in bytes of the compressed information received.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL Compress(COMPRESSOR_HANDLE CompressorHandle, char* UncompressedData, size_t UncompressedDataSize, 
              char* CompressedBuffer, size_t CompressedBufferSize, size_t* CompressedDataSize);

///Prepares the compressor for the compression of a new stream. The compressor object retains properties set with
///SetCompressorInformation. The sequence of blocks generated is independent of previous blocks.
///Params:
///    CompressorHandle = Handle to the compressor returned by CreateCompressor.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL ResetCompressor(COMPRESSOR_HANDLE CompressorHandle);

///Call to close an open <b>COMPRESSOR_HANDLE</b>.
///Params:
///    CompressorHandle = Handle to the compressor to be closed. This is the handle to the compressor that was returned by
///                       CreateCompressor.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL CloseCompressor(COMPRESSOR_HANDLE CompressorHandle);

///Generates a new <b>DECOMPRESSOR_HANDLE</b>.
///Params:
///    Algorithm = The type of compression algorithm and mode to be used by this decompressor. This parameter can have one of the
///                following values optionally combined with the <b>COMPRESS_RAW</b> flag. Use a "bitwise OR" operator to include
///                <b>COMPRESS_RAW</b> and to create a block mode decompressor. If <b>COMPRESS_RAW</b> is not included, the
///                Compression API creates a buffer mode decompressor. For more information about selecting a compression algorithm
///                and mode, see Using the Compression API. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="COMPRESS_ALGORITHM_MSZIP"></a><a id="compress_algorithm_mszip"></a><dl>
///                <dt><b>COMPRESS_ALGORITHM_MSZIP</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> MSZIP compression algorithm
///                </td> </tr> <tr> <td width="40%"><a id="COMPRESS_ALGORITHM_XPRESS"></a><a id="compress_algorithm_xpress"></a><dl>
///                <dt><b>COMPRESS_ALGORITHM_XPRESS</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> XPRESS compression algorithm
///                </td> </tr> <tr> <td width="40%"><a id="COMPRESS_ALGORITHM_XPRESS_HUFF"></a><a
///                id="compress_algorithm_xpress_huff"></a><dl> <dt><b>COMPRESS_ALGORITHM_XPRESS_HUFF</b></dt> <dt>4</dt> </dl>
///                </td> <td width="60%"> XPRESS compression algorithm with Huffman encoding </td> </tr> <tr> <td width="40%"><a
///                id="COMPRESS_ALGORITHM_LZMS"></a><a id="compress_algorithm_lzms"></a><dl> <dt><b>COMPRESS_ALGORITHM_LZMS</b></dt>
///                <dt>5</dt> </dl> </td> <td width="60%"> LZMS compression algorithm </td> </tr> </table>
///    AllocationRoutines = Optional memory allocation and deallocation routines in a COMPRESS_ALLOCATION_ROUTINES structure.
///    DecompressorHandle = If the function succeeds, the handle to the specified decompressor.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL CreateDecompressor(uint Algorithm, COMPRESS_ALLOCATION_ROUTINES* AllocationRoutines, 
                        ptrdiff_t* DecompressorHandle);

///Sets information in a decompressor for a particular compression algorithm.
///Params:
///    DecompressorHandle = Handle to the decompressor.
///    CompressInformationClass = A value that identifies the type of information. of the enumeration that identifies the type of information.
///    CompressInformation = The information being set read as bytes. The maximum size in bytes is given by <i>CompressInformationSize</i>.
///    CompressInformationSize = Maximum size of the information in bytes.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL SetDecompressorInformation(ptrdiff_t DecompressorHandle, COMPRESS_INFORMATION_CLASS CompressInformationClass, 
                                char* CompressInformation, size_t CompressInformationSize);

///Use this function to query information about a particular compression algorithm.
///Params:
///    DecompressorHandle = Handle to the decompressor being queried for information.
///    CompressInformationClass = A value of the COMPRESS_INFORMATION_CLASS enumeration that identifies the type of information.
///    CompressInformation = Information for the compression algorithm written as bytes. The maximum size in bytes of this information is
///                          given by <i>CompressInformationSize</i>.
///    CompressInformationSize = Maximum size in bytes of the information.
///Returns:
///    Returns <b>TRUE</b> to indicate success and <b>FALSE</b> otherwise. Call GetLastError to determine cause of
///    failure.
///    
@DllImport("Cabinet")
BOOL QueryDecompressorInformation(ptrdiff_t DecompressorHandle, 
                                  COMPRESS_INFORMATION_CLASS CompressInformationClass, char* CompressInformation, 
                                  size_t CompressInformationSize);

///Takes a block of compressed information and decompresses it.
///Params:
///    DecompressorHandle = Handle to a decompressor returned by CreateDecompressor.
///    CompressedData = Contains the block of information that is to be decompressed. The size in bytes of the compressed block is given
///                     by <i>CompressedDataSize</i>.
///    CompressedDataSize = The size in bytes of the compressed information.
///    UncompressedBuffer = The buffer that receives the uncompressed information. The size in bytes of the buffer is given by
///                         <i>UncompressedBufferSize</i>.
///    UncompressedBufferSize = Size in bytes of the buffer that receives the uncompressed information.
///    UncompressedDataSize = Actual size in bytes of the uncompressed information received.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL Decompress(ptrdiff_t DecompressorHandle, char* CompressedData, size_t CompressedDataSize, 
                char* UncompressedBuffer, size_t UncompressedBufferSize, size_t* UncompressedDataSize);

///Prepares the decompressor for the decompression of a new stream.
///Params:
///    DecompressorHandle = Handle to the decompressor returned by CreateDecompressor.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL ResetDecompressor(ptrdiff_t DecompressorHandle);

///Call to close an open <b>DECOMPRESSOR_HANDLE</b>.
///Params:
///    DecompressorHandle = Handle to the decompressor to be closed. This is the handle to the compressor that was returned by
///                         CreateDecompressor.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("Cabinet")
BOOL CloseDecompressor(ptrdiff_t DecompressorHandle);


