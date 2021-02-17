// Written in the D programming language.

module windows.windowssetupandmigration;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows):


// Callbacks

///Application-defined callback function used with the RegisterWaitUntilOOBECompleted function.
///Params:
///    CallbackContext = Pointer to the callback context. This is the value passed to the RegisterWaitUntilOOBECompleted function as the
///                      <i>CallbackContext</i> parameter.
alias OOBE_COMPLETED_CALLBACK = void function(void* CallbackContext);

// Functions

///Determines whether OOBE (Windows Welcome) has been completed.
///Params:
///    isOOBEComplete = Pointer to a variable that will receive the completion of OOBE upon success.
@DllImport("KERNEL32")
BOOL OOBEComplete(int* isOOBEComplete);

///Registers a callback to be called once OOBE (Windows Welcome) has been completed.
///Params:
///    OOBECompletedCallback = Pointer to an application-defined callback function that will be called upon completion of OOBE. For more
///                            information, see OOBE_COMPLETED_CALLBACK.
///    CallbackContext = Pointer to the callback context. This value will be passed to the function specified by
///                      <i>OOBECompletedCallback</i>. This value can be <b>nulll</b>.
///    WaitHandle = Pointer to a variable that will receive the handle to the wait callback registration.
///Returns:
///    <b>TRUE</b> if the routine successfully registered the callback. Otherwise, <b>FALSE</b> is returned. If
///    <b>FALSE</b>, GetLastError will retrieve extended error information.
///    
@DllImport("KERNEL32")
BOOL RegisterWaitUntilOOBECompleted(OOBE_COMPLETED_CALLBACK OOBECompletedCallback, void* CallbackContext, 
                                    void** WaitHandle);

///Unregisters the callback previously registered via RegisterWaitUntilOOBECompleted.
///Params:
///    WaitHandle = Handle to be unregistered.
@DllImport("KERNEL32")
BOOL UnregisterWaitUntilOOBECompleted(void* WaitHandle);


