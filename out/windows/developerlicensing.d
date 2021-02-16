module windows.developerlicensing;

public import windows.core;
public import windows.com : HRESULT;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Functions

@DllImport("WSClient")
HRESULT CheckDeveloperLicense(FILETIME* pExpiration);

@DllImport("WSClient")
HRESULT AcquireDeveloperLicense(HWND hwndParent, FILETIME* pExpiration);

@DllImport("WSClient")
HRESULT RemoveDeveloperLicense(HWND hwndParent);


