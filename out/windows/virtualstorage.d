module windows.virtualstorage;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, OVERLAPPED;

extern(Windows):


// Enums


enum : int
{
    OPEN_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    OPEN_VIRTUAL_DISK_VERSION_1           = 0x00000001,
    OPEN_VIRTUAL_DISK_VERSION_2           = 0x00000002,
    OPEN_VIRTUAL_DISK_VERSION_3           = 0x00000003,
}
alias OPEN_VIRTUAL_DISK_VERSION = int;

enum : int
{
    VIRTUAL_DISK_ACCESS_NONE      = 0x00000000,
    VIRTUAL_DISK_ACCESS_ATTACH_RO = 0x00010000,
    VIRTUAL_DISK_ACCESS_ATTACH_RW = 0x00020000,
    VIRTUAL_DISK_ACCESS_DETACH    = 0x00040000,
    VIRTUAL_DISK_ACCESS_GET_INFO  = 0x00080000,
    VIRTUAL_DISK_ACCESS_CREATE    = 0x00100000,
    VIRTUAL_DISK_ACCESS_METAOPS   = 0x00200000,
    VIRTUAL_DISK_ACCESS_READ      = 0x000d0000,
    VIRTUAL_DISK_ACCESS_ALL       = 0x003f0000,
    VIRTUAL_DISK_ACCESS_WRITABLE  = 0x00320000,
}
alias VIRTUAL_DISK_ACCESS_MASK = int;

enum : int
{
    OPEN_VIRTUAL_DISK_FLAG_NONE                           = 0x00000000,
    OPEN_VIRTUAL_DISK_FLAG_NO_PARENTS                     = 0x00000001,
    OPEN_VIRTUAL_DISK_FLAG_BLANK_FILE                     = 0x00000002,
    OPEN_VIRTUAL_DISK_FLAG_BOOT_DRIVE                     = 0x00000004,
    OPEN_VIRTUAL_DISK_FLAG_CACHED_IO                      = 0x00000008,
    OPEN_VIRTUAL_DISK_FLAG_CUSTOM_DIFF_CHAIN              = 0x00000010,
    OPEN_VIRTUAL_DISK_FLAG_PARENT_CACHED_IO               = 0x00000020,
    OPEN_VIRTUAL_DISK_FLAG_VHDSET_FILE_ONLY               = 0x00000040,
    OPEN_VIRTUAL_DISK_FLAG_IGNORE_RELATIVE_PARENT_LOCATOR = 0x00000080,
    OPEN_VIRTUAL_DISK_FLAG_NO_WRITE_HARDENING             = 0x00000100,
    OPEN_VIRTUAL_DISK_FLAG_SUPPORT_COMPRESSED_VOLUMES     = 0x00000200,
}
alias OPEN_VIRTUAL_DISK_FLAG = int;

enum : int
{
    CREATE_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    CREATE_VIRTUAL_DISK_VERSION_1           = 0x00000001,
    CREATE_VIRTUAL_DISK_VERSION_2           = 0x00000002,
    CREATE_VIRTUAL_DISK_VERSION_3           = 0x00000003,
    CREATE_VIRTUAL_DISK_VERSION_4           = 0x00000004,
}
alias CREATE_VIRTUAL_DISK_VERSION = int;

enum : int
{
    CREATE_VIRTUAL_DISK_FLAG_NONE                                  = 0x00000000,
    CREATE_VIRTUAL_DISK_FLAG_FULL_PHYSICAL_ALLOCATION              = 0x00000001,
    CREATE_VIRTUAL_DISK_FLAG_PREVENT_WRITES_TO_SOURCE_DISK         = 0x00000002,
    CREATE_VIRTUAL_DISK_FLAG_DO_NOT_COPY_METADATA_FROM_PARENT      = 0x00000004,
    CREATE_VIRTUAL_DISK_FLAG_CREATE_BACKING_STORAGE                = 0x00000008,
    CREATE_VIRTUAL_DISK_FLAG_USE_CHANGE_TRACKING_SOURCE_LIMIT      = 0x00000010,
    CREATE_VIRTUAL_DISK_FLAG_PRESERVE_PARENT_CHANGE_TRACKING_STATE = 0x00000020,
    CREATE_VIRTUAL_DISK_FLAG_VHD_SET_USE_ORIGINAL_BACKING_STORAGE  = 0x00000040,
    CREATE_VIRTUAL_DISK_FLAG_SPARSE_FILE                           = 0x00000080,
    CREATE_VIRTUAL_DISK_FLAG_PMEM_COMPATIBLE                       = 0x00000100,
}
alias CREATE_VIRTUAL_DISK_FLAG = int;

enum : int
{
    ATTACH_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    ATTACH_VIRTUAL_DISK_VERSION_1           = 0x00000001,
    ATTACH_VIRTUAL_DISK_VERSION_2           = 0x00000002,
}
alias ATTACH_VIRTUAL_DISK_VERSION = int;

enum : int
{
    ATTACH_VIRTUAL_DISK_FLAG_NONE                             = 0x00000000,
    ATTACH_VIRTUAL_DISK_FLAG_READ_ONLY                        = 0x00000001,
    ATTACH_VIRTUAL_DISK_FLAG_NO_DRIVE_LETTER                  = 0x00000002,
    ATTACH_VIRTUAL_DISK_FLAG_PERMANENT_LIFETIME               = 0x00000004,
    ATTACH_VIRTUAL_DISK_FLAG_NO_LOCAL_HOST                    = 0x00000008,
    ATTACH_VIRTUAL_DISK_FLAG_NO_SECURITY_DESCRIPTOR           = 0x00000010,
    ATTACH_VIRTUAL_DISK_FLAG_BYPASS_DEFAULT_ENCRYPTION_POLICY = 0x00000020,
    ATTACH_VIRTUAL_DISK_FLAG_NON_PNP                          = 0x00000040,
    ATTACH_VIRTUAL_DISK_FLAG_RESTRICTED_RANGE                 = 0x00000080,
    ATTACH_VIRTUAL_DISK_FLAG_SINGLE_PARTITION                 = 0x00000100,
    ATTACH_VIRTUAL_DISK_FLAG_REGISTER_VOLUME                  = 0x00000200,
}
alias ATTACH_VIRTUAL_DISK_FLAG = int;

enum : int
{
    DETACH_VIRTUAL_DISK_FLAG_NONE = 0x00000000,
}
alias DETACH_VIRTUAL_DISK_FLAG = int;

enum : int
{
    DEPENDENT_DISK_FLAG_NONE                       = 0x00000000,
    DEPENDENT_DISK_FLAG_MULT_BACKING_FILES         = 0x00000001,
    DEPENDENT_DISK_FLAG_FULLY_ALLOCATED            = 0x00000002,
    DEPENDENT_DISK_FLAG_READ_ONLY                  = 0x00000004,
    DEPENDENT_DISK_FLAG_REMOTE                     = 0x00000008,
    DEPENDENT_DISK_FLAG_SYSTEM_VOLUME              = 0x00000010,
    DEPENDENT_DISK_FLAG_SYSTEM_VOLUME_PARENT       = 0x00000020,
    DEPENDENT_DISK_FLAG_REMOVABLE                  = 0x00000040,
    DEPENDENT_DISK_FLAG_NO_DRIVE_LETTER            = 0x00000080,
    DEPENDENT_DISK_FLAG_PARENT                     = 0x00000100,
    DEPENDENT_DISK_FLAG_NO_HOST_DISK               = 0x00000200,
    DEPENDENT_DISK_FLAG_PERMANENT_LIFETIME         = 0x00000400,
    DEPENDENT_DISK_FLAG_SUPPORT_COMPRESSED_VOLUMES = 0x00000800,
}
alias DEPENDENT_DISK_FLAG = int;

enum : int
{
    STORAGE_DEPENDENCY_INFO_VERSION_UNSPECIFIED = 0x00000000,
    STORAGE_DEPENDENCY_INFO_VERSION_1           = 0x00000001,
    STORAGE_DEPENDENCY_INFO_VERSION_2           = 0x00000002,
}
alias STORAGE_DEPENDENCY_INFO_VERSION = int;

enum : int
{
    GET_STORAGE_DEPENDENCY_FLAG_NONE         = 0x00000000,
    GET_STORAGE_DEPENDENCY_FLAG_HOST_VOLUMES = 0x00000001,
    GET_STORAGE_DEPENDENCY_FLAG_DISK_HANDLE  = 0x00000002,
}
alias GET_STORAGE_DEPENDENCY_FLAG = int;

enum : int
{
    GET_VIRTUAL_DISK_INFO_UNSPECIFIED                = 0x00000000,
    GET_VIRTUAL_DISK_INFO_SIZE                       = 0x00000001,
    GET_VIRTUAL_DISK_INFO_IDENTIFIER                 = 0x00000002,
    GET_VIRTUAL_DISK_INFO_PARENT_LOCATION            = 0x00000003,
    GET_VIRTUAL_DISK_INFO_PARENT_IDENTIFIER          = 0x00000004,
    GET_VIRTUAL_DISK_INFO_PARENT_TIMESTAMP           = 0x00000005,
    GET_VIRTUAL_DISK_INFO_VIRTUAL_STORAGE_TYPE       = 0x00000006,
    GET_VIRTUAL_DISK_INFO_PROVIDER_SUBTYPE           = 0x00000007,
    GET_VIRTUAL_DISK_INFO_IS_4K_ALIGNED              = 0x00000008,
    GET_VIRTUAL_DISK_INFO_PHYSICAL_DISK              = 0x00000009,
    GET_VIRTUAL_DISK_INFO_VHD_PHYSICAL_SECTOR_SIZE   = 0x0000000a,
    GET_VIRTUAL_DISK_INFO_SMALLEST_SAFE_VIRTUAL_SIZE = 0x0000000b,
    GET_VIRTUAL_DISK_INFO_FRAGMENTATION              = 0x0000000c,
    GET_VIRTUAL_DISK_INFO_IS_LOADED                  = 0x0000000d,
    GET_VIRTUAL_DISK_INFO_VIRTUAL_DISK_ID            = 0x0000000e,
    GET_VIRTUAL_DISK_INFO_CHANGE_TRACKING_STATE      = 0x0000000f,
}
alias GET_VIRTUAL_DISK_INFO_VERSION = int;

enum : int
{
    SET_VIRTUAL_DISK_INFO_UNSPECIFIED            = 0x00000000,
    SET_VIRTUAL_DISK_INFO_PARENT_PATH            = 0x00000001,
    SET_VIRTUAL_DISK_INFO_IDENTIFIER             = 0x00000002,
    SET_VIRTUAL_DISK_INFO_PARENT_PATH_WITH_DEPTH = 0x00000003,
    SET_VIRTUAL_DISK_INFO_PHYSICAL_SECTOR_SIZE   = 0x00000004,
    SET_VIRTUAL_DISK_INFO_VIRTUAL_DISK_ID        = 0x00000005,
    SET_VIRTUAL_DISK_INFO_CHANGE_TRACKING_STATE  = 0x00000006,
    SET_VIRTUAL_DISK_INFO_PARENT_LOCATOR         = 0x00000007,
}
alias SET_VIRTUAL_DISK_INFO_VERSION = int;

enum : int
{
    COMPACT_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    COMPACT_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}
alias COMPACT_VIRTUAL_DISK_VERSION = int;

enum : int
{
    COMPACT_VIRTUAL_DISK_FLAG_NONE           = 0x00000000,
    COMPACT_VIRTUAL_DISK_FLAG_NO_ZERO_SCAN   = 0x00000001,
    COMPACT_VIRTUAL_DISK_FLAG_NO_BLOCK_MOVES = 0x00000002,
}
alias COMPACT_VIRTUAL_DISK_FLAG = int;

enum : int
{
    MERGE_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    MERGE_VIRTUAL_DISK_VERSION_1           = 0x00000001,
    MERGE_VIRTUAL_DISK_VERSION_2           = 0x00000002,
}
alias MERGE_VIRTUAL_DISK_VERSION = int;

enum : int
{
    MERGE_VIRTUAL_DISK_FLAG_NONE = 0x00000000,
}
alias MERGE_VIRTUAL_DISK_FLAG = int;

enum : int
{
    EXPAND_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    EXPAND_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}
alias EXPAND_VIRTUAL_DISK_VERSION = int;

enum : int
{
    EXPAND_VIRTUAL_DISK_FLAG_NONE = 0x00000000,
}
alias EXPAND_VIRTUAL_DISK_FLAG = int;

enum : int
{
    RESIZE_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    RESIZE_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}
alias RESIZE_VIRTUAL_DISK_VERSION = int;

enum : int
{
    RESIZE_VIRTUAL_DISK_FLAG_NONE                                 = 0x00000000,
    RESIZE_VIRTUAL_DISK_FLAG_ALLOW_UNSAFE_VIRTUAL_SIZE            = 0x00000001,
    RESIZE_VIRTUAL_DISK_FLAG_RESIZE_TO_SMALLEST_SAFE_VIRTUAL_SIZE = 0x00000002,
}
alias RESIZE_VIRTUAL_DISK_FLAG = int;

enum : int
{
    MIRROR_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    MIRROR_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}
alias MIRROR_VIRTUAL_DISK_VERSION = int;

enum : int
{
    MIRROR_VIRTUAL_DISK_FLAG_NONE                   = 0x00000000,
    MIRROR_VIRTUAL_DISK_FLAG_EXISTING_FILE          = 0x00000001,
    MIRROR_VIRTUAL_DISK_FLAG_SKIP_MIRROR_ACTIVATION = 0x00000002,
    MIRROR_VIRTUAL_DISK_FLAG_ENABLE_SMB_COMPRESSION = 0x00000004,
    MIRROR_VIRTUAL_DISK_FLAG_IS_LIVE_MIGRATION      = 0x00000008,
}
alias MIRROR_VIRTUAL_DISK_FLAG = int;

enum : int
{
    QUERY_CHANGES_VIRTUAL_DISK_FLAG_NONE = 0x00000000,
}
alias QUERY_CHANGES_VIRTUAL_DISK_FLAG = int;

enum : int
{
    TAKE_SNAPSHOT_VHDSET_FLAG_NONE      = 0x00000000,
    TAKE_SNAPSHOT_VHDSET_FLAG_WRITEABLE = 0x00000001,
}
alias TAKE_SNAPSHOT_VHDSET_FLAG = int;

enum : int
{
    TAKE_SNAPSHOT_VHDSET_VERSION_UNSPECIFIED = 0x00000000,
    TAKE_SNAPSHOT_VHDSET_VERSION_1           = 0x00000001,
}
alias TAKE_SNAPSHOT_VHDSET_VERSION = int;

enum : int
{
    DELETE_SNAPSHOT_VHDSET_FLAG_NONE        = 0x00000000,
    DELETE_SNAPSHOT_VHDSET_FLAG_PERSIST_RCT = 0x00000001,
}
alias DELETE_SNAPSHOT_VHDSET_FLAG = int;

enum : int
{
    DELETE_SNAPSHOT_VHDSET_VERSION_UNSPECIFIED = 0x00000000,
    DELETE_SNAPSHOT_VHDSET_VERSION_1           = 0x00000001,
}
alias DELETE_SNAPSHOT_VHDSET_VERSION = int;

enum : int
{
    MODIFY_VHDSET_UNSPECIFIED           = 0x00000000,
    MODIFY_VHDSET_SNAPSHOT_PATH         = 0x00000001,
    MODIFY_VHDSET_REMOVE_SNAPSHOT       = 0x00000002,
    MODIFY_VHDSET_DEFAULT_SNAPSHOT_PATH = 0x00000003,
}
alias MODIFY_VHDSET_VERSION = int;

enum : int
{
    MODIFY_VHDSET_FLAG_NONE               = 0x00000000,
    MODIFY_VHDSET_FLAG_WRITEABLE_SNAPSHOT = 0x00000001,
}
alias MODIFY_VHDSET_FLAG = int;

enum : int
{
    APPLY_SNAPSHOT_VHDSET_FLAG_NONE      = 0x00000000,
    APPLY_SNAPSHOT_VHDSET_FLAG_WRITEABLE = 0x00000001,
}
alias APPLY_SNAPSHOT_VHDSET_FLAG = int;

enum : int
{
    APPLY_SNAPSHOT_VHDSET_VERSION_UNSPECIFIED = 0x00000000,
    APPLY_SNAPSHOT_VHDSET_VERSION_1           = 0x00000001,
}
alias APPLY_SNAPSHOT_VHDSET_VERSION = int;

enum : int
{
    RAW_SCSI_VIRTUAL_DISK_FLAG_NONE = 0x00000000,
}
alias RAW_SCSI_VIRTUAL_DISK_FLAG = int;

enum : int
{
    RAW_SCSI_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    RAW_SCSI_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}
alias RAW_SCSI_VIRTUAL_DISK_VERSION = int;

enum : int
{
    FORK_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    FORK_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}
alias FORK_VIRTUAL_DISK_VERSION = int;

enum : int
{
    FORK_VIRTUAL_DISK_FLAG_NONE          = 0x00000000,
    FORK_VIRTUAL_DISK_FLAG_EXISTING_FILE = 0x00000001,
}
alias FORK_VIRTUAL_DISK_FLAG = int;

// Structs


struct VIRTUAL_STORAGE_TYPE
{
    uint DeviceId;
    GUID VendorId;
}

struct OPEN_VIRTUAL_DISK_PARAMETERS
{
    OPEN_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            uint RWDepth;
        }
        struct Version2
        {
            BOOL GetInfoOnly;
            BOOL ReadOnly;
            GUID ResiliencyGuid;
        }
        struct Version3
        {
            BOOL GetInfoOnly;
            BOOL ReadOnly;
            GUID ResiliencyGuid;
            GUID SnapshotId;
        }
    }
}

struct CREATE_VIRTUAL_DISK_PARAMETERS
{
    CREATE_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            GUID          UniqueId;
            ulong         MaximumSize;
            uint          BlockSizeInBytes;
            uint          SectorSizeInBytes;
            const(wchar)* ParentPath;
            const(wchar)* SourcePath;
        }
        struct Version2
        {
            GUID                 UniqueId;
            ulong                MaximumSize;
            uint                 BlockSizeInBytes;
            uint                 SectorSizeInBytes;
            uint                 PhysicalSectorSizeInBytes;
            const(wchar)*        ParentPath;
            const(wchar)*        SourcePath;
            OPEN_VIRTUAL_DISK_FLAG OpenFlags;
            VIRTUAL_STORAGE_TYPE ParentVirtualStorageType;
            VIRTUAL_STORAGE_TYPE SourceVirtualStorageType;
            GUID                 ResiliencyGuid;
        }
        struct Version3
        {
            GUID                 UniqueId;
            ulong                MaximumSize;
            uint                 BlockSizeInBytes;
            uint                 SectorSizeInBytes;
            uint                 PhysicalSectorSizeInBytes;
            const(wchar)*        ParentPath;
            const(wchar)*        SourcePath;
            OPEN_VIRTUAL_DISK_FLAG OpenFlags;
            VIRTUAL_STORAGE_TYPE ParentVirtualStorageType;
            VIRTUAL_STORAGE_TYPE SourceVirtualStorageType;
            GUID                 ResiliencyGuid;
            const(wchar)*        SourceLimitPath;
            VIRTUAL_STORAGE_TYPE BackingStorageType;
        }
        struct Version4
        {
            GUID                 UniqueId;
            ulong                MaximumSize;
            uint                 BlockSizeInBytes;
            uint                 SectorSizeInBytes;
            uint                 PhysicalSectorSizeInBytes;
            const(wchar)*        ParentPath;
            const(wchar)*        SourcePath;
            OPEN_VIRTUAL_DISK_FLAG OpenFlags;
            VIRTUAL_STORAGE_TYPE ParentVirtualStorageType;
            VIRTUAL_STORAGE_TYPE SourceVirtualStorageType;
            GUID                 ResiliencyGuid;
            const(wchar)*        SourceLimitPath;
            VIRTUAL_STORAGE_TYPE BackingStorageType;
            GUID                 PmemAddressAbstractionType;
            ulong                DataAlignment;
        }
    }
}

struct ATTACH_VIRTUAL_DISK_PARAMETERS
{
    ATTACH_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            uint Reserved;
        }
        struct Version2
        {
            ulong RestrictedOffset;
            ulong RestrictedLength;
        }
    }
}

struct STORAGE_DEPENDENCY_INFO_TYPE_1
{
    DEPENDENT_DISK_FLAG  DependencyTypeFlags;
    uint                 ProviderSpecificFlags;
    VIRTUAL_STORAGE_TYPE VirtualStorageType;
}

struct STORAGE_DEPENDENCY_INFO_TYPE_2
{
    DEPENDENT_DISK_FLAG  DependencyTypeFlags;
    uint                 ProviderSpecificFlags;
    VIRTUAL_STORAGE_TYPE VirtualStorageType;
    uint                 AncestorLevel;
    const(wchar)*        DependencyDeviceName;
    const(wchar)*        HostVolumeName;
    const(wchar)*        DependentVolumeName;
    const(wchar)*        DependentVolumeRelativePath;
}

struct STORAGE_DEPENDENCY_INFO
{
    STORAGE_DEPENDENCY_INFO_VERSION Version;
    uint NumberEntries;
    union
    {
        STORAGE_DEPENDENCY_INFO_TYPE_1 Version1Entries;
        STORAGE_DEPENDENCY_INFO_TYPE_2 Version2Entries;
    }
}

struct GET_VIRTUAL_DISK_INFO
{
    GET_VIRTUAL_DISK_INFO_VERSION Version;
    union
    {
        struct Size
        {
            ulong VirtualSize;
            ulong PhysicalSize;
            uint  BlockSize;
            uint  SectorSize;
        }
        GUID                 Identifier;
        struct ParentLocation
        {
            BOOL      ParentResolved;
            ushort[1] ParentLocationBuffer;
        }
        GUID                 ParentIdentifier;
        uint                 ParentTimestamp;
        VIRTUAL_STORAGE_TYPE VirtualStorageType;
        uint                 ProviderSubtype;
        BOOL                 Is4kAligned;
        BOOL                 IsLoaded;
        struct PhysicalDisk
        {
            uint LogicalSectorSize;
            uint PhysicalSectorSize;
            BOOL IsRemote;
        }
        uint                 VhdPhysicalSectorSize;
        ulong                SmallestSafeVirtualSize;
        uint                 FragmentationPercentage;
        GUID                 VirtualDiskId;
        struct ChangeTrackingState
        {
            BOOL      Enabled;
            BOOL      NewerChanges;
            ushort[1] MostRecentId;
        }
    }
}

struct SET_VIRTUAL_DISK_INFO
{
    SET_VIRTUAL_DISK_INFO_VERSION Version;
    union
    {
        const(wchar)* ParentFilePath;
        GUID          UniqueIdentifier;
        struct ParentPathWithDepthInfo
        {
            uint          ChildDepth;
            const(wchar)* ParentFilePath;
        }
        uint          VhdPhysicalSectorSize;
        GUID          VirtualDiskId;
        BOOL          ChangeTrackingEnabled;
        struct ParentLocator
        {
            GUID          LinkageId;
            const(wchar)* ParentFilePath;
        }
    }
}

struct VIRTUAL_DISK_PROGRESS
{
    uint  OperationStatus;
    ulong CurrentValue;
    ulong CompletionValue;
}

struct COMPACT_VIRTUAL_DISK_PARAMETERS
{
    COMPACT_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            uint Reserved;
        }
    }
}

struct MERGE_VIRTUAL_DISK_PARAMETERS
{
    MERGE_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            uint MergeDepth;
        }
        struct Version2
        {
            uint MergeSourceDepth;
            uint MergeTargetDepth;
        }
    }
}

struct EXPAND_VIRTUAL_DISK_PARAMETERS
{
    EXPAND_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            ulong NewSize;
        }
    }
}

struct RESIZE_VIRTUAL_DISK_PARAMETERS
{
    RESIZE_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            ulong NewSize;
        }
    }
}

struct MIRROR_VIRTUAL_DISK_PARAMETERS
{
    MIRROR_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            const(wchar)* MirrorVirtualDiskPath;
        }
    }
}

struct QUERY_CHANGES_VIRTUAL_DISK_RANGE
{
    ulong ByteOffset;
    ulong ByteLength;
    ulong Reserved;
}

struct TAKE_SNAPSHOT_VHDSET_PARAMETERS
{
    TAKE_SNAPSHOT_VHDSET_VERSION Version;
    union
    {
        struct Version1
        {
            GUID SnapshotId;
        }
    }
}

struct DELETE_SNAPSHOT_VHDSET_PARAMETERS
{
    DELETE_SNAPSHOT_VHDSET_VERSION Version;
    union
    {
        struct Version1
        {
            GUID SnapshotId;
        }
    }
}

struct MODIFY_VHDSET_PARAMETERS
{
    MODIFY_VHDSET_VERSION Version;
    union
    {
        struct SnapshotPath
        {
            GUID          SnapshotId;
            const(wchar)* SnapshotFilePath;
        }
        GUID          SnapshotId;
        const(wchar)* DefaultFilePath;
    }
}

struct APPLY_SNAPSHOT_VHDSET_PARAMETERS
{
    APPLY_SNAPSHOT_VHDSET_VERSION Version;
    union
    {
        struct Version1
        {
            GUID SnapshotId;
            GUID LeafSnapshotId;
        }
    }
}

struct RAW_SCSI_VIRTUAL_DISK_PARAMETERS
{
    RAW_SCSI_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            BOOL   RSVDHandle;
            ubyte  DataIn;
            ubyte  CdbLength;
            ubyte  SenseInfoLength;
            uint   SrbFlags;
            uint   DataTransferLength;
            void*  DataBuffer;
            ubyte* SenseInfo;
            ubyte* Cdb;
        }
    }
}

struct RAW_SCSI_VIRTUAL_DISK_RESPONSE
{
    RAW_SCSI_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            ubyte ScsiStatus;
            ubyte SenseInfoLength;
            uint  DataTransferLength;
        }
    }
}

struct FORK_VIRTUAL_DISK_PARAMETERS
{
    FORK_VIRTUAL_DISK_VERSION Version;
    union
    {
        struct Version1
        {
            const(wchar)* ForkedVirtualDiskPath;
        }
    }
}

// Functions

@DllImport("VirtDisk")
uint OpenVirtualDisk(VIRTUAL_STORAGE_TYPE* VirtualStorageType, const(wchar)* Path, 
                     VIRTUAL_DISK_ACCESS_MASK VirtualDiskAccessMask, OPEN_VIRTUAL_DISK_FLAG Flags, 
                     OPEN_VIRTUAL_DISK_PARAMETERS* Parameters, ptrdiff_t* Handle);

@DllImport("VirtDisk")
uint CreateVirtualDisk(VIRTUAL_STORAGE_TYPE* VirtualStorageType, const(wchar)* Path, 
                       VIRTUAL_DISK_ACCESS_MASK VirtualDiskAccessMask, void* SecurityDescriptor, 
                       CREATE_VIRTUAL_DISK_FLAG Flags, uint ProviderSpecificFlags, 
                       CREATE_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped, ptrdiff_t* Handle);

@DllImport("VirtDisk")
uint AttachVirtualDisk(HANDLE VirtualDiskHandle, void* SecurityDescriptor, ATTACH_VIRTUAL_DISK_FLAG Flags, 
                       uint ProviderSpecificFlags, ATTACH_VIRTUAL_DISK_PARAMETERS* Parameters, 
                       OVERLAPPED* Overlapped);

@DllImport("VirtDisk")
uint DetachVirtualDisk(HANDLE VirtualDiskHandle, DETACH_VIRTUAL_DISK_FLAG Flags, uint ProviderSpecificFlags);

@DllImport("VirtDisk")
uint GetVirtualDiskPhysicalPath(HANDLE VirtualDiskHandle, uint* DiskPathSizeInBytes, const(wchar)* DiskPath);

@DllImport("VirtDisk")
uint GetAllAttachedVirtualDiskPhysicalPaths(uint* PathsBufferSizeInBytes, const(wchar)* PathsBuffer);

@DllImport("VirtDisk")
uint GetStorageDependencyInformation(HANDLE ObjectHandle, GET_STORAGE_DEPENDENCY_FLAG Flags, 
                                     uint StorageDependencyInfoSize, STORAGE_DEPENDENCY_INFO* StorageDependencyInfo, 
                                     uint* SizeUsed);

@DllImport("VirtDisk")
uint GetVirtualDiskInformation(HANDLE VirtualDiskHandle, uint* VirtualDiskInfoSize, char* VirtualDiskInfo, 
                               uint* SizeUsed);

@DllImport("VirtDisk")
uint SetVirtualDiskInformation(HANDLE VirtualDiskHandle, SET_VIRTUAL_DISK_INFO* VirtualDiskInfo);

@DllImport("VirtDisk")
uint EnumerateVirtualDiskMetadata(HANDLE VirtualDiskHandle, uint* NumberOfItems, char* Items);

@DllImport("VirtDisk")
uint GetVirtualDiskMetadata(HANDLE VirtualDiskHandle, const(GUID)* Item, uint* MetaDataSize, char* MetaData);

@DllImport("VirtDisk")
uint SetVirtualDiskMetadata(HANDLE VirtualDiskHandle, const(GUID)* Item, uint MetaDataSize, char* MetaData);

@DllImport("VirtDisk")
uint DeleteVirtualDiskMetadata(HANDLE VirtualDiskHandle, const(GUID)* Item);

@DllImport("VirtDisk")
uint GetVirtualDiskOperationProgress(HANDLE VirtualDiskHandle, OVERLAPPED* Overlapped, 
                                     VIRTUAL_DISK_PROGRESS* Progress);

@DllImport("VirtDisk")
uint CompactVirtualDisk(HANDLE VirtualDiskHandle, COMPACT_VIRTUAL_DISK_FLAG Flags, 
                        COMPACT_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped);

@DllImport("VirtDisk")
uint MergeVirtualDisk(HANDLE VirtualDiskHandle, MERGE_VIRTUAL_DISK_FLAG Flags, 
                      MERGE_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped);

@DllImport("VirtDisk")
uint ExpandVirtualDisk(HANDLE VirtualDiskHandle, EXPAND_VIRTUAL_DISK_FLAG Flags, 
                       EXPAND_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped);

@DllImport("VirtDisk")
uint ResizeVirtualDisk(HANDLE VirtualDiskHandle, RESIZE_VIRTUAL_DISK_FLAG Flags, 
                       RESIZE_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped);

@DllImport("VirtDisk")
uint MirrorVirtualDisk(HANDLE VirtualDiskHandle, MIRROR_VIRTUAL_DISK_FLAG Flags, 
                       MIRROR_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped);

@DllImport("VirtDisk")
uint BreakMirrorVirtualDisk(HANDLE VirtualDiskHandle);

@DllImport("VirtDisk")
uint AddVirtualDiskParent(HANDLE VirtualDiskHandle, const(wchar)* ParentPath);

@DllImport("VirtDisk")
uint QueryChangesVirtualDisk(HANDLE VirtualDiskHandle, const(wchar)* ChangeTrackingId, ulong ByteOffset, 
                             ulong ByteLength, QUERY_CHANGES_VIRTUAL_DISK_FLAG Flags, char* Ranges, uint* RangeCount, 
                             ulong* ProcessedLength);

@DllImport("VirtDisk")
uint TakeSnapshotVhdSet(HANDLE VirtualDiskHandle, const(TAKE_SNAPSHOT_VHDSET_PARAMETERS)* Parameters, 
                        TAKE_SNAPSHOT_VHDSET_FLAG Flags);

@DllImport("VirtDisk")
uint DeleteSnapshotVhdSet(HANDLE VirtualDiskHandle, const(DELETE_SNAPSHOT_VHDSET_PARAMETERS)* Parameters, 
                          DELETE_SNAPSHOT_VHDSET_FLAG Flags);

@DllImport("VirtDisk")
uint ModifyVhdSet(HANDLE VirtualDiskHandle, const(MODIFY_VHDSET_PARAMETERS)* Parameters, MODIFY_VHDSET_FLAG Flags);

@DllImport("VirtDisk")
uint ApplySnapshotVhdSet(HANDLE VirtualDiskHandle, const(APPLY_SNAPSHOT_VHDSET_PARAMETERS)* Parameters, 
                         APPLY_SNAPSHOT_VHDSET_FLAG Flags);

@DllImport("VirtDisk")
uint RawSCSIVirtualDisk(HANDLE VirtualDiskHandle, const(RAW_SCSI_VIRTUAL_DISK_PARAMETERS)* Parameters, 
                        RAW_SCSI_VIRTUAL_DISK_FLAG Flags, RAW_SCSI_VIRTUAL_DISK_RESPONSE* Response);

@DllImport("VirtDisk")
uint ForkVirtualDisk(HANDLE VirtualDiskHandle, FORK_VIRTUAL_DISK_FLAG Flags, 
                     const(FORK_VIRTUAL_DISK_PARAMETERS)* Parameters, OVERLAPPED* Overlapped);

@DllImport("VirtDisk")
uint CompleteForkVirtualDisk(HANDLE VirtualDiskHandle);


