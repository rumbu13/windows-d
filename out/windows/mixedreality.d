// Written in the D programming language.

module windows.mixedreality;

public import windows.core;
public import windows.com : HRESULT;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Interfaces

///Enables interoperability with a Univeral Windows Platform (UWP)
///[SpatialInteractionManager](/uwp/api/windows.ui.input.spatial.spatialinteractionmanager) object, and provides access
///to **SpatialInteractionManager** members for accessing user input from hands, motion controllers, and system voice
///commands.
@GUID("5C4EE536-6A98-4B86-A170-587013D6FD4B")
interface ISpatialInteractionManagerInterop : IInspectable
{
    ///Retrieves a [SpatialInteractionManager](/uwp/api/windows.ui.input.spatial.spatialinteractionmanager) object bound
    ///to the active application.
    ///Params:
    ///    window = Type: [HWND](/windows/desktop/winprog/windows-data-types) Handle to the window of the active application.
    ///    riid = Type: **REFIID** The GUID of the
    ///           [SpatialInteractionManager](/uwp/api/windows.ui.input.spatial.spatialinteractionmanager) object.
    ///    spatialInteractionManager = Type: **void\*\*** Address of a pointer to a
    ///                                [SpatialInteractionManager](/uwp/api/windows.ui.input.spatial.spatialinteractionmanager) object.
    ///Returns:
    ///    Type: **HRESULT** If this function succeeds, it returns **S_OK**. Otherwise, it returns an **HRESULT** error
    ///    code.
    ///    
    HRESULT GetForWindow(HWND window, const(GUID)* riid, void** spatialInteractionManager);
}

///Enables interoperability with a Univeral Windows Platform (UWP)
///[HolographicSpace](/uwp/api/windows.graphics.holographic.holographicspace) object, and provides access to
///**HolographicSpace** members for representing a holographic scene.
@GUID("5C4EE536-6A98-4B86-A170-587013D6FD4B")
interface IHolographicSpaceInterop : IInspectable
{
    ///Instantiates a [HolographicSpace](/uwp/api/windows.graphics.holographic.holographicspace) object, and binds it to
    ///the current application.
    ///Params:
    ///    window = Type: [HWND](/windows/desktop/winprog/windows-data-types) Handle to the window of the active application.
    ///    riid = Type: **REFIID** The RUID for the resource interface. The REFIID, or GUID, of the interface to the resource
    ///           can be obtained by using the __uuidof() macro. For example, __uuidof(IRadialController) will get the GUID of
    ///           the interface to a buffer resource.
    ///    holographicSpace = Type: **void\*\*** Address of a pointer to a
    ///                       [HolographicSpace](/uwp/api/windows.graphics.holographic.holographicspace) object.
    ///Returns:
    ///    Type: **HRESULT** If this function succeeds, it returns **S_OK**. Otherwise, it returns an **HRESULT** error
    ///    code.
    ///    
    HRESULT CreateForWindow(HWND window, const(GUID)* riid, void** holographicSpace);
}


// GUIDs


const GUID IID_IHolographicSpaceInterop          = GUIDOF!IHolographicSpaceInterop;
const GUID IID_ISpatialInteractionManagerInterop = GUIDOF!ISpatialInteractionManagerInterop;
