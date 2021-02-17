// Written in the D programming language.

module windows.remotedifferentialcompression;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


///The <b>RDC_ErrorCode</b> enumeration type defines the set of RDC-specific error codes.
alias RDC_ErrorCode = int;
enum : int
{
    ///The operation was completed successfully.
    RDC_NoError                = 0x00000000,
    ///The data header is incompatible with this library.
    RDC_HeaderVersionNewer     = 0x00000001,
    ///The data header is incompatible with this library.
    RDC_HeaderVersionOlder     = 0x00000002,
    ///The data header is missing or corrupt.
    RDC_HeaderMissingOrCorrupt = 0x00000003,
    ///The data header format is incorrect.
    RDC_HeaderWrongType        = 0x00000004,
    ///The end of data was reached before all data expected was read.
    RDC_DataMissingOrCorrupt   = 0x00000005,
    ///Additional data was found past where the end of data was expected.
    RDC_DataTooManyRecords     = 0x00000006,
    ///The final file checksum doesn't match.
    RDC_FileChecksumMismatch   = 0x00000007,
    ///An application callback function returned failure.
    RDC_ApplicationError       = 0x00000008,
    ///The operation was aborted.
    RDC_Aborted                = 0x00000009,
    ///The failure of the function is not RDC-specific and the <b>HRESULT</b> returned by the function contains the
    ///specific error code.
    RDC_Win32Error             = 0x0000000a,
}

///The <b>GeneratorParametersType</b> enumeration type defines the set of supported generator parameters.
enum GeneratorParametersType : int
{
    ///The generator parameters type is unknown.
    RDCGENTYPE_Unused    = 0x00000000,
    ///The FilterMax generator was used to generate the parameters.
    RDCGENTYPE_FilterMax = 0x00000001,
}

///Defines the set of data chunks used to generate a remote copy.
enum RdcNeedType : int
{
    ///The chunk is a source chunk.
    RDCNEED_SOURCE   = 0x00000000,
    ///This value is reserved for future use.
    RDCNEED_TARGET   = 0x00000001,
    ///The chunk is a seed chunk.
    RDCNEED_SEED     = 0x00000002,
    ///This value is reserved for future use.
    RDCNEED_SEED_MAX = 0x000000ff,
}

///Defines values that describe the state of the similarity traits table, similarity file ID table, or both.
enum RdcCreatedTables : int
{
    ///The table contains data that is not valid.
    RDCTABLE_InvalidOrUnknown = 0x00000000,
    ///The table is an existing table.
    RDCTABLE_Existing         = 0x00000001,
    ///The table is a new table.
    RDCTABLE_New              = 0x00000002,
}

///Defines the access mode values for RDC file mapping objects.
enum RdcMappingAccessMode : int
{
    ///The mapping access mode is unknown.
    RDCMAPPING_Undefined = 0x00000000,
    ///Specifies read-only access.
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


///The <b>RdcNeed</b> structure contains information about a chunk that is required to synchronize two sets of data.
struct RdcNeed
{
    ///Describes the type of data needed—source data or seed data.
    RdcNeedType m_BlockType;
    ///Offset, in bytes, from the start of the data where the chunk should be copied from.
    ulong       m_FileOffset;
    ///Length, in bytes, of the chunk of data that is to be copied to the target data.
    ulong       m_BlockLength;
}

///The <b>RdcBufferPointer</b> structure describes a buffer.
struct RdcBufferPointer
{
    ///Size, in bytes, of the buffer.
    uint   m_Size;
    ///For input buffers, IRdcComparator::Process and IRdcGenerator::Process will store here how much (if any) of the
    ///buffer was used during processing.
    uint   m_Used;
    ///Pointer to the buffer.
    ubyte* m_Data;
}

///The <b>RdcNeedPointer</b> structure describes an array of RdcNeed structures. The <b>RdcNeedPointer</b> structure is
///used as both input and output by the IRdcComparator::Process method.
struct RdcNeedPointer
{
    ///Contains the number of RdcNeed structures in array pointed to by <b>m_Data</b>.
    uint     m_Size;
    ///When the structure is passed to the IRdcComparator::Process method, this member should be zero. On return this
    ///member will contain the number of RdcNeed structures that were filled with data.
    uint     m_Used;
    ///Address of array of RdcNeed structures that describe the chunks required from the source and seed data.
    RdcNeed* m_Data;
}

///The <b>RdcSignature</b> structure contains a single signature and the length of the chunk used to generate it.
struct RdcSignature
{
    ///Signature of a chunk of data.
    ubyte[16] m_Signature;
    ///Length of the chunk represented by this signature.
    ushort    m_BlockLength;
}

///The <b>RdcSignaturePointer</b> structure describes an array of RdcSignature structures. The
///<b>RdcSignaturePointer</b> structure is used as both input and output by the IRdcSignatureReader::ReadSignatures
///method.
struct RdcSignaturePointer
{
    ///Contains the number of RdcSignature structures in array pointed to by <b>m_Data</b>.
    uint          m_Size;
    ///When the structure is passed to the IRdcSignatureReader::ReadSignatures method, this member should be zero. On
    ///return this member will contain the number of RdcSignature structures that were filled.
    uint          m_Used;
    ///Address of an array of RdcSignature structures.
    RdcSignature* m_Data;
}

///Contains information about a similarity mapped view.
struct SimilarityMappedViewInfo
{
    ///The mapped view information.
    ubyte* m_Data;
    uint   m_Length;
}

///Contains the similarity data for a file.
struct SimilarityData
{
    ///The similarity data for the file.
    ubyte[16] m_Data;
}

///Contains the file index information that the ISimilarityTraitsTable::FindSimilarFileIndex method returned for a
///matching file.
struct FindSimilarFileIndexResults
{
    ///The index of the matching file in the similarity traits table.
    uint m_FileIndex;
    ///The number of traits that were matched. The valid range is from <b>MSRDC_MINIMUM_MATCHESREQUIRED</b> to
    ///<b>MSRDC_MAXIMUM_MATCHESREQUIRED</b>.
    uint m_MatchCount;
}

///Contains the similarity information that was returned for a file by the ISimilarityTableDumpState::GetNextData
///method.
struct SimilarityDumpData
{
    ///The index of the SimilarityData structure in the similarity traits table.
    uint           m_FileIndex;
    ///A SimilarityData structure that contains the similarity data for the file.
    SimilarityData m_Data;
}

///Contains the similarity file ID for a file.
struct SimilarityFileId
{
    ///The similarity file ID for the file.
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

///The <b>IRdcGeneratorParameters</b> interface is the generic interface for all types of generator parameters. All
///generator parameter objects must support this interface.
@GUID("96236A71-9DBC-11DA-9E3F-0011114AE311")
interface IRdcGeneratorParameters : IUnknown
{
    ///The <b>GetGeneratorParametersType</b> method returns the specific type of the parameters.
    ///Params:
    ///    parametersType = The address of a GeneratorParametersType that will receive the type of the parameters.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGeneratorParametersType(GeneratorParametersType* parametersType);
    ///The <b>GetParametersVersion</b> method returns information about the version of RDC used to serialize the
    ///parameters.
    ///Params:
    ///    currentVersion = Address of a <b>ULONG</b> that will receive the version of RDC used to serialize the parameters for this
    ///                     object. This corresponds to the <b>MSRDC_VERSION</b> constant.
    ///    minimumCompatibleAppVersion = Address of a <b>ULONG</b> that will receive the version of RDC that is compatible with the serialized
    ///                                  parameters. This corresponds to the <b>MSRDC_MINIMUM_COMPATIBLE_APP_VERSION</b> constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetParametersVersion(uint* currentVersion, uint* minimumCompatibleAppVersion);
    ///The <b>GetSerializeSize</b> method returns the size, in bytes, of the serialized parameter data.
    ///Params:
    ///    size = Address of a <b>ULONG</b> that on successful completion is filled with the size, in bytes, of the serialized
    ///           parameter data.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSerializeSize(uint* size);
    ///The <b>Serialize</b> method serializes the parameter data into a block of memory. This allows the parameters to
    ///be stored or transmitted.
    ///Params:
    ///    size = The size of the buffer pointed to by the <i>parametersBlob</i> parameter.
    ///    parametersBlob = The address of a buffer to receive the serialized parameter data.
    ///    bytesWritten = Address of a <b>ULONG</b> that on successful completion is filled with the size, in bytes, of the serialized
    ///                   parameter data written to the buffer pointed to by the <i>parametersBlob</i> parameter.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Serialize(uint size, ubyte* parametersBlob, uint* bytesWritten);
}

///The <b>IRdcGeneratorFilterMaxParameters</b> interface sets and retrieves parameters used by the FilterMax generator.
@GUID("96236A72-9DBC-11DA-9E3F-0011114AE311")
interface IRdcGeneratorFilterMaxParameters : IUnknown
{
    ///The <b>GetHorizonSize</b> method returns the horizon size—the length over which the FilterMax generator looks
    ///for local maxima. This determines the default smallest size for a chunk.
    ///Params:
    ///    horizonSize = Address of a <b>ULONG</b> that will receive the length in bytes of the horizon size. The valid range is from
    ///                  <b>MSRDC_MINIMUM_HORIZONSIZE</b> to <b>MSRDC_MAXIMUM_HORIZONSIZE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHorizonSize(uint* horizonSize);
    ///The <b>SetHorizonSize</b> method sets the horizon size—the length over which the FilterMax generator looks for
    ///local maxima. This determines the default smallest size for a chunk.
    ///Params:
    ///    horizonSize = Specifies the length in bytes of the horizon size. The valid range is from <b>MSRDC_MINIMUM_HORIZONSIZE</b>
    ///                  to <b>MSRDC_MAXIMUM_HORIZONSIZE</b>. If this parameter is not set then a suitable default will be used.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetHorizonSize(uint horizonSize);
    ///The <b>GetHashWindowSize</b> method returns the hash window size—the size of the sliding window used by the
    ///FilterMax generator for computing the hash used in the local maxima calculations.
    ///Params:
    ///    hashWindowSize = Address of a <b>ULONG</b> that will receive the length in bytes of the hash window size. The valid range is
    ///                     from <b>MSRDC_MINIMUM_HASHWINDOWSIZE</b> to <b>MSRDC_MAXIMUM_HASHWINDOWSIZE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHashWindowSize(uint* hashWindowSize);
    ///The <b>SetHashWindowSize</b> method sets the hash window size—the size of the sliding window used by the
    ///FilterMax generator for computing the hash used in the local maxima calculations.
    ///Params:
    ///    hashWindowSize = The length in bytes of the hash window size. The valid range is from <b>MSRDC_MINIMUM_HASHWINDOWSIZE</b> to
    ///                     <b>MSRDC_MAXIMUM_HASHWINDOWSIZE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetHashWindowSize(uint hashWindowSize);
}

///The <b>IRdcGenerator</b> interface is used to process the input data and read the parameters used by the generator.
@GUID("96236A73-9DBC-11DA-9E3F-0011114AE311")
interface IRdcGenerator : IUnknown
{
    ///The <b>GetGeneratorParameters</b> method returns a copy of the parameters used to create the generator. The
    ///generator parameters are fixed when the generator is created.
    ///Params:
    ///    level = The generator level for the parameters to be returned. The range is <b>MSRDC_MINIMUM_DEPTH</b> to
    ///            <b>MSRDC_MAXIMUM_DEPTH</b>.
    ///    iGeneratorParameters = Address of a pointer that on successful return will contain the IRdcGeneratorParameters interface pointer for
    ///                           the parameters for the generator level specified in the <i>level</i> parameter.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGeneratorParameters(uint level, IRdcGeneratorParameters* iGeneratorParameters);
    ///The <b>Process</b> method processes the input data and produces 0 or more output bytes. This method must be
    ///called repeatedly until the <b>BOOL</b> pointed to by <i>endOfOutput</i> is set to <b>TRUE</b>.
    ///Params:
    ///    endOfInput = Set to <b>TRUE</b> when the input buffer pointed to by the <i>inputBuffer</i> parameter contains the
    ///                 remaining input available.
    ///    endOfOutput = Address of a <b>BOOL</b> that is set to <b>TRUE</b> when the processing is complete for all data.
    ///    inputBuffer = Address of an RdcBufferPointer structure that contains the input buffer. On successful return, the
    ///                  <b>m_Used</b> member of this structure will be filled with the number of bytes by this call.
    ///    depth = The number of levels of signatures to generate. This must match the number of levels specified when the
    ///            generator was created.
    ///    outputBuffers = The address of an array of RdcBufferPointer structures that will receive the output buffers. The
    ///                    <b>m_Used</b> member of these structures will be filled with the number of bytes returned in the buffer.
    ///    rdc_ErrorCode = The address of an RDC_ErrorCode enumeration that is filled with an RDC specific error code if the return
    ///                    value from the <b>Process</b> method is <b>E_FAIL</b>. If this value is <b>RDC_Win32ErrorCode</b>, then the
    ///                    return value of the <b>Process</b> method contains the specific error code.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Process(BOOL endOfInput, int* endOfOutput, RdcBufferPointer* inputBuffer, uint depth, 
                    RdcBufferPointer** outputBuffers, RDC_ErrorCode* rdc_ErrorCode);
}

///The <b>IRdcFileReader</b> interface is used to provide the equivalent of a file handle, because the data being
///synchronized may not exist as a file on disk.
@GUID("96236A74-9DBC-11DA-9E3F-0011114AE311")
interface IRdcFileReader : IUnknown
{
    ///The <b>GetFileSize</b> method returns the size of a file.
    ///Params:
    ///    fileSize = Address of a <b>ULONGLONG</b> that on successful return will be filled with the size of the file, in bytes.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFileSize(ulong* fileSize);
    ///The <b>Read</b> method reads the specified amount of data starting at the specified position.
    ///Params:
    ///    offsetFileStart = Offset from the start of the data at which to start the read.
    ///    bytesToRead = Number of bytes to be read.
    ///    bytesActuallyRead = Address of a <b>ULONG</b> that will receive the number of bytes read.
    ///    buffer = Address of the buffer that receives the data read. This buffer must be at least <i>bytesToRead</i> bytes in
    ///             size.
    ///    eof = Address of a <b>BOOL</b> that is set to <b>TRUE</b> if the end of the file has been read.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Read(ulong offsetFileStart, uint bytesToRead, uint* bytesActuallyRead, ubyte* buffer, int* eof);
    ///The <b>GetFilePosition</b> method returns the current file position.
    ///Params:
    ///    offsetFromStart = Address of a <b>ULONGLONG</b> that will receive the current offset from the start of the data.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFilePosition(ulong* offsetFromStart);
}

///Abstract interface to read from and write to a file. The RDC application must implement this interface for use with
///ISimilarityFileIdTable::CreateTableIndirect. Note that this interface does not include methods to open, close, or
///flush the file to disk. The application is responsible for properly opening and closing the file represented by an
///instance of this interface.
@GUID("96236A75-9DBC-11DA-9E3F-0011114AE311")
interface IRdcFileWriter : IRdcFileReader
{
    ///Write bytes to a file starting at a given offset.
    ///Params:
    ///    offsetFileStart = Starting offset.
    ///    bytesToWrite = Number of bytes to be written to the file.
    ///    buffer = The data to be written to the file.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Write(ulong offsetFileStart, uint bytesToWrite, ubyte* buffer);
    ///Truncates a file to zero length.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Truncate();
    ///Sets a file to be deleted (or truncated) on close.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeleteOnClose();
}

///The <b>IRdcSignatureReader</b> interface reads the signatures and the parameters used to generate the signatures.
@GUID("96236A76-9DBC-11DA-9E3F-0011114AE311")
interface IRdcSignatureReader : IUnknown
{
    ///The <b>ReadHeader</b> method reads the signature header and returns a copy of the parameters used to generate the
    ///signatures.
    ///Params:
    ///    rdc_ErrorCode = Address of a RDC_ErrorCode enumeration that will receive any RDC-specific error code.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReadHeader(RDC_ErrorCode* rdc_ErrorCode);
    ///The <b>ReadSignatures</b> method reads a block of signatures from the current position.
    ///Params:
    ///    rdcSignaturePointer = Address of a RdcSignaturePointer structure. On input the <b>m_Size</b> member of this structure must contain
    ///                          the number of RdcSignature structures in the array pointed to by the <b>m_Data</b> member, and the
    ///                          <b>m_Used</b> member must be zero. On output the <b>m_Used</b> member will contain the number of
    ///                          <b>RdcSignature</b> structures in the array pointed to by the <b>m_Data</b> member.
    ///    endOfOutput = Address of a <b>BOOL</b> that is set to <b>TRUE</b> if the end of the signatures has been read.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReadSignatures(RdcSignaturePointer* rdcSignaturePointer, int* endOfOutput);
}

///The <b>IRdcComparator</b> interface is used to compare two signature streams (seed and source) and produce the list
///of source and seed file data chunks needed to create the target file.
@GUID("96236A77-9DBC-11DA-9E3F-0011114AE311")
interface IRdcComparator : IUnknown
{
    ///The <b>Process</b> method compares two signature streams (seed and source) and produces a needs list, which
    ///describes the chunks of file data needed to create the target file. The seed signature file may be read multiple
    ///times, depending on the size of the source signature file.
    ///Params:
    ///    endOfInput = Set to <b>TRUE</b> if the <i>inputBuffer</i> parameter contains all remaining input.
    ///    endOfOutput = Address of a <b>BOOL</b> that on successful completion is set to <b>TRUE</b> if all output data has been
    ///                  generated.
    ///    inputBuffer = Address of a RdcBufferPointer structure containing information about the input buffer. The <b>m_Used</b>
    ///                  member of this structure is used to indicate how much input, if any, was processed during this call.
    ///    outputBuffer = Address of a RdcNeedPointer structure containing information about the output buffer. On input the
    ///                   <b>m_Size</b> member of this structure must contain the number of RdcNeed structures in the array pointed to
    ///                   by the <b>m_Data</b> member, and the <b>m_Used</b> member must be zero. On output the <b>m_Used</b> member
    ///                   will contain the number of <b>RdcNeed</b> structures in the array pointed to by the <b>m_Data</b> member.
    ///    rdc_ErrorCode = The address of a RDC_ErrorCode enumeration that is filled with an RDC specific error code if the return value
    ///                    from the <b>Process</b> method is <b>E_FAIL</b>. If this value is <b>RDC_Win32ErrorCode</b>, then the return
    ///                    value of the <b>Process</b> method contains the specific error code.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Process(BOOL endOfInput, int* endOfOutput, RdcBufferPointer* inputBuffer, RdcNeedPointer* outputBuffer, 
                    RDC_ErrorCode* rdc_ErrorCode);
}

///The <b>IRdcLibrary</b> interface is the primary interface for using RDC.
@GUID("96236A78-9DBC-11DA-9E3F-0011114AE311")
interface IRdcLibrary : IUnknown
{
    ///The <b>ComputeDefaultRecursionDepth</b> method computes the maximum level of recursion for the specified file
    ///size. The depth returned by the method may be larger than <b>MSRDC_MAXIMUM_DEPTH</b>. The caller must compare the
    ///value returned through the <i>depth</i> parameter with <b>MSRDC_MAXIMUM_DEPTH</b>.
    ///Params:
    ///    fileSize = The approximate size of the file.
    ///    depth = Pointer to a <b>ULONG</b> that will receive the suggested maximum recursion depth.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ComputeDefaultRecursionDepth(ulong fileSize, uint* depth);
    ///The <b>CreateGeneratorParameters</b> method returns an IRdcGeneratorParameters interface pointer initialized with
    ///the parameters necessary for a signature generator.
    ///Params:
    ///    parametersType = Specifies the type of signature generator for the created parameters, enumerated by the
    ///                     GeneratorParametersType enumeration. The initial release of RDC only supports one type,
    ///                     <b>RDCGENTYPE_FilterMax</b>.
    ///    level = The recursion level for this parameter block. A parameter block is needed for each level of generated
    ///            signatures. The valid range is from <b>MSRDC_MINIMUM_DEPTH</b> to <b>MSRDC_MAXIMUM_DEPTH</b>.
    ///    iGeneratorParameters = Pointer to a location that will receive an IRdcGeneratorParameters interface pointer. On a successful return
    ///                           the interface will be initialized on return. Callers must release the interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateGeneratorParameters(GeneratorParametersType parametersType, uint level, 
                                      IRdcGeneratorParameters* iGeneratorParameters);
    ///The <b>OpenGeneratorParameters</b> method opens an existing serialized parameter block and returns an
    ///IRdcGeneratorParameters interface pointer initialized with the data.
    ///Params:
    ///    size = The size, in bytes, of the serialized parameter block.
    ///    parametersBlob = Pointer to a serialized parameter block.
    ///    iGeneratorParameters = Pointer to a location that will receive the returned IRdcGeneratorParameters interface pointer. Callers must
    ///                           release the interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OpenGeneratorParameters(uint size, const(ubyte)* parametersBlob, 
                                    IRdcGeneratorParameters* iGeneratorParameters);
    ///The <b>CreateGenerator</b> method creates a signature generator that will generate the specified levels of
    ///signatures.
    ///Params:
    ///    depth = The number of levels of signatures to generate. The valid range is from <b>MSRDC_MINIMUM_DEPTH</b> to
    ///            <b>MSRDC_MAXIMUM_DEPTH</b>.
    ///    iGeneratorParametersArray = Pointer to an array of initialized IRdcGeneratorParameters interface pointers. Each
    ///                                <b>IRdcGeneratorParameters</b> interface pointer would have been initialized by
    ///                                IRdcLibrary::CreateGeneratorParameters or IRdcGenerator::GetGeneratorParameters.
    ///    iGenerator = Pointer to a location that will receive the returned IRdcGenerator interface pointer. Callers must release
    ///                 the interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateGenerator(uint depth, IRdcGeneratorParameters* iGeneratorParametersArray, 
                            IRdcGenerator* iGenerator);
    ///The <b>CreateComparator</b> method creates a signature comparator.
    ///Params:
    ///    iSeedSignaturesFile = An IRdcFileReader interface pointer initialized to read the seed signatures.
    ///    comparatorBufferSize = Specifies the size of the comparator buffer. The range is from <b>MSRDC_MINIMUM_COMPAREBUFFER</b> to
    ///                           <b>MSRDC_MAXIMUM_COMPAREBUFFER</b>.
    ///    iComparator = Pointer to a location that will receive an IRdcComparator interface pointer. On a successful return the
    ///                  interface will be initialized on return. Callers must release the interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateComparator(IRdcFileReader iSeedSignaturesFile, uint comparatorBufferSize, 
                             IRdcComparator* iComparator);
    ///The <b>CreateSignatureReader</b> method creates a signature reader to allow an application to decode the contents
    ///of a signature file.
    ///Params:
    ///    iFileReader = An IRdcFileReader interface pointer initialized to read the signatures.
    ///    iSignatureReader = Pointer to a location that will receive an IRdcSignatureReader interface pointer. On a successful return the
    ///                       interface will be initialized on return. Callers must release the interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateSignatureReader(IRdcFileReader iFileReader, IRdcSignatureReader* iSignatureReader);
    ///The <b>GetRDCVersion</b> method retrieves the version of the installed RDC runtime and the oldest version of the
    ///RDC interfaces supported by the installed runtime.
    ///Params:
    ///    currentVersion = Address of a <b>ULONG</b> that will receive the installed version of RDC. This corresponds to the
    ///                     <b>MSRDC_VERSION</b> value.
    ///    minimumCompatibleAppVersion = Address of a <b>ULONG</b> that will receive the oldest version of RDC supported by the installed version of
    ///                                  RDC. This corresponds to the <b>MSRDC_MINIMUM_COMPATIBLE_APP_VERSION</b> value.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRDCVersion(uint* currentVersion, uint* minimumCompatibleAppVersion);
}

///Defines a method for RDC to report the current completion percentage of a similarity operation.
@GUID("96236A7A-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityReportProgress : IUnknown
{
    ///Reports the current completion percentage of a similarity operation in progress.
    ///Params:
    ///    percentCompleted = The current completion percentage of the task. The valid range is from 0 through 100.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReportProgress(uint percentCompleted);
}

///Provides a method for retrieving information from the similarity traits list that was returned by the
///ISimilarityTraitsTable::BeginDump method.
@GUID("96236A7B-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityTableDumpState : IUnknown
{
    ///Retrieves one or more SimilarityDumpData structures from the similarity traits list that was returned by the
    ///ISimilarityTraitsTable::BeginDump method.
    ///Params:
    ///    resultsSize = The number of SimilarityDumpData structures that can be stored in the buffer that the <i>results</i>
    ///                  parameter points to.
    ///    resultsUsed = A pointer to a variable that receives the number of SimilarityDumpData structures that were returned in the
    ///                  buffer that the <i>results</i> parameter points to.
    ///    eof = A pointer to a variable that receives <b>TRUE</b> if the end of the file is reached; otherwise, <b>FALSE</b>.
    ///    results = A pointer to a buffer that receives the SimilarityDumpData structures.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetNextData(uint resultsSize, uint* resultsUsed, int* eof, SimilarityDumpData* results);
}

///Provides methods that an RDC application can implement for manipulating a mapped view of a similarity traits table
///file. This interface is used together with the ISimilarityTraitsMapping interface to allow the application to provide
///the I/O services needed by the ISimilarityTraitsTable and ISimilarity interfaces. The implementation model is based
///on memory mapped files, but the interface is rich enough to support other models as well, such as memory-only arrays
///or traditional file accesses. A mapped view is used to map an area of the entire file into a contiguous block of
///memory. This mapping is valid until the view is changed or unmapped. A possible implementation would call the
///ReadFile function when the view is mapped (see the Get method), and would then write the changes back to disk when
///the view is changed (see <b>Get</b>) or released (see the Unmap method). There can be multiple overlapping read-only
///mapped views of the same area of a file, and one or more read-only views can overlap a read/write view, but there can
///be only one read/write view of a given area of a file.
@GUID("96236A7C-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityTraitsMappedView : IUnknown
{
    ///Writes to the disk any dirty pages within a mapped view of a similarity traits table file.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Flush();
    ///Unmaps a mapped view of a similarity traits table file. The view, if any, is not dirty or does not otherwise need
    ///to be flushed to disk.
    ///Returns:
    ///    This method always returns <b>S_OK</b>.
    ///    
    HRESULT Unmap();
    ///Returns information about the mapped view of a similarity traits table file.
    ///Params:
    ///    index = Beginning file offset, in bytes, of the underlying file data to be mapped in the mapped view.
    ///    dirty = If <b>TRUE</b> is specified, the data in the currently mapped view has been changed; otherwise, the data has
    ///            not changed. This parameter can be used to determine if data may need to be written to disk.
    ///    numElements = Minimum number of bytes of data to be mapped in the mapped view.
    ///    viewInfo = Pointer to a location that receives a SimilarityMappedViewInfo structure containing information about the
    ///               mapped view.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Get(ulong index, BOOL dirty, uint numElements, SimilarityMappedViewInfo* viewInfo);
    ///Returns the beginning and ending addresses for the mapped view of a similarity traits table file.
    ///Params:
    ///    mappedPageBegin = Pointer to a location that receives the start of the data that is mapped for this view.
    ///    mappedPageEnd = Pointer to a location that receives the end of the data that is mapped for this view, plus one.
    void    GetView(const(ubyte)** mappedPageBegin, const(ubyte)** mappedPageEnd);
}

///Provides methods that an RDC application can implement for creating and manipulating a file mapping object for a
///similarity traits table file. This interface is used together with the ISimilarityTraitsMappedView interface to allow
///the application to provide the I/O services needed by the ISimilarityTraitsTable and ISimilarity interfaces. The
///implementation model is based on memory mapped files, but the interface is rich enough to support other models as
///well, such as memory-only arrays or traditional file accesses. This interface is used to represent the file on which
///multiple read-only or read/write views can be created. There can be multiple overlapping read-only mapped views of
///the same area of a file, and one or more read-only views can overlap a read/write view, but there can be only one
///read/write view of a given area of a file.
@GUID("96236A7D-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityTraitsMapping : IUnknown
{
    ///Closes a file mapping object for a similarity traits table file.
    void    CloseMapping();
    ///Sets the size of a similarity traits table file.
    ///Params:
    ///    fileSize = Pointer to a location that specifies the file size, in bytes.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFileSize(ulong fileSize);
    ///Returns the size of a similarity traits table file.
    ///Params:
    ///    fileSize = Pointer to a location that receives the file size, in bytes.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFileSize(ulong* fileSize);
    ///Opens the file mapping object for a similarity traits table file.
    ///Params:
    ///    accessMode = RdcMappingAccessMode enumeration value that specifies the desired access to the file mapping object.
    ///    begin = File offset, in bytes, where the file mapping is to begin.
    ///    end = File offset, in bytes, where the file mapping is to end.
    ///    actualEnd = Pointer to a location that receives the file offset, in bytes, of the actual end of the file mapping, rounded
    ///                up to the nearest block size.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OpenMapping(RdcMappingAccessMode accessMode, ulong begin, ulong end, ulong* actualEnd);
    ///Resizes the file mapping object for a similarity traits table file.
    ///Params:
    ///    accessMode = RdcMappingAccessMode enumeration value that specifies the desired access to the file mapping object.
    ///    begin = File offset, in bytes, where the file mapping is to begin.
    ///    end = File offset, in bytes, where the file mapping is to end.
    ///    actualEnd = Pointer to a location that receives the file offset, in bytes, of the actual end of the file mapping, rounded
    ///                up to the nearest block size.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ResizeMapping(RdcMappingAccessMode accessMode, ulong begin, ulong end, ulong* actualEnd);
    ///Returns the page size (disk block size) for a similarity traits table file.
    ///Params:
    ///    pageSize = Pointer to a location that receives the page size, in bytes. This page size must be at least 65536 bytes.
    void    GetPageSize(uint* pageSize);
    ///Maps a view of the file mapping for a similarity traits table file.
    ///Params:
    ///    minimumMappedPages = Minimum number of pages of the file mapping to map to the view.
    ///    accessMode = RdcMappingAccessMode enumeration value that specifies the desired access to the file mapping object.
    ///    mappedView = Pointer to a location that will receive the returned ISimilarityTraitsMappedView interface pointer. Callers
    ///                 must release the interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateView(uint minimumMappedPages, RdcMappingAccessMode accessMode, 
                       ISimilarityTraitsMappedView* mappedView);
}

///Defines methods for storing per-file similarity data and performing similarity lookups.
@GUID("96236A7E-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityTraitsTable : IUnknown
{
    ///Creates or opens a similarity traits table.
    ///Params:
    ///    path = A pointer to a null-terminated string that specifies the name of the file that will contain the similarity
    ///           traits table. The alternate stream name ":Traits" will be appended to the end of this file name. For more
    ///           information, see Naming a File.
    ///    truncate = <b>TRUE</b> if a new similarity traits table should always be created or truncated. If <b>FALSE</b> is
    ///               specified and the table exists and is valid, it may be used; otherwise, if the table is not valid or does not
    ///               exist, the existing table is overwritten.
    ///    securityDescriptor = A pointer to a security descriptor to use when opening the file. If this parameter is <b>NULL</b>, the file
    ///                         is assigned a default security descriptor. The access control lists (ACL) in the file's default security
    ///                         descriptor are inherited from the file's parent directory. For more information, see the
    ///                         <i>lpSecurityAttributes</i> parameter of the CreateFile function.
    ///    isNew = A pointer to a variable that receives an RdcCreatedTables enumeration value that describes the state of the
    ///            similarity traits table. If a new table is created, this variable receives <b>RDCTABLE_New</b>. If an
    ///            existing table is used, this variable receives <b>RDCTABLE_Existing</b>. If this method fails, this variable
    ///            receives <b>RDCTABLE_InvalidOrUnknown</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTable(ushort* path, BOOL truncate, ubyte* securityDescriptor, RdcCreatedTables* isNew);
    ///Creates or opens a similarity traits table using the RDC application's implementation of the
    ///ISimilarityTraitsMapping interface.
    ///Params:
    ///    mapping = An ISimilarityTraitsMapping interface pointer initialized to write the similarity traits table to the file.
    ///    truncate = <b>TRUE</b> if a new similarity traits table should always be created or truncated. If <b>FALSE</b> is
    ///               specified and the table exists and is valid, it may be used; otherwise, if the table is not valid or does not
    ///               exist, the existing table is overwritten.
    ///    isNew = A pointer to a variable that receives an RdcCreatedTables enumeration value that describes the state of the
    ///            similarity traits table. If a new table is created, this variable receives <b>RDCTABLE_New</b>. If an
    ///            existing table is used, this variable receives <b>RDCTABLE_Existing</b>. If this method fails, this variable
    ///            receives <b>RDCTABLE_InvalidOrUnknown</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTableIndirect(ISimilarityTraitsMapping mapping, BOOL truncate, RdcCreatedTables* isNew);
    ///Closes a similarity traits table.
    ///Params:
    ///    isValid = <b>FALSE</b> if the similarity traits table should be deleted when it is closed; otherwise, <b>TRUE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CloseTable(BOOL isValid);
    ///Adds a SimilarityData structure to the similarity traits table.
    ///Params:
    ///    data = The SimilarityData structure to be added to the similarity traits table.
    ///    fileIndex = The index in the similarity traits table where the SimilarityData structure is to be inserted.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Append(SimilarityData* data, uint fileIndex);
    ///Returns a list of files that are similar to a given file. The results in the list are sorted in order of
    ///similarity, beginning with the most similar file.
    ///Params:
    ///    similarityData = A pointer to a SimilarityData structure that contains similarity information for the file.
    ///    numberOfMatchesRequired = TBD
    ///    findSimilarFileIndexResults = A pointer to a buffer that receives an array of FindSimilarFileIndexResults structures that contain the
    ///                                  requested information.
    ///    resultsSize = The number of FindSimilarFileIndexResults structures that can be stored in the buffer that the
    ///                  <i>findSimilarFileIndexResults</i> parameter points to.
    ///    resultsUsed = The number of FindSimilarFileIndexResults structures that were returned in the buffer that the
    ///                  <i>findSimilarFileIndexResults</i> parameter points to.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindSimilarFileIndex(SimilarityData* similarityData, ushort numberOfMatchesRequired, 
                                 FindSimilarFileIndexResults* findSimilarFileIndexResults, uint resultsSize, 
                                 uint* resultsUsed);
    ///Retrieves similarity data from the similarity traits table.
    ///Params:
    ///    similarityTableDumpState = An optional pointer to a location that will receive the returned ISimilarityTableDumpState interface pointer.
    ///                               The caller must release this interface when it is no longer needed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginDump(ISimilarityTableDumpState* similarityTableDumpState);
    ///Retrieves the index of the last entry that was stored in the similarity traits table.
    ///Params:
    ///    fileIndex = A pointer to a variable that receives the index of the last entry.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLastIndex(uint* fileIndex);
}

///Defines methods for storing and retrieving similarity file ID information.
@GUID("96236A7F-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarityFileIdTable : IUnknown
{
    ///Creates or opens a similarity file ID table.
    ///Params:
    ///    path = A pointer to a null-terminated string that specifies the name of the file that will contain the similarity
    ///           file ID table. The alternate stream name ":FileId" will be appended to the end of this file name. For more
    ///           information, see Naming a File.
    ///    truncate = <b>TRUE</b> if a new similarity file ID table should always be created or truncated. If <b>FALSE</b> is
    ///               specified and the table exists and is valid, it may be used; otherwise, if the table is not valid or does not
    ///               exist, the existing table is overwritten.
    ///    securityDescriptor = A pointer to a security descriptor to use when opening the file. If this parameter is <b>NULL</b>, the file
    ///                         is assigned a default security descriptor. The access control lists (ACL) in the file's default security
    ///                         descriptor are inherited from the file's parent directory. For more information, see the
    ///                         <i>lpSecurityAttributes</i> parameter of the CreateFile function.
    ///    recordSize = The size, in bytes, of the file IDs that will be stored in the similarity file ID table. All file IDs must be
    ///                 the same size. The valid range is from <b>SimilarityFileIdMinSize</b> to <b>SimilarityFileIdMaxSize</b>. If
    ///                 an existing similarity file ID table is being opened, the value of this parameter must match the file ID size
    ///                 of the existing table. Otherwise, the existing table is assumed to be not valid and will be overwritten.
    ///    isNew = A pointer to a variable that receives an RdcCreatedTables enumeration value that describes the state of the
    ///            similarity file ID table. If a new table is created, this variable receives <b>RDCTABLE_New</b>. If an
    ///            existing table is used, this variable receives <b>RDCTABLE_Existing</b>. If this method fails, this variable
    ///            receives <b>RDCTABLE_InvalidOrUnknown</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTable(ushort* path, BOOL truncate, ubyte* securityDescriptor, uint recordSize, 
                        RdcCreatedTables* isNew);
    ///Creates or opens a similarity file ID table using the RDC application's implementation of the IRdcFileWriter
    ///interface.
    ///Params:
    ///    fileIdFile = An IRdcFileWriter interface pointer initialized to write the file ID table to the file.
    ///    truncate = <b>TRUE</b> if a new similarity file ID table should always be created or truncated. If <b>FALSE</b> is
    ///               specified and the table exists and is valid, it may be used; otherwise, if the table is not valid or does not
    ///               exist, the existing table is overwritten.
    ///    recordSize = The size, in bytes, of the file IDs that will be stored in the similarity file ID table. All file IDs must be
    ///                 the same size. The valid range is from <b>SimilarityFileIdMinSize</b> to <b>SimilarityFileIdMaxSize</b>. If
    ///                 an existing similarity file ID table is being opened, the value of this parameter must match the file ID size
    ///                 of the existing table. Otherwise, the existing table is assumed to be not valid and will be overwritten.
    ///    isNew = A pointer to a variable that receives an RdcCreatedTables enumeration value that describes the state of the
    ///            similarity file ID table. If a new table is created, this variable receives <b>RDCTABLE_New</b>. If an
    ///            existing table is used, this variable receives <b>RDCTABLE_Existing</b>. If this method fails, this variable
    ///            receives <b>RDCTABLE_InvalidOrUnknown</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTableIndirect(IRdcFileWriter fileIdFile, BOOL truncate, uint recordSize, RdcCreatedTables* isNew);
    ///Closes a similarity file ID table.
    ///Params:
    ///    isValid = <b>FALSE</b> if the similarity file ID table should be deleted when it is closed; otherwise, <b>TRUE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CloseTable(BOOL isValid);
    ///Adds the file ID to the similarity file ID table.
    ///Params:
    ///    similarityFileId = The file ID to be added to the similarity file ID table.
    ///    similarityFileIndex = A pointer to a variable that receives the file index for the file ID's entry in the similarity file ID table.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, or an error <b>HRESULT</b> on failure. This method can also return the
    ///    following error codes.
    ///    
    HRESULT Append(SimilarityFileId* similarityFileId, uint* similarityFileIndex);
    ///Retrieves the file ID that corresponds to a given file index in the similarity file ID table.
    ///Params:
    ///    similarityFileIndex = The file index that was previously returned for the file ID by the ISimilarityFileIdTable::Append method.
    ///    similarityFileId = A pointer to a variable that receives the file ID. If the file has been marked as not valid, the file ID
    ///                       receives zero.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, or an error <b>HRESULT</b> on failure. This method can also return the
    ///    following error code.
    ///    
    HRESULT Lookup(uint similarityFileIndex, SimilarityFileId* similarityFileId);
    ///Marks a file ID as not valid in the similarity file ID table. This method should be called for files that have
    ///been deleted or are otherwise no longer available.
    ///Params:
    ///    similarityFileIndex = The index of the file ID's entry in the similarity file ID table.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Invalidate(uint similarityFileIndex);
    ///Retrieves the number of records that are stored in a similarity file ID table.
    ///Params:
    ///    recordCount = A pointer to a variable that receives the number of records.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, or an error <b>HRESULT</b> on failure. This method can also return the
    ///    following error code.
    ///    
    HRESULT GetRecordCount(uint* recordCount);
}

///Defines methods for enabling the signature generator to generate similarity data and for retrieving the similarity
///data after it is generated.
@GUID("96236A80-9DBC-11DA-9E3F-0011114AE311")
interface IRdcSimilarityGenerator : IUnknown
{
    ///Enables the signature generator to generate similarity data. The <b>EnableSimilarity</b> method must be called
    ///before the IRdcGenerator::Process method is called to begin generating signatures. Otherwise, this method will
    ///return an error.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnableSimilarity();
    ///Retrieves the similarity data that was generated for a file by the signature generator. This method cannot be
    ///called until signature generation is completed. For more information, see the <i>endOfOutput</i> parameter of the
    ///IRdcGenerator::Process method.
    ///Params:
    ///    similarityData = A pointer to a SimilarityData structure that will receive the similarity data.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Results(SimilarityData* similarityData);
}

///Provides methods for retrieving information from the file list returned by the ISimilarity::FindSimilarFileId method.
@GUID("96236A81-9DBC-11DA-9E3F-0011114AE311")
interface IFindSimilarResults : IUnknown
{
    ///Retrieves the number of entries in the file list that was returned by the ISimilarity::FindSimilarFileId method.
    ///The actual number of similarity file IDs that are returned by the GetNextFileId method may be less than the
    ///number that is returned by the <b>GetSize</b> method. <b>GetNextFileId</b> returns only valid similarity file
    ///IDs. However, <b>GetSize</b> counts all entries, even if their similarity file IDs are not valid.
    ///Params:
    ///    size = A pointer to a variable that receives the number of entries in the file list.
    ///Returns:
    ///    This method always returns <b>S_OK</b>.
    ///    
    HRESULT GetSize(uint* size);
    ///Retrieves the next valid similarity file ID in the file list that was returned by the
    ///ISimilarity::FindSimilarFileId method.
    ///Params:
    ///    numTraitsMatched = A pointer to a variable that receives the number of traits that were matched.
    ///    similarityFileId = A pointer to a SimilarityFileId structure that contains the similarity file ID of the matching file.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, or an error <b>HRESULT</b> on failure. This method can also return the
    ///    following error code.
    ///    
    HRESULT GetNextFileId(uint* numTraitsMatched, SimilarityFileId* similarityFileId);
}

///Defines methods for storing and retrieving per-file similarity data and file IDs in a similarity file.
@GUID("96236A83-9DBC-11DA-9E3F-0011114AE311")
interface ISimilarity : IUnknown
{
    ///Creates or opens a similarity traits table and a similarity file ID table.
    ///Params:
    ///    path = A pointer to a null-terminated string that specifies the name of the file that will contain the tables. The
    ///           similarity traits table and the similarity file ID table will be created in two alternate file streams of
    ///           this file. For more information, see the <i>path</i> parameter of the ISimilarityFileIdTable::CreateTable and
    ///           ISimilarityTraitsTable::CreateTable methods.
    ///    truncate = <b>TRUE</b> if a new similarity traits table and a new similarity file ID table should always be created or
    ///               truncated. If <b>FALSE</b> is specified and these tables exist and are valid, they may be used; otherwise, if
    ///               one of the tables is not valid or does not exist, any existing tables are overwritten.
    ///    securityDescriptor = A pointer to a security descriptor to use when opening the file. If this parameter is <b>NULL</b>, the file
    ///                         is assigned a default security descriptor. The access control lists (ACL) in the file's default security
    ///                         descriptor are inherited from the file's parent directory. For more information, see the
    ///                         <i>lpSecurityAttributes</i> parameter of the CreateFile function.
    ///    recordSize = The size, in bytes, of each file ID to be stored in the similarity file id table. All similarity file IDs
    ///                 must be the same size. The valid range is from <b>SimilarityFileIdMinSize</b> to
    ///                 <b>SimilarityFileIdMaxSize</b>. If existing tables are being opened, the value of this parameter must match
    ///                 the file ID size of the existing similarity file ID table. Otherwise, the existing tables are assumed to be
    ///                 not valid and will be overwritten.
    ///    isNew = A pointer to a variable that receives an RdcCreatedTables enumeration value that describes the state of the
    ///            tables. If new tables are created, this variable receives <b>RDCTABLE_New</b>. If existing tables are used,
    ///            this variable receives <b>RDCTABLE_Existing</b>. If this method fails, this variable receives
    ///            <b>RDCTABLE_InvalidOrUnknown</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTable(ushort* path, BOOL truncate, ubyte* securityDescriptor, uint recordSize, 
                        RdcCreatedTables* isNew);
    ///Creates or opens a similarity traits table and a similarity file ID table using the RDC application's
    ///implementations of the ISimilarityTraitsMapping and IRdcFileWriter interfaces.
    ///Params:
    ///    mapping = An ISimilarityTraitsMapping interface pointer initialized to write the similarity traits table to the file.
    ///    fileIdFile = An IRdcFileWriter interface pointer initialized to write the file ID table to the file.
    ///    truncate = <b>TRUE</b> if a new similarity traits table and a new similarity file ID table should always be created or
    ///               truncated. If <b>FALSE</b> is specified and these tables exist and are valid, they may be used; otherwise, if
    ///               one of the tables is not valid or does not exist, any existing tables are overwritten.
    ///    recordSize = The size, in bytes, of each file ID to be stored in the similarity file ID table. All similarity file IDs
    ///                 must be the same size. The valid range is from <b>SimilarityFileIdMinSize</b> to
    ///                 <b>SimilarityFileIdMaxSize</b>. If existing tables are being opened, the value of this parameter must match
    ///                 the file ID size of the existing similarity file ID table. Otherwise, the existing tables are assumed to be
    ///                 not valid and will be overwritten.
    ///    isNew = A pointer to a variable that receives an RdcCreatedTables enumeration value that describes the state of the
    ///            tables. If new tables are created, this variable receives <b>RDCTABLE_New</b>. If existing tables are used,
    ///            this variable receives <b>RDCTABLE_Existing</b>. If this method fails, this variable receives
    ///            <b>RDCTABLE_InvalidOrUnknown</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTableIndirect(ISimilarityTraitsMapping mapping, IRdcFileWriter fileIdFile, BOOL truncate, 
                                uint recordSize, RdcCreatedTables* isNew);
    ///Closes the tables in a similarity file.
    ///Params:
    ///    isValid = <b>FALSE</b> if the similarity traits table and similarity file ID table should be deleted when they are
    ///              closed; otherwise, <b>TRUE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CloseTable(BOOL isValid);
    ///Adds the file ID and similarity data information to the tables in the similarity file.
    ///Params:
    ///    similarityFileId = A pointer to the SimilarityFileId structure to be added to the similarity file ID table.
    ///    similarityData = A pointer to the SimilarityData structure to be added to the similarity traits table.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, or an error <b>HRESULT</b> on failure. This method can also return the
    ///    following error codes.
    ///    
    HRESULT Append(SimilarityFileId* similarityFileId, SimilarityData* similarityData);
    ///Returns a list of files that are similar to a given file.
    ///Params:
    ///    similarityData = A pointer to a SimilarityData structure that contains similarity information for the file.
    ///    numberOfMatchesRequired = TBD
    ///    resultsSize = The number of file IDs that can be stored in the IFindSimilarResults object that the
    ///                  <i>findSimilarResults</i> parameter points to.
    ///    findSimilarResults = A pointer to a location that will receive the returned IFindSimilarResults interface pointer. The caller must
    ///                         release this interface when it is no longer needed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindSimilarFileId(SimilarityData* similarityData, ushort numberOfMatchesRequired, uint resultsSize, 
                              IFindSimilarResults* findSimilarResults);
    ///Creates copies of an existing similarity traits table and an existing similarity file ID table, swaps the
    ///internal pointers, and deletes the existing tables. After the <b>CopyAndSwap</b> method returns, the application
    ///continues to use the same ISimilarity object that it used before calling this method. However, the
    ///<b>ISimilarity</b> object is now associated with a different similarity file on disk.
    ///Params:
    ///    newSimilarityTables = An optional pointer to a temporary ISimilarity object that is used to create temporary copies of the tables.
    ///                          Before calling the <b>CopyAndSwap</b> method, the caller must call the CreateTable method to create the
    ///                          temporary tables. On return, the caller must call the CloseTable method to close the temporary tables.
    ///    reportProgress = An optional pointer to an ISimilarityReportProgress object that will receive information on the progress of
    ///                     the copy-and-swap operation and allow the application to stop the copy operation. The caller must release
    ///                     this interface when it is no longer needed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CopyAndSwap(ISimilarity newSimilarityTables, ISimilarityReportProgress reportProgress);
    ///Retrieves the number of records that are stored in the similarity file ID table in a similarity file.
    ///Params:
    ///    recordCount = A pointer to a variable that receives the number of records.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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
