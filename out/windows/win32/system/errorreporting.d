// Written in the D programming language.

module windows.win32.system.errorreporting;

public import windows.core;
public import windows.win32.foundation : BOOL, FILETIME, HANDLE, HRESULT, HWND, PSTR,
                                         PWSTR;
public import windows.win32.system.diagnostics.debug_ : CONTEXT, EXCEPTION_POINTERS,
                                                        EXCEPTION_RECORD;

extern(Windows) @nogc nothrow:


// Enums


alias WER_FILE = uint;
enum : uint
{
    WER_FILE_ANONYMOUS_DATA   = 0x00000002U,
    WER_FILE_DELETE_WHEN_DONE = 0x00000001U,
}

alias WER_SUBMIT_FLAGS = uint;
enum : uint
{
    WER_SUBMIT_ADD_REGISTERED_DATA     = 0x00000010U,
    WER_SUBMIT_HONOR_RECOVERY          = 0x00000001U,
    WER_SUBMIT_HONOR_RESTART           = 0x00000002U,
    WER_SUBMIT_NO_ARCHIVE              = 0x00000100U,
    WER_SUBMIT_NO_CLOSE_UI             = 0x00000040U,
    WER_SUBMIT_NO_QUEUE                = 0x00000080U,
    WER_SUBMIT_OUTOFPROCESS            = 0x00000020U,
    WER_SUBMIT_OUTOFPROCESS_ASYNC      = 0x00000400U,
    WER_SUBMIT_QUEUE                   = 0x00000004U,
    WER_SUBMIT_SHOW_DEBUG              = 0x00000008U,
    WER_SUBMIT_START_MINIMIZED         = 0x00000200U,
    WER_SUBMIT_BYPASS_DATA_THROTTLING  = 0x00000800U,
    WER_SUBMIT_ARCHIVE_PARAMETERS_ONLY = 0x00001000U,
    WER_SUBMIT_REPORT_MACHINE_ID       = 0x00002000U,
}

alias WER_FAULT_REPORTING = uint;
enum : uint
{
    WER_FAULT_REPORTING_FLAG_DISABLE_THREAD_SUSPENSION = 0x00000004U,
    WER_FAULT_REPORTING_FLAG_NOHEAP                    = 0x00000001U,
    WER_FAULT_REPORTING_FLAG_QUEUE                     = 0x00000002U,
    WER_FAULT_REPORTING_FLAG_QUEUE_UPLOAD              = 0x00000008U,
    WER_FAULT_REPORTING_ALWAYS_SHOW_UI                 = 0x00000010U,
}

alias WER_REPORT_UI = int;
enum : int
{
    WerUIAdditionalDataDlgHeader  = 0x00000001,
    WerUIIconFilePath             = 0x00000002,
    WerUIConsentDlgHeader         = 0x00000003,
    WerUIConsentDlgBody           = 0x00000004,
    WerUIOnlineSolutionCheckText  = 0x00000005,
    WerUIOfflineSolutionCheckText = 0x00000006,
    WerUICloseText                = 0x00000007,
    WerUICloseDlgHeader           = 0x00000008,
    WerUICloseDlgBody             = 0x00000009,
    WerUICloseDlgButtonText       = 0x0000000a,
    WerUIMax                      = 0x0000000b,
}

alias WER_REGISTER_FILE_TYPE = int;
enum : int
{
    WerRegFileTypeUserDocument = 0x00000001,
    WerRegFileTypeOther        = 0x00000002,
    WerRegFileTypeMax          = 0x00000003,
}

alias WER_FILE_TYPE = int;
enum : int
{
    WerFileTypeMicrodump         = 0x00000001,
    WerFileTypeMinidump          = 0x00000002,
    WerFileTypeHeapdump          = 0x00000003,
    WerFileTypeUserDocument      = 0x00000004,
    WerFileTypeOther             = 0x00000005,
    WerFileTypeTriagedump        = 0x00000006,
    WerFileTypeCustomDump        = 0x00000007,
    WerFileTypeAuxiliaryDump     = 0x00000008,
    WerFileTypeEtlTrace          = 0x00000009,
    WerFileTypeAuxiliaryHeapDump = 0x0000000a,
    WerFileTypeMax               = 0x0000000b,
}

alias WER_SUBMIT_RESULT = int;
enum : int
{
    WerReportQueued            = 0x00000001,
    WerReportUploaded          = 0x00000002,
    WerReportDebug             = 0x00000003,
    WerReportFailed            = 0x00000004,
    WerDisabled                = 0x00000005,
    WerReportCancelled         = 0x00000006,
    WerDisabledQueue           = 0x00000007,
    WerReportAsync             = 0x00000008,
    WerCustomAction            = 0x00000009,
    WerThrottled               = 0x0000000a,
    WerReportUploadedCab       = 0x0000000b,
    WerStorageLocationNotFound = 0x0000000c,
    WerSubmitResultMax         = 0x0000000d,
}

alias WER_REPORT_TYPE = int;
enum : int
{
    WerReportNonCritical      = 0x00000000,
    WerReportCritical         = 0x00000001,
    WerReportApplicationCrash = 0x00000002,
    WerReportApplicationHang  = 0x00000003,
    WerReportKernel           = 0x00000004,
    WerReportInvalid          = 0x00000005,
}

alias WER_CONSENT = int;
enum : int
{
    WerConsentNotAsked     = 0x00000001,
    WerConsentApproved     = 0x00000002,
    WerConsentDenied       = 0x00000003,
    WerConsentAlwaysPrompt = 0x00000004,
    WerConsentMax          = 0x00000005,
}

alias WER_DUMP_TYPE = int;
enum : int
{
    WerDumpTypeNone       = 0x00000000,
    WerDumpTypeMicroDump  = 0x00000001,
    WerDumpTypeMiniDump   = 0x00000002,
    WerDumpTypeHeapDump   = 0x00000003,
    WerDumpTypeTriageDump = 0x00000004,
    WerDumpTypeMax        = 0x00000005,
}

alias REPORT_STORE_TYPES = int;
enum : int
{
    E_STORE_USER_ARCHIVE    = 0x00000000,
    E_STORE_USER_QUEUE      = 0x00000001,
    E_STORE_MACHINE_ARCHIVE = 0x00000002,
    E_STORE_MACHINE_QUEUE   = 0x00000003,
    E_STORE_INVALID         = 0x00000004,
}

enum EFaultRepRetVal : int
{
    frrvOk                 = 0x00000000,
    frrvOkManifest         = 0x00000001,
    frrvOkQueued           = 0x00000002,
    frrvErr                = 0x00000003,
    frrvErrNoDW            = 0x00000004,
    frrvErrTimeout         = 0x00000005,
    frrvLaunchDebugger     = 0x00000006,
    frrvOkHeadless         = 0x00000007,
    frrvErrAnotherInstance = 0x00000008,
    frrvErrNoMemory        = 0x00000009,
    frrvErrDoubleFault     = 0x0000000a,
}

// Constants


enum : uint
{
    WER_FAULT_REPORTING_NO_UI                  = 0x00000020U,
    WER_FAULT_REPORTING_FLAG_NO_HEAP_ON_QUEUE  = 0x00000040U,
    WER_FAULT_REPORTING_DISABLE_SNAPSHOT_CRASH = 0x00000080U,
    WER_FAULT_REPORTING_DISABLE_SNAPSHOT_HANG  = 0x00000100U,
    WER_FAULT_REPORTING_CRITICAL               = 0x00000200U,
    WER_FAULT_REPORTING_DURABLE                = 0x00000400U,
}

enum uint WER_MAX_TOTAL_PARAM_LENGTH = 0x000006b8U;

enum : uint
{
    WER_MAX_PREFERRED_MODULES        = 0x00000080U,
    WER_MAX_PREFERRED_MODULES_BUFFER = 0x00000100U,
}

enum const(wchar)* APPCRASH_EVENT = "APPCRASH";
enum const(wchar)* PACKAGED_APPCRASH_EVENT = "MoAppCrash";

enum : uint
{
    WER_P0              = 0x00000000U,
    WER_P1              = 0x00000001U,
    WER_P2              = 0x00000002U,
    WER_P3              = 0x00000003U,
    WER_P4              = 0x00000004U,
    WER_P5              = 0x00000005U,
    WER_P6              = 0x00000006U,
    WER_P7              = 0x00000007U,
    WER_P8              = 0x00000008U,
    WER_P9              = 0x00000009U,
    WER_FILE_COMPRESSED = 0x00000004U,
}

enum : uint
{
    WER_SUBMIT_BYPASS_POWER_THROTTLING        = 0x00004000U,
    WER_SUBMIT_BYPASS_NETWORK_COST_THROTTLING = 0x00008000U,
}

enum : uint
{
    WER_DUMP_MASK_START     = 0x00000001U,
    WER_DUMP_NOHEAP_ONQUEUE = 0x00000001U,
}

enum : uint
{
    WER_DUMP_AUXILIARY   = 0x00000002U,
    WER_DUMP_AUX_PROMOTE = 0x00000004U,
}

enum : uint
{
    WER_MAX_REGISTERED_ENTRIES        = 0x00000200U,
    WER_MAX_REGISTERED_METADATA       = 0x00000008U,
    WER_MAX_REGISTERED_DUMPCOLLECTION = 0x00000004U,
}

enum : uint
{
    WER_METADATA_KEY_MAX_LENGTH   = 0x00000040U,
    WER_METADATA_VALUE_MAX_LENGTH = 0x00000080U,
}

enum uint WER_MAX_SIGNATURE_NAME_LENGTH = 0x00000080U;
enum uint WER_MAX_EVENT_NAME_LENGTH = 0x00000040U;

enum : uint
{
    WER_MAX_PARAM_LENGTH               = 0x00000104U,
    WER_MAX_PARAM_COUNT                = 0x0000000aU,
    WER_MAX_FRIENDLY_EVENT_NAME_LENGTH = 0x00000080U,
}

enum uint WER_MAX_APPLICATION_NAME_LENGTH = 0x00000080U;
enum uint WER_MAX_DESCRIPTION_LENGTH = 0x00000200U;
enum uint WER_MAX_BUCKET_ID_STRING_LENGTH = 0x00000104U;
enum uint WER_MAX_LOCAL_DUMP_SUBPATH_LENGTH = 0x00000040U;
enum uint WER_MAX_REGISTERED_RUNTIME_EXCEPTION_MODULES = 0x00000010U;

enum : const(wchar)*
{
    // Native encoding: ansi
    WER_RUNTIME_EXCEPTION_EVENT_FUNCTION           = "OutOfProcessExceptionEventCallback",
    // Native encoding: ansi
    WER_RUNTIME_EXCEPTION_EVENT_SIGNATURE_FUNCTION = "OutOfProcessExceptionEventSignatureCallback",
    // Native encoding: ansi
    WER_RUNTIME_EXCEPTION_DEBUGGER_LAUNCH          = "OutOfProcessExceptionEventDebuggerLaunchCallback",
}

// Callbacks

alias PFN_WER_RUNTIME_EXCEPTION_EVENT = HRESULT function(void* pContext, 
                                                         const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, 
                                                         BOOL* pbOwnershipClaimed, PWSTR pwszEventName, 
                                                         uint* pchSize, uint* pdwSignatureCount);
alias PFN_WER_RUNTIME_EXCEPTION_EVENT_SIGNATURE = HRESULT function(void* pContext, 
                                                                   const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, 
                                                                   uint dwIndex, PWSTR pwszName, uint* pchName, 
                                                                   PWSTR pwszValue, uint* pchValue);
alias PFN_WER_RUNTIME_EXCEPTION_DEBUGGER_LAUNCH = HRESULT function(void* pContext, 
                                                                   const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, 
                                                                   BOOL* pbIsCustomDebugger, 
                                                                   PWSTR pwszDebuggerLaunch, uint* pchDebuggerLaunch, 
                                                                   BOOL* pbIsDebuggerAutolaunch);
alias pfn_REPORTFAULT = EFaultRepRetVal function(EXCEPTION_POINTERS* param0, uint param1);
alias pfn_ADDEREXCLUDEDAPPLICATIONA = EFaultRepRetVal function(const(PSTR) param0);
alias pfn_ADDEREXCLUDEDAPPLICATIONW = EFaultRepRetVal function(const(PWSTR) param0);

// Structs


@RAIIFree!WerReportCloseHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HREPORT
{
    void* Value;
}

@RAIIFree!WerStoreClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HREPORTSTORE
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/werapi/ns-werapi-wer_report_information
struct WER_REPORT_INFORMATION
{
    uint       dwSize;
    HANDLE     hProcess;
    wchar[64]  wzConsentKey;
    wchar[128] wzFriendlyEventName;
    wchar[128] wzApplicationName;
    wchar[260] wzApplicationPath;
    wchar[512] wzDescription;
    HWND       hwndParent;
}

struct WER_REPORT_INFORMATION_V3
{
    uint       dwSize;
    HANDLE     hProcess;
    wchar[64]  wzConsentKey;
    wchar[128] wzFriendlyEventName;
    wchar[128] wzApplicationName;
    wchar[260] wzApplicationPath;
    wchar[512] wzDescription;
    HWND       hwndParent;
    wchar[64]  wzNamespacePartner;
    wchar[64]  wzNamespaceGroup;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/werapi/ns-werapi-wer_dump_custom_options
struct WER_DUMP_CUSTOM_OPTIONS
{
    uint       dwSize;
    uint       dwMask;
    uint       dwDumpFlags;
    BOOL       bOnlyThisThread;
    uint       dwExceptionThreadFlags;
    uint       dwOtherThreadFlags;
    uint       dwExceptionThreadExFlags;
    uint       dwOtherThreadExFlags;
    uint       dwPreferredModuleFlags;
    uint       dwOtherModuleFlags;
    wchar[256] wzPreferredModuleList;
}

struct WER_DUMP_CUSTOM_OPTIONS_V2
{
    uint       dwSize;
    uint       dwMask;
    uint       dwDumpFlags;
    BOOL       bOnlyThisThread;
    uint       dwExceptionThreadFlags;
    uint       dwOtherThreadFlags;
    uint       dwExceptionThreadExFlags;
    uint       dwOtherThreadExFlags;
    uint       dwPreferredModuleFlags;
    uint       dwOtherModuleFlags;
    wchar[256] wzPreferredModuleList;
    uint       dwPreferredModuleResetFlags;
    uint       dwOtherModuleResetFlags;
}

struct WER_REPORT_INFORMATION_V4
{
    uint       dwSize;
    HANDLE     hProcess;
    wchar[64]  wzConsentKey;
    wchar[128] wzFriendlyEventName;
    wchar[128] wzApplicationName;
    wchar[260] wzApplicationPath;
    wchar[512] wzDescription;
    HWND       hwndParent;
    wchar[64]  wzNamespacePartner;
    wchar[64]  wzNamespaceGroup;
    ubyte[16]  rgbApplicationIdentity;
    HANDLE     hSnapshot;
    HANDLE     hDeleteFilesImpersonationToken;
}

struct WER_REPORT_INFORMATION_V5
{
    uint              dwSize;
    HANDLE            hProcess;
    wchar[64]         wzConsentKey;
    wchar[128]        wzFriendlyEventName;
    wchar[128]        wzApplicationName;
    wchar[260]        wzApplicationPath;
    wchar[512]        wzDescription;
    HWND              hwndParent;
    wchar[64]         wzNamespacePartner;
    wchar[64]         wzNamespaceGroup;
    ubyte[16]         rgbApplicationIdentity;
    HANDLE            hSnapshot;
    HANDLE            hDeleteFilesImpersonationToken;
    WER_SUBMIT_RESULT submitResultMax;
}

struct WER_DUMP_CUSTOM_OPTIONS_V3
{
    uint       dwSize;
    uint       dwMask;
    uint       dwDumpFlags;
    BOOL       bOnlyThisThread;
    uint       dwExceptionThreadFlags;
    uint       dwOtherThreadFlags;
    uint       dwExceptionThreadExFlags;
    uint       dwOtherThreadExFlags;
    uint       dwPreferredModuleFlags;
    uint       dwOtherModuleFlags;
    wchar[256] wzPreferredModuleList;
    uint       dwPreferredModuleResetFlags;
    uint       dwOtherModuleResetFlags;
    void*      pvDumpKey;
    HANDLE     hSnapshot;
    uint       dwThreadID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/werapi/ns-werapi-wer_exception_information
struct WER_EXCEPTION_INFORMATION
{
    EXCEPTION_POINTERS* pExceptionPointers;
    BOOL                bClientPointers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/werapi/ns-werapi-wer_runtime_exception_information
struct WER_RUNTIME_EXCEPTION_INFORMATION
{
    uint             dwSize;
    HANDLE           hProcess;
    HANDLE           hThread;
    EXCEPTION_RECORD exceptionRecord;
    CONTEXT          context;
    const(PWSTR)     pwszReportId;
    BOOL             bIsFatal;
    uint             dwReserved;
}

struct WER_REPORT_PARAMETER
{
    wchar[129] Name;
    wchar[260] Value;
}

struct WER_REPORT_SIGNATURE
{
    wchar[65] EventName;
    WER_REPORT_PARAMETER[10] Parameters;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/werapi/ns-werapi-wer_report_metadata_v2
struct WER_REPORT_METADATA_V2
{
    WER_REPORT_SIGNATURE Signature;
    GUID                 BucketId;
    GUID                 ReportId;
    FILETIME             CreationTime;
    ulong                SizeInBytes;
    wchar[260]           CabId;
    uint                 ReportStatus;
    GUID                 ReportIntegratorId;
    uint                 NumberOfFiles;
    uint                 SizeOfFileNames;
    PWSTR                FileNames;
}

struct WER_REPORT_METADATA_V3
{
    WER_REPORT_SIGNATURE Signature;
    GUID                 BucketId;
    GUID                 ReportId;
    FILETIME             CreationTime;
    ulong                SizeInBytes;
    wchar[260]           CabId;
    uint                 ReportStatus;
    GUID                 ReportIntegratorId;
    uint                 NumberOfFiles;
    uint                 SizeOfFileNames;
    PWSTR                FileNames;
    wchar[128]           FriendlyEventName;
    wchar[128]           ApplicationName;
    wchar[260]           ApplicationPath;
    wchar[512]           Description;
    wchar[260]           BucketIdString;
    ulong                LegacyBucketId;
}

struct WER_REPORT_METADATA_V1
{
    WER_REPORT_SIGNATURE Signature;
    GUID                 BucketId;
    GUID                 ReportId;
    FILETIME             CreationTime;
    ulong                SizeInBytes;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wer.dll")
HRESULT WerReportCreate(const(PWSTR) pwzEventType, WER_REPORT_TYPE repType, 
                        WER_REPORT_INFORMATION* pReportInformation, HREPORT* phReportHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wer.dll")
HRESULT WerReportSetParameter(HREPORT hReportHandle, uint dwparamID, const(PWSTR) pwzName, const(PWSTR) pwzValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wer.dll")
HRESULT WerReportAddFile(HREPORT hReportHandle, const(PWSTR) pwzPath, WER_FILE_TYPE repFileType, 
                         WER_FILE dwFileFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wer.dll")
HRESULT WerReportSetUIOption(HREPORT hReportHandle, WER_REPORT_UI repUITypeID, const(PWSTR) pwzValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wer.dll")
HRESULT WerReportSubmit(HREPORT hReportHandle, WER_CONSENT consent, WER_SUBMIT_FLAGS dwFlags, 
                        WER_SUBMIT_RESULT* pSubmitResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wer.dll")
HRESULT WerReportAddDump(HREPORT hReportHandle, HANDLE hProcess, HANDLE hThread, WER_DUMP_TYPE dumpType, 
                         WER_EXCEPTION_INFORMATION* pExceptionParam, WER_DUMP_CUSTOM_OPTIONS* pDumpCustomOptions, 
                         uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wer.dll")
HRESULT WerReportCloseHandle(HREPORT hReportHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT WerRegisterFile(const(PWSTR) pwzFile, WER_REGISTER_FILE_TYPE regFileType, WER_FILE dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT WerUnregisterFile(const(PWSTR) pwzFilePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT WerRegisterMemoryBlock(void* pvAddress, uint dwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT WerUnregisterMemoryBlock(void* pvAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("KERNEL32.dll")
HRESULT WerRegisterExcludedMemoryBlock(const(void)* address, uint size);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("KERNEL32.dll")
HRESULT WerUnregisterExcludedMemoryBlock(const(void)* address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("KERNEL32.dll")
HRESULT WerRegisterCustomMetadata(const(PWSTR) key, const(PWSTR) value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("KERNEL32.dll")
HRESULT WerUnregisterCustomMetadata(const(PWSTR) key);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("KERNEL32.dll")
HRESULT WerRegisterAdditionalProcess(uint processId, uint captureExtraInfoForThreadId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("KERNEL32.dll")
HRESULT WerUnregisterAdditionalProcess(uint processId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("KERNEL32.dll")
HRESULT WerRegisterAppLocalDump(const(PWSTR) localAppDataRelativePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("KERNEL32.dll")
HRESULT WerUnregisterAppLocalDump();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT WerSetFlags(WER_FAULT_REPORTING dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT WerGetFlags(HANDLE hProcess, WER_FAULT_REPORTING* pdwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wer.dll")
HRESULT WerAddExcludedApplication(const(PWSTR) pwzExeName, BOOL bAllUsers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wer.dll")
HRESULT WerRemoveExcludedApplication(const(PWSTR) pwzExeName, BOOL bAllUsers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
HRESULT WerRegisterRuntimeExceptionModule(const(PWSTR) pwszOutOfProcessCallbackDll, void* pContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
HRESULT WerUnregisterRuntimeExceptionModule(const(PWSTR) pwszOutOfProcessCallbackDll, void* pContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("wer.dll")
HRESULT WerStoreOpen(REPORT_STORE_TYPES repStoreType, HREPORTSTORE* phReportStore);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("wer.dll")
void WerStoreClose(HREPORTSTORE hReportStore);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("wer.dll")
HRESULT WerStoreGetFirstReportKey(HREPORTSTORE hReportStore, const(PWSTR)* ppszReportKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("wer.dll")
HRESULT WerStoreGetNextReportKey(HREPORTSTORE hReportStore, const(PWSTR)* ppszReportKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("wer.dll")
HRESULT WerStoreQueryReportMetadataV2(HREPORTSTORE hReportStore, const(PWSTR) pszReportKey, 
                                      WER_REPORT_METADATA_V2* pReportMetadata);

@DllImport("wer.dll")
HRESULT WerStoreQueryReportMetadataV3(HREPORTSTORE hReportStore, const(PWSTR) pszReportKey, 
                                      WER_REPORT_METADATA_V3* pReportMetadata);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("wer.dll")
void WerFreeString(const(PWSTR) pwszStr);

@DllImport("wer.dll")
HRESULT WerStorePurge();

@DllImport("wer.dll")
HRESULT WerStoreGetReportCount(HREPORTSTORE hReportStore, uint* pdwReportCount);

@DllImport("wer.dll")
HRESULT WerStoreGetSizeOnDisk(HREPORTSTORE hReportStore, ulong* pqwSizeInBytes);

@DllImport("wer.dll")
HRESULT WerStoreQueryReportMetadataV1(HREPORTSTORE hReportStore, const(PWSTR) pszReportKey, 
                                      WER_REPORT_METADATA_V1* pReportMetadata);

@DllImport("wer.dll")
HRESULT WerStoreUploadReport(HREPORTSTORE hReportStore, const(PWSTR) pszReportKey, uint dwFlags, 
                             WER_SUBMIT_RESULT* pSubmitResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("faultrep.dll")
EFaultRepRetVal ReportFault(EXCEPTION_POINTERS* pep, uint dwOpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("faultrep.dll")
BOOL AddERExcludedApplicationA(const(PSTR) szApplication);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("faultrep.dll")
BOOL AddERExcludedApplicationW(const(PWSTR) wszApplication);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("faultrep.dll")
HRESULT WerReportHang(HWND hwndHungApp, const(PWSTR) pwzHungApplicationName);


