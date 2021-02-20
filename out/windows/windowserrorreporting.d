// Written in the D programming language.

module windows.windowserrorreporting;

public import windows.core;
public import windows.com : HRESULT;
public import windows.dbg : CONTEXT, EXCEPTION_POINTERS, EXCEPTION_RECORD;
public import windows.systemservices : BOOL, HANDLE, PSTR, PWSTR;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Enums


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

// Callbacks

///WER calls this function to determine whether the exception handler is claiming the crash. The
///<b>PFN_WER_RUNTIME_EXCEPTION_EVENT</b> type defines a pointer to this callback function. You must use
///"OutOfProcessExceptionEventCallback" as the name of the callback function.
///Params:
///    pContext = A pointer to arbitrary context information that you specified when you called the
///               WerRegisterRuntimeExceptionModule function to register the exception handler.
///    pExceptionInformation = A WER_RUNTIME_EXCEPTION_INFORMATION structure that contains the exception information. Use the information to
///                            determine whether you want to claim the crash.
///    pbOwnershipClaimed = Set to <b>TRUE</b> if the exception handler is claiming this crash; otherwise, <b>FALSE</b>. If you set this
///                         parameter to <b>FALSE</b>, do not set the rest of the out parameters.
///    pwszEventName = A caller-allocated buffer that you use to specify the event name used to identify this crash.
///    pchSize = The size, in characters, of the <i>pwszEventName</i> buffer. The buffer is limited to MAX_PATH characters. The
///              size includes the null-terminating character.
///    pdwSignatureCount = The number of report parameters that you will provide. The valid range of values is one to 10. If you specify a
///                        value greater than 10, WER will ignore the value and collect only the first 10 parameters. If you specify zero,
///                        the reporting process will be indeterminate. This value determines the number of times that WER calls your
///                        OutOfProcessExceptionEventSignatureCallback function.
///Returns:
///    Return <b>S_OK</b>, even if the exception handler is not claiming this crash. If you return other failure codes,
///    WER reverts to its default crash reporting behavior if no other handlers are registered.
///    
alias PFN_WER_RUNTIME_EXCEPTION_EVENT = HRESULT function(void* pContext, 
                                                         const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, 
                                                         BOOL* pbOwnershipClaimed, PWSTR pwszEventName, 
                                                         uint* pchSize, uint* pdwSignatureCount);
///WER can call this function multiple times to get the report parameters that uniquely describe the problem. The
///<b>PFN_WER_RUNTIME_EXCEPTION_EVENT_SIGNATURE</b> type defines a pointer to this callback function. You must use
///"OutOfProcessExceptionEventSignatureCallback" as the name of the callback function.
///Params:
///    pContext = A pointer to arbitrary context information that you specified when you called the
///               WerRegisterRuntimeExceptionModule function to register the exception handler.
///    pExceptionInformation = A WER_RUNTIME_EXCEPTION_INFORMATION structure that contains the exception information.
///    dwIndex = The index of the report parameter. Valid values are 0 to 9. The first call to this function must set the index to
///              0, and each successive call must increment the index value sequentially.
///    pwszName = A caller-allocated buffer that you use to specify the parameter name.
///    pchName = The size, in characters, of the <i>pwszName</i> buffer. The size includes the null-terminating character.
///    pwszValue = A caller-allocated buffer that you use to specify the parameter value.
///    pchValue = The size, in characters, of the <i>pwszValue</i> buffer. The size includes the null-terminating character.
///Returns:
///    Return <b>S_OK</b> on success. If you return other failure codes, WER reverts to its default crash reporting
///    behavior.
///    
alias PFN_WER_RUNTIME_EXCEPTION_EVENT_SIGNATURE = HRESULT function(void* pContext, 
                                                                   const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, 
                                                                   uint dwIndex, PWSTR pwszName, uint* pchName, 
                                                                   PWSTR pwszValue, uint* pchValue);
///WER calls this function to let you customize the debugger launch options and launch string. The
///<b>PFN_WER_RUNTIME_EXCEPTION_DEBUGGER_LAUNCH</b> type defines a pointer to this callback function. You must use
///"OutOfProcessExceptionEventDebuggerLaunchCallback" as the name of the callback function.
///Params:
///    pContext = A pointer to arbitrary context information that you specified when you called the
///               WerRegisterRuntimeExceptionModule function to register the exception handler.
///    pExceptionInformation = A WER_RUNTIME_EXCEPTION_INFORMATION structure that contains the exception information.
///    pbIsCustomDebugger = Set to <b>TRUE</b> if the custom debugger specified in the <i>pwszDebuggerLaunch</i> parameter is used to debug
///                         the crash; otherwise, set to <b>FALSE</b> to use the default debugger. If you set this parameter to <b>FALSE</b>,
///                         do not set the <i>pwszDebuggerLaunch</i> parameter.
///    pwszDebuggerLaunch = A caller-allocated buffer that you use to specify the debugger launch string used to launch the debugger. The
///                         launch string must include the full path to the debugger and any arguments. If an argument includes multiple
///                         words, use quotes to delimit the argument. The debugger string should adhere to the same protocol as the default
///                         AeDebug debugger string (see Configuring Automatic Debugging). The string must contain two formatting specifiers:
///                         %ld for the crashing process ID, and %ld for the handle to an event object to be signaled after the custom
///                         debugger has attached to the target (for a description of these specifiers, see Enabling Postmortem Debugging).
///                         However, custom debuggers can choose to ignore these parameters.
///    pchDebuggerLaunch = The size, in characters, of the <i>pwszDebuggerLaunch</i> buffer.
///    pbIsDebuggerAutolaunch = Set to <b>TRUE</b> if you want WER to silently launch the debugger; otherwise, <b>FALSE</b> if you want WER to
///                             ask the user before launching the debugger.
///Returns:
///    Return <b>S_OK</b>, even if no customer debugger is to be used. If you return other failure codes, WER reverts to
///    its default crash reporting behavior.
///    
alias PFN_WER_RUNTIME_EXCEPTION_DEBUGGER_LAUNCH = HRESULT function(void* pContext, 
                                                                   const(WER_RUNTIME_EXCEPTION_INFORMATION)* pExceptionInformation, 
                                                                   BOOL* pbIsCustomDebugger, 
                                                                   PWSTR pwszDebuggerLaunch, uint* pchDebuggerLaunch, 
                                                                   BOOL* pbIsDebuggerAutolaunch);
alias pfn_REPORTFAULT = EFaultRepRetVal function(EXCEPTION_POINTERS* param0, uint param1);
alias pfn_ADDEREXCLUDEDAPPLICATIONA = EFaultRepRetVal function(const(PSTR) param0);
alias pfn_ADDEREXCLUDEDAPPLICATIONW = EFaultRepRetVal function(const(PWSTR) param0);

// Structs


///Contains information used by the WerReportCreate function.
struct WER_REPORT_INFORMATION
{
    ///The size of this structure, in bytes.
    uint        dwSize;
    ///A handle to the process for which the report is being generated. If this member is <b>NULL</b>, this is the
    ///calling process.
    HANDLE      hProcess;
    ///The name used to look up consent settings. If this member is empty, the default is the name specified by the
    ///<i>pwzEventType</i> parameter of WerReportCreate.
    ushort[64]  wzConsentKey;
    ///The display name. If this member is empty, the default is the name specified by <i>pwzEventType</i> parameter of
    ///WerReportCreate.
    ushort[128] wzFriendlyEventName;
    ///The name of the application. If this parameter is empty, the default is the base name of the image file.
    ushort[128] wzApplicationName;
    ///The full path to the application.
    ushort[260] wzApplicationPath;
    ///A description of the problem. This description is displayed in <b>Problem Reports and Solutions</b> on Windows
    ///Vista or the problem reports pane of the <b>Action Center</b> on Windows 7.
    ushort[512] wzDescription;
    ///A handle to the parent window.
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

///Specifies custom minidump information to be collected by the WerReportAddDump function.
struct WER_DUMP_CUSTOM_OPTIONS
{
    ///The size of the structure, in bytes.
    uint        dwSize;
    ///A mask that controls which options are valid in this structure. You can specify one or more of the following
    ///values: <a id="WER_DUMP_MASK_DUMPTYPE"></a> <a id="wer_dump_mask_dumptype"></a>
    uint        dwMask;
    ///The type information to include in the minidump. You can specify one or more of the MINIDUMP_TYPE flags. This
    ///member is valid only if <b>dwMask</b> contains WER_DUMP_MASK_DUMPTYPE.
    uint        dwDumpFlags;
    ///If this member is <b>TRUE</b> and <b>dwMask</b> contains WER_DUMP_MASK_ONLY_THISTHREAD, the minidump is to be
    ///collected only for the calling thread.
    BOOL        bOnlyThisThread;
    ///The type of thread information to include in the minidump. You can specify one or more of the THREAD_WRITE_FLAGS
    ///flags. This member is valid only if <b>dwMask</b> contains WER_DUMP_MASK_THREADFLAGS.
    uint        dwExceptionThreadFlags;
    ///The type of thread information to include in the minidump. You can specify one or more of the THREAD_WRITE_FLAGS
    ///flags. This member is valid only if <b>dwMask</b> contains WER_DUMP_MASK_OTHERTHREADFLAGS.
    uint        dwOtherThreadFlags;
    ///The type of thread information to include in the minidump. You can specify one or more of the THREAD_WRITE_FLAGS
    ///flags. This member is valid only if <b>dwMask</b> contains WER_DUMP_MASK_THREADFLAGS_EX.
    uint        dwExceptionThreadExFlags;
    ///The type of thread information to include in the minidump. You can specify one or more of the THREAD_WRITE_FLAGS
    ///flags. This member is valid only if <b>dwMask</b> contains WER_DUMP_MASK_OTHERTHREADFLAGS_EX.
    uint        dwOtherThreadExFlags;
    ///The type of module information to include in the minidump for modules specified in the
    ///<b>wzPreferredModuleList</b> member. You can specify one or more of the MODULE_WRITE_FLAGS flags. This member is
    ///valid only if <b>dwMask</b> contains WER_DUMP_MASK_PREFERRED_MODULESFLAGS.
    uint        dwPreferredModuleFlags;
    ///The type of module information to include in the minidump. You can specify one or more of the MODULE_WRITE_FLAGS
    ///flags. This member is valid only if <b>dwMask</b> contains WER_DUMP_MASK_OTHER_MODULESFLAGS.
    uint        dwOtherModuleFlags;
    ///A list of module names (do not include the path) to which the <b>dwPreferredModuleFlags</b> flags apply. Each
    ///name must be null-terminated, and the list must be terminated with two null characters (for example,
    ///module1.dll\0module2.dll\0\0). To specify that all modules are preferred, set this member to "*\0\0". If you
    ///include * in a list with other module names, the * is ignored. This member is valid only if <b>dwMask</b>
    ///contains WER_DUMP_MASK_PREFERRED_MODULE_LIST.
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

///Contains exception information for the WerReportAddDump function.
struct WER_EXCEPTION_INFORMATION
{
    ///A pointer to an EXCEPTION_POINTERS structure.
    EXCEPTION_POINTERS* pExceptionPointers;
    ///A process (calling process) can provide error reporting functionality for another process (client process). If
    ///this member is <b>TRUE</b>, the exception pointer is located inside the address space of the client process. If
    ///this member is <b>FALSE</b>, the exception pointer is located inside the address space of the calling process.
    BOOL                bClientPointers;
}

///Contains the exception information that you use to determine whether you want to claim the crash.
struct WER_RUNTIME_EXCEPTION_INFORMATION
{
    ///Size, in bytes, of this structure.
    uint             dwSize;
    ///The handle to the process that crashed.
    HANDLE           hProcess;
    ///The handle to the thread that crashed.
    HANDLE           hThread;
    ///An EXCEPTION_RECORD structure that contains the exception information.
    EXCEPTION_RECORD exceptionRecord;
    ///A CONTEXT structure that contains the context information.
    CONTEXT          context;
    ///A pointer to a constant, null-terminated string that contains the size of the exception information.
    const(PWSTR)     pwszReportId;
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

///Contains information about an error report generated by Windows Error Reporting.
struct WER_REPORT_METADATA_V2
{
    ///A structure containing the signature of the report. The signature consists of the event name and event parameters
    ///present.
    WER_REPORT_SIGNATURE Signature;
    ///A hash of the signature. Can be used to cross reference with other crash reports with the same signature
    ///(currently not implemented).
    GUID                 BucketId;
    ///A locally unique identifier for the report.
    GUID                 ReportId;
    ///A UTC time stamp of when the report was created.
    FILETIME             CreationTime;
    ///The size (on disk) of the individual report and its constituent files. This value only counts files directly
    ///contained in a report.
    ulong                SizeInBytes;
    ushort[260]          CabId;
    ///The detailed status of the report. Use the ReportStatus decoder to track this bit-field.
    uint                 ReportStatus;
    ///The integrator ID of the report.
    GUID                 ReportIntegratorId;
    ///The number of data files included in the report.
    uint                 NumberOfFiles;
    ///The total size of the file name fields, in count of <b>WCHAR</b>s, including the terminating character for each
    ///name and one more at the end of the record.
    uint                 SizeOfFileNames;
    ///A pointer to hold the names of the files included in the report. It is in the format:
    ///FileName001\0FileName002\0\FileName003\0\0.
    PWSTR                FileNames;
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
    PWSTR                FileNames;
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

///Creates a problem report that describes an application event.
///Params:
///    pwzEventType = A pointer to a Unicode string that specifies the name of the event.
///    repType = The type of report. This parameter can be one of the following values from the <b>WER_REPORT_TYPE</b> enumeration
///              type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="WerReportApplicationCrash"></a><a id="werreportapplicationcrash"></a><a
///              id="WERREPORTAPPLICATIONCRASH"></a><dl> <dt><b>WerReportApplicationCrash</b></dt> <dt>2</dt> </dl> </td> <td
///              width="60%"> An error that has caused the application to stop running has occurred. </td> </tr> <tr> <td
///              width="40%"><a id="WerReportApplicationHang"></a><a id="werreportapplicationhang"></a><a
///              id="WERREPORTAPPLICATIONHANG"></a><dl> <dt><b>WerReportApplicationHang</b></dt> <dt>3</dt> </dl> </td> <td
///              width="60%"> An error that has caused the application to stop responding has occurred. </td> </tr> <tr> <td
///              width="40%"><a id="WerReportInvalid"></a><a id="werreportinvalid"></a><a id="WERREPORTINVALID"></a><dl>
///              <dt><b>WerReportInvalid</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> An error that has called out a return
///              that is not valid has occurred. </td> </tr> <tr> <td width="40%"><a id="WerReportKernel"></a><a
///              id="werreportkernel"></a><a id="WERREPORTKERNEL"></a><dl> <dt><b>WerReportKernel</b></dt> <dt>4</dt> </dl> </td>
///              <td width="60%"> An error in the kernel has occurred. </td> </tr> <tr> <td width="40%"><a
///              id="WerReportCritical"></a><a id="werreportcritical"></a><a id="WERREPORTCRITICAL"></a><dl>
///              <dt><b>WerReportCritical</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> A critical error, such as a crash or
///              non-response, has occurred. By default, processes that experience a critical error are terminated or restarted.
///              </td> </tr> <tr> <td width="40%"><a id="WerReportNonCritical"></a><a id="werreportnoncritical"></a><a
///              id="WERREPORTNONCRITICAL"></a><dl> <dt><b>WerReportNonCritical</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///              An error that is not critical has occurred. This type of report shows no UI; the report is silently queued. It
///              may then be sent silently to the server in the background if adequate user consent is available. </td> </tr>
///              </table>
///    pReportInformation = A pointer to a WER_REPORT_INFORMATION structure that specifies information for the report.
///    phReportHandle = A handle to the report. If the function fails, this handle is <b>NULL</b>.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure.
///    
@DllImport("wer")
HRESULT WerReportCreate(const(PWSTR) pwzEventType, WER_REPORT_TYPE repType, 
                        WER_REPORT_INFORMATION* pReportInformation, ptrdiff_t* phReportHandle);

///Sets the parameters that uniquely identify an event for the specified report.
///Params:
///    hReportHandle = A handle to the report. This handle is returned by the WerReportCreate function.
///    dwparamID = The identifier of the parameter to be set. This parameter can be one of the following values. <a id="WER_P0"></a>
///                <a id="wer_p0"></a>
///    pwzName = A pointer to a Unicode string that contains the name of the parameter. If this parameter is <b>NULL</b>, the
///              default name is P<i>x</i>, where <i>x</i> matches the integer portion of the value specified in <i>dwparamID</i>.
///    pwzValue = The parameter value.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt>
///    </dl> </td> <td width="60%"> The specified handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_LENGTH_EXCEEDED</b></dt> </dl> </td> <td width="60%"> The length of one or more string arguments has
///    exceeded its limit. </td> </tr> </table>
///    
@DllImport("wer")
HRESULT WerReportSetParameter(ptrdiff_t hReportHandle, uint dwparamID, const(PWSTR) pwzName, const(PWSTR) pwzValue);

///Adds a file to the specified report.
///Params:
///    hReportHandle = A handle to the report. This handle is returned by the WerReportCreate function.
///    pwzPath = A pointer to a Unicode string that contains the full path to the file to be added. This path can use environment
///              variables. The maximum length of this path is MAX_PATH characters.
///    repFileType = The type of file. This parameter can be one of the following values from the <b>WER_FILE_TYPE</b> enumeration
///                  type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WerFileTypeHeapdump"></a><a
///                  id="werfiletypeheapdump"></a><a id="WERFILETYPEHEAPDUMP"></a><dl> <dt><b>WerFileTypeHeapdump</b></dt> </dl> </td>
///                  <td width="60%"> An extended minidump that contains additional data such as the process memory. </td> </tr> <tr>
///                  <td width="40%"><a id="WerFileTypeMicrodump"></a><a id="werfiletypemicrodump"></a><a
///                  id="WERFILETYPEMICRODUMP"></a><dl> <dt><b>WerFileTypeMicrodump</b></dt> </dl> </td> <td width="60%"> A limited
///                  minidump that contains only a stack trace. </td> </tr> <tr> <td width="40%"><a id="WerFileTypeMinidump"></a><a
///                  id="werfiletypeminidump"></a><a id="WERFILETYPEMINIDUMP"></a><dl> <dt><b>WerFileTypeMinidump</b></dt> </dl> </td>
///                  <td width="60%"> A minidump file. </td> </tr> <tr> <td width="40%"><a id="WerFileTypeOther"></a><a
///                  id="werfiletypeother"></a><a id="WERFILETYPEOTHER"></a><dl> <dt><b>WerFileTypeOther</b></dt> </dl> </td> <td
///                  width="60%"> Any other type of file. This file will always get added to the cab (but only if the server asks for
///                  a cab). </td> </tr> <tr> <td width="40%"><a id="WerFileTypeUserDocument"></a><a
///                  id="werfiletypeuserdocument"></a><a id="WERFILETYPEUSERDOCUMENT"></a><dl> <dt><b>WerFileTypeUserDocument</b></dt>
///                  </dl> </td> <td width="60%"> The document in use by the application at the time of the event. The document is
///                  added only if the server is asks for this type of document. </td> </tr> </table>
///    dwFileFlags = This parameter can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///                  <tr> <td width="40%"><a id="WER_FILE_ANONYMOUS_DATA"></a><a id="wer_file_anonymous_data"></a><dl>
///                  <dt><b>WER_FILE_ANONYMOUS_DATA</b></dt> </dl> </td> <td width="60%"> The file does not contain personal
///                  information that could be used to identify or contact the user. </td> </tr> <tr> <td width="40%"><a
///                  id="WER_FILE_DELETE_WHEN_DONE"></a><a id="wer_file_delete_when_done"></a><dl>
///                  <dt><b>WER_FILE_DELETE_WHEN_DONE</b></dt> </dl> </td> <td width="60%"> Automatically delete the file after the
///                  report is submitted. </td> </tr> </table>
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The specified file does not
///    exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td>
///    <td width="60%"> The specified file is a user-document and is stored on an encrypted file-system; this
///    combination is not supported. </td> </tr> </table>
///    
@DllImport("wer")
HRESULT WerReportAddFile(ptrdiff_t hReportHandle, const(PWSTR) pwzPath, WER_FILE_TYPE repFileType, 
                         uint dwFileFlags);

///Sets the user interface options for the specified report.
///Params:
///    hReportHandle = A handle to the report. This handle is returned by the WerReportCreate function.
///    repUITypeID = The user interface element to be customized. This parameter can be one of the following values from the
///                  <b>WER_REPORT_UI</b> enumeration type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="WerUIAdditionalDataDlgHeader"></a><a id="weruiadditionaldatadlgheader"></a><a
///                  id="WERUIADDITIONALDATADLGHEADER"></a><dl> <dt><b>WerUIAdditionalDataDlgHeader</b></dt> </dl> </td> <td
///                  width="60%"> The instructions for the additional data dialog box. </td> </tr> <tr> <td width="40%"><a
///                  id="WerUICloseDlgBody"></a><a id="weruiclosedlgbody"></a><a id="WERUICLOSEDLGBODY"></a><dl>
///                  <dt><b>WerUICloseDlgBody</b></dt> </dl> </td> <td width="60%"> The contents of the close dialog box. </td> </tr>
///                  <tr> <td width="40%"><a id="WerUICloseDlgButtonText"></a><a id="weruiclosedlgbuttontext"></a><a
///                  id="WERUICLOSEDLGBUTTONTEXT"></a><dl> <dt><b>WerUICloseDlgButtonText</b></dt> </dl> </td> <td width="60%"> The
///                  text for the button in the close dialog box. </td> </tr> <tr> <td width="40%"><a id="WerUICloseDlgHeader"></a><a
///                  id="weruiclosedlgheader"></a><a id="WERUICLOSEDLGHEADER"></a><dl> <dt><b>WerUICloseDlgHeader</b></dt> </dl> </td>
///                  <td width="60%"> The main instructions for the close dialog box. </td> </tr> <tr> <td width="40%"><a
///                  id="WerUICloseText"></a><a id="weruiclosetext"></a><a id="WERUICLOSETEXT"></a><dl> <dt><b>WerUICloseText</b></dt>
///                  </dl> </td> <td width="60%"> The text for the link to just terminate the application. </td> </tr> <tr> <td
///                  width="40%"><a id="WerUIConsentDlgBody"></a><a id="weruiconsentdlgbody"></a><a id="WERUICONSENTDLGBODY"></a><dl>
///                  <dt><b>WerUIConsentDlgBody</b></dt> </dl> </td> <td width="60%"> The contents of the consent dialog box. </td>
///                  </tr> <tr> <td width="40%"><a id="WerUIConsentDlgHeader"></a><a id="weruiconsentdlgheader"></a><a
///                  id="WERUICONSENTDLGHEADER"></a><dl> <dt><b>WerUIConsentDlgHeader</b></dt> </dl> </td> <td width="60%"> The main
///                  instructions for the consent dialog box. </td> </tr> <tr> <td width="40%"><a id="WerUIIconFilePath"></a><a
///                  id="weruiiconfilepath"></a><a id="WERUIICONFILEPATH"></a><dl> <dt><b>WerUIIconFilePath</b></dt> </dl> </td> <td
///                  width="60%"> The icon to be displayed in the consent dialog box. </td> </tr> <tr> <td width="40%"><a
///                  id="WerUIOfflineSolutionCheckText"></a><a id="weruiofflinesolutionchecktext"></a><a
///                  id="WERUIOFFLINESOLUTIONCHECKTEXT"></a><dl> <dt><b>WerUIOfflineSolutionCheckText</b></dt> </dl> </td> <td
///                  width="60%"> The text for the link to check for a solution when offline. </td> </tr> <tr> <td width="40%"><a
///                  id="WerUIOnlineSolutionCheckText"></a><a id="weruionlinesolutionchecktext"></a><a
///                  id="WERUIONLINESOLUTIONCHECKTEXT"></a><dl> <dt><b>WerUIOnlineSolutionCheckText</b></dt> </dl> </td> <td
///                  width="60%"> The text for the link to check for a solution when online. </td> </tr> </table>
///    pwzValue = A pointer to a Unicode string that specifies the custom text. For more information, see the description of
///               <i>repUITypeID</i>.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure.
///    
@DllImport("wer")
HRESULT WerReportSetUIOption(ptrdiff_t hReportHandle, WER_REPORT_UI repUITypeID, const(PWSTR) pwzValue);

///Submits the specified report.
///Params:
///    hReportHandle = A handle to the report. This handle is returned by the WerReportCreate function.
///    consent = The consent status. This parameter can be one of the following values from the <b>WER_CONSENT</b> enumeration
///              type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="WerConsentAlwaysPrompt"></a><a id="werconsentalwaysprompt"></a><a id="WERCONSENTALWAYSPROMPT"></a><dl>
///              <dt><b>WerConsentAlwaysPrompt</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The user is always asked to submit
///              the request. </td> </tr> <tr> <td width="40%"><a id="WerConsentApproved"></a><a id="werconsentapproved"></a><a
///              id="WERCONSENTAPPROVED"></a><dl> <dt><b>WerConsentApproved</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The
///              user has approved the submission request. </td> </tr> <tr> <td width="40%"><a id="WerConsentDenied"></a><a
///              id="werconsentdenied"></a><a id="WERCONSENTDENIED"></a><dl> <dt><b>WerConsentDenied</b></dt> <dt>3</dt> </dl>
///              </td> <td width="60%"> The user has denied the submission request. </td> </tr> <tr> <td width="40%"><a
///              id="WerConsentMax"></a><a id="werconsentmax"></a><a id="WERCONSENTMAX"></a><dl> <dt><b>WerConsentMax</b></dt>
///              <dt>5</dt> </dl> </td> <td width="60%"> The maximum value for the <b>WER_CONSENT</b> enumeration type. </td>
///              </tr> <tr> <td width="40%"><a id="WerConsentNotAsked"></a><a id="werconsentnotasked"></a><a
///              id="WERCONSENTNOTASKED"></a><dl> <dt><b>WerConsentNotAsked</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The
///              user was not asked for consent. </td> </tr> </table>
///    dwFlags = This parameter can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"><a id="WER_SUBMIT_ADD_REGISTERED_DATA"></a><a id="wer_submit_add_registered_data"></a><dl>
///              <dt><b>WER_SUBMIT_ADD_REGISTERED_DATA</b></dt> <dt>16</dt> </dl> </td> <td width="60%"> Add the data registered
///              by WerSetFlags, WerRegisterFile, and WerRegisterMemoryBlock to the report. </td> </tr> <tr> <td width="40%"><a
///              id="WER_SUBMIT_HONOR_RECOVERY"></a><a id="wer_submit_honor_recovery"></a><dl>
///              <dt><b>WER_SUBMIT_HONOR_RECOVERY</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Honor any recovery registration
///              for the application. For more information, see RegisterApplicationRecoveryCallback. </td> </tr> <tr> <td
///              width="40%"><a id="WER_SUBMIT_HONOR_RESTART"></a><a id="wer_submit_honor_restart"></a><dl>
///              <dt><b>WER_SUBMIT_HONOR_RESTART</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Honor any restart registration
///              for the application. For more information, see RegisterApplicationRestart. </td> </tr> <tr> <td width="40%"><a
///              id="WER_SUBMIT_NO_ARCHIVE"></a><a id="wer_submit_no_archive"></a><dl> <dt><b>WER_SUBMIT_NO_ARCHIVE</b></dt>
///              <dt>256</dt> </dl> </td> <td width="60%"> Do not archive the report. </td> </tr> <tr> <td width="40%"><a
///              id="WER_SUBMIT_NO_CLOSE_UI"></a><a id="wer_submit_no_close_ui"></a><dl> <dt><b>WER_SUBMIT_NO_CLOSE_UI</b></dt>
///              <dt>64</dt> </dl> </td> <td width="60%"> Do not display the close dialog box for the critical report. </td> </tr>
///              <tr> <td width="40%"><a id="WER_SUBMIT_NO_QUEUE"></a><a id="wer_submit_no_queue"></a><dl>
///              <dt><b>WER_SUBMIT_NO_QUEUE</b></dt> <dt>128</dt> </dl> </td> <td width="60%"> Do not queue the report. If there
///              is adequate user consent the report is sent to Microsoft immediately; otherwise, the report is discarded. You may
///              use this flag for non-critical reports. The report is discarded for any action that would require the report to
///              be queued. For example, if the computer is offline when you submit the report, the report is discarded. Also, if
///              there is insufficient consent (for example, consent was required for the data portion of the report), the report
///              is discarded. </td> </tr> <tr> <td width="40%"><a id="WER_SUBMIT_OUTOFPROCESS"></a><a
///              id="wer_submit_outofprocess"></a><dl> <dt><b>WER_SUBMIT_OUTOFPROCESS</b></dt> <dt>32</dt> </dl> </td> <td
///              width="60%"> Spawn another process to submit the report. The calling thread is blocked until the function
///              returns. </td> </tr> <tr> <td width="40%"><a id="WER_SUBMIT_OUTOFPROCESS_ASYNC"></a><a
///              id="wer_submit_outofprocess_async"></a><dl> <dt><b>WER_SUBMIT_OUTOFPROCESS_ASYNC</b></dt> <dt>1024</dt> </dl>
///              </td> <td width="60%"> Spawn another process to submit the report and return from this function call immediately.
///              Note that the contents of the <i>pSubmitResult</i> parameter are undefined and there is no way to query when the
///              reporting completes or the completion status. </td> </tr> <tr> <td width="40%"><a id="WER_SUBMIT_QUEUE"></a><a
///              id="wer_submit_queue"></a><dl> <dt><b>WER_SUBMIT_QUEUE</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> Add the
///              report to the WER queue without notifying the user. The report is queued only—reporting (sending the report to
///              Microsoft) occurs later based on the user's consent level. </td> </tr> <tr> <td width="40%"><a
///              id="WER_SUBMIT_SHOW_DEBUG"></a><a id="wer_submit_show_debug"></a><dl> <dt><b>WER_SUBMIT_SHOW_DEBUG</b></dt>
///              <dt>8</dt> </dl> </td> <td width="60%"> Show the debug button. </td> </tr> <tr> <td width="40%"><a
///              id="WER_SUBMIT_START_MINIMIZED"></a><a id="wer_submit_start_minimized"></a><dl>
///              <dt><b>WER_SUBMIT_START_MINIMIZED</b></dt> <dt>512</dt> </dl> </td> <td width="60%"> The initial UI is minimized
///              and flashing. </td> </tr> <tr> <td width="40%"><a id="WER_SUBMIT_BYPASS_DATA_THROTTLING"></a><a
///              id="wer_submit_bypass_data_throttling"></a><dl> <dt><b>WER_SUBMIT_BYPASS_DATA_THROTTLING</b></dt> <dt>2048</dt>
///              </dl> </td> <td width="60%"> Bypass data throttling for the report. <b>Windows 7 or earlier: </b>This parameter
///              is not available. </td> </tr> <tr> <td width="40%"><a id="WER_SUBMIT_ARCHIVE_PARAMETERS_ONLY"></a><a
///              id="wer_submit_archive_parameters_only"></a><dl> <dt><b>WER_SUBMIT_ARCHIVE_PARAMETERS_ONLY</b></dt> <dt>4096</dt>
///              </dl> </td> <td width="60%"> Archive only the parameters; the cab is discarded. This flag overrides the
///              ConfigureArchive WER setting. <b>Windows 7 or earlier: </b>This parameter is not available. </td> </tr> <tr> <td
///              width="40%"><a id="WER_SUBMIT_REPORT_MACHINE_ID"></a><a id="wer_submit_report_machine_id"></a><dl>
///              <dt><b>WER_SUBMIT_REPORT_MACHINE_ID</b></dt> <dt>8192</dt> </dl> </td> <td width="60%"> Always send the unique,
///              128-bit computer identifier with the report, regardless of the consent with which the report was submitted. See
///              Remarks for additional information. <b>Windows 7 or earlier: </b>This parameter is not available. </td> </tr>
///              </table>
///    pSubmitResult = The result of the submission. This parameter can be one of the following values from the <b>WER_SUBMIT_RESULT</b>
///                    enumeration type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="WerCustomAction"></a><a id="wercustomaction"></a><a id="WERCUSTOMACTION"></a><dl>
///                    <dt><b>WerCustomAction</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> Error reporting can be customized. </td>
///                    </tr> <tr> <td width="40%"><a id="WerDisabled"></a><a id="werdisabled"></a><a id="WERDISABLED"></a><dl>
///                    <dt><b>WerDisabled</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> Error reporting was disabled. </td> </tr>
///                    <tr> <td width="40%"><a id="WerDisabledQueue"></a><a id="werdisabledqueue"></a><a id="WERDISABLEDQUEUE"></a><dl>
///                    <dt><b>WerDisabledQueue</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> Queuing was disabled. </td> </tr> <tr>
///                    <td width="40%"><a id="WerReportAsync"></a><a id="werreportasync"></a><a id="WERREPORTASYNC"></a><dl>
///                    <dt><b>WerReportAsync</b></dt> <dt>8</dt> </dl> </td> <td width="60%"> The report was asynchronous. </td> </tr>
///                    <tr> <td width="40%"><a id="WerReportCancelled"></a><a id="werreportcancelled"></a><a
///                    id="WERREPORTCANCELLED"></a><dl> <dt><b>WerReportCancelled</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> The
///                    report was canceled. </td> </tr> <tr> <td width="40%"><a id="WerReportDebug"></a><a id="werreportdebug"></a><a
///                    id="WERREPORTDEBUG"></a><dl> <dt><b>WerReportDebug</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The Debug
///                    button was clicked. </td> </tr> <tr> <td width="40%"><a id="WerReportFailed"></a><a id="werreportfailed"></a><a
///                    id="WERREPORTFAILED"></a><dl> <dt><b>WerReportFailed</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The report
///                    submission failed. </td> </tr> <tr> <td width="40%"><a id="WerReportQueued"></a><a id="werreportqueued"></a><a
///                    id="WERREPORTQUEUED"></a><dl> <dt><b>WerReportQueued</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The report
///                    was queued. </td> </tr> <tr> <td width="40%"><a id="WerReportUploaded"></a><a id="werreportuploaded"></a><a
///                    id="WERREPORTUPLOADED"></a><dl> <dt><b>WerReportUploaded</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The
///                    report was uploaded. </td> </tr> </table>
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure.
///    
@DllImport("wer")
HRESULT WerReportSubmit(ptrdiff_t hReportHandle, WER_CONSENT consent, uint dwFlags, 
                        WER_SUBMIT_RESULT* pSubmitResult);

///Adds a dump of the specified type to the specified report.
///Params:
///    hReportHandle = A handle to the report. This handle is returned by the WerReportCreate function.
///    hProcess = A handle to the process for which the report is being generated. This handle must have the STANDARD_RIGHTS_READ
///               and PROCESS_QUERY_INFORMATION access rights.
///    hThread = A handle to the thread of <i>hProcess</i> for which the report is being generated. If <i>dumpType</i> is
///              WerDumpTypeMicro, this parameter is required. For other dump types, this parameter may be <b>NULL</b>.
///    dumpType = The type of minidump. This parameter can be one of the following values from the <b>WER_DUMP_TYPE</b> enumeration
///               type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WerDumpTypeHeapDump"></a><a
///               id="werdumptypeheapdump"></a><a id="WERDUMPTYPEHEAPDUMP"></a><dl> <dt><b>WerDumpTypeHeapDump</b></dt> </dl> </td>
///               <td width="60%"> An extended minidump that contains additional data such as the process memory. This type is
///               equivalent to creating a minidump with the following options: <ul> <li>MiniDumpWithDataSegs</li>
///               <li>MiniDumpWithProcessThreadData</li> <li>MiniDumpWithHandleData</li>
///               <li>MiniDumpWithPrivateReadWriteMemory</li> <li>MiniDumpWithUnloadedModules</li>
///               <li>MiniDumpWithFullMemoryInfo</li> <li>MiniDumpWithThreadInfo (Windows 7 and later)</li>
///               <li>MiniDumpWithTokenInformation (Windows 7 and later)</li> <li>MiniDumpWithPrivateWriteCopyMemory (Windows 7 and
///               later)</li> </ul> </td> </tr> <tr> <td width="40%"><a id="WerDumpTypeMicroDump"></a><a
///               id="werdumptypemicrodump"></a><a id="WERDUMPTYPEMICRODUMP"></a><dl> <dt><b>WerDumpTypeMicroDump</b></dt> </dl>
///               </td> <td width="60%"> A limited minidump that contains only a stack trace. This type is equivalent to creating a
///               minidump with the following options: <ul> <li>MiniDumpWithDataSegs</li> <li>MiniDumpWithUnloadedModules</li>
///               <li>MiniDumpWithProcessThreadData</li> <li>MiniDumpWithoutOptionalData</li> </ul> </td> </tr> <tr> <td
///               width="40%"><a id="WerDumpTypeMiniDump"></a><a id="werdumptypeminidump"></a><a id="WERDUMPTYPEMINIDUMP"></a><dl>
///               <dt><b>WerDumpTypeMiniDump</b></dt> </dl> </td> <td width="60%"> A minidump. This type is equivalent to creating
///               a minidump with the following options: <ul> <li>MiniDumpWithDataSegs</li> <li>MiniDumpWithUnloadedModules</li>
///               <li>MiniDumpWithProcessThreadData</li> <li>MiniDumpWithTokenInformation (Windows 7 and later)</li> </ul> </td>
///               </tr> </table>
///    pExceptionParam = A pointer to a WER_EXCEPTION_INFORMATION structure that specifies exception information.
///    pDumpCustomOptions = A pointer to a WER_DUMP_CUSTOM_OPTIONS structure that specifies custom minidump options. If this parameter is
///                         <b>NULL</b>, the standard minidump information is collected.
///    dwFlags = This parameter can be 0 or the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="WER_DUMP_NOHEAP_ONQUEUE"></a><a id="wer_dump_noheap_onqueue"></a><dl>
///              <dt><b>WER_DUMP_NOHEAP_ONQUEUE</b></dt> </dl> </td> <td width="60%"> If the report is being queued, do not
///              include a heap dump. Using this flag saves disk space. </td> </tr> </table>
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure.
///    
@DllImport("wer")
HRESULT WerReportAddDump(ptrdiff_t hReportHandle, HANDLE hProcess, HANDLE hThread, WER_DUMP_TYPE dumpType, 
                         WER_EXCEPTION_INFORMATION* pExceptionParam, WER_DUMP_CUSTOM_OPTIONS* pDumpCustomOptions, 
                         uint dwFlags);

///Closes the specified report.
///Params:
///    hReportHandle = A handle to the report. This handle is returned by the WerReportCreate function.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure.
///    
@DllImport("wer")
HRESULT WerReportCloseHandle(ptrdiff_t hReportHandle);

///Registers a file to be collected when WER creates an error report.
///Params:
///    pwzFile = The full path to the file. The maximum length of this path is MAX_PATH characters.
///    regFileType = The file type. This parameter can be one of the following values from the <b>WER_REGISTER_FILE_TYPE</b>
///                  enumeration type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="WerRegFileTypeMax"></a><a id="werregfiletypemax"></a><a id="WERREGFILETYPEMAX"></a><dl>
///                  <dt><b>WerRegFileTypeMax</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The maximum value for the
///                  <b>WER_REGISTER_FILE_TYPE</b> enumeration type. </td> </tr> <tr> <td width="40%"><a
///                  id="WerRegFileTypeOther"></a><a id="werregfiletypeother"></a><a id="WERREGFILETYPEOTHER"></a><dl>
///                  <dt><b>WerRegFileTypeOther</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Any other type of file. </td> </tr>
///                  <tr> <td width="40%"><a id="WerRegFileTypeUserDocument"></a><a id="werregfiletypeuserdocument"></a><a
///                  id="WERREGFILETYPEUSERDOCUMENT"></a><dl> <dt><b>WerRegFileTypeUserDocument</b></dt> <dt>1</dt> </dl> </td> <td
///                  width="60%"> The document in use by the application at the time of the event. This document is only collected if
///                  the Watson server asks for it. </td> </tr> </table>
///    dwFlags = This parameter can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"><a id="WER_FILE_ANONYMOUS_DATA"></a><a id="wer_file_anonymous_data"></a><dl>
///              <dt><b>WER_FILE_ANONYMOUS_DATA</b></dt> </dl> </td> <td width="60%"> The file does not contain personal
///              information that could be used to identify or contact the user. </td> </tr> <tr> <td width="40%"><a
///              id="WER_FILE_DELETE_WHEN_DONE"></a><a id="wer_file_delete_when_done"></a><dl>
///              <dt><b>WER_FILE_DELETE_WHEN_DONE</b></dt> </dl> </td> <td width="60%"> Automatically deletes the file after it is
///              added to the report. </td> </tr> </table>
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The number of
///    registered memory blocks and files exceeds the limit. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerRegisterFile(const(PWSTR) pwzFile, WER_REGISTER_FILE_TYPE regFileType, uint dwFlags);

///Removes a file from the list of files to be added to reports generated for the current process.
///Params:
///    pwzFilePath = The full path to the file. This file must have been registered using the WerRegisterFile function.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WER_E_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The list of registered files does not contain the specified file. </td> </tr>
///    </table>
///    
@DllImport("KERNEL32")
HRESULT WerUnregisterFile(const(PWSTR) pwzFilePath);

///Registers a memory block to be collected when WER creates an error report.
///Params:
///    pvAddress = The starting address of the memory block.
///    dwSize = The size of the memory block, in bytes. The maximum value for this parameter is WER_MAX_MEM_BLOCK_SIZE bytes.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The number of
///    registered memory blocks and files exceeds the limit. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerRegisterMemoryBlock(void* pvAddress, uint dwSize);

///Removes a memory block from the list of data to be collected during error reporting for the application.
///Params:
///    pvAddress = The starting address of the memory block. This memory block must have been registered using the
///                WerRegisterMemoryBlock function.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WER_E_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The list of registered memory blocks does not contain the specified memory block.
///    </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerUnregisterMemoryBlock(void* pvAddress);

///Marks a memory block (that is normally included by default in error reports) to be excluded from the error report.
///Params:
///    address = The starting address of the memory block.
///    size = The size of the memory block, in bytes.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>address</i> is <b>NULL</b> or <i>size</i> is 0.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> WER could not
///    allocate a large enough heap for the data </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The number of
///    registered entries exceeds the limit (<b>WER_MAX_REGISTERED_ENTRIES</b>). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerRegisterExcludedMemoryBlock(const(void)* address, uint size);

///Removes a memory block that was previously marked as excluded (it will again be included in error reports).
///Params:
///    address = The starting address of the memory block. This memory block must have been registered using the
///              WerRegisterExcludedMemoryBlock function.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerUnregisterExcludedMemoryBlock(const(void)* address);

///Registers app-specific metadata to be collected (in the form of key/value strings) when WER creates an error report.
///Params:
///    key = The "key" string for the metadata element being registered.
///    value = The value string for the metadata element being registered.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Strings were <b>NULL</b>, key length was greater than
///    64 characters or was an invalid xml element name, or<i>value</i> length was greater than 128 characters or
///    contained characters that were not ASCII printable characters. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> WER could not allocate a large enough heap for the
///    data </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl>
///    </td> <td width="60%"> The maximum number of registered entries (<b>WER_MAX_REGISTERED_ENTRIES</b>) or maximum
///    amount of registered metadata (<b>WER_MAX_REGISTERED_METADATA</b>) has been reached. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not
///    valid. For example, the process is in application recovery mode. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerRegisterCustomMetadata(const(PWSTR) key, const(PWSTR) value);

///Removes an item of app-specific metadata being collected during error reporting for the application.
///Params:
///    key = The "key" string for the metadata element being removed. It must have been previously registered with the
///          WerRegisterCustomMetadata function.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WER_E_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> WER could not find the metadata item to remove. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerUnregisterCustomMetadata(const(PWSTR) key);

///Registers a process to be included in the error report along with the main application process. Optionally specifies
///a thread within that registered process to get additional data from.
///Params:
///    processId = The Id of the process to register.
///    captureExtraInfoForThreadId = The Id of a thread within the registered process from which more information is requested.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>processId</i> is 0. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> WER could not allocate a large
///    enough heap for the data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> Number of WER
///    registered entries (memory blocks, metadata, files) exceeds max (<b>WER_MAX_REGISTERED_ENTRIES</b>) or number of
///    processes exceeds max (<b>WER_MAX_REGISTERED_DUMPCOLLECTION</b>) </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerRegisterAdditionalProcess(uint processId, uint captureExtraInfoForThreadId);

///Removes a process from the list of additional processes to be included in the error report.
///Params:
///    processId = The Id of the process to remove. It must have been previously registered with WerRegisterAdditionalProcess.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WER_E_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The list of registered processes does not contain the specified process. </td> </tr>
///    </table>
///    
@DllImport("KERNEL32")
HRESULT WerUnregisterAdditionalProcess(uint processId);

///Registers a path, relative to the [LocalFolder](/uwp/api/windows.storage.applicationdata.localfolder) of the packaged
///application, where a copy of the diagnostic memory dump that Windows Error Reporting (WER) collects when one of the
///processes for the application stops responding should be saved.
///Params:
///    localAppDataRelativePath = The path relative to the local app store for the calling application where WER should save a copy of the
///                               diagnostic memory dump that WER collects when one of the processes for the application stops responding. The
///                               maximum length for this relative path in characters is **WER_MAX_LOCAL_DUMP_SUBPATH_LENGTH**, which has a value
///                               of 64. This maximum length includes the null-termination character.
///Returns:
///    This function returns **S_OK** on success or an error code on failure, including the following error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt>**WER_E_INVALID_STATE**</dt> </dl> </td> <td width="60%"> The process cannot store the memory dump, or WER
///    cannot create a location to store the memory dump. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt>**E_INVALIDARG**</dt> </dl> </td> <td width="60%"> The <i>localAppDataRelativePath</i> parameter is NULL or
///    is longer than 64 characters. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerRegisterAppLocalDump(const(PWSTR) localAppDataRelativePath);

///Cancels the registration that was made by calling the WerRegisterAppLocalDump function to specify that Windows Error
///Reporting (WER) should save a copy of the diagnostic memory dump that WER collects when one of the processes for the
///application stops responding.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("KERNEL32")
HRESULT WerUnregisterAppLocalDump();

///Sets the fault reporting settings for the current process.
///Params:
///    dwFlags = The fault reporting settings. You can specify one or more of the following values: <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WER_FAULT_REPORTING_FLAG_DISABLE_THREAD_SUSPENSION"></a><a
///              id="wer_fault_reporting_flag_disable_thread_suspension"></a><dl>
///              <dt><b>WER_FAULT_REPORTING_FLAG_DISABLE_THREAD_SUSPENSION</b></dt> </dl> </td> <td width="60%"> Do not suspend
///              the process threads before reporting the error. </td> </tr> <tr> <td width="40%"><a
///              id="WER_FAULT_REPORTING_FLAG_NOHEAP"></a><a id="wer_fault_reporting_flag_noheap"></a><dl>
///              <dt><b>WER_FAULT_REPORTING_FLAG_NOHEAP</b></dt> </dl> </td> <td width="60%"> Do not collect heap information in
///              the event of an application crash or non-response. </td> </tr> <tr> <td width="40%"><a
///              id="WER_FAULT_REPORTING_FLAG_QUEUE"></a><a id="wer_fault_reporting_flag_queue"></a><dl>
///              <dt><b>WER_FAULT_REPORTING_FLAG_QUEUE</b></dt> </dl> </td> <td width="60%"> Queue critical reports. </td> </tr>
///              <tr> <td width="40%"><a id="WER_FAULT_REPORTING_FLAG_QUEUE_UPLOAD"></a><a
///              id="wer_fault_reporting_flag_queue_upload"></a><dl> <dt><b>WER_FAULT_REPORTING_FLAG_QUEUE_UPLOAD</b></dt> </dl>
///              </td> <td width="60%"> Queue critical reports and upload from the queue. </td> </tr> <tr> <td width="40%"><a
///              id="WER_FAULT_REPORTING_ALWAYS_SHOW_UI"></a><a id="wer_fault_reporting_always_show_ui"></a><dl>
///              <dt><b>WER_FAULT_REPORTING_ALWAYS_SHOW_UI</b></dt> </dl> </td> <td width="60%"> Always show error reporting UI
///              for this process. This is applicable for interactive applications only. </td> </tr> </table>
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure.
///    
@DllImport("KERNEL32")
HRESULT WerSetFlags(uint dwFlags);

///Retrieves the fault reporting settings for the specified process.
///Params:
///    hProcess = A handle to the process. This handle must have the PROCESS_VM_READ or PROCESS_QUERY_INFORMATION access right.
///    pdwFlags = This parameter can contain one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///               </tr> <tr> <td width="40%"><a id="WER_FAULT_REPORTING_FLAG_DISABLE_THREAD_SUSPENSION"></a><a
///               id="wer_fault_reporting_flag_disable_thread_suspension"></a><dl>
///               <dt><b>WER_FAULT_REPORTING_FLAG_DISABLE_THREAD_SUSPENSION</b></dt> </dl> </td> <td width="60%"> Do not suspend
///               the process threads before reporting the error. </td> </tr> <tr> <td width="40%"><a
///               id="WER_FAULT_REPORTING_FLAG_NOHEAP"></a><a id="wer_fault_reporting_flag_noheap"></a><dl>
///               <dt><b>WER_FAULT_REPORTING_FLAG_NOHEAP</b></dt> </dl> </td> <td width="60%"> Do not collect heap information in
///               the event of an application crash or non-response. </td> </tr> <tr> <td width="40%"><a
///               id="WER_FAULT_REPORTING_FLAG_QUEUE"></a><a id="wer_fault_reporting_flag_queue"></a><dl>
///               <dt><b>WER_FAULT_REPORTING_FLAG_QUEUE</b></dt> </dl> </td> <td width="60%"> Queue critical reports for the
///               specified process. This does not show any UI. </td> </tr> <tr> <td width="40%"><a
///               id="WER_FAULT_REPORTING_FLAG_QUEUE_UPLOAD"></a><a id="wer_fault_reporting_flag_queue_upload"></a><dl>
///               <dt><b>WER_FAULT_REPORTING_FLAG_QUEUE_UPLOAD</b></dt> </dl> </td> <td width="60%"> Queue critical reports and
///               upload from the queue. </td> </tr> <tr> <td width="40%"><a id="WER_FAULT_REPORTING_ALWAYS_SHOW_UI"></a><a
///               id="wer_fault_reporting_always_show_ui"></a><dl> <dt><b>WER_FAULT_REPORTING_ALWAYS_SHOW_UI</b></dt> </dl> </td>
///               <td width="60%"> Always show error reporting UI for this process. This is applicable for interactive applications
///               only. </td> </tr> </table>
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure.
///    
@DllImport("KERNEL32")
HRESULT WerGetFlags(HANDLE hProcess, uint* pdwFlags);

///Adds the specified application to the list of applications that are to be excluded from error reporting.
///Params:
///    pwzExeName = A pointer to a Unicode string that specifies the name of the executable file for the application, including the
///                 file name extension. The maximum length of this path is MAX_PATH characters.
///    bAllUsers = If this parameter is <b>TRUE</b>, the application name is added to the list of excluded applications for all
///                users. Otherwise, it is only added to the list of excluded applications for the current user.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The process does not have permissions to update the
///    list in the registry. See the Remarks section for additional information. </td> </tr> </table>
///    
@DllImport("wer")
HRESULT WerAddExcludedApplication(const(PWSTR) pwzExeName, BOOL bAllUsers);

///Removes the specified application from the list of applications that are to be excluded from error reporting.
///Params:
///    pwzExeName = A pointer to a Unicode string that specifies the name of the executable file for the application, including the
///                 file name extension. The maximum length of this path is MAX_PATH characters. This file must have been excluded
///                 using the WerAddExcludedApplication function or <b>WerRemoveExcludedApplication</b> fails.
///    bAllUsers = If this parameter is <b>TRUE</b>, the application name is removed from the list of excluded applications for all
///                users. Otherwise, it is only removed from the list of excluded applications for the current user.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The process does not have access to update the list
///    in the registry. See the Remarks section for additional information. </td> </tr> </table>
///    
@DllImport("wer")
HRESULT WerRemoveExcludedApplication(const(PWSTR) pwzExeName, BOOL bAllUsers);

///Registers a custom runtime exception handler that is used to provide custom error reporting for crashes.
///Params:
///    pwszOutOfProcessCallbackDll = The name of the exception handler DLL to register.
///    pContext = A pointer to arbitrary context information that is passed to the handler's callback functions.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The number of
///    registered runtime exception modules exceeds the limit. A process can register up to
///    WER_MAX_REGISTERED_RUNTIME_EXCEPTION_MODULES handlers. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerRegisterRuntimeExceptionModule(const(PWSTR) pwszOutOfProcessCallbackDll, void* pContext);

///Removes the registration of your WER exception handler.
///Params:
///    pwszOutOfProcessCallbackDll = The name of the exception handler DLL whose registration you want to remove.
///    pContext = A pointer to arbitrary context information that was passed to the callback.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WER_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The process state is not valid. For example, the
///    process is in application recovery mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WER_E_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The list of registered runtime exception handlers does not contain the specified
///    exception handler. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT WerUnregisterRuntimeExceptionModule(const(PWSTR) pwszOutOfProcessCallbackDll, void* pContext);

///Opens the collection of stored error reports.
///Params:
///    repStoreType = The type of report store to open. See Remarks for details.
///    phReportStore = A pointer to a report store. On a successful call, this will point to the retrieved report store.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is not a valid value. </td> </tr>
///    </table>
///    
@DllImport("wer")
HRESULT WerStoreOpen(REPORT_STORE_TYPES repStoreType, void** phReportStore);

///Closes the collection of stored reports.
///Params:
///    hReportStore = The error report store to close (previously retrieved with WerStoreOpen).
@DllImport("wer")
void WerStoreClose(void* hReportStore);

///Gets a reference to the first report in the report store.
///Params:
///    hReportStore = The error report store (previously retrieved with WerStoreOpen).
///    ppszReportKey = A pointer to the report key string. On a successful call, this will point to the retrieved report key.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is not a valid value. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_FILES</b></dt> </dl> </td> <td width="60%"> There are no error
///    reports in the store. </td> </tr> </table>
///    
@DllImport("wer")
HRESULT WerStoreGetFirstReportKey(void* hReportStore, PWSTR* ppszReportKey);

///Gets a reference to the next report in the error report store.
///Params:
///    hReportStore = The error report store (previously retrieved with WerStoreOpen).
///    ppszReportKey = A pointer to the report key string. On a successful call, this will point to the retrieved report key.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is not a valid value. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_FILES</b></dt> </dl> </td> <td width="60%"> There are no more
///    error reports in the store. </td> </tr> </table>
///    
@DllImport("wer")
HRESULT WerStoreGetNextReportKey(void* hReportStore, PWSTR* ppszReportKey);

///Retrieves metadata about a report in the store.
///Params:
///    hReportStore = The error report store (previously retrieved with WerStoreOpen).
///    pszReportKey = The string identifying which report is being queried (previously retrieved with WerStoreGetFirstReportKey or
///                   WerStoreGetNextReportKey).
///    pReportMetadata = A pointer to the report store metadata in the form of a WER_REPORT_METADATA_V2 structure. The field
///                      <b>SizeOfFileNames</b> should be set to 0 during the first call. The function updates this field with the
///                      required size to hold the file names associated with the report. The field <b>FileNames</b> should then be
///                      allocated with <b>SizeOfFileNames</b> bytes and the function should be called again to get all of the file names.
///Returns:
///    This function returns <b>S_OK</b> on success or an error code on failure, including the following error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is not a valid value. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> There is not
///    enough memory available to retrieve the metadata. In this case, the caller should allocate memory of size
///    <b>SizeOfFileNames</b> for the <b>FileNames</b> field, found in the WER_REPORT_METADATA_V2 structure, and call
///    the function again. </td> </tr> </table>
///    
@DllImport("wer")
HRESULT WerStoreQueryReportMetadataV2(void* hReportStore, const(PWSTR) pszReportKey, 
                                      WER_REPORT_METADATA_V2* pReportMetadata);

@DllImport("wer")
HRESULT WerStoreQueryReportMetadataV3(void* hReportStore, const(PWSTR) pszReportKey, 
                                      WER_REPORT_METADATA_V3* pReportMetadata);

///Frees up the memory used to store a report key string. This should be called after each successive call to
///WerStoreGetFirstReportKey or WerStoreGetNextReportKey, once the particular report key string has been used and is no
///longer needed.
///Params:
///    pwszStr = The string to be freed (value set to <b>NULL</b>).
@DllImport("wer")
void WerFreeString(const(PWSTR) pwszStr);

@DllImport("wer")
HRESULT WerStorePurge();

@DllImport("wer")
HRESULT WerStoreGetReportCount(void* hReportStore, uint* pdwReportCount);

@DllImport("wer")
HRESULT WerStoreGetSizeOnDisk(void* hReportStore, ulong* pqwSizeInBytes);

@DllImport("wer")
HRESULT WerStoreQueryReportMetadataV1(void* hReportStore, const(PWSTR) pszReportKey, 
                                      WER_REPORT_METADATA_V1* pReportMetadata);

@DllImport("wer")
HRESULT WerStoreUploadReport(void* hReportStore, const(PWSTR) pszReportKey, uint dwFlags, 
                             WER_SUBMIT_RESULT* pSubmitResult);

///Enables an application that performs its own exception handling to report faults to Microsoft. Although you can use
///this function to report application crashes, we recommend that applications not handle fatal errors directly but
///instead rely on the crash reporting capability provided by the operating system.
///Params:
///    pep = A pointer to an EXCEPTION_POINTERS structure.
///    dwOpt = This parameter is reserved for system use and should be set to zero.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>frrvErr</b></dt> </dl> </td> <td width="60%"> The function failed but the error
///    reporting client was launched. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>frrvErrNoDW</b></dt> </dl> </td> <td
///    width="60%"> The error reporting client was unable to launch. The system will perform its default actions, such
///    as displaying the standard exception dialog box and launching the debugger. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>frrvErrTimeout</b></dt> </dl> </td> <td width="60%"> The function timed out. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>frrvLaunchDebugger</b></dt> </dl> </td> <td width="60%"> The function succeeded and the
///    user launched the debugger. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>frrvOk</b></dt> </dl> </td> <td
///    width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>frrvOkHeadless</b></dt> </dl>
///    </td> <td width="60%"> The function succeeded and the error reporting client was launched in silent reporting
///    mode (no UI is used). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>frrvOkManifest</b></dt> </dl> </td> <td
///    width="60%"> The function succeeded and the error reporting client was launched in manifest reporting mode. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>frrvOkQueued</b></dt> </dl> </td> <td width="60%"> The function succeeded
///    and the fault report was queued for later reporting. </td> </tr> </table> These return values indicate whether
///    the reporting application was successfully launched. A successful return value does not necessarily indicate that
///    the fault was successfully reported.
///    
@DllImport("faultrep")
EFaultRepRetVal ReportFault(EXCEPTION_POINTERS* pep, uint dwOpt);

///<p class="CCE_Message">[The AddERExcludedApplication function is available for use in the operating systems specified
///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
///WerAddExcludedApplication function.] Excludes the specified application from error reporting.
///Params:
///    szApplication = The name of the executable file for the application, including the file name extension. The name cannot contain
///                    path information.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, see GetLastError.
///    
@DllImport("faultrep")
BOOL AddERExcludedApplicationA(const(PSTR) szApplication);

///[The AddERExcludedApplication function is available for use in the operating systems specified in the Requirements
///section. It may be altered or unavailable in subsequent versions. Instead, use the [WerAddExcludedApplication
///function](../werapi/nf-werapi-weraddexcludedapplication.md).] Excludes the specified application from error
///reporting.
///Params:
///    wszApplication = The name of the executable file for the application, including the file name extension. The name cannot contain
///                     path information.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, see GetLastError.
///    
@DllImport("faultrep")
BOOL AddERExcludedApplicationW(const(PWSTR) wszApplication);

///Initiates "no response" reporting on the specified window.
///Params:
///    hwndHungApp = Handle to the window that is not responding.
///    pwzHungApplicationName = The name of the not-responding application to be shown in the Hang Reporting UI. The name is limited to 128
///                             characters including the <b>NULL</b> terminator. If <b>NULL</b>, WER tries to get the name from the target image
///                             resources. If it cannot get the name from the image, the image name will be used.
///Returns:
///    Returns S_OK if the function was able to initiate the reporting or an error code on failure. Note that S_OK does
///    not necessarily mean that "no response" reporting has completed successfully, only that it was initiated.
///    
@DllImport("faultrep")
HRESULT WerReportHang(HWND hwndHungApp, const(PWSTR) pwzHungApplicationName);


