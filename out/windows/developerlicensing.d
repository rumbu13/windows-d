// Written in the D programming language.

module windows.developerlicensing;

public import windows.core;
public import windows.com : HRESULT;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Functions

///Checks to see if a developer license exists.
///Params:
///    pExpiration = Indicates when the developer license expires.
///Returns:
///    Returns an HResult structure with any error codes that occurred.
///    
@DllImport("WSClient")
HRESULT CheckDeveloperLicense(FILETIME* pExpiration);

///Acquires a developer license.
///Params:
///    hwndParent = The handler to the parent window.
///    pExpiration = Indicates when the developer license expires.
///Returns:
///    Returns an HResult structure with any error codes that occurred.
///    
@DllImport("WSClient")
HRESULT AcquireDeveloperLicense(HWND hwndParent, FILETIME* pExpiration);

///Removes a developer license.
///Params:
///    hwndParent = The handler to the parent window.
///Returns:
///    Returns an HResult structure with any error codes that occurred.
///    
@DllImport("WSClient")
HRESULT RemoveDeveloperLicense(HWND hwndParent);


