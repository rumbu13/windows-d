// Written in the D programming language.

module windows.distributedfilesystem;

public import windows.core;

extern(Windows):


// Enums


///Defines the set of possible DFS target priority class settings.
alias DFS_TARGET_PRIORITY_CLASS = int;
enum : int
{
    ///The priority class is not valid.
    DfsInvalidPriorityClass        = 0xffffffff,
    ///The middle or "normal" site cost priority class for a DFS target.
    DfsSiteCostNormalPriorityClass = 0x00000000,
    ///The highest priority class for a DFS target. Targets assigned this class receive global preference.
    DfsGlobalHighPriorityClass     = 0x00000001,
    ///The highest site cost priority class for a DFS target. Targets assigned this class receive the most preference
    ///among targets of the same site cost for a given DFS client.
    DfsSiteCostHighPriorityClass   = 0x00000002,
    ///The lowest site cost priority class for a DFS target. Targets assigned this class receive the least preference
    ///among targets of the same site cost for a given DFS client.
    DfsSiteCostLowPriorityClass    = 0x00000003,
    ///The lowest level of priority class for a DFS target. Targets assigned this class receive the least preference
    ///globally.
    DfsGlobalLowPriorityClass      = 0x00000004,
}

///Identifies the origin of DFS namespace version information.
alias DFS_NAMESPACE_VERSION_ORIGIN = int;
enum : int
{
    ///The version information specifies the maximum version that the server and the Active Directory Domain Service (AD
    ///DS) domain can support.
    DFS_NAMESPACE_VERSION_ORIGIN_COMBINED = 0x00000000,
    ///The version information specifies the maximum version that the server can support.
    DFS_NAMESPACE_VERSION_ORIGIN_SERVER   = 0x00000001,
    ///The version information specifies the maximum version that the AD DS domain can support.
    DFS_NAMESPACE_VERSION_ORIGIN_DOMAIN   = 0x00000002,
}

// Structs


///Contains the priority class and rank of a specific DFS target.
struct DFS_TARGET_PRIORITY
{
    ///DFS_TARGET_PRIORITY_CLASS enumeration value that specifies the priority class of the target.
    DFS_TARGET_PRIORITY_CLASS TargetPriorityClass;
    ///Specifies the priority rank value of the target. The default value is 0, which indicates the highest priority
    ///rank within a priority class.
    ushort TargetPriorityRank;
    ///This member is reserved and must be zero.
    ushort Reserved;
}

///Contains the name of a Distributed File System (DFS) root or link. This structure is only for use with the
///NetDfsEnum, NetDfsGetClientInfo, and NetDfsGetInfo functions and the FSCTL_DFS_GET_PKT_ENTRY_STATE control code.
struct DFS_INFO_1
{
    ///Pointer to a null-terminated Unicode string that specifies the Universal Naming Convention (UNC) path of a DFS
    ///root or link. For a link, the string can be in one of two forms. The first form is as follows: &
    const(wchar)* EntryPath;
}

///Contains information about a Distributed File System (DFS) root or link. This structure contains the name, status,
///and number of DFS targets for the root or link. This structure is only for use with the NetDfsEnum,
///NetDfsGetClientInfo, and NetDfsGetInfo functions and the FSCTL_DFS_GET_PKT_ENTRY_STATE control code.
struct DFS_INFO_2
{
    ///Pointer to a null-terminated Unicode string that specifies the Universal Naming Convention (UNC) path of a DFS
    ///root or link. For a link, the string can be in one of two forms. The first form is as follows: &
    const(wchar)* EntryPath;
    ///Pointer to a null-terminated Unicode string that contains a comment associated with the DFS root or link.
    const(wchar)* Comment;
    ///Specifies a set of bit flags that describe the DFS root or link. One <b>DFS_VOLUME_STATE</b> flag is set, and one
    ///<b>DFS_VOLUME_FLAVOR</b> flag is set. The <b>DFS_VOLUME_FLAVORS</b> bitmask (0x00000300) must be used to extract
    ///the DFS namespace flavor, and the <b>DFS_VOLUME_STATES</b> bitmask (0x0000000F) must be used to extract the DFS
    ///root or link state from this member. For an example that describes the interpretation of the flags, see the
    ///following Remarks section.
    uint          State;
    ///Specifies the number of DFS targets.
    uint          NumberOfStorages;
}

///Contains information about a DFS root or link target in a DFS namespace or from the cache maintained by the DFS
///client. Information about a DFS root or link target in a DFS namespace is retrieved by calling the NetDfsGetInfo
///function. Information about a DFS root or link target from the cache maintained by the DFS client is retrieved by
///calling the NetDfsGetClientInfo function.
struct DFS_STORAGE_INFO
{
    ///State of the target. When this structure is returned as a result of calling the NetDfsGetInfo function, this
    ///member can be one of the following values.
    uint          State;
    ///Pointer to a null-terminated Unicode string that specifies the DFS root target or link target server name.
    const(wchar)* ServerName;
    ///Pointer to a null-terminated Unicode string that specifies the DFS root target or link target share name.
    const(wchar)* ShareName;
}

///Contains information about a DFS target, including the DFS target server name and share name as well as the target's
///state and priority.
struct DFS_STORAGE_INFO_1
{
    ///State of the target. This member can be one of the following values.
    uint                State;
    ///Pointer to a null-terminated Unicode string that specifies the DFS root target or link target server name.
    const(wchar)*       ServerName;
    ///Pointer to a null-terminated Unicode string that specifies the DFS root target or link target share name.
    const(wchar)*       ShareName;
    ///DFS_TARGET_PRIORITY structure that contains a DFS target's priority class and rank.
    DFS_TARGET_PRIORITY TargetPriority;
}

///Contains information about a Distributed File System (DFS) root or link. This structure contains the name, status,
///number of DFS targets, and information about each target of the root or link. This structure is only for use with the
///NetDfsEnum, NetDfsGetClientInfo, and NetDfsGetInfo functions and the FSCTL_DFS_GET_PKT_ENTRY_STATE control code.
struct DFS_INFO_3
{
    ///Pointer to a null-terminated Unicode string that specifies the Universal Naming Convention (UNC) path of a DFS
    ///root or link. For a link, the string can be in one of two forms. The first form is as follows: &
    const(wchar)*     EntryPath;
    ///Pointer to a null-terminated Unicode string that contains a comment associated with the DFS root or link.
    const(wchar)*     Comment;
    ///Specifies a set of bit flags that describe the DFS root or link. One <b>DFS_VOLUME_STATE</b> flag is set, and one
    ///<b>DFS_VOLUME_FLAVOR</b> flag is set. The <b>DFS_VOLUME_FLAVORS</b> bitmask (0x00000300) must be used to extract
    ///the DFS namespace flavor, and the <b>DFS_VOLUME_STATES</b> bitmask (0x0000000F) must be used to extract the DFS
    ///root or link state from this member. For an example that describes the interpretation of the flags, see the
    ///Remarks section of DFS_INFO_2.
    uint              State;
    ///Specifies the number of DFS targets.
    uint              NumberOfStorages;
    DFS_STORAGE_INFO* Storage;
}

///Contains information about a Distributed File System (DFS) root or link. This structure contains the name, status,
///<b>GUID</b>, time-out, number of targets, and information about each target of the root or link. This structure is
///only for use with the NetDfsEnum, NetDfsGetClientInfo, and NetDfsGetInfo functions and the
///FSCTL_DFS_GET_PKT_ENTRY_STATE control code.
struct DFS_INFO_4
{
    ///Pointer to a null-terminated Unicode string that specifies the Universal Naming Convention (UNC) path of a DFS
    ///root or link. For a link, the string can be in one of two forms. The first form is as follows: &
    const(wchar)*     EntryPath;
    ///Pointer to a null-terminated Unicode string that contains a comment associated with the DFS root or link.
    const(wchar)*     Comment;
    ///Specifies a set of bit flags that describe the DFS root or link. One <b>DFS_VOLUME_STATE</b> flag is set, and one
    ///<b>DFS_VOLUME_FLAVOR</b> flag is set. The <b>DFS_VOLUME_FLAVORS</b> bitmask (0x00000300) must be used to extract
    ///the DFS namespace flavor, and the <b>DFS_VOLUME_STATES</b> bitmask (0x0000000F) must be used to extract the DFS
    ///root or link state from this field. For an example that describes the interpretation of the flags, see the
    ///Remarks section of DFS_INFO_2.
    uint              State;
    ///Specifies the time-out, in seconds, of the DFS root or link.
    uint              Timeout;
    ///Specifies the GUID of the DFS root or link.
    GUID              Guid;
    ///Specifies the number of DFS targets.
    uint              NumberOfStorages;
    DFS_STORAGE_INFO* Storage;
}

///Contains information about a Distributed File System (DFS) root or link. This structure contains the name, status,
///<b>GUID</b>, time-out, namespace/root/link properties, metadata size, and number of targets for the root or link.
///This structure is only for use with the NetDfsEnum, NetDfsGetClientInfo, and NetDfsGetInfo functions. To retrieve
///information about the targets of the DFS namespace, use DFS_INFO_6 instead.
struct DFS_INFO_5
{
    ///Pointer to a null-terminated Unicode string that specifies the Universal Naming Convention (UNC) path of a DFS
    ///root or link. For a link, the string can be in one of two forms. The first form is as follows: &
    const(wchar)* EntryPath;
    ///Pointer to a null-terminated Unicode string that contains a comment associated with the DFS root or link.
    const(wchar)* Comment;
    ///Specifies a set of bit flags that describe the DFS root or link. One <b>DFS_VOLUME_STATE</b> flag is set, and one
    ///<b>DFS_VOLUME_FLAVOR</b> flag is set. For an example that describes the interpretation of the flags, see the
    ///Remarks section of DFS_INFO_2.
    uint          State;
    ///Specifies the time-out, in seconds, of the DFS root or link.
    uint          Timeout;
    ///Specifies the GUID of the DFS root or link.
    GUID          Guid;
    ///Specifies a set of flags describing specific properties of a DFS namespace, root, or link.
    uint          PropertyFlags;
    ///For domain-based DFS namespaces, this member specifies the size of the corresponding Active Directory data blob,
    ///in bytes. For stand-alone DFS namespaces, this member specifies the size of the metadata stored in the registry,
    ///including the key names and value names as well as the specific data items associated with them. This member is
    ///valid for DFS roots only.
    uint          MetadataSize;
    ///Specifies the number of targets for the DFS root or link.
    uint          NumberOfStorages;
}

///Contains information about a Distributed File System (DFS) root or link. This structure contains the name, status,
///<b>GUID</b>, time-out, namespace/root/link properties, metadata size, number of targets, and information about each
///target of the root or link. This structure is only for use with the NetDfsEnum, NetDfsGetClientInfo, and
///NetDfsGetInfo functions. To obtain information about the DFS namespace without target information, use DFS_INFO_5
///instead.
struct DFS_INFO_6
{
    ///Pointer to a null-terminated Unicode string that specifies the Universal Naming Convention (UNC) path of a DFS
    ///root or link. For a link, the string can be in one of two forms. The first form is as follows: &
    const(wchar)*       EntryPath;
    ///Pointer to a null-terminated Unicode string that contains a comment associated with the DFS root or link.
    const(wchar)*       Comment;
    ///Specifies a set of bit flags that describe the DFS root or link. One <b>DFS_VOLUME_STATE</b> flag is set, and one
    ///<b>DFS_VOLUME_FLAVOR</b> flag is set. The <b>DFS_VOLUME_FLAVORS</b> bitmask (0x00000300) must be used to extract
    ///the DFS namespace flavor, and the <b>DFS_VOLUME_STATES</b> bitmask (0x0000000F) must be used to extract the DFS
    ///root or link state from this member. For an example that describes the interpretation of the flags, see the
    ///Remarks section of DFS_INFO_2.
    uint                State;
    ///Specifies the time-out, in seconds, of the DFS root or link.
    uint                Timeout;
    ///Specifies the <b>GUID</b> of the DFS root or link.
    GUID                Guid;
    ///Specifies a set of flags describing specific properties of a DFS namespace, root, or link.
    uint                PropertyFlags;
    ///For domain-based DFS namespaces, this member specifies the size of the corresponding Active Directory data blob,
    ///in bytes. For stand-alone DFS namespaces, this field specifies the size of the metadata stored in the registry,
    ///including the key names and value names as well as the specific data items associated with them. This field is
    ///valid for DFS roots only.
    uint                MetadataSize;
    ///Specifies the number of targets for the DFS root or link. These targets are contained in the <b>Storage</b>
    ///member of this structure.
    uint                NumberOfStorages;
    DFS_STORAGE_INFO_1* Storage;
}

///Contains information about a DFS namespace. This structure contains the version <b>GUID</b> for the metadata for the
///namespace. This information level is available to DFS roots only.
struct DFS_INFO_7
{
    ///The value of this <b>GUID</b> changes each time the DFS metadata is changed.
    GUID GenerationGuid;
}

///Contains the name, status, <b>GUID</b>, time-out, property flags, metadata size, DFS target information, and link
///reparse point security descriptor for a root or link. This structure is only for use with the NetDfsGetInfo and
///NetDfsEnum functions.
struct DFS_INFO_8
{
    ///Pointer to a null-terminated Unicode string that specifies the Universal Naming Convention (UNC) path of a DFS
    ///root or link. For a link, the string can be in one of two forms. The first form is as follows: &
    const(wchar)* EntryPath;
    ///Pointer to a null-terminated Unicode string that contains a comment associated with the DFS root or link.
    const(wchar)* Comment;
    ///Specifies a set of bit flags that describe the DFS root or link. One <b>DFS_VOLUME_STATE</b> flag is set, and one
    ///<b>DFS_VOLUME_FLAVOR</b> flag is set. The <b>DFS_VOLUME_FLAVORS</b> bitmask (0x00000300) must be used to extract
    ///the DFS namespace flavor, and the <b>DFS_VOLUME_STATES</b> bitmask (0x0000000F) must be used to extract the DFS
    ///root or link state from this member. For an example that describes the interpretation of the flags, see the
    ///Remarks section of DFS_INFO_2.
    uint          State;
    ///Specifies the time-out, in seconds, of the DFS root or link.
    uint          Timeout;
    ///Specifies the <b>GUID</b> of the DFS root or link.
    GUID          Guid;
    ///Specifies a set of flags that describe specific properties of a DFS namespace, root, or link.
    uint          PropertyFlags;
    ///For domain-based DFS namespaces, this member specifies the size of the corresponding Active Directory data blob,
    ///in bytes. For stand-alone DFS namespaces, this field specifies the size of the metadata stored in the registry,
    ///including the key names and value names, in addition to the specific data items associated with them. This field
    ///is valid for DFS roots only.
    uint          MetadataSize;
    ///This member is reserved for system use.
    uint          SdLengthReserved;
    void*         pSecurityDescriptor;
    ///Specifies the number of storage servers for the volume that contains the DFS root or link.
    uint          NumberOfStorages;
}

///Contains the name, status, <b>GUID</b>, time-out, property flags, metadata size, DFS target information, link reparse
///point security descriptor, and a list of DFS targets for a root or link. This structure is only for use with the
///NetDfsGetInfo and NetDfsEnum functions.
struct DFS_INFO_9
{
    ///Pointer to a null-terminated Unicode string that specifies the Universal Naming Convention (UNC) path of a DFS
    ///root or link. For a link, the string can be in one of two forms. The first form is as follows: &
    const(wchar)*       EntryPath;
    ///Pointer to a null-terminated Unicode string that contains a comment associated with the DFS root or link.
    const(wchar)*       Comment;
    ///Specifies a set of bit flags that describe the DFS root or link. One <b>DFS_VOLUME_STATE</b> flag is set, and one
    ///<b>DFS_VOLUME_FLAVOR</b> flag is set. The <b>DFS_VOLUME_FLAVORS</b> bitmask (0x00000300) must be used to extract
    ///the DFS namespace flavor, and the <b>DFS_VOLUME_STATES</b> bitmask (0x0000000F) must be used to extract the DFS
    ///root or link state from this member. For an example that describes the interpretation of the flags, see the
    ///Remarks section of DFS_INFO_2.
    uint                State;
    ///Specifies the time-out, in seconds, of the DFS root or link.
    uint                Timeout;
    ///Specifies the <b>GUID</b> of the DFS root or link.
    GUID                Guid;
    ///Specifies a set of flags that describe specific properties of a DFS namespace, root, or link.
    uint                PropertyFlags;
    ///For domain-based DFS namespaces, this member specifies the size of the corresponding Active Directory data blob,
    ///in bytes. For stand-alone DFS namespaces, this field specifies the size of the metadata stored in the registry,
    ///including the key names and value names, in addition to the specific data items associated with them. This field
    ///is valid for DFS roots only.
    uint                MetadataSize;
    ///This member is reserved for system use.
    uint                SdLengthReserved;
    void*               pSecurityDescriptor;
    ///Specifies the number of targets for the DFS root or link. These targets are contained in the <b>Storage</b>
    ///member of this structure.
    uint                NumberOfStorages;
    DFS_STORAGE_INFO_1* Storage;
}

///Contains the DFS metadata version and capabilities of an existing DFS namespace. This structure is only for use with
///the NetDfsGetInfo function.
struct DFS_INFO_50
{
    ///The major version of the DFS metadata.
    uint  NamespaceMajorVersion;
    ///The minor version of the DFS metadata.
    uint  NamespaceMinorVersion;
    ///Specifies a set of flags that describe specific capabilities of a DFS namespace.
    ulong NamespaceCapabilities;
}

///Contains a comment associated with a Distributed File System (DFS) root or link.
struct DFS_INFO_100
{
    ///Pointer to a null-terminated Unicode string that contains the comment associated with the specified DFS root or
    ///link. The comment is associated with the DFS namespace root or link and not with a specific DFS root target or
    ///link target.
    const(wchar)* Comment;
}

///Describes the state of storage on a DFS root, link, root target, or link target.
struct DFS_INFO_101
{
    ///Specifies a set of bit flags that describe the status of the host server. Following are valid values for this
    ///member. Note that the <b>DFS_STORAGE_STATE_OFFLINE</b> and <b>DFS_STORAGE_STATE_ONLINE</b> values are mutually
    ///exclusive. The storage states can only be set on DFS root targets or DFS link targets. The DFS volume states can
    ///only be set on a DFS namespace root or DFS link and not on individual targets.
    uint State;
}

///Contains a time-out value to associate with a Distributed File System (DFS) root or a link in a named DFS root.
struct DFS_INFO_102
{
    ///Specifies the time-out, in seconds, to apply to the specified DFS root or link.
    uint Timeout;
}

///Contains properties that set specific behaviors for a DFS root or link. This structure can only be used with the
///NetDfsSetInfo function.
struct DFS_INFO_103
{
    ///Specifies a mask value that indicates which flags are valid for evaluation in the <b>PropertyFlags</b> field.
    uint PropertyFlagMask;
    ///Bitfield, with each bit responsible for a specific property applicable to the whole DFS namespace, the DFS root,
    ///or an individual DFS link, depending on the actual property. Any combination of bits is allowed unless indicated
    ///otherwise.
    uint PropertyFlags;
}

///Contains the priority of a DFS root target or link target. This structure is only for use with the NetDfsSetInfo
///function.
struct DFS_INFO_104
{
    ///DFS_TARGET_PRIORITY structure that contains the specific priority class and rank of a DFS target.
    DFS_TARGET_PRIORITY TargetPriority;
}

///Contains information about a DFS root or link, including comment, state, time-out, and DFS behaviors specified by
///property flags. This structure is only for use with the NetDfsSetInfo function.
struct DFS_INFO_105
{
    ///Pointer to a null-terminated Unicode string that contains a comment associated with the DFS root or link.
    const(wchar)* Comment;
    ///Specifies a set of bit flags that describe the state of the DFS root or link; the state of the DFS namespace root
    ///cannot be changed. One <b>DFS_VOLUME_STATE</b> flag is set, and one <b>DFS_VOLUME_FLAVOR</b> flag is set. For an
    ///example that describes the interpretation of these flags, see the Remarks section of DFS_INFO_2.
    uint          State;
    ///Specifies the time-out, in seconds, of the DFS root or link.
    uint          Timeout;
    ///Specifies a mask value that indicates which flags are valid for evaluation in the <b>PropertyFlags</b> field.
    uint          PropertyFlagMask;
    ///Bitfield, with each bit responsible for a specific property applicable to the whole DFS namespace, the DFS root,
    ///or an individual DFS link, depending on the actual property. Any combination of bits is allowed unless indicated
    ///otherwise.
    uint          PropertyFlags;
}

///Contains the storage state and priority for a DFS root target or link target. This structure is only for use with the
///NetDfsSetInfo function.
struct DFS_INFO_106
{
    ///State of the target as one of the following values.
    uint                State;
    ///DFS_TARGET_PRIORITY structure that contains the specific priority class and rank of a DFS target.
    DFS_TARGET_PRIORITY TargetPriority;
}

///Contains information about a DFS root or link, including the comment, state, time-out, property flags, and link
///reparse point security descriptor. This structure is only for use with the NetDfsGetInfo and NetDfsSetInfo functions.
struct DFS_INFO_107
{
    ///Pointer to a null-terminated Unicode string that contains a comment associated with the DFS root or link.
    const(wchar)* Comment;
    ///Specifies a set of bit flags that describe the DFS root or link. One <b>DFS_VOLUME_STATE</b> flag is set, and one
    ///<b>DFS_VOLUME_FLAVOR</b> flag is set. The <b>DFS_VOLUME_FLAVORS</b> bitmask (0x00000300) must be used to extract
    ///the DFS namespace flavor, and the <b>DFS_VOLUME_STATES</b> bitmask (0x0000000F) must be used to extract the DFS
    ///root or link state from this member. For an example that describes the interpretation of the flags, see the
    ///Remarks section of DFS_INFO_2.
    uint          State;
    ///Specifies the time-out, in seconds, of the DFS root or link.
    uint          Timeout;
    ///Specifies a mask value that indicates which flags are valid for evaluation in the <b>PropertyFlags</b> field.
    uint          PropertyFlagMask;
    ///Bitfield, with each bit responsible for a specific property applicable to the whole DFS namespace, the DFS root,
    ///or an individual DFS link, depending on the actual property. Any combination of bits is allowed unless indicated
    ///otherwise.
    uint          PropertyFlags;
    ///This member is reserved for system use.
    uint          SdLengthReserved;
    void*         pSecurityDescriptor;
}

///Contains the security descriptor for a DFS link's reparse point. This structure is only for use with the
///NetDfsGetInfo and NetDfsSetInfo functions.
struct DFS_INFO_150
{
    ///This member is reserved for system use.
    uint  SdLengthReserved;
    void* pSecurityDescriptor;
}

///Contains the name of a domain-based Distributed File System (DFS) namespace.
struct DFS_INFO_200
{
    ///Pointer to a null-terminated Unicode string that contains the name of a domain-based DFS namespace.
    const(wchar)* FtDfsName;
}

///Contains the name and type (domain-based or stand-alone) of a DFS namespace.
struct DFS_INFO_300
{
    ///Value that specifies the type of the DFS namespace. This member can be one of the following values.
    uint          Flags;
    ///Pointer to a null-terminated Unicode string that contains the name of a DFS namespace. This member can have one
    ///of the following two formats. The first format is: &
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

///Contains version information for a DFS namespace.
struct DFS_SUPPORTED_NAMESPACE_VERSION_INFO
{
    ///The major version of the domain-based DFS namespace.
    uint  DomainDfsMajorVersion;
    ///The minor version of the domain-based DFS namespace.
    uint  DomainDfsMinorVersion;
    ///Specifies a set of flags that describe specific capabilities of a domain-based DFS namespace.
    ulong DomainDfsCapabilities;
    ///The major version of the stand-alone DFS namespace.
    uint  StandaloneDfsMajorVersion;
    ///The minor version of the stand-alone DFS namespace.
    uint  StandaloneDfsMinorVersion;
    ///Specifies a set of flags that describe specific capabilities of a stand-alone DFS namespace.
    ulong StandaloneDfsCapabilities;
}

///Input buffer used with the FSCTL_DFS_GET_PKT_ENTRY_STATE control code.
struct DFS_GET_PKT_ENTRY_STATE_ARG
{
    ///Length of the DFS Entry Path Unicode string in bytes stored in the <i>Buffer</i> parameter.
    ushort    DfsEntryPathLen;
    ///Length of the Server Name Unicode string in bytes stored in the <i>Buffer</i> parameter following the DFS Entry
    ///Path string.
    ushort    ServerNameLen;
    ///Length of the Share Name Unicode string in bytes stored in the <i>Buffer</i> parameter following the Server Name
    ///string.
    ushort    ShareNameLen;
    ///Length of the Level string in bytes.
    uint      Level;
    ///On input this contains the three Unicode strings in order. The Unicode strings are not <b>NULL</b> terminated and
    ///there is no delimiter between the strings.
    ushort[1] Buffer;
}

// Functions

///Creates a new Distributed File System (DFS) link or adds targets to an existing link in a DFS namespace.
///Params:
///    DfsEntryPath = Pointer to a string that specifies the Universal Naming Convention (UNC) path of a DFS link in a DFS namespace.
///                   The string can be in one of two forms. The first form is as follows: &
///    ServerName = Pointer to a string that specifies the link target server name. This parameter is required.
///    ShareName = Pointer to a string that specifies the link target share name. This can also be a share name with a path relative
///                to the share. For example, <i>share1\mydir1\mydir2</i>. This parameter is required.
///    Comment = Pointer to a string that specifies an optional comment associated with the DFS link. This parameter is ignored
///              when the function adds a target to an existing link.
///    Flags = This parameter can specify the following value, or you can specify zero for no flags.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsAdd(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, 
               const(wchar)* Comment, uint Flags);

///Creates a new stand-alone Distributed File System (DFS) namespace.
///Params:
///    ServerName = Pointer to a string that specifies the name of the server that will host the new stand-alone DFS namespace. This
///                 parameter is required.
///    RootShare = Pointer to a string that specifies the name of the shared folder for the new stand-alone DFS namespace on the
///                server that will host the namespace. This parameter is required.
///    Comment = Pointer to a string that contains an optional comment associated with the DFS namespace.
///    Flags = This parameter is reserved and must be zero.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsAddStdRoot(const(wchar)* ServerName, const(wchar)* RootShare, const(wchar)* Comment, uint Flags);

///Deletes a stand-alone Distributed File System (DFS) namespace.
///Params:
///    ServerName = Pointer to a string that specifies the DFS root target server name of the stand-alone DFS namespace to be
///                 removed. This parameter is required.
///    RootShare = Pointer to a string that specifies the DFS root target share name of the stand-alone DFS namespace to be removed.
///                This parameter is required.
///    Flags = Must be zero.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsRemoveStdRoot(const(wchar)* ServerName, const(wchar)* RootShare, uint Flags);

///Creates a new domain-based Distributed File System (DFS) namespace. If the namespace already exists, the function
///adds the specified root target to it.
///Params:
///    ServerName = Pointer to a string that specifies the name of the server that will host the new DFS root target. This value
///                 cannot be an IP address. This parameter is required.
///    RootShare = Pointer to a string that specifies the name of the shared folder on the server that will host the new DFS root
///                target. This parameter is required.
///    FtDfsName = Pointer to a string that specifies the name of the new or existing domain-based DFS namespace. This parameter is
///                required. For compatibility reasons, it should specify the same string as the <i>RootShare</i> parameter.
///    Comment = Pointer to a string that contains an optional comment associated with the DFS namespace.
///    Flags = This parameter is reserved and must be zero.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsAddFtRoot(const(wchar)* ServerName, const(wchar)* RootShare, const(wchar)* FtDfsName, 
                     const(wchar)* Comment, uint Flags);

///Removes the specified root target from a domain-based Distributed File System (DFS) namespace. If the last root
///target of the DFS namespace is being removed, the function also deletes the DFS namespace. A DFS namespace can be
///deleted without first deleting all the links in it.
///Params:
///    ServerName = Pointer to a string that specifies the server name of the root target to be removed. The server must host the
///                 root of a domain-based DFS namespace. This parameter is required.
///    RootShare = Pointer to a string that specifies the name of the DFS root target share to be removed. This parameter is
///                required.
///    FtDfsName = Pointer to a string that specifies the name of the domain-based DFS namespace from which to remove the root
///                target. This parameter is required. Typically, it is the same as the <i>RootShare</i> parameter.
///    Flags = This parameter is reserved and must be zero.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsRemoveFtRoot(const(wchar)* ServerName, const(wchar)* RootShare, const(wchar)* FtDfsName, uint Flags);

///Removes the specified root target from a domain-based Distributed File System (DFS) namespace, even if the root
///target server is offline. If the last root target of the DFS namespace is being removed, the function also deletes
///the DFS namespace. A DFS namespace can be deleted without first deleting all the links in it. <div
///class="alert"><b>Note</b> The <b>NetDfsRemoveFtRootForced</b> function does not update the registry on the DFS root
///target server. For more information, see the Remarks section.</div><div> </div>
///Params:
///    DomainName = Pointer to a string that specifies the name of the Active Directory domain that contains the domain-based DFS
///                 namespace to be removed. This parameter is required.
///    ServerName = Pointer to a string that specifies the name of the DFS root target server to be removed. The server must host a
///                 root of the domain-based DFS namespace. This parameter is required.
///    RootShare = Pointer to a string that specifies the name of the DFS root target share to be removed. This parameter is
///                required.
///    FtDfsName = Pointer to a string that specifies the name of the domain-based DFS namespace from which to remove the root
///                target. This parameter is required. Typically, it is the same as the <i>RootShare</i> parameter.
///    Flags = Must be zero.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsRemoveFtRootForced(const(wchar)* DomainName, const(wchar)* ServerName, const(wchar)* RootShare, 
                              const(wchar)* FtDfsName, uint Flags);

///Removes a Distributed File System (DFS) link or a specific link target of a DFS link in a DFS namespace. When
///removing a specific link target, the link itself is removed if the last link target of the link is removed.
///Params:
///    DfsEntryPath = Pointer to a string that specifies the Universal Naming Convention (UNC) path of the DFS link. The string can be
///                   in one of two forms. The first form is as follows: &
///    ServerName = Pointer to a string that specifies the server name of the link target. For more information, see the following
///                 Remarks section. Set this parameter to <b>NULL</b> if the link and all link targets are to be removed.
///    ShareName = Pointer to a string that specifies the share name of the link target. Set this parameter to <b>NULL</b> if the
///                link and all link targets are to be removed.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsRemove(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName);

///Enumerates the Distributed File System (DFS) namespaces hosted on a server or DFS links of a namespace hosted by a
///server.
///Params:
///    DfsName = Pointer to a string that specifies the Universal Naming Convention (UNC) path of the DFS root or link. When you
///              specify information level 200 (DFS_INFO_200), this parameter is the name of a domain. When you specify
///              information level 300 (DFS_INFO_300), this parameter is the name of a server. For all other levels, the string
///              can be in one of the following four forms: <i>ServerName</i>&
///    Level = Specifies the information level of the request. This parameter can be one of the following values.
///    PrefMaxLen = Specifies the number of bytes that should be returned by this function in the information structure buffer. If
///                 this parameter is <b>MAX_PREFERRED_LENGTH</b>, the function allocates the amount of memory required for the data.
///                 For more information, see the following Remarks section. This parameter is ignored if you specify level 200 or
///                 level 300.
///    Buffer = Pointer to a buffer that receives the requested information structures. The format of this data depends on the
///             value of the <i>Level</i> parameter. This buffer is allocated by the system and must be freed using the
///             NetApiBufferFree function.
///    EntriesRead = Pointer to a value that receives the actual number of entries returned in the response.
///    ResumeHandle = Pointer to a value that contains a handle to be used for continuing an enumeration when more data is available
///                   than can be returned in a single call to this function. The handle should be zero on the first call and left
///                   unchanged for subsequent calls. For more information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If no more entries are available to be
///    enumerated, the return value is <b>ERROR_NO_MORE_ITEMS</b>. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsEnum(const(wchar)* DfsName, uint Level, uint PrefMaxLen, ubyte** Buffer, uint* EntriesRead, 
                uint* ResumeHandle);

///Retrieves information about a specified Distributed File System (DFS) root or link in a DFS namespace.
///Params:
///    DfsEntryPath = Pointer to a string that specifies the Universal Naming Convention (UNC) path of a DFS root or link. For a link,
///                   the string can be in one of two forms. The first form is as follows: &
///    ServerName = This parameter is currently ignored and should be <b>NULL</b>.
///    ShareName = This parameter is currently ignored and should be <b>NULL</b>.
///    Level = Specifies the information level of the request. This parameter can be one of the following values.
///    Buffer = Pointer to the address of a buffer that receives the requested information structures. The format of this data
///             depends on the value of the <i>Level</i> parameter. This buffer is allocated by the system and must be freed
///             using the NetApiBufferFree function. For more information, see Network Management Function Buffers and Network
///             Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsGetInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, 
                   ubyte** Buffer);

///Sets or modifies information about a specific Distributed File System (DFS) root, root target, link, or link target.
///Params:
///    DfsEntryPath = Pointer to a string that specifies the Universal Naming Convention (UNC) path of a DFS root or link. For a link,
///                   the string can be in one of two forms. The first form is as follows: &
///    ServerName = Pointer to a string that specifies the DFS link target server name. This parameter is optional. For more
///                 information, see the Remarks section.
///    ShareName = Pointer to a string that specifies the DFS link target share name. This may also be a share name with a path
///                relative to the share. For example, "share1\mydir1\mydir2". This parameter is optional. For more information, see
///                the Remarks section.
///    Level = Specifies the information level of the data. This parameter can be one of the following values.
///    Buffer = Pointer to a buffer that specifies the data. The format of this data depends on the value of the <i>Level</i>
///             parameter. For more information, see Network Management Function Buffers.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsSetInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, 
                   ubyte* Buffer);

///Retrieves information about a Distributed File System (DFS) root or link from the cache maintained by the DFS client.
///Params:
///    DfsEntryPath = Pointer to a string that specifies the Universal Naming Convention (UNC) path of a DFS root or link. For a link,
///                   the string can be in one of two forms. The first form is as follows: &
///    ServerName = Pointer to a string that specifies the name of the DFS root target or link target server. This parameter is
///                 optional.
///    ShareName = Pointer to a string that specifies the name of the share corresponding to the DFS root target or link target.
///                This parameter is optional.
///    Level = Specifies the information level of the request. This parameter can be one of the following values.
///    Buffer = Pointer to the address of a buffer that receives the requested information. This buffer is allocated by the
///             system and must be freed using the NetApiBufferFree function. For more information, see Network Management
///             Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsGetClientInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, 
                         ubyte** Buffer);

///Modifies information about a Distributed File System (DFS) root or link in the cache maintained by the DFS client.
///Params:
///    DfsEntryPath = Pointer to a string that specifies the Universal Naming Convention (UNC) path of a DFS root or link. For a link,
///                   the string can be in one of two forms. The first form is as follows: &
///    ServerName = Pointer to a string that specifies the DFS link target server name. This parameter is optional. For more
///                 information, see the Remarks section.
///    ShareName = Pointer to a string that specifies the DFS link target share name. This parameter is optional. For additional
///                information, see the following Remarks section.
///    Level = Specifies the information level of the request. This parameter can be one of the following values.
///    Buffer = Pointer to a buffer that contains the information to be set. The format of this information depends on the value
///             of the <i>Level</i> parameter. For more information, see Network Management Function Buffers.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsSetClientInfo(const(wchar)* DfsEntryPath, const(wchar)* ServerName, const(wchar)* ShareName, uint Level, 
                         ubyte* Buffer);

///Renames or moves a DFS link.
///Params:
///    OldDfsEntryPath = Pointer to a string that specifies the source path for the move operation. This value must be a DFS link or the
///                      path prefix of any DFS link in the DFS namespace.
///    NewDfsEntryPath = Pointer to a string that specifies the destination path for the move operation. This value must be a path or a
///                      DFS link in the same DFS namespace.
///    Flags = A set of flags that describe actions to take when moving the link.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsMove(const(wchar)* OldDfsEntryPath, const(wchar)* NewDfsEntryPath, uint Flags);

///Creates a domain-based or stand-alone DFS namespace or adds a new root target to an existing domain-based namespace.
///Params:
///    pDfsPath = Pointer to a string that specifies the Universal Naming Convention (UNC) path of a DFS namespace. For a
///               stand-alone DFS namespace, this string should be in the following format: &
///    pTargetPath = Pointer to a null-terminated Unicode string that specifies the UNC path of a DFS root target for the DFS
///                  namespace that is specified in the <i>pDfsPath</i> parameter. For a stand-alone DFS namespace, this parameter
///                  must be <b>NULL</b>. For a domain-based DFS namespace, the string should be in the following format: &
///    MajorVersion = Specifies the DFS metadata version for the namespace. <div class="alert"><b>Note</b> This parameter is only for
///                   use when creating a new namespace.</div> <div> </div> If a stand-alone DFS namespace is being created, this
///                   parameter must be set to 1. If a domain-based namespace is being created, this parameter should be set as
///                   follows: <ul> <li>Set it to 1 to specify Windows 2000 mode.</li> <li>Set it to 2 or higher to specify Windows
///                   Server 2008 mode.</li> </ul> If a new root target is being added to an existing domain-based DFS namespace, this
///                   parameter must be set to zero.
///    pComment = Pointer to a null-terminated Unicode string that contains a comment associated with the DFS root.
///    Flags = This parameter is reserved and must be zero.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the domain is not at the required
///    functional level for the specified <i>MajorVersion</i>, the return value is <b>ERROR_DS_INCOMPATIBLE</b>. This
///    return value applies only to domain roots and a <i>MajorVersion</i> of 2. If the function fails, the return value
///    is a system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsAddRootTarget(const(wchar)* pDfsPath, const(wchar)* pTargetPath, uint MajorVersion, 
                         const(wchar)* pComment, uint Flags);

///Removes a DFS root target from a domain-based DFS namespace. If the root target is the last root target in the DFS
///namespace, this function removes the DFS namespace. This function can also be used to remove a stand-alone DFS
///namespace.
///Params:
///    pDfsPath = Pointer to a string that specifies the Universal Naming Convention (UNC) path of a DFS namespace. For a
///               stand-alone DFS namespace, this string should be in the following form: &
///    pTargetPath = Pointer to a null-terminated Unicode string that specifies the UNC path of a DFS root target for the DFS
///                  namespace that is specified in the <i>pDfsPath</i> parameter. For a stand-alone DFS namespace, this parameter
///                  must be <b>NULL</b>. For a domain-based DFS namespace, the string should be in the following form: &
///    Flags = A flag that specifies the type of removal operation. For a stand-alone DFS namespace, this parameter must be
///            zero. For a domain-based DFS namespace, it can be zero or the following value. If it is zero, this indicates a
///            normal removal operation.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsRemoveRootTarget(const(wchar)* pDfsPath, const(wchar)* pTargetPath, uint Flags);

///Retrieves the security descriptor for the root object of the specified DFS namespace.
///Params:
///    DfsEntryPath = Pointer to a string that specifies the Universal Naming Convention (UNC) path of a DFS namespace root. The string
///                   can be in one of two forms. The first form is as follows: &
///    SecurityInformation = SECURITY_INFORMATION structure that contains bit flags that indicate the type of security information to retrieve
///                          from the root object.
///    ppSecurityDescriptor = Pointer to a list of SECURITY_DESCRIPTOR structures that contain the security items requested in the
///                           <i>SecurityInformation</i> parameter. <div class="alert"><b>Note</b> This buffer must be freed by calling the
///                           NetApiBufferFree function.</div> <div> </div>
///    lpcbSecurityDescriptor = The size of the buffer that <i>ppSecurityDescriptor</i> points to, in bytes.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsGetSecurity(const(wchar)* DfsEntryPath, uint SecurityInformation, void** ppSecurityDescriptor, 
                       uint* lpcbSecurityDescriptor);

///Sets the security descriptor for the root object of the specified DFS namespace.
///Params:
///    DfsEntryPath = Pointer to a string that specifies the Universal Naming Convention (UNC) path of a DFS namespace root. The string
///                   can be in one of two forms. The first form is as follows: &
///    SecurityInformation = SECURITY_INFORMATION structure that contains bit flags that indicate the type of security information to set on
///                          the root object.
///    pSecurityDescriptor = SECURITY_DESCRIPTOR structure that contains the security descriptor to set as specified in the
///                          <i>SecurityInformation</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsSetSecurity(const(wchar)* DfsEntryPath, uint SecurityInformation, void* pSecurityDescriptor);

///Retrieves the security descriptor for the container object of the specified stand-alone DFS namespace.
///Params:
///    MachineName = Pointer to a string that specifies the name of the server that hosts the stand-alone DFS namespace.
///    SecurityInformation = SECURITY_INFORMATION structure that contains bit flags that indicate the type of security information to
///                          retrieve.
///    ppSecurityDescriptor = Pointer to a list of SECURITY_DESCRIPTOR structures that contain the security items requested in the
///                           <i>SecurityInformation</i> parameter. <div class="alert"><b>Note</b> This buffer must be freed by calling the
///                           NetApiBufferFree function.</div> <div> </div>
///    lpcbSecurityDescriptor = The size of the buffer that <i>ppSecurityDescriptor</i> points to, in bytes.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsGetStdContainerSecurity(const(wchar)* MachineName, uint SecurityInformation, 
                                   void** ppSecurityDescriptor, uint* lpcbSecurityDescriptor);

///Sets the security descriptor for the container object of the specified stand-alone DFS namespace.
///Params:
///    MachineName = The name of the stand-alone DFS root's host machine. Pointer to a string that specifies the name of the server
///                  that hosts the stand-alone DFS namespace.
///    SecurityInformation = SECURITY_INFORMATION structure that contains bit flags that indicate the type of security information to set on
///                          the root object.
///    pSecurityDescriptor = Pointer to a SECURITY_DESCRIPTOR structure that contains the security attributes to set as specified in the
///                          <i>SecurityInformation</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsSetStdContainerSecurity(const(wchar)* MachineName, uint SecurityInformation, void* pSecurityDescriptor);

///Retrieves the security descriptor of the container object for the domain-based DFS namespaces in the specified Active
///Directory domain.
///Params:
///    DomainName = Pointer to a string that specifies the Active Directory domain name.
///    SecurityInformation = SECURITY_INFORMATION structure that contains bit flags that indicate the type of security information to
///                          retrieve.
///    ppSecurityDescriptor = Pointer to a list SECURITY_DESCRIPTOR structures that contain the security items requested in the
///                           <i>SecurityInformation</i> parameter. <div class="alert"><b>Note</b> This buffer must be freed by calling the
///                           NetApiBufferFree function.</div> <div> </div>
///    lpcbSecurityDescriptor = The size of <i>ppSecurityDescriptor</i>, in bytes.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsGetFtContainerSecurity(const(wchar)* DomainName, uint SecurityInformation, void** ppSecurityDescriptor, 
                                  uint* lpcbSecurityDescriptor);

///Sets the security descriptor of the container object for the domain-based DFS namespaces in the specified Active
///Directory domain.
///Params:
///    DomainName = Pointer to a string that specifies the Active Directory domain name.
///    SecurityInformation = SECURITY_INFORMATION structure that contains bit flags that indicate the type of security information to set.
///    pSecurityDescriptor = Pointer to a SECURITY_DESCRIPTOR structure that contains the security attributes to set as specified in the
///                          <i>SecurityInformation</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsSetFtContainerSecurity(const(wchar)* DomainName, uint SecurityInformation, void* pSecurityDescriptor);

///Determines the supported metadata version number.
///Params:
///    Origin = A DFS_NAMESPACE_VERSION_ORIGIN enumeration value that specifies the origin of the DFS namespace version.
///    pName = A string that specifies the server name or domain name. If the value of the <i>Origin</i> parameter is
///            <b>DFS_NAMESPACE_VERSION_ORIGIN_DOMAIN</b>, this string must be an AD DS domain name. Otherwise, it must be a
///            server name. This parameter is required and cannot be <b>NULL</b>.
///    ppVersionInfo = A pointer to a DFS_SUPPORTED_NAMESPACE_VERSION_INFO structure that receives the DFS metadata version number.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("dfscli")
uint NetDfsGetSupportedNamespaceVersion(DFS_NAMESPACE_VERSION_ORIGIN Origin, const(wchar)* pName, 
                                        DFS_SUPPORTED_NAMESPACE_VERSION_INFO** ppVersionInfo);


