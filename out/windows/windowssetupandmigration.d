module windows.windowssetupandmigration;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows):


// Callbacks

alias OOBE_COMPLETED_CALLBACK = void function(void* CallbackContext);

// Functions

@DllImport("KERNEL32")
BOOL OOBEComplete(int* isOOBEComplete);

@DllImport("KERNEL32")
BOOL RegisterWaitUntilOOBECompleted(OOBE_COMPLETED_CALLBACK OOBECompletedCallback, void* CallbackContext, 
                                    void** WaitHandle);

@DllImport("KERNEL32")
BOOL UnregisterWaitUntilOOBECompleted(void* WaitHandle);


