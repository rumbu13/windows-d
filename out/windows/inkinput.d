// Written in the D programming language.

module windows.inkinput;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;

extern(Windows) @nogc nothrow:


// Enums


alias __MIDL___MIDL_itf_inkrenderer_0000_0000_0001 = int;
enum : int
{
    USE_SYSTEM_COLORS_WHEN_NECESSARY = 0x00000000,
    USE_SYSTEM_COLORS                = 0x00000001,
    USE_ORIGINAL_COLORS              = 0x00000002,
}

// Interfaces

@GUID("062584A6-F830-4BDC-A4D2-0A10AB062B1D")
struct InkDesktopHost;

@GUID("4044E60C-7B01-4671-A97C-04E0210A07A5")
struct InkD2DRenderer;

///An <b>IInkCommitRequestHandler</b> object enables the app (instead of an IInkPresenterDesktop object) to commit all
///pending Microsoft DirectComposition commands to the app's DirectComposition visual tree.
@GUID("FABEA3FC-B108-45B6-A9FC-8D08FA9F85CF")
interface IInkCommitRequestHandler : IUnknown
{
    ///Requests that the app commit all pending Microsoft DirectComposition commands to the app's DirectComposition
    ///visual tree.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT OnCommitRequested();
}

///An <b>IInkPresenterDesktop</b> object represents an InkPresenter that can be configured and inserted into the
///DirectComposition visual tree of the Classic Windows app.
@GUID("73F3C0D9-2E8B-48F3-895E-20CBD27B723B")
interface IInkPresenterDesktop : IUnknown
{
    ///Sets the connection to the app's DirectComposition visual tree.
    ///Params:
    ///    rootVisual = The app's DirectComposition visual tree.
    ///    device = NULL for default ink rendering, or an IDCompositionDevice3 object used to commit all pending
    ///             DirectComposition commands for custom drying of ink input to the app's DirectComposition visual tree.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetRootVisual(IUnknown rootVisual, IUnknown device);
    ///Sets an IInkCommitRequestHandler object that enables the app (instead of an IInkPresenterDesktop object) to
    ///commit all pending Microsoft DirectComposition commands to the app's DirectComposition visual tree. This supports
    ///a custom drying mode and synchronizes the transition of "wet" ink from the IInkPresenterDesktop object to "dry"
    ///ink in the app's DirectComposition visual tree.
    ///Params:
    ///    handler = The IInkCommitRequestHandler that processes the ink input.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetCommitRequestHandler(IInkCommitRequestHandler handler);
    ///Gets the size of the InkPresenter object.
    ///Params:
    ///    width = The width of the object, in DIPs.
    ///    height = The height of the object, in DIPs.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetSize(float* width, float* height);
    ///Sets the size of the InkPresenter object.
    ///Params:
    ///    width = The width of the object, in DIPs.
    ///    height = The height of the object, in DIPs.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSize(float width, float height);
    ///Specifies a high contrast change handler. This handler is notified of changes to the high contrast system
    ///settings.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT OnHighContrastChanged();
}

///An <b>IInkHostWorkItem</b> object represents an ink operation to be executed on an IInkDesktopHost object thread.
@GUID("CCDA0A9A-1B78-4632-BB96-97800662E26C")
interface IInkHostWorkItem : IUnknown
{
    ///Executes the ink operation on an IInkDesktopHost object thread.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Invoke();
}

///An <b>IInkDesktopHost</b> object enables ink input, processing, and rendering through the creation of an app thread
///to host an IInkPresenterDesktop object and insert it into the app's DirectComposition visual tree.
@GUID("4CE7D875-A981-4140-A1FF-AD93258E8D59")
interface IInkDesktopHost : IUnknown
{
    ///Add an ink operation to a work queue for execution on the IInkDesktopHost thread. The app is responsible for
    ///synchronizing the work queue with the UI thread.
    ///Params:
    ///    workItem = An IInkHostWorkItem object representing an ink operation.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT QueueWorkItem(IInkHostWorkItem workItem);
    ///Creates an IInkPresenterDesktop object on an application thread. The IInkPresenterDesktop object can then be
    ///configured and connected to the app's DirectComposition visual tree. <div class="alert"><b>Note</b> <p
    ///class="note">Use CreateAndInitializeInkPresenter to do this in a single call. </div><div> </div>
    ///Params:
    ///    riid = A reference to the interface identifier of an IInkPresenterDesktop object.
    ///    ppv = Address of a pointer variable that receives the interface pointer identified by <i>riid</i>.
    ///Returns:
    ///    If successful, returns the requested interface pointer. Otherwise, returns <b>NULL</b>.
    ///    
    HRESULT CreateInkPresenter(const(GUID)* riid, void** ppv);
    ///Creates an IInkPresenterDesktop object on an application thread, connects it to the app's DirectComposition
    ///visual tree, and sets the size of the object.
    ///Params:
    ///    rootVisual = The IDCompositionVisual of the app.
    ///    width = The width, in pixels, of the inking area.
    ///    height = The height, in pixels, of the inking area.
    ///    riid = A reference to the interface identifier of an IInkPresenterDesktop object.
    ///    ppv = Address of a pointer variable that receives the interface pointer identified by <i>riid</i>.
    ///Returns:
    ///    If successful, returns the requested interface pointer. Otherwise, returns <b>NULL</b>.
    ///    
    HRESULT CreateAndInitializeInkPresenter(IUnknown rootVisual, float width, float height, const(GUID)* riid, 
                                            void** ppv);
}

///An <b>IInkD2DRenderer</b> object enables the rendering of ink strokes onto the designated Direct2D device context of
///a Universal Windows app, instead of the default InkCanvas control.
@GUID("407FB1DE-F85A-4150-97CF-B7FB274FB4F8")
interface IInkD2DRenderer : IUnknown
{
    ///Renders the ink stroke to the designated Direct2D device context of the app.
    ///Params:
    ///    pD2D1DeviceContext = Pointer to the designated Direct2D device context of the app.
    ///    pInkStrokeIterable = Pointer to the collection of ink strokes to render.
    ///    fHighContrast = True, if the Windows high-contrast accessibility option is currently selected. Otherwise, false. Listen for
    ///                    the HighContrastChanged event to set this value appropriately.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
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
