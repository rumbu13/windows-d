module windows.datadeduplication;

public import windows.automation;
public import windows.com;

extern(Windows):

const GUID CLSID_DedupBackupSupport = {0x73D6B2AD, 0x2984, 0x4715, [0xB2, 0xE3, 0x92, 0x4C, 0x14, 0x97, 0x44, 0xDD]};
@GUID(0x73D6B2AD, 0x2984, 0x4715, [0xB2, 0xE3, 0x92, 0x4C, 0x14, 0x97, 0x44, 0xDD]);
struct DedupBackupSupport;

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

enum DEDUP_BACKUP_SUPPORT_PARAM_TYPE
{
    DEDUP_RECONSTRUCT_UNOPTIMIZED = 1,
    DEDUP_RECONSTRUCT_OPTIMIZED = 2,
}

const GUID IID_IDedupReadFileCallback = {0x7BACC67A, 0x2F1D, 0x42D0, [0x89, 0x7E, 0x6F, 0xF6, 0x2D, 0xD5, 0x33, 0xBB]};
@GUID(0x7BACC67A, 0x2F1D, 0x42D0, [0x89, 0x7E, 0x6F, 0xF6, 0x2D, 0xD5, 0x33, 0xBB]);
interface IDedupReadFileCallback : IUnknown
{
    HRESULT ReadBackupFile(BSTR FileFullPath, long FileOffset, uint SizeToRead, char* FileBuffer, uint* ReturnedSize, uint Flags);
    HRESULT OrderContainersRestore(uint NumberOfContainers, char* ContainerPaths, uint* ReadPlanEntries, char* ReadPlan);
    HRESULT PreviewContainerRead(BSTR FileFullPath, uint NumberOfReads, char* ReadOffsets);
}

const GUID IID_IDedupBackupSupport = {0xC719D963, 0x2B2D, 0x415E, [0xAC, 0xF7, 0x7E, 0xB7, 0xCA, 0x59, 0x6F, 0xF4]};
@GUID(0xC719D963, 0x2B2D, 0x415E, [0xAC, 0xF7, 0x7E, 0xB7, 0xCA, 0x59, 0x6F, 0xF4]);
interface IDedupBackupSupport : IUnknown
{
    HRESULT RestoreFiles(uint NumberOfFiles, char* FileFullPaths, IDedupReadFileCallback Store, uint Flags, char* FileResults);
}

