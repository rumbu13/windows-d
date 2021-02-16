module windows.processsnapshotting;

public import windows.core;
public import windows.dbg : CONTEXT;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, MEMORY_BASIC_INFORMATION;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    PSS_HANDLE_NONE                           = 0x00000000,
    PSS_HANDLE_HAVE_TYPE                      = 0x00000001,
    PSS_HANDLE_HAVE_NAME                      = 0x00000002,
    PSS_HANDLE_HAVE_BASIC_INFORMATION         = 0x00000004,
    PSS_HANDLE_HAVE_TYPE_SPECIFIC_INFORMATION = 0x00000008,
}
alias PSS_HANDLE_FLAGS = int;

enum : int
{
    PSS_OBJECT_TYPE_UNKNOWN   = 0x00000000,
    PSS_OBJECT_TYPE_PROCESS   = 0x00000001,
    PSS_OBJECT_TYPE_THREAD    = 0x00000002,
    PSS_OBJECT_TYPE_MUTANT    = 0x00000003,
    PSS_OBJECT_TYPE_EVENT     = 0x00000004,
    PSS_OBJECT_TYPE_SECTION   = 0x00000005,
    PSS_OBJECT_TYPE_SEMAPHORE = 0x00000006,
}
alias PSS_OBJECT_TYPE = int;

enum : int
{
    PSS_CAPTURE_NONE                             = 0x00000000,
    PSS_CAPTURE_VA_CLONE                         = 0x00000001,
    PSS_CAPTURE_RESERVED_00000002                = 0x00000002,
    PSS_CAPTURE_HANDLES                          = 0x00000004,
    PSS_CAPTURE_HANDLE_NAME_INFORMATION          = 0x00000008,
    PSS_CAPTURE_HANDLE_BASIC_INFORMATION         = 0x00000010,
    PSS_CAPTURE_HANDLE_TYPE_SPECIFIC_INFORMATION = 0x00000020,
    PSS_CAPTURE_HANDLE_TRACE                     = 0x00000040,
    PSS_CAPTURE_THREADS                          = 0x00000080,
    PSS_CAPTURE_THREAD_CONTEXT                   = 0x00000100,
    PSS_CAPTURE_THREAD_CONTEXT_EXTENDED          = 0x00000200,
    PSS_CAPTURE_RESERVED_00000400                = 0x00000400,
    PSS_CAPTURE_VA_SPACE                         = 0x00000800,
    PSS_CAPTURE_VA_SPACE_SECTION_INFORMATION     = 0x00001000,
    PSS_CAPTURE_IPT_TRACE                        = 0x00002000,
    PSS_CAPTURE_RESERVED_00004000                = 0x00004000,
    PSS_CREATE_BREAKAWAY_OPTIONAL                = 0x04000000,
    PSS_CREATE_BREAKAWAY                         = 0x08000000,
    PSS_CREATE_FORCE_BREAKAWAY                   = 0x10000000,
    PSS_CREATE_USE_VM_ALLOCATIONS                = 0x20000000,
    PSS_CREATE_MEASURE_PERFORMANCE               = 0x40000000,
    PSS_CREATE_RELEASE_SECTION                   = 0x80000000,
}
alias PSS_CAPTURE_FLAGS = int;

enum : int
{
    PSS_QUERY_PROCESS_INFORMATION         = 0x00000000,
    PSS_QUERY_VA_CLONE_INFORMATION        = 0x00000001,
    PSS_QUERY_AUXILIARY_PAGES_INFORMATION = 0x00000002,
    PSS_QUERY_VA_SPACE_INFORMATION        = 0x00000003,
    PSS_QUERY_HANDLE_INFORMATION          = 0x00000004,
    PSS_QUERY_THREAD_INFORMATION          = 0x00000005,
    PSS_QUERY_HANDLE_TRACE_INFORMATION    = 0x00000006,
    PSS_QUERY_PERFORMANCE_COUNTERS        = 0x00000007,
}
alias PSS_QUERY_INFORMATION_CLASS = int;

enum : int
{
    PSS_WALK_AUXILIARY_PAGES = 0x00000000,
    PSS_WALK_VA_SPACE        = 0x00000001,
    PSS_WALK_HANDLES         = 0x00000002,
    PSS_WALK_THREADS         = 0x00000003,
}
alias PSS_WALK_INFORMATION_CLASS = int;

enum : int
{
    PSS_DUPLICATE_NONE         = 0x00000000,
    PSS_DUPLICATE_CLOSE_SOURCE = 0x00000001,
}
alias PSS_DUPLICATE_FLAGS = int;

enum : int
{
    PSS_PROCESS_FLAGS_NONE        = 0x00000000,
    PSS_PROCESS_FLAGS_PROTECTED   = 0x00000001,
    PSS_PROCESS_FLAGS_WOW64       = 0x00000002,
    PSS_PROCESS_FLAGS_RESERVED_03 = 0x00000004,
    PSS_PROCESS_FLAGS_RESERVED_04 = 0x00000008,
    PSS_PROCESS_FLAGS_FROZEN      = 0x00000010,
}
alias PSS_PROCESS_FLAGS = int;

enum : int
{
    PSS_THREAD_FLAGS_NONE       = 0x00000000,
    PSS_THREAD_FLAGS_TERMINATED = 0x00000001,
}
alias PSS_THREAD_FLAGS = int;

// Structs


struct HPSS__
{
    int unused;
}

struct HPSSWALK__
{
    int unused;
}

struct PSS_PROCESS_INFORMATION
{
    uint              ExitStatus;
    void*             PebBaseAddress;
    size_t            AffinityMask;
    int               BasePriority;
    uint              ProcessId;
    uint              ParentProcessId;
    PSS_PROCESS_FLAGS Flags;
    FILETIME          CreateTime;
    FILETIME          ExitTime;
    FILETIME          KernelTime;
    FILETIME          UserTime;
    uint              PriorityClass;
    size_t            PeakVirtualSize;
    size_t            VirtualSize;
    uint              PageFaultCount;
    size_t            PeakWorkingSetSize;
    size_t            WorkingSetSize;
    size_t            QuotaPeakPagedPoolUsage;
    size_t            QuotaPagedPoolUsage;
    size_t            QuotaPeakNonPagedPoolUsage;
    size_t            QuotaNonPagedPoolUsage;
    size_t            PagefileUsage;
    size_t            PeakPagefileUsage;
    size_t            PrivateUsage;
    uint              ExecuteFlags;
    ushort[260]       ImageFileName;
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
    uint   Size;
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
    void*    Address;
    MEMORY_BASIC_INFORMATION BasicInformation;
    FILETIME CaptureTime;
    void*    PageContents;
    uint     PageSize;
}

struct PSS_VA_SPACE_ENTRY
{
    void*          BaseAddress;
    void*          AllocationBase;
    uint           AllocationProtect;
    size_t         RegionSize;
    uint           State;
    uint           Protect;
    uint           Type;
    uint           TimeDateStamp;
    uint           SizeOfImage;
    void*          ImageBase;
    uint           CheckSum;
    ushort         MappedFileNameLength;
    const(ushort)* MappedFileName;
}

struct PSS_HANDLE_ENTRY
{
    HANDLE           Handle;
    PSS_HANDLE_FLAGS Flags;
    PSS_OBJECT_TYPE  ObjectType;
    FILETIME         CaptureTime;
    uint             Attributes;
    uint             GrantedAccess;
    uint             HandleCount;
    uint             PointerCount;
    uint             PagedPoolCharge;
    uint             NonPagedPoolCharge;
    FILETIME         CreationTime;
    ushort           TypeNameLength;
    const(ushort)*   TypeName;
    ushort           ObjectNameLength;
    const(ushort)*   ObjectName;
    union TypeSpecificInformation
    {
        struct Process
        {
            uint   ExitStatus;
            void*  PebBaseAddress;
            size_t AffinityMask;
            int    BasePriority;
            uint   ProcessId;
            uint   ParentProcessId;
            uint   Flags;
        }
        struct Thread
        {
            uint   ExitStatus;
            void*  TebBaseAddress;
            uint   ProcessId;
            uint   ThreadId;
            size_t AffinityMask;
            int    Priority;
            int    BasePriority;
            void*  Win32StartAddress;
        }
        struct Mutant
        {
            int  CurrentCount;
            BOOL Abandoned;
            uint OwnerProcessId;
            uint OwnerThreadId;
        }
        struct Event
        {
            BOOL ManualReset;
            BOOL Signaled;
        }
        struct Section
        {
            void*         BaseAddress;
            uint          AllocationAttributes;
            LARGE_INTEGER MaximumSize;
        }
        struct Semaphore
        {
            int CurrentCount;
            int MaximumCount;
        }
    }
}

struct PSS_THREAD_ENTRY
{
    uint             ExitStatus;
    void*            TebBaseAddress;
    uint             ProcessId;
    uint             ThreadId;
    size_t           AffinityMask;
    int              Priority;
    int              BasePriority;
    void*            LastSyscallFirstArgument;
    ushort           LastSyscallNumber;
    FILETIME         CreateTime;
    FILETIME         ExitTime;
    FILETIME         KernelTime;
    FILETIME         UserTime;
    void*            Win32StartAddress;
    FILETIME         CaptureTime;
    PSS_THREAD_FLAGS Flags;
    ushort           SuspendCount;
    ushort           SizeOfContextRecord;
    CONTEXT*         ContextRecord;
}

struct PSS_ALLOCATOR
{
    void*     Context;
    ptrdiff_t AllocRoutine;
    ptrdiff_t FreeRoutine;
}

// Functions

@DllImport("KERNEL32")
uint PssCaptureSnapshot(HANDLE ProcessHandle, PSS_CAPTURE_FLAGS CaptureFlags, uint ThreadContextFlags, 
                        HPSS__** SnapshotHandle);

@DllImport("KERNEL32")
uint PssFreeSnapshot(HANDLE ProcessHandle, HPSS__* SnapshotHandle);

@DllImport("KERNEL32")
uint PssQuerySnapshot(HPSS__* SnapshotHandle, PSS_QUERY_INFORMATION_CLASS InformationClass, char* Buffer, 
                      uint BufferLength);

@DllImport("KERNEL32")
uint PssWalkSnapshot(HPSS__* SnapshotHandle, PSS_WALK_INFORMATION_CLASS InformationClass, 
                     HPSSWALK__* WalkMarkerHandle, char* Buffer, uint BufferLength);

@DllImport("KERNEL32")
uint PssDuplicateSnapshot(HANDLE SourceProcessHandle, HPSS__* SnapshotHandle, HANDLE TargetProcessHandle, 
                          HPSS__** TargetSnapshotHandle, PSS_DUPLICATE_FLAGS Flags);

@DllImport("KERNEL32")
uint PssWalkMarkerCreate(const(PSS_ALLOCATOR)* Allocator, HPSSWALK__** WalkMarkerHandle);

@DllImport("KERNEL32")
uint PssWalkMarkerFree(HPSSWALK__* WalkMarkerHandle);

@DllImport("KERNEL32")
uint PssWalkMarkerGetPosition(HPSSWALK__* WalkMarkerHandle, size_t* Position);

@DllImport("KERNEL32")
uint PssWalkMarkerSetPosition(HPSSWALK__* WalkMarkerHandle, size_t Position);

@DllImport("KERNEL32")
uint PssWalkMarkerSeekToBeginning(HPSSWALK__* WalkMarkerHandle);


