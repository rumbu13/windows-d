module windows.processstatus;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Callbacks

alias PENUM_PAGE_FILE_CALLBACKW = BOOL function(void* pContext, ENUM_PAGE_FILE_INFORMATION* pPageFileInfo, 
                                                const(wchar)* lpFilename);
alias PENUM_PAGE_FILE_CALLBACKA = BOOL function(void* pContext, ENUM_PAGE_FILE_INFORMATION* pPageFileInfo, 
                                                const(char)* lpFilename);

// Structs


struct MODULEINFO
{
    void* lpBaseOfDll;
    uint  SizeOfImage;
    void* EntryPoint;
}

union PSAPI_WORKING_SET_BLOCK
{
    size_t Flags;
    struct
    {
        size_t _bitfield95;
    }
}

struct PSAPI_WORKING_SET_INFORMATION
{
    size_t NumberOfEntries;
    PSAPI_WORKING_SET_BLOCK[1] WorkingSetInfo;
}

union PSAPI_WORKING_SET_EX_BLOCK
{
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

struct PSAPI_WORKING_SET_EX_INFORMATION
{
    void* VirtualAddress;
    PSAPI_WORKING_SET_EX_BLOCK VirtualAttributes;
}

struct PSAPI_WS_WATCH_INFORMATION
{
    void* FaultingPc;
    void* FaultingVa;
}

struct PSAPI_WS_WATCH_INFORMATION_EX
{
    PSAPI_WS_WATCH_INFORMATION BasicInfo;
    size_t FaultingThreadId;
    size_t Flags;
}

struct PROCESS_MEMORY_COUNTERS
{
    uint   cb;
    uint   PageFaultCount;
    size_t PeakWorkingSetSize;
    size_t WorkingSetSize;
    size_t QuotaPeakPagedPoolUsage;
    size_t QuotaPagedPoolUsage;
    size_t QuotaPeakNonPagedPoolUsage;
    size_t QuotaNonPagedPoolUsage;
    size_t PagefileUsage;
    size_t PeakPagefileUsage;
}

struct PROCESS_MEMORY_COUNTERS_EX
{
    uint   cb;
    uint   PageFaultCount;
    size_t PeakWorkingSetSize;
    size_t WorkingSetSize;
    size_t QuotaPeakPagedPoolUsage;
    size_t QuotaPagedPoolUsage;
    size_t QuotaPeakNonPagedPoolUsage;
    size_t QuotaNonPagedPoolUsage;
    size_t PagefileUsage;
    size_t PeakPagefileUsage;
    size_t PrivateUsage;
}

struct PERFORMANCE_INFORMATION
{
    uint   cb;
    size_t CommitTotal;
    size_t CommitLimit;
    size_t CommitPeak;
    size_t PhysicalTotal;
    size_t PhysicalAvailable;
    size_t SystemCache;
    size_t KernelTotal;
    size_t KernelPaged;
    size_t KernelNonpaged;
    size_t PageSize;
    uint   HandleCount;
    uint   ProcessCount;
    uint   ThreadCount;
}

struct ENUM_PAGE_FILE_INFORMATION
{
    uint   cb;
    uint   Reserved;
    size_t TotalSize;
    size_t TotalInUse;
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


