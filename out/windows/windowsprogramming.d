module windows.windowsprogramming;

public import system;
public import windows.automation;
public import windows.com;
public import windows.coreaudio;
public import windows.debug;
public import windows.direct2d;
public import windows.directdraw;
public import windows.directshow;
public import windows.displaydevices;
public import windows.gdi;
public import windows.kernel;
public import windows.rpc;
public import windows.security;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

enum PROCESS_CREATION_FLAGS
{
    DEBUG_PROCESS = 1,
    DEBUG_ONLY_THIS_PROCESS = 2,
    CREATE_SUSPENDED = 4,
    DETACHED_PROCESS = 8,
    CREATE_NEW_CONSOLE = 16,
    NORMAL_PRIORITY_CLASS = 32,
    IDLE_PRIORITY_CLASS = 64,
    HIGH_PRIORITY_CLASS = 128,
    REALTIME_PRIORITY_CLASS = 256,
    CREATE_NEW_PROCESS_GROUP = 512,
    CREATE_UNICODE_ENVIRONMENT = 1024,
    CREATE_SEPARATE_WOW_VDM = 2048,
    CREATE_SHARED_WOW_VDM = 4096,
    CREATE_FORCEDOS = 8192,
    BELOW_NORMAL_PRIORITY_CLASS = 16384,
    ABOVE_NORMAL_PRIORITY_CLASS = 32768,
    INHERIT_PARENT_AFFINITY = 65536,
    INHERIT_CALLER_PRIORITY = 131072,
    CREATE_PROTECTED_PROCESS = 262144,
    EXTENDED_STARTUPINFO_PRESENT = 524288,
    PROCESS_MODE_BACKGROUND_BEGIN = 1048576,
    PROCESS_MODE_BACKGROUND_END = 2097152,
    CREATE_SECURE_PROCESS = 4194304,
    CREATE_BREAKAWAY_FROM_JOB = 16777216,
    CREATE_PRESERVE_CODE_AUTHZ_LEVEL = 33554432,
    CREATE_DEFAULT_ERROR_MODE = 67108864,
    CREATE_NO_WINDOW = 134217728,
    PROFILE_USER = 268435456,
    PROFILE_KERNEL = 536870912,
    PROFILE_SERVER = 1073741824,
    CREATE_IGNORE_SYSTEM_DEFAULT = 2147483648,
}

enum HANDLE_FLAG_OPTIONS
{
    HANDLE_FLAG_INHERIT = 1,
    HANDLE_FLAG_PROTECT_FROM_CLOSE = 2,
}

enum DUPLICATE_HANDLE_OPTIONS
{
    DUPLICATE_CLOSE_SOURCE = 1,
    DUPLICATE_SAME_ACCESS = 2,
}

enum STD_HANDLE_TYPE
{
    STD_INPUT_HANDLE = 4294967286,
    STD_OUTPUT_HANDLE = 4294967285,
    STD_ERROR_HANDLE = 4294967284,
}

enum VER_FLAGS
{
    VER_MINORVERSION = 1,
    VER_MAJORVERSION = 2,
    VER_BUILDNUMBER = 4,
    VER_PLATFORMID = 8,
    VER_SERVICEPACKMINOR = 16,
    VER_SERVICEPACKMAJOR = 32,
    VER_SUITENAME = 64,
    VER_PRODUCT_TYPE = 128,
}

enum ProcessAccessRights
{
    Terminate = 1,
    CreateThread = 2,
    SetSessionid = 4,
    VmOperation = 8,
    VmRead = 16,
    VmWrite = 32,
    DupHandle = 64,
    CreateProcess = 128,
    SetQuota = 256,
    SetInformation = 512,
    QueryInformation = 1024,
    SuspendResume = 2048,
    QueryLimitedInformation = 4096,
    SetLimitedInformation = 8192,
    AllAccess = 2097151,
    Delete = 65536,
    ReadControl = 131072,
    WriteDac = 262144,
    WriteOwner = 524288,
    Synchronize = 1048576,
    StandardRightsRequired = 983040,
}

struct NETLOGON_INFO_1
{
    uint netlog1_flags;
    uint netlog1_pdc_connection_status;
}

struct NETLOGON_INFO_2
{
    uint netlog2_flags;
    uint netlog2_pdc_connection_status;
    const(wchar)* netlog2_trusted_dc_name;
    uint netlog2_tc_connection_status;
}

struct NETLOGON_INFO_3
{
    uint netlog3_flags;
    uint netlog3_logon_attempts;
    uint netlog3_reserved1;
    uint netlog3_reserved2;
    uint netlog3_reserved3;
    uint netlog3_reserved4;
    uint netlog3_reserved5;
}

struct NETLOGON_INFO_4
{
    const(wchar)* netlog4_trusted_dc_name;
    const(wchar)* netlog4_trusted_domain_name;
}

@DllImport("NETAPI32.dll")
uint I_NetLogonControl2(const(wchar)* ServerName, uint FunctionCode, uint QueryLevel, char* Data, ubyte** Buffer);

@DllImport("KERNEL32.dll")
void RtlRaiseException(EXCEPTION_RECORD* ExceptionRecord);

@DllImport("loadperf.dll")
uint InstallPerfDllW(const(wchar)* szComputerName, const(wchar)* lpIniFile, uint dwFlags);

@DllImport("loadperf.dll")
uint InstallPerfDllA(const(char)* szComputerName, const(char)* lpIniFile, uint dwFlags);

@DllImport("USER32.dll")
void DisableProcessWindowsGhosting();

@DllImport("KERNEL32.dll")
int CompareFileTime(const(FILETIME)* lpFileTime1, const(FILETIME)* lpFileTime2);

@DllImport("KERNEL32.dll")
BOOL FileTimeToLocalFileTime(const(FILETIME)* lpFileTime, FILETIME* lpLocalFileTime);

@DllImport("KERNEL32.dll")
BOOL GetFileTime(HANDLE hFile, FILETIME* lpCreationTime, FILETIME* lpLastAccessTime, FILETIME* lpLastWriteTime);

@DllImport("KERNEL32.dll")
BOOL LocalFileTimeToFileTime(const(FILETIME)* lpLocalFileTime, FILETIME* lpFileTime);

@DllImport("KERNEL32.dll")
BOOL SetFileTime(HANDLE hFile, const(FILETIME)* lpCreationTime, const(FILETIME)* lpLastAccessTime, const(FILETIME)* lpLastWriteTime);

@DllImport("KERNEL32.dll")
uint GetSystemWow64DirectoryA(const(char)* lpBuffer, uint uSize);

@DllImport("KERNEL32.dll")
uint GetSystemWow64DirectoryW(const(wchar)* lpBuffer, uint uSize);

@DllImport("api-ms-win-core-wow64-l1-1-1.dll")
uint GetSystemWow64Directory2A(const(char)* lpBuffer, uint uSize, ushort ImageFileMachineType);

@DllImport("api-ms-win-core-wow64-l1-1-1.dll")
uint GetSystemWow64Directory2W(const(wchar)* lpBuffer, uint uSize, ushort ImageFileMachineType);

@DllImport("KERNEL32.dll")
HRESULT IsWow64GuestMachineSupported(ushort WowGuestMachine, int* MachineIsSupported);

@DllImport("RPCRT4.dll")
ubyte* NdrSimpleStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrComplexStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrComplexArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrSimpleStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrComplexStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrComplexArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrUserMarshalUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
void NdrSimpleStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrComplexStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrComplexArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("SspiCli.dll")
ubyte GetUserNameExA(EXTENDED_NAME_FORMAT NameFormat, const(char)* lpNameBuffer, uint* nSize);

@DllImport("SspiCli.dll")
ubyte GetUserNameExW(EXTENDED_NAME_FORMAT NameFormat, const(wchar)* lpNameBuffer, uint* nSize);

@DllImport("SECUR32.dll")
ubyte GetComputerObjectNameA(EXTENDED_NAME_FORMAT NameFormat, const(char)* lpNameBuffer, uint* nSize);

@DllImport("SECUR32.dll")
ubyte GetComputerObjectNameW(EXTENDED_NAME_FORMAT NameFormat, const(wchar)* lpNameBuffer, uint* nSize);

@DllImport("SECUR32.dll")
ubyte TranslateNameA(const(char)* lpAccountName, EXTENDED_NAME_FORMAT AccountNameFormat, EXTENDED_NAME_FORMAT DesiredNameFormat, const(char)* lpTranslatedName, uint* nSize);

@DllImport("SECUR32.dll")
ubyte TranslateNameW(const(wchar)* lpAccountName, EXTENDED_NAME_FORMAT AccountNameFormat, EXTENDED_NAME_FORMAT DesiredNameFormat, const(wchar)* lpTranslatedName, uint* nSize);

@DllImport("api-ms-win-core-apiquery-l2-1-0.dll")
BOOL IsApiSetImplemented(const(char)* Contract);

@DllImport("KERNEL32.dll")
BOOL SetEnvironmentStringsW(const(wchar)* NewEnvironment);

@DllImport("KERNEL32.dll")
HANDLE GetStdHandle(STD_HANDLE_TYPE nStdHandle);

@DllImport("KERNEL32.dll")
BOOL SetStdHandle(STD_HANDLE_TYPE nStdHandle, HANDLE hHandle);

@DllImport("KERNEL32.dll")
BOOL SetStdHandleEx(STD_HANDLE_TYPE nStdHandle, HANDLE hHandle, int* phPrevValue);

@DllImport("KERNEL32.dll")
uint ExpandEnvironmentStringsA(const(char)* lpSrc, const(char)* lpDst, uint nSize);

@DllImport("KERNEL32.dll")
uint ExpandEnvironmentStringsW(const(wchar)* lpSrc, const(wchar)* lpDst, uint nSize);

@DllImport("KERNEL32.dll")
BOOL SetCurrentDirectoryA(const(char)* lpPathName);

@DllImport("KERNEL32.dll")
BOOL SetCurrentDirectoryW(const(wchar)* lpPathName);

@DllImport("KERNEL32.dll")
uint GetCurrentDirectoryA(uint nBufferLength, const(char)* lpBuffer);

@DllImport("KERNEL32.dll")
uint GetCurrentDirectoryW(uint nBufferLength, const(wchar)* lpBuffer);

@DllImport("KERNEL32.dll")
BOOL CloseHandle(HANDLE hObject);

@DllImport("KERNEL32.dll")
BOOL DuplicateHandle(HANDLE hSourceProcessHandle, HANDLE hSourceHandle, HANDLE hTargetProcessHandle, int* lpTargetHandle, uint dwDesiredAccess, BOOL bInheritHandle, DUPLICATE_HANDLE_OPTIONS dwOptions);

@DllImport("api-ms-win-core-handle-l1-1-0.dll")
BOOL CompareObjectHandles(HANDLE hFirstObjectHandle, HANDLE hSecondObjectHandle);

@DllImport("KERNEL32.dll")
BOOL GetHandleInformation(HANDLE hObject, uint* lpdwFlags);

@DllImport("KERNEL32.dll")
BOOL SetHandleInformation(HANDLE hObject, uint dwMask, HANDLE_FLAG_OPTIONS dwFlags);

@DllImport("KERNEL32.dll")
BOOL QueryPerformanceCounter(LARGE_INTEGER* lpPerformanceCount);

@DllImport("KERNEL32.dll")
BOOL QueryPerformanceFrequency(LARGE_INTEGER* lpFrequency);

@DllImport("KERNEL32.dll")
BOOL SetProcessDynamicEHContinuationTargets(HANDLE Process, ushort NumberOfTargets, char* Targets);

@DllImport("KERNEL32.dll")
BOOL IsProcessorFeaturePresent(uint ProcessorFeature);

@DllImport("KERNEL32.dll")
BOOL GetSystemTimes(FILETIME* lpIdleTime, FILETIME* lpKernelTime, FILETIME* lpUserTime);

@DllImport("KERNEL32.dll")
BOOL GetSystemCpuSetInformation(char* Information, uint BufferLength, uint* ReturnedLength, HANDLE Process, uint Flags);

@DllImport("KERNEL32.dll")
BOOL GetProcessDefaultCpuSets(HANDLE Process, char* CpuSetIds, uint CpuSetIdCount, uint* RequiredIdCount);

@DllImport("KERNEL32.dll")
BOOL SetProcessDefaultCpuSets(HANDLE Process, char* CpuSetIds, uint CpuSetIdCount);

@DllImport("KERNEL32.dll")
BOOL GetThreadSelectedCpuSets(HANDLE Thread, char* CpuSetIds, uint CpuSetIdCount, uint* RequiredIdCount);

@DllImport("KERNEL32.dll")
BOOL SetThreadSelectedCpuSets(HANDLE Thread, char* CpuSetIds, uint CpuSetIdCount);

@DllImport("KERNEL32.dll")
void GetSystemInfo(SYSTEM_INFO* lpSystemInfo);

@DllImport("KERNEL32.dll")
void GetSystemTime(SYSTEMTIME* lpSystemTime);

@DllImport("KERNEL32.dll")
void GetSystemTimeAsFileTime(FILETIME* lpSystemTimeAsFileTime);

@DllImport("KERNEL32.dll")
void GetLocalTime(SYSTEMTIME* lpSystemTime);

@DllImport("KERNEL32.dll")
BOOL IsUserCetAvailableInEnvironment(uint UserCetEnvironment);

@DllImport("KERNEL32.dll")
BOOL GetSystemLeapSecondInformation(int* Enabled, uint* Flags);

@DllImport("KERNEL32.dll")
uint GetVersion();

@DllImport("KERNEL32.dll")
BOOL SetLocalTime(const(SYSTEMTIME)* lpSystemTime);

@DllImport("KERNEL32.dll")
uint GetTickCount();

@DllImport("KERNEL32.dll")
ulong GetTickCount64();

@DllImport("KERNEL32.dll")
BOOL GetSystemTimeAdjustment(uint* lpTimeAdjustment, uint* lpTimeIncrement, int* lpTimeAdjustmentDisabled);

@DllImport("api-ms-win-core-sysinfo-l1-2-4.dll")
BOOL GetSystemTimeAdjustmentPrecise(ulong* lpTimeAdjustment, ulong* lpTimeIncrement, int* lpTimeAdjustmentDisabled);

@DllImport("KERNEL32.dll")
uint GetSystemDirectoryA(const(char)* lpBuffer, uint uSize);

@DllImport("KERNEL32.dll")
uint GetSystemDirectoryW(const(wchar)* lpBuffer, uint uSize);

@DllImport("KERNEL32.dll")
uint GetWindowsDirectoryA(const(char)* lpBuffer, uint uSize);

@DllImport("KERNEL32.dll")
uint GetWindowsDirectoryW(const(wchar)* lpBuffer, uint uSize);

@DllImport("KERNEL32.dll")
uint GetSystemWindowsDirectoryA(const(char)* lpBuffer, uint uSize);

@DllImport("KERNEL32.dll")
uint GetSystemWindowsDirectoryW(const(wchar)* lpBuffer, uint uSize);

@DllImport("KERNEL32.dll")
BOOL GetComputerNameExA(COMPUTER_NAME_FORMAT NameType, const(char)* lpBuffer, uint* nSize);

@DllImport("KERNEL32.dll")
BOOL GetComputerNameExW(COMPUTER_NAME_FORMAT NameType, const(wchar)* lpBuffer, uint* nSize);

@DllImport("KERNEL32.dll")
BOOL SetComputerNameExW(COMPUTER_NAME_FORMAT NameType, const(wchar)* lpBuffer);

@DllImport("KERNEL32.dll")
BOOL SetSystemTime(const(SYSTEMTIME)* lpSystemTime);

@DllImport("KERNEL32.dll")
BOOL GetVersionExA(OSVERSIONINFOA* lpVersionInformation);

@DllImport("KERNEL32.dll")
BOOL GetVersionExW(OSVERSIONINFOW* lpVersionInformation);

@DllImport("KERNEL32.dll")
void GetNativeSystemInfo(SYSTEM_INFO* lpSystemInfo);

@DllImport("KERNEL32.dll")
void GetSystemTimePreciseAsFileTime(FILETIME* lpSystemTimeAsFileTime);

@DllImport("KERNEL32.dll")
BOOL GetProductInfo(uint dwOSMajorVersion, uint dwOSMinorVersion, uint dwSpMajorVersion, uint dwSpMinorVersion, uint* pdwReturnedProductType);

@DllImport("KERNEL32.dll")
ulong VerSetConditionMask(ulong ConditionMask, uint TypeMask, ubyte Condition);

@DllImport("api-ms-win-core-sysinfo-l1-2-0.dll")
BOOL GetOsSafeBootMode(uint* Flags);

@DllImport("KERNEL32.dll")
uint EnumSystemFirmwareTables(uint FirmwareTableProviderSignature, char* pFirmwareTableEnumBuffer, uint BufferSize);

@DllImport("KERNEL32.dll")
uint GetSystemFirmwareTable(uint FirmwareTableProviderSignature, uint FirmwareTableID, char* pFirmwareTableBuffer, uint BufferSize);

@DllImport("KERNEL32.dll")
BOOL DnsHostnameToComputerNameExW(const(wchar)* Hostname, const(wchar)* ComputerName, uint* nSize);

@DllImport("KERNEL32.dll")
BOOL SetComputerNameEx2W(COMPUTER_NAME_FORMAT NameType, uint Flags, const(wchar)* lpBuffer);

@DllImport("KERNEL32.dll")
BOOL SetSystemTimeAdjustment(uint dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);

@DllImport("api-ms-win-core-sysinfo-l1-2-4.dll")
BOOL SetSystemTimeAdjustmentPrecise(ulong dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);

@DllImport("api-ms-win-core-sysinfo-l1-2-3.dll")
BOOL GetOsManufacturingMode(int* pbEnabled);

@DllImport("api-ms-win-core-sysinfo-l1-2-3.dll")
HRESULT GetIntegratedDisplaySize(double* sizeInInches);

@DllImport("KERNEL32.dll")
BOOL SetComputerNameA(const(char)* lpComputerName);

@DllImport("KERNEL32.dll")
BOOL SetComputerNameW(const(wchar)* lpComputerName);

@DllImport("KERNEL32.dll")
BOOL SetComputerNameExA(COMPUTER_NAME_FORMAT NameType, const(char)* lpBuffer);

@DllImport("api-ms-win-core-realtime-l1-1-1.dll")
void QueryInterruptTimePrecise(ulong* lpInterruptTimePrecise);

@DllImport("api-ms-win-core-realtime-l1-1-1.dll")
void QueryUnbiasedInterruptTimePrecise(ulong* lpUnbiasedInterruptTimePrecise);

@DllImport("api-ms-win-core-realtime-l1-1-1.dll")
void QueryInterruptTime(ulong* lpInterruptTime);

@DllImport("KERNEL32.dll")
BOOL QueryUnbiasedInterruptTime(ulong* UnbiasedTime);

@DllImport("api-ms-win-core-realtime-l1-1-2.dll")
HRESULT QueryAuxiliaryCounterFrequency(ulong* lpAuxiliaryCounterFrequency);

@DllImport("api-ms-win-core-realtime-l1-1-2.dll")
HRESULT ConvertAuxiliaryCounterToPerformanceCounter(ulong ullAuxiliaryCounterValue, ulong* lpPerformanceCounterValue, ulong* lpConversionError);

@DllImport("api-ms-win-core-realtime-l1-1-2.dll")
HRESULT ConvertPerformanceCounterToAuxiliaryCounter(ulong ullPerformanceCounterValue, ulong* lpAuxiliaryCounterValue, ulong* lpConversionError);

@DllImport("KERNEL32.dll")
uint GlobalCompact(uint dwMinFree);

@DllImport("KERNEL32.dll")
void GlobalFix(int hMem);

@DllImport("KERNEL32.dll")
void GlobalUnfix(int hMem);

@DllImport("KERNEL32.dll")
void* GlobalWire(int hMem);

@DllImport("KERNEL32.dll")
BOOL GlobalUnWire(int hMem);

@DllImport("KERNEL32.dll")
uint LocalShrink(int hMem, uint cbNewSize);

@DllImport("KERNEL32.dll")
uint LocalCompact(uint uMinFree);

@DllImport("KERNEL32.dll")
BOOL SetEnvironmentStringsA(const(char)* NewEnvironment);

@DllImport("KERNEL32.dll")
uint SetHandleCount(uint uNumber);

@DllImport("KERNEL32.dll")
BOOL RequestDeviceWakeup(HANDLE hDevice);

@DllImport("KERNEL32.dll")
BOOL CancelDeviceWakeupRequest(HANDLE hDevice);

@DllImport("KERNEL32.dll")
BOOL SetMessageWaitingIndicator(HANDLE hMsgIndicator, uint ulMsgCount);

@DllImport("KERNEL32.dll")
int MulDiv(int nNumber, int nNumerator, int nDenominator);

@DllImport("KERNEL32.dll")
BOOL GetSystemRegistryQuota(uint* pdwQuotaAllowed, uint* pdwQuotaUsed);

@DllImport("KERNEL32.dll")
BOOL FileTimeToDosDateTime(const(FILETIME)* lpFileTime, ushort* lpFatDate, ushort* lpFatTime);

@DllImport("KERNEL32.dll")
BOOL DosDateTimeToFileTime(ushort wFatDate, ushort wFatTime, FILETIME* lpFileTime);

@DllImport("KERNEL32.dll")
int _lopen(const(char)* lpPathName, int iReadWrite);

@DllImport("KERNEL32.dll")
int _lcreat(const(char)* lpPathName, int iAttribute);

@DllImport("KERNEL32.dll")
uint _lread(int hFile, char* lpBuffer, uint uBytes);

@DllImport("KERNEL32.dll")
uint _lwrite(int hFile, const(char)* lpBuffer, uint uBytes);

@DllImport("KERNEL32.dll")
int _hread(int hFile, char* lpBuffer, int lBytes);

@DllImport("KERNEL32.dll")
int _hwrite(int hFile, const(char)* lpBuffer, int lBytes);

@DllImport("KERNEL32.dll")
int _lclose(int hFile);

@DllImport("KERNEL32.dll")
int _llseek(int hFile, int lOffset, int iOrigin);

@DllImport("KERNEL32.dll")
HANDLE OpenMutexA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpName);

@DllImport("KERNEL32.dll")
HANDLE OpenSemaphoreA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpName);

@DllImport("KERNEL32.dll")
HANDLE CreateWaitableTimerA(SECURITY_ATTRIBUTES* lpTimerAttributes, BOOL bManualReset, const(char)* lpTimerName);

@DllImport("KERNEL32.dll")
HANDLE OpenWaitableTimerA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpTimerName);

@DllImport("KERNEL32.dll")
HANDLE CreateWaitableTimerExA(SECURITY_ATTRIBUTES* lpTimerAttributes, const(char)* lpTimerName, uint dwFlags, uint dwDesiredAccess);

@DllImport("KERNEL32.dll")
void GetStartupInfoA(STARTUPINFOA* lpStartupInfo);

@DllImport("KERNEL32.dll")
uint GetFirmwareEnvironmentVariableA(const(char)* lpName, const(char)* lpGuid, char* pBuffer, uint nSize);

@DllImport("KERNEL32.dll")
uint GetFirmwareEnvironmentVariableW(const(wchar)* lpName, const(wchar)* lpGuid, char* pBuffer, uint nSize);

@DllImport("KERNEL32.dll")
uint GetFirmwareEnvironmentVariableExA(const(char)* lpName, const(char)* lpGuid, char* pBuffer, uint nSize, uint* pdwAttribubutes);

@DllImport("KERNEL32.dll")
uint GetFirmwareEnvironmentVariableExW(const(wchar)* lpName, const(wchar)* lpGuid, char* pBuffer, uint nSize, uint* pdwAttribubutes);

@DllImport("KERNEL32.dll")
BOOL SetFirmwareEnvironmentVariableA(const(char)* lpName, const(char)* lpGuid, char* pValue, uint nSize);

@DllImport("KERNEL32.dll")
BOOL SetFirmwareEnvironmentVariableW(const(wchar)* lpName, const(wchar)* lpGuid, char* pValue, uint nSize);

@DllImport("KERNEL32.dll")
BOOL SetFirmwareEnvironmentVariableExA(const(char)* lpName, const(char)* lpGuid, char* pValue, uint nSize, uint dwAttributes);

@DllImport("KERNEL32.dll")
BOOL SetFirmwareEnvironmentVariableExW(const(wchar)* lpName, const(wchar)* lpGuid, char* pValue, uint nSize, uint dwAttributes);

@DllImport("KERNEL32.dll")
BOOL GetFirmwareType(FIRMWARE_TYPE* FirmwareType);

@DllImport("KERNEL32.dll")
BOOL IsNativeVhdBoot(int* NativeVhdBoot);

@DllImport("KERNEL32.dll")
uint GetProfileIntA(const(char)* lpAppName, const(char)* lpKeyName, int nDefault);

@DllImport("KERNEL32.dll")
uint GetProfileIntW(const(wchar)* lpAppName, const(wchar)* lpKeyName, int nDefault);

@DllImport("KERNEL32.dll")
uint GetProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpDefault, const(char)* lpReturnedString, uint nSize);

@DllImport("KERNEL32.dll")
uint GetProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpDefault, const(wchar)* lpReturnedString, uint nSize);

@DllImport("KERNEL32.dll")
BOOL WriteProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpString);

@DllImport("KERNEL32.dll")
BOOL WriteProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpString);

@DllImport("KERNEL32.dll")
uint GetProfileSectionA(const(char)* lpAppName, const(char)* lpReturnedString, uint nSize);

@DllImport("KERNEL32.dll")
uint GetProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpReturnedString, uint nSize);

@DllImport("KERNEL32.dll")
BOOL WriteProfileSectionA(const(char)* lpAppName, const(char)* lpString);

@DllImport("KERNEL32.dll")
BOOL WriteProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpString);

@DllImport("KERNEL32.dll")
uint GetPrivateProfileIntA(const(char)* lpAppName, const(char)* lpKeyName, int nDefault, const(char)* lpFileName);

@DllImport("KERNEL32.dll")
uint GetPrivateProfileIntW(const(wchar)* lpAppName, const(wchar)* lpKeyName, int nDefault, const(wchar)* lpFileName);

@DllImport("KERNEL32.dll")
uint GetPrivateProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpDefault, const(char)* lpReturnedString, uint nSize, const(char)* lpFileName);

@DllImport("KERNEL32.dll")
uint GetPrivateProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpDefault, const(wchar)* lpReturnedString, uint nSize, const(wchar)* lpFileName);

@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpString, const(char)* lpFileName);

@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpString, const(wchar)* lpFileName);

@DllImport("KERNEL32.dll")
uint GetPrivateProfileSectionA(const(char)* lpAppName, const(char)* lpReturnedString, uint nSize, const(char)* lpFileName);

@DllImport("KERNEL32.dll")
uint GetPrivateProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpReturnedString, uint nSize, const(wchar)* lpFileName);

@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileSectionA(const(char)* lpAppName, const(char)* lpString, const(char)* lpFileName);

@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpString, const(wchar)* lpFileName);

@DllImport("KERNEL32.dll")
uint GetPrivateProfileSectionNamesA(const(char)* lpszReturnBuffer, uint nSize, const(char)* lpFileName);

@DllImport("KERNEL32.dll")
uint GetPrivateProfileSectionNamesW(const(wchar)* lpszReturnBuffer, uint nSize, const(wchar)* lpFileName);

@DllImport("KERNEL32.dll")
BOOL GetPrivateProfileStructA(const(char)* lpszSection, const(char)* lpszKey, char* lpStruct, uint uSizeStruct, const(char)* szFile);

@DllImport("KERNEL32.dll")
BOOL GetPrivateProfileStructW(const(wchar)* lpszSection, const(wchar)* lpszKey, char* lpStruct, uint uSizeStruct, const(wchar)* szFile);

@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileStructA(const(char)* lpszSection, const(char)* lpszKey, char* lpStruct, uint uSizeStruct, const(char)* szFile);

@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileStructW(const(wchar)* lpszSection, const(wchar)* lpszKey, char* lpStruct, uint uSizeStruct, const(wchar)* szFile);

@DllImport("KERNEL32.dll")
BOOL IsBadHugeReadPtr(const(void)* lp, uint ucb);

@DllImport("KERNEL32.dll")
BOOL IsBadHugeWritePtr(void* lp, uint ucb);

@DllImport("KERNEL32.dll")
BOOL GetComputerNameA(const(char)* lpBuffer, uint* nSize);

@DllImport("KERNEL32.dll")
BOOL GetComputerNameW(const(wchar)* lpBuffer, uint* nSize);

@DllImport("KERNEL32.dll")
BOOL DnsHostnameToComputerNameA(const(char)* Hostname, const(char)* ComputerName, uint* nSize);

@DllImport("KERNEL32.dll")
BOOL DnsHostnameToComputerNameW(const(wchar)* Hostname, const(wchar)* ComputerName, uint* nSize);

@DllImport("ADVAPI32.dll")
BOOL GetUserNameA(const(char)* lpBuffer, uint* pcbBuffer);

@DllImport("ADVAPI32.dll")
BOOL GetUserNameW(const(wchar)* lpBuffer, uint* pcbBuffer);

@DllImport("ADVAPI32.dll")
BOOL IsTokenUntrusted(HANDLE TokenHandle);

@DllImport("KERNEL32.dll")
HANDLE SetTimerQueueTimer(HANDLE TimerQueue, WAITORTIMERCALLBACK Callback, void* Parameter, uint DueTime, uint Period, BOOL PreferIo);

@DllImport("KERNEL32.dll")
BOOL CancelTimerQueueTimer(HANDLE TimerQueue, HANDLE Timer);

@DllImport("ADVAPI32.dll")
BOOL GetCurrentHwProfileA(HW_PROFILE_INFOA* lpHwProfileInfo);

@DllImport("ADVAPI32.dll")
BOOL GetCurrentHwProfileW(HW_PROFILE_INFOW* lpHwProfileInfo);

@DllImport("KERNEL32.dll")
BOOL VerifyVersionInfoA(OSVERSIONINFOEXA* lpVersionInformation, uint dwTypeMask, ulong dwlConditionMask);

@DllImport("KERNEL32.dll")
BOOL VerifyVersionInfoW(OSVERSIONINFOEXW* lpVersionInformation, uint dwTypeMask, ulong dwlConditionMask);

@DllImport("KERNEL32.dll")
BOOL SystemTimeToTzSpecificLocalTime(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation, const(SYSTEMTIME)* lpUniversalTime, SYSTEMTIME* lpLocalTime);

@DllImport("KERNEL32.dll")
BOOL TzSpecificLocalTimeToSystemTime(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation, const(SYSTEMTIME)* lpLocalTime, SYSTEMTIME* lpUniversalTime);

@DllImport("KERNEL32.dll")
BOOL FileTimeToSystemTime(const(FILETIME)* lpFileTime, SYSTEMTIME* lpSystemTime);

@DllImport("KERNEL32.dll")
BOOL SystemTimeToFileTime(const(SYSTEMTIME)* lpSystemTime, FILETIME* lpFileTime);

@DllImport("KERNEL32.dll")
uint GetTimeZoneInformation(TIME_ZONE_INFORMATION* lpTimeZoneInformation);

@DllImport("KERNEL32.dll")
BOOL SetTimeZoneInformation(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation);

@DllImport("KERNEL32.dll")
BOOL SetDynamicTimeZoneInformation(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation);

@DllImport("KERNEL32.dll")
uint GetDynamicTimeZoneInformation(DYNAMIC_TIME_ZONE_INFORMATION* pTimeZoneInformation);

@DllImport("KERNEL32.dll")
BOOL GetTimeZoneInformationForYear(ushort wYear, DYNAMIC_TIME_ZONE_INFORMATION* pdtzi, TIME_ZONE_INFORMATION* ptzi);

@DllImport("ADVAPI32.dll")
uint EnumDynamicTimeZoneInformation(const(uint) dwIndex, DYNAMIC_TIME_ZONE_INFORMATION* lpTimeZoneInformation);

@DllImport("ADVAPI32.dll")
uint GetDynamicTimeZoneInformationEffectiveYears(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, uint* FirstYear, uint* LastYear);

@DllImport("KERNEL32.dll")
BOOL SystemTimeToTzSpecificLocalTimeEx(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, const(SYSTEMTIME)* lpUniversalTime, SYSTEMTIME* lpLocalTime);

@DllImport("KERNEL32.dll")
BOOL TzSpecificLocalTimeToSystemTimeEx(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, const(SYSTEMTIME)* lpLocalTime, SYSTEMTIME* lpUniversalTime);

@DllImport("KERNEL32.dll")
BOOL LocalFileTimeToLocalSystemTime(const(TIME_ZONE_INFORMATION)* timeZoneInformation, const(FILETIME)* localFileTime, SYSTEMTIME* localSystemTime);

@DllImport("KERNEL32.dll")
BOOL LocalSystemTimeToLocalFileTime(const(TIME_ZONE_INFORMATION)* timeZoneInformation, const(SYSTEMTIME)* localSystemTime, FILETIME* localFileTime);

@DllImport("KERNEL32.dll")
BOOL CreateJobSet(uint NumJob, char* UserJobSet, uint Flags);

@DllImport("KERNEL32.dll")
BOOL ReplacePartitionUnit(const(wchar)* TargetPartition, const(wchar)* SparePartition, uint Flags);

@DllImport("KERNEL32.dll")
BOOL InitializeContext2(char* Buffer, uint ContextFlags, CONTEXT** Context, uint* ContextLength, ulong XStateCompactionMask);

@DllImport("api-ms-win-core-backgroundtask-l1-1-0.dll")
uint RaiseCustomSystemEventTrigger(CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG* CustomSystemEventTriggerConfig);

@DllImport("ADVAPI32.dll")
LSTATUS RegCloseKey(HKEY hKey);

@DllImport("ADVAPI32.dll")
LSTATUS RegOverridePredefKey(HKEY hKey, HKEY hNewHKey);

@DllImport("ADVAPI32.dll")
LSTATUS RegOpenUserClassesRoot(HANDLE hToken, uint dwOptions, uint samDesired, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegOpenCurrentUser(uint samDesired, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegDisablePredefinedCache();

@DllImport("ADVAPI32.dll")
LSTATUS RegDisablePredefinedCacheEx();

@DllImport("ADVAPI32.dll")
LSTATUS RegConnectRegistryA(const(char)* lpMachineName, HKEY hKey, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegConnectRegistryW(const(wchar)* lpMachineName, HKEY hKey, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegConnectRegistryExA(const(char)* lpMachineName, HKEY hKey, uint Flags, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegConnectRegistryExW(const(wchar)* lpMachineName, HKEY hKey, uint Flags, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegCreateKeyA(HKEY hKey, const(char)* lpSubKey, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegCreateKeyW(HKEY hKey, const(wchar)* lpSubKey, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegCreateKeyExA(HKEY hKey, const(char)* lpSubKey, uint Reserved, const(char)* lpClass, uint dwOptions, uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition);

@DllImport("ADVAPI32.dll")
LSTATUS RegCreateKeyExW(HKEY hKey, const(wchar)* lpSubKey, uint Reserved, const(wchar)* lpClass, uint dwOptions, uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition);

@DllImport("ADVAPI32.dll")
LSTATUS RegCreateKeyTransactedA(HKEY hKey, const(char)* lpSubKey, uint Reserved, const(char)* lpClass, uint dwOptions, uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition, HANDLE hTransaction, void* pExtendedParemeter);

@DllImport("ADVAPI32.dll")
LSTATUS RegCreateKeyTransactedW(HKEY hKey, const(wchar)* lpSubKey, uint Reserved, const(wchar)* lpClass, uint dwOptions, uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition, HANDLE hTransaction, void* pExtendedParemeter);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteKeyA(HKEY hKey, const(char)* lpSubKey);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteKeyW(HKEY hKey, const(wchar)* lpSubKey);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteKeyExA(HKEY hKey, const(char)* lpSubKey, uint samDesired, uint Reserved);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteKeyExW(HKEY hKey, const(wchar)* lpSubKey, uint samDesired, uint Reserved);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteKeyTransactedA(HKEY hKey, const(char)* lpSubKey, uint samDesired, uint Reserved, HANDLE hTransaction, void* pExtendedParameter);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteKeyTransactedW(HKEY hKey, const(wchar)* lpSubKey, uint samDesired, uint Reserved, HANDLE hTransaction, void* pExtendedParameter);

@DllImport("ADVAPI32.dll")
int RegDisableReflectionKey(HKEY hBase);

@DllImport("ADVAPI32.dll")
int RegEnableReflectionKey(HKEY hBase);

@DllImport("ADVAPI32.dll")
int RegQueryReflectionKey(HKEY hBase, int* bIsReflectionDisabled);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteValueA(HKEY hKey, const(char)* lpValueName);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteValueW(HKEY hKey, const(wchar)* lpValueName);

@DllImport("ADVAPI32.dll")
LSTATUS RegEnumKeyA(HKEY hKey, uint dwIndex, const(char)* lpName, uint cchName);

@DllImport("ADVAPI32.dll")
LSTATUS RegEnumKeyW(HKEY hKey, uint dwIndex, const(wchar)* lpName, uint cchName);

@DllImport("ADVAPI32.dll")
LSTATUS RegEnumKeyExA(HKEY hKey, uint dwIndex, const(char)* lpName, uint* lpcchName, uint* lpReserved, const(char)* lpClass, uint* lpcchClass, FILETIME* lpftLastWriteTime);

@DllImport("ADVAPI32.dll")
LSTATUS RegEnumKeyExW(HKEY hKey, uint dwIndex, const(wchar)* lpName, uint* lpcchName, uint* lpReserved, const(wchar)* lpClass, uint* lpcchClass, FILETIME* lpftLastWriteTime);

@DllImport("ADVAPI32.dll")
LSTATUS RegEnumValueA(HKEY hKey, uint dwIndex, const(char)* lpValueName, uint* lpcchValueName, uint* lpReserved, uint* lpType, char* lpData, uint* lpcbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegEnumValueW(HKEY hKey, uint dwIndex, const(wchar)* lpValueName, uint* lpcchValueName, uint* lpReserved, uint* lpType, char* lpData, uint* lpcbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegFlushKey(HKEY hKey);

@DllImport("ADVAPI32.dll")
LSTATUS RegLoadKeyA(HKEY hKey, const(char)* lpSubKey, const(char)* lpFile);

@DllImport("ADVAPI32.dll")
LSTATUS RegLoadKeyW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpFile);

@DllImport("ADVAPI32.dll")
LSTATUS RegNotifyChangeKeyValue(HKEY hKey, BOOL bWatchSubtree, uint dwNotifyFilter, HANDLE hEvent, BOOL fAsynchronous);

@DllImport("ADVAPI32.dll")
LSTATUS RegOpenKeyA(HKEY hKey, const(char)* lpSubKey, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegOpenKeyW(HKEY hKey, const(wchar)* lpSubKey, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegOpenKeyExA(HKEY hKey, const(char)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegOpenKeyExW(HKEY hKey, const(wchar)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult);

@DllImport("ADVAPI32.dll")
LSTATUS RegOpenKeyTransactedA(HKEY hKey, const(char)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult, HANDLE hTransaction, void* pExtendedParemeter);

@DllImport("ADVAPI32.dll")
LSTATUS RegOpenKeyTransactedW(HKEY hKey, const(wchar)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult, HANDLE hTransaction, void* pExtendedParemeter);

@DllImport("ADVAPI32.dll")
LSTATUS RegQueryInfoKeyA(HKEY hKey, const(char)* lpClass, uint* lpcchClass, uint* lpReserved, uint* lpcSubKeys, uint* lpcbMaxSubKeyLen, uint* lpcbMaxClassLen, uint* lpcValues, uint* lpcbMaxValueNameLen, uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, FILETIME* lpftLastWriteTime);

@DllImport("ADVAPI32.dll")
LSTATUS RegQueryInfoKeyW(HKEY hKey, const(wchar)* lpClass, uint* lpcchClass, uint* lpReserved, uint* lpcSubKeys, uint* lpcbMaxSubKeyLen, uint* lpcbMaxClassLen, uint* lpcValues, uint* lpcbMaxValueNameLen, uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, FILETIME* lpftLastWriteTime);

@DllImport("ADVAPI32.dll")
LSTATUS RegQueryValueA(HKEY hKey, const(char)* lpSubKey, const(char)* lpData, int* lpcbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegQueryValueW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpData, int* lpcbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegQueryMultipleValuesA(HKEY hKey, char* val_list, uint num_vals, const(char)* lpValueBuf, uint* ldwTotsize);

@DllImport("ADVAPI32.dll")
LSTATUS RegQueryMultipleValuesW(HKEY hKey, char* val_list, uint num_vals, const(wchar)* lpValueBuf, uint* ldwTotsize);

@DllImport("ADVAPI32.dll")
LSTATUS RegQueryValueExA(HKEY hKey, const(char)* lpValueName, uint* lpReserved, uint* lpType, char* lpData, uint* lpcbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegQueryValueExW(HKEY hKey, const(wchar)* lpValueName, uint* lpReserved, uint* lpType, char* lpData, uint* lpcbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegReplaceKeyA(HKEY hKey, const(char)* lpSubKey, const(char)* lpNewFile, const(char)* lpOldFile);

@DllImport("ADVAPI32.dll")
LSTATUS RegReplaceKeyW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpNewFile, const(wchar)* lpOldFile);

@DllImport("ADVAPI32.dll")
LSTATUS RegRestoreKeyA(HKEY hKey, const(char)* lpFile, uint dwFlags);

@DllImport("ADVAPI32.dll")
LSTATUS RegRestoreKeyW(HKEY hKey, const(wchar)* lpFile, uint dwFlags);

@DllImport("ADVAPI32.dll")
LSTATUS RegRenameKey(HKEY hKey, const(wchar)* lpSubKeyName, const(wchar)* lpNewKeyName);

@DllImport("ADVAPI32.dll")
LSTATUS RegSaveKeyA(HKEY hKey, const(char)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

@DllImport("ADVAPI32.dll")
LSTATUS RegSaveKeyW(HKEY hKey, const(wchar)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

@DllImport("ADVAPI32.dll")
LSTATUS RegSetValueA(HKEY hKey, const(char)* lpSubKey, uint dwType, const(char)* lpData, uint cbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegSetValueW(HKEY hKey, const(wchar)* lpSubKey, uint dwType, const(wchar)* lpData, uint cbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegSetValueExA(HKEY hKey, const(char)* lpValueName, uint Reserved, uint dwType, char* lpData, uint cbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegSetValueExW(HKEY hKey, const(wchar)* lpValueName, uint Reserved, uint dwType, char* lpData, uint cbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegUnLoadKeyA(HKEY hKey, const(char)* lpSubKey);

@DllImport("ADVAPI32.dll")
LSTATUS RegUnLoadKeyW(HKEY hKey, const(wchar)* lpSubKey);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteKeyValueA(HKEY hKey, const(char)* lpSubKey, const(char)* lpValueName);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteKeyValueW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpValueName);

@DllImport("ADVAPI32.dll")
LSTATUS RegSetKeyValueA(HKEY hKey, const(char)* lpSubKey, const(char)* lpValueName, uint dwType, char* lpData, uint cbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegSetKeyValueW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpValueName, uint dwType, char* lpData, uint cbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteTreeA(HKEY hKey, const(char)* lpSubKey);

@DllImport("ADVAPI32.dll")
LSTATUS RegDeleteTreeW(HKEY hKey, const(wchar)* lpSubKey);

@DllImport("ADVAPI32.dll")
LSTATUS RegCopyTreeA(HKEY hKeySrc, const(char)* lpSubKey, HKEY hKeyDest);

@DllImport("ADVAPI32.dll")
LSTATUS RegGetValueA(HKEY hkey, const(char)* lpSubKey, const(char)* lpValue, uint dwFlags, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegGetValueW(HKEY hkey, const(wchar)* lpSubKey, const(wchar)* lpValue, uint dwFlags, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("ADVAPI32.dll")
LSTATUS RegCopyTreeW(HKEY hKeySrc, const(wchar)* lpSubKey, HKEY hKeyDest);

@DllImport("ADVAPI32.dll")
LSTATUS RegLoadMUIStringA(HKEY hKey, const(char)* pszValue, const(char)* pszOutBuf, uint cbOutBuf, uint* pcbData, uint Flags, const(char)* pszDirectory);

@DllImport("ADVAPI32.dll")
LSTATUS RegLoadMUIStringW(HKEY hKey, const(wchar)* pszValue, const(wchar)* pszOutBuf, uint cbOutBuf, uint* pcbData, uint Flags, const(wchar)* pszDirectory);

@DllImport("ADVAPI32.dll")
LSTATUS RegLoadAppKeyA(const(char)* lpFile, HKEY* phkResult, uint samDesired, uint dwOptions, uint Reserved);

@DllImport("ADVAPI32.dll")
LSTATUS RegLoadAppKeyW(const(wchar)* lpFile, HKEY* phkResult, uint samDesired, uint dwOptions, uint Reserved);

@DllImport("ADVAPI32.dll")
uint CheckForHiberboot(ubyte* pHiberboot, ubyte bClearFlag);

@DllImport("ADVAPI32.dll")
LSTATUS RegSaveKeyExA(HKEY hKey, const(char)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, uint Flags);

@DllImport("ADVAPI32.dll")
LSTATUS RegSaveKeyExW(HKEY hKey, const(wchar)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, uint Flags);

@DllImport("ntdll.dll")
NTSTATUS NtClose(HANDLE Handle);

@DllImport("ntdll.dll")
NTSTATUS NtCreateFile(int* FileHandle, uint DesiredAccess, OBJECT_ATTRIBUTES* ObjectAttributes, IO_STATUS_BLOCK* IoStatusBlock, LARGE_INTEGER* AllocationSize, uint FileAttributes, uint ShareAccess, uint CreateDisposition, uint CreateOptions, void* EaBuffer, uint EaLength);

@DllImport("ntdll.dll")
NTSTATUS NtOpenFile(int* FileHandle, uint DesiredAccess, OBJECT_ATTRIBUTES* ObjectAttributes, IO_STATUS_BLOCK* IoStatusBlock, uint ShareAccess, uint OpenOptions);

@DllImport("ntdll.dll")
NTSTATUS NtRenameKey(HANDLE KeyHandle, UNICODE_STRING* NewName);

@DllImport("ntdll.dll")
NTSTATUS NtNotifyChangeMultipleKeys(HANDLE MasterKeyHandle, uint Count, char* SubordinateObjects, HANDLE Event, PIO_APC_ROUTINE ApcRoutine, void* ApcContext, IO_STATUS_BLOCK* IoStatusBlock, uint CompletionFilter, ubyte WatchTree, char* Buffer, uint BufferSize, ubyte Asynchronous);

@DllImport("ntdll.dll")
NTSTATUS NtQueryMultipleValueKey(HANDLE KeyHandle, char* ValueEntries, uint EntryCount, char* ValueBuffer, uint* BufferLength, uint* RequiredBufferLength);

@DllImport("ntdll.dll")
NTSTATUS NtSetInformationKey(HANDLE KeyHandle, KEY_SET_INFORMATION_CLASS KeySetInformationClass, char* KeySetInformation, uint KeySetInformationLength);

@DllImport("ntdll.dll")
NTSTATUS NtDeviceIoControlFile(HANDLE FileHandle, HANDLE Event, PIO_APC_ROUTINE ApcRoutine, void* ApcContext, IO_STATUS_BLOCK* IoStatusBlock, uint IoControlCode, void* InputBuffer, uint InputBufferLength, void* OutputBuffer, uint OutputBufferLength);

@DllImport("ntdll.dll")
NTSTATUS NtWaitForSingleObject(HANDLE Handle, ubyte Alertable, LARGE_INTEGER* Timeout);

@DllImport("ntdll.dll")
ubyte RtlIsNameLegalDOS8Dot3(UNICODE_STRING* Name, STRING* OemName, ubyte* NameContainsSpaces);

@DllImport("ntdll.dll")
NTSTATUS NtQueryObject(HANDLE Handle, OBJECT_INFORMATION_CLASS ObjectInformationClass, char* ObjectInformation, uint ObjectInformationLength, uint* ReturnLength);

@DllImport("ntdll.dll")
NTSTATUS NtQuerySystemInformation(SYSTEM_INFORMATION_CLASS SystemInformationClass, void* SystemInformation, uint SystemInformationLength, uint* ReturnLength);

@DllImport("ntdll.dll")
NTSTATUS NtQuerySystemTime(LARGE_INTEGER* SystemTime);

@DllImport("ntdll.dll")
NTSTATUS RtlLocalTimeToSystemTime(LARGE_INTEGER* LocalTime, LARGE_INTEGER* SystemTime);

@DllImport("ntdll.dll")
ubyte RtlTimeToSecondsSince1970(LARGE_INTEGER* Time, uint* ElapsedSeconds);

@DllImport("ntdll.dll")
void RtlFreeAnsiString(STRING* AnsiString);

@DllImport("ntdll.dll")
void RtlFreeUnicodeString(UNICODE_STRING* UnicodeString);

@DllImport("ntdll.dll")
void RtlFreeOemString(STRING* OemString);

@DllImport("ntdll.dll")
void RtlInitString(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll.dll")
NTSTATUS RtlInitStringEx(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll.dll")
void RtlInitAnsiString(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll.dll")
NTSTATUS RtlInitAnsiStringEx(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll.dll")
void RtlInitUnicodeString(UNICODE_STRING* DestinationString, const(wchar)* SourceString);

@DllImport("ntdll.dll")
NTSTATUS RtlAnsiStringToUnicodeString(UNICODE_STRING* DestinationString, STRING* SourceString, ubyte AllocateDestinationString);

@DllImport("ntdll.dll")
NTSTATUS RtlUnicodeStringToAnsiString(STRING* DestinationString, UNICODE_STRING* SourceString, ubyte AllocateDestinationString);

@DllImport("ntdll.dll")
NTSTATUS RtlUnicodeStringToOemString(STRING* DestinationString, UNICODE_STRING* SourceString, ubyte AllocateDestinationString);

@DllImport("ntdll.dll")
NTSTATUS RtlUnicodeToMultiByteSize(uint* BytesInMultiByteString, const(wchar)* UnicodeString, uint BytesInUnicodeString);

@DllImport("ntdll.dll")
NTSTATUS RtlCharToInteger(byte* String, uint Base, uint* Value);

@DllImport("ntdll.dll")
uint RtlUniform(uint* Seed);

@DllImport("Cabinet.dll")
void* FCICreate(ERF* perf, PFNFCIFILEPLACED pfnfcifp, PFNFCIALLOC pfna, PFNFCIFREE pfnf, PFNFCIOPEN pfnopen, PFNFCIREAD pfnread, PFNFCIWRITE pfnwrite, PFNFCICLOSE pfnclose, PFNFCISEEK pfnseek, PFNFCIDELETE pfndelete, PFNFCIGETTEMPFILE pfnfcigtf, CCAB* pccab, void* pv);

@DllImport("Cabinet.dll")
BOOL FCIAddFile(void* hfci, const(char)* pszSourceFile, const(char)* pszFileName, BOOL fExecute, PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis, PFNFCIGETOPENINFO pfnfcigoi, ushort typeCompress);

@DllImport("Cabinet.dll")
BOOL FCIFlushCabinet(void* hfci, BOOL fGetNextCab, PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis);

@DllImport("Cabinet.dll")
BOOL FCIFlushFolder(void* hfci, PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis);

@DllImport("Cabinet.dll")
BOOL FCIDestroy(void* hfci);

@DllImport("Cabinet.dll")
void* FDICreate(PFNALLOC pfnalloc, PFNFREE pfnfree, PFNOPEN pfnopen, PFNREAD pfnread, PFNWRITE pfnwrite, PFNCLOSE pfnclose, PFNSEEK pfnseek, int cpuType, ERF* perf);

@DllImport("Cabinet.dll")
BOOL FDIIsCabinet(void* hfdi, int hf, FDICABINETINFO* pfdici);

@DllImport("Cabinet.dll")
BOOL FDICopy(void* hfdi, const(char)* pszCabinet, const(char)* pszCabPath, int flags, PFNFDINOTIFY pfnfdin, PFNFDIDECRYPT pfnfdid, void* pvUser);

@DllImport("Cabinet.dll")
BOOL FDIDestroy(void* hfdi);

@DllImport("Cabinet.dll")
BOOL FDITruncateCabinet(void* hfdi, const(char)* pszCabinetName, ushort iFolderToDelete);

@DllImport("api-ms-win-core-featurestaging-l1-1-0.dll")
FEATURE_ENABLED_STATE GetFeatureEnabledState(uint featureId, FEATURE_CHANGE_TIME changeTime);

@DllImport("api-ms-win-core-featurestaging-l1-1-0.dll")
void RecordFeatureUsage(uint featureId, uint kind, uint addend, const(char)* originName);

@DllImport("api-ms-win-core-featurestaging-l1-1-0.dll")
void RecordFeatureError(uint featureId, const(FEATURE_ERROR)* error);

@DllImport("api-ms-win-core-featurestaging-l1-1-0.dll")
void SubscribeFeatureStateChangeNotification(FEATURE_STATE_CHANGE_SUBSCRIPTION__** subscription, PFEATURE_STATE_CHANGE_CALLBACK callback, void* context);

@DllImport("api-ms-win-core-featurestaging-l1-1-0.dll")
void UnsubscribeFeatureStateChangeNotification(FEATURE_STATE_CHANGE_SUBSCRIPTION__* subscription);

@DllImport("api-ms-win-core-featurestaging-l1-1-1.dll")
uint GetFeatureVariant(uint featureId, FEATURE_CHANGE_TIME changeTime, uint* payloadId, int* hasNotification);

@DllImport("fhsvcctl.dll")
HRESULT FhServiceOpenPipe(BOOL StartServiceIfStopped, FH_SERVICE_PIPE_HANDLE__** Pipe);

@DllImport("fhsvcctl.dll")
HRESULT FhServiceClosePipe(FH_SERVICE_PIPE_HANDLE__* Pipe);

@DllImport("fhsvcctl.dll")
HRESULT FhServiceStartBackup(FH_SERVICE_PIPE_HANDLE__* Pipe, BOOL LowPriorityIo);

@DllImport("fhsvcctl.dll")
HRESULT FhServiceStopBackup(FH_SERVICE_PIPE_HANDLE__* Pipe, BOOL StopTracking);

@DllImport("fhsvcctl.dll")
HRESULT FhServiceReloadConfiguration(FH_SERVICE_PIPE_HANDLE__* Pipe);

@DllImport("fhsvcctl.dll")
HRESULT FhServiceBlockBackup(FH_SERVICE_PIPE_HANDLE__* Pipe);

@DllImport("fhsvcctl.dll")
HRESULT FhServiceUnblockBackup(FH_SERVICE_PIPE_HANDLE__* Pipe);

@DllImport("DCIMAN32.dll")
HDC DCIOpenProvider();

@DllImport("DCIMAN32.dll")
void DCICloseProvider(HDC hdc);

@DllImport("DCIMAN32.dll")
int DCICreatePrimary(HDC hdc, DCISURFACEINFO** lplpSurface);

@DllImport("DCIMAN32.dll")
int DCICreateOffscreen(HDC hdc, uint dwCompression, uint dwRedMask, uint dwGreenMask, uint dwBlueMask, uint dwWidth, uint dwHeight, uint dwDCICaps, uint dwBitCount, DCIOFFSCREEN** lplpSurface);

@DllImport("DCIMAN32.dll")
int DCICreateOverlay(HDC hdc, void* lpOffscreenSurf, DCIOVERLAY** lplpSurface);

@DllImport("DCIMAN32.dll")
int DCIEnum(HDC hdc, RECT* lprDst, RECT* lprSrc, void* lpFnCallback, void* lpContext);

@DllImport("DCIMAN32.dll")
int DCISetSrcDestClip(DCIOFFSCREEN* pdci, RECT* srcrc, RECT* destrc, RGNDATA* prd);

@DllImport("DCIMAN32.dll")
HWINWATCH__* WinWatchOpen(HWND hwnd);

@DllImport("DCIMAN32.dll")
void WinWatchClose(HWINWATCH__* hWW);

@DllImport("DCIMAN32.dll")
uint WinWatchGetClipList(HWINWATCH__* hWW, RECT* prc, uint size, RGNDATA* prd);

@DllImport("DCIMAN32.dll")
BOOL WinWatchDidStatusChange(HWINWATCH__* hWW);

@DllImport("DCIMAN32.dll")
uint GetWindowRegionData(HWND hwnd, uint size, RGNDATA* prd);

@DllImport("DCIMAN32.dll")
uint GetDCRegionData(HDC hdc, uint size, RGNDATA* prd);

@DllImport("DCIMAN32.dll")
BOOL WinWatchNotify(HWINWATCH__* hWW, WINWATCHNOTIFYPROC NotifyCallback, LPARAM NotifyParam);

@DllImport("DCIMAN32.dll")
void DCIEndAccess(DCISURFACEINFO* pdci);

@DllImport("DCIMAN32.dll")
int DCIBeginAccess(DCISURFACEINFO* pdci, int x, int y, int dx, int dy);

@DllImport("DCIMAN32.dll")
void DCIDestroy(DCISURFACEINFO* pdci);

@DllImport("DCIMAN32.dll")
int DCIDraw(DCIOFFSCREEN* pdci);

@DllImport("DCIMAN32.dll")
int DCISetClipList(DCIOFFSCREEN* pdci, RGNDATA* prd);

@DllImport("DCIMAN32.dll")
int DCISetDestination(DCIOFFSCREEN* pdci, RECT* dst, RECT* src);

@DllImport("api-ms-win-dx-d3dkmt-l1-1-0.dll")
uint GdiEntry13();

@DllImport("ADVPACK.dll")
HRESULT RunSetupCommandA(HWND hWnd, const(char)* szCmdName, const(char)* szInfSection, const(char)* szDir, const(char)* lpszTitle, HANDLE* phEXE, uint dwFlags, void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT RunSetupCommandW(HWND hWnd, const(wchar)* szCmdName, const(wchar)* szInfSection, const(wchar)* szDir, const(wchar)* lpszTitle, HANDLE* phEXE, uint dwFlags, void* pvReserved);

@DllImport("ADVPACK.dll")
uint NeedRebootInit();

@DllImport("ADVPACK.dll")
BOOL NeedReboot(uint dwRebootCheck);

@DllImport("ADVPACK.dll")
HRESULT RebootCheckOnInstallA(HWND hwnd, const(char)* pszINF, const(char)* pszSec, uint dwReserved);

@DllImport("ADVPACK.dll")
HRESULT RebootCheckOnInstallW(HWND hwnd, const(wchar)* pszINF, const(wchar)* pszSec, uint dwReserved);

@DllImport("ADVPACK.dll")
HRESULT TranslateInfStringA(const(char)* pszInfFilename, const(char)* pszInstallSection, const(char)* pszTranslateSection, const(char)* pszTranslateKey, const(char)* pszBuffer, uint cchBuffer, uint* pdwRequiredSize, void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT TranslateInfStringW(const(wchar)* pszInfFilename, const(wchar)* pszInstallSection, const(wchar)* pszTranslateSection, const(wchar)* pszTranslateKey, const(wchar)* pszBuffer, uint cchBuffer, uint* pdwRequiredSize, void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT RegInstallA(int hmod, const(char)* pszSection, const(STRTABLEA)* pstTable);

@DllImport("ADVPACK.dll")
HRESULT RegInstallW(int hmod, const(wchar)* pszSection, const(STRTABLEW)* pstTable);

@DllImport("ADVPACK.dll")
HRESULT LaunchINFSectionExW(HWND hwnd, HINSTANCE hInstance, const(wchar)* pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT ExecuteCabA(HWND hwnd, _CabInfoA* pCab, void* pReserved);

@DllImport("ADVPACK.dll")
HRESULT ExecuteCabW(HWND hwnd, _CabInfoW* pCab, void* pReserved);

@DllImport("ADVPACK.dll")
HRESULT AdvInstallFileA(HWND hwnd, const(char)* lpszSourceDir, const(char)* lpszSourceFile, const(char)* lpszDestDir, const(char)* lpszDestFile, uint dwFlags, uint dwReserved);

@DllImport("ADVPACK.dll")
HRESULT AdvInstallFileW(HWND hwnd, const(wchar)* lpszSourceDir, const(wchar)* lpszSourceFile, const(wchar)* lpszDestDir, const(wchar)* lpszDestFile, uint dwFlags, uint dwReserved);

@DllImport("ADVPACK.dll")
HRESULT RegSaveRestoreA(HWND hWnd, const(char)* pszTitleString, HKEY hkBckupKey, const(char)* pcszRootKey, const(char)* pcszSubKey, const(char)* pcszValueName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT RegSaveRestoreW(HWND hWnd, const(wchar)* pszTitleString, HKEY hkBckupKey, const(wchar)* pcszRootKey, const(wchar)* pcszSubKey, const(wchar)* pcszValueName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT RegSaveRestoreOnINFA(HWND hWnd, const(char)* pszTitle, const(char)* pszINF, const(char)* pszSection, HKEY hHKLMBackKey, HKEY hHKCUBackKey, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT RegSaveRestoreOnINFW(HWND hWnd, const(wchar)* pszTitle, const(wchar)* pszINF, const(wchar)* pszSection, HKEY hHKLMBackKey, HKEY hHKCUBackKey, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT RegRestoreAllA(HWND hWnd, const(char)* pszTitleString, HKEY hkBckupKey);

@DllImport("ADVPACK.dll")
HRESULT RegRestoreAllW(HWND hWnd, const(wchar)* pszTitleString, HKEY hkBckupKey);

@DllImport("ADVPACK.dll")
HRESULT FileSaveRestoreW(HWND hDlg, const(wchar)* lpFileList, const(wchar)* lpDir, const(wchar)* lpBaseName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT FileSaveRestoreOnINFA(HWND hWnd, const(char)* pszTitle, const(char)* pszINF, const(char)* pszSection, const(char)* pszBackupDir, const(char)* pszBaseBackupFile, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT FileSaveRestoreOnINFW(HWND hWnd, const(wchar)* pszTitle, const(wchar)* pszINF, const(wchar)* pszSection, const(wchar)* pszBackupDir, const(wchar)* pszBaseBackupFile, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT AddDelBackupEntryA(const(char)* lpcszFileList, const(char)* lpcszBackupDir, const(char)* lpcszBaseName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT AddDelBackupEntryW(const(wchar)* lpcszFileList, const(wchar)* lpcszBackupDir, const(wchar)* lpcszBaseName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT FileSaveMarkNotExistA(const(char)* lpFileList, const(char)* lpDir, const(char)* lpBaseName);

@DllImport("ADVPACK.dll")
HRESULT FileSaveMarkNotExistW(const(wchar)* lpFileList, const(wchar)* lpDir, const(wchar)* lpBaseName);

@DllImport("ADVPACK.dll")
HRESULT GetVersionFromFileA(const(char)* lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK.dll")
HRESULT GetVersionFromFileW(const(wchar)* lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK.dll")
HRESULT GetVersionFromFileExA(const(char)* lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK.dll")
HRESULT GetVersionFromFileExW(const(wchar)* lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK.dll")
BOOL IsNTAdmin(uint dwReserved, uint* lpdwReserved);

@DllImport("ADVPACK.dll")
HRESULT DelNodeA(const(char)* pszFileOrDirName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT DelNodeW(const(wchar)* pszFileOrDirName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT DelNodeRunDLL32W(HWND hwnd, HINSTANCE hInstance, const(wchar)* pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT OpenINFEngineA(const(char)* pszInfFilename, const(char)* pszInstallSection, uint dwFlags, void** phInf, void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT OpenINFEngineW(const(wchar)* pszInfFilename, const(wchar)* pszInstallSection, uint dwFlags, void** phInf, void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT TranslateInfStringExA(void* hInf, const(char)* pszInfFilename, const(char)* pszTranslateSection, const(char)* pszTranslateKey, const(char)* pszBuffer, uint dwBufferSize, uint* pdwRequiredSize, void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT TranslateInfStringExW(void* hInf, const(wchar)* pszInfFilename, const(wchar)* pszTranslateSection, const(wchar)* pszTranslateKey, const(wchar)* pszBuffer, uint dwBufferSize, uint* pdwRequiredSize, void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT CloseINFEngine(void* hInf);

@DllImport("ADVPACK.dll")
HRESULT ExtractFilesA(const(char)* pszCabName, const(char)* pszExpandDir, uint dwFlags, const(char)* pszFileList, void* lpReserved, uint dwReserved);

@DllImport("ADVPACK.dll")
HRESULT ExtractFilesW(const(wchar)* pszCabName, const(wchar)* pszExpandDir, uint dwFlags, const(wchar)* pszFileList, void* lpReserved, uint dwReserved);

@DllImport("ADVPACK.dll")
int LaunchINFSectionW(HWND hwndOwner, HINSTANCE hInstance, const(wchar)* pszParams, int nShow);

@DllImport("ADVPACK.dll")
HRESULT UserInstStubWrapperA(HWND hwnd, HINSTANCE hInstance, const(char)* pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT UserInstStubWrapperW(HWND hwnd, HINSTANCE hInstance, const(wchar)* pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT UserUnInstStubWrapperA(HWND hwnd, HINSTANCE hInstance, const(char)* pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT UserUnInstStubWrapperW(HWND hwnd, HINSTANCE hInstance, const(wchar)* pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT SetPerUserSecValuesA(PERUSERSECTIONA* pPerUser);

@DllImport("ADVPACK.dll")
HRESULT SetPerUserSecValuesW(PERUSERSECTIONW* pPerUser);

@DllImport("USER32.dll")
LRESULT SendIMEMessageExA(HWND param0, LPARAM param1);

@DllImport("USER32.dll")
LRESULT SendIMEMessageExW(HWND param0, LPARAM param1);

@DllImport("USER32.dll")
BOOL IMPGetIMEA(HWND param0, IMEPROA* param1);

@DllImport("USER32.dll")
BOOL IMPGetIMEW(HWND param0, IMEPROW* param1);

@DllImport("USER32.dll")
BOOL IMPQueryIMEA(IMEPROA* param0);

@DllImport("USER32.dll")
BOOL IMPQueryIMEW(IMEPROW* param0);

@DllImport("USER32.dll")
BOOL IMPSetIMEA(HWND param0, IMEPROA* param1);

@DllImport("USER32.dll")
BOOL IMPSetIMEW(HWND param0, IMEPROW* param1);

@DllImport("USER32.dll")
uint WINNLSGetIMEHotkey(HWND param0);

@DllImport("USER32.dll")
BOOL WINNLSEnableIME(HWND param0, BOOL param1);

@DllImport("USER32.dll")
BOOL WINNLSGetEnableStatus(HWND param0);

@DllImport("api-ms-win-security-isolatedcontainer-l1-1-1.dll")
HRESULT IsProcessInWDAGContainer(void* Reserved, int* isProcessInWDAGContainer);

@DllImport("api-ms-win-security-isolatedcontainer-l1-1-0.dll")
HRESULT IsProcessInIsolatedContainer(int* isProcessInIsolatedContainer);

@DllImport("WSCAPI.dll")
HRESULT WscRegisterForChanges(void* Reserved, int* phCallbackRegistration, LPTHREAD_START_ROUTINE lpCallbackAddress, void* pContext);

@DllImport("WSCAPI.dll")
HRESULT WscUnRegisterChanges(HANDLE hRegistrationHandle);

@DllImport("WSCAPI.dll")
HRESULT WscRegisterForUserNotifications();

@DllImport("WSCAPI.dll")
HRESULT WscGetSecurityProviderHealth(uint Providers, WSC_SECURITY_PROVIDER_HEALTH* pHealth);

@DllImport("WSCAPI.dll")
HRESULT WscQueryAntiMalwareUri();

@DllImport("WSCAPI.dll")
HRESULT WscGetAntiMalwareUri(ushort** ppszUri);

@DllImport("APPHELP.dll")
BOOL ApphelpCheckShellObject(const(Guid)* ObjectCLSID, BOOL bShimIfNecessary, ulong* pullFlags);

@DllImport("Wldp.dll")
HRESULT WldpGetLockdownPolicy(WLDP_HOST_INFORMATION* hostInformation, uint* lockdownState, uint lockdownFlags);

@DllImport("Wldp.dll")
HRESULT WldpIsClassInApprovedList(const(Guid)* classID, WLDP_HOST_INFORMATION* hostInformation, int* isApproved, uint optionalFlags);

@DllImport("Wldp.dll")
HRESULT WldpSetDynamicCodeTrust(HANDLE fileHandle);

@DllImport("Wldp.dll")
HRESULT WldpIsDynamicCodePolicyEnabled(int* isEnabled);

@DllImport("Wldp.dll")
HRESULT WldpQueryDynamicCodeTrust(HANDLE fileHandle, char* baseImage, uint imageSize);

@DllImport("KERNEL32.dll")
BOOL CeipIsOptedIn();

@DllImport("XmlLite.dll")
HRESULT CreateXmlReader(const(Guid)* riid, void** ppvObject, IMalloc pMalloc);

@DllImport("XmlLite.dll")
HRESULT CreateXmlReaderInputWithEncodingCodePage(IUnknown pInputStream, IMalloc pMalloc, uint nEncodingCodePage, BOOL fEncodingHint, const(wchar)* pwszBaseUri, IUnknown* ppInput);

@DllImport("XmlLite.dll")
HRESULT CreateXmlReaderInputWithEncodingName(IUnknown pInputStream, IMalloc pMalloc, const(wchar)* pwszEncodingName, BOOL fEncodingHint, const(wchar)* pwszBaseUri, IUnknown* ppInput);

@DllImport("XmlLite.dll")
HRESULT CreateXmlWriter(const(Guid)* riid, void** ppvObject, IMalloc pMalloc);

@DllImport("XmlLite.dll")
HRESULT CreateXmlWriterOutputWithEncodingCodePage(IUnknown pOutputStream, IMalloc pMalloc, uint nEncodingCodePage, IUnknown* ppOutput);

@DllImport("XmlLite.dll")
HRESULT CreateXmlWriterOutputWithEncodingName(IUnknown pOutputStream, IMalloc pMalloc, const(wchar)* pwszEncodingName, IUnknown* ppOutput);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
HRESULT DevCreateObjectQuery(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-1.dll")
HRESULT DevCreateObjectQueryEx(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, uint cExtendedParameterCount, char* pExtendedParameters, PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
HRESULT DevCreateObjectQueryFromId(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszObjectId, uint QueryFlags, uint cRequestedProperties, char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-1.dll")
HRESULT DevCreateObjectQueryFromIdEx(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszObjectId, uint QueryFlags, uint cRequestedProperties, char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, uint cExtendedParameterCount, char* pExtendedParameters, PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
HRESULT DevCreateObjectQueryFromIds(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszzObjectIds, uint QueryFlags, uint cRequestedProperties, char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-1.dll")
HRESULT DevCreateObjectQueryFromIdsEx(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszzObjectIds, uint QueryFlags, uint cRequestedProperties, char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, uint cExtendedParameterCount, char* pExtendedParameters, PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
void DevCloseObjectQuery(HDEVQUERY__* hDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
HRESULT DevGetObjects(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, uint* pcObjectCount, const(DEV_OBJECT)** ppObjects);

@DllImport("api-ms-win-devices-query-l1-1-1.dll")
HRESULT DevGetObjectsEx(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, uint cExtendedParameterCount, char* pExtendedParameters, uint* pcObjectCount, const(DEV_OBJECT)** ppObjects);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
void DevFreeObjects(uint cObjectCount, char* pObjects);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
HRESULT DevGetObjectProperties(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszObjectId, uint QueryFlags, uint cRequestedProperties, char* pRequestedProperties, uint* pcPropertyCount, const(DEVPROPERTY)** ppProperties);

@DllImport("api-ms-win-devices-query-l1-1-1.dll")
HRESULT DevGetObjectPropertiesEx(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszObjectId, uint QueryFlags, uint cRequestedProperties, char* pRequestedProperties, uint cExtendedParameterCount, char* pExtendedParameters, uint* pcPropertyCount, const(DEVPROPERTY)** ppProperties);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
void DevFreeObjectProperties(uint cPropertyCount, char* pProperties);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
DEVPROPERTY* DevFindProperty(const(DEVPROPKEY)* pKey, DEVPROPSTORE Store, const(wchar)* pszLocaleName, uint cProperties, char* pProperties);

@DllImport("IPHLPAPI.dll")
uint PfCreateInterface(uint dwName, _PfForwardAction inAction, _PfForwardAction outAction, BOOL bUseLog, BOOL bMustBeUnique, void** ppInterface);

@DllImport("IPHLPAPI.dll")
uint PfDeleteInterface(void* pInterface);

@DllImport("IPHLPAPI.dll")
uint PfAddFiltersToInterface(void* ih, uint cInFilters, PF_FILTER_DESCRIPTOR* pfiltIn, uint cOutFilters, PF_FILTER_DESCRIPTOR* pfiltOut, void** pfHandle);

@DllImport("IPHLPAPI.dll")
uint PfRemoveFiltersFromInterface(void* ih, uint cInFilters, PF_FILTER_DESCRIPTOR* pfiltIn, uint cOutFilters, PF_FILTER_DESCRIPTOR* pfiltOut);

@DllImport("IPHLPAPI.dll")
uint PfRemoveFilterHandles(void* pInterface, uint cFilters, void** pvHandles);

@DllImport("IPHLPAPI.dll")
uint PfUnBindInterface(void* pInterface);

@DllImport("IPHLPAPI.dll")
uint PfBindInterfaceToIndex(void* pInterface, uint dwIndex, _PfAddresType pfatLinkType, ubyte* LinkIPAddress);

@DllImport("IPHLPAPI.dll")
uint PfBindInterfaceToIPAddress(void* pInterface, _PfAddresType pfatType, ubyte* IPAddress);

@DllImport("IPHLPAPI.dll")
uint PfRebindFilters(void* pInterface, PF_LATEBIND_INFO* pLateBindInfo);

@DllImport("IPHLPAPI.dll")
uint PfAddGlobalFilterToInterface(void* pInterface, _GlobalFilter gfFilter);

@DllImport("IPHLPAPI.dll")
uint PfRemoveGlobalFilterFromInterface(void* pInterface, _GlobalFilter gfFilter);

@DllImport("IPHLPAPI.dll")
uint PfMakeLog(HANDLE hEvent);

@DllImport("IPHLPAPI.dll")
uint PfSetLogBuffer(ubyte* pbBuffer, uint dwSize, uint dwThreshold, uint dwEntries, uint* pdwLoggedEntries, uint* pdwLostEntries, uint* pdwSizeUsed);

@DllImport("IPHLPAPI.dll")
uint PfDeleteLog();

@DllImport("IPHLPAPI.dll")
uint PfGetInterfaceStatistics(void* pInterface, PF_INTERFACE_STATS* ppfStats, uint* pdwBufferSize, BOOL fResetCounters);

@DllImport("IPHLPAPI.dll")
uint PfTestPacket(void* pInInterface, void* pOutInterface, uint cBytes, ubyte* pbPacket, _PfForwardAction* ppAction);

@DllImport("api-ms-win-core-state-helpers-l1-1-0.dll")
LSTATUS GetRegistryValueWithFallbackW(HKEY hkeyPrimary, const(wchar)* pwszPrimarySubKey, HKEY hkeyFallback, const(wchar)* pwszFallbackSubKey, const(wchar)* pwszValue, uint dwFlags, uint* pdwType, char* pvData, uint cbDataIn, uint* pcbDataOut);

@DllImport("ole32.dll")
HRESULT CoInstall(IBindCtx pbc, uint dwFlags, uCLSSPEC* pClassSpec, QUERYCONTEXT* pQuery, const(wchar)* pszCodeBase);

alias EventLogHandle = int;
alias EventSourceHandle = int;
alias HeapHandle = int;
alias HKEY = int;
enum FIRMWARE_TYPE
{
    FirmwareTypeUnknown = 0,
    FirmwareTypeBios = 1,
    FirmwareTypeUefi = 2,
    FirmwareTypeMax = 3,
}

struct OSVERSIONINFOA
{
    uint dwOSVersionInfoSize;
    uint dwMajorVersion;
    uint dwMinorVersion;
    uint dwBuildNumber;
    uint dwPlatformId;
    byte szCSDVersion;
}

struct OSVERSIONINFOW
{
    uint dwOSVersionInfoSize;
    uint dwMajorVersion;
    uint dwMinorVersion;
    uint dwBuildNumber;
    uint dwPlatformId;
    ushort szCSDVersion;
}

struct OSVERSIONINFOEXA
{
    uint dwOSVersionInfoSize;
    uint dwMajorVersion;
    uint dwMinorVersion;
    uint dwBuildNumber;
    uint dwPlatformId;
    byte szCSDVersion;
    ushort wServicePackMajor;
    ushort wServicePackMinor;
    ushort wSuiteMask;
    ubyte wProductType;
    ubyte wReserved;
}

struct OSVERSIONINFOEXW
{
    uint dwOSVersionInfoSize;
    uint dwMajorVersion;
    uint dwMinorVersion;
    uint dwBuildNumber;
    uint dwPlatformId;
    ushort szCSDVersion;
    ushort wServicePackMajor;
    ushort wServicePackMinor;
    ushort wSuiteMask;
    ubyte wProductType;
    ubyte wReserved;
}

struct FILETIME
{
    uint dwLowDateTime;
    uint dwHighDateTime;
}

struct STRING
{
    ushort Length;
    ushort MaximumLength;
    const(char)* Buffer;
}

struct SYSTEMTIME
{
    ushort wYear;
    ushort wMonth;
    ushort wDayOfWeek;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wMilliseconds;
}

enum UpdateImpactLevel
{
    UpdateImpactLevel_None = 0,
    UpdateImpactLevel_Low = 1,
    UpdateImpactLevel_Medium = 2,
    UpdateImpactLevel_High = 3,
}

enum UpdateAssessmentStatus
{
    UpdateAssessmentStatus_Latest = 0,
    UpdateAssessmentStatus_NotLatestSoftRestriction = 1,
    UpdateAssessmentStatus_NotLatestHardRestriction = 2,
    UpdateAssessmentStatus_NotLatestEndOfSupport = 3,
    UpdateAssessmentStatus_NotLatestServicingTrain = 4,
    UpdateAssessmentStatus_NotLatestDeferredFeature = 5,
    UpdateAssessmentStatus_NotLatestDeferredQuality = 6,
    UpdateAssessmentStatus_NotLatestPausedFeature = 7,
    UpdateAssessmentStatus_NotLatestPausedQuality = 8,
    UpdateAssessmentStatus_NotLatestManaged = 9,
    UpdateAssessmentStatus_NotLatestUnknown = 10,
    UpdateAssessmentStatus_NotLatestTargetedVersion = 11,
}

struct UpdateAssessment
{
    UpdateAssessmentStatus status;
    UpdateImpactLevel impact;
    uint daysOutOfDate;
}

struct OSUpdateAssessment
{
    BOOL isEndOfSupport;
    UpdateAssessment assessmentForCurrent;
    UpdateAssessment assessmentForUpToDate;
    UpdateAssessmentStatus securityStatus;
    FILETIME assessmentTime;
    FILETIME releaseInfoTime;
    const(wchar)* currentOSBuild;
    FILETIME currentOSReleaseTime;
    const(wchar)* upToDateOSBuild;
    FILETIME upToDateOSReleaseTime;
}

enum EXTENDED_NAME_FORMAT
{
    NameUnknown = 0,
    NameFullyQualifiedDN = 1,
    NameSamCompatible = 2,
    NameDisplay = 3,
    NameUniqueId = 6,
    NameCanonical = 7,
    NameUserPrincipal = 8,
    NameCanonicalEx = 9,
    NameServicePrincipal = 10,
    NameDnsDomain = 12,
    NameGivenName = 13,
    NameSurname = 14,
}

struct _PROC_THREAD_ATTRIBUTE_LIST
{
}

enum THREAD_INFORMATION_CLASS
{
    ThreadMemoryPriority = 0,
    ThreadAbsoluteCpuPriority = 1,
    ThreadDynamicCodePolicy = 2,
    ThreadPowerThrottling = 3,
    ThreadInformationClassMax = 4,
}

struct SYSTEM_INFO
{
    _Anonymous_e__Union Anonymous;
    uint dwPageSize;
    void* lpMinimumApplicationAddress;
    void* lpMaximumApplicationAddress;
    uint dwActiveProcessorMask;
    uint dwNumberOfProcessors;
    uint dwProcessorType;
    uint dwAllocationGranularity;
    ushort wProcessorLevel;
    ushort wProcessorRevision;
}

enum COMPUTER_NAME_FORMAT
{
    ComputerNameNetBIOS = 0,
    ComputerNameDnsHostname = 1,
    ComputerNameDnsDomain = 2,
    ComputerNameDnsFullyQualified = 3,
    ComputerNamePhysicalNetBIOS = 4,
    ComputerNamePhysicalDnsHostname = 5,
    ComputerNamePhysicalDnsDomain = 6,
    ComputerNamePhysicalDnsFullyQualified = 7,
    ComputerNameMax = 8,
}

alias LPFIBER_START_ROUTINE = extern(Windows) void function();
alias PFIBER_CALLOUT_ROUTINE = extern(Windows) void* function(void* lpParameter);
struct JIT_DEBUG_INFO
{
    uint dwSize;
    uint dwProcessorArchitecture;
    uint dwThreadID;
    uint dwReserved0;
    ulong lpExceptionAddress;
    ulong lpExceptionRecord;
    ulong lpContextRecord;
}

alias PUMS_SCHEDULER_ENTRY_POINT = extern(Windows) void function();
enum DEP_SYSTEM_POLICY_TYPE
{
    DEPPolicyAlwaysOff = 0,
    DEPPolicyAlwaysOn = 1,
    DEPPolicyOptIn = 2,
    DEPPolicyOptOut = 3,
    DEPTotalPolicyCount = 4,
}

enum PROC_THREAD_ATTRIBUTE_NUM
{
    ProcThreadAttributeParentProcess = 0,
    ProcThreadAttributeHandleList = 2,
    ProcThreadAttributeGroupAffinity = 3,
    ProcThreadAttributePreferredNode = 4,
    ProcThreadAttributeIdealProcessor = 5,
    ProcThreadAttributeUmsThread = 6,
    ProcThreadAttributeMitigationPolicy = 7,
    ProcThreadAttributeSecurityCapabilities = 9,
    ProcThreadAttributeProtectionLevel = 11,
    ProcThreadAttributeJobList = 13,
    ProcThreadAttributeChildProcessPolicy = 14,
    ProcThreadAttributeAllApplicationPackagesPolicy = 15,
    ProcThreadAttributeWin32kFilter = 16,
    ProcThreadAttributeSafeOpenPromptOriginClaim = 17,
    ProcThreadAttributeDesktopAppPolicy = 18,
    ProcThreadAttributePseudoConsole = 22,
}

alias PGET_SYSTEM_WOW64_DIRECTORY_A = extern(Windows) uint function(const(char)* lpBuffer, uint uSize);
alias PGET_SYSTEM_WOW64_DIRECTORY_W = extern(Windows) uint function(const(wchar)* lpBuffer, uint uSize);
struct HW_PROFILE_INFOA
{
    uint dwDockInfo;
    byte szHwProfileGuid;
    byte szHwProfileName;
}

struct HW_PROFILE_INFOW
{
    uint dwDockInfo;
    ushort szHwProfileGuid;
    ushort szHwProfileName;
}

struct TIME_ZONE_INFORMATION
{
    int Bias;
    ushort StandardName;
    SYSTEMTIME StandardDate;
    int StandardBias;
    ushort DaylightName;
    SYSTEMTIME DaylightDate;
    int DaylightBias;
}

struct DYNAMIC_TIME_ZONE_INFORMATION
{
    int Bias;
    ushort StandardName;
    SYSTEMTIME StandardDate;
    int StandardBias;
    ushort DaylightName;
    SYSTEMTIME DaylightDate;
    int DaylightBias;
    ushort TimeZoneKeyName;
    ubyte DynamicDaylightTimeDisabled;
}

struct ACTCTX_SECTION_KEYED_DATA_2600
{
    uint cbSize;
    uint ulDataFormatVersion;
    void* lpData;
    uint ulLength;
    void* lpSectionGlobalData;
    uint ulSectionGlobalDataLength;
    void* lpSectionBase;
    uint ulSectionTotalLength;
    HANDLE hActCtx;
    uint ulAssemblyRosterIndex;
}

struct ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA
{
    void* lpInformation;
    void* lpSectionBase;
    uint ulSectionLength;
    void* lpSectionGlobalDataBase;
    uint ulSectionGlobalDataLength;
}

struct ACTIVATION_CONTEXT_BASIC_INFORMATION
{
    HANDLE hActCtx;
    uint dwFlags;
}

alias PQUERYACTCTXW_FUNC = extern(Windows) BOOL function(uint dwFlags, HANDLE hActCtx, void* pvSubInstance, uint ulInfoClass, char* pvBuffer, uint cbBuffer, uint* pcbWrittenOrRequired);
alias APPLICATION_RECOVERY_CALLBACK = extern(Windows) uint function(void* pvParameter);
struct FILE_CASE_SENSITIVE_INFO
{
    uint Flags;
}

struct FILE_DISPOSITION_INFO_EX
{
    uint Flags;
}

struct val_context
{
    int valuelen;
    void* value_context;
    void* val_buff_ptr;
}

struct pvalueA
{
    const(char)* pv_valuename;
    int pv_valuelen;
    void* pv_value_context;
    uint pv_type;
}

struct pvalueW
{
    const(wchar)* pv_valuename;
    int pv_valuelen;
    void* pv_value_context;
    uint pv_type;
}

alias QUERYHANDLER = extern(Windows) uint function(void* keycontext, val_context* val_list, uint num_vals, void* outputbuffer, uint* total_outlen, uint input_blen);
alias PQUERYHANDLER = extern(Windows) uint function();
struct provider_info
{
    PQUERYHANDLER pi_R0_1val;
    PQUERYHANDLER pi_R0_allvals;
    PQUERYHANDLER pi_R3_1val;
    PQUERYHANDLER pi_R3_allvals;
    uint pi_flags;
    void* pi_key_context;
}

struct VALENTA
{
    const(char)* ve_valuename;
    uint ve_valuelen;
    uint ve_valueptr;
    uint ve_type;
}

struct VALENTW
{
    const(wchar)* ve_valuename;
    uint ve_valuelen;
    uint ve_valueptr;
    uint ve_type;
}

const GUID CLSID_DOMDocument = {0x2933BF90, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF90, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
struct DOMDocument;

const GUID CLSID_DOMFreeThreadedDocument = {0x2933BF91, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF91, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
struct DOMFreeThreadedDocument;

const GUID CLSID_XMLHTTPRequest = {0xED8C108E, 0x4349, 0x11D2, [0x91, 0xA4, 0x00, 0xC0, 0x4F, 0x79, 0x69, 0xE8]};
@GUID(0xED8C108E, 0x4349, 0x11D2, [0x91, 0xA4, 0x00, 0xC0, 0x4F, 0x79, 0x69, 0xE8]);
struct XMLHTTPRequest;

const GUID CLSID_XMLDSOControl = {0x550DDA30, 0x0541, 0x11D2, [0x9C, 0xA9, 0x00, 0x60, 0xB0, 0xEC, 0x3D, 0x39]};
@GUID(0x550DDA30, 0x0541, 0x11D2, [0x9C, 0xA9, 0x00, 0x60, 0xB0, 0xEC, 0x3D, 0x39]);
struct XMLDSOControl;

const GUID CLSID_XMLDocument = {0xCFC399AF, 0xD876, 0x11D0, [0x9C, 0x10, 0x00, 0xC0, 0x4F, 0xC9, 0x9C, 0x8E]};
@GUID(0xCFC399AF, 0xD876, 0x11D0, [0x9C, 0x10, 0x00, 0xC0, 0x4F, 0xC9, 0x9C, 0x8E]);
struct XMLDocument;

struct XML_ERROR
{
    uint _nLine;
    BSTR _pchBuf;
    uint _cchBuf;
    uint _ich;
    BSTR _pszFound;
    BSTR _pszExpected;
    uint _reserved1;
    uint _reserved2;
}

enum DOMNodeType
{
    NODE_INVALID = 0,
    NODE_ELEMENT = 1,
    NODE_ATTRIBUTE = 2,
    NODE_TEXT = 3,
    NODE_CDATA_SECTION = 4,
    NODE_ENTITY_REFERENCE = 5,
    NODE_ENTITY = 6,
    NODE_PROCESSING_INSTRUCTION = 7,
    NODE_COMMENT = 8,
    NODE_DOCUMENT = 9,
    NODE_DOCUMENT_TYPE = 10,
    NODE_DOCUMENT_FRAGMENT = 11,
    NODE_NOTATION = 12,
}

enum XMLEMEM_TYPE
{
    XMLELEMTYPE_ELEMENT = 0,
    XMLELEMTYPE_TEXT = 1,
    XMLELEMTYPE_COMMENT = 2,
    XMLELEMTYPE_DOCUMENT = 3,
    XMLELEMTYPE_DTD = 4,
    XMLELEMTYPE_PI = 5,
    XMLELEMTYPE_OTHER = 6,
}

const GUID IID_IXMLDOMImplementation = {0x2933BF8F, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF8F, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMImplementation : IDispatch
{
    HRESULT hasFeature(BSTR feature, BSTR version, short* hasFeature);
}

const GUID IID_IXMLDOMNode = {0x2933BF80, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF80, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMNode : IDispatch
{
    HRESULT get_nodeName(BSTR* name);
    HRESULT get_nodeValue(VARIANT* value);
    HRESULT put_nodeValue(VARIANT value);
    HRESULT get_nodeType(DOMNodeType* type);
    HRESULT get_parentNode(IXMLDOMNode* parent);
    HRESULT get_childNodes(IXMLDOMNodeList* childList);
    HRESULT get_firstChild(IXMLDOMNode* firstChild);
    HRESULT get_lastChild(IXMLDOMNode* lastChild);
    HRESULT get_previousSibling(IXMLDOMNode* previousSibling);
    HRESULT get_nextSibling(IXMLDOMNode* nextSibling);
    HRESULT get_attributes(IXMLDOMNamedNodeMap* attributeMap);
    HRESULT insertBefore(IXMLDOMNode newChild, VARIANT refChild, IXMLDOMNode* outNewChild);
    HRESULT replaceChild(IXMLDOMNode newChild, IXMLDOMNode oldChild, IXMLDOMNode* outOldChild);
    HRESULT removeChild(IXMLDOMNode childNode, IXMLDOMNode* oldChild);
    HRESULT appendChild(IXMLDOMNode newChild, IXMLDOMNode* outNewChild);
    HRESULT hasChildNodes(short* hasChild);
    HRESULT get_ownerDocument(IXMLDOMDocument* XMLDOMDocument);
    HRESULT cloneNode(short deep, IXMLDOMNode* cloneRoot);
    HRESULT get_nodeTypeString(BSTR* nodeType);
    HRESULT get_text(BSTR* text);
    HRESULT put_text(BSTR text);
    HRESULT get_specified(short* isSpecified);
    HRESULT get_definition(IXMLDOMNode* definitionNode);
    HRESULT get_nodeTypedValue(VARIANT* typedValue);
    HRESULT put_nodeTypedValue(VARIANT typedValue);
    HRESULT get_dataType(VARIANT* dataTypeName);
    HRESULT put_dataType(BSTR dataTypeName);
    HRESULT get_xml(BSTR* xmlString);
    HRESULT transformNode(IXMLDOMNode stylesheet, BSTR* xmlString);
    HRESULT selectNodes(BSTR queryString, IXMLDOMNodeList* resultList);
    HRESULT selectSingleNode(BSTR queryString, IXMLDOMNode* resultNode);
    HRESULT get_parsed(short* isParsed);
    HRESULT get_namespaceURI(BSTR* namespaceURI);
    HRESULT get_prefix(BSTR* prefixString);
    HRESULT get_baseName(BSTR* nameString);
    HRESULT transformNodeToObject(IXMLDOMNode stylesheet, VARIANT outputObject);
}

const GUID IID_IXMLDOMDocumentFragment = {0x3EFAA413, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]};
@GUID(0x3EFAA413, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]);
interface IXMLDOMDocumentFragment : IXMLDOMNode
{
}

const GUID IID_IXMLDOMDocument = {0x2933BF81, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF81, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMDocument : IXMLDOMNode
{
    HRESULT get_doctype(IXMLDOMDocumentType* documentType);
    HRESULT get_implementation(IXMLDOMImplementation* impl);
    HRESULT get_documentElement(IXMLDOMElement* DOMElement);
    HRESULT putref_documentElement(IXMLDOMElement DOMElement);
    HRESULT createElement(BSTR tagName, IXMLDOMElement* element);
    HRESULT createDocumentFragment(IXMLDOMDocumentFragment* docFrag);
    HRESULT createTextNode(BSTR data, IXMLDOMText* text);
    HRESULT createComment(BSTR data, IXMLDOMComment* comment);
    HRESULT createCDATASection(BSTR data, IXMLDOMCDATASection* cdata);
    HRESULT createProcessingInstruction(BSTR target, BSTR data, IXMLDOMProcessingInstruction* pi);
    HRESULT createAttribute(BSTR name, IXMLDOMAttribute* attribute);
    HRESULT createEntityReference(BSTR name, IXMLDOMEntityReference* entityRef);
    HRESULT getElementsByTagName(BSTR tagName, IXMLDOMNodeList* resultList);
    HRESULT createNode(VARIANT Type, BSTR name, BSTR namespaceURI, IXMLDOMNode* node);
    HRESULT nodeFromID(BSTR idString, IXMLDOMNode* node);
    HRESULT load(VARIANT xmlSource, short* isSuccessful);
    HRESULT get_readyState(int* value);
    HRESULT get_parseError(IXMLDOMParseError* errorObj);
    HRESULT get_url(BSTR* urlString);
    HRESULT get_async(short* isAsync);
    HRESULT put_async(short isAsync);
    HRESULT abort();
    HRESULT loadXML(BSTR bstrXML, short* isSuccessful);
    HRESULT save(VARIANT destination);
    HRESULT get_validateOnParse(short* isValidating);
    HRESULT put_validateOnParse(short isValidating);
    HRESULT get_resolveExternals(short* isResolving);
    HRESULT put_resolveExternals(short isResolving);
    HRESULT get_preserveWhiteSpace(short* isPreserving);
    HRESULT put_preserveWhiteSpace(short isPreserving);
    HRESULT put_onreadystatechange(VARIANT readystatechangeSink);
    HRESULT put_ondataavailable(VARIANT ondataavailableSink);
    HRESULT put_ontransformnode(VARIANT ontransformnodeSink);
}

const GUID IID_IXMLDOMNodeList = {0x2933BF82, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF82, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMNodeList : IDispatch
{
    HRESULT get_item(int index, IXMLDOMNode* listItem);
    HRESULT get_length(int* listLength);
    HRESULT nextNode(IXMLDOMNode* nextItem);
    HRESULT reset();
    HRESULT get__newEnum(IUnknown* ppUnk);
}

const GUID IID_IXMLDOMNamedNodeMap = {0x2933BF83, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF83, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMNamedNodeMap : IDispatch
{
    HRESULT getNamedItem(BSTR name, IXMLDOMNode* namedItem);
    HRESULT setNamedItem(IXMLDOMNode newItem, IXMLDOMNode* nameItem);
    HRESULT removeNamedItem(BSTR name, IXMLDOMNode* namedItem);
    HRESULT get_item(int index, IXMLDOMNode* listItem);
    HRESULT get_length(int* listLength);
    HRESULT getQualifiedItem(BSTR baseName, BSTR namespaceURI, IXMLDOMNode* qualifiedItem);
    HRESULT removeQualifiedItem(BSTR baseName, BSTR namespaceURI, IXMLDOMNode* qualifiedItem);
    HRESULT nextNode(IXMLDOMNode* nextItem);
    HRESULT reset();
    HRESULT get__newEnum(IUnknown* ppUnk);
}

const GUID IID_IXMLDOMCharacterData = {0x2933BF84, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF84, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMCharacterData : IXMLDOMNode
{
    HRESULT get_data(BSTR* data);
    HRESULT put_data(BSTR data);
    HRESULT get_length(int* dataLength);
    HRESULT substringData(int offset, int count, BSTR* data);
    HRESULT appendData(BSTR data);
    HRESULT insertData(int offset, BSTR data);
    HRESULT deleteData(int offset, int count);
    HRESULT replaceData(int offset, int count, BSTR data);
}

const GUID IID_IXMLDOMAttribute = {0x2933BF85, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF85, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMAttribute : IXMLDOMNode
{
    HRESULT get_name(BSTR* attributeName);
    HRESULT get_value(VARIANT* attributeValue);
    HRESULT put_value(VARIANT attributeValue);
}

const GUID IID_IXMLDOMElement = {0x2933BF86, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF86, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMElement : IXMLDOMNode
{
    HRESULT get_tagName(BSTR* tagName);
    HRESULT getAttribute(BSTR name, VARIANT* value);
    HRESULT setAttribute(BSTR name, VARIANT value);
    HRESULT removeAttribute(BSTR name);
    HRESULT getAttributeNode(BSTR name, IXMLDOMAttribute* attributeNode);
    HRESULT setAttributeNode(IXMLDOMAttribute DOMAttribute, IXMLDOMAttribute* attributeNode);
    HRESULT removeAttributeNode(IXMLDOMAttribute DOMAttribute, IXMLDOMAttribute* attributeNode);
    HRESULT getElementsByTagName(BSTR tagName, IXMLDOMNodeList* resultList);
    HRESULT normalize();
}

const GUID IID_IXMLDOMText = {0x2933BF87, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF87, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMText : IXMLDOMCharacterData
{
    HRESULT splitText(int offset, IXMLDOMText* rightHandTextNode);
}

const GUID IID_IXMLDOMComment = {0x2933BF88, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF88, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMComment : IXMLDOMCharacterData
{
}

const GUID IID_IXMLDOMProcessingInstruction = {0x2933BF89, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF89, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMProcessingInstruction : IXMLDOMNode
{
    HRESULT get_target(BSTR* name);
    HRESULT get_data(BSTR* value);
    HRESULT put_data(BSTR value);
}

const GUID IID_IXMLDOMCDATASection = {0x2933BF8A, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF8A, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMCDATASection : IXMLDOMText
{
}

const GUID IID_IXMLDOMDocumentType = {0x2933BF8B, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF8B, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMDocumentType : IXMLDOMNode
{
    HRESULT get_name(BSTR* rootName);
    HRESULT get_entities(IXMLDOMNamedNodeMap* entityMap);
    HRESULT get_notations(IXMLDOMNamedNodeMap* notationMap);
}

const GUID IID_IXMLDOMNotation = {0x2933BF8C, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF8C, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMNotation : IXMLDOMNode
{
    HRESULT get_publicId(VARIANT* publicID);
    HRESULT get_systemId(VARIANT* systemID);
}

const GUID IID_IXMLDOMEntity = {0x2933BF8D, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF8D, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMEntity : IXMLDOMNode
{
    HRESULT get_publicId(VARIANT* publicID);
    HRESULT get_systemId(VARIANT* systemID);
    HRESULT get_notationName(BSTR* name);
}

const GUID IID_IXMLDOMEntityReference = {0x2933BF8E, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF8E, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMEntityReference : IXMLDOMNode
{
}

const GUID IID_IXMLDOMParseError = {0x3EFAA426, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]};
@GUID(0x3EFAA426, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]);
interface IXMLDOMParseError : IDispatch
{
    HRESULT get_errorCode(int* errorCode);
    HRESULT get_url(BSTR* urlString);
    HRESULT get_reason(BSTR* reasonString);
    HRESULT get_srcText(BSTR* sourceString);
    HRESULT get_line(int* lineNumber);
    HRESULT get_linepos(int* linePosition);
    HRESULT get_filepos(int* filePosition);
}

const GUID IID_IXTLRuntime = {0x3EFAA425, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]};
@GUID(0x3EFAA425, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]);
interface IXTLRuntime : IXMLDOMNode
{
    HRESULT uniqueID(IXMLDOMNode pNode, int* pID);
    HRESULT depth(IXMLDOMNode pNode, int* pDepth);
    HRESULT childNumber(IXMLDOMNode pNode, int* pNumber);
    HRESULT ancestorChildNumber(BSTR bstrNodeName, IXMLDOMNode pNode, int* pNumber);
    HRESULT absoluteChildNumber(IXMLDOMNode pNode, int* pNumber);
    HRESULT formatIndex(int lIndex, BSTR bstrFormat, BSTR* pbstrFormattedString);
    HRESULT formatNumber(double dblNumber, BSTR bstrFormat, BSTR* pbstrFormattedString);
    HRESULT formatDate(VARIANT varDate, BSTR bstrFormat, VARIANT varDestLocale, BSTR* pbstrFormattedString);
    HRESULT formatTime(VARIANT varTime, BSTR bstrFormat, VARIANT varDestLocale, BSTR* pbstrFormattedString);
}

const GUID IID_XMLDOMDocumentEvents = {0x3EFAA427, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]};
@GUID(0x3EFAA427, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]);
interface XMLDOMDocumentEvents : IDispatch
{
}

const GUID IID_IXMLHttpRequest = {0xED8C108D, 0x4349, 0x11D2, [0x91, 0xA4, 0x00, 0xC0, 0x4F, 0x79, 0x69, 0xE8]};
@GUID(0xED8C108D, 0x4349, 0x11D2, [0x91, 0xA4, 0x00, 0xC0, 0x4F, 0x79, 0x69, 0xE8]);
interface IXMLHttpRequest : IDispatch
{
    HRESULT open(BSTR bstrMethod, BSTR bstrUrl, VARIANT varAsync, VARIANT bstrUser, VARIANT bstrPassword);
    HRESULT setRequestHeader(BSTR bstrHeader, BSTR bstrValue);
    HRESULT getResponseHeader(BSTR bstrHeader, BSTR* pbstrValue);
    HRESULT getAllResponseHeaders(BSTR* pbstrHeaders);
    HRESULT send(VARIANT varBody);
    HRESULT abort();
    HRESULT get_status(int* plStatus);
    HRESULT get_statusText(BSTR* pbstrStatus);
    HRESULT get_responseXML(IDispatch* ppBody);
    HRESULT get_responseText(BSTR* pbstrBody);
    HRESULT get_responseBody(VARIANT* pvarBody);
    HRESULT get_responseStream(VARIANT* pvarBody);
    HRESULT get_readyState(int* plState);
    HRESULT put_onreadystatechange(IDispatch pReadyStateSink);
}

const GUID IID_IXMLDSOControl = {0x310AFA62, 0x0575, 0x11D2, [0x9C, 0xA9, 0x00, 0x60, 0xB0, 0xEC, 0x3D, 0x39]};
@GUID(0x310AFA62, 0x0575, 0x11D2, [0x9C, 0xA9, 0x00, 0x60, 0xB0, 0xEC, 0x3D, 0x39]);
interface IXMLDSOControl : IDispatch
{
    HRESULT get_XMLDocument(IXMLDOMDocument* ppDoc);
    HRESULT put_XMLDocument(IXMLDOMDocument ppDoc);
    HRESULT get_JavaDSOCompatible(int* fJavaDSOCompatible);
    HRESULT put_JavaDSOCompatible(BOOL fJavaDSOCompatible);
    HRESULT get_readyState(int* state);
}

const GUID IID_IXMLElementCollection = {0x65725580, 0x9B5D, 0x11D0, [0x9B, 0xFE, 0x00, 0xC0, 0x4F, 0xC9, 0x9C, 0x8E]};
@GUID(0x65725580, 0x9B5D, 0x11D0, [0x9B, 0xFE, 0x00, 0xC0, 0x4F, 0xC9, 0x9C, 0x8E]);
interface IXMLElementCollection : IDispatch
{
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* ppUnk);
    HRESULT item(VARIANT var1, VARIANT var2, IDispatch* ppDisp);
}

const GUID IID_IXMLDocument = {0xF52E2B61, 0x18A1, 0x11D1, [0xB1, 0x05, 0x00, 0x80, 0x5F, 0x49, 0x91, 0x6B]};
@GUID(0xF52E2B61, 0x18A1, 0x11D1, [0xB1, 0x05, 0x00, 0x80, 0x5F, 0x49, 0x91, 0x6B]);
interface IXMLDocument : IDispatch
{
    HRESULT get_root(IXMLElement* p);
    HRESULT get_fileSize(BSTR* p);
    HRESULT get_fileModifiedDate(BSTR* p);
    HRESULT get_fileUpdatedDate(BSTR* p);
    HRESULT get_URL(BSTR* p);
    HRESULT put_URL(BSTR p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_readyState(int* pl);
    HRESULT get_charset(BSTR* p);
    HRESULT put_charset(BSTR p);
    HRESULT get_version(BSTR* p);
    HRESULT get_doctype(BSTR* p);
    HRESULT get_dtdURL(BSTR* p);
    HRESULT createElement(VARIANT vType, VARIANT var1, IXMLElement* ppElem);
}

const GUID IID_IXMLDocument2 = {0x2B8DE2FE, 0x8D2D, 0x11D1, [0xB2, 0xFC, 0x00, 0xC0, 0x4F, 0xD9, 0x15, 0xA9]};
@GUID(0x2B8DE2FE, 0x8D2D, 0x11D1, [0xB2, 0xFC, 0x00, 0xC0, 0x4F, 0xD9, 0x15, 0xA9]);
interface IXMLDocument2 : IDispatch
{
    HRESULT get_root(IXMLElement2* p);
    HRESULT get_fileSize(BSTR* p);
    HRESULT get_fileModifiedDate(BSTR* p);
    HRESULT get_fileUpdatedDate(BSTR* p);
    HRESULT get_URL(BSTR* p);
    HRESULT put_URL(BSTR p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_readyState(int* pl);
    HRESULT get_charset(BSTR* p);
    HRESULT put_charset(BSTR p);
    HRESULT get_version(BSTR* p);
    HRESULT get_doctype(BSTR* p);
    HRESULT get_dtdURL(BSTR* p);
    HRESULT createElement(VARIANT vType, VARIANT var1, IXMLElement2* ppElem);
    HRESULT get_async(short* pf);
    HRESULT put_async(short f);
}

const GUID IID_IXMLElement = {0x3F7F31AC, 0xE15F, 0x11D0, [0x9C, 0x25, 0x00, 0xC0, 0x4F, 0xC9, 0x9C, 0x8E]};
@GUID(0x3F7F31AC, 0xE15F, 0x11D0, [0x9C, 0x25, 0x00, 0xC0, 0x4F, 0xC9, 0x9C, 0x8E]);
interface IXMLElement : IDispatch
{
    HRESULT get_tagName(BSTR* p);
    HRESULT put_tagName(BSTR p);
    HRESULT get_parent(IXMLElement* ppParent);
    HRESULT setAttribute(BSTR strPropertyName, VARIANT PropertyValue);
    HRESULT getAttribute(BSTR strPropertyName, VARIANT* PropertyValue);
    HRESULT removeAttribute(BSTR strPropertyName);
    HRESULT get_children(IXMLElementCollection* pp);
    HRESULT get_type(int* plType);
    HRESULT get_text(BSTR* p);
    HRESULT put_text(BSTR p);
    HRESULT addChild(IXMLElement pChildElem, int lIndex, int lReserved);
    HRESULT removeChild(IXMLElement pChildElem);
}

const GUID IID_IXMLElement2 = {0x2B8DE2FF, 0x8D2D, 0x11D1, [0xB2, 0xFC, 0x00, 0xC0, 0x4F, 0xD9, 0x15, 0xA9]};
@GUID(0x2B8DE2FF, 0x8D2D, 0x11D1, [0xB2, 0xFC, 0x00, 0xC0, 0x4F, 0xD9, 0x15, 0xA9]);
interface IXMLElement2 : IDispatch
{
    HRESULT get_tagName(BSTR* p);
    HRESULT put_tagName(BSTR p);
    HRESULT get_parent(IXMLElement2* ppParent);
    HRESULT setAttribute(BSTR strPropertyName, VARIANT PropertyValue);
    HRESULT getAttribute(BSTR strPropertyName, VARIANT* PropertyValue);
    HRESULT removeAttribute(BSTR strPropertyName);
    HRESULT get_children(IXMLElementCollection* pp);
    HRESULT get_type(int* plType);
    HRESULT get_text(BSTR* p);
    HRESULT put_text(BSTR p);
    HRESULT addChild(IXMLElement2 pChildElem, int lIndex, int lReserved);
    HRESULT removeChild(IXMLElement2 pChildElem);
    HRESULT get_attributes(IXMLElementCollection* pp);
}

const GUID IID_IXMLAttribute = {0xD4D4A0FC, 0x3B73, 0x11D1, [0xB2, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0x96]};
@GUID(0xD4D4A0FC, 0x3B73, 0x11D1, [0xB2, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0x96]);
interface IXMLAttribute : IDispatch
{
    HRESULT get_name(BSTR* n);
    HRESULT get_value(BSTR* v);
}

const GUID IID_IXMLError = {0x948C5AD3, 0xC58D, 0x11D0, [0x9C, 0x0B, 0x00, 0xC0, 0x4F, 0xC9, 0x9C, 0x8E]};
@GUID(0x948C5AD3, 0xC58D, 0x11D0, [0x9C, 0x0B, 0x00, 0xC0, 0x4F, 0xC9, 0x9C, 0x8E]);
interface IXMLError : IUnknown
{
    HRESULT GetErrorInfo(XML_ERROR* pErrorReturn);
}

struct CLIENT_ID
{
    HANDLE UniqueProcess;
    HANDLE UniqueThread;
}

struct LDR_DATA_TABLE_ENTRY
{
    void* Reserved1;
    LIST_ENTRY InMemoryOrderLinks;
    void* Reserved2;
    void* DllBase;
    void* Reserved3;
    UNICODE_STRING FullDllName;
    ubyte Reserved4;
    void* Reserved5;
    _Anonymous_e__Union Anonymous;
    uint TimeDateStamp;
}

alias PPS_POST_PROCESS_INIT_ROUTINE = extern(Windows) void function();
struct OBJECT_ATTRIBUTES
{
    uint Length;
    HANDLE RootDirectory;
    UNICODE_STRING* ObjectName;
    uint Attributes;
    void* SecurityDescriptor;
    void* SecurityQualityOfService;
}

struct IO_STATUS_BLOCK
{
    _Anonymous_e__Union Anonymous;
    uint Information;
}

alias PIO_APC_ROUTINE = extern(Windows) void function(void* ApcContext, IO_STATUS_BLOCK* IoStatusBlock, uint Reserved);
struct PROCESS_BASIC_INFORMATION
{
    void* Reserved1;
    PEB* PebBaseAddress;
    void* Reserved2;
    uint UniqueProcessId;
    void* Reserved3;
}

struct SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION
{
    LARGE_INTEGER IdleTime;
    LARGE_INTEGER KernelTime;
    LARGE_INTEGER UserTime;
    LARGE_INTEGER Reserved1;
    uint Reserved2;
}

struct SYSTEM_PROCESS_INFORMATION
{
    uint NextEntryOffset;
    uint NumberOfThreads;
    ubyte Reserved1;
    UNICODE_STRING ImageName;
    int BasePriority;
    HANDLE UniqueProcessId;
    void* Reserved2;
    uint HandleCount;
    uint SessionId;
    void* Reserved3;
    uint PeakVirtualSize;
    uint VirtualSize;
    uint Reserved4;
    uint PeakWorkingSetSize;
    uint WorkingSetSize;
    void* Reserved5;
    uint QuotaPagedPoolUsage;
    void* Reserved6;
    uint QuotaNonPagedPoolUsage;
    uint PagefileUsage;
    uint PeakPagefileUsage;
    uint PrivatePageCount;
    LARGE_INTEGER Reserved7;
}

struct SYSTEM_THREAD_INFORMATION
{
    LARGE_INTEGER Reserved1;
    uint Reserved2;
    void* StartAddress;
    CLIENT_ID ClientId;
    int Priority;
    int BasePriority;
    uint Reserved3;
    uint ThreadState;
    uint WaitReason;
}

struct SYSTEM_REGISTRY_QUOTA_INFORMATION
{
    uint RegistryQuotaAllowed;
    uint RegistryQuotaUsed;
    void* Reserved1;
}

struct SYSTEM_BASIC_INFORMATION
{
    ubyte Reserved1;
    void* Reserved2;
    byte NumberOfProcessors;
}

struct SYSTEM_TIMEOFDAY_INFORMATION
{
    ubyte Reserved1;
}

struct SYSTEM_PERFORMANCE_INFORMATION
{
    ubyte Reserved1;
}

struct SYSTEM_EXCEPTION_INFORMATION
{
    ubyte Reserved1;
}

struct SYSTEM_LOOKASIDE_INFORMATION
{
    ubyte Reserved1;
}

struct SYSTEM_INTERRUPT_INFORMATION
{
    ubyte Reserved1;
}

struct SYSTEM_POLICY_INFORMATION
{
    void* Reserved1;
    uint Reserved2;
}

enum FILE_INFORMATION_CLASS
{
    FileDirectoryInformation = 1,
}

enum PROCESSINFOCLASS
{
    ProcessBasicInformation = 0,
    ProcessDebugPort = 7,
    ProcessWow64Information = 26,
    ProcessImageFileName = 27,
    ProcessBreakOnTermination = 29,
}

enum THREADINFOCLASS
{
    ThreadIsIoPending = 16,
}

struct SYSTEM_CODEINTEGRITY_INFORMATION
{
    uint Length;
    uint CodeIntegrityOptions;
}

enum SYSTEM_INFORMATION_CLASS
{
    SystemBasicInformation = 0,
    SystemPerformanceInformation = 2,
    SystemTimeOfDayInformation = 3,
    SystemProcessInformation = 5,
    SystemProcessorPerformanceInformation = 8,
    SystemInterruptInformation = 23,
    SystemExceptionInformation = 33,
    SystemRegistryQuotaInformation = 37,
    SystemLookasideInformation = 45,
    SystemCodeIntegrityInformation = 103,
    SystemPolicyInformation = 134,
}

enum OBJECT_INFORMATION_CLASS
{
    ObjectBasicInformation = 0,
    ObjectTypeInformation = 2,
}

struct PUBLIC_OBJECT_BASIC_INFORMATION
{
    uint Attributes;
    uint GrantedAccess;
    uint HandleCount;
    uint PointerCount;
    uint Reserved;
}

struct __PUBLIC_OBJECT_TYPE_INFORMATION
{
    UNICODE_STRING TypeName;
    uint Reserved;
}

struct KEY_VALUE_ENTRY
{
    UNICODE_STRING* ValueName;
    uint DataLength;
    uint DataOffset;
    uint Type;
}

enum KEY_SET_INFORMATION_CLASS
{
    KeyWriteTimeInformation = 0,
    KeyWow64FlagsInformation = 1,
    KeyControlFlagsInformation = 2,
    KeySetVirtualizationInformation = 3,
    KeySetDebugInformation = 4,
    KeySetHandleTagsInformation = 5,
    MaxKeySetInfoClass = 6,
}

enum WINSTATIONINFOCLASS
{
    WinStationInformation = 8,
}

struct WINSTATIONINFORMATIONW
{
    ubyte Reserved2;
    uint LogonId;
    ubyte Reserved3;
}

alias PWINSTATIONQUERYINFORMATIONW = extern(Windows) ubyte function(HANDLE param0, uint param1, WINSTATIONINFOCLASS param2, void* param3, uint param4, uint* param5);
struct AVRF_BACKTRACE_INFORMATION
{
    uint Depth;
    uint Index;
    ulong ReturnAddresses;
}

enum eUserAllocationState
{
    AllocationStateUnknown = 0,
    AllocationStateBusy = 1,
    AllocationStateFree = 2,
}

enum eHeapAllocationState
{
    HeapFullPageHeap = 1073741824,
    HeapMetadata = -2147483648,
    HeapStateMask = -65536,
}

enum eHeapEnumerationLevel
{
    HeapEnumerationEverything = 0,
    HeapEnumerationStop = -1,
}

struct AVRF_HEAP_ALLOCATION
{
    ulong HeapHandle;
    ulong UserAllocation;
    ulong UserAllocationSize;
    ulong Allocation;
    ulong AllocationSize;
    uint UserAllocationState;
    uint HeapState;
    ulong HeapContext;
    AVRF_BACKTRACE_INFORMATION* BackTraceInformation;
}

enum eHANDLE_TRACE_OPERATIONS
{
    OperationDbUnused = 0,
    OperationDbOPEN = 1,
    OperationDbCLOSE = 2,
    OperationDbBADREF = 3,
}

struct AVRF_HANDLE_OPERATION
{
    ulong Handle;
    uint ProcessId;
    uint ThreadId;
    uint OperationType;
    uint Spare0;
    AVRF_BACKTRACE_INFORMATION BackTraceInformation;
}

enum eAvrfResourceTypes
{
    AvrfResourceHeapAllocation = 0,
    AvrfResourceHandleTrace = 1,
    AvrfResourceMax = 2,
}

alias AVRF_RESOURCE_ENUMERATE_CALLBACK = extern(Windows) uint function(void* ResourceDescription, void* EnumerationContext, uint* EnumerationLevel);
alias AVRF_HEAPALLOCATION_ENUMERATE_CALLBACK = extern(Windows) uint function(AVRF_HEAP_ALLOCATION* HeapAllocation, void* EnumerationContext, uint* EnumerationLevel);
alias AVRF_HANDLEOPERATION_ENUMERATE_CALLBACK = extern(Windows) uint function(AVRF_HANDLE_OPERATION* HandleOperation, void* EnumerationContext, uint* EnumerationLevel);
const GUID CLSID_CameraUIControl = {0x16D5A2BE, 0xB1C5, 0x47B3, [0x8E, 0xAE, 0xCC, 0xBC, 0xF4, 0x52, 0xC7, 0xE8]};
@GUID(0x16D5A2BE, 0xB1C5, 0x47B3, [0x8E, 0xAE, 0xCC, 0xBC, 0xF4, 0x52, 0xC7, 0xE8]);
struct CameraUIControl;

enum CameraUIControlMode
{
    Browse = 0,
    Linear = 1,
}

enum CameraUIControlLinearSelectionMode
{
    Single = 0,
    Multiple = 1,
}

enum CameraUIControlCaptureMode
{
    PhotoOrVideo = 0,
    Photo = 1,
    Video = 2,
}

enum CameraUIControlPhotoFormat
{
    Jpeg = 0,
    Png = 1,
    JpegXR = 2,
}

enum CameraUIControlVideoFormat
{
    Mp4 = 0,
    Wmv = 1,
}

enum CameraUIControlViewType
{
    SingleItem = 0,
    ItemList = 1,
}

const GUID IID_ICameraUIControlEventCallback = {0x1BFA0C2C, 0xFBCD, 0x4776, [0xBD, 0xA4, 0x88, 0xBF, 0x97, 0x4E, 0x74, 0xF4]};
@GUID(0x1BFA0C2C, 0xFBCD, 0x4776, [0xBD, 0xA4, 0x88, 0xBF, 0x97, 0x4E, 0x74, 0xF4]);
interface ICameraUIControlEventCallback : IUnknown
{
    void OnStartupComplete();
    void OnSuspendComplete();
    void OnItemCaptured(const(wchar)* pszPath);
    void OnItemDeleted(const(wchar)* pszPath);
    void OnClosed();
}

const GUID IID_ICameraUIControl = {0xB8733ADF, 0x3D68, 0x4B8F, [0xBB, 0x08, 0xE2, 0x8A, 0x0B, 0xED, 0x03, 0x76]};
@GUID(0xB8733ADF, 0x3D68, 0x4B8F, [0xBB, 0x08, 0xE2, 0x8A, 0x0B, 0xED, 0x03, 0x76]);
interface ICameraUIControl : IUnknown
{
    HRESULT Show(IUnknown pWindow, CameraUIControlMode mode, CameraUIControlLinearSelectionMode selectionMode, CameraUIControlCaptureMode captureMode, CameraUIControlPhotoFormat photoFormat, CameraUIControlVideoFormat videoFormat, BOOL bHasCloseButton, ICameraUIControlEventCallback pEventCallback);
    HRESULT Close();
    HRESULT Suspend(int* pbDeferralRequired);
    HRESULT Resume();
    HRESULT GetCurrentViewType(CameraUIControlViewType* pViewType);
    HRESULT GetActiveItem(BSTR* pbstrActiveItemPath);
    HRESULT GetSelectedItems(SAFEARRAY** ppSelectedItemPaths);
    HRESULT RemoveCapturedItem(const(wchar)* pszPath);
}

struct ERF
{
    int erfOper;
    int erfType;
    BOOL fError;
}

enum FCIERROR
{
    FCIERR_NONE = 0,
    FCIERR_OPEN_SRC = 1,
    FCIERR_READ_SRC = 2,
    FCIERR_ALLOC_FAIL = 3,
    FCIERR_TEMP_FILE = 4,
    FCIERR_BAD_COMPR_TYPE = 5,
    FCIERR_CAB_FILE = 6,
    FCIERR_USER_ABORT = 7,
    FCIERR_MCI_FAIL = 8,
    FCIERR_CAB_FORMAT_LIMIT = 9,
}

struct CCAB
{
    uint cb;
    uint cbFolderThresh;
    uint cbReserveCFHeader;
    uint cbReserveCFFolder;
    uint cbReserveCFData;
    int iCab;
    int iDisk;
    int fFailOnIncompressible;
    ushort setID;
    byte szDisk;
    byte szCab;
    byte szCabPath;
}

alias PFNFCIALLOC = extern(Windows) void* function(uint cb);
alias PFNFCIFREE = extern(Windows) void function(void* memory);
alias PFNFCIOPEN = extern(Windows) int function(const(char)* pszFile, int oflag, int pmode, int* err, void* pv);
alias PFNFCIREAD = extern(Windows) uint function(int hf, void* memory, uint cb, int* err, void* pv);
alias PFNFCIWRITE = extern(Windows) uint function(int hf, void* memory, uint cb, int* err, void* pv);
alias PFNFCICLOSE = extern(Windows) int function(int hf, int* err, void* pv);
alias PFNFCISEEK = extern(Windows) int function(int hf, int dist, int seektype, int* err, void* pv);
alias PFNFCIDELETE = extern(Windows) int function(const(char)* pszFile, int* err, void* pv);
alias PFNFCIGETNEXTCABINET = extern(Windows) BOOL function(CCAB* pccab, uint cbPrevCab, void* pv);
alias PFNFCIFILEPLACED = extern(Windows) int function(CCAB* pccab, const(char)* pszFile, int cbFile, BOOL fContinuation, void* pv);
alias PFNFCIGETOPENINFO = extern(Windows) int function(const(char)* pszName, ushort* pdate, ushort* ptime, ushort* pattribs, int* err, void* pv);
alias PFNFCISTATUS = extern(Windows) int function(uint typeStatus, uint cb1, uint cb2, void* pv);
alias PFNFCIGETTEMPFILE = extern(Windows) BOOL function(char* pszTempName, int cbTempName, void* pv);
enum FDIERROR
{
    FDIERROR_NONE = 0,
    FDIERROR_CABINET_NOT_FOUND = 1,
    FDIERROR_NOT_A_CABINET = 2,
    FDIERROR_UNKNOWN_CABINET_VERSION = 3,
    FDIERROR_CORRUPT_CABINET = 4,
    FDIERROR_ALLOC_FAIL = 5,
    FDIERROR_BAD_COMPR_TYPE = 6,
    FDIERROR_MDI_FAIL = 7,
    FDIERROR_TARGET_FILE = 8,
    FDIERROR_RESERVE_MISMATCH = 9,
    FDIERROR_WRONG_CABINET = 10,
    FDIERROR_USER_ABORT = 11,
    FDIERROR_EOF = 12,
}

struct FDICABINETINFO
{
    int cbCabinet;
    ushort cFolders;
    ushort cFiles;
    ushort setID;
    ushort iCabinet;
    BOOL fReserve;
    BOOL hasprev;
    BOOL hasnext;
}

enum FDIDECRYPTTYPE
{
    fdidtNEW_CABINET = 0,
    fdidtNEW_FOLDER = 1,
    fdidtDECRYPT = 2,
}

struct FDIDECRYPT
{
    FDIDECRYPTTYPE fdidt;
    void* pvUser;
    _Anonymous_e__Union Anonymous;
}

alias PFNALLOC = extern(Windows) void* function(uint cb);
alias PFNFREE = extern(Windows) void function(void* pv);
alias PFNOPEN = extern(Windows) int function(const(char)* pszFile, int oflag, int pmode);
alias PFNREAD = extern(Windows) uint function(int hf, char* pv, uint cb);
alias PFNWRITE = extern(Windows) uint function(int hf, char* pv, uint cb);
alias PFNCLOSE = extern(Windows) int function(int hf);
alias PFNSEEK = extern(Windows) int function(int hf, int dist, int seektype);
alias PFNFDIDECRYPT = extern(Windows) int function(FDIDECRYPT* pfdid);
struct FDINOTIFICATION
{
    int cb;
    byte* psz1;
    byte* psz2;
    byte* psz3;
    void* pv;
    int hf;
    ushort date;
    ushort time;
    ushort attribs;
    ushort setID;
    ushort iCabinet;
    ushort iFolder;
    FDIERROR fdie;
}

enum FDINOTIFICATIONTYPE
{
    fdintCABINET_INFO = 0,
    fdintPARTIAL_FILE = 1,
    fdintCOPY_FILE = 2,
    fdintCLOSE_FILE_INFO = 3,
    fdintNEXT_CABINET = 4,
    fdintENUMERATE = 5,
}

alias PFNFDINOTIFY = extern(Windows) int function(FDINOTIFICATIONTYPE fdint, FDINOTIFICATION* pfdin);
struct FDISPILLFILE
{
    byte ach;
    int cbFile;
}

struct VDMCONTEXT_WITHOUT_XSAVE
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
}

struct SEGMENT_NOTE
{
    ushort Selector1;
    ushort Selector2;
    ushort Segment;
    byte Module;
    byte FileName;
    ushort Type;
    uint Length;
}

struct IMAGE_NOTE
{
    byte Module;
    byte FileName;
    ushort hModule;
    ushort hTask;
}

struct MODULEENTRY
{
    uint dwSize;
    byte szModule;
    HANDLE hModule;
    ushort wcUsage;
    byte szExePath;
    ushort wNext;
}

struct TEMP_BP_NOTE
{
    ushort Seg;
    uint Offset;
    BOOL bPM;
}

struct VDM_SEGINFO
{
    ushort Selector;
    ushort SegNumber;
    uint Length;
    ushort Type;
    byte ModuleName;
    byte FileName;
}

struct GLOBALENTRY
{
    uint dwSize;
    uint dwAddress;
    uint dwBlockSize;
    HANDLE hBlock;
    ushort wcLock;
    ushort wcPageLock;
    ushort wFlags;
    BOOL wHeapPresent;
    HANDLE hOwner;
    ushort wType;
    ushort wData;
    uint dwNext;
    uint dwNextAlt;
}

alias DEBUGEVENTPROC = extern(Windows) uint function(DEBUG_EVENT* param0, void* param1);
alias PROCESSENUMPROC = extern(Windows) BOOL function(uint dwProcessId, uint dwAttributes, LPARAM lpUserDefined);
alias TASKENUMPROC = extern(Windows) BOOL function(uint dwThreadId, ushort hMod16, ushort hTask16, LPARAM lpUserDefined);
alias TASKENUMPROCEX = extern(Windows) BOOL function(uint dwThreadId, ushort hMod16, ushort hTask16, byte* pszModName, byte* pszFileName, LPARAM lpUserDefined);
alias VDMPROCESSEXCEPTIONPROC = extern(Windows) BOOL function(DEBUG_EVENT* param0);
alias VDMGETTHREADSELECTORENTRYPROC = extern(Windows) BOOL function(HANDLE param0, HANDLE param1, uint param2, LDT_ENTRY* param3);
alias VDMGETPOINTERPROC = extern(Windows) uint function(HANDLE param0, HANDLE param1, ushort param2, uint param3, BOOL param4);
alias VDMGETCONTEXTPROC = extern(Windows) BOOL function(HANDLE param0, HANDLE param1, CONTEXT* param2);
alias VDMSETCONTEXTPROC = extern(Windows) BOOL function(HANDLE param0, HANDLE param1, CONTEXT* param2);
alias VDMKILLWOWPROC = extern(Windows) BOOL function();
alias VDMDETECTWOWPROC = extern(Windows) BOOL function();
alias VDMBREAKTHREADPROC = extern(Windows) BOOL function(HANDLE param0);
alias VDMGETSELECTORMODULEPROC = extern(Windows) BOOL function(HANDLE param0, HANDLE param1, ushort param2, uint* param3, const(char)* param4, uint param5, const(char)* param6, uint param7);
alias VDMGETMODULESELECTORPROC = extern(Windows) BOOL function(HANDLE param0, HANDLE param1, uint param2, const(char)* param3, ushort* param4);
alias VDMMODULEFIRSTPROC = extern(Windows) BOOL function(HANDLE param0, HANDLE param1, MODULEENTRY* param2, DEBUGEVENTPROC param3, void* param4);
alias VDMMODULENEXTPROC = extern(Windows) BOOL function(HANDLE param0, HANDLE param1, MODULEENTRY* param2, DEBUGEVENTPROC param3, void* param4);
alias VDMGLOBALFIRSTPROC = extern(Windows) BOOL function(HANDLE param0, HANDLE param1, GLOBALENTRY* param2, ushort param3, DEBUGEVENTPROC param4, void* param5);
alias VDMGLOBALNEXTPROC = extern(Windows) BOOL function(HANDLE param0, HANDLE param1, GLOBALENTRY* param2, ushort param3, DEBUGEVENTPROC param4, void* param5);
alias VDMENUMPROCESSWOWPROC = extern(Windows) int function(PROCESSENUMPROC param0, LPARAM param1);
alias VDMENUMTASKWOWPROC = extern(Windows) int function(uint param0, TASKENUMPROC param1, LPARAM param2);
alias VDMENUMTASKWOWEXPROC = extern(Windows) int function(uint param0, TASKENUMPROCEX param1, LPARAM param2);
alias VDMTERMINATETASKINWOWPROC = extern(Windows) BOOL function(uint param0, ushort param1);
alias VDMSTARTTASKINWOWPROC = extern(Windows) BOOL function(uint param0, const(char)* param1, ushort param2);
alias VDMGETDBGFLAGSPROC = extern(Windows) uint function(HANDLE param0);
alias VDMSETDBGFLAGSPROC = extern(Windows) BOOL function(HANDLE param0, uint param1);
alias VDMISMODULELOADEDPROC = extern(Windows) BOOL function(const(char)* param0);
alias VDMGETSEGMENTINFOPROC = extern(Windows) BOOL function(ushort param0, uint param1, BOOL param2, VDM_SEGINFO param3);
alias VDMGETSYMBOLPROC = extern(Windows) BOOL function(const(char)* param0, ushort param1, uint param2, BOOL param3, BOOL param4, const(char)* param5, uint* param6);
alias VDMGETADDREXPRESSIONPROC = extern(Windows) BOOL function(const(char)* param0, const(char)* param1, ushort* param2, uint* param3, ushort* param4);
const GUID CLSID_EditionUpgradeHelper = {0x01776DF3, 0xB9AF, 0x4E50, [0x9B, 0x1C, 0x56, 0xE9, 0x31, 0x16, 0xD7, 0x04]};
@GUID(0x01776DF3, 0xB9AF, 0x4E50, [0x9B, 0x1C, 0x56, 0xE9, 0x31, 0x16, 0xD7, 0x04]);
struct EditionUpgradeHelper;

const GUID CLSID_EditionUpgradeBroker = {0xC4270827, 0x4F39, 0x45DF, [0x92, 0x88, 0x12, 0xFF, 0x6B, 0x85, 0xA9, 0x21]};
@GUID(0xC4270827, 0x4F39, 0x45DF, [0x92, 0x88, 0x12, 0xFF, 0x6B, 0x85, 0xA9, 0x21]);
struct EditionUpgradeBroker;

const GUID IID_IEditionUpgradeHelper = {0xD3E9E342, 0x5DEB, 0x43B6, [0x84, 0x9E, 0x69, 0x13, 0xB8, 0x5D, 0x50, 0x3A]};
@GUID(0xD3E9E342, 0x5DEB, 0x43B6, [0x84, 0x9E, 0x69, 0x13, 0xB8, 0x5D, 0x50, 0x3A]);
interface IEditionUpgradeHelper : IUnknown
{
    HRESULT CanUpgrade(int* isAllowed);
    HRESULT UpdateOperatingSystem(const(wchar)* contentId);
    HRESULT ShowProductKeyUI();
    HRESULT GetOsProductContentId(ushort** contentId);
    HRESULT GetGenuineLocalStatus(int* isGenuine);
}

const GUID IID_IWindowsLockModeHelper = {0xF342D19E, 0xCC22, 0x4648, [0xBB, 0x5D, 0x03, 0xCC, 0xF7, 0x5B, 0x47, 0xC5]};
@GUID(0xF342D19E, 0xCC22, 0x4648, [0xBB, 0x5D, 0x03, 0xCC, 0xF7, 0x5B, 0x47, 0xC5]);
interface IWindowsLockModeHelper : IUnknown
{
    HRESULT GetSMode(int* isSmode);
}

const GUID IID_IEditionUpgradeBroker = {0xFF19CBCF, 0x9455, 0x4937, [0xB8, 0x72, 0x6B, 0x79, 0x29, 0xA4, 0x60, 0xAF]};
@GUID(0xFF19CBCF, 0x9455, 0x4937, [0xB8, 0x72, 0x6B, 0x79, 0x29, 0xA4, 0x60, 0xAF]);
interface IEditionUpgradeBroker : IUnknown
{
    HRESULT InitializeParentWindow(uint parentHandle);
    HRESULT UpdateOperatingSystem(BSTR parameter);
    HRESULT ShowProductKeyUI();
    HRESULT CanUpgrade();
}

const GUID IID_IContainerActivationHelper = {0xB524F93F, 0x80D5, 0x4EC7, [0xAE, 0x9E, 0xD6, 0x6E, 0x93, 0xAD, 0xE1, 0xFA]};
@GUID(0xB524F93F, 0x80D5, 0x4EC7, [0xAE, 0x9E, 0xD6, 0x6E, 0x93, 0xAD, 0xE1, 0xFA]);
interface IContainerActivationHelper : IUnknown
{
    HRESULT CanActivateClientVM(short* isAllowed);
}

const GUID IID_IClipServiceNotificationHelper = {0xC39948F0, 0x6142, 0x44FD, [0x98, 0xCA, 0xE1, 0x68, 0x1A, 0x8D, 0x68, 0xB5]};
@GUID(0xC39948F0, 0x6142, 0x44FD, [0x98, 0xCA, 0xE1, 0x68, 0x1A, 0x8D, 0x68, 0xB5]);
interface IClipServiceNotificationHelper : IUnknown
{
    HRESULT ShowToast(BSTR titleText, BSTR bodyText, BSTR packageName, BSTR appId, BSTR launchCommand);
}

enum FEATURE_CHANGE_TIME
{
    FEATURE_CHANGE_TIME_READ = 0,
    FEATURE_CHANGE_TIME_MODULE_RELOAD = 1,
    FEATURE_CHANGE_TIME_SESSION = 2,
    FEATURE_CHANGE_TIME_REBOOT = 3,
}

enum FEATURE_ENABLED_STATE
{
    FEATURE_ENABLED_STATE_DEFAULT = 0,
    FEATURE_ENABLED_STATE_DISABLED = 1,
    FEATURE_ENABLED_STATE_ENABLED = 2,
}

struct FEATURE_ERROR
{
    HRESULT hr;
    ushort lineNumber;
    const(char)* file;
    const(char)* process;
    const(char)* module;
    uint callerReturnAddressOffset;
    const(char)* callerModule;
    const(char)* message;
    ushort originLineNumber;
    const(char)* originFile;
    const(char)* originModule;
    uint originCallerReturnAddressOffset;
    const(char)* originCallerModule;
    const(char)* originName;
}

struct FEATURE_STATE_CHANGE_SUBSCRIPTION__
{
    int unused;
}

alias FEATURE_STATE_CHANGE_CALLBACK = extern(Windows) void function(void* context);
alias PFEATURE_STATE_CHANGE_CALLBACK = extern(Windows) void function();
const GUID CLSID_FhConfigMgr = {0xED43BB3C, 0x09E9, 0x498A, [0x9D, 0xF6, 0x21, 0x77, 0x24, 0x4C, 0x6D, 0xB4]};
@GUID(0xED43BB3C, 0x09E9, 0x498A, [0x9D, 0xF6, 0x21, 0x77, 0x24, 0x4C, 0x6D, 0xB4]);
struct FhConfigMgr;

const GUID CLSID_FhReassociation = {0x4D728E35, 0x16FA, 0x4320, [0x9E, 0x8B, 0xBF, 0xD7, 0x10, 0x0A, 0x88, 0x46]};
@GUID(0x4D728E35, 0x16FA, 0x4320, [0x9E, 0x8B, 0xBF, 0xD7, 0x10, 0x0A, 0x88, 0x46]);
struct FhReassociation;

enum FH_TARGET_PROPERTY_TYPE
{
    FH_TARGET_NAME = 0,
    FH_TARGET_URL = 1,
    FH_TARGET_DRIVE_TYPE = 2,
    MAX_TARGET_PROPERTY = 3,
}

enum FH_TARGET_DRIVE_TYPES
{
    FH_DRIVE_UNKNOWN = 0,
    FH_DRIVE_REMOVABLE = 2,
    FH_DRIVE_FIXED = 3,
    FH_DRIVE_REMOTE = 4,
}

const GUID IID_IFhTarget = {0xD87965FD, 0x2BAD, 0x4657, [0xBD, 0x3B, 0x95, 0x67, 0xEB, 0x30, 0x0C, 0xED]};
@GUID(0xD87965FD, 0x2BAD, 0x4657, [0xBD, 0x3B, 0x95, 0x67, 0xEB, 0x30, 0x0C, 0xED]);
interface IFhTarget : IUnknown
{
    HRESULT GetStringProperty(FH_TARGET_PROPERTY_TYPE PropertyType, BSTR* PropertyValue);
    HRESULT GetNumericalProperty(FH_TARGET_PROPERTY_TYPE PropertyType, ulong* PropertyValue);
}

const GUID IID_IFhScopeIterator = {0x3197ABCE, 0x532A, 0x44C6, [0x86, 0x15, 0xF3, 0x66, 0x65, 0x66, 0xA7, 0x20]};
@GUID(0x3197ABCE, 0x532A, 0x44C6, [0x86, 0x15, 0xF3, 0x66, 0x65, 0x66, 0xA7, 0x20]);
interface IFhScopeIterator : IUnknown
{
    HRESULT MoveToNextItem();
    HRESULT GetItem(BSTR* Item);
}

enum FH_PROTECTED_ITEM_CATEGORY
{
    FH_FOLDER = 0,
    FH_LIBRARY = 1,
    MAX_PROTECTED_ITEM_CATEGORY = 2,
}

enum FH_LOCAL_POLICY_TYPE
{
    FH_FREQUENCY = 0,
    FH_RETENTION_TYPE = 1,
    FH_RETENTION_AGE = 2,
    MAX_LOCAL_POLICY = 3,
}

enum FH_RETENTION_TYPES
{
    FH_RETENTION_DISABLED = 0,
    FH_RETENTION_UNLIMITED = 1,
    FH_RETENTION_AGE_BASED = 2,
    MAX_RETENTION_TYPE = 3,
}

enum FH_BACKUP_STATUS
{
    FH_STATUS_DISABLED = 0,
    FH_STATUS_DISABLED_BY_GP = 1,
    FH_STATUS_ENABLED = 2,
    FH_STATUS_REHYDRATING = 3,
    MAX_BACKUP_STATUS = 4,
}

enum FH_DEVICE_VALIDATION_RESULT
{
    FH_ACCESS_DENIED = 0,
    FH_INVALID_DRIVE_TYPE = 1,
    FH_READ_ONLY_PERMISSION = 2,
    FH_CURRENT_DEFAULT = 3,
    FH_NAMESPACE_EXISTS = 4,
    FH_TARGET_PART_OF_LIBRARY = 5,
    FH_VALID_TARGET = 6,
    MAX_VALIDATION_RESULT = 7,
}

const GUID IID_IFhConfigMgr = {0x6A5FEA5B, 0xBF8F, 0x4EE5, [0xB8, 0xC3, 0x44, 0xD8, 0xA0, 0xD7, 0x33, 0x1C]};
@GUID(0x6A5FEA5B, 0xBF8F, 0x4EE5, [0xB8, 0xC3, 0x44, 0xD8, 0xA0, 0xD7, 0x33, 0x1C]);
interface IFhConfigMgr : IUnknown
{
    HRESULT LoadConfiguration();
    HRESULT CreateDefaultConfiguration(BOOL OverwriteIfExists);
    HRESULT SaveConfiguration();
    HRESULT AddRemoveExcludeRule(BOOL Add, FH_PROTECTED_ITEM_CATEGORY Category, BSTR Item);
    HRESULT GetIncludeExcludeRules(BOOL Include, FH_PROTECTED_ITEM_CATEGORY Category, IFhScopeIterator* Iterator);
    HRESULT GetLocalPolicy(FH_LOCAL_POLICY_TYPE LocalPolicyType, ulong* PolicyValue);
    HRESULT SetLocalPolicy(FH_LOCAL_POLICY_TYPE LocalPolicyType, ulong PolicyValue);
    HRESULT GetBackupStatus(FH_BACKUP_STATUS* BackupStatus);
    HRESULT SetBackupStatus(FH_BACKUP_STATUS BackupStatus);
    HRESULT GetDefaultTarget(IFhTarget* DefaultTarget);
    HRESULT ValidateTarget(BSTR TargetUrl, FH_DEVICE_VALIDATION_RESULT* ValidationResult);
    HRESULT ProvisionAndSetNewTarget(BSTR TargetUrl, BSTR TargetName);
    HRESULT ChangeDefaultTargetRecommendation(BOOL Recommend);
    HRESULT QueryProtectionStatus(uint* ProtectionState, BSTR* ProtectedUntilTime);
}

const GUID IID_IFhReassociation = {0x6544A28A, 0xF68D, 0x47AC, [0x91, 0xEF, 0x16, 0xB2, 0xB3, 0x6A, 0xA3, 0xEE]};
@GUID(0x6544A28A, 0xF68D, 0x47AC, [0x91, 0xEF, 0x16, 0xB2, 0xB3, 0x6A, 0xA3, 0xEE]);
interface IFhReassociation : IUnknown
{
    HRESULT ValidateTarget(BSTR TargetUrl, FH_DEVICE_VALIDATION_RESULT* ValidationResult);
    HRESULT ScanTargetForConfigurations(BSTR TargetUrl);
    HRESULT GetConfigurationDetails(uint Index, BSTR* UserName, BSTR* PcName, FILETIME* BackupTime);
    HRESULT SelectConfiguration(uint Index);
    HRESULT PerformReassociation(BOOL OverwriteIfExists);
}

enum FhBackupStopReason
{
    BackupInvalidStopReason = 0,
    BackupLimitUserBusyMachineOnAC = 1,
    BackupLimitUserIdleMachineOnDC = 2,
    BackupLimitUserBusyMachineOnDC = 3,
    BackupCancelled = 4,
}

struct FH_SERVICE_PIPE_HANDLE__
{
    int unused;
}

struct DCICMD
{
    uint dwCommand;
    uint dwParam1;
    uint dwParam2;
    uint dwVersion;
    uint dwReserved;
}

struct DCICREATEINPUT
{
    DCICMD cmd;
    uint dwCompression;
    uint dwMask;
    uint dwWidth;
    uint dwHeight;
    uint dwDCICaps;
    uint dwBitCount;
    void* lpSurface;
}

struct DCISURFACEINFO
{
    uint dwSize;
    uint dwDCICaps;
    uint dwCompression;
    uint dwMask;
    uint dwWidth;
    uint dwHeight;
    int lStride;
    uint dwBitCount;
    uint dwOffSurface;
    ushort wSelSurface;
    ushort wReserved;
    uint dwReserved1;
    uint dwReserved2;
    uint dwReserved3;
    int BeginAccess;
    int EndAccess;
    int DestroySurface;
}

alias ENUM_CALLBACK = extern(Windows) void function(DCISURFACEINFO* lpSurfaceInfo, void* lpContext);
struct DCIENUMINPUT
{
    DCICMD cmd;
    RECT rSrc;
    RECT rDst;
    int EnumCallback;
    void* lpContext;
}

struct DCIOFFSCREEN
{
    DCISURFACEINFO dciInfo;
    int Draw;
    int SetClipList;
    int SetDestination;
}

struct DCIOVERLAY
{
    DCISURFACEINFO dciInfo;
    uint dwChromakeyValue;
    uint dwChromakeyMask;
}

struct HWINWATCH__
{
    int unused;
}

alias WINWATCHNOTIFYPROC = extern(Windows) void function(HWINWATCH__* hww, HWND hwnd, uint code, LPARAM lParam);
const GUID CLSID_WaaSAssessor = {0x098EF871, 0xFA9F, 0x46AF, [0x89, 0x58, 0xC0, 0x83, 0x51, 0x5D, 0x7C, 0x9C]};
@GUID(0x098EF871, 0xFA9F, 0x46AF, [0x89, 0x58, 0xC0, 0x83, 0x51, 0x5D, 0x7C, 0x9C]);
struct WaaSAssessor;

const GUID IID_IWaaSAssessor = {0x2347BBEF, 0x1A3B, 0x45A4, [0x90, 0x2D, 0x3E, 0x09, 0xC2, 0x69, 0xB4, 0x5E]};
@GUID(0x2347BBEF, 0x1A3B, 0x45A4, [0x90, 0x2D, 0x3E, 0x09, 0xC2, 0x69, 0xB4, 0x5E]);
interface IWaaSAssessor : IUnknown
{
    HRESULT GetOSUpdateAssessment(OSUpdateAssessment* result);
}

struct VMEML
{
    VMEML* next;
    uint ptr;
    uint size;
    BOOL bDiscardable;
}

struct VMEMR
{
    VMEMR* next;
    VMEMR* prev;
    VMEMR* pUp;
    VMEMR* pDown;
    VMEMR* pLeft;
    VMEMR* pRight;
    uint ptr;
    uint size;
    uint x;
    uint y;
    uint cx;
    uint cy;
    uint flags;
    uint pBits;
    BOOL bDiscardable;
}

struct PROCESS_LIST
{
    PROCESS_LIST* lpLink;
    uint dwProcessId;
    uint dwRefCnt;
    uint dwAlphaDepth;
    uint dwZDepth;
}

struct DDMONITORINFO
{
    ushort Manufacturer;
    ushort Product;
    uint SerialNumber;
    Guid DeviceIdentifier;
    int Mode640x480;
    int Mode800x600;
    int Mode1024x768;
    int Mode1280x1024;
    int Mode1600x1200;
    int ModeReserved1;
    int ModeReserved2;
    int ModeReserved3;
}

struct IDirectDrawClipperVtbl
{
}

struct IDirectDrawPaletteVtbl
{
}

struct IDirectDrawSurfaceVtbl
{
}

struct IDirectDrawSurface2Vtbl
{
}

struct IDirectDrawSurface3Vtbl
{
}

struct IDirectDrawSurface4Vtbl
{
}

struct IDirectDrawSurface7Vtbl
{
}

struct IDirectDrawColorControlVtbl
{
}

struct IDirectDrawVtbl
{
}

struct IDirectDraw2Vtbl
{
}

struct IDirectDraw4Vtbl
{
}

struct IDirectDraw7Vtbl
{
}

struct IDirectDrawKernelVtbl
{
}

struct IDirectDrawSurfaceKernelVtbl
{
}

struct IDirectDrawGammaControlVtbl
{
}

struct DD32BITDRIVERDATA
{
    byte szName;
    byte szEntryPoint;
    uint dwContext;
}

struct DDVERSIONDATA
{
    uint dwHALVersion;
    uint dwReserved1;
    uint dwReserved2;
}

alias LPDD32BITDRIVERINIT = extern(Windows) uint function(uint dwContext);
struct VIDMEM
{
    uint dwFlags;
    uint fpStart;
    _Anonymous1_e__Union Anonymous1;
    DDSCAPS ddsCaps;
    DDSCAPS ddsCapsAlt;
    _Anonymous2_e__Union Anonymous2;
}

struct VIDMEMINFO
{
    uint fpPrimary;
    uint dwFlags;
    uint dwDisplayWidth;
    uint dwDisplayHeight;
    int lDisplayPitch;
    DDPIXELFORMAT ddpfDisplay;
    uint dwOffscreenAlign;
    uint dwOverlayAlign;
    uint dwTextureAlign;
    uint dwZBufferAlign;
    uint dwAlphaAlign;
    uint dwNumHeaps;
    VIDMEM* pvmList;
}

struct HEAPALIAS
{
    uint fpVidMem;
    void* lpAlias;
    uint dwAliasSize;
}

struct HEAPALIASINFO
{
    uint dwRefCnt;
    uint dwFlags;
    uint dwNumHeaps;
    HEAPALIAS* lpAliases;
}

struct IUNKNOWN_LIST
{
    IUNKNOWN_LIST* lpLink;
    Guid* lpGuid;
    IUnknown lpIUnknown;
}

alias LPDDHEL_INIT = extern(Windows) BOOL function(DDRAWI_DIRECTDRAW_GBL* param0, BOOL param1);
alias LPDDHAL_SETCOLORKEY = extern(Windows) uint function(DDHAL_DRVSETCOLORKEYDATA* param0);
alias LPDDHAL_CANCREATESURFACE = extern(Windows) uint function(DDHAL_CANCREATESURFACEDATA* param0);
alias LPDDHAL_WAITFORVERTICALBLANK = extern(Windows) uint function(DDHAL_WAITFORVERTICALBLANKDATA* param0);
alias LPDDHAL_CREATESURFACE = extern(Windows) uint function(DDHAL_CREATESURFACEDATA* param0);
alias LPDDHAL_DESTROYDRIVER = extern(Windows) uint function(DDHAL_DESTROYDRIVERDATA* param0);
alias LPDDHAL_SETMODE = extern(Windows) uint function(DDHAL_SETMODEDATA* param0);
alias LPDDHAL_CREATEPALETTE = extern(Windows) uint function(DDHAL_CREATEPALETTEDATA* param0);
alias LPDDHAL_GETSCANLINE = extern(Windows) uint function(DDHAL_GETSCANLINEDATA* param0);
alias LPDDHAL_SETEXCLUSIVEMODE = extern(Windows) uint function(DDHAL_SETEXCLUSIVEMODEDATA* param0);
alias LPDDHAL_FLIPTOGDISURFACE = extern(Windows) uint function(DDHAL_FLIPTOGDISURFACEDATA* param0);
alias LPDDHAL_GETDRIVERINFO = extern(Windows) uint function(DDHAL_GETDRIVERINFODATA* param0);
struct DDHAL_DDCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHAL_DESTROYDRIVER DestroyDriver;
    LPDDHAL_CREATESURFACE CreateSurface;
    LPDDHAL_SETCOLORKEY SetColorKey;
    LPDDHAL_SETMODE SetMode;
    LPDDHAL_WAITFORVERTICALBLANK WaitForVerticalBlank;
    LPDDHAL_CANCREATESURFACE CanCreateSurface;
    LPDDHAL_CREATEPALETTE CreatePalette;
    LPDDHAL_GETSCANLINE GetScanLine;
    LPDDHAL_SETEXCLUSIVEMODE SetExclusiveMode;
    LPDDHAL_FLIPTOGDISURFACE FlipToGDISurface;
}

alias LPDDHALPALCB_DESTROYPALETTE = extern(Windows) uint function(DDHAL_DESTROYPALETTEDATA* param0);
alias LPDDHALPALCB_SETENTRIES = extern(Windows) uint function(DDHAL_SETENTRIESDATA* param0);
struct DDHAL_DDPALETTECALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALPALCB_DESTROYPALETTE DestroyPalette;
    LPDDHALPALCB_SETENTRIES SetEntries;
}

alias LPDDHALSURFCB_LOCK = extern(Windows) uint function(DDHAL_LOCKDATA* param0);
alias LPDDHALSURFCB_UNLOCK = extern(Windows) uint function(DDHAL_UNLOCKDATA* param0);
alias LPDDHALSURFCB_BLT = extern(Windows) uint function(DDHAL_BLTDATA* param0);
alias LPDDHALSURFCB_UPDATEOVERLAY = extern(Windows) uint function(DDHAL_UPDATEOVERLAYDATA* param0);
alias LPDDHALSURFCB_SETOVERLAYPOSITION = extern(Windows) uint function(DDHAL_SETOVERLAYPOSITIONDATA* param0);
alias LPDDHALSURFCB_SETPALETTE = extern(Windows) uint function(DDHAL_SETPALETTEDATA* param0);
alias LPDDHALSURFCB_FLIP = extern(Windows) uint function(DDHAL_FLIPDATA* param0);
alias LPDDHALSURFCB_DESTROYSURFACE = extern(Windows) uint function(DDHAL_DESTROYSURFACEDATA* param0);
alias LPDDHALSURFCB_SETCLIPLIST = extern(Windows) uint function(DDHAL_SETCLIPLISTDATA* param0);
alias LPDDHALSURFCB_ADDATTACHEDSURFACE = extern(Windows) uint function(DDHAL_ADDATTACHEDSURFACEDATA* param0);
alias LPDDHALSURFCB_SETCOLORKEY = extern(Windows) uint function(DDHAL_SETCOLORKEYDATA* param0);
alias LPDDHALSURFCB_GETBLTSTATUS = extern(Windows) uint function(DDHAL_GETBLTSTATUSDATA* param0);
alias LPDDHALSURFCB_GETFLIPSTATUS = extern(Windows) uint function(DDHAL_GETFLIPSTATUSDATA* param0);
struct DDHAL_DDSURFACECALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALSURFCB_DESTROYSURFACE DestroySurface;
    LPDDHALSURFCB_FLIP Flip;
    LPDDHALSURFCB_SETCLIPLIST SetClipList;
    LPDDHALSURFCB_LOCK Lock;
    LPDDHALSURFCB_UNLOCK Unlock;
    LPDDHALSURFCB_BLT Blt;
    LPDDHALSURFCB_SETCOLORKEY SetColorKey;
    LPDDHALSURFCB_ADDATTACHEDSURFACE AddAttachedSurface;
    LPDDHALSURFCB_GETBLTSTATUS GetBltStatus;
    LPDDHALSURFCB_GETFLIPSTATUS GetFlipStatus;
    LPDDHALSURFCB_UPDATEOVERLAY UpdateOverlay;
    LPDDHALSURFCB_SETOVERLAYPOSITION SetOverlayPosition;
    void* reserved4;
    LPDDHALSURFCB_SETPALETTE SetPalette;
}

alias LPDDHAL_GETAVAILDRIVERMEMORY = extern(Windows) uint function(DDHAL_GETAVAILDRIVERMEMORYDATA* param0);
alias LPDDHAL_UPDATENONLOCALHEAP = extern(Windows) uint function(DDHAL_UPDATENONLOCALHEAPDATA* param0);
alias LPDDHAL_GETHEAPALIGNMENT = extern(Windows) uint function(DDHAL_GETHEAPALIGNMENTDATA* param0);
struct DDHAL_DDMISCELLANEOUSCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHAL_GETAVAILDRIVERMEMORY GetAvailDriverMemory;
    LPDDHAL_UPDATENONLOCALHEAP UpdateNonLocalHeap;
    LPDDHAL_GETHEAPALIGNMENT GetHeapAlignment;
    LPDDHALSURFCB_GETBLTSTATUS GetSysmemBltStatus;
}

alias LPDDHAL_CREATESURFACEEX = extern(Windows) uint function(DDHAL_CREATESURFACEEXDATA* param0);
alias LPDDHAL_GETDRIVERSTATE = extern(Windows) uint function(DDHAL_GETDRIVERSTATEDATA* param0);
alias LPDDHAL_DESTROYDDLOCAL = extern(Windows) uint function(DDHAL_DESTROYDDLOCALDATA* param0);
struct DDHAL_DDMISCELLANEOUS2CALLBACKS
{
    uint dwSize;
    uint dwFlags;
    void* Reserved;
    LPDDHAL_CREATESURFACEEX CreateSurfaceEx;
    LPDDHAL_GETDRIVERSTATE GetDriverState;
    LPDDHAL_DESTROYDDLOCAL DestroyDDLocal;
}

alias LPDDHALEXEBUFCB_CANCREATEEXEBUF = extern(Windows) uint function(DDHAL_CANCREATESURFACEDATA* param0);
alias LPDDHALEXEBUFCB_CREATEEXEBUF = extern(Windows) uint function(DDHAL_CREATESURFACEDATA* param0);
alias LPDDHALEXEBUFCB_DESTROYEXEBUF = extern(Windows) uint function(DDHAL_DESTROYSURFACEDATA* param0);
alias LPDDHALEXEBUFCB_LOCKEXEBUF = extern(Windows) uint function(DDHAL_LOCKDATA* param0);
alias LPDDHALEXEBUFCB_UNLOCKEXEBUF = extern(Windows) uint function(DDHAL_UNLOCKDATA* param0);
struct DDHAL_DDEXEBUFCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALEXEBUFCB_CANCREATEEXEBUF CanCreateExecuteBuffer;
    LPDDHALEXEBUFCB_CREATEEXEBUF CreateExecuteBuffer;
    LPDDHALEXEBUFCB_DESTROYEXEBUF DestroyExecuteBuffer;
    LPDDHALEXEBUFCB_LOCKEXEBUF LockExecuteBuffer;
    LPDDHALEXEBUFCB_UNLOCKEXEBUF UnlockExecuteBuffer;
}

alias LPDDHALVPORTCB_CANCREATEVIDEOPORT = extern(Windows) uint function(DDHAL_CANCREATEVPORTDATA* param0);
alias LPDDHALVPORTCB_CREATEVIDEOPORT = extern(Windows) uint function(DDHAL_CREATEVPORTDATA* param0);
alias LPDDHALVPORTCB_FLIP = extern(Windows) uint function(DDHAL_FLIPVPORTDATA* param0);
alias LPDDHALVPORTCB_GETBANDWIDTH = extern(Windows) uint function(DDHAL_GETVPORTBANDWIDTHDATA* param0);
alias LPDDHALVPORTCB_GETINPUTFORMATS = extern(Windows) uint function(DDHAL_GETVPORTINPUTFORMATDATA* param0);
alias LPDDHALVPORTCB_GETOUTPUTFORMATS = extern(Windows) uint function(DDHAL_GETVPORTOUTPUTFORMATDATA* param0);
alias LPDDHALVPORTCB_GETFIELD = extern(Windows) uint function(DDHAL_GETVPORTFIELDDATA* param0);
alias LPDDHALVPORTCB_GETLINE = extern(Windows) uint function(DDHAL_GETVPORTLINEDATA* param0);
alias LPDDHALVPORTCB_GETVPORTCONNECT = extern(Windows) uint function(DDHAL_GETVPORTCONNECTDATA* param0);
alias LPDDHALVPORTCB_DESTROYVPORT = extern(Windows) uint function(DDHAL_DESTROYVPORTDATA* param0);
alias LPDDHALVPORTCB_GETFLIPSTATUS = extern(Windows) uint function(DDHAL_GETVPORTFLIPSTATUSDATA* param0);
alias LPDDHALVPORTCB_UPDATE = extern(Windows) uint function(DDHAL_UPDATEVPORTDATA* param0);
alias LPDDHALVPORTCB_WAITFORSYNC = extern(Windows) uint function(DDHAL_WAITFORVPORTSYNCDATA* param0);
alias LPDDHALVPORTCB_GETSIGNALSTATUS = extern(Windows) uint function(DDHAL_GETVPORTSIGNALDATA* param0);
alias LPDDHALVPORTCB_COLORCONTROL = extern(Windows) uint function(DDHAL_VPORTCOLORDATA* param0);
struct DDHAL_DDVIDEOPORTCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALVPORTCB_CANCREATEVIDEOPORT CanCreateVideoPort;
    LPDDHALVPORTCB_CREATEVIDEOPORT CreateVideoPort;
    LPDDHALVPORTCB_FLIP FlipVideoPort;
    LPDDHALVPORTCB_GETBANDWIDTH GetVideoPortBandwidth;
    LPDDHALVPORTCB_GETINPUTFORMATS GetVideoPortInputFormats;
    LPDDHALVPORTCB_GETOUTPUTFORMATS GetVideoPortOutputFormats;
    void* lpReserved1;
    LPDDHALVPORTCB_GETFIELD GetVideoPortField;
    LPDDHALVPORTCB_GETLINE GetVideoPortLine;
    LPDDHALVPORTCB_GETVPORTCONNECT GetVideoPortConnectInfo;
    LPDDHALVPORTCB_DESTROYVPORT DestroyVideoPort;
    LPDDHALVPORTCB_GETFLIPSTATUS GetVideoPortFlipStatus;
    LPDDHALVPORTCB_UPDATE UpdateVideoPort;
    LPDDHALVPORTCB_WAITFORSYNC WaitForVideoPortSync;
    LPDDHALVPORTCB_GETSIGNALSTATUS GetVideoSignalStatus;
    LPDDHALVPORTCB_COLORCONTROL ColorControl;
}

alias LPDDHALCOLORCB_COLORCONTROL = extern(Windows) uint function(DDHAL_COLORCONTROLDATA* param0);
struct DDHAL_DDCOLORCONTROLCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALCOLORCB_COLORCONTROL ColorControl;
}

alias LPDDHALKERNELCB_SYNCSURFACE = extern(Windows) uint function(DDHAL_SYNCSURFACEDATA* param0);
alias LPDDHALKERNELCB_SYNCVIDEOPORT = extern(Windows) uint function(DDHAL_SYNCVIDEOPORTDATA* param0);
struct DDHAL_DDKERNELCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALKERNELCB_SYNCSURFACE SyncSurfaceData;
    LPDDHALKERNELCB_SYNCVIDEOPORT SyncVideoPortData;
}

alias LPDDGAMMACALIBRATORPROC = extern(Windows) HRESULT function(DDGAMMARAMP* param0, ubyte* param1);
alias LPDDHALMOCOMPCB_GETGUIDS = extern(Windows) uint function(DDHAL_GETMOCOMPGUIDSDATA* param0);
alias LPDDHALMOCOMPCB_GETFORMATS = extern(Windows) uint function(DDHAL_GETMOCOMPFORMATSDATA* param0);
alias LPDDHALMOCOMPCB_CREATE = extern(Windows) uint function(DDHAL_CREATEMOCOMPDATA* param0);
alias LPDDHALMOCOMPCB_GETCOMPBUFFINFO = extern(Windows) uint function(DDHAL_GETMOCOMPCOMPBUFFDATA* param0);
alias LPDDHALMOCOMPCB_GETINTERNALINFO = extern(Windows) uint function(DDHAL_GETINTERNALMOCOMPDATA* param0);
alias LPDDHALMOCOMPCB_BEGINFRAME = extern(Windows) uint function(DDHAL_BEGINMOCOMPFRAMEDATA* param0);
alias LPDDHALMOCOMPCB_ENDFRAME = extern(Windows) uint function(DDHAL_ENDMOCOMPFRAMEDATA* param0);
alias LPDDHALMOCOMPCB_RENDER = extern(Windows) uint function(DDHAL_RENDERMOCOMPDATA* param0);
alias LPDDHALMOCOMPCB_QUERYSTATUS = extern(Windows) uint function(DDHAL_QUERYMOCOMPSTATUSDATA* param0);
alias LPDDHALMOCOMPCB_DESTROY = extern(Windows) uint function(DDHAL_DESTROYMOCOMPDATA* param0);
struct DDHAL_DDMOTIONCOMPCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALMOCOMPCB_GETGUIDS GetMoCompGuids;
    LPDDHALMOCOMPCB_GETFORMATS GetMoCompFormats;
    LPDDHALMOCOMPCB_CREATE CreateMoComp;
    LPDDHALMOCOMPCB_GETCOMPBUFFINFO GetMoCompBuffInfo;
    LPDDHALMOCOMPCB_GETINTERNALINFO GetInternalMoCompInfo;
    LPDDHALMOCOMPCB_BEGINFRAME BeginMoCompFrame;
    LPDDHALMOCOMPCB_ENDFRAME EndMoCompFrame;
    LPDDHALMOCOMPCB_RENDER RenderMoComp;
    LPDDHALMOCOMPCB_QUERYSTATUS QueryMoCompStatus;
    LPDDHALMOCOMPCB_DESTROY DestroyMoComp;
}

struct DDNONLOCALVIDMEMCAPS
{
    uint dwSize;
    uint dwNLVBCaps;
    uint dwNLVBCaps2;
    uint dwNLVBCKeyCaps;
    uint dwNLVBFXCaps;
    uint dwNLVBRops;
}

struct DDMORESURFACECAPS
{
    uint dwSize;
    DDSCAPSEX ddsCapsMore;
    tagExtendedHeapRestrictions ddsExtendedHeapRestrictions;
}

struct DDSTEREOMODE
{
    uint dwSize;
    uint dwHeight;
    uint dwWidth;
    uint dwBpp;
    uint dwRefreshRate;
    BOOL bSupported;
}

struct DDRAWI_DDRAWPALETTE_INT
{
    void* lpVtbl;
    DDRAWI_DDRAWPALETTE_LCL* lpLcl;
    DDRAWI_DDRAWPALETTE_INT* lpLink;
    uint dwIntRefCnt;
}

struct DDRAWI_DDRAWPALETTE_GBL
{
    uint dwRefCnt;
    uint dwFlags;
    DDRAWI_DIRECTDRAW_LCL* lpDD_lcl;
    uint dwProcessId;
    PALETTEENTRY* lpColorTable;
    _Anonymous_e__Union Anonymous;
    uint dwDriverReserved;
    uint dwContentsStamp;
    uint dwSaveStamp;
    uint dwHandle;
}

struct DDRAWI_DDRAWPALETTE_LCL
{
    uint lpPalMore;
    DDRAWI_DDRAWPALETTE_GBL* lpGbl;
    uint dwUnused0;
    uint dwLocalRefCnt;
    IUnknown pUnkOuter;
    DDRAWI_DIRECTDRAW_LCL* lpDD_lcl;
    uint dwReserved1;
    uint dwDDRAWReserved1;
    uint dwDDRAWReserved2;
    uint dwDDRAWReserved3;
}

struct DDRAWI_DDRAWCLIPPER_INT
{
    void* lpVtbl;
    DDRAWI_DDRAWCLIPPER_LCL* lpLcl;
    DDRAWI_DDRAWCLIPPER_INT* lpLink;
    uint dwIntRefCnt;
}

struct DDRAWI_DDRAWCLIPPER_GBL
{
    uint dwRefCnt;
    uint dwFlags;
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint dwProcessId;
    uint dwReserved1;
    uint hWnd;
    RGNDATA* lpStaticClipList;
}

struct DDRAWI_DDRAWCLIPPER_LCL
{
    uint lpClipMore;
    DDRAWI_DDRAWCLIPPER_GBL* lpGbl;
    DDRAWI_DIRECTDRAW_LCL* lpDD_lcl;
    uint dwLocalRefCnt;
    IUnknown pUnkOuter;
    DDRAWI_DIRECTDRAW_INT* lpDD_int;
    uint dwReserved1;
    IUnknown pAddrefedThisOwner;
}

struct ATTACHLIST
{
    uint dwFlags;
    ATTACHLIST* lpLink;
    DDRAWI_DDRAWSURFACE_LCL* lpAttached;
    DDRAWI_DDRAWSURFACE_INT* lpIAttached;
}

struct DBLNODE
{
    DBLNODE* next;
    DBLNODE* prev;
    DDRAWI_DDRAWSURFACE_LCL* object;
    DDRAWI_DDRAWSURFACE_INT* object_int;
}

struct ACCESSRECTLIST
{
    ACCESSRECTLIST* lpLink;
    RECT rDest;
    DDRAWI_DIRECTDRAW_LCL* lpOwner;
    void* lpSurfaceData;
    uint dwFlags;
    HEAPALIASINFO* lpHeapAliasInfo;
}

struct DDRAWI_DDRAWSURFACE_INT
{
    void* lpVtbl;
    DDRAWI_DDRAWSURFACE_LCL* lpLcl;
    DDRAWI_DDRAWSURFACE_INT* lpLink;
    uint dwIntRefCnt;
}

struct DDRAWI_DDRAWSURFACE_GBL
{
    uint dwRefCnt;
    uint dwGlobalFlags;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    uint fpVidMem;
    _Anonymous4_e__Union Anonymous4;
    ushort wHeight;
    ushort wWidth;
    uint dwUsageCount;
    uint dwReserved1;
    DDPIXELFORMAT ddpfSurface;
}

struct DDRAWI_DDRAWSURFACE_GBL_MORE
{
    uint dwSize;
    _Anonymous_e__Union Anonymous;
    uint* pPageTable;
    uint cPages;
    uint dwSavedDCContext;
    uint fpAliasedVidMem;
    uint dwDriverReserved;
    uint dwHELReserved;
    uint cPageUnlocks;
    uint hKernelSurface;
    uint dwKernelRefCnt;
    DDCOLORCONTROL* lpColorInfo;
    uint fpNTAlias;
    uint dwContentsStamp;
    void* lpvUnswappedDriverReserved;
    void* lpDDRAWReserved2;
    uint dwDDRAWReserved1;
    uint dwDDRAWReserved2;
    uint fpAliasOfVidMem;
}

struct DDRAWI_DDRAWSURFACE_MORE
{
    uint dwSize;
    IUNKNOWN_LIST* lpIUnknowns;
    DDRAWI_DIRECTDRAW_LCL* lpDD_lcl;
    uint dwPageLockCount;
    uint dwBytesAllocated;
    DDRAWI_DIRECTDRAW_INT* lpDD_int;
    uint dwMipMapCount;
    DDRAWI_DDRAWCLIPPER_INT* lpDDIClipper;
    HEAPALIASINFO* lpHeapAliasInfo;
    uint dwOverlayFlags;
    void* rgjunc;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    DDOVERLAYFX* lpddOverlayFX;
    DDSCAPSEX ddsCapsEx;
    uint dwTextureStage;
    void* lpDDRAWReserved;
    void* lpDDRAWReserved2;
    void* lpDDrawReserved3;
    uint dwDDrawReserved4;
    void* lpDDrawReserved5;
    uint* lpGammaRamp;
    uint* lpOriginalGammaRamp;
    void* lpDDrawReserved6;
    uint dwSurfaceHandle;
    uint qwDDrawReserved8;
    void* lpDDrawReserved9;
    uint cSurfaces;
    DDSURFACEDESC2* pCreatedDDSurfaceDesc2;
    DDRAWI_DDRAWSURFACE_LCL** slist;
    uint dwFVF;
    void* lpVB;
}

struct DDRAWI_DDRAWSURFACE_LCL
{
    DDRAWI_DDRAWSURFACE_MORE* lpSurfMore;
    DDRAWI_DDRAWSURFACE_GBL* lpGbl;
    uint hDDSurface;
    ATTACHLIST* lpAttachList;
    ATTACHLIST* lpAttachListFrom;
    uint dwLocalRefCnt;
    uint dwProcessId;
    uint dwFlags;
    DDSCAPS ddsCaps;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    uint dwModeCreatedIn;
    uint dwBackBufferCount;
    DDCOLORKEY ddckCKDestBlt;
    DDCOLORKEY ddckCKSrcBlt;
    uint hDC;
    uint dwReserved1;
    DDCOLORKEY ddckCKSrcOverlay;
    DDCOLORKEY ddckCKDestOverlay;
    DDRAWI_DDRAWSURFACE_INT* lpSurfaceOverlaying;
    DBLNODE dbnOverlayNode;
    RECT rcOverlaySrc;
    RECT rcOverlayDest;
    uint dwClrXparent;
    uint dwAlpha;
    int lOverlayX;
    int lOverlayY;
}

struct DDHALMODEINFO
{
    uint dwWidth;
    uint dwHeight;
    int lPitch;
    uint dwBPP;
    ushort wFlags;
    ushort wRefreshRate;
    uint dwRBitMask;
    uint dwGBitMask;
    uint dwBBitMask;
    uint dwAlphaBitMask;
}

struct DDRAWI_DIRECTDRAW_INT
{
    void* lpVtbl;
    DDRAWI_DIRECTDRAW_LCL* lpLcl;
    DDRAWI_DIRECTDRAW_INT* lpLink;
    uint dwIntRefCnt;
}

struct DDHAL_CALLBACKS
{
    DDHAL_DDCALLBACKS cbDDCallbacks;
    DDHAL_DDSURFACECALLBACKS cbDDSurfaceCallbacks;
    DDHAL_DDPALETTECALLBACKS cbDDPaletteCallbacks;
    DDHAL_DDCALLBACKS HALDD;
    DDHAL_DDSURFACECALLBACKS HALDDSurface;
    DDHAL_DDPALETTECALLBACKS HALDDPalette;
    DDHAL_DDCALLBACKS HELDD;
    DDHAL_DDSURFACECALLBACKS HELDDSurface;
    DDHAL_DDPALETTECALLBACKS HELDDPalette;
    DDHAL_DDEXEBUFCALLBACKS cbDDExeBufCallbacks;
    DDHAL_DDEXEBUFCALLBACKS HALDDExeBuf;
    DDHAL_DDEXEBUFCALLBACKS HELDDExeBuf;
    DDHAL_DDVIDEOPORTCALLBACKS cbDDVideoPortCallbacks;
    DDHAL_DDVIDEOPORTCALLBACKS HALDDVideoPort;
    DDHAL_DDCOLORCONTROLCALLBACKS cbDDColorControlCallbacks;
    DDHAL_DDCOLORCONTROLCALLBACKS HALDDColorControl;
    DDHAL_DDMISCELLANEOUSCALLBACKS cbDDMiscellaneousCallbacks;
    DDHAL_DDMISCELLANEOUSCALLBACKS HALDDMiscellaneous;
    DDHAL_DDKERNELCALLBACKS cbDDKernelCallbacks;
    DDHAL_DDKERNELCALLBACKS HALDDKernel;
    DDHAL_DDMOTIONCOMPCALLBACKS cbDDMotionCompCallbacks;
    DDHAL_DDMOTIONCOMPCALLBACKS HALDDMotionComp;
}

struct DDRAWI_DIRECTDRAW_GBL
{
    uint dwRefCnt;
    uint dwFlags;
    uint fpPrimaryOrig;
    DDCORECAPS ddCaps;
    uint dwInternal1;
    uint dwUnused1;
    DDHAL_CALLBACKS* lpDDCBtmp;
    DDRAWI_DDRAWSURFACE_INT* dsList;
    DDRAWI_DDRAWPALETTE_INT* palList;
    DDRAWI_DDRAWCLIPPER_INT* clipperList;
    DDRAWI_DIRECTDRAW_GBL* lp16DD;
    uint dwMaxOverlays;
    uint dwCurrOverlays;
    uint dwMonitorFrequency;
    DDCORECAPS ddHELCaps;
    uint dwUnused2;
    DDCOLORKEY ddckCKDestOverlay;
    DDCOLORKEY ddckCKSrcOverlay;
    VIDMEMINFO vmiData;
    void* lpDriverHandle;
    DDRAWI_DIRECTDRAW_LCL* lpExclusiveOwner;
    uint dwModeIndex;
    uint dwModeIndexOrig;
    uint dwNumFourCC;
    uint* lpdwFourCC;
    uint dwNumModes;
    DDHALMODEINFO* lpModeInfo;
    PROCESS_LIST plProcessList;
    uint dwSurfaceLockCount;
    uint dwAliasedLockCnt;
    uint dwReserved3;
    uint hDD;
    byte cObsolete;
    uint dwReserved1;
    uint dwReserved2;
    DBLNODE dbnOverlayRoot;
    ushort* lpwPDeviceFlags;
    uint dwPDevice;
    uint dwWin16LockCnt;
    uint dwUnused3;
    uint hInstance;
    uint dwEvent16;
    uint dwSaveNumModes;
    uint lpD3DGlobalDriverData;
    uint lpD3DHALCallbacks;
    DDCORECAPS ddBothCaps;
    DDVIDEOPORTCAPS* lpDDVideoPortCaps;
    DDRAWI_DDVIDEOPORT_INT* dvpList;
    uint lpD3DHALCallbacks2;
    RECT rectDevice;
    uint cMonitors;
    void* gpbmiSrc;
    void* gpbmiDest;
    HEAPALIASINFO* phaiHeapAliases;
    uint hKernelHandle;
    uint pfnNotifyProc;
    DDKERNELCAPS* lpDDKernelCaps;
    DDNONLOCALVIDMEMCAPS* lpddNLVCaps;
    DDNONLOCALVIDMEMCAPS* lpddNLVHELCaps;
    DDNONLOCALVIDMEMCAPS* lpddNLVBothCaps;
    uint lpD3DExtendedCaps;
    uint dwDOSBoxEvent;
    RECT rectDesktop;
    byte cDriverName;
    uint lpD3DHALCallbacks3;
    uint dwNumZPixelFormats;
    DDPIXELFORMAT* lpZPixelFormats;
    DDRAWI_DDMOTIONCOMP_INT* mcList;
    uint hDDVxd;
    DDSCAPSEX ddsCapsMore;
}

struct DDRAWI_DIRECTDRAW_LCL
{
    uint lpDDMore;
    DDRAWI_DIRECTDRAW_GBL* lpGbl;
    uint dwUnused0;
    uint dwLocalFlags;
    uint dwLocalRefCnt;
    uint dwProcessId;
    IUnknown pUnkOuter;
    uint dwObsolete1;
    uint hWnd;
    uint hDC;
    uint dwErrorMode;
    DDRAWI_DDRAWSURFACE_INT* lpPrimary;
    DDRAWI_DDRAWSURFACE_INT* lpCB;
    uint dwPreferredMode;
    HINSTANCE hD3DInstance;
    IUnknown pD3DIUnknown;
    DDHAL_CALLBACKS* lpDDCB;
    uint hDDVxd;
    uint dwAppHackFlags;
    uint hFocusWnd;
    uint dwHotTracking;
    uint dwIMEState;
    uint hWndPopup;
    uint hDD;
    uint hGammaCalibrator;
    LPDDGAMMACALIBRATORPROC lpGammaCalibrator;
}

struct DDRAWI_DDVIDEOPORT_INT
{
    void* lpVtbl;
    DDRAWI_DDVIDEOPORT_LCL* lpLcl;
    DDRAWI_DDVIDEOPORT_INT* lpLink;
    uint dwIntRefCnt;
    uint dwFlags;
}

struct DDRAWI_DDVIDEOPORT_LCL
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDVIDEOPORTDESC ddvpDesc;
    DDVIDEOPORTINFO ddvpInfo;
    DDRAWI_DDRAWSURFACE_INT* lpSurface;
    DDRAWI_DDRAWSURFACE_INT* lpVBISurface;
    DDRAWI_DDRAWSURFACE_INT** lpFlipInts;
    uint dwNumAutoflip;
    uint dwProcessID;
    uint dwStateFlags;
    uint dwFlags;
    uint dwRefCnt;
    uint fpLastFlip;
    uint dwReserved1;
    uint dwReserved2;
    HANDLE hDDVideoPort;
    uint dwNumVBIAutoflip;
    DDVIDEOPORTDESC* lpVBIDesc;
    DDVIDEOPORTDESC* lpVideoDesc;
    DDVIDEOPORTINFO* lpVBIInfo;
    DDVIDEOPORTINFO* lpVideoInfo;
    uint dwVBIProcessID;
    DDRAWI_DDVIDEOPORT_INT* lpVPNotify;
}

struct DDRAWI_DDMOTIONCOMP_INT
{
    void* lpVtbl;
    DDRAWI_DDMOTIONCOMP_LCL* lpLcl;
    DDRAWI_DDMOTIONCOMP_INT* lpLink;
    uint dwIntRefCnt;
}

struct DDRAWI_DDMOTIONCOMP_LCL
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    Guid guid;
    uint dwUncompWidth;
    uint dwUncompHeight;
    DDPIXELFORMAT ddUncompPixelFormat;
    uint dwInternalFlags;
    uint dwRefCnt;
    uint dwProcessId;
    HANDLE hMoComp;
    uint dwDriverReserved1;
    uint dwDriverReserved2;
    uint dwDriverReserved3;
    void* lpDriverReserved1;
    void* lpDriverReserved2;
    void* lpDriverReserved3;
}

struct DDHALINFO
{
    uint dwSize;
    DDHAL_DDCALLBACKS* lpDDCallbacks;
    DDHAL_DDSURFACECALLBACKS* lpDDSurfaceCallbacks;
    DDHAL_DDPALETTECALLBACKS* lpDDPaletteCallbacks;
    VIDMEMINFO vmiData;
    DDCORECAPS ddCaps;
    uint dwMonitorFrequency;
    LPDDHAL_GETDRIVERINFO GetDriverInfo;
    uint dwModeIndex;
    uint* lpdwFourCC;
    uint dwNumModes;
    DDHALMODEINFO* lpModeInfo;
    uint dwFlags;
    void* lpPDevice;
    uint hInstance;
    uint lpD3DGlobalDriverData;
    uint lpD3DHALCallbacks;
    DDHAL_DDEXEBUFCALLBACKS* lpDDExeBufCallbacks;
}

alias LPDDHAL_SETINFO = extern(Windows) BOOL function(DDHALINFO* lpDDHalInfo, BOOL reset);
alias LPDDHAL_VIDMEMALLOC = extern(Windows) uint function(DDRAWI_DIRECTDRAW_GBL* lpDD, int heap, uint dwWidth, uint dwHeight);
alias LPDDHAL_VIDMEMFREE = extern(Windows) void function(DDRAWI_DIRECTDRAW_GBL* lpDD, int heap, uint fpMem);
struct DDHALDDRAWFNS
{
    uint dwSize;
    LPDDHAL_SETINFO lpSetInfo;
    LPDDHAL_VIDMEMALLOC lpVidMemAlloc;
    LPDDHAL_VIDMEMFREE lpVidMemFree;
}

struct DDHAL_BLTDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDDestSurface;
    RECTL rDest;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSrcSurface;
    RECTL rSrc;
    uint dwFlags;
    uint dwROPFlags;
    DDBLTFX bltFX;
    HRESULT ddRVal;
    LPDDHALSURFCB_BLT Blt;
    BOOL IsClipped;
    RECTL rOrigDest;
    RECTL rOrigSrc;
    uint dwRectCnt;
    RECT* prDestRects;
}

struct DDHAL_LOCKDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint bHasRect;
    RECTL rArea;
    void* lpSurfData;
    HRESULT ddRVal;
    LPDDHALSURFCB_LOCK Lock;
    uint dwFlags;
}

struct DDHAL_UNLOCKDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    HRESULT ddRVal;
    LPDDHALSURFCB_UNLOCK Unlock;
}

struct DDHAL_UPDATEOVERLAYDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDDestSurface;
    RECTL rDest;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSrcSurface;
    RECTL rSrc;
    uint dwFlags;
    DDOVERLAYFX overlayFX;
    HRESULT ddRVal;
    LPDDHALSURFCB_UPDATEOVERLAY UpdateOverlay;
}

struct DDHAL_SETOVERLAYPOSITIONDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSrcSurface;
    DDRAWI_DDRAWSURFACE_LCL* lpDDDestSurface;
    int lXPos;
    int lYPos;
    HRESULT ddRVal;
    LPDDHALSURFCB_SETOVERLAYPOSITION SetOverlayPosition;
}

struct DDHAL_SETPALETTEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    DDRAWI_DDRAWPALETTE_GBL* lpDDPalette;
    HRESULT ddRVal;
    LPDDHALSURFCB_SETPALETTE SetPalette;
    BOOL Attach;
}

struct DDHAL_FLIPDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfCurr;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfTarg;
    uint dwFlags;
    HRESULT ddRVal;
    LPDDHALSURFCB_FLIP Flip;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfCurrLeft;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfTargLeft;
}

struct DDHAL_DESTROYSURFACEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    HRESULT ddRVal;
    LPDDHALSURFCB_DESTROYSURFACE DestroySurface;
}

struct DDHAL_SETCLIPLISTDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    HRESULT ddRVal;
    LPDDHALSURFCB_SETCLIPLIST SetClipList;
}

struct DDHAL_ADDATTACHEDSURFACEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfAttached;
    HRESULT ddRVal;
    LPDDHALSURFCB_ADDATTACHEDSURFACE AddAttachedSurface;
}

struct DDHAL_SETCOLORKEYDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint dwFlags;
    DDCOLORKEY ckNew;
    HRESULT ddRVal;
    LPDDHALSURFCB_SETCOLORKEY SetColorKey;
}

struct DDHAL_GETBLTSTATUSDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint dwFlags;
    HRESULT ddRVal;
    LPDDHALSURFCB_GETBLTSTATUS GetBltStatus;
}

struct DDHAL_GETFLIPSTATUSDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint dwFlags;
    HRESULT ddRVal;
    LPDDHALSURFCB_GETFLIPSTATUS GetFlipStatus;
}

struct DDHAL_DESTROYPALETTEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWPALETTE_GBL* lpDDPalette;
    HRESULT ddRVal;
    LPDDHALPALCB_DESTROYPALETTE DestroyPalette;
}

struct DDHAL_SETENTRIESDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWPALETTE_GBL* lpDDPalette;
    uint dwBase;
    uint dwNumEntries;
    PALETTEENTRY* lpEntries;
    HRESULT ddRVal;
    LPDDHALPALCB_SETENTRIES SetEntries;
}

struct DDHAL_CREATESURFACEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDSURFACEDESC* lpDDSurfaceDesc;
    DDRAWI_DDRAWSURFACE_LCL** lplpSList;
    uint dwSCnt;
    HRESULT ddRVal;
    LPDDHAL_CREATESURFACE CreateSurface;
}

struct DDHAL_CANCREATESURFACEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDSURFACEDESC* lpDDSurfaceDesc;
    uint bIsDifferentPixelFormat;
    HRESULT ddRVal;
    LPDDHAL_CANCREATESURFACE CanCreateSurface;
}

struct DDHAL_CREATEPALETTEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWPALETTE_GBL* lpDDPalette;
    PALETTEENTRY* lpColorTable;
    HRESULT ddRVal;
    LPDDHAL_CREATEPALETTE CreatePalette;
    BOOL is_excl;
}

struct DDHAL_DESTROYDRIVERDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    HRESULT ddRVal;
    LPDDHAL_DESTROYDRIVER DestroyDriver;
}

struct DDHAL_SETMODEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint dwModeIndex;
    HRESULT ddRVal;
    LPDDHAL_SETMODE SetMode;
    BOOL inexcl;
    BOOL useRefreshRate;
}

struct DDHAL_DRVSETCOLORKEYDATA
{
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint dwFlags;
    DDCOLORKEY ckNew;
    HRESULT ddRVal;
    LPDDHAL_SETCOLORKEY SetColorKey;
}

struct DDHAL_GETSCANLINEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint dwScanLine;
    HRESULT ddRVal;
    LPDDHAL_GETSCANLINE GetScanLine;
}

struct DDHAL_SETEXCLUSIVEMODEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint dwEnterExcl;
    uint dwReserved;
    HRESULT ddRVal;
    LPDDHAL_SETEXCLUSIVEMODE SetExclusiveMode;
}

struct DDHAL_FLIPTOGDISURFACEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint dwToGDI;
    uint dwReserved;
    HRESULT ddRVal;
    LPDDHAL_FLIPTOGDISURFACE FlipToGDISurface;
}

struct DDHAL_CANCREATEVPORTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDVIDEOPORTDESC* lpDDVideoPortDesc;
    HRESULT ddRVal;
    LPDDHALVPORTCB_CANCREATEVIDEOPORT CanCreateVideoPort;
}

struct DDHAL_CREATEVPORTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDVIDEOPORTDESC* lpDDVideoPortDesc;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    HRESULT ddRVal;
    LPDDHALVPORTCB_CREATEVIDEOPORT CreateVideoPort;
}

struct DDHAL_FLIPVPORTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfCurr;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfTarg;
    HRESULT ddRVal;
    LPDDHALVPORTCB_FLIP FlipVideoPort;
}

struct DDHAL_GETVPORTBANDWIDTHDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    DDPIXELFORMAT* lpddpfFormat;
    uint dwWidth;
    uint dwHeight;
    uint dwFlags;
    DDVIDEOPORTBANDWIDTH* lpBandwidth;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETBANDWIDTH GetVideoPortBandwidth;
}

struct DDHAL_GETVPORTINPUTFORMATDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint dwFlags;
    DDPIXELFORMAT* lpddpfFormat;
    uint dwNumFormats;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETINPUTFORMATS GetVideoPortInputFormats;
}

struct DDHAL_GETVPORTOUTPUTFORMATDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint dwFlags;
    DDPIXELFORMAT* lpddpfInputFormat;
    DDPIXELFORMAT* lpddpfOutputFormats;
    uint dwNumFormats;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETOUTPUTFORMATS GetVideoPortOutputFormats;
}

struct DDHAL_GETVPORTFIELDDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    BOOL bField;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETFIELD GetVideoPortField;
}

struct DDHAL_GETVPORTLINEDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint dwLine;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETLINE GetVideoPortLine;
}

struct DDHAL_GETVPORTCONNECTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    uint dwPortId;
    DDVIDEOPORTCONNECT* lpConnect;
    uint dwNumEntries;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETVPORTCONNECT GetVideoPortConnectInfo;
}

struct DDHAL_DESTROYVPORTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    HRESULT ddRVal;
    LPDDHALVPORTCB_DESTROYVPORT DestroyVideoPort;
}

struct DDHAL_GETVPORTFLIPSTATUSDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    uint fpSurface;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETFLIPSTATUS GetVideoPortFlipStatus;
}

struct DDHAL_UPDATEVPORTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    DDRAWI_DDRAWSURFACE_INT** lplpDDSurface;
    DDRAWI_DDRAWSURFACE_INT** lplpDDVBISurface;
    DDVIDEOPORTINFO* lpVideoInfo;
    uint dwFlags;
    uint dwNumAutoflip;
    uint dwNumVBIAutoflip;
    HRESULT ddRVal;
    LPDDHALVPORTCB_UPDATE UpdateVideoPort;
}

struct DDHAL_WAITFORVPORTSYNCDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint dwFlags;
    uint dwLine;
    uint dwTimeOut;
    HRESULT ddRVal;
    LPDDHALVPORTCB_WAITFORSYNC WaitForVideoPortSync;
}

struct DDHAL_GETVPORTSIGNALDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint dwStatus;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETSIGNALSTATUS GetVideoSignalStatus;
}

struct DDHAL_VPORTCOLORDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint dwFlags;
    DDCOLORCONTROL* lpColorData;
    HRESULT ddRVal;
    LPDDHALVPORTCB_COLORCONTROL ColorControl;
}

struct DDHAL_COLORCONTROLDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    DDCOLORCONTROL* lpColorData;
    uint dwFlags;
    HRESULT ddRVal;
    LPDDHALCOLORCB_COLORCONTROL ColorControl;
}

struct DDHAL_GETDRIVERINFODATA
{
    uint dwSize;
    uint dwFlags;
    Guid guidInfo;
    uint dwExpectedSize;
    void* lpvData;
    uint dwActualSize;
    HRESULT ddRVal;
    uint dwContext;
}

struct DDHAL_GETAVAILDRIVERMEMORYDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDSCAPS DDSCaps;
    uint dwTotal;
    uint dwFree;
    HRESULT ddRVal;
    LPDDHAL_GETAVAILDRIVERMEMORY GetAvailDriverMemory;
    DDSCAPSEX ddsCapsEx;
}

struct DDHAL_UPDATENONLOCALHEAPDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint dwHeap;
    uint fpGARTLin;
    uint fpGARTDev;
    uint ulPolicyMaxBytes;
    HRESULT ddRVal;
    LPDDHAL_UPDATENONLOCALHEAP UpdateNonLocalHeap;
}

struct DDHAL_GETHEAPALIGNMENTDATA
{
    uint dwInstance;
    uint dwHeap;
    HRESULT ddRVal;
    LPDDHAL_GETHEAPALIGNMENT GetHeapAlignment;
    HEAPALIGNMENT Alignment;
}

struct DDHAL_CREATESURFACEEXDATA
{
    uint dwFlags;
    DDRAWI_DIRECTDRAW_LCL* lpDDLcl;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSLcl;
    HRESULT ddRVal;
}

struct DDHAL_GETDRIVERSTATEDATA
{
    uint dwFlags;
    _Anonymous_e__Union Anonymous;
    uint* lpdwStates;
    uint dwLength;
    HRESULT ddRVal;
}

struct DDHAL_SYNCSURFACEDATA
{
    uint dwSize;
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint dwSurfaceOffset;
    uint fpLockPtr;
    int lPitch;
    uint dwOverlayOffset;
    uint dwOverlaySrcWidth;
    uint dwOverlaySrcHeight;
    uint dwOverlayDestWidth;
    uint dwOverlayDestHeight;
    uint dwDriverReserved1;
    uint dwDriverReserved2;
    uint dwDriverReserved3;
    HRESULT ddRVal;
}

struct DDHAL_SYNCVIDEOPORTDATA
{
    uint dwSize;
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint dwOriginOffset;
    uint dwHeight;
    uint dwVBIHeight;
    uint dwDriverReserved1;
    uint dwDriverReserved2;
    uint dwDriverReserved3;
    HRESULT ddRVal;
}

struct DDHAL_GETMOCOMPGUIDSDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    uint dwNumGuids;
    Guid* lpGuids;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_GETGUIDS GetMoCompGuids;
}

struct DDHAL_GETMOCOMPFORMATSDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    Guid* lpGuid;
    uint dwNumFormats;
    DDPIXELFORMAT* lpFormats;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_GETFORMATS GetMoCompFormats;
}

struct DDHAL_CREATEMOCOMPDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    Guid* lpGuid;
    uint dwUncompWidth;
    uint dwUncompHeight;
    DDPIXELFORMAT ddUncompPixelFormat;
    void* lpData;
    uint dwDataSize;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_CREATE CreateMoComp;
}

struct DDMCCOMPBUFFERINFO
{
    uint dwSize;
    uint dwNumCompBuffers;
    uint dwWidthToCreate;
    uint dwHeightToCreate;
    uint dwBytesToAllocate;
    DDSCAPS2 ddCompCaps;
    DDPIXELFORMAT ddPixelFormat;
}

struct DDHAL_GETMOCOMPCOMPBUFFDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    Guid* lpGuid;
    uint dwWidth;
    uint dwHeight;
    DDPIXELFORMAT ddPixelFormat;
    uint dwNumTypesCompBuffs;
    DDMCCOMPBUFFERINFO* lpCompBuffInfo;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_GETCOMPBUFFINFO GetMoCompBuffInfo;
}

struct DDHAL_GETINTERNALMOCOMPDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    Guid* lpGuid;
    uint dwWidth;
    uint dwHeight;
    DDPIXELFORMAT ddPixelFormat;
    uint dwScratchMemAlloc;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_GETINTERNALINFO GetInternalMoCompInfo;
}

struct DDHAL_BEGINMOCOMPFRAMEDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    DDRAWI_DDRAWSURFACE_LCL* lpDestSurface;
    uint dwInputDataSize;
    void* lpInputData;
    uint dwOutputDataSize;
    void* lpOutputData;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_BEGINFRAME BeginMoCompFrame;
}

struct DDHAL_ENDMOCOMPFRAMEDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    void* lpInputData;
    uint dwInputDataSize;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_ENDFRAME EndMoCompFrame;
}

struct DDMCBUFFERINFO
{
    uint dwSize;
    DDRAWI_DDRAWSURFACE_LCL* lpCompSurface;
    uint dwDataOffset;
    uint dwDataSize;
    void* lpPrivate;
}

struct DDHAL_RENDERMOCOMPDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    uint dwNumBuffers;
    DDMCBUFFERINFO* lpBufferInfo;
    uint dwFunction;
    void* lpInputData;
    uint dwInputDataSize;
    void* lpOutputData;
    uint dwOutputDataSize;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_RENDER RenderMoComp;
}

struct DDHAL_QUERYMOCOMPSTATUSDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    DDRAWI_DDRAWSURFACE_LCL* lpSurface;
    uint dwFlags;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_QUERYSTATUS QueryMoCompStatus;
}

struct DDHAL_DESTROYMOCOMPDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_DESTROY DestroyMoComp;
}

alias PFNCHECKCONNECTIONWIZARD = extern(Windows) uint function(uint param0, uint* param1);
alias PFNSETSHELLNEXT = extern(Windows) uint function(const(char)* param0);
struct _D3DHAL_CALLBACKS
{
}

struct _D3DHAL_GLOBALDRIVERDATA
{
}

struct STRENTRYA
{
    const(char)* pszName;
    const(char)* pszValue;
}

struct STRENTRYW
{
    const(wchar)* pszName;
    const(wchar)* pszValue;
}

struct STRTABLEA
{
    uint cEntries;
    STRENTRYA* pse;
}

struct STRTABLEW
{
    uint cEntries;
    STRENTRYW* pse;
}

alias REGINSTALLA = extern(Windows) HRESULT function(int hm, const(char)* pszSection, STRTABLEA* pstTable);
struct _CabInfoA
{
    const(char)* pszCab;
    const(char)* pszInf;
    const(char)* pszSection;
    byte szSrcPath;
    uint dwFlags;
}

struct _CabInfoW
{
    const(wchar)* pszCab;
    const(wchar)* pszInf;
    const(wchar)* pszSection;
    ushort szSrcPath;
    uint dwFlags;
}

struct PERUSERSECTIONA
{
    byte szGUID;
    byte szDispName;
    byte szLocale;
    byte szStub;
    byte szVersion;
    byte szCompID;
    uint dwIsInstalled;
    BOOL bRollback;
}

struct PERUSERSECTIONW
{
    ushort szGUID;
    ushort szDispName;
    ushort szLocale;
    ushort szStub;
    ushort szVersion;
    ushort szCompID;
    uint dwIsInstalled;
    BOOL bRollback;
}

struct IMESTRUCT
{
    uint fnc;
    WPARAM wParam;
    uint wCount;
    uint dchSource;
    uint dchDest;
    LPARAM lParam1;
    LPARAM lParam2;
    LPARAM lParam3;
}

struct UNDETERMINESTRUCT
{
    uint dwSize;
    uint uDefIMESize;
    uint uDefIMEPos;
    uint uUndetTextLen;
    uint uUndetTextPos;
    uint uUndetAttrPos;
    uint uCursorPos;
    uint uDeltaStart;
    uint uDetermineTextLen;
    uint uDetermineTextPos;
    uint uDetermineDelimPos;
    uint uYomiTextLen;
    uint uYomiTextPos;
    uint uYomiDelimPos;
}

struct STRINGEXSTRUCT
{
    uint dwSize;
    uint uDeterminePos;
    uint uDetermineDelimPos;
    uint uYomiPos;
    uint uYomiDelimPos;
}

struct DATETIME
{
    ushort year;
    ushort month;
    ushort day;
    ushort hour;
    ushort min;
    ushort sec;
}

struct IMEPROA
{
    HWND hWnd;
    DATETIME InstDate;
    uint wVersion;
    ubyte szDescription;
    ubyte szName;
    ubyte szOptions;
}

struct IMEPROW
{
    HWND hWnd;
    DATETIME InstDate;
    uint wVersion;
    ushort szDescription;
    ushort szName;
    ushort szOptions;
}

const GUID CLSID_WebBrowser_V1 = {0xEAB22AC3, 0x30C1, 0x11CF, [0xA7, 0xEB, 0x00, 0x00, 0xC0, 0x5B, 0xAE, 0x0B]};
@GUID(0xEAB22AC3, 0x30C1, 0x11CF, [0xA7, 0xEB, 0x00, 0x00, 0xC0, 0x5B, 0xAE, 0x0B]);
struct WebBrowser_V1;

const GUID CLSID_WebBrowser = {0x8856F961, 0x340A, 0x11D0, [0xA9, 0x6B, 0x00, 0xC0, 0x4F, 0xD7, 0x05, 0xA2]};
@GUID(0x8856F961, 0x340A, 0x11D0, [0xA9, 0x6B, 0x00, 0xC0, 0x4F, 0xD7, 0x05, 0xA2]);
struct WebBrowser;

const GUID CLSID_InternetExplorer = {0x0002DF01, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0002DF01, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
struct InternetExplorer;

const GUID CLSID_InternetExplorerMedium = {0xD5E8041D, 0x920F, 0x45E9, [0xB8, 0xFB, 0xB1, 0xDE, 0xB8, 0x2C, 0x6E, 0x5E]};
@GUID(0xD5E8041D, 0x920F, 0x45E9, [0xB8, 0xFB, 0xB1, 0xDE, 0xB8, 0x2C, 0x6E, 0x5E]);
struct InternetExplorerMedium;

const GUID CLSID_ShellBrowserWindow = {0xC08AFD90, 0xF2A1, 0x11D1, [0x84, 0x55, 0x00, 0xA0, 0xC9, 0x1F, 0x38, 0x80]};
@GUID(0xC08AFD90, 0xF2A1, 0x11D1, [0x84, 0x55, 0x00, 0xA0, 0xC9, 0x1F, 0x38, 0x80]);
struct ShellBrowserWindow;

const GUID CLSID_ShellWindows = {0x9BA05972, 0xF6A8, 0x11CF, [0xA4, 0x42, 0x00, 0xA0, 0xC9, 0x0A, 0x8F, 0x39]};
@GUID(0x9BA05972, 0xF6A8, 0x11CF, [0xA4, 0x42, 0x00, 0xA0, 0xC9, 0x0A, 0x8F, 0x39]);
struct ShellWindows;

const GUID CLSID_ShellUIHelper = {0x64AB4BB7, 0x111E, 0x11D1, [0x8F, 0x79, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]};
@GUID(0x64AB4BB7, 0x111E, 0x11D1, [0x8F, 0x79, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]);
struct ShellUIHelper;

const GUID CLSID_ShellNameSpace = {0x55136805, 0xB2DE, 0x11D1, [0xB9, 0xF2, 0x00, 0xA0, 0xC9, 0x8B, 0xC5, 0x47]};
@GUID(0x55136805, 0xB2DE, 0x11D1, [0xB9, 0xF2, 0x00, 0xA0, 0xC9, 0x8B, 0xC5, 0x47]);
struct ShellNameSpace;

const GUID CLSID_CScriptErrorList = {0xEFD01300, 0x160F, 0x11D2, [0xBB, 0x2E, 0x00, 0x80, 0x5F, 0xF7, 0xEF, 0xCA]};
@GUID(0xEFD01300, 0x160F, 0x11D2, [0xBB, 0x2E, 0x00, 0x80, 0x5F, 0xF7, 0xEF, 0xCA]);
struct CScriptErrorList;

enum CommandStateChangeConstants
{
    CSC_UPDATECOMMANDS = -1,
    CSC_NAVIGATEFORWARD = 1,
    CSC_NAVIGATEBACK = 2,
}

enum SecureLockIconConstants
{
    secureLockIconUnsecure = 0,
    secureLockIconMixed = 1,
    secureLockIconSecureUnknownBits = 2,
    secureLockIconSecure40Bit = 3,
    secureLockIconSecure56Bit = 4,
    secureLockIconSecureFortezza = 5,
    secureLockIconSecure128Bit = 6,
}

enum NewProcessCauseConstants
{
    ProtectedModeRedirect = 1,
}

enum BrowserNavConstants
{
    navOpenInNewWindow = 1,
    navNoHistory = 2,
    navNoReadFromCache = 4,
    navNoWriteToCache = 8,
    navAllowAutosearch = 16,
    navBrowserBar = 32,
    navHyperlink = 64,
    navEnforceRestricted = 128,
    navNewWindowsManaged = 256,
    navUntrustedForDownload = 512,
    navTrustedForActiveX = 1024,
    navOpenInNewTab = 2048,
    navOpenInBackgroundTab = 4096,
    navKeepWordWheelText = 8192,
    navVirtualTab = 16384,
    navBlockRedirectsXDomain = 32768,
    navOpenNewForegroundTab = 65536,
    navTravelLogScreenshot = 131072,
    navDeferUnload = 262144,
    navSpeculative = 524288,
    navSuggestNewWindow = 1048576,
    navSuggestNewTab = 2097152,
    navReserved1 = 4194304,
    navHomepageNavigate = 8388608,
    navRefresh = 16777216,
    navHostNavigation = 33554432,
    navReserved2 = 67108864,
    navReserved3 = 134217728,
    navReserved4 = 268435456,
    navReserved5 = 536870912,
    navReserved6 = 1073741824,
    navReserved7 = -2147483648,
}

enum RefreshConstants
{
    REFRESH_NORMAL = 0,
    REFRESH_IFEXPIRED = 1,
    REFRESH_COMPLETELY = 3,
}

const GUID IID_IWebBrowser = {0xEAB22AC1, 0x30C1, 0x11CF, [0xA7, 0xEB, 0x00, 0x00, 0xC0, 0x5B, 0xAE, 0x0B]};
@GUID(0xEAB22AC1, 0x30C1, 0x11CF, [0xA7, 0xEB, 0x00, 0x00, 0xC0, 0x5B, 0xAE, 0x0B]);
interface IWebBrowser : IDispatch
{
    HRESULT GoBack();
    HRESULT GoForward();
    HRESULT GoHome();
    HRESULT GoSearch();
    HRESULT Navigate(BSTR URL, VARIANT* Flags, VARIANT* TargetFrameName, VARIANT* PostData, VARIANT* Headers);
    HRESULT Refresh();
    HRESULT Refresh2(VARIANT* Level);
    HRESULT Stop();
    HRESULT get_Application(IDispatch* ppDisp);
    HRESULT get_Parent(IDispatch* ppDisp);
    HRESULT get_Container(IDispatch* ppDisp);
    HRESULT get_Document(IDispatch* ppDisp);
    HRESULT get_TopLevelContainer(short* pBool);
    HRESULT get_Type(BSTR* Type);
    HRESULT get_Left(int* pl);
    HRESULT put_Left(int Left);
    HRESULT get_Top(int* pl);
    HRESULT put_Top(int Top);
    HRESULT get_Width(int* pl);
    HRESULT put_Width(int Width);
    HRESULT get_Height(int* pl);
    HRESULT put_Height(int Height);
    HRESULT get_LocationName(BSTR* LocationName);
    HRESULT get_LocationURL(BSTR* LocationURL);
    HRESULT get_Busy(short* pBool);
}

const GUID IID_DWebBrowserEvents = {0xEAB22AC2, 0x30C1, 0x11CF, [0xA7, 0xEB, 0x00, 0x00, 0xC0, 0x5B, 0xAE, 0x0B]};
@GUID(0xEAB22AC2, 0x30C1, 0x11CF, [0xA7, 0xEB, 0x00, 0x00, 0xC0, 0x5B, 0xAE, 0x0B]);
interface DWebBrowserEvents : IDispatch
{
}

const GUID IID_IWebBrowserApp = {0x0002DF05, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0002DF05, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IWebBrowserApp : IWebBrowser
{
    HRESULT Quit();
    HRESULT ClientToWindow(int* pcx, int* pcy);
    HRESULT PutProperty(BSTR Property, VARIANT vtValue);
    HRESULT GetProperty(BSTR Property, VARIANT* pvtValue);
    HRESULT get_Name(BSTR* Name);
    HRESULT get_HWND(int* pHWND);
    HRESULT get_FullName(BSTR* FullName);
    HRESULT get_Path(BSTR* Path);
    HRESULT get_Visible(short* pBool);
    HRESULT put_Visible(short Value);
    HRESULT get_StatusBar(short* pBool);
    HRESULT put_StatusBar(short Value);
    HRESULT get_StatusText(BSTR* StatusText);
    HRESULT put_StatusText(BSTR StatusText);
    HRESULT get_ToolBar(int* Value);
    HRESULT put_ToolBar(int Value);
    HRESULT get_MenuBar(short* Value);
    HRESULT put_MenuBar(short Value);
    HRESULT get_FullScreen(short* pbFullScreen);
    HRESULT put_FullScreen(short bFullScreen);
}

const GUID IID_IWebBrowser2 = {0xD30C1661, 0xCDAF, 0x11D0, [0x8A, 0x3E, 0x00, 0xC0, 0x4F, 0xC9, 0xE2, 0x6E]};
@GUID(0xD30C1661, 0xCDAF, 0x11D0, [0x8A, 0x3E, 0x00, 0xC0, 0x4F, 0xC9, 0xE2, 0x6E]);
interface IWebBrowser2 : IWebBrowserApp
{
    HRESULT Navigate2(VARIANT* URL, VARIANT* Flags, VARIANT* TargetFrameName, VARIANT* PostData, VARIANT* Headers);
    HRESULT QueryStatusWB(OLECMDID cmdID, OLECMDF* pcmdf);
    HRESULT ExecWB(OLECMDID cmdID, OLECMDEXECOPT cmdexecopt, VARIANT* pvaIn, VARIANT* pvaOut);
    HRESULT ShowBrowserBar(VARIANT* pvaClsid, VARIANT* pvarShow, VARIANT* pvarSize);
    HRESULT get_ReadyState(READYSTATE* plReadyState);
    HRESULT get_Offline(short* pbOffline);
    HRESULT put_Offline(short bOffline);
    HRESULT get_Silent(short* pbSilent);
    HRESULT put_Silent(short bSilent);
    HRESULT get_RegisterAsBrowser(short* pbRegister);
    HRESULT put_RegisterAsBrowser(short bRegister);
    HRESULT get_RegisterAsDropTarget(short* pbRegister);
    HRESULT put_RegisterAsDropTarget(short bRegister);
    HRESULT get_TheaterMode(short* pbRegister);
    HRESULT put_TheaterMode(short bRegister);
    HRESULT get_AddressBar(short* Value);
    HRESULT put_AddressBar(short Value);
    HRESULT get_Resizable(short* Value);
    HRESULT put_Resizable(short Value);
}

const GUID IID_DWebBrowserEvents2 = {0x34A715A0, 0x6587, 0x11D0, [0x92, 0x4A, 0x00, 0x20, 0xAF, 0xC7, 0xAC, 0x4D]};
@GUID(0x34A715A0, 0x6587, 0x11D0, [0x92, 0x4A, 0x00, 0x20, 0xAF, 0xC7, 0xAC, 0x4D]);
interface DWebBrowserEvents2 : IDispatch
{
}

const GUID IID_DShellWindowsEvents = {0xFE4106E0, 0x399A, 0x11D0, [0xA4, 0x8C, 0x00, 0xA0, 0xC9, 0x0A, 0x8F, 0x39]};
@GUID(0xFE4106E0, 0x399A, 0x11D0, [0xA4, 0x8C, 0x00, 0xA0, 0xC9, 0x0A, 0x8F, 0x39]);
interface DShellWindowsEvents : IDispatch
{
}

const GUID IID_IShellUIHelper = {0x729FE2F8, 0x1EA8, 0x11D1, [0x8F, 0x85, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]};
@GUID(0x729FE2F8, 0x1EA8, 0x11D1, [0x8F, 0x85, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]);
interface IShellUIHelper : IDispatch
{
    HRESULT ResetFirstBootMode();
    HRESULT ResetSafeMode();
    HRESULT RefreshOfflineDesktop();
    HRESULT AddFavorite(BSTR URL, VARIANT* Title);
    HRESULT AddChannel(BSTR URL);
    HRESULT AddDesktopComponent(BSTR URL, BSTR Type, VARIANT* Left, VARIANT* Top, VARIANT* Width, VARIANT* Height);
    HRESULT IsSubscribed(BSTR URL, short* pBool);
    HRESULT NavigateAndFind(BSTR URL, BSTR strQuery, VARIANT* varTargetFrame);
    HRESULT ImportExportFavorites(short fImport, BSTR strImpExpPath);
    HRESULT AutoCompleteSaveForm(VARIANT* Form);
    HRESULT AutoScan(BSTR strSearch, BSTR strFailureUrl, VARIANT* pvarTargetFrame);
    HRESULT AutoCompleteAttach(VARIANT* Reserved);
    HRESULT ShowBrowserUI(BSTR bstrName, VARIANT* pvarIn, VARIANT* pvarOut);
}

const GUID IID_IShellUIHelper2 = {0xA7FE6EDA, 0x1932, 0x4281, [0xB8, 0x81, 0x87, 0xB3, 0x1B, 0x8B, 0xC5, 0x2C]};
@GUID(0xA7FE6EDA, 0x1932, 0x4281, [0xB8, 0x81, 0x87, 0xB3, 0x1B, 0x8B, 0xC5, 0x2C]);
interface IShellUIHelper2 : IShellUIHelper
{
    HRESULT AddSearchProvider(BSTR URL);
    HRESULT RunOnceShown();
    HRESULT SkipRunOnce();
    HRESULT CustomizeSettings(short fSQM, short fPhishing, BSTR bstrLocale);
    HRESULT SqmEnabled(short* pfEnabled);
    HRESULT PhishingEnabled(short* pfEnabled);
    HRESULT BrandImageUri(BSTR* pbstrUri);
    HRESULT SkipTabsWelcome();
    HRESULT DiagnoseConnection();
    HRESULT CustomizeClearType(short fSet);
    HRESULT IsSearchProviderInstalled(BSTR URL, uint* pdwResult);
    HRESULT IsSearchMigrated(short* pfMigrated);
    HRESULT DefaultSearchProvider(BSTR* pbstrName);
    HRESULT RunOnceRequiredSettingsComplete(short fComplete);
    HRESULT RunOnceHasShown(short* pfShown);
    HRESULT SearchGuideUrl(BSTR* pbstrUrl);
}

const GUID IID_IShellUIHelper3 = {0x528DF2EC, 0xD419, 0x40BC, [0x9B, 0x6D, 0xDC, 0xDB, 0xF9, 0xC1, 0xB2, 0x5D]};
@GUID(0x528DF2EC, 0xD419, 0x40BC, [0x9B, 0x6D, 0xDC, 0xDB, 0xF9, 0xC1, 0xB2, 0x5D]);
interface IShellUIHelper3 : IShellUIHelper2
{
    HRESULT AddService(BSTR URL);
    HRESULT IsServiceInstalled(BSTR URL, BSTR Verb, uint* pdwResult);
    HRESULT InPrivateFilteringEnabled(short* pfEnabled);
    HRESULT AddToFavoritesBar(BSTR URL, BSTR Title, VARIANT* Type);
    HRESULT BuildNewTabPage();
    HRESULT SetRecentlyClosedVisible(short fVisible);
    HRESULT SetActivitiesVisible(short fVisible);
    HRESULT ContentDiscoveryReset();
    HRESULT IsSuggestedSitesEnabled(short* pfEnabled);
    HRESULT EnableSuggestedSites(short fEnable);
    HRESULT NavigateToSuggestedSites(BSTR bstrRelativeUrl);
    HRESULT ShowTabsHelp();
    HRESULT ShowInPrivateHelp();
}

const GUID IID_IShellUIHelper4 = {0xB36E6A53, 0x8073, 0x499E, [0x82, 0x4C, 0xD7, 0x76, 0x33, 0x0A, 0x33, 0x3E]};
@GUID(0xB36E6A53, 0x8073, 0x499E, [0x82, 0x4C, 0xD7, 0x76, 0x33, 0x0A, 0x33, 0x3E]);
interface IShellUIHelper4 : IShellUIHelper3
{
    HRESULT msIsSiteMode(short* pfSiteMode);
    HRESULT msSiteModeShowThumbBar();
    HRESULT msSiteModeAddThumbBarButton(BSTR bstrIconURL, BSTR bstrTooltip, VARIANT* pvarButtonID);
    HRESULT msSiteModeUpdateThumbBarButton(VARIANT ButtonID, short fEnabled, short fVisible);
    HRESULT msSiteModeSetIconOverlay(BSTR IconUrl, VARIANT* pvarDescription);
    HRESULT msSiteModeClearIconOverlay();
    HRESULT msAddSiteMode();
    HRESULT msSiteModeCreateJumpList(BSTR bstrHeader);
    HRESULT msSiteModeAddJumpListItem(BSTR bstrName, BSTR bstrActionUri, BSTR bstrIconUri, VARIANT* pvarWindowType);
    HRESULT msSiteModeClearJumpList();
    HRESULT msSiteModeShowJumpList();
    HRESULT msSiteModeAddButtonStyle(VARIANT uiButtonID, BSTR bstrIconUrl, BSTR bstrTooltip, VARIANT* pvarStyleID);
    HRESULT msSiteModeShowButtonStyle(VARIANT uiButtonID, VARIANT uiStyleID);
    HRESULT msSiteModeActivate();
    HRESULT msIsSiteModeFirstRun(short fPreserveState, VARIANT* puiFirstRun);
    HRESULT msAddTrackingProtectionList(BSTR URL, BSTR bstrFilterName);
    HRESULT msTrackingProtectionEnabled(short* pfEnabled);
    HRESULT msActiveXFilteringEnabled(short* pfEnabled);
}

const GUID IID_IShellUIHelper5 = {0xA2A08B09, 0x103D, 0x4D3F, [0xB9, 0x1C, 0xEA, 0x45, 0x5C, 0xA8, 0x2E, 0xFA]};
@GUID(0xA2A08B09, 0x103D, 0x4D3F, [0xB9, 0x1C, 0xEA, 0x45, 0x5C, 0xA8, 0x2E, 0xFA]);
interface IShellUIHelper5 : IShellUIHelper4
{
    HRESULT msProvisionNetworks(BSTR bstrProvisioningXml, VARIANT* puiResult);
    HRESULT msReportSafeUrl();
    HRESULT msSiteModeRefreshBadge();
    HRESULT msSiteModeClearBadge();
    HRESULT msDiagnoseConnectionUILess();
    HRESULT msLaunchNetworkClientHelp();
    HRESULT msChangeDefaultBrowser(short fChange);
}

const GUID IID_IShellUIHelper6 = {0x987A573E, 0x46EE, 0x4E89, [0x96, 0xAB, 0xDD, 0xF7, 0xF8, 0xFD, 0xC9, 0x8C]};
@GUID(0x987A573E, 0x46EE, 0x4E89, [0x96, 0xAB, 0xDD, 0xF7, 0xF8, 0xFD, 0xC9, 0x8C]);
interface IShellUIHelper6 : IShellUIHelper5
{
    HRESULT msStopPeriodicTileUpdate();
    HRESULT msStartPeriodicTileUpdate(VARIANT pollingUris, VARIANT startTime, VARIANT uiUpdateRecurrence);
    HRESULT msStartPeriodicTileUpdateBatch(VARIANT pollingUris, VARIANT startTime, VARIANT uiUpdateRecurrence);
    HRESULT msClearTile();
    HRESULT msEnableTileNotificationQueue(short fChange);
    HRESULT msPinnedSiteState(VARIANT* pvarSiteState);
    HRESULT msEnableTileNotificationQueueForSquare150x150(short fChange);
    HRESULT msEnableTileNotificationQueueForWide310x150(short fChange);
    HRESULT msEnableTileNotificationQueueForSquare310x310(short fChange);
    HRESULT msScheduledTileNotification(BSTR bstrNotificationXml, BSTR bstrNotificationId, BSTR bstrNotificationTag, VARIANT startTime, VARIANT expirationTime);
    HRESULT msRemoveScheduledTileNotification(BSTR bstrNotificationId);
    HRESULT msStartPeriodicBadgeUpdate(BSTR pollingUri, VARIANT startTime, VARIANT uiUpdateRecurrence);
    HRESULT msStopPeriodicBadgeUpdate();
    HRESULT msLaunchInternetOptions();
}

const GUID IID_IShellUIHelper7 = {0x60E567C8, 0x9573, 0x4AB2, [0xA2, 0x64, 0x63, 0x7C, 0x6C, 0x16, 0x1C, 0xB1]};
@GUID(0x60E567C8, 0x9573, 0x4AB2, [0xA2, 0x64, 0x63, 0x7C, 0x6C, 0x16, 0x1C, 0xB1]);
interface IShellUIHelper7 : IShellUIHelper6
{
    HRESULT SetExperimentalFlag(BSTR bstrFlagString, short vfFlag);
    HRESULT GetExperimentalFlag(BSTR bstrFlagString, short* vfFlag);
    HRESULT SetExperimentalValue(BSTR bstrValueString, uint dwValue);
    HRESULT GetExperimentalValue(BSTR bstrValueString, uint* pdwValue);
    HRESULT ResetAllExperimentalFlagsAndValues();
    HRESULT GetNeedIEAutoLaunchFlag(BSTR bstrUrl, short* flag);
    HRESULT SetNeedIEAutoLaunchFlag(BSTR bstrUrl, short flag);
    HRESULT HasNeedIEAutoLaunchFlag(BSTR bstrUrl, short* exists);
    HRESULT LaunchIE(BSTR bstrUrl, short automated);
}

const GUID IID_IShellUIHelper8 = {0x66DEBCF2, 0x05B0, 0x4F07, [0xB4, 0x9B, 0xB9, 0x62, 0x41, 0xA6, 0x5D, 0xB2]};
@GUID(0x66DEBCF2, 0x05B0, 0x4F07, [0xB4, 0x9B, 0xB9, 0x62, 0x41, 0xA6, 0x5D, 0xB2]);
interface IShellUIHelper8 : IShellUIHelper7
{
    HRESULT GetCVListData(BSTR* pbstrResult);
    HRESULT GetCVListLocalData(BSTR* pbstrResult);
    HRESULT GetEMIEListData(BSTR* pbstrResult);
    HRESULT GetEMIEListLocalData(BSTR* pbstrResult);
    HRESULT OpenFavoritesPane();
    HRESULT OpenFavoritesSettings();
    HRESULT LaunchInHVSI(BSTR bstrUrl);
}

const GUID IID_IShellUIHelper9 = {0x6CDF73B0, 0x7F2F, 0x451F, [0xBC, 0x0F, 0x63, 0xE0, 0xF3, 0x28, 0x4E, 0x54]};
@GUID(0x6CDF73B0, 0x7F2F, 0x451F, [0xBC, 0x0F, 0x63, 0xE0, 0xF3, 0x28, 0x4E, 0x54]);
interface IShellUIHelper9 : IShellUIHelper8
{
    HRESULT GetOSSku(uint* pdwResult);
}

const GUID IID_DShellNameSpaceEvents = {0x55136806, 0xB2DE, 0x11D1, [0xB9, 0xF2, 0x00, 0xA0, 0xC9, 0x8B, 0xC5, 0x47]};
@GUID(0x55136806, 0xB2DE, 0x11D1, [0xB9, 0xF2, 0x00, 0xA0, 0xC9, 0x8B, 0xC5, 0x47]);
interface DShellNameSpaceEvents : IDispatch
{
}

const GUID IID_IShellFavoritesNameSpace = {0x55136804, 0xB2DE, 0x11D1, [0xB9, 0xF2, 0x00, 0xA0, 0xC9, 0x8B, 0xC5, 0x47]};
@GUID(0x55136804, 0xB2DE, 0x11D1, [0xB9, 0xF2, 0x00, 0xA0, 0xC9, 0x8B, 0xC5, 0x47]);
interface IShellFavoritesNameSpace : IDispatch
{
    HRESULT MoveSelectionUp();
    HRESULT MoveSelectionDown();
    HRESULT ResetSort();
    HRESULT NewFolder();
    HRESULT Synchronize();
    HRESULT Import();
    HRESULT Export();
    HRESULT InvokeContextMenuCommand(BSTR strCommand);
    HRESULT MoveSelectionTo();
    HRESULT get_SubscriptionsEnabled(short* pBool);
    HRESULT CreateSubscriptionForSelection(short* pBool);
    HRESULT DeleteSubscriptionForSelection(short* pBool);
    HRESULT SetRoot(BSTR bstrFullPath);
}

const GUID IID_IShellNameSpace = {0xE572D3C9, 0x37BE, 0x4AE2, [0x82, 0x5D, 0xD5, 0x21, 0x76, 0x3E, 0x31, 0x08]};
@GUID(0xE572D3C9, 0x37BE, 0x4AE2, [0x82, 0x5D, 0xD5, 0x21, 0x76, 0x3E, 0x31, 0x08]);
interface IShellNameSpace : IShellFavoritesNameSpace
{
    HRESULT get_EnumOptions(int* pgrfEnumFlags);
    HRESULT put_EnumOptions(int lVal);
    HRESULT get_SelectedItem(IDispatch* pItem);
    HRESULT put_SelectedItem(IDispatch pItem);
    HRESULT get_Root(VARIANT* pvar);
    HRESULT put_Root(VARIANT var);
    HRESULT get_Depth(int* piDepth);
    HRESULT put_Depth(int iDepth);
    HRESULT get_Mode(uint* puMode);
    HRESULT put_Mode(uint uMode);
    HRESULT get_Flags(uint* pdwFlags);
    HRESULT put_Flags(uint dwFlags);
    HRESULT put_TVFlags(uint dwFlags);
    HRESULT get_TVFlags(uint* dwFlags);
    HRESULT get_Columns(BSTR* bstrColumns);
    HRESULT put_Columns(BSTR bstrColumns);
    HRESULT get_CountViewTypes(int* piTypes);
    HRESULT SetViewType(int iType);
    HRESULT SelectedItems(IDispatch* ppid);
    HRESULT Expand(VARIANT var, int iDepth);
    HRESULT UnselectAll();
}

const GUID IID_IScriptErrorList = {0xF3470F24, 0x15FD, 0x11D2, [0xBB, 0x2E, 0x00, 0x80, 0x5F, 0xF7, 0xEF, 0xCA]};
@GUID(0xF3470F24, 0x15FD, 0x11D2, [0xBB, 0x2E, 0x00, 0x80, 0x5F, 0xF7, 0xEF, 0xCA]);
interface IScriptErrorList : IDispatch
{
    HRESULT advanceError();
    HRESULT retreatError();
    HRESULT canAdvanceError(int* pfCanAdvance);
    HRESULT canRetreatError(int* pfCanRetreat);
    HRESULT getErrorLine(int* plLine);
    HRESULT getErrorChar(int* plChar);
    HRESULT getErrorCode(int* plCode);
    HRESULT getErrorMsg(BSTR* pstr);
    HRESULT getErrorUrl(BSTR* pstr);
    HRESULT getAlwaysShowLockState(int* pfAlwaysShowLocked);
    HRESULT getDetailsPaneOpen(int* pfDetailsPaneOpen);
    HRESULT setDetailsPaneOpen(BOOL fDetailsPaneOpen);
    HRESULT getPerErrorDisplay(int* pfPerErrorDisplay);
    HRESULT setPerErrorDisplay(BOOL fPerErrorDisplay);
}

struct JAVA_TRUST
{
    uint cbSize;
    uint flag;
    BOOL fAllActiveXPermissions;
    BOOL fAllPermissions;
    uint dwEncodingType;
    ubyte* pbJavaPermissions;
    uint cbJavaPermissions;
    ubyte* pbSigner;
    uint cbSigner;
    const(wchar)* pwszZone;
    Guid guidZone;
    HRESULT hVerify;
}

const GUID CLSID_IsolatedAppLauncher = {0xBC812430, 0xE75E, 0x4FD1, [0x96, 0x41, 0x1F, 0x9F, 0x1E, 0x2D, 0x9A, 0x1F]};
@GUID(0xBC812430, 0xE75E, 0x4FD1, [0x96, 0x41, 0x1F, 0x9F, 0x1E, 0x2D, 0x9A, 0x1F]);
struct IsolatedAppLauncher;

struct IsolatedAppLauncherTelemetryParameters
{
    BOOL EnableForLaunch;
    Guid CorrelationGUID;
}

const GUID IID_IIsolatedAppLauncher = {0xF686878F, 0x7B42, 0x4CC4, [0x96, 0xFB, 0xF4, 0xF3, 0xB6, 0xE3, 0xD2, 0x4D]};
@GUID(0xF686878F, 0x7B42, 0x4CC4, [0x96, 0xFB, 0xF4, 0xF3, 0xB6, 0xE3, 0xD2, 0x4D]);
interface IIsolatedAppLauncher : IUnknown
{
    HRESULT Launch(const(wchar)* appUserModelId, const(wchar)* arguments, const(IsolatedAppLauncherTelemetryParameters)* telemetryParameters);
}

const GUID CLSID_WSCProductList = {0x17072F7B, 0x9ABE, 0x4A74, [0xA2, 0x61, 0x1E, 0xB7, 0x6B, 0x55, 0x10, 0x7A]};
@GUID(0x17072F7B, 0x9ABE, 0x4A74, [0xA2, 0x61, 0x1E, 0xB7, 0x6B, 0x55, 0x10, 0x7A]);
struct WSCProductList;

const GUID CLSID_WSCDefaultProduct = {0x2981A36E, 0xF22D, 0x11E5, [0x9C, 0xE9, 0x5E, 0x55, 0x17, 0x50, 0x7C, 0x66]};
@GUID(0x2981A36E, 0xF22D, 0x11E5, [0x9C, 0xE9, 0x5E, 0x55, 0x17, 0x50, 0x7C, 0x66]);
struct WSCDefaultProduct;

enum WSC_SECURITY_PRODUCT_SUBSTATUS
{
    WSC_SECURITY_PRODUCT_SUBSTATUS_NOT_SET = 0,
    WSC_SECURITY_PRODUCT_SUBSTATUS_NO_ACTION = 1,
    WSC_SECURITY_PRODUCT_SUBSTATUS_ACTION_RECOMMENDED = 2,
    WSC_SECURITY_PRODUCT_SUBSTATUS_ACTION_NEEDED = 3,
}

enum WSC_SECURITY_PRODUCT_STATE
{
    WSC_SECURITY_PRODUCT_STATE_ON = 0,
    WSC_SECURITY_PRODUCT_STATE_OFF = 1,
    WSC_SECURITY_PRODUCT_STATE_SNOOZED = 2,
    WSC_SECURITY_PRODUCT_STATE_EXPIRED = 3,
}

enum SECURITY_PRODUCT_TYPE
{
    SECURITY_PRODUCT_TYPE_ANTIVIRUS = 0,
    SECURITY_PRODUCT_TYPE_FIREWALL = 1,
    SECURITY_PRODUCT_TYPE_ANTISPYWARE = 2,
}

enum WSC_SECURITY_SIGNATURE_STATUS
{
    WSC_SECURITY_PRODUCT_OUT_OF_DATE = 0,
    WSC_SECURITY_PRODUCT_UP_TO_DATE = 1,
}

const GUID IID_IWscProduct = {0x8C38232E, 0x3A45, 0x4A27, [0x92, 0xB0, 0x1A, 0x16, 0xA9, 0x75, 0xF6, 0x69]};
@GUID(0x8C38232E, 0x3A45, 0x4A27, [0x92, 0xB0, 0x1A, 0x16, 0xA9, 0x75, 0xF6, 0x69]);
interface IWscProduct : IDispatch
{
    HRESULT get_ProductName(BSTR* pVal);
    HRESULT get_ProductState(WSC_SECURITY_PRODUCT_STATE* pVal);
    HRESULT get_SignatureStatus(WSC_SECURITY_SIGNATURE_STATUS* pVal);
    HRESULT get_RemediationPath(BSTR* pVal);
    HRESULT get_ProductStateTimestamp(BSTR* pVal);
    HRESULT get_ProductGuid(BSTR* pVal);
    HRESULT get_ProductIsDefault(int* pVal);
}

const GUID IID_IWscProduct2 = {0xF896CA54, 0xFE09, 0x4403, [0x86, 0xD4, 0x23, 0xCB, 0x48, 0x8D, 0x81, 0xD8]};
@GUID(0xF896CA54, 0xFE09, 0x4403, [0x86, 0xD4, 0x23, 0xCB, 0x48, 0x8D, 0x81, 0xD8]);
interface IWscProduct2 : IWscProduct
{
    HRESULT get_AntivirusScanSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_AntivirusSettingsSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_AntivirusProtectionUpdateSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_FirewallDomainProfileSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_FirewallPrivateProfileSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_FirewallPublicProfileSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
}

const GUID IID_IWscProduct3 = {0x55536524, 0xD1D1, 0x4726, [0x8C, 0x7C, 0x04, 0x99, 0x6A, 0x19, 0x04, 0xE7]};
@GUID(0x55536524, 0xD1D1, 0x4726, [0x8C, 0x7C, 0x04, 0x99, 0x6A, 0x19, 0x04, 0xE7]);
interface IWscProduct3 : IWscProduct2
{
    HRESULT get_AntivirusDaysUntilExpired(uint* pdwDays);
}

const GUID IID_IWSCProductList = {0x722A338C, 0x6E8E, 0x4E72, [0xAC, 0x27, 0x14, 0x17, 0xFB, 0x0C, 0x81, 0xC2]};
@GUID(0x722A338C, 0x6E8E, 0x4E72, [0xAC, 0x27, 0x14, 0x17, 0xFB, 0x0C, 0x81, 0xC2]);
interface IWSCProductList : IDispatch
{
    HRESULT Initialize(uint provider);
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(uint index, IWscProduct* pVal);
}

const GUID IID_IWSCDefaultProduct = {0x0476D69C, 0xF21A, 0x11E5, [0x9C, 0xE9, 0x5E, 0x55, 0x17, 0x50, 0x7C, 0x66]};
@GUID(0x0476D69C, 0xF21A, 0x11E5, [0x9C, 0xE9, 0x5E, 0x55, 0x17, 0x50, 0x7C, 0x66]);
interface IWSCDefaultProduct : IDispatch
{
    HRESULT SetDefaultProduct(SECURITY_PRODUCT_TYPE eType, BSTR pGuid);
}

enum WSC_SECURITY_PROVIDER
{
    WSC_SECURITY_PROVIDER_FIREWALL = 1,
    WSC_SECURITY_PROVIDER_AUTOUPDATE_SETTINGS = 2,
    WSC_SECURITY_PROVIDER_ANTIVIRUS = 4,
    WSC_SECURITY_PROVIDER_ANTISPYWARE = 8,
    WSC_SECURITY_PROVIDER_INTERNET_SETTINGS = 16,
    WSC_SECURITY_PROVIDER_USER_ACCOUNT_CONTROL = 32,
    WSC_SECURITY_PROVIDER_SERVICE = 64,
    WSC_SECURITY_PROVIDER_NONE = 0,
    WSC_SECURITY_PROVIDER_ALL = 127,
}

enum WSC_SECURITY_PROVIDER_HEALTH
{
    WSC_SECURITY_PROVIDER_HEALTH_GOOD = 0,
    WSC_SECURITY_PROVIDER_HEALTH_NOTMONITORED = 1,
    WSC_SECURITY_PROVIDER_HEALTH_POOR = 2,
    WSC_SECURITY_PROVIDER_HEALTH_SNOOZE = 3,
}

alias PFN_IO_COMPLETION = extern(Windows) void function(FIO_CONTEXT* pContext, FH_OVERLAPPED* lpo, uint cb, uint dwCompletionStatus);
struct FH_OVERLAPPED
{
    uint Internal;
    uint InternalHigh;
    uint Offset;
    uint OffsetHigh;
    HANDLE hEvent;
    PFN_IO_COMPLETION pfnCompletion;
    uint Reserved1;
    uint Reserved2;
    uint Reserved3;
    uint Reserved4;
}

struct FIO_CONTEXT
{
    uint m_dwTempHack;
    uint m_dwSignature;
    HANDLE m_hFile;
    uint m_dwLinesOffset;
    uint m_dwHeaderLength;
}

alias FCACHE_CREATE_CALLBACK = extern(Windows) HANDLE function(const(char)* lpstrName, void* lpvData, uint* cbFileSize, uint* cbFileSizeHigh);
alias FCACHE_RICHCREATE_CALLBACK = extern(Windows) HANDLE function(const(char)* lpstrName, void* lpvData, uint* cbFileSize, uint* cbFileSizeHigh, int* pfDidWeScanIt, int* pfIsStuffed, int* pfStoredWithDots, int* pfStoredWithTerminatingDot);
alias CACHE_KEY_COMPARE = extern(Windows) int function(uint cbKey1, ubyte* lpbKey1, uint cbKey2, ubyte* lpbKey2);
alias CACHE_KEY_HASH = extern(Windows) uint function(ubyte* lpbKey, uint cbKey);
alias CACHE_READ_CALLBACK = extern(Windows) BOOL function(uint cb, ubyte* lpb, void* lpvContext);
alias CACHE_DESTROY_CALLBACK = extern(Windows) void function(uint cb, ubyte* lpb);
alias CACHE_ACCESS_CHECK = extern(Windows) BOOL function(void* pSecurityDescriptor, HANDLE hClientToken, uint dwDesiredAccess, GENERIC_MAPPING* GenericMapping, PRIVILEGE_SET* PrivilegeSet, uint* PrivilegeSetLength, uint* GrantedAccess, int* AccessStatus);
struct NAME_CACHE_CONTEXT
{
    uint m_dwSignature;
}

struct TDIEntityID
{
    uint tei_entity;
    uint tei_instance;
}

struct TDIObjectID
{
    TDIEntityID toi_entity;
    uint toi_class;
    uint toi_type;
    uint toi_id;
}

struct tcp_request_query_information_ex_xp
{
    TDIObjectID ID;
    uint Context;
}

struct tcp_request_query_information_ex_w2k
{
    TDIObjectID ID;
    ubyte Context;
}

struct tcp_request_set_information_ex
{
    TDIObjectID ID;
    uint BufferSize;
    ubyte Buffer;
}

enum TDI_TL_IO_CONTROL_TYPE
{
    EndpointIoControlType = 0,
    SetSockOptIoControlType = 1,
    GetSockOptIoControlType = 2,
    SocketIoControlType = 3,
}

struct TDI_TL_IO_CONTROL_ENDPOINT
{
    TDI_TL_IO_CONTROL_TYPE Type;
    uint Level;
    _Anonymous_e__Union Anonymous;
    void* InputBuffer;
    uint InputBufferLength;
    void* OutputBuffer;
    uint OutputBufferLength;
}

enum WLDP_HOST
{
    WLDP_HOST_RUNDLL32 = 0,
    WLDP_HOST_SVCHOST = 1,
    WLDP_HOST_MAX = 2,
}

enum WLDP_HOST_ID
{
    WLDP_HOST_ID_UNKNOWN = 0,
    WLDP_HOST_ID_GLOBAL = 1,
    WLDP_HOST_ID_VBA = 2,
    WLDP_HOST_ID_WSH = 3,
    WLDP_HOST_ID_POWERSHELL = 4,
    WLDP_HOST_ID_IE = 5,
    WLDP_HOST_ID_MSI = 6,
    WLDP_HOST_ID_ALL = 7,
    WLDP_HOST_ID_MAX = 8,
}

enum DECISION_LOCATION
{
    DECISION_LOCATION_REFRESH_GLOBAL_DATA = 0,
    DECISION_LOCATION_PARAMETER_VALIDATION = 1,
    DECISION_LOCATION_AUDIT = 2,
    DECISION_LOCATION_FAILED_CONVERT_GUID = 3,
    DECISION_LOCATION_ENTERPRISE_DEFINED_CLASS_ID = 4,
    DECISION_LOCATION_GLOBAL_BUILT_IN_LIST = 5,
    DECISION_LOCATION_PROVIDER_BUILT_IN_LIST = 6,
    DECISION_LOCATION_ENFORCE_STATE_LIST = 7,
    DECISION_LOCATION_NOT_FOUND = 8,
    DECISION_LOCATION_UNKNOWN = 9,
}

enum WLDP_KEY
{
    KEY_UNKNOWN = 0,
    KEY_OVERRIDE = 1,
    KEY_ALL_KEYS = 2,
}

enum VALUENAME
{
    VALUENAME_UNKNOWN = 0,
    VALUENAME_ENTERPRISE_DEFINED_CLASS_ID = 1,
    VALUENAME_BUILT_IN_LIST = 2,
}

enum WLDP_WINDOWS_LOCKDOWN_MODE
{
    WLDP_WINDOWS_LOCKDOWN_MODE_UNLOCKED = 0,
    WLDP_WINDOWS_LOCKDOWN_MODE_TRIAL = 1,
    WLDP_WINDOWS_LOCKDOWN_MODE_LOCKED = 2,
    WLDP_WINDOWS_LOCKDOWN_MODE_MAX = 3,
}

enum WLDP_WINDOWS_LOCKDOWN_RESTRICTION
{
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NONE = 0,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NOUNLOCK = 1,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NOUNLOCK_PERMANENT = 2,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_MAX = 3,
}

struct WLDP_HOST_INFORMATION
{
    uint dwRevision;
    WLDP_HOST_ID dwHostId;
    const(wchar)* szSource;
    HANDLE hSource;
}

alias PWLDP_SETDYNAMICCODETRUST_API = extern(Windows) HRESULT function(HANDLE hFileHandle);
alias PWLDP_ISDYNAMICCODEPOLICYENABLED_API = extern(Windows) HRESULT function(int* pbEnabled);
alias PWLDP_QUERYDYNAMICODETRUST_API = extern(Windows) HRESULT function(HANDLE fileHandle, char* baseImage, uint imageSize);
alias PWLDP_QUERYWINDOWSLOCKDOWNMODE_API = extern(Windows) HRESULT function(WLDP_WINDOWS_LOCKDOWN_MODE* lockdownMode);
alias PWLDP_QUERYWINDOWSLOCKDOWNRESTRICTION_API = extern(Windows) HRESULT function(WLDP_WINDOWS_LOCKDOWN_RESTRICTION* LockdownRestriction);
alias PWLDP_SETWINDOWSLOCKDOWNRESTRICTION_API = extern(Windows) HRESULT function(WLDP_WINDOWS_LOCKDOWN_RESTRICTION LockdownRestriction);
alias PWLDP_WLDPISAPPAPPROVEDBYPOLICY_API = extern(Windows) HRESULT function(const(wchar)* PackageFamilyName, ulong PackageVersion);
enum XmlNodeType
{
    XmlNodeType_None = 0,
    XmlNodeType_Element = 1,
    XmlNodeType_Attribute = 2,
    XmlNodeType_Text = 3,
    XmlNodeType_CDATA = 4,
    XmlNodeType_ProcessingInstruction = 7,
    XmlNodeType_Comment = 8,
    XmlNodeType_DocumentType = 10,
    XmlNodeType_Whitespace = 13,
    XmlNodeType_EndElement = 15,
    XmlNodeType_XmlDeclaration = 17,
    _XmlNodeType_Last = 17,
}

enum XmlConformanceLevel
{
    XmlConformanceLevel_Auto = 0,
    XmlConformanceLevel_Fragment = 1,
    XmlConformanceLevel_Document = 2,
    _XmlConformanceLevel_Last = 2,
}

enum DtdProcessing
{
    DtdProcessing_Prohibit = 0,
    DtdProcessing_Parse = 1,
    _DtdProcessing_Last = 1,
}

enum XmlReadState
{
    XmlReadState_Initial = 0,
    XmlReadState_Interactive = 1,
    XmlReadState_Error = 2,
    XmlReadState_EndOfFile = 3,
    XmlReadState_Closed = 4,
}

enum XmlReaderProperty
{
    XmlReaderProperty_MultiLanguage = 0,
    XmlReaderProperty_ConformanceLevel = 1,
    XmlReaderProperty_RandomAccess = 2,
    XmlReaderProperty_XmlResolver = 3,
    XmlReaderProperty_DtdProcessing = 4,
    XmlReaderProperty_ReadState = 5,
    XmlReaderProperty_MaxElementDepth = 6,
    XmlReaderProperty_MaxEntityExpansion = 7,
    _XmlReaderProperty_Last = 7,
}

enum XmlError
{
    MX_E_MX = -1072894464,
    MX_E_INPUTEND = -1072894463,
    MX_E_ENCODING = -1072894462,
    MX_E_ENCODINGSWITCH = -1072894461,
    MX_E_ENCODINGSIGNATURE = -1072894460,
    WC_E_WC = -1072894432,
    WC_E_WHITESPACE = -1072894431,
    WC_E_SEMICOLON = -1072894430,
    WC_E_GREATERTHAN = -1072894429,
    WC_E_QUOTE = -1072894428,
    WC_E_EQUAL = -1072894427,
    WC_E_LESSTHAN = -1072894426,
    WC_E_HEXDIGIT = -1072894425,
    WC_E_DIGIT = -1072894424,
    WC_E_LEFTBRACKET = -1072894423,
    WC_E_LEFTPAREN = -1072894422,
    WC_E_XMLCHARACTER = -1072894421,
    WC_E_NAMECHARACTER = -1072894420,
    WC_E_SYNTAX = -1072894419,
    WC_E_CDSECT = -1072894418,
    WC_E_COMMENT = -1072894417,
    WC_E_CONDSECT = -1072894416,
    WC_E_DECLATTLIST = -1072894415,
    WC_E_DECLDOCTYPE = -1072894414,
    WC_E_DECLELEMENT = -1072894413,
    WC_E_DECLENTITY = -1072894412,
    WC_E_DECLNOTATION = -1072894411,
    WC_E_NDATA = -1072894410,
    WC_E_PUBLIC = -1072894409,
    WC_E_SYSTEM = -1072894408,
    WC_E_NAME = -1072894407,
    WC_E_ROOTELEMENT = -1072894406,
    WC_E_ELEMENTMATCH = -1072894405,
    WC_E_UNIQUEATTRIBUTE = -1072894404,
    WC_E_TEXTXMLDECL = -1072894403,
    WC_E_LEADINGXML = -1072894402,
    WC_E_TEXTDECL = -1072894401,
    WC_E_XMLDECL = -1072894400,
    WC_E_ENCNAME = -1072894399,
    WC_E_PUBLICID = -1072894398,
    WC_E_PESINTERNALSUBSET = -1072894397,
    WC_E_PESBETWEENDECLS = -1072894396,
    WC_E_NORECURSION = -1072894395,
    WC_E_ENTITYCONTENT = -1072894394,
    WC_E_UNDECLAREDENTITY = -1072894393,
    WC_E_PARSEDENTITY = -1072894392,
    WC_E_NOEXTERNALENTITYREF = -1072894391,
    WC_E_PI = -1072894390,
    WC_E_SYSTEMID = -1072894389,
    WC_E_QUESTIONMARK = -1072894388,
    WC_E_CDSECTEND = -1072894387,
    WC_E_MOREDATA = -1072894386,
    WC_E_DTDPROHIBITED = -1072894385,
    WC_E_INVALIDXMLSPACE = -1072894384,
    NC_E_NC = -1072894368,
    NC_E_QNAMECHARACTER = -1072894367,
    NC_E_QNAMECOLON = -1072894366,
    NC_E_NAMECOLON = -1072894365,
    NC_E_DECLAREDPREFIX = -1072894364,
    NC_E_UNDECLAREDPREFIX = -1072894363,
    NC_E_EMPTYURI = -1072894362,
    NC_E_XMLPREFIXRESERVED = -1072894361,
    NC_E_XMLNSPREFIXRESERVED = -1072894360,
    NC_E_XMLURIRESERVED = -1072894359,
    NC_E_XMLNSURIRESERVED = -1072894358,
    SC_E_SC = -1072894336,
    SC_E_MAXELEMENTDEPTH = -1072894335,
    SC_E_MAXENTITYEXPANSION = -1072894334,
    WR_E_WR = -1072894208,
    WR_E_NONWHITESPACE = -1072894207,
    WR_E_NSPREFIXDECLARED = -1072894206,
    WR_E_NSPREFIXWITHEMPTYNSURI = -1072894205,
    WR_E_DUPLICATEATTRIBUTE = -1072894204,
    WR_E_XMLNSPREFIXDECLARATION = -1072894203,
    WR_E_XMLPREFIXDECLARATION = -1072894202,
    WR_E_XMLURIDECLARATION = -1072894201,
    WR_E_XMLNSURIDECLARATION = -1072894200,
    WR_E_NAMESPACEUNDECLARED = -1072894199,
    WR_E_INVALIDXMLSPACE = -1072894198,
    WR_E_INVALIDACTION = -1072894197,
    WR_E_INVALIDSURROGATEPAIR = -1072894196,
    XML_E_INVALID_DECIMAL = -1072898019,
    XML_E_INVALID_HEXIDECIMAL = -1072898018,
    XML_E_INVALID_UNICODE = -1072898017,
    XML_E_INVALIDENCODING = -1072897938,
}

enum XmlStandalone
{
    XmlStandalone_Omit = 0,
    XmlStandalone_Yes = 1,
    XmlStandalone_No = 2,
    _XmlStandalone_Last = 2,
}

enum XmlWriterProperty
{
    XmlWriterProperty_MultiLanguage = 0,
    XmlWriterProperty_Indent = 1,
    XmlWriterProperty_ByteOrderMark = 2,
    XmlWriterProperty_OmitXmlDeclaration = 3,
    XmlWriterProperty_ConformanceLevel = 4,
    XmlWriterProperty_CompactEmptyElement = 5,
    _XmlWriterProperty_Last = 5,
}

const GUID IID_IXmlReader = {0x7279FC81, 0x709D, 0x4095, [0xB6, 0x3D, 0x69, 0xFE, 0x4B, 0x0D, 0x90, 0x30]};
@GUID(0x7279FC81, 0x709D, 0x4095, [0xB6, 0x3D, 0x69, 0xFE, 0x4B, 0x0D, 0x90, 0x30]);
interface IXmlReader : IUnknown
{
    HRESULT SetInput(IUnknown pInput);
    HRESULT GetProperty(uint nProperty, int* ppValue);
    HRESULT SetProperty(uint nProperty, int pValue);
    HRESULT Read(XmlNodeType* pNodeType);
    HRESULT GetNodeType(XmlNodeType* pNodeType);
    HRESULT MoveToFirstAttribute();
    HRESULT MoveToNextAttribute();
    HRESULT MoveToAttributeByName(const(wchar)* pwszLocalName, const(wchar)* pwszNamespaceUri);
    HRESULT MoveToElement();
    HRESULT GetQualifiedName(ushort** ppwszQualifiedName, uint* pcwchQualifiedName);
    HRESULT GetNamespaceUri(ushort** ppwszNamespaceUri, uint* pcwchNamespaceUri);
    HRESULT GetLocalName(ushort** ppwszLocalName, uint* pcwchLocalName);
    HRESULT GetPrefix(ushort** ppwszPrefix, uint* pcwchPrefix);
    HRESULT GetValue(ushort** ppwszValue, uint* pcwchValue);
    HRESULT ReadValueChunk(char* pwchBuffer, uint cwchChunkSize, uint* pcwchRead);
    HRESULT GetBaseUri(ushort** ppwszBaseUri, uint* pcwchBaseUri);
    BOOL IsDefault();
    BOOL IsEmptyElement();
    HRESULT GetLineNumber(uint* pnLineNumber);
    HRESULT GetLinePosition(uint* pnLinePosition);
    HRESULT GetAttributeCount(uint* pnAttributeCount);
    HRESULT GetDepth(uint* pnDepth);
    BOOL IsEOF();
}

const GUID IID_IXmlResolver = {0x7279FC82, 0x709D, 0x4095, [0xB6, 0x3D, 0x69, 0xFE, 0x4B, 0x0D, 0x90, 0x30]};
@GUID(0x7279FC82, 0x709D, 0x4095, [0xB6, 0x3D, 0x69, 0xFE, 0x4B, 0x0D, 0x90, 0x30]);
interface IXmlResolver : IUnknown
{
    HRESULT ResolveUri(const(wchar)* pwszBaseUri, const(wchar)* pwszPublicIdentifier, const(wchar)* pwszSystemIdentifier, IUnknown* ppResolvedInput);
}

const GUID IID_IXmlWriter = {0x7279FC88, 0x709D, 0x4095, [0xB6, 0x3D, 0x69, 0xFE, 0x4B, 0x0D, 0x90, 0x30]};
@GUID(0x7279FC88, 0x709D, 0x4095, [0xB6, 0x3D, 0x69, 0xFE, 0x4B, 0x0D, 0x90, 0x30]);
interface IXmlWriter : IUnknown
{
    HRESULT SetOutput(IUnknown pOutput);
    HRESULT GetProperty(uint nProperty, int* ppValue);
    HRESULT SetProperty(uint nProperty, int pValue);
    HRESULT WriteAttributes(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteAttributeString(const(wchar)* pwszPrefix, const(wchar)* pwszLocalName, const(wchar)* pwszNamespaceUri, const(wchar)* pwszValue);
    HRESULT WriteCData(const(wchar)* pwszText);
    HRESULT WriteCharEntity(ushort wch);
    HRESULT WriteChars(const(wchar)* pwch, uint cwch);
    HRESULT WriteComment(const(wchar)* pwszComment);
    HRESULT WriteDocType(const(wchar)* pwszName, const(wchar)* pwszPublicId, const(wchar)* pwszSystemId, const(wchar)* pwszSubset);
    HRESULT WriteElementString(const(wchar)* pwszPrefix, const(wchar)* pwszLocalName, const(wchar)* pwszNamespaceUri, const(wchar)* pwszValue);
    HRESULT WriteEndDocument();
    HRESULT WriteEndElement();
    HRESULT WriteEntityRef(const(wchar)* pwszName);
    HRESULT WriteFullEndElement();
    HRESULT WriteName(const(wchar)* pwszName);
    HRESULT WriteNmToken(const(wchar)* pwszNmToken);
    HRESULT WriteNode(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteNodeShallow(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteProcessingInstruction(const(wchar)* pwszName, const(wchar)* pwszText);
    HRESULT WriteQualifiedName(const(wchar)* pwszLocalName, const(wchar)* pwszNamespaceUri);
    HRESULT WriteRaw(const(wchar)* pwszData);
    HRESULT WriteRawChars(const(wchar)* pwch, uint cwch);
    HRESULT WriteStartDocument(XmlStandalone standalone);
    HRESULT WriteStartElement(const(wchar)* pwszPrefix, const(wchar)* pwszLocalName, const(wchar)* pwszNamespaceUri);
    HRESULT WriteString(const(wchar)* pwszText);
    HRESULT WriteSurrogateCharEntity(ushort wchLow, ushort wchHigh);
    HRESULT WriteWhitespace(const(wchar)* pwszWhitespace);
    HRESULT Flush();
}

const GUID IID_IXmlWriterLite = {0x862494C6, 0x1310, 0x4AAD, [0xB3, 0xCD, 0x2D, 0xBE, 0xEB, 0xF6, 0x70, 0xD3]};
@GUID(0x862494C6, 0x1310, 0x4AAD, [0xB3, 0xCD, 0x2D, 0xBE, 0xEB, 0xF6, 0x70, 0xD3]);
interface IXmlWriterLite : IUnknown
{
    HRESULT SetOutput(IUnknown pOutput);
    HRESULT GetProperty(uint nProperty, int* ppValue);
    HRESULT SetProperty(uint nProperty, int pValue);
    HRESULT WriteAttributes(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteAttributeString(const(wchar)* pwszQName, uint cwszQName, const(wchar)* pwszValue, uint cwszValue);
    HRESULT WriteCData(const(wchar)* pwszText);
    HRESULT WriteCharEntity(ushort wch);
    HRESULT WriteChars(const(wchar)* pwch, uint cwch);
    HRESULT WriteComment(const(wchar)* pwszComment);
    HRESULT WriteDocType(const(wchar)* pwszName, const(wchar)* pwszPublicId, const(wchar)* pwszSystemId, const(wchar)* pwszSubset);
    HRESULT WriteElementString(const(wchar)* pwszQName, uint cwszQName, const(wchar)* pwszValue);
    HRESULT WriteEndDocument();
    HRESULT WriteEndElement(const(wchar)* pwszQName, uint cwszQName);
    HRESULT WriteEntityRef(const(wchar)* pwszName);
    HRESULT WriteFullEndElement(const(wchar)* pwszQName, uint cwszQName);
    HRESULT WriteName(const(wchar)* pwszName);
    HRESULT WriteNmToken(const(wchar)* pwszNmToken);
    HRESULT WriteNode(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteNodeShallow(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteProcessingInstruction(const(wchar)* pwszName, const(wchar)* pwszText);
    HRESULT WriteRaw(const(wchar)* pwszData);
    HRESULT WriteRawChars(const(wchar)* pwch, uint cwch);
    HRESULT WriteStartDocument(XmlStandalone standalone);
    HRESULT WriteStartElement(const(wchar)* pwszQName, uint cwszQName);
    HRESULT WriteString(const(wchar)* pwszText);
    HRESULT WriteSurrogateCharEntity(ushort wchLow, ushort wchHigh);
    HRESULT WriteWhitespace(const(wchar)* pwszWhitespace);
    HRESULT Flush();
}

enum DEVPROP_OPERATOR
{
    DEVPROP_OPERATOR_MODIFIER_NOT = 65536,
    DEVPROP_OPERATOR_MODIFIER_IGNORE_CASE = 131072,
    DEVPROP_OPERATOR_NONE = 0,
    DEVPROP_OPERATOR_EXISTS = 1,
    DEVPROP_OPERATOR_NOT_EXISTS = 65537,
    DEVPROP_OPERATOR_EQUALS = 2,
    DEVPROP_OPERATOR_NOT_EQUALS = 65538,
    DEVPROP_OPERATOR_GREATER_THAN = 3,
    DEVPROP_OPERATOR_LESS_THAN = 4,
    DEVPROP_OPERATOR_GREATER_THAN_EQUALS = 5,
    DEVPROP_OPERATOR_LESS_THAN_EQUALS = 6,
    DEVPROP_OPERATOR_EQUALS_IGNORE_CASE = 131074,
    DEVPROP_OPERATOR_NOT_EQUALS_IGNORE_CASE = 196610,
    DEVPROP_OPERATOR_BITWISE_AND = 7,
    DEVPROP_OPERATOR_BITWISE_OR = 8,
    DEVPROP_OPERATOR_BEGINS_WITH = 9,
    DEVPROP_OPERATOR_ENDS_WITH = 10,
    DEVPROP_OPERATOR_CONTAINS = 11,
    DEVPROP_OPERATOR_BEGINS_WITH_IGNORE_CASE = 131081,
    DEVPROP_OPERATOR_ENDS_WITH_IGNORE_CASE = 131082,
    DEVPROP_OPERATOR_CONTAINS_IGNORE_CASE = 131083,
    DEVPROP_OPERATOR_LIST_CONTAINS = 4096,
    DEVPROP_OPERATOR_LIST_ELEMENT_BEGINS_WITH = 8192,
    DEVPROP_OPERATOR_LIST_ELEMENT_ENDS_WITH = 12288,
    DEVPROP_OPERATOR_LIST_ELEMENT_CONTAINS = 16384,
    DEVPROP_OPERATOR_LIST_CONTAINS_IGNORE_CASE = 135168,
    DEVPROP_OPERATOR_LIST_ELEMENT_BEGINS_WITH_IGNORE_CASE = 139264,
    DEVPROP_OPERATOR_LIST_ELEMENT_ENDS_WITH_IGNORE_CASE = 143360,
    DEVPROP_OPERATOR_LIST_ELEMENT_CONTAINS_IGNORE_CASE = 147456,
    DEVPROP_OPERATOR_AND_OPEN = 1048576,
    DEVPROP_OPERATOR_AND_CLOSE = 2097152,
    DEVPROP_OPERATOR_OR_OPEN = 3145728,
    DEVPROP_OPERATOR_OR_CLOSE = 4194304,
    DEVPROP_OPERATOR_NOT_OPEN = 5242880,
    DEVPROP_OPERATOR_NOT_CLOSE = 6291456,
    DEVPROP_OPERATOR_ARRAY_CONTAINS = 268435456,
    DEVPROP_OPERATOR_MASK_EVAL = 4095,
    DEVPROP_OPERATOR_MASK_LIST = 61440,
    DEVPROP_OPERATOR_MASK_MODIFIER = 983040,
    DEVPROP_OPERATOR_MASK_NOT_LOGICAL = -267386881,
    DEVPROP_OPERATOR_MASK_LOGICAL = 267386880,
    DEVPROP_OPERATOR_MASK_ARRAY = -268435456,
}

struct DEVPROP_FILTER_EXPRESSION
{
    DEVPROP_OPERATOR Operator;
    DEVPROPERTY Property;
}

enum DEV_OBJECT_TYPE
{
    DevObjectTypeUnknown = 0,
    DevObjectTypeDeviceInterface = 1,
    DevObjectTypeDeviceContainer = 2,
    DevObjectTypeDevice = 3,
    DevObjectTypeDeviceInterfaceClass = 4,
    DevObjectTypeAEP = 5,
    DevObjectTypeAEPContainer = 6,
    DevObjectTypeDeviceInstallerClass = 7,
    DevObjectTypeDeviceInterfaceDisplay = 8,
    DevObjectTypeDeviceContainerDisplay = 9,
    DevObjectTypeAEPService = 10,
    DevObjectTypeDevicePanel = 11,
}

enum DEV_QUERY_FLAGS
{
    DevQueryFlagNone = 0,
    DevQueryFlagUpdateResults = 1,
    DevQueryFlagAllProperties = 2,
    DevQueryFlagLocalize = 4,
    DevQueryFlagAsyncClose = 8,
}

enum DEV_QUERY_STATE
{
    DevQueryStateInitialized = 0,
    DevQueryStateEnumCompleted = 1,
    DevQueryStateAborted = 2,
    DevQueryStateClosed = 3,
}

enum DEV_QUERY_RESULT_ACTION
{
    DevQueryResultStateChange = 0,
    DevQueryResultAdd = 1,
    DevQueryResultUpdate = 2,
    DevQueryResultRemove = 3,
}

struct DEV_OBJECT
{
    DEV_OBJECT_TYPE ObjectType;
    const(wchar)* pszObjectId;
    uint cPropertyCount;
    const(DEVPROPERTY)* pProperties;
}

struct DEV_QUERY_RESULT_ACTION_DATA
{
    DEV_QUERY_RESULT_ACTION Action;
    _DEV_QUERY_RESULT_UPDATE_PAYLOAD Data;
}

struct DEV_QUERY_PARAMETER
{
    DEVPROPKEY Key;
    uint Type;
    uint BufferSize;
    void* Buffer;
}

struct HDEVQUERY__
{
    int unused;
}

alias PDEV_QUERY_RESULT_CALLBACK = extern(Windows) void function(HDEVQUERY__* hDevQuery, void* pContext, const(DEV_QUERY_RESULT_ACTION_DATA)* pActionData);
enum _GlobalFilter
{
    GF_FRAGMENTS = 2,
    GF_STRONGHOST = 8,
    GF_FRAGCACHE = 9,
}

enum _PfForwardAction
{
    PF_ACTION_FORWARD = 0,
    PF_ACTION_DROP = 1,
}

enum _PfAddresType
{
    PF_IPV4 = 0,
    PF_IPV6 = 1,
}

struct PF_FILTER_DESCRIPTOR
{
    uint dwFilterFlags;
    uint dwRule;
    _PfAddresType pfatType;
    ubyte* SrcAddr;
    ubyte* SrcMask;
    ubyte* DstAddr;
    ubyte* DstMask;
    uint dwProtocol;
    uint fLateBound;
    ushort wSrcPort;
    ushort wDstPort;
    ushort wSrcPortHighRange;
    ushort wDstPortHighRange;
}

struct PF_FILTER_STATS
{
    uint dwNumPacketsFiltered;
    PF_FILTER_DESCRIPTOR info;
}

struct PF_INTERFACE_STATS
{
    void* pvDriverContext;
    uint dwFlags;
    uint dwInDrops;
    uint dwOutDrops;
    _PfForwardAction eaInAction;
    _PfForwardAction eaOutAction;
    uint dwNumInFilters;
    uint dwNumOutFilters;
    uint dwFrag;
    uint dwSpoof;
    uint dwReserved1;
    uint dwReserved2;
    LARGE_INTEGER liSYN;
    LARGE_INTEGER liTotalLogged;
    uint dwLostLogEntries;
    PF_FILTER_STATS FilterInfo;
}

struct PF_LATEBIND_INFO
{
    ubyte* SrcAddr;
    ubyte* DstAddr;
    ubyte* Mask;
}

enum _PfFrameType
{
    PFFT_FILTER = 1,
    PFFT_FRAG = 2,
    PFFT_SPOOF = 3,
}

struct _pfLogFrame
{
    LARGE_INTEGER Timestamp;
    _PfFrameType pfeTypeOfFrame;
    uint dwTotalSizeUsed;
    uint dwFilterRule;
    ushort wSizeOfAdditionalData;
    ushort wSizeOfIpHeader;
    uint dwInterfaceName;
    uint dwIPIndex;
    ubyte bPacketData;
}

