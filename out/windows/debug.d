module windows.debug;

public import system;
public import windows.automation;
public import windows.com;
public import windows.displaydevices;
public import windows.dxgi;
public import windows.gdi;
public import windows.menusandresources;
public import windows.shell;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct CONTEXT
{
    uint ContextFlags;
    uint Dr0;
    uint Dr1;
    uint Dr2;
    uint Dr3;
    uint Dr6;
    uint Dr7;
    FLOATING_SAVE_AREA FloatSave;
    uint SegGs;
    uint SegFs;
    uint SegEs;
    uint SegDs;
    uint Edi;
    uint Esi;
    uint Ebx;
    uint Edx;
    uint Ecx;
    uint Eax;
    uint Ebp;
    uint Eip;
    uint SegCs;
    uint EFlags;
    uint Esp;
    uint SegSs;
    ubyte ExtendedRegisters;
}

struct LDT_ENTRY
{
    ushort LimitLow;
    ushort BaseLow;
    _HighWord_e__Union HighWord;
}

struct WOW64_FLOATING_SAVE_AREA
{
    uint ControlWord;
    uint StatusWord;
    uint TagWord;
    uint ErrorOffset;
    uint ErrorSelector;
    uint DataOffset;
    uint DataSelector;
    ubyte RegisterArea;
    uint Cr0NpxState;
}

struct WOW64_CONTEXT
{
    uint ContextFlags;
    uint Dr0;
    uint Dr1;
    uint Dr2;
    uint Dr3;
    uint Dr6;
    uint Dr7;
    WOW64_FLOATING_SAVE_AREA FloatSave;
    uint SegGs;
    uint SegFs;
    uint SegEs;
    uint SegDs;
    uint Edi;
    uint Esi;
    uint Ebx;
    uint Edx;
    uint Ecx;
    uint Eax;
    uint Ebp;
    uint Eip;
    uint SegCs;
    uint EFlags;
    uint Esp;
    uint SegSs;
    ubyte ExtendedRegisters;
}

struct WOW64_LDT_ENTRY
{
    ushort LimitLow;
    ushort BaseLow;
    _HighWord_e__Union HighWord;
}

struct EXCEPTION_RECORD
{
    uint ExceptionCode;
    uint ExceptionFlags;
    EXCEPTION_RECORD* ExceptionRecord;
    void* ExceptionAddress;
    uint NumberParameters;
    uint ExceptionInformation;
}

struct EXCEPTION_RECORD64
{
    uint ExceptionCode;
    uint ExceptionFlags;
    ulong ExceptionRecord;
    ulong ExceptionAddress;
    uint NumberParameters;
    uint __unusedAlignment;
    ulong ExceptionInformation;
}

struct EXCEPTION_POINTERS
{
    EXCEPTION_RECORD* ExceptionRecord;
    CONTEXT* ContextRecord;
}

struct IMAGE_FILE_HEADER
{
    ushort Machine;
    ushort NumberOfSections;
    uint TimeDateStamp;
    uint PointerToSymbolTable;
    uint NumberOfSymbols;
    ushort SizeOfOptionalHeader;
    ushort Characteristics;
}

struct IMAGE_DATA_DIRECTORY
{
    uint VirtualAddress;
    uint Size;
}

struct IMAGE_OPTIONAL_HEADER64
{
    ushort Magic;
    ubyte MajorLinkerVersion;
    ubyte MinorLinkerVersion;
    uint SizeOfCode;
    uint SizeOfInitializedData;
    uint SizeOfUninitializedData;
    uint AddressOfEntryPoint;
    uint BaseOfCode;
    ulong ImageBase;
    uint SectionAlignment;
    uint FileAlignment;
    ushort MajorOperatingSystemVersion;
    ushort MinorOperatingSystemVersion;
    ushort MajorImageVersion;
    ushort MinorImageVersion;
    ushort MajorSubsystemVersion;
    ushort MinorSubsystemVersion;
    uint Win32VersionValue;
    uint SizeOfImage;
    uint SizeOfHeaders;
    uint CheckSum;
    ushort Subsystem;
    ushort DllCharacteristics;
    ulong SizeOfStackReserve;
    ulong SizeOfStackCommit;
    ulong SizeOfHeapReserve;
    ulong SizeOfHeapCommit;
    uint LoaderFlags;
    uint NumberOfRvaAndSizes;
    IMAGE_DATA_DIRECTORY DataDirectory;
}

struct IMAGE_NT_HEADERS64
{
    uint Signature;
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER64 OptionalHeader;
}

struct IMAGE_SECTION_HEADER
{
    ubyte Name;
    _Misc_e__Union Misc;
    uint VirtualAddress;
    uint SizeOfRawData;
    uint PointerToRawData;
    uint PointerToRelocations;
    uint PointerToLinenumbers;
    ushort NumberOfRelocations;
    ushort NumberOfLinenumbers;
    uint Characteristics;
}

struct IMAGE_LOAD_CONFIG_DIRECTORY32
{
    uint Size;
    uint TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint GlobalFlagsClear;
    uint GlobalFlagsSet;
    uint CriticalSectionDefaultTimeout;
    uint DeCommitFreeBlockThreshold;
    uint DeCommitTotalFreeThreshold;
    uint LockPrefixTable;
    uint MaximumAllocationSize;
    uint VirtualMemoryThreshold;
    uint ProcessHeapFlags;
    uint ProcessAffinityMask;
    ushort CSDVersion;
    ushort DependentLoadFlags;
    uint EditList;
    uint SecurityCookie;
    uint SEHandlerTable;
    uint SEHandlerCount;
    uint GuardCFCheckFunctionPointer;
    uint GuardCFDispatchFunctionPointer;
    uint GuardCFFunctionTable;
    uint GuardCFFunctionCount;
    uint GuardFlags;
    IMAGE_LOAD_CONFIG_CODE_INTEGRITY CodeIntegrity;
    uint GuardAddressTakenIatEntryTable;
    uint GuardAddressTakenIatEntryCount;
    uint GuardLongJumpTargetTable;
    uint GuardLongJumpTargetCount;
    uint DynamicValueRelocTable;
    uint CHPEMetadataPointer;
    uint GuardRFFailureRoutine;
    uint GuardRFFailureRoutineFunctionPointer;
    uint DynamicValueRelocTableOffset;
    ushort DynamicValueRelocTableSection;
    ushort Reserved2;
    uint GuardRFVerifyStackPointerFunctionPointer;
    uint HotPatchTableOffset;
    uint Reserved3;
    uint EnclaveConfigurationPointer;
    uint VolatileMetadataPointer;
    uint GuardEHContinuationTable;
    uint GuardEHContinuationCount;
}

struct IMAGE_LOAD_CONFIG_DIRECTORY64
{
    uint Size;
    uint TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint GlobalFlagsClear;
    uint GlobalFlagsSet;
    uint CriticalSectionDefaultTimeout;
    ulong DeCommitFreeBlockThreshold;
    ulong DeCommitTotalFreeThreshold;
    ulong LockPrefixTable;
    ulong MaximumAllocationSize;
    ulong VirtualMemoryThreshold;
    ulong ProcessAffinityMask;
    uint ProcessHeapFlags;
    ushort CSDVersion;
    ushort DependentLoadFlags;
    ulong EditList;
    ulong SecurityCookie;
    ulong SEHandlerTable;
    ulong SEHandlerCount;
    ulong GuardCFCheckFunctionPointer;
    ulong GuardCFDispatchFunctionPointer;
    ulong GuardCFFunctionTable;
    ulong GuardCFFunctionCount;
    uint GuardFlags;
    IMAGE_LOAD_CONFIG_CODE_INTEGRITY CodeIntegrity;
    ulong GuardAddressTakenIatEntryTable;
    ulong GuardAddressTakenIatEntryCount;
    ulong GuardLongJumpTargetTable;
    ulong GuardLongJumpTargetCount;
    ulong DynamicValueRelocTable;
    ulong CHPEMetadataPointer;
    ulong GuardRFFailureRoutine;
    ulong GuardRFFailureRoutineFunctionPointer;
    uint DynamicValueRelocTableOffset;
    ushort DynamicValueRelocTableSection;
    ushort Reserved2;
    ulong GuardRFVerifyStackPointerFunctionPointer;
    uint HotPatchTableOffset;
    uint Reserved3;
    ulong EnclaveConfigurationPointer;
    ulong VolatileMetadataPointer;
    ulong GuardEHContinuationTable;
    ulong GuardEHContinuationCount;
}

struct IMAGE_DEBUG_DIRECTORY
{
    uint Characteristics;
    uint TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint Type;
    uint SizeOfData;
    uint AddressOfRawData;
    uint PointerToRawData;
}

struct IMAGE_COFF_SYMBOLS_HEADER
{
    uint NumberOfSymbols;
    uint LvaToFirstSymbol;
    uint NumberOfLinenumbers;
    uint LvaToFirstLinenumber;
    uint RvaToFirstByteOfCode;
    uint RvaToLastByteOfCode;
    uint RvaToFirstByteOfData;
    uint RvaToLastByteOfData;
}

struct FPO_DATA
{
    uint ulOffStart;
    uint cbProcSize;
    uint cdwLocals;
    ushort cdwParams;
    ushort _bitfield;
}

struct IMAGE_FUNCTION_ENTRY
{
    uint StartingAddress;
    uint EndingAddress;
    uint EndOfPrologue;
}

struct IMAGE_FUNCTION_ENTRY64
{
    ulong StartingAddress;
    ulong EndingAddress;
    _Anonymous_e__Union Anonymous;
}

alias PVECTORED_EXCEPTION_HANDLER = extern(Windows) int function(EXCEPTION_POINTERS* ExceptionInfo);
@DllImport("KERNEL32.dll")
void RtlCaptureContext(CONTEXT* ContextRecord);

@DllImport("KERNEL32.dll")
void RtlUnwind(void* TargetFrame, void* TargetIp, EXCEPTION_RECORD* ExceptionRecord, void* ReturnValue);

@DllImport("KERNEL32.dll")
void* RtlPcToFileHeader(void* PcValue, void** BaseOfImage);

@DllImport("KERNEL32.dll")
BOOL ReadProcessMemory(HANDLE hProcess, void* lpBaseAddress, char* lpBuffer, uint nSize, uint* lpNumberOfBytesRead);

@DllImport("KERNEL32.dll")
BOOL WriteProcessMemory(HANDLE hProcess, void* lpBaseAddress, char* lpBuffer, uint nSize, uint* lpNumberOfBytesWritten);

@DllImport("USER32.dll")
BOOL FlashWindow(HWND hWnd, BOOL bInvert);

@DllImport("USER32.dll")
BOOL FlashWindowEx(FLASHWINFO* pfwi);

@DllImport("USER32.dll")
BOOL MessageBeep(uint uType);

@DllImport("USER32.dll")
void SetLastErrorEx(uint dwErrCode, uint dwType);

@DllImport("KERNEL32.dll")
BOOL Wow64GetThreadContext(HANDLE hThread, WOW64_CONTEXT* lpContext);

@DllImport("KERNEL32.dll")
BOOL Wow64SetThreadContext(HANDLE hThread, const(WOW64_CONTEXT)* lpContext);

@DllImport("KERNEL32.dll")
BOOL GetThreadContext(HANDLE hThread, CONTEXT* lpContext);

@DllImport("KERNEL32.dll")
BOOL SetThreadContext(HANDLE hThread, const(CONTEXT)* lpContext);

@DllImport("KERNEL32.dll")
BOOL FlushInstructionCache(HANDLE hProcess, char* lpBaseAddress, uint dwSize);

@DllImport("KERNEL32.dll")
void FatalExit(int ExitCode);

@DllImport("KERNEL32.dll")
BOOL GetThreadSelectorEntry(HANDLE hThread, uint dwSelector, LDT_ENTRY* lpSelectorEntry);

@DllImport("KERNEL32.dll")
BOOL Wow64GetThreadSelectorEntry(HANDLE hThread, uint dwSelector, WOW64_LDT_ENTRY* lpSelectorEntry);

@DllImport("KERNEL32.dll")
BOOL DebugSetProcessKillOnExit(BOOL KillOnExit);

@DllImport("KERNEL32.dll")
BOOL DebugBreakProcess(HANDLE Process);

@DllImport("KERNEL32.dll")
uint FormatMessageA(uint dwFlags, void* lpSource, uint dwMessageId, uint dwLanguageId, const(char)* lpBuffer, uint nSize, byte** Arguments);

@DllImport("KERNEL32.dll")
uint FormatMessageW(uint dwFlags, void* lpSource, uint dwMessageId, uint dwLanguageId, const(wchar)* lpBuffer, uint nSize, byte** Arguments);

@DllImport("KERNEL32.dll")
BOOL CopyContext(CONTEXT* Destination, uint ContextFlags, CONTEXT* Source);

@DllImport("KERNEL32.dll")
BOOL InitializeContext(char* Buffer, uint ContextFlags, CONTEXT** Context, uint* ContextLength);

@DllImport("KERNEL32.dll")
ulong GetEnabledXStateFeatures();

@DllImport("KERNEL32.dll")
BOOL GetXStateFeaturesMask(CONTEXT* Context, ulong* FeatureMask);

@DllImport("KERNEL32.dll")
void* LocateXStateFeature(CONTEXT* Context, uint FeatureId, uint* Length);

@DllImport("KERNEL32.dll")
BOOL SetXStateFeaturesMask(CONTEXT* Context, ulong FeatureMask);

@DllImport("ntdll.dll")
uint RtlNtStatusToDosError(NTSTATUS Status);

@DllImport("KERNEL32.dll")
BOOL IsDebuggerPresent();

@DllImport("KERNEL32.dll")
void DebugBreak();

@DllImport("KERNEL32.dll")
void OutputDebugStringA(const(char)* lpOutputString);

@DllImport("KERNEL32.dll")
void OutputDebugStringW(const(wchar)* lpOutputString);

@DllImport("KERNEL32.dll")
BOOL ContinueDebugEvent(uint dwProcessId, uint dwThreadId, uint dwContinueStatus);

@DllImport("KERNEL32.dll")
BOOL WaitForDebugEvent(DEBUG_EVENT* lpDebugEvent, uint dwMilliseconds);

@DllImport("KERNEL32.dll")
BOOL DebugActiveProcess(uint dwProcessId);

@DllImport("KERNEL32.dll")
BOOL DebugActiveProcessStop(uint dwProcessId);

@DllImport("KERNEL32.dll")
BOOL CheckRemoteDebuggerPresent(HANDLE hProcess, int* pbDebuggerPresent);

@DllImport("KERNEL32.dll")
BOOL WaitForDebugEventEx(DEBUG_EVENT* lpDebugEvent, uint dwMilliseconds);

@DllImport("KERNEL32.dll")
void* EncodePointer(void* Ptr);

@DllImport("KERNEL32.dll")
void* DecodePointer(void* Ptr);

@DllImport("KERNEL32.dll")
void* EncodeSystemPointer(void* Ptr);

@DllImport("KERNEL32.dll")
void* DecodeSystemPointer(void* Ptr);

@DllImport("api-ms-win-core-util-l1-1-1.dll")
HRESULT EncodeRemotePointer(HANDLE ProcessHandle, void* Ptr, void** EncodedPtr);

@DllImport("api-ms-win-core-util-l1-1-1.dll")
HRESULT DecodeRemotePointer(HANDLE ProcessHandle, void* Ptr, void** DecodedPtr);

@DllImport("KERNEL32.dll")
BOOL Beep(uint dwFreq, uint dwDuration);

@DllImport("KERNEL32.dll")
void RaiseException(uint dwExceptionCode, uint dwExceptionFlags, uint nNumberOfArguments, char* lpArguments);

@DllImport("KERNEL32.dll")
int UnhandledExceptionFilter(EXCEPTION_POINTERS* ExceptionInfo);

@DllImport("KERNEL32.dll")
LPTOP_LEVEL_EXCEPTION_FILTER SetUnhandledExceptionFilter(LPTOP_LEVEL_EXCEPTION_FILTER lpTopLevelExceptionFilter);

@DllImport("KERNEL32.dll")
uint GetLastError();

@DllImport("KERNEL32.dll")
void SetLastError(uint dwErrCode);

@DllImport("KERNEL32.dll")
uint GetErrorMode();

@DllImport("KERNEL32.dll")
uint SetErrorMode(uint uMode);

@DllImport("KERNEL32.dll")
void* AddVectoredExceptionHandler(uint First, PVECTORED_EXCEPTION_HANDLER Handler);

@DllImport("KERNEL32.dll")
uint RemoveVectoredExceptionHandler(void* Handle);

@DllImport("KERNEL32.dll")
void* AddVectoredContinueHandler(uint First, PVECTORED_EXCEPTION_HANDLER Handler);

@DllImport("KERNEL32.dll")
uint RemoveVectoredContinueHandler(void* Handle);

@DllImport("KERNEL32.dll")
void RaiseFailFastException(EXCEPTION_RECORD* pExceptionRecord, CONTEXT* pContextRecord, uint dwFlags);

@DllImport("KERNEL32.dll")
void FatalAppExitA(uint uAction, const(char)* lpMessageText);

@DllImport("KERNEL32.dll")
void FatalAppExitW(uint uAction, const(wchar)* lpMessageText);

@DllImport("KERNEL32.dll")
uint GetThreadErrorMode();

@DllImport("KERNEL32.dll")
BOOL SetThreadErrorMode(uint dwNewMode, uint* lpOldMode);

@DllImport("api-ms-win-core-errorhandling-l1-1-3.dll")
void TerminateProcessOnMemoryExhaustion(uint FailedAllocationSize);

@DllImport("ADVAPI32.dll")
void* OpenThreadWaitChainSession(uint Flags, PWAITCHAINCALLBACK callback);

@DllImport("ADVAPI32.dll")
void CloseThreadWaitChainSession(void* WctHandle);

@DllImport("ADVAPI32.dll")
BOOL GetThreadWaitChain(void* WctHandle, uint Context, uint Flags, uint ThreadId, uint* NodeCount, char* NodeInfoArray, int* IsCycle);

@DllImport("ADVAPI32.dll")
void RegisterWaitChainCOMCallback(PCOGETCALLSTATE CallStateCallback, PCOGETACTIVATIONSTATE ActivationStateCallback);

@DllImport("api-ms-win-core-debug-minidump-l1-1-0.dll")
BOOL MiniDumpWriteDump(HANDLE hProcess, uint ProcessId, HANDLE hFile, MINIDUMP_TYPE DumpType, MINIDUMP_EXCEPTION_INFORMATION* ExceptionParam, MINIDUMP_USER_STREAM_INFORMATION* UserStreamParam, MINIDUMP_CALLBACK_INFORMATION* CallbackParam);

@DllImport("api-ms-win-core-debug-minidump-l1-1-0.dll")
BOOL MiniDumpReadDumpStream(void* BaseOfDump, uint StreamNumber, MINIDUMP_DIRECTORY** Dir, void** StreamPointer, uint* StreamSize);

struct EXCEPTION_DEBUG_INFO
{
    EXCEPTION_RECORD ExceptionRecord;
    uint dwFirstChance;
}

struct CREATE_THREAD_DEBUG_INFO
{
    HANDLE hThread;
    void* lpThreadLocalBase;
    LPTHREAD_START_ROUTINE lpStartAddress;
}

struct CREATE_PROCESS_DEBUG_INFO
{
    HANDLE hFile;
    HANDLE hProcess;
    HANDLE hThread;
    void* lpBaseOfImage;
    uint dwDebugInfoFileOffset;
    uint nDebugInfoSize;
    void* lpThreadLocalBase;
    LPTHREAD_START_ROUTINE lpStartAddress;
    void* lpImageName;
    ushort fUnicode;
}

struct EXIT_THREAD_DEBUG_INFO
{
    uint dwExitCode;
}

struct EXIT_PROCESS_DEBUG_INFO
{
    uint dwExitCode;
}

struct LOAD_DLL_DEBUG_INFO
{
    HANDLE hFile;
    void* lpBaseOfDll;
    uint dwDebugInfoFileOffset;
    uint nDebugInfoSize;
    void* lpImageName;
    ushort fUnicode;
}

struct UNLOAD_DLL_DEBUG_INFO
{
    void* lpBaseOfDll;
}

struct OUTPUT_DEBUG_STRING_INFO
{
    const(char)* lpDebugStringData;
    ushort fUnicode;
    ushort nDebugStringLength;
}

struct RIP_INFO
{
    uint dwError;
    uint dwType;
}

struct DEBUG_EVENT
{
    uint dwDebugEventCode;
    uint dwProcessId;
    uint dwThreadId;
    _u_e__Union u;
}

struct FLASHWINFO
{
    uint cbSize;
    HWND hwnd;
    uint dwFlags;
    uint uCount;
    uint dwTimeout;
}

alias PTOP_LEVEL_EXCEPTION_FILTER = extern(Windows) int function(EXCEPTION_POINTERS* ExceptionInfo);
alias LPTOP_LEVEL_EXCEPTION_FILTER = extern(Windows) int function();
enum WCT_OBJECT_TYPE
{
    WctCriticalSectionType = 1,
    WctSendMessageType = 2,
    WctMutexType = 3,
    WctAlpcType = 4,
    WctComType = 5,
    WctThreadWaitType = 6,
    WctProcessWaitType = 7,
    WctThreadType = 8,
    WctComActivationType = 9,
    WctUnknownType = 10,
    WctSocketIoType = 11,
    WctSmbIoType = 12,
    WctMaxType = 13,
}

enum WCT_OBJECT_STATUS
{
    WctStatusNoAccess = 1,
    WctStatusRunning = 2,
    WctStatusBlocked = 3,
    WctStatusPidOnly = 4,
    WctStatusPidOnlyRpcss = 5,
    WctStatusOwned = 6,
    WctStatusNotOwned = 7,
    WctStatusAbandoned = 8,
    WctStatusUnknown = 9,
    WctStatusError = 10,
    WctStatusMax = 11,
}

struct WAITCHAIN_NODE_INFO
{
    WCT_OBJECT_TYPE ObjectType;
    WCT_OBJECT_STATUS ObjectStatus;
    _Anonymous_e__Union Anonymous;
}

alias PWAITCHAINCALLBACK = extern(Windows) void function(void* WctHandle, uint Context, uint CallbackStatus, uint* NodeCount, WAITCHAIN_NODE_INFO* NodeInfoArray, int* IsCycle);
alias PCOGETCALLSTATE = extern(Windows) HRESULT function(int param0, uint* param1);
alias PCOGETACTIVATIONSTATE = extern(Windows) HRESULT function(Guid param0, uint param1, uint* param2);
struct MINIDUMP_LOCATION_DESCRIPTOR
{
    uint DataSize;
    uint Rva;
}

struct MINIDUMP_LOCATION_DESCRIPTOR64
{
    ulong DataSize;
    ulong Rva;
}

struct MINIDUMP_MEMORY_DESCRIPTOR
{
    ulong StartOfMemoryRange;
    MINIDUMP_LOCATION_DESCRIPTOR Memory;
}

struct MINIDUMP_MEMORY_DESCRIPTOR64
{
    ulong StartOfMemoryRange;
    ulong DataSize;
}

struct MINIDUMP_HEADER
{
    uint Signature;
    uint Version;
    uint NumberOfStreams;
    uint StreamDirectoryRva;
    uint CheckSum;
    _Anonymous_e__Union Anonymous;
    ulong Flags;
}

struct MINIDUMP_DIRECTORY
{
    uint StreamType;
    MINIDUMP_LOCATION_DESCRIPTOR Location;
}

struct MINIDUMP_STRING
{
    uint Length;
    ushort Buffer;
}

enum MINIDUMP_STREAM_TYPE
{
    UnusedStream = 0,
    ReservedStream0 = 1,
    ReservedStream1 = 2,
    ThreadListStream = 3,
    ModuleListStream = 4,
    MemoryListStream = 5,
    ExceptionStream = 6,
    SystemInfoStream = 7,
    ThreadExListStream = 8,
    Memory64ListStream = 9,
    CommentStreamA = 10,
    CommentStreamW = 11,
    HandleDataStream = 12,
    FunctionTableStream = 13,
    UnloadedModuleListStream = 14,
    MiscInfoStream = 15,
    MemoryInfoListStream = 16,
    ThreadInfoListStream = 17,
    HandleOperationListStream = 18,
    TokenStream = 19,
    JavaScriptDataStream = 20,
    SystemMemoryInfoStream = 21,
    ProcessVmCountersStream = 22,
    IptTraceStream = 23,
    ThreadNamesStream = 24,
    ceStreamNull = 32768,
    ceStreamSystemInfo = 32769,
    ceStreamException = 32770,
    ceStreamModuleList = 32771,
    ceStreamProcessList = 32772,
    ceStreamThreadList = 32773,
    ceStreamThreadContextList = 32774,
    ceStreamThreadCallStackList = 32775,
    ceStreamMemoryVirtualList = 32776,
    ceStreamMemoryPhysicalList = 32777,
    ceStreamBucketParameters = 32778,
    ceStreamProcessModuleMap = 32779,
    ceStreamDiagnosisList = 32780,
    LastReservedStream = 65535,
}

struct CPU_INFORMATION
{
    _X86CpuInfo_e__Struct X86CpuInfo;
    _OtherCpuInfo_e__Struct OtherCpuInfo;
}

struct MINIDUMP_SYSTEM_INFO
{
    ushort ProcessorArchitecture;
    ushort ProcessorLevel;
    ushort ProcessorRevision;
    _Anonymous1_e__Union Anonymous1;
    uint MajorVersion;
    uint MinorVersion;
    uint BuildNumber;
    uint PlatformId;
    uint CSDVersionRva;
    _Anonymous2_e__Union Anonymous2;
    CPU_INFORMATION Cpu;
}

struct MINIDUMP_THREAD
{
    uint ThreadId;
    uint SuspendCount;
    uint PriorityClass;
    uint Priority;
    ulong Teb;
    MINIDUMP_MEMORY_DESCRIPTOR Stack;
    MINIDUMP_LOCATION_DESCRIPTOR ThreadContext;
}

struct MINIDUMP_THREAD_LIST
{
    uint NumberOfThreads;
    MINIDUMP_THREAD Threads;
}

struct MINIDUMP_THREAD_EX
{
    uint ThreadId;
    uint SuspendCount;
    uint PriorityClass;
    uint Priority;
    ulong Teb;
    MINIDUMP_MEMORY_DESCRIPTOR Stack;
    MINIDUMP_LOCATION_DESCRIPTOR ThreadContext;
    MINIDUMP_MEMORY_DESCRIPTOR BackingStore;
}

struct MINIDUMP_THREAD_EX_LIST
{
    uint NumberOfThreads;
    MINIDUMP_THREAD_EX Threads;
}

struct MINIDUMP_EXCEPTION
{
    uint ExceptionCode;
    uint ExceptionFlags;
    ulong ExceptionRecord;
    ulong ExceptionAddress;
    uint NumberParameters;
    uint __unusedAlignment;
    ulong ExceptionInformation;
}

struct MINIDUMP_EXCEPTION_STREAM
{
    uint ThreadId;
    uint __alignment;
    MINIDUMP_EXCEPTION ExceptionRecord;
    MINIDUMP_LOCATION_DESCRIPTOR ThreadContext;
}

struct MINIDUMP_MODULE
{
    ulong BaseOfImage;
    uint SizeOfImage;
    uint CheckSum;
    uint TimeDateStamp;
    uint ModuleNameRva;
    VS_FIXEDFILEINFO VersionInfo;
    MINIDUMP_LOCATION_DESCRIPTOR CvRecord;
    MINIDUMP_LOCATION_DESCRIPTOR MiscRecord;
    ulong Reserved0;
    ulong Reserved1;
}

struct MINIDUMP_MODULE_LIST
{
    uint NumberOfModules;
    MINIDUMP_MODULE Modules;
}

struct MINIDUMP_MEMORY_LIST
{
    uint NumberOfMemoryRanges;
    MINIDUMP_MEMORY_DESCRIPTOR MemoryRanges;
}

struct MINIDUMP_MEMORY64_LIST
{
    ulong NumberOfMemoryRanges;
    ulong BaseRva;
    MINIDUMP_MEMORY_DESCRIPTOR64 MemoryRanges;
}

struct MINIDUMP_EXCEPTION_INFORMATION
{
    uint ThreadId;
    EXCEPTION_POINTERS* ExceptionPointers;
    BOOL ClientPointers;
}

struct MINIDUMP_EXCEPTION_INFORMATION64
{
    uint ThreadId;
    ulong ExceptionRecord;
    ulong ContextRecord;
    BOOL ClientPointers;
}

enum MINIDUMP_HANDLE_OBJECT_INFORMATION_TYPE
{
    MiniHandleObjectInformationNone = 0,
    MiniThreadInformation1 = 1,
    MiniMutantInformation1 = 2,
    MiniMutantInformation2 = 3,
    MiniProcessInformation1 = 4,
    MiniProcessInformation2 = 5,
    MiniEventInformation1 = 6,
    MiniSectionInformation1 = 7,
    MiniSemaphoreInformation1 = 8,
    MiniHandleObjectInformationTypeMax = 9,
}

struct MINIDUMP_HANDLE_OBJECT_INFORMATION
{
    uint NextInfoRva;
    uint InfoType;
    uint SizeOfInfo;
}

struct MINIDUMP_HANDLE_DESCRIPTOR
{
    ulong Handle;
    uint TypeNameRva;
    uint ObjectNameRva;
    uint Attributes;
    uint GrantedAccess;
    uint HandleCount;
    uint PointerCount;
}

struct MINIDUMP_HANDLE_DESCRIPTOR_2
{
    ulong Handle;
    uint TypeNameRva;
    uint ObjectNameRva;
    uint Attributes;
    uint GrantedAccess;
    uint HandleCount;
    uint PointerCount;
    uint ObjectInfoRva;
    uint Reserved0;
}

struct MINIDUMP_HANDLE_DATA_STREAM
{
    uint SizeOfHeader;
    uint SizeOfDescriptor;
    uint NumberOfDescriptors;
    uint Reserved;
}

struct MINIDUMP_HANDLE_OPERATION_LIST
{
    uint SizeOfHeader;
    uint SizeOfEntry;
    uint NumberOfEntries;
    uint Reserved;
}

struct MINIDUMP_FUNCTION_TABLE_DESCRIPTOR
{
    ulong MinimumAddress;
    ulong MaximumAddress;
    ulong BaseAddress;
    uint EntryCount;
    uint SizeOfAlignPad;
}

struct MINIDUMP_FUNCTION_TABLE_STREAM
{
    uint SizeOfHeader;
    uint SizeOfDescriptor;
    uint SizeOfNativeDescriptor;
    uint SizeOfFunctionEntry;
    uint NumberOfDescriptors;
    uint SizeOfAlignPad;
}

struct MINIDUMP_UNLOADED_MODULE
{
    ulong BaseOfImage;
    uint SizeOfImage;
    uint CheckSum;
    uint TimeDateStamp;
    uint ModuleNameRva;
}

struct MINIDUMP_UNLOADED_MODULE_LIST
{
    uint SizeOfHeader;
    uint SizeOfEntry;
    uint NumberOfEntries;
}

struct XSTATE_CONFIG_FEATURE_MSC_INFO
{
    uint SizeOfInfo;
    uint ContextSize;
    ulong EnabledFeatures;
    XSTATE_FEATURE Features;
}

struct MINIDUMP_MISC_INFO
{
    uint SizeOfInfo;
    uint Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
}

struct MINIDUMP_MISC_INFO_2
{
    uint SizeOfInfo;
    uint Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
    uint ProcessorMaxMhz;
    uint ProcessorCurrentMhz;
    uint ProcessorMhzLimit;
    uint ProcessorMaxIdleState;
    uint ProcessorCurrentIdleState;
}

struct MINIDUMP_MISC_INFO_3
{
    uint SizeOfInfo;
    uint Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
    uint ProcessorMaxMhz;
    uint ProcessorCurrentMhz;
    uint ProcessorMhzLimit;
    uint ProcessorMaxIdleState;
    uint ProcessorCurrentIdleState;
    uint ProcessIntegrityLevel;
    uint ProcessExecuteFlags;
    uint ProtectedProcess;
    uint TimeZoneId;
    TIME_ZONE_INFORMATION TimeZone;
}

struct MINIDUMP_MISC_INFO_4
{
    uint SizeOfInfo;
    uint Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
    uint ProcessorMaxMhz;
    uint ProcessorCurrentMhz;
    uint ProcessorMhzLimit;
    uint ProcessorMaxIdleState;
    uint ProcessorCurrentIdleState;
    uint ProcessIntegrityLevel;
    uint ProcessExecuteFlags;
    uint ProtectedProcess;
    uint TimeZoneId;
    TIME_ZONE_INFORMATION TimeZone;
    ushort BuildString;
    ushort DbgBldStr;
}

struct MINIDUMP_MISC_INFO_5
{
    uint SizeOfInfo;
    uint Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
    uint ProcessorMaxMhz;
    uint ProcessorCurrentMhz;
    uint ProcessorMhzLimit;
    uint ProcessorMaxIdleState;
    uint ProcessorCurrentIdleState;
    uint ProcessIntegrityLevel;
    uint ProcessExecuteFlags;
    uint ProtectedProcess;
    uint TimeZoneId;
    TIME_ZONE_INFORMATION TimeZone;
    ushort BuildString;
    ushort DbgBldStr;
    XSTATE_CONFIG_FEATURE_MSC_INFO XStateData;
    uint ProcessCookie;
}

struct MINIDUMP_MEMORY_INFO
{
    ulong BaseAddress;
    ulong AllocationBase;
    uint AllocationProtect;
    uint __alignment1;
    ulong RegionSize;
    uint State;
    uint Protect;
    uint Type;
    uint __alignment2;
}

struct MINIDUMP_MEMORY_INFO_LIST
{
    uint SizeOfHeader;
    uint SizeOfEntry;
    ulong NumberOfEntries;
}

struct MINIDUMP_THREAD_NAME
{
    uint ThreadId;
    ulong RvaOfThreadName;
}

struct MINIDUMP_THREAD_NAME_LIST
{
    uint NumberOfThreadNames;
    MINIDUMP_THREAD_NAME ThreadNames;
}

struct MINIDUMP_THREAD_INFO
{
    uint ThreadId;
    uint DumpFlags;
    uint DumpError;
    uint ExitStatus;
    ulong CreateTime;
    ulong ExitTime;
    ulong KernelTime;
    ulong UserTime;
    ulong StartAddress;
    ulong Affinity;
}

struct MINIDUMP_THREAD_INFO_LIST
{
    uint SizeOfHeader;
    uint SizeOfEntry;
    uint NumberOfEntries;
}

struct MINIDUMP_TOKEN_INFO_HEADER
{
    uint TokenSize;
    uint TokenId;
    ulong TokenHandle;
}

struct MINIDUMP_TOKEN_INFO_LIST
{
    uint TokenListSize;
    uint TokenListEntries;
    uint ListHeaderSize;
    uint ElementHeaderSize;
}

struct MINIDUMP_SYSTEM_BASIC_INFORMATION
{
    uint TimerResolution;
    uint PageSize;
    uint NumberOfPhysicalPages;
    uint LowestPhysicalPageNumber;
    uint HighestPhysicalPageNumber;
    uint AllocationGranularity;
    ulong MinimumUserModeAddress;
    ulong MaximumUserModeAddress;
    ulong ActiveProcessorsAffinityMask;
    uint NumberOfProcessors;
}

struct MINIDUMP_SYSTEM_FILECACHE_INFORMATION
{
    ulong CurrentSize;
    ulong PeakSize;
    uint PageFaultCount;
    ulong MinimumWorkingSet;
    ulong MaximumWorkingSet;
    ulong CurrentSizeIncludingTransitionInPages;
    ulong PeakSizeIncludingTransitionInPages;
    uint TransitionRePurposeCount;
    uint Flags;
}

struct MINIDUMP_SYSTEM_BASIC_PERFORMANCE_INFORMATION
{
    ulong AvailablePages;
    ulong CommittedPages;
    ulong CommitLimit;
    ulong PeakCommitment;
}

struct MINIDUMP_SYSTEM_PERFORMANCE_INFORMATION
{
    ulong IdleProcessTime;
    ulong IoReadTransferCount;
    ulong IoWriteTransferCount;
    ulong IoOtherTransferCount;
    uint IoReadOperationCount;
    uint IoWriteOperationCount;
    uint IoOtherOperationCount;
    uint AvailablePages;
    uint CommittedPages;
    uint CommitLimit;
    uint PeakCommitment;
    uint PageFaultCount;
    uint CopyOnWriteCount;
    uint TransitionCount;
    uint CacheTransitionCount;
    uint DemandZeroCount;
    uint PageReadCount;
    uint PageReadIoCount;
    uint CacheReadCount;
    uint CacheIoCount;
    uint DirtyPagesWriteCount;
    uint DirtyWriteIoCount;
    uint MappedPagesWriteCount;
    uint MappedWriteIoCount;
    uint PagedPoolPages;
    uint NonPagedPoolPages;
    uint PagedPoolAllocs;
    uint PagedPoolFrees;
    uint NonPagedPoolAllocs;
    uint NonPagedPoolFrees;
    uint FreeSystemPtes;
    uint ResidentSystemCodePage;
    uint TotalSystemDriverPages;
    uint TotalSystemCodePages;
    uint NonPagedPoolLookasideHits;
    uint PagedPoolLookasideHits;
    uint AvailablePagedPoolPages;
    uint ResidentSystemCachePage;
    uint ResidentPagedPoolPage;
    uint ResidentSystemDriverPage;
    uint CcFastReadNoWait;
    uint CcFastReadWait;
    uint CcFastReadResourceMiss;
    uint CcFastReadNotPossible;
    uint CcFastMdlReadNoWait;
    uint CcFastMdlReadWait;
    uint CcFastMdlReadResourceMiss;
    uint CcFastMdlReadNotPossible;
    uint CcMapDataNoWait;
    uint CcMapDataWait;
    uint CcMapDataNoWaitMiss;
    uint CcMapDataWaitMiss;
    uint CcPinMappedDataCount;
    uint CcPinReadNoWait;
    uint CcPinReadWait;
    uint CcPinReadNoWaitMiss;
    uint CcPinReadWaitMiss;
    uint CcCopyReadNoWait;
    uint CcCopyReadWait;
    uint CcCopyReadNoWaitMiss;
    uint CcCopyReadWaitMiss;
    uint CcMdlReadNoWait;
    uint CcMdlReadWait;
    uint CcMdlReadNoWaitMiss;
    uint CcMdlReadWaitMiss;
    uint CcReadAheadIos;
    uint CcLazyWriteIos;
    uint CcLazyWritePages;
    uint CcDataFlushes;
    uint CcDataPages;
    uint ContextSwitches;
    uint FirstLevelTbFills;
    uint SecondLevelTbFills;
    uint SystemCalls;
    ulong CcTotalDirtyPages;
    ulong CcDirtyPageThreshold;
    long ResidentAvailablePages;
    ulong SharedCommittedPages;
}

struct MINIDUMP_SYSTEM_MEMORY_INFO_1
{
    ushort Revision;
    ushort Flags;
    MINIDUMP_SYSTEM_BASIC_INFORMATION BasicInfo;
    MINIDUMP_SYSTEM_FILECACHE_INFORMATION FileCacheInfo;
    MINIDUMP_SYSTEM_BASIC_PERFORMANCE_INFORMATION BasicPerfInfo;
    MINIDUMP_SYSTEM_PERFORMANCE_INFORMATION PerfInfo;
}

struct MINIDUMP_PROCESS_VM_COUNTERS_1
{
    ushort Revision;
    uint PageFaultCount;
    ulong PeakWorkingSetSize;
    ulong WorkingSetSize;
    ulong QuotaPeakPagedPoolUsage;
    ulong QuotaPagedPoolUsage;
    ulong QuotaPeakNonPagedPoolUsage;
    ulong QuotaNonPagedPoolUsage;
    ulong PagefileUsage;
    ulong PeakPagefileUsage;
    ulong PrivateUsage;
}

struct MINIDUMP_PROCESS_VM_COUNTERS_2
{
    ushort Revision;
    ushort Flags;
    uint PageFaultCount;
    ulong PeakWorkingSetSize;
    ulong WorkingSetSize;
    ulong QuotaPeakPagedPoolUsage;
    ulong QuotaPagedPoolUsage;
    ulong QuotaPeakNonPagedPoolUsage;
    ulong QuotaNonPagedPoolUsage;
    ulong PagefileUsage;
    ulong PeakPagefileUsage;
    ulong PeakVirtualSize;
    ulong VirtualSize;
    ulong PrivateUsage;
    ulong PrivateWorkingSetSize;
    ulong SharedCommitUsage;
    ulong JobSharedCommitUsage;
    ulong JobPrivateCommitUsage;
    ulong JobPeakPrivateCommitUsage;
    ulong JobPrivateCommitLimit;
    ulong JobTotalCommitLimit;
}

struct MINIDUMP_USER_RECORD
{
    uint Type;
    MINIDUMP_LOCATION_DESCRIPTOR Memory;
}

struct MINIDUMP_USER_STREAM
{
    uint Type;
    uint BufferSize;
    void* Buffer;
}

struct MINIDUMP_USER_STREAM_INFORMATION
{
    uint UserStreamCount;
    MINIDUMP_USER_STREAM* UserStreamArray;
}

enum MINIDUMP_CALLBACK_TYPE
{
    ModuleCallback = 0,
    ThreadCallback = 1,
    ThreadExCallback = 2,
    IncludeThreadCallback = 3,
    IncludeModuleCallback = 4,
    MemoryCallback = 5,
    CancelCallback = 6,
    WriteKernelMinidumpCallback = 7,
    KernelMinidumpStatusCallback = 8,
    RemoveMemoryCallback = 9,
    IncludeVmRegionCallback = 10,
    IoStartCallback = 11,
    IoWriteAllCallback = 12,
    IoFinishCallback = 13,
    ReadMemoryFailureCallback = 14,
    SecondaryFlagsCallback = 15,
    IsProcessSnapshotCallback = 16,
    VmStartCallback = 17,
    VmQueryCallback = 18,
    VmPreReadCallback = 19,
    VmPostReadCallback = 20,
}

struct MINIDUMP_THREAD_CALLBACK
{
    uint ThreadId;
    HANDLE ThreadHandle;
    CONTEXT Context;
    uint SizeOfContext;
    ulong StackBase;
    ulong StackEnd;
}

struct MINIDUMP_THREAD_EX_CALLBACK
{
    uint ThreadId;
    HANDLE ThreadHandle;
    CONTEXT Context;
    uint SizeOfContext;
    ulong StackBase;
    ulong StackEnd;
    ulong BackingStoreBase;
    ulong BackingStoreEnd;
}

struct MINIDUMP_INCLUDE_THREAD_CALLBACK
{
    uint ThreadId;
}

enum THREAD_WRITE_FLAGS
{
    ThreadWriteThread = 1,
    ThreadWriteStack = 2,
    ThreadWriteContext = 4,
    ThreadWriteBackingStore = 8,
    ThreadWriteInstructionWindow = 16,
    ThreadWriteThreadData = 32,
    ThreadWriteThreadInfo = 64,
}

struct MINIDUMP_MODULE_CALLBACK
{
    const(wchar)* FullPath;
    ulong BaseOfImage;
    uint SizeOfImage;
    uint CheckSum;
    uint TimeDateStamp;
    VS_FIXEDFILEINFO VersionInfo;
    void* CvRecord;
    uint SizeOfCvRecord;
    void* MiscRecord;
    uint SizeOfMiscRecord;
}

struct MINIDUMP_INCLUDE_MODULE_CALLBACK
{
    ulong BaseOfImage;
}

enum MODULE_WRITE_FLAGS
{
    ModuleWriteModule = 1,
    ModuleWriteDataSeg = 2,
    ModuleWriteMiscRecord = 4,
    ModuleWriteCvRecord = 8,
    ModuleReferencedByMemory = 16,
    ModuleWriteTlsData = 32,
    ModuleWriteCodeSegs = 64,
}

struct MINIDUMP_IO_CALLBACK
{
    HANDLE Handle;
    ulong Offset;
    void* Buffer;
    uint BufferBytes;
}

struct MINIDUMP_READ_MEMORY_FAILURE_CALLBACK
{
    ulong Offset;
    uint Bytes;
    HRESULT FailureStatus;
}

struct MINIDUMP_VM_QUERY_CALLBACK
{
    ulong Offset;
}

struct MINIDUMP_VM_PRE_READ_CALLBACK
{
    ulong Offset;
    void* Buffer;
    uint Size;
}

struct MINIDUMP_VM_POST_READ_CALLBACK
{
    ulong Offset;
    void* Buffer;
    uint Size;
    uint Completed;
    HRESULT Status;
}

struct MINIDUMP_CALLBACK_INPUT
{
    uint ProcessId;
    HANDLE ProcessHandle;
    uint CallbackType;
    _Anonymous_e__Union Anonymous;
}

struct MINIDUMP_CALLBACK_OUTPUT
{
    _Anonymous_e__Union Anonymous;
}

enum MINIDUMP_TYPE
{
    MiniDumpNormal = 0,
    MiniDumpWithDataSegs = 1,
    MiniDumpWithFullMemory = 2,
    MiniDumpWithHandleData = 4,
    MiniDumpFilterMemory = 8,
    MiniDumpScanMemory = 16,
    MiniDumpWithUnloadedModules = 32,
    MiniDumpWithIndirectlyReferencedMemory = 64,
    MiniDumpFilterModulePaths = 128,
    MiniDumpWithProcessThreadData = 256,
    MiniDumpWithPrivateReadWriteMemory = 512,
    MiniDumpWithoutOptionalData = 1024,
    MiniDumpWithFullMemoryInfo = 2048,
    MiniDumpWithThreadInfo = 4096,
    MiniDumpWithCodeSegs = 8192,
    MiniDumpWithoutAuxiliaryState = 16384,
    MiniDumpWithFullAuxiliaryState = 32768,
    MiniDumpWithPrivateWriteCopyMemory = 65536,
    MiniDumpIgnoreInaccessibleMemory = 131072,
    MiniDumpWithTokenInformation = 262144,
    MiniDumpWithModuleHeaders = 524288,
    MiniDumpFilterTriage = 1048576,
    MiniDumpWithAvxXStateContext = 2097152,
    MiniDumpWithIptTrace = 4194304,
    MiniDumpScanInaccessiblePartialPages = 8388608,
    MiniDumpValidTypeFlags = 16777215,
}

enum MINIDUMP_SECONDARY_FLAGS
{
    MiniSecondaryWithoutPowerInfo = 1,
    MiniSecondaryValidFlags = 1,
}

alias MINIDUMP_CALLBACK_ROUTINE = extern(Windows) BOOL function(void* CallbackParam, MINIDUMP_CALLBACK_INPUT* CallbackInput, MINIDUMP_CALLBACK_OUTPUT* CallbackOutput);
struct MINIDUMP_CALLBACK_INFORMATION
{
    MINIDUMP_CALLBACK_ROUTINE CallbackRoutine;
    void* CallbackParam;
}

const GUID CLSID_ProcessDebugManager = {0x78A51822, 0x51F4, 0x11D0, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]};
@GUID(0x78A51822, 0x51F4, 0x11D0, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]);
struct ProcessDebugManager;

const GUID CLSID_DebugHelper = {0x0BFCC060, 0x8C1D, 0x11D0, [0xAC, 0xCD, 0x00, 0xAA, 0x00, 0x60, 0x27, 0x5C]};
@GUID(0x0BFCC060, 0x8C1D, 0x11D0, [0xAC, 0xCD, 0x00, 0xAA, 0x00, 0x60, 0x27, 0x5C]);
struct DebugHelper;

const GUID CLSID_CDebugDocumentHelper = {0x83B8BCA6, 0x687C, 0x11D0, [0xA4, 0x05, 0x00, 0xAA, 0x00, 0x60, 0x27, 0x5C]};
@GUID(0x83B8BCA6, 0x687C, 0x11D0, [0xA4, 0x05, 0x00, 0xAA, 0x00, 0x60, 0x27, 0x5C]);
struct CDebugDocumentHelper;

const GUID CLSID_MachineDebugManager_RETAIL = {0x0C0A3666, 0x30C9, 0x11D0, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]};
@GUID(0x0C0A3666, 0x30C9, 0x11D0, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]);
struct MachineDebugManager_RETAIL;

const GUID CLSID_MachineDebugManager_DEBUG = {0x49769CEC, 0x3A55, 0x4BB0, [0xB6, 0x97, 0x88, 0xFE, 0xDE, 0x77, 0xE8, 0xEA]};
@GUID(0x49769CEC, 0x3A55, 0x4BB0, [0xB6, 0x97, 0x88, 0xFE, 0xDE, 0x77, 0xE8, 0xEA]);
struct MachineDebugManager_DEBUG;

const GUID CLSID_DefaultDebugSessionProvider = {0x834128A2, 0x51F4, 0x11D0, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]};
@GUID(0x834128A2, 0x51F4, 0x11D0, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]);
struct DefaultDebugSessionProvider;

enum SCRIPTLANGUAGEVERSION
{
    SCRIPTLANGUAGEVERSION_DEFAULT = 0,
    SCRIPTLANGUAGEVERSION_5_7 = 1,
    SCRIPTLANGUAGEVERSION_5_8 = 2,
    SCRIPTLANGUAGEVERSION_MAX = 255,
}

enum SCRIPTSTATE
{
    SCRIPTSTATE_UNINITIALIZED = 0,
    SCRIPTSTATE_INITIALIZED = 5,
    SCRIPTSTATE_STARTED = 1,
    SCRIPTSTATE_CONNECTED = 2,
    SCRIPTSTATE_DISCONNECTED = 3,
    SCRIPTSTATE_CLOSED = 4,
}

enum SCRIPTTRACEINFO
{
    SCRIPTTRACEINFO_SCRIPTSTART = 0,
    SCRIPTTRACEINFO_SCRIPTEND = 1,
    SCRIPTTRACEINFO_COMCALLSTART = 2,
    SCRIPTTRACEINFO_COMCALLEND = 3,
    SCRIPTTRACEINFO_CREATEOBJSTART = 4,
    SCRIPTTRACEINFO_CREATEOBJEND = 5,
    SCRIPTTRACEINFO_GETOBJSTART = 6,
    SCRIPTTRACEINFO_GETOBJEND = 7,
}

enum SCRIPTTHREADSTATE
{
    SCRIPTTHREADSTATE_NOTINSCRIPT = 0,
    SCRIPTTHREADSTATE_RUNNING = 1,
}

enum SCRIPTGCTYPE
{
    SCRIPTGCTYPE_NORMAL = 0,
    SCRIPTGCTYPE_EXHAUSTIVE = 1,
}

enum SCRIPTUICITEM
{
    SCRIPTUICITEM_INPUTBOX = 1,
    SCRIPTUICITEM_MSGBOX = 2,
}

enum SCRIPTUICHANDLING
{
    SCRIPTUICHANDLING_ALLOW = 0,
    SCRIPTUICHANDLING_NOUIERROR = 1,
    SCRIPTUICHANDLING_NOUIDEFAULT = 2,
}

const GUID IID_IActiveScriptSite = {0xDB01A1E3, 0xA42B, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]};
@GUID(0xDB01A1E3, 0xA42B, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]);
interface IActiveScriptSite : IUnknown
{
    HRESULT GetLCID(uint* plcid);
    HRESULT GetItemInfo(ushort* pstrName, uint dwReturnMask, IUnknown* ppiunkItem, ITypeInfo* ppti);
    HRESULT GetDocVersionString(BSTR* pbstrVersion);
    HRESULT OnScriptTerminate(const(VARIANT)* pvarResult, const(EXCEPINFO)* pexcepinfo);
    HRESULT OnStateChange(SCRIPTSTATE ssScriptState);
    HRESULT OnScriptError(IActiveScriptError pscripterror);
    HRESULT OnEnterScript();
    HRESULT OnLeaveScript();
}

const GUID IID_IActiveScriptError = {0xEAE1BA61, 0xA4ED, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]};
@GUID(0xEAE1BA61, 0xA4ED, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]);
interface IActiveScriptError : IUnknown
{
    HRESULT GetExceptionInfo(EXCEPINFO* pexcepinfo);
    HRESULT GetSourcePosition(uint* pdwSourceContext, uint* pulLineNumber, int* plCharacterPosition);
    HRESULT GetSourceLineText(BSTR* pbstrSourceLine);
}

const GUID IID_IActiveScriptError64 = {0xB21FB2A1, 0x5B8F, 0x4963, [0x8C, 0x21, 0x21, 0x45, 0x0F, 0x84, 0xED, 0x7F]};
@GUID(0xB21FB2A1, 0x5B8F, 0x4963, [0x8C, 0x21, 0x21, 0x45, 0x0F, 0x84, 0xED, 0x7F]);
interface IActiveScriptError64 : IActiveScriptError
{
    HRESULT GetSourcePosition64(ulong* pdwSourceContext, uint* pulLineNumber, int* plCharacterPosition);
}

const GUID IID_IActiveScriptSiteWindow = {0xD10F6761, 0x83E9, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]};
@GUID(0xD10F6761, 0x83E9, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]);
interface IActiveScriptSiteWindow : IUnknown
{
    HRESULT GetWindow(HWND* phwnd);
    HRESULT EnableModeless(BOOL fEnable);
}

const GUID IID_IActiveScriptSiteUIControl = {0xAEDAE97E, 0xD7EE, 0x4796, [0xB9, 0x60, 0x7F, 0x09, 0x2A, 0xE8, 0x44, 0xAB]};
@GUID(0xAEDAE97E, 0xD7EE, 0x4796, [0xB9, 0x60, 0x7F, 0x09, 0x2A, 0xE8, 0x44, 0xAB]);
interface IActiveScriptSiteUIControl : IUnknown
{
    HRESULT GetUIBehavior(SCRIPTUICITEM UicItem, SCRIPTUICHANDLING* pUicHandling);
}

const GUID IID_IActiveScriptSiteInterruptPoll = {0x539698A0, 0xCDCA, 0x11CF, [0xA5, 0xEB, 0x00, 0xAA, 0x00, 0x47, 0xA0, 0x63]};
@GUID(0x539698A0, 0xCDCA, 0x11CF, [0xA5, 0xEB, 0x00, 0xAA, 0x00, 0x47, 0xA0, 0x63]);
interface IActiveScriptSiteInterruptPoll : IUnknown
{
    HRESULT QueryContinue();
}

const GUID IID_IActiveScript = {0xBB1A2AE1, 0xA4F9, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]};
@GUID(0xBB1A2AE1, 0xA4F9, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]);
interface IActiveScript : IUnknown
{
    HRESULT SetScriptSite(IActiveScriptSite pass);
    HRESULT GetScriptSite(const(Guid)* riid, void** ppvObject);
    HRESULT SetScriptState(SCRIPTSTATE ss);
    HRESULT GetScriptState(SCRIPTSTATE* pssState);
    HRESULT Close();
    HRESULT AddNamedItem(ushort* pstrName, uint dwFlags);
    HRESULT AddTypeLib(const(Guid)* rguidTypeLib, uint dwMajor, uint dwMinor, uint dwFlags);
    HRESULT GetScriptDispatch(ushort* pstrItemName, IDispatch* ppdisp);
    HRESULT GetCurrentScriptThreadID(uint* pstidThread);
    HRESULT GetScriptThreadID(uint dwWin32ThreadId, uint* pstidThread);
    HRESULT GetScriptThreadState(uint stidThread, SCRIPTTHREADSTATE* pstsState);
    HRESULT InterruptScriptThread(uint stidThread, const(EXCEPINFO)* pexcepinfo, uint dwFlags);
    HRESULT Clone(IActiveScript* ppscript);
}

const GUID IID_IActiveScriptParse32 = {0xBB1A2AE2, 0xA4F9, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]};
@GUID(0xBB1A2AE2, 0xA4F9, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]);
interface IActiveScriptParse32 : IUnknown
{
    HRESULT InitNew();
    HRESULT AddScriptlet(ushort* pstrDefaultName, ushort* pstrCode, ushort* pstrItemName, ushort* pstrSubItemName, ushort* pstrEventName, ushort* pstrDelimiter, uint dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, BSTR* pbstrName, EXCEPINFO* pexcepinfo);
    HRESULT ParseScriptText(ushort* pstrCode, ushort* pstrItemName, IUnknown punkContext, ushort* pstrDelimiter, uint dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, VARIANT* pvarResult, EXCEPINFO* pexcepinfo);
}

const GUID IID_IActiveScriptParse64 = {0xC7EF7658, 0xE1EE, 0x480E, [0x97, 0xEA, 0xD5, 0x2C, 0xB4, 0xD7, 0x6D, 0x17]};
@GUID(0xC7EF7658, 0xE1EE, 0x480E, [0x97, 0xEA, 0xD5, 0x2C, 0xB4, 0xD7, 0x6D, 0x17]);
interface IActiveScriptParse64 : IUnknown
{
    HRESULT InitNew();
    HRESULT AddScriptlet(ushort* pstrDefaultName, ushort* pstrCode, ushort* pstrItemName, ushort* pstrSubItemName, ushort* pstrEventName, ushort* pstrDelimiter, ulong dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, BSTR* pbstrName, EXCEPINFO* pexcepinfo);
    HRESULT ParseScriptText(ushort* pstrCode, ushort* pstrItemName, IUnknown punkContext, ushort* pstrDelimiter, ulong dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, VARIANT* pvarResult, EXCEPINFO* pexcepinfo);
}

const GUID IID_IActiveScriptParseProcedureOld32 = {0x1CFF0050, 0x6FDD, 0x11D0, [0x93, 0x28, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]};
@GUID(0x1CFF0050, 0x6FDD, 0x11D0, [0x93, 0x28, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]);
interface IActiveScriptParseProcedureOld32 : IUnknown
{
    HRESULT ParseProcedureText(ushort* pstrCode, ushort* pstrFormalParams, ushort* pstrItemName, IUnknown punkContext, ushort* pstrDelimiter, uint dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, IDispatch* ppdisp);
}

const GUID IID_IActiveScriptParseProcedureOld64 = {0x21F57128, 0x08C9, 0x4638, [0xBA, 0x12, 0x22, 0xD1, 0x5D, 0x88, 0xDC, 0x5C]};
@GUID(0x21F57128, 0x08C9, 0x4638, [0xBA, 0x12, 0x22, 0xD1, 0x5D, 0x88, 0xDC, 0x5C]);
interface IActiveScriptParseProcedureOld64 : IUnknown
{
    HRESULT ParseProcedureText(ushort* pstrCode, ushort* pstrFormalParams, ushort* pstrItemName, IUnknown punkContext, ushort* pstrDelimiter, ulong dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, IDispatch* ppdisp);
}

const GUID IID_IActiveScriptParseProcedure32 = {0xAA5B6A80, 0xB834, 0x11D0, [0x93, 0x2F, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]};
@GUID(0xAA5B6A80, 0xB834, 0x11D0, [0x93, 0x2F, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]);
interface IActiveScriptParseProcedure32 : IUnknown
{
    HRESULT ParseProcedureText(ushort* pstrCode, ushort* pstrFormalParams, ushort* pstrProcedureName, ushort* pstrItemName, IUnknown punkContext, ushort* pstrDelimiter, uint dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, IDispatch* ppdisp);
}

const GUID IID_IActiveScriptParseProcedure64 = {0xC64713B6, 0xE029, 0x4CC5, [0x92, 0x00, 0x43, 0x8B, 0x72, 0x89, 0x0B, 0x6A]};
@GUID(0xC64713B6, 0xE029, 0x4CC5, [0x92, 0x00, 0x43, 0x8B, 0x72, 0x89, 0x0B, 0x6A]);
interface IActiveScriptParseProcedure64 : IUnknown
{
    HRESULT ParseProcedureText(ushort* pstrCode, ushort* pstrFormalParams, ushort* pstrProcedureName, ushort* pstrItemName, IUnknown punkContext, ushort* pstrDelimiter, ulong dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, IDispatch* ppdisp);
}

const GUID IID_IActiveScriptParseProcedure2_32 = {0x71EE5B20, 0xFB04, 0x11D1, [0xB3, 0xA8, 0x00, 0xA0, 0xC9, 0x11, 0xE8, 0xB2]};
@GUID(0x71EE5B20, 0xFB04, 0x11D1, [0xB3, 0xA8, 0x00, 0xA0, 0xC9, 0x11, 0xE8, 0xB2]);
interface IActiveScriptParseProcedure2_32 : IActiveScriptParseProcedure32
{
}

const GUID IID_IActiveScriptParseProcedure2_64 = {0xFE7C4271, 0x210C, 0x448D, [0x9F, 0x54, 0x76, 0xDA, 0xB7, 0x04, 0x7B, 0x28]};
@GUID(0xFE7C4271, 0x210C, 0x448D, [0x9F, 0x54, 0x76, 0xDA, 0xB7, 0x04, 0x7B, 0x28]);
interface IActiveScriptParseProcedure2_64 : IActiveScriptParseProcedure64
{
}

const GUID IID_IActiveScriptEncode = {0xBB1A2AE3, 0xA4F9, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]};
@GUID(0xBB1A2AE3, 0xA4F9, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]);
interface IActiveScriptEncode : IUnknown
{
    HRESULT EncodeSection(ushort* pchIn, uint cchIn, ushort* pchOut, uint cchOut, uint* pcchRet);
    HRESULT DecodeScript(ushort* pchIn, uint cchIn, ushort* pchOut, uint cchOut, uint* pcchRet);
    HRESULT GetEncodeProgId(BSTR* pbstrOut);
}

const GUID IID_IActiveScriptHostEncode = {0xBEE9B76E, 0xCFE3, 0x11D1, [0xB7, 0x47, 0x00, 0xC0, 0x4F, 0xC2, 0xB0, 0x85]};
@GUID(0xBEE9B76E, 0xCFE3, 0x11D1, [0xB7, 0x47, 0x00, 0xC0, 0x4F, 0xC2, 0xB0, 0x85]);
interface IActiveScriptHostEncode : IUnknown
{
    HRESULT EncodeScriptHostFile(BSTR bstrInFile, BSTR* pbstrOutFile, uint cFlags, BSTR bstrDefaultLang);
}

const GUID IID_IBindEventHandler = {0x63CDBCB0, 0xC1B1, 0x11D0, [0x93, 0x36, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]};
@GUID(0x63CDBCB0, 0xC1B1, 0x11D0, [0x93, 0x36, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]);
interface IBindEventHandler : IUnknown
{
    HRESULT BindHandler(ushort* pstrEvent, IDispatch pdisp);
}

const GUID IID_IActiveScriptStats = {0xB8DA6310, 0xE19B, 0x11D0, [0x93, 0x3C, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]};
@GUID(0xB8DA6310, 0xE19B, 0x11D0, [0x93, 0x3C, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]);
interface IActiveScriptStats : IUnknown
{
    HRESULT GetStat(uint stid, uint* pluHi, uint* pluLo);
    HRESULT GetStatEx(const(Guid)* guid, uint* pluHi, uint* pluLo);
    HRESULT ResetStats();
}

const GUID IID_IActiveScriptProperty = {0x4954E0D0, 0xFBC7, 0x11D1, [0x84, 0x10, 0x00, 0x60, 0x08, 0xC3, 0xFB, 0xFC]};
@GUID(0x4954E0D0, 0xFBC7, 0x11D1, [0x84, 0x10, 0x00, 0x60, 0x08, 0xC3, 0xFB, 0xFC]);
interface IActiveScriptProperty : IUnknown
{
    HRESULT GetProperty(uint dwProperty, VARIANT* pvarIndex, VARIANT* pvarValue);
    HRESULT SetProperty(uint dwProperty, VARIANT* pvarIndex, VARIANT* pvarValue);
}

const GUID IID_ITridentEventSink = {0x1DC9CA50, 0x06EF, 0x11D2, [0x84, 0x15, 0x00, 0x60, 0x08, 0xC3, 0xFB, 0xFC]};
@GUID(0x1DC9CA50, 0x06EF, 0x11D2, [0x84, 0x15, 0x00, 0x60, 0x08, 0xC3, 0xFB, 0xFC]);
interface ITridentEventSink : IUnknown
{
    HRESULT FireEvent(ushort* pstrEvent, DISPPARAMS* pdp, VARIANT* pvarRes, EXCEPINFO* pei);
}

const GUID IID_IActiveScriptGarbageCollector = {0x6AA2C4A0, 0x2B53, 0x11D4, [0xA2, 0xA0, 0x00, 0x10, 0x4B, 0xD3, 0x50, 0x90]};
@GUID(0x6AA2C4A0, 0x2B53, 0x11D4, [0xA2, 0xA0, 0x00, 0x10, 0x4B, 0xD3, 0x50, 0x90]);
interface IActiveScriptGarbageCollector : IUnknown
{
    HRESULT CollectGarbage(SCRIPTGCTYPE scriptgctype);
}

const GUID IID_IActiveScriptSIPInfo = {0x764651D0, 0x38DE, 0x11D4, [0xA2, 0xA3, 0x00, 0x10, 0x4B, 0xD3, 0x50, 0x90]};
@GUID(0x764651D0, 0x38DE, 0x11D4, [0xA2, 0xA3, 0x00, 0x10, 0x4B, 0xD3, 0x50, 0x90]);
interface IActiveScriptSIPInfo : IUnknown
{
    HRESULT GetSIPOID(Guid* poid_sip);
}

const GUID IID_IActiveScriptSiteTraceInfo = {0x4B7272AE, 0x1955, 0x4BFE, [0x98, 0xB0, 0x78, 0x06, 0x21, 0x88, 0x85, 0x69]};
@GUID(0x4B7272AE, 0x1955, 0x4BFE, [0x98, 0xB0, 0x78, 0x06, 0x21, 0x88, 0x85, 0x69]);
interface IActiveScriptSiteTraceInfo : IUnknown
{
    HRESULT SendScriptTraceInfo(SCRIPTTRACEINFO stiEventType, Guid guidContextID, uint dwScriptContextCookie, int lScriptStatementStart, int lScriptStatementEnd, ulong dwReserved);
}

const GUID IID_IActiveScriptTraceInfo = {0xC35456E7, 0xBEBF, 0x4A1B, [0x86, 0xA9, 0x24, 0xD5, 0x6B, 0xE8, 0xB3, 0x69]};
@GUID(0xC35456E7, 0xBEBF, 0x4A1B, [0x86, 0xA9, 0x24, 0xD5, 0x6B, 0xE8, 0xB3, 0x69]);
interface IActiveScriptTraceInfo : IUnknown
{
    HRESULT StartScriptTracing(IActiveScriptSiteTraceInfo pSiteTraceInfo, Guid guidContextID);
    HRESULT StopScriptTracing();
}

const GUID IID_IActiveScriptStringCompare = {0x58562769, 0xED52, 0x42F7, [0x84, 0x03, 0x49, 0x63, 0x51, 0x4E, 0x1F, 0x11]};
@GUID(0x58562769, 0xED52, 0x42F7, [0x84, 0x03, 0x49, 0x63, 0x51, 0x4E, 0x1F, 0x11]);
interface IActiveScriptStringCompare : IUnknown
{
    HRESULT StrComp(BSTR bszStr1, BSTR bszStr2, int* iRet);
}

enum __MIDL___MIDL_itf_dbgprop_0000_0000_0001
{
    DBGPROP_ATTRIB_NO_ATTRIB = 0,
    DBGPROP_ATTRIB_VALUE_IS_INVALID = 8,
    DBGPROP_ATTRIB_VALUE_IS_EXPANDABLE = 16,
    DBGPROP_ATTRIB_VALUE_IS_FAKE = 32,
    DBGPROP_ATTRIB_VALUE_IS_METHOD = 256,
    DBGPROP_ATTRIB_VALUE_IS_EVENT = 512,
    DBGPROP_ATTRIB_VALUE_IS_RAW_STRING = 1024,
    DBGPROP_ATTRIB_VALUE_READONLY = 2048,
    DBGPROP_ATTRIB_ACCESS_PUBLIC = 4096,
    DBGPROP_ATTRIB_ACCESS_PRIVATE = 8192,
    DBGPROP_ATTRIB_ACCESS_PROTECTED = 16384,
    DBGPROP_ATTRIB_ACCESS_FINAL = 32768,
    DBGPROP_ATTRIB_STORAGE_GLOBAL = 65536,
    DBGPROP_ATTRIB_STORAGE_STATIC = 131072,
    DBGPROP_ATTRIB_STORAGE_FIELD = 262144,
    DBGPROP_ATTRIB_STORAGE_VIRTUAL = 524288,
    DBGPROP_ATTRIB_TYPE_IS_CONSTANT = 1048576,
    DBGPROP_ATTRIB_TYPE_IS_SYNCHRONIZED = 2097152,
    DBGPROP_ATTRIB_TYPE_IS_VOLATILE = 4194304,
    DBGPROP_ATTRIB_HAS_EXTENDED_ATTRIBS = 8388608,
    DBGPROP_ATTRIB_FRAME_INTRYBLOCK = 16777216,
    DBGPROP_ATTRIB_FRAME_INCATCHBLOCK = 33554432,
    DBGPROP_ATTRIB_FRAME_INFINALLYBLOCK = 67108864,
    DBGPROP_ATTRIB_VALUE_IS_RETURN_VALUE = 134217728,
    DBGPROP_ATTRIB_VALUE_PENDING_MUTATION = 268435456,
}

enum __MIDL___MIDL_itf_dbgprop_0000_0000_0002
{
    DBGPROP_INFO_NAME = 1,
    DBGPROP_INFO_TYPE = 2,
    DBGPROP_INFO_VALUE = 4,
    DBGPROP_INFO_FULLNAME = 32,
    DBGPROP_INFO_ATTRIBUTES = 8,
    DBGPROP_INFO_DEBUGPROP = 16,
    DBGPROP_INFO_BEAUTIFY = 33554432,
    DBGPROP_INFO_CALLTOSTRING = 67108864,
    DBGPROP_INFO_AUTOEXPAND = 134217728,
}

enum tagOBJECT_ATTRIB_FLAG
{
    OBJECT_ATTRIB_NO_ATTRIB = 0,
    OBJECT_ATTRIB_NO_NAME = 1,
    OBJECT_ATTRIB_NO_TYPE = 2,
    OBJECT_ATTRIB_NO_VALUE = 4,
    OBJECT_ATTRIB_VALUE_IS_INVALID = 8,
    OBJECT_ATTRIB_VALUE_IS_OBJECT = 16,
    OBJECT_ATTRIB_VALUE_IS_ENUM = 32,
    OBJECT_ATTRIB_VALUE_IS_CUSTOM = 64,
    OBJECT_ATTRIB_OBJECT_IS_EXPANDABLE = 112,
    OBJECT_ATTRIB_VALUE_HAS_CODE = 128,
    OBJECT_ATTRIB_TYPE_IS_OBJECT = 256,
    OBJECT_ATTRIB_TYPE_HAS_CODE = 512,
    OBJECT_ATTRIB_TYPE_IS_EXPANDABLE = 256,
    OBJECT_ATTRIB_SLOT_IS_CATEGORY = 1024,
    OBJECT_ATTRIB_VALUE_READONLY = 2048,
    OBJECT_ATTRIB_ACCESS_PUBLIC = 4096,
    OBJECT_ATTRIB_ACCESS_PRIVATE = 8192,
    OBJECT_ATTRIB_ACCESS_PROTECTED = 16384,
    OBJECT_ATTRIB_ACCESS_FINAL = 32768,
    OBJECT_ATTRIB_STORAGE_GLOBAL = 65536,
    OBJECT_ATTRIB_STORAGE_STATIC = 131072,
    OBJECT_ATTRIB_STORAGE_FIELD = 262144,
    OBJECT_ATTRIB_STORAGE_VIRTUAL = 524288,
    OBJECT_ATTRIB_TYPE_IS_CONSTANT = 1048576,
    OBJECT_ATTRIB_TYPE_IS_SYNCHRONIZED = 2097152,
    OBJECT_ATTRIB_TYPE_IS_VOLATILE = 4194304,
    OBJECT_ATTRIB_HAS_EXTENDED_ATTRIBS = 8388608,
    OBJECT_ATTRIB_IS_CLASS = 16777216,
    OBJECT_ATTRIB_IS_FUNCTION = 33554432,
    OBJECT_ATTRIB_IS_VARIABLE = 67108864,
    OBJECT_ATTRIB_IS_PROPERTY = 134217728,
    OBJECT_ATTRIB_IS_MACRO = 268435456,
    OBJECT_ATTRIB_IS_TYPE = 536870912,
    OBJECT_ATTRIB_IS_INHERITED = 1073741824,
    OBJECT_ATTRIB_IS_INTERFACE = -2147483648,
}

enum PROP_INFO_FLAGS
{
    PROP_INFO_NAME = 1,
    PROP_INFO_TYPE = 2,
    PROP_INFO_VALUE = 4,
    PROP_INFO_FULLNAME = 32,
    PROP_INFO_ATTRIBUTES = 8,
    PROP_INFO_DEBUGPROP = 16,
    PROP_INFO_AUTOEXPAND = 134217728,
}

struct DebugPropertyInfo
{
    uint m_dwValidFields;
    BSTR m_bstrName;
    BSTR m_bstrType;
    BSTR m_bstrValue;
    BSTR m_bstrFullName;
    uint m_dwAttrib;
    IDebugProperty m_pDebugProp;
}

enum EX_PROP_INFO_FLAGS
{
    EX_PROP_INFO_ID = 256,
    EX_PROP_INFO_NTYPE = 512,
    EX_PROP_INFO_NVALUE = 1024,
    EX_PROP_INFO_LOCKBYTES = 2048,
    EX_PROP_INFO_DEBUGEXTPROP = 4096,
}

struct ExtendedDebugPropertyInfo
{
    uint dwValidFields;
    ushort* pszName;
    ushort* pszType;
    ushort* pszValue;
    ushort* pszFullName;
    uint dwAttrib;
    IDebugProperty pDebugProp;
    uint nDISPID;
    uint nType;
    VARIANT varValue;
    ILockBytes plbValue;
    IDebugExtendedProperty pDebugExtProp;
}

const GUID IID_IDebugProperty = {0x51973C50, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C50, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugProperty : IUnknown
{
    HRESULT GetPropertyInfo(uint dwFieldSpec, uint nRadix, DebugPropertyInfo* pPropertyInfo);
    HRESULT GetExtendedInfo(uint cInfos, char* rgguidExtendedInfo, char* rgvar);
    HRESULT SetValueAsString(ushort* pszValue, uint nRadix);
    HRESULT EnumMembers(uint dwFieldSpec, uint nRadix, const(Guid)* refiid, IEnumDebugPropertyInfo* ppepi);
    HRESULT GetParent(IDebugProperty* ppDebugProp);
}

const GUID IID_IEnumDebugPropertyInfo = {0x51973C51, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C51, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IEnumDebugPropertyInfo : IUnknown
{
    HRESULT Next(uint celt, char* pi, uint* pcEltsfetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugPropertyInfo* ppepi);
    HRESULT GetCount(uint* pcelt);
}

const GUID IID_IDebugExtendedProperty = {0x51973C52, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C52, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugExtendedProperty : IDebugProperty
{
    HRESULT GetExtendedPropertyInfo(uint dwFieldSpec, uint nRadix, ExtendedDebugPropertyInfo* pExtendedPropertyInfo);
    HRESULT EnumExtendedMembers(uint dwFieldSpec, uint nRadix, IEnumDebugExtendedPropertyInfo* ppeepi);
}

const GUID IID_IEnumDebugExtendedPropertyInfo = {0x51973C53, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C53, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IEnumDebugExtendedPropertyInfo : IUnknown
{
    HRESULT Next(uint celt, char* rgExtendedPropertyInfo, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugExtendedPropertyInfo* pedpe);
    HRESULT GetCount(uint* pcelt);
}

const GUID IID_IPerPropertyBrowsing2 = {0x51973C54, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C54, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IPerPropertyBrowsing2 : IUnknown
{
    HRESULT GetDisplayString(int dispid, BSTR* pBstr);
    HRESULT MapPropertyToPage(int dispid, Guid* pClsidPropPage);
    HRESULT GetPredefinedStrings(int dispid, CALPOLESTR* pCaStrings, CADWORD* pCaCookies);
    HRESULT SetPredefinedValue(int dispid, uint dwCookie);
}

const GUID IID_IDebugPropertyEnumType_All = {0x51973C55, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C55, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugPropertyEnumType_All : IUnknown
{
    HRESULT GetName(BSTR* __MIDL__IDebugPropertyEnumType_All0000);
}

const GUID IID_IDebugPropertyEnumType_Locals = {0x51973C56, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C56, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugPropertyEnumType_Locals : IDebugPropertyEnumType_All
{
}

const GUID IID_IDebugPropertyEnumType_Arguments = {0x51973C57, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C57, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugPropertyEnumType_Arguments : IDebugPropertyEnumType_All
{
}

const GUID IID_IDebugPropertyEnumType_LocalsPlusArgs = {0x51973C58, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C58, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugPropertyEnumType_LocalsPlusArgs : IDebugPropertyEnumType_All
{
}

const GUID IID_IDebugPropertyEnumType_Registers = {0x51973C59, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C59, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugPropertyEnumType_Registers : IDebugPropertyEnumType_All
{
}

enum BREAKPOINT_STATE
{
    BREAKPOINT_DELETED = 0,
    BREAKPOINT_DISABLED = 1,
    BREAKPOINT_ENABLED = 2,
}

enum BREAKREASON
{
    BREAKREASON_STEP = 0,
    BREAKREASON_BREAKPOINT = 1,
    BREAKREASON_DEBUGGER_BLOCK = 2,
    BREAKREASON_HOST_INITIATED = 3,
    BREAKREASON_LANGUAGE_INITIATED = 4,
    BREAKREASON_DEBUGGER_HALT = 5,
    BREAKREASON_ERROR = 6,
    BREAKREASON_JIT = 7,
    BREAKREASON_MUTATION_BREAKPOINT = 8,
}

enum tagBREAKRESUME_ACTION
{
    BREAKRESUMEACTION_ABORT = 0,
    BREAKRESUMEACTION_CONTINUE = 1,
    BREAKRESUMEACTION_STEP_INTO = 2,
    BREAKRESUMEACTION_STEP_OVER = 3,
    BREAKRESUMEACTION_STEP_OUT = 4,
    BREAKRESUMEACTION_IGNORE = 5,
    BREAKRESUMEACTION_STEP_DOCUMENT = 6,
}

enum ERRORRESUMEACTION
{
    ERRORRESUMEACTION_ReexecuteErrorStatement = 0,
    ERRORRESUMEACTION_AbortCallAndReturnErrorToCaller = 1,
    ERRORRESUMEACTION_SkipErrorStatement = 2,
}

enum DOCUMENTNAMETYPE
{
    DOCUMENTNAMETYPE_APPNODE = 0,
    DOCUMENTNAMETYPE_TITLE = 1,
    DOCUMENTNAMETYPE_FILE_TAIL = 2,
    DOCUMENTNAMETYPE_URL = 3,
    DOCUMENTNAMETYPE_UNIQUE_TITLE = 4,
    DOCUMENTNAMETYPE_SOURCE_MAP_URL = 5,
}

const GUID IID_IActiveScriptDebug32 = {0x51973C10, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C10, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IActiveScriptDebug32 : IUnknown
{
    HRESULT GetScriptTextAttributes(char* pstrCode, uint uNumCodeChars, ushort* pstrDelimiter, uint dwFlags, char* pattr);
    HRESULT GetScriptletTextAttributes(char* pstrCode, uint uNumCodeChars, ushort* pstrDelimiter, uint dwFlags, char* pattr);
    HRESULT EnumCodeContextsOfPosition(uint dwSourceContext, uint uCharacterOffset, uint uNumChars, IEnumDebugCodeContexts* ppescc);
}

const GUID IID_IActiveScriptDebug64 = {0xBC437E23, 0xF5B8, 0x47F4, [0xBB, 0x79, 0x7D, 0x1C, 0xE5, 0x48, 0x3B, 0x86]};
@GUID(0xBC437E23, 0xF5B8, 0x47F4, [0xBB, 0x79, 0x7D, 0x1C, 0xE5, 0x48, 0x3B, 0x86]);
interface IActiveScriptDebug64 : IUnknown
{
    HRESULT GetScriptTextAttributes(char* pstrCode, uint uNumCodeChars, ushort* pstrDelimiter, uint dwFlags, char* pattr);
    HRESULT GetScriptletTextAttributes(char* pstrCode, uint uNumCodeChars, ushort* pstrDelimiter, uint dwFlags, char* pattr);
    HRESULT EnumCodeContextsOfPosition(ulong dwSourceContext, uint uCharacterOffset, uint uNumChars, IEnumDebugCodeContexts* ppescc);
}

const GUID IID_IActiveScriptSiteDebug32 = {0x51973C11, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C11, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IActiveScriptSiteDebug32 : IUnknown
{
    HRESULT GetDocumentContextFromPosition(uint dwSourceContext, uint uCharacterOffset, uint uNumChars, IDebugDocumentContext* ppsc);
    HRESULT GetApplication(IDebugApplication32* ppda);
    HRESULT GetRootApplicationNode(IDebugApplicationNode* ppdanRoot);
    HRESULT OnScriptErrorDebug(IActiveScriptErrorDebug pErrorDebug, int* pfEnterDebugger, int* pfCallOnScriptErrorWhenContinuing);
}

const GUID IID_IActiveScriptSiteDebug64 = {0xD6B96B0A, 0x7463, 0x402C, [0x92, 0xAC, 0x89, 0x98, 0x42, 0x26, 0x94, 0x2F]};
@GUID(0xD6B96B0A, 0x7463, 0x402C, [0x92, 0xAC, 0x89, 0x98, 0x42, 0x26, 0x94, 0x2F]);
interface IActiveScriptSiteDebug64 : IUnknown
{
    HRESULT GetDocumentContextFromPosition(ulong dwSourceContext, uint uCharacterOffset, uint uNumChars, IDebugDocumentContext* ppsc);
    HRESULT GetApplication(IDebugApplication64* ppda);
    HRESULT GetRootApplicationNode(IDebugApplicationNode* ppdanRoot);
    HRESULT OnScriptErrorDebug(IActiveScriptErrorDebug pErrorDebug, int* pfEnterDebugger, int* pfCallOnScriptErrorWhenContinuing);
}

const GUID IID_IActiveScriptSiteDebugEx = {0xBB722CCB, 0x6AD2, 0x41C6, [0xB7, 0x80, 0xAF, 0x9C, 0x03, 0xEE, 0x69, 0xF5]};
@GUID(0xBB722CCB, 0x6AD2, 0x41C6, [0xB7, 0x80, 0xAF, 0x9C, 0x03, 0xEE, 0x69, 0xF5]);
interface IActiveScriptSiteDebugEx : IUnknown
{
    HRESULT OnCanNotJITScriptErrorDebug(IActiveScriptErrorDebug pErrorDebug, int* pfCallOnScriptErrorWhenContinuing);
}

const GUID IID_IActiveScriptErrorDebug = {0x51973C12, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C12, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IActiveScriptErrorDebug : IActiveScriptError
{
    HRESULT GetDocumentContext(IDebugDocumentContext* ppssc);
    HRESULT GetStackFrame(IDebugStackFrame* ppdsf);
}

const GUID IID_IDebugCodeContext = {0x51973C13, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C13, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugCodeContext : IUnknown
{
    HRESULT GetDocumentContext(IDebugDocumentContext* ppsc);
    HRESULT SetBreakPoint(BREAKPOINT_STATE bps);
}

const GUID IID_IDebugExpression = {0x51973C14, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C14, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugExpression : IUnknown
{
    HRESULT Start(IDebugExpressionCallBack pdecb);
    HRESULT Abort();
    HRESULT QueryIsComplete();
    HRESULT GetResultAsString(int* phrResult, BSTR* pbstrResult);
    HRESULT GetResultAsDebugProperty(int* phrResult, IDebugProperty* ppdp);
}

const GUID IID_IDebugExpressionContext = {0x51973C15, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C15, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugExpressionContext : IUnknown
{
    HRESULT ParseLanguageText(ushort* pstrCode, uint nRadix, ushort* pstrDelimiter, uint dwFlags, IDebugExpression* ppe);
    HRESULT GetLanguageInfo(BSTR* pbstrLanguageName, Guid* pLanguageID);
}

const GUID IID_IDebugExpressionCallBack = {0x51973C16, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C16, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugExpressionCallBack : IUnknown
{
    HRESULT onComplete();
}

const GUID IID_IDebugStackFrame = {0x51973C17, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C17, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugStackFrame : IUnknown
{
    HRESULT GetCodeContext(IDebugCodeContext* ppcc);
    HRESULT GetDescriptionString(BOOL fLong, BSTR* pbstrDescription);
    HRESULT GetLanguageString(BOOL fLong, BSTR* pbstrLanguage);
    HRESULT GetThread(IDebugApplicationThread* ppat);
    HRESULT GetDebugProperty(IDebugProperty* ppDebugProp);
}

const GUID IID_IDebugStackFrameSniffer = {0x51973C18, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C18, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugStackFrameSniffer : IUnknown
{
    HRESULT EnumStackFrames(IEnumDebugStackFrames* ppedsf);
}

const GUID IID_IDebugStackFrameSnifferEx32 = {0x51973C19, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C19, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugStackFrameSnifferEx32 : IDebugStackFrameSniffer
{
    HRESULT EnumStackFramesEx32(uint dwSpMin, IEnumDebugStackFrames* ppedsf);
}

const GUID IID_IDebugStackFrameSnifferEx64 = {0x8CD12AF4, 0x49C1, 0x4D52, [0x8D, 0x8A, 0xC1, 0x46, 0xF4, 0x75, 0x81, 0xAA]};
@GUID(0x8CD12AF4, 0x49C1, 0x4D52, [0x8D, 0x8A, 0xC1, 0x46, 0xF4, 0x75, 0x81, 0xAA]);
interface IDebugStackFrameSnifferEx64 : IDebugStackFrameSniffer
{
    HRESULT EnumStackFramesEx64(ulong dwSpMin, IEnumDebugStackFrames64* ppedsf);
}

const GUID IID_IDebugSyncOperation = {0x51973C1A, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C1A, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugSyncOperation : IUnknown
{
    HRESULT GetTargetThread(IDebugApplicationThread* ppatTarget);
    HRESULT Execute(IUnknown* ppunkResult);
    HRESULT InProgressAbort();
}

const GUID IID_IDebugAsyncOperation = {0x51973C1B, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C1B, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugAsyncOperation : IUnknown
{
    HRESULT GetSyncDebugOperation(IDebugSyncOperation* ppsdo);
    HRESULT Start(IDebugAsyncOperationCallBack padocb);
    HRESULT Abort();
    HRESULT QueryIsComplete();
    HRESULT GetResult(int* phrResult, IUnknown* ppunkResult);
}

const GUID IID_IDebugAsyncOperationCallBack = {0x51973C1C, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C1C, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugAsyncOperationCallBack : IUnknown
{
    HRESULT onComplete();
}

const GUID IID_IEnumDebugCodeContexts = {0x51973C1D, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C1D, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IEnumDebugCodeContexts : IUnknown
{
    HRESULT Next(uint celt, IDebugCodeContext* pscc, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugCodeContexts* ppescc);
}

struct DebugStackFrameDescriptor
{
    IDebugStackFrame pdsf;
    uint dwMin;
    uint dwLim;
    BOOL fFinal;
    IUnknown punkFinal;
}

struct DebugStackFrameDescriptor64
{
    IDebugStackFrame pdsf;
    ulong dwMin;
    ulong dwLim;
    BOOL fFinal;
    IUnknown punkFinal;
}

const GUID IID_IEnumDebugStackFrames = {0x51973C1E, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C1E, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IEnumDebugStackFrames : IUnknown
{
    HRESULT Next(uint celt, DebugStackFrameDescriptor* prgdsfd, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugStackFrames* ppedsf);
}

const GUID IID_IEnumDebugStackFrames64 = {0x0DC38853, 0xC1B0, 0x4176, [0xA9, 0x84, 0xB2, 0x98, 0x36, 0x10, 0x27, 0xAF]};
@GUID(0x0DC38853, 0xC1B0, 0x4176, [0xA9, 0x84, 0xB2, 0x98, 0x36, 0x10, 0x27, 0xAF]);
interface IEnumDebugStackFrames64 : IEnumDebugStackFrames
{
    HRESULT Next64(uint celt, DebugStackFrameDescriptor64* prgdsfd, uint* pceltFetched);
}

const GUID IID_IDebugDocumentInfo = {0x51973C1F, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C1F, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugDocumentInfo : IUnknown
{
    HRESULT GetName(DOCUMENTNAMETYPE dnt, BSTR* pbstrName);
    HRESULT GetDocumentClassId(Guid* pclsidDocument);
}

const GUID IID_IDebugDocumentProvider = {0x51973C20, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C20, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugDocumentProvider : IDebugDocumentInfo
{
    HRESULT GetDocument(IDebugDocument* ppssd);
}

const GUID IID_IDebugDocument = {0x51973C21, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C21, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugDocument : IDebugDocumentInfo
{
}

const GUID IID_IDebugDocumentText = {0x51973C22, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C22, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugDocumentText : IDebugDocument
{
    HRESULT GetDocumentAttributes(uint* ptextdocattr);
    HRESULT GetSize(uint* pcNumLines, uint* pcNumChars);
    HRESULT GetPositionOfLine(uint cLineNumber, uint* pcCharacterPosition);
    HRESULT GetLineOfPosition(uint cCharacterPosition, uint* pcLineNumber, uint* pcCharacterOffsetInLine);
    HRESULT GetText(uint cCharacterPosition, char* pcharText, char* pstaTextAttr, uint* pcNumChars, uint cMaxChars);
    HRESULT GetPositionOfContext(IDebugDocumentContext psc, uint* pcCharacterPosition, uint* cNumChars);
    HRESULT GetContextOfPosition(uint cCharacterPosition, uint cNumChars, IDebugDocumentContext* ppsc);
}

const GUID IID_IDebugDocumentTextEvents = {0x51973C23, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C23, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugDocumentTextEvents : IUnknown
{
    HRESULT onDestroy();
    HRESULT onInsertText(uint cCharacterPosition, uint cNumToInsert);
    HRESULT onRemoveText(uint cCharacterPosition, uint cNumToRemove);
    HRESULT onReplaceText(uint cCharacterPosition, uint cNumToReplace);
    HRESULT onUpdateTextAttributes(uint cCharacterPosition, uint cNumToUpdate);
    HRESULT onUpdateDocumentAttributes(uint textdocattr);
}

const GUID IID_IDebugDocumentTextAuthor = {0x51973C24, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C24, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugDocumentTextAuthor : IDebugDocumentText
{
    HRESULT InsertText(uint cCharacterPosition, uint cNumToInsert, char* pcharText);
    HRESULT RemoveText(uint cCharacterPosition, uint cNumToRemove);
    HRESULT ReplaceTextA(uint cCharacterPosition, uint cNumToReplace, char* pcharText);
}

const GUID IID_IDebugDocumentTextExternalAuthor = {0x51973C25, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C25, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugDocumentTextExternalAuthor : IUnknown
{
    HRESULT GetPathName(BSTR* pbstrLongName, int* pfIsOriginalFile);
    HRESULT GetFileName(BSTR* pbstrShortName);
    HRESULT NotifyChanged();
}

const GUID IID_IDebugDocumentHelper32 = {0x51973C26, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C26, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugDocumentHelper32 : IUnknown
{
    HRESULT Init(IDebugApplication32 pda, ushort* pszShortName, ushort* pszLongName, uint docAttr);
    HRESULT Attach(IDebugDocumentHelper32 pddhParent);
    HRESULT Detach();
    HRESULT AddUnicodeText(ushort* pszText);
    HRESULT AddDBCSText(const(char)* pszText);
    HRESULT SetDebugDocumentHost(IDebugDocumentHost pddh);
    HRESULT AddDeferredText(uint cChars, uint dwTextStartCookie);
    HRESULT DefineScriptBlock(uint ulCharOffset, uint cChars, IActiveScript pas, BOOL fScriptlet, uint* pdwSourceContext);
    HRESULT SetDefaultTextAttr(ushort staTextAttr);
    HRESULT SetTextAttributes(uint ulCharOffset, uint cChars, char* pstaTextAttr);
    HRESULT SetLongName(ushort* pszLongName);
    HRESULT SetShortName(ushort* pszShortName);
    HRESULT SetDocumentAttr(uint pszAttributes);
    HRESULT GetDebugApplicationNode(IDebugApplicationNode* ppdan);
    HRESULT GetScriptBlockInfo(uint dwSourceContext, IActiveScript* ppasd, uint* piCharPos, uint* pcChars);
    HRESULT CreateDebugDocumentContext(uint iCharPos, uint cChars, IDebugDocumentContext* ppddc);
    HRESULT BringDocumentToTop();
    HRESULT BringDocumentContextToTop(IDebugDocumentContext pddc);
}

const GUID IID_IDebugDocumentHelper64 = {0xC4C7363C, 0x20FD, 0x47F9, [0xBD, 0x82, 0x48, 0x55, 0xE0, 0x15, 0x08, 0x71]};
@GUID(0xC4C7363C, 0x20FD, 0x47F9, [0xBD, 0x82, 0x48, 0x55, 0xE0, 0x15, 0x08, 0x71]);
interface IDebugDocumentHelper64 : IUnknown
{
    HRESULT Init(IDebugApplication64 pda, ushort* pszShortName, ushort* pszLongName, uint docAttr);
    HRESULT Attach(IDebugDocumentHelper64 pddhParent);
    HRESULT Detach();
    HRESULT AddUnicodeText(ushort* pszText);
    HRESULT AddDBCSText(const(char)* pszText);
    HRESULT SetDebugDocumentHost(IDebugDocumentHost pddh);
    HRESULT AddDeferredText(uint cChars, uint dwTextStartCookie);
    HRESULT DefineScriptBlock(uint ulCharOffset, uint cChars, IActiveScript pas, BOOL fScriptlet, ulong* pdwSourceContext);
    HRESULT SetDefaultTextAttr(ushort staTextAttr);
    HRESULT SetTextAttributes(uint ulCharOffset, uint cChars, char* pstaTextAttr);
    HRESULT SetLongName(ushort* pszLongName);
    HRESULT SetShortName(ushort* pszShortName);
    HRESULT SetDocumentAttr(uint pszAttributes);
    HRESULT GetDebugApplicationNode(IDebugApplicationNode* ppdan);
    HRESULT GetScriptBlockInfo(ulong dwSourceContext, IActiveScript* ppasd, uint* piCharPos, uint* pcChars);
    HRESULT CreateDebugDocumentContext(uint iCharPos, uint cChars, IDebugDocumentContext* ppddc);
    HRESULT BringDocumentToTop();
    HRESULT BringDocumentContextToTop(IDebugDocumentContext pddc);
}

const GUID IID_IDebugDocumentHost = {0x51973C27, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C27, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugDocumentHost : IUnknown
{
    HRESULT GetDeferredText(uint dwTextStartCookie, char* pcharText, char* pstaTextAttr, uint* pcNumChars, uint cMaxChars);
    HRESULT GetScriptTextAttributes(char* pstrCode, uint uNumCodeChars, ushort* pstrDelimiter, uint dwFlags, char* pattr);
    HRESULT OnCreateDocumentContext(IUnknown* ppunkOuter);
    HRESULT GetPathName(BSTR* pbstrLongName, int* pfIsOriginalFile);
    HRESULT GetFileName(BSTR* pbstrShortName);
    HRESULT NotifyChanged();
}

const GUID IID_IDebugDocumentContext = {0x51973C28, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C28, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugDocumentContext : IUnknown
{
    HRESULT GetDocument(IDebugDocument* ppsd);
    HRESULT EnumCodeContexts(IEnumDebugCodeContexts* ppescc);
}

const GUID IID_IDebugSessionProvider = {0x51973C29, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C29, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugSessionProvider : IUnknown
{
    HRESULT StartDebugSession(IRemoteDebugApplication pda);
}

const GUID IID_IApplicationDebugger = {0x51973C2A, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C2A, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IApplicationDebugger : IUnknown
{
    HRESULT QueryAlive();
    HRESULT CreateInstanceAtDebugger(const(Guid)* rclsid, IUnknown pUnkOuter, uint dwClsContext, const(Guid)* riid, IUnknown* ppvObject);
    HRESULT onDebugOutput(ushort* pstr);
    HRESULT onHandleBreakPoint(IRemoteDebugApplicationThread prpt, BREAKREASON br, IActiveScriptErrorDebug pError);
    HRESULT onClose();
    HRESULT onDebuggerEvent(const(Guid)* riid, IUnknown punk);
}

const GUID IID_IApplicationDebuggerUI = {0x51973C2B, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C2B, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IApplicationDebuggerUI : IUnknown
{
    HRESULT BringDocumentToTop(IDebugDocumentText pddt);
    HRESULT BringDocumentContextToTop(IDebugDocumentContext pddc);
}

const GUID IID_IMachineDebugManager = {0x51973C2C, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C2C, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IMachineDebugManager : IUnknown
{
    HRESULT AddApplication(IRemoteDebugApplication pda, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwAppCookie);
    HRESULT EnumApplications(IEnumRemoteDebugApplications* ppeda);
}

const GUID IID_IMachineDebugManagerCookie = {0x51973C2D, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C2D, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IMachineDebugManagerCookie : IUnknown
{
    HRESULT AddApplication(IRemoteDebugApplication pda, uint dwDebugAppCookie, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwDebugAppCookie, uint dwAppCookie);
    HRESULT EnumApplications(IEnumRemoteDebugApplications* ppeda);
}

const GUID IID_IMachineDebugManagerEvents = {0x51973C2E, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C2E, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IMachineDebugManagerEvents : IUnknown
{
    HRESULT onAddApplication(IRemoteDebugApplication pda, uint dwAppCookie);
    HRESULT onRemoveApplication(IRemoteDebugApplication pda, uint dwAppCookie);
}

const GUID IID_IProcessDebugManager32 = {0x51973C2F, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C2F, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IProcessDebugManager32 : IUnknown
{
    HRESULT CreateApplication(IDebugApplication32* ppda);
    HRESULT GetDefaultApplication(IDebugApplication32* ppda);
    HRESULT AddApplication(IDebugApplication32 pda, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwAppCookie);
    HRESULT CreateDebugDocumentHelper(IUnknown punkOuter, IDebugDocumentHelper32* pddh);
}

const GUID IID_IProcessDebugManager64 = {0x56B9FC1C, 0x63A9, 0x4CC1, [0xAC, 0x21, 0x08, 0x7D, 0x69, 0xA1, 0x7F, 0xAB]};
@GUID(0x56B9FC1C, 0x63A9, 0x4CC1, [0xAC, 0x21, 0x08, 0x7D, 0x69, 0xA1, 0x7F, 0xAB]);
interface IProcessDebugManager64 : IUnknown
{
    HRESULT CreateApplication(IDebugApplication64* ppda);
    HRESULT GetDefaultApplication(IDebugApplication64* ppda);
    HRESULT AddApplication(IDebugApplication64 pda, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwAppCookie);
    HRESULT CreateDebugDocumentHelper(IUnknown punkOuter, IDebugDocumentHelper64* pddh);
}

const GUID IID_IRemoteDebugApplication = {0x51973C30, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C30, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IRemoteDebugApplication : IUnknown
{
    HRESULT ResumeFromBreakPoint(IRemoteDebugApplicationThread prptFocus, tagBREAKRESUME_ACTION bra, ERRORRESUMEACTION era);
    HRESULT CauseBreak();
    HRESULT ConnectDebugger(IApplicationDebugger pad);
    HRESULT DisconnectDebugger();
    HRESULT GetDebugger(IApplicationDebugger* pad);
    HRESULT CreateInstanceAtApplication(const(Guid)* rclsid, IUnknown pUnkOuter, uint dwClsContext, const(Guid)* riid, IUnknown* ppvObject);
    HRESULT QueryAlive();
    HRESULT EnumThreads(IEnumRemoteDebugApplicationThreads* pperdat);
    HRESULT GetName(BSTR* pbstrName);
    HRESULT GetRootNode(IDebugApplicationNode* ppdanRoot);
    HRESULT EnumGlobalExpressionContexts(IEnumDebugExpressionContexts* ppedec);
}

const GUID IID_IDebugApplication32 = {0x51973C32, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C32, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugApplication32 : IRemoteDebugApplication
{
    HRESULT SetName(ushort* pstrName);
    HRESULT StepOutComplete();
    HRESULT DebugOutput(ushort* pstr);
    HRESULT StartDebugSession();
    HRESULT HandleBreakPoint(BREAKREASON br, tagBREAKRESUME_ACTION* pbra);
    HRESULT Close();
    HRESULT GetBreakFlags(uint* pabf, IRemoteDebugApplicationThread* pprdatSteppingThread);
    HRESULT GetCurrentThread(IDebugApplicationThread* pat);
    HRESULT CreateAsyncDebugOperation(IDebugSyncOperation psdo, IDebugAsyncOperation* ppado);
    HRESULT AddStackFrameSniffer(IDebugStackFrameSniffer pdsfs, uint* pdwCookie);
    HRESULT RemoveStackFrameSniffer(uint dwCookie);
    HRESULT QueryCurrentThreadIsDebuggerThread();
    HRESULT SynchronousCallInDebuggerThread(IDebugThreadCall32 pptc, uint dwParam1, uint dwParam2, uint dwParam3);
    HRESULT CreateApplicationNode(IDebugApplicationNode* ppdanNew);
    HRESULT FireDebuggerEvent(const(Guid)* riid, IUnknown punk);
    HRESULT HandleRuntimeError(IActiveScriptErrorDebug pErrorDebug, IActiveScriptSite pScriptSite, tagBREAKRESUME_ACTION* pbra, ERRORRESUMEACTION* perra, int* pfCallOnScriptError);
    BOOL FCanJitDebug();
    BOOL FIsAutoJitDebugEnabled();
    HRESULT AddGlobalExpressionContextProvider(IProvideExpressionContexts pdsfs, uint* pdwCookie);
    HRESULT RemoveGlobalExpressionContextProvider(uint dwCookie);
}

const GUID IID_IDebugApplication64 = {0x4DEDC754, 0x04C7, 0x4F10, [0x9E, 0x60, 0x16, 0xA3, 0x90, 0xFE, 0x6E, 0x62]};
@GUID(0x4DEDC754, 0x04C7, 0x4F10, [0x9E, 0x60, 0x16, 0xA3, 0x90, 0xFE, 0x6E, 0x62]);
interface IDebugApplication64 : IRemoteDebugApplication
{
    HRESULT SetName(ushort* pstrName);
    HRESULT StepOutComplete();
    HRESULT DebugOutput(ushort* pstr);
    HRESULT StartDebugSession();
    HRESULT HandleBreakPoint(BREAKREASON br, tagBREAKRESUME_ACTION* pbra);
    HRESULT Close();
    HRESULT GetBreakFlags(uint* pabf, IRemoteDebugApplicationThread* pprdatSteppingThread);
    HRESULT GetCurrentThread(IDebugApplicationThread* pat);
    HRESULT CreateAsyncDebugOperation(IDebugSyncOperation psdo, IDebugAsyncOperation* ppado);
    HRESULT AddStackFrameSniffer(IDebugStackFrameSniffer pdsfs, uint* pdwCookie);
    HRESULT RemoveStackFrameSniffer(uint dwCookie);
    HRESULT QueryCurrentThreadIsDebuggerThread();
    HRESULT SynchronousCallInDebuggerThread(IDebugThreadCall64 pptc, ulong dwParam1, ulong dwParam2, ulong dwParam3);
    HRESULT CreateApplicationNode(IDebugApplicationNode* ppdanNew);
    HRESULT FireDebuggerEvent(const(Guid)* riid, IUnknown punk);
    HRESULT HandleRuntimeError(IActiveScriptErrorDebug pErrorDebug, IActiveScriptSite pScriptSite, tagBREAKRESUME_ACTION* pbra, ERRORRESUMEACTION* perra, int* pfCallOnScriptError);
    BOOL FCanJitDebug();
    BOOL FIsAutoJitDebugEnabled();
    HRESULT AddGlobalExpressionContextProvider(IProvideExpressionContexts pdsfs, ulong* pdwCookie);
    HRESULT RemoveGlobalExpressionContextProvider(ulong dwCookie);
}

const GUID IID_IRemoteDebugApplicationEvents = {0x51973C33, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C33, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IRemoteDebugApplicationEvents : IUnknown
{
    HRESULT OnConnectDebugger(IApplicationDebugger pad);
    HRESULT OnDisconnectDebugger();
    HRESULT OnSetName(ushort* pstrName);
    HRESULT OnDebugOutput(ushort* pstr);
    HRESULT OnClose();
    HRESULT OnEnterBreakPoint(IRemoteDebugApplicationThread prdat);
    HRESULT OnLeaveBreakPoint(IRemoteDebugApplicationThread prdat);
    HRESULT OnCreateThread(IRemoteDebugApplicationThread prdat);
    HRESULT OnDestroyThread(IRemoteDebugApplicationThread prdat);
    HRESULT OnBreakFlagChange(uint abf, IRemoteDebugApplicationThread prdatSteppingThread);
}

const GUID IID_IDebugApplicationNode = {0x51973C34, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C34, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugApplicationNode : IDebugDocumentProvider
{
    HRESULT EnumChildren(IEnumDebugApplicationNodes* pperddp);
    HRESULT GetParent(IDebugApplicationNode* pprddp);
    HRESULT SetDocumentProvider(IDebugDocumentProvider pddp);
    HRESULT Close();
    HRESULT Attach(IDebugApplicationNode pdanParent);
    HRESULT Detach();
}

const GUID IID_IDebugApplicationNodeEvents = {0x51973C35, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C35, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugApplicationNodeEvents : IUnknown
{
    HRESULT onAddChild(IDebugApplicationNode prddpChild);
    HRESULT onRemoveChild(IDebugApplicationNode prddpChild);
    HRESULT onDetach();
    HRESULT onAttach(IDebugApplicationNode prddpParent);
}

const GUID IID_AsyncIDebugApplicationNodeEvents = {0xA2E3AA3B, 0xAA8D, 0x4EBF, [0x84, 0xCD, 0x64, 0x8B, 0x73, 0x7B, 0x8C, 0x13]};
@GUID(0xA2E3AA3B, 0xAA8D, 0x4EBF, [0x84, 0xCD, 0x64, 0x8B, 0x73, 0x7B, 0x8C, 0x13]);
interface AsyncIDebugApplicationNodeEvents : IUnknown
{
    HRESULT Begin_onAddChild(IDebugApplicationNode prddpChild);
    HRESULT Finish_onAddChild();
    HRESULT Begin_onRemoveChild(IDebugApplicationNode prddpChild);
    HRESULT Finish_onRemoveChild();
    HRESULT Begin_onDetach();
    HRESULT Finish_onDetach();
    HRESULT Begin_onAttach(IDebugApplicationNode prddpParent);
    HRESULT Finish_onAttach();
}

const GUID IID_IDebugThreadCall32 = {0x51973C36, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C36, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugThreadCall32 : IUnknown
{
    HRESULT ThreadCallHandler(uint dwParam1, uint dwParam2, uint dwParam3);
}

const GUID IID_IDebugThreadCall64 = {0xCB3FA335, 0xE979, 0x42FD, [0x9F, 0xCF, 0xA7, 0x54, 0x6A, 0x0F, 0x39, 0x05]};
@GUID(0xCB3FA335, 0xE979, 0x42FD, [0x9F, 0xCF, 0xA7, 0x54, 0x6A, 0x0F, 0x39, 0x05]);
interface IDebugThreadCall64 : IUnknown
{
    HRESULT ThreadCallHandler(ulong dwParam1, ulong dwParam2, ulong dwParam3);
}

const GUID IID_IRemoteDebugApplicationThread = {0x51973C37, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C37, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IRemoteDebugApplicationThread : IUnknown
{
    HRESULT GetSystemThreadId(uint* dwThreadId);
    HRESULT GetApplication(IRemoteDebugApplication* pprda);
    HRESULT EnumStackFrames(IEnumDebugStackFrames* ppedsf);
    HRESULT GetDescription(BSTR* pbstrDescription, BSTR* pbstrState);
    HRESULT SetNextStatement(IDebugStackFrame pStackFrame, IDebugCodeContext pCodeContext);
    HRESULT GetState(uint* pState);
    HRESULT Suspend(uint* pdwCount);
    HRESULT Resume(uint* pdwCount);
    HRESULT GetSuspendCount(uint* pdwCount);
}

const GUID IID_IDebugApplicationThread = {0x51973C38, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C38, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugApplicationThread : IRemoteDebugApplicationThread
{
    HRESULT SynchronousCallIntoThread32(IDebugThreadCall32 pstcb, uint dwParam1, uint dwParam2, uint dwParam3);
    HRESULT QueryIsCurrentThread();
    HRESULT QueryIsDebuggerThread();
    HRESULT SetDescription(ushort* pstrDescription);
    HRESULT SetStateString(ushort* pstrState);
}

const GUID IID_IDebugApplicationThread64 = {0x9DAC5886, 0xDBAD, 0x456D, [0x9D, 0xEE, 0x5D, 0xEC, 0x39, 0xAB, 0x3D, 0xDA]};
@GUID(0x9DAC5886, 0xDBAD, 0x456D, [0x9D, 0xEE, 0x5D, 0xEC, 0x39, 0xAB, 0x3D, 0xDA]);
interface IDebugApplicationThread64 : IDebugApplicationThread
{
    HRESULT SynchronousCallIntoThread64(IDebugThreadCall64 pstcb, ulong dwParam1, ulong dwParam2, ulong dwParam3);
}

const GUID IID_IDebugCookie = {0x51973C39, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C39, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugCookie : IUnknown
{
    HRESULT SetDebugCookie(uint dwDebugAppCookie);
}

const GUID IID_IEnumDebugApplicationNodes = {0x51973C3A, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C3A, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IEnumDebugApplicationNodes : IUnknown
{
    HRESULT Next(uint celt, IDebugApplicationNode* pprddp, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugApplicationNodes* pperddp);
}

const GUID IID_IEnumRemoteDebugApplications = {0x51973C3B, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C3B, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IEnumRemoteDebugApplications : IUnknown
{
    HRESULT Next(uint celt, IRemoteDebugApplication* ppda, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumRemoteDebugApplications* ppessd);
}

const GUID IID_IEnumRemoteDebugApplicationThreads = {0x51973C3C, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C3C, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IEnumRemoteDebugApplicationThreads : IUnknown
{
    HRESULT Next(uint celt, IRemoteDebugApplicationThread* pprdat, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumRemoteDebugApplicationThreads* pperdat);
}

const GUID IID_IDebugFormatter = {0x51973C05, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C05, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugFormatter : IUnknown
{
    HRESULT GetStringForVariant(VARIANT* pvar, uint nRadix, BSTR* pbstrValue);
    HRESULT GetVariantForString(ushort* pwstrValue, VARIANT* pvar);
    HRESULT GetStringForVarType(ushort vt, TYPEDESC* ptdescArrayType, BSTR* pbstr);
}

const GUID IID_ISimpleConnectionPoint = {0x51973C3E, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C3E, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface ISimpleConnectionPoint : IUnknown
{
    HRESULT GetEventCount(uint* pulCount);
    HRESULT DescribeEvents(uint iEvent, uint cEvents, int* prgid, BSTR* prgbstr, uint* pcEventsFetched);
    HRESULT Advise(IDispatch pdisp, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
}

const GUID IID_IDebugHelper = {0x51973C3F, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C3F, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IDebugHelper : IUnknown
{
    HRESULT CreatePropertyBrowser(VARIANT* pvar, ushort* bstrName, IDebugApplicationThread pdat, IDebugProperty* ppdob);
    HRESULT CreatePropertyBrowserEx(VARIANT* pvar, ushort* bstrName, IDebugApplicationThread pdat, IDebugFormatter pdf, IDebugProperty* ppdob);
    HRESULT CreateSimpleConnectionPoint(IDispatch pdisp, ISimpleConnectionPoint* ppscp);
}

const GUID IID_IEnumDebugExpressionContexts = {0x51973C40, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C40, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IEnumDebugExpressionContexts : IUnknown
{
    HRESULT Next(uint celt, IDebugExpressionContext* ppdec, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugExpressionContexts* ppedec);
}

const GUID IID_IProvideExpressionContexts = {0x51973C41, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]};
@GUID(0x51973C41, 0xCB0C, 0x11D0, [0xB5, 0xC9, 0x00, 0xA0, 0x24, 0x4A, 0x0E, 0x7A]);
interface IProvideExpressionContexts : IUnknown
{
    HRESULT EnumExpressionContexts(IEnumDebugExpressionContexts* ppedec);
}

enum __MIDL___MIDL_itf_activprof_0000_0000_0001
{
    PROFILER_SCRIPT_TYPE_USER = 0,
    PROFILER_SCRIPT_TYPE_DYNAMIC = 1,
    PROFILER_SCRIPT_TYPE_NATIVE = 2,
    PROFILER_SCRIPT_TYPE_DOM = 3,
}

enum __MIDL___MIDL_itf_activprof_0000_0000_0002
{
    PROFILER_EVENT_MASK_TRACE_SCRIPT_FUNCTION_CALL = 1,
    PROFILER_EVENT_MASK_TRACE_NATIVE_FUNCTION_CALL = 2,
    PROFILER_EVENT_MASK_TRACE_DOM_FUNCTION_CALL = 4,
    PROFILER_EVENT_MASK_TRACE_ALL = 3,
    PROFILER_EVENT_MASK_TRACE_ALL_WITH_DOM = 7,
}

const GUID IID_IActiveScriptProfilerControl = {0x784B5FF0, 0x69B0, 0x47D1, [0xA7, 0xDC, 0x25, 0x18, 0xF4, 0x23, 0x0E, 0x90]};
@GUID(0x784B5FF0, 0x69B0, 0x47D1, [0xA7, 0xDC, 0x25, 0x18, 0xF4, 0x23, 0x0E, 0x90]);
interface IActiveScriptProfilerControl : IUnknown
{
    HRESULT StartProfiling(const(Guid)* clsidProfilerObject, uint dwEventMask, uint dwContext);
    HRESULT SetProfilerEventMask(uint dwEventMask);
    HRESULT StopProfiling(HRESULT hrShutdownReason);
}

const GUID IID_IActiveScriptProfilerControl2 = {0x47810165, 0x498F, 0x40BE, [0x94, 0xF1, 0x65, 0x35, 0x57, 0xE9, 0xE7, 0xDA]};
@GUID(0x47810165, 0x498F, 0x40BE, [0x94, 0xF1, 0x65, 0x35, 0x57, 0xE9, 0xE7, 0xDA]);
interface IActiveScriptProfilerControl2 : IActiveScriptProfilerControl
{
    HRESULT CompleteProfilerStart();
    HRESULT PrepareProfilerStop();
}

enum __MIDL___MIDL_itf_activprof_0000_0002_0001
{
    PROFILER_HEAP_OBJECT_FLAGS_NEW_OBJECT = 1,
    PROFILER_HEAP_OBJECT_FLAGS_IS_ROOT = 2,
    PROFILER_HEAP_OBJECT_FLAGS_SITE_CLOSED = 4,
    PROFILER_HEAP_OBJECT_FLAGS_EXTERNAL = 8,
    PROFILER_HEAP_OBJECT_FLAGS_EXTERNAL_UNKNOWN = 16,
    PROFILER_HEAP_OBJECT_FLAGS_EXTERNAL_DISPATCH = 32,
    PROFILER_HEAP_OBJECT_FLAGS_SIZE_APPROXIMATE = 64,
    PROFILER_HEAP_OBJECT_FLAGS_SIZE_UNAVAILABLE = 128,
    PROFILER_HEAP_OBJECT_FLAGS_NEW_STATE_UNAVAILABLE = 256,
    PROFILER_HEAP_OBJECT_FLAGS_WINRT_INSTANCE = 512,
    PROFILER_HEAP_OBJECT_FLAGS_WINRT_RUNTIMECLASS = 1024,
    PROFILER_HEAP_OBJECT_FLAGS_WINRT_DELEGATE = 2048,
    PROFILER_HEAP_OBJECT_FLAGS_WINRT_NAMESPACE = 4096,
}

enum __MIDL___MIDL_itf_activprof_0000_0002_0002
{
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_PROTOTYPE = 1,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_FUNCTION_NAME = 2,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_SCOPE_LIST = 3,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_INTERNAL_PROPERTY = 4,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_NAME_PROPERTIES = 5,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_INDEX_PROPERTIES = 6,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_ELEMENT_ATTRIBUTES_SIZE = 7,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_ELEMENT_TEXT_CHILDREN_SIZE = 8,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_RELATIONSHIPS = 9,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_WINRTEVENTS = 10,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_WEAKMAP_COLLECTION_LIST = 11,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_MAP_COLLECTION_LIST = 12,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_SET_COLLECTION_LIST = 13,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_MAX_VALUE = 13,
}

enum __MIDL___MIDL_itf_activprof_0000_0002_0003
{
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_NONE = 0,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_IS_GET_ACCESSOR = 65536,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_IS_SET_ACCESSOR = 131072,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_LET_VARIABLE = 262144,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_CONST_VARIABLE = 524288,
}

enum __MIDL___MIDL_itf_activprof_0000_0002_0004
{
    PROFILER_HEAP_ENUM_FLAGS_NONE = 0,
    PROFILER_HEAP_ENUM_FLAGS_STORE_RELATIONSHIP_FLAGS = 1,
    PROFILER_HEAP_ENUM_FLAGS_SUBSTRINGS = 2,
    PROFILER_HEAP_ENUM_FLAGS_RELATIONSHIP_SUBSTRINGS = 3,
}

struct PROFILER_HEAP_OBJECT_SCOPE_LIST
{
    uint count;
    uint scopes;
}

enum __MIDL___MIDL_itf_activprof_0000_0002_0005
{
    PROFILER_PROPERTY_TYPE_NUMBER = 1,
    PROFILER_PROPERTY_TYPE_STRING = 2,
    PROFILER_PROPERTY_TYPE_HEAP_OBJECT = 3,
    PROFILER_PROPERTY_TYPE_EXTERNAL_OBJECT = 4,
    PROFILER_PROPERTY_TYPE_BSTR = 5,
    PROFILER_PROPERTY_TYPE_SUBSTRING = 6,
}

struct PROFILER_PROPERTY_TYPE_SUBSTRING_INFO
{
    uint length;
    const(wchar)* value;
}

struct PROFILER_HEAP_OBJECT_RELATIONSHIP
{
    uint relationshipId;
    __MIDL___MIDL_itf_activprof_0000_0002_0005 relationshipInfo;
    _Anonymous_e__Union Anonymous;
}

struct PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST
{
    uint count;
    PROFILER_HEAP_OBJECT_RELATIONSHIP elements;
}

struct PROFILER_HEAP_OBJECT_OPTIONAL_INFO
{
    __MIDL___MIDL_itf_activprof_0000_0002_0002 infoType;
    _Anonymous_e__Union Anonymous;
}

struct PROFILER_HEAP_OBJECT
{
    uint size;
    _Anonymous_e__Union Anonymous;
    uint typeNameId;
    uint flags;
    ushort unused;
    ushort optionalInfoCount;
}

const GUID IID_IActiveScriptProfilerHeapEnum = {0x32E4694E, 0x0D37, 0x419B, [0xB9, 0x3D, 0xFA, 0x20, 0xDE, 0xD6, 0xE8, 0xEA]};
@GUID(0x32E4694E, 0x0D37, 0x419B, [0xB9, 0x3D, 0xFA, 0x20, 0xDE, 0xD6, 0xE8, 0xEA]);
interface IActiveScriptProfilerHeapEnum : IUnknown
{
    HRESULT Next(uint celt, PROFILER_HEAP_OBJECT** heapObjects, uint* pceltFetched);
    HRESULT GetOptionalInfo(PROFILER_HEAP_OBJECT* heapObject, uint celt, PROFILER_HEAP_OBJECT_OPTIONAL_INFO* optionalInfo);
    HRESULT FreeObjectAndOptionalInfo(uint celt, PROFILER_HEAP_OBJECT** heapObjects);
    HRESULT GetNameIdMap(ushort*** pNameList, uint* pcelt);
}

const GUID IID_IActiveScriptProfilerControl3 = {0x0B403015, 0xF381, 0x4023, [0xA5, 0xD0, 0x6F, 0xED, 0x07, 0x6D, 0xE7, 0x16]};
@GUID(0x0B403015, 0xF381, 0x4023, [0xA5, 0xD0, 0x6F, 0xED, 0x07, 0x6D, 0xE7, 0x16]);
interface IActiveScriptProfilerControl3 : IActiveScriptProfilerControl2
{
    HRESULT EnumHeap(IActiveScriptProfilerHeapEnum* ppEnum);
}

enum __MIDL___MIDL_itf_activprof_0000_0004_0001
{
    PROFILER_HEAP_SUMMARY_VERSION_1 = 1,
}

struct PROFILER_HEAP_SUMMARY
{
    __MIDL___MIDL_itf_activprof_0000_0004_0001 version;
    uint totalHeapSize;
}

const GUID IID_IActiveScriptProfilerControl4 = {0x160F94FD, 0x9DBC, 0x40D4, [0x9E, 0xAC, 0x2B, 0x71, 0xDB, 0x31, 0x32, 0xF4]};
@GUID(0x160F94FD, 0x9DBC, 0x40D4, [0x9E, 0xAC, 0x2B, 0x71, 0xDB, 0x31, 0x32, 0xF4]);
interface IActiveScriptProfilerControl4 : IActiveScriptProfilerControl3
{
    HRESULT SummarizeHeap(PROFILER_HEAP_SUMMARY* heapSummary);
}

const GUID IID_IActiveScriptProfilerControl5 = {0x1C01A2D1, 0x8F0F, 0x46A5, [0x97, 0x20, 0x0D, 0x7E, 0xD2, 0xC6, 0x2F, 0x0A]};
@GUID(0x1C01A2D1, 0x8F0F, 0x46A5, [0x97, 0x20, 0x0D, 0x7E, 0xD2, 0xC6, 0x2F, 0x0A]);
interface IActiveScriptProfilerControl5 : IActiveScriptProfilerControl4
{
    HRESULT EnumHeap2(__MIDL___MIDL_itf_activprof_0000_0002_0004 enumFlags, IActiveScriptProfilerHeapEnum* ppEnum);
}

const GUID IID_IActiveScriptProfilerCallback = {0x740ECA23, 0x7D9D, 0x42E5, [0xBA, 0x9D, 0xF8, 0xB2, 0x4B, 0x1C, 0x7A, 0x9B]};
@GUID(0x740ECA23, 0x7D9D, 0x42E5, [0xBA, 0x9D, 0xF8, 0xB2, 0x4B, 0x1C, 0x7A, 0x9B]);
interface IActiveScriptProfilerCallback : IUnknown
{
    HRESULT Initialize(uint dwContext);
    HRESULT Shutdown(HRESULT hrReason);
    HRESULT ScriptCompiled(int scriptId, __MIDL___MIDL_itf_activprof_0000_0000_0001 type, IUnknown pIDebugDocumentContext);
    HRESULT FunctionCompiled(int functionId, int scriptId, const(wchar)* pwszFunctionName, const(wchar)* pwszFunctionNameHint, IUnknown pIDebugDocumentContext);
    HRESULT OnFunctionEnter(int scriptId, int functionId);
    HRESULT OnFunctionExit(int scriptId, int functionId);
}

const GUID IID_IActiveScriptProfilerCallback2 = {0x31B7F8AD, 0xA637, 0x409C, [0xB2, 0x2F, 0x04, 0x09, 0x95, 0xB6, 0x10, 0x3D]};
@GUID(0x31B7F8AD, 0xA637, 0x409C, [0xB2, 0x2F, 0x04, 0x09, 0x95, 0xB6, 0x10, 0x3D]);
interface IActiveScriptProfilerCallback2 : IActiveScriptProfilerCallback
{
    HRESULT OnFunctionEnterByName(const(wchar)* pwszFunctionName, __MIDL___MIDL_itf_activprof_0000_0000_0001 type);
    HRESULT OnFunctionExitByName(const(wchar)* pwszFunctionName, __MIDL___MIDL_itf_activprof_0000_0000_0001 type);
}

const GUID IID_IActiveScriptProfilerCallback3 = {0x6AC5AD25, 0x2037, 0x4687, [0x91, 0xDF, 0xB5, 0x99, 0x79, 0xD9, 0x3D, 0x73]};
@GUID(0x6AC5AD25, 0x2037, 0x4687, [0x91, 0xDF, 0xB5, 0x99, 0x79, 0xD9, 0x3D, 0x73]);
interface IActiveScriptProfilerCallback3 : IActiveScriptProfilerCallback2
{
    HRESULT SetWebWorkerId(uint webWorkerId);
}

const GUID CLSID_HTMLCSSStyleDeclaration = {0x30510741, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510741, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLCSSStyleDeclaration;

const GUID CLSID_HTMLStyle = {0x3050F285, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F285, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStyle;

const GUID CLSID_HTMLRuleStyle = {0x3050F3D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLRuleStyle;

const GUID CLSID_HTMLCSSRule = {0x305106EF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106EF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLCSSRule;

const GUID CLSID_HTMLCSSImportRule = {0x305106F0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106F0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLCSSImportRule;

const GUID CLSID_HTMLCSSMediaRule = {0x305106F1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106F1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLCSSMediaRule;

const GUID CLSID_HTMLCSSMediaList = {0x30510732, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510732, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLCSSMediaList;

const GUID CLSID_HTMLCSSNamespaceRule = {0x305106F2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106F2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLCSSNamespaceRule;

const GUID CLSID_HTMLMSCSSKeyframeRule = {0x3051080E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051080E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLMSCSSKeyframeRule;

const GUID CLSID_HTMLMSCSSKeyframesRule = {0x3051080F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051080F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLMSCSSKeyframesRule;

const GUID CLSID_HTMLRenderStyle = {0x3050F6AA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6AA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLRenderStyle;

const GUID CLSID_HTMLCurrentStyle = {0x3050F3DC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3DC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLCurrentStyle;

const GUID CLSID_HTMLDOMAttribute = {0x3050F4B2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4B2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDOMAttribute;

const GUID CLSID_HTMLDOMTextNode = {0x3050F4BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDOMTextNode;

const GUID CLSID_HTMLDOMImplementation = {0x3050F80E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F80E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDOMImplementation;

const GUID CLSID_HTMLAttributeCollection = {0x3050F4CC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4CC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLAttributeCollection;

const GUID CLSID_StaticNodeList = {0x30510467, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510467, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct StaticNodeList;

const GUID CLSID_DOMChildrenCollection = {0x3050F5AA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5AA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMChildrenCollection;

const GUID CLSID_HTMLDefaults = {0x3050F6C8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6C8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDefaults;

const GUID CLSID_HTCDefaultDispatch = {0x3050F4FC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4FC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTCDefaultDispatch;

const GUID CLSID_HTCPropertyBehavior = {0x3050F5DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTCPropertyBehavior;

const GUID CLSID_HTCMethodBehavior = {0x3050F630, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F630, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTCMethodBehavior;

const GUID CLSID_HTCEventBehavior = {0x3050F4FE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4FE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTCEventBehavior;

const GUID CLSID_HTCAttachBehavior = {0x3050F5F5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5F5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTCAttachBehavior;

const GUID CLSID_HTCDescBehavior = {0x3050F5DD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5DD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTCDescBehavior;

const GUID CLSID_HTMLUrnCollection = {0x3050F580, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F580, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLUrnCollection;

const GUID CLSID_HTMLGenericElement = {0x3050F4B8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4B8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLGenericElement;

const GUID CLSID_HTMLStyleSheetRule = {0x3050F3CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStyleSheetRule;

const GUID CLSID_HTMLStyleSheetRulesCollection = {0x3050F3CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStyleSheetRulesCollection;

const GUID CLSID_HTMLStyleSheetPage = {0x3050F7EF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7EF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStyleSheetPage;

const GUID CLSID_HTMLStyleSheetPagesCollection = {0x3050F7F1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7F1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStyleSheetPagesCollection;

const GUID CLSID_HTMLStyleSheet = {0x3050F2E4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2E4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStyleSheet;

const GUID CLSID_HTMLStyleSheetsCollection = {0x3050F37F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F37F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStyleSheetsCollection;

const GUID CLSID_HTMLLinkElement = {0x3050F277, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F277, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLLinkElement;

const GUID CLSID_HTMLDOMRange = {0x305106C3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106C3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDOMRange;

const GUID CLSID_HTMLFormElement = {0x3050F251, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F251, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLFormElement;

const GUID CLSID_HTMLTextElement = {0x3050F26A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F26A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLTextElement;

const GUID CLSID_HTMLImg = {0x3050F241, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F241, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLImg;

const GUID CLSID_HTMLImageElementFactory = {0x3050F38F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F38F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLImageElementFactory;

const GUID CLSID_HTMLBody = {0x3050F24A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F24A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLBody;

const GUID CLSID_HTMLFontElement = {0x3050F27B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F27B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLFontElement;

const GUID CLSID_HTMLAnchorElement = {0x3050F248, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F248, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLAnchorElement;

const GUID CLSID_HTMLLabelElement = {0x3050F32B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F32B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLLabelElement;

const GUID CLSID_HTMLListElement = {0x3050F272, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F272, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLListElement;

const GUID CLSID_HTMLUListElement = {0x3050F269, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F269, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLUListElement;

const GUID CLSID_HTMLOListElement = {0x3050F270, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F270, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLOListElement;

const GUID CLSID_HTMLLIElement = {0x3050F273, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F273, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLLIElement;

const GUID CLSID_HTMLBlockElement = {0x3050F281, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F281, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLBlockElement;

const GUID CLSID_HTMLDivElement = {0x3050F27E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F27E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDivElement;

const GUID CLSID_HTMLDDElement = {0x3050F27F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F27F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDDElement;

const GUID CLSID_HTMLDTElement = {0x3050F27C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F27C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDTElement;

const GUID CLSID_HTMLBRElement = {0x3050F280, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F280, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLBRElement;

const GUID CLSID_HTMLDListElement = {0x3050F27D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F27D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDListElement;

const GUID CLSID_HTMLHRElement = {0x3050F252, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F252, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLHRElement;

const GUID CLSID_HTMLParaElement = {0x3050F26F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F26F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLParaElement;

const GUID CLSID_HTMLElementCollection = {0x3050F4CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLElementCollection;

const GUID CLSID_HTMLHeaderElement = {0x3050F27A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F27A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLHeaderElement;

const GUID CLSID_HTMLSelectElement = {0x3050F245, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F245, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLSelectElement;

const GUID CLSID_HTMLWndSelectElement = {0x3050F2CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLWndSelectElement;

const GUID CLSID_HTMLOptionElement = {0x3050F24D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F24D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLOptionElement;

const GUID CLSID_HTMLOptionElementFactory = {0x3050F38D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F38D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLOptionElementFactory;

const GUID CLSID_HTMLWndOptionElement = {0x3050F2D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLWndOptionElement;

const GUID CLSID_HTMLInputElement = {0x3050F5D8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5D8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLInputElement;

const GUID CLSID_HTMLTextAreaElement = {0x3050F2AC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2AC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLTextAreaElement;

const GUID CLSID_HTMLRichtextElement = {0x3050F2DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLRichtextElement;

const GUID CLSID_HTMLButtonElement = {0x3050F2C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLButtonElement;

const GUID CLSID_HTMLMarqueeElement = {0x3050F2B9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2B9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLMarqueeElement;

const GUID CLSID_HTMLHtmlElement = {0x3050F491, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F491, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLHtmlElement;

const GUID CLSID_HTMLHeadElement = {0x3050F493, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F493, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLHeadElement;

const GUID CLSID_HTMLTitleElement = {0x3050F284, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F284, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLTitleElement;

const GUID CLSID_HTMLMetaElement = {0x3050F275, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F275, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLMetaElement;

const GUID CLSID_HTMLBaseElement = {0x3050F276, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F276, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLBaseElement;

const GUID CLSID_HTMLIsIndexElement = {0x3050F278, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F278, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLIsIndexElement;

const GUID CLSID_HTMLNextIdElement = {0x3050F279, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F279, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLNextIdElement;

const GUID CLSID_HTMLBaseFontElement = {0x3050F282, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F282, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLBaseFontElement;

const GUID CLSID_HTMLUnknownElement = {0x3050F268, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F268, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLUnknownElement;

const GUID CLSID_HTMLHistory = {0xFECEAAA3, 0x8405, 0x11CF, [0x8B, 0xA1, 0x00, 0xAA, 0x00, 0x47, 0x6D, 0xA6]};
@GUID(0xFECEAAA3, 0x8405, 0x11CF, [0x8B, 0xA1, 0x00, 0xAA, 0x00, 0x47, 0x6D, 0xA6]);
struct HTMLHistory;

const GUID CLSID_COpsProfile = {0x3050F402, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F402, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct COpsProfile;

const GUID CLSID_HTMLNavigator = {0xFECEAAA6, 0x8405, 0x11CF, [0x8B, 0xA1, 0x00, 0xAA, 0x00, 0x47, 0x6D, 0xA6]};
@GUID(0xFECEAAA6, 0x8405, 0x11CF, [0x8B, 0xA1, 0x00, 0xAA, 0x00, 0x47, 0x6D, 0xA6]);
struct HTMLNavigator;

const GUID CLSID_HTMLLocation = {0x163BB1E1, 0x6E00, 0x11CF, [0x83, 0x7A, 0x48, 0xDC, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x163BB1E1, 0x6E00, 0x11CF, [0x83, 0x7A, 0x48, 0xDC, 0x04, 0xC1, 0x00, 0x00]);
struct HTMLLocation;

const GUID CLSID_CMimeTypes = {0x3050F3FE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3FE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct CMimeTypes;

const GUID CLSID_CPlugins = {0x3050F3FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct CPlugins;

const GUID CLSID_CEventObj = {0x3050F48A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F48A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct CEventObj;

const GUID CLSID_HTMLStyleMedia = {0x3051074C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051074C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStyleMedia;

const GUID CLSID_FramesCollection = {0x3050F7F6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7F6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct FramesCollection;

const GUID CLSID_HTMLScreen = {0x3050F35D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F35D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLScreen;

const GUID CLSID_HTMLWindow2 = {0xD48A6EC6, 0x6A4A, 0x11CF, [0x94, 0xA7, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0xD48A6EC6, 0x6A4A, 0x11CF, [0x94, 0xA7, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
struct HTMLWindow2;

const GUID CLSID_HTMLWindowProxy = {0x3050F391, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F391, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLWindowProxy;

const GUID CLSID_HTMLDocumentCompatibleInfo = {0x3051041B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051041B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDocumentCompatibleInfo;

const GUID CLSID_HTMLDocumentCompatibleInfoCollection = {0x30510419, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510419, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDocumentCompatibleInfoCollection;

const GUID CLSID_HTMLDocument = {0x25336920, 0x03F9, 0x11CF, [0x8F, 0xD0, 0x00, 0xAA, 0x00, 0x68, 0x6F, 0x13]};
@GUID(0x25336920, 0x03F9, 0x11CF, [0x8F, 0xD0, 0x00, 0xAA, 0x00, 0x68, 0x6F, 0x13]);
struct HTMLDocument;

const GUID CLSID_Scriptlet = {0xAE24FDAE, 0x03C6, 0x11D1, [0x8B, 0x76, 0x00, 0x80, 0xC7, 0x44, 0xF3, 0x89]};
@GUID(0xAE24FDAE, 0x03C6, 0x11D1, [0x8B, 0x76, 0x00, 0x80, 0xC7, 0x44, 0xF3, 0x89]);
struct Scriptlet;

const GUID CLSID_HTMLEmbed = {0x3050F25D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F25D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLEmbed;

const GUID CLSID_HTMLAreasCollection = {0x3050F4CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLAreasCollection;

const GUID CLSID_HTMLMapElement = {0x3050F271, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F271, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLMapElement;

const GUID CLSID_HTMLAreaElement = {0x3050F283, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F283, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLAreaElement;

const GUID CLSID_HTMLTableCaption = {0x3050F2EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLTableCaption;

const GUID CLSID_HTMLCommentElement = {0x3050F317, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F317, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLCommentElement;

const GUID CLSID_HTMLPhraseElement = {0x3050F26E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F26E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLPhraseElement;

const GUID CLSID_HTMLSpanElement = {0x3050F3F5, 0x98B4, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3F5, 0x98B4, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLSpanElement;

const GUID CLSID_HTMLTable = {0x3050F26B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F26B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLTable;

const GUID CLSID_HTMLTableCol = {0x3050F26C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F26C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLTableCol;

const GUID CLSID_HTMLTableSection = {0x3050F2E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLTableSection;

const GUID CLSID_HTMLTableRow = {0x3050F26D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F26D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLTableRow;

const GUID CLSID_HTMLTableCell = {0x3050F246, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F246, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLTableCell;

const GUID CLSID_HTMLScriptElement = {0x3050F28C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F28C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLScriptElement;

const GUID CLSID_HTMLNoShowElement = {0x3050F38B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F38B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLNoShowElement;

const GUID CLSID_HTMLObjectElement = {0x3050F24E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F24E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLObjectElement;

const GUID CLSID_HTMLParamElement = {0x3050F83E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F83E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLParamElement;

const GUID CLSID_HTMLFrameBase = {0x3050F312, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F312, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLFrameBase;

const GUID CLSID_HTMLFrameElement = {0x3050F314, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F314, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLFrameElement;

const GUID CLSID_HTMLIFrame = {0x3050F316, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F316, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLIFrame;

const GUID CLSID_HTMLDivPosition = {0x3050F249, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F249, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDivPosition;

const GUID CLSID_HTMLFieldSetElement = {0x3050F3E8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3E8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLFieldSetElement;

const GUID CLSID_HTMLLegendElement = {0x3050F3E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLLegendElement;

const GUID CLSID_HTMLSpanFlow = {0x3050F3E6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3E6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLSpanFlow;

const GUID CLSID_HTMLFrameSetSite = {0x3050F31A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F31A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLFrameSetSite;

const GUID CLSID_HTMLBGsound = {0x3050F370, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F370, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLBGsound;

const GUID CLSID_HTMLStyleElement = {0x3050F37D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F37D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStyleElement;

const GUID CLSID_HTMLStyleFontFace = {0x3050F3D4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3D4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStyleFontFace;

const GUID CLSID_XDomainRequest = {0x30510455, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510455, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct XDomainRequest;

const GUID CLSID_XDomainRequestFactory = {0x30510457, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510457, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct XDomainRequestFactory;

const GUID CLSID_HTMLStorage = {0x30510475, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510475, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLStorage;

const GUID CLSID_DOMEvent = {0x305104BB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104BB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMEvent;

const GUID CLSID_DOMUIEvent = {0x305106CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMUIEvent;

const GUID CLSID_DOMMouseEvent = {0x305106CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMMouseEvent;

const GUID CLSID_DOMDragEvent = {0x30510762, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510762, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMDragEvent;

const GUID CLSID_DOMMouseWheelEvent = {0x305106D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMMouseWheelEvent;

const GUID CLSID_DOMWheelEvent = {0x305106D3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106D3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMWheelEvent;

const GUID CLSID_DOMTextEvent = {0x305106D5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106D5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMTextEvent;

const GUID CLSID_DOMKeyboardEvent = {0x305106D7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106D7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMKeyboardEvent;

const GUID CLSID_DOMCompositionEvent = {0x305106D9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106D9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMCompositionEvent;

const GUID CLSID_DOMMutationEvent = {0x305106DB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106DB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMMutationEvent;

const GUID CLSID_DOMBeforeUnloadEvent = {0x30510764, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510764, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMBeforeUnloadEvent;

const GUID CLSID_DOMFocusEvent = {0x305106CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMFocusEvent;

const GUID CLSID_DOMCustomEvent = {0x305106DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMCustomEvent;

const GUID CLSID_CanvasGradient = {0x30510715, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510715, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct CanvasGradient;

const GUID CLSID_CanvasPattern = {0x30510717, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510717, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct CanvasPattern;

const GUID CLSID_CanvasTextMetrics = {0x30510719, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510719, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct CanvasTextMetrics;

const GUID CLSID_CanvasImageData = {0x3051071B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051071B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct CanvasImageData;

const GUID CLSID_CanvasRenderingContext2D = {0x30510700, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510700, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct CanvasRenderingContext2D;

const GUID CLSID_HTMLCanvasElement = {0x305106E5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106E5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLCanvasElement;

const GUID CLSID_DOMProgressEvent = {0x3051071F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051071F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMProgressEvent;

const GUID CLSID_DOMMessageEvent = {0x30510721, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510721, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMMessageEvent;

const GUID CLSID_DOMSiteModeEvent = {0x30510766, 0x98B6, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510766, 0x98B6, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMSiteModeEvent;

const GUID CLSID_DOMStorageEvent = {0x30510723, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510723, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMStorageEvent;

const GUID CLSID_XMLHttpRequestEventTarget = {0x30510831, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510831, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct XMLHttpRequestEventTarget;

const GUID CLSID_HTMLXMLHttpRequest = {0x3051040B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051040B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLXMLHttpRequest;

const GUID CLSID_HTMLXMLHttpRequestFactory = {0x3051040D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051040D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLXMLHttpRequestFactory;

const GUID CLSID_SVGAngle = {0x30510584, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510584, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAngle;

const GUID CLSID_SVGAnimatedAngle = {0x305105E4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105E4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedAngle;

const GUID CLSID_SVGAnimatedTransformList = {0x305105B1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105B1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedTransformList;

const GUID CLSID_SVGAnimatedBoolean = {0x3051058B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051058B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedBoolean;

const GUID CLSID_SVGAnimatedEnumeration = {0x3051058E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051058E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedEnumeration;

const GUID CLSID_SVGAnimatedInteger = {0x3051058F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051058F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedInteger;

const GUID CLSID_SVGAnimatedLength = {0x30510581, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510581, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedLength;

const GUID CLSID_SVGAnimatedLengthList = {0x30510582, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510582, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedLengthList;

const GUID CLSID_SVGAnimatedNumber = {0x30510588, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510588, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedNumber;

const GUID CLSID_SVGAnimatedNumberList = {0x3051058A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051058A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedNumberList;

const GUID CLSID_SVGAnimatedRect = {0x30510586, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510586, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedRect;

const GUID CLSID_SVGAnimatedString = {0x3051058C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051058C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedString;

const GUID CLSID_SVGClipPathElement = {0x305105E6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105E6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGClipPathElement;

const GUID CLSID_SVGElement = {0x30510564, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510564, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGElement;

const GUID CLSID_SVGLength = {0x3051057E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051057E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGLength;

const GUID CLSID_SVGLengthList = {0x30510580, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510580, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGLengthList;

const GUID CLSID_SVGMatrix = {0x305105AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGMatrix;

const GUID CLSID_SVGNumber = {0x30510587, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510587, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGNumber;

const GUID CLSID_SVGNumberList = {0x30510589, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510589, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGNumberList;

const GUID CLSID_SVGPatternElement = {0x305105D4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105D4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPatternElement;

const GUID CLSID_SVGPathSeg = {0x305105B3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105B3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSeg;

const GUID CLSID_SVGPathSegArcAbs = {0x305105BB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105BB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegArcAbs;

const GUID CLSID_SVGPathSegArcRel = {0x305105BC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105BC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegArcRel;

const GUID CLSID_SVGPathSegClosePath = {0x305105BD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105BD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegClosePath;

const GUID CLSID_SVGPathSegMovetoAbs = {0x305105CC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105CC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegMovetoAbs;

const GUID CLSID_SVGPathSegMovetoRel = {0x305105CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegMovetoRel;

const GUID CLSID_SVGPathSegLinetoAbs = {0x305105C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegLinetoAbs;

const GUID CLSID_SVGPathSegLinetoRel = {0x305105C9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105C9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegLinetoRel;

const GUID CLSID_SVGPathSegCurvetoCubicAbs = {0x305105BE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105BE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegCurvetoCubicAbs;

const GUID CLSID_SVGPathSegCurvetoCubicRel = {0x305105BF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105BF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegCurvetoCubicRel;

const GUID CLSID_SVGPathSegCurvetoCubicSmoothAbs = {0x305105C0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105C0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegCurvetoCubicSmoothAbs;

const GUID CLSID_SVGPathSegCurvetoCubicSmoothRel = {0x305105C1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105C1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegCurvetoCubicSmoothRel;

const GUID CLSID_SVGPathSegCurvetoQuadraticAbs = {0x305105C2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105C2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegCurvetoQuadraticAbs;

const GUID CLSID_SVGPathSegCurvetoQuadraticRel = {0x305105C3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105C3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegCurvetoQuadraticRel;

const GUID CLSID_SVGPathSegCurvetoQuadraticSmoothAbs = {0x305105C4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105C4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegCurvetoQuadraticSmoothAbs;

const GUID CLSID_SVGPathSegCurvetoQuadraticSmoothRel = {0x305105C5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105C5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegCurvetoQuadraticSmoothRel;

const GUID CLSID_SVGPathSegLinetoHorizontalAbs = {0x305105C7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105C7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegLinetoHorizontalAbs;

const GUID CLSID_SVGPathSegLinetoHorizontalRel = {0x305105C8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105C8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegLinetoHorizontalRel;

const GUID CLSID_SVGPathSegLinetoVerticalAbs = {0x305105CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegLinetoVerticalAbs;

const GUID CLSID_SVGPathSegLinetoVerticalRel = {0x305105CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegLinetoVerticalRel;

const GUID CLSID_SVGPathSegList = {0x305105B4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105B4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathSegList;

const GUID CLSID_SVGPoint = {0x305105BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPoint;

const GUID CLSID_SVGPointList = {0x305105B9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105B9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPointList;

const GUID CLSID_SVGRect = {0x30510583, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510583, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGRect;

const GUID CLSID_SVGStringList = {0x3051058D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051058D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGStringList;

const GUID CLSID_SVGTransform = {0x305105AF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105AF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGTransform;

const GUID CLSID_SVGSVGElement = {0x30510574, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510574, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGSVGElement;

const GUID CLSID_SVGUseElement = {0x30510590, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510590, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGUseElement;

const GUID CLSID_HTMLStyleSheetRulesAppliedCollection = {0xEB36F845, 0x2395, 0x4719, [0xB8, 0x5C, 0xD0, 0xD8, 0x0E, 0x18, 0x4B, 0xD9]};
@GUID(0xEB36F845, 0x2395, 0x4719, [0xB8, 0x5C, 0xD0, 0xD8, 0x0E, 0x18, 0x4B, 0xD9]);
struct HTMLStyleSheetRulesAppliedCollection;

const GUID CLSID_RulesApplied = {0x7C803920, 0x7A53, 0x4D26, [0x98, 0xAC, 0xFD, 0xD2, 0x3E, 0x6B, 0x9E, 0x01]};
@GUID(0x7C803920, 0x7A53, 0x4D26, [0x98, 0xAC, 0xFD, 0xD2, 0x3E, 0x6B, 0x9E, 0x01]);
struct RulesApplied;

const GUID CLSID_RulesAppliedCollection = {0x671926EE, 0xC3CF, 0x40AF, [0xBE, 0x8F, 0x1C, 0xBA, 0xEE, 0x64, 0x86, 0xE8]};
@GUID(0x671926EE, 0xC3CF, 0x40AF, [0xBE, 0x8F, 0x1C, 0xBA, 0xEE, 0x64, 0x86, 0xE8]);
struct RulesAppliedCollection;

const GUID CLSID_HTMLW3CComputedStyle = {0x305106C8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106C8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLW3CComputedStyle;

const GUID CLSID_SVGTransformList = {0x305105B0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105B0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGTransformList;

const GUID CLSID_SVGCircleElement = {0x30510578, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510578, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGCircleElement;

const GUID CLSID_SVGEllipseElement = {0x30510579, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510579, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGEllipseElement;

const GUID CLSID_SVGLineElement = {0x3051057A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051057A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGLineElement;

const GUID CLSID_SVGRectElement = {0x30510577, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510577, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGRectElement;

const GUID CLSID_SVGPolygonElement = {0x3051057B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051057B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPolygonElement;

const GUID CLSID_SVGPolylineElement = {0x3051057C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051057C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPolylineElement;

const GUID CLSID_SVGGElement = {0x3051056F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051056F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGGElement;

const GUID CLSID_SVGSymbolElement = {0x30510571, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510571, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGSymbolElement;

const GUID CLSID_SVGDefsElement = {0x30510570, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510570, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGDefsElement;

const GUID CLSID_SVGPathElement = {0x305105B2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105B2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPathElement;

const GUID CLSID_SVGPreserveAspectRatio = {0x305105D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGPreserveAspectRatio;

const GUID CLSID_SVGTextElement = {0x305105DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGTextElement;

const GUID CLSID_SVGAnimatedPreserveAspectRatio = {0x305105CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAnimatedPreserveAspectRatio;

const GUID CLSID_SVGImageElement = {0x305105CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGImageElement;

const GUID CLSID_SVGStopElement = {0x305105D5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105D5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGStopElement;

const GUID CLSID_SVGGradientElement = {0x305105D6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105D6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGGradientElement;

const GUID CLSID_SVGLinearGradientElement = {0x305105D2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105D2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGLinearGradientElement;

const GUID CLSID_SVGRadialGradientElement = {0x305105D3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105D3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGRadialGradientElement;

const GUID CLSID_SVGMaskElement = {0x305105E7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105E7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGMaskElement;

const GUID CLSID_SVGMarkerElement = {0x305105DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGMarkerElement;

const GUID CLSID_SVGZoomEvent = {0x305105D9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105D9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGZoomEvent;

const GUID CLSID_SVGAElement = {0x305105DB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105DB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGAElement;

const GUID CLSID_SVGViewElement = {0x305105DC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105DC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGViewElement;

const GUID CLSID_HTMLMediaError = {0x3051070A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051070A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLMediaError;

const GUID CLSID_HTMLTimeRanges = {0x3051070B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051070B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLTimeRanges;

const GUID CLSID_HTMLMediaElement = {0x3051070C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051070C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLMediaElement;

const GUID CLSID_HTMLSourceElement = {0x3051070D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051070D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLSourceElement;

const GUID CLSID_HTMLAudioElement = {0x3051070E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051070E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLAudioElement;

const GUID CLSID_HTMLAudioElementFactory = {0x305107EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLAudioElementFactory;

const GUID CLSID_HTMLVideoElement = {0x3051070F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051070F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLVideoElement;

const GUID CLSID_SVGSwitchElement = {0x305105D8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105D8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGSwitchElement;

const GUID CLSID_SVGDescElement = {0x30510572, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510572, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGDescElement;

const GUID CLSID_SVGTitleElement = {0x30510573, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510573, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGTitleElement;

const GUID CLSID_SVGMetadataElement = {0x305105D7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105D7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGMetadataElement;

const GUID CLSID_SVGElementInstance = {0x30510575, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510575, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGElementInstance;

const GUID CLSID_SVGElementInstanceList = {0x30510576, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510576, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGElementInstanceList;

const GUID CLSID_DOMException = {0x3051072C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051072C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMException;

const GUID CLSID_RangeException = {0x3051072E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051072E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct RangeException;

const GUID CLSID_SVGException = {0x30510730, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510730, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGException;

const GUID CLSID_EventException = {0x3051073B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051073B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct EventException;

const GUID CLSID_SVGScriptElement = {0x305105E1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105E1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGScriptElement;

const GUID CLSID_SVGStyleElement = {0x305105D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGStyleElement;

const GUID CLSID_SVGTextContentElement = {0x305105DD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105DD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGTextContentElement;

const GUID CLSID_SVGTextPositioningElement = {0x305105E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGTextPositioningElement;

const GUID CLSID_DOMDocumentType = {0x30510739, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510739, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMDocumentType;

const GUID CLSID_NodeIterator = {0x30510745, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510745, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct NodeIterator;

const GUID CLSID_TreeWalker = {0x30510747, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510747, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct TreeWalker;

const GUID CLSID_DOMProcessingInstruction = {0x30510743, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510743, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMProcessingInstruction;

const GUID CLSID_HTMLPerformance = {0x3051074F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051074F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLPerformance;

const GUID CLSID_HTMLPerformanceNavigation = {0x30510751, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510751, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLPerformanceNavigation;

const GUID CLSID_HTMLPerformanceTiming = {0x30510753, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510753, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLPerformanceTiming;

const GUID CLSID_SVGTSpanElement = {0x305105E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGTSpanElement;

const GUID CLSID_CTemplatePrinter = {0x3050F6B3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6B3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct CTemplatePrinter;

const GUID CLSID_CPrintManagerTemplatePrinter = {0x63619F54, 0x9D71, 0x4C23, [0xA0, 0x8D, 0x50, 0xD7, 0xF1, 0x8D, 0xB2, 0xE9]};
@GUID(0x63619F54, 0x9D71, 0x4C23, [0xA0, 0x8D, 0x50, 0xD7, 0xF1, 0x8D, 0xB2, 0xE9]);
struct CPrintManagerTemplatePrinter;

const GUID CLSID_SVGTextPathElement = {0x305105EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct SVGTextPathElement;

const GUID CLSID_XMLSerializer = {0x3051077E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051077E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct XMLSerializer;

const GUID CLSID_DOMParser = {0x30510782, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510782, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMParser;

const GUID CLSID_HTMLDOMXmlSerializerFactory = {0x30510780, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510780, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDOMXmlSerializerFactory;

const GUID CLSID_DOMParserFactory = {0x30510784, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510784, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMParserFactory;

const GUID CLSID_HTMLSemanticElement = {0x305107B0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107B0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLSemanticElement;

const GUID CLSID_HTMLProgressElement = {0x3050F2D5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2D5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLProgressElement;

const GUID CLSID_DOMMSTransitionEvent = {0x305107B6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107B6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMMSTransitionEvent;

const GUID CLSID_DOMMSAnimationEvent = {0x305107B8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107B8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMMSAnimationEvent;

const GUID CLSID_WebGeolocation = {0x305107C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct WebGeolocation;

const GUID CLSID_WebGeocoordinates = {0x305107C8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107C8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct WebGeocoordinates;

const GUID CLSID_WebGeopositionError = {0x305107CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct WebGeopositionError;

const GUID CLSID_WebGeoposition = {0x305107CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct WebGeoposition;

const GUID CLSID_CClientCaps = {0x7E8BC44E, 0xAEFF, 0x11D1, [0x89, 0xC2, 0x00, 0xC0, 0x4F, 0xB6, 0xBF, 0xC4]};
@GUID(0x7E8BC44E, 0xAEFF, 0x11D1, [0x89, 0xC2, 0x00, 0xC0, 0x4F, 0xB6, 0xBF, 0xC4]);
struct CClientCaps;

const GUID CLSID_DOMMSManipulationEvent = {0x30510817, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510817, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMMSManipulationEvent;

const GUID CLSID_DOMCloseEvent = {0x30510800, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510800, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct DOMCloseEvent;

const GUID CLSID_ApplicationCache = {0x30510829, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510829, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct ApplicationCache;

const GUID CLSID_HtmlDlgSafeHelper = {0x3050F819, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F819, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HtmlDlgSafeHelper;

const GUID CLSID_BlockFormats = {0x3050F831, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F831, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct BlockFormats;

const GUID CLSID_FontNames = {0x3050F83A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F83A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct FontNames;

const GUID CLSID_HTMLNamespace = {0x3050F6BC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6BC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLNamespace;

const GUID CLSID_HTMLNamespaceCollection = {0x3050F6B9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6B9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLNamespaceCollection;

const GUID CLSID_ThreadDialogProcParam = {0x3050F5EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct ThreadDialogProcParam;

const GUID CLSID_HTMLDialog = {0x3050F28A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F28A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLDialog;

const GUID CLSID_HTMLPopup = {0x3050F667, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F667, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLPopup;

const GUID CLSID_HTMLAppBehavior = {0x3050F5CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLAppBehavior;

const GUID CLSID_OldHTMLDocument = {0xD48A6EC9, 0x6A4A, 0x11CF, [0x94, 0xA7, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0xD48A6EC9, 0x6A4A, 0x11CF, [0x94, 0xA7, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
struct OldHTMLDocument;

const GUID CLSID_OldHTMLFormElement = {0x0D04D285, 0x6BEC, 0x11CF, [0x8B, 0x97, 0x00, 0xAA, 0x00, 0x47, 0x6D, 0xA6]};
@GUID(0x0D04D285, 0x6BEC, 0x11CF, [0x8B, 0x97, 0x00, 0xAA, 0x00, 0x47, 0x6D, 0xA6]);
struct OldHTMLFormElement;

const GUID CLSID_HTMLInputButtonElement = {0x3050F2B4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2B4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLInputButtonElement;

const GUID CLSID_HTMLInputTextElement = {0x3050F2AB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2AB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLInputTextElement;

const GUID CLSID_HTMLInputFileElement = {0x3050F2AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLInputFileElement;

const GUID CLSID_HTMLOptionButtonElement = {0x3050F2BE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2BE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLOptionButtonElement;

const GUID CLSID_HTMLInputImage = {0x3050F2C4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2C4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
struct HTMLInputImage;

const GUID IID_IHTMLFiltersCollection = {0x3050F3EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFiltersCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

const GUID IID_IIE70DispatchEx = {0x3051046B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051046B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IIE70DispatchEx : IDispatchEx
{
}

const GUID IID_IIE80DispatchEx = {0x3051046C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051046C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IIE80DispatchEx : IDispatchEx
{
}

enum htmlDesignMode
{
    htmlDesignModeInherit = -2,
    htmlDesignModeOn = -1,
    htmlDesignModeOff = 0,
    htmlDesignMode_Max = 2147483647,
}

enum htmlZOrder
{
    htmlZOrderFront = 0,
    htmlZOrderBack = 1,
    htmlZOrder_Max = 2147483647,
}

enum htmlClear
{
    htmlClearNotSet = 0,
    htmlClearAll = 1,
    htmlClearLeft = 2,
    htmlClearRight = 3,
    htmlClearBoth = 4,
    htmlClearNone = 5,
    htmlClear_Max = 2147483647,
}

enum htmlControlAlign
{
    htmlControlAlignNotSet = 0,
    htmlControlAlignLeft = 1,
    htmlControlAlignCenter = 2,
    htmlControlAlignRight = 3,
    htmlControlAlignTextTop = 4,
    htmlControlAlignAbsMiddle = 5,
    htmlControlAlignBaseline = 6,
    htmlControlAlignAbsBottom = 7,
    htmlControlAlignBottom = 8,
    htmlControlAlignMiddle = 9,
    htmlControlAlignTop = 10,
    htmlControlAlign_Max = 2147483647,
}

enum htmlBlockAlign
{
    htmlBlockAlignNotSet = 0,
    htmlBlockAlignLeft = 1,
    htmlBlockAlignCenter = 2,
    htmlBlockAlignRight = 3,
    htmlBlockAlignJustify = 4,
    htmlBlockAlign_Max = 2147483647,
}

enum htmlReadyState
{
    htmlReadyStateuninitialized = 0,
    htmlReadyStateloading = 1,
    htmlReadyStateloaded = 2,
    htmlReadyStateinteractive = 3,
    htmlReadyStatecomplete = 4,
    htmlReadyState_Max = 2147483647,
}

enum htmlLoop
{
    htmlLoopLoopInfinite = -1,
    htmlLoop_Max = 2147483647,
}

enum mediaType
{
    mediaTypeNotSet = 0,
    mediaTypeAll = 511,
    mediaTypeAural = 1,
    mediaTypeBraille = 2,
    mediaTypeEmbossed = 4,
    mediaTypeHandheld = 8,
    mediaTypePrint = 16,
    mediaTypeProjection = 32,
    mediaTypeScreen = 64,
    mediaTypeTty = 128,
    mediaTypeTv = 256,
    mediaType_Max = 2147483647,
}

enum DomConstructor
{
    DomConstructorObject = 0,
    DomConstructorAttr = 1,
    DomConstructorBehaviorUrnsCollection = 2,
    DomConstructorBookmarkCollection = 3,
    DomConstructorCompatibleInfo = 4,
    DomConstructorCompatibleInfoCollection = 5,
    DomConstructorControlRangeCollection = 6,
    DomConstructorCSSCurrentStyleDeclaration = 7,
    DomConstructorCSSRuleList = 8,
    DomConstructorCSSRuleStyleDeclaration = 9,
    DomConstructorCSSStyleDeclaration = 10,
    DomConstructorCSSStyleRule = 11,
    DomConstructorCSSStyleSheet = 12,
    DomConstructorDataTransfer = 13,
    DomConstructorDOMImplementation = 14,
    DomConstructorElement = 15,
    DomConstructorEvent = 16,
    DomConstructorHistory = 17,
    DomConstructorHTCElementBehaviorDefaults = 18,
    DomConstructorHTMLAnchorElement = 19,
    DomConstructorHTMLAreaElement = 20,
    DomConstructorHTMLAreasCollection = 21,
    DomConstructorHTMLBaseElement = 22,
    DomConstructorHTMLBaseFontElement = 23,
    DomConstructorHTMLBGSoundElement = 24,
    DomConstructorHTMLBlockElement = 25,
    DomConstructorHTMLBodyElement = 26,
    DomConstructorHTMLBRElement = 27,
    DomConstructorHTMLButtonElement = 28,
    DomConstructorHTMLCollection = 29,
    DomConstructorHTMLCommentElement = 30,
    DomConstructorHTMLDDElement = 31,
    DomConstructorHTMLDivElement = 32,
    DomConstructorHTMLDocument = 33,
    DomConstructorHTMLDListElement = 34,
    DomConstructorHTMLDTElement = 35,
    DomConstructorHTMLEmbedElement = 36,
    DomConstructorHTMLFieldSetElement = 37,
    DomConstructorHTMLFontElement = 38,
    DomConstructorHTMLFormElement = 39,
    DomConstructorHTMLFrameElement = 40,
    DomConstructorHTMLFrameSetElement = 41,
    DomConstructorHTMLGenericElement = 42,
    DomConstructorHTMLHeadElement = 43,
    DomConstructorHTMLHeadingElement = 44,
    DomConstructorHTMLHRElement = 45,
    DomConstructorHTMLHtmlElement = 46,
    DomConstructorHTMLIFrameElement = 47,
    DomConstructorHTMLImageElement = 48,
    DomConstructorHTMLInputElement = 49,
    DomConstructorHTMLIsIndexElement = 50,
    DomConstructorHTMLLabelElement = 51,
    DomConstructorHTMLLegendElement = 52,
    DomConstructorHTMLLIElement = 53,
    DomConstructorHTMLLinkElement = 54,
    DomConstructorHTMLMapElement = 55,
    DomConstructorHTMLMarqueeElement = 56,
    DomConstructorHTMLMetaElement = 57,
    DomConstructorHTMLModelessDialog = 58,
    DomConstructorHTMLNamespaceInfo = 59,
    DomConstructorHTMLNamespaceInfoCollection = 60,
    DomConstructorHTMLNextIdElement = 61,
    DomConstructorHTMLNoShowElement = 62,
    DomConstructorHTMLObjectElement = 63,
    DomConstructorHTMLOListElement = 64,
    DomConstructorHTMLOptionElement = 65,
    DomConstructorHTMLParagraphElement = 66,
    DomConstructorHTMLParamElement = 67,
    DomConstructorHTMLPhraseElement = 68,
    DomConstructorHTMLPluginsCollection = 69,
    DomConstructorHTMLPopup = 70,
    DomConstructorHTMLScriptElement = 71,
    DomConstructorHTMLSelectElement = 72,
    DomConstructorHTMLSpanElement = 73,
    DomConstructorHTMLStyleElement = 74,
    DomConstructorHTMLTableCaptionElement = 75,
    DomConstructorHTMLTableCellElement = 76,
    DomConstructorHTMLTableColElement = 77,
    DomConstructorHTMLTableElement = 78,
    DomConstructorHTMLTableRowElement = 79,
    DomConstructorHTMLTableSectionElement = 80,
    DomConstructorHTMLTextAreaElement = 81,
    DomConstructorHTMLTextElement = 82,
    DomConstructorHTMLTitleElement = 83,
    DomConstructorHTMLUListElement = 84,
    DomConstructorHTMLUnknownElement = 85,
    DomConstructorImage = 86,
    DomConstructorLocation = 87,
    DomConstructorNamedNodeMap = 88,
    DomConstructorNavigator = 89,
    DomConstructorNodeList = 90,
    DomConstructorOption = 91,
    DomConstructorScreen = 92,
    DomConstructorSelection = 93,
    DomConstructorStaticNodeList = 94,
    DomConstructorStorage = 95,
    DomConstructorStyleSheetList = 96,
    DomConstructorStyleSheetPage = 97,
    DomConstructorStyleSheetPageList = 98,
    DomConstructorText = 99,
    DomConstructorTextRange = 100,
    DomConstructorTextRangeCollection = 101,
    DomConstructorTextRectangle = 102,
    DomConstructorTextRectangleList = 103,
    DomConstructorWindow = 104,
    DomConstructorXDomainRequest = 105,
    DomConstructorXMLHttpRequest = 106,
    DomConstructorMax = 107,
    DomConstructor_Max = 2147483647,
}

enum styleTextTransform
{
    styleTextTransformNotSet = 0,
    styleTextTransformCapitalize = 1,
    styleTextTransformLowercase = 2,
    styleTextTransformUppercase = 3,
    styleTextTransformNone = 4,
    styleTextTransform_Max = 2147483647,
}

enum styleDataRepeat
{
    styleDataRepeatNone = 0,
    styleDataRepeatInner = 1,
    styleDataRepeat_Max = 2147483647,
}

enum styleOverflow
{
    styleOverflowNotSet = 0,
    styleOverflowAuto = 1,
    styleOverflowHidden = 2,
    styleOverflowVisible = 3,
    styleOverflowScroll = 4,
    styleOverflow_Max = 2147483647,
}

enum styleMsOverflowStyle
{
    styleMsOverflowStyleNotSet = 0,
    styleMsOverflowStyleAuto = 1,
    styleMsOverflowStyleNone = 2,
    styleMsOverflowStyleScrollbar = 3,
    styleMsOverflowStyleMsAutoHidingScrollbar = 4,
    styleMsOverflowStyle_Max = 2147483647,
}

enum styleTableLayout
{
    styleTableLayoutNotSet = 0,
    styleTableLayoutAuto = 1,
    styleTableLayoutFixed = 2,
    styleTableLayout_Max = 2147483647,
}

enum styleBorderCollapse
{
    styleBorderCollapseNotSet = 0,
    styleBorderCollapseSeparate = 1,
    styleBorderCollapseCollapse = 2,
    styleBorderCollapse_Max = 2147483647,
}

enum styleCaptionSide
{
    styleCaptionSideNotSet = 0,
    styleCaptionSideTop = 1,
    styleCaptionSideBottom = 2,
    styleCaptionSideLeft = 3,
    styleCaptionSideRight = 4,
    styleCaptionSide_Max = 2147483647,
}

enum styleEmptyCells
{
    styleEmptyCellsNotSet = 0,
    styleEmptyCellsShow = 1,
    styleEmptyCellsHide = 2,
    styleEmptyCells_Max = 2147483647,
}

enum styleFontStyle
{
    styleFontStyleNotSet = 0,
    styleFontStyleItalic = 1,
    styleFontStyleOblique = 2,
    styleFontStyleNormal = 3,
    styleFontStyle_Max = 2147483647,
}

enum styleFontVariant
{
    styleFontVariantNotSet = 0,
    styleFontVariantSmallCaps = 1,
    styleFontVariantNormal = 2,
    styleFontVariant_Max = 2147483647,
}

enum styleBackgroundRepeat
{
    styleBackgroundRepeatRepeat = 0,
    styleBackgroundRepeatRepeatX = 1,
    styleBackgroundRepeatRepeatY = 2,
    styleBackgroundRepeatNoRepeat = 3,
    styleBackgroundRepeatNotSet = 4,
    styleBackgroundRepeat_Max = 2147483647,
}

enum styleBackgroundAttachment
{
    styleBackgroundAttachmentFixed = 0,
    styleBackgroundAttachmentScroll = 1,
    styleBackgroundAttachmentNotSet = 2,
    styleBackgroundAttachment_Max = 2147483647,
}

enum styleBackgroundAttachment3
{
    styleBackgroundAttachment3Fixed = 0,
    styleBackgroundAttachment3Scroll = 1,
    styleBackgroundAttachment3Local = 2,
    styleBackgroundAttachment3NotSet = 3,
    styleBackgroundAttachment3_Max = 2147483647,
}

enum styleBackgroundClip
{
    styleBackgroundClipBorderBox = 0,
    styleBackgroundClipPaddingBox = 1,
    styleBackgroundClipContentBox = 2,
    styleBackgroundClipNotSet = 3,
    styleBackgroundClip_Max = 2147483647,
}

enum styleBackgroundOrigin
{
    styleBackgroundOriginBorderBox = 0,
    styleBackgroundOriginPaddingBox = 1,
    styleBackgroundOriginContentBox = 2,
    styleBackgroundOriginNotSet = 3,
    styleBackgroundOrigin_Max = 2147483647,
}

enum styleVerticalAlign
{
    styleVerticalAlignAuto = 0,
    styleVerticalAlignBaseline = 1,
    styleVerticalAlignSub = 2,
    styleVerticalAlignSuper = 3,
    styleVerticalAlignTop = 4,
    styleVerticalAlignTextTop = 5,
    styleVerticalAlignMiddle = 6,
    styleVerticalAlignBottom = 7,
    styleVerticalAlignTextBottom = 8,
    styleVerticalAlignInherit = 9,
    styleVerticalAlignNotSet = 10,
    styleVerticalAlign_Max = 2147483647,
}

enum styleFontWeight
{
    styleFontWeightNotSet = 0,
    styleFontWeight100 = 1,
    styleFontWeight200 = 2,
    styleFontWeight300 = 3,
    styleFontWeight400 = 4,
    styleFontWeight500 = 5,
    styleFontWeight600 = 6,
    styleFontWeight700 = 7,
    styleFontWeight800 = 8,
    styleFontWeight900 = 9,
    styleFontWeightNormal = 10,
    styleFontWeightBold = 11,
    styleFontWeightBolder = 12,
    styleFontWeightLighter = 13,
    styleFontWeight_Max = 2147483647,
}

enum styleFontSize
{
    styleFontSizeXXSmall = 0,
    styleFontSizeXSmall = 1,
    styleFontSizeSmall = 2,
    styleFontSizeMedium = 3,
    styleFontSizeLarge = 4,
    styleFontSizeXLarge = 5,
    styleFontSizeXXLarge = 6,
    styleFontSizeSmaller = 7,
    styleFontSizeLarger = 8,
    styleFontSize_Max = 2147483647,
}

enum styleZIndex
{
    styleZIndexAuto = -2147483647,
    styleZIndex_Max = 2147483647,
}

enum styleWidowsOrphans
{
    styleWidowsOrphansNotSet = -2147483647,
    styleWidowsOrphans_Max = 2147483647,
}

enum styleAuto
{
    styleAutoAuto = 0,
    styleAuto_Max = 2147483647,
}

enum styleNone
{
    styleNoneNone = 0,
    styleNone_Max = 2147483647,
}

enum styleNormal
{
    styleNormalNormal = 0,
    styleNormal_Max = 2147483647,
}

enum styleBorderWidth
{
    styleBorderWidthThin = 0,
    styleBorderWidthMedium = 1,
    styleBorderWidthThick = 2,
    styleBorderWidth_Max = 2147483647,
}

enum stylePosition
{
    stylePositionNotSet = 0,
    stylePositionstatic = 1,
    stylePositionrelative = 2,
    stylePositionabsolute = 3,
    stylePositionfixed = 4,
    stylePositionMsPage = 5,
    stylePositionMsDeviceFixed = 6,
    stylePosition_Max = 2147483647,
}

enum styleBorderStyle
{
    styleBorderStyleNotSet = 0,
    styleBorderStyleDotted = 1,
    styleBorderStyleDashed = 2,
    styleBorderStyleSolid = 3,
    styleBorderStyleDouble = 4,
    styleBorderStyleGroove = 5,
    styleBorderStyleRidge = 6,
    styleBorderStyleInset = 7,
    styleBorderStyleOutset = 8,
    styleBorderStyleWindowInset = 9,
    styleBorderStyleNone = 10,
    styleBorderStyleHidden = 11,
    styleBorderStyle_Max = 2147483647,
}

enum styleOutlineStyle
{
    styleOutlineStyleNotSet = 0,
    styleOutlineStyleDotted = 1,
    styleOutlineStyleDashed = 2,
    styleOutlineStyleSolid = 3,
    styleOutlineStyleDouble = 4,
    styleOutlineStyleGroove = 5,
    styleOutlineStyleRidge = 6,
    styleOutlineStyleInset = 7,
    styleOutlineStyleOutset = 8,
    styleOutlineStyleWindowInset = 9,
    styleOutlineStyleNone = 10,
    styleOutlineStyle_Max = 2147483647,
}

enum styleStyleFloat
{
    styleStyleFloatNotSet = 0,
    styleStyleFloatLeft = 1,
    styleStyleFloatRight = 2,
    styleStyleFloatNone = 3,
    styleStyleFloat_Max = 2147483647,
}

enum styleDisplay
{
    styleDisplayNotSet = 0,
    styleDisplayBlock = 1,
    styleDisplayInline = 2,
    styleDisplayListItem = 3,
    styleDisplayNone = 4,
    styleDisplayTableHeaderGroup = 5,
    styleDisplayTableFooterGroup = 6,
    styleDisplayInlineBlock = 7,
    styleDisplayTable = 8,
    styleDisplayInlineTable = 9,
    styleDisplayTableRow = 10,
    styleDisplayTableRowGroup = 11,
    styleDisplayTableColumn = 12,
    styleDisplayTableColumnGroup = 13,
    styleDisplayTableCell = 14,
    styleDisplayTableCaption = 15,
    styleDisplayRunIn = 16,
    styleDisplayRuby = 17,
    styleDisplayRubyBase = 18,
    styleDisplayRubyText = 19,
    styleDisplayRubyBaseContainer = 20,
    styleDisplayRubyTextContainer = 21,
    styleDisplayMsFlexbox = 22,
    styleDisplayMsInlineFlexbox = 23,
    styleDisplayMsGrid = 24,
    styleDisplayMsInlineGrid = 25,
    styleDisplayFlex = 26,
    styleDisplayInlineFlex = 27,
    styleDisplayWebkitBox = 28,
    styleDisplayWebkitInlineBox = 29,
    styleDisplay_Max = 2147483647,
}

enum styleVisibility
{
    styleVisibilityNotSet = 0,
    styleVisibilityInherit = 1,
    styleVisibilityVisible = 2,
    styleVisibilityHidden = 3,
    styleVisibilityCollapse = 4,
    styleVisibility_Max = 2147483647,
}

enum styleListStyleType
{
    styleListStyleTypeNotSet = 0,
    styleListStyleTypeDisc = 1,
    styleListStyleTypeCircle = 2,
    styleListStyleTypeSquare = 3,
    styleListStyleTypeDecimal = 4,
    styleListStyleTypeLowerRoman = 5,
    styleListStyleTypeUpperRoman = 6,
    styleListStyleTypeLowerAlpha = 7,
    styleListStyleTypeUpperAlpha = 8,
    styleListStyleTypeNone = 9,
    styleListStyleTypeDecimalLeadingZero = 10,
    styleListStyleTypeGeorgian = 11,
    styleListStyleTypeArmenian = 12,
    styleListStyleTypeUpperLatin = 13,
    styleListStyleTypeLowerLatin = 14,
    styleListStyleTypeUpperGreek = 15,
    styleListStyleTypeLowerGreek = 16,
    styleListStyleType_Max = 2147483647,
}

enum styleListStylePosition
{
    styleListStylePositionNotSet = 0,
    styleListStylePositionInside = 1,
    styleListStylePositionOutSide = 2,
    styleListStylePosition_Max = 2147483647,
}

enum styleWhiteSpace
{
    styleWhiteSpaceNotSet = 0,
    styleWhiteSpaceNormal = 1,
    styleWhiteSpacePre = 2,
    styleWhiteSpaceNowrap = 3,
    styleWhiteSpacePreline = 4,
    styleWhiteSpacePrewrap = 5,
    styleWhiteSpace_Max = 2147483647,
}

enum stylePageBreak
{
    stylePageBreakNotSet = 0,
    stylePageBreakAuto = 1,
    stylePageBreakAlways = 2,
    stylePageBreakLeft = 3,
    stylePageBreakRight = 4,
    stylePageBreakAvoid = 5,
    stylePageBreak_Max = 2147483647,
}

enum stylePageBreakInside
{
    stylePageBreakInsideNotSet = 0,
    stylePageBreakInsideAuto = 1,
    stylePageBreakInsideAvoid = 2,
    stylePageBreakInside_Max = 2147483647,
}

enum styleCursor
{
    styleCursorAuto = 0,
    styleCursorCrosshair = 1,
    styleCursorDefault = 2,
    styleCursorHand = 3,
    styleCursorMove = 4,
    styleCursorE_resize = 5,
    styleCursorNe_resize = 6,
    styleCursorNw_resize = 7,
    styleCursorN_resize = 8,
    styleCursorSe_resize = 9,
    styleCursorSw_resize = 10,
    styleCursorS_resize = 11,
    styleCursorW_resize = 12,
    styleCursorText = 13,
    styleCursorWait = 14,
    styleCursorHelp = 15,
    styleCursorPointer = 16,
    styleCursorProgress = 17,
    styleCursorNot_allowed = 18,
    styleCursorNo_drop = 19,
    styleCursorVertical_text = 20,
    styleCursorall_scroll = 21,
    styleCursorcol_resize = 22,
    styleCursorrow_resize = 23,
    styleCursorNone = 24,
    styleCursorContext_menu = 25,
    styleCursorEw_resize = 26,
    styleCursorNs_resize = 27,
    styleCursorNesw_resize = 28,
    styleCursorNwse_resize = 29,
    styleCursorCell = 30,
    styleCursorCopy = 31,
    styleCursorAlias = 32,
    styleCursorcustom = 33,
    styleCursorNotSet = 34,
    styleCursor_Max = 2147483647,
}

enum styleDir
{
    styleDirNotSet = 0,
    styleDirLeftToRight = 1,
    styleDirRightToLeft = 2,
    styleDirInherit = 3,
    styleDir_Max = 2147483647,
}

enum styleBidi
{
    styleBidiNotSet = 0,
    styleBidiNormal = 1,
    styleBidiEmbed = 2,
    styleBidiOverride = 3,
    styleBidiInherit = 4,
    styleBidi_Max = 2147483647,
}

enum styleImeMode
{
    styleImeModeAuto = 0,
    styleImeModeActive = 1,
    styleImeModeInactive = 2,
    styleImeModeDisabled = 3,
    styleImeModeNotSet = 4,
    styleImeMode_Max = 2147483647,
}

enum styleRubyAlign
{
    styleRubyAlignNotSet = 0,
    styleRubyAlignAuto = 1,
    styleRubyAlignLeft = 2,
    styleRubyAlignCenter = 3,
    styleRubyAlignRight = 4,
    styleRubyAlignDistributeLetter = 5,
    styleRubyAlignDistributeSpace = 6,
    styleRubyAlignLineEdge = 7,
    styleRubyAlign_Max = 2147483647,
}

enum styleRubyPosition
{
    styleRubyPositionNotSet = 0,
    styleRubyPositionAbove = 1,
    styleRubyPositionInline = 2,
    styleRubyPosition_Max = 2147483647,
}

enum styleRubyOverhang
{
    styleRubyOverhangNotSet = 0,
    styleRubyOverhangAuto = 1,
    styleRubyOverhangWhitespace = 2,
    styleRubyOverhangNone = 3,
    styleRubyOverhang_Max = 2147483647,
}

enum styleLayoutGridChar
{
    styleLayoutGridCharNotSet = 0,
    styleLayoutGridCharAuto = 1,
    styleLayoutGridCharNone = 2,
    styleLayoutGridChar_Max = 2147483647,
}

enum styleLayoutGridLine
{
    styleLayoutGridLineNotSet = 0,
    styleLayoutGridLineAuto = 1,
    styleLayoutGridLineNone = 2,
    styleLayoutGridLine_Max = 2147483647,
}

enum styleLayoutGridMode
{
    styleLayoutGridModeNotSet = 0,
    styleLayoutGridModeChar = 1,
    styleLayoutGridModeLine = 2,
    styleLayoutGridModeBoth = 3,
    styleLayoutGridModeNone = 4,
    styleLayoutGridMode_Max = 2147483647,
}

enum styleLayoutGridType
{
    styleLayoutGridTypeNotSet = 0,
    styleLayoutGridTypeLoose = 1,
    styleLayoutGridTypeStrict = 2,
    styleLayoutGridTypeFixed = 3,
    styleLayoutGridType_Max = 2147483647,
}

enum styleLineBreak
{
    styleLineBreakNotSet = 0,
    styleLineBreakNormal = 1,
    styleLineBreakStrict = 2,
    styleLineBreak_Max = 2147483647,
}

enum styleWordBreak
{
    styleWordBreakNotSet = 0,
    styleWordBreakNormal = 1,
    styleWordBreakBreakAll = 2,
    styleWordBreakKeepAll = 3,
    styleWordBreak_Max = 2147483647,
}

enum styleWordWrap
{
    styleWordWrapNotSet = 0,
    styleWordWrapOff = 1,
    styleWordWrapOn = 2,
    styleWordWrap_Max = 2147483647,
}

enum styleTextJustify
{
    styleTextJustifyNotSet = 0,
    styleTextJustifyInterWord = 1,
    styleTextJustifyNewspaper = 2,
    styleTextJustifyDistribute = 3,
    styleTextJustifyDistributeAllLines = 4,
    styleTextJustifyInterIdeograph = 5,
    styleTextJustifyInterCluster = 6,
    styleTextJustifyKashida = 7,
    styleTextJustifyAuto = 8,
    styleTextJustify_Max = 2147483647,
}

enum styleTextAlignLast
{
    styleTextAlignLastNotSet = 0,
    styleTextAlignLastLeft = 1,
    styleTextAlignLastCenter = 2,
    styleTextAlignLastRight = 3,
    styleTextAlignLastJustify = 4,
    styleTextAlignLastAuto = 5,
    styleTextAlignLast_Max = 2147483647,
}

enum styleTextJustifyTrim
{
    styleTextJustifyTrimNotSet = 0,
    styleTextJustifyTrimNone = 1,
    styleTextJustifyTrimPunctuation = 2,
    styleTextJustifyTrimPunctAndKana = 3,
    styleTextJustifyTrim_Max = 2147483647,
}

enum styleAccelerator
{
    styleAcceleratorFalse = 0,
    styleAcceleratorTrue = 1,
    styleAccelerator_Max = 2147483647,
}

enum styleLayoutFlow
{
    styleLayoutFlowHorizontal = 0,
    styleLayoutFlowVerticalIdeographic = 1,
    styleLayoutFlowNotSet = 2,
    styleLayoutFlow_Max = 2147483647,
}

enum styleBlockProgression
{
    styleBlockProgressionTb = 0,
    styleBlockProgressionRl = 1,
    styleBlockProgressionBt = 2,
    styleBlockProgressionLr = 3,
    styleBlockProgressionNotSet = 4,
    styleBlockProgression_Max = 2147483647,
}

enum styleWritingMode
{
    styleWritingModeLrtb = 0,
    styleWritingModeTbrl = 1,
    styleWritingModeRltb = 2,
    styleWritingModeBtrl = 3,
    styleWritingModeNotSet = 4,
    styleWritingModeTblr = 5,
    styleWritingModeBtlr = 6,
    styleWritingModeLrbt = 7,
    styleWritingModeRlbt = 8,
    styleWritingModeLr = 9,
    styleWritingModeRl = 10,
    styleWritingModeTb = 11,
    styleWritingMode_Max = 2147483647,
}

enum styleBool
{
    styleBoolFalse = 0,
    styleBoolTrue = 1,
    styleBool_Max = 2147483647,
}

enum styleTextUnderlinePosition
{
    styleTextUnderlinePositionBelow = 0,
    styleTextUnderlinePositionAbove = 1,
    styleTextUnderlinePositionAuto = 2,
    styleTextUnderlinePositionNotSet = 3,
    styleTextUnderlinePosition_Max = 2147483647,
}

enum styleTextOverflow
{
    styleTextOverflowClip = 0,
    styleTextOverflowEllipsis = 1,
    styleTextOverflowNotSet = 2,
    styleTextOverflow_Max = 2147483647,
}

enum styleInterpolation
{
    styleInterpolationNotSet = 0,
    styleInterpolationNN = 1,
    styleInterpolationBCH = 2,
    styleInterpolation_Max = 2147483647,
}

enum styleBoxSizing
{
    styleBoxSizingNotSet = 0,
    styleBoxSizingContentBox = 1,
    styleBoxSizingBorderBox = 2,
    styleBoxSizing_Max = 2147483647,
}

enum styleFlex
{
    styleFlexNone = 0,
    styleFlexNotSet = 1,
    styleFlex_Max = 2147483647,
}

enum styleFlexBasis
{
    styleFlexBasisAuto = 0,
    styleFlexBasisNotSet = 1,
    styleFlexBasis_Max = 2147483647,
}

enum styleFlexDirection
{
    styleFlexDirectionRow = 0,
    styleFlexDirectionRowReverse = 1,
    styleFlexDirectionColumn = 2,
    styleFlexDirectionColumnReverse = 3,
    styleFlexDirectionNotSet = 4,
    styleFlexDirection_Max = 2147483647,
}

enum styleWebkitBoxOrient
{
    styleWebkitBoxOrientHorizontal = 0,
    styleWebkitBoxOrientInlineAxis = 1,
    styleWebkitBoxOrientVertical = 2,
    styleWebkitBoxOrientBlockAxis = 3,
    styleWebkitBoxOrientNotSet = 4,
    styleWebkitBoxOrient_Max = 2147483647,
}

enum styleWebkitBoxDirection
{
    styleWebkitBoxDirectionNormal = 0,
    styleWebkitBoxDirectionReverse = 1,
    styleWebkitBoxDirectionNotSet = 2,
    styleWebkitBoxDirection_Max = 2147483647,
}

enum styleFlexWrap
{
    styleFlexWrapNowrap = 0,
    styleFlexWrapWrap = 1,
    styleFlexWrapWrapReverse = 2,
    styleFlexWrapNotSet = 3,
    styleFlexWrap_Max = 2147483647,
}

enum styleAlignItems
{
    styleAlignItemsFlexStart = 0,
    styleAlignItemsFlexEnd = 1,
    styleAlignItemsCenter = 2,
    styleAlignItemsBaseline = 3,
    styleAlignItemsStretch = 4,
    styleAlignItemsNotSet = 5,
    styleAlignItems_Max = 2147483647,
}

enum styleMsFlexAlign
{
    styleMsFlexAlignStart = 0,
    styleMsFlexAlignEnd = 1,
    styleMsFlexAlignCenter = 2,
    styleMsFlexAlignBaseline = 3,
    styleMsFlexAlignStretch = 4,
    styleMsFlexAlignNotSet = 5,
    styleMsFlexAlign_Max = 2147483647,
}

enum styleMsFlexItemAlign
{
    styleMsFlexItemAlignStart = 0,
    styleMsFlexItemAlignEnd = 1,
    styleMsFlexItemAlignCenter = 2,
    styleMsFlexItemAlignBaseline = 3,
    styleMsFlexItemAlignStretch = 4,
    styleMsFlexItemAlignAuto = 5,
    styleMsFlexItemAlignNotSet = 6,
    styleMsFlexItemAlign_Max = 2147483647,
}

enum styleAlignSelf
{
    styleAlignSelfFlexStart = 0,
    styleAlignSelfFlexEnd = 1,
    styleAlignSelfCenter = 2,
    styleAlignSelfBaseline = 3,
    styleAlignSelfStretch = 4,
    styleAlignSelfAuto = 5,
    styleAlignSelfNotSet = 6,
    styleAlignSelf_Max = 2147483647,
}

enum styleJustifyContent
{
    styleJustifyContentFlexStart = 0,
    styleJustifyContentFlexEnd = 1,
    styleJustifyContentCenter = 2,
    styleJustifyContentSpaceBetween = 3,
    styleJustifyContentSpaceAround = 4,
    styleJustifyContentNotSet = 5,
    styleJustifyContent_Max = 2147483647,
}

enum styleMsFlexPack
{
    styleMsFlexPackStart = 0,
    styleMsFlexPackEnd = 1,
    styleMsFlexPackCenter = 2,
    styleMsFlexPackJustify = 3,
    styleMsFlexPackDistribute = 4,
    styleMsFlexPackNotSet = 5,
    styleMsFlexPack_Max = 2147483647,
}

enum styleWebkitBoxPack
{
    styleWebkitBoxPackStart = 0,
    styleWebkitBoxPackEnd = 1,
    styleWebkitBoxPackCenter = 2,
    styleWebkitBoxPackJustify = 3,
    styleWebkitBoxPackNotSet = 5,
    styleWebkitBoxPack_Max = 2147483647,
}

enum styleMsFlexLinePack
{
    styleMsFlexLinePackStart = 0,
    styleMsFlexLinePackEnd = 1,
    styleMsFlexLinePackCenter = 2,
    styleMsFlexLinePackJustify = 3,
    styleMsFlexLinePackDistribute = 4,
    styleMsFlexLinePackStretch = 5,
    styleMsFlexLinePackNotSet = 6,
    styleMsFlexLinePack_Max = 2147483647,
}

enum styleAlignContent
{
    styleAlignContentFlexStart = 0,
    styleAlignContentFlexEnd = 1,
    styleAlignContentCenter = 2,
    styleAlignContentSpaceBetween = 3,
    styleAlignContentSpaceAround = 4,
    styleAlignContentStretch = 5,
    styleAlignContentNotSet = 6,
    styleAlignContent_Max = 2147483647,
}

enum styleColumnFill
{
    styleColumnFillAuto = 0,
    styleColumnFillBalance = 1,
    styleColumnFillNotSet = 2,
    styleColumnFill_Max = 2147483647,
}

enum styleColumnSpan
{
    styleColumnSpanNone = 0,
    styleColumnSpanAll = 1,
    styleColumnSpanOne = 2,
    styleColumnSpanNotSet = 3,
    styleColumnSpan_Max = 2147483647,
}

enum styleBreak
{
    styleBreakNotSet = 0,
    styleBreakAuto = 1,
    styleBreakAlways = 2,
    styleBreakAvoid = 3,
    styleBreakLeft = 4,
    styleBreakRight = 5,
    styleBreakPage = 6,
    styleBreakColumn = 7,
    styleBreakAvoidPage = 8,
    styleBreakAvoidColumn = 9,
    styleBreak_Max = 2147483647,
}

enum styleBreakInside
{
    styleBreakInsideNotSet = 0,
    styleBreakInsideAuto = 1,
    styleBreakInsideAvoid = 2,
    styleBreakInsideAvoidPage = 3,
    styleBreakInsideAvoidColumn = 4,
    styleBreakInside_Max = 2147483647,
}

enum styleMsScrollChaining
{
    styleMsScrollChainingNotSet = 0,
    styleMsScrollChainingNone = 1,
    styleMsScrollChainingChained = 2,
    styleMsScrollChaining_Max = 2147483647,
}

enum styleMsContentZooming
{
    styleMsContentZoomingNotSet = 0,
    styleMsContentZoomingNone = 1,
    styleMsContentZoomingZoom = 2,
    styleMsContentZooming_Max = 2147483647,
}

enum styleMsContentZoomSnapType
{
    styleMsContentZoomSnapTypeNotSet = 0,
    styleMsContentZoomSnapTypeNone = 1,
    styleMsContentZoomSnapTypeMandatory = 2,
    styleMsContentZoomSnapTypeProximity = 3,
    styleMsContentZoomSnapType_Max = 2147483647,
}

enum styleMsScrollRails
{
    styleMsScrollRailsNotSet = 0,
    styleMsScrollRailsNone = 1,
    styleMsScrollRailsRailed = 2,
    styleMsScrollRails_Max = 2147483647,
}

enum styleMsContentZoomChaining
{
    styleMsContentZoomChainingNotSet = 0,
    styleMsContentZoomChainingNone = 1,
    styleMsContentZoomChainingChained = 2,
    styleMsContentZoomChaining_Max = 2147483647,
}

enum styleMsScrollSnapType
{
    styleMsScrollSnapTypeNotSet = 0,
    styleMsScrollSnapTypeNone = 1,
    styleMsScrollSnapTypeMandatory = 2,
    styleMsScrollSnapTypeProximity = 3,
    styleMsScrollSnapType_Max = 2147483647,
}

enum styleGridColumn
{
    styleGridColumnNotSet = 0,
    styleGridColumn_Max = 2147483647,
}

enum styleGridColumnAlign
{
    styleGridColumnAlignCenter = 0,
    styleGridColumnAlignEnd = 1,
    styleGridColumnAlignStart = 2,
    styleGridColumnAlignStretch = 3,
    styleGridColumnAlignNotSet = 4,
    styleGridColumnAlign_Max = 2147483647,
}

enum styleGridColumnSpan
{
    styleGridColumnSpanNotSet = 0,
    styleGridColumnSpan_Max = 2147483647,
}

enum styleGridRow
{
    styleGridRowNotSet = 0,
    styleGridRow_Max = 2147483647,
}

enum styleGridRowAlign
{
    styleGridRowAlignCenter = 0,
    styleGridRowAlignEnd = 1,
    styleGridRowAlignStart = 2,
    styleGridRowAlignStretch = 3,
    styleGridRowAlignNotSet = 4,
    styleGridRowAlign_Max = 2147483647,
}

enum styleGridRowSpan
{
    styleGridRowSpanNotSet = 0,
    styleGridRowSpan_Max = 2147483647,
}

enum styleWrapThrough
{
    styleWrapThroughNotSet = 0,
    styleWrapThroughWrap = 1,
    styleWrapThroughNone = 2,
    styleWrapThrough_Max = 2147483647,
}

enum styleWrapFlow
{
    styleWrapFlowNotSet = 0,
    styleWrapFlowAuto = 1,
    styleWrapFlowBoth = 2,
    styleWrapFlowStart = 3,
    styleWrapFlowEnd = 4,
    styleWrapFlowClear = 5,
    styleWrapFlowMinimum = 6,
    styleWrapFlowMaximum = 7,
    styleWrapFlow_Max = 2147483647,
}

enum styleAlignmentBaseline
{
    styleAlignmentBaselineNotSet = 0,
    styleAlignmentBaselineAfterEdge = 1,
    styleAlignmentBaselineAlphabetic = 2,
    styleAlignmentBaselineAuto = 3,
    styleAlignmentBaselineBaseline = 4,
    styleAlignmentBaselineBeforeEdge = 5,
    styleAlignmentBaselineCentral = 6,
    styleAlignmentBaselineHanging = 7,
    styleAlignmentBaselineMathematical = 8,
    styleAlignmentBaselineMiddle = 9,
    styleAlignmentBaselineTextAfterEdge = 10,
    styleAlignmentBaselineTextBeforeEdge = 11,
    styleAlignmentBaselineIdeographic = 12,
    styleAlignmentBaseline_Max = 2147483647,
}

enum styleBaselineShift
{
    styleBaselineShiftBaseline = 0,
    styleBaselineShiftSub = 1,
    styleBaselineShiftSuper = 2,
    styleBaselineShift_Max = 2147483647,
}

enum styleClipRule
{
    styleClipRuleNotSet = 0,
    styleClipRuleNonZero = 1,
    styleClipRuleEvenOdd = 2,
    styleClipRule_Max = 2147483647,
}

enum styleDominantBaseline
{
    styleDominantBaselineNotSet = 0,
    styleDominantBaselineAlphabetic = 1,
    styleDominantBaselineAuto = 2,
    styleDominantBaselineCentral = 3,
    styleDominantBaselineHanging = 4,
    styleDominantBaselineIdeographic = 5,
    styleDominantBaselineMathematical = 6,
    styleDominantBaselineMiddle = 7,
    styleDominantBaselineNoChange = 8,
    styleDominantBaselineResetSize = 9,
    styleDominantBaselineTextAfterEdge = 10,
    styleDominantBaselineTextBeforeEdge = 11,
    styleDominantBaselineUseScript = 12,
    styleDominantBaseline_Max = 2147483647,
}

enum styleFillRule
{
    styleFillRuleNotSet = 0,
    styleFillRuleNonZero = 1,
    styleFillRuleEvenOdd = 2,
    styleFillRule_Max = 2147483647,
}

enum styleFontStretch
{
    styleFontStretchNotSet = 0,
    styleFontStretchWider = 1,
    styleFontStretchNarrower = 2,
    styleFontStretchUltraCondensed = 3,
    styleFontStretchExtraCondensed = 4,
    styleFontStretchCondensed = 5,
    styleFontStretchSemiCondensed = 6,
    styleFontStretchNormal = 7,
    styleFontStretchSemiExpanded = 8,
    styleFontStretchExpanded = 9,
    styleFontStretchExtraExpanded = 10,
    styleFontStretchUltraExpanded = 11,
    styleFontStretch_Max = 2147483647,
}

enum stylePointerEvents
{
    stylePointerEventsNotSet = 0,
    stylePointerEventsVisiblePainted = 1,
    stylePointerEventsVisibleFill = 2,
    stylePointerEventsVisibleStroke = 3,
    stylePointerEventsVisible = 4,
    stylePointerEventsPainted = 5,
    stylePointerEventsFill = 6,
    stylePointerEventsStroke = 7,
    stylePointerEventsAll = 8,
    stylePointerEventsNone = 9,
    stylePointerEventsInitial = 10,
    stylePointerEventsAuto = 11,
    stylePointerEvents_Max = 2147483647,
}

enum styleEnableBackground
{
    styleEnableBackgroundNotSet = 0,
    styleEnableBackgroundAccumulate = 1,
    styleEnableBackgroundNew = 2,
    styleEnableBackgroundInherit = 3,
    styleEnableBackground_Max = 2147483647,
}

enum styleStrokeLinecap
{
    styleStrokeLinecapNotSet = 0,
    styleStrokeLinecapButt = 1,
    styleStrokeLinecapRound = 2,
    styleStrokeLinecapSquare = 3,
    styleStrokeLinecap_Max = 2147483647,
}

enum styleStrokeLinejoin
{
    styleStrokeLinejoinNotSet = 0,
    styleStrokeLinejoinMiter = 1,
    styleStrokeLinejoinRound = 2,
    styleStrokeLinejoinBevel = 3,
    styleStrokeLinejoin_Max = 2147483647,
}

enum styleTextAnchor
{
    styleTextAnchorNotSet = 0,
    styleTextAnchorStart = 1,
    styleTextAnchorMiddle = 2,
    styleTextAnchorEnd = 3,
    styleTextAnchor_Max = 2147483647,
}

enum styleAttrType
{
    styleAttrTypeString = 0,
    styleAttrTypeColor = 1,
    styleAttrTypeUrl = 2,
    styleAttrTypeInteger = 3,
    styleAttrTypeNumber = 4,
    styleAttrTypeLength = 5,
    styleAttrTypePx = 6,
    styleAttrTypeEm = 7,
    styleAttrTypeEx = 8,
    styleAttrTypeIn = 9,
    styleAttrTypeCm = 10,
    styleAttrTypeMm = 11,
    styleAttrTypePt = 12,
    styleAttrTypePc = 13,
    styleAttrTypeRem = 14,
    styleAttrTypeCh = 15,
    styleAttrTypeVh = 16,
    styleAttrTypeVw = 17,
    styleAttrTypeVmin = 18,
    styleAttrTypePercentage = 19,
    styleAttrTypeAngle = 20,
    styleAttrTypeDeg = 21,
    styleAttrTypeRad = 22,
    styleAttrTypeGrad = 23,
    styleAttrTypeTime = 24,
    styleAttrTypeS = 25,
    styleAttrTypeMs = 26,
    styleAttrType_Max = 2147483647,
}

enum styleInitialColor
{
    styleInitialColorNoInitial = 0,
    styleInitialColorColorProperty = 1,
    styleInitialColorTransparent = 2,
    styleInitialColorInvert = 3,
    styleInitialColor_Max = 2147483647,
}

enum styleInitialString
{
    styleInitialStringNoInitial = 0,
    styleInitialStringNone = 1,
    styleInitialStringAuto = 2,
    styleInitialStringNormal = 3,
    styleInitialString_Max = 2147483647,
}

enum styleTransformOriginX
{
    styleTransformOriginXNotSet = 0,
    styleTransformOriginXLeft = 1,
    styleTransformOriginXCenter = 2,
    styleTransformOriginXRight = 3,
    styleTransformOriginX_Max = 2147483647,
}

enum styleTransformOriginY
{
    styleTransformOriginYNotSet = 0,
    styleTransformOriginYTop = 1,
    styleTransformOriginYCenter = 2,
    styleTransformOriginYBottom = 3,
    styleTransformOriginY_Max = 2147483647,
}

enum stylePerspectiveOriginX
{
    stylePerspectiveOriginXNotSet = 0,
    stylePerspectiveOriginXLeft = 1,
    stylePerspectiveOriginXCenter = 2,
    stylePerspectiveOriginXRight = 3,
    stylePerspectiveOriginX_Max = 2147483647,
}

enum stylePerspectiveOriginY
{
    stylePerspectiveOriginYNotSet = 0,
    stylePerspectiveOriginYTop = 1,
    stylePerspectiveOriginYCenter = 2,
    stylePerspectiveOriginYBottom = 3,
    stylePerspectiveOriginY_Max = 2147483647,
}

enum styleTransformStyle
{
    styleTransformStyleFlat = 0,
    styleTransformStylePreserve3D = 1,
    styleTransformStyleNotSet = 2,
    styleTransformStyle_Max = 2147483647,
}

enum styleBackfaceVisibility
{
    styleBackfaceVisibilityVisible = 0,
    styleBackfaceVisibilityHidden = 1,
    styleBackfaceVisibilityNotSet = 2,
    styleBackfaceVisibility_Max = 2147483647,
}

enum styleTextSizeAdjust
{
    styleTextSizeAdjustNone = 0,
    styleTextSizeAdjustAuto = 1,
    styleTextSizeAdjust_Max = 2147483647,
}

enum styleColorInterpolationFilters
{
    styleColorInterpolationFiltersAuto = 0,
    styleColorInterpolationFiltersSRgb = 1,
    styleColorInterpolationFiltersLinearRgb = 2,
    styleColorInterpolationFiltersNotSet = 3,
    styleColorInterpolationFilters_Max = 2147483647,
}

enum styleHyphens
{
    styleHyphensNone = 0,
    styleHyphensManual = 1,
    styleHyphensAuto = 2,
    styleHyphensNotSet = 3,
    styleHyphens_Max = 2147483647,
}

enum styleHyphenateLimitLines
{
    styleHyphenateLimitLinesNoLimit = 0,
    styleHyphenateLimitLines_Max = 2147483647,
}

enum styleMsAnimationPlayState
{
    styleMsAnimationPlayStateRunning = 0,
    styleMsAnimationPlayStatePaused = 1,
    styleMsAnimationPlayStateNotSet = 2,
    styleMsAnimationPlayState_Max = 2147483647,
}

enum styleMsAnimationDirection
{
    styleMsAnimationDirectionNormal = 0,
    styleMsAnimationDirectionAlternate = 1,
    styleMsAnimationDirectionReverse = 2,
    styleMsAnimationDirectionAlternateReverse = 3,
    styleMsAnimationDirectionNotSet = 4,
    styleMsAnimationDirection_Max = 2147483647,
}

enum styleMsAnimationFillMode
{
    styleMsAnimationFillModeNone = 0,
    styleMsAnimationFillModeForwards = 1,
    styleMsAnimationFillModeBackwards = 2,
    styleMsAnimationFillModeBoth = 3,
    styleMsAnimationFillModeNotSet = 4,
    styleMsAnimationFillMode_Max = 2147483647,
}

enum styleMsHighContrastAdjust
{
    styleMsHighContrastAdjustNotSet = 0,
    styleMsHighContrastAdjustAuto = 1,
    styleMsHighContrastAdjustNone = 2,
    styleMsHighContrastAdjust_Max = 2147483647,
}

enum styleMsUserSelect
{
    styleMsUserSelectAuto = 0,
    styleMsUserSelectText = 1,
    styleMsUserSelectElement = 2,
    styleMsUserSelectNone = 3,
    styleMsUserSelectNotSet = 4,
    styleMsUserSelect_Max = 2147483647,
}

enum styleMsTouchAction
{
    styleMsTouchActionNotSet = -1,
    styleMsTouchActionNone = 0,
    styleMsTouchActionAuto = 1,
    styleMsTouchActionManipulation = 2,
    styleMsTouchActionDoubleTapZoom = 4,
    styleMsTouchActionPanX = 8,
    styleMsTouchActionPanY = 16,
    styleMsTouchActionPinchZoom = 32,
    styleMsTouchActionCrossSlideX = 64,
    styleMsTouchActionCrossSlideY = 128,
    styleMsTouchAction_Max = 2147483647,
}

enum styleMsTouchSelect
{
    styleMsTouchSelectGrippers = 0,
    styleMsTouchSelectNone = 1,
    styleMsTouchSelectNotSet = 2,
    styleMsTouchSelect_Max = 2147483647,
}

enum styleMsScrollTranslation
{
    styleMsScrollTranslationNotSet = 0,
    styleMsScrollTranslationNone = 1,
    styleMsScrollTranslationVtoH = 2,
    styleMsScrollTranslation_Max = 2147483647,
}

enum styleBorderImageRepeat
{
    styleBorderImageRepeatStretch = 0,
    styleBorderImageRepeatRepeat = 1,
    styleBorderImageRepeatRound = 2,
    styleBorderImageRepeatSpace = 3,
    styleBorderImageRepeatNotSet = 4,
    styleBorderImageRepeat_Max = 2147483647,
}

enum styleBorderImageSliceFill
{
    styleBorderImageSliceFillNotSet = 0,
    styleBorderImageSliceFillFill = 1,
    styleBorderImageSliceFill_Max = 2147483647,
}

enum styleMsImeAlign
{
    styleMsImeAlignAuto = 0,
    styleMsImeAlignAfter = 1,
    styleMsImeAlignNotSet = 2,
    styleMsImeAlign_Max = 2147483647,
}

enum styleMsTextCombineHorizontal
{
    styleMsTextCombineHorizontalNone = 0,
    styleMsTextCombineHorizontalAll = 1,
    styleMsTextCombineHorizontalDigits = 2,
    styleMsTextCombineHorizontalNotSet = 3,
    styleMsTextCombineHorizontal_Max = 2147483647,
}

enum styleWebkitAppearance
{
    styleWebkitAppearanceNone = 0,
    styleWebkitAppearanceCapsLockIndicator = 1,
    styleWebkitAppearanceButton = 2,
    styleWebkitAppearanceButtonBevel = 3,
    styleWebkitAppearanceCaret = 4,
    styleWebkitAppearanceCheckbox = 5,
    styleWebkitAppearanceDefaultButton = 6,
    styleWebkitAppearanceListbox = 7,
    styleWebkitAppearanceListitem = 8,
    styleWebkitAppearanceMediaFullscreenButton = 9,
    styleWebkitAppearanceMediaMuteButton = 10,
    styleWebkitAppearanceMediaPlayButton = 11,
    styleWebkitAppearanceMediaSeekBackButton = 12,
    styleWebkitAppearanceMediaSeekForwardButton = 13,
    styleWebkitAppearanceMediaSlider = 14,
    styleWebkitAppearanceMediaSliderthumb = 15,
    styleWebkitAppearanceMenulist = 16,
    styleWebkitAppearanceMenulistButton = 17,
    styleWebkitAppearanceMenulistText = 18,
    styleWebkitAppearanceMenulistTextfield = 19,
    styleWebkitAppearancePushButton = 20,
    styleWebkitAppearanceRadio = 21,
    styleWebkitAppearanceSearchfield = 22,
    styleWebkitAppearanceSearchfieldCancelButton = 23,
    styleWebkitAppearanceSearchfieldDecoration = 24,
    styleWebkitAppearanceSearchfieldResultsButton = 25,
    styleWebkitAppearanceSearchfieldResultsDecoration = 26,
    styleWebkitAppearanceSliderHorizontal = 27,
    styleWebkitAppearanceSliderVertical = 28,
    styleWebkitAppearanceSliderthumbHorizontal = 29,
    styleWebkitAppearanceSliderthumbVertical = 30,
    styleWebkitAppearanceSquareButton = 31,
    styleWebkitAppearanceTextarea = 32,
    styleWebkitAppearanceTextfield = 33,
    styleWebkitAppearanceNotSet = 34,
    styleWebkitAppearance_Max = 2147483647,
}

enum styleViewportSize
{
    styleViewportSizeAuto = 0,
    styleViewportSizeDeviceWidth = 1,
    styleViewportSizeDeviceHeight = 2,
    styleViewportSize_Max = 2147483647,
}

enum styleUserZoom
{
    styleUserZoomNotSet = 0,
    styleUserZoomZoom = 1,
    styleUserZoomFixed = 2,
    styleUserZoom_Max = 2147483647,
}

enum styleTextLineThroughStyle
{
    styleTextLineThroughStyleUndefined = 0,
    styleTextLineThroughStyleSingle = 1,
    styleTextLineThroughStyleDouble = 2,
    styleTextLineThroughStyle_Max = 2147483647,
}

enum styleTextUnderlineStyle
{
    styleTextUnderlineStyleUndefined = 0,
    styleTextUnderlineStyleSingle = 1,
    styleTextUnderlineStyleDouble = 2,
    styleTextUnderlineStyleWords = 3,
    styleTextUnderlineStyleDotted = 4,
    styleTextUnderlineStyleThick = 5,
    styleTextUnderlineStyleDash = 6,
    styleTextUnderlineStyleDotDash = 7,
    styleTextUnderlineStyleDotDotDash = 8,
    styleTextUnderlineStyleWave = 9,
    styleTextUnderlineStyleSingleAccounting = 10,
    styleTextUnderlineStyleDoubleAccounting = 11,
    styleTextUnderlineStyleThickDash = 12,
    styleTextUnderlineStyle_Max = 2147483647,
}

enum styleTextEffect
{
    styleTextEffectNone = 0,
    styleTextEffectEmboss = 1,
    styleTextEffectEngrave = 2,
    styleTextEffectOutline = 3,
    styleTextEffect_Max = 2147483647,
}

enum styleDefaultTextSelection
{
    styleDefaultTextSelectionFalse = 0,
    styleDefaultTextSelectionTrue = 1,
    styleDefaultTextSelection_Max = 2147483647,
}

enum styleTextDecoration
{
    styleTextDecorationNone = 0,
    styleTextDecorationUnderline = 1,
    styleTextDecorationOverline = 2,
    styleTextDecorationLineThrough = 3,
    styleTextDecorationBlink = 4,
    styleTextDecoration_Max = 2147483647,
}

enum textDecoration
{
    textDecorationNone = 0,
    textDecorationUnderline = 1,
    textDecorationOverline = 2,
    textDecorationLineThrough = 3,
    textDecorationBlink = 4,
    textDecoration_Max = 2147483647,
}

enum htmlListType
{
    htmlListTypeNotSet = 0,
    htmlListTypeLargeAlpha = 1,
    htmlListTypeSmallAlpha = 2,
    htmlListTypeLargeRoman = 3,
    htmlListTypeSmallRoman = 4,
    htmlListTypeNumbers = 5,
    htmlListTypeDisc = 6,
    htmlListTypeCircle = 7,
    htmlListTypeSquare = 8,
    htmlListType_Max = 2147483647,
}

enum htmlMethod
{
    htmlMethodNotSet = 0,
    htmlMethodGet = 1,
    htmlMethodPost = 2,
    htmlMethod_Max = 2147483647,
}

enum htmlWrap
{
    htmlWrapOff = 1,
    htmlWrapSoft = 2,
    htmlWrapHard = 3,
    htmlWrap_Max = 2147483647,
}

enum htmlDir
{
    htmlDirNotSet = 0,
    htmlDirLeftToRight = 1,
    htmlDirRightToLeft = 2,
    htmlDir_Max = 2147483647,
}

enum htmlEditable
{
    htmlEditableInherit = 0,
    htmlEditableTrue = 1,
    htmlEditableFalse = 2,
    htmlEditable_Max = 2147483647,
}

enum htmlInput
{
    htmlInputNotSet = 0,
    htmlInputButton = 1,
    htmlInputCheckbox = 2,
    htmlInputFile = 3,
    htmlInputHidden = 4,
    htmlInputImage = 5,
    htmlInputPassword = 6,
    htmlInputRadio = 7,
    htmlInputReset = 8,
    htmlInputSelectOne = 9,
    htmlInputSelectMultiple = 10,
    htmlInputSubmit = 11,
    htmlInputText = 12,
    htmlInputTextarea = 13,
    htmlInputRichtext = 14,
    htmlInputRange = 15,
    htmlInputUrl = 16,
    htmlInputEmail = 17,
    htmlInputNumber = 18,
    htmlInputTel = 19,
    htmlInputSearch = 20,
    htmlInput_Max = 2147483647,
}

enum htmlSpellCheck
{
    htmlSpellCheckNotSet = 0,
    htmlSpellCheckTrue = 1,
    htmlSpellCheckFalse = 2,
    htmlSpellCheckDefault = 3,
    htmlSpellCheck_Max = 2147483647,
}

enum htmlEncoding
{
    htmlEncodingURL = 0,
    htmlEncodingMultipart = 1,
    htmlEncodingText = 2,
    htmlEncoding_Max = 2147483647,
}

enum htmlAdjacency
{
    htmlAdjacencyBeforeBegin = 1,
    htmlAdjacencyAfterBegin = 2,
    htmlAdjacencyBeforeEnd = 3,
    htmlAdjacencyAfterEnd = 4,
    htmlAdjacency_Max = 2147483647,
}

enum htmlTabIndex
{
    htmlTabIndexNotSet = -32768,
    htmlTabIndex_Max = 2147483647,
}

enum htmlComponent
{
    htmlComponentClient = 0,
    htmlComponentSbLeft = 1,
    htmlComponentSbPageLeft = 2,
    htmlComponentSbHThumb = 3,
    htmlComponentSbPageRight = 4,
    htmlComponentSbRight = 5,
    htmlComponentSbUp = 6,
    htmlComponentSbPageUp = 7,
    htmlComponentSbVThumb = 8,
    htmlComponentSbPageDown = 9,
    htmlComponentSbDown = 10,
    htmlComponentSbLeft2 = 11,
    htmlComponentSbPageLeft2 = 12,
    htmlComponentSbRight2 = 13,
    htmlComponentSbPageRight2 = 14,
    htmlComponentSbUp2 = 15,
    htmlComponentSbPageUp2 = 16,
    htmlComponentSbDown2 = 17,
    htmlComponentSbPageDown2 = 18,
    htmlComponentSbTop = 19,
    htmlComponentSbBottom = 20,
    htmlComponentOutside = 21,
    htmlComponentGHTopLeft = 22,
    htmlComponentGHLeft = 23,
    htmlComponentGHTop = 24,
    htmlComponentGHBottomLeft = 25,
    htmlComponentGHTopRight = 26,
    htmlComponentGHBottom = 27,
    htmlComponentGHRight = 28,
    htmlComponentGHBottomRight = 29,
    htmlComponent_Max = 2147483647,
}

enum htmlApplyLocation
{
    htmlApplyLocationInside = 0,
    htmlApplyLocationOutside = 1,
    htmlApplyLocation_Max = 2147483647,
}

enum htmlGlyphMode
{
    htmlGlyphModeNone = 0,
    htmlGlyphModeBegin = 1,
    htmlGlyphModeEnd = 2,
    htmlGlyphModeBoth = 3,
    htmlGlyphMode_Max = 2147483647,
}

enum htmlDraggable
{
    htmlDraggableAuto = 0,
    htmlDraggableTrue = 1,
    htmlDraggableFalse = 2,
    htmlDraggable_Max = 2147483647,
}

enum htmlUnit
{
    htmlUnitCharacter = 1,
    htmlUnitWord = 2,
    htmlUnitSentence = 3,
    htmlUnitTextEdit = 6,
    htmlUnit_Max = 2147483647,
}

enum htmlEndPoints
{
    htmlEndPointsStartToStart = 1,
    htmlEndPointsStartToEnd = 2,
    htmlEndPointsEndToStart = 3,
    htmlEndPointsEndToEnd = 4,
    htmlEndPoints_Max = 2147483647,
}

enum htmlDirection
{
    htmlDirectionForward = 99999,
    htmlDirectionBackward = -99999,
    htmlDirection_Max = 2147483647,
}

enum htmlStart
{
    htmlStartfileopen = 0,
    htmlStartmouseover = 1,
    htmlStart_Max = 2147483647,
}

enum bodyScroll
{
    bodyScrollyes = 1,
    bodyScrollno = 2,
    bodyScrollauto = 4,
    bodyScrolldefault = 3,
    bodyScroll_Max = 2147483647,
}

enum htmlSelectType
{
    htmlSelectTypeSelectOne = 1,
    htmlSelectTypeSelectMultiple = 2,
    htmlSelectType_Max = 2147483647,
}

enum htmlSelectExFlag
{
    htmlSelectExFlagNone = 0,
    htmlSelectExFlagHideSelectionInDesign = 1,
    htmlSelectExFlag_Max = 2147483647,
}

enum htmlSelection
{
    htmlSelectionNone = 0,
    htmlSelectionText = 1,
    htmlSelectionControl = 2,
    htmlSelectionTable = 3,
    htmlSelection_Max = 2147483647,
}

enum htmlMarqueeBehavior
{
    htmlMarqueeBehaviorscroll = 1,
    htmlMarqueeBehaviorslide = 2,
    htmlMarqueeBehavioralternate = 3,
    htmlMarqueeBehavior_Max = 2147483647,
}

enum htmlMarqueeDirection
{
    htmlMarqueeDirectionleft = 1,
    htmlMarqueeDirectionright = 3,
    htmlMarqueeDirectionup = 5,
    htmlMarqueeDirectiondown = 7,
    htmlMarqueeDirection_Max = 2147483647,
}

enum htmlPersistState
{
    htmlPersistStateNormal = 0,
    htmlPersistStateFavorite = 1,
    htmlPersistStateHistory = 2,
    htmlPersistStateSnapshot = 3,
    htmlPersistStateUserData = 4,
    htmlPersistState_Max = 2147483647,
}

enum htmlDropEffect
{
    htmlDropEffectCopy = 0,
    htmlDropEffectLink = 1,
    htmlDropEffectMove = 2,
    htmlDropEffectNone = 3,
    htmlDropEffect_Max = 2147483647,
}

enum htmlEffectAllowed
{
    htmlEffectAllowedCopy = 0,
    htmlEffectAllowedLink = 1,
    htmlEffectAllowedMove = 2,
    htmlEffectAllowedCopyLink = 3,
    htmlEffectAllowedCopyMove = 4,
    htmlEffectAllowedLinkMove = 5,
    htmlEffectAllowedAll = 6,
    htmlEffectAllowedNone = 7,
    htmlEffectAllowedUninitialized = 8,
    htmlEffectAllowed_Max = 2147483647,
}

enum htmlCompatMode
{
    htmlCompatModeBackCompat = 0,
    htmlCompatModeCSS1Compat = 1,
    htmlCompatMode_Max = 2147483647,
}

enum BoolValue
{
    True = 1,
    False = 0,
    BoolValue_Max = 2147483647,
}

enum htmlCaptionAlign
{
    htmlCaptionAlignNotSet = 0,
    htmlCaptionAlignLeft = 1,
    htmlCaptionAlignCenter = 2,
    htmlCaptionAlignRight = 3,
    htmlCaptionAlignJustify = 4,
    htmlCaptionAlignTop = 5,
    htmlCaptionAlignBottom = 6,
    htmlCaptionAlign_Max = 2147483647,
}

enum htmlCaptionVAlign
{
    htmlCaptionVAlignNotSet = 0,
    htmlCaptionVAlignTop = 1,
    htmlCaptionVAlignBottom = 2,
    htmlCaptionVAlign_Max = 2147483647,
}

enum htmlFrame
{
    htmlFrameNotSet = 0,
    htmlFramevoid = 1,
    htmlFrameabove = 2,
    htmlFramebelow = 3,
    htmlFramehsides = 4,
    htmlFramelhs = 5,
    htmlFramerhs = 6,
    htmlFramevsides = 7,
    htmlFramebox = 8,
    htmlFrameborder = 9,
    htmlFrame_Max = 2147483647,
}

enum htmlRules
{
    htmlRulesNotSet = 0,
    htmlRulesnone = 1,
    htmlRulesgroups = 2,
    htmlRulesrows = 3,
    htmlRulescols = 4,
    htmlRulesall = 5,
    htmlRules_Max = 2147483647,
}

enum htmlCellAlign
{
    htmlCellAlignNotSet = 0,
    htmlCellAlignLeft = 1,
    htmlCellAlignCenter = 2,
    htmlCellAlignRight = 3,
    htmlCellAlignMiddle = 2,
    htmlCellAlign_Max = 2147483647,
}

enum htmlCellVAlign
{
    htmlCellVAlignNotSet = 0,
    htmlCellVAlignTop = 1,
    htmlCellVAlignMiddle = 2,
    htmlCellVAlignBottom = 3,
    htmlCellVAlignBaseline = 4,
    htmlCellVAlignCenter = 2,
    htmlCellVAlign_Max = 2147483647,
}

enum frameScrolling
{
    frameScrollingyes = 1,
    frameScrollingno = 2,
    frameScrollingauto = 4,
    frameScrolling_Max = 2147483647,
}

enum sandboxAllow
{
    sandboxAllowScripts = 0,
    sandboxAllowSameOrigin = 1,
    sandboxAllowTopNavigation = 2,
    sandboxAllowForms = 3,
    sandboxAllowPopups = 4,
    sandboxAllow_Max = 2147483647,
}

enum svgAngleType
{
    SVG_ANGLETYPE_UNKNOWN = 0,
    SVG_ANGLETYPE_UNSPECIFIED = 1,
    SVG_ANGLETYPE_DEG = 2,
    SVG_ANGLETYPE_RAD = 3,
    SVG_ANGLETYPE_GRAD = 4,
    svgAngleType_Max = 2147483647,
}

enum svgExternalResourcesRequired
{
    svgExternalResourcesRequiredFalse = 0,
    svgExternalResourcesRequiredTrue = 1,
    svgExternalResourcesRequired_Max = 2147483647,
}

enum svgFocusable
{
    svgFocusableNotSet = 0,
    svgFocusableAuto = 1,
    svgFocusableTrue = 2,
    svgFocusableFalse = 3,
    svgFocusable_Max = 2147483647,
}

enum svgLengthType
{
    SVG_LENGTHTYPE_UNKNOWN = 0,
    SVG_LENGTHTYPE_NUMBER = 1,
    SVG_LENGTHTYPE_PERCENTAGE = 2,
    SVG_LENGTHTYPE_EMS = 3,
    SVG_LENGTHTYPE_EXS = 4,
    SVG_LENGTHTYPE_PX = 5,
    SVG_LENGTHTYPE_CM = 6,
    SVG_LENGTHTYPE_MM = 7,
    SVG_LENGTHTYPE_IN = 8,
    SVG_LENGTHTYPE_PT = 9,
    SVG_LENGTHTYPE_PC = 10,
    svgLengthType_Max = 2147483647,
}

enum svgPathSegType
{
    PATHSEG_UNKNOWN = 0,
    PATHSEG_CLOSEPATH = 1,
    PATHSEG_MOVETO_ABS = 2,
    PATHSEG_MOVETO_REL = 3,
    PATHSEG_LINETO_ABS = 4,
    PATHSEG_LINETO_REL = 5,
    PATHSEG_CURVETO_CUBIC_ABS = 6,
    PATHSEG_CURVETO_CUBIC_REL = 7,
    PATHSEG_CURVETO_QUADRATIC_ABS = 8,
    PATHSEG_CURVETO_QUADRATIC_REL = 9,
    PATHSEG_ARC_ABS = 10,
    PATHSEG_ARC_REL = 11,
    PATHSEG_LINETO_HORIZONTAL_ABS = 12,
    PATHSEG_LINETO_HORIZONTAL_REL = 13,
    PATHSEG_LINETO_VERTICAL_ABS = 14,
    PATHSEG_LINETO_VERTICAL_REL = 15,
    PATHSEG_CURVETO_CUBIC_SMOOTH_ABS = 16,
    PATHSEG_CURVETO_CUBIC_SMOOTH_REL = 17,
    PATHSEG_CURVETO_QUADRATIC_SMOOTH_ABS = 18,
    PATHSEG_CURVETO_QUADRATIC_SMOOTH_REL = 19,
    svgPathSegType_Max = 2147483647,
}

enum svgTransformType
{
    SVG_TRANSFORM_UNKNOWN = 0,
    SVG_TRANSFORM_MATRIX = 1,
    SVG_TRANSFORM_TRANSLATE = 2,
    SVG_TRANSFORM_SCALE = 3,
    SVG_TRANSFORM_ROTATE = 4,
    SVG_TRANSFORM_SKEWX = 5,
    SVG_TRANSFORM_SKEWY = 6,
    svgTransformType_Max = 2147483647,
}

enum svgPreserveAspectRatioAlignType
{
    SVG_PRESERVEASPECTRATIO_UNKNOWN = 0,
    SVG_PRESERVEASPECTRATIO_NONE = 1,
    SVG_PRESERVEASPECTRATIO_XMINYMIN = 2,
    SVG_PRESERVEASPECTRATIO_XMIDYMIN = 3,
    SVG_PRESERVEASPECTRATIO_XMAXYMIN = 4,
    SVG_PRESERVEASPECTRATIO_XMINYMID = 5,
    SVG_PRESERVEASPECTRATIO_XMIDYMID = 6,
    SVG_PRESERVEASPECTRATIO_XMAXYMID = 7,
    SVG_PRESERVEASPECTRATIO_XMINYMAX = 8,
    SVG_PRESERVEASPECTRATIO_XMIDYMAX = 9,
    SVG_PRESERVEASPECTRATIO_XMAXYMAX = 10,
    svgPreserveAspectRatioAlignType_Max = 2147483647,
}

enum svgPreserveAspectMeetOrSliceType
{
    SVG_MEETORSLICE_UNKNOWN = 0,
    SVG_MEETORSLICE_MEET = 1,
    SVG_MEETORSLICE_SLICE = 2,
    svgPreserveAspectMeetOrSliceType_Max = 2147483647,
}

enum svgUnitTypes
{
    SVG_UNITTYPE_UNKNOWN = 0,
    SVG_UNITTYPE_USERSPACEONUSE = 1,
    SVG_UNITTYPE_OBJECTBOUNDINGBOX = 2,
    svgUnitTypes_Max = 2147483647,
}

enum svgSpreadMethod
{
    SVG_SPREADMETHOD_UNKNOWN = 0,
    SVG_SPREADMETHOD_PAD = 1,
    SVG_SPREADMETHOD_REFLECT = 2,
    SVG_SPREADMETHOD_REPEAT = 3,
    svgSpreadMethod_Max = 2147483647,
}

enum svgFeblendMode
{
    SVG_FEBLEND_MODE_UNKNOWN = 0,
    SVG_FEBLEND_MODE_NORMAL = 1,
    SVG_FEBLEND_MODE_MULTIPLY = 2,
    SVG_FEBLEND_MODE_SCREEN = 3,
    SVG_FEBLEND_MODE_DARKEN = 4,
    SVG_FEBLEND_MODE_LIGHTEN = 5,
    svgFeblendMode_Max = 2147483647,
}

enum svgFecolormatrixType
{
    SVG_FECOLORMATRIX_TYPE_UNKNOWN = 0,
    SVG_FECOLORMATRIX_TYPE_MATRIX = 1,
    SVG_FECOLORMATRIX_TYPE_SATURATE = 2,
    SVG_FECOLORMATRIX_TYPE_HUEROTATE = 3,
    SVG_FECOLORMATRIX_TYPE_LUMINANCETOALPHA = 4,
    svgFecolormatrixType_Max = 2147483647,
}

enum svgFecomponenttransferType
{
    SVG_FECOMPONENTTRANSFER_TYPE_UNKNOWN = 0,
    SVG_FECOMPONENTTRANSFER_TYPE_IDENTITY = 1,
    SVG_FECOMPONENTTRANSFER_TYPE_TABLE = 2,
    SVG_FECOMPONENTTRANSFER_TYPE_DISCRETE = 3,
    SVG_FECOMPONENTTRANSFER_TYPE_LINEAR = 4,
    SVG_FECOMPONENTTRANSFER_TYPE_GAMMA = 5,
    svgFecomponenttransferType_Max = 2147483647,
}

enum svgFecompositeOperator
{
    SVG_FECOMPOSITE_OPERATOR_UNKNOWN = 0,
    SVG_FECOMPOSITE_OPERATOR_OVER = 1,
    SVG_FECOMPOSITE_OPERATOR_IN = 2,
    SVG_FECOMPOSITE_OPERATOR_OUT = 3,
    SVG_FECOMPOSITE_OPERATOR_ATOP = 4,
    SVG_FECOMPOSITE_OPERATOR_XOR = 5,
    SVG_FECOMPOSITE_OPERATOR_ARITHMETIC = 6,
    svgFecompositeOperator_Max = 2147483647,
}

enum svgEdgemode
{
    SVG_EDGEMODE_UNKNOWN = 0,
    SVG_EDGEMODE_DUPLICATE = 1,
    SVG_EDGEMODE_WRAP = 2,
    SVG_EDGEMODE_NONE = 3,
    svgEdgemode_Max = 2147483647,
}

enum svgPreserveAlpha
{
    SVG_PRESERVEALPHA_FALSE = 0,
    SVG_PRESERVEALPHA_TRUE = 1,
    svgPreserveAlpha_Max = 2147483647,
}

enum svgChannel
{
    SVG_CHANNEL_UNKNOWN = 0,
    SVG_CHANNEL_R = 1,
    SVG_CHANNEL_G = 2,
    SVG_CHANNEL_B = 3,
    SVG_CHANNEL_A = 4,
    svgChannel_Max = 2147483647,
}

enum svgMorphologyOperator
{
    SVG_MORPHOLOGY_OPERATOR_UNKNOWN = 0,
    SVG_MORPHOLOGY_OPERATOR_ERODE = 1,
    SVG_MORPHOLOGY_OPERATOR_DILATE = 2,
    svgMorphologyOperator_Max = 2147483647,
}

enum svgTurbulenceType
{
    SVG_TURBULENCE_TYPE_UNKNOWN = 0,
    SVG_TURBULENCE_TYPE_FACTALNOISE = 1,
    SVG_TURBULENCE_TYPE_TURBULENCE = 2,
    svgTurbulenceType_Max = 2147483647,
}

enum svgStitchtype
{
    SVG_STITCHTYPE_UNKNOWN = 0,
    SVG_STITCHTYPE_STITCH = 1,
    SVG_STITCHTYPE_NOSTITCH = 2,
    svgStitchtype_Max = 2147483647,
}

enum svgMarkerUnits
{
    SVG_MARKERUNITS_UNKNOWN = 0,
    SVG_MARKERUNITS_USERSPACEONUSE = 1,
    SVG_MARKERUNITS_STROKEWIDTH = 2,
    svgMarkerUnits_Max = 2147483647,
}

enum svgMarkerOrient
{
    SVG_MARKER_ORIENT_UNKNOWN = 0,
    SVG_MARKER_ORIENT_AUTO = 1,
    SVG_MARKER_ORIENT_ANGLE = 2,
    svgMarkerOrient_Max = 2147483647,
}

enum svgMarkerOrientAttribute
{
    svgMarkerOrientAttributeAuto = 0,
    svgMarkerOrientAttribute_Max = 2147483647,
}

enum htmlMediaNetworkState
{
    htmlMediaNetworkStateEmpty = 0,
    htmlMediaNetworkStateIdle = 1,
    htmlMediaNetworkStateLoading = 2,
    htmlMediaNetworkStateNoSource = 3,
    htmlMediaNetworkState_Max = 2147483647,
}

enum htmlMediaReadyState
{
    htmlMediaReadyStateHaveNothing = 0,
    htmlMediaReadyStateHaveMetadata = 1,
    htmlMediaReadyStateHaveCurrentData = 2,
    htmlMediaReadyStateHaveFutureData = 3,
    htmlMediaReadyStateHaveEnoughData = 4,
    htmlMediaReadyState_Max = 2147483647,
}

enum htmlMediaErr
{
    htmlMediaErrAborted = 0,
    htmlMediaErrNetwork = 1,
    htmlMediaErrDecode = 2,
    htmlMediaErrSrcNotSupported = 3,
    htmlMediaErr_Max = 2147483647,
}

enum lengthAdjust
{
    LENGTHADJUST_UNKNOWN = 0,
    LENGTHADJUST_SPACING = 1,
    LENGTHADJUST_SPACINGANDGLYPHS = 2,
    lengthAdjust_Max = 2147483647,
}

enum textpathMethodtype
{
    TEXTPATH_METHODTYPE_UNKNOWN = 0,
    TEXTPATH_METHODTYPE_ALIGN = 1,
    TEXTPATH_METHODTYPE_STRETCH = 2,
    textpathMethodtype_Max = 2147483647,
}

enum textpathSpacingtype
{
    TEXTPATH_SPACINGTYPE_UNKNOWN = 0,
    TEXTPATH_SPACINGTYPE_AUTO = 1,
    TEXTPATH_SPACINGTYPE_EXACT = 2,
    textpathSpacingtype_Max = 2147483647,
}

enum ELEMENT_CORNER
{
    ELEMENT_CORNER_NONE = 0,
    ELEMENT_CORNER_TOP = 1,
    ELEMENT_CORNER_LEFT = 2,
    ELEMENT_CORNER_BOTTOM = 3,
    ELEMENT_CORNER_RIGHT = 4,
    ELEMENT_CORNER_TOPLEFT = 5,
    ELEMENT_CORNER_TOPRIGHT = 6,
    ELEMENT_CORNER_BOTTOMLEFT = 7,
    ELEMENT_CORNER_BOTTOMRIGHT = 8,
    ELEMENT_CORNER_Max = 2147483647,
}

enum SECUREURLHOSTVALIDATE_FLAGS
{
    SUHV_PROMPTBEFORENO = 1,
    SUHV_SILENTYES = 2,
    SUHV_UNSECURESOURCE = 4,
    SECUREURLHOSTVALIDATE_FLAGS_Max = 2147483647,
}

enum POINTER_GRAVITY
{
    POINTER_GRAVITY_Left = 0,
    POINTER_GRAVITY_Right = 1,
    POINTER_GRAVITY_Max = 2147483647,
}

enum ELEMENT_ADJACENCY
{
    ELEM_ADJ_BeforeBegin = 0,
    ELEM_ADJ_AfterBegin = 1,
    ELEM_ADJ_BeforeEnd = 2,
    ELEM_ADJ_AfterEnd = 3,
    ELEMENT_ADJACENCY_Max = 2147483647,
}

enum MARKUP_CONTEXT_TYPE
{
    CONTEXT_TYPE_None = 0,
    CONTEXT_TYPE_Text = 1,
    CONTEXT_TYPE_EnterScope = 2,
    CONTEXT_TYPE_ExitScope = 3,
    CONTEXT_TYPE_NoScope = 4,
    MARKUP_CONTEXT_TYPE_Max = 2147483647,
}

enum FINDTEXT_FLAGS
{
    FINDTEXT_BACKWARDS = 1,
    FINDTEXT_WHOLEWORD = 2,
    FINDTEXT_MATCHCASE = 4,
    FINDTEXT_RAW = 131072,
    FINDTEXT_MATCHREPEATEDWHITESPACE = 262144,
    FINDTEXT_MATCHDIAC = 536870912,
    FINDTEXT_MATCHKASHIDA = 1073741824,
    FINDTEXT_MATCHALEFHAMZA = -2147483648,
    FINDTEXT_FLAGS_Max = 2147483647,
}

enum MOVEUNIT_ACTION
{
    MOVEUNIT_PREVCHAR = 0,
    MOVEUNIT_NEXTCHAR = 1,
    MOVEUNIT_PREVCLUSTERBEGIN = 2,
    MOVEUNIT_NEXTCLUSTERBEGIN = 3,
    MOVEUNIT_PREVCLUSTEREND = 4,
    MOVEUNIT_NEXTCLUSTEREND = 5,
    MOVEUNIT_PREVWORDBEGIN = 6,
    MOVEUNIT_NEXTWORDBEGIN = 7,
    MOVEUNIT_PREVWORDEND = 8,
    MOVEUNIT_NEXTWORDEND = 9,
    MOVEUNIT_PREVPROOFWORD = 10,
    MOVEUNIT_NEXTPROOFWORD = 11,
    MOVEUNIT_NEXTURLBEGIN = 12,
    MOVEUNIT_PREVURLBEGIN = 13,
    MOVEUNIT_NEXTURLEND = 14,
    MOVEUNIT_PREVURLEND = 15,
    MOVEUNIT_PREVSENTENCE = 16,
    MOVEUNIT_NEXTSENTENCE = 17,
    MOVEUNIT_PREVBLOCK = 18,
    MOVEUNIT_NEXTBLOCK = 19,
    MOVEUNIT_ACTION_Max = 2147483647,
}

enum PARSE_FLAGS
{
    PARSE_ABSOLUTIFYIE40URLS = 1,
    PARSE_DISABLEVML = 2,
    PARSE_FLAGS_Max = 2147483647,
}

enum ELEMENT_TAG_ID
{
    TAGID_NULL = 0,
    TAGID_UNKNOWN = 1,
    TAGID_A = 2,
    TAGID_ACRONYM = 3,
    TAGID_ADDRESS = 4,
    TAGID_APPLET = 5,
    TAGID_AREA = 6,
    TAGID_B = 7,
    TAGID_BASE = 8,
    TAGID_BASEFONT = 9,
    TAGID_BDO = 10,
    TAGID_BGSOUND = 11,
    TAGID_BIG = 12,
    TAGID_BLINK = 13,
    TAGID_BLOCKQUOTE = 14,
    TAGID_BODY = 15,
    TAGID_BR = 16,
    TAGID_BUTTON = 17,
    TAGID_CAPTION = 18,
    TAGID_CENTER = 19,
    TAGID_CITE = 20,
    TAGID_CODE = 21,
    TAGID_COL = 22,
    TAGID_COLGROUP = 23,
    TAGID_COMMENT = 24,
    TAGID_COMMENT_RAW = 25,
    TAGID_DD = 26,
    TAGID_DEL = 27,
    TAGID_DFN = 28,
    TAGID_DIR = 29,
    TAGID_DIV = 30,
    TAGID_DL = 31,
    TAGID_DT = 32,
    TAGID_EM = 33,
    TAGID_EMBED = 34,
    TAGID_FIELDSET = 35,
    TAGID_FONT = 36,
    TAGID_FORM = 37,
    TAGID_FRAME = 38,
    TAGID_FRAMESET = 39,
    TAGID_GENERIC = 40,
    TAGID_H1 = 41,
    TAGID_H2 = 42,
    TAGID_H3 = 43,
    TAGID_H4 = 44,
    TAGID_H5 = 45,
    TAGID_H6 = 46,
    TAGID_HEAD = 47,
    TAGID_HR = 48,
    TAGID_HTML = 49,
    TAGID_I = 50,
    TAGID_IFRAME = 51,
    TAGID_IMG = 52,
    TAGID_INPUT = 53,
    TAGID_INS = 54,
    TAGID_KBD = 55,
    TAGID_LABEL = 56,
    TAGID_LEGEND = 57,
    TAGID_LI = 58,
    TAGID_LINK = 59,
    TAGID_LISTING = 60,
    TAGID_MAP = 61,
    TAGID_MARQUEE = 62,
    TAGID_MENU = 63,
    TAGID_META = 64,
    TAGID_NEXTID = 65,
    TAGID_NOBR = 66,
    TAGID_NOEMBED = 67,
    TAGID_NOFRAMES = 68,
    TAGID_NOSCRIPT = 69,
    TAGID_OBJECT = 70,
    TAGID_OL = 71,
    TAGID_OPTION = 72,
    TAGID_P = 73,
    TAGID_PARAM = 74,
    TAGID_PLAINTEXT = 75,
    TAGID_PRE = 76,
    TAGID_Q = 77,
    TAGID_RP = 78,
    TAGID_RT = 79,
    TAGID_RUBY = 80,
    TAGID_S = 81,
    TAGID_SAMP = 82,
    TAGID_SCRIPT = 83,
    TAGID_SELECT = 84,
    TAGID_SMALL = 85,
    TAGID_SPAN = 86,
    TAGID_STRIKE = 87,
    TAGID_STRONG = 88,
    TAGID_STYLE = 89,
    TAGID_SUB = 90,
    TAGID_SUP = 91,
    TAGID_TABLE = 92,
    TAGID_TBODY = 93,
    TAGID_TC = 94,
    TAGID_TD = 95,
    TAGID_TEXTAREA = 96,
    TAGID_TFOOT = 97,
    TAGID_TH = 98,
    TAGID_THEAD = 99,
    TAGID_TITLE = 100,
    TAGID_TR = 101,
    TAGID_TT = 102,
    TAGID_U = 103,
    TAGID_UL = 104,
    TAGID_VAR = 105,
    TAGID_WBR = 106,
    TAGID_XMP = 107,
    TAGID_ROOT = 108,
    TAGID_OPTGROUP = 109,
    TAGID_ABBR = 110,
    TAGID_SVG_A = 111,
    TAGID_SVG_ALTGLYPH = 112,
    TAGID_SVG_ALTGLYPHDEF = 113,
    TAGID_SVG_ALTGLYPHITEM = 114,
    TAGID_SVG_ANIMATE = 115,
    TAGID_SVG_ANIMATECOLOR = 116,
    TAGID_SVG_ANIMATEMOTION = 117,
    TAGID_SVG_ANIMATETRANSFORM = 118,
    TAGID_SVG_CIRCLE = 119,
    TAGID_SVG_CLIPPATH = 120,
    TAGID_SVG_COLOR_PROFILE = 121,
    TAGID_SVG_CURSOR = 122,
    TAGID_SVG_DEFINITION_SRC = 123,
    TAGID_SVG_DEFS = 124,
    TAGID_SVG_DESC = 125,
    TAGID_SVG_ELLIPSE = 126,
    TAGID_SVG_FEBLEND = 127,
    TAGID_SVG_FECOLORMATRIX = 128,
    TAGID_SVG_FECOMPONENTTRANSFER = 129,
    TAGID_SVG_FECOMPOSITE = 130,
    TAGID_SVG_FECONVOLVEMATRIX = 131,
    TAGID_SVG_FEDIFFUSELIGHTING = 132,
    TAGID_SVG_FEDISPLACEMENTMAP = 133,
    TAGID_SVG_FEDISTANTLIGHT = 134,
    TAGID_SVG_FEFLOOD = 135,
    TAGID_SVG_FEFUNCA = 136,
    TAGID_SVG_FEFUNCB = 137,
    TAGID_SVG_FEFUNCG = 138,
    TAGID_SVG_FEFUNCR = 139,
    TAGID_SVG_FEGAUSSIANBLUR = 140,
    TAGID_SVG_FEIMAGE = 141,
    TAGID_SVG_FEMERGE = 142,
    TAGID_SVG_FEMERGENODE = 143,
    TAGID_SVG_FEMORPHOLOGY = 144,
    TAGID_SVG_FEOFFSET = 145,
    TAGID_SVG_FEPOINTLIGHT = 146,
    TAGID_SVG_FESPECULARLIGHTING = 147,
    TAGID_SVG_FESPOTLIGHT = 148,
    TAGID_SVG_FETILE = 149,
    TAGID_SVG_FETURBULENCE = 150,
    TAGID_SVG_FILTER = 151,
    TAGID_SVG_FONT = 152,
    TAGID_SVG_FONT_FACE = 153,
    TAGID_SVG_FONT_FACE_FORMAT = 154,
    TAGID_SVG_FONT_FACE_NAME = 155,
    TAGID_SVG_FONT_FACE_SRC = 156,
    TAGID_SVG_FONT_FACE_URI = 157,
    TAGID_SVG_FOREIGNOBJECT = 158,
    TAGID_SVG_G = 159,
    TAGID_SVG_GLYPH = 160,
    TAGID_SVG_GLYPHREF = 161,
    TAGID_SVG_HKERN = 162,
    TAGID_SVG_IMAGE = 163,
    TAGID_SVG_LINE = 164,
    TAGID_SVG_LINEARGRADIENT = 165,
    TAGID_SVG_MARKER = 166,
    TAGID_SVG_MASK = 167,
    TAGID_SVG_METADATA = 168,
    TAGID_SVG_MISSING_GLYPH = 169,
    TAGID_SVG_MPATH = 170,
    TAGID_SVG_PATH = 171,
    TAGID_SVG_PATTERN = 172,
    TAGID_SVG_POLYGON = 173,
    TAGID_SVG_POLYLINE = 174,
    TAGID_SVG_RADIALGRADIENT = 175,
    TAGID_SVG_RECT = 176,
    TAGID_SVG_SCRIPT = 177,
    TAGID_SVG_SET = 178,
    TAGID_SVG_STOP = 179,
    TAGID_SVG_STYLE = 180,
    TAGID_SVG_SVG = 181,
    TAGID_SVG_SWITCH = 182,
    TAGID_SVG_SYMBOL = 183,
    TAGID_SVG_TEXT = 184,
    TAGID_SVG_TEXTPATH = 185,
    TAGID_SVG_TITLE = 186,
    TAGID_SVG_TREF = 187,
    TAGID_SVG_TSPAN = 188,
    TAGID_SVG_USE = 189,
    TAGID_SVG_VIEW = 190,
    TAGID_SVG_VKERN = 191,
    TAGID_AUDIO = 192,
    TAGID_SOURCE = 193,
    TAGID_VIDEO = 194,
    TAGID_CANVAS = 195,
    TAGID_DOCTYPE = 196,
    TAGID_KEYGEN = 197,
    TAGID_PROCESSINGINSTRUCTION = 198,
    TAGID_ARTICLE = 199,
    TAGID_ASIDE = 200,
    TAGID_FIGCAPTION = 201,
    TAGID_FIGURE = 202,
    TAGID_FOOTER = 203,
    TAGID_HEADER = 204,
    TAGID_HGROUP = 205,
    TAGID_MARK = 206,
    TAGID_NAV = 207,
    TAGID_SECTION = 208,
    TAGID_PROGRESS = 209,
    TAGID_MATHML_ANNOTATION_XML = 210,
    TAGID_MATHML_MATH = 211,
    TAGID_MATHML_MI = 212,
    TAGID_MATHML_MN = 213,
    TAGID_MATHML_MO = 214,
    TAGID_MATHML_MS = 215,
    TAGID_MATHML_MTEXT = 216,
    TAGID_DATALIST = 217,
    TAGID_TRACK = 218,
    TAGID_ISINDEX = 219,
    TAGID_COMMAND = 220,
    TAGID_DETAILS = 221,
    TAGID_SUMMARY = 222,
    TAGID_X_MS_WEBVIEW = 223,
    TAGID_COUNT = 224,
    TAGID_LAST_PREDEFINED = 10000,
    ELEMENT_TAG_ID_Max = 2147483647,
}

enum SELECTION_TYPE
{
    SELECTION_TYPE_None = 0,
    SELECTION_TYPE_Caret = 1,
    SELECTION_TYPE_Text = 2,
    SELECTION_TYPE_Control = 3,
    SELECTION_TYPE_Max = 2147483647,
}

enum SAVE_SEGMENTS_FLAGS
{
    SAVE_SEGMENTS_NoIE4SelectionCompat = 1,
    SAVE_SEGMENTS_FLAGS_Max = 2147483647,
}

enum CARET_DIRECTION
{
    CARET_DIRECTION_INDETERMINATE = 0,
    CARET_DIRECTION_SAME = 1,
    CARET_DIRECTION_BACKWARD = 2,
    CARET_DIRECTION_FORWARD = 3,
    CARET_DIRECTION_Max = 2147483647,
}

enum LINE_DIRECTION
{
    LINE_DIRECTION_RightToLeft = 1,
    LINE_DIRECTION_LeftToRight = 2,
    LINE_DIRECTION_Max = 2147483647,
}

enum HT_OPTIONS
{
    HT_OPT_AllowAfterEOL = 1,
    HT_OPTIONS_Max = 2147483647,
}

enum HT_RESULTS
{
    HT_RESULTS_Glyph = 1,
    HT_RESULTS_Max = 2147483647,
}

enum DISPLAY_MOVEUNIT
{
    DISPLAY_MOVEUNIT_PreviousLine = 1,
    DISPLAY_MOVEUNIT_NextLine = 2,
    DISPLAY_MOVEUNIT_CurrentLineStart = 3,
    DISPLAY_MOVEUNIT_CurrentLineEnd = 4,
    DISPLAY_MOVEUNIT_TopOfWindow = 5,
    DISPLAY_MOVEUNIT_BottomOfWindow = 6,
    DISPLAY_MOVEUNIT_Max = 2147483647,
}

enum DISPLAY_GRAVITY
{
    DISPLAY_GRAVITY_PreviousLine = 1,
    DISPLAY_GRAVITY_NextLine = 2,
    DISPLAY_GRAVITY_Max = 2147483647,
}

enum DISPLAY_BREAK
{
    DISPLAY_BREAK_None = 0,
    DISPLAY_BREAK_Block = 1,
    DISPLAY_BREAK_Break = 2,
    DISPLAY_BREAK_Max = 2147483647,
}

enum COORD_SYSTEM
{
    COORD_SYSTEM_GLOBAL = 0,
    COORD_SYSTEM_PARENT = 1,
    COORD_SYSTEM_CONTAINER = 2,
    COORD_SYSTEM_CONTENT = 3,
    COORD_SYSTEM_FRAME = 4,
    COORD_SYSTEM_CLIENT = 5,
    COORD_SYSTEM_Max = 2147483647,
}

enum DEV_CONSOLE_MESSAGE_LEVEL
{
    DCML_INFORMATIONAL = 0,
    DCML_WARNING = 1,
    DCML_ERROR = 2,
    DEV_CONSOLE_MESSAGE_LEVEL_Max = 2147483647,
}

enum DOM_EVENT_PHASE
{
    DEP_CAPTURING_PHASE = 1,
    DEP_AT_TARGET = 2,
    DEP_BUBBLING_PHASE = 3,
    DOM_EVENT_PHASE_Max = 2147483647,
}

enum SCRIPT_TIMER_TYPE
{
    STT_TIMEOUT = 0,
    STT_INTERVAL = 1,
    STT_IMMEDIATE = 2,
    STT_ANIMATION_FRAME = 3,
    SCRIPT_TIMER_TYPE_Max = 2147483647,
}

enum HTML_PAINTER
{
    HTMLPAINTER_OPAQUE = 1,
    HTMLPAINTER_TRANSPARENT = 2,
    HTMLPAINTER_ALPHA = 4,
    HTMLPAINTER_COMPLEX = 8,
    HTMLPAINTER_OVERLAY = 16,
    HTMLPAINTER_HITTEST = 32,
    HTMLPAINTER_SURFACE = 256,
    HTMLPAINTER_3DSURFACE = 512,
    HTMLPAINTER_NOBAND = 1024,
    HTMLPAINTER_NODC = 4096,
    HTMLPAINTER_NOPHYSICALCLIP = 8192,
    HTMLPAINTER_NOSAVEDC = 16384,
    HTMLPAINTER_SUPPORTS_XFORM = 32768,
    HTMLPAINTER_EXPAND = 65536,
    HTMLPAINTER_NOSCROLLBITS = 131072,
    HTML_PAINTER_Max = 2147483647,
}

enum HTML_PAINT_ZORDER
{
    HTMLPAINT_ZORDER_NONE = 0,
    HTMLPAINT_ZORDER_REPLACE_ALL = 1,
    HTMLPAINT_ZORDER_REPLACE_CONTENT = 2,
    HTMLPAINT_ZORDER_REPLACE_BACKGROUND = 3,
    HTMLPAINT_ZORDER_BELOW_CONTENT = 4,
    HTMLPAINT_ZORDER_BELOW_FLOW = 5,
    HTMLPAINT_ZORDER_ABOVE_FLOW = 6,
    HTMLPAINT_ZORDER_ABOVE_CONTENT = 7,
    HTMLPAINT_ZORDER_WINDOW_TOP = 8,
    HTML_PAINT_ZORDER_Max = 2147483647,
}

enum HTML_PAINT_DRAW_FLAGS
{
    HTMLPAINT_DRAW_UPDATEREGION = 1,
    HTMLPAINT_DRAW_USE_XFORM = 2,
    HTML_PAINT_DRAW_FLAGS_Max = 2147483647,
}

enum HTML_PAINT_EVENT_FLAGS
{
    HTMLPAINT_EVENT_TARGET = 1,
    HTMLPAINT_EVENT_SETCURSOR = 2,
    HTML_PAINT_EVENT_FLAGS_Max = 2147483647,
}

enum HTML_PAINT_DRAW_INFO_FLAGS
{
    HTMLPAINT_DRAWINFO_VIEWPORT = 1,
    HTMLPAINT_DRAWINFO_UPDATEREGION = 2,
    HTMLPAINT_DRAWINFO_XFORM = 4,
    HTML_PAINT_DRAW_INFO_FLAGS_Max = 2147483647,
}

struct HTML_PAINTER_INFO
{
    int lFlags;
    int lZOrder;
    Guid iidDrawObject;
    RECT rcExpand;
}

struct HTML_PAINT_XFORM
{
    float eM11;
    float eM12;
    float eM21;
    float eM22;
    float eDx;
    float eDy;
}

struct HTML_PAINT_DRAW_INFO
{
    RECT rcViewport;
    HRGN hrgnUpdate;
    HTML_PAINT_XFORM xform;
}

enum HTMLDlgFlag
{
    HTMLDlgFlagNo = 0,
    HTMLDlgFlagOff = 0,
    HTMLDlgFlag0 = 0,
    HTMLDlgFlagYes = 1,
    HTMLDlgFlagOn = 1,
    HTMLDlgFlag1 = 1,
    HTMLDlgFlagNotSet = -1,
    HTMLDlgFlag_Max = 2147483647,
}

enum HTMLDlgBorder
{
    HTMLDlgBorderThin = 0,
    HTMLDlgBorderThick = 262144,
    HTMLDlgBorder_Max = 2147483647,
}

enum HTMLDlgEdge
{
    HTMLDlgEdgeSunken = 0,
    HTMLDlgEdgeRaised = 16,
    HTMLDlgEdge_Max = 2147483647,
}

enum HTMLDlgCenter
{
    HTMLDlgCenterNo = 0,
    HTMLDlgCenterOff = 0,
    HTMLDlgCenter0 = 0,
    HTMLDlgCenterYes = 1,
    HTMLDlgCenterOn = 1,
    HTMLDlgCenter1 = 1,
    HTMLDlgCenterParent = 1,
    HTMLDlgCenterDesktop = 2,
    HTMLDlgCenter_Max = 2147483647,
}

enum HTMLAppFlag
{
    HTMLAppFlagNo = 0,
    HTMLAppFlagOff = 0,
    HTMLAppFlag0 = 0,
    HTMLAppFlagYes = 1,
    HTMLAppFlagOn = 1,
    HTMLAppFlag1 = 1,
    HTMLAppFlag_Max = 2147483647,
}

enum HTMLMinimizeFlag
{
    HTMLMinimizeFlagNo = 0,
    HTMLMinimizeFlagYes = 131072,
    HTMLMinimizeFlag_Max = 2147483647,
}

enum HTMLMaximizeFlag
{
    HTMLMaximizeFlagNo = 0,
    HTMLMaximizeFlagYes = 65536,
    HTMLMaximizeFlag_Max = 2147483647,
}

enum HTMLCaptionFlag
{
    HTMLCaptionFlagNo = 0,
    HTMLCaptionFlagYes = 12582912,
    HTMLCaptionFlag_Max = 2147483647,
}

enum HTMLSysMenuFlag
{
    HTMLSysMenuFlagNo = 0,
    HTMLSysMenuFlagYes = 524288,
    HTMLSysMenuFlag_Max = 2147483647,
}

enum HTMLBorder
{
    HTMLBorderNone = 0,
    HTMLBorderThick = 262144,
    HTMLBorderDialog = 4194304,
    HTMLBorderThin = 8388608,
    HTMLBorder_Max = 2147483647,
}

enum HTMLBorderStyle
{
    HTMLBorderStyleNormal = 0,
    HTMLBorderStyleRaised = 256,
    HTMLBorderStyleSunken = 512,
    HTMLBorderStylecombined = 768,
    HTMLBorderStyleStatic = 131072,
    HTMLBorderStyle_Max = 2147483647,
}

enum HTMLWindowState
{
    HTMLWindowStateNormal = 1,
    HTMLWindowStateMaximize = 3,
    HTMLWindowStateMinimize = 6,
    HTMLWindowState_Max = 2147483647,
}

enum BEHAVIOR_EVENT
{
    BEHAVIOREVENT_FIRST = 0,
    BEHAVIOREVENT_CONTENTREADY = 0,
    BEHAVIOREVENT_DOCUMENTREADY = 1,
    BEHAVIOREVENT_APPLYSTYLE = 2,
    BEHAVIOREVENT_DOCUMENTCONTEXTCHANGE = 3,
    BEHAVIOREVENT_CONTENTSAVE = 4,
    BEHAVIOREVENT_LAST = 4,
    BEHAVIOR_EVENT_Max = 2147483647,
}

enum BEHAVIOR_EVENT_FLAGS
{
    BEHAVIOREVENTFLAGS_BUBBLE = 1,
    BEHAVIOREVENTFLAGS_STANDARDADDITIVE = 2,
    BEHAVIOR_EVENT_FLAGS_Max = 2147483647,
}

enum BEHAVIOR_RENDER_INFO
{
    BEHAVIORRENDERINFO_BEFOREBACKGROUND = 1,
    BEHAVIORRENDERINFO_AFTERBACKGROUND = 2,
    BEHAVIORRENDERINFO_BEFORECONTENT = 4,
    BEHAVIORRENDERINFO_AFTERCONTENT = 8,
    BEHAVIORRENDERINFO_AFTERFOREGROUND = 32,
    BEHAVIORRENDERINFO_ABOVECONTENT = 40,
    BEHAVIORRENDERINFO_ALLLAYERS = 255,
    BEHAVIORRENDERINFO_DISABLEBACKGROUND = 256,
    BEHAVIORRENDERINFO_DISABLENEGATIVEZ = 512,
    BEHAVIORRENDERINFO_DISABLECONTENT = 1024,
    BEHAVIORRENDERINFO_DISABLEPOSITIVEZ = 2048,
    BEHAVIORRENDERINFO_DISABLEALLLAYERS = 3840,
    BEHAVIORRENDERINFO_HITTESTING = 4096,
    BEHAVIORRENDERINFO_SURFACE = 1048576,
    BEHAVIORRENDERINFO_3DSURFACE = 2097152,
    BEHAVIOR_RENDER_INFO_Max = 2147483647,
}

enum BEHAVIOR_RELATION
{
    BEHAVIOR_FIRSTRELATION = 0,
    BEHAVIOR_SAMEELEMENT = 0,
    BEHAVIOR_PARENT = 1,
    BEHAVIOR_CHILD = 2,
    BEHAVIOR_SIBLING = 3,
    BEHAVIOR_LASTRELATION = 3,
    BEHAVIOR_RELATION_Max = 2147483647,
}

enum BEHAVIOR_LAYOUT_INFO
{
    BEHAVIORLAYOUTINFO_FULLDELEGATION = 1,
    BEHAVIORLAYOUTINFO_MODIFYNATURAL = 2,
    BEHAVIORLAYOUTINFO_MAPSIZE = 4,
    BEHAVIOR_LAYOUT_INFO_Max = 2147483647,
}

enum BEHAVIOR_LAYOUT_MODE
{
    BEHAVIORLAYOUTMODE_NATURAL = 1,
    BEHAVIORLAYOUTMODE_MINWIDTH = 2,
    BEHAVIORLAYOUTMODE_MAXWIDTH = 4,
    BEHAVIORLAYOUTMODE_MEDIA_RESOLUTION = 16384,
    BEHAVIORLAYOUTMODE_FINAL_PERCENT = 32768,
    BEHAVIOR_LAYOUT_MODE_Max = 2147483647,
}

enum ELEMENTDESCRIPTOR_FLAGS
{
    ELEMENTDESCRIPTORFLAGS_LITERAL = 1,
    ELEMENTDESCRIPTORFLAGS_NESTED_LITERAL = 2,
    ELEMENTDESCRIPTOR_FLAGS_Max = 2147483647,
}

enum ELEMENTNAMESPACE_FLAGS
{
    ELEMENTNAMESPACEFLAGS_ALLOWANYTAG = 1,
    ELEMENTNAMESPACEFLAGS_QUERYFORUNKNOWNTAGS = 2,
    ELEMENTNAMESPACE_FLAGS_Max = 2147483647,
}

enum VIEW_OBJECT_ALPHA_MODE
{
    VIEW_OBJECT_ALPHA_MODE_IGNORE = 0,
    VIEW_OBJECT_ALPHA_MODE_PREMULTIPLIED = 1,
    VIEW_OBJECT_ALPHA_MODE_Max = 2147483647,
}

enum VIEW_OBJECT_COMPOSITION_MODE
{
    VIEW_OBJECT_COMPOSITION_MODE_LEGACY = 0,
    VIEW_OBJECT_COMPOSITION_MODE_SURFACEPRESENTER = 1,
    VIEW_OBJECT_COMPOSITION_MODE_Max = 2147483647,
}

const GUID IID_IHTMLEventObj = {0x3050F32D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F32D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEventObj : IDispatch
{
    HRESULT get_srcElement(IHTMLElement* p);
    HRESULT get_altKey(short* p);
    HRESULT get_ctrlKey(short* p);
    HRESULT get_shiftKey(short* p);
    HRESULT put_returnValue(VARIANT v);
    HRESULT get_returnValue(VARIANT* p);
    HRESULT put_cancelBubble(short v);
    HRESULT get_cancelBubble(short* p);
    HRESULT get_fromElement(IHTMLElement* p);
    HRESULT get_toElement(IHTMLElement* p);
    HRESULT put_keyCode(int v);
    HRESULT get_keyCode(int* p);
    HRESULT get_button(int* p);
    HRESULT get_type(BSTR* p);
    HRESULT get_qualifier(BSTR* p);
    HRESULT get_reason(int* p);
    HRESULT get_x(int* p);
    HRESULT get_y(int* p);
    HRESULT get_clientX(int* p);
    HRESULT get_clientY(int* p);
    HRESULT get_offsetX(int* p);
    HRESULT get_offsetY(int* p);
    HRESULT get_screenX(int* p);
    HRESULT get_screenY(int* p);
    HRESULT get_srcFilter(IDispatch* p);
}

const GUID IID_IElementBehaviorSite = {0x3050F427, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F427, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorSite : IUnknown
{
    HRESULT GetElement(IHTMLElement* ppElement);
    HRESULT RegisterNotification(int lEvent);
}

const GUID IID_IElementBehavior = {0x3050F425, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F425, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehavior : IUnknown
{
    HRESULT Init(IElementBehaviorSite pBehaviorSite);
    HRESULT Notify(int lEvent, VARIANT* pVar);
    HRESULT Detach();
}

const GUID IID_IElementBehaviorFactory = {0x3050F429, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F429, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorFactory : IUnknown
{
    HRESULT FindBehavior(BSTR bstrBehavior, BSTR bstrBehaviorUrl, IElementBehaviorSite pSite, IElementBehavior* ppBehavior);
}

const GUID IID_IElementBehaviorSiteOM = {0x3050F489, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F489, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorSiteOM : IUnknown
{
    HRESULT RegisterEvent(ushort* pchEvent, int lFlags, int* plCookie);
    HRESULT GetEventCookie(ushort* pchEvent, int* plCookie);
    HRESULT FireEvent(int lCookie, IHTMLEventObj pEventObject);
    HRESULT CreateEventObject(IHTMLEventObj* ppEventObject);
    HRESULT RegisterName(ushort* pchName);
    HRESULT RegisterUrn(ushort* pchUrn);
}

const GUID IID_IElementBehaviorRender = {0x3050F4AA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4AA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorRender : IUnknown
{
    HRESULT Draw(HDC hdc, int lLayer, RECT* pRect, IUnknown pReserved);
    HRESULT GetRenderInfo(int* plRenderInfo);
    HRESULT HitTestPoint(POINT* pPoint, IUnknown pReserved, int* pbHit);
}

const GUID IID_IElementBehaviorSiteRender = {0x3050F4A7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4A7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorSiteRender : IUnknown
{
    HRESULT Invalidate(RECT* pRect);
    HRESULT InvalidateRenderInfo();
    HRESULT InvalidateStyle();
}

const GUID IID_IDOMEvent = {0x305104BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMEvent : IDispatch
{
    HRESULT get_bubbles(short* p);
    HRESULT get_cancelable(short* p);
    HRESULT get_currentTarget(IEventTarget* p);
    HRESULT get_defaultPrevented(short* p);
    HRESULT get_eventPhase(ushort* p);
    HRESULT get_target(IEventTarget* p);
    HRESULT get_timeStamp(ulong* p);
    HRESULT get_type(BSTR* p);
    HRESULT initEvent(BSTR eventType, short canBubble, short cancelable);
    HRESULT preventDefault();
    HRESULT stopPropagation();
    HRESULT stopImmediatePropagation();
    HRESULT get_isTrusted(short* p);
    HRESULT put_cancelBubble(short v);
    HRESULT get_cancelBubble(short* p);
    HRESULT get_srcElement(IHTMLElement* p);
}

const GUID IID_IHTMLDOMConstructor = {0x3051049B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051049B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMConstructor : IDispatch
{
    HRESULT get_constructor(IDispatch* p);
    HRESULT LookupGetter(BSTR propname, VARIANT* ppDispHandler);
    HRESULT LookupSetter(BSTR propname, VARIANT* ppDispHandler);
    HRESULT DefineGetter(BSTR propname, VARIANT* pdispHandler);
    HRESULT DefineSetter(BSTR propname, VARIANT* pdispHandler);
}

const GUID IID_IHTMLStyleSheetRule = {0x3050F357, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F357, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetRule : IDispatch
{
    HRESULT put_selectorText(BSTR v);
    HRESULT get_selectorText(BSTR* p);
    HRESULT get_style(IHTMLRuleStyle* p);
    HRESULT get_readOnly(short* p);
}

const GUID IID_IHTMLCSSStyleDeclaration = {0x30510740, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510740, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCSSStyleDeclaration : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get_parentRule(VARIANT* p);
    HRESULT getPropertyValue(BSTR bstrPropertyName, BSTR* pbstrPropertyValue);
    HRESULT getPropertyPriority(BSTR bstrPropertyName, BSTR* pbstrPropertyPriority);
    HRESULT removeProperty(BSTR bstrPropertyName, BSTR* pbstrPropertyValue);
    HRESULT setProperty(BSTR bstrPropertyName, VARIANT* pvarPropertyValue, VARIANT* pvarPropertyPriority);
    HRESULT item(int index, BSTR* pbstrPropertyName);
    HRESULT put_fontFamily(BSTR v);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT put_fontStyle(BSTR v);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT put_fontVariant(BSTR v);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT put_fontWeight(BSTR v);
    HRESULT get_fontWeight(BSTR* p);
    HRESULT put_fontSize(VARIANT v);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_backgroundColor(VARIANT v);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT put_backgroundImage(BSTR v);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT put_backgroundRepeat(BSTR v);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT put_backgroundAttachment(BSTR v);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT put_backgroundPosition(BSTR v);
    HRESULT get_backgroundPosition(BSTR* p);
    HRESULT put_backgroundPositionX(VARIANT v);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT put_backgroundPositionY(VARIANT v);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT put_wordSpacing(VARIANT v);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT put_letterSpacing(VARIANT v);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT put_verticalAlign(VARIANT v);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT put_textTransform(BSTR v);
    HRESULT get_textTransform(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textIndent(VARIANT v);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT put_lineHeight(VARIANT v);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT put_marginTop(VARIANT v);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT put_marginRight(VARIANT v);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT put_marginBottom(VARIANT v);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT put_marginLeft(VARIANT v);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT put_margin(BSTR v);
    HRESULT get_margin(BSTR* p);
    HRESULT put_paddingTop(VARIANT v);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT put_paddingRight(VARIANT v);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT put_paddingBottom(VARIANT v);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT put_paddingLeft(VARIANT v);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT put_padding(BSTR v);
    HRESULT get_padding(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderTop(BSTR v);
    HRESULT get_borderTop(BSTR* p);
    HRESULT put_borderRight(BSTR v);
    HRESULT get_borderRight(BSTR* p);
    HRESULT put_borderBottom(BSTR v);
    HRESULT get_borderBottom(BSTR* p);
    HRESULT put_borderLeft(BSTR v);
    HRESULT get_borderLeft(BSTR* p);
    HRESULT put_borderColor(BSTR v);
    HRESULT get_borderColor(BSTR* p);
    HRESULT put_borderTopColor(VARIANT v);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT put_borderRightColor(VARIANT v);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT put_borderBottomColor(VARIANT v);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT put_borderLeftColor(VARIANT v);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT put_borderWidth(BSTR v);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT put_borderTopWidth(VARIANT v);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT put_borderRightWidth(VARIANT v);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT put_borderBottomWidth(VARIANT v);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT put_borderLeftWidth(VARIANT v);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_borderTopStyle(BSTR v);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT put_borderRightStyle(BSTR v);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT put_borderBottomStyle(BSTR v);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT put_borderLeftStyle(BSTR v);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_styleFloat(BSTR v);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
    HRESULT put_display(BSTR v);
    HRESULT get_display(BSTR* p);
    HRESULT put_visibility(BSTR v);
    HRESULT get_visibility(BSTR* p);
    HRESULT put_listStyleType(BSTR v);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT put_listStylePosition(BSTR v);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT put_listStyleImage(BSTR v);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT put_listStyle(BSTR v);
    HRESULT get_listStyle(BSTR* p);
    HRESULT put_whiteSpace(BSTR v);
    HRESULT get_whiteSpace(BSTR* p);
    HRESULT put_top(VARIANT v);
    HRESULT get_top(VARIANT* p);
    HRESULT put_left(VARIANT v);
    HRESULT get_left(VARIANT* p);
    HRESULT put_zIndex(VARIANT v);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT put_overflow(BSTR v);
    HRESULT get_overflow(BSTR* p);
    HRESULT put_pageBreakBefore(BSTR v);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT put_pageBreakAfter(BSTR v);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT put_cursor(BSTR v);
    HRESULT get_cursor(BSTR* p);
    HRESULT put_clip(BSTR v);
    HRESULT get_clip(BSTR* p);
    HRESULT put_filter(BSTR v);
    HRESULT get_filter(BSTR* p);
    HRESULT put_tableLayout(BSTR v);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT put_borderCollapse(BSTR v);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT put_position(BSTR v);
    HRESULT get_position(BSTR* p);
    HRESULT put_unicodeBidi(BSTR v);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT put_bottom(VARIANT v);
    HRESULT get_bottom(VARIANT* p);
    HRESULT put_right(VARIANT v);
    HRESULT get_right(VARIANT* p);
    HRESULT put_imeMode(BSTR v);
    HRESULT get_imeMode(BSTR* p);
    HRESULT put_rubyAlign(BSTR v);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT put_rubyPosition(BSTR v);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT put_rubyOverhang(BSTR v);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT put_layoutGridChar(VARIANT v);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT put_layoutGridLine(VARIANT v);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT put_layoutGridMode(BSTR v);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT put_layoutGridType(BSTR v);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT put_layoutGrid(BSTR v);
    HRESULT get_layoutGrid(BSTR* p);
    HRESULT put_textAutospace(BSTR v);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT put_wordBreak(BSTR v);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT put_lineBreak(BSTR v);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT put_textJustify(BSTR v);
    HRESULT get_textJustify(BSTR* p);
    HRESULT put_textJustifyTrim(BSTR v);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT put_textKashida(VARIANT v);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT put_overflowX(BSTR v);
    HRESULT get_overflowX(BSTR* p);
    HRESULT put_overflowY(BSTR v);
    HRESULT get_overflowY(BSTR* p);
    HRESULT put_accelerator(BSTR v);
    HRESULT get_accelerator(BSTR* p);
    HRESULT put_layoutFlow(BSTR v);
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT put_zoom(VARIANT v);
    HRESULT get_zoom(VARIANT* p);
    HRESULT put_wordWrap(BSTR v);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT put_textUnderlinePosition(BSTR v);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT put_scrollbarBaseColor(VARIANT v);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT put_scrollbarFaceColor(VARIANT v);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT put_scrollbar3dLightColor(VARIANT v);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT put_scrollbarShadowColor(VARIANT v);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT put_scrollbarHighlightColor(VARIANT v);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT put_scrollbarDarkShadowColor(VARIANT v);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT put_scrollbarArrowColor(VARIANT v);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT put_scrollbarTrackColor(VARIANT v);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT put_writingMode(BSTR v);
    HRESULT get_writingMode(BSTR* p);
    HRESULT put_textAlignLast(BSTR v);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT put_textKashidaSpace(VARIANT v);
    HRESULT get_textKashidaSpace(VARIANT* p);
    HRESULT put_textOverflow(BSTR v);
    HRESULT get_textOverflow(BSTR* p);
    HRESULT put_minHeight(VARIANT v);
    HRESULT get_minHeight(VARIANT* p);
    HRESULT put_msInterpolationMode(BSTR v);
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT put_maxHeight(VARIANT v);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT put_minWidth(VARIANT v);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT put_maxWidth(VARIANT v);
    HRESULT get_maxWidth(VARIANT* p);
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_captionSide(BSTR v);
    HRESULT get_captionSide(BSTR* p);
    HRESULT put_counterIncrement(BSTR v);
    HRESULT get_counterIncrement(BSTR* p);
    HRESULT put_counterReset(BSTR v);
    HRESULT get_counterReset(BSTR* p);
    HRESULT put_outline(BSTR v);
    HRESULT get_outline(BSTR* p);
    HRESULT put_outlineWidth(VARIANT v);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT put_outlineStyle(BSTR v);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT put_outlineColor(VARIANT v);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT put_boxSizing(BSTR v);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT put_borderSpacing(BSTR v);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT put_orphans(VARIANT v);
    HRESULT get_orphans(VARIANT* p);
    HRESULT put_widows(VARIANT v);
    HRESULT get_widows(VARIANT* p);
    HRESULT put_pageBreakInside(BSTR v);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT put_emptyCells(BSTR v);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT put_msBlockProgression(BSTR v);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT put_quotes(BSTR v);
    HRESULT get_quotes(BSTR* p);
    HRESULT put_alignmentBaseline(BSTR v);
    HRESULT get_alignmentBaseline(BSTR* p);
    HRESULT put_baselineShift(VARIANT v);
    HRESULT get_baselineShift(VARIANT* p);
    HRESULT put_dominantBaseline(BSTR v);
    HRESULT get_dominantBaseline(BSTR* p);
    HRESULT put_fontSizeAdjust(VARIANT v);
    HRESULT get_fontSizeAdjust(VARIANT* p);
    HRESULT put_fontStretch(BSTR v);
    HRESULT get_fontStretch(BSTR* p);
    HRESULT put_opacity(VARIANT v);
    HRESULT get_opacity(VARIANT* p);
    HRESULT put_clipPath(BSTR v);
    HRESULT get_clipPath(BSTR* p);
    HRESULT put_clipRule(BSTR v);
    HRESULT get_clipRule(BSTR* p);
    HRESULT put_fill(BSTR v);
    HRESULT get_fill(BSTR* p);
    HRESULT put_fillOpacity(VARIANT v);
    HRESULT get_fillOpacity(VARIANT* p);
    HRESULT put_fillRule(BSTR v);
    HRESULT get_fillRule(BSTR* p);
    HRESULT put_kerning(VARIANT v);
    HRESULT get_kerning(VARIANT* p);
    HRESULT put_marker(BSTR v);
    HRESULT get_marker(BSTR* p);
    HRESULT put_markerEnd(BSTR v);
    HRESULT get_markerEnd(BSTR* p);
    HRESULT put_markerMid(BSTR v);
    HRESULT get_markerMid(BSTR* p);
    HRESULT put_markerStart(BSTR v);
    HRESULT get_markerStart(BSTR* p);
    HRESULT put_mask(BSTR v);
    HRESULT get_mask(BSTR* p);
    HRESULT put_pointerEvents(BSTR v);
    HRESULT get_pointerEvents(BSTR* p);
    HRESULT put_stopColor(VARIANT v);
    HRESULT get_stopColor(VARIANT* p);
    HRESULT put_stopOpacity(VARIANT v);
    HRESULT get_stopOpacity(VARIANT* p);
    HRESULT put_stroke(BSTR v);
    HRESULT get_stroke(BSTR* p);
    HRESULT put_strokeDasharray(BSTR v);
    HRESULT get_strokeDasharray(BSTR* p);
    HRESULT put_strokeDashoffset(VARIANT v);
    HRESULT get_strokeDashoffset(VARIANT* p);
    HRESULT put_strokeLinecap(BSTR v);
    HRESULT get_strokeLinecap(BSTR* p);
    HRESULT put_strokeLinejoin(BSTR v);
    HRESULT get_strokeLinejoin(BSTR* p);
    HRESULT put_strokeMiterlimit(VARIANT v);
    HRESULT get_strokeMiterlimit(VARIANT* p);
    HRESULT put_strokeOpacity(VARIANT v);
    HRESULT get_strokeOpacity(VARIANT* p);
    HRESULT put_strokeWidth(VARIANT v);
    HRESULT get_strokeWidth(VARIANT* p);
    HRESULT put_textAnchor(BSTR v);
    HRESULT get_textAnchor(BSTR* p);
    HRESULT put_glyphOrientationHorizontal(VARIANT v);
    HRESULT get_glyphOrientationHorizontal(VARIANT* p);
    HRESULT put_glyphOrientationVertical(VARIANT v);
    HRESULT get_glyphOrientationVertical(VARIANT* p);
    HRESULT put_borderRadius(BSTR v);
    HRESULT get_borderRadius(BSTR* p);
    HRESULT put_borderTopLeftRadius(BSTR v);
    HRESULT get_borderTopLeftRadius(BSTR* p);
    HRESULT put_borderTopRightRadius(BSTR v);
    HRESULT get_borderTopRightRadius(BSTR* p);
    HRESULT put_borderBottomRightRadius(BSTR v);
    HRESULT get_borderBottomRightRadius(BSTR* p);
    HRESULT put_borderBottomLeftRadius(BSTR v);
    HRESULT get_borderBottomLeftRadius(BSTR* p);
    HRESULT put_clipTop(VARIANT v);
    HRESULT get_clipTop(VARIANT* p);
    HRESULT put_clipRight(VARIANT v);
    HRESULT get_clipRight(VARIANT* p);
    HRESULT get_clipBottom(VARIANT* p);
    HRESULT put_clipLeft(VARIANT v);
    HRESULT get_clipLeft(VARIANT* p);
    HRESULT put_cssFloat(BSTR v);
    HRESULT get_cssFloat(BSTR* p);
    HRESULT put_backgroundClip(BSTR v);
    HRESULT get_backgroundClip(BSTR* p);
    HRESULT put_backgroundOrigin(BSTR v);
    HRESULT get_backgroundOrigin(BSTR* p);
    HRESULT put_backgroundSize(BSTR v);
    HRESULT get_backgroundSize(BSTR* p);
    HRESULT put_boxShadow(BSTR v);
    HRESULT get_boxShadow(BSTR* p);
    HRESULT put_msTransform(BSTR v);
    HRESULT get_msTransform(BSTR* p);
    HRESULT put_msTransformOrigin(BSTR v);
    HRESULT get_msTransformOrigin(BSTR* p);
}

const GUID IID_IHTMLCSSStyleDeclaration2 = {0x305107D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCSSStyleDeclaration2 : IDispatch
{
    HRESULT put_msScrollChaining(BSTR v);
    HRESULT get_msScrollChaining(BSTR* p);
    HRESULT put_msContentZooming(BSTR v);
    HRESULT get_msContentZooming(BSTR* p);
    HRESULT put_msContentZoomSnapType(BSTR v);
    HRESULT get_msContentZoomSnapType(BSTR* p);
    HRESULT put_msScrollRails(BSTR v);
    HRESULT get_msScrollRails(BSTR* p);
    HRESULT put_msContentZoomChaining(BSTR v);
    HRESULT get_msContentZoomChaining(BSTR* p);
    HRESULT put_msScrollSnapType(BSTR v);
    HRESULT get_msScrollSnapType(BSTR* p);
    HRESULT put_msContentZoomLimit(BSTR v);
    HRESULT get_msContentZoomLimit(BSTR* p);
    HRESULT put_msContentZoomSnap(BSTR v);
    HRESULT get_msContentZoomSnap(BSTR* p);
    HRESULT put_msContentZoomSnapPoints(BSTR v);
    HRESULT get_msContentZoomSnapPoints(BSTR* p);
    HRESULT put_msContentZoomLimitMin(VARIANT v);
    HRESULT get_msContentZoomLimitMin(VARIANT* p);
    HRESULT put_msContentZoomLimitMax(VARIANT v);
    HRESULT get_msContentZoomLimitMax(VARIANT* p);
    HRESULT put_msScrollSnapX(BSTR v);
    HRESULT get_msScrollSnapX(BSTR* p);
    HRESULT put_msScrollSnapY(BSTR v);
    HRESULT get_msScrollSnapY(BSTR* p);
    HRESULT put_msScrollSnapPointsX(BSTR v);
    HRESULT get_msScrollSnapPointsX(BSTR* p);
    HRESULT put_msScrollSnapPointsY(BSTR v);
    HRESULT get_msScrollSnapPointsY(BSTR* p);
    HRESULT put_msGridColumn(VARIANT v);
    HRESULT get_msGridColumn(VARIANT* p);
    HRESULT put_msGridColumnAlign(BSTR v);
    HRESULT get_msGridColumnAlign(BSTR* p);
    HRESULT put_msGridColumns(BSTR v);
    HRESULT get_msGridColumns(BSTR* p);
    HRESULT put_msGridColumnSpan(VARIANT v);
    HRESULT get_msGridColumnSpan(VARIANT* p);
    HRESULT put_msGridRow(VARIANT v);
    HRESULT get_msGridRow(VARIANT* p);
    HRESULT put_msGridRowAlign(BSTR v);
    HRESULT get_msGridRowAlign(BSTR* p);
    HRESULT put_msGridRows(BSTR v);
    HRESULT get_msGridRows(BSTR* p);
    HRESULT put_msGridRowSpan(VARIANT v);
    HRESULT get_msGridRowSpan(VARIANT* p);
    HRESULT put_msWrapThrough(BSTR v);
    HRESULT get_msWrapThrough(BSTR* p);
    HRESULT put_msWrapMargin(VARIANT v);
    HRESULT get_msWrapMargin(VARIANT* p);
    HRESULT put_msWrapFlow(BSTR v);
    HRESULT get_msWrapFlow(BSTR* p);
    HRESULT put_msAnimationName(BSTR v);
    HRESULT get_msAnimationName(BSTR* p);
    HRESULT put_msAnimationDuration(BSTR v);
    HRESULT get_msAnimationDuration(BSTR* p);
    HRESULT put_msAnimationTimingFunction(BSTR v);
    HRESULT get_msAnimationTimingFunction(BSTR* p);
    HRESULT put_msAnimationDelay(BSTR v);
    HRESULT get_msAnimationDelay(BSTR* p);
    HRESULT put_msAnimationDirection(BSTR v);
    HRESULT get_msAnimationDirection(BSTR* p);
    HRESULT put_msAnimationPlayState(BSTR v);
    HRESULT get_msAnimationPlayState(BSTR* p);
    HRESULT put_msAnimationIterationCount(BSTR v);
    HRESULT get_msAnimationIterationCount(BSTR* p);
    HRESULT put_msAnimation(BSTR v);
    HRESULT get_msAnimation(BSTR* p);
    HRESULT put_msAnimationFillMode(BSTR v);
    HRESULT get_msAnimationFillMode(BSTR* p);
    HRESULT put_colorInterpolationFilters(BSTR v);
    HRESULT get_colorInterpolationFilters(BSTR* p);
    HRESULT put_columnCount(VARIANT v);
    HRESULT get_columnCount(VARIANT* p);
    HRESULT put_columnWidth(VARIANT v);
    HRESULT get_columnWidth(VARIANT* p);
    HRESULT put_columnGap(VARIANT v);
    HRESULT get_columnGap(VARIANT* p);
    HRESULT put_columnFill(BSTR v);
    HRESULT get_columnFill(BSTR* p);
    HRESULT put_columnSpan(BSTR v);
    HRESULT get_columnSpan(BSTR* p);
    HRESULT put_columns(BSTR v);
    HRESULT get_columns(BSTR* p);
    HRESULT put_columnRule(BSTR v);
    HRESULT get_columnRule(BSTR* p);
    HRESULT put_columnRuleColor(VARIANT v);
    HRESULT get_columnRuleColor(VARIANT* p);
    HRESULT put_columnRuleStyle(BSTR v);
    HRESULT get_columnRuleStyle(BSTR* p);
    HRESULT put_columnRuleWidth(VARIANT v);
    HRESULT get_columnRuleWidth(VARIANT* p);
    HRESULT put_breakBefore(BSTR v);
    HRESULT get_breakBefore(BSTR* p);
    HRESULT put_breakAfter(BSTR v);
    HRESULT get_breakAfter(BSTR* p);
    HRESULT put_breakInside(BSTR v);
    HRESULT get_breakInside(BSTR* p);
    HRESULT put_floodColor(VARIANT v);
    HRESULT get_floodColor(VARIANT* p);
    HRESULT put_floodOpacity(VARIANT v);
    HRESULT get_floodOpacity(VARIANT* p);
    HRESULT put_lightingColor(VARIANT v);
    HRESULT get_lightingColor(VARIANT* p);
    HRESULT put_msScrollLimitXMin(VARIANT v);
    HRESULT get_msScrollLimitXMin(VARIANT* p);
    HRESULT put_msScrollLimitYMin(VARIANT v);
    HRESULT get_msScrollLimitYMin(VARIANT* p);
    HRESULT put_msScrollLimitXMax(VARIANT v);
    HRESULT get_msScrollLimitXMax(VARIANT* p);
    HRESULT put_msScrollLimitYMax(VARIANT v);
    HRESULT get_msScrollLimitYMax(VARIANT* p);
    HRESULT put_msScrollLimit(BSTR v);
    HRESULT get_msScrollLimit(BSTR* p);
    HRESULT put_textShadow(BSTR v);
    HRESULT get_textShadow(BSTR* p);
    HRESULT put_msFlowFrom(BSTR v);
    HRESULT get_msFlowFrom(BSTR* p);
    HRESULT put_msFlowInto(BSTR v);
    HRESULT get_msFlowInto(BSTR* p);
    HRESULT put_msHyphens(BSTR v);
    HRESULT get_msHyphens(BSTR* p);
    HRESULT put_msHyphenateLimitZone(VARIANT v);
    HRESULT get_msHyphenateLimitZone(VARIANT* p);
    HRESULT put_msHyphenateLimitChars(BSTR v);
    HRESULT get_msHyphenateLimitChars(BSTR* p);
    HRESULT put_msHyphenateLimitLines(VARIANT v);
    HRESULT get_msHyphenateLimitLines(VARIANT* p);
    HRESULT put_msHighContrastAdjust(BSTR v);
    HRESULT get_msHighContrastAdjust(BSTR* p);
    HRESULT put_enableBackground(BSTR v);
    HRESULT get_enableBackground(BSTR* p);
    HRESULT put_msFontFeatureSettings(BSTR v);
    HRESULT get_msFontFeatureSettings(BSTR* p);
    HRESULT put_msUserSelect(BSTR v);
    HRESULT get_msUserSelect(BSTR* p);
    HRESULT put_msOverflowStyle(BSTR v);
    HRESULT get_msOverflowStyle(BSTR* p);
    HRESULT put_msTransformStyle(BSTR v);
    HRESULT get_msTransformStyle(BSTR* p);
    HRESULT put_msBackfaceVisibility(BSTR v);
    HRESULT get_msBackfaceVisibility(BSTR* p);
    HRESULT put_msPerspective(VARIANT v);
    HRESULT get_msPerspective(VARIANT* p);
    HRESULT put_msPerspectiveOrigin(BSTR v);
    HRESULT get_msPerspectiveOrigin(BSTR* p);
    HRESULT put_msTransitionProperty(BSTR v);
    HRESULT get_msTransitionProperty(BSTR* p);
    HRESULT put_msTransitionDuration(BSTR v);
    HRESULT get_msTransitionDuration(BSTR* p);
    HRESULT put_msTransitionTimingFunction(BSTR v);
    HRESULT get_msTransitionTimingFunction(BSTR* p);
    HRESULT put_msTransitionDelay(BSTR v);
    HRESULT get_msTransitionDelay(BSTR* p);
    HRESULT put_msTransition(BSTR v);
    HRESULT get_msTransition(BSTR* p);
    HRESULT put_msTouchAction(BSTR v);
    HRESULT get_msTouchAction(BSTR* p);
    HRESULT put_msScrollTranslation(BSTR v);
    HRESULT get_msScrollTranslation(BSTR* p);
    HRESULT put_msFlex(BSTR v);
    HRESULT get_msFlex(BSTR* p);
    HRESULT put_msFlexPositive(VARIANT v);
    HRESULT get_msFlexPositive(VARIANT* p);
    HRESULT put_msFlexNegative(VARIANT v);
    HRESULT get_msFlexNegative(VARIANT* p);
    HRESULT put_msFlexPreferredSize(VARIANT v);
    HRESULT get_msFlexPreferredSize(VARIANT* p);
    HRESULT put_msFlexFlow(BSTR v);
    HRESULT get_msFlexFlow(BSTR* p);
    HRESULT put_msFlexDirection(BSTR v);
    HRESULT get_msFlexDirection(BSTR* p);
    HRESULT put_msFlexWrap(BSTR v);
    HRESULT get_msFlexWrap(BSTR* p);
    HRESULT put_msFlexAlign(BSTR v);
    HRESULT get_msFlexAlign(BSTR* p);
    HRESULT put_msFlexItemAlign(BSTR v);
    HRESULT get_msFlexItemAlign(BSTR* p);
    HRESULT put_msFlexPack(BSTR v);
    HRESULT get_msFlexPack(BSTR* p);
    HRESULT put_msFlexLinePack(BSTR v);
    HRESULT get_msFlexLinePack(BSTR* p);
    HRESULT put_msFlexOrder(VARIANT v);
    HRESULT get_msFlexOrder(VARIANT* p);
    HRESULT put_msTouchSelect(BSTR v);
    HRESULT get_msTouchSelect(BSTR* p);
    HRESULT put_transform(BSTR v);
    HRESULT get_transform(BSTR* p);
    HRESULT put_transformOrigin(BSTR v);
    HRESULT get_transformOrigin(BSTR* p);
    HRESULT put_transformStyle(BSTR v);
    HRESULT get_transformStyle(BSTR* p);
    HRESULT put_backfaceVisibility(BSTR v);
    HRESULT get_backfaceVisibility(BSTR* p);
    HRESULT put_perspective(VARIANT v);
    HRESULT get_perspective(VARIANT* p);
    HRESULT put_perspectiveOrigin(BSTR v);
    HRESULT get_perspectiveOrigin(BSTR* p);
    HRESULT put_transitionProperty(BSTR v);
    HRESULT get_transitionProperty(BSTR* p);
    HRESULT put_transitionDuration(BSTR v);
    HRESULT get_transitionDuration(BSTR* p);
    HRESULT put_transitionTimingFunction(BSTR v);
    HRESULT get_transitionTimingFunction(BSTR* p);
    HRESULT put_transitionDelay(BSTR v);
    HRESULT get_transitionDelay(BSTR* p);
    HRESULT put_transition(BSTR v);
    HRESULT get_transition(BSTR* p);
    HRESULT put_fontFeatureSettings(BSTR v);
    HRESULT get_fontFeatureSettings(BSTR* p);
    HRESULT put_animationName(BSTR v);
    HRESULT get_animationName(BSTR* p);
    HRESULT put_animationDuration(BSTR v);
    HRESULT get_animationDuration(BSTR* p);
    HRESULT put_animationTimingFunction(BSTR v);
    HRESULT get_animationTimingFunction(BSTR* p);
    HRESULT put_animationDelay(BSTR v);
    HRESULT get_animationDelay(BSTR* p);
    HRESULT put_animationDirection(BSTR v);
    HRESULT get_animationDirection(BSTR* p);
    HRESULT put_animationPlayState(BSTR v);
    HRESULT get_animationPlayState(BSTR* p);
    HRESULT put_animationIterationCount(BSTR v);
    HRESULT get_animationIterationCount(BSTR* p);
    HRESULT put_animation(BSTR v);
    HRESULT get_animation(BSTR* p);
    HRESULT put_animationFillMode(BSTR v);
    HRESULT get_animationFillMode(BSTR* p);
}

const GUID IID_IHTMLCSSStyleDeclaration3 = {0x3051085C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051085C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCSSStyleDeclaration3 : IDispatch
{
    HRESULT put_flex(BSTR v);
    HRESULT get_flex(BSTR* p);
    HRESULT put_flexDirection(BSTR v);
    HRESULT get_flexDirection(BSTR* p);
    HRESULT put_flexWrap(BSTR v);
    HRESULT get_flexWrap(BSTR* p);
    HRESULT put_flexFlow(BSTR v);
    HRESULT get_flexFlow(BSTR* p);
    HRESULT put_flexGrow(VARIANT v);
    HRESULT get_flexGrow(VARIANT* p);
    HRESULT put_flexShrink(VARIANT v);
    HRESULT get_flexShrink(VARIANT* p);
    HRESULT put_flexBasis(VARIANT v);
    HRESULT get_flexBasis(VARIANT* p);
    HRESULT put_justifyContent(BSTR v);
    HRESULT get_justifyContent(BSTR* p);
    HRESULT put_alignItems(BSTR v);
    HRESULT get_alignItems(BSTR* p);
    HRESULT put_alignSelf(BSTR v);
    HRESULT get_alignSelf(BSTR* p);
    HRESULT put_alignContent(BSTR v);
    HRESULT get_alignContent(BSTR* p);
    HRESULT put_borderImage(BSTR v);
    HRESULT get_borderImage(BSTR* p);
    HRESULT put_borderImageSource(BSTR v);
    HRESULT get_borderImageSource(BSTR* p);
    HRESULT put_borderImageSlice(BSTR v);
    HRESULT get_borderImageSlice(BSTR* p);
    HRESULT put_borderImageWidth(BSTR v);
    HRESULT get_borderImageWidth(BSTR* p);
    HRESULT put_borderImageOutset(BSTR v);
    HRESULT get_borderImageOutset(BSTR* p);
    HRESULT put_borderImageRepeat(BSTR v);
    HRESULT get_borderImageRepeat(BSTR* p);
    HRESULT put_msImeAlign(BSTR v);
    HRESULT get_msImeAlign(BSTR* p);
    HRESULT put_msTextCombineHorizontal(BSTR v);
    HRESULT get_msTextCombineHorizontal(BSTR* p);
    HRESULT put_touchAction(BSTR v);
    HRESULT get_touchAction(BSTR* p);
}

const GUID IID_IHTMLCSSStyleDeclaration4 = {0xD6100F3B, 0x27C8, 0x4132, [0xAF, 0xEA, 0xF0, 0xE4, 0xB1, 0xE0, 0x00, 0x60]};
@GUID(0xD6100F3B, 0x27C8, 0x4132, [0xAF, 0xEA, 0xF0, 0xE4, 0xB1, 0xE0, 0x00, 0x60]);
interface IHTMLCSSStyleDeclaration4 : IDispatch
{
    HRESULT put_webkitAppearance(BSTR v);
    HRESULT get_webkitAppearance(BSTR* p);
    HRESULT put_webkitUserSelect(BSTR v);
    HRESULT get_webkitUserSelect(BSTR* p);
    HRESULT put_webkitBoxAlign(BSTR v);
    HRESULT get_webkitBoxAlign(BSTR* p);
    HRESULT put_webkitBoxOrdinalGroup(VARIANT v);
    HRESULT get_webkitBoxOrdinalGroup(VARIANT* p);
    HRESULT put_webkitBoxPack(BSTR v);
    HRESULT get_webkitBoxPack(BSTR* p);
    HRESULT put_webkitBoxFlex(VARIANT v);
    HRESULT get_webkitBoxFlex(VARIANT* p);
    HRESULT put_webkitBoxOrient(BSTR v);
    HRESULT get_webkitBoxOrient(BSTR* p);
    HRESULT put_webkitBoxDirection(BSTR v);
    HRESULT get_webkitBoxDirection(BSTR* p);
    HRESULT put_webkitTransform(BSTR v);
    HRESULT get_webkitTransform(BSTR* p);
    HRESULT put_webkitBackgroundSize(BSTR v);
    HRESULT get_webkitBackgroundSize(BSTR* p);
    HRESULT put_webkitBackfaceVisibility(BSTR v);
    HRESULT get_webkitBackfaceVisibility(BSTR* p);
    HRESULT put_webkitAnimation(BSTR v);
    HRESULT get_webkitAnimation(BSTR* p);
    HRESULT put_webkitTransition(BSTR v);
    HRESULT get_webkitTransition(BSTR* p);
    HRESULT put_webkitAnimationName(BSTR v);
    HRESULT get_webkitAnimationName(BSTR* p);
    HRESULT put_webkitAnimationDuration(BSTR v);
    HRESULT get_webkitAnimationDuration(BSTR* p);
    HRESULT put_webkitAnimationTimingFunction(BSTR v);
    HRESULT get_webkitAnimationTimingFunction(BSTR* p);
    HRESULT put_webkitAnimationDelay(BSTR v);
    HRESULT get_webkitAnimationDelay(BSTR* p);
    HRESULT put_webkitAnimationIterationCount(BSTR v);
    HRESULT get_webkitAnimationIterationCount(BSTR* p);
    HRESULT put_webkitAnimationDirection(BSTR v);
    HRESULT get_webkitAnimationDirection(BSTR* p);
    HRESULT put_webkitAnimationPlayState(BSTR v);
    HRESULT get_webkitAnimationPlayState(BSTR* p);
    HRESULT put_webkitTransitionProperty(BSTR v);
    HRESULT get_webkitTransitionProperty(BSTR* p);
    HRESULT put_webkitTransitionDuration(BSTR v);
    HRESULT get_webkitTransitionDuration(BSTR* p);
    HRESULT put_webkitTransitionTimingFunction(BSTR v);
    HRESULT get_webkitTransitionTimingFunction(BSTR* p);
    HRESULT put_webkitTransitionDelay(BSTR v);
    HRESULT get_webkitTransitionDelay(BSTR* p);
    HRESULT put_webkitBackgroundAttachment(BSTR v);
    HRESULT get_webkitBackgroundAttachment(BSTR* p);
    HRESULT put_webkitBackgroundColor(VARIANT v);
    HRESULT get_webkitBackgroundColor(VARIANT* p);
    HRESULT put_webkitBackgroundClip(BSTR v);
    HRESULT get_webkitBackgroundClip(BSTR* p);
    HRESULT put_webkitBackgroundImage(BSTR v);
    HRESULT get_webkitBackgroundImage(BSTR* p);
    HRESULT put_webkitBackgroundRepeat(BSTR v);
    HRESULT get_webkitBackgroundRepeat(BSTR* p);
    HRESULT put_webkitBackgroundOrigin(BSTR v);
    HRESULT get_webkitBackgroundOrigin(BSTR* p);
    HRESULT put_webkitBackgroundPosition(BSTR v);
    HRESULT get_webkitBackgroundPosition(BSTR* p);
    HRESULT put_webkitBackgroundPositionX(VARIANT v);
    HRESULT get_webkitBackgroundPositionX(VARIANT* p);
    HRESULT put_webkitBackgroundPositionY(VARIANT v);
    HRESULT get_webkitBackgroundPositionY(VARIANT* p);
    HRESULT put_webkitBackground(BSTR v);
    HRESULT get_webkitBackground(BSTR* p);
    HRESULT put_webkitTransformOrigin(BSTR v);
    HRESULT get_webkitTransformOrigin(BSTR* p);
    HRESULT put_msTextSizeAdjust(VARIANT v);
    HRESULT get_msTextSizeAdjust(VARIANT* p);
    HRESULT put_webkitTextSizeAdjust(VARIANT v);
    HRESULT get_webkitTextSizeAdjust(VARIANT* p);
    HRESULT put_webkitBorderImage(BSTR v);
    HRESULT get_webkitBorderImage(BSTR* p);
    HRESULT put_webkitBorderImageSource(BSTR v);
    HRESULT get_webkitBorderImageSource(BSTR* p);
    HRESULT put_webkitBorderImageSlice(BSTR v);
    HRESULT get_webkitBorderImageSlice(BSTR* p);
    HRESULT put_webkitBorderImageWidth(BSTR v);
    HRESULT get_webkitBorderImageWidth(BSTR* p);
    HRESULT put_webkitBorderImageOutset(BSTR v);
    HRESULT get_webkitBorderImageOutset(BSTR* p);
    HRESULT put_webkitBorderImageRepeat(BSTR v);
    HRESULT get_webkitBorderImageRepeat(BSTR* p);
    HRESULT put_webkitBoxSizing(BSTR v);
    HRESULT get_webkitBoxSizing(BSTR* p);
    HRESULT put_webkitAnimationFillMode(BSTR v);
    HRESULT get_webkitAnimationFillMode(BSTR* p);
}

const GUID IID_IHTMLStyleEnabled = {0x305104C2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104C2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleEnabled : IDispatch
{
    HRESULT msGetPropertyEnabled(BSTR name, short* p);
    HRESULT msPutPropertyEnabled(BSTR name, short b);
}

const GUID IID_DispHTMLCSSStyleDeclaration = {0x3059009A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059009A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLCSSStyleDeclaration : IDispatch
{
}

const GUID IID_IHTMLStyle = {0x3050F25E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F25E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyle : IDispatch
{
    HRESULT put_fontFamily(BSTR v);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT put_fontStyle(BSTR v);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT put_fontVariant(BSTR v);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT put_fontWeight(BSTR v);
    HRESULT get_fontWeight(BSTR* p);
    HRESULT put_fontSize(VARIANT v);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_backgroundColor(VARIANT v);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT put_backgroundImage(BSTR v);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT put_backgroundRepeat(BSTR v);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT put_backgroundAttachment(BSTR v);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT put_backgroundPosition(BSTR v);
    HRESULT get_backgroundPosition(BSTR* p);
    HRESULT put_backgroundPositionX(VARIANT v);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT put_backgroundPositionY(VARIANT v);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT put_wordSpacing(VARIANT v);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT put_letterSpacing(VARIANT v);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT put_textDecorationNone(short v);
    HRESULT get_textDecorationNone(short* p);
    HRESULT put_textDecorationUnderline(short v);
    HRESULT get_textDecorationUnderline(short* p);
    HRESULT put_textDecorationOverline(short v);
    HRESULT get_textDecorationOverline(short* p);
    HRESULT put_textDecorationLineThrough(short v);
    HRESULT get_textDecorationLineThrough(short* p);
    HRESULT put_textDecorationBlink(short v);
    HRESULT get_textDecorationBlink(short* p);
    HRESULT put_verticalAlign(VARIANT v);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT put_textTransform(BSTR v);
    HRESULT get_textTransform(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textIndent(VARIANT v);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT put_lineHeight(VARIANT v);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT put_marginTop(VARIANT v);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT put_marginRight(VARIANT v);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT put_marginBottom(VARIANT v);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT put_marginLeft(VARIANT v);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT put_margin(BSTR v);
    HRESULT get_margin(BSTR* p);
    HRESULT put_paddingTop(VARIANT v);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT put_paddingRight(VARIANT v);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT put_paddingBottom(VARIANT v);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT put_paddingLeft(VARIANT v);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT put_padding(BSTR v);
    HRESULT get_padding(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderTop(BSTR v);
    HRESULT get_borderTop(BSTR* p);
    HRESULT put_borderRight(BSTR v);
    HRESULT get_borderRight(BSTR* p);
    HRESULT put_borderBottom(BSTR v);
    HRESULT get_borderBottom(BSTR* p);
    HRESULT put_borderLeft(BSTR v);
    HRESULT get_borderLeft(BSTR* p);
    HRESULT put_borderColor(BSTR v);
    HRESULT get_borderColor(BSTR* p);
    HRESULT put_borderTopColor(VARIANT v);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT put_borderRightColor(VARIANT v);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT put_borderBottomColor(VARIANT v);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT put_borderLeftColor(VARIANT v);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT put_borderWidth(BSTR v);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT put_borderTopWidth(VARIANT v);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT put_borderRightWidth(VARIANT v);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT put_borderBottomWidth(VARIANT v);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT put_borderLeftWidth(VARIANT v);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_borderTopStyle(BSTR v);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT put_borderRightStyle(BSTR v);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT put_borderBottomStyle(BSTR v);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT put_borderLeftStyle(BSTR v);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_styleFloat(BSTR v);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
    HRESULT put_display(BSTR v);
    HRESULT get_display(BSTR* p);
    HRESULT put_visibility(BSTR v);
    HRESULT get_visibility(BSTR* p);
    HRESULT put_listStyleType(BSTR v);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT put_listStylePosition(BSTR v);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT put_listStyleImage(BSTR v);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT put_listStyle(BSTR v);
    HRESULT get_listStyle(BSTR* p);
    HRESULT put_whiteSpace(BSTR v);
    HRESULT get_whiteSpace(BSTR* p);
    HRESULT put_top(VARIANT v);
    HRESULT get_top(VARIANT* p);
    HRESULT put_left(VARIANT v);
    HRESULT get_left(VARIANT* p);
    HRESULT get_position(BSTR* p);
    HRESULT put_zIndex(VARIANT v);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT put_overflow(BSTR v);
    HRESULT get_overflow(BSTR* p);
    HRESULT put_pageBreakBefore(BSTR v);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT put_pageBreakAfter(BSTR v);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT put_pixelTop(int v);
    HRESULT get_pixelTop(int* p);
    HRESULT put_pixelLeft(int v);
    HRESULT get_pixelLeft(int* p);
    HRESULT put_pixelWidth(int v);
    HRESULT get_pixelWidth(int* p);
    HRESULT put_pixelHeight(int v);
    HRESULT get_pixelHeight(int* p);
    HRESULT put_posTop(float v);
    HRESULT get_posTop(float* p);
    HRESULT put_posLeft(float v);
    HRESULT get_posLeft(float* p);
    HRESULT put_posWidth(float v);
    HRESULT get_posWidth(float* p);
    HRESULT put_posHeight(float v);
    HRESULT get_posHeight(float* p);
    HRESULT put_cursor(BSTR v);
    HRESULT get_cursor(BSTR* p);
    HRESULT put_clip(BSTR v);
    HRESULT get_clip(BSTR* p);
    HRESULT put_filter(BSTR v);
    HRESULT get_filter(BSTR* p);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, short* pfSuccess);
    HRESULT toString(BSTR* String);
}

const GUID IID_IHTMLStyle2 = {0x3050F4A2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4A2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyle2 : IDispatch
{
    HRESULT put_tableLayout(BSTR v);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT put_borderCollapse(BSTR v);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT setExpression(BSTR propname, BSTR expression, BSTR language);
    HRESULT getExpression(BSTR propname, VARIANT* expression);
    HRESULT removeExpression(BSTR propname, short* pfSuccess);
    HRESULT put_position(BSTR v);
    HRESULT get_position(BSTR* p);
    HRESULT put_unicodeBidi(BSTR v);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT put_bottom(VARIANT v);
    HRESULT get_bottom(VARIANT* p);
    HRESULT put_right(VARIANT v);
    HRESULT get_right(VARIANT* p);
    HRESULT put_pixelBottom(int v);
    HRESULT get_pixelBottom(int* p);
    HRESULT put_pixelRight(int v);
    HRESULT get_pixelRight(int* p);
    HRESULT put_posBottom(float v);
    HRESULT get_posBottom(float* p);
    HRESULT put_posRight(float v);
    HRESULT get_posRight(float* p);
    HRESULT put_imeMode(BSTR v);
    HRESULT get_imeMode(BSTR* p);
    HRESULT put_rubyAlign(BSTR v);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT put_rubyPosition(BSTR v);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT put_rubyOverhang(BSTR v);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT put_layoutGridChar(VARIANT v);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT put_layoutGridLine(VARIANT v);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT put_layoutGridMode(BSTR v);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT put_layoutGridType(BSTR v);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT put_layoutGrid(BSTR v);
    HRESULT get_layoutGrid(BSTR* p);
    HRESULT put_wordBreak(BSTR v);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT put_lineBreak(BSTR v);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT put_textJustify(BSTR v);
    HRESULT get_textJustify(BSTR* p);
    HRESULT put_textJustifyTrim(BSTR v);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT put_textKashida(VARIANT v);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT put_textAutospace(BSTR v);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT put_overflowX(BSTR v);
    HRESULT get_overflowX(BSTR* p);
    HRESULT put_overflowY(BSTR v);
    HRESULT get_overflowY(BSTR* p);
    HRESULT put_accelerator(BSTR v);
    HRESULT get_accelerator(BSTR* p);
}

const GUID IID_IHTMLStyle3 = {0x3050F656, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F656, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyle3 : IDispatch
{
    HRESULT put_layoutFlow(BSTR v);
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT put_zoom(VARIANT v);
    HRESULT get_zoom(VARIANT* p);
    HRESULT put_wordWrap(BSTR v);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT put_textUnderlinePosition(BSTR v);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT put_scrollbarBaseColor(VARIANT v);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT put_scrollbarFaceColor(VARIANT v);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT put_scrollbar3dLightColor(VARIANT v);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT put_scrollbarShadowColor(VARIANT v);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT put_scrollbarHighlightColor(VARIANT v);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT put_scrollbarDarkShadowColor(VARIANT v);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT put_scrollbarArrowColor(VARIANT v);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT put_scrollbarTrackColor(VARIANT v);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT put_writingMode(BSTR v);
    HRESULT get_writingMode(BSTR* p);
    HRESULT put_textAlignLast(BSTR v);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT put_textKashidaSpace(VARIANT v);
    HRESULT get_textKashidaSpace(VARIANT* p);
}

const GUID IID_IHTMLStyle4 = {0x3050F816, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F816, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyle4 : IDispatch
{
    HRESULT put_textOverflow(BSTR v);
    HRESULT get_textOverflow(BSTR* p);
    HRESULT put_minHeight(VARIANT v);
    HRESULT get_minHeight(VARIANT* p);
}

const GUID IID_IHTMLStyle5 = {0x3050F33A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F33A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyle5 : IDispatch
{
    HRESULT put_msInterpolationMode(BSTR v);
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT put_maxHeight(VARIANT v);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT put_minWidth(VARIANT v);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT put_maxWidth(VARIANT v);
    HRESULT get_maxWidth(VARIANT* p);
}

const GUID IID_IHTMLStyle6 = {0x30510480, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510480, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyle6 : IDispatch
{
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_captionSide(BSTR v);
    HRESULT get_captionSide(BSTR* p);
    HRESULT put_counterIncrement(BSTR v);
    HRESULT get_counterIncrement(BSTR* p);
    HRESULT put_counterReset(BSTR v);
    HRESULT get_counterReset(BSTR* p);
    HRESULT put_outline(BSTR v);
    HRESULT get_outline(BSTR* p);
    HRESULT put_outlineWidth(VARIANT v);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT put_outlineStyle(BSTR v);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT put_outlineColor(VARIANT v);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT put_boxSizing(BSTR v);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT put_borderSpacing(BSTR v);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT put_orphans(VARIANT v);
    HRESULT get_orphans(VARIANT* p);
    HRESULT put_widows(VARIANT v);
    HRESULT get_widows(VARIANT* p);
    HRESULT put_pageBreakInside(BSTR v);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT put_emptyCells(BSTR v);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT put_msBlockProgression(BSTR v);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT put_quotes(BSTR v);
    HRESULT get_quotes(BSTR* p);
}

const GUID IID_IHTMLRuleStyle = {0x3050F3CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLRuleStyle : IDispatch
{
    HRESULT put_fontFamily(BSTR v);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT put_fontStyle(BSTR v);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT put_fontVariant(BSTR v);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT put_fontWeight(BSTR v);
    HRESULT get_fontWeight(BSTR* p);
    HRESULT put_fontSize(VARIANT v);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_backgroundColor(VARIANT v);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT put_backgroundImage(BSTR v);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT put_backgroundRepeat(BSTR v);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT put_backgroundAttachment(BSTR v);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT put_backgroundPosition(BSTR v);
    HRESULT get_backgroundPosition(BSTR* p);
    HRESULT put_backgroundPositionX(VARIANT v);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT put_backgroundPositionY(VARIANT v);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT put_wordSpacing(VARIANT v);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT put_letterSpacing(VARIANT v);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT put_textDecorationNone(short v);
    HRESULT get_textDecorationNone(short* p);
    HRESULT put_textDecorationUnderline(short v);
    HRESULT get_textDecorationUnderline(short* p);
    HRESULT put_textDecorationOverline(short v);
    HRESULT get_textDecorationOverline(short* p);
    HRESULT put_textDecorationLineThrough(short v);
    HRESULT get_textDecorationLineThrough(short* p);
    HRESULT put_textDecorationBlink(short v);
    HRESULT get_textDecorationBlink(short* p);
    HRESULT put_verticalAlign(VARIANT v);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT put_textTransform(BSTR v);
    HRESULT get_textTransform(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textIndent(VARIANT v);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT put_lineHeight(VARIANT v);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT put_marginTop(VARIANT v);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT put_marginRight(VARIANT v);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT put_marginBottom(VARIANT v);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT put_marginLeft(VARIANT v);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT put_margin(BSTR v);
    HRESULT get_margin(BSTR* p);
    HRESULT put_paddingTop(VARIANT v);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT put_paddingRight(VARIANT v);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT put_paddingBottom(VARIANT v);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT put_paddingLeft(VARIANT v);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT put_padding(BSTR v);
    HRESULT get_padding(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderTop(BSTR v);
    HRESULT get_borderTop(BSTR* p);
    HRESULT put_borderRight(BSTR v);
    HRESULT get_borderRight(BSTR* p);
    HRESULT put_borderBottom(BSTR v);
    HRESULT get_borderBottom(BSTR* p);
    HRESULT put_borderLeft(BSTR v);
    HRESULT get_borderLeft(BSTR* p);
    HRESULT put_borderColor(BSTR v);
    HRESULT get_borderColor(BSTR* p);
    HRESULT put_borderTopColor(VARIANT v);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT put_borderRightColor(VARIANT v);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT put_borderBottomColor(VARIANT v);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT put_borderLeftColor(VARIANT v);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT put_borderWidth(BSTR v);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT put_borderTopWidth(VARIANT v);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT put_borderRightWidth(VARIANT v);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT put_borderBottomWidth(VARIANT v);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT put_borderLeftWidth(VARIANT v);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_borderTopStyle(BSTR v);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT put_borderRightStyle(BSTR v);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT put_borderBottomStyle(BSTR v);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT put_borderLeftStyle(BSTR v);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_styleFloat(BSTR v);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
    HRESULT put_display(BSTR v);
    HRESULT get_display(BSTR* p);
    HRESULT put_visibility(BSTR v);
    HRESULT get_visibility(BSTR* p);
    HRESULT put_listStyleType(BSTR v);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT put_listStylePosition(BSTR v);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT put_listStyleImage(BSTR v);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT put_listStyle(BSTR v);
    HRESULT get_listStyle(BSTR* p);
    HRESULT put_whiteSpace(BSTR v);
    HRESULT get_whiteSpace(BSTR* p);
    HRESULT put_top(VARIANT v);
    HRESULT get_top(VARIANT* p);
    HRESULT put_left(VARIANT v);
    HRESULT get_left(VARIANT* p);
    HRESULT get_position(BSTR* p);
    HRESULT put_zIndex(VARIANT v);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT put_overflow(BSTR v);
    HRESULT get_overflow(BSTR* p);
    HRESULT put_pageBreakBefore(BSTR v);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT put_pageBreakAfter(BSTR v);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT put_cursor(BSTR v);
    HRESULT get_cursor(BSTR* p);
    HRESULT put_clip(BSTR v);
    HRESULT get_clip(BSTR* p);
    HRESULT put_filter(BSTR v);
    HRESULT get_filter(BSTR* p);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, short* pfSuccess);
}

const GUID IID_IHTMLRuleStyle2 = {0x3050F4AC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4AC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLRuleStyle2 : IDispatch
{
    HRESULT put_tableLayout(BSTR v);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT put_borderCollapse(BSTR v);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT put_position(BSTR v);
    HRESULT get_position(BSTR* p);
    HRESULT put_unicodeBidi(BSTR v);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT put_bottom(VARIANT v);
    HRESULT get_bottom(VARIANT* p);
    HRESULT put_right(VARIANT v);
    HRESULT get_right(VARIANT* p);
    HRESULT put_pixelBottom(int v);
    HRESULT get_pixelBottom(int* p);
    HRESULT put_pixelRight(int v);
    HRESULT get_pixelRight(int* p);
    HRESULT put_posBottom(float v);
    HRESULT get_posBottom(float* p);
    HRESULT put_posRight(float v);
    HRESULT get_posRight(float* p);
    HRESULT put_imeMode(BSTR v);
    HRESULT get_imeMode(BSTR* p);
    HRESULT put_rubyAlign(BSTR v);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT put_rubyPosition(BSTR v);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT put_rubyOverhang(BSTR v);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT put_layoutGridChar(VARIANT v);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT put_layoutGridLine(VARIANT v);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT put_layoutGridMode(BSTR v);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT put_layoutGridType(BSTR v);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT put_layoutGrid(BSTR v);
    HRESULT get_layoutGrid(BSTR* p);
    HRESULT put_textAutospace(BSTR v);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT put_wordBreak(BSTR v);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT put_lineBreak(BSTR v);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT put_textJustify(BSTR v);
    HRESULT get_textJustify(BSTR* p);
    HRESULT put_textJustifyTrim(BSTR v);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT put_textKashida(VARIANT v);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT put_overflowX(BSTR v);
    HRESULT get_overflowX(BSTR* p);
    HRESULT put_overflowY(BSTR v);
    HRESULT get_overflowY(BSTR* p);
    HRESULT put_accelerator(BSTR v);
    HRESULT get_accelerator(BSTR* p);
}

const GUID IID_IHTMLRuleStyle3 = {0x3050F657, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F657, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLRuleStyle3 : IDispatch
{
    HRESULT put_layoutFlow(BSTR v);
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT put_zoom(VARIANT v);
    HRESULT get_zoom(VARIANT* p);
    HRESULT put_wordWrap(BSTR v);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT put_textUnderlinePosition(BSTR v);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT put_scrollbarBaseColor(VARIANT v);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT put_scrollbarFaceColor(VARIANT v);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT put_scrollbar3dLightColor(VARIANT v);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT put_scrollbarShadowColor(VARIANT v);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT put_scrollbarHighlightColor(VARIANT v);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT put_scrollbarDarkShadowColor(VARIANT v);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT put_scrollbarArrowColor(VARIANT v);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT put_scrollbarTrackColor(VARIANT v);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT put_writingMode(BSTR v);
    HRESULT get_writingMode(BSTR* p);
    HRESULT put_textAlignLast(BSTR v);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT put_textKashidaSpace(VARIANT v);
    HRESULT get_textKashidaSpace(VARIANT* p);
}

const GUID IID_IHTMLRuleStyle4 = {0x3050F817, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F817, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLRuleStyle4 : IDispatch
{
    HRESULT put_textOverflow(BSTR v);
    HRESULT get_textOverflow(BSTR* p);
    HRESULT put_minHeight(VARIANT v);
    HRESULT get_minHeight(VARIANT* p);
}

const GUID IID_IHTMLRuleStyle5 = {0x3050F335, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F335, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLRuleStyle5 : IDispatch
{
    HRESULT put_msInterpolationMode(BSTR v);
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT put_maxHeight(VARIANT v);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT put_minWidth(VARIANT v);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT put_maxWidth(VARIANT v);
    HRESULT get_maxWidth(VARIANT* p);
}

const GUID IID_IHTMLRuleStyle6 = {0x30510471, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510471, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLRuleStyle6 : IDispatch
{
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_captionSide(BSTR v);
    HRESULT get_captionSide(BSTR* p);
    HRESULT put_counterIncrement(BSTR v);
    HRESULT get_counterIncrement(BSTR* p);
    HRESULT put_counterReset(BSTR v);
    HRESULT get_counterReset(BSTR* p);
    HRESULT put_outline(BSTR v);
    HRESULT get_outline(BSTR* p);
    HRESULT put_outlineWidth(VARIANT v);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT put_outlineStyle(BSTR v);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT put_outlineColor(VARIANT v);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT put_boxSizing(BSTR v);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT put_borderSpacing(BSTR v);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT put_orphans(VARIANT v);
    HRESULT get_orphans(VARIANT* p);
    HRESULT put_widows(VARIANT v);
    HRESULT get_widows(VARIANT* p);
    HRESULT put_pageBreakInside(BSTR v);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT put_emptyCells(BSTR v);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT put_msBlockProgression(BSTR v);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT put_quotes(BSTR v);
    HRESULT get_quotes(BSTR* p);
}

const GUID IID_DispHTMLStyle = {0x3050F55A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F55A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyle : IDispatch
{
}

const GUID IID_DispHTMLRuleStyle = {0x3050F55C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F55C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLRuleStyle : IDispatch
{
}

const GUID IID_IHTMLStyleSheetRulesCollection = {0x3050F2E5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2E5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetRulesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLStyleSheetRule* ppHTMLStyleSheetRule);
}

const GUID IID_IHTMLStyleSheet = {0x3050F2E3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2E3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheet : IDispatch
{
    HRESULT put_title(BSTR v);
    HRESULT get_title(BSTR* p);
    HRESULT get_parentStyleSheet(IHTMLStyleSheet* p);
    HRESULT get_owningElement(IHTMLElement* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_readOnly(short* p);
    HRESULT get_imports(IHTMLStyleSheetsCollection* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT get_type(BSTR* p);
    HRESULT get_id(BSTR* p);
    HRESULT addImport(BSTR bstrURL, int lIndex, int* plIndex);
    HRESULT addRule(BSTR bstrSelector, BSTR bstrStyle, int lIndex, int* plNewIndex);
    HRESULT removeImport(int lIndex);
    HRESULT removeRule(int lIndex);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT get_rules(IHTMLStyleSheetRulesCollection* p);
}

const GUID IID_IHTMLCSSRule = {0x305106E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCSSRule : IDispatch
{
    HRESULT get_type(ushort* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT get_parentRule(IHTMLCSSRule* p);
    HRESULT get_parentStyleSheet(IHTMLStyleSheet* p);
}

const GUID IID_IHTMLCSSImportRule = {0x305106EA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106EA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCSSImportRule : IDispatch
{
    HRESULT get_href(BSTR* p);
    HRESULT put_media(VARIANT v);
    HRESULT get_media(VARIANT* p);
    HRESULT get_styleSheet(IHTMLStyleSheet* p);
}

const GUID IID_IHTMLCSSMediaRule = {0x305106EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCSSMediaRule : IDispatch
{
    HRESULT put_media(VARIANT v);
    HRESULT get_media(VARIANT* p);
    HRESULT get_cssRules(IHTMLStyleSheetRulesCollection* p);
    HRESULT insertRule(BSTR bstrRule, int lIndex, int* plNewIndex);
    HRESULT deleteRule(int lIndex);
}

const GUID IID_IHTMLCSSMediaList = {0x30510731, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510731, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCSSMediaList : IDispatch
{
    HRESULT put_mediaText(BSTR v);
    HRESULT get_mediaText(BSTR* p);
    HRESULT get_length(int* p);
    HRESULT item(int index, BSTR* pbstrMedium);
    HRESULT appendMedium(BSTR bstrMedium);
    HRESULT deleteMedium(BSTR bstrMedium);
}

const GUID IID_IHTMLCSSNamespaceRule = {0x305106EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCSSNamespaceRule : IDispatch
{
    HRESULT get_namespaceURI(BSTR* p);
    HRESULT get_prefix(BSTR* p);
}

const GUID IID_IHTMLMSCSSKeyframeRule = {0x3051080C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051080C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMSCSSKeyframeRule : IDispatch
{
    HRESULT put_keyText(BSTR v);
    HRESULT get_keyText(BSTR* p);
    HRESULT get_style(IHTMLRuleStyle* p);
}

const GUID IID_IHTMLMSCSSKeyframesRule = {0x3051080D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051080D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMSCSSKeyframesRule : IDispatch
{
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT get_cssRules(IHTMLStyleSheetRulesCollection* p);
    HRESULT appendRule(BSTR bstrRule);
    HRESULT deleteRule(BSTR bstrKey);
    HRESULT findRule(BSTR bstrKey, IHTMLMSCSSKeyframeRule* ppMSKeyframeRule);
}

const GUID IID_DispHTMLCSSRule = {0x3059007D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059007D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLCSSRule : IDispatch
{
}

const GUID IID_DispHTMLCSSImportRule = {0x3059007E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059007E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLCSSImportRule : IDispatch
{
}

const GUID IID_DispHTMLCSSMediaRule = {0x3059007F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059007F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLCSSMediaRule : IDispatch
{
}

const GUID IID_DispHTMLCSSMediaList = {0x30590097, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590097, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLCSSMediaList : IDispatch
{
}

const GUID IID_DispHTMLCSSNamespaceRule = {0x30590080, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590080, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLCSSNamespaceRule : IDispatch
{
}

const GUID IID_DispHTMLMSCSSKeyframeRule = {0x305900DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLMSCSSKeyframeRule : IDispatch
{
}

const GUID IID_DispHTMLMSCSSKeyframesRule = {0x305900DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLMSCSSKeyframesRule : IDispatch
{
}

const GUID IID_IHTMLRenderStyle = {0x3050F6AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLRenderStyle : IDispatch
{
    HRESULT put_textLineThroughStyle(BSTR v);
    HRESULT get_textLineThroughStyle(BSTR* p);
    HRESULT put_textUnderlineStyle(BSTR v);
    HRESULT get_textUnderlineStyle(BSTR* p);
    HRESULT put_textEffect(BSTR v);
    HRESULT get_textEffect(BSTR* p);
    HRESULT put_textColor(VARIANT v);
    HRESULT get_textColor(VARIANT* p);
    HRESULT put_textBackgroundColor(VARIANT v);
    HRESULT get_textBackgroundColor(VARIANT* p);
    HRESULT put_textDecorationColor(VARIANT v);
    HRESULT get_textDecorationColor(VARIANT* p);
    HRESULT put_renderingPriority(int v);
    HRESULT get_renderingPriority(int* p);
    HRESULT put_defaultTextSelection(BSTR v);
    HRESULT get_defaultTextSelection(BSTR* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
}

const GUID IID_DispHTMLRenderStyle = {0x3050F58B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F58B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLRenderStyle : IDispatch
{
}

const GUID IID_IHTMLCurrentStyle = {0x3050F3DB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3DB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCurrentStyle : IDispatch
{
    HRESULT get_position(BSTR* p);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT get_color(VARIANT* p);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT get_fontWeight(VARIANT* p);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT get_left(VARIANT* p);
    HRESULT get_top(VARIANT* p);
    HRESULT get_width(VARIANT* p);
    HRESULT get_height(VARIANT* p);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT get_textAlign(BSTR* p);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT get_display(BSTR* p);
    HRESULT get_visibility(BSTR* p);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT get_clear(BSTR* p);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT get_clipTop(VARIANT* p);
    HRESULT get_clipRight(VARIANT* p);
    HRESULT get_clipBottom(VARIANT* p);
    HRESULT get_clipLeft(VARIANT* p);
    HRESULT get_overflow(BSTR* p);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT get_cursor(BSTR* p);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT get_direction(BSTR* p);
    HRESULT get_behavior(BSTR* p);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT get_right(VARIANT* p);
    HRESULT get_bottom(VARIANT* p);
    HRESULT get_imeMode(BSTR* p);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT get_textJustify(BSTR* p);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT get_blockDirection(BSTR* p);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT get_borderColor(BSTR* p);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT get_padding(BSTR* p);
    HRESULT get_margin(BSTR* p);
    HRESULT get_accelerator(BSTR* p);
    HRESULT get_overflowX(BSTR* p);
    HRESULT get_overflowY(BSTR* p);
    HRESULT get_textTransform(BSTR* p);
}

const GUID IID_IHTMLCurrentStyle2 = {0x3050F658, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F658, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCurrentStyle2 : IDispatch
{
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT get_hasLayout(short* p);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT get_writingMode(BSTR* p);
    HRESULT get_zoom(VARIANT* p);
    HRESULT get_filter(BSTR* p);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT get_textKashidaSpace(VARIANT* p);
    HRESULT get_isBlock(short* p);
}

const GUID IID_IHTMLCurrentStyle3 = {0x3050F818, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F818, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCurrentStyle3 : IDispatch
{
    HRESULT get_textOverflow(BSTR* p);
    HRESULT get_minHeight(VARIANT* p);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT get_whiteSpace(BSTR* p);
}

const GUID IID_IHTMLCurrentStyle4 = {0x3050F33B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F33B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCurrentStyle4 : IDispatch
{
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT get_maxWidth(VARIANT* p);
}

const GUID IID_IHTMLCurrentStyle5 = {0x30510481, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510481, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCurrentStyle5 : IDispatch
{
    HRESULT get_captionSide(BSTR* p);
    HRESULT get_outline(BSTR* p);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT get_orphans(VARIANT* p);
    HRESULT get_widows(VARIANT* p);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT get_quotes(BSTR* p);
}

const GUID IID_DispHTMLCurrentStyle = {0x3050F557, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F557, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLCurrentStyle : IDispatch
{
}

const GUID IID_IHTMLElement = {0x3050F1FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElement : IDispatch
{
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, short* pfSuccess);
    HRESULT put_className(BSTR v);
    HRESULT get_className(BSTR* p);
    HRESULT put_id(BSTR v);
    HRESULT get_id(BSTR* p);
    HRESULT get_tagName(BSTR* p);
    HRESULT get_parentElement(IHTMLElement* p);
    HRESULT get_style(IHTMLStyle* p);
    HRESULT put_onhelp(VARIANT v);
    HRESULT get_onhelp(VARIANT* p);
    HRESULT put_onclick(VARIANT v);
    HRESULT get_onclick(VARIANT* p);
    HRESULT put_ondblclick(VARIANT v);
    HRESULT get_ondblclick(VARIANT* p);
    HRESULT put_onkeydown(VARIANT v);
    HRESULT get_onkeydown(VARIANT* p);
    HRESULT put_onkeyup(VARIANT v);
    HRESULT get_onkeyup(VARIANT* p);
    HRESULT put_onkeypress(VARIANT v);
    HRESULT get_onkeypress(VARIANT* p);
    HRESULT put_onmouseout(VARIANT v);
    HRESULT get_onmouseout(VARIANT* p);
    HRESULT put_onmouseover(VARIANT v);
    HRESULT get_onmouseover(VARIANT* p);
    HRESULT put_onmousemove(VARIANT v);
    HRESULT get_onmousemove(VARIANT* p);
    HRESULT put_onmousedown(VARIANT v);
    HRESULT get_onmousedown(VARIANT* p);
    HRESULT put_onmouseup(VARIANT v);
    HRESULT get_onmouseup(VARIANT* p);
    HRESULT get_document(IDispatch* p);
    HRESULT put_title(BSTR v);
    HRESULT get_title(BSTR* p);
    HRESULT put_language(BSTR v);
    HRESULT get_language(BSTR* p);
    HRESULT put_onselectstart(VARIANT v);
    HRESULT get_onselectstart(VARIANT* p);
    HRESULT scrollIntoView(VARIANT varargStart);
    HRESULT contains(IHTMLElement pChild, short* pfResult);
    HRESULT get_sourceIndex(int* p);
    HRESULT get_recordNumber(VARIANT* p);
    HRESULT put_lang(BSTR v);
    HRESULT get_lang(BSTR* p);
    HRESULT get_offsetLeft(int* p);
    HRESULT get_offsetTop(int* p);
    HRESULT get_offsetWidth(int* p);
    HRESULT get_offsetHeight(int* p);
    HRESULT get_offsetParent(IHTMLElement* p);
    HRESULT put_innerHTML(BSTR v);
    HRESULT get_innerHTML(BSTR* p);
    HRESULT put_innerText(BSTR v);
    HRESULT get_innerText(BSTR* p);
    HRESULT put_outerHTML(BSTR v);
    HRESULT get_outerHTML(BSTR* p);
    HRESULT put_outerText(BSTR v);
    HRESULT get_outerText(BSTR* p);
    HRESULT insertAdjacentHTML(BSTR where, BSTR html);
    HRESULT insertAdjacentText(BSTR where, BSTR text);
    HRESULT get_parentTextEdit(IHTMLElement* p);
    HRESULT get_isTextEdit(short* p);
    HRESULT click();
    HRESULT get_filters(IHTMLFiltersCollection* p);
    HRESULT put_ondragstart(VARIANT v);
    HRESULT get_ondragstart(VARIANT* p);
    HRESULT toString(BSTR* String);
    HRESULT put_onbeforeupdate(VARIANT v);
    HRESULT get_onbeforeupdate(VARIANT* p);
    HRESULT put_onafterupdate(VARIANT v);
    HRESULT get_onafterupdate(VARIANT* p);
    HRESULT put_onerrorupdate(VARIANT v);
    HRESULT get_onerrorupdate(VARIANT* p);
    HRESULT put_onrowexit(VARIANT v);
    HRESULT get_onrowexit(VARIANT* p);
    HRESULT put_onrowenter(VARIANT v);
    HRESULT get_onrowenter(VARIANT* p);
    HRESULT put_ondatasetchanged(VARIANT v);
    HRESULT get_ondatasetchanged(VARIANT* p);
    HRESULT put_ondataavailable(VARIANT v);
    HRESULT get_ondataavailable(VARIANT* p);
    HRESULT put_ondatasetcomplete(VARIANT v);
    HRESULT get_ondatasetcomplete(VARIANT* p);
    HRESULT put_onfilterchange(VARIANT v);
    HRESULT get_onfilterchange(VARIANT* p);
    HRESULT get_children(IDispatch* p);
    HRESULT get_all(IDispatch* p);
}

const GUID IID_IHTMLRect = {0x3050F4A3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4A3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLRect : IDispatch
{
    HRESULT put_left(int v);
    HRESULT get_left(int* p);
    HRESULT put_top(int v);
    HRESULT get_top(int* p);
    HRESULT put_right(int v);
    HRESULT get_right(int* p);
    HRESULT put_bottom(int v);
    HRESULT get_bottom(int* p);
}

const GUID IID_IHTMLRect2 = {0x3051076C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051076C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLRect2 : IDispatch
{
    HRESULT get_width(float* p);
    HRESULT get_height(float* p);
}

const GUID IID_IHTMLRectCollection = {0x3050F4A4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4A4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLRectCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

const GUID IID_IHTMLElementCollection = {0x3050F21F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F21F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElementCollection : IDispatch
{
    HRESULT toString(BSTR* String);
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
}

const GUID IID_IHTMLElement2 = {0x3050F434, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F434, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElement2 : IDispatch
{
    HRESULT get_scopeName(BSTR* p);
    HRESULT setCapture(short containerCapture);
    HRESULT releaseCapture();
    HRESULT put_onlosecapture(VARIANT v);
    HRESULT get_onlosecapture(VARIANT* p);
    HRESULT componentFromPoint(int x, int y, BSTR* component);
    HRESULT doScroll(VARIANT component);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
    HRESULT put_ondrag(VARIANT v);
    HRESULT get_ondrag(VARIANT* p);
    HRESULT put_ondragend(VARIANT v);
    HRESULT get_ondragend(VARIANT* p);
    HRESULT put_ondragenter(VARIANT v);
    HRESULT get_ondragenter(VARIANT* p);
    HRESULT put_ondragover(VARIANT v);
    HRESULT get_ondragover(VARIANT* p);
    HRESULT put_ondragleave(VARIANT v);
    HRESULT get_ondragleave(VARIANT* p);
    HRESULT put_ondrop(VARIANT v);
    HRESULT get_ondrop(VARIANT* p);
    HRESULT put_onbeforecut(VARIANT v);
    HRESULT get_onbeforecut(VARIANT* p);
    HRESULT put_oncut(VARIANT v);
    HRESULT get_oncut(VARIANT* p);
    HRESULT put_onbeforecopy(VARIANT v);
    HRESULT get_onbeforecopy(VARIANT* p);
    HRESULT put_oncopy(VARIANT v);
    HRESULT get_oncopy(VARIANT* p);
    HRESULT put_onbeforepaste(VARIANT v);
    HRESULT get_onbeforepaste(VARIANT* p);
    HRESULT put_onpaste(VARIANT v);
    HRESULT get_onpaste(VARIANT* p);
    HRESULT get_currentStyle(IHTMLCurrentStyle* p);
    HRESULT put_onpropertychange(VARIANT v);
    HRESULT get_onpropertychange(VARIANT* p);
    HRESULT getClientRects(IHTMLRectCollection* pRectCol);
    HRESULT getBoundingClientRect(IHTMLRect* pRect);
    HRESULT setExpression(BSTR propname, BSTR expression, BSTR language);
    HRESULT getExpression(BSTR propname, VARIANT* expression);
    HRESULT removeExpression(BSTR propname, short* pfSuccess);
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_onresize(VARIANT v);
    HRESULT get_onresize(VARIANT* p);
    HRESULT blur();
    HRESULT addFilter(IUnknown pUnk);
    HRESULT removeFilter(IUnknown pUnk);
    HRESULT get_clientHeight(int* p);
    HRESULT get_clientWidth(int* p);
    HRESULT get_clientTop(int* p);
    HRESULT get_clientLeft(int* p);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, short* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
    HRESULT get_readyState(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onrowsdelete(VARIANT v);
    HRESULT get_onrowsdelete(VARIANT* p);
    HRESULT put_onrowsinserted(VARIANT v);
    HRESULT get_onrowsinserted(VARIANT* p);
    HRESULT put_oncellchange(VARIANT v);
    HRESULT get_oncellchange(VARIANT* p);
    HRESULT put_dir(BSTR v);
    HRESULT get_dir(BSTR* p);
    HRESULT createControlRange(IDispatch* range);
    HRESULT get_scrollHeight(int* p);
    HRESULT get_scrollWidth(int* p);
    HRESULT put_scrollTop(int v);
    HRESULT get_scrollTop(int* p);
    HRESULT put_scrollLeft(int v);
    HRESULT get_scrollLeft(int* p);
    HRESULT clearAttributes();
    HRESULT mergeAttributes(IHTMLElement mergeThis);
    HRESULT put_oncontextmenu(VARIANT v);
    HRESULT get_oncontextmenu(VARIANT* p);
    HRESULT insertAdjacentElement(BSTR where, IHTMLElement insertedElement, IHTMLElement* inserted);
    HRESULT applyElement(IHTMLElement apply, BSTR where, IHTMLElement* applied);
    HRESULT getAdjacentText(BSTR where, BSTR* text);
    HRESULT replaceAdjacentText(BSTR where, BSTR newText, BSTR* oldText);
    HRESULT get_canHaveChildren(short* p);
    HRESULT addBehavior(BSTR bstrUrl, VARIANT* pvarFactory, int* pCookie);
    HRESULT removeBehavior(int cookie, short* pfResult);
    HRESULT get_runtimeStyle(IHTMLStyle* p);
    HRESULT get_behaviorUrns(IDispatch* p);
    HRESULT put_tagUrn(BSTR v);
    HRESULT get_tagUrn(BSTR* p);
    HRESULT put_onbeforeeditfocus(VARIANT v);
    HRESULT get_onbeforeeditfocus(VARIANT* p);
    HRESULT get_readyStateValue(int* p);
    HRESULT getElementsByTagName(BSTR v, IHTMLElementCollection* pelColl);
}

const GUID IID_IHTMLAttributeCollection3 = {0x30510469, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510469, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAttributeCollection3 : IDispatch
{
    HRESULT getNamedItem(BSTR bstrName, IHTMLDOMAttribute* ppNodeOut);
    HRESULT setNamedItem(IHTMLDOMAttribute pNodeIn, IHTMLDOMAttribute* ppNodeOut);
    HRESULT removeNamedItem(BSTR bstrName, IHTMLDOMAttribute* ppNodeOut);
    HRESULT item(int index, IHTMLDOMAttribute* ppNodeOut);
    HRESULT get_length(int* p);
}

const GUID IID_IDOMDocumentType = {0x30510738, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510738, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMDocumentType : IDispatch
{
    HRESULT get_name(BSTR* p);
    HRESULT get_entities(IDispatch* p);
    HRESULT get_notations(IDispatch* p);
    HRESULT get_publicId(VARIANT* p);
    HRESULT get_systemId(VARIANT* p);
    HRESULT get_internalSubset(VARIANT* p);
}

const GUID IID_IHTMLDocument7 = {0x305104B8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104B8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDocument7 : IDispatch
{
    HRESULT get_defaultView(IHTMLWindow2* p);
    HRESULT createCDATASection(BSTR text, IHTMLDOMNode* newCDATASectionNode);
    HRESULT getSelection(IHTMLSelection* ppIHTMLSelection);
    HRESULT getElementsByTagNameNS(VARIANT* pvarNS, BSTR bstrLocalName, IHTMLElementCollection* pelColl);
    HRESULT createElementNS(VARIANT* pvarNS, BSTR bstrTag, IHTMLElement* newElem);
    HRESULT createAttributeNS(VARIANT* pvarNS, BSTR bstrAttrName, IHTMLDOMAttribute* ppAttribute);
    HRESULT put_onmsthumbnailclick(VARIANT v);
    HRESULT get_onmsthumbnailclick(VARIANT* p);
    HRESULT get_characterSet(BSTR* p);
    HRESULT createElement(BSTR bstrTag, IHTMLElement* newElem);
    HRESULT createAttribute(BSTR bstrAttrName, IHTMLDOMAttribute* ppAttribute);
    HRESULT getElementsByClassName(BSTR v, IHTMLElementCollection* pel);
    HRESULT createProcessingInstruction(BSTR bstrTarget, BSTR bstrData, IDOMProcessingInstruction* newProcessingInstruction);
    HRESULT adoptNode(IHTMLDOMNode pNodeSource, IHTMLDOMNode3* ppNodeDest);
    HRESULT put_onmssitemodejumplistitemremoved(VARIANT v);
    HRESULT get_onmssitemodejumplistitemremoved(VARIANT* p);
    HRESULT get_all(IHTMLElementCollection* p);
    HRESULT get_inputEncoding(BSTR* p);
    HRESULT get_xmlEncoding(BSTR* p);
    HRESULT put_xmlStandalone(short v);
    HRESULT get_xmlStandalone(short* p);
    HRESULT put_xmlVersion(BSTR v);
    HRESULT get_xmlVersion(BSTR* p);
    HRESULT hasAttributes(short* pfHasAttributes);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_oncanplay(VARIANT v);
    HRESULT get_oncanplay(VARIANT* p);
    HRESULT put_oncanplaythrough(VARIANT v);
    HRESULT get_oncanplaythrough(VARIANT* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_ondrag(VARIANT v);
    HRESULT get_ondrag(VARIANT* p);
    HRESULT put_ondragend(VARIANT v);
    HRESULT get_ondragend(VARIANT* p);
    HRESULT put_ondragenter(VARIANT v);
    HRESULT get_ondragenter(VARIANT* p);
    HRESULT put_ondragleave(VARIANT v);
    HRESULT get_ondragleave(VARIANT* p);
    HRESULT put_ondragover(VARIANT v);
    HRESULT get_ondragover(VARIANT* p);
    HRESULT put_ondrop(VARIANT v);
    HRESULT get_ondrop(VARIANT* p);
    HRESULT put_ondurationchange(VARIANT v);
    HRESULT get_ondurationchange(VARIANT* p);
    HRESULT put_onemptied(VARIANT v);
    HRESULT get_onemptied(VARIANT* p);
    HRESULT put_onended(VARIANT v);
    HRESULT get_onended(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_oninput(VARIANT v);
    HRESULT get_oninput(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onloadeddata(VARIANT v);
    HRESULT get_onloadeddata(VARIANT* p);
    HRESULT put_onloadedmetadata(VARIANT v);
    HRESULT get_onloadedmetadata(VARIANT* p);
    HRESULT put_onloadstart(VARIANT v);
    HRESULT get_onloadstart(VARIANT* p);
    HRESULT put_onpause(VARIANT v);
    HRESULT get_onpause(VARIANT* p);
    HRESULT put_onplay(VARIANT v);
    HRESULT get_onplay(VARIANT* p);
    HRESULT put_onplaying(VARIANT v);
    HRESULT get_onplaying(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onratechange(VARIANT v);
    HRESULT get_onratechange(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
    HRESULT put_onseeked(VARIANT v);
    HRESULT get_onseeked(VARIANT* p);
    HRESULT put_onseeking(VARIANT v);
    HRESULT get_onseeking(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onstalled(VARIANT v);
    HRESULT get_onstalled(VARIANT* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onsuspend(VARIANT v);
    HRESULT get_onsuspend(VARIANT* p);
    HRESULT put_ontimeupdate(VARIANT v);
    HRESULT get_ontimeupdate(VARIANT* p);
    HRESULT put_onvolumechange(VARIANT v);
    HRESULT get_onvolumechange(VARIANT* p);
    HRESULT put_onwaiting(VARIANT v);
    HRESULT get_onwaiting(VARIANT* p);
    HRESULT normalize();
    HRESULT importNode(IHTMLDOMNode pNodeSource, short fDeep, IHTMLDOMNode3* ppNodeDest);
    HRESULT get_parentWindow(IHTMLWindow2* p);
    HRESULT putref_body(IHTMLElement v);
    HRESULT get_body(IHTMLElement* p);
    HRESULT get_head(IHTMLElement* p);
}

const GUID IID_IHTMLDOMNode = {0x3050F5DA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5DA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMNode : IDispatch
{
    HRESULT get_nodeType(int* p);
    HRESULT get_parentNode(IHTMLDOMNode* p);
    HRESULT hasChildNodes(short* fChildren);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT get_attributes(IDispatch* p);
    HRESULT insertBefore(IHTMLDOMNode newChild, VARIANT refChild, IHTMLDOMNode* node);
    HRESULT removeChild(IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT replaceChild(IHTMLDOMNode newChild, IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT cloneNode(short fDeep, IHTMLDOMNode* clonedNode);
    HRESULT removeNode(short fDeep, IHTMLDOMNode* removed);
    HRESULT swapNode(IHTMLDOMNode otherNode, IHTMLDOMNode* swappedNode);
    HRESULT replaceNode(IHTMLDOMNode replacement, IHTMLDOMNode* replaced);
    HRESULT appendChild(IHTMLDOMNode newChild, IHTMLDOMNode* node);
    HRESULT get_nodeName(BSTR* p);
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT get_firstChild(IHTMLDOMNode* p);
    HRESULT get_lastChild(IHTMLDOMNode* p);
    HRESULT get_previousSibling(IHTMLDOMNode* p);
    HRESULT get_nextSibling(IHTMLDOMNode* p);
}

const GUID IID_IHTMLDOMNode2 = {0x3050F80B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F80B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMNode2 : IDispatch
{
    HRESULT get_ownerDocument(IDispatch* p);
}

const GUID IID_IHTMLDOMNode3 = {0x305106E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMNode3 : IDispatch
{
    HRESULT put_prefix(VARIANT v);
    HRESULT get_prefix(VARIANT* p);
    HRESULT get_localName(VARIANT* p);
    HRESULT get_namespaceURI(VARIANT* p);
    HRESULT put_textContent(VARIANT v);
    HRESULT get_textContent(VARIANT* p);
    HRESULT isEqualNode(IHTMLDOMNode3 otherNode, short* isEqual);
    HRESULT lookupNamespaceURI(VARIANT* pvarPrefix, VARIANT* pvarNamespaceURI);
    HRESULT lookupPrefix(VARIANT* pvarNamespaceURI, VARIANT* pvarPrefix);
    HRESULT isDefaultNamespace(VARIANT* pvarNamespace, short* pfDefaultNamespace);
    HRESULT appendChild(IHTMLDOMNode newChild, IHTMLDOMNode* node);
    HRESULT insertBefore(IHTMLDOMNode newChild, VARIANT refChild, IHTMLDOMNode* node);
    HRESULT removeChild(IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT replaceChild(IHTMLDOMNode newChild, IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT isSameNode(IHTMLDOMNode3 otherNode, short* isSame);
    HRESULT compareDocumentPosition(IHTMLDOMNode otherNode, ushort* flags);
    HRESULT isSupported(BSTR feature, VARIANT version, short* pfisSupported);
}

const GUID IID_IHTMLDOMAttribute = {0x3050F4B0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4B0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMAttribute : IDispatch
{
    HRESULT get_nodeName(BSTR* p);
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT get_specified(short* p);
}

const GUID IID_IHTMLDOMAttribute2 = {0x3050F810, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F810, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMAttribute2 : IDispatch
{
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_expando(short* p);
    HRESULT get_nodeType(int* p);
    HRESULT get_parentNode(IHTMLDOMNode* p);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT get_firstChild(IHTMLDOMNode* p);
    HRESULT get_lastChild(IHTMLDOMNode* p);
    HRESULT get_previousSibling(IHTMLDOMNode* p);
    HRESULT get_nextSibling(IHTMLDOMNode* p);
    HRESULT get_attributes(IDispatch* p);
    HRESULT get_ownerDocument(IDispatch* p);
    HRESULT insertBefore(IHTMLDOMNode newChild, VARIANT refChild, IHTMLDOMNode* node);
    HRESULT replaceChild(IHTMLDOMNode newChild, IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT removeChild(IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT appendChild(IHTMLDOMNode newChild, IHTMLDOMNode* node);
    HRESULT hasChildNodes(short* fChildren);
    HRESULT cloneNode(short fDeep, IHTMLDOMAttribute* clonedNode);
}

const GUID IID_IHTMLDOMAttribute3 = {0x30510468, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510468, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMAttribute3 : IDispatch
{
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_specified(short* p);
    HRESULT get_ownerElement(IHTMLElement2* p);
}

const GUID IID_IHTMLDOMAttribute4 = {0x305106F9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106F9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMAttribute4 : IDispatch
{
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT get_nodeName(BSTR* p);
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_firstChild(IHTMLDOMNode* p);
    HRESULT get_lastChild(IHTMLDOMNode* p);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT hasAttributes(short* pfHasAttributes);
    HRESULT hasChildNodes(short* fChildren);
    HRESULT normalize();
    HRESULT get_specified(short* p);
}

const GUID IID_IHTMLDOMTextNode = {0x3050F4B1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4B1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMTextNode : IDispatch
{
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
    HRESULT toString(BSTR* String);
    HRESULT get_length(int* p);
    HRESULT splitText(int offset, IHTMLDOMNode* pRetNode);
}

const GUID IID_IHTMLDOMTextNode2 = {0x3050F809, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F809, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMTextNode2 : IDispatch
{
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT appendData(BSTR bstrstring);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
}

const GUID IID_IHTMLDOMTextNode3 = {0x3051073E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051073E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMTextNode3 : IDispatch
{
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
    HRESULT splitText(int offset, IHTMLDOMNode* pRetNode);
    HRESULT get_wholeText(BSTR* p);
    HRESULT replaceWholeText(BSTR bstrText, IHTMLDOMNode* ppRetNode);
    HRESULT hasAttributes(short* pfHasAttributes);
    HRESULT normalize();
}

const GUID IID_IHTMLDOMImplementation = {0x3050F80D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F80D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMImplementation : IDispatch
{
    HRESULT hasFeature(BSTR bstrfeature, VARIANT version, short* pfHasFeature);
}

const GUID IID_IHTMLDOMImplementation2 = {0x3051073C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051073C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMImplementation2 : IDispatch
{
    HRESULT createDocumentType(BSTR bstrQualifiedName, VARIANT* pvarPublicId, VARIANT* pvarSystemId, IDOMDocumentType* newDocumentType);
    HRESULT createDocument(VARIANT* pvarNS, VARIANT* pvarTagName, IDOMDocumentType pDocumentType, IHTMLDocument7* ppnewDocument);
    HRESULT createHTMLDocument(BSTR bstrTitle, IHTMLDocument7* ppnewDocument);
    HRESULT hasFeature(BSTR bstrfeature, VARIANT version, short* pfHasFeature);
}

const GUID IID_DispHTMLDOMAttribute = {0x3050F564, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F564, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDOMAttribute : IDispatch
{
}

const GUID IID_DispHTMLDOMTextNode = {0x3050F565, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F565, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDOMTextNode : IDispatch
{
}

const GUID IID_DispHTMLDOMImplementation = {0x3050F58F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F58F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDOMImplementation : IDispatch
{
}

const GUID IID_IHTMLAttributeCollection = {0x3050F4C3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4C3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAttributeCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* name, IDispatch* pdisp);
}

const GUID IID_IHTMLAttributeCollection2 = {0x3050F80A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F80A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAttributeCollection2 : IDispatch
{
    HRESULT getNamedItem(BSTR bstrName, IHTMLDOMAttribute* newretNode);
    HRESULT setNamedItem(IHTMLDOMAttribute ppNode, IHTMLDOMAttribute* newretNode);
    HRESULT removeNamedItem(BSTR bstrName, IHTMLDOMAttribute* newretNode);
}

const GUID IID_IHTMLAttributeCollection4 = {0x305106FA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106FA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAttributeCollection4 : IDispatch
{
    HRESULT getNamedItemNS(VARIANT* pvarNS, BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT setNamedItemNS(IHTMLDOMAttribute2 pNodeIn, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT removeNamedItemNS(VARIANT* pvarNS, BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT getNamedItem(BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT setNamedItem(IHTMLDOMAttribute2 pNodeIn, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT removeNamedItem(BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT item(int index, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT get_length(int* p);
}

const GUID IID_IHTMLDOMChildrenCollection = {0x3050F5AB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5AB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMChildrenCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, IDispatch* ppItem);
}

const GUID IID_IHTMLDOMChildrenCollection2 = {0x30510791, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510791, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMChildrenCollection2 : IDispatch
{
    HRESULT item(int index, IDispatch* ppItem);
}

const GUID IID_DispHTMLAttributeCollection = {0x3050F56C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F56C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLAttributeCollection : IDispatch
{
}

const GUID IID_DispStaticNodeList = {0x3050F59B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F59B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispStaticNodeList : IDispatch
{
}

const GUID IID_DispDOMChildrenCollection = {0x3050F577, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F577, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMChildrenCollection : IDispatch
{
}

const GUID IID_HTMLElementEvents4 = {0x3051075E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051075E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLElementEvents4 : IDispatch
{
}

const GUID IID_HTMLElementEvents3 = {0x3050F59F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F59F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLElementEvents3 : IDispatch
{
}

const GUID IID_HTMLElementEvents2 = {0x3050F60F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F60F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLElementEvents2 : IDispatch
{
}

const GUID IID_HTMLElementEvents = {0x3050F33C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F33C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLElementEvents : IDispatch
{
}

const GUID IID_IRulesAppliedCollection = {0x305104BE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104BE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IRulesAppliedCollection : IDispatch
{
    HRESULT item(int index, IRulesApplied* ppRulesApplied);
    HRESULT get_length(int* p);
    HRESULT get_element(IHTMLElement* p);
    HRESULT propertyInheritedFrom(BSTR name, IRulesApplied* ppRulesApplied);
    HRESULT get_propertyCount(int* p);
    HRESULT property(int index, BSTR* pbstrProperty);
    HRESULT propertyInheritedTrace(BSTR name, int index, IRulesApplied* ppRulesApplied);
    HRESULT propertyInheritedTraceLength(BSTR name, int* pLength);
}

const GUID IID_IHTMLElement3 = {0x3050F673, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F673, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElement3 : IDispatch
{
    HRESULT mergeAttributes(IHTMLElement mergeThis, VARIANT* pvarFlags);
    HRESULT get_isMultiLine(short* p);
    HRESULT get_canHaveHTML(short* p);
    HRESULT put_onlayoutcomplete(VARIANT v);
    HRESULT get_onlayoutcomplete(VARIANT* p);
    HRESULT put_onpage(VARIANT v);
    HRESULT get_onpage(VARIANT* p);
    HRESULT put_inflateBlock(short v);
    HRESULT get_inflateBlock(short* p);
    HRESULT put_onbeforedeactivate(VARIANT v);
    HRESULT get_onbeforedeactivate(VARIANT* p);
    HRESULT setActive();
    HRESULT put_contentEditable(BSTR v);
    HRESULT get_contentEditable(BSTR* p);
    HRESULT get_isContentEditable(short* p);
    HRESULT put_hideFocus(short v);
    HRESULT get_hideFocus(short* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_isDisabled(short* p);
    HRESULT put_onmove(VARIANT v);
    HRESULT get_onmove(VARIANT* p);
    HRESULT put_oncontrolselect(VARIANT v);
    HRESULT get_oncontrolselect(VARIANT* p);
    HRESULT fireEvent(BSTR bstrEventName, VARIANT* pvarEventObject, short* pfCancelled);
    HRESULT put_onresizestart(VARIANT v);
    HRESULT get_onresizestart(VARIANT* p);
    HRESULT put_onresizeend(VARIANT v);
    HRESULT get_onresizeend(VARIANT* p);
    HRESULT put_onmovestart(VARIANT v);
    HRESULT get_onmovestart(VARIANT* p);
    HRESULT put_onmoveend(VARIANT v);
    HRESULT get_onmoveend(VARIANT* p);
    HRESULT put_onmouseenter(VARIANT v);
    HRESULT get_onmouseenter(VARIANT* p);
    HRESULT put_onmouseleave(VARIANT v);
    HRESULT get_onmouseleave(VARIANT* p);
    HRESULT put_onactivate(VARIANT v);
    HRESULT get_onactivate(VARIANT* p);
    HRESULT put_ondeactivate(VARIANT v);
    HRESULT get_ondeactivate(VARIANT* p);
    HRESULT dragDrop(short* pfRet);
    HRESULT get_glyphMode(int* p);
}

const GUID IID_IHTMLElement4 = {0x3050F80F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F80F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElement4 : IDispatch
{
    HRESULT put_onmousewheel(VARIANT v);
    HRESULT get_onmousewheel(VARIANT* p);
    HRESULT normalize();
    HRESULT getAttributeNode(BSTR bstrname, IHTMLDOMAttribute* ppAttribute);
    HRESULT setAttributeNode(IHTMLDOMAttribute pattr, IHTMLDOMAttribute* ppretAttribute);
    HRESULT removeAttributeNode(IHTMLDOMAttribute pattr, IHTMLDOMAttribute* ppretAttribute);
    HRESULT put_onbeforeactivate(VARIANT v);
    HRESULT get_onbeforeactivate(VARIANT* p);
    HRESULT put_onfocusin(VARIANT v);
    HRESULT get_onfocusin(VARIANT* p);
    HRESULT put_onfocusout(VARIANT v);
    HRESULT get_onfocusout(VARIANT* p);
}

const GUID IID_IElementSelector = {0x30510463, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510463, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementSelector : IDispatch
{
    HRESULT querySelector(BSTR v, IHTMLElement* pel);
    HRESULT querySelectorAll(BSTR v, IHTMLDOMChildrenCollection* pel);
}

const GUID IID_IHTMLElementRender = {0x3050F669, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F669, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElementRender : IUnknown
{
    HRESULT DrawToDC(HDC hDC);
    HRESULT SetDocumentPrinter(BSTR bstrPrinterName, HDC hDC);
}

const GUID IID_IHTMLUniqueName = {0x3050F4D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLUniqueName : IDispatch
{
    HRESULT get_uniqueNumber(int* p);
    HRESULT get_uniqueID(BSTR* p);
}

const GUID IID_IHTMLElement5 = {0x3051045D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051045D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElement5 : IDispatch
{
    HRESULT getAttributeNode(BSTR bstrname, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT setAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT removeAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT hasAttribute(BSTR name, short* pfHasAttribute);
    HRESULT put_role(BSTR v);
    HRESULT get_role(BSTR* p);
    HRESULT put_ariaBusy(BSTR v);
    HRESULT get_ariaBusy(BSTR* p);
    HRESULT put_ariaChecked(BSTR v);
    HRESULT get_ariaChecked(BSTR* p);
    HRESULT put_ariaDisabled(BSTR v);
    HRESULT get_ariaDisabled(BSTR* p);
    HRESULT put_ariaExpanded(BSTR v);
    HRESULT get_ariaExpanded(BSTR* p);
    HRESULT put_ariaHaspopup(BSTR v);
    HRESULT get_ariaHaspopup(BSTR* p);
    HRESULT put_ariaHidden(BSTR v);
    HRESULT get_ariaHidden(BSTR* p);
    HRESULT put_ariaInvalid(BSTR v);
    HRESULT get_ariaInvalid(BSTR* p);
    HRESULT put_ariaMultiselectable(BSTR v);
    HRESULT get_ariaMultiselectable(BSTR* p);
    HRESULT put_ariaPressed(BSTR v);
    HRESULT get_ariaPressed(BSTR* p);
    HRESULT put_ariaReadonly(BSTR v);
    HRESULT get_ariaReadonly(BSTR* p);
    HRESULT put_ariaRequired(BSTR v);
    HRESULT get_ariaRequired(BSTR* p);
    HRESULT put_ariaSecret(BSTR v);
    HRESULT get_ariaSecret(BSTR* p);
    HRESULT put_ariaSelected(BSTR v);
    HRESULT get_ariaSelected(BSTR* p);
    HRESULT getAttribute(BSTR strAttributeName, VARIANT* AttributeValue);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, short* pfSuccess);
    HRESULT get_attributes(IHTMLAttributeCollection3* p);
    HRESULT put_ariaValuenow(BSTR v);
    HRESULT get_ariaValuenow(BSTR* p);
    HRESULT put_ariaPosinset(short v);
    HRESULT get_ariaPosinset(short* p);
    HRESULT put_ariaSetsize(short v);
    HRESULT get_ariaSetsize(short* p);
    HRESULT put_ariaLevel(short v);
    HRESULT get_ariaLevel(short* p);
    HRESULT put_ariaValuemin(BSTR v);
    HRESULT get_ariaValuemin(BSTR* p);
    HRESULT put_ariaValuemax(BSTR v);
    HRESULT get_ariaValuemax(BSTR* p);
    HRESULT put_ariaControls(BSTR v);
    HRESULT get_ariaControls(BSTR* p);
    HRESULT put_ariaDescribedby(BSTR v);
    HRESULT get_ariaDescribedby(BSTR* p);
    HRESULT put_ariaFlowto(BSTR v);
    HRESULT get_ariaFlowto(BSTR* p);
    HRESULT put_ariaLabelledby(BSTR v);
    HRESULT get_ariaLabelledby(BSTR* p);
    HRESULT put_ariaActivedescendant(BSTR v);
    HRESULT get_ariaActivedescendant(BSTR* p);
    HRESULT put_ariaOwns(BSTR v);
    HRESULT get_ariaOwns(BSTR* p);
    HRESULT hasAttributes(short* pfHasAttributes);
    HRESULT put_ariaLive(BSTR v);
    HRESULT get_ariaLive(BSTR* p);
    HRESULT put_ariaRelevant(BSTR v);
    HRESULT get_ariaRelevant(BSTR* p);
}

const GUID IID_IHTMLElement6 = {0x305106F8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106F8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElement6 : IDispatch
{
    HRESULT getAttributeNS(VARIANT* pvarNS, BSTR strAttributeName, VARIANT* AttributeValue);
    HRESULT setAttributeNS(VARIANT* pvarNS, BSTR strAttributeName, VARIANT* pvarAttributeValue);
    HRESULT removeAttributeNS(VARIANT* pvarNS, BSTR strAttributeName);
    HRESULT getAttributeNodeNS(VARIANT* pvarNS, BSTR bstrname, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT setAttributeNodeNS(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT hasAttributeNS(VARIANT* pvarNS, BSTR name, short* pfHasAttribute);
    HRESULT getAttribute(BSTR strAttributeName, VARIANT* AttributeValue);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT* pvarAttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName);
    HRESULT getAttributeNode(BSTR strAttributeName, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT setAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT removeAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT hasAttribute(BSTR name, short* pfHasAttribute);
    HRESULT getElementsByTagNameNS(VARIANT* varNS, BSTR bstrLocalName, IHTMLElementCollection* pelColl);
    HRESULT get_tagName(BSTR* p);
    HRESULT get_nodeName(BSTR* p);
    HRESULT getElementsByClassName(BSTR v, IHTMLElementCollection* pel);
    HRESULT msMatchesSelector(BSTR v, short* pfMatches);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_oncanplay(VARIANT v);
    HRESULT get_oncanplay(VARIANT* p);
    HRESULT put_oncanplaythrough(VARIANT v);
    HRESULT get_oncanplaythrough(VARIANT* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_ondurationchange(VARIANT v);
    HRESULT get_ondurationchange(VARIANT* p);
    HRESULT put_onemptied(VARIANT v);
    HRESULT get_onemptied(VARIANT* p);
    HRESULT put_onended(VARIANT v);
    HRESULT get_onended(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_oninput(VARIANT v);
    HRESULT get_oninput(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onloadeddata(VARIANT v);
    HRESULT get_onloadeddata(VARIANT* p);
    HRESULT put_onloadedmetadata(VARIANT v);
    HRESULT get_onloadedmetadata(VARIANT* p);
    HRESULT put_onloadstart(VARIANT v);
    HRESULT get_onloadstart(VARIANT* p);
    HRESULT put_onpause(VARIANT v);
    HRESULT get_onpause(VARIANT* p);
    HRESULT put_onplay(VARIANT v);
    HRESULT get_onplay(VARIANT* p);
    HRESULT put_onplaying(VARIANT v);
    HRESULT get_onplaying(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onratechange(VARIANT v);
    HRESULT get_onratechange(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT put_onseeked(VARIANT v);
    HRESULT get_onseeked(VARIANT* p);
    HRESULT put_onseeking(VARIANT v);
    HRESULT get_onseeking(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onstalled(VARIANT v);
    HRESULT get_onstalled(VARIANT* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onsuspend(VARIANT v);
    HRESULT get_onsuspend(VARIANT* p);
    HRESULT put_ontimeupdate(VARIANT v);
    HRESULT get_ontimeupdate(VARIANT* p);
    HRESULT put_onvolumechange(VARIANT v);
    HRESULT get_onvolumechange(VARIANT* p);
    HRESULT put_onwaiting(VARIANT v);
    HRESULT get_onwaiting(VARIANT* p);
    HRESULT hasAttributes(short* pfHasAttributes);
}

const GUID IID_IHTMLElement7 = {0x305107AA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107AA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElement7 : IDispatch
{
    HRESULT put_onmspointerdown(VARIANT v);
    HRESULT get_onmspointerdown(VARIANT* p);
    HRESULT put_onmspointermove(VARIANT v);
    HRESULT get_onmspointermove(VARIANT* p);
    HRESULT put_onmspointerup(VARIANT v);
    HRESULT get_onmspointerup(VARIANT* p);
    HRESULT put_onmspointerover(VARIANT v);
    HRESULT get_onmspointerover(VARIANT* p);
    HRESULT put_onmspointerout(VARIANT v);
    HRESULT get_onmspointerout(VARIANT* p);
    HRESULT put_onmspointercancel(VARIANT v);
    HRESULT get_onmspointercancel(VARIANT* p);
    HRESULT put_onmspointerhover(VARIANT v);
    HRESULT get_onmspointerhover(VARIANT* p);
    HRESULT put_onmslostpointercapture(VARIANT v);
    HRESULT get_onmslostpointercapture(VARIANT* p);
    HRESULT put_onmsgotpointercapture(VARIANT v);
    HRESULT get_onmsgotpointercapture(VARIANT* p);
    HRESULT put_onmsgesturestart(VARIANT v);
    HRESULT get_onmsgesturestart(VARIANT* p);
    HRESULT put_onmsgesturechange(VARIANT v);
    HRESULT get_onmsgesturechange(VARIANT* p);
    HRESULT put_onmsgestureend(VARIANT v);
    HRESULT get_onmsgestureend(VARIANT* p);
    HRESULT put_onmsgesturehold(VARIANT v);
    HRESULT get_onmsgesturehold(VARIANT* p);
    HRESULT put_onmsgesturetap(VARIANT v);
    HRESULT get_onmsgesturetap(VARIANT* p);
    HRESULT put_onmsgesturedoubletap(VARIANT v);
    HRESULT get_onmsgesturedoubletap(VARIANT* p);
    HRESULT put_onmsinertiastart(VARIANT v);
    HRESULT get_onmsinertiastart(VARIANT* p);
    HRESULT msSetPointerCapture(int pointerId);
    HRESULT msReleasePointerCapture(int pointerId);
    HRESULT put_onmstransitionstart(VARIANT v);
    HRESULT get_onmstransitionstart(VARIANT* p);
    HRESULT put_onmstransitionend(VARIANT v);
    HRESULT get_onmstransitionend(VARIANT* p);
    HRESULT put_onmsanimationstart(VARIANT v);
    HRESULT get_onmsanimationstart(VARIANT* p);
    HRESULT put_onmsanimationend(VARIANT v);
    HRESULT get_onmsanimationend(VARIANT* p);
    HRESULT put_onmsanimationiteration(VARIANT v);
    HRESULT get_onmsanimationiteration(VARIANT* p);
    HRESULT put_oninvalid(VARIANT v);
    HRESULT get_oninvalid(VARIANT* p);
    HRESULT put_xmsAcceleratorKey(BSTR v);
    HRESULT get_xmsAcceleratorKey(BSTR* p);
    HRESULT put_spellcheck(VARIANT v);
    HRESULT get_spellcheck(VARIANT* p);
    HRESULT put_onmsmanipulationstatechanged(VARIANT v);
    HRESULT get_onmsmanipulationstatechanged(VARIANT* p);
    HRESULT put_oncuechange(VARIANT v);
    HRESULT get_oncuechange(VARIANT* p);
}

const GUID IID_IHTMLElementAppliedStyles = {0x305104BD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104BD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElementAppliedStyles : IDispatch
{
    HRESULT msGetRulesApplied(IRulesAppliedCollection* ppRulesAppliedCollection);
    HRESULT msGetRulesAppliedWithAncestor(VARIANT varContext, IRulesAppliedCollection* ppRulesAppliedCollection);
}

const GUID IID_IElementTraversal = {0x30510736, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510736, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementTraversal : IDispatch
{
    HRESULT get_firstElementChild(IHTMLElement* p);
    HRESULT get_lastElementChild(IHTMLElement* p);
    HRESULT get_previousElementSibling(IHTMLElement* p);
    HRESULT get_nextElementSibling(IHTMLElement* p);
    HRESULT get_childElementCount(int* p);
}

const GUID IID_IHTMLDatabinding = {0x3050F3F2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3F2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDatabinding : IDispatch
{
    HRESULT put_dataFld(BSTR v);
    HRESULT get_dataFld(BSTR* p);
    HRESULT put_dataSrc(BSTR v);
    HRESULT get_dataSrc(BSTR* p);
    HRESULT put_dataFormatAs(BSTR v);
    HRESULT get_dataFormatAs(BSTR* p);
}

const GUID IID_IHTMLDocument = {0x626FC520, 0xA41E, 0x11CF, [0xA7, 0x31, 0x00, 0xA0, 0xC9, 0x08, 0x26, 0x37]};
@GUID(0x626FC520, 0xA41E, 0x11CF, [0xA7, 0x31, 0x00, 0xA0, 0xC9, 0x08, 0x26, 0x37]);
interface IHTMLDocument : IDispatch
{
    HRESULT get_Script(IDispatch* p);
}

const GUID IID_IHTMLElementDefaults = {0x3050F6C9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6C9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElementDefaults : IDispatch
{
    HRESULT get_style(IHTMLStyle* p);
    HRESULT put_tabStop(short v);
    HRESULT get_tabStop(short* p);
    HRESULT put_viewInheritStyle(short v);
    HRESULT get_viewInheritStyle(short* p);
    HRESULT put_viewMasterTab(short v);
    HRESULT get_viewMasterTab(short* p);
    HRESULT put_scrollSegmentX(int v);
    HRESULT get_scrollSegmentX(int* p);
    HRESULT put_scrollSegmentY(int v);
    HRESULT get_scrollSegmentY(int* p);
    HRESULT put_isMultiLine(short v);
    HRESULT get_isMultiLine(short* p);
    HRESULT put_contentEditable(BSTR v);
    HRESULT get_contentEditable(BSTR* p);
    HRESULT put_canHaveHTML(short v);
    HRESULT get_canHaveHTML(short* p);
    HRESULT putref_viewLink(IHTMLDocument v);
    HRESULT get_viewLink(IHTMLDocument* p);
    HRESULT put_frozen(short v);
    HRESULT get_frozen(short* p);
}

const GUID IID_DispHTMLDefaults = {0x3050F58C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F58C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDefaults : IDispatch
{
}

const GUID IID_IHTCDefaultDispatch = {0x3050F4FD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4FD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTCDefaultDispatch : IDispatch
{
    HRESULT get_element(IHTMLElement* p);
    HRESULT createEventObject(IHTMLEventObj* eventObj);
    HRESULT get_defaults(IDispatch* p);
    HRESULT get_document(IDispatch* p);
}

const GUID IID_IHTCPropertyBehavior = {0x3050F5DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTCPropertyBehavior : IDispatch
{
    HRESULT fireChange();
    HRESULT put_value(VARIANT v);
    HRESULT get_value(VARIANT* p);
}

const GUID IID_IHTCMethodBehavior = {0x3050F631, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F631, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTCMethodBehavior : IDispatch
{
}

const GUID IID_IHTCEventBehavior = {0x3050F4FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTCEventBehavior : IDispatch
{
    HRESULT fire(IHTMLEventObj pvar);
}

const GUID IID_IHTCAttachBehavior = {0x3050F5F4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5F4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTCAttachBehavior : IDispatch
{
    HRESULT fireEvent(IDispatch evt);
    HRESULT detachEvent();
}

const GUID IID_IHTCAttachBehavior2 = {0x3050F7EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTCAttachBehavior2 : IDispatch
{
    HRESULT fireEvent(VARIANT evt);
}

const GUID IID_IHTCDescBehavior = {0x3050F5DC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5DC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTCDescBehavior : IDispatch
{
    HRESULT get_urn(BSTR* p);
    HRESULT get_name(BSTR* p);
}

const GUID IID_DispHTCDefaultDispatch = {0x3050F573, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F573, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTCDefaultDispatch : IDispatch
{
}

const GUID IID_DispHTCPropertyBehavior = {0x3050F57F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F57F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTCPropertyBehavior : IDispatch
{
}

const GUID IID_DispHTCMethodBehavior = {0x3050F587, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F587, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTCMethodBehavior : IDispatch
{
}

const GUID IID_DispHTCEventBehavior = {0x3050F574, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F574, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTCEventBehavior : IDispatch
{
}

const GUID IID_DispHTCAttachBehavior = {0x3050F583, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F583, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTCAttachBehavior : IDispatch
{
}

const GUID IID_DispHTCDescBehavior = {0x3050F57E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F57E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTCDescBehavior : IDispatch
{
}

const GUID IID_IHTMLUrnCollection = {0x3050F5E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLUrnCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, BSTR* ppUrn);
}

const GUID IID_DispHTMLUrnCollection = {0x3050F551, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F551, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLUrnCollection : IDispatch
{
}

const GUID IID_IHTMLGenericElement = {0x3050F4B7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4B7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLGenericElement : IDispatch
{
    HRESULT get_recordset(IDispatch* p);
    HRESULT namedRecordset(BSTR dataMember, VARIANT* hierarchy, IDispatch* ppRecordset);
}

const GUID IID_DispHTMLGenericElement = {0x3050F563, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F563, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLGenericElement : IDispatch
{
}

const GUID IID_IHTMLStyleSheetRuleApplied = {0x305104C1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104C1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetRuleApplied : IDispatch
{
    HRESULT get_msSpecificity(int* p);
    HRESULT msGetSpecificity(int index, int* p);
}

const GUID IID_IHTMLStyleSheetRule2 = {0x305106FD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106FD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetRule2 : IDispatch
{
    HRESULT put_selectorText(BSTR v);
    HRESULT get_selectorText(BSTR* p);
}

const GUID IID_IHTMLStyleSheetRulesCollection2 = {0x305106E8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106E8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetRulesCollection2 : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLCSSRule* ppHTMLCSSRule);
}

const GUID IID_DispHTMLStyleSheetRule = {0x3050F50E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F50E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyleSheetRule : IDispatch
{
}

const GUID IID_DispHTMLStyleSheetRulesCollection = {0x3050F52F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F52F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyleSheetRulesCollection : IDispatch
{
}

const GUID IID_IHTMLStyleSheetPage = {0x3050F7EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetPage : IDispatch
{
    HRESULT get_selector(BSTR* p);
    HRESULT get_pseudoClass(BSTR* p);
}

const GUID IID_IHTMLStyleSheetPage2 = {0x305106ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetPage2 : IDispatch
{
    HRESULT put_selectorText(BSTR v);
    HRESULT get_selectorText(BSTR* p);
    HRESULT get_style(IHTMLRuleStyle* p);
}

const GUID IID_IHTMLStyleSheetPagesCollection = {0x3050F7F0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7F0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetPagesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLStyleSheetPage* ppHTMLStyleSheetPage);
}

const GUID IID_DispHTMLStyleSheetPage = {0x3050F540, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F540, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyleSheetPage : IDispatch
{
}

const GUID IID_DispHTMLStyleSheetPagesCollection = {0x3050F543, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F543, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyleSheetPagesCollection : IDispatch
{
}

const GUID IID_IHTMLStyleSheetsCollection = {0x3050F37E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F37E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetsCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

const GUID IID_IHTMLStyleSheet2 = {0x3050F3D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheet2 : IDispatch
{
    HRESULT get_pages(IHTMLStyleSheetPagesCollection* p);
    HRESULT addPageRule(BSTR bstrSelector, BSTR bstrStyle, int lIndex, int* plNewIndex);
}

const GUID IID_IHTMLStyleSheet3 = {0x30510496, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510496, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheet3 : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT get_isAlternate(short* p);
    HRESULT get_isPrefAlternate(short* p);
}

const GUID IID_IHTMLStyleSheet4 = {0x305106F4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106F4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheet4 : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT get_href(VARIANT* p);
    HRESULT get_title(BSTR* p);
    HRESULT get_ownerNode(IHTMLElement* p);
    HRESULT get_ownerRule(IHTMLCSSRule* p);
    HRESULT get_cssRules(IHTMLStyleSheetRulesCollection* p);
    HRESULT get_media(VARIANT* p);
    HRESULT insertRule(BSTR bstrRule, int lIndex, int* plNewIndex);
    HRESULT deleteRule(int lIndex);
}

const GUID IID_DispHTMLStyleSheet = {0x3050F58D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F58D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyleSheet : IDispatch
{
}

const GUID IID_IHTMLStyleSheetsCollection2 = {0x305106E7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106E7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetsCollection2 : IDispatch
{
    HRESULT item(int index, VARIANT* pvarResult);
}

const GUID IID_DispHTMLStyleSheetsCollection = {0x3050F547, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F547, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyleSheetsCollection : IDispatch
{
}

const GUID IID_HTMLLinkElementEvents2 = {0x3050F61D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F61D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLLinkElementEvents2 : IDispatch
{
}

const GUID IID_HTMLLinkElementEvents = {0x3050F3CC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3CC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLLinkElementEvents : IDispatch
{
}

const GUID IID_IHTMLLinkElement = {0x3050F205, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F205, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLLinkElement : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_rel(BSTR v);
    HRESULT get_rel(BSTR* p);
    HRESULT put_rev(BSTR v);
    HRESULT get_rev(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT get_styleSheet(IHTMLStyleSheet* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

const GUID IID_IHTMLLinkElement2 = {0x3050F4E5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4E5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLLinkElement2 : IDispatch
{
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
}

const GUID IID_IHTMLLinkElement3 = {0x3050F81E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F81E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLLinkElement3 : IDispatch
{
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
    HRESULT put_hreflang(BSTR v);
    HRESULT get_hreflang(BSTR* p);
}

const GUID IID_IHTMLLinkElement4 = {0x3051043A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051043A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLLinkElement4 : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

const GUID IID_IHTMLLinkElement5 = {0x30510726, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510726, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLLinkElement5 : IDispatch
{
    HRESULT get_sheet(IHTMLStyleSheet* p);
}

const GUID IID_DispHTMLLinkElement = {0x3050F524, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F524, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLLinkElement : IDispatch
{
}

const GUID IID_IHTMLTxtRange = {0x3050F220, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F220, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTxtRange : IDispatch
{
    HRESULT get_htmlText(BSTR* p);
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT parentElement(IHTMLElement* parent);
    HRESULT duplicate(IHTMLTxtRange* Duplicate);
    HRESULT inRange(IHTMLTxtRange Range, short* InRange);
    HRESULT isEqual(IHTMLTxtRange Range, short* IsEqual);
    HRESULT scrollIntoView(short fStart);
    HRESULT collapse(short Start);
    HRESULT expand(BSTR Unit, short* Success);
    HRESULT move(BSTR Unit, int Count, int* ActualCount);
    HRESULT moveStart(BSTR Unit, int Count, int* ActualCount);
    HRESULT moveEnd(BSTR Unit, int Count, int* ActualCount);
    HRESULT select();
    HRESULT pasteHTML(BSTR html);
    HRESULT moveToElementText(IHTMLElement element);
    HRESULT setEndPoint(BSTR how, IHTMLTxtRange SourceRange);
    HRESULT compareEndPoints(BSTR how, IHTMLTxtRange SourceRange, int* ret);
    HRESULT findText(BSTR String, int count, int Flags, short* Success);
    HRESULT moveToPoint(int x, int y);
    HRESULT getBookmark(BSTR* Boolmark);
    HRESULT moveToBookmark(BSTR Bookmark, short* Success);
    HRESULT queryCommandSupported(BSTR cmdID, short* pfRet);
    HRESULT queryCommandEnabled(BSTR cmdID, short* pfRet);
    HRESULT queryCommandState(BSTR cmdID, short* pfRet);
    HRESULT queryCommandIndeterm(BSTR cmdID, short* pfRet);
    HRESULT queryCommandText(BSTR cmdID, BSTR* pcmdText);
    HRESULT queryCommandValue(BSTR cmdID, VARIANT* pcmdValue);
    HRESULT execCommand(BSTR cmdID, short showUI, VARIANT value, short* pfRet);
    HRESULT execCommandShowHelp(BSTR cmdID, short* pfRet);
}

const GUID IID_IHTMLTextRangeMetrics = {0x3050F40B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F40B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTextRangeMetrics : IDispatch
{
    HRESULT get_offsetTop(int* p);
    HRESULT get_offsetLeft(int* p);
    HRESULT get_boundingTop(int* p);
    HRESULT get_boundingLeft(int* p);
    HRESULT get_boundingWidth(int* p);
    HRESULT get_boundingHeight(int* p);
}

const GUID IID_IHTMLTextRangeMetrics2 = {0x3050F4A6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4A6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTextRangeMetrics2 : IDispatch
{
    HRESULT getClientRects(IHTMLRectCollection* pRectCol);
    HRESULT getBoundingClientRect(IHTMLRect* pRect);
}

const GUID IID_IHTMLTxtRangeCollection = {0x3050F7ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTxtRangeCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

const GUID IID_IHTMLDOMRange = {0x305104AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMRange : IDispatch
{
    HRESULT get_startContainer(IHTMLDOMNode* p);
    HRESULT get_startOffset(int* p);
    HRESULT get_endContainer(IHTMLDOMNode* p);
    HRESULT get_endOffset(int* p);
    HRESULT get_collapsed(short* p);
    HRESULT get_commonAncestorContainer(IHTMLDOMNode* p);
    HRESULT setStart(IDispatch refNode, int offset);
    HRESULT setEnd(IDispatch refNode, int offset);
    HRESULT setStartBefore(IDispatch refNode);
    HRESULT setStartAfter(IDispatch refNode);
    HRESULT setEndBefore(IDispatch refNode);
    HRESULT setEndAfter(IDispatch refNode);
    HRESULT collapse(short toStart);
    HRESULT selectNode(IDispatch refNode);
    HRESULT selectNodeContents(IDispatch refNode);
    HRESULT compareBoundaryPoints(short how, IDispatch sourceRange, int* compareResult);
    HRESULT deleteContents();
    HRESULT extractContents(IDispatch* ppDocumentFragment);
    HRESULT cloneContents(IDispatch* ppDocumentFragment);
    HRESULT insertNode(IDispatch newNode);
    HRESULT surroundContents(IDispatch newParent);
    HRESULT cloneRange(IHTMLDOMRange* ppClonedRange);
    HRESULT toString(BSTR* pRangeString);
    HRESULT detach();
    HRESULT getClientRects(IHTMLRectCollection* ppRectCol);
    HRESULT getBoundingClientRect(IHTMLRect* ppRect);
}

const GUID IID_DispHTMLDOMRange = {0x3050F5A3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5A3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDOMRange : IDispatch
{
}

const GUID IID_HTMLFormElementEvents2 = {0x3050F614, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F614, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLFormElementEvents2 : IDispatch
{
}

const GUID IID_HTMLFormElementEvents = {0x3050F364, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F364, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLFormElementEvents : IDispatch
{
}

const GUID IID_IHTMLFormElement = {0x3050F1F7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1F7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFormElement : IDispatch
{
    HRESULT put_action(BSTR v);
    HRESULT get_action(BSTR* p);
    HRESULT put_dir(BSTR v);
    HRESULT get_dir(BSTR* p);
    HRESULT put_encoding(BSTR v);
    HRESULT get_encoding(BSTR* p);
    HRESULT put_method(BSTR v);
    HRESULT get_method(BSTR* p);
    HRESULT get_elements(IDispatch* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT submit();
    HRESULT reset();
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
}

const GUID IID_IHTMLFormElement2 = {0x3050F4F6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4F6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFormElement2 : IDispatch
{
    HRESULT put_acceptCharset(BSTR v);
    HRESULT get_acceptCharset(BSTR* p);
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

const GUID IID_IHTMLFormElement3 = {0x3050F836, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F836, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFormElement3 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

const GUID IID_IHTMLSubmitData = {0x3050F645, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F645, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSubmitData : IDispatch
{
    HRESULT appendNameValuePair(BSTR name, BSTR value);
    HRESULT appendNameFilePair(BSTR name, BSTR filename);
    HRESULT appendItemSeparator();
}

const GUID IID_IHTMLFormElement4 = {0x3051042C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051042C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFormElement4 : IDispatch
{
    HRESULT put_action(BSTR v);
    HRESULT get_action(BSTR* p);
}

const GUID IID_DispHTMLFormElement = {0x3050F510, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F510, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLFormElement : IDispatch
{
}

const GUID IID_HTMLControlElementEvents2 = {0x3050F612, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F612, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLControlElementEvents2 : IDispatch
{
}

const GUID IID_HTMLControlElementEvents = {0x3050F4EA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4EA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLControlElementEvents : IDispatch
{
}

const GUID IID_IHTMLControlElement = {0x3050F4E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLControlElement : IDispatch
{
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_onresize(VARIANT v);
    HRESULT get_onresize(VARIANT* p);
    HRESULT blur();
    HRESULT addFilter(IUnknown pUnk);
    HRESULT removeFilter(IUnknown pUnk);
    HRESULT get_clientHeight(int* p);
    HRESULT get_clientWidth(int* p);
    HRESULT get_clientTop(int* p);
    HRESULT get_clientLeft(int* p);
}

const GUID IID_IHTMLTextElement = {0x3050F218, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F218, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTextElement : IDispatch
{
}

const GUID IID_DispHTMLTextElement = {0x3050F537, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F537, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLTextElement : IDispatch
{
}

const GUID IID_HTMLTextContainerEvents2 = {0x3050F624, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F624, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLTextContainerEvents2 : IDispatch
{
}

const GUID IID_HTMLTextContainerEvents = {0x1FF6AA72, 0x5842, 0x11CF, [0xA7, 0x07, 0x00, 0xAA, 0x00, 0xC0, 0x09, 0x8D]};
@GUID(0x1FF6AA72, 0x5842, 0x11CF, [0xA7, 0x07, 0x00, 0xAA, 0x00, 0xC0, 0x09, 0x8D]);
interface HTMLTextContainerEvents : IDispatch
{
}

const GUID IID_IHTMLTextContainer = {0x3050F230, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F230, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTextContainer : IDispatch
{
    HRESULT createControlRange(IDispatch* range);
    HRESULT get_scrollHeight(int* p);
    HRESULT get_scrollWidth(int* p);
    HRESULT put_scrollTop(int v);
    HRESULT get_scrollTop(int* p);
    HRESULT put_scrollLeft(int v);
    HRESULT get_scrollLeft(int* p);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
}

const GUID IID_IHTMLControlRange = {0x3050F29C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F29C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLControlRange : IDispatch
{
    HRESULT select();
    HRESULT add(IHTMLControlElement item);
    HRESULT remove(int index);
    HRESULT item(int index, IHTMLElement* pdisp);
    HRESULT scrollIntoView(VARIANT varargStart);
    HRESULT queryCommandSupported(BSTR cmdID, short* pfRet);
    HRESULT queryCommandEnabled(BSTR cmdID, short* pfRet);
    HRESULT queryCommandState(BSTR cmdID, short* pfRet);
    HRESULT queryCommandIndeterm(BSTR cmdID, short* pfRet);
    HRESULT queryCommandText(BSTR cmdID, BSTR* pcmdText);
    HRESULT queryCommandValue(BSTR cmdID, VARIANT* pcmdValue);
    HRESULT execCommand(BSTR cmdID, short showUI, VARIANT value, short* pfRet);
    HRESULT execCommandShowHelp(BSTR cmdID, short* pfRet);
    HRESULT commonParentElement(IHTMLElement* parent);
    HRESULT get_length(int* p);
}

const GUID IID_IHTMLControlRange2 = {0x3050F65E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F65E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLControlRange2 : IDispatch
{
    HRESULT addElement(IHTMLElement item);
}

const GUID IID_HTMLImgEvents2 = {0x3050F616, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F616, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLImgEvents2 : IDispatch
{
}

const GUID IID_HTMLImgEvents = {0x3050F25B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F25B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLImgEvents : IDispatch
{
}

const GUID IID_IHTMLImgElement = {0x3050F240, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F240, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLImgElement : IDispatch
{
    HRESULT put_isMap(short v);
    HRESULT get_isMap(short* p);
    HRESULT put_useMap(BSTR v);
    HRESULT get_useMap(BSTR* p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_fileSize(BSTR* p);
    HRESULT get_fileCreatedDate(BSTR* p);
    HRESULT get_fileModifiedDate(BSTR* p);
    HRESULT get_fileUpdatedDate(BSTR* p);
    HRESULT get_protocol(BSTR* p);
    HRESULT get_href(BSTR* p);
    HRESULT get_nameProp(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_complete(short* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT put_start(BSTR v);
    HRESULT get_start(BSTR* p);
}

const GUID IID_IHTMLImgElement2 = {0x3050F826, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F826, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLImgElement2 : IDispatch
{
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
}

const GUID IID_IHTMLImgElement3 = {0x30510434, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510434, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLImgElement3 : IDispatch
{
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
}

const GUID IID_IHTMLImgElement4 = {0x305107F6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107F6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLImgElement4 : IDispatch
{
    HRESULT get_naturalWidth(int* p);
    HRESULT get_naturalHeight(int* p);
}

const GUID IID_IHTMLMSImgElement = {0x30510793, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510793, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMSImgElement : IDispatch
{
    HRESULT put_msPlayToDisabled(short v);
    HRESULT get_msPlayToDisabled(short* p);
    HRESULT put_msPlayToPrimary(short v);
    HRESULT get_msPlayToPrimary(short* p);
}

const GUID IID_IHTMLImageElementFactory = {0x3050F38E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F38E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLImageElementFactory : IDispatch
{
    HRESULT create(VARIANT width, VARIANT height, IHTMLImgElement* __MIDL__IHTMLImageElementFactory0000);
}

const GUID IID_DispHTMLImg = {0x3050F51C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F51C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLImg : IDispatch
{
}

const GUID IID_IHTMLBodyElement = {0x3050F1D8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1D8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBodyElement : IDispatch
{
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_bgProperties(BSTR v);
    HRESULT get_bgProperties(BSTR* p);
    HRESULT put_leftMargin(VARIANT v);
    HRESULT get_leftMargin(VARIANT* p);
    HRESULT put_topMargin(VARIANT v);
    HRESULT get_topMargin(VARIANT* p);
    HRESULT put_rightMargin(VARIANT v);
    HRESULT get_rightMargin(VARIANT* p);
    HRESULT put_bottomMargin(VARIANT v);
    HRESULT get_bottomMargin(VARIANT* p);
    HRESULT put_noWrap(short v);
    HRESULT get_noWrap(short* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_text(VARIANT v);
    HRESULT get_text(VARIANT* p);
    HRESULT put_link(VARIANT v);
    HRESULT get_link(VARIANT* p);
    HRESULT put_vLink(VARIANT v);
    HRESULT get_vLink(VARIANT* p);
    HRESULT put_aLink(VARIANT v);
    HRESULT get_aLink(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onunload(VARIANT v);
    HRESULT get_onunload(VARIANT* p);
    HRESULT put_scroll(BSTR v);
    HRESULT get_scroll(BSTR* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onbeforeunload(VARIANT v);
    HRESULT get_onbeforeunload(VARIANT* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

const GUID IID_IHTMLBodyElement2 = {0x3050F5C5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5C5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBodyElement2 : IDispatch
{
    HRESULT put_onbeforeprint(VARIANT v);
    HRESULT get_onbeforeprint(VARIANT* p);
    HRESULT put_onafterprint(VARIANT v);
    HRESULT get_onafterprint(VARIANT* p);
}

const GUID IID_IHTMLBodyElement3 = {0x30510422, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510422, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBodyElement3 : IDispatch
{
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_ononline(VARIANT v);
    HRESULT get_ononline(VARIANT* p);
    HRESULT put_onoffline(VARIANT v);
    HRESULT get_onoffline(VARIANT* p);
    HRESULT put_onhashchange(VARIANT v);
    HRESULT get_onhashchange(VARIANT* p);
}

const GUID IID_IHTMLBodyElement4 = {0x30510795, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510795, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBodyElement4 : IDispatch
{
    HRESULT put_onmessage(VARIANT v);
    HRESULT get_onmessage(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
}

const GUID IID_IHTMLBodyElement5 = {0x30510822, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510822, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBodyElement5 : IDispatch
{
    HRESULT put_onpopstate(VARIANT v);
    HRESULT get_onpopstate(VARIANT* p);
}

const GUID IID_DispHTMLBody = {0x3050F507, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F507, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLBody : IDispatch
{
}

const GUID IID_IHTMLFontElement = {0x3050F1D9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1D9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFontElement : IDispatch
{
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_face(BSTR v);
    HRESULT get_face(BSTR* p);
    HRESULT put_size(VARIANT v);
    HRESULT get_size(VARIANT* p);
}

const GUID IID_DispHTMLFontElement = {0x3050F512, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F512, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLFontElement : IDispatch
{
}

const GUID IID_HTMLAnchorEvents2 = {0x3050F610, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F610, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLAnchorEvents2 : IDispatch
{
}

const GUID IID_HTMLAnchorEvents = {0x3050F29D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F29D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLAnchorEvents : IDispatch
{
}

const GUID IID_IHTMLAnchorElement = {0x3050F1DA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1DA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAnchorElement : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
    HRESULT put_rel(BSTR v);
    HRESULT get_rel(BSTR* p);
    HRESULT put_rev(BSTR v);
    HRESULT get_rev(BSTR* p);
    HRESULT put_urn(BSTR v);
    HRESULT get_urn(BSTR* p);
    HRESULT put_Methods(BSTR v);
    HRESULT get_Methods(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_host(BSTR v);
    HRESULT get_host(BSTR* p);
    HRESULT put_hostname(BSTR v);
    HRESULT get_hostname(BSTR* p);
    HRESULT put_pathname(BSTR v);
    HRESULT get_pathname(BSTR* p);
    HRESULT put_port(BSTR v);
    HRESULT get_port(BSTR* p);
    HRESULT put_protocol(BSTR v);
    HRESULT get_protocol(BSTR* p);
    HRESULT put_search(BSTR v);
    HRESULT get_search(BSTR* p);
    HRESULT put_hash(BSTR v);
    HRESULT get_hash(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
    HRESULT get_protocolLong(BSTR* p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_nameProp(BSTR* p);
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT blur();
}

const GUID IID_IHTMLAnchorElement2 = {0x3050F825, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F825, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAnchorElement2 : IDispatch
{
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_hreflang(BSTR v);
    HRESULT get_hreflang(BSTR* p);
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

const GUID IID_IHTMLAnchorElement3 = {0x3051041D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051041D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAnchorElement3 : IDispatch
{
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

const GUID IID_DispHTMLAnchorElement = {0x3050F502, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F502, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLAnchorElement : IDispatch
{
}

const GUID IID_HTMLLabelEvents2 = {0x3050F61C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F61C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLLabelEvents2 : IDispatch
{
}

const GUID IID_HTMLLabelEvents = {0x3050F329, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F329, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLLabelEvents : IDispatch
{
}

const GUID IID_IHTMLLabelElement = {0x3050F32A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F32A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLLabelElement : IDispatch
{
    HRESULT put_htmlFor(BSTR v);
    HRESULT get_htmlFor(BSTR* p);
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
}

const GUID IID_IHTMLLabelElement2 = {0x3050F832, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F832, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLLabelElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

const GUID IID_DispHTMLLabelElement = {0x3050F522, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F522, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLLabelElement : IDispatch
{
}

const GUID IID_IHTMLListElement = {0x3050F20E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F20E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLListElement : IDispatch
{
}

const GUID IID_IHTMLListElement2 = {0x3050F822, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F822, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLListElement2 : IDispatch
{
    HRESULT put_compact(short v);
    HRESULT get_compact(short* p);
}

const GUID IID_DispHTMLListElement = {0x3050F525, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F525, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLListElement : IDispatch
{
}

const GUID IID_IHTMLUListElement = {0x3050F1DD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1DD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLUListElement : IDispatch
{
    HRESULT put_compact(short v);
    HRESULT get_compact(short* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

const GUID IID_DispHTMLUListElement = {0x3050F538, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F538, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLUListElement : IDispatch
{
}

const GUID IID_IHTMLOListElement = {0x3050F1DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLOListElement : IDispatch
{
    HRESULT put_compact(short v);
    HRESULT get_compact(short* p);
    HRESULT put_start(int v);
    HRESULT get_start(int* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

const GUID IID_DispHTMLOListElement = {0x3050F52A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F52A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLOListElement : IDispatch
{
}

const GUID IID_IHTMLLIElement = {0x3050F1E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLLIElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(int v);
    HRESULT get_value(int* p);
}

const GUID IID_DispHTMLLIElement = {0x3050F523, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F523, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLLIElement : IDispatch
{
}

const GUID IID_IHTMLBlockElement = {0x3050F208, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F208, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBlockElement : IDispatch
{
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
}

const GUID IID_IHTMLBlockElement2 = {0x3050F823, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F823, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBlockElement2 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
    HRESULT put_width(BSTR v);
    HRESULT get_width(BSTR* p);
}

const GUID IID_IHTMLBlockElement3 = {0x30510494, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510494, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBlockElement3 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
}

const GUID IID_DispHTMLBlockElement = {0x3050F506, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F506, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLBlockElement : IDispatch
{
}

const GUID IID_IHTMLDivElement = {0x3050F200, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F200, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDivElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_noWrap(short v);
    HRESULT get_noWrap(short* p);
}

const GUID IID_DispHTMLDivElement = {0x3050F50C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F50C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDivElement : IDispatch
{
}

const GUID IID_IHTMLDDElement = {0x3050F1F2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1F2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDDElement : IDispatch
{
    HRESULT put_noWrap(short v);
    HRESULT get_noWrap(short* p);
}

const GUID IID_DispHTMLDDElement = {0x3050F50B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F50B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDDElement : IDispatch
{
}

const GUID IID_IHTMLDTElement = {0x3050F1F3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1F3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDTElement : IDispatch
{
    HRESULT put_noWrap(short v);
    HRESULT get_noWrap(short* p);
}

const GUID IID_DispHTMLDTElement = {0x3050F50D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F50D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDTElement : IDispatch
{
}

const GUID IID_IHTMLBRElement = {0x3050F1F0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1F0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBRElement : IDispatch
{
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
}

const GUID IID_DispHTMLBRElement = {0x3050F53A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F53A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLBRElement : IDispatch
{
}

const GUID IID_IHTMLDListElement = {0x3050F1F1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1F1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDListElement : IDispatch
{
    HRESULT put_compact(short v);
    HRESULT get_compact(short* p);
}

const GUID IID_DispHTMLDListElement = {0x3050F53B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F53B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDListElement : IDispatch
{
}

const GUID IID_IHTMLHRElement = {0x3050F1F4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1F4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLHRElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_noShade(short v);
    HRESULT get_noShade(short* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_size(VARIANT v);
    HRESULT get_size(VARIANT* p);
}

const GUID IID_DispHTMLHRElement = {0x3050F53D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F53D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLHRElement : IDispatch
{
}

const GUID IID_IHTMLParaElement = {0x3050F1F5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1F5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLParaElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

const GUID IID_DispHTMLParaElement = {0x3050F52C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F52C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLParaElement : IDispatch
{
}

const GUID IID_IHTMLElementCollection2 = {0x3050F5EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElementCollection2 : IDispatch
{
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

const GUID IID_IHTMLElementCollection3 = {0x3050F835, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F835, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElementCollection3 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

const GUID IID_IHTMLElementCollection4 = {0x30510425, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510425, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLElementCollection4 : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLElement2* pNode);
    HRESULT namedItem(BSTR name, IHTMLElement2* pNode);
}

const GUID IID_DispHTMLElementCollection = {0x3050F56B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F56B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLElementCollection : IDispatch
{
}

const GUID IID_IHTMLHeaderElement = {0x3050F1F6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F1F6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLHeaderElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

const GUID IID_DispHTMLHeaderElement = {0x3050F515, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F515, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLHeaderElement : IDispatch
{
}

const GUID IID_HTMLSelectElementEvents2 = {0x3050F622, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F622, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLSelectElementEvents2 : IDispatch
{
}

const GUID IID_HTMLSelectElementEvents = {0x3050F302, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F302, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLSelectElementEvents : IDispatch
{
}

const GUID IID_IHTMLOptionElement = {0x3050F211, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F211, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLOptionElement : IDispatch
{
    HRESULT put_selected(short v);
    HRESULT get_selected(short* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_defaultSelected(short v);
    HRESULT get_defaultSelected(short* p);
    HRESULT put_index(int v);
    HRESULT get_index(int* p);
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT get_form(IHTMLFormElement* p);
}

const GUID IID_IHTMLSelectElementEx = {0x3050F2D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSelectElementEx : IUnknown
{
    HRESULT ShowDropdown(BOOL fShow);
    HRESULT SetSelectExFlags(uint lFlags);
    HRESULT GetSelectExFlags(uint* pFlags);
    HRESULT GetDropdownOpen(int* pfOpen);
}

const GUID IID_IHTMLSelectElement = {0x3050F244, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F244, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSelectElement : IDispatch
{
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_multiple(short v);
    HRESULT get_multiple(short* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT get_options(IDispatch* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_selectedIndex(int v);
    HRESULT get_selectedIndex(int* p);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT add(IHTMLElement element, VARIANT before);
    HRESULT remove(int index);
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
}

const GUID IID_IHTMLSelectElement2 = {0x3050F5ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSelectElement2 : IDispatch
{
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

const GUID IID_IHTMLSelectElement4 = {0x3050F838, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F838, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSelectElement4 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

const GUID IID_IHTMLSelectElement5 = {0x3051049D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051049D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSelectElement5 : IDispatch
{
    HRESULT add(IHTMLOptionElement pElem, VARIANT* pvarBefore);
}

const GUID IID_IHTMLSelectElement6 = {0x30510760, 0x98B6, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510760, 0x98B6, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSelectElement6 : IDispatch
{
    HRESULT add(IHTMLOptionElement pElem, VARIANT* pvarBefore);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
}

const GUID IID_DispHTMLSelectElement = {0x3050F531, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F531, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLSelectElement : IDispatch
{
}

const GUID IID_DispHTMLWndSelectElement = {0x3050F597, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F597, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLWndSelectElement : IDispatch
{
}

const GUID IID_IHTMLSelectionObject = {0x3050F25A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F25A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSelectionObject : IDispatch
{
    HRESULT createRange(IDispatch* range);
    HRESULT empty();
    HRESULT clear();
    HRESULT get_type(BSTR* p);
}

const GUID IID_IHTMLSelectionObject2 = {0x3050F7EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSelectionObject2 : IDispatch
{
    HRESULT createRangeCollection(IDispatch* rangeCollection);
    HRESULT get_typeDetail(BSTR* p);
}

const GUID IID_IHTMLSelection = {0x305104B6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104B6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSelection : IDispatch
{
    HRESULT get_anchorNode(IHTMLDOMNode* p);
    HRESULT get_anchorOffset(int* p);
    HRESULT get_focusNode(IHTMLDOMNode* p);
    HRESULT get_focusOffset(int* p);
    HRESULT get_isCollapsed(short* p);
    HRESULT collapse(IDispatch parentNode, int offfset);
    HRESULT collapseToStart();
    HRESULT collapseToEnd();
    HRESULT selectAllChildren(IDispatch parentNode);
    HRESULT deleteFromDocument();
    HRESULT get_rangeCount(int* p);
    HRESULT getRangeAt(int index, IHTMLDOMRange* ppRange);
    HRESULT addRange(IDispatch range);
    HRESULT removeRange(IDispatch range);
    HRESULT removeAllRanges();
    HRESULT toString(BSTR* pSelectionString);
}

const GUID IID_IHTMLOptionElement3 = {0x3050F820, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F820, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLOptionElement3 : IDispatch
{
    HRESULT put_label(BSTR v);
    HRESULT get_label(BSTR* p);
}

const GUID IID_IHTMLOptionElement4 = {0x305107B4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107B4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLOptionElement4 : IDispatch
{
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
}

const GUID IID_IHTMLOptionElementFactory = {0x3050F38C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F38C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLOptionElementFactory : IDispatch
{
    HRESULT create(VARIANT text, VARIANT value, VARIANT defaultselected, VARIANT selected, IHTMLOptionElement* __MIDL__IHTMLOptionElementFactory0000);
}

const GUID IID_DispHTMLOptionElement = {0x3050F52B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F52B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLOptionElement : IDispatch
{
}

const GUID IID_DispHTMLWndOptionElement = {0x3050F598, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F598, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLWndOptionElement : IDispatch
{
}

const GUID IID_HTMLButtonElementEvents2 = {0x3050F617, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F617, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLButtonElementEvents2 : IDispatch
{
}

const GUID IID_HTMLButtonElementEvents = {0x3050F2B3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2B3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLButtonElementEvents : IDispatch
{
}

const GUID IID_HTMLInputTextElementEvents2 = {0x3050F618, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F618, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLInputTextElementEvents2 : IDispatch
{
}

const GUID IID_HTMLOptionButtonElementEvents2 = {0x3050F619, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F619, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLOptionButtonElementEvents2 : IDispatch
{
}

const GUID IID_HTMLInputFileElementEvents2 = {0x3050F61A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F61A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLInputFileElementEvents2 : IDispatch
{
}

const GUID IID_HTMLInputImageEvents2 = {0x3050F61B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F61B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLInputImageEvents2 : IDispatch
{
}

const GUID IID_HTMLInputTextElementEvents = {0x3050F2A7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2A7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLInputTextElementEvents : IDispatch
{
}

const GUID IID_HTMLOptionButtonElementEvents = {0x3050F2BD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2BD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLOptionButtonElementEvents : IDispatch
{
}

const GUID IID_HTMLInputFileElementEvents = {0x3050F2AF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2AF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLInputFileElementEvents : IDispatch
{
}

const GUID IID_HTMLInputImageEvents = {0x3050F2C3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2C3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLInputImageEvents : IDispatch
{
}

const GUID IID_IHTMLInputElement = {0x3050F5D2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5D2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLInputElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(short v);
    HRESULT get_status(short* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_maxLength(int v);
    HRESULT get_maxLength(int* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_defaultValue(BSTR v);
    HRESULT get_defaultValue(BSTR* p);
    HRESULT put_readOnly(short v);
    HRESULT get_readOnly(short* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
    HRESULT put_indeterminate(short v);
    HRESULT get_indeterminate(short* p);
    HRESULT put_defaultChecked(short v);
    HRESULT get_defaultChecked(short* p);
    HRESULT put_checked(short v);
    HRESULT get_checked(short* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_complete(short* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT put_start(BSTR v);
    HRESULT get_start(BSTR* p);
}

const GUID IID_IHTMLInputElement2 = {0x3050F821, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F821, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLInputElement2 : IDispatch
{
    HRESULT put_accept(BSTR v);
    HRESULT get_accept(BSTR* p);
    HRESULT put_useMap(BSTR v);
    HRESULT get_useMap(BSTR* p);
}

const GUID IID_IHTMLInputElement3 = {0x30510435, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510435, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLInputElement3 : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
}

const GUID IID_IHTMLInputButtonElement = {0x3050F2B2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2B2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLInputButtonElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

const GUID IID_IHTMLInputHiddenElement = {0x3050F2A4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2A4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLInputHiddenElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

const GUID IID_IHTMLInputTextElement = {0x3050F2A6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2A6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLInputTextElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_defaultValue(BSTR v);
    HRESULT get_defaultValue(BSTR* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_maxLength(int v);
    HRESULT get_maxLength(int* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_readOnly(short v);
    HRESULT get_readOnly(short* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

const GUID IID_IHTMLInputTextElement2 = {0x3050F2D2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2D2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLInputTextElement2 : IDispatch
{
    HRESULT put_selectionStart(int v);
    HRESULT get_selectionStart(int* p);
    HRESULT put_selectionEnd(int v);
    HRESULT get_selectionEnd(int* p);
    HRESULT setSelectionRange(int start, int end);
}

const GUID IID_IHTMLInputFileElement = {0x3050F2AD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2AD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLInputFileElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_maxLength(int v);
    HRESULT get_maxLength(int* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
}

const GUID IID_IHTMLOptionButtonElement = {0x3050F2BC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2BC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLOptionButtonElement : IDispatch
{
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_type(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_checked(short v);
    HRESULT get_checked(short* p);
    HRESULT put_defaultChecked(short v);
    HRESULT get_defaultChecked(short* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT put_status(short v);
    HRESULT get_status(short* p);
    HRESULT put_indeterminate(short v);
    HRESULT get_indeterminate(short* p);
    HRESULT get_form(IHTMLFormElement* p);
}

const GUID IID_IHTMLInputImage = {0x3050F2C2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2C2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLInputImage : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_complete(short* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT put_start(BSTR v);
    HRESULT get_start(BSTR* p);
}

const GUID IID_IHTMLInputRangeElement = {0x3050F2D4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2D4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLInputRangeElement : IDispatch
{
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_type(BSTR* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_min(BSTR v);
    HRESULT get_min(BSTR* p);
    HRESULT put_max(BSTR v);
    HRESULT get_max(BSTR* p);
    HRESULT put_step(BSTR v);
    HRESULT get_step(BSTR* p);
    HRESULT put_valueAsNumber(double v);
    HRESULT get_valueAsNumber(double* p);
    HRESULT stepUp(int n);
    HRESULT stepDown(int n);
}

const GUID IID_DispHTMLInputElement = {0x3050F57D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F57D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLInputElement : IDispatch
{
}

const GUID IID_IHTMLTextAreaElement = {0x3050F2AA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2AA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTextAreaElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_defaultValue(BSTR v);
    HRESULT get_defaultValue(BSTR* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_readOnly(short v);
    HRESULT get_readOnly(short* p);
    HRESULT put_rows(int v);
    HRESULT get_rows(int* p);
    HRESULT put_cols(int v);
    HRESULT get_cols(int* p);
    HRESULT put_wrap(BSTR v);
    HRESULT get_wrap(BSTR* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

const GUID IID_IHTMLTextAreaElement2 = {0x3050F2D3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2D3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTextAreaElement2 : IDispatch
{
    HRESULT put_selectionStart(int v);
    HRESULT get_selectionStart(int* p);
    HRESULT put_selectionEnd(int v);
    HRESULT get_selectionEnd(int* p);
    HRESULT setSelectionRange(int start, int end);
}

const GUID IID_DispHTMLTextAreaElement = {0x3050F521, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F521, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLTextAreaElement : IDispatch
{
}

const GUID IID_DispHTMLRichtextElement = {0x3050F54D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F54D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLRichtextElement : IDispatch
{
}

const GUID IID_IHTMLButtonElement = {0x3050F2BB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2BB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLButtonElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

const GUID IID_IHTMLButtonElement2 = {0x305106F3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106F3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLButtonElement2 : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

const GUID IID_DispHTMLButtonElement = {0x3050F51F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F51F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLButtonElement : IDispatch
{
}

const GUID IID_HTMLMarqueeElementEvents2 = {0x3050F61F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F61F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLMarqueeElementEvents2 : IDispatch
{
}

const GUID IID_HTMLMarqueeElementEvents = {0x3050F2B8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2B8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLMarqueeElementEvents : IDispatch
{
}

const GUID IID_IHTMLMarqueeElement = {0x3050F2B5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2B5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMarqueeElement : IDispatch
{
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_scrollDelay(int v);
    HRESULT get_scrollDelay(int* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT put_scrollAmount(int v);
    HRESULT get_scrollAmount(int* p);
    HRESULT put_loop(int v);
    HRESULT get_loop(int* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_onfinish(VARIANT v);
    HRESULT get_onfinish(VARIANT* p);
    HRESULT put_onstart(VARIANT v);
    HRESULT get_onstart(VARIANT* p);
    HRESULT put_onbounce(VARIANT v);
    HRESULT get_onbounce(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_trueSpeed(short v);
    HRESULT get_trueSpeed(short* p);
    HRESULT start();
    HRESULT stop();
}

const GUID IID_DispHTMLMarqueeElement = {0x3050F527, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F527, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLMarqueeElement : IDispatch
{
}

const GUID IID_IHTMLHtmlElement = {0x3050F81C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F81C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLHtmlElement : IDispatch
{
    HRESULT put_version(BSTR v);
    HRESULT get_version(BSTR* p);
}

const GUID IID_IHTMLHeadElement = {0x3050F81D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F81D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLHeadElement : IDispatch
{
    HRESULT put_profile(BSTR v);
    HRESULT get_profile(BSTR* p);
}

const GUID IID_IHTMLHeadElement2 = {0x3051042F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051042F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLHeadElement2 : IDispatch
{
    HRESULT put_profile(BSTR v);
    HRESULT get_profile(BSTR* p);
}

const GUID IID_IHTMLTitleElement = {0x3050F322, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F322, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTitleElement : IDispatch
{
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
}

const GUID IID_IHTMLMetaElement = {0x3050F203, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F203, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMetaElement : IDispatch
{
    HRESULT put_httpEquiv(BSTR v);
    HRESULT get_httpEquiv(BSTR* p);
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_url(BSTR v);
    HRESULT get_url(BSTR* p);
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
}

const GUID IID_IHTMLMetaElement2 = {0x3050F81F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F81F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMetaElement2 : IDispatch
{
    HRESULT put_scheme(BSTR v);
    HRESULT get_scheme(BSTR* p);
}

const GUID IID_IHTMLMetaElement3 = {0x30510495, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510495, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMetaElement3 : IDispatch
{
    HRESULT put_url(BSTR v);
    HRESULT get_url(BSTR* p);
}

const GUID IID_IHTMLBaseElement = {0x3050F204, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F204, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBaseElement : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
}

const GUID IID_IHTMLBaseElement2 = {0x30510420, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510420, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBaseElement2 : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

const GUID IID_DispHTMLHtmlElement = {0x3050F560, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F560, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLHtmlElement : IDispatch
{
}

const GUID IID_DispHTMLHeadElement = {0x3050F561, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F561, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLHeadElement : IDispatch
{
}

const GUID IID_DispHTMLTitleElement = {0x3050F516, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F516, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLTitleElement : IDispatch
{
}

const GUID IID_DispHTMLMetaElement = {0x3050F517, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F517, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLMetaElement : IDispatch
{
}

const GUID IID_DispHTMLBaseElement = {0x3050F518, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F518, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLBaseElement : IDispatch
{
}

const GUID IID_IHTMLIsIndexElement = {0x3050F206, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F206, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLIsIndexElement : IDispatch
{
    HRESULT put_prompt(BSTR v);
    HRESULT get_prompt(BSTR* p);
    HRESULT put_action(BSTR v);
    HRESULT get_action(BSTR* p);
}

const GUID IID_IHTMLIsIndexElement2 = {0x3050F82F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F82F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLIsIndexElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

const GUID IID_IHTMLNextIdElement = {0x3050F207, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F207, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLNextIdElement : IDispatch
{
    HRESULT put_n(BSTR v);
    HRESULT get_n(BSTR* p);
}

const GUID IID_DispHTMLIsIndexElement = {0x3050F519, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F519, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLIsIndexElement : IDispatch
{
}

const GUID IID_DispHTMLNextIdElement = {0x3050F51A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F51A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLNextIdElement : IDispatch
{
}

const GUID IID_IHTMLBaseFontElement = {0x3050F202, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F202, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBaseFontElement : IDispatch
{
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_face(BSTR v);
    HRESULT get_face(BSTR* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
}

const GUID IID_DispHTMLBaseFontElement = {0x3050F504, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F504, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLBaseFontElement : IDispatch
{
}

const GUID IID_IHTMLUnknownElement = {0x3050F209, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F209, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLUnknownElement : IDispatch
{
}

const GUID IID_DispHTMLUnknownElement = {0x3050F539, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F539, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLUnknownElement : IDispatch
{
}

const GUID IID_IWebGeolocation = {0x305107C5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107C5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IWebGeolocation : IDispatch
{
    HRESULT getCurrentPosition(IDispatch successCallback, IDispatch errorCallback, IDispatch options);
    HRESULT watchPosition(IDispatch successCallback, IDispatch errorCallback, IDispatch options, int* watchId);
    HRESULT clearWatch(int watchId);
}

const GUID IID_IHTMLMimeTypesCollection = {0x3050F3FC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3FC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMimeTypesCollection : IDispatch
{
    HRESULT get_length(int* p);
}

const GUID IID_IHTMLPluginsCollection = {0x3050F3FD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3FD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPluginsCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT refresh(short reload);
}

const GUID IID_IOmHistory = {0xFECEAAA2, 0x8405, 0x11CF, [0x8B, 0xA1, 0x00, 0xAA, 0x00, 0x47, 0x6D, 0xA6]};
@GUID(0xFECEAAA2, 0x8405, 0x11CF, [0x8B, 0xA1, 0x00, 0xAA, 0x00, 0x47, 0x6D, 0xA6]);
interface IOmHistory : IDispatch
{
    HRESULT get_length(short* p);
    HRESULT back(VARIANT* pvargdistance);
    HRESULT forward(VARIANT* pvargdistance);
    HRESULT go(VARIANT* pvargdistance);
}

const GUID IID_IHTMLOpsProfile = {0x3050F401, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F401, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLOpsProfile : IDispatch
{
    HRESULT addRequest(BSTR name, VARIANT reserved, short* success);
    HRESULT clearRequest();
    HRESULT doRequest(VARIANT usage, VARIANT fname, VARIANT domain, VARIANT path, VARIANT expire, VARIANT reserved);
    HRESULT getAttribute(BSTR name, BSTR* value);
    HRESULT setAttribute(BSTR name, BSTR value, VARIANT prefs, short* success);
    HRESULT commitChanges(short* success);
    HRESULT addReadRequest(BSTR name, VARIANT reserved, short* success);
    HRESULT doReadRequest(VARIANT usage, VARIANT fname, VARIANT domain, VARIANT path, VARIANT expire, VARIANT reserved);
    HRESULT doWriteRequest(short* success);
}

const GUID IID_IOmNavigator = {0xFECEAAA5, 0x8405, 0x11CF, [0x8B, 0xA1, 0x00, 0xAA, 0x00, 0x47, 0x6D, 0xA6]};
@GUID(0xFECEAAA5, 0x8405, 0x11CF, [0x8B, 0xA1, 0x00, 0xAA, 0x00, 0x47, 0x6D, 0xA6]);
interface IOmNavigator : IDispatch
{
    HRESULT get_appCodeName(BSTR* p);
    HRESULT get_appName(BSTR* p);
    HRESULT get_appVersion(BSTR* p);
    HRESULT get_userAgent(BSTR* p);
    HRESULT javaEnabled(short* enabled);
    HRESULT taintEnabled(short* enabled);
    HRESULT get_mimeTypes(IHTMLMimeTypesCollection* p);
    HRESULT get_plugins(IHTMLPluginsCollection* p);
    HRESULT get_cookieEnabled(short* p);
    HRESULT get_opsProfile(IHTMLOpsProfile* p);
    HRESULT toString(BSTR* string);
    HRESULT get_cpuClass(BSTR* p);
    HRESULT get_systemLanguage(BSTR* p);
    HRESULT get_browserLanguage(BSTR* p);
    HRESULT get_userLanguage(BSTR* p);
    HRESULT get_platform(BSTR* p);
    HRESULT get_appMinorVersion(BSTR* p);
    HRESULT get_connectionSpeed(int* p);
    HRESULT get_onLine(short* p);
    HRESULT get_userProfile(IHTMLOpsProfile* p);
}

const GUID IID_INavigatorGeolocation = {0x305107CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface INavigatorGeolocation : IDispatch
{
    HRESULT get_geolocation(IWebGeolocation* p);
}

const GUID IID_INavigatorDoNotTrack = {0x30510804, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510804, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface INavigatorDoNotTrack : IDispatch
{
    HRESULT get_msDoNotTrack(BSTR* p);
}

const GUID IID_IHTMLLocation = {0x163BB1E0, 0x6E00, 0x11CF, [0x83, 0x7A, 0x48, 0xDC, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x163BB1E0, 0x6E00, 0x11CF, [0x83, 0x7A, 0x48, 0xDC, 0x04, 0xC1, 0x00, 0x00]);
interface IHTMLLocation : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_protocol(BSTR v);
    HRESULT get_protocol(BSTR* p);
    HRESULT put_host(BSTR v);
    HRESULT get_host(BSTR* p);
    HRESULT put_hostname(BSTR v);
    HRESULT get_hostname(BSTR* p);
    HRESULT put_port(BSTR v);
    HRESULT get_port(BSTR* p);
    HRESULT put_pathname(BSTR v);
    HRESULT get_pathname(BSTR* p);
    HRESULT put_search(BSTR v);
    HRESULT get_search(BSTR* p);
    HRESULT put_hash(BSTR v);
    HRESULT get_hash(BSTR* p);
    HRESULT reload(short flag);
    HRESULT replace(BSTR bstr);
    HRESULT assign(BSTR bstr);
    HRESULT toString(BSTR* string);
}

const GUID IID_DispHTMLHistory = {0x3050F549, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F549, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLHistory : IDispatch
{
}

const GUID IID_DispHTMLNavigator = {0x3050F54C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F54C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLNavigator : IDispatch
{
}

const GUID IID_DispHTMLLocation = {0x3050F54E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F54E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLLocation : IDispatch
{
}

const GUID IID_DispCPlugins = {0x3050F54A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F54A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispCPlugins : IDispatch
{
}

const GUID IID_IHTMLBookmarkCollection = {0x3050F4CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBookmarkCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, VARIANT* pVarBookmark);
}

const GUID IID_IHTMLDataTransfer = {0x3050F4B3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4B3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDataTransfer : IDispatch
{
    HRESULT setData(BSTR format, VARIANT* data, short* pret);
    HRESULT getData(BSTR format, VARIANT* pvarRet);
    HRESULT clearData(BSTR format, short* pret);
    HRESULT put_dropEffect(BSTR v);
    HRESULT get_dropEffect(BSTR* p);
    HRESULT put_effectAllowed(BSTR v);
    HRESULT get_effectAllowed(BSTR* p);
}

const GUID IID_IHTMLEventObj2 = {0x3050F48B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F48B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEventObj2 : IDispatch
{
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, short* pfSuccess);
    HRESULT put_propertyName(BSTR v);
    HRESULT get_propertyName(BSTR* p);
    HRESULT putref_bookmarks(IHTMLBookmarkCollection v);
    HRESULT get_bookmarks(IHTMLBookmarkCollection* p);
    HRESULT putref_recordset(IDispatch v);
    HRESULT get_recordset(IDispatch* p);
    HRESULT put_dataFld(BSTR v);
    HRESULT get_dataFld(BSTR* p);
    HRESULT putref_boundElements(IHTMLElementCollection v);
    HRESULT get_boundElements(IHTMLElementCollection* p);
    HRESULT put_repeat(short v);
    HRESULT get_repeat(short* p);
    HRESULT put_srcUrn(BSTR v);
    HRESULT get_srcUrn(BSTR* p);
    HRESULT putref_srcElement(IHTMLElement v);
    HRESULT get_srcElement(IHTMLElement* p);
    HRESULT put_altKey(short v);
    HRESULT get_altKey(short* p);
    HRESULT put_ctrlKey(short v);
    HRESULT get_ctrlKey(short* p);
    HRESULT put_shiftKey(short v);
    HRESULT get_shiftKey(short* p);
    HRESULT putref_fromElement(IHTMLElement v);
    HRESULT get_fromElement(IHTMLElement* p);
    HRESULT putref_toElement(IHTMLElement v);
    HRESULT get_toElement(IHTMLElement* p);
    HRESULT put_button(int v);
    HRESULT get_button(int* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_qualifier(BSTR v);
    HRESULT get_qualifier(BSTR* p);
    HRESULT put_reason(int v);
    HRESULT get_reason(int* p);
    HRESULT put_x(int v);
    HRESULT get_x(int* p);
    HRESULT put_y(int v);
    HRESULT get_y(int* p);
    HRESULT put_clientX(int v);
    HRESULT get_clientX(int* p);
    HRESULT put_clientY(int v);
    HRESULT get_clientY(int* p);
    HRESULT put_offsetX(int v);
    HRESULT get_offsetX(int* p);
    HRESULT put_offsetY(int v);
    HRESULT get_offsetY(int* p);
    HRESULT put_screenX(int v);
    HRESULT get_screenX(int* p);
    HRESULT put_screenY(int v);
    HRESULT get_screenY(int* p);
    HRESULT putref_srcFilter(IDispatch v);
    HRESULT get_srcFilter(IDispatch* p);
    HRESULT get_dataTransfer(IHTMLDataTransfer* p);
}

const GUID IID_IHTMLEventObj3 = {0x3050F680, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F680, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEventObj3 : IDispatch
{
    HRESULT get_contentOverflow(short* p);
    HRESULT put_shiftLeft(short v);
    HRESULT get_shiftLeft(short* p);
    HRESULT put_altLeft(short v);
    HRESULT get_altLeft(short* p);
    HRESULT put_ctrlLeft(short v);
    HRESULT get_ctrlLeft(short* p);
    HRESULT get_imeCompositionChange(int* p);
    HRESULT get_imeNotifyCommand(int* p);
    HRESULT get_imeNotifyData(int* p);
    HRESULT get_imeRequest(int* p);
    HRESULT get_imeRequestData(int* p);
    HRESULT get_keyboardLayout(int* p);
    HRESULT get_behaviorCookie(int* p);
    HRESULT get_behaviorPart(int* p);
    HRESULT get_nextPage(BSTR* p);
}

const GUID IID_IHTMLEventObj4 = {0x3050F814, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F814, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEventObj4 : IDispatch
{
    HRESULT get_wheelDelta(int* p);
}

const GUID IID_IHTMLEventObj5 = {0x30510478, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510478, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEventObj5 : IDispatch
{
    HRESULT put_url(BSTR v);
    HRESULT get_url(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
    HRESULT get_source(IDispatch* p);
    HRESULT put_origin(BSTR v);
    HRESULT get_origin(BSTR* p);
    HRESULT put_issession(short v);
    HRESULT get_issession(short* p);
}

const GUID IID_IHTMLEventObj6 = {0x30510734, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510734, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEventObj6 : IDispatch
{
    HRESULT get_actionURL(BSTR* p);
    HRESULT get_buttonID(int* p);
}

const GUID IID_DispCEventObj = {0x3050F558, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F558, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispCEventObj : IDispatch
{
}

const GUID IID_IHTMLStyleMedia = {0x3051074B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051074B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleMedia : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT matchMedium(BSTR mediaQuery, short* matches);
}

const GUID IID_DispHTMLStyleMedia = {0x3059009E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059009E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyleMedia : IDispatch
{
}

const GUID IID_IHTMLFramesCollection2 = {0x332C4426, 0x26CB, 0x11D0, [0xB4, 0x83, 0x00, 0xC0, 0x4F, 0xD9, 0x01, 0x19]};
@GUID(0x332C4426, 0x26CB, 0x11D0, [0xB4, 0x83, 0x00, 0xC0, 0x4F, 0xD9, 0x01, 0x19]);
interface IHTMLFramesCollection2 : IDispatch
{
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
    HRESULT get_length(int* p);
}

const GUID IID_HTMLWindowEvents3 = {0x3050F5A1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5A1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLWindowEvents3 : IDispatch
{
}

const GUID IID_HTMLWindowEvents2 = {0x3050F625, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F625, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLWindowEvents2 : IDispatch
{
}

const GUID IID_HTMLWindowEvents = {0x96A0A4E0, 0xD062, 0x11CF, [0x94, 0xB6, 0x00, 0xAA, 0x00, 0x60, 0x27, 0x5C]};
@GUID(0x96A0A4E0, 0xD062, 0x11CF, [0x94, 0xB6, 0x00, 0xAA, 0x00, 0x60, 0x27, 0x5C]);
interface HTMLWindowEvents : IDispatch
{
}

const GUID IID_IHTMLDocument2 = {0x332C4425, 0x26CB, 0x11D0, [0xB4, 0x83, 0x00, 0xC0, 0x4F, 0xD9, 0x01, 0x19]};
@GUID(0x332C4425, 0x26CB, 0x11D0, [0xB4, 0x83, 0x00, 0xC0, 0x4F, 0xD9, 0x01, 0x19]);
interface IHTMLDocument2 : IHTMLDocument
{
    HRESULT get_all(IHTMLElementCollection* p);
    HRESULT get_body(IHTMLElement* p);
    HRESULT get_activeElement(IHTMLElement* p);
    HRESULT get_images(IHTMLElementCollection* p);
    HRESULT get_applets(IHTMLElementCollection* p);
    HRESULT get_links(IHTMLElementCollection* p);
    HRESULT get_forms(IHTMLElementCollection* p);
    HRESULT get_anchors(IHTMLElementCollection* p);
    HRESULT put_title(BSTR v);
    HRESULT get_title(BSTR* p);
    HRESULT get_scripts(IHTMLElementCollection* p);
    HRESULT put_designMode(BSTR v);
    HRESULT get_designMode(BSTR* p);
    HRESULT get_selection(IHTMLSelectionObject* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_frames(IHTMLFramesCollection2* p);
    HRESULT get_embeds(IHTMLElementCollection* p);
    HRESULT get_plugins(IHTMLElementCollection* p);
    HRESULT put_alinkColor(VARIANT v);
    HRESULT get_alinkColor(VARIANT* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_fgColor(VARIANT v);
    HRESULT get_fgColor(VARIANT* p);
    HRESULT put_linkColor(VARIANT v);
    HRESULT get_linkColor(VARIANT* p);
    HRESULT put_vlinkColor(VARIANT v);
    HRESULT get_vlinkColor(VARIANT* p);
    HRESULT get_referrer(BSTR* p);
    HRESULT get_location(IHTMLLocation* p);
    HRESULT get_lastModified(BSTR* p);
    HRESULT put_URL(BSTR v);
    HRESULT get_URL(BSTR* p);
    HRESULT put_domain(BSTR v);
    HRESULT get_domain(BSTR* p);
    HRESULT put_cookie(BSTR v);
    HRESULT get_cookie(BSTR* p);
    HRESULT put_expando(short v);
    HRESULT get_expando(short* p);
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
    HRESULT put_defaultCharset(BSTR v);
    HRESULT get_defaultCharset(BSTR* p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_fileSize(BSTR* p);
    HRESULT get_fileCreatedDate(BSTR* p);
    HRESULT get_fileModifiedDate(BSTR* p);
    HRESULT get_fileUpdatedDate(BSTR* p);
    HRESULT get_security(BSTR* p);
    HRESULT get_protocol(BSTR* p);
    HRESULT get_nameProp(BSTR* p);
    HRESULT write(SAFEARRAY* psarray);
    HRESULT writeln(SAFEARRAY* psarray);
    HRESULT open(BSTR url, VARIANT name, VARIANT features, VARIANT replace, IDispatch* pomWindowResult);
    HRESULT close();
    HRESULT clear();
    HRESULT queryCommandSupported(BSTR cmdID, short* pfRet);
    HRESULT queryCommandEnabled(BSTR cmdID, short* pfRet);
    HRESULT queryCommandState(BSTR cmdID, short* pfRet);
    HRESULT queryCommandIndeterm(BSTR cmdID, short* pfRet);
    HRESULT queryCommandText(BSTR cmdID, BSTR* pcmdText);
    HRESULT queryCommandValue(BSTR cmdID, VARIANT* pcmdValue);
    HRESULT execCommand(BSTR cmdID, short showUI, VARIANT value, short* pfRet);
    HRESULT execCommandShowHelp(BSTR cmdID, short* pfRet);
    HRESULT createElement(BSTR eTag, IHTMLElement* newElem);
    HRESULT put_onhelp(VARIANT v);
    HRESULT get_onhelp(VARIANT* p);
    HRESULT put_onclick(VARIANT v);
    HRESULT get_onclick(VARIANT* p);
    HRESULT put_ondblclick(VARIANT v);
    HRESULT get_ondblclick(VARIANT* p);
    HRESULT put_onkeyup(VARIANT v);
    HRESULT get_onkeyup(VARIANT* p);
    HRESULT put_onkeydown(VARIANT v);
    HRESULT get_onkeydown(VARIANT* p);
    HRESULT put_onkeypress(VARIANT v);
    HRESULT get_onkeypress(VARIANT* p);
    HRESULT put_onmouseup(VARIANT v);
    HRESULT get_onmouseup(VARIANT* p);
    HRESULT put_onmousedown(VARIANT v);
    HRESULT get_onmousedown(VARIANT* p);
    HRESULT put_onmousemove(VARIANT v);
    HRESULT get_onmousemove(VARIANT* p);
    HRESULT put_onmouseout(VARIANT v);
    HRESULT get_onmouseout(VARIANT* p);
    HRESULT put_onmouseover(VARIANT v);
    HRESULT get_onmouseover(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onafterupdate(VARIANT v);
    HRESULT get_onafterupdate(VARIANT* p);
    HRESULT put_onrowexit(VARIANT v);
    HRESULT get_onrowexit(VARIANT* p);
    HRESULT put_onrowenter(VARIANT v);
    HRESULT get_onrowenter(VARIANT* p);
    HRESULT put_ondragstart(VARIANT v);
    HRESULT get_ondragstart(VARIANT* p);
    HRESULT put_onselectstart(VARIANT v);
    HRESULT get_onselectstart(VARIANT* p);
    HRESULT elementFromPoint(int x, int y, IHTMLElement* elementHit);
    HRESULT get_parentWindow(IHTMLWindow2* p);
    HRESULT get_styleSheets(IHTMLStyleSheetsCollection* p);
    HRESULT put_onbeforeupdate(VARIANT v);
    HRESULT get_onbeforeupdate(VARIANT* p);
    HRESULT put_onerrorupdate(VARIANT v);
    HRESULT get_onerrorupdate(VARIANT* p);
    HRESULT toString(BSTR* String);
    HRESULT createStyleSheet(BSTR bstrHref, int lIndex, IHTMLStyleSheet* ppnewStyleSheet);
}

const GUID IID_IHTMLWindow2 = {0x332C4427, 0x26CB, 0x11D0, [0xB4, 0x83, 0x00, 0xC0, 0x4F, 0xD9, 0x01, 0x19]};
@GUID(0x332C4427, 0x26CB, 0x11D0, [0xB4, 0x83, 0x00, 0xC0, 0x4F, 0xD9, 0x01, 0x19]);
interface IHTMLWindow2 : IHTMLFramesCollection2
{
    HRESULT get_frames(IHTMLFramesCollection2* p);
    HRESULT put_defaultStatus(BSTR v);
    HRESULT get_defaultStatus(BSTR* p);
    HRESULT put_status(BSTR v);
    HRESULT get_status(BSTR* p);
    HRESULT setTimeout(BSTR expression, int msec, VARIANT* language, int* timerID);
    HRESULT clearTimeout(int timerID);
    HRESULT alert(BSTR message);
    HRESULT confirm(BSTR message, short* confirmed);
    HRESULT prompt(BSTR message, BSTR defstr, VARIANT* textdata);
    HRESULT get_Image(IHTMLImageElementFactory* p);
    HRESULT get_location(IHTMLLocation* p);
    HRESULT get_history(IOmHistory* p);
    HRESULT close();
    HRESULT put_opener(VARIANT v);
    HRESULT get_opener(VARIANT* p);
    HRESULT get_navigator(IOmNavigator* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT get_parent(IHTMLWindow2* p);
    HRESULT open(BSTR url, BSTR name, BSTR features, short replace, IHTMLWindow2* pomWindowResult);
    HRESULT get_self(IHTMLWindow2* p);
    HRESULT get_top(IHTMLWindow2* p);
    HRESULT get_window(IHTMLWindow2* p);
    HRESULT navigate(BSTR url);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onbeforeunload(VARIANT v);
    HRESULT get_onbeforeunload(VARIANT* p);
    HRESULT put_onunload(VARIANT v);
    HRESULT get_onunload(VARIANT* p);
    HRESULT put_onhelp(VARIANT v);
    HRESULT get_onhelp(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onresize(VARIANT v);
    HRESULT get_onresize(VARIANT* p);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
    HRESULT get_document(IHTMLDocument2* p);
    HRESULT get_event(IHTMLEventObj* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT showModalDialog(BSTR dialog, VARIANT* varArgIn, VARIANT* varOptions, VARIANT* varArgOut);
    HRESULT showHelp(BSTR helpURL, VARIANT helpArg, BSTR features);
    HRESULT get_screen(IHTMLScreen* p);
    HRESULT get_Option(IHTMLOptionElementFactory* p);
    HRESULT focus();
    HRESULT get_closed(short* p);
    HRESULT blur();
    HRESULT scroll(int x, int y);
    HRESULT get_clientInformation(IOmNavigator* p);
    HRESULT setInterval(BSTR expression, int msec, VARIANT* language, int* timerID);
    HRESULT clearInterval(int timerID);
    HRESULT put_offscreenBuffering(VARIANT v);
    HRESULT get_offscreenBuffering(VARIANT* p);
    HRESULT execScript(BSTR code, BSTR language, VARIANT* pvarRet);
    HRESULT toString(BSTR* String);
    HRESULT scrollBy(int x, int y);
    HRESULT scrollTo(int x, int y);
    HRESULT moveTo(int x, int y);
    HRESULT moveBy(int x, int y);
    HRESULT resizeTo(int x, int y);
    HRESULT resizeBy(int x, int y);
    HRESULT get_external(IDispatch* p);
}

const GUID IID_IHTMLWindow3 = {0x3050F4AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLWindow3 : IDispatch
{
    HRESULT get_screenLeft(int* p);
    HRESULT get_screenTop(int* p);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, short* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
    HRESULT setTimeout(VARIANT* expression, int msec, VARIANT* language, int* timerID);
    HRESULT setInterval(VARIANT* expression, int msec, VARIANT* language, int* timerID);
    HRESULT print();
    HRESULT put_onbeforeprint(VARIANT v);
    HRESULT get_onbeforeprint(VARIANT* p);
    HRESULT put_onafterprint(VARIANT v);
    HRESULT get_onafterprint(VARIANT* p);
    HRESULT get_clipboardData(IHTMLDataTransfer* p);
    HRESULT showModelessDialog(BSTR url, VARIANT* varArgIn, VARIANT* options, IHTMLWindow2* pDialog);
}

const GUID IID_IHTMLFrameBase = {0x3050F311, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F311, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFrameBase : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
    HRESULT put_frameSpacing(VARIANT v);
    HRESULT get_frameSpacing(VARIANT* p);
    HRESULT put_marginWidth(VARIANT v);
    HRESULT get_marginWidth(VARIANT* p);
    HRESULT put_marginHeight(VARIANT v);
    HRESULT get_marginHeight(VARIANT* p);
    HRESULT put_noResize(short v);
    HRESULT get_noResize(short* p);
    HRESULT put_scrolling(BSTR v);
    HRESULT get_scrolling(BSTR* p);
}

const GUID IID_IHTMLStorage = {0x30510474, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510474, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStorage : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get_remainingSpace(int* p);
    HRESULT key(int lIndex, BSTR* __MIDL__IHTMLStorage0000);
    HRESULT getItem(BSTR bstrKey, VARIANT* __MIDL__IHTMLStorage0001);
    HRESULT setItem(BSTR bstrKey, BSTR bstrValue);
    HRESULT removeItem(BSTR bstrKey);
    HRESULT clear();
}

const GUID IID_IHTMLPerformance = {0x3051074E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051074E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPerformance : IDispatch
{
    HRESULT get_navigation(IHTMLPerformanceNavigation* p);
    HRESULT get_timing(IHTMLPerformanceTiming* p);
    HRESULT toString(BSTR* string);
    HRESULT toJSON(VARIANT* pVar);
}

const GUID IID_IHTMLApplicationCache = {0x30510828, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510828, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLApplicationCache : IDispatch
{
    HRESULT get_status(int* p);
    HRESULT put_onchecking(VARIANT v);
    HRESULT get_onchecking(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onnoupdate(VARIANT v);
    HRESULT get_onnoupdate(VARIANT* p);
    HRESULT put_ondownloading(VARIANT v);
    HRESULT get_ondownloading(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onupdateready(VARIANT v);
    HRESULT get_onupdateready(VARIANT* p);
    HRESULT put_oncached(VARIANT v);
    HRESULT get_oncached(VARIANT* p);
    HRESULT put_onobsolete(VARIANT v);
    HRESULT get_onobsolete(VARIANT* p);
    HRESULT update();
    HRESULT swapCache();
    HRESULT abort();
}

const GUID IID_IHTMLScreen = {0x3050F35C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F35C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLScreen : IDispatch
{
    HRESULT get_colorDepth(int* p);
    HRESULT put_bufferDepth(int v);
    HRESULT get_bufferDepth(int* p);
    HRESULT get_width(int* p);
    HRESULT get_height(int* p);
    HRESULT put_updateInterval(int v);
    HRESULT get_updateInterval(int* p);
    HRESULT get_availHeight(int* p);
    HRESULT get_availWidth(int* p);
    HRESULT get_fontSmoothingEnabled(short* p);
}

const GUID IID_IHTMLScreen2 = {0x3050F84A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F84A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLScreen2 : IDispatch
{
    HRESULT get_logicalXDPI(int* p);
    HRESULT get_logicalYDPI(int* p);
    HRESULT get_deviceXDPI(int* p);
    HRESULT get_deviceYDPI(int* p);
}

const GUID IID_IHTMLScreen3 = {0x305104A1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104A1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLScreen3 : IDispatch
{
    HRESULT get_systemXDPI(int* p);
    HRESULT get_systemYDPI(int* p);
}

const GUID IID_IHTMLScreen4 = {0x3051076B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051076B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLScreen4 : IDispatch
{
    HRESULT get_pixelDepth(int* p);
}

const GUID IID_IHTMLWindow4 = {0x3050F6CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLWindow4 : IDispatch
{
    HRESULT createPopup(VARIANT* varArgIn, IDispatch* ppPopup);
    HRESULT get_frameElement(IHTMLFrameBase* p);
}

const GUID IID_IHTMLWindow5 = {0x3051040E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051040E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLWindow5 : IDispatch
{
    HRESULT put_XMLHttpRequest(VARIANT v);
    HRESULT get_XMLHttpRequest(VARIANT* p);
}

const GUID IID_IHTMLWindow6 = {0x30510453, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510453, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLWindow6 : IDispatch
{
    HRESULT put_XDomainRequest(VARIANT v);
    HRESULT get_XDomainRequest(VARIANT* p);
    HRESULT get_sessionStorage(IHTMLStorage* p);
    HRESULT get_localStorage(IHTMLStorage* p);
    HRESULT put_onhashchange(VARIANT v);
    HRESULT get_onhashchange(VARIANT* p);
    HRESULT get_maxConnectionsPerServer(int* p);
    HRESULT postMessage(BSTR msg, VARIANT targetOrigin);
    HRESULT toStaticHTML(BSTR bstrHTML, BSTR* pbstrStaticHTML);
    HRESULT put_onmessage(VARIANT v);
    HRESULT get_onmessage(VARIANT* p);
    HRESULT msWriteProfilerMark(BSTR bstrProfilerMarkName);
}

const GUID IID_IHTMLWindow7 = {0x305104B7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104B7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLWindow7 : IDispatch
{
    HRESULT getSelection(IHTMLSelection* ppIHTMLSelection);
    HRESULT getComputedStyle(IHTMLDOMNode varArgIn, BSTR bstrPseudoElt, IHTMLCSSStyleDeclaration* ppComputedStyle);
    HRESULT get_styleMedia(IHTMLStyleMedia* p);
    HRESULT put_performance(VARIANT v);
    HRESULT get_performance(VARIANT* p);
    HRESULT get_innerWidth(int* p);
    HRESULT get_innerHeight(int* p);
    HRESULT get_pageXOffset(int* p);
    HRESULT get_pageYOffset(int* p);
    HRESULT get_screenX(int* p);
    HRESULT get_screenY(int* p);
    HRESULT get_outerWidth(int* p);
    HRESULT get_outerHeight(int* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_oncanplay(VARIANT v);
    HRESULT get_oncanplay(VARIANT* p);
    HRESULT put_oncanplaythrough(VARIANT v);
    HRESULT get_oncanplaythrough(VARIANT* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onclick(VARIANT v);
    HRESULT get_onclick(VARIANT* p);
    HRESULT put_oncontextmenu(VARIANT v);
    HRESULT get_oncontextmenu(VARIANT* p);
    HRESULT put_ondblclick(VARIANT v);
    HRESULT get_ondblclick(VARIANT* p);
    HRESULT put_ondrag(VARIANT v);
    HRESULT get_ondrag(VARIANT* p);
    HRESULT put_ondragend(VARIANT v);
    HRESULT get_ondragend(VARIANT* p);
    HRESULT put_ondragenter(VARIANT v);
    HRESULT get_ondragenter(VARIANT* p);
    HRESULT put_ondragleave(VARIANT v);
    HRESULT get_ondragleave(VARIANT* p);
    HRESULT put_ondragover(VARIANT v);
    HRESULT get_ondragover(VARIANT* p);
    HRESULT put_ondragstart(VARIANT v);
    HRESULT get_ondragstart(VARIANT* p);
    HRESULT put_ondrop(VARIANT v);
    HRESULT get_ondrop(VARIANT* p);
    HRESULT put_ondurationchange(VARIANT v);
    HRESULT get_ondurationchange(VARIANT* p);
    HRESULT put_onfocusin(VARIANT v);
    HRESULT get_onfocusin(VARIANT* p);
    HRESULT put_onfocusout(VARIANT v);
    HRESULT get_onfocusout(VARIANT* p);
    HRESULT put_oninput(VARIANT v);
    HRESULT get_oninput(VARIANT* p);
    HRESULT put_onemptied(VARIANT v);
    HRESULT get_onemptied(VARIANT* p);
    HRESULT put_onended(VARIANT v);
    HRESULT get_onended(VARIANT* p);
    HRESULT put_onkeydown(VARIANT v);
    HRESULT get_onkeydown(VARIANT* p);
    HRESULT put_onkeypress(VARIANT v);
    HRESULT get_onkeypress(VARIANT* p);
    HRESULT put_onkeyup(VARIANT v);
    HRESULT get_onkeyup(VARIANT* p);
    HRESULT put_onloadeddata(VARIANT v);
    HRESULT get_onloadeddata(VARIANT* p);
    HRESULT put_onloadedmetadata(VARIANT v);
    HRESULT get_onloadedmetadata(VARIANT* p);
    HRESULT put_onloadstart(VARIANT v);
    HRESULT get_onloadstart(VARIANT* p);
    HRESULT put_onmousedown(VARIANT v);
    HRESULT get_onmousedown(VARIANT* p);
    HRESULT put_onmouseenter(VARIANT v);
    HRESULT get_onmouseenter(VARIANT* p);
    HRESULT put_onmouseleave(VARIANT v);
    HRESULT get_onmouseleave(VARIANT* p);
    HRESULT put_onmousemove(VARIANT v);
    HRESULT get_onmousemove(VARIANT* p);
    HRESULT put_onmouseout(VARIANT v);
    HRESULT get_onmouseout(VARIANT* p);
    HRESULT put_onmouseover(VARIANT v);
    HRESULT get_onmouseover(VARIANT* p);
    HRESULT put_onmouseup(VARIANT v);
    HRESULT get_onmouseup(VARIANT* p);
    HRESULT put_onmousewheel(VARIANT v);
    HRESULT get_onmousewheel(VARIANT* p);
    HRESULT put_onoffline(VARIANT v);
    HRESULT get_onoffline(VARIANT* p);
    HRESULT put_ononline(VARIANT v);
    HRESULT get_ononline(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onratechange(VARIANT v);
    HRESULT get_onratechange(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT put_onseeked(VARIANT v);
    HRESULT get_onseeked(VARIANT* p);
    HRESULT put_onseeking(VARIANT v);
    HRESULT get_onseeking(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onstalled(VARIANT v);
    HRESULT get_onstalled(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onsuspend(VARIANT v);
    HRESULT get_onsuspend(VARIANT* p);
    HRESULT put_ontimeupdate(VARIANT v);
    HRESULT get_ontimeupdate(VARIANT* p);
    HRESULT put_onpause(VARIANT v);
    HRESULT get_onpause(VARIANT* p);
    HRESULT put_onplay(VARIANT v);
    HRESULT get_onplay(VARIANT* p);
    HRESULT put_onplaying(VARIANT v);
    HRESULT get_onplaying(VARIANT* p);
    HRESULT put_onvolumechange(VARIANT v);
    HRESULT get_onvolumechange(VARIANT* p);
    HRESULT put_onwaiting(VARIANT v);
    HRESULT get_onwaiting(VARIANT* p);
}

const GUID IID_IHTMLWindow8 = {0x305107AB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107AB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLWindow8 : IDispatch
{
    HRESULT put_onmspointerdown(VARIANT v);
    HRESULT get_onmspointerdown(VARIANT* p);
    HRESULT put_onmspointermove(VARIANT v);
    HRESULT get_onmspointermove(VARIANT* p);
    HRESULT put_onmspointerup(VARIANT v);
    HRESULT get_onmspointerup(VARIANT* p);
    HRESULT put_onmspointerover(VARIANT v);
    HRESULT get_onmspointerover(VARIANT* p);
    HRESULT put_onmspointerout(VARIANT v);
    HRESULT get_onmspointerout(VARIANT* p);
    HRESULT put_onmspointercancel(VARIANT v);
    HRESULT get_onmspointercancel(VARIANT* p);
    HRESULT put_onmspointerhover(VARIANT v);
    HRESULT get_onmspointerhover(VARIANT* p);
    HRESULT put_onmsgesturestart(VARIANT v);
    HRESULT get_onmsgesturestart(VARIANT* p);
    HRESULT put_onmsgesturechange(VARIANT v);
    HRESULT get_onmsgesturechange(VARIANT* p);
    HRESULT put_onmsgestureend(VARIANT v);
    HRESULT get_onmsgestureend(VARIANT* p);
    HRESULT put_onmsgesturehold(VARIANT v);
    HRESULT get_onmsgesturehold(VARIANT* p);
    HRESULT put_onmsgesturetap(VARIANT v);
    HRESULT get_onmsgesturetap(VARIANT* p);
    HRESULT put_onmsgesturedoubletap(VARIANT v);
    HRESULT get_onmsgesturedoubletap(VARIANT* p);
    HRESULT put_onmsinertiastart(VARIANT v);
    HRESULT get_onmsinertiastart(VARIANT* p);
    HRESULT get_applicationCache(IHTMLApplicationCache* p);
    HRESULT put_onpopstate(VARIANT v);
    HRESULT get_onpopstate(VARIANT* p);
}

const GUID IID_DispHTMLScreen = {0x3050F591, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F591, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLScreen : IDispatch
{
}

const GUID IID_DispHTMLWindow2 = {0x3050F55D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F55D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLWindow2 : IDispatch
{
}

const GUID IID_DispHTMLWindowProxy = {0x3050F55E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F55E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLWindowProxy : IDispatch
{
}

const GUID IID_IHTMLDocumentCompatibleInfo = {0x3051041A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051041A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDocumentCompatibleInfo : IDispatch
{
    HRESULT get_userAgent(BSTR* p);
    HRESULT get_version(BSTR* p);
}

const GUID IID_IHTMLDocumentCompatibleInfoCollection = {0x30510418, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510418, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDocumentCompatibleInfoCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLDocumentCompatibleInfo* compatibleInfo);
}

const GUID IID_DispHTMLDocumentCompatibleInfo = {0x3050F53E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F53E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDocumentCompatibleInfo : IDispatch
{
}

const GUID IID_DispHTMLDocumentCompatibleInfoCollection = {0x3050F53F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F53F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDocumentCompatibleInfoCollection : IDispatch
{
}

const GUID IID_HTMLDocumentEvents4 = {0x30510737, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510737, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLDocumentEvents4 : IDispatch
{
}

const GUID IID_HTMLDocumentEvents3 = {0x3050F5A0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5A0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLDocumentEvents3 : IDispatch
{
}

const GUID IID_HTMLDocumentEvents2 = {0x3050F613, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F613, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLDocumentEvents2 : IDispatch
{
}

const GUID IID_HTMLDocumentEvents = {0x3050F260, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F260, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLDocumentEvents : IDispatch
{
}

const GUID IID_ISVGSVGElement = {0x305104E7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104E7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGSVGElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
    HRESULT put_contentScriptType(BSTR v);
    HRESULT get_contentScriptType(BSTR* p);
    HRESULT put_contentStyleType(BSTR v);
    HRESULT get_contentStyleType(BSTR* p);
    HRESULT putref_viewport(ISVGRect v);
    HRESULT get_viewport(ISVGRect* p);
    HRESULT put_pixelUnitToMillimeterX(float v);
    HRESULT get_pixelUnitToMillimeterX(float* p);
    HRESULT put_pixelUnitToMillimeterY(float v);
    HRESULT get_pixelUnitToMillimeterY(float* p);
    HRESULT put_screenPixelToMillimeterX(float v);
    HRESULT get_screenPixelToMillimeterX(float* p);
    HRESULT put_screenPixelToMillimeterY(float v);
    HRESULT get_screenPixelToMillimeterY(float* p);
    HRESULT put_useCurrentView(short v);
    HRESULT get_useCurrentView(short* p);
    HRESULT putref_currentView(ISVGViewSpec v);
    HRESULT get_currentView(ISVGViewSpec* p);
    HRESULT put_currentScale(float v);
    HRESULT get_currentScale(float* p);
    HRESULT putref_currentTranslate(ISVGPoint v);
    HRESULT get_currentTranslate(ISVGPoint* p);
    HRESULT suspendRedraw(uint maxWaitMilliseconds, uint* pResult);
    HRESULT unsuspendRedraw(uint suspendHandeID);
    HRESULT unsuspendRedrawAll();
    HRESULT forceRedraw();
    HRESULT pauseAnimations();
    HRESULT unpauseAnimations();
    HRESULT animationsPaused(short* pResult);
    HRESULT getCurrentTime(float* pResult);
    HRESULT setCurrentTime(float seconds);
    HRESULT getIntersectionList(ISVGRect rect, ISVGElement referenceElement, VARIANT* pResult);
    HRESULT getEnclosureList(ISVGRect rect, ISVGElement referenceElement, VARIANT* pResult);
    HRESULT checkIntersection(ISVGElement element, ISVGRect rect, short* pResult);
    HRESULT checkEnclosure(ISVGElement element, ISVGRect rect, short* pResult);
    HRESULT deselectAll();
    HRESULT createSVGNumber(ISVGNumber* pResult);
    HRESULT createSVGLength(ISVGLength* pResult);
    HRESULT createSVGAngle(ISVGAngle* pResult);
    HRESULT createSVGPoint(ISVGPoint* pResult);
    HRESULT createSVGMatrix(ISVGMatrix* pResult);
    HRESULT createSVGRect(ISVGRect* pResult);
    HRESULT createSVGTransform(ISVGTransform* pResult);
    HRESULT createSVGTransformFromMatrix(ISVGMatrix matrix, ISVGTransform* pResult);
    HRESULT getElementById(BSTR elementId, IHTMLElement* pResult);
}

const GUID IID_IDOMNodeIterator = {0x30510746, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510746, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMNodeIterator : IDispatch
{
    HRESULT get_root(IDispatch* p);
    HRESULT get_whatToShow(uint* p);
    HRESULT get_filter(IDispatch* p);
    HRESULT get_expandEntityReferences(short* p);
    HRESULT nextNode(IDispatch* ppRetNode);
    HRESULT previousNode(IDispatch* ppRetNode);
    HRESULT detach();
}

const GUID IID_IDOMTreeWalker = {0x30510748, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510748, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMTreeWalker : IDispatch
{
    HRESULT get_root(IDispatch* p);
    HRESULT get_whatToShow(uint* p);
    HRESULT get_filter(IDispatch* p);
    HRESULT get_expandEntityReferences(short* p);
    HRESULT putref_currentNode(IDispatch v);
    HRESULT get_currentNode(IDispatch* p);
    HRESULT parentNode(IDispatch* ppRetNode);
    HRESULT firstChild(IDispatch* ppRetNode);
    HRESULT lastChild(IDispatch* ppRetNode);
    HRESULT previousSibling(IDispatch* ppRetNode);
    HRESULT nextSibling(IDispatch* ppRetNode);
    HRESULT previousNode(IDispatch* ppRetNode);
    HRESULT nextNode(IDispatch* ppRetNode);
}

const GUID IID_IDOMProcessingInstruction = {0x30510742, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510742, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMProcessingInstruction : IDispatch
{
    HRESULT get_target(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
}

const GUID IID_IHTMLDocument3 = {0x3050F485, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F485, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDocument3 : IDispatch
{
    HRESULT releaseCapture();
    HRESULT recalc(short fForce);
    HRESULT createTextNode(BSTR text, IHTMLDOMNode* newTextNode);
    HRESULT get_documentElement(IHTMLElement* p);
    HRESULT get_uniqueID(BSTR* p);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, short* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
    HRESULT put_onrowsdelete(VARIANT v);
    HRESULT get_onrowsdelete(VARIANT* p);
    HRESULT put_onrowsinserted(VARIANT v);
    HRESULT get_onrowsinserted(VARIANT* p);
    HRESULT put_oncellchange(VARIANT v);
    HRESULT get_oncellchange(VARIANT* p);
    HRESULT put_ondatasetchanged(VARIANT v);
    HRESULT get_ondatasetchanged(VARIANT* p);
    HRESULT put_ondataavailable(VARIANT v);
    HRESULT get_ondataavailable(VARIANT* p);
    HRESULT put_ondatasetcomplete(VARIANT v);
    HRESULT get_ondatasetcomplete(VARIANT* p);
    HRESULT put_onpropertychange(VARIANT v);
    HRESULT get_onpropertychange(VARIANT* p);
    HRESULT put_dir(BSTR v);
    HRESULT get_dir(BSTR* p);
    HRESULT put_oncontextmenu(VARIANT v);
    HRESULT get_oncontextmenu(VARIANT* p);
    HRESULT put_onstop(VARIANT v);
    HRESULT get_onstop(VARIANT* p);
    HRESULT createDocumentFragment(IHTMLDocument2* pNewDoc);
    HRESULT get_parentDocument(IHTMLDocument2* p);
    HRESULT put_enableDownload(short v);
    HRESULT get_enableDownload(short* p);
    HRESULT put_baseUrl(BSTR v);
    HRESULT get_baseUrl(BSTR* p);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT put_inheritStyleSheets(short v);
    HRESULT get_inheritStyleSheets(short* p);
    HRESULT put_onbeforeeditfocus(VARIANT v);
    HRESULT get_onbeforeeditfocus(VARIANT* p);
    HRESULT getElementsByName(BSTR v, IHTMLElementCollection* pelColl);
    HRESULT getElementById(BSTR v, IHTMLElement* pel);
    HRESULT getElementsByTagName(BSTR v, IHTMLElementCollection* pelColl);
}

const GUID IID_IHTMLDocument4 = {0x3050F69A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F69A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDocument4 : IDispatch
{
    HRESULT focus();
    HRESULT hasFocus(short* pfFocus);
    HRESULT put_onselectionchange(VARIANT v);
    HRESULT get_onselectionchange(VARIANT* p);
    HRESULT get_namespaces(IDispatch* p);
    HRESULT createDocumentFromUrl(BSTR bstrUrl, BSTR bstrOptions, IHTMLDocument2* newDoc);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
    HRESULT createEventObject(VARIANT* pvarEventObject, IHTMLEventObj* ppEventObj);
    HRESULT fireEvent(BSTR bstrEventName, VARIANT* pvarEventObject, short* pfCancelled);
    HRESULT createRenderStyle(BSTR v, IHTMLRenderStyle* ppIHTMLRenderStyle);
    HRESULT put_oncontrolselect(VARIANT v);
    HRESULT get_oncontrolselect(VARIANT* p);
    HRESULT get_URLUnencoded(BSTR* p);
}

const GUID IID_IHTMLDocument5 = {0x3050F80C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F80C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDocument5 : IDispatch
{
    HRESULT put_onmousewheel(VARIANT v);
    HRESULT get_onmousewheel(VARIANT* p);
    HRESULT get_doctype(IHTMLDOMNode* p);
    HRESULT get_implementation(IHTMLDOMImplementation* p);
    HRESULT createAttribute(BSTR bstrattrName, IHTMLDOMAttribute* ppattribute);
    HRESULT createComment(BSTR bstrdata, IHTMLDOMNode* ppRetNode);
    HRESULT put_onfocusin(VARIANT v);
    HRESULT get_onfocusin(VARIANT* p);
    HRESULT put_onfocusout(VARIANT v);
    HRESULT get_onfocusout(VARIANT* p);
    HRESULT put_onactivate(VARIANT v);
    HRESULT get_onactivate(VARIANT* p);
    HRESULT put_ondeactivate(VARIANT v);
    HRESULT get_ondeactivate(VARIANT* p);
    HRESULT put_onbeforeactivate(VARIANT v);
    HRESULT get_onbeforeactivate(VARIANT* p);
    HRESULT put_onbeforedeactivate(VARIANT v);
    HRESULT get_onbeforedeactivate(VARIANT* p);
    HRESULT get_compatMode(BSTR* p);
}

const GUID IID_IHTMLDocument6 = {0x30510417, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510417, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDocument6 : IDispatch
{
    HRESULT get_compatible(IHTMLDocumentCompatibleInfoCollection* p);
    HRESULT get_documentMode(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
    HRESULT put_onstoragecommit(VARIANT v);
    HRESULT get_onstoragecommit(VARIANT* p);
    HRESULT getElementById(BSTR bstrId, IHTMLElement2* ppRetElement);
    HRESULT updateSettings();
}

const GUID IID_IHTMLDocument8 = {0x305107D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDocument8 : IDispatch
{
    HRESULT put_onmscontentzoom(VARIANT v);
    HRESULT get_onmscontentzoom(VARIANT* p);
    HRESULT put_onmspointerdown(VARIANT v);
    HRESULT get_onmspointerdown(VARIANT* p);
    HRESULT put_onmspointermove(VARIANT v);
    HRESULT get_onmspointermove(VARIANT* p);
    HRESULT put_onmspointerup(VARIANT v);
    HRESULT get_onmspointerup(VARIANT* p);
    HRESULT put_onmspointerover(VARIANT v);
    HRESULT get_onmspointerover(VARIANT* p);
    HRESULT put_onmspointerout(VARIANT v);
    HRESULT get_onmspointerout(VARIANT* p);
    HRESULT put_onmspointercancel(VARIANT v);
    HRESULT get_onmspointercancel(VARIANT* p);
    HRESULT put_onmspointerhover(VARIANT v);
    HRESULT get_onmspointerhover(VARIANT* p);
    HRESULT put_onmsgesturestart(VARIANT v);
    HRESULT get_onmsgesturestart(VARIANT* p);
    HRESULT put_onmsgesturechange(VARIANT v);
    HRESULT get_onmsgesturechange(VARIANT* p);
    HRESULT put_onmsgestureend(VARIANT v);
    HRESULT get_onmsgestureend(VARIANT* p);
    HRESULT put_onmsgesturehold(VARIANT v);
    HRESULT get_onmsgesturehold(VARIANT* p);
    HRESULT put_onmsgesturetap(VARIANT v);
    HRESULT get_onmsgesturetap(VARIANT* p);
    HRESULT put_onmsgesturedoubletap(VARIANT v);
    HRESULT get_onmsgesturedoubletap(VARIANT* p);
    HRESULT put_onmsinertiastart(VARIANT v);
    HRESULT get_onmsinertiastart(VARIANT* p);
    HRESULT elementsFromPoint(float x, float y, IHTMLDOMChildrenCollection* elementsHit);
    HRESULT elementsFromRect(float left, float top, float width, float height, IHTMLDOMChildrenCollection* elementsHit);
    HRESULT put_onmsmanipulationstatechanged(VARIANT v);
    HRESULT get_onmsmanipulationstatechanged(VARIANT* p);
    HRESULT put_msCapsLockWarningOff(short v);
    HRESULT get_msCapsLockWarningOff(short* p);
}

const GUID IID_IDocumentEvent = {0x305104BC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104BC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDocumentEvent : IDispatch
{
    HRESULT createEvent(BSTR eventType, IDOMEvent* ppEvent);
}

const GUID IID_IDocumentRange = {0x305104AF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104AF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDocumentRange : IDispatch
{
    HRESULT createRange(IHTMLDOMRange* ppIHTMLDOMRange);
}

const GUID IID_IDocumentSelector = {0x30510462, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510462, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDocumentSelector : IDispatch
{
    HRESULT querySelector(BSTR v, IHTMLElement* pel);
    HRESULT querySelectorAll(BSTR v, IHTMLDOMChildrenCollection* pel);
}

const GUID IID_IDocumentTraversal = {0x30510744, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510744, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDocumentTraversal : IDispatch
{
    HRESULT createNodeIterator(IDispatch pRootNode, int ulWhatToShow, VARIANT* pFilter, short fEntityReferenceExpansion, IDOMNodeIterator* ppNodeIterator);
    HRESULT createTreeWalker(IDispatch pRootNode, int ulWhatToShow, VARIANT* pFilter, short fEntityReferenceExpansion, IDOMTreeWalker* ppTreeWalker);
}

const GUID IID_DispHTMLDocument = {0x3050F55F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F55F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDocument : IDispatch
{
}

const GUID IID_DWebBridgeEvents = {0xA6D897FF, 0x0A95, 0x11D1, [0xB0, 0xBA, 0x00, 0x60, 0x08, 0x16, 0x6E, 0x11]};
@GUID(0xA6D897FF, 0x0A95, 0x11D1, [0xB0, 0xBA, 0x00, 0x60, 0x08, 0x16, 0x6E, 0x11]);
interface DWebBridgeEvents : IDispatch
{
}

const GUID IID_IWebBridge = {0xAE24FDAD, 0x03C6, 0x11D1, [0x8B, 0x76, 0x00, 0x80, 0xC7, 0x44, 0xF3, 0x89]};
@GUID(0xAE24FDAD, 0x03C6, 0x11D1, [0x8B, 0x76, 0x00, 0x80, 0xC7, 0x44, 0xF3, 0x89]);
interface IWebBridge : IDispatch
{
    HRESULT put_URL(BSTR v);
    HRESULT get_URL(BSTR* p);
    HRESULT put_Scrollbar(short v);
    HRESULT get_Scrollbar(short* p);
    HRESULT put_embed(short v);
    HRESULT get_embed(short* p);
    HRESULT get_event(IDispatch* p);
    HRESULT get_readyState(int* p);
    HRESULT AboutBox();
}

const GUID IID_IWBScriptControl = {0xA5170870, 0x0CF8, 0x11D1, [0x8B, 0x91, 0x00, 0x80, 0xC7, 0x44, 0xF3, 0x89]};
@GUID(0xA5170870, 0x0CF8, 0x11D1, [0x8B, 0x91, 0x00, 0x80, 0xC7, 0x44, 0xF3, 0x89]);
interface IWBScriptControl : IDispatch
{
    HRESULT raiseEvent(BSTR name, VARIANT eventData);
    HRESULT bubbleEvent();
    HRESULT setContextMenu(VARIANT menuItemPairs);
    HRESULT put_selectableContent(short v);
    HRESULT get_selectableContent(short* p);
    HRESULT get_frozen(short* p);
    HRESULT put_scrollbar(short v);
    HRESULT get_scrollbar(short* p);
    HRESULT get_version(BSTR* p);
    HRESULT get_visibility(short* p);
    HRESULT put_onvisibilitychange(VARIANT v);
    HRESULT get_onvisibilitychange(VARIANT* p);
}

const GUID IID_IHTMLEmbedElement = {0x3050F25F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F25F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEmbedElement : IDispatch
{
    HRESULT put_hidden(BSTR v);
    HRESULT get_hidden(BSTR* p);
    HRESULT get_palette(BSTR* p);
    HRESULT get_pluginspage(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_units(BSTR v);
    HRESULT get_units(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
}

const GUID IID_IHTMLEmbedElement2 = {0x30510493, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510493, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEmbedElement2 : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT get_pluginspage(BSTR* p);
}

const GUID IID_DispHTMLEmbed = {0x3050F52E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F52E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLEmbed : IDispatch
{
}

const GUID IID_HTMLMapEvents2 = {0x3050F61E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F61E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLMapEvents2 : IDispatch
{
}

const GUID IID_HTMLMapEvents = {0x3050F3BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLMapEvents : IDispatch
{
}

const GUID IID_IHTMLAreasCollection = {0x3050F383, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F383, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAreasCollection : IDispatch
{
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
    HRESULT add(IHTMLElement element, VARIANT before);
    HRESULT remove(int index);
}

const GUID IID_IHTMLAreasCollection2 = {0x3050F5EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAreasCollection2 : IDispatch
{
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

const GUID IID_IHTMLAreasCollection3 = {0x3050F837, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F837, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAreasCollection3 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

const GUID IID_IHTMLAreasCollection4 = {0x30510492, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510492, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAreasCollection4 : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLElement2* pNode);
    HRESULT namedItem(BSTR name, IHTMLElement2* pNode);
}

const GUID IID_IHTMLMapElement = {0x3050F266, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F266, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMapElement : IDispatch
{
    HRESULT get_areas(IHTMLAreasCollection* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
}

const GUID IID_DispHTMLAreasCollection = {0x3050F56A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F56A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLAreasCollection : IDispatch
{
}

const GUID IID_DispHTMLMapElement = {0x3050F526, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F526, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLMapElement : IDispatch
{
}

const GUID IID_HTMLAreaEvents2 = {0x3050F611, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F611, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLAreaEvents2 : IDispatch
{
}

const GUID IID_HTMLAreaEvents = {0x3050F366, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F366, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLAreaEvents : IDispatch
{
}

const GUID IID_IHTMLAreaElement = {0x3050F265, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F265, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAreaElement : IDispatch
{
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_noHref(short v);
    HRESULT get_noHref(short* p);
    HRESULT put_host(BSTR v);
    HRESULT get_host(BSTR* p);
    HRESULT put_hostname(BSTR v);
    HRESULT get_hostname(BSTR* p);
    HRESULT put_pathname(BSTR v);
    HRESULT get_pathname(BSTR* p);
    HRESULT put_port(BSTR v);
    HRESULT get_port(BSTR* p);
    HRESULT put_protocol(BSTR v);
    HRESULT get_protocol(BSTR* p);
    HRESULT put_search(BSTR v);
    HRESULT get_search(BSTR* p);
    HRESULT put_hash(BSTR v);
    HRESULT get_hash(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT blur();
}

const GUID IID_IHTMLAreaElement2 = {0x3051041F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051041F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAreaElement2 : IDispatch
{
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

const GUID IID_DispHTMLAreaElement = {0x3050F503, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F503, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLAreaElement : IDispatch
{
}

const GUID IID_IHTMLTableCaption = {0x3050F2EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableCaption : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
}

const GUID IID_DispHTMLTableCaption = {0x3050F508, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F508, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLTableCaption : IDispatch
{
}

const GUID IID_IHTMLCommentElement = {0x3050F20C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F20C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCommentElement : IDispatch
{
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT put_atomic(int v);
    HRESULT get_atomic(int* p);
}

const GUID IID_IHTMLCommentElement2 = {0x3050F813, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F813, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCommentElement2 : IDispatch
{
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
    HRESULT get_length(int* p);
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT appendData(BSTR bstrstring);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
}

const GUID IID_IHTMLCommentElement3 = {0x3051073F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051073F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCommentElement3 : IDispatch
{
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
}

const GUID IID_DispHTMLCommentElement = {0x3050F50A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F50A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLCommentElement : IDispatch
{
}

const GUID IID_IHTMLPhraseElement = {0x3050F20A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F20A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPhraseElement : IDispatch
{
}

const GUID IID_IHTMLPhraseElement2 = {0x3050F824, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F824, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPhraseElement2 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
    HRESULT put_dateTime(BSTR v);
    HRESULT get_dateTime(BSTR* p);
}

const GUID IID_IHTMLPhraseElement3 = {0x3051043D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051043D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPhraseElement3 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
}

const GUID IID_IHTMLSpanElement = {0x3050F3F3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3F3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSpanElement : IDispatch
{
}

const GUID IID_DispHTMLPhraseElement = {0x3050F52D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F52D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLPhraseElement : IDispatch
{
}

const GUID IID_DispHTMLSpanElement = {0x3050F548, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F548, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLSpanElement : IDispatch
{
}

const GUID IID_HTMLTableEvents2 = {0x3050F623, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F623, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLTableEvents2 : IDispatch
{
}

const GUID IID_HTMLTableEvents = {0x3050F407, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F407, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLTableEvents : IDispatch
{
}

const GUID IID_IHTMLTableSection = {0x3050F23B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F23B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableSection : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT get_rows(IHTMLElementCollection* p);
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
}

const GUID IID_IHTMLTable = {0x3050F21E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F21E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTable : IDispatch
{
    HRESULT put_cols(int v);
    HRESULT get_cols(int* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_frame(BSTR v);
    HRESULT get_frame(BSTR* p);
    HRESULT put_rules(BSTR v);
    HRESULT get_rules(BSTR* p);
    HRESULT put_cellSpacing(VARIANT v);
    HRESULT get_cellSpacing(VARIANT* p);
    HRESULT put_cellPadding(VARIANT v);
    HRESULT get_cellPadding(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_borderColorLight(VARIANT v);
    HRESULT get_borderColorLight(VARIANT* p);
    HRESULT put_borderColorDark(VARIANT v);
    HRESULT get_borderColorDark(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT refresh();
    HRESULT get_rows(IHTMLElementCollection* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_dataPageSize(int v);
    HRESULT get_dataPageSize(int* p);
    HRESULT nextPage();
    HRESULT previousPage();
    HRESULT get_tHead(IHTMLTableSection* p);
    HRESULT get_tFoot(IHTMLTableSection* p);
    HRESULT get_tBodies(IHTMLElementCollection* p);
    HRESULT get_caption(IHTMLTableCaption* p);
    HRESULT createTHead(IDispatch* head);
    HRESULT deleteTHead();
    HRESULT createTFoot(IDispatch* foot);
    HRESULT deleteTFoot();
    HRESULT createCaption(IHTMLTableCaption* caption);
    HRESULT deleteCaption();
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
}

const GUID IID_IHTMLTable2 = {0x3050F4AD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4AD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTable2 : IDispatch
{
    HRESULT firstPage();
    HRESULT lastPage();
    HRESULT get_cells(IHTMLElementCollection* p);
    HRESULT moveRow(int indexFrom, int indexTo, IDispatch* row);
}

const GUID IID_IHTMLTable3 = {0x3050F829, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F829, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTable3 : IDispatch
{
    HRESULT put_summary(BSTR v);
    HRESULT get_summary(BSTR* p);
}

const GUID IID_IHTMLTable4 = {0x305106C2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106C2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTable4 : IDispatch
{
    HRESULT putref_tHead(IHTMLTableSection v);
    HRESULT get_tHead(IHTMLTableSection* p);
    HRESULT putref_tFoot(IHTMLTableSection v);
    HRESULT get_tFoot(IHTMLTableSection* p);
    HRESULT putref_caption(IHTMLTableCaption v);
    HRESULT get_caption(IHTMLTableCaption* p);
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
    HRESULT createTBody(IHTMLTableSection* tbody);
}

const GUID IID_IHTMLTableCol = {0x3050F23A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F23A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableCol : IDispatch
{
    HRESULT put_span(int v);
    HRESULT get_span(int* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
}

const GUID IID_IHTMLTableCol2 = {0x3050F82A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F82A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableCol2 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

const GUID IID_IHTMLTableCol3 = {0x305106C4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106C4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableCol3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

const GUID IID_IHTMLTableSection2 = {0x3050F5C7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5C7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableSection2 : IDispatch
{
    HRESULT moveRow(int indexFrom, int indexTo, IDispatch* row);
}

const GUID IID_IHTMLTableSection3 = {0x3050F82B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F82B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableSection3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

const GUID IID_IHTMLTableSection4 = {0x305106C5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106C5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableSection4 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
}

const GUID IID_IHTMLTableRow = {0x3050F23C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F23C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableRow : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_borderColorLight(VARIANT v);
    HRESULT get_borderColorLight(VARIANT* p);
    HRESULT put_borderColorDark(VARIANT v);
    HRESULT get_borderColorDark(VARIANT* p);
    HRESULT get_rowIndex(int* p);
    HRESULT get_sectionRowIndex(int* p);
    HRESULT get_cells(IHTMLElementCollection* p);
    HRESULT insertCell(int index, IDispatch* row);
    HRESULT deleteCell(int index);
}

const GUID IID_IHTMLTableRow2 = {0x3050F4A1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4A1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableRow2 : IDispatch
{
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
}

const GUID IID_IHTMLTableRow3 = {0x3050F82C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F82C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableRow3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

const GUID IID_IHTMLTableRow4 = {0x305106C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableRow4 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
    HRESULT insertCell(int index, IDispatch* row);
    HRESULT deleteCell(int index);
}

const GUID IID_IHTMLTableRowMetrics = {0x3050F413, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F413, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableRowMetrics : IDispatch
{
    HRESULT get_clientHeight(int* p);
    HRESULT get_clientWidth(int* p);
    HRESULT get_clientTop(int* p);
    HRESULT get_clientLeft(int* p);
}

const GUID IID_IHTMLTableCell = {0x3050F23D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F23D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableCell : IDispatch
{
    HRESULT put_rowSpan(int v);
    HRESULT get_rowSpan(int* p);
    HRESULT put_colSpan(int v);
    HRESULT get_colSpan(int* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_noWrap(short v);
    HRESULT get_noWrap(short* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_borderColorLight(VARIANT v);
    HRESULT get_borderColorLight(VARIANT* p);
    HRESULT put_borderColorDark(VARIANT v);
    HRESULT get_borderColorDark(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT get_cellIndex(int* p);
}

const GUID IID_IHTMLTableCell2 = {0x3050F82D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F82D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableCell2 : IDispatch
{
    HRESULT put_abbr(BSTR v);
    HRESULT get_abbr(BSTR* p);
    HRESULT put_axis(BSTR v);
    HRESULT get_axis(BSTR* p);
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
    HRESULT put_headers(BSTR v);
    HRESULT get_headers(BSTR* p);
    HRESULT put_scope(BSTR v);
    HRESULT get_scope(BSTR* p);
}

const GUID IID_IHTMLTableCell3 = {0x305106C7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106C7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTableCell3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

const GUID IID_DispHTMLTable = {0x3050F532, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F532, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLTable : IDispatch
{
}

const GUID IID_DispHTMLTableCol = {0x3050F533, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F533, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLTableCol : IDispatch
{
}

const GUID IID_DispHTMLTableSection = {0x3050F534, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F534, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLTableSection : IDispatch
{
}

const GUID IID_DispHTMLTableRow = {0x3050F535, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F535, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLTableRow : IDispatch
{
}

const GUID IID_DispHTMLTableCell = {0x3050F536, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F536, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLTableCell : IDispatch
{
}

const GUID IID_HTMLScriptEvents2 = {0x3050F621, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F621, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLScriptEvents2 : IDispatch
{
}

const GUID IID_HTMLScriptEvents = {0x3050F3E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLScriptEvents : IDispatch
{
}

const GUID IID_IHTMLScriptElement = {0x3050F28B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F28B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLScriptElement : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_htmlFor(BSTR v);
    HRESULT get_htmlFor(BSTR* p);
    HRESULT put_event(BSTR v);
    HRESULT get_event(BSTR* p);
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT put_defer(short v);
    HRESULT get_defer(short* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

const GUID IID_IHTMLScriptElement2 = {0x3050F828, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F828, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLScriptElement2 : IDispatch
{
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
}

const GUID IID_IHTMLScriptElement3 = {0x30510447, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510447, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLScriptElement3 : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
}

const GUID IID_IHTMLScriptElement4 = {0x30510801, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510801, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLScriptElement4 : IDispatch
{
    HRESULT get_usedCharset(BSTR* p);
}

const GUID IID_DispHTMLScriptElement = {0x3050F530, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F530, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLScriptElement : IDispatch
{
}

const GUID IID_IHTMLNoShowElement = {0x3050F38A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F38A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLNoShowElement : IDispatch
{
}

const GUID IID_DispHTMLNoShowElement = {0x3050F528, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F528, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLNoShowElement : IDispatch
{
}

const GUID IID_HTMLObjectElementEvents2 = {0x3050F620, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F620, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLObjectElementEvents2 : IDispatch
{
}

const GUID IID_HTMLObjectElementEvents = {0x3050F3C4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3C4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLObjectElementEvents : IDispatch
{
}

const GUID IID_IHTMLObjectElement = {0x3050F24F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F24F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLObjectElement : IDispatch
{
    HRESULT get_object(IDispatch* p);
    HRESULT get_classid(BSTR* p);
    HRESULT get_data(BSTR* p);
    HRESULT putref_recordset(IDispatch v);
    HRESULT get_recordset(IDispatch* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_codeBase(BSTR v);
    HRESULT get_codeBase(BSTR* p);
    HRESULT put_codeType(BSTR v);
    HRESULT get_codeType(BSTR* p);
    HRESULT put_code(BSTR v);
    HRESULT get_code(BSTR* p);
    HRESULT get_BaseHref(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT get_readyState(int* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_altHtml(BSTR v);
    HRESULT get_altHtml(BSTR* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
}

const GUID IID_IHTMLObjectElement2 = {0x3050F4CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLObjectElement2 : IDispatch
{
    HRESULT namedRecordset(BSTR dataMember, VARIANT* hierarchy, IDispatch* ppRecordset);
    HRESULT put_classid(BSTR v);
    HRESULT get_classid(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
}

const GUID IID_IHTMLObjectElement3 = {0x3050F827, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F827, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLObjectElement3 : IDispatch
{
    HRESULT put_archive(BSTR v);
    HRESULT get_archive(BSTR* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_declare(short v);
    HRESULT get_declare(short* p);
    HRESULT put_standby(BSTR v);
    HRESULT get_standby(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_useMap(BSTR v);
    HRESULT get_useMap(BSTR* p);
}

const GUID IID_IHTMLObjectElement4 = {0x3051043E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051043E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLObjectElement4 : IDispatch
{
    HRESULT get_contentDocument(IDispatch* p);
    HRESULT put_codeBase(BSTR v);
    HRESULT get_codeBase(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
}

const GUID IID_IHTMLObjectElement5 = {0x305104B5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104B5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLObjectElement5 : IDispatch
{
    HRESULT put_object(BSTR v);
    HRESULT get_object(BSTR* p);
}

const GUID IID_IHTMLParamElement = {0x3050F83D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F83D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLParamElement : IDispatch
{
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_valueType(BSTR v);
    HRESULT get_valueType(BSTR* p);
}

const GUID IID_IHTMLParamElement2 = {0x30510444, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510444, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLParamElement2 : IDispatch
{
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_valueType(BSTR v);
    HRESULT get_valueType(BSTR* p);
}

const GUID IID_DispHTMLObjectElement = {0x3050F529, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F529, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLObjectElement : IDispatch
{
}

const GUID IID_DispHTMLParamElement = {0x3050F590, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F590, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLParamElement : IDispatch
{
}

const GUID IID_HTMLFrameSiteEvents2 = {0x3050F7FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLFrameSiteEvents2 : IDispatch
{
}

const GUID IID_HTMLFrameSiteEvents = {0x3050F800, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F800, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLFrameSiteEvents : IDispatch
{
}

const GUID IID_IHTMLFrameBase2 = {0x3050F6DB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6DB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFrameBase2 : IDispatch
{
    HRESULT get_contentWindow(IHTMLWindow2* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_allowTransparency(short v);
    HRESULT get_allowTransparency(short* p);
}

const GUID IID_IHTMLFrameBase3 = {0x3050F82E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F82E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFrameBase3 : IDispatch
{
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
}

const GUID IID_DispHTMLFrameBase = {0x3050F541, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F541, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLFrameBase : IDispatch
{
}

const GUID IID_IHTMLFrameElement = {0x3050F313, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F313, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFrameElement : IDispatch
{
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
}

const GUID IID_IHTMLFrameElement2 = {0x3050F7F5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7F5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFrameElement2 : IDispatch
{
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
}

const GUID IID_IHTMLFrameElement3 = {0x3051042D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051042D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFrameElement3 : IDispatch
{
    HRESULT get_contentDocument(IDispatch* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
}

const GUID IID_DispHTMLFrameElement = {0x3050F513, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F513, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLFrameElement : IDispatch
{
}

const GUID IID_IHTMLIFrameElement = {0x3050F315, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F315, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLIFrameElement : IDispatch
{
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

const GUID IID_IHTMLIFrameElement2 = {0x3050F4E6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4E6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLIFrameElement2 : IDispatch
{
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
}

const GUID IID_IHTMLIFrameElement3 = {0x30510433, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510433, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLIFrameElement3 : IDispatch
{
    HRESULT get_contentDocument(IDispatch* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
}

const GUID IID_DispHTMLIFrame = {0x3050F51B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F51B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLIFrame : IDispatch
{
}

const GUID IID_IHTMLDivPosition = {0x3050F212, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F212, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDivPosition : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

const GUID IID_IHTMLFieldSetElement = {0x3050F3E7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3E7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFieldSetElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

const GUID IID_IHTMLFieldSetElement2 = {0x3050F833, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F833, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFieldSetElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

const GUID IID_IHTMLLegendElement = {0x3050F3EA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3EA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLLegendElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

const GUID IID_IHTMLLegendElement2 = {0x3050F834, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F834, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLLegendElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

const GUID IID_DispHTMLDivPosition = {0x3050F50F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F50F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLDivPosition : IDispatch
{
}

const GUID IID_DispHTMLFieldSetElement = {0x3050F545, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F545, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLFieldSetElement : IDispatch
{
}

const GUID IID_DispHTMLLegendElement = {0x3050F546, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F546, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLLegendElement : IDispatch
{
}

const GUID IID_IHTMLSpanFlow = {0x3050F3E5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3E5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSpanFlow : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

const GUID IID_DispHTMLSpanFlow = {0x3050F544, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F544, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLSpanFlow : IDispatch
{
}

const GUID IID_IHTMLFrameSetElement = {0x3050F319, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F319, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFrameSetElement : IDispatch
{
    HRESULT put_rows(BSTR v);
    HRESULT get_rows(BSTR* p);
    HRESULT put_cols(BSTR v);
    HRESULT get_cols(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
    HRESULT put_frameSpacing(VARIANT v);
    HRESULT get_frameSpacing(VARIANT* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onunload(VARIANT v);
    HRESULT get_onunload(VARIANT* p);
    HRESULT put_onbeforeunload(VARIANT v);
    HRESULT get_onbeforeunload(VARIANT* p);
}

const GUID IID_IHTMLFrameSetElement2 = {0x3050F5C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFrameSetElement2 : IDispatch
{
    HRESULT put_onbeforeprint(VARIANT v);
    HRESULT get_onbeforeprint(VARIANT* p);
    HRESULT put_onafterprint(VARIANT v);
    HRESULT get_onafterprint(VARIANT* p);
}

const GUID IID_IHTMLFrameSetElement3 = {0x30510796, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510796, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFrameSetElement3 : IDispatch
{
    HRESULT put_onhashchange(VARIANT v);
    HRESULT get_onhashchange(VARIANT* p);
    HRESULT put_onmessage(VARIANT v);
    HRESULT get_onmessage(VARIANT* p);
    HRESULT put_onoffline(VARIANT v);
    HRESULT get_onoffline(VARIANT* p);
    HRESULT put_ononline(VARIANT v);
    HRESULT get_ononline(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
}

const GUID IID_DispHTMLFrameSetSite = {0x3050F514, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F514, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLFrameSetSite : IDispatch
{
}

const GUID IID_IHTMLBGsound = {0x3050F369, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F369, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLBGsound : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_volume(VARIANT v);
    HRESULT get_volume(VARIANT* p);
    HRESULT put_balance(VARIANT v);
    HRESULT get_balance(VARIANT* p);
}

const GUID IID_DispHTMLBGsound = {0x3050F53C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F53C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLBGsound : IDispatch
{
}

const GUID IID_IHTMLFontNamesCollection = {0x3050F376, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F376, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFontNamesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, BSTR* pBstr);
}

const GUID IID_IHTMLFontSizesCollection = {0x3050F377, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F377, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLFontSizesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT get_forFont(BSTR* p);
    HRESULT item(int index, int* plSize);
}

const GUID IID_IHTMLOptionsHolder = {0x3050F378, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F378, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLOptionsHolder : IDispatch
{
    HRESULT get_document(IHTMLDocument2* p);
    HRESULT get_fonts(IHTMLFontNamesCollection* p);
    HRESULT put_execArg(VARIANT v);
    HRESULT get_execArg(VARIANT* p);
    HRESULT put_errorLine(int v);
    HRESULT get_errorLine(int* p);
    HRESULT put_errorCharacter(int v);
    HRESULT get_errorCharacter(int* p);
    HRESULT put_errorCode(int v);
    HRESULT get_errorCode(int* p);
    HRESULT put_errorMessage(BSTR v);
    HRESULT get_errorMessage(BSTR* p);
    HRESULT put_errorDebug(short v);
    HRESULT get_errorDebug(short* p);
    HRESULT get_unsecuredWindowOfDocument(IHTMLWindow2* p);
    HRESULT put_findText(BSTR v);
    HRESULT get_findText(BSTR* p);
    HRESULT put_anythingAfterFrameset(short v);
    HRESULT get_anythingAfterFrameset(short* p);
    HRESULT sizes(BSTR fontName, IHTMLFontSizesCollection* pSizesCollection);
    HRESULT openfiledlg(VARIANT initFile, VARIANT initDir, VARIANT filter, VARIANT title, BSTR* pathName);
    HRESULT savefiledlg(VARIANT initFile, VARIANT initDir, VARIANT filter, VARIANT title, BSTR* pathName);
    HRESULT choosecolordlg(VARIANT initColor, int* rgbColor);
    HRESULT showSecurityInfo();
    HRESULT isApartmentModel(IHTMLObjectElement object, short* fApartment);
    HRESULT getCharset(BSTR fontName, int* charset);
    HRESULT get_secureConnectionInfo(BSTR* p);
}

const GUID IID_HTMLStyleElementEvents2 = {0x3050F615, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F615, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLStyleElementEvents2 : IDispatch
{
}

const GUID IID_HTMLStyleElementEvents = {0x3050F3CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLStyleElementEvents : IDispatch
{
}

const GUID IID_IHTMLStyleElement = {0x3050F375, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F375, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT get_styleSheet(IHTMLStyleSheet* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

const GUID IID_IHTMLStyleElement2 = {0x3051072A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051072A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleElement2 : IDispatch
{
    HRESULT get_sheet(IHTMLStyleSheet* p);
}

const GUID IID_DispHTMLStyleElement = {0x3050F511, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F511, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyleElement : IDispatch
{
}

const GUID IID_IHTMLStyleFontFace = {0x3050F3D5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3D5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleFontFace : IDispatch
{
    HRESULT put_fontsrc(BSTR v);
    HRESULT get_fontsrc(BSTR* p);
}

const GUID IID_IHTMLStyleFontFace2 = {0x305106EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleFontFace2 : IDispatch
{
    HRESULT get_style(IHTMLRuleStyle* p);
}

const GUID IID_DispHTMLStyleFontFace = {0x30590081, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590081, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyleFontFace : IDispatch
{
}

const GUID IID_IHTMLXDomainRequest = {0x30510454, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510454, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLXDomainRequest : IDispatch
{
    HRESULT get_responseText(BSTR* p);
    HRESULT put_timeout(int v);
    HRESULT get_timeout(int* p);
    HRESULT get_contentType(BSTR* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_ontimeout(VARIANT v);
    HRESULT get_ontimeout(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT abort();
    HRESULT open(BSTR bstrMethod, BSTR bstrUrl);
    HRESULT send(VARIANT varBody);
}

const GUID IID_IHTMLXDomainRequestFactory = {0x30510456, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510456, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLXDomainRequestFactory : IDispatch
{
    HRESULT create(IHTMLXDomainRequest* __MIDL__IHTMLXDomainRequestFactory0000);
}

const GUID IID_DispXDomainRequest = {0x3050F599, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F599, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispXDomainRequest : IDispatch
{
}

const GUID IID_IHTMLStorage2 = {0x30510799, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510799, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStorage2 : IDispatch
{
    HRESULT setItem(BSTR bstrKey, BSTR bstrValue);
}

const GUID IID_DispHTMLStorage = {0x3050F59D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F59D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStorage : IDispatch
{
}

const GUID IID_IEventTarget = {0x305104B9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104B9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IEventTarget : IDispatch
{
    HRESULT addEventListener(BSTR type, IDispatch listener, short useCapture);
    HRESULT removeEventListener(BSTR type, IDispatch listener, short useCapture);
    HRESULT dispatchEvent(IDOMEvent evt, short* pfResult);
}

const GUID IID_DispDOMEvent = {0x3050F5A2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5A2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMEvent : IDispatch
{
}

const GUID IID_IDOMUIEvent = {0x305106CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMUIEvent : IDispatch
{
    HRESULT get_view(IHTMLWindow2* p);
    HRESULT get_detail(int* p);
    HRESULT initUIEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 view, int detail);
}

const GUID IID_DispDOMUIEvent = {0x30590072, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590072, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMUIEvent : IDispatch
{
}

const GUID IID_IDOMMouseEvent = {0x305106CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMMouseEvent : IDispatch
{
    HRESULT get_screenX(int* p);
    HRESULT get_screenY(int* p);
    HRESULT get_clientX(int* p);
    HRESULT get_clientY(int* p);
    HRESULT get_ctrlKey(short* p);
    HRESULT get_shiftKey(short* p);
    HRESULT get_altKey(short* p);
    HRESULT get_metaKey(short* p);
    HRESULT get_button(ushort* p);
    HRESULT get_relatedTarget(IEventTarget* p);
    HRESULT initMouseEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, int detailArg, int screenXArg, int screenYArg, int clientXArg, int clientYArg, short ctrlKeyArg, short altKeyArg, short shiftKeyArg, short metaKeyArg, ushort buttonArg, IEventTarget relatedTargetArg);
    HRESULT getModifierState(BSTR keyArg, short* activated);
    HRESULT get_buttons(ushort* p);
    HRESULT get_fromElement(IHTMLElement* p);
    HRESULT get_toElement(IHTMLElement* p);
    HRESULT get_x(int* p);
    HRESULT get_y(int* p);
    HRESULT get_offsetX(int* p);
    HRESULT get_offsetY(int* p);
    HRESULT get_pageX(int* p);
    HRESULT get_pageY(int* p);
    HRESULT get_layerX(int* p);
    HRESULT get_layerY(int* p);
    HRESULT get_which(ushort* p);
}

const GUID IID_DispDOMMouseEvent = {0x30590073, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590073, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMMouseEvent : IDispatch
{
}

const GUID IID_IDOMDragEvent = {0x30510761, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510761, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMDragEvent : IDispatch
{
    HRESULT get_dataTransfer(IHTMLDataTransfer* p);
    HRESULT initDragEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, int detailArg, int screenXArg, int screenYArg, int clientXArg, int clientYArg, short ctrlKeyArg, short altKeyArg, short shiftKeyArg, short metaKeyArg, ushort buttonArg, IEventTarget relatedTargetArg, IHTMLDataTransfer dataTransferArg);
}

const GUID IID_DispDOMDragEvent = {0x305900A7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900A7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMDragEvent : IDispatch
{
}

const GUID IID_IDOMMouseWheelEvent = {0x305106D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMMouseWheelEvent : IDispatch
{
    HRESULT get_wheelDelta(int* p);
    HRESULT initMouseWheelEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, int detailArg, int screenXArg, int screenYArg, int clientXArg, int clientYArg, ushort buttonArg, IEventTarget relatedTargetArg, BSTR modifiersListArg, int wheelDeltaArg);
}

const GUID IID_DispDOMMouseWheelEvent = {0x30590074, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590074, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMMouseWheelEvent : IDispatch
{
}

const GUID IID_IDOMWheelEvent = {0x305106D2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106D2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMWheelEvent : IDispatch
{
    HRESULT get_deltaX(int* p);
    HRESULT get_deltaY(int* p);
    HRESULT get_deltaZ(int* p);
    HRESULT get_deltaMode(uint* p);
    HRESULT initWheelEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, int detailArg, int screenXArg, int screenYArg, int clientXArg, int clientYArg, ushort buttonArg, IEventTarget relatedTargetArg, BSTR modifiersListArg, int deltaX, int deltaY, int deltaZ, uint deltaMode);
}

const GUID IID_DispDOMWheelEvent = {0x30590075, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590075, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMWheelEvent : IDispatch
{
}

const GUID IID_IDOMTextEvent = {0x305106D4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106D4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMTextEvent : IDispatch
{
    HRESULT get_data(BSTR* p);
    HRESULT get_inputMethod(uint* p);
    HRESULT initTextEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, BSTR dataArg, uint inputMethod, BSTR locale);
    HRESULT get_locale(BSTR* p);
}

const GUID IID_DispDOMTextEvent = {0x30590076, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590076, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMTextEvent : IDispatch
{
}

const GUID IID_IDOMKeyboardEvent = {0x305106D6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106D6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMKeyboardEvent : IDispatch
{
    HRESULT get_key(BSTR* p);
    HRESULT get_location(uint* p);
    HRESULT get_ctrlKey(short* p);
    HRESULT get_shiftKey(short* p);
    HRESULT get_altKey(short* p);
    HRESULT get_metaKey(short* p);
    HRESULT get_repeat(short* p);
    HRESULT getModifierState(BSTR keyArg, short* state);
    HRESULT initKeyboardEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, BSTR keyArg, uint locationArg, BSTR modifiersListArg, short repeat, BSTR locale);
    HRESULT get_keyCode(int* p);
    HRESULT get_charCode(int* p);
    HRESULT get_which(int* p);
    HRESULT get_ie9_char(VARIANT* p);
    HRESULT get_locale(BSTR* p);
}

const GUID IID_DispDOMKeyboardEvent = {0x30590077, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590077, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMKeyboardEvent : IDispatch
{
}

const GUID IID_IDOMCompositionEvent = {0x305106D8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106D8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMCompositionEvent : IDispatch
{
    HRESULT get_data(BSTR* p);
    HRESULT initCompositionEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, BSTR data, BSTR locale);
    HRESULT get_locale(BSTR* p);
}

const GUID IID_DispDOMCompositionEvent = {0x30590078, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590078, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMCompositionEvent : IDispatch
{
}

const GUID IID_IDOMMutationEvent = {0x305106DA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106DA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMMutationEvent : IDispatch
{
    HRESULT get_relatedNode(IDispatch* p);
    HRESULT get_prevValue(BSTR* p);
    HRESULT get_newValue(BSTR* p);
    HRESULT get_attrName(BSTR* p);
    HRESULT get_attrChange(ushort* p);
    HRESULT initMutationEvent(BSTR eventType, short canBubble, short cancelable, IDispatch relatedNodeArg, BSTR prevValueArg, BSTR newValueArg, BSTR attrNameArg, ushort attrChangeArg);
}

const GUID IID_DispDOMMutationEvent = {0x30590079, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590079, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMMutationEvent : IDispatch
{
}

const GUID IID_IDOMBeforeUnloadEvent = {0x30510763, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510763, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMBeforeUnloadEvent : IDispatch
{
    HRESULT put_returnValue(VARIANT v);
    HRESULT get_returnValue(VARIANT* p);
}

const GUID IID_DispDOMBeforeUnloadEvent = {0x305900A8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900A8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMBeforeUnloadEvent : IDispatch
{
}

const GUID IID_IDOMFocusEvent = {0x305106CC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106CC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMFocusEvent : IDispatch
{
    HRESULT get_relatedTarget(IEventTarget* p);
    HRESULT initFocusEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 view, int detail, IEventTarget relatedTargetArg);
}

const GUID IID_DispDOMFocusEvent = {0x30590071, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590071, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMFocusEvent : IDispatch
{
}

const GUID IID_IDOMCustomEvent = {0x305106DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMCustomEvent : IDispatch
{
    HRESULT get_detail(VARIANT* p);
    HRESULT initCustomEvent(BSTR eventType, short canBubble, short cancelable, VARIANT* detail);
}

const GUID IID_DispDOMCustomEvent = {0x3059007C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059007C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMCustomEvent : IDispatch
{
}

const GUID IID_ICanvasGradient = {0x30510714, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510714, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ICanvasGradient : IDispatch
{
    HRESULT addColorStop(float offset, BSTR color);
}

const GUID IID_ICanvasPattern = {0x30510716, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510716, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ICanvasPattern : IDispatch
{
}

const GUID IID_ICanvasTextMetrics = {0x30510718, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510718, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ICanvasTextMetrics : IDispatch
{
    HRESULT get_width(float* p);
}

const GUID IID_ICanvasImageData = {0x3051071A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051071A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ICanvasImageData : IDispatch
{
    HRESULT get_width(uint* p);
    HRESULT get_height(uint* p);
    HRESULT get_data(VARIANT* p);
}

const GUID IID_ICanvasPixelArray = {0x3051071C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051071C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ICanvasPixelArray : IDispatch
{
    HRESULT get_length(uint* p);
}

const GUID IID_IHTMLCanvasElement = {0x305106E4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106E4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCanvasElement : IDispatch
{
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT getContext(BSTR contextId, ICanvasRenderingContext2D* ppContext);
    HRESULT toDataURL(BSTR type, VARIANT jpegquality, BSTR* pUrl);
}

const GUID IID_ICanvasRenderingContext2D = {0x305106FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ICanvasRenderingContext2D : IDispatch
{
    HRESULT get_canvas(IHTMLCanvasElement* p);
    HRESULT restore();
    HRESULT save();
    HRESULT rotate(float angle);
    HRESULT scale(float x, float y);
    HRESULT setTransform(float m11, float m12, float m21, float m22, float dx, float dy);
    HRESULT transform(float m11, float m12, float m21, float m22, float dx, float dy);
    HRESULT translate(float x, float y);
    HRESULT put_globalAlpha(float v);
    HRESULT get_globalAlpha(float* p);
    HRESULT put_globalCompositeOperation(BSTR v);
    HRESULT get_globalCompositeOperation(BSTR* p);
    HRESULT put_fillStyle(VARIANT v);
    HRESULT get_fillStyle(VARIANT* p);
    HRESULT put_strokeStyle(VARIANT v);
    HRESULT get_strokeStyle(VARIANT* p);
    HRESULT createLinearGradient(float x0, float y0, float x1, float y1, ICanvasGradient* ppCanvasGradient);
    HRESULT createRadialGradient(float x0, float y0, float r0, float x1, float y1, float r1, ICanvasGradient* ppCanvasGradient);
    HRESULT createPattern(IDispatch image, VARIANT repetition, ICanvasPattern* ppCanvasPattern);
    HRESULT put_lineCap(BSTR v);
    HRESULT get_lineCap(BSTR* p);
    HRESULT put_lineJoin(BSTR v);
    HRESULT get_lineJoin(BSTR* p);
    HRESULT put_lineWidth(float v);
    HRESULT get_lineWidth(float* p);
    HRESULT put_miterLimit(float v);
    HRESULT get_miterLimit(float* p);
    HRESULT put_shadowBlur(float v);
    HRESULT get_shadowBlur(float* p);
    HRESULT put_shadowColor(BSTR v);
    HRESULT get_shadowColor(BSTR* p);
    HRESULT put_shadowOffsetX(float v);
    HRESULT get_shadowOffsetX(float* p);
    HRESULT put_shadowOffsetY(float v);
    HRESULT get_shadowOffsetY(float* p);
    HRESULT clearRect(float x, float y, float w, float h);
    HRESULT fillRect(float x, float y, float w, float h);
    HRESULT strokeRect(float x, float y, float w, float h);
    HRESULT arc(float x, float y, float radius, float startAngle, float endAngle, BOOL anticlockwise);
    HRESULT arcTo(float x1, float y1, float x2, float y2, float radius);
    HRESULT beginPath();
    HRESULT bezierCurveTo(float cp1x, float cp1y, float cp2x, float cp2y, float x, float y);
    HRESULT clip();
    HRESULT closePath();
    HRESULT fill();
    HRESULT lineTo(float x, float y);
    HRESULT moveTo(float x, float y);
    HRESULT quadraticCurveTo(float cpx, float cpy, float x, float y);
    HRESULT rect(float x, float y, float w, float h);
    HRESULT stroke();
    HRESULT isPointInPath(float x, float y, short* pResult);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textBaseline(BSTR v);
    HRESULT get_textBaseline(BSTR* p);
    HRESULT fillText(BSTR text, float x, float y, VARIANT maxWidth);
    HRESULT measureText(BSTR text, ICanvasTextMetrics* ppCanvasTextMetrics);
    HRESULT strokeText(BSTR text, float x, float y, VARIANT maxWidth);
    HRESULT drawImage(IDispatch pSrc, VARIANT a1, VARIANT a2, VARIANT a3, VARIANT a4, VARIANT a5, VARIANT a6, VARIANT a7, VARIANT a8);
    HRESULT createImageData(VARIANT a1, VARIANT a2, ICanvasImageData* ppCanvasImageData);
    HRESULT getImageData(float sx, float sy, float sw, float sh, ICanvasImageData* ppCanvasImageData);
    HRESULT putImageData(ICanvasImageData imagedata, float dx, float dy, VARIANT dirtyX, VARIANT dirtyY, VARIANT dirtyWidth, VARIANT dirtyHeight);
}

const GUID IID_DispCanvasGradient = {0x3059008C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059008C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispCanvasGradient : IDispatch
{
}

const GUID IID_DispCanvasPattern = {0x3059008D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059008D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispCanvasPattern : IDispatch
{
}

const GUID IID_DispCanvasTextMetrics = {0x3059008E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059008E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispCanvasTextMetrics : IDispatch
{
}

const GUID IID_DispCanvasImageData = {0x3059008F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059008F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispCanvasImageData : IDispatch
{
}

const GUID IID_DispCanvasRenderingContext2D = {0x30590082, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590082, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispCanvasRenderingContext2D : IDispatch
{
}

const GUID IID_DispHTMLCanvasElement = {0x3059007B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059007B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLCanvasElement : IDispatch
{
}

const GUID IID_IDOMProgressEvent = {0x3051071E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051071E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMProgressEvent : IDispatch
{
    HRESULT get_lengthComputable(short* p);
    HRESULT get_loaded(ulong* p);
    HRESULT get_total(ulong* p);
    HRESULT initProgressEvent(BSTR eventType, short canBubble, short cancelable, short lengthComputableArg, ulong loadedArg, ulong totalArg);
}

const GUID IID_DispDOMProgressEvent = {0x30590091, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590091, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMProgressEvent : IDispatch
{
}

const GUID IID_IDOMMessageEvent = {0x30510720, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510720, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMMessageEvent : IDispatch
{
    HRESULT get_data(BSTR* p);
    HRESULT get_origin(BSTR* p);
    HRESULT get_source(IHTMLWindow2* p);
    HRESULT initMessageEvent(BSTR eventType, short canBubble, short cancelable, BSTR data, BSTR origin, BSTR lastEventId, IHTMLWindow2 source);
}

const GUID IID_DispDOMMessageEvent = {0x30590092, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590092, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMMessageEvent : IDispatch
{
}

const GUID IID_IDOMSiteModeEvent = {0x30510765, 0x98B6, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510765, 0x98B6, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMSiteModeEvent : IDispatch
{
    HRESULT get_buttonID(int* p);
    HRESULT get_actionURL(BSTR* p);
}

const GUID IID_DispDOMSiteModeEvent = {0x305900A9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900A9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMSiteModeEvent : IDispatch
{
}

const GUID IID_IDOMStorageEvent = {0x30510722, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510722, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMStorageEvent : IDispatch
{
    HRESULT get_key(BSTR* p);
    HRESULT get_oldValue(BSTR* p);
    HRESULT get_newValue(BSTR* p);
    HRESULT get_url(BSTR* p);
    HRESULT get_storageArea(IHTMLStorage* p);
    HRESULT initStorageEvent(BSTR eventType, short canBubble, short cancelable, BSTR keyArg, BSTR oldValueArg, BSTR newValueArg, BSTR urlArg, IHTMLStorage storageAreaArg);
}

const GUID IID_DispDOMStorageEvent = {0x30590093, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590093, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMStorageEvent : IDispatch
{
}

const GUID IID_IXMLHttpRequestEventTarget = {0x30510830, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510830, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IXMLHttpRequestEventTarget : IDispatch
{
}

const GUID IID_DispXMLHttpRequestEventTarget = {0x305900E7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900E7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispXMLHttpRequestEventTarget : IDispatch
{
}

const GUID IID_HTMLXMLHttpRequestEvents = {0x30510498, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510498, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLXMLHttpRequestEvents : IDispatch
{
}

const GUID IID_IHTMLXMLHttpRequest = {0x3051040A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051040A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLXMLHttpRequest : IDispatch
{
    HRESULT get_readyState(int* p);
    HRESULT get_responseBody(VARIANT* p);
    HRESULT get_responseText(BSTR* p);
    HRESULT get_responseXML(IDispatch* p);
    HRESULT get_status(int* p);
    HRESULT get_statusText(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT abort();
    HRESULT open(BSTR bstrMethod, BSTR bstrUrl, VARIANT varAsync, VARIANT varUser, VARIANT varPassword);
    HRESULT send(VARIANT varBody);
    HRESULT getAllResponseHeaders(BSTR* __MIDL__IHTMLXMLHttpRequest0000);
    HRESULT getResponseHeader(BSTR bstrHeader, BSTR* __MIDL__IHTMLXMLHttpRequest0001);
    HRESULT setRequestHeader(BSTR bstrHeader, BSTR bstrValue);
}

const GUID IID_IHTMLXMLHttpRequest2 = {0x30510482, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510482, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLXMLHttpRequest2 : IDispatch
{
    HRESULT put_timeout(int v);
    HRESULT get_timeout(int* p);
    HRESULT put_ontimeout(VARIANT v);
    HRESULT get_ontimeout(VARIANT* p);
}

const GUID IID_IHTMLXMLHttpRequestFactory = {0x3051040C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051040C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLXMLHttpRequestFactory : IDispatch
{
    HRESULT create(IHTMLXMLHttpRequest* __MIDL__IHTMLXMLHttpRequestFactory0000);
}

const GUID IID_DispHTMLXMLHttpRequest = {0x3050F596, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F596, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLXMLHttpRequest : IDispatch
{
}

const GUID IID_ISVGAngle = {0x305104D3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104D3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAngle : IDispatch
{
    HRESULT put_unitType(short v);
    HRESULT get_unitType(short* p);
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
    HRESULT put_valueInSpecifiedUnits(float v);
    HRESULT get_valueInSpecifiedUnits(float* p);
    HRESULT put_valueAsString(BSTR v);
    HRESULT get_valueAsString(BSTR* p);
    HRESULT newValueSpecifiedUnits(short unitType, float valueInSpecifiedUnits);
    HRESULT convertToSpecifiedUnits(short unitType);
}

const GUID IID_ISVGElement = {0x305104C5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104C5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGElement : IDispatch
{
    HRESULT put_xmlbase(BSTR v);
    HRESULT get_xmlbase(BSTR* p);
    HRESULT putref_ownerSVGElement(ISVGSVGElement v);
    HRESULT get_ownerSVGElement(ISVGSVGElement* p);
    HRESULT putref_viewportElement(ISVGElement v);
    HRESULT get_viewportElement(ISVGElement* p);
    HRESULT putref_focusable(ISVGAnimatedEnumeration v);
    HRESULT get_focusable(ISVGAnimatedEnumeration* p);
}

const GUID IID_ISVGRect = {0x305104D7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104D7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGRect : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_width(float v);
    HRESULT get_width(float* p);
    HRESULT put_height(float v);
    HRESULT get_height(float* p);
}

const GUID IID_ISVGMatrix = {0x305104F6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104F6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGMatrix : IDispatch
{
    HRESULT put_a(float v);
    HRESULT get_a(float* p);
    HRESULT put_b(float v);
    HRESULT get_b(float* p);
    HRESULT put_c(float v);
    HRESULT get_c(float* p);
    HRESULT put_d(float v);
    HRESULT get_d(float* p);
    HRESULT put_e(float v);
    HRESULT get_e(float* p);
    HRESULT put_f(float v);
    HRESULT get_f(float* p);
    HRESULT multiply(ISVGMatrix secondMatrix, ISVGMatrix* ppResult);
    HRESULT inverse(ISVGMatrix* ppResult);
    HRESULT translate(float x, float y, ISVGMatrix* ppResult);
    HRESULT scale(float scaleFactor, ISVGMatrix* ppResult);
    HRESULT scaleNonUniform(float scaleFactorX, float scaleFactorY, ISVGMatrix* ppResult);
    HRESULT rotate(float angle, ISVGMatrix* ppResult);
    HRESULT rotateFromVector(float x, float y, ISVGMatrix* ppResult);
    HRESULT flipX(ISVGMatrix* ppResult);
    HRESULT flipY(ISVGMatrix* ppResult);
    HRESULT skewX(float angle, ISVGMatrix* ppResult);
    HRESULT skewY(float angle, ISVGMatrix* ppResult);
}

const GUID IID_ISVGStringList = {0x305104C8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104C8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGStringList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(BSTR newItem, BSTR* ppResult);
    HRESULT getItem(int index, BSTR* ppResult);
    HRESULT insertItemBefore(BSTR newItem, int index, BSTR* ppResult);
    HRESULT replaceItem(BSTR newItem, int index, BSTR* ppResult);
    HRESULT removeItem(int index, BSTR* ppResult);
    HRESULT appendItem(BSTR newItem, BSTR* ppResult);
}

const GUID IID_ISVGAnimatedRect = {0x305104D8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104D8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedRect : IDispatch
{
    HRESULT putref_baseVal(ISVGRect v);
    HRESULT get_baseVal(ISVGRect* p);
    HRESULT putref_animVal(ISVGRect v);
    HRESULT get_animVal(ISVGRect* p);
}

const GUID IID_ISVGAnimatedString = {0x305104C7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104C7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedString : IDispatch
{
    HRESULT put_baseVal(BSTR v);
    HRESULT get_baseVal(BSTR* p);
    HRESULT get_animVal(BSTR* p);
}

const GUID IID_ISVGAnimatedBoolean = {0x305104C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104C6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedBoolean : IDispatch
{
    HRESULT put_baseVal(short v);
    HRESULT get_baseVal(short* p);
    HRESULT put_animVal(short v);
    HRESULT get_animVal(short* p);
}

const GUID IID_ISVGAnimatedTransformList = {0x305104F9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104F9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedTransformList : IDispatch
{
    HRESULT putref_baseVal(ISVGTransformList v);
    HRESULT get_baseVal(ISVGTransformList* p);
    HRESULT putref_animVal(ISVGTransformList v);
    HRESULT get_animVal(ISVGTransformList* p);
}

const GUID IID_ISVGAnimatedPreserveAspectRatio = {0x305104FB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104FB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedPreserveAspectRatio : IDispatch
{
    HRESULT putref_baseVal(ISVGPreserveAspectRatio v);
    HRESULT get_baseVal(ISVGPreserveAspectRatio* p);
    HRESULT putref_animVal(ISVGPreserveAspectRatio v);
    HRESULT get_animVal(ISVGPreserveAspectRatio* p);
}

const GUID IID_ISVGStylable = {0x305104DA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104DA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGStylable : IDispatch
{
    HRESULT get_className(ISVGAnimatedString* p);
}

const GUID IID_ISVGLocatable = {0x305104DB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104DB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGLocatable : IDispatch
{
    HRESULT get_nearestViewportElement(ISVGElement* p);
    HRESULT get_farthestViewportElement(ISVGElement* p);
    HRESULT getBBox(ISVGRect* ppResult);
    HRESULT getCTM(ISVGMatrix* ppResult);
    HRESULT getScreenCTM(ISVGMatrix* ppResult);
    HRESULT getTransformToElement(ISVGElement pElement, ISVGMatrix* ppResult);
}

const GUID IID_ISVGTransformable = {0x305104DC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104DC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGTransformable : IDispatch
{
    HRESULT get_transform(ISVGAnimatedTransformList* p);
}

const GUID IID_ISVGTests = {0x305104DD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104DD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGTests : IDispatch
{
    HRESULT get_requiredFeatures(ISVGStringList* p);
    HRESULT get_requiredExtensions(ISVGStringList* p);
    HRESULT get_systemLanguage(ISVGStringList* p);
    HRESULT hasExtension(BSTR extension, short* pResult);
}

const GUID IID_ISVGLangSpace = {0x305104DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104DE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGLangSpace : IDispatch
{
    HRESULT put_xmllang(BSTR v);
    HRESULT get_xmllang(BSTR* p);
    HRESULT put_xmlspace(BSTR v);
    HRESULT get_xmlspace(BSTR* p);
}

const GUID IID_ISVGExternalResourcesRequired = {0x305104DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGExternalResourcesRequired : IDispatch
{
    HRESULT get_externalResourcesRequired(ISVGAnimatedBoolean* p);
}

const GUID IID_ISVGFitToViewBox = {0x305104E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGFitToViewBox : IDispatch
{
    HRESULT get_viewBox(ISVGAnimatedRect* p);
    HRESULT putref_preserveAspectRatio(ISVGAnimatedPreserveAspectRatio v);
    HRESULT get_preserveAspectRatio(ISVGAnimatedPreserveAspectRatio* p);
}

const GUID IID_ISVGZoomAndPan = {0x305104E1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104E1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGZoomAndPan : IDispatch
{
    HRESULT get_zoomAndPan(short* p);
}

const GUID IID_ISVGURIReference = {0x305104E3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104E3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGURIReference : IDispatch
{
    HRESULT get_href(ISVGAnimatedString* p);
}

const GUID IID_ISVGAnimatedAngle = {0x305104D4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104D4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedAngle : IDispatch
{
    HRESULT putref_baseVal(ISVGAngle v);
    HRESULT get_baseVal(ISVGAngle* p);
    HRESULT putref_animVal(ISVGAngle v);
    HRESULT get_animVal(ISVGAngle* p);
}

const GUID IID_ISVGTransformList = {0x305104F8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104F8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGTransformList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGTransform newItem, ISVGTransform* ppResult);
    HRESULT getItem(int index, ISVGTransform* ppResult);
    HRESULT insertItemBefore(ISVGTransform newItem, int index, ISVGTransform* ppResult);
    HRESULT replaceItem(ISVGTransform newItem, int index, ISVGTransform* ppResult);
    HRESULT removeItem(int index, ISVGTransform* ppResult);
    HRESULT appendItem(ISVGTransform newItem, ISVGTransform* ppResult);
    HRESULT createSVGTransformFromMatrix(ISVGMatrix newItem, ISVGTransform* ppResult);
    HRESULT consolidate(ISVGTransform* ppResult);
}

const GUID IID_ISVGAnimatedEnumeration = {0x305104C9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104C9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedEnumeration : IDispatch
{
    HRESULT put_baseVal(ushort v);
    HRESULT get_baseVal(ushort* p);
    HRESULT put_animVal(ushort v);
    HRESULT get_animVal(ushort* p);
}

const GUID IID_ISVGAnimatedInteger = {0x305104CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedInteger : IDispatch
{
    HRESULT put_baseVal(int v);
    HRESULT get_baseVal(int* p);
    HRESULT put_animVal(int v);
    HRESULT get_animVal(int* p);
}

const GUID IID_ISVGLength = {0x305104CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104CF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGLength : IDispatch
{
    HRESULT put_unitType(short v);
    HRESULT get_unitType(short* p);
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
    HRESULT put_valueInSpecifiedUnits(float v);
    HRESULT get_valueInSpecifiedUnits(float* p);
    HRESULT put_valueAsString(BSTR v);
    HRESULT get_valueAsString(BSTR* p);
    HRESULT newValueSpecifiedUnits(short unitType, float valueInSpecifiedUnits);
    HRESULT convertToSpecifiedUnits(short unitType);
}

const GUID IID_ISVGAnimatedLength = {0x305104D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104D0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedLength : IDispatch
{
    HRESULT putref_baseVal(ISVGLength v);
    HRESULT get_baseVal(ISVGLength* p);
    HRESULT putref_animVal(ISVGLength v);
    HRESULT get_animVal(ISVGLength* p);
}

const GUID IID_ISVGLengthList = {0x305104D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104D1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGLengthList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGLength newItem, ISVGLength* ppResult);
    HRESULT getItem(int index, ISVGLength* ppResult);
    HRESULT insertItemBefore(ISVGLength newItem, int index, ISVGLength* ppResult);
    HRESULT replaceItem(ISVGLength newItem, int index, ISVGLength* ppResult);
    HRESULT removeItem(int index, ISVGLength* ppResult);
    HRESULT appendItem(ISVGLength newItem, ISVGLength* ppResult);
}

const GUID IID_ISVGAnimatedLengthList = {0x305104D2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104D2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedLengthList : IDispatch
{
    HRESULT putref_baseVal(ISVGLengthList v);
    HRESULT get_baseVal(ISVGLengthList* p);
    HRESULT putref_animVal(ISVGLengthList v);
    HRESULT get_animVal(ISVGLengthList* p);
}

const GUID IID_ISVGNumber = {0x305104CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104CB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGNumber : IDispatch
{
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
}

const GUID IID_ISVGAnimatedNumber = {0x305104CC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104CC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedNumber : IDispatch
{
    HRESULT put_baseVal(float v);
    HRESULT get_baseVal(float* p);
    HRESULT put_animVal(float v);
    HRESULT get_animVal(float* p);
}

const GUID IID_ISVGNumberList = {0x305104CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGNumberList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGNumber newItem, ISVGNumber* ppResult);
    HRESULT getItem(int index, ISVGNumber* ppResult);
    HRESULT insertItemBefore(ISVGNumber newItem, int index, ISVGNumber* ppResult);
    HRESULT replaceItem(ISVGNumber newItem, int index, ISVGNumber* ppResult);
    HRESULT removeItem(int index, ISVGNumber* ppResult);
    HRESULT appendItem(ISVGNumber newItem, ISVGNumber* ppResult);
}

const GUID IID_ISVGAnimatedNumberList = {0x305104CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104CE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedNumberList : IDispatch
{
    HRESULT putref_baseVal(ISVGNumberList v);
    HRESULT get_baseVal(ISVGNumberList* p);
    HRESULT putref_animVal(ISVGNumberList v);
    HRESULT get_animVal(ISVGNumberList* p);
}

const GUID IID_ISVGClipPathElement = {0x3051052D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051052D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGClipPathElement : IDispatch
{
    HRESULT putref_clipPathUnits(ISVGAnimatedEnumeration v);
    HRESULT get_clipPathUnits(ISVGAnimatedEnumeration* p);
}

const GUID IID_DispSVGClipPathElement = {0x3059003B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059003B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGClipPathElement : IDispatch
{
}

const GUID IID_ISVGDocument = {0x305104E6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104E6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGDocument : IDispatch
{
    HRESULT get_rootElement(ISVGSVGElement* p);
}

const GUID IID_IGetSVGDocument = {0x305105AB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305105AB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IGetSVGDocument : IDispatch
{
    HRESULT getSVGDocument(IDispatch* ppSVGDocument);
}

const GUID IID_DispSVGElement = {0x30590000, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590000, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGElement : IDispatch
{
}

const GUID IID_IICCSVGColor = {0x305104D6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104D6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IICCSVGColor : IDispatch
{
}

const GUID IID_ISVGPaint = {0x30510524, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510524, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPaint : IDispatch
{
}

const GUID IID_ISVGPatternElement = {0x3051052C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051052C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPatternElement : IDispatch
{
    HRESULT putref_patternUnits(ISVGAnimatedEnumeration v);
    HRESULT get_patternUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_patternContentUnits(ISVGAnimatedEnumeration v);
    HRESULT get_patternContentUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_patternTransform(ISVGAnimatedTransformList v);
    HRESULT get_patternTransform(ISVGAnimatedTransformList* p);
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
}

const GUID IID_DispSVGPatternElement = {0x3059002C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059002C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPatternElement : IDispatch
{
}

const GUID IID_ISVGPathSeg = {0x305104FC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104FC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSeg : IDispatch
{
    HRESULT put_pathSegType(short v);
    HRESULT get_pathSegType(short* p);
    HRESULT get_pathSegTypeAsLetter(BSTR* p);
}

const GUID IID_ISVGPathSegArcAbs = {0x30510506, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510506, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegArcAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_r1(float v);
    HRESULT get_r1(float* p);
    HRESULT put_r2(float v);
    HRESULT get_r2(float* p);
    HRESULT put_angle(float v);
    HRESULT get_angle(float* p);
    HRESULT put_largeArcFlag(short v);
    HRESULT get_largeArcFlag(short* p);
    HRESULT put_sweepFlag(short v);
    HRESULT get_sweepFlag(short* p);
}

const GUID IID_ISVGPathSegArcRel = {0x30510507, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510507, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegArcRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_r1(float v);
    HRESULT get_r1(float* p);
    HRESULT put_r2(float v);
    HRESULT get_r2(float* p);
    HRESULT put_angle(float v);
    HRESULT get_angle(float* p);
    HRESULT put_largeArcFlag(short v);
    HRESULT get_largeArcFlag(short* p);
    HRESULT put_sweepFlag(short v);
    HRESULT get_sweepFlag(short* p);
}

const GUID IID_ISVGPathSegClosePath = {0x305104FD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104FD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegClosePath : IDispatch
{
}

const GUID IID_ISVGPathSegMovetoAbs = {0x305104FE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104FE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegMovetoAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

const GUID IID_ISVGPathSegMovetoRel = {0x305104FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegMovetoRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

const GUID IID_ISVGPathSegLinetoAbs = {0x30510500, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510500, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegLinetoAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

const GUID IID_ISVGPathSegLinetoRel = {0x30510501, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510501, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegLinetoRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

const GUID IID_ISVGPathSegCurvetoCubicAbs = {0x30510502, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510502, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegCurvetoCubicAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

const GUID IID_ISVGPathSegCurvetoCubicRel = {0x30510503, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510503, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegCurvetoCubicRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

const GUID IID_ISVGPathSegCurvetoCubicSmoothAbs = {0x3051050C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051050C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegCurvetoCubicSmoothAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

const GUID IID_ISVGPathSegCurvetoCubicSmoothRel = {0x3051050D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051050D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegCurvetoCubicSmoothRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

const GUID IID_ISVGPathSegCurvetoQuadraticAbs = {0x30510504, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510504, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegCurvetoQuadraticAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
}

const GUID IID_ISVGPathSegCurvetoQuadraticRel = {0x30510505, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510505, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegCurvetoQuadraticRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
}

const GUID IID_ISVGPathSegCurvetoQuadraticSmoothAbs = {0x3051050E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051050E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegCurvetoQuadraticSmoothAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

const GUID IID_ISVGPathSegCurvetoQuadraticSmoothRel = {0x3051050F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051050F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegCurvetoQuadraticSmoothRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

const GUID IID_ISVGPathSegLinetoHorizontalAbs = {0x30510508, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510508, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegLinetoHorizontalAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
}

const GUID IID_ISVGPathSegLinetoHorizontalRel = {0x30510509, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510509, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegLinetoHorizontalRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
}

const GUID IID_ISVGPathSegLinetoVerticalAbs = {0x3051050A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051050A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegLinetoVerticalAbs : IDispatch
{
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

const GUID IID_ISVGPathSegLinetoVerticalRel = {0x3051050B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051050B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegLinetoVerticalRel : IDispatch
{
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

const GUID IID_DispSVGPathSegArcAbs = {0x30590013, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590013, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegArcAbs : IDispatch
{
}

const GUID IID_DispSVGPathSegArcRel = {0x30590014, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590014, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegArcRel : IDispatch
{
}

const GUID IID_DispSVGPathSegClosePath = {0x30590015, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590015, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegClosePath : IDispatch
{
}

const GUID IID_DispSVGPathSegMovetoAbs = {0x30590024, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590024, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegMovetoAbs : IDispatch
{
}

const GUID IID_DispSVGPathSegMovetoRel = {0x30590025, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590025, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegMovetoRel : IDispatch
{
}

const GUID IID_DispSVGPathSegLinetoAbs = {0x3059001E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059001E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegLinetoAbs : IDispatch
{
}

const GUID IID_DispSVGPathSegLinetoRel = {0x30590021, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590021, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegLinetoRel : IDispatch
{
}

const GUID IID_DispSVGPathSegCurvetoCubicAbs = {0x30590016, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590016, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegCurvetoCubicAbs : IDispatch
{
}

const GUID IID_DispSVGPathSegCurvetoCubicRel = {0x30590017, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590017, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegCurvetoCubicRel : IDispatch
{
}

const GUID IID_DispSVGPathSegCurvetoCubicSmoothAbs = {0x30590018, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590018, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegCurvetoCubicSmoothAbs : IDispatch
{
}

const GUID IID_DispSVGPathSegCurvetoCubicSmoothRel = {0x30590019, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590019, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegCurvetoCubicSmoothRel : IDispatch
{
}

const GUID IID_DispSVGPathSegCurvetoQuadraticAbs = {0x3059001A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059001A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegCurvetoQuadraticAbs : IDispatch
{
}

const GUID IID_DispSVGPathSegCurvetoQuadraticRel = {0x3059001B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059001B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegCurvetoQuadraticRel : IDispatch
{
}

const GUID IID_DispSVGPathSegCurvetoQuadraticSmoothAbs = {0x3059001C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059001C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegCurvetoQuadraticSmoothAbs : IDispatch
{
}

const GUID IID_DispSVGPathSegCurvetoQuadraticSmoothRel = {0x3059001D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059001D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegCurvetoQuadraticSmoothRel : IDispatch
{
}

const GUID IID_DispSVGPathSegLinetoHorizontalAbs = {0x3059001F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059001F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegLinetoHorizontalAbs : IDispatch
{
}

const GUID IID_DispSVGPathSegLinetoHorizontalRel = {0x30590020, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590020, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegLinetoHorizontalRel : IDispatch
{
}

const GUID IID_DispSVGPathSegLinetoVerticalAbs = {0x30590022, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590022, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegLinetoVerticalAbs : IDispatch
{
}

const GUID IID_DispSVGPathSegLinetoVerticalRel = {0x30590023, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590023, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathSegLinetoVerticalRel : IDispatch
{
}

const GUID IID_ISVGPathSegList = {0x30510510, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510510, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathSegList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGPathSeg newItem, ISVGPathSeg* ppResult);
    HRESULT getItem(int index, ISVGPathSeg* ppResult);
    HRESULT insertItemBefore(ISVGPathSeg newItem, int index, ISVGPathSeg* ppResult);
    HRESULT replaceItem(ISVGPathSeg newItem, int index, ISVGPathSeg* ppResult);
    HRESULT removeItem(int index, ISVGPathSeg* ppResult);
    HRESULT appendItem(ISVGPathSeg newItem, ISVGPathSeg* ppResult);
}

const GUID IID_ISVGPoint = {0x305104F4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104F4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPoint : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT matrixTransform(ISVGMatrix pMatrix, ISVGPoint* ppResult);
}

const GUID IID_ISVGPointList = {0x305104F5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104F5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPointList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGPoint pNewItem, ISVGPoint* ppResult);
    HRESULT getItem(int index, ISVGPoint* ppResult);
    HRESULT insertItemBefore(ISVGPoint pNewItem, int index, ISVGPoint* ppResult);
    HRESULT replaceItem(ISVGPoint pNewItem, int index, ISVGPoint* ppResult);
    HRESULT removeItem(int index, ISVGPoint* ppResult);
    HRESULT appendItem(ISVGPoint pNewItem, ISVGPoint* ppResult);
}

const GUID IID_ISVGViewSpec = {0x305104E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGViewSpec : IDispatch
{
}

const GUID IID_ISVGTransform = {0x305104F7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104F7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGTransform : IDispatch
{
    HRESULT put_type(short v);
    HRESULT get_type(short* p);
    HRESULT putref_matrix(ISVGMatrix v);
    HRESULT get_matrix(ISVGMatrix* p);
    HRESULT put_angle(float v);
    HRESULT get_angle(float* p);
    HRESULT setMatrix(ISVGMatrix matrix);
    HRESULT setTranslate(float tx, float ty);
    HRESULT setScale(float sx, float sy);
    HRESULT setRotate(float angle, float cx, float cy);
    HRESULT setSkewX(float angle);
    HRESULT setSkewY(float angle);
}

const GUID IID_DispSVGSVGElement = {0x30590001, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590001, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGSVGElement : IDispatch
{
}

const GUID IID_ISVGElementInstance = {0x305104EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGElementInstance : IDispatch
{
    HRESULT get_correspondingElement(ISVGElement* p);
    HRESULT get_correspondingUseElement(ISVGUseElement* p);
    HRESULT get_parentNode(ISVGElementInstance* p);
    HRESULT get_childNodes(ISVGElementInstanceList* p);
    HRESULT get_firstChild(ISVGElementInstance* p);
    HRESULT get_lastChild(ISVGElementInstance* p);
    HRESULT get_previousSibling(ISVGElementInstance* p);
    HRESULT get_nextSibling(ISVGElementInstance* p);
}

const GUID IID_ISVGUseElement = {0x305104ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGUseElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
    HRESULT putref_instanceRoot(ISVGElementInstance v);
    HRESULT get_instanceRoot(ISVGElementInstance* p);
    HRESULT putref_animatedInstanceRoot(ISVGElementInstance v);
    HRESULT get_animatedInstanceRoot(ISVGElementInstance* p);
}

const GUID IID_DispSVGUseElement = {0x30590010, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590010, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGUseElement : IDispatch
{
}

const GUID IID_IHTMLStyleSheetRulesAppliedCollection = {0x305104C0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104C0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLStyleSheetRulesAppliedCollection : IDispatch
{
    HRESULT item(int index, IHTMLStyleSheetRule* ppHTMLStyleSheetRule);
    HRESULT get_length(int* p);
    HRESULT propertyAppliedBy(BSTR name, IHTMLStyleSheetRule* ppRule);
    HRESULT propertyAppliedTrace(BSTR name, int index, IHTMLStyleSheetRule* ppRule);
    HRESULT propertyAppliedTraceLength(BSTR name, int* pLength);
}

const GUID IID_IRulesApplied = {0x305104BF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104BF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IRulesApplied : IDispatch
{
    HRESULT get_element(IHTMLElement* p);
    HRESULT get_inlineStyles(IHTMLStyle* p);
    HRESULT get_appliedRules(IHTMLStyleSheetRulesAppliedCollection* p);
    HRESULT propertyIsInline(BSTR name, short* p);
    HRESULT propertyIsInheritable(BSTR name, short* p);
    HRESULT hasInheritableProperty(short* p);
}

const GUID IID_DispHTMLStyleSheetRulesAppliedCollection = {0x3050F5A6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5A6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLStyleSheetRulesAppliedCollection : IDispatch
{
}

const GUID IID_DispRulesApplied = {0x3050F5A5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5A5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispRulesApplied : IDispatch
{
}

const GUID IID_DispRulesAppliedCollection = {0x3050F5A4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5A4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispRulesAppliedCollection : IDispatch
{
}

const GUID IID_DispHTMLW3CComputedStyle = {0x30590070, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590070, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLW3CComputedStyle : IDispatch
{
}

const GUID IID_ISVGAnimatedPoints = {0x30510517, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510517, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedPoints : IDispatch
{
    HRESULT putref_points(ISVGPointList v);
    HRESULT get_points(ISVGPointList* p);
    HRESULT putref_animatedPoints(ISVGPointList v);
    HRESULT get_animatedPoints(ISVGPointList* p);
}

const GUID IID_ISVGCircleElement = {0x30510514, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510514, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGCircleElement : IDispatch
{
    HRESULT putref_cx(ISVGAnimatedLength v);
    HRESULT get_cx(ISVGAnimatedLength* p);
    HRESULT putref_cy(ISVGAnimatedLength v);
    HRESULT get_cy(ISVGAnimatedLength* p);
    HRESULT putref_r(ISVGAnimatedLength v);
    HRESULT get_r(ISVGAnimatedLength* p);
}

const GUID IID_ISVGEllipseElement = {0x30510515, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510515, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGEllipseElement : IDispatch
{
    HRESULT putref_cx(ISVGAnimatedLength v);
    HRESULT get_cx(ISVGAnimatedLength* p);
    HRESULT putref_cy(ISVGAnimatedLength v);
    HRESULT get_cy(ISVGAnimatedLength* p);
    HRESULT putref_rx(ISVGAnimatedLength v);
    HRESULT get_rx(ISVGAnimatedLength* p);
    HRESULT putref_ry(ISVGAnimatedLength v);
    HRESULT get_ry(ISVGAnimatedLength* p);
}

const GUID IID_ISVGLineElement = {0x30510516, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510516, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGLineElement : IDispatch
{
    HRESULT putref_x1(ISVGAnimatedLength v);
    HRESULT get_x1(ISVGAnimatedLength* p);
    HRESULT putref_y1(ISVGAnimatedLength v);
    HRESULT get_y1(ISVGAnimatedLength* p);
    HRESULT putref_x2(ISVGAnimatedLength v);
    HRESULT get_x2(ISVGAnimatedLength* p);
    HRESULT putref_y2(ISVGAnimatedLength v);
    HRESULT get_y2(ISVGAnimatedLength* p);
}

const GUID IID_ISVGRectElement = {0x30510513, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510513, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGRectElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
    HRESULT putref_rx(ISVGAnimatedLength v);
    HRESULT get_rx(ISVGAnimatedLength* p);
    HRESULT putref_ry(ISVGAnimatedLength v);
    HRESULT get_ry(ISVGAnimatedLength* p);
}

const GUID IID_ISVGPolygonElement = {0x30510519, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510519, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPolygonElement : IDispatch
{
}

const GUID IID_ISVGPolylineElement = {0x30510518, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510518, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPolylineElement : IDispatch
{
}

const GUID IID_DispSVGCircleElement = {0x3059000A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059000A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGCircleElement : IDispatch
{
}

const GUID IID_DispSVGEllipseElement = {0x3059000B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059000B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGEllipseElement : IDispatch
{
}

const GUID IID_DispSVGLineElement = {0x3059000C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059000C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGLineElement : IDispatch
{
}

const GUID IID_DispSVGRectElement = {0x30590009, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590009, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGRectElement : IDispatch
{
}

const GUID IID_DispSVGPolygonElement = {0x3059000D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059000D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPolygonElement : IDispatch
{
}

const GUID IID_DispSVGPolylineElement = {0x3059000E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059000E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPolylineElement : IDispatch
{
}

const GUID IID_ISVGGElement = {0x305104E8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104E8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGGElement : IDispatch
{
}

const GUID IID_DispSVGGElement = {0x30590002, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590002, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGGElement : IDispatch
{
}

const GUID IID_ISVGSymbolElement = {0x305104EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGSymbolElement : IDispatch
{
}

const GUID IID_DispSVGSymbolElement = {0x30590004, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590004, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGSymbolElement : IDispatch
{
}

const GUID IID_ISVGDefsElement = {0x305104E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGDefsElement : IDispatch
{
}

const GUID IID_DispSVGDefsElement = {0x30590003, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590003, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGDefsElement : IDispatch
{
}

const GUID IID_ISVGAnimatedPathData = {0x30510511, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510511, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAnimatedPathData : IDispatch
{
    HRESULT putref_pathSegList(ISVGPathSegList v);
    HRESULT get_pathSegList(ISVGPathSegList* p);
    HRESULT putref_normalizedPathSegList(ISVGPathSegList v);
    HRESULT get_normalizedPathSegList(ISVGPathSegList* p);
    HRESULT putref_animatedPathSegList(ISVGPathSegList v);
    HRESULT get_animatedPathSegList(ISVGPathSegList* p);
    HRESULT putref_animatedNormalizedPathSegList(ISVGPathSegList v);
    HRESULT get_animatedNormalizedPathSegList(ISVGPathSegList* p);
}

const GUID IID_ISVGPathElement = {0x30510512, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510512, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPathElement : IDispatch
{
    HRESULT putref_pathLength(ISVGAnimatedNumber v);
    HRESULT get_pathLength(ISVGAnimatedNumber* p);
    HRESULT getTotalLength(float* pfltResult);
    HRESULT getPointAtLength(float fltdistance, ISVGPoint* ppPointResult);
    HRESULT getPathSegAtLength(float fltdistance, int* plResult);
    HRESULT createSVGPathSegClosePath(ISVGPathSegClosePath* ppResult);
    HRESULT createSVGPathSegMovetoAbs(float x, float y, ISVGPathSegMovetoAbs* ppResult);
    HRESULT createSVGPathSegMovetoRel(float x, float y, ISVGPathSegMovetoRel* ppResult);
    HRESULT createSVGPathSegLinetoAbs(float x, float y, ISVGPathSegLinetoAbs* ppResult);
    HRESULT createSVGPathSegLinetoRel(float x, float y, ISVGPathSegLinetoRel* ppResult);
    HRESULT createSVGPathSegCurvetoCubicAbs(float x, float y, float x1, float y1, float x2, float y2, ISVGPathSegCurvetoCubicAbs* ppResult);
    HRESULT createSVGPathSegCurvetoCubicRel(float x, float y, float x1, float y1, float x2, float y2, ISVGPathSegCurvetoCubicRel* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticAbs(float x, float y, float x1, float y1, ISVGPathSegCurvetoQuadraticAbs* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticRel(float x, float y, float x1, float y1, ISVGPathSegCurvetoQuadraticRel* ppResult);
    HRESULT createSVGPathSegArcAbs(float x, float y, float r1, float r2, float angle, short largeArcFlag, short sweepFlag, ISVGPathSegArcAbs* ppResult);
    HRESULT createSVGPathSegArcRel(float x, float y, float r1, float r2, float angle, short largeArcFlag, short sweepFlag, ISVGPathSegArcRel* ppResult);
    HRESULT createSVGPathSegLinetoHorizontalAbs(float x, ISVGPathSegLinetoHorizontalAbs* ppResult);
    HRESULT createSVGPathSegLinetoHorizontalRel(float x, ISVGPathSegLinetoHorizontalRel* ppResult);
    HRESULT createSVGPathSegLinetoVerticalAbs(float y, ISVGPathSegLinetoVerticalAbs* ppResult);
    HRESULT createSVGPathSegLinetoVerticalRel(float y, ISVGPathSegLinetoVerticalRel* ppResult);
    HRESULT createSVGPathSegCurvetoCubicSmoothAbs(float x, float y, float x2, float y2, ISVGPathSegCurvetoCubicSmoothAbs* ppResult);
    HRESULT createSVGPathSegCurvetoCubicSmoothRel(float x, float y, float x2, float y2, ISVGPathSegCurvetoCubicSmoothRel* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticSmoothAbs(float x, float y, ISVGPathSegCurvetoQuadraticSmoothAbs* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticSmoothRel(float x, float y, ISVGPathSegCurvetoQuadraticSmoothRel* ppResult);
}

const GUID IID_DispSVGPathElement = {0x30590011, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590011, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGPathElement : IDispatch
{
}

const GUID IID_ISVGPreserveAspectRatio = {0x305104FA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104FA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGPreserveAspectRatio : IDispatch
{
    HRESULT put_align(short v);
    HRESULT get_align(short* p);
    HRESULT put_meetOrSlice(short v);
    HRESULT get_meetOrSlice(short* p);
}

const GUID IID_ISVGTextElement = {0x3051051C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051051C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGTextElement : IDispatch
{
}

const GUID IID_DispSVGTextElement = {0x30590037, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590037, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGTextElement : IDispatch
{
}

const GUID IID_ISVGImageElement = {0x305104F0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104F0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGImageElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
}

const GUID IID_DispSVGImageElement = {0x30590027, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590027, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGImageElement : IDispatch
{
}

const GUID IID_ISVGStopElement = {0x3051052B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051052B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGStopElement : IDispatch
{
    HRESULT putref_offset(ISVGAnimatedNumber v);
    HRESULT get_offset(ISVGAnimatedNumber* p);
}

const GUID IID_DispSVGStopElement = {0x3059002D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059002D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGStopElement : IDispatch
{
}

const GUID IID_ISVGGradientElement = {0x30510528, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510528, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGGradientElement : IDispatch
{
    HRESULT putref_gradientUnits(ISVGAnimatedEnumeration v);
    HRESULT get_gradientUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_gradientTransform(ISVGAnimatedTransformList v);
    HRESULT get_gradientTransform(ISVGAnimatedTransformList* p);
    HRESULT putref_spreadMethod(ISVGAnimatedEnumeration v);
    HRESULT get_spreadMethod(ISVGAnimatedEnumeration* p);
}

const GUID IID_DispSVGGradientElement = {0x3059002E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059002E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGGradientElement : IDispatch
{
}

const GUID IID_ISVGLinearGradientElement = {0x30510529, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510529, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGLinearGradientElement : IDispatch
{
    HRESULT putref_x1(ISVGAnimatedLength v);
    HRESULT get_x1(ISVGAnimatedLength* p);
    HRESULT putref_y1(ISVGAnimatedLength v);
    HRESULT get_y1(ISVGAnimatedLength* p);
    HRESULT putref_x2(ISVGAnimatedLength v);
    HRESULT get_x2(ISVGAnimatedLength* p);
    HRESULT putref_y2(ISVGAnimatedLength v);
    HRESULT get_y2(ISVGAnimatedLength* p);
}

const GUID IID_DispSVGLinearGradientElement = {0x3059002A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059002A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGLinearGradientElement : IDispatch
{
}

const GUID IID_ISVGRadialGradientElement = {0x3051052A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051052A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGRadialGradientElement : IDispatch
{
    HRESULT putref_cx(ISVGAnimatedLength v);
    HRESULT get_cx(ISVGAnimatedLength* p);
    HRESULT putref_cy(ISVGAnimatedLength v);
    HRESULT get_cy(ISVGAnimatedLength* p);
    HRESULT putref_r(ISVGAnimatedLength v);
    HRESULT get_r(ISVGAnimatedLength* p);
    HRESULT putref_fx(ISVGAnimatedLength v);
    HRESULT get_fx(ISVGAnimatedLength* p);
    HRESULT putref_fy(ISVGAnimatedLength v);
    HRESULT get_fy(ISVGAnimatedLength* p);
}

const GUID IID_DispSVGRadialGradientElement = {0x3059002B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059002B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGRadialGradientElement : IDispatch
{
}

const GUID IID_ISVGMaskElement = {0x3051052E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051052E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGMaskElement : IDispatch
{
    HRESULT putref_maskUnits(ISVGAnimatedEnumeration v);
    HRESULT get_maskUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_maskContentUnits(ISVGAnimatedEnumeration v);
    HRESULT get_maskContentUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
}

const GUID IID_DispSVGMaskElement = {0x3059003C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059003C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGMaskElement : IDispatch
{
}

const GUID IID_ISVGMarkerElement = {0x30510525, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510525, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGMarkerElement : IDispatch
{
    HRESULT putref_refX(ISVGAnimatedLength v);
    HRESULT get_refX(ISVGAnimatedLength* p);
    HRESULT putref_refY(ISVGAnimatedLength v);
    HRESULT get_refY(ISVGAnimatedLength* p);
    HRESULT putref_markerUnits(ISVGAnimatedEnumeration v);
    HRESULT get_markerUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_markerWidth(ISVGAnimatedLength v);
    HRESULT get_markerWidth(ISVGAnimatedLength* p);
    HRESULT putref_markerHeight(ISVGAnimatedLength v);
    HRESULT get_markerHeight(ISVGAnimatedLength* p);
    HRESULT putref_orientType(ISVGAnimatedEnumeration v);
    HRESULT get_orientType(ISVGAnimatedEnumeration* p);
    HRESULT putref_orientAngle(ISVGAnimatedAngle v);
    HRESULT get_orientAngle(ISVGAnimatedAngle* p);
    HRESULT setOrientToAuto();
    HRESULT setOrientToAngle(ISVGAngle pSVGAngle);
}

const GUID IID_DispSVGMarkerElement = {0x30590036, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590036, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGMarkerElement : IDispatch
{
}

const GUID IID_ISVGZoomEvent = {0x3051054E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051054E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGZoomEvent : IDispatch
{
    HRESULT get_zoomRectScreen(ISVGRect* p);
    HRESULT get_previousScale(float* p);
    HRESULT get_previousTranslate(ISVGPoint* p);
    HRESULT get_newScale(float* p);
    HRESULT get_newTranslate(ISVGPoint* p);
}

const GUID IID_DispSVGZoomEvent = {0x30590031, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590031, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGZoomEvent : IDispatch
{
}

const GUID IID_ISVGAElement = {0x3051054B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051054B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGAElement : IDispatch
{
    HRESULT putref_target(ISVGAnimatedString v);
    HRESULT get_target(ISVGAnimatedString* p);
}

const GUID IID_DispSVGAElement = {0x30590033, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590033, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGAElement : IDispatch
{
}

const GUID IID_ISVGViewElement = {0x3051054C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051054C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGViewElement : IDispatch
{
    HRESULT putref_viewTarget(ISVGStringList v);
    HRESULT get_viewTarget(ISVGStringList* p);
}

const GUID IID_DispSVGViewElement = {0x30590034, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590034, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGViewElement : IDispatch
{
}

const GUID IID_IHTMLMediaError = {0x30510704, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510704, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMediaError : IDispatch
{
    HRESULT get_code(short* p);
}

const GUID IID_IHTMLTimeRanges = {0x30510705, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510705, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTimeRanges : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT start(int index, float* startTime);
    HRESULT end(int index, float* endTime);
}

const GUID IID_IHTMLTimeRanges2 = {0x3051080B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051080B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLTimeRanges2 : IDispatch
{
    HRESULT startDouble(int index, double* startTime);
    HRESULT endDouble(int index, double* endTime);
}

const GUID IID_IHTMLMediaElement = {0x30510706, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510706, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMediaElement : IDispatch
{
    HRESULT get_error(IHTMLMediaError* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT get_currentSrc(BSTR* p);
    HRESULT get_networkState(ushort* p);
    HRESULT put_preload(BSTR v);
    HRESULT get_preload(BSTR* p);
    HRESULT get_buffered(IHTMLTimeRanges* p);
    HRESULT load();
    HRESULT canPlayType(BSTR type, BSTR* canPlay);
    HRESULT get_seeking(short* p);
    HRESULT put_currentTime(float v);
    HRESULT get_currentTime(float* p);
    HRESULT get_initialTime(float* p);
    HRESULT get_duration(float* p);
    HRESULT get_paused(short* p);
    HRESULT put_defaultPlaybackRate(float v);
    HRESULT get_defaultPlaybackRate(float* p);
    HRESULT put_playbackRate(float v);
    HRESULT get_playbackRate(float* p);
    HRESULT get_played(IHTMLTimeRanges* p);
    HRESULT get_seekable(IHTMLTimeRanges* p);
    HRESULT get_ended(short* p);
    HRESULT put_autoplay(short v);
    HRESULT get_autoplay(short* p);
    HRESULT put_loop(short v);
    HRESULT get_loop(short* p);
    HRESULT play();
    HRESULT pause();
    HRESULT put_controls(short v);
    HRESULT get_controls(short* p);
    HRESULT put_volume(float v);
    HRESULT get_volume(float* p);
    HRESULT put_muted(short v);
    HRESULT get_muted(short* p);
    HRESULT put_autobuffer(short v);
    HRESULT get_autobuffer(short* p);
}

const GUID IID_IHTMLMediaElement2 = {0x30510809, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510809, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMediaElement2 : IDispatch
{
    HRESULT put_currentTimeDouble(double v);
    HRESULT get_currentTimeDouble(double* p);
    HRESULT get_initialTimeDouble(double* p);
    HRESULT get_durationDouble(double* p);
    HRESULT put_defaultPlaybackRateDouble(double v);
    HRESULT get_defaultPlaybackRateDouble(double* p);
    HRESULT put_playbackRateDouble(double v);
    HRESULT get_playbackRateDouble(double* p);
    HRESULT put_volumeDouble(double v);
    HRESULT get_volumeDouble(double* p);
}

const GUID IID_IHTMLMSMediaElement = {0x30510792, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510792, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLMSMediaElement : IDispatch
{
    HRESULT put_msPlayToDisabled(short v);
    HRESULT get_msPlayToDisabled(short* p);
    HRESULT put_msPlayToPrimary(short v);
    HRESULT get_msPlayToPrimary(short* p);
}

const GUID IID_IHTMLSourceElement = {0x30510707, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510707, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLSourceElement : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

const GUID IID_IHTMLAudioElement = {0x30510708, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510708, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAudioElement : IDispatch
{
}

const GUID IID_IHTMLVideoElement = {0x30510709, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510709, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLVideoElement : IDispatch
{
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT get_videoWidth(uint* p);
    HRESULT get_videoHeight(uint* p);
    HRESULT put_poster(BSTR v);
    HRESULT get_poster(BSTR* p);
}

const GUID IID_IHTMLAudioElementFactory = {0x305107EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAudioElementFactory : IDispatch
{
    HRESULT create(VARIANT src, IHTMLAudioElement* __MIDL__IHTMLAudioElementFactory0000);
}

const GUID IID_DispHTMLMediaError = {0x30590086, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590086, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLMediaError : IDispatch
{
}

const GUID IID_DispHTMLTimeRanges = {0x30590087, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590087, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLTimeRanges : IDispatch
{
}

const GUID IID_DispHTMLMediaElement = {0x30590088, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590088, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLMediaElement : IDispatch
{
}

const GUID IID_DispHTMLSourceElement = {0x30590089, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590089, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLSourceElement : IDispatch
{
}

const GUID IID_DispHTMLAudioElement = {0x3059008A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059008A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLAudioElement : IDispatch
{
}

const GUID IID_DispHTMLVideoElement = {0x3059008B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059008B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLVideoElement : IDispatch
{
}

const GUID IID_ISVGSwitchElement = {0x305104F1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104F1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGSwitchElement : IDispatch
{
}

const GUID IID_DispSVGSwitchElement = {0x30590030, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590030, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGSwitchElement : IDispatch
{
}

const GUID IID_ISVGDescElement = {0x305104EA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104EA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGDescElement : IDispatch
{
}

const GUID IID_DispSVGDescElement = {0x30590005, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590005, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGDescElement : IDispatch
{
}

const GUID IID_ISVGTitleElement = {0x305104EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104EB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGTitleElement : IDispatch
{
}

const GUID IID_DispSVGTitleElement = {0x30590006, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590006, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGTitleElement : IDispatch
{
}

const GUID IID_ISVGMetadataElement = {0x30510560, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510560, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGMetadataElement : IDispatch
{
}

const GUID IID_DispSVGMetadataElement = {0x3059002F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059002F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGMetadataElement : IDispatch
{
}

const GUID IID_ISVGElementInstanceList = {0x305104EF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104EF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGElementInstanceList : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, ISVGElementInstance* ppResult);
}

const GUID IID_DispSVGElementInstance = {0x30590007, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590007, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGElementInstance : IDispatch
{
}

const GUID IID_DispSVGElementInstanceList = {0x30590008, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590008, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGElementInstanceList : IDispatch
{
}

const GUID IID_IDOMException = {0x3051072B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051072B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

const GUID IID_DispDOMException = {0x30590094, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590094, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMException : IDispatch
{
}

const GUID IID_IRangeException = {0x3051072D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051072D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IRangeException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

const GUID IID_DispRangeException = {0x30590095, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590095, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispRangeException : IDispatch
{
}

const GUID IID_ISVGException = {0x3051072F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051072F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

const GUID IID_DispSVGException = {0x30590096, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590096, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGException : IDispatch
{
}

const GUID IID_IEventException = {0x3051073A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051073A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IEventException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

const GUID IID_DispEventException = {0x30590099, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590099, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispEventException : IDispatch
{
}

const GUID IID_ISVGScriptElement = {0x3051054D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051054D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGScriptElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

const GUID IID_DispSVGScriptElement = {0x30590039, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590039, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGScriptElement : IDispatch
{
}

const GUID IID_ISVGStyleElement = {0x305104F3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104F3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGStyleElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

const GUID IID_DispSVGStyleElement = {0x30590029, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590029, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGStyleElement : IDispatch
{
}

const GUID IID_ISVGTextContentElement = {0x3051051A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051051A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGTextContentElement : IDispatch
{
    HRESULT putref_textLength(ISVGAnimatedLength v);
    HRESULT get_textLength(ISVGAnimatedLength* p);
    HRESULT putref_lengthAdjust(ISVGAnimatedEnumeration v);
    HRESULT get_lengthAdjust(ISVGAnimatedEnumeration* p);
    HRESULT getNumberOfChars(int* pResult);
    HRESULT getComputedTextLength(float* pResult);
    HRESULT getSubStringLength(int charnum, int nchars, float* pResult);
    HRESULT getStartPositionOfChar(int charnum, ISVGPoint* ppResult);
    HRESULT getEndPositionOfChar(int charnum, ISVGPoint* ppResult);
    HRESULT getExtentOfChar(int charnum, ISVGRect* ppResult);
    HRESULT getRotationOfChar(int charnum, float* pResult);
    HRESULT getCharNumAtPosition(ISVGPoint point, int* pResult);
    HRESULT selectSubString(int charnum, int nchars);
}

const GUID IID_DispSVGTextContentElement = {0x30590035, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590035, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGTextContentElement : IDispatch
{
}

const GUID IID_ISVGTextPositioningElement = {0x3051051B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051051B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGTextPositioningElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLengthList v);
    HRESULT get_x(ISVGAnimatedLengthList* p);
    HRESULT putref_y(ISVGAnimatedLengthList v);
    HRESULT get_y(ISVGAnimatedLengthList* p);
    HRESULT putref_dx(ISVGAnimatedLengthList v);
    HRESULT get_dx(ISVGAnimatedLengthList* p);
    HRESULT putref_dy(ISVGAnimatedLengthList v);
    HRESULT get_dy(ISVGAnimatedLengthList* p);
    HRESULT putref_rotate(ISVGAnimatedNumberList v);
    HRESULT get_rotate(ISVGAnimatedNumberList* p);
}

const GUID IID_DispSVGTextPositioningElement = {0x30590038, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590038, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGTextPositioningElement : IDispatch
{
}

const GUID IID_DispDOMDocumentType = {0x30590098, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30590098, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMDocumentType : IDispatch
{
}

const GUID IID_DispNodeIterator = {0x3059009C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059009C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispNodeIterator : IDispatch
{
}

const GUID IID_DispTreeWalker = {0x3059009D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059009D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispTreeWalker : IDispatch
{
}

const GUID IID_DispDOMProcessingInstruction = {0x3059009B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059009B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMProcessingInstruction : IDispatch
{
}

const GUID IID_IHTMLPerformanceNavigation = {0x30510750, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510750, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPerformanceNavigation : IDispatch
{
    HRESULT get_type(uint* p);
    HRESULT get_redirectCount(uint* p);
    HRESULT toString(BSTR* string);
    HRESULT toJSON(VARIANT* pVar);
}

const GUID IID_IHTMLPerformanceTiming = {0x30510752, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510752, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPerformanceTiming : IDispatch
{
    HRESULT get_navigationStart(ulong* p);
    HRESULT get_unloadEventStart(ulong* p);
    HRESULT get_unloadEventEnd(ulong* p);
    HRESULT get_redirectStart(ulong* p);
    HRESULT get_redirectEnd(ulong* p);
    HRESULT get_fetchStart(ulong* p);
    HRESULT get_domainLookupStart(ulong* p);
    HRESULT get_domainLookupEnd(ulong* p);
    HRESULT get_connectStart(ulong* p);
    HRESULT get_connectEnd(ulong* p);
    HRESULT get_requestStart(ulong* p);
    HRESULT get_responseStart(ulong* p);
    HRESULT get_responseEnd(ulong* p);
    HRESULT get_domLoading(ulong* p);
    HRESULT get_domInteractive(ulong* p);
    HRESULT get_domContentLoadedEventStart(ulong* p);
    HRESULT get_domContentLoadedEventEnd(ulong* p);
    HRESULT get_domComplete(ulong* p);
    HRESULT get_loadEventStart(ulong* p);
    HRESULT get_loadEventEnd(ulong* p);
    HRESULT get_msFirstPaint(ulong* p);
    HRESULT toString(BSTR* string);
    HRESULT toJSON(VARIANT* pVar);
}

const GUID IID_DispHTMLPerformance = {0x3059009F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059009F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLPerformance : IDispatch
{
}

const GUID IID_DispHTMLPerformanceNavigation = {0x305900A0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900A0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLPerformanceNavigation : IDispatch
{
}

const GUID IID_DispHTMLPerformanceTiming = {0x305900A1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900A1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLPerformanceTiming : IDispatch
{
}

const GUID IID_ISVGTSpanElement = {0x3051051D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051051D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGTSpanElement : IDispatch
{
}

const GUID IID_DispSVGTSpanElement = {0x3059003A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059003A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGTSpanElement : IDispatch
{
}

const GUID IID_ITemplatePrinter = {0x3050F6B4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6B4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ITemplatePrinter : IDispatch
{
    HRESULT startDoc(BSTR bstrTitle, short* p);
    HRESULT stopDoc();
    HRESULT printBlankPage();
    HRESULT printPage(IDispatch pElemDisp);
    HRESULT ensurePrintDialogDefaults(short* p);
    HRESULT showPrintDialog(short* p);
    HRESULT showPageSetupDialog(short* p);
    HRESULT printNonNative(IUnknown pMarkup, short* p);
    HRESULT printNonNativeFrames(IUnknown pMarkup, short fActiveFrame);
    HRESULT put_framesetDocument(short v);
    HRESULT get_framesetDocument(short* p);
    HRESULT put_frameActive(short v);
    HRESULT get_frameActive(short* p);
    HRESULT put_frameAsShown(short v);
    HRESULT get_frameAsShown(short* p);
    HRESULT put_selection(short v);
    HRESULT get_selection(short* p);
    HRESULT put_selectedPages(short v);
    HRESULT get_selectedPages(short* p);
    HRESULT put_currentPage(short v);
    HRESULT get_currentPage(short* p);
    HRESULT put_currentPageAvail(short v);
    HRESULT get_currentPageAvail(short* p);
    HRESULT put_collate(short v);
    HRESULT get_collate(short* p);
    HRESULT get_duplex(short* p);
    HRESULT put_copies(ushort v);
    HRESULT get_copies(ushort* p);
    HRESULT put_pageFrom(ushort v);
    HRESULT get_pageFrom(ushort* p);
    HRESULT put_pageTo(ushort v);
    HRESULT get_pageTo(ushort* p);
    HRESULT put_tableOfLinks(short v);
    HRESULT get_tableOfLinks(short* p);
    HRESULT put_allLinkedDocuments(short v);
    HRESULT get_allLinkedDocuments(short* p);
    HRESULT put_header(BSTR v);
    HRESULT get_header(BSTR* p);
    HRESULT put_footer(BSTR v);
    HRESULT get_footer(BSTR* p);
    HRESULT put_marginLeft(int v);
    HRESULT get_marginLeft(int* p);
    HRESULT put_marginRight(int v);
    HRESULT get_marginRight(int* p);
    HRESULT put_marginTop(int v);
    HRESULT get_marginTop(int* p);
    HRESULT put_marginBottom(int v);
    HRESULT get_marginBottom(int* p);
    HRESULT get_pageWidth(int* p);
    HRESULT get_pageHeight(int* p);
    HRESULT get_unprintableLeft(int* p);
    HRESULT get_unprintableTop(int* p);
    HRESULT get_unprintableRight(int* p);
    HRESULT get_unprintableBottom(int* p);
    HRESULT updatePageStatus(int* p);
}

const GUID IID_ITemplatePrinter2 = {0x3050F83F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F83F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ITemplatePrinter2 : ITemplatePrinter
{
    HRESULT put_selectionEnabled(short v);
    HRESULT get_selectionEnabled(short* p);
    HRESULT put_frameActiveEnabled(short v);
    HRESULT get_frameActiveEnabled(short* p);
    HRESULT put_orientation(BSTR v);
    HRESULT get_orientation(BSTR* p);
    HRESULT put_usePrinterCopyCollate(short v);
    HRESULT get_usePrinterCopyCollate(short* p);
    HRESULT deviceSupports(BSTR bstrProperty, VARIANT* pvar);
}

const GUID IID_ITemplatePrinter3 = {0x305104A3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305104A3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ITemplatePrinter3 : ITemplatePrinter2
{
    HRESULT put_headerFooterFont(BSTR v);
    HRESULT get_headerFooterFont(BSTR* p);
    HRESULT getPageMarginTop(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginRight(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginBottom(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginLeft(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginTopImportant(IDispatch pageRule, short* pbImportant);
    HRESULT getPageMarginRightImportant(IDispatch pageRule, short* pbImportant);
    HRESULT getPageMarginBottomImportant(IDispatch pageRule, short* pbImportant);
    HRESULT getPageMarginLeftImportant(IDispatch pageRule, short* pbImportant);
}

const GUID IID_IPrintManagerTemplatePrinter = {0xF633BE14, 0x9EFF, 0x4C4D, [0x92, 0x9E, 0x05, 0x71, 0x7B, 0x21, 0xB3, 0xE6]};
@GUID(0xF633BE14, 0x9EFF, 0x4C4D, [0x92, 0x9E, 0x05, 0x71, 0x7B, 0x21, 0xB3, 0xE6]);
interface IPrintManagerTemplatePrinter : IDispatch
{
    HRESULT startPrint();
    HRESULT drawPreviewPage(IDispatch pElemDisp, int nPage);
    HRESULT setPageCount(int nPage);
    HRESULT invalidatePreview();
    HRESULT getPrintTaskOptionValue(BSTR bstrKey, VARIANT* pvarin);
    HRESULT endPrint();
}

const GUID IID_IPrintManagerTemplatePrinter2 = {0xC6403497, 0x7493, 0x4F09, [0x80, 0x16, 0x54, 0xB0, 0x3E, 0x9B, 0xDA, 0x69]};
@GUID(0xC6403497, 0x7493, 0x4F09, [0x80, 0x16, 0x54, 0xB0, 0x3E, 0x9B, 0xDA, 0x69]);
interface IPrintManagerTemplatePrinter2 : IPrintManagerTemplatePrinter
{
    HRESULT get_showHeaderFooter(short* p);
    HRESULT get_shrinkToFit(short* p);
    HRESULT get_percentScale(float* p);
}

const GUID IID_DispCPrintManagerTemplatePrinter = {0x305900E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900E9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispCPrintManagerTemplatePrinter : IDispatch
{
}

const GUID IID_ISVGTextPathElement = {0x3051051F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051051F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISVGTextPathElement : IDispatch
{
    HRESULT putref_startOffset(ISVGAnimatedLength v);
    HRESULT get_startOffset(ISVGAnimatedLength* p);
    HRESULT putref_method(ISVGAnimatedEnumeration v);
    HRESULT get_method(ISVGAnimatedEnumeration* p);
    HRESULT putref_spacing(ISVGAnimatedEnumeration v);
    HRESULT get_spacing(ISVGAnimatedEnumeration* p);
}

const GUID IID_DispSVGTextPathElement = {0x3059003D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3059003D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispSVGTextPathElement : IDispatch
{
}

const GUID IID_IDOMXmlSerializer = {0x3051077D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051077D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMXmlSerializer : IDispatch
{
    HRESULT serializeToString(IHTMLDOMNode pNode, BSTR* pString);
}

const GUID IID_IDOMParser = {0x30510781, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510781, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMParser : IDispatch
{
    HRESULT parseFromString(BSTR xmlSource, BSTR mimeType, IHTMLDocument2* ppNode);
}

const GUID IID_DispXMLSerializer = {0x305900AD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900AD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispXMLSerializer : IDispatch
{
}

const GUID IID_DispDOMParser = {0x305900AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900AE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMParser : IDispatch
{
}

const GUID IID_IDOMXmlSerializerFactory = {0x3051077F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051077F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMXmlSerializerFactory : IDispatch
{
    HRESULT create(IDOMXmlSerializer* __MIDL__IDOMXmlSerializerFactory0000);
}

const GUID IID_IDOMParserFactory = {0x30510783, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510783, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMParserFactory : IDispatch
{
    HRESULT create(IDOMParser* __MIDL__IDOMParserFactory0000);
}

const GUID IID_DispHTMLSemanticElement = {0x305900BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLSemanticElement : IDispatch
{
}

const GUID IID_IHTMLProgressElement = {0x3050F2D6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F2D6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLProgressElement : IDispatch
{
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
    HRESULT put_max(float v);
    HRESULT get_max(float* p);
    HRESULT get_position(float* p);
    HRESULT get_form(IHTMLFormElement* p);
}

const GUID IID_DispHTMLProgressElement = {0x305900AF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900AF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLProgressElement : IDispatch
{
}

const GUID IID_IDOMMSTransitionEvent = {0x305107B5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107B5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMMSTransitionEvent : IDispatch
{
    HRESULT get_propertyName(BSTR* p);
    HRESULT get_elapsedTime(float* p);
    HRESULT initMSTransitionEvent(BSTR eventType, short canBubble, short cancelable, BSTR propertyName, float elapsedTime);
}

const GUID IID_DispDOMMSTransitionEvent = {0x305900BB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900BB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMMSTransitionEvent : IDispatch
{
}

const GUID IID_IDOMMSAnimationEvent = {0x305107B7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107B7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMMSAnimationEvent : IDispatch
{
    HRESULT get_animationName(BSTR* p);
    HRESULT get_elapsedTime(float* p);
    HRESULT initMSAnimationEvent(BSTR eventType, short canBubble, short cancelable, BSTR animationName, float elapsedTime);
}

const GUID IID_DispDOMMSAnimationEvent = {0x305900BC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900BC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMMSAnimationEvent : IDispatch
{
}

const GUID IID_IWebGeocoordinates = {0x305107C7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107C7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IWebGeocoordinates : IDispatch
{
    HRESULT get_latitude(double* p);
    HRESULT get_longitude(double* p);
    HRESULT get_altitude(VARIANT* p);
    HRESULT get_accuracy(double* p);
    HRESULT get_altitudeAccuracy(VARIANT* p);
    HRESULT get_heading(VARIANT* p);
    HRESULT get_speed(VARIANT* p);
}

const GUID IID_IWebGeopositionError = {0x305107C9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107C9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IWebGeopositionError : IDispatch
{
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

const GUID IID_IWebGeoposition = {0x305107CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IWebGeoposition : IDispatch
{
    HRESULT get_coords(IWebGeocoordinates* p);
    HRESULT get_timestamp(ulong* p);
}

const GUID IID_DispWebGeolocation = {0x305900BD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900BD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispWebGeolocation : IDispatch
{
}

const GUID IID_DispWebGeocoordinates = {0x305900BE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900BE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispWebGeocoordinates : IDispatch
{
}

const GUID IID_DispWebGeopositionError = {0x305900BF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900BF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispWebGeopositionError : IDispatch
{
}

const GUID IID_DispWebGeoposition = {0x305900C1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900C1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispWebGeoposition : IDispatch
{
}

const GUID IID_IClientCaps = {0x7E8BC44D, 0xAEFF, 0x11D1, [0x89, 0xC2, 0x00, 0xC0, 0x4F, 0xB6, 0xBF, 0xC4]};
@GUID(0x7E8BC44D, 0xAEFF, 0x11D1, [0x89, 0xC2, 0x00, 0xC0, 0x4F, 0xB6, 0xBF, 0xC4]);
interface IClientCaps : IDispatch
{
    HRESULT get_javaEnabled(short* p);
    HRESULT get_cookieEnabled(short* p);
    HRESULT get_cpuClass(BSTR* p);
    HRESULT get_systemLanguage(BSTR* p);
    HRESULT get_userLanguage(BSTR* p);
    HRESULT get_platform(BSTR* p);
    HRESULT get_connectionSpeed(int* p);
    HRESULT get_onLine(short* p);
    HRESULT get_colorDepth(int* p);
    HRESULT get_bufferDepth(int* p);
    HRESULT get_width(int* p);
    HRESULT get_height(int* p);
    HRESULT get_availHeight(int* p);
    HRESULT get_availWidth(int* p);
    HRESULT get_connectionType(BSTR* p);
    HRESULT isComponentInstalled(BSTR bstrName, BSTR bstrUrl, BSTR bStrVer, short* p);
    HRESULT getComponentVersion(BSTR bstrName, BSTR bstrUrl, BSTR* pbstrVer);
    HRESULT compareVersions(BSTR bstrVer1, BSTR bstrVer2, int* p);
    HRESULT addComponentRequest(BSTR bstrName, BSTR bstrUrl, BSTR bStrVer);
    HRESULT doComponentRequest(short* p);
    HRESULT clearComponentRequest();
}

const GUID IID_IDOMMSManipulationEvent = {0x30510816, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510816, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMMSManipulationEvent : IDispatch
{
    HRESULT get_lastState(int* p);
    HRESULT get_currentState(int* p);
    HRESULT initMSManipulationEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, int detailArg, int lastState, int currentState);
}

const GUID IID_DispDOMMSManipulationEvent = {0x305900E1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900E1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMMSManipulationEvent : IDispatch
{
}

const GUID IID_IDOMCloseEvent = {0x305107FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107FF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMCloseEvent : IDispatch
{
    HRESULT get_wasClean(short* p);
    HRESULT initCloseEvent(BSTR eventType, short canBubble, short cancelable, short wasClean, int code, BSTR reason);
}

const GUID IID_DispDOMCloseEvent = {0x305900DC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900DC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispDOMCloseEvent : IDispatch
{
}

const GUID IID_DispApplicationCache = {0x305900E4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305900E4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispApplicationCache : IDispatch
{
}

const GUID IID_ICSSFilterSite = {0x3050F3ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ICSSFilterSite : IUnknown
{
    HRESULT GetElement(IHTMLElement* Element);
    HRESULT FireOnFilterChangeEvent();
}

const GUID IID_IMarkupPointer = {0x3050F49F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F49F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IMarkupPointer : IUnknown
{
    HRESULT OwningDoc(IHTMLDocument2* ppDoc);
    HRESULT Gravity(POINTER_GRAVITY* pGravity);
    HRESULT SetGravity(POINTER_GRAVITY Gravity);
    HRESULT Cling(int* pfCling);
    HRESULT SetCling(BOOL fCLing);
    HRESULT Unposition();
    HRESULT IsPositioned(int* pfPositioned);
    HRESULT GetContainer(IMarkupContainer* ppContainer);
    HRESULT MoveAdjacentToElement(IHTMLElement pElement, ELEMENT_ADJACENCY eAdj);
    HRESULT MoveToPointer(IMarkupPointer pPointer);
    HRESULT MoveToContainer(IMarkupContainer pContainer, BOOL fAtStart);
    HRESULT Left(BOOL fMove, MARKUP_CONTEXT_TYPE* pContext, IHTMLElement* ppElement, int* pcch, char* pchText);
    HRESULT Right(BOOL fMove, MARKUP_CONTEXT_TYPE* pContext, IHTMLElement* ppElement, int* pcch, char* pchText);
    HRESULT CurrentScope(IHTMLElement* ppElemCurrent);
    HRESULT IsLeftOf(IMarkupPointer pPointerThat, int* pfResult);
    HRESULT IsLeftOfOrEqualTo(IMarkupPointer pPointerThat, int* pfResult);
    HRESULT IsRightOf(IMarkupPointer pPointerThat, int* pfResult);
    HRESULT IsRightOfOrEqualTo(IMarkupPointer pPointerThat, int* pfResult);
    HRESULT IsEqualTo(IMarkupPointer pPointerThat, int* pfAreEqual);
    HRESULT MoveUnit(MOVEUNIT_ACTION muAction);
    HRESULT FindTextA(ushort* pchFindText, uint dwFlags, IMarkupPointer pIEndMatch, IMarkupPointer pIEndSearch);
}

const GUID IID_IMarkupContainer = {0x3050F5F9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5F9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IMarkupContainer : IUnknown
{
    HRESULT OwningDoc(IHTMLDocument2* ppDoc);
}

const GUID IID_IMarkupContainer2 = {0x3050F648, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F648, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IMarkupContainer2 : IMarkupContainer
{
    HRESULT CreateChangeLog(IHTMLChangeSink pChangeSink, IHTMLChangeLog* ppChangeLog, BOOL fForward, BOOL fBackward);
    HRESULT RegisterForDirtyRange(IHTMLChangeSink pChangeSink, uint* pdwCookie);
    HRESULT UnRegisterForDirtyRange(uint dwCookie);
    HRESULT GetAndClearDirtyRange(uint dwCookie, IMarkupPointer pIPointerBegin, IMarkupPointer pIPointerEnd);
    int GetVersionNumber();
    HRESULT GetMasterElement(IHTMLElement* ppElementMaster);
}

const GUID IID_IHTMLChangeLog = {0x3050F649, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F649, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLChangeLog : IUnknown
{
    HRESULT GetNextChange(ubyte* pbBuffer, int nBufferSize, int* pnRecordLength);
}

const GUID IID_IHTMLChangeSink = {0x3050F64A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F64A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLChangeSink : IUnknown
{
    HRESULT Notify();
}

const GUID IID_ISegmentList = {0x3050F605, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F605, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISegmentList : IUnknown
{
    HRESULT CreateIterator(ISegmentListIterator* ppIIter);
    HRESULT GetType(SELECTION_TYPE* peType);
    HRESULT IsEmpty(int* pfEmpty);
}

const GUID IID_ISegmentListIterator = {0x3050F692, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F692, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISegmentListIterator : IUnknown
{
    HRESULT Current(ISegment* ppISegment);
    HRESULT First();
    HRESULT IsDone();
    HRESULT Advance();
}

const GUID IID_IHTMLCaret = {0x3050F604, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F604, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLCaret : IUnknown
{
    HRESULT MoveCaretToPointer(IDisplayPointer pDispPointer, BOOL fScrollIntoView, CARET_DIRECTION eDir);
    HRESULT MoveCaretToPointerEx(IDisplayPointer pDispPointer, BOOL fVisible, BOOL fScrollIntoView, CARET_DIRECTION eDir);
    HRESULT MoveMarkupPointerToCaret(IMarkupPointer pIMarkupPointer);
    HRESULT MoveDisplayPointerToCaret(IDisplayPointer pDispPointer);
    HRESULT IsVisible(int* pIsVisible);
    HRESULT Show(BOOL fScrollIntoView);
    HRESULT Hide();
    HRESULT InsertText(ushort* pText, int lLen);
    HRESULT ScrollIntoView();
    HRESULT GetLocation(POINT* pPoint, BOOL fTranslate);
    HRESULT GetCaretDirection(CARET_DIRECTION* peDir);
    HRESULT SetCaretDirection(CARET_DIRECTION eDir);
}

const GUID IID_ISegment = {0x3050F683, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F683, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISegment : IUnknown
{
    HRESULT GetPointers(IMarkupPointer pIStart, IMarkupPointer pIEnd);
}

const GUID IID_IElementSegment = {0x3050F68F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F68F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementSegment : ISegment
{
    HRESULT GetElement(IHTMLElement* ppIElement);
    HRESULT SetPrimary(BOOL fPrimary);
    HRESULT IsPrimary(int* pfPrimary);
}

const GUID IID_IHighlightSegment = {0x3050F690, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F690, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHighlightSegment : ISegment
{
}

const GUID IID_IHighlightRenderingServices = {0x3050F606, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F606, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHighlightRenderingServices : IUnknown
{
    HRESULT AddSegment(IDisplayPointer pDispPointerStart, IDisplayPointer pDispPointerEnd, IHTMLRenderStyle pIRenderStyle, IHighlightSegment* ppISegment);
    HRESULT MoveSegmentToPointers(IHighlightSegment pISegment, IDisplayPointer pDispPointerStart, IDisplayPointer pDispPointerEnd);
    HRESULT RemoveSegment(IHighlightSegment pISegment);
}

const GUID IID_ILineInfo = {0x3050F7E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ILineInfo : IUnknown
{
    HRESULT get_x(int* p);
    HRESULT get_baseLine(int* p);
    HRESULT get_textDescent(int* p);
    HRESULT get_textHeight(int* p);
    HRESULT get_lineDirection(int* p);
}

const GUID IID_IDisplayPointer = {0x3050F69E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F69E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDisplayPointer : IUnknown
{
    HRESULT MoveToPoint(POINT ptPoint, COORD_SYSTEM eCoordSystem, IHTMLElement pElementContext, uint dwHitTestOptions, uint* pdwHitTestResults);
    HRESULT MoveUnit(DISPLAY_MOVEUNIT eMoveUnit, int lXPos);
    HRESULT PositionMarkupPointer(IMarkupPointer pMarkupPointer);
    HRESULT MoveToPointer(IDisplayPointer pDispPointer);
    HRESULT SetPointerGravity(POINTER_GRAVITY eGravity);
    HRESULT GetPointerGravity(POINTER_GRAVITY* peGravity);
    HRESULT SetDisplayGravity(DISPLAY_GRAVITY eGravity);
    HRESULT GetDisplayGravity(DISPLAY_GRAVITY* peGravity);
    HRESULT IsPositioned(int* pfPositioned);
    HRESULT Unposition();
    HRESULT IsEqualTo(IDisplayPointer pDispPointer, int* pfIsEqual);
    HRESULT IsLeftOf(IDisplayPointer pDispPointer, int* pfIsLeftOf);
    HRESULT IsRightOf(IDisplayPointer pDispPointer, int* pfIsRightOf);
    HRESULT IsAtBOL(int* pfBOL);
    HRESULT MoveToMarkupPointer(IMarkupPointer pPointer, IDisplayPointer pDispLineContext);
    HRESULT ScrollIntoView();
    HRESULT GetLineInfo(ILineInfo* ppLineInfo);
    HRESULT GetFlowElement(IHTMLElement* ppLayoutElement);
    HRESULT QueryBreaks(uint* pdwBreaks);
}

const GUID IID_IDisplayServices = {0x3050F69D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F69D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDisplayServices : IUnknown
{
    HRESULT CreateDisplayPointer(IDisplayPointer* ppDispPointer);
    HRESULT TransformRect(RECT* pRect, COORD_SYSTEM eSource, COORD_SYSTEM eDestination, IHTMLElement pIElement);
    HRESULT TransformPoint(POINT* pPoint, COORD_SYSTEM eSource, COORD_SYSTEM eDestination, IHTMLElement pIElement);
    HRESULT GetCaret(IHTMLCaret* ppCaret);
    HRESULT GetComputedStyle(IMarkupPointer pPointer, IHTMLComputedStyle* ppComputedStyle);
    HRESULT ScrollRectIntoView(IHTMLElement pIElement, RECT rect);
    HRESULT HasFlowLayout(IHTMLElement pIElement, int* pfHasFlowLayout);
}

const GUID IID_IHtmlDlgSafeHelper = {0x3050F81A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F81A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHtmlDlgSafeHelper : IDispatch
{
    HRESULT choosecolordlg(VARIANT initColor, VARIANT* rgbColor);
    HRESULT getCharset(BSTR fontName, VARIANT* charset);
    HRESULT get_Fonts(IDispatch* p);
    HRESULT get_BlockFormats(IDispatch* p);
}

const GUID IID_IBlockFormats = {0x3050F830, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F830, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IBlockFormats : IDispatch
{
    HRESULT get__NewEnum(IUnknown* p);
    HRESULT get_Count(int* p);
    HRESULT Item(VARIANT* pvarIndex, BSTR* pbstrBlockFormat);
}

const GUID IID_IFontNames = {0x3050F839, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F839, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IFontNames : IDispatch
{
    HRESULT get__NewEnum(IUnknown* p);
    HRESULT get_Count(int* p);
    HRESULT Item(VARIANT* pvarIndex, BSTR* pbstrFontName);
}

const GUID IID_ICSSFilter = {0x3050F3EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F3EC, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ICSSFilter : IUnknown
{
    HRESULT SetSite(ICSSFilterSite pSink);
    HRESULT OnAmbientPropertyChange(int dispid);
}

const GUID IID_ISecureUrlHost = {0xC81984C4, 0x74C8, 0x11D2, [0xBA, 0xA9, 0x00, 0xC0, 0x4F, 0xC2, 0x04, 0x0E]};
@GUID(0xC81984C4, 0x74C8, 0x11D2, [0xBA, 0xA9, 0x00, 0xC0, 0x4F, 0xC2, 0x04, 0x0E]);
interface ISecureUrlHost : IUnknown
{
    HRESULT ValidateSecureUrl(int* pfAllow, ushort* pchUrlInQuestion, uint dwFlags);
}

const GUID IID_IMarkupServices = {0x3050F4A0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4A0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IMarkupServices : IUnknown
{
    HRESULT CreateMarkupPointer(IMarkupPointer* ppPointer);
    HRESULT CreateMarkupContainer(IMarkupContainer* ppMarkupContainer);
    HRESULT CreateElement(ELEMENT_TAG_ID tagID, ushort* pchAttributes, IHTMLElement* ppElement);
    HRESULT CloneElement(IHTMLElement pElemCloneThis, IHTMLElement* ppElementTheClone);
    HRESULT InsertElement(IHTMLElement pElementInsert, IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT RemoveElement(IHTMLElement pElementRemove);
    HRESULT Remove(IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT Copy(IMarkupPointer pPointerSourceStart, IMarkupPointer pPointerSourceFinish, IMarkupPointer pPointerTarget);
    HRESULT Move(IMarkupPointer pPointerSourceStart, IMarkupPointer pPointerSourceFinish, IMarkupPointer pPointerTarget);
    HRESULT InsertText(ushort* pchText, int cch, IMarkupPointer pPointerTarget);
    HRESULT ParseString(ushort* pchHTML, uint dwFlags, IMarkupContainer* ppContainerResult, IMarkupPointer ppPointerStart, IMarkupPointer ppPointerFinish);
    HRESULT ParseGlobal(int hglobalHTML, uint dwFlags, IMarkupContainer* ppContainerResult, IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT IsScopedElement(IHTMLElement pElement, int* pfScoped);
    HRESULT GetElementTagId(IHTMLElement pElement, ELEMENT_TAG_ID* ptagId);
    HRESULT GetTagIDForName(BSTR bstrName, ELEMENT_TAG_ID* ptagId);
    HRESULT GetNameForTagID(ELEMENT_TAG_ID tagId, BSTR* pbstrName);
    HRESULT MovePointersToRange(IHTMLTxtRange pIRange, IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT MoveRangeToPointers(IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish, IHTMLTxtRange pIRange);
    HRESULT BeginUndoUnit(ushort* pchTitle);
    HRESULT EndUndoUnit();
}

const GUID IID_IMarkupServices2 = {0x3050F682, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F682, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IMarkupServices2 : IMarkupServices
{
    HRESULT ParseGlobalEx(int hglobalHTML, uint dwFlags, IMarkupContainer pContext, IMarkupContainer* ppContainerResult, IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT ValidateElements(IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish, IMarkupPointer pPointerTarget, IMarkupPointer pPointerStatus, IHTMLElement* ppElemFailBottom, IHTMLElement* ppElemFailTop);
    HRESULT SaveSegmentsToClipboard(ISegmentList pSegmentList, uint dwFlags);
}

const GUID IID_IHTMLChangePlayback = {0x3050F6E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLChangePlayback : IUnknown
{
    HRESULT ExecChange(ubyte* pbRecord, BOOL fForward);
}

const GUID IID_IMarkupPointer2 = {0x3050F675, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F675, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IMarkupPointer2 : IMarkupPointer
{
    HRESULT IsAtWordBreak(int* pfAtBreak);
    HRESULT GetMarkupPosition(int* plMP);
    HRESULT MoveToMarkupPosition(IMarkupContainer pContainer, int lMP);
    HRESULT MoveUnitBounded(MOVEUNIT_ACTION muAction, IMarkupPointer pIBoundary);
    HRESULT IsInsideURL(IMarkupPointer pRight, int* pfResult);
    HRESULT MoveToContent(IHTMLElement pIElement, BOOL fAtStart);
}

const GUID IID_IMarkupTextFrags = {0x3050F5FA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5FA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IMarkupTextFrags : IUnknown
{
    HRESULT GetTextFragCount(int* pcFrags);
    HRESULT GetTextFrag(int iFrag, BSTR* pbstrFrag, IMarkupPointer pPointerFrag);
    HRESULT RemoveTextFrag(int iFrag);
    HRESULT InsertTextFrag(int iFrag, BSTR bstrInsert, IMarkupPointer pPointerInsert);
    HRESULT FindTextFragFromMarkupPointer(IMarkupPointer pPointerFind, int* piFrag, int* pfFragFound);
}

const GUID IID_IXMLGenericParse = {0xE4E23071, 0x4D07, 0x11D2, [0xAE, 0x76, 0x00, 0x80, 0xC7, 0x3B, 0xC1, 0x99]};
@GUID(0xE4E23071, 0x4D07, 0x11D2, [0xAE, 0x76, 0x00, 0x80, 0xC7, 0x3B, 0xC1, 0x99]);
interface IXMLGenericParse : IUnknown
{
    HRESULT SetGenericParse(short fDoGeneric);
}

const GUID IID_IHTMLEditHost = {0x3050F6A0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6A0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEditHost : IUnknown
{
    HRESULT SnapRect(IHTMLElement pIElement, RECT* prcNew, ELEMENT_CORNER eHandle);
}

const GUID IID_IHTMLEditHost2 = {0x3050F848, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0D]};
@GUID(0x3050F848, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0D]);
interface IHTMLEditHost2 : IHTMLEditHost
{
    HRESULT PreDrag();
}

const GUID IID_ISequenceNumber = {0x3050F6C1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6C1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISequenceNumber : IUnknown
{
    HRESULT GetSequenceNumber(int nCurrent, int* pnNew);
}

const GUID IID_IIMEServices = {0x3050F6CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IIMEServices : IUnknown
{
    HRESULT GetActiveIMM(IActiveIMMApp* ppActiveIMM);
}

const GUID IID_ISelectionServicesListener = {0x3050F699, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F699, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISelectionServicesListener : IUnknown
{
    HRESULT BeginSelectionUndo();
    HRESULT EndSelectionUndo();
    HRESULT OnSelectedElementExit(IMarkupPointer pIElementStart, IMarkupPointer pIElementEnd, IMarkupPointer pIElementContentStart, IMarkupPointer pIElementContentEnd);
    HRESULT OnChangeType(SELECTION_TYPE eType, ISelectionServicesListener pIListener);
    HRESULT GetTypeDetail(BSTR* pTypeDetail);
}

const GUID IID_ISelectionServices = {0x3050F684, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F684, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISelectionServices : IUnknown
{
    HRESULT SetSelectionType(SELECTION_TYPE eType, ISelectionServicesListener pIListener);
    HRESULT GetMarkupContainer(IMarkupContainer* ppIContainer);
    HRESULT AddSegment(IMarkupPointer pIStart, IMarkupPointer pIEnd, ISegment* ppISegmentAdded);
    HRESULT AddElementSegment(IHTMLElement pIElement, IElementSegment* ppISegmentAdded);
    HRESULT RemoveSegment(ISegment pISegment);
    HRESULT GetSelectionServicesListener(ISelectionServicesListener* ppISelectionServicesListener);
}

const GUID IID_IHTMLEditDesigner = {0x3050F662, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F662, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEditDesigner : IUnknown
{
    HRESULT PreHandleEvent(int inEvtDispId, IHTMLEventObj pIEventObj);
    HRESULT PostHandleEvent(int inEvtDispId, IHTMLEventObj pIEventObj);
    HRESULT TranslateAcceleratorA(int inEvtDispId, IHTMLEventObj pIEventObj);
    HRESULT PostEditorEventNotify(int inEvtDispId, IHTMLEventObj pIEventObj);
}

const GUID IID_IHTMLEditServices = {0x3050F663, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F663, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEditServices : IUnknown
{
    HRESULT AddDesigner(IHTMLEditDesigner pIDesigner);
    HRESULT RemoveDesigner(IHTMLEditDesigner pIDesigner);
    HRESULT GetSelectionServices(IMarkupContainer pIContainer, ISelectionServices* ppSelSvc);
    HRESULT MoveToSelectionAnchor(IMarkupPointer pIStartAnchor);
    HRESULT MoveToSelectionEnd(IMarkupPointer pIEndAnchor);
    HRESULT SelectRange(IMarkupPointer pStart, IMarkupPointer pEnd, SELECTION_TYPE eType);
}

const GUID IID_IHTMLEditServices2 = {0x3050F812, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F812, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLEditServices2 : IHTMLEditServices
{
    HRESULT MoveToSelectionAnchorEx(IDisplayPointer pIStartAnchor);
    HRESULT MoveToSelectionEndEx(IDisplayPointer pIEndAnchor);
    HRESULT FreezeVirtualCaretPos(BOOL fReCompute);
    HRESULT UnFreezeVirtualCaretPos(BOOL fReset);
}

const GUID IID_IHTMLComputedStyle = {0x3050F6C3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6C3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLComputedStyle : IUnknown
{
    HRESULT get_bold(short* p);
    HRESULT get_italic(short* p);
    HRESULT get_underline(short* p);
    HRESULT get_overline(short* p);
    HRESULT get_strikeOut(short* p);
    HRESULT get_subScript(short* p);
    HRESULT get_superScript(short* p);
    HRESULT get_explicitFace(short* p);
    HRESULT get_fontWeight(int* p);
    HRESULT get_fontSize(int* p);
    HRESULT get_fontName(byte* p);
    HRESULT get_hasBgColor(short* p);
    HRESULT get_textColor(uint* p);
    HRESULT get_backgroundColor(uint* p);
    HRESULT get_preFormatted(short* p);
    HRESULT get_direction(short* p);
    HRESULT get_blockDirection(short* p);
    HRESULT get_OL(short* p);
    HRESULT IsEqual(IHTMLComputedStyle pComputedStyle, short* pfEqual);
}

const GUID IID_IDeveloperConsoleMessageReceiver = {0x30510808, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510808, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDeveloperConsoleMessageReceiver : IUnknown
{
    HRESULT Write(const(wchar)* source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, const(wchar)* messageText);
    HRESULT WriteWithUrl(const(wchar)* source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, const(wchar)* messageText, const(wchar)* fileUrl);
    HRESULT WriteWithUrlAndLine(const(wchar)* source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, const(wchar)* messageText, const(wchar)* fileUrl, uint line);
    HRESULT WriteWithUrlLineAndColumn(const(wchar)* source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, const(wchar)* messageText, const(wchar)* fileUrl, uint line, uint column);
}

const GUID IID_IScriptEventHandler = {0x3051083A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051083A, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IScriptEventHandler : IUnknown
{
    HRESULT FunctionName(BSTR* pbstrFunctionName);
    HRESULT DebugDocumentContext(IUnknown* ppDebugDocumentContext);
    HRESULT EventHandlerDispatch(IDispatch* ppDispHandler);
    HRESULT UsesCapture(int* pfUsesCapture);
    HRESULT Cookie(ulong* pullCookie);
}

const GUID IID_IDebugCallbackNotificationHandler = {0x30510842, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510842, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDebugCallbackNotificationHandler : IUnknown
{
    HRESULT RequestedCallbackTypes(uint* pCallbackMask);
    HRESULT BeforeDispatchEvent(IUnknown pEvent);
    HRESULT DispatchEventComplete(IUnknown pEvent, uint propagationStatus);
    HRESULT BeforeInvokeDomCallback(IUnknown pEvent, IScriptEventHandler pCallback, DOM_EVENT_PHASE eStage, uint propagationStatus);
    HRESULT InvokeDomCallbackComplete(IUnknown pEvent, IScriptEventHandler pCallback, DOM_EVENT_PHASE eStage, uint propagationStatus);
    HRESULT BeforeInvokeCallback(SCRIPT_TIMER_TYPE eCallbackType, uint callbackCookie, IDispatch pDispHandler, ulong ullHandlerCookie, BSTR functionName, uint line, uint column, uint cchLength, IUnknown pDebugDocumentContext);
    HRESULT InvokeCallbackComplete(SCRIPT_TIMER_TYPE eCallbackType, uint callbackCookie, IDispatch pDispHandler, ulong ullHandlerCookie, BSTR functionName, uint line, uint column, uint cchLength, IUnknown pDebugDocumentContext);
}

const GUID IID_IScriptEventHandlerSourceInfo = {0x30510841, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510841, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IScriptEventHandlerSourceInfo : IUnknown
{
    HRESULT GetSourceInfo(BSTR* pbstrFunctionName, uint* line, uint* column, uint* cchLength);
}

const GUID IID_IDOMEventRegistrationCallback = {0x3051083B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051083B, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IDOMEventRegistrationCallback : IUnknown
{
    HRESULT OnDOMEventListenerAdded(const(wchar)* pszEventType, IScriptEventHandler pHandler);
    HRESULT OnDOMEventListenerRemoved(ulong ullCookie);
}

const GUID IID_IEventTarget2 = {0x30510839, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510839, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IEventTarget2 : IUnknown
{
    HRESULT GetRegisteredEventTypes(SAFEARRAY** ppEventTypeArray);
    HRESULT GetListenersForType(const(wchar)* pszEventType, SAFEARRAY** ppEventHandlerArray);
    HRESULT RegisterForDOMEventListeners(IDOMEventRegistrationCallback pCallback);
    HRESULT UnregisterForDOMEventListeners(IDOMEventRegistrationCallback pCallback);
}

const GUID IID_HTMLNamespaceEvents = {0x3050F6BD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6BD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface HTMLNamespaceEvents : IDispatch
{
}

const GUID IID_IHTMLNamespace = {0x3050F6BB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6BB, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLNamespace : IDispatch
{
    HRESULT get_name(BSTR* p);
    HRESULT get_urn(BSTR* p);
    HRESULT get_tagNames(IDispatch* p);
    HRESULT get_readyState(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT doImport(BSTR bstrImplementationUrl);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, short* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
}

const GUID IID_IHTMLNamespaceCollection = {0x3050F6B8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6B8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLNamespaceCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(VARIANT index, IDispatch* ppNamespace);
    HRESULT add(BSTR bstrNamespace, BSTR bstrUrn, VARIANT implementationUrl, IDispatch* ppNamespace);
}

const GUID IID_DispHTMLNamespace = {0x3050F54F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F54F, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLNamespace : IDispatch
{
}

const GUID IID_DispHTMLNamespaceCollection = {0x3050F550, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F550, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLNamespaceCollection : IDispatch
{
}

const GUID IID_IHTMLPainter = {0x3050F6A6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6A6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPainter : IUnknown
{
    HRESULT Draw(RECT rcBounds, RECT rcUpdate, int lDrawFlags, HDC hdc, void* pvDrawObject);
    HRESULT OnResize(SIZE size);
    HRESULT GetPainterInfo(HTML_PAINTER_INFO* pInfo);
    HRESULT HitTestPoint(POINT pt, int* pbHit, int* plPartID);
}

const GUID IID_IHTMLPaintSite = {0x3050F6A7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6A7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPaintSite : IUnknown
{
    HRESULT InvalidatePainterInfo();
    HRESULT InvalidateRect(RECT* prcInvalid);
    HRESULT InvalidateRegion(HRGN rgnInvalid);
    HRESULT GetDrawInfo(int lFlags, HTML_PAINT_DRAW_INFO* pDrawInfo);
    HRESULT TransformGlobalToLocal(POINT ptGlobal, POINT* pptLocal);
    HRESULT TransformLocalToGlobal(POINT ptLocal, POINT* pptGlobal);
    HRESULT GetHitTestCookie(int* plCookie);
}

const GUID IID_IHTMLPainterEventInfo = {0x3050F6DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6DF, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPainterEventInfo : IUnknown
{
    HRESULT GetEventInfoFlags(int* plEventInfoFlags);
    HRESULT GetEventTarget(IHTMLElement* ppElement);
    HRESULT SetCursor(int lPartID);
    HRESULT StringFromPartID(int lPartID, BSTR* pbstrPart);
}

const GUID IID_IHTMLPainterOverlay = {0x3050F7E3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7E3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPainterOverlay : IUnknown
{
    HRESULT OnMove(RECT rcDevice);
}

const GUID IID_IHTMLIPrintCollection = {0x3050F6B5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6B5, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLIPrintCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, IUnknown* ppIPrint);
}

const GUID IID_IEnumPrivacyRecords = {0x3050F844, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F844, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IEnumPrivacyRecords : IUnknown
{
    HRESULT Reset();
    HRESULT GetSize(uint* pSize);
    HRESULT GetPrivacyImpacted(int* pState);
    HRESULT Next(BSTR* pbstrUrl, BSTR* pbstrPolicyRef, int* pdwReserved, uint* pdwPrivacyFlags);
}

const GUID IID_IWPCBlockedUrls = {0x30510413, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510413, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IWPCBlockedUrls : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT GetUrl(uint dwIdx, BSTR* pbstrUrl);
}

const GUID IID_IHTMLDOMConstructorCollection = {0x3051049C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3051049C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDOMConstructorCollection : IDispatch
{
    HRESULT get_Attr(IDispatch* p);
    HRESULT get_BehaviorUrnsCollection(IDispatch* p);
    HRESULT get_BookmarkCollection(IDispatch* p);
    HRESULT get_CompatibleInfo(IDispatch* p);
    HRESULT get_CompatibleInfoCollection(IDispatch* p);
    HRESULT get_ControlRangeCollection(IDispatch* p);
    HRESULT get_CSSCurrentStyleDeclaration(IDispatch* p);
    HRESULT get_CSSRuleList(IDispatch* p);
    HRESULT get_CSSRuleStyleDeclaration(IDispatch* p);
    HRESULT get_CSSStyleDeclaration(IDispatch* p);
    HRESULT get_CSSStyleRule(IDispatch* p);
    HRESULT get_CSSStyleSheet(IDispatch* p);
    HRESULT get_DataTransfer(IDispatch* p);
    HRESULT get_DOMImplementation(IDispatch* p);
    HRESULT get_Element(IDispatch* p);
    HRESULT get_Event(IDispatch* p);
    HRESULT get_History(IDispatch* p);
    HRESULT get_HTCElementBehaviorDefaults(IDispatch* p);
    HRESULT get_HTMLAnchorElement(IDispatch* p);
    HRESULT get_HTMLAreaElement(IDispatch* p);
    HRESULT get_HTMLAreasCollection(IDispatch* p);
    HRESULT get_HTMLBaseElement(IDispatch* p);
    HRESULT get_HTMLBaseFontElement(IDispatch* p);
    HRESULT get_HTMLBGSoundElement(IDispatch* p);
    HRESULT get_HTMLBlockElement(IDispatch* p);
    HRESULT get_HTMLBodyElement(IDispatch* p);
    HRESULT get_HTMLBRElement(IDispatch* p);
    HRESULT get_HTMLButtonElement(IDispatch* p);
    HRESULT get_HTMLCollection(IDispatch* p);
    HRESULT get_HTMLCommentElement(IDispatch* p);
    HRESULT get_HTMLDDElement(IDispatch* p);
    HRESULT get_HTMLDivElement(IDispatch* p);
    HRESULT get_HTMLDocument(IDispatch* p);
    HRESULT get_HTMLDListElement(IDispatch* p);
    HRESULT get_HTMLDTElement(IDispatch* p);
    HRESULT get_HTMLEmbedElement(IDispatch* p);
    HRESULT get_HTMLFieldSetElement(IDispatch* p);
    HRESULT get_HTMLFontElement(IDispatch* p);
    HRESULT get_HTMLFormElement(IDispatch* p);
    HRESULT get_HTMLFrameElement(IDispatch* p);
    HRESULT get_HTMLFrameSetElement(IDispatch* p);
    HRESULT get_HTMLGenericElement(IDispatch* p);
    HRESULT get_HTMLHeadElement(IDispatch* p);
    HRESULT get_HTMLHeadingElement(IDispatch* p);
    HRESULT get_HTMLHRElement(IDispatch* p);
    HRESULT get_HTMLHtmlElement(IDispatch* p);
    HRESULT get_HTMLIFrameElement(IDispatch* p);
    HRESULT get_HTMLImageElement(IDispatch* p);
    HRESULT get_HTMLInputElement(IDispatch* p);
    HRESULT get_HTMLIsIndexElement(IDispatch* p);
    HRESULT get_HTMLLabelElement(IDispatch* p);
    HRESULT get_HTMLLegendElement(IDispatch* p);
    HRESULT get_HTMLLIElement(IDispatch* p);
    HRESULT get_HTMLLinkElement(IDispatch* p);
    HRESULT get_HTMLMapElement(IDispatch* p);
    HRESULT get_HTMLMarqueeElement(IDispatch* p);
    HRESULT get_HTMLMetaElement(IDispatch* p);
    HRESULT get_HTMLModelessDialog(IDispatch* p);
    HRESULT get_HTMLNamespaceInfo(IDispatch* p);
    HRESULT get_HTMLNamespaceInfoCollection(IDispatch* p);
    HRESULT get_HTMLNextIdElement(IDispatch* p);
    HRESULT get_HTMLNoShowElement(IDispatch* p);
    HRESULT get_HTMLObjectElement(IDispatch* p);
    HRESULT get_HTMLOListElement(IDispatch* p);
    HRESULT get_HTMLOptionElement(IDispatch* p);
    HRESULT get_HTMLParagraphElement(IDispatch* p);
    HRESULT get_HTMLParamElement(IDispatch* p);
    HRESULT get_HTMLPhraseElement(IDispatch* p);
    HRESULT get_HTMLPluginsCollection(IDispatch* p);
    HRESULT get_HTMLPopup(IDispatch* p);
    HRESULT get_HTMLScriptElement(IDispatch* p);
    HRESULT get_HTMLSelectElement(IDispatch* p);
    HRESULT get_HTMLSpanElement(IDispatch* p);
    HRESULT get_HTMLStyleElement(IDispatch* p);
    HRESULT get_HTMLTableCaptionElement(IDispatch* p);
    HRESULT get_HTMLTableCellElement(IDispatch* p);
    HRESULT get_HTMLTableColElement(IDispatch* p);
    HRESULT get_HTMLTableElement(IDispatch* p);
    HRESULT get_HTMLTableRowElement(IDispatch* p);
    HRESULT get_HTMLTableSectionElement(IDispatch* p);
    HRESULT get_HTMLTextAreaElement(IDispatch* p);
    HRESULT get_HTMLTextElement(IDispatch* p);
    HRESULT get_HTMLTitleElement(IDispatch* p);
    HRESULT get_HTMLUListElement(IDispatch* p);
    HRESULT get_HTMLUnknownElement(IDispatch* p);
    HRESULT get_Image(IDispatch* p);
    HRESULT get_Location(IDispatch* p);
    HRESULT get_NamedNodeMap(IDispatch* p);
    HRESULT get_Navigator(IDispatch* p);
    HRESULT get_NodeList(IDispatch* p);
    HRESULT get_Option(IDispatch* p);
    HRESULT get_Screen(IDispatch* p);
    HRESULT get_Selection(IDispatch* p);
    HRESULT get_StaticNodeList(IDispatch* p);
    HRESULT get_Storage(IDispatch* p);
    HRESULT get_StyleSheetList(IDispatch* p);
    HRESULT get_StyleSheetPage(IDispatch* p);
    HRESULT get_StyleSheetPageList(IDispatch* p);
    HRESULT get_Text(IDispatch* p);
    HRESULT get_TextRange(IDispatch* p);
    HRESULT get_TextRangeCollection(IDispatch* p);
    HRESULT get_TextRectangle(IDispatch* p);
    HRESULT get_TextRectangleList(IDispatch* p);
    HRESULT get_Window(IDispatch* p);
    HRESULT get_XDomainRequest(IDispatch* p);
    HRESULT get_XMLHttpRequest(IDispatch* p);
}

const GUID IID_IHTMLDialog = {0x3050F216, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F216, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDialog : IDispatch
{
    HRESULT put_dialogTop(VARIANT v);
    HRESULT get_dialogTop(VARIANT* p);
    HRESULT put_dialogLeft(VARIANT v);
    HRESULT get_dialogLeft(VARIANT* p);
    HRESULT put_dialogWidth(VARIANT v);
    HRESULT get_dialogWidth(VARIANT* p);
    HRESULT put_dialogHeight(VARIANT v);
    HRESULT get_dialogHeight(VARIANT* p);
    HRESULT get_dialogArguments(VARIANT* p);
    HRESULT get_menuArguments(VARIANT* p);
    HRESULT put_returnValue(VARIANT v);
    HRESULT get_returnValue(VARIANT* p);
    HRESULT close();
    HRESULT toString(BSTR* String);
}

const GUID IID_IHTMLDialog2 = {0x3050F5E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5E0, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDialog2 : IDispatch
{
    HRESULT put_status(BSTR v);
    HRESULT get_status(BSTR* p);
    HRESULT put_resizable(BSTR v);
    HRESULT get_resizable(BSTR* p);
}

const GUID IID_IHTMLDialog3 = {0x3050F388, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F388, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLDialog3 : IDispatch
{
    HRESULT put_unadorned(BSTR v);
    HRESULT get_unadorned(BSTR* p);
    HRESULT put_dialogHide(BSTR v);
    HRESULT get_dialogHide(BSTR* p);
}

const GUID IID_IHTMLModelessInit = {0x3050F5E4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5E4, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLModelessInit : IDispatch
{
    HRESULT get_parameters(VARIANT* p);
    HRESULT get_optionString(VARIANT* p);
    HRESULT get_moniker(IUnknown* p);
    HRESULT get_document(IUnknown* p);
}

const GUID IID_IHTMLPopup = {0x3050F666, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F666, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLPopup : IDispatch
{
    HRESULT show(int x, int y, int w, int h, VARIANT* pElement);
    HRESULT hide();
    HRESULT get_document(IHTMLDocument* p);
    HRESULT get_isOpen(short* p);
}

const GUID IID_DispHTMLPopup = {0x3050F589, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F589, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLPopup : IDispatch
{
}

const GUID IID_IHTMLAppBehavior = {0x3050F5CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5CA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAppBehavior : IDispatch
{
    HRESULT put_applicationName(BSTR v);
    HRESULT get_applicationName(BSTR* p);
    HRESULT put_version(BSTR v);
    HRESULT get_version(BSTR* p);
    HRESULT put_icon(BSTR v);
    HRESULT get_icon(BSTR* p);
    HRESULT put_singleInstance(BSTR v);
    HRESULT get_singleInstance(BSTR* p);
    HRESULT put_minimizeButton(BSTR v);
    HRESULT get_minimizeButton(BSTR* p);
    HRESULT put_maximizeButton(BSTR v);
    HRESULT get_maximizeButton(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_sysMenu(BSTR v);
    HRESULT get_sysMenu(BSTR* p);
    HRESULT put_caption(BSTR v);
    HRESULT get_caption(BSTR* p);
    HRESULT put_windowState(BSTR v);
    HRESULT get_windowState(BSTR* p);
    HRESULT put_showInTaskBar(BSTR v);
    HRESULT get_showInTaskBar(BSTR* p);
    HRESULT get_commandLine(BSTR* p);
}

const GUID IID_IHTMLAppBehavior2 = {0x3050F5C9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5C9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAppBehavior2 : IDispatch
{
    HRESULT put_contextMenu(BSTR v);
    HRESULT get_contextMenu(BSTR* p);
    HRESULT put_innerBorder(BSTR v);
    HRESULT get_innerBorder(BSTR* p);
    HRESULT put_scroll(BSTR v);
    HRESULT get_scroll(BSTR* p);
    HRESULT put_scrollFlat(BSTR v);
    HRESULT get_scrollFlat(BSTR* p);
    HRESULT put_selection(BSTR v);
    HRESULT get_selection(BSTR* p);
}

const GUID IID_IHTMLAppBehavior3 = {0x3050F5CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F5CD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHTMLAppBehavior3 : IDispatch
{
    HRESULT put_navigable(BSTR v);
    HRESULT get_navigable(BSTR* p);
}

const GUID IID_DispHTMLAppBehavior = {0x3050F57C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F57C, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispHTMLAppBehavior : IDispatch
{
}

const GUID IID_DispIHTMLInputButtonElement = {0x3050F51E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F51E, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispIHTMLInputButtonElement : IDispatch
{
}

const GUID IID_DispIHTMLInputTextElement = {0x3050F520, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F520, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispIHTMLInputTextElement : IDispatch
{
}

const GUID IID_DispIHTMLInputFileElement = {0x3050F542, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F542, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispIHTMLInputFileElement : IDispatch
{
}

const GUID IID_DispIHTMLOptionButtonElement = {0x3050F509, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F509, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispIHTMLOptionButtonElement : IDispatch
{
}

const GUID IID_DispIHTMLInputImage = {0x3050F51D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F51D, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface DispIHTMLInputImage : IDispatch
{
}

const GUID IID_IElementNamespace = {0x3050F671, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F671, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementNamespace : IUnknown
{
    HRESULT AddTag(BSTR bstrTagName, int lFlags);
}

const GUID IID_IElementNamespaceTable = {0x3050F670, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F670, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementNamespaceTable : IUnknown
{
    HRESULT AddNamespace(BSTR bstrNamespace, BSTR bstrUrn, int lFlags, VARIANT* pvarFactory);
}

const GUID IID_IElementNamespaceFactory = {0x3050F672, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F672, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementNamespaceFactory : IUnknown
{
    HRESULT Create(IElementNamespace pNamespace);
}

const GUID IID_IElementNamespaceFactory2 = {0x3050F805, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F805, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementNamespaceFactory2 : IElementNamespaceFactory
{
    HRESULT CreateWithImplementation(IElementNamespace pNamespace, BSTR bstrImplementation);
}

const GUID IID_IElementNamespaceFactoryCallback = {0x3050F7FD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F7FD, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementNamespaceFactoryCallback : IUnknown
{
    HRESULT Resolve(BSTR bstrNamespace, BSTR bstrTagName, BSTR bstrAttrs, IElementNamespace pNamespace);
}

const GUID IID_IElementBehaviorSiteOM2 = {0x3050F659, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F659, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorSiteOM2 : IElementBehaviorSiteOM
{
    HRESULT GetDefaults(IHTMLElementDefaults* ppDefaults);
}

const GUID IID_IElementBehaviorCategory = {0x3050F4ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4ED, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorCategory : IUnknown
{
    HRESULT GetCategory(ushort** ppchCategory);
}

const GUID IID_IElementBehaviorSiteCategory = {0x3050F4EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F4EE, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorSiteCategory : IUnknown
{
    HRESULT GetRelatedBehaviors(int lDirection, ushort* pchCategory, IEnumUnknown* ppEnumerator);
}

const GUID IID_IElementBehaviorSubmit = {0x3050F646, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F646, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorSubmit : IUnknown
{
    HRESULT GetSubmitInfo(IHTMLSubmitData pSubmitData);
    HRESULT Reset();
}

const GUID IID_IElementBehaviorFocus = {0x3050F6B6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6B6, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorFocus : IUnknown
{
    HRESULT GetFocusRect(RECT* pRect);
}

const GUID IID_IElementBehaviorLayout = {0x3050F6BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6BA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorLayout : IUnknown
{
    HRESULT GetSize(int dwFlags, SIZE sizeContent, POINT* pptTranslateBy, POINT* pptTopLeft, SIZE* psizeProposed);
    HRESULT GetLayoutInfo(int* plLayoutInfo);
    HRESULT GetPosition(int lFlags, POINT* pptTopLeft);
    HRESULT MapSize(SIZE* psizeIn, RECT* prcOut);
}

const GUID IID_IElementBehaviorLayout2 = {0x3050F846, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F846, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorLayout2 : IUnknown
{
    HRESULT GetTextDescent(int* plDescent);
}

const GUID IID_IElementBehaviorSiteLayout = {0x3050F6B7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F6B7, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorSiteLayout : IUnknown
{
    HRESULT InvalidateLayoutInfo();
    HRESULT InvalidateSize();
    HRESULT GetMediaResolution(SIZE* psizeResolution);
}

const GUID IID_IElementBehaviorSiteLayout2 = {0x3050F847, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F847, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IElementBehaviorSiteLayout2 : IUnknown
{
    HRESULT GetFontInfo(LOGFONTW* plf);
}

const GUID IID_IHostBehaviorInit = {0x3050F842, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x3050F842, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IHostBehaviorInit : IUnknown
{
    HRESULT PopulateNamespaceTable();
}

const GUID IID_ISurfacePresenter = {0x305106E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106E2, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ISurfacePresenter : IUnknown
{
    HRESULT Present(uint uBuffer, RECT* pDirty);
    HRESULT GetBuffer(uint backBufferIndex, const(Guid)* riid, void** ppBuffer);
    HRESULT IsCurrent(int* pIsCurrent);
}

const GUID IID_IViewObjectPresentSite = {0x305106E1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106E1, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IViewObjectPresentSite : IUnknown
{
    HRESULT CreateSurfacePresenter(IUnknown pDevice, uint width, uint height, uint backBufferCount, DXGI_FORMAT format, VIEW_OBJECT_ALPHA_MODE mode, ISurfacePresenter* ppQueue);
    HRESULT IsHardwareComposition(int* pIsHardwareComposition);
    HRESULT SetCompositionMode(VIEW_OBJECT_COMPOSITION_MODE mode);
}

const GUID IID_ICanvasPixelArrayData = {0x305107F9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107F9, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ICanvasPixelArrayData : IUnknown
{
    HRESULT GetBufferPointer(ubyte** ppBuffer, uint* pBufferLength);
}

const GUID IID_IViewObjectPrint = {0x305106E3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305106E3, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IViewObjectPrint : IUnknown
{
    HRESULT GetPrintBitmap(IUnknown* ppPrintBitmap);
}

const GUID IID_IViewObjectPresentNotifySite = {0x305107FA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107FA, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IViewObjectPresentNotifySite : IViewObjectPresentSite
{
    HRESULT RequestFrame();
}

const GUID IID_IViewObjectPresentNotify = {0x305107F8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x305107F8, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IViewObjectPresentNotify : IUnknown
{
    HRESULT OnPreRender();
}

const GUID IID_ITrackingProtection = {0x30510803, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510803, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface ITrackingProtection : IUnknown
{
    HRESULT EvaluateUrl(BSTR bstrUrl, int* pfAllowed);
    HRESULT GetEnabled(int* pfEnabled);
}

const GUID IID_IBFCacheable = {0x30510861, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]};
@GUID(0x30510861, 0x98B5, 0x11CF, [0xBB, 0x82, 0x00, 0xAA, 0x00, 0xBD, 0xCE, 0x0B]);
interface IBFCacheable : IUnknown
{
    HRESULT EnterBFCache();
    HRESULT ExitBFCache();
}

const GUID IID_IWebApplicationScriptEvents = {0x7C3F6998, 0x1567, 0x4BBA, [0xB5, 0x2B, 0x48, 0xD3, 0x21, 0x41, 0xD6, 0x13]};
@GUID(0x7C3F6998, 0x1567, 0x4BBA, [0xB5, 0x2B, 0x48, 0xD3, 0x21, 0x41, 0xD6, 0x13]);
interface IWebApplicationScriptEvents : IUnknown
{
    HRESULT BeforeScriptExecute(IHTMLWindow2 htmlWindow);
    HRESULT ScriptError(IHTMLWindow2 htmlWindow, IActiveScriptError scriptError, const(wchar)* url, BOOL errorHandled);
}

const GUID IID_IWebApplicationNavigationEvents = {0xC22615D2, 0xD318, 0x4DA2, [0x84, 0x22, 0x1F, 0xCA, 0xF7, 0x7B, 0x10, 0xE4]};
@GUID(0xC22615D2, 0xD318, 0x4DA2, [0x84, 0x22, 0x1F, 0xCA, 0xF7, 0x7B, 0x10, 0xE4]);
interface IWebApplicationNavigationEvents : IUnknown
{
    HRESULT BeforeNavigate(IHTMLWindow2 htmlWindow, const(wchar)* url, uint navigationFlags, const(wchar)* targetFrameName);
    HRESULT NavigateComplete(IHTMLWindow2 htmlWindow, const(wchar)* url);
    HRESULT NavigateError(IHTMLWindow2 htmlWindow, const(wchar)* url, const(wchar)* targetFrameName, uint statusCode);
    HRESULT DocumentComplete(IHTMLWindow2 htmlWindow, const(wchar)* url);
    HRESULT DownloadBegin();
    HRESULT DownloadComplete();
}

const GUID IID_IWebApplicationUIEvents = {0x5B2B3F99, 0x328C, 0x41D5, [0xA6, 0xF7, 0x74, 0x83, 0xED, 0x8E, 0x71, 0xDD]};
@GUID(0x5B2B3F99, 0x328C, 0x41D5, [0xA6, 0xF7, 0x74, 0x83, 0xED, 0x8E, 0x71, 0xDD]);
interface IWebApplicationUIEvents : IUnknown
{
    HRESULT SecurityProblem(uint securityProblem, int* result);
}

const GUID IID_IWebApplicationUpdateEvents = {0x3E59E6B7, 0xC652, 0x4DAF, [0xAD, 0x5E, 0x16, 0xFE, 0xB3, 0x50, 0xCD, 0xE3]};
@GUID(0x3E59E6B7, 0xC652, 0x4DAF, [0xAD, 0x5E, 0x16, 0xFE, 0xB3, 0x50, 0xCD, 0xE3]);
interface IWebApplicationUpdateEvents : IUnknown
{
    HRESULT OnPaint();
    HRESULT OnCssChanged();
}

const GUID IID_IWebApplicationHost = {0xCECBD2C3, 0xA3A5, 0x4749, [0x96, 0x81, 0x20, 0xE9, 0x16, 0x1C, 0x67, 0x94]};
@GUID(0xCECBD2C3, 0xA3A5, 0x4749, [0x96, 0x81, 0x20, 0xE9, 0x16, 0x1C, 0x67, 0x94]);
interface IWebApplicationHost : IUnknown
{
    HRESULT get_HWND(HWND* hwnd);
    HRESULT get_Document(IHTMLDocument2* htmlDocument);
    HRESULT Refresh();
    HRESULT Advise(const(Guid)* interfaceId, IUnknown callback, uint* cookie);
    HRESULT Unadvise(uint cookie);
}

const GUID IID_IWebApplicationActivation = {0xBCDCD0DE, 0x330E, 0x481B, [0xB8, 0x43, 0x48, 0x98, 0xA6, 0xA8, 0xEB, 0xAC]};
@GUID(0xBCDCD0DE, 0x330E, 0x481B, [0xB8, 0x43, 0x48, 0x98, 0xA6, 0xA8, 0xEB, 0xAC]);
interface IWebApplicationActivation : IUnknown
{
    HRESULT CancelPendingActivation();
}

const GUID IID_IWebApplicationAuthoringMode = {0x720AEA93, 0x1964, 0x4DB0, [0xB0, 0x05, 0x29, 0xEB, 0x9E, 0x2B, 0x18, 0xA9]};
@GUID(0x720AEA93, 0x1964, 0x4DB0, [0xB0, 0x05, 0x29, 0xEB, 0x9E, 0x2B, 0x18, 0xA9]);
interface IWebApplicationAuthoringMode : IServiceProvider
{
    HRESULT get_AuthoringClientBinary(BSTR* designModeDllPath);
}

alias RegisterAuthoringClientFunctionType = extern(Windows) HRESULT function(IWebApplicationAuthoringMode authoringModeObject, IWebApplicationHost host);
alias UnregisterAuthoringClientFunctionType = extern(Windows) HRESULT function(IWebApplicationHost host);
