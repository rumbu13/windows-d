// Written in the D programming language.

module windows.win32.system.clrhosting;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, HANDLE, HINSTANCE,
                                         HMODULE, HRESULT, HWND, PSTR, PWSTR;
public import windows.win32.security : ACL;
public import windows.win32.system.com : IEnumUnknown, IStream, IUnknown;
public import windows.win32.system.diagnostics.debug_ : EXCEPTION_POINTERS;
public import windows.win32.system.io : LPOVERLAPPED_COMPLETION_ROUTINE;
public import windows.win32.system.threading : LPTHREAD_START_ROUTINE, PROCESS_INFORMATION,
                                               WAITORTIMERCALLBACK;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias COR_GC_STAT_TYPES = int;
enum : int
{
    COR_GC_COUNTS      = 0x00000001,
    COR_GC_MEMORYUSAGE = 0x00000002,
}

alias COR_GC_THREAD_STATS_TYPES = int;
enum : int
{
    COR_GC_THREAD_HAS_PROMOTED_BYTES = 0x00000001,
}

alias HOST_TYPE = int;
enum : int
{
    HOST_TYPE_DEFAULT   = 0x00000000,
    HOST_TYPE_APPLAUNCH = 0x00000001,
    HOST_TYPE_CORFLAG   = 0x00000002,
}

alias STARTUP_FLAGS = int;
enum : int
{
    STARTUP_CONCURRENT_GC                         = 0x00000001,
    STARTUP_LOADER_OPTIMIZATION_MASK              = 0x00000006,
    STARTUP_LOADER_OPTIMIZATION_SINGLE_DOMAIN     = 0x00000002,
    STARTUP_LOADER_OPTIMIZATION_MULTI_DOMAIN      = 0x00000004,
    STARTUP_LOADER_OPTIMIZATION_MULTI_DOMAIN_HOST = 0x00000006,
    STARTUP_LOADER_SAFEMODE                       = 0x00000010,
    STARTUP_LOADER_SETPREFERENCE                  = 0x00000100,
    STARTUP_SERVER_GC                             = 0x00001000,
    STARTUP_HOARD_GC_VM                           = 0x00002000,
    STARTUP_SINGLE_VERSION_HOSTING_INTERFACE      = 0x00004000,
    STARTUP_LEGACY_IMPERSONATION                  = 0x00010000,
    STARTUP_DISABLE_COMMITTHREADSTACK             = 0x00020000,
    STARTUP_ALWAYSFLOW_IMPERSONATION              = 0x00040000,
    STARTUP_TRIM_GC_COMMIT                        = 0x00080000,
    STARTUP_ETW                                   = 0x00100000,
    STARTUP_ARM                                   = 0x00400000,
}

alias CLSID_RESOLUTION_FLAGS = int;
enum : int
{
    CLSID_RESOLUTION_DEFAULT    = 0x00000000,
    CLSID_RESOLUTION_REGISTERED = 0x00000001,
}

alias RUNTIME_INFO_FLAGS = int;
enum : int
{
    RUNTIME_INFO_UPGRADE_VERSION        = 0x00000001,
    RUNTIME_INFO_REQUEST_IA64           = 0x00000002,
    RUNTIME_INFO_REQUEST_AMD64          = 0x00000004,
    RUNTIME_INFO_REQUEST_X86            = 0x00000008,
    RUNTIME_INFO_DONT_RETURN_DIRECTORY  = 0x00000010,
    RUNTIME_INFO_DONT_RETURN_VERSION    = 0x00000020,
    RUNTIME_INFO_DONT_SHOW_ERROR_DIALOG = 0x00000040,
    RUNTIME_INFO_IGNORE_ERROR_MODE      = 0x00001000,
    RUNTIME_INFO_REQUEST_ARM64          = 0x00002000,
}

alias APPDOMAIN_SECURITY_FLAGS = int;
enum : int
{
    APPDOMAIN_SECURITY_DEFAULT                        = 0x00000000,
    APPDOMAIN_SECURITY_SANDBOXED                      = 0x00000001,
    APPDOMAIN_SECURITY_FORBID_CROSSAD_REVERSE_PINVOKE = 0x00000002,
    APPDOMAIN_FORCE_TRIVIAL_WAIT_OPERATIONS           = 0x00000008,
}

enum EMemoryAvailable : int
{
    eMemoryAvailableLow     = 0x00000001,
    eMemoryAvailableNeutral = 0x00000002,
    eMemoryAvailableHigh    = 0x00000003,
}

enum EMemoryCriticalLevel : int
{
    eTaskCritical      = 0x00000000,
    eAppDomainCritical = 0x00000001,
    eProcessCritical   = 0x00000002,
}

alias WAIT_OPTION = int;
enum : int
{
    WAIT_MSGPUMP       = 0x00000001,
    WAIT_ALERTABLE     = 0x00000002,
    WAIT_NOTINDEADLOCK = 0x00000004,
}

alias MALLOC_TYPE = int;
enum : int
{
    MALLOC_THREADSAFE = 0x00000001,
    MALLOC_EXECUTABLE = 0x00000002,
}

enum ETaskType : int
{
    TT_DEBUGGERHELPER          = 0x00000001,
    TT_GC                      = 0x00000002,
    TT_FINALIZER               = 0x00000004,
    TT_THREADPOOL_TIMER        = 0x00000008,
    TT_THREADPOOL_GATE         = 0x00000010,
    TT_THREADPOOL_WORKER       = 0x00000020,
    TT_THREADPOOL_IOCOMPLETION = 0x00000040,
    TT_ADUNLOAD                = 0x00000080,
    TT_USER                    = 0x00000100,
    TT_THREADPOOL_WAIT         = 0x00000200,
    TT_UNKNOWN                 = 0x80000000,
}

enum ESymbolReadingPolicy : int
{
    eSymbolReadingNever         = 0x00000000,
    eSymbolReadingAlways        = 0x00000001,
    eSymbolReadingFullTrustOnly = 0x00000002,
}

enum ECustomDumpFlavor : int
{
    DUMP_FLAVOR_Mini             = 0x00000000,
    DUMP_FLAVOR_CriticalCLRState = 0x00000001,
    DUMP_FLAVOR_NonHeapCLRState  = 0x00000002,
    DUMP_FLAVOR_Default          = 0x00000000,
}

enum ECustomDumpItemKind : int
{
    DUMP_ITEM_None = 0x00000000,
}

enum BucketParameterIndex : int
{
    Parameter1              = 0x00000000,
    Parameter2              = 0x00000001,
    Parameter3              = 0x00000002,
    Parameter4              = 0x00000003,
    Parameter5              = 0x00000004,
    Parameter6              = 0x00000005,
    Parameter7              = 0x00000006,
    Parameter8              = 0x00000007,
    Parameter9              = 0x00000008,
    InvalidBucketParamIndex = 0x00000009,
}

enum EClrOperation : int
{
    OPR_ThreadAbort                        = 0x00000000,
    OPR_ThreadRudeAbortInNonCriticalRegion = 0x00000001,
    OPR_ThreadRudeAbortInCriticalRegion    = 0x00000002,
    OPR_AppDomainUnload                    = 0x00000003,
    OPR_AppDomainRudeUnload                = 0x00000004,
    OPR_ProcessExit                        = 0x00000005,
    OPR_FinalizerRun                       = 0x00000006,
    MaxClrOperation                        = 0x00000007,
}

enum EClrFailure : int
{
    FAIL_NonCriticalResource = 0x00000000,
    FAIL_CriticalResource    = 0x00000001,
    FAIL_FatalRuntime        = 0x00000002,
    FAIL_OrphanedLock        = 0x00000003,
    FAIL_StackOverflow       = 0x00000004,
    FAIL_AccessViolation     = 0x00000005,
    FAIL_CodeContract        = 0x00000006,
    MaxClrFailure            = 0x00000007,
}

enum EClrUnhandledException : int
{
    eRuntimeDeterminedPolicy = 0x00000000,
    eHostDeterminedPolicy    = 0x00000001,
}

enum EPolicyAction : int
{
    eNoAction            = 0x00000000,
    eThrowException      = 0x00000001,
    eAbortThread         = 0x00000002,
    eRudeAbortThread     = 0x00000003,
    eUnloadAppDomain     = 0x00000004,
    eRudeUnloadAppDomain = 0x00000005,
    eExitProcess         = 0x00000006,
    eFastExitProcess     = 0x00000007,
    eRudeExitProcess     = 0x00000008,
    eDisableRuntime      = 0x00000009,
    MaxPolicyAction      = 0x0000000a,
}

enum EClrEvent : int
{
    Event_DomainUnload  = 0x00000000,
    Event_ClrDisabled   = 0x00000001,
    Event_MDAFired      = 0x00000002,
    Event_StackOverflow = 0x00000003,
    MaxClrEvent         = 0x00000004,
}

enum StackOverflowType : int
{
    SO_Managed   = 0x00000000,
    SO_ClrEngine = 0x00000001,
    SO_Other     = 0x00000002,
}

enum ECLRAssemblyIdentityFlags : int
{
    CLR_ASSEMBLY_IDENTITY_FLAGS_DEFAULT = 0x00000000,
}

enum EHostBindingPolicyModifyFlags : int
{
    HOST_BINDING_POLICY_MODIFY_DEFAULT = 0x00000000,
    HOST_BINDING_POLICY_MODIFY_CHAIN   = 0x00000001,
    HOST_BINDING_POLICY_MODIFY_REMOVE  = 0x00000002,
    HOST_BINDING_POLICY_MODIFY_MAX     = 0x00000003,
}

enum EBindPolicyLevels : int
{
    ePolicyLevelNone         = 0x00000000,
    ePolicyLevelRetargetable = 0x00000001,
    ePolicyUnifiedToCLR      = 0x00000002,
    ePolicyLevelApp          = 0x00000004,
    ePolicyLevelPublisher    = 0x00000008,
    ePolicyLevelHost         = 0x00000010,
    ePolicyLevelAdmin        = 0x00000020,
    ePolicyPortability       = 0x00000040,
}

enum EHostApplicationPolicy : int
{
    HOST_APPLICATION_BINDING_POLICY = 0x00000001,
}

enum EApiCategories : int
{
    eNoChecks                 = 0x00000000,
    eSynchronization          = 0x00000001,
    eSharedState              = 0x00000002,
    eExternalProcessMgmt      = 0x00000004,
    eSelfAffectingProcessMgmt = 0x00000008,
    eExternalThreading        = 0x00000010,
    eSelfAffectingThreading   = 0x00000020,
    eSecurityInfrastructure   = 0x00000040,
    eUI                       = 0x00000080,
    eMayLeakOnAbort           = 0x00000100,
    eAll                      = 0x000001ff,
}

enum EInitializeNewDomainFlags : int
{
    eInitializeNewDomainFlags_None              = 0x00000000,
    eInitializeNewDomainFlags_NoSecurityChanges = 0x00000002,
}

enum EContextType : int
{
    eCurrentContext    = 0x00000000,
    eRestrictedContext = 0x00000001,
}

alias METAHOST_POLICY_FLAGS = int;
enum : int
{
    METAHOST_POLICY_HIGHCOMPAT             = 0x00000000,
    METAHOST_POLICY_APPLY_UPGRADE_POLICY   = 0x00000008,
    METAHOST_POLICY_EMULATE_EXE_LAUNCH     = 0x00000010,
    METAHOST_POLICY_SHOW_ERROR_DIALOG      = 0x00000020,
    METAHOST_POLICY_USE_PROCESS_IMAGE_PATH = 0x00000040,
    METAHOST_POLICY_ENSURE_SKU_SUPPORTED   = 0x00000080,
    METAHOST_POLICY_IGNORE_ERROR_MODE      = 0x00001000,
}

alias METAHOST_CONFIG_FLAGS = int;
enum : int
{
    METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_UNSET = 0x00000000,
    METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_TRUE  = 0x00000001,
    METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_FALSE = 0x00000002,
    METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_MASK  = 0x00000003,
}

alias CLR_DEBUGGING_PROCESS_FLAGS = int;
enum : int
{
    CLR_DEBUGGING_MANAGED_EVENT_PENDING         = 0x00000001,
    CLR_DEBUGGING_MANAGED_EVENT_DEBUGGER_LAUNCH = 0x00000002,
}

// Constants


// Native encoding: ansi
enum const(wchar)* DEPRECATED_CLR_API_MESG = "This API has been deprecated. Refer to https://go.microsoft.com/fwlink/?LinkId=143720 for more details.";
enum uint CLR_MAJOR_VERSION = 0x00000004U;
enum uint CLR_MINOR_VERSION = 0x00000000U;
enum uint CLR_BUILD_VERSION = 0x000056ccU;

enum : uint
{
    CLR_ASSEMBLY_MAJOR_VERSION = 0x00000004U,
    CLR_ASSEMBLY_MINOR_VERSION = 0x00000000U,
    CLR_ASSEMBLY_BUILD_VERSION = 0x00000000U,
}

enum : uint
{
    BucketParamsCount = 0x0000000aU,
    BucketParamLength = 0x000000ffU,
}

enum GUID LIBID_mscoree = GUID("5477469e-83b1-11d2-8b49-00a0c9b7c9c4");

enum : GUID
{
    CLSID_CLRStrongName     = GUID("b79b0acd-f5cd-409b-b5a5-a16244610b92"),
    CLSID_CLRMetaHost       = GUID("9280188d-0e8e-4867-b30c-7fa83884e8de"),
    CLSID_CLRMetaHostPolicy = GUID("2ebcd49a-1b47-4a61-b13a-4a03701e594b"),
}

enum : GUID
{
    CLSID_CLRDebugging       = GUID("bacc578d-fbdd-48a4-969f-02d932b74634"),
    CLSID_CLRDebuggingLegacy = GUID("df8395b5-a4ba-450b-a77c-a9a47762c520"),
}

enum GUID CLSID_CLRProfiling = GUID("bd097ed8-733e-43fe-8ed7-a95ff9a8448c");

// Callbacks

alias FLockClrVersionCallback = HRESULT function();
alias FExecuteInAppDomainCallback = HRESULT function(void* cookie);
alias PTLS_CALLBACK_FUNCTION = void function(void* __MIDL____MIDL_itf_mscoree_0000_00040005);
alias CLRCreateInstanceFnPtr = HRESULT function(const(GUID)* clsid, const(GUID)* riid, void** ppInterface);
alias CreateInterfaceFnPtr = HRESULT function(const(GUID)* clsid, const(GUID)* riid, void** ppInterface);
alias CallbackThreadSetFnPtr = HRESULT function();
alias CallbackThreadUnsetFnPtr = HRESULT function();
alias RuntimeLoadedCallbackFnPtr = void function(ICLRRuntimeInfo pRuntimeInfo, 
                                                 CallbackThreadSetFnPtr pfnCallbackThreadSet, 
                                                 CallbackThreadUnsetFnPtr pfnCallbackThreadUnset);

// Structs


struct COR_GC_STATS
{
    uint      Flags;
    size_t    ExplicitGCCount;
    size_t[3] GenCollectionsTaken;
    size_t    CommittedKBytes;
    size_t    ReservedKBytes;
    size_t    Gen0HeapSizeKBytes;
    size_t    Gen1HeapSizeKBytes;
    size_t    Gen2HeapSizeKBytes;
    size_t    LargeObjectHeapSizeKBytes;
    size_t    KBytesPromotedFromGen0;
    size_t    KBytesPromotedFromGen1;
}

struct COR_GC_THREAD_STATS
{
    ulong PerThreadAllocation;
    uint  Flags;
}

struct CustomDumpItem
{
    ECustomDumpItemKind itemKind;
    union
    {
        size_t pReserved;
    }
}

struct BucketParameters
{
    BOOL        fInited;
    wchar[255]  pszEventTypeName;
    wchar[2550] pszParams;
}

struct MDAInfo
{
    const(PWSTR) lpMDACaption;
    const(PWSTR) lpMDAMessage;
    const(PWSTR) lpStackTrace;
}

struct StackOverflowInfo
{
    StackOverflowType   soType;
    EXCEPTION_POINTERS* pExceptionInfo;
}

struct AssemblyBindInfo
{
    uint         dwAppDomainId;
    const(PWSTR) lpReferencedIdentity;
    const(PWSTR) lpPostPolicyIdentity;
    uint         ePolicyLevel;
}

struct ModuleBindInfo
{
    uint         dwAppDomainId;
    const(PWSTR) lpAssemblyIdentity;
    const(PWSTR) lpModuleName;
}

struct CLR_DEBUGGING_VERSION
{
    ushort wStructVersion;
    ushort wMajor;
    ushort wMinor;
    ushort wBuild;
    ushort wRevision;
}

// Functions

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT GetCORSystemDirectory(PWSTR pbuffer, uint cchBuffer, uint* dwLength);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT GetCORVersion(PWSTR pbBuffer, uint cchBuffer, uint* dwLength);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT GetFileVersion(const(PWSTR) szFilename, PWSTR szBuffer, uint cchBuffer, uint* dwLength);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT GetCORRequiredVersion(PWSTR pbuffer, uint cchBuffer, uint* dwLength);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT GetRequestedRuntimeInfo(const(PWSTR) pExe, const(PWSTR) pwszVersion, const(PWSTR) pConfigurationFile, 
                                uint startupFlags, uint runtimeInfoFlags, PWSTR pDirectory, uint dwDirectory, 
                                uint* dwDirectoryLength, PWSTR pVersion, uint cchBuffer, uint* dwlength);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT GetRequestedRuntimeVersion(PWSTR pExe, PWSTR pVersion, uint cchBuffer, uint* dwLength);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT CorBindToRuntimeHost(const(PWSTR) pwszVersion, const(PWSTR) pwszBuildFlavor, 
                             const(PWSTR) pwszHostConfigFile, void* pReserved, uint startupFlags, 
                             const(GUID)* rclsid, const(GUID)* riid, void** ppv);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT CorBindToRuntimeEx(const(PWSTR) pwszVersion, const(PWSTR) pwszBuildFlavor, uint startupFlags, 
                           const(GUID)* rclsid, const(GUID)* riid, void** ppv);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT CorBindToRuntimeByCfg(IStream pCfgStream, uint reserved, uint startupFlags, const(GUID)* rclsid, 
                              const(GUID)* riid, void** ppv);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT CorBindToRuntime(const(PWSTR) pwszVersion, const(PWSTR) pwszBuildFlavor, const(GUID)* rclsid, 
                         const(GUID)* riid, void** ppv);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT CorBindToCurrentRuntime(const(PWSTR) pwszFileName, const(GUID)* rclsid, const(GUID)* riid, void** ppv);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT ClrCreateManagedInstance(const(PWSTR) pTypeName, const(GUID)* riid, void** ppObject);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
void CorMarkThreadInThreadPool();

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT RunDll32ShimW(HWND hwnd, HINSTANCE hinst, const(PWSTR) lpszCmdLine, int nCmdShow);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT LoadLibraryShim(const(PWSTR) szDllName, const(PWSTR) szVersion, void* pvReserved, HMODULE* phModDll);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT CallFunctionShim(const(PWSTR) szDllName, const(PSTR) szFunctionName, void* lpvArgument1, 
                         void* lpvArgument2, const(PWSTR) szVersion, void* pvReserved);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT GetRealProcAddress(const(PSTR) pwszProcName, void** ppv);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
void CorExitProcess(int exitCode);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT LoadStringRC(uint iResouceID, PWSTR szBuffer, int iMax, int bQuiet);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT LoadStringRCEx(uint lcid, uint iResouceID, PWSTR szBuffer, int iMax, int bQuiet, int* pcwchUsed);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT LockClrVersion(FLockClrVersionCallback hostCallback, FLockClrVersionCallback* pBeginHostSetup, 
                       FLockClrVersionCallback* pEndHostSetup);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT CreateDebuggingInterfaceFromVersion(int iDebuggerVersion, const(PWSTR) szDebuggeeVersion, 
                                            IUnknown* ppCordb);

deprecated("marked as obsolete") 
@DllImport("MSCorEE.dll")
HRESULT GetVersionFromProcess(HANDLE hProcess, PWSTR pVersion, uint cchBuffer, uint* dwLength);

@DllImport("MSCorEE.dll")
HRESULT CorLaunchApplication(HOST_TYPE dwClickOnceHost, const(PWSTR) pwzAppFullName, uint dwManifestPaths, 
                             const(PWSTR)* ppwzManifestPaths, uint dwActivationData, 
                             const(PWSTR)* ppwzActivationData, PROCESS_INFORMATION* lpProcessInformation);

@DllImport("MSCorEE.dll")
HRESULT GetRequestedRuntimeVersionForCLSID(const(GUID)* rclsid, PWSTR pVersion, uint cchBuffer, uint* dwLength, 
                                           CLSID_RESOLUTION_FLAGS dwResolutionFlags);

@DllImport("MSCorEE.dll")
HRESULT GetCLRIdentityManager(const(GUID)* riid, IUnknown* ppManager);

@DllImport("MSCorEE.dll")
HRESULT CLRCreateInstance(const(GUID)* clsid, const(GUID)* riid, void** ppInterface);


// Interfaces

@GUID("3f281000-e95a-11d2-886b-00c04f869f04")
struct ComCallUnmarshal;

@GUID("45fb4600-e6e8-4928-b25e-50476ff79425")
struct ComCallUnmarshalV4;

@GUID("cb2f6723-ab3a-11d2-9c40-00c04fa30a3e")
struct CorRuntimeHost;

@GUID("90f1a06e-7712-4762-86b5-7a5eba6bdb02")
struct CLRRuntimeHost;

@GUID("b81ff171-20f3-11d2-8dcc-00a0c9b00525")
struct TypeNameFactory;

@GUID("fac34f6e-0dcd-47b5-8021-531bc5ecca63")
interface IGCHost : IUnknown
{
    HRESULT SetGCStartupLimits(uint SegmentSize, uint MaxGen0Size);
    HRESULT Collect(int Generation);
    HRESULT GetStats(COR_GC_STATS* pStats);
    HRESULT GetThreadStats(uint* pFiberCookie, COR_GC_THREAD_STATS* pStats);
    HRESULT SetVirtualMemLimit(size_t sztMaxVirtualMemMB);
}

@GUID("a1d70cec-2dbe-4e2f-9291-fdf81438a1df")
interface IGCHost2 : IGCHost
{
    HRESULT SetGCStartupLimitsEx(size_t SegmentSize, size_t MaxGen0Size);
}

@GUID("c460e2b4-e199-412a-8456-84dc3e4838c3")
interface IObjectHandle : IUnknown
{
    HRESULT Unwrap(VARIANT* ppv);
}

@GUID("5c2b07a7-1e98-11d3-872f-00c04f79ed0d")
interface IAppDomainBinding : IUnknown
{
    HRESULT OnAppDomain(IUnknown pAppdomain);
}

@GUID("f31d1788-c397-4725-87a5-6af3472c2791")
interface IGCThreadControl : IUnknown
{
    HRESULT ThreadIsBlockingForSuspension();
    HRESULT SuspensionStarting();
    HRESULT SuspensionEnding(uint Generation);
}

@GUID("5513d564-8374-4cb9-aed9-0083f4160a1d")
interface IGCHostControl : IUnknown
{
    HRESULT RequestVirtualMemLimit(size_t sztMaxVirtualMemMB, size_t* psztNewMaxVirtualMemMB);
}

@GUID("84680d3a-b2c1-46e8-acc2-dbc0a359159a")
interface ICorThreadpool : IUnknown
{
    HRESULT CorRegisterWaitForSingleObject(HANDLE* phNewWaitObject, HANDLE hWaitObject, 
                                           WAITORTIMERCALLBACK Callback, void* Context, uint timeout, 
                                           BOOL executeOnlyOnce, BOOL* result);
    HRESULT CorUnregisterWait(HANDLE hWaitObject, HANDLE CompletionEvent, BOOL* result);
    HRESULT CorQueueUserWorkItem(LPTHREAD_START_ROUTINE Function, void* Context, BOOL executeOnlyOnce, 
                                 BOOL* result);
    HRESULT CorCreateTimer(HANDLE* phNewTimer, WAITORTIMERCALLBACK Callback, void* Parameter, uint DueTime, 
                           uint Period, BOOL* result);
    HRESULT CorChangeTimer(HANDLE Timer, uint DueTime, uint Period, BOOL* result);
    HRESULT CorDeleteTimer(HANDLE Timer, HANDLE CompletionEvent, BOOL* result);
    HRESULT CorBindIoCompletionCallback(HANDLE fileHandle, LPOVERLAPPED_COMPLETION_ROUTINE callback);
    HRESULT CorCallOrQueueUserWorkItem(LPTHREAD_START_ROUTINE Function, void* Context, BOOL* result);
    HRESULT CorSetMaxThreads(uint MaxWorkerThreads, uint MaxIOCompletionThreads);
    HRESULT CorGetMaxThreads(uint* MaxWorkerThreads, uint* MaxIOCompletionThreads);
    HRESULT CorGetAvailableThreads(uint* AvailableWorkerThreads, uint* AvailableIOCompletionThreads);
}

@GUID("23d86786-0bb5-4774-8fb5-e3522add6246")
interface IDebuggerThreadControl : IUnknown
{
    HRESULT ThreadIsBlockingForDebugger();
    HRESULT ReleaseAllRuntimeThreads();
    HRESULT StartBlockingForDebugger(uint dwUnused);
}

@GUID("bf24142d-a47d-4d24-a66d-8c2141944e44")
interface IDebuggerInfo : IUnknown
{
    HRESULT IsDebuggerAttached(BOOL* pbAttached);
}

@GUID("5c2b07a5-1e98-11d3-872f-00c04f79ed0d")
interface ICorConfiguration : IUnknown
{
    HRESULT SetGCThreadControl(IGCThreadControl pGCThreadControl);
    HRESULT SetGCHostControl(IGCHostControl pGCHostControl);
    HRESULT SetDebuggerThreadControl(IDebuggerThreadControl pDebuggerThreadControl);
    HRESULT AddDebuggerSpecialThread(uint dwSpecialThreadId);
}

@GUID("cb2f6722-ab3a-11d2-9c40-00c04fa30a3e")
interface ICorRuntimeHost : IUnknown
{
    HRESULT CreateLogicalThreadState();
    HRESULT DeleteLogicalThreadState();
    HRESULT SwitchInLogicalThreadState(uint* pFiberCookie);
    HRESULT SwitchOutLogicalThreadState(uint** pFiberCookie);
    HRESULT LocksHeldByLogicalThread(uint* pCount);
    HRESULT MapFile(HANDLE hFile, HMODULE* hMapAddress);
    HRESULT GetConfiguration(ICorConfiguration* pConfiguration);
    HRESULT Start();
    HRESULT Stop();
    HRESULT CreateDomain(const(PWSTR) pwzFriendlyName, IUnknown pIdentityArray, IUnknown* pAppDomain);
    HRESULT GetDefaultDomain(IUnknown* pAppDomain);
    HRESULT EnumDomains(void** hEnum);
    HRESULT NextDomain(void* hEnum, IUnknown* pAppDomain);
    HRESULT CloseEnum(void* hEnum);
    HRESULT CreateDomainEx(const(PWSTR) pwzFriendlyName, IUnknown pSetup, IUnknown pEvidence, IUnknown* pAppDomain);
    HRESULT CreateDomainSetup(IUnknown* pAppDomainSetup);
    HRESULT CreateEvidence(IUnknown* pEvidence);
    HRESULT UnloadDomain(IUnknown pAppDomain);
    HRESULT CurrentDomain(IUnknown* pAppDomain);
}

@GUID("47eb8e57-0846-4546-af76-6f42fcfc2649")
interface ICLRMemoryNotificationCallback : IUnknown
{
    HRESULT OnMemoryNotification(EMemoryAvailable eMemoryAvailable);
}

@GUID("1831991c-cc53-4a31-b218-04e910446479")
interface IHostMalloc : IUnknown
{
    HRESULT Alloc(size_t cbSize, EMemoryCriticalLevel eCriticalLevel, void** ppMem);
    HRESULT DebugAlloc(size_t cbSize, EMemoryCriticalLevel eCriticalLevel, ubyte* pszFileName, int iLineNo, 
                       void** ppMem);
    HRESULT Free(void* pMem);
}

@GUID("7bc698d1-f9e3-4460-9cde-d04248e9fa25")
interface IHostMemoryManager : IUnknown
{
    HRESULT CreateMalloc(uint dwMallocType, IHostMalloc* ppMalloc);
    HRESULT VirtualAlloc(void* pAddress, size_t dwSize, uint flAllocationType, uint flProtect, 
                         EMemoryCriticalLevel eCriticalLevel, void** ppMem);
    HRESULT VirtualFree(void* lpAddress, size_t dwSize, uint dwFreeType);
    HRESULT VirtualQuery(void* lpAddress, void* lpBuffer, size_t dwLength, size_t* pResult);
    HRESULT VirtualProtect(void* lpAddress, size_t dwSize, uint flNewProtect, uint* pflOldProtect);
    HRESULT GetMemoryLoad(uint* pMemoryLoad, size_t* pAvailableBytes);
    HRESULT RegisterMemoryNotificationCallback(ICLRMemoryNotificationCallback pCallback);
    HRESULT NeedsVirtualAddressSpace(void* startAddress, size_t size);
    HRESULT AcquiredVirtualAddressSpace(void* startAddress, size_t size);
    HRESULT ReleasedVirtualAddressSpace(void* startAddress);
}

@GUID("28e66a4a-9906-4225-b231-9187c3eb8611")
interface ICLRTask : IUnknown
{
    HRESULT SwitchIn(HANDLE threadHandle);
    HRESULT SwitchOut();
    HRESULT GetMemStats(COR_GC_THREAD_STATS* memUsage);
    HRESULT Reset(BOOL fFull);
    HRESULT ExitTask();
    HRESULT Abort();
    HRESULT RudeAbort();
    HRESULT NeedsPriorityScheduling(BOOL* pbNeedsPriorityScheduling);
    HRESULT YieldTask();
    HRESULT LocksHeld(size_t* pLockCount);
    HRESULT SetTaskIdentifier(ulong asked);
}

@GUID("28e66a4a-9906-4225-b231-9187c3eb8612")
interface ICLRTask2 : ICLRTask
{
    HRESULT BeginPreventAsyncAbort();
    HRESULT EndPreventAsyncAbort();
}

@GUID("c2275828-c4b1-4b55-82c9-92135f74df1a")
interface IHostTask : IUnknown
{
    HRESULT Start();
    HRESULT Alert();
    HRESULT Join(uint dwMilliseconds, uint option);
    HRESULT SetPriority(int newPriority);
    HRESULT GetPriority(int* pPriority);
    HRESULT SetCLRTask(ICLRTask pCLRTask);
}

@GUID("4862efbe-3ae5-44f8-8feb-346190ee8a34")
interface ICLRTaskManager : IUnknown
{
    HRESULT CreateTask(ICLRTask* pTask);
    HRESULT GetCurrentTask(ICLRTask* pTask);
    HRESULT SetUILocale(uint lcid);
    HRESULT SetLocale(uint lcid);
    HRESULT GetCurrentTaskType(ETaskType* pTaskType);
}

@GUID("997ff24c-43b7-4352-8667-0dc04fafd354")
interface IHostTaskManager : IUnknown
{
    HRESULT GetCurrentTask(IHostTask* pTask);
    HRESULT CreateTask(uint dwStackSize, LPTHREAD_START_ROUTINE pStartAddress, void* pParameter, IHostTask* ppTask);
    HRESULT Sleep(uint dwMilliseconds, uint option);
    HRESULT SwitchToTask(uint option);
    HRESULT SetUILocale(uint lcid);
    HRESULT SetLocale(uint lcid);
    HRESULT CallNeedsHostHook(size_t target, BOOL* pbCallNeedsHostHook);
    HRESULT LeaveRuntime(size_t target);
    HRESULT EnterRuntime();
    HRESULT ReverseLeaveRuntime();
    HRESULT ReverseEnterRuntime();
    HRESULT BeginDelayAbort();
    HRESULT EndDelayAbort();
    HRESULT BeginThreadAffinity();
    HRESULT EndThreadAffinity();
    HRESULT SetStackGuarantee(uint guarantee);
    HRESULT GetStackGuarantee(uint* pGuarantee);
    HRESULT SetCLRTaskManager(ICLRTaskManager ppManager);
}

@GUID("983d50e2-cb15-466b-80fc-845dc6e8c5fd")
interface IHostThreadpoolManager : IUnknown
{
    HRESULT QueueUserWorkItem(LPTHREAD_START_ROUTINE Function, void* Context, uint Flags);
    HRESULT SetMaxThreads(uint dwMaxWorkerThreads);
    HRESULT GetMaxThreads(uint* pdwMaxWorkerThreads);
    HRESULT GetAvailableThreads(uint* pdwAvailableWorkerThreads);
    HRESULT SetMinThreads(uint dwMinIOCompletionThreads);
    HRESULT GetMinThreads(uint* pdwMinIOCompletionThreads);
}

@GUID("2d74ce86-b8d6-4c84-b3a7-9768933b3c12")
interface ICLRIoCompletionManager : IUnknown
{
    HRESULT OnComplete(uint dwErrorCode, uint NumberOfBytesTransferred, void* pvOverlapped);
}

@GUID("8bde9d80-ec06-41d6-83e6-22580effcc20")
interface IHostIoCompletionManager : IUnknown
{
    HRESULT CreateIoCompletionPort(HANDLE* phPort);
    HRESULT CloseIoCompletionPort(HANDLE hPort);
    HRESULT SetMaxThreads(uint dwMaxIOCompletionThreads);
    HRESULT GetMaxThreads(uint* pdwMaxIOCompletionThreads);
    HRESULT GetAvailableThreads(uint* pdwAvailableIOCompletionThreads);
    HRESULT GetHostOverlappedSize(uint* pcbSize);
    HRESULT SetCLRIoCompletionManager(ICLRIoCompletionManager pManager);
    HRESULT InitializeHostOverlapped(void* pvOverlapped);
    HRESULT Bind(HANDLE hPort, HANDLE hHandle);
    HRESULT SetMinThreads(uint dwMinIOCompletionThreads);
    HRESULT GetMinThreads(uint* pdwMinIOCompletionThreads);
}

@GUID("00dcaec6-2ac0-43a9-acf9-1e36c139b10d")
interface ICLRDebugManager : IUnknown
{
    HRESULT BeginConnection(uint dwConnectionId, PWSTR szConnectionName);
    HRESULT SetConnectionTasks(uint id, uint dwCount, ICLRTask* ppCLRTask);
    HRESULT EndConnection(uint dwConnectionId);
    HRESULT SetDacl(ACL* pacl);
    HRESULT GetDacl(ACL** pacl);
    HRESULT IsDebuggerAttached(BOOL* pbAttached);
    HRESULT SetSymbolReadingPolicy(ESymbolReadingPolicy policy);
}

@GUID("980d2f1a-bf79-4c08-812a-bb9778928f78")
interface ICLRErrorReportingManager : IUnknown
{
    HRESULT GetBucketParametersForCurrentException(BucketParameters* pParams);
    HRESULT BeginCustomDump(ECustomDumpFlavor dwFlavor, uint dwNumItems, CustomDumpItem* items, uint dwReserved);
    HRESULT EndCustomDump();
}

@GUID("6df710a6-26a4-4a65-8cd5-7237b8bda8dc")
interface IHostCrst : IUnknown
{
    HRESULT Enter(uint option);
    HRESULT Leave();
    HRESULT TryEnter(uint option, BOOL* pbSucceeded);
    HRESULT SetSpinCount(uint dwSpinCount);
}

@GUID("50b0cfce-4063-4278-9673-e5cb4ed0bdb8")
interface IHostAutoEvent : IUnknown
{
    HRESULT Wait(uint dwMilliseconds, uint option);
    HRESULT Set();
}

@GUID("1bf4ec38-affe-4fb9-85a6-525268f15b54")
interface IHostManualEvent : IUnknown
{
    HRESULT Wait(uint dwMilliseconds, uint option);
    HRESULT Reset();
    HRESULT Set();
}

@GUID("855efd47-cc09-463a-a97d-16acab882661")
interface IHostSemaphore : IUnknown
{
    HRESULT Wait(uint dwMilliseconds, uint option);
    HRESULT ReleaseSemaphore(int lReleaseCount, int* lpPreviousCount);
}

@GUID("55ff199d-ad21-48f9-a16c-f24ebbb8727d")
interface ICLRSyncManager : IUnknown
{
    HRESULT GetMonitorOwner(size_t Cookie, IHostTask* ppOwnerHostTask);
    HRESULT CreateRWLockOwnerIterator(size_t Cookie, size_t* pIterator);
    HRESULT GetRWLockOwnerNext(size_t Iterator, IHostTask* ppOwnerHostTask);
    HRESULT DeleteRWLockOwnerIterator(size_t Iterator);
}

@GUID("234330c7-5f10-4f20-9615-5122dab7a0ac")
interface IHostSyncManager : IUnknown
{
    HRESULT SetCLRSyncManager(ICLRSyncManager pManager);
    HRESULT CreateCrst(IHostCrst* ppCrst);
    HRESULT CreateCrstWithSpinCount(uint dwSpinCount, IHostCrst* ppCrst);
    HRESULT CreateAutoEvent(IHostAutoEvent* ppEvent);
    HRESULT CreateManualEvent(BOOL bInitialState, IHostManualEvent* ppEvent);
    HRESULT CreateMonitorEvent(size_t Cookie, IHostAutoEvent* ppEvent);
    HRESULT CreateRWLockWriterEvent(size_t Cookie, IHostAutoEvent* ppEvent);
    HRESULT CreateRWLockReaderEvent(BOOL bInitialState, size_t Cookie, IHostManualEvent* ppEvent);
    HRESULT CreateSemaphoreA(uint dwInitial, uint dwMax, IHostSemaphore* ppSemaphore);
}

@GUID("7d290010-d781-45da-a6f8-aa5d711a730e")
interface ICLRPolicyManager : IUnknown
{
    HRESULT SetDefaultAction(EClrOperation operation, EPolicyAction action);
    HRESULT SetTimeout(EClrOperation operation, uint dwMilliseconds);
    HRESULT SetActionOnTimeout(EClrOperation operation, EPolicyAction action);
    HRESULT SetTimeoutAndAction(EClrOperation operation, uint dwMilliseconds, EPolicyAction action);
    HRESULT SetActionOnFailure(EClrFailure failure, EPolicyAction action);
    HRESULT SetUnhandledExceptionPolicy(EClrUnhandledException policy);
}

@GUID("7ae49844-b1e3-4683-ba7c-1e8212ea3b79")
interface IHostPolicyManager : IUnknown
{
    HRESULT OnDefaultAction(EClrOperation operation, EPolicyAction action);
    HRESULT OnTimeout(EClrOperation operation, EPolicyAction action);
    HRESULT OnFailure(EClrFailure failure, EPolicyAction action);
}

@GUID("607be24b-d91b-4e28-a242-61871ce56e35")
interface IActionOnCLREvent : IUnknown
{
    HRESULT OnEvent(EClrEvent event, void* data);
}

@GUID("1d0e0132-e64f-493d-9260-025c0e32c175")
interface ICLROnEventManager : IUnknown
{
    HRESULT RegisterActionOnEvent(EClrEvent event, IActionOnCLREvent pAction);
    HRESULT UnregisterActionOnEvent(EClrEvent event, IActionOnCLREvent pAction);
}

@GUID("5d4ec34e-f248-457b-b603-255faaba0d21")
interface IHostGCManager : IUnknown
{
    HRESULT ThreadIsBlockingForSuspension();
    HRESULT SuspensionStarting();
    HRESULT SuspensionEnding(uint Generation);
}

@GUID("1b2c9750-2e66-4bda-8b44-0a642c5cd733")
interface ICLRAssemblyReferenceList : IUnknown
{
    HRESULT IsStringAssemblyReferenceInList(const(PWSTR) pwzAssemblyName);
    HRESULT IsAssemblyReferenceInList(IUnknown pName);
}

@GUID("d509cb5d-cf32-4876-ae61-67770cf91973")
interface ICLRReferenceAssemblyEnum : IUnknown
{
    HRESULT Get(uint dwIndex, PWSTR pwzBuffer, uint* pcchBufferSize);
}

@GUID("d0c5fb1f-416b-4f97-81f4-7ac7dc24dd5d")
interface ICLRProbingAssemblyEnum : IUnknown
{
    HRESULT Get(uint dwIndex, PWSTR pwzBuffer, uint* pcchBufferSize);
}

@GUID("15f0a9da-3ff6-4393-9da9-fdfd284e6972")
interface ICLRAssemblyIdentityManager : IUnknown
{
    HRESULT GetCLRAssemblyReferenceList(const(PWSTR)* ppwzAssemblyReferences, uint dwNumOfReferences, 
                                        ICLRAssemblyReferenceList* ppReferenceList);
    HRESULT GetBindingIdentityFromFile(const(PWSTR) pwzFilePath, uint dwFlags, PWSTR pwzBuffer, 
                                       uint* pcchBufferSize);
    HRESULT GetBindingIdentityFromStream(IStream pStream, uint dwFlags, PWSTR pwzBuffer, uint* pcchBufferSize);
    HRESULT GetReferencedAssembliesFromFile(const(PWSTR) pwzFilePath, uint dwFlags, 
                                            ICLRAssemblyReferenceList pExcludeAssembliesList, 
                                            ICLRReferenceAssemblyEnum* ppReferenceEnum);
    HRESULT GetReferencedAssembliesFromStream(IStream pStream, uint dwFlags, 
                                              ICLRAssemblyReferenceList pExcludeAssembliesList, 
                                              ICLRReferenceAssemblyEnum* ppReferenceEnum);
    HRESULT GetProbingAssembliesFromReference(uint dwMachineType, uint dwFlags, const(PWSTR) pwzReferenceIdentity, 
                                              ICLRProbingAssemblyEnum* ppProbingAssemblyEnum);
    HRESULT IsStronglyNamed(const(PWSTR) pwzAssemblyIdentity, BOOL* pbIsStronglyNamed);
}

@GUID("4b3545e7-1856-48c9-a8ba-24b21a753c09")
interface ICLRHostBindingPolicyManager : IUnknown
{
    HRESULT ModifyApplicationPolicy(const(PWSTR) pwzSourceAssemblyIdentity, const(PWSTR) pwzTargetAssemblyIdentity, 
                                    ubyte* pbApplicationPolicy, uint cbAppPolicySize, uint dwPolicyModifyFlags, 
                                    ubyte* pbNewApplicationPolicy, uint* pcbNewAppPolicySize);
    HRESULT EvaluatePolicy(const(PWSTR) pwzReferenceIdentity, ubyte* pbApplicationPolicy, uint cbAppPolicySize, 
                           PWSTR pwzPostPolicyReferenceIdentity, uint* pcchPostPolicyReferenceIdentity, 
                           uint* pdwPoliciesApplied);
}

@GUID("54d9007e-a8e2-4885-b7bf-f998deee4f2a")
interface ICLRGCManager : IUnknown
{
    HRESULT Collect(int Generation);
    HRESULT GetStats(COR_GC_STATS* pStats);
    HRESULT SetGCStartupLimits(uint SegmentSize, uint MaxGen0Size);
}

@GUID("0603b793-a97a-4712-9cb4-0cd1c74c0f7c")
interface ICLRGCManager2 : ICLRGCManager
{
    HRESULT SetGCStartupLimitsEx(size_t SegmentSize, size_t MaxGen0Size);
}

@GUID("7b102a88-3f7f-496d-8fa2-c35374e01af3")
interface IHostAssemblyStore : IUnknown
{
    HRESULT ProvideAssembly(AssemblyBindInfo* pBindInfo, ulong* pAssemblyId, ulong* pContext, 
                            IStream* ppStmAssemblyImage, IStream* ppStmPDB);
    HRESULT ProvideModule(ModuleBindInfo* pBindInfo, uint* pdwModuleId, IStream* ppStmModuleImage, 
                          IStream* ppStmPDB);
}

@GUID("613dabd7-62b2-493e-9e65-c1e32a1e0c5e")
interface IHostAssemblyManager : IUnknown
{
    HRESULT GetNonHostStoreAssemblies(ICLRAssemblyReferenceList* ppReferenceList);
    HRESULT GetAssemblyStore(IHostAssemblyStore* ppAssemblyStore);
}

@GUID("02ca073c-7079-4860-880a-c2f7a449c991")
interface IHostControl : IUnknown
{
    HRESULT GetHostManager(const(GUID)* riid, void** ppObject);
    HRESULT SetAppDomainManager(uint dwAppDomainID, IUnknown pUnkAppDomainManager);
}

@GUID("9065597e-d1a1-4fb2-b6ba-7e1fce230f61")
interface ICLRControl : IUnknown
{
    HRESULT GetCLRManager(const(GUID)* riid, void** ppObject);
    HRESULT SetAppDomainManagerType(const(PWSTR) pwzAppDomainManagerAssembly, const(PWSTR) pwzAppDomainManagerType);
}

@GUID("90f1a06c-7712-4762-86b5-7a5eba6bdb02")
interface ICLRRuntimeHost : IUnknown
{
    HRESULT Start();
    HRESULT Stop();
    HRESULT SetHostControl(IHostControl pHostControl);
    HRESULT GetCLRControl(ICLRControl* pCLRControl);
    HRESULT UnloadAppDomain(uint dwAppDomainId, BOOL fWaitUntilDone);
    HRESULT ExecuteInAppDomain(uint dwAppDomainId, FExecuteInAppDomainCallback pCallback, void* cookie);
    HRESULT GetCurrentAppDomainId(uint* pdwAppDomainId);
    HRESULT ExecuteApplication(const(PWSTR) pwzAppFullName, uint dwManifestPaths, const(PWSTR)* ppwzManifestPaths, 
                               uint dwActivationData, const(PWSTR)* ppwzActivationData, int* pReturnValue);
    HRESULT ExecuteInDefaultAppDomain(const(PWSTR) pwzAssemblyPath, const(PWSTR) pwzTypeName, 
                                      const(PWSTR) pwzMethodName, const(PWSTR) pwzArgument, uint* pReturnValue);
}

@GUID("89f25f5c-ceef-43e1-9cfa-a68ce863aaac")
interface ICLRHostProtectionManager : IUnknown
{
    HRESULT SetProtectedCategories(EApiCategories categories);
    HRESULT SetEagerSerializeGrantSets();
}

@GUID("270d00a2-8e15-4d0b-adeb-37bc3e47df77")
interface ICLRDomainManager : IUnknown
{
    HRESULT SetAppDomainManagerType(const(PWSTR) wszAppDomainManagerAssembly, const(PWSTR) wszAppDomainManagerType, 
                                    EInitializeNewDomainFlags dwInitializeDomainFlags);
    HRESULT SetPropertiesForDefaultAppDomain(uint nProperties, const(PWSTR)* pwszPropertyNames, 
                                             const(PWSTR)* pwszPropertyValues);
}

@GUID("b81ff171-20f3-11d2-8dcc-00a0c9b00522")
interface ITypeName : IUnknown
{
    HRESULT GetNameCount(uint* pCount);
    HRESULT GetNames(uint count, BSTR* rgbszNames, uint* pCount);
    HRESULT GetTypeArgumentCount(uint* pCount);
    HRESULT GetTypeArguments(uint count, ITypeName* rgpArguments, uint* pCount);
    HRESULT GetModifierLength(uint* pCount);
    HRESULT GetModifiers(uint count, uint* rgModifiers, uint* pCount);
    HRESULT GetAssemblyName(BSTR* rgbszAssemblyNames);
}

@GUID("b81ff171-20f3-11d2-8dcc-00a0c9b00523")
interface ITypeNameBuilder : IUnknown
{
    HRESULT OpenGenericArguments();
    HRESULT CloseGenericArguments();
    HRESULT OpenGenericArgument();
    HRESULT CloseGenericArgument();
    HRESULT AddName(const(PWSTR) szName);
    HRESULT AddPointer();
    HRESULT AddByRef();
    HRESULT AddSzArray();
    HRESULT AddArray(uint rank);
    HRESULT AddAssemblySpec(const(PWSTR) szAssemblySpec);
    HRESULT ToString(BSTR* pszStringRepresentation);
    HRESULT Clear();
}

@GUID("b81ff171-20f3-11d2-8dcc-00a0c9b00521")
interface ITypeNameFactory : IUnknown
{
    HRESULT ParseTypeName(const(PWSTR) szName, uint* pError, ITypeName* ppTypeName);
    HRESULT GetTypeNameBuilder(ITypeNameBuilder* ppTypeBuilder);
}

@GUID("178e5337-1528-4591-b1c9-1c6e484686d8")
interface IApartmentCallback : IUnknown
{
    HRESULT DoCallback(size_t pFunc, size_t pData);
}

@GUID("c3fcc19e-a970-11d2-8b5a-00a0c9b7c9c4")
interface IManagedObject : IUnknown
{
    HRESULT GetSerializedBuffer(BSTR* pBSTR);
    HRESULT GetObjectIdentity(BSTR* pBSTRGUID, int* AppDomainID, int* pCCW);
}

@GUID("04c6be1e-1db1-4058-ab7a-700cccfbf254")
interface ICatalogServices : IUnknown
{
    HRESULT Autodone();
    HRESULT NotAutodone();
}

@GUID("7e573ce4-0343-4423-98d7-6318348a1d3c")
interface IHostSecurityContext : IUnknown
{
    HRESULT Capture(IHostSecurityContext* ppClonedContext);
}

@GUID("75ad2468-a349-4d02-a764-76a68aee0c4f")
interface IHostSecurityManager : IUnknown
{
    HRESULT ImpersonateLoggedOnUser(HANDLE hToken);
    HRESULT RevertToSelf();
    HRESULT OpenThreadToken(uint dwDesiredAccess, BOOL bOpenAsSelf, HANDLE* phThreadToken);
    HRESULT SetThreadToken(HANDLE hToken);
    HRESULT GetSecurityContext(EContextType eContextType, IHostSecurityContext* ppSecurityContext);
    HRESULT SetSecurityContext(EContextType eContextType, IHostSecurityContext pSecurityContext);
}

@GUID("c62de18c-2e23-4aea-8423-b40c1fc59eae")
interface ICLRAppDomainResourceMonitor : IUnknown
{
    HRESULT GetCurrentAllocated(uint dwAppDomainId, ulong* pBytesAllocated);
    HRESULT GetCurrentSurvived(uint dwAppDomainId, ulong* pAppDomainBytesSurvived, ulong* pTotalBytesSurvived);
    HRESULT GetCurrentCpuTime(uint dwAppDomainId, ulong* pMilliseconds);
}

@GUID("d332db9e-b9b3-4125-8207-a14884f53216")
interface ICLRMetaHost : IUnknown
{
    HRESULT GetRuntime(const(PWSTR) pwzVersion, const(GUID)* riid, void** ppRuntime);
    HRESULT GetVersionFromFile(const(PWSTR) pwzFilePath, PWSTR pwzBuffer, uint* pcchBuffer);
    HRESULT EnumerateInstalledRuntimes(IEnumUnknown* ppEnumerator);
    HRESULT EnumerateLoadedRuntimes(HANDLE hndProcess, IEnumUnknown* ppEnumerator);
    HRESULT RequestRuntimeLoadedNotification(RuntimeLoadedCallbackFnPtr pCallbackFunction);
    HRESULT QueryLegacyV2RuntimeBinding(const(GUID)* riid, void** ppUnk);
    HRESULT ExitProcess(int iExitCode);
}

@GUID("e2190695-77b2-492e-8e14-c4b3a7fdd593")
interface ICLRMetaHostPolicy : IUnknown
{
    HRESULT GetRequestedRuntime(METAHOST_POLICY_FLAGS dwPolicyFlags, const(PWSTR) pwzBinary, IStream pCfgStream, 
                                PWSTR pwzVersion, uint* pcchVersion, PWSTR pwzImageVersion, uint* pcchImageVersion, 
                                uint* pdwConfigFlags, const(GUID)* riid, void** ppRuntime);
}

@GUID("b349abe3-b56f-4689-bfcd-76bf39d888ea")
interface ICLRProfiling : IUnknown
{
    HRESULT AttachProfiler(uint dwProfileeProcessID, uint dwMillisecondsMax, const(GUID)* pClsidProfiler, 
                           const(PWSTR) wszProfilerPath, void* pvClientData, uint cbClientData);
}

@GUID("3151c08d-4d09-4f9b-8838-2880bf18fe51")
interface ICLRDebuggingLibraryProvider : IUnknown
{
    HRESULT ProvideLibrary(const(PWSTR) pwszFileName, uint dwTimestamp, uint dwSizeOfImage, HMODULE* phModule);
}

@GUID("d28f3c5a-9634-4206-a509-477552eefb10")
interface ICLRDebugging : IUnknown
{
    HRESULT OpenVirtualProcess(ulong moduleBaseAddress, IUnknown pDataTarget, 
                               ICLRDebuggingLibraryProvider pLibraryProvider, 
                               CLR_DEBUGGING_VERSION* pMaxDebuggerSupportedVersion, const(GUID)* riidProcess, 
                               IUnknown* ppProcess, CLR_DEBUGGING_VERSION* pVersion, 
                               CLR_DEBUGGING_PROCESS_FLAGS* pdwFlags);
    HRESULT CanUnloadNow(HMODULE hModule);
}

@GUID("bd39d1d2-ba2f-486a-89b0-b4b0cb466891")
interface ICLRRuntimeInfo : IUnknown
{
    HRESULT GetVersionString(PWSTR pwzBuffer, uint* pcchBuffer);
    HRESULT GetRuntimeDirectory(PWSTR pwzBuffer, uint* pcchBuffer);
    HRESULT IsLoaded(HANDLE hndProcess, BOOL* pbLoaded);
    HRESULT LoadErrorString(uint iResourceID, PWSTR pwzBuffer, uint* pcchBuffer, int iLocaleID);
    HRESULT LoadLibraryA(const(PWSTR) pwzDllName, HMODULE* phndModule);
    HRESULT GetProcAddress(const(PSTR) pszProcName, void** ppProc);
    HRESULT GetInterface(const(GUID)* rclsid, const(GUID)* riid, void** ppUnk);
    HRESULT IsLoadable(BOOL* pbLoadable);
    HRESULT SetDefaultStartupFlags(uint dwStartupFlags, const(PWSTR) pwzHostConfigFile);
    HRESULT GetDefaultStartupFlags(uint* pdwStartupFlags, PWSTR pwzHostConfigFile, uint* pcchHostConfigFile);
    HRESULT BindAsLegacyV2Runtime();
    HRESULT IsStarted(BOOL* pbStarted, uint* pdwStartupFlags);
}

@GUID("9fd93ccf-3280-4391-b3a9-96e1cde77c8d")
interface ICLRStrongName : IUnknown
{
    HRESULT GetHashFromAssemblyFile(const(PSTR) pszFilePath, uint* piHashAlg, ubyte* pbHash, uint cchHash, 
                                    uint* pchHash);
    HRESULT GetHashFromAssemblyFileW(const(PWSTR) pwzFilePath, uint* piHashAlg, ubyte* pbHash, uint cchHash, 
                                     uint* pchHash);
    HRESULT GetHashFromBlob(ubyte* pbBlob, uint cchBlob, uint* piHashAlg, ubyte* pbHash, uint cchHash, 
                            uint* pchHash);
    HRESULT GetHashFromFile(const(PSTR) pszFilePath, uint* piHashAlg, ubyte* pbHash, uint cchHash, uint* pchHash);
    HRESULT GetHashFromFileW(const(PWSTR) pwzFilePath, uint* piHashAlg, ubyte* pbHash, uint cchHash, uint* pchHash);
    HRESULT GetHashFromHandle(HANDLE hFile, uint* piHashAlg, ubyte* pbHash, uint cchHash, uint* pchHash);
    HRESULT StrongNameCompareAssemblies(const(PWSTR) pwzAssembly1, const(PWSTR) pwzAssembly2, uint* pdwResult);
    HRESULT StrongNameFreeBuffer(ubyte* pbMemory);
    HRESULT StrongNameGetBlob(const(PWSTR) pwzFilePath, ubyte* pbBlob, uint* pcbBlob);
    HRESULT StrongNameGetBlobFromImage(ubyte* pbBase, uint dwLength, ubyte* pbBlob, uint* pcbBlob);
    HRESULT StrongNameGetPublicKey(const(PWSTR) pwzKeyContainer, ubyte* pbKeyBlob, uint cbKeyBlob, 
                                   ubyte** ppbPublicKeyBlob, uint* pcbPublicKeyBlob);
    HRESULT StrongNameHashSize(uint ulHashAlg, uint* pcbSize);
    HRESULT StrongNameKeyDelete(const(PWSTR) pwzKeyContainer);
    HRESULT StrongNameKeyGen(const(PWSTR) pwzKeyContainer, uint dwFlags, ubyte** ppbKeyBlob, uint* pcbKeyBlob);
    HRESULT StrongNameKeyGenEx(const(PWSTR) pwzKeyContainer, uint dwFlags, uint dwKeySize, ubyte** ppbKeyBlob, 
                               uint* pcbKeyBlob);
    HRESULT StrongNameKeyInstall(const(PWSTR) pwzKeyContainer, ubyte* pbKeyBlob, uint cbKeyBlob);
    HRESULT StrongNameSignatureGeneration(const(PWSTR) pwzFilePath, const(PWSTR) pwzKeyContainer, ubyte* pbKeyBlob, 
                                          uint cbKeyBlob, ubyte** ppbSignatureBlob, uint* pcbSignatureBlob);
    HRESULT StrongNameSignatureGenerationEx(const(PWSTR) wszFilePath, const(PWSTR) wszKeyContainer, 
                                            ubyte* pbKeyBlob, uint cbKeyBlob, ubyte** ppbSignatureBlob, 
                                            uint* pcbSignatureBlob, uint dwFlags);
    HRESULT StrongNameSignatureSize(ubyte* pbPublicKeyBlob, uint cbPublicKeyBlob, uint* pcbSize);
    HRESULT StrongNameSignatureVerification(const(PWSTR) pwzFilePath, uint dwInFlags, uint* pdwOutFlags);
    HRESULT StrongNameSignatureVerificationEx(const(PWSTR) pwzFilePath, BOOLEAN fForceVerification, 
                                              ubyte* pfWasVerified);
    HRESULT StrongNameSignatureVerificationFromImage(ubyte* pbBase, uint dwLength, uint dwInFlags, 
                                                     uint* pdwOutFlags);
    HRESULT StrongNameTokenFromAssembly(const(PWSTR) pwzFilePath, ubyte** ppbStrongNameToken, 
                                        uint* pcbStrongNameToken);
    HRESULT StrongNameTokenFromAssemblyEx(const(PWSTR) pwzFilePath, ubyte** ppbStrongNameToken, 
                                          uint* pcbStrongNameToken, ubyte** ppbPublicKeyBlob, uint* pcbPublicKeyBlob);
    HRESULT StrongNameTokenFromPublicKey(ubyte* pbPublicKeyBlob, uint cbPublicKeyBlob, ubyte** ppbStrongNameToken, 
                                         uint* pcbStrongNameToken);
}

@GUID("c22ed5c5-4b59-4975-90eb-85ea55c0069b")
interface ICLRStrongName2 : IUnknown
{
    HRESULT StrongNameGetPublicKeyEx(const(PWSTR) pwzKeyContainer, ubyte* pbKeyBlob, uint cbKeyBlob, 
                                     ubyte** ppbPublicKeyBlob, uint* pcbPublicKeyBlob, uint uHashAlgId, 
                                     uint uReserved);
    HRESULT StrongNameSignatureVerificationEx2(const(PWSTR) wszFilePath, BOOLEAN fForceVerification, 
                                               ubyte* pbEcmaPublicKey, uint cbEcmaPublicKey, ubyte* pfWasVerified);
}

@GUID("22c7089b-bbd3-414a-b698-210f263f1fed")
interface ICLRStrongName3 : IUnknown
{
    HRESULT StrongNameDigestGenerate(const(PWSTR) wszFilePath, ubyte** ppbDigestBlob, uint* pcbDigestBlob, 
                                     uint dwFlags);
    HRESULT StrongNameDigestSign(const(PWSTR) wszKeyContainer, ubyte* pbKeyBlob, uint cbKeyBlob, 
                                 ubyte* pbDigestBlob, uint cbDigestBlob, uint hashAlgId, ubyte** ppbSignatureBlob, 
                                 uint* pcbSignatureBlob, uint dwFlags);
    HRESULT StrongNameDigestEmbed(const(PWSTR) wszFilePath, ubyte* pbSignatureBlob, uint cbSignatureBlob);
}


// GUIDs

const GUID CLSID_CLRRuntimeHost     = GUIDOF!CLRRuntimeHost;
const GUID CLSID_ComCallUnmarshal   = GUIDOF!ComCallUnmarshal;
const GUID CLSID_ComCallUnmarshalV4 = GUIDOF!ComCallUnmarshalV4;
const GUID CLSID_CorRuntimeHost     = GUIDOF!CorRuntimeHost;
const GUID CLSID_TypeNameFactory    = GUIDOF!TypeNameFactory;

const GUID IID_IActionOnCLREvent              = GUIDOF!IActionOnCLREvent;
const GUID IID_IApartmentCallback             = GUIDOF!IApartmentCallback;
const GUID IID_IAppDomainBinding              = GUIDOF!IAppDomainBinding;
const GUID IID_ICLRAppDomainResourceMonitor   = GUIDOF!ICLRAppDomainResourceMonitor;
const GUID IID_ICLRAssemblyIdentityManager    = GUIDOF!ICLRAssemblyIdentityManager;
const GUID IID_ICLRAssemblyReferenceList      = GUIDOF!ICLRAssemblyReferenceList;
const GUID IID_ICLRControl                    = GUIDOF!ICLRControl;
const GUID IID_ICLRDebugManager               = GUIDOF!ICLRDebugManager;
const GUID IID_ICLRDebugging                  = GUIDOF!ICLRDebugging;
const GUID IID_ICLRDebuggingLibraryProvider   = GUIDOF!ICLRDebuggingLibraryProvider;
const GUID IID_ICLRDomainManager              = GUIDOF!ICLRDomainManager;
const GUID IID_ICLRErrorReportingManager      = GUIDOF!ICLRErrorReportingManager;
const GUID IID_ICLRGCManager                  = GUIDOF!ICLRGCManager;
const GUID IID_ICLRGCManager2                 = GUIDOF!ICLRGCManager2;
const GUID IID_ICLRHostBindingPolicyManager   = GUIDOF!ICLRHostBindingPolicyManager;
const GUID IID_ICLRHostProtectionManager      = GUIDOF!ICLRHostProtectionManager;
const GUID IID_ICLRIoCompletionManager        = GUIDOF!ICLRIoCompletionManager;
const GUID IID_ICLRMemoryNotificationCallback = GUIDOF!ICLRMemoryNotificationCallback;
const GUID IID_ICLRMetaHost                   = GUIDOF!ICLRMetaHost;
const GUID IID_ICLRMetaHostPolicy             = GUIDOF!ICLRMetaHostPolicy;
const GUID IID_ICLROnEventManager             = GUIDOF!ICLROnEventManager;
const GUID IID_ICLRPolicyManager              = GUIDOF!ICLRPolicyManager;
const GUID IID_ICLRProbingAssemblyEnum        = GUIDOF!ICLRProbingAssemblyEnum;
const GUID IID_ICLRProfiling                  = GUIDOF!ICLRProfiling;
const GUID IID_ICLRReferenceAssemblyEnum      = GUIDOF!ICLRReferenceAssemblyEnum;
const GUID IID_ICLRRuntimeHost                = GUIDOF!ICLRRuntimeHost;
const GUID IID_ICLRRuntimeInfo                = GUIDOF!ICLRRuntimeInfo;
const GUID IID_ICLRStrongName                 = GUIDOF!ICLRStrongName;
const GUID IID_ICLRStrongName2                = GUIDOF!ICLRStrongName2;
const GUID IID_ICLRStrongName3                = GUIDOF!ICLRStrongName3;
const GUID IID_ICLRSyncManager                = GUIDOF!ICLRSyncManager;
const GUID IID_ICLRTask                       = GUIDOF!ICLRTask;
const GUID IID_ICLRTask2                      = GUIDOF!ICLRTask2;
const GUID IID_ICLRTaskManager                = GUIDOF!ICLRTaskManager;
const GUID IID_ICatalogServices               = GUIDOF!ICatalogServices;
const GUID IID_ICorConfiguration              = GUIDOF!ICorConfiguration;
const GUID IID_ICorRuntimeHost                = GUIDOF!ICorRuntimeHost;
const GUID IID_ICorThreadpool                 = GUIDOF!ICorThreadpool;
const GUID IID_IDebuggerInfo                  = GUIDOF!IDebuggerInfo;
const GUID IID_IDebuggerThreadControl         = GUIDOF!IDebuggerThreadControl;
const GUID IID_IGCHost                        = GUIDOF!IGCHost;
const GUID IID_IGCHost2                       = GUIDOF!IGCHost2;
const GUID IID_IGCHostControl                 = GUIDOF!IGCHostControl;
const GUID IID_IGCThreadControl               = GUIDOF!IGCThreadControl;
const GUID IID_IHostAssemblyManager           = GUIDOF!IHostAssemblyManager;
const GUID IID_IHostAssemblyStore             = GUIDOF!IHostAssemblyStore;
const GUID IID_IHostAutoEvent                 = GUIDOF!IHostAutoEvent;
const GUID IID_IHostControl                   = GUIDOF!IHostControl;
const GUID IID_IHostCrst                      = GUIDOF!IHostCrst;
const GUID IID_IHostGCManager                 = GUIDOF!IHostGCManager;
const GUID IID_IHostIoCompletionManager       = GUIDOF!IHostIoCompletionManager;
const GUID IID_IHostMalloc                    = GUIDOF!IHostMalloc;
const GUID IID_IHostManualEvent               = GUIDOF!IHostManualEvent;
const GUID IID_IHostMemoryManager             = GUIDOF!IHostMemoryManager;
const GUID IID_IHostPolicyManager             = GUIDOF!IHostPolicyManager;
const GUID IID_IHostSecurityContext           = GUIDOF!IHostSecurityContext;
const GUID IID_IHostSecurityManager           = GUIDOF!IHostSecurityManager;
const GUID IID_IHostSemaphore                 = GUIDOF!IHostSemaphore;
const GUID IID_IHostSyncManager               = GUIDOF!IHostSyncManager;
const GUID IID_IHostTask                      = GUIDOF!IHostTask;
const GUID IID_IHostTaskManager               = GUIDOF!IHostTaskManager;
const GUID IID_IHostThreadpoolManager         = GUIDOF!IHostThreadpoolManager;
const GUID IID_IManagedObject                 = GUIDOF!IManagedObject;
const GUID IID_IObjectHandle                  = GUIDOF!IObjectHandle;
const GUID IID_ITypeName                      = GUIDOF!ITypeName;
const GUID IID_ITypeNameBuilder               = GUIDOF!ITypeNameBuilder;
const GUID IID_ITypeNameFactory               = GUIDOF!ITypeNameFactory;
