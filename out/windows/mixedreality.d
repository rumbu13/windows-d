module windows.mixedreality;

public import windows.core;
public import windows.com : HRESULT;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Interfaces

@GUID("5C4EE536-6A98-4B86-A170-587013D6FD4B")
interface ISpatialInteractionManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND window, const(GUID)* riid, void** spatialInteractionManager);
}

@GUID("5C4EE536-6A98-4B86-A170-587013D6FD4B")
interface IHolographicSpaceInterop : IInspectable
{
    HRESULT CreateForWindow(HWND window, const(GUID)* riid, void** holographicSpace);
}


// GUIDs


const GUID IID_IHolographicSpaceInterop          = GUIDOF!IHolographicSpaceInterop;
const GUID IID_ISpatialInteractionManagerInterop = GUIDOF!ISpatialInteractionManagerInterop;
