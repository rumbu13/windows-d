module windows.installablefilesystems;

public import windows.com;
public import windows.systemservices;

extern(Windows):

enum FLT_FILESYSTEM_TYPE
{
    FLT_FSTYPE_UNKNOWN = 0,
    FLT_FSTYPE_RAW = 1,
    FLT_FSTYPE_NTFS = 2,
    FLT_FSTYPE_FAT = 3,
    FLT_FSTYPE_CDFS = 4,
    FLT_FSTYPE_UDFS = 5,
    FLT_FSTYPE_LANMAN = 6,
    FLT_FSTYPE_WEBDAV = 7,
    FLT_FSTYPE_RDPDR = 8,
    FLT_FSTYPE_NFS = 9,
    FLT_FSTYPE_MS_NETWARE = 10,
    FLT_FSTYPE_NETWARE = 11,
    FLT_FSTYPE_BSUDF = 12,
    FLT_FSTYPE_MUP = 13,
    FLT_FSTYPE_RSFX = 14,
    FLT_FSTYPE_ROXIO_UDF1 = 15,
    FLT_FSTYPE_ROXIO_UDF2 = 16,
    FLT_FSTYPE_ROXIO_UDF3 = 17,
    FLT_FSTYPE_TACIT = 18,
    FLT_FSTYPE_FS_REC = 19,
    FLT_FSTYPE_INCD = 20,
    FLT_FSTYPE_INCD_FAT = 21,
    FLT_FSTYPE_EXFAT = 22,
    FLT_FSTYPE_PSFS = 23,
    FLT_FSTYPE_GPFS = 24,
    FLT_FSTYPE_NPFS = 25,
    FLT_FSTYPE_MSFS = 26,
    FLT_FSTYPE_CSVFS = 27,
    FLT_FSTYPE_REFS = 28,
    FLT_FSTYPE_OPENAFS = 29,
    FLT_FSTYPE_CIMFS = 30,
}

enum FILTER_INFORMATION_CLASS
{
    FilterFullInformation = 0,
    FilterAggregateBasicInformation = 1,
    FilterAggregateStandardInformation = 2,
}

struct FILTER_FULL_INFORMATION
{
    uint NextEntryOffset;
    uint FrameID;
    uint NumberOfInstances;
    ushort FilterNameLength;
    ushort FilterNameBuffer;
}

struct FILTER_AGGREGATE_BASIC_INFORMATION
{
    uint NextEntryOffset;
    uint Flags;
    _Type_e__Union Type;
}

struct FILTER_AGGREGATE_STANDARD_INFORMATION
{
    uint NextEntryOffset;
    uint Flags;
    _Type_e__Union Type;
}

enum FILTER_VOLUME_INFORMATION_CLASS
{
    FilterVolumeBasicInformation = 0,
    FilterVolumeStandardInformation = 1,
}

struct FILTER_VOLUME_BASIC_INFORMATION
{
    ushort FilterVolumeNameLength;
    ushort FilterVolumeName;
}

struct FILTER_VOLUME_STANDARD_INFORMATION
{
    uint NextEntryOffset;
    uint Flags;
    uint FrameID;
    FLT_FILESYSTEM_TYPE FileSystemType;
    ushort FilterVolumeNameLength;
    ushort FilterVolumeName;
}

enum INSTANCE_INFORMATION_CLASS
{
    InstanceBasicInformation = 0,
    InstancePartialInformation = 1,
    InstanceFullInformation = 2,
    InstanceAggregateStandardInformation = 3,
}

struct INSTANCE_BASIC_INFORMATION
{
    uint NextEntryOffset;
    ushort InstanceNameLength;
    ushort InstanceNameBufferOffset;
}

struct INSTANCE_PARTIAL_INFORMATION
{
    uint NextEntryOffset;
    ushort InstanceNameLength;
    ushort InstanceNameBufferOffset;
    ushort AltitudeLength;
    ushort AltitudeBufferOffset;
}

struct INSTANCE_FULL_INFORMATION
{
    uint NextEntryOffset;
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
    _Type_e__Union Type;
}

struct FILTER_MESSAGE_HEADER
{
    uint ReplyLength;
    ulong MessageId;
}

struct FILTER_REPLY_HEADER
{
    NTSTATUS Status;
    ulong MessageId;
}

@DllImport("FLTLIB.dll")
HRESULT FilterLoad(const(wchar)* lpFilterName);

@DllImport("FLTLIB.dll")
HRESULT FilterUnload(const(wchar)* lpFilterName);

@DllImport("FLTLIB.dll")
HRESULT FilterCreate(const(wchar)* lpFilterName, HFILTER* hFilter);

@DllImport("FLTLIB.dll")
HRESULT FilterClose(HFILTER hFilter);

@DllImport("FLTLIB.dll")
HRESULT FilterInstanceCreate(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpInstanceName, HFILTER_INSTANCE* hInstance);

@DllImport("FLTLIB.dll")
HRESULT FilterInstanceClose(HFILTER_INSTANCE hInstance);

@DllImport("FLTLIB.dll")
HRESULT FilterAttach(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpInstanceName, uint dwCreatedInstanceNameLength, const(wchar)* lpCreatedInstanceName);

@DllImport("FLTLIB.dll")
HRESULT FilterAttachAtAltitude(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpAltitude, const(wchar)* lpInstanceName, uint dwCreatedInstanceNameLength, const(wchar)* lpCreatedInstanceName);

@DllImport("FLTLIB.dll")
HRESULT FilterDetach(const(wchar)* lpFilterName, const(wchar)* lpVolumeName, const(wchar)* lpInstanceName);

@DllImport("FLTLIB.dll")
HRESULT FilterFindFirst(FILTER_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned, FilterFindHandle* lpFilterFind);

@DllImport("FLTLIB.dll")
HRESULT FilterFindNext(HANDLE hFilterFind, FILTER_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB.dll")
HRESULT FilterFindClose(HANDLE hFilterFind);

@DllImport("FLTLIB.dll")
HRESULT FilterVolumeFindFirst(FILTER_VOLUME_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned, FilterVolumeFindHandle* lpVolumeFind);

@DllImport("FLTLIB.dll")
HRESULT FilterVolumeFindNext(HANDLE hVolumeFind, FILTER_VOLUME_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB.dll")
HRESULT FilterVolumeFindClose(HANDLE hVolumeFind);

@DllImport("FLTLIB.dll")
HRESULT FilterInstanceFindFirst(const(wchar)* lpFilterName, INSTANCE_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned, FilterInstanceFindHandle* lpFilterInstanceFind);

@DllImport("FLTLIB.dll")
HRESULT FilterInstanceFindNext(HANDLE hFilterInstanceFind, INSTANCE_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB.dll")
HRESULT FilterInstanceFindClose(HANDLE hFilterInstanceFind);

@DllImport("FLTLIB.dll")
HRESULT FilterVolumeInstanceFindFirst(const(wchar)* lpVolumeName, INSTANCE_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned, FilterVolumeInstanceFindHandle* lpVolumeInstanceFind);

@DllImport("FLTLIB.dll")
HRESULT FilterVolumeInstanceFindNext(HANDLE hVolumeInstanceFind, INSTANCE_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB.dll")
HRESULT FilterVolumeInstanceFindClose(HANDLE hVolumeInstanceFind);

@DllImport("FLTLIB.dll")
HRESULT FilterGetInformation(HFILTER hFilter, FILTER_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB.dll")
HRESULT FilterInstanceGetInformation(HFILTER_INSTANCE hInstance, INSTANCE_INFORMATION_CLASS dwInformationClass, char* lpBuffer, uint dwBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB.dll")
HRESULT FilterConnectCommunicationPort(const(wchar)* lpPortName, uint dwOptions, char* lpContext, ushort wSizeOfContext, SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE* hPort);

@DllImport("FLTLIB.dll")
HRESULT FilterSendMessage(HANDLE hPort, char* lpInBuffer, uint dwInBufferSize, char* lpOutBuffer, uint dwOutBufferSize, uint* lpBytesReturned);

@DllImport("FLTLIB.dll")
HRESULT FilterGetMessage(HANDLE hPort, char* lpMessageBuffer, uint dwMessageBufferSize, OVERLAPPED* lpOverlapped);

@DllImport("FLTLIB.dll")
HRESULT FilterReplyMessage(HANDLE hPort, char* lpReplyBuffer, uint dwReplyBufferSize);

@DllImport("FLTLIB.dll")
HRESULT FilterGetDosName(const(wchar)* lpVolumeName, const(wchar)* lpDosName, uint dwDosNameBufferSize);

@DllImport("KERNEL32.dll")
ushort RtlCaptureStackBackTrace(uint FramesToSkip, uint FramesToCapture, char* BackTrace, uint* BackTraceHash);

alias FilterFindHandle = int;
alias FilterInstanceFindHandle = int;
alias FilterVolumeFindHandle = int;
alias FilterVolumeInstanceFindHandle = int;
alias HFILTER = int;
alias HFILTER_INSTANCE = int;
