module windows.distributedfilesystem;

public import system;

extern(Windows):

enum DFS_TARGET_PRIORITY_CLASS
{
    DfsInvalidPriorityClass = -1,
    DfsSiteCostNormalPriorityClass = 0,
    DfsGlobalHighPriorityClass = 1,
    DfsSiteCostHighPriorityClass = 2,
    DfsSiteCostLowPriorityClass = 3,
    DfsGlobalLowPriorityClass = 4,
}

struct DFS_TARGET_PRIORITY
{
    DFS_TARGET_PRIORITY_CLASS TargetPriorityClass;
    ushort TargetPriorityRank;
    ushort Reserved;
}

struct DFS_INFO_1
{
    const(wchar)* EntryPath;
}

struct DFS_INFO_2
{
    const(wchar)* EntryPath;
    const(wchar)* Comment;
    uint State;
    uint NumberOfStorages;
}

struct DFS_STORAGE_INFO
{
    uint State;
    const(wchar)* ServerName;
    const(wchar)* ShareName;
}

struct DFS_STORAGE_INFO_1
{
    uint State;
    const(wchar)* ServerName;
    const(wchar)* ShareName;
    DFS_TARGET_PRIORITY TargetPriority;
}

struct DFS_INFO_3
{
    const(wchar)* EntryPath;
    const(wchar)* Comment;
    uint State;
    uint NumberOfStorages;
    DFS_STORAGE_INFO* Storage;
}

struct DFS_INFO_4
{
    const(wchar)* EntryPath;
    const(wchar)* Comment;
    uint State;
    uint Timeout;
    Guid Guid;
    uint NumberOfStorages;
    DFS_STORAGE_INFO* Storage;
}

struct DFS_INFO_5
{
    const(wchar)* EntryPath;
    const(wchar)* Comment;
    uint State;
    uint Timeout;
    Guid Guid;
    uint PropertyFlags;
    uint MetadataSize;
    uint NumberOfStorages;
}

struct DFS_INFO_6
{
    const(wchar)* EntryPath;
    const(wchar)* Comment;
    uint State;
    uint Timeout;
    Guid Guid;
    uint PropertyFlags;
    uint MetadataSize;
    uint NumberOfStorages;
    DFS_STORAGE_INFO_1* Storage;
}

struct DFS_INFO_7
{
    Guid GenerationGuid;
}

struct DFS_INFO_8
{
    const(wchar)* EntryPath;
    const(wchar)* Comment;
    uint State;
    uint Timeout;
    Guid Guid;
    uint PropertyFlags;
    uint MetadataSize;
    uint SdLengthReserved;
    void* pSecurityDescriptor;
    uint NumberOfStorages;
}

struct DFS_INFO_9
{
    const(wchar)* EntryPath;
    const(wchar)* Comment;
    uint State;
    uint Timeout;
    Guid Guid;
    uint PropertyFlags;
    uint MetadataSize;
    uint SdLengthReserved;
    void* pSecurityDescriptor;
    uint NumberOfStorages;
    DFS_STORAGE_INFO_1* Storage;
}

struct DFS_INFO_50
{
    uint NamespaceMajorVersion;
    uint NamespaceMinorVersion;
    ulong NamespaceCapabilities;
}

struct DFS_INFO_100
{
    const(wchar)* Comment;
}

struct DFS_INFO_101
{
    uint State;
}

struct DFS_INFO_102
{
    uint Timeout;
}

struct DFS_INFO_103
{
    uint PropertyFlagMask;
    uint PropertyFlags;
}

struct DFS_INFO_104
{
    DFS_TARGET_PRIORITY TargetPriority;
}

struct DFS_INFO_105
{
    const(wchar)* Comment;
    uint State;
    uint Timeout;
    uint PropertyFlagMask;
    uint PropertyFlags;
}

struct DFS_INFO_106
{
    uint State;
    DFS_TARGET_PRIORITY TargetPriority;
}

struct DFS_INFO_107
{
    const(wchar)* Comment;
    uint State;
    uint Timeout;
    uint PropertyFlagMask;
    uint PropertyFlags;
    uint SdLengthReserved;
    void* pSecurityDescriptor;
}

struct DFS_INFO_150
{
    uint SdLengthReserved;
    void* pSecurityDescriptor;
}

struct DFS_INFO_200
{
    const(wchar)* FtDfsName;
}

struct DFS_INFO_300
{
    uint Flags;
    const(wchar)* DfsName;
}

struct DFS_SITENAME_INFO
{
    uint SiteFlags;
    const(wchar)* SiteName;
}

struct DFS_SITELIST_INFO
{
    uint cSites;
    DFS_SITENAME_INFO Site;
}

enum DFS_NAMESPACE_VERSION_ORIGIN
{
    DFS_NAMESPACE_VERSION_ORIGIN_COMBINED = 0,
    DFS_NAMESPACE_VERSION_ORIGIN_SERVER = 1,
    DFS_NAMESPACE_VERSION_ORIGIN_DOMAIN = 2,
}

struct DFS_SUPPORTED_NAMESPACE_VERSION_INFO
{
    uint DomainDfsMajorVersion;
    uint DomainDfsMinorVersion;
    ulong DomainDfsCapabilities;
    uint StandaloneDfsMajorVersion;
    uint StandaloneDfsMinorVersion;
    ulong StandaloneDfsCapabilities;
}

struct DFS_GET_PKT_ENTRY_STATE_ARG
{
    ushort DfsEntryPathLen;
    ushort ServerNameLen;
    ushort ShareNameLen;
    uint Level;
    ushort Buffer;
}

@DllImport("dfscli.dll")
uint NetDfsAdd(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, const(wchar)* Comment, uint Flags);

@DllImport("dfscli.dll")
uint NetDfsAddStdRoot(const(wchar)* ServerName, const(wchar)* RootShare, const(wchar)* Comment, uint Flags);

@DllImport("dfscli.dll")
uint NetDfsRemoveStdRoot(const(wchar)* ServerName, const(wchar)* RootShare, uint Flags);

@DllImport("dfscli.dll")
uint NetDfsAddFtRoot(const(wchar)* ServerName, const(wchar)* RootShare, const(wchar)* FtDfsName, const(wchar)* Comment, uint Flags);

@DllImport("dfscli.dll")
uint NetDfsRemoveFtRoot(const(wchar)* ServerName, const(wchar)* RootShare, const(wchar)* FtDfsName, uint Flags);

@DllImport("dfscli.dll")
uint NetDfsRemoveFtRootForced(const(wchar)* DomainName, const(wchar)* ServerName, const(wchar)* RootShare, const(wchar)* FtDfsName, uint Flags);

@DllImport("dfscli.dll")
uint NetDfsRemove(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName);

@DllImport("dfscli.dll")
uint NetDfsEnum(const(wchar)* DfsName, uint Level, uint PrefMaxLen, ubyte** Buffer, uint* EntriesRead, uint* ResumeHandle);

@DllImport("dfscli.dll")
uint NetDfsGetInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, ubyte** Buffer);

@DllImport("dfscli.dll")
uint NetDfsSetInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, ubyte* Buffer);

@DllImport("dfscli.dll")
uint NetDfsGetClientInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, ubyte** Buffer);

@DllImport("dfscli.dll")
uint NetDfsSetClientInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, ubyte* Buffer);

@DllImport("dfscli.dll")
uint NetDfsMove(const(wchar)* OldDfsEntryPath, const(wchar)* NewDfsEntryPath, uint Flags);

@DllImport("dfscli.dll")
uint NetDfsAddRootTarget(const(wchar)* pDfsPath, const(wchar)* pTargetPath, uint MajorVersion, const(wchar)* pComment, uint Flags);

@DllImport("dfscli.dll")
uint NetDfsRemoveRootTarget(const(wchar)* pDfsPath, const(wchar)* pTargetPath, uint Flags);

@DllImport("dfscli.dll")
uint NetDfsGetSecurity(const(wchar)* DfsEntryPath, uint SecurityInformation, void** ppSecurityDescriptor, uint* lpcbSecurityDescriptor);

@DllImport("dfscli.dll")
uint NetDfsSetSecurity(const(wchar)* DfsEntryPath, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("dfscli.dll")
uint NetDfsGetStdContainerSecurity(const(wchar)* MachineName, uint SecurityInformation, void** ppSecurityDescriptor, uint* lpcbSecurityDescriptor);

@DllImport("dfscli.dll")
uint NetDfsSetStdContainerSecurity(const(wchar)* MachineName, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("dfscli.dll")
uint NetDfsGetFtContainerSecurity(const(wchar)* DomainName, uint SecurityInformation, void** ppSecurityDescriptor, uint* lpcbSecurityDescriptor);

@DllImport("dfscli.dll")
uint NetDfsSetFtContainerSecurity(const(wchar)* DomainName, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("dfscli.dll")
uint NetDfsGetSupportedNamespaceVersion(DFS_NAMESPACE_VERSION_ORIGIN Origin, const(wchar)* pName, DFS_SUPPORTED_NAMESPACE_VERSION_INFO** ppVersionInfo);

