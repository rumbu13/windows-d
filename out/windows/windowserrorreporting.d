module windows.windowserrorreporting;

public import windows.core;
public import windows.com : HRESULT;
public import windows.dbg : CONTEXT, EXCEPTION_POINTERS, EXCEPTION_RECORD;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


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
alias WER_REPORT_UI = int;

enum : int
{
    WerRegFileTypeUserDocument = 0x00000001,
    WerRegFileTypeOther        = 0x00000002,
    WerRegFileTypeMax          = 0x00000003,
}
alias WER_REGISTER_FILE_TYPE = int;

enum : int
{
    WerFileTypeMicrodump     = 0x00000001,
    WerFileTypeMinidump      = 0x00000002,
    WerFileTypeHeapdump      = 0x00000003,
    WerFileTypeUserDocument  = 0x00000004,
    WerFileTypeOther         = 0x00000005,
    WerFileTypeTriagedump    = 0x00000006,
    WerFileTypeCustomDump    = 0x00000007,
    WerFileTypeAuxiliaryDump = 0x00000008,
    WerFileTypeEtlTrace      = 0x00000009,
    WerFileTypeMax           = 0x0000000a,
}
alias WER_FILE_TYPE = int;

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
alias WER_SUBMIT_RESULT = int;

enum : int
{
    WerReportNonCritical      = 0x00000000,
    WerReportCritical         = 0x00000001,
    WerReportApplicationCrash = 0x00000002,
    WerReportApplicationHang  = 0x00000003,
    WerReportKernel           = 0x00000004,
    WerReportInvalid          = 0x00000005,
}
alias WER_REPORT_TYPE = int;

enum : int
{
    WerConsentNotAsked     = 0x00000001,
    WerConsentApproved     = 0x00000002,
    WerConsentDenied       = 0x00000003,
    WerConsentAlwaysPrompt = 0x00000004,
    WerConsentMax          = 0x00000005,
}
alias WER_CONSENT = int;

enum : int
{
    WerDumpTypeNone       = 0x00000000,
    WerDumpTypeMicroDump  = 0x00000001,
    WerDumpTypeMiniDump   = 0x00000002,
    WerDumpTypeHeapDump   = 0x00000003,
    WerDumpTypeTriageDump = 0x00000004,
    WerDumpTypeMax        = 0x00000005,
}
alias WER_DUMP_TYPE = int;

enum : int
{
    E_STORE_USER_ARCHIVE    = 0x00000000,
    E_STORE_USER_QUEUE      = 0x00000001,
    E_STORE_MACHINE_ARCHIVE = 0x00000002,
    E_STORE_MACHINE_QUEUE   = 0x00000003,
    E_STORE_INVALID         = 0x00000004,
}
alias REPORT_STORE_TYPES = int;

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

// Callbacks

alias PFN_WER_RUNTIME_EXCEPTION_EVENT = HRESULT function(void* pContext, 
                                                         const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, 
                                                         int* pbOwnershipClaimed, const(wchar)* pwszEventName, 
                                                         uint* pchSize, uint* pdwSignatureCount);
alias PFN_WER_RUNTIME_EXCEPTION_EVENT_SIGNATURE = HRESULT function(void* pContext, 
                                                                   const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, 
                                                                   uint dwIndex, const(wchar)* pwszName, 
                                                                   uint* pchName, const(wchar)* pwszValue, 
                                                                   uint* pchValue);
alias PFN_WER_RUNTIME_EXCEPTION_DEBUGGER_LAUNCH = HRESULT function(void* pContext, 
                                                                   const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, 
                                                                   int* pbIsCustomDebugger, 
                                                                   const(wchar)* pwszDebuggerLaunch, 
                                                                   uint* pchDebuggerLaunch, 
                                                                   int* pbIsDebuggerAutolaunch);
alias pfn_REPORTFAULT = EFaultRepRetVal function(EXCEPTION_POINTERS* param0, uint param1);
alias pfn_ADDEREXCLUDEDAPPLICATIONA = EFaultRepRetVal function(const(char)* param0);
alias pfn_ADDEREXCLUDEDAPPLICATIONW = EFaultRepRetVal function(const(wchar)* param0);

// Structs


struct WER_REPORT_INFORMATION
{
    uint        dwSize;
    HANDLE      hProcess;
    ushort[64]  wzConsentKey;
    ushort[128] wzFriendlyEventName;
    ushort[128] wzApplicationName;
    ushort[260] wzApplicationPath;
    ushort[512] wzDescription;
    HWND        hwndParent;
}

struct WER_REPORT_INFORMATION_V3
{
    uint        dwSize;
    HANDLE      hProcess;
    ushort[64]  wzConsentKey;
    ushort[128] wzFriendlyEventName;
    ushort[128] wzApplicationName;
    ushort[260] wzApplicationPath;
    ushort[512] wzDescription;
    HWND        hwndParent;
    ushort[64]  wzNamespacePartner;
    ushort[64]  wzNamespaceGroup;
}

struct WER_DUMP_CUSTOM_OPTIONS
{
    uint        dwSize;
    uint        dwMask;
    uint        dwDumpFlags;
    BOOL        bOnlyThisThread;
    uint        dwExceptionThreadFlags;
    uint        dwOtherThreadFlags;
    uint        dwExceptionThreadExFlags;
    uint        dwOtherThreadExFlags;
    uint        dwPreferredModuleFlags;
    uint        dwOtherModuleFlags;
    ushort[256] wzPreferredModuleList;
}

struct WER_DUMP_CUSTOM_OPTIONS_V2
{
    uint        dwSize;
    uint        dwMask;
    uint        dwDumpFlags;
    BOOL        bOnlyThisThread;
    uint        dwExceptionThreadFlags;
    uint        dwOtherThreadFlags;
    uint        dwExceptionThreadExFlags;
    uint        dwOtherThreadExFlags;
    uint        dwPreferredModuleFlags;
    uint        dwOtherModuleFlags;
    ushort[256] wzPreferredModuleList;
    uint        dwPreferredModuleResetFlags;
    uint        dwOtherModuleResetFlags;
}

struct WER_REPORT_INFORMATION_V4
{
    uint        dwSize;
    HANDLE      hProcess;
    ushort[64]  wzConsentKey;
    ushort[128] wzFriendlyEventName;
    ushort[128] wzApplicationName;
    ushort[260] wzApplicationPath;
    ushort[512] wzDescription;
    HWND        hwndParent;
    ushort[64]  wzNamespacePartner;
    ushort[64]  wzNamespaceGroup;
    ubyte[16]   rgbApplicationIdentity;
    HANDLE      hSnapshot;
    HANDLE      hDeleteFilesImpersonationToken;
}

struct WER_REPORT_INFORMATION_V5
{
    uint              dwSize;
    HANDLE            hProcess;
    ushort[64]        wzConsentKey;
    ushort[128]       wzFriendlyEventName;
    ushort[128]       wzApplicationName;
    ushort[260]       wzApplicationPath;
    ushort[512]       wzDescription;
    HWND              hwndParent;
    ushort[64]        wzNamespacePartner;
    ushort[64]        wzNamespaceGroup;
    ubyte[16]         rgbApplicationIdentity;
    HANDLE            hSnapshot;
    HANDLE            hDeleteFilesImpersonationToken;
    WER_SUBMIT_RESULT submitResultMax;
}

struct WER_DUMP_CUSTOM_OPTIONS_V3
{
    uint        dwSize;
    uint        dwMask;
    uint        dwDumpFlags;
    BOOL        bOnlyThisThread;
    uint        dwExceptionThreadFlags;
    uint        dwOtherThreadFlags;
    uint        dwExceptionThreadExFlags;
    uint        dwOtherThreadExFlags;
    uint        dwPreferredModuleFlags;
    uint        dwOtherModuleFlags;
    ushort[256] wzPreferredModuleList;
    uint        dwPreferredModuleResetFlags;
    uint        dwOtherModuleResetFlags;
    void*       pvDumpKey;
    HANDLE      hSnapshot;
    uint        dwThreadID;
}

struct WER_EXCEPTION_INFORMATION
{
    EXCEPTION_POINTERS* pExceptionPointers;
    BOOL                bClientPointers;
}

struct WER_RUNTIME_EXCEPTION_INFORMATION
{
    uint             dwSize;
    HANDLE           hProcess;
    HANDLE           hThread;
    EXCEPTION_RECORD exceptionRecord;
    CONTEXT          context;
    const(wchar)*    pwszReportId;
    BOOL             bIsFatal;
    uint             dwReserved;
}

struct WER_REPORT_PARAMETER
{
    ushort[129] Name;
    ushort[260] Value;
}

struct WER_REPORT_SIGNATURE
{
    ushort[65] EventName;
    WER_REPORT_PARAMETER[10] Parameters;
}

struct WER_REPORT_METADATA_V2
{
    WER_REPORT_SIGNATURE Signature;
    GUID                 BucketId;
    GUID                 ReportId;
    FILETIME             CreationTime;
    ulong                SizeInBytes;
    ushort[260]          CabId;
    uint                 ReportStatus;
    GUID                 ReportIntegratorId;
    uint                 NumberOfFiles;
    uint                 SizeOfFileNames;
    ushort*              FileNames;
}

struct WER_REPORT_METADATA_V3
{
    WER_REPORT_SIGNATURE Signature;
    GUID                 BucketId;
    GUID                 ReportId;
    FILETIME             CreationTime;
    ulong                SizeInBytes;
    ushort[260]          CabId;
    uint                 ReportStatus;
    GUID                 ReportIntegratorId;
    uint                 NumberOfFiles;
    uint                 SizeOfFileNames;
    ushort*              FileNames;
    ushort[128]          FriendlyEventName;
    ushort[128]          ApplicationName;
    ushort[260]          ApplicationPath;
    ushort[512]          Description;
    ushort[260]          BucketIdString;
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

@DllImport("wer")
HRESULT WerReportCreate(const(wchar)* pwzEventType, WER_REPORT_TYPE repType, 
                        WER_REPORT_INFORMATION* pReportInformation, ptrdiff_t* phReportHandle);

@DllImport("wer")
HRESULT WerReportSetParameter(ptrdiff_t hReportHandle, uint dwparamID, const(wchar)* pwzName, 
                              const(wchar)* pwzValue);

@DllImport("wer")
HRESULT WerReportAddFile(ptrdiff_t hReportHandle, const(wchar)* pwzPath, WER_FILE_TYPE repFileType, 
                         uint dwFileFlags);

@DllImport("wer")
HRESULT WerReportSetUIOption(ptrdiff_t hReportHandle, WER_REPORT_UI repUITypeID, const(wchar)* pwzValue);

@DllImport("wer")
HRESULT WerReportSubmit(ptrdiff_t hReportHandle, WER_CONSENT consent, uint dwFlags, 
                        WER_SUBMIT_RESULT* pSubmitResult);

@DllImport("wer")
HRESULT WerReportAddDump(ptrdiff_t hReportHandle, HANDLE hProcess, HANDLE hThread, WER_DUMP_TYPE dumpType, 
                         WER_EXCEPTION_INFORMATION* pExceptionParam, WER_DUMP_CUSTOM_OPTIONS* pDumpCustomOptions, 
                         uint dwFlags);

@DllImport("wer")
HRESULT WerReportCloseHandle(ptrdiff_t hReportHandle);

@DllImport("KERNEL32")
HRESULT WerRegisterFile(const(wchar)* pwzFile, WER_REGISTER_FILE_TYPE regFileType, uint dwFlags);

@DllImport("KERNEL32")
HRESULT WerUnregisterFile(const(wchar)* pwzFilePath);

@DllImport("KERNEL32")
HRESULT WerRegisterMemoryBlock(void* pvAddress, uint dwSize);

@DllImport("KERNEL32")
HRESULT WerUnregisterMemoryBlock(void* pvAddress);

@DllImport("KERNEL32")
HRESULT WerRegisterExcludedMemoryBlock(const(void)* address, uint size);

@DllImport("KERNEL32")
HRESULT WerUnregisterExcludedMemoryBlock(const(void)* address);

@DllImport("KERNEL32")
HRESULT WerRegisterCustomMetadata(const(wchar)* key, const(wchar)* value);

@DllImport("KERNEL32")
HRESULT WerUnregisterCustomMetadata(const(wchar)* key);

@DllImport("KERNEL32")
HRESULT WerRegisterAdditionalProcess(uint processId, uint captureExtraInfoForThreadId);

@DllImport("KERNEL32")
HRESULT WerUnregisterAdditionalProcess(uint processId);

@DllImport("KERNEL32")
HRESULT WerRegisterAppLocalDump(const(wchar)* localAppDataRelativePath);

@DllImport("KERNEL32")
HRESULT WerUnregisterAppLocalDump();

@DllImport("KERNEL32")
HRESULT WerSetFlags(uint dwFlags);

@DllImport("KERNEL32")
HRESULT WerGetFlags(HANDLE hProcess, uint* pdwFlags);

@DllImport("wer")
HRESULT WerAddExcludedApplication(const(wchar)* pwzExeName, BOOL bAllUsers);

@DllImport("wer")
HRESULT WerRemoveExcludedApplication(const(wchar)* pwzExeName, BOOL bAllUsers);

@DllImport("KERNEL32")
HRESULT WerRegisterRuntimeExceptionModule(const(wchar)* pwszOutOfProcessCallbackDll, void* pContext);

@DllImport("KERNEL32")
HRESULT WerUnregisterRuntimeExceptionModule(const(wchar)* pwszOutOfProcessCallbackDll, void* pContext);

@DllImport("wer")
HRESULT WerStoreOpen(REPORT_STORE_TYPES repStoreType, void** phReportStore);

@DllImport("wer")
void WerStoreClose(void* hReportStore);

@DllImport("wer")
HRESULT WerStoreGetFirstReportKey(void* hReportStore, ushort** ppszReportKey);

@DllImport("wer")
HRESULT WerStoreGetNextReportKey(void* hReportStore, ushort** ppszReportKey);

@DllImport("wer")
HRESULT WerStoreQueryReportMetadataV2(void* hReportStore, const(wchar)* pszReportKey, 
                                      WER_REPORT_METADATA_V2* pReportMetadata);

@DllImport("wer")
HRESULT WerStoreQueryReportMetadataV3(void* hReportStore, const(wchar)* pszReportKey, 
                                      WER_REPORT_METADATA_V3* pReportMetadata);

@DllImport("wer")
void WerFreeString(const(wchar)* pwszStr);

@DllImport("wer")
HRESULT WerStorePurge();

@DllImport("wer")
HRESULT WerStoreGetReportCount(void* hReportStore, uint* pdwReportCount);

@DllImport("wer")
HRESULT WerStoreGetSizeOnDisk(void* hReportStore, ulong* pqwSizeInBytes);

@DllImport("wer")
HRESULT WerStoreQueryReportMetadataV1(void* hReportStore, const(wchar)* pszReportKey, 
                                      WER_REPORT_METADATA_V1* pReportMetadata);

@DllImport("wer")
HRESULT WerStoreUploadReport(void* hReportStore, const(wchar)* pszReportKey, uint dwFlags, 
                             WER_SUBMIT_RESULT* pSubmitResult);

@DllImport("faultrep")
EFaultRepRetVal ReportFault(EXCEPTION_POINTERS* pep, uint dwOpt);

@DllImport("faultrep")
BOOL AddERExcludedApplicationA(const(char)* szApplication);

@DllImport("faultrep")
BOOL AddERExcludedApplicationW(const(wchar)* wszApplication);

@DllImport("faultrep")
HRESULT WerReportHang(HWND hwndHungApp, const(wchar)* pwzHungApplicationName);


