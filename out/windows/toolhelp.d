module windows.toolhelp;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Structs


struct HEAPLIST32
{
    size_t dwSize;
    uint   th32ProcessID;
    size_t th32HeapID;
    uint   dwFlags;
}

struct HEAPENTRY32
{
    size_t dwSize;
    HANDLE hHandle;
    size_t dwAddress;
    size_t dwBlockSize;
    uint   dwFlags;
    uint   dwLockCount;
    uint   dwResvd;
    uint   th32ProcessID;
    size_t th32HeapID;
}

struct PROCESSENTRY32W
{
    uint        dwSize;
    uint        cntUsage;
    uint        th32ProcessID;
    size_t      th32DefaultHeapID;
    uint        th32ModuleID;
    uint        cntThreads;
    uint        th32ParentProcessID;
    int         pcPriClassBase;
    uint        dwFlags;
    ushort[260] szExeFile;
}

struct PROCESSENTRY32
{
    uint      dwSize;
    uint      cntUsage;
    uint      th32ProcessID;
    size_t    th32DefaultHeapID;
    uint      th32ModuleID;
    uint      cntThreads;
    uint      th32ParentProcessID;
    int       pcPriClassBase;
    uint      dwFlags;
    byte[260] szExeFile;
}

struct THREADENTRY32
{
    uint dwSize;
    uint cntUsage;
    uint th32ThreadID;
    uint th32OwnerProcessID;
    int  tpBasePri;
    int  tpDeltaPri;
    uint dwFlags;
}

struct MODULEENTRY32W
{
    uint        dwSize;
    uint        th32ModuleID;
    uint        th32ProcessID;
    uint        GlblcntUsage;
    uint        ProccntUsage;
    ubyte*      modBaseAddr;
    uint        modBaseSize;
    ptrdiff_t   hModule;
    ushort[256] szModule;
    ushort[260] szExePath;
}

struct MODULEENTRY32
{
    uint      dwSize;
    uint      th32ModuleID;
    uint      th32ProcessID;
    uint      GlblcntUsage;
    uint      ProccntUsage;
    ubyte*    modBaseAddr;
    uint      modBaseSize;
    ptrdiff_t hModule;
    byte[256] szModule;
    byte[260] szExePath;
}

// Functions

@DllImport("KERNEL32")
HANDLE CreateToolhelp32Snapshot(uint dwFlags, uint th32ProcessID);

@DllImport("KERNEL32")
BOOL Heap32ListFirst(HANDLE hSnapshot, HEAPLIST32* lphl);

@DllImport("KERNEL32")
BOOL Heap32ListNext(HANDLE hSnapshot, HEAPLIST32* lphl);

@DllImport("KERNEL32")
BOOL Heap32First(HEAPENTRY32* lphe, uint th32ProcessID, size_t th32HeapID);

@DllImport("KERNEL32")
BOOL Heap32Next(HEAPENTRY32* lphe);

@DllImport("KERNEL32")
BOOL Toolhelp32ReadProcessMemory(uint th32ProcessID, void* lpBaseAddress, void* lpBuffer, size_t cbRead, 
                                 size_t* lpNumberOfBytesRead);

@DllImport("KERNEL32")
BOOL Process32FirstW(HANDLE hSnapshot, PROCESSENTRY32W* lppe);

@DllImport("KERNEL32")
BOOL Process32NextW(HANDLE hSnapshot, PROCESSENTRY32W* lppe);

@DllImport("KERNEL32")
BOOL Process32First(HANDLE hSnapshot, PROCESSENTRY32* lppe);

@DllImport("KERNEL32")
BOOL Process32Next(HANDLE hSnapshot, PROCESSENTRY32* lppe);

@DllImport("KERNEL32")
BOOL Thread32First(HANDLE hSnapshot, THREADENTRY32* lpte);

@DllImport("KERNEL32")
BOOL Thread32Next(HANDLE hSnapshot, THREADENTRY32* lpte);

@DllImport("KERNEL32")
BOOL Module32FirstW(HANDLE hSnapshot, MODULEENTRY32W* lpme);

@DllImport("KERNEL32")
BOOL Module32NextW(HANDLE hSnapshot, MODULEENTRY32W* lpme);

@DllImport("KERNEL32")
BOOL Module32First(HANDLE hSnapshot, MODULEENTRY32* lpme);

@DllImport("KERNEL32")
BOOL Module32Next(HANDLE hSnapshot, MODULEENTRY32* lpme);


