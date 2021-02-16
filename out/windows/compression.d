module windows.compression;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum : int
{
    COMPRESS_INFORMATION_CLASS_INVALID    = 0x00000000,
    COMPRESS_INFORMATION_CLASS_BLOCK_SIZE = 0x00000001,
    COMPRESS_INFORMATION_CLASS_LEVEL      = 0x00000002,
}
alias COMPRESS_INFORMATION_CLASS = int;

// Callbacks

alias PFN_COMPRESS_ALLOCATE = void* function(void* UserContext, size_t Size);
alias PFN_COMPRESS_FREE = void function(void* UserContext, void* Memory);

// Structs


alias COMPRESSOR_HANDLE = ptrdiff_t;

struct COMPRESS_ALLOCATION_ROUTINES
{
    PFN_COMPRESS_ALLOCATE Allocate;
    PFN_COMPRESS_FREE Free;
    void*             UserContext;
}

// Functions

@DllImport("Cabinet")
BOOL CreateCompressor(uint Algorithm, COMPRESS_ALLOCATION_ROUTINES* AllocationRoutines, 
                      COMPRESSOR_HANDLE* CompressorHandle);

@DllImport("Cabinet")
BOOL SetCompressorInformation(COMPRESSOR_HANDLE CompressorHandle, 
                              COMPRESS_INFORMATION_CLASS CompressInformationClass, char* CompressInformation, 
                              size_t CompressInformationSize);

@DllImport("Cabinet")
BOOL QueryCompressorInformation(COMPRESSOR_HANDLE CompressorHandle, 
                                COMPRESS_INFORMATION_CLASS CompressInformationClass, char* CompressInformation, 
                                size_t CompressInformationSize);

@DllImport("Cabinet")
BOOL Compress(COMPRESSOR_HANDLE CompressorHandle, char* UncompressedData, size_t UncompressedDataSize, 
              char* CompressedBuffer, size_t CompressedBufferSize, size_t* CompressedDataSize);

@DllImport("Cabinet")
BOOL ResetCompressor(COMPRESSOR_HANDLE CompressorHandle);

@DllImport("Cabinet")
BOOL CloseCompressor(COMPRESSOR_HANDLE CompressorHandle);

@DllImport("Cabinet")
BOOL CreateDecompressor(uint Algorithm, COMPRESS_ALLOCATION_ROUTINES* AllocationRoutines, 
                        ptrdiff_t* DecompressorHandle);

@DllImport("Cabinet")
BOOL SetDecompressorInformation(ptrdiff_t DecompressorHandle, COMPRESS_INFORMATION_CLASS CompressInformationClass, 
                                char* CompressInformation, size_t CompressInformationSize);

@DllImport("Cabinet")
BOOL QueryDecompressorInformation(ptrdiff_t DecompressorHandle, 
                                  COMPRESS_INFORMATION_CLASS CompressInformationClass, char* CompressInformation, 
                                  size_t CompressInformationSize);

@DllImport("Cabinet")
BOOL Decompress(ptrdiff_t DecompressorHandle, char* CompressedData, size_t CompressedDataSize, 
                char* UncompressedBuffer, size_t UncompressedBufferSize, size_t* UncompressedDataSize);

@DllImport("Cabinet")
BOOL ResetDecompressor(ptrdiff_t DecompressorHandle);

@DllImport("Cabinet")
BOOL CloseDecompressor(ptrdiff_t DecompressorHandle);


