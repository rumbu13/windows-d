module windows.networklistmanager;

public import windows.core;
public import windows.automation : BSTR, IDispatch, IEnumVARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : HANDLE;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    NLM_CONNECTION_COST_UNKNOWN              = 0x00000000,
    NLM_CONNECTION_COST_UNRESTRICTED         = 0x00000001,
    NLM_CONNECTION_COST_FIXED                = 0x00000002,
    NLM_CONNECTION_COST_VARIABLE             = 0x00000004,
    NLM_CONNECTION_COST_OVERDATALIMIT        = 0x00010000,
    NLM_CONNECTION_COST_CONGESTED            = 0x00020000,
    NLM_CONNECTION_COST_ROAMING              = 0x00040000,
    NLM_CONNECTION_COST_APPROACHINGDATALIMIT = 0x00080000,
}
alias NLM_CONNECTION_COST = int;

enum : int
{
    NLM_NETWORK_IDENTIFYING  = 0x00000001,
    NLM_NETWORK_IDENTIFIED   = 0x00000002,
    NLM_NETWORK_UNIDENTIFIED = 0x00000003,
}
alias NLM_NETWORK_CLASS = int;

enum : int
{
    NLM_INTERNET_CONNECTIVITY_WEBHIJACK = 0x00000001,
    NLM_INTERNET_CONNECTIVITY_PROXIED   = 0x00000002,
    NLM_INTERNET_CONNECTIVITY_CORPORATE = 0x00000004,
}
alias NLM_INTERNET_CONNECTIVITY = int;

enum : int
{
    NLM_CONNECTIVITY_DISCONNECTED      = 0x00000000,
    NLM_CONNECTIVITY_IPV4_NOTRAFFIC    = 0x00000001,
    NLM_CONNECTIVITY_IPV6_NOTRAFFIC    = 0x00000002,
    NLM_CONNECTIVITY_IPV4_SUBNET       = 0x00000010,
    NLM_CONNECTIVITY_IPV4_LOCALNETWORK = 0x00000020,
    NLM_CONNECTIVITY_IPV4_INTERNET     = 0x00000040,
    NLM_CONNECTIVITY_IPV6_SUBNET       = 0x00000100,
    NLM_CONNECTIVITY_IPV6_LOCALNETWORK = 0x00000200,
    NLM_CONNECTIVITY_IPV6_INTERNET     = 0x00000400,
}
alias NLM_CONNECTIVITY = int;

enum : int
{
    NLM_DOMAIN_TYPE_NON_DOMAIN_NETWORK   = 0x00000000,
    NLM_DOMAIN_TYPE_DOMAIN_NETWORK       = 0x00000001,
    NLM_DOMAIN_TYPE_DOMAIN_AUTHENTICATED = 0x00000002,
}
alias NLM_DOMAIN_TYPE = int;

enum : int
{
    NLM_ENUM_NETWORK_CONNECTED    = 0x00000001,
    NLM_ENUM_NETWORK_DISCONNECTED = 0x00000002,
    NLM_ENUM_NETWORK_ALL          = 0x00000003,
}
alias NLM_ENUM_NETWORK = int;

enum : int
{
    NLM_NETWORK_CATEGORY_PUBLIC               = 0x00000000,
    NLM_NETWORK_CATEGORY_PRIVATE              = 0x00000001,
    NLM_NETWORK_CATEGORY_DOMAIN_AUTHENTICATED = 0x00000002,
}
alias NLM_NETWORK_CATEGORY = int;

enum : int
{
    NLM_NETWORK_PROPERTY_CHANGE_CONNECTION     = 0x00000001,
    NLM_NETWORK_PROPERTY_CHANGE_DESCRIPTION    = 0x00000002,
    NLM_NETWORK_PROPERTY_CHANGE_NAME           = 0x00000004,
    NLM_NETWORK_PROPERTY_CHANGE_ICON           = 0x00000008,
    NLM_NETWORK_PROPERTY_CHANGE_CATEGORY_VALUE = 0x00000010,
}
alias NLM_NETWORK_PROPERTY_CHANGE = int;

enum : int
{
    NLM_CONNECTION_PROPERTY_CHANGE_AUTHENTICATION = 0x00000001,
}
alias NLM_CONNECTION_PROPERTY_CHANGE = int;

// Callbacks

alias ONDEMAND_NOTIFICATION_CALLBACK = void function(void* param0);

// Structs


struct NLM_USAGE_DATA
{
    uint     UsageInMegabytes;
    FILETIME LastSyncTime;
}

struct NLM_DATAPLAN_STATUS
{
    GUID           InterfaceGuid;
    NLM_USAGE_DATA UsageData;
    uint           DataLimitInMegabytes;
    uint           InboundBandwidthInKbps;
    uint           OutboundBandwidthInKbps;
    FILETIME       NextBillingCycle;
    uint           MaxTransferSizeInMegabytes;
    uint           Reserved;
}

struct NLM_SOCKADDR
{
    ubyte[128] data;
}

struct NLM_SIMULATED_PROFILE_INFO
{
    ushort[256]         ProfileName;
    NLM_CONNECTION_COST cost;
    uint                UsageInMegabytes;
    uint                DataLimitInMegabytes;
}

struct NET_INTERFACE_CONTEXT
{
    uint          InterfaceIndex;
    const(wchar)* ConfigurationName;
}

struct NET_INTERFACE_CONTEXT_TABLE
{
    HANDLE InterfaceContextHandle;
    uint   NumberOfEntries;
    NET_INTERFACE_CONTEXT* InterfaceContextArray;
}

// Functions

@DllImport("OnDemandConnRouteHelper")
HRESULT OnDemandGetRoutingHint(const(wchar)* destinationHostName, uint* interfaceIndex);

@DllImport("OnDemandConnRouteHelper")
HRESULT OnDemandRegisterNotification(ONDEMAND_NOTIFICATION_CALLBACK callback, void* callbackContext, 
                                     HANDLE* registrationHandle);

@DllImport("OnDemandConnRouteHelper")
HRESULT OnDemandUnRegisterNotification(HANDLE registrationHandle);

@DllImport("OnDemandConnRouteHelper")
HRESULT GetInterfaceContextTableForHostName(const(wchar)* HostName, const(wchar)* ProxyName, uint Flags, 
                                            char* ConnectionProfileFilterRawData, 
                                            uint ConnectionProfileFilterRawDataSize, 
                                            NET_INTERFACE_CONTEXT_TABLE** InterfaceContextTable);

@DllImport("OnDemandConnRouteHelper")
void FreeInterfaceContextTable(NET_INTERFACE_CONTEXT_TABLE* InterfaceContextTable);


// Interfaces

@GUID("DCB00C01-570F-4A9B-8D69-199FDBA5723B")
struct NetworkListManager;

@GUID("DCB00000-570F-4A9B-8D69-199FDBA5723B")
interface INetworkListManager : IDispatch
{
    HRESULT GetNetworks(NLM_ENUM_NETWORK Flags, IEnumNetworks* ppEnumNetwork);
    HRESULT GetNetwork(GUID gdNetworkId, INetwork* ppNetwork);
    HRESULT GetNetworkConnections(IEnumNetworkConnections* ppEnum);
    HRESULT GetNetworkConnection(GUID gdNetworkConnectionId, INetworkConnection* ppNetworkConnection);
    HRESULT get_IsConnectedToInternet(short* pbIsConnected);
    HRESULT get_IsConnected(short* pbIsConnected);
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    HRESULT SetSimulatedProfileInfo(NLM_SIMULATED_PROFILE_INFO* pSimulatedInfo);
    HRESULT ClearSimulatedProfileInfo();
}

@GUID("DCB00001-570F-4A9B-8D69-199FDBA5723B")
interface INetworkListManagerEvents : IUnknown
{
    HRESULT ConnectivityChanged(NLM_CONNECTIVITY newConnectivity);
}

@GUID("DCB00002-570F-4A9B-8D69-199FDBA5723B")
interface INetwork : IDispatch
{
    HRESULT GetName(BSTR* pszNetworkName);
    HRESULT SetName(BSTR szNetworkNewName);
    HRESULT GetDescription(BSTR* pszDescription);
    HRESULT SetDescription(BSTR szDescription);
    HRESULT GetNetworkId(GUID* pgdGuidNetworkId);
    HRESULT GetDomainType(NLM_DOMAIN_TYPE* pNetworkType);
    HRESULT GetNetworkConnections(IEnumNetworkConnections* ppEnumNetworkConnection);
    HRESULT GetTimeCreatedAndConnected(uint* pdwLowDateTimeCreated, uint* pdwHighDateTimeCreated, 
                                       uint* pdwLowDateTimeConnected, uint* pdwHighDateTimeConnected);
    HRESULT get_IsConnectedToInternet(short* pbIsConnected);
    HRESULT get_IsConnected(short* pbIsConnected);
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    HRESULT GetCategory(NLM_NETWORK_CATEGORY* pCategory);
    HRESULT SetCategory(NLM_NETWORK_CATEGORY NewCategory);
}

@GUID("DCB00003-570F-4A9B-8D69-199FDBA5723B")
interface IEnumNetworks : IDispatch
{
    HRESULT get__NewEnum(IEnumVARIANT* ppEnumVar);
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetworks* ppEnumNetwork);
}

@GUID("DCB00004-570F-4A9B-8D69-199FDBA5723B")
interface INetworkEvents : IUnknown
{
    HRESULT NetworkAdded(GUID networkId);
    HRESULT NetworkDeleted(GUID networkId);
    HRESULT NetworkConnectivityChanged(GUID networkId, NLM_CONNECTIVITY newConnectivity);
    HRESULT NetworkPropertyChanged(GUID networkId, NLM_NETWORK_PROPERTY_CHANGE flags);
}

@GUID("DCB00005-570F-4A9B-8D69-199FDBA5723B")
interface INetworkConnection : IDispatch
{
    HRESULT GetNetwork(INetwork* ppNetwork);
    HRESULT get_IsConnectedToInternet(short* pbIsConnected);
    HRESULT get_IsConnected(short* pbIsConnected);
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    HRESULT GetConnectionId(GUID* pgdConnectionId);
    HRESULT GetAdapterId(GUID* pgdAdapterId);
    HRESULT GetDomainType(NLM_DOMAIN_TYPE* pDomainType);
}

@GUID("DCB00006-570F-4A9B-8D69-199FDBA5723B")
interface IEnumNetworkConnections : IDispatch
{
    HRESULT get__NewEnum(IEnumVARIANT* ppEnumVar);
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetworkConnections* ppEnumNetwork);
}

@GUID("DCB00007-570F-4A9B-8D69-199FDBA5723B")
interface INetworkConnectionEvents : IUnknown
{
    HRESULT NetworkConnectionConnectivityChanged(GUID connectionId, NLM_CONNECTIVITY newConnectivity);
    HRESULT NetworkConnectionPropertyChanged(GUID connectionId, NLM_CONNECTION_PROPERTY_CHANGE flags);
}

@GUID("DCB00008-570F-4A9B-8D69-199FDBA5723B")
interface INetworkCostManager : IUnknown
{
    HRESULT GetCost(uint* pCost, NLM_SOCKADDR* pDestIPAddr);
    HRESULT GetDataPlanStatus(NLM_DATAPLAN_STATUS* pDataPlanStatus, NLM_SOCKADDR* pDestIPAddr);
    HRESULT SetDestinationAddresses(uint length, char* pDestIPAddrList, short bAppend);
}

@GUID("DCB00009-570F-4A9B-8D69-199FDBA5723B")
interface INetworkCostManagerEvents : IUnknown
{
    HRESULT CostChanged(uint newCost, NLM_SOCKADDR* pDestAddr);
    HRESULT DataPlanStatusChanged(NLM_SOCKADDR* pDestAddr);
}

@GUID("DCB0000A-570F-4A9B-8D69-199FDBA5723B")
interface INetworkConnectionCost : IUnknown
{
    HRESULT GetCost(uint* pCost);
    HRESULT GetDataPlanStatus(NLM_DATAPLAN_STATUS* pDataPlanStatus);
}

@GUID("DCB0000B-570F-4A9B-8D69-199FDBA5723B")
interface INetworkConnectionCostEvents : IUnknown
{
    HRESULT ConnectionCostChanged(GUID connectionId, uint newCost);
    HRESULT ConnectionDataPlanStatusChanged(GUID connectionId);
}


// GUIDs

const GUID CLSID_NetworkListManager = GUIDOF!NetworkListManager;

const GUID IID_IEnumNetworkConnections      = GUIDOF!IEnumNetworkConnections;
const GUID IID_IEnumNetworks                = GUIDOF!IEnumNetworks;
const GUID IID_INetwork                     = GUIDOF!INetwork;
const GUID IID_INetworkConnection           = GUIDOF!INetworkConnection;
const GUID IID_INetworkConnectionCost       = GUIDOF!INetworkConnectionCost;
const GUID IID_INetworkConnectionCostEvents = GUIDOF!INetworkConnectionCostEvents;
const GUID IID_INetworkConnectionEvents     = GUIDOF!INetworkConnectionEvents;
const GUID IID_INetworkCostManager          = GUIDOF!INetworkCostManager;
const GUID IID_INetworkCostManagerEvents    = GUIDOF!INetworkCostManagerEvents;
const GUID IID_INetworkEvents               = GUIDOF!INetworkEvents;
const GUID IID_INetworkListManager          = GUIDOF!INetworkListManager;
const GUID IID_INetworkListManagerEvents    = GUIDOF!INetworkListManagerEvents;
