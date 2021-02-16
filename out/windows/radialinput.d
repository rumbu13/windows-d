module windows.radialinput;

public import windows.core;
public import windows.com : HRESULT;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Interfaces

@GUID("1B0535C9-57AD-45C1-9D79-AD5C34360513")
interface IRadialControllerInterop : IInspectable
{
    HRESULT CreateForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}

@GUID("787CDAAC-3186-476D-87E4-B9374A7B9970")
interface IRadialControllerConfigurationInterop : IInspectable
{
    HRESULT GetForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}

@GUID("3D577EFF-4CEE-11E6-B535-001BDC06AB3B")
interface IRadialControllerIndependentInputSourceInterop : IInspectable
{
    HRESULT CreateForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}


// GUIDs


const GUID IID_IRadialControllerConfigurationInterop          = GUIDOF!IRadialControllerConfigurationInterop;
const GUID IID_IRadialControllerIndependentInputSourceInterop = GUIDOF!IRadialControllerIndependentInputSourceInterop;
const GUID IID_IRadialControllerInterop                       = GUIDOF!IRadialControllerInterop;
