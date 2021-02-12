module windows.systemservices;

public import system;
public import windows.system;
public import windows.automation;
public import windows.com;
public import windows.coreaudio;
public import windows.debug;
public import windows.direct3d9;
public import windows.directdraw;
public import windows.directshow;
public import windows.displaydevices;
public import windows.dxgi;
public import windows.filesystem;
public import windows.gdi;
public import windows.kernel;
public import windows.menusandresources;
public import windows.opengl;
public import windows.rpc;
public import windows.security;
public import windows.virtualstorage;
public import windows.windowsandmessaging;
public import windows.windowscolorsystem;
public import windows.windowsprogramming;
public import windows.xps;

extern(Windows):

@DllImport("api-ms-win-core-rtlsupport-l1-1-0.dll")
uint RtlCompareMemory(const(void)* Source1, const(void)* Source2, uint Length);

@DllImport("ntdll.dll")
void RtlInitializeSListHead(SLIST_HEADER* ListHead);

@DllImport("ntdll.dll")
SINGLE_LIST_ENTRY* RtlFirstEntrySList(const(SLIST_HEADER)* ListHead);

@DllImport("ntdll.dll")
SINGLE_LIST_ENTRY* RtlInterlockedPopEntrySList(SLIST_HEADER* ListHead);

@DllImport("ntdll.dll")
SINGLE_LIST_ENTRY* RtlInterlockedPushEntrySList(SLIST_HEADER* ListHead, SINGLE_LIST_ENTRY* ListEntry);

@DllImport("ntdll.dll")
SINGLE_LIST_ENTRY* RtlInterlockedPushListSListEx(SLIST_HEADER* ListHead, SINGLE_LIST_ENTRY* List, SINGLE_LIST_ENTRY* ListEnd, uint Count);

@DllImport("ntdll.dll")
SINGLE_LIST_ENTRY* RtlInterlockedFlushSList(SLIST_HEADER* ListHead);

@DllImport("ntdll.dll")
ushort RtlQueryDepthSList(SLIST_HEADER* ListHead);

@DllImport("ntdll.dll")
uint RtlGetReturnAddressHijackTarget();

@DllImport("ntdll.dll")
ubyte RtlGetProductInfo(uint OSMajorVersion, uint OSMinorVersion, uint SpMajorVersion, uint SpMinorVersion, uint* ReturnedProductType);

@DllImport("ntdll.dll")
uint RtlCrc32(char* Buffer, uint Size, uint InitialCrc);

@DllImport("ntdll.dll")
ulong RtlCrc64(char* Buffer, uint Size, ulong InitialCrc);

@DllImport("ntdll.dll")
OS_DEPLOYEMENT_STATE_VALUES RtlOsDeploymentState(uint Flags);

@DllImport("ntdll.dll")
uint RtlInitializeCorrelationVector(CORRELATION_VECTOR* CorrelationVector, int Version, const(Guid)* Guid);

@DllImport("ntdll.dll")
uint RtlIncrementCorrelationVector(CORRELATION_VECTOR* CorrelationVector);

@DllImport("ntdll.dll")
uint RtlExtendCorrelationVector(CORRELATION_VECTOR* CorrelationVector);

@DllImport("ntdll.dll")
uint RtlValidateCorrelationVector(CORRELATION_VECTOR* Vector);

@DllImport("ntdll.dll")
uint RtlRaiseCustomSystemEventTrigger(CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG* TriggerConfig);

@DllImport("ntdll.dll")
ubyte RtlIsZeroMemory(void* Buffer, uint Length);

@DllImport("ntdll.dll")
ubyte RtlNormalizeSecurityDescriptor(void** SecurityDescriptor, uint SecurityDescriptorLength, void** NewSecurityDescriptor, uint* NewSecurityDescriptorLength, ubyte CheckOnly);

@DllImport("ntdll.dll")
void RtlGetDeviceFamilyInfoEnum(ulong* pullUAPInfo, uint* pulDeviceFamily, uint* pulDeviceForm);

@DllImport("ntdll.dll")
uint RtlConvertDeviceFamilyInfoToString(uint* pulDeviceFamilyBufferSize, uint* pulDeviceFormBufferSize, const(wchar)* DeviceFamily, const(wchar)* DeviceForm);

@DllImport("ntdll.dll")
uint RtlSwitchedVVI(OSVERSIONINFOEXW* VersionInfo, uint TypeMask, ulong ConditionMask);

@DllImport("KERNEL32.dll")
uint FlsAlloc(PFLS_CALLBACK_FUNCTION lpCallback);

@DllImport("KERNEL32.dll")
void* FlsGetValue(uint dwFlsIndex);

@DllImport("KERNEL32.dll")
BOOL FlsSetValue(uint dwFlsIndex, void* lpFlsData);

@DllImport("KERNEL32.dll")
BOOL FlsFree(uint dwFlsIndex);

@DllImport("KERNEL32.dll")
BOOL IsThreadAFiber();

@DllImport("KERNEL32.dll")
void InitializeSRWLock(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32.dll")
void ReleaseSRWLockExclusive(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32.dll")
void ReleaseSRWLockShared(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32.dll")
void AcquireSRWLockExclusive(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32.dll")
void AcquireSRWLockShared(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32.dll")
ubyte TryAcquireSRWLockExclusive(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32.dll")
ubyte TryAcquireSRWLockShared(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32.dll")
void InitializeCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

@DllImport("KERNEL32.dll")
void LeaveCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

@DllImport("KERNEL32.dll")
BOOL InitializeCriticalSectionAndSpinCount(RTL_CRITICAL_SECTION* lpCriticalSection, uint dwSpinCount);

@DllImport("KERNEL32.dll")
BOOL InitializeCriticalSectionEx(RTL_CRITICAL_SECTION* lpCriticalSection, uint dwSpinCount, uint Flags);

@DllImport("KERNEL32.dll")
uint SetCriticalSectionSpinCount(RTL_CRITICAL_SECTION* lpCriticalSection, uint dwSpinCount);

@DllImport("KERNEL32.dll")
BOOL TryEnterCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

@DllImport("KERNEL32.dll")
void DeleteCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

@DllImport("KERNEL32.dll")
void InitOnceInitialize(RTL_RUN_ONCE* InitOnce);

@DllImport("KERNEL32.dll")
BOOL InitOnceExecuteOnce(RTL_RUN_ONCE* InitOnce, PINIT_ONCE_FN InitFn, void* Parameter, void** Context);

@DllImport("KERNEL32.dll")
BOOL InitOnceBeginInitialize(RTL_RUN_ONCE* lpInitOnce, uint dwFlags, int* fPending, void** lpContext);

@DllImport("KERNEL32.dll")
BOOL InitOnceComplete(RTL_RUN_ONCE* lpInitOnce, uint dwFlags, void* lpContext);

@DllImport("KERNEL32.dll")
void InitializeConditionVariable(RTL_CONDITION_VARIABLE* ConditionVariable);

@DllImport("KERNEL32.dll")
void WakeConditionVariable(RTL_CONDITION_VARIABLE* ConditionVariable);

@DllImport("KERNEL32.dll")
void WakeAllConditionVariable(RTL_CONDITION_VARIABLE* ConditionVariable);

@DllImport("KERNEL32.dll")
BOOL SleepConditionVariableCS(RTL_CONDITION_VARIABLE* ConditionVariable, RTL_CRITICAL_SECTION* CriticalSection, uint dwMilliseconds);

@DllImport("KERNEL32.dll")
BOOL SleepConditionVariableSRW(RTL_CONDITION_VARIABLE* ConditionVariable, RTL_SRWLOCK* SRWLock, uint dwMilliseconds, uint Flags);

@DllImport("KERNEL32.dll")
BOOL SetEvent(HANDLE hEvent);

@DllImport("KERNEL32.dll")
BOOL ResetEvent(HANDLE hEvent);

@DllImport("KERNEL32.dll")
BOOL ReleaseSemaphore(HANDLE hSemaphore, int lReleaseCount, int* lpPreviousCount);

@DllImport("KERNEL32.dll")
BOOL ReleaseMutex(HANDLE hMutex);

@DllImport("KERNEL32.dll")
uint WaitForSingleObject(HANDLE hHandle, uint dwMilliseconds);

@DllImport("KERNEL32.dll")
uint SleepEx(uint dwMilliseconds, BOOL bAlertable);

@DllImport("KERNEL32.dll")
uint WaitForSingleObjectEx(HANDLE hHandle, uint dwMilliseconds, BOOL bAlertable);

@DllImport("KERNEL32.dll")
uint WaitForMultipleObjectsEx(uint nCount, char* lpHandles, BOOL bWaitAll, uint dwMilliseconds, BOOL bAlertable);

@DllImport("KERNEL32.dll")
HANDLE CreateMutexA(SECURITY_ATTRIBUTES* lpMutexAttributes, BOOL bInitialOwner, const(char)* lpName);

@DllImport("KERNEL32.dll")
HANDLE CreateMutexW(SECURITY_ATTRIBUTES* lpMutexAttributes, BOOL bInitialOwner, const(wchar)* lpName);

@DllImport("KERNEL32.dll")
HANDLE OpenMutexW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpName);

@DllImport("KERNEL32.dll")
HANDLE CreateEventA(SECURITY_ATTRIBUTES* lpEventAttributes, BOOL bManualReset, BOOL bInitialState, const(char)* lpName);

@DllImport("KERNEL32.dll")
HANDLE CreateEventW(SECURITY_ATTRIBUTES* lpEventAttributes, BOOL bManualReset, BOOL bInitialState, const(wchar)* lpName);

@DllImport("KERNEL32.dll")
HANDLE OpenEventA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpName);

@DllImport("KERNEL32.dll")
HANDLE OpenEventW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpName);

@DllImport("KERNEL32.dll")
HANDLE OpenSemaphoreW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpName);

@DllImport("KERNEL32.dll")
HANDLE OpenWaitableTimerW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpTimerName);

@DllImport("KERNEL32.dll")
BOOL SetWaitableTimerEx(HANDLE hTimer, const(LARGE_INTEGER)* lpDueTime, int lPeriod, PTIMERAPCROUTINE pfnCompletionRoutine, void* lpArgToCompletionRoutine, REASON_CONTEXT* WakeContext, uint TolerableDelay);

@DllImport("KERNEL32.dll")
BOOL SetWaitableTimer(HANDLE hTimer, const(LARGE_INTEGER)* lpDueTime, int lPeriod, PTIMERAPCROUTINE pfnCompletionRoutine, void* lpArgToCompletionRoutine, BOOL fResume);

@DllImport("KERNEL32.dll")
BOOL CancelWaitableTimer(HANDLE hTimer);

@DllImport("KERNEL32.dll")
HANDLE CreateMutexExA(SECURITY_ATTRIBUTES* lpMutexAttributes, const(char)* lpName, uint dwFlags, uint dwDesiredAccess);

@DllImport("KERNEL32.dll")
HANDLE CreateMutexExW(SECURITY_ATTRIBUTES* lpMutexAttributes, const(wchar)* lpName, uint dwFlags, uint dwDesiredAccess);

@DllImport("KERNEL32.dll")
HANDLE CreateEventExA(SECURITY_ATTRIBUTES* lpEventAttributes, const(char)* lpName, uint dwFlags, uint dwDesiredAccess);

@DllImport("KERNEL32.dll")
HANDLE CreateEventExW(SECURITY_ATTRIBUTES* lpEventAttributes, const(wchar)* lpName, uint dwFlags, uint dwDesiredAccess);

@DllImport("KERNEL32.dll")
HANDLE CreateSemaphoreExW(SECURITY_ATTRIBUTES* lpSemaphoreAttributes, int lInitialCount, int lMaximumCount, const(wchar)* lpName, uint dwFlags, uint dwDesiredAccess);

@DllImport("KERNEL32.dll")
HANDLE CreateWaitableTimerExW(SECURITY_ATTRIBUTES* lpTimerAttributes, const(wchar)* lpTimerName, uint dwFlags, uint dwDesiredAccess);

@DllImport("KERNEL32.dll")
BOOL EnterSynchronizationBarrier(RTL_BARRIER* lpBarrier, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL InitializeSynchronizationBarrier(RTL_BARRIER* lpBarrier, int lTotalThreads, int lSpinCount);

@DllImport("KERNEL32.dll")
BOOL DeleteSynchronizationBarrier(RTL_BARRIER* lpBarrier);

@DllImport("KERNEL32.dll")
void Sleep(uint dwMilliseconds);

@DllImport("api-ms-win-core-synch-l1-2-0.dll")
BOOL WaitOnAddress(char* Address, char* CompareAddress, uint AddressSize, uint dwMilliseconds);

@DllImport("api-ms-win-core-synch-l1-2-0.dll")
void WakeByAddressSingle(void* Address);

@DllImport("api-ms-win-core-synch-l1-2-0.dll")
void WakeByAddressAll(void* Address);

@DllImport("KERNEL32.dll")
uint WaitForMultipleObjects(uint nCount, char* lpHandles, BOOL bWaitAll, uint dwMilliseconds);

@DllImport("KERNEL32.dll")
HANDLE CreateSemaphoreW(SECURITY_ATTRIBUTES* lpSemaphoreAttributes, int lInitialCount, int lMaximumCount, const(wchar)* lpName);

@DllImport("KERNEL32.dll")
HANDLE CreateWaitableTimerW(SECURITY_ATTRIBUTES* lpTimerAttributes, BOOL bManualReset, const(wchar)* lpTimerName);

@DllImport("KERNEL32.dll")
void InitializeSListHead(SLIST_HEADER* ListHead);

@DllImport("KERNEL32.dll")
SINGLE_LIST_ENTRY* InterlockedPopEntrySList(SLIST_HEADER* ListHead);

@DllImport("KERNEL32.dll")
SINGLE_LIST_ENTRY* InterlockedPushEntrySList(SLIST_HEADER* ListHead, SINGLE_LIST_ENTRY* ListEntry);

@DllImport("KERNEL32.dll")
SINGLE_LIST_ENTRY* InterlockedPushListSListEx(SLIST_HEADER* ListHead, SINGLE_LIST_ENTRY* List, SINGLE_LIST_ENTRY* ListEnd, uint Count);

@DllImport("KERNEL32.dll")
SINGLE_LIST_ENTRY* InterlockedFlushSList(SLIST_HEADER* ListHead);

@DllImport("KERNEL32.dll")
ushort QueryDepthSList(SLIST_HEADER* ListHead);

@DllImport("KERNEL32.dll")
BOOL QueueUserWorkItem(LPTHREAD_START_ROUTINE Function, void* Context, uint Flags);

@DllImport("KERNEL32.dll")
BOOL UnregisterWaitEx(HANDLE WaitHandle, HANDLE CompletionEvent);

@DllImport("KERNEL32.dll")
HANDLE CreateTimerQueue();

@DllImport("KERNEL32.dll")
BOOL CreateTimerQueueTimer(int* phNewTimer, HANDLE TimerQueue, WAITORTIMERCALLBACK Callback, void* Parameter, uint DueTime, uint Period, uint Flags);

@DllImport("KERNEL32.dll")
BOOL ChangeTimerQueueTimer(HANDLE TimerQueue, HANDLE Timer, uint DueTime, uint Period);

@DllImport("KERNEL32.dll")
BOOL DeleteTimerQueueTimer(HANDLE TimerQueue, HANDLE Timer, HANDLE CompletionEvent);

@DllImport("KERNEL32.dll")
BOOL DeleteTimerQueueEx(HANDLE TimerQueue, HANDLE CompletionEvent);

@DllImport("KERNEL32.dll")
PTP_POOL CreateThreadpool(void* reserved);

@DllImport("KERNEL32.dll")
void SetThreadpoolThreadMaximum(PTP_POOL ptpp, uint cthrdMost);

@DllImport("KERNEL32.dll")
BOOL SetThreadpoolThreadMinimum(PTP_POOL ptpp, uint cthrdMic);

@DllImport("KERNEL32.dll")
BOOL SetThreadpoolStackInformation(PTP_POOL ptpp, TP_POOL_STACK_INFORMATION* ptpsi);

@DllImport("KERNEL32.dll")
BOOL QueryThreadpoolStackInformation(PTP_POOL ptpp, TP_POOL_STACK_INFORMATION* ptpsi);

@DllImport("KERNEL32.dll")
void CloseThreadpool(PTP_POOL ptpp);

@DllImport("KERNEL32.dll")
int CreateThreadpoolCleanupGroup();

@DllImport("KERNEL32.dll")
void CloseThreadpoolCleanupGroupMembers(int ptpcg, BOOL fCancelPendingCallbacks, void* pvCleanupContext);

@DllImport("KERNEL32.dll")
void CloseThreadpoolCleanupGroup(int ptpcg);

@DllImport("KERNEL32.dll")
void SetEventWhenCallbackReturns(TP_CALLBACK_INSTANCE* pci, HANDLE evt);

@DllImport("KERNEL32.dll")
void ReleaseSemaphoreWhenCallbackReturns(TP_CALLBACK_INSTANCE* pci, HANDLE sem, uint crel);

@DllImport("KERNEL32.dll")
void ReleaseMutexWhenCallbackReturns(TP_CALLBACK_INSTANCE* pci, HANDLE mut);

@DllImport("KERNEL32.dll")
void LeaveCriticalSectionWhenCallbackReturns(TP_CALLBACK_INSTANCE* pci, RTL_CRITICAL_SECTION* pcs);

@DllImport("KERNEL32.dll")
void FreeLibraryWhenCallbackReturns(TP_CALLBACK_INSTANCE* pci, int mod);

@DllImport("KERNEL32.dll")
BOOL CallbackMayRunLong(TP_CALLBACK_INSTANCE* pci);

@DllImport("KERNEL32.dll")
void DisassociateCurrentThreadFromCallback(TP_CALLBACK_INSTANCE* pci);

@DllImport("KERNEL32.dll")
BOOL TrySubmitThreadpoolCallback(PTP_SIMPLE_CALLBACK pfns, void* pv, TP_CALLBACK_ENVIRON_V3* pcbe);

@DllImport("KERNEL32.dll")
TP_WORK* CreateThreadpoolWork(PTP_WORK_CALLBACK pfnwk, void* pv, TP_CALLBACK_ENVIRON_V3* pcbe);

@DllImport("KERNEL32.dll")
void SubmitThreadpoolWork(TP_WORK* pwk);

@DllImport("KERNEL32.dll")
void WaitForThreadpoolWorkCallbacks(TP_WORK* pwk, BOOL fCancelPendingCallbacks);

@DllImport("KERNEL32.dll")
void CloseThreadpoolWork(TP_WORK* pwk);

@DllImport("KERNEL32.dll")
TP_TIMER* CreateThreadpoolTimer(PTP_TIMER_CALLBACK pfnti, void* pv, TP_CALLBACK_ENVIRON_V3* pcbe);

@DllImport("KERNEL32.dll")
void SetThreadpoolTimer(TP_TIMER* pti, FILETIME* pftDueTime, uint msPeriod, uint msWindowLength);

@DllImport("KERNEL32.dll")
BOOL IsThreadpoolTimerSet(TP_TIMER* pti);

@DllImport("KERNEL32.dll")
void WaitForThreadpoolTimerCallbacks(TP_TIMER* pti, BOOL fCancelPendingCallbacks);

@DllImport("KERNEL32.dll")
void CloseThreadpoolTimer(TP_TIMER* pti);

@DllImport("KERNEL32.dll")
TP_WAIT* CreateThreadpoolWait(PTP_WAIT_CALLBACK pfnwa, void* pv, TP_CALLBACK_ENVIRON_V3* pcbe);

@DllImport("KERNEL32.dll")
void SetThreadpoolWait(TP_WAIT* pwa, HANDLE h, FILETIME* pftTimeout);

@DllImport("KERNEL32.dll")
void WaitForThreadpoolWaitCallbacks(TP_WAIT* pwa, BOOL fCancelPendingCallbacks);

@DllImport("KERNEL32.dll")
void CloseThreadpoolWait(TP_WAIT* pwa);

@DllImport("KERNEL32.dll")
TP_IO* CreateThreadpoolIo(HANDLE fl, PTP_WIN32_IO_CALLBACK pfnio, void* pv, TP_CALLBACK_ENVIRON_V3* pcbe);

@DllImport("KERNEL32.dll")
void StartThreadpoolIo(TP_IO* pio);

@DllImport("KERNEL32.dll")
void CancelThreadpoolIo(TP_IO* pio);

@DllImport("KERNEL32.dll")
void WaitForThreadpoolIoCallbacks(TP_IO* pio, BOOL fCancelPendingCallbacks);

@DllImport("KERNEL32.dll")
void CloseThreadpoolIo(TP_IO* pio);

@DllImport("KERNEL32.dll")
BOOL SetThreadpoolTimerEx(TP_TIMER* pti, FILETIME* pftDueTime, uint msPeriod, uint msWindowLength);

@DllImport("KERNEL32.dll")
BOOL SetThreadpoolWaitEx(TP_WAIT* pwa, HANDLE h, FILETIME* pftTimeout, void* Reserved);

@DllImport("KERNEL32.dll")
BOOL IsProcessInJob(HANDLE ProcessHandle, HANDLE JobHandle, int* Result);

@DllImport("KERNEL32.dll")
HANDLE CreateJobObjectW(SECURITY_ATTRIBUTES* lpJobAttributes, const(wchar)* lpName);

@DllImport("KERNEL32.dll")
void FreeMemoryJobObject(void* Buffer);

@DllImport("KERNEL32.dll")
HANDLE OpenJobObjectW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpName);

@DllImport("KERNEL32.dll")
BOOL AssignProcessToJobObject(HANDLE hJob, HANDLE hProcess);

@DllImport("KERNEL32.dll")
BOOL TerminateJobObject(HANDLE hJob, uint uExitCode);

@DllImport("KERNEL32.dll")
BOOL SetInformationJobObject(HANDLE hJob, JOBOBJECTINFOCLASS JobObjectInformationClass, char* lpJobObjectInformation, uint cbJobObjectInformationLength);

@DllImport("KERNEL32.dll")
uint SetIoRateControlInformationJobObject(HANDLE hJob, JOBOBJECT_IO_RATE_CONTROL_INFORMATION* IoRateControlInfo);

@DllImport("KERNEL32.dll")
BOOL QueryInformationJobObject(HANDLE hJob, JOBOBJECTINFOCLASS JobObjectInformationClass, char* lpJobObjectInformation, uint cbJobObjectInformationLength, uint* lpReturnLength);

@DllImport("KERNEL32.dll")
uint QueryIoRateControlInformationJobObject(HANDLE hJob, const(wchar)* VolumeName, JOBOBJECT_IO_RATE_CONTROL_INFORMATION** InfoBlocks, uint* InfoBlockCount);

@DllImport("KERNEL32.dll")
NamespaceHandle CreatePrivateNamespaceW(SECURITY_ATTRIBUTES* lpPrivateNamespaceAttributes, void* lpBoundaryDescriptor, const(wchar)* lpAliasPrefix);

@DllImport("KERNEL32.dll")
NamespaceHandle OpenPrivateNamespaceW(void* lpBoundaryDescriptor, const(wchar)* lpAliasPrefix);

@DllImport("KERNEL32.dll")
ubyte ClosePrivateNamespace(NamespaceHandle Handle, uint Flags);

@DllImport("KERNEL32.dll")
BoundaryDescriptorHandle CreateBoundaryDescriptorW(const(wchar)* Name, uint Flags);

@DllImport("KERNEL32.dll")
BOOL AddSIDToBoundaryDescriptor(HANDLE* BoundaryDescriptor, void* RequiredSid);

@DllImport("KERNEL32.dll")
void DeleteBoundaryDescriptor(BoundaryDescriptorHandle BoundaryDescriptor);

@DllImport("KERNEL32.dll")
BOOL GetNumaHighestNodeNumber(uint* HighestNodeNumber);

@DllImport("KERNEL32.dll")
BOOL GetNumaNodeProcessorMaskEx(ushort Node, GROUP_AFFINITY* ProcessorMask);

@DllImport("KERNEL32.dll")
BOOL GetNumaProximityNodeEx(uint ProximityId, ushort* NodeNumber);

@DllImport("KERNEL32.dll")
BOOL GetProcessGroupAffinity(HANDLE hProcess, ushort* GroupCount, char* GroupArray);

@DllImport("KERNEL32.dll")
BOOL GetThreadGroupAffinity(HANDLE hThread, GROUP_AFFINITY* GroupAffinity);

@DllImport("KERNEL32.dll")
BOOL SetThreadGroupAffinity(HANDLE hThread, const(GROUP_AFFINITY)* GroupAffinity, GROUP_AFFINITY* PreviousGroupAffinity);

@DllImport("KERNEL32.dll")
BOOL CreatePipe(int* hReadPipe, int* hWritePipe, SECURITY_ATTRIBUTES* lpPipeAttributes, uint nSize);

@DllImport("KERNEL32.dll")
BOOL ConnectNamedPipe(HANDLE hNamedPipe, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
BOOL DisconnectNamedPipe(HANDLE hNamedPipe);

@DllImport("KERNEL32.dll")
BOOL SetNamedPipeHandleState(HANDLE hNamedPipe, uint* lpMode, uint* lpMaxCollectionCount, uint* lpCollectDataTimeout);

@DllImport("KERNEL32.dll")
BOOL PeekNamedPipe(HANDLE hNamedPipe, char* lpBuffer, uint nBufferSize, uint* lpBytesRead, uint* lpTotalBytesAvail, uint* lpBytesLeftThisMessage);

@DllImport("KERNEL32.dll")
BOOL TransactNamedPipe(HANDLE hNamedPipe, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesRead, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
HANDLE CreateNamedPipeW(const(wchar)* lpName, uint dwOpenMode, uint dwPipeMode, uint nMaxInstances, uint nOutBufferSize, uint nInBufferSize, uint nDefaultTimeOut, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
BOOL WaitNamedPipeW(const(wchar)* lpNamedPipeName, uint nTimeOut);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeClientComputerNameW(HANDLE Pipe, const(wchar)* ClientComputerName, uint ClientComputerNameLength);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeInfo(HANDLE hNamedPipe, uint* lpFlags, uint* lpOutBufferSize, uint* lpInBufferSize, uint* lpMaxInstances);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeHandleStateW(HANDLE hNamedPipe, uint* lpState, uint* lpCurInstances, uint* lpMaxCollectionCount, uint* lpCollectDataTimeout, const(wchar)* lpUserName, uint nMaxUserNameSize);

@DllImport("KERNEL32.dll")
BOOL CallNamedPipeW(const(wchar)* lpNamedPipeName, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesRead, uint nTimeOut);

@DllImport("KERNEL32.dll")
HeapHandle HeapCreate(uint flOptions, uint dwInitialSize, uint dwMaximumSize);

@DllImport("KERNEL32.dll")
BOOL HeapDestroy(HeapHandle hHeap);

@DllImport("KERNEL32.dll")
void* HeapAlloc(HeapHandle hHeap, uint dwFlags, uint dwBytes);

@DllImport("KERNEL32.dll")
void* HeapReAlloc(HeapHandle hHeap, uint dwFlags, void* lpMem, uint dwBytes);

@DllImport("KERNEL32.dll")
BOOL HeapFree(HANDLE hHeap, uint dwFlags, void* lpMem);

@DllImport("KERNEL32.dll")
uint HeapSize(HeapHandle hHeap, uint dwFlags, void* lpMem);

@DllImport("KERNEL32.dll")
HANDLE GetProcessHeap();

@DllImport("KERNEL32.dll")
uint HeapCompact(HeapHandle hHeap, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL HeapSetInformation(HANDLE HeapHandle, HEAP_INFORMATION_CLASS HeapInformationClass, char* HeapInformation, uint HeapInformationLength);

@DllImport("KERNEL32.dll")
BOOL HeapValidate(HANDLE hHeap, uint dwFlags, void* lpMem);

@DllImport("KERNEL32.dll")
BOOL HeapSummary(HANDLE hHeap, uint dwFlags, HEAP_SUMMARY* lpSummary);

@DllImport("KERNEL32.dll")
uint GetProcessHeaps(uint NumberOfHeaps, char* ProcessHeaps);

@DllImport("KERNEL32.dll")
BOOL HeapLock(HeapHandle hHeap);

@DllImport("KERNEL32.dll")
BOOL HeapUnlock(HANDLE hHeap);

@DllImport("KERNEL32.dll")
BOOL HeapWalk(HANDLE hHeap, PROCESS_HEAP_ENTRY* lpEntry);

@DllImport("KERNEL32.dll")
BOOL HeapQueryInformation(HANDLE HeapHandle, HEAP_INFORMATION_CLASS HeapInformationClass, char* HeapInformation, uint HeapInformationLength, uint* ReturnLength);

@DllImport("KERNEL32.dll")
void* VirtualAlloc(void* lpAddress, uint dwSize, uint flAllocationType, uint flProtect);

@DllImport("KERNEL32.dll")
BOOL VirtualProtect(void* lpAddress, uint dwSize, uint flNewProtect, uint* lpflOldProtect);

@DllImport("KERNEL32.dll")
BOOL VirtualFree(void* lpAddress, uint dwSize, uint dwFreeType);

@DllImport("KERNEL32.dll")
uint VirtualQuery(void* lpAddress, char* lpBuffer, uint dwLength);

@DllImport("KERNEL32.dll")
void* VirtualAllocEx(HANDLE hProcess, void* lpAddress, uint dwSize, uint flAllocationType, uint flProtect);

@DllImport("KERNEL32.dll")
BOOL VirtualProtectEx(HANDLE hProcess, void* lpAddress, uint dwSize, uint flNewProtect, uint* lpflOldProtect);

@DllImport("KERNEL32.dll")
uint VirtualQueryEx(HANDLE hProcess, void* lpAddress, char* lpBuffer, uint dwLength);

@DllImport("KERNEL32.dll")
HANDLE CreateFileMappingW(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, uint flProtect, uint dwMaximumSizeHigh, uint dwMaximumSizeLow, const(wchar)* lpName);

@DllImport("KERNEL32.dll")
HANDLE OpenFileMappingW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpName);

@DllImport("KERNEL32.dll")
void* MapViewOfFile(HANDLE hFileMappingObject, uint dwDesiredAccess, uint dwFileOffsetHigh, uint dwFileOffsetLow, uint dwNumberOfBytesToMap);

@DllImport("KERNEL32.dll")
void* MapViewOfFileEx(HANDLE hFileMappingObject, uint dwDesiredAccess, uint dwFileOffsetHigh, uint dwFileOffsetLow, uint dwNumberOfBytesToMap, void* lpBaseAddress);

@DllImport("KERNEL32.dll")
BOOL VirtualFreeEx(HANDLE hProcess, void* lpAddress, uint dwSize, uint dwFreeType);

@DllImport("KERNEL32.dll")
BOOL FlushViewOfFile(void* lpBaseAddress, uint dwNumberOfBytesToFlush);

@DllImport("KERNEL32.dll")
BOOL UnmapViewOfFile(void* lpBaseAddress);

@DllImport("KERNEL32.dll")
uint GetLargePageMinimum();

@DllImport("KERNEL32.dll")
BOOL GetProcessWorkingSetSizeEx(HANDLE hProcess, uint* lpMinimumWorkingSetSize, uint* lpMaximumWorkingSetSize, uint* Flags);

@DllImport("KERNEL32.dll")
BOOL SetProcessWorkingSetSizeEx(HANDLE hProcess, uint dwMinimumWorkingSetSize, uint dwMaximumWorkingSetSize, uint Flags);

@DllImport("KERNEL32.dll")
BOOL VirtualLock(void* lpAddress, uint dwSize);

@DllImport("KERNEL32.dll")
BOOL VirtualUnlock(void* lpAddress, uint dwSize);

@DllImport("KERNEL32.dll")
uint GetWriteWatch(uint dwFlags, void* lpBaseAddress, uint dwRegionSize, char* lpAddresses, uint* lpdwCount, uint* lpdwGranularity);

@DllImport("KERNEL32.dll")
uint ResetWriteWatch(void* lpBaseAddress, uint dwRegionSize);

@DllImport("KERNEL32.dll")
HANDLE CreateMemoryResourceNotification(MEMORY_RESOURCE_NOTIFICATION_TYPE NotificationType);

@DllImport("KERNEL32.dll")
BOOL QueryMemoryResourceNotification(HANDLE ResourceNotificationHandle, int* ResourceState);

@DllImport("KERNEL32.dll")
BOOL GetSystemFileCacheSize(uint* lpMinimumFileCacheSize, uint* lpMaximumFileCacheSize, uint* lpFlags);

@DllImport("KERNEL32.dll")
BOOL SetSystemFileCacheSize(uint MinimumFileCacheSize, uint MaximumFileCacheSize, uint Flags);

@DllImport("KERNEL32.dll")
HANDLE CreateFileMappingNumaW(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, uint flProtect, uint dwMaximumSizeHigh, uint dwMaximumSizeLow, const(wchar)* lpName, uint nndPreferred);

@DllImport("KERNEL32.dll")
BOOL PrefetchVirtualMemory(HANDLE hProcess, uint NumberOfEntries, char* VirtualAddresses, uint Flags);

@DllImport("KERNEL32.dll")
HANDLE CreateFileMappingFromApp(HANDLE hFile, SECURITY_ATTRIBUTES* SecurityAttributes, uint PageProtection, ulong MaximumSize, const(wchar)* Name);

@DllImport("KERNEL32.dll")
void* MapViewOfFileFromApp(HANDLE hFileMappingObject, uint DesiredAccess, ulong FileOffset, uint NumberOfBytesToMap);

@DllImport("KERNEL32.dll")
BOOL UnmapViewOfFileEx(void* BaseAddress, uint UnmapFlags);

@DllImport("KERNEL32.dll")
BOOL AllocateUserPhysicalPages(HANDLE hProcess, uint* NumberOfPages, char* PageArray);

@DllImport("KERNEL32.dll")
BOOL FreeUserPhysicalPages(HANDLE hProcess, uint* NumberOfPages, char* PageArray);

@DllImport("KERNEL32.dll")
BOOL MapUserPhysicalPages(void* VirtualAddress, uint NumberOfPages, char* PageArray);

@DllImport("KERNEL32.dll")
BOOL AllocateUserPhysicalPagesNuma(HANDLE hProcess, uint* NumberOfPages, char* PageArray, uint nndPreferred);

@DllImport("KERNEL32.dll")
void* VirtualAllocExNuma(HANDLE hProcess, void* lpAddress, uint dwSize, uint flAllocationType, uint flProtect, uint nndPreferred);

@DllImport("KERNEL32.dll")
BOOL GetMemoryErrorHandlingCapabilities(uint* Capabilities);

@DllImport("KERNEL32.dll")
void* RegisterBadMemoryNotification(PBAD_MEMORY_CALLBACK_ROUTINE Callback);

@DllImport("KERNEL32.dll")
BOOL UnregisterBadMemoryNotification(void* RegistrationHandle);

@DllImport("KERNEL32.dll")
uint OfferVirtualMemory(char* VirtualAddress, uint Size, OFFER_PRIORITY Priority);

@DllImport("KERNEL32.dll")
uint ReclaimVirtualMemory(char* VirtualAddress, uint Size);

@DllImport("KERNEL32.dll")
uint DiscardVirtualMemory(char* VirtualAddress, uint Size);

@DllImport("api-ms-win-core-memory-l1-1-3.dll")
BOOL SetProcessValidCallTargets(HANDLE hProcess, void* VirtualAddress, uint RegionSize, uint NumberOfOffsets, char* OffsetInformation);

@DllImport("api-ms-win-core-memory-l1-1-7.dll")
BOOL SetProcessValidCallTargetsForMappedView(HANDLE Process, void* VirtualAddress, uint RegionSize, uint NumberOfOffsets, char* OffsetInformation, HANDLE Section, ulong ExpectedFileOffset);

@DllImport("api-ms-win-core-memory-l1-1-3.dll")
void* VirtualAllocFromApp(void* BaseAddress, uint Size, uint AllocationType, uint Protection);

@DllImport("api-ms-win-core-memory-l1-1-3.dll")
BOOL VirtualProtectFromApp(void* Address, uint Size, uint NewProtection, uint* OldProtection);

@DllImport("api-ms-win-core-memory-l1-1-3.dll")
HANDLE OpenFileMappingFromApp(uint DesiredAccess, BOOL InheritHandle, const(wchar)* Name);

@DllImport("api-ms-win-core-memory-l1-1-4.dll")
BOOL QueryVirtualMemoryInformation(HANDLE Process, const(void)* VirtualAddress, WIN32_MEMORY_INFORMATION_CLASS MemoryInformationClass, char* MemoryInformation, uint MemoryInformationSize, uint* ReturnSize);

@DllImport("api-ms-win-core-memory-l1-1-5.dll")
void* MapViewOfFileNuma2(HANDLE FileMappingHandle, HANDLE ProcessHandle, ulong Offset, void* BaseAddress, uint ViewSize, uint AllocationType, uint PageProtection, uint PreferredNode);

@DllImport("api-ms-win-core-memory-l1-1-5.dll")
BOOL UnmapViewOfFile2(HANDLE Process, void* BaseAddress, uint UnmapFlags);

@DllImport("api-ms-win-core-memory-l1-1-5.dll")
BOOL VirtualUnlockEx(HANDLE Process, void* Address, uint Size);

@DllImport("api-ms-win-core-memory-l1-1-6.dll")
void* VirtualAlloc2(HANDLE Process, void* BaseAddress, uint Size, uint AllocationType, uint PageProtection, char* ExtendedParameters, uint ParameterCount);

@DllImport("api-ms-win-core-memory-l1-1-6.dll")
void* MapViewOfFile3(HANDLE FileMapping, HANDLE Process, void* BaseAddress, ulong Offset, uint ViewSize, uint AllocationType, uint PageProtection, char* ExtendedParameters, uint ParameterCount);

@DllImport("api-ms-win-core-memory-l1-1-6.dll")
void* VirtualAlloc2FromApp(HANDLE Process, void* BaseAddress, uint Size, uint AllocationType, uint PageProtection, char* ExtendedParameters, uint ParameterCount);

@DllImport("api-ms-win-core-memory-l1-1-6.dll")
void* MapViewOfFile3FromApp(HANDLE FileMapping, HANDLE Process, void* BaseAddress, ulong Offset, uint ViewSize, uint AllocationType, uint PageProtection, char* ExtendedParameters, uint ParameterCount);

@DllImport("api-ms-win-core-memory-l1-1-7.dll")
HANDLE CreateFileMapping2(HANDLE File, SECURITY_ATTRIBUTES* SecurityAttributes, uint DesiredAccess, uint PageProtection, uint AllocationAttributes, ulong MaximumSize, const(wchar)* Name, char* ExtendedParameters, uint ParameterCount);

@DllImport("KERNEL32.dll")
BOOL IsEnclaveTypeSupported(uint flEnclaveType);

@DllImport("KERNEL32.dll")
void* CreateEnclave(HANDLE hProcess, void* lpAddress, uint dwSize, uint dwInitialCommitment, uint flEnclaveType, char* lpEnclaveInformation, uint dwInfoLength, uint* lpEnclaveError);

@DllImport("KERNEL32.dll")
BOOL LoadEnclaveData(HANDLE hProcess, void* lpAddress, char* lpBuffer, uint nSize, uint flProtect, char* lpPageInformation, uint dwInfoLength, uint* lpNumberOfBytesWritten, uint* lpEnclaveError);

@DllImport("KERNEL32.dll")
BOOL InitializeEnclave(HANDLE hProcess, void* lpAddress, char* lpEnclaveInformation, uint dwInfoLength, uint* lpEnclaveError);

@DllImport("api-ms-win-core-enclave-l1-1-1.dll")
BOOL LoadEnclaveImageA(void* lpEnclaveAddress, const(char)* lpImageName);

@DllImport("api-ms-win-core-enclave-l1-1-1.dll")
BOOL LoadEnclaveImageW(void* lpEnclaveAddress, const(wchar)* lpImageName);

@DllImport("api-ms-win-core-enclave-l1-1-1.dll")
BOOL CallEnclave(LPENCLAVE_ROUTINE lpRoutine, void* lpParameter, BOOL fWaitForThread, void** lpReturnValue);

@DllImport("api-ms-win-core-enclave-l1-1-1.dll")
BOOL TerminateEnclave(void* lpAddress, BOOL fWait);

@DllImport("api-ms-win-core-enclave-l1-1-1.dll")
BOOL DeleteEnclave(void* lpAddress);

@DllImport("KERNEL32.dll")
BOOL DisableThreadLibraryCalls(int hLibModule);

@DllImport("KERNEL32.dll")
int FindResourceExW(int hModule, const(wchar)* lpType, const(wchar)* lpName, ushort wLanguage);

@DllImport("KERNEL32.dll")
BOOL FreeLibrary(int hLibModule);

@DllImport("KERNEL32.dll")
void FreeLibraryAndExitThread(int hLibModule, uint dwExitCode);

@DllImport("KERNEL32.dll")
uint GetModuleFileNameA(int hModule, const(char)* lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
uint GetModuleFileNameW(int hModule, const(wchar)* lpFilename, uint nSize);

@DllImport("KERNEL32.dll")
int GetModuleHandleA(const(char)* lpModuleName);

@DllImport("KERNEL32.dll")
int GetModuleHandleW(const(wchar)* lpModuleName);

@DllImport("KERNEL32.dll")
BOOL GetModuleHandleExA(uint dwFlags, const(char)* lpModuleName, int* phModule);

@DllImport("KERNEL32.dll")
BOOL GetModuleHandleExW(uint dwFlags, const(wchar)* lpModuleName, int* phModule);

@DllImport("KERNEL32.dll")
FARPROC GetProcAddress(int hModule, const(char)* lpProcName);

@DllImport("KERNEL32.dll")
int LoadLibraryExA(const(char)* lpLibFileName, HANDLE hFile, uint dwFlags);

@DllImport("KERNEL32.dll")
int LoadLibraryExW(const(wchar)* lpLibFileName, HANDLE hFile, uint dwFlags);

@DllImport("KERNEL32.dll")
void* AddDllDirectory(const(wchar)* NewDirectory);

@DllImport("KERNEL32.dll")
BOOL RemoveDllDirectory(void* Cookie);

@DllImport("KERNEL32.dll")
BOOL SetDefaultDllDirectories(uint DirectoryFlags);

@DllImport("KERNEL32.dll")
int FindResourceW(int hModule, const(wchar)* lpName, const(wchar)* lpType);

@DllImport("KERNEL32.dll")
int LoadLibraryA(const(char)* lpLibFileName);

@DllImport("KERNEL32.dll")
int LoadLibraryW(const(wchar)* lpLibFileName);

@DllImport("KERNEL32.dll")
BOOL EnumResourceNamesW(int hModule, const(wchar)* lpType, ENUMRESNAMEPROCW lpEnumFunc, int lParam);

@DllImport("KERNEL32.dll")
BOOL AllocConsole();

@DllImport("KERNEL32.dll")
BOOL FreeConsole();

@DllImport("KERNEL32.dll")
BOOL AttachConsole(uint dwProcessId);

@DllImport("KERNEL32.dll")
uint GetConsoleCP();

@DllImport("KERNEL32.dll")
uint GetConsoleOutputCP();

@DllImport("KERNEL32.dll")
BOOL GetConsoleMode(HANDLE hConsoleHandle, uint* lpMode);

@DllImport("KERNEL32.dll")
BOOL SetConsoleMode(HANDLE hConsoleHandle, uint dwMode);

@DllImport("KERNEL32.dll")
BOOL GetNumberOfConsoleInputEvents(HANDLE hConsoleInput, uint* lpNumberOfEvents);

@DllImport("KERNEL32.dll")
BOOL ReadConsoleInputA(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

@DllImport("KERNEL32.dll")
BOOL ReadConsoleInputW(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

@DllImport("KERNEL32.dll")
BOOL PeekConsoleInputA(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

@DllImport("KERNEL32.dll")
BOOL PeekConsoleInputW(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

@DllImport("KERNEL32.dll")
BOOL ReadConsoleA(HANDLE hConsoleInput, char* lpBuffer, uint nNumberOfCharsToRead, uint* lpNumberOfCharsRead, CONSOLE_READCONSOLE_CONTROL* pInputControl);

@DllImport("KERNEL32.dll")
BOOL ReadConsoleW(HANDLE hConsoleInput, char* lpBuffer, uint nNumberOfCharsToRead, uint* lpNumberOfCharsRead, CONSOLE_READCONSOLE_CONTROL* pInputControl);

@DllImport("KERNEL32.dll")
BOOL WriteConsoleA(HANDLE hConsoleOutput, char* lpBuffer, uint nNumberOfCharsToWrite, uint* lpNumberOfCharsWritten, void* lpReserved);

@DllImport("KERNEL32.dll")
BOOL WriteConsoleW(HANDLE hConsoleOutput, char* lpBuffer, uint nNumberOfCharsToWrite, uint* lpNumberOfCharsWritten, void* lpReserved);

@DllImport("KERNEL32.dll")
BOOL SetConsoleCtrlHandler(PHANDLER_ROUTINE HandlerRoutine, BOOL Add);

@DllImport("KERNEL32.dll")
HRESULT CreatePseudoConsole(COORD size, HANDLE hInput, HANDLE hOutput, uint dwFlags, void** phPC);

@DllImport("KERNEL32.dll")
HRESULT ResizePseudoConsole(void* hPC, COORD size);

@DllImport("KERNEL32.dll")
void ClosePseudoConsole(void* hPC);

@DllImport("KERNEL32.dll")
BOOL FillConsoleOutputCharacterA(HANDLE hConsoleOutput, byte cCharacter, uint nLength, COORD dwWriteCoord, uint* lpNumberOfCharsWritten);

@DllImport("KERNEL32.dll")
BOOL FillConsoleOutputCharacterW(HANDLE hConsoleOutput, ushort cCharacter, uint nLength, COORD dwWriteCoord, uint* lpNumberOfCharsWritten);

@DllImport("KERNEL32.dll")
BOOL FillConsoleOutputAttribute(HANDLE hConsoleOutput, ushort wAttribute, uint nLength, COORD dwWriteCoord, uint* lpNumberOfAttrsWritten);

@DllImport("KERNEL32.dll")
BOOL GenerateConsoleCtrlEvent(uint dwCtrlEvent, uint dwProcessGroupId);

@DllImport("KERNEL32.dll")
HANDLE CreateConsoleScreenBuffer(uint dwDesiredAccess, uint dwShareMode, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, uint dwFlags, void* lpScreenBufferData);

@DllImport("KERNEL32.dll")
BOOL SetConsoleActiveScreenBuffer(HANDLE hConsoleOutput);

@DllImport("KERNEL32.dll")
BOOL FlushConsoleInputBuffer(HANDLE hConsoleInput);

@DllImport("KERNEL32.dll")
BOOL SetConsoleCP(uint wCodePageID);

@DllImport("KERNEL32.dll")
BOOL SetConsoleOutputCP(uint wCodePageID);

@DllImport("KERNEL32.dll")
BOOL GetConsoleCursorInfo(HANDLE hConsoleOutput, CONSOLE_CURSOR_INFO* lpConsoleCursorInfo);

@DllImport("KERNEL32.dll")
BOOL SetConsoleCursorInfo(HANDLE hConsoleOutput, const(CONSOLE_CURSOR_INFO)* lpConsoleCursorInfo);

@DllImport("KERNEL32.dll")
BOOL GetConsoleScreenBufferInfo(HANDLE hConsoleOutput, CONSOLE_SCREEN_BUFFER_INFO* lpConsoleScreenBufferInfo);

@DllImport("KERNEL32.dll")
BOOL GetConsoleScreenBufferInfoEx(HANDLE hConsoleOutput, CONSOLE_SCREEN_BUFFER_INFOEX* lpConsoleScreenBufferInfoEx);

@DllImport("KERNEL32.dll")
BOOL SetConsoleScreenBufferInfoEx(HANDLE hConsoleOutput, CONSOLE_SCREEN_BUFFER_INFOEX* lpConsoleScreenBufferInfoEx);

@DllImport("KERNEL32.dll")
BOOL SetConsoleScreenBufferSize(HANDLE hConsoleOutput, COORD dwSize);

@DllImport("KERNEL32.dll")
BOOL SetConsoleCursorPosition(HANDLE hConsoleOutput, COORD dwCursorPosition);

@DllImport("KERNEL32.dll")
COORD GetLargestConsoleWindowSize(HANDLE hConsoleOutput);

@DllImport("KERNEL32.dll")
BOOL SetConsoleTextAttribute(HANDLE hConsoleOutput, ushort wAttributes);

@DllImport("KERNEL32.dll")
BOOL SetConsoleWindowInfo(HANDLE hConsoleOutput, BOOL bAbsolute, const(SMALL_RECT)* lpConsoleWindow);

@DllImport("KERNEL32.dll")
BOOL WriteConsoleOutputCharacterA(HANDLE hConsoleOutput, const(char)* lpCharacter, uint nLength, COORD dwWriteCoord, uint* lpNumberOfCharsWritten);

@DllImport("KERNEL32.dll")
BOOL WriteConsoleOutputCharacterW(HANDLE hConsoleOutput, const(wchar)* lpCharacter, uint nLength, COORD dwWriteCoord, uint* lpNumberOfCharsWritten);

@DllImport("KERNEL32.dll")
BOOL WriteConsoleOutputAttribute(HANDLE hConsoleOutput, char* lpAttribute, uint nLength, COORD dwWriteCoord, uint* lpNumberOfAttrsWritten);

@DllImport("KERNEL32.dll")
BOOL ReadConsoleOutputCharacterA(HANDLE hConsoleOutput, const(char)* lpCharacter, uint nLength, COORD dwReadCoord, uint* lpNumberOfCharsRead);

@DllImport("KERNEL32.dll")
BOOL ReadConsoleOutputCharacterW(HANDLE hConsoleOutput, const(wchar)* lpCharacter, uint nLength, COORD dwReadCoord, uint* lpNumberOfCharsRead);

@DllImport("KERNEL32.dll")
BOOL ReadConsoleOutputAttribute(HANDLE hConsoleOutput, char* lpAttribute, uint nLength, COORD dwReadCoord, uint* lpNumberOfAttrsRead);

@DllImport("KERNEL32.dll")
BOOL WriteConsoleInputA(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsWritten);

@DllImport("KERNEL32.dll")
BOOL WriteConsoleInputW(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsWritten);

@DllImport("KERNEL32.dll")
BOOL ScrollConsoleScreenBufferA(HANDLE hConsoleOutput, const(SMALL_RECT)* lpScrollRectangle, const(SMALL_RECT)* lpClipRectangle, COORD dwDestinationOrigin, const(CHAR_INFO)* lpFill);

@DllImport("KERNEL32.dll")
BOOL ScrollConsoleScreenBufferW(HANDLE hConsoleOutput, const(SMALL_RECT)* lpScrollRectangle, const(SMALL_RECT)* lpClipRectangle, COORD dwDestinationOrigin, const(CHAR_INFO)* lpFill);

@DllImport("KERNEL32.dll")
BOOL WriteConsoleOutputA(HANDLE hConsoleOutput, char* lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, SMALL_RECT* lpWriteRegion);

@DllImport("KERNEL32.dll")
BOOL WriteConsoleOutputW(HANDLE hConsoleOutput, char* lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, SMALL_RECT* lpWriteRegion);

@DllImport("KERNEL32.dll")
BOOL ReadConsoleOutputA(HANDLE hConsoleOutput, char* lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, SMALL_RECT* lpReadRegion);

@DllImport("KERNEL32.dll")
BOOL ReadConsoleOutputW(HANDLE hConsoleOutput, char* lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, SMALL_RECT* lpReadRegion);

@DllImport("KERNEL32.dll")
uint GetConsoleTitleA(const(char)* lpConsoleTitle, uint nSize);

@DllImport("KERNEL32.dll")
uint GetConsoleTitleW(const(wchar)* lpConsoleTitle, uint nSize);

@DllImport("KERNEL32.dll")
uint GetConsoleOriginalTitleA(const(char)* lpConsoleTitle, uint nSize);

@DllImport("KERNEL32.dll")
uint GetConsoleOriginalTitleW(const(wchar)* lpConsoleTitle, uint nSize);

@DllImport("KERNEL32.dll")
BOOL SetConsoleTitleA(const(char)* lpConsoleTitle);

@DllImport("KERNEL32.dll")
BOOL SetConsoleTitleW(const(wchar)* lpConsoleTitle);

@DllImport("KERNEL32.dll")
BOOL GetNumberOfConsoleMouseButtons(uint* lpNumberOfMouseButtons);

@DllImport("KERNEL32.dll")
COORD GetConsoleFontSize(HANDLE hConsoleOutput, uint nFont);

@DllImport("KERNEL32.dll")
BOOL GetCurrentConsoleFont(HANDLE hConsoleOutput, BOOL bMaximumWindow, CONSOLE_FONT_INFO* lpConsoleCurrentFont);

@DllImport("KERNEL32.dll")
BOOL GetCurrentConsoleFontEx(HANDLE hConsoleOutput, BOOL bMaximumWindow, CONSOLE_FONT_INFOEX* lpConsoleCurrentFontEx);

@DllImport("KERNEL32.dll")
BOOL SetCurrentConsoleFontEx(HANDLE hConsoleOutput, BOOL bMaximumWindow, CONSOLE_FONT_INFOEX* lpConsoleCurrentFontEx);

@DllImport("KERNEL32.dll")
BOOL GetConsoleSelectionInfo(CONSOLE_SELECTION_INFO* lpConsoleSelectionInfo);

@DllImport("KERNEL32.dll")
BOOL GetConsoleHistoryInfo(CONSOLE_HISTORY_INFO* lpConsoleHistoryInfo);

@DllImport("KERNEL32.dll")
BOOL SetConsoleHistoryInfo(CONSOLE_HISTORY_INFO* lpConsoleHistoryInfo);

@DllImport("KERNEL32.dll")
BOOL GetConsoleDisplayMode(uint* lpModeFlags);

@DllImport("KERNEL32.dll")
BOOL SetConsoleDisplayMode(HANDLE hConsoleOutput, uint dwFlags, COORD* lpNewScreenBufferDimensions);

@DllImport("KERNEL32.dll")
HWND GetConsoleWindow();

@DllImport("KERNEL32.dll")
BOOL AddConsoleAliasA(const(char)* Source, const(char)* Target, const(char)* ExeName);

@DllImport("KERNEL32.dll")
BOOL AddConsoleAliasW(const(wchar)* Source, const(wchar)* Target, const(wchar)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleAliasA(const(char)* Source, const(char)* TargetBuffer, uint TargetBufferLength, const(char)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleAliasW(const(wchar)* Source, const(wchar)* TargetBuffer, uint TargetBufferLength, const(wchar)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleAliasesLengthA(const(char)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleAliasesLengthW(const(wchar)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleAliasExesLengthA();

@DllImport("KERNEL32.dll")
uint GetConsoleAliasExesLengthW();

@DllImport("KERNEL32.dll")
uint GetConsoleAliasesA(const(char)* AliasBuffer, uint AliasBufferLength, const(char)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleAliasesW(const(wchar)* AliasBuffer, uint AliasBufferLength, const(wchar)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleAliasExesA(const(char)* ExeNameBuffer, uint ExeNameBufferLength);

@DllImport("KERNEL32.dll")
uint GetConsoleAliasExesW(const(wchar)* ExeNameBuffer, uint ExeNameBufferLength);

@DllImport("KERNEL32.dll")
void ExpungeConsoleCommandHistoryA(const(char)* ExeName);

@DllImport("KERNEL32.dll")
void ExpungeConsoleCommandHistoryW(const(wchar)* ExeName);

@DllImport("KERNEL32.dll")
BOOL SetConsoleNumberOfCommandsA(uint Number, const(char)* ExeName);

@DllImport("KERNEL32.dll")
BOOL SetConsoleNumberOfCommandsW(uint Number, const(wchar)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleCommandHistoryLengthA(const(char)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleCommandHistoryLengthW(const(wchar)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleCommandHistoryA(const(char)* Commands, uint CommandBufferLength, const(char)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleCommandHistoryW(const(wchar)* Commands, uint CommandBufferLength, const(wchar)* ExeName);

@DllImport("KERNEL32.dll")
uint GetConsoleProcessList(char* lpdwProcessList, uint dwProcessCount);

@DllImport("WINMM.dll")
uint timeSetEvent(uint uDelay, uint uResolution, LPTIMECALLBACK fptc, uint dwUser, uint fuEvent);

@DllImport("WINMM.dll")
uint timeKillEvent(uint uTimerID);

@DllImport("RPCNS4.dll")
int I_RpcNsGetBuffer(RPC_MESSAGE* Message);

@DllImport("RPCNS4.dll")
int I_RpcNsSendReceive(RPC_MESSAGE* Message, void** Handle);

@DllImport("RPCNS4.dll")
void I_RpcNsRaiseException(RPC_MESSAGE* Message, int Status);

@DllImport("RPCNS4.dll")
int I_RpcReBindBuffer(RPC_MESSAGE* Message);

@DllImport("WINSPOOL.dll")
BOOL EnumPrintersA(uint Flags, const(char)* Name, uint Level, char* pPrinterEnum, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
BOOL EnumPrintersW(uint Flags, const(wchar)* Name, uint Level, char* pPrinterEnum, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
HANDLE GetSpoolFileHandle(HANDLE hPrinter);

@DllImport("WINSPOOL.dll")
HANDLE CommitSpoolData(HANDLE hPrinter, HANDLE hSpoolFile, uint cbCommit);

@DllImport("WINSPOOL.dll")
BOOL CloseSpoolFileHandle(HANDLE hPrinter, HANDLE hSpoolFile);

@DllImport("WINSPOOL.dll")
BOOL OpenPrinterA(const(char)* pPrinterName, int* phPrinter, PRINTER_DEFAULTSA* pDefault);

@DllImport("WINSPOOL.dll")
BOOL OpenPrinterW(const(wchar)* pPrinterName, int* phPrinter, PRINTER_DEFAULTSW* pDefault);

@DllImport("WINSPOOL.dll")
BOOL ResetPrinterA(HANDLE hPrinter, PRINTER_DEFAULTSA* pDefault);

@DllImport("SPOOLSS.dll")
BOOL ResetPrinterW(HANDLE hPrinter, PRINTER_DEFAULTSW* pDefault);

@DllImport("WINSPOOL.dll")
BOOL SetJobA(HANDLE hPrinter, uint JobId, uint Level, char* pJob, uint Command);

@DllImport("WINSPOOL.dll")
BOOL SetJobW(HANDLE hPrinter, uint JobId, uint Level, char* pJob, uint Command);

@DllImport("WINSPOOL.dll")
BOOL GetJobA(HANDLE hPrinter, uint JobId, uint Level, char* pJob, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL GetJobW(HANDLE hPrinter, uint JobId, uint Level, char* pJob, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL EnumJobsA(HANDLE hPrinter, uint FirstJob, uint NoJobs, uint Level, char* pJob, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
BOOL EnumJobsW(HANDLE hPrinter, uint FirstJob, uint NoJobs, uint Level, char* pJob, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
HANDLE AddPrinterA(const(char)* pName, uint Level, char* pPrinter);

@DllImport("WINSPOOL.dll")
HANDLE AddPrinterW(const(wchar)* pName, uint Level, char* pPrinter);

@DllImport("WINSPOOL.dll")
BOOL DeletePrinter(HANDLE hPrinter);

@DllImport("WINSPOOL.dll")
BOOL SetPrinterA(HANDLE hPrinter, uint Level, char* pPrinter, uint Command);

@DllImport("WINSPOOL.dll")
BOOL SetPrinterW(HANDLE hPrinter, uint Level, char* pPrinter, uint Command);

@DllImport("WINSPOOL.dll")
BOOL GetPrinterA(HANDLE hPrinter, uint Level, char* pPrinter, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL GetPrinterW(HANDLE hPrinter, uint Level, char* pPrinter, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL AddPrinterDriverA(const(char)* pName, uint Level, ubyte* pDriverInfo);

@DllImport("SPOOLSS.dll")
BOOL AddPrinterDriverW(const(wchar)* pName, uint Level, ubyte* pDriverInfo);

@DllImport("WINSPOOL.dll")
BOOL AddPrinterDriverExA(const(char)* pName, uint Level, char* lpbDriverInfo, uint dwFileCopyFlags);

@DllImport("SPOOLSS.dll")
BOOL AddPrinterDriverExW(const(wchar)* pName, uint Level, char* lpbDriverInfo, uint dwFileCopyFlags);

@DllImport("WINSPOOL.dll")
BOOL EnumPrinterDriversA(const(char)* pName, const(char)* pEnvironment, uint Level, char* pDriverInfo, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
BOOL EnumPrinterDriversW(const(wchar)* pName, const(wchar)* pEnvironment, uint Level, char* pDriverInfo, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
BOOL GetPrinterDriverA(HANDLE hPrinter, const(char)* pEnvironment, uint Level, char* pDriverInfo, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL GetPrinterDriverW(HANDLE hPrinter, const(wchar)* pEnvironment, uint Level, char* pDriverInfo, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL GetPrinterDriverDirectoryA(const(char)* pName, const(char)* pEnvironment, uint Level, char* pDriverDirectory, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL GetPrinterDriverDirectoryW(const(wchar)* pName, const(wchar)* pEnvironment, uint Level, char* pDriverDirectory, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL DeletePrinterDriverA(const(char)* pName, const(char)* pEnvironment, const(char)* pDriverName);

@DllImport("SPOOLSS.dll")
BOOL DeletePrinterDriverW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pDriverName);

@DllImport("WINSPOOL.dll")
BOOL DeletePrinterDriverExA(const(char)* pName, const(char)* pEnvironment, const(char)* pDriverName, uint dwDeleteFlag, uint dwVersionFlag);

@DllImport("SPOOLSS.dll")
BOOL DeletePrinterDriverExW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pDriverName, uint dwDeleteFlag, uint dwVersionFlag);

@DllImport("WINSPOOL.dll")
BOOL AddPrintProcessorA(const(char)* pName, const(char)* pEnvironment, const(char)* pPathName, const(char)* pPrintProcessorName);

@DllImport("SPOOLSS.dll")
BOOL AddPrintProcessorW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pPathName, const(wchar)* pPrintProcessorName);

@DllImport("WINSPOOL.dll")
BOOL EnumPrintProcessorsA(const(char)* pName, const(char)* pEnvironment, uint Level, char* pPrintProcessorInfo, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("SPOOLSS.dll")
BOOL EnumPrintProcessorsW(const(wchar)* pName, const(wchar)* pEnvironment, uint Level, char* pPrintProcessorInfo, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
BOOL GetPrintProcessorDirectoryA(const(char)* pName, const(char)* pEnvironment, uint Level, char* pPrintProcessorInfo, uint cbBuf, uint* pcbNeeded);

@DllImport("SPOOLSS.dll")
BOOL GetPrintProcessorDirectoryW(const(wchar)* pName, const(wchar)* pEnvironment, uint Level, char* pPrintProcessorInfo, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL EnumPrintProcessorDatatypesA(const(char)* pName, const(char)* pPrintProcessorName, uint Level, char* pDatatypes, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("SPOOLSS.dll")
BOOL EnumPrintProcessorDatatypesW(const(wchar)* pName, const(wchar)* pPrintProcessorName, uint Level, char* pDatatypes, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
BOOL DeletePrintProcessorA(const(char)* pName, const(char)* pEnvironment, const(char)* pPrintProcessorName);

@DllImport("SPOOLSS.dll")
BOOL DeletePrintProcessorW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pPrintProcessorName);

@DllImport("WINSPOOL.dll")
uint StartDocPrinterA(HANDLE hPrinter, uint Level, char* pDocInfo);

@DllImport("WINSPOOL.dll")
uint StartDocPrinterW(HANDLE hPrinter, uint Level, char* pDocInfo);

@DllImport("SPOOLSS.dll")
BOOL StartPagePrinter(HANDLE hPrinter);

@DllImport("WINSPOOL.dll")
BOOL WritePrinter(HANDLE hPrinter, char* pBuf, uint cbBuf, uint* pcWritten);

@DllImport("SPOOLSS.dll")
BOOL FlushPrinter(HANDLE hPrinter, char* pBuf, uint cbBuf, uint* pcWritten, uint cSleep);

@DllImport("SPOOLSS.dll")
BOOL EndPagePrinter(HANDLE hPrinter);

@DllImport("WINSPOOL.dll")
BOOL AbortPrinter(HANDLE hPrinter);

@DllImport("SPOOLSS.dll")
BOOL ReadPrinter(HANDLE hPrinter, char* pBuf, uint cbBuf, uint* pNoBytesRead);

@DllImport("WINSPOOL.dll")
BOOL EndDocPrinter(HANDLE hPrinter);

@DllImport("WINSPOOL.dll")
BOOL AddJobA(HANDLE hPrinter, uint Level, char* pData, uint cbBuf, uint* pcbNeeded);

@DllImport("SPOOLSS.dll")
BOOL AddJobW(HANDLE hPrinter, uint Level, char* pData, uint cbBuf, uint* pcbNeeded);

@DllImport("SPOOLSS.dll")
BOOL ScheduleJob(HANDLE hPrinter, uint JobId);

@DllImport("WINSPOOL.dll")
BOOL PrinterProperties(HWND hWnd, HANDLE hPrinter);

@DllImport("WINSPOOL.dll")
int DocumentPropertiesA(HWND hWnd, HANDLE hPrinter, const(char)* pDeviceName, DEVMODEA* pDevModeOutput, DEVMODEA* pDevModeInput, uint fMode);

@DllImport("WINSPOOL.dll")
int DocumentPropertiesW(HWND hWnd, HANDLE hPrinter, const(wchar)* pDeviceName, DEVMODEW* pDevModeOutput, DEVMODEW* pDevModeInput, uint fMode);

@DllImport("WINSPOOL.dll")
int AdvancedDocumentPropertiesA(HWND hWnd, HANDLE hPrinter, const(char)* pDeviceName, DEVMODEA* pDevModeOutput, DEVMODEA* pDevModeInput);

@DllImport("WINSPOOL.dll")
int AdvancedDocumentPropertiesW(HWND hWnd, HANDLE hPrinter, const(wchar)* pDeviceName, DEVMODEW* pDevModeOutput, DEVMODEW* pDevModeInput);

@DllImport("WINSPOOL.dll")
uint GetPrinterDataA(HANDLE hPrinter, const(char)* pValueName, uint* pType, char* pData, uint nSize, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
uint GetPrinterDataW(HANDLE hPrinter, const(wchar)* pValueName, uint* pType, char* pData, uint nSize, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
uint GetPrinterDataExA(HANDLE hPrinter, const(char)* pKeyName, const(char)* pValueName, uint* pType, char* pData, uint nSize, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
uint GetPrinterDataExW(HANDLE hPrinter, const(wchar)* pKeyName, const(wchar)* pValueName, uint* pType, char* pData, uint nSize, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
uint EnumPrinterDataA(HANDLE hPrinter, uint dwIndex, const(char)* pValueName, uint cbValueName, uint* pcbValueName, uint* pType, char* pData, uint cbData, uint* pcbData);

@DllImport("SPOOLSS.dll")
uint EnumPrinterDataW(HANDLE hPrinter, uint dwIndex, const(wchar)* pValueName, uint cbValueName, uint* pcbValueName, uint* pType, char* pData, uint cbData, uint* pcbData);

@DllImport("WINSPOOL.dll")
uint EnumPrinterDataExA(HANDLE hPrinter, const(char)* pKeyName, char* pEnumValues, uint cbEnumValues, uint* pcbEnumValues, uint* pnEnumValues);

@DllImport("SPOOLSS.dll")
uint EnumPrinterDataExW(HANDLE hPrinter, const(wchar)* pKeyName, char* pEnumValues, uint cbEnumValues, uint* pcbEnumValues, uint* pnEnumValues);

@DllImport("WINSPOOL.dll")
uint EnumPrinterKeyA(HANDLE hPrinter, const(char)* pKeyName, const(char)* pSubkey, uint cbSubkey, uint* pcbSubkey);

@DllImport("SPOOLSS.dll")
uint EnumPrinterKeyW(HANDLE hPrinter, const(wchar)* pKeyName, const(wchar)* pSubkey, uint cbSubkey, uint* pcbSubkey);

@DllImport("WINSPOOL.dll")
uint SetPrinterDataA(HANDLE hPrinter, const(char)* pValueName, uint Type, char* pData, uint cbData);

@DllImport("WINSPOOL.dll")
uint SetPrinterDataW(HANDLE hPrinter, const(wchar)* pValueName, uint Type, char* pData, uint cbData);

@DllImport("WINSPOOL.dll")
uint SetPrinterDataExA(HANDLE hPrinter, const(char)* pKeyName, const(char)* pValueName, uint Type, char* pData, uint cbData);

@DllImport("WINSPOOL.dll")
uint SetPrinterDataExW(HANDLE hPrinter, const(wchar)* pKeyName, const(wchar)* pValueName, uint Type, char* pData, uint cbData);

@DllImport("WINSPOOL.dll")
uint DeletePrinterDataA(HANDLE hPrinter, const(char)* pValueName);

@DllImport("WINSPOOL.dll")
uint DeletePrinterDataW(HANDLE hPrinter, const(wchar)* pValueName);

@DllImport("WINSPOOL.dll")
uint DeletePrinterDataExA(HANDLE hPrinter, const(char)* pKeyName, const(char)* pValueName);

@DllImport("WINSPOOL.dll")
uint DeletePrinterDataExW(HANDLE hPrinter, const(wchar)* pKeyName, const(wchar)* pValueName);

@DllImport("WINSPOOL.dll")
uint DeletePrinterKeyA(HANDLE hPrinter, const(char)* pKeyName);

@DllImport("SPOOLSS.dll")
uint DeletePrinterKeyW(HANDLE hPrinter, const(wchar)* pKeyName);

@DllImport("SPOOLSS.dll")
uint WaitForPrinterChange(HANDLE hPrinter, uint Flags);

@DllImport("WINSPOOL.dll")
HANDLE FindFirstPrinterChangeNotification(HANDLE hPrinter, uint fdwFilter, uint fdwOptions, void* pPrinterNotifyOptions);

@DllImport("WINSPOOL.dll")
BOOL FindNextPrinterChangeNotification(HANDLE hChange, uint* pdwChange, void* pvReserved, void** ppPrinterNotifyInfo);

@DllImport("WINSPOOL.dll")
BOOL FreePrinterNotifyInfo(PRINTER_NOTIFY_INFO* pPrinterNotifyInfo);

@DllImport("SPOOLSS.dll")
BOOL FindClosePrinterChangeNotification(HANDLE hChange);

@DllImport("WINSPOOL.dll")
uint PrinterMessageBoxA(HANDLE hPrinter, uint Error, HWND hWnd, const(char)* pText, const(char)* pCaption, uint dwType);

@DllImport("SPOOLSS.dll")
uint PrinterMessageBoxW(HANDLE hPrinter, uint Error, HWND hWnd, const(wchar)* pText, const(wchar)* pCaption, uint dwType);

@DllImport("WINSPOOL.dll")
BOOL ClosePrinter(HANDLE hPrinter);

@DllImport("WINSPOOL.dll")
BOOL AddFormA(HANDLE hPrinter, uint Level, char* pForm);

@DllImport("SPOOLSS.dll")
BOOL AddFormW(HANDLE hPrinter, uint Level, char* pForm);

@DllImport("WINSPOOL.dll")
BOOL DeleteFormA(HANDLE hPrinter, const(char)* pFormName);

@DllImport("SPOOLSS.dll")
BOOL DeleteFormW(HANDLE hPrinter, const(wchar)* pFormName);

@DllImport("WINSPOOL.dll")
BOOL GetFormA(HANDLE hPrinter, const(char)* pFormName, uint Level, char* pForm, uint cbBuf, uint* pcbNeeded);

@DllImport("SPOOLSS.dll")
BOOL GetFormW(HANDLE hPrinter, const(wchar)* pFormName, uint Level, char* pForm, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL SetFormA(HANDLE hPrinter, const(char)* pFormName, uint Level, char* pForm);

@DllImport("SPOOLSS.dll")
BOOL SetFormW(HANDLE hPrinter, const(wchar)* pFormName, uint Level, char* pForm);

@DllImport("WINSPOOL.dll")
BOOL EnumFormsA(HANDLE hPrinter, uint Level, char* pForm, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("SPOOLSS.dll")
BOOL EnumFormsW(HANDLE hPrinter, uint Level, char* pForm, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
BOOL EnumMonitorsA(const(char)* pName, uint Level, char* pMonitor, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("SPOOLSS.dll")
BOOL EnumMonitorsW(const(wchar)* pName, uint Level, char* pMonitor, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
BOOL AddMonitorA(const(char)* pName, uint Level, char* pMonitors);

@DllImport("SPOOLSS.dll")
BOOL AddMonitorW(const(wchar)* pName, uint Level, char* pMonitors);

@DllImport("WINSPOOL.dll")
BOOL DeleteMonitorA(const(char)* pName, const(char)* pEnvironment, const(char)* pMonitorName);

@DllImport("SPOOLSS.dll")
BOOL DeleteMonitorW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pMonitorName);

@DllImport("WINSPOOL.dll")
BOOL EnumPortsA(const(char)* pName, uint Level, char* pPort, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
BOOL EnumPortsW(const(wchar)* pName, uint Level, char* pPort, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL.dll")
BOOL AddPortA(const(char)* pName, HWND hWnd, const(char)* pMonitorName);

@DllImport("SPOOLSS.dll")
BOOL AddPortW(const(wchar)* pName, HWND hWnd, const(wchar)* pMonitorName);

@DllImport("WINSPOOL.dll")
BOOL ConfigurePortA(const(char)* pName, HWND hWnd, const(char)* pPortName);

@DllImport("SPOOLSS.dll")
BOOL ConfigurePortW(const(wchar)* pName, HWND hWnd, const(wchar)* pPortName);

@DllImport("WINSPOOL.dll")
BOOL DeletePortA(const(char)* pName, HWND hWnd, const(char)* pPortName);

@DllImport("SPOOLSS.dll")
BOOL DeletePortW(const(wchar)* pName, HWND hWnd, const(wchar)* pPortName);

@DllImport("WINSPOOL.dll")
BOOL XcvDataW(HANDLE hXcv, const(wchar)* pszDataName, char* pInputData, uint cbInputData, char* pOutputData, uint cbOutputData, uint* pcbOutputNeeded, uint* pdwStatus);

@DllImport("WINSPOOL.dll")
BOOL GetDefaultPrinterA(const(char)* pszBuffer, uint* pcchBuffer);

@DllImport("WINSPOOL.dll")
BOOL GetDefaultPrinterW(const(wchar)* pszBuffer, uint* pcchBuffer);

@DllImport("WINSPOOL.dll")
BOOL SetDefaultPrinterA(const(char)* pszPrinter);

@DllImport("WINSPOOL.dll")
BOOL SetDefaultPrinterW(const(wchar)* pszPrinter);

@DllImport("WINSPOOL.dll")
BOOL SetPortA(const(char)* pName, const(char)* pPortName, uint dwLevel, char* pPortInfo);

@DllImport("SPOOLSS.dll")
BOOL SetPortW(const(wchar)* pName, const(wchar)* pPortName, uint dwLevel, char* pPortInfo);

@DllImport("WINSPOOL.dll")
BOOL AddPrinterConnectionA(const(char)* pName);

@DllImport("WINSPOOL.dll")
BOOL AddPrinterConnectionW(const(wchar)* pName);

@DllImport("WINSPOOL.dll")
BOOL DeletePrinterConnectionA(const(char)* pName);

@DllImport("WINSPOOL.dll")
BOOL DeletePrinterConnectionW(const(wchar)* pName);

@DllImport("WINSPOOL.dll")
HANDLE ConnectToPrinterDlg(HWND hwnd, uint Flags);

@DllImport("WINSPOOL.dll")
BOOL AddPrintProvidorA(const(char)* pName, uint Level, char* pProvidorInfo);

@DllImport("SPOOLSS.dll")
BOOL AddPrintProvidorW(const(wchar)* pName, uint Level, char* pProvidorInfo);

@DllImport("WINSPOOL.dll")
BOOL DeletePrintProvidorA(const(char)* pName, const(char)* pEnvironment, const(char)* pPrintProvidorName);

@DllImport("SPOOLSS.dll")
BOOL DeletePrintProvidorW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pPrintProvidorName);

@DllImport("WINSPOOL.dll")
BOOL IsValidDevmodeA(DEVMODEA* pDevmode, uint DevmodeSize);

@DllImport("WINSPOOL.dll")
BOOL IsValidDevmodeW(DEVMODEW* pDevmode, uint DevmodeSize);

@DllImport("WINSPOOL.dll")
BOOL OpenPrinter2A(const(char)* pPrinterName, int* phPrinter, PRINTER_DEFAULTSA* pDefault, PRINTER_OPTIONSA* pOptions);

@DllImport("SPOOLSS.dll")
BOOL OpenPrinter2W(const(wchar)* pPrinterName, int* phPrinter, PRINTER_DEFAULTSW* pDefault, PRINTER_OPTIONSW* pOptions);

@DllImport("WINSPOOL.dll")
BOOL AddPrinterConnection2A(HWND hWnd, const(char)* pszName, uint dwLevel, void* pConnectionInfo);

@DllImport("WINSPOOL.dll")
BOOL AddPrinterConnection2W(HWND hWnd, const(wchar)* pszName, uint dwLevel, void* pConnectionInfo);

@DllImport("WINSPOOL.dll")
HRESULT InstallPrinterDriverFromPackageA(const(char)* pszServer, const(char)* pszInfPath, const(char)* pszDriverName, const(char)* pszEnvironment, uint dwFlags);

@DllImport("WINSPOOL.dll")
HRESULT InstallPrinterDriverFromPackageW(const(wchar)* pszServer, const(wchar)* pszInfPath, const(wchar)* pszDriverName, const(wchar)* pszEnvironment, uint dwFlags);

@DllImport("WINSPOOL.dll")
HRESULT UploadPrinterDriverPackageA(const(char)* pszServer, const(char)* pszInfPath, const(char)* pszEnvironment, uint dwFlags, HWND hwnd, const(char)* pszDestInfPath, uint* pcchDestInfPath);

@DllImport("WINSPOOL.dll")
HRESULT UploadPrinterDriverPackageW(const(wchar)* pszServer, const(wchar)* pszInfPath, const(wchar)* pszEnvironment, uint dwFlags, HWND hwnd, const(wchar)* pszDestInfPath, uint* pcchDestInfPath);

@DllImport("WINSPOOL.dll")
HRESULT GetCorePrinterDriversA(const(char)* pszServer, const(char)* pszEnvironment, const(char)* pszzCoreDriverDependencies, uint cCorePrinterDrivers, char* pCorePrinterDrivers);

@DllImport("WINSPOOL.dll")
HRESULT GetCorePrinterDriversW(const(wchar)* pszServer, const(wchar)* pszEnvironment, const(wchar)* pszzCoreDriverDependencies, uint cCorePrinterDrivers, char* pCorePrinterDrivers);

@DllImport("WINSPOOL.dll")
HRESULT CorePrinterDriverInstalledA(const(char)* pszServer, const(char)* pszEnvironment, Guid CoreDriverGUID, FILETIME ftDriverDate, ulong dwlDriverVersion, int* pbDriverInstalled);

@DllImport("WINSPOOL.dll")
HRESULT CorePrinterDriverInstalledW(const(wchar)* pszServer, const(wchar)* pszEnvironment, Guid CoreDriverGUID, FILETIME ftDriverDate, ulong dwlDriverVersion, int* pbDriverInstalled);

@DllImport("WINSPOOL.dll")
HRESULT GetPrinterDriverPackagePathA(const(char)* pszServer, const(char)* pszEnvironment, const(char)* pszLanguage, const(char)* pszPackageID, const(char)* pszDriverPackageCab, uint cchDriverPackageCab, uint* pcchRequiredSize);

@DllImport("WINSPOOL.dll")
HRESULT GetPrinterDriverPackagePathW(const(wchar)* pszServer, const(wchar)* pszEnvironment, const(wchar)* pszLanguage, const(wchar)* pszPackageID, const(wchar)* pszDriverPackageCab, uint cchDriverPackageCab, uint* pcchRequiredSize);

@DllImport("WINSPOOL.dll")
HRESULT DeletePrinterDriverPackageA(const(char)* pszServer, const(char)* pszInfPath, const(char)* pszEnvironment);

@DllImport("WINSPOOL.dll")
HRESULT DeletePrinterDriverPackageW(const(wchar)* pszServer, const(wchar)* pszInfPath, const(wchar)* pszEnvironment);

@DllImport("WINSPOOL.dll")
HRESULT ReportJobProcessingProgress(HANDLE printerHandle, uint jobId, EPrintXPSJobOperation jobOperation, EPrintXPSJobProgress jobProgress);

@DllImport("WINSPOOL.dll")
BOOL GetPrinterDriver2A(HWND hWnd, HANDLE hPrinter, const(char)* pEnvironment, uint Level, char* pDriverInfo, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL GetPrinterDriver2W(HWND hWnd, HANDLE hPrinter, const(wchar)* pEnvironment, uint Level, char* pDriverInfo, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL.dll")
BOOL GetPrintExecutionData(PRINT_EXECUTION_DATA* pData);

@DllImport("SPOOLSS.dll")
uint GetJobNamedPropertyValue(HANDLE hPrinter, uint JobId, const(wchar)* pszName, PrintPropertyValue* pValue);

@DllImport("SPOOLSS.dll")
void FreePrintPropertyValue(PrintPropertyValue* pValue);

@DllImport("WINSPOOL.dll")
void FreePrintNamedPropertyArray(uint cProperties, char* ppProperties);

@DllImport("WINSPOOL.dll")
uint SetJobNamedProperty(HANDLE hPrinter, uint JobId, const(PrintNamedProperty)* pProperty);

@DllImport("SPOOLSS.dll")
uint DeleteJobNamedProperty(HANDLE hPrinter, uint JobId, const(wchar)* pszName);

@DllImport("WINSPOOL.dll")
uint EnumJobNamedProperties(HANDLE hPrinter, uint JobId, uint* pcProperties, PrintNamedProperty** ppProperties);

@DllImport("WINSPOOL.dll")
HRESULT GetPrintOutputInfo(HWND hWnd, const(wchar)* pszPrinter, HANDLE* phFile, ushort** ppszOutputFile);

@DllImport("CoreMessaging.dll")
HRESULT CreateDispatcherQueueController(DispatcherQueueOptions options, DispatcherQueueController* dispatcherQueueController);

@DllImport("VSSAPI.dll")
HRESULT CreateVssExpressWriterInternal(IVssExpressWriter* ppWriter);

@DllImport("GDI32.dll")
BOOL EngQueryEMFInfo(HDEV__* hdev, EMFINFO* pEMFInfo);

@DllImport("api-ms-win-core-libraryloader-l2-1-0.dll")
BOOL QueryOptionalDelayLoadedAPI(int hParentModule, const(char)* lpDllName, const(char)* lpProcName, uint Reserved);

@DllImport("vertdll.dll")
HRESULT EnclaveGetAttestationReport(const(ubyte)* EnclaveData, char* Report, uint BufferSize, uint* OutputSize);

@DllImport("vertdll.dll")
HRESULT EnclaveVerifyAttestationReport(uint EnclaveType, char* Report, uint ReportSize);

@DllImport("vertdll.dll")
HRESULT EnclaveSealData(char* DataToEncrypt, uint DataToEncryptSize, ENCLAVE_SEALING_IDENTITY_POLICY IdentityPolicy, uint RuntimePolicy, char* ProtectedBlob, uint BufferSize, uint* ProtectedBlobSize);

@DllImport("vertdll.dll")
HRESULT EnclaveUnsealData(char* ProtectedBlob, uint ProtectedBlobSize, char* DecryptedData, uint BufferSize, uint* DecryptedDataSize, ENCLAVE_IDENTITY* SealingIdentity, uint* UnsealingFlags);

@DllImport("vertdll.dll")
HRESULT EnclaveGetEnclaveInformation(uint InformationSize, char* EnclaveInformation);

@DllImport("POWRPROF.dll")
NTSTATUS CallNtPowerInformation(POWER_INFORMATION_LEVEL InformationLevel, char* InputBuffer, uint InputBufferLength, char* OutputBuffer, uint OutputBufferLength);

@DllImport("api-ms-win-power-base-l1-1-0.dll")
ubyte GetPwrCapabilities(SYSTEM_POWER_CAPABILITIES* lpspc);

@DllImport("api-ms-win-power-base-l1-1-0.dll")
POWER_PLATFORM_ROLE PowerDeterminePlatformRoleEx(uint Version);

@DllImport("api-ms-win-power-base-l1-1-0.dll")
uint PowerRegisterSuspendResumeNotification(uint Flags, HANDLE Recipient, void** RegistrationHandle);

@DllImport("api-ms-win-power-base-l1-1-0.dll")
uint PowerUnregisterSuspendResumeNotification(void* RegistrationHandle);

@DllImport("api-ms-win-power-setting-l1-1-0.dll")
uint PowerReadACValue(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint* Type, char* Buffer, uint* BufferSize);

@DllImport("api-ms-win-power-setting-l1-1-0.dll")
uint PowerReadDCValue(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint* Type, char* Buffer, uint* BufferSize);

@DllImport("api-ms-win-power-setting-l1-1-0.dll")
uint PowerGetActiveScheme(HKEY UserRootPowerKey, Guid** ActivePolicyGuid);

@DllImport("api-ms-win-power-setting-l1-1-0.dll")
uint PowerSetActiveScheme(HKEY UserRootPowerKey, const(Guid)* SchemeGuid);

@DllImport("api-ms-win-power-setting-l1-1-0.dll")
uint PowerSettingRegisterNotification(Guid* SettingGuid, uint Flags, HANDLE Recipient, void** RegistrationHandle);

@DllImport("api-ms-win-power-setting-l1-1-0.dll")
uint PowerSettingUnregisterNotification(void* RegistrationHandle);

@DllImport("api-ms-win-power-setting-l1-1-1.dll")
HRESULT PowerRegisterForEffectivePowerModeNotifications(uint Version, EFFECTIVE_POWER_MODE_CALLBACK* Callback, void* Context, void** RegistrationHandle);

@DllImport("api-ms-win-power-setting-l1-1-1.dll")
HRESULT PowerUnregisterFromEffectivePowerModeNotifications(void* RegistrationHandle);

@DllImport("POWRPROF.dll")
ubyte GetPwrDiskSpindownRange(uint* puiMax, uint* puiMin);

@DllImport("POWRPROF.dll")
ubyte EnumPwrSchemes(PWRSCHEMESENUMPROC lpfn, LPARAM lParam);

@DllImport("POWRPROF.dll")
ubyte ReadGlobalPwrPolicy(GLOBAL_POWER_POLICY* pGlobalPowerPolicy);

@DllImport("POWRPROF.dll")
ubyte ReadPwrScheme(uint uiID, POWER_POLICY* pPowerPolicy);

@DllImport("POWRPROF.dll")
ubyte WritePwrScheme(uint* puiID, const(wchar)* lpszSchemeName, const(wchar)* lpszDescription, POWER_POLICY* lpScheme);

@DllImport("POWRPROF.dll")
ubyte WriteGlobalPwrPolicy(GLOBAL_POWER_POLICY* pGlobalPowerPolicy);

@DllImport("POWRPROF.dll")
ubyte DeletePwrScheme(uint uiID);

@DllImport("POWRPROF.dll")
ubyte GetActivePwrScheme(uint* puiID);

@DllImport("POWRPROF.dll")
ubyte SetActivePwrScheme(uint uiID, GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

@DllImport("POWRPROF.dll")
ubyte IsPwrSuspendAllowed();

@DllImport("POWRPROF.dll")
ubyte IsPwrHibernateAllowed();

@DllImport("POWRPROF.dll")
ubyte IsPwrShutdownAllowed();

@DllImport("POWRPROF.dll")
ubyte IsAdminOverrideActive(ADMINISTRATOR_POWER_POLICY* papp);

@DllImport("POWRPROF.dll")
ubyte SetSuspendState(ubyte bHibernate, ubyte bForce, ubyte bWakeupEventsDisabled);

@DllImport("POWRPROF.dll")
ubyte GetCurrentPowerPolicies(GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

@DllImport("POWRPROF.dll")
ubyte CanUserWritePwrScheme();

@DllImport("POWRPROF.dll")
ubyte ReadProcessorPwrScheme(uint uiID, MACHINE_PROCESSOR_POWER_POLICY* pMachineProcessorPowerPolicy);

@DllImport("POWRPROF.dll")
ubyte WriteProcessorPwrScheme(uint uiID, MACHINE_PROCESSOR_POWER_POLICY* pMachineProcessorPowerPolicy);

@DllImport("POWRPROF.dll")
ubyte ValidatePowerPolicies(GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

@DllImport("POWRPROF.dll")
ubyte PowerIsSettingRangeDefined(const(Guid)* SubKeyGuid, const(Guid)* SettingGuid);

@DllImport("POWRPROF.dll")
uint PowerSettingAccessCheckEx(POWER_DATA_ACCESSOR AccessFlags, const(Guid)* PowerGuid, uint AccessType);

@DllImport("POWRPROF.dll")
uint PowerSettingAccessCheck(POWER_DATA_ACCESSOR AccessFlags, const(Guid)* PowerGuid);

@DllImport("POWRPROF.dll")
uint PowerReadFriendlyName(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF.dll")
uint PowerReadDescription(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF.dll")
uint PowerReadPossibleValue(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint* Type, uint PossibleSettingIndex, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF.dll")
uint PowerReadPossibleFriendlyName(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint PossibleSettingIndex, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF.dll")
uint PowerReadPossibleDescription(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint PossibleSettingIndex, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF.dll")
uint PowerReadValueMin(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint* ValueMinimum);

@DllImport("POWRPROF.dll")
uint PowerReadValueMax(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint* ValueMaximum);

@DllImport("POWRPROF.dll")
uint PowerReadValueIncrement(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint* ValueIncrement);

@DllImport("POWRPROF.dll")
uint PowerReadValueUnitsSpecifier(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF.dll")
uint PowerReadIconResourceSpecifier(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF.dll")
uint PowerReadSettingAttributes(const(Guid)* SubGroupGuid, const(Guid)* PowerSettingGuid);

@DllImport("POWRPROF.dll")
uint PowerWriteFriendlyName(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, char* Buffer, uint BufferSize);

@DllImport("POWRPROF.dll")
uint PowerWriteDescription(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, char* Buffer, uint BufferSize);

@DllImport("POWRPROF.dll")
uint PowerWritePossibleValue(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint Type, uint PossibleSettingIndex, char* Buffer, uint BufferSize);

@DllImport("POWRPROF.dll")
uint PowerWritePossibleFriendlyName(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint PossibleSettingIndex, char* Buffer, uint BufferSize);

@DllImport("POWRPROF.dll")
uint PowerWritePossibleDescription(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint PossibleSettingIndex, char* Buffer, uint BufferSize);

@DllImport("POWRPROF.dll")
uint PowerWriteValueMin(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint ValueMinimum);

@DllImport("POWRPROF.dll")
uint PowerWriteValueMax(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint ValueMaximum);

@DllImport("POWRPROF.dll")
uint PowerWriteValueIncrement(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint ValueIncrement);

@DllImport("POWRPROF.dll")
uint PowerWriteValueUnitsSpecifier(HKEY RootPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, char* Buffer, uint BufferSize);

@DllImport("POWRPROF.dll")
uint PowerWriteIconResourceSpecifier(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, char* Buffer, uint BufferSize);

@DllImport("POWRPROF.dll")
uint PowerWriteSettingAttributes(const(Guid)* SubGroupGuid, const(Guid)* PowerSettingGuid, uint Attributes);

@DllImport("POWRPROF.dll")
uint PowerDuplicateScheme(HKEY RootPowerKey, const(Guid)* SourceSchemeGuid, Guid** DestinationSchemeGuid);

@DllImport("POWRPROF.dll")
uint PowerImportPowerScheme(HKEY RootPowerKey, const(wchar)* ImportFileNamePath, Guid** DestinationSchemeGuid);

@DllImport("POWRPROF.dll")
uint PowerDeleteScheme(HKEY RootPowerKey, const(Guid)* SchemeGuid);

@DllImport("POWRPROF.dll")
uint PowerRemovePowerSetting(const(Guid)* PowerSettingSubKeyGuid, const(Guid)* PowerSettingGuid);

@DllImport("POWRPROF.dll")
uint PowerCreateSetting(HKEY RootSystemPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid);

@DllImport("POWRPROF.dll")
uint PowerCreatePossibleSetting(HKEY RootSystemPowerKey, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint PossibleSettingIndex);

@DllImport("POWRPROF.dll")
uint PowerEnumerate(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, POWER_DATA_ACCESSOR AccessFlags, uint Index, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF.dll")
uint PowerOpenUserPowerKey(HKEY* phUserPowerKey, uint Access, BOOL OpenExisting);

@DllImport("POWRPROF.dll")
uint PowerOpenSystemPowerKey(HKEY* phSystemPowerKey, uint Access, BOOL OpenExisting);

@DllImport("POWRPROF.dll")
uint PowerCanRestoreIndividualDefaultPowerScheme(const(Guid)* SchemeGuid);

@DllImport("POWRPROF.dll")
uint PowerRestoreIndividualDefaultPowerScheme(const(Guid)* SchemeGuid);

@DllImport("POWRPROF.dll")
uint PowerRestoreDefaultPowerSchemes();

@DllImport("POWRPROF.dll")
uint PowerReplaceDefaultPowerSchemes();

@DllImport("POWRPROF.dll")
POWER_PLATFORM_ROLE PowerDeterminePlatformRole();

@DllImport("POWRPROF.dll")
ubyte DevicePowerEnumDevices(uint QueryIndex, uint QueryInterpretationFlags, uint QueryFlags, char* pReturnBuffer, uint* pBufferSize);

@DllImport("POWRPROF.dll")
uint DevicePowerSetDeviceState(const(wchar)* DeviceDescription, uint SetFlags, void* SetData);

@DllImport("POWRPROF.dll")
ubyte DevicePowerOpen(uint DebugMask);

@DllImport("POWRPROF.dll")
ubyte DevicePowerClose();

@DllImport("POWRPROF.dll")
uint PowerReportThermalEvent(THERMAL_EVENT* Event);

@DllImport("USER32.dll")
BOOL ExitWindowsEx(uint uFlags, uint dwReason);

@DllImport("USER32.dll")
BOOL IsWow64Message();

@DllImport("USER32.dll")
void* RegisterDeviceNotificationA(HANDLE hRecipient, void* NotificationFilter, uint Flags);

@DllImport("USER32.dll")
void* RegisterDeviceNotificationW(HANDLE hRecipient, void* NotificationFilter, uint Flags);

@DllImport("USER32.dll")
BOOL UnregisterDeviceNotification(void* Handle);

@DllImport("USER32.dll")
void* RegisterPowerSettingNotification(HANDLE hRecipient, Guid* PowerSettingGuid, uint Flags);

@DllImport("USER32.dll")
BOOL UnregisterPowerSettingNotification(void* Handle);

@DllImport("USER32.dll")
void* RegisterSuspendResumeNotification(HANDLE hRecipient, uint Flags);

@DllImport("USER32.dll")
BOOL UnregisterSuspendResumeNotification(void* Handle);

@DllImport("USER32.dll")
BOOL AttachThreadInput(uint idAttach, uint idAttachTo, BOOL fAttach);

@DllImport("USER32.dll")
uint WaitForInputIdle(HANDLE hProcess, uint dwMilliseconds);

@DllImport("USER32.dll")
uint MsgWaitForMultipleObjects(uint nCount, char* pHandles, BOOL fWaitAll, uint dwMilliseconds, uint dwWakeMask);

@DllImport("USER32.dll")
uint MsgWaitForMultipleObjectsEx(uint nCount, char* pHandles, uint dwMilliseconds, uint dwWakeMask, uint dwFlags);

@DllImport("USER32.dll")
uint GetGuiResources(HANDLE hProcess, uint uiFlags);

@DllImport("USER32.dll")
BOOL LockWorkStation();

@DllImport("USER32.dll")
BOOL UserHandleGrantAccess(HANDLE hUserHandle, HANDLE hJob, BOOL bGrant);

@DllImport("USER32.dll")
BOOL ShutdownBlockReasonCreate(HWND hWnd, const(wchar)* pwszReason);

@DllImport("USER32.dll")
BOOL ShutdownBlockReasonQuery(HWND hWnd, const(wchar)* pwszBuff, uint* pcchBuff);

@DllImport("USER32.dll")
BOOL ShutdownBlockReasonDestroy(HWND hWnd);

@DllImport("USER32.dll")
BOOL GetAutoRotationState(AR_STATE* pState);

@DllImport("USER32.dll")
BOOL GetDisplayAutoRotationPreferences(ORIENTATION_PREFERENCE* pOrientation);

@DllImport("USER32.dll")
BOOL SetDisplayAutoRotationPreferences(ORIENTATION_PREFERENCE orientation);

@DllImport("USER32.dll")
BOOL IsImmersiveProcess(HANDLE hProcess);

@DllImport("USER32.dll")
BOOL SetProcessRestrictionExemption(BOOL fEnableExemption);

@DllImport("KERNEL32.dll")
BOOL DeviceIoControl(HANDLE hDevice, uint dwIoControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
BOOL GetOverlappedResult(HANDLE hFile, OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, BOOL bWait);

@DllImport("KERNEL32.dll")
BOOL GetOverlappedResultEx(HANDLE hFile, OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, uint dwMilliseconds, BOOL bAlertable);

@DllImport("KERNEL32.dll")
BOOL IsWow64Process(HANDLE hProcess, int* Wow64Process);

@DllImport("KERNEL32.dll")
BOOL IsWow64Process2(HANDLE hProcess, ushort* pProcessMachine, ushort* pNativeMachine);

@DllImport("KERNEL32.dll")
byte* GetCommandLineA();

@DllImport("KERNEL32.dll")
ushort* GetCommandLineW();

@DllImport("KERNEL32.dll")
byte* GetEnvironmentStrings();

@DllImport("KERNEL32.dll")
ushort* GetEnvironmentStringsW();

@DllImport("KERNEL32.dll")
BOOL FreeEnvironmentStringsA(const(char)* penv);

@DllImport("KERNEL32.dll")
BOOL FreeEnvironmentStringsW(const(wchar)* penv);

@DllImport("KERNEL32.dll")
uint GetEnvironmentVariableA(const(char)* lpName, const(char)* lpBuffer, uint nSize);

@DllImport("KERNEL32.dll")
uint GetEnvironmentVariableW(const(wchar)* lpName, const(wchar)* lpBuffer, uint nSize);

@DllImport("KERNEL32.dll")
BOOL SetEnvironmentVariableA(const(char)* lpName, const(char)* lpValue);

@DllImport("KERNEL32.dll")
BOOL SetEnvironmentVariableW(const(wchar)* lpName, const(wchar)* lpValue);

@DllImport("KERNEL32.dll")
BOOL NeedCurrentDirectoryForExePathA(const(char)* ExeName);

@DllImport("KERNEL32.dll")
BOOL NeedCurrentDirectoryForExePathW(const(wchar)* ExeName);

@DllImport("KERNEL32.dll")
uint QueueUserAPC(PAPCFUNC pfnAPC, HANDLE hThread, uint dwData);

@DllImport("KERNEL32.dll")
BOOL GetProcessTimes(HANDLE hProcess, FILETIME* lpCreationTime, FILETIME* lpExitTime, FILETIME* lpKernelTime, FILETIME* lpUserTime);

@DllImport("KERNEL32.dll")
HANDLE GetCurrentProcess();

@DllImport("KERNEL32.dll")
uint GetCurrentProcessId();

@DllImport("KERNEL32.dll")
void ExitProcess(uint uExitCode);

@DllImport("KERNEL32.dll")
BOOL TerminateProcess(HANDLE hProcess, uint uExitCode);

@DllImport("KERNEL32.dll")
BOOL GetExitCodeProcess(HANDLE hProcess, uint* lpExitCode);

@DllImport("KERNEL32.dll")
BOOL SwitchToThread();

@DllImport("KERNEL32.dll")
HANDLE CreateThread(SECURITY_ATTRIBUTES* lpThreadAttributes, uint dwStackSize, LPTHREAD_START_ROUTINE lpStartAddress, void* lpParameter, uint dwCreationFlags, uint* lpThreadId);

@DllImport("KERNEL32.dll")
HANDLE CreateRemoteThread(HANDLE hProcess, SECURITY_ATTRIBUTES* lpThreadAttributes, uint dwStackSize, LPTHREAD_START_ROUTINE lpStartAddress, void* lpParameter, uint dwCreationFlags, uint* lpThreadId);

@DllImport("KERNEL32.dll")
HANDLE GetCurrentThread();

@DllImport("KERNEL32.dll")
uint GetCurrentThreadId();

@DllImport("KERNEL32.dll")
HANDLE OpenThread(uint dwDesiredAccess, BOOL bInheritHandle, uint dwThreadId);

@DllImport("KERNEL32.dll")
BOOL SetThreadPriority(HANDLE hThread, int nPriority);

@DllImport("KERNEL32.dll")
BOOL SetThreadPriorityBoost(HANDLE hThread, BOOL bDisablePriorityBoost);

@DllImport("KERNEL32.dll")
BOOL GetThreadPriorityBoost(HANDLE hThread, int* pDisablePriorityBoost);

@DllImport("KERNEL32.dll")
int GetThreadPriority(HANDLE hThread);

@DllImport("KERNEL32.dll")
void ExitThread(uint dwExitCode);

@DllImport("KERNEL32.dll")
BOOL TerminateThread(HANDLE hThread, uint dwExitCode);

@DllImport("KERNEL32.dll")
BOOL GetExitCodeThread(HANDLE hThread, uint* lpExitCode);

@DllImport("KERNEL32.dll")
uint SuspendThread(HANDLE hThread);

@DllImport("KERNEL32.dll")
uint ResumeThread(HANDLE hThread);

@DllImport("KERNEL32.dll")
uint TlsAlloc();

@DllImport("KERNEL32.dll")
void* TlsGetValue(uint dwTlsIndex);

@DllImport("KERNEL32.dll")
BOOL TlsSetValue(uint dwTlsIndex, void* lpTlsValue);

@DllImport("KERNEL32.dll")
BOOL TlsFree(uint dwTlsIndex);

@DllImport("KERNEL32.dll")
BOOL CreateProcessA(const(char)* lpApplicationName, const(char)* lpCommandLine, SECURITY_ATTRIBUTES* lpProcessAttributes, SECURITY_ATTRIBUTES* lpThreadAttributes, BOOL bInheritHandles, PROCESS_CREATION_FLAGS dwCreationFlags, void* lpEnvironment, const(char)* lpCurrentDirectory, STARTUPINFOA* lpStartupInfo, PROCESS_INFORMATION* lpProcessInformation);

@DllImport("KERNEL32.dll")
BOOL CreateProcessW(const(wchar)* lpApplicationName, const(wchar)* lpCommandLine, SECURITY_ATTRIBUTES* lpProcessAttributes, SECURITY_ATTRIBUTES* lpThreadAttributes, BOOL bInheritHandles, PROCESS_CREATION_FLAGS dwCreationFlags, void* lpEnvironment, const(wchar)* lpCurrentDirectory, STARTUPINFOW* lpStartupInfo, PROCESS_INFORMATION* lpProcessInformation);

@DllImport("KERNEL32.dll")
BOOL SetProcessShutdownParameters(uint dwLevel, uint dwFlags);

@DllImport("KERNEL32.dll")
uint GetProcessVersion(uint ProcessId);

@DllImport("KERNEL32.dll")
void GetStartupInfoW(STARTUPINFOW* lpStartupInfo);

@DllImport("ADVAPI32.dll")
BOOL CreateProcessAsUserW(HANDLE hToken, const(wchar)* lpApplicationName, const(wchar)* lpCommandLine, SECURITY_ATTRIBUTES* lpProcessAttributes, SECURITY_ATTRIBUTES* lpThreadAttributes, BOOL bInheritHandles, uint dwCreationFlags, void* lpEnvironment, const(wchar)* lpCurrentDirectory, STARTUPINFOW* lpStartupInfo, PROCESS_INFORMATION* lpProcessInformation);

@DllImport("KERNEL32.dll")
BOOL SetPriorityClass(HANDLE hProcess, uint dwPriorityClass);

@DllImport("KERNEL32.dll")
uint GetPriorityClass(HANDLE hProcess);

@DllImport("KERNEL32.dll")
BOOL SetThreadStackGuarantee(uint* StackSizeInBytes);

@DllImport("KERNEL32.dll")
uint GetProcessId(HANDLE Process);

@DllImport("KERNEL32.dll")
uint GetThreadId(HANDLE Thread);

@DllImport("KERNEL32.dll")
void FlushProcessWriteBuffers();

@DllImport("KERNEL32.dll")
uint GetProcessIdOfThread(HANDLE Thread);

@DllImport("KERNEL32.dll")
BOOL InitializeProcThreadAttributeList(char* lpAttributeList, uint dwAttributeCount, uint dwFlags, uint* lpSize);

@DllImport("KERNEL32.dll")
void DeleteProcThreadAttributeList(int lpAttributeList);

@DllImport("KERNEL32.dll")
BOOL UpdateProcThreadAttribute(int lpAttributeList, uint dwFlags, uint Attribute, char* lpValue, uint cbSize, char* lpPreviousValue, uint* lpReturnSize);

@DllImport("KERNEL32.dll")
BOOL SetProcessAffinityUpdateMode(HANDLE hProcess, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL QueryProcessAffinityUpdateMode(HANDLE hProcess, uint* lpdwFlags);

@DllImport("KERNEL32.dll")
HANDLE CreateRemoteThreadEx(HANDLE hProcess, SECURITY_ATTRIBUTES* lpThreadAttributes, uint dwStackSize, LPTHREAD_START_ROUTINE lpStartAddress, void* lpParameter, uint dwCreationFlags, int lpAttributeList, uint* lpThreadId);

@DllImport("KERNEL32.dll")
void GetCurrentThreadStackLimits(uint* LowLimit, uint* HighLimit);

@DllImport("KERNEL32.dll")
BOOL GetProcessMitigationPolicy(HANDLE hProcess, PROCESS_MITIGATION_POLICY MitigationPolicy, char* lpBuffer, uint dwLength);

@DllImport("KERNEL32.dll")
BOOL SetProcessMitigationPolicy(PROCESS_MITIGATION_POLICY MitigationPolicy, char* lpBuffer, uint dwLength);

@DllImport("KERNEL32.dll")
BOOL GetThreadTimes(HANDLE hThread, FILETIME* lpCreationTime, FILETIME* lpExitTime, FILETIME* lpKernelTime, FILETIME* lpUserTime);

@DllImport("KERNEL32.dll")
HANDLE OpenProcess(uint dwDesiredAccess, BOOL bInheritHandle, uint dwProcessId);

@DllImport("KERNEL32.dll")
BOOL GetProcessHandleCount(HANDLE hProcess, uint* pdwHandleCount);

@DllImport("KERNEL32.dll")
uint GetCurrentProcessorNumber();

@DllImport("KERNEL32.dll")
BOOL SetThreadIdealProcessorEx(HANDLE hThread, PROCESSOR_NUMBER* lpIdealProcessor, PROCESSOR_NUMBER* lpPreviousIdealProcessor);

@DllImport("KERNEL32.dll")
BOOL GetThreadIdealProcessorEx(HANDLE hThread, PROCESSOR_NUMBER* lpIdealProcessor);

@DllImport("KERNEL32.dll")
void GetCurrentProcessorNumberEx(PROCESSOR_NUMBER* ProcNumber);

@DllImport("KERNEL32.dll")
BOOL GetProcessPriorityBoost(HANDLE hProcess, int* pDisablePriorityBoost);

@DllImport("KERNEL32.dll")
BOOL SetProcessPriorityBoost(HANDLE hProcess, BOOL bDisablePriorityBoost);

@DllImport("KERNEL32.dll")
BOOL GetThreadIOPendingFlag(HANDLE hThread, int* lpIOIsPending);

@DllImport("KERNEL32.dll")
BOOL GetThreadInformation(HANDLE hThread, THREAD_INFORMATION_CLASS ThreadInformationClass, char* ThreadInformation, uint ThreadInformationSize);

@DllImport("KERNEL32.dll")
BOOL SetThreadInformation(HANDLE hThread, THREAD_INFORMATION_CLASS ThreadInformationClass, char* ThreadInformation, uint ThreadInformationSize);

@DllImport("KERNEL32.dll")
BOOL IsProcessCritical(HANDLE hProcess, int* Critical);

@DllImport("KERNEL32.dll")
BOOL SetProtectedPolicy(Guid* PolicyGuid, uint PolicyValue, uint* OldPolicyValue);

@DllImport("KERNEL32.dll")
BOOL QueryProtectedPolicy(Guid* PolicyGuid, uint* PolicyValue);

@DllImport("KERNEL32.dll")
uint SetThreadIdealProcessor(HANDLE hThread, uint dwIdealProcessor);

@DllImport("KERNEL32.dll")
BOOL SetProcessInformation(HANDLE hProcess, PROCESS_INFORMATION_CLASS ProcessInformationClass, char* ProcessInformation, uint ProcessInformationSize);

@DllImport("KERNEL32.dll")
BOOL GetProcessInformation(HANDLE hProcess, PROCESS_INFORMATION_CLASS ProcessInformationClass, char* ProcessInformation, uint ProcessInformationSize);

@DllImport("ADVAPI32.dll")
BOOL CreateProcessAsUserA(HANDLE hToken, const(char)* lpApplicationName, const(char)* lpCommandLine, SECURITY_ATTRIBUTES* lpProcessAttributes, SECURITY_ATTRIBUTES* lpThreadAttributes, BOOL bInheritHandles, uint dwCreationFlags, void* lpEnvironment, const(char)* lpCurrentDirectory, STARTUPINFOA* lpStartupInfo, PROCESS_INFORMATION* lpProcessInformation);

@DllImport("KERNEL32.dll")
BOOL GetProcessShutdownParameters(uint* lpdwLevel, uint* lpdwFlags);

@DllImport("KERNEL32.dll")
HRESULT SetThreadDescription(HANDLE hThread, const(wchar)* lpThreadDescription);

@DllImport("KERNEL32.dll")
HRESULT GetThreadDescription(HANDLE hThread, ushort** ppszThreadDescription);

@DllImport("KERNEL32.dll")
BOOL GlobalMemoryStatusEx(MEMORYSTATUSEX* lpBuffer);

@DllImport("KERNEL32.dll")
BOOL GetLogicalProcessorInformation(char* Buffer, uint* ReturnedLength);

@DllImport("KERNEL32.dll")
BOOL GetLogicalProcessorInformationEx(LOGICAL_PROCESSOR_RELATIONSHIP RelationshipType, char* Buffer, uint* ReturnedLength);

@DllImport("KERNEL32.dll")
BOOL GetPhysicallyInstalledSystemMemory(ulong* TotalMemoryInKilobytes);

@DllImport("KERNEL32.dll")
BOOL GetProcessorSystemCycleTime(ushort Group, char* Buffer, uint* ReturnedLength);

@DllImport("KERNEL32.dll")
BOOL QueryThreadCycleTime(HANDLE ThreadHandle, ulong* CycleTime);

@DllImport("KERNEL32.dll")
BOOL QueryProcessCycleTime(HANDLE ProcessHandle, ulong* CycleTime);

@DllImport("KERNEL32.dll")
BOOL QueryIdleProcessorCycleTime(uint* BufferLength, char* ProcessorIdleCycleTime);

@DllImport("KERNEL32.dll")
BOOL QueryIdleProcessorCycleTimeEx(ushort Group, uint* BufferLength, char* ProcessorIdleCycleTime);

@DllImport("KERNEL32.dll")
int GlobalAlloc(uint uFlags, uint dwBytes);

@DllImport("KERNEL32.dll")
int GlobalReAlloc(int hMem, uint dwBytes, uint uFlags);

@DllImport("KERNEL32.dll")
uint GlobalSize(int hMem);

@DllImport("KERNEL32.dll")
BOOL GlobalUnlock(int hMem);

@DllImport("KERNEL32.dll")
void* GlobalLock(int hMem);

@DllImport("KERNEL32.dll")
uint GlobalFlags(int hMem);

@DllImport("KERNEL32.dll")
int GlobalHandle(void* pMem);

@DllImport("KERNEL32.dll")
int GlobalFree(int hMem);

@DllImport("KERNEL32.dll")
void GlobalMemoryStatus(MEMORYSTATUS* lpBuffer);

@DllImport("KERNEL32.dll")
int LocalAlloc(uint uFlags, uint uBytes);

@DllImport("KERNEL32.dll")
int LocalReAlloc(int hMem, uint uBytes, uint uFlags);

@DllImport("KERNEL32.dll")
void* LocalLock(int hMem);

@DllImport("KERNEL32.dll")
int LocalHandle(void* pMem);

@DllImport("KERNEL32.dll")
BOOL LocalUnlock(int hMem);

@DllImport("KERNEL32.dll")
uint LocalSize(int hMem);

@DllImport("KERNEL32.dll")
uint LocalFlags(int hMem);

@DllImport("KERNEL32.dll")
int LocalFree(int hMem);

@DllImport("KERNEL32.dll")
BOOL GetProcessAffinityMask(HANDLE hProcess, uint* lpProcessAffinityMask, uint* lpSystemAffinityMask);

@DllImport("KERNEL32.dll")
BOOL SetProcessAffinityMask(HANDLE hProcess, uint dwProcessAffinityMask);

@DllImport("KERNEL32.dll")
BOOL GetProcessIoCounters(HANDLE hProcess, IO_COUNTERS* lpIoCounters);

@DllImport("KERNEL32.dll")
BOOL GetProcessWorkingSetSize(HANDLE hProcess, uint* lpMinimumWorkingSetSize, uint* lpMaximumWorkingSetSize);

@DllImport("KERNEL32.dll")
BOOL SetProcessWorkingSetSize(HANDLE hProcess, uint dwMinimumWorkingSetSize, uint dwMaximumWorkingSetSize);

@DllImport("KERNEL32.dll")
void SwitchToFiber(void* lpFiber);

@DllImport("KERNEL32.dll")
void DeleteFiber(void* lpFiber);

@DllImport("KERNEL32.dll")
BOOL ConvertFiberToThread();

@DllImport("KERNEL32.dll")
void* CreateFiberEx(uint dwStackCommitSize, uint dwStackReserveSize, uint dwFlags, LPFIBER_START_ROUTINE lpStartAddress, void* lpParameter);

@DllImport("KERNEL32.dll")
void* ConvertThreadToFiberEx(void* lpParameter, uint dwFlags);

@DllImport("KERNEL32.dll")
void* CreateFiber(uint dwStackSize, LPFIBER_START_ROUTINE lpStartAddress, void* lpParameter);

@DllImport("KERNEL32.dll")
void* ConvertThreadToFiber(void* lpParameter);

@DllImport("KERNEL32.dll")
BOOL CreateUmsCompletionList(void** UmsCompletionList);

@DllImport("KERNEL32.dll")
BOOL DequeueUmsCompletionListItems(void* UmsCompletionList, uint WaitTimeOut, void** UmsThreadList);

@DllImport("KERNEL32.dll")
BOOL GetUmsCompletionListEvent(void* UmsCompletionList, int* UmsCompletionEvent);

@DllImport("KERNEL32.dll")
BOOL ExecuteUmsThread(void* UmsThread);

@DllImport("KERNEL32.dll")
BOOL UmsThreadYield(void* SchedulerParam);

@DllImport("KERNEL32.dll")
BOOL DeleteUmsCompletionList(void* UmsCompletionList);

@DllImport("KERNEL32.dll")
void* GetCurrentUmsThread();

@DllImport("KERNEL32.dll")
void* GetNextUmsListItem(void* UmsContext);

@DllImport("KERNEL32.dll")
BOOL QueryUmsThreadInformation(void* UmsThread, RTL_UMS_THREAD_INFO_CLASS UmsThreadInfoClass, char* UmsThreadInformation, uint UmsThreadInformationLength, uint* ReturnLength);

@DllImport("KERNEL32.dll")
BOOL SetUmsThreadInformation(void* UmsThread, RTL_UMS_THREAD_INFO_CLASS UmsThreadInfoClass, void* UmsThreadInformation, uint UmsThreadInformationLength);

@DllImport("KERNEL32.dll")
BOOL DeleteUmsThreadContext(void* UmsThread);

@DllImport("KERNEL32.dll")
BOOL CreateUmsThreadContext(void** lpUmsThread);

@DllImport("KERNEL32.dll")
BOOL EnterUmsSchedulingMode(UMS_SCHEDULER_STARTUP_INFO* SchedulerStartupInfo);

@DllImport("KERNEL32.dll")
BOOL GetUmsSystemThreadInformation(HANDLE ThreadHandle, UMS_SYSTEM_THREAD_INFORMATION* SystemThreadInfo);

@DllImport("KERNEL32.dll")
uint SetThreadAffinityMask(HANDLE hThread, uint dwThreadAffinityMask);

@DllImport("KERNEL32.dll")
BOOL SetProcessDEPPolicy(uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL GetProcessDEPPolicy(HANDLE hProcess, uint* lpFlags, int* lpPermanent);

@DllImport("KERNEL32.dll")
BOOL RequestWakeupLatency(LATENCY_TIME latency);

@DllImport("KERNEL32.dll")
BOOL IsSystemResumeAutomatic();

@DllImport("KERNEL32.dll")
uint SetThreadExecutionState(uint esFlags);

@DllImport("KERNEL32.dll")
HANDLE PowerCreateRequest(REASON_CONTEXT* Context);

@DllImport("KERNEL32.dll")
BOOL PowerSetRequest(HANDLE PowerRequest, POWER_REQUEST_TYPE RequestType);

@DllImport("KERNEL32.dll")
BOOL PowerClearRequest(HANDLE PowerRequest, POWER_REQUEST_TYPE RequestType);

@DllImport("KERNEL32.dll")
BOOL PulseEvent(HANDLE hEvent);

@DllImport("KERNEL32.dll")
BOOL GetDevicePowerState(HANDLE hDevice, int* pfOn);

@DllImport("KERNEL32.dll")
uint LoadModule(const(char)* lpModuleName, void* lpParameterBlock);

@DllImport("KERNEL32.dll")
uint WinExec(const(char)* lpCmdLine, uint uCmdShow);

@DllImport("KERNEL32.dll")
BOOL ClearCommBreak(HANDLE hFile);

@DllImport("KERNEL32.dll")
BOOL ClearCommError(HANDLE hFile, uint* lpErrors, COMSTAT* lpStat);

@DllImport("KERNEL32.dll")
BOOL SetupComm(HANDLE hFile, uint dwInQueue, uint dwOutQueue);

@DllImport("KERNEL32.dll")
BOOL EscapeCommFunction(HANDLE hFile, uint dwFunc);

@DllImport("KERNEL32.dll")
BOOL GetCommConfig(HANDLE hCommDev, char* lpCC, uint* lpdwSize);

@DllImport("KERNEL32.dll")
BOOL GetCommMask(HANDLE hFile, uint* lpEvtMask);

@DllImport("KERNEL32.dll")
BOOL GetCommProperties(HANDLE hFile, COMMPROP* lpCommProp);

@DllImport("KERNEL32.dll")
BOOL GetCommModemStatus(HANDLE hFile, uint* lpModemStat);

@DllImport("KERNEL32.dll")
BOOL GetCommState(HANDLE hFile, DCB* lpDCB);

@DllImport("KERNEL32.dll")
BOOL GetCommTimeouts(HANDLE hFile, COMMTIMEOUTS* lpCommTimeouts);

@DllImport("KERNEL32.dll")
BOOL PurgeComm(HANDLE hFile, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL SetCommBreak(HANDLE hFile);

@DllImport("KERNEL32.dll")
BOOL SetCommConfig(HANDLE hCommDev, char* lpCC, uint dwSize);

@DllImport("KERNEL32.dll")
BOOL SetCommMask(HANDLE hFile, uint dwEvtMask);

@DllImport("KERNEL32.dll")
BOOL SetCommState(HANDLE hFile, DCB* lpDCB);

@DllImport("KERNEL32.dll")
BOOL SetCommTimeouts(HANDLE hFile, COMMTIMEOUTS* lpCommTimeouts);

@DllImport("KERNEL32.dll")
BOOL TransmitCommChar(HANDLE hFile, byte cChar);

@DllImport("KERNEL32.dll")
BOOL WaitCommEvent(HANDLE hFile, uint* lpEvtMask, OVERLAPPED* lpOverlapped);

@DllImport("api-ms-win-core-comm-l1-1-1.dll")
HANDLE OpenCommPort(uint uPortNumber, uint dwDesiredAccess, uint dwFlagsAndAttributes);

@DllImport("api-ms-win-core-comm-l1-1-2.dll")
uint GetCommPorts(char* lpPortNumbers, uint uPortNumbersCount, uint* puPortNumbersFound);

@DllImport("KERNEL32.dll")
uint SetTapePosition(HANDLE hDevice, uint dwPositionMethod, uint dwPartition, uint dwOffsetLow, uint dwOffsetHigh, BOOL bImmediate);

@DllImport("KERNEL32.dll")
uint GetTapePosition(HANDLE hDevice, uint dwPositionType, uint* lpdwPartition, uint* lpdwOffsetLow, uint* lpdwOffsetHigh);

@DllImport("KERNEL32.dll")
uint PrepareTape(HANDLE hDevice, uint dwOperation, BOOL bImmediate);

@DllImport("KERNEL32.dll")
uint EraseTape(HANDLE hDevice, uint dwEraseType, BOOL bImmediate);

@DllImport("KERNEL32.dll")
uint CreateTapePartition(HANDLE hDevice, uint dwPartitionMethod, uint dwCount, uint dwSize);

@DllImport("KERNEL32.dll")
uint WriteTapemark(HANDLE hDevice, uint dwTapemarkType, uint dwTapemarkCount, BOOL bImmediate);

@DllImport("KERNEL32.dll")
uint GetTapeStatus(HANDLE hDevice);

@DllImport("KERNEL32.dll")
uint GetTapeParameters(HANDLE hDevice, uint dwOperation, uint* lpdwSize, char* lpTapeInformation);

@DllImport("KERNEL32.dll")
uint SetTapeParameters(HANDLE hDevice, uint dwOperation, void* lpTapeInformation);

@DllImport("KERNEL32.dll")
DEP_SYSTEM_POLICY_TYPE GetSystemDEPPolicy();

@DllImport("KERNEL32.dll")
HANDLE CreateMailslotA(const(char)* lpName, uint nMaxMessageSize, uint lReadTimeout, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
HANDLE CreateMailslotW(const(wchar)* lpName, uint nMaxMessageSize, uint lReadTimeout, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
BOOL GetMailslotInfo(HANDLE hMailslot, uint* lpMaxMessageSize, uint* lpNextSize, uint* lpMessageCount, uint* lpReadTimeout);

@DllImport("KERNEL32.dll")
BOOL SetMailslotInfo(HANDLE hMailslot, uint lReadTimeout);

@DllImport("KERNEL32.dll")
uint SignalObjectAndWait(HANDLE hObjectToSignal, HANDLE hObjectToWaitOn, uint dwMilliseconds, BOOL bAlertable);

@DllImport("KERNEL32.dll")
BOOL BackupRead(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToRead, uint* lpNumberOfBytesRead, BOOL bAbort, BOOL bProcessSecurity, void** lpContext);

@DllImport("KERNEL32.dll")
BOOL BackupSeek(HANDLE hFile, uint dwLowBytesToSeek, uint dwHighBytesToSeek, uint* lpdwLowByteSeeked, uint* lpdwHighByteSeeked, void** lpContext);

@DllImport("KERNEL32.dll")
BOOL BackupWrite(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToWrite, uint* lpNumberOfBytesWritten, BOOL bAbort, BOOL bProcessSecurity, void** lpContext);

@DllImport("KERNEL32.dll")
HANDLE CreateSemaphoreA(SECURITY_ATTRIBUTES* lpSemaphoreAttributes, int lInitialCount, int lMaximumCount, const(char)* lpName);

@DllImport("KERNEL32.dll")
HANDLE CreateSemaphoreExA(SECURITY_ATTRIBUTES* lpSemaphoreAttributes, int lInitialCount, int lMaximumCount, const(char)* lpName, uint dwFlags, uint dwDesiredAccess);

@DllImport("KERNEL32.dll")
HANDLE CreateFileMappingA(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, uint flProtect, uint dwMaximumSizeHigh, uint dwMaximumSizeLow, const(char)* lpName);

@DllImport("KERNEL32.dll")
HANDLE CreateFileMappingNumaA(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, uint flProtect, uint dwMaximumSizeHigh, uint dwMaximumSizeLow, const(char)* lpName, uint nndPreferred);

@DllImport("KERNEL32.dll")
HANDLE OpenFileMappingA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpName);

@DllImport("KERNEL32.dll")
int LoadPackagedLibrary(const(wchar)* lpwLibFileName, uint Reserved);

@DllImport("KERNEL32.dll")
BOOL QueryFullProcessImageNameA(HANDLE hProcess, uint dwFlags, const(char)* lpExeName, uint* lpdwSize);

@DllImport("KERNEL32.dll")
BOOL QueryFullProcessImageNameW(HANDLE hProcess, uint dwFlags, const(wchar)* lpExeName, uint* lpdwSize);

@DllImport("KERNEL32.dll")
BOOL SetDllDirectoryA(const(char)* lpPathName);

@DllImport("KERNEL32.dll")
BOOL SetDllDirectoryW(const(wchar)* lpPathName);

@DllImport("KERNEL32.dll")
uint GetDllDirectoryA(uint nBufferLength, const(char)* lpBuffer);

@DllImport("KERNEL32.dll")
uint GetDllDirectoryW(uint nBufferLength, const(wchar)* lpBuffer);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeHandleStateA(HANDLE hNamedPipe, uint* lpState, uint* lpCurInstances, uint* lpMaxCollectionCount, uint* lpCollectDataTimeout, const(char)* lpUserName, uint nMaxUserNameSize);

@DllImport("KERNEL32.dll")
BOOL CallNamedPipeA(const(char)* lpNamedPipeName, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesRead, uint nTimeOut);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeClientComputerNameA(HANDLE Pipe, const(char)* ClientComputerName, uint ClientComputerNameLength);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeClientProcessId(HANDLE Pipe, uint* ClientProcessId);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeClientSessionId(HANDLE Pipe, uint* ClientSessionId);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeServerProcessId(HANDLE Pipe, uint* ServerProcessId);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeServerSessionId(HANDLE Pipe, uint* ServerSessionId);

@DllImport("ADVAPI32.dll")
BOOL ClearEventLogA(HANDLE hEventLog, const(char)* lpBackupFileName);

@DllImport("ADVAPI32.dll")
BOOL ClearEventLogW(HANDLE hEventLog, const(wchar)* lpBackupFileName);

@DllImport("ADVAPI32.dll")
BOOL BackupEventLogA(HANDLE hEventLog, const(char)* lpBackupFileName);

@DllImport("ADVAPI32.dll")
BOOL BackupEventLogW(HANDLE hEventLog, const(wchar)* lpBackupFileName);

@DllImport("ADVAPI32.dll")
BOOL CloseEventLog(HANDLE hEventLog);

@DllImport("ADVAPI32.dll")
BOOL DeregisterEventSource(HANDLE hEventLog);

@DllImport("ADVAPI32.dll")
BOOL NotifyChangeEventLog(HANDLE hEventLog, HANDLE hEvent);

@DllImport("ADVAPI32.dll")
BOOL GetNumberOfEventLogRecords(HANDLE hEventLog, uint* NumberOfRecords);

@DllImport("ADVAPI32.dll")
BOOL GetOldestEventLogRecord(HANDLE hEventLog, uint* OldestRecord);

@DllImport("ADVAPI32.dll")
EventLogHandle OpenEventLogA(const(char)* lpUNCServerName, const(char)* lpSourceName);

@DllImport("ADVAPI32.dll")
EventLogHandle OpenEventLogW(const(wchar)* lpUNCServerName, const(wchar)* lpSourceName);

@DllImport("ADVAPI32.dll")
EventSourceHandle RegisterEventSourceA(const(char)* lpUNCServerName, const(char)* lpSourceName);

@DllImport("ADVAPI32.dll")
HANDLE RegisterEventSourceW(const(wchar)* lpUNCServerName, const(wchar)* lpSourceName);

@DllImport("ADVAPI32.dll")
EventLogHandle OpenBackupEventLogA(const(char)* lpUNCServerName, const(char)* lpFileName);

@DllImport("ADVAPI32.dll")
EventLogHandle OpenBackupEventLogW(const(wchar)* lpUNCServerName, const(wchar)* lpFileName);

@DllImport("ADVAPI32.dll")
BOOL ReadEventLogA(HANDLE hEventLog, uint dwReadFlags, uint dwRecordOffset, char* lpBuffer, uint nNumberOfBytesToRead, uint* pnBytesRead, uint* pnMinNumberOfBytesNeeded);

@DllImport("ADVAPI32.dll")
BOOL ReadEventLogW(HANDLE hEventLog, uint dwReadFlags, uint dwRecordOffset, char* lpBuffer, uint nNumberOfBytesToRead, uint* pnBytesRead, uint* pnMinNumberOfBytesNeeded);

@DllImport("ADVAPI32.dll")
BOOL ReportEventA(HANDLE hEventLog, ushort wType, ushort wCategory, uint dwEventID, void* lpUserSid, ushort wNumStrings, uint dwDataSize, char* lpStrings, char* lpRawData);

@DllImport("ADVAPI32.dll")
BOOL ReportEventW(HANDLE hEventLog, ushort wType, ushort wCategory, uint dwEventID, void* lpUserSid, ushort wNumStrings, uint dwDataSize, char* lpStrings, char* lpRawData);

@DllImport("ADVAPI32.dll")
BOOL GetEventLogInformation(HANDLE hEventLog, uint dwInfoLevel, char* lpBuffer, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("KERNEL32.dll")
void* MapViewOfFileExNuma(HANDLE hFileMappingObject, uint dwDesiredAccess, uint dwFileOffsetHigh, uint dwFileOffsetLow, uint dwNumberOfBytesToMap, void* lpBaseAddress, uint nndPreferred);

@DllImport("KERNEL32.dll")
BOOL IsBadReadPtr(const(void)* lp, uint ucb);

@DllImport("KERNEL32.dll")
BOOL IsBadWritePtr(void* lp, uint ucb);

@DllImport("KERNEL32.dll")
BOOL IsBadCodePtr(FARPROC lpfn);

@DllImport("KERNEL32.dll")
BOOL IsBadStringPtrA(const(char)* lpsz, uint ucchMax);

@DllImport("KERNEL32.dll")
BOOL IsBadStringPtrW(const(wchar)* lpsz, uint ucchMax);

@DllImport("KERNEL32.dll")
BOOL BuildCommDCBA(const(char)* lpDef, DCB* lpDCB);

@DllImport("KERNEL32.dll")
BOOL BuildCommDCBW(const(wchar)* lpDef, DCB* lpDCB);

@DllImport("KERNEL32.dll")
BOOL BuildCommDCBAndTimeoutsA(const(char)* lpDef, DCB* lpDCB, COMMTIMEOUTS* lpCommTimeouts);

@DllImport("KERNEL32.dll")
BOOL BuildCommDCBAndTimeoutsW(const(wchar)* lpDef, DCB* lpDCB, COMMTIMEOUTS* lpCommTimeouts);

@DllImport("KERNEL32.dll")
BOOL CommConfigDialogA(const(char)* lpszName, HWND hWnd, COMMCONFIG* lpCC);

@DllImport("KERNEL32.dll")
BOOL CommConfigDialogW(const(wchar)* lpszName, HWND hWnd, COMMCONFIG* lpCC);

@DllImport("KERNEL32.dll")
BOOL GetDefaultCommConfigA(const(char)* lpszName, char* lpCC, uint* lpdwSize);

@DllImport("KERNEL32.dll")
BOOL GetDefaultCommConfigW(const(wchar)* lpszName, char* lpCC, uint* lpdwSize);

@DllImport("KERNEL32.dll")
BOOL SetDefaultCommConfigA(const(char)* lpszName, char* lpCC, uint dwSize);

@DllImport("KERNEL32.dll")
BOOL SetDefaultCommConfigW(const(wchar)* lpszName, char* lpCC, uint dwSize);

@DllImport("ADVAPI32.dll")
BOOL CreateProcessWithLogonW(const(wchar)* lpUsername, const(wchar)* lpDomain, const(wchar)* lpPassword, uint dwLogonFlags, const(wchar)* lpApplicationName, const(wchar)* lpCommandLine, uint dwCreationFlags, void* lpEnvironment, const(wchar)* lpCurrentDirectory, STARTUPINFOW* lpStartupInfo, PROCESS_INFORMATION* lpProcessInformation);

@DllImport("ADVAPI32.dll")
BOOL CreateProcessWithTokenW(HANDLE hToken, uint dwLogonFlags, const(wchar)* lpApplicationName, const(wchar)* lpCommandLine, uint dwCreationFlags, void* lpEnvironment, const(wchar)* lpCurrentDirectory, STARTUPINFOW* lpStartupInfo, PROCESS_INFORMATION* lpProcessInformation);

@DllImport("KERNEL32.dll")
BOOL RegisterWaitForSingleObject(int* phNewWaitObject, HANDLE hObject, WAITORTIMERCALLBACK Callback, void* Context, uint dwMilliseconds, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL UnregisterWait(HANDLE WaitHandle);

@DllImport("KERNEL32.dll")
BOOL BindIoCompletionCallback(HANDLE FileHandle, LPOVERLAPPED_COMPLETION_ROUTINE Function, uint Flags);

@DllImport("KERNEL32.dll")
BOOL DeleteTimerQueue(HANDLE TimerQueue);

@DllImport("KERNEL32.dll")
BoundaryDescriptorHandle CreateBoundaryDescriptorA(const(char)* Name, uint Flags);

@DllImport("KERNEL32.dll")
BOOL AddIntegrityLabelToBoundaryDescriptor(HANDLE* BoundaryDescriptor, void* IntegrityLabel);

@DllImport("KERNEL32.dll")
BOOL SetSystemPowerState(BOOL fSuspend, BOOL fForce);

@DllImport("KERNEL32.dll")
BOOL GetSystemPowerStatus(SYSTEM_POWER_STATUS* lpSystemPowerStatus);

@DllImport("KERNEL32.dll")
BOOL MapUserPhysicalPagesScatter(char* VirtualAddresses, uint NumberOfPages, char* PageArray);

@DllImport("KERNEL32.dll")
HANDLE CreateJobObjectA(SECURITY_ATTRIBUTES* lpJobAttributes, const(char)* lpName);

@DllImport("KERNEL32.dll")
HANDLE OpenJobObjectA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpName);

@DllImport("KERNEL32.dll")
ushort GetActiveProcessorGroupCount();

@DllImport("KERNEL32.dll")
ushort GetMaximumProcessorGroupCount();

@DllImport("KERNEL32.dll")
uint GetActiveProcessorCount(ushort GroupNumber);

@DllImport("KERNEL32.dll")
uint GetMaximumProcessorCount(ushort GroupNumber);

@DllImport("KERNEL32.dll")
BOOL GetNumaProcessorNode(ubyte Processor, ubyte* NodeNumber);

@DllImport("KERNEL32.dll")
BOOL GetNumaNodeNumberFromHandle(HANDLE hFile, ushort* NodeNumber);

@DllImport("KERNEL32.dll")
BOOL GetNumaProcessorNodeEx(PROCESSOR_NUMBER* Processor, ushort* NodeNumber);

@DllImport("KERNEL32.dll")
BOOL GetNumaNodeProcessorMask(ubyte Node, ulong* ProcessorMask);

@DllImport("KERNEL32.dll")
BOOL GetNumaAvailableMemoryNode(ubyte Node, ulong* AvailableBytes);

@DllImport("KERNEL32.dll")
BOOL GetNumaAvailableMemoryNodeEx(ushort Node, ulong* AvailableBytes);

@DllImport("KERNEL32.dll")
BOOL GetNumaProximityNode(uint ProximityId, ubyte* NodeNumber);

@DllImport("KERNEL32.dll")
BOOL AddSecureMemoryCacheCallback(PSECURE_MEMORY_CACHE_CALLBACK pfnCallBack);

@DllImport("KERNEL32.dll")
BOOL RemoveSecureMemoryCacheCallback(PSECURE_MEMORY_CACHE_CALLBACK pfnCallBack);

@DllImport("ADVAPI32.dll")
BOOL InitiateSystemShutdownA(const(char)* lpMachineName, const(char)* lpMessage, uint dwTimeout, BOOL bForceAppsClosed, BOOL bRebootAfterShutdown);

@DllImport("ADVAPI32.dll")
BOOL InitiateSystemShutdownW(const(wchar)* lpMachineName, const(wchar)* lpMessage, uint dwTimeout, BOOL bForceAppsClosed, BOOL bRebootAfterShutdown);

@DllImport("ADVAPI32.dll")
BOOL AbortSystemShutdownA(const(char)* lpMachineName);

@DllImport("ADVAPI32.dll")
BOOL AbortSystemShutdownW(const(wchar)* lpMachineName);

@DllImport("ADVAPI32.dll")
BOOL InitiateSystemShutdownExA(const(char)* lpMachineName, const(char)* lpMessage, uint dwTimeout, BOOL bForceAppsClosed, BOOL bRebootAfterShutdown, uint dwReason);

@DllImport("ADVAPI32.dll")
BOOL InitiateSystemShutdownExW(const(wchar)* lpMachineName, const(wchar)* lpMessage, uint dwTimeout, BOOL bForceAppsClosed, BOOL bRebootAfterShutdown, uint dwReason);

@DllImport("ADVAPI32.dll")
uint InitiateShutdownA(const(char)* lpMachineName, const(char)* lpMessage, uint dwGracePeriod, uint dwShutdownFlags, uint dwReason);

@DllImport("ADVAPI32.dll")
uint InitiateShutdownW(const(wchar)* lpMachineName, const(wchar)* lpMessage, uint dwGracePeriod, uint dwShutdownFlags, uint dwReason);

@DllImport("ntdll.dll")
NTSTATUS NtQueryInformationProcess(HANDLE ProcessHandle, PROCESSINFOCLASS ProcessInformationClass, void* ProcessInformation, uint ProcessInformationLength, uint* ReturnLength);

@DllImport("ntdll.dll")
NTSTATUS NtQueryInformationThread(HANDLE ThreadHandle, THREADINFOCLASS ThreadInformationClass, void* ThreadInformation, uint ThreadInformationLength, uint* ReturnLength);

alias BOOL = int;
alias BoundaryDescriptorHandle = int;
alias HANDLE = int;
alias HINSTANCE = int;
alias LRESULT = int;
alias LSTATUS = int;
alias NamespaceHandle = int;
alias NTSTATUS = int;
alias PTP_POOL = int;
alias TimerQueueHandle = int;
struct FLOAT128
{
    long LowPart;
    long HighPart;
}

struct LARGE_INTEGER
{
    _Anonymous_e__Struct Anonymous;
    _u_e__Struct u;
    long QuadPart;
}

struct ULARGE_INTEGER
{
    _Anonymous_e__Struct Anonymous;
    _u_e__Struct u;
    ulong QuadPart;
}

struct M128A
{
    ulong Low;
    long High;
}

struct XSAVE_FORMAT
{
    ushort ControlWord;
    ushort StatusWord;
    ubyte TagWord;
    ubyte Reserved1;
    ushort ErrorOpcode;
    uint ErrorOffset;
    ushort ErrorSelector;
    ushort Reserved2;
    uint DataOffset;
    ushort DataSelector;
    ushort Reserved3;
    uint MxCsr;
    uint MxCsr_Mask;
    M128A FloatRegisters;
    M128A XmmRegisters;
    ubyte Reserved4;
}

struct XSAVE_CET_U_FORMAT
{
    ulong Ia32CetUMsr;
    ulong Ia32Pl3SspMsr;
}

struct XSAVE_AREA_HEADER
{
    ulong Mask;
    ulong CompactionMask;
    ulong Reserved2;
}

struct XSAVE_AREA
{
    XSAVE_FORMAT LegacyState;
    XSAVE_AREA_HEADER Header;
}

struct XSTATE_CONTEXT
{
    ulong Mask;
    uint Length;
    uint Reserved1;
    XSAVE_AREA* Area;
    uint Reserved2;
    void* Buffer;
    uint Reserved3;
}

struct SCOPE_TABLE_AMD64
{
    uint Count;
    _Anonymous_e__Struct ScopeRecord;
}

struct SCOPE_TABLE_ARM
{
    uint Count;
    _Anonymous_e__Struct ScopeRecord;
}

struct SCOPE_TABLE_ARM64
{
    uint Count;
    _Anonymous_e__Struct ScopeRecord;
}

struct KNONVOLATILE_CONTEXT_POINTERS_ARM64
{
    ulong* X19;
    ulong* X20;
    ulong* X21;
    ulong* X22;
    ulong* X23;
    ulong* X24;
    ulong* X25;
    ulong* X26;
    ulong* X27;
    ulong* X28;
    ulong* Fp;
    ulong* Lr;
    ulong* D8;
    ulong* D9;
    ulong* D10;
    ulong* D11;
    ulong* D12;
    ulong* D13;
    ulong* D14;
    ulong* D15;
}

struct FLOATING_SAVE_AREA
{
    uint ControlWord;
    uint StatusWord;
    uint TagWord;
    uint ErrorOffset;
    uint ErrorSelector;
    uint DataOffset;
    uint DataSelector;
    ubyte RegisterArea;
    uint Spare0;
}

struct KNONVOLATILE_CONTEXT_POINTERS
{
    uint Dummy;
}

struct WOW64_DESCRIPTOR_TABLE_ENTRY
{
    uint Selector;
    WOW64_LDT_ENTRY Descriptor;
}

struct EXCEPTION_RECORD32
{
    uint ExceptionCode;
    uint ExceptionFlags;
    uint ExceptionRecord;
    uint ExceptionAddress;
    uint NumberParameters;
    uint ExceptionInformation;
}

struct SE_SID
{
    SID Sid;
    ubyte Buffer;
}

struct SYSTEM_PROCESS_TRUST_LABEL_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct SYSTEM_ACCESS_FILTER_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct SECURITY_DESCRIPTOR_RELATIVE
{
    ubyte Revision;
    ubyte Sbz1;
    ushort Control;
    uint Owner;
    uint Group;
    uint Sacl;
    uint Dacl;
}

struct SECURITY_OBJECT_AI_PARAMS
{
    uint Size;
    uint ConstraintMask;
}

enum ACCESS_REASON_TYPE
{
    AccessReasonNone = 0,
    AccessReasonAllowedAce = 65536,
    AccessReasonDeniedAce = 131072,
    AccessReasonAllowedParentAce = 196608,
    AccessReasonDeniedParentAce = 262144,
    AccessReasonNotGrantedByCape = 327680,
    AccessReasonNotGrantedByParentCape = 393216,
    AccessReasonNotGrantedToAppContainer = 458752,
    AccessReasonMissingPrivilege = 1048576,
    AccessReasonFromPrivilege = 2097152,
    AccessReasonIntegrityLevel = 3145728,
    AccessReasonOwnership = 4194304,
    AccessReasonNullDacl = 5242880,
    AccessReasonEmptyDacl = 6291456,
    AccessReasonNoSD = 7340032,
    AccessReasonNoGrant = 8388608,
    AccessReasonTrustLabel = 9437184,
    AccessReasonFilterAce = 10485760,
}

struct ACCESS_REASONS
{
    uint Data;
}

struct SE_SECURITY_DESCRIPTOR
{
    uint Size;
    uint Flags;
    void* SecurityDescriptor;
}

struct SE_ACCESS_REQUEST
{
    uint Size;
    SE_SECURITY_DESCRIPTOR* SeSecurityDescriptor;
    uint DesiredAccess;
    uint PreviouslyGrantedAccess;
    void* PrincipalSelfSid;
    GENERIC_MAPPING* GenericMapping;
    uint ObjectTypeListCount;
    OBJECT_TYPE_LIST* ObjectTypeList;
}

struct SE_ACCESS_REPLY
{
    uint Size;
    uint ResultListCount;
    uint* GrantedAccess;
    uint* AccessStatus;
    ACCESS_REASONS* AccessReason;
    PRIVILEGE_SET** Privileges;
}

struct SE_TOKEN_USER
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct TOKEN_SID_INFORMATION
{
    void* Sid;
}

struct TOKEN_BNO_ISOLATION_INFORMATION
{
    const(wchar)* IsolationPrefix;
    ubyte IsolationEnabled;
}

struct SE_IMPERSONATION_STATE
{
    void* Token;
    ubyte CopyOnOpen;
    ubyte EffectiveOnly;
    SECURITY_IMPERSONATION_LEVEL Level;
}

enum SE_IMAGE_SIGNATURE_TYPE
{
    SeImageSignatureNone = 0,
    SeImageSignatureEmbedded = 1,
    SeImageSignatureCache = 2,
    SeImageSignatureCatalogCached = 3,
    SeImageSignatureCatalogNotCached = 4,
    SeImageSignatureCatalogHint = 5,
    SeImageSignaturePackageCatalog = 6,
}

enum SE_LEARNING_MODE_DATA_TYPE
{
    SeLearningModeInvalidType = 0,
    SeLearningModeSettings = 1,
    SeLearningModeMax = 2,
}

struct JOB_SET_ARRAY
{
    HANDLE JobHandle;
    uint MemberLevel;
    uint Flags;
}

struct EXCEPTION_REGISTRATION_RECORD
{
    EXCEPTION_REGISTRATION_RECORD* Next;
    EXCEPTION_ROUTINE Handler;
}

struct NT_TIB
{
    EXCEPTION_REGISTRATION_RECORD* ExceptionList;
    void* StackBase;
    void* StackLimit;
    void* SubSystemTib;
    _Anonymous_e__Union Anonymous;
    void* ArbitraryUserPointer;
    NT_TIB* Self;
}

struct NT_TIB32
{
    uint ExceptionList;
    uint StackBase;
    uint StackLimit;
    uint SubSystemTib;
    _Anonymous_e__Union Anonymous;
    uint ArbitraryUserPointer;
    uint Self;
}

struct NT_TIB64
{
    ulong ExceptionList;
    ulong StackBase;
    ulong StackLimit;
    ulong SubSystemTib;
    _Anonymous_e__Union Anonymous;
    ulong ArbitraryUserPointer;
    ulong Self;
}

struct UMS_CREATE_THREAD_ATTRIBUTES
{
    uint UmsVersion;
    void* UmsContext;
    void* UmsCompletionList;
}

struct WOW64_ARCHITECTURE_INFORMATION
{
    uint _bitfield;
}

struct PROCESS_DYNAMIC_EH_CONTINUATION_TARGET
{
    uint TargetAddress;
    uint Flags;
}

struct PROCESS_DYNAMIC_EH_CONTINUATION_TARGETS_INFORMATION
{
    ushort NumberOfTargets;
    ushort Reserved;
    uint Reserved2;
    PROCESS_DYNAMIC_EH_CONTINUATION_TARGET* Targets;
}

struct RATE_QUOTA_LIMIT
{
    uint RateData;
    _Anonymous_e__Struct Anonymous;
}

struct QUOTA_LIMITS_EX
{
    uint PagedPoolLimit;
    uint NonPagedPoolLimit;
    uint MinimumWorkingSetSize;
    uint MaximumWorkingSetSize;
    uint PagefileLimit;
    LARGE_INTEGER TimeLimit;
    uint WorkingSetLimit;
    uint Reserved2;
    uint Reserved3;
    uint Reserved4;
    uint Flags;
    RATE_QUOTA_LIMIT CpuRateLimit;
}

struct IO_COUNTERS
{
    ulong ReadOperationCount;
    ulong WriteOperationCount;
    ulong OtherOperationCount;
    ulong ReadTransferCount;
    ulong WriteTransferCount;
    ulong OtherTransferCount;
}

enum PROCESS_MITIGATION_POLICY
{
    ProcessDEPPolicy = 0,
    ProcessASLRPolicy = 1,
    ProcessDynamicCodePolicy = 2,
    ProcessStrictHandleCheckPolicy = 3,
    ProcessSystemCallDisablePolicy = 4,
    ProcessMitigationOptionsMask = 5,
    ProcessExtensionPointDisablePolicy = 6,
    ProcessControlFlowGuardPolicy = 7,
    ProcessSignaturePolicy = 8,
    ProcessFontDisablePolicy = 9,
    ProcessImageLoadPolicy = 10,
    ProcessSystemCallFilterPolicy = 11,
    ProcessPayloadRestrictionPolicy = 12,
    ProcessChildProcessPolicy = 13,
    ProcessSideChannelIsolationPolicy = 14,
    ProcessUserShadowStackPolicy = 15,
    MaxProcessMitigationPolicy = 16,
}

struct PROCESS_MITIGATION_ASLR_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_DEP_POLICY
{
    _Anonymous_e__Union Anonymous;
    ubyte Permanent;
}

struct PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_DYNAMIC_CODE_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_CONTROL_FLOW_GUARD_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_BINARY_SIGNATURE_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_FONT_DISABLE_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_IMAGE_LOAD_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_SYSTEM_CALL_FILTER_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_PAYLOAD_RESTRICTION_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_CHILD_PROCESS_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_SIDE_CHANNEL_ISOLATION_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct PROCESS_MITIGATION_USER_SHADOW_STACK_POLICY
{
    _Anonymous_e__Union Anonymous;
}

struct JOBOBJECT_BASIC_ACCOUNTING_INFORMATION
{
    LARGE_INTEGER TotalUserTime;
    LARGE_INTEGER TotalKernelTime;
    LARGE_INTEGER ThisPeriodTotalUserTime;
    LARGE_INTEGER ThisPeriodTotalKernelTime;
    uint TotalPageFaultCount;
    uint TotalProcesses;
    uint ActiveProcesses;
    uint TotalTerminatedProcesses;
}

struct JOBOBJECT_BASIC_LIMIT_INFORMATION
{
    LARGE_INTEGER PerProcessUserTimeLimit;
    LARGE_INTEGER PerJobUserTimeLimit;
    uint LimitFlags;
    uint MinimumWorkingSetSize;
    uint MaximumWorkingSetSize;
    uint ActiveProcessLimit;
    uint Affinity;
    uint PriorityClass;
    uint SchedulingClass;
}

struct JOBOBJECT_EXTENDED_LIMIT_INFORMATION
{
    JOBOBJECT_BASIC_LIMIT_INFORMATION BasicLimitInformation;
    IO_COUNTERS IoInfo;
    uint ProcessMemoryLimit;
    uint JobMemoryLimit;
    uint PeakProcessMemoryUsed;
    uint PeakJobMemoryUsed;
}

struct JOBOBJECT_BASIC_PROCESS_ID_LIST
{
    uint NumberOfAssignedProcesses;
    uint NumberOfProcessIdsInList;
    uint ProcessIdList;
}

struct JOBOBJECT_BASIC_UI_RESTRICTIONS
{
    uint UIRestrictionsClass;
}

struct JOBOBJECT_SECURITY_LIMIT_INFORMATION
{
    uint SecurityLimitFlags;
    HANDLE JobToken;
    TOKEN_GROUPS* SidsToDisable;
    TOKEN_PRIVILEGES* PrivilegesToDelete;
    TOKEN_GROUPS* RestrictedSids;
}

struct JOBOBJECT_END_OF_JOB_TIME_INFORMATION
{
    uint EndOfJobTimeAction;
}

struct JOBOBJECT_ASSOCIATE_COMPLETION_PORT
{
    void* CompletionKey;
    HANDLE CompletionPort;
}

struct JOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION
{
    JOBOBJECT_BASIC_ACCOUNTING_INFORMATION BasicInfo;
    IO_COUNTERS IoInfo;
}

struct JOBOBJECT_JOBSET_INFORMATION
{
    uint MemberLevel;
}

enum JOBOBJECT_RATE_CONTROL_TOLERANCE
{
    ToleranceLow = 1,
    ToleranceMedium = 2,
    ToleranceHigh = 3,
}

enum JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL
{
    ToleranceIntervalShort = 1,
    ToleranceIntervalMedium = 2,
    ToleranceIntervalLong = 3,
}

struct JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION
{
    ulong IoReadBytesLimit;
    ulong IoWriteBytesLimit;
    LARGE_INTEGER PerJobUserTimeLimit;
    ulong JobMemoryLimit;
    JOBOBJECT_RATE_CONTROL_TOLERANCE RateControlTolerance;
    JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL RateControlToleranceInterval;
    uint LimitFlags;
}

struct JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION_2
{
    ulong IoReadBytesLimit;
    ulong IoWriteBytesLimit;
    LARGE_INTEGER PerJobUserTimeLimit;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    uint LimitFlags;
    JOBOBJECT_RATE_CONTROL_TOLERANCE IoRateControlTolerance;
    ulong JobLowMemoryLimit;
    JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL IoRateControlToleranceInterval;
    JOBOBJECT_RATE_CONTROL_TOLERANCE NetRateControlTolerance;
    JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL NetRateControlToleranceInterval;
}

struct JOBOBJECT_LIMIT_VIOLATION_INFORMATION
{
    uint LimitFlags;
    uint ViolationLimitFlags;
    ulong IoReadBytes;
    ulong IoReadBytesLimit;
    ulong IoWriteBytes;
    ulong IoWriteBytesLimit;
    LARGE_INTEGER PerJobUserTime;
    LARGE_INTEGER PerJobUserTimeLimit;
    ulong JobMemory;
    ulong JobMemoryLimit;
    JOBOBJECT_RATE_CONTROL_TOLERANCE RateControlTolerance;
    JOBOBJECT_RATE_CONTROL_TOLERANCE RateControlToleranceLimit;
}

struct JOBOBJECT_LIMIT_VIOLATION_INFORMATION_2
{
    uint LimitFlags;
    uint ViolationLimitFlags;
    ulong IoReadBytes;
    ulong IoReadBytesLimit;
    ulong IoWriteBytes;
    ulong IoWriteBytesLimit;
    LARGE_INTEGER PerJobUserTime;
    LARGE_INTEGER PerJobUserTimeLimit;
    ulong JobMemory;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    ulong JobLowMemoryLimit;
    JOBOBJECT_RATE_CONTROL_TOLERANCE IoRateControlTolerance;
    JOBOBJECT_RATE_CONTROL_TOLERANCE IoRateControlToleranceLimit;
    JOBOBJECT_RATE_CONTROL_TOLERANCE NetRateControlTolerance;
    JOBOBJECT_RATE_CONTROL_TOLERANCE NetRateControlToleranceLimit;
}

struct JOBOBJECT_CPU_RATE_CONTROL_INFORMATION
{
    uint ControlFlags;
    _Anonymous_e__Union Anonymous;
}

enum JOB_OBJECT_NET_RATE_CONTROL_FLAGS
{
    JOB_OBJECT_NET_RATE_CONTROL_ENABLE = 1,
    JOB_OBJECT_NET_RATE_CONTROL_MAX_BANDWIDTH = 2,
    JOB_OBJECT_NET_RATE_CONTROL_DSCP_TAG = 4,
    JOB_OBJECT_NET_RATE_CONTROL_VALID_FLAGS = 7,
}

struct JOBOBJECT_NET_RATE_CONTROL_INFORMATION
{
    ulong MaxBandwidth;
    JOB_OBJECT_NET_RATE_CONTROL_FLAGS ControlFlags;
    ubyte DscpTag;
}

enum JOB_OBJECT_IO_RATE_CONTROL_FLAGS
{
    JOB_OBJECT_IO_RATE_CONTROL_ENABLE = 1,
    JOB_OBJECT_IO_RATE_CONTROL_STANDALONE_VOLUME = 2,
    JOB_OBJECT_IO_RATE_CONTROL_FORCE_UNIT_ACCESS_ALL = 4,
    JOB_OBJECT_IO_RATE_CONTROL_FORCE_UNIT_ACCESS_ON_SOFT_CAP = 8,
    JOB_OBJECT_IO_RATE_CONTROL_VALID_FLAGS = 15,
}

struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION_NATIVE
{
    long MaxIops;
    long MaxBandwidth;
    long ReservationIops;
    const(wchar)* VolumeName;
    uint BaseIoSize;
    JOB_OBJECT_IO_RATE_CONTROL_FLAGS ControlFlags;
    ushort VolumeNameLength;
}

struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION_NATIVE_V2
{
    long MaxIops;
    long MaxBandwidth;
    long ReservationIops;
    const(wchar)* VolumeName;
    uint BaseIoSize;
    JOB_OBJECT_IO_RATE_CONTROL_FLAGS ControlFlags;
    ushort VolumeNameLength;
    long CriticalReservationIops;
    long ReservationBandwidth;
    long CriticalReservationBandwidth;
    long MaxTimePercent;
    long ReservationTimePercent;
    long CriticalReservationTimePercent;
}

struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION_NATIVE_V3
{
    long MaxIops;
    long MaxBandwidth;
    long ReservationIops;
    const(wchar)* VolumeName;
    uint BaseIoSize;
    JOB_OBJECT_IO_RATE_CONTROL_FLAGS ControlFlags;
    ushort VolumeNameLength;
    long CriticalReservationIops;
    long ReservationBandwidth;
    long CriticalReservationBandwidth;
    long MaxTimePercent;
    long ReservationTimePercent;
    long CriticalReservationTimePercent;
    long SoftMaxIops;
    long SoftMaxBandwidth;
    long SoftMaxTimePercent;
    long LimitExcessNotifyIops;
    long LimitExcessNotifyBandwidth;
    long LimitExcessNotifyTimePercent;
}

enum JOBOBJECT_IO_ATTRIBUTION_CONTROL_FLAGS
{
    JOBOBJECT_IO_ATTRIBUTION_CONTROL_ENABLE = 1,
    JOBOBJECT_IO_ATTRIBUTION_CONTROL_DISABLE = 2,
    JOBOBJECT_IO_ATTRIBUTION_CONTROL_VALID_FLAGS = 3,
}

struct JOBOBJECT_IO_ATTRIBUTION_STATS
{
    uint IoCount;
    ulong TotalNonOverlappedQueueTime;
    ulong TotalNonOverlappedServiceTime;
    ulong TotalSize;
}

struct JOBOBJECT_IO_ATTRIBUTION_INFORMATION
{
    uint ControlFlags;
    JOBOBJECT_IO_ATTRIBUTION_STATS ReadStats;
    JOBOBJECT_IO_ATTRIBUTION_STATS WriteStats;
}

enum JOBOBJECTINFOCLASS
{
    JobObjectBasicAccountingInformation = 1,
    JobObjectBasicLimitInformation = 2,
    JobObjectBasicProcessIdList = 3,
    JobObjectBasicUIRestrictions = 4,
    JobObjectSecurityLimitInformation = 5,
    JobObjectEndOfJobTimeInformation = 6,
    JobObjectAssociateCompletionPortInformation = 7,
    JobObjectBasicAndIoAccountingInformation = 8,
    JobObjectExtendedLimitInformation = 9,
    JobObjectJobSetInformation = 10,
    JobObjectGroupInformation = 11,
    JobObjectNotificationLimitInformation = 12,
    JobObjectLimitViolationInformation = 13,
    JobObjectGroupInformationEx = 14,
    JobObjectCpuRateControlInformation = 15,
    JobObjectCompletionFilter = 16,
    JobObjectCompletionCounter = 17,
    JobObjectReserved1Information = 18,
    JobObjectReserved2Information = 19,
    JobObjectReserved3Information = 20,
    JobObjectReserved4Information = 21,
    JobObjectReserved5Information = 22,
    JobObjectReserved6Information = 23,
    JobObjectReserved7Information = 24,
    JobObjectReserved8Information = 25,
    JobObjectReserved9Information = 26,
    JobObjectReserved10Information = 27,
    JobObjectReserved11Information = 28,
    JobObjectReserved12Information = 29,
    JobObjectReserved13Information = 30,
    JobObjectReserved14Information = 31,
    JobObjectNetRateControlInformation = 32,
    JobObjectNotificationLimitInformation2 = 33,
    JobObjectLimitViolationInformation2 = 34,
    JobObjectCreateSilo = 35,
    JobObjectSiloBasicInformation = 36,
    JobObjectReserved15Information = 37,
    JobObjectReserved16Information = 38,
    JobObjectReserved17Information = 39,
    JobObjectReserved18Information = 40,
    JobObjectReserved19Information = 41,
    JobObjectReserved20Information = 42,
    JobObjectReserved21Information = 43,
    JobObjectReserved22Information = 44,
    JobObjectReserved23Information = 45,
    JobObjectReserved24Information = 46,
    JobObjectReserved25Information = 47,
    MaxJobObjectInfoClass = 48,
}

struct SILOOBJECT_BASIC_INFORMATION
{
    uint SiloId;
    uint SiloParentId;
    uint NumberOfProcesses;
    ubyte IsInServerSilo;
    ubyte Reserved;
}

enum SERVERSILO_STATE
{
    SERVERSILO_INITING = 0,
    SERVERSILO_STARTED = 1,
    SERVERSILO_SHUTTING_DOWN = 2,
    SERVERSILO_TERMINATING = 3,
    SERVERSILO_TERMINATED = 4,
}

struct SERVERSILO_BASIC_INFORMATION
{
    uint ServiceSessionId;
    SERVERSILO_STATE State;
    uint ExitStatus;
    ubyte IsDownlevelContainer;
    void* ApiSetSchema;
    void* HostApiSetSchema;
}

enum LOGICAL_PROCESSOR_RELATIONSHIP
{
    RelationProcessorCore = 0,
    RelationNumaNode = 1,
    RelationCache = 2,
    RelationProcessorPackage = 3,
    RelationGroup = 4,
    RelationAll = 65535,
}

enum PROCESSOR_CACHE_TYPE
{
    CacheUnified = 0,
    CacheInstruction = 1,
    CacheData = 2,
    CacheTrace = 3,
}

struct CACHE_DESCRIPTOR
{
    ubyte Level;
    ubyte Associativity;
    ushort LineSize;
    uint Size;
    PROCESSOR_CACHE_TYPE Type;
}

struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION
{
    uint ProcessorMask;
    LOGICAL_PROCESSOR_RELATIONSHIP Relationship;
    _Anonymous_e__Union Anonymous;
}

struct PROCESSOR_RELATIONSHIP
{
    ubyte Flags;
    ubyte EfficiencyClass;
    ubyte Reserved;
    ushort GroupCount;
    GROUP_AFFINITY GroupMask;
}

struct NUMA_NODE_RELATIONSHIP
{
    uint NodeNumber;
    ubyte Reserved;
    GROUP_AFFINITY GroupMask;
}

struct CACHE_RELATIONSHIP
{
    ubyte Level;
    ubyte Associativity;
    ushort LineSize;
    uint CacheSize;
    PROCESSOR_CACHE_TYPE Type;
    ubyte Reserved;
    GROUP_AFFINITY GroupMask;
}

struct PROCESSOR_GROUP_INFO
{
    ubyte MaximumProcessorCount;
    ubyte ActiveProcessorCount;
    ubyte Reserved;
    uint ActiveProcessorMask;
}

struct GROUP_RELATIONSHIP
{
    ushort MaximumGroupCount;
    ushort ActiveGroupCount;
    ubyte Reserved;
    PROCESSOR_GROUP_INFO GroupInfo;
}

struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX
{
    LOGICAL_PROCESSOR_RELATIONSHIP Relationship;
    uint Size;
    _Anonymous_e__Union Anonymous;
}

enum CPU_SET_INFORMATION_TYPE
{
    CpuSetInformation = 0,
}

struct SYSTEM_CPU_SET_INFORMATION
{
    uint Size;
    CPU_SET_INFORMATION_TYPE Type;
    _Anonymous_e__Union Anonymous;
}

struct SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION
{
    ulong CycleTime;
}

struct XSTATE_FEATURE
{
    uint Offset;
    uint Size;
}

struct XSTATE_CONFIGURATION
{
    ulong EnabledFeatures;
    ulong EnabledVolatileFeatures;
    uint Size;
    _Anonymous_e__Union Anonymous;
    XSTATE_FEATURE Features;
    ulong EnabledSupervisorFeatures;
    ulong AlignedFeatures;
    uint AllFeatureSize;
    uint AllFeatures;
    ulong EnabledUserVisibleSupervisorFeatures;
}

struct MEMORY_BASIC_INFORMATION
{
    void* BaseAddress;
    void* AllocationBase;
    uint AllocationProtect;
    uint RegionSize;
    uint State;
    uint Protect;
    uint Type;
}

struct MEMORY_BASIC_INFORMATION32
{
    uint BaseAddress;
    uint AllocationBase;
    uint AllocationProtect;
    uint RegionSize;
    uint State;
    uint Protect;
    uint Type;
}

struct MEMORY_BASIC_INFORMATION64
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

struct CFG_CALL_TARGET_INFO
{
    uint Offset;
    uint Flags;
}

struct MEM_ADDRESS_REQUIREMENTS
{
    void* LowestStartingAddress;
    void* HighestEndingAddress;
    uint Alignment;
}

enum MEM_EXTENDED_PARAMETER_TYPE
{
    MemExtendedParameterInvalidType = 0,
    MemExtendedParameterAddressRequirements = 1,
    MemExtendedParameterNumaNode = 2,
    MemExtendedParameterPartitionHandle = 3,
    MemExtendedParameterUserPhysicalHandle = 4,
    MemExtendedParameterAttributeFlags = 5,
    MemExtendedParameterMax = 6,
}

struct MEM_EXTENDED_PARAMETER
{
    _Anonymous1_e__Struct Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

enum MEM_SECTION_EXTENDED_PARAMETER_TYPE
{
    MemSectionExtendedParameterInvalidType = 0,
    MemSectionExtendedParameterUserPhysicalFlags = 1,
    MemSectionExtendedParameterNumaNode = 2,
    MemSectionExtendedParameterMax = 3,
}

struct ENCLAVE_CREATE_INFO_SGX
{
    ubyte Secs;
}

struct ENCLAVE_INIT_INFO_SGX
{
    ubyte SigStruct;
    ubyte Reserved1;
    ubyte EInitToken;
    ubyte Reserved2;
}

struct ENCLAVE_CREATE_INFO_VBS
{
    uint Flags;
    ubyte OwnerID;
}

struct ENCLAVE_CREATE_INFO_VBS_BASIC
{
    uint Flags;
    ubyte OwnerID;
}

struct ENCLAVE_LOAD_DATA_VBS_BASIC
{
    uint PageType;
}

struct ENCLAVE_INIT_INFO_VBS_BASIC
{
    ubyte FamilyId;
    ubyte ImageId;
    ulong EnclaveSize;
    uint EnclaveSvn;
    uint Reserved;
    _Anonymous_e__Union Anonymous;
}

struct ENCLAVE_INIT_INFO_VBS
{
    uint Length;
    uint ThreadCount;
}

alias ENCLAVE_TARGET_FUNCTION = extern(Windows) void* function(void* param0);
alias PENCLAVE_TARGET_FUNCTION = extern(Windows) void* function();
alias LPENCLAVE_TARGET_FUNCTION = extern(Windows) void* function();
struct FILE_SEGMENT_ELEMENT
{
    void* Buffer;
    ulong Alignment;
}

struct SCRUB_DATA_INPUT
{
    uint Size;
    uint Flags;
    uint MaximumIos;
    uint ObjectId;
    uint Reserved;
    ubyte ResumeContext;
}

struct SCRUB_PARITY_EXTENT
{
    long Offset;
    ulong Length;
}

struct SCRUB_PARITY_EXTENT_DATA
{
    ushort Size;
    ushort Flags;
    ushort NumberOfParityExtents;
    ushort MaximumNumberOfParityExtents;
    SCRUB_PARITY_EXTENT ParityExtents;
}

struct SCRUB_DATA_OUTPUT
{
    uint Size;
    uint Flags;
    uint Status;
    ulong ErrorFileOffset;
    ulong ErrorLength;
    ulong NumberOfBytesRepaired;
    ulong NumberOfBytesFailed;
    ulong InternalFileReference;
    ushort ResumeContextLength;
    ushort ParityExtentDataOffset;
    uint Reserved;
    ulong NumberOfMetadataBytesProcessed;
    ulong NumberOfDataBytesProcessed;
    ulong TotalNumberOfMetadataBytesInUse;
    ulong TotalNumberOfDataBytesInUse;
    ubyte ResumeContext;
}

enum SharedVirtualDiskSupportType
{
    SharedVirtualDisksUnsupported = 0,
    SharedVirtualDisksSupported = 1,
    SharedVirtualDiskSnapshotsSupported = 3,
    SharedVirtualDiskCDPSnapshotsSupported = 7,
}

enum SharedVirtualDiskHandleState
{
    SharedVirtualDiskHandleStateNone = 0,
    SharedVirtualDiskHandleStateFileShared = 1,
    SharedVirtualDiskHandleStateHandleShared = 3,
}

struct SHARED_VIRTUAL_DISK_SUPPORT
{
    SharedVirtualDiskSupportType SharedVirtualDiskSupport;
    SharedVirtualDiskHandleState HandleState;
}

struct REARRANGE_FILE_DATA
{
    ulong SourceStartingOffset;
    ulong TargetOffset;
    HANDLE SourceFileHandle;
    uint Length;
    uint Flags;
}

struct SHUFFLE_FILE_DATA
{
    long StartingOffset;
    long Length;
    uint Flags;
}

struct NETWORK_APP_INSTANCE_EA
{
    Guid AppInstanceID;
    uint CsvFlags;
}

enum SYSTEM_POWER_STATE
{
    PowerSystemUnspecified = 0,
    PowerSystemWorking = 1,
    PowerSystemSleeping1 = 2,
    PowerSystemSleeping2 = 3,
    PowerSystemSleeping3 = 4,
    PowerSystemHibernate = 5,
    PowerSystemShutdown = 6,
    PowerSystemMaximum = 7,
}

enum POWER_ACTION
{
    PowerActionNone = 0,
    PowerActionReserved = 1,
    PowerActionSleep = 2,
    PowerActionHibernate = 3,
    PowerActionShutdown = 4,
    PowerActionShutdownReset = 5,
    PowerActionShutdownOff = 6,
    PowerActionWarmEject = 7,
    PowerActionDisplayOff = 8,
}

enum DEVICE_POWER_STATE
{
    PowerDeviceUnspecified = 0,
    PowerDeviceD0 = 1,
    PowerDeviceD1 = 2,
    PowerDeviceD2 = 3,
    PowerDeviceD3 = 4,
    PowerDeviceMaximum = 5,
}

enum MONITOR_DISPLAY_STATE
{
    PowerMonitorOff = 0,
    PowerMonitorOn = 1,
    PowerMonitorDim = 2,
}

enum USER_ACTIVITY_PRESENCE
{
    PowerUserPresent = 0,
    PowerUserNotPresent = 1,
    PowerUserInactive = 2,
    PowerUserMaximum = 3,
    PowerUserInvalid = 3,
}

enum LATENCY_TIME
{
    LT_DONT_CARE = 0,
    LT_LOWEST_LATENCY = 1,
}

enum POWER_REQUEST_TYPE
{
    PowerRequestDisplayRequired = 0,
    PowerRequestSystemRequired = 1,
    PowerRequestAwayModeRequired = 2,
    PowerRequestExecutionRequired = 3,
}

struct CM_Power_Data_s
{
    uint PD_Size;
    DEVICE_POWER_STATE PD_MostRecentPowerState;
    uint PD_Capabilities;
    uint PD_D1Latency;
    uint PD_D2Latency;
    uint PD_D3Latency;
    DEVICE_POWER_STATE PD_PowerStateMapping;
    SYSTEM_POWER_STATE PD_DeepestSystemWake;
}

enum POWER_INFORMATION_LEVEL
{
    SystemPowerPolicyAc = 0,
    SystemPowerPolicyDc = 1,
    VerifySystemPolicyAc = 2,
    VerifySystemPolicyDc = 3,
    SystemPowerCapabilities = 4,
    SystemBatteryState = 5,
    SystemPowerStateHandler = 6,
    ProcessorStateHandler = 7,
    SystemPowerPolicyCurrent = 8,
    AdministratorPowerPolicy = 9,
    SystemReserveHiberFile = 10,
    ProcessorInformation = 11,
    SystemPowerInformation = 12,
    ProcessorStateHandler2 = 13,
    LastWakeTime = 14,
    LastSleepTime = 15,
    SystemExecutionState = 16,
    SystemPowerStateNotifyHandler = 17,
    ProcessorPowerPolicyAc = 18,
    ProcessorPowerPolicyDc = 19,
    VerifyProcessorPowerPolicyAc = 20,
    VerifyProcessorPowerPolicyDc = 21,
    ProcessorPowerPolicyCurrent = 22,
    SystemPowerStateLogging = 23,
    SystemPowerLoggingEntry = 24,
    SetPowerSettingValue = 25,
    NotifyUserPowerSetting = 26,
    PowerInformationLevelUnused0 = 27,
    SystemMonitorHiberBootPowerOff = 28,
    SystemVideoState = 29,
    TraceApplicationPowerMessage = 30,
    TraceApplicationPowerMessageEnd = 31,
    ProcessorPerfStates = 32,
    ProcessorIdleStates = 33,
    ProcessorCap = 34,
    SystemWakeSource = 35,
    SystemHiberFileInformation = 36,
    TraceServicePowerMessage = 37,
    ProcessorLoad = 38,
    PowerShutdownNotification = 39,
    MonitorCapabilities = 40,
    SessionPowerInit = 41,
    SessionDisplayState = 42,
    PowerRequestCreate = 43,
    PowerRequestAction = 44,
    GetPowerRequestList = 45,
    ProcessorInformationEx = 46,
    NotifyUserModeLegacyPowerEvent = 47,
    GroupPark = 48,
    ProcessorIdleDomains = 49,
    WakeTimerList = 50,
    SystemHiberFileSize = 51,
    ProcessorIdleStatesHv = 52,
    ProcessorPerfStatesHv = 53,
    ProcessorPerfCapHv = 54,
    ProcessorSetIdle = 55,
    LogicalProcessorIdling = 56,
    UserPresence = 57,
    PowerSettingNotificationName = 58,
    GetPowerSettingValue = 59,
    IdleResiliency = 60,
    SessionRITState = 61,
    SessionConnectNotification = 62,
    SessionPowerCleanup = 63,
    SessionLockState = 64,
    SystemHiberbootState = 65,
    PlatformInformation = 66,
    PdcInvocation = 67,
    MonitorInvocation = 68,
    FirmwareTableInformationRegistered = 69,
    SetShutdownSelectedTime = 70,
    SuspendResumeInvocation = 71,
    PlmPowerRequestCreate = 72,
    ScreenOff = 73,
    CsDeviceNotification = 74,
    PlatformRole = 75,
    LastResumePerformance = 76,
    DisplayBurst = 77,
    ExitLatencySamplingPercentage = 78,
    RegisterSpmPowerSettings = 79,
    PlatformIdleStates = 80,
    ProcessorIdleVeto = 81,
    PlatformIdleVeto = 82,
    SystemBatteryStatePrecise = 83,
    ThermalEvent = 84,
    PowerRequestActionInternal = 85,
    BatteryDeviceState = 86,
    PowerInformationInternal = 87,
    ThermalStandby = 88,
    SystemHiberFileType = 89,
    PhysicalPowerButtonPress = 90,
    QueryPotentialDripsConstraint = 91,
    EnergyTrackerCreate = 92,
    EnergyTrackerQuery = 93,
    UpdateBlackBoxRecorder = 94,
    SessionAllowExternalDmaDevices = 95,
    PowerInformationLevelMaximum = 96,
}

enum POWER_USER_PRESENCE_TYPE
{
    UserNotPresent = 0,
    UserPresent = 1,
    UserUnknown = 255,
}

struct POWER_USER_PRESENCE
{
    POWER_USER_PRESENCE_TYPE UserPresence;
}

struct POWER_SESSION_CONNECT
{
    ubyte Connected;
    ubyte Console;
}

struct POWER_SESSION_TIMEOUTS
{
    uint InputTimeout;
    uint DisplayTimeout;
}

struct POWER_SESSION_RIT_STATE
{
    ubyte Active;
    uint LastInputTime;
}

struct POWER_SESSION_WINLOGON
{
    uint SessionId;
    ubyte Console;
    ubyte Locked;
}

struct POWER_SESSION_ALLOW_EXTERNAL_DMA_DEVICES
{
    ubyte IsAllowed;
}

struct POWER_IDLE_RESILIENCY
{
    uint CoalescingTimeout;
    uint IdleResiliencyPeriod;
}

enum POWER_MONITOR_REQUEST_REASON
{
    MonitorRequestReasonUnknown = 0,
    MonitorRequestReasonPowerButton = 1,
    MonitorRequestReasonRemoteConnection = 2,
    MonitorRequestReasonScMonitorpower = 3,
    MonitorRequestReasonUserInput = 4,
    MonitorRequestReasonAcDcDisplayBurst = 5,
    MonitorRequestReasonUserDisplayBurst = 6,
    MonitorRequestReasonPoSetSystemState = 7,
    MonitorRequestReasonSetThreadExecutionState = 8,
    MonitorRequestReasonFullWake = 9,
    MonitorRequestReasonSessionUnlock = 10,
    MonitorRequestReasonScreenOffRequest = 11,
    MonitorRequestReasonIdleTimeout = 12,
    MonitorRequestReasonPolicyChange = 13,
    MonitorRequestReasonSleepButton = 14,
    MonitorRequestReasonLid = 15,
    MonitorRequestReasonBatteryCountChange = 16,
    MonitorRequestReasonGracePeriod = 17,
    MonitorRequestReasonPnP = 18,
    MonitorRequestReasonDP = 19,
    MonitorRequestReasonSxTransition = 20,
    MonitorRequestReasonSystemIdle = 21,
    MonitorRequestReasonNearProximity = 22,
    MonitorRequestReasonThermalStandby = 23,
    MonitorRequestReasonResumePdc = 24,
    MonitorRequestReasonResumeS4 = 25,
    MonitorRequestReasonTerminal = 26,
    MonitorRequestReasonPdcSignal = 27,
    MonitorRequestReasonAcDcDisplayBurstSuppressed = 28,
    MonitorRequestReasonSystemStateEntered = 29,
    MonitorRequestReasonWinrt = 30,
    MonitorRequestReasonUserInputKeyboard = 31,
    MonitorRequestReasonUserInputMouse = 32,
    MonitorRequestReasonUserInputTouch = 33,
    MonitorRequestReasonUserInputPen = 34,
    MonitorRequestReasonUserInputAccelerometer = 35,
    MonitorRequestReasonUserInputHid = 36,
    MonitorRequestReasonUserInputPoUserPresent = 37,
    MonitorRequestReasonUserInputSessionSwitch = 38,
    MonitorRequestReasonUserInputInitialization = 39,
    MonitorRequestReasonPdcSignalWindowsMobilePwrNotif = 40,
    MonitorRequestReasonPdcSignalWindowsMobileShell = 41,
    MonitorRequestReasonPdcSignalHeyCortana = 42,
    MonitorRequestReasonPdcSignalHolographicShell = 43,
    MonitorRequestReasonPdcSignalFingerprint = 44,
    MonitorRequestReasonDirectedDrips = 45,
    MonitorRequestReasonDim = 46,
    MonitorRequestReasonBuiltinPanel = 47,
    MonitorRequestReasonDisplayRequiredUnDim = 48,
    MonitorRequestReasonBatteryCountChangeSuppressed = 49,
    MonitorRequestReasonResumeModernStandby = 50,
    MonitorRequestReasonMax = 51,
}

enum POWER_MONITOR_REQUEST_TYPE
{
    MonitorRequestTypeOff = 0,
    MonitorRequestTypeOnAndPresent = 1,
    MonitorRequestTypeToggleOn = 2,
}

struct POWER_MONITOR_INVOCATION
{
    ubyte Console;
    POWER_MONITOR_REQUEST_REASON RequestReason;
}

struct RESUME_PERFORMANCE
{
    uint PostTimeMs;
    ulong TotalResumeTimeMs;
    ulong ResumeCompleteTimestamp;
}

enum SYSTEM_POWER_CONDITION
{
    PoAc = 0,
    PoDc = 1,
    PoHot = 2,
    PoConditionMaximum = 3,
}

struct SET_POWER_SETTING_VALUE
{
    uint Version;
    Guid Guid;
    SYSTEM_POWER_CONDITION PowerCondition;
    uint DataLength;
    ubyte Data;
}

struct NOTIFY_USER_POWER_SETTING
{
    Guid Guid;
}

struct APPLICATIONLAUNCH_SETTING_VALUE
{
    LARGE_INTEGER ActivationTime;
    uint Flags;
    uint ButtonInstanceID;
}

enum POWER_PLATFORM_ROLE
{
    PlatformRoleUnspecified = 0,
    PlatformRoleDesktop = 1,
    PlatformRoleMobile = 2,
    PlatformRoleWorkstation = 3,
    PlatformRoleEnterpriseServer = 4,
    PlatformRoleSOHOServer = 5,
    PlatformRoleAppliancePC = 6,
    PlatformRolePerformanceServer = 7,
    PlatformRoleSlate = 8,
    PlatformRoleMaximum = 9,
}

struct POWER_PLATFORM_INFORMATION
{
    ubyte AoAc;
}

struct BATTERY_REPORTING_SCALE
{
    uint Granularity;
    uint Capacity;
}

struct PPM_WMI_LEGACY_PERFSTATE
{
    uint Frequency;
    uint Flags;
    uint PercentFrequency;
}

struct PPM_WMI_IDLE_STATE
{
    uint Latency;
    uint Power;
    uint TimeCheck;
    ubyte PromotePercent;
    ubyte DemotePercent;
    ubyte StateType;
    ubyte Reserved;
    uint StateFlags;
    uint Context;
    uint IdleHandler;
    uint Reserved1;
}

struct PPM_WMI_IDLE_STATES
{
    uint Type;
    uint Count;
    uint TargetState;
    uint OldState;
    ulong TargetProcessors;
    PPM_WMI_IDLE_STATE State;
}

struct PPM_WMI_IDLE_STATES_EX
{
    uint Type;
    uint Count;
    uint TargetState;
    uint OldState;
    void* TargetProcessors;
    PPM_WMI_IDLE_STATE State;
}

struct PPM_WMI_PERF_STATE
{
    uint Frequency;
    uint Power;
    ubyte PercentFrequency;
    ubyte IncreaseLevel;
    ubyte DecreaseLevel;
    ubyte Type;
    uint IncreaseTime;
    uint DecreaseTime;
    ulong Control;
    ulong Status;
    uint HitCount;
    uint Reserved1;
    ulong Reserved2;
    ulong Reserved3;
}

struct PPM_WMI_PERF_STATES
{
    uint Count;
    uint MaxFrequency;
    uint CurrentState;
    uint MaxPerfState;
    uint MinPerfState;
    uint LowestPerfState;
    uint ThermalConstraint;
    ubyte BusyAdjThreshold;
    ubyte PolicyType;
    ubyte Type;
    ubyte Reserved;
    uint TimerInterval;
    ulong TargetProcessors;
    uint PStateHandler;
    uint PStateContext;
    uint TStateHandler;
    uint TStateContext;
    uint FeedbackHandler;
    uint Reserved1;
    ulong Reserved2;
    PPM_WMI_PERF_STATE State;
}

struct PPM_WMI_PERF_STATES_EX
{
    uint Count;
    uint MaxFrequency;
    uint CurrentState;
    uint MaxPerfState;
    uint MinPerfState;
    uint LowestPerfState;
    uint ThermalConstraint;
    ubyte BusyAdjThreshold;
    ubyte PolicyType;
    ubyte Type;
    ubyte Reserved;
    uint TimerInterval;
    void* TargetProcessors;
    uint PStateHandler;
    uint PStateContext;
    uint TStateHandler;
    uint TStateContext;
    uint FeedbackHandler;
    uint Reserved1;
    ulong Reserved2;
    PPM_WMI_PERF_STATE State;
}

struct PPM_IDLE_STATE_ACCOUNTING
{
    uint IdleTransitions;
    uint FailedTransitions;
    uint InvalidBucketIndex;
    ulong TotalTime;
    uint IdleTimeBuckets;
}

struct PPM_IDLE_ACCOUNTING
{
    uint StateCount;
    uint TotalTransitions;
    uint ResetCount;
    ulong StartTime;
    PPM_IDLE_STATE_ACCOUNTING State;
}

struct PPM_IDLE_STATE_BUCKET_EX
{
    ulong TotalTimeUs;
    uint MinTimeUs;
    uint MaxTimeUs;
    uint Count;
}

struct PPM_IDLE_STATE_ACCOUNTING_EX
{
    ulong TotalTime;
    uint IdleTransitions;
    uint FailedTransitions;
    uint InvalidBucketIndex;
    uint MinTimeUs;
    uint MaxTimeUs;
    uint CancelledTransitions;
    PPM_IDLE_STATE_BUCKET_EX IdleTimeBuckets;
}

struct PPM_IDLE_ACCOUNTING_EX
{
    uint StateCount;
    uint TotalTransitions;
    uint ResetCount;
    uint AbortCount;
    ulong StartTime;
    PPM_IDLE_STATE_ACCOUNTING_EX State;
}

struct PPM_PERFSTATE_EVENT
{
    uint State;
    uint Status;
    uint Latency;
    uint Speed;
    uint Processor;
}

struct PPM_PERFSTATE_DOMAIN_EVENT
{
    uint State;
    uint Latency;
    uint Speed;
    ulong Processors;
}

struct PPM_IDLESTATE_EVENT
{
    uint NewState;
    uint OldState;
    ulong Processors;
}

struct PPM_THERMALCHANGE_EVENT
{
    uint ThermalConstraint;
    ulong Processors;
}

struct PPM_THERMAL_POLICY_EVENT
{
    ubyte Mode;
    ulong Processors;
}

struct POWER_ACTION_POLICY
{
    POWER_ACTION Action;
    uint Flags;
    uint EventCode;
}

struct SYSTEM_POWER_LEVEL
{
    ubyte Enable;
    ubyte Spare;
    uint BatteryLevel;
    POWER_ACTION_POLICY PowerPolicy;
    SYSTEM_POWER_STATE MinSystemState;
}

struct SYSTEM_POWER_POLICY
{
    uint Revision;
    POWER_ACTION_POLICY PowerButton;
    POWER_ACTION_POLICY SleepButton;
    POWER_ACTION_POLICY LidClose;
    SYSTEM_POWER_STATE LidOpenWake;
    uint Reserved;
    POWER_ACTION_POLICY Idle;
    uint IdleTimeout;
    ubyte IdleSensitivity;
    ubyte DynamicThrottle;
    ubyte Spare2;
    SYSTEM_POWER_STATE MinSleep;
    SYSTEM_POWER_STATE MaxSleep;
    SYSTEM_POWER_STATE ReducedLatencySleep;
    uint WinLogonFlags;
    uint Spare3;
    uint DozeS4Timeout;
    uint BroadcastCapacityResolution;
    SYSTEM_POWER_LEVEL DischargePolicy;
    uint VideoTimeout;
    ubyte VideoDimDisplay;
    uint VideoReserved;
    uint SpindownTimeout;
    ubyte OptimizeForPower;
    ubyte FanThrottleTolerance;
    ubyte ForcedThrottle;
    ubyte MinThrottle;
    POWER_ACTION_POLICY OverThrottled;
}

struct PROCESSOR_IDLESTATE_INFO
{
    uint TimeCheck;
    ubyte DemotePercent;
    ubyte PromotePercent;
    ubyte Spare;
}

struct PROCESSOR_IDLESTATE_POLICY
{
    ushort Revision;
    _Flags_e__Union Flags;
    uint PolicyCount;
    PROCESSOR_IDLESTATE_INFO Policy;
}

struct PROCESSOR_POWER_POLICY_INFO
{
    uint TimeCheck;
    uint DemoteLimit;
    uint PromoteLimit;
    ubyte DemotePercent;
    ubyte PromotePercent;
    ubyte Spare;
    uint _bitfield;
}

struct PROCESSOR_POWER_POLICY
{
    uint Revision;
    ubyte DynamicThrottle;
    ubyte Spare;
    uint _bitfield;
    uint PolicyCount;
    PROCESSOR_POWER_POLICY_INFO Policy;
}

struct PROCESSOR_PERFSTATE_POLICY
{
    uint Revision;
    ubyte MaxThrottle;
    ubyte MinThrottle;
    ubyte BusyAdjThreshold;
    _Anonymous_e__Union Anonymous;
    uint TimeCheck;
    uint IncreaseTime;
    uint DecreaseTime;
    uint IncreasePercent;
    uint DecreasePercent;
}

struct ADMINISTRATOR_POWER_POLICY
{
    SYSTEM_POWER_STATE MinSleep;
    SYSTEM_POWER_STATE MaxSleep;
    uint MinVideoTimeout;
    uint MaxVideoTimeout;
    uint MinSpindownTimeout;
    uint MaxSpindownTimeout;
}

enum HIBERFILE_BUCKET_SIZE
{
    HiberFileBucket1GB = 0,
    HiberFileBucket2GB = 1,
    HiberFileBucket4GB = 2,
    HiberFileBucket8GB = 3,
    HiberFileBucket16GB = 4,
    HiberFileBucket32GB = 5,
    HiberFileBucketUnlimited = 6,
    HiberFileBucketMax = 7,
}

struct HIBERFILE_BUCKET
{
    ulong MaxPhysicalMemory;
    uint PhysicalMemoryPercent;
}

struct SYSTEM_POWER_CAPABILITIES
{
    ubyte PowerButtonPresent;
    ubyte SleepButtonPresent;
    ubyte LidPresent;
    ubyte SystemS1;
    ubyte SystemS2;
    ubyte SystemS3;
    ubyte SystemS4;
    ubyte SystemS5;
    ubyte HiberFilePresent;
    ubyte FullWake;
    ubyte VideoDimPresent;
    ubyte ApmPresent;
    ubyte UpsPresent;
    ubyte ThermalControl;
    ubyte ProcessorThrottle;
    ubyte ProcessorMinThrottle;
    ubyte ProcessorMaxThrottle;
    ubyte FastSystemS4;
    ubyte Hiberboot;
    ubyte WakeAlarmPresent;
    ubyte AoAc;
    ubyte DiskSpinDown;
    ubyte HiberFileType;
    ubyte AoAcConnectivitySupported;
    ubyte spare3;
    ubyte SystemBatteriesPresent;
    ubyte BatteriesAreShortTerm;
    BATTERY_REPORTING_SCALE BatteryScale;
    SYSTEM_POWER_STATE AcOnLineWake;
    SYSTEM_POWER_STATE SoftLidWake;
    SYSTEM_POWER_STATE RtcWake;
    SYSTEM_POWER_STATE MinDeviceWakeState;
    SYSTEM_POWER_STATE DefaultLowLatencyWake;
}

struct SYSTEM_BATTERY_STATE
{
    ubyte AcOnLine;
    ubyte BatteryPresent;
    ubyte Charging;
    ubyte Discharging;
    ubyte Spare1;
    ubyte Tag;
    uint MaxCapacity;
    uint RemainingCapacity;
    uint Rate;
    uint EstimatedTime;
    uint DefaultAlert1;
    uint DefaultAlert2;
}

struct IMAGE_DOS_HEADER
{
    ushort e_magic;
    ushort e_cblp;
    ushort e_cp;
    ushort e_crlc;
    ushort e_cparhdr;
    ushort e_minalloc;
    ushort e_maxalloc;
    ushort e_ss;
    ushort e_sp;
    ushort e_csum;
    ushort e_ip;
    ushort e_cs;
    ushort e_lfarlc;
    ushort e_ovno;
    ushort e_res;
    ushort e_oemid;
    ushort e_oeminfo;
    ushort e_res2;
    int e_lfanew;
}

struct IMAGE_OS2_HEADER
{
    ushort ne_magic;
    byte ne_ver;
    byte ne_rev;
    ushort ne_enttab;
    ushort ne_cbenttab;
    int ne_crc;
    ushort ne_flags;
    ushort ne_autodata;
    ushort ne_heap;
    ushort ne_stack;
    int ne_csip;
    int ne_sssp;
    ushort ne_cseg;
    ushort ne_cmod;
    ushort ne_cbnrestab;
    ushort ne_segtab;
    ushort ne_rsrctab;
    ushort ne_restab;
    ushort ne_modtab;
    ushort ne_imptab;
    int ne_nrestab;
    ushort ne_cmovent;
    ushort ne_align;
    ushort ne_cres;
    ubyte ne_exetyp;
    ubyte ne_flagsothers;
    ushort ne_pretthunks;
    ushort ne_psegrefbytes;
    ushort ne_swaparea;
    ushort ne_expver;
}

struct IMAGE_VXD_HEADER
{
    ushort e32_magic;
    ubyte e32_border;
    ubyte e32_worder;
    uint e32_level;
    ushort e32_cpu;
    ushort e32_os;
    uint e32_ver;
    uint e32_mflags;
    uint e32_mpages;
    uint e32_startobj;
    uint e32_eip;
    uint e32_stackobj;
    uint e32_esp;
    uint e32_pagesize;
    uint e32_lastpagesize;
    uint e32_fixupsize;
    uint e32_fixupsum;
    uint e32_ldrsize;
    uint e32_ldrsum;
    uint e32_objtab;
    uint e32_objcnt;
    uint e32_objmap;
    uint e32_itermap;
    uint e32_rsrctab;
    uint e32_rsrccnt;
    uint e32_restab;
    uint e32_enttab;
    uint e32_dirtab;
    uint e32_dircnt;
    uint e32_fpagetab;
    uint e32_frectab;
    uint e32_impmod;
    uint e32_impmodcnt;
    uint e32_impproc;
    uint e32_pagesum;
    uint e32_datapage;
    uint e32_preload;
    uint e32_nrestab;
    uint e32_cbnrestab;
    uint e32_nressum;
    uint e32_autodata;
    uint e32_debuginfo;
    uint e32_debuglen;
    uint e32_instpreload;
    uint e32_instdemand;
    uint e32_heapsize;
    ubyte e32_res3;
    uint e32_winresoff;
    uint e32_winreslen;
    ushort e32_devid;
    ushort e32_ddkver;
}

struct IMAGE_OPTIONAL_HEADER
{
    ushort Magic;
    ubyte MajorLinkerVersion;
    ubyte MinorLinkerVersion;
    uint SizeOfCode;
    uint SizeOfInitializedData;
    uint SizeOfUninitializedData;
    uint AddressOfEntryPoint;
    uint BaseOfCode;
    uint BaseOfData;
    uint ImageBase;
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
    uint SizeOfStackReserve;
    uint SizeOfStackCommit;
    uint SizeOfHeapReserve;
    uint SizeOfHeapCommit;
    uint LoaderFlags;
    uint NumberOfRvaAndSizes;
    IMAGE_DATA_DIRECTORY DataDirectory;
}

struct IMAGE_ROM_OPTIONAL_HEADER
{
    ushort Magic;
    ubyte MajorLinkerVersion;
    ubyte MinorLinkerVersion;
    uint SizeOfCode;
    uint SizeOfInitializedData;
    uint SizeOfUninitializedData;
    uint AddressOfEntryPoint;
    uint BaseOfCode;
    uint BaseOfData;
    uint BaseOfBss;
    uint GprMask;
    uint CprMask;
    uint GpValue;
}

struct IMAGE_NT_HEADERS
{
    uint Signature;
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER OptionalHeader;
}

struct IMAGE_ROM_HEADERS
{
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_ROM_OPTIONAL_HEADER OptionalHeader;
}

struct ANON_OBJECT_HEADER
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint TimeDateStamp;
    Guid ClassID;
    uint SizeOfData;
}

struct ANON_OBJECT_HEADER_V2
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint TimeDateStamp;
    Guid ClassID;
    uint SizeOfData;
    uint Flags;
    uint MetaDataSize;
    uint MetaDataOffset;
}

struct ANON_OBJECT_HEADER_BIGOBJ
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint TimeDateStamp;
    Guid ClassID;
    uint SizeOfData;
    uint Flags;
    uint MetaDataSize;
    uint MetaDataOffset;
    uint NumberOfSections;
    uint PointerToSymbolTable;
    uint NumberOfSymbols;
}

struct IMAGE_SYMBOL
{
    _N_e__Union N;
    uint Value;
    short SectionNumber;
    ushort Type;
    ubyte StorageClass;
    ubyte NumberOfAuxSymbols;
}

struct IMAGE_SYMBOL_EX
{
    _N_e__Union N;
    uint Value;
    int SectionNumber;
    ushort Type;
    ubyte StorageClass;
    ubyte NumberOfAuxSymbols;
}

struct IMAGE_AUX_SYMBOL_TOKEN_DEF
{
    ubyte bAuxType;
    ubyte bReserved;
    uint SymbolTableIndex;
    ubyte rgbReserved;
}

struct IMAGE_AUX_SYMBOL
{
    _Sym_e__Struct Sym;
    _File_e__Struct File;
    _Section_e__Struct Section;
    IMAGE_AUX_SYMBOL_TOKEN_DEF TokenDef;
    _CRC_e__Struct CRC;
}

struct IMAGE_AUX_SYMBOL_EX
{
    _Sym_e__Struct Sym;
    _File_e__Struct File;
    _Section_e__Struct Section;
    _Anonymous_e__Struct Anonymous;
    _CRC_e__Struct CRC;
}

enum IMAGE_AUX_SYMBOL_TYPE
{
    IMAGE_AUX_SYMBOL_TYPE_TOKEN_DEF = 1,
}

struct IMAGE_RELOCATION
{
    _Anonymous_e__Union Anonymous;
    uint SymbolTableIndex;
    ushort Type;
}

struct IMAGE_LINENUMBER
{
    _Type_e__Union Type;
    ushort Linenumber;
}

struct IMAGE_BASE_RELOCATION
{
    uint VirtualAddress;
    uint SizeOfBlock;
}

struct IMAGE_ARCHIVE_MEMBER_HEADER
{
    ubyte Name;
    ubyte Date;
    ubyte UserID;
    ubyte GroupID;
    ubyte Mode;
    ubyte Size;
    ubyte EndHeader;
}

struct IMAGE_EXPORT_DIRECTORY
{
    uint Characteristics;
    uint TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint Name;
    uint Base;
    uint NumberOfFunctions;
    uint NumberOfNames;
    uint AddressOfFunctions;
    uint AddressOfNames;
    uint AddressOfNameOrdinals;
}

struct IMAGE_IMPORT_BY_NAME
{
    ushort Hint;
    byte Name;
}

struct IMAGE_THUNK_DATA64
{
    _u1_e__Union u1;
}

struct IMAGE_THUNK_DATA32
{
    _u1_e__Union u1;
}

alias PIMAGE_TLS_CALLBACK = extern(Windows) void function(void* DllHandle, uint Reason, void* Reserved);
struct IMAGE_TLS_DIRECTORY64
{
    ulong StartAddressOfRawData;
    ulong EndAddressOfRawData;
    ulong AddressOfIndex;
    ulong AddressOfCallBacks;
    uint SizeOfZeroFill;
    _Anonymous_e__Union Anonymous;
}

struct IMAGE_TLS_DIRECTORY32
{
    uint StartAddressOfRawData;
    uint EndAddressOfRawData;
    uint AddressOfIndex;
    uint AddressOfCallBacks;
    uint SizeOfZeroFill;
    _Anonymous_e__Union Anonymous;
}

struct IMAGE_IMPORT_DESCRIPTOR
{
    _Anonymous_e__Union Anonymous;
    uint TimeDateStamp;
    uint ForwarderChain;
    uint Name;
    uint FirstThunk;
}

struct IMAGE_BOUND_IMPORT_DESCRIPTOR
{
    uint TimeDateStamp;
    ushort OffsetModuleName;
    ushort NumberOfModuleForwarderRefs;
}

struct IMAGE_BOUND_FORWARDER_REF
{
    uint TimeDateStamp;
    ushort OffsetModuleName;
    ushort Reserved;
}

struct IMAGE_DELAYLOAD_DESCRIPTOR
{
    _Attributes_e__Union Attributes;
    uint DllNameRVA;
    uint ModuleHandleRVA;
    uint ImportAddressTableRVA;
    uint ImportNameTableRVA;
    uint BoundImportAddressTableRVA;
    uint UnloadInformationTableRVA;
    uint TimeDateStamp;
}

struct IMAGE_RESOURCE_DIRECTORY
{
    uint Characteristics;
    uint TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    ushort NumberOfNamedEntries;
    ushort NumberOfIdEntries;
}

struct IMAGE_RESOURCE_DIRECTORY_ENTRY
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct IMAGE_RESOURCE_DIRECTORY_STRING
{
    ushort Length;
    byte NameString;
}

struct IMAGE_RESOURCE_DIR_STRING_U
{
    ushort Length;
    ushort NameString;
}

struct IMAGE_RESOURCE_DATA_ENTRY
{
    uint OffsetToData;
    uint Size;
    uint CodePage;
    uint Reserved;
}

struct IMAGE_LOAD_CONFIG_CODE_INTEGRITY
{
    ushort Flags;
    ushort Catalog;
    uint CatalogOffset;
    uint Reserved;
}

struct IMAGE_DYNAMIC_RELOCATION_TABLE
{
    uint Version;
    uint Size;
}

struct IMAGE_DYNAMIC_RELOCATION32
{
    uint Symbol;
    uint BaseRelocSize;
}

struct IMAGE_DYNAMIC_RELOCATION64
{
    ulong Symbol;
    uint BaseRelocSize;
}

struct IMAGE_DYNAMIC_RELOCATION32_V2
{
    uint HeaderSize;
    uint FixupInfoSize;
    uint Symbol;
    uint SymbolGroup;
    uint Flags;
}

struct IMAGE_DYNAMIC_RELOCATION64_V2
{
    uint HeaderSize;
    uint FixupInfoSize;
    ulong Symbol;
    uint SymbolGroup;
    uint Flags;
}

struct IMAGE_PROLOGUE_DYNAMIC_RELOCATION_HEADER
{
    ubyte PrologueByteCount;
}

struct IMAGE_EPILOGUE_DYNAMIC_RELOCATION_HEADER
{
    uint EpilogueCount;
    ubyte EpilogueByteCount;
    ubyte BranchDescriptorElementSize;
    ushort BranchDescriptorCount;
}

struct IMAGE_IMPORT_CONTROL_TRANSFER_DYNAMIC_RELOCATION
{
    uint _bitfield;
}

struct IMAGE_INDIR_CONTROL_TRANSFER_DYNAMIC_RELOCATION
{
    ushort _bitfield;
}

struct IMAGE_SWITCHTABLE_BRANCH_DYNAMIC_RELOCATION
{
    ushort _bitfield;
}

struct IMAGE_HOT_PATCH_INFO
{
    uint Version;
    uint Size;
    uint SequenceNumber;
    uint BaseImageList;
    uint BaseImageCount;
    uint BufferOffset;
    uint ExtraPatchSize;
}

struct IMAGE_HOT_PATCH_BASE
{
    uint SequenceNumber;
    uint Flags;
    uint OriginalTimeDateStamp;
    uint OriginalCheckSum;
    uint CodeIntegrityInfo;
    uint CodeIntegritySize;
    uint PatchTable;
    uint BufferOffset;
}

struct IMAGE_HOT_PATCH_HASHES
{
    ubyte SHA256;
    ubyte SHA1;
}

struct IMAGE_CE_RUNTIME_FUNCTION_ENTRY
{
    uint FuncStart;
    uint _bitfield;
}

struct IMAGE_ARM_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    _Anonymous_e__Union Anonymous;
}

enum ARM64_FNPDATA_FLAGS
{
    PdataRefToFullXdata = 0,
    PdataPackedUnwindFunction = 1,
    PdataPackedUnwindFragment = 2,
}

enum ARM64_FNPDATA_CR
{
    PdataCrUnchained = 0,
    PdataCrUnchainedSavedLr = 1,
    PdataCrChained = 3,
}

struct IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    _Anonymous_e__Union Anonymous;
}

struct IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA
{
    uint HeaderData;
    _Anonymous_e__Struct Anonymous;
}

struct IMAGE_ALPHA64_RUNTIME_FUNCTION_ENTRY
{
    ulong BeginAddress;
    ulong EndAddress;
    ulong ExceptionHandler;
    ulong HandlerData;
    ulong PrologEndAddress;
}

struct IMAGE_ALPHA_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    uint EndAddress;
    uint ExceptionHandler;
    uint HandlerData;
    uint PrologEndAddress;
}

struct IMAGE_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    uint EndAddress;
    _Anonymous_e__Union Anonymous;
}

struct IMAGE_ENCLAVE_CONFIG32
{
    uint Size;
    uint MinimumRequiredConfigSize;
    uint PolicyFlags;
    uint NumberOfImports;
    uint ImportList;
    uint ImportEntrySize;
    ubyte FamilyID;
    ubyte ImageID;
    uint ImageVersion;
    uint SecurityVersion;
    uint EnclaveSize;
    uint NumberOfThreads;
    uint EnclaveFlags;
}

struct IMAGE_ENCLAVE_CONFIG64
{
    uint Size;
    uint MinimumRequiredConfigSize;
    uint PolicyFlags;
    uint NumberOfImports;
    uint ImportList;
    uint ImportEntrySize;
    ubyte FamilyID;
    ubyte ImageID;
    uint ImageVersion;
    uint SecurityVersion;
    ulong EnclaveSize;
    uint NumberOfThreads;
    uint EnclaveFlags;
}

struct IMAGE_ENCLAVE_IMPORT
{
    uint MatchType;
    uint MinimumSecurityVersion;
    ubyte UniqueOrAuthorID;
    ubyte FamilyID;
    ubyte ImageID;
    uint ImportName;
    uint Reserved;
}

struct IMAGE_DEBUG_MISC
{
    uint DataType;
    uint Length;
    ubyte Unicode;
    ubyte Reserved;
    ubyte Data;
}

struct IMAGE_SEPARATE_DEBUG_HEADER
{
    ushort Signature;
    ushort Flags;
    ushort Machine;
    ushort Characteristics;
    uint TimeDateStamp;
    uint CheckSum;
    uint ImageBase;
    uint SizeOfImage;
    uint NumberOfSections;
    uint ExportedNamesSize;
    uint DebugDirectorySize;
    uint SectionAlignment;
    uint Reserved;
}

struct NON_PAGED_DEBUG_INFO
{
    ushort Signature;
    ushort Flags;
    uint Size;
    ushort Machine;
    ushort Characteristics;
    uint TimeDateStamp;
    uint CheckSum;
    uint SizeOfImage;
    ulong ImageBase;
}

struct IMAGE_ARCHITECTURE_HEADER
{
    uint _bitfield;
    uint FirstEntryRVA;
}

struct IMAGE_ARCHITECTURE_ENTRY
{
    uint FixupInstRVA;
    uint NewInst;
}

struct IMPORT_OBJECT_HEADER
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint TimeDateStamp;
    uint SizeOfData;
    _Anonymous_e__Union Anonymous;
    ushort _bitfield;
}

enum IMPORT_OBJECT_TYPE
{
    IMPORT_OBJECT_CODE = 0,
    IMPORT_OBJECT_DATA = 1,
    IMPORT_OBJECT_CONST = 2,
}

enum IMPORT_OBJECT_NAME_TYPE
{
    IMPORT_OBJECT_ORDINAL = 0,
    IMPORT_OBJECT_NAME = 1,
    IMPORT_OBJECT_NAME_NO_PREFIX = 2,
    IMPORT_OBJECT_NAME_UNDECORATE = 3,
    IMPORT_OBJECT_NAME_EXPORTAS = 4,
}

enum ReplacesCorHdrNumericDefines
{
    COMIMAGE_FLAGS_ILONLY = 1,
    COMIMAGE_FLAGS_32BITREQUIRED = 2,
    COMIMAGE_FLAGS_IL_LIBRARY = 4,
    COMIMAGE_FLAGS_STRONGNAMESIGNED = 8,
    COMIMAGE_FLAGS_NATIVE_ENTRYPOINT = 16,
    COMIMAGE_FLAGS_TRACKDEBUGDATA = 65536,
    COMIMAGE_FLAGS_32BITPREFERRED = 131072,
    COR_VERSION_MAJOR_V2 = 2,
    COR_VERSION_MAJOR = 2,
    COR_VERSION_MINOR = 5,
    COR_DELETED_NAME_LENGTH = 8,
    COR_VTABLEGAP_NAME_LENGTH = 8,
    NATIVE_TYPE_MAX_CB = 1,
    COR_ILMETHOD_SECT_SMALL_MAX_DATASIZE = 255,
    IMAGE_COR_MIH_METHODRVA = 1,
    IMAGE_COR_MIH_EHRVA = 2,
    IMAGE_COR_MIH_BASICBLOCK = 8,
    COR_VTABLE_32BIT = 1,
    COR_VTABLE_64BIT = 2,
    COR_VTABLE_FROM_UNMANAGED = 4,
    COR_VTABLE_FROM_UNMANAGED_RETAIN_APPDOMAIN = 8,
    COR_VTABLE_CALL_MOST_DERIVED = 16,
    IMAGE_COR_EATJ_THUNK_SIZE = 32,
    MAX_CLASS_NAME = 1024,
    MAX_PACKAGE_NAME = 1024,
}

struct IMAGE_COR20_HEADER
{
    uint cb;
    ushort MajorRuntimeVersion;
    ushort MinorRuntimeVersion;
    IMAGE_DATA_DIRECTORY MetaData;
    uint Flags;
    _Anonymous_e__Union Anonymous;
    IMAGE_DATA_DIRECTORY Resources;
    IMAGE_DATA_DIRECTORY StrongNameSignature;
    IMAGE_DATA_DIRECTORY CodeManagerTable;
    IMAGE_DATA_DIRECTORY VTableFixups;
    IMAGE_DATA_DIRECTORY ExportAddressTableJumps;
    IMAGE_DATA_DIRECTORY ManagedNativeHeader;
}

struct SLIST_HEADER
{
    ulong Alignment;
    _Anonymous_e__Struct Anonymous;
}

struct RTL_RUN_ONCE
{
    void* Ptr;
}

struct RTL_BARRIER
{
    uint Reserved1;
    uint Reserved2;
    uint Reserved3;
    uint Reserved4;
    uint Reserved5;
}

enum RTL_UMS_THREAD_INFO_CLASS
{
    UmsThreadInvalidInfoClass = 0,
    UmsThreadUserContext = 1,
    UmsThreadPriority = 2,
    UmsThreadAffinity = 3,
    UmsThreadTeb = 4,
    UmsThreadIsSuspended = 5,
    UmsThreadIsTerminated = 6,
    UmsThreadMaxInfoClass = 7,
}

enum RTL_UMS_SCHEDULER_REASON
{
    UmsSchedulerStartup = 0,
    UmsSchedulerThreadBlocked = 1,
    UmsSchedulerThreadYield = 2,
}

alias RTL_UMS_SCHEDULER_ENTRY_POINT = extern(Windows) void function(RTL_UMS_SCHEDULER_REASON Reason, uint ActivationPayload, void* SchedulerParam);
alias PRTL_UMS_SCHEDULER_ENTRY_POINT = extern(Windows) void function();
enum OS_DEPLOYEMENT_STATE_VALUES
{
    OS_DEPLOYMENT_STANDARD = 1,
    OS_DEPLOYMENT_COMPACT = 2,
}

struct NV_MEMORY_RANGE
{
    void* BaseAddress;
    uint Length;
}

struct CORRELATION_VECTOR
{
    byte Version;
    byte Vector;
}

struct CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG
{
    uint Size;
    const(wchar)* TriggerId;
}

enum IMAGE_POLICY_ENTRY_TYPE
{
    ImagePolicyEntryTypeNone = 0,
    ImagePolicyEntryTypeBool = 1,
    ImagePolicyEntryTypeInt8 = 2,
    ImagePolicyEntryTypeUInt8 = 3,
    ImagePolicyEntryTypeInt16 = 4,
    ImagePolicyEntryTypeUInt16 = 5,
    ImagePolicyEntryTypeInt32 = 6,
    ImagePolicyEntryTypeUInt32 = 7,
    ImagePolicyEntryTypeInt64 = 8,
    ImagePolicyEntryTypeUInt64 = 9,
    ImagePolicyEntryTypeAnsiString = 10,
    ImagePolicyEntryTypeUnicodeString = 11,
    ImagePolicyEntryTypeOverride = 12,
    ImagePolicyEntryTypeMaximum = 13,
}

enum IMAGE_POLICY_ID
{
    ImagePolicyIdNone = 0,
    ImagePolicyIdEtw = 1,
    ImagePolicyIdDebug = 2,
    ImagePolicyIdCrashDump = 3,
    ImagePolicyIdCrashDumpKey = 4,
    ImagePolicyIdCrashDumpKeyGuid = 5,
    ImagePolicyIdParentSd = 6,
    ImagePolicyIdParentSdRev = 7,
    ImagePolicyIdSvn = 8,
    ImagePolicyIdDeviceId = 9,
    ImagePolicyIdCapability = 10,
    ImagePolicyIdScenarioId = 11,
    ImagePolicyIdMaximum = 12,
}

struct IMAGE_POLICY_ENTRY
{
    IMAGE_POLICY_ENTRY_TYPE Type;
    IMAGE_POLICY_ID PolicyId;
    _u_e__Union u;
}

struct IMAGE_POLICY_METADATA
{
    ubyte Version;
    ubyte Reserved0;
    ulong ApplicationId;
    IMAGE_POLICY_ENTRY Policies;
}

struct RTL_CRITICAL_SECTION_DEBUG
{
    ushort Type;
    ushort CreatorBackTraceIndex;
    RTL_CRITICAL_SECTION* CriticalSection;
    LIST_ENTRY ProcessLocksList;
    uint EntryCount;
    uint ContentionCount;
    uint Flags;
    ushort CreatorBackTraceIndexHigh;
    ushort SpareWORD;
}

struct RTL_CRITICAL_SECTION
{
    RTL_CRITICAL_SECTION_DEBUG* DebugInfo;
    int LockCount;
    int RecursionCount;
    HANDLE OwningThread;
    HANDLE LockSemaphore;
    uint SpinCount;
}

struct RTL_SRWLOCK
{
    void* Ptr;
}

struct RTL_CONDITION_VARIABLE
{
    void* Ptr;
}

alias PAPCFUNC = extern(Windows) void function(uint Parameter);
enum HEAP_INFORMATION_CLASS
{
    HeapCompatibilityInformation = 0,
    HeapEnableTerminationOnCorruption = 1,
    HeapOptimizeResources = 3,
}

struct HEAP_OPTIMIZE_RESOURCES_INFORMATION
{
    uint Version;
    uint Flags;
}

alias WAITORTIMERCALLBACKFUNC = extern(Windows) void function(void* param0, ubyte param1);
alias WORKERCALLBACKFUNC = extern(Windows) void function(void* param0);
alias APC_CALLBACK_FUNCTION = extern(Windows) void function(uint param0, void* param1, void* param2);
alias WAITORTIMERCALLBACK = extern(Windows) void function();
alias PFLS_CALLBACK_FUNCTION = extern(Windows) void function(void* lpFlsData);
alias PSECURE_MEMORY_CACHE_CALLBACK = extern(Windows) ubyte function(char* Addr, uint Range);
enum ACTIVATION_CONTEXT_INFO_CLASS
{
    ActivationContextBasicInformation = 1,
    ActivationContextDetailedInformation = 2,
    AssemblyDetailedInformationInActivationContext = 3,
    FileInformationInAssemblyOfAssemblyInActivationContext = 4,
    RunlevelInformationInActivationContext = 5,
    CompatibilityInformationInActivationContext = 6,
    ActivationContextManifestResourceName = 7,
    MaxActivationContextInfoClass = 8,
    AssemblyDetailedInformationInActivationContxt = 3,
    FileInformationInAssemblyOfAssemblyInActivationContxt = 4,
}

struct SUPPORTED_OS_INFO
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct MAXVERSIONTESTED_INFO
{
    ulong MaxVersionTested;
}

struct EVENTLOGRECORD
{
    uint Length;
    uint Reserved;
    uint RecordNumber;
    uint TimeGenerated;
    uint TimeWritten;
    uint EventID;
    ushort EventType;
    ushort NumStrings;
    ushort EventCategory;
    ushort ReservedFlags;
    uint ClosingRecordNumber;
    uint StringOffset;
    uint UserSidLength;
    uint UserSidOffset;
    uint DataLength;
    uint DataOffset;
}

struct EVENTSFORLOGFILE
{
    uint ulSize;
    ushort szLogicalLogFile;
    uint ulNumRecords;
    EVENTLOGRECORD pEventLogRecords;
}

struct PACKEDEVENTINFO
{
    uint ulSize;
    uint ulNumEventsForLogFile;
    uint ulOffsets;
}

enum CM_SERVICE_NODE_TYPE
{
    DriverType = 1,
    FileSystemType = 2,
    Win32ServiceOwnProcess = 16,
    Win32ServiceShareProcess = 32,
    AdapterType = 4,
    RecognizerType = 8,
}

enum CM_SERVICE_LOAD_TYPE
{
    BootLoad = 0,
    SystemLoad = 1,
    AutoLoad = 2,
    DemandLoad = 3,
    DisableLoad = 4,
}

enum CM_ERROR_CONTROL_TYPE
{
    IgnoreError = 0,
    NormalError = 1,
    SevereError = 2,
    CriticalError = 3,
}

struct TAPE_ERASE
{
    uint Type;
    ubyte Immediate;
}

struct TAPE_PREPARE
{
    uint Operation;
    ubyte Immediate;
}

struct TAPE_WRITE_MARKS
{
    uint Type;
    uint Count;
    ubyte Immediate;
}

struct TAPE_GET_POSITION
{
    uint Type;
    uint Partition;
    LARGE_INTEGER Offset;
}

struct TAPE_SET_POSITION
{
    uint Method;
    uint Partition;
    LARGE_INTEGER Offset;
    ubyte Immediate;
}

struct TAPE_GET_DRIVE_PARAMETERS
{
    ubyte ECC;
    ubyte Compression;
    ubyte DataPadding;
    ubyte ReportSetmarks;
    uint DefaultBlockSize;
    uint MaximumBlockSize;
    uint MinimumBlockSize;
    uint MaximumPartitionCount;
    uint FeaturesLow;
    uint FeaturesHigh;
    uint EOTWarningZoneSize;
}

struct TAPE_SET_DRIVE_PARAMETERS
{
    ubyte ECC;
    ubyte Compression;
    ubyte DataPadding;
    ubyte ReportSetmarks;
    uint EOTWarningZoneSize;
}

struct TAPE_GET_MEDIA_PARAMETERS
{
    LARGE_INTEGER Capacity;
    LARGE_INTEGER Remaining;
    uint BlockSize;
    uint PartitionCount;
    ubyte WriteProtected;
}

struct TAPE_SET_MEDIA_PARAMETERS
{
    uint BlockSize;
}

struct TAPE_CREATE_PARTITION
{
    uint Method;
    uint Count;
    uint Size;
}

struct TAPE_WMI_OPERATIONS
{
    uint Method;
    uint DataBufferSize;
    void* DataBuffer;
}

enum TAPE_DRIVE_PROBLEM_TYPE
{
    TapeDriveProblemNone = 0,
    TapeDriveReadWriteWarning = 1,
    TapeDriveReadWriteError = 2,
    TapeDriveReadWarning = 3,
    TapeDriveWriteWarning = 4,
    TapeDriveReadError = 5,
    TapeDriveWriteError = 6,
    TapeDriveHardwareError = 7,
    TapeDriveUnsupportedMedia = 8,
    TapeDriveScsiConnectionError = 9,
    TapeDriveTimetoClean = 10,
    TapeDriveCleanDriveNow = 11,
    TapeDriveMediaLifeExpired = 12,
    TapeDriveSnappedTape = 13,
}

enum TRANSACTION_STATE
{
    TransactionStateNormal = 1,
    TransactionStateIndoubt = 2,
    TransactionStateCommittedNotify = 3,
}

struct TRANSACTION_BASIC_INFORMATION
{
    Guid TransactionId;
    uint State;
    uint Outcome;
}

struct TRANSACTIONMANAGER_BASIC_INFORMATION
{
    Guid TmIdentity;
    LARGE_INTEGER VirtualClock;
}

struct TRANSACTIONMANAGER_LOG_INFORMATION
{
    Guid LogIdentity;
}

struct TRANSACTIONMANAGER_LOGPATH_INFORMATION
{
    uint LogPathLength;
    ushort LogPath;
}

struct TRANSACTIONMANAGER_RECOVERY_INFORMATION
{
    ulong LastRecoveredLsn;
}

struct TRANSACTIONMANAGER_OLDEST_INFORMATION
{
    Guid OldestTransactionGuid;
}

struct TRANSACTION_PROPERTIES_INFORMATION
{
    uint IsolationLevel;
    uint IsolationFlags;
    LARGE_INTEGER Timeout;
    uint Outcome;
    uint DescriptionLength;
    ushort Description;
}

struct TRANSACTION_BIND_INFORMATION
{
    HANDLE TmHandle;
}

struct TRANSACTION_ENLISTMENT_PAIR
{
    Guid EnlistmentId;
    Guid ResourceManagerId;
}

struct TRANSACTION_ENLISTMENTS_INFORMATION
{
    uint NumberOfEnlistments;
    TRANSACTION_ENLISTMENT_PAIR EnlistmentPair;
}

struct TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION
{
    TRANSACTION_ENLISTMENT_PAIR SuperiorEnlistmentPair;
}

struct RESOURCEMANAGER_BASIC_INFORMATION
{
    Guid ResourceManagerId;
    uint DescriptionLength;
    ushort Description;
}

struct RESOURCEMANAGER_COMPLETION_INFORMATION
{
    HANDLE IoCompletionPortHandle;
    uint CompletionKey;
}

enum TRANSACTION_INFORMATION_CLASS
{
    TransactionBasicInformation = 0,
    TransactionPropertiesInformation = 1,
    TransactionEnlistmentInformation = 2,
    TransactionSuperiorEnlistmentInformation = 3,
    TransactionBindInformation = 4,
    TransactionDTCPrivateInformation = 5,
}

enum TRANSACTIONMANAGER_INFORMATION_CLASS
{
    TransactionManagerBasicInformation = 0,
    TransactionManagerLogInformation = 1,
    TransactionManagerLogPathInformation = 2,
    TransactionManagerRecoveryInformation = 4,
    TransactionManagerOnlineProbeInformation = 3,
    TransactionManagerOldestTransactionInformation = 5,
}

enum RESOURCEMANAGER_INFORMATION_CLASS
{
    ResourceManagerBasicInformation = 0,
    ResourceManagerCompletionInformation = 1,
}

struct ENLISTMENT_BASIC_INFORMATION
{
    Guid EnlistmentId;
    Guid TransactionId;
    Guid ResourceManagerId;
}

struct ENLISTMENT_CRM_INFORMATION
{
    Guid CrmTransactionManagerId;
    Guid CrmResourceManagerId;
    Guid CrmEnlistmentId;
}

enum ENLISTMENT_INFORMATION_CLASS
{
    EnlistmentBasicInformation = 0,
    EnlistmentRecoveryInformation = 1,
    EnlistmentCrmInformation = 2,
}

struct TRANSACTION_LIST_ENTRY
{
    Guid UOW;
}

struct TRANSACTION_LIST_INFORMATION
{
    uint NumberOfTransactions;
    TRANSACTION_LIST_ENTRY TransactionInformation;
}

enum KTMOBJECT_TYPE
{
    KTMOBJECT_TRANSACTION = 0,
    KTMOBJECT_TRANSACTION_MANAGER = 1,
    KTMOBJECT_RESOURCE_MANAGER = 2,
    KTMOBJECT_ENLISTMENT = 3,
    KTMOBJECT_INVALID = 4,
}

struct KTMOBJECT_CURSOR
{
    Guid LastQuery;
    uint ObjectIdCount;
    Guid ObjectIds;
}

struct TP_CALLBACK_INSTANCE
{
}

alias PTP_SIMPLE_CALLBACK = extern(Windows) void function(TP_CALLBACK_INSTANCE* Instance, void* Context);
struct TP_POOL
{
}

enum TP_CALLBACK_PRIORITY
{
    TP_CALLBACK_PRIORITY_HIGH = 0,
    TP_CALLBACK_PRIORITY_NORMAL = 1,
    TP_CALLBACK_PRIORITY_LOW = 2,
    TP_CALLBACK_PRIORITY_INVALID = 3,
    TP_CALLBACK_PRIORITY_COUNT = 3,
}

struct TP_POOL_STACK_INFORMATION
{
    uint StackReserve;
    uint StackCommit;
}

struct TP_CLEANUP_GROUP
{
}

alias PTP_CLEANUP_GROUP_CANCEL_CALLBACK = extern(Windows) void function(void* ObjectContext, void* CleanupContext);
struct TP_CALLBACK_ENVIRON_V3
{
    uint Version;
    PTP_POOL Pool;
    int CleanupGroup;
    PTP_CLEANUP_GROUP_CANCEL_CALLBACK CleanupGroupCancelCallback;
    void* RaceDll;
    int ActivationContext;
    PTP_SIMPLE_CALLBACK FinalizationCallback;
    _u_e__Union u;
    TP_CALLBACK_PRIORITY CallbackPriority;
    uint Size;
}

struct TP_WORK
{
}

alias PTP_WORK_CALLBACK = extern(Windows) void function(TP_CALLBACK_INSTANCE* Instance, void* Context, TP_WORK* Work);
struct TP_TIMER
{
}

alias PTP_TIMER_CALLBACK = extern(Windows) void function(TP_CALLBACK_INSTANCE* Instance, void* Context, TP_TIMER* Timer);
struct TP_WAIT
{
}

alias PTP_WAIT_CALLBACK = extern(Windows) void function(TP_CALLBACK_INSTANCE* Instance, void* Context, TP_WAIT* Wait, uint WaitResult);
struct TP_IO
{
}

struct TEB
{
}

alias FARPROC = extern(Windows) int function();
alias NEARPROC = extern(Windows) int function();
alias PROC = extern(Windows) int function();
struct HKEY__
{
    int unused;
}

struct HMETAFILE__
{
    int unused;
}

struct HINSTANCE__
{
    int unused;
}

struct HRGN__
{
    int unused;
}

struct HRSRC__
{
    int unused;
}

struct HSPRITE__
{
    int unused;
}

struct HLSURF__
{
    int unused;
}

struct HSTR__
{
    int unused;
}

struct HTASK__
{
    int unused;
}

struct HWINSTA__
{
    int unused;
}

struct HKL__
{
    int unused;
}

struct HWND__
{
    int unused;
}

struct HHOOK__
{
    int unused;
}

struct HACCEL__
{
    int unused;
}

struct HBITMAP__
{
    int unused;
}

struct HBRUSH__
{
    int unused;
}

struct HCOLORSPACE__
{
    int unused;
}

struct HDC__
{
    int unused;
}

struct HGLRC__
{
    int unused;
}

struct HDESK__
{
    int unused;
}

struct HENHMETAFILE__
{
    int unused;
}

struct HFONT__
{
    int unused;
}

struct HICON__
{
    int unused;
}

struct HMENU__
{
    int unused;
}

struct HPALETTE__
{
    int unused;
}

struct HPEN__
{
    int unused;
}

struct HWINEVENTHOOK__
{
    int unused;
}

struct HMONITOR__
{
    int unused;
}

struct HUMPD__
{
    int unused;
}

struct APP_LOCAL_DEVICE_ID
{
    ubyte value;
}

struct DPI_AWARENESS_CONTEXT__
{
    int unused;
}

alias PINIT_ONCE_FN = extern(Windows) BOOL function(RTL_RUN_ONCE* InitOnce, void* Parameter, void** Context);
alias PTIMERAPCROUTINE = extern(Windows) void function(void* lpArgToCompletionRoutine, uint dwTimerLowValue, uint dwTimerHighValue);
alias PTP_WIN32_IO_CALLBACK = extern(Windows) void function(TP_CALLBACK_INSTANCE* Instance, void* Context, void* Overlapped, uint IoResult, uint NumberOfBytesTransferred, TP_IO* Io);
struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION
{
    long MaxIops;
    long MaxBandwidth;
    long ReservationIops;
    const(wchar)* VolumeName;
    uint BaseIoSize;
    uint ControlFlags;
}

struct PROCESSOR_NUMBER
{
    ushort Group;
    ubyte Number;
    ubyte Reserved;
}

struct GROUP_AFFINITY
{
    uint Mask;
    ushort Group;
    ushort Reserved;
}

struct SECURITY_ATTRIBUTES
{
    uint nLength;
    void* lpSecurityDescriptor;
    BOOL bInheritHandle;
}

struct OVERLAPPED
{
    uint Internal;
    uint InternalHigh;
    _Anonymous_e__Union Anonymous;
    HANDLE hEvent;
}

struct PROCESS_HEAP_ENTRY
{
    void* lpData;
    uint cbData;
    ubyte cbOverhead;
    ubyte iRegionIndex;
    ushort wFlags;
    _Anonymous_e__Union Anonymous;
}

struct REASON_CONTEXT
{
    uint Version;
    uint Flags;
    _Reason_e__Union Reason;
}

alias PTHREAD_START_ROUTINE = extern(Windows) uint function(void* lpThreadParameter);
alias LPTHREAD_START_ROUTINE = extern(Windows) uint function();
alias PENCLAVE_ROUTINE = extern(Windows) void* function(void* lpThreadParameter);
alias LPENCLAVE_ROUTINE = extern(Windows) void* function();
struct HEAP_SUMMARY
{
    uint cb;
    uint cbAllocated;
    uint cbCommitted;
    uint cbReserved;
    uint cbMaxReserve;
}

enum MEMORY_RESOURCE_NOTIFICATION_TYPE
{
    LowMemoryResourceNotification = 0,
    HighMemoryResourceNotification = 1,
}

struct WIN32_MEMORY_RANGE_ENTRY
{
    void* VirtualAddress;
    uint NumberOfBytes;
}

alias BAD_MEMORY_CALLBACK_ROUTINE = extern(Windows) void function();
alias PBAD_MEMORY_CALLBACK_ROUTINE = extern(Windows) void function();
enum OFFER_PRIORITY
{
    VmOfferPriorityVeryLow = 1,
    VmOfferPriorityLow = 2,
    VmOfferPriorityBelowNormal = 3,
    VmOfferPriorityNormal = 4,
}

enum WIN32_MEMORY_INFORMATION_CLASS
{
    MemoryRegionInfo = 0,
}

struct WIN32_MEMORY_REGION_INFORMATION
{
    void* AllocationBase;
    uint AllocationProtect;
    _Anonymous_e__Union Anonymous;
    uint RegionSize;
    uint CommitSize;
}

struct ENUMUILANG
{
    uint NumOfEnumUILang;
    uint SizeOfEnumUIBuffer;
    ushort* pEnumUIBuffer;
}

alias ENUMRESLANGPROCA = extern(Windows) BOOL function(int hModule, const(char)* lpType, const(char)* lpName, ushort wLanguage, int lParam);
alias ENUMRESLANGPROCW = extern(Windows) BOOL function(int hModule, const(wchar)* lpType, const(wchar)* lpName, ushort wLanguage, int lParam);
alias PGET_MODULE_HANDLE_EXA = extern(Windows) BOOL function(uint dwFlags, const(char)* lpModuleName, int* phModule);
alias PGET_MODULE_HANDLE_EXW = extern(Windows) BOOL function(uint dwFlags, const(wchar)* lpModuleName, int* phModule);
struct REDIRECTION_FUNCTION_DESCRIPTOR
{
    const(char)* DllName;
    const(char)* FunctionName;
    void* RedirectionTarget;
}

struct REDIRECTION_DESCRIPTOR
{
    uint Version;
    uint FunctionCount;
    REDIRECTION_FUNCTION_DESCRIPTOR* Redirections;
}

struct COORD
{
    short X;
    short Y;
}

struct SMALL_RECT
{
    short Left;
    short Top;
    short Right;
    short Bottom;
}

struct KEY_EVENT_RECORD
{
    BOOL bKeyDown;
    ushort wRepeatCount;
    ushort wVirtualKeyCode;
    ushort wVirtualScanCode;
    _uChar_e__Union uChar;
    uint dwControlKeyState;
}

struct MOUSE_EVENT_RECORD
{
    COORD dwMousePosition;
    uint dwButtonState;
    uint dwControlKeyState;
    uint dwEventFlags;
}

struct WINDOW_BUFFER_SIZE_RECORD
{
    COORD dwSize;
}

struct MENU_EVENT_RECORD
{
    uint dwCommandId;
}

struct FOCUS_EVENT_RECORD
{
    BOOL bSetFocus;
}

struct INPUT_RECORD
{
    ushort EventType;
    _Event_e__Union Event;
}

struct CHAR_INFO
{
    _Char_e__Union Char;
    ushort Attributes;
}

struct CONSOLE_FONT_INFO
{
    uint nFont;
    COORD dwFontSize;
}

struct CONSOLE_READCONSOLE_CONTROL
{
    uint nLength;
    uint nInitialChars;
    uint dwCtrlWakeupMask;
    uint dwControlKeyState;
}

alias PHANDLER_ROUTINE = extern(Windows) BOOL function(uint CtrlType);
struct CONSOLE_CURSOR_INFO
{
    uint dwSize;
    BOOL bVisible;
}

struct CONSOLE_SCREEN_BUFFER_INFO
{
    COORD dwSize;
    COORD dwCursorPosition;
    ushort wAttributes;
    SMALL_RECT srWindow;
    COORD dwMaximumWindowSize;
}

struct CONSOLE_SCREEN_BUFFER_INFOEX
{
    uint cbSize;
    COORD dwSize;
    COORD dwCursorPosition;
    ushort wAttributes;
    SMALL_RECT srWindow;
    COORD dwMaximumWindowSize;
    ushort wPopupAttributes;
    BOOL bFullscreenSupported;
    uint ColorTable;
}

struct CONSOLE_FONT_INFOEX
{
    uint cbSize;
    uint nFont;
    COORD dwFontSize;
    uint FontFamily;
    uint FontWeight;
    ushort FaceName;
}

struct CONSOLE_SELECTION_INFO
{
    uint dwFlags;
    COORD dwSelectionAnchor;
    SMALL_RECT srSelection;
}

struct CONSOLE_HISTORY_INFO
{
    uint cbSize;
    uint HistoryBufferSize;
    uint NumberOfHistoryBuffers;
    uint dwFlags;
}

alias TIMECALLBACK = extern(Windows) void function(uint uTimerID, uint uMsg, uint dwUser, uint dw1, uint dw2);
alias LPTIMECALLBACK = extern(Windows) void function();
alias PM_OPEN_PROC = extern(Windows) uint function(const(wchar)* param0);
alias PM_QUERY_PROC = extern(Windows) uint function(uint* param0, void** param1, uint* param2, uint* param3);
struct RPC_IMPORT_CONTEXT_P
{
    void* LookupContext;
    void* ProposedHandle;
    RPC_BINDING_VECTOR* Bindings;
}

struct RemHGLOBAL
{
    int fNullHGlobal;
    uint cbData;
    ubyte data;
}

struct RemHMETAFILEPICT
{
    int mm;
    int xExt;
    int yExt;
    uint cbData;
    ubyte data;
}

struct RemHENHMETAFILE
{
    uint cbData;
    ubyte data;
}

struct RemHBITMAP
{
    uint cbData;
    ubyte data;
}

struct RemHPALETTE
{
    uint cbData;
    ubyte data;
}

struct RemBRUSH
{
    uint cbData;
    ubyte data;
}

struct userCLIPFORMAT
{
    int fContext;
    _u_e__Struct u;
}

struct GDI_NONREMOTE
{
    int fContext;
    _u_e__Struct u;
}

struct userHGLOBAL
{
    int fContext;
    _u_e__Struct u;
}

struct userHMETAFILE
{
    int fContext;
    _u_e__Struct u;
}

struct remoteMETAFILEPICT
{
    int mm;
    int xExt;
    int yExt;
    userHMETAFILE* hMF;
}

struct userHMETAFILEPICT
{
    int fContext;
    _u_e__Struct u;
}

struct userHENHMETAFILE
{
    int fContext;
    _u_e__Struct u;
}

struct userBITMAP
{
    int bmType;
    int bmWidth;
    int bmHeight;
    int bmWidthBytes;
    ushort bmPlanes;
    ushort bmBitsPixel;
    uint cbSize;
    ubyte pBuffer;
}

struct userHBITMAP
{
    int fContext;
    _u_e__Struct u;
}

struct userHPALETTE
{
    int fContext;
    _u_e__Struct u;
}

struct RemotableHandle
{
    int fContext;
    _u_e__Struct u;
}

struct CY
{
    _Anonymous_e__Struct Anonymous;
    long int64;
}

struct DECIMAL
{
    ushort wReserved;
    _Anonymous1_e__Union Anonymous1;
    uint Hi32;
    _Anonymous2_e__Union Anonymous2;
}

struct BSTRBLOB
{
    uint cbSize;
    ubyte* pData;
}

struct CLIPDATA
{
    uint cbSize;
    int ulClipFmt;
    ubyte* pClipData;
}

struct uCLSSPEC
{
    uint tyspec;
    _tagged_union_e__Struct tagged_union;
}

struct STORAGE_HOTPLUG_INFO
{
    uint Size;
    ubyte MediaRemovable;
    ubyte MediaHotplug;
    ubyte DeviceHotplug;
    ubyte WriteCacheEnableOverride;
}

struct STORAGE_DEVICE_NUMBER
{
    uint DeviceType;
    uint DeviceNumber;
    uint PartitionNumber;
}

struct STORAGE_DEVICE_NUMBERS
{
    uint Version;
    uint Size;
    uint NumberOfDevices;
    STORAGE_DEVICE_NUMBER Devices;
}

struct STORAGE_DEVICE_NUMBER_EX
{
    uint Version;
    uint Size;
    uint Flags;
    uint DeviceType;
    uint DeviceNumber;
    Guid DeviceGuid;
    uint PartitionNumber;
}

struct STORAGE_BUS_RESET_REQUEST
{
    ubyte PathId;
}

struct STORAGE_BREAK_RESERVATION_REQUEST
{
    uint Length;
    ubyte _unused;
    ubyte PathId;
    ubyte TargetId;
    ubyte Lun;
}

struct PREVENT_MEDIA_REMOVAL
{
    ubyte PreventMediaRemoval;
}

struct CLASS_MEDIA_CHANGE_CONTEXT
{
    uint MediaChangeCount;
    uint NewState;
}

struct TAPE_STATISTICS
{
    uint Version;
    uint Flags;
    LARGE_INTEGER RecoveredWrites;
    LARGE_INTEGER UnrecoveredWrites;
    LARGE_INTEGER RecoveredReads;
    LARGE_INTEGER UnrecoveredReads;
    ubyte CompressionRatioReads;
    ubyte CompressionRatioWrites;
}

struct TAPE_GET_STATISTICS
{
    uint Operation;
}

enum STORAGE_MEDIA_TYPE
{
    DDS_4mm = 32,
    MiniQic = 33,
    Travan = 34,
    QIC = 35,
    MP_8mm = 36,
    AME_8mm = 37,
    AIT1_8mm = 38,
    DLT = 39,
    NCTP = 40,
    IBM_3480 = 41,
    IBM_3490E = 42,
    IBM_Magstar_3590 = 43,
    IBM_Magstar_MP = 44,
    STK_DATA_D3 = 45,
    SONY_DTF = 46,
    DV_6mm = 47,
    DMI = 48,
    SONY_D2 = 49,
    CLEANER_CARTRIDGE = 50,
    CD_ROM = 51,
    CD_R = 52,
    CD_RW = 53,
    DVD_ROM = 54,
    DVD_R = 55,
    DVD_RW = 56,
    MO_3_RW = 57,
    MO_5_WO = 58,
    MO_5_RW = 59,
    MO_5_LIMDOW = 60,
    PC_5_WO = 61,
    PC_5_RW = 62,
    PD_5_RW = 63,
    ABL_5_WO = 64,
    PINNACLE_APEX_5_RW = 65,
    SONY_12_WO = 66,
    PHILIPS_12_WO = 67,
    HITACHI_12_WO = 68,
    CYGNET_12_WO = 69,
    KODAK_14_WO = 70,
    MO_NFR_525 = 71,
    NIKON_12_RW = 72,
    IOMEGA_ZIP = 73,
    IOMEGA_JAZ = 74,
    SYQUEST_EZ135 = 75,
    SYQUEST_EZFLYER = 76,
    SYQUEST_SYJET = 77,
    AVATAR_F2 = 78,
    MP2_8mm = 79,
    DST_S = 80,
    DST_M = 81,
    DST_L = 82,
    VXATape_1 = 83,
    VXATape_2 = 84,
    STK_9840 = 85,
    LTO_Ultrium = 86,
    LTO_Accelis = 87,
    DVD_RAM = 88,
    AIT_8mm = 89,
    ADR_1 = 90,
    ADR_2 = 91,
    STK_9940 = 92,
    SAIT = 93,
    VXATape = 94,
}

enum STORAGE_BUS_TYPE
{
    BusTypeUnknown = 0,
    BusTypeScsi = 1,
    BusTypeAtapi = 2,
    BusTypeAta = 3,
    BusType1394 = 4,
    BusTypeSsa = 5,
    BusTypeFibre = 6,
    BusTypeUsb = 7,
    BusTypeRAID = 8,
    BusTypeiScsi = 9,
    BusTypeSas = 10,
    BusTypeSata = 11,
    BusTypeSd = 12,
    BusTypeMmc = 13,
    BusTypeVirtual = 14,
    BusTypeFileBackedVirtual = 15,
    BusTypeSpaces = 16,
    BusTypeNvme = 17,
    BusTypeSCM = 18,
    BusTypeUfs = 19,
    BusTypeMax = 20,
    BusTypeMaxReserved = 127,
}

struct DEVICE_MEDIA_INFO
{
    _DeviceSpecific_e__Union DeviceSpecific;
}

struct GET_MEDIA_TYPES
{
    uint DeviceType;
    uint MediaInfoCount;
    DEVICE_MEDIA_INFO MediaInfo;
}

struct STORAGE_PREDICT_FAILURE
{
    uint PredictFailure;
    ubyte VendorSpecific;
}

struct STORAGE_FAILURE_PREDICTION_CONFIG
{
    uint Version;
    uint Size;
    ubyte Set;
    ubyte Enabled;
    ushort Reserved;
}

enum STORAGE_SET_TYPE
{
    PropertyStandardSet = 0,
    PropertyExistsSet = 1,
    PropertySetMaxDefined = 2,
}

struct STORAGE_PROPERTY_SET
{
    STORAGE_PROPERTY_ID PropertyId;
    STORAGE_SET_TYPE SetType;
    ubyte AdditionalParameters;
}

enum STORAGE_IDENTIFIER_CODE_SET
{
    StorageIdCodeSetReserved = 0,
    StorageIdCodeSetBinary = 1,
    StorageIdCodeSetAscii = 2,
    StorageIdCodeSetUtf8 = 3,
}

enum STORAGE_IDENTIFIER_TYPE
{
    StorageIdTypeVendorSpecific = 0,
    StorageIdTypeVendorId = 1,
    StorageIdTypeEUI64 = 2,
    StorageIdTypeFCPHName = 3,
    StorageIdTypePortRelative = 4,
    StorageIdTypeTargetPortGroup = 5,
    StorageIdTypeLogicalUnitGroup = 6,
    StorageIdTypeMD5LogicalUnitIdentifier = 7,
    StorageIdTypeScsiNameString = 8,
}

enum STORAGE_ID_NAA_FORMAT
{
    StorageIdNAAFormatIEEEExtended = 2,
    StorageIdNAAFormatIEEERegistered = 3,
    StorageIdNAAFormatIEEEERegisteredExtended = 5,
}

enum STORAGE_ASSOCIATION_TYPE
{
    StorageIdAssocDevice = 0,
    StorageIdAssocPort = 1,
    StorageIdAssocTarget = 2,
}

struct STORAGE_IDENTIFIER
{
    STORAGE_IDENTIFIER_CODE_SET CodeSet;
    STORAGE_IDENTIFIER_TYPE Type;
    ushort IdentifierSize;
    ushort NextOffset;
    STORAGE_ASSOCIATION_TYPE Association;
    ubyte Identifier;
}

struct STORAGE_LB_PROVISIONING_MAP_RESOURCES
{
    uint Size;
    uint Version;
    ubyte _bitfield1;
    ubyte Reserved1;
    ubyte _bitfield2;
    ubyte Reserved3;
    ulong AvailableMappingResources;
    ulong UsedMappingResources;
}

enum STORAGE_RPMB_FRAME_TYPE
{
    StorageRpmbFrameTypeUnknown = 0,
    StorageRpmbFrameTypeStandard = 1,
    StorageRpmbFrameTypeMax = 2,
}

struct STORAGE_RPMB_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint SizeInBytes;
    uint MaxReliableWriteSizeInBytes;
    STORAGE_RPMB_FRAME_TYPE FrameFormat;
}

enum STORAGE_CRYPTO_ALGORITHM_ID
{
    StorageCryptoAlgorithmUnknown = 0,
    StorageCryptoAlgorithmXTSAES = 1,
    StorageCryptoAlgorithmBitlockerAESCBC = 2,
    StorageCryptoAlgorithmAESECB = 3,
    StorageCryptoAlgorithmESSIVAESCBC = 4,
    StorageCryptoAlgorithmMax = 5,
}

enum STORAGE_CRYPTO_KEY_SIZE
{
    StorageCryptoKeySizeUnknown = 0,
    StorageCryptoKeySize128Bits = 1,
    StorageCryptoKeySize192Bits = 2,
    StorageCryptoKeySize256Bits = 3,
    StorageCryptoKeySize512Bits = 4,
}

struct STORAGE_CRYPTO_CAPABILITY
{
    uint Version;
    uint Size;
    uint CryptoCapabilityIndex;
    STORAGE_CRYPTO_ALGORITHM_ID AlgorithmId;
    STORAGE_CRYPTO_KEY_SIZE KeySize;
    uint DataUnitSizeBitmask;
}

struct STORAGE_CRYPTO_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint NumKeysSupported;
    uint NumCryptoCapabilities;
    STORAGE_CRYPTO_CAPABILITY CryptoCapabilities;
}

enum STORAGE_TIER_MEDIA_TYPE
{
    StorageTierMediaTypeUnspecified = 0,
    StorageTierMediaTypeDisk = 1,
    StorageTierMediaTypeSsd = 2,
    StorageTierMediaTypeScm = 4,
    StorageTierMediaTypeMax = 5,
}

enum STORAGE_TIER_CLASS
{
    StorageTierClassUnspecified = 0,
    StorageTierClassCapacity = 1,
    StorageTierClassPerformance = 2,
    StorageTierClassMax = 3,
}

struct STORAGE_TIER
{
    Guid Id;
    ushort Name;
    ushort Description;
    ulong Flags;
    ulong ProvisionedCapacity;
    STORAGE_TIER_MEDIA_TYPE MediaType;
    STORAGE_TIER_CLASS Class;
}

struct STORAGE_DEVICE_TIERING_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint Flags;
    uint TotalNumberOfTiers;
    uint NumberOfTiersReturned;
    STORAGE_TIER Tiers;
}

struct STORAGE_DEVICE_FAULT_DOMAIN_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint NumberOfFaultDomains;
    Guid FaultDomainIds;
}

enum STORAGE_PROTOCOL_UFS_DATA_TYPE
{
    UfsDataTypeUnknown = 0,
    UfsDataTypeQueryDescriptor = 1,
    UfsDataTypeMax = 2,
}

struct STORAGE_PROTOCOL_SPECIFIC_DATA_EXT
{
    STORAGE_PROTOCOL_TYPE ProtocolType;
    uint DataType;
    uint ProtocolDataValue;
    uint ProtocolDataSubValue;
    uint ProtocolDataOffset;
    uint ProtocolDataLength;
    uint FixedProtocolReturnData;
    uint ProtocolDataSubValue2;
    uint ProtocolDataSubValue3;
    uint ProtocolDataSubValue4;
    uint ProtocolDataSubValue5;
    uint Reserved;
}

struct STORAGE_PROTOCOL_DATA_DESCRIPTOR_EXT
{
    uint Version;
    uint Size;
    STORAGE_PROTOCOL_SPECIFIC_DATA_EXT ProtocolSpecificData;
}

enum STORAGE_DISK_HEALTH_STATUS
{
    DiskHealthUnknown = 0,
    DiskHealthUnhealthy = 1,
    DiskHealthWarning = 2,
    DiskHealthHealthy = 3,
    DiskHealthMax = 4,
}

enum STORAGE_DISK_OPERATIONAL_STATUS
{
    DiskOpStatusNone = 0,
    DiskOpStatusUnknown = 1,
    DiskOpStatusOk = 2,
    DiskOpStatusPredictingFailure = 3,
    DiskOpStatusInService = 4,
    DiskOpStatusHardwareError = 5,
    DiskOpStatusNotUsable = 6,
    DiskOpStatusTransientError = 7,
    DiskOpStatusMissing = 8,
}

enum STORAGE_OPERATIONAL_STATUS_REASON
{
    DiskOpReasonUnknown = 0,
    DiskOpReasonScsiSenseCode = 1,
    DiskOpReasonMedia = 2,
    DiskOpReasonIo = 3,
    DiskOpReasonThresholdExceeded = 4,
    DiskOpReasonLostData = 5,
    DiskOpReasonEnergySource = 6,
    DiskOpReasonConfiguration = 7,
    DiskOpReasonDeviceController = 8,
    DiskOpReasonMediaController = 9,
    DiskOpReasonComponent = 10,
    DiskOpReasonNVDIMM_N = 11,
    DiskOpReasonBackgroundOperation = 12,
    DiskOpReasonInvalidFirmware = 13,
    DiskOpReasonHealthCheck = 14,
    DiskOpReasonLostDataPersistence = 15,
    DiskOpReasonDisabledByPlatform = 16,
    DiskOpReasonLostWritePersistence = 17,
    DiskOpReasonDataPersistenceLossImminent = 18,
    DiskOpReasonWritePersistenceLossImminent = 19,
    DiskOpReasonMax = 20,
}

struct STORAGE_OPERATIONAL_REASON
{
    uint Version;
    uint Size;
    STORAGE_OPERATIONAL_STATUS_REASON Reason;
    _RawBytes_e__Union RawBytes;
}

struct STORAGE_DEVICE_MANAGEMENT_STATUS
{
    uint Version;
    uint Size;
    STORAGE_DISK_HEALTH_STATUS Health;
    uint NumberOfOperationalStatus;
    uint NumberOfAdditionalReasons;
    STORAGE_DISK_OPERATIONAL_STATUS OperationalStatus;
    STORAGE_OPERATIONAL_REASON AdditionalReasons;
}

enum STORAGE_ZONED_DEVICE_TYPES
{
    ZonedDeviceTypeUnknown = 0,
    ZonedDeviceTypeHostManaged = 1,
    ZonedDeviceTypeHostAware = 2,
    ZonedDeviceTypeDeviceManaged = 3,
}

enum STORAGE_ZONE_TYPES
{
    ZoneTypeUnknown = 0,
    ZoneTypeConventional = 1,
    ZoneTypeSequentialWriteRequired = 2,
    ZoneTypeSequentialWritePreferred = 3,
    ZoneTypeMax = 4,
}

struct STORAGE_ZONE_GROUP
{
    uint ZoneCount;
    STORAGE_ZONE_TYPES ZoneType;
    ulong ZoneSize;
}

struct STORAGE_ZONED_DEVICE_DESCRIPTOR
{
    uint Version;
    uint Size;
    STORAGE_ZONED_DEVICE_TYPES DeviceType;
    uint ZoneCount;
    _ZoneAttributes_e__Union ZoneAttributes;
    uint ZoneGroupCount;
    STORAGE_ZONE_GROUP ZoneGroup;
}

struct DEVICE_LOCATION
{
    uint Socket;
    uint Slot;
    uint Adapter;
    uint Port;
    _Anonymous_e__Union Anonymous;
}

struct STORAGE_DEVICE_LOCATION_DESCRIPTOR
{
    uint Version;
    uint Size;
    DEVICE_LOCATION Location;
    uint StringOffset;
}

struct STORAGE_DEVICE_NUMA_PROPERTY
{
    uint Version;
    uint Size;
    uint NumaNode;
}

struct STORAGE_DEVICE_UNSAFE_SHUTDOWN_COUNT
{
    uint Version;
    uint Size;
    uint UnsafeShutdownCount;
}

struct STORAGE_HW_ENDURANCE_INFO
{
    uint ValidFields;
    uint GroupId;
    _Flags_e__Struct Flags;
    uint LifePercentage;
    ubyte BytesReadCount;
    ubyte ByteWriteCount;
}

struct STORAGE_HW_ENDURANCE_DATA_DESCRIPTOR
{
    uint Version;
    uint Size;
    STORAGE_HW_ENDURANCE_INFO EnduranceInfo;
}

struct DEVICE_DATA_SET_RANGE
{
    long StartingOffset;
    ulong LengthInBytes;
}

struct DEVICE_MANAGE_DATA_SET_ATTRIBUTES
{
    uint Size;
    uint Action;
    uint Flags;
    uint ParameterBlockOffset;
    uint ParameterBlockLength;
    uint DataSetRangesOffset;
    uint DataSetRangesLength;
}

struct DEVICE_MANAGE_DATA_SET_ATTRIBUTES_OUTPUT
{
    uint Size;
    uint Action;
    uint Flags;
    uint OperationStatus;
    uint ExtendedError;
    uint TargetDetailedError;
    uint ReservedStatus;
    uint OutputBlockOffset;
    uint OutputBlockLength;
}

struct DEVICE_DSM_DEFINITION
{
    uint Action;
    ubyte SingleRange;
    uint ParameterBlockAlignment;
    uint ParameterBlockLength;
    ubyte HasOutput;
    uint OutputBlockAlignment;
    uint OutputBlockLength;
}

struct DEVICE_DSM_NOTIFICATION_PARAMETERS
{
    uint Size;
    uint Flags;
    uint NumFileTypeIDs;
    Guid FileTypeID;
}

struct STORAGE_OFFLOAD_TOKEN
{
    ubyte TokenType;
    ubyte Reserved;
    ubyte TokenIdLength;
    _Anonymous_e__Union Anonymous;
}

struct DEVICE_DSM_OFFLOAD_READ_PARAMETERS
{
    uint Flags;
    uint TimeToLive;
    uint Reserved;
}

struct STORAGE_OFFLOAD_READ_OUTPUT
{
    uint OffloadReadFlags;
    uint Reserved;
    ulong LengthProtected;
    uint TokenLength;
    STORAGE_OFFLOAD_TOKEN Token;
}

struct DEVICE_DSM_OFFLOAD_WRITE_PARAMETERS
{
    uint Flags;
    uint Reserved;
    ulong TokenOffset;
    STORAGE_OFFLOAD_TOKEN Token;
}

struct STORAGE_OFFLOAD_WRITE_OUTPUT
{
    uint OffloadWriteFlags;
    uint Reserved;
    ulong LengthCopied;
}

struct DEVICE_DATA_SET_LBP_STATE_PARAMETERS
{
    uint Version;
    uint Size;
    uint Flags;
    uint OutputVersion;
}

struct DEVICE_DATA_SET_LB_PROVISIONING_STATE
{
    uint Size;
    uint Version;
    ulong SlabSizeInBytes;
    uint SlabOffsetDeltaInBytes;
    uint SlabAllocationBitMapBitCount;
    uint SlabAllocationBitMapLength;
    uint SlabAllocationBitMap;
}

struct DEVICE_DATA_SET_LB_PROVISIONING_STATE_V2
{
    uint Size;
    uint Version;
    ulong SlabSizeInBytes;
    ulong SlabOffsetDeltaInBytes;
    uint SlabAllocationBitMapBitCount;
    uint SlabAllocationBitMapLength;
    uint SlabAllocationBitMap;
}

struct DEVICE_DATA_SET_REPAIR_PARAMETERS
{
    uint NumberOfRepairCopies;
    uint SourceCopy;
    uint RepairCopies;
}

struct DEVICE_DATA_SET_REPAIR_OUTPUT
{
    DEVICE_DATA_SET_RANGE ParityExtent;
}

struct DEVICE_DATA_SET_SCRUB_OUTPUT
{
    ulong BytesProcessed;
    ulong BytesRepaired;
    ulong BytesFailed;
}

struct DEVICE_DATA_SET_SCRUB_EX_OUTPUT
{
    ulong BytesProcessed;
    ulong BytesRepaired;
    ulong BytesFailed;
    DEVICE_DATA_SET_RANGE ParityExtent;
}

struct DEVICE_DSM_TIERING_QUERY_INPUT
{
    uint Version;
    uint Size;
    uint Flags;
    uint NumberOfTierIds;
    Guid TierIds;
}

struct STORAGE_TIER_REGION
{
    Guid TierId;
    ulong Offset;
    ulong Length;
}

struct DEVICE_DSM_TIERING_QUERY_OUTPUT
{
    uint Version;
    uint Size;
    uint Flags;
    uint Reserved;
    ulong Alignment;
    uint TotalNumberOfRegions;
    uint NumberOfRegionsReturned;
    STORAGE_TIER_REGION Regions;
}

struct DEVICE_DSM_NVCACHE_CHANGE_PRIORITY_PARAMETERS
{
    uint Size;
    ubyte TargetPriority;
    ubyte Reserved;
}

struct DEVICE_DATA_SET_TOPOLOGY_ID_QUERY_OUTPUT
{
    ulong TopologyRangeBytes;
    ubyte TopologyId;
}

struct DEVICE_STORAGE_ADDRESS_RANGE
{
    long StartAddress;
    ulong LengthInBytes;
}

struct DEVICE_DSM_PHYSICAL_ADDRESSES_OUTPUT
{
    uint Version;
    uint Flags;
    uint TotalNumberOfRanges;
    uint NumberOfRangesReturned;
    DEVICE_STORAGE_ADDRESS_RANGE Ranges;
}

struct DEVICE_DSM_REPORT_ZONES_PARAMETERS
{
    uint Size;
    ubyte ReportOption;
    ubyte Partial;
    ubyte Reserved;
}

enum STORAGE_ZONES_ATTRIBUTES
{
    ZonesAttributeTypeAndLengthMayDifferent = 0,
    ZonesAttributeTypeSameLengthSame = 1,
    ZonesAttributeTypeSameLastZoneLengthDifferent = 2,
    ZonesAttributeTypeMayDifferentLengthSame = 3,
}

enum STORAGE_ZONE_CONDITION
{
    ZoneConditionConventional = 0,
    ZoneConditionEmpty = 1,
    ZoneConditionImplicitlyOpened = 2,
    ZoneConditionExplicitlyOpened = 3,
    ZoneConditionClosed = 4,
    ZoneConditionReadOnly = 13,
    ZoneConditionFull = 14,
    ZoneConditionOffline = 15,
}

struct STORAGE_ZONE_DESCRIPTOR
{
    uint Size;
    STORAGE_ZONE_TYPES ZoneType;
    STORAGE_ZONE_CONDITION ZoneCondition;
    ubyte ResetWritePointerRecommend;
    ubyte Reserved0;
    ulong ZoneSize;
    ulong WritePointerOffset;
}

struct DEVICE_DSM_REPORT_ZONES_DATA
{
    uint Size;
    uint ZoneCount;
    STORAGE_ZONES_ATTRIBUTES Attributes;
    uint Reserved0;
    STORAGE_ZONE_DESCRIPTOR ZoneDescriptors;
}

struct DEVICE_STORAGE_RANGE_ATTRIBUTES
{
    ulong LengthInBytes;
    _Anonymous_e__Union Anonymous;
    uint Reserved;
}

struct DEVICE_DSM_RANGE_ERROR_INFO
{
    uint Version;
    uint Flags;
    uint TotalNumberOfRanges;
    uint NumberOfRangesReturned;
    DEVICE_STORAGE_RANGE_ATTRIBUTES Ranges;
}

struct DEVICE_DSM_LOST_QUERY_PARAMETERS
{
    uint Version;
    ulong Granularity;
}

struct DEVICE_DSM_LOST_QUERY_OUTPUT
{
    uint Version;
    uint Size;
    ulong Alignment;
    uint NumberOfBits;
    uint BitMap;
}

struct DEVICE_DSM_FREE_SPACE_OUTPUT
{
    uint Version;
    ulong FreeSpace;
}

struct DEVICE_DSM_CONVERSION_OUTPUT
{
    uint Version;
    Guid Source;
}

struct STORAGE_GET_BC_PROPERTIES_OUTPUT
{
    uint MaximumRequestsPerPeriod;
    uint MinimumPeriod;
    ulong MaximumRequestSize;
    uint EstimatedTimePerRequest;
    uint NumOutStandingRequests;
    ulong RequestSize;
}

struct STORAGE_ALLOCATE_BC_STREAM_INPUT
{
    uint Version;
    uint RequestsPerPeriod;
    uint Period;
    ubyte RetryFailures;
    ubyte Discardable;
    ubyte Reserved1;
    uint AccessType;
    uint AccessMode;
}

struct STORAGE_ALLOCATE_BC_STREAM_OUTPUT
{
    ulong RequestSize;
    uint NumOutStandingRequests;
}

struct STORAGE_PRIORITY_HINT_SUPPORT
{
    uint SupportFlags;
}

enum STORAGE_DIAGNOSTIC_LEVEL
{
    StorageDiagnosticLevelDefault = 0,
    StorageDiagnosticLevelMax = 1,
}

enum STORAGE_DIAGNOSTIC_TARGET_TYPE
{
    StorageDiagnosticTargetTypeUndefined = 0,
    StorageDiagnosticTargetTypePort = 1,
    StorageDiagnosticTargetTypeMiniport = 2,
    StorageDiagnosticTargetTypeHbaFirmware = 3,
    StorageDiagnosticTargetTypeMax = 4,
}

struct STORAGE_DIAGNOSTIC_REQUEST
{
    uint Version;
    uint Size;
    uint Reserved;
    STORAGE_DIAGNOSTIC_TARGET_TYPE TargetType;
    STORAGE_DIAGNOSTIC_LEVEL Level;
}

struct STORAGE_DIAGNOSTIC_DATA
{
    uint Version;
    uint Size;
    Guid ProviderId;
    uint BufferSize;
    uint Reserved;
    ubyte DiagnosticDataBuffer;
}

struct PHYSICAL_ELEMENT_STATUS_REQUEST
{
    uint Version;
    uint Size;
    uint StartingElement;
    ubyte Filter;
    ubyte ReportType;
    ubyte Reserved;
}

struct PHYSICAL_ELEMENT_STATUS_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint ElementIdentifier;
    ubyte PhysicalElementType;
    ubyte PhysicalElementHealth;
    ubyte Reserved1;
    ulong AssociatedCapacity;
    uint Reserved2;
}

struct PHYSICAL_ELEMENT_STATUS
{
    uint Version;
    uint Size;
    uint DescriptorCount;
    uint ReturnedDescriptorCount;
    uint ElementIdentifierBeingDepoped;
    uint Reserved;
    PHYSICAL_ELEMENT_STATUS_DESCRIPTOR Descriptors;
}

struct REMOVE_ELEMENT_AND_TRUNCATE_REQUEST
{
    uint Version;
    uint Size;
    ulong RequestCapacity;
    uint ElementIdentifier;
    uint Reserved;
}

enum DEVICE_INTERNAL_STATUS_DATA_REQUEST_TYPE
{
    DeviceInternalStatusDataRequestTypeUndefined = 0,
    DeviceCurrentInternalStatusDataHeader = 1,
    DeviceCurrentInternalStatusData = 2,
}

enum DEVICE_INTERNAL_STATUS_DATA_SET
{
    DeviceStatusDataSetUndefined = 0,
    DeviceStatusDataSet1 = 1,
    DeviceStatusDataSet2 = 2,
    DeviceStatusDataSet3 = 3,
    DeviceStatusDataSet4 = 4,
    DeviceStatusDataSetMax = 5,
}

struct GET_DEVICE_INTERNAL_STATUS_DATA_REQUEST
{
    uint Version;
    uint Size;
    DEVICE_INTERNAL_STATUS_DATA_REQUEST_TYPE RequestDataType;
    DEVICE_INTERNAL_STATUS_DATA_SET RequestDataSet;
}

struct DEVICE_INTERNAL_STATUS_DATA
{
    uint Version;
    uint Size;
    ulong T10VendorId;
    uint DataSet1Length;
    uint DataSet2Length;
    uint DataSet3Length;
    uint DataSet4Length;
    ubyte StatusDataVersion;
    ubyte Reserved;
    ubyte ReasonIdentifier;
    uint StatusDataLength;
    ubyte StatusData;
}

struct STORAGE_MEDIA_SERIAL_NUMBER_DATA
{
    ushort Reserved;
    ushort SerialNumberLength;
    ubyte SerialNumber;
}

struct STORAGE_READ_CAPACITY
{
    uint Version;
    uint Size;
    uint BlockLength;
    LARGE_INTEGER NumberOfBlocks;
    LARGE_INTEGER DiskLength;
}

struct PERSISTENT_RESERVE_COMMAND
{
    uint Version;
    uint Size;
    _Anonymous_e__Union Anonymous;
}

enum _DEVICEDUMP_COLLECTION_TYPE
{
    TCCollectionBugCheck = 1,
    TCCollectionApplicationRequested = 2,
    TCCollectionDeviceRequested = 3,
}

struct DEVICEDUMP_SUBSECTION_POINTER
{
    uint dwSize;
    uint dwFlags;
    uint dwOffset;
}

struct DEVICEDUMP_STRUCTURE_VERSION
{
    uint dwSignature;
    uint dwVersion;
    uint dwSize;
}

struct DEVICEDUMP_SECTION_HEADER
{
    Guid guidDeviceDataId;
    ubyte sOrganizationID;
    uint dwFirmwareRevision;
    ubyte sModelNumber;
    ubyte szDeviceManufacturingID;
    uint dwFlags;
    uint bRestrictedPrivateDataVersion;
    uint dwFirmwareIssueId;
    ubyte szIssueDescriptionString;
}

struct GP_LOG_PAGE_DESCRIPTOR
{
    ushort LogAddress;
    ushort LogSectors;
}

struct DEVICEDUMP_PUBLIC_SUBSECTION
{
    uint dwFlags;
    GP_LOG_PAGE_DESCRIPTOR GPLogTable;
    byte szDescription;
    ubyte bData;
}

struct DEVICEDUMP_RESTRICTED_SUBSECTION
{
    ubyte bData;
}

struct DEVICEDUMP_PRIVATE_SUBSECTION
{
    uint dwFlags;
    GP_LOG_PAGE_DESCRIPTOR GPLogId;
    ubyte bData;
}

struct DEVICEDUMP_STORAGEDEVICE_DATA
{
    DEVICEDUMP_STRUCTURE_VERSION Descriptor;
    DEVICEDUMP_SECTION_HEADER SectionHeader;
    uint dwBufferSize;
    uint dwReasonForCollection;
    DEVICEDUMP_SUBSECTION_POINTER PublicData;
    DEVICEDUMP_SUBSECTION_POINTER RestrictedData;
    DEVICEDUMP_SUBSECTION_POINTER PrivateData;
}

struct DEVICEDUMP_STORAGESTACK_PUBLIC_STATE_RECORD
{
    ubyte Cdb;
    ubyte Command;
    ulong StartTime;
    ulong EndTime;
    uint OperationStatus;
    uint OperationError;
    _StackSpecific_e__Union StackSpecific;
}

struct DEVICEDUMP_STORAGESTACK_PUBLIC_DUMP
{
    DEVICEDUMP_STRUCTURE_VERSION Descriptor;
    uint dwReasonForCollection;
    ubyte cDriverName;
    uint uiNumRecords;
    DEVICEDUMP_STORAGESTACK_PUBLIC_STATE_RECORD RecordArray;
}

struct STORAGE_IDLE_POWER
{
    uint Version;
    uint Size;
    uint _bitfield;
    uint D3IdleTimeout;
}

enum STORAGE_POWERUP_REASON_TYPE
{
    StoragePowerupUnknown = 0,
    StoragePowerupIO = 1,
    StoragePowerupDeviceAttention = 2,
}

struct STORAGE_IDLE_POWERUP_REASON
{
    uint Version;
    uint Size;
    STORAGE_POWERUP_REASON_TYPE PowerupReason;
}

struct STORAGE_RPMB_DATA_FRAME
{
    ubyte Stuff;
    ubyte KeyOrMAC;
    ubyte Data;
    ubyte Nonce;
    ubyte WriteCounter;
    ubyte Address;
    ubyte BlockCount;
    ubyte OperationResult;
    ubyte RequestOrResponseType;
}

enum STORAGE_RPMB_COMMAND_TYPE
{
    StorRpmbProgramAuthKey = 1,
    StorRpmbQueryWriteCounter = 2,
    StorRpmbAuthenticatedWrite = 3,
    StorRpmbAuthenticatedRead = 4,
    StorRpmbReadResultRequest = 5,
    StorRpmbAuthenticatedDeviceConfigWrite = 6,
    StorRpmbAuthenticatedDeviceConfigRead = 7,
}

struct STORAGE_EVENT_NOTIFICATION
{
    uint Version;
    uint Size;
    ulong Events;
}

enum STORAGE_COUNTER_TYPE
{
    StorageCounterTypeUnknown = 0,
    StorageCounterTypeTemperatureCelsius = 1,
    StorageCounterTypeTemperatureCelsiusMax = 2,
    StorageCounterTypeReadErrorsTotal = 3,
    StorageCounterTypeReadErrorsCorrected = 4,
    StorageCounterTypeReadErrorsUncorrected = 5,
    StorageCounterTypeWriteErrorsTotal = 6,
    StorageCounterTypeWriteErrorsCorrected = 7,
    StorageCounterTypeWriteErrorsUncorrected = 8,
    StorageCounterTypeManufactureDate = 9,
    StorageCounterTypeStartStopCycleCount = 10,
    StorageCounterTypeStartStopCycleCountMax = 11,
    StorageCounterTypeLoadUnloadCycleCount = 12,
    StorageCounterTypeLoadUnloadCycleCountMax = 13,
    StorageCounterTypeWearPercentage = 14,
    StorageCounterTypeWearPercentageWarning = 15,
    StorageCounterTypeWearPercentageMax = 16,
    StorageCounterTypePowerOnHours = 17,
    StorageCounterTypeReadLatency100NSMax = 18,
    StorageCounterTypeWriteLatency100NSMax = 19,
    StorageCounterTypeFlushLatency100NSMax = 20,
    StorageCounterTypeMax = 21,
}

struct STORAGE_COUNTER
{
    STORAGE_COUNTER_TYPE Type;
    _Value_e__Union Value;
}

struct STORAGE_COUNTERS
{
    uint Version;
    uint Size;
    uint NumberOfCounters;
    STORAGE_COUNTER Counters;
}

struct STORAGE_HW_FIRMWARE_INFO_QUERY
{
    uint Version;
    uint Size;
    uint Flags;
    uint Reserved;
}

struct STORAGE_HW_FIRMWARE_SLOT_INFO
{
    uint Version;
    uint Size;
    ubyte SlotNumber;
    ubyte _bitfield;
    ubyte Reserved1;
    ubyte Revision;
}

struct STORAGE_HW_FIRMWARE_INFO
{
    uint Version;
    uint Size;
    ubyte _bitfield;
    ubyte SlotCount;
    ubyte ActiveSlot;
    ubyte PendingActivateSlot;
    ubyte FirmwareShared;
    ubyte Reserved;
    uint ImagePayloadAlignment;
    uint ImagePayloadMaxSize;
    STORAGE_HW_FIRMWARE_SLOT_INFO Slot;
}

struct STORAGE_HW_FIRMWARE_DOWNLOAD_V2
{
    uint Version;
    uint Size;
    uint Flags;
    ubyte Slot;
    ubyte Reserved;
    ulong Offset;
    ulong BufferSize;
    uint ImageSize;
    uint Reserved2;
    ubyte ImageBuffer;
}

enum STORAGE_ATTRIBUTE_MGMT_ACTION
{
    StorAttributeMgmt_ClearAttribute = 0,
    StorAttributeMgmt_SetAttribute = 1,
    StorAttributeMgmt_ResetAttribute = 2,
}

struct STORAGE_ATTRIBUTE_MGMT
{
    uint Version;
    uint Size;
    STORAGE_ATTRIBUTE_MGMT_ACTION Action;
    uint Attribute;
}

struct SCM_PD_HEALTH_NOTIFICATION_DATA
{
    Guid DeviceGuid;
}

struct SCM_LOGICAL_DEVICE_INSTANCE
{
    uint Version;
    uint Size;
    Guid DeviceGuid;
    ushort SymbolicLink;
}

struct SCM_LOGICAL_DEVICES
{
    uint Version;
    uint Size;
    uint DeviceCount;
    SCM_LOGICAL_DEVICE_INSTANCE Devices;
}

struct SCM_PHYSICAL_DEVICE_INSTANCE
{
    uint Version;
    uint Size;
    uint NfitHandle;
    ushort SymbolicLink;
}

struct SCM_PHYSICAL_DEVICES
{
    uint Version;
    uint Size;
    uint DeviceCount;
    SCM_PHYSICAL_DEVICE_INSTANCE Devices;
}

enum SCM_REGION_FLAG
{
    ScmRegionFlagNone = 0,
    ScmRegionFlagLabel = 1,
}

struct SCM_REGION
{
    uint Version;
    uint Size;
    uint Flags;
    uint NfitHandle;
    Guid LogicalDeviceGuid;
    Guid AddressRangeType;
    uint AssociatedId;
    ulong Length;
    ulong StartingDPA;
    ulong BaseSPA;
    ulong SPAOffset;
    ulong RegionOffset;
}

struct SCM_REGIONS
{
    uint Version;
    uint Size;
    uint RegionCount;
    SCM_REGION Regions;
}

struct SCM_INTERLEAVED_PD_INFO
{
    uint DeviceHandle;
    Guid DeviceGuid;
}

struct SCM_LD_INTERLEAVE_SET_INFO
{
    uint Version;
    uint Size;
    uint InterleaveSetSize;
    SCM_INTERLEAVED_PD_INFO InterleaveSet;
}

enum SCM_PD_QUERY_TYPE
{
    ScmPhysicalDeviceQuery_Descriptor = 0,
    ScmPhysicalDeviceQuery_IsSupported = 1,
    ScmPhysicalDeviceQuery_Max = 2,
}

enum SCM_PD_PROPERTY_ID
{
    ScmPhysicalDeviceProperty_DeviceInfo = 0,
    ScmPhysicalDeviceProperty_ManagementStatus = 1,
    ScmPhysicalDeviceProperty_FirmwareInfo = 2,
    ScmPhysicalDeviceProperty_LocationString = 3,
    ScmPhysicalDeviceProperty_DeviceSpecificInfo = 4,
    ScmPhysicalDeviceProperty_DeviceHandle = 5,
    ScmPhysicalDeviceProperty_Max = 6,
}

struct SCM_PD_PROPERTY_QUERY
{
    uint Version;
    uint Size;
    SCM_PD_PROPERTY_ID PropertyId;
    SCM_PD_QUERY_TYPE QueryType;
    ubyte AdditionalParameters;
}

struct SCM_PD_DESCRIPTOR_HEADER
{
    uint Version;
    uint Size;
}

struct SCM_PD_DEVICE_HANDLE
{
    uint Version;
    uint Size;
    Guid DeviceGuid;
    uint DeviceHandle;
}

struct SCM_PD_DEVICE_INFO
{
    uint Version;
    uint Size;
    Guid DeviceGuid;
    uint UnsafeShutdownCount;
    ulong PersistentMemorySizeInBytes;
    ulong VolatileMemorySizeInBytes;
    ulong TotalMemorySizeInBytes;
    uint SlotNumber;
    uint DeviceHandle;
    ushort PhysicalId;
    ubyte NumberOfFormatInterfaceCodes;
    ushort FormatInterfaceCodes;
    uint VendorId;
    uint ProductId;
    uint SubsystemDeviceId;
    uint SubsystemVendorId;
    ubyte ManufacturingLocation;
    ubyte ManufacturingWeek;
    ubyte ManufacturingYear;
    uint SerialNumber4Byte;
    uint SerialNumberLengthInChars;
    byte SerialNumber;
}

struct SCM_PD_DEVICE_SPECIFIC_PROPERTY
{
    ushort Name;
    long Value;
}

struct SCM_PD_DEVICE_SPECIFIC_INFO
{
    uint Version;
    uint Size;
    uint NumberOfProperties;
    SCM_PD_DEVICE_SPECIFIC_PROPERTY DeviceSpecificProperties;
}

struct SCM_PD_FIRMWARE_SLOT_INFO
{
    uint Version;
    uint Size;
    ubyte SlotNumber;
    ubyte _bitfield;
    ubyte Reserved1;
    ubyte Revision;
}

struct SCM_PD_FIRMWARE_INFO
{
    uint Version;
    uint Size;
    ubyte ActiveSlot;
    ubyte NextActiveSlot;
    ubyte SlotCount;
    SCM_PD_FIRMWARE_SLOT_INFO Slots;
}

enum SCM_PD_HEALTH_STATUS
{
    ScmPhysicalDeviceHealth_Unknown = 0,
    ScmPhysicalDeviceHealth_Unhealthy = 1,
    ScmPhysicalDeviceHealth_Warning = 2,
    ScmPhysicalDeviceHealth_Healthy = 3,
    ScmPhysicalDeviceHealth_Max = 4,
}

enum SCM_PD_OPERATIONAL_STATUS
{
    ScmPhysicalDeviceOpStatus_Unknown = 0,
    ScmPhysicalDeviceOpStatus_Ok = 1,
    ScmPhysicalDeviceOpStatus_PredictingFailure = 2,
    ScmPhysicalDeviceOpStatus_InService = 3,
    ScmPhysicalDeviceOpStatus_HardwareError = 4,
    ScmPhysicalDeviceOpStatus_NotUsable = 5,
    ScmPhysicalDeviceOpStatus_TransientError = 6,
    ScmPhysicalDeviceOpStatus_Missing = 7,
    ScmPhysicalDeviceOpStatus_Max = 8,
}

enum SCM_PD_OPERATIONAL_STATUS_REASON
{
    ScmPhysicalDeviceOpReason_Unknown = 0,
    ScmPhysicalDeviceOpReason_Media = 1,
    ScmPhysicalDeviceOpReason_ThresholdExceeded = 2,
    ScmPhysicalDeviceOpReason_LostData = 3,
    ScmPhysicalDeviceOpReason_EnergySource = 4,
    ScmPhysicalDeviceOpReason_Configuration = 5,
    ScmPhysicalDeviceOpReason_DeviceController = 6,
    ScmPhysicalDeviceOpReason_MediaController = 7,
    ScmPhysicalDeviceOpReason_Component = 8,
    ScmPhysicalDeviceOpReason_BackgroundOperation = 9,
    ScmPhysicalDeviceOpReason_InvalidFirmware = 10,
    ScmPhysicalDeviceOpReason_HealthCheck = 11,
    ScmPhysicalDeviceOpReason_LostDataPersistence = 12,
    ScmPhysicalDeviceOpReason_DisabledByPlatform = 13,
    ScmPhysicalDeviceOpReason_PermanentError = 14,
    ScmPhysicalDeviceOpReason_LostWritePersistence = 15,
    ScmPhysicalDeviceOpReason_FatalError = 16,
    ScmPhysicalDeviceOpReason_DataPersistenceLossImminent = 17,
    ScmPhysicalDeviceOpReason_WritePersistenceLossImminent = 18,
    ScmPhysicalDeviceOpReason_MediaRemainingSpareBlock = 19,
    ScmPhysicalDeviceOpReason_PerformanceDegradation = 20,
    ScmPhysicalDeviceOpReason_ExcessiveTemperature = 21,
    ScmPhysicalDeviceOpReason_Max = 22,
}

struct SCM_PD_MANAGEMENT_STATUS
{
    uint Version;
    uint Size;
    SCM_PD_HEALTH_STATUS Health;
    uint NumberOfOperationalStatus;
    uint NumberOfAdditionalReasons;
    SCM_PD_OPERATIONAL_STATUS OperationalStatus;
    SCM_PD_OPERATIONAL_STATUS_REASON AdditionalReasons;
}

struct SCM_PD_LOCATION_STRING
{
    uint Version;
    uint Size;
    ushort Location;
}

struct SCM_PD_FIRMWARE_DOWNLOAD
{
    uint Version;
    uint Size;
    uint Flags;
    ubyte Slot;
    ubyte Reserved;
    ulong Offset;
    uint FirmwareImageSizeInBytes;
    ubyte FirmwareImage;
}

struct SCM_PD_FIRMWARE_ACTIVATE
{
    uint Version;
    uint Size;
    uint Flags;
    ubyte Slot;
}

struct SCM_PD_PASSTHROUGH_INPUT
{
    uint Version;
    uint Size;
    Guid ProtocolGuid;
    uint DataSize;
    ubyte Data;
}

struct SCM_PD_PASSTHROUGH_OUTPUT
{
    uint Version;
    uint Size;
    Guid ProtocolGuid;
    uint DataSize;
    ubyte Data;
}

struct SCM_PD_PASSTHROUGH_INVDIMM_INPUT
{
    uint Opcode;
    uint OpcodeParametersLength;
    ubyte OpcodeParameters;
}

struct SCM_PD_PASSTHROUGH_INVDIMM_OUTPUT
{
    ushort GeneralStatus;
    ushort ExtendedStatus;
    uint OutputDataLength;
    ubyte OutputData;
}

struct SCM_PD_REINITIALIZE_MEDIA_INPUT
{
    uint Version;
    uint Size;
    _Options_e__Struct Options;
}

enum SCM_PD_MEDIA_REINITIALIZATION_STATUS
{
    ScmPhysicalDeviceReinit_Success = 0,
    ScmPhysicalDeviceReinit_RebootNeeded = 1,
    ScmPhysicalDeviceReinit_ColdBootNeeded = 2,
    ScmPhysicalDeviceReinit_Max = 3,
}

struct SCM_PD_REINITIALIZE_MEDIA_OUTPUT
{
    uint Version;
    uint Size;
    SCM_PD_MEDIA_REINITIALIZATION_STATUS Status;
}

struct SET_PARTITION_INFORMATION_EX
{
    PARTITION_STYLE PartitionStyle;
    _Anonymous_e__Union Anonymous;
}

enum DETECTION_TYPE
{
    DetectNone = 0,
    DetectInt13 = 1,
    DetectExInt13 = 2,
}

struct DISK_CONTROLLER_NUMBER
{
    uint ControllerNumber;
    uint DiskNumber;
}

enum DISK_CACHE_RETENTION_PRIORITY
{
    EqualPriority = 0,
    KeepPrefetchedData = 1,
    KeepReadData = 2,
}

struct HISTOGRAM_BUCKET
{
    uint Reads;
    uint Writes;
}

struct DISK_HISTOGRAM
{
    LARGE_INTEGER DiskSize;
    LARGE_INTEGER Start;
    LARGE_INTEGER End;
    LARGE_INTEGER Average;
    LARGE_INTEGER AverageRead;
    LARGE_INTEGER AverageWrite;
    uint Granularity;
    uint Size;
    uint ReadCount;
    uint WriteCount;
    HISTOGRAM_BUCKET* Histogram;
}

struct DISK_RECORD
{
    LARGE_INTEGER ByteOffset;
    LARGE_INTEGER StartTime;
    LARGE_INTEGER EndTime;
    void* VirtualAddress;
    uint NumberOfBytes;
    ubyte DeviceNumber;
    ubyte ReadRequest;
}

struct DISK_LOGGING
{
    ubyte Function;
    void* BufferAddress;
    uint BufferSize;
}

enum BIN_TYPES
{
    RequestSize = 0,
    RequestLocation = 1,
}

struct BIN_RANGE
{
    LARGE_INTEGER StartValue;
    LARGE_INTEGER Length;
}

struct PERF_BIN
{
    uint NumberOfBins;
    uint TypeOfBin;
    BIN_RANGE BinsRanges;
}

struct BIN_COUNT
{
    BIN_RANGE BinRange;
    uint BinCount;
}

struct BIN_RESULTS
{
    uint NumberOfBins;
    BIN_COUNT BinCounts;
}

struct GETVERSIONINPARAMS
{
    ubyte bVersion;
    ubyte bRevision;
    ubyte bReserved;
    ubyte bIDEDeviceMap;
    uint fCapabilities;
    uint dwReserved;
}

struct IDEREGS
{
    ubyte bFeaturesReg;
    ubyte bSectorCountReg;
    ubyte bSectorNumberReg;
    ubyte bCylLowReg;
    ubyte bCylHighReg;
    ubyte bDriveHeadReg;
    ubyte bCommandReg;
    ubyte bReserved;
}

struct SENDCMDINPARAMS
{
    uint cBufferSize;
    IDEREGS irDriveRegs;
    ubyte bDriveNumber;
    ubyte bReserved;
    uint dwReserved;
    ubyte bBuffer;
}

struct DRIVERSTATUS
{
    ubyte bDriverError;
    ubyte bIDEError;
    ubyte bReserved;
    uint dwReserved;
}

struct SENDCMDOUTPARAMS
{
    uint cBufferSize;
    DRIVERSTATUS DriverStatus;
    ubyte bBuffer;
}

enum ELEMENT_TYPE
{
    AllElements = 0,
    ChangerTransport = 1,
    ChangerSlot = 2,
    ChangerIEPort = 3,
    ChangerDrive = 4,
    ChangerDoor = 5,
    ChangerKeypad = 6,
    ChangerMaxElement = 7,
}

struct CHANGER_ELEMENT
{
    ELEMENT_TYPE ElementType;
    uint ElementAddress;
}

struct CHANGER_ELEMENT_LIST
{
    CHANGER_ELEMENT Element;
    uint NumberOfElements;
}

struct GET_CHANGER_PARAMETERS
{
    uint Size;
    ushort NumberTransportElements;
    ushort NumberStorageElements;
    ushort NumberCleanerSlots;
    ushort NumberIEElements;
    ushort NumberDataTransferElements;
    ushort NumberOfDoors;
    ushort FirstSlotNumber;
    ushort FirstDriveNumber;
    ushort FirstTransportNumber;
    ushort FirstIEPortNumber;
    ushort FirstCleanerSlotAddress;
    ushort MagazineSize;
    uint DriveCleanTimeout;
    uint Features0;
    uint Features1;
    ubyte MoveFromTransport;
    ubyte MoveFromSlot;
    ubyte MoveFromIePort;
    ubyte MoveFromDrive;
    ubyte ExchangeFromTransport;
    ubyte ExchangeFromSlot;
    ubyte ExchangeFromIePort;
    ubyte ExchangeFromDrive;
    ubyte LockUnlockCapabilities;
    ubyte PositionCapabilities;
    ubyte Reserved1;
    uint Reserved2;
}

struct CHANGER_PRODUCT_DATA
{
    ubyte VendorId;
    ubyte ProductId;
    ubyte Revision;
    ubyte SerialNumber;
    ubyte DeviceType;
}

struct CHANGER_SET_ACCESS
{
    CHANGER_ELEMENT Element;
    uint Control;
}

struct CHANGER_READ_ELEMENT_STATUS
{
    CHANGER_ELEMENT_LIST ElementList;
    ubyte VolumeTagInfo;
}

struct CHANGER_ELEMENT_STATUS
{
    CHANGER_ELEMENT Element;
    CHANGER_ELEMENT SrcElementAddress;
    uint Flags;
    uint ExceptionCode;
    ubyte TargetId;
    ubyte Lun;
    ushort Reserved;
    ubyte PrimaryVolumeID;
    ubyte AlternateVolumeID;
}

struct CHANGER_ELEMENT_STATUS_EX
{
    CHANGER_ELEMENT Element;
    CHANGER_ELEMENT SrcElementAddress;
    uint Flags;
    uint ExceptionCode;
    ubyte TargetId;
    ubyte Lun;
    ushort Reserved;
    ubyte PrimaryVolumeID;
    ubyte AlternateVolumeID;
    ubyte VendorIdentification;
    ubyte ProductIdentification;
    ubyte SerialNumber;
}

struct CHANGER_INITIALIZE_ELEMENT_STATUS
{
    CHANGER_ELEMENT_LIST ElementList;
    ubyte BarCodeScan;
}

struct CHANGER_SET_POSITION
{
    CHANGER_ELEMENT Transport;
    CHANGER_ELEMENT Destination;
    ubyte Flip;
}

struct CHANGER_EXCHANGE_MEDIUM
{
    CHANGER_ELEMENT Transport;
    CHANGER_ELEMENT Source;
    CHANGER_ELEMENT Destination1;
    CHANGER_ELEMENT Destination2;
    ubyte Flip1;
    ubyte Flip2;
}

struct CHANGER_MOVE_MEDIUM
{
    CHANGER_ELEMENT Transport;
    CHANGER_ELEMENT Source;
    CHANGER_ELEMENT Destination;
    ubyte Flip;
}

struct CHANGER_SEND_VOLUME_TAG_INFORMATION
{
    CHANGER_ELEMENT StartingElement;
    uint ActionCode;
    ubyte VolumeIDTemplate;
}

struct READ_ELEMENT_ADDRESS_INFO
{
    uint NumberOfElements;
    CHANGER_ELEMENT_STATUS ElementStatus;
}

enum CHANGER_DEVICE_PROBLEM_TYPE
{
    DeviceProblemNone = 0,
    DeviceProblemHardware = 1,
    DeviceProblemCHMError = 2,
    DeviceProblemDoorOpen = 3,
    DeviceProblemCalibrationError = 4,
    DeviceProblemTargetFailure = 5,
    DeviceProblemCHMMoveError = 6,
    DeviceProblemCHMZeroError = 7,
    DeviceProblemCartridgeInsertError = 8,
    DeviceProblemPositionError = 9,
    DeviceProblemSensorError = 10,
    DeviceProblemCartridgeEjectError = 11,
    DeviceProblemGripperError = 12,
    DeviceProblemDriveError = 13,
}

struct PATHNAME_BUFFER
{
    uint PathNameLength;
    ushort Name;
}

struct FSCTL_QUERY_FAT_BPB_BUFFER
{
    ubyte First0x24BytesOfBootSector;
}

struct REFS_VOLUME_DATA_BUFFER
{
    uint ByteCount;
    uint MajorVersion;
    uint MinorVersion;
    uint BytesPerPhysicalSector;
    LARGE_INTEGER VolumeSerialNumber;
    LARGE_INTEGER NumberSectors;
    LARGE_INTEGER TotalClusters;
    LARGE_INTEGER FreeClusters;
    LARGE_INTEGER TotalReserved;
    uint BytesPerSector;
    uint BytesPerCluster;
    LARGE_INTEGER MaximumSizeOfResidentFile;
    ushort FastTierDataFillRatio;
    ushort SlowTierDataFillRatio;
    uint DestagesFastTierToSlowTierRate;
    LARGE_INTEGER Reserved;
}

struct STARTING_LCN_INPUT_BUFFER_EX
{
    LARGE_INTEGER StartingLcn;
    uint Flags;
}

struct RETRIEVAL_POINTERS_AND_REFCOUNT_BUFFER
{
    uint ExtentCount;
    LARGE_INTEGER StartingVcn;
    _Anonymous_e__Struct Extents;
}

struct RETRIEVAL_POINTER_COUNT
{
    uint ExtentCount;
}

struct MOVE_FILE_RECORD_DATA
{
    HANDLE FileHandle;
    LARGE_INTEGER SourceFileRecord;
    LARGE_INTEGER TargetFileRecord;
}

struct USN_RECORD_UNION
{
    USN_RECORD_COMMON_HEADER Header;
    USN_RECORD_V2 V2;
    USN_RECORD_V3 V3;
    USN_RECORD_V4 V4;
}

struct BULK_SECURITY_TEST_DATA
{
    uint DesiredAccess;
    uint SecurityIds;
}

struct FILE_PREFETCH
{
    uint Type;
    uint Count;
    ulong Prefetch;
}

struct FILE_PREFETCH_EX
{
    uint Type;
    uint Count;
    void* Context;
    ulong Prefetch;
}

struct FILE_ZERO_DATA_INFORMATION_EX
{
    LARGE_INTEGER FileOffset;
    LARGE_INTEGER BeyondFinalZero;
    uint Flags;
}

struct ENCRYPTION_BUFFER
{
    uint EncryptionOperation;
    ubyte Private;
}

struct DECRYPTION_STATUS_BUFFER
{
    ubyte NoEncryptedStreams;
}

struct REQUEST_RAW_ENCRYPTED_DATA
{
    long FileOffset;
    uint Length;
}

struct ENCRYPTED_DATA_INFO
{
    ulong StartingFileOffset;
    uint OutputBufferOffset;
    uint BytesWithinFileSize;
    uint BytesWithinValidDataLength;
    ushort CompressionFormat;
    ubyte DataUnitShift;
    ubyte ChunkShift;
    ubyte ClusterShift;
    ubyte EncryptionFormat;
    ushort NumberOfDataBlocks;
    uint DataBlockSize;
}

struct EXTENDED_ENCRYPTED_DATA_INFO
{
    uint ExtendedCode;
    uint Length;
    uint Flags;
    uint Reserved;
}

struct SI_COPYFILE
{
    uint SourceFileNameLength;
    uint DestinationFileNameLength;
    uint Flags;
    ushort FileNameBuffer;
}

struct FILE_INITIATE_REPAIR_OUTPUT_BUFFER
{
    ulong Hint1;
    ulong Hint2;
    ulong Clsn;
    uint Status;
}

enum SHRINK_VOLUME_REQUEST_TYPES
{
    ShrinkPrepare = 1,
    ShrinkCommit = 2,
    ShrinkAbort = 3,
}

struct TXFS_ROLLFORWARD_REDO_INFORMATION
{
    LARGE_INTEGER LastVirtualClock;
    ulong LastRedoLsn;
    ulong HighestRecoveryLsn;
    uint Flags;
}

struct TXFS_START_RM_INFORMATION
{
    uint Flags;
    ulong LogContainerSize;
    uint LogContainerCountMin;
    uint LogContainerCountMax;
    uint LogGrowthIncrement;
    uint LogAutoShrinkPercentage;
    uint TmLogPathOffset;
    ushort TmLogPathLength;
    ushort LoggingMode;
    ushort LogPathLength;
    ushort Reserved;
    ushort LogPath;
}

struct FILE_FS_PERSISTENT_VOLUME_INFORMATION
{
    uint VolumeFlags;
    uint FlagMask;
    uint Version;
    uint Reserved;
}

struct STORAGE_QUERY_DEPENDENT_VOLUME_REQUEST
{
    uint RequestLevel;
    uint RequestFlags;
}

struct STORAGE_QUERY_DEPENDENT_VOLUME_LEV1_ENTRY
{
    uint EntryLength;
    uint DependencyTypeFlags;
    uint ProviderSpecificFlags;
    VIRTUAL_STORAGE_TYPE VirtualStorageType;
}

struct STORAGE_QUERY_DEPENDENT_VOLUME_LEV2_ENTRY
{
    uint EntryLength;
    uint DependencyTypeFlags;
    uint ProviderSpecificFlags;
    VIRTUAL_STORAGE_TYPE VirtualStorageType;
    uint AncestorLevel;
    uint HostVolumeNameOffset;
    uint HostVolumeNameSize;
    uint DependentVolumeNameOffset;
    uint DependentVolumeNameSize;
    uint RelativePathOffset;
    uint RelativePathSize;
    uint DependentDeviceNameOffset;
    uint DependentDeviceNameSize;
}

struct STORAGE_QUERY_DEPENDENT_VOLUME_RESPONSE
{
    uint ResponseLevel;
    uint NumberEntries;
    _Anonymous_e__Union Anonymous;
}

struct SD_CHANGE_MACHINE_SID_INPUT
{
    ushort CurrentMachineSIDOffset;
    ushort CurrentMachineSIDLength;
    ushort NewMachineSIDOffset;
    ushort NewMachineSIDLength;
}

struct SD_CHANGE_MACHINE_SID_OUTPUT
{
    ulong NumSDChangedSuccess;
    ulong NumSDChangedFail;
    ulong NumSDUnused;
    ulong NumSDTotal;
    ulong NumMftSDChangedSuccess;
    ulong NumMftSDChangedFail;
    ulong NumMftSDTotal;
}

struct SD_QUERY_STATS_INPUT
{
    uint Reserved;
}

struct SD_QUERY_STATS_OUTPUT
{
    ulong SdsStreamSize;
    ulong SdsAllocationSize;
    ulong SiiStreamSize;
    ulong SiiAllocationSize;
    ulong SdhStreamSize;
    ulong SdhAllocationSize;
    ulong NumSDTotal;
    ulong NumSDUnused;
}

struct SD_ENUM_SDS_INPUT
{
    ulong StartingOffset;
    ulong MaxSDEntriesToReturn;
}

struct SD_ENUM_SDS_ENTRY
{
    uint Hash;
    uint SecurityId;
    ulong Offset;
    uint Length;
    ubyte Descriptor;
}

struct SD_ENUM_SDS_OUTPUT
{
    ulong NextOffset;
    ulong NumSDEntriesReturned;
    ulong NumSDBytesReturned;
    SD_ENUM_SDS_ENTRY SDEntry;
}

struct SD_GLOBAL_CHANGE_INPUT
{
    uint Flags;
    uint ChangeType;
    _Anonymous_e__Union Anonymous;
}

struct SD_GLOBAL_CHANGE_OUTPUT
{
    uint Flags;
    uint ChangeType;
    _Anonymous_e__Union Anonymous;
}

struct FILE_TYPE_NOTIFICATION_INPUT
{
    uint Flags;
    uint NumFileTypeIDs;
    Guid FileTypeID;
}

struct CSV_MGMT_LOCK
{
    uint Flags;
}

struct CSV_QUERY_FILE_REVISION_FILE_ID_128
{
    FILE_ID_128 FileId;
    long FileRevision;
}

enum CSVFS_DISK_CONNECTIVITY
{
    CsvFsDiskConnectivityNone = 0,
    CsvFsDiskConnectivityMdsNodeOnly = 1,
    CsvFsDiskConnectivitySubsetOfNodes = 2,
    CsvFsDiskConnectivityAllNodes = 3,
}

struct CSV_QUERY_VOLUME_REDIRECT_STATE
{
    uint MdsNodeId;
    uint DsNodeId;
    ubyte IsDiskConnected;
    ubyte ClusterEnableDirectIo;
    CSVFS_DISK_CONNECTIVITY DiskConnectivity;
}

struct CSV_QUERY_MDS_PATH_V2
{
    long Version;
    uint RequiredSize;
    uint MdsNodeId;
    uint DsNodeId;
    uint Flags;
    CSVFS_DISK_CONNECTIVITY DiskConnectivity;
    Guid VolumeId;
    uint IpAddressOffset;
    uint IpAddressLength;
    uint PathOffset;
    uint PathLength;
}

enum STORAGE_RESERVE_ID
{
    StorageReserveIdNone = 0,
    StorageReserveIdHard = 1,
    StorageReserveIdSoft = 2,
    StorageReserveIdUpdateScratch = 3,
    StorageReserveIdMax = 4,
}

enum QUERY_FILE_LAYOUT_FILTER_TYPE
{
    QUERY_FILE_LAYOUT_FILTER_TYPE_NONE = 0,
    QUERY_FILE_LAYOUT_FILTER_TYPE_CLUSTERS = 1,
    QUERY_FILE_LAYOUT_FILTER_TYPE_FILEID = 2,
    QUERY_FILE_LAYOUT_FILTER_TYPE_STORAGE_RESERVE_ID = 3,
    QUERY_FILE_LAYOUT_NUM_FILTER_TYPES = 4,
}

struct CLUSTER_RANGE
{
    LARGE_INTEGER StartingCluster;
    LARGE_INTEGER ClusterCount;
}

struct FILE_REFERENCE_RANGE
{
    ulong StartingFileReferenceNumber;
    ulong EndingFileReferenceNumber;
}

struct QUERY_FILE_LAYOUT_INPUT
{
    _Anonymous_e__Union Anonymous;
    uint Flags;
    QUERY_FILE_LAYOUT_FILTER_TYPE FilterType;
    uint Reserved;
    _Filter_e__Union Filter;
}

struct QUERY_FILE_LAYOUT_OUTPUT
{
    uint FileEntryCount;
    uint FirstFileOffset;
    uint Flags;
    uint Reserved;
}

struct FILE_LAYOUT_ENTRY
{
    uint Version;
    uint NextFileOffset;
    uint Flags;
    uint FileAttributes;
    ulong FileReferenceNumber;
    uint FirstNameOffset;
    uint FirstStreamOffset;
    uint ExtraInfoOffset;
    uint ExtraInfoLength;
}

struct FILE_LAYOUT_NAME_ENTRY
{
    uint NextNameOffset;
    uint Flags;
    ulong ParentFileReferenceNumber;
    uint FileNameLength;
    uint Reserved;
    ushort FileName;
}

struct FILE_LAYOUT_INFO_ENTRY
{
    _BasicInformation_e__Struct BasicInformation;
    uint OwnerId;
    uint SecurityId;
    long Usn;
    STORAGE_RESERVE_ID StorageReserveId;
}

struct STREAM_LAYOUT_ENTRY
{
    uint Version;
    uint NextStreamOffset;
    uint Flags;
    uint ExtentInformationOffset;
    LARGE_INTEGER AllocationSize;
    LARGE_INTEGER EndOfFile;
    uint StreamInformationOffset;
    uint AttributeTypeCode;
    uint AttributeFlags;
    uint StreamIdentifierLength;
    ushort StreamIdentifier;
}

struct STREAM_EXTENT_ENTRY
{
    uint Flags;
    _ExtentInformation_e__Union ExtentInformation;
}

struct FSCTL_SET_INTEGRITY_INFORMATION_BUFFER_EX
{
    ubyte EnableIntegrity;
    ubyte KeepIntegrityStateUnchanged;
    ushort Reserved;
    uint Flags;
    ubyte Version;
    ubyte Reserved2;
}

struct FSCTL_OFFLOAD_READ_INPUT
{
    uint Size;
    uint Flags;
    uint TokenTimeToLive;
    uint Reserved;
    ulong FileOffset;
    ulong CopyLength;
}

struct FSCTL_OFFLOAD_READ_OUTPUT
{
    uint Size;
    uint Flags;
    ulong TransferLength;
    ubyte Token;
}

struct FSCTL_OFFLOAD_WRITE_INPUT
{
    uint Size;
    uint Flags;
    ulong FileOffset;
    ulong CopyLength;
    ulong TransferOffset;
    ubyte Token;
}

struct FSCTL_OFFLOAD_WRITE_OUTPUT
{
    uint Size;
    uint Flags;
    ulong LengthWritten;
}

struct SET_PURGE_FAILURE_MODE_INPUT
{
    uint Flags;
}

struct FILE_REGION_INFO
{
    long FileOffset;
    long Length;
    uint Usage;
    uint Reserved;
}

struct FILE_REGION_OUTPUT
{
    uint Flags;
    uint TotalRegionEntryCount;
    uint RegionEntryCount;
    uint Reserved;
    FILE_REGION_INFO Region;
}

struct FILE_REGION_INPUT
{
    long FileOffset;
    long Length;
    uint DesiredUsage;
}

struct WRITE_USN_REASON_INPUT
{
    uint Flags;
    uint UsnReasonToWrite;
}

enum FILE_STORAGE_TIER_CLASS
{
    FileStorageTierClassUnspecified = 0,
    FileStorageTierClassCapacity = 1,
    FileStorageTierClassPerformance = 2,
    FileStorageTierClassMax = 3,
}

struct STREAM_INFORMATION_ENTRY
{
    uint Version;
    uint Flags;
    _StreamInformation StreamInformation;
}

struct FILE_DESIRED_STORAGE_CLASS_INFORMATION
{
    FILE_STORAGE_TIER_CLASS Class;
    uint Flags;
}

struct DUPLICATE_EXTENTS_DATA_EX
{
    uint Size;
    HANDLE FileHandle;
    LARGE_INTEGER SourceFileOffset;
    LARGE_INTEGER TargetFileOffset;
    LARGE_INTEGER ByteCount;
    uint Flags;
}

enum REFS_SMR_VOLUME_GC_STATE
{
    SmrGcStateInactive = 0,
    SmrGcStatePaused = 1,
    SmrGcStateActive = 2,
    SmrGcStateActiveFullSpeed = 3,
}

struct REFS_SMR_VOLUME_INFO_OUTPUT
{
    uint Version;
    uint Flags;
    LARGE_INTEGER SizeOfRandomlyWritableTier;
    LARGE_INTEGER FreeSpaceInRandomlyWritableTier;
    LARGE_INTEGER SizeofSMRTier;
    LARGE_INTEGER FreeSpaceInSMRTier;
    LARGE_INTEGER UsableFreeSpaceInSMRTier;
    REFS_SMR_VOLUME_GC_STATE VolumeGcState;
    uint VolumeGcLastStatus;
    ulong Unused;
}

enum REFS_SMR_VOLUME_GC_ACTION
{
    SmrGcActionStart = 1,
    SmrGcActionStartFullSpeed = 2,
    SmrGcActionPause = 3,
    SmrGcActionStop = 4,
}

enum REFS_SMR_VOLUME_GC_METHOD
{
    SmrGcMethodCompaction = 1,
    SmrGcMethodCompression = 2,
    SmrGcMethodRotation = 3,
}

struct REFS_SMR_VOLUME_GC_PARAMETERS
{
    uint Version;
    uint Flags;
    REFS_SMR_VOLUME_GC_ACTION Action;
    REFS_SMR_VOLUME_GC_METHOD Method;
    uint IoGranularity;
    uint CompressionFormat;
    ulong Unused;
}

struct STREAMS_QUERY_PARAMETERS_OUTPUT_BUFFER
{
    uint OptimalWriteSize;
    uint StreamGranularitySize;
    uint StreamIdMin;
    uint StreamIdMax;
}

struct STREAMS_ASSOCIATE_ID_INPUT_BUFFER
{
    uint Flags;
    uint StreamId;
}

struct STREAMS_QUERY_ID_OUTPUT_BUFFER
{
    uint StreamId;
}

struct QUERY_BAD_RANGES_INPUT_RANGE
{
    ulong StartOffset;
    ulong LengthInBytes;
}

struct QUERY_BAD_RANGES_INPUT
{
    uint Flags;
    uint NumRanges;
    QUERY_BAD_RANGES_INPUT_RANGE Ranges;
}

struct QUERY_BAD_RANGES_OUTPUT_RANGE
{
    uint Flags;
    uint Reserved;
    ulong StartOffset;
    ulong LengthInBytes;
}

struct QUERY_BAD_RANGES_OUTPUT
{
    uint Flags;
    uint NumBadRanges;
    ulong NextOffsetToLookUp;
    QUERY_BAD_RANGES_OUTPUT_RANGE BadRanges;
}

struct SET_DAX_ALLOC_ALIGNMENT_HINT_INPUT
{
    uint Flags;
    uint AlignmentShift;
    ulong FileOffsetToAlign;
    uint FallbackAlignmentShift;
}

enum VIRTUAL_STORAGE_BEHAVIOR_CODE
{
    VirtualStorageBehaviorUndefined = 0,
    VirtualStorageBehaviorCacheWriteThrough = 1,
    VirtualStorageBehaviorCacheWriteBack = 2,
}

struct VIRTUAL_STORAGE_SET_BEHAVIOR_INPUT
{
    uint Size;
    VIRTUAL_STORAGE_BEHAVIOR_CODE BehaviorCode;
}

struct ENCRYPTION_KEY_CTRL_INPUT
{
    uint HeaderSize;
    uint StructureSize;
    ushort KeyOffset;
    ushort KeySize;
    uint DplLock;
    ulong DplUserId;
    ulong DplCredentialId;
}

struct WOF_EXTERNAL_INFO
{
    uint Version;
    uint Provider;
}

struct WOF_EXTERNAL_FILE_ID
{
    FILE_ID_128 FileId;
}

struct WOF_VERSION_INFO
{
    uint WofVersion;
}

struct WIM_PROVIDER_EXTERNAL_INFO
{
    uint Version;
    uint Flags;
    LARGE_INTEGER DataSourceId;
    ubyte ResourceHash;
}

struct WIM_PROVIDER_ADD_OVERLAY_INPUT
{
    uint WimType;
    uint WimIndex;
    uint WimFileNameOffset;
    uint WimFileNameLength;
}

struct WIM_PROVIDER_UPDATE_OVERLAY_INPUT
{
    LARGE_INTEGER DataSourceId;
    uint WimFileNameOffset;
    uint WimFileNameLength;
}

struct WIM_PROVIDER_REMOVE_OVERLAY_INPUT
{
    LARGE_INTEGER DataSourceId;
}

struct WIM_PROVIDER_SUSPEND_OVERLAY_INPUT
{
    LARGE_INTEGER DataSourceId;
}

struct WIM_PROVIDER_OVERLAY_ENTRY
{
    uint NextEntryOffset;
    LARGE_INTEGER DataSourceId;
    Guid WimGuid;
    uint WimFileNameOffset;
    uint WimType;
    uint WimIndex;
    uint Flags;
}

struct FILE_PROVIDER_EXTERNAL_INFO_V0
{
    uint Version;
    uint Algorithm;
}

struct FILE_PROVIDER_EXTERNAL_INFO_V1
{
    uint Version;
    uint Algorithm;
    uint Flags;
}

struct CONTAINER_VOLUME_STATE
{
    uint Flags;
}

struct CONTAINER_ROOT_INFO_INPUT
{
    uint Flags;
}

struct CONTAINER_ROOT_INFO_OUTPUT
{
    ushort ContainerRootIdLength;
    ubyte ContainerRootId;
}

struct VIRTUALIZATION_INSTANCE_INFO_INPUT
{
    uint NumberOfWorkerThreads;
    uint Flags;
}

struct VIRTUALIZATION_INSTANCE_INFO_INPUT_EX
{
    ushort HeaderSize;
    uint Flags;
    uint NotificationInfoSize;
    ushort NotificationInfoOffset;
    ushort ProviderMajorVersion;
}

struct VIRTUALIZATION_INSTANCE_INFO_OUTPUT
{
    Guid VirtualizationInstanceID;
}

struct GET_FILTER_FILE_IDENTIFIER_INPUT
{
    ushort AltitudeLength;
    ushort Altitude;
}

struct GET_FILTER_FILE_IDENTIFIER_OUTPUT
{
    ushort FilterFileIdentifierLength;
    ubyte FilterFileIdentifier;
}

alias PIO_IRP_EXT_PROCESS_TRACKED_OFFSET_CALLBACK = extern(Windows) void function(IO_IRP_EXT_TRACK_OFFSET_HEADER* SourceContext, IO_IRP_EXT_TRACK_OFFSET_HEADER* TargetContext, long RelativeOffset);
struct IO_IRP_EXT_TRACK_OFFSET_HEADER
{
    ushort Validation;
    ushort Flags;
    PIO_IRP_EXT_PROCESS_TRACKED_OFFSET_CALLBACK TrackedOffsetCallback;
}

struct SCARD_IO_REQUEST
{
    uint dwProtocol;
    uint cbPciLength;
}

struct SCARD_T0_COMMAND
{
    ubyte bCla;
    ubyte bIns;
    ubyte bP1;
    ubyte bP2;
    ubyte bP3;
}

struct SCARD_T0_REQUEST
{
    SCARD_IO_REQUEST ioRequest;
    ubyte bSw1;
    ubyte bSw2;
    _Anonymous_e__Union Anonymous;
}

struct SCARD_T1_REQUEST
{
    SCARD_IO_REQUEST ioRequest;
}

struct PRINTER_INFO_1A
{
    uint Flags;
    const(char)* pDescription;
    const(char)* pName;
    const(char)* pComment;
}

struct PRINTER_INFO_1W
{
    uint Flags;
    const(wchar)* pDescription;
    const(wchar)* pName;
    const(wchar)* pComment;
}

struct PRINTER_INFO_2A
{
    const(char)* pServerName;
    const(char)* pPrinterName;
    const(char)* pShareName;
    const(char)* pPortName;
    const(char)* pDriverName;
    const(char)* pComment;
    const(char)* pLocation;
    DEVMODEA* pDevMode;
    const(char)* pSepFile;
    const(char)* pPrintProcessor;
    const(char)* pDatatype;
    const(char)* pParameters;
    void* pSecurityDescriptor;
    uint Attributes;
    uint Priority;
    uint DefaultPriority;
    uint StartTime;
    uint UntilTime;
    uint Status;
    uint cJobs;
    uint AveragePPM;
}

struct PRINTER_INFO_2W
{
    const(wchar)* pServerName;
    const(wchar)* pPrinterName;
    const(wchar)* pShareName;
    const(wchar)* pPortName;
    const(wchar)* pDriverName;
    const(wchar)* pComment;
    const(wchar)* pLocation;
    DEVMODEW* pDevMode;
    const(wchar)* pSepFile;
    const(wchar)* pPrintProcessor;
    const(wchar)* pDatatype;
    const(wchar)* pParameters;
    void* pSecurityDescriptor;
    uint Attributes;
    uint Priority;
    uint DefaultPriority;
    uint StartTime;
    uint UntilTime;
    uint Status;
    uint cJobs;
    uint AveragePPM;
}

struct PRINTER_INFO_3
{
    void* pSecurityDescriptor;
}

struct PRINTER_INFO_4A
{
    const(char)* pPrinterName;
    const(char)* pServerName;
    uint Attributes;
}

struct PRINTER_INFO_4W
{
    const(wchar)* pPrinterName;
    const(wchar)* pServerName;
    uint Attributes;
}

struct PRINTER_INFO_5A
{
    const(char)* pPrinterName;
    const(char)* pPortName;
    uint Attributes;
    uint DeviceNotSelectedTimeout;
    uint TransmissionRetryTimeout;
}

struct PRINTER_INFO_5W
{
    const(wchar)* pPrinterName;
    const(wchar)* pPortName;
    uint Attributes;
    uint DeviceNotSelectedTimeout;
    uint TransmissionRetryTimeout;
}

struct PRINTER_INFO_6
{
    uint dwStatus;
}

struct PRINTER_INFO_7A
{
    const(char)* pszObjectGUID;
    uint dwAction;
}

struct PRINTER_INFO_7W
{
    const(wchar)* pszObjectGUID;
    uint dwAction;
}

struct PRINTER_INFO_8A
{
    DEVMODEA* pDevMode;
}

struct PRINTER_INFO_8W
{
    DEVMODEW* pDevMode;
}

struct PRINTER_INFO_9A
{
    DEVMODEA* pDevMode;
}

struct PRINTER_INFO_9W
{
    DEVMODEW* pDevMode;
}

struct JOB_INFO_1A
{
    uint JobId;
    const(char)* pPrinterName;
    const(char)* pMachineName;
    const(char)* pUserName;
    const(char)* pDocument;
    const(char)* pDatatype;
    const(char)* pStatus;
    uint Status;
    uint Priority;
    uint Position;
    uint TotalPages;
    uint PagesPrinted;
    SYSTEMTIME Submitted;
}

struct JOB_INFO_1W
{
    uint JobId;
    const(wchar)* pPrinterName;
    const(wchar)* pMachineName;
    const(wchar)* pUserName;
    const(wchar)* pDocument;
    const(wchar)* pDatatype;
    const(wchar)* pStatus;
    uint Status;
    uint Priority;
    uint Position;
    uint TotalPages;
    uint PagesPrinted;
    SYSTEMTIME Submitted;
}

struct JOB_INFO_2A
{
    uint JobId;
    const(char)* pPrinterName;
    const(char)* pMachineName;
    const(char)* pUserName;
    const(char)* pDocument;
    const(char)* pNotifyName;
    const(char)* pDatatype;
    const(char)* pPrintProcessor;
    const(char)* pParameters;
    const(char)* pDriverName;
    DEVMODEA* pDevMode;
    const(char)* pStatus;
    void* pSecurityDescriptor;
    uint Status;
    uint Priority;
    uint Position;
    uint StartTime;
    uint UntilTime;
    uint TotalPages;
    uint Size;
    SYSTEMTIME Submitted;
    uint Time;
    uint PagesPrinted;
}

struct JOB_INFO_2W
{
    uint JobId;
    const(wchar)* pPrinterName;
    const(wchar)* pMachineName;
    const(wchar)* pUserName;
    const(wchar)* pDocument;
    const(wchar)* pNotifyName;
    const(wchar)* pDatatype;
    const(wchar)* pPrintProcessor;
    const(wchar)* pParameters;
    const(wchar)* pDriverName;
    DEVMODEW* pDevMode;
    const(wchar)* pStatus;
    void* pSecurityDescriptor;
    uint Status;
    uint Priority;
    uint Position;
    uint StartTime;
    uint UntilTime;
    uint TotalPages;
    uint Size;
    SYSTEMTIME Submitted;
    uint Time;
    uint PagesPrinted;
}

struct JOB_INFO_3
{
    uint JobId;
    uint NextJobId;
    uint Reserved;
}

struct JOB_INFO_4A
{
    uint JobId;
    const(char)* pPrinterName;
    const(char)* pMachineName;
    const(char)* pUserName;
    const(char)* pDocument;
    const(char)* pNotifyName;
    const(char)* pDatatype;
    const(char)* pPrintProcessor;
    const(char)* pParameters;
    const(char)* pDriverName;
    DEVMODEA* pDevMode;
    const(char)* pStatus;
    void* pSecurityDescriptor;
    uint Status;
    uint Priority;
    uint Position;
    uint StartTime;
    uint UntilTime;
    uint TotalPages;
    uint Size;
    SYSTEMTIME Submitted;
    uint Time;
    uint PagesPrinted;
    int SizeHigh;
}

struct JOB_INFO_4W
{
    uint JobId;
    const(wchar)* pPrinterName;
    const(wchar)* pMachineName;
    const(wchar)* pUserName;
    const(wchar)* pDocument;
    const(wchar)* pNotifyName;
    const(wchar)* pDatatype;
    const(wchar)* pPrintProcessor;
    const(wchar)* pParameters;
    const(wchar)* pDriverName;
    DEVMODEW* pDevMode;
    const(wchar)* pStatus;
    void* pSecurityDescriptor;
    uint Status;
    uint Priority;
    uint Position;
    uint StartTime;
    uint UntilTime;
    uint TotalPages;
    uint Size;
    SYSTEMTIME Submitted;
    uint Time;
    uint PagesPrinted;
    int SizeHigh;
}

struct ADDJOB_INFO_1A
{
    const(char)* Path;
    uint JobId;
}

struct ADDJOB_INFO_1W
{
    const(wchar)* Path;
    uint JobId;
}

struct DRIVER_INFO_1A
{
    const(char)* pName;
}

struct DRIVER_INFO_1W
{
    const(wchar)* pName;
}

struct DRIVER_INFO_2A
{
    uint cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
}

struct DRIVER_INFO_2W
{
    uint cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
}

struct DRIVER_INFO_3A
{
    uint cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
    const(char)* pHelpFile;
    const(char)* pDependentFiles;
    const(char)* pMonitorName;
    const(char)* pDefaultDataType;
}

struct DRIVER_INFO_3W
{
    uint cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
    const(wchar)* pHelpFile;
    const(wchar)* pDependentFiles;
    const(wchar)* pMonitorName;
    const(wchar)* pDefaultDataType;
}

struct DRIVER_INFO_4A
{
    uint cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
    const(char)* pHelpFile;
    const(char)* pDependentFiles;
    const(char)* pMonitorName;
    const(char)* pDefaultDataType;
    const(char)* pszzPreviousNames;
}

struct DRIVER_INFO_4W
{
    uint cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
    const(wchar)* pHelpFile;
    const(wchar)* pDependentFiles;
    const(wchar)* pMonitorName;
    const(wchar)* pDefaultDataType;
    const(wchar)* pszzPreviousNames;
}

struct DRIVER_INFO_5A
{
    uint cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
    uint dwDriverAttributes;
    uint dwConfigVersion;
    uint dwDriverVersion;
}

struct DRIVER_INFO_5W
{
    uint cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
    uint dwDriverAttributes;
    uint dwConfigVersion;
    uint dwDriverVersion;
}

struct DRIVER_INFO_6A
{
    uint cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
    const(char)* pHelpFile;
    const(char)* pDependentFiles;
    const(char)* pMonitorName;
    const(char)* pDefaultDataType;
    const(char)* pszzPreviousNames;
    FILETIME ftDriverDate;
    ulong dwlDriverVersion;
    const(char)* pszMfgName;
    const(char)* pszOEMUrl;
    const(char)* pszHardwareID;
    const(char)* pszProvider;
}

struct DRIVER_INFO_6W
{
    uint cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
    const(wchar)* pHelpFile;
    const(wchar)* pDependentFiles;
    const(wchar)* pMonitorName;
    const(wchar)* pDefaultDataType;
    const(wchar)* pszzPreviousNames;
    FILETIME ftDriverDate;
    ulong dwlDriverVersion;
    const(wchar)* pszMfgName;
    const(wchar)* pszOEMUrl;
    const(wchar)* pszHardwareID;
    const(wchar)* pszProvider;
}

struct DRIVER_INFO_8A
{
    uint cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
    const(char)* pHelpFile;
    const(char)* pDependentFiles;
    const(char)* pMonitorName;
    const(char)* pDefaultDataType;
    const(char)* pszzPreviousNames;
    FILETIME ftDriverDate;
    ulong dwlDriverVersion;
    const(char)* pszMfgName;
    const(char)* pszOEMUrl;
    const(char)* pszHardwareID;
    const(char)* pszProvider;
    const(char)* pszPrintProcessor;
    const(char)* pszVendorSetup;
    const(char)* pszzColorProfiles;
    const(char)* pszInfPath;
    uint dwPrinterDriverAttributes;
    const(char)* pszzCoreDriverDependencies;
    FILETIME ftMinInboxDriverVerDate;
    ulong dwlMinInboxDriverVerVersion;
}

struct DRIVER_INFO_8W
{
    uint cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
    const(wchar)* pHelpFile;
    const(wchar)* pDependentFiles;
    const(wchar)* pMonitorName;
    const(wchar)* pDefaultDataType;
    const(wchar)* pszzPreviousNames;
    FILETIME ftDriverDate;
    ulong dwlDriverVersion;
    const(wchar)* pszMfgName;
    const(wchar)* pszOEMUrl;
    const(wchar)* pszHardwareID;
    const(wchar)* pszProvider;
    const(wchar)* pszPrintProcessor;
    const(wchar)* pszVendorSetup;
    const(wchar)* pszzColorProfiles;
    const(wchar)* pszInfPath;
    uint dwPrinterDriverAttributes;
    const(wchar)* pszzCoreDriverDependencies;
    FILETIME ftMinInboxDriverVerDate;
    ulong dwlMinInboxDriverVerVersion;
}

struct DOC_INFO_1A
{
    const(char)* pDocName;
    const(char)* pOutputFile;
    const(char)* pDatatype;
}

struct DOC_INFO_1W
{
    const(wchar)* pDocName;
    const(wchar)* pOutputFile;
    const(wchar)* pDatatype;
}

struct FORM_INFO_1A
{
    uint Flags;
    const(char)* pName;
    SIZE Size;
    RECTL ImageableArea;
}

struct FORM_INFO_1W
{
    uint Flags;
    const(wchar)* pName;
    SIZE Size;
    RECTL ImageableArea;
}

struct FORM_INFO_2A
{
    uint Flags;
    const(char)* pName;
    SIZE Size;
    RECTL ImageableArea;
    const(char)* pKeyword;
    uint StringType;
    const(char)* pMuiDll;
    uint dwResourceId;
    const(char)* pDisplayName;
    ushort wLangId;
}

struct FORM_INFO_2W
{
    uint Flags;
    const(wchar)* pName;
    SIZE Size;
    RECTL ImageableArea;
    const(char)* pKeyword;
    uint StringType;
    const(wchar)* pMuiDll;
    uint dwResourceId;
    const(wchar)* pDisplayName;
    ushort wLangId;
}

struct DOC_INFO_2A
{
    const(char)* pDocName;
    const(char)* pOutputFile;
    const(char)* pDatatype;
    uint dwMode;
    uint JobId;
}

struct DOC_INFO_2W
{
    const(wchar)* pDocName;
    const(wchar)* pOutputFile;
    const(wchar)* pDatatype;
    uint dwMode;
    uint JobId;
}

struct DOC_INFO_3A
{
    const(char)* pDocName;
    const(char)* pOutputFile;
    const(char)* pDatatype;
    uint dwFlags;
}

struct DOC_INFO_3W
{
    const(wchar)* pDocName;
    const(wchar)* pOutputFile;
    const(wchar)* pDatatype;
    uint dwFlags;
}

struct PRINTPROCESSOR_INFO_1A
{
    const(char)* pName;
}

struct PRINTPROCESSOR_INFO_1W
{
    const(wchar)* pName;
}

struct PRINTPROCESSOR_CAPS_1
{
    uint dwLevel;
    uint dwNupOptions;
    uint dwPageOrderFlags;
    uint dwNumberOfCopies;
}

struct PRINTPROCESSOR_CAPS_2
{
    uint dwLevel;
    uint dwNupOptions;
    uint dwPageOrderFlags;
    uint dwNumberOfCopies;
    uint dwDuplexHandlingCaps;
    uint dwNupDirectionCaps;
    uint dwNupBorderCaps;
    uint dwBookletHandlingCaps;
    uint dwScalingCaps;
}

struct PORT_INFO_1A
{
    const(char)* pName;
}

struct PORT_INFO_1W
{
    const(wchar)* pName;
}

struct PORT_INFO_2A
{
    const(char)* pPortName;
    const(char)* pMonitorName;
    const(char)* pDescription;
    uint fPortType;
    uint Reserved;
}

struct PORT_INFO_2W
{
    const(wchar)* pPortName;
    const(wchar)* pMonitorName;
    const(wchar)* pDescription;
    uint fPortType;
    uint Reserved;
}

struct PORT_INFO_3A
{
    uint dwStatus;
    const(char)* pszStatus;
    uint dwSeverity;
}

struct PORT_INFO_3W
{
    uint dwStatus;
    const(wchar)* pszStatus;
    uint dwSeverity;
}

struct MONITOR_INFO_1A
{
    const(char)* pName;
}

struct MONITOR_INFO_1W
{
    const(wchar)* pName;
}

struct MONITOR_INFO_2A
{
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDLLName;
}

struct MONITOR_INFO_2W
{
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDLLName;
}

struct DATATYPES_INFO_1A
{
    const(char)* pName;
}

struct DATATYPES_INFO_1W
{
    const(wchar)* pName;
}

struct PRINTER_DEFAULTSA
{
    const(char)* pDatatype;
    DEVMODEA* pDevMode;
    uint DesiredAccess;
}

struct PRINTER_DEFAULTSW
{
    const(wchar)* pDatatype;
    DEVMODEW* pDevMode;
    uint DesiredAccess;
}

struct PRINTER_ENUM_VALUESA
{
    const(char)* pValueName;
    uint cbValueName;
    uint dwType;
    ubyte* pData;
    uint cbData;
}

struct PRINTER_ENUM_VALUESW
{
    const(wchar)* pValueName;
    uint cbValueName;
    uint dwType;
    ubyte* pData;
    uint cbData;
}

struct PRINTER_NOTIFY_OPTIONS_TYPE
{
    ushort Type;
    ushort Reserved0;
    uint Reserved1;
    uint Reserved2;
    uint Count;
    ushort* pFields;
}

struct PRINTER_NOTIFY_OPTIONS
{
    uint Version;
    uint Flags;
    uint Count;
    PRINTER_NOTIFY_OPTIONS_TYPE* pTypes;
}

struct PRINTER_NOTIFY_INFO_DATA
{
    ushort Type;
    ushort Field;
    uint Reserved;
    uint Id;
    _NotifyData_e__Union NotifyData;
}

struct PRINTER_NOTIFY_INFO
{
    uint Version;
    uint Flags;
    uint Count;
    PRINTER_NOTIFY_INFO_DATA aData;
}

struct BINARY_CONTAINER
{
    uint cbBuf;
    ubyte* pData;
}

struct BIDI_DATA
{
    uint dwBidiType;
    _u_e__Union u;
}

struct BIDI_REQUEST_DATA
{
    uint dwReqNumber;
    const(wchar)* pSchema;
    BIDI_DATA data;
}

struct BIDI_REQUEST_CONTAINER
{
    uint Version;
    uint Flags;
    uint Count;
    BIDI_REQUEST_DATA aData;
}

struct BIDI_RESPONSE_DATA
{
    uint dwResult;
    uint dwReqNumber;
    const(wchar)* pSchema;
    BIDI_DATA data;
}

struct BIDI_RESPONSE_CONTAINER
{
    uint Version;
    uint Flags;
    uint Count;
    BIDI_RESPONSE_DATA aData;
}

enum BIDI_TYPE
{
    BIDI_NULL = 0,
    BIDI_INT = 1,
    BIDI_FLOAT = 2,
    BIDI_BOOL = 3,
    BIDI_STRING = 4,
    BIDI_TEXT = 5,
    BIDI_ENUM = 6,
    BIDI_BLOB = 7,
}

struct PROVIDOR_INFO_1A
{
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDLLName;
}

struct PROVIDOR_INFO_1W
{
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDLLName;
}

struct PROVIDOR_INFO_2A
{
    const(char)* pOrder;
}

struct PROVIDOR_INFO_2W
{
    const(wchar)* pOrder;
}

enum PRINTER_OPTION_FLAGS
{
    PRINTER_OPTION_NO_CACHE = 1,
    PRINTER_OPTION_CACHE = 2,
    PRINTER_OPTION_CLIENT_CHANGE = 4,
    PRINTER_OPTION_NO_CLIENT_DATA = 8,
}

struct PRINTER_OPTIONSA
{
    uint cbSize;
    uint dwFlags;
}

struct PRINTER_OPTIONSW
{
    uint cbSize;
    uint dwFlags;
}

struct PRINTER_CONNECTION_INFO_1A
{
    uint dwFlags;
    const(char)* pszDriverName;
}

struct PRINTER_CONNECTION_INFO_1W
{
    uint dwFlags;
    const(wchar)* pszDriverName;
}

struct CORE_PRINTER_DRIVERA
{
    Guid CoreDriverGUID;
    FILETIME ftDriverDate;
    ulong dwlDriverVersion;
    byte szPackageID;
}

struct CORE_PRINTER_DRIVERW
{
    Guid CoreDriverGUID;
    FILETIME ftDriverDate;
    ulong dwlDriverVersion;
    ushort szPackageID;
}

enum EPrintPropertyType
{
    kPropertyTypeString = 1,
    kPropertyTypeInt32 = 2,
    kPropertyTypeInt64 = 3,
    kPropertyTypeByte = 4,
    kPropertyTypeTime = 5,
    kPropertyTypeDevMode = 6,
    kPropertyTypeSD = 7,
    kPropertyTypeNotificationReply = 8,
    kPropertyTypeNotificationOptions = 9,
    kPropertyTypeBuffer = 10,
}

enum EPrintXPSJobProgress
{
    kAddingDocumentSequence = 0,
    kDocumentSequenceAdded = 1,
    kAddingFixedDocument = 2,
    kFixedDocumentAdded = 3,
    kAddingFixedPage = 4,
    kFixedPageAdded = 5,
    kResourceAdded = 6,
    kFontAdded = 7,
    kImageAdded = 8,
    kXpsDocumentCommitted = 9,
}

enum EPrintXPSJobOperation
{
    kJobProduction = 1,
    kJobConsumption = 2,
}

struct PrintPropertyValue
{
    EPrintPropertyType ePropertyType;
    _value_e__Union value;
}

struct PrintNamedProperty
{
    ushort* propertyName;
    PrintPropertyValue propertyValue;
}

struct PrintPropertiesCollection
{
    uint numberOfProperties;
    PrintNamedProperty* propertiesCollection;
}

enum PRINT_EXECUTION_CONTEXT
{
    PRINT_EXECUTION_CONTEXT_APPLICATION = 0,
    PRINT_EXECUTION_CONTEXT_SPOOLER_SERVICE = 1,
    PRINT_EXECUTION_CONTEXT_SPOOLER_ISOLATION_HOST = 2,
    PRINT_EXECUTION_CONTEXT_FILTER_PIPELINE = 3,
    PRINT_EXECUTION_CONTEXT_WOW64 = 4,
}

struct PRINT_EXECUTION_DATA
{
    PRINT_EXECUTION_CONTEXT context;
    uint clientAppPID;
}

const GUID IID_IServiceProvider = {0x6D5140C1, 0x7436, 0x11CE, [0x80, 0x34, 0x00, 0xAA, 0x00, 0x60, 0x09, 0xFA]};
@GUID(0x6D5140C1, 0x7436, 0x11CE, [0x80, 0x34, 0x00, 0xAA, 0x00, 0x60, 0x09, 0xFA]);
interface IServiceProvider : IUnknown
{
    HRESULT QueryService(const(Guid)* guidService, const(Guid)* riid, void** ppvObject);
}

struct MODEMDEVCAPS
{
    uint dwActualSize;
    uint dwRequiredSize;
    uint dwDevSpecificOffset;
    uint dwDevSpecificSize;
    uint dwModemProviderVersion;
    uint dwModemManufacturerOffset;
    uint dwModemManufacturerSize;
    uint dwModemModelOffset;
    uint dwModemModelSize;
    uint dwModemVersionOffset;
    uint dwModemVersionSize;
    uint dwDialOptions;
    uint dwCallSetupFailTimer;
    uint dwInactivityTimeout;
    uint dwSpeakerVolume;
    uint dwSpeakerMode;
    uint dwModemOptions;
    uint dwMaxDTERate;
    uint dwMaxDCERate;
    ubyte abVariablePortion;
}

struct MODEMSETTINGS
{
    uint dwActualSize;
    uint dwRequiredSize;
    uint dwDevSpecificOffset;
    uint dwDevSpecificSize;
    uint dwCallSetupFailTimer;
    uint dwInactivityTimeout;
    uint dwSpeakerVolume;
    uint dwSpeakerMode;
    uint dwPreferredModemOptions;
    uint dwNegotiatedModemOptions;
    uint dwNegotiatedDCERate;
    ubyte abVariablePortion;
}

enum DISPATCHERQUEUE_THREAD_APARTMENTTYPE
{
    DQTAT_COM_NONE = 0,
    DQTAT_COM_ASTA = 1,
    DQTAT_COM_STA = 2,
}

enum DISPATCHERQUEUE_THREAD_TYPE
{
    DQTYPE_THREAD_DEDICATED = 1,
    DQTYPE_THREAD_CURRENT = 2,
}

struct DispatcherQueueOptions
{
    uint dwSize;
    DISPATCHERQUEUE_THREAD_TYPE threadType;
    DISPATCHERQUEUE_THREAD_APARTMENTTYPE apartmentType;
}

enum VDS_STORAGE_IDENTIFIER_CODE_SET
{
    VDSStorageIdCodeSetReserved = 0,
    VDSStorageIdCodeSetBinary = 1,
    VDSStorageIdCodeSetAscii = 2,
    VDSStorageIdCodeSetUtf8 = 3,
}

enum VDS_STORAGE_IDENTIFIER_TYPE
{
    VDSStorageIdTypeVendorSpecific = 0,
    VDSStorageIdTypeVendorId = 1,
    VDSStorageIdTypeEUI64 = 2,
    VDSStorageIdTypeFCPHName = 3,
    VDSStorageIdTypePortRelative = 4,
    VDSStorageIdTypeTargetPortGroup = 5,
    VDSStorageIdTypeLogicalUnitGroup = 6,
    VDSStorageIdTypeMD5LogicalUnitIdentifier = 7,
    VDSStorageIdTypeScsiNameString = 8,
}

enum VDS_STORAGE_BUS_TYPE
{
    VDSBusTypeUnknown = 0,
    VDSBusTypeScsi = 1,
    VDSBusTypeAtapi = 2,
    VDSBusTypeAta = 3,
    VDSBusType1394 = 4,
    VDSBusTypeSsa = 5,
    VDSBusTypeFibre = 6,
    VDSBusTypeUsb = 7,
    VDSBusTypeRAID = 8,
    VDSBusTypeiScsi = 9,
    VDSBusTypeSas = 10,
    VDSBusTypeSata = 11,
    VDSBusTypeSd = 12,
    VDSBusTypeMmc = 13,
    VDSBusTypeMax = 14,
    VDSBusTypeVirtual = 14,
    VDSBusTypeFileBackedVirtual = 15,
    VDSBusTypeSpaces = 16,
    VDSBusTypeNVMe = 17,
    VDSBusTypeScm = 18,
    VDSBusTypeUfs = 19,
    VDSBusTypeMaxReserved = 127,
}

struct VDS_STORAGE_IDENTIFIER
{
    VDS_STORAGE_IDENTIFIER_CODE_SET m_CodeSet;
    VDS_STORAGE_IDENTIFIER_TYPE m_Type;
    uint m_cbIdentifier;
    ubyte* m_rgbIdentifier;
}

struct VDS_STORAGE_DEVICE_ID_DESCRIPTOR
{
    uint m_version;
    uint m_cIdentifiers;
    VDS_STORAGE_IDENTIFIER* m_rgIdentifiers;
}

enum VDS_INTERCONNECT_ADDRESS_TYPE
{
    VDS_IA_UNKNOWN = 0,
    VDS_IA_FCFS = 1,
    VDS_IA_FCPH = 2,
    VDS_IA_FCPH3 = 3,
    VDS_IA_MAC = 4,
    VDS_IA_SCSI = 5,
}

struct VDS_INTERCONNECT
{
    VDS_INTERCONNECT_ADDRESS_TYPE m_addressType;
    uint m_cbPort;
    ubyte* m_pbPort;
    uint m_cbAddress;
    ubyte* m_pbAddress;
}

struct VDS_LUN_INFORMATION
{
    uint m_version;
    ubyte m_DeviceType;
    ubyte m_DeviceTypeModifier;
    BOOL m_bCommandQueueing;
    VDS_STORAGE_BUS_TYPE m_BusType;
    byte* m_szVendorId;
    byte* m_szProductId;
    byte* m_szProductRevision;
    byte* m_szSerialNumber;
    Guid m_diskSignature;
    VDS_STORAGE_DEVICE_ID_DESCRIPTOR m_deviceIdDescriptor;
    uint m_cInterconnects;
    VDS_INTERCONNECT* m_rgInterconnects;
}

enum VDS_OBJECT_TYPE
{
    VDS_OT_UNKNOWN = 0,
    VDS_OT_PROVIDER = 1,
    VDS_OT_PACK = 10,
    VDS_OT_VOLUME = 11,
    VDS_OT_VOLUME_PLEX = 12,
    VDS_OT_DISK = 13,
    VDS_OT_SUB_SYSTEM = 30,
    VDS_OT_CONTROLLER = 31,
    VDS_OT_DRIVE = 32,
    VDS_OT_LUN = 33,
    VDS_OT_LUN_PLEX = 34,
    VDS_OT_PORT = 35,
    VDS_OT_PORTAL = 36,
    VDS_OT_TARGET = 37,
    VDS_OT_PORTAL_GROUP = 38,
    VDS_OT_STORAGE_POOL = 39,
    VDS_OT_HBAPORT = 90,
    VDS_OT_INIT_ADAPTER = 91,
    VDS_OT_INIT_PORTAL = 92,
    VDS_OT_ASYNC = 100,
    VDS_OT_ENUM = 101,
    VDS_OT_VDISK = 200,
    VDS_OT_OPEN_VDISK = 201,
}

enum VDS_PROVIDER_TYPE
{
    VDS_PT_UNKNOWN = 0,
    VDS_PT_SOFTWARE = 1,
    VDS_PT_HARDWARE = 2,
    VDS_PT_VIRTUALDISK = 3,
    VDS_PT_MAX = 4,
}

enum VDS_PROVIDER_FLAG
{
    VDS_PF_DYNAMIC = 1,
    VDS_PF_INTERNAL_HARDWARE_PROVIDER = 2,
    VDS_PF_ONE_DISK_ONLY_PER_PACK = 4,
    VDS_PF_ONE_PACK_ONLINE_ONLY = 8,
    VDS_PF_VOLUME_SPACE_MUST_BE_CONTIGUOUS = 16,
    VDS_PF_SUPPORT_DYNAMIC = -2147483648,
    VDS_PF_SUPPORT_FAULT_TOLERANT = 1073741824,
    VDS_PF_SUPPORT_DYNAMIC_1394 = 536870912,
    VDS_PF_SUPPORT_MIRROR = 32,
    VDS_PF_SUPPORT_RAID5 = 64,
}

enum VDS_RECOVER_ACTION
{
    VDS_RA_UNKNOWN = 0,
    VDS_RA_REFRESH = 1,
    VDS_RA_RESTART = 2,
}

enum VDS_NOTIFICATION_TARGET_TYPE
{
    VDS_NTT_UNKNOWN = 0,
    VDS_NTT_PACK = 10,
    VDS_NTT_VOLUME = 11,
    VDS_NTT_DISK = 13,
    VDS_NTT_PARTITION = 60,
    VDS_NTT_DRIVE_LETTER = 61,
    VDS_NTT_FILE_SYSTEM = 62,
    VDS_NTT_MOUNT_POINT = 63,
    VDS_NTT_SUB_SYSTEM = 30,
    VDS_NTT_CONTROLLER = 31,
    VDS_NTT_DRIVE = 32,
    VDS_NTT_LUN = 33,
    VDS_NTT_PORT = 35,
    VDS_NTT_PORTAL = 36,
    VDS_NTT_TARGET = 37,
    VDS_NTT_PORTAL_GROUP = 38,
    VDS_NTT_SERVICE = 200,
}

struct VDS_PACK_NOTIFICATION
{
    uint ulEvent;
    Guid packId;
}

struct VDS_DISK_NOTIFICATION
{
    uint ulEvent;
    Guid diskId;
}

struct VDS_VOLUME_NOTIFICATION
{
    uint ulEvent;
    Guid volumeId;
    Guid plexId;
    uint ulPercentCompleted;
}

struct VDS_PARTITION_NOTIFICATION
{
    uint ulEvent;
    Guid diskId;
    ulong ullOffset;
}

struct VDS_SERVICE_NOTIFICATION
{
    uint ulEvent;
    VDS_RECOVER_ACTION action;
}

struct VDS_DRIVE_LETTER_NOTIFICATION
{
    uint ulEvent;
    ushort wcLetter;
    Guid volumeId;
}

struct VDS_FILE_SYSTEM_NOTIFICATION
{
    uint ulEvent;
    Guid volumeId;
    uint dwPercentCompleted;
}

struct VDS_MOUNT_POINT_NOTIFICATION
{
    uint ulEvent;
    Guid volumeId;
}

struct VDS_SUB_SYSTEM_NOTIFICATION
{
    uint ulEvent;
    Guid subSystemId;
}

struct VDS_CONTROLLER_NOTIFICATION
{
    uint ulEvent;
    Guid controllerId;
}

struct VDS_DRIVE_NOTIFICATION
{
    uint ulEvent;
    Guid driveId;
}

struct VDS_LUN_NOTIFICATION
{
    uint ulEvent;
    Guid LunId;
}

struct VDS_PORT_NOTIFICATION
{
    uint ulEvent;
    Guid portId;
}

struct VDS_PORTAL_NOTIFICATION
{
    uint ulEvent;
    Guid portalId;
}

struct VDS_TARGET_NOTIFICATION
{
    uint ulEvent;
    Guid targetId;
}

struct VDS_PORTAL_GROUP_NOTIFICATION
{
    uint ulEvent;
    Guid portalGroupId;
}

struct VDS_NOTIFICATION
{
    VDS_NOTIFICATION_TARGET_TYPE objectType;
    _Anonymous_e__Union Anonymous;
}

enum VDS_ASYNC_OUTPUT_TYPE
{
    VDS_ASYNCOUT_UNKNOWN = 0,
    VDS_ASYNCOUT_CREATEVOLUME = 1,
    VDS_ASYNCOUT_EXTENDVOLUME = 2,
    VDS_ASYNCOUT_SHRINKVOLUME = 3,
    VDS_ASYNCOUT_ADDVOLUMEPLEX = 4,
    VDS_ASYNCOUT_BREAKVOLUMEPLEX = 5,
    VDS_ASYNCOUT_REMOVEVOLUMEPLEX = 6,
    VDS_ASYNCOUT_REPAIRVOLUMEPLEX = 7,
    VDS_ASYNCOUT_RECOVERPACK = 8,
    VDS_ASYNCOUT_REPLACEDISK = 9,
    VDS_ASYNCOUT_CREATEPARTITION = 10,
    VDS_ASYNCOUT_CLEAN = 11,
    VDS_ASYNCOUT_CREATELUN = 50,
    VDS_ASYNCOUT_ADDLUNPLEX = 52,
    VDS_ASYNCOUT_REMOVELUNPLEX = 53,
    VDS_ASYNCOUT_EXTENDLUN = 54,
    VDS_ASYNCOUT_SHRINKLUN = 55,
    VDS_ASYNCOUT_RECOVERLUN = 56,
    VDS_ASYNCOUT_LOGINTOTARGET = 60,
    VDS_ASYNCOUT_LOGOUTFROMTARGET = 61,
    VDS_ASYNCOUT_CREATETARGET = 62,
    VDS_ASYNCOUT_CREATEPORTALGROUP = 63,
    VDS_ASYNCOUT_DELETETARGET = 64,
    VDS_ASYNCOUT_ADDPORTAL = 65,
    VDS_ASYNCOUT_REMOVEPORTAL = 66,
    VDS_ASYNCOUT_DELETEPORTALGROUP = 67,
    VDS_ASYNCOUT_FORMAT = 101,
    VDS_ASYNCOUT_CREATE_VDISK = 200,
    VDS_ASYNCOUT_ATTACH_VDISK = 201,
    VDS_ASYNCOUT_COMPACT_VDISK = 202,
    VDS_ASYNCOUT_MERGE_VDISK = 203,
    VDS_ASYNCOUT_EXPAND_VDISK = 204,
}

struct VDS_ASYNC_OUTPUT
{
    VDS_ASYNC_OUTPUT_TYPE type;
    _Anonymous_e__Union Anonymous;
}

enum VDS_IPADDRESS_TYPE
{
    VDS_IPT_TEXT = 0,
    VDS_IPT_IPV4 = 1,
    VDS_IPT_IPV6 = 2,
    VDS_IPT_EMPTY = 3,
}

enum VDS_HEALTH
{
    VDS_H_UNKNOWN = 0,
    VDS_H_HEALTHY = 1,
    VDS_H_REBUILDING = 2,
    VDS_H_STALE = 3,
    VDS_H_FAILING = 4,
    VDS_H_FAILING_REDUNDANCY = 5,
    VDS_H_FAILED_REDUNDANCY = 6,
    VDS_H_FAILED_REDUNDANCY_FAILING = 7,
    VDS_H_FAILED = 8,
    VDS_H_REPLACED = 9,
    VDS_H_PENDING_FAILURE = 10,
    VDS_H_DEGRADED = 11,
}

enum VDS_TRANSITION_STATE
{
    VDS_TS_UNKNOWN = 0,
    VDS_TS_STABLE = 1,
    VDS_TS_EXTENDING = 2,
    VDS_TS_SHRINKING = 3,
    VDS_TS_RECONFIGING = 4,
    VDS_TS_RESTRIPING = 5,
}

enum VDS_FILE_SYSTEM_TYPE
{
    VDS_FST_UNKNOWN = 0,
    VDS_FST_RAW = 1,
    VDS_FST_FAT = 2,
    VDS_FST_FAT32 = 3,
    VDS_FST_NTFS = 4,
    VDS_FST_CDFS = 5,
    VDS_FST_UDF = 6,
    VDS_FST_EXFAT = 7,
    VDS_FST_CSVFS = 8,
    VDS_FST_REFS = 9,
}

enum VDS_HBAPORT_TYPE
{
    VDS_HPT_UNKNOWN = 1,
    VDS_HPT_OTHER = 2,
    VDS_HPT_NOTPRESENT = 3,
    VDS_HPT_NPORT = 5,
    VDS_HPT_NLPORT = 6,
    VDS_HPT_FLPORT = 7,
    VDS_HPT_FPORT = 8,
    VDS_HPT_EPORT = 9,
    VDS_HPT_GPORT = 10,
    VDS_HPT_LPORT = 20,
    VDS_HPT_PTP = 21,
}

enum VDS_HBAPORT_STATUS
{
    VDS_HPS_UNKNOWN = 1,
    VDS_HPS_ONLINE = 2,
    VDS_HPS_OFFLINE = 3,
    VDS_HPS_BYPASSED = 4,
    VDS_HPS_DIAGNOSTICS = 5,
    VDS_HPS_LINKDOWN = 6,
    VDS_HPS_ERROR = 7,
    VDS_HPS_LOOPBACK = 8,
}

enum VDS_HBAPORT_SPEED_FLAG
{
    VDS_HSF_UNKNOWN = 0,
    VDS_HSF_1GBIT = 1,
    VDS_HSF_2GBIT = 2,
    VDS_HSF_10GBIT = 4,
    VDS_HSF_4GBIT = 8,
    VDS_HSF_NOT_NEGOTIATED = 32768,
}

enum VDS_PATH_STATUS
{
    VDS_MPS_UNKNOWN = 0,
    VDS_MPS_ONLINE = 1,
    VDS_MPS_FAILED = 5,
    VDS_MPS_STANDBY = 7,
}

enum VDS_LOADBALANCE_POLICY_ENUM
{
    VDS_LBP_UNKNOWN = 0,
    VDS_LBP_FAILOVER = 1,
    VDS_LBP_ROUND_ROBIN = 2,
    VDS_LBP_ROUND_ROBIN_WITH_SUBSET = 3,
    VDS_LBP_DYN_LEAST_QUEUE_DEPTH = 4,
    VDS_LBP_WEIGHTED_PATHS = 5,
    VDS_LBP_LEAST_BLOCKS = 6,
    VDS_LBP_VENDOR_SPECIFIC = 7,
}

enum VDS_PROVIDER_LBSUPPORT_FLAG
{
    VDS_LBF_FAILOVER = 1,
    VDS_LBF_ROUND_ROBIN = 2,
    VDS_LBF_ROUND_ROBIN_WITH_SUBSET = 4,
    VDS_LBF_DYN_LEAST_QUEUE_DEPTH = 8,
    VDS_LBF_WEIGHTED_PATHS = 16,
    VDS_LBF_LEAST_BLOCKS = 32,
    VDS_LBF_VENDOR_SPECIFIC = 64,
}

enum VDS_VERSION_SUPPORT_FLAG
{
    VDS_VSF_1_0 = 1,
    VDS_VSF_1_1 = 2,
    VDS_VSF_2_0 = 4,
    VDS_VSF_2_1 = 8,
    VDS_VSF_3_0 = 16,
}

enum VDS_HWPROVIDER_TYPE
{
    VDS_HWT_UNKNOWN = 0,
    VDS_HWT_PCI_RAID = 1,
    VDS_HWT_FIBRE_CHANNEL = 2,
    VDS_HWT_ISCSI = 3,
    VDS_HWT_SAS = 4,
    VDS_HWT_HYBRID = 5,
}

enum VDS_ISCSI_LOGIN_TYPE
{
    VDS_ILT_MANUAL = 0,
    VDS_ILT_PERSISTENT = 1,
    VDS_ILT_BOOT = 2,
}

enum VDS_ISCSI_AUTH_TYPE
{
    VDS_IAT_NONE = 0,
    VDS_IAT_CHAP = 1,
    VDS_IAT_MUTUAL_CHAP = 2,
}

enum VDS_ISCSI_IPSEC_FLAG
{
    VDS_IIF_VALID = 1,
    VDS_IIF_IKE = 2,
    VDS_IIF_MAIN_MODE = 4,
    VDS_IIF_AGGRESSIVE_MODE = 8,
    VDS_IIF_PFS_ENABLE = 16,
    VDS_IIF_TRANSPORT_MODE_PREFERRED = 32,
    VDS_IIF_TUNNEL_MODE_PREFERRED = 64,
}

enum VDS_ISCSI_LOGIN_FLAG
{
    VDS_ILF_REQUIRE_IPSEC = 1,
    VDS_ILF_MULTIPATH_ENABLED = 2,
}

struct VDS_PATH_ID
{
    ulong ullSourceId;
    ulong ullPathId;
}

struct VDS_WWN
{
    ubyte rguchWwn;
}

struct VDS_IPADDRESS
{
    VDS_IPADDRESS_TYPE type;
    uint ipv4Address;
    ubyte ipv6Address;
    uint ulIpv6FlowInfo;
    uint ulIpv6ScopeId;
    ushort wszTextAddress;
    uint ulPort;
}

struct VDS_ISCSI_IPSEC_KEY
{
    ubyte* pKey;
    uint ulKeySize;
}

struct VDS_ISCSI_SHARED_SECRET
{
    ubyte* pSharedSecret;
    uint ulSharedSecretSize;
}

struct VDS_HBAPORT_PROP
{
    Guid id;
    VDS_WWN wwnNode;
    VDS_WWN wwnPort;
    VDS_HBAPORT_TYPE type;
    VDS_HBAPORT_STATUS status;
    uint ulPortSpeed;
    uint ulSupportedPortSpeed;
}

struct VDS_ISCSI_INITIATOR_ADAPTER_PROP
{
    Guid id;
    const(wchar)* pwszName;
}

struct VDS_ISCSI_INITIATOR_PORTAL_PROP
{
    Guid id;
    VDS_IPADDRESS address;
    uint ulPortIndex;
}

struct VDS_PROVIDER_PROP
{
    Guid id;
    const(wchar)* pwszName;
    Guid guidVersionId;
    const(wchar)* pwszVersion;
    VDS_PROVIDER_TYPE type;
    uint ulFlags;
    uint ulStripeSizeFlags;
    short sRebuildPriority;
}

struct VDS_PATH_INFO
{
    VDS_PATH_ID pathId;
    VDS_HWPROVIDER_TYPE type;
    VDS_PATH_STATUS status;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
}

struct VDS_PATH_POLICY
{
    VDS_PATH_ID pathId;
    BOOL bPrimaryPath;
    uint ulWeight;
}

const GUID IID_IEnumVdsObject = {0x118610B7, 0x8D94, 0x4030, [0xB5, 0xB8, 0x50, 0x08, 0x89, 0x78, 0x8E, 0x4E]};
@GUID(0x118610B7, 0x8D94, 0x4030, [0xB5, 0xB8, 0x50, 0x08, 0x89, 0x78, 0x8E, 0x4E]);
interface IEnumVdsObject : IUnknown
{
    HRESULT Next(uint celt, char* ppObjectArray, uint* pcFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumVdsObject* ppEnum);
}

const GUID IID_IVdsAsync = {0xD5D23B6D, 0x5A55, 0x4492, [0x98, 0x89, 0x39, 0x7A, 0x3C, 0x2D, 0x2D, 0xBC]};
@GUID(0xD5D23B6D, 0x5A55, 0x4492, [0x98, 0x89, 0x39, 0x7A, 0x3C, 0x2D, 0x2D, 0xBC]);
interface IVdsAsync : IUnknown
{
    HRESULT Cancel();
    HRESULT Wait(int* pHrResult, VDS_ASYNC_OUTPUT* pAsyncOut);
    HRESULT QueryStatus(int* pHrResult, uint* pulPercentCompleted);
}

const GUID IID_IVdsAdviseSink = {0x8326CD1D, 0xCF59, 0x4936, [0xB7, 0x86, 0x5E, 0xFC, 0x08, 0x79, 0x8E, 0x25]};
@GUID(0x8326CD1D, 0xCF59, 0x4936, [0xB7, 0x86, 0x5E, 0xFC, 0x08, 0x79, 0x8E, 0x25]);
interface IVdsAdviseSink : IUnknown
{
    HRESULT OnNotify(int lNumberOfNotifications, char* pNotificationArray);
}

const GUID IID_IVdsProvider = {0x10C5E575, 0x7984, 0x4E81, [0xA5, 0x6B, 0x43, 0x1F, 0x5F, 0x92, 0xAE, 0x42]};
@GUID(0x10C5E575, 0x7984, 0x4E81, [0xA5, 0x6B, 0x43, 0x1F, 0x5F, 0x92, 0xAE, 0x42]);
interface IVdsProvider : IUnknown
{
    HRESULT GetProperties(VDS_PROVIDER_PROP* pProviderProp);
}

const GUID IID_IVdsProviderSupport = {0x1732BE13, 0xE8F9, 0x4A03, [0xBF, 0xBC, 0x5F, 0x61, 0x6A, 0xA6, 0x6C, 0xE1]};
@GUID(0x1732BE13, 0xE8F9, 0x4A03, [0xBF, 0xBC, 0x5F, 0x61, 0x6A, 0xA6, 0x6C, 0xE1]);
interface IVdsProviderSupport : IUnknown
{
    HRESULT GetVersionSupport(uint* ulVersionSupport);
}

const GUID IID_IVdsProviderPrivate = {0x11F3CD41, 0xB7E8, 0x48FF, [0x94, 0x72, 0x9D, 0xFF, 0x01, 0x8A, 0xA2, 0x92]};
@GUID(0x11F3CD41, 0xB7E8, 0x48FF, [0x94, 0x72, 0x9D, 0xFF, 0x01, 0x8A, 0xA2, 0x92]);
interface IVdsProviderPrivate : IUnknown
{
    HRESULT GetObjectA(Guid ObjectId, VDS_OBJECT_TYPE type, IUnknown* ppObjectUnk);
    HRESULT OnLoad(const(wchar)* pwszMachineName, IUnknown pCallbackObject);
    HRESULT OnUnload(BOOL bForceUnload);
}

enum VDS_SUB_SYSTEM_STATUS
{
    VDS_SSS_UNKNOWN = 0,
    VDS_SSS_ONLINE = 1,
    VDS_SSS_NOT_READY = 2,
    VDS_SSS_OFFLINE = 4,
    VDS_SSS_FAILED = 5,
    VDS_SSS_PARTIALLY_MANAGED = 9,
}

enum VDS_SUB_SYSTEM_FLAG
{
    VDS_SF_LUN_MASKING_CAPABLE = 1,
    VDS_SF_LUN_PLEXING_CAPABLE = 2,
    VDS_SF_LUN_REMAPPING_CAPABLE = 4,
    VDS_SF_DRIVE_EXTENT_CAPABLE = 8,
    VDS_SF_HARDWARE_CHECKSUM_CAPABLE = 16,
    VDS_SF_RADIUS_CAPABLE = 32,
    VDS_SF_READ_BACK_VERIFY_CAPABLE = 64,
    VDS_SF_WRITE_THROUGH_CACHING_CAPABLE = 128,
    VDS_SF_SUPPORTS_FAULT_TOLERANT_LUNS = 512,
    VDS_SF_SUPPORTS_NON_FAULT_TOLERANT_LUNS = 1024,
    VDS_SF_SUPPORTS_SIMPLE_LUNS = 2048,
    VDS_SF_SUPPORTS_SPAN_LUNS = 4096,
    VDS_SF_SUPPORTS_STRIPE_LUNS = 8192,
    VDS_SF_SUPPORTS_MIRROR_LUNS = 16384,
    VDS_SF_SUPPORTS_PARITY_LUNS = 32768,
    VDS_SF_SUPPORTS_AUTH_CHAP = 65536,
    VDS_SF_SUPPORTS_AUTH_MUTUAL_CHAP = 131072,
    VDS_SF_SUPPORTS_SIMPLE_TARGET_CONFIG = 262144,
    VDS_SF_SUPPORTS_LUN_NUMBER = 524288,
    VDS_SF_SUPPORTS_MIRRORED_CACHE = 1048576,
    VDS_SF_READ_CACHING_CAPABLE = 2097152,
    VDS_SF_WRITE_CACHING_CAPABLE = 4194304,
    VDS_SF_MEDIA_SCAN_CAPABLE = 8388608,
    VDS_SF_CONSISTENCY_CHECK_CAPABLE = 16777216,
}

enum VDS_SUB_SYSTEM_SUPPORTED_RAID_TYPE_FLAG
{
    VDS_SF_SUPPORTS_RAID2_LUNS = 1,
    VDS_SF_SUPPORTS_RAID3_LUNS = 2,
    VDS_SF_SUPPORTS_RAID4_LUNS = 4,
    VDS_SF_SUPPORTS_RAID5_LUNS = 8,
    VDS_SF_SUPPORTS_RAID6_LUNS = 16,
    VDS_SF_SUPPORTS_RAID01_LUNS = 32,
    VDS_SF_SUPPORTS_RAID03_LUNS = 64,
    VDS_SF_SUPPORTS_RAID05_LUNS = 128,
    VDS_SF_SUPPORTS_RAID10_LUNS = 256,
    VDS_SF_SUPPORTS_RAID15_LUNS = 512,
    VDS_SF_SUPPORTS_RAID30_LUNS = 1024,
    VDS_SF_SUPPORTS_RAID50_LUNS = 2048,
    VDS_SF_SUPPORTS_RAID51_LUNS = 4096,
    VDS_SF_SUPPORTS_RAID53_LUNS = 8192,
    VDS_SF_SUPPORTS_RAID60_LUNS = 16384,
    VDS_SF_SUPPORTS_RAID61_LUNS = 32768,
}

enum VDS_INTERCONNECT_FLAG
{
    VDS_ITF_PCI_RAID = 1,
    VDS_ITF_FIBRE_CHANNEL = 2,
    VDS_ITF_ISCSI = 4,
    VDS_ITF_SAS = 8,
}

enum VDS_CONTROLLER_STATUS
{
    VDS_CS_UNKNOWN = 0,
    VDS_CS_ONLINE = 1,
    VDS_CS_NOT_READY = 2,
    VDS_CS_OFFLINE = 4,
    VDS_CS_FAILED = 5,
    VDS_CS_REMOVED = 8,
}

enum VDS_PORT_STATUS
{
    VDS_PRS_UNKNOWN = 0,
    VDS_PRS_ONLINE = 1,
    VDS_PRS_NOT_READY = 2,
    VDS_PRS_OFFLINE = 4,
    VDS_PRS_FAILED = 5,
    VDS_PRS_REMOVED = 8,
}

enum VDS_DRIVE_STATUS
{
    VDS_DRS_UNKNOWN = 0,
    VDS_DRS_ONLINE = 1,
    VDS_DRS_NOT_READY = 2,
    VDS_DRS_OFFLINE = 4,
    VDS_DRS_FAILED = 5,
    VDS_DRS_REMOVED = 8,
}

enum VDS_DRIVE_FLAG
{
    VDS_DRF_HOTSPARE = 1,
    VDS_DRF_ASSIGNED = 2,
    VDS_DRF_UNASSIGNED = 4,
    VDS_DRF_HOTSPARE_IN_USE = 8,
    VDS_DRF_HOTSPARE_STANDBY = 16,
}

enum VDS_LUN_TYPE
{
    VDS_LT_UNKNOWN = 0,
    VDS_LT_DEFAULT = 1,
    VDS_LT_FAULT_TOLERANT = 2,
    VDS_LT_NON_FAULT_TOLERANT = 3,
    VDS_LT_SIMPLE = 10,
    VDS_LT_SPAN = 11,
    VDS_LT_STRIPE = 12,
    VDS_LT_MIRROR = 13,
    VDS_LT_PARITY = 14,
    VDS_LT_RAID2 = 15,
    VDS_LT_RAID3 = 16,
    VDS_LT_RAID4 = 17,
    VDS_LT_RAID5 = 18,
    VDS_LT_RAID6 = 19,
    VDS_LT_RAID01 = 20,
    VDS_LT_RAID03 = 21,
    VDS_LT_RAID05 = 22,
    VDS_LT_RAID10 = 23,
    VDS_LT_RAID15 = 24,
    VDS_LT_RAID30 = 25,
    VDS_LT_RAID50 = 26,
    VDS_LT_RAID51 = 27,
    VDS_LT_RAID53 = 28,
    VDS_LT_RAID60 = 29,
    VDS_LT_RAID61 = 30,
}

enum VDS_LUN_STATUS
{
    VDS_LS_UNKNOWN = 0,
    VDS_LS_ONLINE = 1,
    VDS_LS_NOT_READY = 2,
    VDS_LS_OFFLINE = 4,
    VDS_LS_FAILED = 5,
}

enum VDS_LUN_FLAG
{
    VDS_LF_LBN_REMAP_ENABLED = 1,
    VDS_LF_READ_BACK_VERIFY_ENABLED = 2,
    VDS_LF_WRITE_THROUGH_CACHING_ENABLED = 4,
    VDS_LF_HARDWARE_CHECKSUM_ENABLED = 8,
    VDS_LF_READ_CACHE_ENABLED = 16,
    VDS_LF_WRITE_CACHE_ENABLED = 32,
    VDS_LF_MEDIA_SCAN_ENABLED = 64,
    VDS_LF_CONSISTENCY_CHECK_ENABLED = 128,
    VDS_LF_SNAPSHOT = 256,
}

enum VDS_LUN_PLEX_TYPE
{
    VDS_LPT_UNKNOWN = 0,
    VDS_LPT_SIMPLE = 10,
    VDS_LPT_SPAN = 11,
    VDS_LPT_STRIPE = 12,
    VDS_LPT_PARITY = 14,
    VDS_LPT_RAID2 = 15,
    VDS_LPT_RAID3 = 16,
    VDS_LPT_RAID4 = 17,
    VDS_LPT_RAID5 = 18,
    VDS_LPT_RAID6 = 19,
    VDS_LPT_RAID03 = 21,
    VDS_LPT_RAID05 = 22,
    VDS_LPT_RAID10 = 23,
    VDS_LPT_RAID15 = 24,
    VDS_LPT_RAID30 = 25,
    VDS_LPT_RAID50 = 26,
    VDS_LPT_RAID53 = 28,
    VDS_LPT_RAID60 = 29,
}

enum VDS_LUN_PLEX_STATUS
{
    VDS_LPS_UNKNOWN = 0,
    VDS_LPS_ONLINE = 1,
    VDS_LPS_NOT_READY = 2,
    VDS_LPS_OFFLINE = 4,
    VDS_LPS_FAILED = 5,
}

enum VDS_LUN_PLEX_FLAG
{
    VDS_LPF_LBN_REMAP_ENABLED = 1,
}

enum VDS_ISCSI_PORTAL_STATUS
{
    VDS_IPS_UNKNOWN = 0,
    VDS_IPS_ONLINE = 1,
    VDS_IPS_NOT_READY = 2,
    VDS_IPS_OFFLINE = 4,
    VDS_IPS_FAILED = 5,
}

enum VDS_STORAGE_POOL_STATUS
{
    VDS_SPS_UNKNOWN = 0,
    VDS_SPS_ONLINE = 1,
    VDS_SPS_NOT_READY = 2,
    VDS_SPS_OFFLINE = 4,
}

enum VDS_STORAGE_POOL_TYPE
{
    VDS_SPT_UNKNOWN = 0,
    VDS_SPT_PRIMORDIAL = 1,
    VDS_SPT_CONCRETE = 2,
}

enum VDS_MAINTENANCE_OPERATION
{
    BlinkLight = 1,
    BeepAlarm = 2,
    SpinDown = 3,
    SpinUp = 4,
    Ping = 5,
}

struct VDS_HINTS
{
    ulong ullHintMask;
    ulong ullExpectedMaximumSize;
    uint ulOptimalReadSize;
    uint ulOptimalReadAlignment;
    uint ulOptimalWriteSize;
    uint ulOptimalWriteAlignment;
    uint ulMaximumDriveCount;
    uint ulStripeSize;
    BOOL bFastCrashRecoveryRequired;
    BOOL bMostlyReads;
    BOOL bOptimizeForSequentialReads;
    BOOL bOptimizeForSequentialWrites;
    BOOL bRemapEnabled;
    BOOL bReadBackVerifyEnabled;
    BOOL bWriteThroughCachingEnabled;
    BOOL bHardwareChecksumEnabled;
    BOOL bIsYankable;
    short sRebuildPriority;
}

struct VDS_HINTS2
{
    ulong ullHintMask;
    ulong ullExpectedMaximumSize;
    uint ulOptimalReadSize;
    uint ulOptimalReadAlignment;
    uint ulOptimalWriteSize;
    uint ulOptimalWriteAlignment;
    uint ulMaximumDriveCount;
    uint ulStripeSize;
    uint ulReserved1;
    uint ulReserved2;
    uint ulReserved3;
    BOOL bFastCrashRecoveryRequired;
    BOOL bMostlyReads;
    BOOL bOptimizeForSequentialReads;
    BOOL bOptimizeForSequentialWrites;
    BOOL bRemapEnabled;
    BOOL bReadBackVerifyEnabled;
    BOOL bWriteThroughCachingEnabled;
    BOOL bHardwareChecksumEnabled;
    BOOL bIsYankable;
    BOOL bAllocateHotSpare;
    BOOL bUseMirroredCache;
    BOOL bReadCachingEnabled;
    BOOL bWriteCachingEnabled;
    BOOL bMediaScanEnabled;
    BOOL bConsistencyCheckEnabled;
    VDS_STORAGE_BUS_TYPE BusType;
    BOOL bReserved1;
    BOOL bReserved2;
    BOOL bReserved3;
    short sRebuildPriority;
}

struct VDS_SUB_SYSTEM_PROP
{
    Guid id;
    const(wchar)* pwszFriendlyName;
    const(wchar)* pwszIdentification;
    uint ulFlags;
    uint ulStripeSizeFlags;
    VDS_SUB_SYSTEM_STATUS status;
    VDS_HEALTH health;
    short sNumberOfInternalBuses;
    short sMaxNumberOfSlotsEachBus;
    short sMaxNumberOfControllers;
    short sRebuildPriority;
}

struct VDS_SUB_SYSTEM_PROP2
{
    Guid id;
    const(wchar)* pwszFriendlyName;
    const(wchar)* pwszIdentification;
    uint ulFlags;
    uint ulStripeSizeFlags;
    uint ulSupportedRaidTypeFlags;
    VDS_SUB_SYSTEM_STATUS status;
    VDS_HEALTH health;
    short sNumberOfInternalBuses;
    short sMaxNumberOfSlotsEachBus;
    short sMaxNumberOfControllers;
    short sRebuildPriority;
    uint ulNumberOfEnclosures;
}

struct VDS_CONTROLLER_PROP
{
    Guid id;
    const(wchar)* pwszFriendlyName;
    const(wchar)* pwszIdentification;
    VDS_CONTROLLER_STATUS status;
    VDS_HEALTH health;
    short sNumberOfPorts;
}

struct VDS_DRIVE_PROP
{
    Guid id;
    ulong ullSize;
    const(wchar)* pwszFriendlyName;
    const(wchar)* pwszIdentification;
    uint ulFlags;
    VDS_DRIVE_STATUS status;
    VDS_HEALTH health;
    short sInternalBusNumber;
    short sSlotNumber;
}

struct VDS_DRIVE_PROP2
{
    Guid id;
    ulong ullSize;
    const(wchar)* pwszFriendlyName;
    const(wchar)* pwszIdentification;
    uint ulFlags;
    VDS_DRIVE_STATUS status;
    VDS_HEALTH health;
    short sInternalBusNumber;
    short sSlotNumber;
    uint ulEnclosureNumber;
    VDS_STORAGE_BUS_TYPE busType;
    uint ulSpindleSpeed;
}

struct VDS_DRIVE_EXTENT
{
    Guid id;
    Guid LunId;
    ulong ullSize;
    BOOL bUsed;
}

struct VDS_LUN_PROP
{
    Guid id;
    ulong ullSize;
    const(wchar)* pwszFriendlyName;
    const(wchar)* pwszIdentification;
    const(wchar)* pwszUnmaskingList;
    uint ulFlags;
    VDS_LUN_TYPE type;
    VDS_LUN_STATUS status;
    VDS_HEALTH health;
    VDS_TRANSITION_STATE TransitionState;
    short sRebuildPriority;
}

struct VDS_LUN_PLEX_PROP
{
    Guid id;
    ulong ullSize;
    VDS_LUN_PLEX_TYPE type;
    VDS_LUN_PLEX_STATUS status;
    VDS_HEALTH health;
    VDS_TRANSITION_STATE TransitionState;
    uint ulFlags;
    uint ulStripeSize;
    short sRebuildPriority;
}

struct VDS_PORT_PROP
{
    Guid id;
    const(wchar)* pwszFriendlyName;
    const(wchar)* pwszIdentification;
    VDS_PORT_STATUS status;
}

struct VDS_ISCSI_PORTAL_PROP
{
    Guid id;
    VDS_IPADDRESS address;
    VDS_ISCSI_PORTAL_STATUS status;
}

struct VDS_ISCSI_TARGET_PROP
{
    Guid id;
    const(wchar)* pwszIscsiName;
    const(wchar)* pwszFriendlyName;
    BOOL bChapEnabled;
}

struct VDS_ISCSI_PORTALGROUP_PROP
{
    Guid id;
    ushort tag;
}

enum VDS_RAID_TYPE
{
    VDS_RT_UNKNOWN = 0,
    VDS_RT_RAID0 = 10,
    VDS_RT_RAID1 = 11,
    VDS_RT_RAID2 = 12,
    VDS_RT_RAID3 = 13,
    VDS_RT_RAID4 = 14,
    VDS_RT_RAID5 = 15,
    VDS_RT_RAID6 = 16,
    VDS_RT_RAID01 = 17,
    VDS_RT_RAID03 = 18,
    VDS_RT_RAID05 = 19,
    VDS_RT_RAID10 = 20,
    VDS_RT_RAID15 = 21,
    VDS_RT_RAID30 = 22,
    VDS_RT_RAID50 = 23,
    VDS_RT_RAID51 = 24,
    VDS_RT_RAID53 = 25,
    VDS_RT_RAID60 = 26,
    VDS_RT_RAID61 = 27,
}

struct VDS_POOL_CUSTOM_ATTRIBUTES
{
    const(wchar)* pwszName;
    const(wchar)* pwszValue;
}

struct VDS_POOL_ATTRIBUTES
{
    ulong ullAttributeMask;
    VDS_RAID_TYPE raidType;
    VDS_STORAGE_BUS_TYPE busType;
    const(wchar)* pwszIntendedUsage;
    BOOL bSpinDown;
    BOOL bIsThinProvisioned;
    ulong ullProvisionedSpace;
    BOOL bNoSinglePointOfFailure;
    uint ulDataRedundancyMax;
    uint ulDataRedundancyMin;
    uint ulDataRedundancyDefault;
    uint ulPackageRedundancyMax;
    uint ulPackageRedundancyMin;
    uint ulPackageRedundancyDefault;
    uint ulStripeSize;
    uint ulStripeSizeMax;
    uint ulStripeSizeMin;
    uint ulDefaultStripeSize;
    uint ulNumberOfColumns;
    uint ulNumberOfColumnsMax;
    uint ulNumberOfColumnsMin;
    uint ulDefaultNumberofColumns;
    uint ulDataAvailabilityHint;
    uint ulAccessRandomnessHint;
    uint ulAccessDirectionHint;
    uint ulAccessSizeHint;
    uint ulAccessLatencyHint;
    uint ulAccessBandwidthWeightHint;
    uint ulStorageCostHint;
    uint ulStorageEfficiencyHint;
    uint ulNumOfCustomAttributes;
    VDS_POOL_CUSTOM_ATTRIBUTES* pPoolCustomAttributes;
    BOOL bReserved1;
    BOOL bReserved2;
    uint ulReserved1;
    uint ulReserved2;
    ulong ullReserved1;
    ulong ullReserved2;
}

struct VDS_STORAGE_POOL_PROP
{
    Guid id;
    VDS_STORAGE_POOL_STATUS status;
    VDS_HEALTH health;
    VDS_STORAGE_POOL_TYPE type;
    const(wchar)* pwszName;
    const(wchar)* pwszDescription;
    ulong ullTotalConsumedSpace;
    ulong ullTotalManagedSpace;
    ulong ullRemainingFreeSpace;
}

struct VDS_STORAGE_POOL_DRIVE_EXTENT
{
    Guid id;
    ulong ullSize;
    BOOL bUsed;
}

const GUID IID_IVdsHwProvider = {0xD99BDAAE, 0xB13A, 0x4178, [0x9F, 0xDB, 0xE2, 0x7F, 0x16, 0xB4, 0x60, 0x3E]};
@GUID(0xD99BDAAE, 0xB13A, 0x4178, [0x9F, 0xDB, 0xE2, 0x7F, 0x16, 0xB4, 0x60, 0x3E]);
interface IVdsHwProvider : IUnknown
{
    HRESULT QuerySubSystems(IEnumVdsObject* ppEnum);
    HRESULT Reenumerate();
    HRESULT Refresh();
}

const GUID IID_IVdsHwProviderType = {0x3E0F5166, 0x542D, 0x4FC6, [0x94, 0x7A, 0x01, 0x21, 0x74, 0x24, 0x0B, 0x7E]};
@GUID(0x3E0F5166, 0x542D, 0x4FC6, [0x94, 0x7A, 0x01, 0x21, 0x74, 0x24, 0x0B, 0x7E]);
interface IVdsHwProviderType : IUnknown
{
    HRESULT GetProviderType(VDS_HWPROVIDER_TYPE* pType);
}

const GUID IID_IVdsHwProviderType2 = {0x8190236F, 0xC4D0, 0x4E81, [0x80, 0x11, 0xD6, 0x95, 0x12, 0xFC, 0xC9, 0x84]};
@GUID(0x8190236F, 0xC4D0, 0x4E81, [0x80, 0x11, 0xD6, 0x95, 0x12, 0xFC, 0xC9, 0x84]);
interface IVdsHwProviderType2 : IUnknown
{
    HRESULT GetProviderType2(VDS_HWPROVIDER_TYPE* pType);
}

const GUID IID_IVdsHwProviderStoragePools = {0xD5B5937A, 0xF188, 0x4C79, [0xB8, 0x6C, 0x11, 0xC9, 0x20, 0xAD, 0x11, 0xB8]};
@GUID(0xD5B5937A, 0xF188, 0x4C79, [0xB8, 0x6C, 0x11, 0xC9, 0x20, 0xAD, 0x11, 0xB8]);
interface IVdsHwProviderStoragePools : IUnknown
{
    HRESULT QueryStoragePools(uint ulFlags, ulong ullRemainingFreeSpace, VDS_POOL_ATTRIBUTES* pPoolAttributes, IEnumVdsObject* ppEnum);
    HRESULT CreateLunInStoragePool(VDS_LUN_TYPE type, ulong ullSizeInBytes, Guid StoragePoolId, const(wchar)* pwszUnmaskingList, VDS_HINTS2* pHints2, IVdsAsync* ppAsync);
    HRESULT QueryMaxLunCreateSizeInStoragePool(VDS_LUN_TYPE type, Guid StoragePoolId, VDS_HINTS2* pHints2, ulong* pullMaxLunSize);
}

const GUID IID_IVdsSubSystem = {0x6FCEE2D3, 0x6D90, 0x4F91, [0x80, 0xE2, 0xA5, 0xC7, 0xCA, 0xAC, 0xA9, 0xD8]};
@GUID(0x6FCEE2D3, 0x6D90, 0x4F91, [0x80, 0xE2, 0xA5, 0xC7, 0xCA, 0xAC, 0xA9, 0xD8]);
interface IVdsSubSystem : IUnknown
{
    HRESULT GetProperties(VDS_SUB_SYSTEM_PROP* pSubSystemProp);
    HRESULT GetProvider(IVdsProvider* ppProvider);
    HRESULT QueryControllers(IEnumVdsObject* ppEnum);
    HRESULT QueryLuns(IEnumVdsObject* ppEnum);
    HRESULT QueryDrives(IEnumVdsObject* ppEnum);
    HRESULT GetDrive(short sBusNumber, short sSlotNumber, IVdsDrive* ppDrive);
    HRESULT Reenumerate();
    HRESULT SetControllerStatus(char* pOnlineControllerIdArray, int lNumberOfOnlineControllers, char* pOfflineControllerIdArray, int lNumberOfOfflineControllers);
    HRESULT CreateLun(VDS_LUN_TYPE type, ulong ullSizeInBytes, char* pDriveIdArray, int lNumberOfDrives, const(wchar)* pwszUnmaskingList, VDS_HINTS* pHints, IVdsAsync* ppAsync);
    HRESULT ReplaceDrive(Guid DriveToBeReplaced, Guid ReplacementDrive);
    HRESULT SetStatus(VDS_SUB_SYSTEM_STATUS status);
    HRESULT QueryMaxLunCreateSize(VDS_LUN_TYPE type, char* pDriveIdArray, int lNumberOfDrives, VDS_HINTS* pHints, ulong* pullMaxLunSize);
}

const GUID IID_IVdsSubSystem2 = {0xBE666735, 0x7800, 0x4A77, [0x9D, 0x9C, 0x40, 0xF8, 0x5B, 0x87, 0xE2, 0x92]};
@GUID(0xBE666735, 0x7800, 0x4A77, [0x9D, 0x9C, 0x40, 0xF8, 0x5B, 0x87, 0xE2, 0x92]);
interface IVdsSubSystem2 : IUnknown
{
    HRESULT GetProperties2(VDS_SUB_SYSTEM_PROP2* pSubSystemProp2);
    HRESULT GetDrive2(short sBusNumber, short sSlotNumber, uint ulEnclosureNumber, IVdsDrive* ppDrive);
    HRESULT CreateLun2(VDS_LUN_TYPE type, ulong ullSizeInBytes, char* pDriveIdArray, int lNumberOfDrives, const(wchar)* pwszUnmaskingList, VDS_HINTS2* pHints2, IVdsAsync* ppAsync);
    HRESULT QueryMaxLunCreateSize2(VDS_LUN_TYPE type, char* pDriveIdArray, int lNumberOfDrives, VDS_HINTS2* pHints2, ulong* pullMaxLunSize);
}

const GUID IID_IVdsSubSystemNaming = {0x0D70FAA3, 0x9CD4, 0x4900, [0xAA, 0x20, 0x69, 0x81, 0xB6, 0xAA, 0xFC, 0x75]};
@GUID(0x0D70FAA3, 0x9CD4, 0x4900, [0xAA, 0x20, 0x69, 0x81, 0xB6, 0xAA, 0xFC, 0x75]);
interface IVdsSubSystemNaming : IUnknown
{
    HRESULT SetFriendlyName(const(wchar)* pwszFriendlyName);
}

const GUID IID_IVdsSubSystemIscsi = {0x0027346F, 0x40D0, 0x4B45, [0x8C, 0xEC, 0x59, 0x06, 0xDC, 0x03, 0x80, 0xC8]};
@GUID(0x0027346F, 0x40D0, 0x4B45, [0x8C, 0xEC, 0x59, 0x06, 0xDC, 0x03, 0x80, 0xC8]);
interface IVdsSubSystemIscsi : IUnknown
{
    HRESULT QueryTargets(IEnumVdsObject* ppEnum);
    HRESULT QueryPortals(IEnumVdsObject* ppEnum);
    HRESULT CreateTarget(const(wchar)* pwszIscsiName, const(wchar)* pwszFriendlyName, IVdsAsync* ppAsync);
    HRESULT SetIpsecGroupPresharedKey(VDS_ISCSI_IPSEC_KEY* pIpsecKey);
}

const GUID IID_IVdsSubSystemInterconnect = {0x9E6FA560, 0xC141, 0x477B, [0x83, 0xBA, 0x0B, 0x6C, 0x38, 0xF7, 0xFE, 0xBF]};
@GUID(0x9E6FA560, 0xC141, 0x477B, [0x83, 0xBA, 0x0B, 0x6C, 0x38, 0xF7, 0xFE, 0xBF]);
interface IVdsSubSystemInterconnect : IUnknown
{
    HRESULT GetSupportedInterconnects(uint* pulSupportedInterconnectsFlag);
}

const GUID IID_IVdsControllerPort = {0x18691D0D, 0x4E7F, 0x43E8, [0x92, 0xE4, 0xCF, 0x44, 0xBE, 0xEE, 0xD1, 0x1C]};
@GUID(0x18691D0D, 0x4E7F, 0x43E8, [0x92, 0xE4, 0xCF, 0x44, 0xBE, 0xEE, 0xD1, 0x1C]);
interface IVdsControllerPort : IUnknown
{
    HRESULT GetProperties(VDS_PORT_PROP* pPortProp);
    HRESULT GetController(IVdsController* ppController);
    HRESULT QueryAssociatedLuns(IEnumVdsObject* ppEnum);
    HRESULT Reset();
    HRESULT SetStatus(VDS_PORT_STATUS status);
}

const GUID IID_IVdsController = {0xCB53D96E, 0xDFFB, 0x474A, [0xA0, 0x78, 0x79, 0x0D, 0x1E, 0x2B, 0xC0, 0x82]};
@GUID(0xCB53D96E, 0xDFFB, 0x474A, [0xA0, 0x78, 0x79, 0x0D, 0x1E, 0x2B, 0xC0, 0x82]);
interface IVdsController : IUnknown
{
    HRESULT GetProperties(VDS_CONTROLLER_PROP* pControllerProp);
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    HRESULT GetPortProperties(short sPortNumber, VDS_PORT_PROP* pPortProp);
    HRESULT FlushCache();
    HRESULT InvalidateCache();
    HRESULT Reset();
    HRESULT QueryAssociatedLuns(IEnumVdsObject* ppEnum);
    HRESULT SetStatus(VDS_CONTROLLER_STATUS status);
}

const GUID IID_IVdsControllerControllerPort = {0xCA5D735F, 0x6BAE, 0x42C0, [0xB3, 0x0E, 0xF2, 0x66, 0x60, 0x45, 0xCE, 0x71]};
@GUID(0xCA5D735F, 0x6BAE, 0x42C0, [0xB3, 0x0E, 0xF2, 0x66, 0x60, 0x45, 0xCE, 0x71]);
interface IVdsControllerControllerPort : IUnknown
{
    HRESULT QueryControllerPorts(IEnumVdsObject* ppEnum);
}

const GUID IID_IVdsDrive = {0xFF24EFA4, 0xAADE, 0x4B6B, [0x89, 0x8B, 0xEA, 0xA6, 0xA2, 0x08, 0x87, 0xC7]};
@GUID(0xFF24EFA4, 0xAADE, 0x4B6B, [0x89, 0x8B, 0xEA, 0xA6, 0xA2, 0x08, 0x87, 0xC7]);
interface IVdsDrive : IUnknown
{
    HRESULT GetProperties(VDS_DRIVE_PROP* pDriveProp);
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    HRESULT QueryExtents(char* ppExtentArray, int* plNumberOfExtents);
    HRESULT SetFlags(uint ulFlags);
    HRESULT ClearFlags(uint ulFlags);
    HRESULT SetStatus(VDS_DRIVE_STATUS status);
}

const GUID IID_IVdsDrive2 = {0x60B5A730, 0xADDF, 0x4436, [0x8C, 0xA7, 0x57, 0x69, 0xE2, 0xD1, 0xFF, 0xA4]};
@GUID(0x60B5A730, 0xADDF, 0x4436, [0x8C, 0xA7, 0x57, 0x69, 0xE2, 0xD1, 0xFF, 0xA4]);
interface IVdsDrive2 : IUnknown
{
    HRESULT GetProperties2(VDS_DRIVE_PROP2* pDriveProp2);
}

const GUID IID_IVdsLun = {0x3540A9C7, 0xE60F, 0x4111, [0xA8, 0x40, 0x8B, 0xBA, 0x6C, 0x2C, 0x83, 0xD8]};
@GUID(0x3540A9C7, 0xE60F, 0x4111, [0xA8, 0x40, 0x8B, 0xBA, 0x6C, 0x2C, 0x83, 0xD8]);
interface IVdsLun : IUnknown
{
    HRESULT GetProperties(VDS_LUN_PROP* pLunProp);
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    HRESULT GetIdentificationData(VDS_LUN_INFORMATION* pLunInfo);
    HRESULT QueryActiveControllers(IEnumVdsObject* ppEnum);
    HRESULT Extend(ulong ullNumberOfBytesToAdd, char* pDriveIdArray, int lNumberOfDrives, IVdsAsync* ppAsync);
    HRESULT Shrink(ulong ullNumberOfBytesToRemove, IVdsAsync* ppAsync);
    HRESULT QueryPlexes(IEnumVdsObject* ppEnum);
    HRESULT AddPlex(Guid lunId, IVdsAsync* ppAsync);
    HRESULT RemovePlex(Guid plexId, IVdsAsync* ppAsync);
    HRESULT Recover(IVdsAsync* ppAsync);
    HRESULT SetMask(const(wchar)* pwszUnmaskingList);
    HRESULT Delete();
    HRESULT AssociateControllers(char* pActiveControllerIdArray, int lNumberOfActiveControllers, char* pInactiveControllerIdArray, int lNumberOfInactiveControllers);
    HRESULT QueryHints(VDS_HINTS* pHints);
    HRESULT ApplyHints(VDS_HINTS* pHints);
    HRESULT SetStatus(VDS_LUN_STATUS status);
    HRESULT QueryMaxLunExtendSize(char* pDriveIdArray, int lNumberOfDrives, ulong* pullMaxBytesToBeAdded);
}

const GUID IID_IVdsLun2 = {0xE5B3A735, 0x9EFB, 0x499A, [0x80, 0x71, 0x43, 0x94, 0xD9, 0xEE, 0x6F, 0xCB]};
@GUID(0xE5B3A735, 0x9EFB, 0x499A, [0x80, 0x71, 0x43, 0x94, 0xD9, 0xEE, 0x6F, 0xCB]);
interface IVdsLun2 : IUnknown
{
    HRESULT QueryHints2(VDS_HINTS2* pHints2);
    HRESULT ApplyHints2(VDS_HINTS2* pHints2);
}

const GUID IID_IVdsLunNaming = {0x907504CB, 0x6B4E, 0x4D88, [0xA3, 0x4D, 0x17, 0xBA, 0x66, 0x1F, 0xBB, 0x06]};
@GUID(0x907504CB, 0x6B4E, 0x4D88, [0xA3, 0x4D, 0x17, 0xBA, 0x66, 0x1F, 0xBB, 0x06]);
interface IVdsLunNaming : IUnknown
{
    HRESULT SetFriendlyName(const(wchar)* pwszFriendlyName);
}

const GUID IID_IVdsLunNumber = {0xD3F95E46, 0x54B3, 0x41F9, [0xB6, 0x78, 0x0F, 0x18, 0x71, 0x44, 0x3A, 0x08]};
@GUID(0xD3F95E46, 0x54B3, 0x41F9, [0xB6, 0x78, 0x0F, 0x18, 0x71, 0x44, 0x3A, 0x08]);
interface IVdsLunNumber : IUnknown
{
    HRESULT GetLunNumber(uint* pulLunNumber);
}

const GUID IID_IVdsLunControllerPorts = {0x451FE266, 0xDA6D, 0x406A, [0xBB, 0x60, 0x82, 0xE5, 0x34, 0xF8, 0x5A, 0xEB]};
@GUID(0x451FE266, 0xDA6D, 0x406A, [0xBB, 0x60, 0x82, 0xE5, 0x34, 0xF8, 0x5A, 0xEB]);
interface IVdsLunControllerPorts : IUnknown
{
    HRESULT AssociateControllerPorts(char* pActiveControllerPortIdArray, int lNumberOfActiveControllerPorts, char* pInactiveControllerPortIdArray, int lNumberOfInactiveControllerPorts);
    HRESULT QueryActiveControllerPorts(IEnumVdsObject* ppEnum);
}

const GUID IID_IVdsLunMpio = {0x7C5FBAE3, 0x333A, 0x48A1, [0xA9, 0x82, 0x33, 0xC1, 0x57, 0x88, 0xCD, 0xE3]};
@GUID(0x7C5FBAE3, 0x333A, 0x48A1, [0xA9, 0x82, 0x33, 0xC1, 0x57, 0x88, 0xCD, 0xE3]);
interface IVdsLunMpio : IUnknown
{
    HRESULT GetPathInfo(char* ppPaths, int* plNumberOfPaths);
    HRESULT GetLoadBalancePolicy(VDS_LOADBALANCE_POLICY_ENUM* pPolicy, char* ppPaths, int* plNumberOfPaths);
    HRESULT SetLoadBalancePolicy(VDS_LOADBALANCE_POLICY_ENUM policy, char* pPaths, int lNumberOfPaths);
    HRESULT GetSupportedLbPolicies(uint* pulLbFlags);
}

const GUID IID_IVdsLunIscsi = {0x0D7C1E64, 0xB59B, 0x45AE, [0xB8, 0x6A, 0x2C, 0x2C, 0xC6, 0xA4, 0x20, 0x67]};
@GUID(0x0D7C1E64, 0xB59B, 0x45AE, [0xB8, 0x6A, 0x2C, 0x2C, 0xC6, 0xA4, 0x20, 0x67]);
interface IVdsLunIscsi : IUnknown
{
    HRESULT AssociateTargets(char* pTargetIdArray, int lNumberOfTargets);
    HRESULT QueryAssociatedTargets(IEnumVdsObject* ppEnum);
}

const GUID IID_IVdsLunPlex = {0x0EE1A790, 0x5D2E, 0x4ABB, [0x8C, 0x99, 0xC4, 0x81, 0xE8, 0xBE, 0x21, 0x38]};
@GUID(0x0EE1A790, 0x5D2E, 0x4ABB, [0x8C, 0x99, 0xC4, 0x81, 0xE8, 0xBE, 0x21, 0x38]);
interface IVdsLunPlex : IUnknown
{
    HRESULT GetProperties(VDS_LUN_PLEX_PROP* pPlexProp);
    HRESULT GetLun(IVdsLun* ppLun);
    HRESULT QueryExtents(char* ppExtentArray, int* plNumberOfExtents);
    HRESULT QueryHints(VDS_HINTS* pHints);
    HRESULT ApplyHints(VDS_HINTS* pHints);
}

const GUID IID_IVdsIscsiPortal = {0x7FA1499D, 0xEC85, 0x4A8A, [0xA4, 0x7B, 0xFF, 0x69, 0x20, 0x1F, 0xCD, 0x34]};
@GUID(0x7FA1499D, 0xEC85, 0x4A8A, [0xA4, 0x7B, 0xFF, 0x69, 0x20, 0x1F, 0xCD, 0x34]);
interface IVdsIscsiPortal : IUnknown
{
    HRESULT GetProperties(VDS_ISCSI_PORTAL_PROP* pPortalProp);
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    HRESULT QueryAssociatedPortalGroups(IEnumVdsObject* ppEnum);
    HRESULT SetStatus(VDS_ISCSI_PORTAL_STATUS status);
    HRESULT SetIpsecTunnelAddress(VDS_IPADDRESS* pTunnelAddress, VDS_IPADDRESS* pDestinationAddress);
    HRESULT GetIpsecSecurity(VDS_IPADDRESS* pInitiatorPortalAddress, ulong* pullSecurityFlags);
    HRESULT SetIpsecSecurity(VDS_IPADDRESS* pInitiatorPortalAddress, ulong ullSecurityFlags, VDS_ISCSI_IPSEC_KEY* pIpsecKey);
}

const GUID IID_IVdsIscsiTarget = {0xAA8F5055, 0x83E5, 0x4BCC, [0xAA, 0x73, 0x19, 0x85, 0x1A, 0x36, 0xA8, 0x49]};
@GUID(0xAA8F5055, 0x83E5, 0x4BCC, [0xAA, 0x73, 0x19, 0x85, 0x1A, 0x36, 0xA8, 0x49]);
interface IVdsIscsiTarget : IUnknown
{
    HRESULT GetProperties(VDS_ISCSI_TARGET_PROP* pTargetProp);
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    HRESULT QueryPortalGroups(IEnumVdsObject* ppEnum);
    HRESULT QueryAssociatedLuns(IEnumVdsObject* ppEnum);
    HRESULT CreatePortalGroup(IVdsAsync* ppAsync);
    HRESULT Delete(IVdsAsync* ppAsync);
    HRESULT SetFriendlyName(const(wchar)* pwszFriendlyName);
    HRESULT SetSharedSecret(VDS_ISCSI_SHARED_SECRET* pTargetSharedSecret, const(wchar)* pwszInitiatorName);
    HRESULT RememberInitiatorSharedSecret(const(wchar)* pwszInitiatorName, VDS_ISCSI_SHARED_SECRET* pInitiatorSharedSecret);
    HRESULT GetConnectedInitiators(char* pppwszInitiatorList, int* plNumberOfInitiators);
}

const GUID IID_IVdsIscsiPortalGroup = {0xFEF5F89D, 0xA3DD, 0x4B36, [0xBF, 0x28, 0xE7, 0xDD, 0xE0, 0x45, 0xC5, 0x93]};
@GUID(0xFEF5F89D, 0xA3DD, 0x4B36, [0xBF, 0x28, 0xE7, 0xDD, 0xE0, 0x45, 0xC5, 0x93]);
interface IVdsIscsiPortalGroup : IUnknown
{
    HRESULT GetProperties(VDS_ISCSI_PORTALGROUP_PROP* pPortalGroupProp);
    HRESULT GetTarget(IVdsIscsiTarget* ppTarget);
    HRESULT QueryAssociatedPortals(IEnumVdsObject* ppEnum);
    HRESULT AddPortal(Guid portalId, IVdsAsync* ppAsync);
    HRESULT RemovePortal(Guid portalId, IVdsAsync* ppAsync);
    HRESULT Delete(IVdsAsync* ppAsync);
}

const GUID IID_IVdsStoragePool = {0x932CA8CF, 0x0EB3, 0x4BA8, [0x96, 0x20, 0x22, 0x66, 0x5D, 0x7F, 0x84, 0x50]};
@GUID(0x932CA8CF, 0x0EB3, 0x4BA8, [0x96, 0x20, 0x22, 0x66, 0x5D, 0x7F, 0x84, 0x50]);
interface IVdsStoragePool : IUnknown
{
    HRESULT GetProvider(IVdsProvider* ppProvider);
    HRESULT GetProperties(VDS_STORAGE_POOL_PROP* pStoragePoolProp);
    HRESULT GetAttributes(VDS_POOL_ATTRIBUTES* pStoragePoolAttributes);
    HRESULT QueryDriveExtents(char* ppExtentArray, int* plNumberOfExtents);
    HRESULT QueryAllocatedLuns(IEnumVdsObject* ppEnum);
    HRESULT QueryAllocatedStoragePools(IEnumVdsObject* ppEnum);
}

const GUID IID_IVdsMaintenance = {0xDAEBEEF3, 0x8523, 0x47ED, [0xA2, 0xB9, 0x05, 0xCE, 0xCC, 0xE2, 0xA1, 0xAE]};
@GUID(0xDAEBEEF3, 0x8523, 0x47ED, [0xA2, 0xB9, 0x05, 0xCE, 0xCC, 0xE2, 0xA1, 0xAE]);
interface IVdsMaintenance : IUnknown
{
    HRESULT StartMaintenance(VDS_MAINTENANCE_OPERATION operation);
    HRESULT StopMaintenance(VDS_MAINTENANCE_OPERATION operation);
    HRESULT PulseMaintenance(VDS_MAINTENANCE_OPERATION operation, uint ulCount);
}

const GUID IID_IVdsHwProviderPrivate = {0x98F17BF3, 0x9F33, 0x4F12, [0x87, 0x14, 0x8B, 0x40, 0x75, 0x09, 0x2C, 0x2E]};
@GUID(0x98F17BF3, 0x9F33, 0x4F12, [0x87, 0x14, 0x8B, 0x40, 0x75, 0x09, 0x2C, 0x2E]);
interface IVdsHwProviderPrivate : IUnknown
{
    HRESULT QueryIfCreatedLun(const(wchar)* pwszDevicePath, VDS_LUN_INFORMATION* pVdsLunInformation, Guid* pLunId);
}

const GUID IID_IVdsHwProviderPrivateMpio = {0x310A7715, 0xAC2B, 0x4C6F, [0x98, 0x27, 0x3D, 0x74, 0x2F, 0x35, 0x16, 0x76]};
@GUID(0x310A7715, 0xAC2B, 0x4C6F, [0x98, 0x27, 0x3D, 0x74, 0x2F, 0x35, 0x16, 0x76]);
interface IVdsHwProviderPrivateMpio : IUnknown
{
    HRESULT SetAllPathStatusesFromHbaPort(VDS_HBAPORT_PROP hbaPortProp, VDS_PATH_STATUS status);
}

const GUID IID_IVdsAdmin = {0xD188E97D, 0x85AA, 0x4D33, [0xAB, 0xC6, 0x26, 0x29, 0x9A, 0x10, 0xFF, 0xC1]};
@GUID(0xD188E97D, 0x85AA, 0x4D33, [0xAB, 0xC6, 0x26, 0x29, 0x9A, 0x10, 0xFF, 0xC1]);
interface IVdsAdmin : IUnknown
{
    HRESULT RegisterProvider(Guid providerId, Guid providerClsid, const(wchar)* pwszName, VDS_PROVIDER_TYPE type, const(wchar)* pwszMachineName, const(wchar)* pwszVersion, Guid guidVersionId);
    HRESULT UnregisterProvider(Guid providerId);
}

enum VSS_OBJECT_TYPE
{
    VSS_OBJECT_UNKNOWN = 0,
    VSS_OBJECT_NONE = 1,
    VSS_OBJECT_SNAPSHOT_SET = 2,
    VSS_OBJECT_SNAPSHOT = 3,
    VSS_OBJECT_PROVIDER = 4,
    VSS_OBJECT_TYPE_COUNT = 5,
}

enum VSS_SNAPSHOT_STATE
{
    VSS_SS_UNKNOWN = 0,
    VSS_SS_PREPARING = 1,
    VSS_SS_PROCESSING_PREPARE = 2,
    VSS_SS_PREPARED = 3,
    VSS_SS_PROCESSING_PRECOMMIT = 4,
    VSS_SS_PRECOMMITTED = 5,
    VSS_SS_PROCESSING_COMMIT = 6,
    VSS_SS_COMMITTED = 7,
    VSS_SS_PROCESSING_POSTCOMMIT = 8,
    VSS_SS_PROCESSING_PREFINALCOMMIT = 9,
    VSS_SS_PREFINALCOMMITTED = 10,
    VSS_SS_PROCESSING_POSTFINALCOMMIT = 11,
    VSS_SS_CREATED = 12,
    VSS_SS_ABORTED = 13,
    VSS_SS_DELETED = 14,
    VSS_SS_POSTCOMMITTED = 15,
    VSS_SS_COUNT = 16,
}

enum VSS_VOLUME_SNAPSHOT_ATTRIBUTES
{
    VSS_VOLSNAP_ATTR_PERSISTENT = 1,
    VSS_VOLSNAP_ATTR_NO_AUTORECOVERY = 2,
    VSS_VOLSNAP_ATTR_CLIENT_ACCESSIBLE = 4,
    VSS_VOLSNAP_ATTR_NO_AUTO_RELEASE = 8,
    VSS_VOLSNAP_ATTR_NO_WRITERS = 16,
    VSS_VOLSNAP_ATTR_TRANSPORTABLE = 32,
    VSS_VOLSNAP_ATTR_NOT_SURFACED = 64,
    VSS_VOLSNAP_ATTR_NOT_TRANSACTED = 128,
    VSS_VOLSNAP_ATTR_HARDWARE_ASSISTED = 65536,
    VSS_VOLSNAP_ATTR_DIFFERENTIAL = 131072,
    VSS_VOLSNAP_ATTR_PLEX = 262144,
    VSS_VOLSNAP_ATTR_IMPORTED = 524288,
    VSS_VOLSNAP_ATTR_EXPOSED_LOCALLY = 1048576,
    VSS_VOLSNAP_ATTR_EXPOSED_REMOTELY = 2097152,
    VSS_VOLSNAP_ATTR_AUTORECOVER = 4194304,
    VSS_VOLSNAP_ATTR_ROLLBACK_RECOVERY = 8388608,
    VSS_VOLSNAP_ATTR_DELAYED_POSTSNAPSHOT = 16777216,
    VSS_VOLSNAP_ATTR_TXF_RECOVERY = 33554432,
    VSS_VOLSNAP_ATTR_FILE_SHARE = 67108864,
}

enum VSS_SNAPSHOT_CONTEXT
{
    VSS_CTX_BACKUP = 0,
    VSS_CTX_FILE_SHARE_BACKUP = 16,
    VSS_CTX_NAS_ROLLBACK = 25,
    VSS_CTX_APP_ROLLBACK = 9,
    VSS_CTX_CLIENT_ACCESSIBLE = 29,
    VSS_CTX_CLIENT_ACCESSIBLE_WRITERS = 13,
    VSS_CTX_ALL = -1,
}

enum VSS_PROVIDER_CAPABILITIES
{
    VSS_PRV_CAPABILITY_LEGACY = 1,
    VSS_PRV_CAPABILITY_COMPLIANT = 2,
    VSS_PRV_CAPABILITY_LUN_REPOINT = 4,
    VSS_PRV_CAPABILITY_LUN_RESYNC = 8,
    VSS_PRV_CAPABILITY_OFFLINE_CREATION = 16,
    VSS_PRV_CAPABILITY_MULTIPLE_IMPORT = 32,
    VSS_PRV_CAPABILITY_RECYCLING = 64,
    VSS_PRV_CAPABILITY_PLEX = 128,
    VSS_PRV_CAPABILITY_DIFFERENTIAL = 256,
    VSS_PRV_CAPABILITY_CLUSTERED = 512,
}

enum VSS_HARDWARE_OPTIONS
{
    VSS_BREAKEX_FLAG_MASK_LUNS = 1,
    VSS_BREAKEX_FLAG_MAKE_READ_WRITE = 2,
    VSS_BREAKEX_FLAG_REVERT_IDENTITY_ALL = 4,
    VSS_BREAKEX_FLAG_REVERT_IDENTITY_NONE = 8,
    VSS_ONLUNSTATECHANGE_NOTIFY_READ_WRITE = 256,
    VSS_ONLUNSTATECHANGE_NOTIFY_LUN_PRE_RECOVERY = 512,
    VSS_ONLUNSTATECHANGE_NOTIFY_LUN_POST_RECOVERY = 1024,
    VSS_ONLUNSTATECHANGE_DO_MASK_LUNS = 2048,
}

enum VSS_RECOVERY_OPTIONS
{
    VSS_RECOVERY_REVERT_IDENTITY_ALL = 256,
    VSS_RECOVERY_NO_VOLUME_CHECK = 512,
}

enum VSS_WRITER_STATE
{
    VSS_WS_UNKNOWN = 0,
    VSS_WS_STABLE = 1,
    VSS_WS_WAITING_FOR_FREEZE = 2,
    VSS_WS_WAITING_FOR_THAW = 3,
    VSS_WS_WAITING_FOR_POST_SNAPSHOT = 4,
    VSS_WS_WAITING_FOR_BACKUP_COMPLETE = 5,
    VSS_WS_FAILED_AT_IDENTIFY = 6,
    VSS_WS_FAILED_AT_PREPARE_BACKUP = 7,
    VSS_WS_FAILED_AT_PREPARE_SNAPSHOT = 8,
    VSS_WS_FAILED_AT_FREEZE = 9,
    VSS_WS_FAILED_AT_THAW = 10,
    VSS_WS_FAILED_AT_POST_SNAPSHOT = 11,
    VSS_WS_FAILED_AT_BACKUP_COMPLETE = 12,
    VSS_WS_FAILED_AT_PRE_RESTORE = 13,
    VSS_WS_FAILED_AT_POST_RESTORE = 14,
    VSS_WS_FAILED_AT_BACKUPSHUTDOWN = 15,
    VSS_WS_COUNT = 16,
}

enum VSS_BACKUP_TYPE
{
    VSS_BT_UNDEFINED = 0,
    VSS_BT_FULL = 1,
    VSS_BT_INCREMENTAL = 2,
    VSS_BT_DIFFERENTIAL = 3,
    VSS_BT_LOG = 4,
    VSS_BT_COPY = 5,
    VSS_BT_OTHER = 6,
}

enum VSS_RESTORE_TYPE
{
    VSS_RTYPE_UNDEFINED = 0,
    VSS_RTYPE_BY_COPY = 1,
    VSS_RTYPE_IMPORT = 2,
    VSS_RTYPE_OTHER = 3,
}

enum VSS_ROLLFORWARD_TYPE
{
    VSS_RF_UNDEFINED = 0,
    VSS_RF_NONE = 1,
    VSS_RF_ALL = 2,
    VSS_RF_PARTIAL = 3,
}

enum VSS_PROVIDER_TYPE
{
    VSS_PROV_UNKNOWN = 0,
    VSS_PROV_SYSTEM = 1,
    VSS_PROV_SOFTWARE = 2,
    VSS_PROV_HARDWARE = 3,
    VSS_PROV_FILESHARE = 4,
}

enum VSS_APPLICATION_LEVEL
{
    VSS_APP_UNKNOWN = 0,
    VSS_APP_SYSTEM = 1,
    VSS_APP_BACK_END = 2,
    VSS_APP_FRONT_END = 3,
    VSS_APP_SYSTEM_RM = 4,
    VSS_APP_AUTO = -1,
}

enum VSS_SNAPSHOT_COMPATIBILITY
{
    VSS_SC_DISABLE_DEFRAG = 1,
    VSS_SC_DISABLE_CONTENTINDEX = 2,
}

enum VSS_SNAPSHOT_PROPERTY_ID
{
    VSS_SPROPID_UNKNOWN = 0,
    VSS_SPROPID_SNAPSHOT_ID = 1,
    VSS_SPROPID_SNAPSHOT_SET_ID = 2,
    VSS_SPROPID_SNAPSHOTS_COUNT = 3,
    VSS_SPROPID_SNAPSHOT_DEVICE = 4,
    VSS_SPROPID_ORIGINAL_VOLUME = 5,
    VSS_SPROPID_ORIGINATING_MACHINE = 6,
    VSS_SPROPID_SERVICE_MACHINE = 7,
    VSS_SPROPID_EXPOSED_NAME = 8,
    VSS_SPROPID_EXPOSED_PATH = 9,
    VSS_SPROPID_PROVIDER_ID = 10,
    VSS_SPROPID_SNAPSHOT_ATTRIBUTES = 11,
    VSS_SPROPID_CREATION_TIMESTAMP = 12,
    VSS_SPROPID_STATUS = 13,
}

enum VSS_FILE_SPEC_BACKUP_TYPE
{
    VSS_FSBT_FULL_BACKUP_REQUIRED = 1,
    VSS_FSBT_DIFFERENTIAL_BACKUP_REQUIRED = 2,
    VSS_FSBT_INCREMENTAL_BACKUP_REQUIRED = 4,
    VSS_FSBT_LOG_BACKUP_REQUIRED = 8,
    VSS_FSBT_FULL_SNAPSHOT_REQUIRED = 256,
    VSS_FSBT_DIFFERENTIAL_SNAPSHOT_REQUIRED = 512,
    VSS_FSBT_INCREMENTAL_SNAPSHOT_REQUIRED = 1024,
    VSS_FSBT_LOG_SNAPSHOT_REQUIRED = 2048,
    VSS_FSBT_CREATED_DURING_BACKUP = 65536,
    VSS_FSBT_ALL_BACKUP_REQUIRED = 15,
    VSS_FSBT_ALL_SNAPSHOT_REQUIRED = 3840,
}

enum VSS_BACKUP_SCHEMA
{
    VSS_BS_UNDEFINED = 0,
    VSS_BS_DIFFERENTIAL = 1,
    VSS_BS_INCREMENTAL = 2,
    VSS_BS_EXCLUSIVE_INCREMENTAL_DIFFERENTIAL = 4,
    VSS_BS_LOG = 8,
    VSS_BS_COPY = 16,
    VSS_BS_TIMESTAMPED = 32,
    VSS_BS_LAST_MODIFY = 64,
    VSS_BS_LSN = 128,
    VSS_BS_WRITER_SUPPORTS_NEW_TARGET = 256,
    VSS_BS_WRITER_SUPPORTS_RESTORE_WITH_MOVE = 512,
    VSS_BS_INDEPENDENT_SYSTEM_STATE = 1024,
    VSS_BS_ROLLFORWARD_RESTORE = 4096,
    VSS_BS_RESTORE_RENAME = 8192,
    VSS_BS_AUTHORITATIVE_RESTORE = 16384,
    VSS_BS_WRITER_SUPPORTS_PARALLEL_RESTORES = 32768,
}

struct VSS_SNAPSHOT_PROP
{
    Guid m_SnapshotId;
    Guid m_SnapshotSetId;
    int m_lSnapshotsCount;
    ushort* m_pwszSnapshotDeviceObject;
    ushort* m_pwszOriginalVolumeName;
    ushort* m_pwszOriginatingMachine;
    ushort* m_pwszServiceMachine;
    ushort* m_pwszExposedName;
    ushort* m_pwszExposedPath;
    Guid m_ProviderId;
    int m_lSnapshotAttributes;
    long m_tsCreationTimestamp;
    VSS_SNAPSHOT_STATE m_eStatus;
}

struct VSS_PROVIDER_PROP
{
    Guid m_ProviderId;
    ushort* m_pwszProviderName;
    VSS_PROVIDER_TYPE m_eProviderType;
    ushort* m_pwszProviderVersion;
    Guid m_ProviderVersionId;
    Guid m_ClassId;
}

struct __MIDL___MIDL_itf_vss_0000_0000_0001
{
    VSS_SNAPSHOT_PROP Snap;
    VSS_PROVIDER_PROP Prov;
}

struct VSS_OBJECT_PROP
{
    VSS_OBJECT_TYPE Type;
    __MIDL___MIDL_itf_vss_0000_0000_0001 Obj;
}

const GUID IID_IVssEnumObject = {0xAE1C7110, 0x2F60, 0x11D3, [0x8A, 0x39, 0x00, 0xC0, 0x4F, 0x72, 0xD8, 0xE3]};
@GUID(0xAE1C7110, 0x2F60, 0x11D3, [0x8A, 0x39, 0x00, 0xC0, 0x4F, 0x72, 0xD8, 0xE3]);
interface IVssEnumObject : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IVssEnumObject* ppenum);
}

const GUID IID_IVssAsync = {0x507C37B4, 0xCF5B, 0x4E95, [0xB0, 0xAF, 0x14, 0xEB, 0x97, 0x67, 0x46, 0x7E]};
@GUID(0x507C37B4, 0xCF5B, 0x4E95, [0xB0, 0xAF, 0x14, 0xEB, 0x97, 0x67, 0x46, 0x7E]);
interface IVssAsync : IUnknown
{
    HRESULT Cancel();
    HRESULT Wait(uint dwMilliseconds);
    HRESULT QueryStatus(int* pHrResult, int* pReserved);
}

enum VSS_USAGE_TYPE
{
    VSS_UT_UNDEFINED = 0,
    VSS_UT_BOOTABLESYSTEMSTATE = 1,
    VSS_UT_SYSTEMSERVICE = 2,
    VSS_UT_USERDATA = 3,
    VSS_UT_OTHER = 4,
}

enum VSS_SOURCE_TYPE
{
    VSS_ST_UNDEFINED = 0,
    VSS_ST_TRANSACTEDDB = 1,
    VSS_ST_NONTRANSACTEDDB = 2,
    VSS_ST_OTHER = 3,
}

enum VSS_RESTOREMETHOD_ENUM
{
    VSS_RME_UNDEFINED = 0,
    VSS_RME_RESTORE_IF_NOT_THERE = 1,
    VSS_RME_RESTORE_IF_CAN_REPLACE = 2,
    VSS_RME_STOP_RESTORE_START = 3,
    VSS_RME_RESTORE_TO_ALTERNATE_LOCATION = 4,
    VSS_RME_RESTORE_AT_REBOOT = 5,
    VSS_RME_RESTORE_AT_REBOOT_IF_CANNOT_REPLACE = 6,
    VSS_RME_CUSTOM = 7,
    VSS_RME_RESTORE_STOP_START = 8,
}

enum VSS_WRITERRESTORE_ENUM
{
    VSS_WRE_UNDEFINED = 0,
    VSS_WRE_NEVER = 1,
    VSS_WRE_IF_REPLACE_FAILS = 2,
    VSS_WRE_ALWAYS = 3,
}

enum VSS_COMPONENT_TYPE
{
    VSS_CT_UNDEFINED = 0,
    VSS_CT_DATABASE = 1,
    VSS_CT_FILEGROUP = 2,
}

enum VSS_ALTERNATE_WRITER_STATE
{
    VSS_AWS_UNDEFINED = 0,
    VSS_AWS_NO_ALTERNATE_WRITER = 1,
    VSS_AWS_ALTERNATE_WRITER_EXISTS = 2,
    VSS_AWS_THIS_IS_ALTERNATE_WRITER = 3,
}

enum VSS_SUBSCRIBE_MASK
{
    VSS_SM_POST_SNAPSHOT_FLAG = 1,
    VSS_SM_BACKUP_EVENTS_FLAG = 2,
    VSS_SM_RESTORE_EVENTS_FLAG = 4,
    VSS_SM_IO_THROTTLING_FLAG = 8,
    VSS_SM_ALL_FLAGS = -1,
}

enum VSS_RESTORE_TARGET
{
    VSS_RT_UNDEFINED = 0,
    VSS_RT_ORIGINAL = 1,
    VSS_RT_ALTERNATE = 2,
    VSS_RT_DIRECTED = 3,
    VSS_RT_ORIGINAL_LOCATION = 4,
}

enum VSS_FILE_RESTORE_STATUS
{
    VSS_RS_UNDEFINED = 0,
    VSS_RS_NONE = 1,
    VSS_RS_ALL = 2,
    VSS_RS_FAILED = 3,
}

enum VSS_COMPONENT_FLAGS
{
    VSS_CF_BACKUP_RECOVERY = 1,
    VSS_CF_APP_ROLLBACK_RECOVERY = 2,
    VSS_CF_NOT_SYSTEM_STATE = 4,
}

struct IVssExamineWriterMetadata
{
}

interface IVssWMFiledesc : IUnknown
{
    HRESULT GetPath(BSTR* pbstrPath);
    HRESULT GetFilespec(BSTR* pbstrFilespec);
    HRESULT GetRecursive(bool* pbRecursive);
    HRESULT GetAlternateLocation(BSTR* pbstrAlternateLocation);
    HRESULT GetBackupTypeMask(uint* pdwTypeMask);
}

interface IVssWMDependency : IUnknown
{
    HRESULT GetWriterId(Guid* pWriterId);
    HRESULT GetLogicalPath(BSTR* pbstrLogicalPath);
    HRESULT GetComponentName(BSTR* pbstrComponentName);
}

const GUID IID_IVssComponent = {0xD2C72C96, 0xC121, 0x4518, [0xB6, 0x27, 0xE5, 0xA9, 0x3D, 0x01, 0x0E, 0xAD]};
@GUID(0xD2C72C96, 0xC121, 0x4518, [0xB6, 0x27, 0xE5, 0xA9, 0x3D, 0x01, 0x0E, 0xAD]);
interface IVssComponent : IUnknown
{
    HRESULT GetLogicalPath(BSTR* pbstrPath);
    HRESULT GetComponentType(VSS_COMPONENT_TYPE* pct);
    HRESULT GetComponentName(BSTR* pbstrName);
    HRESULT GetBackupSucceeded(bool* pbSucceeded);
    HRESULT GetAlternateLocationMappingCount(uint* pcMappings);
    HRESULT GetAlternateLocationMapping(uint iMapping, IVssWMFiledesc* ppFiledesc);
    HRESULT SetBackupMetadata(const(wchar)* wszData);
    HRESULT GetBackupMetadata(BSTR* pbstrData);
    HRESULT AddPartialFile(const(wchar)* wszPath, const(wchar)* wszFilename, const(wchar)* wszRanges, const(wchar)* wszMetadata);
    HRESULT GetPartialFileCount(uint* pcPartialFiles);
    HRESULT GetPartialFile(uint iPartialFile, BSTR* pbstrPath, BSTR* pbstrFilename, BSTR* pbstrRange, BSTR* pbstrMetadata);
    HRESULT IsSelectedForRestore(bool* pbSelectedForRestore);
    HRESULT GetAdditionalRestores(bool* pbAdditionalRestores);
    HRESULT GetNewTargetCount(uint* pcNewTarget);
    HRESULT GetNewTarget(uint iNewTarget, IVssWMFiledesc* ppFiledesc);
    HRESULT AddDirectedTarget(const(wchar)* wszSourcePath, const(wchar)* wszSourceFilename, const(wchar)* wszSourceRangeList, const(wchar)* wszDestinationPath, const(wchar)* wszDestinationFilename, const(wchar)* wszDestinationRangeList);
    HRESULT GetDirectedTargetCount(uint* pcDirectedTarget);
    HRESULT GetDirectedTarget(uint iDirectedTarget, BSTR* pbstrSourcePath, BSTR* pbstrSourceFileName, BSTR* pbstrSourceRangeList, BSTR* pbstrDestinationPath, BSTR* pbstrDestinationFilename, BSTR* pbstrDestinationRangeList);
    HRESULT SetRestoreMetadata(const(wchar)* wszRestoreMetadata);
    HRESULT GetRestoreMetadata(BSTR* pbstrRestoreMetadata);
    HRESULT SetRestoreTarget(VSS_RESTORE_TARGET target);
    HRESULT GetRestoreTarget(VSS_RESTORE_TARGET* pTarget);
    HRESULT SetPreRestoreFailureMsg(const(wchar)* wszPreRestoreFailureMsg);
    HRESULT GetPreRestoreFailureMsg(BSTR* pbstrPreRestoreFailureMsg);
    HRESULT SetPostRestoreFailureMsg(const(wchar)* wszPostRestoreFailureMsg);
    HRESULT GetPostRestoreFailureMsg(BSTR* pbstrPostRestoreFailureMsg);
    HRESULT SetBackupStamp(const(wchar)* wszBackupStamp);
    HRESULT GetBackupStamp(BSTR* pbstrBackupStamp);
    HRESULT GetPreviousBackupStamp(BSTR* pbstrBackupStamp);
    HRESULT GetBackupOptions(BSTR* pbstrBackupOptions);
    HRESULT GetRestoreOptions(BSTR* pbstrRestoreOptions);
    HRESULT GetRestoreSubcomponentCount(uint* pcRestoreSubcomponent);
    HRESULT GetRestoreSubcomponent(uint iComponent, BSTR* pbstrLogicalPath, BSTR* pbstrComponentName, bool* pbRepair);
    HRESULT GetFileRestoreStatus(VSS_FILE_RESTORE_STATUS* pStatus);
    HRESULT AddDifferencedFilesByLastModifyTime(const(wchar)* wszPath, const(wchar)* wszFilespec, BOOL bRecursive, FILETIME ftLastModifyTime);
    HRESULT AddDifferencedFilesByLastModifyLSN(const(wchar)* wszPath, const(wchar)* wszFilespec, BOOL bRecursive, BSTR bstrLsnString);
    HRESULT GetDifferencedFilesCount(uint* pcDifferencedFiles);
    HRESULT GetDifferencedFile(uint iDifferencedFile, BSTR* pbstrPath, BSTR* pbstrFilespec, int* pbRecursive, BSTR* pbstrLsnString, FILETIME* pftLastModifyTime);
}

interface IVssWriterComponents
{
    HRESULT GetComponentCount(uint* pcComponents);
    HRESULT GetWriterInfo(Guid* pidInstance, Guid* pidWriter);
    HRESULT GetComponent(uint iComponent, IVssComponent* ppComponent);
}

const GUID IID_IVssComponentEx = {0x156C8B5E, 0xF131, 0x4BD7, [0x9C, 0x97, 0xD1, 0x92, 0x3B, 0xE7, 0xE1, 0xFA]};
@GUID(0x156C8B5E, 0xF131, 0x4BD7, [0x9C, 0x97, 0xD1, 0x92, 0x3B, 0xE7, 0xE1, 0xFA]);
interface IVssComponentEx : IVssComponent
{
    HRESULT SetPrepareForBackupFailureMsg(const(wchar)* wszFailureMsg);
    HRESULT SetPostSnapshotFailureMsg(const(wchar)* wszFailureMsg);
    HRESULT GetPrepareForBackupFailureMsg(BSTR* pbstrFailureMsg);
    HRESULT GetPostSnapshotFailureMsg(BSTR* pbstrFailureMsg);
    HRESULT GetAuthoritativeRestore(bool* pbAuth);
    HRESULT GetRollForward(VSS_ROLLFORWARD_TYPE* pRollType, BSTR* pbstrPoint);
    HRESULT GetRestoreName(BSTR* pbstrName);
}

const GUID IID_IVssComponentEx2 = {0x3B5BE0F2, 0x07A9, 0x4E4B, [0xBD, 0xD3, 0xCF, 0xDC, 0x8E, 0x2C, 0x0D, 0x2D]};
@GUID(0x3B5BE0F2, 0x07A9, 0x4E4B, [0xBD, 0xD3, 0xCF, 0xDC, 0x8E, 0x2C, 0x0D, 0x2D]);
interface IVssComponentEx2 : IVssComponentEx
{
    HRESULT SetFailure(HRESULT hr, HRESULT hrApplication, const(wchar)* wszApplicationMessage, uint dwReserved);
    HRESULT GetFailure(int* phr, int* phrApplication, BSTR* pbstrApplicationMessage, uint* pdwReserved);
}

interface IVssCreateWriterMetadata
{
    HRESULT AddIncludeFiles(const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive, const(wchar)* wszAlternateLocation);
    HRESULT AddExcludeFiles(const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive);
    HRESULT AddComponent(VSS_COMPONENT_TYPE ct, const(wchar)* wszLogicalPath, const(wchar)* wszComponentName, const(wchar)* wszCaption, const(ubyte)* pbIcon, uint cbIcon, ubyte bRestoreMetadata, ubyte bNotifyOnBackupComplete, ubyte bSelectable, ubyte bSelectableForRestore, uint dwComponentFlags);
    HRESULT AddDatabaseFiles(const(wchar)* wszLogicalPath, const(wchar)* wszDatabaseName, const(wchar)* wszPath, const(wchar)* wszFilespec, uint dwBackupTypeMask);
    HRESULT AddDatabaseLogFiles(const(wchar)* wszLogicalPath, const(wchar)* wszDatabaseName, const(wchar)* wszPath, const(wchar)* wszFilespec, uint dwBackupTypeMask);
    HRESULT AddFilesToFileGroup(const(wchar)* wszLogicalPath, const(wchar)* wszGroupName, const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive, const(wchar)* wszAlternateLocation, uint dwBackupTypeMask);
    HRESULT SetRestoreMethod(VSS_RESTOREMETHOD_ENUM method, const(wchar)* wszService, const(wchar)* wszUserProcedure, VSS_WRITERRESTORE_ENUM writerRestore, ubyte bRebootRequired);
    HRESULT AddAlternateLocationMapping(const(wchar)* wszSourcePath, const(wchar)* wszSourceFilespec, ubyte bRecursive, const(wchar)* wszDestination);
    HRESULT AddComponentDependency(const(wchar)* wszForLogicalPath, const(wchar)* wszForComponentName, Guid onWriterId, const(wchar)* wszOnLogicalPath, const(wchar)* wszOnComponentName);
    HRESULT SetBackupSchema(uint dwSchemaMask);
    HRESULT GetDocument(IXMLDOMDocument* pDoc);
    HRESULT SaveAsXML(BSTR* pbstrXML);
}

const GUID IID_IVssCreateWriterMetadataEx = {0x9F21981D, 0xD469, 0x4349, [0xB8, 0x07, 0x39, 0xE6, 0x4E, 0x46, 0x74, 0xE1]};
@GUID(0x9F21981D, 0xD469, 0x4349, [0xB8, 0x07, 0x39, 0xE6, 0x4E, 0x46, 0x74, 0xE1]);
interface IVssCreateWriterMetadataEx : IUnknown
{
    HRESULT AddDatabaseFiles(const(wchar)* wszLogicalPath, const(wchar)* wszDatabaseName, const(wchar)* wszPath, const(wchar)* wszFilespec, uint dwBackupTypeMask);
    HRESULT AddDatabaseLogFiles(const(wchar)* wszLogicalPath, const(wchar)* wszDatabaseName, const(wchar)* wszPath, const(wchar)* wszFilespec, uint dwBackupTypeMask);
    HRESULT AddFilesToFileGroup(const(wchar)* wszLogicalPath, const(wchar)* wszGroupName, const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive, const(wchar)* wszAlternateLocation, uint dwBackupTypeMask);
    HRESULT SetRestoreMethod(VSS_RESTOREMETHOD_ENUM method, const(wchar)* wszService, const(wchar)* wszUserProcedure, VSS_WRITERRESTORE_ENUM writerRestore, ubyte bRebootRequired);
    HRESULT AddAlternateLocationMapping(const(wchar)* wszSourcePath, const(wchar)* wszSourceFilespec, ubyte bRecursive, const(wchar)* wszDestination);
    HRESULT AddComponentDependency(const(wchar)* wszForLogicalPath, const(wchar)* wszForComponentName, Guid onWriterId, const(wchar)* wszOnLogicalPath, const(wchar)* wszOnComponentName);
    HRESULT SetBackupSchema(uint dwSchemaMask);
    HRESULT GetDocument(IXMLDOMDocument* pDoc);
    HRESULT SaveAsXML(BSTR* pbstrXML);
    HRESULT QueryInterface(const(Guid)* riid, void** ppvObject);
    uint AddRef();
    uint Release();
    HRESULT AddExcludeFilesFromSnapshot(const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive);
}

interface IVssWriterImpl : IUnknown
{
    HRESULT Initialize(Guid writerId, const(wchar)* wszWriterName, const(wchar)* wszWriterInstanceName, uint dwMajorVersion, uint dwMinorVersion, VSS_USAGE_TYPE ut, VSS_SOURCE_TYPE st, VSS_APPLICATION_LEVEL nLevel, uint dwTimeout, VSS_ALTERNATE_WRITER_STATE aws, ubyte bIOThrottlingOnly);
    HRESULT Subscribe(uint dwSubscribeTimeout, uint dwEventFlags);
    HRESULT Unsubscribe();
    void Uninitialize();
    ushort** GetCurrentVolumeArray();
    uint GetCurrentVolumeCount();
    HRESULT GetSnapshotDeviceName(const(wchar)* wszOriginalVolume, ushort** ppwszSnapshotDevice);
    Guid GetCurrentSnapshotSetId();
    int GetContext();
    VSS_APPLICATION_LEVEL GetCurrentLevel();
    bool IsPathAffected(const(wchar)* wszPath);
    bool IsBootableSystemStateBackedUp();
    bool AreComponentsSelected();
    VSS_BACKUP_TYPE GetBackupType();
    VSS_RESTORE_TYPE GetRestoreType();
    HRESULT SetWriterFailure(HRESULT hr);
    bool IsPartialFileSupportEnabled();
    HRESULT InstallAlternateWriter(Guid idWriter, Guid clsid);
    IVssExamineWriterMetadata* GetIdentityInformation();
    HRESULT SetWriterFailureEx(HRESULT hr, HRESULT hrApplication, const(wchar)* wszApplicationMessage);
    HRESULT GetSessionId(Guid* idSession);
    bool IsWriterShuttingDown();
}

const GUID IID_IVssCreateExpressWriterMetadata = {0x9C772E77, 0xB26E, 0x427F, [0x92, 0xDD, 0xC9, 0x96, 0xF4, 0x1E, 0xA5, 0xE3]};
@GUID(0x9C772E77, 0xB26E, 0x427F, [0x92, 0xDD, 0xC9, 0x96, 0xF4, 0x1E, 0xA5, 0xE3]);
interface IVssCreateExpressWriterMetadata : IUnknown
{
    HRESULT AddExcludeFiles(const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive);
    HRESULT AddComponent(VSS_COMPONENT_TYPE ct, const(wchar)* wszLogicalPath, const(wchar)* wszComponentName, const(wchar)* wszCaption, const(ubyte)* pbIcon, uint cbIcon, ubyte bRestoreMetadata, ubyte bNotifyOnBackupComplete, ubyte bSelectable, ubyte bSelectableForRestore, uint dwComponentFlags);
    HRESULT AddFilesToFileGroup(const(wchar)* wszLogicalPath, const(wchar)* wszGroupName, const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive, const(wchar)* wszAlternateLocation, uint dwBackupTypeMask);
    HRESULT SetRestoreMethod(VSS_RESTOREMETHOD_ENUM method, const(wchar)* wszService, const(wchar)* wszUserProcedure, VSS_WRITERRESTORE_ENUM writerRestore, ubyte bRebootRequired);
    HRESULT AddComponentDependency(const(wchar)* wszForLogicalPath, const(wchar)* wszForComponentName, Guid onWriterId, const(wchar)* wszOnLogicalPath, const(wchar)* wszOnComponentName);
    HRESULT SetBackupSchema(uint dwSchemaMask);
    HRESULT SaveAsXML(BSTR* pbstrXML);
}

const GUID IID_IVssExpressWriter = {0xE33AFFDC, 0x59C7, 0x47B1, [0x97, 0xD5, 0x42, 0x66, 0x59, 0x8F, 0x62, 0x35]};
@GUID(0xE33AFFDC, 0x59C7, 0x47B1, [0x97, 0xD5, 0x42, 0x66, 0x59, 0x8F, 0x62, 0x35]);
interface IVssExpressWriter : IUnknown
{
    HRESULT CreateMetadata(Guid writerId, const(wchar)* writerName, VSS_USAGE_TYPE usageType, uint versionMajor, uint versionMinor, uint reserved, IVssCreateExpressWriterMetadata* ppMetadata);
    HRESULT LoadMetadata(const(wchar)* metadata, uint reserved);
    HRESULT Register();
    HRESULT Unregister(Guid writerId);
}

const GUID CLSID_VssSnapshotMgmt = {0x0B5A2C52, 0x3EB9, 0x470A, [0x96, 0xE2, 0x6C, 0x6D, 0x45, 0x70, 0xE4, 0x0F]};
@GUID(0x0B5A2C52, 0x3EB9, 0x470A, [0x96, 0xE2, 0x6C, 0x6D, 0x45, 0x70, 0xE4, 0x0F]);
struct VssSnapshotMgmt;

enum VSS_MGMT_OBJECT_TYPE
{
    VSS_MGMT_OBJECT_UNKNOWN = 0,
    VSS_MGMT_OBJECT_VOLUME = 1,
    VSS_MGMT_OBJECT_DIFF_VOLUME = 2,
    VSS_MGMT_OBJECT_DIFF_AREA = 3,
}

struct VSS_VOLUME_PROP
{
    ushort* m_pwszVolumeName;
    ushort* m_pwszVolumeDisplayName;
}

struct VSS_DIFF_VOLUME_PROP
{
    ushort* m_pwszVolumeName;
    ushort* m_pwszVolumeDisplayName;
    long m_llVolumeFreeSpace;
    long m_llVolumeTotalSpace;
}

struct VSS_DIFF_AREA_PROP
{
    ushort* m_pwszVolumeName;
    ushort* m_pwszDiffAreaVolumeName;
    long m_llMaximumDiffSpace;
    long m_llAllocatedDiffSpace;
    long m_llUsedDiffSpace;
}

struct __MIDL___MIDL_itf_vsmgmt_0000_0000_0001
{
    VSS_VOLUME_PROP Vol;
    VSS_DIFF_VOLUME_PROP DiffVol;
    VSS_DIFF_AREA_PROP DiffArea;
}

struct VSS_MGMT_OBJECT_PROP
{
    VSS_MGMT_OBJECT_TYPE Type;
    __MIDL___MIDL_itf_vsmgmt_0000_0000_0001 Obj;
}

enum VSS_PROTECTION_LEVEL
{
    VSS_PROTECTION_LEVEL_ORIGINAL_VOLUME = 0,
    VSS_PROTECTION_LEVEL_SNAPSHOT = 1,
}

enum VSS_PROTECTION_FAULT
{
    VSS_PROTECTION_FAULT_NONE = 0,
    VSS_PROTECTION_FAULT_DIFF_AREA_MISSING = 1,
    VSS_PROTECTION_FAULT_IO_FAILURE_DURING_ONLINE = 2,
    VSS_PROTECTION_FAULT_META_DATA_CORRUPTION = 3,
    VSS_PROTECTION_FAULT_MEMORY_ALLOCATION_FAILURE = 4,
    VSS_PROTECTION_FAULT_MAPPED_MEMORY_FAILURE = 5,
    VSS_PROTECTION_FAULT_COW_READ_FAILURE = 6,
    VSS_PROTECTION_FAULT_COW_WRITE_FAILURE = 7,
    VSS_PROTECTION_FAULT_DIFF_AREA_FULL = 8,
    VSS_PROTECTION_FAULT_GROW_TOO_SLOW = 9,
    VSS_PROTECTION_FAULT_GROW_FAILED = 10,
    VSS_PROTECTION_FAULT_DESTROY_ALL_SNAPSHOTS = 11,
    VSS_PROTECTION_FAULT_FILE_SYSTEM_FAILURE = 12,
    VSS_PROTECTION_FAULT_IO_FAILURE = 13,
    VSS_PROTECTION_FAULT_DIFF_AREA_REMOVED = 14,
    VSS_PROTECTION_FAULT_EXTERNAL_WRITER_TO_DIFF_AREA = 15,
    VSS_PROTECTION_FAULT_MOUNT_DURING_CLUSTER_OFFLINE = 16,
}

struct VSS_VOLUME_PROTECTION_INFO
{
    VSS_PROTECTION_LEVEL m_protectionLevel;
    BOOL m_volumeIsOfflineForProtection;
    VSS_PROTECTION_FAULT m_protectionFault;
    int m_failureStatus;
    BOOL m_volumeHasUnusedDiffArea;
    uint m_reserved;
}

const GUID IID_IVssSnapshotMgmt = {0xFA7DF749, 0x66E7, 0x4986, [0xA2, 0x7F, 0xE2, 0xF0, 0x4A, 0xE5, 0x37, 0x72]};
@GUID(0xFA7DF749, 0x66E7, 0x4986, [0xA2, 0x7F, 0xE2, 0xF0, 0x4A, 0xE5, 0x37, 0x72]);
interface IVssSnapshotMgmt : IUnknown
{
    HRESULT GetProviderMgmtInterface(Guid ProviderId, const(Guid)* InterfaceId, IUnknown* ppItf);
    HRESULT QueryVolumesSupportedForSnapshots(Guid ProviderId, int lContext, IVssEnumMgmtObject* ppEnum);
    HRESULT QuerySnapshotsByVolume(ushort* pwszVolumeName, Guid ProviderId, IVssEnumObject* ppEnum);
}

const GUID IID_IVssSnapshotMgmt2 = {0x0F61EC39, 0xFE82, 0x45F2, [0xA3, 0xF0, 0x76, 0x8B, 0x5D, 0x42, 0x71, 0x02]};
@GUID(0x0F61EC39, 0xFE82, 0x45F2, [0xA3, 0xF0, 0x76, 0x8B, 0x5D, 0x42, 0x71, 0x02]);
interface IVssSnapshotMgmt2 : IUnknown
{
    HRESULT GetMinDiffAreaSize(long* pllMinDiffAreaSize);
}

const GUID IID_IVssDifferentialSoftwareSnapshotMgmt = {0x214A0F28, 0xB737, 0x4026, [0xB8, 0x47, 0x4F, 0x9E, 0x37, 0xD7, 0x95, 0x29]};
@GUID(0x214A0F28, 0xB737, 0x4026, [0xB8, 0x47, 0x4F, 0x9E, 0x37, 0xD7, 0x95, 0x29]);
interface IVssDifferentialSoftwareSnapshotMgmt : IUnknown
{
    HRESULT AddDiffArea(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, long llMaximumDiffSpace);
    HRESULT ChangeDiffAreaMaximumSize(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, long llMaximumDiffSpace);
    HRESULT QueryVolumesSupportedForDiffAreas(ushort* pwszOriginalVolumeName, IVssEnumMgmtObject* ppEnum);
    HRESULT QueryDiffAreasForVolume(ushort* pwszVolumeName, IVssEnumMgmtObject* ppEnum);
    HRESULT QueryDiffAreasOnVolume(ushort* pwszVolumeName, IVssEnumMgmtObject* ppEnum);
    HRESULT QueryDiffAreasForSnapshot(Guid SnapshotId, IVssEnumMgmtObject* ppEnum);
}

const GUID IID_IVssDifferentialSoftwareSnapshotMgmt2 = {0x949D7353, 0x675F, 0x4275, [0x89, 0x69, 0xF0, 0x44, 0xC6, 0x27, 0x78, 0x15]};
@GUID(0x949D7353, 0x675F, 0x4275, [0x89, 0x69, 0xF0, 0x44, 0xC6, 0x27, 0x78, 0x15]);
interface IVssDifferentialSoftwareSnapshotMgmt2 : IVssDifferentialSoftwareSnapshotMgmt
{
    HRESULT ChangeDiffAreaMaximumSizeEx(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, long llMaximumDiffSpace, BOOL bVolatile);
    HRESULT MigrateDiffAreas(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, ushort* pwszNewDiffAreaVolumeName);
    HRESULT QueryMigrationStatus(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, IVssAsync* ppAsync);
    HRESULT SetSnapshotPriority(Guid idSnapshot, ubyte priority);
}

const GUID IID_IVssDifferentialSoftwareSnapshotMgmt3 = {0x383F7E71, 0xA4C5, 0x401F, [0xB2, 0x7F, 0xF8, 0x26, 0x28, 0x9F, 0x84, 0x58]};
@GUID(0x383F7E71, 0xA4C5, 0x401F, [0xB2, 0x7F, 0xF8, 0x26, 0x28, 0x9F, 0x84, 0x58]);
interface IVssDifferentialSoftwareSnapshotMgmt3 : IVssDifferentialSoftwareSnapshotMgmt2
{
    HRESULT SetVolumeProtectLevel(ushort* pwszVolumeName, VSS_PROTECTION_LEVEL protectionLevel);
    HRESULT GetVolumeProtectLevel(ushort* pwszVolumeName, VSS_VOLUME_PROTECTION_INFO* protectionLevel);
    HRESULT ClearVolumeProtectFault(ushort* pwszVolumeName);
    HRESULT DeleteUnusedDiffAreas(ushort* pwszDiffAreaVolumeName);
    HRESULT QuerySnapshotDeltaBitmap(Guid idSnapshotOlder, Guid idSnapshotYounger, uint* pcBlockSizePerBit, uint* pcBitmapLength, char* ppbBitmap);
}

const GUID IID_IVssEnumMgmtObject = {0x01954E6B, 0x9254, 0x4E6E, [0x80, 0x8C, 0xC9, 0xE0, 0x5D, 0x00, 0x76, 0x96]};
@GUID(0x01954E6B, 0x9254, 0x4E6E, [0x80, 0x8C, 0xC9, 0xE0, 0x5D, 0x00, 0x76, 0x96]);
interface IVssEnumMgmtObject : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IVssEnumMgmtObject* ppenum);
}

const GUID CLSID_VSSCoordinator = {0xE579AB5F, 0x1CC4, 0x44B4, [0xBE, 0xD9, 0xDE, 0x09, 0x91, 0xFF, 0x06, 0x23]};
@GUID(0xE579AB5F, 0x1CC4, 0x44B4, [0xBE, 0xD9, 0xDE, 0x09, 0x91, 0xFF, 0x06, 0x23]);
struct VSSCoordinator;

const GUID IID_IVssAdmin = {0x77ED5996, 0x2F63, 0x11D3, [0x8A, 0x39, 0x00, 0xC0, 0x4F, 0x72, 0xD8, 0xE3]};
@GUID(0x77ED5996, 0x2F63, 0x11D3, [0x8A, 0x39, 0x00, 0xC0, 0x4F, 0x72, 0xD8, 0xE3]);
interface IVssAdmin : IUnknown
{
    HRESULT RegisterProvider(Guid pProviderId, Guid ClassId, ushort* pwszProviderName, VSS_PROVIDER_TYPE eProviderType, ushort* pwszProviderVersion, Guid ProviderVersionId);
    HRESULT UnregisterProvider(Guid ProviderId);
    HRESULT QueryProviders(IVssEnumObject* ppEnum);
    HRESULT AbortAllSnapshotsInProgress();
}

const GUID IID_IVssAdminEx = {0x7858A9F8, 0xB1FA, 0x41A6, [0x96, 0x4F, 0xB9, 0xB3, 0x6B, 0x8C, 0xD8, 0xD8]};
@GUID(0x7858A9F8, 0xB1FA, 0x41A6, [0x96, 0x4F, 0xB9, 0xB3, 0x6B, 0x8C, 0xD8, 0xD8]);
interface IVssAdminEx : IVssAdmin
{
    HRESULT GetProviderCapability(Guid pProviderId, ulong* pllOriginalCapabilityMask);
    HRESULT GetProviderContext(Guid ProviderId, int* plContext);
    HRESULT SetProviderContext(Guid ProviderId, int lContext);
}

const GUID IID_IVssSoftwareSnapshotProvider = {0x609E123E, 0x2C5A, 0x44D3, [0x8F, 0x01, 0x0B, 0x1D, 0x9A, 0x47, 0xD1, 0xFF]};
@GUID(0x609E123E, 0x2C5A, 0x44D3, [0x8F, 0x01, 0x0B, 0x1D, 0x9A, 0x47, 0xD1, 0xFF]);
interface IVssSoftwareSnapshotProvider : IUnknown
{
    HRESULT SetContext(int lContext);
    HRESULT GetSnapshotProperties(Guid SnapshotId, VSS_SNAPSHOT_PROP* pProp);
    HRESULT Query(Guid QueriedObjectId, VSS_OBJECT_TYPE eQueriedObjectType, VSS_OBJECT_TYPE eReturnedObjectsType, IVssEnumObject* ppEnum);
    HRESULT DeleteSnapshots(Guid SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType, BOOL bForceDelete, int* plDeletedSnapshots, Guid* pNondeletedSnapshotID);
    HRESULT BeginPrepareSnapshot(Guid SnapshotSetId, Guid SnapshotId, ushort* pwszVolumeName, int lNewContext);
    HRESULT IsVolumeSupported(ushort* pwszVolumeName, int* pbSupportedByThisProvider);
    HRESULT IsVolumeSnapshotted(ushort* pwszVolumeName, int* pbSnapshotsPresent, int* plSnapshotCompatibility);
    HRESULT SetSnapshotProperty(Guid SnapshotId, VSS_SNAPSHOT_PROPERTY_ID eSnapshotPropertyId, VARIANT vProperty);
    HRESULT RevertToSnapshot(Guid SnapshotId);
    HRESULT QueryRevertStatus(ushort* pwszVolume, IVssAsync* ppAsync);
}

const GUID IID_IVssProviderCreateSnapshotSet = {0x5F894E5B, 0x1E39, 0x4778, [0x8E, 0x23, 0x9A, 0xBA, 0xD9, 0xF0, 0xE0, 0x8C]};
@GUID(0x5F894E5B, 0x1E39, 0x4778, [0x8E, 0x23, 0x9A, 0xBA, 0xD9, 0xF0, 0xE0, 0x8C]);
interface IVssProviderCreateSnapshotSet : IUnknown
{
    HRESULT EndPrepareSnapshots(Guid SnapshotSetId);
    HRESULT PreCommitSnapshots(Guid SnapshotSetId);
    HRESULT CommitSnapshots(Guid SnapshotSetId);
    HRESULT PostCommitSnapshots(Guid SnapshotSetId, int lSnapshotsCount);
    HRESULT PreFinalCommitSnapshots(Guid SnapshotSetId);
    HRESULT PostFinalCommitSnapshots(Guid SnapshotSetId);
    HRESULT AbortSnapshots(Guid SnapshotSetId);
}

const GUID IID_IVssProviderNotifications = {0xE561901F, 0x03A5, 0x4AFE, [0x86, 0xD0, 0x72, 0xBA, 0xEE, 0xCE, 0x70, 0x04]};
@GUID(0xE561901F, 0x03A5, 0x4AFE, [0x86, 0xD0, 0x72, 0xBA, 0xEE, 0xCE, 0x70, 0x04]);
interface IVssProviderNotifications : IUnknown
{
    HRESULT OnLoad(IUnknown pCallback);
    HRESULT OnUnload(BOOL bForceUnload);
}

const GUID IID_IVssHardwareSnapshotProvider = {0x9593A157, 0x44E9, 0x4344, [0xBB, 0xEB, 0x44, 0xFB, 0xF9, 0xB0, 0x6B, 0x10]};
@GUID(0x9593A157, 0x44E9, 0x4344, [0xBB, 0xEB, 0x44, 0xFB, 0xF9, 0xB0, 0x6B, 0x10]);
interface IVssHardwareSnapshotProvider : IUnknown
{
    HRESULT AreLunsSupported(int lLunCount, int lContext, char* rgwszDevices, char* pLunInformation, int* pbIsSupported);
    HRESULT FillInLunInfo(ushort* wszDeviceName, VDS_LUN_INFORMATION* pLunInfo, int* pbIsSupported);
    HRESULT BeginPrepareSnapshot(Guid SnapshotSetId, Guid SnapshotId, int lContext, int lLunCount, char* rgDeviceNames, char* rgLunInformation);
    HRESULT GetTargetLuns(int lLunCount, char* rgDeviceNames, char* rgSourceLuns, char* rgDestinationLuns);
    HRESULT LocateLuns(int lLunCount, char* rgSourceLuns);
    HRESULT OnLunEmpty(ushort* wszDeviceName, VDS_LUN_INFORMATION* pInformation);
}

const GUID IID_IVssHardwareSnapshotProviderEx = {0x7F5BA925, 0xCDB1, 0x4D11, [0xA7, 0x1F, 0x33, 0x9E, 0xB7, 0xE7, 0x09, 0xFD]};
@GUID(0x7F5BA925, 0xCDB1, 0x4D11, [0xA7, 0x1F, 0x33, 0x9E, 0xB7, 0xE7, 0x09, 0xFD]);
interface IVssHardwareSnapshotProviderEx : IVssHardwareSnapshotProvider
{
    HRESULT GetProviderCapabilities(ulong* pllOriginalCapabilityMask);
    HRESULT OnLunStateChange(char* pSnapshotLuns, char* pOriginalLuns, uint dwCount, uint dwFlags);
    HRESULT ResyncLuns(char* pSourceLuns, char* pTargetLuns, uint dwCount, IVssAsync* ppAsync);
    HRESULT OnReuseLuns(char* pSnapshotLuns, char* pOriginalLuns, uint dwCount);
}

const GUID IID_IVssFileShareSnapshotProvider = {0xC8636060, 0x7C2E, 0x11DF, [0x8C, 0x4A, 0x08, 0x00, 0x20, 0x0C, 0x9A, 0x66]};
@GUID(0xC8636060, 0x7C2E, 0x11DF, [0x8C, 0x4A, 0x08, 0x00, 0x20, 0x0C, 0x9A, 0x66]);
interface IVssFileShareSnapshotProvider : IUnknown
{
    HRESULT SetContext(int lContext);
    HRESULT GetSnapshotProperties(Guid SnapshotId, VSS_SNAPSHOT_PROP* pProp);
    HRESULT Query(Guid QueriedObjectId, VSS_OBJECT_TYPE eQueriedObjectType, VSS_OBJECT_TYPE eReturnedObjectsType, IVssEnumObject* ppEnum);
    HRESULT DeleteSnapshots(Guid SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType, BOOL bForceDelete, int* plDeletedSnapshots, Guid* pNondeletedSnapshotID);
    HRESULT BeginPrepareSnapshot(Guid SnapshotSetId, Guid SnapshotId, ushort* pwszSharePath, int lNewContext, Guid ProviderId);
    HRESULT IsPathSupported(ushort* pwszSharePath, int* pbSupportedByThisProvider);
    HRESULT IsPathSnapshotted(ushort* pwszSharePath, int* pbSnapshotsPresent, int* plSnapshotCompatibility);
    HRESULT SetSnapshotProperty(Guid SnapshotId, VSS_SNAPSHOT_PROPERTY_ID eSnapshotPropertyId, VARIANT vProperty);
}

struct IDDVideoPortContainer
{
}

struct IDirectDrawVideoPort
{
}

struct IDirectDrawVideoPortNotify
{
}

struct IDDVideoPortContainerVtbl
{
}

struct IDirectDrawVideoPortVtbl
{
}

struct IDirectDrawVideoPortNotifyVtbl
{
}

alias LPDDENUMVIDEOCALLBACK = extern(Windows) HRESULT function(DDVIDEOPORTCAPS* param0, void* param1);
struct DDVIDEOPORTSTATUS
{
    uint dwSize;
    BOOL bInUse;
    uint dwFlags;
    uint dwReserved1;
    DDVIDEOPORTCONNECT VideoPortType;
    uint dwReserved2;
    uint dwReserved3;
}

struct DDVIDEOPORTNOTIFY
{
    LARGE_INTEGER ApproximateTimeStamp;
    int lField;
    uint dwSurfaceIndex;
    int lDone;
}

struct _DD_DESTROYDRIVERDATA
{
}

struct _DD_SETMODEDATA
{
}

struct _DD_GETVPORTAUTOFLIPSURFACEDATA
{
}

alias PDD_SETCOLORKEY = extern(Windows) uint function(DD_DRVSETCOLORKEYDATA* param0);
alias PDD_DESTROYDRIVER = extern(Windows) uint function(_DD_DESTROYDRIVERDATA* param0);
alias PDD_SETMODE = extern(Windows) uint function(_DD_SETMODEDATA* param0);
alias PDD_ALPHABLT = extern(Windows) uint function(DD_BLTDATA* param0);
alias PDD_SURFCB_SETCLIPLIST = extern(Windows) uint function(DD_SETCLIPLISTDATA* param0);
alias PDD_VPORTCB_GETAUTOFLIPSURF = extern(Windows) uint function(_DD_GETVPORTAUTOFLIPSURFACEDATA* param0);
struct DD_MORECAPS
{
    uint dwSize;
    uint dwAlphaCaps;
    uint dwSVBAlphaCaps;
    uint dwVSBAlphaCaps;
    uint dwSSBAlphaCaps;
    uint dwFilterCaps;
    uint dwSVBFilterCaps;
    uint dwVSBFilterCaps;
    uint dwSSBFilterCaps;
}

struct DDNTCORECAPS
{
    uint dwSize;
    uint dwCaps;
    uint dwCaps2;
    uint dwCKeyCaps;
    uint dwFXCaps;
    uint dwFXAlphaCaps;
    uint dwPalCaps;
    uint dwSVCaps;
    uint dwAlphaBltConstBitDepths;
    uint dwAlphaBltPixelBitDepths;
    uint dwAlphaBltSurfaceBitDepths;
    uint dwAlphaOverlayConstBitDepths;
    uint dwAlphaOverlayPixelBitDepths;
    uint dwAlphaOverlaySurfaceBitDepths;
    uint dwZBufferBitDepths;
    uint dwVidMemTotal;
    uint dwVidMemFree;
    uint dwMaxVisibleOverlays;
    uint dwCurrVisibleOverlays;
    uint dwNumFourCCCodes;
    uint dwAlignBoundarySrc;
    uint dwAlignSizeSrc;
    uint dwAlignBoundaryDest;
    uint dwAlignSizeDest;
    uint dwAlignStrideAlign;
    uint dwRops;
    DDSCAPS ddsCaps;
    uint dwMinOverlayStretch;
    uint dwMaxOverlayStretch;
    uint dwMinLiveVideoStretch;
    uint dwMaxLiveVideoStretch;
    uint dwMinHwCodecStretch;
    uint dwMaxHwCodecStretch;
    uint dwReserved1;
    uint dwReserved2;
    uint dwReserved3;
    uint dwSVBCaps;
    uint dwSVBCKeyCaps;
    uint dwSVBFXCaps;
    uint dwSVBRops;
    uint dwVSBCaps;
    uint dwVSBCKeyCaps;
    uint dwVSBFXCaps;
    uint dwVSBRops;
    uint dwSSBCaps;
    uint dwSSBCKeyCaps;
    uint dwSSBFXCaps;
    uint dwSSBRops;
    uint dwMaxVideoPorts;
    uint dwCurrVideoPorts;
    uint dwSVBCaps2;
}

struct DD_HALINFO_V4
{
    uint dwSize;
    VIDEOMEMORYINFO vmiData;
    DDNTCORECAPS ddCaps;
    PDD_GETDRIVERINFO GetDriverInfo;
    uint dwFlags;
}

struct DD_SETCLIPLISTDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    HRESULT ddRVal;
    void* SetClipList;
}

struct DD_DRVSETCOLORKEYDATA
{
    DD_SURFACE_LOCAL* lpDDSurface;
    uint dwFlags;
    DDCOLORKEY ckNew;
    HRESULT ddRVal;
    void* SetColorKey;
}

struct DD_DESTROYDDLOCALDATA
{
    uint dwFlags;
    DD_DIRECTDRAW_LOCAL* pDDLcl;
    HRESULT ddRVal;
}

alias LPD3DVALIDATECALLBACK = extern(Windows) HRESULT function(void* lpUserArg, uint dwOffset);
alias LPD3DENUMTEXTUREFORMATSCALLBACK = extern(Windows) HRESULT function(DDSURFACEDESC* lpDdsd, void* lpContext);
alias LPD3DENUMPIXELFORMATSCALLBACK = extern(Windows) HRESULT function(DDPIXELFORMAT* lpDDPixFmt, void* lpContext);
struct D3DRECT
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    _Anonymous4_e__Union Anonymous4;
}

struct D3DVECTOR
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
}

struct D3DHVERTEX
{
    uint dwFlags;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
}

struct D3DTLVERTEX
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    _Anonymous4_e__Union Anonymous4;
    _Anonymous5_e__Union Anonymous5;
    _Anonymous6_e__Union Anonymous6;
    _Anonymous7_e__Union Anonymous7;
    _Anonymous8_e__Union Anonymous8;
}

struct D3DLVERTEX
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    uint dwReserved;
    _Anonymous4_e__Union Anonymous4;
    _Anonymous5_e__Union Anonymous5;
    _Anonymous6_e__Union Anonymous6;
    _Anonymous7_e__Union Anonymous7;
}

struct D3DVERTEX
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    _Anonymous4_e__Union Anonymous4;
    _Anonymous5_e__Union Anonymous5;
    _Anonymous6_e__Union Anonymous6;
    _Anonymous7_e__Union Anonymous7;
    _Anonymous8_e__Union Anonymous8;
}

struct D3DVIEWPORT
{
    uint dwSize;
    uint dwX;
    uint dwY;
    uint dwWidth;
    uint dwHeight;
    float dvScaleX;
    float dvScaleY;
    float dvMaxX;
    float dvMaxY;
    float dvMinZ;
    float dvMaxZ;
}

struct D3DVIEWPORT2
{
    uint dwSize;
    uint dwX;
    uint dwY;
    uint dwWidth;
    uint dwHeight;
    float dvClipX;
    float dvClipY;
    float dvClipWidth;
    float dvClipHeight;
    float dvMinZ;
    float dvMaxZ;
}

struct D3DVIEWPORT7
{
    uint dwX;
    uint dwY;
    uint dwWidth;
    uint dwHeight;
    float dvMinZ;
    float dvMaxZ;
}

struct D3DTRANSFORMDATA
{
    uint dwSize;
    void* lpIn;
    uint dwInSize;
    void* lpOut;
    uint dwOutSize;
    D3DHVERTEX* lpHOut;
    uint dwClip;
    uint dwClipIntersection;
    uint dwClipUnion;
    D3DRECT drExtent;
}

struct D3DLIGHTINGELEMENT
{
    D3DVECTOR dvPosition;
    D3DVECTOR dvNormal;
}

struct D3DMATERIAL
{
    uint dwSize;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    _Anonymous4_e__Union Anonymous4;
    _Anonymous5_e__Union Anonymous5;
    uint hTexture;
    uint dwRampSize;
}

struct D3DMATERIAL7
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    _Anonymous4_e__Union Anonymous4;
    _Anonymous5_e__Union Anonymous5;
}

enum D3DLIGHTTYPE
{
    D3DLIGHT_POINT = 1,
    D3DLIGHT_SPOT = 2,
    D3DLIGHT_DIRECTIONAL = 3,
    D3DLIGHT_PARALLELPOINT = 4,
    D3DLIGHT_FORCE_DWORD = 2147483647,
}

struct D3DLIGHT
{
    uint dwSize;
    D3DLIGHTTYPE dltType;
    DXGI_RGBA dcvColor;
    D3DVECTOR dvPosition;
    D3DVECTOR dvDirection;
    float dvRange;
    float dvFalloff;
    float dvAttenuation0;
    float dvAttenuation1;
    float dvAttenuation2;
    float dvTheta;
    float dvPhi;
}

struct D3DLIGHT7
{
    D3DLIGHTTYPE dltType;
    DXGI_RGBA dcvDiffuse;
    DXGI_RGBA dcvSpecular;
    DXGI_RGBA dcvAmbient;
    D3DVECTOR dvPosition;
    D3DVECTOR dvDirection;
    float dvRange;
    float dvFalloff;
    float dvAttenuation0;
    float dvAttenuation1;
    float dvAttenuation2;
    float dvTheta;
    float dvPhi;
}

struct D3DLIGHT2
{
    uint dwSize;
    D3DLIGHTTYPE dltType;
    DXGI_RGBA dcvColor;
    D3DVECTOR dvPosition;
    D3DVECTOR dvDirection;
    float dvRange;
    float dvFalloff;
    float dvAttenuation0;
    float dvAttenuation1;
    float dvAttenuation2;
    float dvTheta;
    float dvPhi;
    uint dwFlags;
}

struct D3DLIGHTDATA
{
    uint dwSize;
    D3DLIGHTINGELEMENT* lpIn;
    uint dwInSize;
    D3DTLVERTEX* lpOut;
    uint dwOutSize;
}

enum D3DOPCODE
{
    D3DOP_POINT = 1,
    D3DOP_LINE = 2,
    D3DOP_TRIANGLE = 3,
    D3DOP_MATRIXLOAD = 4,
    D3DOP_MATRIXMULTIPLY = 5,
    D3DOP_STATETRANSFORM = 6,
    D3DOP_STATELIGHT = 7,
    D3DOP_STATERENDER = 8,
    D3DOP_PROCESSVERTICES = 9,
    D3DOP_TEXTURELOAD = 10,
    D3DOP_EXIT = 11,
    D3DOP_BRANCHFORWARD = 12,
    D3DOP_SPAN = 13,
    D3DOP_SETSTATUS = 14,
    D3DOP_FORCE_DWORD = 2147483647,
}

struct D3DINSTRUCTION
{
    ubyte bOpcode;
    ubyte bSize;
    ushort wCount;
}

struct D3DTEXTURELOAD
{
    uint hDestTexture;
    uint hSrcTexture;
}

struct D3DPICKRECORD
{
    ubyte bOpcode;
    ubyte bPad;
    uint dwOffset;
    float dvZ;
}

enum D3DSHADEMODE
{
    D3DSHADE_FLAT = 1,
    D3DSHADE_GOURAUD = 2,
    D3DSHADE_PHONG = 3,
    D3DSHADE_FORCE_DWORD = 2147483647,
}

enum D3DFILLMODE
{
    D3DFILL_POINT = 1,
    D3DFILL_WIREFRAME = 2,
    D3DFILL_SOLID = 3,
    D3DFILL_FORCE_DWORD = 2147483647,
}

struct D3DLINEPATTERN
{
    ushort wRepeatFactor;
    ushort wLinePattern;
}

enum D3DTEXTUREFILTER
{
    D3DFILTER_NEAREST = 1,
    D3DFILTER_LINEAR = 2,
    D3DFILTER_MIPNEAREST = 3,
    D3DFILTER_MIPLINEAR = 4,
    D3DFILTER_LINEARMIPNEAREST = 5,
    D3DFILTER_LINEARMIPLINEAR = 6,
    D3DFILTER_FORCE_DWORD = 2147483647,
}

enum D3DBLEND
{
    D3DBLEND_ZERO = 1,
    D3DBLEND_ONE = 2,
    D3DBLEND_SRCCOLOR = 3,
    D3DBLEND_INVSRCCOLOR = 4,
    D3DBLEND_SRCALPHA = 5,
    D3DBLEND_INVSRCALPHA = 6,
    D3DBLEND_DESTALPHA = 7,
    D3DBLEND_INVDESTALPHA = 8,
    D3DBLEND_DESTCOLOR = 9,
    D3DBLEND_INVDESTCOLOR = 10,
    D3DBLEND_SRCALPHASAT = 11,
    D3DBLEND_BOTHSRCALPHA = 12,
    D3DBLEND_BOTHINVSRCALPHA = 13,
    D3DBLEND_FORCE_DWORD = 2147483647,
}

enum D3DTEXTUREBLEND
{
    D3DTBLEND_DECAL = 1,
    D3DTBLEND_MODULATE = 2,
    D3DTBLEND_DECALALPHA = 3,
    D3DTBLEND_MODULATEALPHA = 4,
    D3DTBLEND_DECALMASK = 5,
    D3DTBLEND_MODULATEMASK = 6,
    D3DTBLEND_COPY = 7,
    D3DTBLEND_ADD = 8,
    D3DTBLEND_FORCE_DWORD = 2147483647,
}

enum D3DTEXTUREADDRESS
{
    D3DTADDRESS_WRAP = 1,
    D3DTADDRESS_MIRROR = 2,
    D3DTADDRESS_CLAMP = 3,
    D3DTADDRESS_BORDER = 4,
    D3DTADDRESS_FORCE_DWORD = 2147483647,
}

enum D3DCULL
{
    D3DCULL_NONE = 1,
    D3DCULL_CW = 2,
    D3DCULL_CCW = 3,
    D3DCULL_FORCE_DWORD = 2147483647,
}

enum D3DCMPFUNC
{
    D3DCMP_NEVER = 1,
    D3DCMP_LESS = 2,
    D3DCMP_EQUAL = 3,
    D3DCMP_LESSEQUAL = 4,
    D3DCMP_GREATER = 5,
    D3DCMP_NOTEQUAL = 6,
    D3DCMP_GREATEREQUAL = 7,
    D3DCMP_ALWAYS = 8,
    D3DCMP_FORCE_DWORD = 2147483647,
}

enum D3DSTENCILOP
{
    D3DSTENCILOP_KEEP = 1,
    D3DSTENCILOP_ZERO = 2,
    D3DSTENCILOP_REPLACE = 3,
    D3DSTENCILOP_INCRSAT = 4,
    D3DSTENCILOP_DECRSAT = 5,
    D3DSTENCILOP_INVERT = 6,
    D3DSTENCILOP_INCR = 7,
    D3DSTENCILOP_DECR = 8,
    D3DSTENCILOP_FORCE_DWORD = 2147483647,
}

enum D3DFOGMODE
{
    D3DFOG_NONE = 0,
    D3DFOG_EXP = 1,
    D3DFOG_EXP2 = 2,
    D3DFOG_LINEAR = 3,
    D3DFOG_FORCE_DWORD = 2147483647,
}

enum D3DZBUFFERTYPE
{
    D3DZB_FALSE = 0,
    D3DZB_TRUE = 1,
    D3DZB_USEW = 2,
    D3DZB_FORCE_DWORD = 2147483647,
}

enum D3DANTIALIASMODE
{
    D3DANTIALIAS_NONE = 0,
    D3DANTIALIAS_SORTDEPENDENT = 1,
    D3DANTIALIAS_SORTINDEPENDENT = 2,
    D3DANTIALIAS_FORCE_DWORD = 2147483647,
}

enum D3DVERTEXTYPE
{
    D3DVT_VERTEX = 1,
    D3DVT_LVERTEX = 2,
    D3DVT_TLVERTEX = 3,
    D3DVT_FORCE_DWORD = 2147483647,
}

enum D3DPRIMITIVETYPE
{
    D3DPT_POINTLIST = 1,
    D3DPT_LINELIST = 2,
    D3DPT_LINESTRIP = 3,
    D3DPT_TRIANGLELIST = 4,
    D3DPT_TRIANGLESTRIP = 5,
    D3DPT_TRIANGLEFAN = 6,
    D3DPT_FORCE_DWORD = 2147483647,
}

enum D3DTRANSFORMSTATETYPE
{
    D3DTRANSFORMSTATE_WORLD = 1,
    D3DTRANSFORMSTATE_VIEW = 2,
    D3DTRANSFORMSTATE_PROJECTION = 3,
    D3DTRANSFORMSTATE_WORLD1 = 4,
    D3DTRANSFORMSTATE_WORLD2 = 5,
    D3DTRANSFORMSTATE_WORLD3 = 6,
    D3DTRANSFORMSTATE_TEXTURE0 = 16,
    D3DTRANSFORMSTATE_TEXTURE1 = 17,
    D3DTRANSFORMSTATE_TEXTURE2 = 18,
    D3DTRANSFORMSTATE_TEXTURE3 = 19,
    D3DTRANSFORMSTATE_TEXTURE4 = 20,
    D3DTRANSFORMSTATE_TEXTURE5 = 21,
    D3DTRANSFORMSTATE_TEXTURE6 = 22,
    D3DTRANSFORMSTATE_TEXTURE7 = 23,
    D3DTRANSFORMSTATE_FORCE_DWORD = 2147483647,
}

enum D3DLIGHTSTATETYPE
{
    D3DLIGHTSTATE_MATERIAL = 1,
    D3DLIGHTSTATE_AMBIENT = 2,
    D3DLIGHTSTATE_COLORMODEL = 3,
    D3DLIGHTSTATE_FOGMODE = 4,
    D3DLIGHTSTATE_FOGSTART = 5,
    D3DLIGHTSTATE_FOGEND = 6,
    D3DLIGHTSTATE_FOGDENSITY = 7,
    D3DLIGHTSTATE_COLORVERTEX = 8,
    D3DLIGHTSTATE_FORCE_DWORD = 2147483647,
}

enum D3DRENDERSTATETYPE
{
    D3DRENDERSTATE_ANTIALIAS = 2,
    D3DRENDERSTATE_TEXTUREPERSPECTIVE = 4,
    D3DRENDERSTATE_ZENABLE = 7,
    D3DRENDERSTATE_FILLMODE = 8,
    D3DRENDERSTATE_SHADEMODE = 9,
    D3DRENDERSTATE_LINEPATTERN = 10,
    D3DRENDERSTATE_ZWRITEENABLE = 14,
    D3DRENDERSTATE_ALPHATESTENABLE = 15,
    D3DRENDERSTATE_LASTPIXEL = 16,
    D3DRENDERSTATE_SRCBLEND = 19,
    D3DRENDERSTATE_DESTBLEND = 20,
    D3DRENDERSTATE_CULLMODE = 22,
    D3DRENDERSTATE_ZFUNC = 23,
    D3DRENDERSTATE_ALPHAREF = 24,
    D3DRENDERSTATE_ALPHAFUNC = 25,
    D3DRENDERSTATE_DITHERENABLE = 26,
    D3DRENDERSTATE_ALPHABLENDENABLE = 27,
    D3DRENDERSTATE_FOGENABLE = 28,
    D3DRENDERSTATE_SPECULARENABLE = 29,
    D3DRENDERSTATE_ZVISIBLE = 30,
    D3DRENDERSTATE_STIPPLEDALPHA = 33,
    D3DRENDERSTATE_FOGCOLOR = 34,
    D3DRENDERSTATE_FOGTABLEMODE = 35,
    D3DRENDERSTATE_FOGSTART = 36,
    D3DRENDERSTATE_FOGEND = 37,
    D3DRENDERSTATE_FOGDENSITY = 38,
    D3DRENDERSTATE_EDGEANTIALIAS = 40,
    D3DRENDERSTATE_COLORKEYENABLE = 41,
    D3DRENDERSTATE_ZBIAS = 47,
    D3DRENDERSTATE_RANGEFOGENABLE = 48,
    D3DRENDERSTATE_STENCILENABLE = 52,
    D3DRENDERSTATE_STENCILFAIL = 53,
    D3DRENDERSTATE_STENCILZFAIL = 54,
    D3DRENDERSTATE_STENCILPASS = 55,
    D3DRENDERSTATE_STENCILFUNC = 56,
    D3DRENDERSTATE_STENCILREF = 57,
    D3DRENDERSTATE_STENCILMASK = 58,
    D3DRENDERSTATE_STENCILWRITEMASK = 59,
    D3DRENDERSTATE_TEXTUREFACTOR = 60,
    D3DRENDERSTATE_WRAP0 = 128,
    D3DRENDERSTATE_WRAP1 = 129,
    D3DRENDERSTATE_WRAP2 = 130,
    D3DRENDERSTATE_WRAP3 = 131,
    D3DRENDERSTATE_WRAP4 = 132,
    D3DRENDERSTATE_WRAP5 = 133,
    D3DRENDERSTATE_WRAP6 = 134,
    D3DRENDERSTATE_WRAP7 = 135,
    D3DRENDERSTATE_CLIPPING = 136,
    D3DRENDERSTATE_LIGHTING = 137,
    D3DRENDERSTATE_EXTENTS = 138,
    D3DRENDERSTATE_AMBIENT = 139,
    D3DRENDERSTATE_FOGVERTEXMODE = 140,
    D3DRENDERSTATE_COLORVERTEX = 141,
    D3DRENDERSTATE_LOCALVIEWER = 142,
    D3DRENDERSTATE_NORMALIZENORMALS = 143,
    D3DRENDERSTATE_COLORKEYBLENDENABLE = 144,
    D3DRENDERSTATE_DIFFUSEMATERIALSOURCE = 145,
    D3DRENDERSTATE_SPECULARMATERIALSOURCE = 146,
    D3DRENDERSTATE_AMBIENTMATERIALSOURCE = 147,
    D3DRENDERSTATE_EMISSIVEMATERIALSOURCE = 148,
    D3DRENDERSTATE_VERTEXBLEND = 151,
    D3DRENDERSTATE_CLIPPLANEENABLE = 152,
    D3DRENDERSTATE_TEXTUREHANDLE = 1,
    D3DRENDERSTATE_TEXTUREADDRESS = 3,
    D3DRENDERSTATE_WRAPU = 5,
    D3DRENDERSTATE_WRAPV = 6,
    D3DRENDERSTATE_MONOENABLE = 11,
    D3DRENDERSTATE_ROP2 = 12,
    D3DRENDERSTATE_PLANEMASK = 13,
    D3DRENDERSTATE_TEXTUREMAG = 17,
    D3DRENDERSTATE_TEXTUREMIN = 18,
    D3DRENDERSTATE_TEXTUREMAPBLEND = 21,
    D3DRENDERSTATE_SUBPIXEL = 31,
    D3DRENDERSTATE_SUBPIXELX = 32,
    D3DRENDERSTATE_STIPPLEENABLE = 39,
    D3DRENDERSTATE_BORDERCOLOR = 43,
    D3DRENDERSTATE_TEXTUREADDRESSU = 44,
    D3DRENDERSTATE_TEXTUREADDRESSV = 45,
    D3DRENDERSTATE_MIPMAPLODBIAS = 46,
    D3DRENDERSTATE_ANISOTROPY = 49,
    D3DRENDERSTATE_FLUSHBATCH = 50,
    D3DRENDERSTATE_TRANSLUCENTSORTINDEPENDENT = 51,
    D3DRENDERSTATE_STIPPLEPATTERN00 = 64,
    D3DRENDERSTATE_STIPPLEPATTERN01 = 65,
    D3DRENDERSTATE_STIPPLEPATTERN02 = 66,
    D3DRENDERSTATE_STIPPLEPATTERN03 = 67,
    D3DRENDERSTATE_STIPPLEPATTERN04 = 68,
    D3DRENDERSTATE_STIPPLEPATTERN05 = 69,
    D3DRENDERSTATE_STIPPLEPATTERN06 = 70,
    D3DRENDERSTATE_STIPPLEPATTERN07 = 71,
    D3DRENDERSTATE_STIPPLEPATTERN08 = 72,
    D3DRENDERSTATE_STIPPLEPATTERN09 = 73,
    D3DRENDERSTATE_STIPPLEPATTERN10 = 74,
    D3DRENDERSTATE_STIPPLEPATTERN11 = 75,
    D3DRENDERSTATE_STIPPLEPATTERN12 = 76,
    D3DRENDERSTATE_STIPPLEPATTERN13 = 77,
    D3DRENDERSTATE_STIPPLEPATTERN14 = 78,
    D3DRENDERSTATE_STIPPLEPATTERN15 = 79,
    D3DRENDERSTATE_STIPPLEPATTERN16 = 80,
    D3DRENDERSTATE_STIPPLEPATTERN17 = 81,
    D3DRENDERSTATE_STIPPLEPATTERN18 = 82,
    D3DRENDERSTATE_STIPPLEPATTERN19 = 83,
    D3DRENDERSTATE_STIPPLEPATTERN20 = 84,
    D3DRENDERSTATE_STIPPLEPATTERN21 = 85,
    D3DRENDERSTATE_STIPPLEPATTERN22 = 86,
    D3DRENDERSTATE_STIPPLEPATTERN23 = 87,
    D3DRENDERSTATE_STIPPLEPATTERN24 = 88,
    D3DRENDERSTATE_STIPPLEPATTERN25 = 89,
    D3DRENDERSTATE_STIPPLEPATTERN26 = 90,
    D3DRENDERSTATE_STIPPLEPATTERN27 = 91,
    D3DRENDERSTATE_STIPPLEPATTERN28 = 92,
    D3DRENDERSTATE_STIPPLEPATTERN29 = 93,
    D3DRENDERSTATE_STIPPLEPATTERN30 = 94,
    D3DRENDERSTATE_STIPPLEPATTERN31 = 95,
    D3DRENDERSTATE_FOGTABLESTART = 36,
    D3DRENDERSTATE_FOGTABLEEND = 37,
    D3DRENDERSTATE_FOGTABLEDENSITY = 38,
    D3DRENDERSTATE_FORCE_DWORD = 2147483647,
}

enum D3DMATERIALCOLORSOURCE
{
    D3DMCS_MATERIAL = 0,
    D3DMCS_COLOR1 = 1,
    D3DMCS_COLOR2 = 2,
    D3DMCS_FORCE_DWORD = 2147483647,
}

struct D3DSTATE
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct D3DMATRIXLOAD
{
    uint hDestMatrix;
    uint hSrcMatrix;
}

struct D3DMATRIXMULTIPLY
{
    uint hDestMatrix;
    uint hSrcMatrix1;
    uint hSrcMatrix2;
}

struct D3DPROCESSVERTICES
{
    uint dwFlags;
    ushort wStart;
    ushort wDest;
    uint dwCount;
    uint dwReserved;
}

enum D3DTEXTURESTAGESTATETYPE
{
    D3DTSS_COLOROP = 1,
    D3DTSS_COLORARG1 = 2,
    D3DTSS_COLORARG2 = 3,
    D3DTSS_ALPHAOP = 4,
    D3DTSS_ALPHAARG1 = 5,
    D3DTSS_ALPHAARG2 = 6,
    D3DTSS_BUMPENVMAT00 = 7,
    D3DTSS_BUMPENVMAT01 = 8,
    D3DTSS_BUMPENVMAT10 = 9,
    D3DTSS_BUMPENVMAT11 = 10,
    D3DTSS_TEXCOORDINDEX = 11,
    D3DTSS_ADDRESS = 12,
    D3DTSS_ADDRESSU = 13,
    D3DTSS_ADDRESSV = 14,
    D3DTSS_BORDERCOLOR = 15,
    D3DTSS_MAGFILTER = 16,
    D3DTSS_MINFILTER = 17,
    D3DTSS_MIPFILTER = 18,
    D3DTSS_MIPMAPLODBIAS = 19,
    D3DTSS_MAXMIPLEVEL = 20,
    D3DTSS_MAXANISOTROPY = 21,
    D3DTSS_BUMPENVLSCALE = 22,
    D3DTSS_BUMPENVLOFFSET = 23,
    D3DTSS_TEXTURETRANSFORMFLAGS = 24,
    D3DTSS_FORCE_DWORD = 2147483647,
}

enum D3DTEXTUREOP
{
    D3DTOP_DISABLE = 1,
    D3DTOP_SELECTARG1 = 2,
    D3DTOP_SELECTARG2 = 3,
    D3DTOP_MODULATE = 4,
    D3DTOP_MODULATE2X = 5,
    D3DTOP_MODULATE4X = 6,
    D3DTOP_ADD = 7,
    D3DTOP_ADDSIGNED = 8,
    D3DTOP_ADDSIGNED2X = 9,
    D3DTOP_SUBTRACT = 10,
    D3DTOP_ADDSMOOTH = 11,
    D3DTOP_BLENDDIFFUSEALPHA = 12,
    D3DTOP_BLENDTEXTUREALPHA = 13,
    D3DTOP_BLENDFACTORALPHA = 14,
    D3DTOP_BLENDTEXTUREALPHAPM = 15,
    D3DTOP_BLENDCURRENTALPHA = 16,
    D3DTOP_PREMODULATE = 17,
    D3DTOP_MODULATEALPHA_ADDCOLOR = 18,
    D3DTOP_MODULATECOLOR_ADDALPHA = 19,
    D3DTOP_MODULATEINVALPHA_ADDCOLOR = 20,
    D3DTOP_MODULATEINVCOLOR_ADDALPHA = 21,
    D3DTOP_BUMPENVMAP = 22,
    D3DTOP_BUMPENVMAPLUMINANCE = 23,
    D3DTOP_DOTPRODUCT3 = 24,
    D3DTOP_FORCE_DWORD = 2147483647,
}

enum D3DTEXTUREMAGFILTER
{
    D3DTFG_POINT = 1,
    D3DTFG_LINEAR = 2,
    D3DTFG_FLATCUBIC = 3,
    D3DTFG_GAUSSIANCUBIC = 4,
    D3DTFG_ANISOTROPIC = 5,
    D3DTFG_FORCE_DWORD = 2147483647,
}

enum D3DTEXTUREMINFILTER
{
    D3DTFN_POINT = 1,
    D3DTFN_LINEAR = 2,
    D3DTFN_ANISOTROPIC = 3,
    D3DTFN_FORCE_DWORD = 2147483647,
}

enum D3DTEXTUREMIPFILTER
{
    D3DTFP_NONE = 1,
    D3DTFP_POINT = 2,
    D3DTFP_LINEAR = 3,
    D3DTFP_FORCE_DWORD = 2147483647,
}

struct D3DTRIANGLE
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    ushort wFlags;
}

struct D3DLINE
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct D3DSPAN
{
    ushort wCount;
    ushort wFirst;
}

struct D3DPOINT
{
    ushort wCount;
    ushort wFirst;
}

struct D3DBRANCH
{
    uint dwMask;
    uint dwValue;
    BOOL bNegate;
    uint dwOffset;
}

struct D3DSTATUS
{
    uint dwFlags;
    uint dwStatus;
    D3DRECT drExtent;
}

struct D3DCLIPSTATUS
{
    uint dwFlags;
    uint dwStatus;
    float minx;
    float maxx;
    float miny;
    float maxy;
    float minz;
    float maxz;
}

struct D3DSTATS
{
    uint dwSize;
    uint dwTrianglesDrawn;
    uint dwLinesDrawn;
    uint dwPointsDrawn;
    uint dwSpansDrawn;
    uint dwVerticesProcessed;
}

struct D3DEXECUTEDATA
{
    uint dwSize;
    uint dwVertexOffset;
    uint dwVertexCount;
    uint dwInstructionOffset;
    uint dwInstructionLength;
    uint dwHVertexOffset;
    D3DSTATUS dsStatus;
}

struct D3DVERTEXBUFFERDESC
{
    uint dwSize;
    uint dwCaps;
    uint dwFVF;
    uint dwNumVertices;
}

struct D3DDP_PTRSTRIDE
{
    void* lpvData;
    uint dwStride;
}

struct D3DDRAWPRIMITIVESTRIDEDDATA
{
    D3DDP_PTRSTRIDE position;
    D3DDP_PTRSTRIDE normal;
    D3DDP_PTRSTRIDE diffuse;
    D3DDP_PTRSTRIDE specular;
    D3DDP_PTRSTRIDE textureCoords;
}

enum D3DSTATEBLOCKTYPE
{
    D3DSBT_ALL = 1,
    D3DSBT_PIXELSTATE = 2,
    D3DSBT_VERTEXSTATE = 3,
    D3DSBT_FORCE_DWORD = -1,
}

enum D3DVERTEXBLENDFLAGS
{
    D3DVBLEND_DISABLE = 0,
    D3DVBLEND_1WEIGHT = 1,
    D3DVBLEND_2WEIGHTS = 2,
    D3DVBLEND_3WEIGHTS = 3,
}

enum D3DTEXTURETRANSFORMFLAGS
{
    D3DTTFF_DISABLE = 0,
    D3DTTFF_COUNT1 = 1,
    D3DTTFF_COUNT2 = 2,
    D3DTTFF_COUNT3 = 3,
    D3DTTFF_COUNT4 = 4,
    D3DTTFF_PROJECTED = 256,
    D3DTTFF_FORCE_DWORD = 2147483647,
}

struct D3DTRANSFORMCAPS
{
    uint dwSize;
    uint dwCaps;
}

struct D3DLIGHTINGCAPS
{
    uint dwSize;
    uint dwCaps;
    uint dwLightingModel;
    uint dwNumLights;
}

struct _D3DPrimCaps
{
    uint dwSize;
    uint dwMiscCaps;
    uint dwRasterCaps;
    uint dwZCmpCaps;
    uint dwSrcBlendCaps;
    uint dwDestBlendCaps;
    uint dwAlphaCmpCaps;
    uint dwShadeCaps;
    uint dwTextureCaps;
    uint dwTextureFilterCaps;
    uint dwTextureBlendCaps;
    uint dwTextureAddressCaps;
    uint dwStippleWidth;
    uint dwStippleHeight;
}

struct _D3DDeviceDesc
{
    uint dwSize;
    uint dwFlags;
    uint dcmColorModel;
    uint dwDevCaps;
    D3DTRANSFORMCAPS dtcTransformCaps;
    BOOL bClipping;
    D3DLIGHTINGCAPS dlcLightingCaps;
    _D3DPrimCaps dpcLineCaps;
    _D3DPrimCaps dpcTriCaps;
    uint dwDeviceRenderBitDepth;
    uint dwDeviceZBufferBitDepth;
    uint dwMaxBufferSize;
    uint dwMaxVertexCount;
    uint dwMinTextureWidth;
    uint dwMinTextureHeight;
    uint dwMaxTextureWidth;
    uint dwMaxTextureHeight;
    uint dwMinStippleWidth;
    uint dwMaxStippleWidth;
    uint dwMinStippleHeight;
    uint dwMaxStippleHeight;
    uint dwMaxTextureRepeat;
    uint dwMaxTextureAspectRatio;
    uint dwMaxAnisotropy;
    float dvGuardBandLeft;
    float dvGuardBandTop;
    float dvGuardBandRight;
    float dvGuardBandBottom;
    float dvExtentsAdjust;
    uint dwStencilCaps;
    uint dwFVFCaps;
    uint dwTextureOpCaps;
    ushort wMaxTextureBlendStages;
    ushort wMaxSimultaneousTextures;
}

struct _D3DDeviceDesc7
{
    uint dwDevCaps;
    _D3DPrimCaps dpcLineCaps;
    _D3DPrimCaps dpcTriCaps;
    uint dwDeviceRenderBitDepth;
    uint dwDeviceZBufferBitDepth;
    uint dwMinTextureWidth;
    uint dwMinTextureHeight;
    uint dwMaxTextureWidth;
    uint dwMaxTextureHeight;
    uint dwMaxTextureRepeat;
    uint dwMaxTextureAspectRatio;
    uint dwMaxAnisotropy;
    float dvGuardBandLeft;
    float dvGuardBandTop;
    float dvGuardBandRight;
    float dvGuardBandBottom;
    float dvExtentsAdjust;
    uint dwStencilCaps;
    uint dwFVFCaps;
    uint dwTextureOpCaps;
    ushort wMaxTextureBlendStages;
    ushort wMaxSimultaneousTextures;
    uint dwMaxActiveLights;
    float dvMaxVertexW;
    Guid deviceGUID;
    ushort wMaxUserClipPlanes;
    ushort wMaxVertexBlendMatrices;
    uint dwVertexProcessingCaps;
    uint dwReserved1;
    uint dwReserved2;
    uint dwReserved3;
    uint dwReserved4;
}

alias LPD3DENUMDEVICESCALLBACK = extern(Windows) HRESULT function(Guid* lpGuid, const(char)* lpDeviceDescription, const(char)* lpDeviceName, _D3DDeviceDesc* param3, _D3DDeviceDesc* param4, void* param5);
alias LPD3DENUMDEVICESCALLBACK7 = extern(Windows) HRESULT function(const(char)* lpDeviceDescription, const(char)* lpDeviceName, _D3DDeviceDesc7* param2, void* param3);
struct D3DFINDDEVICESEARCH
{
    uint dwSize;
    uint dwFlags;
    BOOL bHardware;
    uint dcmColorModel;
    Guid guid;
    uint dwCaps;
    _D3DPrimCaps dpcPrimCaps;
}

struct D3DFINDDEVICERESULT
{
    uint dwSize;
    Guid guid;
    _D3DDeviceDesc ddHwDesc;
    _D3DDeviceDesc ddSwDesc;
}

struct _D3DExecuteBufferDesc
{
    uint dwSize;
    uint dwFlags;
    uint dwCaps;
    uint dwBufferSize;
    void* lpData;
}

struct D3DDEVINFO_TEXTUREMANAGER
{
    BOOL bThrashing;
    uint dwApproxBytesDownloaded;
    uint dwNumEvicts;
    uint dwNumVidCreates;
    uint dwNumTexturesUsed;
    uint dwNumUsedTexInVid;
    uint dwWorkingSet;
    uint dwWorkingSetBytes;
    uint dwTotalManaged;
    uint dwTotalBytes;
    uint dwLastPri;
}

struct D3DDEVINFO_TEXTURING
{
    uint dwNumLoads;
    uint dwApproxBytesLoaded;
    uint dwNumPreLoads;
    uint dwNumSet;
    uint dwNumCreates;
    uint dwNumDestroys;
    uint dwNumSetPriorities;
    uint dwNumSetLODs;
    uint dwNumLocks;
    uint dwNumGetDCs;
}

struct _D3DNTHALDeviceDesc_V1
{
    uint dwSize;
    uint dwFlags;
    uint dcmColorModel;
    uint dwDevCaps;
    D3DTRANSFORMCAPS dtcTransformCaps;
    BOOL bClipping;
    D3DLIGHTINGCAPS dlcLightingCaps;
    _D3DPrimCaps dpcLineCaps;
    _D3DPrimCaps dpcTriCaps;
    uint dwDeviceRenderBitDepth;
    uint dwDeviceZBufferBitDepth;
    uint dwMaxBufferSize;
    uint dwMaxVertexCount;
}

struct _D3DNTHALDeviceDesc_V2
{
    uint dwSize;
    uint dwFlags;
    uint dcmColorModel;
    uint dwDevCaps;
    D3DTRANSFORMCAPS dtcTransformCaps;
    BOOL bClipping;
    D3DLIGHTINGCAPS dlcLightingCaps;
    _D3DPrimCaps dpcLineCaps;
    _D3DPrimCaps dpcTriCaps;
    uint dwDeviceRenderBitDepth;
    uint dwDeviceZBufferBitDepth;
    uint dwMaxBufferSize;
    uint dwMaxVertexCount;
    uint dwMinTextureWidth;
    uint dwMinTextureHeight;
    uint dwMaxTextureWidth;
    uint dwMaxTextureHeight;
    uint dwMinStippleWidth;
    uint dwMaxStippleWidth;
    uint dwMinStippleHeight;
    uint dwMaxStippleHeight;
}

struct _D3DNTDeviceDesc_V3
{
    uint dwSize;
    uint dwFlags;
    uint dcmColorModel;
    uint dwDevCaps;
    D3DTRANSFORMCAPS dtcTransformCaps;
    BOOL bClipping;
    D3DLIGHTINGCAPS dlcLightingCaps;
    _D3DPrimCaps dpcLineCaps;
    _D3DPrimCaps dpcTriCaps;
    uint dwDeviceRenderBitDepth;
    uint dwDeviceZBufferBitDepth;
    uint dwMaxBufferSize;
    uint dwMaxVertexCount;
    uint dwMinTextureWidth;
    uint dwMinTextureHeight;
    uint dwMaxTextureWidth;
    uint dwMaxTextureHeight;
    uint dwMinStippleWidth;
    uint dwMaxStippleWidth;
    uint dwMinStippleHeight;
    uint dwMaxStippleHeight;
    uint dwMaxTextureRepeat;
    uint dwMaxTextureAspectRatio;
    uint dwMaxAnisotropy;
    float dvGuardBandLeft;
    float dvGuardBandTop;
    float dvGuardBandRight;
    float dvGuardBandBottom;
    float dvExtentsAdjust;
    uint dwStencilCaps;
    uint dwFVFCaps;
    uint dwTextureOpCaps;
    ushort wMaxTextureBlendStages;
    ushort wMaxSimultaneousTextures;
}

struct D3DNTHAL_GLOBALDRIVERDATA
{
    uint dwSize;
    _D3DNTHALDeviceDesc_V1 hwCaps;
    uint dwNumVertices;
    uint dwNumClipVertices;
    uint dwNumTextureFormats;
    DDSURFACEDESC* lpTextureFormats;
}

struct D3DNTHAL_D3DDX6EXTENDEDCAPS
{
    uint dwSize;
    uint dwMinTextureWidth;
    uint dwMaxTextureWidth;
    uint dwMinTextureHeight;
    uint dwMaxTextureHeight;
    uint dwMinStippleWidth;
    uint dwMaxStippleWidth;
    uint dwMinStippleHeight;
    uint dwMaxStippleHeight;
    uint dwMaxTextureRepeat;
    uint dwMaxTextureAspectRatio;
    uint dwMaxAnisotropy;
    float dvGuardBandLeft;
    float dvGuardBandTop;
    float dvGuardBandRight;
    float dvGuardBandBottom;
    float dvExtentsAdjust;
    uint dwStencilCaps;
    uint dwFVFCaps;
    uint dwTextureOpCaps;
    ushort wMaxTextureBlendStages;
    ushort wMaxSimultaneousTextures;
}

struct D3DNTHAL_D3DEXTENDEDCAPS
{
    uint dwSize;
    uint dwMinTextureWidth;
    uint dwMaxTextureWidth;
    uint dwMinTextureHeight;
    uint dwMaxTextureHeight;
    uint dwMinStippleWidth;
    uint dwMaxStippleWidth;
    uint dwMinStippleHeight;
    uint dwMaxStippleHeight;
    uint dwMaxTextureRepeat;
    uint dwMaxTextureAspectRatio;
    uint dwMaxAnisotropy;
    float dvGuardBandLeft;
    float dvGuardBandTop;
    float dvGuardBandRight;
    float dvGuardBandBottom;
    float dvExtentsAdjust;
    uint dwStencilCaps;
    uint dwFVFCaps;
    uint dwTextureOpCaps;
    ushort wMaxTextureBlendStages;
    ushort wMaxSimultaneousTextures;
    uint dwMaxActiveLights;
    float dvMaxVertexW;
    ushort wMaxUserClipPlanes;
    ushort wMaxVertexBlendMatrices;
    uint dwVertexProcessingCaps;
    uint dwReserved1;
    uint dwReserved2;
    uint dwReserved3;
    uint dwReserved4;
}

struct D3DNTHAL_CONTEXTCREATEDATA
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    uint dwPID;
    uint dwhContext;
    HRESULT ddrval;
}

struct D3DNTHAL_CONTEXTDESTROYDATA
{
    uint dwhContext;
    HRESULT ddrval;
}

struct D3DNTHAL_CONTEXTDESTROYALLDATA
{
    uint dwPID;
    HRESULT ddrval;
}

struct D3DNTHAL_SCENECAPTUREDATA
{
    uint dwhContext;
    uint dwFlag;
    HRESULT ddrval;
}

struct D3DNTHAL_TEXTURECREATEDATA
{
    uint dwhContext;
    HANDLE hDDS;
    uint dwHandle;
    HRESULT ddrval;
}

struct D3DNTHAL_TEXTUREDESTROYDATA
{
    uint dwhContext;
    uint dwHandle;
    HRESULT ddrval;
}

struct D3DNTHAL_TEXTURESWAPDATA
{
    uint dwhContext;
    uint dwHandle1;
    uint dwHandle2;
    HRESULT ddrval;
}

struct D3DNTHAL_TEXTUREGETSURFDATA
{
    uint dwhContext;
    HANDLE hDDS;
    uint dwHandle;
    HRESULT ddrval;
}

alias LPD3DNTHAL_CONTEXTCREATECB = extern(Windows) uint function(D3DNTHAL_CONTEXTCREATEDATA* param0);
alias LPD3DNTHAL_CONTEXTDESTROYCB = extern(Windows) uint function(D3DNTHAL_CONTEXTDESTROYDATA* param0);
alias LPD3DNTHAL_CONTEXTDESTROYALLCB = extern(Windows) uint function(D3DNTHAL_CONTEXTDESTROYALLDATA* param0);
alias LPD3DNTHAL_SCENECAPTURECB = extern(Windows) uint function(D3DNTHAL_SCENECAPTUREDATA* param0);
alias LPD3DNTHAL_TEXTURECREATECB = extern(Windows) uint function(D3DNTHAL_TEXTURECREATEDATA* param0);
alias LPD3DNTHAL_TEXTUREDESTROYCB = extern(Windows) uint function(D3DNTHAL_TEXTUREDESTROYDATA* param0);
alias LPD3DNTHAL_TEXTURESWAPCB = extern(Windows) uint function(D3DNTHAL_TEXTURESWAPDATA* param0);
alias LPD3DNTHAL_TEXTUREGETSURFCB = extern(Windows) uint function(D3DNTHAL_TEXTUREGETSURFDATA* param0);
struct D3DNTHAL_CALLBACKS
{
    uint dwSize;
    LPD3DNTHAL_CONTEXTCREATECB ContextCreate;
    LPD3DNTHAL_CONTEXTDESTROYCB ContextDestroy;
    LPD3DNTHAL_CONTEXTDESTROYALLCB ContextDestroyAll;
    LPD3DNTHAL_SCENECAPTURECB SceneCapture;
    void* dwReserved10;
    void* dwReserved11;
    void* dwReserved22;
    void* dwReserved23;
    uint dwReserved;
    LPD3DNTHAL_TEXTURECREATECB TextureCreate;
    LPD3DNTHAL_TEXTUREDESTROYCB TextureDestroy;
    LPD3DNTHAL_TEXTURESWAPCB TextureSwap;
    LPD3DNTHAL_TEXTUREGETSURFCB TextureGetSurf;
    void* dwReserved12;
    void* dwReserved13;
    void* dwReserved14;
    void* dwReserved15;
    void* dwReserved16;
    void* dwReserved17;
    void* dwReserved18;
    void* dwReserved19;
    void* dwReserved20;
    void* dwReserved21;
    void* dwReserved24;
    uint dwReserved0;
    uint dwReserved1;
    uint dwReserved2;
    uint dwReserved3;
    uint dwReserved4;
    uint dwReserved5;
    uint dwReserved6;
    uint dwReserved7;
    uint dwReserved8;
    uint dwReserved9;
}

struct D3DNTHAL_SETRENDERTARGETDATA
{
    uint dwhContext;
    DD_SURFACE_LOCAL* lpDDS;
    DD_SURFACE_LOCAL* lpDDSZ;
    HRESULT ddrval;
}

alias LPD3DNTHAL_SETRENDERTARGETCB = extern(Windows) uint function(D3DNTHAL_SETRENDERTARGETDATA* param0);
struct D3DNTHAL_CALLBACKS2
{
    uint dwSize;
    uint dwFlags;
    LPD3DNTHAL_SETRENDERTARGETCB SetRenderTarget;
    void* dwReserved1;
    void* dwReserved2;
    void* dwReserved3;
    void* dwReserved4;
}

struct D3DNTHAL_CLEAR2DATA
{
    uint dwhContext;
    uint dwFlags;
    uint dwFillColor;
    float dvFillDepth;
    uint dwFillStencil;
    D3DRECT* lpRects;
    uint dwNumRects;
    HRESULT ddrval;
}

struct D3DNTHAL_VALIDATETEXTURESTAGESTATEDATA
{
    uint dwhContext;
    uint dwFlags;
    uint dwReserved;
    uint dwNumPasses;
    HRESULT ddrval;
}

struct D3DNTHAL_DP2COMMAND
{
    ubyte bCommand;
    ubyte bReserved;
    _Anonymous_e__Union Anonymous;
}

enum D3DNTHAL_DP2OPERATION
{
    D3DNTDP2OP_POINTS = 1,
    D3DNTDP2OP_INDEXEDLINELIST = 2,
    D3DNTDP2OP_INDEXEDTRIANGLELIST = 3,
    D3DNTDP2OP_RENDERSTATE = 8,
    D3DNTDP2OP_LINELIST = 15,
    D3DNTDP2OP_LINESTRIP = 16,
    D3DNTDP2OP_INDEXEDLINESTRIP = 17,
    D3DNTDP2OP_TRIANGLELIST = 18,
    D3DNTDP2OP_TRIANGLESTRIP = 19,
    D3DNTDP2OP_INDEXEDTRIANGLESTRIP = 20,
    D3DNTDP2OP_TRIANGLEFAN = 21,
    D3DNTDP2OP_INDEXEDTRIANGLEFAN = 22,
    D3DNTDP2OP_TRIANGLEFAN_IMM = 23,
    D3DNTDP2OP_LINELIST_IMM = 24,
    D3DNTDP2OP_TEXTURESTAGESTATE = 25,
    D3DNTDP2OP_INDEXEDTRIANGLELIST2 = 26,
    D3DNTDP2OP_INDEXEDLINELIST2 = 27,
    D3DNTDP2OP_VIEWPORTINFO = 28,
    D3DNTDP2OP_WINFO = 29,
    D3DNTDP2OP_SETPALETTE = 30,
    D3DNTDP2OP_UPDATEPALETTE = 31,
    D3DNTDP2OP_ZRANGE = 32,
    D3DNTDP2OP_SETMATERIAL = 33,
    D3DNTDP2OP_SETLIGHT = 34,
    D3DNTDP2OP_CREATELIGHT = 35,
    D3DNTDP2OP_SETTRANSFORM = 36,
    D3DNTDP2OP_TEXBLT = 38,
    D3DNTDP2OP_STATESET = 39,
    D3DNTDP2OP_SETPRIORITY = 40,
    D3DNTDP2OP_SETRENDERTARGET = 41,
    D3DNTDP2OP_CLEAR = 42,
    D3DNTDP2OP_SETTEXLOD = 43,
    D3DNTDP2OP_SETCLIPPLANE = 44,
}

struct D3DNTHAL_DP2POINTS
{
    ushort wCount;
    ushort wVStart;
}

struct D3DNTHAL_DP2STARTVERTEX
{
    ushort wVStart;
}

struct D3DNTHAL_DP2LINELIST
{
    ushort wVStart;
}

struct D3DNTHAL_DP2INDEXEDLINELIST
{
    ushort wV1;
    ushort wV2;
}

struct D3DNTHAL_DP2LINESTRIP
{
    ushort wVStart;
}

struct D3DNTHAL_DP2INDEXEDLINESTRIP
{
    ushort wV;
}

struct D3DNTHAL_DP2TRIANGLELIST
{
    ushort wVStart;
}

struct D3DNTHAL_DP2INDEXEDTRIANGLELIST
{
    ushort wV1;
    ushort wV2;
    ushort wV3;
    ushort wFlags;
}

struct D3DNTHAL_DP2INDEXEDTRIANGLELIST2
{
    ushort wV1;
    ushort wV2;
    ushort wV3;
}

struct D3DNTHAL_DP2TRIANGLESTRIP
{
    ushort wVStart;
}

struct D3DNTHAL_DP2INDEXEDTRIANGLESTRIP
{
    ushort wV;
}

struct D3DNTHAL_DP2TRIANGLEFAN
{
    ushort wVStart;
}

struct D3DNTHAL_DP2INDEXEDTRIANGLEFAN
{
    ushort wV;
}

struct D3DNTHAL_DP2TRIANGLEFAN_IMM
{
    uint dwEdgeFlags;
}

struct D3DNTHAL_DP2RENDERSTATE
{
    D3DRENDERSTATETYPE RenderState;
    _Anonymous_e__Union Anonymous;
}

struct D3DNTHAL_DP2TEXTURESTAGESTATE
{
    ushort wStage;
    ushort TSState;
    uint dwValue;
}

struct D3DNTHAL_DP2VIEWPORTINFO
{
    uint dwX;
    uint dwY;
    uint dwWidth;
    uint dwHeight;
}

struct D3DNTHAL_DP2WINFO
{
    float dvWNear;
    float dvWFar;
}

struct D3DNTHAL_DP2SETPALETTE
{
    uint dwPaletteHandle;
    uint dwPaletteFlags;
    uint dwSurfaceHandle;
}

struct D3DNTHAL_DP2UPDATEPALETTE
{
    uint dwPaletteHandle;
    ushort wStartIndex;
    ushort wNumEntries;
}

struct D3DNTHAL_DP2SETRENDERTARGET
{
    uint hRenderTarget;
    uint hZBuffer;
}

struct D3DNTHAL_DP2STATESET
{
    uint dwOperation;
    uint dwParam;
    D3DSTATEBLOCKTYPE sbType;
}

struct D3DNTHAL_DP2ZRANGE
{
    float dvMinZ;
    float dvMaxZ;
}

struct D3DNTHAL_DP2SETLIGHT
{
    uint dwIndex;
    _Anonymous_e__Union Anonymous;
}

struct D3DNTHAL_DP2SETCLIPPLANE
{
    uint dwIndex;
    float plane;
}

struct D3DNTHAL_DP2CREATELIGHT
{
    uint dwIndex;
}

struct D3DNTHAL_DP2SETTRANSFORM
{
    D3DTRANSFORMSTATETYPE xfrmType;
    D3DMATRIX matrix;
}

struct D3DNTHAL_DP2EXT
{
    uint dwExtToken;
    uint dwSize;
}

struct D3DNTHAL_DP2TEXBLT
{
    uint dwDDDestSurface;
    uint dwDDSrcSurface;
    POINT pDest;
    RECTL rSrc;
    uint dwFlags;
}

struct D3DNTHAL_DP2SETPRIORITY
{
    uint dwDDDestSurface;
    uint dwPriority;
}

struct D3DNTHAL_DP2CLEAR
{
    uint dwFlags;
    uint dwFillColor;
    float dvFillDepth;
    uint dwFillStencil;
    RECT Rects;
}

struct D3DNTHAL_DP2SETTEXLOD
{
    uint dwDDSurface;
    uint dwLOD;
}

struct D3DNTHAL_DRAWPRIMITIVES2DATA
{
    uint dwhContext;
    uint dwFlags;
    uint dwVertexType;
    DD_SURFACE_LOCAL* lpDDCommands;
    uint dwCommandOffset;
    uint dwCommandLength;
    _Anonymous1_e__Union Anonymous1;
    uint dwVertexOffset;
    uint dwVertexLength;
    uint dwReqVertexBufSize;
    uint dwReqCommandBufSize;
    uint* lpdwRStates;
    _Anonymous2_e__Union Anonymous2;
    uint dwErrorOffset;
}

alias LPD3DNTHAL_CLEAR2CB = extern(Windows) uint function(D3DNTHAL_CLEAR2DATA* param0);
alias LPD3DNTHAL_VALIDATETEXTURESTAGESTATECB = extern(Windows) uint function(D3DNTHAL_VALIDATETEXTURESTAGESTATEDATA* param0);
alias LPD3DNTHAL_DRAWPRIMITIVES2CB = extern(Windows) uint function(D3DNTHAL_DRAWPRIMITIVES2DATA* param0);
struct D3DNTHAL_CALLBACKS3
{
    uint dwSize;
    uint dwFlags;
    LPD3DNTHAL_CLEAR2CB Clear2;
    void* lpvReserved;
    LPD3DNTHAL_VALIDATETEXTURESTAGESTATECB ValidateTextureStageState;
    LPD3DNTHAL_DRAWPRIMITIVES2CB DrawPrimitives2;
}

alias PFND3DNTPARSEUNKNOWNCOMMAND = extern(Windows) HRESULT function(void* lpvCommands, void** lplpvReturnedCommand);
struct POINTE
{
    uint x;
    uint y;
}

struct FLOAT_LONG
{
    uint e;
    int l;
}

struct POINTFIX
{
    int x;
    int y;
}

struct RECTFX
{
    int xLeft;
    int yTop;
    int xRight;
    int yBottom;
}

struct HBM__
{
    int unused;
}

struct HDEV__
{
    int unused;
}

struct HSURF__
{
    int unused;
}

struct DHSURF__
{
    int unused;
}

struct DHPDEV__
{
    int unused;
}

struct HDRVOBJ__
{
    int unused;
}

struct LIGATURE
{
    uint culSize;
    const(wchar)* pwsz;
    uint chglyph;
    uint ahglyph;
}

struct FD_LIGATURE
{
    uint culThis;
    uint ulType;
    uint cLigatures;
    LIGATURE alig;
}

struct POINTQF
{
    LARGE_INTEGER x;
    LARGE_INTEGER y;
}

alias PFN = extern(Windows) int function();
struct CDDDXGK_REDIRBITMAPPRESENTINFO
{
    uint NumDirtyRects;
    RECT* DirtyRect;
    uint NumContexts;
    int hContext;
    ubyte bDoNotSynchronizeWithDxContent;
}

alias FREEOBJPROC = extern(Windows) BOOL function(DRIVEROBJ* pDriverObj);
struct XFORMOBJ
{
    uint ulReserved;
}

alias WNDOBJCHANGEPROC = extern(Windows) void function(WNDOBJ* pwo, uint fl);
struct HSEMAPHORE__
{
    int unused;
}

struct HFASTMUTEX__
{
    int unused;
}

alias SORTCOMP = extern(Windows) int function(const(void)* pv1, const(void)* pv2);
enum ENG_SYSTEM_ATTRIBUTE
{
    EngProcessorFeature = 1,
    EngNumberOfProcessors = 2,
    EngOptimumAvailableUserMemory = 3,
    EngOptimumAvailableSystemMemory = 4,
}

enum ENG_DEVICE_ATTRIBUTE
{
    QDA_RESERVED = 0,
    QDA_ACCELERATION_LEVEL = 1,
}

struct EMFINFO
{
    uint nSize;
    HDC hdc;
    ubyte* pvEMF;
    ubyte* pvCurrentRecord;
}

alias PFN_DrvEnableDriver = extern(Windows) BOOL function(uint param0, uint param1, DRVENABLEDATA* param2);
alias PFN_DrvEnablePDEV = extern(Windows) DHPDEV__* function(DEVMODEW* param0, const(wchar)* param1, uint param2, HSURF__** param3, uint param4, GDIINFO* param5, uint param6, DEVINFO* param7, HDEV__* param8, const(wchar)* param9, HANDLE param10);
alias PFN_DrvCompletePDEV = extern(Windows) void function(DHPDEV__* param0, HDEV__* param1);
alias PFN_DrvResetDevice = extern(Windows) uint function(DHPDEV__* param0, void* param1);
alias PFN_DrvDisablePDEV = extern(Windows) void function(DHPDEV__* param0);
alias PFN_DrvSynchronize = extern(Windows) void function(DHPDEV__* param0, RECTL* param1);
alias PFN_DrvEnableSurface = extern(Windows) HSURF__* function(DHPDEV__* param0);
alias PFN_DrvDisableDriver = extern(Windows) void function();
alias PFN_DrvDisableSurface = extern(Windows) void function(DHPDEV__* param0);
alias PFN_DrvAssertMode = extern(Windows) BOOL function(DHPDEV__* param0, BOOL param1);
alias PFN_DrvTextOut = extern(Windows) BOOL function(SURFOBJ* param0, STROBJ* param1, FONTOBJ* param2, CLIPOBJ* param3, RECTL* param4, RECTL* param5, BRUSHOBJ* param6, BRUSHOBJ* param7, POINTL* param8, uint param9);
alias PFN_DrvStretchBlt = extern(Windows) BOOL function(SURFOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, CLIPOBJ* param3, XLATEOBJ* param4, COLORADJUSTMENT* param5, POINTL* param6, RECTL* param7, RECTL* param8, POINTL* param9, uint param10);
alias PFN_DrvStretchBltROP = extern(Windows) BOOL function(SURFOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, CLIPOBJ* param3, XLATEOBJ* param4, COLORADJUSTMENT* param5, POINTL* param6, RECTL* param7, RECTL* param8, POINTL* param9, uint param10, BRUSHOBJ* param11, uint param12);
alias PFN_DrvTransparentBlt = extern(Windows) BOOL function(SURFOBJ* param0, SURFOBJ* param1, CLIPOBJ* param2, XLATEOBJ* param3, RECTL* param4, RECTL* param5, uint param6, uint param7);
alias PFN_DrvPlgBlt = extern(Windows) BOOL function(SURFOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, CLIPOBJ* param3, XLATEOBJ* param4, COLORADJUSTMENT* param5, POINTL* param6, POINTFIX* param7, RECTL* param8, POINTL* param9, uint param10);
alias PFN_DrvBitBlt = extern(Windows) BOOL function(SURFOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, CLIPOBJ* param3, XLATEOBJ* param4, RECTL* param5, POINTL* param6, POINTL* param7, BRUSHOBJ* param8, POINTL* param9, uint param10);
alias PFN_DrvRealizeBrush = extern(Windows) BOOL function(BRUSHOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, SURFOBJ* param3, XLATEOBJ* param4, uint param5);
alias PFN_DrvCopyBits = extern(Windows) BOOL function(SURFOBJ* param0, SURFOBJ* param1, CLIPOBJ* param2, XLATEOBJ* param3, RECTL* param4, POINTL* param5);
alias PFN_DrvDitherColor = extern(Windows) uint function(DHPDEV__* param0, uint param1, uint param2, uint* param3);
alias PFN_DrvCreateDeviceBitmap = extern(Windows) HBITMAP function(DHPDEV__* param0, SIZE param1, uint param2);
alias PFN_DrvDeleteDeviceBitmap = extern(Windows) void function(DHSURF__* param0);
alias PFN_DrvSetPalette = extern(Windows) BOOL function(DHPDEV__* param0, PALOBJ* param1, uint param2, uint param3, uint param4);
alias PFN_DrvEscape = extern(Windows) uint function(SURFOBJ* param0, uint param1, uint param2, void* param3, uint param4, void* param5);
alias PFN_DrvDrawEscape = extern(Windows) uint function(SURFOBJ* param0, uint param1, CLIPOBJ* param2, RECTL* param3, uint param4, void* param5);
alias PFN_DrvQueryFont = extern(Windows) IFIMETRICS* function(DHPDEV__* param0, uint param1, uint param2, uint* param3);
alias PFN_DrvQueryFontTree = extern(Windows) void* function(DHPDEV__* param0, uint param1, uint param2, uint param3, uint* param4);
alias PFN_DrvQueryFontData = extern(Windows) int function(DHPDEV__* param0, FONTOBJ* param1, uint param2, uint param3, GLYPHDATA* param4, void* param5, uint param6);
alias PFN_DrvFree = extern(Windows) void function(void* param0, uint param1);
alias PFN_DrvDestroyFont = extern(Windows) void function(FONTOBJ* param0);
alias PFN_DrvQueryFontCaps = extern(Windows) int function(uint param0, uint* param1);
alias PFN_DrvLoadFontFile = extern(Windows) uint function(uint param0, uint* param1, void** param2, uint* param3, DESIGNVECTOR* param4, uint param5, uint param6);
alias PFN_DrvUnloadFontFile = extern(Windows) BOOL function(uint param0);
alias PFN_DrvSetPointerShape = extern(Windows) uint function(SURFOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, XLATEOBJ* param3, int param4, int param5, int param6, int param7, RECTL* param8, uint param9);
alias PFN_DrvMovePointer = extern(Windows) void function(SURFOBJ* pso, int x, int y, RECTL* prcl);
alias PFN_DrvSendPage = extern(Windows) BOOL function(SURFOBJ* param0);
alias PFN_DrvStartPage = extern(Windows) BOOL function(SURFOBJ* pso);
alias PFN_DrvStartDoc = extern(Windows) BOOL function(SURFOBJ* pso, const(wchar)* pwszDocName, uint dwJobId);
alias PFN_DrvEndDoc = extern(Windows) BOOL function(SURFOBJ* pso, uint fl);
alias PFN_DrvQuerySpoolType = extern(Windows) BOOL function(DHPDEV__* dhpdev, const(wchar)* pwchType);
alias PFN_DrvLineTo = extern(Windows) BOOL function(SURFOBJ* param0, CLIPOBJ* param1, BRUSHOBJ* param2, int param3, int param4, int param5, int param6, RECTL* param7, uint param8);
alias PFN_DrvStrokePath = extern(Windows) BOOL function(SURFOBJ* param0, PATHOBJ* param1, CLIPOBJ* param2, XFORMOBJ* param3, BRUSHOBJ* param4, POINTL* param5, LINEATTRS* param6, uint param7);
alias PFN_DrvFillPath = extern(Windows) BOOL function(SURFOBJ* param0, PATHOBJ* param1, CLIPOBJ* param2, BRUSHOBJ* param3, POINTL* param4, uint param5, uint param6);
alias PFN_DrvStrokeAndFillPath = extern(Windows) BOOL function(SURFOBJ* param0, PATHOBJ* param1, CLIPOBJ* param2, XFORMOBJ* param3, BRUSHOBJ* param4, LINEATTRS* param5, BRUSHOBJ* param6, POINTL* param7, uint param8, uint param9);
alias PFN_DrvPaint = extern(Windows) BOOL function(SURFOBJ* param0, CLIPOBJ* param1, BRUSHOBJ* param2, POINTL* param3, uint param4);
alias PFN_DrvGetGlyphMode = extern(Windows) uint function(DHPDEV__* dhpdev, FONTOBJ* pfo);
alias PFN_DrvResetPDEV = extern(Windows) BOOL function(DHPDEV__* dhpdevOld, DHPDEV__* dhpdevNew);
alias PFN_DrvSaveScreenBits = extern(Windows) uint function(SURFOBJ* param0, uint param1, uint param2, RECTL* param3);
alias PFN_DrvGetModes = extern(Windows) uint function(HANDLE param0, uint param1, DEVMODEW* param2);
alias PFN_DrvQueryTrueTypeTable = extern(Windows) int function(uint param0, uint param1, uint param2, int param3, uint param4, ubyte* param5, ubyte** param6, uint* param7);
alias PFN_DrvQueryTrueTypeSection = extern(Windows) int function(uint param0, uint param1, uint param2, HANDLE* param3, int* param4);
alias PFN_DrvQueryTrueTypeOutline = extern(Windows) int function(DHPDEV__* param0, FONTOBJ* param1, uint param2, BOOL param3, GLYPHDATA* param4, uint param5, TTPOLYGONHEADER* param6);
alias PFN_DrvGetTrueTypeFile = extern(Windows) void* function(uint param0, uint* param1);
alias PFN_DrvQueryFontFile = extern(Windows) int function(uint param0, uint param1, uint param2, uint* param3);
alias PFN_DrvQueryAdvanceWidths = extern(Windows) BOOL function(DHPDEV__* param0, FONTOBJ* param1, uint param2, uint* param3, void* param4, uint param5);
alias PFN_DrvFontManagement = extern(Windows) uint function(SURFOBJ* param0, FONTOBJ* param1, uint param2, uint param3, void* param4, uint param5, void* param6);
alias PFN_DrvSetPixelFormat = extern(Windows) BOOL function(SURFOBJ* param0, int param1, HWND param2);
alias PFN_DrvDescribePixelFormat = extern(Windows) int function(DHPDEV__* param0, int param1, uint param2, PIXELFORMATDESCRIPTOR* param3);
alias PFN_DrvSwapBuffers = extern(Windows) BOOL function(SURFOBJ* param0, WNDOBJ* param1);
alias PFN_DrvStartBanding = extern(Windows) BOOL function(SURFOBJ* param0, POINTL* ppointl);
alias PFN_DrvNextBand = extern(Windows) BOOL function(SURFOBJ* param0, POINTL* ppointl);
alias PFN_DrvQueryPerBandInfo = extern(Windows) BOOL function(SURFOBJ* param0, PERBANDINFO* param1);
alias PFN_DrvEnableDirectDraw = extern(Windows) BOOL function(DHPDEV__* param0, DD_CALLBACKS* param1, DD_SURFACECALLBACKS* param2, DD_PALETTECALLBACKS* param3);
alias PFN_DrvDisableDirectDraw = extern(Windows) void function(DHPDEV__* param0);
alias PFN_DrvGetDirectDrawInfo = extern(Windows) BOOL function(DHPDEV__* param0, DD_HALINFO* param1, uint* param2, VIDEOMEMORY* param3, uint* param4, uint* param5);
alias PFN_DrvIcmCreateColorTransform = extern(Windows) HANDLE function(DHPDEV__* param0, LOGCOLORSPACEW* param1, void* param2, uint param3, void* param4, uint param5, void* param6, uint param7, uint param8);
alias PFN_DrvIcmDeleteColorTransform = extern(Windows) BOOL function(DHPDEV__* param0, HANDLE param1);
alias PFN_DrvIcmCheckBitmapBits = extern(Windows) BOOL function(DHPDEV__* param0, HANDLE param1, SURFOBJ* param2, ubyte* param3);
alias PFN_DrvIcmSetDeviceGammaRamp = extern(Windows) BOOL function(DHPDEV__* param0, uint param1, void* param2);
alias PFN_DrvAlphaBlend = extern(Windows) BOOL function(SURFOBJ* param0, SURFOBJ* param1, CLIPOBJ* param2, XLATEOBJ* param3, RECTL* param4, RECTL* param5, BLENDOBJ* param6);
alias PFN_DrvGradientFill = extern(Windows) BOOL function(SURFOBJ* param0, CLIPOBJ* param1, XLATEOBJ* param2, TRIVERTEX* param3, uint param4, void* param5, uint param6, RECTL* param7, POINTL* param8, uint param9);
alias PFN_DrvQueryDeviceSupport = extern(Windows) BOOL function(SURFOBJ* param0, XLATEOBJ* param1, XFORMOBJ* param2, uint param3, uint param4, void* param5, uint param6, void* param7);
alias PFN_DrvDeriveSurface = extern(Windows) HBITMAP function(DD_DIRECTDRAW_GLOBAL* param0, DD_SURFACE_LOCAL* param1);
alias PFN_DrvSynchronizeSurface = extern(Windows) void function(SURFOBJ* param0, RECTL* param1, uint param2);
alias PFN_DrvNotify = extern(Windows) void function(SURFOBJ* param0, uint param1, void* param2);
alias PFN_DrvRenderHint = extern(Windows) int function(DHPDEV__* dhpdev, uint NotifyCode, uint Length, char* Data);
struct DRH_APIBITMAPDATA
{
    SURFOBJ* pso;
    BOOL b;
}

alias PFN_EngCreateRectRgn = extern(Windows) HANDLE function(int left, int top, int right, int bottom);
alias PFN_EngDeleteRgn = extern(Windows) void function(HANDLE hrgn);
alias PFN_EngCombineRgn = extern(Windows) int function(HANDLE hrgnTrg, HANDLE hrgnSrc1, HANDLE hrgnSrc2, int imode);
alias PFN_EngCopyRgn = extern(Windows) int function(HANDLE hrgnDst, HANDLE hrgnSrc);
alias PFN_EngIntersectRgn = extern(Windows) int function(HANDLE hrgnResult, HANDLE hRgnA, HANDLE hRgnB);
alias PFN_EngSubtractRgn = extern(Windows) int function(HANDLE hrgnResult, HANDLE hRgnA, HANDLE hRgnB);
alias PFN_EngUnionRgn = extern(Windows) int function(HANDLE hrgnResult, HANDLE hRgnA, HANDLE hRgnB);
alias PFN_EngXorRgn = extern(Windows) int function(HANDLE hrgnResult, HANDLE hRgnA, HANDLE hRgnB);
alias PFN_DrvCreateDeviceBitmapEx = extern(Windows) HBITMAP function(DHPDEV__* param0, SIZE param1, uint param2, uint param3, DHSURF__* param4, uint param5, uint param6, HANDLE* param7);
alias PFN_DrvDeleteDeviceBitmapEx = extern(Windows) void function(DHSURF__* param0);
alias PFN_DrvAssociateSharedSurface = extern(Windows) BOOL function(SURFOBJ* param0, HANDLE param1, HANDLE param2, SIZE param3);
alias PFN_DrvSynchronizeRedirectionBitmaps = extern(Windows) NTSTATUS function(DHPDEV__* param0, ulong* param1);
alias PFN_DrvAccumulateD3DDirtyRect = extern(Windows) BOOL function(SURFOBJ* param0, CDDDXGK_REDIRBITMAPPRESENTINFO* param1);
alias PFN_DrvStartDxInterop = extern(Windows) BOOL function(SURFOBJ* param0, BOOL param1, void* KernelModeDeviceHandle);
alias PFN_DrvEndDxInterop = extern(Windows) BOOL function(SURFOBJ* param0, BOOL param1, int* param2, void* KernelModeDeviceHandle);
alias PFN_DrvLockDisplayArea = extern(Windows) void function(DHPDEV__* param0, RECTL* param1);
alias PFN_DrvUnlockDisplayArea = extern(Windows) void function(DHPDEV__* param0, RECTL* param1);
alias PFN_DrvSurfaceComplete = extern(Windows) BOOL function(DHPDEV__* param0, HANDLE param1);
struct DEVICE_EVENT_MOUNT
{
    uint Version;
    uint Flags;
    uint FileSystemNameLength;
    uint FileSystemNameOffset;
}

struct DEVICE_EVENT_BECOMING_READY
{
    uint Version;
    uint Reason;
    uint Estimated100msToReady;
}

struct DEVICE_EVENT_EXTERNAL_REQUEST
{
    uint Version;
    uint DeviceClass;
    ushort ButtonStatus;
    ushort Request;
    LARGE_INTEGER SystemTime;
}

struct DEVICE_EVENT_GENERIC_DATA
{
    uint EventNumber;
}

struct DEVICE_EVENT_RBC_DATA
{
    uint EventNumber;
    ubyte SenseQualifier;
    ubyte SenseCode;
    ubyte SenseKey;
    ubyte Reserved;
    uint Information;
}

struct GUID_IO_DISK_CLONE_ARRIVAL_INFORMATION
{
    uint DiskNumber;
}

struct DISK_HEALTH_NOTIFICATION_DATA
{
    Guid DeviceGuid;
}

struct DEVPROPKEY
{
    Guid fmtid;
    uint pid;
}

enum DEVPROPSTORE
{
    DEVPROP_STORE_SYSTEM = 0,
    DEVPROP_STORE_USER = 1,
}

struct DEVPROPCOMPKEY
{
    DEVPROPKEY Key;
    DEVPROPSTORE Store;
    const(wchar)* LocaleName;
}

struct DEVPROPERTY
{
    DEVPROPCOMPKEY CompKey;
    uint Type;
    uint BufferSize;
    void* Buffer;
}

struct REDBOOK_DIGITAL_AUDIO_EXTRACTION_INFO
{
    uint Version;
    uint Accurate;
    uint Supported;
    uint AccurateMask0;
}

struct DEV_BROADCAST_HDR
{
    uint dbch_size;
    uint dbch_devicetype;
    uint dbch_reserved;
}

struct VolLockBroadcast
{
    DEV_BROADCAST_HDR vlb_dbh;
    uint vlb_owner;
    ubyte vlb_perms;
    ubyte vlb_lockType;
    ubyte vlb_drive;
    ubyte vlb_flags;
}

struct _DEV_BROADCAST_HEADER
{
    uint dbcd_size;
    uint dbcd_devicetype;
    uint dbcd_reserved;
}

struct DEV_BROADCAST_OEM
{
    uint dbco_size;
    uint dbco_devicetype;
    uint dbco_reserved;
    uint dbco_identifier;
    uint dbco_suppfunc;
}

struct DEV_BROADCAST_DEVNODE
{
    uint dbcd_size;
    uint dbcd_devicetype;
    uint dbcd_reserved;
    uint dbcd_devnode;
}

struct DEV_BROADCAST_VOLUME
{
    uint dbcv_size;
    uint dbcv_devicetype;
    uint dbcv_reserved;
    uint dbcv_unitmask;
    ushort dbcv_flags;
}

struct DEV_BROADCAST_PORT_A
{
    uint dbcp_size;
    uint dbcp_devicetype;
    uint dbcp_reserved;
    byte dbcp_name;
}

struct DEV_BROADCAST_PORT_W
{
    uint dbcp_size;
    uint dbcp_devicetype;
    uint dbcp_reserved;
    ushort dbcp_name;
}

struct DEV_BROADCAST_NET
{
    uint dbcn_size;
    uint dbcn_devicetype;
    uint dbcn_reserved;
    uint dbcn_resource;
    uint dbcn_flags;
}

struct DEV_BROADCAST_DEVICEINTERFACE_A
{
    uint dbcc_size;
    uint dbcc_devicetype;
    uint dbcc_reserved;
    Guid dbcc_classguid;
    byte dbcc_name;
}

struct DEV_BROADCAST_DEVICEINTERFACE_W
{
    uint dbcc_size;
    uint dbcc_devicetype;
    uint dbcc_reserved;
    Guid dbcc_classguid;
    ushort dbcc_name;
}

struct DEV_BROADCAST_HANDLE
{
    uint dbch_size;
    uint dbch_devicetype;
    uint dbch_reserved;
    HANDLE dbch_handle;
    void* dbch_hdevnotify;
    Guid dbch_eventguid;
    int dbch_nameoffset;
    ubyte dbch_data;
}

struct DEV_BROADCAST_HANDLE32
{
    uint dbch_size;
    uint dbch_devicetype;
    uint dbch_reserved;
    uint dbch_handle;
    uint dbch_hdevnotify;
    Guid dbch_eventguid;
    int dbch_nameoffset;
    ubyte dbch_data;
}

struct DEV_BROADCAST_HANDLE64
{
    uint dbch_size;
    uint dbch_devicetype;
    uint dbch_reserved;
    ulong dbch_handle;
    ulong dbch_hdevnotify;
    Guid dbch_eventguid;
    int dbch_nameoffset;
    ubyte dbch_data;
}

struct _DEV_BROADCAST_USERDEFINED
{
    DEV_BROADCAST_HDR dbud_dbh;
    byte dbud_szName;
}

struct PWM_CONTROLLER_INFO
{
    uint Size;
    uint PinCount;
    ulong MinimumPeriod;
    ulong MaximumPeriod;
}

struct PWM_CONTROLLER_GET_ACTUAL_PERIOD_OUTPUT
{
    ulong ActualPeriod;
}

struct PWM_CONTROLLER_SET_DESIRED_PERIOD_INPUT
{
    ulong DesiredPeriod;
}

struct PWM_CONTROLLER_SET_DESIRED_PERIOD_OUTPUT
{
    ulong ActualPeriod;
}

struct PWM_PIN_GET_ACTIVE_DUTY_CYCLE_PERCENTAGE_OUTPUT
{
    ulong Percentage;
}

struct PWM_PIN_SET_ACTIVE_DUTY_CYCLE_PERCENTAGE_INPUT
{
    ulong Percentage;
}

enum PWM_POLARITY
{
    PWM_ACTIVE_HIGH = 0,
    PWM_ACTIVE_LOW = 1,
}

struct PWM_PIN_GET_POLARITY_OUTPUT
{
    PWM_POLARITY Polarity;
}

struct PWM_PIN_SET_POLARITY_INPUT
{
    PWM_POLARITY Polarity;
}

struct PWM_PIN_IS_STARTED_OUTPUT
{
    ubyte IsStarted;
}

struct AtlThunkData_t
{
}

enum ENCLAVE_SEALING_IDENTITY_POLICY
{
    ENCLAVE_IDENTITY_POLICY_SEAL_INVALID = 0,
    ENCLAVE_IDENTITY_POLICY_SEAL_EXACT_CODE = 1,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_PRIMARY_CODE = 2,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_IMAGE = 3,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_FAMILY = 4,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_AUTHOR = 5,
}

struct ENCLAVE_IDENTITY
{
    ubyte OwnerId;
    ubyte UniqueId;
    ubyte AuthorId;
    ubyte FamilyId;
    ubyte ImageId;
    uint EnclaveSvn;
    uint SecureKernelSvn;
    uint PlatformSvn;
    uint Flags;
    uint SigningLevel;
    uint EnclaveType;
}

struct VBS_ENCLAVE_REPORT_PKG_HEADER
{
    uint PackageSize;
    uint Version;
    uint SignatureScheme;
    uint SignedStatementSize;
    uint SignatureSize;
    uint Reserved;
}

struct VBS_ENCLAVE_REPORT
{
    uint ReportSize;
    uint ReportVersion;
    ubyte EnclaveData;
    ENCLAVE_IDENTITY EnclaveIdentity;
}

struct VBS_ENCLAVE_REPORT_VARDATA_HEADER
{
    uint DataType;
    uint Size;
}

struct VBS_ENCLAVE_REPORT_MODULE
{
    VBS_ENCLAVE_REPORT_VARDATA_HEADER Header;
    ubyte UniqueId;
    ubyte AuthorId;
    ubyte FamilyId;
    ubyte ImageId;
    uint Svn;
    ushort ModuleName;
}

struct ENCLAVE_INFORMATION
{
    uint EnclaveType;
    uint Reserved;
    void* BaseAddress;
    uint Size;
    ENCLAVE_IDENTITY Identity;
}

struct VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32
{
    uint ThreadContext;
    uint EntryPoint;
    uint StackPointer;
    uint ExceptionEntryPoint;
    uint ExceptionStack;
    uint ExceptionActive;
}

struct VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64
{
    ulong ThreadContext;
    ulong EntryPoint;
    ulong StackPointer;
    ulong ExceptionEntryPoint;
    ulong ExceptionStack;
    uint ExceptionActive;
}

struct VBS_BASIC_ENCLAVE_EXCEPTION_AMD64
{
    uint ExceptionCode;
    uint NumberParameters;
    uint ExceptionInformation;
    uint ExceptionRAX;
    uint ExceptionRCX;
    uint ExceptionRIP;
    uint ExceptionRFLAGS;
    uint ExceptionRSP;
}

alias VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_ENCLAVE = extern(Windows) void function(uint ReturnValue);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_EXCEPTION = extern(Windows) int function(void* ExceptionRecord);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_TERMINATE_THREAD = extern(Windows) int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32* ThreadDescriptor);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_INTERRUPT_THREAD = extern(Windows) int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32* ThreadDescriptor);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_COMMIT_PAGES = extern(Windows) int function(void* EnclaveAddress, uint NumberOfBytes, void* SourceAddress, uint PageProtection);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_DECOMMIT_PAGES = extern(Windows) int function(void* EnclaveAddress, uint NumberOfBytes);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_PROTECT_PAGES = extern(Windows) int function(void* EnclaveAddress, uint NumberOfytes, uint PageProtection);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_CREATE_THREAD = extern(Windows) int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32* ThreadDescriptor);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GET_ENCLAVE_INFORMATION = extern(Windows) int function(ENCLAVE_INFORMATION* EnclaveInfo);
struct ENCLAVE_VBS_BASIC_KEY_REQUEST
{
    uint RequestSize;
    uint Flags;
    uint EnclaveSVN;
    uint SystemKeyID;
    uint CurrentSystemKeyID;
}

alias VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_KEY = extern(Windows) int function(ENCLAVE_VBS_BASIC_KEY_REQUEST* KeyRequest, uint RequestedKeySize, char* ReturnedKey);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_REPORT = extern(Windows) int function(const(ubyte)* EnclaveData, char* Report, uint BufferSize, uint* OutputSize);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_VERIFY_REPORT = extern(Windows) int function(char* Report, uint ReportSize);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_RANDOM_DATA = extern(Windows) int function(char* Buffer, uint NumberOfBytes, ulong* Generation);
struct VBS_BASIC_ENCLAVE_SYSCALL_PAGE
{
    VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_ENCLAVE* ReturnFromEnclave;
    VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_EXCEPTION* ReturnFromException;
    VBS_BASIC_ENCLAVE_BASIC_CALL_TERMINATE_THREAD* TerminateThread;
    VBS_BASIC_ENCLAVE_BASIC_CALL_INTERRUPT_THREAD* InterruptThread;
    VBS_BASIC_ENCLAVE_BASIC_CALL_COMMIT_PAGES* CommitPages;
    VBS_BASIC_ENCLAVE_BASIC_CALL_DECOMMIT_PAGES* DecommitPages;
    VBS_BASIC_ENCLAVE_BASIC_CALL_PROTECT_PAGES* ProtectPages;
    VBS_BASIC_ENCLAVE_BASIC_CALL_CREATE_THREAD* CreateThread;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GET_ENCLAVE_INFORMATION* GetEnclaveInformation;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_KEY* GenerateKey;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_REPORT* GenerateReport;
    VBS_BASIC_ENCLAVE_BASIC_CALL_VERIFY_REPORT* VerifyReport;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_RANDOM_DATA* GenerateRandomData;
}

enum EFFECTIVE_POWER_MODE
{
    EffectivePowerModeBatterySaver = 0,
    EffectivePowerModeBetterBattery = 1,
    EffectivePowerModeBalanced = 2,
    EffectivePowerModeHighPerformance = 3,
    EffectivePowerModeMaxPerformance = 4,
    EffectivePowerModeGameMode = 5,
    EffectivePowerModeMixedReality = 6,
}

alias EFFECTIVE_POWER_MODE_CALLBACK = extern(Windows) void function(EFFECTIVE_POWER_MODE Mode, void* Context);
struct GLOBAL_MACHINE_POWER_POLICY
{
    uint Revision;
    SYSTEM_POWER_STATE LidOpenWakeAc;
    SYSTEM_POWER_STATE LidOpenWakeDc;
    uint BroadcastCapacityResolution;
}

struct GLOBAL_USER_POWER_POLICY
{
    uint Revision;
    POWER_ACTION_POLICY PowerButtonAc;
    POWER_ACTION_POLICY PowerButtonDc;
    POWER_ACTION_POLICY SleepButtonAc;
    POWER_ACTION_POLICY SleepButtonDc;
    POWER_ACTION_POLICY LidCloseAc;
    POWER_ACTION_POLICY LidCloseDc;
    SYSTEM_POWER_LEVEL DischargePolicy;
    uint GlobalFlags;
}

struct GLOBAL_POWER_POLICY
{
    GLOBAL_USER_POWER_POLICY user;
    GLOBAL_MACHINE_POWER_POLICY mach;
}

struct MACHINE_POWER_POLICY
{
    uint Revision;
    SYSTEM_POWER_STATE MinSleepAc;
    SYSTEM_POWER_STATE MinSleepDc;
    SYSTEM_POWER_STATE ReducedLatencySleepAc;
    SYSTEM_POWER_STATE ReducedLatencySleepDc;
    uint DozeTimeoutAc;
    uint DozeTimeoutDc;
    uint DozeS4TimeoutAc;
    uint DozeS4TimeoutDc;
    ubyte MinThrottleAc;
    ubyte MinThrottleDc;
    ubyte pad1;
    POWER_ACTION_POLICY OverThrottledAc;
    POWER_ACTION_POLICY OverThrottledDc;
}

struct MACHINE_PROCESSOR_POWER_POLICY
{
    uint Revision;
    PROCESSOR_POWER_POLICY ProcessorPolicyAc;
    PROCESSOR_POWER_POLICY ProcessorPolicyDc;
}

struct USER_POWER_POLICY
{
    uint Revision;
    POWER_ACTION_POLICY IdleAc;
    POWER_ACTION_POLICY IdleDc;
    uint IdleTimeoutAc;
    uint IdleTimeoutDc;
    ubyte IdleSensitivityAc;
    ubyte IdleSensitivityDc;
    ubyte ThrottlePolicyAc;
    ubyte ThrottlePolicyDc;
    SYSTEM_POWER_STATE MaxSleepAc;
    SYSTEM_POWER_STATE MaxSleepDc;
    uint Reserved;
    uint VideoTimeoutAc;
    uint VideoTimeoutDc;
    uint SpindownTimeoutAc;
    uint SpindownTimeoutDc;
    ubyte OptimizeForPowerAc;
    ubyte OptimizeForPowerDc;
    ubyte FanThrottleToleranceAc;
    ubyte FanThrottleToleranceDc;
    ubyte ForcedThrottleAc;
    ubyte ForcedThrottleDc;
}

struct POWER_POLICY
{
    USER_POWER_POLICY user;
    MACHINE_POWER_POLICY mach;
}

alias PWRSCHEMESENUMPROC_V1 = extern(Windows) ubyte function(uint Index, uint NameSize, char* Name, uint DescriptionSize, char* Description, POWER_POLICY* Policy, LPARAM Context);
alias PWRSCHEMESENUMPROC_V2 = extern(Windows) ubyte function(uint Index, uint NameSize, const(wchar)* Name, uint DescriptionSize, const(wchar)* Description, POWER_POLICY* Policy, LPARAM Context);
alias PWRSCHEMESENUMPROC = extern(Windows) ubyte function();
enum POWER_DATA_ACCESSOR
{
    ACCESS_AC_POWER_SETTING_INDEX = 0,
    ACCESS_DC_POWER_SETTING_INDEX = 1,
    ACCESS_FRIENDLY_NAME = 2,
    ACCESS_DESCRIPTION = 3,
    ACCESS_POSSIBLE_POWER_SETTING = 4,
    ACCESS_POSSIBLE_POWER_SETTING_FRIENDLY_NAME = 5,
    ACCESS_POSSIBLE_POWER_SETTING_DESCRIPTION = 6,
    ACCESS_DEFAULT_AC_POWER_SETTING = 7,
    ACCESS_DEFAULT_DC_POWER_SETTING = 8,
    ACCESS_POSSIBLE_VALUE_MIN = 9,
    ACCESS_POSSIBLE_VALUE_MAX = 10,
    ACCESS_POSSIBLE_VALUE_INCREMENT = 11,
    ACCESS_POSSIBLE_VALUE_UNITS = 12,
    ACCESS_ICON_RESOURCE = 13,
    ACCESS_DEFAULT_SECURITY_DESCRIPTOR = 14,
    ACCESS_ATTRIBUTES = 15,
    ACCESS_SCHEME = 16,
    ACCESS_SUBGROUP = 17,
    ACCESS_INDIVIDUAL_SETTING = 18,
    ACCESS_ACTIVE_SCHEME = 19,
    ACCESS_CREATE_SCHEME = 20,
    ACCESS_AC_POWER_SETTING_MAX = 21,
    ACCESS_DC_POWER_SETTING_MAX = 22,
    ACCESS_AC_POWER_SETTING_MIN = 23,
    ACCESS_DC_POWER_SETTING_MIN = 24,
    ACCESS_PROFILE = 25,
    ACCESS_OVERLAY_SCHEME = 26,
    ACCESS_ACTIVE_OVERLAY_SCHEME = 27,
}

alias DEVICE_NOTIFY_CALLBACK_ROUTINE = extern(Windows) uint function(void* Context, uint Type, void* Setting);
alias PDEVICE_NOTIFY_CALLBACK_ROUTINE = extern(Windows) uint function();
struct DEVICE_NOTIFY_SUBSCRIBE_PARAMETERS
{
    PDEVICE_NOTIFY_CALLBACK_ROUTINE Callback;
    void* Context;
}

struct THERMAL_EVENT
{
    uint Version;
    uint Size;
    uint Type;
    uint Temperature;
    uint TripPointTemperature;
    const(wchar)* Initiator;
}

enum BATTERY_QUERY_INFORMATION_LEVEL
{
    BatteryInformation = 0,
    BatteryGranularityInformation = 1,
    BatteryTemperature = 2,
    BatteryEstimatedTime = 3,
    BatteryDeviceName = 4,
    BatteryManufactureDate = 5,
    BatteryManufactureName = 6,
    BatteryUniqueID = 7,
    BatterySerialNumber = 8,
}

struct BATTERY_QUERY_INFORMATION
{
    uint BatteryTag;
    BATTERY_QUERY_INFORMATION_LEVEL InformationLevel;
    uint AtRate;
}

struct BATTERY_INFORMATION
{
    uint Capabilities;
    ubyte Technology;
    ubyte Reserved;
    ubyte Chemistry;
    uint DesignedCapacity;
    uint FullChargedCapacity;
    uint DefaultAlert1;
    uint DefaultAlert2;
    uint CriticalBias;
    uint CycleCount;
}

enum BATTERY_CHARGING_SOURCE_TYPE
{
    BatteryChargingSourceType_AC = 1,
    BatteryChargingSourceType_USB = 2,
    BatteryChargingSourceType_Wireless = 3,
    BatteryChargingSourceType_Max = 4,
}

struct BATTERY_CHARGING_SOURCE
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    uint MaxCurrent;
}

struct BATTERY_CHARGING_SOURCE_INFORMATION
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    ubyte SourceOnline;
}

enum USB_CHARGER_PORT
{
    UsbChargerPort_Legacy = 0,
    UsbChargerPort_TypeC = 1,
    UsbChargerPort_Max = 2,
}

enum BATTERY_SET_INFORMATION_LEVEL
{
    BatteryCriticalBias = 0,
    BatteryCharge = 1,
    BatteryDischarge = 2,
    BatteryChargingSource = 3,
    BatteryChargerId = 4,
    BatteryChargerStatus = 5,
}

struct BATTERY_SET_INFORMATION
{
    uint BatteryTag;
    BATTERY_SET_INFORMATION_LEVEL InformationLevel;
    ubyte Buffer;
}

struct BATTERY_CHARGER_STATUS
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    uint VaData;
}

struct BATTERY_USB_CHARGER_STATUS
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    uint Reserved;
    uint Flags;
    uint MaxCurrent;
    uint Voltage;
    USB_CHARGER_PORT PortType;
    ulong PortId;
    void* PowerSourceInformation;
    Guid OemCharger;
}

struct BATTERY_WAIT_STATUS
{
    uint BatteryTag;
    uint Timeout;
    uint PowerState;
    uint LowCapacity;
    uint HighCapacity;
}

struct BATTERY_STATUS
{
    uint PowerState;
    uint Capacity;
    uint Voltage;
    int Rate;
}

struct BATTERY_MANUFACTURE_DATE
{
    ubyte Day;
    ubyte Month;
    ushort Year;
}

struct THERMAL_INFORMATION
{
    uint ThermalStamp;
    uint ThermalConstant1;
    uint ThermalConstant2;
    uint Processors;
    uint SamplingPeriod;
    uint CurrentTemperature;
    uint PassiveTripPoint;
    uint CriticalTripPoint;
    ubyte ActiveTripPointCount;
    uint ActiveTripPoint;
}

struct THERMAL_WAIT_READ
{
    uint Timeout;
    uint LowTemperature;
    uint HighTemperature;
}

struct THERMAL_POLICY
{
    uint Version;
    ubyte WaitForUpdate;
    ubyte Hibernate;
    ubyte Critical;
    ubyte ThermalStandby;
    uint ActivationReasons;
    uint PassiveLimit;
    uint ActiveLevel;
    ubyte OverThrottled;
}

struct PROCESSOR_OBJECT_INFO
{
    uint PhysicalID;
    uint PBlkAddress;
    ubyte PBlkLength;
}

struct PROCESSOR_OBJECT_INFO_EX
{
    uint PhysicalID;
    uint PBlkAddress;
    ubyte PBlkLength;
    uint InitialApicId;
}

struct WAKE_ALARM_INFORMATION
{
    uint TimerIdentifier;
    uint Timeout;
}

struct ACPI_REAL_TIME
{
    ushort Year;
    ubyte Month;
    ubyte Day;
    ubyte Hour;
    ubyte Minute;
    ubyte Second;
    ubyte Valid;
    ushort Milliseconds;
    short TimeZone;
    ubyte DayLight;
    ubyte Reserved1;
}

struct INDIRECT_DISPLAY_INFO
{
    LUID DisplayAdapterLuid;
    uint Flags;
    uint NumMonitors;
    uint DisplayAdapterTargetBase;
}

struct VIDEO_VDM
{
    HANDLE ProcessHandle;
}

struct VIDEO_REGISTER_VDM
{
    uint MinimumStateSize;
}

struct VIDEO_MONITOR_DESCRIPTOR
{
    uint DescriptorSize;
    ubyte Descriptor;
}

enum VIDEO_WIN32K_CALLBACKS_PARAMS_TYPE
{
    VideoPowerNotifyCallout = 1,
    VideoEnumChildPdoNotifyCallout = 3,
    VideoFindAdapterCallout = 4,
    VideoPnpNotifyCallout = 7,
    VideoDxgkDisplaySwitchCallout = 8,
    VideoDxgkFindAdapterTdrCallout = 10,
    VideoDxgkHardwareProtectionTeardown = 11,
    VideoRepaintDesktop = 12,
    VideoUpdateCursor = 13,
    VideoDisableMultiPlaneOverlay = 14,
    VideoDesktopDuplicationChange = 15,
    VideoBlackScreenDiagnostics = 16,
}

enum BlackScreenDiagnosticsCalloutParam
{
    BlackScreenDiagnosticsData = 1,
    BlackScreenDisplayRecovery = 2,
}

struct DXGK_WIN32K_PARAM_DATA
{
    void* PathsArray;
    void* ModesArray;
    uint NumPathArrayElements;
    uint NumModeArrayElements;
    uint SDCFlags;
}

struct VIDEO_WIN32K_CALLBACKS_PARAMS
{
    VIDEO_WIN32K_CALLBACKS_PARAMS_TYPE CalloutType;
    void* PhysDisp;
    uint Param;
    int Status;
    ubyte LockUserSession;
    ubyte IsPostDevice;
    ubyte SurpriseRemoval;
    ubyte WaitForQueueReady;
}

alias PVIDEO_WIN32K_CALLOUT = extern(Windows) void function(void* Params);
struct VIDEO_WIN32K_CALLBACKS
{
    void* PhysDisp;
    PVIDEO_WIN32K_CALLOUT Callout;
    uint bACPI;
    HANDLE pPhysDeviceObject;
    uint DualviewFlags;
}

struct VIDEO_DEVICE_SESSION_STATUS
{
    uint bEnable;
    uint bSuccess;
}

struct VIDEO_HARDWARE_STATE_HEADER
{
    uint Length;
    ubyte PortValue;
    uint AttribIndexDataState;
    uint BasicSequencerOffset;
    uint BasicCrtContOffset;
    uint BasicGraphContOffset;
    uint BasicAttribContOffset;
    uint BasicDacOffset;
    uint BasicLatchesOffset;
    uint ExtendedSequencerOffset;
    uint ExtendedCrtContOffset;
    uint ExtendedGraphContOffset;
    uint ExtendedAttribContOffset;
    uint ExtendedDacOffset;
    uint ExtendedValidatorStateOffset;
    uint ExtendedMiscDataOffset;
    uint PlaneLength;
    uint Plane1Offset;
    uint Plane2Offset;
    uint Plane3Offset;
    uint Plane4Offset;
    uint VGAStateFlags;
    uint DIBOffset;
    uint DIBBitsPerPixel;
    uint DIBXResolution;
    uint DIBYResolution;
    uint DIBXlatOffset;
    uint DIBXlatLength;
    uint VesaInfoOffset;
    void* FrameBufferData;
}

struct VIDEO_HARDWARE_STATE
{
    VIDEO_HARDWARE_STATE_HEADER* StateHeader;
    uint StateLength;
}

struct VIDEO_NUM_MODES
{
    uint NumModes;
    uint ModeInformationLength;
}

struct VIDEO_MODE
{
    uint RequestedMode;
}

struct VIDEO_MODE_INFORMATION
{
    uint Length;
    uint ModeIndex;
    uint VisScreenWidth;
    uint VisScreenHeight;
    uint ScreenStride;
    uint NumberOfPlanes;
    uint BitsPerPlane;
    uint Frequency;
    uint XMillimeter;
    uint YMillimeter;
    uint NumberRedBits;
    uint NumberGreenBits;
    uint NumberBlueBits;
    uint RedMask;
    uint GreenMask;
    uint BlueMask;
    uint AttributeFlags;
    uint VideoMemoryBitmapWidth;
    uint VideoMemoryBitmapHeight;
    uint DriverSpecificAttributeFlags;
}

struct VIDEO_LOAD_FONT_INFORMATION
{
    ushort WidthInPixels;
    ushort HeightInPixels;
    uint FontSize;
    ubyte Font;
}

struct VIDEO_PALETTE_DATA
{
    ushort NumEntries;
    ushort FirstEntry;
    ushort Colors;
}

struct VIDEO_CLUTDATA
{
    ubyte Red;
    ubyte Green;
    ubyte Blue;
    ubyte Unused;
}

struct VIDEO_CLUT
{
    ushort NumEntries;
    ushort FirstEntry;
    _Anonymous_e__Union LookupTable;
}

struct VIDEO_CURSOR_POSITION
{
    short Column;
    short Row;
}

struct VIDEO_CURSOR_ATTRIBUTES
{
    ushort Width;
    ushort Height;
    short Column;
    short Row;
    ubyte Rate;
    ubyte Enable;
}

struct VIDEO_POINTER_POSITION
{
    short Column;
    short Row;
}

struct VIDEO_POINTER_ATTRIBUTES
{
    uint Flags;
    uint Width;
    uint Height;
    uint WidthInBytes;
    uint Enable;
    short Column;
    short Row;
    ubyte Pixels;
}

struct VIDEO_POINTER_CAPABILITIES
{
    uint Flags;
    uint MaxWidth;
    uint MaxHeight;
    uint HWPtrBitmapStart;
    uint HWPtrBitmapEnd;
}

struct VIDEO_BANK_SELECT
{
    uint Length;
    uint Size;
    uint BankingFlags;
    uint BankingType;
    uint PlanarHCBankingType;
    uint BitmapWidthInBytes;
    uint BitmapSize;
    uint Granularity;
    uint PlanarHCGranularity;
    uint CodeOffset;
    uint PlanarHCBankCodeOffset;
    uint PlanarHCEnableCodeOffset;
    uint PlanarHCDisableCodeOffset;
}

enum VIDEO_BANK_TYPE
{
    VideoNotBanked = 0,
    VideoBanked1RW = 1,
    VideoBanked1R1W = 2,
    VideoBanked2RW = 3,
    NumVideoBankTypes = 4,
}

struct VIDEO_MEMORY
{
    void* RequestedVirtualAddress;
}

struct VIDEO_SHARE_MEMORY
{
    HANDLE ProcessHandle;
    uint ViewOffset;
    uint ViewSize;
    void* RequestedVirtualAddress;
}

struct VIDEO_SHARE_MEMORY_INFORMATION
{
    uint SharedViewOffset;
    uint SharedViewSize;
    void* VirtualAddress;
}

struct VIDEO_MEMORY_INFORMATION
{
    void* VideoRamBase;
    uint VideoRamLength;
    void* FrameBufferBase;
    uint FrameBufferLength;
}

struct VIDEO_PUBLIC_ACCESS_RANGES
{
    uint InIoSpace;
    uint MappedInIoSpace;
    void* VirtualAddress;
}

struct VIDEO_COLOR_CAPABILITIES
{
    uint Length;
    uint AttributeFlags;
    int RedPhosphoreDecay;
    int GreenPhosphoreDecay;
    int BluePhosphoreDecay;
    int WhiteChromaticity_x;
    int WhiteChromaticity_y;
    int WhiteChromaticity_Y;
    int RedChromaticity_x;
    int RedChromaticity_y;
    int GreenChromaticity_x;
    int GreenChromaticity_y;
    int BlueChromaticity_x;
    int BlueChromaticity_y;
    int WhiteGamma;
    int RedGamma;
    int GreenGamma;
    int BlueGamma;
}

enum VIDEO_POWER_STATE
{
    VideoPowerUnspecified = 0,
    VideoPowerOn = 1,
    VideoPowerStandBy = 2,
    VideoPowerSuspend = 3,
    VideoPowerOff = 4,
    VideoPowerHibernate = 5,
    VideoPowerShutdown = 6,
    VideoPowerMaximum = 7,
}

struct VIDEO_POWER_MANAGEMENT
{
    uint Length;
    uint DPMSVersion;
    uint PowerState;
}

struct VIDEO_COLOR_LUT_DATA
{
    uint Length;
    uint LutDataFormat;
    ubyte LutData;
}

struct VIDEO_LUT_RGB256WORDS
{
    ushort Red;
    ushort Green;
    ushort Blue;
}

struct BANK_POSITION
{
    uint ReadBankPosition;
    uint WriteBankPosition;
}

struct DISPLAY_BRIGHTNESS
{
    ubyte ucDisplayPolicy;
    ubyte ucACBrightness;
    ubyte ucDCBrightness;
}

struct VIDEO_BRIGHTNESS_POLICY
{
    ubyte DefaultToBiosPolicy;
    ubyte LevelCount;
    _Anonymous_e__Struct Level;
}

struct FSCNTL_SCREEN_INFO
{
    COORD Position;
    COORD ScreenSize;
    uint nNumberOfChars;
}

struct FONT_IMAGE_INFO
{
    COORD FontSize;
    ubyte* ImageBits;
}

struct CHAR_IMAGE_INFO
{
    CHAR_INFO CharInfo;
    FONT_IMAGE_INFO FontImageInfo;
}

struct VGA_CHAR
{
    byte Char;
    byte Attributes;
}

struct FSVIDEO_COPY_FRAME_BUFFER
{
    FSCNTL_SCREEN_INFO SrcScreen;
    FSCNTL_SCREEN_INFO DestScreen;
}

struct FSVIDEO_WRITE_TO_FRAME_BUFFER
{
    CHAR_IMAGE_INFO* SrcBuffer;
    FSCNTL_SCREEN_INFO DestScreen;
}

struct FSVIDEO_REVERSE_MOUSE_POINTER
{
    FSCNTL_SCREEN_INFO Screen;
    uint dwType;
}

struct FSVIDEO_MODE_INFORMATION
{
    VIDEO_MODE_INFORMATION VideoMode;
    VIDEO_MEMORY_INFORMATION VideoMemory;
}

struct FSVIDEO_SCREEN_INFORMATION
{
    COORD ScreenSize;
    COORD FontSize;
}

struct FSVIDEO_CURSOR_POSITION
{
    VIDEO_CURSOR_POSITION Coord;
    uint dwType;
}

struct ENG_EVENT
{
    void* pKEvent;
    uint fFlags;
}

struct VIDEO_PERFORMANCE_COUNTER
{
    ulong NbOfAllocationEvicted;
    ulong NbOfAllocationMarked;
    ulong NbOfAllocationRestored;
    ulong KBytesEvicted;
    ulong KBytesMarked;
    ulong KBytesRestored;
    ulong NbProcessCommited;
    ulong NbAllocationCommited;
    ulong NbAllocationMarked;
    ulong KBytesAllocated;
    ulong KBytesAvailable;
    ulong KBytesCurMarked;
    ulong Reference;
    ulong Unreference;
    ulong TrueReference;
    ulong NbOfPageIn;
    ulong KBytesPageIn;
    ulong NbOfPageOut;
    ulong KBytesPageOut;
    ulong NbOfRotateOut;
    ulong KBytesRotateOut;
}

struct VIDEO_QUERY_PERFORMANCE_COUNTER
{
    uint BufferSize;
    VIDEO_PERFORMANCE_COUNTER* Buffer;
}

enum BRIGHTNESS_INTERFACE_VERSION
{
    BRIGHTNESS_INTERFACE_VERSION_1 = 1,
    BRIGHTNESS_INTERFACE_VERSION_2 = 2,
    BRIGHTNESS_INTERFACE_VERSION_3 = 3,
}

struct PANEL_QUERY_BRIGHTNESS_CAPS
{
    BRIGHTNESS_INTERFACE_VERSION Version;
    _Anonymous_e__Union Anonymous;
}

struct BRIGHTNESS_LEVEL
{
    ubyte Count;
    ubyte Level;
}

struct BRIGHTNESS_NIT_RANGE
{
    uint MinLevelInMillinit;
    uint MaxLevelInMillinit;
    uint StepSizeInMillinit;
}

struct BRIGHTNESS_NIT_RANGES
{
    uint NormalRangeCount;
    uint RangeCount;
    uint PreferredMaximumBrightness;
    BRIGHTNESS_NIT_RANGE SupportedRanges;
}

struct PANEL_QUERY_BRIGHTNESS_RANGES
{
    BRIGHTNESS_INTERFACE_VERSION Version;
    _Anonymous_e__Union Anonymous;
}

struct PANEL_GET_BRIGHTNESS
{
    BRIGHTNESS_INTERFACE_VERSION Version;
    _Anonymous_e__Union Anonymous;
}

struct CHROMATICITY_COORDINATE
{
    float x;
    float y;
}

struct PANEL_BRIGHTNESS_SENSOR_DATA
{
    _Anonymous_e__Union Anonymous;
    float AlsReading;
    CHROMATICITY_COORDINATE ChromaticityCoordinate;
    float ColorTemperature;
}

struct PANEL_SET_BRIGHTNESS
{
    BRIGHTNESS_INTERFACE_VERSION Version;
    _Anonymous_e__Union Anonymous;
}

struct PANEL_SET_BRIGHTNESS_STATE
{
    _Anonymous_e__Union Anonymous;
}

enum BACKLIGHT_OPTIMIZATION_LEVEL
{
    BacklightOptimizationDisable = 0,
    BacklightOptimizationDesktop = 1,
    BacklightOptimizationDynamic = 2,
    BacklightOptimizationDimmed = 3,
    BacklightOptimizationEDR = 4,
}

struct PANEL_SET_BACKLIGHT_OPTIMIZATION
{
    BACKLIGHT_OPTIMIZATION_LEVEL Level;
}

struct BACKLIGHT_REDUCTION_GAMMA_RAMP
{
    ushort R;
    ushort G;
    ushort B;
}

struct PANEL_GET_BACKLIGHT_REDUCTION
{
    ushort BacklightUsersetting;
    ushort BacklightEffective;
    BACKLIGHT_REDUCTION_GAMMA_RAMP GammaRamp;
}

enum COLORSPACE_TRANSFORM_DATA_TYPE
{
    COLORSPACE_TRANSFORM_DATA_TYPE_FIXED_POINT = 0,
    COLORSPACE_TRANSFORM_DATA_TYPE_FLOAT = 1,
}

struct COLORSPACE_TRANSFORM_DATA_CAP
{
    COLORSPACE_TRANSFORM_DATA_TYPE DataType;
    _Anonymous_e__Union Anonymous;
    float NumericRangeMin;
    float NumericRangeMax;
}

struct COLORSPACE_TRANSFORM_1DLUT_CAP
{
    uint NumberOfLUTEntries;
    COLORSPACE_TRANSFORM_DATA_CAP DataCap;
}

struct COLORSPACE_TRANSFORM_MATRIX_CAP
{
    _Anonymous_e__Union Anonymous;
    COLORSPACE_TRANSFORM_DATA_CAP DataCap;
}

enum COLORSPACE_TRANSFORM_TARGET_CAPS_VERSION
{
    COLORSPACE_TRANSFORM_VERSION_DEFAULT = 0,
    COLORSPACE_TRANSFORM_VERSION_1 = 1,
    COLORSPACE_TRANSFORM_VERSION_NOT_SUPPORTED = 0,
}

struct COLORSPACE_TRANSFORM_TARGET_CAPS
{
    COLORSPACE_TRANSFORM_TARGET_CAPS_VERSION Version;
    COLORSPACE_TRANSFORM_1DLUT_CAP LookupTable1DDegammaCap;
    COLORSPACE_TRANSFORM_MATRIX_CAP ColorMatrix3x3Cap;
    COLORSPACE_TRANSFORM_1DLUT_CAP LookupTable1DRegammaCap;
}

enum COLORSPACE_TRANSFORM_TYPE
{
    COLORSPACE_TRANSFORM_TYPE_UNINITIALIZED = 0,
    COLORSPACE_TRANSFORM_TYPE_DEFAULT = 1,
    COLORSPACE_TRANSFORM_TYPE_RGB256x3x16 = 2,
    COLORSPACE_TRANSFORM_TYPE_DXGI_1 = 3,
    COLORSPACE_TRANSFORM_TYPE_MATRIX_3x4 = 4,
    COLORSPACE_TRANSFORM_TYPE_MATRIX_V2 = 5,
}

struct GAMMA_RAMP_RGB256x3x16
{
    ushort Red;
    ushort Green;
    ushort Blue;
}

struct GAMMA_RAMP_RGB
{
    float Red;
    float Green;
    float Blue;
}

struct GAMMA_RAMP_DXGI_1
{
    GAMMA_RAMP_RGB Scale;
    GAMMA_RAMP_RGB Offset;
    GAMMA_RAMP_RGB GammaCurve;
}

struct COLORSPACE_TRANSFORM_3x4
{
    float ColorMatrix3x4;
    float ScalarMultiplier;
    GAMMA_RAMP_RGB LookupTable1D;
}

enum OUTPUT_WIRE_COLOR_SPACE_TYPE
{
    OUTPUT_WIRE_COLOR_SPACE_G22_P709 = 0,
    OUTPUT_WIRE_COLOR_SPACE_RESERVED = 4,
    OUTPUT_WIRE_COLOR_SPACE_G2084_P2020 = 12,
    OUTPUT_WIRE_COLOR_SPACE_G22_P709_WCG = 30,
    OUTPUT_WIRE_COLOR_SPACE_G22_P2020 = 31,
    OUTPUT_WIRE_COLOR_SPACE_G2084_P2020_HDR10PLUS = 32,
    OUTPUT_WIRE_COLOR_SPACE_G2084_P2020_DVLL = 33,
}

enum OUTPUT_COLOR_ENCODING
{
    OUTPUT_COLOR_ENCODING_RGB = 0,
    OUTPUT_COLOR_ENCODING_YCBCR444 = 1,
    OUTPUT_COLOR_ENCODING_YCBCR422 = 2,
    OUTPUT_COLOR_ENCODING_YCBCR420 = 3,
    OUTPUT_COLOR_ENCODING_INTENSITY = 4,
    OUTPUT_COLOR_ENCODING_FORCE_UINT32 = -1,
}

struct OUTPUT_WIRE_FORMAT
{
    OUTPUT_COLOR_ENCODING ColorEncoding;
    uint BitsPerPixel;
}

enum COLORSPACE_TRANSFORM_STAGE_CONTROL
{
    ColorSpaceTransformStageControl_No_Change = 0,
    ColorSpaceTransformStageControl_Enable = 1,
    ColorSpaceTransformStageControl_Bypass = 2,
}

struct COLORSPACE_TRANSFORM_MATRIX_V2
{
    COLORSPACE_TRANSFORM_STAGE_CONTROL StageControlLookupTable1DDegamma;
    GAMMA_RAMP_RGB LookupTable1DDegamma;
    COLORSPACE_TRANSFORM_STAGE_CONTROL StageControlColorMatrix3x3;
    float ColorMatrix3x3;
    COLORSPACE_TRANSFORM_STAGE_CONTROL StageControlLookupTable1DRegamma;
    GAMMA_RAMP_RGB LookupTable1DRegamma;
}

struct COLORSPACE_TRANSFORM
{
    COLORSPACE_TRANSFORM_TYPE Type;
    _Data_e__Union Data;
}

struct COLORSPACE_TRANSFORM_SET_INPUT
{
    OUTPUT_WIRE_COLOR_SPACE_TYPE OutputWireColorSpaceExpected;
    OUTPUT_WIRE_FORMAT OutputWireFormatExpected;
    COLORSPACE_TRANSFORM ColorSpaceTransform;
}

struct SET_ACTIVE_COLOR_PROFILE_NAME
{
    ushort ColorProfileName;
}

struct MIPI_DSI_CAPS
{
    ubyte DSITypeMajor;
    ubyte DSITypeMinor;
    ubyte SpecVersionMajor;
    ubyte SpecVersionMinor;
    ubyte SpecVersionPatch;
    ushort TargetMaximumReturnPacketSize;
    ubyte ResultCodeFlags;
    ubyte ResultCodeStatus;
    ubyte Revision;
    ubyte Level;
    ubyte DeviceClassHi;
    ubyte DeviceClassLo;
    ubyte ManufacturerHi;
    ubyte ManufacturerLo;
    ubyte ProductHi;
    ubyte ProductLo;
    ubyte LengthHi;
    ubyte LengthLo;
}

enum DSI_CONTROL_TRANSMISSION_MODE
{
    DCT_DEFAULT = 0,
    DCT_FORCE_LOW_POWER = 1,
    DCT_FORCE_HIGH_PERFORMANCE = 2,
}

struct MIPI_DSI_PACKET
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ubyte EccFiller;
    ubyte Payload;
}

struct MIPI_DSI_TRANSMISSION
{
    uint TotalBufferSize;
    ubyte PacketCount;
    ubyte FailedPacket;
    _Anonymous_e__Struct Anonymous;
    ushort ReadWordCount;
    ushort FinalCommandExtraPayload;
    ushort MipiErrors;
    ushort HostErrors;
    MIPI_DSI_PACKET Packets;
}

struct MIPI_DSI_RESET
{
    uint Flags;
    _Anonymous_e__Union Anonymous;
}

struct POWERBROADCAST_SETTING
{
    Guid PowerSetting;
    uint DataLength;
    ubyte Data;
}

enum AR_STATE
{
    AR_ENABLED = 0,
    AR_DISABLED = 1,
    AR_SUPPRESSED = 2,
    AR_REMOTESESSION = 4,
    AR_MULTIMON = 8,
    AR_NOSENSOR = 16,
    AR_NOT_SUPPORTED = 32,
    AR_DOCKED = 64,
    AR_LAPTOP = 128,
}

enum ORIENTATION_PREFERENCE
{
    ORIENTATION_PREFERENCE_NONE = 0,
    ORIENTATION_PREFERENCE_LANDSCAPE = 1,
    ORIENTATION_PREFERENCE_PORTRAIT = 2,
    ORIENTATION_PREFERENCE_LANDSCAPE_FLIPPED = 4,
    ORIENTATION_PREFERENCE_PORTRAIT_FLIPPED = 8,
}

struct PROCESS_INFORMATION
{
    HANDLE hProcess;
    HANDLE hThread;
    uint dwProcessId;
    uint dwThreadId;
}

struct STARTUPINFOA
{
    uint cb;
    const(char)* lpReserved;
    const(char)* lpDesktop;
    const(char)* lpTitle;
    uint dwX;
    uint dwY;
    uint dwXSize;
    uint dwYSize;
    uint dwXCountChars;
    uint dwYCountChars;
    uint dwFillAttribute;
    uint dwFlags;
    ushort wShowWindow;
    ushort cbReserved2;
    ubyte* lpReserved2;
    HANDLE hStdInput;
    HANDLE hStdOutput;
    HANDLE hStdError;
}

struct STARTUPINFOW
{
    uint cb;
    const(wchar)* lpReserved;
    const(wchar)* lpDesktop;
    const(wchar)* lpTitle;
    uint dwX;
    uint dwY;
    uint dwXSize;
    uint dwYSize;
    uint dwXCountChars;
    uint dwYCountChars;
    uint dwFillAttribute;
    uint dwFlags;
    ushort wShowWindow;
    ushort cbReserved2;
    ubyte* lpReserved2;
    HANDLE hStdInput;
    HANDLE hStdOutput;
    HANDLE hStdError;
}

struct MEMORY_PRIORITY_INFORMATION
{
    uint MemoryPriority;
}

struct THREAD_POWER_THROTTLING_STATE
{
    uint Version;
    uint ControlMask;
    uint StateMask;
}

struct APP_MEMORY_INFORMATION
{
    ulong AvailableCommit;
    ulong PrivateCommitUsage;
    ulong PeakPrivateCommitUsage;
    ulong TotalCommitUsage;
}

enum PROCESS_MEMORY_EXHAUSTION_TYPE
{
    PMETypeFailFastOnCommitFailure = 0,
    PMETypeMax = 1,
}

struct PROCESS_MEMORY_EXHAUSTION_INFO
{
    ushort Version;
    ushort Reserved;
    PROCESS_MEMORY_EXHAUSTION_TYPE Type;
    uint Value;
}

struct PROCESS_POWER_THROTTLING_STATE
{
    uint Version;
    uint ControlMask;
    uint StateMask;
}

struct PROCESS_PROTECTION_LEVEL_INFORMATION
{
    uint ProtectionLevel;
}

struct PROCESS_LEAP_SECOND_INFO
{
    uint Flags;
    uint Reserved;
}

struct MEMORYSTATUSEX
{
    uint dwLength;
    uint dwMemoryLoad;
    ulong ullTotalPhys;
    ulong ullAvailPhys;
    ulong ullTotalPageFile;
    ulong ullAvailPageFile;
    ulong ullTotalVirtual;
    ulong ullAvailVirtual;
    ulong ullAvailExtendedVirtual;
}

alias PFIBER_START_ROUTINE = extern(Windows) void function(void* lpFiberParameter);
struct COMMPROP
{
    ushort wPacketLength;
    ushort wPacketVersion;
    uint dwServiceMask;
    uint dwReserved1;
    uint dwMaxTxQueue;
    uint dwMaxRxQueue;
    uint dwMaxBaud;
    uint dwProvSubType;
    uint dwProvCapabilities;
    uint dwSettableParams;
    uint dwSettableBaud;
    ushort wSettableData;
    ushort wSettableStopParity;
    uint dwCurrentTxQueue;
    uint dwCurrentRxQueue;
    uint dwProvSpec1;
    uint dwProvSpec2;
    ushort wcProvChar;
}

struct COMSTAT
{
    uint _bitfield;
    uint cbInQue;
    uint cbOutQue;
}

struct DCB
{
    uint DCBlength;
    uint BaudRate;
    uint _bitfield;
    ushort wReserved;
    ushort XonLim;
    ushort XoffLim;
    ubyte ByteSize;
    ubyte Parity;
    ubyte StopBits;
    byte XonChar;
    byte XoffChar;
    byte ErrorChar;
    byte EofChar;
    byte EvtChar;
    ushort wReserved1;
}

struct COMMTIMEOUTS
{
    uint ReadIntervalTimeout;
    uint ReadTotalTimeoutMultiplier;
    uint ReadTotalTimeoutConstant;
    uint WriteTotalTimeoutMultiplier;
    uint WriteTotalTimeoutConstant;
}

struct COMMCONFIG
{
    uint dwSize;
    ushort wVersion;
    ushort wReserved;
    DCB dcb;
    uint dwProviderSubType;
    uint dwProviderOffset;
    uint dwProviderSize;
    ushort wcProviderData;
}

struct MEMORYSTATUS
{
    uint dwLength;
    uint dwMemoryLoad;
    uint dwTotalPhys;
    uint dwAvailPhys;
    uint dwTotalPageFile;
    uint dwAvailPageFile;
    uint dwTotalVirtual;
    uint dwAvailVirtual;
}

struct UMS_SCHEDULER_STARTUP_INFO
{
    uint UmsVersion;
    void* CompletionList;
    PUMS_SCHEDULER_ENTRY_POINT SchedulerProc;
    void* SchedulerParam;
}

struct UMS_SYSTEM_THREAD_INFORMATION
{
    uint UmsVersion;
    _Anonymous_e__Union Anonymous;
}

struct WIN32_STREAM_ID
{
    uint dwStreamId;
    uint dwStreamAttributes;
    LARGE_INTEGER Size;
    uint dwStreamNameSize;
    ushort cStreamName;
}

struct STARTUPINFOEXA
{
    STARTUPINFOA StartupInfo;
    int lpAttributeList;
}

struct STARTUPINFOEXW
{
    STARTUPINFOW StartupInfo;
    int lpAttributeList;
}

struct EVENTLOG_FULL_INFORMATION
{
    uint dwFull;
}

struct SYSTEM_POWER_STATUS
{
    ubyte ACLineStatus;
    ubyte BatteryFlag;
    ubyte BatteryLifePercent;
    ubyte SystemStatusFlag;
    uint BatteryLifeTime;
    uint BatteryFullLifeTime;
}

struct PEB_LDR_DATA
{
    ubyte Reserved1;
    void* Reserved2;
    LIST_ENTRY InMemoryOrderModuleList;
}

struct RTL_USER_PROCESS_PARAMETERS
{
    ubyte Reserved1;
    void* Reserved2;
    UNICODE_STRING ImagePathName;
    UNICODE_STRING CommandLine;
}

struct PEB
{
    ubyte Reserved1;
    ubyte BeingDebugged;
    ubyte Reserved2;
    void* Reserved3;
    PEB_LDR_DATA* Ldr;
    RTL_USER_PROCESS_PARAMETERS* ProcessParameters;
    void* Reserved4;
    void* AtlThunkSListPtr;
    void* Reserved5;
    uint Reserved6;
    void* Reserved7;
    uint Reserved8;
    uint AtlThunkSListPtr32;
    void* Reserved9;
    ubyte Reserved10;
    PPS_POST_PROCESS_INIT_ROUTINE PostProcessInitRoutine;
    ubyte Reserved11;
    void* Reserved12;
    uint SessionId;
}

