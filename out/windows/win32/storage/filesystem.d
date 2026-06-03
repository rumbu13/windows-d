// Written in the D programming language.

module windows.win32.storage.filesystem;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, CHAR, FILETIME, HANDLE,
                                         HRESULT, PSTR, PWSTR, SYSTEMTIME;
public import windows.win32.security.cryptography : ALG_ID;
public import windows.win32.security : GENERIC_MAPPING, PRIVILEGE_SET, PSECURITY_DESCRIPTOR,
                                       PSID, SECURITY_ATTRIBUTES, SID;
public import windows.win32.system.com : IConnectionPointContainer, IUnknown;
public import windows.win32.system.io : LPOVERLAPPED_COMPLETION_ROUTINE, OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


alias FIND_FIRST_EX_FLAGS = uint;
enum : uint
{
    FIND_FIRST_EX_CASE_SENSITIVE       = 0x00000001U,
    FIND_FIRST_EX_LARGE_FETCH          = 0x00000002U,
    FIND_FIRST_EX_ON_DISK_ENTRIES_ONLY = 0x00000004U,
}

alias DEFINE_DOS_DEVICE_FLAGS = uint;
enum : uint
{
    DDD_RAW_TARGET_PATH       = 0x00000001U,
    DDD_REMOVE_DEFINITION     = 0x00000002U,
    DDD_EXACT_MATCH_ON_REMOVE = 0x00000004U,
    DDD_NO_BROADCAST_SYSTEM   = 0x00000008U,
    DDD_LUID_BROADCAST_DRIVE  = 0x00000010U,
}

alias FILE_FLAGS_AND_ATTRIBUTES = uint;
enum : uint
{
    FILE_ATTRIBUTE_READONLY              = 0x00000001U,
    FILE_ATTRIBUTE_HIDDEN                = 0x00000002U,
    FILE_ATTRIBUTE_SYSTEM                = 0x00000004U,
    FILE_ATTRIBUTE_DIRECTORY             = 0x00000010U,
    FILE_ATTRIBUTE_ARCHIVE               = 0x00000020U,
    FILE_ATTRIBUTE_DEVICE                = 0x00000040U,
    FILE_ATTRIBUTE_NORMAL                = 0x00000080U,
    FILE_ATTRIBUTE_TEMPORARY             = 0x00000100U,
    FILE_ATTRIBUTE_SPARSE_FILE           = 0x00000200U,
    FILE_ATTRIBUTE_REPARSE_POINT         = 0x00000400U,
    FILE_ATTRIBUTE_COMPRESSED            = 0x00000800U,
    FILE_ATTRIBUTE_OFFLINE               = 0x00001000U,
    FILE_ATTRIBUTE_NOT_CONTENT_INDEXED   = 0x00002000U,
    FILE_ATTRIBUTE_ENCRYPTED             = 0x00004000U,
    FILE_ATTRIBUTE_INTEGRITY_STREAM      = 0x00008000U,
    FILE_ATTRIBUTE_VIRTUAL               = 0x00010000U,
    FILE_ATTRIBUTE_NO_SCRUB_DATA         = 0x00020000U,
    FILE_ATTRIBUTE_EA                    = 0x00040000U,
    FILE_ATTRIBUTE_PINNED                = 0x00080000U,
    FILE_ATTRIBUTE_UNPINNED              = 0x00100000U,
    FILE_ATTRIBUTE_RECALL_ON_OPEN        = 0x00040000U,
    FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS = 0x00400000U,
    FILE_FLAG_WRITE_THROUGH              = 0x80000000U,
    FILE_FLAG_OVERLAPPED                 = 0x40000000U,
    FILE_FLAG_NO_BUFFERING               = 0x20000000U,
    FILE_FLAG_RANDOM_ACCESS              = 0x10000000U,
    FILE_FLAG_SEQUENTIAL_SCAN            = 0x08000000U,
    FILE_FLAG_DELETE_ON_CLOSE            = 0x04000000U,
    FILE_FLAG_BACKUP_SEMANTICS           = 0x02000000U,
    FILE_FLAG_POSIX_SEMANTICS            = 0x01000000U,
    FILE_FLAG_SESSION_AWARE              = 0x00800000U,
    FILE_FLAG_OPEN_REPARSE_POINT         = 0x00200000U,
    FILE_FLAG_OPEN_NO_RECALL             = 0x00100000U,
    FILE_FLAG_FIRST_PIPE_INSTANCE        = 0x00080000U,
    PIPE_ACCESS_DUPLEX                   = 0x00000003U,
    PIPE_ACCESS_INBOUND                  = 0x00000001U,
    PIPE_ACCESS_OUTBOUND                 = 0x00000002U,
    SECURITY_ANONYMOUS                   = 0x00000000U,
    SECURITY_IDENTIFICATION              = 0x00010000U,
    SECURITY_IMPERSONATION               = 0x00020000U,
    SECURITY_DELEGATION                  = 0x00030000U,
    SECURITY_CONTEXT_TRACKING            = 0x00040000U,
    SECURITY_EFFECTIVE_ONLY              = 0x00080000U,
    SECURITY_SQOS_PRESENT                = 0x00100000U,
    SECURITY_VALID_SQOS_FLAGS            = 0x001f0000U,
}

alias FILE_ACCESS_RIGHTS = uint;
enum : uint
{
    FILE_READ_DATA            = 0x00000001U,
    FILE_LIST_DIRECTORY       = 0x00000001U,
    FILE_WRITE_DATA           = 0x00000002U,
    FILE_ADD_FILE             = 0x00000002U,
    FILE_APPEND_DATA          = 0x00000004U,
    FILE_ADD_SUBDIRECTORY     = 0x00000004U,
    FILE_CREATE_PIPE_INSTANCE = 0x00000004U,
    FILE_READ_EA              = 0x00000008U,
    FILE_WRITE_EA             = 0x00000010U,
    FILE_EXECUTE              = 0x00000020U,
    FILE_TRAVERSE             = 0x00000020U,
    FILE_DELETE_CHILD         = 0x00000040U,
    FILE_READ_ATTRIBUTES      = 0x00000080U,
    FILE_WRITE_ATTRIBUTES     = 0x00000100U,
    DELETE                    = 0x00010000U,
    READ_CONTROL              = 0x00020000U,
    WRITE_DAC                 = 0x00040000U,
    WRITE_OWNER               = 0x00080000U,
    SYNCHRONIZE               = 0x00100000U,
    STANDARD_RIGHTS_REQUIRED  = 0x000f0000U,
    STANDARD_RIGHTS_READ      = 0x00020000U,
    STANDARD_RIGHTS_WRITE     = 0x00020000U,
    STANDARD_RIGHTS_EXECUTE   = 0x00020000U,
    STANDARD_RIGHTS_ALL       = 0x001f0000U,
    SPECIFIC_RIGHTS_ALL       = 0x0000ffffU,
    FILE_ALL_ACCESS           = 0x001f01ffU,
    FILE_GENERIC_READ         = 0x00120089U,
    FILE_GENERIC_WRITE        = 0x00120116U,
    FILE_GENERIC_EXECUTE      = 0x001200a0U,
}

alias GET_FILE_VERSION_INFO_FLAGS = uint;
enum : uint
{
    FILE_VER_GET_LOCALISED  = 0x00000001U,
    FILE_VER_GET_NEUTRAL    = 0x00000002U,
    FILE_VER_GET_PREFETCHED = 0x00000004U,
}

alias VER_FIND_FILE_FLAGS = uint;
enum : uint
{
    VFFF_ISSHAREDFILE = 0x00000001U,
}

alias VER_FIND_FILE_STATUS = uint;
enum : uint
{
    VFF_CURNEDEST    = 0x00000001U,
    VFF_FILEINUSE    = 0x00000002U,
    VFF_BUFFTOOSMALL = 0x00000004U,
}

alias VER_INSTALL_FILE_FLAGS = uint;
enum : uint
{
    VIFF_FORCEINSTALL  = 0x00000001U,
    VIFF_DONTDELETEOLD = 0x00000002U,
}

alias VER_INSTALL_FILE_STATUS = uint;
enum : uint
{
    VIF_TEMPFILE          = 0x00000001U,
    VIF_MISMATCH          = 0x00000002U,
    VIF_SRCOLD            = 0x00000004U,
    VIF_DIFFLANG          = 0x00000008U,
    VIF_DIFFCODEPG        = 0x00000010U,
    VIF_DIFFTYPE          = 0x00000020U,
    VIF_WRITEPROT         = 0x00000040U,
    VIF_FILEINUSE         = 0x00000080U,
    VIF_OUTOFSPACE        = 0x00000100U,
    VIF_ACCESSVIOLATION   = 0x00000200U,
    VIF_SHARINGVIOLATION  = 0x00000400U,
    VIF_CANNOTCREATE      = 0x00000800U,
    VIF_CANNOTDELETE      = 0x00001000U,
    VIF_CANNOTRENAME      = 0x00002000U,
    VIF_CANNOTDELETECUR   = 0x00004000U,
    VIF_OUTOFMEMORY       = 0x00008000U,
    VIF_CANNOTREADSRC     = 0x00010000U,
    VIF_CANNOTREADDST     = 0x00020000U,
    VIF_BUFFTOOSMALL      = 0x00040000U,
    VIF_CANNOTLOADLZ32    = 0x00080000U,
    VIF_CANNOTLOADCABINET = 0x00100000U,
}

alias VS_FIXEDFILEINFO_FILE_FLAGS = uint;
enum : uint
{
    VS_FF_DEBUG        = 0x00000001U,
    VS_FF_PRERELEASE   = 0x00000002U,
    VS_FF_PATCHED      = 0x00000004U,
    VS_FF_PRIVATEBUILD = 0x00000008U,
    VS_FF_INFOINFERRED = 0x00000010U,
    VS_FF_SPECIALBUILD = 0x00000020U,
}

alias VS_FIXEDFILEINFO_FILE_OS = uint;
enum : uint
{
    VOS_UNKNOWN       = 0x00000000U,
    VOS_DOS           = 0x00010000U,
    VOS_OS216         = 0x00020000U,
    VOS_OS232         = 0x00030000U,
    VOS_NT            = 0x00040000U,
    VOS_WINCE         = 0x00050000U,
    VOS__BASE         = 0x00000000U,
    VOS__WINDOWS16    = 0x00000001U,
    VOS__PM16         = 0x00000002U,
    VOS__PM32         = 0x00000003U,
    VOS__WINDOWS32    = 0x00000004U,
    VOS_DOS_WINDOWS16 = 0x00010001U,
    VOS_DOS_WINDOWS32 = 0x00010004U,
    VOS_OS216_PM16    = 0x00020002U,
    VOS_OS232_PM32    = 0x00030003U,
    VOS_NT_WINDOWS32  = 0x00040004U,
}

alias VS_FIXEDFILEINFO_FILE_TYPE = int;
enum : int
{
    VFT_UNKNOWN    = 0x00000000,
    VFT_APP        = 0x00000001,
    VFT_DLL        = 0x00000002,
    VFT_DRV        = 0x00000003,
    VFT_FONT       = 0x00000004,
    VFT_VXD        = 0x00000005,
    VFT_STATIC_LIB = 0x00000007,
}

alias VS_FIXEDFILEINFO_FILE_SUBTYPE = int;
enum : int
{
    VFT2_UNKNOWN               = 0x00000000,
    VFT2_DRV_PRINTER           = 0x00000001,
    VFT2_DRV_KEYBOARD          = 0x00000002,
    VFT2_DRV_LANGUAGE          = 0x00000003,
    VFT2_DRV_DISPLAY           = 0x00000004,
    VFT2_DRV_MOUSE             = 0x00000005,
    VFT2_DRV_NETWORK           = 0x00000006,
    VFT2_DRV_SYSTEM            = 0x00000007,
    VFT2_DRV_INSTALLABLE       = 0x00000008,
    VFT2_DRV_SOUND             = 0x00000009,
    VFT2_DRV_COMM              = 0x0000000a,
    VFT2_DRV_INPUTMETHOD       = 0x0000000b,
    VFT2_DRV_VERSIONED_PRINTER = 0x0000000c,
    VFT2_FONT_RASTER           = 0x00000001,
    VFT2_FONT_VECTOR           = 0x00000002,
    VFT2_FONT_TRUETYPE         = 0x00000003,
}

alias FILE_CREATION_DISPOSITION = uint;
enum : uint
{
    CREATE_NEW        = 0x00000001U,
    CREATE_ALWAYS     = 0x00000002U,
    OPEN_EXISTING     = 0x00000003U,
    OPEN_ALWAYS       = 0x00000004U,
    TRUNCATE_EXISTING = 0x00000005U,
}

alias FILE_SHARE_MODE = uint;
enum : uint
{
    FILE_SHARE_NONE   = 0x00000000U,
    FILE_SHARE_DELETE = 0x00000004U,
    FILE_SHARE_READ   = 0x00000001U,
    FILE_SHARE_WRITE  = 0x00000002U,
}

alias SHARE_TYPE = uint;
enum : uint
{
    STYPE_DISKTREE  = 0x00000000U,
    STYPE_PRINTQ    = 0x00000001U,
    STYPE_DEVICE    = 0x00000002U,
    STYPE_IPC       = 0x00000003U,
    STYPE_SPECIAL   = 0x80000000U,
    STYPE_TEMPORARY = 0x40000000U,
    STYPE_MASK      = 0x000000ffU,
}

alias CLFS_FLAG = uint;
enum : uint
{
    CLFS_FLAG_FORCE_APPEND    = 0x00000001U,
    CLFS_FLAG_FORCE_FLUSH     = 0x00000002U,
    CLFS_FLAG_NO_FLAGS        = 0x00000000U,
    CLFS_FLAG_USE_RESERVATION = 0x00000004U,
}

alias SET_FILE_POINTER_MOVE_METHOD = uint;
enum : uint
{
    FILE_BEGIN   = 0x00000000U,
    FILE_CURRENT = 0x00000001U,
    FILE_END     = 0x00000002U,
}

alias MOVE_FILE_FLAGS = uint;
enum : uint
{
    MOVEFILE_COPY_ALLOWED          = 0x00000002U,
    MOVEFILE_CREATE_HARDLINK       = 0x00000010U,
    MOVEFILE_DELAY_UNTIL_REBOOT    = 0x00000004U,
    MOVEFILE_REPLACE_EXISTING      = 0x00000001U,
    MOVEFILE_WRITE_THROUGH         = 0x00000008U,
    MOVEFILE_FAIL_IF_NOT_TRACKABLE = 0x00000020U,
}

alias GETFINALPATHNAMEBYHANDLE_FLAGS = uint;
enum : uint
{
    VOLUME_NAME_DOS      = 0x00000000U,
    VOLUME_NAME_GUID     = 0x00000001U,
    VOLUME_NAME_NT       = 0x00000002U,
    VOLUME_NAME_NONE     = 0x00000004U,
    FILE_NAME_NORMALIZED = 0x00000000U,
    FILE_NAME_OPENED     = 0x00000008U,
}

alias LZOPENFILE_STYLE = ushort;
enum : ushort
{
    OF_CANCEL           = cast(ushort) 0x0800,
    OF_CREATE           = cast(ushort) 0x1000,
    OF_DELETE           = cast(ushort) 0x0200,
    OF_EXIST            = cast(ushort) 0x4000,
    OF_PARSE            = cast(ushort) 0x0100,
    OF_PROMPT           = cast(ushort) 0x2000,
    OF_READ             = cast(ushort) 0x0000,
    OF_READWRITE        = cast(ushort) 0x0002,
    OF_REOPEN           = cast(ushort) 0x8000,
    OF_SHARE_DENY_NONE  = cast(ushort) 0x0040,
    OF_SHARE_DENY_READ  = cast(ushort) 0x0030,
    OF_SHARE_DENY_WRITE = cast(ushort) 0x0020,
    OF_SHARE_EXCLUSIVE  = cast(ushort) 0x0010,
    OF_WRITE            = cast(ushort) 0x0001,
    OF_SHARE_COMPAT     = cast(ushort) 0x0000,
    OF_VERIFY           = cast(ushort) 0x0400,
}

alias FILE_NOTIFY_CHANGE = uint;
enum : uint
{
    FILE_NOTIFY_CHANGE_FILE_NAME   = 0x00000001U,
    FILE_NOTIFY_CHANGE_DIR_NAME    = 0x00000002U,
    FILE_NOTIFY_CHANGE_ATTRIBUTES  = 0x00000004U,
    FILE_NOTIFY_CHANGE_SIZE        = 0x00000008U,
    FILE_NOTIFY_CHANGE_LAST_WRITE  = 0x00000010U,
    FILE_NOTIFY_CHANGE_LAST_ACCESS = 0x00000020U,
    FILE_NOTIFY_CHANGE_CREATION    = 0x00000040U,
    FILE_NOTIFY_CHANGE_SECURITY    = 0x00000100U,
}

alias TXFS_MINIVERSION = uint;
enum : uint
{
    TXFS_MINIVERSION_COMMITTED_VIEW = 0x00000000U,
    TXFS_MINIVERSION_DIRTY_VIEW     = 0x0000ffffU,
    TXFS_MINIVERSION_DEFAULT_VIEW   = 0x0000fffeU,
}

alias TAPE_POSITION_TYPE = uint;
enum : uint
{
    TAPE_ABSOLUTE_POSITION = 0x00000000U,
    TAPE_LOGICAL_POSITION  = 0x00000001U,
}

alias CREATE_TAPE_PARTITION_METHOD = uint;
enum : uint
{
    TAPE_FIXED_PARTITIONS     = 0x00000000U,
    TAPE_INITIATOR_PARTITIONS = 0x00000002U,
    TAPE_SELECT_PARTITIONS    = 0x00000001U,
}

alias REPLACE_FILE_FLAGS = uint;
enum : uint
{
    REPLACEFILE_WRITE_THROUGH       = 0x00000001U,
    REPLACEFILE_IGNORE_MERGE_ERRORS = 0x00000002U,
    REPLACEFILE_IGNORE_ACL_ERRORS   = 0x00000004U,
}

alias TAPEMARK_TYPE = uint;
enum : uint
{
    TAPE_FILEMARKS       = 0x00000001U,
    TAPE_LONG_FILEMARKS  = 0x00000003U,
    TAPE_SETMARKS        = 0x00000000U,
    TAPE_SHORT_FILEMARKS = 0x00000002U,
}

alias DISKQUOTA_USERNAME_RESOLVE = uint;
enum : uint
{
    DISKQUOTA_USERNAME_RESOLVE_ASYNC = 0x00000002U,
    DISKQUOTA_USERNAME_RESOLVE_NONE  = 0x00000000U,
    DISKQUOTA_USERNAME_RESOLVE_SYNC  = 0x00000001U,
}

alias TAPE_POSITION_METHOD = uint;
enum : uint
{
    TAPE_ABSOLUTE_BLOCK        = 0x00000001U,
    TAPE_LOGICAL_BLOCK         = 0x00000002U,
    TAPE_REWIND                = 0x00000000U,
    TAPE_SPACE_END_OF_DATA     = 0x00000004U,
    TAPE_SPACE_FILEMARKS       = 0x00000006U,
    TAPE_SPACE_RELATIVE_BLOCKS = 0x00000005U,
    TAPE_SPACE_SEQUENTIAL_FMKS = 0x00000007U,
    TAPE_SPACE_SEQUENTIAL_SMKS = 0x00000009U,
    TAPE_SPACE_SETMARKS        = 0x00000008U,
}

alias TAPE_INFORMATION_TYPE = uint;
enum : uint
{
    SET_TAPE_DRIVE_INFORMATION = 0x00000001U,
    SET_TAPE_MEDIA_INFORMATION = 0x00000000U,
}

alias NTMS_OMID_TYPE = uint;
enum : uint
{
    NTMS_OMID_TYPE_FILESYSTEM_INFO = 0x00000002U,
    NTMS_OMID_TYPE_RAW_LABEL       = 0x00000001U,
}

alias LOCK_FILE_FLAGS = uint;
enum : uint
{
    LOCKFILE_EXCLUSIVE_LOCK   = 0x00000002U,
    LOCKFILE_FAIL_IMMEDIATELY = 0x00000001U,
}

alias LPPROGRESS_ROUTINE_CALLBACK_REASON = uint;
enum : uint
{
    CALLBACK_CHUNK_FINISHED = 0x00000000U,
    CALLBACK_STREAM_SWITCH  = 0x00000001U,
}

alias PREPARE_TAPE_OPERATION = uint;
enum : uint
{
    TAPE_FORMAT  = 0x00000005U,
    TAPE_LOAD    = 0x00000000U,
    TAPE_LOCK    = 0x00000003U,
    TAPE_TENSION = 0x00000002U,
    TAPE_UNLOAD  = 0x00000001U,
    TAPE_UNLOCK  = 0x00000004U,
}

alias GET_TAPE_DRIVE_PARAMETERS_OPERATION = uint;
enum : uint
{
    GET_TAPE_DRIVE_INFORMATION = 0x00000001U,
    GET_TAPE_MEDIA_INFORMATION = 0x00000000U,
}

alias ERASE_TAPE_TYPE = uint;
enum : uint
{
    TAPE_ERASE_LONG  = 0x00000001U,
    TAPE_ERASE_SHORT = 0x00000000U,
}

alias FILE_ACTION = uint;
enum : uint
{
    FILE_ACTION_ADDED            = 0x00000001U,
    FILE_ACTION_REMOVED          = 0x00000002U,
    FILE_ACTION_MODIFIED         = 0x00000003U,
    FILE_ACTION_RENAMED_OLD_NAME = 0x00000004U,
    FILE_ACTION_RENAMED_NEW_NAME = 0x00000005U,
}

alias SHARE_INFO_PERMISSIONS = uint;
enum : uint
{
    ACCESS_READ   = 0x00000001U,
    ACCESS_WRITE  = 0x00000002U,
    ACCESS_CREATE = 0x00000004U,
    ACCESS_EXEC   = 0x00000008U,
    ACCESS_DELETE = 0x00000010U,
    ACCESS_ATRIB  = 0x00000020U,
    ACCESS_PERM   = 0x00000040U,
    ACCESS_ALL    = 0x00008000U,
}

alias FILE_DEVICE_TYPE = uint;
enum : uint
{
    FILE_DEVICE_CD_ROM = 0x00000002U,
    FILE_DEVICE_DISK   = 0x00000007U,
    FILE_DEVICE_TAPE   = 0x0000001fU,
    FILE_DEVICE_DVD    = 0x00000033U,
}

alias SESSION_INFO_USER_FLAGS = uint;
enum : uint
{
    SESS_GUEST        = 0x00000001U,
    SESS_NOENCRYPTION = 0x00000002U,
}

alias WIN_STREAM_ID = uint;
enum : uint
{
    BACKUP_ALTERNATE_DATA = 0x00000004U,
    BACKUP_DATA           = 0x00000001U,
    BACKUP_EA_DATA        = 0x00000002U,
    BACKUP_LINK           = 0x00000005U,
    BACKUP_OBJECT_ID      = 0x00000007U,
    BACKUP_PROPERTY_DATA  = 0x00000006U,
    BACKUP_REPARSE_DATA   = 0x00000008U,
    BACKUP_SECURITY_DATA  = 0x00000003U,
    BACKUP_SPARSE_BLOCK   = 0x00000009U,
    BACKUP_TXFS_DATA      = 0x0000000aU,
}

alias TXF_LOG_RECORD_TYPE = ushort;
enum : ushort
{
    TXF_LOG_RECORD_TYPE_AFFECTED_FILE = cast(ushort) 0x0004,
    TXF_LOG_RECORD_TYPE_TRUNCATE      = cast(ushort) 0x0002,
    TXF_LOG_RECORD_TYPE_WRITE         = cast(ushort) 0x0001,
}

alias FILE_INFO_FLAGS_PERMISSIONS = uint;
enum : uint
{
    PERM_FILE_READ   = 0x00000001U,
    PERM_FILE_WRITE  = 0x00000002U,
    PERM_FILE_CREATE = 0x00000004U,
}

alias SYMBOLIC_LINK_FLAGS = uint;
enum : uint
{
    SYMBOLIC_LINK_FLAG_DIRECTORY                 = 0x00000001U,
    SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE = 0x00000002U,
}

alias COMPRESSION_FORMAT = ushort;
enum : ushort
{
    COMPRESSION_FORMAT_NONE        = cast(ushort) 0x0000,
    COMPRESSION_FORMAT_DEFAULT     = cast(ushort) 0x0001,
    COMPRESSION_FORMAT_LZNT1       = cast(ushort) 0x0002,
    COMPRESSION_FORMAT_XPRESS      = cast(ushort) 0x0003,
    COMPRESSION_FORMAT_XPRESS_HUFF = cast(ushort) 0x0004,
    COMPRESSION_FORMAT_XP10        = cast(ushort) 0x0005,
    COMPRESSION_FORMAT_LZ4         = cast(ushort) 0x0006,
    COMPRESSION_FORMAT_DEFLATE     = cast(ushort) 0x0007,
    COMPRESSION_FORMAT_ZLIB        = cast(ushort) 0x0008,
}

alias FILE_TYPE = uint;
enum : uint
{
    FILE_TYPE_UNKNOWN = 0x00000000U,
    FILE_TYPE_DISK    = 0x00000001U,
    FILE_TYPE_CHAR    = 0x00000002U,
    FILE_TYPE_PIPE    = 0x00000003U,
    FILE_TYPE_REMOTE  = 0x00008000U,
}

alias FILE_DISPOSITION_INFO_EX_FLAGS = uint;
enum : uint
{
    FILE_DISPOSITION_FLAG_DO_NOT_DELETE             = 0x00000000U,
    FILE_DISPOSITION_FLAG_DELETE                    = 0x00000001U,
    FILE_DISPOSITION_FLAG_POSIX_SEMANTICS           = 0x00000002U,
    FILE_DISPOSITION_FLAG_FORCE_IMAGE_SECTION_CHECK = 0x00000004U,
    FILE_DISPOSITION_FLAG_ON_CLOSE                  = 0x00000008U,
    FILE_DISPOSITION_FLAG_IGNORE_READONLY_ATTRIBUTE = 0x00000010U,
}

alias COPYFILE_FLAGS = uint;
enum : uint
{
    COPY_FILE_FAIL_IF_EXISTS              = 0x00000001U,
    COPY_FILE_RESTARTABLE                 = 0x00000002U,
    COPY_FILE_OPEN_SOURCE_FOR_WRITE       = 0x00000004U,
    COPY_FILE_ALLOW_DECRYPTED_DESTINATION = 0x00000008U,
    COPY_FILE_COPY_SYMLINK                = 0x00000800U,
    COPY_FILE_NO_BUFFERING                = 0x00001000U,
    COPY_FILE_REQUEST_SECURITY_PRIVILEGES = 0x00002000U,
    COPY_FILE_RESUME_FROM_PAUSE           = 0x00004000U,
    COPY_FILE_NO_OFFLOAD                  = 0x00040000U,
    COPY_FILE_IGNORE_EDP_BLOCK            = 0x00400000U,
    COPY_FILE_IGNORE_SOURCE_ENCRYPTION    = 0x00800000U,
    COPY_FILE_DONT_REQUEST_DEST_WRITE_DAC = 0x02000000U,
    COPY_FILE_REQUEST_COMPRESSED_TRAFFIC  = 0x10000000U,
    COPY_FILE_OPEN_AND_COPY_REPARSE_POINT = 0x00200000U,
    COPY_FILE_DIRECTORY                   = 0x00000080U,
    COPY_FILE_SKIP_ALTERNATE_STREAMS      = 0x00008000U,
    COPY_FILE_DISABLE_PRE_ALLOCATION      = 0x04000000U,
    COPY_FILE_ENABLE_LOW_FREE_SPACE_MODE  = 0x08000000U,
    COPY_FILE_ENABLE_SPARSE_COPY          = 0x20000000U,
    COPY_FILE_DISABLE_SPARSE_COPY         = 0x80000000U,
}

alias COPYFILE2_V2_FLAGS = uint;
enum : uint
{
    COPY_FILE2_V2_DONT_COPY_JUNCTIONS   = 0x00000001U,
    COPY_FILE2_V2_DISABLE_BLOCK_CLONING = 0x00000002U,
    COPY_FILE2_V2_VALID_FLAGS           = 0x00000003U,
}

alias COPYPROGRESSROUTINE_PROGRESS = uint;
enum : uint
{
    PROGRESS_CONTINUE = 0x00000000U,
    PROGRESS_CANCEL   = 0x00000001U,
    PROGRESS_STOP     = 0x00000002U,
    PROGRESS_QUIET    = 0x00000003U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ne-minwinbase-findex_info_levels
alias FINDEX_INFO_LEVELS = int;
enum : int
{
    FindExInfoStandard     = 0x00000000,
    FindExInfoBasic        = 0x00000001,
    FindExInfoMaxInfoLevel = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ne-minwinbase-findex_search_ops
alias FINDEX_SEARCH_OPS = int;
enum : int
{
    FindExSearchNameMatch          = 0x00000000,
    FindExSearchLimitToDirectories = 0x00000001,
    FindExSearchLimitToDevices     = 0x00000002,
    FindExSearchMaxSearchOp        = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ne-minwinbase-read_directory_notify_information_class
alias READ_DIRECTORY_NOTIFY_INFORMATION_CLASS = int;
enum : int
{
    ReadDirectoryNotifyInformation         = 0x00000001,
    ReadDirectoryNotifyExtendedInformation = 0x00000002,
    ReadDirectoryNotifyFullInformation     = 0x00000003,
    ReadDirectoryNotifyMaximumInformation  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ne-minwinbase-get_fileex_info_levels
alias GET_FILEEX_INFO_LEVELS = int;
enum : int
{
    GetFileExInfoStandard = 0x00000000,
    GetFileExMaxInfoLevel = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ne-minwinbase-file_info_by_handle_class
alias FILE_INFO_BY_HANDLE_CLASS = int;
enum : int
{
    FileBasicInfo                  = 0x00000000,
    FileStandardInfo               = 0x00000001,
    FileNameInfo                   = 0x00000002,
    FileRenameInfo                 = 0x00000003,
    FileDispositionInfo            = 0x00000004,
    FileAllocationInfo             = 0x00000005,
    FileEndOfFileInfo              = 0x00000006,
    FileStreamInfo                 = 0x00000007,
    FileCompressionInfo            = 0x00000008,
    FileAttributeTagInfo           = 0x00000009,
    FileIdBothDirectoryInfo        = 0x0000000a,
    FileIdBothDirectoryRestartInfo = 0x0000000b,
    FileIoPriorityHintInfo         = 0x0000000c,
    FileRemoteProtocolInfo         = 0x0000000d,
    FileFullDirectoryInfo          = 0x0000000e,
    FileFullDirectoryRestartInfo   = 0x0000000f,
    FileStorageInfo                = 0x00000010,
    FileAlignmentInfo              = 0x00000011,
    FileIdInfo                     = 0x00000012,
    FileIdExtdDirectoryInfo        = 0x00000013,
    FileIdExtdDirectoryRestartInfo = 0x00000014,
    FileDispositionInfoEx          = 0x00000015,
    FileRenameInfoEx               = 0x00000016,
    FileCaseSensitiveInfo          = 0x00000017,
    FileNormalizedNameInfo         = 0x00000018,
    MaximumFileInfoByHandleClass   = 0x00000019,
}

alias FILE_INFO_BY_NAME_CLASS = int;
enum : int
{
    FileStatByNameInfo          = 0x00000000,
    FileStatLxByNameInfo        = 0x00000001,
    FileCaseSensitiveByNameInfo = 0x00000002,
    FileStatBasicByNameInfo     = 0x00000003,
    MaximumFileInfoByNameClass  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapi/ne-fileapi-stream_info_levels
alias STREAM_INFO_LEVELS = int;
enum : int
{
    FindStreamInfoStandard     = 0x00000000,
    FindStreamInfoMaxInfoLevel = 0x00000001,
}

alias DIRECTORY_FLAGS = int;
enum : int
{
    DIRECTORY_FLAGS_NONE                    = 0x00000000,
    DIRECTORY_FLAGS_DISALLOW_PATH_REDIRECTS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ne-ntmsapi-ntmsobjectstypes
enum NtmsObjectsTypes : int
{
    NTMS_UNKNOWN                = 0x00000000,
    NTMS_OBJECT                 = 0x00000001,
    NTMS_CHANGER                = 0x00000002,
    NTMS_CHANGER_TYPE           = 0x00000003,
    NTMS_COMPUTER               = 0x00000004,
    NTMS_DRIVE                  = 0x00000005,
    NTMS_DRIVE_TYPE             = 0x00000006,
    NTMS_IEDOOR                 = 0x00000007,
    NTMS_IEPORT                 = 0x00000008,
    NTMS_LIBRARY                = 0x00000009,
    NTMS_LIBREQUEST             = 0x0000000a,
    NTMS_LOGICAL_MEDIA          = 0x0000000b,
    NTMS_MEDIA_POOL             = 0x0000000c,
    NTMS_MEDIA_TYPE             = 0x0000000d,
    NTMS_PARTITION              = 0x0000000e,
    NTMS_PHYSICAL_MEDIA         = 0x0000000f,
    NTMS_STORAGESLOT            = 0x00000010,
    NTMS_OPREQUEST              = 0x00000011,
    NTMS_UI_DESTINATION         = 0x00000012,
    NTMS_NUMBER_OF_OBJECT_TYPES = 0x00000013,
}

enum NtmsAsyncStatus : int
{
    NTMS_ASYNCSTATE_QUEUED        = 0x00000000,
    NTMS_ASYNCSTATE_WAIT_RESOURCE = 0x00000001,
    NTMS_ASYNCSTATE_WAIT_OPERATOR = 0x00000002,
    NTMS_ASYNCSTATE_INPROCESS     = 0x00000003,
    NTMS_ASYNCSTATE_COMPLETE      = 0x00000004,
}

enum NtmsAsyncOperations : int
{
    NTMS_ASYNCOP_MOUNT = 0x00000001,
}

enum NtmsSessionOptions : int
{
    NTMS_SESSION_QUERYEXPEDITE = 0x00000001,
}

enum NtmsMountOptions : int
{
    NTMS_MOUNT_READ                 = 0x00000001,
    NTMS_MOUNT_WRITE                = 0x00000002,
    NTMS_MOUNT_ERROR_NOT_AVAILABLE  = 0x00000004,
    NTMS_MOUNT_ERROR_IF_UNAVAILABLE = 0x00000004,
    NTMS_MOUNT_ERROR_OFFLINE        = 0x00000008,
    NTMS_MOUNT_ERROR_IF_OFFLINE     = 0x00000008,
    NTMS_MOUNT_SPECIFIC_DRIVE       = 0x00000010,
    NTMS_MOUNT_NOWAIT               = 0x00000020,
}

enum NtmsDismountOptions : int
{
    NTMS_DISMOUNT_DEFERRED  = 0x00000001,
    NTMS_DISMOUNT_IMMEDIATE = 0x00000002,
}

enum NtmsMountPriority : int
{
    NTMS_PRIORITY_DEFAULT = 0x00000000,
    NTMS_PRIORITY_HIGHEST = 0x0000000f,
    NTMS_PRIORITY_HIGH    = 0x00000007,
    NTMS_PRIORITY_NORMAL  = 0x00000000,
    NTMS_PRIORITY_LOW     = 0xfffffff9,
    NTMS_PRIORITY_LOWEST  = 0xfffffff1,
}

enum NtmsAllocateOptions : int
{
    NTMS_ALLOCATE_NEW                  = 0x00000001,
    NTMS_ALLOCATE_NEXT                 = 0x00000002,
    NTMS_ALLOCATE_ERROR_IF_UNAVAILABLE = 0x00000004,
}

enum NtmsCreateOptions : int
{
    NTMS_OPEN_EXISTING = 0x00000001,
    NTMS_CREATE_NEW    = 0x00000002,
    NTMS_OPEN_ALWAYS   = 0x00000003,
}

enum NtmsDriveState : int
{
    NTMS_DRIVESTATE_DISMOUNTED    = 0x00000000,
    NTMS_DRIVESTATE_MOUNTED       = 0x00000001,
    NTMS_DRIVESTATE_LOADED        = 0x00000002,
    NTMS_DRIVESTATE_UNLOADED      = 0x00000005,
    NTMS_DRIVESTATE_BEING_CLEANED = 0x00000006,
    NTMS_DRIVESTATE_DISMOUNTABLE  = 0x00000007,
}

enum NtmsLibraryType : int
{
    NTMS_LIBRARYTYPE_UNKNOWN    = 0x00000000,
    NTMS_LIBRARYTYPE_OFFLINE    = 0x00000001,
    NTMS_LIBRARYTYPE_ONLINE     = 0x00000002,
    NTMS_LIBRARYTYPE_STANDALONE = 0x00000003,
}

enum NtmsLibraryFlags : int
{
    NTMS_LIBRARYFLAG_FIXEDOFFLINE               = 0x00000001,
    NTMS_LIBRARYFLAG_CLEANERPRESENT             = 0x00000002,
    NTMS_LIBRARYFLAG_AUTODETECTCHANGE           = 0x00000004,
    NTMS_LIBRARYFLAG_IGNORECLEANERUSESREMAINING = 0x00000008,
    NTMS_LIBRARYFLAG_RECOGNIZECLEANERBARCODE    = 0x00000010,
}

enum NtmsInventoryMethod : int
{
    NTMS_INVENTORY_NONE    = 0x00000000,
    NTMS_INVENTORY_FAST    = 0x00000001,
    NTMS_INVENTORY_OMID    = 0x00000002,
    NTMS_INVENTORY_DEFAULT = 0x00000003,
    NTMS_INVENTORY_SLOT    = 0x00000004,
    NTMS_INVENTORY_STOP    = 0x00000005,
    NTMS_INVENTORY_MAX     = 0x00000006,
}

enum NtmsSlotState : int
{
    NTMS_SLOTSTATE_UNKNOWN        = 0x00000000,
    NTMS_SLOTSTATE_FULL           = 0x00000001,
    NTMS_SLOTSTATE_EMPTY          = 0x00000002,
    NTMS_SLOTSTATE_NOTPRESENT     = 0x00000003,
    NTMS_SLOTSTATE_NEEDSINVENTORY = 0x00000004,
}

enum NtmsDoorState : int
{
    NTMS_DOORSTATE_UNKNOWN = 0x00000000,
    NTMS_DOORSTATE_CLOSED  = 0x00000001,
    NTMS_DOORSTATE_OPEN    = 0x00000002,
}

enum NtmsPortPosition : int
{
    NTMS_PORTPOSITION_UNKNOWN   = 0x00000000,
    NTMS_PORTPOSITION_EXTENDED  = 0x00000001,
    NTMS_PORTPOSITION_RETRACTED = 0x00000002,
}

enum NtmsPortContent : int
{
    NTMS_PORTCONTENT_UNKNOWN = 0x00000000,
    NTMS_PORTCONTENT_FULL    = 0x00000001,
    NTMS_PORTCONTENT_EMPTY   = 0x00000002,
}

enum NtmsBarCodeState : int
{
    NTMS_BARCODESTATE_OK         = 0x00000001,
    NTMS_BARCODESTATE_UNREADABLE = 0x00000002,
}

enum NtmsMediaState : int
{
    NTMS_MEDIASTATE_IDLE     = 0x00000000,
    NTMS_MEDIASTATE_INUSE    = 0x00000001,
    NTMS_MEDIASTATE_MOUNTED  = 0x00000002,
    NTMS_MEDIASTATE_LOADED   = 0x00000003,
    NTMS_MEDIASTATE_UNLOADED = 0x00000004,
    NTMS_MEDIASTATE_OPERROR  = 0x00000005,
    NTMS_MEDIASTATE_OPREQ    = 0x00000006,
}

enum NtmsPartitionState : int
{
    NTMS_PARTSTATE_UNKNOWN        = 0x00000000,
    NTMS_PARTSTATE_UNPREPARED     = 0x00000001,
    NTMS_PARTSTATE_INCOMPATIBLE   = 0x00000002,
    NTMS_PARTSTATE_DECOMMISSIONED = 0x00000003,
    NTMS_PARTSTATE_AVAILABLE      = 0x00000004,
    NTMS_PARTSTATE_ALLOCATED      = 0x00000005,
    NTMS_PARTSTATE_COMPLETE       = 0x00000006,
    NTMS_PARTSTATE_FOREIGN        = 0x00000007,
    NTMS_PARTSTATE_IMPORT         = 0x00000008,
    NTMS_PARTSTATE_RESERVED       = 0x00000009,
}

enum NtmsPoolType : int
{
    NTMS_POOLTYPE_UNKNOWN     = 0x00000000,
    NTMS_POOLTYPE_SCRATCH     = 0x00000001,
    NTMS_POOLTYPE_FOREIGN     = 0x00000002,
    NTMS_POOLTYPE_IMPORT      = 0x00000003,
    NTMS_POOLTYPE_APPLICATION = 0x000003e8,
}

enum NtmsAllocationPolicy : int
{
    NTMS_ALLOCATE_FROMSCRATCH = 0x00000001,
}

enum NtmsDeallocationPolicy : int
{
    NTMS_DEALLOCATE_TOSCRATCH = 0x00000001,
}

enum NtmsReadWriteCharacteristics : int
{
    NTMS_MEDIARW_UNKNOWN    = 0x00000000,
    NTMS_MEDIARW_REWRITABLE = 0x00000001,
    NTMS_MEDIARW_WRITEONCE  = 0x00000002,
    NTMS_MEDIARW_READONLY   = 0x00000003,
}

enum NtmsLmOperation : int
{
    NTMS_LM_REMOVE         = 0x00000000,
    NTMS_LM_DISABLECHANGER = 0x00000001,
    NTMS_LM_DISABLELIBRARY = 0x00000001,
    NTMS_LM_ENABLECHANGER  = 0x00000002,
    NTMS_LM_ENABLELIBRARY  = 0x00000002,
    NTMS_LM_DISABLEDRIVE   = 0x00000003,
    NTMS_LM_ENABLEDRIVE    = 0x00000004,
    NTMS_LM_DISABLEMEDIA   = 0x00000005,
    NTMS_LM_ENABLEMEDIA    = 0x00000006,
    NTMS_LM_UPDATEOMID     = 0x00000007,
    NTMS_LM_INVENTORY      = 0x00000008,
    NTMS_LM_DOORACCESS     = 0x00000009,
    NTMS_LM_EJECT          = 0x0000000a,
    NTMS_LM_EJECTCLEANER   = 0x0000000b,
    NTMS_LM_INJECT         = 0x0000000c,
    NTMS_LM_INJECTCLEANER  = 0x0000000d,
    NTMS_LM_PROCESSOMID    = 0x0000000e,
    NTMS_LM_CLEANDRIVE     = 0x0000000f,
    NTMS_LM_DISMOUNT       = 0x00000010,
    NTMS_LM_MOUNT          = 0x00000011,
    NTMS_LM_WRITESCRATCH   = 0x00000012,
    NTMS_LM_CLASSIFY       = 0x00000013,
    NTMS_LM_RESERVECLEANER = 0x00000014,
    NTMS_LM_RELEASECLEANER = 0x00000015,
    NTMS_LM_MAXWORKITEM    = 0x00000016,
}

enum NtmsLmState : int
{
    NTMS_LM_QUEUED    = 0x00000000,
    NTMS_LM_INPROCESS = 0x00000001,
    NTMS_LM_PASSED    = 0x00000002,
    NTMS_LM_FAILED    = 0x00000003,
    NTMS_LM_INVALID   = 0x00000004,
    NTMS_LM_WAITING   = 0x00000005,
    NTMS_LM_DEFERRED  = 0x00000006,
    NTMS_LM_DEFFERED  = 0x00000006,
    NTMS_LM_CANCELLED = 0x00000007,
    NTMS_LM_STOPPED   = 0x00000008,
}

enum NtmsOpreqCommand : int
{
    NTMS_OPREQ_UNKNOWN       = 0x00000000,
    NTMS_OPREQ_NEWMEDIA      = 0x00000001,
    NTMS_OPREQ_CLEANER       = 0x00000002,
    NTMS_OPREQ_DEVICESERVICE = 0x00000003,
    NTMS_OPREQ_MOVEMEDIA     = 0x00000004,
    NTMS_OPREQ_MESSAGE       = 0x00000005,
}

enum NtmsOpreqState : int
{
    NTMS_OPSTATE_UNKNOWN    = 0x00000000,
    NTMS_OPSTATE_SUBMITTED  = 0x00000001,
    NTMS_OPSTATE_ACTIVE     = 0x00000002,
    NTMS_OPSTATE_INPROGRESS = 0x00000003,
    NTMS_OPSTATE_REFUSED    = 0x00000004,
    NTMS_OPSTATE_COMPLETE   = 0x00000005,
}

enum NtmsLibRequestFlags : int
{
    NTMS_LIBREQFLAGS_NOAUTOPURGE   = 0x00000001,
    NTMS_LIBREQFLAGS_NOFAILEDPURGE = 0x00000002,
}

enum NtmsOpRequestFlags : int
{
    NTMS_OPREQFLAGS_NOAUTOPURGE   = 0x00000001,
    NTMS_OPREQFLAGS_NOFAILEDPURGE = 0x00000002,
    NTMS_OPREQFLAGS_NOALERTS      = 0x00000010,
    NTMS_OPREQFLAGS_NOTRAYICON    = 0x00000020,
}

enum NtmsMediaPoolPolicy : int
{
    NTMS_POOLPOLICY_PURGEOFFLINESCRATCH = 0x00000001,
    NTMS_POOLPOLICY_KEEPOFFLINEIMPORT   = 0x00000002,
}

enum NtmsOperationalState : int
{
    NTMS_READY         = 0x00000000,
    NTMS_INITIALIZING  = 0x0000000a,
    NTMS_NEEDS_SERVICE = 0x00000014,
    NTMS_NOT_PRESENT   = 0x00000015,
}

enum NtmsCreateNtmsMediaOptions : int
{
    NTMS_ERROR_ON_DUPLICATE = 0x00000001,
}

enum NtmsEnumerateOption : int
{
    NTMS_ENUM_DEFAULT  = 0x00000000,
    NTMS_ENUM_ROOTPOOL = 0x00000001,
}

enum NtmsEjectOperation : int
{
    NTMS_EJECT_START     = 0x00000000,
    NTMS_EJECT_STOP      = 0x00000001,
    NTMS_EJECT_QUEUE     = 0x00000002,
    NTMS_EJECT_FORCE     = 0x00000003,
    NTMS_EJECT_IMMEDIATE = 0x00000004,
    NTMS_EJECT_ASK_USER  = 0x00000005,
}

enum NtmsInjectOperation : int
{
    NTMS_INJECT_START     = 0x00000000,
    NTMS_INJECT_STOP      = 0x00000001,
    NTMS_INJECT_RETRACT   = 0x00000002,
    NTMS_INJECT_STARTMANY = 0x00000003,
}

enum NtmsDriveType : int
{
    NTMS_UNKNOWN_DRIVE = 0x00000000,
}

enum NtmsAccessMask : int
{
    NTMS_USE_ACCESS     = 0x00000001,
    NTMS_MODIFY_ACCESS  = 0x00000002,
    NTMS_CONTROL_ACCESS = 0x00000004,
}

enum NtmsUITypes : int
{
    NTMS_UITYPE_INVALID = 0x00000000,
    NTMS_UITYPE_INFO    = 0x00000001,
    NTMS_UITYPE_REQ     = 0x00000002,
    NTMS_UITYPE_ERR     = 0x00000003,
    NTMS_UITYPE_MAX     = 0x00000004,
}

enum NtmsUIOperations : int
{
    NTMS_UIDEST_ADD       = 0x00000001,
    NTMS_UIDEST_DELETE    = 0x00000002,
    NTMS_UIDEST_DELETEALL = 0x00000003,
    NTMS_UIOPERATION_MAX  = 0x00000004,
}

enum NtmsNotificationOperations : int
{
    NTMS_OBJ_UPDATE     = 0x00000001,
    NTMS_OBJ_INSERT     = 0x00000002,
    NTMS_OBJ_DELETE     = 0x00000003,
    NTMS_EVENT_SIGNAL   = 0x00000004,
    NTMS_EVENT_COMPLETE = 0x00000005,
}

alias CLS_CONTEXT_MODE = int;
enum : int
{
    ClsContextNone     = 0x00000000,
    ClsContextUndoNext = 0x00000001,
    ClsContextPrevious = 0x00000002,
    ClsContextForward  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ne-clfs-clfs_context_mode
alias CLFS_CONTEXT_MODE = int;
enum : int
{
    ClfsContextNone     = 0x00000000,
    ClfsContextUndoNext = 0x00000001,
    ClfsContextPrevious = 0x00000002,
    ClfsContextForward  = 0x00000003,
}

alias CLS_LOG_INFORMATION_CLASS = int;
enum : int
{
    ClfsLogBasicInformation            = 0x00000000,
    ClfsLogBasicInformationPhysical    = 0x00000001,
    ClfsLogPhysicalNameInformation     = 0x00000002,
    ClfsLogStreamIdentifierInformation = 0x00000003,
    ClfsLogSystemMarkingInformation    = 0x00000004,
    ClfsLogPhysicalLsnInformation      = 0x00000005,
}

alias CLS_IOSTATS_CLASS = int;
enum : int
{
    ClsIoStatsDefault = 0x00000000,
    ClsIoStatsMax     = 0x0000ffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ne-clfs-clfs_iostats_class
alias CLFS_IOSTATS_CLASS = int;
enum : int
{
    ClfsIoStatsDefault = 0x00000000,
    ClfsIoStatsMax     = 0x0000ffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ne-clfs-clfs_log_archive_mode
alias CLFS_LOG_ARCHIVE_MODE = int;
enum : int
{
    ClfsLogArchiveEnabled  = 0x00000001,
    ClfsLogArchiveDisabled = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfsmgmt/ne-clfsmgmt-clfs_mgmt_policy_type
alias CLFS_MGMT_POLICY_TYPE = int;
enum : int
{
    ClfsMgmtPolicyMaximumSize           = 0x00000000,
    ClfsMgmtPolicyMinimumSize           = 0x00000001,
    ClfsMgmtPolicyNewContainerSize      = 0x00000002,
    ClfsMgmtPolicyGrowthRate            = 0x00000003,
    ClfsMgmtPolicyLogTail               = 0x00000004,
    ClfsMgmtPolicyAutoShrink            = 0x00000005,
    ClfsMgmtPolicyAutoGrow              = 0x00000006,
    ClfsMgmtPolicyNewContainerPrefix    = 0x00000007,
    ClfsMgmtPolicyNewContainerSuffix    = 0x00000008,
    ClfsMgmtPolicyNewContainerExtension = 0x00000009,
    ClfsMgmtPolicyInvalid               = 0x0000000a,
}

alias CLFS_MGMT_NOTIFICATION_TYPE = int;
enum : int
{
    ClfsMgmtAdvanceTailNotification    = 0x00000000,
    ClfsMgmtLogFullHandlerNotification = 0x00000001,
    ClfsMgmtLogUnpinnedNotification    = 0x00000002,
    ClfsMgmtLogWriteNotification       = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntioring_x/ne-ntioring_x-ioring_version
alias IORING_VERSION = int;
enum : int
{
    IORING_VERSION_INVALID = 0x00000000,
    IORING_VERSION_1       = 0x00000001,
    IORING_VERSION_2       = 0x00000002,
    IORING_VERSION_3       = 0x0000012c,
    IORING_VERSION_4       = 0x00000190,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntioring_x/ne-ntioring_x-ioring_feature_flags
alias IORING_FEATURE_FLAGS = int;
enum : int
{
    IORING_FEATURE_FLAGS_NONE           = 0x00000000,
    IORING_FEATURE_UM_EMULATION         = 0x00000001,
    IORING_FEATURE_SET_COMPLETION_EVENT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntioring_x/ne-ntioring_x-ioring_op_code
alias IORING_OP_CODE = int;
enum : int
{
    IORING_OP_NOP              = 0x00000000,
    IORING_OP_READ             = 0x00000001,
    IORING_OP_REGISTER_FILES   = 0x00000002,
    IORING_OP_REGISTER_BUFFERS = 0x00000003,
    IORING_OP_CANCEL           = 0x00000004,
    IORING_OP_WRITE            = 0x00000005,
    IORING_OP_FLUSH            = 0x00000006,
    IORING_OP_READ_SCATTER     = 0x00000007,
    IORING_OP_WRITE_GATHER     = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/ne-ioringapi-ioring_sqe_flags
alias IORING_SQE_FLAGS = int;
enum : int
{
    IOSQE_FLAGS_NONE                = 0x00000000,
    IOSQE_FLAGS_DRAIN_PRECEDING_OPS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/ne-ioringapi-ioring_create_required_flags
alias IORING_CREATE_REQUIRED_FLAGS = int;
enum : int
{
    IORING_CREATE_REQUIRED_FLAGS_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/ne-ioringapi-ioring_create_advisory_flags
alias IORING_CREATE_ADVISORY_FLAGS = int;
enum : int
{
    IORING_CREATE_ADVISORY_FLAGS_NONE       = 0x00000000,
    IORING_CREATE_SKIP_BUILDER_PARAM_CHECKS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/ne-ioringapi-ioring_ref_kind
alias IORING_REF_KIND = int;
enum : int
{
    IORING_REF_RAW        = 0x00000000,
    IORING_REF_REGISTERED = 0x00000001,
}

alias CREATE_BIND_LINK_FLAGS = int;
enum : int
{
    CREATE_BIND_LINK_FLAG_NONE      = 0x00000000,
    CREATE_BIND_LINK_FLAG_READ_ONLY = 0x00000001,
    CREATE_BIND_LINK_FLAG_MERGED    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-transaction_outcome
alias TRANSACTION_OUTCOME = int;
enum : int
{
    TransactionOutcomeUndetermined = 0x00000001,
    TransactionOutcomeCommitted    = 0x00000002,
    TransactionOutcomeAborted      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_bus_type
alias STORAGE_BUS_TYPE = int;
enum : int
{
    BusTypeUnknown           = 0x00000000,
    BusTypeScsi              = 0x00000001,
    BusTypeAtapi             = 0x00000002,
    BusTypeAta               = 0x00000003,
    BusType1394              = 0x00000004,
    BusTypeSsa               = 0x00000005,
    BusTypeFibre             = 0x00000006,
    BusTypeUsb               = 0x00000007,
    BusTypeRAID              = 0x00000008,
    BusTypeiScsi             = 0x00000009,
    BusTypeSas               = 0x0000000a,
    BusTypeSata              = 0x0000000b,
    BusTypeSd                = 0x0000000c,
    BusTypeMmc               = 0x0000000d,
    BusTypeVirtual           = 0x0000000e,
    BusTypeFileBackedVirtual = 0x0000000f,
    BusTypeSpaces            = 0x00000010,
    BusTypeNvme              = 0x00000011,
    BusTypeSCM               = 0x00000012,
    BusTypeUfs               = 0x00000013,
    BusTypeNvmeof            = 0x00000014,
    BusTypeMax               = 0x00000015,
    BusTypeMaxReserved       = 0x0000007f,
}

alias FILE_WRITE_FLAGS = int;
enum : int
{
    FILE_WRITE_FLAGS_NONE          = 0x00000000,
    FILE_WRITE_FLAGS_WRITE_THROUGH = 0x00000001,
}

alias FILE_FLUSH_MODE = int;
enum : int
{
    FILE_FLUSH_DEFAULT      = 0x00000000,
    FILE_FLUSH_DATA         = 0x00000001,
    FILE_FLUSH_MIN_METADATA = 0x00000002,
    FILE_FLUSH_NO_SYNC      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ne-winbase-copyfile2_message_type
alias COPYFILE2_MESSAGE_TYPE = int;
enum : int
{
    COPYFILE2_CALLBACK_NONE            = 0x00000000,
    COPYFILE2_CALLBACK_CHUNK_STARTED   = 0x00000001,
    COPYFILE2_CALLBACK_CHUNK_FINISHED  = 0x00000002,
    COPYFILE2_CALLBACK_STREAM_STARTED  = 0x00000003,
    COPYFILE2_CALLBACK_STREAM_FINISHED = 0x00000004,
    COPYFILE2_CALLBACK_POLL_CONTINUE   = 0x00000005,
    COPYFILE2_CALLBACK_ERROR           = 0x00000006,
    COPYFILE2_CALLBACK_MAX             = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ne-winbase-copyfile2_message_action
alias COPYFILE2_MESSAGE_ACTION = int;
enum : int
{
    COPYFILE2_PROGRESS_CONTINUE = 0x00000000,
    COPYFILE2_PROGRESS_CANCEL   = 0x00000001,
    COPYFILE2_PROGRESS_STOP     = 0x00000002,
    COPYFILE2_PROGRESS_QUIET    = 0x00000003,
    COPYFILE2_PROGRESS_PAUSE    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ne-winbase-copyfile2_copy_phase
alias COPYFILE2_COPY_PHASE = int;
enum : int
{
    COPYFILE2_PHASE_NONE              = 0x00000000,
    COPYFILE2_PHASE_PREPARE_SOURCE    = 0x00000001,
    COPYFILE2_PHASE_PREPARE_DEST      = 0x00000002,
    COPYFILE2_PHASE_READ_SOURCE       = 0x00000003,
    COPYFILE2_PHASE_WRITE_DESTINATION = 0x00000004,
    COPYFILE2_PHASE_SERVER_COPY       = 0x00000005,
    COPYFILE2_PHASE_NAMEGRAFT_COPY    = 0x00000006,
    COPYFILE2_PHASE_MAX               = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ne-winbase-priority_hint
alias PRIORITY_HINT = int;
enum : int
{
    IoPriorityHintVeryLow     = 0x00000000,
    IoPriorityHintLow         = 0x00000001,
    IoPriorityHintNormal      = 0x00000002,
    MaximumIoPriorityHintType = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ne-winbase-file_id_type
alias FILE_ID_TYPE = int;
enum : int
{
    FileIdType         = 0x00000000,
    ObjectIdType       = 0x00000001,
    ExtendedFileIdType = 0x00000002,
    MaximumFileIdType  = 0x00000003,
}

// Constants


enum uint MAXIMUM_REPARSE_DATA_BUFFER_SIZE = 0x00004000U;

enum : const(wchar)*
{
    // Native encoding: ansi
    EA_CONTAINER_NAME = "ContainerName",
    // Native encoding: ansi
    EA_CONTAINER_SIZE = "ContainerSize",
}

enum const(wchar)* CLFS_BASELOG_EXTENSION = ".blf";
enum uint CLFS_FLAG_REENTRANT_FILE_SYSTEM = 0x00000008U;
enum uint CLFS_FLAG_NON_REENTRANT_FILTER = 0x00000010U;
enum uint CLFS_FLAG_REENTRANT_FILTER = 0x00000020U;
enum uint CLFS_FLAG_IGNORE_SHARE_ACCESS = 0x00000040U;
enum uint CLFS_FLAG_READ_IN_PROGRESS = 0x00000080U;
enum uint CLFS_FLAG_MINIFILTER_LEVEL = 0x00000100U;
enum uint CLFS_FLAG_HIDDEN_SYSTEM_LOG = 0x00000200U;

enum : uint
{
    CLFS_MARSHALLING_FLAG_NONE              = 0x00000000U,
    CLFS_MARSHALLING_FLAG_DISABLE_BUFF_INIT = 0x00000001U,
}

enum : uint
{
    CLFS_FLAG_FILTER_INTERMEDIATE_LEVEL = 0x00000010U,
    CLFS_FLAG_FILTER_TOP_LEVEL          = 0x00000020U,
}

enum : const(wchar)*
{
    CLFS_CONTAINER_STREAM_PREFIX   = "%BLF%:",
    CLFS_CONTAINER_RELATIVE_PREFIX = "%BLF%\\",
}

enum : uint
{
    TRANSACTION_MANAGER_VOLATILE             = 0x00000001U,
    TRANSACTION_MANAGER_COMMIT_DEFAULT       = 0x00000000U,
    TRANSACTION_MANAGER_COMMIT_SYSTEM_VOLUME = 0x00000002U,
    TRANSACTION_MANAGER_COMMIT_SYSTEM_HIVES  = 0x00000004U,
    TRANSACTION_MANAGER_COMMIT_LOWEST        = 0x00000008U,
    TRANSACTION_MANAGER_CORRUPT_FOR_RECOVERY = 0x00000010U,
    TRANSACTION_MANAGER_CORRUPT_FOR_PROGRESS = 0x00000020U,
    TRANSACTION_MANAGER_MAXIMUM_OPTION       = 0x0000003fU,
}

enum : uint
{
    TRANSACTION_DO_NOT_PROMOTE = 0x00000001U,
    TRANSACTION_MAXIMUM_OPTION = 0x00000001U,
}

enum : uint
{
    RESOURCE_MANAGER_VOLATILE       = 0x00000001U,
    RESOURCE_MANAGER_COMMUNICATION  = 0x00000002U,
    RESOURCE_MANAGER_MAXIMUM_OPTION = 0x00000003U,
}

enum uint CRM_PROTOCOL_EXPLICIT_MARSHAL_ONLY = 0x00000001U;
enum uint CRM_PROTOCOL_DYNAMIC_MARSHAL_INFO = 0x00000002U;
enum uint CRM_PROTOCOL_MAXIMUM_OPTION = 0x00000003U;

enum : uint
{
    ENLISTMENT_SUPERIOR       = 0x00000001U,
    ENLISTMENT_MAXIMUM_OPTION = 0x00000001U,
}

enum : uint
{
    TRANSACTION_NOTIFY_MASK                = 0x3fffffffU,
    TRANSACTION_NOTIFY_PREPREPARE          = 0x00000001U,
    TRANSACTION_NOTIFY_PREPARE             = 0x00000002U,
    TRANSACTION_NOTIFY_COMMIT              = 0x00000004U,
    TRANSACTION_NOTIFY_ROLLBACK            = 0x00000008U,
    TRANSACTION_NOTIFY_PREPREPARE_COMPLETE = 0x00000010U,
    TRANSACTION_NOTIFY_PREPARE_COMPLETE    = 0x00000020U,
    TRANSACTION_NOTIFY_COMMIT_COMPLETE     = 0x00000040U,
    TRANSACTION_NOTIFY_ROLLBACK_COMPLETE   = 0x00000080U,
    TRANSACTION_NOTIFY_RECOVER             = 0x00000100U,
    TRANSACTION_NOTIFY_SINGLE_PHASE_COMMIT = 0x00000200U,
    TRANSACTION_NOTIFY_DELEGATE_COMMIT     = 0x00000400U,
    TRANSACTION_NOTIFY_RECOVER_QUERY       = 0x00000800U,
    TRANSACTION_NOTIFY_ENLIST_PREPREPARE   = 0x00001000U,
    TRANSACTION_NOTIFY_LAST_RECOVER        = 0x00002000U,
    TRANSACTION_NOTIFY_INDOUBT             = 0x00004000U,
    TRANSACTION_NOTIFY_PROPAGATE_PULL      = 0x00008000U,
    TRANSACTION_NOTIFY_PROPAGATE_PUSH      = 0x00010000U,
    TRANSACTION_NOTIFY_MARSHAL             = 0x00020000U,
    TRANSACTION_NOTIFY_ENLIST_MASK         = 0x00040000U,
    TRANSACTION_NOTIFY_RM_DISCONNECTED     = 0x01000000U,
    TRANSACTION_NOTIFY_TM_ONLINE           = 0x02000000U,
    TRANSACTION_NOTIFY_COMMIT_REQUEST      = 0x04000000U,
    TRANSACTION_NOTIFY_PROMOTE             = 0x08000000U,
    TRANSACTION_NOTIFY_PROMOTE_NEW         = 0x10000000U,
    TRANSACTION_NOTIFY_REQUEST_OUTCOME     = 0x20000000U,
    TRANSACTION_NOTIFY_COMMIT_FINALIZE     = 0x40000000U,
}

enum const(wchar)* TRANSACTIONMANAGER_OBJECT_PATH = "\\TransactionManager\\";
enum const(wchar)* TRANSACTION_OBJECT_PATH = "\\Transaction\\";
enum const(wchar)* ENLISTMENT_OBJECT_PATH = "\\Enlistment\\";
enum const(wchar)* RESOURCE_MANAGER_OBJECT_PATH = "\\ResourceManager\\";
enum uint TRANSACTION_NOTIFICATION_TM_ONLINE_FLAG_IS_CLUSTERED = 0x00000001U;

enum : uint
{
    KTM_MARSHAL_BLOB_VERSION_MAJOR = 0x00000001U,
    KTM_MARSHAL_BLOB_VERSION_MINOR = 0x00000001U,
}

enum uint MAX_TRANSACTION_DESCRIPTION_LENGTH = 0x00000040U;
enum uint MAX_RESOURCEMANAGER_DESCRIPTION_LENGTH = 0x00000040U;

enum : uint
{
    IOCTL_VOLUME_BASE                    = 0x00000056U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_volume_get_volume_disk_extents
    IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS = 0x00560000U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_volume_online
    IOCTL_VOLUME_ONLINE                  = 0x0056c008U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_volume_offline
    IOCTL_VOLUME_OFFLINE                 = 0x0056c00cU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_volume_is_clustered
    IOCTL_VOLUME_IS_CLUSTERED            = 0x00560030U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_volume_get_gpt_attributes
    IOCTL_VOLUME_GET_GPT_ATTRIBUTES      = 0x00560038U,
    IOCTL_VOLUME_SUPPORTS_ONLINE_OFFLINE = 0x00560004U,
}

enum : uint
{
    IOCTL_VOLUME_IS_OFFLINE              = 0x00560010U,
    IOCTL_VOLUME_IS_IO_CAPABLE           = 0x00560014U,
    IOCTL_VOLUME_QUERY_FAILOVER_SET      = 0x00560018U,
    IOCTL_VOLUME_QUERY_VOLUME_NUMBER     = 0x0056001cU,
    IOCTL_VOLUME_LOGICAL_TO_PHYSICAL     = 0x00560020U,
    IOCTL_VOLUME_PHYSICAL_TO_LOGICAL     = 0x00560024U,
    IOCTL_VOLUME_IS_PARTITION            = 0x00560028U,
    IOCTL_VOLUME_READ_PLEX               = 0x0056402eU,
    IOCTL_VOLUME_SET_GPT_ATTRIBUTES      = 0x00560034U,
    IOCTL_VOLUME_GET_BC_PROPERTIES       = 0x0056403cU,
    IOCTL_VOLUME_ALLOCATE_BC_STREAM      = 0x0056c040U,
    IOCTL_VOLUME_FREE_BC_STREAM          = 0x0056c044U,
    IOCTL_VOLUME_BC_VERSION              = 0x00000001U,
    IOCTL_VOLUME_IS_DYNAMIC              = 0x00560048U,
    IOCTL_VOLUME_PREPARE_FOR_CRITICAL_IO = 0x0056c04cU,
}

enum uint IOCTL_VOLUME_QUERY_ALLOCATION_HINT = 0x00564052U;

enum : uint
{
    IOCTL_VOLUME_UPDATE_PROPERTIES         = 0x00560054U,
    IOCTL_VOLUME_QUERY_MINIMUM_SHRINK_SIZE = 0x00564058U,
}

enum : uint
{
    IOCTL_VOLUME_PREPARE_FOR_SHRINK         = 0x0056c05cU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/FileIO/ioctl-volume-is-csv
    IOCTL_VOLUME_IS_CSV                     = 0x00560060U,
    IOCTL_VOLUME_POST_ONLINE                = 0x0056c064U,
    IOCTL_VOLUME_GET_CSVBLOCKCACHE_CALLBACK = 0x0056c068U,
}

enum uint CSV_BLOCK_CACHE_CALLBACK_VERSION = 0x00000001U;
enum uint CSV_BLOCK_AND_FILE_CACHE_CALLBACK_VERSION = 0x00000002U;

enum : GUID
{
    PARTITION_BASIC_DATA_GUID   = GUID("ebd0a0a2-b9e5-4433-87c0-68b6b72699c7"),
    PARTITION_BSP_GUID          = GUID("57434f53-4df9-45b9-8e9e-2370f006457c"),
    PARTITION_CLUSTER_GUID      = GUID("db97dba9-0840-4bae-97f0-ffb9a327c7e1"),
    PARTITION_DPP_GUID          = GUID("57434f53-94cb-43f0-a533-d73c10cfa57d"),
    PARTITION_ENTRY_UNUSED_GUID = GUID("00000000-0000-0000-0000-000000000000"),
}

enum : GUID
{
    PARTITION_LDM_DATA_GUID     = GUID("af9b60a0-1431-4f62-bc68-3311714a69ad"),
    PARTITION_LDM_METADATA_GUID = GUID("5808c8aa-7e8f-42e0-85d2-e1e90434cfb3"),
}

enum : GUID
{
    PARTITION_MAIN_OS_GUID       = GUID("57434f53-8f45-405e-8a23-186d8a4330d3"),
    PARTITION_MSFT_RECOVERY_GUID = GUID("de94bba4-06d1-4d40-a16a-bfd50179d6ac"),
    PARTITION_MSFT_RESERVED_GUID = GUID("e3c9e316-0b5c-4db8-817d-f92df00215ae"),
    PARTITION_MSFT_SNAPSHOT_GUID = GUID("caddebf1-4400-4de8-b103-12117dcf3ccf"),
}

enum : GUID
{
    PARTITION_OS_DATA_GUID       = GUID("57434f53-23f2-44d5-a830-67bbdaa609f9"),
    PARTITION_PATCH_GUID         = GUID("8967a686-96aa-6aa8-9589-a84256541090"),
    PARTITION_PRE_INSTALLED_GUID = GUID("57434f53-7fe0-4196-9b42-427b51643484"),
}

enum : GUID
{
    PARTITION_SBL_CACHE_SSD_GUID          = GUID("eeff8352-dd2a-44db-ae83-bee1cf7481dc"),
    PARTITION_SBL_CACHE_SSD_RESERVED_GUID = GUID("dcc0c7c1-55ad-4f17-9d43-4bc776e0117e"),
    PARTITION_SBL_CACHE_HDD_GUID          = GUID("03aaa829-ebfc-4e7e-aac9-c4d76c63b24b"),
}

enum : GUID
{
    PARTITION_SERVICING_FILES_GUID        = GUID("57434f53-432e-4014-ae4c-8deaa9c0006a"),
    PARTITION_SERVICING_METADATA_GUID     = GUID("57434f53-c691-4a05-bb4e-703dafd229ce"),
    PARTITION_SERVICING_RESERVE_GUID      = GUID("57434f53-4b81-460b-a319-ffb6fe136d14"),
    PARTITION_SERVICING_STAGING_ROOT_GUID = GUID("57434f53-e84d-4e84-aaf3-ecbbbd04b9df"),
}

enum : GUID
{
    PARTITION_SPACES_GUID         = GUID("e75caf8f-f680-4cee-afa3-b001e56efc2d"),
    PARTITION_SPACES_DATA_GUID    = GUID("e7addcb4-dc34-4539-9a76-ebbd07be6f7e"),
    PARTITION_SYSTEM_GUID         = GUID("c12a7328-f81f-11d2-ba4b-00a0c93ec93b"),
    PARTITION_WINDOWS_SYSTEM_GUID = GUID("57434f53-e3e3-4631-a5c5-26d2243873aa"),
}

enum uint _FT_TYPES_DEFINITION_ = 0x00000001U;
enum uint CLFS_MGMT_POLICY_VERSION = 0x00000001U;

enum : uint
{
    LOG_POLICY_OVERWRITE = 0x00000001U,
    LOG_POLICY_PERSIST   = 0x00000002U,
}

enum uint CLFS_MGMT_CLIENT_REGISTRATION_VERSION = 0x00000001U;
enum GUID CLSID_DiskQuotaControl = GUID("7988b571-ec89-11cf-9c00-00aa00a14f56");

enum : uint
{
    DISKQUOTA_STATE_DISABLED         = 0x00000000U,
    DISKQUOTA_STATE_TRACK            = 0x00000001U,
    DISKQUOTA_STATE_ENFORCE          = 0x00000002U,
    DISKQUOTA_STATE_MASK             = 0x00000003U,
    DISKQUOTA_FILESTATE_INCOMPLETE   = 0x00000100U,
    DISKQUOTA_FILESTATE_REBUILDING   = 0x00000200U,
    DISKQUOTA_FILESTATE_MASK         = 0x00000300U,
    DISKQUOTA_LOGFLAG_USER_THRESHOLD = 0x00000001U,
    DISKQUOTA_LOGFLAG_USER_LIMIT     = 0x00000002U,
}

enum : uint
{
    DISKQUOTA_USER_ACCOUNT_RESOLVED    = 0x00000000U,
    DISKQUOTA_USER_ACCOUNT_UNAVAILABLE = 0x00000001U,
    DISKQUOTA_USER_ACCOUNT_DELETED     = 0x00000002U,
    DISKQUOTA_USER_ACCOUNT_INVALID     = 0x00000003U,
    DISKQUOTA_USER_ACCOUNT_UNKNOWN     = 0x00000004U,
    DISKQUOTA_USER_ACCOUNT_UNRESOLVED  = 0x00000005U,
}

enum : uint
{
    INVALID_FILE_SIZE        = 0xffffffffU,
    INVALID_SET_FILE_POINTER = 0xffffffffU,
}

enum uint INVALID_FILE_ATTRIBUTES = 0xffffffffU;
enum uint SHARE_NETNAME_PARMNUM = 0x00000001U;
enum uint SHARE_TYPE_PARMNUM = 0x00000003U;
enum uint SHARE_REMARK_PARMNUM = 0x00000004U;
enum uint SHARE_PERMISSIONS_PARMNUM = 0x00000005U;
enum uint SHARE_MAX_USES_PARMNUM = 0x00000006U;
enum uint SHARE_CURRENT_USES_PARMNUM = 0x00000007U;

enum : uint
{
    SHARE_PATH_PARMNUM   = 0x00000008U,
    SHARE_PASSWD_PARMNUM = 0x00000009U,
}

enum uint SHARE_FILE_SD_PARMNUM = 0x000001f5U;
enum uint SHARE_SERVER_PARMNUM = 0x000001f7U;
enum uint SHARE_QOS_POLICY_PARMNUM = 0x000001f8U;
enum uint SHI1_NUM_ELEMENTS = 0x00000004U;
enum uint SHI2_NUM_ELEMENTS = 0x0000000aU;

enum : uint
{
    STYPE_RESERVED1    = 0x01000000U,
    STYPE_RESERVED2    = 0x02000000U,
    STYPE_RESERVED3    = 0x04000000U,
    STYPE_RESERVED4    = 0x08000000U,
    STYPE_RESERVED5    = 0x00100000U,
    STYPE_RESERVED_ALL = 0x3fffff00U,
}

enum uint SHI_USES_UNLIMITED = 0xffffffffU;

enum : uint
{
    SHI1005_FLAGS_DFS      = 0x00000001U,
    SHI1005_FLAGS_DFS_ROOT = 0x00000002U,
}

enum : uint
{
    CSC_MASK_EXT           = 0x00002030U,
    CSC_MASK               = 0x00000030U,
    CSC_CACHE_MANUAL_REINT = 0x00000000U,
    CSC_CACHE_AUTO_REINT   = 0x00000010U,
    CSC_CACHE_VDO          = 0x00000020U,
    CSC_CACHE_NONE         = 0x00000030U,
}

enum uint SHI1005_FLAGS_RESTRICT_EXCLUSIVE_OPENS = 0x00000100U;

enum : uint
{
    SHI1005_FLAGS_FORCE_SHARED_DELETE         = 0x00000200U,
    SHI1005_FLAGS_ALLOW_NAMESPACE_CACHING     = 0x00000400U,
    SHI1005_FLAGS_ACCESS_BASED_DIRECTORY_ENUM = 0x00000800U,
}

enum : uint
{
    SHI1005_FLAGS_FORCE_LEVELII_OPLOCK     = 0x00001000U,
    SHI1005_FLAGS_ENABLE_HASH              = 0x00002000U,
    SHI1005_FLAGS_ENABLE_CA                = 0x00004000U,
    SHI1005_FLAGS_ENCRYPT_DATA             = 0x00008000U,
    SHI1005_FLAGS_RESERVED                 = 0x00010000U,
    SHI1005_FLAGS_DISABLE_CLIENT_BUFFERING = 0x00020000U,
}

enum : uint
{
    SHI1005_FLAGS_IDENTITY_REMOTING                = 0x00040000U,
    SHI1005_FLAGS_CLUSTER_MANAGED                  = 0x00080000U,
    SHI1005_FLAGS_COMPRESS_DATA                    = 0x00100000U,
    SHI1005_FLAGS_ISOLATED_TRANSPORT               = 0x00200000U,
    SHI1005_FLAGS_DISABLE_DIRECTORY_HANDLE_LEASING = 0x00400000U,
}

enum uint SESI1_NUM_ELEMENTS = 0x00000008U;
enum uint SESI2_NUM_ELEMENTS = 0x00000009U;
enum uint STATSOPT_CLR = 0x00000001U;

enum : int
{
    LZERROR_BADINHANDLE  = 0xffffffff,
    LZERROR_BADOUTHANDLE = 0xfffffffe,
}

enum : int
{
    LZERROR_READ       = 0xfffffffd,
    LZERROR_WRITE      = 0xfffffffc,
    LZERROR_GLOBALLOC  = 0xfffffffb,
    LZERROR_GLOBLOCK   = 0xfffffffa,
    LZERROR_BADVALUE   = 0xfffffff9,
    LZERROR_UNKNOWNALG = 0xfffffff8,
}

enum uint NTMS_OBJECTNAME_LENGTH = 0x00000040U;
enum uint NTMS_DESCRIPTION_LENGTH = 0x0000007fU;
enum uint NTMS_DEVICENAME_LENGTH = 0x00000040U;
enum uint NTMS_SERIALNUMBER_LENGTH = 0x00000020U;
enum uint NTMS_REVISION_LENGTH = 0x00000020U;
enum uint NTMS_BARCODE_LENGTH = 0x00000040U;
enum uint NTMS_SEQUENCE_LENGTH = 0x00000020U;
enum uint NTMS_VENDORNAME_LENGTH = 0x00000080U;
enum uint NTMS_PRODUCTNAME_LENGTH = 0x00000080U;
enum uint NTMS_USERNAME_LENGTH = 0x00000040U;
enum uint NTMS_APPLICATIONNAME_LENGTH = 0x00000040U;
enum uint NTMS_COMPUTERNAME_LENGTH = 0x00000040U;
enum uint NTMS_I1_MESSAGE_LENGTH = 0x0000007fU;
enum uint NTMS_MESSAGE_LENGTH = 0x00000100U;
enum uint NTMS_POOLHIERARCHY_LENGTH = 0x00000200U;

enum : uint
{
    NTMS_OMIDLABELID_LENGTH   = 0x000000ffU,
    NTMS_OMIDLABELTYPE_LENGTH = 0x00000040U,
    NTMS_OMIDLABELINFO_LENGTH = 0x00000100U,
}

enum : uint
{
    NTMS_MAXATTR_LENGTH  = 0x00010000U,
    NTMS_MAXATTR_NAMELEN = 0x00000020U,
}

enum : uint
{
    NTMSMLI_MAXTYPE     = 0x00000040U,
    NTMSMLI_MAXIDSIZE   = 0x00000100U,
    NTMSMLI_MAXAPPDESCR = 0x00000100U,
}

enum : uint
{
    TXF_LOG_RECORD_GENERIC_TYPE_COMMIT  = 0x00000001U,
    TXF_LOG_RECORD_GENERIC_TYPE_ABORT   = 0x00000002U,
    TXF_LOG_RECORD_GENERIC_TYPE_PREPARE = 0x00000004U,
    TXF_LOG_RECORD_GENERIC_TYPE_DATA    = 0x00000008U,
}

enum uint VS_VERSION_INFO = 0x00000001U;
enum uint VS_USER_DEFINED = 0x00000064U;

enum : int
{
    VS_FFI_SIGNATURE    = 0xfeef04bd,
    VS_FFI_STRUCVERSION = 0x00010000,
}

enum int VS_FFI_FILEFLAGSMASK = 0x0000003f;
enum uint WINEFS_SETUSERKEY_SET_CAPABILITIES = 0x00000001U;

enum : uint
{
    EFS_COMPATIBILITY_VERSION_NCRYPT_PROTECTOR = 0x00000005U,
    EFS_COMPATIBILITY_VERSION_PFILE_PROTECTOR  = 0x00000006U,
}

enum uint EFS_SUBVER_UNKNOWN = 0x00000000U;
enum uint EFS_EFS_SUBVER_EFS_CERT = 0x00000001U;

enum : uint
{
    EFS_PFILE_SUBVER_RMS  = 0x00000002U,
    EFS_PFILE_SUBVER_APPX = 0x00000003U,
}

enum uint MAX_SID_SIZE = 0x00000100U;

enum : uint
{
    EFS_METADATA_ADD_USER     = 0x00000001U,
    EFS_METADATA_REMOVE_USER  = 0x00000002U,
    EFS_METADATA_REPLACE_USER = 0x00000004U,
    EFS_METADATA_GENERAL_OP   = 0x00000008U,
}

enum : uint
{
    WOF_PROVIDER_WIM  = 0x00000001U,
    WOF_PROVIDER_FILE = 0x00000002U,
}

enum uint WIM_PROVIDER_HASH_SIZE = 0x00000014U;

enum : uint
{
    WIM_BOOT_OS_WIM     = 0x00000001U,
    WIM_BOOT_NOT_OS_WIM = 0x00000000U,
}

enum : uint
{
    WIM_ENTRY_FLAG_NOT_ACTIVE = 0x00000001U,
    WIM_ENTRY_FLAG_SUSPENDED  = 0x00000002U,
}

enum : uint
{
    WIM_EXTERNAL_FILE_INFO_FLAG_NOT_ACTIVE = 0x00000001U,
    WIM_EXTERNAL_FILE_INFO_FLAG_SUSPENDED  = 0x00000002U,
}

enum : uint
{
    FILE_PROVIDER_COMPRESSION_XPRESS4K  = 0x00000000U,
    FILE_PROVIDER_COMPRESSION_LZX       = 0x00000001U,
    FILE_PROVIDER_COMPRESSION_XPRESS8K  = 0x00000002U,
    FILE_PROVIDER_COMPRESSION_XPRESS16K = 0x00000003U,
}

enum int COPYFILE2_MESSAGE_COPY_OFFLOAD = 0x00000001;

enum : uint
{
    COPYFILE2_IO_CYCLE_SIZE_MIN = 0x00001000U,
    COPYFILE2_IO_CYCLE_SIZE_MAX = 0x40000000U,
    COPYFILE2_IO_RATE_MIN       = 0x00000200U,
}

enum ubyte ClfsNullRecord = 0x00;
enum ubyte ClfsDataRecord = 0x01;
enum ubyte ClfsRestartRecord = 0x02;
enum ubyte ClfsClientRecord = 0x03;

enum : uint
{
    ClsContainerInitializing        = 0x00000001U,
    ClsContainerInactive            = 0x00000002U,
    ClsContainerActive              = 0x00000004U,
    ClsContainerActivePendingDelete = 0x00000008U,
}

enum : uint
{
    ClsContainerPendingArchive          = 0x00000010U,
    ClsContainerPendingArchiveAndDelete = 0x00000020U,
}

enum : uint
{
    ClfsContainerInitializing            = 0x00000001U,
    ClfsContainerInactive                = 0x00000002U,
    ClfsContainerActive                  = 0x00000004U,
    ClfsContainerActivePendingDelete     = 0x00000008U,
    ClfsContainerPendingArchive          = 0x00000010U,
    ClfsContainerPendingArchiveAndDelete = 0x00000020U,
}

enum uint CLFS_MAX_CONTAINER_INFO = 0x00000100U;

enum : ubyte
{
    CLFS_SCAN_INIT        = 0x01,
    CLFS_SCAN_FORWARD     = 0x02,
    CLFS_SCAN_BACKWARD    = 0x04,
    CLFS_SCAN_CLOSE       = 0x08,
    CLFS_SCAN_INITIALIZED = 0x10,
    CLFS_SCAN_BUFFERED    = 0x20,
}

// Callbacks

alias MAXMEDIALABEL = uint function(uint* pMaxSize);
alias CLAIMMEDIALABEL = uint function(const(ubyte)* pBuffer, const(uint) nBufferSize, MediaLabelInfo* pLabelInfo);
alias CLAIMMEDIALABELEX = uint function(const(ubyte)* pBuffer, const(uint) nBufferSize, MediaLabelInfo* pLabelInfo, 
                                        GUID* LabelGuid);
alias CLFS_BLOCK_ALLOCATION = void* function(uint cbBufferLength, void* pvUserContext);
alias CLFS_BLOCK_DEALLOCATION = void function(void* pvBuffer, void* pvUserContext);
alias PCLFS_COMPLETION_ROUTINE = void function(void* pvOverlapped, uint ulReserved);
alias PLOG_TAIL_ADVANCE_CALLBACK = void function(HANDLE hLogFile, CLS_LSN lsnTarget, void* pvClientContext);
alias PLOG_FULL_HANDLER_CALLBACK = void function(HANDLE hLogFile, uint dwError, BOOL fLogIsPinned, 
                                                 void* pvClientContext);
alias PLOG_UNPINNED_CALLBACK = void function(HANDLE hLogFile, void* pvClientContext);
alias WofEnumEntryProc = BOOL function(const(void)* EntryInfo, void* UserData);
alias WofEnumFilesProc = BOOL function(const(PWSTR) FilePath, void* ExternalFileInfo, void* UserData);
alias PFN_IO_COMPLETION = void function(FIO_CONTEXT* pContext, FH_OVERLAPPED* lpo, uint cb, 
                                        uint dwCompletionStatus);
alias FCACHE_CREATE_CALLBACK = HANDLE function(PSTR lpstrName, void* lpvData, uint* cbFileSize, 
                                               uint* cbFileSizeHigh);
alias FCACHE_RICHCREATE_CALLBACK = HANDLE function(PSTR lpstrName, void* lpvData, uint* cbFileSize, 
                                                   uint* cbFileSizeHigh, BOOL* pfDidWeScanIt, BOOL* pfIsStuffed, 
                                                   BOOL* pfStoredWithDots, BOOL* pfStoredWithTerminatingDot);
alias CACHE_KEY_COMPARE = int function(uint cbKey1, ubyte* lpbKey1, uint cbKey2, ubyte* lpbKey2);
alias CACHE_KEY_HASH = uint function(ubyte* lpbKey, uint cbKey);
alias CACHE_READ_CALLBACK = BOOL function(uint cb, ubyte* lpb, void* lpvContext);
alias CACHE_DESTROY_CALLBACK = void function(uint cb, ubyte* lpb);
alias CACHE_ACCESS_CHECK = BOOL function(PSECURITY_DESCRIPTOR pSecurityDescriptor, HANDLE hClientToken, 
                                         uint dwDesiredAccess, GENERIC_MAPPING* GenericMapping, 
                                         PRIVILEGE_SET* PrivilegeSet, uint* PrivilegeSetLength, uint* GrantedAccess, 
                                         BOOL* AccessStatus);
alias PFE_EXPORT_FUNC = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pbData, 
                                      void* pvCallbackContext, uint ulLength);
alias PFE_IMPORT_FUNC = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pbData, 
                                      void* pvCallbackContext, uint* ulLength);
alias LPPROGRESS_ROUTINE = COPYPROGRESSROUTINE_PROGRESS function(long TotalFileSize, long TotalBytesTransferred, 
                                                                 long StreamSize, long StreamBytesTransferred, 
                                                                 uint dwStreamNumber, 
                                                                 LPPROGRESS_ROUTINE_CALLBACK_REASON dwCallbackReason, 
                                                                 HANDLE hSourceFile, HANDLE hDestinationFile, 
                                                                 void* lpData);
alias PCOPYFILE2_PROGRESS_ROUTINE = COPYFILE2_MESSAGE_ACTION function(const(COPYFILE2_MESSAGE)* pMessage, 
                                                                      void* pvCallbackContext);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_disposition_info
struct FILE_DISPOSITION_INFO
{
    BOOLEAN DeleteFile;
}

@RAIIFree!CloseIoRing
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HIORING
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-win32_find_dataa
struct WIN32_FIND_DATAA
{
    uint      dwFileAttributes;
    FILETIME  ftCreationTime;
    FILETIME  ftLastAccessTime;
    FILETIME  ftLastWriteTime;
    uint      nFileSizeHigh;
    uint      nFileSizeLow;
    uint      dwReserved0;
    uint      dwReserved1;
    CHAR[260] cFileName;
    CHAR[14]  cAlternateFileName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-win32_find_dataw
struct WIN32_FIND_DATAW
{
    uint       dwFileAttributes;
    FILETIME   ftCreationTime;
    FILETIME   ftLastAccessTime;
    FILETIME   ftLastWriteTime;
    uint       nFileSizeHigh;
    uint       nFileSizeLow;
    uint       dwReserved0;
    uint       dwReserved1;
    wchar[260] cFileName;
    wchar[14]  cAlternateFileName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ktmtypes/ns-ktmtypes-transaction_notification
struct TRANSACTION_NOTIFICATION
{
    void* TransactionKey;
    uint  TransactionNotification;
    long  TmVirtualClock;
    uint  ArgumentLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ktmtypes/ns-ktmtypes-transaction_notification_recovery_argument
struct TRANSACTION_NOTIFICATION_RECOVERY_ARGUMENT
{
    GUID EnlistmentId;
    GUID UOW;
}

struct TRANSACTION_NOTIFICATION_TM_ONLINE_ARGUMENT
{
    GUID TmIdentity;
    uint Flags;
}

struct TRANSACTION_NOTIFICATION_SAVEPOINT_ARGUMENT
{
    uint SavepointId;
}

struct TRANSACTION_NOTIFICATION_PROPAGATE_ARGUMENT
{
    uint PropagationCookie;
    GUID UOW;
    GUID TmIdentity;
    uint BufferLength;
}

struct TRANSACTION_NOTIFICATION_MARSHAL_ARGUMENT
{
    uint MarshalCookie;
    GUID UOW;
}

struct KCRM_MARSHAL_HEADER
{
    uint VersionMajor;
    uint VersionMinor;
    uint NumProtocols;
    uint Unused;
}

struct KCRM_TRANSACTION_BLOB
{
    GUID      UOW;
    GUID      TmIdentity;
    uint      IsolationLevel;
    uint      IsolationFlags;
    uint      Timeout;
    wchar[64] Description;
}

struct KCRM_PROTOCOL_BLOB
{
    GUID ProtocolId;
    uint StaticInfoLength;
    uint TransactionIdInfoLength;
    uint Unused1;
    uint Unused2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapi/ns-fileapi-disk_space_information
struct DISK_SPACE_INFORMATION
{
    ulong ActualTotalAllocationUnits;
    ulong ActualAvailableAllocationUnits;
    ulong ActualPoolUnavailableAllocationUnits;
    ulong CallerTotalAllocationUnits;
    ulong CallerAvailableAllocationUnits;
    ulong CallerPoolUnavailableAllocationUnits;
    ulong UsedAllocationUnits;
    ulong TotalReservedAllocationUnits;
    ulong VolumeStorageReserveAllocationUnits;
    ulong AvailableCommittedAllocationUnits;
    ulong PoolAvailableAllocationUnits;
    uint  SectorsPerAllocationUnit;
    uint  BytesPerSector;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapi/ns-fileapi-win32_file_attribute_data
struct WIN32_FILE_ATTRIBUTE_DATA
{
    uint     dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    uint     nFileSizeHigh;
    uint     nFileSizeLow;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapi/ns-fileapi-by_handle_file_information
struct BY_HANDLE_FILE_INFORMATION
{
    uint     dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    uint     dwVolumeSerialNumber;
    uint     nFileSizeHigh;
    uint     nFileSizeLow;
    uint     nNumberOfLinks;
    uint     nFileIndexHigh;
    uint     nFileIndexLow;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapi/ns-fileapi-createfile2_extended_parameters
struct CREATEFILE2_EXTENDED_PARAMETERS
{
    uint                 dwSize;
    uint                 dwFileAttributes;
    uint                 dwFileFlags;
    uint                 dwSecurityQosFlags;
    SECURITY_ATTRIBUTES* lpSecurityAttributes;
    HANDLE               hTemplateFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapi/ns-fileapi-win32_find_stream_data
struct WIN32_FIND_STREAM_DATA
{
    long       StreamSize;
    wchar[296] cStreamName;
}

struct CREATEFILE3_EXTENDED_PARAMETERS
{
    uint                 dwSize;
    uint                 dwFileAttributes;
    uint                 dwFileFlags;
    uint                 dwSecurityQosFlags;
    SECURITY_ATTRIBUTES* lpSecurityAttributes;
    HANDLE               hTemplateFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/verrsrc/ns-verrsrc-vs_fixedfileinfo
struct VS_FIXEDFILEINFO
{
    uint dwSignature;
    uint dwStrucVersion;
    uint dwFileVersionMS;
    uint dwFileVersionLS;
    uint dwProductVersionMS;
    uint dwProductVersionLS;
    uint dwFileFlagsMask;
    VS_FIXEDFILEINFO_FILE_FLAGS dwFileFlags;
    VS_FIXEDFILEINFO_FILE_OS dwFileOS;
    uint dwFileType;
    uint dwFileSubtype;
    uint dwFileDateMS;
    uint dwFileDateLS;
}

struct NTMS_ASYNC_IO
{
    GUID   OperationId;
    GUID   EventId;
    uint   dwOperationType;
    uint   dwResult;
    uint   dwAsyncState;
    HANDLE hEvent;
    BOOL   bOnStateChange;
}

struct NTMS_MOUNT_INFORMATION
{
    uint  dwSize;
    void* lpReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_allocation_information
struct NTMS_ALLOCATION_INFORMATION
{
    uint  dwSize;
    void* lpReserved;
    GUID  AllocatedFrom;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_driveinformationa
struct NTMS_DRIVEINFORMATIONA
{
    uint       Number;
    uint       State;
    GUID       DriveType;
    CHAR[64]   szDeviceName;
    CHAR[32]   szSerialNumber;
    CHAR[32]   szRevision;
    ushort     ScsiPort;
    ushort     ScsiBus;
    ushort     ScsiTarget;
    ushort     ScsiLun;
    uint       dwMountCount;
    SYSTEMTIME LastCleanedTs;
    GUID       SavedPartitionId;
    GUID       Library;
    GUID       Reserved;
    uint       dwDeferDismountDelay;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_driveinformationw
struct NTMS_DRIVEINFORMATIONW
{
    uint       Number;
    uint       State;
    GUID       DriveType;
    wchar[64]  szDeviceName;
    wchar[32]  szSerialNumber;
    wchar[32]  szRevision;
    ushort     ScsiPort;
    ushort     ScsiBus;
    ushort     ScsiTarget;
    ushort     ScsiLun;
    uint       dwMountCount;
    SYSTEMTIME LastCleanedTs;
    GUID       SavedPartitionId;
    GUID       Library;
    GUID       Reserved;
    uint       dwDeferDismountDelay;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_libraryinformation
struct NTMS_LIBRARYINFORMATION
{
    uint LibraryType;
    GUID CleanerSlot;
    GUID CleanerSlotDefault;
    BOOL LibrarySupportsDriveCleaning;
    BOOL BarCodeReaderInstalled;
    uint InventoryMethod;
    uint dwCleanerUsesRemaining;
    uint FirstDriveNumber;
    uint dwNumberOfDrives;
    uint FirstSlotNumber;
    uint dwNumberOfSlots;
    uint FirstDoorNumber;
    uint dwNumberOfDoors;
    uint FirstPortNumber;
    uint dwNumberOfPorts;
    uint FirstChangerNumber;
    uint dwNumberOfChangers;
    uint dwNumberOfMedia;
    uint dwNumberOfMediaTypes;
    uint dwNumberOfLibRequests;
    GUID Reserved;
    BOOL AutoRecovery;
    uint dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_changerinformationa
struct NTMS_CHANGERINFORMATIONA
{
    uint     Number;
    GUID     ChangerType;
    CHAR[32] szSerialNumber;
    CHAR[32] szRevision;
    CHAR[64] szDeviceName;
    ushort   ScsiPort;
    ushort   ScsiBus;
    ushort   ScsiTarget;
    ushort   ScsiLun;
    GUID     Library;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_changerinformationw
struct NTMS_CHANGERINFORMATIONW
{
    uint      Number;
    GUID      ChangerType;
    wchar[32] szSerialNumber;
    wchar[32] szRevision;
    wchar[64] szDeviceName;
    ushort    ScsiPort;
    ushort    ScsiBus;
    ushort    ScsiTarget;
    ushort    ScsiLun;
    GUID      Library;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_storageslotinformation
struct NTMS_STORAGESLOTINFORMATION
{
    uint Number;
    uint State;
    GUID Library;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_iedoorinformation
struct NTMS_IEDOORINFORMATION
{
    uint   Number;
    uint   State;
    ushort MaxOpenSecs;
    GUID   Library;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_ieportinformation
struct NTMS_IEPORTINFORMATION
{
    uint   Number;
    uint   Content;
    uint   Position;
    ushort MaxExtendSecs;
    GUID   Library;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_pmidinformationa
struct NTMS_PMIDINFORMATIONA
{
    GUID     CurrentLibrary;
    GUID     MediaPool;
    GUID     Location;
    uint     LocationType;
    GUID     MediaType;
    GUID     HomeSlot;
    CHAR[64] szBarCode;
    uint     BarCodeState;
    CHAR[32] szSequenceNumber;
    uint     MediaState;
    uint     dwNumberOfPartitions;
    uint     dwMediaTypeCode;
    uint     dwDensityCode;
    GUID     MountedPartition;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_pmidinformationw
struct NTMS_PMIDINFORMATIONW
{
    GUID      CurrentLibrary;
    GUID      MediaPool;
    GUID      Location;
    uint      LocationType;
    GUID      MediaType;
    GUID      HomeSlot;
    wchar[64] szBarCode;
    uint      BarCodeState;
    wchar[32] szSequenceNumber;
    uint      MediaState;
    uint      dwNumberOfPartitions;
    uint      dwMediaTypeCode;
    uint      dwDensityCode;
    GUID      MountedPartition;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_lmidinformation
struct NTMS_LMIDINFORMATION
{
    GUID MediaPool;
    uint dwNumberOfPartitions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_partitioninformationa
struct NTMS_PARTITIONINFORMATIONA
{
    GUID       PhysicalMedia;
    GUID       LogicalMedia;
    uint       State;
    ushort     Side;
    uint       dwOmidLabelIdLength;
    ubyte[255] OmidLabelId;
    CHAR[64]   szOmidLabelType;
    CHAR[256]  szOmidLabelInfo;
    uint       dwMountCount;
    uint       dwAllocateCount;
    long       Capacity;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_partitioninformationw
struct NTMS_PARTITIONINFORMATIONW
{
    GUID       PhysicalMedia;
    GUID       LogicalMedia;
    uint       State;
    ushort     Side;
    uint       dwOmidLabelIdLength;
    ubyte[255] OmidLabelId;
    wchar[64]  szOmidLabelType;
    wchar[256] szOmidLabelInfo;
    uint       dwMountCount;
    uint       dwAllocateCount;
    long       Capacity;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_mediapoolinformation
struct NTMS_MEDIAPOOLINFORMATION
{
    uint PoolType;
    GUID MediaType;
    GUID Parent;
    uint AllocationPolicy;
    uint DeallocationPolicy;
    uint dwMaxAllocates;
    uint dwNumberOfPhysicalMedia;
    uint dwNumberOfLogicalMedia;
    uint dwNumberOfMediaPools;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_mediatypeinformation
struct NTMS_MEDIATYPEINFORMATION
{
    uint             MediaType;
    uint             NumberOfSides;
    uint             ReadWriteCharacteristics;
    FILE_DEVICE_TYPE DeviceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_drivetypeinformationa
struct NTMS_DRIVETYPEINFORMATIONA
{
    CHAR[128]        szVendor;
    CHAR[128]        szProduct;
    uint             NumberOfHeads;
    FILE_DEVICE_TYPE DeviceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_drivetypeinformationw
struct NTMS_DRIVETYPEINFORMATIONW
{
    wchar[128]       szVendor;
    wchar[128]       szProduct;
    uint             NumberOfHeads;
    FILE_DEVICE_TYPE DeviceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_changertypeinformationa
struct NTMS_CHANGERTYPEINFORMATIONA
{
    CHAR[128] szVendor;
    CHAR[128] szProduct;
    uint      DeviceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_changertypeinformationw
struct NTMS_CHANGERTYPEINFORMATIONW
{
    wchar[128] szVendor;
    wchar[128] szProduct;
    uint       DeviceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_librequestinformationa
struct NTMS_LIBREQUESTINFORMATIONA
{
    uint       OperationCode;
    uint       OperationOption;
    uint       State;
    GUID       PartitionId;
    GUID       DriveId;
    GUID       PhysMediaId;
    GUID       Library;
    GUID       SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    CHAR[64]   szApplication;
    CHAR[64]   szUser;
    CHAR[64]   szComputer;
    uint       dwErrorCode;
    GUID       WorkItemId;
    uint       dwPriority;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_librequestinformationw
struct NTMS_LIBREQUESTINFORMATIONW
{
    uint       OperationCode;
    uint       OperationOption;
    uint       State;
    GUID       PartitionId;
    GUID       DriveId;
    GUID       PhysMediaId;
    GUID       Library;
    GUID       SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    wchar[64]  szApplication;
    wchar[64]  szUser;
    wchar[64]  szComputer;
    uint       dwErrorCode;
    GUID       WorkItemId;
    uint       dwPriority;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_oprequestinformationa
struct NTMS_OPREQUESTINFORMATIONA
{
    uint       Request;
    SYSTEMTIME Submitted;
    uint       State;
    CHAR[256]  szMessage;
    uint       Arg1Type;
    GUID       Arg1;
    uint       Arg2Type;
    GUID       Arg2;
    CHAR[64]   szApplication;
    CHAR[64]   szUser;
    CHAR[64]   szComputer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_oprequestinformationw
struct NTMS_OPREQUESTINFORMATIONW
{
    uint       Request;
    SYSTEMTIME Submitted;
    uint       State;
    wchar[256] szMessage;
    uint       Arg1Type;
    GUID       Arg1;
    uint       Arg2Type;
    GUID       Arg2;
    wchar[64]  szApplication;
    wchar[64]  szUser;
    wchar[64]  szComputer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_computerinformation
struct NTMS_COMPUTERINFORMATION
{
    uint dwLibRequestPurgeTime;
    uint dwOpRequestPurgeTime;
    uint dwLibRequestFlags;
    uint dwOpRequestFlags;
    uint dwMediaPoolPolicy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_objectinformationa
struct NTMS_OBJECTINFORMATIONA
{
    uint       dwSize;
    uint       dwType;
    SYSTEMTIME Created;
    SYSTEMTIME Modified;
    GUID       ObjectGuid;
    BOOL       Enabled;
    uint       dwOperationalState;
    CHAR[64]   szName;
    CHAR[127]  szDescription;
    union Info
    {
        NTMS_DRIVEINFORMATIONA Drive;
        NTMS_DRIVETYPEINFORMATIONA DriveType;
        NTMS_LIBRARYINFORMATION Library;
        NTMS_CHANGERINFORMATIONA Changer;
        NTMS_CHANGERTYPEINFORMATIONA ChangerType;
        NTMS_STORAGESLOTINFORMATION StorageSlot;
        NTMS_IEDOORINFORMATION IEDoor;
        NTMS_IEPORTINFORMATION IEPort;
        NTMS_PMIDINFORMATIONA PhysicalMedia;
        NTMS_LMIDINFORMATION LogicalMedia;
        NTMS_PARTITIONINFORMATIONA Partition;
        NTMS_MEDIAPOOLINFORMATION MediaPool;
        NTMS_MEDIATYPEINFORMATION MediaType;
        NTMS_LIBREQUESTINFORMATIONA LibRequest;
        NTMS_OPREQUESTINFORMATIONA OpRequest;
        NTMS_COMPUTERINFORMATION Computer;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_objectinformationw
struct NTMS_OBJECTINFORMATIONW
{
    uint       dwSize;
    uint       dwType;
    SYSTEMTIME Created;
    SYSTEMTIME Modified;
    GUID       ObjectGuid;
    BOOL       Enabled;
    uint       dwOperationalState;
    wchar[64]  szName;
    wchar[127] szDescription;
    union Info
    {
        NTMS_DRIVEINFORMATIONW Drive;
        NTMS_DRIVETYPEINFORMATIONW DriveType;
        NTMS_LIBRARYINFORMATION Library;
        NTMS_CHANGERINFORMATIONW Changer;
        NTMS_CHANGERTYPEINFORMATIONW ChangerType;
        NTMS_STORAGESLOTINFORMATION StorageSlot;
        NTMS_IEDOORINFORMATION IEDoor;
        NTMS_IEPORTINFORMATION IEPort;
        NTMS_PMIDINFORMATIONW PhysicalMedia;
        NTMS_LMIDINFORMATION LogicalMedia;
        NTMS_PARTITIONINFORMATIONW Partition;
        NTMS_MEDIAPOOLINFORMATION MediaPool;
        NTMS_MEDIATYPEINFORMATION MediaType;
        NTMS_LIBREQUESTINFORMATIONW LibRequest;
        NTMS_OPREQUESTINFORMATIONW OpRequest;
        NTMS_COMPUTERINFORMATION Computer;
    }
}

struct NTMS_I1_LIBRARYINFORMATION
{
    uint LibraryType;
    GUID CleanerSlot;
    GUID CleanerSlotDefault;
    BOOL LibrarySupportsDriveCleaning;
    BOOL BarCodeReaderInstalled;
    uint InventoryMethod;
    uint dwCleanerUsesRemaining;
    uint FirstDriveNumber;
    uint dwNumberOfDrives;
    uint FirstSlotNumber;
    uint dwNumberOfSlots;
    uint FirstDoorNumber;
    uint dwNumberOfDoors;
    uint FirstPortNumber;
    uint dwNumberOfPorts;
    uint FirstChangerNumber;
    uint dwNumberOfChangers;
    uint dwNumberOfMedia;
    uint dwNumberOfMediaTypes;
    uint dwNumberOfLibRequests;
    GUID Reserved;
}

struct NTMS_I1_LIBREQUESTINFORMATIONA
{
    uint       OperationCode;
    uint       OperationOption;
    uint       State;
    GUID       PartitionId;
    GUID       DriveId;
    GUID       PhysMediaId;
    GUID       Library;
    GUID       SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    CHAR[64]   szApplication;
    CHAR[64]   szUser;
    CHAR[64]   szComputer;
}

struct NTMS_I1_LIBREQUESTINFORMATIONW
{
    uint       OperationCode;
    uint       OperationOption;
    uint       State;
    GUID       PartitionId;
    GUID       DriveId;
    GUID       PhysMediaId;
    GUID       Library;
    GUID       SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    wchar[64]  szApplication;
    wchar[64]  szUser;
    wchar[64]  szComputer;
}

struct NTMS_I1_PMIDINFORMATIONA
{
    GUID     CurrentLibrary;
    GUID     MediaPool;
    GUID     Location;
    uint     LocationType;
    GUID     MediaType;
    GUID     HomeSlot;
    CHAR[64] szBarCode;
    uint     BarCodeState;
    CHAR[32] szSequenceNumber;
    uint     MediaState;
    uint     dwNumberOfPartitions;
}

struct NTMS_I1_PMIDINFORMATIONW
{
    GUID      CurrentLibrary;
    GUID      MediaPool;
    GUID      Location;
    uint      LocationType;
    GUID      MediaType;
    GUID      HomeSlot;
    wchar[64] szBarCode;
    uint      BarCodeState;
    wchar[32] szSequenceNumber;
    uint      MediaState;
    uint      dwNumberOfPartitions;
}

struct NTMS_I1_PARTITIONINFORMATIONA
{
    GUID       PhysicalMedia;
    GUID       LogicalMedia;
    uint       State;
    ushort     Side;
    uint       dwOmidLabelIdLength;
    ubyte[255] OmidLabelId;
    CHAR[64]   szOmidLabelType;
    CHAR[256]  szOmidLabelInfo;
    uint       dwMountCount;
    uint       dwAllocateCount;
}

struct NTMS_I1_PARTITIONINFORMATIONW
{
    GUID       PhysicalMedia;
    GUID       LogicalMedia;
    uint       State;
    ushort     Side;
    uint       dwOmidLabelIdLength;
    ubyte[255] OmidLabelId;
    wchar[64]  szOmidLabelType;
    wchar[256] szOmidLabelInfo;
    uint       dwMountCount;
    uint       dwAllocateCount;
}

struct NTMS_I1_OPREQUESTINFORMATIONA
{
    uint       Request;
    SYSTEMTIME Submitted;
    uint       State;
    CHAR[127]  szMessage;
    uint       Arg1Type;
    GUID       Arg1;
    uint       Arg2Type;
    GUID       Arg2;
    CHAR[64]   szApplication;
    CHAR[64]   szUser;
    CHAR[64]   szComputer;
}

struct NTMS_I1_OPREQUESTINFORMATIONW
{
    uint       Request;
    SYSTEMTIME Submitted;
    uint       State;
    wchar[127] szMessage;
    uint       Arg1Type;
    GUID       Arg1;
    uint       Arg2Type;
    GUID       Arg2;
    wchar[64]  szApplication;
    wchar[64]  szUser;
    wchar[64]  szComputer;
}

struct NTMS_I1_OBJECTINFORMATIONA
{
    uint       dwSize;
    uint       dwType;
    SYSTEMTIME Created;
    SYSTEMTIME Modified;
    GUID       ObjectGuid;
    BOOL       Enabled;
    uint       dwOperationalState;
    CHAR[64]   szName;
    CHAR[127]  szDescription;
    union Info
    {
        NTMS_DRIVEINFORMATIONA Drive;
        NTMS_DRIVETYPEINFORMATIONA DriveType;
        NTMS_I1_LIBRARYINFORMATION Library;
        NTMS_CHANGERINFORMATIONA Changer;
        NTMS_CHANGERTYPEINFORMATIONA ChangerType;
        NTMS_STORAGESLOTINFORMATION StorageSlot;
        NTMS_IEDOORINFORMATION IEDoor;
        NTMS_IEPORTINFORMATION IEPort;
        NTMS_I1_PMIDINFORMATIONA PhysicalMedia;
        NTMS_LMIDINFORMATION LogicalMedia;
        NTMS_I1_PARTITIONINFORMATIONA Partition;
        NTMS_MEDIAPOOLINFORMATION MediaPool;
        NTMS_MEDIATYPEINFORMATION MediaType;
        NTMS_I1_LIBREQUESTINFORMATIONA LibRequest;
        NTMS_I1_OPREQUESTINFORMATIONA OpRequest;
    }
}

struct NTMS_I1_OBJECTINFORMATIONW
{
    uint       dwSize;
    uint       dwType;
    SYSTEMTIME Created;
    SYSTEMTIME Modified;
    GUID       ObjectGuid;
    BOOL       Enabled;
    uint       dwOperationalState;
    wchar[64]  szName;
    wchar[127] szDescription;
    union Info
    {
        NTMS_DRIVEINFORMATIONW Drive;
        NTMS_DRIVETYPEINFORMATIONW DriveType;
        NTMS_I1_LIBRARYINFORMATION Library;
        NTMS_CHANGERINFORMATIONW Changer;
        NTMS_CHANGERTYPEINFORMATIONW ChangerType;
        NTMS_STORAGESLOTINFORMATION StorageSlot;
        NTMS_IEDOORINFORMATION IEDoor;
        NTMS_IEPORTINFORMATION IEPort;
        NTMS_I1_PMIDINFORMATIONW PhysicalMedia;
        NTMS_LMIDINFORMATION LogicalMedia;
        NTMS_I1_PARTITIONINFORMATIONW Partition;
        NTMS_MEDIAPOOLINFORMATION MediaPool;
        NTMS_MEDIATYPEINFORMATION MediaType;
        NTMS_I1_LIBREQUESTINFORMATIONW LibRequest;
        NTMS_I1_OPREQUESTINFORMATIONW OpRequest;
    }
}

struct NTMS_FILESYSTEM_INFO
{
    wchar[64]  FileSystemType;
    wchar[256] VolumeName;
    uint       SerialNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsapi/ns-ntmsapi-ntms_notificationinformation
struct NTMS_NOTIFICATIONINFORMATION
{
    uint dwOperation;
    GUID ObjectId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntmsmli/ns-ntmsmli-medialabelinfo
struct MediaLabelInfo
{
    wchar[64]  LabelType;
    uint       LabelIDSize;
    ubyte[256] LabelID;
    wchar[256] LabelAppDescr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ns-clfs-cls_lsn
struct CLS_LSN
{
    ulong Internal;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ns-clfs-clfs_node_id
struct CLFS_NODE_ID
{
    uint cType;
    uint cbNode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ns-clfs-cls_write_entry
struct CLS_WRITE_ENTRY
{
    void* Buffer;
    uint  ByteLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ns-clfs-cls_information
struct CLS_INFORMATION
{
    long    TotalAvailable;
    long    CurrentAvailable;
    long    TotalReservation;
    ulong   BaseFileSize;
    ulong   ContainerSize;
    uint    TotalContainers;
    uint    FreeContainers;
    uint    TotalClients;
    uint    Attributes;
    uint    FlushThreshold;
    uint    SectorSize;
    CLS_LSN MinArchiveTailLsn;
    CLS_LSN BaseLsn;
    CLS_LSN LastFlushedLsn;
    CLS_LSN LastLsn;
    CLS_LSN RestartLsn;
    GUID    Identity;
}

struct CLFS_LOG_NAME_INFORMATION
{
    ushort   NameLengthInBytes;
    wchar[1] Name; // Flexible array
}

struct CLFS_STREAM_ID_INFORMATION
{
    ubyte StreamIdentifier;
}

struct CLFS_PHYSICAL_LSN_INFORMATION
{
    ubyte   StreamIdentifier;
    CLS_LSN VirtualLsn;
    CLS_LSN PhysicalLsn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ns-clfs-cls_container_information
struct CLS_CONTAINER_INFORMATION
{
    uint       FileAttributes;
    ulong      CreationTime;
    ulong      LastAccessTime;
    ulong      LastWriteTime;
    long       ContainerSize;
    uint       FileNameActualLength;
    uint       FileNameLength;
    wchar[256] FileName;
    uint       State;
    uint       PhysicalContainerId;
    uint       LogicalContainerId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ns-clfs-cls_io_statistics_header
struct CLS_IO_STATISTICS_HEADER
{
    ubyte              ubMajorVersion;
    ubyte              ubMinorVersion;
    CLFS_IOSTATS_CLASS eStatsClass;
    ushort             cbLength;
    uint               coffData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ns-clfs-cls_io_statistics
struct CLS_IO_STATISTICS
{
    CLS_IO_STATISTICS_HEADER hdrIoStats;
    ulong cFlush;
    ulong cbFlush;
    ulong cMetaFlush;
    ulong cbMetaFlush;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ns-clfs-cls_scan_context~r1
struct CLS_SCAN_CONTEXT
{
    CLFS_NODE_ID cidNode;
    HANDLE       hLog;
    uint         cIndex;
    uint         cContainers;
    uint         cContainersReturned;
    ubyte        eScanMode;
    CLS_CONTAINER_INFORMATION* pinfoContainer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfs/ns-clfs-cls_archive_descriptor
struct CLS_ARCHIVE_DESCRIPTOR
{
    ulong coffLow;
    ulong coffHigh;
    CLS_CONTAINER_INFORMATION infoContainer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfsmgmt/ns-clfsmgmt-clfs_mgmt_policy
struct CLFS_MGMT_POLICY
{
    uint Version;
    uint LengthInBytes;
    uint PolicyFlags;
    CLFS_MGMT_POLICY_TYPE PolicyType;
    union PolicyParameters
    {
        struct MaximumSize
        {
            uint Containers;
        }
        struct MinimumSize
        {
            uint Containers;
        }
        struct NewContainerSize
        {
            uint SizeInBytes;
        }
        struct GrowthRate
        {
            uint AbsoluteGrowthInContainers;
            uint RelativeGrowthPercentage;
        }
        struct LogTail
        {
            uint MinimumAvailablePercentage;
            uint MinimumAvailableContainers;
        }
        struct AutoShrink
        {
            uint Percentage;
        }
        struct AutoGrow
        {
            uint Enabled;
        }
        struct NewContainerPrefix
        {
            ushort   PrefixLengthInBytes;
            wchar[1] PrefixString; // Flexible array
        }
        struct NewContainerSuffix
        {
            ulong NextContainerSuffix;
        }
        struct NewContainerExtension
        {
            ushort   ExtensionLengthInBytes;
            wchar[1] ExtensionString; // Flexible array
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfsmgmt/ns-clfsmgmt-clfs_mgmt_notification
struct CLFS_MGMT_NOTIFICATION
{
    CLFS_MGMT_NOTIFICATION_TYPE Notification;
    CLS_LSN Lsn;
    ushort  LogIsPinned;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clfsmgmtw32/ns-clfsmgmtw32-log_management_callbacks
struct LOG_MANAGEMENT_CALLBACKS
{
    void* CallbackContext;
    PLOG_TAIL_ADVANCE_CALLBACK AdvanceTailCallback;
    PLOG_FULL_HANDLER_CALLBACK LogFullHandlerCallback;
    PLOG_UNPINNED_CALLBACK LogUnpinnedCallback;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/ns-dskquota-diskquota_user_information
struct DISKQUOTA_USER_INFORMATION
{
    long QuotaUsed;
    long QuotaThreshold;
    long QuotaLimit;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winefs/ns-winefs-efs_certificate_blob
struct EFS_CERTIFICATE_BLOB
{
    uint   dwCertEncodingType;
    uint   cbData;
    ubyte* pbData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winefs/ns-winefs-efs_hash_blob
struct EFS_HASH_BLOB
{
    uint   cbData;
    ubyte* pbData;
}

struct EFS_RPC_BLOB
{
    uint   cbData;
    ubyte* pbData;
}

struct EFS_PIN_BLOB
{
    uint   cbPadding;
    uint   cbData;
    ubyte* pbData;
}

struct EFS_KEY_INFO
{
    uint   dwVersion;
    uint   Entropy;
    ALG_ID Algorithm;
    uint   KeyLength;
}

struct EFS_COMPATIBILITY_INFO
{
    uint EfsVersion;
}

struct EFS_VERSION_INFO
{
    uint EfsVersion;
    uint SubVersion;
}

struct EFS_DECRYPTION_STATUS_INFO
{
    uint dwDecryptionError;
    uint dwHashOffset;
    uint cbHash;
}

struct EFS_ENCRYPTION_STATUS_INFO
{
    BOOL bHasCurrentKey;
    uint dwEncryptionError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winefs/ns-winefs-encryption_certificate
struct ENCRYPTION_CERTIFICATE
{
    uint cbTotalLength;
    SID* pUserSid;
    EFS_CERTIFICATE_BLOB* pCertBlob;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winefs/ns-winefs-encryption_certificate_hash
struct ENCRYPTION_CERTIFICATE_HASH
{
    uint           cbTotalLength;
    SID*           pUserSid;
    EFS_HASH_BLOB* pHash;
    PWSTR          lpDisplayInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winefs/ns-winefs-encryption_certificate_hash_list
struct ENCRYPTION_CERTIFICATE_HASH_LIST
{
    uint nCert_Hash;
    ENCRYPTION_CERTIFICATE_HASH** pUsers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winefs/ns-winefs-encryption_certificate_list
struct ENCRYPTION_CERTIFICATE_LIST
{
    uint nUsers;
    ENCRYPTION_CERTIFICATE** pUsers;
}

struct ENCRYPTED_FILE_METADATA_SIGNATURE
{
    uint          dwEfsAccessType;
    ENCRYPTION_CERTIFICATE_HASH_LIST* pCertificatesAdded;
    ENCRYPTION_CERTIFICATE* pEncryptionCertificate;
    EFS_RPC_BLOB* pEfsStreamSignature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevNotes/encryption_protector-structure
struct ENCRYPTION_PROTECTOR
{
    uint  cbTotalLength;
    SID*  pUserSid;
    PWSTR lpProtectorDescriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevNotes/encryption_protector_list-structure
struct ENCRYPTION_PROTECTOR_LIST
{
    uint nProtectors;
    ENCRYPTION_PROTECTOR** pProtectors;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/ns-wofapi-wim_entry_info
struct WIM_ENTRY_INFO
{
    uint         WimEntryInfoSize;
    uint         WimType;
    long         DataSourceId;
    GUID         WimGuid;
    const(PWSTR) WimPath;
    uint         WimIndex;
    uint         Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/ns-wofapi-wim_external_file_info
struct WIM_EXTERNAL_FILE_INFO
{
    long      DataSourceId;
    ubyte[20] ResourceHash;
    uint      Flags;
}

struct WOF_FILE_COMPRESSION_INFO_V0
{
    uint Algorithm;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/ns-wofapi-wof_file_compression_info_v1
struct WOF_FILE_COMPRESSION_INFO_V1
{
    uint Algorithm;
    uint Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/txfw32/ns-txfw32-txf_id
struct TXF_ID
{
align (4):
    struct
    {
    align (4):
        long LowPart;
        long HighPart;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/txfw32/ns-txfw32-txf_log_record_base
struct TXF_LOG_RECORD_BASE
{
align (4):
    ushort              Version;
    TXF_LOG_RECORD_TYPE RecordType;
    uint                RecordLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/txfw32/ns-txfw32-txf_log_record_write
struct TXF_LOG_RECORD_WRITE
{
align (4):
    ushort Version;
    ushort RecordType;
    uint   RecordLength;
    uint   Flags;
    TXF_ID TxfFileId;
    GUID   KtmGuid;
    long   ByteOffsetInFile;
    uint   NumBytesWritten;
    uint   ByteOffsetInStructure;
    uint   FileNameLength;
    uint   FileNameByteOffsetInStructure;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/txfw32/ns-txfw32-txf_log_record_truncate
struct TXF_LOG_RECORD_TRUNCATE
{
align (4):
    ushort Version;
    ushort RecordType;
    uint   RecordLength;
    uint   Flags;
    TXF_ID TxfFileId;
    GUID   KtmGuid;
    long   NewFileSize;
    uint   FileNameLength;
    uint   FileNameByteOffsetInStructure;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/txfw32/ns-txfw32-txf_log_record_affected_file
struct TXF_LOG_RECORD_AFFECTED_FILE
{
align (4):
    ushort Version;
    uint   RecordLength;
    uint   Flags;
    TXF_ID TxfFileId;
    GUID   KtmGuid;
    uint   FileNameLength;
    uint   FileNameByteOffsetInStructure;
}

struct VOLUME_FAILOVER_SET
{
    uint    NumberOfDisks;
    uint[1] DiskNumbers; // Flexible array
}

struct VOLUME_NUMBER
{
    uint     VolumeNumber;
    wchar[8] VolumeManagerName;
}

struct VOLUME_LOGICAL_OFFSET
{
    long LogicalOffset;
}

struct VOLUME_PHYSICAL_OFFSET
{
    uint DiskNumber;
    long Offset;
}

struct VOLUME_PHYSICAL_OFFSETS
{
    uint NumberOfPhysicalOffsets;
    VOLUME_PHYSICAL_OFFSET[1] PhysicalOffset; // Flexible array
}

struct VOLUME_READ_PLEX_INPUT
{
    long ByteOffset;
    uint Length;
    uint PlexNumber;
}

struct VOLUME_SET_GPT_ATTRIBUTES_INFORMATION
{
    ulong   GptAttributes;
    BOOLEAN RevertOnClose;
    BOOLEAN ApplyToAllConnectedVolumes;
    ushort  Reserved1;
    uint    Reserved2;
}

struct VOLUME_GET_BC_PROPERTIES_INPUT
{
    uint  Version;
    uint  Reserved1;
    ulong LowestByteOffset;
    ulong HighestByteOffset;
    uint  AccessType;
    uint  AccessMode;
}

struct VOLUME_GET_BC_PROPERTIES_OUTPUT
{
    uint  MaximumRequestsPerPeriod;
    uint  MinimumPeriod;
    ulong MaximumRequestSize;
    uint  EstimatedTimePerRequest;
    uint  NumOutStandingRequests;
    ulong RequestSize;
}

struct VOLUME_ALLOCATE_BC_STREAM_INPUT
{
    uint       Version;
    uint       RequestsPerPeriod;
    uint       Period;
    BOOLEAN    RetryFailures;
    BOOLEAN    Discardable;
    BOOLEAN[2] Reserved1;
    ulong      LowestByteOffset;
    ulong      HighestByteOffset;
    uint       AccessType;
    uint       AccessMode;
}

struct VOLUME_ALLOCATE_BC_STREAM_OUTPUT
{
    ulong RequestSize;
    uint  NumOutStandingRequests;
}

struct FILE_EXTENT
{
    ulong VolumeOffset;
    ulong ExtentLength;
}

struct VOLUME_CRITICAL_IO
{
    uint           AccessType;
    uint           ExtentsCount;
    FILE_EXTENT[1] Extents; // Flexible array
}

struct VOLUME_ALLOCATION_HINT_INPUT
{
    uint ClusterSize;
    uint NumberOfClusters;
    long StartingClusterNumber;
}

struct VOLUME_ALLOCATION_HINT_OUTPUT
{
    uint[1] Bitmap; // Flexible array
}

struct VOLUME_SHRINK_INFO
{
    ulong VolumeSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-share_info_0
struct SHARE_INFO_0
{
    PWSTR shi0_netname;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-share_info_1
struct SHARE_INFO_1
{
    PWSTR      shi1_netname;
    SHARE_TYPE shi1_type;
    PWSTR      shi1_remark;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-share_info_2
struct SHARE_INFO_2
{
    PWSTR      shi2_netname;
    SHARE_TYPE shi2_type;
    PWSTR      shi2_remark;
    SHARE_INFO_PERMISSIONS shi2_permissions;
    uint       shi2_max_uses;
    uint       shi2_current_uses;
    PWSTR      shi2_path;
    PWSTR      shi2_passwd;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-share_info_501
struct SHARE_INFO_501
{
    PWSTR      shi501_netname;
    SHARE_TYPE shi501_type;
    PWSTR      shi501_remark;
    uint       shi501_flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-share_info_502
struct SHARE_INFO_502
{
    PWSTR                shi502_netname;
    SHARE_TYPE           shi502_type;
    PWSTR                shi502_remark;
    SHARE_INFO_PERMISSIONS shi502_permissions;
    uint                 shi502_max_uses;
    uint                 shi502_current_uses;
    PWSTR                shi502_path;
    PWSTR                shi502_passwd;
    uint                 shi502_reserved;
    PSECURITY_DESCRIPTOR shi502_security_descriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-share_info_503
struct SHARE_INFO_503
{
    PWSTR                shi503_netname;
    SHARE_TYPE           shi503_type;
    PWSTR                shi503_remark;
    SHARE_INFO_PERMISSIONS shi503_permissions;
    uint                 shi503_max_uses;
    uint                 shi503_current_uses;
    PWSTR                shi503_path;
    PWSTR                shi503_passwd;
    PWSTR                shi503_servername;
    uint                 shi503_reserved;
    PSECURITY_DESCRIPTOR shi503_security_descriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-share_info_1004
struct SHARE_INFO_1004
{
    PWSTR shi1004_remark;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-share_info_1005
struct SHARE_INFO_1005
{
    uint shi1005_flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-share_info_1006
struct SHARE_INFO_1006
{
    uint shi1006_max_uses;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-share_info_1501
struct SHARE_INFO_1501
{
    uint                 shi1501_reserved;
    PSECURITY_DESCRIPTOR shi1501_security_descriptor;
}

struct SHARE_INFO_1503
{
    GUID shi1503_sharefilter;
}

struct SERVER_ALIAS_INFO_0
{
    PWSTR   srvai0_alias;
    PWSTR   srvai0_target;
    BOOLEAN srvai0_default;
    uint    srvai0_reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-session_info_0
struct SESSION_INFO_0
{
    PWSTR sesi0_cname;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-session_info_1
struct SESSION_INFO_1
{
    PWSTR sesi1_cname;
    PWSTR sesi1_username;
    uint  sesi1_num_opens;
    uint  sesi1_time;
    uint  sesi1_idle_time;
    SESSION_INFO_USER_FLAGS sesi1_user_flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-session_info_2
struct SESSION_INFO_2
{
    PWSTR sesi2_cname;
    PWSTR sesi2_username;
    uint  sesi2_num_opens;
    uint  sesi2_time;
    uint  sesi2_idle_time;
    SESSION_INFO_USER_FLAGS sesi2_user_flags;
    PWSTR sesi2_cltype_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-session_info_10
struct SESSION_INFO_10
{
    PWSTR sesi10_cname;
    PWSTR sesi10_username;
    uint  sesi10_time;
    uint  sesi10_idle_time;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-session_info_502
struct SESSION_INFO_502
{
    PWSTR sesi502_cname;
    PWSTR sesi502_username;
    uint  sesi502_num_opens;
    uint  sesi502_time;
    uint  sesi502_idle_time;
    SESSION_INFO_USER_FLAGS sesi502_user_flags;
    PWSTR sesi502_cltype_name;
    PWSTR sesi502_transport;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-connection_info_0
struct CONNECTION_INFO_0
{
    uint coni0_id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-connection_info_1
struct CONNECTION_INFO_1
{
    uint       coni1_id;
    SHARE_TYPE coni1_type;
    uint       coni1_num_opens;
    uint       coni1_num_users;
    uint       coni1_time;
    PWSTR      coni1_username;
    PWSTR      coni1_netname;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-file_info_2
struct FILE_INFO_2
{
    uint fi2_id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmshare/ns-lmshare-file_info_3
struct FILE_INFO_3
{
    uint  fi3_id;
    FILE_INFO_FLAGS_PERMISSIONS fi3_permissions;
    uint  fi3_num_locks;
    PWSTR fi3_pathname;
    PWSTR fi3_username;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmstats/ns-lmstats-stat_workstation_0~r1
struct STAT_WORKSTATION_0
{
    long StatisticsStartTime;
    long BytesReceived;
    long SmbsReceived;
    long PagingReadBytesRequested;
    long NonPagingReadBytesRequested;
    long CacheReadBytesRequested;
    long NetworkReadBytesRequested;
    long BytesTransmitted;
    long SmbsTransmitted;
    long PagingWriteBytesRequested;
    long NonPagingWriteBytesRequested;
    long CacheWriteBytesRequested;
    long NetworkWriteBytesRequested;
    uint InitiallyFailedOperations;
    uint FailedCompletionOperations;
    uint ReadOperations;
    uint RandomReadOperations;
    uint ReadSmbs;
    uint LargeReadSmbs;
    uint SmallReadSmbs;
    uint WriteOperations;
    uint RandomWriteOperations;
    uint WriteSmbs;
    uint LargeWriteSmbs;
    uint SmallWriteSmbs;
    uint RawReadsDenied;
    uint RawWritesDenied;
    uint NetworkErrors;
    uint Sessions;
    uint FailedSessions;
    uint Reconnects;
    uint CoreConnects;
    uint Lanman20Connects;
    uint Lanman21Connects;
    uint LanmanNtConnects;
    uint ServerDisconnects;
    uint HungSessions;
    uint UseCount;
    uint FailedUseCount;
    uint CurrentCommands;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmstats/ns-lmstats-stat_server_0
struct STAT_SERVER_0
{
    uint sts0_start;
    uint sts0_fopens;
    uint sts0_devopens;
    uint sts0_jobsqueued;
    uint sts0_sopens;
    uint sts0_stimedout;
    uint sts0_serrorout;
    uint sts0_pwerrors;
    uint sts0_permerrors;
    uint sts0_syserrors;
    uint sts0_bytessent_low;
    uint sts0_bytessent_high;
    uint sts0_bytesrcvd_low;
    uint sts0_bytesrcvd_high;
    uint sts0_avresponse;
    uint sts0_reqbufneed;
    uint sts0_bigbufneed;
}

struct FH_OVERLAPPED
{
    size_t            Internal;
    size_t            InternalHigh;
    uint              Offset;
    uint              OffsetHigh;
    HANDLE            hEvent;
    PFN_IO_COMPLETION pfnCompletion;
    size_t            Reserved1;
    size_t            Reserved2;
    size_t            Reserved3;
    size_t            Reserved4;
}

struct FIO_CONTEXT
{
    uint   m_dwTempHack;
    uint   m_dwSignature;
    HANDLE m_hFile;
    uint   m_dwLinesOffset;
    uint   m_dwHeaderLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filehc/ns-filehc-name_cache_context
struct NAME_CACHE_CONTEXT
{
    uint m_dwSignature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntioring_x/ns-ntioring_x-ioring_buffer_info
struct IORING_BUFFER_INFO
{
    void* Address;
    uint  Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntioring_x/ns-ntioring_x-ioring_registered_buffer
struct IORING_REGISTERED_BUFFER
{
    uint BufferIndex;
    uint Offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/ns-ioringapi-ioring_create_flags
struct IORING_CREATE_FLAGS
{
    IORING_CREATE_REQUIRED_FLAGS Required;
    IORING_CREATE_ADVISORY_FLAGS Advisory;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/ns-ioringapi-ioring_info
struct IORING_INFO
{
    IORING_VERSION      IoRingVersion;
    IORING_CREATE_FLAGS Flags;
    uint                SubmissionQueueSize;
    uint                CompletionQueueSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/ns-ioringapi-ioring_capabilities
struct IORING_CAPABILITIES
{
    IORING_VERSION       MaxVersion;
    uint                 MaxSubmissionQueueSize;
    uint                 MaxCompletionQueueSize;
    IORING_FEATURE_FLAGS FeatureFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/ns-ioringapi-ioring_handle_ref
struct IORING_HANDLE_REF
{
    IORING_REF_KIND Kind;
    union Handle
    {
        HANDLE Handle;
        uint   Index;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/ns-ioringapi-ioring_buffer_ref
struct IORING_BUFFER_REF
{
    IORING_REF_KIND Kind;
    union Buffer
    {
        void* Address;
        IORING_REGISTERED_BUFFER IndexAndOffset;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/ns-ioringapi-ioring_cqe
struct IORING_CQE
{
    size_t  UserData;
    HRESULT ResultCode;
    size_t  Information;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-file_id_128
struct FILE_ID_128
{
    ubyte[16] Identifier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-file_notify_information
struct FILE_NOTIFY_INFORMATION
{
    uint        NextEntryOffset;
    FILE_ACTION Action;
    uint        FileNameLength;
    wchar[1]    FileName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-file_notify_extended_information
struct FILE_NOTIFY_EXTENDED_INFORMATION
{
    uint        NextEntryOffset;
    FILE_ACTION Action;
    long        CreationTime;
    long        LastModificationTime;
    long        LastChangeTime;
    long        LastAccessTime;
    long        AllocatedLength;
    long        FileSize;
    uint        FileAttributes;
    union
    {
        uint ReparsePointTag;
        uint EaSize;
    }
    long        FileId;
    long        ParentFileId;
    uint        FileNameLength;
    wchar[1]    FileName; // Flexible array
}

struct FILE_STAT_BASIC_INFORMATION
{
    long        FileId;
    long        CreationTime;
    long        LastAccessTime;
    long        LastWriteTime;
    long        ChangeTime;
    long        AllocationSize;
    long        EndOfFile;
    uint        FileAttributes;
    uint        ReparseTag;
    uint        NumberOfLinks;
    uint        DeviceType;
    uint        DeviceCharacteristics;
    uint        Reserved;
    long        VolumeSerialNumber;
    FILE_ID_128 FileId128;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-file_segment_element
union FILE_SEGMENT_ELEMENT
{
    void* Buffer;
    ulong Alignment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-reparse_guid_data_buffer
struct REPARSE_GUID_DATA_BUFFER
{
    uint   ReparseTag;
    ushort ReparseDataLength;
    ushort Reserved;
    GUID   ReparseGuid;
    struct GenericReparseBuffer
    {
        ubyte[1] DataBuffer; // Flexible array
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_erase
struct TAPE_ERASE
{
    ERASE_TAPE_TYPE Type;
    BOOLEAN         Immediate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_prepare
struct TAPE_PREPARE
{
    PREPARE_TAPE_OPERATION Operation;
    BOOLEAN Immediate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_write_marks
struct TAPE_WRITE_MARKS
{
    TAPEMARK_TYPE Type;
    uint          Count;
    BOOLEAN       Immediate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_get_position
struct TAPE_GET_POSITION
{
    TAPE_POSITION_TYPE Type;
    uint               Partition;
    long               Offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_set_position
struct TAPE_SET_POSITION
{
    TAPE_POSITION_METHOD Method;
    uint                 Partition;
    long                 Offset;
    BOOLEAN              Immediate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-ofstruct
struct OFSTRUCT
{
    ubyte     cBytes;
    ubyte     fFixedDisk;
    ushort    nErrCode;
    ushort    Reserved1;
    ushort    Reserved2;
    CHAR[128] szPathName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-win32_stream_id
struct WIN32_STREAM_ID
{
    WIN_STREAM_ID dwStreamId;
    uint          dwStreamAttributes;
    long          Size;
    uint          dwStreamNameSize;
    wchar[1]      cStreamName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-copyfile2_message
struct COPYFILE2_MESSAGE
{
    COPYFILE2_MESSAGE_TYPE Type;
    uint dwPadding;
    union Info
    {
        struct ChunkStarted
        {
            uint   dwStreamNumber;
            uint   dwReserved;
            HANDLE hSourceFile;
            HANDLE hDestinationFile;
            ulong  uliChunkNumber;
            ulong  uliChunkSize;
            ulong  uliStreamSize;
            ulong  uliTotalFileSize;
        }
        struct ChunkFinished
        {
            uint   dwStreamNumber;
            uint   dwFlags;
            HANDLE hSourceFile;
            HANDLE hDestinationFile;
            ulong  uliChunkNumber;
            ulong  uliChunkSize;
            ulong  uliStreamSize;
            ulong  uliStreamBytesTransferred;
            ulong  uliTotalFileSize;
            ulong  uliTotalBytesTransferred;
        }
        struct StreamStarted
        {
            uint   dwStreamNumber;
            uint   dwReserved;
            HANDLE hSourceFile;
            HANDLE hDestinationFile;
            ulong  uliStreamSize;
            ulong  uliTotalFileSize;
        }
        struct StreamFinished
        {
            uint   dwStreamNumber;
            uint   dwReserved;
            HANDLE hSourceFile;
            HANDLE hDestinationFile;
            ulong  uliStreamSize;
            ulong  uliStreamBytesTransferred;
            ulong  uliTotalFileSize;
            ulong  uliTotalBytesTransferred;
        }
        struct PollContinue
        {
            uint dwReserved;
        }
        struct Error
        {
            COPYFILE2_COPY_PHASE CopyPhase;
            uint                 dwStreamNumber;
            HRESULT              hrFailure;
            uint                 dwReserved;
            ulong                uliChunkNumber;
            ulong                uliStreamSize;
            ulong                uliStreamBytesTransferred;
            ulong                uliTotalFileSize;
            ulong                uliTotalBytesTransferred;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-copyfile2_extended_parameters
struct COPYFILE2_EXTENDED_PARAMETERS
{
    uint           dwSize;
    COPYFILE_FLAGS dwCopyFlags;
    BOOL*          pfCancel;
    PCOPYFILE2_PROGRESS_ROUTINE pProgressRoutine;
    void*          pvCallbackContext;
}

struct COPYFILE2_CREATE_OPLOCK_KEYS
{
    GUID ParentOplockKey;
    GUID TargetOplockKey;
}

struct COPYFILE2_EXTENDED_PARAMETERS_V2
{
    uint               dwSize;
    COPYFILE_FLAGS     dwCopyFlags;
    BOOL*              pfCancel;
    PCOPYFILE2_PROGRESS_ROUTINE pProgressRoutine;
    void*              pvCallbackContext;
    COPYFILE2_V2_FLAGS dwCopyFlagsV2;
    uint               ioDesiredSize;
    uint               ioDesiredRate;
    LPPROGRESS_ROUTINE pProgressRoutineOld;
    COPYFILE2_CREATE_OPLOCK_KEYS* SourceOplockKeys;
    void[6]*           reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_basic_info
struct FILE_BASIC_INFO
{
    long CreationTime;
    long LastAccessTime;
    long LastWriteTime;
    long ChangeTime;
    uint FileAttributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_standard_info
struct FILE_STANDARD_INFO
{
    long    AllocationSize;
    long    EndOfFile;
    uint    NumberOfLinks;
    BOOLEAN DeletePending;
    BOOLEAN Directory;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_name_info
struct FILE_NAME_INFO
{
    uint     FileNameLength;
    wchar[1] FileName; // Flexible array
}

struct FILE_CASE_SENSITIVE_INFO
{
    uint Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_rename_info
struct FILE_RENAME_INFO
{
    union
    {
        BOOLEAN ReplaceIfExists;
        uint    Flags;
    }
    HANDLE   RootDirectory;
    uint     FileNameLength;
    wchar[1] FileName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_allocation_info
struct FILE_ALLOCATION_INFO
{
    long AllocationSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_end_of_file_info
struct FILE_END_OF_FILE_INFO
{
    long EndOfFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_stream_info
struct FILE_STREAM_INFO
{
    uint     NextEntryOffset;
    uint     StreamNameLength;
    long     StreamSize;
    long     StreamAllocationSize;
    wchar[1] StreamName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_compression_info
struct FILE_COMPRESSION_INFO
{
    long               CompressedFileSize;
    COMPRESSION_FORMAT CompressionFormat;
    ubyte              CompressionUnitShift;
    ubyte              ChunkShift;
    ubyte              ClusterShift;
    ubyte[3]           Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_attribute_tag_info
struct FILE_ATTRIBUTE_TAG_INFO
{
    uint FileAttributes;
    uint ReparseTag;
}

struct FILE_DISPOSITION_INFO_EX
{
    FILE_DISPOSITION_INFO_EX_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_id_both_dir_info
struct FILE_ID_BOTH_DIR_INFO
{
    uint      NextEntryOffset;
    uint      FileIndex;
    long      CreationTime;
    long      LastAccessTime;
    long      LastWriteTime;
    long      ChangeTime;
    long      EndOfFile;
    long      AllocationSize;
    uint      FileAttributes;
    uint      FileNameLength;
    uint      EaSize;
    byte      ShortNameLength;
    wchar[12] ShortName;
    long      FileId;
    wchar[1]  FileName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_full_dir_info
struct FILE_FULL_DIR_INFO
{
    uint     NextEntryOffset;
    uint     FileIndex;
    long     CreationTime;
    long     LastAccessTime;
    long     LastWriteTime;
    long     ChangeTime;
    long     EndOfFile;
    long     AllocationSize;
    uint     FileAttributes;
    uint     FileNameLength;
    uint     EaSize;
    wchar[1] FileName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_io_priority_hint_info
struct FILE_IO_PRIORITY_HINT_INFO
{
    PRIORITY_HINT PriorityHint;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_alignment_info
struct FILE_ALIGNMENT_INFO
{
    uint AlignmentRequirement;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_storage_info
struct FILE_STORAGE_INFO
{
    uint LogicalBytesPerSector;
    uint PhysicalBytesPerSectorForAtomicity;
    uint PhysicalBytesPerSectorForPerformance;
    uint FileSystemEffectivePhysicalBytesPerSectorForAtomicity;
    uint Flags;
    uint ByteOffsetForSectorAlignment;
    uint ByteOffsetForPartitionAlignment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_id_info
struct FILE_ID_INFO
{
    ulong       VolumeSerialNumber;
    FILE_ID_128 FileId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_id_extd_dir_info
struct FILE_ID_EXTD_DIR_INFO
{
    uint        NextEntryOffset;
    uint        FileIndex;
    long        CreationTime;
    long        LastAccessTime;
    long        LastWriteTime;
    long        ChangeTime;
    long        EndOfFile;
    long        AllocationSize;
    uint        FileAttributes;
    uint        FileNameLength;
    uint        EaSize;
    uint        ReparsePointTag;
    FILE_ID_128 FileId;
    wchar[1]    FileName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_remote_protocol_info
struct FILE_REMOTE_PROTOCOL_INFO
{
    ushort StructureVersion;
    ushort StructureSize;
    uint   Protocol;
    ushort ProtocolMajorVersion;
    ushort ProtocolMinorVersion;
    ushort ProtocolRevision;
    ushort Reserved;
    uint   Flags;
    struct GenericReserved
    {
        uint[8] Reserved;
    }
    union ProtocolSpecific
    {
        struct Smb2
        {
            struct Server
            {
                uint Capabilities;
            }
            struct Share
            {
                uint Capabilities;
                uint ShareFlags;
            }
        }
        uint[16] Reserved;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-file_id_descriptor
struct FILE_ID_DESCRIPTOR
{
    uint         dwSize;
    FILE_ID_TYPE Type;
    union
    {
        long        FileId;
        GUID        ObjectId;
        FILE_ID_128 ExtendedFileId;
    }
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint SearchPathW(const(PWSTR) lpPath, const(PWSTR) lpFileName, const(PWSTR) lpExtension, uint nBufferLength, 
                 PWSTR lpBuffer, PWSTR* lpFilePart);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint SearchPathA(const(PSTR) lpPath, const(PSTR) lpFileName, const(PSTR) lpExtension, uint nBufferLength, 
                 PSTR lpBuffer, PSTR* lpFilePart);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int CompareFileTime(const(FILETIME)* lpFileTime1, const(FILETIME)* lpFileTime2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CreateDirectoryA(const(PSTR) lpPathName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CreateDirectoryW(const(PWSTR) lpPathName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateFileA(const(PSTR) lpFileName, uint dwDesiredAccess, FILE_SHARE_MODE dwShareMode, 
                   SECURITY_ATTRIBUTES* lpSecurityAttributes, FILE_CREATION_DISPOSITION dwCreationDisposition, 
                   FILE_FLAGS_AND_ATTRIBUTES dwFlagsAndAttributes, HANDLE hTemplateFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateFileW(const(PWSTR) lpFileName, uint dwDesiredAccess, FILE_SHARE_MODE dwShareMode, 
                   SECURITY_ATTRIBUTES* lpSecurityAttributes, FILE_CREATION_DISPOSITION dwCreationDisposition, 
                   FILE_FLAGS_AND_ATTRIBUTES dwFlagsAndAttributes, HANDLE hTemplateFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DefineDosDeviceW(DEFINE_DOS_DEVICE_FLAGS dwFlags, const(PWSTR) lpDeviceName, const(PWSTR) lpTargetPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DeleteFileA(const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DeleteFileW(const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DeleteVolumeMountPointW(const(PWSTR) lpszVolumeMountPoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FileTimeToLocalFileTime(const(FILETIME)* lpFileTime, FILETIME* lpLocalFileTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindClose(HANDLE hFindFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindCloseChangeNotification(HANDLE hChangeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstChangeNotificationA(const(PSTR) lpPathName, BOOL bWatchSubtree, FILE_NOTIFY_CHANGE dwNotifyFilter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstChangeNotificationW(const(PWSTR) lpPathName, BOOL bWatchSubtree, FILE_NOTIFY_CHANGE dwNotifyFilter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstFileA(const(PSTR) lpFileName, WIN32_FIND_DATAA* lpFindFileData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstFileW(const(PWSTR) lpFileName, WIN32_FIND_DATAW* lpFindFileData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstFileExA(const(PSTR) lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, void* lpFindFileData, 
                        FINDEX_SEARCH_OPS fSearchOp, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpSearchFilter, 
                        FIND_FIRST_EX_FLAGS dwAdditionalFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstFileExW(const(PWSTR) lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, void* lpFindFileData, 
                        FINDEX_SEARCH_OPS fSearchOp, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpSearchFilter, 
                        FIND_FIRST_EX_FLAGS dwAdditionalFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstVolumeW(PWSTR lpszVolumeName, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindNextChangeNotification(HANDLE hChangeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindNextFileA(HANDLE hFindFile, WIN32_FIND_DATAA* lpFindFileData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindNextFileW(HANDLE hFindFile, WIN32_FIND_DATAW* lpFindFileData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindNextVolumeW(HANDLE hFindVolume, PWSTR lpszVolumeName, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindVolumeClose(HANDLE hFindVolume);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FlushFileBuffers(HANDLE hFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetDiskFreeSpaceA(const(PSTR) lpRootPathName, uint* lpSectorsPerCluster, uint* lpBytesPerSector, 
                       uint* lpNumberOfFreeClusters, uint* lpTotalNumberOfClusters);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetDiskFreeSpaceW(const(PWSTR) lpRootPathName, uint* lpSectorsPerCluster, uint* lpBytesPerSector, 
                       uint* lpNumberOfFreeClusters, uint* lpTotalNumberOfClusters);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetDiskFreeSpaceExA(const(PSTR) lpDirectoryName, ulong* lpFreeBytesAvailableToCaller, 
                         ulong* lpTotalNumberOfBytes, ulong* lpTotalNumberOfFreeBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetDiskFreeSpaceExW(const(PWSTR) lpDirectoryName, ulong* lpFreeBytesAvailableToCaller, 
                         ulong* lpTotalNumberOfBytes, ulong* lpTotalNumberOfFreeBytes);

@DllImport("KERNEL32.dll")
HRESULT GetDiskSpaceInformationA(const(PSTR) rootPath, DISK_SPACE_INFORMATION* diskSpaceInfo);

@DllImport("KERNEL32.dll")
HRESULT GetDiskSpaceInformationW(const(PWSTR) rootPath, DISK_SPACE_INFORMATION* diskSpaceInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetDriveTypeA(const(PSTR) lpRootPathName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetDriveTypeW(const(PWSTR) lpRootPathName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetFileAttributesA(const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetFileAttributesW(const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileAttributesExA(const(PSTR) lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, void* lpFileInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileAttributesExW(const(PWSTR) lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, void* lpFileInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileInformationByHandle(HANDLE hFile, BY_HANDLE_FILE_INFORMATION* lpFileInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetFileSize(HANDLE hFile, uint* lpFileSizeHigh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileSizeEx(HANDLE hFile, long* lpFileSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
FILE_TYPE GetFileType(HANDLE hFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetFinalPathNameByHandleA(HANDLE hFile, PSTR lpszFilePath, uint cchFilePath, 
                               GETFINALPATHNAMEBYHANDLE_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetFinalPathNameByHandleW(HANDLE hFile, PWSTR lpszFilePath, uint cchFilePath, 
                               GETFINALPATHNAMEBYHANDLE_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileTime(HANDLE hFile, FILETIME* lpCreationTime, FILETIME* lpLastAccessTime, FILETIME* lpLastWriteTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetFullPathNameW(const(PWSTR) lpFileName, uint nBufferLength, PWSTR lpBuffer, PWSTR* lpFilePart);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetFullPathNameA(const(PSTR) lpFileName, uint nBufferLength, PSTR lpBuffer, PSTR* lpFilePart);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetLogicalDrives();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetLogicalDriveStringsW(uint nBufferLength, PWSTR lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetLongPathNameA(const(PSTR) lpszShortPath, PSTR lpszLongPath, uint cchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetLongPathNameW(const(PWSTR) lpszShortPath, PWSTR lpszLongPath, uint cchBuffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapi/nf-fileapi-areshortnamesenabled
@DllImport("KERNEL32.dll")
BOOL AreShortNamesEnabled(HANDLE Handle, BOOL* Enabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetShortPathNameW(const(PWSTR) lpszLongPath, PWSTR lpszShortPath, uint cchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetTempFileNameW(const(PWSTR) lpPathName, const(PWSTR) lpPrefixString, uint uUnique, PWSTR lpTempFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetVolumeInformationByHandleW(HANDLE hFile, PWSTR lpVolumeNameBuffer, uint nVolumeNameSize, 
                                   uint* lpVolumeSerialNumber, uint* lpMaximumComponentLength, 
                                   uint* lpFileSystemFlags, PWSTR lpFileSystemNameBuffer, uint nFileSystemNameSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetVolumeInformationW(const(PWSTR) lpRootPathName, PWSTR lpVolumeNameBuffer, uint nVolumeNameSize, 
                           uint* lpVolumeSerialNumber, uint* lpMaximumComponentLength, uint* lpFileSystemFlags, 
                           PWSTR lpFileSystemNameBuffer, uint nFileSystemNameSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetVolumePathNameW(const(PWSTR) lpszFileName, PWSTR lpszVolumePathName, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL LocalFileTimeToFileTime(const(FILETIME)* lpLocalFileTime, FILETIME* lpFileTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL LockFile(HANDLE hFile, uint dwFileOffsetLow, uint dwFileOffsetHigh, uint nNumberOfBytesToLockLow, 
              uint nNumberOfBytesToLockHigh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL LockFileEx(HANDLE hFile, LOCK_FILE_FLAGS dwFlags, 
                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                uint nNumberOfBytesToLockLow, uint nNumberOfBytesToLockHigh, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint QueryDosDeviceW(const(PWSTR) lpDeviceName, PWSTR lpTargetPath, uint ucchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ReadFile(HANDLE hFile, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* lpBuffer, 
              uint nNumberOfBytesToRead, uint* lpNumberOfBytesRead, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ReadFileEx(HANDLE hFile, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* lpBuffer, 
                uint nNumberOfBytesToRead, 
                /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* lpOverlapped, 
                LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ReadFileScatter(HANDLE hFile, FILE_SEGMENT_ELEMENT* aSegmentArray, uint nNumberOfBytesToRead, 
                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* lpReserved, 
                     OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL RemoveDirectoryA(const(PSTR) lpPathName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL RemoveDirectoryW(const(PWSTR) lpPathName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetEndOfFile(HANDLE hFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileAttributesA(const(PSTR) lpFileName, FILE_FLAGS_AND_ATTRIBUTES dwFileAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileAttributesW(const(PWSTR) lpFileName, FILE_FLAGS_AND_ATTRIBUTES dwFileAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileInformationByHandle(HANDLE hFile, FILE_INFO_BY_HANDLE_CLASS FileInformationClass, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpFileInformation, 
                                uint dwBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint SetFilePointer(HANDLE hFile, int lDistanceToMove, int* lpDistanceToMoveHigh, 
                    SET_FILE_POINTER_MOVE_METHOD dwMoveMethod);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetFilePointerEx(HANDLE hFile, long liDistanceToMove, long* lpNewFilePointer, 
                      SET_FILE_POINTER_MOVE_METHOD dwMoveMethod);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileTime(HANDLE hFile, const(FILETIME)* lpCreationTime, const(FILETIME)* lpLastAccessTime, 
                 const(FILETIME)* lpLastWriteTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileValidData(HANDLE hFile, long ValidDataLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL UnlockFile(HANDLE hFile, uint dwFileOffsetLow, uint dwFileOffsetHigh, uint nNumberOfBytesToUnlockLow, 
                uint nNumberOfBytesToUnlockHigh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL UnlockFileEx(HANDLE hFile, /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                  uint nNumberOfBytesToUnlockLow, uint nNumberOfBytesToUnlockHigh, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL WriteFile(HANDLE hFile, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(ubyte)* lpBuffer, 
               uint nNumberOfBytesToWrite, uint* lpNumberOfBytesWritten, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL WriteFileEx(HANDLE hFile, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(ubyte)* lpBuffer, 
                 uint nNumberOfBytesToWrite, 
                 /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* lpOverlapped, 
                 LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL WriteFileGather(HANDLE hFile, FILE_SEGMENT_ELEMENT* aSegmentArray, uint nNumberOfBytesToWrite, 
                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* lpReserved, 
                     OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetTempPathW(uint nBufferLength, PWSTR lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetVolumeNameForVolumeMountPointW(const(PWSTR) lpszVolumeMountPoint, PWSTR lpszVolumeName, 
                                       uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetVolumePathNamesForVolumeNameW(const(PWSTR) lpszVolumeName, 
                                      /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR lpszVolumePathNames, 
                                      uint cchBufferLength, uint* lpcchReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateFile2(const(PWSTR) lpFileName, uint dwDesiredAccess, FILE_SHARE_MODE dwShareMode, 
                   FILE_CREATION_DISPOSITION dwCreationDisposition, CREATEFILE2_EXTENDED_PARAMETERS* pCreateExParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileIoOverlappedRange(HANDLE FileHandle, ubyte* OverlappedRangeStart, uint Length);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetCompressedFileSizeA(const(PSTR) lpFileName, uint* lpFileSizeHigh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetCompressedFileSizeW(const(PWSTR) lpFileName, uint* lpFileSizeHigh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstStreamW(const(PWSTR) lpFileName, STREAM_INFO_LEVELS InfoLevel, void* lpFindStreamData, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL FindNextStreamW(HANDLE hFindStream, void* lpFindStreamData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL AreFileApisANSI();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetTempPathA(uint nBufferLength, PSTR lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstFileNameW(const(PWSTR) lpFileName, uint dwFlags, uint* StringLength, PWSTR LinkName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL FindNextFileNameW(HANDLE hFindStream, uint* StringLength, PWSTR LinkName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetVolumeInformationA(const(PSTR) lpRootPathName, PSTR lpVolumeNameBuffer, uint nVolumeNameSize, 
                           uint* lpVolumeSerialNumber, uint* lpMaximumComponentLength, uint* lpFileSystemFlags, 
                           PSTR lpFileSystemNameBuffer, uint nFileSystemNameSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetTempFileNameA(const(PSTR) lpPathName, const(PSTR) lpPrefixString, uint uUnique, PSTR lpTempFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void SetFileApisToOEM();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void SetFileApisToANSI();

@DllImport("KERNEL32.dll")
uint GetTempPath2W(uint BufferLength, PWSTR Buffer);

@DllImport("KERNEL32.dll")
uint GetTempPath2A(uint BufferLength, PSTR Buffer);

@DllImport("KERNEL32.dll")
HANDLE CreateFile3(const(PWSTR) lpFileName, uint dwDesiredAccess, uint dwShareMode, uint dwCreationDisposition, 
                   CREATEFILE3_EXTENDED_PARAMETERS* pCreateExParams);

@DllImport("KERNEL32.dll")
HANDLE CreateDirectory2A(const(PSTR) lpPathName, uint dwDesiredAccess, uint dwShareMode, 
                         DIRECTORY_FLAGS DirectoryFlags, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
HANDLE CreateDirectory2W(const(PWSTR) lpPathName, uint dwDesiredAccess, uint dwShareMode, 
                         DIRECTORY_FLAGS DirectoryFlags, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
BOOL RemoveDirectory2A(const(PSTR) lpPathName, DIRECTORY_FLAGS DirectoryFlags);

@DllImport("KERNEL32.dll")
BOOL RemoveDirectory2W(const(PWSTR) lpPathName, DIRECTORY_FLAGS DirectoryFlags);

@DllImport("KERNEL32.dll")
BOOL DeleteFile2A(const(PSTR) lpFileName, uint Flags);

@DllImport("KERNEL32.dll")
BOOL DeleteFile2W(const(PWSTR) lpFileName, uint Flags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-copyfilefromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL CopyFileFromAppW(const(PWSTR) lpExistingFileName, const(PWSTR) lpNewFileName, BOOL bFailIfExists);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-createdirectoryfromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL CreateDirectoryFromAppW(const(PWSTR) lpPathName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-createfilefromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
HANDLE CreateFileFromAppW(const(PWSTR) lpFileName, uint dwDesiredAccess, uint dwShareMode, 
                          SECURITY_ATTRIBUTES* lpSecurityAttributes, uint dwCreationDisposition, 
                          uint dwFlagsAndAttributes, HANDLE hTemplateFile);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-createfile2fromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
HANDLE CreateFile2FromAppW(const(PWSTR) lpFileName, uint dwDesiredAccess, uint dwShareMode, 
                           uint dwCreationDisposition, CREATEFILE2_EXTENDED_PARAMETERS* pCreateExParams);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-deletefilefromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL DeleteFileFromAppW(const(PWSTR) lpFileName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-findfirstfileexfromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
HANDLE FindFirstFileExFromAppW(const(PWSTR) lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, void* lpFindFileData, 
                               FINDEX_SEARCH_OPS fSearchOp, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpSearchFilter, 
                               uint dwAdditionalFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-getfileattributesexfromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL GetFileAttributesExFromAppW(const(PWSTR) lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, 
                                 void* lpFileInformation);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-movefilefromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL MoveFileFromAppW(const(PWSTR) lpExistingFileName, const(PWSTR) lpNewFileName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-removedirectoryfromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL RemoveDirectoryFromAppW(const(PWSTR) lpPathName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-replacefilefromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL ReplaceFileFromAppW(const(PWSTR) lpReplacedFileName, const(PWSTR) lpReplacementFileName, 
                         const(PWSTR) lpBackupFileName, uint dwReplaceFlags, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpExclude, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fileapifromapp/nf-fileapifromapp-setfileattributesfromappw
@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL SetFileAttributesFromAppW(const(PWSTR) lpFileName, uint dwFileAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("VERSION.dll")
VER_FIND_FILE_STATUS VerFindFileA(VER_FIND_FILE_FLAGS uFlags, const(PSTR) szFileName, const(PSTR) szWinDir, 
                                  const(PSTR) szAppDir, PSTR szCurDir, uint* puCurDirLen, PSTR szDestDir, 
                                  uint* puDestDirLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("VERSION.dll")
VER_FIND_FILE_STATUS VerFindFileW(VER_FIND_FILE_FLAGS uFlags, const(PWSTR) szFileName, const(PWSTR) szWinDir, 
                                  const(PWSTR) szAppDir, PWSTR szCurDir, uint* puCurDirLen, PWSTR szDestDir, 
                                  uint* puDestDirLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("VERSION.dll")
VER_INSTALL_FILE_STATUS VerInstallFileA(VER_INSTALL_FILE_FLAGS uFlags, const(PSTR) szSrcFileName, 
                                        const(PSTR) szDestFileName, const(PSTR) szSrcDir, const(PSTR) szDestDir, 
                                        const(PSTR) szCurDir, PSTR szTmpFile, uint* puTmpFileLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("VERSION.dll")
VER_INSTALL_FILE_STATUS VerInstallFileW(VER_INSTALL_FILE_FLAGS uFlags, const(PWSTR) szSrcFileName, 
                                        const(PWSTR) szDestFileName, const(PWSTR) szSrcDir, const(PWSTR) szDestDir, 
                                        const(PWSTR) szCurDir, PWSTR szTmpFile, uint* puTmpFileLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("VERSION.dll")
uint GetFileVersionInfoSizeA(const(PSTR) lptstrFilename, uint* lpdwHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("VERSION.dll")
uint GetFileVersionInfoSizeW(const(PWSTR) lptstrFilename, uint* lpdwHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("VERSION.dll")
BOOL GetFileVersionInfoA(const(PSTR) lptstrFilename, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwHandle, uint dwLen, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("VERSION.dll")
BOOL GetFileVersionInfoW(const(PWSTR) lptstrFilename, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwHandle, uint dwLen, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("VERSION.dll")
uint GetFileVersionInfoSizeExA(GET_FILE_VERSION_INFO_FLAGS dwFlags, const(PSTR) lpwstrFilename, uint* lpdwHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("VERSION.dll")
uint GetFileVersionInfoSizeExW(GET_FILE_VERSION_INFO_FLAGS dwFlags, const(PWSTR) lpwstrFilename, uint* lpdwHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("VERSION.dll")
BOOL GetFileVersionInfoExA(GET_FILE_VERSION_INFO_FLAGS dwFlags, const(PSTR) lpwstrFilename, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwHandle, uint dwLen, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("VERSION.dll")
BOOL GetFileVersionInfoExW(GET_FILE_VERSION_INFO_FLAGS dwFlags, const(PWSTR) lpwstrFilename, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwHandle, uint dwLen, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint VerLanguageNameA(uint wLang, PSTR szLang, uint cchLang);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint VerLanguageNameW(uint wLang, PWSTR szLang, uint cchLang);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("VERSION.dll")
BOOL VerQueryValueA(const(void)* pBlock, const(PSTR) lpSubBlock, void** lplpBuffer, uint* puLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("VERSION.dll")
BOOL VerQueryValueW(const(void)* pBlock, const(PWSTR) lpSubBlock, void** lplpBuffer, uint* puLen);

@DllImport("clfsw32.dll")
BOOLEAN LsnEqual(const(CLS_LSN)* plsn1, const(CLS_LSN)* plsn2);

@DllImport("clfsw32.dll")
BOOLEAN LsnLess(const(CLS_LSN)* plsn1, const(CLS_LSN)* plsn2);

@DllImport("clfsw32.dll")
BOOLEAN LsnGreater(const(CLS_LSN)* plsn1, const(CLS_LSN)* plsn2);

@DllImport("clfsw32.dll")
BOOLEAN LsnNull(const(CLS_LSN)* plsn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
uint LsnContainer(const(CLS_LSN)* plsn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
CLS_LSN LsnCreate(uint cidContainer, uint offBlock, uint cRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
uint LsnBlockOffset(const(CLS_LSN)* plsn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
uint LsnRecordSequence(const(CLS_LSN)* plsn);

@DllImport("clfsw32.dll")
BOOLEAN LsnInvalid(const(CLS_LSN)* plsn);

@DllImport("clfsw32.dll")
CLS_LSN LsnIncrement(CLS_LSN* plsn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
HANDLE CreateLogFile(const(PWSTR) pszLogFileName, uint fDesiredAccess, FILE_SHARE_MODE dwShareMode, 
                     SECURITY_ATTRIBUTES* psaLogFile, FILE_CREATION_DISPOSITION fCreateDisposition, 
                     FILE_FLAGS_AND_ATTRIBUTES fFlagsAndAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL DeleteLogByHandle(HANDLE hLog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL DeleteLogFile(const(PWSTR) pszLogFileName, void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL AddLogContainer(HANDLE hLog, ulong* pcbContainer, PWSTR pwszContainerPath, void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL AddLogContainerSet(HANDLE hLog, ushort cContainer, ulong* pcbContainer, PWSTR* rgwszContainerPath, 
                        void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL RemoveLogContainer(HANDLE hLog, PWSTR pwszContainerPath, BOOL fForce, void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL RemoveLogContainerSet(HANDLE hLog, ushort cContainer, PWSTR* rgwszContainerPath, BOOL fForce, void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL SetLogArchiveTail(HANDLE hLog, CLS_LSN* plsnArchiveTail, void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL SetEndOfLog(HANDLE hLog, CLS_LSN* plsnEnd, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL TruncateLog(void* pvMarshal, CLS_LSN* plsnEnd, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL CreateLogContainerScanContext(HANDLE hLog, uint cFromContainer, uint cContainers, ubyte eScanMode, 
                                   CLS_SCAN_CONTEXT* pcxScan, OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL ScanLogContainers(CLS_SCAN_CONTEXT* pcxScan, ubyte eScanMode, void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL AlignReservedLog(void* pvMarshal, uint cReservedRecords, long* rgcbReservation, long* pcbAlignReservation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL AllocReservedLog(void* pvMarshal, uint cReservedRecords, long* pcbAdjustment);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL FreeReservedLog(void* pvMarshal, uint cReservedRecords, long* pcbAdjustment);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL GetLogFileInformation(HANDLE hLog, CLS_INFORMATION* pinfoBuffer, uint* cbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL SetLogArchiveMode(HANDLE hLog, CLFS_LOG_ARCHIVE_MODE eMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL ReadLogRestartArea(void* pvMarshal, void** ppvRestartBuffer, uint* pcbRestartBuffer, CLS_LSN* plsn, 
                        void** ppvContext, OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL ReadPreviousLogRestartArea(void* pvReadContext, void** ppvRestartBuffer, uint* pcbRestartBuffer, 
                                CLS_LSN* plsnRestart, OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL WriteLogRestartArea(void* pvMarshal, void* pvRestartBuffer, uint cbRestartBuffer, CLS_LSN* plsnBase, 
                         CLFS_FLAG fFlags, uint* pcbWritten, CLS_LSN* plsnNext, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL GetLogReservationInfo(void* pvMarshal, uint* pcbRecordNumber, long* pcbUserReservation, 
                           long* pcbCommitReservation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL AdvanceLogBase(void* pvMarshal, CLS_LSN* plsnBase, uint fFlags, OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL CloseAndResetLogFile(HANDLE hLog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL CreateLogMarshallingArea(HANDLE hLog, CLFS_BLOCK_ALLOCATION pfnAllocBuffer, 
                              CLFS_BLOCK_DEALLOCATION pfnFreeBuffer, void* pvBlockAllocContext, 
                              uint cbMarshallingBuffer, uint cMaxWriteBuffers, uint cMaxReadBuffers, 
                              void** ppvMarshal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL DeleteLogMarshallingArea(void* pvMarshal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL ReserveAndAppendLog(void* pvMarshal, CLS_WRITE_ENTRY* rgWriteEntries, uint cWriteEntries, 
                         CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, uint cReserveRecords, long* rgcbReservation, 
                         CLFS_FLAG fFlags, CLS_LSN* plsn, OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL ReserveAndAppendLogAligned(void* pvMarshal, CLS_WRITE_ENTRY* rgWriteEntries, uint cWriteEntries, 
                                uint cbEntryAlignment, CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, 
                                uint cReserveRecords, long* rgcbReservation, CLFS_FLAG fFlags, CLS_LSN* plsn, 
                                OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL FlushLogBuffers(void* pvMarshal, 
                     /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL FlushLogToLsn(void* pvMarshalContext, CLS_LSN* plsnFlush, CLS_LSN* plsnLastFlushed, OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL ReadLogRecord(void* pvMarshal, CLS_LSN* plsnFirst, CLFS_CONTEXT_MODE eContextMode, void** ppvReadBuffer, 
                   uint* pcbReadBuffer, ubyte* peRecordType, CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, 
                   void** ppvReadContext, OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL ReadNextLogRecord(void* pvReadContext, void** ppvBuffer, uint* pcbBuffer, ubyte* peRecordType, 
                       CLS_LSN* plsnUser, CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, CLS_LSN* plsnRecord, 
                       OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL TerminateReadLog(void* pvCursorContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL PrepareLogArchive(HANDLE hLog, PWSTR pszBaseLogFileName, uint cLen, const(CLS_LSN)* plsnLow, 
                       const(CLS_LSN)* plsnHigh, uint* pcActualLength, ulong* poffBaseLogFileData, 
                       ulong* pcbBaseLogFileLength, CLS_LSN* plsnBase, CLS_LSN* plsnLast, 
                       CLS_LSN* plsnCurrentArchiveTail, void** ppvArchiveContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL ReadLogArchiveMetadata(void* pvArchiveContext, uint cbOffset, uint cbBytesToRead, ubyte* pbReadBuffer, 
                            uint* pcbBytesRead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL GetNextLogArchiveExtent(void* pvArchiveContext, CLS_ARCHIVE_DESCRIPTOR* rgadExtent, uint cDescriptors, 
                             uint* pcDescriptorsReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL TerminateLogArchive(void* pvArchiveContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL ValidateLog(const(PWSTR) pszLogFileName, SECURITY_ATTRIBUTES* psaLogFile, CLS_INFORMATION* pinfoBuffer, 
                 uint* pcbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL GetLogContainerName(HANDLE hLog, uint cidLogicalContainer, const(PWSTR) pwstrContainerName, 
                         uint cLenContainerName, uint* pcActualLenContainerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL GetLogIoStatistics(HANDLE hLog, void* pvStatsBuffer, uint cbStatsBuffer, CLFS_IOSTATS_CLASS eStatsClass, 
                        uint* pcbStatsWritten);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL RegisterManageableLogClient(HANDLE hLog, LOG_MANAGEMENT_CALLBACKS* pCallbacks);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL DeregisterManageableLogClient(HANDLE hLog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL ReadLogNotification(HANDLE hLog, CLFS_MGMT_NOTIFICATION* pNotification, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL InstallLogPolicy(HANDLE hLog, CLFS_MGMT_POLICY* pPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL RemoveLogPolicy(HANDLE hLog, CLFS_MGMT_POLICY_TYPE ePolicyType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL QueryLogPolicy(HANDLE hLog, CLFS_MGMT_POLICY_TYPE ePolicyType, CLFS_MGMT_POLICY* pPolicyBuffer, 
                    uint* pcbPolicyBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL SetLogFileSizeWithPolicy(HANDLE hLog, ulong* pDesiredSize, ulong* pResultingSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL HandleLogFull(HANDLE hLog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL LogTailAdvanceFailure(HANDLE hLog, uint dwReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("clfsw32.dll")
BOOL RegisterForLogWriteNotification(HANDLE hLog, uint cbThreshold, BOOL fEnable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint QueryUsersOnEncryptedFile(const(PWSTR) lpFileName, ENCRYPTION_CERTIFICATE_HASH_LIST** pUsers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint QueryRecoveryAgentsOnEncryptedFile(const(PWSTR) lpFileName, 
                                        ENCRYPTION_CERTIFICATE_HASH_LIST** pRecoveryAgents);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint RemoveUsersFromEncryptedFile(const(PWSTR) lpFileName, ENCRYPTION_CERTIFICATE_HASH_LIST* pHashes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint AddUsersToEncryptedFile(const(PWSTR) lpFileName, ENCRYPTION_CERTIFICATE_LIST* pEncryptionCertificates);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint SetUserFileEncryptionKey(ENCRYPTION_CERTIFICATE* pEncryptionCertificate);

@DllImport("ADVAPI32.dll")
uint SetUserFileEncryptionKeyEx(ENCRYPTION_CERTIFICATE* pEncryptionCertificate, uint dwCapabilities, uint dwFlags, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void FreeEncryptionCertificateHashList(ENCRYPTION_CERTIFICATE_HASH_LIST* pUsers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EncryptionDisable(const(PWSTR) DirPath, BOOL Disable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint DuplicateEncryptionInfoFile(const(PWSTR) SrcFileName, const(PWSTR) DstFileName, uint dwCreationDistribution, 
                                 uint dwAttributes, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

deprecated("marked as obsolete") 
@DllImport("ADVAPI32.dll")
uint GetEncryptedFileMetadata(const(PWSTR) lpFileName, uint* pcbMetadata, ubyte** ppbMetadata);

deprecated("marked as obsolete") 
@DllImport("ADVAPI32.dll")
uint SetEncryptedFileMetadata(const(PWSTR) lpFileName, ubyte* pbOldMetadata, ubyte* pbNewMetadata, 
                              ENCRYPTION_CERTIFICATE_HASH* pOwnerHash, uint dwOperation, 
                              ENCRYPTION_CERTIFICATE_HASH_LIST* pCertificatesAdded);

deprecated("marked as obsolete") 
@DllImport("ADVAPI32.dll")
void FreeEncryptedFileMetadata(ubyte* pbMetadata);

@DllImport("KERNEL32.dll")
int LZStart();

@DllImport("KERNEL32.dll")
void LZDone();

@DllImport("KERNEL32.dll")
int CopyLZFile(int hfSource, int hfDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int LZCopy(int hfSource, int hfDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int LZInit(int hfSource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int GetExpandedNameA(PSTR lpszSource, PSTR lpszBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int GetExpandedNameW(PWSTR lpszSource, PWSTR lpszBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int LZOpenFileA(PSTR lpFileName, OFSTRUCT* lpReOpenBuf, LZOPENFILE_STYLE wStyle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int LZOpenFileW(PWSTR lpFileName, OFSTRUCT* lpReOpenBuf, LZOPENFILE_STYLE wStyle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int LZSeek(int hFile, int lOffset, int iOrigin);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int LZRead(int hFile, 
           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR lpBuffer, 
           int cbRead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void LZClose(int hFile);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-wofshouldcompressbinaries
@DllImport("WOFUTIL.dll")
BOOL WofShouldCompressBinaries(const(PWSTR) Volume, uint* Algorithm);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-wofgetdriverversion
@DllImport("WOFUTIL.dll")
HRESULT WofGetDriverVersion(HANDLE FileOrVolumeHandle, uint Provider, uint* WofVersion);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-wofsetfiledatalocation
@DllImport("WOFUTIL.dll")
HRESULT WofSetFileDataLocation(HANDLE FileHandle, uint Provider, void* ExternalFileInfo, uint Length);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-wofisexternalfile
@DllImport("WOFUTIL.dll")
HRESULT WofIsExternalFile(const(PWSTR) FilePath, BOOL* IsExternalFile, uint* Provider, void* ExternalFileInfo, 
                          uint* BufferLength);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-wofenumentries
@DllImport("WOFUTIL.dll")
HRESULT WofEnumEntries(const(PWSTR) VolumeName, uint Provider, WofEnumEntryProc EnumProc, void* UserData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-wofwimaddentry
@DllImport("WOFUTIL.dll")
HRESULT WofWimAddEntry(const(PWSTR) VolumeName, const(PWSTR) WimPath, uint WimType, uint WimIndex, 
                       long* DataSourceId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-wofwimenumfiles
@DllImport("WOFUTIL.dll")
HRESULT WofWimEnumFiles(const(PWSTR) VolumeName, long DataSourceId, WofEnumFilesProc EnumProc, void* UserData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-wofwimsuspendentry
@DllImport("WOFUTIL.dll")
HRESULT WofWimSuspendEntry(const(PWSTR) VolumeName, long DataSourceId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-wofwimremoveentry
@DllImport("WOFUTIL.dll")
HRESULT WofWimRemoveEntry(const(PWSTR) VolumeName, long DataSourceId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-wofwimupdateentry
@DllImport("WOFUTIL.dll")
HRESULT WofWimUpdateEntry(const(PWSTR) VolumeName, long DataSourceId, const(PWSTR) NewWimPath);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wofapi/nf-wofapi-woffileenumfiles
@DllImport("WOFUTIL.dll")
HRESULT WofFileEnumFiles(const(PWSTR) VolumeName, uint Algorithm, WofEnumFilesProc EnumProc, void* UserData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("txfw32.dll")
BOOL TxfLogCreateFileReadContext(const(PWSTR) LogPath, CLS_LSN BeginningLsn, CLS_LSN EndingLsn, TXF_ID* TxfFileId, 
                                 void** TxfLogContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/txfw32/nf-txfw32-txflogcreaterangereadcontext
@DllImport("txfw32.dll")
BOOL TxfLogCreateRangeReadContext(const(PWSTR) LogPath, CLS_LSN BeginningLsn, CLS_LSN EndingLsn, 
                                  long* BeginningVirtualClock, long* EndingVirtualClock, uint RecordTypeMask, 
                                  void** TxfLogContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("txfw32.dll")
BOOL TxfLogDestroyReadContext(void* TxfLogContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("txfw32.dll")
BOOL TxfLogReadRecords(void* TxfLogContext, uint BufferLength, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Buffer, 
                       uint* BytesUsed, uint* RecordCount);

@DllImport("txfw32.dll")
BOOL TxfReadMetadataInfo(HANDLE FileHandle, TXF_ID* TxfFileId, CLS_LSN* LastLsn, uint* TransactionState, 
                         GUID* LockingTransaction);

@DllImport("txfw32.dll")
BOOL TxfLogRecordGetFileName(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* RecordBuffer, 
                             uint RecordBufferLengthInBytes, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR NameBuffer, 
                             uint* NameBufferLengthInBytes, TXF_ID* TxfId);

@DllImport("txfw32.dll")
BOOL TxfLogRecordGetGenericType(void* RecordBuffer, uint RecordBufferLengthInBytes, uint* GenericType, 
                                long* VirtualClock);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/txfw32/nf-txfw32-txfsetthreadminiversionforcreate
@DllImport("txfw32.dll")
void TxfSetThreadMiniVersionForCreate(ushort MiniVersion);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/txfw32/nf-txfw32-txfgetthreadminiversionforcreate
@DllImport("txfw32.dll")
void TxfGetThreadMiniVersionForCreate(ushort* MiniVersion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
HANDLE CreateTransaction(SECURITY_ATTRIBUTES* lpTransactionAttributes, GUID* UOW, uint CreateOptions, 
                         uint IsolationLevel, uint IsolationFlags, uint Timeout, PWSTR Description);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
HANDLE OpenTransaction(uint dwDesiredAccess, GUID* TransactionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL CommitTransaction(HANDLE TransactionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL CommitTransactionAsync(HANDLE TransactionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL RollbackTransaction(HANDLE TransactionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL RollbackTransactionAsync(HANDLE TransactionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL GetTransactionId(HANDLE TransactionHandle, GUID* TransactionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL GetTransactionInformation(HANDLE TransactionHandle, uint* Outcome, uint* IsolationLevel, uint* IsolationFlags, 
                               uint* Timeout, uint BufferLength, PWSTR Description);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL SetTransactionInformation(HANDLE TransactionHandle, uint IsolationLevel, uint IsolationFlags, uint Timeout, 
                               PWSTR Description);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
HANDLE CreateTransactionManager(SECURITY_ATTRIBUTES* lpTransactionAttributes, PWSTR LogFileName, 
                                uint CreateOptions, uint CommitStrength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
HANDLE OpenTransactionManager(PWSTR LogFileName, uint DesiredAccess, uint OpenOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
HANDLE OpenTransactionManagerById(GUID* TransactionManagerId, uint DesiredAccess, uint OpenOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL RenameTransactionManager(PWSTR LogFileName, GUID* ExistingTransactionManagerGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL RollforwardTransactionManager(HANDLE TransactionManagerHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL RecoverTransactionManager(HANDLE TransactionManagerHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL GetCurrentClockTransactionManager(HANDLE TransactionManagerHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL GetTransactionManagerId(HANDLE TransactionManagerHandle, GUID* TransactionManagerId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
HANDLE CreateResourceManager(SECURITY_ATTRIBUTES* lpResourceManagerAttributes, GUID* ResourceManagerId, 
                             uint CreateOptions, HANDLE TmHandle, PWSTR Description);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
HANDLE OpenResourceManager(uint dwDesiredAccess, HANDLE TmHandle, GUID* ResourceManagerId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL RecoverResourceManager(HANDLE ResourceManagerHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL GetNotificationResourceManager(HANDLE ResourceManagerHandle, 
                                    TRANSACTION_NOTIFICATION* TransactionNotification, uint NotificationLength, 
                                    uint dwMilliseconds, uint* ReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL GetNotificationResourceManagerAsync(HANDLE ResourceManagerHandle, 
                                         TRANSACTION_NOTIFICATION* TransactionNotification, 
                                         uint TransactionNotificationLength, uint* ReturnLength, 
                                         OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL SetResourceManagerCompletionPort(HANDLE ResourceManagerHandle, HANDLE IoCompletionPortHandle, 
                                      size_t CompletionKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
HANDLE CreateEnlistment(SECURITY_ATTRIBUTES* lpEnlistmentAttributes, HANDLE ResourceManagerHandle, 
                        HANDLE TransactionHandle, uint NotificationMask, uint CreateOptions, void* EnlistmentKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
HANDLE OpenEnlistment(uint dwDesiredAccess, HANDLE ResourceManagerHandle, GUID* EnlistmentId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL RecoverEnlistment(HANDLE EnlistmentHandle, void* EnlistmentKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL GetEnlistmentRecoveryInformation(HANDLE EnlistmentHandle, uint BufferSize, void* Buffer, uint* BufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL GetEnlistmentId(HANDLE EnlistmentHandle, GUID* EnlistmentId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL SetEnlistmentRecoveryInformation(HANDLE EnlistmentHandle, uint BufferSize, void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL PrepareEnlistment(HANDLE EnlistmentHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL PrePrepareEnlistment(HANDLE EnlistmentHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL CommitEnlistment(HANDLE EnlistmentHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL RollbackEnlistment(HANDLE EnlistmentHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL PrePrepareComplete(HANDLE EnlistmentHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL PrepareComplete(HANDLE EnlistmentHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL ReadOnlyEnlistment(HANDLE EnlistmentHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL CommitComplete(HANDLE EnlistmentHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL RollbackComplete(HANDLE EnlistmentHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ktmw32.dll")
BOOL SinglePhaseReject(HANDLE EnlistmentHandle, long* TmVirtualClock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetShareAdd(PWSTR servername, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetShareEnum(PWSTR servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                  uint* totalentries, uint* resume_handle);

@DllImport("NETAPI32.dll")
uint NetShareEnumSticky(PWSTR servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                        uint* totalentries, uint* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetShareGetInfo(PWSTR servername, PWSTR netname, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetShareSetInfo(PWSTR servername, PWSTR netname, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetShareDel(PWSTR servername, PWSTR netname, 
                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved);

@DllImport("NETAPI32.dll")
uint NetShareDelSticky(PWSTR servername, PWSTR netname, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetShareCheck(PWSTR servername, PWSTR device, uint* type);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetShareDelEx(PWSTR servername, uint level, ubyte* buf);

@DllImport("NETAPI32.dll")
uint NetServerAliasAdd(PWSTR servername, uint level, ubyte* buf);

@DllImport("NETAPI32.dll")
uint NetServerAliasDel(PWSTR servername, uint level, ubyte* buf);

@DllImport("NETAPI32.dll")
uint NetServerAliasEnum(PWSTR servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                        uint* totalentries, uint* resumehandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetSessionEnum(PWSTR servername, PWSTR UncClientName, PWSTR username, uint level, ubyte** bufptr, 
                    uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetSessionDel(PWSTR servername, PWSTR UncClientName, PWSTR username);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetSessionGetInfo(PWSTR servername, PWSTR UncClientName, PWSTR username, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetConnectionEnum(PWSTR servername, PWSTR qualifier, uint level, ubyte** bufptr, uint prefmaxlen, 
                       uint* entriesread, uint* totalentries, uint* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetFileClose(PWSTR servername, uint fileid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetFileEnum(PWSTR servername, PWSTR basepath, PWSTR username, uint level, ubyte** bufptr, uint prefmaxlen, 
                 uint* entriesread, uint* totalentries, size_t* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetFileGetInfo(PWSTR servername, uint fileid, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetStatisticsGet(byte* ServerName, byte* Service, uint Level, uint Options, ubyte** Buffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-queryioringcapabilities
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT QueryIoRingCapabilities(IORING_CAPABILITIES* capabilities);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-isioringopsupported
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
BOOL IsIoRingOpSupported(HIORING ioRing, IORING_OP_CODE op);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-createioring
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT CreateIoRing(IORING_VERSION ioringVersion, IORING_CREATE_FLAGS flags, uint submissionQueueSize, 
                     uint completionQueueSize, HIORING* h);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-getioringinfo
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT GetIoRingInfo(HIORING ioRing, IORING_INFO* info);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-submitioring
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT SubmitIoRing(HIORING ioRing, uint waitOperations, uint milliseconds, uint* submittedEntries);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-closeioring
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT CloseIoRing(HIORING ioRing);

//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT PopIoRingCompletion(HIORING ioRing, IORING_CQE* cqe);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-setioringcompletionevent
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT SetIoRingCompletionEvent(HIORING ioRing, HANDLE hEvent);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-buildioringcancelrequest
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT BuildIoRingCancelRequest(HIORING ioRing, IORING_HANDLE_REF file, size_t opToCancel, size_t userData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-buildioringreadfile
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT BuildIoRingReadFile(HIORING ioRing, IORING_HANDLE_REF fileRef, IORING_BUFFER_REF dataRef, 
                            uint numberOfBytesToRead, ulong fileOffset, size_t userData, IORING_SQE_FLAGS sqeFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-buildioringregisterfilehandles
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT BuildIoRingRegisterFileHandles(HIORING ioRing, uint count, const(HANDLE)* handles, size_t userData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ioringapi/nf-ioringapi-buildioringregisterbuffers
@DllImport("api-ms-win-core-ioring-l1-1-0.dll")
HRESULT BuildIoRingRegisterBuffers(HIORING ioRing, uint count, const(IORING_BUFFER_INFO)* buffers, size_t userData);

@DllImport("KERNEL32.dll")
HRESULT BuildIoRingWriteFile(HIORING ioRing, IORING_HANDLE_REF fileRef, IORING_BUFFER_REF bufferRef, 
                             uint numberOfBytesToWrite, ulong fileOffset, FILE_WRITE_FLAGS writeFlags, 
                             size_t userData, IORING_SQE_FLAGS sqeFlags);

@DllImport("KERNEL32.dll")
HRESULT BuildIoRingFlushFile(HIORING ioRing, IORING_HANDLE_REF fileRef, FILE_FLUSH_MODE flushMode, size_t userData, 
                             IORING_SQE_FLAGS sqeFlags);

@DllImport("KERNEL32.dll")
HRESULT BuildIoRingReadFileScatter(HIORING ioRing, IORING_HANDLE_REF fileRef, uint segmentCount, 
                                   FILE_SEGMENT_ELEMENT* segmentArray, uint numberOfBytesToRead, ulong fileOffset, 
                                   size_t userData, IORING_SQE_FLAGS sqeFlags);

@DllImport("KERNEL32.dll")
HRESULT BuildIoRingWriteFileGather(HIORING ioRing, IORING_HANDLE_REF fileRef, uint segmentCount, 
                                   FILE_SEGMENT_ELEMENT* segmentArray, uint numberOfBytesToWrite, ulong fileOffset, 
                                   FILE_WRITE_FLAGS writeFlags, size_t userData, IORING_SQE_FLAGS sqeFlags);

@DllImport("BINDFLTAPI.dll")
HRESULT CreateBindLink(const(PWSTR) virtualPath, const(PWSTR) backingPath, 
                       CREATE_BIND_LINK_FLAGS createBindLinkFlags, uint exceptionCount, const(PWSTR)* exceptionPaths);

@DllImport("BINDFLTAPI.dll")
HRESULT RemoveBindLink(const(PWSTR) virtualPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOLEAN Wow64EnableWow64FsRedirection(BOOLEAN Wow64FsEnableRedirection);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL Wow64DisableWow64FsRedirection(void** OldValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL Wow64RevertWow64FsRedirection(void* OlValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetBinaryTypeA(const(PSTR) lpApplicationName, uint* lpBinaryType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetBinaryTypeW(const(PWSTR) lpApplicationName, uint* lpBinaryType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetShortPathNameA(const(PSTR) lpszLongPath, PSTR lpszShortPath, uint cchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetLongPathNameTransactedA(const(PSTR) lpszShortPath, PSTR lpszLongPath, uint cchBuffer, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetLongPathNameTransactedW(const(PWSTR) lpszShortPath, PWSTR lpszLongPath, uint cchBuffer, 
                                HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileCompletionNotificationModes(HANDLE FileHandle, ubyte Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileShortNameA(HANDLE hFile, const(PSTR) lpShortName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileShortNameW(HANDLE hFile, const(PWSTR) lpShortName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint SetTapePosition(HANDLE hDevice, TAPE_POSITION_METHOD dwPositionMethod, uint dwPartition, uint dwOffsetLow, 
                     uint dwOffsetHigh, BOOL bImmediate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetTapePosition(HANDLE hDevice, TAPE_POSITION_TYPE dwPositionType, uint* lpdwPartition, uint* lpdwOffsetLow, 
                     uint* lpdwOffsetHigh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint PrepareTape(HANDLE hDevice, PREPARE_TAPE_OPERATION dwOperation, BOOL bImmediate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint EraseTape(HANDLE hDevice, ERASE_TAPE_TYPE dwEraseType, BOOL bImmediate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint CreateTapePartition(HANDLE hDevice, CREATE_TAPE_PARTITION_METHOD dwPartitionMethod, uint dwCount, uint dwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint WriteTapemark(HANDLE hDevice, TAPEMARK_TYPE dwTapemarkType, uint dwTapemarkCount, BOOL bImmediate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetTapeStatus(HANDLE hDevice);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetTapeParameters(HANDLE hDevice, GET_TAPE_DRIVE_PARAMETERS_OPERATION dwOperation, uint* lpdwSize, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpTapeInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint SetTapeParameters(HANDLE hDevice, TAPE_INFORMATION_TYPE dwOperation, void* lpTapeInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EncryptFileA(const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EncryptFileW(const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL DecryptFileA(const(PSTR) lpFileName, 
                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL DecryptFileW(const(PWSTR) lpFileName, 
                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL FileEncryptionStatusA(const(PSTR) lpFileName, uint* lpStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL FileEncryptionStatusW(const(PWSTR) lpFileName, uint* lpStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint OpenEncryptedFileRawA(const(PSTR) lpFileName, uint ulFlags, void** pvContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint OpenEncryptedFileRawW(const(PWSTR) lpFileName, uint ulFlags, void** pvContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint ReadEncryptedFileRaw(PFE_EXPORT_FUNC pfExportCallback, void* pvCallbackContext, void* pvContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint WriteEncryptedFileRaw(PFE_IMPORT_FUNC pfImportCallback, void* pvCallbackContext, void* pvContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void CloseEncryptedFileRaw(void* pvContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int OpenFile(const(PSTR) lpFileName, OFSTRUCT* lpReOpenBuff, uint uStyle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL BackupRead(HANDLE hFile, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* lpBuffer, 
                uint nNumberOfBytesToRead, uint* lpNumberOfBytesRead, BOOL bAbort, BOOL bProcessSecurity, 
                void** lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL BackupSeek(HANDLE hFile, uint dwLowBytesToSeek, uint dwHighBytesToSeek, uint* lpdwLowByteSeeked, 
                uint* lpdwHighByteSeeked, void** lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL BackupWrite(HANDLE hFile, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* lpBuffer, 
                 uint nNumberOfBytesToWrite, uint* lpNumberOfBytesWritten, BOOL bAbort, BOOL bProcessSecurity, 
                 void** lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetLogicalDriveStringsA(uint nBufferLength, PSTR lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL SetSearchPathMode(uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CreateDirectoryExA(const(PSTR) lpTemplateDirectory, const(PSTR) lpNewDirectory, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CreateDirectoryExW(const(PWSTR) lpTemplateDirectory, const(PWSTR) lpNewDirectory, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL CreateDirectoryTransactedA(const(PSTR) lpTemplateDirectory, const(PSTR) lpNewDirectory, 
                                SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL CreateDirectoryTransactedW(const(PWSTR) lpTemplateDirectory, const(PWSTR) lpNewDirectory, 
                                SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL RemoveDirectoryTransactedA(const(PSTR) lpPathName, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL RemoveDirectoryTransactedW(const(PWSTR) lpPathName, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetFullPathNameTransactedA(const(PSTR) lpFileName, uint nBufferLength, PSTR lpBuffer, PSTR* lpFilePart, 
                                HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetFullPathNameTransactedW(const(PWSTR) lpFileName, uint nBufferLength, PWSTR lpBuffer, PWSTR* lpFilePart, 
                                HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DefineDosDeviceA(DEFINE_DOS_DEVICE_FLAGS dwFlags, const(PSTR) lpDeviceName, const(PSTR) lpTargetPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint QueryDosDeviceA(const(PSTR) lpDeviceName, PSTR lpTargetPath, uint ucchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateFileTransactedA(const(PSTR) lpFileName, uint dwDesiredAccess, FILE_SHARE_MODE dwShareMode, 
                             SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                             FILE_CREATION_DISPOSITION dwCreationDisposition, 
                             FILE_FLAGS_AND_ATTRIBUTES dwFlagsAndAttributes, HANDLE hTemplateFile, 
                             HANDLE hTransaction, TXFS_MINIVERSION* pusMiniVersion, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpExtendedParameter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateFileTransactedW(const(PWSTR) lpFileName, uint dwDesiredAccess, FILE_SHARE_MODE dwShareMode, 
                             SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                             FILE_CREATION_DISPOSITION dwCreationDisposition, 
                             FILE_FLAGS_AND_ATTRIBUTES dwFlagsAndAttributes, HANDLE hTemplateFile, 
                             HANDLE hTransaction, TXFS_MINIVERSION* pusMiniVersion, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpExtendedParameter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE ReOpenFile(HANDLE hOriginalFile, uint dwDesiredAccess, FILE_SHARE_MODE dwShareMode, 
                  FILE_FLAGS_AND_ATTRIBUTES dwFlagsAndAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileAttributesTransactedA(const(PSTR) lpFileName, uint dwFileAttributes, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileAttributesTransactedW(const(PWSTR) lpFileName, uint dwFileAttributes, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileAttributesTransactedA(const(PSTR) lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, 
                                  void* lpFileInformation, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileAttributesTransactedW(const(PWSTR) lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, 
                                  void* lpFileInformation, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetCompressedFileSizeTransactedA(const(PSTR) lpFileName, uint* lpFileSizeHigh, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetCompressedFileSizeTransactedW(const(PWSTR) lpFileName, uint* lpFileSizeHigh, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL DeleteFileTransactedA(const(PSTR) lpFileName, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL DeleteFileTransactedW(const(PWSTR) lpFileName, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL CheckNameLegalDOS8Dot3A(const(PSTR) lpName, PSTR lpOemName, uint OemNameSize, BOOL* pbNameContainsSpaces, 
                             BOOL* pbNameLegal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL CheckNameLegalDOS8Dot3W(const(PWSTR) lpName, PSTR lpOemName, uint OemNameSize, BOOL* pbNameContainsSpaces, 
                             BOOL* pbNameLegal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstFileTransactedA(const(PSTR) lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, void* lpFindFileData, 
                                FINDEX_SEARCH_OPS fSearchOp, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpSearchFilter, 
                                uint dwAdditionalFlags, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstFileTransactedW(const(PWSTR) lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, void* lpFindFileData, 
                                FINDEX_SEARCH_OPS fSearchOp, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpSearchFilter, 
                                uint dwAdditionalFlags, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CopyFileA(const(PSTR) lpExistingFileName, const(PSTR) lpNewFileName, BOOL bFailIfExists);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CopyFileW(const(PWSTR) lpExistingFileName, const(PWSTR) lpNewFileName, BOOL bFailIfExists);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CopyFileExA(const(PSTR) lpExistingFileName, const(PSTR) lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, 
                 void* lpData, BOOL* pbCancel, COPYFILE_FLAGS dwCopyFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CopyFileExW(const(PWSTR) lpExistingFileName, const(PWSTR) lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, 
                 void* lpData, BOOL* pbCancel, COPYFILE_FLAGS dwCopyFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL CopyFileTransactedA(const(PSTR) lpExistingFileName, const(PSTR) lpNewFileName, 
                         LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, BOOL* pbCancel, uint dwCopyFlags, 
                         HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL CopyFileTransactedW(const(PWSTR) lpExistingFileName, const(PWSTR) lpNewFileName, 
                         LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, BOOL* pbCancel, uint dwCopyFlags, 
                         HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
HRESULT CopyFile2(const(PWSTR) pwszExistingFileName, const(PWSTR) pwszNewFileName, 
                  COPYFILE2_EXTENDED_PARAMETERS* pExtendedParameters);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL MoveFileA(const(PSTR) lpExistingFileName, const(PSTR) lpNewFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL MoveFileW(const(PWSTR) lpExistingFileName, const(PWSTR) lpNewFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL MoveFileExA(const(PSTR) lpExistingFileName, const(PSTR) lpNewFileName, MOVE_FILE_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL MoveFileExW(const(PWSTR) lpExistingFileName, const(PWSTR) lpNewFileName, MOVE_FILE_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL MoveFileWithProgressA(const(PSTR) lpExistingFileName, const(PSTR) lpNewFileName, 
                           LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, MOVE_FILE_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL MoveFileWithProgressW(const(PWSTR) lpExistingFileName, const(PWSTR) lpNewFileName, 
                           LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, MOVE_FILE_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL MoveFileTransactedA(const(PSTR) lpExistingFileName, const(PSTR) lpNewFileName, 
                         LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, MOVE_FILE_FLAGS dwFlags, 
                         HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL MoveFileTransactedW(const(PWSTR) lpExistingFileName, const(PWSTR) lpNewFileName, 
                         LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, MOVE_FILE_FLAGS dwFlags, 
                         HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ReplaceFileA(const(PSTR) lpReplacedFileName, const(PSTR) lpReplacementFileName, const(PSTR) lpBackupFileName, 
                  REPLACE_FILE_FLAGS dwReplaceFlags, 
                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpExclude, 
                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ReplaceFileW(const(PWSTR) lpReplacedFileName, const(PWSTR) lpReplacementFileName, 
                  const(PWSTR) lpBackupFileName, REPLACE_FILE_FLAGS dwReplaceFlags, 
                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpExclude, 
                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CreateHardLinkA(const(PSTR) lpFileName, const(PSTR) lpExistingFileName, 
                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/SECURITY_ATTRIBUTES* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CreateHardLinkW(const(PWSTR) lpFileName, const(PWSTR) lpExistingFileName, 
                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/SECURITY_ATTRIBUTES* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL CreateHardLinkTransactedA(const(PSTR) lpFileName, const(PSTR) lpExistingFileName, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                               HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL CreateHardLinkTransactedW(const(PWSTR) lpFileName, const(PWSTR) lpExistingFileName, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                               HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstStreamTransactedW(const(PWSTR) lpFileName, STREAM_INFO_LEVELS InfoLevel, void* lpFindStreamData, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                                  HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstFileNameTransactedW(const(PWSTR) lpFileName, uint dwFlags, uint* StringLength, PWSTR LinkName, 
                                    HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetVolumeLabelA(const(PSTR) lpRootPathName, const(PSTR) lpVolumeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetVolumeLabelW(const(PWSTR) lpRootPathName, const(PWSTR) lpVolumeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetFileBandwidthReservation(HANDLE hFile, uint nPeriodMilliseconds, uint nBytesPerPeriod, BOOL bDiscardable, 
                                 uint* lpTransferSize, uint* lpNumOutstandingRequests);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileBandwidthReservation(HANDLE hFile, uint* lpPeriodMilliseconds, uint* lpBytesPerPeriod, 
                                 BOOL* pDiscardable, uint* lpTransferSize, uint* lpNumOutstandingRequests);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ReadDirectoryChangesW(HANDLE hDirectory, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                           uint nBufferLength, BOOL bWatchSubtree, FILE_NOTIFY_CHANGE dwNotifyFilter, 
                           uint* lpBytesReturned, OVERLAPPED* lpOverlapped, 
                           LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("KERNEL32.dll")
BOOL ReadDirectoryChangesExW(HANDLE hDirectory, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                             uint nBufferLength, BOOL bWatchSubtree, FILE_NOTIFY_CHANGE dwNotifyFilter, 
                             uint* lpBytesReturned, OVERLAPPED* lpOverlapped, 
                             LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, 
                             READ_DIRECTORY_NOTIFY_INFORMATION_CLASS ReadDirectoryNotifyInformationClass);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstVolumeA(PSTR lpszVolumeName, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindNextVolumeA(HANDLE hFindVolume, PSTR lpszVolumeName, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstVolumeMountPointA(const(PSTR) lpszRootPathName, PSTR lpszVolumeMountPoint, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE FindFirstVolumeMountPointW(const(PWSTR) lpszRootPathName, PWSTR lpszVolumeMountPoint, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindNextVolumeMountPointA(HANDLE hFindVolumeMountPoint, PSTR lpszVolumeMountPoint, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindNextVolumeMountPointW(HANDLE hFindVolumeMountPoint, PWSTR lpszVolumeMountPoint, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindVolumeMountPointClose(HANDLE hFindVolumeMountPoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetVolumeMountPointA(const(PSTR) lpszVolumeMountPoint, const(PSTR) lpszVolumeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetVolumeMountPointW(const(PWSTR) lpszVolumeMountPoint, const(PWSTR) lpszVolumeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DeleteVolumeMountPointA(const(PSTR) lpszVolumeMountPoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetVolumeNameForVolumeMountPointA(const(PSTR) lpszVolumeMountPoint, PSTR lpszVolumeName, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetVolumePathNameA(const(PSTR) lpszFileName, PSTR lpszVolumePathName, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetVolumePathNamesForVolumeNameA(const(PSTR) lpszVolumeName, 
                                      /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR lpszVolumePathNames, 
                                      uint cchBufferLength, uint* lpcchReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileInformationByHandleEx(HANDLE hFile, FILE_INFO_BY_HANDLE_CLASS FileInformationClass, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpFileInformation, 
                                  uint dwBufferSize);

@DllImport("KERNEL32.dll")
BOOL GetFileInformationByName(const(PWSTR) FileName, FILE_INFO_BY_NAME_CLASS FileInformationClass, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* FileInfoBuffer, 
                              uint FileInfoBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE OpenFileById(HANDLE hVolumeHint, FILE_ID_DESCRIPTOR* lpFileId, uint dwDesiredAccess, 
                    FILE_SHARE_MODE dwShareMode, SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                    FILE_FLAGS_AND_ATTRIBUTES dwFlagsAndAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOLEAN CreateSymbolicLinkA(const(PSTR) lpSymlinkFileName, const(PSTR) lpTargetFileName, 
                            SYMBOLIC_LINK_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOLEAN CreateSymbolicLinkW(const(PWSTR) lpSymlinkFileName, const(PWSTR) lpTargetFileName, 
                            SYMBOLIC_LINK_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOLEAN CreateSymbolicLinkTransactedA(const(PSTR) lpSymlinkFileName, const(PSTR) lpTargetFileName, 
                                      SYMBOLIC_LINK_FLAGS dwFlags, HANDLE hTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOLEAN CreateSymbolicLinkTransactedW(const(PWSTR) lpSymlinkFileName, const(PWSTR) lpTargetFileName, 
                                      SYMBOLIC_LINK_FLAGS dwFlags, HANDLE hTransaction);


// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nn-dskquota-idiskquotauser
@GUID("7988b574-ec89-11cf-9c00-00aa00a14f56")
interface IDiskQuotaUser : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getid
    HRESULT GetID(uint* pulID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getname
    HRESULT GetName(PWSTR pszAccountContainer, uint cchAccountContainer, PWSTR pszLogonName, uint cchLogonName, 
                    PWSTR pszDisplayName, uint cchDisplayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getsidlength
    HRESULT GetSidLength(uint* pdwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getsid
    HRESULT GetSid(ubyte* pbSidBuffer, uint cbSidBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getquotathreshold
    HRESULT GetQuotaThreshold(long* pllThreshold);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getquotathresholdtext
    HRESULT GetQuotaThresholdText(PWSTR pszText, uint cchText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getquotalimit
    HRESULT GetQuotaLimit(long* pllLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getquotalimittext
    HRESULT GetQuotaLimitText(PWSTR pszText, uint cchText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getquotaused
    HRESULT GetQuotaUsed(long* pllUsed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getquotausedtext
    HRESULT GetQuotaUsedText(PWSTR pszText, uint cchText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getquotainformation
    HRESULT GetQuotaInformation(void* pbQuotaInfo, uint cbQuotaInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-setquotathreshold
    HRESULT SetQuotaThreshold(long llThreshold, BOOL fWriteThrough);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-setquotalimit
    HRESULT SetQuotaLimit(long llLimit, BOOL fWriteThrough);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-invalidate
    HRESULT Invalidate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauser-getaccountstatus
    HRESULT GetAccountStatus(uint* pdwStatus);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nn-dskquota-ienumdiskquotausers
@GUID("7988b577-ec89-11cf-9c00-00aa00a14f56")
interface IEnumDiskQuotaUsers : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-ienumdiskquotausers-next
    HRESULT Next(uint cUsers, IDiskQuotaUser* rgUsers, uint* pcUsersFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-ienumdiskquotausers-skip
    HRESULT Skip(uint cUsers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-ienumdiskquotausers-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-ienumdiskquotausers-clone
    HRESULT Clone(IEnumDiskQuotaUsers* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nn-dskquota-idiskquotauserbatch
@GUID("7988b576-ec89-11cf-9c00-00aa00a14f56")
interface IDiskQuotaUserBatch : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauserbatch-add
    HRESULT Add(IDiskQuotaUser pUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauserbatch-remove
    HRESULT Remove(IDiskQuotaUser pUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauserbatch-removeall
    HRESULT RemoveAll();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotauserbatch-flushtodisk
    HRESULT FlushToDisk();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nn-dskquota-idiskquotacontrol
@GUID("7988b572-ec89-11cf-9c00-00aa00a14f56")
interface IDiskQuotaControl : IConnectionPointContainer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-initialize
    HRESULT Initialize(const(PWSTR) pszPath, BOOL bReadWrite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-setquotastate
    HRESULT SetQuotaState(uint dwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-getquotastate
    HRESULT GetQuotaState(uint* pdwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-setquotalogflags
    HRESULT SetQuotaLogFlags(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-getquotalogflags
    HRESULT GetQuotaLogFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-setdefaultquotathreshold
    HRESULT SetDefaultQuotaThreshold(long llThreshold);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-getdefaultquotathreshold
    HRESULT GetDefaultQuotaThreshold(long* pllThreshold);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-getdefaultquotathresholdtext
    HRESULT GetDefaultQuotaThresholdText(PWSTR pszText, uint cchText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-setdefaultquotalimit
    HRESULT SetDefaultQuotaLimit(long llLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-getdefaultquotalimit
    HRESULT GetDefaultQuotaLimit(long* pllLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-getdefaultquotalimittext
    HRESULT GetDefaultQuotaLimitText(PWSTR pszText, uint cchText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-addusersid
    HRESULT AddUserSid(PSID pUserSid, DISKQUOTA_USERNAME_RESOLVE fNameResolution, IDiskQuotaUser* ppUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-addusername
    HRESULT AddUserName(const(PWSTR) pszLogonName, DISKQUOTA_USERNAME_RESOLVE fNameResolution, 
                        IDiskQuotaUser* ppUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-deleteuser
    HRESULT DeleteUser(IDiskQuotaUser pUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-findusersid
    HRESULT FindUserSid(PSID pUserSid, DISKQUOTA_USERNAME_RESOLVE fNameResolution, IDiskQuotaUser* ppUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-findusername
    HRESULT FindUserName(const(PWSTR) pszLogonName, IDiskQuotaUser* ppUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-createenumusers
    HRESULT CreateEnumUsers(PSID* rgpUserSids, uint cpSids, DISKQUOTA_USERNAME_RESOLVE fNameResolution, 
                            IEnumDiskQuotaUsers* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-createuserbatch
    HRESULT CreateUserBatch(IDiskQuotaUserBatch* ppBatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-invalidatesidnamecache
    HRESULT InvalidateSidNameCache();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-giveusernameresolutionpriority
    HRESULT GiveUserNameResolutionPriority(IDiskQuotaUser pUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotacontrol-shutdownnameresolution
    HRESULT ShutdownNameResolution();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nn-dskquota-idiskquotaevents
@GUID("7988b579-ec89-11cf-9c00-00aa00a14f56")
interface IDiskQuotaEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dskquota/nf-dskquota-idiskquotaevents-onusernamechanged
    HRESULT OnUserNameChanged(IDiskQuotaUser pUser);
}


// GUIDs


const GUID IID_IDiskQuotaControl   = GUIDOF!IDiskQuotaControl;
const GUID IID_IDiskQuotaEvents    = GUIDOF!IDiskQuotaEvents;
const GUID IID_IDiskQuotaUser      = GUIDOF!IDiskQuotaUser;
const GUID IID_IDiskQuotaUserBatch = GUIDOF!IDiskQuotaUserBatch;
const GUID IID_IEnumDiskQuotaUsers = GUIDOF!IEnumDiskQuotaUsers;
