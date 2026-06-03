// Written in the D programming language.

module windows.win32.system.processstatus;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HMODULE, PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias ENUM_PROCESS_MODULES_EX_FLAGS = uint;
enum : uint
{
    LIST_MODULES_ALL     = 0x00000003U,
    LIST_MODULES_DEFAULT = 0x00000000U,
    LIST_MODULES_32BIT   = 0x00000001U,
    LIST_MODULES_64BIT   = 0x00000002U,
}

// Constants


enum uint PSAPI_VERSION = 0x00000002U;

// Callbacks

alias PENUM_PAGE_FILE_CALLBACKW = BOOL function(void* pContext, ENUM_PAGE_FILE_INFORMATION* pPageFileInfo, 
                                                const(PWSTR) lpFilename);
alias PENUM_PAGE_FILE_CALLBACKA = BOOL function(void* pContext, ENUM_PAGE_FILE_INFORMATION* pPageFileInfo, 
                                                const(PSTR) lpFilename);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-moduleinfo
struct MODULEINFO
{
    void* lpBaseOfDll;
    uint  SizeOfImage;
    void* EntryPoint;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-psapi_ws_watch_information
struct PSAPI_WS_WATCH_INFORMATION
{
    void* FaultingPc;
    void* FaultingVa;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-psapi_ws_watch_information_ex
struct PSAPI_WS_WATCH_INFORMATION_EX
{
    PSAPI_WS_WATCH_INFORMATION BasicInfo;
    size_t FaultingThreadId;
    size_t Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-psapi_working_set_block
union PSAPI_WORKING_SET_BLOCK
{
    size_t Flags;
    struct
    {
        // Native bit field: Protection: [0-4], ShareCount: [5-7], Shared: [8], Reserved: [9-11], VirtualPage: [12-31]
        size_t _bitfield0;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-psapi_working_set_information
struct PSAPI_WORKING_SET_INFORMATION
{
    size_t NumberOfEntries;
    PSAPI_WORKING_SET_BLOCK[1] WorkingSetInfo; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-psapi_working_set_ex_block
union PSAPI_WORKING_SET_EX_BLOCK
{
    size_t Flags;
    union
    {
        struct
        {
            // Native bit field: Valid: [0], ShareCount: [1-3], Win32Protection: [4-14], Shared: [15], Node: [16-21], Locked: [22], LargePage: [23], Reserved: [24-30], Bad: [31]
            size_t _bitfield0;
        }
        struct Invalid
        {
            // Native bit field: Valid: [0], Reserved0: [1-14], Shared: [15], Reserved1: [16-30], Bad: [31]
            size_t _bitfield1;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-psapi_working_set_ex_information
struct PSAPI_WORKING_SET_EX_INFORMATION
{
    void* VirtualAddress;
    PSAPI_WORKING_SET_EX_BLOCK VirtualAttributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-process_memory_counters
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-process_memory_counters_ex
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

struct PROCESS_MEMORY_COUNTERS_EX2
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
    size_t PrivateWorkingSetSize;
    ulong  SharedCommitUsage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-performance_information
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-enum_page_file_information
struct ENUM_PAGE_FILE_INFORMATION
{
    uint   cb;
    uint   Reserved;
    size_t TotalSize;
    size_t TotalInUse;
    size_t PeakUsage;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL EnumProcesses(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/uint* lpidProcess, 
                   uint cb, uint* lpcbNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL EnumProcessModules(HANDLE hProcess, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/HMODULE* lphModule, 
                        uint cb, uint* lpcbNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("PSAPI.dll")
BOOL EnumProcessModulesEx(HANDLE hProcess, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/HMODULE* lphModule, 
                          uint cb, uint* lpcbNeeded, ENUM_PROCESS_MODULES_EX_FLAGS dwFilterFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetModuleBaseNameA(HANDLE hProcess, HMODULE hModule, PSTR lpBaseName, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetModuleBaseNameW(HANDLE hProcess, HMODULE hModule, PWSTR lpBaseName, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetModuleFileNameExA(HANDLE hProcess, HMODULE hModule, PSTR lpFilename, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetModuleFileNameExW(HANDLE hProcess, HMODULE hModule, PWSTR lpFilename, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL GetModuleInformation(HANDLE hProcess, HMODULE hModule, MODULEINFO* lpmodinfo, uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL EmptyWorkingSet(HANDLE hProcess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL InitializeProcessForWsWatch(HANDLE hProcess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL GetWsChanges(HANDLE hProcess, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSAPI_WS_WATCH_INFORMATION* lpWatchInfo, 
                  uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("PSAPI.dll")
BOOL GetWsChangesEx(HANDLE hProcess, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSAPI_WS_WATCH_INFORMATION_EX* lpWatchInfoEx, 
                    uint* cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetMappedFileNameW(HANDLE hProcess, void* lpv, PWSTR lpFilename, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetMappedFileNameA(HANDLE hProcess, void* lpv, PSTR lpFilename, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL EnumDeviceDrivers(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void** lpImageBase, 
                       uint cb, uint* lpcbNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetDeviceDriverBaseNameA(void* ImageBase, PSTR lpFilename, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetDeviceDriverBaseNameW(void* ImageBase, PWSTR lpBaseName, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetDeviceDriverFileNameA(void* ImageBase, PSTR lpFilename, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetDeviceDriverFileNameW(void* ImageBase, PWSTR lpFilename, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL QueryWorkingSet(HANDLE hProcess, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                     uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("PSAPI.dll")
BOOL QueryWorkingSetEx(HANDLE hProcess, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                       uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL GetProcessMemoryInfo(HANDLE Process, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PROCESS_MEMORY_COUNTERS* ppsmemCounters, 
                          uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL GetPerformanceInfo(PERFORMANCE_INFORMATION* pPerformanceInformation, uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL EnumPageFilesW(PENUM_PAGE_FILE_CALLBACKW pCallBackRoutine, void* pContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
BOOL EnumPageFilesA(PENUM_PAGE_FILE_CALLBACKA pCallBackRoutine, void* pContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetProcessImageFileNameA(HANDLE hProcess, PSTR lpImageFileName, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PSAPI.dll")
uint GetProcessImageFileNameW(HANDLE hProcess, PWSTR lpImageFileName, uint nSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-enumprocesses
@DllImport("KERNEL32.dll")
BOOL K32EnumProcesses(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/uint* lpidProcess, 
                      uint cb, uint* lpcbNeeded);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-enumprocessmodules
@DllImport("KERNEL32.dll")
BOOL K32EnumProcessModules(HANDLE hProcess, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/HMODULE* lphModule, 
                           uint cb, uint* lpcbNeeded);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-enumprocessmodulesex
@DllImport("KERNEL32.dll")
BOOL K32EnumProcessModulesEx(HANDLE hProcess, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/HMODULE* lphModule, 
                             uint cb, uint* lpcbNeeded, uint dwFilterFlag);

@DllImport("KERNEL32.dll")
uint K32GetModuleBaseNameA(HANDLE hProcess, HMODULE hModule, PSTR lpBaseName, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetModuleBaseNameW(HANDLE hProcess, HMODULE hModule, PWSTR lpBaseName, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetModuleFileNameExA(HANDLE hProcess, HMODULE hModule, PSTR lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetModuleFileNameExW(HANDLE hProcess, HMODULE hModule, PWSTR lpFilename, uint nSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-getmoduleinformation
@DllImport("KERNEL32.dll")
BOOL K32GetModuleInformation(HANDLE hProcess, HMODULE hModule, MODULEINFO* lpmodinfo, uint cb);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-emptyworkingset
@DllImport("KERNEL32.dll")
BOOL K32EmptyWorkingSet(HANDLE hProcess);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-initializeprocessforwswatch
@DllImport("KERNEL32.dll")
BOOL K32InitializeProcessForWsWatch(HANDLE hProcess);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-getwschanges
@DllImport("KERNEL32.dll")
BOOL K32GetWsChanges(HANDLE hProcess, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSAPI_WS_WATCH_INFORMATION* lpWatchInfo, 
                     uint cb);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-getwschangesex
@DllImport("KERNEL32.dll")
BOOL K32GetWsChangesEx(HANDLE hProcess, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSAPI_WS_WATCH_INFORMATION_EX* lpWatchInfoEx, 
                       uint* cb);

@DllImport("KERNEL32.dll")
uint K32GetMappedFileNameW(HANDLE hProcess, void* lpv, PWSTR lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetMappedFileNameA(HANDLE hProcess, void* lpv, PSTR lpFilename, uint nSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-enumdevicedrivers
@DllImport("KERNEL32.dll")
BOOL K32EnumDeviceDrivers(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void** lpImageBase, 
                          uint cb, uint* lpcbNeeded);

@DllImport("KERNEL32.dll")
uint K32GetDeviceDriverBaseNameA(void* ImageBase, PSTR lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetDeviceDriverBaseNameW(void* ImageBase, PWSTR lpBaseName, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetDeviceDriverFileNameA(void* ImageBase, PSTR lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetDeviceDriverFileNameW(void* ImageBase, PWSTR lpFilename, uint nSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-queryworkingset
@DllImport("KERNEL32.dll")
BOOL K32QueryWorkingSet(HANDLE hProcess, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                        uint cb);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-queryworkingsetex
@DllImport("KERNEL32.dll")
BOOL K32QueryWorkingSetEx(HANDLE hProcess, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                          uint cb);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-getprocessmemoryinfo
@DllImport("KERNEL32.dll")
BOOL K32GetProcessMemoryInfo(HANDLE Process, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PROCESS_MEMORY_COUNTERS* ppsmemCounters, 
                             uint cb);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-getperformanceinfo
@DllImport("KERNEL32.dll")
BOOL K32GetPerformanceInfo(PERFORMANCE_INFORMATION* pPerformanceInformation, uint cb);

@DllImport("KERNEL32.dll")
BOOL K32EnumPageFilesW(PENUM_PAGE_FILE_CALLBACKW pCallBackRoutine, void* pContext);

@DllImport("KERNEL32.dll")
BOOL K32EnumPageFilesA(PENUM_PAGE_FILE_CALLBACKA pCallBackRoutine, void* pContext);

@DllImport("KERNEL32.dll")
uint K32GetProcessImageFileNameA(HANDLE hProcess, PSTR lpImageFileName, uint nSize);

@DllImport("KERNEL32.dll")
uint K32GetProcessImageFileNameW(HANDLE hProcess, PWSTR lpImageFileName, uint nSize);


