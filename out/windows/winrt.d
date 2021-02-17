// Written in the D programming language.

module windows.winrt;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IMarshal, IUnknown;
public import windows.direct2d : D2D_RECT_F, ID2D1DeviceContext, ID2D1Factory,
                                 ID2D1Geometry;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.dxgi : DXGI_RGBA, IDXGIDevice, IDXGISurface, IDXGISwapChain;
public import windows.mediafoundation : IMF2DBuffer2, IMFDXGIDeviceManager, IMFSample,
                                        MFVideoArea;
public import windows.pointerinput : POINTER_INFO;
public import windows.shell : INamedPropertyStore;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, HANDLE, SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : HWND;
public import windows.windowsimagingcomponent : IWICBitmap;

extern(Windows):


// Enums


///Specifies the kind of activation for an activatable class.
alias ACTIVATIONTYPE = int;
enum : int
{
    ACTIVATIONTYPE_UNCATEGORIZED = 0x00000000,
    ACTIVATIONTYPE_FROM_MONIKER  = 0x00000001,
    ACTIVATIONTYPE_FROM_DATA     = 0x00000002,
    ACTIVATIONTYPE_FROM_STORAGE  = 0x00000004,
    ACTIVATIONTYPE_FROM_STREAM   = 0x00000008,
    ACTIVATIONTYPE_FROM_FILE     = 0x00000010,
}

///Specifies options for the RoGetAgileReference function.
enum AgileReferenceOptions : int
{
    ///Use the default marshaling behavior, which is to marshal interfaces when an agile reference to the interface is
    ///obtained.
    AGILEREFERENCE_DEFAULT        = 0x00000000,
    ///Marshaling happens on demand. Use this option only in situations where it's known that an object is only resolved
    ///from the same apartment in which it was registered.
    AGILEREFERENCE_DELAYEDMARSHAL = 0x00000001,
}

///Represents the trust level of an activatable class.
enum TrustLevel : int
{
    ///The component has access to resources that are not protected.
    BaseTrust    = 0x00000000,
    ///The component has access to resources requested in the app manifest and approved by the user.
    PartialTrust = 0x00000001,
    ///The component requires the full privileges of the user.
    FullTrust    = 0x00000002,
}

alias CASTING_CONNECTION_ERROR_STATUS = int;
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

alias CASTING_CONNECTION_STATE = int;
enum : int
{
    CASTING_CONNECTION_STATE_DISCONNECTED  = 0x00000000,
    CASTING_CONNECTION_STATE_CONNECTED     = 0x00000001,
    CASTING_CONNECTION_STATE_RENDERING     = 0x00000002,
    CASTING_CONNECTION_STATE_DISCONNECTING = 0x00000003,
    CASTING_CONNECTION_STATE_CONNECTING    = 0x00000004,
}

///Indicates how a strongly-typed effect property maps to an underlying Direct2D effect property. This enumeration
///supports the Windows.UI.Composition API and is not meant to be used directly in your code.
alias GRAPHICS_EFFECT_PROPERTY_MAPPING = int;
enum : int
{
    ///Specifies that the value cannot be mapped to a Direct2D effect property.
    GRAPHICS_EFFECT_PROPERTY_MAPPING_UNKNOWN                = 0x00000000,
    ///Specifies that the value can be set as-is on the Direct2D effect property.
    GRAPHICS_EFFECT_PROPERTY_MAPPING_DIRECT                 = 0x00000001,
    ///Specifies that the value maps to the X component of a vector-typed Direct2D effect property.
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORX                = 0x00000002,
    ///Specifies that the value maps to the Y component of a vector-typed Direct2D effect property.
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORY                = 0x00000003,
    ///Specifies that the value maps to the Z component of a vector-typed Direct2D effect property.
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORZ                = 0x00000004,
    ///Specifies that the value maps to the W component of a vector-typed Direct2D effect property.
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORW                = 0x00000005,
    ///Specifies that a rect value maps to a Vector4 Direct2D effect property.
    GRAPHICS_EFFECT_PROPERTY_MAPPING_RECT_TO_VECTOR4        = 0x00000006,
    ///Specifies that the value needs to be converted from radians to degrees before being set on the Direct2D effect
    ///property.
    GRAPHICS_EFFECT_PROPERTY_MAPPING_RADIANS_TO_DEGREES     = 0x00000007,
    ///Specifies a color matrix alpha mode enum value needs to be converted to the equivalent Direct2D enum value before
    ///being set on the effect property.
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLORMATRIX_ALPHA_MODE = 0x00000008,
    ///Specifies that a Windows.UI.Color value needs to be converted to an RGB Vector3 before being set on the Direct2D
    ///effect property.
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLOR_TO_VECTOR3       = 0x00000009,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLOR_TO_VECTOR4       = 0x0000000a,
}

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

///Determines the concurrency model used for incoming calls to the objects created by this thread.
alias RO_INIT_TYPE = int;
enum : int
{
    RO_INIT_SINGLETHREADED = 0x00000000,
    ///Initializes the thread for multi-threaded concurrency. The current thread is initialized in the MTA.
    RO_INIT_MULTITHREADED  = 0x00000001,
}

///Specifies the behavior of the RoOriginateError and RoTransformError functions.
alias RO_ERROR_REPORTING_FLAGS = int;
enum : int
{
    ///Error functions raise structured exceptions when a debugger is attached.
    RO_ERROR_REPORTING_NONE                 = 0x00000000,
    ///Error functions do not raise structured exceptions, even when a debugger is present. Override the behavior of
    ///this flag by setting the <b>ForceExceptions</b> flag.
    RO_ERROR_REPORTING_SUPPRESSEXCEPTIONS   = 0x00000001,
    ///Error functions raise structured exceptions, even if no debugger is present. This flag supercedes the
    ///<b>RO_ERROR_REPORTING_SUPPRESSEXCEPTIONS</b> flag. If this flag is set, structured exceptions are raised even if
    ///the <b>RO_ERROR_REPORTING_SUPPRESSEXCEPTIONS</b> flag is set.
    RO_ERROR_REPORTING_FORCEEXCEPTIONS      = 0x00000002,
    ///Error functions report error strings through a COM object that is attached to the COM channel through the
    ///SetRestrictedErrorInfo infrastructure. For the <b>SetRestrictedErrorInfo</b> call to succeed, the thread must be
    ///initialized into COM.
    RO_ERROR_REPORTING_USESETERRORINFO      = 0x00000004,
    ///Error functions do not report error strings through a COM object that is attached to the COM channel through the
    ///SetRestrictedErrorInfo infrastructure.
    RO_ERROR_REPORTING_SUPPRESSSETERRORINFO = 0x00000008,
}

///Specifies the behavior of a RandomAccessStream that encapsulates a Component Object Model (COM) IStream.
alias BSOS_OPTIONS = int;
enum : int
{
    ///When creating a RandomAccessStream over a stream, use the base IRandomAccessStream behavior on the STGM mode from
    ///the Stat method.
    BSOS_DEFAULT                 = 0x00000000,
    ///Use the GetDestinationStream method.
    BSOS_PREFERDESTINATIONSTREAM = 0x00000001,
}

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
///Provides a function pointer to the callback used by the WindowsInspectString function.
///Params:
///    context = [in] Custom context data provided to the WindowsInspectString function.
///    readAddress = [in] The address to read data from.
///    length = [in] The number of bytes to read, starting at <i>readAddress</i>.
///    buffer = [out] The buffer that receives a copy of the bytes that are read.
///Returns:
///    If this function pointer succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise,
///    it returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
alias PINSPECT_HSTRING_CALLBACK = HRESULT function(void* context, size_t readAddress, uint length, char* buffer);
alias PINSPECT_HSTRING_CALLBACK2 = HRESULT function(void* context, ulong readAddress, uint length, char* buffer);
///Provides a function pointer to the callback used by the RoInspectCapturedStackBackTrace function.
///Params:
///    context = Custom context data provided to the RoInspectCapturedStackBackTrace function.
///    readAddress = The address to read data from.
///    length = The number of bytes to read, starting at <i>readAddress</i>.
///    buffer = The buffer that receives a copy of the bytes that are read.
///Returns:
///    If this callback function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>.
///    Otherwise, it returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
alias PINSPECT_MEMORY_CALLBACK = HRESULT function(void* context, size_t readAddress, uint length, char* buffer);

// Structs


///Identifies an event handler that has been registered with an event source.
struct EventRegistrationToken
{
    ///Type: <b>INT64</b> An identifying value that is provided by an event source.
    long value;
}

///Represents the implementation of a Component Object Model (COM) interface in a server process.
struct ServerInformation
{
    ///The process ID of the server.
    uint  dwServerPid;
    ///The thread ID of the server object if it's in the STA, 0 if it's in the MTA, and <b>0x0000FFFF</b> if it's in the
    ///NA.
    uint  dwServerTid;
    ///<i>ui64ServerAddress</i> is considered a 64-bit value type, rather than a pointer to a 64-bit value, and isn't a
    ///pointer to an object in the debugger process. Instead, this address is passed to the ReadProcessMemory function.
    ulong ui64ServerAddress;
}

struct HSTRING__
{
    int unused;
}

///Represents a header for an HSTRING.
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

///Represents a set of properties for outputting a single page of a Portable Document Format (PDF) file.
struct PDF_RENDER_PARAMS
{
    ///Outputs a rectangular portion of the original page, as defined by the <b>D2D_RECT_F</b> structure's upper-left
    ///and lower-right corner x- and y-coordinates. The default value is 0.f for all coordinates.
    D2D_RECT_F SourceRect;
    ///Outputs the page at the specified width. The default is 0.f.
    uint       DestinationWidth;
    ///Outputs the page at the specified height. The default is 0.f.
    uint       DestinationHeight;
    ///Outputs the page with the specified background color. The default is {1.f, 1.f, 1.f, 1.f}, which represents the
    ///values 1.0 for red, green, blue, and alpha channel, respectively. These values, taken together, represent white
    ///at full opacity.
    DXGI_RGBA  BackgroundColor;
    ///False to use the system's high contrast display settings; otherwise true. The default is true.
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

///Locates the implementation of a Component Object Model (COM) interface in a server process given an interface to a
///proxied object.
///Params:
///    dwClientPid = The process ID of the process that contains the proxy.
///    ui64ProxyAddress = The address of an interface on a proxy to the object. <i>ui64ProxyAddress</i> is considered a 64-bit value type,
///                       rather than a pointer to a 64-bit value, and isn't a pointer to an object in the debugger process. Instead, this
///                       address is passed to the ReadProcessMemory function.
///    pServerInformation = A structure that contains the process ID, the thread ID, and the address of the server.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The server information was successfully
///    retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The
///    caller is an app container, or the developer license is not installed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_E_INVALID_IPID</b></dt> </dl> </td> <td width="60%"> <i>ui64ProxyAddress</i> does not point to a
///    proxy. </td> </tr> </table>
///    
@DllImport("OLE32")
HRESULT CoDecodeProxy(uint dwClientPid, ulong ui64ProxyAddress, ServerInformation* pServerInformation);

///Creates an agile reference for an object specified by the given interface.
///Params:
///    options = The registration options.
///    riid = The interface ID of the object for which an agile reference is being obtained.
///    pUnk = Pointer to the interface to be encapsulated in an agile reference. It must be the same type as <i>riid</i>. It
///           may be a pointer to an in-process object or a pointer to a proxy of an object.
///    ppAgileReference = The agile reference for the object. Call the Resolve method to localize the object into the apartment in which
///                       <b>Resolve</b> is called.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return value</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The function completed successfully. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt>E_INVALIDARG</dt> </dl> </td> <td width="60%"> The <i>options</i> parameter in
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt>E_OUTOFMEMORY</dt> </dl> </td> <td width="60%"> The agile
///    reference couldn't be constructed due to an out-of-memory condition. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt>E_NOINTERFACE</dt> </dl> </td> <td width="60%"> The <i>pUnk</i> parameter doesn't support the interface ID
///    specified by the <i>riid</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt>CO_E_NOT_SUPPORTED</dt> </dl>
///    </td> <td width="60%"> The object implements the INoMarshal interface. </td> </tr> </table>
///    
@DllImport("OLE32")
HRESULT RoGetAgileReference(AgileReferenceOptions options, const(GUID)* riid, IUnknown pUnk, 
                            IAgileReference* ppAgileReference);

///Calculates the wire size of the [**HSTRING**](/windows/win32/winrt/hstring) object, and gets its handle and data.
///Params:
///    pFlags = [in] The data used by RPC.
///    StartingSize = [in] The current buffer offset where the object will be marshaled. The method has to account for any padding
///                   needed for the [**HSTRING**](/windows/win32/winrt/hstring) object to be properly aligned when it will be
///                   marshaled to the buffer.
///    ppidl = [in] The string.
///Returns:
///    The value obtained from the returned <b>HRESULT</b> value is <b>S_OK</b>.
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
uint HSTRING_UserSize(uint* param0, uint param1, ptrdiff_t* param2);

///Marshals an [**HSTRING**](/windows/win32/winrt/hstring) object into the RPC buffer.
///Params:
///    pFlags = [in] The data used by RPC.
///    pBuffer = [in, out] The current buffer. This pointer may or may not be aligned on entry.
///    ppidl = [in] The string.
///Returns:
///    The value obtained from the returned <b>HRESULT</b> value is <b>S_OK</b>.
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
ubyte* HSTRING_UserMarshal(uint* param0, ubyte* param1, ptrdiff_t* param2);

///Unmarshals an [**HSTRING**](/windows/win32/winrt/hstring) object from the RPC buffer.
///Params:
///    pFlags = [in] The data used by RPC.
///    pBuffer = [in] The current buffer. This pointer may or may not be aligned on entry.
///    ppidl = [out] The string.
///Returns:
///    The value obtained from the returned <b>HRESULT</b> value is one of the following. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
///    Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient memory for this function to perform. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
ubyte* HSTRING_UserUnmarshal(uint* param0, char* param1, ptrdiff_t* param2);

///Frees resources on the server side when called by RPC stub files.
///Params:
///    pFlags = [in] The data used by RPC.
///    ppidl = [in] The string.
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
void HSTRING_UserFree(uint* param0, ptrdiff_t* param1);

///Calculates the wire size of the HSTRING object, and gets its handle and data.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer offset where the object will be marshaled. The method has to account for any padding needed
///           for the HSTRING object to be properly aligned when it will be marshaled to the buffer.
///    arg3 = The string.
///Returns:
///    The value obtained from the returned <b>HRESULT</b> value is <b>S_OK</b>.
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
uint HSTRING_UserSize64(uint* param0, uint param1, ptrdiff_t* param2);

///Marshals an HSTRING object into the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry.
///    arg3 = The string.
///Returns:
///    The value obtained from the returned <b>HRESULT</b> value is <b>S_OK</b>.
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
ubyte* HSTRING_UserMarshal64(uint* param0, ubyte* param1, ptrdiff_t* param2);

///Unmarshals an HSTRING object from the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry.
///    arg3 = The string.
///Returns:
///    The value obtained from the returned <b>HRESULT</b> value is one of the following. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
///    Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient memory for this function to perform. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
ubyte* HSTRING_UserUnmarshal64(uint* param0, char* param1, ptrdiff_t* param2);

///Frees resources on the server side when called by RPC stub files.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The string.
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
void HSTRING_UserFree64(uint* param0, ptrdiff_t* param1);

///Gets an instance of the IPdfRendererNative interface for displaying a single page of a Portable Document Format (PDF)
///file.
///Params:
///    pDevice = An instance of a Microsoft DirectX Graphics Infrastructure (DXGI) object that is used for producing image data.
///    ppRenderer = An instance of the high-performance IPdfRendererNative interface for rendering PDF content on a DirectX surface.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function call succeeded. </td> </tr>
///    </table>
///    
@DllImport("Windows")
HRESULT PdfCreateRenderer(IDXGIDevice pDevice, IPdfRendererNative* ppRenderer);

///Creates a new [**HSTRING**](/windows/win32/winrt/hstring) based on the specified source string.
///Params:
///    sourceString = Type: [in, optional] <b>LPCWSTR</b> A null-terminated string to use as the source for the new
///                   [**HSTRING**](/windows/win32/winrt/hstring). To create a new, empty, or <b>NULL</b> string, pass <b>NULL</b> for
///                   <i>sourceString</i> and 0 for <i>length</i>.
///    length = Type: [in] <b>UINT32</b> The length of <i>sourceString</i>, in Unicode characters. Must be 0 if
///             <i>sourceString</i> is <b>NULL</b>.
///    string = Type: [out] <b>[**HSTRING**](/windows/win32/winrt/hstring)*</b> A pointer to the newly created
///             [**HSTRING**](/windows/win32/winrt/hstring), or <b>NULL</b> if an error occurs. Any existing content in
///             <i>string</i> is overwritten. The <b>HSTRING</b> is a standard handle type.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    [**HSTRING**](/windows/win32/winrt/hstring) was created successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>string</i> is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the new
///    [**HSTRING**](/windows/win32/winrt/hstring). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
///    </dl> </td> <td width="60%"> <i>sourceString</i> is <b>NULL</b> and <i>length</i> is non-zero. </td> </tr>
///    </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsCreateString(char* sourceString, uint length, ptrdiff_t* string);

///Creates a new string reference based on the specified string.
///Params:
///    sourceString = Type: [in] <b>PCWSTR</b> A null-terminated string to use as the source for the new
///                   [**HSTRING**](/windows/win32/winrt/hstring). A value of <b>NULL</b> represents the empty string, if the value of
///                   <i>length</i> is 0. Should be allocated on the stack frame.
///    length = Type: [in] <b>UINT32</b> The length of <i>sourceString</i>, in Unicode characters. Must be 0 if
///             <i>sourceString</i> is <b>NULL</b>. If greater than 0, <i>sourceString</i> must have a terminating null
///             character.
///    hstringHeader = Type: [out] <b>HSTRING_HEADER*</b> A pointer to a structure that the Windows Runtime uses to identify
///                    <i>string</i> as a string reference, or fast-pass string.
///    string = Type: [out] <b>[**HSTRING**](/windows/win32/winrt/hstring)*</b> A pointer to the newly created string, or
///             <b>NULL</b> if an error occurs. Any existing content in <i>string</i> is overwritten. The
///             [**HSTRING**](/windows/win32/winrt/hstring) is a standard handle type.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    [**HSTRING**](/windows/win32/winrt/hstring) was created successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Either <i>string</i> or <i>hstringHeader</i> is
///    <b>NULL</b>, or <i>string</i> is not null-terminated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the new
///    [**HSTRING**](/windows/win32/winrt/hstring). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
///    </dl> </td> <td width="60%"> <i>sourceString</i> is <b>NULL</b> and <i>length</i> is non-zero. </td> </tr>
///    </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsCreateStringReference(const(wchar)* sourceString, uint length, HSTRING_HEADER* hstringHeader, 
                                     ptrdiff_t* string);

///Decrements the reference count of a string buffer.
///Params:
///    string = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The string to be deleted. If <i>string</i> is a fast-pass
///             string created by WindowsCreateStringReference, or if <i>string</i> is <b>NULL</b> or empty, no action is taken
///             and <b>S_OK</b> is returned.
///Returns:
///    Type: <b>HRESULT</b> This function always returns <b>S_OK</b>.
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsDeleteString(ptrdiff_t string);

///Creates a copy of the specified string.
///Params:
///    string = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The string to be copied.
///    newString = Type: [out] <b>[**HSTRING**](/windows/win32/winrt/hstring)*</b> A copy of <i>string</i>.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    [**HSTRING**](/windows/win32/winrt/hstring) was copied successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>newString</i> is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the new
///    [**HSTRING**](/windows/win32/winrt/hstring). </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsDuplicateString(ptrdiff_t string, ptrdiff_t* newString);

///Gets the length, in Unicode characters, of the specified string.
///Params:
///    string = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The string whose length is to be found.
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
uint WindowsGetStringLen(ptrdiff_t string);

///Retrieves the backing buffer for the specified string.
///Params:
///    string = Type: [in, optional] **[HSTRING](/windows/win32/winrt/hstring)** An optional string for which the backing buffer
///             is to be retrieved. Can be **NULL**.
///    length = Type: [out, optional] **UINT32 \*** An optional pointer to a **UINT32**. If **NULL** is passed for *length*, then
///             it is ignored. If *length* is a valid pointer to a **UINT32**, and *string* is a valid
///             [**HSTRING**](/windows/win32/winrt/hstring), then on successful completion the function sets the value pointed to
///             by *length* to the number of Unicode characters in the backing buffer for *string* (including embedded null
///             characters, but excluding the terminating null). If *length* is a valid pointer to a **UINT32**, and *string* is
///             **NULL**, then the value pointed to by *length* is set to 0.
///Returns:
///    Type: <b>PCWSTR</b> A pointer to the buffer that provides the backing store for <i>string</i>, or the empty
///    string if <i>string</i> is <b>NULL</b> or the empty string.
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
ushort* WindowsGetStringRawBuffer(ptrdiff_t string, uint* length);

///Indicates whether the specified string is the empty string.
///Params:
///    string = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The string to be tested for content.
///Returns:
///    Type: <b>BOOL</b> <b>TRUE</b> if <i>string</i> is <b>NULL</b> or the empty string; otherwise, <b>FALSE</b>.
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
BOOL WindowsIsStringEmpty(ptrdiff_t string);

///Indicates whether the specified string has embedded null characters.
///Params:
///    string = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The string to test for embedded null characters.
///    hasEmbedNull = Type: [out] <b>BOOL*</b> <b>TRUE</b> if <i>string</i> has one or more embedded null characters; otherwise,
///                   <b>FALSE</b>. <b>FALSE</b> if <i>string</i> is <b>NULL</b> or the empty string.
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsStringHasEmbeddedNull(ptrdiff_t string, int* hasEmbedNull);

///Compares two specified [**HSTRING**](/windows/win32/winrt/hstring) objects and returns an integer that indicates
///their relative position in a sort order.
///Params:
///    string1 = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The first string to compare.
///    string2 = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The second string to compare.
///    result = Type: [out] <b>INT32*</b> A value that indicates the lexical relationship between <i>string1</i> and
///             <i>string2</i>.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    comparison was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> <i>result</i> is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsCompareStringOrdinal(ptrdiff_t string1, ptrdiff_t string2, int* result);

///Retrieves a substring from the specified string. The substring starts at the specified character position.
///Params:
///    string = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The original string.
///    startIndex = Type: [in] <b>UINT32</b> The zero-based starting character position of a substring in this instance.
///    newString = Type: [out] <b>[**HSTRING**](/windows/win32/winrt/hstring)*</b> A string that is equivalent to the substring that
///                begins at <i>startIndex</i> in <i>string</i>, or <b>NULL</b> if <i>startIndex</i> is equal to the length of
///                <i>string</i>.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    substring was created successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> <i>newString</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%"> <i>startIndex</i> is greater than the length of
///    <i>string</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    Failed to allocate the new substring. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsSubstring(ptrdiff_t string, uint startIndex, ptrdiff_t* newString);

///Retrieves a substring from the specified string. The substring starts at a specified character position and has a
///specified length.
///Params:
///    string = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The original string.
///    startIndex = Type: [in] <b>UINT32</b> The zero-based starting character position of a substring in this instance.
///    length = Type: [in] <b>UINT32</b> The number of characters in the substring.
///    newString = Type: [out] <b>[**HSTRING**](/windows/win32/winrt/hstring)*</b> A string that is equivalent to the substring that
///                begins at <i>startIndex</i> in <i>string</i>, or <b>NULL</b> if <i>startIndex</i> is equal to the length of
///                <i>string</i>.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    substring was created successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> <i>newString</i> is <b>NULL</b>, or <i>startIndex</i> plus <i>length</i> is greater than
///    <b>MAXUINT32</b>, which is 4,294,967,295; that is, hexadecimal 0xFFFFFFFF. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%"> <i>startIndex</i> is greater than the length of
///    <i>string</i>, or <i>startIndex</i> plus <i>length</i> indicates a position not within <i>string</i>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the new
///    substring. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsSubstringWithSpecifiedLength(ptrdiff_t string, uint startIndex, uint length, ptrdiff_t* newString);

///Concatenates two specified strings.
///Params:
///    string1 = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The first string to be concatenated.
///    string2 = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The second string to be concatenated.
///    newString = Type: [out] <b>[**HSTRING**](/windows/win32/winrt/hstring)*</b> The concatenation of <i>string1</i> and
///                <i>string2</i>. If <i>string1</i> and <i>string2</i> are <b>NULL</b>, <i>newString</i> is <b>NULL</b>. If either
///                <i>string1</i> or <i>string2</i> is <b>NULL</b>, <i>newString</i> is a copy of the non-null string.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    concatenated string was created successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
///    </dl> </td> <td width="60%"> <i>newString</i> is <b>NULL</b>, or the length of <i>string1</i> plus the length of
///    <i>string2</i> is greater than <b>MAXUINT32</b>, which is 4,294,967,295; that is, hexadecimal 0xFFFFFFFF. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate
///    the concatenated string. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsConcatString(ptrdiff_t string1, ptrdiff_t string2, ptrdiff_t* newString);

///Replaces all occurrences of a set of characters in the specified string with another set of characters to create a
///new string.
///Params:
///    string = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The original string.
///    stringReplaced = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The string to be replaced.
///    stringReplaceWith = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The string to replace all occurrences of
///                        <i>stringReplaced</i>. If this parameter is <b>NULL</b>, all instances of <i>stringReplaced</i> are removed.
///    newString = Type: [out] <b>[**HSTRING**](/windows/win32/winrt/hstring)*</b> A string that is equivalent to the original,
///                except that all instances of <i>stringReplaced</i> are replaced with <i>stringReplaceWith</i>.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    string replacement was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> <i>newString</i> is <b>NULL</b>, <i>stringReplaced</i> is empty, or the length of
///    <i>string1</i> plus the length of <i>string2</i> is greater than <b>MAXUINT32</b>, which is 4,294,967,295; that
///    is, hexadecimal 0xFFFFFFFF. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
///    width="60%"> Failed to allocate the new string. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsReplaceString(ptrdiff_t string, ptrdiff_t stringReplaced, ptrdiff_t stringReplaceWith, 
                             ptrdiff_t* newString);

///Removes all leading occurrences of a specified set of characters from the source string.
///Params:
///    string = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The string to be trimmed.
///    trimString = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The characters to remove from <i>string</i>.
///    newString = Type: [out] <b>[**HSTRING**](/windows/win32/winrt/hstring)*</b> The string that remains after all occurrences of
///                characters in the <i>trimString</i> parameter are removed from the start of <i>string</i>, or <b>NULL</b> if
///                <i>trimString</i> contains all of the characters in <i>string</i>.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    trimmed string was created successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
///    </dl> </td> <td width="60%"> <i>newString</i> is <b>NULL</b>, or <i>trimString</i> is empty. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the trimmed
///    string. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsTrimStringStart(ptrdiff_t string, ptrdiff_t trimString, ptrdiff_t* newString);

///Removes all trailing occurrences of a specified set of characters from the source string.
///Params:
///    string = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The string to be trimmed.
///    trimString = Type: [in] **[HSTRING](/windows/win32/winrt/hstring)** The characters to remove from <i>string</i>.
///    newString = Type: [out] <b>[**HSTRING**](/windows/win32/winrt/hstring)*</b> The string that remains after all occurrences of
///                characters in the <i>trimString</i> parameter are removed from the end of <i>string</i>, or <b>NULL</b> if
///                <i>trimString</i> contains all of the characters in <i>string</i>.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    trimmed string was created successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
///    </dl> </td> <td width="60%"> <i>newString</i> is <b>NULL</b>, or <i>trimString</i> is empty. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the trimmed
///    string. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsTrimStringEnd(ptrdiff_t string, ptrdiff_t trimString, ptrdiff_t* newString);

///Allocates a mutable character buffer for use in [**HSTRING**](/windows/win32/winrt/hstring) creation.
///Params:
///    length = Type: [in] <b>UINT32</b> The size of the buffer to allocate. A value of zero corresponds to the empty string.
///    charBuffer = Type: [out] <b>WCHAR**</b> The mutable buffer that holds the characters. Note that the buffer already contains a
///                 terminating <b>NULL</b> character.
///    bufferHandle = Type: [out] <b>HSTRING_BUFFER*</b> The preallocated string buffer, or <b>NULL</b> if <i>length</i> is 0.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    [**HSTRING**](/windows/win32/winrt/hstring) was created successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>mutableBuffer</i> or <i>bufferHandle</i> is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MEM_E_INVALID_SIZE</b></dt> </dl> </td> <td
///    width="60%"> The requested [**HSTRING**](/windows/win32/winrt/hstring) allocation size is too large. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
///    [**HSTRING**](/windows/win32/winrt/hstring) buffer. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsPreallocateStringBuffer(uint length, ushort** charBuffer, ptrdiff_t* bufferHandle);

///Creates an [**HSTRING**](/windows/win32/winrt/hstring) from the specified HSTRING_BUFFER.
///Params:
///    bufferHandle = Type: [in] <b>HSTRING_BUFFER</b> The buffer to use for the new [**HSTRING**](/windows/win32/winrt/hstring). You
///                   must use the WindowsPreallocateStringBuffer function to create the HSTRING_BUFFER.
///    string = Type: [out] <b>[**HSTRING**](/windows/win32/winrt/hstring)*</b> The newly created
///             [**HSTRING**](/windows/win32/winrt/hstring) that contains the contents of <i>bufferHandle</i>.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    [**HSTRING**](/windows/win32/winrt/hstring) was created successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>string</i> is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>bufferHandle</i> was not created
///    by calling the WindowsPreallocateStringBuffer function, or the caller has overwritten the terminating NUL
///    character in <i>bufferHandle</i>. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsPromoteStringBuffer(ptrdiff_t bufferHandle, ptrdiff_t* string);

///Discards a preallocated string buffer if it was not promoted to an [**HSTRING**](/windows/win32/winrt/hstring).
///Params:
///    bufferHandle = Type: [in] <b>HSTRING_BUFFER</b> The buffer to discard. The <b>WindowsDeleteStringBuffer</b> function raises an
///                   exception if <i>bufferHandle</i> was not allocated by a call to the WindowsPreallocateStringBuffer function.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    buffer was discarded successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
///    <td width="60%"> <i>bufferHandle</i> is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsDeleteStringBuffer(ptrdiff_t bufferHandle);

///Provides a way to for debuggers to display the value of an Windows Runtime
///[**HSTRING**](/windows/win32/winrt/hstring) in another address space, remotely, or from a dump.
///Params:
///    targetHString = [in] The [**HSTRING**](/windows/win32/winrt/hstring) to inspect.
///    machine = The format of the target address space. Valid values are <b>IMAGE_FILE_MACHINE_AMD64</b> for Win64,
///              <b>IMAGE_FILE_MACHINE_I386</b> for Win32, or <b>IMAGE_FILE_MACHINE_ARM</b> for 32-bit ARM.
///    callback = [in] A callback function to read the string buffer from the target address space. This function is called before
///               the <i>length</i> and <i>targetStringAddress</i> parameters are computed by the <b>WindowsInspectString</b>
///               function.
///    context = [in, optional] Custom context data passed to the callback.
///    length = [out] The length of the string in the target address space, if the call to <i>callback</i> is successful;
///             otherwise, 0.
///    targetStringAddress = [out] The target address of the raw <b>PCWSTR</b>, if the call to <i>callback</i> is successful; otherwise,
///                          <b>NULL</b>.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <ul>
///    <li><b>IMAGE_FILE_MACHINE_AMD64</b> was specified for <i>machine</i>, but the current platform is not Win64,
///    or</li> <li><i>machine</i> is not <b>IMAGE_FILE_MACHINE_AMD64</b>, <b>IMAGE_FILE_MACHINE_I386</b>, or
///    <b>IMAGE_FILE_MACHINE_ARM</b>, or</li> <li><i>targetHString</i> is not a correctly formed
///    [**HSTRING**](/windows/win32/winrt/hstring). </li> </ul> </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-0")
HRESULT WindowsInspectString(size_t targetHString, ushort machine, PINSPECT_HSTRING_CALLBACK callback, 
                             void* context, uint* length, size_t* targetStringAddress);

///Provides a way to for debuggers to display the value of an Windows Runtime
///[**HSTRING**](/windows/win32/winrt/hstring) in another address space, remotely, or from a dump.
///Params:
///    targetHString = [in] The [**HSTRING**](/windows/win32/winrt/hstring) to inspect.
///    machine = The format of the target address space. Valid values are <b>IMAGE_FILE_MACHINE_AMD64</b> for Win64,
///              <b>IMAGE_FILE_MACHINE_I386</b> for Win32, or <b>IMAGE_FILE_MACHINE_ARM</b> for 32-bit ARM.
///    callback = [in] A callback function to read the string buffer from the target address space. This function is called before
///               the <i>length</i> and <i>targetStringAddress</i> parameters are computed by the <b>WindowsInspectString2</b>
///               function.
///    context = [in, optional] Custom context data passed to the callback.
///    length = [out] The length of the string in the target address space, if the call to <i>callback</i> is successful;
///             otherwise, 0.
///    targetStringAddress = [out] The target address of the raw <b>PCWSTR</b>, if the call to <i>callback</i> is successful; otherwise,
///                          <b>NULL</b>.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <ul> <li>The <i>machine</i> value
///    is not <b>IMAGE_FILE_MACHINE_AMD64</b>, <b>IMAGE_FILE_MACHINE_I386</b>, or <b>IMAGE_FILE_MACHINE_ARM</b> or</li>
///    <li><i>targetHString</i> is not a correctly formed [**HSTRING**](/windows/win32/winrt/hstring). </li> </ul> </td>
///    </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-string-l1-1-1")
HRESULT WindowsInspectString2(ulong targetHString, ushort machine, PINSPECT_HSTRING_CALLBACK2 callback, 
                              void* context, uint* length, ulong* targetStringAddress);

///Creates an instance of [IDirect3DDevice](/uwp/api/windows.graphics.directx.direct3d11.idirect3ddevice) from an
///[IDXGIDevice](/windows/desktop/api/dxgi/nn-dxgi-idxgidevice).
///Params:
///    dxgiDevice = Type: **[IDXGIDevice](/windows/desktop/api/dxgi/nn-dxgi-idxgidevice)\*** The
///                 [IDXGIDevice](/windows/desktop/api/dxgi/nn-dxgi-idxgidevice) to create the Direct3DDevice from.
///    graphicsDevice = Type: **[IInspectable](/windows/desktop/api/inspectable/nn-inspectable-iinspectable)\*\*** A Direct3DDevice
///                     instance that wraps the DXGIDevice.
///Returns:
///    Type: [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) If the function succeeds, it returns
///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
///    code](/windows/desktop/com/com-error-codes-10).
///    
@DllImport("d3d11")
HRESULT CreateDirect3D11DeviceFromDXGIDevice(IDXGIDevice dxgiDevice, IInspectable* graphicsDevice);

///Creates an instance of [IDirect3DSurface](/uwp/api/windows.graphics.directx.direct3d11.idirect3dsurface) from an
///[IDXGISurface](/windows/desktop/api/dxgi/nn-dxgi-idxgisurface).
///Params:
///    dxgiSurface = Type: **[IDXGISurface](/windows/desktop/api/dxgi/nn-dxgi-idxgisurface)\*** The
///                  [IDXGISurface](/windows/desktop/api/dxgi/nn-dxgi-idxgisurface) to create the IDirect3D11Surface from.
///    graphicsSurface = Type: **[IInspectable](/windows/desktop/api/inspectable/nn-inspectable-iinspectable)\*\*** An
///                      [IDirect3DSurface](/uwp/api/windows.graphics.directx.direct3d11.idirect3dsurface) instance that wraps the
///                      [IDXGISurface](/windows/desktop/api/dxgi/nn-dxgi-idxgisurface).
///Returns:
///    Type: [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) If the function succeeds, it returns
///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
///    code](/windows/desktop/com/com-error-codes-10).
///    
@DllImport("d3d11")
HRESULT CreateDirect3D11SurfaceFromDXGISurface(IDXGISurface dgxiSurface, IInspectable* graphicsSurface);

///Initializes the Windows Runtime on the current thread with the specified concurrency model.
///Params:
///    initType = Type: <b>RO_INIT_TYPE</b> The concurrency model for the thread. The default is <b>RO_INIT_MULTITHREADED</b>.
///Returns:
///    Type: <b>HRESULT</b> This function can return the standard return values <b>E_INVALIDARG</b>,
///    <b>E_OUTOFMEMORY</b>, and <b>E_UNEXPECTED</b>, as well as the following values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    Windows Runtime was initialized successfully on this thread. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The Windows Runtime is already initialized on this thread.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_E_CHANGED_MODE</b></dt> </dl> </td> <td width="60%"> A previous
///    call to RoInitialize specified the concurrency model for this thread as multithread apartment (MTA). This could
///    also indicate that a change from neutral-threaded apartment to single-threaded apartment has occurred. </td>
///    </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoInitialize(RO_INIT_TYPE initType);

///Closes the Windows Runtime on the current thread.
@DllImport("api-ms-win-core-winrt-l1-1-0")
void RoUninitialize();

///Activates the specified Windows Runtime class.
///Params:
///    activatableClassId = Type: <b>HSTRING</b> The class identifier that is associated with the activatable runtime class.
///    instance = Type: <b>IInspectable**</b> A pointer to the activated instance of the runtime class.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The class
///    was activated successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
///    width="60%"> <i>instance</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CO_E_NOTINITIALIZED</b></dt> </dl> </td> <td width="60%"> The thread has not been initialized in the
///    Windows Runtime by calling the RoInitialize function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The TrustLevel for the class requires a full-trust
///    process. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The
///    IInspectable interface is not implemented by the specified class. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to create an instance of the class. </td> </tr>
///    </table>
///    
@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoActivateInstance(ptrdiff_t activatableClassId, IInspectable* instance);

///Registers an array out-of-process activation factories for a Windows Runtime exe server.
///Params:
///    activatableClassIds = Type: <b>HSTRING*</b> An array of class identifiers that are associated with activatable runtime classes.
///    activationFactoryCallbacks = Type: <b>PFNGETACTIVATIONFACTORY*</b> An array of callback functions that you can use to retrieve the activation
///                                 factories that correspond with <i>activatableClassIds</i>.
///    count = Type: <b>UINT32</b> The number of items in the <i>activatableClassIds</i> and <i>activationFactoryCallbacks</i>
///            arrays.
///    cookie = Type: <b>RO_REGISTRATION_COOKIE*</b> A cookie that identifies the registered factories.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    activation factory was registered successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
///    </dl> </td> <td width="60%"> <i>cookie</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CO_E_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The thread is in a neutral apartment. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>CO_E_NOTINITIALIZED</b></dt> </dl> </td> <td width="60%"> The thread has not
///    been initialized in the Windows Runtime by calling the RoInitialize function. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>CO_E_ALREADYINITIALIZED</b></dt> </dl> </td> <td width="60%"> The factory has been initialized
///    already. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_E_CLASSNOTREG</b></dt> </dl> </td> <td width="60%">
///    The class is not registered as OutOfProc. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoRegisterActivationFactories(char* activatableClassIds, char* activationFactoryCallbacks, uint count, 
                                      ptrdiff_t* cookie);

///Removes an array of registered activation factories from the Windows Runtime.
///Params:
///    cookie = Type: <b>RO_REGISTRATION_COOKIE</b>
@DllImport("api-ms-win-core-winrt-l1-1-0")
void RoRevokeActivationFactories(ptrdiff_t cookie);

///Gets the activation factory for the specified runtime class.
///Params:
///    activatableClassId = Type: <b>HSTRING</b> The ID of the activatable class.
///    iid = Type: <b>REFIID</b> The reference ID of the interface.
///    factory = Type: <b>void**</b> The activation factory.
@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoGetActivationFactory(ptrdiff_t activatableClassId, const(GUID)* iid, void** factory);

///Registers an IApartmentShutdown callback to be invoked when the current apartment shuts down.
///Params:
///    callbackObject = The application-supplied IApartmentShutdown interface.
///    apartmentIdentifier = The identifier for the current apartment.
///    regCookie = A cookie that you can use to unregister the callback.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoRegisterForApartmentShutdown(IApartmentShutdown callbackObject, ulong* apartmentIdentifier, 
                                       ptrdiff_t* regCookie);

///Unregisters a previously registered IApartmentShutdown interface.
///Params:
///    regCookie = A registration cookie obtained from a previous call to the RoRegisterForApartmentShutdown function.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoUnregisterForApartmentShutdown(ptrdiff_t regCookie);

///Gets a unique identifier for the current apartment.
///Params:
///    apartmentIdentifier = A process-unique identifier for the current apartment.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-core-winrt-l1-1-0")
HRESULT RoGetApartmentIdentifier(ulong* apartmentIdentifier);

///Provides a standard IBuffer marshaler to implement the semantics associated with the IBuffer interface when it is
///marshaled.
///Params:
///    bufferMarshaler = pointer to Windows Runtime IBuffer marshaler
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-core-winrt-robuffer-l1-1-0")
HRESULT RoGetBufferMarshaler(IMarshal* bufferMarshaler);

///Gets the current reporting behavior of Windows Runtime error functions.
///Params:
///    pflags = Type: <b>UINT32*</b> A pointer to the bitmask of RO_ERROR_REPORTING_FLAGS values that represents the current
///             error-reporting behavior.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    error-reporting behavior was retrieved successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pflags</i> is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT RoGetErrorReportingFlags(uint* pflags);

///Sets the reporting behavior of Windows Runtime error functions.
///Params:
///    flags = Type: <b>UINT32</b> A bitmask of RO_ERROR_REPORTING_FLAGS values.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    error-reporting behavior was set successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>flags</i> has invalid or undefined bits set. </td>
///    </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT RoSetErrorReportingFlags(uint flags);

///Returns the IRestrictedErrorInfo interface pointer based on the given reference.
///Params:
///    reference = Type: <b>PCWSTR</b> Identifies an error object which contains relevant information for the specific error.
///    ppRestrictedErrorInfo = Type: <b>IRestrictedErrorInfo**</b> The output parameter for the object associated with the given reference.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    operation succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CLASS_E_NOAGGREGATION</b></dt> </dl> </td> <td
///    width="60%"> object does not support aggregation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The reference is invalid. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT RoResolveRestrictedErrorInfoReference(const(wchar)* reference, IRestrictedErrorInfo* ppRestrictedErrorInfo);

///Sets the restricted error information object for the current thread.
///Params:
///    pRestrictedErrorInfo = The restricted error information object associated with the current thread.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT SetRestrictedErrorInfo(IRestrictedErrorInfo pRestrictedErrorInfo);

///Gets the restricted error information object set by a previous call to SetRestrictedErrorInfo in the current logical
///thread.
///Params:
///    ppRestrictedErrorInfo = The restricted error info object associated with the current thread.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The restricted error object was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There
///    is no restricted error object associated with the current thread. Any other error object is removed from the
///    thread. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT GetRestrictedErrorInfo(IRestrictedErrorInfo* ppRestrictedErrorInfo);

///Reports an error and an informative string to an attached debugger.
///Params:
///    error = Type: <b>HRESULT</b> The error code associated with the error condition. If <i>error</i> is a success code, such
///            as <b>S_OK</b>, the function has no effect and returns <b>FALSE</b>. This behavior enables calling the function
///            when no error has occurred without causing an unwanted error message.
///    cchMax = Type: <b>UINT</b> The maximum number of characters in <i>message</i>, excluding the terminating <b>NUL</b>
///             character. If the value is 0, the string is read to the first <b>NUL</b> character or 512 characters, whichever
///             is less. If <i>cchMax</i> is greater than 512, all characters after 512 are ignored.
///    message = Type: <b>PCWSTR</b> An informative string to help developers to correct the reported error condition. The maximum
///              length is 512 characters, including the trailing <b>NUL</b> character; longer strings are truncated. If the
///              string is empty, the function succeeds but no error information is reported. It is recommended that you always
///              provide an informative string. If <i>message</i> is <b>NULL</b>, the function succeeds and reports the generic
///              string in Winerror.h if available or the generic string associated with <b>E_FAIL</b>. This function does not
///              support embedded <b>NUL</b> characters, so only the characters before the first <b>NUL</b> are reported. The
///              <i>message</i> string should be localized.
///Returns:
///    Type: <b>BOOL</b> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The error message was reported successfully. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> <i>message</i> is <b>NULL</b> or points
///    to an empty string, or <i>error</i> is a success code. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
BOOL RoOriginateErrorW(HRESULT error, uint cchMax, const(wchar)* message);

///Reports an error and an informative string to an attached debugger.
///Params:
///    error = Type: <b>HRESULT</b> The error code associated with the error condition. If <i>error</i> is a success code, such
///            as <b>S_OK</b>, the function has no effect and returns <b>FALSE</b>. This behavior enables calling the function
///            when no error has occurred without causing an unwanted error message.
///    message = Type: <b>HSTRING</b> An informative string to help developers to correct the reported error condition. The
///              maximum length is 512 characters, including the trailing <b>NUL</b> character; longer strings are truncated. If
///              the string is empty, the function succeeds but no error information is reported. It is recommended that you
///              always provide an informative string. If <i>message</i> is <b>NULL</b>, the function succeeds and reports the
///              generic string in Winerror.h if available or the generic string associated with <b>E_FAIL</b>. This function does
///              not support embedded <b>NUL</b> characters, so only the characters before the first <b>NUL</b> are reported. The
///              <i>message</i> string should be localized.
///Returns:
///    Type: <b>BOOL</b> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The error message was reported successfully. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> <i>message</i> is <b>NULL</b> or points
///    to an empty string, or <i>error</i> is a success code. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
BOOL RoOriginateError(HRESULT error, ptrdiff_t message);

///Reports a transformed error and an informative string to an attached debugger.
///Params:
///    oldError = Type: <b>HRESULT</b> The original error code associated with the error condition.
///    newError = Type: <b>HRESULT</b> The custom error code to associate with the error condition. If <i>oldError</i> and
///               <i>newError</i> are the same, or both are success codes, such as <b>S_OK</b>, the function has no effect and
///               returns <b>FALSE</b>.
///    cchMax = Type: <b>UINT</b> The maximum number of characters in <i>message</i>, excluding the terminating null character.
///             If the value is 0, the string is read to the first null character or 512 characters, whichever is less. If
///             <i>cchMax</i> is greater than 512, all characters after 512 are ignored.
///    message = Type: <b>PCWSTR</b> An informative string to help developers to correct the reported error condition. The maximum
///              length is 512 characters, including the trailing null character; longer strings are truncated. If the string is
///              empty, the function succeeds but no error information is reported. It is recommended that you always provide an
///              informative string. If <i>message</i> is <b>NULL</b>, the function succeeds and reports the generic string in
///              Winerror.h if available or the generic string associated with E_FAIL. This function does not support embedded
///              null characters, so only the characters before the first null are reported.
///Returns:
///    Type: <b>BOOL</b> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The error message was reported successfully. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> <i>message</i> is <b>NULL</b> or points
///    to an empty string, or <i>oldError</i> and <i>newError</i> are the same, or both are success codes. </td> </tr>
///    </table>
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
BOOL RoTransformErrorW(HRESULT oldError, HRESULT newError, uint cchMax, const(wchar)* message);

///Reports a modified error and an informative string to an attached debugger.
///Params:
///    oldError = Type: <b>HRESULT</b> The original error code associated with the error condition.
///    newError = Type: <b>HRESULT</b> A different error code to associate with the error condition. If <i>oldError</i> and
///               <i>newError</i> are the same, or both are success codes, such as <b>S_OK</b>, the function has no effect and
///               returns <b>FALSE</b>.
///    message = Type: <b>HSTRING</b> An informative string to help developers to correct the reported error condition. The
///              maximum length is 512 characters, including the trailing null character; longer strings are truncated. If the
///              string is empty, the function succeeds but no error information is reported. It is recommended that you always
///              provide an informative string. If <i>message</i> is <b>NULL</b>, the function succeeds and reports the generic
///              string in Winerror.h if available or the generic string associated with E_FAIL. Although the <i>message</i>
///              string is an HSTRING, the <b>RoTransformError</b> function does not support embedded null characters, so only the
///              characters before the first null are reported.
///Returns:
///    Type: <b>BOOL</b> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The error message was reported successfully. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> <i>message</i> is <b>NULL</b> or points
///    to an empty string, or <i>oldError</i> and <i>newError</i> are the same, or both are success codes. </td> </tr>
///    </table>
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
BOOL RoTransformError(HRESULT oldError, HRESULT newError, ptrdiff_t message);

///Saves the current error context so that it's available for later calls to the RoFailFastWithErrorContext function.
///Params:
///    hr = The <b>HRESULT</b> associated with the error.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
HRESULT RoCaptureErrorContext(HRESULT hr);

///Raises a non-continuable exception in the current process.
///Params:
///    hrError = The <b>HRESULT</b> associated with the current error. The exception is raised for any value of <i>hrError</i>.
@DllImport("api-ms-win-core-winrt-error-l1-1-0")
void RoFailFastWithErrorContext(HRESULT hrError);

///Reports an error, an informative string, and an error object to an attached debugger.
///Params:
///    error = The error code associated with the error condition. If <i>error</i> is a success code, like <b>S_OK</b>, the
///            function has no effect and returns <b>FALSE</b>. This behavior enables calling the function when no error has
///            occurred without causing an unwanted error message.
///    message = An informative string to help developers to correct the reported error condition. The maximum length is 512
///              characters, including the trailing <b>NUL</b> character; longer strings are truncated. If the string is empty,
///              the function succeeds but no error information is reported. It is recommended that you always provide an
///              informative string. If <i>message</i> is <b>NULL</b>, the function succeeds and reports the generic string in
///              Winerror.h if available or the generic string associated with <b>E_FAIL</b>. This function does not support
///              embedded <b>NUL</b> characters, so only the characters before the first <b>NUL</b> are reported. The
///              <i>message</i> string should be localized.
///    languageException = An error object that's apartment-agile, in-proc, and marshal-by-value across processes. This object should
///                        implement ILanguageExceptionStackBackTrace and ILanguageExceptionTransform if necessary.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> The error message was reported successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> <i>message</i> is <b>NULL</b> or points to an empty string, or
///    <i>error</i> is a success code. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-1")
BOOL RoOriginateLanguageException(HRESULT error, ptrdiff_t message, IUnknown languageException);

///Removes existing error information from the current thread environment block (TEB).
@DllImport("api-ms-win-core-winrt-error-l1-1-1")
void RoClearError();

///Triggers the Global Error Handler when an unhandled exception occurs.
///Params:
///    pRestrictedErrorInfo = The error to report. Call the GetRestrictedErrorInfo function to get the IRestrictedErrorInfo that represents the
///                           error.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-1")
HRESULT RoReportUnhandledError(IRestrictedErrorInfo pRestrictedErrorInfo);

///Gets the error object that represents the call stack at the point where the error originated
///Params:
///    targetTebAddress = The target thread environment block (TEB).
///    machine = The machine to debug.
///    readMemoryCallback = A callback function to read the buffer from the target TEB address space.
///    context = Custom context data.
///    targetErrorInfoAddress = The address of the error object.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-1")
HRESULT RoInspectThreadErrorInfo(size_t targetTebAddress, ushort machine, 
                                 PINSPECT_MEMORY_CALLBACK readMemoryCallback, void* context, 
                                 size_t* targetErrorInfoAddress);

///Provides a way to for debuggers to inspect a call stack from a target process.
///Params:
///    targetErrorInfoAddress = The address of the error info object in the target process. Get the <i>targetErrorInfoAddress</i> by calling the
///                             RoInspectThreadErrorInfo function.
///    machine = The machine to debug.
///    readMemoryCallback = A callback function to read the buffer from the target TEB address space.
///    context = Custom context data.
///    frameCount = The number of stack frames stored in the error object.
///    targetBackTraceAddress = The stack back trace address in the target process.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-1")
HRESULT RoInspectCapturedStackBackTrace(size_t targetErrorInfoAddress, ushort machine, 
                                        PINSPECT_MEMORY_CALLBACK readMemoryCallback, void* context, uint* frameCount, 
                                        size_t* targetBackTraceAddress);

@DllImport("api-ms-win-core-winrt-error-l1-1-1")
HRESULT RoGetMatchingRestrictedErrorInfo(HRESULT hrIn, IRestrictedErrorInfo* ppRestrictedErrorInfo);

///Triggers the Global Error Handler when a delegate failure occurs.
///Params:
///    punkDelegate = The delegate to report.
///    pRestrictedErrorInfo = The error to report. Call the GetRestrictedErrorInfo function to get the IRestrictedErrorInfo that represents the
///                           error.
@DllImport("api-ms-win-core-winrt-error-l1-1-1")
HRESULT RoReportFailedDelegate(IUnknown punkDelegate, IRestrictedErrorInfo pRestrictedErrorInfo);

///<div class="alert"><b>Note</b> This function is deprecated. Going forward, all Windows 8.1 and Windows 10 apps can
///operate automatically as if error propagation is enabled, and do not need to check dynamically whether error
///propagation is enabled. </div><div> </div>Indicates whether the CoreApplication.UnhandledErrorDetected event occurs
///for the errors that are returned by the delegate registered as a callback function for a Windows Runtime API event or
///the completion of an asynchronous method.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> Indicates that the CoreApplication.UnhandledErrorDetected event occurs for the
///    errors that are returned by the delegate registered as a callback function for a Windows Runtime API event or the
///    completion of an asynchronous method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td>
///    <td width="60%"> Indicates that the CoreApplication.UnhandledErrorDetected event does not occur for the errors
///    that are returned by the delegate registered as a callback function for a Windows Runtime API event or the
///    completion of an asynchronous method. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-error-l1-1-1")
BOOL IsErrorPropagationEnabled();

///Creates a dispenser class.
///Params:
///    rclsid = Type: <b>REFCLSID</b> This parameter must be <b>CLSID_CorMetaDataDispenser</b>.
///    riid = Type: <b>REFIID</b> The interface to implement. This parameter can be either <b>IID_IMetaDataDispenser</b> or
///           <b>IID_IMetaDataDispenserEx</b>.
///    ppv = Type: <b>LPVOID*</b> The dispenser class. The class implements <b>IMetaDataDispenser</b> or
///          <b>IMetaDataDispenserEx.</b>
@DllImport("RoMetadata")
HRESULT MetaDataGetDispenser(const(GUID)* rclsid, const(GUID)* riid, void** ppv);

///Computes the interface identifier (IID) of the interface or delegate type that results when a parameterized interface
///or delegate is instantiated with the specified type arguments.
///Params:
///    nameElementCount = Type: <b>UINT32</b> Number of elements in <i>nameElements.</i>
///    nameElements = Type: <b>PCWSTR*</b> A parsed Windows Runtime type name, as returned by the RoParseTypeName function. For
///                   example, "Windows.Foundation.Collections.IVector`1", and "N1.N2.IFoo".
///    metaDataLocator = Type: <b>const IRoMetaDataLocator</b> A callback to use for resolving metadata. An implementation should use the
///                      RoGetMetaDataFile function to discover the necessary metadata (.winmd) file and examine the metadata to determine
///                      the necessary type information. Because the <b>RoGetMetaDataFile</b> function does not cache results, locators
///                      should cache the results as appropriate for the programming model being implemented.
///    iid = Type: <b>GUID*</b> The IID of the interface or delegate that corresponds with <i>nameElements</i>.
///    pExtra = Type: <b>ROPARAMIIDHANDLE*</b> Handle to the IID that corresponds with <i>nameElements</i>.
///Returns:
///    Type: <b>HRESULT</b> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The call was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory available to complete the task.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The wrong number
///    of type arguments are provided for a parameterized type. </td> </tr> </table> A failure may also occur if a type
///    is inappropriate for the context in which it appears.
///    
@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0")
HRESULT RoGetParameterizedTypeInstanceIID(uint nameElementCount, char* nameElements, 
                                          const(IRoMetaDataLocator) metaDataLocator, GUID* iid, ptrdiff_t* pExtra);

///Frees the handle allocated by RoGetParameterizedTypeInstanceIID.
///Params:
///    extra = Type: <b>ROPARAMIIDHANDLE</b> A handle to the IID.
@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0")
void RoFreeParameterizedTypeExtra(ptrdiff_t extra);

///Gets the type signature used to compute the IID from the last call to RoGetParameterizedTypeInstanceIID with the
///specified handle.
///Params:
///    extra = Type: <b>ROPARAMIIDHANDLE</b> A handle to the IID.
@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0")
byte* RoParameterizedTypeExtraGetTypeSignature(ptrdiff_t extra);

///Retrieves the activatable classes that are registered for a given executable (EXE) server, which was registered under
///the package ID of the calling process.
///Params:
///    serverName = Type: <b>HSTRING</b> The name of the server to retrieve class registrations for. This server name is passed on
///                 the command line when the server is activated.
///    activatableClassIds = Type: <b>HSTRING**</b> A callee-allocated array of activatable class ID strings which the server is registered to
///                          serve. The strings must be released by the caller using the WindowsDeleteString function. The buffer must then be
///                          released using CoTaskMemFree. The server (caller) is responsible for registering the activation factories for
///                          these classes.
///    count = Type: <b>DWORD*</b> The count of activatable class IDs returned in the <i>activatableClassIds</i> array.
///Returns:
///    Type: <b>HRESULT</b> The method returns <b>S_OK</b> on success, otherwise an error code, including the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>REGDB_E_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> An empty server name is provided, the server is
///    not registered, or no classes are registered for this server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The process does not have sufficient permissions to
///    read this server’s registration. </td> </tr> </table>
///    
@DllImport("api-ms-win-core-winrt-registration-l1-1-0")
HRESULT RoGetServerActivatableClasses(ptrdiff_t serverName, ptrdiff_t** activatableClassIds, uint* count);

///Creates a Windows Runtime random access stream for a file.
///Params:
///    filePath = The fully qualified path of the file to encapsulate.
///    accessMode = An AccessMode value that specifies the behavior of the RandomAccessStream that encapsulates the file.
///    riid = A reference to the IID of the interface to retrieve through <i>ppv</i>, typically IID_RandomAccessStream.
///    ppv = When this method returns successfully, contains the interface pointer requested in <i>riid</i>, typically the
///          IRandomAccessStream that encapsulates the file.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0")
HRESULT CreateRandomAccessStreamOnFile(const(wchar)* filePath, uint accessMode, const(GUID)* riid, void** ppv);

///Creates a Windows Runtime random access stream around an IStream base implementation.
///Params:
///    stream = The COM stream to encapsulate.
///    options = One of the BSOS_OPTIONS options that specify the behavior of the RandomAccessStream that encapsulates
///              <i>stream</i>.
///    riid = A reference to the IID of the interface to retrieve through <i>ppv</i>, typically IID_RandomAccessStream.
///    ppv = When this method returns successfully, contains the interface pointer to the RandomAccessStream that encapsulates
///          <i>stream</i> requested in <i>riid</i>.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0")
HRESULT CreateRandomAccessStreamOverStream(IStream stream, BSOS_OPTIONS options, const(GUID)* riid, void** ppv);

///Creates an IStream around a Windows Runtime IRandomAccessStream object.
///Params:
///    randomAccessStream = The source IRandomAccessStream.
///    riid = A reference to the IID of the interface to retrieve through <i>ppv</i>, typically IID_IStream. This object
///           encapsulates <i>randomAccessStream</i>.
///    ppv = When this method returns successfully, contains the interface pointer requested in <i>riid</i>, typically
///          IStream.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0")
HRESULT CreateStreamOverRandomAccessStream(IUnknown randomAccessStream, const(GUID)* riid, void** ppv);


// Interfaces

///Enables retrieving an agile reference to an object.
@GUID("C03F6A43-65A4-9818-987E-E0B810D2A6F2")
interface IAgileReference : IUnknown
{
    HRESULT Resolve(const(GUID)* riid, void** ppvObjectReference);
}

///Enables registration of an apartment shutdown notification handler.
@GUID("A2F05A09-27A2-42B5-BC0E-AC163EF49D9B")
interface IApartmentShutdown : IUnknown
{
    ///Called when a registered apartment is shut down.
    ///Params:
    ///    ui64ApartmentIdentifier = The apartment Identifier of the apartment that is shutting down
    void OnUninitialize(ulong ui64ApartmentIdentifier);
}

///Provides functionality required for all Windows Runtime classes.
@GUID("AF86E2E0-B12D-4C6A-9C5A-D7AA65101E90")
interface IInspectable : IUnknown
{
    ///Gets the interfaces that are implemented by the current Windows Runtime class.
    ///Params:
    ///    iidCount = Type: <b>ULONG*</b> The number of interfaces that are implemented by the current Windows Runtime object,
    ///               excluding the IUnknown and IInspectable implementations.
    ///    iids = Type: <b>IID**</b> A pointer to an array that contains an IID for each interface implemented by the current
    ///           Windows Runtime object. The IUnknown and IInspectable interfaces are excluded.
    ///Returns:
    ///    Type: <b>HRESULT</b> This function can return the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    HSTRING was created successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> Failed to allocate <i>iids</i>. </td> </tr> </table>
    ///    
    HRESULT GetIids(uint* iidCount, char* iids);
    ///Gets the fully qualified name of the current Windows Runtime object.
    ///Params:
    ///    className = Type: <b>HSTRING*</b> The fully qualified name of the current Windows Runtime object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This function can return the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>className</i> string was created successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate <i>className</i> string. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_ILLEGAL_METHOD_CALL</b></dt> </dl> </td> <td width="60%">
    ///    <i>className</i> refers to a class factory or a static interface. </td> </tr> </table>
    ///    
    HRESULT GetRuntimeClassName(ptrdiff_t* className);
    ///Gets the trust level of the current Windows Runtime object.
    ///Params:
    ///    trustLevel = Type: <b>TrustLevel*</b> The trust level of the current Windows Runtime object. The default is
    ///                 <b>BaseLevel</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method always returns <b>S_OK</b>.
    ///    
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

///Enables access to the members of the InputPane class in a desktop app.
@GUID("75CF2C57-9195-4931-8332-F0B409E916AF")
interface IInputPaneInterop : IInspectable
{
    ///Gets an instance of an InputPane object for the specified window.
    ///Params:
    ///    appWindow = The window for which you want to get the InputPane object.
    ///    riid = The interface identifier for the interface that you want to get in the <i>inputPane</i> parameter. This value
    ///           is typically <b>IID_IInputPane</b> or <b>IID_IInputPane2</b>, as defined in Windows.UI.ViewManagement.h.
    ///    inputPane = The InputPane object for the window that the <i>appWindow</i> parameter specifies. This parameter is
    ///                typically a pointer to an <b>IInputPane</b> or <b>IInputPane2</b> interface, as defined in
    ///                Windows.UI.ViewManagement.idl.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** inputPane);
}

///Enables access to PlayToManager methods in a Windows Store app that manages multiple windows.
@GUID("24394699-1F2C-4EB3-8CD7-0EC1DA42A540")
interface IPlayToManagerInterop : IInspectable
{
    ///Gets the PlayToManager instance for the specified window.
    ///Params:
    ///    appWindow = The window to get the PlayToManager instance for.
    ///    riid = The reference ID of the specified window.
    ///    playToManager = The PlayToManager instance for the specified window.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** playToManager);
    ///Displays the Play To UI for the specified window.
    ///Params:
    ///    appWindow = The window to show the Play To UI for.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ShowPlayToUIForWindow(HWND appWindow);
}

@GUID("9CA31010-1484-4587-B26B-DDDF9F9CAECD")
interface IPrinting3DManagerInterop : IInspectable
{
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** printManager);
    HRESULT ShowPrintUIForWindowAsync(HWND appWindow, const(GUID)* riid, void** asyncOperation);
}

///Enables access to PrintManager methods in a Windows Store app that manages multiple windows.
@GUID("C5435A42-8D43-4E7B-A68A-EF311E392087")
interface IPrintManagerInterop : IInspectable
{
    ///Gets the PrintManager instance for the specified window.
    ///Params:
    ///    appWindow = The window to get the PrintManager instance for.
    ///    riid = The reference ID of the specified window.
    ///    printManager = The PrintManager instance for the specified window.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** printManager);
    ///Displays the UI for printing content for the specified window.
    ///Params:
    ///    appWindow = The window to show the print UI for.
    ///    riid = The reference ID of the specified window.
    ///    asyncOperation = The asynchronous operation that reports completion.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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

///Provides Win32 apps with access to certain functions of
///[WebAuthenticationCoreManager](/uwp/api/windows.security.authentication.web.core.webauthenticationcoremanager) that
///are otherwise available only to UWP apps.
@GUID("F4B8E804-811E-4436-B69C-44CB67B72084")
interface IWebAuthenticationCoreManagerInterop : IInspectable
{
    ///Asynchronously requests a token from a web account provider. If necessary, the user is prompted to enter their
    ///credentials.
    ///Params:
    ///    appWindow = Type: **[HWND](/windows/win32/winprog/windows-data-types)** The window to be used as the owner for the window
    ///                prompting the user for credentials, in case such a window becomes necessary.
    ///    request = Type: **[IInspectable](../inspectable/nn-inspectable-iinspectable.md)\*** The web token request, given as an
    ///              instance of the [WebTokenRequest](/uwp/api/windows.security.authentication.web.core.webtokenrequest) class
    ///              type-casted to the [IInspectable](../inspectable/nn-inspectable-iinspectable.md) interface.
    ///    riid = Type: **REFIID** Must be a reference to the [interface identifier
    ///           (IID)](/openspecs/windows_protocols/ms-oaut/5583e1b8-454c-4147-9f56-f72416a15bee
    ///    asyncInfo = Type: **void\*\*** The address of a pointer to
    ///                [IAsyncOperation](/uwp/api/windows.foundation.iasyncoperation-1)\<[WebTokenRequestResult](/uwp/api/windows.security.authentication.web.core.webtokenrequestresult)\>.
    ///                On successful return from this method, the pointer will be set to the asynchronous request operation object
    ///                for the request operation just started.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** A status code for the attempt to start
    ///    the asynchronous request operation.
    ///    
    HRESULT RequestTokenForWindowAsync(HWND appWindow, IInspectable request, const(GUID)* riid, void** asyncInfo);
    ///Asynchronously requests a token from a web account provider. If necessary, the user is prompted to enter their
    ///credentials.
    ///Params:
    ///    appWindow = Type: **[HWND](/windows/win32/winprog/windows-data-types)** The window to be used as the owner for the window
    ///                prompting the user for credentials, in case such a window becomes necessary.
    ///    request = Type: **[IInspectable](../inspectable/nn-inspectable-iinspectable.md)\*** The web token request, given as an
    ///              instance of the [WebTokenRequest](/uwp/api/windows.security.authentication.web.core.webtokenrequest) class
    ///              type-casted to the [IInspectable](../inspectable/nn-inspectable-iinspectable.md) interface.
    ///    webAccount = Type: **[IInspectable](../inspectable/nn-inspectable-iinspectable.md)\*** The web account for the request,
    ///                 given as an instance of the [WebAccount](/uwp/api/windows.security.credentials.webaccount) class type-casted
    ///                 to the [IInspectable](../inspectable/nn-inspectable-iinspectable.md) interface.
    ///    riid = Type: **REFIID** Must refer to the [interface identifier
    ///           (IID)](/openspecs/windows_protocols/ms-oaut/bbde795f-5398-42d8-9f59-3613da03c318) for the interface
    ///           [IAsyncOperation](/uwp/api/windows.foundation.iasyncoperation-1)\<[WebTokenRequestResult](/uwp/api/windows.security.authentication.web.core.webtokenrequestresult)\>.
    ///           This IID is automatically generated, and you can obtain it using code like this: ```cppwinrt using
    ///           winrt::Windows::Foundation::IAsyncOperation; using
    ///           winrt::Windows::Security::Authentication::Web::Core::WebTokenRequestResult; constexpr winrt::guid
    ///           iidAsyncRequestResult{ winrt::guid_of<IAsyncOperation<WebTokenRequestResult>>() }; ```
    ///    asyncInfo = Type: **void\*\*** The address of a pointer to
    ///                [IAsyncOperation](/uwp/api/windows.foundation.iasyncoperation-1)\<[WebTokenRequestResult](/uwp/api/windows.security.authentication.web.core.webtokenrequestresult)\>.
    ///                On successful return from this method, the pointer will be set to the asynchronous request operation object
    ///                for the request operation just started.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** A status code for the attempt to start
    ///    the asynchronous request operation.
    ///    
    HRESULT RequestTokenWithWebAccountForWindowAsync(HWND appWindow, IInspectable request, IInspectable webAccount, 
                                                     const(GUID)* riid, void** asyncInfo);
}

///Represents a high-performance API for displaying a single page of a Portable Document Format (PDF) file.
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
    ///For a [DisplaySurface](/uwp/api/windows.devices.display.core.displaysurface) or a
    ///[DisplayFence](/uwp/api/windows.devices.display.core.displayfence) object, creates a shared handle that can be
    ///used for interop with Direct3D or other graphics APIs.
    ///Params:
    ///    pObject = A pointer to the **IUnknown** interface of a
    ///              [DisplaySurface](/uwp/api/windows.devices.display.core.displaysurface) or a
    ///              [DisplayFence](/uwp/api/windows.devices.display.core.displayfence) object.
    ///    pSecurityAttributes = A pointer to a [SECURITY_ATTRIBUTES](/previous-versions/windows/desktop/legacy/aa379560(v=vs.85)) structure
    ///                          that contains two separate but related data members: an optional security descriptor, and a Boolean value
    ///                          that determines whether child processes can inherit the returned handle. Set this parameter to `nullptr` if
    ///                          you want child processes that the application might create to not inherit the handle returned by
    ///                          **CreateSharedHandle**, and if you want the resource that is associated with the returned handle to get a
    ///                          default security descriptor. The *lpSecurityDescriptor* member of the structure specifies a
    ///                          [SECURITY_DESCRIPTOR](../winnt/ns-winnt-security_descriptor.md) for the resource. Set this member to
    ///                          `nullptr` if you want the runtime to assign a default security descriptor to the resource that is associated
    ///                          with the returned handle. The access control lists (ACLs) in the default security descriptor for the resource
    ///                          come from the primary or impersonation token of the creator. For more info, see [Synchronization object
    ///                          security and access rights](/windows/win32/sync/synchronization-object-security-and-access-rights).
    ///    Access = The requested access rights to the resource. In addition to the [Generic access
    ///             rights](/windows/win32/secauthz/generic-access-rights), a surface can use these values. -
    ///             **DXGI_SHARED_RESOURCE_READ** (0x80000000L). Specifies read access to the resource. -
    ///             **DXGI_SHARED_RESOURCE_WRITE** (1). Specifies write access to the resource. You can combine these values by
    ///             using a bitwise OR operation. If *pObject* is a fence, then you must use **GENERIC_ALL**.
    ///    Name = Type: **[LPCWSTR](/windows/win32/winprog/windows-data-types)** A null-terminated Unicode string that contains
    ///           the name to associate with the shared heap. The name is limited to **MAX_PATH** characters. Name comparison
    ///           is case-sensitive. If *Name* matches the name of an existing resource, then **CreateSharedHandle** fails with
    ///           [DXGI_ERROR_NAME_ALREADY_EXISTS](/windows/win32/direct3ddxgi/dxgi-error). This occurs because these objects
    ///           share the same namespace. The name can have a "Global\" or "Local\" prefix to explicitly create the object in
    ///           the global or session namespace. The remainder of the name can contain any character except the backslash
    ///           character (`\`). For more information, see [Kernel object
    ///           namespaces](/windows/win32/termserv/kernel-object-namespaces). Fast user-switching is implemented using
    ///           Terminal Services sessions. Kernel object names must follow the guidelines outlined for Terminal Services so
    ///           that applications can support multiple users. The object can be created in a private namespace. For more
    ///           information, see [Object namespaces](/windows/win32/sync/object-namespaces).
    ///    pHandle = A pointer to a **HANDLE** that receives that new shared handle.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** This method returns **S_OK** if it
    ///    succeeded, otherwise a failure code indicating why it failed. If it succeeded, then *pHandle* will always
    ///    point to the newly created handle.
    ///    
    HRESULT CreateSharedHandle(IInspectable pObject, const(SECURITY_ATTRIBUTES)* pSecurityAttributes, uint Access, 
                               ptrdiff_t Name, HANDLE* pHandle);
    ///Opens a handle for shared primary surfaces, shared fences, and source presentation handles.
    ///Params:
    ///    NTHandle = Type: **[HANDLE](/windows/win32/winprog/windows-data-types)** An NT handle for a shared primary surface,
    ///               shared fence, or source presentation handle.
    ///    riid = Type: **REFIID** A reference to the interface identifier (IID) for the default interface of one of the
    ///           following Windows Runtime classes. An IID is a **[GUID](../guiddef/ns-guiddef-guid.md)**. *
    ///           [IDisplaySurface](/uwp/api/windows.devices.display.core.displaysurface) *
    ///           [IDisplayFence](/uwp/api/windows.devices.display.core.displayfence) *
    ///           [IDisplaySource](/uwp/api/windows.devices.display.core.displaysource)
    ///    ppvObj = Type: **void\*\*** A pointer to a memory block that receives a pointer to the interface specified by the
    ///             *riid* argument.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** Returns **S_OK** on success, or a
    ///    failure code describing the problem on failure.
    ///    
    HRESULT OpenSharedHandle(HANDLE NTHandle, GUID riid, void** ppvObj);
}

@GUID("A6BA4205-E59E-4E71-B25B-4E436D21EE3D")
interface IDisplayPathInterop : IUnknown
{
    ///Creates an NT handle for controlling access to scanout on this path. A compositor application can choose to
    ///broker access to paths that it controls using these objects. Your application can call
    ///[IDisplayDeviceInterop.OpenSharedHandle](nf-windows-devices-display-core-interop-idisplaydeviceinterop-opensharedhandle.md)
    ///to create a [DisplaySource](/uwp/api/windows.devices.display.core.displaysource) object from this handle.
    ///Params:
    ///    pValue = Type: **[HANDLE](/windows/win32/winprog/windows-data-types)\*** A pointer to a **HANDLE** that receives the
    ///             newly created source presentation object.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** This method returns **S_OK** if it
    ///    succeeded, otherwise a failure code indicating why it failed. If it succeeded, then *pValue* will always
    ///    point to the newly created handle.
    ///    
    HRESULT CreateSourcePresentationHandle(HANDLE* pValue);
    ///Gets the unique identifier of the [DisplaySource](/uwp/api/windows.devices.display.core.displaysource) object.
    ///Params:
    ///    pSourceId = The unique identifier.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** This method returns **S_OK** if it
    ///    succeeded, otherwise a failure code indicating why it failed.
    ///    
    HRESULT GetSourceId(uint* pSourceId);
}

@GUID("3628E81B-3CAC-4C60-B7F4-23CE0E0C3356")
interface IGraphicsCaptureItemInterop : IUnknown
{
    ///Targets a single window for the creation of a graphics capture item.
    ///Params:
    ///    window = Type: **HWND** The window handle that represents the window to capture.
    ///    riid = Type: **REFIID** GUID for the type returned. Supported value:
    ///           [GraphicsCaptureItem](/uwp/api/windows.graphics.capture.graphicscaptureitem).
    ///    result = Type: **void\*\*** Out pointer for the object to receive.
    ///Returns:
    ///    Type: **HRESULT** The return error code.
    ///    
    HRESULT CreateForWindow(HWND window, const(GUID)* riid, void** result);
    ///Targets a monitor(s) for the creation of a graphics capture item.
    ///Params:
    ///    monitor = Type: **HMONITOR** The monitor handle that represents the monitor to capture.
    ///    riid = Type: **REFIID** GUID for the type returned. Supported value:
    ///           [GraphicsCaptureItem](/uwp/api/windows.graphics.capture.graphicscaptureitem).
    ///    result = Type: **void\*\*** Out pointer for the object to receive.
    ///Returns:
    ///    Type: **HRESULT** The return error code.
    ///    
    HRESULT CreateForMonitor(ptrdiff_t monitor, const(GUID)* riid, void** result);
}

///IDirect3DDxgiInterfaceAccess is a COM interface, which must be implemented by anything that implements
///[IDirect3DDevice](/uwp/api/windows.graphics.directx.direct3d11.idirect3ddevice) or
///[IDirect3DSurface](/uwp/api/windows.graphics.directx.direct3d11.idirect3dsurface). **ID3D12GraphicsCommandList5**
///inherits from the [IUnknown interface](/windows/desktop/api/unknwn/nn-unknwn-iunknown).
@GUID("A9B3D012-3DF2-4EE3-B8D1-8695F457D3C1")
interface IDirect3DDxgiInterfaceAccess : IUnknown
{
    HRESULT GetInterface(const(GUID)* iid, void** p);
}

///Represents a software bitmap.
@GUID("94BC8415-04EA-4B2E-AF13-4DE95AA898EB")
interface ISoftwareBitmapNative : IInspectable
{
    HRESULT GetData(const(GUID)* riid, void** ppv);
}

///Creates instances of ISoftwareBitmapNative.
@GUID("C3C181EC-2914-4791-AF02-02D224A10B43")
interface ISoftwareBitmapNativeFactory : IInspectable
{
    HRESULT CreateFromWICBitmap(IWICBitmap data, BOOL forceReadOnly, const(GUID)* riid, void** ppv);
    HRESULT CreateFromMF2DBuffer2(IMF2DBuffer2 data, const(GUID)* subtype, uint width, uint height, 
                                  BOOL forceReadOnly, const(MFVideoArea)* minDisplayAperture, const(GUID)* riid, 
                                  void** ppv);
}

///Represents a frame of audio data.
@GUID("20BE1E2E-930F-4746-9335-3C332F255093")
interface IAudioFrameNative : IInspectable
{
    HRESULT GetData(const(GUID)* riid, void** ppv);
}

///Represents a frame of video data.
@GUID("26BA702B-314A-4620-AAF6-7A51AA58FA18")
interface IVideoFrameNative : IInspectable
{
    HRESULT GetData(const(GUID)* riid, void** ppv);
    HRESULT GetDevice(const(GUID)* riid, void** ppv);
}

///Creates instances of IAudioFrameNative.
@GUID("7BD67CF8-BF7D-43E6-AF8D-B170EE0C0110")
interface IAudioFrameNativeFactory : IInspectable
{
    HRESULT CreateFromMFSample(IMFSample data, BOOL forceReadOnly, const(GUID)* riid, void** ppv);
}

///Creates instances of IVideoFrameNative.
@GUID("69E3693E-8E1E-4E63-AC4C-7FDC21D9731D")
interface IVideoFrameNativeFactory : IInspectable
{
    HRESULT CreateFromMFSample(IMFSample data, const(GUID)* subtype, uint width, uint height, BOOL forceReadOnly, 
                               const(MFVideoArea)* minDisplayAperture, IMFDXGIDeviceManager device, 
                               const(GUID)* riid, void** ppv);
}

///Provides the implementation of a shared fixed-size surface for Direct2D drawing. <div class="alert"><b>Note</b> If
///the surface is larger than the screen size, use IVirtualSurfaceImageSourceNative instead.</div><div> </div>
@GUID("F2E9EDC1-D307-4525-9886-0FAFAA44163C")
interface ISurfaceImageSourceNative : IUnknown
{
    HRESULT SetDevice(IDXGIDevice device);
    HRESULT BeginDraw(RECT updateRect, IDXGISurface* surface, POINT* offset);
    HRESULT EndDraw();
}

///Provides an interface for the implementation of drawing behaviors when a VirtualSurfaceImageSource requests an
///update.
@GUID("DBF2E947-8E6C-4254-9EEE-7738F71386C9")
interface IVirtualSurfaceUpdatesCallbackNative : IUnknown
{
    HRESULT UpdatesNeeded();
}

///Provides the implementation of a large (greater than the screen size) shared surface for DirectX drawing.
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

///Provides interoperation between XAML and a DirectX swap chain.
@GUID("43BEBD4E-ADD5-4035-8F85-5608D08E9DC9")
interface ISwapChainBackgroundPanelNative : IUnknown
{
    HRESULT SetSwapChain(IDXGISwapChain swapChain);
}

///Enables performing bulk operations across all SurfaceImageSource objects created in the same process.
@GUID("4C8798B7-1D88-4A0F-B59B-B93F600DE8C8")
interface ISurfaceImageSourceManagerNative : IUnknown
{
    HRESULT FlushAllSurfacesWithDevice(IUnknown device);
}

///Provides the implementation of a shared Microsoft DirectX surface which is displayed in a SurfaceImageSource or
///VirtualSurfaceImageSource.
@GUID("54298223-41E1-4A41-9C08-02E8256864A1")
interface ISurfaceImageSourceNativeWithD2D : IUnknown
{
    HRESULT SetDevice(IUnknown device);
    HRESULT BeginDraw(const(RECT)* updateRect, const(GUID)* iid, void** updateObject, POINT* offset);
    HRESULT EndDraw();
    HRESULT SuspendDraw();
    HRESULT ResumeDraw();
}

///Provides interoperation between XAML and a DirectX swap chain. Unlike SwapChainBackgroundPanel, a
///<b>SwapChainPanel</b> can appear at any level in the XAML display tree, and more than 1 can be present in any given
///tree.
@GUID("F92F19D2-3ADE-45A6-A20C-F6F1EA90554B")
interface ISwapChainPanelNative : IUnknown
{
    HRESULT SetSwapChain(IDXGISwapChain swapChain);
}

///Provides interoperation between XAML and a DirectX swap chain. Unlike SwapChainBackgroundPanel, a
///<b>SwapChainPanel</b> can appear at any level in the XAML display tree, and more than 1 can be present in any given
///tree.
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

///Native interoperation interface that allows drawing on a surface object using a RECT to define the area to draw into.
///This interface is available in C++ only.
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
    ///Reads back the contents of a composition drawing surface (or a composition virtual drawing surface).
    ///Params:
    ///    destinationResource = Type: **[IUnknown](../unknwn/nn-unknwn-iunknown.md)\*** Represents the Direct3D texture that will receive the
    ///                          copy. You must have created this resource on the same Direct3D device as the one associated with the
    ///                          [CompositionGraphicsDevice](/uwp/api/Windows.UI.Composition.CompositionGraphicsDevice) that was used to
    ///                          create the source composition drawing surface (or composition virtual drawing surface).
    ///    destinationOffsetX = Type: **int** The x-coordinate of an offset (into *destinationResource*) where the copy will be performed. No
    ///                         pixels above or to the left of this offset are changed by the copy operation. The argument can't be negative.
    ///    destinationOffsetY = Type: **int** The y-coordinate of an offset (into *destinationResource*) where the copy will be performed. No
    ///                         pixels above or to the left of this offset are changed by the copy operation. The argument can't be negative.
    ///    sourceRectangle = Type: **const [RECT](../windef/ns-windef-rect.md)\*** An optional pointer to a constant **RECT** representing
    ///                      the rectangle on the source surface to copy out. The rectangle can't exceed the bounds of the source surface.
    ///                      In order to have enough room to receive the requested pixels, the destination resource must have at least as
    ///                      many pixels as the *destinationOffsetX* and *Y* parameters plus the width/height of this rectangle. If this
    ///                      parameter is null, then the entire source surface is copied (and the source surface size is used to validate
    ///                      the size of the destination resource).
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** **S_OK** if successful, otherwise
    ///    returns an [HRESULT](/windows/win32/com/structure-of-com-error-codes) error code indicating the reason for
    ///    failure. Also see [COM Error Codes (UI, Audio, DirectX, Codec)](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CopySurface(IUnknown destinationResource, int destinationOffsetX, int destinationOffsetY, 
                        const(RECT)* sourceRectangle);
}

///A native interoperation interface that allows getting and setting the graphics device. This is interface is available
///in C++ only.
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

///Represents the details of an error, including restricted error information.
@GUID("82BA7092-4C88-427D-A7BC-16DD93FEB67E")
interface IRestrictedErrorInfo : IUnknown
{
    ///Returns information about an error, including the restricted error description.
    ///Params:
    ///    description = Type: <b>BSTR*</b> The error description.
    ///    error = Type: <b>HRESULT*</b> The error code associated with the error condition.
    ///    restrictedDescription = Type: <b>BSTR*</b> The restricted error description.
    ///    capabilitySid = TBD
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetErrorDetails(BSTR* description, int* error, BSTR* restrictedDescription, BSTR* capabilitySid);
    ///Returns a reference to restricted error information.
    ///Params:
    ///    reference = Type: <b>BSTR*</b> A reference to the error information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetReference(BSTR* reference);
}

///Enables retrieving the IUnknown pointer stored in the error info with the call to RoOriginateLanguageException.
@GUID("04A2DBF3-DF83-116C-0946-0812ABF6E07D")
interface ILanguageExceptionErrorInfo : IUnknown
{
    ///Gets the stored IUnknown object from the error object.
    ///Params:
    ///    languageException = The stored IUnknown object from the error object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLanguageException(IUnknown* languageException);
}

///Allows language projections to make available to the system any and all context from an exception that gets thrown
///from the context of a catch handler that catches a different exception.
@GUID("FEB5A271-A6CD-45CE-880A-696706BADC65")
interface ILanguageExceptionTransform : IUnknown
{
    ///Retrieves the transformed restricted error info.
    ///Params:
    ///    restrictedErrorInfo = A pointer to an IRestrictedErrorInfo object that contains the restricted error info.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTransformedRestrictedErrorInfo(IRestrictedErrorInfo* restrictedErrorInfo);
}

///Allows projections to provide custom stack trace for that exception.
@GUID("CBE53FB5-F967-4258-8D34-42F5E25833DE")
interface ILanguageExceptionStackBackTrace : IUnknown
{
    ///Retrieves the back stack trace.
    ///Params:
    ///    maxFramesToCapture = The maximum number of frames to capture.
    ///    stackBackTrace = An array containing the stack back trace; the maximum size is the <i>maxFramesToCapture</i>.
    ///    framesCaptured = On success, contains a pointer to the number of frames actually captured.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStackBackTrace(uint maxFramesToCapture, char* stackBackTrace, uint* framesCaptured);
}

///Enables language projections to provide and retrieve error information as with ILanguageExceptionErrorInfo, with the
///additional benefit of working across language boundaries.
@GUID("5746E5C4-5B97-424C-B620-2822915734DD")
interface ILanguageExceptionErrorInfo2 : ILanguageExceptionErrorInfo
{
    ///Retrieves the previous language exception error information object.
    ///Params:
    ///    previousLanguageExceptionErrorInfo = Pointer to an ILanguageExceptionErrorInfo2 object that contains the previous error information object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPreviousLanguageExceptionErrorInfo(ILanguageExceptionErrorInfo2* previousLanguageExceptionErrorInfo);
    ///Captures the context of an exception across a language boundary and across threads.
    ///Params:
    ///    languageException = An error object that's apartment-agile, in-proc, and marshal-by-value across processes.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CapturePropagationContext(IUnknown languageException);
    ///Retrieves the propagation context head.
    ///Params:
    ///    propagatedLanguageExceptionErrorInfoHead = On success, returns an ILanguageExceptionErrorInfo2 object that represents the head of the propagation
    ///                                               context.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPropagationContextHead(ILanguageExceptionErrorInfo2* propagatedLanguageExceptionErrorInfoHead);
}

///Represents a buffer as an array of bytes.
@GUID("905A0FEF-BC53-11DF-8C49-001E4FC686DA")
interface IBufferByteAccess : IUnknown
{
    ///Gets the array of bytes in the buffer.
    ///Params:
    ///    value = The byte array.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Buffer(ubyte** value);
}

///Provides a metadata locator with a destination for the metadata it has discovered. This member supports the Windows
///Runtime infrastructure and is not intended to be used directly from your code.
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

///Enables the RoGetParameterizedTypeInstanceIID function to access run-time metadata. Implement
///<b>IRoMetaDataLocator</b> when you're implementing programming language bindings to enable a language to call Windows
///platform APIs by using Windows metadata (.winmd) files.
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
