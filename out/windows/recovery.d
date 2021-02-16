module windows.recovery;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsprogramming : APPLICATION_RECOVERY_CALLBACK;

extern(Windows):


// Functions

@DllImport("KERNEL32")
HRESULT RegisterApplicationRecoveryCallback(APPLICATION_RECOVERY_CALLBACK pRecoveyCallback, void* pvParameter, 
                                            uint dwPingInterval, uint dwFlags);

@DllImport("KERNEL32")
HRESULT UnregisterApplicationRecoveryCallback();

@DllImport("KERNEL32")
HRESULT RegisterApplicationRestart(const(wchar)* pwzCommandline, uint dwFlags);

@DllImport("KERNEL32")
HRESULT UnregisterApplicationRestart();

@DllImport("KERNEL32")
HRESULT GetApplicationRecoveryCallback(HANDLE hProcess, APPLICATION_RECOVERY_CALLBACK* pRecoveryCallback, 
                                       void** ppvParameter, uint* pdwPingInterval, uint* pdwFlags);

@DllImport("KERNEL32")
HRESULT GetApplicationRestartSettings(HANDLE hProcess, const(wchar)* pwzCommandline, uint* pcchSize, 
                                      uint* pdwFlags);

@DllImport("KERNEL32")
HRESULT ApplicationRecoveryInProgress(int* pbCancelled);

@DllImport("KERNEL32")
void ApplicationRecoveryFinished(BOOL bSuccess);


