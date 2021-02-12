module windows.toolhelp;

public import windows.systemservices;

extern(Windows):

struct HEAPLIST32
{
    uint dwSize;
    uint th32ProcessID;
    uint th32HeapID;
    uint dwFlags;
}

struct HEAPENTRY32
{
    uint dwSize;
    HANDLE hHandle;
    uint dwAddress;
    uint dwBlockSize;
    uint dwFlags;
    uint dwLockCount;
    uint dwResvd;
    uint th32ProcessID;
    uint th32HeapID;
}

struct PROCESSENTRY32W
{
    uint dwSize;
    uint cntUsage;
    uint th32ProcessID;
    uint th32DefaultHeapID;
    uint th32ModuleID;
    uint cntThreads;
    uint th32ParentProcessID;
    int pcPriClassBase;
    uint dwFlags;
    ushort szExeFile;
}

struct PROCESSENTRY32
{
    uint dwSize;
    uint cntUsage;
    uint th32ProcessID;
    uint th32DefaultHeapID;
    uint th32ModuleID;
    uint cntThreads;
    uint th32ParentProcessID;
    int pcPriClassBase;
    uint dwFlags;
    byte szExeFile;
}

struct THREADENTRY32
{
    uint dwSize;
    uint cntUsage;
    uint th32ThreadID;
    uint th32OwnerProcessID;
    int tpBasePri;
    int tpDeltaPri;
    uint dwFlags;
}

struct MODULEENTRY32W
{
    uint dwSize;
    uint th32ModuleID;
    uint th32ProcessID;
    uint GlblcntUsage;
    uint ProccntUsage;
    ubyte* modBaseAddr;
    uint modBaseSize;
    int hModule;
    ushort szModule;
    ushort szExePath;
}

struct MODULEENTRY32
{
    uint dwSize;
    uint th32ModuleID;
    uint th32ProcessID;
    uint GlblcntUsage;
    uint ProccntUsage;
    ubyte* modBaseAddr;
    uint modBaseSize;
    int hModule;
    byte szModule;
    byte szExePath;
}

@DllImport("KERNEL32.dll")
HANDLE CreateToolhelp32Snapshot(uint dwFlags, uint th32ProcessID);

@DllImport("KERNEL32.dll")
BOOL Heap32ListFirst(HANDLE hSnapshot, HEAPLIST32* lphl);

@DllImport("KERNEL32.dll")
BOOL Heap32ListNext(HANDLE hSnapshot, HEAPLIST32* lphl);

@DllImport("KERNEL32.dll")
BOOL Heap32First(HEAPENTRY32* lphe, uint th32ProcessID, uint th32HeapID);

@DllImport("KERNEL32.dll")
BOOL Heap32Next(HEAPENTRY32* lphe);

@DllImport("KERNEL32.dll")
BOOL Toolhelp32ReadProcessMemory(uint th32ProcessID, void* lpBaseAddress, void* lpBuffer, uint cbRead, uint* lpNumberOfBytesRead);

@DllImport("KERNEL32.dll")
BOOL Process32FirstW(HANDLE hSnapshot, PROCESSENTRY32W* lppe);

@DllImport("KERNEL32.dll")
BOOL Process32NextW(HANDLE hSnapshot, PROCESSENTRY32W* lppe);

@DllImport("KERNEL32.dll")
BOOL Process32First(HANDLE hSnapshot, PROCESSENTRY32* lppe);

@DllImport("KERNEL32.dll")
BOOL Process32Next(HANDLE hSnapshot, PROCESSENTRY32* lppe);

@DllImport("KERNEL32.dll")
BOOL Thread32First(HANDLE hSnapshot, THREADENTRY32* lpte);

@DllImport("KERNEL32.dll")
BOOL Thread32Next(HANDLE hSnapshot, THREADENTRY32* lpte);

@DllImport("KERNEL32.dll")
BOOL Module32FirstW(HANDLE hSnapshot, MODULEENTRY32W* lpme);

@DllImport("KERNEL32.dll")
BOOL Module32NextW(HANDLE hSnapshot, MODULEENTRY32W* lpme);

@DllImport("KERNEL32.dll")
BOOL Module32First(HANDLE hSnapshot, MODULEENTRY32* lpme);

@DllImport("KERNEL32.dll")
BOOL Module32Next(HANDLE hSnapshot, MODULEENTRY32* lpme);

