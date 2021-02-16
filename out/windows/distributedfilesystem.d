module windows.distributedfilesystem;

public import windows.core;

extern(Windows):


// Enums


enum : int
{
    DfsInvalidPriorityClass        = 0xffffffff,
    DfsSiteCostNormalPriorityClass = 0x00000000,
    DfsGlobalHighPriorityClass     = 0x00000001,
    DfsSiteCostHighPriorityClass   = 0x00000002,
    DfsSiteCostLowPriorityClass    = 0x00000003,
    DfsGlobalLowPriorityClass      = 0x00000004,
}
alias DFS_TARGET_PRIORITY_CLASS = int;

enum : int
{
    DFS_NAMESPACE_VERSION_ORIGIN_COMBINED = 0x00000000,
    DFS_NAMESPACE_VERSION_ORIGIN_SERVER   = 0x00000001,
    DFS_NAMESPACE_VERSION_ORIGIN_DOMAIN   = 0x00000002,
}
alias DFS_NAMESPACE_VERSION_ORIGIN = int;

// Structs


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
    uint          State;
    uint          NumberOfStorages;
}

struct DFS_STORAGE_INFO
{
    uint          State;
    const(wchar)* ServerName;
    const(wchar)* ShareName;
}

struct DFS_STORAGE_INFO_1
{
    uint                State;
    const(wchar)*       ServerName;
    const(wchar)*       ShareName;
    DFS_TARGET_PRIORITY TargetPriority;
}

struct DFS_INFO_3
{
    const(wchar)*     EntryPath;
    const(wchar)*     Comment;
    uint              State;
    uint              NumberOfStorages;
    DFS_STORAGE_INFO* Storage;
}

struct DFS_INFO_4
{
    const(wchar)*     EntryPath;
    const(wchar)*     Comment;
    uint              State;
    uint              Timeout;
    GUID              Guid;
    uint              NumberOfStorages;
    DFS_STORAGE_INFO* Storage;
}

struct DFS_INFO_5
{
    const(wchar)* EntryPath;
    const(wchar)* Comment;
    uint          State;
    uint          Timeout;
    GUID          Guid;
    uint          PropertyFlags;
    uint          MetadataSize;
    uint          NumberOfStorages;
}

struct DFS_INFO_6
{
    const(wchar)*       EntryPath;
    const(wchar)*       Comment;
    uint                State;
    uint                Timeout;
    GUID                Guid;
    uint                PropertyFlags;
    uint                MetadataSize;
    uint                NumberOfStorages;
    DFS_STORAGE_INFO_1* Storage;
}

struct DFS_INFO_7
{
    GUID GenerationGuid;
}

struct DFS_INFO_8
{
    const(wchar)* EntryPath;
    const(wchar)* Comment;
    uint          State;
    uint          Timeout;
    GUID          Guid;
    uint          PropertyFlags;
    uint          MetadataSize;
    uint          SdLengthReserved;
    void*         pSecurityDescriptor;
    uint          NumberOfStorages;
}

struct DFS_INFO_9
{
    const(wchar)*       EntryPath;
    const(wchar)*       Comment;
    uint                State;
    uint                Timeout;
    GUID                Guid;
    uint                PropertyFlags;
    uint                MetadataSize;
    uint                SdLengthReserved;
    void*               pSecurityDescriptor;
    uint                NumberOfStorages;
    DFS_STORAGE_INFO_1* Storage;
}

struct DFS_INFO_50
{
    uint  NamespaceMajorVersion;
    uint  NamespaceMinorVersion;
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
    uint          State;
    uint          Timeout;
    uint          PropertyFlagMask;
    uint          PropertyFlags;
}

struct DFS_INFO_106
{
    uint                State;
    DFS_TARGET_PRIORITY TargetPriority;
}

struct DFS_INFO_107
{
    const(wchar)* Comment;
    uint          State;
    uint          Timeout;
    uint          PropertyFlagMask;
    uint          PropertyFlags;
    uint          SdLengthReserved;
    void*         pSecurityDescriptor;
}

struct DFS_INFO_150
{
    uint  SdLengthReserved;
    void* pSecurityDescriptor;
}

struct DFS_INFO_200
{
    const(wchar)* FtDfsName;
}

struct DFS_INFO_300
{
    uint          Flags;
    const(wchar)* DfsName;
}

struct DFS_SITENAME_INFO
{
    uint          SiteFlags;
    const(wchar)* SiteName;
}

struct DFS_SITELIST_INFO
{
    uint                 cSites;
    DFS_SITENAME_INFO[1] Site;
}

struct DFS_SUPPORTED_NAMESPACE_VERSION_INFO
{
    uint  DomainDfsMajorVersion;
    uint  DomainDfsMinorVersion;
    ulong DomainDfsCapabilities;
    uint  StandaloneDfsMajorVersion;
    uint  StandaloneDfsMinorVersion;
    ulong StandaloneDfsCapabilities;
}

struct DFS_GET_PKT_ENTRY_STATE_ARG
{
    ushort    DfsEntryPathLen;
    ushort    ServerNameLen;
    ushort    ShareNameLen;
    uint      Level;
    ushort[1] Buffer;
}

// Functions

@DllImport("dfscli")
uint NetDfsAdd(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, 
               const(wchar)* Comment, uint Flags);

@DllImport("dfscli")
uint NetDfsAddStdRoot(const(wchar)* ServerName, const(wchar)* RootShare, const(wchar)* Comment, uint Flags);

@DllImport("dfscli")
uint NetDfsRemoveStdRoot(const(wchar)* ServerName, const(wchar)* RootShare, uint Flags);

@DllImport("dfscli")
uint NetDfsAddFtRoot(const(wchar)* ServerName, const(wchar)* RootShare, const(wchar)* FtDfsName, 
                     const(wchar)* Comment, uint Flags);

@DllImport("dfscli")
uint NetDfsRemoveFtRoot(const(wchar)* ServerName, const(wchar)* RootShare, const(wchar)* FtDfsName, uint Flags);

@DllImport("dfscli")
uint NetDfsRemoveFtRootForced(const(wchar)* DomainName, const(wchar)* ServerName, const(wchar)* RootShare, 
                              const(wchar)* FtDfsName, uint Flags);

@DllImport("dfscli")
uint NetDfsRemove(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName);

@DllImport("dfscli")
uint NetDfsEnum(const(wchar)* DfsName, uint Level, uint PrefMaxLen, ubyte** Buffer, uint* EntriesRead, 
                uint* ResumeHandle);

@DllImport("dfscli")
uint NetDfsGetInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, 
                   ubyte** Buffer);

@DllImport("dfscli")
uint NetDfsSetInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, 
                   ubyte* Buffer);

@DllImport("dfscli")
uint NetDfsGetClientInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, 
                         ubyte** Buffer);

@DllImport("dfscli")
uint NetDfsSetClientInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, 
                         ubyte* Buffer);

@DllImport("dfscli")
uint NetDfsMove(const(wchar)* OldDfsEntryPath, const(wchar)* NewDfsEntryPath, uint Flags);

@DllImport("dfscli")
uint NetDfsAddRootTarget(const(wchar)* pDfsPath, const(wchar)* pTargetPath, uint MajorVersion, 
                         const(wchar)* pComment, uint Flags);

@DllImport("dfscli")
uint NetDfsRemoveRootTarget(const(wchar)* pDfsPath, const(wchar)* pTargetPath, uint Flags);

@DllImport("dfscli")
uint NetDfsGetSecurity(const(wchar)* DfsEntryPath, uint SecurityInformation, void** ppSecurityDescriptor, 
                       uint* lpcbSecurityDescriptor);

@DllImport("dfscli")
uint NetDfsSetSecurity(const(wchar)* DfsEntryPath, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("dfscli")
uint NetDfsGetStdContainerSecurity(const(wchar)* MachineName, uint SecurityInformation, 
                                   void** ppSecurityDescriptor, uint* lpcbSecurityDescriptor);

@DllImport("dfscli")
uint NetDfsSetStdContainerSecurity(const(wchar)* MachineName, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("dfscli")
uint NetDfsGetFtContainerSecurity(const(wchar)* DomainName, uint SecurityInformation, void** ppSecurityDescriptor, 
                                  uint* lpcbSecurityDescriptor);

@DllImport("dfscli")
uint NetDfsSetFtContainerSecurity(const(wchar)* DomainName, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("dfscli")
uint NetDfsGetSupportedNamespaceVersion(DFS_NAMESPACE_VERSION_ORIGIN Origin, const(wchar)* pName, 
                                        DFS_SUPPORTED_NAMESPACE_VERSION_INFO** ppVersionInfo);


