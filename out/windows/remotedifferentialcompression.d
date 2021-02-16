module windows.remotedifferentialcompression;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum : int
{
    RDC_NoError                = 0x00000000,
    RDC_HeaderVersionNewer     = 0x00000001,
    RDC_HeaderVersionOlder     = 0x00000002,
    RDC_HeaderMissingOrCorrupt = 0x00000003,
    RDC_HeaderWrongType        = 0x00000004,
    RDC_DataMissingOrCorrupt   = 0x00000005,
    RDC_DataTooManyRecords     = 0x00000006,
    RDC_FileChecksumMismatch   = 0x00000007,
    RDC_ApplicationError       = 0x00000008,
    RDC_Aborted                = 0x00000009,
    RDC_Win32Error             = 0x0000000a,
}
alias RDC_ErrorCode = int;

enum GeneratorParametersType : int
{
    RDCGENTYPE_Unused    = 0x00000000,
    RDCGENTYPE_FilterMax = 0x00000001,
}

enum RdcNeedType : int
{
    RDCNEED_SOURCE   = 0x00000000,
    RDCNEED_TARGET   = 0x00000001,
    RDCNEED_SEED     = 0x00000002,
    RDCNEED_SEED_MAX = 0x000000ff,
}

enum RdcCreatedTables : int
{
    RDCTABLE_InvalidOrUnknown = 0x00000000,
    RDCTABLE_Existing         = 0x00000001,
    RDCTABLE_New              = 0x00000002,
}

enum RdcMappingAccessMode : int
{
    RDCMAPPING_Undefined = 0x00000000,
    RDCMAPPING_ReadOnly  = 0x00000001,
    RDCMAPPING_ReadWrite = 0x00000002,
}

// Constants


enum : uint
{
    MSRDC_VERSION                        = 0x00010000,
    MSRDC_MINIMUM_COMPATIBLE_APP_VERSION = 0x00010000,
}

enum uint MSRDC_MAXIMUM_DEPTH = 0x00000008;
enum uint MSRDC_MAXIMUM_COMPAREBUFFER = 0x40000000;

enum : uint
{
    MSRDC_MINIMUM_INPUTBUFFERSIZE = 0x00000400,
    MSRDC_MINIMUM_HORIZONSIZE     = 0x00000080,
}

enum uint MSRDC_MINIMUM_HASHWINDOWSIZE = 0x00000002;

enum : uint
{
    MSRDC_DEFAULT_HASHWINDOWSIZE_1 = 0x00000030,
    MSRDC_DEFAULT_HORIZONSIZE_1    = 0x00000400,
    MSRDC_DEFAULT_HASHWINDOWSIZE_N = 0x00000002,
    MSRDC_DEFAULT_HORIZONSIZE_N    = 0x00000080,
}

enum uint MSRDC_MINIMUM_MATCHESREQUIRED = 0x00000001;

// Structs


struct RdcNeed
{
    RdcNeedType m_BlockType;
    ulong       m_FileOffset;
    ulong       m_BlockLength;
}

struct RdcBufferPointer
{
    uint   m_Size;
    uint   m_Used;
    ubyte* m_Data;
}

struct RdcNeedPointer
{
    uint     m_Size;
    uint     m_Used;
    RdcNeed* m_Data;
}

struct RdcSignature
{
    ubyte[16] m_Signature;
    ushort    m_BlockLength;
}

struct RdcSignaturePointer
{
    uint          m_Size;
    uint          m_Used;
    RdcSignature* m_Data;
}

struct SimilarityMappedViewInfo
{
    ubyte* m_Data;
    uint   m_Length;
}

struct SimilarityData
{
    ubyte[16] m_Data;
}

struct FindSimilarFileIndexResults
{
    uint m_FileIndex;
    uint m_MatchCount;
}

struct SimilarityDumpData
{
    uint           m_FileIndex;
    SimilarityData m_Data;
}

struct SimilarityFileId
{
    ubyte[32] m_FileId;
}

// Interfaces

@GUID("96236A85-9DBC-11DA-9E3F-0011114AE311")
struct RdcLibrary;

@GUID("96236A86-9DBC-11DA-9E3F-0011114AE311")
struct RdcGeneratorParameters;

@GUID("96236A87-9DBC-11DA-9E3F-0011114AE311")
struct RdcGeneratorFilterMaxParameters;

@GUID("96236A88-9DBC-11DA-9E3F-0011114AE311")
struct RdcGenerator;

@GUID("96236A89-9DBC-11DA-9E3F-0011114AE311")
struct RdcFileReader;

@GUID("96236A8A-9DBC-11DA-9E3F-0011114AE311")
struct RdcSignatureReader;

@GUID("96236A8B-9DBC-11DA-9E3F-0011114AE311")
struct RdcComparator;

@GUID("96236A8D-9DBC-11DA-9E3F-0011114AE311")
struct SimilarityReportProgress;

@GUID("96236A8E-9DBC-11DA-9E3F-0011114AE311")
struct SimilarityTableDumpState;

@GUID("96236A8F-9DBC-11DA-9E3F-0011114AE311")
struct SimilarityTraitsTable;

@GUID("96236A90-9DBC-11DA-9E3F-0011114AE311")
struct SimilarityFileIdTable;

@GUID("96236A91-9DBC-11DA-9E3F-0011114AE311")
struct Similarity;

@GUID("96236A92-9DBC-11DA-9E3F-0011114AE311")
struct RdcSimilarityGenerator;

@GUID("96236A93-9DBC-11DA-9E3F-0011114AE311")
struct FindSimilarResults;

@GUID("96236A94-9DBC-11DA-9E3F-0011114AE311")
struct SimilarityTraitsMapping;

@GUID("96236A95-9DBC-11DA-9E3F-0011114AE311")
struct SimilarityTraitsMappedView;

@GUID("96236A71-9DBC-11DA-9E3F-0011114AE311")
interface IRdcGeneratorParameters : IUnknown
{
    HRESULT GetGeneratorParametersType(GeneratorParametersType* parametersType);
    HRESULT GetParametersVersion(uint* currentVersion, uint* minimumCompatibleAppVersion);
    HRESULT GetSerializeSize(uint* size);
    HRESULT Serialize(uint size, ubyte* parametersBlob, uint* bytesWritten);
}

@GUID("96236A72-9DBC-11DA-9E3F-0011114AE311")
interface IRdcGeneratorFilterMaxParameters : IUnknown
{
    HRESULT GetHorizonSize(uint* horizonSize);
    HRESULT SetHorizonSize(uint horizonSize);
    HRESULT GetHashWindowSize(uint* hashWindowSize);
    HRESULT SetHashWindowSize(uint hashWindowSize);
}

@GUID("96236A73-9DBC-11DA-9E3F-0011114AE311")
interface IRdcGenerator : IUnknown
{
    HRESULT GetGeneratorParameters(uint level, IRdcGeneratorParameters* iGeneratorParameters);
    HRESULT Process(BOOL endOfInput, int* endOfOutput, RdcBufferPointer* inputBuffer, uint depth, 
                    RdcBufferPointer** outputBuffers, RDC_ErrorCode* rdc_ErrorCode);
}

@GUID("96236A74-9DBC-11DA-9E3F-0011114AE311")
interface IRdcFileReader : IUnknown
{
    HRESULT GetFileSize(ulong* fileSize);
    HRESULT Read(ulong offsetFileStart, uint bytesToRead, uint* bytesActuallyRead, ubyte* buffer, int* eof);
    HRESULT GetFilePosition(ulong* offsetFromStart);
}

@GUID("96236A75-9DBC-11DA-9E3F-0011114AE311")
interface IRdcFileWriter : IRdcFileReader
{
    HRESULT Write(ulong offsetFileStart, uint bytesToWrite, ubyte* buffer);
    HRESULT Truncate();
    HRESULT DeleteOnClose();
}

@GUID("96236A76-9DBC-11DA-9E3F-0011114AE311")
interface IRdcSignatureReader : IUnknown
{
    HRESULT ReadHeader(RDC_ErrorCode* rdc_ErrorCode);
    HRESULT ReadSignatures(RdcSignaturePointer* rdcSignaturePointer, int* endOfOutput);
}

@GUID("96236A77-9DBC-11DA-9E3F-0011114AE311")
interface IRdcComparator : IUnknown
{
    HRESULT Process(BOOL endOfInput, int* endOfOutput, RdcBufferPointer* inputBuffer, RdcNeedPointer* outputBuffer, 
                    RDC_ErrorCode* rdc_ErrorCode);
}

@GUID("96236A78-9DBC-11DA-9E3F-0011114AE311")
interface IRdcLibrary : IUnknown
{
    HRESULT ComputeDefaultRecursionDepth(ulong fileSize, uint* depth);
    HRESULT CreateGeneratorParameters(GeneratorParametersType parametersType, uint level, 
                                      IRdcGeneratorParameters* iGeneratorParameters);
    HRESULT OpenGeneratorParameters(uint size, const(ubyte)* parametersBlob, 
                                    IRdcGeneratorParameters* iGeneratorParameters);
    HRESULT CreateGenerator(uint depth, IRdcGeneratorParameters* iGeneratorParametersArray, 
                            IRdcGenerator* iGenerator);
    HRESULT CreateComparator(IRdcFileReader iSeedSignaturesFile, uint comparatorBufferSize, 
                             IRdcComparator* iComparator);
    HRESULT CreateSignatureReader(IRdcFileReader iFileReader, IRdcSignatureReader* iSignatureReader);
    HRESULT GetRDCVersion(uint* currentVersion, uint* minimumCompatibleAppVersion);
}

@GUID("96236A7A-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityReportProgress : IUnknown
{
    HRESULT ReportProgress(uint percentCompleted);
}

@GUID("96236A7B-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityTableDumpState : IUnknown
{
    HRESULT GetNextData(uint resultsSize, uint* resultsUsed, int* eof, SimilarityDumpData* results);
}

@GUID("96236A7C-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityTraitsMappedView : IUnknown
{
    HRESULT Flush();
    HRESULT Unmap();
    HRESULT Get(ulong index, BOOL dirty, uint numElements, SimilarityMappedViewInfo* viewInfo);
    void    GetView(const(ubyte)** mappedPageBegin, const(ubyte)** mappedPageEnd);
}

@GUID("96236A7D-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityTraitsMapping : IUnknown
{
    void    CloseMapping();
    HRESULT SetFileSize(ulong fileSize);
    HRESULT GetFileSize(ulong* fileSize);
    HRESULT OpenMapping(RdcMappingAccessMode accessMode, ulong begin, ulong end, ulong* actualEnd);
    HRESULT ResizeMapping(RdcMappingAccessMode accessMode, ulong begin, ulong end, ulong* actualEnd);
    void    GetPageSize(uint* pageSize);
    HRESULT CreateView(uint minimumMappedPages, RdcMappingAccessMode accessMode, 
                       ISimilarityTraitsMappedView* mappedView);
}

@GUID("96236A7E-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityTraitsTable : IUnknown
{
    HRESULT CreateTable(ushort* path, BOOL truncate, ubyte* securityDescriptor, RdcCreatedTables* isNew);
    HRESULT CreateTableIndirect(ISimilarityTraitsMapping mapping, BOOL truncate, RdcCreatedTables* isNew);
    HRESULT CloseTable(BOOL isValid);
    HRESULT Append(SimilarityData* data, uint fileIndex);
    HRESULT FindSimilarFileIndex(SimilarityData* similarityData, ushort numberOfMatchesRequired, 
                                 FindSimilarFileIndexResults* findSimilarFileIndexResults, uint resultsSize, 
                                 uint* resultsUsed);
    HRESULT BeginDump(ISimilarityTableDumpState* similarityTableDumpState);
    HRESULT GetLastIndex(uint* fileIndex);
}

@GUID("96236A7F-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityFileIdTable : IUnknown
{
    HRESULT CreateTable(ushort* path, BOOL truncate, ubyte* securityDescriptor, uint recordSize, 
                        RdcCreatedTables* isNew);
    HRESULT CreateTableIndirect(IRdcFileWriter fileIdFile, BOOL truncate, uint recordSize, RdcCreatedTables* isNew);
    HRESULT CloseTable(BOOL isValid);
    HRESULT Append(SimilarityFileId* similarityFileId, uint* similarityFileIndex);
    HRESULT Lookup(uint similarityFileIndex, SimilarityFileId* similarityFileId);
    HRESULT Invalidate(uint similarityFileIndex);
    HRESULT GetRecordCount(uint* recordCount);
}

@GUID("96236A80-9DBC-11DA-9E3F-0011114AE311")
interface IRdcSimilarityGenerator : IUnknown
{
    HRESULT EnableSimilarity();
    HRESULT Results(SimilarityData* similarityData);
}

@GUID("96236A81-9DBC-11DA-9E3F-0011114AE311")
interface IFindSimilarResults : IUnknown
{
    HRESULT GetSize(uint* size);
    HRESULT GetNextFileId(uint* numTraitsMatched, SimilarityFileId* similarityFileId);
}

@GUID("96236A83-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarity : IUnknown
{
    HRESULT CreateTable(ushort* path, BOOL truncate, ubyte* securityDescriptor, uint recordSize, 
                        RdcCreatedTables* isNew);
    HRESULT CreateTableIndirect(ISimilarityTraitsMapping mapping, IRdcFileWriter fileIdFile, BOOL truncate, 
                                uint recordSize, RdcCreatedTables* isNew);
    HRESULT CloseTable(BOOL isValid);
    HRESULT Append(SimilarityFileId* similarityFileId, SimilarityData* similarityData);
    HRESULT FindSimilarFileId(SimilarityData* similarityData, ushort numberOfMatchesRequired, uint resultsSize, 
                              IFindSimilarResults* findSimilarResults);
    HRESULT CopyAndSwap(ISimilarity newSimilarityTables, ISimilarityReportProgress reportProgress);
    HRESULT GetRecordCount(uint* recordCount);
}


// GUIDs

const GUID CLSID_FindSimilarResults              = GUIDOF!FindSimilarResults;
const GUID CLSID_RdcComparator                   = GUIDOF!RdcComparator;
const GUID CLSID_RdcFileReader                   = GUIDOF!RdcFileReader;
const GUID CLSID_RdcGenerator                    = GUIDOF!RdcGenerator;
const GUID CLSID_RdcGeneratorFilterMaxParameters = GUIDOF!RdcGeneratorFilterMaxParameters;
const GUID CLSID_RdcGeneratorParameters          = GUIDOF!RdcGeneratorParameters;
const GUID CLSID_RdcLibrary                      = GUIDOF!RdcLibrary;
const GUID CLSID_RdcSignatureReader              = GUIDOF!RdcSignatureReader;
const GUID CLSID_RdcSimilarityGenerator          = GUIDOF!RdcSimilarityGenerator;
const GUID CLSID_Similarity                      = GUIDOF!Similarity;
const GUID CLSID_SimilarityFileIdTable           = GUIDOF!SimilarityFileIdTable;
const GUID CLSID_SimilarityReportProgress        = GUIDOF!SimilarityReportProgress;
const GUID CLSID_SimilarityTableDumpState        = GUIDOF!SimilarityTableDumpState;
const GUID CLSID_SimilarityTraitsMappedView      = GUIDOF!SimilarityTraitsMappedView;
const GUID CLSID_SimilarityTraitsMapping         = GUIDOF!SimilarityTraitsMapping;
const GUID CLSID_SimilarityTraitsTable           = GUIDOF!SimilarityTraitsTable;

const GUID IID_IFindSimilarResults              = GUIDOF!IFindSimilarResults;
const GUID IID_IRdcComparator                   = GUIDOF!IRdcComparator;
const GUID IID_IRdcFileReader                   = GUIDOF!IRdcFileReader;
const GUID IID_IRdcFileWriter                   = GUIDOF!IRdcFileWriter;
const GUID IID_IRdcGenerator                    = GUIDOF!IRdcGenerator;
const GUID IID_IRdcGeneratorFilterMaxParameters = GUIDOF!IRdcGeneratorFilterMaxParameters;
const GUID IID_IRdcGeneratorParameters          = GUIDOF!IRdcGeneratorParameters;
const GUID IID_IRdcLibrary                      = GUIDOF!IRdcLibrary;
const GUID IID_IRdcSignatureReader              = GUIDOF!IRdcSignatureReader;
const GUID IID_IRdcSimilarityGenerator          = GUIDOF!IRdcSimilarityGenerator;
const GUID IID_ISimilarity                      = GUIDOF!ISimilarity;
const GUID IID_ISimilarityFileIdTable           = GUIDOF!ISimilarityFileIdTable;
const GUID IID_ISimilarityReportProgress        = GUIDOF!ISimilarityReportProgress;
const GUID IID_ISimilarityTableDumpState        = GUIDOF!ISimilarityTableDumpState;
const GUID IID_ISimilarityTraitsMappedView      = GUIDOF!ISimilarityTraitsMappedView;
const GUID IID_ISimilarityTraitsMapping         = GUIDOF!ISimilarityTraitsMapping;
const GUID IID_ISimilarityTraitsTable           = GUIDOF!ISimilarityTraitsTable;
