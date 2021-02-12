module windows.networklistmanager;

public import system;
public import windows.automation;
public import windows.com;
public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

const GUID CLSID_NetworkListManager = {0xDCB00C01, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00C01, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
struct NetworkListManager;

enum NLM_CONNECTION_COST
{
    NLM_CONNECTION_COST_UNKNOWN = 0,
    NLM_CONNECTION_COST_UNRESTRICTED = 1,
    NLM_CONNECTION_COST_FIXED = 2,
    NLM_CONNECTION_COST_VARIABLE = 4,
    NLM_CONNECTION_COST_OVERDATALIMIT = 65536,
    NLM_CONNECTION_COST_CONGESTED = 131072,
    NLM_CONNECTION_COST_ROAMING = 262144,
    NLM_CONNECTION_COST_APPROACHINGDATALIMIT = 524288,
}

struct NLM_USAGE_DATA
{
    uint UsageInMegabytes;
    FILETIME LastSyncTime;
}

struct NLM_DATAPLAN_STATUS
{
    Guid InterfaceGuid;
    NLM_USAGE_DATA UsageData;
    uint DataLimitInMegabytes;
    uint InboundBandwidthInKbps;
    uint OutboundBandwidthInKbps;
    FILETIME NextBillingCycle;
    uint MaxTransferSizeInMegabytes;
    uint Reserved;
}

struct NLM_SOCKADDR
{
    ubyte data;
}

enum NLM_NETWORK_CLASS
{
    NLM_NETWORK_IDENTIFYING = 1,
    NLM_NETWORK_IDENTIFIED = 2,
    NLM_NETWORK_UNIDENTIFIED = 3,
}

struct NLM_SIMULATED_PROFILE_INFO
{
    ushort ProfileName;
    NLM_CONNECTION_COST cost;
    uint UsageInMegabytes;
    uint DataLimitInMegabytes;
}

enum NLM_INTERNET_CONNECTIVITY
{
    NLM_INTERNET_CONNECTIVITY_WEBHIJACK = 1,
    NLM_INTERNET_CONNECTIVITY_PROXIED = 2,
    NLM_INTERNET_CONNECTIVITY_CORPORATE = 4,
}

enum NLM_CONNECTIVITY
{
    NLM_CONNECTIVITY_DISCONNECTED = 0,
    NLM_CONNECTIVITY_IPV4_NOTRAFFIC = 1,
    NLM_CONNECTIVITY_IPV6_NOTRAFFIC = 2,
    NLM_CONNECTIVITY_IPV4_SUBNET = 16,
    NLM_CONNECTIVITY_IPV4_LOCALNETWORK = 32,
    NLM_CONNECTIVITY_IPV4_INTERNET = 64,
    NLM_CONNECTIVITY_IPV6_SUBNET = 256,
    NLM_CONNECTIVITY_IPV6_LOCALNETWORK = 512,
    NLM_CONNECTIVITY_IPV6_INTERNET = 1024,
}

enum NLM_DOMAIN_TYPE
{
    NLM_DOMAIN_TYPE_NON_DOMAIN_NETWORK = 0,
    NLM_DOMAIN_TYPE_DOMAIN_NETWORK = 1,
    NLM_DOMAIN_TYPE_DOMAIN_AUTHENTICATED = 2,
}

enum NLM_ENUM_NETWORK
{
    NLM_ENUM_NETWORK_CONNECTED = 1,
    NLM_ENUM_NETWORK_DISCONNECTED = 2,
    NLM_ENUM_NETWORK_ALL = 3,
}

const GUID IID_INetworkListManager = {0xDCB00000, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00000, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface INetworkListManager : IDispatch
{
    HRESULT GetNetworks(NLM_ENUM_NETWORK Flags, IEnumNetworks* ppEnumNetwork);
    HRESULT GetNetwork(Guid gdNetworkId, INetwork* ppNetwork);
    HRESULT GetNetworkConnections(IEnumNetworkConnections* ppEnum);
    HRESULT GetNetworkConnection(Guid gdNetworkConnectionId, INetworkConnection* ppNetworkConnection);
    HRESULT get_IsConnectedToInternet(short* pbIsConnected);
    HRESULT get_IsConnected(short* pbIsConnected);
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    HRESULT SetSimulatedProfileInfo(NLM_SIMULATED_PROFILE_INFO* pSimulatedInfo);
    HRESULT ClearSimulatedProfileInfo();
}

const GUID IID_INetworkListManagerEvents = {0xDCB00001, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00001, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface INetworkListManagerEvents : IUnknown
{
    HRESULT ConnectivityChanged(NLM_CONNECTIVITY newConnectivity);
}

enum NLM_NETWORK_CATEGORY
{
    NLM_NETWORK_CATEGORY_PUBLIC = 0,
    NLM_NETWORK_CATEGORY_PRIVATE = 1,
    NLM_NETWORK_CATEGORY_DOMAIN_AUTHENTICATED = 2,
}

const GUID IID_INetwork = {0xDCB00002, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00002, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface INetwork : IDispatch
{
    HRESULT GetName(BSTR* pszNetworkName);
    HRESULT SetName(BSTR szNetworkNewName);
    HRESULT GetDescription(BSTR* pszDescription);
    HRESULT SetDescription(BSTR szDescription);
    HRESULT GetNetworkId(Guid* pgdGuidNetworkId);
    HRESULT GetDomainType(NLM_DOMAIN_TYPE* pNetworkType);
    HRESULT GetNetworkConnections(IEnumNetworkConnections* ppEnumNetworkConnection);
    HRESULT GetTimeCreatedAndConnected(uint* pdwLowDateTimeCreated, uint* pdwHighDateTimeCreated, uint* pdwLowDateTimeConnected, uint* pdwHighDateTimeConnected);
    HRESULT get_IsConnectedToInternet(short* pbIsConnected);
    HRESULT get_IsConnected(short* pbIsConnected);
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    HRESULT GetCategory(NLM_NETWORK_CATEGORY* pCategory);
    HRESULT SetCategory(NLM_NETWORK_CATEGORY NewCategory);
}

const GUID IID_IEnumNetworks = {0xDCB00003, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00003, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface IEnumNetworks : IDispatch
{
    HRESULT get__NewEnum(IEnumVARIANT* ppEnumVar);
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetworks* ppEnumNetwork);
}

enum NLM_NETWORK_PROPERTY_CHANGE
{
    NLM_NETWORK_PROPERTY_CHANGE_CONNECTION = 1,
    NLM_NETWORK_PROPERTY_CHANGE_DESCRIPTION = 2,
    NLM_NETWORK_PROPERTY_CHANGE_NAME = 4,
    NLM_NETWORK_PROPERTY_CHANGE_ICON = 8,
    NLM_NETWORK_PROPERTY_CHANGE_CATEGORY_VALUE = 16,
}

const GUID IID_INetworkEvents = {0xDCB00004, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00004, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface INetworkEvents : IUnknown
{
    HRESULT NetworkAdded(Guid networkId);
    HRESULT NetworkDeleted(Guid networkId);
    HRESULT NetworkConnectivityChanged(Guid networkId, NLM_CONNECTIVITY newConnectivity);
    HRESULT NetworkPropertyChanged(Guid networkId, NLM_NETWORK_PROPERTY_CHANGE flags);
}

const GUID IID_INetworkConnection = {0xDCB00005, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00005, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface INetworkConnection : IDispatch
{
    HRESULT GetNetwork(INetwork* ppNetwork);
    HRESULT get_IsConnectedToInternet(short* pbIsConnected);
    HRESULT get_IsConnected(short* pbIsConnected);
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    HRESULT GetConnectionId(Guid* pgdConnectionId);
    HRESULT GetAdapterId(Guid* pgdAdapterId);
    HRESULT GetDomainType(NLM_DOMAIN_TYPE* pDomainType);
}

const GUID IID_IEnumNetworkConnections = {0xDCB00006, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00006, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface IEnumNetworkConnections : IDispatch
{
    HRESULT get__NewEnum(IEnumVARIANT* ppEnumVar);
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetworkConnections* ppEnumNetwork);
}

enum NLM_CONNECTION_PROPERTY_CHANGE
{
    NLM_CONNECTION_PROPERTY_CHANGE_AUTHENTICATION = 1,
}

const GUID IID_INetworkConnectionEvents = {0xDCB00007, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00007, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface INetworkConnectionEvents : IUnknown
{
    HRESULT NetworkConnectionConnectivityChanged(Guid connectionId, NLM_CONNECTIVITY newConnectivity);
    HRESULT NetworkConnectionPropertyChanged(Guid connectionId, NLM_CONNECTION_PROPERTY_CHANGE flags);
}

const GUID IID_INetworkCostManager = {0xDCB00008, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00008, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface INetworkCostManager : IUnknown
{
    HRESULT GetCost(uint* pCost, NLM_SOCKADDR* pDestIPAddr);
    HRESULT GetDataPlanStatus(NLM_DATAPLAN_STATUS* pDataPlanStatus, NLM_SOCKADDR* pDestIPAddr);
    HRESULT SetDestinationAddresses(uint length, char* pDestIPAddrList, short bAppend);
}

const GUID IID_INetworkCostManagerEvents = {0xDCB00009, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB00009, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface INetworkCostManagerEvents : IUnknown
{
    HRESULT CostChanged(uint newCost, NLM_SOCKADDR* pDestAddr);
    HRESULT DataPlanStatusChanged(NLM_SOCKADDR* pDestAddr);
}

const GUID IID_INetworkConnectionCost = {0xDCB0000A, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB0000A, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface INetworkConnectionCost : IUnknown
{
    HRESULT GetCost(uint* pCost);
    HRESULT GetDataPlanStatus(NLM_DATAPLAN_STATUS* pDataPlanStatus);
}

const GUID IID_INetworkConnectionCostEvents = {0xDCB0000B, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]};
@GUID(0xDCB0000B, 0x570F, 0x4A9B, [0x8D, 0x69, 0x19, 0x9F, 0xDB, 0xA5, 0x72, 0x3B]);
interface INetworkConnectionCostEvents : IUnknown
{
    HRESULT ConnectionCostChanged(Guid connectionId, uint newCost);
    HRESULT ConnectionDataPlanStatusChanged(Guid connectionId);
}

alias ONDEMAND_NOTIFICATION_CALLBACK = extern(Windows) void function(void* param0);
struct NET_INTERFACE_CONTEXT
{
    uint InterfaceIndex;
    const(wchar)* ConfigurationName;
}

struct NET_INTERFACE_CONTEXT_TABLE
{
    HANDLE InterfaceContextHandle;
    uint NumberOfEntries;
    NET_INTERFACE_CONTEXT* InterfaceContextArray;
}

@DllImport("OnDemandConnRouteHelper.dll")
HRESULT OnDemandGetRoutingHint(const(wchar)* destinationHostName, uint* interfaceIndex);

@DllImport("OnDemandConnRouteHelper.dll")
HRESULT OnDemandRegisterNotification(ONDEMAND_NOTIFICATION_CALLBACK callback, void* callbackContext, HANDLE* registrationHandle);

@DllImport("OnDemandConnRouteHelper.dll")
HRESULT OnDemandUnRegisterNotification(HANDLE registrationHandle);

@DllImport("OnDemandConnRouteHelper.dll")
HRESULT GetInterfaceContextTableForHostName(const(wchar)* HostName, const(wchar)* ProxyName, uint Flags, char* ConnectionProfileFilterRawData, uint ConnectionProfileFilterRawDataSize, NET_INTERFACE_CONTEXT_TABLE** InterfaceContextTable);

@DllImport("OnDemandConnRouteHelper.dll")
void FreeInterfaceContextTable(NET_INTERFACE_CONTEXT_TABLE* InterfaceContextTable);

