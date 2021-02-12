module windows.processsnapshotting;

public import windows.debug;
public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

enum PSS_HANDLE_FLAGS
{
    PSS_HANDLE_NONE = 0,
    PSS_HANDLE_HAVE_TYPE = 1,
    PSS_HANDLE_HAVE_NAME = 2,
    PSS_HANDLE_HAVE_BASIC_INFORMATION = 4,
    PSS_HANDLE_HAVE_TYPE_SPECIFIC_INFORMATION = 8,
}

enum PSS_OBJECT_TYPE
{
    PSS_OBJECT_TYPE_UNKNOWN = 0,
    PSS_OBJECT_TYPE_PROCESS = 1,
    PSS_OBJECT_TYPE_THREAD = 2,
    PSS_OBJECT_TYPE_MUTANT = 3,
    PSS_OBJECT_TYPE_EVENT = 4,
    PSS_OBJECT_TYPE_SECTION = 5,
    PSS_OBJECT_TYPE_SEMAPHORE = 6,
}

enum PSS_CAPTURE_FLAGS
{
    PSS_CAPTURE_NONE = 0,
    PSS_CAPTURE_VA_CLONE = 1,
    PSS_CAPTURE_RESERVED_00000002 = 2,
    PSS_CAPTURE_HANDLES = 4,
    PSS_CAPTURE_HANDLE_NAME_INFORMATION = 8,
    PSS_CAPTURE_HANDLE_BASIC_INFORMATION = 16,
    PSS_CAPTURE_HANDLE_TYPE_SPECIFIC_INFORMATION = 32,
    PSS_CAPTURE_HANDLE_TRACE = 64,
    PSS_CAPTURE_THREADS = 128,
    PSS_CAPTURE_THREAD_CONTEXT = 256,
    PSS_CAPTURE_THREAD_CONTEXT_EXTENDED = 512,
    PSS_CAPTURE_RESERVED_00000400 = 1024,
    PSS_CAPTURE_VA_SPACE = 2048,
    PSS_CAPTURE_VA_SPACE_SECTION_INFORMATION = 4096,
    PSS_CAPTURE_IPT_TRACE = 8192,
    PSS_CAPTURE_RESERVED_00004000 = 16384,
    PSS_CREATE_BREAKAWAY_OPTIONAL = 67108864,
    PSS_CREATE_BREAKAWAY = 134217728,
    PSS_CREATE_FORCE_BREAKAWAY = 268435456,
    PSS_CREATE_USE_VM_ALLOCATIONS = 536870912,
    PSS_CREATE_MEASURE_PERFORMANCE = 1073741824,
    PSS_CREATE_RELEASE_SECTION = -2147483648,
}

enum PSS_QUERY_INFORMATION_CLASS
{
    PSS_QUERY_PROCESS_INFORMATION = 0,
    PSS_QUERY_VA_CLONE_INFORMATION = 1,
    PSS_QUERY_AUXILIARY_PAGES_INFORMATION = 2,
    PSS_QUERY_VA_SPACE_INFORMATION = 3,
    PSS_QUERY_HANDLE_INFORMATION = 4,
    PSS_QUERY_THREAD_INFORMATION = 5,
    PSS_QUERY_HANDLE_TRACE_INFORMATION = 6,
    PSS_QUERY_PERFORMANCE_COUNTERS = 7,
}

enum PSS_WALK_INFORMATION_CLASS
{
    PSS_WALK_AUXILIARY_PAGES = 0,
    PSS_WALK_VA_SPACE = 1,
    PSS_WALK_HANDLES = 2,
    PSS_WALK_THREADS = 3,
}

enum PSS_DUPLICATE_FLAGS
{
    PSS_DUPLICATE_NONE = 0,
    PSS_DUPLICATE_CLOSE_SOURCE = 1,
}

struct HPSS__
{
    int unused;
}

struct HPSSWALK__
{
    int unused;
}

enum PSS_PROCESS_FLAGS
{
    PSS_PROCESS_FLAGS_NONE = 0,
    PSS_PROCESS_FLAGS_PROTECTED = 1,
    PSS_PROCESS_FLAGS_WOW64 = 2,
    PSS_PROCESS_FLAGS_RESERVED_03 = 4,
    PSS_PROCESS_FLAGS_RESERVED_04 = 8,
    PSS_PROCESS_FLAGS_FROZEN = 16,
}

struct PSS_PROCESS_INFORMATION
{
    uint ExitStatus;
    void* PebBaseAddress;
    uint AffinityMask;
    int BasePriority;
    uint ProcessId;
    uint ParentProcessId;
    PSS_PROCESS_FLAGS Flags;
    FILETIME CreateTime;
    FILETIME ExitTime;
    FILETIME KernelTime;
    FILETIME UserTime;
    uint PriorityClass;
    uint PeakVirtualSize;
    uint VirtualSize;
    uint PageFaultCount;
    uint PeakWorkingSetSize;
    uint WorkingSetSize;
    uint QuotaPeakPagedPoolUsage;
    uint QuotaPagedPoolUsage;
    uint QuotaPeakNonPagedPoolUsage;
    uint QuotaNonPagedPoolUsage;
    uint PagefileUsage;
    uint PeakPagefileUsage;
    uint PrivateUsage;
    uint ExecuteFlags;
    ushort ImageFileName;
}

struct PSS_VA_CLONE_INFORMATION
{
    HANDLE VaCloneHandle;
}

struct PSS_AUXILIARY_PAGES_INFORMATION
{
    uint AuxPagesCaptured;
}

struct PSS_VA_SPACE_INFORMATION
{
    uint RegionCount;
}

struct PSS_HANDLE_INFORMATION
{
    uint HandlesCaptured;
}

struct PSS_THREAD_INFORMATION
{
    uint ThreadsCaptured;
    uint ContextLength;
}

struct PSS_HANDLE_TRACE_INFORMATION
{
    HANDLE SectionHandle;
    uint Size;
}

struct PSS_PERFORMANCE_COUNTERS
{
    ulong TotalCycleCount;
    ulong TotalWallClockPeriod;
    ulong VaCloneCycleCount;
    ulong VaCloneWallClockPeriod;
    ulong VaSpaceCycleCount;
    ulong VaSpaceWallClockPeriod;
    ulong AuxPagesCycleCount;
    ulong AuxPagesWallClockPeriod;
    ulong HandlesCycleCount;
    ulong HandlesWallClockPeriod;
    ulong ThreadsCycleCount;
    ulong ThreadsWallClockPeriod;
}

struct PSS_AUXILIARY_PAGE_ENTRY
{
    void* Address;
    MEMORY_BASIC_INFORMATION BasicInformation;
    FILETIME CaptureTime;
    void* PageContents;
    uint PageSize;
}

struct PSS_VA_SPACE_ENTRY
{
    void* BaseAddress;
    void* AllocationBase;
    uint AllocationProtect;
    uint RegionSize;
    uint State;
    uint Protect;
    uint Type;
    uint TimeDateStamp;
    uint SizeOfImage;
    void* ImageBase;
    uint CheckSum;
    ushort MappedFileNameLength;
    const(ushort)* MappedFileName;
}

struct PSS_HANDLE_ENTRY
{
    HANDLE Handle;
    PSS_HANDLE_FLAGS Flags;
    PSS_OBJECT_TYPE ObjectType;
    FILETIME CaptureTime;
    uint Attributes;
    uint GrantedAccess;
    uint HandleCount;
    uint PointerCount;
    uint PagedPoolCharge;
    uint NonPagedPoolCharge;
    FILETIME CreationTime;
    ushort TypeNameLength;
    const(ushort)* TypeName;
    ushort ObjectNameLength;
    const(ushort)* ObjectName;
    _TypeSpecificInformation_e__Union TypeSpecificInformation;
}

enum PSS_THREAD_FLAGS
{
    PSS_THREAD_FLAGS_NONE = 0,
    PSS_THREAD_FLAGS_TERMINATED = 1,
}

struct PSS_THREAD_ENTRY
{
    uint ExitStatus;
    void* TebBaseAddress;
    uint ProcessId;
    uint ThreadId;
    uint AffinityMask;
    int Priority;
    int BasePriority;
    void* LastSyscallFirstArgument;
    ushort LastSyscallNumber;
    FILETIME CreateTime;
    FILETIME ExitTime;
    FILETIME KernelTime;
    FILETIME UserTime;
    void* Win32StartAddress;
    FILETIME CaptureTime;
    PSS_THREAD_FLAGS Flags;
    ushort SuspendCount;
    ushort SizeOfContextRecord;
    CONTEXT* ContextRecord;
}

struct PSS_ALLOCATOR
{
    void* Context;
    int AllocRoutine;
    int FreeRoutine;
}

@DllImport("KERNEL32.dll")
uint PssCaptureSnapshot(HANDLE ProcessHandle, PSS_CAPTURE_FLAGS CaptureFlags, uint ThreadContextFlags, HPSS__** SnapshotHandle);

@DllImport("KERNEL32.dll")
uint PssFreeSnapshot(HANDLE ProcessHandle, HPSS__* SnapshotHandle);

@DllImport("KERNEL32.dll")
uint PssQuerySnapshot(HPSS__* SnapshotHandle, PSS_QUERY_INFORMATION_CLASS InformationClass, char* Buffer, uint BufferLength);

@DllImport("KERNEL32.dll")
uint PssWalkSnapshot(HPSS__* SnapshotHandle, PSS_WALK_INFORMATION_CLASS InformationClass, HPSSWALK__* WalkMarkerHandle, char* Buffer, uint BufferLength);

@DllImport("KERNEL32.dll")
uint PssDuplicateSnapshot(HANDLE SourceProcessHandle, HPSS__* SnapshotHandle, HANDLE TargetProcessHandle, HPSS__** TargetSnapshotHandle, PSS_DUPLICATE_FLAGS Flags);

@DllImport("KERNEL32.dll")
uint PssWalkMarkerCreate(const(PSS_ALLOCATOR)* Allocator, HPSSWALK__** WalkMarkerHandle);

@DllImport("KERNEL32.dll")
uint PssWalkMarkerFree(HPSSWALK__* WalkMarkerHandle);

@DllImport("KERNEL32.dll")
uint PssWalkMarkerGetPosition(HPSSWALK__* WalkMarkerHandle, uint* Position);

@DllImport("KERNEL32.dll")
uint PssWalkMarkerSetPosition(HPSSWALK__* WalkMarkerHandle, uint Position);

@DllImport("KERNEL32.dll")
uint PssWalkMarkerSeekToBeginning(HPSSWALK__* WalkMarkerHandle);

