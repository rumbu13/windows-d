module windows.winrt;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IMarshal, IUnknown;
public import windows.direct2d : D2D_RECT_F, ID2D1DeviceContext, ID2D1Factory, ID2D1Geometry;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.dxgi : DXGI_RGBA, IDXGIDevice, IDXGISurface, IDXGISwapChain;
public import windows.mediafoundation : IMF2DBuffer2, IMFDXGIDeviceManager, IMFSample, MFVideoArea;
public import windows.pointerinput : POINTER_INFO;
public import windows.shell : INamedPropertyStore;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, HANDLE, SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : HWND;
public import windows.windowsimagingcomponent : IWICBitmap;

extern(Windows):


// Enums


enum : int
{
    ACTIVATIONTYPE_UNCATEGORIZED = 0x00000000,
    ACTIVATIONTYPE_FROM_MONIKER  = 0x00000001,
    ACTIVATIONTYPE_FROM_DATA     = 0x00000002,
    ACTIVATIONTYPE_FROM_STORAGE  = 0x00000004,
    ACTIVATIONTYPE_FROM_STREAM   = 0x00000008,
    ACTIVATIONTYPE_FROM_FILE     = 0x00000010,
}
alias ACTIVATIONTYPE = int;

enum AgileReferenceOptions : int
{
    AGILEREFERENCE_DEFAULT        = 0x00000000,
    AGILEREFERENCE_DELAYEDMARSHAL = 0x00000001,
}

enum TrustLevel : int
{
    BaseTrust    = 0x00000000,
    PartialTrust = 0x00000001,
    FullTrust    = 0x00000002,
}

enum : int
{
    CASTING_CONNECTION_ERROR_STATUS_SUCCEEDED                 = 0x00000000,
    CASTING_CONNECTION_ERROR_STATUS_DEVICE_DID_NOT_RESPOND    = 0x00000001,
    CASTING_CONNECTION_ERROR_STATUS_DEVICE_ERROR              = 0x00000002,
    CASTING_CONNECTION_ERROR_STATUS_DEVICE_LOCKED             = 0x00000003,
    CASTING_CONNECTION_ERROR_STATUS_PROTECTED_PLAYBACK_FAILED = 0x00000004,
    CASTING_CONNECTION_ERROR_STATUS_INVALID_CASTING_SOURCE    = 0x00000005,
    CASTING_CONNECTION_ERROR_STATUS_UNKNOWN                   = 0x00000006,
}
alias CASTING_CONNECTION_ERROR_STATUS = int;

enum : int
{
    CASTING_CONNECTION_STATE_DISCONNECTED  = 0x00000000,
    CASTING_CONNECTION_STATE_CONNECTED     = 0x00000001,
    CASTING_CONNECTION_STATE_RENDERING     = 0x00000002,
    CASTING_CONNECTION_STATE_DISCONNECTING = 0x00000003,
    CASTING_CONNECTION_STATE_CONNECTING    = 0x00000004,
}
alias CASTING_CONNECTION_STATE = int;

enum : int
{
    GRAPHICS_EFFECT_PROPERTY_MAPPING_UNKNOWN                = 0x00000000,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_DIRECT                 = 0x00000001,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORX                = 0x00000002,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORY                = 0x00000003,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORZ                = 0x00000004,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORW                = 0x00000005,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_RECT_TO_VECTOR4        = 0x00000006,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_RADIANS_TO_DEGREES     = 0x00000007,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLORMATRIX_ALPHA_MODE = 0x00000008,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLOR_TO_VECTOR3       = 0x00000009,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLOR_TO_VECTOR4       = 0x0000000a,
}
alias GRAPHICS_EFFECT_PROPERTY_MAPPING = int;

enum NotifyCollectionChangedAction : int
{
    NotifyCollectionChangedAction_Add     = 0x00000000,
    NotifyCollectionChangedAction_Remove  = 0x00000001,
    NotifyCollectionChangedAction_Replace = 0x00000002,
    NotifyCollectionChangedAction_Move    = 0x00000003,
    NotifyCollectionChangedAction_Reset   = 0x00000004,
}

enum TypeKind : int
{
    TypeKind_Primitive = 0x00000000,
    TypeKind_Metadata  = 0x00000001,
    TypeKind_Custom    = 0x00000002,
}

enum : int
{
    RO_INIT_SINGLETHREADED = 0x00000000,
    RO_INIT_MULTITHREADED  = 0x00000001,
}
alias RO_INIT_TYPE = int;

enum : int
{
    RO_ERROR_REPORTING_NONE                 = 0x00000000,
    RO_ERROR_REPORTING_SUPPRESSEXCEPTIONS   = 0x00000001,
    RO_ERROR_REPORTING_FORCEEXCEPTIONS      = 0x00000002,
    RO_ERROR_REPORTING_USESETERRORINFO      = 0x00000004,
    RO_ERROR_REPORTING_SUPPRESSSETERRORINFO = 0x00000008,
}
alias RO_ERROR_REPORTING_FLAGS = int;

enum : int
{
    BSOS_DEFAULT                 = 0x00000000,
    BSOS_PREFERDESTINATIONSTREAM = 0x00000001,
}
alias BSOS_OPTIONS = int;

// Constants


enum : const(wchar)*
{
    CastingSourceInfo_Property_PreferredSourceUriScheme = "PreferredSourceUriScheme",
    CastingSourceInfo_Property_CastingTypes             = "CastingTypes",
    CastingSourceInfo_Property_ProtectedMedia           = "ProtectedMedia",
}

enum : const(wchar)*
{
    InterfaceName_Windows_UI_Xaml_Interop_IBindableIterator                        = "Windows.UI.Xaml.Interop.IBindableIterator",
    InterfaceName_Windows_UI_Xaml_Interop_IBindableObservableVector                = "Windows.UI.Xaml.Interop.IBindableObservableVector",
    InterfaceName_Windows_UI_Xaml_Interop_IBindableVector                          = "Windows.UI.Xaml.Interop.IBindableVector",
    InterfaceName_Windows_UI_Xaml_Interop_IBindableVectorView                      = "Windows.UI.Xaml.Interop.IBindableVectorView",
    InterfaceName_Windows_UI_Xaml_Interop_INotifyCollectionChanged                 = "Windows.UI.Xaml.Interop.INotifyCollectionChanged",
    InterfaceName_Windows_UI_Xaml_Interop_INotifyCollectionChangedEventArgs        = "Windows.UI.Xaml.Interop.INotifyCollectionChangedEventArgs",
    InterfaceName_Windows_UI_Xaml_Interop_INotifyCollectionChangedEventArgsFactory = "Windows.UI.Xaml.Interop.INotifyCollectionChangedEventArgsFactory",
}

// Callbacks

alias PFN_PDF_CREATE_RENDERER = HRESULT function(IDXGIDevice param0, IPdfRendererNative* param1);
alias PINSPECT_HSTRING_CALLBACK = HRESULT function(void* context, size_t readAddress, uint length, char* buffer);
alias PINSPECT_HSTRING_CALLBACK2 = HRESULT function(void* context, ulong readAddress, uint length, char* buffer);
alias PINSPECT_MEMORY_CALLBACK = HRESULT function(void* context, size_t readAddress, uint length, char* buffer);

// Structs


struct EventRegistrationToken
{
    long value;
}

struct ServerInformation
{
    uint  dwServerPid;
    uint  dwServerTid;
    ulong ui64ServerAddress;
}

struct HSTRING__
{
    int unused;
}

struct HSTRING_HEADER
{
    union Reserved
    {
        void*    Reserved1;
        byte[20] Reserved2;
    }
}

struct HSTRING_BUFFER__
{
    int unused;
}

struct PDF_RENDER_PARAMS
{
    D2D_RECT_F SourceRect;
    uint       DestinationWidth;
    uint       DestinationHeight;
    DXGI_RGBA  BackgroundColor;
    ubyte      IgnoreHighContrast;
}

struct NotifyCollectionChangedEventArgs
{
}

struct TypeName
{
    ptrdiff_t Name;
    TypeKind  Kind;
}

struct __AnonymousRecord_roapi_L45_C9
{
}

struct APARTMENT_SHUTDOWN_REGISTRATION_COOKIE__
{
    int unused;
}

struct ROPARAMIIDHANDLE__
{
    int unused;
}

// Functions

@DllImport("OLE32")
HRESULT CoDecodeProxy(uint dwClientPid, ulong ui64ProxyAddress, ServerInformation* pServerInformation);

@DllImport("OLE32")
HRESULT RoGetAgileReference(AgileReferenceOptions options, const(GUID)* riid, IUnknown pUnk, 
                            IAgileReference* ppAgileReference);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
uint HSTRING_UserSize(uint* param0, uint param1, ptrdiff_t* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
ubyte* HSTRING_UserMarshal(uint* param0, ubyte* param1, ptrdiff_t* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
ubyte* HSTRING_UserUnmarshal(uint* param0, char* param1, ptrdiff_t* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
void HSTRING_UserFree(uint* param0, ptrdiff_t* param1);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
uint HSTRING_UserSize64(uint* param0, uint param1, ptrdiff_t* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
ubyte* HSTRING_UserMarshal64(uint* param0, ubyte* param1, ptrdiff_t* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
ubyte* HSTRING_UserUnmarshal64(uint* param0, char* param1, ptrdiff_t* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
void HSTRING_UserFree64(uint* param0, ptrdiff_t* param1);

@DllImport("Windows")
HRESULT PdfCreateRenderer(IDXGIDevice pDevice, IPdfRendererNative* ppRenderer);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsCreateString(char* sourceString, uint length, ptrdiff_t* string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsCreateStringReference(const(wchar)* sourceString, uint length, HSTRING_HEADER* hstringHeader, 
                                     ptrdiff_t* string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsDeleteString(ptrdiff_t string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsDuplicateString(ptrdiff_t string, ptrdiff_t* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
uint WindowsGetStringLen(ptrdiff_t string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
ushort* WindowsGetStringRawBuffer(ptrdiff_t string, uint* length);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
BOOL WindowsIsStringEmpty(ptrdiff_t string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsStringHasEmbeddedNull(ptrdiff_t string, int* hasEmbedNull);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsCompareStringOrdinal(ptrdiff_t string1, ptrdiff_t string2, int* result);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsSubstring(ptrdiff_t string, uint startIndex, ptrdiff_t* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsSubstringWithSpecifiedLength(ptrdiff_t string, uint startIndex, uint length, ptrdiff_t* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsConcatString(ptrdiff_t string1, ptrdiff_t string2, ptrdiff_t* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsReplaceString(ptrdiff_t string, ptrdiff_t stringReplaced, ptrdiff_t stringReplaceWith, 
                             ptrdiff_t* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsTrimStringStart(ptrdiff_t string, ptrdiff_t trimString, ptrdiff_t* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsTrimStringEnd(ptrdiff_t string, ptrdiff_t trimString, ptrdiff_t* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsPreallocateStringBuffer(uint length, ushort** charBuffer, ptrdiff_t* bufferHandle);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsPromoteStringBuffer(ptrdiff_t bufferHandle, ptrdiff_t* string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsDeleteStringBuffer(ptrdiff_t bufferHandle);

@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsInspectString(size_t targetHString, ushort machine, PINSPECT_HSTRING_CALLBACK callback, 
                             void* context, uint* length, size_t* targetStringAddress);

@DllImport("api-ms-win-core-winrt-string-l1-1-1")
HRESULT WindowsInspectString2(ulong targetHString, ushort machine, PINSPECT_HSTRING_CALLBACK2 callback, 
                              void* context, uint* length, ulong* targetStringAddress);

@DllImport("d3d11")
HRESULT CreateDirect3D11DeviceFromDXGIDevice(IDXGIDevice dxgiDevice, IInspectable* graphicsDevice);

@DllImport("d3d11")
HRESULT CreateDirect3D11SurfaceFromDXGISurface(IDXGISurface dgxiSurface, IInspectable* graphicsSurface);

@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoInitialize(RO_INIT_TYPE initType);

@DllImport("api-ms-win-core-winrt-l1-1-0")
void RoUninitialize();

@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoActivateInstance(ptrdiff_t activatableClassId, IInspectable* instance);

@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoRegisterActivationFactories(char* activatableClassIds, char* activationFactoryCallbacks, uint count, 
                                      ptrdiff_t* cookie);

@DllImport("api-ms-win-core-winrt-l1-1-0")
void RoRevokeActivationFactories(ptrdiff_t cookie);

@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoGetActivationFactory(ptrdiff_t activatableClassId, const(GUID)* iid, void** factory);

@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoRegisterForApartmentShutdown(IApartmentShutdown callbackObject, ulong* apartmentIdentifier, 
                                       ptrdiff_t* regCookie);

@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoUnregisterForApartmentShutdown(ptrdiff_t regCookie);

@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoGetApartmentIdentifier(ulong* apartmentIdentifier);

@DllImport("api-ms-win-core-winrt-robuffer-l1-1-0")
HRESULT RoGetBufferMarshaler(IMarshal* bufferMarshaler);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT RoGetErrorReportingFlags(uint* pflags);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT RoSetErrorReportingFlags(uint flags);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT RoResolveRestrictedErrorInfoReference(const(wchar)* reference, IRestrictedErrorInfo* ppRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT SetRestrictedErrorInfo(IRestrictedErrorInfo pRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT GetRestrictedErrorInfo(IRestrictedErrorInfo* ppRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
BOOL RoOriginateErrorW(HRESULT error, uint cchMax, const(wchar)* message);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
BOOL RoOriginateError(HRESULT error, ptrdiff_t message);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
BOOL RoTransformErrorW(HRESULT oldError, HRESULT newError, uint cchMax, const(wchar)* message);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
BOOL RoTransformError(HRESULT oldError, HRESULT newError, ptrdiff_t message);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT RoCaptureErrorContext(HRESULT hr);

@DllImport("api-ms-win-core-winrt-error-l1-1-0")
void RoFailFastWithErrorContext(HRESULT hrError);

@DllImport("api-ms-win-core-winrt-error-l1-1-1")
BOOL RoOriginateLanguageException(HRESULT error, ptrdiff_t message, IUnknown languageException);

@DllImport("api-ms-win-core-winrt-error-l1-1-1")
void RoClearError();

@DllImport("api-ms-win-core-winrt-error-l1-1-1")
HRESULT RoReportUnhandledError(IRestrictedErrorInfo pRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-1")
HRESULT RoInspectThreadErrorInfo(size_t targetTebAddress, ushort machine, 
                                 PINSPECT_MEMORY_CALLBACK readMemoryCallback, void* context, 
                                 size_t* targetErrorInfoAddress);

@DllImport("api-ms-win-core-winrt-error-l1-1-1")
HRESULT RoInspectCapturedStackBackTrace(size_t targetErrorInfoAddress, ushort machine, 
                                        PINSPECT_MEMORY_CALLBACK readMemoryCallback, void* context, uint* frameCount, 
                                        size_t* targetBackTraceAddress);

@DllImport("api-ms-win-core-winrt-error-l1-1-1")
HRESULT RoGetMatchingRestrictedErrorInfo(HRESULT hrIn, IRestrictedErrorInfo* ppRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-1")
HRESULT RoReportFailedDelegate(IUnknown punkDelegate, IRestrictedErrorInfo pRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-1")
BOOL IsErrorPropagationEnabled();

@DllImport("RoMetadata")
HRESULT MetaDataGetDispenser(const(GUID)* rclsid, const(GUID)* riid, void** ppv);

@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0")
HRESULT RoGetParameterizedTypeInstanceIID(uint nameElementCount, char* nameElements, 
                                          const(IRoMetaDataLocator) metaDataLocator, GUID* iid, ptrdiff_t* pExtra);

@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0")
void RoFreeParameterizedTypeExtra(ptrdiff_t extra);

@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0")
byte* RoParameterizedTypeExtraGetTypeSignature(ptrdiff_t extra);

@DllImport("api-ms-win-core-winrt-registration-l1-1-0")
HRESULT RoGetServerActivatableClasses(ptrdiff_t serverName, ptrdiff_t** activatableClassIds, uint* count);

@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0")
HRESULT CreateRandomAccessStreamOnFile(const(wchar)* filePath, uint accessMode, const(GUID)* riid, void** ppv);

@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0")
HRESULT CreateRandomAccessStreamOverStream(IStream stream, BSOS_OPTIONS options, const(GUID)* riid, void** ppv);

@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0")
HRESULT CreateStreamOverRandomAccessStream(IUnknown randomAccessStream, const(GUID)* riid, void** ppv);


// Interfaces

@GUID("C03F6A43-65A4-9818-987E-E0B810D2A6F2")
interface IAgileReference : IUnknown
{
    HRESULT Resolve(const(GUID)* riid, void** ppvObjectReference);
}

@GUID("A2F05A09-27A2-42B5-BC0E-AC163EF49D9B")
interface IApartmentShutdown : IUnknown
{
    void OnUninitialize(ulong ui64ApartmentIdentifier);
}

@GUID("AF86E2E0-B12D-4C6A-9C5A-D7AA65101E90")
interface IInspectable : IUnknown
{
    HRESULT GetIids(uint* iidCount, char* iids);
    HRESULT GetRuntimeClassName(ptrdiff_t* className);
    HRESULT GetTrustLevel(TrustLevel* trustLevel);
}

@GUID("D3EE12AD-3865-4362-9746-B75A682DF0E6")
interface IAccountsSettingsPaneInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** accountsSettingsPane);
    HRESULT ShowManageAccountsForWindowAsync(HWND appWindow, const(GUID)* riid, void** asyncAction);
    HRESULT ShowAddAccountForWindowAsync(HWND appWindow, const(GUID)* riid, void** asyncAction);
}

@GUID("65219584-F9CB-4AE3-81F9-A28A6CA450D9")
interface IAppServiceConnectionExtendedExecution : IUnknown
{
    HRESULT OpenForExtendedExecutionAsync(const(GUID)* riid, void** operation);
}

@GUID("152B8A3B-B9B9-4685-B56E-974847BC7545")
interface ICorrelationVectorSource : IUnknown
{
    HRESULT get_CorrelationVector(ptrdiff_t* cv);
}

@GUID("C79A6CB7-BEBD-47A6-A2AD-4D45AD79C7BC")
interface ICastingEventHandler : IUnknown
{
    HRESULT OnStateChanged(CASTING_CONNECTION_STATE newState);
    HRESULT OnError(CASTING_CONNECTION_ERROR_STATUS errorStatus, const(wchar)* errorMessage);
}

@GUID("F0A56423-A664-4FBD-8B43-409A45E8D9A1")
interface ICastingController : IUnknown
{
    HRESULT Initialize(IUnknown castingEngine, IUnknown castingSource);
    HRESULT Connect();
    HRESULT Disconnect();
    HRESULT Advise(ICastingEventHandler eventHandler, uint* cookie);
    HRESULT UnAdvise(uint cookie);
}

@GUID("45101AB7-7C3A-4BCE-9500-12C09024B298")
interface ICastingSourceInfo : IUnknown
{
    HRESULT GetController(ICastingController* controller);
    HRESULT GetProperties(INamedPropertyStore* props);
}

@GUID("5AD8CBA7-4C01-4DAC-9074-827894292D63")
interface IDragDropManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}

@GUID("75CF2C57-9195-4931-8332-F0B409E916AF")
interface IInputPaneInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** inputPane);
}

@GUID("24394699-1F2C-4EB3-8CD7-0EC1DA42A540")
interface IPlayToManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** playToManager);
    HRESULT ShowPlayToUIForWindow(HWND appWindow);
}

@GUID("9CA31010-1484-4587-B26B-DDDF9F9CAECD")
interface IPrinting3DManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** printManager);
    HRESULT ShowPrintUIForWindowAsync(HWND appWindow, const(GUID)* riid, void** asyncOperation);
}

@GUID("C5435A42-8D43-4E7B-A68A-EF311E392087")
interface IPrintManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** printManager);
    HRESULT ShowPrintUIForWindowAsync(HWND appWindow, const(GUID)* riid, void** asyncOperation);
}

@GUID("83C78B3C-D88B-4950-AA6E-22B8D22AABD3")
interface ICorrelationVectorInformation : IInspectable
{
    HRESULT get_LastCorrelationVectorForThread(ptrdiff_t* cv);
    HRESULT get_NextCorrelationVectorForThread(ptrdiff_t* cv);
    HRESULT put_NextCorrelationVectorForThread(ptrdiff_t cv);
}

@GUID("3694DBF9-8F68-44BE-8FF5-195C98EDE8A6")
interface IUIViewSettingsInterop : IInspectable
{
    HRESULT GetForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}

@GUID("1ADE314D-0E0A-40D9-824C-9A088A50059F")
interface IUserActivityInterop : IInspectable
{
    HRESULT CreateSessionForWindow(HWND window, const(GUID)* iid, void** value);
}

@GUID("C15DF8BC-8844-487A-B85B-7578E0F61419")
interface IUserActivitySourceHostInterop : IInspectable
{
    HRESULT SetActivitySourceHost(ptrdiff_t activitySourceHost);
}

@GUID("DD69F876-9699-4715-9095-E37EA30DFA1B")
interface IUserActivityRequestManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND window, const(GUID)* iid, void** value);
}

@GUID("39E050C3-4E74-441A-8DC0-B81104DF949C")
interface IUserConsentVerifierInterop : IInspectable
{
    HRESULT RequestVerificationForWindowAsync(HWND appWindow, ptrdiff_t message, const(GUID)* riid, 
                                              void** asyncOperation);
}

@GUID("F4B8E804-811E-4436-B69C-44CB67B72084")
interface IWebAuthenticationCoreManagerInterop : IInspectable
{
    HRESULT RequestTokenForWindowAsync(HWND appWindow, IInspectable request, const(GUID)* riid, void** asyncInfo);
    HRESULT RequestTokenWithWebAccountForWindowAsync(HWND appWindow, IInspectable request, IInspectable webAccount, 
                                                     const(GUID)* riid, void** asyncInfo);
}

@GUID("7D9DCD91-D277-4947-8527-07A0DAEDA94A")
interface IPdfRendererNative : IUnknown
{
    HRESULT RenderPageToSurface(IUnknown pdfPage, IDXGISurface pSurface, POINT offset, 
                                PDF_RENDER_PARAMS* pRenderParams);
    HRESULT RenderPageToDeviceContext(IUnknown pdfPage, ID2D1DeviceContext pD2DDeviceContext, 
                                      PDF_RENDER_PARAMS* pRenderParams);
}

@GUID("64338358-366A-471B-BD56-DD8EF48E439B")
interface IDisplayDeviceInterop : IUnknown
{
    HRESULT CreateSharedHandle(IInspectable pObject, const(SECURITY_ATTRIBUTES)* pSecurityAttributes, uint Access, 
                               ptrdiff_t Name, HANDLE* pHandle);
    HRESULT OpenSharedHandle(HANDLE NTHandle, GUID riid, void** ppvObj);
}

@GUID("A6BA4205-E59E-4E71-B25B-4E436D21EE3D")
interface IDisplayPathInterop : IUnknown
{
    HRESULT CreateSourcePresentationHandle(HANDLE* pValue);
    HRESULT GetSourceId(uint* pSourceId);
}

@GUID("3628E81B-3CAC-4C60-B7F4-23CE0E0C3356")
interface IGraphicsCaptureItemInterop : IUnknown
{
    HRESULT CreateForWindow(HWND window, const(GUID)* riid, void** result);
    HRESULT CreateForMonitor(ptrdiff_t monitor, const(GUID)* riid, void** result);
}

@GUID("A9B3D012-3DF2-4EE3-B8D1-8695F457D3C1")
interface IDirect3DDxgiInterfaceAccess : IUnknown
{
    HRESULT GetInterface(const(GUID)* iid, void** p);
}

@GUID("94BC8415-04EA-4B2E-AF13-4DE95AA898EB")
interface ISoftwareBitmapNative : IInspectable
{
    HRESULT GetData(const(GUID)* riid, void** ppv);
}

@GUID("C3C181EC-2914-4791-AF02-02D224A10B43")
interface ISoftwareBitmapNativeFactory : IInspectable
{
    HRESULT CreateFromWICBitmap(IWICBitmap data, BOOL forceReadOnly, const(GUID)* riid, void** ppv);
    HRESULT CreateFromMF2DBuffer2(IMF2DBuffer2 data, const(GUID)* subtype, uint width, uint height, 
                                  BOOL forceReadOnly, const(MFVideoArea)* minDisplayAperture, const(GUID)* riid, 
                                  void** ppv);
}

@GUID("20BE1E2E-930F-4746-9335-3C332F255093")
interface IAudioFrameNative : IInspectable
{
    HRESULT GetData(const(GUID)* riid, void** ppv);
}

@GUID("26BA702B-314A-4620-AAF6-7A51AA58FA18")
interface IVideoFrameNative : IInspectable
{
    HRESULT GetData(const(GUID)* riid, void** ppv);
    HRESULT GetDevice(const(GUID)* riid, void** ppv);
}

@GUID("7BD67CF8-BF7D-43E6-AF8D-B170EE0C0110")
interface IAudioFrameNativeFactory : IInspectable
{
    HRESULT CreateFromMFSample(IMFSample data, BOOL forceReadOnly, const(GUID)* riid, void** ppv);
}

@GUID("69E3693E-8E1E-4E63-AC4C-7FDC21D9731D")
interface IVideoFrameNativeFactory : IInspectable
{
    HRESULT CreateFromMFSample(IMFSample data, const(GUID)* subtype, uint width, uint height, BOOL forceReadOnly, 
                               const(MFVideoArea)* minDisplayAperture, IMFDXGIDeviceManager device, 
                               const(GUID)* riid, void** ppv);
}

@GUID("F2E9EDC1-D307-4525-9886-0FAFAA44163C")
interface ISurfaceImageSourceNative : IUnknown
{
    HRESULT SetDevice(IDXGIDevice device);
    HRESULT BeginDraw(RECT updateRect, IDXGISurface* surface, POINT* offset);
    HRESULT EndDraw();
}

@GUID("DBF2E947-8E6C-4254-9EEE-7738F71386C9")
interface IVirtualSurfaceUpdatesCallbackNative : IUnknown
{
    HRESULT UpdatesNeeded();
}

@GUID("E9550983-360B-4F53-B391-AFD695078691")
interface IVirtualSurfaceImageSourceNative : ISurfaceImageSourceNative
{
    HRESULT Invalidate(RECT updateRect);
    HRESULT GetUpdateRectCount(uint* count);
    HRESULT GetUpdateRects(char* updates, uint count);
    HRESULT GetVisibleBounds(RECT* bounds);
    HRESULT RegisterForUpdatesNeeded(IVirtualSurfaceUpdatesCallbackNative callback);
    HRESULT Resize(int newWidth, int newHeight);
}

@GUID("43BEBD4E-ADD5-4035-8F85-5608D08E9DC9")
interface ISwapChainBackgroundPanelNative : IUnknown
{
    HRESULT SetSwapChain(IDXGISwapChain swapChain);
}

@GUID("4C8798B7-1D88-4A0F-B59B-B93F600DE8C8")
interface ISurfaceImageSourceManagerNative : IUnknown
{
    HRESULT FlushAllSurfacesWithDevice(IUnknown device);
}

@GUID("54298223-41E1-4A41-9C08-02E8256864A1")
interface ISurfaceImageSourceNativeWithD2D : IUnknown
{
    HRESULT SetDevice(IUnknown device);
    HRESULT BeginDraw(const(RECT)* updateRect, const(GUID)* iid, void** updateObject, POINT* offset);
    HRESULT EndDraw();
    HRESULT SuspendDraw();
    HRESULT ResumeDraw();
}

@GUID("F92F19D2-3ADE-45A6-A20C-F6F1EA90554B")
interface ISwapChainPanelNative : IUnknown
{
    HRESULT SetSwapChain(IDXGISwapChain swapChain);
}

@GUID("D5A2F60C-37B2-44A2-937B-8D8EB9726821")
interface ISwapChainPanelNative2 : ISwapChainPanelNative
{
    HRESULT SetSwapChainHandle(HANDLE swapChainHandle);
}

@GUID("0657AF73-53FD-47CF-84FF-C8492D2A80A3")
interface IGeometrySource2DInterop : IUnknown
{
    HRESULT GetGeometry(ID2D1Geometry* value);
    HRESULT TryGetGeometryUsingFactory(ID2D1Factory factory, ID2D1Geometry* value);
}

@GUID("FD04E6E3-FE0C-4C3C-AB19-A07601A576EE")
interface ICompositionDrawingSurfaceInterop : IUnknown
{
    HRESULT BeginDraw(const(RECT)* updateRect, const(GUID)* iid, void** updateObject, POINT* updateOffset);
    HRESULT EndDraw();
    HRESULT Resize(SIZE sizePixels);
    HRESULT Scroll(const(RECT)* scrollRect, const(RECT)* clipRect, int offsetX, int offsetY);
    HRESULT ResumeDraw();
    HRESULT SuspendDraw();
}

@GUID("41E64AAE-98C0-4239-8E95-A330DD6AA18B")
interface ICompositionDrawingSurfaceInterop2 : ICompositionDrawingSurfaceInterop
{
    HRESULT CopySurface(IUnknown destinationResource, int destinationOffsetX, int destinationOffsetY, 
                        const(RECT)* sourceRectangle);
}

@GUID("A116FF71-F8BF-4C8A-9C98-70779A32A9C8")
interface ICompositionGraphicsDeviceInterop : IUnknown
{
    HRESULT GetRenderingDevice(IUnknown* value);
    HRESULT SetRenderingDevice(IUnknown value);
}

@GUID("26F496A0-7F38-45FB-88F7-FAAABE67DD59")
interface ISwapChainInterop : IUnknown
{
    HRESULT SetSwapChain(IUnknown swapChain);
}

@GUID("11F62CD1-2F9D-42D3-B05F-D6790D9E9F8E")
interface IVisualInteractionSourceInterop : IUnknown
{
    HRESULT TryRedirectForManipulation(const(POINTER_INFO)* pointerInfo);
}

@GUID("35DBF59E-E3F9-45B0-81E7-FE75F4145DC9")
interface IDesktopWindowTargetInterop : IUnknown
{
    HRESULT get_Hwnd(HWND* value);
}

@GUID("624CD4E1-D007-43B1-9C03-AF4D3E6258C4")
interface IBindableVectorChangedEventHandler : IUnknown
{
    HRESULT Invoke(IBindableObservableVector vector, IInspectable e);
}

@GUID("CA10B37C-F382-4591-8557-5E24965279B0")
interface INotifyCollectionChangedEventHandler : IUnknown
{
    HRESULT Invoke(IInspectable sender, INotifyCollectionChangedEventArgs e);
}

@GUID("036D2C08-DF29-41AF-8AA2-D774BE62BA6F")
interface IBindableIterable : IInspectable
{
    HRESULT First(IBindableIterator* result);
}

@GUID("6A1D6C07-076D-49F2-8314-F52C9C9A8331")
interface IBindableIterator : IInspectable
{
    HRESULT get_Current(IInspectable* value);
    HRESULT get_HasCurrent(ubyte* value);
    HRESULT MoveNext(ubyte* result);
}

@GUID("FE1EB536-7E7F-4F90-AC9A-474984AAE512")
interface IBindableObservableVector : IInspectable
{
    HRESULT add_VectorChanged(IBindableVectorChangedEventHandler handler, EventRegistrationToken* token);
    HRESULT remove_VectorChanged(EventRegistrationToken token);
}

@GUID("393DE7DE-6FD0-4C0D-BB71-47244A113E93")
interface IBindableVector : IInspectable
{
    HRESULT GetAt(uint index, IInspectable* result);
    HRESULT get_Size(uint* value);
    HRESULT GetView(IBindableVectorView* result);
    HRESULT IndexOf(IInspectable value, uint* index, ubyte* returnValue);
    HRESULT SetAt(uint index, IInspectable value);
    HRESULT InsertAt(uint index, IInspectable value);
    HRESULT RemoveAt(uint index);
    HRESULT Append(IInspectable value);
    HRESULT RemoveAtEnd();
    HRESULT Clear();
}

@GUID("346DD6E7-976E-4BC3-815D-ECE243BC0F33")
interface IBindableVectorView : IInspectable
{
    HRESULT GetAt(uint index, IInspectable* result);
    HRESULT get_Size(uint* value);
    HRESULT IndexOf(IInspectable value, uint* index, ubyte* returnValue);
}

@GUID("28B167D5-1A31-465B-9B25-D5C3AE686C40")
interface INotifyCollectionChanged : IInspectable
{
    HRESULT add_CollectionChanged(INotifyCollectionChangedEventHandler handler, EventRegistrationToken* token);
    HRESULT remove_CollectionChanged(EventRegistrationToken token);
}

@GUID("4CF68D33-E3F2-4964-B85E-945B4F7E2F21")
interface INotifyCollectionChangedEventArgs : IInspectable
{
    HRESULT get_Action(NotifyCollectionChangedAction* value);
    HRESULT get_NewItems(IBindableVector* value);
    HRESULT get_OldItems(IBindableVector* value);
    HRESULT get_NewStartingIndex(int* value);
    HRESULT get_OldStartingIndex(int* value);
}

@GUID("B30C3E3A-DF8D-44A5-9A38-7AC0D08CE63D")
interface INotifyCollectionChangedEventArgsFactory : IInspectable
{
    HRESULT CreateInstanceWithAllParameters(NotifyCollectionChangedAction action, IBindableVector newItems, 
                                            IBindableVector oldItems, int newIndex, int oldIndex, 
                                            IInspectable baseInterface, IInspectable* innerInterface, 
                                            INotifyCollectionChangedEventArgs* value);
}

@GUID("82BA7092-4C88-427D-A7BC-16DD93FEB67E")
interface IRestrictedErrorInfo : IUnknown
{
    HRESULT GetErrorDetails(BSTR* description, int* error, BSTR* restrictedDescription, BSTR* capabilitySid);
    HRESULT GetReference(BSTR* reference);
}

@GUID("04A2DBF3-DF83-116C-0946-0812ABF6E07D")
interface ILanguageExceptionErrorInfo : IUnknown
{
    HRESULT GetLanguageException(IUnknown* languageException);
}

@GUID("FEB5A271-A6CD-45CE-880A-696706BADC65")
interface ILanguageExceptionTransform : IUnknown
{
    HRESULT GetTransformedRestrictedErrorInfo(IRestrictedErrorInfo* restrictedErrorInfo);
}

@GUID("CBE53FB5-F967-4258-8D34-42F5E25833DE")
interface ILanguageExceptionStackBackTrace : IUnknown
{
    HRESULT GetStackBackTrace(uint maxFramesToCapture, char* stackBackTrace, uint* framesCaptured);
}

@GUID("5746E5C4-5B97-424C-B620-2822915734DD")
interface ILanguageExceptionErrorInfo2 : ILanguageExceptionErrorInfo
{
    HRESULT GetPreviousLanguageExceptionErrorInfo(ILanguageExceptionErrorInfo2* previousLanguageExceptionErrorInfo);
    HRESULT CapturePropagationContext(IUnknown languageException);
    HRESULT GetPropagationContextHead(ILanguageExceptionErrorInfo2* propagatedLanguageExceptionErrorInfoHead);
}

@GUID("905A0FEF-BC53-11DF-8C49-001E4FC686DA")
interface IBufferByteAccess : IUnknown
{
    HRESULT Buffer(ubyte** value);
}

interface IRoSimpleMetaDataBuilder
{
    HRESULT SetWinRtInterface(GUID iid);
    HRESULT SetDelegate(GUID iid);
    HRESULT SetInterfaceGroupSimpleDefault(const(wchar)* name, const(wchar)* defaultInterfaceName, 
                                           const(GUID)* defaultInterfaceIID);
    HRESULT SetInterfaceGroupParameterizedDefault(const(wchar)* name, uint elementCount, 
                                                  char* defaultInterfaceNameElements);
    HRESULT SetRuntimeClassSimpleDefault(const(wchar)* name, const(wchar)* defaultInterfaceName, 
                                         const(GUID)* defaultInterfaceIID);
    HRESULT SetRuntimeClassParameterizedDefault(const(wchar)* name, uint elementCount, 
                                                char* defaultInterfaceNameElements);
    HRESULT SetStruct(const(wchar)* name, uint numFields, char* fieldTypeNames);
    HRESULT SetEnum(const(wchar)* name, const(wchar)* baseType);
    HRESULT SetParameterizedInterface(GUID piid, uint numArgs);
    HRESULT SetParameterizedDelegate(GUID piid, uint numArgs);
}

interface IRoMetaDataLocator
{
    HRESULT Locate(const(wchar)* nameElement, IRoSimpleMetaDataBuilder metaDataDestination);
}


// GUIDs


const GUID IID_IAccountsSettingsPaneInterop             = GUIDOF!IAccountsSettingsPaneInterop;
const GUID IID_IAgileReference                          = GUIDOF!IAgileReference;
const GUID IID_IApartmentShutdown                       = GUIDOF!IApartmentShutdown;
const GUID IID_IAppServiceConnectionExtendedExecution   = GUIDOF!IAppServiceConnectionExtendedExecution;
const GUID IID_IAudioFrameNative                        = GUIDOF!IAudioFrameNative;
const GUID IID_IAudioFrameNativeFactory                 = GUIDOF!IAudioFrameNativeFactory;
const GUID IID_IBindableIterable                        = GUIDOF!IBindableIterable;
const GUID IID_IBindableIterator                        = GUIDOF!IBindableIterator;
const GUID IID_IBindableObservableVector                = GUIDOF!IBindableObservableVector;
const GUID IID_IBindableVector                          = GUIDOF!IBindableVector;
const GUID IID_IBindableVectorChangedEventHandler       = GUIDOF!IBindableVectorChangedEventHandler;
const GUID IID_IBindableVectorView                      = GUIDOF!IBindableVectorView;
const GUID IID_IBufferByteAccess                        = GUIDOF!IBufferByteAccess;
const GUID IID_ICastingController                       = GUIDOF!ICastingController;
const GUID IID_ICastingEventHandler                     = GUIDOF!ICastingEventHandler;
const GUID IID_ICastingSourceInfo                       = GUIDOF!ICastingSourceInfo;
const GUID IID_ICompositionDrawingSurfaceInterop        = GUIDOF!ICompositionDrawingSurfaceInterop;
const GUID IID_ICompositionDrawingSurfaceInterop2       = GUIDOF!ICompositionDrawingSurfaceInterop2;
const GUID IID_ICompositionGraphicsDeviceInterop        = GUIDOF!ICompositionGraphicsDeviceInterop;
const GUID IID_ICorrelationVectorInformation            = GUIDOF!ICorrelationVectorInformation;
const GUID IID_ICorrelationVectorSource                 = GUIDOF!ICorrelationVectorSource;
const GUID IID_IDesktopWindowTargetInterop              = GUIDOF!IDesktopWindowTargetInterop;
const GUID IID_IDirect3DDxgiInterfaceAccess             = GUIDOF!IDirect3DDxgiInterfaceAccess;
const GUID IID_IDisplayDeviceInterop                    = GUIDOF!IDisplayDeviceInterop;
const GUID IID_IDisplayPathInterop                      = GUIDOF!IDisplayPathInterop;
const GUID IID_IDragDropManagerInterop                  = GUIDOF!IDragDropManagerInterop;
const GUID IID_IGeometrySource2DInterop                 = GUIDOF!IGeometrySource2DInterop;
const GUID IID_IGraphicsCaptureItemInterop              = GUIDOF!IGraphicsCaptureItemInterop;
const GUID IID_IInputPaneInterop                        = GUIDOF!IInputPaneInterop;
const GUID IID_IInspectable                             = GUIDOF!IInspectable;
const GUID IID_ILanguageExceptionErrorInfo              = GUIDOF!ILanguageExceptionErrorInfo;
const GUID IID_ILanguageExceptionErrorInfo2             = GUIDOF!ILanguageExceptionErrorInfo2;
const GUID IID_ILanguageExceptionStackBackTrace         = GUIDOF!ILanguageExceptionStackBackTrace;
const GUID IID_ILanguageExceptionTransform              = GUIDOF!ILanguageExceptionTransform;
const GUID IID_INotifyCollectionChanged                 = GUIDOF!INotifyCollectionChanged;
const GUID IID_INotifyCollectionChangedEventArgs        = GUIDOF!INotifyCollectionChangedEventArgs;
const GUID IID_INotifyCollectionChangedEventArgsFactory = GUIDOF!INotifyCollectionChangedEventArgsFactory;
const GUID IID_INotifyCollectionChangedEventHandler     = GUIDOF!INotifyCollectionChangedEventHandler;
const GUID IID_IPdfRendererNative                       = GUIDOF!IPdfRendererNative;
const GUID IID_IPlayToManagerInterop                    = GUIDOF!IPlayToManagerInterop;
const GUID IID_IPrintManagerInterop                     = GUIDOF!IPrintManagerInterop;
const GUID IID_IPrinting3DManagerInterop                = GUIDOF!IPrinting3DManagerInterop;
const GUID IID_IRestrictedErrorInfo                     = GUIDOF!IRestrictedErrorInfo;
const GUID IID_ISoftwareBitmapNative                    = GUIDOF!ISoftwareBitmapNative;
const GUID IID_ISoftwareBitmapNativeFactory             = GUIDOF!ISoftwareBitmapNativeFactory;
const GUID IID_ISurfaceImageSourceManagerNative         = GUIDOF!ISurfaceImageSourceManagerNative;
const GUID IID_ISurfaceImageSourceNative                = GUIDOF!ISurfaceImageSourceNative;
const GUID IID_ISurfaceImageSourceNativeWithD2D         = GUIDOF!ISurfaceImageSourceNativeWithD2D;
const GUID IID_ISwapChainBackgroundPanelNative          = GUIDOF!ISwapChainBackgroundPanelNative;
const GUID IID_ISwapChainInterop                        = GUIDOF!ISwapChainInterop;
const GUID IID_ISwapChainPanelNative                    = GUIDOF!ISwapChainPanelNative;
const GUID IID_ISwapChainPanelNative2                   = GUIDOF!ISwapChainPanelNative2;
const GUID IID_IUIViewSettingsInterop                   = GUIDOF!IUIViewSettingsInterop;
const GUID IID_IUserActivityInterop                     = GUIDOF!IUserActivityInterop;
const GUID IID_IUserActivityRequestManagerInterop       = GUIDOF!IUserActivityRequestManagerInterop;
const GUID IID_IUserActivitySourceHostInterop           = GUIDOF!IUserActivitySourceHostInterop;
const GUID IID_IUserConsentVerifierInterop              = GUIDOF!IUserConsentVerifierInterop;
const GUID IID_IVideoFrameNative                        = GUIDOF!IVideoFrameNative;
const GUID IID_IVideoFrameNativeFactory                 = GUIDOF!IVideoFrameNativeFactory;
const GUID IID_IVirtualSurfaceImageSourceNative         = GUIDOF!IVirtualSurfaceImageSourceNative;
const GUID IID_IVirtualSurfaceUpdatesCallbackNative     = GUIDOF!IVirtualSurfaceUpdatesCallbackNative;
const GUID IID_IVisualInteractionSourceInterop          = GUIDOF!IVisualInteractionSourceInterop;
const GUID IID_IWebAuthenticationCoreManagerInterop     = GUIDOF!IWebAuthenticationCoreManagerInterop;
