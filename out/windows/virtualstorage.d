// Written in the D programming language.

module windows.virtualstorage;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, OVERLAPPED, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///Contains the version of the virtual disk OPEN_VIRTUAL_DISK_PARAMETERS structure to use in calls to virtual disk
///functions.
alias OPEN_VIRTUAL_DISK_VERSION = int;
enum : int
{
    ///Not supported.
    OPEN_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    ///The <b>Version1</b> member structure will be used.
    OPEN_VIRTUAL_DISK_VERSION_1           = 0x00000001,
    ///The <b>Version2</b> member structure will be used. <b>Windows 7 and Windows Server 2008 R2: </b>This value is not
    ///supported until Windows 8 and Windows Server 2012.
    OPEN_VIRTUAL_DISK_VERSION_2           = 0x00000002,
    OPEN_VIRTUAL_DISK_VERSION_3           = 0x00000003,
}

///Contains the bitmask for specifying access rights to a virtual hard disk (VHD) or CD or DVD image file (ISO).
alias VIRTUAL_DISK_ACCESS_MASK = int;
enum : int
{
    ///Open the virtual disk with no access. This is the only supported value when calling CreateVirtualDisk and
    ///specifying <b>CREATE_VIRTUAL_DISK_VERSION_2</b> in the <i>VirtualDiskAccessMask</i> parameter.
    VIRTUAL_DISK_ACCESS_NONE      = 0x00000000,
    ///Open the virtual disk for read-only attach access. The caller must have <b>READ</b> access to the virtual disk
    ///image file. If used in a request to open a virtual disk that is already open, the other handles must be limited
    ///to either <b>VIRTUAL_DISK_ACCESS_DETACH</b> or <b>VIRTUAL_DISK_ACCESS_GET_INFO</b> access, otherwise the open
    ///request with this flag will fail. <b>Windows 7 and Windows Server 2008 R2: </b>This access right is not supported
    ///for opening ISO virtual disks until Windows 8 and Windows Server 2012.
    VIRTUAL_DISK_ACCESS_ATTACH_RO = 0x00010000,
    ///Open the virtual disk for read/write attaching access. The caller must have <code>(READ | WRITE)</code> access to
    ///the virtual disk image file. If used in a request to open a virtual disk that is already open, the other handles
    ///must be limited to either <b>VIRTUAL_DISK_ACCESS_DETACH</b> or <b>VIRTUAL_DISK_ACCESS_GET_INFO</b> access,
    ///otherwise the open request with this flag will fail. If the virtual disk is part of a differencing chain, the
    ///disk for this request cannot be less than the <b>RWDepth</b> specified during the prior open request for that
    ///differencing chain. This flag is not supported for ISO virtual disks.
    VIRTUAL_DISK_ACCESS_ATTACH_RW = 0x00020000,
    ///Open the virtual disk to allow detaching of an attached virtual disk. The caller must have
    ///<code>(FILE_READ_ATTRIBUTES | FILE_READ_DATA)</code> access to the virtual disk image file. <b>Windows 7 and
    ///Windows Server 2008 R2: </b>This access right is not supported for opening ISO virtual disks until Windows 8 and
    ///Windows Server 2012.
    VIRTUAL_DISK_ACCESS_DETACH    = 0x00040000,
    ///Information retrieval access to the virtual disk. The caller must have <b>READ</b> access to the virtual disk
    ///image file. <b>Windows 7 and Windows Server 2008 R2: </b>This access right is not supported for opening ISO
    ///virtual disks until Windows 8 and Windows Server 2012.
    VIRTUAL_DISK_ACCESS_GET_INFO  = 0x00080000,
    ///Virtual disk creation access. This flag is not supported for ISO virtual disks.
    VIRTUAL_DISK_ACCESS_CREATE    = 0x00100000,
    ///Open the virtual disk to perform offline meta-operations. The caller must have <code>(READ | WRITE)</code> access
    ///to the virtual disk image file, up to <b>RWDepth</b> if working with a differencing chain. If the virtual disk is
    ///part of a differencing chain, the backing store (host volume) is opened in RW exclusive mode up to
    ///<b>RWDepth</b>. This flag is not supported for ISO virtual disks.
    VIRTUAL_DISK_ACCESS_METAOPS   = 0x00200000,
    ///Reserved.
    VIRTUAL_DISK_ACCESS_READ      = 0x000d0000,
    ///Allows unrestricted access to the virtual disk. The caller must have unrestricted access rights to the virtual
    ///disk image file. This flag is not supported for ISO virtual disks.
    VIRTUAL_DISK_ACCESS_ALL       = 0x003f0000,
    ///Reserved.
    VIRTUAL_DISK_ACCESS_WRITABLE  = 0x00320000,
}

///Contains virtual hard disk (VHD) or CD or DVD image file (ISO) open request flags.
alias OPEN_VIRTUAL_DISK_FLAG = int;
enum : int
{
    ///No flag specified.
    OPEN_VIRTUAL_DISK_FLAG_NONE                           = 0x00000000,
    ///Open the VHD file (backing store) without opening any differencing-chain parents. Used to correct broken parent
    ///links. This flag is not supported for ISO virtual disks.
    OPEN_VIRTUAL_DISK_FLAG_NO_PARENTS                     = 0x00000001,
    ///Reserved. This flag is not supported for ISO virtual disks.
    OPEN_VIRTUAL_DISK_FLAG_BLANK_FILE                     = 0x00000002,
    ///Reserved. This flag is not supported for ISO virtual disks.
    OPEN_VIRTUAL_DISK_FLAG_BOOT_DRIVE                     = 0x00000004,
    ///Indicates that the virtual disk should be opened in cached mode. By default the virtual disks are opened using
    ///<b>FILE_FLAG_NO_BUFFERING</b> and <b>FILE_FLAG_WRITE_THROUGH</b>. <b>Windows 7 and Windows Server 2008 R2:
    ///</b>This value is not supported before Windows 8 and Windows Server 2012.
    OPEN_VIRTUAL_DISK_FLAG_CACHED_IO                      = 0x00000008,
    ///Indicates the VHD file is to be opened without opening any differencing-chain parents and the parent chain is to
    ///be created manually using the AddVirtualDiskParent function. <b>Windows 7 and Windows Server 2008 R2: </b>This
    ///value is not supported before Windows 8 and Windows Server 2012.
    OPEN_VIRTUAL_DISK_FLAG_CUSTOM_DIFF_CHAIN              = 0x00000010,
    OPEN_VIRTUAL_DISK_FLAG_PARENT_CACHED_IO               = 0x00000020,
    OPEN_VIRTUAL_DISK_FLAG_VHDSET_FILE_ONLY               = 0x00000040,
    OPEN_VIRTUAL_DISK_FLAG_IGNORE_RELATIVE_PARENT_LOCATOR = 0x00000080,
    OPEN_VIRTUAL_DISK_FLAG_NO_WRITE_HARDENING             = 0x00000100,
    OPEN_VIRTUAL_DISK_FLAG_SUPPORT_COMPRESSED_VOLUMES     = 0x00000200,
}

///Contains the version of the virtual disk CREATE_VIRTUAL_DISK_PARAMETERS structure to use in calls to virtual disk
///functions.
alias CREATE_VIRTUAL_DISK_VERSION = int;
enum : int
{
    ///Not supported.
    CREATE_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    ///The <b>Version1</b> member structure will be used.
    CREATE_VIRTUAL_DISK_VERSION_1           = 0x00000001,
    ///The <b>Version2</b> member structure will be used. <b>Windows 7 and Windows Server 2008 R2: </b>This value is not
    ///supported until Windows 8 and Windows Server 2012.
    CREATE_VIRTUAL_DISK_VERSION_2           = 0x00000002,
    CREATE_VIRTUAL_DISK_VERSION_3           = 0x00000003,
    CREATE_VIRTUAL_DISK_VERSION_4           = 0x00000004,
}

///Contains virtual hard disk (VHD) creation flags.
alias CREATE_VIRTUAL_DISK_FLAG = int;
enum : int
{
    ///No special creation conditions; system defaults are used.
    CREATE_VIRTUAL_DISK_FLAG_NONE                                  = 0x00000000,
    ///Pre-allocate all physical space necessary for the size of the virtual disk.
    CREATE_VIRTUAL_DISK_FLAG_FULL_PHYSICAL_ALLOCATION              = 0x00000001,
    ///Take ownership of the source disk during create from source disk, to insure the source disk does not change
    ///during the create operation. The source disk must also already be offline or read-only (or both). Ownership is
    ///released when create is done. This also has a side-effect of disallowing concurrent create from same source disk.
    ///Create will fail if ownership cannot be obtained or if the source disk is not already offline or read-only. This
    ///flag is optional, but highly recommended for creates from source disk. No effect for other types of create (no
    ///effect for create from source VHD; no effect for create without SourcePath). <b>Windows 7 and Windows Server 2008
    ///R2: </b>This flag is not supported for opening ISO virtual disks until Windows 8 and Windows Server 2012.
    CREATE_VIRTUAL_DISK_FLAG_PREVENT_WRITES_TO_SOURCE_DISK         = 0x00000002,
    ///Do not copy initial virtual disk metadata or block states from the parent VHD; this is useful if the parent VHD
    ///is a stand-in file and the real parent will be explicitly set later. <b>Windows 7 and Windows Server 2008 R2:
    ///</b>This flag is not supported for opening ISO virtual disks until Windows 8 and Windows Server 2012.
    CREATE_VIRTUAL_DISK_FLAG_DO_NOT_COPY_METADATA_FROM_PARENT      = 0x00000004,
    CREATE_VIRTUAL_DISK_FLAG_CREATE_BACKING_STORAGE                = 0x00000008,
    CREATE_VIRTUAL_DISK_FLAG_USE_CHANGE_TRACKING_SOURCE_LIMIT      = 0x00000010,
    CREATE_VIRTUAL_DISK_FLAG_PRESERVE_PARENT_CHANGE_TRACKING_STATE = 0x00000020,
    CREATE_VIRTUAL_DISK_FLAG_VHD_SET_USE_ORIGINAL_BACKING_STORAGE  = 0x00000040,
    CREATE_VIRTUAL_DISK_FLAG_SPARSE_FILE                           = 0x00000080,
    CREATE_VIRTUAL_DISK_FLAG_PMEM_COMPATIBLE                       = 0x00000100,
}

///Contains the version of the virtual hard disk (VHD) ATTACH_VIRTUAL_DISK_PARAMETERS structure to use in calls to VHD
///functions.
alias ATTACH_VIRTUAL_DISK_VERSION = int;
enum : int
{
    ATTACH_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    ATTACH_VIRTUAL_DISK_VERSION_1           = 0x00000001,
    ATTACH_VIRTUAL_DISK_VERSION_2           = 0x00000002,
}

///Contains virtual disk attach request flags.
alias ATTACH_VIRTUAL_DISK_FLAG = int;
enum : int
{
    ///No flags. Use system defaults. This enumeration value is not supported for ISO virtual disks.
    ///<b>ATTACH_VIRTUAL_DISK_FLAG_READ_ONLY</b> must be specified.
    ATTACH_VIRTUAL_DISK_FLAG_NONE                             = 0x00000000,
    ///Attach the virtual disk as read-only. <b>Windows 7 and Windows Server 2008 R2: </b>This flag is not supported for
    ///opening ISO virtual disks until Windows 8 and Windows Server 2012.
    ATTACH_VIRTUAL_DISK_FLAG_READ_ONLY                        = 0x00000001,
    ///No drive letters are assigned to the disk's volumes. <b>Windows 7 and Windows Server 2008 R2: </b>This flag is
    ///not supported for opening ISO virtual disks until Windows 8 and Windows Server 2012.
    ATTACH_VIRTUAL_DISK_FLAG_NO_DRIVE_LETTER                  = 0x00000002,
    ///Will decouple the virtual disk lifetime from that of the <i>VirtualDiskHandle</i>. The virtual disk will be
    ///attached until the DetachVirtualDisk function is called, even if all open handles to the virtual disk are closed.
    ///<b>Windows 7 and Windows Server 2008 R2: </b>This flag is not supported for opening ISO virtual disks until
    ///Windows 8 and Windows Server 2012.
    ATTACH_VIRTUAL_DISK_FLAG_PERMANENT_LIFETIME               = 0x00000004,
    ///Reserved. This flag is not supported for ISO virtual disks.
    ATTACH_VIRTUAL_DISK_FLAG_NO_LOCAL_HOST                    = 0x00000008,
    ATTACH_VIRTUAL_DISK_FLAG_NO_SECURITY_DESCRIPTOR           = 0x00000010,
    ATTACH_VIRTUAL_DISK_FLAG_BYPASS_DEFAULT_ENCRYPTION_POLICY = 0x00000020,
    ATTACH_VIRTUAL_DISK_FLAG_NON_PNP                          = 0x00000040,
    ATTACH_VIRTUAL_DISK_FLAG_RESTRICTED_RANGE                 = 0x00000080,
    ATTACH_VIRTUAL_DISK_FLAG_SINGLE_PARTITION                 = 0x00000100,
    ATTACH_VIRTUAL_DISK_FLAG_REGISTER_VOLUME                  = 0x00000200,
}

///Contains virtual disk detach request flags.
alias DETACH_VIRTUAL_DISK_FLAG = int;
enum : int
{
    ///No flags. Use system defaults.
    DETACH_VIRTUAL_DISK_FLAG_NONE = 0x00000000,
}

///Contains virtual hard disk (VHD) dependency information flags.
alias DEPENDENT_DISK_FLAG = int;
enum : int
{
    ///No flags specified. Use system defaults.
    DEPENDENT_DISK_FLAG_NONE                       = 0x00000000,
    ///Multiple files backing the virtual disk.
    DEPENDENT_DISK_FLAG_MULT_BACKING_FILES         = 0x00000001,
    ///Fully allocated virtual disk.
    DEPENDENT_DISK_FLAG_FULLY_ALLOCATED            = 0x00000002,
    ///Read-only virtual disk.
    DEPENDENT_DISK_FLAG_READ_ONLY                  = 0x00000004,
    ///The backing file of the virtual disk is not on a local physical disk.
    DEPENDENT_DISK_FLAG_REMOTE                     = 0x00000008,
    ///Reserved.
    DEPENDENT_DISK_FLAG_SYSTEM_VOLUME              = 0x00000010,
    ///The backing file of the virtual disk is on the system volume.
    DEPENDENT_DISK_FLAG_SYSTEM_VOLUME_PARENT       = 0x00000020,
    ///The backing file of the virtual disk is on a removable physical disk.
    DEPENDENT_DISK_FLAG_REMOVABLE                  = 0x00000040,
    ///Drive letters are not automatically assigned to the volumes on the virtual disk.
    DEPENDENT_DISK_FLAG_NO_DRIVE_LETTER            = 0x00000080,
    ///The virtual disk is a parent of a differencing chain.
    DEPENDENT_DISK_FLAG_PARENT                     = 0x00000100,
    ///The virtual disk is not attached to the local host. For example, it is attached to a guest virtual machine.
    DEPENDENT_DISK_FLAG_NO_HOST_DISK               = 0x00000200,
    ///The lifetime of the virtual disk is not tied to any application or process.
    DEPENDENT_DISK_FLAG_PERMANENT_LIFETIME         = 0x00000400,
    DEPENDENT_DISK_FLAG_SUPPORT_COMPRESSED_VOLUMES = 0x00000800,
}

///Contains the version of the virtual hard disk (VHD)
///[STORAGE_DEPENDENCY_INFO](./ns-virtdisk-storage_dependency_info.md) structure to use in calls to VHD functions.
alias STORAGE_DEPENDENCY_INFO_VERSION = int;
enum : int
{
    ///The version is not specified.
    STORAGE_DEPENDENCY_INFO_VERSION_UNSPECIFIED = 0x00000000,
    ///Specifies STORAGE_DEPENDENCY_INFO_TYPE_1.
    STORAGE_DEPENDENCY_INFO_VERSION_1           = 0x00000001,
    ///Specifies STORAGE_DEPENDENCY_INFO_TYPE_2.
    STORAGE_DEPENDENCY_INFO_VERSION_2           = 0x00000002,
}

///Contains virtual hard disk (VHD) storage dependency request flags.
alias GET_STORAGE_DEPENDENCY_FLAG = int;
enum : int
{
    ///No flags specified.
    GET_STORAGE_DEPENDENCY_FLAG_NONE         = 0x00000000,
    ///Return information for volumes or disks hosting the volume specified.
    GET_STORAGE_DEPENDENCY_FLAG_HOST_VOLUMES = 0x00000001,
    ///The handle provided is to a disk, not a volume or file.
    GET_STORAGE_DEPENDENCY_FLAG_DISK_HANDLE  = 0x00000002,
}

///Contains the kinds of virtual hard disk (VHD) information that you can retrieve. For more information, see
///[GET_VIRTUAL_DISK_INFO](./ns-virtdisk-get_virtual_disk_info.md).
alias GET_VIRTUAL_DISK_INFO_VERSION = int;
enum : int
{
    ///Reserved. This value should not be used.
    GET_VIRTUAL_DISK_INFO_UNSPECIFIED                = 0x00000000,
    ///Information related to the virtual disk size, including total size, physical allocation used, block size, and
    ///sector size.
    GET_VIRTUAL_DISK_INFO_SIZE                       = 0x00000001,
    ///The unique identifier. This identifier is persistently stored in the virtual disk and will not change even if the
    ///virtual disk file is copied to another file.
    GET_VIRTUAL_DISK_INFO_IDENTIFIER                 = 0x00000002,
    ///The paths to parent virtual disks. Valid only for differencing virtual disks.
    GET_VIRTUAL_DISK_INFO_PARENT_LOCATION            = 0x00000003,
    ///The unique identifier of the parent virtual disk. Valid only for differencing virtual disks.
    GET_VIRTUAL_DISK_INFO_PARENT_IDENTIFIER          = 0x00000004,
    ///The time stamp of the parent when the child virtual disk was created. Valid only for differencing virtual disks.
    GET_VIRTUAL_DISK_INFO_PARENT_TIMESTAMP           = 0x00000005,
    ///The device identifier and vendor identifier that identify the type of virtual disk.
    GET_VIRTUAL_DISK_INFO_VIRTUAL_STORAGE_TYPE       = 0x00000006,
    ///The type of virtual disk.
    GET_VIRTUAL_DISK_INFO_PROVIDER_SUBTYPE           = 0x00000007,
    ///Indicates whether the virtual disk is 4 KB aligned. <b>Windows 7 and Windows Server 2008 R2: </b>This value is
    ///not supported before Windows 8 and Windows Server 2012.
    GET_VIRTUAL_DISK_INFO_IS_4K_ALIGNED              = 0x00000008,
    ///Details about the physical disk on which the virtual disk resides. <b>Windows 7 and Windows Server 2008 R2:
    ///</b>This value is not supported before Windows 8 and Windows Server 2012.
    GET_VIRTUAL_DISK_INFO_PHYSICAL_DISK              = 0x00000009,
    ///The physical sector size of the virtual disk. <b>Windows 7 and Windows Server 2008 R2: </b>This value is not
    ///supported before Windows 8 and Windows Server 2012.
    GET_VIRTUAL_DISK_INFO_VHD_PHYSICAL_SECTOR_SIZE   = 0x0000000a,
    ///The smallest safe minimum size of the virtual disk. <b>Windows 7 and Windows Server 2008 R2: </b>This value is
    ///not supported before Windows 8 and Windows Server 2012.
    GET_VIRTUAL_DISK_INFO_SMALLEST_SAFE_VIRTUAL_SIZE = 0x0000000b,
    ///The fragmentation level of the virtual disk. <b>Windows 7 and Windows Server 2008 R2: </b>This value is not
    ///supported before Windows 8 and Windows Server 2012.
    GET_VIRTUAL_DISK_INFO_FRAGMENTATION              = 0x0000000c,
    ///Whether the virtual disk is currently mounted and in use. <b>Windows 8 and Windows Server 2012: </b>This value is
    ///not supported before Windows 8.1 and Windows Server 2012 R2.
    GET_VIRTUAL_DISK_INFO_IS_LOADED                  = 0x0000000d,
    ///The identifier that is uniquely created when a user first creates the virtual disk to attempt to uniquely
    ///identify that virtual disk. <b>Windows 8 and Windows Server 2012: </b>This value is not supported before Windows
    ///8.1 and Windows Server 2012 R2.
    GET_VIRTUAL_DISK_INFO_VIRTUAL_DISK_ID            = 0x0000000e,
    ///The state of resilient change tracking (RCT) for the virtual disk. <b>Windows 8.1 and Windows Server 2012 R2:
    ///</b>This value is not supported before Windows 10 and Windows Server 2016.
    GET_VIRTUAL_DISK_INFO_CHANGE_TRACKING_STATE      = 0x0000000f,
}

///Contains the version of the virtual disk [SET_VIRTUAL_DISK_INFO](./ns-virtdisk-set_virtual_disk_info.md) structure to
///use in calls to VHD functions. Use the different versions of the structure to set different kinds of information for
///the VHD.
alias SET_VIRTUAL_DISK_INFO_VERSION = int;
enum : int
{
    ///Not used. Will fail the operation.
    SET_VIRTUAL_DISK_INFO_UNSPECIFIED            = 0x00000000,
    ///Parent information is being set.
    SET_VIRTUAL_DISK_INFO_PARENT_PATH            = 0x00000001,
    ///A unique identifier is being set. <div class="alert"><b>Note</b> If the VHD's unique identifier changes as a
    ///result of the <b>SET_VIRTUAL_DISK_INFO_IDENTIFIER</b> operation, it will break any existing differencing chains
    ///on the VHD.</div> <div> </div>
    SET_VIRTUAL_DISK_INFO_IDENTIFIER             = 0x00000002,
    ///Sets the parent file path and the child depth. <b>Windows 7 and Windows Server 2008 R2: </b>This value is not
    ///supported before Windows 8 and Windows Server 2012.
    SET_VIRTUAL_DISK_INFO_PARENT_PATH_WITH_DEPTH = 0x00000003,
    ///Sets the physical sector size reported by the VHD. <b>Windows 7 and Windows Server 2008 R2: </b>This value is not
    ///supported before Windows 8 and Windows Server 2012.
    SET_VIRTUAL_DISK_INFO_PHYSICAL_SECTOR_SIZE   = 0x00000004,
    ///The identifier that is uniquely created when a user first creates the virtual disk to attempt to uniquely
    ///identify that virtual disk. <b>Windows 8 and Windows Server 2012: </b>This value is not supported before Windows
    ///8.1 and Windows Server 2012 R2.
    SET_VIRTUAL_DISK_INFO_VIRTUAL_DISK_ID        = 0x00000005,
    ///Whether resilient change tracking (RCT) is turned on for the virtual disk. <b>Windows 8.1 and Windows Server 2012
    ///R2: </b>This value is not supported before Windows 10 and Windows Server 2016.
    SET_VIRTUAL_DISK_INFO_CHANGE_TRACKING_STATE  = 0x00000006,
    ///The parent linkage information that differencing VHDs store. Parent linkage information is metadata used to
    ///locate and correctly identify the next parent in the virtual disk chain. <b>Windows 8.1 and Windows Server 2012
    ///R2: </b>This value is not supported before Windows 10 and Windows Server 2016.
    SET_VIRTUAL_DISK_INFO_PARENT_LOCATOR         = 0x00000007,
}

///Contains the version of the virtual hard disk (VHD) COMPACT_VIRTUAL_DISK_PARAMETERS structure to use in calls to VHD
///functions.
alias COMPACT_VIRTUAL_DISK_VERSION = int;
enum : int
{
    COMPACT_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    COMPACT_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}

///Contains virtual disk compact request flags.
alias COMPACT_VIRTUAL_DISK_FLAG = int;
enum : int
{
    ///No flags are specified.
    COMPACT_VIRTUAL_DISK_FLAG_NONE           = 0x00000000,
    COMPACT_VIRTUAL_DISK_FLAG_NO_ZERO_SCAN   = 0x00000001,
    COMPACT_VIRTUAL_DISK_FLAG_NO_BLOCK_MOVES = 0x00000002,
}

///Contains the version of the virtual hard disk (VHD) MERGE_VIRTUAL_DISK_PARAMETERS structure to use in calls to VHD
///functions.
alias MERGE_VIRTUAL_DISK_VERSION = int;
enum : int
{
    ///Not supported.
    MERGE_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    ///The <b>Version1</b> member structure will be used.
    MERGE_VIRTUAL_DISK_VERSION_1           = 0x00000001,
    ///The <b>Version2</b> member structure will be used. <b>Windows 7 and Windows Server 2008 R2: </b>This value is not
    ///supported until Windows 8 and Windows Server 2012.
    MERGE_VIRTUAL_DISK_VERSION_2           = 0x00000002,
}

///Contains virtual hard disk (VHD) merge request flags.
alias MERGE_VIRTUAL_DISK_FLAG = int;
enum : int
{
    MERGE_VIRTUAL_DISK_FLAG_NONE = 0x00000000,
}

///Contains the version of the virtual disk EXPAND_VIRTUAL_DISK_PARAMETERS structure to use in calls to virtual disk
///functions.
alias EXPAND_VIRTUAL_DISK_VERSION = int;
enum : int
{
    EXPAND_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    EXPAND_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}

///Contains virtual hard disk (VHD) expand request flags.
alias EXPAND_VIRTUAL_DISK_FLAG = int;
enum : int
{
    EXPAND_VIRTUAL_DISK_FLAG_NONE = 0x00000000,
}

///Enumerates the possible versions for parameters for the ResizeVirtualDisk function.
alias RESIZE_VIRTUAL_DISK_VERSION = int;
enum : int
{
    ///The version is not valid.
    RESIZE_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    ///Version one of the parameters is used. This is the only supported value.
    RESIZE_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}

///Enumerates the available flags for the ResizeVirtualDisk function.
alias RESIZE_VIRTUAL_DISK_FLAG = int;
enum : int
{
    ///No flags are specified.
    RESIZE_VIRTUAL_DISK_FLAG_NONE                                 = 0x00000000,
    ///If this flag is set, skip checking the virtual disk's partition table to ensure that this truncation is safe.
    ///Setting this flag can cause unrecoverable data loss; use with care.
    RESIZE_VIRTUAL_DISK_FLAG_ALLOW_UNSAFE_VIRTUAL_SIZE            = 0x00000001,
    ///If this flag is set, resize the disk to the smallest virtual size possible without truncating past any existing
    ///partitions. If this is set, the <b>NewSize</b> member in the RESIZE_VIRTUAL_DISK_PARAMETERS structure must be
    ///zero.
    RESIZE_VIRTUAL_DISK_FLAG_RESIZE_TO_SMALLEST_SAFE_VIRTUAL_SIZE = 0x00000002,
}

///Contains the version of the virtual disk MIRROR_VIRTUAL_DISK_PARAMETERS structure used by the MirrorVirtualDisk
///function.
alias MIRROR_VIRTUAL_DISK_VERSION = int;
enum : int
{
    ///Unsupported.
    MIRROR_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    ///Use the <b>Version1</b> member.
    MIRROR_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}

///Contains virtual hard disk (VHD) mirror request flags.
alias MIRROR_VIRTUAL_DISK_FLAG = int;
enum : int
{
    ///The mirror virtual disk file does not exist, and needs to be created.
    MIRROR_VIRTUAL_DISK_FLAG_NONE                   = 0x00000000,
    ///Create the mirror using an existing file.
    MIRROR_VIRTUAL_DISK_FLAG_EXISTING_FILE          = 0x00000001,
    MIRROR_VIRTUAL_DISK_FLAG_SKIP_MIRROR_ACTIVATION = 0x00000002,
    MIRROR_VIRTUAL_DISK_FLAG_ENABLE_SMB_COMPRESSION = 0x00000004,
    MIRROR_VIRTUAL_DISK_FLAG_IS_LIVE_MIGRATION      = 0x00000008,
}

alias QUERY_CHANGES_VIRTUAL_DISK_FLAG = int;
enum : int
{
    QUERY_CHANGES_VIRTUAL_DISK_FLAG_NONE = 0x00000000,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Contains flags affecting the behavior of the TakeSnapshotVhdSet function.
alias TAKE_SNAPSHOT_VHDSET_FLAG = int;
enum : int
{
    ///No flag specified.
    TAKE_SNAPSHOT_VHDSET_FLAG_NONE      = 0x00000000,
    TAKE_SNAPSHOT_VHDSET_FLAG_WRITEABLE = 0x00000001,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Enumerates the possible versions for parameters for the TakeSnapshotVhdSet function.
alias TAKE_SNAPSHOT_VHDSET_VERSION = int;
enum : int
{
    ///Not Supported.
    TAKE_SNAPSHOT_VHDSET_VERSION_UNSPECIFIED = 0x00000000,
    TAKE_SNAPSHOT_VHDSET_VERSION_1           = 0x00000001,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Contains flags affecting the behavior of the DeleteSnapshotVhdSet function.
alias DELETE_SNAPSHOT_VHDSET_FLAG = int;
enum : int
{
    ///No flag specified.
    DELETE_SNAPSHOT_VHDSET_FLAG_NONE        = 0x00000000,
    DELETE_SNAPSHOT_VHDSET_FLAG_PERSIST_RCT = 0x00000001,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Contains the version of the DELETE_SNAPHSOT_VHDSET_PARAMETERS structure to use in calls to virtual
///disk functions.
alias DELETE_SNAPSHOT_VHDSET_VERSION = int;
enum : int
{
    ///Not supported.
    DELETE_SNAPSHOT_VHDSET_VERSION_UNSPECIFIED = 0x00000000,
    DELETE_SNAPSHOT_VHDSET_VERSION_1           = 0x00000001,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Contains the version of the MODIFY_VHDSET_PARAMETERS structure to use in calls to virtual disk
///functions.
alias MODIFY_VHDSET_VERSION = int;
enum : int
{
    ///Not Supported.
    MODIFY_VHDSET_UNSPECIFIED           = 0x00000000,
    ///The <b>SnapshotPath</b> member structure will be used.
    MODIFY_VHDSET_SNAPSHOT_PATH         = 0x00000001,
    ///The <b>SnapshotId</b> member structure will be used.
    MODIFY_VHDSET_REMOVE_SNAPSHOT       = 0x00000002,
    MODIFY_VHDSET_DEFAULT_SNAPSHOT_PATH = 0x00000003,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Contains flags affecting the behavior of the ModifyVhdSet function.
alias MODIFY_VHDSET_FLAG = int;
enum : int
{
    ///No flag specified.
    MODIFY_VHDSET_FLAG_NONE               = 0x00000000,
    MODIFY_VHDSET_FLAG_WRITEABLE_SNAPSHOT = 0x00000001,
}

///Contains flags affecting the behavior of the ApplySnapshotVhdSet function.
alias APPLY_SNAPSHOT_VHDSET_FLAG = int;
enum : int
{
    ///No flag specified.
    APPLY_SNAPSHOT_VHDSET_FLAG_NONE      = 0x00000000,
    APPLY_SNAPSHOT_VHDSET_FLAG_WRITEABLE = 0x00000001,
}

///Enumerates the possible versions for parameters for the ApplySnapshotVhdSet function.
alias APPLY_SNAPSHOT_VHDSET_VERSION = int;
enum : int
{
    ///Not Supported.
    APPLY_SNAPSHOT_VHDSET_VERSION_UNSPECIFIED = 0x00000000,
    APPLY_SNAPSHOT_VHDSET_VERSION_1           = 0x00000001,
}

///Contains flags affecting the behavior of the RawSCSIVirtualDisk function.
alias RAW_SCSI_VIRTUAL_DISK_FLAG = int;
enum : int
{
    RAW_SCSI_VIRTUAL_DISK_FLAG_NONE = 0x00000000,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Contains the version of the RAW_SCSI_VIRTUAL_DISK_PARAMETERS structure to use in calls to virtual
///disk functions.
alias RAW_SCSI_VIRTUAL_DISK_VERSION = int;
enum : int
{
    RAW_SCSI_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    RAW_SCSI_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}

alias FORK_VIRTUAL_DISK_VERSION = int;
enum : int
{
    FORK_VIRTUAL_DISK_VERSION_UNSPECIFIED = 0x00000000,
    FORK_VIRTUAL_DISK_VERSION_1           = 0x00000001,
}

alias FORK_VIRTUAL_DISK_FLAG = int;
enum : int
{
    FORK_VIRTUAL_DISK_FLAG_NONE          = 0x00000000,
    FORK_VIRTUAL_DISK_FLAG_EXISTING_FILE = 0x00000001,
}

// Structs


///Contains the type and provider (vendor) of the virtual storage device.
struct VIRTUAL_STORAGE_TYPE
{
    ///Device type identifier. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="VIRTUAL_STORAGE_TYPE_DEVICE_UNKNOWN"></a><a id="virtual_storage_type_device_unknown"></a><dl>
    ///<dt><b>VIRTUAL_STORAGE_TYPE_DEVICE_UNKNOWN</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Device type is
    ///unknown or not valid. </td> </tr> <tr> <td width="40%"><a id="VIRTUAL_STORAGE_TYPE_DEVICE_ISO"></a><a
    ///id="virtual_storage_type_device_iso"></a><dl> <dt><b>VIRTUAL_STORAGE_TYPE_DEVICE_ISO</b></dt> <dt>1</dt> </dl>
    ///</td> <td width="60%"> CD or DVD image file device type. (.iso file) <b>Windows 7 and Windows Server 2008 R2:
    ///</b>This value is not supported before Windows 8 and Windows Server 2012. </td> </tr> <tr> <td width="40%"><a
    ///id="VIRTUAL_STORAGE_TYPE_DEVICE_VHD"></a><a id="virtual_storage_type_device_vhd"></a><dl>
    ///<dt><b>VIRTUAL_STORAGE_TYPE_DEVICE_VHD</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Virtual hard disk device
    ///type. (.vhd file) </td> </tr> <tr> <td width="40%"><a id="VIRTUAL_STORAGE_TYPE_DEVICE_VHDX"></a><a
    ///id="virtual_storage_type_device_vhdx"></a><dl> <dt><b>VIRTUAL_STORAGE_TYPE_DEVICE_VHDX</b></dt> <dt>3</dt> </dl>
    ///</td> <td width="60%"> VHDX format virtual hard disk device type. (.vhdx file) <b>Windows 7 and Windows Server
    ///2008 R2: </b>This value is not supported before Windows 8 and Windows Server 2012. </td> </tr> </table>
    uint DeviceId;
    ///Vendor-unique identifier.
    GUID VendorId;
}

///Contains virtual disk open request parameters.
struct OPEN_VIRTUAL_DISK_PARAMETERS
{
    ///An OPEN_VIRTUAL_DISK_VERSION enumeration that specifies the version of the <b>OPEN_VIRTUAL_DISK_PARAMETERS</b>
    ///structure being passed to or from the VHD functions. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="OPEN_VIRTUAL_DISK_VERSION_1"></a><a id="open_virtual_disk_version_1"></a><dl>
    ///<dt><b>OPEN_VIRTUAL_DISK_VERSION_1</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Use the <b>Version1</b>
    ///member of this structure. </td> </tr> <tr> <td width="40%"><a id="OPEN_VIRTUAL_DISK_VERSION_2"></a><a
    ///id="open_virtual_disk_version_2"></a><dl> <dt><b>OPEN_VIRTUAL_DISK_VERSION_2</b></dt> <dt>2</dt> </dl> </td> <td
    ///width="60%"> Use the <b>Version2</b> member of this structure. </td> </tr> </table>
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

///Contains virtual hard disk (VHD) creation parameters, providing control over, and information about, the newly
///created virtual disk.
struct CREATE_VIRTUAL_DISK_PARAMETERS
{
    ///A value from the CREATE_VIRTUAL_DISK_VERSION enumeration that is the discriminant for the union. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CREATE_VIRTUAL_DISK_VERSION_1"></a><a
    ///id="create_virtual_disk_version_1"></a><dl> <dt><b>CREATE_VIRTUAL_DISK_VERSION_1</b></dt> <dt>1</dt> </dl> </td>
    ///<td width="60%"> Use the <b>Version1</b> member of this structure. </td> </tr> <tr> <td width="40%"><a
    ///id="CREATE_VIRTUAL_DISK_VERSION_2"></a><a id="create_virtual_disk_version_2"></a><dl>
    ///<dt><b>CREATE_VIRTUAL_DISK_VERSION_2</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Use the <b>Version2</b>
    ///member of this structure. </td> </tr> </table>
    CREATE_VIRTUAL_DISK_VERSION Version;
union
    {
struct Version1
        {
            GUID         UniqueId;
            ulong        MaximumSize;
            uint         BlockSizeInBytes;
            uint         SectorSizeInBytes;
            const(PWSTR) ParentPath;
            const(PWSTR) SourcePath;
        }
struct Version2
        {
            GUID                 UniqueId;
            ulong                MaximumSize;
            uint                 BlockSizeInBytes;
            uint                 SectorSizeInBytes;
            uint                 PhysicalSectorSizeInBytes;
            const(PWSTR)         ParentPath;
            const(PWSTR)         SourcePath;
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
            const(PWSTR)         ParentPath;
            const(PWSTR)         SourcePath;
            OPEN_VIRTUAL_DISK_FLAG OpenFlags;
            VIRTUAL_STORAGE_TYPE ParentVirtualStorageType;
            VIRTUAL_STORAGE_TYPE SourceVirtualStorageType;
            GUID                 ResiliencyGuid;
            const(PWSTR)         SourceLimitPath;
            VIRTUAL_STORAGE_TYPE BackingStorageType;
        }
struct Version4
        {
            GUID                 UniqueId;
            ulong                MaximumSize;
            uint                 BlockSizeInBytes;
            uint                 SectorSizeInBytes;
            uint                 PhysicalSectorSizeInBytes;
            const(PWSTR)         ParentPath;
            const(PWSTR)         SourcePath;
            OPEN_VIRTUAL_DISK_FLAG OpenFlags;
            VIRTUAL_STORAGE_TYPE ParentVirtualStorageType;
            VIRTUAL_STORAGE_TYPE SourceVirtualStorageType;
            GUID                 ResiliencyGuid;
            const(PWSTR)         SourceLimitPath;
            VIRTUAL_STORAGE_TYPE BackingStorageType;
            GUID                 PmemAddressAbstractionType;
            ulong                DataAlignment;
        }
    }
}

///Contains virtual hard disk (VHD) attach request parameters.
struct ATTACH_VIRTUAL_DISK_PARAMETERS
{
    ///A ATTACH_VIRTUAL_DISK_VERSION enumeration that specifies the version of the <b>ATTACH_VIRTUAL_DISK_PARAMETERS</b>
    ///structure being passed to or from the VHD functions.
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

///Contains virtual hard disk (VHD) storage dependency information for type 1.
struct STORAGE_DEPENDENCY_INFO_TYPE_1
{
    ///A DEPENDENT_DISK_FLAG enumeration.
    DEPENDENT_DISK_FLAG  DependencyTypeFlags;
    ///Flags specific to the VHD provider.
    uint                 ProviderSpecificFlags;
    ///A VIRTUAL_STORAGE_TYPE structure.
    VIRTUAL_STORAGE_TYPE VirtualStorageType;
}

///Contains VHD or ISO storage dependency information for type 2.
struct STORAGE_DEPENDENCY_INFO_TYPE_2
{
    ///A DEPENDENT_DISK_FLAG enumeration.
    DEPENDENT_DISK_FLAG  DependencyTypeFlags;
    ///Flags specific to the VHD provider.
    uint                 ProviderSpecificFlags;
    ///A VIRTUAL_STORAGE_TYPE structure.
    VIRTUAL_STORAGE_TYPE VirtualStorageType;
    ///The ancestor level.
    uint                 AncestorLevel;
    ///The device name of the dependent device. If the device is a virtual hard drive then this will be in the form
    ///\\.\PhysicalDrive<i>N</i>. If the device is a virtual CD or DVD drive (ISO) then this will be in the form
    ///\\.\CDRom<i>N</i>. In either case <i>N</i> is an integer that represents a unique identifier for the caller's
    ///host system.
    PWSTR                DependencyDeviceName;
    ///The host disk volume name in the form \\?\Volume{<i>GUID</i>}\ where <i>GUID</i> is the <b>GUID</b> that
    ///identifies the volume.
    PWSTR                HostVolumeName;
    ///The name of the dependent volume, if any, in the form \\?\Volume{<i>GUID</i>}\ where <i>GUID</i> is the
    ///<b>GUID</b> that identifies the volume.
    PWSTR                DependentVolumeName;
    ///The relative path to the dependent volume.
    PWSTR                DependentVolumeRelativePath;
}

///Contains virtual hard disk (VHD) storage dependency information.
struct STORAGE_DEPENDENCY_INFO
{
    ///A [STORAGE_DEPENDENCY_INFO_TYPE_1](./ns-virtdisk-storage_dependency_info_type_1.md) or
    ///[STORAGE_DEPENDENCY_INFO_TYPE_2](./ns-virtdisk-storage_dependency_info_type_2.md).
    STORAGE_DEPENDENCY_INFO_VERSION Version;
    ///Number of entries returned in the following unioned members.
    uint NumberEntries;
union
    {
        STORAGE_DEPENDENCY_INFO_TYPE_1 Version1Entries;
        STORAGE_DEPENDENCY_INFO_TYPE_2 Version2Entries;
    }
}

///Contains virtual hard disk (VHD) information.
struct GET_VIRTUAL_DISK_INFO
{
    ///A value of the GET_VIRTUAL_DISK_INFO_VERSION enumeration that specifies the version of the
    ///<b>GET_VIRTUAL_DISK_INFO</b> structure being passed to or from the virtual disk functions. This determines what
    ///parts of this structure will be used.
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

///Contains virtual hard disk (VHD) information to use when you call the SetVirtualDiskInformation function to set VHD
///properties.
struct SET_VIRTUAL_DISK_INFO
{
    ///A SET_VIRTUAL_DISK_INFO_VERSION enumeration that specifies the version of the <b>SET_VIRTUAL_DISK_INFO</b>
    ///structure being passed to or from the VHD functions. This determines the type of information set.
    SET_VIRTUAL_DISK_INFO_VERSION Version;
union
    {
        const(PWSTR) ParentFilePath;
        GUID         UniqueIdentifier;
struct ParentPathWithDepthInfo
        {
            uint         ChildDepth;
            const(PWSTR) ParentFilePath;
        }
        uint         VhdPhysicalSectorSize;
        GUID         VirtualDiskId;
        BOOL         ChangeTrackingEnabled;
struct ParentLocator
        {
            GUID         LinkageId;
            const(PWSTR) ParentFilePath;
        }
    }
}

///Contains the progress and result data for the current virtual hard disk (VHD) operation, used by the
///GetVirtualDiskOperationProgress function.
struct VIRTUAL_DISK_PROGRESS
{
    ///A system error code status value, this member will be <b>ERROR_IO_PENDING</b> if the operation is still in
    ///progress; otherwise, the value is the result code of the completed operation.
    uint  OperationStatus;
    ///The current progress of the operation, used in conjunction with the <b>CompletionValue</b> member. This value is
    ///meaningful only if <b>OperationStatus</b> is <b>ERROR_IO_PENDING</b>.
    ulong CurrentValue;
    ///The value that the <b>CurrentValue</b> member would be if the operation were complete. This value is meaningful
    ///only if <b>OperationStatus</b> is <b>ERROR_IO_PENDING</b>.
    ulong CompletionValue;
}

///Contains virtual hard disk (VHD) compacting parameters.
struct COMPACT_VIRTUAL_DISK_PARAMETERS
{
    ///A COMPACT_VIRTUAL_DISK_VERSION enumeration that specifies the version of the
    ///<b>COMPACT_VIRTUAL_DISK_PARAMETERS</b> structure being passed to or from the VHD functions.
    COMPACT_VIRTUAL_DISK_VERSION Version;
union
    {
struct Version1
        {
            uint Reserved;
        }
    }
}

///Contains virtual hard disk (VHD) merge request parameters.
struct MERGE_VIRTUAL_DISK_PARAMETERS
{
    ///A MERGE_VIRTUAL_DISK_VERSION enumeration that specifies the version of the <b>MERGE_VIRTUAL_DISK_PARAMETERS</b>
    ///structure being passed to or from the VHD functions.
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

///Contains virtual disk expansion request parameters.
struct EXPAND_VIRTUAL_DISK_PARAMETERS
{
    ///An EXPAND_VIRTUAL_DISK_VERSION enumeration value that specifies the version of the
    ///<b>EXPAND_VIRTUAL_DISK_PARAMETERS</b> structure being passed to or from the virtual disk functions.
    EXPAND_VIRTUAL_DISK_VERSION Version;
union
    {
struct Version1
        {
            ulong NewSize;
        }
    }
}

///Contains the parameters for a ResizeVirtualDisk function.
struct RESIZE_VIRTUAL_DISK_PARAMETERS
{
    ///Discriminant for the union containing a value enumerated from the RESIZE_VIRTUAL_DISK_VERSION enumeration.
    RESIZE_VIRTUAL_DISK_VERSION Version;
union
    {
struct Version1
        {
            ulong NewSize;
        }
    }
}

///Contains virtual hard disk (VHD) mirror request parameters.
struct MIRROR_VIRTUAL_DISK_PARAMETERS
{
    ///Indicates the version of this structure to use. Set this to <b>MIRROR_VIRTUAL_DISK_VERSION_1</b> (1).
    MIRROR_VIRTUAL_DISK_VERSION Version;
union
    {
struct Version1
        {
            const(PWSTR) MirrorVirtualDiskPath;
        }
    }
}

///Identifies an area on a virtual hard disk (VHD) that has changed as tracked by resilient change tracking (RCT).
struct QUERY_CHANGES_VIRTUAL_DISK_RANGE
{
    ///The distance from the start of the virtual disk to the beginning of the area of the virtual disk that has
    ///changed, in bytes.
    ulong ByteOffset;
    ///The length of the area of the virtual disk that has changed, in bytes.
    ulong ByteLength;
    ///Reserved.
    ulong Reserved;
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Contains snapshot parameters, indicating information about the new snapshot to be created.
struct TAKE_SNAPSHOT_VHDSET_PARAMETERS
{
    ///A value from the TAKE_SNAPSHOT_VHDSET_VERSION enumeration that is the discriminant for the union.
    TAKE_SNAPSHOT_VHDSET_VERSION Version;
union
    {
struct Version1
        {
            GUID SnapshotId;
        }
    }
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Contains snapshot deletion parameters, designating which snapshot to delete from the VHD Set.
struct DELETE_SNAPSHOT_VHDSET_PARAMETERS
{
    ///A value from the DELETE_SNAPSHOT_VHDSET_VERSION enumeration that is the discriminant for the union.
    DELETE_SNAPSHOT_VHDSET_VERSION Version;
union
    {
struct Version1
        {
            GUID SnapshotId;
        }
    }
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Contains VHD Set modification parameters, indicating how the VHD Set should be altered.
struct MODIFY_VHDSET_PARAMETERS
{
    ///A value from the MODIFY_VHDSET_VERSION enumeration that determines that is the discriminant for the union.
    MODIFY_VHDSET_VERSION Version;
union
    {
struct SnapshotPath
        {
            GUID         SnapshotId;
            const(PWSTR) SnapshotFilePath;
        }
        GUID         SnapshotId;
        const(PWSTR) DefaultFilePath;
    }
}

///Contains snapshot parameters, indicating information about the new snapshot to be applied.
struct APPLY_SNAPSHOT_VHDSET_PARAMETERS
{
    ///An APPLY_SNAPSHOT_VHDSET_VERSION enumeration that specifies the version of the
    ///<b>APPLY_SNAPSHOT_VHDSET_PARAMETERS</b> structure being passed to or from the VHD functions.
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

///Contains raw SCSI virtual disk request parameters.
struct RAW_SCSI_VIRTUAL_DISK_PARAMETERS
{
    ///A RAW_SCSI_VIRTUAL_DISK_VERSION enumeration that specifies the version of the
    ///<b>RAW_SCSI_VIRTUAL_DISK_PARAMETERS</b> structure being passed to or from the VHD functions.
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

///Contains raw SCSI virtual disk response parameters.
struct RAW_SCSI_VIRTUAL_DISK_RESPONSE
{
    ///A [RAW_SCSI_VIRTUAL_DISK_PARAMETERS](./ns-virtdisk-raw_scsi_virtual_disk_parameters.md) structure being passed to
    ///or from the VHD functions.
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
            const(PWSTR) ForkedVirtualDiskPath;
        }
    }
}

// Functions

///Opens a virtual hard disk (VHD) or CD or DVD image file (ISO) for use.
///Params:
///    VirtualStorageType = A pointer to a valid VIRTUAL_STORAGE_TYPE structure.
///    Path = A pointer to a valid path to the virtual disk image to open.
///    VirtualDiskAccessMask = A valid value of the VIRTUAL_DISK_ACCESS_MASK enumeration.
///    Flags = A valid combination of values of the OPEN_VIRTUAL_DISK_FLAG enumeration.
///    Parameters = An optional pointer to a valid OPEN_VIRTUAL_DISK_PARAMETERS structure. Can be <b>NULL</b>.
///    Handle = A pointer to the handle object that represents the open virtual disk.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b> (0) and the <i>Handle</i> parameter contains a
///    valid pointer to the new virtual disk object. If the function fails, the return value is an error code and the
///    value of the <i>Handle</i> parameter is undefined. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint OpenVirtualDisk(VIRTUAL_STORAGE_TYPE* VirtualStorageType, const(PWSTR) Path, 
                     VIRTUAL_DISK_ACCESS_MASK VirtualDiskAccessMask, OPEN_VIRTUAL_DISK_FLAG Flags, 
                     OPEN_VIRTUAL_DISK_PARAMETERS* Parameters, HANDLE* Handle);

///Creates a virtual hard disk (VHD) image file, either using default parameters or using an existing virtual disk or
///physical disk.
///Params:
///    VirtualStorageType = A pointer to a VIRTUAL_STORAGE_TYPE structure that contains the desired disk type and vendor information.
///    Path = A pointer to a valid string that represents the path to the new virtual disk image file.
///    VirtualDiskAccessMask = The VIRTUAL_DISK_ACCESS_MASK value to use when opening the newly created virtual disk file. If the <b>Version</b>
///                            member of the <i>Parameters</i> parameter is set to <b>CREATE_VIRTUAL_DISK_VERSION_2</b> then only the
///                            <b>VIRTUAL_DISK_ACCESS_NONE</b> (0) value may be specified.
///    SecurityDescriptor = An optional pointer to a SECURITY_DESCRIPTOR to apply to the virtual disk image file. If this parameter is
///                         <b>NULL</b>, the parent directory's security descriptor will be used.
///    Flags = Creation flags, which must be a valid combination of the CREATE_VIRTUAL_DISK_FLAG enumeration.
///    ProviderSpecificFlags = Flags specific to the type of virtual disk being created. May be zero if none are required.
///    Parameters = A pointer to a valid CREATE_VIRTUAL_DISK_PARAMETERS structure that contains creation parameter data.
///    Overlapped = An optional pointer to a valid OVERLAPPED structure if asynchronous operation is desired.
///    Handle = A pointer to the handle object that represents the newly created virtual disk.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and the <i>Handle</i> parameter contains a
///    valid pointer to the new virtual disk object. If the function fails, the return value is an error code and the
///    value of the <i>Handle</i> parameter is undefined. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint CreateVirtualDisk(VIRTUAL_STORAGE_TYPE* VirtualStorageType, const(PWSTR) Path, 
                       VIRTUAL_DISK_ACCESS_MASK VirtualDiskAccessMask, void* SecurityDescriptor, 
                       CREATE_VIRTUAL_DISK_FLAG Flags, uint ProviderSpecificFlags, 
                       CREATE_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped, HANDLE* Handle);

///Attaches a virtual hard disk (VHD) or CD or DVD image file (ISO) by locating an appropriate VHD provider to
///accomplish the attachment.
///Params:
///    VirtualDiskHandle = A handle to an open virtual disk. For information on how to open a virtual disk, see the OpenVirtualDisk
///                        function.
///    SecurityDescriptor = An optional pointer to a SECURITY_DESCRIPTOR to apply to the attached virtual disk. If this parameter is
///                         <b>NULL</b>, the security descriptor of the virtual disk image file is used. Ensure that the security descriptor
///                         that <b>AttachVirtualDisk</b> applies to the attached virtual disk grants the write attributes permission for the
///                         user, or that the security descriptor of the virtual disk image file grants the write attributes permission for
///                         the user if you specify NULL for this parameter. If the security descriptor does not grant write attributes
///                         permission for a user, Shell displays the following error when the user accesses the attached virtual disk:
///                         <b>The Recycle Bin is corrupted. Do you want to empty the Recycle Bin for this drive?</b>
///    Flags = A valid combination of values of the ATTACH_VIRTUAL_DISK_FLAG enumeration.
///    ProviderSpecificFlags = Flags specific to the type of virtual disk being attached. May be zero if none are required.
///    Parameters = A pointer to a valid ATTACH_VIRTUAL_DISK_PARAMETERS structure that contains attachment parameter data.
///    Overlapped = An optional pointer to a valid OVERLAPPED structure if asynchronous operation is desired.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint AttachVirtualDisk(HANDLE VirtualDiskHandle, void* SecurityDescriptor, ATTACH_VIRTUAL_DISK_FLAG Flags, 
                       uint ProviderSpecificFlags, ATTACH_VIRTUAL_DISK_PARAMETERS* Parameters, 
                       OVERLAPPED* Overlapped);

///Detaches a virtual hard disk (VHD) or CD or DVD image file (ISO) by locating an appropriate virtual disk provider to
///accomplish the operation.
///Params:
///    VirtualDiskHandle = A handle to an open virtual disk, which must have been opened using the <b>VIRTUAL_DISK_ACCESS_DETACH</b> flag
///                        set in the <i>VirtualDiskAccessMask</i> parameter to the OpenVirtualDisk function. For information on how to open
///                        a virtual disk, see the <b>OpenVirtualDisk</b> function.
///    Flags = A valid combination of values of the DETACH_VIRTUAL_DISK_FLAG enumeration.
///    ProviderSpecificFlags = Flags specific to the type of virtual disk being detached. May be zero if none are required.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint DetachVirtualDisk(HANDLE VirtualDiskHandle, DETACH_VIRTUAL_DISK_FLAG Flags, uint ProviderSpecificFlags);

///Retrieves the path to the physical device object that contains a virtual hard disk (VHD) or CD or DVD image file
///(ISO).
///Params:
///    VirtualDiskHandle = A handle to the open virtual disk, which must have been opened using the <b>VIRTUAL_DISK_ACCESS_GET_INFO</b>
///                        flag. For information on how to open a virtual disk, see the OpenVirtualDisk function.
///    DiskPathSizeInBytes = The size, in bytes, of the buffer pointed to by the <i>DiskPath</i> parameter.
///    DiskPath = A target buffer to receive the path of the physical disk device that contains the virtual disk.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and the <i>DiskPath</i>
///    parameter contains a pointer to a populated string. If the function fails, the return value is an error code and
///    the value of the contents of the buffer referred to by the <i>DiskPath</i> parameter is undefined. For more
///    information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint GetVirtualDiskPhysicalPath(HANDLE VirtualDiskHandle, uint* DiskPathSizeInBytes, PWSTR DiskPath);

@DllImport("VirtDisk")
uint GetAllAttachedVirtualDiskPhysicalPaths(uint* PathsBufferSizeInBytes, PWSTR PathsBuffer);

///Returns the relationships between virtual hard disks (VHDs) or CD or DVD image file (ISO) or the volumes contained
///within those disks and their parent disk or volume.
///Params:
///    ObjectHandle = A handle to a volume or root directory if the <i>Flags</i> parameter does not specify the
///                   <b>GET_STORAGE_DEPENDENCY_FLAG_DISK_HANDLE</b> flag. For information on how to open a volume or root directory,
///                   see the CreateFile function. If the <i>Flags</i> parameter specifies the
///                   <b>GET_STORAGE_DEPENDENCY_FLAG_DISK_HANDLE</b> flag, this handle should be a handle to a disk.
///    Flags = A valid combination of GET_STORAGE_DEPENDENCY_FLAG values.
///    StorageDependencyInfoSize = Size, in bytes, of the buffer that the <i>StorageDependencyInfo</i> parameter refers to.
///    StorageDependencyInfo = A pointer to a buffer to receive the populated
///                            [STORAGE_DEPENDENCY_INFO](./ns-virtdisk-storage_dependency_info.md) structure, which is a variable-length
///                            structure.
///    SizeUsed = An optional pointer to a <b>ULONG</b> that receives the size used.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and the
///    <i>StorageDependencyInfo</i> parameter contains the requested dependency information. If the function fails, the
///    return value is an error code and the <i>StorageDependencyInfo</i> parameter is undefined. For more information,
///    see System Error Codes.
///    
@DllImport("VirtDisk")
uint GetStorageDependencyInformation(HANDLE ObjectHandle, GET_STORAGE_DEPENDENCY_FLAG Flags, 
                                     uint StorageDependencyInfoSize, STORAGE_DEPENDENCY_INFO* StorageDependencyInfo, 
                                     uint* SizeUsed);

///Retrieves information about a virtual hard disk (VHD).
///Params:
///    VirtualDiskHandle = A handle to the open VHD, which must have been opened using the <b>VIRTUAL_DISK_ACCESS_GET_INFO</b> flag set in
///                        the <i>VirtualDiskAccessMask</i> parameter to the OpenVirtualDisk function. For information on how to open a VHD,
///                        see the <b>OpenVirtualDisk</b> function.
///    VirtualDiskInfoSize = A pointer to a <b>ULONG</b> that contains the size of the <i>VirtualDiskInfo</i> parameter.
///    VirtualDiskInfo = A pointer to a valid [GET_VIRTUAL_DISK_INFO](./ns-virtdisk-get_virtual_disk_info.md) structure. The format of the
///                      data returned is dependent on the value passed in the <b>Version</b> member by the caller.
///    SizeUsed = A pointer to a <b>ULONG</b> that contains the size used.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and the
///    <i>VirtualDiskInfo</i> parameter contains the requested information. If the function fails, the return value is
///    an error code and the <i>VirtualDiskInfo</i> parameter is undefined. For more information, see System Error
///    Codes.
///    
@DllImport("VirtDisk")
uint GetVirtualDiskInformation(HANDLE VirtualDiskHandle, uint* VirtualDiskInfoSize, 
                               GET_VIRTUAL_DISK_INFO* VirtualDiskInfo, uint* SizeUsed);

///Sets information about a virtual hard disk (VHD).
///Params:
///    VirtualDiskHandle = A handle to the open virtual disk, which must have been opened using the <b>VIRTUAL_DISK_ACCESS_METAOPS</b> flag.
///                        For information on how to open a virtual disk, see the OpenVirtualDisk function.
///    VirtualDiskInfo = A pointer to a valid [SET_VIRTUAL_DISK_INFO](./ns-virtdisk-set_virtual_disk_info.md) structure.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint SetVirtualDiskInformation(HANDLE VirtualDiskHandle, SET_VIRTUAL_DISK_INFO* VirtualDiskInfo);

///Enumerates the metadata associated with a virtual disk.
///Params:
///    VirtualDiskHandle = Handle to an open virtual disk.
///    NumberOfItems = Address of a <b>ULONG</b>. On input, the value indicates the number of elements in the buffer pointed to by the
///                    <i>Items</i> parameter. On output, the value contains the number of items retrieved. If the buffer was too small,
///                    the API will fail and return <b>ERROR_INSUFFICIENT_BUFFER</b> and the <b>ULONG</b> will contain the required
///                    buffer size.
///    Items = Address of a buffer to be filled with the <b>GUID</b>s representing the metadata. The GetVirtualDiskMetadata
///            function can be used to retrieve the data represented by each <b>GUID</b>.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the buffer pointed
///    to by the <i>Items</i> parameter was too small, the return value is <b>ERROR_INSUFFICIENT_BUFFER</b>. If the
///    function fails, the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint EnumerateVirtualDiskMetadata(HANDLE VirtualDiskHandle, uint* NumberOfItems, GUID* Items);

///Retrieves the specified metadata from the virtual disk.
///Params:
///    VirtualDiskHandle = Handle to an open virtual disk.
///    Item = Address of a <b>GUID</b> identifying the metadata to retrieve.
///    MetaDataSize = Address of a <b>ULONG</b>. On input, the value indicates the size, in bytes, of the buffer pointed to by the
///                   <i>MetaData</i> parameter. On output, the value contains size, in bytes, of the retrieved metadata. If the buffer
///                   was too small, the API will fail and return <b>ERROR_INSUFFICIENT_BUFFER</b>, putting the required size in the
///                   <b>ULONG</b> and the buffer will contain the start of the metadata.
///    MetaData = Address of the buffer where the metadata is to be stored.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the buffer pointed
///    to by the <i>Items</i> parameter was too small, the return value is <b>ERROR_INSUFFICIENT_BUFFER</b>. If the
///    function fails, the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint GetVirtualDiskMetadata(HANDLE VirtualDiskHandle, const(GUID)* Item, uint* MetaDataSize, void* MetaData);

///Sets a metadata item for a virtual disk.
///Params:
///    VirtualDiskHandle = Handle to an open virtual disk.
///    Item = Address of a <b>GUID</b> identifying the metadata to retrieve.
///    MetaDataSize = Address of a <b>ULONG</b> containing the size, in bytes, of the buffer pointed to by the <i>MetaData</i>
///                   parameter.
///    MetaData = Address of the buffer containing the metadata to be stored.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint SetVirtualDiskMetadata(HANDLE VirtualDiskHandle, const(GUID)* Item, uint MetaDataSize, const(void)* MetaData);

///Deletes metadata from a virtual disk.
///Params:
///    VirtualDiskHandle = A handle to the open virtual disk.
///    Item = The item to be deleted.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint DeleteVirtualDiskMetadata(HANDLE VirtualDiskHandle, const(GUID)* Item);

///Checks the progress of an asynchronous virtual hard disk (VHD) operation.
///Params:
///    VirtualDiskHandle = A valid handle to a virtual disk with a pending asynchronous operation.
///    Overlapped = A pointer to a valid OVERLAPPED structure. This parameter must reference the same structure previously sent to
///                 the virtual disk operation being checked for progress.
///    Progress = A pointer to a VIRTUAL_DISK_PROGRESS structure that receives the current virtual disk operation progress.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and the <i>Progress</i>
///    parameter will be populated with the current virtual disk operation progress. If the function fails, the return
///    value is an error code and the value of the <i>Progress</i> parameter is undefined. For more information, see
///    System Error Codes.
///    
@DllImport("VirtDisk")
uint GetVirtualDiskOperationProgress(HANDLE VirtualDiskHandle, OVERLAPPED* Overlapped, 
                                     VIRTUAL_DISK_PROGRESS* Progress);

///Reduces the size of a virtual hard disk (VHD) backing store file.
///Params:
///    VirtualDiskHandle = A handle to the open virtual disk, which must have been opened using the <b>VIRTUAL_DISK_ACCESS_METAOPS</b> flag
///                        in the <i>VirtualDiskAccessMask</i> parameter passed to OpenVirtualDisk. For information on how to open a virtual
///                        disk, see the <b>OpenVirtualDisk</b> function.
///    Flags = Must be the <b>COMPACT_VIRTUAL_DISK_FLAG_NONE</b> value (0) of the COMPACT_VIRTUAL_DISK_FLAG enumeration.
///    Parameters = A optional pointer to a valid COMPACT_VIRTUAL_DISK_PARAMETERS structure that contains compaction parameter data.
///    Overlapped = An optional pointer to a valid OVERLAPPED structure if asynchronous operation is desired.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint CompactVirtualDisk(HANDLE VirtualDiskHandle, COMPACT_VIRTUAL_DISK_FLAG Flags, 
                        COMPACT_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped);

///Merges a child virtual hard disk (VHD) in a differencing chain with one or more parent virtual disks in the chain.
///Params:
///    VirtualDiskHandle = A handle to the open virtual disk, which must have been opened using the <b>VIRTUAL_DISK_ACCESS_METAOPS</b> flag.
///                        For information on how to open a virtual disk, see the OpenVirtualDisk function.
///    Flags = Must be the <b>MERGE_VIRTUAL_DISK_FLAG_NONE</b> value of the MERGE_VIRTUAL_DISK_FLAG enumeration.
///    Parameters = A pointer to a valid MERGE_VIRTUAL_DISK_PARAMETERS structure that contains merge parameter data.
///    Overlapped = An optional pointer to a valid OVERLAPPED structure if asynchronous operation is desired.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint MergeVirtualDisk(HANDLE VirtualDiskHandle, MERGE_VIRTUAL_DISK_FLAG Flags, 
                      MERGE_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped);

///Increases the size of a fixed or dynamically expandable virtual hard disk (VHD).
///Params:
///    VirtualDiskHandle = A handle to the open virtual disk, which must have been opened using the <b>VIRTUAL_DISK_ACCESS_METAOPS</b> flag.
///                        For information on how to open a virtual disk, see the OpenVirtualDisk function.
///    Flags = Must be the <b>EXPAND_VIRTUAL_DISK_FLAG_NONE</b> value of the EXPAND_VIRTUAL_DISK_FLAG enumeration.
///    Parameters = A pointer to a valid EXPAND_VIRTUAL_DISK_PARAMETERS structure that contains expansion parameter data.
///    Overlapped = An optional pointer to a valid OVERLAPPED structure if asynchronous operation is desired.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint ExpandVirtualDisk(HANDLE VirtualDiskHandle, EXPAND_VIRTUAL_DISK_FLAG Flags, 
                       EXPAND_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped);

///Resizes a virtual disk.
///Params:
///    VirtualDiskHandle = Handle to an open virtual disk.
///    Flags = Zero or more flags enumerated from the RESIZE_VIRTUAL_DISK_FLAG enumeration.
///    Parameters = Address of a RESIZE_VIRTUAL_DISK_PARAMETERS structure containing the new size of the virtual disk.
///    Overlapped = If this is to be an asynchronous operation, the address of a valid OVERLAPPED structure.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint ResizeVirtualDisk(HANDLE VirtualDiskHandle, RESIZE_VIRTUAL_DISK_FLAG Flags, 
                       RESIZE_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped);

///Initiates a mirror operation for a virtual disk. Once the mirroring operation is initiated it will not complete until
///either CancelIo or CancelIoEx is called to cancel all I/O on the <i>VirtualDiskHandle</i>, leaving the original file
///as the current or BreakMirrorVirtualDisk is called to stop using the original file and only use the mirror.
///GetVirtualDiskOperationProgress can be used to determine if the disks are fully mirrored and writes go to both
///virtual disks.
///Params:
///    VirtualDiskHandle = A handle to the open virtual disk. For information on how to open a virtual disk, see the OpenVirtualDisk
///                        function.
///    Flags = A valid combination of values from the MIRROR_VIRTUAL_DISK_FLAG enumeration. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIRROR_VIRTUAL_DISK_FLAG_NONE"></a><a
///            id="mirror_virtual_disk_flag_none"></a><dl> <dt><b>MIRROR_VIRTUAL_DISK_FLAG_NONE</b></dt> <dt>0x00000000</dt>
///            </dl> </td> <td width="60%"> The mirror virtual disk file does not exist, and needs to be created. </td> </tr>
///            <tr> <td width="40%"><a id="MIRROR_VIRTUAL_DISK_FLAG_EXISTING_FILE"></a><a
///            id="mirror_virtual_disk_flag_existing_file"></a><dl> <dt><b>MIRROR_VIRTUAL_DISK_FLAG_EXISTING_FILE</b></dt>
///            <dt>0x00000001</dt> </dl> </td> <td width="60%"> Create the mirror using an existing file. </td> </tr> </table>
///    Parameters = Address of a MIRROR_VIRTUAL_DISK_PARAMETERS structure containing mirror parameter data.
///    Overlapped = Address of an OVERLAPPEDstructure. This parameter is required.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint MirrorVirtualDisk(HANDLE VirtualDiskHandle, MIRROR_VIRTUAL_DISK_FLAG Flags, 
                       MIRROR_VIRTUAL_DISK_PARAMETERS* Parameters, OVERLAPPED* Overlapped);

///Breaks a previously initiated mirror operation and sets the mirror to be the active virtual disk.
///Params:
///    VirtualDiskHandle = A handle to the open mirrored virtual disk. For information on how to open a virtual disk, see the
///                        OpenVirtualDisk function. For information on how to mirror a virtual disk, see the MirrorVirtualDisk function.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint BreakMirrorVirtualDisk(HANDLE VirtualDiskHandle);

///Attaches a parent to a virtual disk opened with the <b>OPEN_VIRTUAL_DISK_FLAG_CUSTOM_DIFF_CHAIN</b> flag.
///Params:
///    VirtualDiskHandle = Handle to a virtual disk.
///    ParentPath = Address of a string containing a valid path to the virtual hard disk image to add as a parent.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint AddVirtualDiskParent(HANDLE VirtualDiskHandle, const(PWSTR) ParentPath);

///Retrieves information about changes to the specified areas of a virtual hard disk (VHD) that are tracked by resilient
///change tracking (RCT).
///Params:
///    VirtualDiskHandle = A handle to the open VHD, which must have been opened using the <b>VIRTUAL_DISK_ACCESS_GET_INFO</b> flag set in
///                        the <i>VirtualDiskAccessMask</i> parameter to the OpenVirtualDisk function. For information on how to open a VHD,
///                        see the <b>OpenVirtualDisk</b> function.
///    ChangeTrackingId = A pointer to a string that specifies the change tracking identifier for the change that identifies the state of
///                       the virtual disk that you want to use as the basis of comparison to determine whether the specified area of the
///                       VHD has changed.
///    ByteOffset = An unsigned long integer that specifies the distance from the start of the VHD to the beginning of the area of
///                 the VHD that you want to check for changes, in bytes.
///    ByteLength = An unsigned long integer that specifies the length of the area of the VHD that you want to check for changes, in
///                 bytes.
///    Flags = Reserved. Set to <b>QUERY_CHANGES_VIRTUAL_DISK_FLAG_NONE</b>.
///    Ranges = An array of QUERY_CHANGES_VIRTUAL_DISK_RANGE structures that indicates the areas of the virtual disk within the
///             area that the <i>ByteOffset</i> and <i>ByteLength</i> parameters specify that have changed since the change
///             tracking identifier that the <i>ChangeTrackingId</i> parameter specifies was sealed.
///    RangeCount = An address of an unsigned long integer. On input, the value indicates the number of
///                 QUERY_CHANGES_VIRTUAL_DISK_RANGE structures that the array that the <i>Ranges</i> parameter points to can hold.
///                 On output, the value contains the number of <b>QUERY_CHANGES_VIRTUAL_DISK_RANGE</b> structures that the method
///                 placed in the array.
///    ProcessedLength = A pointer to an unsigned long integer that indicates the total number of bytes that the method processed, which
///                      indicates for how much of the area that the <i>BytesLength</i> parameter specifies that changes were captured in
///                      the available space of the array that the <i>Ranges</i> parameter specifies.
///Returns:
///    The status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and the
///    <i>Ranges</i> parameter contains the requested information. If the function fails, the return value is an error
///    code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint QueryChangesVirtualDisk(HANDLE VirtualDiskHandle, const(PWSTR) ChangeTrackingId, ulong ByteOffset, 
                             ulong ByteLength, QUERY_CHANGES_VIRTUAL_DISK_FLAG Flags, 
                             QUERY_CHANGES_VIRTUAL_DISK_RANGE* Ranges, uint* RangeCount, ulong* ProcessedLength);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Creates a snapshot of the current virtual disk for VHD Set files.
///Params:
///    VirtualDiskHandle = A handle to the open virtual disk. This must be a VHD Set file.
///    Parameters = A pointer to a valid TAKE_SNAPSHOT_VHDSET_PARAMETERS structure that contains snapshot data.
///    Flags = Snapshot flags, which must be a valid combination of the TAKE_SNAPSHOT_VHDSET_FLAG enumeration
@DllImport("VirtDisk")
uint TakeSnapshotVhdSet(HANDLE VirtualDiskHandle, const(TAKE_SNAPSHOT_VHDSET_PARAMETERS)* Parameters, 
                        TAKE_SNAPSHOT_VHDSET_FLAG Flags);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Deletes a snapshot from a VHD Set file.
///Params:
///    VirtualDiskHandle = A handle to the open virtual disk. This must be a VHD Set file.
///    Parameters = A pointer to a valid DELETE_SNAPSHOT_VHDSET_PARAMETERS structure that contains snapshot deletion data.
///    Flags = Snapshot deletion flags, which must be a valid combination of the DELETE_SNAPSHOT_VHDSET_FLAG enumeration.
@DllImport("VirtDisk")
uint DeleteSnapshotVhdSet(HANDLE VirtualDiskHandle, const(DELETE_SNAPSHOT_VHDSET_PARAMETERS)* Parameters, 
                          DELETE_SNAPSHOT_VHDSET_FLAG Flags);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Modifies the internal contents of a virtual disk file. Can be used to set the active leaf, or to fix
///up snapshot entries.
///Params:
///    VirtualDiskHandle = A handle to the open virtual disk. This must be a VHD Set file.
///    Parameters = A pointer to a valid MODIFY_VHDSET_PARAMETERS structure that contains modification data.
///    Flags = Modification flags, which must be a valid combination of the MODIFY_VHDSET_FLAG enumeration.
@DllImport("VirtDisk")
uint ModifyVhdSet(HANDLE VirtualDiskHandle, const(MODIFY_VHDSET_PARAMETERS)* Parameters, MODIFY_VHDSET_FLAG Flags);

///Applies a snapshot of the current virtual disk for VHD Set files.
///Params:
///    VirtualDiskHandle = A handle to an open virtual disk. For information on how to open a virtual disk, see the OpenVirtualDisk
///                        function.
///    Parameters = A pointer to a valid APPLY_SNAPSHOT_VHDSET_PARAMETERS structure that contains snapshot data.
///    Flags = A valid combination of values of the APPLY_SNAPSHOT_VHDSET_FLAG enumeration.
///Returns:
///    Status of the request. If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value is an error code. For more information, see System Error Codes.
///    
@DllImport("VirtDisk")
uint ApplySnapshotVhdSet(HANDLE VirtualDiskHandle, const(APPLY_SNAPSHOT_VHDSET_PARAMETERS)* Parameters, 
                         APPLY_SNAPSHOT_VHDSET_FLAG Flags);

///Issues an embedded SCSI request directly to a virtual hard disk.
///Params:
///    VirtualDiskHandle = A handle to an open virtual disk. For information on how to open a virtual disk, see the OpenVirtualDisk
///                        function. This handle may also be a handle to a Remote Shared Virtual Disk. For information on how to open a
///                        Remote Shared Virtual Disk, see the Remote Shared Virtual Disk Protocol documentation.
///    Parameters = A pointer to a valid RAW_SCSI_VIRTUAL_DISK_PARAMETERS structure that contains snapshot deletion data.
///    Flags = SCSI virtual disk flags, which must be a valid combination of the RAW_SCSI_VIRTUAL_DISK_FLAG enumeration.
///    Response = A pointer to a RAW_SCSI_VIRTUAL_DISK_RESPONSE structure that contains the results of processing the SCSI command.
@DllImport("VirtDisk")
uint RawSCSIVirtualDisk(HANDLE VirtualDiskHandle, const(RAW_SCSI_VIRTUAL_DISK_PARAMETERS)* Parameters, 
                        RAW_SCSI_VIRTUAL_DISK_FLAG Flags, RAW_SCSI_VIRTUAL_DISK_RESPONSE* Response);

@DllImport("VirtDisk")
uint ForkVirtualDisk(HANDLE VirtualDiskHandle, FORK_VIRTUAL_DISK_FLAG Flags, 
                     const(FORK_VIRTUAL_DISK_PARAMETERS)* Parameters, OVERLAPPED* Overlapped);

@DllImport("VirtDisk")
uint CompleteForkVirtualDisk(HANDLE VirtualDiskHandle);


