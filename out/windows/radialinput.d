// Written in the D programming language.

module windows.radialinput;

public import windows.core;
public import windows.com : HRESULT;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Interfaces

///Enables interoperability with a Universal Windows Platform (UWP) RadialController object and provides access to
///<b>RadialController</b> members for customizing the interaction experience.
@GUID("1B0535C9-57AD-45C1-9D79-AD5C34360513")
interface IRadialControllerInterop : IInspectable
{
    ///Instantiates a RadialController object and binds it to the active application.
    ///Params:
    ///    hwnd = Handle to the window of the active application.
    ///    riid = The GUID for the resource interface. The REFIID, or GUID, of the interface to the resource can be obtained by
    ///           using the __uuidof() macro. For example, __uuidof(IRadialController) will get the GUID of the interface to a
    ///           buffer resource.
    ///    ppv = Address of a pointer to a RadialController object.
    ///Returns:
    ///    If this function succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CreateForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}

///Enables interoperability with a Universal Windows Platform (UWP) RadialControllerConfiguration object and provides
///access to <b>RadialControllerConfiguration</b> members for customizing a RadialController menu.
@GUID("787CDAAC-3186-476D-87E4-B9374A7B9970")
interface IRadialControllerConfigurationInterop : IInspectable
{
    ///Retrieves a RadialControllerConfiguration object bound to the active application.
    ///Params:
    ///    hwnd = Handle to the window of the active application.
    ///    riid = The GUID of the RadialControllerConfiguration object.
    ///    ppv = Address of a pointer to a RadialControllerConfiguration object.
    ///Returns:
    ///    If this function succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
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
