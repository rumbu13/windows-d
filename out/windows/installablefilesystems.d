// Written in the D programming language.

module windows.installablefilesystems;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : HANDLE, NTSTATUS, OVERLAPPED, SECURITY_ATTRIBUTES;

extern(Windows):


// Enums


alias FLT_FILESYSTEM_TYPE = int;
enum : int
{
    FLT_FSTYPE_UNKNOWN    = 0x00000000,
    FLT_FSTYPE_RAW        = 0x00000001,
    FLT_FSTYPE_NTFS       = 0x00000002,
    FLT_FSTYPE_FAT        = 0x00000003,
    FLT_FSTYPE_CDFS       = 0x00000004,
    FLT_FSTYPE_UDFS       = 0x00000005,
    FLT_FSTYPE_LANMAN     = 0x00000006,
    FLT_FSTYPE_WEBDAV     = 0x00000007,
    FLT_FSTYPE_RDPDR      = 0x00000008,
    FLT_FSTYPE_NFS        = 0x00000009,
    FLT_FSTYPE_MS_NETWARE = 0x0000000a,
    FLT_FSTYPE_NETWARE    = 0x0000000b,
    FLT_FSTYPE_BSUDF      = 0x0000000c,
    FLT_FSTYPE_MUP        = 0x0000000d,
    FLT_FSTYPE_RSFX       = 0x0000000e,
    FLT_FSTYPE_ROXIO_UDF1 = 0x0000000f,
    FLT_FSTYPE_ROXIO_UDF2 = 0x00000010,
    FLT_FSTYPE_ROXIO_UDF3 = 0x00000011,
    FLT_FSTYPE_TACIT      = 0x00000012,
    FLT_FSTYPE_FS_REC     = 0x00000013,
    FLT_FSTYPE_INCD       = 0x00000014,
    FLT_FSTYPE_INCD_FAT   = 0x00000015,
    FLT_FSTYPE_EXFAT      = 0x00000016,
    FLT_FSTYPE_PSFS       = 0x00000017,
    FLT_FSTYPE_GPFS       = 0x00000018,
    FLT_FSTYPE_NPFS       = 0x00000019,
    FLT_FSTYPE_MSFS       = 0x0000001a,
    FLT_FSTYPE_CSVFS      = 0x0000001b,
    FLT_FSTYPE_REFS       = 0x0000001c,
    FLT_FSTYPE_OPENAFS    = 0x0000001d,
    FLT_FSTYPE_CIMFS      = 0x0000001e,
}

alias FILTER_INFORMATION_CLASS = int;
enum : int
{
    FilterFullInformation              = 0x00000000,
    FilterAggregateBasicInformation    = 0x00000001,
    FilterAggregateStandardInformation = 0x00000002,
}

alias FILTER_VOLUME_INFORMATION_CLASS = int;
enum : int
{
    FilterVolumeBasicInformation    = 0x00000000,
    FilterVolumeStandardInformation = 0x00000001,
}

alias INSTANCE_INFORMATION_CLASS = int;
enum : int
{
    InstanceBasicInformation             = 0x00000000,
    InstancePartialInformation           = 0x00000001,
    InstanceFullInformation              = 0x00000002,
    InstanceAggregateStandardInformation = 0x00000003,
}

// Structs


struct FILTER_FULL_INFORMATION
{
    uint      NextEntryOffset;
    uint      FrameID;
    uint      NumberOfInstances;
    ushort    FilterNameLength;
    ushort[1] FilterNameBuffer;
}

struct FILTER_AGGREGATE_BASIC_INFORMATION
{
    uint NextEntryOffset;
    uint Flags;
    union Type
    {
        struct MiniFilter
        {
            uint   FrameID;
            uint   NumberOfInstances;
            ushort FilterNameLength;
            ushort FilterNameBufferOffset;
            ushort FilterAltitudeLength;
            ushort FilterAltitudeBufferOffset;
        }
        struct LegacyFilter
        {
            ushort FilterNameLength;
            ushort FilterNameBufferOffset;
        }
    }
}

struct FILTER_AGGREGATE_STANDARD_INFORMATION
{
    uint NextEntryOffset;
    uint Flags;
    union Type
    {
        struct MiniFilter
        {
            uint   Flags;
            uint   FrameID;
            uint   NumberOfInstances;
            ushort FilterNameLength;
            ushort FilterNameBufferOffset;
            ushort FilterAltitudeLength;
            ushort FilterAltitudeBufferOffset;
        }
        struct LegacyFilter
        {
            uint   Flags;
            ushort FilterNameLength;
            ushort FilterNameBufferOffset;
            ushort FilterAltitudeLength;
            ushort FilterAltitudeBufferOffset;
        }
    }
}

struct FILTER_VOLUME_BASIC_INFORMATION
{
    ushort    FilterVolumeNameLength;
    ushort[1] FilterVolumeName;
}

struct FILTER_VOLUME_STANDARD_INFORMATION
{
    uint                NextEntryOffset;
    uint                Flags;
    uint                FrameID;
    FLT_FILESYSTEM_TYPE FileSystemType;
    ushort              FilterVolumeNameLength;
    ushort[1]           FilterVolumeName;
}

struct INSTANCE_BASIC_INFORMATION
{
    uint   NextEntryOffset;
    ushort InstanceNameLength;
    ushort InstanceNameBufferOffset;
}

struct INSTANCE_PARTIAL_INFORMATION
{
    uint   NextEntryOffset;
    ushort InstanceNameLength;
    ushort InstanceNameBufferOffset;
    ushort AltitudeLength;
    ushort AltitudeBufferOffset;
}

struct INSTANCE_FULL_INFORMATION
{
    uint   NextEntryOffset;
    ushort InstanceNameLength;
    ushort InstanceNameBufferOffset;
    ushort AltitudeLength;
    ushort AltitudeBufferOffset;
    ushort VolumeNameLength;
    ushort VolumeNameBufferOffset;
    ushort FilterNameLength;
    ushort FilterNameBufferOffset;
}

struct INSTANCE_AGGREGATE_STANDARD_INFORMATION
{
    uint NextEntryOffset;
    uint Flags;
    union Type
    {
        struct MiniFilter
        {
            uint                Flags;
            uint                FrameID;
            FLT_FILESYSTEM_TYPE VolumeFileSystemType;
            ushort              InstanceNameLength;
            ushort              InstanceNameBufferOffset;
            ushort              AltitudeLength;
            ushort              AltitudeBufferOffset;
            ushort              VolumeNameLength;
            ushort              VolumeNameBufferOffset;
            ushort              FilterNameLength;
            ushort              FilterNameBufferOffset;
            uint                SupportedFeatures;
        }
        struct LegacyFilter
        {
            uint   Flags;
            ushort AltitudeLength;
            ushort AltitudeBufferOffset;
            ushort VolumeNameLength;
            ushort VolumeNameBufferOffset;
            ushort FilterNameLength;
            ushort FilterNameBufferOffset;
            uint   SupportedFeatures;
        }
    }
}

struct FILTER_MESSAGE_HEADER
{
    uint  ReplyLength;
    ulong MessageId;
}

struct FILTER_REPLY_HEADER
{
    NTSTATUS Status;
    ulong    MessageId;
}

alias FilterFindHandle = ptrdiff_t;

alias FilterInstanceFindHandle = ptrdiff_t;

alias FilterVolumeFindHandle = ptrdiff_t;

alias FilterVolumeInstanceFindHandle = ptrdiff_t;

alias HFILTER = ptrdiff_t;

alias HFILTER_INSTANCE = ptrdiff_t;

// Functions

///The <b>FilterLoad</b> function dynamically loads a minifilter driver into the system.
///Params:
///    lpFilterName = Pointer to a null-terminated wide-character string that specifies the service name of the minifilter driver. This
///                   parameter is required and cannot be <b>NULL</b> or an empty string.
///Returns:
///    <b>FilterLoad</b> returns S_OK if successful. Otherwise, it returns one of the following error values: <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>HRESULT_FROM_WIN32
///    (ERROR_ALREADY_EXISTS)</b></b></dt> </dl> </td> <td width="60%"> The minifilter driver is already running. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>HRESULT_FROM_WIN32 (ERROR_FILE_NOT_FOUND)</b></b></dt> </dl> </td> <td
///    width="60%"> No matching minifilter driver was found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>HRESULT_FROM_WIN32 (ERROR_SERVICE_ALREADY_RUNNING)</b></b></dt> </dl> </td> <td width="60%"> The
///    minifilter driver is already running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>HRESULT_FROM_WIN32
///    (ERROR_BAD_EXE_FORMAT)</b></b></dt> </dl> </td> <td width="60%"> The load image for the minifilter driver
///    specified by <i>lpFilterName</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>HRESULT_FROM_WIN32
///    (ERROR_BAD_DRIVER)</b></b></dt> </dl> </td> <td width="60%"> The load image for the minifilter driver specified
///    by <i>lpFilterName</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>HRESULT_FROM_WIN32
///    (ERROR_INVALID_IMAGE_HASH)</b></b></dt> </dl> </td> <td width="60%"> The minifilter driver has an invalid digital
///    signature. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterLoad(const(wchar)* lpFilterName);

///An application that has loaded a supporting minifilter by calling FilterLoad can unload the minifilter by calling the
///<b>FilterUnload</b> function.
///Params:
///    lpFilterName = Pointer to a null-terminated wide-character string containing the same minifilter name that was passed to
///                   FilterLoad. This parameter is required and cannot be <b>NULL</b> or an empty string.
///Returns:
///    <b>FilterUnload</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterUnload(const(wchar)* lpFilterName);

///The <b>FilterCreate</b> function creates a handle for the given minifilter.
///Params:
///    lpFilterName = Pointer to a null-terminated wide-character string containing the name of the minifilter. This parameter is
///                   required and cannot be <b>NULL</b>.
///    hFilter = Pointer to a caller-allocated variable that receives a handle for the minifilter if the call to
///              <b>FilterCreate</b> succeeds; otherwise, it receives INVALID_HANDLE_VALUE.
///Returns:
///    <b>FilterCreate</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterCreate(const(wchar)* lpFilterName, HFILTER* hFilter);

///The <b>FilterClose</b> function closes an open minifilter handle.
///Params:
///    hFilter = Minifilter handle returned by a previous call to FilterCreate.
///Returns:
///    <b>FilterClose</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterClose(HFILTER hFilter);

///The <b>FilterInstanceCreate</b> function creates a handle that can be used to communicate with the given minifilter
///instance.
///Params:
///    lpFilterName = Pointer to a null-terminated wide-character string containing the name of the minifilter that owns the instance.
///    lpVolumeName = Pointer to a null-terminated wide-character string containing the name of the volume that the instance is
///                   attached to. The <i>lpVolumeName</i> input string can be any of the following. The trailing backslash (\\) is
///                   optional. <ul> <li> A drive letter, such as "D:\" </li> <li> A path to a volume mount point, such as
///                   "c:\mnt\edrive\" </li> <li> A unique volume identifier (also called a <i>volume GUID name</i>), such as
///                   "\??\Volume{7603f260-142a-11d4-ac67-806d6172696f}\" </li> <li> A nonpersistent device name (also called a
///                   <i>target name</i> or an <i>NT device name</i>), such as "\Device\HarddiskVolume1\" </li> </ul>
///    lpInstanceName = Pointer to a null-terminated wide-character string containing the instance name for the instance. This parameter
///                     is optional and can be <b>NULL</b>. If it is <b>NULL</b>, the first instance found for this minifilter on this
///                     volume is returned.
///    hInstance = Pointer to a caller-allocated variable that receives an opaque handle for the minifilter instance if the call to
///                <b>FilterInstanceCreate</b> succeeds; otherwise, it receives INVALID_HANDLE_VALUE.
///Returns:
///    <b>FilterInstanceCreate</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterInstanceCreate(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpInstanceName, 
                             HFILTER_INSTANCE* hInstance);

///The <b>FilterInstanceClose</b> function closes a minifilter instance handle opened by <b>FilterInstanceCreate</b>.
///Params:
///    hInstance = Minifilter instance handle returned by a previous call to FilterInstanceCreate.
///Returns:
///    <b>FilterInstanceClose</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterInstanceClose(HFILTER_INSTANCE hInstance);

///The <b>FilterAttach</b> function attaches a new minifilter instance to the given volume.
///Params:
///    lpFilterName = Pointer to a null-terminated wide-character string containing the name of the minifilter for which an instance is
///                   to be created. This parameter is required and cannot be <b>NULL</b>.
///    lpVolumeName = Pointer to a null-terminated wide-character string containing the name of the volume to which the newly created
///                   instance is to be attached. The <i>lpVolumeName</i> input string can be any of the following. The trailing
///                   backslash (\\) is optional. <ul> <li> A drive letter, such as "D:\" </li> <li> A path to a volume mount point,
///                   such as "c:\mnt\edrive\" </li> <li> A unique volume identifier (also called a <i>volume GUID name</i>), such as
///                   "\??\Volume{7603f260-142a-11d4-ac67-806d6172696f}\" </li> <li> A nonpersistent device name (also called a
///                   <i>target name</i> or an <i>NT device name</i>), such as "\Device\HarddiskVolume1\" </li> </ul> The
///                   <i>lpVolumeName</i> parameter is required and cannot be <b>NULL</b>.
///    lpInstanceName = Pointer to a null-terminated wide-character string containing the instance name for the new instance. This
///                     parameter is optional and can be <b>NULL</b>. If this parameter is <b>NULL</b>, the new instance receives the
///                     minifilter's default instance name as described in the Remarks section for FltAttachVolume.
///    dwCreatedInstanceNameLength = Length, in bytes, of the buffer that <i>lpCreatedInstanceName </i>points to. This parameter is optional and can
///                                  be zero.
///    lpCreatedInstanceName = Pointer to a caller-allocated variable that receives the instance name for the new instance if the instance is
///                            successfully attached to the volume. This parameter is optional and can be <b>NULL</b>. If it is not <b>NULL</b>,
///                            the buffer must be large enough to hold INSTANCE_NAME_MAX_CHARS characters plus a NULL terminator.
///Returns:
///    <b>FilterAttach</b> returns S_OK if successful. Otherwise, it returns an error value such as one of the
///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FLT_INSTANCE_ALTITUDE_COLLISION</b></dt> </dl> </td> <td width="60%"> An instance already exists at
///    this altitude on the volume specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FLT_INSTANCE_NAME_COLLISION</b></dt> </dl> </td> <td width="60%"> An instance already exists with
///    this name on the volume specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> If <i>lpInstanceName</i> is non-<b>NULL</b>, <i>lpInstanceName</i> does not match a
///    registered filter instance name in the registry. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterAttach(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpInstanceName, 
                     uint dwCreatedInstanceNameLength, const(wchar)* lpCreatedInstanceName);

///The <b>FilterAttachAtAltitude</b> function is a debugging support function that attaches a new minifilter instance to
///a volume at a specified altitude, overriding any settings in the minifilter's setup information (INF) file.
///Params:
///    lpFilterName = Pointer to a null-terminated wide-character string containing the name of the minifilter for which an instance is
///                   to be created. This parameter is required and cannot be <b>NULL</b>.
///    lpVolumeName = Pointer to a null-terminated wide-character string containing the name of the volume to which the newly created
///                   instance is to be attached. The <i>lpVolumeName</i> input string can be any of the following. The trailing
///                   backslash (\\) is optional. <ul> <li> A drive letter, such as "D:\" </li> <li> A path to a volume mount point,
///                   such as "c:\mnt\edrive\" </li> <li> A unique volume identifier (also called a <i>volume GUID name</i>), such as
///                   "\??\Volume{7603f260-142a-11d4-ac67-806d6172696f}\" </li> <li> A nonpersistent device name (also called a
///                   <i>target name</i> or an <i>NT device name</i>), such as "\Device\HarddiskVolume1\" </li> </ul> This parameter is
///                   required and cannot be <b>NULL</b>.
///    lpAltitude = Pointer to a null-terminated wide-character string that contains a numeric value specifying the target position
///                 that the minifilter instance should occupy in the stack for the volume. The higher the number, the higher the
///                 relative position in the stack. An altitude string consists of one or more digits in the range from 0 through 9,
///                 and it can include a single decimal point. The decimal point is optional. For example, "100.123456" is a valid
///                 altitude string. This parameter is required and cannot be <b>NULL</b>.
///    lpInstanceName = Pointer to a null-terminated wide-character string containing the instance name for the new instance. This
///                     parameter is optional and can be <b>NULL</b>. If this parameter is <b>NULL</b>, the new instance receives the
///                     minifilter's default instance name as described in the Remarks section for FltAttachVolume.
///    dwCreatedInstanceNameLength = Length, in bytes, of the buffer that <i>lpCreatedInstanceName </i>points to. This parameter is optional and can
///                                  be zero.
///    lpCreatedInstanceName = Pointer to a caller-allocated variable that receives the instance name for the new instance if the instance is
///                            successfully attached to the volume. This parameter is optional and can be <b>NULL</b>. If it is not <b>NULL</b>,
///                            the buffer must be large enough to hold INSTANCE_NAME_MAX_CHARS characters plus a NULL terminator.
///Returns:
///    <b>FilterAttachAtAltitude</b> returns S_OK if successful. Otherwise, it returns an error value such as one of the
///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FLT_INSTANCE_ALTITUDE_COLLISION</b></dt> </dl> </td> <td width="60%"> An instance already exists at
///    this altitude on the volume specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FLT_INSTANCE_NAME_COLLISION</b></dt> </dl> </td> <td width="60%"> An instance already exists with
///    this name on the volume specified. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterAttachAtAltitude(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpAltitude, 
                               const(wchar)* lpInstanceName, uint dwCreatedInstanceNameLength, 
                               const(wchar)* lpCreatedInstanceName);

///The <b>FilterDetach</b> function detaches the given minifilter instance from the given volume.
///Params:
///    lpFilterName = Pointer to a null-terminated wide-character string containing the name of the minifilter whose instance is to be
///                   detached from the stack. This parameter is required and cannot be <b>NULL</b>.
///    lpVolumeName = Pointer to a null-terminated wide-character string containing the name of the volume to which the instance is
///                   currently attached. The <i>lpVolumeName</i> input string can be any of the following. The trailing backslash (\\)
///                   is optional. <ul> <li> A drive letter, such as "D:\" </li> <li> A path to a volume mount point, such as
///                   "c:\mnt\edrive\" </li> <li> A unique volume identifier (also called a <i>volume GUID name</i>), such as
///                   "\??\Volume{7603f260-142a-11d4-ac67-806d6172696f}\" </li> <li> A nonpersistent device name (also called a
///                   <i>target name</i> or an <i>NT device name</i>), such as "\Device\HarddiskVolume1\" </li> </ul> This parameter is
///                   required and cannot be <b>NULL</b>.
///    lpInstanceName = Pointer to a null-terminated wide-character string containing the instance name for the instance to be removed.
///                     This parameter is optional and can be <b>NULL</b>. If it is <b>NULL</b>, the highest matching instance is
///                     removed.
///Returns:
///    <b>FilterDetach</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterDetach(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpInstanceName);

///The <b>FilterFindFirst</b> function returns information about a filter driver (minifilter driver instance or legacy
///filter driver) and is used to begin scanning the filters in the global list of registered filters.
///Params:
///    dwInformationClass = Type of filter driver information requested. This parameter must be one of the following values. <table> <tr>
///                         <th>Value</th> <th>Meaning</th> </tr> <tr> <td> <b>FilterFullInformation</b> </td> <td> The buffer pointed to by
///                         the <i>lpBuffer</i> parameter receives a FILTER_FULL_INFORMATION structure for each minifilter instance. Legacy
///                         filters are ignored. </td> </tr> <tr> <td> <b>FilterAggregateBasicInformation</b> </td> <td> The buffer pointed
///                         to by the <i>lpBuffer</i> parameter receives a FILTER_AGGREGATE_BASIC_INFORMATION structure for each minifilter
///                         instance or legacy filter. This <i>dwInformationClass</i> value is available starting with Windows Server 2003
///                         with SP1 and Windows XP with SP2 with filter manager rollup. For more information about the filter manager rollup
///                         package for Windows XP with SP2, see article 914882, " The filter manager rollup package for Windows XP SP2," in
///                         the Microsoft Knowledge Base. </td> </tr> <tr> <td> <b>FilterAggregateStandardInformation</b> </td> <td> The
///                         buffer pointed to by the <i>lpBuffer</i> parameter receives a FILTER_AGGREGATE_STANDARD_INFORMATION structure for
///                         each minifilter instance or legacy filter. This <i>dwInformationClass</i> value is available starting with
///                         Windows Vista. </td> </tr> </table>
///    lpBuffer = Pointer to a caller-allocated buffer that receives the requested information. The type of the information
///               returned in the buffer is defined by the <i>dwInformationClass</i> parameter.
///    dwBufferSize = Size, in bytes, of the buffer that the <i>lpBuffer</i> parameter points to. The caller should set this parameter
///                   according to the given <i>dwInformationClass</i>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpBuffer</i> points to if the call to <b>FilterFindFirst</b> succeeds. This parameter is required and cannot
///                      be <b>NULL</b>.
///    lpFilterFind = Pointer to a caller-allocated variable that receives a search handle for the filter driver if the call to
///                   <b>FilterFindFirst</b> succeeds; otherwise, it receives INVALID_HANDLE_VALUE. This search handle can be used in
///                   subsequent calls to FilterFindNext and FilterFindClose.
///Returns:
///    <b>FilterFindFirst</b> returns S_OK if successful. Otherwise, it returns an HRESULT error value, such as one of
///    the following: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer pointed to
///    by <i>lpBuffer</i> is not large enough to contain the requested information. When this value is returned,
///    <i>lpBytesReturned</i> will contain the size, in bytes, of the buffer required for the given
///    <i>dwInformationClass</i> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</b></dt> </dl> </td> <td width="60%"> An invalid value was
///    specified for the <i>dwInformationClass</i> parameter. For example, if <i>FilterAggregateStandardInformation</i>
///    is specified for an operating system prior to Windows Vista, <b>FilterFindFirst</b> returns this HRESULT value.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NO_MORE_ITEMS)</b></dt> </dl> </td> <td
///    width="60%"> A filter driver was not found in the global list of registered filters. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterFindFirst(FILTER_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, 
                        uint* lpBytesReturned, FilterFindHandle* lpFilterFind);

///The <b>FilterFindNext</b> function continues a filter search started by a call to FilterFindFirst.
///Params:
///    hFilterFind = Filter search handle returned by a previous call to FilterFindFirst.
///    dwInformationClass = Type of information requested. This parameter must be one of the following values. <table> <tr> <th>Value</th>
///                         <th>Meaning</th> </tr> <tr> <td> <b>FilterFullInformation</b> </td> <td> The buffer pointed to by the
///                         <i>lpBuffer</i> parameter receives a FILTER_FULL_INFORMATION structure for each minifilter instance. Legacy
///                         filters are ignored. </td> </tr> <tr> <td> <b>FilterAggregateBasicInformation</b> </td> <td> The buffer pointed
///                         to by the <i>lpBuffer</i> parameter receives a FILTER_AGGREGATE_BASIC_INFORMATION structure for each minifilter
///                         instance or legacy filter. This <i>dwInformationClass</i> value is available starting with Microsoft Windows
///                         Server 2003 with SP1 and Windows XP with SP2 with filter manager rollup. For more information about the filter
///                         manager rollup package for Windows XP with SP2, see article 914882, " The filter manager rollup package for
///                         Windows XP SP2," in the Microsoft Knowledge Base. </td> </tr> <tr> <td> <b>FilterAggregateStandardInformation</b>
///                         </td> <td> The buffer pointed to by the <i>lpBuffer</i> parameter receives a
///                         FILTER_AGGREGATE_STANDARD_INFORMATION structure for each minifilter instance or legacy filter. This
///                         <i>dwInformationClass</i> value is available starting with Windows Vista. </td> </tr> </table>
///    lpBuffer = Pointer to a caller-allocated buffer that receives the requested information. The type of the information
///               returned is defined by the <i>dwInformationClass</i> parameter.
///    dwBufferSize = Size, in bytes, of the buffer that the <i>lpBuffer</i> parameter points to. The caller should set this parameter
///                   according to the given <i>dwInformationClass</i>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpBuffer</i> points to if the call to <b>FilterFindNext</b> succeeds. This parameter is required and cannot be
///                      <b>NULL</b>.
///Returns:
///    <b>FilterFindNext</b> returns S_OK if successful. Otherwise, it returns an HRESULT error value, such as one of
///    the following: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer pointed to
///    by <i>lpBuffer</i> is not large enough to contain the requested information. When this value is returned,
///    <i>lpBytesReturned</i> will contain the size, in bytes, of the buffer required for the given
///    <i>dwInformationClass</i> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</b></dt> </dl> </td> <td width="60%"> An invalid value was
///    specified for the <i>dwInformationClass</i> parameter. For example, if <b>FilterAggregateStandardInformation</b>
///    is specified for an operating system prior to Windows Vista, <b>FilterFindNext</b> returns this HRESULT value.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NO_MORE_ITEMS)</b></dt> </dl> </td> <td
///    width="60%"> No more filter drivers were found in the global list of registered filter drivers. </td> </tr>
///    </table>
///    
@DllImport("FLTLIB")
HRESULT FilterFindNext(HANDLE hFilterFind, FILTER_INFORMATION_CLASS dwInformationClass, char* lpBuffer, 
                       uint dwBufferSize, uint* lpBytesReturned);

///The <b>FilterFindClose</b> function closes the specified minifilter search handle. The FilterFindFirst and
///FilterFindNext functions use this search handle to locate minifilters.
///Params:
///    hFilterFind = Minifilter search handle to close. This handle must have been opened by a previous call to FilterFindFirst.
///Returns:
///    <b>FilterFindClose</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterFindClose(HANDLE hFilterFind);

///The <b>FilterVolumeFindFirst</b> function returns information about a volume.
///Params:
///    dwInformationClass = Type of requested information. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                         <th>Meaning</th> </tr> <tr> <td> <b>FilterVolumeBasicInformation</b> </td> <td> The buffer pointed to by the
///                         <i>lpBuffer</i> parameter receives a FILTER_VOLUME_BASIC_INFORMATION structure for the volume. </td> </tr> <tr>
///                         <td> <b>FilterVolumeStandardInformation</b> </td> <td> The buffer pointed to by the <i>lpBuffer</i> parameter
///                         receives a FILTER_VOLUME_STANDARD_INFORMATION structure for the volume. This structure is available starting with
///                         Windows Vista. </td> </tr> </table>
///    lpBuffer = Pointer to a caller-allocated buffer that receives the requested information. The type of the information
///               returned in the buffer is defined by the <i>dwInformationClass</i> parameter.
///    dwBufferSize = Size, in bytes, of the buffer that the <i>lpBuffer</i> parameter points to. The caller should set this parameter
///                   according to the given <i>dwInformationClass</i>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpBuffer</i> points to if the call to <b>FilterVolumeFindFirst</b> succeeds. This parameter is required and
///                      cannot be <b>NULL</b>.
///    lpVolumeFind = Pointer to a caller-allocated variable that receives a search handle for the minifilter if the call to
///                   <b>FilterVolumeFindFirst</b> succeeds; otherwise, it receives INVALID_HANDLE_VALUE. This search handle can be
///                   used in subsequent calls to FilterVolumeFindNext and FilterVolumeFindClose.
///Returns:
///    <b>FilterVolumeFindFirst</b> returns S_OK if it successfully returns information about a volume. Otherwise, it
///    returns an HRESULT error value, such as one of the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer pointed to
///    by <i>lpBuffer</i> is not large enough to contain the requested information. When this value is returned,
///    <i>lpBytesReturned</i> will contain the size, in bytes, of the buffer required for the given
///    <i>dwInformationClass</i> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</b></dt> </dl> </td> <td width="60%"> An invalid value was
///    specified for the <i>dwInformationClass</i> parameter. For example, if <b>FilterVolumeStandardInformation</b> is
///    specified for an operating system prior to Windows Vista, <b>FilterVolumeFindFirst</b> returns this HRESULT
///    value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NO_MORE_ITEMS)</b></dt> </dl> </td>
///    <td width="60%"> A volume was not found in the list of volumes known to the filter manager. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterVolumeFindFirst(FILTER_VOLUME_INFORMATION_CLASS dwInformationClass, char* lpBuffer, 
                              uint dwBufferSize, uint* lpBytesReturned, FilterVolumeFindHandle* lpVolumeFind);

///The <b>FilterVolumeFindNext</b> function continues a volume search started by a call to FilterVolumeFindFirst.
///Params:
///    hVolumeFind = Volume search handle returned by a previous call to FilterVolumeFindFirst.
///    dwInformationClass = Type of information requested. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                         <th>Meaning</th> </tr> <tr> <td> <b>FilterVolumeBasicInformation</b> </td> <td> The buffer pointed to by the
///                         <i>lpBuffer</i> parameter receives a FILTER_VOLUME_BASIC_INFORMATION structure for the volume. </td> </tr> <tr>
///                         <td> <b>FilterVolumeStandardInformation</b> </td> <td> The buffer pointed to by the <i>lpBuffer</i> parameter
///                         receives a FILTER_VOLUME_STANDARD_INFORMATION structure for the volume. This structure is available starting with
///                         Windows Vista. </td> </tr> </table>
///    lpBuffer = Pointer to a caller-allocated buffer that receives the requested information. The type of the information
///               returned in the buffer is defined by the <i>dwInformationClass</i> parameter.
///    dwBufferSize = Size, in bytes, of the buffer that the <i>lpBuffer</i> parameter points to. The caller should set this parameter
///                   according to the given <i>dwInformationClass</i>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpBuffer</i> points to if the call to <b>FilterVolumeFindNext</b> succeeds. This parameter is required and
///                      cannot be <b>NULL</b>.
///Returns:
///    <b>FilterVolumeFindNext</b> returns S_OK if it successfully returns volume information. Otherwise, it returns an
///    HRESULT error value, such as one of the following: <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td
///    width="60%"> The buffer pointed to by <i>lpBuffer</i> is not large enough to contain the requested information.
///    When this value is returned, <i>lpBytesReturned</i> will contain the size, in bytes, of the buffer required for
///    the given <i>dwInformationClass</i> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</b></dt> </dl> </td> <td width="60%"> An invalid value was
///    specified for the <i>dwInformationClass</i> parameter. For example, if <b>FilterVolumeStandardInformation</b> is
///    specified for an operating system prior to Windows Vista, <b>FilterVolumeFindNext</b> returns this HRESULT value.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NO_MORE_ITEMS)</b></dt> </dl> </td> <td
///    width="60%"> No more volumes were found in the list of volumes known to the filter manager. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterVolumeFindNext(HANDLE hVolumeFind, FILTER_VOLUME_INFORMATION_CLASS dwInformationClass, 
                             char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

///The <b>FilterVolumeFindClose</b> function closes the specified volume search handle. FilterVolumeFindFirst and
///FilterVolumeFindNext use this search handle to locate volumes.
///Params:
///    hVolumeFind = Volume search handle to close. This handle must have been previously opened by FilterVolumeFindFirst.
///Returns:
///    <b>FilterVolumeFindClose</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterVolumeFindClose(HANDLE hVolumeFind);

///The <b>FilterInstanceFindFirst</b> function returns information about a minifilter driver instance and is used as a
///starting point for scanning the instances of a minifilter.
///Params:
///    lpFilterName = Pointer to a null-terminated wide-character string that contains the name of the minifilter driver that owns the
///                   instance.
///    dwInformationClass = The type of instance information structure returned. This parameter must be one of the following values. <table>
///                         <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> <b>InstanceBasicInformation</b> </td> <td> Return an
///                         INSTANCE_BASIC_INFORMATION structure for the instance. </td> </tr> <tr> <td> <b>InstanceFullInformation</b> </td>
///                         <td> Return an INSTANCE_FULL_INFORMATION structure for the instance. </td> </tr> <tr> <td>
///                         <b>InstancePartialInformation</b> </td> <td> Return an INSTANCE_PARTIAL_INFORMATION structure for the instance.
///                         </td> </tr> <tr> <td> <b>InstanceAggregateStandardInformation</b> </td> <td> Return an
///                         INSTANCE_AGGREGATE_STANDARD_INFORMATION structure for the instance. The LegacyFilter portion of the structure is
///                         not utilized. This structure is available starting with Windows Vista. </td> </tr> </table>
///    lpBuffer = Pointer to a caller-allocated buffer that receives the requested information. The type of the information
///               returned in the buffer is defined by the <i>dwInformationClass</i> parameter.
///    dwBufferSize = Size, in bytes, of the buffer that the <i>lpBuffer</i> parameter points to. The caller should set this parameter
///                   according to the given <i>dwInformationClass</i>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpBuffer</i> points to, if the call to <b>FilterInstanceFindFirst</b> succeeds. This parameter is required and
///                      cannot be <b>NULL</b>.
///    lpFilterInstanceFind = Pointer to a caller-allocated variable that receives a search handle for the minifilter if the call to
///                           <b>FilterInstanceFindFirst</b> succeeds; otherwise, it receives INVALID_HANDLE_VALUE. This search handle can be
///                           used in subsequent calls to FilterInstanceFindNext and FilterInstanceFindClose.
///Returns:
///    <b>FilterInstanceFindFirst</b> returns S_OK if successful. Otherwise, it returns an HRESULT error value, such as
///    one of the following: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer pointed to
///    by <i>lpBuffer</i> is not large enough to contain the requested information. When this value is returned,
///    <i>lpBytesReturned</i> will contain the size, in bytes, of the buffer required for the given
///    <i>dwInformationClass</i> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</b></dt> </dl> </td> <td width="60%"> An invalid value was
///    specified for the <i>dwInformationClass</i> parameter. For example, if
///    <b>InstanceAggregateStandardInformation</b> is specified for operating systems prior to Windows Vista, the
///    function returns this HRESULT value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_NO_MORE_ITEMS)</b></dt> </dl> </td> <td width="60%"> The minifilter specified by
///    the <i>lpFilterName</i> parameter does not have an instance on the file system stack. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterInstanceFindFirst(const(wchar)* lpFilterName, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned, 
                                FilterInstanceFindHandle* lpFilterInstanceFind);

///The <b>FilterInstanceFindNext</b> function continues a minifilter driver instance search started by a call to
///FilterInstanceFindFirst.
///Params:
///    hFilterInstanceFind = Minifilter instance search handle returned by a previous call to FilterInstanceFindFirst.
///    dwInformationClass = The type of instance information structure returned. This parameter must contain one of the following values.
///                         <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> <b>InstanceBasicInformation</b> </td> <td> Return an
///                         INSTANCE_BASIC_INFORMATION structure for the instance. </td> </tr> <tr> <td> <b>InstanceFullInformation</b> </td>
///                         <td> Return an INSTANCE_FULL_INFORMATION structure for the instance. </td> </tr> <tr> <td>
///                         <b>InstancePartialInformation</b> </td> <td> Return an INSTANCE_PARTIAL_INFORMATION structure for the instance.
///                         </td> </tr> <tr> <td> <b>InstanceAggregateStandardInformation</b> </td> <td> Return an
///                         INSTANCE_AGGREGATE_STANDARD_INFORMATION structure for the instance. The LegacyFilter portion of the structure is
///                         not utilized. This structure is available starting with Windows Vista. </td> </tr> </table>
///    lpBuffer = Pointer to a caller-allocated buffer that receives the requested information. The type of the information
///               returned in the buffer is defined by the <i>dwInformationClass</i> parameter.
///    dwBufferSize = Size, in bytes, of the buffer that the <i>lpBuffer</i> parameter points to. The caller should set this parameter
///                   according to the given <i>dwInformationClass</i>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpBuffer</i> points to if the call to <b>FilterInstanceFindNext</b> succeeds. This parameter is required and
///                      cannot be <b>NULL</b>.
///Returns:
///    <b>FilterInstanceFindNext</b> returns S_OK if successful. Otherwise, it returns an HRESULT error value, such as
///    one of the following: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer pointed to
///    by <i>lpBuffer</i> is not large enough to contain the requested information. When this value is returned,
///    <i>lpBytesReturned</i> will contain the size, in bytes, of the buffer required for the given
///    <i>dwInformationClass</i> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</b></dt> </dl> </td> <td width="60%"> An invalid value was
///    specified for the <i>dwInformationClass</i> parameter. For example, if
///    <b>InstanceAggregateStandardInformation</b> is specified for an operating system prior to Windows Vista,
///    <b>FilterInstanceFindNext</b> returns this HRESULT value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_NO_MORE_ITEMS)</b></dt> </dl> </td> <td width="60%"> This HRESULT value is
///    returned if there are no more unique instances of the minifilter. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterInstanceFindNext(HANDLE hFilterInstanceFind, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                               char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

///The <b>FilterInstanceFindClose</b> function closes the specified minifilter instance search handle. The
///FilterInstanceFindFirst and FilterInstanceFindNext functions use this search handle to locate instances of a
///minifilter.
///Params:
///    hFilterInstanceFind = Minifilter instance search handle to close. This handle must have been opened by a previous call to
///                          FilterInstanceFindFirst.
///Returns:
///    <b>FilterInstanceFindClose</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterInstanceFindClose(HANDLE hFilterInstanceFind);

///The <b>FilterVolumeInstanceFindFirst</b> function returns information about a minifilter driver instance or legacy
///filter driver and is used to begin scanning the filter drivers that are attached to a volume.
///Params:
///    lpVolumeName = Pointer to a null-terminated wide-character string that contains the name of the volume to which the minifilter
///                   instance or legacy filter is attached. The <i>lpVolumeName</i> input string can be any of the following. The
///                   trailing backslash (\\) is optional. <ul> <li> A drive letter, such as D:\ </li> <li> A path to a volume mount
///                   point, such as c:\mnt\edrive\ </li> <li> A unique volume identifier (also called a <i>volume GUID name</i>), such
///                   as \??\Volume{7603f260-142a-11d4-ac67-806d6172696f}\ </li> <li> A nonpersistent device name (also called a
///                   <i>target name</i> or an <i>NT device name</i>), such as \Device\HarddiskVolume1\ </li> </ul>
///    dwInformationClass = The type of filter driver information structure returned. This parameter must contain one of the following
///                         values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> <b>InstanceBasicInformation</b> </td> <td>
///                         Return an INSTANCE_BASIC_INFORMATION structure for a minifilter instance. Legacy filter drivers are ignored.
///                         </td> </tr> <tr> <td> <b>InstanceFullInformation</b> </td> <td> Return an INSTANCE_FULL_INFORMATION structure for
///                         a minifilter instance. Legacy filter drivers are ignored. </td> </tr> <tr> <td> <b>InstancePartialInformation</b>
///                         </td> <td> Return an INSTANCE_PARTIAL_INFORMATION structure for a minifilter instance. Legacy filter drivers are
///                         ignored. </td> </tr> <tr> <td> <b>InstanceAggregateStandardInformation</b> </td> <td> Return an
///                         INSTANCE_AGGREGATE_STANDARD_INFORMATION structure for the instance. The <b>LegacyFilter</b> member of the
///                         structure is not utilized. This structure is available starting with Windows Vista. </td> </tr> </table>
///    lpBuffer = Pointer to a caller-allocated buffer that receives the requested information. The type of the information
///               returned in the buffer is defined by the <i>dwInformationClass</i> parameter.
///    dwBufferSize = Size, in bytes, of the buffer that the <i>lpBuffer</i> parameter points to. The caller should set this parameter
///                   according to the given <i>dwInformationClass</i>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpBuffer</i> points to if the call to <b>FilterVolumeInstanceFindFirst</b> succeeds. This parameter is
///                      required and cannot be <b>NULL</b>.
///    lpVolumeInstanceFind = Pointer to a caller-allocated variable that receives a search handle for the minifilter instance or legacy filter
///                           (only when <b>InstanceAggregateStandardInformation</b> is specified) if the call to
///                           <b>FilterVolumeInstanceFindFirst</b> succeeds. Otherwise, <i>lpVolumeInstanceFind</i> receives
///                           INVALID_HANDLE_VALUE. This search handle can be used in subsequent calls to FilterVolumeInstanceFindNext and
///                           FilterVolumeInstanceFindClose.
///Returns:
///    <b>FilterVolumeInstanceFindFirst</b> returns S_OK if successful. Otherwise, it returns an HRESULT error value,
///    such as one of the following: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer
///    pointed to by <i>lpBuffer</i> is not large enough to contain the requested information. When this value is
///    returned, <i>lpBytesReturned</i> will contain the size, in bytes, of the buffer required for the given
///    <i>dwInformationClass</i> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</b></dt> </dl> </td> <td width="60%"> An invalid value was
///    specified for the <i>dwInformationClass</i> parameter. For example, if
///    <b>InstanceAggregateStandardInformation</b> is specified for an operating system prior to Windows Vista,
///    <b>FilterVolumeInstanceFindFirst</b> returns this HRESULT value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_NO_MORE_ITEMS)</b></dt> </dl> </td> <td width="60%"> A filter driver was not
///    found on the given volume. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterVolumeInstanceFindFirst(const(wchar)* lpVolumeName, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                      char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned, 
                                      FilterVolumeInstanceFindHandle* lpVolumeInstanceFind);

///The <b>FilterVolumeInstanceFindNext</b> function continues a minifilter driver instance or legacy filter driver
///search started by a call to FilterVolumeInstanceFindFirst.
///Params:
///    hVolumeInstanceFind = Volume filter driver search handle returned by a previous call to FilterVolumeInstanceFindFirst.
///    dwInformationClass = The type of filter driver information structure returned. This parameter must contain one of the following
///                         values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> <b>InstanceBasicInformation</b> </td> <td>
///                         Return an INSTANCE_BASIC_INFORMATION structure for a minifilter instance. Legacy filter drivers are ignored.
///                         </td> </tr> <tr> <td> <b>InstanceFullInformation</b> </td> <td> Return an INSTANCE_FULL_INFORMATION structure for
///                         a minifilter instance. Legacy filter drivers are ignored. </td> </tr> <tr> <td> <b>InstancePartialInformation</b>
///                         </td> <td> Return an INSTANCE_PARTIAL_INFORMATION structure for a minifilter instance. Legacy filter drivers are
///                         ignored. </td> </tr> <tr> <td> <b>InstanceAggregateStandardInformation</b> </td> <td> Return an
///                         INSTANCE_AGGREGATE_STANDARD_INFORMATION structure for the instance. The <b>LegacyFilter</b> member of the
///                         structure is not utilized. This structure is available starting with Windows Vista. </td> </tr> </table>
///    lpBuffer = Pointer to a caller-allocated buffer that receives the requested information. The type of the information
///               returned in the buffer is defined by the <i>dwInformationClass</i> parameter.
///    dwBufferSize = Size, in bytes, of the buffer that the <i>lpBuffer</i> parameter points to. The caller should set this parameter
///                   according to the given <i>dwInformationClass</i>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpBuffer</i> points to if the call to <b>FilterVolumeInstanceFindNext</b> succeeds. This parameter is required
///                      and cannot be <b>NULL</b>.
///Returns:
///    <b>FilterVolumeInstanceFindNext</b> returns S_OK if successful. Otherwise, it returns an HRESULT error value,
///    such as one of the following: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer
///    pointed to by <i>lpBuffer</i> is not large enough to contain the requested information. When this value is
///    returned, <i>lpBytesReturned</i> will contain the size, in bytes, of the buffer required for the given
///    <i>dwInformationClass</i> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</b></dt> </dl> </td> <td width="60%"> An invalid value was
///    specified for the <i>dwInformationClass</i> parameter. For example, if
///    <b>InstanceAggregateStandardInformation</b> is specified for an operating system prior to Windows Vista,
///    <b>FilterVolumeInstanceFindNext</b> returns this HRESULT value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_NO_MORE_ITEMS)</b></dt> </dl> </td> <td width="60%"> No more filter drivers were
///    found on the given volume. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterVolumeInstanceFindNext(HANDLE hVolumeInstanceFind, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                     char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

///The <b>FilterVolumeInstanceFindClose</b> function closes the specified volume instance search handle.
///FilterVolumeInstanceFindFirst and FilterVolumeInstanceFindNext use this search handle to locate instances on a
///volume.
///Params:
///    hVolumeInstanceFind = Volume instance search handle to close. This handle must have been opened by a previous call to
///                          FilterVolumeInstanceFindFirst.
///Returns:
///    <b>FilterVolumeInstanceFindClose</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterVolumeInstanceFindClose(HANDLE hVolumeInstanceFind);

///The <b>FilterGetInformation</b> function returns various kinds of information about a minifilter.
///Params:
///    hFilter = Handle returned by a previous call to the FilterCreate function.
///    dwInformationClass = Type of information requested. This parameter must be one of the following values. <table> <tr> <th>Value</th>
///                         <th>Meaning</th> </tr> <tr> <td> <b>FilterFullInformation</b> </td> <td> Return a FILTER_FULL_INFORMATION
///                         structure for the minifilter. </td> </tr> <tr> <td> <b>FilterAggregateBasicInformation</b> </td> <td> Return a
///                         FILTER_AGGREGATE_BASIC_INFORMATION structure for the minifilter. This <i>dwInformationClass</i> value is
///                         available starting with Microsoft Windows Server 2003 with SP1 and Microsoft Windows XP with SP2 with filter
///                         manager rollup. For more information about the filter manager rollup package for Windows XP with SP2, see article
///                         914882, " The filter manager rollup package for Windows XP SP2," in the Microsoft Knowledge Base. </td> </tr>
///                         <tr> <td> <b>FilterAggregateStandardInformation</b> </td> <td> Return a FILTER_AGGREGATE_STANDARD_INFORMATION
///                         structure for each minifilter. The LegacyFilter portion of the structure is not utilized. This
///                         <i>dwInformationClass</i> value is available starting with Windows Vista. </td> </tr> </table>
///    lpBuffer = Pointer to a caller-allocated buffer that receives the requested information. The type of the information
///               returned in the buffer is defined by the <i>dwInformationClass</i> parameter.
///    dwBufferSize = Size, in bytes, of the buffer that the <i>lpBuffer</i> parameter points to. The caller should set this parameter
///                   according to the given <i>dwInformationClass</i>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpBuffer</i> points to if the call to <b>FilterGetInformation</b> succeeds. This parameter is required and
///                      cannot be <b>NULL</b>.
///Returns:
///    <b>FilterGetInformation</b> returns S_OK if successful. Otherwise, it returns an HRESULT error value, such as one
///    of the following: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer pointed to
///    by <i>lpBuffer</i> is not large enough to contain the requested information. When this value is returned,
///    <i>lpBytesReturned</i> will contain the size, in bytes, of the buffer required for the given
///    <i>dwInformationClass</i> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</b></dt> </dl> </td> <td width="60%"> An invalid value was
///    specified for the <i>dwInformationClass</i> parameter. For example, if <b>FilterAggregateStandardInformation</b>
///    is specified for an operating system prior to Windows Vista, <b>FilterGetInformation</b> returns this HRESULT
///    value. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterGetInformation(HFILTER hFilter, FILTER_INFORMATION_CLASS dwInformationClass, char* lpBuffer, 
                             uint dwBufferSize, uint* lpBytesReturned);

///The <b>FilterInstanceGetInformation</b> function returns various kinds of information about a minifilter instance.
///Params:
///    hInstance = Handle returned by a previous call to FilterInstanceCreate.
///    dwInformationClass = The type of instance information structure returned. This parameter must contain one of the following values.
///                         <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> <b>InstanceBasicInformation</b> </td> <td> Return an
///                         INSTANCE_BASIC_INFORMATION structure for the instance. </td> </tr> <tr> <td> <b>InstanceFullInformation</b> </td>
///                         <td> Return an INSTANCE_FULL_INFORMATION structure for the instance. </td> </tr> <tr> <td>
///                         <b>InstancePartialInformation</b> </td> <td> Return an INSTANCE_PARTIAL_INFORMATION structure for the instance.
///                         </td> </tr> <tr> <td> <b>InstanceAggregateStandardInformation</b> </td> <td> Return an
///                         INSTANCE_AGGREGATE_STANDARD_INFORMATION structure for the instance. The <b>LegacyFilter</b> portion of the
///                         structure is utilized starting with Windows 8. This structure is available starting with Windows Vista. </td>
///                         </tr> </table>
///    lpBuffer = Pointer to a caller-allocated buffer that receives the requested information. The type of the information
///               returned in the buffer is defined by the <i>dwInformationClass</i> parameter.
///    dwBufferSize = Size, in bytes, of the buffer that the <i>lpBuffer</i> parameter points to. The caller should set this parameter
///                   according to the given <i>dwInformationClass</i>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpBuffer</i> points to if the call to <b>FilterInstanceGetInformation</b> succeeds. This parameter is required
///                      and cannot be <b>NULL</b>.
///Returns:
///    <b>FilterInstanceGetInformation</b> returns S_OK if successful. Otherwise, it returns an HRESULT error value,
///    such as one of the following: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer
///    pointed to by <i>lpBuffer</i> is not large enough to contain the requested information. When this value is
///    returned, <i>lpBytesReturned</i> will contain the size, in bytes, of the buffer required for the given
///    <i>dwInformationClass</i> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</b></dt> </dl> </td> <td width="60%"> An invalid value was
///    specified for the <i>dwInformationClass</i> parameter. For example, if
///    <b>InstanceAggregateStandardInformation</b> is specified for an operating system prior to Windows Vista,
///    <b>FilterInstanceGetInformation</b> returns this HRESULT value. </td> </tr> </table>
///    
@DllImport("FLTLIB")
HRESULT FilterInstanceGetInformation(HFILTER_INSTANCE hInstance, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                     char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

///<b>FilterConnectCommunicationPort</b> opens a new connection to a communication server port that is created by a file
///system minifilter.
///Params:
///    lpPortName = Pointer to a NULL-terminated wide-character string containing the fully qualified name of the communication
///                 server port (for example, L"\\MyFilterPort").
///    dwOptions = Connection options for the communication port. Prior to Windows 8.1, this value is set to 0. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FLT_PORT_FLAG_SYNC_HANDLE"></a><a
///                id="flt_port_flag_sync_handle"></a><dl> <dt><b>FLT_PORT_FLAG_SYNC_HANDLE</b></dt> </dl> </td> <td width="60%">
///                The handle returned in <i>hPort</i> is for synchronous I/O. This flag is available starting with Windows 8.1.
///                </td> </tr> </table>
///    lpContext = Pointer to caller-supplied context information to be passed to the kernel-mode minifilter's connect notification
///                routine. (See the <i>ConnectNotifyCallback</i> parameter in the reference page for FltCreateCommunicationPort.)
///                This parameter is optional and can be <b>NULL</b>.
///    wSizeOfContext = Size, in bytes, of the structure that the <i>lpContext</i> parameter points to. If the value of <i>lpContext</i>
///                     is non-<b>NULL</b>, this parameter must be nonzero. If <i>lpContext</i> is <b>NULL</b>, this parameter must be
///                     zero.
///    lpSecurityAttributes = Pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by child
///                           processes. For more information about the SECURITY_ATTRIBUTES structure, see the Microsoft Windows SDK
///                           documentation. This parameter is optional and can be <b>NULL</b>. If this parameter is <b>NULL</b>, the handle
///                           cannot be inherited.
///    hPort = Pointer to a caller-allocated variable that receives a handle for the newly created connection port if the call
///            to <b>FilterConnectCommunicationPort</b> succeeds; otherwise, it receives INVALID_HANDLE_VALUE.
///Returns:
///    <b>FilterConnectCommunicationPort</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterConnectCommunicationPort(const(wchar)* lpPortName, uint dwOptions, char* lpContext, 
                                       ushort wSizeOfContext, SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                                       HANDLE* hPort);

///The <b>FilterSendMessage</b> function sends a message to a kernel-mode minifilter.
///Params:
///    hPort = Communication port handle returned by a previous call to FilterConnectCommunicationPort. This parameter is
///            required and cannot be <b>NULL</b>.
///    lpInBuffer = Pointer to a caller-allocated buffer containing the message to be sent to the minifilter. The message format is
///                 caller-defined. This parameter is required and cannot be <b>NULL</b>.
///    dwInBufferSize = Size, in bytes, of the buffer pointed to by <i>lpInBuffer</i>.
///    lpOutBuffer = Pointer to a caller-allocated buffer that receives the reply (if any) from the minifilter.
///    dwOutBufferSize = Size, in bytes, of the buffer pointed to by <i>lpOutBuffer</i>. This value is ignored if <i>lpOutBuffer</i> is
///                      <b>NULL</b>.
///    lpBytesReturned = Pointer to a caller-allocated variable that receives the number of bytes returned in the buffer that
///                      <i>lpOutBuffer</i> points to if the call to <b>FilterSendMessage</b> succeeds. This parameter is required and
///                      cannot be <b>NULL</b>.
///Returns:
///    <b>FilterSendMessage</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterSendMessage(HANDLE hPort, char* lpInBuffer, uint dwInBufferSize, char* lpOutBuffer, 
                          uint dwOutBufferSize, uint* lpBytesReturned);

///The <b>FilterGetMessage</b> function gets a message from a kernel-mode minifilter.
///Params:
///    hPort = Communication port handle returned by a previous call to FilterConnectCommunicationPort. This parameter is
///            required and cannot be <b>NULL</b>.
///    lpMessageBuffer = Pointer to a caller-allocated buffer that receives the message from the minifilter. The message must contain a
///                      FILTER_MESSAGE_HEADER structure, but otherwise its format is caller-defined. This parameter is required and
///                      cannot be <b>NULL</b>.
///    dwMessageBufferSize = Size, in bytes, of the buffer that the <i>lpMessageBuffer</i> parameter points to.
///    lpOverlapped = Pointer to an OVERLAPPED structure. This parameter is optional and can be <b>NULL</b>. If it is not <b>NULL</b>,
///                   the caller must initialize the <b>hEvent</b> member of the OVERLAPPED structure to a valid event handle or
///                   <b>NULL</b>.
///Returns:
///    <b>FilterGetMessage</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterGetMessage(HANDLE hPort, char* lpMessageBuffer, uint dwMessageBufferSize, OVERLAPPED* lpOverlapped);

///The <b>FilterReplyMessage</b> function replies to a message from a kernel-mode minifilter.
///Params:
///    hPort = Communication port handle returned by a previous call to FilterConnectCommunicationPort. This parameter is
///            required and cannot be <b>NULL</b>.
///    lpReplyBuffer = A pointer to a caller-allocated buffer containing the reply to be sent to the minifilter. The reply must contain
///                    a FILTER_REPLY_HEADER structure, but otherwise, its format is caller-defined. This parameter is required and
///                    cannot be <b>NULL</b>.
///    dwReplyBufferSize = Size, in bytes, of the buffer that the <i>lpReplyBuffer</i> parameter points to. See the Remarks section.
///Returns:
///    <b>FilterReplyMessage</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterReplyMessage(HANDLE hPort, char* lpReplyBuffer, uint dwReplyBufferSize);

///The <b>FilterGetDosName</b> function returns the MS-DOS device name that corresponds to the given volume name.
///Params:
///    lpVolumeName = Pointer to a NULL-terminated wide-character string containing the volume name. The <i>lpVolumeName</i> input
///                   string can be any of the following. The trailing backslash (\\) is optional. <ul> <li> A drive letter, such as
///                   "D:\" </li> <li> A path to a volume mount point, such as "c:\mnt\edrive\" </li> <li> A unique volume identifier
///                   (also called a <i>volume GUID name</i>), such as "\??\Volume{7603f260-142a-11d4-ac67-806d6172696f}\" </li> <li> A
///                   nonpersistent device name (also called a <i>target name</i> or an <i>NT device name</i>), such as
///                   "\Device\HarddiskVolume1\" </li> </ul> This parameter is required and cannot be <b>NULL</b>.
///    lpDosName = Pointer to a caller-allocated buffer that receives the MS-DOS device name as a NULL-terminated wide-character
///                string.
///    dwDosNameBufferSize = Size, in wide characters, of the buffer that <i>lpDosName </i>points to.
///Returns:
///    <b>FilterGetDosName</b> returns S_OK if successful. Otherwise, it returns an error value.
///    
@DllImport("FLTLIB")
HRESULT FilterGetDosName(const(wchar)* lpVolumeName, const(wchar)* lpDosName, uint dwDosNameBufferSize);

///The <b>RtlCaptureStackBackTrace</b> routine captures a stack back trace by walking up the stack and recording the
///information for each frame.
///Params:
///    FramesToSkip = The number of frames to skip from the start of the back trace.
///    FramesToCapture = The number of frames to be captured.
///    BackTrace = An array of pointers captured from the current stack trace.
///    BackTraceHash = An optional value that can be used to organize hash tables. If this parameter is <b>NULL</b>, no hash value is
///                    computed. This value is calculated based on the values of the pointers returned in the <i>BackTrace</i> array.
///                    Two identical stack traces will generate identical hash values.
@DllImport("KERNEL32")
ushort RtlCaptureStackBackTrace(uint FramesToSkip, uint FramesToCapture, char* BackTrace, uint* BackTraceHash);


