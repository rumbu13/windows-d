module windows.compression;

public import windows.systemservices;

extern(Windows):

alias COMPRESSOR_HANDLE = int;
alias PFN_COMPRESS_ALLOCATE = extern(Windows) void* function(void* UserContext, uint Size);
alias PFN_COMPRESS_FREE = extern(Windows) void function(void* UserContext, void* Memory);
struct COMPRESS_ALLOCATION_ROUTINES
{
    PFN_COMPRESS_ALLOCATE Allocate;
    PFN_COMPRESS_FREE Free;
    void* UserContext;
}

enum COMPRESS_INFORMATION_CLASS
{
    COMPRESS_INFORMATION_CLASS_INVALID = 0,
    COMPRESS_INFORMATION_CLASS_BLOCK_SIZE = 1,
    COMPRESS_INFORMATION_CLASS_LEVEL = 2,
}

@DllImport("Cabinet.dll")
BOOL CreateCompressor(uint Algorithm, COMPRESS_ALLOCATION_ROUTINES* AllocationRoutines, COMPRESSOR_HANDLE* CompressorHandle);

@DllImport("Cabinet.dll")
BOOL SetCompressorInformation(COMPRESSOR_HANDLE CompressorHandle, COMPRESS_INFORMATION_CLASS CompressInformationClass, char* CompressInformation, uint CompressInformationSize);

@DllImport("Cabinet.dll")
BOOL QueryCompressorInformation(COMPRESSOR_HANDLE CompressorHandle, COMPRESS_INFORMATION_CLASS CompressInformationClass, char* CompressInformation, uint CompressInformationSize);

@DllImport("Cabinet.dll")
BOOL Compress(COMPRESSOR_HANDLE CompressorHandle, char* UncompressedData, uint UncompressedDataSize, char* CompressedBuffer, uint CompressedBufferSize, uint* CompressedDataSize);

@DllImport("Cabinet.dll")
BOOL ResetCompressor(COMPRESSOR_HANDLE CompressorHandle);

@DllImport("Cabinet.dll")
BOOL CloseCompressor(COMPRESSOR_HANDLE CompressorHandle);

@DllImport("Cabinet.dll")
BOOL CreateDecompressor(uint Algorithm, COMPRESS_ALLOCATION_ROUTINES* AllocationRoutines, int* DecompressorHandle);

@DllImport("Cabinet.dll")
BOOL SetDecompressorInformation(int DecompressorHandle, COMPRESS_INFORMATION_CLASS CompressInformationClass, char* CompressInformation, uint CompressInformationSize);

@DllImport("Cabinet.dll")
BOOL QueryDecompressorInformation(int DecompressorHandle, COMPRESS_INFORMATION_CLASS CompressInformationClass, char* CompressInformation, uint CompressInformationSize);

@DllImport("Cabinet.dll")
BOOL Decompress(int DecompressorHandle, char* CompressedData, uint CompressedDataSize, char* UncompressedBuffer, uint UncompressedBufferSize, uint* UncompressedDataSize);

@DllImport("Cabinet.dll")
BOOL ResetDecompressor(int DecompressorHandle);

@DllImport("Cabinet.dll")
BOOL CloseDecompressor(int DecompressorHandle);

