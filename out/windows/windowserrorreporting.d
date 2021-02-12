module windows.windowserrorreporting;

public import system;
public import windows.com;
public import windows.debug;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

enum WER_REPORT_UI
{
    WerUIAdditionalDataDlgHeader = 1,
    WerUIIconFilePath = 2,
    WerUIConsentDlgHeader = 3,
    WerUIConsentDlgBody = 4,
    WerUIOnlineSolutionCheckText = 5,
    WerUIOfflineSolutionCheckText = 6,
    WerUICloseText = 7,
    WerUICloseDlgHeader = 8,
    WerUICloseDlgBody = 9,
    WerUICloseDlgButtonText = 10,
    WerUIMax = 11,
}

enum WER_REGISTER_FILE_TYPE
{
    WerRegFileTypeUserDocument = 1,
    WerRegFileTypeOther = 2,
    WerRegFileTypeMax = 3,
}

enum WER_FILE_TYPE
{
    WerFileTypeMicrodump = 1,
    WerFileTypeMinidump = 2,
    WerFileTypeHeapdump = 3,
    WerFileTypeUserDocument = 4,
    WerFileTypeOther = 5,
    WerFileTypeTriagedump = 6,
    WerFileTypeCustomDump = 7,
    WerFileTypeAuxiliaryDump = 8,
    WerFileTypeEtlTrace = 9,
    WerFileTypeMax = 10,
}

enum WER_SUBMIT_RESULT
{
    WerReportQueued = 1,
    WerReportUploaded = 2,
    WerReportDebug = 3,
    WerReportFailed = 4,
    WerDisabled = 5,
    WerReportCancelled = 6,
    WerDisabledQueue = 7,
    WerReportAsync = 8,
    WerCustomAction = 9,
    WerThrottled = 10,
    WerReportUploadedCab = 11,
    WerStorageLocationNotFound = 12,
    WerSubmitResultMax = 13,
}

enum WER_REPORT_TYPE
{
    WerReportNonCritical = 0,
    WerReportCritical = 1,
    WerReportApplicationCrash = 2,
    WerReportApplicationHang = 3,
    WerReportKernel = 4,
    WerReportInvalid = 5,
}

struct WER_REPORT_INFORMATION
{
    uint dwSize;
    HANDLE hProcess;
    ushort wzConsentKey;
    ushort wzFriendlyEventName;
    ushort wzApplicationName;
    ushort wzApplicationPath;
    ushort wzDescription;
    HWND hwndParent;
}

struct WER_REPORT_INFORMATION_V3
{
    uint dwSize;
    HANDLE hProcess;
    ushort wzConsentKey;
    ushort wzFriendlyEventName;
    ushort wzApplicationName;
    ushort wzApplicationPath;
    ushort wzDescription;
    HWND hwndParent;
    ushort wzNamespacePartner;
    ushort wzNamespaceGroup;
}

struct WER_DUMP_CUSTOM_OPTIONS
{
    uint dwSize;
    uint dwMask;
    uint dwDumpFlags;
    BOOL bOnlyThisThread;
    uint dwExceptionThreadFlags;
    uint dwOtherThreadFlags;
    uint dwExceptionThreadExFlags;
    uint dwOtherThreadExFlags;
    uint dwPreferredModuleFlags;
    uint dwOtherModuleFlags;
    ushort wzPreferredModuleList;
}

struct WER_DUMP_CUSTOM_OPTIONS_V2
{
    uint dwSize;
    uint dwMask;
    uint dwDumpFlags;
    BOOL bOnlyThisThread;
    uint dwExceptionThreadFlags;
    uint dwOtherThreadFlags;
    uint dwExceptionThreadExFlags;
    uint dwOtherThreadExFlags;
    uint dwPreferredModuleFlags;
    uint dwOtherModuleFlags;
    ushort wzPreferredModuleList;
    uint dwPreferredModuleResetFlags;
    uint dwOtherModuleResetFlags;
}

struct WER_REPORT_INFORMATION_V4
{
    uint dwSize;
    HANDLE hProcess;
    ushort wzConsentKey;
    ushort wzFriendlyEventName;
    ushort wzApplicationName;
    ushort wzApplicationPath;
    ushort wzDescription;
    HWND hwndParent;
    ushort wzNamespacePartner;
    ushort wzNamespaceGroup;
    ubyte rgbApplicationIdentity;
    HANDLE hSnapshot;
    HANDLE hDeleteFilesImpersonationToken;
}

struct WER_REPORT_INFORMATION_V5
{
    uint dwSize;
    HANDLE hProcess;
    ushort wzConsentKey;
    ushort wzFriendlyEventName;
    ushort wzApplicationName;
    ushort wzApplicationPath;
    ushort wzDescription;
    HWND hwndParent;
    ushort wzNamespacePartner;
    ushort wzNamespaceGroup;
    ubyte rgbApplicationIdentity;
    HANDLE hSnapshot;
    HANDLE hDeleteFilesImpersonationToken;
    WER_SUBMIT_RESULT submitResultMax;
}

struct WER_DUMP_CUSTOM_OPTIONS_V3
{
    uint dwSize;
    uint dwMask;
    uint dwDumpFlags;
    BOOL bOnlyThisThread;
    uint dwExceptionThreadFlags;
    uint dwOtherThreadFlags;
    uint dwExceptionThreadExFlags;
    uint dwOtherThreadExFlags;
    uint dwPreferredModuleFlags;
    uint dwOtherModuleFlags;
    ushort wzPreferredModuleList;
    uint dwPreferredModuleResetFlags;
    uint dwOtherModuleResetFlags;
    void* pvDumpKey;
    HANDLE hSnapshot;
    uint dwThreadID;
}

struct WER_EXCEPTION_INFORMATION
{
    EXCEPTION_POINTERS* pExceptionPointers;
    BOOL bClientPointers;
}

enum WER_CONSENT
{
    WerConsentNotAsked = 1,
    WerConsentApproved = 2,
    WerConsentDenied = 3,
    WerConsentAlwaysPrompt = 4,
    WerConsentMax = 5,
}

enum WER_DUMP_TYPE
{
    WerDumpTypeNone = 0,
    WerDumpTypeMicroDump = 1,
    WerDumpTypeMiniDump = 2,
    WerDumpTypeHeapDump = 3,
    WerDumpTypeTriageDump = 4,
    WerDumpTypeMax = 5,
}

struct WER_RUNTIME_EXCEPTION_INFORMATION
{
    uint dwSize;
    HANDLE hProcess;
    HANDLE hThread;
    EXCEPTION_RECORD exceptionRecord;
    CONTEXT context;
    const(wchar)* pwszReportId;
    BOOL bIsFatal;
    uint dwReserved;
}

alias PFN_WER_RUNTIME_EXCEPTION_EVENT = extern(Windows) HRESULT function(void* pContext, const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, int* pbOwnershipClaimed, const(wchar)* pwszEventName, uint* pchSize, uint* pdwSignatureCount);
alias PFN_WER_RUNTIME_EXCEPTION_EVENT_SIGNATURE = extern(Windows) HRESULT function(void* pContext, const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, uint dwIndex, const(wchar)* pwszName, uint* pchName, const(wchar)* pwszValue, uint* pchValue);
alias PFN_WER_RUNTIME_EXCEPTION_DEBUGGER_LAUNCH = extern(Windows) HRESULT function(void* pContext, const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, int* pbIsCustomDebugger, const(wchar)* pwszDebuggerLaunch, uint* pchDebuggerLaunch, int* pbIsDebuggerAutolaunch);
enum REPORT_STORE_TYPES
{
    E_STORE_USER_ARCHIVE = 0,
    E_STORE_USER_QUEUE = 1,
    E_STORE_MACHINE_ARCHIVE = 2,
    E_STORE_MACHINE_QUEUE = 3,
    E_STORE_INVALID = 4,
}

struct WER_REPORT_PARAMETER
{
    ushort Name;
    ushort Value;
}

struct WER_REPORT_SIGNATURE
{
    ushort EventName;
    WER_REPORT_PARAMETER Parameters;
}

struct WER_REPORT_METADATA_V2
{
    WER_REPORT_SIGNATURE Signature;
    Guid BucketId;
    Guid ReportId;
    FILETIME CreationTime;
    ulong SizeInBytes;
    ushort CabId;
    uint ReportStatus;
    Guid ReportIntegratorId;
    uint NumberOfFiles;
    uint SizeOfFileNames;
    ushort* FileNames;
}

struct WER_REPORT_METADATA_V3
{
    WER_REPORT_SIGNATURE Signature;
    Guid BucketId;
    Guid ReportId;
    FILETIME CreationTime;
    ulong SizeInBytes;
    ushort CabId;
    uint ReportStatus;
    Guid ReportIntegratorId;
    uint NumberOfFiles;
    uint SizeOfFileNames;
    ushort* FileNames;
    ushort FriendlyEventName;
    ushort ApplicationName;
    ushort ApplicationPath;
    ushort Description;
    ushort BucketIdString;
    ulong LegacyBucketId;
}

struct WER_REPORT_METADATA_V1
{
    WER_REPORT_SIGNATURE Signature;
    Guid BucketId;
    Guid ReportId;
    FILETIME CreationTime;
    ulong SizeInBytes;
}

enum EFaultRepRetVal
{
    frrvOk = 0,
    frrvOkManifest = 1,
    frrvOkQueued = 2,
    frrvErr = 3,
    frrvErrNoDW = 4,
    frrvErrTimeout = 5,
    frrvLaunchDebugger = 6,
    frrvOkHeadless = 7,
    frrvErrAnotherInstance = 8,
    frrvErrNoMemory = 9,
    frrvErrDoubleFault = 10,
}

alias pfn_REPORTFAULT = extern(Windows) EFaultRepRetVal function(EXCEPTION_POINTERS* param0, uint param1);
alias pfn_ADDEREXCLUDEDAPPLICATIONA = extern(Windows) EFaultRepRetVal function(const(char)* param0);
alias pfn_ADDEREXCLUDEDAPPLICATIONW = extern(Windows) EFaultRepRetVal function(const(wchar)* param0);
@DllImport("wer.dll")
HRESULT WerReportCreate(const(wchar)* pwzEventType, WER_REPORT_TYPE repType, WER_REPORT_INFORMATION* pReportInformation, int* phReportHandle);

@DllImport("wer.dll")
HRESULT WerReportSetParameter(int hReportHandle, uint dwparamID, const(wchar)* pwzName, const(wchar)* pwzValue);

@DllImport("wer.dll")
HRESULT WerReportAddFile(int hReportHandle, const(wchar)* pwzPath, WER_FILE_TYPE repFileType, uint dwFileFlags);

@DllImport("wer.dll")
HRESULT WerReportSetUIOption(int hReportHandle, WER_REPORT_UI repUITypeID, const(wchar)* pwzValue);

@DllImport("wer.dll")
HRESULT WerReportSubmit(int hReportHandle, WER_CONSENT consent, uint dwFlags, WER_SUBMIT_RESULT* pSubmitResult);

@DllImport("wer.dll")
HRESULT WerReportAddDump(int hReportHandle, HANDLE hProcess, HANDLE hThread, WER_DUMP_TYPE dumpType, WER_EXCEPTION_INFORMATION* pExceptionParam, WER_DUMP_CUSTOM_OPTIONS* pDumpCustomOptions, uint dwFlags);

@DllImport("wer.dll")
HRESULT WerReportCloseHandle(int hReportHandle);

@DllImport("KERNEL32.dll")
HRESULT WerRegisterFile(const(wchar)* pwzFile, WER_REGISTER_FILE_TYPE regFileType, uint dwFlags);

@DllImport("KERNEL32.dll")
HRESULT WerUnregisterFile(const(wchar)* pwzFilePath);

@DllImport("KERNEL32.dll")
HRESULT WerRegisterMemoryBlock(void* pvAddress, uint dwSize);

@DllImport("KERNEL32.dll")
HRESULT WerUnregisterMemoryBlock(void* pvAddress);

@DllImport("KERNEL32.dll")
HRESULT WerRegisterExcludedMemoryBlock(const(void)* address, uint size);

@DllImport("KERNEL32.dll")
HRESULT WerUnregisterExcludedMemoryBlock(const(void)* address);

@DllImport("KERNEL32.dll")
HRESULT WerRegisterCustomMetadata(const(wchar)* key, const(wchar)* value);

@DllImport("KERNEL32.dll")
HRESULT WerUnregisterCustomMetadata(const(wchar)* key);

@DllImport("KERNEL32.dll")
HRESULT WerRegisterAdditionalProcess(uint processId, uint captureExtraInfoForThreadId);

@DllImport("KERNEL32.dll")
HRESULT WerUnregisterAdditionalProcess(uint processId);

@DllImport("KERNEL32.dll")
HRESULT WerRegisterAppLocalDump(const(wchar)* localAppDataRelativePath);

@DllImport("KERNEL32.dll")
HRESULT WerUnregisterAppLocalDump();

@DllImport("KERNEL32.dll")
HRESULT WerSetFlags(uint dwFlags);

@DllImport("KERNEL32.dll")
HRESULT WerGetFlags(HANDLE hProcess, uint* pdwFlags);

@DllImport("wer.dll")
HRESULT WerAddExcludedApplication(const(wchar)* pwzExeName, BOOL bAllUsers);

@DllImport("wer.dll")
HRESULT WerRemoveExcludedApplication(const(wchar)* pwzExeName, BOOL bAllUsers);

@DllImport("KERNEL32.dll")
HRESULT WerRegisterRuntimeExceptionModule(const(wchar)* pwszOutOfProcessCallbackDll, void* pContext);

@DllImport("KERNEL32.dll")
HRESULT WerUnregisterRuntimeExceptionModule(const(wchar)* pwszOutOfProcessCallbackDll, void* pContext);

@DllImport("wer.dll")
HRESULT WerStoreOpen(REPORT_STORE_TYPES repStoreType, void** phReportStore);

@DllImport("wer.dll")
void WerStoreClose(void* hReportStore);

@DllImport("wer.dll")
HRESULT WerStoreGetFirstReportKey(void* hReportStore, ushort** ppszReportKey);

@DllImport("wer.dll")
HRESULT WerStoreGetNextReportKey(void* hReportStore, ushort** ppszReportKey);

@DllImport("wer.dll")
HRESULT WerStoreQueryReportMetadataV2(void* hReportStore, const(wchar)* pszReportKey, WER_REPORT_METADATA_V2* pReportMetadata);

@DllImport("wer.dll")
HRESULT WerStoreQueryReportMetadataV3(void* hReportStore, const(wchar)* pszReportKey, WER_REPORT_METADATA_V3* pReportMetadata);

@DllImport("wer.dll")
void WerFreeString(const(wchar)* pwszStr);

@DllImport("wer.dll")
HRESULT WerStorePurge();

@DllImport("wer.dll")
HRESULT WerStoreGetReportCount(void* hReportStore, uint* pdwReportCount);

@DllImport("wer.dll")
HRESULT WerStoreGetSizeOnDisk(void* hReportStore, ulong* pqwSizeInBytes);

@DllImport("wer.dll")
HRESULT WerStoreQueryReportMetadataV1(void* hReportStore, const(wchar)* pszReportKey, WER_REPORT_METADATA_V1* pReportMetadata);

@DllImport("wer.dll")
HRESULT WerStoreUploadReport(void* hReportStore, const(wchar)* pszReportKey, uint dwFlags, WER_SUBMIT_RESULT* pSubmitResult);

@DllImport("faultrep.dll")
EFaultRepRetVal ReportFault(EXCEPTION_POINTERS* pep, uint dwOpt);

@DllImport("faultrep.dll")
BOOL AddERExcludedApplicationA(const(char)* szApplication);

@DllImport("faultrep.dll")
BOOL AddERExcludedApplicationW(const(wchar)* wszApplication);

@DllImport("faultrep.dll")
HRESULT WerReportHang(HWND hwndHungApp, const(wchar)* pwzHungApplicationName);

