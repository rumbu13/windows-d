module windows.otherdevicetechnologies;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.com : HRESULT, IUnknown;
public import windows.security : CERT_CONTEXT;
public import windows.structuredstorage : PROPVARIANT;
public import windows.systemservices : BOOL, HANDLE, IServiceProvider;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows):


// Enums


enum PropertyConstraint : int
{
    QC_EQUALS             = 0x00000000,
    QC_NOTEQUAL           = 0x00000001,
    QC_LESSTHAN           = 0x00000002,
    QC_LESSTHANOREQUAL    = 0x00000003,
    QC_GREATERTHAN        = 0x00000004,
    QC_GREATERTHANOREQUAL = 0x00000005,
    QC_STARTSWITH         = 0x00000006,
    QC_EXISTS             = 0x00000007,
    QC_DOESNOTEXIST       = 0x00000008,
    QC_CONTAINS           = 0x00000009,
}

enum SystemVisibilityFlags : int
{
    SVF_SYSTEM = 0x00000000,
    SVF_USER   = 0x00000001,
}

enum QueryUpdateAction : int
{
    QUA_ADD    = 0x00000000,
    QUA_REMOVE = 0x00000001,
    QUA_CHANGE = 0x00000002,
}

enum QueryCategoryType : int
{
    QCT_PROVIDER = 0x00000000,
    QCT_LAYERED  = 0x00000001,
}

enum : int
{
    OpNone                  = 0x00000000,
    OpEndOfTable            = 0x00000001,
    OpBeginElement_         = 0x00000002,
    OpBeginAnyElement       = 0x00000003,
    OpEndElement            = 0x00000004,
    OpElement_              = 0x00000005,
    OpAnyElement            = 0x00000006,
    OpAnyElements           = 0x00000007,
    OpAnyText               = 0x00000008,
    OpAttribute_            = 0x00000009,
    OpBeginChoice           = 0x0000000a,
    OpEndChoice             = 0x0000000b,
    OpBeginSequence         = 0x0000000c,
    OpEndSequence           = 0x0000000d,
    OpBeginAll              = 0x0000000e,
    OpEndAll                = 0x0000000f,
    OpAnything              = 0x00000010,
    OpAnyNumber             = 0x00000011,
    OpOneOrMore             = 0x00000012,
    OpOptional              = 0x00000013,
    OpFormatBool_           = 0x00000014,
    OpFormatInt8_           = 0x00000015,
    OpFormatInt16_          = 0x00000016,
    OpFormatInt32_          = 0x00000017,
    OpFormatInt64_          = 0x00000018,
    OpFormatUInt8_          = 0x00000019,
    OpFormatUInt16_         = 0x0000001a,
    OpFormatUInt32_         = 0x0000001b,
    OpFormatUInt64_         = 0x0000001c,
    OpFormatUnicodeString_  = 0x0000001d,
    OpFormatDom_            = 0x0000001e,
    OpFormatStruct_         = 0x0000001f,
    OpFormatUri_            = 0x00000020,
    OpFormatUuidUri_        = 0x00000021,
    OpFormatName_           = 0x00000022,
    OpFormatListInsertTail_ = 0x00000023,
    OpFormatType_           = 0x00000024,
    OpFormatDynamicType_    = 0x00000025,
    OpFormatLookupType_     = 0x00000026,
    OpFormatDuration_       = 0x00000027,
    OpFormatDateTime_       = 0x00000028,
    OpFormatFloat_          = 0x00000029,
    OpFormatDouble_         = 0x0000002a,
    OpProcess_              = 0x0000002b,
    OpQualifiedAttribute_   = 0x0000002c,
    OpFormatXMLDeclaration_ = 0x0000002d,
    OpFormatMax             = 0x0000002e,
}
alias __MIDL___MIDL_itf_wsdxml_0000_0000_0001 = int;

enum : int
{
    WSD_CONFIG_MAX_INBOUND_MESSAGE_SIZE                  = 0x00000001,
    WSD_CONFIG_MAX_OUTBOUND_MESSAGE_SIZE                 = 0x00000002,
    WSD_SECURITY_SSL_CERT_FOR_CLIENT_AUTH                = 0x00000003,
    WSD_SECURITY_SSL_SERVER_CERT_VALIDATION              = 0x00000004,
    WSD_SECURITY_SSL_CLIENT_CERT_VALIDATION              = 0x00000005,
    WSD_SECURITY_SSL_NEGOTIATE_CLIENT_CERT               = 0x00000006,
    WSD_SECURITY_COMPACTSIG_SIGNING_CERT                 = 0x00000007,
    WSD_SECURITY_COMPACTSIG_VALIDATION                   = 0x00000008,
    WSD_CONFIG_HOSTING_ADDRESSES                         = 0x00000009,
    WSD_CONFIG_DEVICE_ADDRESSES                          = 0x0000000a,
    WSD_SECURITY_REQUIRE_HTTP_CLIENT_AUTH                = 0x0000000b,
    WSD_SECURITY_REQUIRE_CLIENT_CERT_OR_HTTP_CLIENT_AUTH = 0x0000000c,
    WSD_SECURITY_USE_HTTP_CLIENT_AUTH                    = 0x0000000d,
}
alias WSD_CONFIG_PARAM_TYPE = int;

enum WSDUdpMessageType : int
{
    ONE_WAY = 0x00000000,
    TWO_WAY = 0x00000001,
}

enum DeviceDiscoveryMechanism : int
{
    MulticastDiscovery      = 0x00000000,
    DirectedDiscovery       = 0x00000001,
    SecureDirectedDiscovery = 0x00000002,
}

enum : int
{
    WSD_PT_NONE  = 0x00000000,
    WSD_PT_UDP   = 0x00000001,
    WSD_PT_HTTP  = 0x00000002,
    WSD_PT_HTTPS = 0x00000004,
    WSD_PT_ALL   = 0x000000ff,
}
alias WSD_PROTOCOL_TYPE = int;

enum WSDEventType : int
{
    WSDET_NONE                 = 0x00000000,
    WSDET_INCOMING_MESSAGE     = 0x00000001,
    WSDET_INCOMING_FAULT       = 0x00000002,
    WSDET_TRANSMISSION_FAILURE = 0x00000003,
    WSDET_RESPONSE_TIMEOUT     = 0x00000004,
}

// Callbacks

alias WSD_STUB_FUNCTION = HRESULT function(IUnknown server, IWSDServiceMessaging session, WSD_EVENT* event);
alias PWSD_SOAP_MESSAGE_HANDLER = HRESULT function(IUnknown thisUnknown, WSD_EVENT* event);

// Structs


struct IFunctionInstanceQuery2
{
}

struct IFunctionInstanceCollectionQuery2
{
}

struct IFunctionInstanceCollectionQueryCollection
{
}

struct IFunctionDiscoveryProviderRefresh
{
}

struct WSD_DATETIME
{
    BOOL  isPositive;
    uint  year;
    ubyte month;
    ubyte day;
    ubyte hour;
    ubyte minute;
    ubyte second;
    uint  millisecond;
    BOOL  TZIsLocal;
    BOOL  TZIsPositive;
    ubyte TZHour;
    ubyte TZMinute;
}

struct WSD_DURATION
{
    BOOL isPositive;
    uint year;
    uint month;
    uint day;
    uint hour;
    uint minute;
    uint second;
    uint millisecond;
}

struct WSD_CONFIG_PARAM
{
    WSD_CONFIG_PARAM_TYPE configParamType;
    void* pConfigData;
    uint  dwConfigDataSize;
}

struct WSD_SECURITY_CERT_VALIDATION_V1
{
    CERT_CONTEXT** certMatchArray;
    uint           dwCertMatchArrayCount;
    void*          hCertMatchStore;
    void*          hCertIssuerStore;
    uint           dwCertCheckOptions;
}

struct WSD_SECURITY_CERT_VALIDATION
{
    CERT_CONTEXT** certMatchArray;
    uint           dwCertMatchArrayCount;
    void*          hCertMatchStore;
    void*          hCertIssuerStore;
    uint           dwCertCheckOptions;
    const(wchar)*  pszCNGHashAlgId;
    ubyte*         pbCertHash;
    uint           dwCertHashSize;
}

struct WSD_SECURITY_SIGNATURE_VALIDATION
{
    CERT_CONTEXT** signingCertArray;
    uint           dwSigningCertArrayCount;
    void*          hSigningCertStore;
    uint           dwFlags;
}

struct WSD_CONFIG_ADDRESSES
{
    IWSDAddress* addresses;
    uint         dwAddressCount;
}

struct WSDUdpRetransmitParams
{
    uint ulSendDelay;
    uint ulRepeat;
    uint ulRepeatMinDelay;
    uint ulRepeatMaxDelay;
    uint ulRepeatUpperDelay;
}

struct SOCKADDR_STORAGE
{
}

struct WSD_OPERATION
{
    WSDXML_TYPE*      RequestType;
    WSDXML_TYPE*      ResponseType;
    WSD_STUB_FUNCTION RequestStubFunction;
}

struct WSD_HANDLER_CONTEXT
{
    PWSD_SOAP_MESSAGE_HANDLER Handler;
    void*    PVoid;
    IUnknown Unknown;
}

struct WSD_SYNCHRONOUS_RESPONSE_CONTEXT
{
    HRESULT hr;
    HANDLE  eventHandle;
    IWSDMessageParameters messageParameters;
    void*   results;
}

struct WSD_PORT_TYPE
{
    uint              EncodedName;
    uint              OperationCount;
    WSD_OPERATION*    Operations;
    WSD_PROTOCOL_TYPE ProtocolType;
}

struct WSD_RELATIONSHIP_METADATA
{
    const(wchar)*      Type;
    WSD_HOST_METADATA* Data;
    WSDXML_ELEMENT*    Any;
}

struct WSD_SERVICE_METADATA_LIST
{
    WSD_SERVICE_METADATA_LIST* Next;
    WSD_SERVICE_METADATA* Element;
}

struct WSD_HOST_METADATA
{
    WSD_SERVICE_METADATA* Host;
    WSD_SERVICE_METADATA_LIST* Hosted;
}

struct WSD_ENDPOINT_REFERENCE_LIST
{
    WSD_ENDPOINT_REFERENCE_LIST* Next;
    WSD_ENDPOINT_REFERENCE* Element;
}

struct WSD_SERVICE_METADATA
{
    WSD_ENDPOINT_REFERENCE_LIST* EndpointReference;
    WSD_NAME_LIST*  Types;
    const(wchar)*   ServiceId;
    WSDXML_ELEMENT* Any;
}

struct WSD_THIS_DEVICE_METADATA
{
    WSD_LOCALIZED_STRING_LIST* FriendlyName;
    const(wchar)*   FirmwareVersion;
    const(wchar)*   SerialNumber;
    WSDXML_ELEMENT* Any;
}

struct WSD_THIS_MODEL_METADATA
{
    WSD_LOCALIZED_STRING_LIST* Manufacturer;
    const(wchar)*   ManufacturerUrl;
    WSD_LOCALIZED_STRING_LIST* ModelName;
    const(wchar)*   ModelNumber;
    const(wchar)*   ModelUrl;
    const(wchar)*   PresentationUrl;
    WSDXML_ELEMENT* Any;
}

struct WSD_LOCALIZED_STRING_LIST
{
    WSD_LOCALIZED_STRING_LIST* Next;
    WSD_LOCALIZED_STRING* Element;
}

struct WSD_SOAP_FAULT_REASON
{
    WSD_LOCALIZED_STRING_LIST* Text;
}

struct WSD_SOAP_FAULT_SUBCODE
{
    WSDXML_NAME* Value;
    WSD_SOAP_FAULT_SUBCODE* Subcode;
}

struct WSD_SOAP_FAULT_CODE
{
    WSDXML_NAME* Value;
    WSD_SOAP_FAULT_SUBCODE* Subcode;
}

struct WSD_SOAP_FAULT
{
    WSD_SOAP_FAULT_CODE* Code;
    WSD_SOAP_FAULT_REASON* Reason;
    const(wchar)*        Node;
    const(wchar)*        Role;
    WSDXML_ELEMENT*      Detail;
}

struct WSD_APP_SEQUENCE
{
    ulong         InstanceId;
    const(wchar)* SequenceId;
    ulong         MessageNumber;
}

struct WSD_HEADER_RELATESTO
{
    WSDXML_NAME*  RelationshipType;
    const(wchar)* MessageID;
}

struct WSD_SOAP_HEADER
{
    const(wchar)*        To;
    const(wchar)*        Action;
    const(wchar)*        MessageID;
    WSD_HEADER_RELATESTO RelatesTo;
    WSD_ENDPOINT_REFERENCE* ReplyTo;
    WSD_ENDPOINT_REFERENCE* From;
    WSD_ENDPOINT_REFERENCE* FaultTo;
    WSD_APP_SEQUENCE*    AppSequence;
    WSDXML_ELEMENT*      AnyHeaders;
}

struct WSD_SOAP_MESSAGE
{
    WSD_SOAP_HEADER Header;
    void*           Body;
    WSDXML_TYPE*    BodyType;
}

struct WSD_RESOLVE_MATCHES
{
    WSD_RESOLVE_MATCH* ResolveMatch;
    WSDXML_ELEMENT*    Any;
}

struct WSD_RESOLVE_MATCH
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSD_NAME_LIST*  Types;
    WSD_SCOPES*     Scopes;
    WSD_URI_LIST*   XAddrs;
    ulong           MetadataVersion;
    WSDXML_ELEMENT* Any;
}

struct WSD_RESOLVE
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSDXML_ELEMENT* Any;
}

struct WSD_PROBE_MATCH
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSD_NAME_LIST*  Types;
    WSD_SCOPES*     Scopes;
    WSD_URI_LIST*   XAddrs;
    ulong           MetadataVersion;
    WSDXML_ELEMENT* Any;
}

struct WSD_PROBE_MATCH_LIST
{
    WSD_PROBE_MATCH_LIST* Next;
    WSD_PROBE_MATCH* Element;
}

struct WSD_PROBE_MATCHES
{
    WSD_PROBE_MATCH_LIST* ProbeMatch;
    WSDXML_ELEMENT* Any;
}

struct WSD_PROBE
{
    WSD_NAME_LIST*  Types;
    WSD_SCOPES*     Scopes;
    WSDXML_ELEMENT* Any;
}

struct WSD_BYE
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSDXML_ELEMENT* Any;
}

struct WSD_SCOPES
{
    const(wchar)* MatchBy;
    WSD_URI_LIST* Scopes;
}

struct WSD_NAME_LIST
{
    WSD_NAME_LIST* Next;
    WSDXML_NAME*   Element;
}

struct WSD_HELLO
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSD_NAME_LIST*  Types;
    WSD_SCOPES*     Scopes;
    WSD_URI_LIST*   XAddrs;
    ulong           MetadataVersion;
    WSDXML_ELEMENT* Any;
}

struct WSD_REFERENCE_PARAMETERS
{
    WSDXML_ELEMENT* Any;
}

struct WSD_REFERENCE_PROPERTIES
{
    WSDXML_ELEMENT* Any;
}

struct WSD_ENDPOINT_REFERENCE
{
    const(wchar)*   Address;
    WSD_REFERENCE_PROPERTIES ReferenceProperties;
    WSD_REFERENCE_PARAMETERS ReferenceParameters;
    WSDXML_NAME*    PortType;
    WSDXML_NAME*    ServiceName;
    WSDXML_ELEMENT* Any;
}

struct WSD_METADATA_SECTION
{
    const(wchar)*   Dialect;
    const(wchar)*   Identifier;
    void*           Data;
    WSD_ENDPOINT_REFERENCE* MetadataReference;
    const(wchar)*   Location;
    WSDXML_ELEMENT* Any;
}

struct WSD_METADATA_SECTION_LIST
{
    WSD_METADATA_SECTION_LIST* Next;
    WSD_METADATA_SECTION* Element;
}

struct WSD_URI_LIST
{
    WSD_URI_LIST* Next;
    const(wchar)* Element;
}

struct WSD_EVENTING_FILTER_ACTION
{
    WSD_URI_LIST* Actions;
}

struct WSD_EVENTING_FILTER
{
    const(wchar)* Dialect;
    WSD_EVENTING_FILTER_ACTION* FilterAction;
    void*         Data;
}

struct WSD_EVENTING_EXPIRES
{
    WSD_DURATION* Duration;
    WSD_DATETIME* DateTime;
}

struct WSD_EVENTING_DELIVERY_MODE_PUSH
{
    WSD_ENDPOINT_REFERENCE* NotifyTo;
}

struct WSD_EVENTING_DELIVERY_MODE
{
    const(wchar)* Mode;
    WSD_EVENTING_DELIVERY_MODE_PUSH* Push;
    void*         Data;
}

struct WSD_LOCALIZED_STRING
{
    const(wchar)* lang;
    const(wchar)* String;
}

struct RESPONSEBODY_GetMetadata
{
    WSD_METADATA_SECTION_LIST* Metadata;
}

struct REQUESTBODY_Subscribe
{
    WSD_ENDPOINT_REFERENCE* EndTo;
    WSD_EVENTING_DELIVERY_MODE* Delivery;
    WSD_EVENTING_EXPIRES* Expires;
    WSD_EVENTING_FILTER* Filter;
    WSDXML_ELEMENT*      Any;
}

struct RESPONSEBODY_Subscribe
{
    WSD_ENDPOINT_REFERENCE* SubscriptionManager;
    WSD_EVENTING_EXPIRES* expires;
    WSDXML_ELEMENT* any;
}

struct REQUESTBODY_Renew
{
    WSD_EVENTING_EXPIRES* Expires;
    WSDXML_ELEMENT* Any;
}

struct RESPONSEBODY_Renew
{
    WSD_EVENTING_EXPIRES* expires;
    WSDXML_ELEMENT* any;
}

struct REQUESTBODY_GetStatus
{
    WSDXML_ELEMENT* Any;
}

struct RESPONSEBODY_GetStatus
{
    WSD_EVENTING_EXPIRES* expires;
    WSDXML_ELEMENT* any;
}

struct REQUESTBODY_Unsubscribe
{
    WSDXML_ELEMENT* any;
}

struct RESPONSEBODY_SubscriptionEnd
{
    WSD_ENDPOINT_REFERENCE* SubscriptionManager;
    const(wchar)*   Status;
    WSD_LOCALIZED_STRING* Reason;
    WSDXML_ELEMENT* Any;
}

struct WSD_UNKNOWN_LOOKUP
{
    WSDXML_ELEMENT* Any;
}

struct WSD_EVENT
{
    HRESULT             Hr;
    uint                EventType;
    ushort*             DispatchTag;
    WSD_HANDLER_CONTEXT HandlerContext;
    WSD_SOAP_MESSAGE*   Soap;
    WSD_OPERATION*      Operation;
    IWSDMessageParameters MessageParameters;
}

struct WSDXML_NAMESPACE
{
    const(wchar)* Uri;
    const(wchar)* PreferredPrefix;
    WSDXML_NAME*  Names;
    ushort        NamesCount;
    ushort        Encoding;
}

struct WSDXML_NAME
{
    WSDXML_NAMESPACE* Space;
    ushort*           LocalName;
}

struct WSDXML_TYPE
{
    const(wchar)* Uri;
    const(ubyte)* Table;
}

struct WSDXML_PREFIX_MAPPING
{
    uint              Refs;
    WSDXML_PREFIX_MAPPING* Next;
    WSDXML_NAMESPACE* Space;
    ushort*           Prefix;
}

struct WSDXML_ATTRIBUTE
{
    WSDXML_ELEMENT*   Element;
    WSDXML_ATTRIBUTE* Next;
    WSDXML_NAME*      Name;
    ushort*           Value;
}

struct WSDXML_NODE
{
    int             Type;
    WSDXML_ELEMENT* Parent;
    WSDXML_NODE*    Next;
    int             ElementType = 0x00000000;
    int             TextType    = 0x00000001;
}

struct WSDXML_ELEMENT
{
    WSDXML_NODE       Node;
    WSDXML_NAME*      Name;
    WSDXML_ATTRIBUTE* FirstAttribute;
    WSDXML_NODE*      FirstChild;
    WSDXML_PREFIX_MAPPING* PrefixMappings;
}

struct WSDXML_TEXT
{
    WSDXML_NODE Node;
    ushort*     Text;
}

struct WSDXML_ELEMENT_LIST
{
    WSDXML_ELEMENT_LIST* Next;
    WSDXML_ELEMENT*      Element;
}

// Functions

@DllImport("wsdapi")
HRESULT WSDXMLGetNameFromBuiltinNamespace(const(wchar)* pszNamespace, const(wchar)* pszName, WSDXML_NAME** ppName);

@DllImport("wsdapi")
HRESULT WSDXMLCreateContext(IWSDXMLContext* ppContext);

@DllImport("wsdapi")
HRESULT WSDCreateUdpMessageParameters(IWSDUdpMessageParameters* ppTxParams);

@DllImport("wsdapi")
HRESULT WSDCreateUdpAddress(IWSDUdpAddress* ppAddress);

@DllImport("wsdapi")
HRESULT WSDCreateHttpMessageParameters(IWSDHttpMessageParameters* ppTxParams);

@DllImport("wsdapi")
HRESULT WSDCreateHttpAddress(IWSDHttpAddress* ppAddress);

@DllImport("wsdapi")
HRESULT WSDSetConfigurationOption(uint dwOption, char* pVoid, uint cbInBuffer);

@DllImport("wsdapi")
HRESULT WSDGetConfigurationOption(uint dwOption, char* pVoid, uint cbOutBuffer);

@DllImport("wsdapi")
void* WSDAllocateLinkedMemory(void* pParent, size_t cbSize);

@DllImport("wsdapi")
void WSDFreeLinkedMemory(void* pVoid);

@DllImport("wsdapi")
void WSDAttachLinkedMemory(void* pParent, void* pChild);

@DllImport("wsdapi")
void WSDDetachLinkedMemory(void* pVoid);

@DllImport("wsdapi")
HRESULT WSDXMLBuildAnyForSingleElement(WSDXML_NAME* pElementName, const(wchar)* pszText, WSDXML_ELEMENT** ppAny);

@DllImport("wsdapi")
HRESULT WSDXMLGetValueFromAny(const(wchar)* pszNamespace, const(wchar)* pszName, WSDXML_ELEMENT* pAny, 
                              ushort** ppszValue);

@DllImport("wsdapi")
HRESULT WSDXMLAddSibling(WSDXML_ELEMENT* pFirst, WSDXML_ELEMENT* pSecond);

@DllImport("wsdapi")
HRESULT WSDXMLAddChild(WSDXML_ELEMENT* pParent, WSDXML_ELEMENT* pChild);

@DllImport("wsdapi")
HRESULT WSDXMLCleanupElement(WSDXML_ELEMENT* pAny);

@DllImport("wsdapi")
HRESULT WSDGenerateFault(const(wchar)* pszCode, const(wchar)* pszSubCode, const(wchar)* pszReason, 
                         const(wchar)* pszDetail, IWSDXMLContext pContext, WSD_SOAP_FAULT** ppFault);

@DllImport("wsdapi")
HRESULT WSDGenerateFaultEx(WSDXML_NAME* pCode, WSDXML_NAME* pSubCode, WSD_LOCALIZED_STRING_LIST* pReasons, 
                           const(wchar)* pszDetail, WSD_SOAP_FAULT** ppFault);

@DllImport("wsdapi")
HRESULT WSDUriEncode(const(wchar)* source, uint cchSource, char* destOut, uint* cchDestOut);

@DllImport("wsdapi")
HRESULT WSDUriDecode(const(wchar)* source, uint cchSource, char* destOut, uint* cchDestOut);

@DllImport("wsdapi")
HRESULT WSDCreateDeviceHost(const(wchar)* pszLocalId, IWSDXMLContext pContext, IWSDDeviceHost* ppDeviceHost);

@DllImport("wsdapi")
HRESULT WSDCreateDeviceHostAdvanced(const(wchar)* pszLocalId, IWSDXMLContext pContext, char* ppHostAddresses, 
                                    uint dwHostAddressCount, IWSDDeviceHost* ppDeviceHost);

@DllImport("wsdapi")
HRESULT WSDCreateDeviceHost2(const(wchar)* pszLocalId, IWSDXMLContext pContext, char* pConfigParams, 
                             uint dwConfigParamCount, IWSDDeviceHost* ppDeviceHost);

@DllImport("wsdapi")
HRESULT WSDCreateDeviceProxy(const(wchar)* pszDeviceId, const(wchar)* pszLocalId, IWSDXMLContext pContext, 
                             IWSDDeviceProxy* ppDeviceProxy);

@DllImport("wsdapi")
HRESULT WSDCreateDeviceProxyAdvanced(const(wchar)* pszDeviceId, IWSDAddress pDeviceAddress, 
                                     const(wchar)* pszLocalId, IWSDXMLContext pContext, 
                                     IWSDDeviceProxy* ppDeviceProxy);

@DllImport("wsdapi")
HRESULT WSDCreateDeviceProxy2(const(wchar)* pszDeviceId, const(wchar)* pszLocalId, IWSDXMLContext pContext, 
                              char* pConfigParams, uint dwConfigParamCount, IWSDDeviceProxy* ppDeviceProxy);

@DllImport("wsdapi")
HRESULT WSDCreateDiscoveryProvider(IWSDXMLContext pContext, IWSDiscoveryProvider* ppProvider);

@DllImport("wsdapi")
HRESULT WSDCreateDiscoveryProvider2(IWSDXMLContext pContext, char* pConfigParams, uint dwConfigParamCount, 
                                    IWSDiscoveryProvider* ppProvider);

@DllImport("wsdapi")
HRESULT WSDCreateDiscoveryPublisher(IWSDXMLContext pContext, IWSDiscoveryPublisher* ppPublisher);

@DllImport("wsdapi")
HRESULT WSDCreateDiscoveryPublisher2(IWSDXMLContext pContext, char* pConfigParams, uint dwConfigParamCount, 
                                     IWSDiscoveryPublisher* ppPublisher);

@DllImport("wsdapi")
HRESULT WSDCreateOutboundAttachment(IWSDOutboundAttachment* ppAttachment);


// Interfaces

@GUID("CEE8CCC9-4F6B-4469-A235-5A22869EEF03")
struct PNPXAssociation;

@GUID("B8A27942-ADE7-4085-AA6E-4FADC7ADA1EF")
struct PNPXPairingHandler;

@GUID("5F6C1BA8-5330-422E-A368-572B244D3F87")
interface IFunctionDiscoveryNotification : IUnknown
{
    HRESULT OnUpdate(QueryUpdateAction enumQueryUpdateAction, ulong fdqcQueryContext, 
                     IFunctionInstance pIFunctionInstance);
    HRESULT OnError(HRESULT hr, ulong fdqcQueryContext, const(wchar)* pszProvider);
    HRESULT OnEvent(uint dwEventID, ulong fdqcQueryContext, const(wchar)* pszProvider);
}

@GUID("4DF99B70-E148-4432-B004-4C9EEB535A5E")
interface IFunctionDiscovery : IUnknown
{
    HRESULT GetInstanceCollection(const(wchar)* pszCategory, const(wchar)* pszSubCategory, 
                                  BOOL fIncludeAllSubCategories, 
                                  IFunctionInstanceCollection* ppIFunctionInstanceCollection);
    HRESULT GetInstance(const(wchar)* pszFunctionInstanceIdentity, IFunctionInstance* ppIFunctionInstance);
    HRESULT CreateInstanceCollectionQuery(const(wchar)* pszCategory, const(wchar)* pszSubCategory, 
                                          BOOL fIncludeAllSubCategories, 
                                          IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, 
                                          ulong* pfdqcQueryContext, 
                                          IFunctionInstanceCollectionQuery* ppIFunctionInstanceCollectionQuery);
    HRESULT CreateInstanceQuery(const(wchar)* pszFunctionInstanceIdentity, 
                                IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, 
                                ulong* pfdqcQueryContext, IFunctionInstanceQuery* ppIFunctionInstanceQuery);
    HRESULT AddInstance(SystemVisibilityFlags enumSystemVisibility, const(wchar)* pszCategory, 
                        const(wchar)* pszSubCategory, const(wchar)* pszCategoryIdentity, 
                        IFunctionInstance* ppIFunctionInstance);
    HRESULT RemoveInstance(SystemVisibilityFlags enumSystemVisibility, const(wchar)* pszCategory, 
                           const(wchar)* pszSubCategory, const(wchar)* pszCategoryIdentity);
}

@GUID("33591C10-0BED-4F02-B0AB-1530D5533EE9")
interface IFunctionInstance : IServiceProvider
{
    HRESULT GetID(ushort** ppszCoMemIdentity);
    HRESULT GetProviderInstanceID(ushort** ppszCoMemProviderInstanceIdentity);
    HRESULT OpenPropertyStore(uint dwStgAccess, IPropertyStore* ppIPropertyStore);
    HRESULT GetCategory(ushort** ppszCoMemCategory, ushort** ppszCoMemSubCategory);
}

@GUID("F0A3D895-855C-42A2-948D-2F97D450ECB1")
interface IFunctionInstanceCollection : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT Get(const(wchar)* pszInstanceIdentity, uint* pdwIndex, IFunctionInstance* ppIFunctionInstance);
    HRESULT Item(uint dwIndex, IFunctionInstance* ppIFunctionInstance);
    HRESULT Add(IFunctionInstance pIFunctionInstance);
    HRESULT Remove(uint dwIndex, IFunctionInstance* ppIFunctionInstance);
    HRESULT Delete(uint dwIndex);
    HRESULT DeleteAll();
}

@GUID("D14D9C30-12D2-42D8-BCE4-C60C2BB226FA")
interface IPropertyStoreCollection : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT Get(const(wchar)* pszInstanceIdentity, uint* pdwIndex, IPropertyStore* ppIPropertyStore);
    HRESULT Item(uint dwIndex, IPropertyStore* ppIPropertyStore);
    HRESULT Add(IPropertyStore pIPropertyStore);
    HRESULT Remove(uint dwIndex, IPropertyStore* pIPropertyStore);
    HRESULT Delete(uint dwIndex);
    HRESULT DeleteAll();
}

@GUID("6242BC6B-90EC-4B37-BB46-E229FD84ED95")
interface IFunctionInstanceQuery : IUnknown
{
    HRESULT Execute(IFunctionInstance* ppIFunctionInstance);
}

@GUID("57CC6FD2-C09A-4289-BB72-25F04142058E")
interface IFunctionInstanceCollectionQuery : IUnknown
{
    HRESULT AddQueryConstraint(const(wchar)* pszConstraintName, const(wchar)* pszConstraintValue);
    HRESULT AddPropertyConstraint(const(PROPERTYKEY)* Key, const(PROPVARIANT)* pv, 
                                  PropertyConstraint enumPropertyConstraint);
    HRESULT Execute(IFunctionInstanceCollection* ppIFunctionInstanceCollection);
}

interface CFunctionDiscoveryNotificationWrapper : IFunctionDiscoveryNotification
{
}

@GUID("DCDE394F-1478-4813-A402-F6FB10657222")
interface IFunctionDiscoveryProvider : IUnknown
{
    HRESULT Initialize(IFunctionDiscoveryProviderFactory pIFunctionDiscoveryProviderFactory, 
                       IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, uint lcidUserDefault, 
                       uint* pdwStgAccessCapabilities);
    HRESULT Query(IFunctionDiscoveryProviderQuery pIFunctionDiscoveryProviderQuery, 
                  IFunctionInstanceCollection* ppIFunctionInstanceCollection);
    HRESULT EndQuery();
    HRESULT InstancePropertyStoreValidateAccess(IFunctionInstance pIFunctionInstance, 
                                                ptrdiff_t iProviderInstanceContext, const(uint) dwStgAccess);
    HRESULT InstancePropertyStoreOpen(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                                      const(uint) dwStgAccess, IPropertyStore* ppIPropertyStore);
    HRESULT InstancePropertyStoreFlush(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext);
    HRESULT InstanceQueryService(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                                 const(GUID)* guidService, const(GUID)* riid, IUnknown* ppIUnknown);
    HRESULT InstanceReleased(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext);
}

@GUID("CF986EA6-3B5F-4C5F-B88A-2F8B20CEEF17")
interface IProviderProperties : IUnknown
{
    HRESULT GetCount(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, uint* pdwCount);
    HRESULT GetAt(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, uint dwIndex, 
                  PROPERTYKEY* pKey);
    HRESULT GetValue(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                     const(PROPERTYKEY)* Key, PROPVARIANT* ppropVar);
    HRESULT SetValue(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                     const(PROPERTYKEY)* Key, const(PROPVARIANT)* ppropVar);
}

@GUID("CD1B9A04-206C-4A05-A0C8-1635A21A2B7C")
interface IProviderPublishing : IUnknown
{
    HRESULT CreateInstance(SystemVisibilityFlags enumVisibilityFlags, const(wchar)* pszSubCategory, 
                           const(wchar)* pszProviderInstanceIdentity, IFunctionInstance* ppIFunctionInstance);
    HRESULT RemoveInstance(SystemVisibilityFlags enumVisibilityFlags, const(wchar)* pszSubCategory, 
                           const(wchar)* pszProviderInstanceIdentity);
}

@GUID("86443FF0-1AD5-4E68-A45A-40C2C329DE3B")
interface IFunctionDiscoveryProviderFactory : IUnknown
{
    HRESULT CreatePropertyStore(IPropertyStore* ppIPropertyStore);
    HRESULT CreateInstance(const(wchar)* pszSubCategory, const(wchar)* pszProviderInstanceIdentity, 
                           ptrdiff_t iProviderInstanceContext, IPropertyStore pIPropertyStore, 
                           IFunctionDiscoveryProvider pIFunctionDiscoveryProvider, 
                           IFunctionInstance* ppIFunctionInstance);
    HRESULT CreateFunctionInstanceCollection(IFunctionInstanceCollection* ppIFunctionInstanceCollection);
}

@GUID("6876EA98-BAEC-46DB-BC20-75A76E267A3A")
interface IFunctionDiscoveryProviderQuery : IUnknown
{
    HRESULT IsInstanceQuery(int* pisInstanceQuery, ushort** ppszConstraintValue);
    HRESULT IsSubcategoryQuery(int* pisSubcategoryQuery, ushort** ppszConstraintValue);
    HRESULT GetQueryConstraints(IProviderQueryConstraintCollection* ppIProviderQueryConstraints);
    HRESULT GetPropertyConstraints(IProviderPropertyConstraintCollection* ppIProviderPropertyConstraints);
}

@GUID("9C243E11-3261-4BCD-B922-84A873D460AE")
interface IProviderQueryConstraintCollection : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT Get(const(wchar)* pszConstraintName, ushort** ppszConstraintValue);
    HRESULT Item(uint dwIndex, ushort** ppszConstraintName, ushort** ppszConstraintValue);
    HRESULT Next(ushort** ppszConstraintName, ushort** ppszConstraintValue);
    HRESULT Skip();
    HRESULT Reset();
}

@GUID("F4FAE42F-5778-4A13-8540-B5FD8C1398DD")
interface IProviderPropertyConstraintCollection : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT Get(const(PROPERTYKEY)* Key, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    HRESULT Item(uint dwIndex, PROPERTYKEY* pKey, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    HRESULT Next(PROPERTYKEY* pKey, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    HRESULT Skip();
    HRESULT Reset();
}

@GUID("4C81ED02-1B04-43F2-A451-69966CBCD1C2")
interface IFunctionDiscoveryServiceProvider : IUnknown
{
    HRESULT Initialize(IFunctionInstance pIFunctionInstance, const(GUID)* riid, void** ppv);
}

@GUID("0BD7E521-4DA6-42D5-81BA-1981B6B94075")
interface IPNPXAssociation : IUnknown
{
    HRESULT Associate(const(wchar)* pszSubcategory);
    HRESULT Unassociate(const(wchar)* pszSubcategory);
    HRESULT Delete(const(wchar)* pszSubcategory);
}

@GUID("EED366D0-35B8-4FC5-8D20-7E5BD31F6DED")
interface IPNPXDeviceAssociation : IUnknown
{
    HRESULT Associate(const(wchar)* pszSubCategory, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
    HRESULT Unassociate(const(wchar)* pszSubCategory, 
                        IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
    HRESULT Delete(const(wchar)* pszSubcategory, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
}

@GUID("75D8F3EE-3E5A-43B4-A15A-BCF6887460C0")
interface IWSDXMLContext : IUnknown
{
    HRESULT AddNamespace(const(wchar)* pszUri, const(wchar)* pszSuggestedPrefix, WSDXML_NAMESPACE** ppNamespace);
    HRESULT AddNameToNamespace(const(wchar)* pszUri, const(wchar)* pszName, WSDXML_NAME** ppName);
    HRESULT SetNamespaces(char* pNamespaces, ushort wNamespacesCount, ubyte bLayerNumber);
    HRESULT SetTypes(char* pTypes, uint dwTypesCount, ubyte bLayerNumber);
}

@GUID("B9574C6C-12A6-4F74-93A1-3318FF605759")
interface IWSDAddress : IUnknown
{
    HRESULT Serialize(const(wchar)* pszBuffer, uint cchLength, BOOL fSafe);
    HRESULT Deserialize(const(wchar)* pszBuffer);
}

@GUID("70D23498-4EE6-4340-A3DF-D845D2235467")
interface IWSDTransportAddress : IWSDAddress
{
    HRESULT GetPort(ushort* pwPort);
    HRESULT SetPortA(ushort wPort);
    HRESULT GetTransportAddress(ushort** ppszAddress);
    HRESULT GetTransportAddressEx(BOOL fSafe, ushort** ppszAddress);
    HRESULT SetTransportAddress(const(wchar)* pszAddress);
}

@GUID("1FAFE8A2-E6FC-4B80-B6CF-B7D45C416D7C")
interface IWSDMessageParameters : IUnknown
{
    HRESULT GetLocalAddress(IWSDAddress* ppAddress);
    HRESULT SetLocalAddress(IWSDAddress pAddress);
    HRESULT GetRemoteAddress(IWSDAddress* ppAddress);
    HRESULT SetRemoteAddress(IWSDAddress pAddress);
    HRESULT GetLowerParameters(IWSDMessageParameters* ppTxParams);
}

@GUID("9934149F-8F0C-447B-AA0B-73124B0CA7F0")
interface IWSDUdpMessageParameters : IWSDMessageParameters
{
    HRESULT SetRetransmitParams(const(WSDUdpRetransmitParams)* pParams);
    HRESULT GetRetransmitParams(WSDUdpRetransmitParams* pParams);
}

@GUID("74D6124A-A441-4F78-A1EB-97A8D1996893")
interface IWSDUdpAddress : IWSDTransportAddress
{
    HRESULT SetSockaddr(const(SOCKADDR_STORAGE)* pSockAddr);
    HRESULT GetSockaddr(SOCKADDR_STORAGE* pSockAddr);
    HRESULT SetExclusive(BOOL fExclusive);
    HRESULT GetExclusive();
    HRESULT SetMessageType(WSDUdpMessageType messageType);
    HRESULT GetMessageType(WSDUdpMessageType* pMessageType);
    HRESULT SetTTL(uint dwTTL);
    HRESULT GetTTL(uint* pdwTTL);
    HRESULT SetAlias(const(GUID)* pAlias);
    HRESULT GetAlias(GUID* pAlias);
}

@GUID("540BD122-5C83-4DEC-B396-EA62A2697FDF")
interface IWSDHttpMessageParameters : IWSDMessageParameters
{
    HRESULT SetInboundHttpHeaders(const(wchar)* pszHeaders);
    HRESULT GetInboundHttpHeaders(ushort** ppszHeaders);
    HRESULT SetOutboundHttpHeaders(const(wchar)* pszHeaders);
    HRESULT GetOutboundHttpHeaders(ushort** ppszHeaders);
    HRESULT SetID(const(wchar)* pszId);
    HRESULT GetID(ushort** ppszId);
    HRESULT SetContext(IUnknown pContext);
    HRESULT GetContext(IUnknown* ppContext);
    HRESULT Clear();
}

@GUID("D09AC7BD-2A3E-4B85-8605-2737FF3E4EA0")
interface IWSDHttpAddress : IWSDTransportAddress
{
    HRESULT GetSecure();
    HRESULT SetSecure(BOOL fSecure);
    HRESULT GetPath(ushort** ppszPath);
    HRESULT SetPath(const(wchar)* pszPath);
}

@GUID("DE105E87-A0DA-418E-98AD-27B9EED87BDC")
interface IWSDSSLClientCertificate : IUnknown
{
    HRESULT GetClientCertificate(CERT_CONTEXT** ppCertContext);
    HRESULT GetMappedAccessToken(HANDLE* phToken);
}

@GUID("0B476DF0-8DAC-480D-B05C-99781A5884AA")
interface IWSDHttpAuthParameters : IUnknown
{
    HRESULT GetClientAccessToken(HANDLE* phToken);
    HRESULT GetAuthType(uint* pAuthType);
}

@GUID("03CE20AA-71C4-45E2-B32E-3766C61C790F")
interface IWSDSignatureProperty : IUnknown
{
    HRESULT IsMessageSigned(int* pbSigned);
    HRESULT IsMessageSignatureTrusted(int* pbSignatureTrusted);
    HRESULT GetKeyInfo(char* pbKeyInfo, uint* pdwKeyInfoSize);
    HRESULT GetSignature(char* pbSignature, uint* pdwSignatureSize);
    HRESULT GetSignedInfoHash(char* pbSignedInfoHash, uint* pdwHashSize);
}

@GUID("917FE891-3D13-4138-9809-934C8ABEB12C")
interface IWSDDeviceHost : IUnknown
{
    HRESULT Init(const(wchar)* pszLocalId, IWSDXMLContext pContext, char* ppHostAddresses, uint dwHostAddressCount);
    HRESULT Start(ulong ullInstanceId, const(WSD_URI_LIST)* pScopeList, IWSDDeviceHostNotify pNotificationSink);
    HRESULT Stop();
    HRESULT Terminate();
    HRESULT RegisterPortType(const(WSD_PORT_TYPE)* pPortType);
    HRESULT SetMetadata(const(WSD_THIS_MODEL_METADATA)* pThisModelMetadata, 
                        const(WSD_THIS_DEVICE_METADATA)* pThisDeviceMetadata, 
                        const(WSD_HOST_METADATA)* pHostMetadata, const(WSD_METADATA_SECTION_LIST)* pCustomMetadata);
    HRESULT RegisterService(const(wchar)* pszServiceId, IUnknown pService);
    HRESULT RetireService(const(wchar)* pszServiceId);
    HRESULT AddDynamicService(const(wchar)* pszServiceId, const(wchar)* pszEndpointAddress, 
                              const(WSD_PORT_TYPE)* pPortType, const(WSDXML_NAME)* pPortName, 
                              const(WSDXML_ELEMENT)* pAny, IUnknown pService);
    HRESULT RemoveDynamicService(const(wchar)* pszServiceId);
    HRESULT SetServiceDiscoverable(const(wchar)* pszServiceId, BOOL fDiscoverable);
    HRESULT SignalEvent(const(wchar)* pszServiceId, const(void)* pBody, const(WSD_OPERATION)* pOperation);
}

@GUID("B5BEE9F9-EEDA-41FE-96F7-F45E14990FB0")
interface IWSDDeviceHostNotify : IUnknown
{
    HRESULT GetService(const(wchar)* pszServiceId, IUnknown* ppService);
}

@GUID("94974CF4-0CAB-460D-A3F6-7A0AD623C0E6")
interface IWSDServiceMessaging : IUnknown
{
    HRESULT SendResponse(void* pBody, WSD_OPERATION* pOperation, IWSDMessageParameters pMessageParameters);
    HRESULT FaultRequest(WSD_SOAP_HEADER* pRequestHeader, IWSDMessageParameters pMessageParameters, 
                         WSD_SOAP_FAULT* pFault);
}

@GUID("1860D430-B24C-4975-9F90-DBB39BAA24EC")
interface IWSDEndpointProxy : IUnknown
{
    HRESULT SendOneWayRequest(const(void)* pBody, const(WSD_OPERATION)* pOperation);
    HRESULT SendTwoWayRequest(const(void)* pBody, const(WSD_OPERATION)* pOperation, 
                              const(WSD_SYNCHRONOUS_RESPONSE_CONTEXT)* pResponseContext);
    HRESULT SendTwoWayRequestAsync(const(void)* pBody, const(WSD_OPERATION)* pOperation, IUnknown pAsyncState, 
                                   IWSDAsyncCallback pCallback, IWSDAsyncResult* pResult);
    HRESULT AbortAsyncOperation(IWSDAsyncResult pAsyncResult);
    HRESULT ProcessFault(const(WSD_SOAP_FAULT)* pFault);
    HRESULT GetErrorInfo(ushort** ppszErrorInfo);
    HRESULT GetFaultInfo(WSD_SOAP_FAULT** ppFault);
}

@GUID("06996D57-1D67-4928-9307-3D7833FDB846")
interface IWSDMetadataExchange : IUnknown
{
    HRESULT GetMetadata(WSD_METADATA_SECTION_LIST** MetadataOut);
}

@GUID("D4C7FB9C-03AB-4175-9D67-094FAFEBF487")
interface IWSDServiceProxy : IWSDMetadataExchange
{
    HRESULT BeginGetMetadata(IWSDAsyncResult* ppResult);
    HRESULT EndGetMetadata(IWSDAsyncResult pResult, WSD_METADATA_SECTION_LIST** ppMetadata);
    HRESULT GetServiceMetadata(WSD_SERVICE_METADATA** ppServiceMetadata);
    HRESULT SubscribeToOperation(const(WSD_OPERATION)* pOperation, IUnknown pUnknown, const(WSDXML_ELEMENT)* pAny, 
                                 WSDXML_ELEMENT** ppAny);
    HRESULT UnsubscribeToOperation(const(WSD_OPERATION)* pOperation);
    HRESULT SetEventingStatusCallback(IWSDEventingStatus pStatus);
    HRESULT GetEndpointProxy(IWSDEndpointProxy* ppProxy);
}

@GUID("F9279D6D-1012-4A94-B8CC-FD35D2202BFE")
interface IWSDServiceProxyEventing : IWSDServiceProxy
{
    HRESULT SubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IUnknown pUnknown, 
                                          const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, 
                                          WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    HRESULT BeginSubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IUnknown pUnknown, 
                                               const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, 
                                               IUnknown pAsyncState, IWSDAsyncCallback pAsyncCallback, 
                                               IWSDAsyncResult* ppResult);
    HRESULT EndSubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult, 
                                             WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    HRESULT UnsubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, const(WSDXML_ELEMENT)* pAny);
    HRESULT BeginUnsubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, 
                                                 const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, 
                                                 IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
    HRESULT EndUnsubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult);
    HRESULT RenewMultipleOperations(char* pOperations, uint dwOperationCount, 
                                    const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, 
                                    WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    HRESULT BeginRenewMultipleOperations(char* pOperations, uint dwOperationCount, 
                                         const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, 
                                         IUnknown pAsyncState, IWSDAsyncCallback pAsyncCallback, 
                                         IWSDAsyncResult* ppResult);
    HRESULT EndRenewMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult, 
                                       WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    HRESULT GetStatusForMultipleOperations(char* pOperations, uint dwOperationCount, const(WSDXML_ELEMENT)* pAny, 
                                           WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    HRESULT BeginGetStatusForMultipleOperations(char* pOperations, uint dwOperationCount, 
                                                const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, 
                                                IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
    HRESULT EndGetStatusForMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult, 
                                              WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
}

@GUID("EEE0C031-C578-4C0E-9A3B-973C35F409DB")
interface IWSDDeviceProxy : IUnknown
{
    HRESULT Init(const(wchar)* pszDeviceId, IWSDAddress pDeviceAddress, const(wchar)* pszLocalId, 
                 IWSDXMLContext pContext, IWSDDeviceProxy pSponsor);
    HRESULT BeginGetMetadata(IWSDAsyncResult* ppResult);
    HRESULT EndGetMetadata(IWSDAsyncResult pResult);
    HRESULT GetHostMetadata(WSD_HOST_METADATA** ppHostMetadata);
    HRESULT GetThisModelMetadata(WSD_THIS_MODEL_METADATA** ppManufacturerMetadata);
    HRESULT GetThisDeviceMetadata(WSD_THIS_DEVICE_METADATA** ppThisDeviceMetadata);
    HRESULT GetAllMetadata(WSD_METADATA_SECTION_LIST** ppMetadata);
    HRESULT GetServiceProxyById(const(wchar)* pszServiceId, IWSDServiceProxy* ppServiceProxy);
    HRESULT GetServiceProxyByType(const(WSDXML_NAME)* pType, IWSDServiceProxy* ppServiceProxy);
    HRESULT GetEndpointProxy(IWSDEndpointProxy* ppProxy);
}

@GUID("11A9852A-8DD8-423E-B537-9356DB4FBFB8")
interface IWSDAsyncResult : IUnknown
{
    HRESULT SetCallback(IWSDAsyncCallback pCallback, IUnknown pAsyncState);
    HRESULT SetWaitHandle(HANDLE hWaitHandle);
    HRESULT HasCompleted();
    HRESULT GetAsyncState(IUnknown* ppAsyncState);
    HRESULT Abort();
    HRESULT GetEvent(WSD_EVENT* pEvent);
    HRESULT GetEndpointProxy(IWSDEndpointProxy* ppEndpoint);
}

@GUID("A63E109D-CE72-49E2-BA98-E845F5EE1666")
interface IWSDAsyncCallback : IUnknown
{
    HRESULT AsyncOperationComplete(IWSDAsyncResult pAsyncResult, IUnknown pAsyncState);
}

@GUID("49B17F52-637A-407A-AE99-FBE82A4D38C0")
interface IWSDEventingStatus : IUnknown
{
    void SubscriptionRenewed(const(wchar)* pszSubscriptionAction);
    void SubscriptionRenewalFailed(const(wchar)* pszSubscriptionAction, HRESULT hr);
    void SubscriptionEnded(const(wchar)* pszSubscriptionAction);
}

@GUID("8FFC8E55-F0EB-480F-88B7-B435DD281D45")
interface IWSDiscoveryProvider : IUnknown
{
    HRESULT SetAddressFamily(uint dwAddressFamily);
    HRESULT Attach(IWSDiscoveryProviderNotify pSink);
    HRESULT Detach();
    HRESULT SearchById(const(wchar)* pszId, const(wchar)* pszTag);
    HRESULT SearchByAddress(const(wchar)* pszAddress, const(wchar)* pszTag);
    HRESULT SearchByType(const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, 
                         const(wchar)* pszMatchBy, const(wchar)* pszTag);
    HRESULT GetXMLContext(IWSDXMLContext* ppContext);
}

@GUID("73EE3CED-B6E6-4329-A546-3E8AD46563D2")
interface IWSDiscoveryProviderNotify : IUnknown
{
    HRESULT Add(IWSDiscoveredService pService);
    HRESULT Remove(IWSDiscoveredService pService);
    HRESULT SearchFailed(HRESULT hr, const(wchar)* pszTag);
    HRESULT SearchComplete(const(wchar)* pszTag);
}

@GUID("4BAD8A3B-B374-4420-9632-AAC945B374AA")
interface IWSDiscoveredService : IUnknown
{
    HRESULT GetEndpointReference(WSD_ENDPOINT_REFERENCE** ppEndpointReference);
    HRESULT GetTypes(WSD_NAME_LIST** ppTypesList);
    HRESULT GetScopes(WSD_URI_LIST** ppScopesList);
    HRESULT GetXAddrs(WSD_URI_LIST** ppXAddrsList);
    HRESULT GetMetadataVersion(ulong* pullMetadataVersion);
    HRESULT GetExtendedDiscoXML(WSDXML_ELEMENT** ppHeaderAny, WSDXML_ELEMENT** ppBodyAny);
    HRESULT GetProbeResolveTag(ushort** ppszTag);
    HRESULT GetRemoteTransportAddress(ushort** ppszRemoteTransportAddress);
    HRESULT GetLocalTransportAddress(ushort** ppszLocalTransportAddress);
    HRESULT GetLocalInterfaceGUID(GUID* pGuid);
    HRESULT GetInstanceId(ulong* pullInstanceId);
}

@GUID("AE01E1A8-3FF9-4148-8116-057CC616FE13")
interface IWSDiscoveryPublisher : IUnknown
{
    HRESULT SetAddressFamily(uint dwAddressFamily);
    HRESULT RegisterNotificationSink(IWSDiscoveryPublisherNotify pSink);
    HRESULT UnRegisterNotificationSink(IWSDiscoveryPublisherNotify pSink);
    HRESULT Publish(const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                    const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, 
                    const(WSD_URI_LIST)* pXAddrsList);
    HRESULT UnPublish(const(wchar)* pszId, ulong ullInstanceId, ulong ullMessageNumber, const(wchar)* pszSessionId, 
                      const(WSDXML_ELEMENT)* pAny);
    HRESULT MatchProbe(const(WSD_SOAP_MESSAGE)* pProbeMessage, IWSDMessageParameters pMessageParameters, 
                       const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                       const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                       const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList);
    HRESULT MatchResolve(const(WSD_SOAP_MESSAGE)* pResolveMessage, IWSDMessageParameters pMessageParameters, 
                         const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                         const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                         const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList);
    HRESULT PublishEx(const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                      const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, 
                      const(WSD_URI_LIST)* pXAddrsList, const(WSDXML_ELEMENT)* pHeaderAny, 
                      const(WSDXML_ELEMENT)* pReferenceParameterAny, const(WSDXML_ELEMENT)* pPolicyAny, 
                      const(WSDXML_ELEMENT)* pEndpointReferenceAny, const(WSDXML_ELEMENT)* pAny);
    HRESULT MatchProbeEx(const(WSD_SOAP_MESSAGE)* pProbeMessage, IWSDMessageParameters pMessageParameters, 
                         const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                         const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                         const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList, 
                         const(WSDXML_ELEMENT)* pHeaderAny, const(WSDXML_ELEMENT)* pReferenceParameterAny, 
                         const(WSDXML_ELEMENT)* pPolicyAny, const(WSDXML_ELEMENT)* pEndpointReferenceAny, 
                         const(WSDXML_ELEMENT)* pAny);
    HRESULT MatchResolveEx(const(WSD_SOAP_MESSAGE)* pResolveMessage, IWSDMessageParameters pMessageParameters, 
                           const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, 
                           ulong ullMessageNumber, const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                           const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList, 
                           const(WSDXML_ELEMENT)* pHeaderAny, const(WSDXML_ELEMENT)* pReferenceParameterAny, 
                           const(WSDXML_ELEMENT)* pPolicyAny, const(WSDXML_ELEMENT)* pEndpointReferenceAny, 
                           const(WSDXML_ELEMENT)* pAny);
    HRESULT RegisterScopeMatchingRule(IWSDScopeMatchingRule pScopeMatchingRule);
    HRESULT UnRegisterScopeMatchingRule(IWSDScopeMatchingRule pScopeMatchingRule);
    HRESULT GetXMLContext(IWSDXMLContext* ppContext);
}

@GUID("E67651B0-337A-4B3C-9758-733388568251")
interface IWSDiscoveryPublisherNotify : IUnknown
{
    HRESULT ProbeHandler(const(WSD_SOAP_MESSAGE)* pSoap, IWSDMessageParameters pMessageParameters);
    HRESULT ResolveHandler(const(WSD_SOAP_MESSAGE)* pSoap, IWSDMessageParameters pMessageParameters);
}

@GUID("FCAFE424-FEF5-481A-BD9F-33CE0574256F")
interface IWSDScopeMatchingRule : IUnknown
{
    HRESULT GetScopeRule(ushort** ppszScopeMatchingRule);
    HRESULT MatchScopes(const(wchar)* pszScope1, const(wchar)* pszScope2, int* pfMatch);
}

@GUID("5D55A616-9DF8-4B09-B156-9BA351A48B76")
interface IWSDAttachment : IUnknown
{
}

@GUID("AA302F8D-5A22-4BA5-B392-AA8486F4C15D")
interface IWSDOutboundAttachment : IWSDAttachment
{
    HRESULT Write(char* pBuffer, uint dwBytesToWrite, uint* pdwNumberOfBytesWritten);
    HRESULT Close();
    HRESULT Abort();
}

@GUID("5BD6CA65-233C-4FB8-9F7A-2641619655C9")
interface IWSDInboundAttachment : IWSDAttachment
{
    HRESULT Read(char* pBuffer, uint dwBytesToRead, uint* pdwNumberOfBytesRead);
    HRESULT Close();
}


// GUIDs

const GUID CLSID_PNPXAssociation    = GUIDOF!PNPXAssociation;
const GUID CLSID_PNPXPairingHandler = GUIDOF!PNPXPairingHandler;

const GUID IID_IFunctionDiscovery                    = GUIDOF!IFunctionDiscovery;
const GUID IID_IFunctionDiscoveryNotification        = GUIDOF!IFunctionDiscoveryNotification;
const GUID IID_IFunctionDiscoveryProvider            = GUIDOF!IFunctionDiscoveryProvider;
const GUID IID_IFunctionDiscoveryProviderFactory     = GUIDOF!IFunctionDiscoveryProviderFactory;
const GUID IID_IFunctionDiscoveryProviderQuery       = GUIDOF!IFunctionDiscoveryProviderQuery;
const GUID IID_IFunctionDiscoveryServiceProvider     = GUIDOF!IFunctionDiscoveryServiceProvider;
const GUID IID_IFunctionInstance                     = GUIDOF!IFunctionInstance;
const GUID IID_IFunctionInstanceCollection           = GUIDOF!IFunctionInstanceCollection;
const GUID IID_IFunctionInstanceCollectionQuery      = GUIDOF!IFunctionInstanceCollectionQuery;
const GUID IID_IFunctionInstanceQuery                = GUIDOF!IFunctionInstanceQuery;
const GUID IID_IPNPXAssociation                      = GUIDOF!IPNPXAssociation;
const GUID IID_IPNPXDeviceAssociation                = GUIDOF!IPNPXDeviceAssociation;
const GUID IID_IPropertyStoreCollection              = GUIDOF!IPropertyStoreCollection;
const GUID IID_IProviderProperties                   = GUIDOF!IProviderProperties;
const GUID IID_IProviderPropertyConstraintCollection = GUIDOF!IProviderPropertyConstraintCollection;
const GUID IID_IProviderPublishing                   = GUIDOF!IProviderPublishing;
const GUID IID_IProviderQueryConstraintCollection    = GUIDOF!IProviderQueryConstraintCollection;
const GUID IID_IWSDAddress                           = GUIDOF!IWSDAddress;
const GUID IID_IWSDAsyncCallback                     = GUIDOF!IWSDAsyncCallback;
const GUID IID_IWSDAsyncResult                       = GUIDOF!IWSDAsyncResult;
const GUID IID_IWSDAttachment                        = GUIDOF!IWSDAttachment;
const GUID IID_IWSDDeviceHost                        = GUIDOF!IWSDDeviceHost;
const GUID IID_IWSDDeviceHostNotify                  = GUIDOF!IWSDDeviceHostNotify;
const GUID IID_IWSDDeviceProxy                       = GUIDOF!IWSDDeviceProxy;
const GUID IID_IWSDEndpointProxy                     = GUIDOF!IWSDEndpointProxy;
const GUID IID_IWSDEventingStatus                    = GUIDOF!IWSDEventingStatus;
const GUID IID_IWSDHttpAddress                       = GUIDOF!IWSDHttpAddress;
const GUID IID_IWSDHttpAuthParameters                = GUIDOF!IWSDHttpAuthParameters;
const GUID IID_IWSDHttpMessageParameters             = GUIDOF!IWSDHttpMessageParameters;
const GUID IID_IWSDInboundAttachment                 = GUIDOF!IWSDInboundAttachment;
const GUID IID_IWSDMessageParameters                 = GUIDOF!IWSDMessageParameters;
const GUID IID_IWSDMetadataExchange                  = GUIDOF!IWSDMetadataExchange;
const GUID IID_IWSDOutboundAttachment                = GUIDOF!IWSDOutboundAttachment;
const GUID IID_IWSDSSLClientCertificate              = GUIDOF!IWSDSSLClientCertificate;
const GUID IID_IWSDScopeMatchingRule                 = GUIDOF!IWSDScopeMatchingRule;
const GUID IID_IWSDServiceMessaging                  = GUIDOF!IWSDServiceMessaging;
const GUID IID_IWSDServiceProxy                      = GUIDOF!IWSDServiceProxy;
const GUID IID_IWSDServiceProxyEventing              = GUIDOF!IWSDServiceProxyEventing;
const GUID IID_IWSDSignatureProperty                 = GUIDOF!IWSDSignatureProperty;
const GUID IID_IWSDTransportAddress                  = GUIDOF!IWSDTransportAddress;
const GUID IID_IWSDUdpAddress                        = GUIDOF!IWSDUdpAddress;
const GUID IID_IWSDUdpMessageParameters              = GUIDOF!IWSDUdpMessageParameters;
const GUID IID_IWSDXMLContext                        = GUIDOF!IWSDXMLContext;
const GUID IID_IWSDiscoveredService                  = GUIDOF!IWSDiscoveredService;
const GUID IID_IWSDiscoveryProvider                  = GUIDOF!IWSDiscoveryProvider;
const GUID IID_IWSDiscoveryProviderNotify            = GUIDOF!IWSDiscoveryProviderNotify;
const GUID IID_IWSDiscoveryPublisher                 = GUIDOF!IWSDiscoveryPublisher;
const GUID IID_IWSDiscoveryPublisherNotify           = GUIDOF!IWSDiscoveryPublisherNotify;
