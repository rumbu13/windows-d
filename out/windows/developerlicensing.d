module windows.developerlicensing;

public import windows.com;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

@DllImport("WSClient.dll")
HRESULT CheckDeveloperLicense(FILETIME* pExpiration);

@DllImport("WSClient.dll")
HRESULT AcquireDeveloperLicense(HWND hwndParent, FILETIME* pExpiration);

@DllImport("WSClient.dll")
HRESULT RemoveDeveloperLicense(HWND hwndParent);

