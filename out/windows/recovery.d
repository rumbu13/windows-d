module windows.recovery;

public import windows.com;
public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

@DllImport("KERNEL32.dll")
HRESULT RegisterApplicationRecoveryCallback(APPLICATION_RECOVERY_CALLBACK pRecoveyCallback, void* pvParameter, uint dwPingInterval, uint dwFlags);

@DllImport("KERNEL32.dll")
HRESULT UnregisterApplicationRecoveryCallback();

@DllImport("KERNEL32.dll")
HRESULT RegisterApplicationRestart(const(wchar)* pwzCommandline, uint dwFlags);

@DllImport("KERNEL32.dll")
HRESULT UnregisterApplicationRestart();

@DllImport("KERNEL32.dll")
HRESULT GetApplicationRecoveryCallback(HANDLE hProcess, APPLICATION_RECOVERY_CALLBACK* pRecoveryCallback, void** ppvParameter, uint* pdwPingInterval, uint* pdwFlags);

@DllImport("KERNEL32.dll")
HRESULT GetApplicationRestartSettings(HANDLE hProcess, const(wchar)* pwzCommandline, uint* pcchSize, uint* pdwFlags);

@DllImport("KERNEL32.dll")
HRESULT ApplicationRecoveryInProgress(int* pbCancelled);

@DllImport("KERNEL32.dll")
void ApplicationRecoveryFinished(BOOL bSuccess);

