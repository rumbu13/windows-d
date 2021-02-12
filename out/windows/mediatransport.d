module windows.mediatransport;

public import system;
public import windows.com;
public import windows.winrt;
public import windows.windowsandmessaging;

extern(Windows):

const GUID IID_ISystemMediaTransportControlsInterop = {0xDDB0472D, 0xC911, 0x4A1F, [0x86, 0xD9, 0xDC, 0x3D, 0x71, 0xA9, 0x5F, 0x5A]};
@GUID(0xDDB0472D, 0xC911, 0x4A1F, [0x86, 0xD9, 0xDC, 0x3D, 0x71, 0xA9, 0x5F, 0x5A]);
interface ISystemMediaTransportControlsInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(Guid)* riid, void** mediaTransportControl);
}

