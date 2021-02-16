module windows.datadeduplication;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


enum : int
{
    DEDUP_RECONSTRUCT_UNOPTIMIZED = 0x00000001,
    DEDUP_RECONSTRUCT_OPTIMIZED   = 0x00000002,
}
alias DEDUP_BACKUP_SUPPORT_PARAM_TYPE = int;

// Structs


struct DEDUP_CONTAINER_EXTENT
{
    uint ContainerIndex;
    long StartOffset;
    long Length;
}

struct DDP_FILE_EXTENT
{
    long Length;
    long Offset;
}

// Interfaces

@GUID("73D6B2AD-2984-4715-B2E3-924C149744DD")
struct DedupBackupSupport;

@GUID("7BACC67A-2F1D-42D0-897E-6FF62DD533BB")
interface IDedupReadFileCallback : IUnknown
{
    HRESULT ReadBackupFile(BSTR FileFullPath, long FileOffset, uint SizeToRead, char* FileBuffer, 
                           uint* ReturnedSize, uint Flags);
    HRESULT OrderContainersRestore(uint NumberOfContainers, char* ContainerPaths, uint* ReadPlanEntries, 
                                   char* ReadPlan);
    HRESULT PreviewContainerRead(BSTR FileFullPath, uint NumberOfReads, char* ReadOffsets);
}

@GUID("C719D963-2B2D-415E-ACF7-7EB7CA596FF4")
interface IDedupBackupSupport : IUnknown
{
    HRESULT RestoreFiles(uint NumberOfFiles, char* FileFullPaths, IDedupReadFileCallback Store, uint Flags, 
                         char* FileResults);
}


// GUIDs

const GUID CLSID_DedupBackupSupport = GUIDOF!DedupBackupSupport;

const GUID IID_IDedupBackupSupport    = GUIDOF!IDedupBackupSupport;
const GUID IID_IDedupReadFileCallback = GUIDOF!IDedupReadFileCallback;
