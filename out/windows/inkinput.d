module windows.inkinput;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum : int
{
    USE_SYSTEM_COLORS_WHEN_NECESSARY = 0x00000000,
    USE_SYSTEM_COLORS                = 0x00000001,
    USE_ORIGINAL_COLORS              = 0x00000002,
}
alias __MIDL___MIDL_itf_inkrenderer_0000_0000_0001 = int;

// Interfaces

@GUID("062584A6-F830-4BDC-A4D2-0A10AB062B1D")
struct InkDesktopHost;

@GUID("4044E60C-7B01-4671-A97C-04E0210A07A5")
struct InkD2DRenderer;

@GUID("FABEA3FC-B108-45B6-A9FC-8D08FA9F85CF")
interface IInkCommitRequestHandler : IUnknown
{
    HRESULT OnCommitRequested();
}

@GUID("73F3C0D9-2E8B-48F3-895E-20CBD27B723B")
interface IInkPresenterDesktop : IUnknown
{
    HRESULT SetRootVisual(IUnknown rootVisual, IUnknown device);
    HRESULT SetCommitRequestHandler(IInkCommitRequestHandler handler);
    HRESULT GetSize(float* width, float* height);
    HRESULT SetSize(float width, float height);
    HRESULT OnHighContrastChanged();
}

@GUID("CCDA0A9A-1B78-4632-BB96-97800662E26C")
interface IInkHostWorkItem : IUnknown
{
    HRESULT Invoke();
}

@GUID("4CE7D875-A981-4140-A1FF-AD93258E8D59")
interface IInkDesktopHost : IUnknown
{
    HRESULT QueueWorkItem(IInkHostWorkItem workItem);
    HRESULT CreateInkPresenter(const(GUID)* riid, void** ppv);
    HRESULT CreateAndInitializeInkPresenter(IUnknown rootVisual, float width, float height, const(GUID)* riid, 
                                            void** ppv);
}

@GUID("407FB1DE-F85A-4150-97CF-B7FB274FB4F8")
interface IInkD2DRenderer : IUnknown
{
    HRESULT Draw(IUnknown pD2D1DeviceContext, IUnknown pInkStrokeIterable, BOOL fHighContrast);
}

@GUID("0A95DCD9-4578-4B71-B20B-BF664D4BFEEE")
interface IInkD2DRenderer2 : IUnknown
{
    HRESULT Draw(IUnknown pD2D1DeviceContext, IUnknown pInkStrokeIterable, 
                 __MIDL___MIDL_itf_inkrenderer_0000_0000_0001 highContrastAdjustment);
}


// GUIDs

const GUID CLSID_InkD2DRenderer = GUIDOF!InkD2DRenderer;
const GUID CLSID_InkDesktopHost = GUIDOF!InkDesktopHost;

const GUID IID_IInkCommitRequestHandler = GUIDOF!IInkCommitRequestHandler;
const GUID IID_IInkD2DRenderer          = GUIDOF!IInkD2DRenderer;
const GUID IID_IInkD2DRenderer2         = GUIDOF!IInkD2DRenderer2;
const GUID IID_IInkDesktopHost          = GUIDOF!IInkDesktopHost;
const GUID IID_IInkHostWorkItem         = GUIDOF!IInkHostWorkItem;
const GUID IID_IInkPresenterDesktop     = GUIDOF!IInkPresenterDesktop;
