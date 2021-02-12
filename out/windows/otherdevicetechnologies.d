module windows.otherdevicetechnologies;

public import system;
public import windows.audio;
public import windows.com;
public import windows.security;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowspropertiessystem;

extern(Windows):

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

enum PropertyConstraint
{
    QC_EQUALS = 0,
    QC_NOTEQUAL = 1,
    QC_LESSTHAN = 2,
    QC_LESSTHANOREQUAL = 3,
    QC_GREATERTHAN = 4,
    QC_GREATERTHANOREQUAL = 5,
    QC_STARTSWITH = 6,
    QC_EXISTS = 7,
    QC_DOESNOTEXIST = 8,
    QC_CONTAINS = 9,
}

enum SystemVisibilityFlags
{
    SVF_SYSTEM = 0,
    SVF_USER = 1,
}

enum QueryUpdateAction
{
    QUA_ADD = 0,
    QUA_REMOVE = 1,
    QUA_CHANGE = 2,
}

enum QueryCategoryType
{
    QCT_PROVIDER = 0,
    QCT_LAYERED = 1,
}

const GUID IID_IFunctionDiscoveryNotification = {0x5F6C1BA8, 0x5330, 0x422E, [0xA3, 0x68, 0x57, 0x2B, 0x24, 0x4D, 0x3F, 0x87]};
@GUID(0x5F6C1BA8, 0x5330, 0x422E, [0xA3, 0x68, 0x57, 0x2B, 0x24, 0x4D, 0x3F, 0x87]);
interface IFunctionDiscoveryNotification : IUnknown
{
    HRESULT OnUpdate(QueryUpdateAction enumQueryUpdateAction, ulong fdqcQueryContext, IFunctionInstance pIFunctionInstance);
    HRESULT OnError(HRESULT hr, ulong fdqcQueryContext, const(wchar)* pszProvider);
    HRESULT OnEvent(uint dwEventID, ulong fdqcQueryContext, const(wchar)* pszProvider);
}

const GUID IID_IFunctionDiscovery = {0x4DF99B70, 0xE148, 0x4432, [0xB0, 0x04, 0x4C, 0x9E, 0xEB, 0x53, 0x5A, 0x5E]};
@GUID(0x4DF99B70, 0xE148, 0x4432, [0xB0, 0x04, 0x4C, 0x9E, 0xEB, 0x53, 0x5A, 0x5E]);
interface IFunctionDiscovery : IUnknown
{
    HRESULT GetInstanceCollection(const(wchar)* pszCategory, const(wchar)* pszSubCategory, BOOL fIncludeAllSubCategories, IFunctionInstanceCollection* ppIFunctionInstanceCollection);
    HRESULT GetInstance(const(wchar)* pszFunctionInstanceIdentity, IFunctionInstance* ppIFunctionInstance);
    HRESULT CreateInstanceCollectionQuery(const(wchar)* pszCategory, const(wchar)* pszSubCategory, BOOL fIncludeAllSubCategories, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, ulong* pfdqcQueryContext, IFunctionInstanceCollectionQuery* ppIFunctionInstanceCollectionQuery);
    HRESULT CreateInstanceQuery(const(wchar)* pszFunctionInstanceIdentity, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, ulong* pfdqcQueryContext, IFunctionInstanceQuery* ppIFunctionInstanceQuery);
    HRESULT AddInstance(SystemVisibilityFlags enumSystemVisibility, const(wchar)* pszCategory, const(wchar)* pszSubCategory, const(wchar)* pszCategoryIdentity, IFunctionInstance* ppIFunctionInstance);
    HRESULT RemoveInstance(SystemVisibilityFlags enumSystemVisibility, const(wchar)* pszCategory, const(wchar)* pszSubCategory, const(wchar)* pszCategoryIdentity);
}

const GUID IID_IFunctionInstance = {0x33591C10, 0x0BED, 0x4F02, [0xB0, 0xAB, 0x15, 0x30, 0xD5, 0x53, 0x3E, 0xE9]};
@GUID(0x33591C10, 0x0BED, 0x4F02, [0xB0, 0xAB, 0x15, 0x30, 0xD5, 0x53, 0x3E, 0xE9]);
interface IFunctionInstance : IServiceProvider
{
    HRESULT GetID(ushort** ppszCoMemIdentity);
    HRESULT GetProviderInstanceID(ushort** ppszCoMemProviderInstanceIdentity);
    HRESULT OpenPropertyStore(uint dwStgAccess, IPropertyStore* ppIPropertyStore);
    HRESULT GetCategory(ushort** ppszCoMemCategory, ushort** ppszCoMemSubCategory);
}

const GUID IID_IFunctionInstanceCollection = {0xF0A3D895, 0x855C, 0x42A2, [0x94, 0x8D, 0x2F, 0x97, 0xD4, 0x50, 0xEC, 0xB1]};
@GUID(0xF0A3D895, 0x855C, 0x42A2, [0x94, 0x8D, 0x2F, 0x97, 0xD4, 0x50, 0xEC, 0xB1]);
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

const GUID IID_IPropertyStoreCollection = {0xD14D9C30, 0x12D2, 0x42D8, [0xBC, 0xE4, 0xC6, 0x0C, 0x2B, 0xB2, 0x26, 0xFA]};
@GUID(0xD14D9C30, 0x12D2, 0x42D8, [0xBC, 0xE4, 0xC6, 0x0C, 0x2B, 0xB2, 0x26, 0xFA]);
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

const GUID IID_IFunctionInstanceQuery = {0x6242BC6B, 0x90EC, 0x4B37, [0xBB, 0x46, 0xE2, 0x29, 0xFD, 0x84, 0xED, 0x95]};
@GUID(0x6242BC6B, 0x90EC, 0x4B37, [0xBB, 0x46, 0xE2, 0x29, 0xFD, 0x84, 0xED, 0x95]);
interface IFunctionInstanceQuery : IUnknown
{
    HRESULT Execute(IFunctionInstance* ppIFunctionInstance);
}

const GUID IID_IFunctionInstanceCollectionQuery = {0x57CC6FD2, 0xC09A, 0x4289, [0xBB, 0x72, 0x25, 0xF0, 0x41, 0x42, 0x05, 0x8E]};
@GUID(0x57CC6FD2, 0xC09A, 0x4289, [0xBB, 0x72, 0x25, 0xF0, 0x41, 0x42, 0x05, 0x8E]);
interface IFunctionInstanceCollectionQuery : IUnknown
{
    HRESULT AddQueryConstraint(const(wchar)* pszConstraintName, const(wchar)* pszConstraintValue);
    HRESULT AddPropertyConstraint(const(PROPERTYKEY)* Key, const(PROPVARIANT)* pv, PropertyConstraint enumPropertyConstraint);
    HRESULT Execute(IFunctionInstanceCollection* ppIFunctionInstanceCollection);
}

interface CFunctionDiscoveryNotificationWrapper : IFunctionDiscoveryNotification
{
}

const GUID IID_IFunctionDiscoveryProvider = {0xDCDE394F, 0x1478, 0x4813, [0xA4, 0x02, 0xF6, 0xFB, 0x10, 0x65, 0x72, 0x22]};
@GUID(0xDCDE394F, 0x1478, 0x4813, [0xA4, 0x02, 0xF6, 0xFB, 0x10, 0x65, 0x72, 0x22]);
interface IFunctionDiscoveryProvider : IUnknown
{
    HRESULT Initialize(IFunctionDiscoveryProviderFactory pIFunctionDiscoveryProviderFactory, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, uint lcidUserDefault, uint* pdwStgAccessCapabilities);
    HRESULT Query(IFunctionDiscoveryProviderQuery pIFunctionDiscoveryProviderQuery, IFunctionInstanceCollection* ppIFunctionInstanceCollection);
    HRESULT EndQuery();
    HRESULT InstancePropertyStoreValidateAccess(IFunctionInstance pIFunctionInstance, int iProviderInstanceContext, const(uint) dwStgAccess);
    HRESULT InstancePropertyStoreOpen(IFunctionInstance pIFunctionInstance, int iProviderInstanceContext, const(uint) dwStgAccess, IPropertyStore* ppIPropertyStore);
    HRESULT InstancePropertyStoreFlush(IFunctionInstance pIFunctionInstance, int iProviderInstanceContext);
    HRESULT InstanceQueryService(IFunctionInstance pIFunctionInstance, int iProviderInstanceContext, const(Guid)* guidService, const(Guid)* riid, IUnknown* ppIUnknown);
    HRESULT InstanceReleased(IFunctionInstance pIFunctionInstance, int iProviderInstanceContext);
}

const GUID IID_IProviderProperties = {0xCF986EA6, 0x3B5F, 0x4C5F, [0xB8, 0x8A, 0x2F, 0x8B, 0x20, 0xCE, 0xEF, 0x17]};
@GUID(0xCF986EA6, 0x3B5F, 0x4C5F, [0xB8, 0x8A, 0x2F, 0x8B, 0x20, 0xCE, 0xEF, 0x17]);
interface IProviderProperties : IUnknown
{
    HRESULT GetCount(IFunctionInstance pIFunctionInstance, int iProviderInstanceContext, uint* pdwCount);
    HRESULT GetAt(IFunctionInstance pIFunctionInstance, int iProviderInstanceContext, uint dwIndex, PROPERTYKEY* pKey);
    HRESULT GetValue(IFunctionInstance pIFunctionInstance, int iProviderInstanceContext, const(PROPERTYKEY)* Key, PROPVARIANT* ppropVar);
    HRESULT SetValue(IFunctionInstance pIFunctionInstance, int iProviderInstanceContext, const(PROPERTYKEY)* Key, const(PROPVARIANT)* ppropVar);
}

const GUID IID_IProviderPublishing = {0xCD1B9A04, 0x206C, 0x4A05, [0xA0, 0xC8, 0x16, 0x35, 0xA2, 0x1A, 0x2B, 0x7C]};
@GUID(0xCD1B9A04, 0x206C, 0x4A05, [0xA0, 0xC8, 0x16, 0x35, 0xA2, 0x1A, 0x2B, 0x7C]);
interface IProviderPublishing : IUnknown
{
    HRESULT CreateInstance(SystemVisibilityFlags enumVisibilityFlags, const(wchar)* pszSubCategory, const(wchar)* pszProviderInstanceIdentity, IFunctionInstance* ppIFunctionInstance);
    HRESULT RemoveInstance(SystemVisibilityFlags enumVisibilityFlags, const(wchar)* pszSubCategory, const(wchar)* pszProviderInstanceIdentity);
}

const GUID IID_IFunctionDiscoveryProviderFactory = {0x86443FF0, 0x1AD5, 0x4E68, [0xA4, 0x5A, 0x40, 0xC2, 0xC3, 0x29, 0xDE, 0x3B]};
@GUID(0x86443FF0, 0x1AD5, 0x4E68, [0xA4, 0x5A, 0x40, 0xC2, 0xC3, 0x29, 0xDE, 0x3B]);
interface IFunctionDiscoveryProviderFactory : IUnknown
{
    HRESULT CreatePropertyStore(IPropertyStore* ppIPropertyStore);
    HRESULT CreateInstance(const(wchar)* pszSubCategory, const(wchar)* pszProviderInstanceIdentity, int iProviderInstanceContext, IPropertyStore pIPropertyStore, IFunctionDiscoveryProvider pIFunctionDiscoveryProvider, IFunctionInstance* ppIFunctionInstance);
    HRESULT CreateFunctionInstanceCollection(IFunctionInstanceCollection* ppIFunctionInstanceCollection);
}

const GUID IID_IFunctionDiscoveryProviderQuery = {0x6876EA98, 0xBAEC, 0x46DB, [0xBC, 0x20, 0x75, 0xA7, 0x6E, 0x26, 0x7A, 0x3A]};
@GUID(0x6876EA98, 0xBAEC, 0x46DB, [0xBC, 0x20, 0x75, 0xA7, 0x6E, 0x26, 0x7A, 0x3A]);
interface IFunctionDiscoveryProviderQuery : IUnknown
{
    HRESULT IsInstanceQuery(int* pisInstanceQuery, ushort** ppszConstraintValue);
    HRESULT IsSubcategoryQuery(int* pisSubcategoryQuery, ushort** ppszConstraintValue);
    HRESULT GetQueryConstraints(IProviderQueryConstraintCollection* ppIProviderQueryConstraints);
    HRESULT GetPropertyConstraints(IProviderPropertyConstraintCollection* ppIProviderPropertyConstraints);
}

const GUID IID_IProviderQueryConstraintCollection = {0x9C243E11, 0x3261, 0x4BCD, [0xB9, 0x22, 0x84, 0xA8, 0x73, 0xD4, 0x60, 0xAE]};
@GUID(0x9C243E11, 0x3261, 0x4BCD, [0xB9, 0x22, 0x84, 0xA8, 0x73, 0xD4, 0x60, 0xAE]);
interface IProviderQueryConstraintCollection : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT Get(const(wchar)* pszConstraintName, ushort** ppszConstraintValue);
    HRESULT Item(uint dwIndex, ushort** ppszConstraintName, ushort** ppszConstraintValue);
    HRESULT Next(ushort** ppszConstraintName, ushort** ppszConstraintValue);
    HRESULT Skip();
    HRESULT Reset();
}

const GUID IID_IProviderPropertyConstraintCollection = {0xF4FAE42F, 0x5778, 0x4A13, [0x85, 0x40, 0xB5, 0xFD, 0x8C, 0x13, 0x98, 0xDD]};
@GUID(0xF4FAE42F, 0x5778, 0x4A13, [0x85, 0x40, 0xB5, 0xFD, 0x8C, 0x13, 0x98, 0xDD]);
interface IProviderPropertyConstraintCollection : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT Get(const(PROPERTYKEY)* Key, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    HRESULT Item(uint dwIndex, PROPERTYKEY* pKey, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    HRESULT Next(PROPERTYKEY* pKey, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    HRESULT Skip();
    HRESULT Reset();
}

const GUID IID_IFunctionDiscoveryServiceProvider = {0x4C81ED02, 0x1B04, 0x43F2, [0xA4, 0x51, 0x69, 0x96, 0x6C, 0xBC, 0xD1, 0xC2]};
@GUID(0x4C81ED02, 0x1B04, 0x43F2, [0xA4, 0x51, 0x69, 0x96, 0x6C, 0xBC, 0xD1, 0xC2]);
interface IFunctionDiscoveryServiceProvider : IUnknown
{
    HRESULT Initialize(IFunctionInstance pIFunctionInstance, const(Guid)* riid, void** ppv);
}

const GUID CLSID_PNPXAssociation = {0xCEE8CCC9, 0x4F6B, 0x4469, [0xA2, 0x35, 0x5A, 0x22, 0x86, 0x9E, 0xEF, 0x03]};
@GUID(0xCEE8CCC9, 0x4F6B, 0x4469, [0xA2, 0x35, 0x5A, 0x22, 0x86, 0x9E, 0xEF, 0x03]);
struct PNPXAssociation;

const GUID CLSID_PNPXPairingHandler = {0xB8A27942, 0xADE7, 0x4085, [0xAA, 0x6E, 0x4F, 0xAD, 0xC7, 0xAD, 0xA1, 0xEF]};
@GUID(0xB8A27942, 0xADE7, 0x4085, [0xAA, 0x6E, 0x4F, 0xAD, 0xC7, 0xAD, 0xA1, 0xEF]);
struct PNPXPairingHandler;

const GUID IID_IPNPXAssociation = {0x0BD7E521, 0x4DA6, 0x42D5, [0x81, 0xBA, 0x19, 0x81, 0xB6, 0xB9, 0x40, 0x75]};
@GUID(0x0BD7E521, 0x4DA6, 0x42D5, [0x81, 0xBA, 0x19, 0x81, 0xB6, 0xB9, 0x40, 0x75]);
interface IPNPXAssociation : IUnknown
{
    HRESULT Associate(const(wchar)* pszSubcategory);
    HRESULT Unassociate(const(wchar)* pszSubcategory);
    HRESULT Delete(const(wchar)* pszSubcategory);
}

const GUID IID_IPNPXDeviceAssociation = {0xEED366D0, 0x35B8, 0x4FC5, [0x8D, 0x20, 0x7E, 0x5B, 0xD3, 0x1F, 0x6D, 0xED]};
@GUID(0xEED366D0, 0x35B8, 0x4FC5, [0x8D, 0x20, 0x7E, 0x5B, 0xD3, 0x1F, 0x6D, 0xED]);
interface IPNPXDeviceAssociation : IUnknown
{
    HRESULT Associate(const(wchar)* pszSubCategory, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
    HRESULT Unassociate(const(wchar)* pszSubCategory, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
    HRESULT Delete(const(wchar)* pszSubcategory, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
}

struct WSD_DATETIME
{
    BOOL isPositive;
    uint year;
    ubyte month;
    ubyte day;
    ubyte hour;
    ubyte minute;
    ubyte second;
    uint millisecond;
    BOOL TZIsLocal;
    BOOL TZIsPositive;
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

enum __MIDL___MIDL_itf_wsdxml_0000_0000_0001
{
    OpNone = 0,
    OpEndOfTable = 1,
    OpBeginElement_ = 2,
    OpBeginAnyElement = 3,
    OpEndElement = 4,
    OpElement_ = 5,
    OpAnyElement = 6,
    OpAnyElements = 7,
    OpAnyText = 8,
    OpAttribute_ = 9,
    OpBeginChoice = 10,
    OpEndChoice = 11,
    OpBeginSequence = 12,
    OpEndSequence = 13,
    OpBeginAll = 14,
    OpEndAll = 15,
    OpAnything = 16,
    OpAnyNumber = 17,
    OpOneOrMore = 18,
    OpOptional = 19,
    OpFormatBool_ = 20,
    OpFormatInt8_ = 21,
    OpFormatInt16_ = 22,
    OpFormatInt32_ = 23,
    OpFormatInt64_ = 24,
    OpFormatUInt8_ = 25,
    OpFormatUInt16_ = 26,
    OpFormatUInt32_ = 27,
    OpFormatUInt64_ = 28,
    OpFormatUnicodeString_ = 29,
    OpFormatDom_ = 30,
    OpFormatStruct_ = 31,
    OpFormatUri_ = 32,
    OpFormatUuidUri_ = 33,
    OpFormatName_ = 34,
    OpFormatListInsertTail_ = 35,
    OpFormatType_ = 36,
    OpFormatDynamicType_ = 37,
    OpFormatLookupType_ = 38,
    OpFormatDuration_ = 39,
    OpFormatDateTime_ = 40,
    OpFormatFloat_ = 41,
    OpFormatDouble_ = 42,
    OpProcess_ = 43,
    OpQualifiedAttribute_ = 44,
    OpFormatXMLDeclaration_ = 45,
    OpFormatMax = 46,
}

const GUID IID_IWSDXMLContext = {0x75D8F3EE, 0x3E5A, 0x43B4, [0xA1, 0x5A, 0xBC, 0xF6, 0x88, 0x74, 0x60, 0xC0]};
@GUID(0x75D8F3EE, 0x3E5A, 0x43B4, [0xA1, 0x5A, 0xBC, 0xF6, 0x88, 0x74, 0x60, 0xC0]);
interface IWSDXMLContext : IUnknown
{
    HRESULT AddNamespace(const(wchar)* pszUri, const(wchar)* pszSuggestedPrefix, WSDXML_NAMESPACE** ppNamespace);
    HRESULT AddNameToNamespace(const(wchar)* pszUri, const(wchar)* pszName, WSDXML_NAME** ppName);
    HRESULT SetNamespaces(char* pNamespaces, ushort wNamespacesCount, ubyte bLayerNumber);
    HRESULT SetTypes(char* pTypes, uint dwTypesCount, ubyte bLayerNumber);
}

enum WSD_CONFIG_PARAM_TYPE
{
    WSD_CONFIG_MAX_INBOUND_MESSAGE_SIZE = 1,
    WSD_CONFIG_MAX_OUTBOUND_MESSAGE_SIZE = 2,
    WSD_SECURITY_SSL_CERT_FOR_CLIENT_AUTH = 3,
    WSD_SECURITY_SSL_SERVER_CERT_VALIDATION = 4,
    WSD_SECURITY_SSL_CLIENT_CERT_VALIDATION = 5,
    WSD_SECURITY_SSL_NEGOTIATE_CLIENT_CERT = 6,
    WSD_SECURITY_COMPACTSIG_SIGNING_CERT = 7,
    WSD_SECURITY_COMPACTSIG_VALIDATION = 8,
    WSD_CONFIG_HOSTING_ADDRESSES = 9,
    WSD_CONFIG_DEVICE_ADDRESSES = 10,
    WSD_SECURITY_REQUIRE_HTTP_CLIENT_AUTH = 11,
    WSD_SECURITY_REQUIRE_CLIENT_CERT_OR_HTTP_CLIENT_AUTH = 12,
    WSD_SECURITY_USE_HTTP_CLIENT_AUTH = 13,
}

struct WSD_CONFIG_PARAM
{
    WSD_CONFIG_PARAM_TYPE configParamType;
    void* pConfigData;
    uint dwConfigDataSize;
}

struct WSD_SECURITY_CERT_VALIDATION_V1
{
    CERT_CONTEXT** certMatchArray;
    uint dwCertMatchArrayCount;
    void* hCertMatchStore;
    void* hCertIssuerStore;
    uint dwCertCheckOptions;
}

struct WSD_SECURITY_CERT_VALIDATION
{
    CERT_CONTEXT** certMatchArray;
    uint dwCertMatchArrayCount;
    void* hCertMatchStore;
    void* hCertIssuerStore;
    uint dwCertCheckOptions;
    const(wchar)* pszCNGHashAlgId;
    ubyte* pbCertHash;
    uint dwCertHashSize;
}

struct WSD_SECURITY_SIGNATURE_VALIDATION
{
    CERT_CONTEXT** signingCertArray;
    uint dwSigningCertArrayCount;
    void* hSigningCertStore;
    uint dwFlags;
}

struct WSD_CONFIG_ADDRESSES
{
    IWSDAddress* addresses;
    uint dwAddressCount;
}

const GUID IID_IWSDAddress = {0xB9574C6C, 0x12A6, 0x4F74, [0x93, 0xA1, 0x33, 0x18, 0xFF, 0x60, 0x57, 0x59]};
@GUID(0xB9574C6C, 0x12A6, 0x4F74, [0x93, 0xA1, 0x33, 0x18, 0xFF, 0x60, 0x57, 0x59]);
interface IWSDAddress : IUnknown
{
    HRESULT Serialize(const(wchar)* pszBuffer, uint cchLength, BOOL fSafe);
    HRESULT Deserialize(const(wchar)* pszBuffer);
}

const GUID IID_IWSDTransportAddress = {0x70D23498, 0x4EE6, 0x4340, [0xA3, 0xDF, 0xD8, 0x45, 0xD2, 0x23, 0x54, 0x67]};
@GUID(0x70D23498, 0x4EE6, 0x4340, [0xA3, 0xDF, 0xD8, 0x45, 0xD2, 0x23, 0x54, 0x67]);
interface IWSDTransportAddress : IWSDAddress
{
    HRESULT GetPort(ushort* pwPort);
    HRESULT SetPortA(ushort wPort);
    HRESULT GetTransportAddress(ushort** ppszAddress);
    HRESULT GetTransportAddressEx(BOOL fSafe, ushort** ppszAddress);
    HRESULT SetTransportAddress(const(wchar)* pszAddress);
}

const GUID IID_IWSDMessageParameters = {0x1FAFE8A2, 0xE6FC, 0x4B80, [0xB6, 0xCF, 0xB7, 0xD4, 0x5C, 0x41, 0x6D, 0x7C]};
@GUID(0x1FAFE8A2, 0xE6FC, 0x4B80, [0xB6, 0xCF, 0xB7, 0xD4, 0x5C, 0x41, 0x6D, 0x7C]);
interface IWSDMessageParameters : IUnknown
{
    HRESULT GetLocalAddress(IWSDAddress* ppAddress);
    HRESULT SetLocalAddress(IWSDAddress pAddress);
    HRESULT GetRemoteAddress(IWSDAddress* ppAddress);
    HRESULT SetRemoteAddress(IWSDAddress pAddress);
    HRESULT GetLowerParameters(IWSDMessageParameters* ppTxParams);
}

struct WSDUdpRetransmitParams
{
    uint ulSendDelay;
    uint ulRepeat;
    uint ulRepeatMinDelay;
    uint ulRepeatMaxDelay;
    uint ulRepeatUpperDelay;
}

const GUID IID_IWSDUdpMessageParameters = {0x9934149F, 0x8F0C, 0x447B, [0xAA, 0x0B, 0x73, 0x12, 0x4B, 0x0C, 0xA7, 0xF0]};
@GUID(0x9934149F, 0x8F0C, 0x447B, [0xAA, 0x0B, 0x73, 0x12, 0x4B, 0x0C, 0xA7, 0xF0]);
interface IWSDUdpMessageParameters : IWSDMessageParameters
{
    HRESULT SetRetransmitParams(const(WSDUdpRetransmitParams)* pParams);
    HRESULT GetRetransmitParams(WSDUdpRetransmitParams* pParams);
}

struct SOCKADDR_STORAGE
{
}

enum WSDUdpMessageType
{
    ONE_WAY = 0,
    TWO_WAY = 1,
}

const GUID IID_IWSDUdpAddress = {0x74D6124A, 0xA441, 0x4F78, [0xA1, 0xEB, 0x97, 0xA8, 0xD1, 0x99, 0x68, 0x93]};
@GUID(0x74D6124A, 0xA441, 0x4F78, [0xA1, 0xEB, 0x97, 0xA8, 0xD1, 0x99, 0x68, 0x93]);
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
    HRESULT SetAlias(const(Guid)* pAlias);
    HRESULT GetAlias(Guid* pAlias);
}

const GUID IID_IWSDHttpMessageParameters = {0x540BD122, 0x5C83, 0x4DEC, [0xB3, 0x96, 0xEA, 0x62, 0xA2, 0x69, 0x7F, 0xDF]};
@GUID(0x540BD122, 0x5C83, 0x4DEC, [0xB3, 0x96, 0xEA, 0x62, 0xA2, 0x69, 0x7F, 0xDF]);
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

const GUID IID_IWSDHttpAddress = {0xD09AC7BD, 0x2A3E, 0x4B85, [0x86, 0x05, 0x27, 0x37, 0xFF, 0x3E, 0x4E, 0xA0]};
@GUID(0xD09AC7BD, 0x2A3E, 0x4B85, [0x86, 0x05, 0x27, 0x37, 0xFF, 0x3E, 0x4E, 0xA0]);
interface IWSDHttpAddress : IWSDTransportAddress
{
    HRESULT GetSecure();
    HRESULT SetSecure(BOOL fSecure);
    HRESULT GetPath(ushort** ppszPath);
    HRESULT SetPath(const(wchar)* pszPath);
}

const GUID IID_IWSDSSLClientCertificate = {0xDE105E87, 0xA0DA, 0x418E, [0x98, 0xAD, 0x27, 0xB9, 0xEE, 0xD8, 0x7B, 0xDC]};
@GUID(0xDE105E87, 0xA0DA, 0x418E, [0x98, 0xAD, 0x27, 0xB9, 0xEE, 0xD8, 0x7B, 0xDC]);
interface IWSDSSLClientCertificate : IUnknown
{
    HRESULT GetClientCertificate(CERT_CONTEXT** ppCertContext);
    HRESULT GetMappedAccessToken(HANDLE* phToken);
}

const GUID IID_IWSDHttpAuthParameters = {0x0B476DF0, 0x8DAC, 0x480D, [0xB0, 0x5C, 0x99, 0x78, 0x1A, 0x58, 0x84, 0xAA]};
@GUID(0x0B476DF0, 0x8DAC, 0x480D, [0xB0, 0x5C, 0x99, 0x78, 0x1A, 0x58, 0x84, 0xAA]);
interface IWSDHttpAuthParameters : IUnknown
{
    HRESULT GetClientAccessToken(HANDLE* phToken);
    HRESULT GetAuthType(uint* pAuthType);
}

const GUID IID_IWSDSignatureProperty = {0x03CE20AA, 0x71C4, 0x45E2, [0xB3, 0x2E, 0x37, 0x66, 0xC6, 0x1C, 0x79, 0x0F]};
@GUID(0x03CE20AA, 0x71C4, 0x45E2, [0xB3, 0x2E, 0x37, 0x66, 0xC6, 0x1C, 0x79, 0x0F]);
interface IWSDSignatureProperty : IUnknown
{
    HRESULT IsMessageSigned(int* pbSigned);
    HRESULT IsMessageSignatureTrusted(int* pbSignatureTrusted);
    HRESULT GetKeyInfo(char* pbKeyInfo, uint* pdwKeyInfoSize);
    HRESULT GetSignature(char* pbSignature, uint* pdwSignatureSize);
    HRESULT GetSignedInfoHash(char* pbSignedInfoHash, uint* pdwHashSize);
}

alias WSD_STUB_FUNCTION = extern(Windows) HRESULT function(IUnknown server, IWSDServiceMessaging session, WSD_EVENT* event);
enum DeviceDiscoveryMechanism
{
    MulticastDiscovery = 0,
    DirectedDiscovery = 1,
    SecureDirectedDiscovery = 2,
}

enum WSD_PROTOCOL_TYPE
{
    WSD_PT_NONE = 0,
    WSD_PT_UDP = 1,
    WSD_PT_HTTP = 2,
    WSD_PT_HTTPS = 4,
    WSD_PT_ALL = 255,
}

struct WSD_OPERATION
{
    WSDXML_TYPE* RequestType;
    WSDXML_TYPE* ResponseType;
    WSD_STUB_FUNCTION RequestStubFunction;
}

alias PWSD_SOAP_MESSAGE_HANDLER = extern(Windows) HRESULT function(IUnknown thisUnknown, WSD_EVENT* event);
struct WSD_HANDLER_CONTEXT
{
    PWSD_SOAP_MESSAGE_HANDLER Handler;
    void* PVoid;
    IUnknown Unknown;
}

enum WSDEventType
{
    WSDET_NONE = 0,
    WSDET_INCOMING_MESSAGE = 1,
    WSDET_INCOMING_FAULT = 2,
    WSDET_TRANSMISSION_FAILURE = 3,
    WSDET_RESPONSE_TIMEOUT = 4,
}

struct WSD_SYNCHRONOUS_RESPONSE_CONTEXT
{
    HRESULT hr;
    HANDLE eventHandle;
    IWSDMessageParameters messageParameters;
    void* results;
}

struct WSD_PORT_TYPE
{
    uint EncodedName;
    uint OperationCount;
    WSD_OPERATION* Operations;
    WSD_PROTOCOL_TYPE ProtocolType;
}

struct WSD_RELATIONSHIP_METADATA
{
    const(wchar)* Type;
    WSD_HOST_METADATA* Data;
    WSDXML_ELEMENT* Any;
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
    WSD_NAME_LIST* Types;
    const(wchar)* ServiceId;
    WSDXML_ELEMENT* Any;
}

struct WSD_THIS_DEVICE_METADATA
{
    WSD_LOCALIZED_STRING_LIST* FriendlyName;
    const(wchar)* FirmwareVersion;
    const(wchar)* SerialNumber;
    WSDXML_ELEMENT* Any;
}

struct WSD_THIS_MODEL_METADATA
{
    WSD_LOCALIZED_STRING_LIST* Manufacturer;
    const(wchar)* ManufacturerUrl;
    WSD_LOCALIZED_STRING_LIST* ModelName;
    const(wchar)* ModelNumber;
    const(wchar)* ModelUrl;
    const(wchar)* PresentationUrl;
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
    const(wchar)* Node;
    const(wchar)* Role;
    WSDXML_ELEMENT* Detail;
}

struct WSD_APP_SEQUENCE
{
    ulong InstanceId;
    const(wchar)* SequenceId;
    ulong MessageNumber;
}

struct WSD_HEADER_RELATESTO
{
    WSDXML_NAME* RelationshipType;
    const(wchar)* MessageID;
}

struct WSD_SOAP_HEADER
{
    const(wchar)* To;
    const(wchar)* Action;
    const(wchar)* MessageID;
    WSD_HEADER_RELATESTO RelatesTo;
    WSD_ENDPOINT_REFERENCE* ReplyTo;
    WSD_ENDPOINT_REFERENCE* From;
    WSD_ENDPOINT_REFERENCE* FaultTo;
    WSD_APP_SEQUENCE* AppSequence;
    WSDXML_ELEMENT* AnyHeaders;
}

struct WSD_SOAP_MESSAGE
{
    WSD_SOAP_HEADER Header;
    void* Body;
    WSDXML_TYPE* BodyType;
}

struct WSD_RESOLVE_MATCHES
{
    WSD_RESOLVE_MATCH* ResolveMatch;
    WSDXML_ELEMENT* Any;
}

struct WSD_RESOLVE_MATCH
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSD_NAME_LIST* Types;
    WSD_SCOPES* Scopes;
    WSD_URI_LIST* XAddrs;
    ulong MetadataVersion;
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
    WSD_NAME_LIST* Types;
    WSD_SCOPES* Scopes;
    WSD_URI_LIST* XAddrs;
    ulong MetadataVersion;
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
    WSD_NAME_LIST* Types;
    WSD_SCOPES* Scopes;
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
    WSDXML_NAME* Element;
}

struct WSD_HELLO
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSD_NAME_LIST* Types;
    WSD_SCOPES* Scopes;
    WSD_URI_LIST* XAddrs;
    ulong MetadataVersion;
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
    const(wchar)* Address;
    WSD_REFERENCE_PROPERTIES ReferenceProperties;
    WSD_REFERENCE_PARAMETERS ReferenceParameters;
    WSDXML_NAME* PortType;
    WSDXML_NAME* ServiceName;
    WSDXML_ELEMENT* Any;
}

struct WSD_METADATA_SECTION
{
    const(wchar)* Dialect;
    const(wchar)* Identifier;
    void* Data;
    WSD_ENDPOINT_REFERENCE* MetadataReference;
    const(wchar)* Location;
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
    void* Data;
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
    void* Data;
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
    WSDXML_ELEMENT* Any;
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
    const(wchar)* Status;
    WSD_LOCALIZED_STRING* Reason;
    WSDXML_ELEMENT* Any;
}

struct WSD_UNKNOWN_LOOKUP
{
    WSDXML_ELEMENT* Any;
}

struct WSD_EVENT
{
    HRESULT Hr;
    uint EventType;
    ushort* DispatchTag;
    WSD_HANDLER_CONTEXT HandlerContext;
    WSD_SOAP_MESSAGE* Soap;
    WSD_OPERATION* Operation;
    IWSDMessageParameters MessageParameters;
}

struct WSDXML_NAMESPACE
{
    const(wchar)* Uri;
    const(wchar)* PreferredPrefix;
    WSDXML_NAME* Names;
    ushort NamesCount;
    ushort Encoding;
}

struct WSDXML_NAME
{
    WSDXML_NAMESPACE* Space;
    ushort* LocalName;
}

struct WSDXML_TYPE
{
    const(wchar)* Uri;
    const(ubyte)* Table;
}

struct WSDXML_PREFIX_MAPPING
{
    uint Refs;
    WSDXML_PREFIX_MAPPING* Next;
    WSDXML_NAMESPACE* Space;
    ushort* Prefix;
}

struct WSDXML_ATTRIBUTE
{
    WSDXML_ELEMENT* Element;
    WSDXML_ATTRIBUTE* Next;
    WSDXML_NAME* Name;
    ushort* Value;
}

struct WSDXML_NODE
{
    int Type;
    WSDXML_ELEMENT* Parent;
    WSDXML_NODE* Next;
    enum int ElementType = 0;
    enum int TextType = 1;
}

struct WSDXML_ELEMENT
{
    WSDXML_NODE Node;
    WSDXML_NAME* Name;
    WSDXML_ATTRIBUTE* FirstAttribute;
    WSDXML_NODE* FirstChild;
    WSDXML_PREFIX_MAPPING* PrefixMappings;
}

struct WSDXML_TEXT
{
    WSDXML_NODE Node;
    ushort* Text;
}

struct WSDXML_ELEMENT_LIST
{
    WSDXML_ELEMENT_LIST* Next;
    WSDXML_ELEMENT* Element;
}

const GUID IID_IWSDDeviceHost = {0x917FE891, 0x3D13, 0x4138, [0x98, 0x09, 0x93, 0x4C, 0x8A, 0xBE, 0xB1, 0x2C]};
@GUID(0x917FE891, 0x3D13, 0x4138, [0x98, 0x09, 0x93, 0x4C, 0x8A, 0xBE, 0xB1, 0x2C]);
interface IWSDDeviceHost : IUnknown
{
    HRESULT Init(const(wchar)* pszLocalId, IWSDXMLContext pContext, char* ppHostAddresses, uint dwHostAddressCount);
    HRESULT Start(ulong ullInstanceId, const(WSD_URI_LIST)* pScopeList, IWSDDeviceHostNotify pNotificationSink);
    HRESULT Stop();
    HRESULT Terminate();
    HRESULT RegisterPortType(const(WSD_PORT_TYPE)* pPortType);
    HRESULT SetMetadata(const(WSD_THIS_MODEL_METADATA)* pThisModelMetadata, const(WSD_THIS_DEVICE_METADATA)* pThisDeviceMetadata, const(WSD_HOST_METADATA)* pHostMetadata, const(WSD_METADATA_SECTION_LIST)* pCustomMetadata);
    HRESULT RegisterService(const(wchar)* pszServiceId, IUnknown pService);
    HRESULT RetireService(const(wchar)* pszServiceId);
    HRESULT AddDynamicService(const(wchar)* pszServiceId, const(wchar)* pszEndpointAddress, const(WSD_PORT_TYPE)* pPortType, const(WSDXML_NAME)* pPortName, const(WSDXML_ELEMENT)* pAny, IUnknown pService);
    HRESULT RemoveDynamicService(const(wchar)* pszServiceId);
    HRESULT SetServiceDiscoverable(const(wchar)* pszServiceId, BOOL fDiscoverable);
    HRESULT SignalEvent(const(wchar)* pszServiceId, const(void)* pBody, const(WSD_OPERATION)* pOperation);
}

const GUID IID_IWSDDeviceHostNotify = {0xB5BEE9F9, 0xEEDA, 0x41FE, [0x96, 0xF7, 0xF4, 0x5E, 0x14, 0x99, 0x0F, 0xB0]};
@GUID(0xB5BEE9F9, 0xEEDA, 0x41FE, [0x96, 0xF7, 0xF4, 0x5E, 0x14, 0x99, 0x0F, 0xB0]);
interface IWSDDeviceHostNotify : IUnknown
{
    HRESULT GetService(const(wchar)* pszServiceId, IUnknown* ppService);
}

const GUID IID_IWSDServiceMessaging = {0x94974CF4, 0x0CAB, 0x460D, [0xA3, 0xF6, 0x7A, 0x0A, 0xD6, 0x23, 0xC0, 0xE6]};
@GUID(0x94974CF4, 0x0CAB, 0x460D, [0xA3, 0xF6, 0x7A, 0x0A, 0xD6, 0x23, 0xC0, 0xE6]);
interface IWSDServiceMessaging : IUnknown
{
    HRESULT SendResponse(void* pBody, WSD_OPERATION* pOperation, IWSDMessageParameters pMessageParameters);
    HRESULT FaultRequest(WSD_SOAP_HEADER* pRequestHeader, IWSDMessageParameters pMessageParameters, WSD_SOAP_FAULT* pFault);
}

const GUID IID_IWSDEndpointProxy = {0x1860D430, 0xB24C, 0x4975, [0x9F, 0x90, 0xDB, 0xB3, 0x9B, 0xAA, 0x24, 0xEC]};
@GUID(0x1860D430, 0xB24C, 0x4975, [0x9F, 0x90, 0xDB, 0xB3, 0x9B, 0xAA, 0x24, 0xEC]);
interface IWSDEndpointProxy : IUnknown
{
    HRESULT SendOneWayRequest(const(void)* pBody, const(WSD_OPERATION)* pOperation);
    HRESULT SendTwoWayRequest(const(void)* pBody, const(WSD_OPERATION)* pOperation, const(WSD_SYNCHRONOUS_RESPONSE_CONTEXT)* pResponseContext);
    HRESULT SendTwoWayRequestAsync(const(void)* pBody, const(WSD_OPERATION)* pOperation, IUnknown pAsyncState, IWSDAsyncCallback pCallback, IWSDAsyncResult* pResult);
    HRESULT AbortAsyncOperation(IWSDAsyncResult pAsyncResult);
    HRESULT ProcessFault(const(WSD_SOAP_FAULT)* pFault);
    HRESULT GetErrorInfo(ushort** ppszErrorInfo);
    HRESULT GetFaultInfo(WSD_SOAP_FAULT** ppFault);
}

const GUID IID_IWSDMetadataExchange = {0x06996D57, 0x1D67, 0x4928, [0x93, 0x07, 0x3D, 0x78, 0x33, 0xFD, 0xB8, 0x46]};
@GUID(0x06996D57, 0x1D67, 0x4928, [0x93, 0x07, 0x3D, 0x78, 0x33, 0xFD, 0xB8, 0x46]);
interface IWSDMetadataExchange : IUnknown
{
    HRESULT GetMetadata(WSD_METADATA_SECTION_LIST** MetadataOut);
}

const GUID IID_IWSDServiceProxy = {0xD4C7FB9C, 0x03AB, 0x4175, [0x9D, 0x67, 0x09, 0x4F, 0xAF, 0xEB, 0xF4, 0x87]};
@GUID(0xD4C7FB9C, 0x03AB, 0x4175, [0x9D, 0x67, 0x09, 0x4F, 0xAF, 0xEB, 0xF4, 0x87]);
interface IWSDServiceProxy : IWSDMetadataExchange
{
    HRESULT BeginGetMetadata(IWSDAsyncResult* ppResult);
    HRESULT EndGetMetadata(IWSDAsyncResult pResult, WSD_METADATA_SECTION_LIST** ppMetadata);
    HRESULT GetServiceMetadata(WSD_SERVICE_METADATA** ppServiceMetadata);
    HRESULT SubscribeToOperation(const(WSD_OPERATION)* pOperation, IUnknown pUnknown, const(WSDXML_ELEMENT)* pAny, WSDXML_ELEMENT** ppAny);
    HRESULT UnsubscribeToOperation(const(WSD_OPERATION)* pOperation);
    HRESULT SetEventingStatusCallback(IWSDEventingStatus pStatus);
    HRESULT GetEndpointProxy(IWSDEndpointProxy* ppProxy);
}

const GUID IID_IWSDServiceProxyEventing = {0xF9279D6D, 0x1012, 0x4A94, [0xB8, 0xCC, 0xFD, 0x35, 0xD2, 0x20, 0x2B, 0xFE]};
@GUID(0xF9279D6D, 0x1012, 0x4A94, [0xB8, 0xCC, 0xFD, 0x35, 0xD2, 0x20, 0x2B, 0xFE]);
interface IWSDServiceProxyEventing : IWSDServiceProxy
{
    HRESULT SubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IUnknown pUnknown, const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    HRESULT BeginSubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IUnknown pUnknown, const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
    HRESULT EndSubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult, WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    HRESULT UnsubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, const(WSDXML_ELEMENT)* pAny);
    HRESULT BeginUnsubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
    HRESULT EndUnsubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult);
    HRESULT RenewMultipleOperations(char* pOperations, uint dwOperationCount, const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    HRESULT BeginRenewMultipleOperations(char* pOperations, uint dwOperationCount, const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
    HRESULT EndRenewMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult, WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    HRESULT GetStatusForMultipleOperations(char* pOperations, uint dwOperationCount, const(WSDXML_ELEMENT)* pAny, WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    HRESULT BeginGetStatusForMultipleOperations(char* pOperations, uint dwOperationCount, const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
    HRESULT EndGetStatusForMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult, WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
}

const GUID IID_IWSDDeviceProxy = {0xEEE0C031, 0xC578, 0x4C0E, [0x9A, 0x3B, 0x97, 0x3C, 0x35, 0xF4, 0x09, 0xDB]};
@GUID(0xEEE0C031, 0xC578, 0x4C0E, [0x9A, 0x3B, 0x97, 0x3C, 0x35, 0xF4, 0x09, 0xDB]);
interface IWSDDeviceProxy : IUnknown
{
    HRESULT Init(const(wchar)* pszDeviceId, IWSDAddress pDeviceAddress, const(wchar)* pszLocalId, IWSDXMLContext pContext, IWSDDeviceProxy pSponsor);
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

const GUID IID_IWSDAsyncResult = {0x11A9852A, 0x8DD8, 0x423E, [0xB5, 0x37, 0x93, 0x56, 0xDB, 0x4F, 0xBF, 0xB8]};
@GUID(0x11A9852A, 0x8DD8, 0x423E, [0xB5, 0x37, 0x93, 0x56, 0xDB, 0x4F, 0xBF, 0xB8]);
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

const GUID IID_IWSDAsyncCallback = {0xA63E109D, 0xCE72, 0x49E2, [0xBA, 0x98, 0xE8, 0x45, 0xF5, 0xEE, 0x16, 0x66]};
@GUID(0xA63E109D, 0xCE72, 0x49E2, [0xBA, 0x98, 0xE8, 0x45, 0xF5, 0xEE, 0x16, 0x66]);
interface IWSDAsyncCallback : IUnknown
{
    HRESULT AsyncOperationComplete(IWSDAsyncResult pAsyncResult, IUnknown pAsyncState);
}

const GUID IID_IWSDEventingStatus = {0x49B17F52, 0x637A, 0x407A, [0xAE, 0x99, 0xFB, 0xE8, 0x2A, 0x4D, 0x38, 0xC0]};
@GUID(0x49B17F52, 0x637A, 0x407A, [0xAE, 0x99, 0xFB, 0xE8, 0x2A, 0x4D, 0x38, 0xC0]);
interface IWSDEventingStatus : IUnknown
{
    void SubscriptionRenewed(const(wchar)* pszSubscriptionAction);
    void SubscriptionRenewalFailed(const(wchar)* pszSubscriptionAction, HRESULT hr);
    void SubscriptionEnded(const(wchar)* pszSubscriptionAction);
}

const GUID IID_IWSDiscoveryProvider = {0x8FFC8E55, 0xF0EB, 0x480F, [0x88, 0xB7, 0xB4, 0x35, 0xDD, 0x28, 0x1D, 0x45]};
@GUID(0x8FFC8E55, 0xF0EB, 0x480F, [0x88, 0xB7, 0xB4, 0x35, 0xDD, 0x28, 0x1D, 0x45]);
interface IWSDiscoveryProvider : IUnknown
{
    HRESULT SetAddressFamily(uint dwAddressFamily);
    HRESULT Attach(IWSDiscoveryProviderNotify pSink);
    HRESULT Detach();
    HRESULT SearchById(const(wchar)* pszId, const(wchar)* pszTag);
    HRESULT SearchByAddress(const(wchar)* pszAddress, const(wchar)* pszTag);
    HRESULT SearchByType(const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, const(wchar)* pszMatchBy, const(wchar)* pszTag);
    HRESULT GetXMLContext(IWSDXMLContext* ppContext);
}

const GUID IID_IWSDiscoveryProviderNotify = {0x73EE3CED, 0xB6E6, 0x4329, [0xA5, 0x46, 0x3E, 0x8A, 0xD4, 0x65, 0x63, 0xD2]};
@GUID(0x73EE3CED, 0xB6E6, 0x4329, [0xA5, 0x46, 0x3E, 0x8A, 0xD4, 0x65, 0x63, 0xD2]);
interface IWSDiscoveryProviderNotify : IUnknown
{
    HRESULT Add(IWSDiscoveredService pService);
    HRESULT Remove(IWSDiscoveredService pService);
    HRESULT SearchFailed(HRESULT hr, const(wchar)* pszTag);
    HRESULT SearchComplete(const(wchar)* pszTag);
}

const GUID IID_IWSDiscoveredService = {0x4BAD8A3B, 0xB374, 0x4420, [0x96, 0x32, 0xAA, 0xC9, 0x45, 0xB3, 0x74, 0xAA]};
@GUID(0x4BAD8A3B, 0xB374, 0x4420, [0x96, 0x32, 0xAA, 0xC9, 0x45, 0xB3, 0x74, 0xAA]);
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
    HRESULT GetLocalInterfaceGUID(Guid* pGuid);
    HRESULT GetInstanceId(ulong* pullInstanceId);
}

const GUID IID_IWSDiscoveryPublisher = {0xAE01E1A8, 0x3FF9, 0x4148, [0x81, 0x16, 0x05, 0x7C, 0xC6, 0x16, 0xFE, 0x13]};
@GUID(0xAE01E1A8, 0x3FF9, 0x4148, [0x81, 0x16, 0x05, 0x7C, 0xC6, 0x16, 0xFE, 0x13]);
interface IWSDiscoveryPublisher : IUnknown
{
    HRESULT SetAddressFamily(uint dwAddressFamily);
    HRESULT RegisterNotificationSink(IWSDiscoveryPublisherNotify pSink);
    HRESULT UnRegisterNotificationSink(IWSDiscoveryPublisherNotify pSink);
    HRESULT Publish(const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList);
    HRESULT UnPublish(const(wchar)* pszId, ulong ullInstanceId, ulong ullMessageNumber, const(wchar)* pszSessionId, const(WSDXML_ELEMENT)* pAny);
    HRESULT MatchProbe(const(WSD_SOAP_MESSAGE)* pProbeMessage, IWSDMessageParameters pMessageParameters, const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList);
    HRESULT MatchResolve(const(WSD_SOAP_MESSAGE)* pResolveMessage, IWSDMessageParameters pMessageParameters, const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList);
    HRESULT PublishEx(const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList, const(WSDXML_ELEMENT)* pHeaderAny, const(WSDXML_ELEMENT)* pReferenceParameterAny, const(WSDXML_ELEMENT)* pPolicyAny, const(WSDXML_ELEMENT)* pEndpointReferenceAny, const(WSDXML_ELEMENT)* pAny);
    HRESULT MatchProbeEx(const(WSD_SOAP_MESSAGE)* pProbeMessage, IWSDMessageParameters pMessageParameters, const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList, const(WSDXML_ELEMENT)* pHeaderAny, const(WSDXML_ELEMENT)* pReferenceParameterAny, const(WSDXML_ELEMENT)* pPolicyAny, const(WSDXML_ELEMENT)* pEndpointReferenceAny, const(WSDXML_ELEMENT)* pAny);
    HRESULT MatchResolveEx(const(WSD_SOAP_MESSAGE)* pResolveMessage, IWSDMessageParameters pMessageParameters, const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList, const(WSDXML_ELEMENT)* pHeaderAny, const(WSDXML_ELEMENT)* pReferenceParameterAny, const(WSDXML_ELEMENT)* pPolicyAny, const(WSDXML_ELEMENT)* pEndpointReferenceAny, const(WSDXML_ELEMENT)* pAny);
    HRESULT RegisterScopeMatchingRule(IWSDScopeMatchingRule pScopeMatchingRule);
    HRESULT UnRegisterScopeMatchingRule(IWSDScopeMatchingRule pScopeMatchingRule);
    HRESULT GetXMLContext(IWSDXMLContext* ppContext);
}

const GUID IID_IWSDiscoveryPublisherNotify = {0xE67651B0, 0x337A, 0x4B3C, [0x97, 0x58, 0x73, 0x33, 0x88, 0x56, 0x82, 0x51]};
@GUID(0xE67651B0, 0x337A, 0x4B3C, [0x97, 0x58, 0x73, 0x33, 0x88, 0x56, 0x82, 0x51]);
interface IWSDiscoveryPublisherNotify : IUnknown
{
    HRESULT ProbeHandler(const(WSD_SOAP_MESSAGE)* pSoap, IWSDMessageParameters pMessageParameters);
    HRESULT ResolveHandler(const(WSD_SOAP_MESSAGE)* pSoap, IWSDMessageParameters pMessageParameters);
}

const GUID IID_IWSDScopeMatchingRule = {0xFCAFE424, 0xFEF5, 0x481A, [0xBD, 0x9F, 0x33, 0xCE, 0x05, 0x74, 0x25, 0x6F]};
@GUID(0xFCAFE424, 0xFEF5, 0x481A, [0xBD, 0x9F, 0x33, 0xCE, 0x05, 0x74, 0x25, 0x6F]);
interface IWSDScopeMatchingRule : IUnknown
{
    HRESULT GetScopeRule(ushort** ppszScopeMatchingRule);
    HRESULT MatchScopes(const(wchar)* pszScope1, const(wchar)* pszScope2, int* pfMatch);
}

const GUID IID_IWSDAttachment = {0x5D55A616, 0x9DF8, 0x4B09, [0xB1, 0x56, 0x9B, 0xA3, 0x51, 0xA4, 0x8B, 0x76]};
@GUID(0x5D55A616, 0x9DF8, 0x4B09, [0xB1, 0x56, 0x9B, 0xA3, 0x51, 0xA4, 0x8B, 0x76]);
interface IWSDAttachment : IUnknown
{
}

const GUID IID_IWSDOutboundAttachment = {0xAA302F8D, 0x5A22, 0x4BA5, [0xB3, 0x92, 0xAA, 0x84, 0x86, 0xF4, 0xC1, 0x5D]};
@GUID(0xAA302F8D, 0x5A22, 0x4BA5, [0xB3, 0x92, 0xAA, 0x84, 0x86, 0xF4, 0xC1, 0x5D]);
interface IWSDOutboundAttachment : IWSDAttachment
{
    HRESULT Write(char* pBuffer, uint dwBytesToWrite, uint* pdwNumberOfBytesWritten);
    HRESULT Close();
    HRESULT Abort();
}

const GUID IID_IWSDInboundAttachment = {0x5BD6CA65, 0x233C, 0x4FB8, [0x9F, 0x7A, 0x26, 0x41, 0x61, 0x96, 0x55, 0xC9]};
@GUID(0x5BD6CA65, 0x233C, 0x4FB8, [0x9F, 0x7A, 0x26, 0x41, 0x61, 0x96, 0x55, 0xC9]);
interface IWSDInboundAttachment : IWSDAttachment
{
    HRESULT Read(char* pBuffer, uint dwBytesToRead, uint* pdwNumberOfBytesRead);
    HRESULT Close();
}

@DllImport("wsdapi.dll")
HRESULT WSDXMLGetNameFromBuiltinNamespace(const(wchar)* pszNamespace, const(wchar)* pszName, WSDXML_NAME** ppName);

@DllImport("wsdapi.dll")
HRESULT WSDXMLCreateContext(IWSDXMLContext* ppContext);

@DllImport("wsdapi.dll")
HRESULT WSDCreateUdpMessageParameters(IWSDUdpMessageParameters* ppTxParams);

@DllImport("wsdapi.dll")
HRESULT WSDCreateUdpAddress(IWSDUdpAddress* ppAddress);

@DllImport("wsdapi.dll")
HRESULT WSDCreateHttpMessageParameters(IWSDHttpMessageParameters* ppTxParams);

@DllImport("wsdapi.dll")
HRESULT WSDCreateHttpAddress(IWSDHttpAddress* ppAddress);

@DllImport("wsdapi.dll")
HRESULT WSDSetConfigurationOption(uint dwOption, char* pVoid, uint cbInBuffer);

@DllImport("wsdapi.dll")
HRESULT WSDGetConfigurationOption(uint dwOption, char* pVoid, uint cbOutBuffer);

@DllImport("wsdapi.dll")
void* WSDAllocateLinkedMemory(void* pParent, uint cbSize);

@DllImport("wsdapi.dll")
void WSDFreeLinkedMemory(void* pVoid);

@DllImport("wsdapi.dll")
void WSDAttachLinkedMemory(void* pParent, void* pChild);

@DllImport("wsdapi.dll")
void WSDDetachLinkedMemory(void* pVoid);

@DllImport("wsdapi.dll")
HRESULT WSDXMLBuildAnyForSingleElement(WSDXML_NAME* pElementName, const(wchar)* pszText, WSDXML_ELEMENT** ppAny);

@DllImport("wsdapi.dll")
HRESULT WSDXMLGetValueFromAny(const(wchar)* pszNamespace, const(wchar)* pszName, WSDXML_ELEMENT* pAny, ushort** ppszValue);

@DllImport("wsdapi.dll")
HRESULT WSDXMLAddSibling(WSDXML_ELEMENT* pFirst, WSDXML_ELEMENT* pSecond);

@DllImport("wsdapi.dll")
HRESULT WSDXMLAddChild(WSDXML_ELEMENT* pParent, WSDXML_ELEMENT* pChild);

@DllImport("wsdapi.dll")
HRESULT WSDXMLCleanupElement(WSDXML_ELEMENT* pAny);

@DllImport("wsdapi.dll")
HRESULT WSDGenerateFault(const(wchar)* pszCode, const(wchar)* pszSubCode, const(wchar)* pszReason, const(wchar)* pszDetail, IWSDXMLContext pContext, WSD_SOAP_FAULT** ppFault);

@DllImport("wsdapi.dll")
HRESULT WSDGenerateFaultEx(WSDXML_NAME* pCode, WSDXML_NAME* pSubCode, WSD_LOCALIZED_STRING_LIST* pReasons, const(wchar)* pszDetail, WSD_SOAP_FAULT** ppFault);

@DllImport("wsdapi.dll")
HRESULT WSDUriEncode(const(wchar)* source, uint cchSource, char* destOut, uint* cchDestOut);

@DllImport("wsdapi.dll")
HRESULT WSDUriDecode(const(wchar)* source, uint cchSource, char* destOut, uint* cchDestOut);

@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceHost(const(wchar)* pszLocalId, IWSDXMLContext pContext, IWSDDeviceHost* ppDeviceHost);

@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceHostAdvanced(const(wchar)* pszLocalId, IWSDXMLContext pContext, char* ppHostAddresses, uint dwHostAddressCount, IWSDDeviceHost* ppDeviceHost);

@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceHost2(const(wchar)* pszLocalId, IWSDXMLContext pContext, char* pConfigParams, uint dwConfigParamCount, IWSDDeviceHost* ppDeviceHost);

@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceProxy(const(wchar)* pszDeviceId, const(wchar)* pszLocalId, IWSDXMLContext pContext, IWSDDeviceProxy* ppDeviceProxy);

@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceProxyAdvanced(const(wchar)* pszDeviceId, IWSDAddress pDeviceAddress, const(wchar)* pszLocalId, IWSDXMLContext pContext, IWSDDeviceProxy* ppDeviceProxy);

@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceProxy2(const(wchar)* pszDeviceId, const(wchar)* pszLocalId, IWSDXMLContext pContext, char* pConfigParams, uint dwConfigParamCount, IWSDDeviceProxy* ppDeviceProxy);

@DllImport("wsdapi.dll")
HRESULT WSDCreateDiscoveryProvider(IWSDXMLContext pContext, IWSDiscoveryProvider* ppProvider);

@DllImport("wsdapi.dll")
HRESULT WSDCreateDiscoveryProvider2(IWSDXMLContext pContext, char* pConfigParams, uint dwConfigParamCount, IWSDiscoveryProvider* ppProvider);

@DllImport("wsdapi.dll")
HRESULT WSDCreateDiscoveryPublisher(IWSDXMLContext pContext, IWSDiscoveryPublisher* ppPublisher);

@DllImport("wsdapi.dll")
HRESULT WSDCreateDiscoveryPublisher2(IWSDXMLContext pContext, char* pConfigParams, uint dwConfigParamCount, IWSDiscoveryPublisher* ppPublisher);

@DllImport("wsdapi.dll")
HRESULT WSDCreateOutboundAttachment(IWSDOutboundAttachment* ppAttachment);

