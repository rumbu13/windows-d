// Written in the D programming language.

module windows.recovery;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsprogramming : APPLICATION_RECOVERY_CALLBACK;

extern(Windows):


// Functions

///Registers the active instance of an application for recovery.
///Params:
///    pRecoveyCallback = A pointer to the recovery callback function. For more information, see ApplicationRecoveryCallback.
///    pvParameter = A pointer to a variable to be passed to the callback function. Can be <b>NULL</b>.
///    dwPingInterval = The recovery ping interval, in milliseconds. By default, the interval is 5 seconds
///                     (RECOVERY_DEFAULT_PING_INTERVAL). The maximum interval is 5 minutes. If you specify zero, the default interval is
///                     used. You must call the ApplicationRecoveryInProgress function within the specified interval to indicate to ARR
///                     that you are still actively recovering; otherwise, WER terminates recovery. Typically, you perform recovery in a
///                     loop with each iteration lasting no longer than the ping interval. Each iteration performs a block of recovery
///                     work followed by a call to <b>ApplicationRecoveryInProgress</b>. Since you also use
///                     <b>ApplicationRecoveryInProgress</b> to determine if the user wants to cancel recovery, you should consider a
///                     smaller interval, so you do not perform a lot of work unnecessarily.
///    dwFlags = Reserved for future use. Set to zero.
///Returns:
///    This function returns <b>S_OK</b> on success or one of the following error codes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
///    width="60%"> Internal error; the registration failed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The ping interval cannot be more than five minutes.
///    </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT RegisterApplicationRecoveryCallback(APPLICATION_RECOVERY_CALLBACK pRecoveyCallback, void* pvParameter, 
                                            uint dwPingInterval, uint dwFlags);

///Removes the active instance of an application from the recovery list.
///Returns:
///    This function returns <b>S_OK</b> on success or one of the following error codes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
///    width="60%"> Internal error. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT UnregisterApplicationRecoveryCallback();

///Registers the active instance of an application for restart.
///Params:
///    pwzCommandline = A pointer to a Unicode string that specifies the command-line arguments for the application when it is restarted.
///                     The maximum size of the command line that you can specify is RESTART_MAX_CMD_LINE characters. Do not include the
///                     name of the executable in the command line; this function adds it for you. If this parameter is <b>NULL</b> or an
///                     empty string, the previously registered command line is removed. If the argument contains spaces, use quotes
///                     around the argument.
///    dwFlags = This parameter can be 0 or one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///              </tr> <tr> <td width="40%"><a id="RESTART_NO_CRASH"></a><a id="restart_no_crash"></a><dl>
///              <dt><b>RESTART_NO_CRASH</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Do not restart the process if it
///              terminates due to an unhandled exception. </td> </tr> <tr> <td width="40%"><a id="RESTART_NO_HANG"></a><a
///              id="restart_no_hang"></a><dl> <dt><b>RESTART_NO_HANG</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Do not
///              restart the process if it terminates due to the application not responding. </td> </tr> <tr> <td width="40%"><a
///              id="RESTART_NO_PATCH"></a><a id="restart_no_patch"></a><dl> <dt><b>RESTART_NO_PATCH</b></dt> <dt>4</dt> </dl>
///              </td> <td width="60%"> Do not restart the process if it terminates due to the installation of an update. </td>
///              </tr> <tr> <td width="40%"><a id="RESTART_NO_REBOOT"></a><a id="restart_no_reboot"></a><dl>
///              <dt><b>RESTART_NO_REBOOT</b></dt> <dt>8</dt> </dl> </td> <td width="60%"> Do not restart the process if the
///              computer is restarted as the result of an update. </td> </tr> </table>
///Returns:
///    This function returns <b>S_OK</b> on success or one of the following error codes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
///    width="60%"> Internal error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> The specified command line is too long. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT RegisterApplicationRestart(const(wchar)* pwzCommandline, uint dwFlags);

///Removes the active instance of an application from the restart list.
///Returns:
///    This function returns <b>S_OK</b> on success or one of the following error codes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
///    width="60%"> Internal error. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT UnregisterApplicationRestart();

///Retrieves a pointer to the callback routine registered for the specified process. The address returned is in the
///virtual address space of the process.
///Params:
///    hProcess = A handle to the process. This handle must have the PROCESS_VM_READ access right.
///    pRecoveryCallback = A pointer to the recovery callback function. For more information, see ApplicationRecoveryCallback.
///    ppvParameter = A pointer to the callback parameter.
///    pdwPingInterval = The recovery ping interval, in 100-nanosecond intervals.
///    pdwFlags = Reserved for future use.
///Returns:
///    This function returns <b>S_OK</b> on success or one of the following error codes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
///    width="60%"> The application did not register for recovery. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are not valid. </td> </tr>
///    </table>
///    
@DllImport("KERNEL32")
HRESULT GetApplicationRecoveryCallback(HANDLE hProcess, APPLICATION_RECOVERY_CALLBACK* pRecoveryCallback, 
                                       void** ppvParameter, uint* pdwPingInterval, uint* pdwFlags);

///Retrieves the restart information registered for the specified process.
///Params:
///    hProcess = A handle to the process. This handle must have the PROCESS_VM_READ access right.
///    pwzCommandline = A pointer to a buffer that receives the restart command line specified by the application when it called the
///                     RegisterApplicationRestart function. The maximum size of the command line, in characters, is
///                     RESTART_MAX_CMD_LINE. Can be <b>NULL</b> if <i>pcchSize</i> is zero.
///    pcchSize = On input, specifies the size of the <i>pwzCommandLine</i> buffer, in characters. If the buffer is not large
///               enough to receive the command line, the function fails with HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER) and
///               sets this parameter to the required buffer size, in characters. On output, specifies the size of the buffer that
///               was used. To determine the required buffer size, set <i>pwzCommandLine</i> to <b>NULL</b> and this parameter to
///               zero. The size includes one for the <b>null</b>-terminator character. Note that the function returns S_OK, not
///               HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER) in this case.
///    pdwFlags = A pointer to a variable that receives the flags specified by the application when it called the
///               RegisterApplicationRestart function.
///Returns:
///    This function returns <b>S_OK</b> on success or one of the following error codes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> One or more parameters are not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The application did not register
///    for restart. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt>
///    </dl> </td> <td width="60%"> The <i>pwzCommandLine</i> buffer is too small. The function returns the required
///    buffer size in <i>pcchSize</i>. Use the required size to reallocate the buffer. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT GetApplicationRestartSettings(HANDLE hProcess, const(wchar)* pwzCommandline, uint* pcchSize, 
                                      uint* pdwFlags);

///Indicates that the calling application is continuing to recover data.
///Params:
///    pbCancelled = Indicates whether the user has canceled the recovery process. Set by WER if the user clicks the Cancel button.
///Returns:
///    This function returns <b>S_OK</b> on success or one of the following error codes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
///    width="60%"> You can call this function only after Windows Error Reporting has called your recovery callback
///    function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
///    <i>pbCancelled</i> cannot be <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
HRESULT ApplicationRecoveryInProgress(int* pbCancelled);

///Indicates that the calling application has completed its data recovery.
///Params:
///    bSuccess = Specify <b>TRUE</b> to indicate that the data was successfully recovered; otherwise, <b>FALSE</b>.
@DllImport("KERNEL32")
void ApplicationRecoveryFinished(BOOL bSuccess);


