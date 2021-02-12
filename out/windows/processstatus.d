module windows.processstatus;

public import windows.systemservices;

extern(Windows):

struct MODULEINFO
{
    void* lpBaseOfDll;
    uint SizeOfImage;
    void* EntryPoint;
}

struct PSAPI_WORKING_SET_BLOCK
{
    uint Flags;
    _Anonymous_e__Struct Anonymous;
}

struct PSAPI_WORKING_SET_INFORMATION
{
    uint NumberOfEntries;
    PSAPI_WORKING_SET_BLOCK WorkingSetInfo;
}

struct PSAPI_WORKING_SET_EX_BLOCK
{
    uint Flags;
    _Anonymous_e__Union Anonymous;
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
    uint FaultingThreadId;
    uint Flags;
}

struct PROCESS_MEMORY_COUNTERS
{
    uint cb;
    uint PageFaultCount;
    uint PeakWorkingSetSize;
    uint WorkingSetSize;
    uint QuotaPeakPagedPoolUsage;
    uint QuotaPagedPoolUsage;
    uint QuotaPeakNonPagedPoolUsage;
    uint QuotaNonPagedPoolUsage;
    uint PagefileUsage;
    uint PeakPagefileUsage;
}

struct PROCESS_MEMORY_COUNTERS_EX
{
    uint cb;
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
}

struct PERFORMANCE_INFORMATION
{
    uint cb;
    uint CommitTotal;
    uint CommitLimit;
    uint CommitPeak;
    uint PhysicalTotal;
    uint PhysicalAvailable;
    uint SystemCache;
    uint KernelTotal;
    uint KernelPaged;
    uint KernelNonpaged;
    uint PageSize;
    uint HandleCount;
    uint ProcessCount;
    uint ThreadCount;
}

struct ENUM_PAGE_FILE_INFORMATION
{
    uint cb;
    uint Reserved;
    uint TotalSize;
    uint TotalInUse;
    uint PeakUsage;
}

alias PENUM_PAGE_FILE_CALLBACKW = extern(Windows) BOOL function(void* pContext, ENUM_PAGE_FILE_INFORMATION* pPageFileInfo, const(wchar)* lpFilename);
alias PENUM_PAGE_FILE_CALLBACKA = extern(Windows) BOOL function(void* pContext, ENUM_PAGE_FILE_INFORMATION* pPageFileInfo, const(char)* lpFilename);
@DllImport("KERNEL32.dll")
BOOL K32EnumProcesses(char* lpidProcess, uint cb, uint* lpcbNeeded);

@DllImport("KERNEL32.dll")
BOOL K32EnumProcessModules(HANDLE hProcess, char* lphModule, uint cb, uint* lpcbNeeded);

@DllImport("KERNEL32.dll")
BOOL K32EnumProcessModulesEx(HANDLE hProcess, char* lphModule, uint cb, uint* lpcbNeeded, uint dwFilterFlag);

@DllImport("KERNEL32.dll")
uint K32GetModuleBaseNameA(HANDLE hProcess, int hModule, const(char)* lpBaseName, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetModuleBaseNameW(HANDLE hProcess, int hModule, const(wchar)* lpBaseName, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetModuleFileNameExA(HANDLE hProcess, int hModule, const(char)* lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetModuleFileNameExW(HANDLE hProcess, int hModule, const(wchar)* lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
BOOL K32GetModuleInformation(HANDLE hProcess, int hModule, MODULEINFO* lpmodinfo, uint cb);

@DllImport("KERNEL32.dll")
BOOL K32EmptyWorkingSet(HANDLE hProcess);

@DllImport("KERNEL32.dll")
BOOL K32QueryWorkingSet(HANDLE hProcess, char* pv, uint cb);

@DllImport("KERNEL32.dll")
BOOL K32QueryWorkingSetEx(HANDLE hProcess, char* pv, uint cb);

@DllImport("KERNEL32.dll")
BOOL K32InitializeProcessForWsWatch(HANDLE hProcess);

@DllImport("KERNEL32.dll")
BOOL K32GetWsChanges(HANDLE hProcess, char* lpWatchInfo, uint cb);

@DllImport("KERNEL32.dll")
BOOL K32GetWsChangesEx(HANDLE hProcess, char* lpWatchInfoEx, uint* cb);

@DllImport("KERNEL32.dll")
uint K32GetMappedFileNameW(HANDLE hProcess, void* lpv, const(wchar)* lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetMappedFileNameA(HANDLE hProcess, void* lpv, const(char)* lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
BOOL K32EnumDeviceDrivers(char* lpImageBase, uint cb, uint* lpcbNeeded);

@DllImport("KERNEL32.dll")
uint K32GetDeviceDriverBaseNameA(void* ImageBase, const(char)* lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetDeviceDriverBaseNameW(void* ImageBase, const(wchar)* lpBaseName, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetDeviceDriverFileNameA(void* ImageBase, const(char)* lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetDeviceDriverFileNameW(void* ImageBase, const(wchar)* lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
BOOL K32GetProcessMemoryInfo(HANDLE Process, PROCESS_MEMORY_COUNTERS* ppsmemCounters, uint cb);

@DllImport("KERNEL32.dll")
BOOL K32GetPerformanceInfo(PERFORMANCE_INFORMATION* pPerformanceInformation, uint cb);

@DllImport("KERNEL32.dll")
BOOL K32EnumPageFilesW(PENUM_PAGE_FILE_CALLBACKW pCallBackRoutine, void* pContext);

@DllImport("KERNEL32.dll")
BOOL K32EnumPageFilesA(PENUM_PAGE_FILE_CALLBACKA pCallBackRoutine, void* pContext);

@DllImport("KERNEL32.dll")
uint K32GetProcessImageFileNameA(HANDLE hProcess, const(char)* lpImageFileName, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetProcessImageFileNameW(HANDLE hProcess, const(wchar)* lpImageFileName, uint nSize);

