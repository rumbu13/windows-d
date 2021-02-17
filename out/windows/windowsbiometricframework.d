// Written in the D programming language.

module windows.windowsbiometricframework;

public import windows.core;
public import windows.com : HRESULT;
public import windows.displaydevices : POINT, RECT;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, OVERLAPPED;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


alias WINBIO_ANTI_SPOOF_POLICY_ACTION = int;
enum : int
{
    WINBIO_ANTI_SPOOF_DISABLE = 0x00000000,
    WINBIO_ANTI_SPOOF_ENABLE  = 0x00000001,
    WINBIO_ANTI_SPOOF_REMOVE  = 0x00000002,
}

alias WINBIO_POLICY_SOURCE = int;
enum : int
{
    WINBIO_POLICY_UNKNOWN = 0x00000000,
    WINBIO_POLICY_DEFAULT = 0x00000001,
    WINBIO_POLICY_LOCAL   = 0x00000002,
    WINBIO_POLICY_ADMIN   = 0x00000003,
}

alias WINBIO_CREDENTIAL_TYPE = int;
enum : int
{
    WINBIO_CREDENTIAL_PASSWORD = 0x00000001,
    WINBIO_CREDENTIAL_ALL      = 0xffffffff,
}

alias WINBIO_CREDENTIAL_FORMAT = int;
enum : int
{
    WINBIO_PASSWORD_GENERIC   = 0x00000001,
    WINBIO_PASSWORD_PACKED    = 0x00000002,
    WINBIO_PASSWORD_PROTECTED = 0x00000003,
}

alias WINBIO_CREDENTIAL_STATE = int;
enum : int
{
    WINBIO_CREDENTIAL_NOT_SET = 0x00000001,
    WINBIO_CREDENTIAL_SET     = 0x00000002,
}

///Defines constants that specify how completion notifications for asynchronous operations are to be delivered to the
///client application. This enumeration is used by the WinBioAsyncOpenFramework and WinBioAsyncOpenSession functions.
alias WINBIO_ASYNC_NOTIFICATION_METHOD = int;
enum : int
{
    ///The operation is synchronous.
    WINBIO_ASYNC_NOTIFY_NONE          = 0x00000000,
    ///The client-implemented PWINBIO_ASYNC_COMPLETION_CALLBACK function is called by the framework.
    WINBIO_ASYNC_NOTIFY_CALLBACK      = 0x00000001,
    ///The framework sends completion notices to the client application window message queue.
    WINBIO_ASYNC_NOTIFY_MESSAGE       = 0x00000002,
    ///The maximum enumeration value. This constant is not directly used by the WinBioAsyncOpenFramework and
    ///WinBioAsyncOpenSession.
    WINBIO_ASYNC_NOTIFY_MAXIMUM_VALUE = 0x00000003,
}

// Callbacks

///Called by the Windows Biometric Framework to notify the client application that an asynchronous operation has
///completed. The callback is defined by the client application and called by the Windows Biometric Framework.
///Params:
///    AsyncResult = Pointer to a WINBIO_ASYNC_RESULT structure that contains information about the completed operation. The structure
///                  is created by the Windows Biometric Framework. You must call WinBioFree to release the structure.
alias PWINBIO_ASYNC_COMPLETION_CALLBACK = void function(WINBIO_ASYNC_RESULT* AsyncResult);
///Called by the Windows Biometric Framework to return results from the asynchronous WinBioVerifyWithCallback function.
///The client application must implement this function. <div class="alert"><b>Important</b> We recommend that, beginning
///with Windows 8, you no longer use the <b>PWINBIO_VERIFY_CALLBACK</b>/<b>WinBioVerifyWithCallback</b> combination.
///Instead, do the following:<ul> <li>Implement a PWINBIO_ASYNC_COMPLETION_CALLBACK function to receive notice when the
///operation completes.</li> <li>Call the WinBioAsyncOpenSession function. Pass the address of your callback in the
///<i>CallbackRoutine</i> parameter. Pass <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b> in the <i>NotificationMethod</i>
///parameter. Retrieve an asynchronous session handle.</li> <li>Use the asynchronous session handle to call
///WinBioVerify. When the operation finishes, the Windows Biometric Framework will allocate and initialize a
///WINBIO_ASYNC_RESULT structure with the results and invoke your callback with a pointer to the results structure.</li>
///<li>Call WinBioFree from your callback implementation to release the WINBIO_ASYNC_RESULT structure after you have
///finished using it.</li> </ul> </div> <div> </div>
///Params:
///    VerifyCallbackContext = Pointer to a buffer defined by the application and passed to the <i>VerifyCallbackContext</i> parameter of the
///                            WinBioVerifyWithCallback function. The buffer is not modified by the framework or the biometric unit. Your
///                            application can use the data to help it determine what actions to perform or to maintain additional information
///                            about the biometric capture.
///    OperationStatus = Error code returned by the capture operation.
///    UnitId = Biometric unit ID number.
///    Match = A Boolean value that specifies whether the captured sample matched the user identity specified by the
///            <i>Identity</i> parameter.
///    RejectDetail = Additional information about the failure, if any, to perform the operation. For more information, see Remarks.
alias PWINBIO_VERIFY_CALLBACK = void function(void* VerifyCallbackContext, HRESULT OperationStatus, uint UnitId, 
                                              ubyte Match, uint RejectDetail);
///The <b>PWINBIO_IDENTIFY_CALLBACK</b> function is called by the Windows Biometric Framework to return results from the
///asynchronous WinBioIdentifyWithCallback function. The client application must implement this function. <div
///class="alert"><b>Important</b> We recommend that, beginning with Windows 8, you no longer use the
///<b>PWINBIO_IDENTIFY_CALLBACK</b>/<b>WinBioIdentifyWithCallback</b> combination. Instead, do the following:<ul>
///<li>Implement a PWINBIO_ASYNC_COMPLETION_CALLBACK function to receive notice when the operation completes.</li>
///<li>Call the WinBioAsyncOpenSession function. Pass the address of your callback in the <i>CallbackRoutine</i>
///parameter. Pass <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b> in the <i>NotificationMethod</i> parameter. Retrieve an
///asynchronous session handle.</li> <li>Use the asynchronous session handle to call WinBioIdentify. When the operation
///finishes, the Windows Biometric Framework will allocate and initialize a WINBIO_ASYNC_RESULT structure with the
///results and invoke your callback with a pointer to the results structure.</li> <li>Call WinBioFree from your callback
///implementation to release the WINBIO_ASYNC_RESULT structure after you have finished using it.</li> </ul> </div> <div>
///</div>
///Params:
///    IdentifyCallbackContext = Pointer to a buffer defined by the application and passed to the <i>IdentifyCallbackContext</i> parameter of the
///                              WinBioIdentifyWithCallback function. The buffer is not modified by the framework or the biometric unit. Your
///                              application can use the data to help it determine what actions to perform or to maintain additional information
///                              about the biometric capture.
///    OperationStatus = Error code returned by the capture operation.
///    UnitId = Biometric unit ID number.
///    Identity = A WINBIO_IDENTITY structure that receives the GUID or SID of the user providing the biometric sample.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that receives the sub-factor associated with the biometric sample. See
///                the Remarks section for more details.
///    RejectDetail = Additional information about the failure, if any, to perform the operation. For more information, see Remarks.
alias PWINBIO_IDENTIFY_CALLBACK = void function(void* IdentifyCallbackContext, HRESULT OperationStatus, 
                                                uint UnitId, WINBIO_IDENTITY* Identity, ubyte SubFactor, 
                                                uint RejectDetail);
///Called by the Windows Biometric Framework to return results from the asynchronous WinBioLocateSensorWithCallback
///function. The client application must implement this function. <div class="alert"><b>Important</b> We recommend that,
///beginning with Windows 8, you no longer use the
///<b>PWINBIO_LOCATE_SENSOR_CALLBACK</b>/<b>WinBioLocateSensorWithCallback</b> combination. Instead, do the
///following:<ul> <li>Implement a PWINBIO_ASYNC_COMPLETION_CALLBACK function to receive notice when the operation
///completes.</li> <li>Call the WinBioAsyncOpenSession function. Pass the address of your callback in the
///<i>CallbackRoutine</i> parameter. Pass <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b> in the <i>NotificationMethod</i>
///parameter. Retrieve an asynchronous session handle.</li> <li>Use the asynchronous session handle to call
///WinBioLocateSensor. When the operation finishes, the Windows Biometric Framework will allocate and initialize a
///WINBIO_ASYNC_RESULT structure with the results and invoke your callback with a pointer to the results structure.</li>
///<li>Call WinBioFree from your callback implementation to release the WINBIO_ASYNC_RESULT structure after you have
///finished using it.</li> </ul> </div> <div> </div>
///Params:
///    LocateCallbackContext = Pointer to a buffer defined by the application and passed to the <i>LocateCallbackContext</i> parameter of the
///                            WinBioLocateSensorWithCallback function. The buffer is not modified by the framework or the biometric unit. Your
///                            application can use the data to help it determine what actions to perform or to maintain additional information
///                            about the biometric capture.
///    OperationStatus = Error code returned by the capture operation.
alias PWINBIO_LOCATE_SENSOR_CALLBACK = void function(void* LocateCallbackContext, HRESULT OperationStatus, 
                                                     uint UnitId);
///The <b>PWINBIO_ENROLL_CAPTURE_CALLBACK</b> function is called by the Windows Biometric Framework to return results
///from the asynchronous WinBioEnrollCaptureWithCallback function. The client application must implement this function.
///<div class="alert"><b>Important</b> We recommend that, beginning with Windows 8, you no longer use the
///<b>PWINBIO_ENROLL_CAPTURE_CALLBACK</b>/<b>WinBioEnrollCaptureWithCallback</b> combination. Instead, do the
///following:<ul> <li>Implement a PWINBIO_ASYNC_COMPLETION_CALLBACK function to receive notice when the operation
///completes.</li> <li>Call the WinBioAsyncOpenSession function. Pass the address of your callback in the
///<i>CallbackRoutine</i> parameter. Pass <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b> in the <i>NotificationMethod</i>
///parameter. Retrieve an asynchronous session handle.</li> <li>Use the asynchronous session handle to call
///WinBioEnrollCapture. When the operation finishes, the Windows Biometric Framework will allocate and initialize a
///WINBIO_ASYNC_RESULT structure with the results and invoke your callback with a pointer to the results structure.</li>
///<li>Call WinBioFree from your callback implementation to release the WINBIO_ASYNC_RESULT structure after you have
///finished using it.</li> </ul> </div> <div> </div>
///Params:
///    EnrollCallbackContext = Pointer to a buffer defined by the application and passed to the <i>EnrollCallback</i> parameter of the
///                            WinBioEnrollCaptureWithCallback function. The buffer is not modified by the framework or the biometric unit. Your
///                            application can use the data to help it determine what actions to perform or to maintain additional information
///                            about the biometric capture.
///    OperationStatus = Error code returned by the capture operation.
///    RejectDetail = Additional information about the failure, if any, to perform the operation. For more information, see Remarks.
alias PWINBIO_ENROLL_CAPTURE_CALLBACK = void function(void* EnrollCallbackContext, HRESULT OperationStatus, 
                                                      uint RejectDetail);
///Called by the Windows Biometric Framework to return results from the asynchronous WinBioRegisterEventMonitor
///function. The client application must implement this function.
///Params:
///    EventCallbackContext = Pointer to a buffer defined by the application and passed to the <i>EventCallbackContext</i> parameter of the
///                           WinBioRegisterEventMonitor function. The buffer is not modified by the framework or the biometric unit. Your
///                           application can use the data to help it determine what actions to perform or to maintain additional information
///                           about the biometric capture.
///    OperationStatus = Error code returned by the capture operation.
alias PWINBIO_EVENT_CALLBACK = void function(void* EventCallbackContext, HRESULT OperationStatus, 
                                             WINBIO_EVENT* Event);
///Called by the Windows Biometric Framework to return results from the asynchronous WinBioCaptureSampleWithCallback
///function. The client application must implement this function. <div class="alert"><b>Important</b> We recommend that,
///beginning with Windows 8, you no longer use the
///<b>PWINBIO_CAPTURE_CALLBACK</b>/<b>WinBioCaptureSampleWithCallback</b> combination. Instead, do the following:<ul>
///<li>Implement a PWINBIO_ASYNC_COMPLETION_CALLBACK function to receive notice when the operation completes.</li>
///<li>Call the WinBioAsyncOpenSession function. Pass the address of your callback in the <i>CallbackRoutine</i>
///parameter. Pass <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b> in the <i>NotificationMethod</i> parameter. Retrieve an
///asynchronous session handle.</li> <li>Use the asynchronous session handle to call WinBioCaptureSample. When the
///operation finishes, the Windows Biometric Framework will allocate and initialize a WINBIO_ASYNC_RESULT structure with
///the results and invoke your callback with a pointer to the results structure.</li> <li>Call WinBioFree from your
///callback implementation to release the WINBIO_ASYNC_RESULT structure after you have finished using it.</li> </ul>
///</div> <div> </div>
///Params:
///    CaptureCallbackContext = Pointer to a buffer defined by the application and passed to the <i>CaptureCallbackContext</i> parameter of the
///                             WinBioCaptureSampleWithCallback function. The buffer is not modified by the framework or the biometric unit. Your
///                             application can use the data to help it determine what actions to perform or to maintain additional information
///                             about the biometric capture.
///    OperationStatus = Error code returned by the capture operation.
///    UnitId = Biometric unit ID number.
///    Sample = Pointer to the sample data.
///    SampleSize = Size, in bytes, of the sample data pointed to by the <i>Sample</i> parameter.
///    RejectDetail = Additional information about the failure, if any, to perform the operation. For more information, see Remarks.
alias PWINBIO_CAPTURE_CALLBACK = void function(void* CaptureCallbackContext, HRESULT OperationStatus, uint UnitId, 
                                               char* Sample, size_t SampleSize, uint RejectDetail);
///Called by the Windows Biometric Framework when a sensor adapter is added to the processing pipeline of the biometric
///unit. The purpose of this function is to perform any initialization required for later biometric operations.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    The operation could not be completed because of insufficient memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>SensorContext</b> member of the
///    WINBIO_PIPELINE structure pointed to by the <i>Pipeline</i> argument is not <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_SENSOR_ATTACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework immediately before a sensor adapter is removed from the processing pipeline
///of the biometric unit. The purpose of this function is to release adapter specific resources attached to the
///pipeline.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td>
///    <td width="60%"> The <b>SensorContext</b> field of the WINBIO_PIPELINE structure cannot be <b>NULL</b>. </td>
///    </tr> </table>
///    
alias PIBIO_SENSOR_DETACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to prepare the processing pipeline of the biometric unit for a new
///operation. This function should flush temporary data from the sensor context and place the sensor adapter into a
///well-defined initial state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_SENSOR_CLEAR_CONTEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to retrieve information about the current status of the sensor device.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Status = Pointer to a WINBIO_SENSOR_STATUS value that receives the status information.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td
///    width="60%"> The <b>SensorContext</b> member of the WINBIO_PIPELINE structure pointed to by the <i>Pipeline</i>
///    argument is <b>NULL</b> or the <b>SensorHandle</b> member is set to <b>INVALID_HANDLE_VALUE</b>. </td> </tr>
///    </table>
///    
alias PIBIO_SENSOR_QUERY_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* Status);
///Called by the Windows Biometric Framework to reinitialize the sensor. The specific details of the reset state are
///determined by the sensor hardware vendor.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <i>Pipeline</i> argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> There was a hardware failure. </td> </tr> </table>
///    
alias PIBIO_SENSOR_RESET_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to set the sensor adapter mode.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Mode = A WINBIO_SENSOR_MODE value. This can be one of the following values: <ul> <li>WINBIO_SENSOR_UNKNOWN_MODE</li>
///           <li>WINBIO_SENSOR_BASIC_MODE</li> <li>WINBIO_SENSOR_ADVANCED_MODE</li> <li>WINBIO_SENSOR_NAVIGATION_MODE</li>
///           <li>WINBIO_SENSOR_SLEEP_MODE</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_FAILURE </b></dt> </dl> </td> <td
///    width="60%"> There was a hardware failure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>SensorContext</b> member of the
///    WINBIO_PIPELINE structure pointed to by the <i>Pipeline</i> argument is <b>NULL</b> or the <b>SensorHandle</b>
///    member is set to <b>INVALID_HANDLE_VALUE</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_SENSOR_MODE</b></dt> </dl> </td> <td width="60%"> The sensor adapter does not support the
///    value specified by the <i>Mode</i> parameter. </td> </tr> </table>
///    
alias PIBIO_SENSOR_SET_MODE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint Mode);
///Called by the Windows Biometric Framework to toggle the sensor indicator on or off.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    IndicatorStatus = A <b>WINBIO_INDICATOR_STATUS</b> value. This can be one of the following: <ul> <li>WINBIO_INDICATOR_ON</li>
///                      <li>WINBIO_INDICATOR_OFF</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
///    <i>IndicatorStatus</i> parameter is not correct </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_DEVICE_FAILURE </b></dt> </dl> </td> <td width="60%"> There was a hardware failure. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The
///    <b>SensorContext</b> member of the WINBIO_PIPELINE structure pointed to by the <i>Pipeline</i> argument is
///    <b>NULL</b> or the <b>SensorHandle</b> member is set to <b>INVALID_HANDLE_VALUE</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_UNSUPPORTED_PROPERTY</b></dt> </dl> </td> <td width="60%"> The sensor does not
///    have an indicator. </td> </tr> </table>
///    
alias PIBIO_SENSOR_SET_INDICATOR_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint IndicatorStatus);
///Called by the Windows Biometric Framework to retrieve a value that indicates whether the sensor indicator is on or
///off.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    IndicatorStatus = Pointer to a <b>WINBIO_INDICATOR_STATUS</b> value. This can be one of the following: <ul>
///                      <li>WINBIO_INDICATOR_ON</li> <li>WINBIO_INDICATOR_OFF</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_FAILURE </b></dt> </dl> </td> <td
///    width="60%"> There was a hardware failure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>SensorContext</b> member of the
///    WINBIO_PIPELINE structure pointed to by the <i>Pipeline</i> argument is <b>NULL</b> or the <b>SensorHandle</b>
///    member is set to <b>INVALID_HANDLE_VALUE</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_UNSUPPORTED_PROPERTY</b></dt> </dl> </td> <td width="60%"> The sensor does not have an indicator.
///    </td> </tr> </table>
///    
alias PIBIO_SENSOR_GET_INDICATOR_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* IndicatorStatus);
///Called by the Windows Biometric Framework to begin an asynchronous biometric capture.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Purpose = A <b>WINBIO_BIR_PURPOSE</b> bitmask that specifies the intended use of the sample. This can be a bitwise
///              <b>OR</b> of the following values:<ul> <li>WINBIO_PURPOSE_VERIFY</li> <li>WINBIO_PURPOSE_IDENTIFY</li>
///              <li>WINBIO_PURPOSE_ENROLL</li> <li>WINBIO_PURPOSE_ENROLL_FOR_VERIFICATION</li>
///              <li>WINBIO_PURPOSE_ENROLL_FOR_IDENTIFICATION</li> </ul> Some sensors have the ability to capture biometric
///              information at multiple resolutions. If the <i>Purpose</i> parameter specifies more than one flag, your adapter
///              should use the flag that represents the highest resolution to determine the resolution of the capture operation.
///    Overlapped = Address of a variable that receives a pointer to an <b>OVERLAPPED</b> structure that tracks the state of the
///                 asynchronous capture operation. This structure is created and managed by the sensor adapter but is used by the
///                 Windows Biometric Framework for synchronization. For more information, see the Remarks section.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. The following values will be recognized by the Windows Biometric Framework. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
///    <td width="60%"> A mandatory pointer argument is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%"> The <i>Purpose</i> parameter is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_OUTOFMEMORY</b></b></dt> </dl> </td> <td width="60%"> There was not
///    enough memory to perform the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_BUSY
///    </b></dt> </dl> </td> <td width="60%"> The device is not ready to capture data. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WINBIO_E_DEVICE_FAILURE</b></dt> </dl> </td> <td width="60%"> There was a device failure. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The
///    <b>SensorContext</b> member of the WINBIO_PIPELINE structure pointed to by the <i>Pipeline</i> argument is
///    <b>NULL</b> or the <b>SensorHandle</b> member is set to <b>INVALID_HANDLE_VALUE</b>. </td> </tr> </table>
///    
alias PIBIO_SENSOR_START_CAPTURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, 
                                                       OVERLAPPED** Overlapped);
///Called by the Windows Biometric Framework to wait for the completion of a capture operation initiated by the
///SensorAdapterStartCapture function.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    RejectDetail = Pointer to a <b>WINBIO_REJECT_DETAIL</b> value that receives additional information about the failure to capture
///                   a biometric sample. If the operation succeeded, this parameter is set to zero. The following values are defined
///                   for fingerprint samples: <ul> <li>WINBIO_FP_TOO_HIGH</li> <li>WINBIO_FP_TOO_LOW</li> <li>WINBIO_FP_TOO_LEFT</li>
///                   <li>WINBIO_FP_TOO_RIGHT</li> <li>WINBIO_FP_TOO_FAST</li> <li>WINBIO_FP_TOO_SLOW</li>
///                   <li>WINBIO_FP_POOR_QUALITY</li> <li>WINBIO_FP_TOO_SKEWED</li> <li>WINBIO_FP_TOO_SHORT</li>
///                   <li>WINBIO_FP_MERGE_FAILURE</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. The following values will be recognized by the Windows Biometric Framework. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_BAD_CAPTURE</b></b></dt> </dl> </td> <td width="60%"> The sample could not be captured. If you
///    return this error code, you must also specify a value in the <i>RejectDetail</i> parameter that indicates the
///    nature of the problem. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_CAPTURE_CANCELED</b></b></dt>
///    </dl> </td> <td width="60%"> The sensor driver returned <b>ERROR_CANCELLED</b> or <b>ERROR_OPERATION_ABORTED</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_FAILURE</b></dt> </dl> </td> <td width="60%"> There
///    was a device failure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl>
///    </td> <td width="60%"> The <b>SensorContext</b> member of the WINBIO_PIPELINE structure pointed to by the
///    <i>Pipeline</i> argument is <b>NULL</b> or the <b>SensorHandle</b> member is set to <b>INVALID_HANDLE_VALUE</b>.
///    </td> </tr> </table>
///    
alias PIBIO_SENSOR_FINISH_CAPTURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
///Called by the Windows Biometric Framework to retrieve a copy of the most recently captured biometric sample formatted
///as a standard WINBIO_BIR structure.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    SampleBuffer = Address of a variable that receives a pointer to a WINBIO_BIR structure that contains the sample.
///    SampleSize = Pointer to a variable that receives the size, in bytes, of the buffer specified by the <i>SampleBuffer</i>
///                 parameter.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to create the WINBIO_BIR structure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
///    </dl> </td> <td width="60%"> A mandatory pointer parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>SensorContext</b> member of the
///    WINBIO_PIPELINE structure pointed to by the <i>Pipeline</i> argument is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_NO_CAPTURE_DATA </b></dt> </dl> </td> <td width="60%"> No capture data exists.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This method is not
///    currently implemented. </td> </tr> </table>
///    
alias PIBIO_SENSOR_EXPORT_SENSOR_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_BIR** SampleBuffer, 
                                                            size_t* SampleSize);
///Called by the Windows Biometric Framework to cancel all pending sensor operations.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td>
///    <td width="60%"> The <b>SensorHandle</b> member of the WINBIO_PIPELINE structure pointed to by the
///    <i>Pipeline</i> argument is set to <b>INVALID_HANDLE_VALUE</b>. </td> </tr> </table>
///    
alias PIBIO_SENSOR_CANCEL_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to make the current contents of the sample buffer available to the engine
///adapter.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Purpose = A value that specifies the properties of the WINBIO_BIR structure that will be passed to the engine. This can be
///              a bitwise <b>OR</b> of the following security and processing level flags: <ul> <li>WINBIO_PURPOSE_VERIFY</li>
///              <li>WINBIO_PURPOSE_IDENTIFY</li> <li>WINBIO_PURPOSE_ENROLL</li> <li>WINBIO_PURPOSE_ENROLL_FOR_VERIFICATION</li>
///              <li>WINBIO_PURPOSE_ENROLL_FOR_IDENTIFICATION</li> </ul>
///    Flags = A value that specifies the format of the sample. This can be a bitwise <b>OR</b> of the following security and
///            processing level flags: * **WINBIO_DATA_FLAG_PRIVACY** The sample should be encrypted. *
///            **WINBIO_DATA_FLAG_INTEGRITY** The sample should be digitally signed or protected by a message authentication
///            code (MAC). * **WINBIO_DATA_FLAG_SIGNED** If this flag and the <mark
///            type="const">WINBIO_DATA_FLAG_INTEGRITY</mark> flag are set, the sample should be signed. If this flag is not set
///            but the <mark type="const">WINBIO_DATA_FLAG_INTEGRITY</mark> flag is set, a MAC should be computed. *
///            **WINBIO_DATA_FLAG_RAW** The sample should be placed in the <xref targtype="struct"
///            rid="secbiomet.winbio_bir">WINBIO_BIR</xref> object in the format in which it was captured.
///    RejectDetail = A pointer to a <b>WINBIO_REJECT_DETAIL</b> value that contains information about the previous failure to capture
///                   a biometric sample and therefore the reason that the sample buffer is empty. If an earlier capture succeeded,
///                   this parameter is set to zero. The following values are defined for fingerprint capture: <ul>
///                   <li>WINBIO_FP_TOO_HIGH</li> <li>WINBIO_FP_TOO_LOW</li> <li>WINBIO_FP_TOO_LEFT</li> <li>WINBIO_FP_TOO_RIGHT</li>
///                   <li>WINBIO_FP_TOO_FAST</li> <li>WINBIO_FP_TOO_SLOW</li> <li>WINBIO_FP_POOR_QUALITY</li>
///                   <li>WINBIO_FP_TOO_SKEWED</li> <li>WINBIO_FP_TOO_SHORT</li> <li>WINBIO_FP_MERGE_FAILURE</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_BAD_CAPTURE</b></dt> </dl> </td> <td
///    width="60%"> The sample data is not suitable for use. If you return this error code, you must also specify a
///    value in the <i>RejectDetail</i> parameter to indicate the nature of the problem. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The
///    <b>SensorContext</b> member of the WINBIO_PIPELINE structure pointed to by the <i>Pipeline</i> argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_NO_CAPTURE_DATA </b></dt> </dl> </td> <td
///    width="60%"> No capture data exists. </td> </tr> </table>
///    
alias PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, ubyte Flags, 
                                                             uint* RejectDetail);
///Called by the Windows Biometric Framework to perform a vendor-defined control operation that does not require
///elevated privilege. Call the SensorAdapterControlUnitPrivileged function to perform a vendor-defined control
///operation that requires elevated privilege.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    ControlCode = A <b>ULONG</b> value that specifies the vendor-defined operation to perform.
///    SendBuffer = Pointer to a buffer that contains the control information to be sent to the sensor adapter. The format and
///                 content of the buffer is vendor-defined.
///    SendBufferSize = Size, in bytes, of the buffer specified by the <i>SendBuffer</i> parameter.
///    ReceiveBuffer = Pointer to a buffer that receives information sent by the sensor adapter. The format of the buffer is
///                    vendor-defined.
///    ReceiveBufferSize = Size, in bytes, of the buffer specified by the <i>ReceiveBuffer</i> parameter.
///    ReceiveDataSize = Pointer to a variable that receives the size, in bytes, of the data written to the buffer specified by the
///                      <i>ReceiveBuffer</i> parameter.
///    OperationStatus = Pointer to a variable that receives a vendor-defined status code that specifies the outcome of the control
///                      operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b> E_INVALIDARG</b></b></dt> </dl> </td> <td
///    width="60%"> The size or format of the buffer specified by the <i>SendBuffer</i> parameter is not correct, or the
///    value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_NOT_SUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer specified by
///    the <i>ReceiveBuffer</i> parameter is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_CANCELED</b></dt> </dl> </td> <td width="60%"> The operation was canceled. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_FAILURE</b></dt> </dl> </td> <td width="60%"> There was a hardware
///    failure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_INVALID_CONTROL_CODE</b></b></dt> </dl> </td>
///    <td width="60%"> The value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. <div
///    class="alert"><b>Note</b> Beginning with Windows 8, use only <b>E_INVALIDARG</b> to signal this condition.</div>
///    <div> </div> </td> </tr> </table>
///    
alias PIBIO_SENSOR_CONTROL_UNIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                      char* SendBuffer, size_t SendBufferSize, char* ReceiveBuffer, 
                                                      size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                      uint* OperationStatus);
///Called by the Windows Biometric Framework to perform a vendor-defined control operation that requires elevated
///privilege. Call the SensorAdapterControlUnit function to perform a vendor-defined control operation that does not
///require elevated privilege.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    ControlCode = A <b>ULONG</b> value that specifies the vendor-defined operation to perform.
///    SendBuffer = Pointer to a buffer that contains the control information sent to the sensor adapter. The format and content of
///                 the buffer is vendor-defined.
///    SendBufferSize = Size, in bytes, of the buffer specified by the <i>SendBuffer</i> parameter.
///    ReceiveBuffer = Pointer to a buffer that receives information returned by the sensor adapter in response to the control
///                    operation. The format of the buffer is vendor-defined.
///    ReceiveBufferSize = Size, in bytes, of the buffer specified by the <i>ReceiveBuffer</i> parameter.
///    ReceiveDataSize = Pointer to a variable that receives the size, in bytes, of the data written to the buffer specified by the
///                      <i>ReceiveBuffer</i> parameter.
///    OperationStatus = Pointer to a variable that receives a vendor-defined status code that specifies the outcome of the control
///                      operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b> E_INVALIDARG</b></b></dt> </dl> </td> <td
///    width="60%"> The size or format of the buffer specified by the <i>SendBuffer</i> parameter is not correct, or the
///    value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_NOT_SUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer specified by
///    the <i>ReceiveBuffer</i> parameter is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_CANCELED</b></dt> </dl> </td> <td width="60%"> The operation was canceled. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_FAILURE</b></dt> </dl> </td> <td width="60%"> There was a hardware
///    failure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_INVALID_CONTROL_CODE</b></b></dt> </dl> </td>
///    <td width="60%"> The value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. <div
///    class="alert"><b>Note</b> Beginning with Windows 8, use only <b>E_INVALIDARG</b> to signal this condition.</div>
///    <div> </div> </td> </tr> </table>
///    
alias PIBIO_SENSOR_CONTROL_UNIT_PRIVILEGED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                                 char* SendBuffer, size_t SendBufferSize, 
                                                                 char* ReceiveBuffer, size_t ReceiveBufferSize, 
                                                                 size_t* ReceiveDataSize, uint* OperationStatus);
///Called by the Windows Biometric Framework when the system is ready to enter a low-power state or when the system has
///been awakened from a low-power state. The purpose of this function is to enable the adapter to respond to transitions
///in the computer power state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation
///    PowerEventType = Indicates the nature of the change. It can be one of the following values: * **PBT_APMSUSPEND** The system is
///                     entering a low-power state. * **PBT_APMRESUMEAUTOMATIC** The system is returning from a low-power state. *
///                     **PBT_APMPOWERSTATUSCHANGE** The status of the system's power source is changing (e.g. the system has switched
///                     from battery to line power, or the battery is getting low).
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument was
///    NULL </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
///    <i>PowerEventType</i> argument was not one of the values listed. </td> </tr> </table>
///    
alias PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
///Called by the Windows Biometric Framework to give the Sensor Adapter the chance to perform any initialization that
///remains incomplete, and which requires help from the Engine or Storage adapter components.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_some_error </b></dt> </dl> </td> <td width="60%"> Any error code will cause the
///    Biometric Service to log the error and abort the configuration of the biometric unit. </td> </tr> </table>
///    
alias PIBIO_SENSOR_PIPELINE_INIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to give the Sensor Adapter the chance to perform any cleanup in that
///requires help from the Engine or Storage adapter components.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_SENSOR_PIPELINE_CLEANUP_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to give the Sensor Adapter the chance to perform any work needed to bring
///the sensor component out of an idle state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_SENSOR_ACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to give the Sensor Adapter the chance to perform any work needed to put the
///sensor component into an idle state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_SENSOR_DEACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to determine the capabilities and limitations of the biometric sensor
///component.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    SensorInfo = Pointer to the WINBIO_EXTENDED_SENSOR_INFO structure that contains the sensor information returned by this
///                 function.
///    SensorInfoSize = The specified size of the sensor information.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> and
///    <i>SensorInfo</i> parameters cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG
///    </b></dt> </dl> </td> <td width="60%"> The <i>SensorInfoSize</i> value is less than the size needed to return the
///    sensor information. </td> </tr> </table>
///    
alias PIBIO_SENSOR_QUERY_EXTENDED_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* SensorInfo, 
                                                             size_t SensorInfoSize);
///Called by the Windows Biometric Framework to determine the set of calibration formats supported by the Sensor
///Adapter.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    FormatArray = Address of an array of empty WINBIO_UUID items. The <b>SensorAdapterQueryCalibrationFormats</b> method is
///                  expected to fill this array with one or more UUIDs identifying the calibration data formats known to the Sensor
///                  Adapter.
///    FormatArraySize = A value indicating the number of slots available in <i>FormatArray</i>. The
///                      <b>SensorAdapterQueryCalibrationFormats</b> method must not attempt to write more than this number of elements
///                      into <i>FormatArray</i>, or the results will be unpredictable.
///    FormatCount = Pointer to a variable that receives the number UUIDs returned in <i>FormatArray</i>. The
///                  <b>SensorAdapterQueryCalibrationFormats</b> method must set this value before returning.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_NOTIMPL </b></dt> </dl> </td> <td width="60%"> – The Sensor Adapter doesn’t
///    support dynamic calibration. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_some_other_error </b></dt> </dl>
///    </td> <td width="60%"> Any other error code will cause the Windows Biometric Framework to log the error and abort
///    the configuration of the biometric unit. </td> </tr> </table>
///    
alias PIBIO_SENSOR_QUERY_CALIBRATION_FORMATS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* FormatArray, 
                                                                   size_t FormatArraySize, size_t* FormatCount);
///Called by the Windows Biometric Framework to notify the sensor adapter that a particular calibration data format has
///been selected by the engine adapter.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Format = Address of a WINBIO_UUID identifying the calibration data format selected by the Engine Adapter.
///Returns:
///    The function will return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> The
///    operation succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL </b></dt> </dl> </td> <td
///    width="60%"> The Sensor Adapter doesn’t support dynamic calibration. This is only treated as an error if the
///    SensorAdapterQueryCalibrationFormats method has previously indicated that the adapter supports dynamic
///    calibration. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_UNSUPPORTED_SENSOR_CALIBRATION_FORMAT
///    </b></dt> </dl> </td> <td width="60%"> The UUID specified in the <i>Format</i> parameter is not one of the ones
///    supported by the Sensor Adapter. This error code will cause the Biometric Service to log the error and abort the
///    configuration of the biometric unit. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_some_other_error </b></dt>
///    </dl> </td> <td width="60%"> Any other error code will cause the Biometric Service to log the error and abort the
///    configuration of the biometric unit. </td> </tr> </table>
///    
alias PIBIO_SENSOR_SET_CALIBRATION_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* Format);
///Called by the Windows Biometric Framework to pass calibration data from the engine adapter to the sensor adapter.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    CalibrationBuffer = Pointer to the buffer that contains the calibration data.
///    CalibrationBufferSize = The size in bytes of the calibration buffer.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_some_error </b></dt> </dl> </td> <td width="60%"> Any error code will cause the
///    Biometric Service to discontinue the dynamic calibration loop and abort the capture operation. </td> </tr>
///    </table>
///    
alias PIBIO_SENSOR_ACCEPT_CALIBRATION_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                 char* CalibrationBuffer, 
                                                                 size_t CalibrationBufferSize);
alias PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* RawBufferAddress, 
                                                                 size_t RawBufferSize, ubyte** ResultBufferAddress, 
                                                                 size_t* ResultBufferSize);
alias PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                    GUID SecureBufferIdentifier, 
                                                                    char* MetadataBufferAddress, 
                                                                    size_t MetadataBufferSize, 
                                                                    ubyte** ResultBufferAddress, 
                                                                    size_t* ResultBufferSize);
alias PIBIO_SENSOR_QUERY_PRIVATE_SENSOR_TYPE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   char* TypeInfoBufferAddress, 
                                                                   size_t TypeInfoBufferSize, 
                                                                   size_t* TypeInfoDataSize);
alias PIBIO_SENSOR_CONNECT_SECURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                        const(WINBIO_SECURE_CONNECTION_PARAMS)* ConnectionParams, 
                                                        WINBIO_SECURE_CONNECTION_DATA** ConnectionData);
alias PIBIO_SENSOR_START_CAPTURE_EX_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, char* Nonce, 
                                                          size_t NonceSize, ubyte Flags, OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_START_NOTIFY_WAKE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_FINISH_NOTIFY_WAKE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* Reason);
alias PWINBIO_QUERY_SENSOR_INTERFACE_FN = HRESULT function(WINBIO_SENSOR_INTERFACE** SensorInterface);
///Called by the Windows Biometric Framework when an engine adapter is added to the processing pipeline of the biometric
///unit. The purpose of this function is to perform any initialization required for later biometric operations.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    The operation could not be completed because of insufficient memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>EngineContext</b> member of the
///    WINBIO_PIPELINE structure pointed to by the <i>Pipeline</i> argument is not <b>NULL</b> or the
///    <b>EngineHandle</b> member is not set to <b>INVALID_HANDLE_VALUE</b>. </td> </tr> </table>
///    
alias PIBIO_ENGINE_ATTACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework immediately before an engine adapter is removed from the processing
///pipeline of the biometric unit. The purpose of this function is to release adapter specific resources attached to the
///pipeline.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td>
///    <td width="60%"> The <b>EngineContext</b> field of the WINBIO_PIPELINE structure cannot be <b>NULL</b>. </td>
///    </tr> </table>
///    
alias PIBIO_ENGINE_DETACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to prepare the processing pipeline of the biometric unit for a new
///operation. This function should flush temporary data from the engine context and place the engine adapter into a
///well-defined initial state.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_ENGINE_CLEAR_CONTEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the sensor adapter on the biometric unit to determine the input data format preferred by the engine
///adapter.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    StandardFormat = Pointer to a WINBIO_REGISTERED_FORMAT structure that specifies the format of the data in the
///                     <b>StandardDataBlock</b> member of the WINBIO_BIR object. The format is an IBIA-registered name/value pair.
///    VendorFormat = Pointer to a GUID that receives the vendor-defined format of the data in the <b>VendorDataBlock</b> member of the
///                   WINBIO_BIR object.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer parameter is
///    <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_ENGINE_QUERY_PREFERRED_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                WINBIO_REGISTERED_FORMAT* StandardFormat, 
                                                                GUID* VendorFormat);
///Called by the Windows Biometric Framework to retrieve the size of the index vector used by the engine adapter.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    IndexElementCount = Address of a variable that receives the number of array elements in the index vector.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer parameter is
///    <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_ENGINE_QUERY_INDEX_VECTOR_SIZE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                 size_t* IndexElementCount);
///Called by the Windows Biometric Framework to retrieve an array of object identifiers (OIDs) that represent the hash
///algorithms supported by the engine adapter.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    AlgorithmCount = Pointer to a value that receives the number of algorithm OID strings in the buffer specified by the
///                     <i>AlgorithmBuffer</i> parameter.
///    AlgorithmBufferSize = Pointer to a value that contains the size, in bytes, of the buffer specified by the <i>AlgorithmBuffer</i>
///                          parameter. The size includes the two <b>NULL</b> values that terminate the buffer.
///    AlgorithmBuffer = Address of a variable that receives a pointer to a buffer that contains packed, <b>NULL</b>-terminated ANSI
///                      strings. Each string represents an OID for a hash algorithm. The final string in the buffer must be terminated by
///                      two successive <b>NULL</b> values.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The
///    engine adapter does not support template hash generation. </td> </tr> </table>
///    
alias PIBIO_ENGINE_QUERY_HASH_ALGORITHMS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* AlgorithmCount, 
                                                               size_t* AlgorithmBufferSize, char* AlgorithmBuffer);
///Called by the Windows Biometric Framework to select a hash algorithm for use in subsequent operations.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    AlgorithmBufferSize = The size, in bytes, of the buffer specified by the <i>AlgorithmBuffer</i> parameter.
///    AlgorithmBuffer = Pointer to a <b>NULL</b>-terminated ANSI string that contains the object identifier of the hash algorithm to
///                      select. Call the EngineAdapterQueryHashAlgorithms function to retrieve an array of the supported algorithm object
///                      identifiers (OIDs).
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The
///    engine adapter does not support template hashing. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The engine adapter does not support the hash algorithm
///    specified by the <i>AlgorithmBuffer</i> parameter. </td> </tr> </table>
///    
alias PIBIO_ENGINE_SET_HASH_ALGORITHM_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t AlgorithmBufferSize, 
                                                            char* AlgorithmBuffer);
///Called by the Windows Biometric Framework to retrieve the number of correct samples required by the engine adapter to
///construct an enrollment template.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    SampleHint = Pointer to a variable that receives the number of required samples.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_UNSUPPORTED_PROPERTY</b></dt> </dl> </td> <td
///    width="60%"> The engine adapter does not support this property. </td> </tr> </table>
///    
alias PIBIO_ENGINE_QUERY_SAMPLE_HINT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* SampleHint);
///Called by the SensorAdapterPushDataToEngine function implemented by the sensor adapter to notify the engine adapter
///to accept a raw biometric sample and extract a feature set. The feature set can be used for matching or enrollment.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    SampleBuffer = Pointer to a WINBIO_BIR structure that contains the biometric sample to be processed.
///    SampleSize = A <b>SIZE_T</b> value that contains the size of the WINBIO_BIR structure returned in the <i>SampleBuffer</i>
///                 parameter.
///    Purpose = A <b>WINBIO_BIR_PURPOSE</b> bitmask that specifies the intended use of the sample. The <b>WINBIO_BIR_PURPOSE</b>
///              structure specifies the purpose for which capture data is to be used, and (as a result) how it should be
///              optimized. This can be a bitwise <b>OR</b> of the following values:<ul> <li>WINBIO_PURPOSE_VERIFY</li>
///              <li>WINBIO_PURPOSE_IDENTIFY</li> <li>WINBIO_PURPOSE_ENROLL</li> <li>WINBIO_PURPOSE_ENROLL_FOR_VERIFICATION</li>
///              <li>WINBIO_PURPOSE_ENROLL_FOR_IDENTIFICATION</li> </ul>
///    RejectDetail = A pointer to a <b>WINBIO_REJECT_DETAIL</b> value that receives additional information about the failure to
///                   process a biometric sample. If the operation succeeded, this parameter is set to zero. The following values are
///                   defined for fingerprint samples: <ul> <li>WINBIO_FP_TOO_HIGH</li> <li>WINBIO_FP_TOO_LOW</li>
///                   <li>WINBIO_FP_TOO_LEFT</li> <li>WINBIO_FP_TOO_RIGHT</li> <li>WINBIO_FP_TOO_FAST</li> <li>WINBIO_FP_TOO_SLOW</li>
///                   <li>WINBIO_FP_POOR_QUALITY</li> <li>WINBIO_FP_TOO_SKEWED</li> <li>WINBIO_FP_TOO_SHORT</li>
///                   <li>WINBIO_FP_MERGE_FAILURE</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>SampleSize</i> argument
///    cannot be zero. The <i>Purpose</i> argument must be a bitwise <b>OR</b> of the values listed in the parameter
///    description. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
///    <i>Pipeline</i>, <i>SampleBuffer</i>, and <i>RejectDetail</i> arguments cannot be <b>NULL</b>. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The operation could not be
///    completed because of insufficient memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_BAD_CAPTURE</b></dt> </dl> </td> <td width="60%"> The data could not be processed to create the
///    required feature set. The RejectDetail contains additional information about the failure. </td> </tr> </table>
///    
alias PIBIO_ENGINE_ACCEPT_SAMPLE_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* SampleBuffer, 
                                                            size_t SampleSize, ubyte Purpose, uint* RejectDetail);
///Called by the Windows Biometric Framework to retrieve a copy of the most recently processed feature set or template
///from the engine formatted as a standard WINBIO_BIR structure.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Flags = A value that specifies the properties of the WINBIO_BIR structure returned by the engine. This can be a bitwise
///            <b>OR</b> of the following security and processing level flags: **WINBIO_DATA_FLAG_PRIVACY** The data is
///            encrypted. * **WINBIO_DATA_FLAG_INTEGRITY** The data is digitally signed or protected by a message authentication
///            code (MAC). * **WINBIO_DATA_FLAG_SIGNED** If this flag and the <mark
///            type="const">WINBIO_DATA_FLAG_INTEGRITY</mark> flag are set, the data is signed. If this flag is not set but the
///            <mark type="const">WINBIO_DATA_FLAG_INTEGRITY</mark> flag is set, a MAC is computed. * **WINBIO_DATA_FLAG_RAW**
///            The data is in the format with which it was captured. * **WINBIO_DATA_FLAG_INTERMEDIATE** The data is not raw but
///            has not been completely processed. * **WINBIO_DATA_FLAG_PROCESSED** The data has been processed.
///    SampleBuffer = Address of a variable that receives a pointer to a WINBIO_BIR structure that contains the feature set or
///                   template.
///    SampleSize = Pointer to a variable that contains the size, in bytes, of the WINBIO_BIR structure returned in the
///                 <i>SampleBuffer</i> parameter.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The engine adapter does not
///    support the combination of flags specified by the <i>Flags</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to create the
///    WINBIO_BIR structure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
///    width="60%"> A mandatory pointer parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The pipeline does not contain the type
///    of data required by the <i>Flags</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt>
///    </dl> </td> <td width="60%"> This method is not currently implemented. </td> </tr> </table>
///    
alias PIBIO_ENGINE_EXPORT_ENGINE_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Flags, 
                                                            char* SampleBuffer, size_t* SampleSize);
///Called by the Windows Biometric Framework to compare the template in the current feature set with a specific template
///in the database. If the templates are equivalent, the engine adapter must set the Boolean value pointed to by the
///<i>Match</i> parameter to <b>TRUE</b>, return the matched template in the <i>PayloadBlob</i> parameter, and return a
///hash of the template in the <i>HashValue</i> parameter.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Identity = Pointer to a WINBIO_IDENTITY structure that contains a GUID or SID that is expected to match that of the template
///               recovered from the database.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that is expected to match that of the template recovered from the
///                database. See the Remarks section for more details.
///    Match = Pointer to a Boolean value that specifies whether the <i>Identity</i> and <i>SubFactor</i> parameters match those
///            of the template recovered from the database. <b>TRUE</b> specifies that these values match.
///    PayloadBlob = Address of a variable that receives a pointer to the payload data saved with the template. If there is no payload
///                  data, set this value to <b>NULL</b>.
///    PayloadBlobSize = Pointer to a value that receives the size, in bytes, of the buffer specified in the <i>PayloadBlob</i> parameter.
///                      If there is no payload data stored with the template, set this value to zero.
///    HashValue = Address of a variable that receives a pointer to the hash of the template. If the engine adapter does not support
///                hash generation, set this value to <b>NULL</b>.
///    HashSize = Pointer to a value that contains the size, in bytes, of the hash specified by the <i>HashValue</i> parameter. If
///               the engine adapter does not support hash generation, set this value to zero.
///    RejectDetail = Pointer to a <b>WINBIO_REJECT_DETAIL</b> value that receives additional information if a capture failure prevents
///                   the engine from performing a matching operation. If the most-recent capture succeeded, set this parameter to
///                   zero. The following values are defined for fingerprint capture <ul> <li>WINBIO_FP_TOO_HIGH</li>
///                   <li>WINBIO_FP_TOO_LOW</li> <li>WINBIO_FP_TOO_LEFT</li> <li>WINBIO_FP_TOO_RIGHT</li> <li>WINBIO_FP_TOO_FAST</li>
///                   <li>WINBIO_FP_TOO_SLOW</li> <li>WINBIO_FP_POOR_QUALITY</li> <li>WINBIO_FP_TOO_SKEWED</li>
///                   <li>WINBIO_FP_TOO_SHORT</li> <li>WINBIO_FP_MERGE_FAILURE</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td
///    width="60%"> The value specified in the <i>SubFactor</i> parameter is not correct. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b><b> WINBIO_E_BAD_CAPTURE</b></b></dt> </dl> </td> <td width="60%"> The feature set did
///    not meet the internal requirements of the engine adapter for a verification operation. Further information about
///    the failure is specified by the <i>RejectDetail</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_NO_MATCH</b></b></dt> </dl> </td> <td width="60%"> The feature set in the pipeline matches one
///    stored in the database but it does not correspond to the combination of values passed in the <i>Identity</i> and
///    <i>SubFactor</i> parameters. </td> </tr> </table>
///    
alias PIBIO_ENGINE_VERIFY_FEATURE_SET_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                            ubyte SubFactor, ubyte* Match, char* PayloadBlob, 
                                                            size_t* PayloadBlobSize, char* HashValue, 
                                                            size_t* HashSize, uint* RejectDetail);
///Called by the Windows Biometric Framework to build a template from the current feature set and locate a matching
///template in the database. If a match can be found, the engine adapter must fill the <i>Identity</i>,
///<i>SubFactor</i>, <i>PayloadBlob</i> parameters with the appropriate information from the stored template.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Identity = Pointer to a WINBIO_IDENTITY structure that contains the GUID or SID of the template recovered from the database.
///               This value is returned only if a match is found.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that receives the sub-factor associated with the template in the
///                database. See the Remarks section for more details. This value is returned only if a match is found.
///    PayloadBlob = Address of a variable that receives a pointer to the payload data saved with the template. If there is no payload
///                  data, set this value to <b>NULL</b>.
///    PayloadBlobSize = Pointer to a variable that receives the size, in bytes, of the buffer specified by the <i>PayloadBlob</i>
///                      parameter. If there is no payload data, set this value to zero.
///    HashValue = Address of a variable that receives a pointer to the generated hash value for the template. If the engine adapter
///                does not support hash generation, set this value to <b>NULL</b>.
///    HashSize = Pointer to a variable that receives the size, in bytes, of the buffer specified by the <i>HashValue</i>
///               parameter. If the engine adapter does not support hash generation, set this value to zero.
///    RejectDetail = Pointer to a variable that receives additional information if a capture failure prevents the engine from
///                   performing a matching operation. If the most recent capture succeeded, set this parameter to zero. The following
///                   values are defined for fingerprint capture: <ul> <li>WINBIO_FP_TOO_HIGH</li> <li>WINBIO_FP_TOO_LOW</li>
///                   <li>WINBIO_FP_TOO_LEFT</li> <li>WINBIO_FP_TOO_RIGHT</li> <li>WINBIO_FP_TOO_FAST</li> <li>WINBIO_FP_TOO_SLOW</li>
///                   <li>WINBIO_FP_POOR_QUALITY</li> <li>WINBIO_FP_TOO_SKEWED</li> <li>WINBIO_FP_TOO_SHORT</li>
///                   <li>WINBIO_FP_MERGE_FAILURE</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK to indicate that the last update succeeded and no additional feature
///    sets are required to complete the template. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b> WINBIO_E_BAD_CAPTURE</b></b></dt> </dl> </td> <td
///    width="60%"> The feature set did not meet internal requirements of the engine adapter for an identification
///    operation. Further information about the failure is specified by the <i>RejectDetail</i> parameter. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_UNKNOWN_ID</b></b></dt> </dl> </td> <td width="60%"> The feature
///    set in the pipeline does not correspond to any identity in the database. </td> </tr> </table>
///    
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                              ubyte* SubFactor, char* PayloadBlob, 
                                                              size_t* PayloadBlobSize, char* HashValue, 
                                                              size_t* HashSize, uint* RejectDetail);
///Called by the Windows Biometric Framework to initialize the enrollment object in the biometric unit pipeline.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    There is not enough memory to complete the operation. </td> </tr> </table>
///    
alias PIBIO_ENGINE_CREATE_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to add the current feature set to the enrollment object.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    RejectDetail = Pointer to a <b>WINBIO_REJECT_DETAIL</b> value that receives additional information about the failure to update
///                   the enrollment object. If the update succeeds, this value should be set to zero.
///Returns:
///    This function must return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The last
///    update succeeded and no additional feature sets are required to complete the template. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b> WINBIO_E_BAD_CAPTURE</b></b></dt> </dl> </td> <td
///    width="60%"> The feature set did not meet the internal enrollment requirements of the engine adapter. Further
///    information about the failure is specified by the <i>RejectDetail</i> parameter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> There is no
///    enrollment in progress on this biometric unit. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_I_MORE_DATA</b></b></dt> </dl> </td> <td width="60%"> The last update succeeded, but the engine
///    adapter requires one or more additional feature sets before it can complete the enrollment template. </td> </tr>
///    </table>
///    
alias PIBIO_ENGINE_UPDATE_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
///Called by the Windows Biometric Framework to determine whether the enrollment object is ready to be committed to the
///pipeline.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    RejectDetail = A pointer to a <b>WINBIO_REJECT_DETAIL</b> value that receives additional information about the failure to update
///                   the enrollment object. If the last update was successful, you should set this variable to zero.
///Returns:
///    This function must return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The last
///    update succeeded and no additional feature sets are required to complete the template. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b> WINBIO_E_BAD_CAPTURE</b></b></dt> </dl> </td> <td
///    width="60%"> The feature set did not meet the internal enrollment requirements of the engine adapter. Further
///    information about the failure is specified by the <i>RejectDetail</i> parameter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> There is no
///    enrollment in progress on this biometric unit. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_I_MORE_DATA</b></b></dt> </dl> </td> <td width="60%"> The last update succeeded, but the engine
///    adapter requires one or more additional feature sets before it can complete the enrollment template. </td> </tr>
///    </table>
///    
alias PIBIO_ENGINE_GET_ENROLLMENT_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
///Called by the Windows Biometric Framework to retrieve the hash of the completed enrollment template in the pipeline.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    HashValue = Address of variable that receives a pointer to a byte array that contains the hash of the template.
///    HashSize = A pointer to a variable that receives the size, in bytes, of the hash pointed to by the <i>HashValue</i>
///               parameter.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The
///    engine adapter does not support template hash generation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The pipeline does not contain a
///    completed enrollment template. </td> </tr> </table>
///    
alias PIBIO_ENGINE_GET_ENROLLMENT_HASH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* HashValue, 
                                                             size_t* HashSize);
///Called by the Windows Biometric Framework to determine whether a new template in the pipeline duplicates any template
///already saved in the database regardless of the identity associated with the templates.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Identity = Pointer to a WINBIO_IDENTITY structure that receives the GUID or SID of the duplicate template stored in the
///               database.
///    SubFactor = Pointer to a <b>WINBIO_BIOMETRIC_SUBTYPE</b> variable that receives the sub-factor associated with the duplicate
///                template in the database.
///    Duplicate = A pointer to a Boolean value that specifies whether a matching template was found in the database.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
///    </dl> </td> <td width="60%"> A mandatory pointer parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> There is no enrollment template in the
///    pipeline engine context. </td> </tr> </table>
///    
alias PIBIO_ENGINE_CHECK_FOR_DUPLICATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                             ubyte* SubFactor, ubyte* Duplicate);
///Called by the Windows Biometric Framework to finalize the enrollment object, convert it to a template, and save the
///template in the database.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Identity = Pointer to a WINBIO_IDENTITY structure that contains the GUID or SID of the template to be stored in the
///               database.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that specifies the sub-factor associated with the template to be stored
///                in the database.
///    PayloadBlob = An optional pointer to an array of bytes that contain a verification signature generated by the Windows Biometric
///                  Framework.
///    PayloadBlobSize = The size, in bytes, of the character array pointed to by the <i>PayloadBlob</i> parameter. This value must be
///                      zero if the <i>PayloadBlob</i> parameter is <b>NULL</b>.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values or any value returned by the storage adapter. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
///    mandatory pointer argument is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>
///    E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%"> The value specified by the <i>Identity</i> parameter or
///    the <i>SubFactor</i> parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DUPLICATE_ENROLLMENT</b></b></dt> </dl> </td> <td width="60%"> The template specified by the
///    <i>Identity</i> and <i>SubFactor</i> parameters is already saved in the database. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> There is no template
///    attached to the pipeline. </td> </tr> </table>
///    
alias PIBIO_ENGINE_COMMIT_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                           ubyte SubFactor, char* PayloadBlob, 
                                                           size_t PayloadBlobSize);
///Called by the Windows Biometric Framework to delete intermediate enrollment state information from the pipeline.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return the following <b>HRESULT</b>
///    value to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot be <b>NULL</b>.
///    </td> </tr> </table>
///    
alias PIBIO_ENGINE_DISCARD_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to perform a vendor-defined control operation that does not require
///elevated privilege. Call the EngineAdapterControlUnitPrivileged function to perform a vendor-defined control
///operation that requires elevated privilege.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    ControlCode = A <b>ULONG</b> value that specifies the vendor-defined operation to perform.
///    SendBuffer = Pointer to a buffer that contains the control information sent to the engine adapter. The format and content of
///                 the buffer is vendor-defined.
///    SendBufferSize = Size, in bytes, of the buffer specified by the <i>SendBuffer</i> parameter.
///    ReceiveBuffer = Pointer to a buffer that receives information returned by the engine adapter in response to the control
///                    operation. The format of the buffer is vendor-defined.
///    ReceiveBufferSize = Size, in bytes, of the buffer specified by the <i>ReceiveBuffer</i> parameter.
///    ReceiveDataSize = Pointer to a variable that receives the size, in bytes, of the data written to the buffer specified by the
///                      <i>ReceiveBuffer</i> parameter.
///    OperationStatus = Pointer to a variable that receives a vendor-defined status code that specifies the outcome of the control
///                      operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b> E_INVALIDARG</b></b></dt> </dl> </td> <td
///    width="60%"> The size or format of the buffer specified by the <i>SendBuffer</i> parameter is not correct, or the
///    value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_NOT_SUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer specified by
///    the <i>ReceiveBuffer</i> parameter is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_CANCELED</b></dt> </dl> </td> <td width="60%"> The operation was canceled. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_FAILURE</b></dt> </dl> </td> <td width="60%"> There was a hardware
///    failure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_INVALID_CONTROL_CODE</b></b></dt> </dl> </td>
///    <td width="60%"> The value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. <div
///    class="alert"><b>Note</b> Beginning with Windows 8, use only <b>E_INVALIDARG</b> to signal this condition.</div>
///    <div> </div> </td> </tr> </table>
///    
alias PIBIO_ENGINE_CONTROL_UNIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                      char* SendBuffer, size_t SendBufferSize, char* ReceiveBuffer, 
                                                      size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                      uint* OperationStatus);
///Called by the Windows Biometric Framework to perform a vendor-defined control operation that requires elevated
///privilege. Call the EngineAdapterControlUnit function to perform a vendor-defined control operation that does not
///require elevated privilege.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    ControlCode = A <b>ULONG</b> value that specifies the vendor-defined operation to perform.
///    SendBuffer = Pointer to a buffer that contains the control information sent to the engine adapter. The format and content of
///                 the buffer is vendor-defined.
///    SendBufferSize = Size, in bytes, of the buffer specified by the <i>SendBuffer</i> parameter.
///    ReceiveBuffer = Pointer to a buffer that receives information returned by the engine adapter in response to the control
///                    operation. The format of the buffer is vendor-defined.
///    ReceiveBufferSize = Size, in bytes, of the buffer specified by the <i>ReceiveBuffer</i> parameter.
///    ReceiveDataSize = Pointer to a variable that receives the size, in bytes, of the data written to the buffer specified by the
///                      <i>ReceiveBuffer</i> parameter.
///    OperationStatus = Pointer to a variable that receives a vendor-defined status code that specifies the outcome of the control
///                      operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b> E_INVALIDARG</b></b></dt> </dl> </td> <td
///    width="60%"> The size or format of the buffer specified by the <i>SendBuffer</i> parameter is not correct, or the
///    value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_NOT_SUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer specified by
///    the <i>ReceiveBuffer</i> parameter is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_CANCELED</b></dt> </dl> </td> <td width="60%"> The operation was canceled. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_FAILURE</b></dt> </dl> </td> <td width="60%"> There was a hardware
///    failure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_INVALID_CONTROL_CODE</b></b></dt> </dl> </td>
///    <td width="60%"> The value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. <div
///    class="alert"><b>Note</b> Beginning with Windows 8, use only <b>E_INVALIDARG</b> to signal this condition.</div>
///    <div> </div> </td> </tr> </table>
///    
alias PIBIO_ENGINE_CONTROL_UNIT_PRIVILEGED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                                 char* SendBuffer, size_t SendBufferSize, 
                                                                 char* ReceiveBuffer, size_t ReceiveBufferSize, 
                                                                 size_t* ReceiveDataSize, uint* OperationStatus);
///Called by the Windows Biometric Framework when the computer is ready to enter a low-power state or when the computer
///has been awakened from a low-power state. The purpose of this function is to enable the adapter to respond to
///transitions in the computer power state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    PowerEventType = Indicates the nature of the change. It can be one of the following values: * **PBT_APMSUSPEND** The system is
///                     entering a low-power state. * **PBT_APMRESUMEAUTOMATIC** The system is returning from a low-power state. *
///                     **PBT_APMPOWERSTATUSCHANGE** The status of the system's power source is changing (e.g. the system has switched
///                     from battery to line power, or the battery is getting low).
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values.
///    
alias PIBIO_ENGINE_NOTIFY_POWER_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
alias PIBIO_ENGINE_RESERVED_1_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity);
///Called by the Windows Biometric Framework to give the Engine Adapter the chance to perform any initialization that
///remains incomplete.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_some_error </b></dt> </dl> </td> <td width="60%"> Any error code will cause the
///    Biometric Service to log the error and abort the configuration of the biometric unit. </td> </tr> </table>
///    
alias PIBIO_ENGINE_PIPELINE_INIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to give the Engine Adapter the chance to perform any cleanup that requires
///help from the Storage Adapter.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_ENGINE_PIPELINE_CLEANUP_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to give the Engine Adapter the chance to perform any work needed to bring
///the sensor component out of an idle state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_ENGINE_ACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to give the Engine Adapter the chance to perform any work needed to put the
///sensor component into an idle state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_ENGINE_DEACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to determine the capabilities and limitations of the biometric engine
///component.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    EngineInfo = Pointer to the the WINBIO_EXTENDED_ENGINE_INFO structure that contains the engine information returned by this
///                 function.
///    EngineInfoSize = The specified size in bytes of the engine information.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> and
///    <i>EngineInfo</i> parameters cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG
///    </b></dt> </dl> </td> <td width="60%"> The <i>EngineInfoSize</i> value is less than the size needed to return the
///    engine information. </td> </tr> </table>
///    
alias PIBIO_ENGINE_QUERY_EXTENDED_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* EngineInfo, 
                                                             size_t EngineInfoSize);
///Called by the Windows Biometric Framework to determine the identities of any people who are currently in camera
///frame.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    PresenceCount = Address of a variable that receives the number of presences detected by the function.
///    PresenceArray = Address of a variable that receives a pointer to an array of WINBIO_PRESENCE elements.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_some_error </b></dt> </dl> </td> <td width="60%"> Any error code will cause the
///    Biometric Service to log the error and ignore the camera frame. </td> </tr> </table>
///    
alias PIBIO_ENGINE_IDENTIFY_ALL_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* PresenceCount, 
                                                      WINBIO_PRESENCE** PresenceArray);
///Called by the Windows Biometric Framework to tell the Engine Adapter which person to track for the current enrollment
///operation.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    SelectorValue = The enrollment selector value to use.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_ENGINE_SET_ENROLLMENT_SELECTOR_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ulong SelectorValue);
///Called by the Windows Biometric Framework to give the engine adapter additional information about an enrollment
///operation.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Parameters = Pointer to the WINBIO_EXTENDED_ENROLLMENT_PARAMETERS structure containing the extended enrollment parameters to
///                 use.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_ENGINE_SET_ENROLLMENT_PARAMETERS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   WINBIO_EXTENDED_ENROLLMENT_PARAMETERS* Parameters);
///Called by the Windows Biometric Framework when a client application queries the
///<b>WINBIO_PROPERTY_EXTENDED_ENROLLMENT_STATUS</b> property.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    EnrollmentStatus = Pointer to the WINBIO_EXTENDED_ENROLLMENT_STATUS structure that contains the extended enrollment status
///                       information returned by this function.
///    EnrollmentStatusSize = The specified size in bytes of the extended enrollment status information.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%">
///    The <i>EnrollmentStatusSize</i> parameter indicates that the output buffer is too small. </td> </tr> </table>
///    
alias PIBIO_ENGINE_QUERY_EXTENDED_ENROLLMENT_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                          char* EnrollmentStatus, 
                                                                          size_t EnrollmentStatusSize);
///Called by the Windows Biometric Framework to notify the Engine Adapter that it should discard any cached templates
///that it may be keeping in memory.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    The function will return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
///    <i>Pipeline</i> parameter cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
///    </dl> </td> <td width="60%"> This value is returned in all other cases. </td> </tr> </table>
///    
alias PIBIO_ENGINE_REFRESH_CACHE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to determine which of the Sensor Adapter’s calibration formats the Engine
///Adapter wants to use.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    FormatArray = Address of an array of WINBIO_UUID items identifying the calibration data formats supported by the Sensor
///                  Adapter. The Engine Adapter is expected to choose one of these formats for its calibration data.
///    FormatCount = Value indicating the number of UUIDs in the <i>FormatArray</i> parameter.
///    SelectedFormat = Address of a WINBIO_UUID item where the <b>EngineAdapterSelectCalibrationFormat</b> method will store the UUID of
///                     the selected calibration format. This must be one of the UUIDs in the <i>FormatArray</i> parameter.
///    MaxBufferSize = Address of a variable where the <b>EngineAdapterSelectCalibrationFormat</b> method will store the maximum size
///                    (in bytes) of any calibration data it plans to return to the Sensor Adapter. The maximum size of this buffer must
///                    be 4096 bytes or less.
///Returns:
///    The function will return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> The
///    operation succeeded. The <i>SelectedFormat</i> and <i>MaxBufferSize</i> return values have both been set. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL </b></dt> </dl> </td> <td width="60%"> The Engine Adapter
///    doesn’t require dynamic calibration. This is not an error condition. The Biometric Service will convert this
///    value to <b>S_OK</b>, and the biometric unit will be configured not to use dynamic calibration. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WINBIO_E_NO_SUPPORTED_CALIBRATION_FORMAT </b></dt> </dl> </td> <td width="60%"> The
///    Engine Adapter requires dynamic calibration, but doesn’t support any of the calibration formats specified in
///    the <i>FormatArray</i> parameter. (The Engine Adapter should also return this error code if the
///    <i>FormatCount</i> argument is zero.) This error code will cause the Biometric Service to log the error and abort
///    the configuration of the biometric unit. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_some_other_error
///    </b></dt> </dl> </td> <td width="60%"> Any other error code will cause the Biometric Service to log the error and
///    abort the configuration of the biometric unit. </td> </tr> </table>
///    
alias PIBIO_ENGINE_SELECT_CALIBRATION_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* FormatArray, 
                                                                   size_t FormatCount, GUID* SelectedFormat, 
                                                                   size_t* MaxBufferSize);
///Called by the Windows Biometric Framework to get a set of post-capture calibration data from the engine adapter.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    DiscardAndRepeatCapture = Address of a Boolean value that must be set by the <b>EngineAdapterQueryCalibrationData</b> method. This value
///                              indicates what the biometric service should do with the current sample after calibration is complete. <ul> <li>
///                              <b>TRUE</b> indicates that the captured biometric sample is unusable. The biometric service will discard the
///                              sample and collect a new one. </li> <li> <b>FALSE</b> indicates that the sample is usable and the Engine should
///                              be instructed to perform further operations on it. </li> </ul>
///    CalibrationBuffer = Address of an empty buffer where the method is expected to write its calibration data. The memory holding this
///                        buffer belongs to the biometric service, and the Engine Adapter must not keep any pointers to this buffer once
///                        the <b>EngineAdapterQueryCalibrationData</b> method returns.
///    CalibrationBufferSize = Address of a variable where the <b>EngineAdapterQueryCalibrationData</b> method will store the size (in bytes) of
///                            the calibration data it has written to <i>CalibrationBuffer</i>. This value must not exceed <i>MaxBufferSize</i>.
///                            If <b>EngineAdapterQueryCalibrationData</b> sets this value to zero, the contents of the <i>CalibrationBuffer</i>
///                            will be discarded without sending them to the Sensor Adapter. This is not an error condition; it simply indicates
///                            that the Engine Adapter doesn’t need to update the sensor’s calibration based on the current capture data.
///    MaxBufferSize = A value indicating the maximum space (in bytes) available to the Engine Adapter in the <i>CalibrationBuffer</i>.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_some_error </b></dt> </dl> </td> <td width="60%"> Any error code will cause the
///    Biometric Service to discontinue the dynamic calibration loop and abort the capture operation. </td> </tr>
///    </table>
///    
alias PIBIO_ENGINE_QUERY_CALIBRATION_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                ubyte* DiscardAndRepeatCapture, 
                                                                char* CalibrationBuffer, 
                                                                size_t* CalibrationBufferSize, size_t MaxBufferSize);
///Called by the Windows Biometric Framework to set the extended default and per-user antispoofing policies used by the
///engine adapter.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    PolicyItemArray = Address of an array of WINBIO_ACCOUNT_POLICY structures, which the routine should use to update the policies it
///                      is applying to any identities it detects.
///    PolicyItemCount = The number of elements in the array pointed to by the <i>PolicyItemArray</i> parameter.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_some_error </b></dt> </dl> </td> <td width="60%"> Errors return by the method are
///    logged but ignored. </td> </tr> </table>
///    
alias PIBIO_ENGINE_SET_ACCOUNT_POLICY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* PolicyItemArray, 
                                                            size_t PolicyItemCount);
///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Called by the Windows Biometric Framework to push an HMAC key to the sensor. The returned key
///identifier will be passed back to the biometric unit when the framework calls EngineAdapterIdentifyFeatureSetSecure.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Key = Pointer to a buffer that contains the HMAC key.
///    KeySize = Size, in bytes, of the buffer specified by the <b>Key</b> parameter.
///    KeyIdentifier = Pointer to a buffer that receives a key identifier. The format of the buffer is vendor-defined.
///    KeyIdentifierSize = Size, in bytes, of the buffer specified by the <b>KeyIdentifier</b> parameter.
///    ResultSize = Pointer to a variable that receives the size, in bytes, of the data written to the buffer specified by the
///                 <b>KeyIdentifier</b> parameter.
///Returns:
///    If the <b>KeyIdentifier</b> buffer is too small, <b>WINBIO_E_KEY_IDENTIFIER_BUFFER_TOO_SMALL</b> must be
///    returned, and the required size must be written to <i>ResultSize</i>. The framework will call the API again with
///    a larger buffer. If the sensor cannot create the key, <b>WINBIO_E_KEY_CREATION_FAILED</b> must be returned.
///    
alias PIBIO_ENGINE_CREATE_KEY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* Key, size_t KeySize, 
                                                    char* KeyIdentifier, size_t KeyIdentifierSize, 
                                                    size_t* ResultSize);
///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Called by the Windows Biometric Framework to build a template from the current feature set and locate
///a matching template in the database. If a match can be found, the engine adapter must fill the <i>Identity</i>,
///<i>SubFactor</i>, <i>Authorization</i>, and <i>AuthorizationSize</i> fields.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Nonce = Pointer to a buffer that contains a nonce.
///    NonceSize = Size, in bytes, of the buffer specified by the <i>Nonce</i> parameter.
///    KeyIdentifier = Pointer to a buffer that contains an identifier for the key from a previous call to EngineAdapterCreateKey
///    KeyIdentifierSize = Size, in bytes, of the buffer specified by the <i>KeyIdentifier</i> parameter.
///    Identity = Pointer to a WINBIO_IDENTITY structure that contains the SID of the template recovered from the database. This
///               value is returned only if a match is found.
///    SubFactor = 
///    RejectDetail = Pointer to a variable that receives additional information if a capture failure prevents the engine from
///                   performing a matching operation. If the most recent capture succeeded, set this parameter to zero.
///    Authorization = An HMAC. See remarks section.
///    AuthorizationSize = Size, in bytes, of the buffer specified by the <i>Authorization</i> parameter.
///    Subfactor = A WINBIO_BIOMETRIC_SUBTYPE Constants value that receives the sub-factor associated with the template in the
///                database. See the Remarks section for more details. This value is returned only if a match is found.
///Returns:
///    <b>WINBIO_E_INVALID_KEY_IDENTIFIER</b> must be returned in the case where the key cannot be used for whatever
///    reason. When <b>WINBIO_E_INVALID_KEY_IDENTIFIER </b>is returned, the sensor and TPM will be re-provisioned.
///    
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_SECURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* Nonce, 
                                                                     size_t NonceSize, char* KeyIdentifier, 
                                                                     size_t KeyIdentifierSize, 
                                                                     WINBIO_IDENTITY* Identity, ubyte* SubFactor, 
                                                                     uint* RejectDetail, ubyte** Authorization, 
                                                                     size_t* AuthorizationSize);
alias PIBIO_ENGINE_ACCEPT_PRIVATE_SENSOR_TYPE_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                         char* TypeInfoBufferAddress, 
                                                                         size_t TypeInfoBufferSize);
alias PIBIO_ENGINE_CREATE_ENROLLMENT_AUTHENTICATED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte** Nonce, 
                                                                         size_t* NonceSize);
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_AUTHENTICATED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* Nonce, 
                                                                            size_t NonceSize, 
                                                                            WINBIO_IDENTITY* Identity, 
                                                                            ubyte* SubFactor, uint* RejectDetail, 
                                                                            ubyte** Authentication, 
                                                                            size_t* AuthenticationSize);
alias PWINBIO_QUERY_ENGINE_INTERFACE_FN = HRESULT function(WINBIO_ENGINE_INTERFACE** EngineInterface);
///Called by the Windows Biometric Framework when a storage adapter is added to the processing pipeline of the biometric
///unit. The purpose of this function is to perform any initialization required for later biometric operations.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    The operation could not be completed because of insufficient memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>StorageContext</b> member of
///    the WINBIO_PIPELINE structure pointed to by the <i>Pipeline</i> argument is not <b>NULL</b> or the
///    <b>StorageHandle</b> member is not set to <b>INVALID_HANDLE_VALUE</b>. </td> </tr> </table>
///    
alias PIBIO_STORAGE_ATTACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework immediately before a storage adapter is removed from the processing
///pipeline of the biometric unit. The purpose of this function is to release adapter specific resources attached to the
///pipeline.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td>
///    <td width="60%"> The <b>StorageContext</b> field of the WINBIO_PIPELINE structure cannot be <b>NULL</b>. </td>
///    </tr> </table>
///    
alias PIBIO_STORAGE_DETACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to prepare the processing pipeline of the biometric unit for a new
///operation. This function should flush temporary data from the engine context and place the engine adapter into a
///well-defined initial state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td>
///    <td width="60%"> The <b>StorageContext</b> member of the WINBIO_PIPELINE structure pointed to by the
///    <i>Pipeline</i> argument is <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_STORAGE_CLEAR_CONTEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to create and configure a new database.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    DatabaseId = Pointer to a GUID that uniquely identifies the database. This is the same GUID used to register the database in
///                 the registry.
///    Factor = A WINBIO_BIOMETRIC_TYPE value that specifies the type of the biometric factor stored in this database. Only
///             <b>WINBIO_TYPE_FINGERPRINT</b> is currently supported.
///    Format = Pointer to a GUID that specifies the vendor-defined format of the data in the <b>VendorDataBlock</b> member of
///             the WINBIO_BIR object.
///    FilePath = Pointer to a <b>NULL</b>-terminated Unicode string that contains the fully qualified file path for the database.
///    ConnectString = Pointer to a <b>NULL</b>-terminated Unicode connection string for the database.
///    IndexElementCount = The number of elements in the index vector. This can be equal to or greater than zero.
///    InitialSize = A value that contains the beginning size of the database, in bytes.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td
///    width="60%"> The <b>StorageContext</b> member of the pipeline object is <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_STORAGE_CREATE_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* DatabaseId, uint Factor, 
                                                          GUID* Format, const(wchar)* FilePath, 
                                                          const(wchar)* ConnectString, size_t IndexElementCount, 
                                                          size_t InitialSize);
///Called by the Windows Biometric Framework to erase the database and mark it for deletion.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    DatabaseId = A pointer to a GUID that uniquely identifies the database. This is the same GUID used to register the database in
///                 the registry.
///    FilePath = Pointer to a <b>NULL</b>-terminated UNICODE string that contains the fully qualified file path for the database.
///    ConnectString = A pointer to a <b>NULL</b>-terminated UNICODE connection string for the database.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_DATABASE_CORRUPTED</b></dt> </dl> </td> <td
///    width="60%"> The <i>DatabaseId</i> parameter is not the same as the one used when creating the database. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_DATABASE_CANT_FIND</b></dt> </dl> </td> <td width="60%"> The
///    specified database cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>StorageContext</b> member of
///    the pipeline object is <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_STORAGE_ERASE_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* DatabaseId, 
                                                         const(wchar)* FilePath, const(wchar)* ConnectString);
///Called by the Windows Biometric Framework to open a database.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    DatabaseId = Pointer to a GUID that uniquely identifies the database. This is the same GUID used to register the database in
///                 the registry.
///    FilePath = Pointer to a <b>NULL</b>-terminated Unicode string that contains the fully qualified file path for the database.
///    ConnectString = Pointer to a <b>NULL</b>-terminated Unicode connection string for the database.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_CANT_CREATE</b></b></dt> </dl>
///    </td> <td width="60%"> The database cannot be created. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DATABASE_CANT_FIND</b></b></dt> </dl> </td> <td width="60%"> The specified database cannot be
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_LOCKED</b></b></dt> </dl> </td> <td
///    width="60%"> The database is currently locked by another application and cannot be opened. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_CANT_OPEN</b></b></dt> </dl> </td> <td width="60%"> An unspecified
///    problem has caused the request to fail. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>StorageContext</b> member of
///    the pipeline object is <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_STORAGE_OPEN_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* DatabaseId, 
                                                        const(wchar)* FilePath, const(wchar)* ConnectString);
///Called by the Windows Biometric Framework to close the database associated with the pipeline and free all related
///resources.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument cannot
///    be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_CANT_CLOSE</b></b></dt> </dl>
///    </td> <td width="60%"> An unspecified problem has caused the request to fail. </td> </tr> </table>
///    
alias PIBIO_STORAGE_CLOSE_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to retrieve format and version information used by the current database
///associated with the pipeline.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Format = Pointer to a variable that receives a GUID that uniquely identifies the data format used by this storage adapter
///             when it stores templates in the database.
///    Version = Pointer to a WINBIO_VERSION structure that receives the version number of the storage adapter component.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td
///    width="60%"> The <b>StorageContext</b> member of the pipeline object is <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_STORAGE_GET_DATA_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* Format, 
                                                          WINBIO_VERSION* Version);
///Called by the Windows Biometric Framework to retrieve the database size and available space.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    AvailableRecordCount = Pointer to a variable that receives the number of unused record slots in the database.
///    TotalRecordCount = Pointer to a variable that receives the number of valid records in the database.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td
///    width="60%"> The <b>StorageContext</b> member of the pipeline object is <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_STORAGE_GET_DATABASE_SIZE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                            size_t* AvailableRecordCount, size_t* TotalRecordCount);
///Called by the engine adapter to add a template to the database.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    RecordContents = Pointer to a WINBIO_STORAGE_RECORD structure that contains the template to add.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A member of the structure
///    specified by the <i>RecordContents</i> parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is <b>NULL</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_BAD_INDEX_VECTOR</b></b></dt> </dl> </td> <td width="60%">
///    The size of the index vector specified in the WINBIO_STORAGE_RECORD structure does not match the index size
///    specified when the database was created. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DUPLICATE_ENROLLMENT</b></b></dt> </dl> </td> <td width="60%"> The database already contains a
///    template with the combination of values specified by the <i>Identity</i> and <i>SubFactor</i> parameters. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_CORRUPTED</b></b></dt> </dl> </td> <td width="60%">
///    There is an unspecified problem with the database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DATABASE_FULL</b></b></dt> </dl> </td> <td width="60%"> The database is full and no further
///    records can be added. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_LOCKED</b></b></dt>
///    </dl> </td> <td width="60%"> The database is locked. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DATABASE_WRITE_ERROR</b></b></dt> </dl> </td> <td width="60%"> Record addition failed because
///    of an unspecified problem. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt>
///    </dl> </td> <td width="60%"> The <b>StorageContext</b> member of the pipeline object is <b>NULL</b> or the
///    <b>FileHandle</b> member is not valid. </td> </tr> </table>
///    
alias PIBIO_STORAGE_ADD_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                     WINBIO_STORAGE_RECORD* RecordContents);
///Called by the Windows Biometric Framework to delete one or more templates from the database.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Identity = Pointer to a WINBIO_IDENTITY structure that contains the GUID or SID of the template to delete.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that specifies the sub-factor associated with the template to delete.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument specified by the
///    <i>SubFactor</i> parameter is not valid or a member of the structure specified by the <i>Identity</i> parameter
///    is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    Memory could not be allocated for the record header. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is <b>NULL</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_CORRUPTED</b></b></dt> </dl> </td> <td width="60%"> There
///    is an unspecified problem with the database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DATABASE_NO_SUCH_RECORD</b></b></dt> </dl> </td> <td width="60%"> No matching record could be
///    found in the database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl>
///    </td> <td width="60%"> The <b>StorageContext</b> member of the pipeline object is <b>NULL</b> or the
///    <b>FileHandle</b> member is not valid. </td> </tr> </table>
///    
alias PIBIO_STORAGE_DELETE_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                        ubyte SubFactor);
///Called by the Windows Biometric Framework or by the engine adapter to locate templates that match a specified
///identity and sub-factor.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    Identity = Pointer to a WINBIO_IDENTITY structure that contains the GUID or SID to be located. If the <b>Type</b> field of
///               this structure contains <b>WINBIO_IDENTITY_TYPE_WILDCARD</b>, the query returns every template that matches the
///               <i>SubFactor</i> parameter.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that specifies the sub-factor to be located. If this value is
///                <b>WINBIO_SUBTYPE_ANY</b>, the query returns every template that matches the <i>Identity</i> parameter.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument specified by the
///    <i>SubFactor</i> parameter is not valid or a member of the structure specified by the <i>Identity</i> parameter
///    is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
///    mandatory pointer argument is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DATABASE_NO_RESULTS</b></b></dt> </dl> </td> <td width="60%"> The query was successful, but no
///    matching records could be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DATABASE_LOCKED</b></b></dt> </dl> </td> <td width="60%"> The database is locked. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_READ_ERROR</b></b></dt> </dl> </td> <td width="60%"> An
///    unspecified problem occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>StorageContext</b> member of
///    the pipeline object is <b>NULL</b> or the <b>FileHandle</b> member is not valid. </td> </tr> </table>
///    
alias PIBIO_STORAGE_QUERY_BY_SUBJECT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                           ubyte SubFactor);
///Called by the engine adapter to locate templates that match a specified index vector.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that specifies the sub-factor associated with the template.
///    IndexVector = 
///    IndexElementCount = A value that contains the number of elements in the index vector array. This must match the size specified when
///                        the database was created. If the database was created with a zero length index, this parameter must be zero.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument specified by the
///    <i>SubFactor</i> parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
///    </td> <td width="60%"> A mandatory pointer argument is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Memory could not be allocated for the record header.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_BAD_INDEX_VECTOR</b></b></dt> </dl> </td> <td
///    width="60%"> The size of the index vector does not match the index size specified when the database was created.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_NO_RESULTS</b></b></dt> </dl> </td> <td
///    width="60%"> The query was successful, but no matching records could be found. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b><b>WINBIO_E_DATABASE_LOCKED</b></b></dt> </dl> </td> <td width="60%"> The database is locked. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_READ_ERROR</b></b></dt> </dl> </td> <td width="60%">
///    An unspecified problem occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>StorageContext</b> member of
///    the pipeline object is <b>NULL</b> or the <b>FileHandle</b> member is not valid. </td> </tr> </table>
///    
alias PIBIO_STORAGE_QUERY_BY_CONTENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte SubFactor, 
                                                           char* IndexVector, size_t IndexElementCount);
///Called by the Windows Biometric Framework or by the engine adapter to retrieve the number of template records in the
///pipeline result set.
///Params:
///    Pipeline = Pointer to a WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    RecordCount = Pointer to a variable that receives the number of template records in the result set.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_NO_RESULTS</b></b></dt> </dl>
///    </td> <td width="60%"> The query was successful, but no matching records could be found. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The
///    <b>StorageContext</b> member of the pipeline object is <b>NULL</b> or the <b>FileHandle</b> member is not valid.
///    </td> </tr> </table>
///    
alias PIBIO_STORAGE_GET_RECORD_COUNT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* RecordCount);
///Called by the Windows Biometric Framework or by an engine adapter to position the result set cursor on the first
///record in the set.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_DATABASE_NO_RESULTS</b></dt> </dl> </td> <td
///    width="60%"> There are no records in the result set. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td width="60%"> The <b>StorageContext</b> member of
///    the pipeline object is <b>NULL</b> or the <b>FileHandle</b> member is not valid. </td> </tr> </table>
///    
alias PIBIO_STORAGE_FIRST_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework or by an engine adapter to advance the result set cursor by one record.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DATABASE_NO_RESULTS</b></b></dt> </dl>
///    </td> <td width="60%"> There are no records in the result set. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DATABASE_NO_MORE_RECORDS</b></b></dt> </dl> </td> <td width="60%"> The cursor is already on
///    the last record. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td>
///    <td width="60%"> The <b>StorageContext</b> member of the pipeline object is <b>NULL</b> or the <b>FileHandle</b>
///    member is not valid. </td> </tr> </table>
///    
alias PIBIO_STORAGE_NEXT_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework or by an engine adapter to retrieve the contents of the current record in
///the pipeline result set.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    RecordContents = Pointer to a WINBIO_STORAGE_RECORD structure that will receive the contents of the record.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Memory could not be allocated
///    for the record. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
///    mandatory pointer argument is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DATABASE_NO_RESULTS</b></b></dt> </dl> </td> <td width="60%"> There are no records in the
///    result set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_DEVICE_STATE</b></dt> </dl> </td> <td
///    width="60%"> The <b>StorageContext</b> member of the pipeline object is <b>NULL</b> or the <b>FileHandle</b>
///    member is not valid. </td> </tr> </table>
///    
alias PIBIO_STORAGE_GET_CURRENT_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                             WINBIO_STORAGE_RECORD* RecordContents);
///Called by the Windows Biometric Framework to perform a vendor-defined control operation that does not require
///elevated privilege. Call the StorageAdapterControlUnitPrivileged function to perform a vendor-defined control
///operation that requires elevated privilege.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    ControlCode = A <b>ULONG</b> value that specifies the vendor-defined operation to perform.
///    SendBuffer = Pointer to a buffer that contains the control information sent to the storage adapter. The format and content of
///                 the buffer is vendor-defined.
///    SendBufferSize = Size, in bytes, of the buffer specified by the <i>SendBuffer</i> parameter.
///    ReceiveBuffer = Pointer to the buffer that receives information sent by the storage adapter in response to the control operation.
///                    The format of the buffer is vendor-defined.
///    ReceiveBufferSize = Size, in bytes, of the buffer specified by the <i>ReceiveBuffer</i> parameter.
///    ReceiveDataSize = Pointer to a variable that receives the size, in bytes, of the data written to the buffer specified by the
///                      <i>ReceiveBuffer</i> parameter.
///    OperationStatus = Pointer to a variable that receives a vendor-defined status code that specifies the outcome of the control
///                      operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b> E_INVALIDARG</b></b></dt> </dl> </td> <td
///    width="60%"> The size or format of the buffer specified by the <i>SendBuffer</i> parameter is not correct, or the
///    value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_NOT_SUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer specified by
///    the <i>ReceiveBuffer</i> parameter is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_CANCELED</b></dt> </dl> </td> <td width="60%"> The operation was canceled. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_FAILURE</b></dt> </dl> </td> <td width="60%"> There was a hardware
///    failure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_INVALID_CONTROL_CODE</b></b></dt> </dl> </td>
///    <td width="60%"> The value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. <div
///    class="alert"><b>Note</b> Beginning with Windows 8, use only <b>E_INVALIDARG</b> to signal this condition.</div>
///    <div> </div> </td> </tr> </table>
///    
alias PIBIO_STORAGE_CONTROL_UNIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                       char* SendBuffer, size_t SendBufferSize, char* ReceiveBuffer, 
                                                       size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                       uint* OperationStatus);
///Called by the Windows Biometric Framework to perform a vendor-defined control operation that requires elevated
///privilege. Call the StorageAdapterControlUnit function to perform a vendor-defined control operation that does not
///require elevated privilege.
///Params:
///    Pipeline = A pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    ControlCode = A <b>ULONG</b> value that specifies the vendor-defined operation to perform.
///    SendBuffer = A pointer to a buffer that contains the control information sent to the storage adapter. The format and content
///                 of the buffer is vendor defined.
///    SendBufferSize = The size, in bytes, of the buffer specified by the <i>SendBuffer</i> parameter.
///    ReceiveBuffer = A pointer to a buffer that receives information returned by the storage adapter in response to the control
///                    operation. The format of the buffer is vendor defined.
///    ReceiveBufferSize = The size, in bytes, of the buffer specified by the <i>ReceiveBuffer</i> parameter.
///    ReceiveDataSize = A pointer to a variable that receives the size, in bytes, of the data written to the buffer specified by the
///                      <i>ReceiveBuffer</i> parameter.
///    OperationStatus = A pointer to a variable that receives a vendor-defined status code that specifies the outcome of the control
///                      operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A mandatory pointer argument is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b> E_INVALIDARG</b></b></dt> </dl> </td> <td
///    width="60%"> The size or format of the buffer specified by the <i>SendBuffer</i> parameter is not correct, or the
///    value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_NOT_SUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer specified by
///    the <i>ReceiveBuffer</i> parameter is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_CANCELED</b></dt> </dl> </td> <td width="60%"> The operation was canceled. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_DEVICE_FAILURE</b></dt> </dl> </td> <td width="60%"> There was a hardware
///    failure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_INVALID_CONTROL_CODE</b></b></dt> </dl> </td>
///    <td width="60%"> The value specified in the <i>ControlCode</i> parameter is not recognized by the adapter. <div
///    class="alert"><b>Note</b> Beginning with Windows 8, use only <b>E_INVALIDARG</b> to signal this condition.</div>
///    <div> </div> </td> </tr> </table>
///    
alias PIBIO_STORAGE_CONTROL_UNIT_PRIVILEGED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                                  char* SendBuffer, size_t SendBufferSize, 
                                                                  char* ReceiveBuffer, size_t ReceiveBufferSize, 
                                                                  size_t* ReceiveDataSize, uint* OperationStatus);
///Called by the Windows Biometric Framework when the system is ready to enter a low-power state or when the system has
///been awakened from a low-power state. The purpose of this function is to enable the adapter to respond to transitions
///in the computer power state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    PowerEventType = Indicates the nature of the change. It can be one of the following values: <table> <tr> <th>Value</th>
///                     <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PBT_APMSUSPEND"></a><a id="pbt_apmsuspend"></a><dl>
///                     <dt><b>PBT_APMSUSPEND</b></dt> </dl> </td> <td width="60%"> The system is entering a low-power state </td> </tr>
///                     <tr> <td width="40%"><a id="PBT_APMRESUMEAUTOMATIC"></a><a id="pbt_apmresumeautomatic"></a><dl>
///                     <dt><b>PBT_APMRESUMEAUTOMATIC</b></dt> </dl> </td> <td width="60%"> The system is returning from a low-power
///                     state. </td> </tr> <tr> <td width="40%"><a id="PBT_APMPOWERSTATUSCHANGE"></a><a
///                     id="pbt_apmpowerstatuschange"></a><dl> <dt><b>PBT_APMPOWERSTATUSCHANGE</b></dt> </dl> </td> <td width="60%"> The
///                     status of the system's power source is changing (e.g., the system has switched from battery to line power, or the
///                     battery is getting low). </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> argument was
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
///    <i>PowerEventType</i> argument was not one of the values listed in the table. </td> </tr> </table>
///    
alias PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
///Called by the Windows Biometric Framework to give the Storage Adapter the chance to perform any initialization that
///remains incomplete.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_some_error </b></dt> </dl> </td> <td width="60%"> Any error code will cause the
///    Biometric Service to log the error and abort the configuration of the biometric unit. </td> </tr> </table>
///    
alias PIBIO_STORAGE_PIPELINE_INIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to give the Storage Adapter the chance to perform any cleanup in
///preparation for closing the template database.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_STORAGE_PIPELINE_CLEANUP_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to give the Storage Adapter the chance to perform any work needed to bring
///the storage component out of an idle state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_STORAGE_ACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to give the Storage Adapter the chance to perform any work needed to put
///the storage component into an idle state.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> parameter cannot
///    be <b>NULL</b>. </td> </tr> </table>
///    
alias PIBIO_STORAGE_DEACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
///Called by the Windows Biometric Framework to determine the capabilities and limitations of the biometric storage
///component.
///Params:
///    Pipeline = Pointer to the WINBIO_PIPELINE structure associated with the biometric unit performing the operation.
///    StorageInfo = Pointer to the WINBIO_EXTENDED_STORAGE_INFO structure that contains the storage information returned by this
///                  function.
///    StorageInfoSize = The specified size of the storage information.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it must return one of the following
///    <b>HRESULT</b> values to indicate the error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>Pipeline</i> and
///    <i>StorageInfo</i> parameters cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG
///    </b></dt> </dl> </td> <td width="60%"> The <i>StorageInfoSize</i> value is less than the size needed to return
///    the storage information. </td> </tr> </table>
///    
alias PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* StorageInfo, 
                                                              size_t StorageInfoSize);
alias PIBIO_STORAGE_NOTIFY_DATABASE_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte RecordsAdded);
alias PIBIO_STORAGE_RESERVED_1_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                     ulong* Reserved1, ulong* Reserved2);
alias PIBIO_STORAGE_RESERVED_2_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity);
alias PIBIO_STORAGE_UPDATE_RECORD_BEGIN_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                              ubyte SubFactor, WINBIO_STORAGE_RECORD* RecordContents);
alias PIBIO_STORAGE_UPDATE_RECORD_COMMIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                               WINBIO_STORAGE_RECORD* RecordContents);
alias PWINBIO_QUERY_STORAGE_INTERFACE_FN = HRESULT function(WINBIO_STORAGE_INTERFACE** StorageInterface);
alias PIBIO_FRAMEWORK_SET_UNIT_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* ExtendedStatus, 
                                                            size_t ExtendedStatusSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_CLEAR_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_BEGIN_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   size_t RequiredCapacity, size_t* MaxBufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_NEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* BufferAddress, 
                                                                  size_t BufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_END_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_BEGIN_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   size_t* RequiredCapacity, size_t* MaxBufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_NEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* BufferAddress, 
                                                                  size_t BufferSize, size_t* ReturnedDataSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_END_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_1_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t Reserved1, 
                                                                   size_t* Reserved2);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_2_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte* Reserved1, 
                                                                   size_t Reserved2);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_3_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_ALLOCATE_MEMORY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t AllocationSize, 
                                                            void** Address);
alias PIBIO_FRAMEWORK_FREE_MEMORY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, void* Address);
alias PIBIO_FRAMEWORK_GET_PROPERTY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PropertyType, 
                                                         uint PropertyId, WINBIO_IDENTITY* Identity, ubyte SubFactor, 
                                                         void** PropertyBuffer, size_t* PropertyBufferSize);
alias PIBIO_FRAMEWORK_LOCK_AND_VALIDATE_SECURE_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                            GUID SecureBufferIdentifier, 
                                                                            void** SecureBufferAddress, 
                                                                            size_t* SecureBufferSize);
alias PIBIO_FRAMEWORK_RELEASE_SECURE_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                  GUID SecureBufferIdentifier);
alias PIBIO_FRAMEWORK_VSM_QUERY_AUTHORIZED_ENROLLMENTS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                             WINBIO_IDENTITY* Identity, 
                                                                             size_t* SecureIdentityCount, 
                                                                             WINBIO_IDENTITY** SecureIdentities);
alias PIBIO_FRAMEWORK_VSM_DECRYPT_SAMPLE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* Authentication, 
                                                               size_t AuthenticationSize, char* Iv, size_t IvSize, 
                                                               char* EncryptedData, size_t EncryptedDataSize);

// Structs


struct WINBIO_VERSION
{
    uint MajorVersion;
    uint MinorVersion;
}

struct WINBIO_IDENTITY
{
    uint Type;
    union Value
    {
        uint      Null;
        uint      Wildcard;
        GUID      TemplateGuid;
        struct AccountSid
        {
            uint      Size;
            ubyte[68] Data;
        }
        ubyte[32] SecureId;
    }
}

struct WINBIO_SECURE_CONNECTION_PARAMS
{
    uint   PayloadSize;
    ushort Version;
    ushort Flags;
}

struct WINBIO_SECURE_CONNECTION_DATA
{
    uint   Size;
    ushort Version;
    ushort Flags;
    uint   ModelCertificateSize;
    uint   IntermediateCA1Size;
    uint   IntermediateCA2Size;
}

struct WINBIO_BIR_DATA
{
    uint Size;
    uint Offset;
}

struct WINBIO_BIR
{
    WINBIO_BIR_DATA HeaderBlock;
    WINBIO_BIR_DATA StandardDataBlock;
    WINBIO_BIR_DATA VendorDataBlock;
    WINBIO_BIR_DATA SignatureBlock;
}

struct WINBIO_REGISTERED_FORMAT
{
    ushort Owner;
    ushort Type;
}

struct WINBIO_BIR_HEADER
{
    ushort        ValidFields;
    ubyte         HeaderVersion;
    ubyte         PatronHeaderVersion;
    ubyte         DataFlags;
    uint          Type;
    ubyte         Subtype;
    ubyte         Purpose;
    byte          DataQuality;
    LARGE_INTEGER CreationDate;
    struct ValidityPeriod
    {
        LARGE_INTEGER BeginDate;
        LARGE_INTEGER EndDate;
    }
    WINBIO_REGISTERED_FORMAT BiometricDataFormat;
    WINBIO_REGISTERED_FORMAT ProductId;
}

struct WINBIO_BDB_ANSI_381_HEADER
{
    ulong  RecordLength;
    uint   FormatIdentifier;
    uint   VersionNumber;
    WINBIO_REGISTERED_FORMAT ProductId;
    ushort CaptureDeviceId;
    ushort ImageAcquisitionLevel;
    ushort HorizontalScanResolution;
    ushort VerticalScanResolution;
    ushort HorizontalImageResolution;
    ushort VerticalImageResolution;
    ubyte  ElementCount;
    ubyte  ScaleUnits;
    ubyte  PixelDepth;
    ubyte  ImageCompressionAlg;
    ushort Reserved;
}

struct WINBIO_BDB_ANSI_381_RECORD
{
    uint   BlockLength;
    ushort HorizontalLineLength;
    ushort VerticalLineLength;
    ubyte  Position;
    ubyte  CountOfViews;
    ubyte  ViewNumber;
    ubyte  ImageQuality;
    ubyte  ImpressionType;
    ubyte  Reserved;
}

struct WINBIO_SECURE_BUFFER_HEADER_V1
{
    uint  Type;
    uint  Size;
    uint  Flags;
    ulong ValidationTag;
}

struct WINBIO_EVENT
{
    uint Type;
    union Parameters
    {
        struct Unclaimed
        {
            uint UnitId;
            uint RejectDetail;
        }
        struct UnclaimedIdentify
        {
            uint            UnitId;
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            uint            RejectDetail;
        }
        struct Error
        {
            HRESULT ErrorCode;
        }
    }
}

union WINBIO_PRESENCE_PROPERTIES
{
    struct FacialFeatures
    {
        RECT BoundingBox;
        int  Distance;
        struct OpaqueEngineData
        {
            GUID     AdapterId;
            uint[77] Data;
        }
    }
    struct Iris
    {
        RECT  EyeBoundingBox_1;
        RECT  EyeBoundingBox_2;
        POINT PupilCenter_1;
        POINT PupilCenter_2;
        int   Distance;
    }
}

struct WINBIO_PRESENCE
{
    uint            Factor;
    ubyte           SubFactor;
    HRESULT         Status;
    uint            RejectDetail;
    WINBIO_IDENTITY Identity;
    ulong           TrackingId;
    ulong           Ticket;
    WINBIO_PRESENCE_PROPERTIES Properties;
    struct Authorization
    {
        uint      Size;
        ubyte[32] Data;
    }
}

struct WINBIO_BSP_SCHEMA
{
    uint           BiometricFactor;
    GUID           BspId;
    ushort[256]    Description;
    ushort[256]    Vendor;
    WINBIO_VERSION Version;
}

struct WINBIO_UNIT_SCHEMA
{
    uint           UnitId;
    uint           PoolType;
    uint           BiometricFactor;
    uint           SensorSubType;
    uint           Capabilities;
    ushort[256]    DeviceInstanceId;
    ushort[256]    Description;
    ushort[256]    Manufacturer;
    ushort[256]    Model;
    ushort[256]    SerialNumber;
    WINBIO_VERSION FirmwareVersion;
}

struct WINBIO_STORAGE_SCHEMA
{
    uint        BiometricFactor;
    GUID        DatabaseId;
    GUID        DataFormat;
    uint        Attributes;
    ushort[256] FilePath;
    ushort[256] ConnectionString;
}

struct WINBIO_EXTENDED_SENSOR_INFO
{
    uint GenericSensorCapabilities;
    uint Factor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            RECT  FrameSize;
            POINT FrameOffset;
            uint  MandatoryOrientation;
            struct HardwareInfo
            {
                ushort[260] ColorSensorId;
                ushort[260] InfraredSensorId;
                uint        InfraredSensorRotationAngle;
            }
        }
        struct Fingerprint
        {
            uint Reserved;
        }
        struct Iris
        {
            RECT  FrameSize;
            POINT FrameOffset;
            uint  MandatoryOrientation;
        }
        struct Voice
        {
            uint Reserved;
        }
    }
}

struct WINBIO_EXTENDED_ENGINE_INFO
{
    uint GenericEngineCapabilities;
    uint Factor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint Null;
            }
        }
        struct Fingerprint
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint GeneralSamples;
                uint Center;
                uint TopEdge;
                uint BottomEdge;
                uint LeftEdge;
                uint RightEdge;
            }
        }
        struct Iris
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint Null;
            }
        }
        struct Voice
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint Null;
            }
        }
    }
}

struct WINBIO_EXTENDED_STORAGE_INFO
{
    uint GenericStorageCapabilities;
    uint Factor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            uint Capabilities;
        }
        struct Fingerprint
        {
            uint Capabilities;
        }
        struct Iris
        {
            uint Capabilities;
        }
        struct Voice
        {
            uint Capabilities;
        }
    }
}

struct WINBIO_EXTENDED_ENROLLMENT_STATUS
{
    HRESULT TemplateStatus;
    uint    RejectDetail;
    uint    PercentComplete;
    uint    Factor;
    ubyte   SubFactor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            RECT BoundingBox;
            int  Distance;
            struct OpaqueEngineData
            {
                GUID     AdapterId;
                uint[77] Data;
            }
        }
        struct Fingerprint
        {
            uint GeneralSamples;
            uint Center;
            uint TopEdge;
            uint BottomEdge;
            uint LeftEdge;
            uint RightEdge;
        }
        struct Iris
        {
            RECT   EyeBoundingBox_1;
            RECT   EyeBoundingBox_2;
            POINT  PupilCenter_1;
            POINT  PupilCenter_2;
            int    Distance;
            uint   GridPointCompletionPercent;
            ushort GridPointIndex;
            struct Point3D
            {
                double X;
                double Y;
                double Z;
            }
            BOOL   StopCaptureAndShowCriticalFeedback;
        }
        struct Voice
        {
            uint Reserved;
        }
    }
}

struct WINBIO_EXTENDED_UNIT_STATUS
{
    uint Availability;
    uint ReasonCode;
}

struct WINBIO_FP_BU_STATE
{
    BOOL    SensorAttached;
    HRESULT CreationResult;
}

struct WINBIO_ANTI_SPOOF_POLICY
{
    WINBIO_ANTI_SPOOF_POLICY_ACTION Action;
    WINBIO_POLICY_SOURCE Source;
}

struct WINBIO_EXTENDED_ENROLLMENT_PARAMETERS
{
    size_t Size;
    ubyte  SubFactor;
}

struct WINBIO_ACCOUNT_POLICY
{
    WINBIO_IDENTITY Identity;
    WINBIO_ANTI_SPOOF_POLICY_ACTION AntiSpoofBehavior;
}

struct WINBIO_PROTECTION_POLICY
{
    uint            Version;
    WINBIO_IDENTITY Identity;
    GUID            DatabaseId;
    ulong           UserState;
    size_t          PolicySize;
    ubyte[128]      Policy;
}

struct WINBIO_GESTURE_METADATA
{
    size_t Size;
    uint   BiometricType;
    uint   MatchType;
    uint   ProtectionType;
}

///The <b>WINBIO_ASYNC_RESULT</b> structure contains the results of an asynchronous operation.
struct WINBIO_ASYNC_RESULT
{
    ///Handle of an asynchronous session started by calling the WinBioAsyncOpenSession function or the
    ///WinBioAsyncOpenFramework function.
    uint    SessionHandle;
    ///Type of the asynchronous operation. For more information, see WINBIO_OPERATION_TYPE Constants.
    uint    Operation;
    ///Sequence number of the asynchronous operation. The integers are assigned sequentially for each operation in a
    ///biometric session, starting at one (1). For any session, the open operation is always assigned the first sequence
    ///number and the close operation is assigned the last sequence number. If your application queues multiple
    ///operations, you can use sequence numbers to perform error handling. For example, you can ignore operation results
    ///until a specific sequence number is sent to the application.
    ulong   SequenceNumber;
    ///System date and time at which the biometric operation began. For more information, see the
    ///<b>GetSystemTimeAsFileTime</b> function.
    long    TimeStamp;
    ///Error code returned by the operation.
    HRESULT ApiStatus;
    ///The numeric unit identifier of the biometric unit that performed the operation.
    uint    UnitId;
    ///Address of an optional buffer supplied by the caller. The buffer is not modified by the framework or the
    ///biometric unit. Your application can use the data to help it determine what actions to perform upon receipt of
    ///the completion notice or to maintain additional information about the requested operation.
    void*   UserData;
    union Parameters
    {
        struct Verify
        {
            ubyte Match;
            uint  RejectDetail;
        }
        struct Identify
        {
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            uint            RejectDetail;
        }
        struct EnrollBegin
        {
            ubyte SubFactor;
        }
        struct EnrollCapture
        {
            uint RejectDetail;
        }
        struct EnrollCommit
        {
            WINBIO_IDENTITY Identity;
            ubyte           IsNewTemplate;
        }
        struct EnumEnrollments
        {
            WINBIO_IDENTITY Identity;
            size_t          SubFactorCount;
            ubyte*          SubFactorArray;
        }
        struct CaptureSample
        {
            WINBIO_BIR* Sample;
            size_t      SampleSize;
            uint        RejectDetail;
        }
        struct DeleteTemplate
        {
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
        }
        struct GetProperty
        {
            uint            PropertyType;
            uint            PropertyId;
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            size_t          PropertyBufferSize;
            void*           PropertyBuffer;
        }
        struct SetProperty
        {
            uint            PropertyType;
            uint            PropertyId;
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            size_t          PropertyBufferSize;
            void*           PropertyBuffer;
        }
        struct GetEvent
        {
            WINBIO_EVENT Event;
        }
        struct ControlUnit
        {
            uint   Component;
            uint   ControlCode;
            uint   OperationStatus;
            ubyte* SendBuffer;
            size_t SendBufferSize;
            ubyte* ReceiveBuffer;
            size_t ReceiveBufferSize;
            size_t ReceiveDataSize;
        }
        struct EnumServiceProviders
        {
            size_t             BspCount;
            WINBIO_BSP_SCHEMA* BspSchemaArray;
        }
        struct EnumBiometricUnits
        {
            size_t              UnitCount;
            WINBIO_UNIT_SCHEMA* UnitSchemaArray;
        }
        struct EnumDatabases
        {
            size_t StorageCount;
            WINBIO_STORAGE_SCHEMA* StorageSchemaArray;
        }
        struct VerifyAndReleaseTicket
        {
            ubyte Match;
            uint  RejectDetail;
            ulong Ticket;
        }
        struct IdentifyAndReleaseTicket
        {
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            uint            RejectDetail;
            ulong           Ticket;
        }
        struct EnrollSelect
        {
            ulong SelectorValue;
        }
        struct MonitorPresence
        {
            uint             ChangeType;
            size_t           PresenceCount;
            WINBIO_PRESENCE* PresenceArray;
        }
        struct GetProtectionPolicy
        {
            WINBIO_IDENTITY Identity;
            WINBIO_PROTECTION_POLICY Policy;
        }
        struct NotifyUnitStatusChange
        {
            WINBIO_EXTENDED_UNIT_STATUS ExtendedStatus;
        }
    }
}

struct _WINIBIO_SENSOR_CONTEXT
{
}

struct _WINIBIO_ENGINE_CONTEXT
{
}

struct _WINIBIO_STORAGE_CONTEXT
{
}

///The <b>WINBIO_STORAGE_RECORD</b> structure contains a biometric template and associated data in a standard format.
///This structure is used to pass information between an engine adapter and a storage adapter.
struct WINBIO_STORAGE_RECORD
{
    ///Pointer to a WINBIO_IDENTITY structure that contains the GUID or SID of the storage record.
    WINBIO_IDENTITY* Identity;
    ///A WINBIO_BIOMETRIC_SUBTYPE value that specifies the biometric sub-factor associated with the template data. <div
    ///class="alert"><b>Important</b> <p class="note">Do not attempt to validate the value supplied for the
    ///<i>SubFactor</i> value. The Windows Biometrics Service will validate the supplied value before passing it through
    ///to your implementation. If the value is <b>WINBIO_SUBTYPE_NO_INFORMATION</b> or <b>WINBIO_SUBTYPE_ANY</b>, then
    ///validate where appropriate. </div> <div> </div>
    ubyte            SubFactor;
    ///Pointer to a contiguous array of <b>ULONG</b> values. These values represent the bucket address assigned to the
    ///biometric template by the engine adapter.
    uint*            IndexVector;
    ///The number of <b>ULONG</b> values in the array specified by the <i>IndexVector</i> field.
    size_t           IndexElementCount;
    ///Pointer to an array of bytes that contains the biometric template data.
    ubyte*           TemplateBlob;
    ///Size, in bytes, of the template specified by the <i>TemplateBlob</i> parameter.
    size_t           TemplateBlobSize;
    ///Pointer to an array of bytes that contains integrity checking data. This field is used only by adapters for
    ///removable devices that contain embedded storage.
    ubyte*           PayloadBlob;
    ///Size, in bytes, of the data specified by the <i>PayloadBlob</i> parameter.
    size_t           PayloadBlobSize;
}

///The <b>WINBIO_PIPELINE</b> structure contains shared context information used by the sensor, engine, and storage
///adapter components in a single biometric unit.
struct WINBIO_PIPELINE
{
    ///File handle to the sensor device associated with the biometric unit. Adapters should treat this as a read-only
    ///field.
    HANDLE SensorHandle;
    ///File handle to the dedicated hardware matching engine, if one is present. This is modified only by the engine
    ///adapter. It is read by the Windows Biometric Framework.
    HANDLE EngineHandle;
    ///File handle to the template storage database. This is read by the Windows Biometric Framework, but it is modified
    ///only by the storage adapter.
    HANDLE StorageHandle;
    ///Pointer to the WINBIO_SENSOR_INTERFACE structure for the biometric unit. Adapters should ignore this field.
    WINBIO_SENSOR_INTERFACE* SensorInterface;
    ///Pointer to the WINBIO_ENGINE_INTERFACE structure for the biometric unit. Adapters should ignore this field.
    WINBIO_ENGINE_INTERFACE* EngineInterface;
    ///Pointer to the WINBIO_STORAGE_INTERFACE structure for the biometric unit. Adapters should ignore this field.
    WINBIO_STORAGE_INTERFACE* StorageInterface;
    ///Pointer to a private data structure defined by the sensor adapter. This pointer and the structure contents are
    ///managed by the sensor adapter and are never accessed by the Windows Biometric Framework.
    _WINIBIO_SENSOR_CONTEXT* SensorContext;
    ///Pointer to a private data structure defined by the engine adapter. This pointer and the structure contents are
    ///managed by the engine adapter and are never accessed by the Windows Biometric Framework.
    _WINIBIO_ENGINE_CONTEXT* EngineContext;
    ///Pointer to a private data structure defined by the storage adapter. This pointer and the structure contents are
    ///managed by the storage adapter and are never accessed by the Windows Biometric Framework.
    _WINIBIO_STORAGE_CONTEXT* StorageContext;
    WINBIO_FRAMEWORK_INTERFACE* FrameworkInterface;
}

///The <b>WINBIO_ADAPTER_INTERFACE_VERSION</b> structure contains a major and minor version number used in the engine,
///sensor, and storage adapter interface tables.
struct WINBIO_ADAPTER_INTERFACE_VERSION
{
    ///Contains the major version number.
    ushort MajorVersion;
    ///Contains the minor version number.
    ushort MinorVersion;
}

///The <b>WINBIO_SENSOR_INTERFACE</b> structure contains pointers to your custom sensor adapter functions. The Windows
///Biometric Framework uses this structure to locate the functions.
struct WINBIO_SENSOR_INTERFACE
{
    ///Version number of this structure. <b>Windows 10: </b>The version number must be
    ///<b>WINBIO_SENSOR_INTERFACE_VERSION_3</b>. <b>Windows Server 2012 R2, Windows 8.1, Windows Server 2012 and Windows
    ///8: </b>The version number must be <b>WINBIO_SENSOR_INTERFACE_VERSION_2</b>. <b>Windows Server 2008 R2 and Windows
    ///7: </b>The version number must be <b>WINBIO_SENSOR_INTERFACE_VERSION_1</b>.
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    ///The type of adapter. This must be <b>WINBIO_ADAPTER_TYPE_SENSOR</b>.
    uint   Type;
    ///The size, in bytes, of this structure. Set this value to the size of the <b>WINBIO_SENSOR_INTERFACE</b>
    ///structure.
    size_t Size;
    ///A GUID that uniquely identifies the sensor adapter. You must generate this value.
    GUID   AdapterId;
    ///A pointer to your implementation of the SensorAdapterAttach function.
    PIBIO_SENSOR_ATTACH_FN Attach;
    ///A pointer to your implementation of the SensorAdapterDetach function.
    PIBIO_SENSOR_DETACH_FN Detach;
    ///A pointer to your implementation of the SensorAdapterClearContext function.
    PIBIO_SENSOR_CLEAR_CONTEXT_FN ClearContext;
    ///A pointer to your implementation of the SensorAdapterQueryStatus function.
    PIBIO_SENSOR_QUERY_STATUS_FN QueryStatus;
    ///A pointer to your implementation of the SensorAdapterReset function.
    PIBIO_SENSOR_RESET_FN Reset;
    ///A pointer to your implementation of the SensorAdapterSetMode function.
    PIBIO_SENSOR_SET_MODE_FN SetMode;
    ///A pointer to your implementation of the SensorAdapterSetIndicatorStatus function.
    PIBIO_SENSOR_SET_INDICATOR_STATUS_FN SetIndicatorStatus;
    ///A pointer to your implementation of the SensorAdapterGetIndicatorStatus function.
    PIBIO_SENSOR_GET_INDICATOR_STATUS_FN GetIndicatorStatus;
    ///A pointer to your implementation of the SensorAdapterStartCapture function.
    PIBIO_SENSOR_START_CAPTURE_FN StartCapture;
    ///A pointer to your implementation of the SensorAdapterFinishCapture function.
    PIBIO_SENSOR_FINISH_CAPTURE_FN FinishCapture;
    ///A pointer to your implementation of the SensorAdapterExportSensorData function.
    PIBIO_SENSOR_EXPORT_SENSOR_DATA_FN ExportSensorData;
    ///A pointer to your implementation of the SensorAdapterCancel function.
    PIBIO_SENSOR_CANCEL_FN Cancel;
    ///A pointer to your implementation of the SensorAdapterPushDataToEngine function.
    PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN PushDataToEngine;
    ///A pointer to your implementation of the SensorAdapterControlUnit function.
    PIBIO_SENSOR_CONTROL_UNIT_FN ControlUnit;
    ///A pointer to your implementation of the SensorAdapterControlUnitPrivileged function.
    PIBIO_SENSOR_CONTROL_UNIT_PRIVILEGED_FN ControlUnitPrivileged;
    ///A pointer to your implementation of the SensorAdapterNotifyPowerChange function. This member is supported
    ///starting in Windows 8.
    PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN NotifyPowerChange;
    ///A pointer to your implementation of the SensorAdapterPipelineInit function. This member is supported starting in
    ///Windows 10.
    PIBIO_SENSOR_PIPELINE_INIT_FN PipelineInit;
    ///A pointer to your implementation of the SensorAdapterPipelineCleanup function. This member is supported starting
    ///in Windows 10.
    PIBIO_SENSOR_PIPELINE_CLEANUP_FN PipelineCleanup;
    ///A pointer to your implementation of the SensorAdapterActivate function. This member is supported starting in
    ///Windows 10.
    PIBIO_SENSOR_ACTIVATE_FN Activate;
    ///A pointer to your implementation of the SensorAdapterDeactivate function. This member is supported starting in
    ///Windows 10.
    PIBIO_SENSOR_DEACTIVATE_FN Deactivate;
    ///A pointer to your implementation of the SensorAdapterQueryExtendedInfo function. This member is supported
    ///starting in Windows 10.
    PIBIO_SENSOR_QUERY_EXTENDED_INFO_FN QueryExtendedInfo;
    ///A pointer to your implementation of the SensorAdapterQueryCalibrationFormats function. This member is supported
    ///starting in Windows 10.
    PIBIO_SENSOR_QUERY_CALIBRATION_FORMATS_FN QueryCalibrationFormats;
    ///A pointer to your implementation of the SensorAdapterSetCalibrationFormat function. This member is supported
    ///starting in Windows 10.
    PIBIO_SENSOR_SET_CALIBRATION_FORMAT_FN SetCalibrationFormat;
    ///A pointer to your implementation of the SensorAdapterAcceptCalibrationData function. This member is supported
    ///starting in Windows 10.
    PIBIO_SENSOR_ACCEPT_CALIBRATION_DATA_FN AcceptCalibrationData;
    PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN AsyncImportRawBuffer;
    PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN AsyncImportSecureBuffer;
    PIBIO_SENSOR_QUERY_PRIVATE_SENSOR_TYPE_FN QueryPrivateSensorType;
    PIBIO_SENSOR_CONNECT_SECURE_FN ConnectSecure;
    PIBIO_SENSOR_START_CAPTURE_EX_FN StartCaptureEx;
    PIBIO_SENSOR_START_NOTIFY_WAKE_FN StartNotifyWake;
    PIBIO_SENSOR_FINISH_NOTIFY_WAKE_FN FinishNotifyWake;
}

///The <b>WINBIO_ENGINE_INTERFACE</b> structure contains pointers to your custom engine adapter functions. The Windows
///Biometric Framework uses this structure to locate the functions.
struct WINBIO_ENGINE_INTERFACE
{
    ///Version number of this structure. <b>Windows 10: </b>The version number must be
    ///<b>WINBIO_ENGINE_INTERFACE_VERSION_3</b> or <b>WINBIO_ENGINE_INTERFACE_VERSION_4</b>. For more information on
    ///implementing <b>WINBIO_ENGINE_INTERFACE_VERSION_4</b>, see Sensor requirements for secure biometrics. <b>Windows
    ///Server 2012 R2, Windows 8.1, Windows Server 2012 and Windows 8: </b>The version number must be
    ///<b>WINBIO_ENGINE_INTERFACE_VERSION_2</b>. <b>Windows Server 2008 R2 and Windows 7: </b>The version number must be
    ///<b>WINBIO_ENGINE_INTERFACE_VERSION_1</b>.
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    ///The type of adapter. This must be <b>WINBIO_ADAPTER_TYPE_ENGINE</b>.
    uint   Type;
    ///The size, in bytes, of this structure. Set this value to the size of the <b>WINBIO_ENGINE_INTERFACE</b>
    ///structure.
    size_t Size;
    ///A GUID that uniquely identifies the engine adapter. You must generate this value.
    GUID   AdapterId;
    ///A pointer to your implementation of the EngineAdapterAttach function.
    PIBIO_ENGINE_ATTACH_FN Attach;
    ///A pointer to your implementation of the EngineAdapterDetach function.
    PIBIO_ENGINE_DETACH_FN Detach;
    ///A pointer to your implementation of the EngineAdapterClearContext function.
    PIBIO_ENGINE_CLEAR_CONTEXT_FN ClearContext;
    ///A pointer to your implementation of the EngineAdapterQueryPreferredFormat function.
    PIBIO_ENGINE_QUERY_PREFERRED_FORMAT_FN QueryPreferredFormat;
    ///A pointer to your implementation of the EngineAdapterQueryIndexVectorSize function.
    PIBIO_ENGINE_QUERY_INDEX_VECTOR_SIZE_FN QueryIndexVectorSize;
    ///A pointer to your implementation of the EngineAdapterQueryHashAlgorithms function.
    PIBIO_ENGINE_QUERY_HASH_ALGORITHMS_FN QueryHashAlgorithms;
    ///A pointer to your implementation of the EngineAdapterSetHashAlgorithm function.
    PIBIO_ENGINE_SET_HASH_ALGORITHM_FN SetHashAlgorithm;
    ///A pointer to your implementation of the EngineAdapterQuerySampleHint function.
    PIBIO_ENGINE_QUERY_SAMPLE_HINT_FN QuerySampleHint;
    ///A pointer to your implementation of the EngineAdapterAcceptSampleData function.
    PIBIO_ENGINE_ACCEPT_SAMPLE_DATA_FN AcceptSampleData;
    ///A pointer to your implementation of the EngineAdapterExportEngineData function.
    PIBIO_ENGINE_EXPORT_ENGINE_DATA_FN ExportEngineData;
    ///A pointer to your implementation of the EngineAdapterVerifyFeatureSet function.
    PIBIO_ENGINE_VERIFY_FEATURE_SET_FN VerifyFeatureSet;
    ///A pointer to your implementation of the EngineAdapterIdentifyFeatureSet function.
    PIBIO_ENGINE_IDENTIFY_FEATURE_SET_FN IdentifyFeatureSet;
    ///A pointer to your implementation of the EngineAdapterCreateEnrollment function.
    PIBIO_ENGINE_CREATE_ENROLLMENT_FN CreateEnrollment;
    ///A pointer to your implementation of the EngineAdapterUpdateEnrollment function.
    PIBIO_ENGINE_UPDATE_ENROLLMENT_FN UpdateEnrollment;
    ///A pointer to your implementation of the EngineAdapterGetEnrollmentStatus function.
    PIBIO_ENGINE_GET_ENROLLMENT_STATUS_FN GetEnrollmentStatus;
    ///A pointer to your implementation of the EngineAdapterGetEnrollmentHash function.
    PIBIO_ENGINE_GET_ENROLLMENT_HASH_FN GetEnrollmentHash;
    ///A pointer to your implementation of the EngineAdapterCheckForDuplicate function.
    PIBIO_ENGINE_CHECK_FOR_DUPLICATE_FN CheckForDuplicate;
    ///A pointer to your implementation of the EngineAdapterCommitEnrollment function.
    PIBIO_ENGINE_COMMIT_ENROLLMENT_FN CommitEnrollment;
    ///A pointer to your implementation of the EngineAdapterDiscardEnrollment function.
    PIBIO_ENGINE_DISCARD_ENROLLMENT_FN DiscardEnrollment;
    ///A pointer to your implementation of the EngineAdapterControlUnit function.
    PIBIO_ENGINE_CONTROL_UNIT_FN ControlUnit;
    ///A pointer to your implementation of the EngineAdapterControlUnitPrivileged function.
    PIBIO_ENGINE_CONTROL_UNIT_PRIVILEGED_FN ControlUnitPrivileged;
    ///A pointer to your implementation of the EngineAdapterNotifyPowerChange function. This member is supported
    ///starting in Windows 8.
    PIBIO_ENGINE_NOTIFY_POWER_CHANGE_FN NotifyPowerChange;
    ///This field is reserved and should be set to <b>NULL</b>.
    PIBIO_ENGINE_RESERVED_1_FN Reserved_1;
    ///A pointer to your implementation of the EngineAdapterPipelineInit function. This member is supported starting in
    ///Windows 10.
    PIBIO_ENGINE_PIPELINE_INIT_FN PipelineInit;
    ///A pointer to your implementation of the EngineAdapterPipelineCleanup function. This member is supported starting
    ///in Windows 10.
    PIBIO_ENGINE_PIPELINE_CLEANUP_FN PipelineCleanup;
    ///A pointer to your implementation of the EngineAdapterActivate function. This member is supported starting in
    ///Windows 10.
    PIBIO_ENGINE_ACTIVATE_FN Activate;
    ///A pointer to your implementation of the EngineAdapterDeactivate function. This member is supported starting in
    ///Windows 10.
    PIBIO_ENGINE_DEACTIVATE_FN Deactivate;
    ///A pointer to your implementation of the EngineAdapterQueryExtendedInfo function. This member is supported
    ///starting in Windows 10.
    PIBIO_ENGINE_QUERY_EXTENDED_INFO_FN QueryExtendedInfo;
    ///A pointer to your implementation of the EngineAdapterIdentifyAll function. This member is supported starting in
    ///Windows 10.
    PIBIO_ENGINE_IDENTIFY_ALL_FN IdentifyAll;
    ///A pointer to your implementation of the EngineAdapterSetEnrollmentSelector function. This member is supported
    ///starting in Windows 10.
    PIBIO_ENGINE_SET_ENROLLMENT_SELECTOR_FN SetEnrollmentSelector;
    ///A pointer to your implementation of the EngineAdapterSetEnrollmentParameters function. This member is supported
    ///starting in Windows 10.
    PIBIO_ENGINE_SET_ENROLLMENT_PARAMETERS_FN SetEnrollmentParameters;
    ///A pointer to your implementation of the EngineAdapterQueryExtendedEnrollmentStatus function. This member is
    ///supported starting in Windows 10.
    PIBIO_ENGINE_QUERY_EXTENDED_ENROLLMENT_STATUS_FN QueryExtendedEnrollmentStatus;
    ///A pointer to your implementation of the EngineAdapterRefreshCache function. This member is supported starting in
    ///Windows 10.
    PIBIO_ENGINE_REFRESH_CACHE_FN RefreshCache;
    ///A pointer to your implementation of the EngineAdapterSelectCalibrationFormat function. This member is supported
    ///starting in Windows 10.
    PIBIO_ENGINE_SELECT_CALIBRATION_FORMAT_FN SelectCalibrationFormat;
    ///A pointer to your implementation of the EngineAdapterQueryCalibrationData function. This member is supported
    ///starting in Windows 10.
    PIBIO_ENGINE_QUERY_CALIBRATION_DATA_FN QueryCalibrationData;
    ///A pointer to your implementation of the EngineAdapterSetAccountPolicy function. This member is supported starting
    ///in Windows 10.
    PIBIO_ENGINE_SET_ACCOUNT_POLICY_FN SetAccountPolicy;
    ///A pointer to your implementation of the EngineAdapterCreateKey function. This member is supported starting in
    ///Windows 10, version 1607.
    PIBIO_ENGINE_CREATE_KEY_FN CreateKey;
    ///A pointer to your implementation of the EngineAdapterIdentifyFeatureSetSecure function. This member is supported
    ///starting in Windows 10, version 1607.
    PIBIO_ENGINE_IDENTIFY_FEATURE_SET_SECURE_FN IdentifyFeatureSetSecure;
    PIBIO_ENGINE_ACCEPT_PRIVATE_SENSOR_TYPE_INFO_FN AcceptPrivateSensorTypeInfo;
    PIBIO_ENGINE_CREATE_ENROLLMENT_AUTHENTICATED_FN CreateEnrollmentAuthenticated;
    PIBIO_ENGINE_IDENTIFY_FEATURE_SET_AUTHENTICATED_FN IdentifyFeatureSetAuthenticated;
}

///The <b>WINBIO_STORAGE_INTERFACE</b> structure contains pointers to your custom storage adapter functions. The Windows
///Biometric Framework uses this structure to locate the functions.
struct WINBIO_STORAGE_INTERFACE
{
    ///Version number of this structure. <b>Windows 10: </b>The version number must be
    ///<b>WINBIO_STORAGE_INTERFACE_VERSION_3</b>. <b>Windows Server 2012 R2, Windows 8.1, Windows Server 2012 and
    ///Windows 8: </b>The version number must be <b>WINBIO_STORAGE_INTERFACE_VERSION_2</b>. <b>Windows Server 2008 R2
    ///and Windows 7: </b>The version number must be <b>WINBIO_STORAGE_INTERFACE_VERSION_1</b>.
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    ///The type of adapter. This must be <b>WINBIO_ADAPTER_TYPE_STORAGE</b>.
    uint   Type;
    ///The size, in bytes, of this structure. Set this value to the size of the <b>WINBIO_STORAGE_INTERFACE</b>
    ///structure.
    size_t Size;
    ///A GUID that uniquely identifies the storage adapter. You must generate this value.
    GUID   AdapterId;
    ///A pointer to your implementation of the StorageAdapterAttach function.
    PIBIO_STORAGE_ATTACH_FN Attach;
    ///A pointer to your implementation of the StorageAdapterDetach function.
    PIBIO_STORAGE_DETACH_FN Detach;
    ///A pointer to your implementation of the StorageAdapterClearContext function.
    PIBIO_STORAGE_CLEAR_CONTEXT_FN ClearContext;
    ///A pointer to your implementation of the StorageAdapterCreateDatabase function.
    PIBIO_STORAGE_CREATE_DATABASE_FN CreateDatabase;
    ///A pointer to your implementation of the StorageAdapterEraseDatabase function.
    PIBIO_STORAGE_ERASE_DATABASE_FN EraseDatabase;
    ///A pointer to your implementation of the StorageAdapterOpenDatabase function.
    PIBIO_STORAGE_OPEN_DATABASE_FN OpenDatabase;
    ///A pointer to your implementation of the StorageAdapterCloseDatabase function.
    PIBIO_STORAGE_CLOSE_DATABASE_FN CloseDatabase;
    ///A pointer to your implementation of the StorageAdapterGetDataFormat function.
    PIBIO_STORAGE_GET_DATA_FORMAT_FN GetDataFormat;
    ///A pointer to your implementation of the StorageAdapterGetDatabaseSize function.
    PIBIO_STORAGE_GET_DATABASE_SIZE_FN GetDatabaseSize;
    ///A pointer to your implementation of the StorageAdapterAddRecord function.
    PIBIO_STORAGE_ADD_RECORD_FN AddRecord;
    ///A pointer to your implementation of the StorageAdapterDeleteRecord function.
    PIBIO_STORAGE_DELETE_RECORD_FN DeleteRecord;
    ///A pointer to your implementation of the StorageAdapterQueryBySubject function.
    PIBIO_STORAGE_QUERY_BY_SUBJECT_FN QueryBySubject;
    ///A pointer to your implementation of the StorageAdapterQueryByContent function.
    PIBIO_STORAGE_QUERY_BY_CONTENT_FN QueryByContent;
    ///A pointer to your implementation of the StorageAdapterGetRecordCount function.
    PIBIO_STORAGE_GET_RECORD_COUNT_FN GetRecordCount;
    ///A pointer to your implementation of the StorageAdapterFirstRecord function.
    PIBIO_STORAGE_FIRST_RECORD_FN FirstRecord;
    ///A pointer to your implementation of the StorageAdapterNextRecord function.
    PIBIO_STORAGE_NEXT_RECORD_FN NextRecord;
    ///A pointer to your implementation of the StorageAdapterGetCurrentRecord function.
    PIBIO_STORAGE_GET_CURRENT_RECORD_FN GetCurrentRecord;
    ///A pointer to your implementation of the StorageAdapterControlUnit function.
    PIBIO_STORAGE_CONTROL_UNIT_FN ControlUnit;
    ///A pointer to your implementation of the StorageAdapterControlUnitPrivileged function.
    PIBIO_STORAGE_CONTROL_UNIT_PRIVILEGED_FN ControlUnitPrivileged;
    ///A pointer to your implementation of the StorageAdapterNotifyPowerChange function. This member is supported
    ///starting in Windows 8.
    PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN NotifyPowerChange;
    ///A pointer to your implementation of the StorageAdapterPipelineInit function. This member is supported starting in
    ///Windows 10.
    PIBIO_STORAGE_PIPELINE_INIT_FN PipelineInit;
    ///A pointer to your implementation of the StorageAdapterPipelineCleanup function. This member is supported starting
    ///in Windows 10.
    PIBIO_STORAGE_PIPELINE_CLEANUP_FN PipelineCleanup;
    ///A pointer to your implementation of the StorageAdapterActivate function. This member is supported starting in
    ///Windows 10.
    PIBIO_STORAGE_ACTIVATE_FN Activate;
    ///A pointer to your implementation of the StorageAdapterDeactivate function. This member is supported starting in
    ///Windows 10.
    PIBIO_STORAGE_DEACTIVATE_FN Deactivate;
    ///A pointer to your implementation of the StorageAdapterQueryExtendedInfo function. This member is supported
    ///starting in Windows 10.
    PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN QueryExtendedInfo;
    PIBIO_STORAGE_NOTIFY_DATABASE_CHANGE_FN NotifyDatabaseChange;
    PIBIO_STORAGE_RESERVED_1_FN Reserved1;
    PIBIO_STORAGE_RESERVED_2_FN Reserved2;
    PIBIO_STORAGE_UPDATE_RECORD_BEGIN_FN UpdateRecordBegin;
    PIBIO_STORAGE_UPDATE_RECORD_COMMIT_FN UpdateRecordCommit;
}

struct WINBIO_FRAMEWORK_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint   Type;
    size_t Size;
    GUID   AdapterId;
    PIBIO_FRAMEWORK_SET_UNIT_STATUS_FN SetUnitStatus;
    PIBIO_STORAGE_ATTACH_FN VsmStorageAttach;
    PIBIO_STORAGE_DETACH_FN VsmStorageDetach;
    PIBIO_STORAGE_CLEAR_CONTEXT_FN VsmStorageClearContext;
    PIBIO_STORAGE_CREATE_DATABASE_FN VsmStorageCreateDatabase;
    PIBIO_STORAGE_OPEN_DATABASE_FN VsmStorageOpenDatabase;
    PIBIO_STORAGE_CLOSE_DATABASE_FN VsmStorageCloseDatabase;
    PIBIO_STORAGE_DELETE_RECORD_FN VsmStorageDeleteRecord;
    PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN VsmStorageNotifyPowerChange;
    PIBIO_STORAGE_PIPELINE_INIT_FN VsmStoragePipelineInit;
    PIBIO_STORAGE_PIPELINE_CLEANUP_FN VsmStoragePipelineCleanup;
    PIBIO_STORAGE_ACTIVATE_FN VsmStorageActivate;
    PIBIO_STORAGE_DEACTIVATE_FN VsmStorageDeactivate;
    PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN VsmStorageQueryExtendedInfo;
    PIBIO_FRAMEWORK_VSM_CACHE_CLEAR_FN VsmStorageCacheClear;
    PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_BEGIN_FN VsmStorageCacheImportBegin;
    PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_NEXT_FN VsmStorageCacheImportNext;
    PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_END_FN VsmStorageCacheImportEnd;
    PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_BEGIN_FN VsmStorageCacheExportBegin;
    PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_NEXT_FN VsmStorageCacheExportNext;
    PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_END_FN VsmStorageCacheExportEnd;
    PIBIO_SENSOR_ATTACH_FN VsmSensorAttach;
    PIBIO_SENSOR_DETACH_FN VsmSensorDetach;
    PIBIO_SENSOR_CLEAR_CONTEXT_FN VsmSensorClearContext;
    PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN VsmSensorPushDataToEngine;
    PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN VsmSensorNotifyPowerChange;
    PIBIO_SENSOR_PIPELINE_INIT_FN VsmSensorPipelineInit;
    PIBIO_SENSOR_PIPELINE_CLEANUP_FN VsmSensorPipelineCleanup;
    PIBIO_SENSOR_ACTIVATE_FN VsmSensorActivate;
    PIBIO_SENSOR_DEACTIVATE_FN VsmSensorDeactivate;
    PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN VsmSensorAsyncImportRawBuffer;
    PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN VsmSensorAsyncImportSecureBuffer;
    PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_1_FN Reserved1;
    PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_2_FN Reserved2;
    PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_3_FN Reserved3;
    PIBIO_STORAGE_RESERVED_1_FN Reserved4;
    PIBIO_STORAGE_RESERVED_2_FN Reserved5;
    PIBIO_FRAMEWORK_ALLOCATE_MEMORY_FN AllocateMemory;
    PIBIO_FRAMEWORK_FREE_MEMORY_FN FreeMemory;
    PIBIO_FRAMEWORK_GET_PROPERTY_FN GetProperty;
    PIBIO_FRAMEWORK_LOCK_AND_VALIDATE_SECURE_BUFFER_FN LockAndValidateSecureBuffer;
    PIBIO_FRAMEWORK_RELEASE_SECURE_BUFFER_FN ReleaseSecureBuffer;
    PIBIO_FRAMEWORK_VSM_QUERY_AUTHORIZED_ENROLLMENTS_FN QueryAuthorizedEnrollments;
    PIBIO_FRAMEWORK_VSM_DECRYPT_SAMPLE_FN DecryptSample;
}

// Functions

///Retrieves information about installed biometric service providers. Starting with Windows 10, build 1607, this
///function is available to use with a mobile image.
///Params:
///    Factor = A bitmask of WINBIO_BIOMETRIC_TYPE flags that specifies the biometric unit types to be enumerated. Only
///             <b>WINBIO_TYPE_FINGERPRINT</b> is currently supported.
///    BspSchemaArray = Address of a variable that receives a pointer to an array of WINBIO_BSP_SCHEMA structures that contain
///                     information about each of the available service providers. If the function does not succeed, the pointer is set
///                     to <b>NULL</b>. If the function succeeds, you must pass the pointer to WinBioFree to release memory allocated
///                     internally for the array.
///    BspCount = Pointer to a value that specifies the number of structures pointed to by the <i>BspSchemaArray</i> parameter.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The bitmask contained in the
///    <i>Factor</i> parameter contains one or more an invalid type bits. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient memory to complete the request.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The
///    <i>BspSchemaArray</i> and <i>BspCount</i> parameters cannot be <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioEnumServiceProviders(uint Factor, WINBIO_BSP_SCHEMA** BspSchemaArray, size_t* BspCount);

///Enumerates all attached biometric units that match the input type.
///Params:
///    Factor = A bitmask of WINBIO_BIOMETRIC_TYPE flags that specifies the biometric unit types to be enumerated. Only
///             <b>WINBIO_TYPE_FINGERPRINT</b> is currently supported.
///    UnitSchemaArray = Address of a variable that receives a pointer to an array of WINBIO_UNIT_SCHEMA structures that contain
///                      information about each enumerated biometric unit. If the function does not succeed, the pointer is set to
///                      <b>NULL</b>. If the function succeeds, you must pass the pointer to WinBioFree to release memory allocated
///                      internally for the array.
///    UnitCount = Pointer to a value that specifies the number of structures pointed to by the <i>UnitSchemaArray</i> parameter.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The bitmask contained in the
///    <i>Factor</i> parameter contains one or more an invalid type bits. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient memory to complete the request.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The
///    <i>UnitSchemaArray</i> and <i>UnitCount</i> parameters cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b><b>WINBIO_E_DISABLED</b></b></dt> </dl> </td> <td width="60%"> Current administrative policy
///    prohibits use of the Windows Biometric Framework API. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioEnumBiometricUnits(uint Factor, WINBIO_UNIT_SCHEMA** UnitSchemaArray, size_t* UnitCount);

///Enumerates all registered databases that match a specified type.
///Params:
///    Factor = A bitmask of WINBIO_BIOMETRIC_TYPE flags that specifies the biometric unit types to be enumerated. Only
///             <b>WINBIO_TYPE_FINGERPRINT</b> is currently supported.
///    StorageSchemaArray = Address of a variable that receives a pointer to an array of WINBIO_STORAGE_SCHEMA structures that contain
///                         information about each database. If the function does not succeed, the pointer is set to <b>NULL</b>. If the
///                         function succeeds, you must pass the pointer to WinBioFree to release memory allocated internally for the array.
///    StorageCount = Pointer to a value that specifies the number of structures pointed to by the <i>StorageSchemaArray</i> parameter.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The bitmask contained in the
///    <i>Factor</i> parameter contains one or more an invalid type bits. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient memory to complete the request.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The
///    <i>StorageSchemaArray</i> and <i>StorageCount</i> parameters cannot be <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioEnumDatabases(uint Factor, WINBIO_STORAGE_SCHEMA** StorageSchemaArray, size_t* StorageCount);

///Opens a handle to the biometric framework. Starting with Windows 10, build 1607, this function is available to use
///with a mobile image. You can use this handle to asynchronously enumerate biometric units, databases, and service
///providers and to receive asynchronous notification when biometric units are attached to the computer or removed.
///Params:
///    NotificationMethod = Specifies how completion notifications for asynchronous operations in this framework session are to be delivered
///                         to the client application. This must be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                         </tr> <tr> <td width="40%"><a id="WINBIO_ASYNC_NOTIFY_CALLBACK"></a><a id="winbio_async_notify_callback"></a><dl>
///                         <dt><b>WINBIO_ASYNC_NOTIFY_CALLBACK</b></dt> </dl> </td> <td width="60%"> The framework invokes the callback
///                         function defined by the application. </td> </tr> <tr> <td width="40%"><a id="WINBIO_ASYNC_NOTIFY_MESSAGE"></a><a
///                         id="winbio_async_notify_message"></a><dl> <dt><b>WINBIO_ASYNC_NOTIFY_MESSAGE</b></dt> </dl> </td> <td
///                         width="60%"> The framework posts a window message to the application's message queue. </td> </tr> </table>
///    TargetWindow = Handle of the window that will receive the completion notices. This value is ignored unless the
///                   <i>NotificationMethod</i> parameter is set to <b>WINBIO_ASYNC_NOTIFY_MESSAGE</b>.
///    MessageCode = Window message code the framework must send to signify completion notices. This value is ignored unless the
///                  <i>NotificationMethod</i> parameter is set to <b>WINBIO_ASYNC_NOTIFY_MESSAGE</b>. The value must be within the
///                  range WM_APP (0x8000) to 0xBFFF. The Windows Biometric Framework sets the <b>LPARAM</b> value of the message to
///                  the address of the WINBIO_ASYNC_RESULT structure that contains the results of the operation. You must call
///                  WinBioFree to release the structure after you have finished using it.
///    CallbackRoutine = Address of the callback routine to be invoked for completion notices. This value is ignored unless the
///                      <i>NotificationMethod</i> parameter is set to <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b>.
///    UserData = Address of a buffer supplied by the caller. The buffer is not modified by the framework or the biometric unit. It
///               is returned in the WINBIO_ASYNC_RESULT structure. Your application can use the data to help it determine what
///               actions to perform upon receipt of the completion notice or to maintain additional information about the
///               requested operation.
///    AsynchronousOpen = Specifies whether to block until the framework session has been opened. Specifying <b>FALSE</b> causes the
///                       process to block. Specifying <b>TRUE</b> causes the session to be opened asynchronously. If you specify
///                       <b>FALSE</b> to open the framework session synchronously, success or failure is returned to the caller directly
///                       by this function in the <b>HRESULT</b> return value. If the session is opened successfully, the first
///                       asynchronous completion event your application receives will be for an asynchronous operation requested after the
///                       framework has been open. If you specify <b>TRUE</b> to open the framework session asynchronously, the first
///                       asynchronous completion notice received will be for opening the framework. If the <i>NotificationMethod</i>
///                       parameter is set to <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b>, operation results are delivered to the
///                       WINBIO_ASYNC_RESULT structure in the callback function specified by the <i>CallbackRoutine</i> parameter. If the
///                       <i>NotificationMethod</i> parameter is set to <b>WINBIO_ASYNC_NOTIFY_MESSAGE</b>, operation results are delivered
///                       to the <b>WINBIO_ASYNC_RESULT</b> structure pointed to by the <b>LPARAM</b> field of the window message.
///    FrameworkHandle = If the function does not succeed, this parameter will be <b>NULL</b>. If the session is opened synchronously and
///                      successfully, this parameter will contain a pointer to the session handle. If you specify that the session be
///                      opened asynchronously, this method returns immediately, the session handle will be <b>NULL</b>, and you must
///                      examine the WINBIO_ASYNC_RESULT structure to determine whether the session was successfully opened.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_OUTOFMEMORY</b></b></dt> </dl> </td> <td width="60%"> There is not enough
///    memory available to create the framework session. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%"> If you set the notification method to
///    <b>WINBIO_ASYNC_NOTIFY_MESSAGE</b>, the <i>TargetWindow</i> parameter cannot be <b>NULL</b> or
///    <b>HWND_BROADCAST</b> and the <i>MessageCode</i> parameter cannot be zero (0). </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The <i>FrameworkHandle</i> parameter and the
///    <i>AsynchronousOpen</i> parameter must be set. If you set the notification method to
///    <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b>, you must also specify the address of a callback function in the
///    <i>CallbackRoutine</i> parameter. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioAsyncOpenFramework(WINBIO_ASYNC_NOTIFICATION_METHOD NotificationMethod, HWND TargetWindow, 
                                 uint MessageCode, PWINBIO_ASYNC_COMPLETION_CALLBACK CallbackRoutine, void* UserData, 
                                 BOOL AsynchronousOpen, uint* FrameworkHandle);

///Closes a framework handle previously opened with WinBioAsyncOpenFramework. Starting with Windows 10, build 1607, this
///function is available to use with a mobile image.
///Params:
///    FrameworkHandle = Handle to the framework session that will be closed.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error.
///    
@DllImport("winbio")
HRESULT WinBioCloseFramework(uint FrameworkHandle);

///Asynchronously returns information about installed biometric service providers. Starting with Windows 10, build 1607,
///this function is available to use with a mobile image. For a synchronous version of this function, see
///WinBioEnumServiceProviders.
///Params:
///    FrameworkHandle = Handle to the framework session opened by calling WinBioAsyncOpenFramework.
///    Factor = A bitmask of WINBIO_BIOMETRIC_TYPE flags that specifies the biometric service provider types to be enumerated.
///             For Windows 8, only <b>WINBIO_TYPE_FINGERPRINT</b> is supported.
///Returns:
///    The function returns an <b>HRESULT</b> indicating success or failure. Note that success indicates only that the
///    function's arguments were valid. Failures encountered during the execution of the operation will be returned
///    asynchronously to a WINBIO_ASYNC_RESULT structure using the notification method specified in the call to
///    WinBioAsyncOpenFramework. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> You must set the <i>FrameworkHandle</i> argument. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The bitmask contained
///    in the <i>Factor</i> parameter contains one or more an invalid type bits. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient memory to complete the request.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INCORRECT_SESSION_TYPE</b></dt> </dl> </td> <td
///    width="60%"> The <i>FrameworkHandle</i> argument must represent an asynchronous framework session. </td> </tr>
///    </table>
///    
@DllImport("winbio")
HRESULT WinBioAsyncEnumServiceProviders(uint FrameworkHandle, uint Factor);

///Asynchronously enumerates all attached biometric units that match the input factor type. For a synchronous version of
///this function, see WinBioEnumBiometricUnits. Starting with Windows 10, build 1607, this function is available to use
///with a mobile image.
///Params:
///    FrameworkHandle = Handle to the framework session opened by calling WinBioAsyncOpenFramework.
///    Factor = A bitmask of WINBIO_BIOMETRIC_TYPE flags that specifies the biometric unit types to be enumerated. Only
///             <b>WINBIO_TYPE_FINGERPRINT</b> is currently supported.
///Returns:
///    The function returns an <b>HRESULT</b> indicating success or failure. Note that success indicates only that the
///    arguments were valid. Failures encountered during the execution of the operation will be returned asynchronously
///    to a WINBIO_ASYNC_RESULT structure using the notification method specified in the call to
///    WinBioAsyncOpenFramework. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> You must set the <i>FrameworkHandle</i> argument. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The bitmask contained
///    in the <i>Factor</i> parameter contains one or more an invalid type bits. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient memory to complete the request.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DISABLED</b></b></dt> </dl> </td> <td width="60%">
///    Current administrative policy prohibits use of the Windows Biometric Framework API. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_INCORRECT_SESSION_TYPE</b></dt> </dl> </td> <td width="60%"> The
///    <i>FrameworkHandle</i> argument must represent an asynchronous framework session. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_SESSION_HANDLE_CLOSED</b></dt> </dl> </td> <td width="60%"> The session handle
///    has been marked for closure. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioAsyncEnumBiometricUnits(uint FrameworkHandle, uint Factor);

///Asynchronously enumerates all registered databases that match a specified type. For a synchronous version of this
///function, see WinBioEnumDatabases.
///Params:
///    FrameworkHandle = Handle to the framework session opened by calling WinBioAsyncOpenFramework.
///    Factor = A bitmask of WINBIO_BIOMETRIC_TYPE flags that specifies the biometric database types to be enumerated. Only
///             <b>WINBIO_TYPE_FINGERPRINT</b> is currently supported.
///Returns:
///    The function returns an <b>HRESULT</b> indicating success or failure. Note that success indicates only that the
///    function's arguments were valid. Failures encountered during the execution of the operation will be returned
///    asynchronously to a WINBIO_ASYNC_RESULT structure using the notification method specified in the call to
///    WinBioAsyncOpenFramework. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> You must set the <i>FrameworkHandle</i> argument. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The bitmask contained
///    in the <i>Factor</i> parameter contains one or more an invalid type bits. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient memory to complete the request.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INCORRECT_SESSION_TYPE</b></dt> </dl> </td> <td
///    width="60%"> The <i>FrameworkHandle</i> argument must represent an asynchronous framework session. </td> </tr>
///    </table>
///    
@DllImport("winbio")
HRESULT WinBioAsyncEnumDatabases(uint FrameworkHandle, uint Factor);

///Starts an asynchronous monitor of changes to the biometric framework. Currently, the only monitored changes that are
///supported occur when a biometric unit is attached to or detached from the computer.
///Params:
///    FrameworkHandle = Handle to the framework session opened by calling WinBioAsyncOpenFramework.
///    ChangeTypes = A bitmask of type <b>WINBIO_FRAMEWORK_CHANGE_TYPE</b> flags that indicates the types of events that should
///                  generate asynchronous notifications. Beginning with Windows 8, the following flag is available: <table> <tr>
///                  <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WINBIO_FRAMEWORK_CHANGE_UNIT"></a><a
///                  id="winbio_framework_change_unit"></a><dl> <dt><b>WINBIO_FRAMEWORK_CHANGE_UNIT</b></dt> </dl> </td> <td
///                  width="60%"> A biometric unit has been attached to or detached from the computer. </td> </tr> </table>
///Returns:
///    The function returns an <b>HRESULT</b> indicating success or failure. Note that success indicates only that the
///    function arguments were valid. Failures encountered during the execution of the operation will be returned
///    asynchronously to a WINBIO_ASYNC_RESULT structure using the notification method specified in
///    WinBioAsyncOpenFramework. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> You must set the <i>FrameworkHandle</i> argument. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The bitmask contained
///    in the <i>ChangeTypes</i> parameter contains one or more an invalid type bits. Currently, the only available
///    value is <b>WINBIO_FRAMEWORK_CHANGE_UNIT</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INCORRECT_SESSION_TYPE</b></dt> </dl> </td> <td width="60%"> The <i>FrameworkHandle</i> argument
///    must represent an asynchronous framework session. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioAsyncMonitorFrameworkChanges(uint FrameworkHandle, uint ChangeTypes);

///Connects to a biometric service provider and one or more biometric units.
///Params:
///    Factor = A bitmask of WINBIO_BIOMETRIC_TYPE flags that specifies the biometric unit types to be enumerated. Only
///             <b>WINBIO_TYPE_FINGERPRINT</b> is currently supported.
///    PoolType = A <b>ULONG</b> value that specifies the type of the biometric units that will be used in the session. This can be
///               one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="WINBIO_POOL_SYSTEM"></a><a id="winbio_pool_system"></a><dl> <dt><b>WINBIO_POOL_SYSTEM</b></dt> </dl> </td>
///               <td width="60%"> The session connects to a shared collection of biometric units managed by the service provider.
///               </td> </tr> <tr> <td width="40%"><a id="WINBIO_POOL_PRIVATE"></a><a id="winbio_pool_private"></a><dl>
///               <dt><b>WINBIO_POOL_PRIVATE</b></dt> </dl> </td> <td width="60%"> The session connects to a collection of
///               biometric units that are managed by the caller. </td> </tr> </table>
///    Flags = A <b>ULONG</b> value that specifies biometric unit configuration and access characteristics for the new session.
///            Configuration flags specify the general configuration of units in the session. Access flags specify how the
///            application will use the biometric units. You must specify one configuration flag but you can combine that flag
///            with any access flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="WINBIO_FLAG_DEFAULT"></a><a id="winbio_flag_default"></a><dl> <dt><b>WINBIO_FLAG_DEFAULT</b></dt> </dl> </td>
///            <td width="60%"> Group: configuration The biometric units operate in the manner specified during installation.
///            You must use this value when the <i>PoolType</i> parameter is WINBIO_POOL_SYSTEM. </td> </tr> <tr> <td
///            width="40%"><a id="WINBIO_FLAG_BASIC"></a><a id="winbio_flag_basic"></a><dl> <dt><b>WINBIO_FLAG_BASIC</b></dt>
///            </dl> </td> <td width="60%"> Group: configuration The biometric units operate only as basic capture devices. All
///            processing, matching, and storage operations is performed by software plug-ins. </td> </tr> <tr> <td
///            width="40%"><a id="WINBIO_FLAG_ADVANCED"></a><a id="winbio_flag_advanced"></a><dl>
///            <dt><b>WINBIO_FLAG_ADVANCED</b></dt> </dl> </td> <td width="60%"> Group: configuration The biometric units use
///            internal processing and storage capabilities. </td> </tr> <tr> <td width="40%"><a id="WINBIO_FLAG_RAW"></a><a
///            id="winbio_flag_raw"></a><dl> <dt><b>WINBIO_FLAG_RAW</b></dt> </dl> </td> <td width="60%"> Group: access The
///            client application captures raw biometric data using WinBioCaptureSample. </td> </tr> <tr> <td width="40%"><a
///            id="WINBIO_FLAG_MAINTENANCE"></a><a id="winbio_flag_maintenance"></a><dl> <dt><b>WINBIO_FLAG_MAINTENANCE</b></dt>
///            </dl> </td> <td width="60%"> Group: access The client performs vendor-defined control operations on a biometric
///            unit by calling WinBioControlUnitPrivileged. </td> </tr> </table>
///    UnitArray = Pointer to an array of biometric unit identifiers to be included in the session. You can call
///                WinBioEnumBiometricUnits to enumerate the biometric units. Set this value to <b>NULL</b> if the <i>PoolType</i>
///                parameter is <b>WINBIO_POOL_SYSTEM</b>.
///    UnitCount = A value that specifies the number of elements in the array pointed to by the <i>UnitArray</i> parameter. Set this
///                value to zero if the <i>PoolType</i> parameter is <b>WINBIO_POOL_SYSTEM</b>.
///    DatabaseId = A value that specifies the database(s) to be used by the session. If the <i>PoolType</i> parameter is
///                 <b>WINBIO_POOL_PRIVATE</b>, you must specify the GUID of an installed database. If the <i>PoolType</i> parameter
///                 is not <b>WINBIO_POOL_PRIVATE</b>, you can specify one of the following common values. <table> <tr>
///                 <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WINBIO_DB_DEFAULT"></a><a
///                 id="winbio_db_default"></a><dl> <dt><b>WINBIO_DB_DEFAULT</b></dt> </dl> </td> <td width="60%"> Each biometric
///                 unit in the sensor pool uses the default database specified in the default biometric unit configuration. You must
///                 specify this value if the <i>PoolType</i> parameter is <b>WINBIO_POOL_SYSTEM</b>. You cannot use this value if
///                 the <i>PoolType</i> parameter is <b>WINBIO_POOL_PRIVATE</b> </td> </tr> <tr> <td width="40%"><a
///                 id="WINBIO_DB_BOOTSTRAP"></a><a id="winbio_db_bootstrap"></a><dl> <dt><b>WINBIO_DB_BOOTSTRAP</b></dt> </dl> </td>
///                 <td width="60%"> You can specify this value to be used for scenarios prior to starting Windows. Typically, the
///                 database is part of the sensor chip or is part of the BIOS and can only be used for template enrollment and
///                 deletion. </td> </tr> <tr> <td width="40%"><a id="WINBIO_DB_ONCHIP"></a><a id="winbio_db_onchip"></a><dl>
///                 <dt><b>WINBIO_DB_ONCHIP</b></dt> </dl> </td> <td width="60%"> The database is on the sensor chip and is available
///                 for enrollment and matching. </td> </tr> </table>
///    SessionHandle = Pointer to the new session handle. If the function does not succeed, the handle is set to zero.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%"> One or more arguments have
///    incorrect values or are incompatible with other arguments. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The session handle pointer in the
///    <i>SessionHandle</i> parameter cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> The <i>Flags</i> parameter contains the
///    <b>WINBIO_FLAG_RAW</b> or the <b>WINBIO_FLAG_MAINTENANCE</b> flag and the caller has not been granted either
///    access permission. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_INVALID_UNIT</b></b></dt> </dl>
///    </td> <td width="60%"> One or more of the biometric unit numbers specified in the <i>UnitArray</i> parameter is
///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_NOT_ACTIVE_CONSOLE</b></b></dt> </dl> </td>
///    <td width="60%"> The client application is running on a remote desktop client and is attempting to open a system
///    pool session. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_SENSOR_UNAVAILABLE</b></b></dt> </dl>
///    </td> <td width="60%"> The <i>PoolType</i> parameter is set to WINBIO_POOL_PRIVATE and one or more of the
///    requested sensors in that pool is not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_DISABLED</b></b></dt> </dl> </td> <td width="60%"> Current administrative policy prohibits use
///    of the Windows Biometric Framework API. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioOpenSession(uint Factor, uint PoolType, uint Flags, char* UnitArray, size_t UnitCount, 
                          GUID* DatabaseId, uint* SessionHandle);

///Asynchronously connects to a biometric service provider and one or more biometric units. Starting with Windows 10,
///build 1607, this function is available to use with a mobile image. If successful, the function returns a biometric
///session handle. Every operation performed by using this handle will be completed asynchronously, including
///WinBioCloseSession, and the results will be returned to the client application by using the method specified in the
///<i>NotificationMethod</i> parameter. For a synchronous version of this function, see WinBioOpenSession.
///Params:
///    Factor = A bitmask of WINBIO_BIOMETRIC_TYPE flags that specifies the biometric unit types to be enumerated. Only
///             <b>WINBIO_TYPE_FINGERPRINT</b> is currently supported.
///    PoolType = A <b>ULONG</b> value that specifies the type of the biometric units that will be used in the session. This can be
///               one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="WINBIO_POOL_SYSTEM"></a><a id="winbio_pool_system"></a><dl> <dt><b>WINBIO_POOL_SYSTEM</b></dt> </dl> </td>
///               <td width="60%"> The session connects to a shared collection of biometric units managed by the service provider.
///               </td> </tr> <tr> <td width="40%"><a id="WINBIO_POOL_PRIVATE"></a><a id="winbio_pool_private"></a><dl>
///               <dt><b>WINBIO_POOL_PRIVATE</b></dt> </dl> </td> <td width="60%"> The session connects to a collection of
///               biometric units that are managed by the caller. </td> </tr> </table>
///    Flags = A <b>ULONG</b> value that specifies biometric unit configuration and access characteristics for the new session.
///            Configuration flags specify the general configuration of units in the session. Access flags specify how the
///            application will use the biometric units. You must specify one configuration flag but you can combine that flag
///            with any access flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="WINBIO_FLAG_DEFAULT"></a><a id="winbio_flag_default"></a><dl> <dt><b>WINBIO_FLAG_DEFAULT</b></dt> </dl> </td>
///            <td width="60%"> Group: configuration The biometric units operate in the manner specified during installation.
///            You must use this value when the <i>PoolType</i> parameter is <b>WINBIO_POOL_SYSTEM</b>. </td> </tr> <tr> <td
///            width="40%"><a id="WINBIO_FLAG_BASIC"></a><a id="winbio_flag_basic"></a><dl> <dt><b>WINBIO_FLAG_BASIC</b></dt>
///            </dl> </td> <td width="60%"> Group: configuration The biometric units operate only as basic capture devices. All
///            processing, matching, and storage operations is performed by software plug-ins. </td> </tr> <tr> <td
///            width="40%"><a id="WINBIO_FLAG_ADVANCED"></a><a id="winbio_flag_advanced"></a><dl>
///            <dt><b>WINBIO_FLAG_ADVANCED</b></dt> </dl> </td> <td width="60%"> Group: configuration The biometric units use
///            internal processing and storage capabilities. </td> </tr> <tr> <td width="40%"><a id="WINBIO_FLAG_RAW"></a><a
///            id="winbio_flag_raw"></a><dl> <dt><b>WINBIO_FLAG_RAW</b></dt> </dl> </td> <td width="60%"> Group: access The
///            client application captures raw biometric data using WinBioCaptureSample. </td> </tr> <tr> <td width="40%"><a
///            id="WINBIO_FLAG_MAINTENANCE"></a><a id="winbio_flag_maintenance"></a><dl> <dt><b>WINBIO_FLAG_MAINTENANCE</b></dt>
///            </dl> </td> <td width="60%"> Group: access The client performs vendor-defined control operations on a biometric
///            unit by calling WinBioControlUnitPrivileged. </td> </tr> </table>
///    UnitArray = Pointer to an array of biometric unit identifiers to be included in the session. You can call
///                WinBioEnumBiometricUnits to enumerate the biometric units. Set this value to <b>NULL</b> if the <i>PoolType</i>
///                parameter is <b>WINBIO_POOL_SYSTEM</b>.
///    UnitCount = A value that specifies the number of elements in the array pointed to by the <i>UnitArray</i> parameter. Set this
///                value to zero if the <i>PoolType</i> parameter is <b>WINBIO_POOL_SYSTEM</b>.
///    DatabaseId = A value that specifies the database(s) to be used by the session. If the <i>PoolType</i> parameter is
///                 <b>WINBIO_POOL_PRIVATE</b>, you must specify the GUID of an installed database. If the <i>PoolType</i> parameter
///                 is not <b>WINBIO_POOL_PRIVATE</b>, you can specify one of the following common values. <table> <tr>
///                 <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WINBIO_DB_DEFAULT"></a><a
///                 id="winbio_db_default"></a><dl> <dt><b>WINBIO_DB_DEFAULT</b></dt> </dl> </td> <td width="60%"> Each biometric
///                 unit in the sensor pool uses the default database specified in the default biometric unit configuration. You must
///                 specify this value if the <i>PoolType</i> parameter is <b>WINBIO_POOL_SYSTEM</b>. You cannot use this value if
///                 the <i>PoolType</i> parameter is <b>WINBIO_POOL_PRIVATE</b> </td> </tr> <tr> <td width="40%"><a
///                 id="WINBIO_DB_BOOTSTRAP"></a><a id="winbio_db_bootstrap"></a><dl> <dt><b>WINBIO_DB_BOOTSTRAP</b></dt> </dl> </td>
///                 <td width="60%"> You can specify this value to be used for scenarios prior to starting Windows. Typically, the
///                 database is part of the sensor chip or is part of the BIOS and can only be used for template enrollment and
///                 deletion. </td> </tr> <tr> <td width="40%"><a id="WINBIO_DB_ONCHIP"></a><a id="winbio_db_onchip"></a><dl>
///                 <dt><b>WINBIO_DB_ONCHIP</b></dt> </dl> </td> <td width="60%"> The database is on the sensor chip and is available
///                 for enrollment and matching. </td> </tr> </table>
///    NotificationMethod = Specifies how completion notifications for asynchronous operations in this biometric session are to be delivered
///                         to the client application. This must be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                         </tr> <tr> <td width="40%"><a id="WINBIO_ASYNC_NOTIFY_CALLBACK"></a><a id="winbio_async_notify_callback"></a><dl>
///                         <dt><b>WINBIO_ASYNC_NOTIFY_CALLBACK</b></dt> </dl> </td> <td width="60%"> The session invokes the callback
///                         function defined by the application. </td> </tr> <tr> <td width="40%"><a id="WINBIO_ASYNC_NOTIFY_MESSAGE"></a><a
///                         id="winbio_async_notify_message"></a><dl> <dt><b>WINBIO_ASYNC_NOTIFY_MESSAGE</b></dt> </dl> </td> <td
///                         width="60%"> The session posts a window message to the application's message queue. </td> </tr> </table>
///    TargetWindow = Handle of the window that will receive the completion notices. This value is ignored unless the
///                   <i>NotificationMethod</i> parameter is set to <b>WINBIO_ASYNC_NOTIFY_MESSAGE</b>.
///    MessageCode = Window message code the framework must send to signify completion notices. This value is ignored unless the
///                  <i>NotificationMethod</i> parameter is set to <b>WINBIO_ASYNC_NOTIFY_MESSAGE</b>. The value must be within the
///                  range WM_APP(0x8000) to 0xBFFF. The Windows Biometric Framework sets the <b>LPARAM</b> value of the message to
///                  the address of the WINBIO_ASYNC_RESULT structure that contains the results of the operation. You must call
///                  WinBioFree to release the structure after you have finished using it.
///    CallbackRoutine = Address of callback routine to be invoked when the operation started by using the session handle completes. This
///                      value is ignored unless the <i>NotificationMethod</i> parameter is set to <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b>.
///    UserData = Address of a buffer supplied by the caller. The buffer is not modified by the framework or the biometric unit. It
///               is returned in the WINBIO_ASYNC_RESULT structure. Your application can use the data to help it determine what
///               actions to perform upon receipt of the completion notice or to maintain additional information about the
///               requested operation.
///    AsynchronousOpen = Specifies whether to block until the framework session has been opened. Specifying <b>FALSE</b> causes the
///                       process to block. Specifying <b>TRUE</b> causes the session to be opened asynchronously. If you specify
///                       <b>FALSE</b> to open the framework session synchronously, success or failure is returned to the caller directly
///                       by this function in the <b>HRESULT</b> return value. If the session is opened successfully, the first
///                       asynchronous completion event your application receives will be for an asynchronous operation requested after the
///                       framework has been open. If you specify <b>TRUE</b> to open the framework session asynchronously, the first
///                       asynchronous completion notice received will be for opening the framework. If the <i>NotificationMethod</i>
///                       parameter is set to <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b>, operation results are delivered to the
///                       WINBIO_ASYNC_RESULT structure in the callback function specified by the <i>CallbackRoutine</i> parameter. If the
///                       <i>NotificationMethod</i> parameter is set to <b>WINBIO_ASYNC_NOTIFY_MESSAGE</b>, operation results are delivered
///                       to the <b>WINBIO_ASYNC_RESULT</b> structure pointed to by the LPARAM field of the window message.
///    SessionHandle = If the function does not succeed, this parameter will be <b>NULL</b>. If the session is opened synchronously and
///                    successfully, this parameter will contain a pointer to the session handle. If you specify that the session be
///                    opened asynchronously, this method returns immediately, the session handle will be <b>NULL</b>, and you must
///                    examine the WINBIO_ASYNC_RESULT structure to determine whether the session was successfully opened.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_OUTOFMEMORY</b></b></dt> </dl> </td> <td width="60%"> There is not enough
///    memory available to create the biometric session. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%"> If you set the notification method to
///    <b>WINBIO_ASYNC_NOTIFY_MESSAGE</b>, the <i>TargetWindow</i> parameter cannot be <b>NULL</b> or
///    <b>HWND_BROADCAST</b> and the <i>MessageCode</i> parameter cannot be zero (0). </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The <i>SessionHandle</i> parameter and the
///    <i>AsynchronousOpen</i> parameter must be set. If you set the notification method to
///    <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b>, you must also specify the address of a callback function in the
///    <i>CallbackRoutine</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt>
///    </dl> </td> <td width="60%"> The <i>Flags</i> parameter contains the <b>WINBIO_FLAG_RAW</b> or the
///    <b>WINBIO_FLAG_MAINTENANCE</b> flag and the caller has not been granted either access permission. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_INVALID_UNIT</b></b></dt> </dl> </td> <td width="60%"> One or more
///    of the biometric unit numbers specified in the <i>UnitArray</i> parameter is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b><b>WINBIO_E_NOT_ACTIVE_CONSOLE</b></b></dt> </dl> </td> <td width="60%"> The client
///    application is running on a remote desktop client and is attempting to open a system pool session. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_SENSOR_UNAVAILABLE</b></b></dt> </dl> </td> <td width="60%"> The
///    <i>PoolType</i> parameter is set to <b>WINBIO_POOL_PRIVATE</b> and one or more of the requested sensors in that
///    pool is not available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_DISABLED</b></b></dt> </dl>
///    </td> <td width="60%"> Current administrative policy prohibits use of the Windows Biometric Framework API. </td>
///    </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioAsyncOpenSession(uint Factor, uint PoolType, uint Flags, char* UnitArray, size_t UnitCount, 
                               GUID* DatabaseId, WINBIO_ASYNC_NOTIFICATION_METHOD NotificationMethod, 
                               HWND TargetWindow, uint MessageCode, 
                               PWINBIO_ASYNC_COMPLETION_CALLBACK CallbackRoutine, void* UserData, 
                               BOOL AsynchronousOpen, uint* SessionHandle);

///Closes a biometric session and releases associated resources. Starting with Windows 10, build 1607, this function is
///available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioCloseSession(uint SessionHandle);

///Captures a biometric sample and determines whether the sample corresponds to the specified user identity. Starting
///with Windows 10, build 1607, this function is available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    Identity = Pointer to a WINBIO_IDENTITY structure that contains the GUID or SID of the user providing the biometric sample.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that specifies the sub-factor associated with the biometric sample. The
///                Windows Biometric Framework (WBF) currently supports only fingerprint capture and can use the following constants
///                to represent sub-type information. <ul> <li>WINBIO_ANSI_381_POS_RH_THUMB</li>
///                <li>WINBIO_ANSI_381_POS_RH_INDEX_FINGER</li> <li>WINBIO_ANSI_381_POS_RH_MIDDLE_FINGER</li>
///                <li>WINBIO_ANSI_381_POS_RH_RING_FINGER</li> <li>WINBIO_ANSI_381_POS_RH_LITTLE_FINGER</li>
///                <li>WINBIO_ANSI_381_POS_LH_THUMB</li> <li>WINBIO_ANSI_381_POS_LH_INDEX_FINGER</li>
///                <li>WINBIO_ANSI_381_POS_LH_MIDDLE_FINGER</li> <li>WINBIO_ANSI_381_POS_LH_RING_FINGER</li>
///                <li>WINBIO_ANSI_381_POS_LH_LITTLE_FINGER</li> <li>WINBIO_ANSI_381_POS_RH_FOUR_FINGERS</li>
///                <li>WINBIO_ANSI_381_POS_LH_FOUR_FINGERS</li> <li>WINBIO_SUBTYPE_ANY</li> </ul>
///    UnitId = A pointer to a <b>WINBIO_UNIT_ID</b> value that specifies the biometric unit that performed the verification.
///    Match = Pointer to a Boolean value that specifies whether the captured sample matched the user identity specified by the
///            <i>Identity</i> parameter.
///    RejectDetail = A pointer to a <b>ULONG</b> value that contains additional information about the failure to capture a biometric
///                   sample. If the capture succeeded, this parameter is set to zero. The following values are defined for fingerprint
///                   capture: <ul> <li>WINBIO_FP_TOO_HIGH</li> <li>WINBIO_FP_TOO_LOW</li> <li>WINBIO_FP_TOO_LEFT</li>
///                   <li>WINBIO_FP_TOO_RIGHT</li> <li>WINBIO_FP_TOO_FAST</li> <li>WINBIO_FP_TOO_SLOW</li>
///                   <li>WINBIO_FP_POOR_QUALITY</li> <li>WINBIO_FP_TOO_SKEWED</li> <li>WINBIO_FP_TOO_SHORT</li>
///                   <li>WINBIO_FP_MERGE_FAILURE</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%">
///    The <i>SubFactor</i> argument is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The pointer specified by the <i>UnitId</i>,
///    <i>Identity</i>, <i>SubFactor</i>, or <i>RejectDetail</i> parameters cannot be <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b><b>WINBIO_E_BAD_CAPTURE</b></b></dt> </dl> </td> <td width="60%"> The biometric sample
///    could not be captured. Use the <i>RejectDetail</i> value for more information. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The operation could not be
///    completed because the specified biometric unit is currently being used for an enrollment transaction (system pool
///    only). </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_NO_MATCH</b></b></dt> </dl> </td> <td
///    width="60%"> The biometric sample does not correspond to the specified <i>Identity</i> and <i>SubFactor</i>
///    combination. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioVerify(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte SubFactor, uint* UnitId, ubyte* Match, 
                     uint* RejectDetail);

///Asynchronously captures a biometric sample and determines whether the sample corresponds to the specified user
///identity. The function returns immediately to the caller, performs capture and verification on a separate thread, and
///calls into an application-defined callback function to update operation status. <div class="alert"><b>Important</b>
///<p class="note">We recommend that, beginning with Windows 8, you no longer use this function to start an asynchronous
///operation. Instead, do the following: <ul> <li>Implement a PWINBIO_ASYNC_COMPLETION_CALLBACK function to receive
///notice when the operation completes.</li> <li>Call the WinBioAsyncOpenSession function. Pass the address of your
///callback in the <i>CallbackRoutine</i> parameter. Pass <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b> in the
///<i>NotificationMethod</i> parameter. Retrieve an asynchronous session handle.</li> <li>Use the asynchronous session
///handle to call WinBioVerify. When the operation finishes, the Windows Biometric Framework will allocate and
///initialize a WINBIO_ASYNC_RESULT structure with the results and invoke your callback with a pointer to the results
///structure.</li> <li>Call WinBioFree from your callback implementation to release the WINBIO_ASYNC_RESULT structure
///after you have finished using it.</li> </ul> </div> <div> </div>
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session.
///    Identity = Pointer to a WINBIO_IDENTITY structure that contains the GUID or SID of the user providing the biometric sample.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that specifies the sub-factor associated with the biometric sample. See
///                the Remarks section for more details.
///    VerifyCallback = Address of a callback function that will be called by the <b>WinBioVerifyWithCallback</b> function when
///                     verification succeeds or fails. You must create the callback.
///    VerifyCallbackContext = An optional application-defined structure that is returned in the <i>VerifyCallbackContext</i> parameter of the
///                            callback function. This structure can contain any data that the custom callback function is designed to handle.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%">
///    The <i>SubFactor</i> argument is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The pointer specified by the <i>Identity</i> and
///    <i>VerifyCallback</i> parameters cannot be <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioVerifyWithCallback(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte SubFactor, 
                                 PWINBIO_VERIFY_CALLBACK VerifyCallback, void* VerifyCallbackContext);

///Captures a biometric sample and determines whether it matches an existing biometric template. Starting with Windows
///10, build 1607, this function is available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    UnitId = A pointer to a <b>ULONG</b> value that specifies the biometric unit used to perform the identification.
///    Identity = Pointer to a WINBIO_IDENTITY structure that receives the GUID or SID of the user providing the biometric sample.
///    SubFactor = Pointer to a <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that receives the sub-factor associated with the biometric
///                sample. See the Remarks section for more details.
///    RejectDetail = A pointer to a <b>ULONG</b> value that contains additional information about the failure, if any, to capture a
///                   biometric sample. If the capture succeeded, this parameter is set to zero. The following values are defined for
///                   fingerprint capture: <ul> <li>WINBIO_FP_TOO_HIGH</li> <li>WINBIO_FP_TOO_LOW</li> <li>WINBIO_FP_TOO_LEFT</li>
///                   <li>WINBIO_FP_TOO_RIGHT</li> <li>WINBIO_FP_TOO_FAST</li> <li>WINBIO_FP_TOO_SLOW</li>
///                   <li>WINBIO_FP_POOR_QUALITY</li> <li>WINBIO_FP_TOO_SKEWED</li> <li>WINBIO_FP_TOO_SHORT</li>
///                   <li>WINBIO_FP_MERGE_FAILURE</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The
///    pointer specified by the <i>UnitId</i>, <i>Identity</i>, <i>SubFactor</i>, or <i>RejectDetail</i> parameters
///    cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_BAD_CAPTURE</b></b></dt> </dl>
///    </td> <td width="60%"> The sample could not be captured. Use the <i>RejectDetail</i> value for more information.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></dt> </dl> </td> <td
///    width="60%"> The operation could not be completed because the biometric unit is currently being used for an
///    enrollment transaction (system pool only). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_UNKNOWN_ID</b></b></dt> </dl> </td> <td width="60%"> The biometric sample does not match any
///    saved in the database. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioIdentify(uint SessionHandle, uint* UnitId, WINBIO_IDENTITY* Identity, ubyte* SubFactor, 
                       uint* RejectDetail);

///Asynchronously captures a biometric sample and determines whether it matches an existing biometric template. The
///function returns immediately to the caller, performs capture and identification on a separate thread, and calls into
///an application-defined callback function to update operation status. <div class="alert"><b>Important</b> <p
///class="note">We recommend that, beginning with Windows 8, you no longer use this function to start an asynchronous
///operation. Instead, do the following: <ul> <li>Implement a PWINBIO_ASYNC_COMPLETION_CALLBACK function to receive
///notice when the operation completes.</li> <li>Call the WinBioAsyncOpenSession function. Pass the address of your
///callback in the <i>CallbackRoutine</i> parameter. Pass <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b> in the
///<i>NotificationMethod</i> parameter. Retrieve an asynchronous session handle.</li> <li>Use the asynchronous session
///handle to call WinBioIdentify. When the operation finishes, the Windows Biometric Framework will allocate and
///initialize a WINBIO_ASYNC_RESULT structure with the results and invoke your callback with a pointer to the results
///structure.</li> <li>Call WinBioFree from your callback implementation to release the WINBIO_ASYNC_RESULT structure
///after you have finished using it.</li> </ul> </div> <div> </div>
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session.
///    IdentifyCallback = Address of a callback function that will be called by the <b>WinBioIdentifyWithCallback</b> function when
///                       identification succeeds or fails. You must create the callback.
///    IdentifyCallbackContext = Pointer to an application-defined data structure that is passed to the callback function in its
///                              <i>IdentifyCallbackContext</i> parameter. This structure can contain any data that the custom callback function
///                              is designed to handle.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
///    <i>SessionHandle</i> and <i>IdentifyCallback</i> parameters cannot be <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioIdentifyWithCallback(uint SessionHandle, PWINBIO_IDENTIFY_CALLBACK IdentifyCallback, 
                                   void* IdentifyCallbackContext);

///Blocks caller execution until all pending biometric operations for a session have been completed or canceled.
///Starting with Windows 10, build 1607, this function is available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioWait(uint SessionHandle);

///Cancels all pending biometric operations for a specified session. Starting with Windows 10, build 1607, this function
///is available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioCancel(uint SessionHandle);

///Retrieves the ID number of a biometric unit selected interactively by a user.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    UnitId = A pointer to a <b>ULONG</b> value that specifies the biometric unit.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The
///    pointer specified by the <i>UnitId</i> parameter cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The operation could not be completed
///    because the biometric unit is currently being used for an enrollment transaction (system pool only). </td> </tr>
///    </table>
///    
@DllImport("winbio")
HRESULT WinBioLocateSensor(uint SessionHandle, uint* UnitId);

///Asynchronously retrieves the ID number of the biometric unit selected interactively by a user. The function returns
///immediately to the caller, processes on a separate thread, and reports the selected biometric unit by calling an
///application-defined callback function. <div class="alert"><b>Important</b> <p class="note">We recommend that,
///beginning with Windows 8, you no longer use this function to start an asynchronous operation. Instead, do the
///following: <ul> <li>Implement a PWINBIO_ASYNC_COMPLETION_CALLBACK function to receive notice when the operation
///completes.</li> <li>Call the WinBioAsyncOpenSession function. Pass the address of your callback in the
///<i>CallbackRoutine</i> parameter. Pass <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b> in the <i>NotificationMethod</i>
///parameter. Retrieve an asynchronous session handle.</li> <li>Use the asynchronous session handle to call
///WinBioLocateSensor. When the operation finishes, the Windows Biometric Framework will allocate and initialize a
///WINBIO_ASYNC_RESULT structure with the results and invoke your callback with a pointer to the results structure.</li>
///<li>Call WinBioFree from your callback implementation to release the WINBIO_ASYNC_RESULT structure after you have
///finished using it.</li> </ul> </div> <div> </div>
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session.
///    LocateCallback = Address of a callback function that will be called by the <b>WinBioLocateSensorWithCallback</b> function when
///                     sensor location succeeds or fails. You must create the callback.
///    LocateCallbackContext = Address of an application-defined data structure that is passed to the callback function in its
///                            <i>LocateCallbackContext</i> parameter. This structure can contain any data that the custom callback function is
///                            designed to handle.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The
///    address specified by the <i>LocateCallback</i> parameter cannot be <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioLocateSensorWithCallback(uint SessionHandle, PWINBIO_LOCATE_SENSOR_CALLBACK LocateCallback, 
                                       void* LocateCallbackContext);

///Initiates a biometric enrollment sequence and creates an empty biometric template. Starting with Windows 10, build
///1607, this function is available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that provides additional information about the enrollment. This must be
///                one of the following values: <ul> <li>WINBIO_ANSI_381_POS_RH_THUMB</li>
///                <li>WINBIO_ANSI_381_POS_RH_INDEX_FINGER</li> <li>WINBIO_ANSI_381_POS_RH_MIDDLE_FINGER</li>
///                <li>WINBIO_ANSI_381_POS_RH_RING_FINGER</li> <li>WINBIO_ANSI_381_POS_RH_LITTLE_FINGER</li>
///                <li>WINBIO_ANSI_381_POS_LH_THUMB</li> <li>WINBIO_ANSI_381_POS_LH_INDEX_FINGER</li>
///                <li>WINBIO_ANSI_381_POS_LH_MIDDLE_FINGER</li> <li>WINBIO_ANSI_381_POS_LH_RING_FINGER</li>
///                <li>WINBIO_ANSI_381_POS_LH_LITTLE_FINGER</li> <li>WINBIO_ANSI_381_POS_RH_FOUR_FINGERS</li>
///                <li>WINBIO_ANSI_381_POS_LH_FOUR_FINGERS</li> </ul>
///    UnitId = A <b>WINBIO_UNIT_ID</b> value that identifies the biometric unit. This value cannot be zero. You can find a unit
///             ID by calling the WinBioEnumBiometricUnits or WinBioLocateSensor functions.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    permission to enroll. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td
///    width="60%"> The session handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%"> The <i>SubFactor</i> parameter cannot equal
///    WINBIO_SUBTYPE_NO_INFORMATION or WINBIO_SUBTYPE_ANY, and the <i>UnitId</i> parameter cannot equal zero. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></b></dt> </dl> </td> <td
///    width="60%"> An enrollment operation is already in progress, and only one enrollment can occur at a given time.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_LOCK_VIOLATION</b></b></dt> </dl> </td> <td
///    width="60%"> The biometric unit is in use and is locked. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioEnrollBegin(uint SessionHandle, ubyte SubFactor, uint UnitId);

///Specifies the individual that you want to enroll when data that represents multiple individuals is present in the
///sample buffer. Starting with Windows 10, build 1607, this function is available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession. For
///                    enrollment in facial recognition, use WinBioAsyncOpenSession with the <i>PoolType</i> parameter set to
///                    <b>WINBIO_POOL_SYSTEM</b> to get the handle.
///    SelectorValue = A value that identifies that individual that you want to select for enrollment.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%">
///    The <i>SelectorValue</i> parameter cannot equal zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_INCORRECT_SESSION_TYPE</b></b></dt> </dl> </td> <td width="60%"> The session handle does not
///    correspond to a biometric session. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioEnrollSelect(uint SessionHandle, ulong SelectorValue);

///Captures a biometric sample and adds it to a template. Starting with Windows 10, build 1607, this function is
///available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    RejectDetail = A pointer to a <b>ULONG</b> value that contains additional information the failure to capture a biometric sample.
///                   If the capture succeeded, this parameter is set to zero. The following values are defined for fingerprint
///                   capture: <ul> <li>WINBIO_FP_TOO_HIGH</li> <li>WINBIO_FP_TOO_LOW</li> <li>WINBIO_FP_TOO_LEFT</li>
///                   <li>WINBIO_FP_TOO_RIGHT</li> <li>WINBIO_FP_TOO_FAST</li> <li>WINBIO_FP_TOO_SLOW</li>
///                   <li>WINBIO_FP_POOR_QUALITY</li> <li>WINBIO_FP_TOO_SKEWED</li> <li>WINBIO_FP_TOO_SHORT</li>
///                   <li>WINBIO_FP_MERGE_FAILURE</li> </ul>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> The calling account is
///    not allowed to perform enrollment. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl>
///    </td> <td width="60%"> The session handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The pointer specified by the <i>RejectDetail</i>
///    parameter cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_BAD_CAPTURE</b></b></dt> </dl> </td> <td width="60%"> The sample could not be captured. Use
///    the <i>RejectDetail</i> value for more information. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_LOCK_VIOLATION</b></b></dt> </dl> </td> <td width="60%"> The biometric unit is in use and is
///    locked. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_I_MORE_DATA</b></b></dt> </dl> </td> <td
///    width="60%"> The matching engine requires one or more additional samples to generate a reliable template. You
///    should update instructions to the user to submit more samples and call WinBioEnrollCapture again. </td> </tr>
///    </table>
///    
@DllImport("winbio")
HRESULT WinBioEnrollCapture(uint SessionHandle, uint* RejectDetail);

///Asynchronously captures a biometric sample and adds it to a template. The function returns immediately to the caller,
///performs enrollment on a separate thread, and calls into an application-defined callback function to update operation
///status. <div class="alert"><b>Important</b> <p class="note">We recommend that, beginning with Windows 8, you no
///longer use this function to start an asynchronous operation. Instead, do the following: <ul> <li>Implement a
///PWINBIO_ASYNC_COMPLETION_CALLBACK function to receive notice when the operation completes.</li> <li>Call the
///WinBioAsyncOpenSession function. Pass the address of your callback in the <i>CallbackRoutine</i> parameter. Pass
///<b>WINBIO_ASYNC_NOTIFY_CALLBACK</b> in the <i>NotificationMethod</i> parameter. Retrieve an asynchronous session
///handle.</li> <li>Use the asynchronous session handle to call WinBioEnrollCapture. When the operation finishes, the
///Windows Biometric Framework will allocate and initialize a WINBIO_ASYNC_RESULT structure with the results and invoke
///your callback with a pointer to the results structure.</li> <li>Call WinBioFree from your callback implementation to
///release the WINBIO_ASYNC_RESULT structure after you have finished using it.</li> </ul> </div> <div> </div>
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session.
///    EnrollCallback = Address of a callback function that will be called by the <b>WinBioEnrollCaptureWithCallback</b> function when
///                     the capture operation succeeds or fails. You must create the callback.
///    EnrollCallbackContext = Pointer to an optional application-defined structure that is passed to the <i>EnrollCallbackContext</i> parameter
///                            of the callback function. This structure can contain any data that the custom callback function is designed to
///                            handle.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> The calling account is
///    not allowed to perform enrollment. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl>
///    </td> <td width="60%"> The session handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The pointer specified by the <i>EnrollCallback</i>
///    parameter cannot be <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioEnrollCaptureWithCallback(uint SessionHandle, PWINBIO_ENROLL_CAPTURE_CALLBACK EnrollCallback, 
                                        void* EnrollCallbackContext);

///Finalizes a pending biometric template and saves it to the database associated with the biometric unit used for
///enrollment. Starting with Windows 10, build 1607, this function is available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    Identity = Pointer to a WINBIO_IDENTITY structure that receives the identifier (GUID or SID) of the template.
///    IsNewTemplate = Pointer to a Boolean value that specifies whether the template being added to the database is new.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The
///    pointers specified by the <i>Identity</i> and <i>IsNewTemplate</i> parameters cannot be <b>NULL</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_DATABASE_FULL</b></dt> </dl> </td> <td width="60%"> There is no space
///    available in the database for the template. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_DUPLICATE_TEMPLATE</b></dt> </dl> </td> <td width="60%"> The template matches one already saved
///    in the database with a different identity or sub-factor (system pool only). </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b><b>WINBIO_E_LOCK_VIOLATION</b></b></dt> </dl> </td> <td width="60%"> The biometric unit is in use and
///    is locked. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioEnrollCommit(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte* IsNewTemplate);

///Ends the enrollment sequence and discards a pending biometric template. Starting with Windows 10, build 1607, this
///function is available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    permission to enroll. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td
///    width="60%"> The session handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_LOCK_VIOLATION</b></b></dt> </dl> </td> <td width="60%"> The biometric unit is in use and is
///    locked. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioEnrollDiscard(uint SessionHandle);

///Retrieves the biometric sub-factors enrolled for a specified identity and biometric unit. Starting with Windows 10,
///build 1607, this function is available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    UnitId = A <b>WINBIO_UNIT_ID</b> value that specifies the biometric unit.
///    Identity = Pointer to a WINBIO_IDENTITY structure that contains the GUID or SID of the template from which the sub-factors
///               are to be retrieved.
///    SubFactorArray = Address of a variable that receives a pointer to an array of sub-factors. If the function does not succeed, the
///                     pointer is set to <b>NULL</b>. If the function succeeds, you must pass the pointer to WinBioFree to release
///                     memory allocated internally for the array.
///    SubFactorCount = Pointer to a value that specifies the number of elements in the array pointed to by the <i>SubFactorArray</i>
///                     parameter. If the function does not succeed, this value is set to zero.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%">
///    The <i>UnitId</i> parameter cannot be zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The <i>Identity</i>, <i>SubFactorArray</i>, and
///    <i>SubFactorCount</i> parameters cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></b></dt> </dl> </td> <td width="60%"> The operation could not be
///    completed because the biometric unit specified by the <i>UnitId</i> parameter is currently being used for an
///    enrollment transaction. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_UNKNOWN_ID</b></b></dt> </dl>
///    </td> <td width="60%"> The GUID or SID specified by the <i>Identity</i> parameter cannot be found. </td> </tr>
///    </table>
///    
@DllImport("winbio")
HRESULT WinBioEnumEnrollments(uint SessionHandle, uint UnitId, WINBIO_IDENTITY* Identity, ubyte** SubFactorArray, 
                              size_t* SubFactorCount);

///The <b>WinBioRegisterEventMonitor</b> function Registers a callback function to receive event notifications from the
///service provider associated with an open session.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies the open biometric session. Open the session handle by
///                    calling WinBioOpenSession.
///    EventMask = A value that specifies the types of events to monitor. Only the fingerprint provider is currently supported. You
///                must specify one of the following flags. * **WINBIO_EVENT_FP_UNCLAIMED** The sensor detected a finger swipe that
///                was not requested by the application, or the requesting application does not have window focus. The Windows
///                Biometric Framework calls into your callback function to indicate that a finger swipe has occurred but does not
///                try to identify the fingerprint. * **WINBIO_EVENT_FP_UNCLAIMED_IDENTIFY** The sensor detected a finger swipe that
///                was not requested by the application, or the requesting application does not have window focus. The Windows
///                Biometric Framework attempts to identify the fingerprint and passes the result of that process to your callback
///                function.
///    EventCallback = Address of a callback function that receives the event notifications sent by the Windows Biometric Framework. You
///                    must define this function.
///    EventCallbackContext = An optional application-defined value that is returned in the <i>pvContext</i> parameter of the callback
///                           function. This value can contain any data that the custom callback function is designed to handle.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The
///    address of the callback function specified by the <i>EventCallback</i> parameter cannot be <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%"> The
///    <i>EventMask</i> parameter cannot be zero and you cannot specify both <b>WINBIO_EVENT_FP_UNCLAIMED</b> and
///    <b>WINBIO_EVENT_FP_UNCLAIMED_IDENTIFY</b> at the same time. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_EVENT_MONITOR_ACTIVE</b></b></dt> </dl> </td> <td width="60%"> An active event monitor has
///    already been registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_INVALID_OPERATION</b></b></dt>
///    </dl> </td> <td width="60%"> The service provider does not support event notification. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioRegisterEventMonitor(uint SessionHandle, uint EventMask, PWINBIO_EVENT_CALLBACK EventCallback, 
                                   void* EventCallbackContext);

///The <b>WinBioUnregisterEventMonitor</b> function cancels event notifications from the service provider associated
///with an open biometric session.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies the open biometric session. Open the session handle by
///                    calling WinBioOpenSession.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioUnregisterEventMonitor(uint SessionHandle);

///Turns on the face-recognition or iris-monitoring mechanism for the specified biometric unit. Starting with Windows
///10, build 1607, this function is available to use with a mobile image.
///Params:
///    SessionHandle = An asynchronous handle for the biometric session that you obtained by calling the WinBioAsyncOpenSession function
///                    with the <i>PoolType</i> parameter set to <b>WINBIO_POOL_SYSTEM</b>.
///    UnitId = The identifier of the biometric unit for which you want to turn on the face-recognition or iris-monitoring
///             mechanism.
///Returns:
///    If the function parameters are acceptable, it returns <b>S_OK</b>. If the function parameters are not acceptable,
///    it returns an <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to,
///    those in the following table. For a list of common error codes, see Common HRESULT Values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl>
///    </td> <td width="60%"> The session handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%"> The <i>UnitId</i> parameter cannot equal zero.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_INCORRECT_SESSION_TYPE</b></b></dt> </dl> </td> <td
///    width="60%"> The session handle does not correspond to an asynchronous biometric session. </td> </tr> </table>
///    The actual success or failure of the operation itself is returned to the your notification function in a
///    WINBIO_ASYNC_RESULT structure.
///    
@DllImport("winbio")
HRESULT WinBioMonitorPresence(uint SessionHandle, uint UnitId);

///Captures a biometric sample and fills a biometric information record (BIR) with the raw or processed data.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    Purpose = A <b>WINBIO_BIR_PURPOSE</b> bitmask that specifies the intended use of the sample. This can be a bitwise
///              <b>OR</b> of the following values: <ul> <li><b>WINBIO_PURPOSE_VERIFY</b></li>
///              <li><b>WINBIO_PURPOSE_IDENTIFY</b></li> <li><b>WINBIO_PURPOSE_ENROLL</b></li>
///              <li><b>WINBIO_PURPOSE_ENROLL_FOR_VERIFICATION</b></li> <li><b>WINBIO_PURPOSE_ENROLL_FOR_IDENTIFICATION</b></li>
///              </ul>
///    Flags = A value that specifies the type of processing to be applied to the captured sample. This can be a bitwise
///            <b>OR</b> of the following security and processing level flags: * **WINBIO_DATA_FLAG_PRIVACY** Encrypt the
///            sample. * **WINBIO_DATA_FLAG_INTEGRITY** Sign the sample or protect it by using a message authentication code
///            (MAC) * **WINBIO_DATA_FLAG_SIGNED** If this flag and the WINBIO_DATA_FLAG_INTEGRITY flag are set, sign the
///            sample. If this flag is not set but the WINBIO_DATA_FLAG_INTEGRITY flag is set, compute a MAC. *
///            **WINBIO_DATA_FLAG_RAW** Return the sample exactly as it was captured by the sensor. *
///            **WINBIO_DATA_FLAG_INTERMEDIATE** Return the sample after it has been cleaned and filtered. *
///            **WINBIO_DATA_FLAG_PROCESSED** Return the sample after it is ready to be used for the purpose specified by the
///            Purpose parameter.
///    UnitId = A pointer to a <b>WINBIO_UNIT_ID</b> value that contains the ID of the biometric unit that generated the sample.
///    Sample = Address of a variable that receives a pointer to a WINBIO_BIR structure that contains the sample. When you have
///             finished using the structure, you must pass the pointer to WinBioFree to release the memory allocated for the
///             sample.
///    SampleSize = A pointer to a <b>SIZE_T</b> value that contains the size, in bytes, of the WINBIO_BIR structure returned in the
///                 <i>Sample</i> parameter.
///    RejectDetail = A pointer to a <b>WINBIO_REJECT_DETAIL</b> value that contains additional information about the failure to
///                   capture a biometric sample. If the capture succeeded, this parameter is set to zero. The following values are
///                   defined for fingerprint capture: <ul> <li><b>WINBIO_FP_TOO_HIGH</b></li> <li><b>WINBIO_FP_TOO_LOW</b></li>
///                   <li><b>WINBIO_FP_TOO_LEFT</b></li> <li><b>WINBIO_FP_TOO_RIGHT</b></li> <li><b>WINBIO_FP_TOO_FAST</b></li>
///                   <li><b>WINBIO_FP_TOO_SLOW</b></li> <li><b>WINBIO_FP_POOR_QUALITY</b></li> <li><b>WINBIO_FP_TOO_SKEWED</b></li>
///                   <li><b>WINBIO_FP_TOO_SHORT</b></li> <li><b>WINBIO_FP_MERGE_FAILURE</b></li> </ul>
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> The caller does not have
///    permission to capture raw samples, or the session was not opened by using the <b>WINBIO_FLAG_RAW</b> flag. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle
///    is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The
///    biometric unit does not support the requested operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>UnitId</i>, <i>Sample</i>, <i>SampleSize</i>, and
///    <i>RejectDetail</i> pointers cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The operation could not be completed
///    because the biometric unit is currently being used for an enrollment transaction (system pool only). </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation
///    could not be completed because a secure sensor is present in the sensor pool. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioCaptureSample(uint SessionHandle, ubyte Purpose, ubyte Flags, uint* UnitId, WINBIO_BIR** Sample, 
                            size_t* SampleSize, uint* RejectDetail);

///Captures a biometric sample asynchronously and returns the raw or processed data in a biometric information record
///(BIR). The function returns immediately to the caller, captures the sample on a separate thread, and calls into an
///application-defined callback function to update operation status. <div class="alert"><b>Important</b> <p
///class="note">We recommend that, beginning with Windows 8, you no longer use this function to start an asynchronous
///operation. Instead, do the following: <ul> <li>Implement a PWINBIO_ASYNC_COMPLETION_CALLBACK function to receive
///notice when the operation completes.</li> <li>Call the WinBioAsyncOpenSession function. Pass the address of your
///callback in the <i>CallbackRoutine</i> parameter. Pass <b>WINBIO_ASYNC_NOTIFY_CALLBACK</b> in the
///<i>NotificationMethod</i> parameter. Retrieve an asynchronous session handle.</li> <li>Use the asynchronous session
///handle to call WinBioCaptureSample. When the operation finishes, the Windows Biometric Framework will allocate and
///initialize a WINBIO_ASYNC_RESULT structure with the results and invoke your callback with a pointer to the results
///structure.</li> <li>Call WinBioFree from your callback implementation to release the WINBIO_ASYNC_RESULT structure
///after you have finished using it.</li> </ul> </div> <div> </div>
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session.
///    Purpose = A <b>WINBIO_BIR_PURPOSE</b> bitmask that specifies the intended use of the sample. This can be a bitwise
///              <b>OR</b> of the following values: <ul> <li><b>WINBIO_PURPOSE_VERIFY</b></li>
///              <li><b>WINBIO_PURPOSE_IDENTIFY</b></li> <li><b>WINBIO_PURPOSE_ENROLL</b></li>
///              <li><b>WINBIO_PURPOSE_ENROLL_FOR_VERIFICATION</b></li> <li><b>WINBIO_PURPOSE_ENROLL_FOR_IDENTIFICATION</b></li>
///              </ul>
///    Flags = A value that specifies the type of processing to be applied to the captured sample. This can be a bitwise
///            <b>OR</b> of the following security and processing level flags: * **WINBIO_DATA_FLAG_PRIVACY** Encrypt the
///            sample. * **WINBIO_DATA_FLAG_INTEGRITY** Sign the sample or protect it by using a message authentication code
///            (MAC). * **WINBIO_DATA_FLAG_SIGNED** If this flag and the WINBIO_DATA_FLAG_INTEGRITYflag are set, sign the
///            sample. If this flag is not set but the WINBIO_DATA_FLAG_INTEGRITY flag is set, compute a MAC. *
///            **WINBIO_DATA_FLAG_RAW** Return the sample exactly as it was captured by the sensor. *
///            **WINBIO_DATA_FLAG_INTERMEDIATE** Return the sample after it has been cleaned and filtered. *
///            **WINBIO_DATA_FLAG_PROCESSED** Return the sample after it is ready to be used for the purpose specified by the
///            <mark type="param">Purpose</mark> parameter.
///    CaptureCallback = Address of a callback function that will be called by the <b>WinBioCaptureSampleWithCallback</b> function when
///                      the capture operation succeeds or fails. You must create the callback.
///    CaptureCallbackContext = Address of an application-defined data structure that is passed to the callback function in its
///                             <i>CaptureCallbackContext</i> parameter. This structure can contain any data that the custom callback function is
///                             designed to handle.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> The caller does not have
///    permission to capture raw samples, or the session was not opened by using the <b>WINBIO_FLAG_RAW</b> flag. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle
///    is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The
///    biometric unit does not support the requested operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>UnitId</i>, <i>Sample</i>, <i>SampleSize</i>, and
///    <i>RejectDetail</i> pointers cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The operation could not be completed
///    because the biometric unit is currently being used for an enrollment transaction (system pool only). </td> </tr>
///    </table>
///    
@DllImport("winbio")
HRESULT WinBioCaptureSampleWithCallback(uint SessionHandle, ubyte Purpose, ubyte Flags, 
                                        PWINBIO_CAPTURE_CALLBACK CaptureCallback, void* CaptureCallbackContext);

///Deletes a biometric template from the template store. Starting with Windows 10, build 1607, this function is
///available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    UnitId = A <b>WINBIO_UNIT_ID</b> value that identifies the biometric unit where the template is located.
///    Identity = Pointer to a WINBIO_IDENTITY structure that contains the GUID or SID of the template to be deleted. If the
///               <b>Type</b> member of the <b>WINBIO_IDENTITY</b> structure is <b>WINBIO_ID_TYPE_WILDCARD</b>, templates matching
///               the <i>SubFactor</i> parameter will be deleted for all identities. Only administrators can perform wildcard
///               identity deletion.
///    SubFactor = A <b>WINBIO_BIOMETRIC_SUBTYPE</b> value that provides additional information about the template to be deleted. If
///                you specify WINBIO_SUBTYPE_ANY, all templates for the biometric unit specified by the <i>UnitId</i> parameter are
///                deleted.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%">
///    The <i>UnitId</i> parameter contains zero or the <i>SubFactor</i> contains WINBIO_SUBTYPE_NO_INFORMATION. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The pointer
///    specified in the <i>Identity</i> parameter cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The operation could not be completed
///    because the biometric unit is currently being used for an enrollment transaction. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioDeleteTemplate(uint SessionHandle, uint UnitId, WINBIO_IDENTITY* Identity, ubyte SubFactor);

///Locks a biometric unit for exclusive use by a single session. Starting with Windows 10, build 1607, this function is
///available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    UnitId = A <b>WINBIO_UNIT_ID</b> value that specifies the biometric unit to be locked.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%">
///    The <i>UnitId</i> parameter cannot contain zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The operation could not be completed
///    because the specified biometric unit is currently being used for an enrollment transaction (system pool only).
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_LOCK_VIOLATION</b></b></dt> </dl> </td> <td
///    width="60%"> The biometric unit cannot be locked because the specified session already has another unit locked.
///    </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioLockUnit(uint SessionHandle, uint UnitId);

///Releases the session lock on the specified biometric unit.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    UnitId = A <b>WINBIO_UNIT_ID</b> value that specifies the biometric unit to unlock.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%">
///    The <i>UnitId</i> parameter cannot contain zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_LOCK_VIOLATION</b></b></dt> </dl> </td> <td width="60%"> The biometric unit specified by the
///    <i>UnitId</i> parameter is not currently locked by the session. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioUnlockUnit(uint SessionHandle, uint UnitId);

///Allows the caller to perform vendor-defined control operations on a biometric unit. Starting with Windows 10, build
///1607, this function is available to use with a mobile image. This function is provided for access to extended vendor
///operations for which elevated privileges are not required. If access rights are required, call the
///WinBioControlUnitPrivileged function.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    UnitId = A <b>WINBIO_UNIT_ID</b> value that identifies the biometric unit. This value must correspond to the unit ID used
///             previously in the WinBioLockUnit function.
///    Component = A <b>WINBIO_COMPONENT</b> value that specifies the component within the biometric unit that should perform the
///                operation. This can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="WINBIO_COMPONENT_SENSOR"></a><a id="winbio_component_sensor"></a><dl>
///                <dt><b>WINBIO_COMPONENT_SENSOR</b></dt> </dl> </td> <td width="60%"> Send the command to the sensor adapter.
///                </td> </tr> <tr> <td width="40%"><a id="WINBIO_COMPONENT_ENGINE"></a><a id="winbio_component_engine"></a><dl>
///                <dt><b>WINBIO_COMPONENT_ENGINE</b></dt> </dl> </td> <td width="60%"> Send the command to the engine adapter.
///                </td> </tr> <tr> <td width="40%"><a id="WINBIO_COMPONENT_STORAGE"></a><a id="winbio_component_storage"></a><dl>
///                <dt><b>WINBIO_COMPONENT_STORAGE</b></dt> </dl> </td> <td width="60%"> Send the command to the storage adapter.
///                </td> </tr> </table>
///    ControlCode = A vendor-defined code recognized by the biometric unit specified by the <i>UnitId</i> parameter and the adapter
///                  specified by the <i>Component</i> parameter.
///    SendBuffer = Address of the buffer that contains the control information to be sent to the adapter specified by the
///                 <i>Component</i> parameter. The format and content of the buffer is vendor-defined.
///    SendBufferSize = Size, in bytes, of the buffer specified by the <i>SendBuffer</i> parameter.
///    ReceiveBuffer = Address of the buffer that receives information sent by the adapter specified by the <i>Component</i> parameter.
///                    The format and content of the buffer is vendor-defined.
///    ReceiveBufferSize = Size, in bytes, of the buffer specified by the <i>ReceiveBuffer</i> parameter.
///    ReceiveDataSize = Pointer to a <b>SIZE_T</b> value that contains the size, in bytes, of the data written to the buffer specified by
///                      the <i>ReceiveBuffer</i> parameter.
///    OperationStatus = Pointer to an integer that contains a vendor-defined status code that specifies the outcome of the control
///                      operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%">
///    The value specified in the <i>ControlCode</i> parameter is not recognized. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The <i>SendBuffer</i>, <i>ReceiveBuffer</i>,
///    <i>ReceiveDataSize</i>, <i>OperationStatus</i> parameters cannot be <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b><b>WINBIO_E_INVALID_CONTROL_CODE</b></b></dt> </dl> </td> <td width="60%"> The value
///    specified in the <i>ControlCode</i> parameter is not recognized. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_LOCK_VIOLATION</b></b></dt> </dl> </td> <td width="60%"> The biometric unit specified by the
///    <i>UnitId</i> parameter must be locked before any control operations can be performed. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioControlUnit(uint SessionHandle, uint UnitId, uint Component, uint ControlCode, char* SendBuffer, 
                          size_t SendBufferSize, char* ReceiveBuffer, size_t ReceiveBufferSize, 
                          size_t* ReceiveDataSize, uint* OperationStatus);

///Allows the caller to perform privileged vendor-defined control operations on a biometric unit. Starting with Windows
///10, build 1607, this function is available to use with a mobile image. The client must call this function to perform
///extended vendor operations that require elevated access rights. If no privileges are required, the client can call
///the WinBioControlUnit function.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    UnitId = A <b>WINBIO_UNIT_ID</b> value that identifies the biometric unit. This value must correspond to the unit ID used
///             previously in the WinBioLockUnit function.
///    Component = A <b>WINBIO_COMPONENT</b> value that specifies the component within the biometric unit that should perform the
///                operation. This can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="WINBIO_COMPONENT_SENSOR"></a><a id="winbio_component_sensor"></a><dl>
///                <dt><b>WINBIO_COMPONENT_SENSOR</b></dt> </dl> </td> <td width="60%"> Send the command to the sensor adapter.
///                </td> </tr> <tr> <td width="40%"><a id="WINBIO_COMPONENT_ENGINE"></a><a id="winbio_component_engine"></a><dl>
///                <dt><b>WINBIO_COMPONENT_ENGINE</b></dt> </dl> </td> <td width="60%"> Send the command to the engine adapter.
///                </td> </tr> <tr> <td width="40%"><a id="WINBIO_COMPONENT_STORAGE"></a><a id="winbio_component_storage"></a><dl>
///                <dt><b>WINBIO_COMPONENT_STORAGE</b></dt> </dl> </td> <td width="60%"> Send the command to the storage adapter.
///                </td> </tr> </table>
///    ControlCode = A vendor-defined code recognized by the biometric unit specified by the <i>UnitId</i> parameter and the adapter
///                  specified by the <i>Component</i> parameter.
///    SendBuffer = Address of the buffer that contains the control information to be sent to the adapter specified by the
///                 <i>Component</i> parameter. The format and content of the buffer is vendor-defined.
///    SendBufferSize = Size, in bytes, of the buffer specified by the <i>SendBuffer</i> parameter.
///    ReceiveBuffer = Address of the buffer that receives information sent by the adapter specified by the <i>Component</i> parameter.
///                    The format and content of the buffer is vendor-defined.
///    ReceiveBufferSize = Size, in bytes, of the buffer specified by the <i>ReceiveBuffer</i> parameter.
///    ReceiveDataSize = Pointer to a <b>SIZE_T</b> value that contains the size, in bytes, of the data written to the buffer specified by
///                      the <i>ReceiveBuffer</i> parameter.
///    OperationStatus = Pointer to an integer that contains a vendor-defined status code that specifies the outcome of the control
///                      operation.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%">
///    The value specified in the <i>ControlCode</i> parameter is not recognized. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The <i>SendBuffer</i>, <i>ReceiveBuffer</i>,
///    <i>ReceiveDataSize</i>, <i>OperationStatus</i> parameters cannot be <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> The caller does not have
///    permission to perform the operation, or the session was not opened by using <b>WINBIO_FLAG_MAINTENANCE</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_INVALIDARG</b></b></dt> </dl> </td> <td width="60%"> The value
///    specified in the <i>ControlCode</i> parameter is not recognized. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_LOCK_VIOLATION</b></b></dt> </dl> </td> <td width="60%"> The biometric unit specified by the
///    <i>UnitId</i> parameter must be locked before any control operations can be performed. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioControlUnitPrivileged(uint SessionHandle, uint UnitId, uint Component, uint ControlCode, 
                                    char* SendBuffer, size_t SendBufferSize, char* ReceiveBuffer, 
                                    size_t ReceiveBufferSize, size_t* ReceiveDataSize, uint* OperationStatus);

///Retrieves a session, unit, or template property. Starting with Windows 10, build 1607, this function is available to
///use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    PropertyType = A <b>WINBIO_PROPERTY_TYPE</b> value that specifies the source of the property information. Currently this must be
///                   <b>WINBIO_PROPERTY_TYPE_UNIT</b> or <b>WINBIO_PROPERTY_TYPE_ACCOUNT</b>. For more information about property
///                   types, see WINBIO_PROPERTY_TYPE Constants. The <b>WINBIO_PROPERTY_TYPE_ACCOUNT</b> value is supported starting in
///                   Windows 10.
///    PropertyId = A <b>WINBIO_PROPERTY_ID</b> value that specifies the property that you want to query. The following values are
///                 possible. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="WINBIO_PROPERTY_SAMPLE_HINT"></a><a id="winbio_property_sample_hint"></a><dl>
///                 <dt><b><b>WINBIO_PROPERTY_SAMPLE_HINT</b></b></dt> </dl> </td> <td width="60%"> Estimates the maximum number of
///                 good biometric samples that are required to complete an enrollment template. The result of the property query is
///                 returned in the buffer to which to the <i>PropertyBuffer</i> parameter points as a <b>ULONG</b> value that
///                 contains the hint. </td> </tr> <tr> <td width="40%"><a id="WINBIO_PROPERTY_EXTENDED_SENSOR_INFO_"></a><a
///                 id="winbio_property_extended_sensor_info_"></a><dl> <dt><b><b>WINBIO_PROPERTY_EXTENDED_SENSOR_INFO </b></b></dt>
///                 </dl> </td> <td width="60%"> Contains extended information about the capabilities and attributes of the sensor
///                 component that is connected to a specific biometric unit. The result of the property query is returned in the
///                 buffer to which to the <i>PropertyBuffer</i> parameter points as a WINBIO_EXTENDED_SENSOR_INFO structure. This
///                 value is supported starting in Windows 10. </td> </tr> <tr> <td width="40%"><a
///                 id="WINBIO_PROPERTY_EXTENDED_ENGINE_INFO__"></a><a id="winbio_property_extended_engine_info__"></a><dl>
///                 <dt><b><b>WINBIO_PROPERTY_EXTENDED_ENGINE_INFO </b></b></dt> </dl> </td> <td width="60%"> Contains extended
///                 information about the capabilities and attributes of the engine component that is connected to a specific
///                 biometric unit. The result of the property query is returned in the buffer to which to the <i>PropertyBuffer</i>
///                 parameter points as a WINBIO_EXTENDED_ENGINE_INFO structure. This value is supported starting in Windows 10.
///                 </td> </tr> <tr> <td width="40%"><a id="WINBIO_PROPERTY_EXTENDED_STORAGE_INFO_"></a><a
///                 id="winbio_property_extended_storage_info_"></a><dl> <dt><b><b>WINBIO_PROPERTY_EXTENDED_STORAGE_INFO
///                 </b></b></dt> </dl> </td> <td width="60%"> Contains extended information about the capabilities and attributes of
///                 the storage component that is connected to a specific biometric unit. The result of the property query is
///                 returned in the buffer to which to the <i>PropertyBuffer</i> parameter points as a WINBIO_EXTENDED_STORAGE_INFO
///                 structure. This value is supported starting in Windows 10. </td> </tr> <tr> <td width="40%"><a
///                 id="WINBIO_PROPERTY_EXTENDED_ENROLLMENT_STATUS_"></a><a id="winbio_property_extended_enrollment_status_"></a><dl>
///                 <dt><b><b>WINBIO_PROPERTY_EXTENDED_ENROLLMENT_STATUS </b></b></dt> </dl> </td> <td width="60%"> Contains extended
///                 information about the status of an enrollment that is in progress on a specific biometric unit. The result of the
///                 property query is returned in the buffer to which to the <i>PropertyBuffer</i> parameter points as a
///                 WINBIO_EXTENDED_ENROLLMENT_STATUS structure. If no enrollment is in progress on the biometric unit, the
///                 <b>TemplateStatus</b> member of the returned structure has a value of <b>WINBIO_E_INVALID_OPERATION</b>. This
///                 value is supported starting in Windows 10. </td> </tr> <tr> <td width="40%"><a
///                 id="WINBIO_PROPERTY_ANTI_SPOOF_POLICY___"></a><a id="winbio_property_anti_spoof_policy___"></a><dl>
///                 <dt><b><b>WINBIO_PROPERTY_ANTI_SPOOF_POLICY </b></b></dt> </dl> </td> <td width="60%"> Contains the values of the
///                 antispoofing policy for a specific user account. The property operation is returned in the buffer to which to the
///                 <i>PropertyBuffer</i> parameter points as a WINBIO_ANTI_SPOOF_POLICY structure. This value is supported starting
///                 in Windows 10. </td> </tr> </table> For more information about these properties, see WINBIO_PROPERTY Constants.
///    UnitId = A <b>WINBIO_UNIT_ID</b> value that identifies the biometric unit. You can find a unit identifier by calling the
///             WinBioEnumBiometricUnits or WinBioLocateSensor functions. If you specify <b>WINBIO_PROPERTY_ANTI_SPOOF_POLICY</b>
///             as the value for the <i>PropertyId</i> parameter, specify 0 for the <i>UnitId</i> parameter. If you specify any
///             other property with the <i>PropertyId</i> parameter, you cannot specify 0 for the <i>UnitId</i> parameter.
///    Identity = A WINBIO_IDENTITY structure that provides the SID of the account for which you want to get the antispoofing
///               policy, if you specify <b>WINBIO_PROPERTY_ANTI_SPOOF_POLICY</b> as the value of the <i>PropertyId</i> parameter.
///               If you specify any other value for the <i>PropertyId</i> parameter, the <i>Identity</i> parameter must be
///               <b>NULL</b>.
///    SubFactor = Reserved. This must be <b>WINBIO_SUBTYPE_NO_INFORMATION</b>.
///    PropertyBuffer = Address of a pointer to a buffer that receives the property value. For information about the contents of this
///                     buffer for different properties, see the descriptions of the property values for the <i>PropertyId</i> parameter.
///    PropertyBufferSize = Pointer to a variable that receives the size, in bytes, of the buffer pointed to by the <i>PropertyBuffer</i>
///                         parameter.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The session handle specified by the
///    <i>SessionHandle</i> parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
///    </dl> </td> <td width="60%"> The <i>Identity</i>, <i>PropertyBuffer</i>, or <i>PropertyBufferSize</i> arguments
///    cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> The <i>UnitId</i>, <i>Identity</i>, or <i>SubFactor</i> arguments are incorrect. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WINBIO_E_INVALID_PROPERTY_TYPE</b></dt> </dl> </td> <td width="60%"> The value of
///    the <i>PropertyType</i> argument is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_PROPERTY_ID</b></dt> </dl> </td> <td width="60%"> The value of the <i>PropertyId</i>
///    argument is incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_LOCK_VIOLATION</b></dt> </dl> </td>
///    <td width="60%"> The caller attempted to query a property that resides inside of a locked region. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_UNSUPPORTED_PROPERTY</b></dt> </dl> </td> <td width="60%"> The object
///    being queried does not support the specified property. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The operation could not be completed
///    because the specified biometric unit is currently being used for an enrollment transaction (system pool only).
///    </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioGetProperty(uint SessionHandle, uint PropertyType, uint PropertyId, uint UnitId, 
                          WINBIO_IDENTITY* Identity, ubyte SubFactor, void** PropertyBuffer, 
                          size_t* PropertyBufferSize);

///Sets the value of a standard property associated with a biometric session, unit, template, or account. Starting with
///Windows 10, build 1607, this function is available to use with a mobile image.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies an open biometric session. Open a synchronous session handle
///                    by calling WinBioOpenSession. Open an asynchronous session handle by calling WinBioAsyncOpenSession.
///    PropertyType = A <b>WINBIO_PROPERTY_TYPE</b> value that specifies the type of the property that you want to set. Currently this
///                   must be <b>WINBIO_PROPERTY_TYPE_ACCOUNT</b>.
///    PropertyId = A <b>WINBIO_PROPERTY_ID</b> value that specifies the property to set. Currently this must be
///                 <b>WINBIO_PROPERTY_ANTI_SPOOF_POLICY</b>. All other properties are read-only.
///    UnitId = A <b>WINBIO_UNIT_ID</b> value that identifies the biometric unit. For the
///             <b>WINBIO_PROPERTY_ANTI_SPOOF_POLICY</b> property, this value must be 0.
///    Identity = Address of a WINBIO_IDENTITY structure that specifies the account for which you want to set the property.
///    SubFactor = Reserved. This must be <b>WINBIO_SUBTYPE_NO_INFORMATION</b>.
///    PropertyBuffer = A pointer to a structure that specifies the new value for the property. This value cannot be NULL. For setting
///                     the <b>WINBIO_PROPERTY_ANTI_SPOOF_POLICY</b> property, the structure must be a WINBIO_ANTI_SPOOF_POLICY
///                     structure.
///    PropertyBufferSize = The size, in bytes, of the structure to which the <i>PropertyBuffer</i> parameter points. This value cannot be 0.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The session handle specified by the
///    <i>SessionHandle</i> parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
///    </dl> </td> <td width="60%"> The <i>Identity</i> and <i>PropertyBuffer</i> parameters cannot be <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
///    <i>PropertyType</i>, <i>PropertyId</i>, or <i>PropertyBufferSize</i> parameter cannot be 0. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WINBIO_E_INVALID_PROPERTY_TYPE</b></dt> </dl> </td> <td width="60%"> The value of the
///    <i>PropertyType</i> argument is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_INVALID_PROPERTY_ID</b></dt> </dl> </td> <td width="60%"> The value of the <i>PropertyId</i>
///    argument is incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WINBIO_E_LOCK_VIOLATION</b></dt> </dl> </td>
///    <td width="60%"> The caller attempted to set a property that resides inside of a locked region. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WINBIO_E_UNSUPPORTED_PROPERTY</b></dt> </dl> </td> <td width="60%"> The object does
///    not support the specified property. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WINBIO_E_ENROLLMENT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The operation could not be completed
///    because the specified biometric unit is currently being used for an enrollment transaction (system pool only).
///    </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioSetProperty(uint SessionHandle, uint PropertyType, uint PropertyId, uint UnitId, 
                          WINBIO_IDENTITY* Identity, ubyte SubFactor, char* PropertyBuffer, 
                          size_t PropertyBufferSize);

///Releases memory allocated for the client application by an earlier call to a Windows Biometric Framework API
///function. Starting with Windows 10, build 1607, this function is available to use with a mobile image.
///Params:
///    Address = Address of the memory block to delete.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_POINTER</b></b></dt> </dl> </td> <td width="60%"> The <i>Address</i> parameter
///    cannot be <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioFree(void* Address);

///Saves a biometric logon credential for the current user. Starting with Windows 10, build 1607, this function is
///available to use with a mobile image.
///Params:
///    Type = A WINBIO_CREDENTIAL_TYPE value that specifies the credential type. Currently, this can be
///           WINBIO_CREDENTIAL_PASSWORD.
///    Credential = A pointer to a variable length array of bytes that contains the credential. The format depends on the <i>Type</i>
///                 and <i>Format</i> parameters.
///    CredentialSize = Size, in bytes, of the value specified by the <i>Credential</i> parameter.
///    Format = A WINBIO_CREDENTIAL_FORMAT enumeration value that specifies the format of the credential. If the <i>Type</i>
///             parameter is <b>WINBIO_CREDENTIAL_PASSWORD</b>, this can be one of the following: <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WINBIO_PASSWORD_GENERIC"></a><a
///             id="winbio_password_generic"></a><dl> <dt><b>WINBIO_PASSWORD_GENERIC</b></dt> </dl> </td> <td width="60%"> The
///             credential is a plaintext <b>NULL</b>-terminated Unicode string. </td> </tr> <tr> <td width="40%"><a
///             id="WINBIO_PASSWORD_PACKED"></a><a id="winbio_password_packed"></a><dl> <dt><b>WINBIO_PASSWORD_PACKED</b></dt>
///             </dl> </td> <td width="60%"> The credential was wrapped by using the CredProtect function and packed by using the
///             CredPackAuthenticationBuffer function. This is recommended. </td> </tr> <tr> <td width="40%"><a
///             id="WINBIO_PASSWORD_PROTECTED"></a><a id="winbio_password_protected"></a><dl>
///             <dt><b>WINBIO_PASSWORD_PROTECTED</b></dt> </dl> </td> <td width="60%"> The password credential was wrapped with
///             CredProtect. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> The caller does not have
///    permission to set the credential. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_UNKNOWN_ID</b></b></dt> </dl> </td> <td width="60%"> The user has not enrolled a biometric
///    sample. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>SEC_E_LOGON_DENIED</b></b></dt> </dl> </td> <td
///    width="60%"> The credential was not valid for the current user. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_CRED_PROV_DISABLED</b></b></dt> </dl> </td> <td width="60%"> Current administrative policy
///    prohibits use of the credential provider. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioSetCredential(WINBIO_CREDENTIAL_TYPE Type, char* Credential, size_t CredentialSize, 
                            WINBIO_CREDENTIAL_FORMAT Format);

///Deletes a biometric logon credential for a specified user. Starting with Windows 10, build 1607, this function is
///available to use with a mobile image.
///Params:
///    Identity = A WINBIO_IDENTITY structure that contains the SID of the user account for which the logon credential will be
///               removed.
///    Type = A WINBIO_CREDENTIAL_TYPE value that specifies the credential type. This can be one of the following values:
///           <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WINBIO_CREDENTIAL_PASSWORD"></a><a
///           id="winbio_credential_password"></a><dl> <dt><b>WINBIO_CREDENTIAL_PASSWORD</b></dt> </dl> </td> <td width="60%">
///           The password-based credential will be deleted. </td> </tr> <tr> <td width="40%"><a
///           id="WINBIO_CREDENTIAL_ALL"></a><a id="winbio_credential_all"></a><dl> <dt><b>WINBIO_CREDENTIAL_ALL</b></dt> </dl>
///           </td> <td width="60%"> All logon credentials for the user will be deleted. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> The caller does not have
///    permission to delete the credential. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_CRED_PROV_NO_CREDENTIAL</b></b></dt> </dl> </td> <td width="60%"> The specified identity does
///    not exist or does not have any related records in the credential store. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioRemoveCredential(WINBIO_IDENTITY Identity, WINBIO_CREDENTIAL_TYPE Type);

///Removes all credentials from the store. Starting with Windows 10, build 1607, this function is available to use with
///a mobile image.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("winbio")
HRESULT WinBioRemoveAllCredentials();

///Removes all user credentials for the current domain from the store. Starting with Windows 10, build 1607, this
///function is available to use with a mobile image.
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("winbio")
HRESULT WinBioRemoveAllDomainCredentials();

///Retrieves a value that specifies whether credentials have been set for the specified user. Starting with Windows 10,
///build 1607, this function is available to use with a mobile image.
///Params:
///    Identity = A WINBIO_IDENTITY structure that contains the SID of the user account for which the credential is being queried.
///    Type = A WINBIO_CREDENTIAL_TYPE value that specifies the credential type. This can be one of the following values:
///           <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WINBIO_CREDENTIAL_PASSWORD"></a><a
///           id="winbio_credential_password"></a><dl> <dt><b>WINBIO_CREDENTIAL_PASSWORD</b></dt> </dl> </td> <td width="60%">
///           The password-based credential is checked. </td> </tr> </table>
///    CredentialState = Pointer to a WINBIO_CREDENTIAL_STATE enumeration value that specifies whether user credentials have been set.
///                      This can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                      width="40%"><a id="WINBIO_CREDENTIAL_NOT_SET"></a><a id="winbio_credential_not_set"></a><dl>
///                      <dt><b>WINBIO_CREDENTIAL_NOT_SET</b></dt> </dl> </td> <td width="60%"> A credential has not been specified. </td>
///                      </tr> <tr> <td width="40%"><a id="WINBIO_CREDENTIAL_SET"></a><a id="winbio_credential_set"></a><dl>
///                      <dt><b>WINBIO_CREDENTIAL_SET</b></dt> </dl> </td> <td width="60%"> A credential has been specified. </td> </tr>
///                      </table>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> The caller does not have
///    permission to retrieve the credential state. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_UNKNOWN_ID</b></b></dt> </dl> </td> <td width="60%"> The specified identity does not exist.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_CRED_PROV_DISABLED</b></b></dt> </dl> </td> <td
///    width="60%"> Current administrative policy prohibits use of the credential provider. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioGetCredentialState(WINBIO_IDENTITY Identity, WINBIO_CREDENTIAL_TYPE Type, 
                                 WINBIO_CREDENTIAL_STATE* CredentialState);

///The <b>WinBioLogonIdentifiedUser</b> function causes a fast user switch to the account associated with the last
///successful identification operation performed by the biometric session.
///Params:
///    SessionHandle = A <b>WINBIO_SESSION_HANDLE</b> value that identifies the biometric session that has recently performed a
///                    successful identification operation. Open the session handle by calling WinBioOpenSession.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> The caller does not have
///    permission to switch users or the biometric session is out of date. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>E_HANDLE</b></b></dt> </dl> </td> <td width="60%"> The session handle is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>S_FALSE</b></b></dt> </dl> </td> <td width="60%"> The user identified by the
///    <i>SessionHandle</i> parameter is the same as the current user. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SEC_E_LOGON_DENIED</b></dt> </dl> </td> <td width="60%"> The user could not be logged on. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b><b>WINBIO_E_CRED_PROV_DISABLED</b></b></dt> </dl> </td> <td width="60%"> Current
///    administrative policy prohibits use of the credential provider. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>WINBIO_E_FAST_USER_SWITCH_DISABLED</b></b></dt> </dl> </td> <td width="60%"> Fast user switching is not
///    enabled. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>WINBIO_E_SAS_ENABLED</b></b></dt> </dl> </td> <td
///    width="60%"> Fast user switching cannot be performed because secure logon (CTRL+ALT+DELETE) is currently enabled.
///    </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioLogonIdentifiedUser(uint SessionHandle);

///Gets information about the biometric enrollments that the specified user has on the computer. Biometric enrollments
///include enrollments for facial recognition, fingerprint scanning, iris scanning, and so on.
///Params:
///    AccountOwner = A WINBIO_IDENTITY structure for the user whose biometric enrollments you want to get. For example: <pre
///                   class="syntax" xml:space="preserve"><code>WINBIO_IDENTITY identity = {}; identity.Type = WINBIO_ID_TYPE_SID; //
///                   Move an account SID into identity.Value.AccountSid.Data. // For example, CopySid(...)</code></pre> To see the
///                   enrollments for every user on the computer, specify the <b>WINBIO_ID_TYPE_WILDCARD</b> identity type for the
///                   WINBIO_IDENTITY structure that you specify for the <i>AccountOwner</i> parameter. For example: <pre
///                   class="syntax" xml:space="preserve"><code>WINBIO_IDENTITY identity = {}; identity.Type = WINBIO_ID_TYPE_WILDCARD;
///                   </code></pre>
///    EnrolledFactors = A set of WINBIO_BIOMETRIC_TYPE flags that indicate the biometric enrollments that the specified user has on the
///                      computer. A value of 0 indicates that the user has no biometric enrollments. These enrollments represent system
///                      pool enrollments only, such as enrollments that you can use to authenticate a user for sign-in, unlock, and so
///                      on. This value does not include private pool enrollments. If you specify the wildcard identity type for the
///                      WINBIO_IDENTITY structure that you use for the <i>AccountOwner</i> parameter, this set of flags represents the
///                      combined set of enrollments for all users with accounts on the computer.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>AccountOwner</i> and
///    <i>EnrolledFactors</i> parameters cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <b>Type</b> member of the WINBIO_IDENTITY structure
///    that the <i>AccountOnwer</i> parameter specified was not <b>WINBIO_ID_TYPE_SID</b> or
///    <b>WINBIO_ID_TYPE_WILDCARD</b>, or the <b>AccountSid</b> member of the <b>WINBIO_IDENTITY</b> structure was not
///    valid. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioGetEnrolledFactors(WINBIO_IDENTITY* AccountOwner, uint* EnrolledFactors);

///Retrieves a value that specifies whether the Windows Biometric Framework is currently enabled.
///Params:
///    Value = Pointer to a Boolean value that specifies whether the Windows Biometric Framework is currently enabled.
///    Source = Pointer to a <b>WINBIO_SETTING_SOURCE_TYPE</b> value that specifics the setting source. This can be one of the
///             following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="WINBIO_SETTING_SOURCE_INVALID"></a><a id="winbio_setting_source_invalid"></a><dl>
///             <dt><b>WINBIO_SETTING_SOURCE_INVALID</b></dt> </dl> </td> <td width="60%"> The setting is not valid. </td> </tr>
///             <tr> <td width="40%"><a id="WINBIO_SETTING_SOURCE_DEFAULT"></a><a id="winbio_setting_source_default"></a><dl>
///             <dt><b>WINBIO_SETTING_SOURCE_DEFAULT</b></dt> </dl> </td> <td width="60%"> The setting originated from built-in
///             policy. </td> </tr> <tr> <td width="40%"><a id="WINBIO_SETTING_SOURCE_LOCAL"></a><a
///             id="winbio_setting_source_local"></a><dl> <dt><b>WINBIO_SETTING_SOURCE_LOCAL</b></dt> </dl> </td> <td
///             width="60%"> The setting originated in the local computer registry. </td> </tr> <tr> <td width="40%"><a
///             id="WINBIO_SETTING_SOURCE_POLICY"></a><a id="winbio_setting_source_policy"></a><dl>
///             <dt><b>WINBIO_SETTING_SOURCE_POLICY</b></dt> </dl> </td> <td width="60%"> The setting was created by Group
///             Policy. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("winbio")
void WinBioGetEnabledSetting(ubyte* Value, uint* Source);

///Retrieves a value that indicates whether users can log on by using biometric information.
///Params:
///    Value = Pointer to a Boolean value that specifies whether biometric logons are enabled.
///    Source = Pointer to a <b>WINBIO_SETTING_SOURCE_TYPE</b> value that specifics the setting source. This can be one of the
///             following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="WINBIO_SETTING_SOURCE_INVALID"></a><a id="winbio_setting_source_invalid"></a><dl>
///             <dt><b>WINBIO_SETTING_SOURCE_INVALID</b></dt> </dl> </td> <td width="60%"> The setting is not valid. </td> </tr>
///             <tr> <td width="40%"><a id="WINBIO_SETTING_SOURCE_DEFAULT"></a><a id="winbio_setting_source_default"></a><dl>
///             <dt><b>WINBIO_SETTING_SOURCE_DEFAULT</b></dt> </dl> </td> <td width="60%"> The setting originated from built-in
///             policy. </td> </tr> <tr> <td width="40%"><a id="WINBIO_SETTING_SOURCE_LOCAL"></a><a
///             id="winbio_setting_source_local"></a><dl> <dt><b>WINBIO_SETTING_SOURCE_LOCAL</b></dt> </dl> </td> <td
///             width="60%"> The setting originated in the local computer registry. </td> </tr> <tr> <td width="40%"><a
///             id="WINBIO_SETTING_SOURCE_POLICY"></a><a id="winbio_setting_source_policy"></a><dl>
///             <dt><b>WINBIO_SETTING_SOURCE_POLICY</b></dt> </dl> </td> <td width="60%"> The setting was created by Group
///             Policy. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("winbio")
void WinBioGetLogonSetting(ubyte* Value, uint* Source);

///Retrieves a value that specifies whether users can log on to a domain by using biometric information.
///Params:
///    Value = Pointer to a Boolean value that specifies whether biometric domain logons are enabled.
///    Source = Pointer to a <b>WINBIO_SETTING_SOURCE_TYPE</b> value that specifies the setting source. This can be one of the
///             following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="WINBIO_SETTING_SOURCE_INVALID"></a><a id="winbio_setting_source_invalid"></a><dl>
///             <dt><b>WINBIO_SETTING_SOURCE_INVALID</b></dt> </dl> </td> <td width="60%"> The setting is not valid. </td> </tr>
///             <tr> <td width="40%"><a id="WINBIO_SETTING_SOURCE_DEFAULT"></a><a id="winbio_setting_source_default"></a><dl>
///             <dt><b>WINBIO_SETTING_SOURCE_DEFAULT</b></dt> </dl> </td> <td width="60%"> The setting originated from built-in
///             policy. </td> </tr> <tr> <td width="40%"><a id="WINBIO_SETTING_SOURCE_LOCAL"></a><a
///             id="winbio_setting_source_local"></a><dl> <dt><b>WINBIO_SETTING_SOURCE_LOCAL</b></dt> </dl> </td> <td
///             width="60%"> The setting originated in the local computer registry. </td> </tr> <tr> <td width="40%"><a
///             id="WINBIO_SETTING_SOURCE_POLICY"></a><a id="winbio_setting_source_policy"></a><dl>
///             <dt><b>WINBIO_SETTING_SOURCE_POLICY</b></dt> </dl> </td> <td width="60%"> The setting was created by Group
///             Policy. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns S_OK. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("winbio")
void WinBioGetDomainLogonSetting(ubyte* Value, uint* Source);

///Acquires window focus.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The calling process must be
///    running under the Local System account. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioAcquireFocus();

///Releases window focus.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b> value that
///    indicates the error. Possible values include, but are not limited to, those in the following table. For a list of
///    common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The calling process must be
///    running under the Local System account. </td> </tr> </table>
///    
@DllImport("winbio")
HRESULT WinBioReleaseFocus();


