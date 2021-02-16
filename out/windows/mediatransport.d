module windows.mediatransport;

public import windows.core;
public import windows.com : HRESULT;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Interfaces

@GUID("DDB0472D-C911-4A1F-86D9-DC3D71A95F5A")
interface ISystemMediaTransportControlsInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** mediaTransportControl);
}


// GUIDs


const GUID IID_ISystemMediaTransportControlsInterop = GUIDOF!ISystemMediaTransportControlsInterop;
