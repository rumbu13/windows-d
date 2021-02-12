module windows.mixedreality;

public import system;
public import windows.com;
public import windows.winrt;
public import windows.windowsandmessaging;

extern(Windows):

const GUID IID_ISpatialInteractionManagerInterop = {0x5C4EE536, 0x6A98, 0x4B86, [0xA1, 0x70, 0x58, 0x70, 0x13, 0xD6, 0xFD, 0x4B]};
@GUID(0x5C4EE536, 0x6A98, 0x4B86, [0xA1, 0x70, 0x58, 0x70, 0x13, 0xD6, 0xFD, 0x4B]);
interface ISpatialInteractionManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND window, const(Guid)* riid, void** spatialInteractionManager);
}

const GUID IID_IHolographicSpaceInterop = {0x5C4EE536, 0x6A98, 0x4B86, [0xA1, 0x70, 0x58, 0x70, 0x13, 0xD6, 0xFD, 0x4B]};
@GUID(0x5C4EE536, 0x6A98, 0x4B86, [0xA1, 0x70, 0x58, 0x70, 0x13, 0xD6, 0xFD, 0x4B]);
interface IHolographicSpaceInterop : IInspectable
{
    HRESULT CreateForWindow(HWND window, const(Guid)* riid, void** holographicSpace);
}

