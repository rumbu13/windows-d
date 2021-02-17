// Written in the D programming language.

module windows.datadeduplication;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


///Indicates whether Data Deduplication should perform an unoptimized or optimized restore.
alias DEDUP_BACKUP_SUPPORT_PARAM_TYPE = int;
enum : int
{
    ///Perform an unoptimized restore.
    DEDUP_RECONSTRUCT_UNOPTIMIZED = 0x00000001,
    ///Reserved for future use. Do not use.
    DEDUP_RECONSTRUCT_OPTIMIZED   = 0x00000002,
}

// Structs


///A logical container file may be stored in a single segment or multiple segments in the backup store.
///<b>DEDUP_CONTAINER_EXTENT</b> represents a single extent of a specific container file as stored in the backup store.
///The extent may be the full container file or a portion of the file.
struct DEDUP_CONTAINER_EXTENT
{
    ///The index in the container list passed to IDedupReadFileCallback::OrderContainersRestore to which this container
    ///extent structure corresponds.
    uint ContainerIndex;
    ///Offset, in bytes, from the beginning of the container to the beginning of the extent.
    long StartOffset;
    ///Length, in bytes, of the extent.
    long Length;
}

///<b>DDP_FILE_EXTENT</b> represents the extent of data in a file that is to be read in a pending call to
///ReadBackupFile.
struct DDP_FILE_EXTENT
{
    ///Length, in bytes, of the extent.
    long Length;
    ///Offset, in bytes, from the beginning of the file to the beginning of the extent.
    long Offset;
}

// Interfaces

@GUID("73D6B2AD-2984-4715-B2E3-924C149744DD")
struct DedupBackupSupport;

///A callback interface, implemented by backup applications, that enables Data Deduplication to read content from
///metadata and container files residing in a backup store and optionally improve restore efficiency.
@GUID("7BACC67A-2F1D-42D0-897E-6FF62DD533BB")
interface IDedupReadFileCallback : IUnknown
{
    ///Reads data from a Data Deduplication store metadata or container file located in the backup store.
    ///Params:
    ///    FileFullPath = The full path from the root directory of the volume to the container file.
    ///    FileOffset = The offset, in bytes, from the beginning of the file to the beginning of the data to be read.
    ///    SizeToRead = The number of bytes to read from the file.
    ///    FileBuffer = A pointer to a buffer that receives the data that is read from the file. The size of the buffer must be
    ///                 greater than or equal to the number specified in the <i>SizeToRead</i> parameter.
    ///    ReturnedSize = Pointer to a ULONG variable that receives the number of bytes that were read from the backup store. If the
    ///                   call to <b>ReadBackupFile</b> is successful, this number is equal to the value that was specified in the
    ///                   <i>SizeToRead</i> parameter.
    ///    Flags = This parameter is reserved for future use.
    ///Returns:
    ///    This method can return standard <b>HRESULT</b> values, such as <b>S_OK</b>. It can also return converted
    ///    system error codes using the HRESULT_FROM_WIN32 macro. Possible return values include the following.
    ///    
    HRESULT ReadBackupFile(BSTR FileFullPath, long FileOffset, uint SizeToRead, char* FileBuffer, 
                           uint* ReturnedSize, uint Flags);
    ///This method provides the application with the ability to influence the order of the pending reads that are
    ///required to retrieve the target file. Given a list of container files that hold data for the restore target file,
    ///generates a list of container file extents in a sorted order that results in an efficient cross-container read
    ///plan from the backup store. Implementation of this method by the application is optional.
    ///Params:
    ///    NumberOfContainers = Number of container paths in the <i>ContainerPaths</i> array.
    ///    ContainerPaths = Array of paths to container files that must be read in order to restore the file specified in the
    ///                     IDedupBackupSupport::RestoreFiles call. Each element is a full path from the root directory of the volume to
    ///                     a container file.
    ///    ReadPlanEntries = Pointer to a ULONG variable that receives the number of DEDUP_CONTAINER_EXTENT structures in the array that
    ///                      the <i>ReadPlan</i> parameter points to.
    ///    ReadPlan = Pointer to a buffer that receives an array of DEDUP_CONTAINER_EXTENT structures.
    ///Returns:
    ///    This method can return standard <b>HRESULT</b> values, such as <b>S_OK</b>. It can also return converted
    ///    system error codes using the HRESULT_FROM_WIN32 macro. Possible return values include the following.
    ///    
    HRESULT OrderContainersRestore(uint NumberOfContainers, char* ContainerPaths, uint* ReadPlanEntries, 
                                   char* ReadPlan);
    ///Provides the application with a preview of the sequence of reads that are pending for a given container file
    ///extent.
    ///Params:
    ///    FileFullPath = The full path from the root directory of the volume to the container file.
    ///    NumberOfReads = Number of DDP_FILE_EXTENT structures in the array that the <i>ReadOffsets</i> parameter points to.
    ///    ReadOffsets = Pointer to an array of DDP_FILE_EXTENT structures.
    ///Returns:
    ///    This method can return standard <b>HRESULT</b> values, such as <b>S_OK</b>. It can also return converted
    ///    system error codes using the HRESULT_FROM_WIN32 macro. Possible return values include the following.
    ///    
    HRESULT PreviewContainerRead(BSTR FileFullPath, uint NumberOfReads, char* ReadOffsets);
}

///Provides a method for restoring a file from a backup store containing copies of Data Deduplication reparse points,
///metadata, and container files.
@GUID("C719D963-2B2D-415E-ACF7-7EB7CA596FF4")
interface IDedupBackupSupport : IUnknown
{
    ///Reconstructs a set of files from a backup store that contains the fully optimized version of the files (reparse
    ///points) and the Data Deduplication store. Applications that call the RestoreFiles method must also implement the
    ///IDedupReadFileCallback interface. Before calling the <b>RestoreFiles</b> method, the application must have
    ///previously restored the Data Deduplication reparse points for the files to the location specified by the
    ///<i>FileFullPaths</i> parameter. Metadata located in the reparse points will be utilized by Data Deduplication to
    ///further drive the restore process. After calling this method, applications can expect to receive two calls to
    ///IDedupReadFileCallback::OrderContainersRestore (one for stream map containers and one for data containers) and
    ///two or more calls to IDedupReadFileCallback::ReadBackupFile. The application will also receive one call to
    ///IDedupReadFileCallback::PreviewContainerRead before each call to <b>ReadBackupFile</b> that is directed to a
    ///container file.
    ///Params:
    ///    NumberOfFiles = The number of files to restore. If this exceeds 10,000 then the method will fail with <b>E_INVALIDARG</b>
    ///                    (0x80070057).
    ///    FileFullPaths = For each file, this parameter contains the full path from the root directory of the volume to the reparse
    ///                    point previously restored by the application.
    ///    Store = IDedupReadFileCallback interface pointer for the backup store. This parameter is required and cannot be
    ///            <b>NULL</b>.
    ///    Flags = This parameter must be <b>DEDUP_RECONSTRUCT_UNOPTIMIZED</b> on input. For more information, see the
    ///            DEDUP_BACKUP_SUPPORT_PARAM_TYPE enumeration.
    ///    FileResults = For each file, this parameter contains the results of the restore operation for that file. This parameter is
    ///                  optional and can be <b>NULL</b> if the application doesn't need to know the results for each individual file.
    ///Returns:
    ///    This method can return standard <b>HRESULT</b> values, such as <b>S_OK</b>. It can also return converted
    ///    system error codes using the HRESULT_FROM_WIN32 macro. You can test for success or failure <b>HRESULT</b>
    ///    values by using the SUCCEEDED and FAILED macros defined in Winerror.h. Possible return values include the
    ///    following. If no file was restored successfully, the result is the first file error encountered. This will be
    ///    one of the "DDP_E_<i>XXX</i>" error codes above.
    ///    
    HRESULT RestoreFiles(uint NumberOfFiles, char* FileFullPaths, IDedupReadFileCallback Store, uint Flags, 
                         char* FileResults);
}


// GUIDs

const GUID CLSID_DedupBackupSupport = GUIDOF!DedupBackupSupport;

const GUID IID_IDedupBackupSupport    = GUIDOF!IDedupBackupSupport;
const GUID IID_IDedupReadFileCallback = GUIDOF!IDedupReadFileCallback;
