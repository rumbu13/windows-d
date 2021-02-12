module windows.winrt;

public import system;
public import windows.foundation;
public import windows.graphics.effects;
public import windows.ui.composition;
public import windows.ui.composition.desktop;
public import windows.automation;
public import windows.com;
public import windows.direct2d;
public import windows.displaydevices;
public import windows.dxgi;
public import windows.mediafoundation;
public import windows.pointerinput;
public import windows.shell;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsimagingcomponent;

extern(Windows):

struct EventRegistrationToken
{
    long value;
}

enum ACTIVATIONTYPE
{
    ACTIVATIONTYPE_UNCATEGORIZED = 0,
    ACTIVATIONTYPE_FROM_MONIKER = 1,
    ACTIVATIONTYPE_FROM_DATA = 2,
    ACTIVATIONTYPE_FROM_STORAGE = 4,
    ACTIVATIONTYPE_FROM_STREAM = 8,
    ACTIVATIONTYPE_FROM_FILE = 16,
}

const GUID IID_IAgileReference = {0xC03F6A43, 0x65A4, 0x9818, [0x98, 0x7E, 0xE0, 0xB8, 0x10, 0xD2, 0xA6, 0xF2]};
@GUID(0xC03F6A43, 0x65A4, 0x9818, [0x98, 0x7E, 0xE0, 0xB8, 0x10, 0xD2, 0xA6, 0xF2]);
interface IAgileReference : IUnknown
{
    HRESULT Resolve(const(Guid)* riid, void** ppvObjectReference);
}

struct ServerInformation
{
    uint dwServerPid;
    uint dwServerTid;
    ulong ui64ServerAddress;
}

enum AgileReferenceOptions
{
    AGILEREFERENCE_DEFAULT = 0,
    AGILEREFERENCE_DELAYEDMARSHAL = 1,
}

const GUID IID_IApartmentShutdown = {0xA2F05A09, 0x27A2, 0x42B5, [0xBC, 0x0E, 0xAC, 0x16, 0x3E, 0xF4, 0x9D, 0x9B]};
@GUID(0xA2F05A09, 0x27A2, 0x42B5, [0xBC, 0x0E, 0xAC, 0x16, 0x3E, 0xF4, 0x9D, 0x9B]);
interface IApartmentShutdown : IUnknown
{
    void OnUninitialize(ulong ui64ApartmentIdentifier);
}

@DllImport("OLE32.dll")
HRESULT CoDecodeProxy(uint dwClientPid, ulong ui64ProxyAddress, ServerInformation* pServerInformation);

@DllImport("OLE32.dll")
HRESULT RoGetAgileReference(AgileReferenceOptions options, const(Guid)* riid, IUnknown pUnk, IAgileReference* ppAgileReference);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
uint HSTRING_UserSize(uint* param0, uint param1, int* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
ubyte* HSTRING_UserMarshal(uint* param0, ubyte* param1, int* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
ubyte* HSTRING_UserUnmarshal(uint* param0, char* param1, int* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
void HSTRING_UserFree(uint* param0, int* param1);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
uint HSTRING_UserSize64(uint* param0, uint param1, int* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
ubyte* HSTRING_UserMarshal64(uint* param0, ubyte* param1, int* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
ubyte* HSTRING_UserUnmarshal64(uint* param0, char* param1, int* param2);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
void HSTRING_UserFree64(uint* param0, int* param1);

@DllImport("Windows.dll")
HRESULT PdfCreateRenderer(IDXGIDevice pDevice, IPdfRendererNative* ppRenderer);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsCreateString(char* sourceString, uint length, int* string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsCreateStringReference(const(wchar)* sourceString, uint length, HSTRING_HEADER* hstringHeader, int* string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsDeleteString(int string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsDuplicateString(int string, int* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
uint WindowsGetStringLen(int string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
ushort* WindowsGetStringRawBuffer(int string, uint* length);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
BOOL WindowsIsStringEmpty(int string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsStringHasEmbeddedNull(int string, int* hasEmbedNull);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsCompareStringOrdinal(int string1, int string2, int* result);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsSubstring(int string, uint startIndex, int* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsSubstringWithSpecifiedLength(int string, uint startIndex, uint length, int* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsConcatString(int string1, int string2, int* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsReplaceString(int string, int stringReplaced, int stringReplaceWith, int* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsTrimStringStart(int string, int trimString, int* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsTrimStringEnd(int string, int trimString, int* newString);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsPreallocateStringBuffer(uint length, ushort** charBuffer, int* bufferHandle);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsPromoteStringBuffer(int bufferHandle, int* string);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsDeleteStringBuffer(int bufferHandle);

@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsInspectString(uint targetHString, ushort machine, PINSPECT_HSTRING_CALLBACK callback, void* context, uint* length, uint* targetStringAddress);

@DllImport("api-ms-win-core-winrt-string-l1-1-1.dll")
HRESULT WindowsInspectString2(ulong targetHString, ushort machine, PINSPECT_HSTRING_CALLBACK2 callback, void* context, uint* length, ulong* targetStringAddress);

@DllImport("d3d11.dll")
HRESULT CreateDirect3D11DeviceFromDXGIDevice(IDXGIDevice dxgiDevice, IInspectable* graphicsDevice);

@DllImport("d3d11.dll")
HRESULT CreateDirect3D11SurfaceFromDXGISurface(IDXGISurface dgxiSurface, IInspectable* graphicsSurface);

@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoInitialize(RO_INIT_TYPE initType);

@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
void RoUninitialize();

@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoActivateInstance(int activatableClassId, IInspectable* instance);

@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoRegisterActivationFactories(char* activatableClassIds, char* activationFactoryCallbacks, uint count, int* cookie);

@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
void RoRevokeActivationFactories(int cookie);

@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoGetActivationFactory(int activatableClassId, const(Guid)* iid, void** factory);

@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoRegisterForApartmentShutdown(IApartmentShutdown callbackObject, ulong* apartmentIdentifier, int* regCookie);

@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoUnregisterForApartmentShutdown(int regCookie);

@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoGetApartmentIdentifier(ulong* apartmentIdentifier);

@DllImport("api-ms-win-core-winrt-robuffer-l1-1-0.dll")
HRESULT RoGetBufferMarshaler(IMarshal* bufferMarshaler);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT RoGetErrorReportingFlags(uint* pflags);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT RoSetErrorReportingFlags(uint flags);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT RoResolveRestrictedErrorInfoReference(const(wchar)* reference, IRestrictedErrorInfo* ppRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT SetRestrictedErrorInfo(IRestrictedErrorInfo pRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT GetRestrictedErrorInfo(IRestrictedErrorInfo* ppRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
BOOL RoOriginateErrorW(HRESULT error, uint cchMax, const(wchar)* message);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
BOOL RoOriginateError(HRESULT error, int message);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
BOOL RoTransformErrorW(HRESULT oldError, HRESULT newError, uint cchMax, const(wchar)* message);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
BOOL RoTransformError(HRESULT oldError, HRESULT newError, int message);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT RoCaptureErrorContext(HRESULT hr);

@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
void RoFailFastWithErrorContext(HRESULT hrError);

@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
BOOL RoOriginateLanguageException(HRESULT error, int message, IUnknown languageException);

@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
void RoClearError();

@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
HRESULT RoReportUnhandledError(IRestrictedErrorInfo pRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
HRESULT RoInspectThreadErrorInfo(uint targetTebAddress, ushort machine, PINSPECT_MEMORY_CALLBACK readMemoryCallback, void* context, uint* targetErrorInfoAddress);

@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
HRESULT RoInspectCapturedStackBackTrace(uint targetErrorInfoAddress, ushort machine, PINSPECT_MEMORY_CALLBACK readMemoryCallback, void* context, uint* frameCount, uint* targetBackTraceAddress);

@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
HRESULT RoGetMatchingRestrictedErrorInfo(HRESULT hrIn, IRestrictedErrorInfo* ppRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
HRESULT RoReportFailedDelegate(IUnknown punkDelegate, IRestrictedErrorInfo pRestrictedErrorInfo);

@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
BOOL IsErrorPropagationEnabled();

@DllImport("RoMetadata.dll")
HRESULT MetaDataGetDispenser(const(Guid)* rclsid, const(Guid)* riid, void** ppv);

@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0.dll")
HRESULT RoGetParameterizedTypeInstanceIID(uint nameElementCount, char* nameElements, const(IRoMetaDataLocator) metaDataLocator, Guid* iid, int* pExtra);

@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0.dll")
void RoFreeParameterizedTypeExtra(int extra);

@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0.dll")
byte* RoParameterizedTypeExtraGetTypeSignature(int extra);

@DllImport("api-ms-win-core-winrt-registration-l1-1-0.dll")
HRESULT RoGetServerActivatableClasses(int serverName, int** activatableClassIds, uint* count);

@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0.dll")
HRESULT CreateRandomAccessStreamOnFile(const(wchar)* filePath, uint accessMode, const(Guid)* riid, void** ppv);

@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0.dll")
HRESULT CreateRandomAccessStreamOverStream(IStream stream, BSOS_OPTIONS options, const(Guid)* riid, void** ppv);

@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0.dll")
HRESULT CreateStreamOverRandomAccessStream(IUnknown randomAccessStream, const(Guid)* riid, void** ppv);

struct HSTRING__
{
    int unused;
}

struct HSTRING_HEADER
{
    _Reserved_e__Union Reserved;
}

struct HSTRING_BUFFER__
{
    int unused;
}

enum TrustLevel
{
    BaseTrust = 0,
    PartialTrust = 1,
    FullTrust = 2,
}

const GUID IID_IInspectable = {0xAF86E2E0, 0xB12D, 0x4C6A, [0x9C, 0x5A, 0xD7, 0xAA, 0x65, 0x10, 0x1E, 0x90]};
@GUID(0xAF86E2E0, 0xB12D, 0x4C6A, [0x9C, 0x5A, 0xD7, 0xAA, 0x65, 0x10, 0x1E, 0x90]);
interface IInspectable : IUnknown
{
    HRESULT GetIids(uint* iidCount, char* iids);
    HRESULT GetRuntimeClassName(int* className);
    HRESULT GetTrustLevel(TrustLevel* trustLevel);
}

const GUID IID_IAccountsSettingsPaneInterop = {0xD3EE12AD, 0x3865, 0x4362, [0x97, 0x46, 0xB7, 0x5A, 0x68, 0x2D, 0xF0, 0xE6]};
@GUID(0xD3EE12AD, 0x3865, 0x4362, [0x97, 0x46, 0xB7, 0x5A, 0x68, 0x2D, 0xF0, 0xE6]);
interface IAccountsSettingsPaneInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(Guid)* riid, void** accountsSettingsPane);
    HRESULT ShowManageAccountsForWindowAsync(HWND appWindow, const(Guid)* riid, void** asyncAction);
    HRESULT ShowAddAccountForWindowAsync(HWND appWindow, const(Guid)* riid, void** asyncAction);
}

const GUID IID_IAppServiceConnectionExtendedExecution = {0x65219584, 0xF9CB, 0x4AE3, [0x81, 0xF9, 0xA2, 0x8A, 0x6C, 0xA4, 0x50, 0xD9]};
@GUID(0x65219584, 0xF9CB, 0x4AE3, [0x81, 0xF9, 0xA2, 0x8A, 0x6C, 0xA4, 0x50, 0xD9]);
interface IAppServiceConnectionExtendedExecution : IUnknown
{
    HRESULT OpenForExtendedExecutionAsync(const(Guid)* riid, void** operation);
}

const GUID IID_ICorrelationVectorSource = {0x152B8A3B, 0xB9B9, 0x4685, [0xB5, 0x6E, 0x97, 0x48, 0x47, 0xBC, 0x75, 0x45]};
@GUID(0x152B8A3B, 0xB9B9, 0x4685, [0xB5, 0x6E, 0x97, 0x48, 0x47, 0xBC, 0x75, 0x45]);
interface ICorrelationVectorSource : IUnknown
{
    HRESULT get_CorrelationVector(int* cv);
}

enum CASTING_CONNECTION_ERROR_STATUS
{
    CASTING_CONNECTION_ERROR_STATUS_SUCCEEDED = 0,
    CASTING_CONNECTION_ERROR_STATUS_DEVICE_DID_NOT_RESPOND = 1,
    CASTING_CONNECTION_ERROR_STATUS_DEVICE_ERROR = 2,
    CASTING_CONNECTION_ERROR_STATUS_DEVICE_LOCKED = 3,
    CASTING_CONNECTION_ERROR_STATUS_PROTECTED_PLAYBACK_FAILED = 4,
    CASTING_CONNECTION_ERROR_STATUS_INVALID_CASTING_SOURCE = 5,
    CASTING_CONNECTION_ERROR_STATUS_UNKNOWN = 6,
}

enum CASTING_CONNECTION_STATE
{
    CASTING_CONNECTION_STATE_DISCONNECTED = 0,
    CASTING_CONNECTION_STATE_CONNECTED = 1,
    CASTING_CONNECTION_STATE_RENDERING = 2,
    CASTING_CONNECTION_STATE_DISCONNECTING = 3,
    CASTING_CONNECTION_STATE_CONNECTING = 4,
}

const GUID IID_ICastingEventHandler = {0xC79A6CB7, 0xBEBD, 0x47A6, [0xA2, 0xAD, 0x4D, 0x45, 0xAD, 0x79, 0xC7, 0xBC]};
@GUID(0xC79A6CB7, 0xBEBD, 0x47A6, [0xA2, 0xAD, 0x4D, 0x45, 0xAD, 0x79, 0xC7, 0xBC]);
interface ICastingEventHandler : IUnknown
{
    HRESULT OnStateChanged(CASTING_CONNECTION_STATE newState);
    HRESULT OnError(CASTING_CONNECTION_ERROR_STATUS errorStatus, const(wchar)* errorMessage);
}

const GUID IID_ICastingController = {0xF0A56423, 0xA664, 0x4FBD, [0x8B, 0x43, 0x40, 0x9A, 0x45, 0xE8, 0xD9, 0xA1]};
@GUID(0xF0A56423, 0xA664, 0x4FBD, [0x8B, 0x43, 0x40, 0x9A, 0x45, 0xE8, 0xD9, 0xA1]);
interface ICastingController : IUnknown
{
    HRESULT Initialize(IUnknown castingEngine, IUnknown castingSource);
    HRESULT Connect();
    HRESULT Disconnect();
    HRESULT Advise(ICastingEventHandler eventHandler, uint* cookie);
    HRESULT UnAdvise(uint cookie);
}

const GUID IID_ICastingSourceInfo = {0x45101AB7, 0x7C3A, 0x4BCE, [0x95, 0x00, 0x12, 0xC0, 0x90, 0x24, 0xB2, 0x98]};
@GUID(0x45101AB7, 0x7C3A, 0x4BCE, [0x95, 0x00, 0x12, 0xC0, 0x90, 0x24, 0xB2, 0x98]);
interface ICastingSourceInfo : IUnknown
{
    HRESULT GetController(ICastingController* controller);
    HRESULT GetProperties(INamedPropertyStore* props);
}

const GUID IID_IDragDropManagerInterop = {0x5AD8CBA7, 0x4C01, 0x4DAC, [0x90, 0x74, 0x82, 0x78, 0x94, 0x29, 0x2D, 0x63]};
@GUID(0x5AD8CBA7, 0x4C01, 0x4DAC, [0x90, 0x74, 0x82, 0x78, 0x94, 0x29, 0x2D, 0x63]);
interface IDragDropManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND hwnd, const(Guid)* riid, void** ppv);
}

const GUID IID_IInputPaneInterop = {0x75CF2C57, 0x9195, 0x4931, [0x83, 0x32, 0xF0, 0xB4, 0x09, 0xE9, 0x16, 0xAF]};
@GUID(0x75CF2C57, 0x9195, 0x4931, [0x83, 0x32, 0xF0, 0xB4, 0x09, 0xE9, 0x16, 0xAF]);
interface IInputPaneInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(Guid)* riid, void** inputPane);
}

const GUID IID_IPlayToManagerInterop = {0x24394699, 0x1F2C, 0x4EB3, [0x8C, 0xD7, 0x0E, 0xC1, 0xDA, 0x42, 0xA5, 0x40]};
@GUID(0x24394699, 0x1F2C, 0x4EB3, [0x8C, 0xD7, 0x0E, 0xC1, 0xDA, 0x42, 0xA5, 0x40]);
interface IPlayToManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(Guid)* riid, void** playToManager);
    HRESULT ShowPlayToUIForWindow(HWND appWindow);
}

const GUID IID_IPrinting3DManagerInterop = {0x9CA31010, 0x1484, 0x4587, [0xB2, 0x6B, 0xDD, 0xDF, 0x9F, 0x9C, 0xAE, 0xCD]};
@GUID(0x9CA31010, 0x1484, 0x4587, [0xB2, 0x6B, 0xDD, 0xDF, 0x9F, 0x9C, 0xAE, 0xCD]);
interface IPrinting3DManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(Guid)* riid, void** printManager);
    HRESULT ShowPrintUIForWindowAsync(HWND appWindow, const(Guid)* riid, void** asyncOperation);
}

const GUID IID_IPrintManagerInterop = {0xC5435A42, 0x8D43, 0x4E7B, [0xA6, 0x8A, 0xEF, 0x31, 0x1E, 0x39, 0x20, 0x87]};
@GUID(0xC5435A42, 0x8D43, 0x4E7B, [0xA6, 0x8A, 0xEF, 0x31, 0x1E, 0x39, 0x20, 0x87]);
interface IPrintManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(Guid)* riid, void** printManager);
    HRESULT ShowPrintUIForWindowAsync(HWND appWindow, const(Guid)* riid, void** asyncOperation);
}

const GUID IID_ICorrelationVectorInformation = {0x83C78B3C, 0xD88B, 0x4950, [0xAA, 0x6E, 0x22, 0xB8, 0xD2, 0x2A, 0xAB, 0xD3]};
@GUID(0x83C78B3C, 0xD88B, 0x4950, [0xAA, 0x6E, 0x22, 0xB8, 0xD2, 0x2A, 0xAB, 0xD3]);
interface ICorrelationVectorInformation : IInspectable
{
    HRESULT get_LastCorrelationVectorForThread(int* cv);
    HRESULT get_NextCorrelationVectorForThread(int* cv);
    HRESULT put_NextCorrelationVectorForThread(int cv);
}

const GUID IID_IUIViewSettingsInterop = {0x3694DBF9, 0x8F68, 0x44BE, [0x8F, 0xF5, 0x19, 0x5C, 0x98, 0xED, 0xE8, 0xA6]};
@GUID(0x3694DBF9, 0x8F68, 0x44BE, [0x8F, 0xF5, 0x19, 0x5C, 0x98, 0xED, 0xE8, 0xA6]);
interface IUIViewSettingsInterop : IInspectable
{
    HRESULT GetForWindow(HWND hwnd, const(Guid)* riid, void** ppv);
}

const GUID IID_IUserActivityInterop = {0x1ADE314D, 0x0E0A, 0x40D9, [0x82, 0x4C, 0x9A, 0x08, 0x8A, 0x50, 0x05, 0x9F]};
@GUID(0x1ADE314D, 0x0E0A, 0x40D9, [0x82, 0x4C, 0x9A, 0x08, 0x8A, 0x50, 0x05, 0x9F]);
interface IUserActivityInterop : IInspectable
{
    HRESULT CreateSessionForWindow(HWND window, const(Guid)* iid, void** value);
}

const GUID IID_IUserActivitySourceHostInterop = {0xC15DF8BC, 0x8844, 0x487A, [0xB8, 0x5B, 0x75, 0x78, 0xE0, 0xF6, 0x14, 0x19]};
@GUID(0xC15DF8BC, 0x8844, 0x487A, [0xB8, 0x5B, 0x75, 0x78, 0xE0, 0xF6, 0x14, 0x19]);
interface IUserActivitySourceHostInterop : IInspectable
{
    HRESULT SetActivitySourceHost(int activitySourceHost);
}

const GUID IID_IUserActivityRequestManagerInterop = {0xDD69F876, 0x9699, 0x4715, [0x90, 0x95, 0xE3, 0x7E, 0xA3, 0x0D, 0xFA, 0x1B]};
@GUID(0xDD69F876, 0x9699, 0x4715, [0x90, 0x95, 0xE3, 0x7E, 0xA3, 0x0D, 0xFA, 0x1B]);
interface IUserActivityRequestManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND window, const(Guid)* iid, void** value);
}

const GUID IID_IUserConsentVerifierInterop = {0x39E050C3, 0x4E74, 0x441A, [0x8D, 0xC0, 0xB8, 0x11, 0x04, 0xDF, 0x94, 0x9C]};
@GUID(0x39E050C3, 0x4E74, 0x441A, [0x8D, 0xC0, 0xB8, 0x11, 0x04, 0xDF, 0x94, 0x9C]);
interface IUserConsentVerifierInterop : IInspectable
{
    HRESULT RequestVerificationForWindowAsync(HWND appWindow, int message, const(Guid)* riid, void** asyncOperation);
}

const GUID IID_IWebAuthenticationCoreManagerInterop = {0xF4B8E804, 0x811E, 0x4436, [0xB6, 0x9C, 0x44, 0xCB, 0x67, 0xB7, 0x20, 0x84]};
@GUID(0xF4B8E804, 0x811E, 0x4436, [0xB6, 0x9C, 0x44, 0xCB, 0x67, 0xB7, 0x20, 0x84]);
interface IWebAuthenticationCoreManagerInterop : IInspectable
{
    HRESULT RequestTokenForWindowAsync(HWND appWindow, IInspectable request, const(Guid)* riid, void** asyncInfo);
    HRESULT RequestTokenWithWebAccountForWindowAsync(HWND appWindow, IInspectable request, IInspectable webAccount, const(Guid)* riid, void** asyncInfo);
}

alias PFN_PDF_CREATE_RENDERER = extern(Windows) HRESULT function(IDXGIDevice param0, IPdfRendererNative* param1);
struct PDF_RENDER_PARAMS
{
    D2D_RECT_F SourceRect;
    uint DestinationWidth;
    uint DestinationHeight;
    DXGI_RGBA BackgroundColor;
    ubyte IgnoreHighContrast;
}

const GUID IID_IPdfRendererNative = {0x7D9DCD91, 0xD277, 0x4947, [0x85, 0x27, 0x07, 0xA0, 0xDA, 0xED, 0xA9, 0x4A]};
@GUID(0x7D9DCD91, 0xD277, 0x4947, [0x85, 0x27, 0x07, 0xA0, 0xDA, 0xED, 0xA9, 0x4A]);
interface IPdfRendererNative : IUnknown
{
    HRESULT RenderPageToSurface(IUnknown pdfPage, IDXGISurface pSurface, POINT offset, PDF_RENDER_PARAMS* pRenderParams);
    HRESULT RenderPageToDeviceContext(IUnknown pdfPage, ID2D1DeviceContext pD2DDeviceContext, PDF_RENDER_PARAMS* pRenderParams);
}

const GUID IID_IDisplayDeviceInterop = {0x64338358, 0x366A, 0x471B, [0xBD, 0x56, 0xDD, 0x8E, 0xF4, 0x8E, 0x43, 0x9B]};
@GUID(0x64338358, 0x366A, 0x471B, [0xBD, 0x56, 0xDD, 0x8E, 0xF4, 0x8E, 0x43, 0x9B]);
interface IDisplayDeviceInterop : IUnknown
{
    HRESULT CreateSharedHandle(IInspectable pObject, const(SECURITY_ATTRIBUTES)* pSecurityAttributes, uint Access, int Name, HANDLE* pHandle);
    HRESULT OpenSharedHandle(HANDLE NTHandle, Guid riid, void** ppvObj);
}

const GUID IID_IDisplayPathInterop = {0xA6BA4205, 0xE59E, 0x4E71, [0xB2, 0x5B, 0x4E, 0x43, 0x6D, 0x21, 0xEE, 0x3D]};
@GUID(0xA6BA4205, 0xE59E, 0x4E71, [0xB2, 0x5B, 0x4E, 0x43, 0x6D, 0x21, 0xEE, 0x3D]);
interface IDisplayPathInterop : IUnknown
{
    HRESULT CreateSourcePresentationHandle(HANDLE* pValue);
    HRESULT GetSourceId(uint* pSourceId);
}

alias PINSPECT_HSTRING_CALLBACK = extern(Windows) HRESULT function(void* context, uint readAddress, uint length, char* buffer);
alias PINSPECT_HSTRING_CALLBACK2 = extern(Windows) HRESULT function(void* context, ulong readAddress, uint length, char* buffer);
const GUID IID_IGraphicsCaptureItemInterop = {0x3628E81B, 0x3CAC, 0x4C60, [0xB7, 0xF4, 0x23, 0xCE, 0x0E, 0x0C, 0x33, 0x56]};
@GUID(0x3628E81B, 0x3CAC, 0x4C60, [0xB7, 0xF4, 0x23, 0xCE, 0x0E, 0x0C, 0x33, 0x56]);
interface IGraphicsCaptureItemInterop : IUnknown
{
    HRESULT CreateForWindow(HWND window, const(Guid)* riid, void** result);
    HRESULT CreateForMonitor(int monitor, const(Guid)* riid, void** result);
}

const GUID IID_IDirect3DDxgiInterfaceAccess = {0xA9B3D012, 0x3DF2, 0x4EE3, [0xB8, 0xD1, 0x86, 0x95, 0xF4, 0x57, 0xD3, 0xC1]};
@GUID(0xA9B3D012, 0x3DF2, 0x4EE3, [0xB8, 0xD1, 0x86, 0x95, 0xF4, 0x57, 0xD3, 0xC1]);
interface IDirect3DDxgiInterfaceAccess : IUnknown
{
    HRESULT GetInterface(const(Guid)* iid, void** p);
}

const GUID IID_ISoftwareBitmapNative = {0x94BC8415, 0x04EA, 0x4B2E, [0xAF, 0x13, 0x4D, 0xE9, 0x5A, 0xA8, 0x98, 0xEB]};
@GUID(0x94BC8415, 0x04EA, 0x4B2E, [0xAF, 0x13, 0x4D, 0xE9, 0x5A, 0xA8, 0x98, 0xEB]);
interface ISoftwareBitmapNative : IInspectable
{
    HRESULT GetData(const(Guid)* riid, void** ppv);
}

const GUID IID_ISoftwareBitmapNativeFactory = {0xC3C181EC, 0x2914, 0x4791, [0xAF, 0x02, 0x02, 0xD2, 0x24, 0xA1, 0x0B, 0x43]};
@GUID(0xC3C181EC, 0x2914, 0x4791, [0xAF, 0x02, 0x02, 0xD2, 0x24, 0xA1, 0x0B, 0x43]);
interface ISoftwareBitmapNativeFactory : IInspectable
{
    HRESULT CreateFromWICBitmap(IWICBitmap data, BOOL forceReadOnly, const(Guid)* riid, void** ppv);
    HRESULT CreateFromMF2DBuffer2(IMF2DBuffer2 data, const(Guid)* subtype, uint width, uint height, BOOL forceReadOnly, const(MFVideoArea)* minDisplayAperture, const(Guid)* riid, void** ppv);
}

const GUID IID_IAudioFrameNative = {0x20BE1E2E, 0x930F, 0x4746, [0x93, 0x35, 0x3C, 0x33, 0x2F, 0x25, 0x50, 0x93]};
@GUID(0x20BE1E2E, 0x930F, 0x4746, [0x93, 0x35, 0x3C, 0x33, 0x2F, 0x25, 0x50, 0x93]);
interface IAudioFrameNative : IInspectable
{
    HRESULT GetData(const(Guid)* riid, void** ppv);
}

const GUID IID_IVideoFrameNative = {0x26BA702B, 0x314A, 0x4620, [0xAA, 0xF6, 0x7A, 0x51, 0xAA, 0x58, 0xFA, 0x18]};
@GUID(0x26BA702B, 0x314A, 0x4620, [0xAA, 0xF6, 0x7A, 0x51, 0xAA, 0x58, 0xFA, 0x18]);
interface IVideoFrameNative : IInspectable
{
    HRESULT GetData(const(Guid)* riid, void** ppv);
    HRESULT GetDevice(const(Guid)* riid, void** ppv);
}

const GUID IID_IAudioFrameNativeFactory = {0x7BD67CF8, 0xBF7D, 0x43E6, [0xAF, 0x8D, 0xB1, 0x70, 0xEE, 0x0C, 0x01, 0x10]};
@GUID(0x7BD67CF8, 0xBF7D, 0x43E6, [0xAF, 0x8D, 0xB1, 0x70, 0xEE, 0x0C, 0x01, 0x10]);
interface IAudioFrameNativeFactory : IInspectable
{
    HRESULT CreateFromMFSample(IMFSample data, BOOL forceReadOnly, const(Guid)* riid, void** ppv);
}

const GUID IID_IVideoFrameNativeFactory = {0x69E3693E, 0x8E1E, 0x4E63, [0xAC, 0x4C, 0x7F, 0xDC, 0x21, 0xD9, 0x73, 0x1D]};
@GUID(0x69E3693E, 0x8E1E, 0x4E63, [0xAC, 0x4C, 0x7F, 0xDC, 0x21, 0xD9, 0x73, 0x1D]);
interface IVideoFrameNativeFactory : IInspectable
{
    HRESULT CreateFromMFSample(IMFSample data, const(Guid)* subtype, uint width, uint height, BOOL forceReadOnly, const(MFVideoArea)* minDisplayAperture, IMFDXGIDeviceManager device, const(Guid)* riid, void** ppv);
}

const GUID IID_ISurfaceImageSourceNative = {0xF2E9EDC1, 0xD307, 0x4525, [0x98, 0x86, 0x0F, 0xAF, 0xAA, 0x44, 0x16, 0x3C]};
@GUID(0xF2E9EDC1, 0xD307, 0x4525, [0x98, 0x86, 0x0F, 0xAF, 0xAA, 0x44, 0x16, 0x3C]);
interface ISurfaceImageSourceNative : IUnknown
{
    HRESULT SetDevice(IDXGIDevice device);
    HRESULT BeginDraw(RECT updateRect, IDXGISurface* surface, POINT* offset);
    HRESULT EndDraw();
}

const GUID IID_IVirtualSurfaceUpdatesCallbackNative = {0xDBF2E947, 0x8E6C, 0x4254, [0x9E, 0xEE, 0x77, 0x38, 0xF7, 0x13, 0x86, 0xC9]};
@GUID(0xDBF2E947, 0x8E6C, 0x4254, [0x9E, 0xEE, 0x77, 0x38, 0xF7, 0x13, 0x86, 0xC9]);
interface IVirtualSurfaceUpdatesCallbackNative : IUnknown
{
    HRESULT UpdatesNeeded();
}

const GUID IID_IVirtualSurfaceImageSourceNative = {0xE9550983, 0x360B, 0x4F53, [0xB3, 0x91, 0xAF, 0xD6, 0x95, 0x07, 0x86, 0x91]};
@GUID(0xE9550983, 0x360B, 0x4F53, [0xB3, 0x91, 0xAF, 0xD6, 0x95, 0x07, 0x86, 0x91]);
interface IVirtualSurfaceImageSourceNative : ISurfaceImageSourceNative
{
    HRESULT Invalidate(RECT updateRect);
    HRESULT GetUpdateRectCount(uint* count);
    HRESULT GetUpdateRects(char* updates, uint count);
    HRESULT GetVisibleBounds(RECT* bounds);
    HRESULT RegisterForUpdatesNeeded(IVirtualSurfaceUpdatesCallbackNative callback);
    HRESULT Resize(int newWidth, int newHeight);
}

const GUID IID_ISwapChainBackgroundPanelNative = {0x43BEBD4E, 0xADD5, 0x4035, [0x8F, 0x85, 0x56, 0x08, 0xD0, 0x8E, 0x9D, 0xC9]};
@GUID(0x43BEBD4E, 0xADD5, 0x4035, [0x8F, 0x85, 0x56, 0x08, 0xD0, 0x8E, 0x9D, 0xC9]);
interface ISwapChainBackgroundPanelNative : IUnknown
{
    HRESULT SetSwapChain(IDXGISwapChain swapChain);
}

const GUID IID_ISurfaceImageSourceManagerNative = {0x4C8798B7, 0x1D88, 0x4A0F, [0xB5, 0x9B, 0xB9, 0x3F, 0x60, 0x0D, 0xE8, 0xC8]};
@GUID(0x4C8798B7, 0x1D88, 0x4A0F, [0xB5, 0x9B, 0xB9, 0x3F, 0x60, 0x0D, 0xE8, 0xC8]);
interface ISurfaceImageSourceManagerNative : IUnknown
{
    HRESULT FlushAllSurfacesWithDevice(IUnknown device);
}

const GUID IID_ISurfaceImageSourceNativeWithD2D = {0x54298223, 0x41E1, 0x4A41, [0x9C, 0x08, 0x02, 0xE8, 0x25, 0x68, 0x64, 0xA1]};
@GUID(0x54298223, 0x41E1, 0x4A41, [0x9C, 0x08, 0x02, 0xE8, 0x25, 0x68, 0x64, 0xA1]);
interface ISurfaceImageSourceNativeWithD2D : IUnknown
{
    HRESULT SetDevice(IUnknown device);
    HRESULT BeginDraw(const(RECT)* updateRect, const(Guid)* iid, void** updateObject, POINT* offset);
    HRESULT EndDraw();
    HRESULT SuspendDraw();
    HRESULT ResumeDraw();
}

const GUID IID_ISwapChainPanelNative = {0xF92F19D2, 0x3ADE, 0x45A6, [0xA2, 0x0C, 0xF6, 0xF1, 0xEA, 0x90, 0x55, 0x4B]};
@GUID(0xF92F19D2, 0x3ADE, 0x45A6, [0xA2, 0x0C, 0xF6, 0xF1, 0xEA, 0x90, 0x55, 0x4B]);
interface ISwapChainPanelNative : IUnknown
{
    HRESULT SetSwapChain(IDXGISwapChain swapChain);
}

const GUID IID_ISwapChainPanelNative2 = {0xD5A2F60C, 0x37B2, 0x44A2, [0x93, 0x7B, 0x8D, 0x8E, 0xB9, 0x72, 0x68, 0x21]};
@GUID(0xD5A2F60C, 0x37B2, 0x44A2, [0x93, 0x7B, 0x8D, 0x8E, 0xB9, 0x72, 0x68, 0x21]);
interface ISwapChainPanelNative2 : ISwapChainPanelNative
{
    HRESULT SetSwapChainHandle(HANDLE swapChainHandle);
}

enum GRAPHICS_EFFECT_PROPERTY_MAPPING
{
    GRAPHICS_EFFECT_PROPERTY_MAPPING_UNKNOWN = 0,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_DIRECT = 1,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORX = 2,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORY = 3,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORZ = 4,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORW = 5,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_RECT_TO_VECTOR4 = 6,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_RADIANS_TO_DEGREES = 7,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLORMATRIX_ALPHA_MODE = 8,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLOR_TO_VECTOR3 = 9,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLOR_TO_VECTOR4 = 10,
}

const GUID IID_IGraphicsEffectD2D1Interop = {0x2FC57384, 0xA068, 0x44D7, [0xA3, 0x31, 0x30, 0x98, 0x2F, 0xCF, 0x71, 0x77]};
@GUID(0x2FC57384, 0xA068, 0x44D7, [0xA3, 0x31, 0x30, 0x98, 0x2F, 0xCF, 0x71, 0x77]);
interface IGraphicsEffectD2D1Interop : IUnknown
{
    HRESULT GetEffectId(Guid* id);
    HRESULT GetNamedPropertyMapping(const(wchar)* name, uint* index, GRAPHICS_EFFECT_PROPERTY_MAPPING* mapping);
    HRESULT GetPropertyCount(uint* count);
    HRESULT GetProperty(uint index, IPropertyValue* value);
    HRESULT GetSource(uint index, IGraphicsEffectSource* source);
    HRESULT GetSourceCount(uint* count);
}

const GUID IID_IGeometrySource2DInterop = {0x0657AF73, 0x53FD, 0x47CF, [0x84, 0xFF, 0xC8, 0x49, 0x2D, 0x2A, 0x80, 0xA3]};
@GUID(0x0657AF73, 0x53FD, 0x47CF, [0x84, 0xFF, 0xC8, 0x49, 0x2D, 0x2A, 0x80, 0xA3]);
interface IGeometrySource2DInterop : IUnknown
{
    HRESULT GetGeometry(ID2D1Geometry* value);
    HRESULT TryGetGeometryUsingFactory(ID2D1Factory factory, ID2D1Geometry* value);
}

const GUID IID_ICompositionDrawingSurfaceInterop = {0xFD04E6E3, 0xFE0C, 0x4C3C, [0xAB, 0x19, 0xA0, 0x76, 0x01, 0xA5, 0x76, 0xEE]};
@GUID(0xFD04E6E3, 0xFE0C, 0x4C3C, [0xAB, 0x19, 0xA0, 0x76, 0x01, 0xA5, 0x76, 0xEE]);
interface ICompositionDrawingSurfaceInterop : IUnknown
{
    HRESULT BeginDraw(const(RECT)* updateRect, const(Guid)* iid, void** updateObject, POINT* updateOffset);
    HRESULT EndDraw();
    HRESULT Resize(SIZE sizePixels);
    HRESULT Scroll(const(RECT)* scrollRect, const(RECT)* clipRect, int offsetX, int offsetY);
    HRESULT ResumeDraw();
    HRESULT SuspendDraw();
}

const GUID IID_ICompositionDrawingSurfaceInterop2 = {0x41E64AAE, 0x98C0, 0x4239, [0x8E, 0x95, 0xA3, 0x30, 0xDD, 0x6A, 0xA1, 0x8B]};
@GUID(0x41E64AAE, 0x98C0, 0x4239, [0x8E, 0x95, 0xA3, 0x30, 0xDD, 0x6A, 0xA1, 0x8B]);
interface ICompositionDrawingSurfaceInterop2 : ICompositionDrawingSurfaceInterop
{
    HRESULT CopySurface(IUnknown destinationResource, int destinationOffsetX, int destinationOffsetY, const(RECT)* sourceRectangle);
}

const GUID IID_ICompositionGraphicsDeviceInterop = {0xA116FF71, 0xF8BF, 0x4C8A, [0x9C, 0x98, 0x70, 0x77, 0x9A, 0x32, 0xA9, 0xC8]};
@GUID(0xA116FF71, 0xF8BF, 0x4C8A, [0x9C, 0x98, 0x70, 0x77, 0x9A, 0x32, 0xA9, 0xC8]);
interface ICompositionGraphicsDeviceInterop : IUnknown
{
    HRESULT GetRenderingDevice(IUnknown* value);
    HRESULT SetRenderingDevice(IUnknown value);
}

const GUID IID_ICompositorInterop = {0x25297D5C, 0x3AD4, 0x4C9C, [0xB5, 0xCF, 0xE3, 0x6A, 0x38, 0x51, 0x23, 0x30]};
@GUID(0x25297D5C, 0x3AD4, 0x4C9C, [0xB5, 0xCF, 0xE3, 0x6A, 0x38, 0x51, 0x23, 0x30]);
interface ICompositorInterop : IUnknown
{
    HRESULT CreateCompositionSurfaceForHandle(HANDLE swapChain, ICompositionSurface* result);
    HRESULT CreateCompositionSurfaceForSwapChain(IUnknown swapChain, ICompositionSurface* result);
    HRESULT CreateGraphicsDevice(IUnknown renderingDevice, CompositionGraphicsDevice* result);
}

const GUID IID_ISwapChainInterop = {0x26F496A0, 0x7F38, 0x45FB, [0x88, 0xF7, 0xFA, 0xAA, 0xBE, 0x67, 0xDD, 0x59]};
@GUID(0x26F496A0, 0x7F38, 0x45FB, [0x88, 0xF7, 0xFA, 0xAA, 0xBE, 0x67, 0xDD, 0x59]);
interface ISwapChainInterop : IUnknown
{
    HRESULT SetSwapChain(IUnknown swapChain);
}

const GUID IID_IVisualInteractionSourceInterop = {0x11F62CD1, 0x2F9D, 0x42D3, [0xB0, 0x5F, 0xD6, 0x79, 0x0D, 0x9E, 0x9F, 0x8E]};
@GUID(0x11F62CD1, 0x2F9D, 0x42D3, [0xB0, 0x5F, 0xD6, 0x79, 0x0D, 0x9E, 0x9F, 0x8E]);
interface IVisualInteractionSourceInterop : IUnknown
{
    HRESULT TryRedirectForManipulation(const(POINTER_INFO)* pointerInfo);
}

const GUID IID_ICompositionCapabilitiesInteropFactory = {0x2C9DB356, 0xE70D, 0x4642, [0x82, 0x98, 0xBC, 0x4A, 0xA5, 0xB4, 0x86, 0x5C]};
@GUID(0x2C9DB356, 0xE70D, 0x4642, [0x82, 0x98, 0xBC, 0x4A, 0xA5, 0xB4, 0x86, 0x5C]);
interface ICompositionCapabilitiesInteropFactory : IInspectable
{
    HRESULT GetForWindow(HWND hwnd, CompositionCapabilities* result);
}

const GUID IID_ICompositorDesktopInterop = {0x29E691FA, 0x4567, 0x4DCA, [0xB3, 0x19, 0xD0, 0xF2, 0x07, 0xEB, 0x68, 0x07]};
@GUID(0x29E691FA, 0x4567, 0x4DCA, [0xB3, 0x19, 0xD0, 0xF2, 0x07, 0xEB, 0x68, 0x07]);
interface ICompositorDesktopInterop : IUnknown
{
    HRESULT CreateDesktopWindowTarget(HWND hwndTarget, BOOL isTopmost, DesktopWindowTarget* result);
    HRESULT EnsureOnThread(uint threadId);
}

const GUID IID_IDesktopWindowTargetInterop = {0x35DBF59E, 0xE3F9, 0x45B0, [0x81, 0xE7, 0xFE, 0x75, 0xF4, 0x14, 0x5D, 0xC9]};
@GUID(0x35DBF59E, 0xE3F9, 0x45B0, [0x81, 0xE7, 0xFE, 0x75, 0xF4, 0x14, 0x5D, 0xC9]);
interface IDesktopWindowTargetInterop : IUnknown
{
    HRESULT get_Hwnd(HWND* value);
}

const GUID IID_IDesktopWindowContentBridgeInterop = {0x37642806, 0xF421, 0x4FD0, [0x9F, 0x82, 0x23, 0xAE, 0x7C, 0x77, 0x61, 0x82]};
@GUID(0x37642806, 0xF421, 0x4FD0, [0x9F, 0x82, 0x23, 0xAE, 0x7C, 0x77, 0x61, 0x82]);
interface IDesktopWindowContentBridgeInterop : IUnknown
{
    HRESULT Initialize(Compositor compositor, HWND parentHwnd);
    HRESULT get_Hwnd(HWND* value);
    HRESULT get_AppliedScaleFactor(float* value);
}

struct NotifyCollectionChangedEventArgs
{
}

enum NotifyCollectionChangedAction
{
    NotifyCollectionChangedAction_Add = 0,
    NotifyCollectionChangedAction_Remove = 1,
    NotifyCollectionChangedAction_Replace = 2,
    NotifyCollectionChangedAction_Move = 3,
    NotifyCollectionChangedAction_Reset = 4,
}

enum TypeKind
{
    TypeKind_Primitive = 0,
    TypeKind_Metadata = 1,
    TypeKind_Custom = 2,
}

struct TypeName
{
    int Name;
    TypeKind Kind;
}

const GUID IID_IBindableVectorChangedEventHandler = {0x624CD4E1, 0xD007, 0x43B1, [0x9C, 0x03, 0xAF, 0x4D, 0x3E, 0x62, 0x58, 0xC4]};
@GUID(0x624CD4E1, 0xD007, 0x43B1, [0x9C, 0x03, 0xAF, 0x4D, 0x3E, 0x62, 0x58, 0xC4]);
interface IBindableVectorChangedEventHandler : IUnknown
{
    HRESULT Invoke(IBindableObservableVector vector, IInspectable e);
}

const GUID IID_INotifyCollectionChangedEventHandler = {0xCA10B37C, 0xF382, 0x4591, [0x85, 0x57, 0x5E, 0x24, 0x96, 0x52, 0x79, 0xB0]};
@GUID(0xCA10B37C, 0xF382, 0x4591, [0x85, 0x57, 0x5E, 0x24, 0x96, 0x52, 0x79, 0xB0]);
interface INotifyCollectionChangedEventHandler : IUnknown
{
    HRESULT Invoke(IInspectable sender, INotifyCollectionChangedEventArgs e);
}

const GUID IID_IBindableIterable = {0x036D2C08, 0xDF29, 0x41AF, [0x8A, 0xA2, 0xD7, 0x74, 0xBE, 0x62, 0xBA, 0x6F]};
@GUID(0x036D2C08, 0xDF29, 0x41AF, [0x8A, 0xA2, 0xD7, 0x74, 0xBE, 0x62, 0xBA, 0x6F]);
interface IBindableIterable : IInspectable
{
    HRESULT First(IBindableIterator* result);
}

const GUID IID_IBindableIterator = {0x6A1D6C07, 0x076D, 0x49F2, [0x83, 0x14, 0xF5, 0x2C, 0x9C, 0x9A, 0x83, 0x31]};
@GUID(0x6A1D6C07, 0x076D, 0x49F2, [0x83, 0x14, 0xF5, 0x2C, 0x9C, 0x9A, 0x83, 0x31]);
interface IBindableIterator : IInspectable
{
    HRESULT get_Current(IInspectable* value);
    HRESULT get_HasCurrent(ubyte* value);
    HRESULT MoveNext(ubyte* result);
}

const GUID IID_IBindableObservableVector = {0xFE1EB536, 0x7E7F, 0x4F90, [0xAC, 0x9A, 0x47, 0x49, 0x84, 0xAA, 0xE5, 0x12]};
@GUID(0xFE1EB536, 0x7E7F, 0x4F90, [0xAC, 0x9A, 0x47, 0x49, 0x84, 0xAA, 0xE5, 0x12]);
interface IBindableObservableVector : IInspectable
{
    HRESULT add_VectorChanged(IBindableVectorChangedEventHandler handler, EventRegistrationToken* token);
    HRESULT remove_VectorChanged(EventRegistrationToken token);
}

const GUID IID_IBindableVector = {0x393DE7DE, 0x6FD0, 0x4C0D, [0xBB, 0x71, 0x47, 0x24, 0x4A, 0x11, 0x3E, 0x93]};
@GUID(0x393DE7DE, 0x6FD0, 0x4C0D, [0xBB, 0x71, 0x47, 0x24, 0x4A, 0x11, 0x3E, 0x93]);
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

const GUID IID_IBindableVectorView = {0x346DD6E7, 0x976E, 0x4BC3, [0x81, 0x5D, 0xEC, 0xE2, 0x43, 0xBC, 0x0F, 0x33]};
@GUID(0x346DD6E7, 0x976E, 0x4BC3, [0x81, 0x5D, 0xEC, 0xE2, 0x43, 0xBC, 0x0F, 0x33]);
interface IBindableVectorView : IInspectable
{
    HRESULT GetAt(uint index, IInspectable* result);
    HRESULT get_Size(uint* value);
    HRESULT IndexOf(IInspectable value, uint* index, ubyte* returnValue);
}

const GUID IID_INotifyCollectionChanged = {0x28B167D5, 0x1A31, 0x465B, [0x9B, 0x25, 0xD5, 0xC3, 0xAE, 0x68, 0x6C, 0x40]};
@GUID(0x28B167D5, 0x1A31, 0x465B, [0x9B, 0x25, 0xD5, 0xC3, 0xAE, 0x68, 0x6C, 0x40]);
interface INotifyCollectionChanged : IInspectable
{
    HRESULT add_CollectionChanged(INotifyCollectionChangedEventHandler handler, EventRegistrationToken* token);
    HRESULT remove_CollectionChanged(EventRegistrationToken token);
}

const GUID IID_INotifyCollectionChangedEventArgs = {0x4CF68D33, 0xE3F2, 0x4964, [0xB8, 0x5E, 0x94, 0x5B, 0x4F, 0x7E, 0x2F, 0x21]};
@GUID(0x4CF68D33, 0xE3F2, 0x4964, [0xB8, 0x5E, 0x94, 0x5B, 0x4F, 0x7E, 0x2F, 0x21]);
interface INotifyCollectionChangedEventArgs : IInspectable
{
    HRESULT get_Action(NotifyCollectionChangedAction* value);
    HRESULT get_NewItems(IBindableVector* value);
    HRESULT get_OldItems(IBindableVector* value);
    HRESULT get_NewStartingIndex(int* value);
    HRESULT get_OldStartingIndex(int* value);
}

const GUID IID_INotifyCollectionChangedEventArgsFactory = {0xB30C3E3A, 0xDF8D, 0x44A5, [0x9A, 0x38, 0x7A, 0xC0, 0xD0, 0x8C, 0xE6, 0x3D]};
@GUID(0xB30C3E3A, 0xDF8D, 0x44A5, [0x9A, 0x38, 0x7A, 0xC0, 0xD0, 0x8C, 0xE6, 0x3D]);
interface INotifyCollectionChangedEventArgsFactory : IInspectable
{
    HRESULT CreateInstanceWithAllParameters(NotifyCollectionChangedAction action, IBindableVector newItems, IBindableVector oldItems, int newIndex, int oldIndex, IInspectable baseInterface, IInspectable* innerInterface, INotifyCollectionChangedEventArgs* value);
}

const GUID IID_IRestrictedErrorInfo = {0x82BA7092, 0x4C88, 0x427D, [0xA7, 0xBC, 0x16, 0xDD, 0x93, 0xFE, 0xB6, 0x7E]};
@GUID(0x82BA7092, 0x4C88, 0x427D, [0xA7, 0xBC, 0x16, 0xDD, 0x93, 0xFE, 0xB6, 0x7E]);
interface IRestrictedErrorInfo : IUnknown
{
    HRESULT GetErrorDetails(BSTR* description, int* error, BSTR* restrictedDescription, BSTR* capabilitySid);
    HRESULT GetReference(BSTR* reference);
}

const GUID IID_ILanguageExceptionErrorInfo = {0x04A2DBF3, 0xDF83, 0x116C, [0x09, 0x46, 0x08, 0x12, 0xAB, 0xF6, 0xE0, 0x7D]};
@GUID(0x04A2DBF3, 0xDF83, 0x116C, [0x09, 0x46, 0x08, 0x12, 0xAB, 0xF6, 0xE0, 0x7D]);
interface ILanguageExceptionErrorInfo : IUnknown
{
    HRESULT GetLanguageException(IUnknown* languageException);
}

const GUID IID_ILanguageExceptionTransform = {0xFEB5A271, 0xA6CD, 0x45CE, [0x88, 0x0A, 0x69, 0x67, 0x06, 0xBA, 0xDC, 0x65]};
@GUID(0xFEB5A271, 0xA6CD, 0x45CE, [0x88, 0x0A, 0x69, 0x67, 0x06, 0xBA, 0xDC, 0x65]);
interface ILanguageExceptionTransform : IUnknown
{
    HRESULT GetTransformedRestrictedErrorInfo(IRestrictedErrorInfo* restrictedErrorInfo);
}

const GUID IID_ILanguageExceptionStackBackTrace = {0xCBE53FB5, 0xF967, 0x4258, [0x8D, 0x34, 0x42, 0xF5, 0xE2, 0x58, 0x33, 0xDE]};
@GUID(0xCBE53FB5, 0xF967, 0x4258, [0x8D, 0x34, 0x42, 0xF5, 0xE2, 0x58, 0x33, 0xDE]);
interface ILanguageExceptionStackBackTrace : IUnknown
{
    HRESULT GetStackBackTrace(uint maxFramesToCapture, char* stackBackTrace, uint* framesCaptured);
}

const GUID IID_ILanguageExceptionErrorInfo2 = {0x5746E5C4, 0x5B97, 0x424C, [0xB6, 0x20, 0x28, 0x22, 0x91, 0x57, 0x34, 0xDD]};
@GUID(0x5746E5C4, 0x5B97, 0x424C, [0xB6, 0x20, 0x28, 0x22, 0x91, 0x57, 0x34, 0xDD]);
interface ILanguageExceptionErrorInfo2 : ILanguageExceptionErrorInfo
{
    HRESULT GetPreviousLanguageExceptionErrorInfo(ILanguageExceptionErrorInfo2* previousLanguageExceptionErrorInfo);
    HRESULT CapturePropagationContext(IUnknown languageException);
    HRESULT GetPropagationContextHead(ILanguageExceptionErrorInfo2* propagatedLanguageExceptionErrorInfoHead);
}

enum RO_INIT_TYPE
{
    RO_INIT_SINGLETHREADED = 0,
    RO_INIT_MULTITHREADED = 1,
}

struct __AnonymousRecord_roapi_L45_C9
{
}

struct APARTMENT_SHUTDOWN_REGISTRATION_COOKIE__
{
    int unused;
}

const GUID IID_IBufferByteAccess = {0x905A0FEF, 0xBC53, 0x11DF, [0x8C, 0x49, 0x00, 0x1E, 0x4F, 0xC6, 0x86, 0xDA]};
@GUID(0x905A0FEF, 0xBC53, 0x11DF, [0x8C, 0x49, 0x00, 0x1E, 0x4F, 0xC6, 0x86, 0xDA]);
interface IBufferByteAccess : IUnknown
{
    HRESULT Buffer(ubyte** value);
}

enum RO_ERROR_REPORTING_FLAGS
{
    RO_ERROR_REPORTING_NONE = 0,
    RO_ERROR_REPORTING_SUPPRESSEXCEPTIONS = 1,
    RO_ERROR_REPORTING_FORCEEXCEPTIONS = 2,
    RO_ERROR_REPORTING_USESETERRORINFO = 4,
    RO_ERROR_REPORTING_SUPPRESSSETERRORINFO = 8,
}

alias PINSPECT_MEMORY_CALLBACK = extern(Windows) HRESULT function(void* context, uint readAddress, uint length, char* buffer);
struct ROPARAMIIDHANDLE__
{
    int unused;
}

interface IRoSimpleMetaDataBuilder
{
    HRESULT SetWinRtInterface(Guid iid);
    HRESULT SetDelegate(Guid iid);
    HRESULT SetInterfaceGroupSimpleDefault(const(wchar)* name, const(wchar)* defaultInterfaceName, const(Guid)* defaultInterfaceIID);
    HRESULT SetInterfaceGroupParameterizedDefault(const(wchar)* name, uint elementCount, char* defaultInterfaceNameElements);
    HRESULT SetRuntimeClassSimpleDefault(const(wchar)* name, const(wchar)* defaultInterfaceName, const(Guid)* defaultInterfaceIID);
    HRESULT SetRuntimeClassParameterizedDefault(const(wchar)* name, uint elementCount, char* defaultInterfaceNameElements);
    HRESULT SetStruct(const(wchar)* name, uint numFields, char* fieldTypeNames);
    HRESULT SetEnum(const(wchar)* name, const(wchar)* baseType);
    HRESULT SetParameterizedInterface(Guid piid, uint numArgs);
    HRESULT SetParameterizedDelegate(Guid piid, uint numArgs);
}

interface IRoMetaDataLocator
{
    HRESULT Locate(const(wchar)* nameElement, IRoSimpleMetaDataBuilder metaDataDestination);
}

enum BSOS_OPTIONS
{
    BSOS_DEFAULT = 0,
    BSOS_PREFERDESTINATIONSTREAM = 1,
}

