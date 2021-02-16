module windows.installablefilesystems;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : HANDLE, NTSTATUS, OVERLAPPED, SECURITY_ATTRIBUTES;

extern(Windows):


// Enums


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
alias FLT_FILESYSTEM_TYPE = int;

enum : int
{
    FilterFullInformation              = 0x00000000,
    FilterAggregateBasicInformation    = 0x00000001,
    FilterAggregateStandardInformation = 0x00000002,
}
alias FILTER_INFORMATION_CLASS = int;

enum : int
{
    FilterVolumeBasicInformation    = 0x00000000,
    FilterVolumeStandardInformation = 0x00000001,
}
alias FILTER_VOLUME_INFORMATION_CLASS = int;

enum : int
{
    InstanceBasicInformation             = 0x00000000,
    InstancePartialInformation           = 0x00000001,
    InstanceFullInformation              = 0x00000002,
    InstanceAggregateStandardInformation = 0x00000003,
}
alias INSTANCE_INFORMATION_CLASS = int;

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

@DllImport("FLTLIB")
HRESULT FilterLoad(const(wchar)* lpFilterName);

@DllImport("FLTLIB")
HRESULT FilterUnload(const(wchar)* lpFilterName);

@DllImport("FLTLIB")
HRESULT FilterCreate(const(wchar)* lpFilterName, HFILTER* hFilter);

@DllImport("FLTLIB")
HRESULT FilterClose(HFILTER hFilter);

@DllImport("FLTLIB")
HRESULT FilterInstanceCreate(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpInstanceName, 
                             HFILTER_INSTANCE* hInstance);

@DllImport("FLTLIB")
HRESULT FilterInstanceClose(HFILTER_INSTANCE hInstance);

@DllImport("FLTLIB")
HRESULT FilterAttach(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpInstanceName, 
                     uint dwCreatedInstanceNameLength, const(wchar)* lpCreatedInstanceName);

@DllImport("FLTLIB")
HRESULT FilterAttachAtAltitude(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpAltitude, 
                               const(wchar)* lpInstanceName, uint dwCreatedInstanceNameLength, 
                               const(wchar)* lpCreatedInstanceName);

@DllImport("FLTLIB")
HRESULT FilterDetach(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpInstanceName);

@DllImport("FLTLIB")
HRESULT FilterFindFirst(FILTER_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, 
                        uint* lpBytesReturned, FilterFindHandle* lpFilterFind);

@DllImport("FLTLIB")
HRESULT FilterFindNext(HANDLE hFilterFind, FILTER_INFORMATION_CLASS dwInformationClass, char* lpBuffer, 
                       uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB")
HRESULT FilterFindClose(HANDLE hFilterFind);

@DllImport("FLTLIB")
HRESULT FilterVolumeFindFirst(FILTER_VOLUME_INFORMATION_CLASS dwInformationClass, char* lpBuffer, 
                              uint dwBufferSize, uint* lpBytesReturned, FilterVolumeFindHandle* lpVolumeFind);

@DllImport("FLTLIB")
HRESULT FilterVolumeFindNext(HANDLE hVolumeFind, FILTER_VOLUME_INFORMATION_CLASS dwInformationClass, 
                             char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB")
HRESULT FilterVolumeFindClose(HANDLE hVolumeFind);

@DllImport("FLTLIB")
HRESULT FilterInstanceFindFirst(const(wchar)* lpFilterName, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned, 
                                FilterInstanceFindHandle* lpFilterInstanceFind);

@DllImport("FLTLIB")
HRESULT FilterInstanceFindNext(HANDLE hFilterInstanceFind, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                               char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB")
HRESULT FilterInstanceFindClose(HANDLE hFilterInstanceFind);

@DllImport("FLTLIB")
HRESULT FilterVolumeInstanceFindFirst(const(wchar)* lpVolumeName, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                      char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned, 
                                      FilterVolumeInstanceFindHandle* lpVolumeInstanceFind);

@DllImport("FLTLIB")
HRESULT FilterVolumeInstanceFindNext(HANDLE hVolumeInstanceFind, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                     char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB")
HRESULT FilterVolumeInstanceFindClose(HANDLE hVolumeInstanceFind);

@DllImport("FLTLIB")
HRESULT FilterGetInformation(HFILTER hFilter, FILTER_INFORMATION_CLASS dwInformationClass, char* lpBuffer, 
                             uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB")
HRESULT FilterInstanceGetInformation(HFILTER_INSTANCE hInstance, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                     char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB")
HRESULT FilterConnectCommunicationPort(const(wchar)* lpPortName, uint dwOptions, char* lpContext, 
                                       ushort wSizeOfContext, SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                                       HANDLE* hPort);

@DllImport("FLTLIB")
HRESULT FilterSendMessage(HANDLE hPort, char* lpInBuffer, uint dwInBufferSize, char* lpOutBuffer, 
                          uint dwOutBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB")
HRESULT FilterGetMessage(HANDLE hPort, char* lpMessageBuffer, uint dwMessageBufferSize, OVERLAPPED* lpOverlapped);

@DllImport("FLTLIB")
HRESULT FilterReplyMessage(HANDLE hPort, char* lpReplyBuffer, uint dwReplyBufferSize);

@DllImport("FLTLIB")
HRESULT FilterGetDosName(const(wchar)* lpVolumeName, const(wchar)* lpDosName, uint dwDosNameBufferSize);

@DllImport("KERNEL32")
ushort RtlCaptureStackBackTrace(uint FramesToSkip, uint FramesToCapture, char* BackTrace, uint* BackTraceHash);


