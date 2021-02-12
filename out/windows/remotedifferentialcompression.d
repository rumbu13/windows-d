module windows.remotedifferentialcompression;

public import windows.com;
public import windows.systemservices;

extern(Windows):

const GUID CLSID_RdcLibrary = {0x96236A85, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A85, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct RdcLibrary;

const GUID CLSID_RdcGeneratorParameters = {0x96236A86, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A86, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct RdcGeneratorParameters;

const GUID CLSID_RdcGeneratorFilterMaxParameters = {0x96236A87, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A87, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct RdcGeneratorFilterMaxParameters;

const GUID CLSID_RdcGenerator = {0x96236A88, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A88, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct RdcGenerator;

const GUID CLSID_RdcFileReader = {0x96236A89, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A89, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct RdcFileReader;

const GUID CLSID_RdcSignatureReader = {0x96236A8A, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A8A, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct RdcSignatureReader;

const GUID CLSID_RdcComparator = {0x96236A8B, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A8B, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct RdcComparator;

const GUID CLSID_SimilarityReportProgress = {0x96236A8D, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A8D, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct SimilarityReportProgress;

const GUID CLSID_SimilarityTableDumpState = {0x96236A8E, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A8E, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct SimilarityTableDumpState;

const GUID CLSID_SimilarityTraitsTable = {0x96236A8F, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A8F, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct SimilarityTraitsTable;

const GUID CLSID_SimilarityFileIdTable = {0x96236A90, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A90, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct SimilarityFileIdTable;

const GUID CLSID_Similarity = {0x96236A91, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A91, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct Similarity;

const GUID CLSID_RdcSimilarityGenerator = {0x96236A92, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A92, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct RdcSimilarityGenerator;

const GUID CLSID_FindSimilarResults = {0x96236A93, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A93, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct FindSimilarResults;

const GUID CLSID_SimilarityTraitsMapping = {0x96236A94, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A94, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct SimilarityTraitsMapping;

const GUID CLSID_SimilarityTraitsMappedView = {0x96236A95, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A95, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
struct SimilarityTraitsMappedView;

enum RDC_ErrorCode
{
    RDC_NoError = 0,
    RDC_HeaderVersionNewer = 1,
    RDC_HeaderVersionOlder = 2,
    RDC_HeaderMissingOrCorrupt = 3,
    RDC_HeaderWrongType = 4,
    RDC_DataMissingOrCorrupt = 5,
    RDC_DataTooManyRecords = 6,
    RDC_FileChecksumMismatch = 7,
    RDC_ApplicationError = 8,
    RDC_Aborted = 9,
    RDC_Win32Error = 10,
}

enum GeneratorParametersType
{
    RDCGENTYPE_Unused = 0,
    RDCGENTYPE_FilterMax = 1,
}

enum RdcNeedType
{
    RDCNEED_SOURCE = 0,
    RDCNEED_TARGET = 1,
    RDCNEED_SEED = 2,
    RDCNEED_SEED_MAX = 255,
}

struct RdcNeed
{
    RdcNeedType m_BlockType;
    ulong m_FileOffset;
    ulong m_BlockLength;
}

struct RdcBufferPointer
{
    uint m_Size;
    uint m_Used;
    ubyte* m_Data;
}

struct RdcNeedPointer
{
    uint m_Size;
    uint m_Used;
    RdcNeed* m_Data;
}

struct RdcSignature
{
    ubyte m_Signature;
    ushort m_BlockLength;
}

struct RdcSignaturePointer
{
    uint m_Size;
    uint m_Used;
    RdcSignature* m_Data;
}

enum RdcCreatedTables
{
    RDCTABLE_InvalidOrUnknown = 0,
    RDCTABLE_Existing = 1,
    RDCTABLE_New = 2,
}

enum RdcMappingAccessMode
{
    RDCMAPPING_Undefined = 0,
    RDCMAPPING_ReadOnly = 1,
    RDCMAPPING_ReadWrite = 2,
}

struct SimilarityMappedViewInfo
{
    ubyte* m_Data;
    uint m_Length;
}

struct SimilarityData
{
    ubyte m_Data;
}

struct FindSimilarFileIndexResults
{
    uint m_FileIndex;
    uint m_MatchCount;
}

struct SimilarityDumpData
{
    uint m_FileIndex;
    SimilarityData m_Data;
}

struct SimilarityFileId
{
    ubyte m_FileId;
}

const GUID IID_IRdcGeneratorParameters = {0x96236A71, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A71, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface IRdcGeneratorParameters : IUnknown
{
    HRESULT GetGeneratorParametersType(GeneratorParametersType* parametersType);
    HRESULT GetParametersVersion(uint* currentVersion, uint* minimumCompatibleAppVersion);
    HRESULT GetSerializeSize(uint* size);
    HRESULT Serialize(uint size, ubyte* parametersBlob, uint* bytesWritten);
}

const GUID IID_IRdcGeneratorFilterMaxParameters = {0x96236A72, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A72, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface IRdcGeneratorFilterMaxParameters : IUnknown
{
    HRESULT GetHorizonSize(uint* horizonSize);
    HRESULT SetHorizonSize(uint horizonSize);
    HRESULT GetHashWindowSize(uint* hashWindowSize);
    HRESULT SetHashWindowSize(uint hashWindowSize);
}

const GUID IID_IRdcGenerator = {0x96236A73, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A73, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface IRdcGenerator : IUnknown
{
    HRESULT GetGeneratorParameters(uint level, IRdcGeneratorParameters* iGeneratorParameters);
    HRESULT Process(BOOL endOfInput, int* endOfOutput, RdcBufferPointer* inputBuffer, uint depth, RdcBufferPointer** outputBuffers, RDC_ErrorCode* rdc_ErrorCode);
}

const GUID IID_IRdcFileReader = {0x96236A74, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A74, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface IRdcFileReader : IUnknown
{
    HRESULT GetFileSize(ulong* fileSize);
    HRESULT Read(ulong offsetFileStart, uint bytesToRead, uint* bytesActuallyRead, ubyte* buffer, int* eof);
    HRESULT GetFilePosition(ulong* offsetFromStart);
}

const GUID IID_IRdcFileWriter = {0x96236A75, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A75, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface IRdcFileWriter : IRdcFileReader
{
    HRESULT Write(ulong offsetFileStart, uint bytesToWrite, ubyte* buffer);
    HRESULT Truncate();
    HRESULT DeleteOnClose();
}

const GUID IID_IRdcSignatureReader = {0x96236A76, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A76, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface IRdcSignatureReader : IUnknown
{
    HRESULT ReadHeader(RDC_ErrorCode* rdc_ErrorCode);
    HRESULT ReadSignatures(RdcSignaturePointer* rdcSignaturePointer, int* endOfOutput);
}

const GUID IID_IRdcComparator = {0x96236A77, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A77, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface IRdcComparator : IUnknown
{
    HRESULT Process(BOOL endOfInput, int* endOfOutput, RdcBufferPointer* inputBuffer, RdcNeedPointer* outputBuffer, RDC_ErrorCode* rdc_ErrorCode);
}

const GUID IID_IRdcLibrary = {0x96236A78, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A78, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface IRdcLibrary : IUnknown
{
    HRESULT ComputeDefaultRecursionDepth(ulong fileSize, uint* depth);
    HRESULT CreateGeneratorParameters(GeneratorParametersType parametersType, uint level, IRdcGeneratorParameters* iGeneratorParameters);
    HRESULT OpenGeneratorParameters(uint size, const(ubyte)* parametersBlob, IRdcGeneratorParameters* iGeneratorParameters);
    HRESULT CreateGenerator(uint depth, IRdcGeneratorParameters* iGeneratorParametersArray, IRdcGenerator* iGenerator);
    HRESULT CreateComparator(IRdcFileReader iSeedSignaturesFile, uint comparatorBufferSize, IRdcComparator* iComparator);
    HRESULT CreateSignatureReader(IRdcFileReader iFileReader, IRdcSignatureReader* iSignatureReader);
    HRESULT GetRDCVersion(uint* currentVersion, uint* minimumCompatibleAppVersion);
}

const GUID IID_ISimilarityReportProgress = {0x96236A7A, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A7A, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface ISimilarityReportProgress : IUnknown
{
    HRESULT ReportProgress(uint percentCompleted);
}

const GUID IID_ISimilarityTableDumpState = {0x96236A7B, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A7B, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface ISimilarityTableDumpState : IUnknown
{
    HRESULT GetNextData(uint resultsSize, uint* resultsUsed, int* eof, SimilarityDumpData* results);
}

const GUID IID_ISimilarityTraitsMappedView = {0x96236A7C, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A7C, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface ISimilarityTraitsMappedView : IUnknown
{
    HRESULT Flush();
    HRESULT Unmap();
    HRESULT Get(ulong index, BOOL dirty, uint numElements, SimilarityMappedViewInfo* viewInfo);
    void GetView(const(ubyte)** mappedPageBegin, const(ubyte)** mappedPageEnd);
}

const GUID IID_ISimilarityTraitsMapping = {0x96236A7D, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A7D, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface ISimilarityTraitsMapping : IUnknown
{
    void CloseMapping();
    HRESULT SetFileSize(ulong fileSize);
    HRESULT GetFileSize(ulong* fileSize);
    HRESULT OpenMapping(RdcMappingAccessMode accessMode, ulong begin, ulong end, ulong* actualEnd);
    HRESULT ResizeMapping(RdcMappingAccessMode accessMode, ulong begin, ulong end, ulong* actualEnd);
    void GetPageSize(uint* pageSize);
    HRESULT CreateView(uint minimumMappedPages, RdcMappingAccessMode accessMode, ISimilarityTraitsMappedView* mappedView);
}

const GUID IID_ISimilarityTraitsTable = {0x96236A7E, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A7E, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface ISimilarityTraitsTable : IUnknown
{
    HRESULT CreateTable(ushort* path, BOOL truncate, ubyte* securityDescriptor, RdcCreatedTables* isNew);
    HRESULT CreateTableIndirect(ISimilarityTraitsMapping mapping, BOOL truncate, RdcCreatedTables* isNew);
    HRESULT CloseTable(BOOL isValid);
    HRESULT Append(SimilarityData* data, uint fileIndex);
    HRESULT FindSimilarFileIndex(SimilarityData* similarityData, ushort numberOfMatchesRequired, FindSimilarFileIndexResults* findSimilarFileIndexResults, uint resultsSize, uint* resultsUsed);
    HRESULT BeginDump(ISimilarityTableDumpState* similarityTableDumpState);
    HRESULT GetLastIndex(uint* fileIndex);
}

const GUID IID_ISimilarityFileIdTable = {0x96236A7F, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A7F, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface ISimilarityFileIdTable : IUnknown
{
    HRESULT CreateTable(ushort* path, BOOL truncate, ubyte* securityDescriptor, uint recordSize, RdcCreatedTables* isNew);
    HRESULT CreateTableIndirect(IRdcFileWriter fileIdFile, BOOL truncate, uint recordSize, RdcCreatedTables* isNew);
    HRESULT CloseTable(BOOL isValid);
    HRESULT Append(SimilarityFileId* similarityFileId, uint* similarityFileIndex);
    HRESULT Lookup(uint similarityFileIndex, SimilarityFileId* similarityFileId);
    HRESULT Invalidate(uint similarityFileIndex);
    HRESULT GetRecordCount(uint* recordCount);
}

const GUID IID_IRdcSimilarityGenerator = {0x96236A80, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A80, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface IRdcSimilarityGenerator : IUnknown
{
    HRESULT EnableSimilarity();
    HRESULT Results(SimilarityData* similarityData);
}

const GUID IID_IFindSimilarResults = {0x96236A81, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A81, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface IFindSimilarResults : IUnknown
{
    HRESULT GetSize(uint* size);
    HRESULT GetNextFileId(uint* numTraitsMatched, SimilarityFileId* similarityFileId);
}

const GUID IID_ISimilarity = {0x96236A83, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]};
@GUID(0x96236A83, 0x9DBC, 0x11DA, [0x9E, 0x3F, 0x00, 0x11, 0x11, 0x4A, 0xE3, 0x11]);
interface ISimilarity : IUnknown
{
    HRESULT CreateTable(ushort* path, BOOL truncate, ubyte* securityDescriptor, uint recordSize, RdcCreatedTables* isNew);
    HRESULT CreateTableIndirect(ISimilarityTraitsMapping mapping, IRdcFileWriter fileIdFile, BOOL truncate, uint recordSize, RdcCreatedTables* isNew);
    HRESULT CloseTable(BOOL isValid);
    HRESULT Append(SimilarityFileId* similarityFileId, SimilarityData* similarityData);
    HRESULT FindSimilarFileId(SimilarityData* similarityData, ushort numberOfMatchesRequired, uint resultsSize, IFindSimilarResults* findSimilarResults);
    HRESULT CopyAndSwap(ISimilarity newSimilarityTables, ISimilarityReportProgress reportProgress);
    HRESULT GetRecordCount(uint* recordCount);
}

