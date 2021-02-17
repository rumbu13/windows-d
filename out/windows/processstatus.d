// Written in the D programming language.

module windows.processstatus;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Callbacks

///An application-defined callback function used with the EnumPageFiles function. The <b>PENUM_PAGE_FILE_CALLBACK</b>
///type defines a pointer to this callback function. <b>EnumPageFilesProc</b> is a placeholder for the
///application-defined function name.
///Params:
///    pContext = The user-defined data passed from EnumPageFiles.
///    pPageFileInfo = A pointer to an ENUM_PAGE_FILE_INFORMATION structure.
///    lpFilename = The name of the pagefile.
///Returns:
///    To continue enumeration, the callback function must return TRUE. To stop enumeration, the callback function must
///    return FALSE.
///    
alias PENUM_PAGE_FILE_CALLBACKW = BOOL function(void* pContext, ENUM_PAGE_FILE_INFORMATION* pPageFileInfo, 
                                                const(wchar)* lpFilename);
///An application-defined callback function used with the EnumPageFiles function. The <b>PENUM_PAGE_FILE_CALLBACK</b>
///type defines a pointer to this callback function. <b>EnumPageFilesProc</b> is a placeholder for the
///application-defined function name.
///Params:
///    pContext = The user-defined data passed from EnumPageFiles.
///    pPageFileInfo = A pointer to an ENUM_PAGE_FILE_INFORMATION structure.
///    lpFilename = The name of the pagefile.
///Returns:
///    To continue enumeration, the callback function must return TRUE. To stop enumeration, the callback function must
///    return FALSE.
///    
alias PENUM_PAGE_FILE_CALLBACKA = BOOL function(void* pContext, ENUM_PAGE_FILE_INFORMATION* pPageFileInfo, 
                                                const(char)* lpFilename);

// Structs


///Contains the module load address, size, and entry point.
struct MODULEINFO
{
    ///The load address of the module.
    void* lpBaseOfDll;
    ///The size of the linear space that the module occupies, in bytes.
    uint  SizeOfImage;
    ///The entry point of the module.
    void* EntryPoint;
}

///Contains working set information for a page.
union PSAPI_WORKING_SET_BLOCK
{
    ///The working set information. See the description of the structure members for information about the layout of
    ///this variable.
    size_t Flags;
    struct
    {
        size_t _bitfield95;
    }
}

///Contains working set information for a process.
struct PSAPI_WORKING_SET_INFORMATION
{
    ///The number of entries in the <b>WorkingSetInfo</b> array.
    size_t NumberOfEntries;
    ///An array of PSAPI_WORKING_SET_BLOCK elements, one for each page in the process working set.
    PSAPI_WORKING_SET_BLOCK[1] WorkingSetInfo;
}

///Contains extended working set information for a page.
union PSAPI_WORKING_SET_EX_BLOCK
{
    ///The working set information. See the description of the structure members for information about the layout of
    ///this variable.
    size_t Flags;
    union
    {
        struct
        {
            size_t _bitfield96;
        }
        struct Invalid
        {
            size_t _bitfield97;
        }
    }
}

///Contains extended working set information for a process.
struct PSAPI_WORKING_SET_EX_INFORMATION
{
    ///The virtual address.
    void* VirtualAddress;
    ///A PSAPI_WORKING_SET_EX_BLOCK union that indicates the attributes of the page at <b>VirtualAddress</b>.
    PSAPI_WORKING_SET_EX_BLOCK VirtualAttributes;
}

///Contains information about a page added to a process working set.
struct PSAPI_WS_WATCH_INFORMATION
{
    ///A pointer to the instruction that caused the page fault.
    void* FaultingPc;
    ///A pointer to the page that was added to the working set.
    void* FaultingVa;
}

///Contains extended information about a page added to a process working set.
struct PSAPI_WS_WATCH_INFORMATION_EX
{
    ///A PSAPI_WS_WATCH_INFORMATION structure.
    PSAPI_WS_WATCH_INFORMATION BasicInfo;
    ///The identifier of the thread that caused the page fault.
    size_t FaultingThreadId;
    ///This member is reserved for future use.
    size_t Flags;
}

///Contains the memory statistics for a process.
struct PROCESS_MEMORY_COUNTERS
{
    ///The size of the structure, in bytes.
    uint   cb;
    ///The number of page faults.
    uint   PageFaultCount;
    ///The peak working set size, in bytes.
    size_t PeakWorkingSetSize;
    ///The current working set size, in bytes.
    size_t WorkingSetSize;
    ///The peak paged pool usage, in bytes.
    size_t QuotaPeakPagedPoolUsage;
    ///The current paged pool usage, in bytes.
    size_t QuotaPagedPoolUsage;
    ///The peak nonpaged pool usage, in bytes.
    size_t QuotaPeakNonPagedPoolUsage;
    ///The current nonpaged pool usage, in bytes.
    size_t QuotaNonPagedPoolUsage;
    ///The Commit Charge value in bytes for this process. Commit Charge is the total amount of memory that the memory
    ///manager has committed for a running process.
    size_t PagefileUsage;
    ///The peak value in bytes of the Commit Charge during the lifetime of this process.
    size_t PeakPagefileUsage;
}

///Contains extended memory statistics for a process.
struct PROCESS_MEMORY_COUNTERS_EX
{
    ///The size of the structure, in bytes.
    uint   cb;
    ///The number of page faults.
    uint   PageFaultCount;
    ///The peak working set size, in bytes.
    size_t PeakWorkingSetSize;
    ///The current working set size, in bytes.
    size_t WorkingSetSize;
    ///The peak paged pool usage, in bytes.
    size_t QuotaPeakPagedPoolUsage;
    ///The current paged pool usage, in bytes.
    size_t QuotaPagedPoolUsage;
    ///The peak nonpaged pool usage, in bytes.
    size_t QuotaPeakNonPagedPoolUsage;
    ///The current nonpaged pool usage, in bytes.
    size_t QuotaNonPagedPoolUsage;
    ///The Commit Charge value in bytes for this process. Commit Charge is the total amount of private memory that the
    ///memory manager has committed for a running process. <b>Windows 7 and Windows Server 2008 R2 and earlier:
    ///</b><b>PagefileUsage</b> is always zero. Check <b>PrivateUsage</b> instead.
    size_t PagefileUsage;
    ///The peak value in bytes of the Commit Charge during the lifetime of this process.
    size_t PeakPagefileUsage;
    ///Same as <b>PagefileUsage</b>. The Commit Charge value in bytes for this process. Commit Charge is the total
    ///amount of private memory that the memory manager has committed for a running process.
    size_t PrivateUsage;
}

///Contains performance information.
struct PERFORMANCE_INFORMATION
{
    ///The size of this structure, in bytes.
    uint   cb;
    ///The number of pages currently committed by the system. Note that committing pages (using VirtualAlloc with
    ///MEM_COMMIT) changes this value immediately; however, the physical memory is not charged until the pages are
    ///accessed.
    size_t CommitTotal;
    ///The current maximum number of pages that can be committed by the system without extending the paging file(s).
    ///This number can change if memory is added or deleted, or if pagefiles have grown, shrunk, or been added. If the
    ///paging file can be extended, this is a soft limit.
    size_t CommitLimit;
    ///The maximum number of pages that were simultaneously in the committed state since the last system reboot.
    size_t CommitPeak;
    ///The amount of actual physical memory, in pages.
    size_t PhysicalTotal;
    ///The amount of physical memory currently available, in pages. This is the amount of physical memory that can be
    ///immediately reused without having to write its contents to disk first. It is the sum of the size of the standby,
    ///free, and zero lists.
    size_t PhysicalAvailable;
    ///The amount of system cache memory, in pages. This is the size of the standby list plus the system working set.
    size_t SystemCache;
    ///The sum of the memory currently in the paged and nonpaged kernel pools, in pages.
    size_t KernelTotal;
    ///The memory currently in the paged kernel pool, in pages.
    size_t KernelPaged;
    ///The memory currently in the nonpaged kernel pool, in pages.
    size_t KernelNonpaged;
    ///The size of a page, in bytes.
    size_t PageSize;
    ///The current number of open handles.
    uint   HandleCount;
    ///The current number of processes.
    uint   ProcessCount;
    ///The current number of threads.
    uint   ThreadCount;
}

///Contains information about a pagefile.
struct ENUM_PAGE_FILE_INFORMATION
{
    ///The size of this structure, in bytes.
    uint   cb;
    ///This member is reserved.
    uint   Reserved;
    ///The total size of the pagefile, in pages.
    size_t TotalSize;
    ///The current pagefile usage, in pages.
    size_t TotalInUse;
    ///The peak pagefile usage, in pages.
    size_t PeakUsage;
}

// Functions

@DllImport("KERNEL32")
BOOL K32EnumProcesses(char* lpidProcess, uint cb, uint* lpcbNeeded);

@DllImport("KERNEL32")
BOOL K32EnumProcessModules(HANDLE hProcess, char* lphModule, uint cb, uint* lpcbNeeded);

@DllImport("KERNEL32")
BOOL K32EnumProcessModulesEx(HANDLE hProcess, char* lphModule, uint cb, uint* lpcbNeeded, uint dwFilterFlag);

@DllImport("KERNEL32")
uint K32GetModuleBaseNameA(HANDLE hProcess, ptrdiff_t hModule, const(char)* lpBaseName, uint nSize);

@DllImport("KERNEL32")
uint K32GetModuleBaseNameW(HANDLE hProcess, ptrdiff_t hModule, const(wchar)* lpBaseName, uint nSize);

@DllImport("KERNEL32")
uint K32GetModuleFileNameExA(HANDLE hProcess, ptrdiff_t hModule, const(char)* lpFilename, uint nSize);

@DllImport("KERNEL32")
uint K32GetModuleFileNameExW(HANDLE hProcess, ptrdiff_t hModule, const(wchar)* lpFilename, uint nSize);

@DllImport("KERNEL32")
BOOL K32GetModuleInformation(HANDLE hProcess, ptrdiff_t hModule, MODULEINFO* lpmodinfo, uint cb);

@DllImport("KERNEL32")
BOOL K32EmptyWorkingSet(HANDLE hProcess);

@DllImport("KERNEL32")
BOOL K32QueryWorkingSet(HANDLE hProcess, char* pv, uint cb);

@DllImport("KERNEL32")
BOOL K32QueryWorkingSetEx(HANDLE hProcess, char* pv, uint cb);

@DllImport("KERNEL32")
BOOL K32InitializeProcessForWsWatch(HANDLE hProcess);

@DllImport("KERNEL32")
BOOL K32GetWsChanges(HANDLE hProcess, char* lpWatchInfo, uint cb);

@DllImport("KERNEL32")
BOOL K32GetWsChangesEx(HANDLE hProcess, char* lpWatchInfoEx, uint* cb);

@DllImport("KERNEL32")
uint K32GetMappedFileNameW(HANDLE hProcess, void* lpv, const(wchar)* lpFilename, uint nSize);

@DllImport("KERNEL32")
uint K32GetMappedFileNameA(HANDLE hProcess, void* lpv, const(char)* lpFilename, uint nSize);

@DllImport("KERNEL32")
BOOL K32EnumDeviceDrivers(char* lpImageBase, uint cb, uint* lpcbNeeded);

@DllImport("KERNEL32")
uint K32GetDeviceDriverBaseNameA(void* ImageBase, const(char)* lpFilename, uint nSize);

@DllImport("KERNEL32")
uint K32GetDeviceDriverBaseNameW(void* ImageBase, const(wchar)* lpBaseName, uint nSize);

@DllImport("KERNEL32")
uint K32GetDeviceDriverFileNameA(void* ImageBase, const(char)* lpFilename, uint nSize);

@DllImport("KERNEL32")
uint K32GetDeviceDriverFileNameW(void* ImageBase, const(wchar)* lpFilename, uint nSize);

@DllImport("KERNEL32")
BOOL K32GetProcessMemoryInfo(HANDLE Process, PROCESS_MEMORY_COUNTERS* ppsmemCounters, uint cb);

@DllImport("KERNEL32")
BOOL K32GetPerformanceInfo(PERFORMANCE_INFORMATION* pPerformanceInformation, uint cb);

@DllImport("KERNEL32")
BOOL K32EnumPageFilesW(PENUM_PAGE_FILE_CALLBACKW pCallBackRoutine, void* pContext);

@DllImport("KERNEL32")
BOOL K32EnumPageFilesA(PENUM_PAGE_FILE_CALLBACKA pCallBackRoutine, void* pContext);

@DllImport("KERNEL32")
uint K32GetProcessImageFileNameA(HANDLE hProcess, const(char)* lpImageFileName, uint nSize);

@DllImport("KERNEL32")
uint K32GetProcessImageFileNameW(HANDLE hProcess, const(wchar)* lpImageFileName, uint nSize);


