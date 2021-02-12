module windows.windowssetupandmigration;

public import windows.systemservices;

extern(Windows):

alias OOBE_COMPLETED_CALLBACK = extern(Windows) void function(void* CallbackContext);
@DllImport("KERNEL32.dll")
BOOL OOBEComplete(int* isOOBEComplete);

@DllImport("KERNEL32.dll")
BOOL RegisterWaitUntilOOBECompleted(OOBE_COMPLETED_CALLBACK OOBECompletedCallback, void* CallbackContext, void** WaitHandle);

@DllImport("KERNEL32.dll")
BOOL UnregisterWaitUntilOOBECompleted(void* WaitHandle);

