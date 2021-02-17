// Written in the D programming language.

module windows.processsnapshotting;

public import windows.core;
public import windows.dbg : CONTEXT;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, MEMORY_BASIC_INFORMATION;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


///Flags to specify what parts of a PSS_HANDLE_ENTRY structure are valid.
alias PSS_HANDLE_FLAGS = int;
enum : int
{
    ///No parts specified.
    PSS_HANDLE_NONE                           = 0x00000000,
    ///The <b>ObjectType</b> member is valid.
    PSS_HANDLE_HAVE_TYPE                      = 0x00000001,
    ///The <b>ObjectName</b> member is valid.
    PSS_HANDLE_HAVE_NAME                      = 0x00000002,
    ///The <b>Attributes</b>, <b>GrantedAccess</b>, <b>HandleCount</b>, <b>PointerCount</b>, <b>PagedPoolCharge</b>, and
    ///<b>NonPagedPoolCharge</b> members are valid.
    PSS_HANDLE_HAVE_BASIC_INFORMATION         = 0x00000004,
    ///The <b>TypeSpecificInformation</b> member is valid (either <b>Process</b>, <b>Thread</b>, <b>Mutant</b>,
    ///<b>Event</b> or <b>Section</b>).
    PSS_HANDLE_HAVE_TYPE_SPECIFIC_INFORMATION = 0x00000008,
}

///Specifies the object type in a PSS_HANDLE_ENTRY structure.
alias PSS_OBJECT_TYPE = int;
enum : int
{
    ///The object type is either unknown or unsupported.
    PSS_OBJECT_TYPE_UNKNOWN   = 0x00000000,
    ///The object is a process.
    PSS_OBJECT_TYPE_PROCESS   = 0x00000001,
    ///The object is a thread.
    PSS_OBJECT_TYPE_THREAD    = 0x00000002,
    ///The object is a mutant/mutex.
    PSS_OBJECT_TYPE_MUTANT    = 0x00000003,
    ///The object is an event.
    PSS_OBJECT_TYPE_EVENT     = 0x00000004,
    ///The object is a file-mapping object.
    PSS_OBJECT_TYPE_SECTION   = 0x00000005,
    PSS_OBJECT_TYPE_SEMAPHORE = 0x00000006,
}

///Flags that specify what PssCaptureSnapshot captures.
alias PSS_CAPTURE_FLAGS = int;
enum : int
{
    ///Capture nothing.
    PSS_CAPTURE_NONE                             = 0x00000000,
    ///Capture a snapshot of all cloneable pages in the process. The clone includes all <b>MEM_PRIVATE</b> regions, as
    ///well as all sections (<b>MEM_MAPPED</b> and <b>MEM_IMAGE</b>) that are shareable. All Win32 sections created via
    ///CreateFileMapping are shareable.
    PSS_CAPTURE_VA_CLONE                         = 0x00000001,
    ///(Do not use.)
    PSS_CAPTURE_RESERVED_00000002                = 0x00000002,
    ///Capture the handle table (handle values only).
    PSS_CAPTURE_HANDLES                          = 0x00000004,
    ///Capture name information for each handle.
    PSS_CAPTURE_HANDLE_NAME_INFORMATION          = 0x00000008,
    ///Capture basic handle information such as <b>HandleCount</b>, <b>PointerCount</b>, <b>GrantedAccess</b>, etc.
    PSS_CAPTURE_HANDLE_BASIC_INFORMATION         = 0x00000010,
    ///Capture type-specific information for supported object types: <b>Process</b>, <b>Thread</b>, <b>Event</b>,
    ///<b>Mutant</b>, <b>Section.</b>
    PSS_CAPTURE_HANDLE_TYPE_SPECIFIC_INFORMATION = 0x00000020,
    ///Capture the handle tracing table.
    PSS_CAPTURE_HANDLE_TRACE                     = 0x00000040,
    ///Capture thread information (IDs only).
    PSS_CAPTURE_THREADS                          = 0x00000080,
    ///Capture the context for each thread.
    PSS_CAPTURE_THREAD_CONTEXT                   = 0x00000100,
    ///Capture extended context for each thread (e.g. <b>CONTEXT_XSTATE</b>).
    PSS_CAPTURE_THREAD_CONTEXT_EXTENDED          = 0x00000200,
    ///(Do not use.)
    PSS_CAPTURE_RESERVED_00000400                = 0x00000400,
    ///Capture a snapshot of the virtual address space. The VA space is captured as an array of MEMORY_BASIC_INFORMATION
    ///structures. This flag does not capture the contents of the pages.
    PSS_CAPTURE_VA_SPACE                         = 0x00000800,
    ///For <b>MEM_IMAGE</b> and <b>MEM_MAPPED</b> regions, dumps the path to the file backing the sections (identical to
    ///what GetMappedFileName returns). For <b>MEM_IMAGE</b> regions, also dumps: <ul> <li>
    ///<b>IMAGE_NT_HEADERS.FileHeader.TimeDateStamp</b> </li> <li> <b>IMAGE_NT_HEADERS.OptionalHeader.SizeOfImage</b>
    ///</li> <li> <b>IMAGE_NT_HEADERS.OptionalHeader.ImageBase</b> </li> <li>
    ///<b>IMAGE_NT_HEADERS.OptionalHeader.CheckSum</b> </li> </ul> The PROCESS_VM_READ access right is required on the
    ///process handle. <div class="alert"><b>Warning</b> This option is only valid when <b>PSS_CAPTURE_VA_SPACE</b> is
    ///specified. </div> <div> </div>
    PSS_CAPTURE_VA_SPACE_SECTION_INFORMATION     = 0x00001000,
    PSS_CAPTURE_IPT_TRACE                        = 0x00002000,
    PSS_CAPTURE_RESERVED_00004000                = 0x00004000,
    ///The breakaway is optional. If the clone process fails to create as a breakaway, then it is created still inside
    ///the job. This flag must be specified in combination with either <b>PSS_CREATE_FORCE_BREAKAWAY</b> and/or
    ///<b>PSS_CREATE_BREAKAWAY</b>.
    PSS_CREATE_BREAKAWAY_OPTIONAL                = 0x04000000,
    ///The clone is broken away from the parent process' job. This is equivalent to CreateProcess flag
    ///<b>CREATE_BREAKAWAY_FROM_JOB</b>.
    PSS_CREATE_BREAKAWAY                         = 0x08000000,
    ///The clone is forcefully broken away the parent process's job. This is only allowed for Tcb-privileged callers.
    PSS_CREATE_FORCE_BREAKAWAY                   = 0x10000000,
    ///The facility should not use the process heap for any persistent or transient allocations. The use of the heap may
    ///be undesirable in certain contexts such as creation of snapshots in the exception reporting path (where the heap
    ///may be corrupted).
    PSS_CREATE_USE_VM_ALLOCATIONS                = 0x20000000,
    ///Measure performance of the facility. Performance counters can be retrieved via PssQuerySnapshot with the
    ///<b>PSS_QUERY_PERFORMANCE_COUNTERS</b> information class of PSS_QUERY_INFORMATION_CLASS.
    PSS_CREATE_MEASURE_PERFORMANCE               = 0x40000000,
    ///The virtual address (VA) clone process does not hold a reference to the underlying image. This will cause
    ///functions such as QueryFullProcessImageName to fail on the VA clone process. <div class="alert"><b>Important</b>
    ///<p class="note"> This flag has no effect unless <b>PSS_CAPTURE_VA_CLONE</b> is specified. </div> <div> </div>
    PSS_CREATE_RELEASE_SECTION                   = 0x80000000,
}

///Specifies what information PssQuerySnapshot function returns.
alias PSS_QUERY_INFORMATION_CLASS = int;
enum : int
{
    ///Returns a PSS_PROCESS_INFORMATION structure, with information about the original process.
    PSS_QUERY_PROCESS_INFORMATION         = 0x00000000,
    ///Returns a PSS_VA_CLONE_INFORMATION structure, with a handle to the VA clone.
    PSS_QUERY_VA_CLONE_INFORMATION        = 0x00000001,
    ///Returns a PSS_AUXILIARY_PAGES_INFORMATION structure, which contains the count of auxiliary pages captured.
    PSS_QUERY_AUXILIARY_PAGES_INFORMATION = 0x00000002,
    ///Returns a PSS_VA_SPACE_INFORMATION structure, which contains the count of regions captured.
    PSS_QUERY_VA_SPACE_INFORMATION        = 0x00000003,
    ///Returns a PSS_HANDLE_INFORMATION structure, which contains the count of handles captured.
    PSS_QUERY_HANDLE_INFORMATION          = 0x00000004,
    ///Returns a PSS_THREAD_INFORMATION structure, which contains the count of threads captured.
    PSS_QUERY_THREAD_INFORMATION          = 0x00000005,
    ///Returns a PSS_HANDLE_TRACE_INFORMATION structure, which contains a handle to the handle trace section, and its
    ///size.
    PSS_QUERY_HANDLE_TRACE_INFORMATION    = 0x00000006,
    ///Returns a PSS_PERFORMANCE_COUNTERS structure, which contains various performance counters.
    PSS_QUERY_PERFORMANCE_COUNTERS        = 0x00000007,
}

///Specifies what information the PssWalkSnapshot function returns.
alias PSS_WALK_INFORMATION_CLASS = int;
enum : int
{
    ///Returns a PSS_AUXILIARY_PAGE_ENTRY structure, which contains the address, page attributes and contents of an
    ///auxiliary copied page.
    PSS_WALK_AUXILIARY_PAGES = 0x00000000,
    ///Returns a PSS_VA_SPACE_ENTRY structure, which contains the MEMORY_BASIC_INFORMATION structure for every distinct
    ///VA region.
    PSS_WALK_VA_SPACE        = 0x00000001,
    ///Returns a PSS_HANDLE_ENTRY structure, with information specifying the handle value, its type name, object name
    ///(if captured), basic information (if captured), and type-specific information (if captured).
    PSS_WALK_HANDLES         = 0x00000002,
    ///Returns a PSS_THREAD_ENTRY structure, with basic information about the thread, as well as its termination state,
    ///suspend count and Win32 start address.
    PSS_WALK_THREADS         = 0x00000003,
}

///Duplication flags for use by PssDuplicateSnapshot.
alias PSS_DUPLICATE_FLAGS = int;
enum : int
{
    ///No flag.
    PSS_DUPLICATE_NONE         = 0x00000000,
    ///Free the source handle. This will only succeed if you set the <b>PSS_CREATE_USE_VM_ALLOCATIONS</b> flag when you
    ///called PssCaptureSnapshot to create the snapshot and handle. The handle will be freed even if duplication fails.
    ///The close operation does not protect against concurrent access to the same descriptor.
    PSS_DUPLICATE_CLOSE_SOURCE = 0x00000001,
}

///Flags that describe a process.
alias PSS_PROCESS_FLAGS = int;
enum : int
{
    ///No flag.
    PSS_PROCESS_FLAGS_NONE        = 0x00000000,
    ///The process is protected.
    PSS_PROCESS_FLAGS_PROTECTED   = 0x00000001,
    ///The process is a 32-bit process running on a 64-bit native OS.
    PSS_PROCESS_FLAGS_WOW64       = 0x00000002,
    ///Undefined.
    PSS_PROCESS_FLAGS_RESERVED_03 = 0x00000004,
    ///Undefined.
    PSS_PROCESS_FLAGS_RESERVED_04 = 0x00000008,
    ///The process is frozen; for example, a debugger is attached and broken into the process or a Store process is
    ///suspended by a lifetime management service.
    PSS_PROCESS_FLAGS_FROZEN      = 0x00000010,
}

///Flags that describe a thread.
alias PSS_THREAD_FLAGS = int;
enum : int
{
    ///No flag.
    PSS_THREAD_FLAGS_NONE       = 0x00000000,
    ///The thread terminated.
    PSS_THREAD_FLAGS_TERMINATED = 0x00000001,
}

// Structs


struct HPSS__
{
    int unused;
}

struct HPSSWALK__
{
    int unused;
}

///Holds process information returned by PssQuerySnapshot.
struct PSS_PROCESS_INFORMATION
{
    ///The exit code of the process. If the process has not exited, this is set to <b>STILL_ACTIVE</b> (259).
    uint              ExitStatus;
    ///The address to the process environment block (PEB). Reserved for use by the operating system.
    void*             PebBaseAddress;
    ///The affinity mask of the process.
    size_t            AffinityMask;
    ///The base priority level of the process.
    int               BasePriority;
    ///The process ID.
    uint              ProcessId;
    ///The parent process ID.
    uint              ParentProcessId;
    ///Flags about the process. For more information, see PSS_PROCESS_FLAGS.
    PSS_PROCESS_FLAGS Flags;
    ///The time the process was created. For more information, see FILETIME.
    FILETIME          CreateTime;
    ///If the process exited, the time of the exit. For more information, see FILETIME.
    FILETIME          ExitTime;
    ///The amount of time the process spent executing in kernel-mode. For more information, see FILETIME.
    FILETIME          KernelTime;
    ///The amount of time the process spent executing in user-mode. For more information, see FILETIME.
    FILETIME          UserTime;
    ///The priority class.
    uint              PriorityClass;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            PeakVirtualSize;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            VirtualSize;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    uint              PageFaultCount;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            PeakWorkingSetSize;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            WorkingSetSize;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            QuotaPeakPagedPoolUsage;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            QuotaPagedPoolUsage;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            QuotaPeakNonPagedPoolUsage;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            QuotaNonPagedPoolUsage;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            PagefileUsage;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            PeakPagefileUsage;
    ///A memory usage counter. See the GetProcessMemoryInfo function for more information.
    size_t            PrivateUsage;
    ///Reserved for use by the operating system.
    uint              ExecuteFlags;
    ///The full path to the process executable. If the path exceeds the allocated buffer size, it is truncated.
    ushort[260]       ImageFileName;
}

///Holds virtual address (VA) clone information returned by PssQuerySnapshot.
struct PSS_VA_CLONE_INFORMATION
{
    ///A handle to the VA clone process.
    HANDLE VaCloneHandle;
}

///Holds auxiliary pages information returned by PssQuerySnapshot.
struct PSS_AUXILIARY_PAGES_INFORMATION
{
    ///The count of auxiliary pages captured.
    uint AuxPagesCaptured;
}

///Holds virtual address (VA) space information returned by PssQuerySnapshot.
struct PSS_VA_SPACE_INFORMATION
{
    ///The count of VA regions captured.
    uint RegionCount;
}

///Holds handle information returned by PssQuerySnapshot.
struct PSS_HANDLE_INFORMATION
{
    ///The count of handles captured.
    uint HandlesCaptured;
}

///Holds thread information returned by PssQuerySnapshot.
struct PSS_THREAD_INFORMATION
{
    ///The count of threads in the snapshot.
    uint ThreadsCaptured;
    ///The length of the <b>CONTEXT</b> record captured, in bytes.
    uint ContextLength;
}

///Holds handle trace information returned by PssQuerySnapshot.
struct PSS_HANDLE_TRACE_INFORMATION
{
    ///A handle to a section containing the handle trace information.
    HANDLE SectionHandle;
    ///The size of the handle trace section, in bytes.
    uint   Size;
}

///Holds performance counters returned by PssQuerySnapshot.
struct PSS_PERFORMANCE_COUNTERS
{
    ///The count of clock cycles spent for capture.
    ulong TotalCycleCount;
    ///The count of FILETIME units spent for capture.
    ulong TotalWallClockPeriod;
    ///The count of clock cycles spent for the capture of the VA clone.
    ulong VaCloneCycleCount;
    ///The count of FILETIME units spent for the capture of the VA clone.
    ulong VaCloneWallClockPeriod;
    ///The count of clock cycles spent for the capture of VA space information.
    ulong VaSpaceCycleCount;
    ///The count of FILETIME units spent for the capture VA space information.
    ulong VaSpaceWallClockPeriod;
    ///The count of clock cycles spent for the capture of auxiliary page information.
    ulong AuxPagesCycleCount;
    ///The count of FILETIME units spent for the capture of auxiliary page information.
    ulong AuxPagesWallClockPeriod;
    ///The count of clock cycles spent for the capture of handle information.
    ulong HandlesCycleCount;
    ///The count of FILETIME units spent for the capture of handle information.
    ulong HandlesWallClockPeriod;
    ///The count of clock cycles spent for the capture of thread information.
    ulong ThreadsCycleCount;
    ///The count of FILETIME units spent for the capture of thread information.
    ulong ThreadsWallClockPeriod;
}

///Holds auxiliary page entry information returned by PssWalkSnapshot.
struct PSS_AUXILIARY_PAGE_ENTRY
{
    ///The address of the captured auxiliary page, in the context of the captured process.
    void*    Address;
    ///Basic information about the captured page. See MEMORY_BASIC_INFORMATION for more information.
    MEMORY_BASIC_INFORMATION BasicInformation;
    ///The capture time of the page. For more information, see FILETIME.
    FILETIME CaptureTime;
    ///A pointer to the contents of the captured page, in the context of the current process. This member may be
    ///<b>NULL</b> if page contents were not captured. The pointer is valid for the lifetime of the walk marker passed
    ///to PssWalkSnapshot.
    void*    PageContents;
    ///The size of the page contents that <b>PageContents</b> points to, in bytes.
    uint     PageSize;
}

///Holds the MEMORY_BASIC_INFORMATION returned by PssWalkSnapshot for a virtual address (VA) region.
struct PSS_VA_SPACE_ENTRY
{
    ///Information about the VA region. For more information, see MEMORY_BASIC_INFORMATION.
    void*          BaseAddress;
    ///Information about the VA region. For more information, see MEMORY_BASIC_INFORMATION.
    void*          AllocationBase;
    ///Information about the VA region. For more information, see MEMORY_BASIC_INFORMATION.
    uint           AllocationProtect;
    ///Information about the VA region. For more information, see MEMORY_BASIC_INFORMATION.
    size_t         RegionSize;
    ///Information about the VA region. For more information, see MEMORY_BASIC_INFORMATION.
    uint           State;
    ///Information about the VA region. For more information, see MEMORY_BASIC_INFORMATION.
    uint           Protect;
    ///Information about the VA region. For more information, see MEMORY_BASIC_INFORMATION.
    uint           Type;
    ///If section information was captured and the region is an executable image (<b>MEM_IMAGE</b>), this is the
    ///<b>TimeDateStamp</b> value from the Portable Executable (PE) header which describes the image. It is the low 32
    ///bits of the number of seconds since 00:00 January 1, 1970 (a C run-time time_t value), that indicates when the
    ///file was created.
    uint           TimeDateStamp;
    ///If section information was captured and the region is an executable image (<b>MEM_IMAGE</b>), this is the
    ///<b>SizeOfImage</b> value from the Portable Executable (PE) header which describes the image. It is the size (in
    ///bytes) of the image, including all headers, as the image is loaded in memory.
    uint           SizeOfImage;
    ///If section information was captured and the region is an executable image (<b>MEM_IMAGE</b>), this is the
    ///<b>ImageBase</b> value from the Portable Executable (PE) header which describes the image. It is the preferred
    ///address of the first byte of the image when loaded into memory.
    void*          ImageBase;
    ///If section information was captured and the region is an executable image (<b>MEM_IMAGE</b>), this is the
    ///<b>CheckSum</b> value from the Portable Executable (PE) header which describes the image. It is the image file
    ///checksum.
    uint           CheckSum;
    ///The length of the mapped file name buffer, in bytes.
    ushort         MappedFileNameLength;
    ///If section information was captured, this is the file path backing the section (if any). The path may be in NT
    ///namespace. The string may not be terminated by a <b>NULL</b> character. The pointer is valid for the lifetime of
    ///the walk marker passed to PssWalkSnapshot.
    const(ushort)* MappedFileName;
}

///Holds information about a handle returned by PssWalkSnapshot.
struct PSS_HANDLE_ENTRY
{
    ///The handle value.
    HANDLE           Handle;
    ///Flags that indicate what parts of this structure are valid. For more information, see PSS_HANDLE_FLAGS.
    PSS_HANDLE_FLAGS Flags;
    ///The type of the object that the handle references. For more information, see PSS_OBJECT_TYPE.
    PSS_OBJECT_TYPE  ObjectType;
    ///The capture time of this information. For more information, see FILETIME.
    FILETIME         CaptureTime;
    ///Attributes.
    uint             Attributes;
    ///Reserved for use by the operating system.
    uint             GrantedAccess;
    ///Reserved for use by the operating system.
    uint             HandleCount;
    ///Reserved for use by the operating system.
    uint             PointerCount;
    ///Reserved for use by the operating system.
    uint             PagedPoolCharge;
    ///Reserved for use by the operating system.
    uint             NonPagedPoolCharge;
    ///Reserved for use by the operating system.
    FILETIME         CreationTime;
    ///The length of <b>TypeName</b>, in bytes.
    ushort           TypeNameLength;
    ///The type name of the object referenced by this handle. The buffer may not terminated by a <b>NULL</b> character.
    ///The pointer is valid for the lifetime of the walk marker passed to PssWalkSnapshot.
    const(ushort)*   TypeName;
    ///The length of <b>ObjectName</b>, in bytes.
    ushort           ObjectNameLength;
    ///Specifies the name of the object referenced by this handle. The buffer may not terminated by a <b>NULL</b>
    ///character. The pointer is valid for the lifetime of the walk marker passed to PssWalkSnapshot.
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

///Holds thread information returned by PssWalkSnapshot<b>PssWalkSnapshot</b>.
struct PSS_THREAD_ENTRY
{
    ///The exit code of the process. If the process has not exited, this is set to <b>STILL_ACTIVE</b> (259).
    uint             ExitStatus;
    ///The address of the thread environment block (TEB). Reserved for use by the operating system.
    void*            TebBaseAddress;
    ///The process ID.
    uint             ProcessId;
    ///The thread ID.
    uint             ThreadId;
    ///The affinity mask of the process.
    size_t           AffinityMask;
    ///The thread’s dynamic priority level.
    int              Priority;
    ///The base priority level of the process.
    int              BasePriority;
    ///Reserved for use by the operating system.
    void*            LastSyscallFirstArgument;
    ///Reserved for use by the operating system.
    ushort           LastSyscallNumber;
    ///The time the thread was created. For more information, see FILETIME.
    FILETIME         CreateTime;
    ///If the thread exited, the time of the exit. For more information, see FILETIME.
    FILETIME         ExitTime;
    ///The amount of time the thread spent executing in kernel mode. For more information, see FILETIME.
    FILETIME         KernelTime;
    ///The amount of time the thread spent executing in user mode. For more information, see FILETIME.
    FILETIME         UserTime;
    ///A pointer to the thread procedure for thread.
    void*            Win32StartAddress;
    ///The capture time of this thread. For more information, see FILETIME.
    FILETIME         CaptureTime;
    ///Flags about the thread. For more information, see PSS_THREAD_FLAGS.
    PSS_THREAD_FLAGS Flags;
    ///The count of times the thread suspended.
    ushort           SuspendCount;
    ///The size of <i>ContextRecord</i>, in bytes.
    ushort           SizeOfContextRecord;
    ///A pointer to the context record if thread context information was captured. The pointer is valid for the lifetime
    ///of the walk marker passed to PssWalkSnapshot.
    CONTEXT*         ContextRecord;
}

///Specifies custom functions which the Process Snapshotting functions use to allocate and free the internal walk marker
///structures.
struct PSS_ALLOCATOR
{
    ///An arbitrary pointer-sized value that the Process Snapshotting functions pass to <b>AllocRoutine</b> and
    ///<b>FreeRoutine</b>.
    void*     Context;
    ///A pointer to a WINAPI-calling convention function that takes two parameters. It returns a pointer to the block of
    ///memory that it allocates, or <b>NULL</b> if allocation fails.
    ptrdiff_t AllocRoutine;
    ///A pointer to a WINAPI-calling convention function taking two parameters. It deallocates a block of memory that
    ///<b>AllocRoutine</b> allocated.
    ptrdiff_t FreeRoutine;
}

// Functions

///Captures a snapshot of a target process.
///Params:
///    ProcessHandle = A handle to the target process.
///    CaptureFlags = Flags that specify what to capture. For more information, see PSS_CAPTURE_FLAGS.
///    ThreadContextFlags = The <b>CONTEXT</b> record flags to capture if <i>CaptureFlags</i> specifies thread contexts.
///    SnapshotHandle = A handle to the snapshot that this function captures.
@DllImport("KERNEL32")
uint PssCaptureSnapshot(HANDLE ProcessHandle, PSS_CAPTURE_FLAGS CaptureFlags, uint ThreadContextFlags, 
                        HPSS__** SnapshotHandle);

///Frees a snapshot.
///Params:
///    ProcessHandle = A handle to the process that contains the snapshot. The handle must have <b>PROCESS_VM_READ</b>,
///                    <b>PROCESS_VM_OPERATION</b>, and <b>PROCESS_DUP_HANDLE</b> rights. If the snapshot was captured from the current
///                    process, or duplicated into the current process, then pass in the result of GetCurrentProcess.
///    SnapshotHandle = A handle to the snapshot to free.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> on success or one of the following error codes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt>
///    </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The remote snapshot was not created with
///    <b>PSS_CREATE_USE_VM_ALLOCATIONS</b>. </td> </tr> </table> All error codes are defined in winerror.h. Use
///    FormatMessage with the <b>FORMAT_MESSAGE_FROM_SYSTEM</b> flag to get a message for an error code.
///    
@DllImport("KERNEL32")
uint PssFreeSnapshot(HANDLE ProcessHandle, HPSS__* SnapshotHandle);

///Queries the snapshot.
///Params:
///    SnapshotHandle = A handle to the snapshot to query.
///    InformationClass = An enumerator member that selects what information to query. For more information, see
///                       PSS_QUERY_INFORMATION_CLASS.
///    Buffer = The information that this function provides.
///    BufferLength = The size of <i>Buffer</i>, in bytes.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> on success or one of the following error codes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl>
///    </td> <td width="60%"> The specified buffer length is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The specified
///    information class is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td>
///    <td width="60%"> The requested information is not in the snapshot. </td> </tr> </table> All error codes are
///    defined in winerror.h. Use FormatMessage with the <b>FORMAT_MESSAGE_FROM_SYSTEM</b> flag to get a message for an
///    error code.
///    
@DllImport("KERNEL32")
uint PssQuerySnapshot(HPSS__* SnapshotHandle, PSS_QUERY_INFORMATION_CLASS InformationClass, char* Buffer, 
                      uint BufferLength);

///Returns information from the current walk position and advanced the walk marker to the next position.
///Params:
///    SnapshotHandle = A handle to the snapshot.
///    InformationClass = The type of information to return. For more information, see PSS_WALK_INFORMATION_CLASS.
///    WalkMarkerHandle = A handle to a walk marker. The walk marker indicates the walk position from which data is to be returned.
///                       <b>PssWalkSnapshot</b> advances the walk marker to the next walk position in time order before returning to the
///                       caller.
///    Buffer = The snapshot information that this function returns.
///    BufferLength = The size of <i>Buffer</i>, in bytes.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> on success or one of the following error codes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl>
///    </td> <td width="60%"> The specified buffer length is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The specified
///    information class is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td>
///    <td width="60%"> <i>Buffer</i> is <b>NULL</b>, and there is data at the current position to return. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The walk has
///    completed and there are no more items to return. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The requested information is not in the snapshot.
///    </td> </tr> </table> All error codes are defined in winerror.h. Use FormatMessage with the
///    <b>FORMAT_MESSAGE_FROM_SYSTEM</b> flag to get a message for an error code.
///    
@DllImport("KERNEL32")
uint PssWalkSnapshot(HPSS__* SnapshotHandle, PSS_WALK_INFORMATION_CLASS InformationClass, 
                     HPSSWALK__* WalkMarkerHandle, char* Buffer, uint BufferLength);

///Duplicates a snapshot handle from one process to another.
///Params:
///    SourceProcessHandle = A handle to the source process from which the original snapshot was captured. The handle must have
///                          <b>PROCESS_VM_READ</b> and <b>PROCESS_DUP_HANDLE</b> rights.
///    SnapshotHandle = A handle to the snapshot to duplicate. This handle must be in the context of the source process.
///    TargetProcessHandle = A handle to the target process that receives the duplicate snapshot. The handle must have
///                          <b>PROCESS_VM_OPERATION</b>, <b>PROCESS_VM_WRITE</b>, and <b>PROCESS_DUP_HANDLE</b> rights.
///    TargetSnapshotHandle = A handle to the duplicate snapshot that this function creates, in the context of the target process.
///    Flags = The duplication flags. For more information, see PSS_DUPLICATE_FLAGS.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> on success or the following error code. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The specified handle is invalid. </td> </tr> </table> All error codes are defined in winerror.h.
///    Use FormatMessage with the <b>FORMAT_MESSAGE_FROM_SYSTEM</b> flag to get a message for an error code.
///    
@DllImport("KERNEL32")
uint PssDuplicateSnapshot(HANDLE SourceProcessHandle, HPSS__* SnapshotHandle, HANDLE TargetProcessHandle, 
                          HPSS__** TargetSnapshotHandle, PSS_DUPLICATE_FLAGS Flags);

///Creates a walk marker.
///Params:
///    Allocator = A structure that provides functions to allocate and free memory. If you provide the structure,
///                <b>PssWalkMarkerCreate</b> uses the functions to allocate the internal walk marker structures. Otherwise it uses
///                the default process heap. For more information, see PSS_ALLOCATOR.
///    WalkMarkerHandle = A handle to the walk marker that this function creates.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> on success or the following error code. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> Could not allocate memory for the walk marker. </td> </tr> </table> All error codes are
///    defined in winerror.h. Use FormatMessage with the <b>FORMAT_MESSAGE_FROM_SYSTEM</b> flag to get a message for an
///    error code.
///    
@DllImport("KERNEL32")
uint PssWalkMarkerCreate(const(PSS_ALLOCATOR)* Allocator, HPSSWALK__** WalkMarkerHandle);

///Frees a walk marker created by PssWalkMarkerCreate.
///Params:
///    WalkMarkerHandle = A handle to the walk marker.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> on success. All error codes are defined in winerror.h. Use
///    FormatMessage with the <b>FORMAT_MESSAGE_FROM_SYSTEM</b> flag to get a message for an error code.
///    
@DllImport("KERNEL32")
uint PssWalkMarkerFree(HPSSWALK__* WalkMarkerHandle);

///Returns the current position of a walk marker.
///Params:
///    WalkMarkerHandle = A handle to the walk marker.
///    Position = The walk marker position that this function returns.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> on success. All error codes are defined in winerror.h. Use
///    FormatMessage with the <b>FORMAT_MESSAGE_FROM_SYSTEM</b> flag to get a message for an error code.
///    
@DllImport("KERNEL32")
uint PssWalkMarkerGetPosition(HPSSWALK__* WalkMarkerHandle, size_t* Position);

///Sets the position of a walk marker.
///Params:
///    WalkMarkerHandle = A handle to the walk marker.
///    Position = The position to set. This is a position that the PssWalkMarkerGetPosition function provided.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> on success or one of the following error codes. All error codes are
///    defined in winerror.h. Use FormatMessage with the <b>FORMAT_MESSAGE_FROM_SYSTEM</b> flag to get a message for an
///    error code.
///    
@DllImport("KERNEL32")
uint PssWalkMarkerSetPosition(HPSSWALK__* WalkMarkerHandle, size_t Position);

///Rewinds a walk marker back to the beginning.
///Params:
///    WalkMarkerHandle = A handle to the walk marker.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> on success. All error codes are defined in winerror.h. Use
///    FormatMessage with the <b>FORMAT_MESSAGE_FROM_SYSTEM</b> flag to get a message for an error code.
///    
@DllImport("KERNEL32")
uint PssWalkMarkerSeekToBeginning(HPSSWALK__* WalkMarkerHandle);


