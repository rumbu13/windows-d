module windows.upnp;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;

extern(Windows):


// Interfaces

@GUID("4C1FC63A-695C-47E8-A339-1A194BE3D0B8")
struct UIAnimationManager;

@GUID("D25D8842-8884-4A4A-B321-091314379BDD")
struct UIAnimationManager2;

@GUID("1D6322AD-AA85-4EF5-A828-86D71067D145")
struct UIAnimationTransitionLibrary;

@GUID("812F944A-C5C8-4CD9-B0A6-B3DA802F228D")
struct UIAnimationTransitionLibrary2;

@GUID("8A9B1CDD-FCD7-419C-8B44-42FD17DB1887")
struct UIAnimationTransitionFactory;

@GUID("84302F97-7F7B-4040-B190-72AC9D18E420")
struct UIAnimationTransitionFactory2;

@GUID("BFCD4A0C-06B6-4384-B768-0DAA792C380E")
struct UIAnimationTimer;

@GUID("E2085F28-FEB7-404A-B8E7-E659BDEAAA02")
struct UPnPDeviceFinder;

@GUID("B9E84FFD-AD3C-40A4-B835-0882EBCBAAA8")
struct UPnPDevices;

@GUID("A32552C5-BA61-457A-B59A-A2561E125E33")
struct UPnPDevice;

@GUID("C0BC4B4A-A406-4EFC-932F-B8546B8100CC")
struct UPnPServices;

@GUID("C624BA95-FBCB-4409-8C03-8CCEEC533EF1")
struct UPnPService;

@GUID("1D8A9B47-3A28-4CE2-8A4B-BD34E45BCEEB")
struct UPnPDescriptionDocument;

@GUID("181B54FC-380B-4A75-B3F1-4AC45E9605B0")
struct UPnPDeviceFinderEx;

@GUID("33FD0563-D81A-4393-83CC-0195B1DA2F91")
struct UPnPDescriptionDocumentEx;

@GUID("204810B9-73B2-11D4-BF42-00B0D0118B56")
struct UPnPRegistrar;

@GUID("2E5E84E9-4049-4244-B728-2D24227157C7")
struct UPnPRemoteEndpointInfo;

@GUID("ADDA3D55-6F72-4319-BFF9-18600A539B10")
interface IUPnPDeviceFinder : IDispatch
{
    HRESULT FindByType(BSTR bstrTypeURI, uint dwFlags, IUPnPDevices* pDevices);
    HRESULT CreateAsyncFind(BSTR bstrTypeURI, uint dwFlags, IUnknown punkDeviceFinderCallback, int* plFindData);
    HRESULT StartAsyncFind(int lFindData);
    HRESULT CancelAsyncFind(int lFindData);
    HRESULT FindByUDN(BSTR bstrUDN, IUPnPDevice* pDevice);
}

@GUID("E3BF6178-694E-459F-A5A6-191EA0FFA1C7")
interface IUPnPAddressFamilyControl : IUnknown
{
    HRESULT SetAddressFamily(int dwFlags);
    HRESULT GetAddressFamily(int* pdwFlags);
}

@GUID("0405AF4F-8B5C-447C-80F2-B75984A31F3C")
interface IUPnPHttpHeaderControl : IUnknown
{
    HRESULT AddRequestHeaders(BSTR bstrHttpHeaders);
}

@GUID("415A984A-88B3-49F3-92AF-0508BEDF0D6C")
interface IUPnPDeviceFinderCallback : IUnknown
{
    HRESULT DeviceAdded(int lFindData, IUPnPDevice pDevice);
    HRESULT DeviceRemoved(int lFindData, BSTR bstrUDN);
    HRESULT SearchComplete(int lFindData);
}

@GUID("3F8C8E9E-9A7A-4DC8-BC41-FF31FA374956")
interface IUPnPServices : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppunk);
    HRESULT get_Item(BSTR bstrServiceId, IUPnPService* ppService);
}

@GUID("A295019C-DC65-47DD-90DC-7FE918A1AB44")
interface IUPnPService : IDispatch
{
    HRESULT QueryStateVariable(BSTR bstrVariableName, VARIANT* pValue);
    HRESULT InvokeAction(BSTR bstrActionName, VARIANT vInActionArgs, VARIANT* pvOutActionArgs, VARIANT* pvRetVal);
    HRESULT get_ServiceTypeIdentifier(BSTR* pVal);
    HRESULT AddCallback(IUnknown pUnkCallback);
    HRESULT get_Id(BSTR* pbstrId);
    HRESULT get_LastTransportStatus(int* plValue);
}

@GUID("4D65FD08-D13E-4274-9C8B-DD8D028C8644")
interface IUPnPAsyncResult : IUnknown
{
    HRESULT AsyncOperationComplete(ulong ullRequestID);
}

@GUID("098BDAF5-5EC1-49E7-A260-B3A11DD8680C")
interface IUPnPServiceAsync : IUnknown
{
    HRESULT BeginInvokeAction(BSTR bstrActionName, VARIANT vInActionArgs, IUPnPAsyncResult pAsyncResult, 
                              ulong* pullRequestID);
    HRESULT EndInvokeAction(ulong ullRequestID, VARIANT* pvOutActionArgs, VARIANT* pvRetVal);
    HRESULT BeginQueryStateVariable(BSTR bstrVariableName, IUPnPAsyncResult pAsyncResult, ulong* pullRequestID);
    HRESULT EndQueryStateVariable(ulong ullRequestID, VARIANT* pValue);
    HRESULT BeginSubscribeToEvents(IUnknown pUnkCallback, IUPnPAsyncResult pAsyncResult, ulong* pullRequestID);
    HRESULT EndSubscribeToEvents(ulong ullRequestID);
    HRESULT BeginSCPDDownload(IUPnPAsyncResult pAsyncResult, ulong* pullRequestID);
    HRESULT EndSCPDDownload(ulong ullRequestID, BSTR* pbstrSCPDDoc);
    HRESULT CancelAsyncOperation(ulong ullRequestID);
}

@GUID("31FADCA9-AB73-464B-B67D-5C1D0F83C8B8")
interface IUPnPServiceCallback : IUnknown
{
    HRESULT StateVariableChanged(IUPnPService pus, const(wchar)* pcwszStateVarName, VARIANT vaValue);
    HRESULT ServiceInstanceDied(IUPnPService pus);
}

@GUID("38873B37-91BB-49F4-B249-2E8EFBB8A816")
interface IUPnPServiceEnumProperty : IUnknown
{
    HRESULT SetServiceEnumProperty(uint dwMask);
}

@GUID("21905529-0A5E-4589-825D-7E6D87EA6998")
interface IUPnPServiceDocumentAccess : IUnknown
{
    HRESULT GetDocumentURL(BSTR* pbstrDocUrl);
    HRESULT GetDocument(BSTR* pbstrDoc);
}

@GUID("FDBC0C73-BDA3-4C66-AC4F-F2D96FDAD68C")
interface IUPnPDevices : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppunk);
    HRESULT get_Item(BSTR bstrUDN, IUPnPDevice* ppDevice);
}

@GUID("3D44D0D1-98C9-4889-ACD1-F9D674BF2221")
interface IUPnPDevice : IDispatch
{
    HRESULT get_IsRootDevice(short* pvarb);
    HRESULT get_RootDevice(IUPnPDevice* ppudRootDevice);
    HRESULT get_ParentDevice(IUPnPDevice* ppudDeviceParent);
    HRESULT get_HasChildren(short* pvarb);
    HRESULT get_Children(IUPnPDevices* ppudChildren);
    HRESULT get_UniqueDeviceName(BSTR* pbstr);
    HRESULT get_FriendlyName(BSTR* pbstr);
    HRESULT get_Type(BSTR* pbstr);
    HRESULT get_PresentationURL(BSTR* pbstr);
    HRESULT get_ManufacturerName(BSTR* pbstr);
    HRESULT get_ManufacturerURL(BSTR* pbstr);
    HRESULT get_ModelName(BSTR* pbstr);
    HRESULT get_ModelNumber(BSTR* pbstr);
    HRESULT get_Description(BSTR* pbstr);
    HRESULT get_ModelURL(BSTR* pbstr);
    HRESULT get_UPC(BSTR* pbstr);
    HRESULT get_SerialNumber(BSTR* pbstr);
    HRESULT IconURL(BSTR bstrEncodingFormat, int lSizeX, int lSizeY, int lBitDepth, BSTR* pbstrIconURL);
    HRESULT get_Services(IUPnPServices* ppusServices);
}

@GUID("E7772804-3287-418E-9072-CF2B47238981")
interface IUPnPDeviceDocumentAccess : IUnknown
{
    HRESULT GetDocumentURL(BSTR* pbstrDocument);
}

@GUID("C4BC4050-6178-4BD1-A4B8-6398321F3247")
interface IUPnPDeviceDocumentAccessEx : IUnknown
{
    HRESULT GetDocument(BSTR* pbstrDocument);
}

@GUID("11D1C1B2-7DAA-4C9E-9595-7F82ED206D1E")
interface IUPnPDescriptionDocument : IDispatch
{
    HRESULT get_ReadyState(int* plReadyState);
    HRESULT Load(BSTR bstrUrl);
    HRESULT LoadAsync(BSTR bstrUrl, IUnknown punkCallback);
    HRESULT get_LoadResult(int* phrError);
    HRESULT Abort();
    HRESULT RootDevice(IUPnPDevice* ppudRootDevice);
    HRESULT DeviceByUDN(BSTR bstrUDN, IUPnPDevice* ppudDevice);
}

@GUID("983DFC0B-1796-44DF-8975-CA545B620EE5")
interface IUPnPDeviceFinderAddCallbackWithInterface : IUnknown
{
    HRESULT DeviceAddedWithInterface(int lFindData, IUPnPDevice pDevice, GUID* pguidInterface);
}

@GUID("77394C69-5486-40D6-9BC3-4991983E02DA")
interface IUPnPDescriptionDocumentCallback : IUnknown
{
    HRESULT LoadComplete(HRESULT hrLoadResult);
}

@GUID("204810B4-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPEventSink : IUnknown
{
    HRESULT OnStateChanged(uint cChanges, char* rgdispidChanges);
    HRESULT OnStateChangedSafe(VARIANT varsadispidChanges);
}

@GUID("204810B5-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPEventSource : IUnknown
{
    HRESULT Advise(IUPnPEventSink pesSubscriber);
    HRESULT Unadvise(IUPnPEventSink pesSubscriber);
}

@GUID("204810B6-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPRegistrar : IUnknown
{
    HRESULT RegisterDevice(BSTR bstrXMLDesc, BSTR bstrProgIDDeviceControlClass, BSTR bstrInitString, 
                           BSTR bstrContainerId, BSTR bstrResourcePath, int nLifeTime, BSTR* pbstrDeviceIdentifier);
    HRESULT RegisterRunningDevice(BSTR bstrXMLDesc, IUnknown punkDeviceControl, BSTR bstrInitString, 
                                  BSTR bstrResourcePath, int nLifeTime, BSTR* pbstrDeviceIdentifier);
    HRESULT RegisterDeviceProvider(BSTR bstrProviderName, BSTR bstrProgIDProviderClass, BSTR bstrInitString, 
                                   BSTR bstrContainerId);
    HRESULT GetUniqueDeviceName(BSTR bstrDeviceIdentifier, BSTR bstrTemplateUDN, BSTR* pbstrUDN);
    HRESULT UnregisterDevice(BSTR bstrDeviceIdentifier, BOOL fPermanent);
    HRESULT UnregisterDeviceProvider(BSTR bstrProviderName);
}

@GUID("204810B7-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPReregistrar : IUnknown
{
    HRESULT ReregisterDevice(BSTR bstrDeviceIdentifier, BSTR bstrXMLDesc, BSTR bstrProgIDDeviceControlClass, 
                             BSTR bstrInitString, BSTR bstrContainerId, BSTR bstrResourcePath, int nLifeTime);
    HRESULT ReregisterRunningDevice(BSTR bstrDeviceIdentifier, BSTR bstrXMLDesc, IUnknown punkDeviceControl, 
                                    BSTR bstrInitString, BSTR bstrResourcePath, int nLifeTime);
}

@GUID("204810BA-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPDeviceControl : IUnknown
{
    HRESULT Initialize(BSTR bstrXMLDesc, BSTR bstrDeviceIdentifier, BSTR bstrInitString);
    HRESULT GetServiceObject(BSTR bstrUDN, BSTR bstrServiceId, IDispatch* ppdispService);
}

@GUID("204810BB-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPDeviceControlHttpHeaders : IUnknown
{
    HRESULT GetAdditionalResponseHeaders(BSTR* bstrHttpResponseHeaders);
}

@GUID("204810B8-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPDeviceProvider : IUnknown
{
    HRESULT Start(BSTR bstrInitString);
    HRESULT Stop();
}

@GUID("C92EB863-0269-4AFF-9C72-75321BBA2952")
interface IUPnPRemoteEndpointInfo : IUnknown
{
    HRESULT GetDwordValue(BSTR bstrValueName, uint* pdwValue);
    HRESULT GetStringValue(BSTR bstrValueName, BSTR* pbstrValue);
    HRESULT GetGuidValue(BSTR bstrValueName, GUID* pguidValue);
}


// GUIDs

const GUID CLSID_UIAnimationManager            = GUIDOF!UIAnimationManager;
const GUID CLSID_UIAnimationManager2           = GUIDOF!UIAnimationManager2;
const GUID CLSID_UIAnimationTimer              = GUIDOF!UIAnimationTimer;
const GUID CLSID_UIAnimationTransitionFactory  = GUIDOF!UIAnimationTransitionFactory;
const GUID CLSID_UIAnimationTransitionFactory2 = GUIDOF!UIAnimationTransitionFactory2;
const GUID CLSID_UIAnimationTransitionLibrary  = GUIDOF!UIAnimationTransitionLibrary;
const GUID CLSID_UIAnimationTransitionLibrary2 = GUIDOF!UIAnimationTransitionLibrary2;
const GUID CLSID_UPnPDescriptionDocument       = GUIDOF!UPnPDescriptionDocument;
const GUID CLSID_UPnPDescriptionDocumentEx     = GUIDOF!UPnPDescriptionDocumentEx;
const GUID CLSID_UPnPDevice                    = GUIDOF!UPnPDevice;
const GUID CLSID_UPnPDeviceFinder              = GUIDOF!UPnPDeviceFinder;
const GUID CLSID_UPnPDeviceFinderEx            = GUIDOF!UPnPDeviceFinderEx;
const GUID CLSID_UPnPDevices                   = GUIDOF!UPnPDevices;
const GUID CLSID_UPnPRegistrar                 = GUIDOF!UPnPRegistrar;
const GUID CLSID_UPnPRemoteEndpointInfo        = GUIDOF!UPnPRemoteEndpointInfo;
const GUID CLSID_UPnPService                   = GUIDOF!UPnPService;
const GUID CLSID_UPnPServices                  = GUIDOF!UPnPServices;

const GUID IID_IUPnPAddressFamilyControl                 = GUIDOF!IUPnPAddressFamilyControl;
const GUID IID_IUPnPAsyncResult                          = GUIDOF!IUPnPAsyncResult;
const GUID IID_IUPnPDescriptionDocument                  = GUIDOF!IUPnPDescriptionDocument;
const GUID IID_IUPnPDescriptionDocumentCallback          = GUIDOF!IUPnPDescriptionDocumentCallback;
const GUID IID_IUPnPDevice                               = GUIDOF!IUPnPDevice;
const GUID IID_IUPnPDeviceControl                        = GUIDOF!IUPnPDeviceControl;
const GUID IID_IUPnPDeviceControlHttpHeaders             = GUIDOF!IUPnPDeviceControlHttpHeaders;
const GUID IID_IUPnPDeviceDocumentAccess                 = GUIDOF!IUPnPDeviceDocumentAccess;
const GUID IID_IUPnPDeviceDocumentAccessEx               = GUIDOF!IUPnPDeviceDocumentAccessEx;
const GUID IID_IUPnPDeviceFinder                         = GUIDOF!IUPnPDeviceFinder;
const GUID IID_IUPnPDeviceFinderAddCallbackWithInterface = GUIDOF!IUPnPDeviceFinderAddCallbackWithInterface;
const GUID IID_IUPnPDeviceFinderCallback                 = GUIDOF!IUPnPDeviceFinderCallback;
const GUID IID_IUPnPDeviceProvider                       = GUIDOF!IUPnPDeviceProvider;
const GUID IID_IUPnPDevices                              = GUIDOF!IUPnPDevices;
const GUID IID_IUPnPEventSink                            = GUIDOF!IUPnPEventSink;
const GUID IID_IUPnPEventSource                          = GUIDOF!IUPnPEventSource;
const GUID IID_IUPnPHttpHeaderControl                    = GUIDOF!IUPnPHttpHeaderControl;
const GUID IID_IUPnPRegistrar                            = GUIDOF!IUPnPRegistrar;
const GUID IID_IUPnPRemoteEndpointInfo                   = GUIDOF!IUPnPRemoteEndpointInfo;
const GUID IID_IUPnPReregistrar                          = GUIDOF!IUPnPReregistrar;
const GUID IID_IUPnPService                              = GUIDOF!IUPnPService;
const GUID IID_IUPnPServiceAsync                         = GUIDOF!IUPnPServiceAsync;
const GUID IID_IUPnPServiceCallback                      = GUIDOF!IUPnPServiceCallback;
const GUID IID_IUPnPServiceDocumentAccess                = GUIDOF!IUPnPServiceDocumentAccess;
const GUID IID_IUPnPServiceEnumProperty                  = GUIDOF!IUPnPServiceEnumProperty;
const GUID IID_IUPnPServices                             = GUIDOF!IUPnPServices;
