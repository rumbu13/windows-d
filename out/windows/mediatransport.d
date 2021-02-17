// Written in the D programming language.

module windows.mediatransport;

public import windows.core;
public import windows.com : HRESULT;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Interfaces

///Allows an app to get an instance of the ISystemMediaTransportControls interface.
@GUID("DDB0472D-C911-4A1F-86D9-DC3D71A95F5A")
interface ISystemMediaTransportControlsInterop : IInspectable
{
    ///Gets an instance of the ISystemMediaTransportControls interface for the specified window.
    ///Params:
    ///    appWindow = The top-level app window for which the ISystemMediaTransportControls interface is retrieved.
    ///    riid = A reference to the IID of the interface to retrieve.
    ///    mediaTransportControl = The top-level app window for which the ISystemMediaTransportControls interface is retrieved.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** mediaTransportControl);
}


// GUIDs


const GUID IID_ISystemMediaTransportControlsInterop = GUIDOF!ISystemMediaTransportControlsInterop;
