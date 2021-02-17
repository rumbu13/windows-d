// Written in the D programming language.

module windows.networklistmanager;

public import windows.core;
public import windows.automation : BSTR, IDispatch, IEnumVARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : HANDLE;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


///The <b>NLM_CONNECTION_COST</b> enumeration specifies a set of cost levels and cost flags supported in Windows 8 Cost
///APIs.
alias NLM_CONNECTION_COST = int;
enum : int
{
    ///The cost is unknown.
    NLM_CONNECTION_COST_UNKNOWN              = 0x00000000,
    ///The connection is unlimited and is considered to be unrestricted of usage charges and capacity constraints.
    NLM_CONNECTION_COST_UNRESTRICTED         = 0x00000001,
    ///The use of this connection is unrestricted up to a specific data transfer limit.
    NLM_CONNECTION_COST_FIXED                = 0x00000002,
    ///This connection is regulated on a per byte basis.
    NLM_CONNECTION_COST_VARIABLE             = 0x00000004,
    ///The connection is currently in an OverDataLimit state as it has exceeded the carrier specified data transfer
    ///limit.
    NLM_CONNECTION_COST_OVERDATALIMIT        = 0x00010000,
    ///The network is experiencing high traffic load and is congested.
    NLM_CONNECTION_COST_CONGESTED            = 0x00020000,
    ///The connection is roaming outside the network and affiliates of the home provider.
    NLM_CONNECTION_COST_ROAMING              = 0x00040000,
    ///The connection is approaching the data limit specified by the carrier.
    NLM_CONNECTION_COST_APPROACHINGDATALIMIT = 0x00080000,
}

///The <b>NLM_NETWORK_CLASS</b> enumeration defines a set of flags that specify if a network has been identified.
alias NLM_NETWORK_CLASS = int;
enum : int
{
    ///The network is being identified.
    NLM_NETWORK_IDENTIFYING  = 0x00000001,
    ///The network has been identified.
    NLM_NETWORK_IDENTIFIED   = 0x00000002,
    NLM_NETWORK_UNIDENTIFIED = 0x00000003,
}

///The <b>NLM_INTERNET_CONNECTIVITY</b> enumeration defines a set of flags that provide additional data for IPv4 or IPv6
///network connectivity.
alias NLM_INTERNET_CONNECTIVITY = int;
enum : int
{
    ///Indicates that the detected network is a hotspot. For example, when connected to a coffee Wi-Fi hotspot network
    ///and the local HTTP traffic is being redirected to a captive portal, this flag will be set.
    NLM_INTERNET_CONNECTIVITY_WEBHIJACK = 0x00000001,
    ///Indicates that the detected network has a proxy configuration. For example, when connected to a corporate network
    ///using a proxy for HTTP access, this flag will be set.
    NLM_INTERNET_CONNECTIVITY_PROXIED   = 0x00000002,
    ///Indicates that the machine is configured for Direct Access and that access to the corporate domain network, for
    ///which Direct Access was previously configured, has been detected.
    NLM_INTERNET_CONNECTIVITY_CORPORATE = 0x00000004,
}

///The NLM_Connectivity enumeration is a set of flags that provide notification whenever connectivity related parameters
///have changed.
alias NLM_CONNECTIVITY = int;
enum : int
{
    ///The underlying network interfaces have no connectivity to any network.
    NLM_CONNECTIVITY_DISCONNECTED      = 0x00000000,
    ///There is connectivity to a network, but the service cannot detect any IPv4 Network Traffic.
    NLM_CONNECTIVITY_IPV4_NOTRAFFIC    = 0x00000001,
    ///There is connectivity to a network, but the service cannot detect any IPv6 Network Traffic.
    NLM_CONNECTIVITY_IPV6_NOTRAFFIC    = 0x00000002,
    ///There is connectivity to the local subnet using the IPv4 protocol.
    NLM_CONNECTIVITY_IPV4_SUBNET       = 0x00000010,
    ///There is connectivity to a routed network using the IPv4 protocol.
    NLM_CONNECTIVITY_IPV4_LOCALNETWORK = 0x00000020,
    ///There is connectivity to the Internet using the IPv4 protocol.
    NLM_CONNECTIVITY_IPV4_INTERNET     = 0x00000040,
    ///There is connectivity to the local subnet using the IPv6 protocol.
    NLM_CONNECTIVITY_IPV6_SUBNET       = 0x00000100,
    ///There is connectivity to a local network using the IPv6 protocol.
    NLM_CONNECTIVITY_IPV6_LOCALNETWORK = 0x00000200,
    NLM_CONNECTIVITY_IPV6_INTERNET     = 0x00000400,
}

///The NLM_DOMAIN_TYPE enumeration is a set of flags that specify the domain type of a network.
alias NLM_DOMAIN_TYPE = int;
enum : int
{
    ///The Network is not an Active Directory Network.
    NLM_DOMAIN_TYPE_NON_DOMAIN_NETWORK   = 0x00000000,
    ///The Network is an Active Directory Network, but this machine is not authenticated against it.
    NLM_DOMAIN_TYPE_DOMAIN_NETWORK       = 0x00000001,
    NLM_DOMAIN_TYPE_DOMAIN_AUTHENTICATED = 0x00000002,
}

///The NLM_ENUM_NETWORK enumeration contains a set of flags that specify what types of networks are enumerated.
alias NLM_ENUM_NETWORK = int;
enum : int
{
    ///Returns connected networks
    NLM_ENUM_NETWORK_CONNECTED    = 0x00000001,
    ///Returns disconnected networks
    NLM_ENUM_NETWORK_DISCONNECTED = 0x00000002,
    NLM_ENUM_NETWORK_ALL          = 0x00000003,
}

///The NLM_NETWORK_CATEGORY enumeration is a set of flags that specify the category type of a network.
alias NLM_NETWORK_CATEGORY = int;
enum : int
{
    ///The network is a public (untrusted) network.
    NLM_NETWORK_CATEGORY_PUBLIC               = 0x00000000,
    ///The network is a private (trusted) network.
    NLM_NETWORK_CATEGORY_PRIVATE              = 0x00000001,
    ///The network is authenticated against an Active Directory domain.
    NLM_NETWORK_CATEGORY_DOMAIN_AUTHENTICATED = 0x00000002,
}

///The NLM_NETWORK_PROPERTY_CHANGE enumeration is a set of flags that define changes made to the properties of a
///network.
alias NLM_NETWORK_PROPERTY_CHANGE = int;
enum : int
{
    ///A connection to this network has been added or removed.
    NLM_NETWORK_PROPERTY_CHANGE_CONNECTION     = 0x00000001,
    ///The description of the network has changed.
    NLM_NETWORK_PROPERTY_CHANGE_DESCRIPTION    = 0x00000002,
    ///The name of the network has changed.
    NLM_NETWORK_PROPERTY_CHANGE_NAME           = 0x00000004,
    NLM_NETWORK_PROPERTY_CHANGE_ICON           = 0x00000008,
    NLM_NETWORK_PROPERTY_CHANGE_CATEGORY_VALUE = 0x00000010,
}

///The NLM_CONNECTION PROPERTY_CHANGE enumeration is a set of flags that define changes made to the properties of a
///network connection.
alias NLM_CONNECTION_PROPERTY_CHANGE = int;
enum : int
{
    NLM_CONNECTION_PROPERTY_CHANGE_AUTHENTICATION = 0x00000001,
}

// Callbacks

alias ONDEMAND_NOTIFICATION_CALLBACK = void function(void* param0);

// Structs


///The<b>NLM_USAGE_DATA</b> structure stores information that indicates the data usage of a plan.
struct NLM_USAGE_DATA
{
    ///The data usage of a plan, represented in megabytes.
    uint     UsageInMegabytes;
    ///The timestamp of last time synced with carriers about the data usage stored in this structure.
    FILETIME LastSyncTime;
}

///The <b>NLM_DATAPLAN_STATUS</b> structure stores the current data plan status information supplied by the carrier.
struct NLM_DATAPLAN_STATUS
{
    ///The unique ID of the interface associated with the data plan. This GUID is determined by the system when a data
    ///plan is first used by a system connection.
    GUID           InterfaceGuid;
    ///An NLM_USAGE_DATA structure containing current data usage value expressed in megabytes, as well as the system
    ///time at the moment this value was last synced. If this value is not supplied, NLM_USAGE_DATA will indicate
    ///<b>NLM_UNKNOWN_DATAPLAN_STATUS</b> for <b>UsageInMegabytes</b> and a value of '0' will be set for
    ///<b>LastSyncTime.</b>
    NLM_USAGE_DATA UsageData;
    ///The data plan usage limit expressed in megabytes. If this value is not supplied, a default value of
    ///<b>NLM_UNKNOWN_DATAPLAN_STATUS</b> is set.
    uint           DataLimitInMegabytes;
    ///The maximum inbound connection bandwidth expressed in kbps. If this value is not supplied, a default value of
    ///<b>NLM_UNKNOWN_DATAPLAN_STATUS</b> is set.
    uint           InboundBandwidthInKbps;
    ///The maximum outbound connection bandwidth expressed in kbps. If this value is not supplied, a default value of
    ///<b>NLM_UNKNOWN_DATAPLAN_STATUS</b> is set.
    uint           OutboundBandwidthInKbps;
    ///The start time of the next billing cycle. If this value is not supplied, a default value of '0' is set.
    FILETIME       NextBillingCycle;
    ///The maximum suggested transfer size for this network expressed in megabytes. If this value is not supplied, a
    ///default value of <b>NLM_UNKNOWN_DATAPLAN_STATUS</b> is set.
    uint           MaxTransferSizeInMegabytes;
    ///Reserved for future use.
    uint           Reserved;
}

///The <b>NLM_SOCKADDR</b> structure contains the IPv4/IPv6 destination address.
struct NLM_SOCKADDR
{
    ///An IPv4/IPv6 destination address.
    ubyte[128] data;
}

///Used to specify values that are used by SetSimulatedProfileInfo to override current internet connection profile
///values in an RDP Child Session to support the simulation of specific metered internet connection conditions.
struct NLM_SIMULATED_PROFILE_INFO
{
    ///Name for the simulated profile.
    ushort[256]         ProfileName;
    ///The network cost. Possible values are defined by NLM_CONNECTION_COST.
    NLM_CONNECTION_COST cost;
    ///The data usage.
    uint                UsageInMegabytes;
    ///The data limit of the plan.
    uint                DataLimitInMegabytes;
}

///The interface context that is part of the NET_INTERFACE_CONTEXT_TABLE structure.
struct NET_INTERFACE_CONTEXT
{
    ///The interface index.
    uint          InterfaceIndex;
    ///The configuration name.
    const(wchar)* ConfigurationName;
}

///The table of NET_INTERFACE_CONTEXT structures.
struct NET_INTERFACE_CONTEXT_TABLE
{
    ///A handle to the interface context.
    HANDLE InterfaceContextHandle;
    ///The number of entries in the table.
    uint   NumberOfEntries;
    ///An array of NET_INTERFACE_CONTEXT structures.
    NET_INTERFACE_CONTEXT* InterfaceContextArray;
}

// Functions

///The <b>OnDemandGetRoutingHint</b> function looks up a destination in the Route Request cache and, if a match is
///found, return the corresponding Interface ID.
///Params:
///    destinationHostName = An PWSTR describing the target host name for a network communication.
///    interfaceIndex = The interface index of the network adapter to be used for communicating with the target host.
@DllImport("OnDemandConnRouteHelper")
HRESULT OnDemandGetRoutingHint(const(wchar)* destinationHostName, uint* interfaceIndex);

///The <b>OnDemandRegisterNotification</b> function allows an application to register to be notified when the Route
///Requests cache is modified. For example, this allows the system to recycle cached connections when a Route Request is
///added or removed from the cache.
///Params:
///    callback = A pointer to a function of type O<b>ONDEMAND_NOTIFICATION_CALLBACK</b> to receive the notifications.
///    callbackContext = A pointer to a memory location containing optional context to be passed to the callback.
///    registrationHandle = A pointer to a HANDLE to receive a handle to the registration in case of success.
///Returns:
///    Returns S_OK on success.
///    
@DllImport("OnDemandConnRouteHelper")
HRESULT OnDemandRegisterNotification(ONDEMAND_NOTIFICATION_CALLBACK callback, void* callbackContext, 
                                     HANDLE* registrationHandle);

///The <b>OnDemandUnregisterNotification</b> function allows an application to unregister for notifications and clean up
///resources.
///Params:
///    registrationHandle = A HANDLE obtained from a successful OnDemandRegisterNotification call.
///Returns:
///    Returns S_OK on success.
///    
@DllImport("OnDemandConnRouteHelper")
HRESULT OnDemandUnRegisterNotification(HANDLE registrationHandle);

///This function retrieves an interface context table for the given hostname and connection profile filter.
///Params:
///    HostName = The destination hostname.
///    ProxyName = The HTTP proxy name.
///    Flags = You can use the following flags. <table></table> <table> <tr> <td><b>Flag</b></td> <td><b>Description</b></td>
///            </tr> <tr> <td><b>NET_INTERFACE_FLAG_NONE</b></td> <td>Use the default behavior.</td> </tr> <tr>
///            <td><b>NET_INTERFACE_FLAG_CONNECT_IF_NEEDED</b></td> <td>Indicates whether the underlying connection should be
///            activated or not.</td> </tr> </table>
///    ConnectionProfileFilterRawData = The connection profile filter blog which is a byte cast of wcm_selection_filters.
///    ConnectionProfileFilterRawDataSize = The size of the <i>ConnectionProfileFilterRawData</i> in bytes.
///    InterfaceContextTable = This is set to the list of NET_INTERFACE_CONTEXT structures containing the interface indices and configuration
///                            names that can be used for the hostname and filter.
///Returns:
///    This function returns the following <b>HRESULT</b> values depending on the status. <table></table> <table> <tr>
///    <td><b>HRESULT</b></td> <td><b>Description</b></td> </tr> <tr> <td><b>S_OK</b></td> <td> This is returned if
///    connection that satify the parameters and internal policies exists. NET_INTERFACE_CONTEXT_TABLE will contain a
///    list of interfaces indices and configuration names of those connections. When S_OK is returned,
///    FreeInterfaceContextTable should be called to release the context table. </td> </tr> <tr> <td><b>S_FALSE</b></td>
///    <td> This is returned to indicate that any connection or default interface can be used for this hostname and
///    filter. The NET_INTERFACE_CONTEXT_TABLE will be null in this case because the caller can use the default route to
///    satisfy the requirements. </td> </tr> <tr> <td><b>E_NOTFOUND</b></td> <td> This is returned if no connection is
///    currently available or existing connection don't meet the connection filter and the internal policy for the host.
///    The exact return code would be <b>HRESULT(ERROR_NOT_FOUND)</b> </td> </tr> <tr> <td><b>E_INVALIDARG</b></td> <td>
///    This is returned if the caller passes an invalid argument, uses an unsupported flag, has a bad connection filter
///    data, incorrect size or null NET_INTERFACE_CONTEXT_TABLE </td> </tr> <tr> <td><b>E_OUTOFMEMORY</b></td> <td> This
///    is returned if there is not enough memory to complete the operation. </td> </tr> <tr>
///    <td><b>FAILED(HRESULT)</b></td> <td> This is returned because of failures that are outside the control of this
///    function. </td> </tr> </table>
///    
@DllImport("OnDemandConnRouteHelper")
HRESULT GetInterfaceContextTableForHostName(const(wchar)* HostName, const(wchar)* ProxyName, uint Flags, 
                                            char* ConnectionProfileFilterRawData, 
                                            uint ConnectionProfileFilterRawDataSize, 
                                            NET_INTERFACE_CONTEXT_TABLE** InterfaceContextTable);

///This function frees the interface context table retrieved using the GetInterfaceContextTableForHostName function.
///Params:
///    InterfaceContextTable = The interface context table retrieved using the GetInterfaceContextTableForHostName function.
@DllImport("OnDemandConnRouteHelper")
void FreeInterfaceContextTable(NET_INTERFACE_CONTEXT_TABLE* InterfaceContextTable);


// Interfaces

@GUID("DCB00C01-570F-4A9B-8D69-199FDBA5723B")
struct NetworkListManager;

///The <b>INetworkListManager</b> interface provides a set of methods to perform network list management functions.
@GUID("DCB00000-570F-4A9B-8D69-199FDBA5723B")
interface INetworkListManager : IDispatch
{
    ///The <b>GetNetworks</b> method retrieves the list of networks available on the local machine.
    ///Params:
    ///    Flags = NLM_ENUM_NETWORK enumeration value that specifies the flags for the network (specifically, connected or not
    ///            connected).
    ///    ppEnumNetwork = Pointer to a pointer that receives an IEnumNetworks interface instance that contains the enumerator for the
    ///                    list of available networks.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> The pointer passed is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The GUID is invalid. </td> </tr> </table>
    ///    
    HRESULT GetNetworks(NLM_ENUM_NETWORK Flags, IEnumNetworks* ppEnumNetwork);
    ///The <b>GetNetwork</b> method retrieves a network based on a supplied network ID.
    ///Params:
    ///    gdNetworkId = GUID that specifies the network ID.
    ///    ppNetwork = Pointer to a pointer that receives the INetwork interface instance for this network.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> The pointer passed is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The GUID is invalid. </td> </tr> </table>
    ///    
    HRESULT GetNetwork(GUID gdNetworkId, INetwork* ppNetwork);
    ///The <b>GetNetworkConnections</b> method enumerates a complete list of the network connections that have been
    ///made.
    ///Params:
    ///    ppEnum = Pointer to a pointer that receives an IEnumNetworkConnections interface instance that enumerates all network
    ///             connections on the machine.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> The pointer passed is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetNetworkConnections(IEnumNetworkConnections* ppEnum);
    ///The <b>GetNetworkConnection</b> method retrieves a network based on a supplied Network Connection ID.
    ///Params:
    ///    gdNetworkConnectionId = A <b>GUID</b> that specifies the Network Connection ID.
    ///    ppNetworkConnection = Pointer to a pointer to the INetworkConnection object associated with the supplied
    ///                          <i>gdNetworkConnectionId</i>.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl>
    ///    </td> <td width="60%"> The network associated with the specified network connection ID was not found. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The pointer passed is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///    The specified GUID is invalid. </td> </tr> </table>
    ///    
    HRESULT GetNetworkConnection(GUID gdNetworkConnectionId, INetworkConnection* ppNetworkConnection);
    ///The <b>get_IsConnectedToInternet</b> property specifies if the local machine has internet connectivity.
    ///Params:
    ///    pbIsConnected = If <b>TRUE</b>, the local machine is connected to the internet; if <b>FALSE</b>, it is not.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT get_IsConnectedToInternet(short* pbIsConnected);
    ///The <b>get_IsConnected</b> property specifies if the local machine has network connectivity.
    ///Params:
    ///    pbIsConnected = If <b>TRUE</b> , the network has at least local connectivity via ipv4 or ipv6 or both. The network may also
    ///                    have internet connectivity. Thus, the network is connected. If <b>FALSE</b>, the network does not have local
    ///                    or internet connectivity. The network is not connected.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT get_IsConnected(short* pbIsConnected);
    ///The <b>GetConnectivity</b> method returns the overall connectivity state of the machine.
    ///Params:
    ///    pConnectivity = Pointer to an NLM_CONNECTIVITY enumeration value that contains a bitmask that specifies the network
    ///                    connectivity of this machine.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    ///The <b>SetSimulatedProfileInfo</b> method applies a specific set of connection profile values to the internet
    ///connection profile in support of the simulation of specific metered internet connection conditions. The
    ///simulation only applies in an RDP Child Session and does not affect the primary user session. The simulated
    ///internet connection profile is returned via the Windows Runtime API GetInternetConnectionProfile.
    ///Params:
    ///    pSimulatedInfo = Specific connection profile values to simulate on the current internet connection profile when calling
    ///                     GetInternetConnectionProfile from an RDP Child Session
    ///Returns:
    ///    Returns S_OK on success.
    ///    
    HRESULT SetSimulatedProfileInfo(NLM_SIMULATED_PROFILE_INFO* pSimulatedInfo);
    ///Clears the connection profile values previously applied to the internet connection profile by
    ///SetSimulatedProfileInfo. The next internet connection query, via GetInternetConnectionProfile, will use system
    ///information.
    ///Returns:
    ///    Returns S_OK on success.
    ///    
    HRESULT ClearSimulatedProfileInfo();
}

///<b>INetworkListManagerEvents</b> is a message sink interface that a client implements to get overall machine state
///related events. Applications that are interested on higher-level events, for example internet connectivity, implement
///this interface.
@GUID("DCB00001-570F-4A9B-8D69-199FDBA5723B")
interface INetworkListManagerEvents : IUnknown
{
    ///The <b>NetworkConnectivityChanged</b> method is called when network connectivity related changes occur.
    ///Params:
    ///    newConnectivity = An NLM_CONNECTIVITY enumeration value that contains the new connectivity settings of the machine.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT ConnectivityChanged(NLM_CONNECTIVITY newConnectivity);
}

///The <b>INetwork</b> interface represents a network on the local machine. It can also represent a collection of
///network connections with a similar network signature.
@GUID("DCB00002-570F-4A9B-8D69-199FDBA5723B")
interface INetwork : IDispatch
{
    ///The <b>GetName</b> method returns the name of a network.
    ///Params:
    ///    pszNetworkName = Pointer to the name of the network.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns the following value. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> The pointer passed is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetName(BSTR* pszNetworkName);
    ///The <b>SetName</b> method sets or renames a network.
    ///Params:
    ///    szNetworkNewName = Zero-terminated string that contains the new name of the network.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>szNetworkNewName</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILENAME_EXCED_RANGE)</b></dt> </dl> </td> <td width="60%"> The name provided
    ///    is too long. </td> </tr> </table>
    ///    
    HRESULT SetName(BSTR szNetworkNewName);
    ///The <b>GetDescription</b> method returns a description string for the network.
    ///Params:
    ///    pszDescription = Pointer to a string that specifies the text description of the network. This value must be freed using the
    ///                     SysFreeString API.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> The pointer passed is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetDescription(BSTR* pszDescription);
    ///The <b>SetDescription</b> method sets or replaces the description for a network.
    ///Params:
    ///    szDescription = Zero-terminated string that contains the description of the network.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>szDescription</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILENAME_EXCED_RANGE)</b></dt> </dl> </td> <td width="60%"> The given name is
    ///    too long. </td> </tr> </table>
    ///    
    HRESULT SetDescription(BSTR szDescription);
    ///The <b>GetNetworkId</b> method returns the unique identifier of a network.
    ///Params:
    ///    pgdGuidNetworkId = Pointer to a GUID that specifies the network ID.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetNetworkId(GUID* pgdGuidNetworkId);
    ///The GetDomainType method returns the domain type of a network.
    ///Params:
    ///    pNetworkType = Pointer to an NLM_DOMAIN_TYPE enumeration value that specifies the domain type of the network.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetDomainType(NLM_DOMAIN_TYPE* pNetworkType);
    ///The <b>GetNetworkConnections</b> method returns an enumeration of all network connections for a network. A
    ///network can have multiple connections to it from different interfaces or different links from the same interface.
    ///Params:
    ///    ppEnumNetworkConnection = Pointer to an IEnumNetworkConnections interface instance that enumerates the list of local connections to
    ///                              this network.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetNetworkConnections(IEnumNetworkConnections* ppEnumNetworkConnection);
    ///The <b>GetTimeCreatedAndConnected</b> method returns the local date and time when the network was created and
    ///connected.
    ///Params:
    ///    pdwLowDateTimeCreated = Pointer to a datetime when the network was created. Specifically, it contains the low DWORD of
    ///                            <b>FILETIME.dwLowDateTime</b>.
    ///    pdwHighDateTimeCreated = Pointer to a datetime when the network was created. Specifically, it contains the high DWORD of
    ///                             <b>FILETIME.dwLowDateTime</b>.
    ///    pdwLowDateTimeConnected = Pointer to a datetime when the network was last connected to. Specifically, it contains the low DWORD of
    ///                              <b>FILETIME.dwLowDateTime</b>.
    ///    pdwHighDateTimeConnected = Pointer to a datetime when the network was last connected to. Specifically, it contains the high DWORD of
    ///                               <b>FILETIME.dwLowDateTime</b>.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> The pointer passed is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTimeCreatedAndConnected(uint* pdwLowDateTimeCreated, uint* pdwHighDateTimeCreated, 
                                       uint* pdwLowDateTimeConnected, uint* pdwHighDateTimeConnected);
    ///The <b>get_IsConnectedToInternet</b> property specifies if the network has internet connectivity.
    ///Params:
    ///    pbIsConnected = If <b>TRUE</b>, this network has connectivity to the internet; if <b>FALSE</b>, it does not.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT get_IsConnectedToInternet(short* pbIsConnected);
    ///The <b>get_IsConnected</b> property specifies if the network has any network connectivity.
    ///Params:
    ///    pbIsConnected = If <b>TRUE</b>, this network is connected; if <b>FALSE</b>, it is not.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT get_IsConnected(short* pbIsConnected);
    ///The <b>GetConnectivity</b> method returns the connectivity state of the network.
    ///Params:
    ///    pConnectivity = Pointer to a NLM_CONNECTIVITY enumeration value that contains a bitmask that specifies the connectivity state
    ///                    of this network.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    ///The <b>GetCategory</b> method returns the category of a network.
    ///Params:
    ///    pCategory = Pointer to a NLM_NETWORK_CATEGORY enumeration value that specifies the category information for the network.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetCategory(NLM_NETWORK_CATEGORY* pCategory);
    ///The <b>SetCategory</b> method sets the category of a network. Changes made take effect immediately. Callers of
    ///this API must be members of the Administrators group.
    ///Params:
    ///    NewCategory = Pointer to a NLM_NETWORK_CATEGORY enumeration value that specifies the new category of the network.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT SetCategory(NLM_NETWORK_CATEGORY NewCategory);
}

///The <b>IEnumNetworks</b> interface is a standard enumerator for networks. It enumerates all networks available on the
///local machine. This interface can be obtained from the INetworkListManager interface.
@GUID("DCB00003-570F-4A9B-8D69-199FDBA5723B")
interface IEnumNetworks : IDispatch
{
    ///The <b>get_NewEnum</b> property returns an automation enumerator object that you can use to iterate through the
    ///IEnumNetworks collection.
    ///Params:
    ///    ppEnumVar = Contains the new instance of the implemented interface.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppEnumVar);
    ///The <b>Next</b> method gets the next specified number of elements in the enumeration sequence.
    ///Params:
    ///    celt = Number of elements requested in the enumeration.
    ///    rgelt = Pointer to the enumerated list of pointers returned by INetwork.
    ///    pceltFetched = Pointer to the number of elements supplied. This parameter is set to <b>NULL</b> if <i>celt</i> has the value
    ///                   of 1.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl>
    ///    </td> <td width="60%"> The number of elements skipped was not equal to <i>celt</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory exists to
    ///    perform the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>ppElements</i> parameter is not a valid pointer. </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    ///The <b>Skip</b> method skips over the next specified number of elements in the enumeration sequence.
    ///Params:
    ///    celt = Number of elements to skip in the enumeration.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl>
    ///    </td> <td width="60%"> The number of elements skipped was not <i>celt</i>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory exists to perform the
    ///    operation. </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///The <b>Reset</b> method resets the enumeration sequence to the beginning.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Insufficient memory exists to perform the operation. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///The <b>Clone</b> method creates an enumerator that contains the same enumeration state as the enumerator
    ///currently in use.
    ///Params:
    ///    ppEnumNetwork = Pointer to a new IEnumNetworks interface.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT Clone(IEnumNetworks* ppEnumNetwork);
}

///<b>INetworkEvents</b> is a notification sink interface that a client implements to get network related events. These
///APIs are all callback functions that are called automatically when the respective events are raised.
@GUID("DCB00004-570F-4A9B-8D69-199FDBA5723B")
interface INetworkEvents : IUnknown
{
    ///The <b>NetworkAdded</b> method is called when a new network is added. The GUID of the new network is provided.
    ///Params:
    ///    networkId = A <b>GUID</b> that specifies the new network that was added.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT NetworkAdded(GUID networkId);
    ///The <b>NetworkDeleted</b> method is called when a network is deleted.
    ///Params:
    ///    networkId = GUID that contains the network ID of the network that was deleted.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT NetworkDeleted(GUID networkId);
    ///The <b>NetworkConnectivityChanged</b> method is called when network connectivity related changes occur.
    ///Params:
    ///    networkId = A <b>GUID</b> that specifies the new network that was added.
    ///    newConnectivity = NLM_CONNECTIVITY enumeration value that contains the new connectivity of this network.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT NetworkConnectivityChanged(GUID networkId, NLM_CONNECTIVITY newConnectivity);
    ///The <b>NetworkPropertyChanged</b> method is called when a network property change is detected.
    ///Params:
    ///    networkId = GUID that specifies the network on which this event occurred.
    ///    flags = NLM_NETWORK_PROPERTY_CHANGE enumeration value that specifies the network property that changed.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT NetworkPropertyChanged(GUID networkId, NLM_NETWORK_PROPERTY_CHANGE flags);
}

///The <b>INetworkConnection</b> interface represents a single network connection.
@GUID("DCB00005-570F-4A9B-8D69-199FDBA5723B")
interface INetworkConnection : IDispatch
{
    ///The <b>GetNetwork</b> method returns the network associated with the connection.
    ///Params:
    ///    ppNetwork = Pointer to a pointer that receives an INetwork interface instance that specifies the network associated with
    ///                the connection.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetNetwork(INetwork* ppNetwork);
    ///The get_IsConnectedToInternet property specifies if the associated network connection has internet connectivity.
    ///Params:
    ///    pbIsConnected = If <b>TRUE</b>, this network connection has connectivity to the internet; if <b>FALSE</b>, it does not.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT get_IsConnectedToInternet(short* pbIsConnected);
    ///The <b>get_IsConnected</b> property specifies if the associated network connection has network connectivity.
    ///Params:
    ///    pbIsConnected = If <b>TRUE</b>, this network connection has connectivity; if <b>FALSE</b>, it does not.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT get_IsConnected(short* pbIsConnected);
    ///The <b>GetConnectivity</b> method returns the connectivity state of the network connection.
    ///Params:
    ///    pConnectivity = Pointer to a NLM_CONNECTIVITY enumeration value that contains a bitmask that specifies the connectivity of
    ///                    this network connection.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    ///The GetConnectionID method returns the Connection ID associated with this network connection.
    ///Params:
    ///    pgdConnectionId = Pointer to a <b>GUID</b> that specifies the Connection ID associated with this network connection.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetConnectionId(GUID* pgdConnectionId);
    ///The <b>GetAdapterID</b> method returns the ID of the network adapter used by this connection.
    ///Params:
    ///    pgdAdapterId = Pointer to a GUID that specifies the adapter ID of the TCP/IP interface used by this network connection.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetAdapterId(GUID* pgdAdapterId);
    ///The <b>GetDomainType</b> method returns the domain type of the network connection.
    ///Params:
    ///    pDomainType = Pointer to an NLM_DOMAIN_TYPE enumeration value that specifies the domain type of the network.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT GetDomainType(NLM_DOMAIN_TYPE* pDomainType);
}

///The IEnumNetworkConnections interface provides a standard enumerator for network connections. It enumerates active,
///disconnected, or all network connections within a network. This interface can be obtained from the INetwork
///interface.
@GUID("DCB00006-570F-4A9B-8D69-199FDBA5723B")
interface IEnumNetworkConnections : IDispatch
{
    ///The <b>get_NewEnum</b> property returns an automation enumerator object that you can use to iterate through the
    ///IEnumNetworkConnections collection.
    ///Params:
    ///    ppEnumVar = Contains the new instance of the implemented interface.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppEnumVar);
    ///The <b>Next</b> method gets the next specified number of elements in the enumeration sequence.
    ///Params:
    ///    celt = Number of elements requested.
    ///    rgelt = Pointer to a list of pointers returned by INetworkConnection.
    ///    pceltFetched = Pointer to the number of elements supplied. May be <b>NULL</b> if <i>celt</i> is one.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl>
    ///    </td> <td width="60%"> The number of elements skipped was not <i>celt</i>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory exists to perform the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>ppElements</i> parameter is not a valid pointer. </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    ///The <b>Skip</b> method skips over the next specified number of elements in the enumeration sequence.
    ///Params:
    ///    celt = Number of elements to skip over in the enumeration.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl>
    ///    </td> <td width="60%"> The number of elements skipped was not <i>celt</i>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory exists to perform the
    ///    operation. </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///The <b>Reset</b> method resets the enumeration sequence to the beginning.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Insufficient memory exists to perform the operation. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///The <b>Clone</b> method creates an enumerator that contains the same enumeration state as the enumerator
    ///currently in use.
    ///Params:
    ///    ppEnumNetwork = Pointer to new IEnumNetworkConnections interface instance.
    ///Returns:
    ///    Returns S_OK if the method succeeds. Otherwise, the method returns one of the following values. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> The <i>ppEnum</i> parameter is not a valid pointer. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory exists to perform the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///    Failed for unknown reasons. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumNetworkConnections* ppEnumNetwork);
}

///The <b>INetworkConnectionEvents</b> interface is a message sink interface that a client implements to get network
///connection-related events. Applications that are interested in lower-level events (such as authentication changes)
///must implement this interface.
@GUID("DCB00007-570F-4A9B-8D69-199FDBA5723B")
interface INetworkConnectionEvents : IUnknown
{
    ///The <b>NetworkConnectionConnectivityChanged</b> method notifies a client when connectivity change events occur on
    ///a network connection level.
    ///Params:
    ///    connectionId = A GUID that identifies the network connection on which the event occurred.
    ///    newConnectivity = NLM_CONNECTIVITY enumeration value that specifies the new connectivity for this network connection.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT NetworkConnectionConnectivityChanged(GUID connectionId, NLM_CONNECTIVITY newConnectivity);
    ///The <b>NetworkConnectionPropertyChanged</b> method notifies a client when property change events related to a
    ///specific network connection occur.
    ///Params:
    ///    connectionId = A GUID that identifies the network connection on which the event occurred.
    ///    flags = The NLM_CONNECTION_PROPERTY_CHANGE flags for this connection.
    ///Returns:
    ///    Returns S_OK if the method succeeds.
    ///    
    HRESULT NetworkConnectionPropertyChanged(GUID connectionId, NLM_CONNECTION_PROPERTY_CHANGE flags);
}

///Use this interface to query for machine-wide cost and data plan status information associated with either a
///connection used for machine-wide Internet connectivity, or the first-hop of routing to a specific destination on a
///connection. Additionally, this interface enables applications to specify destination IP addresses to receive cost or
///data plan status change notifications for.
@GUID("DCB00008-570F-4A9B-8D69-199FDBA5723B")
interface INetworkCostManager : IUnknown
{
    ///The <b>GetCost</b> method retrieves the current cost of either a machine-wide internet connection, or the
    ///first-hop of routing to a specific destination on a connection. If <i>destIPaddr</i> is NULL, this method instead
    ///returns the cost of the network used for machine-wide Internet connectivity.
    ///Params:
    ///    pCost = A DWORD value that indicates the cost of the connection. The lowest 16 bits represent the cost level, and the
    ///            highest 16 bits represent the flags. Possible values are defined by the NLM_CONNECTION_COST enumeration.
    ///    pDestIPAddr = An NLM_SOCKADDR structure containing the destination IPv4/IPv6 address. If NULL, this method will instead
    ///                  return the cost associated with the preferred connection used for machine Internet connectivity.
    ///Returns:
    ///    Returns S_OK on success, otherwise an HRESULT error code is returned. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>pCost</i> is NULL </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td
    ///    width="60%"> Currently determining the interface used to route to the destination </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The destination IPv4/IPv6 address
    ///    specified by <i>destIPAddr</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The request is not
    ///    supported. This error is returned if either an IPv4 or IPv6 stack is not present on the local computer but
    ///    either an IPv4 or IPv6 address was specified by<i>destIPAddr</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NO_NETWORK)</b></dt> </dl> </td> <td width="60%"> Network connectivity is
    ///    currently unavailable. </td> </tr> </table>
    ///    
    HRESULT GetCost(uint* pCost, NLM_SOCKADDR* pDestIPAddr);
    ///The <b>GetDataPlanStatus</b> retrieves the data plan status for either a machine-wide internet connection , or
    ///the first-hop of routing to a specific destination on a connection. If an IPv4/IPv6 address is not specified,
    ///this method returns the data plan status of the connection used for machine-wide Internet connectivity.
    ///Params:
    ///    pDataPlanStatus = Pointer to an NLM_DATAPLAN_STATUS structure that describes the data plan status associated with a connection
    ///                      used to route to a destination. If <i>destIPAddr</i> specifies a tunnel address, the first available data
    ///                      plan status in the interface stack is returned.
    ///    pDestIPAddr = An NLM_SOCKADDR structure containing the destination IPv4/IPv6 or tunnel address. If NULL, this method
    ///                  returns the cost associated with the preferred connection used for machine Internet connectivity.
    ///Returns:
    ///    Returns S_OK on success, otherwise an HRESULT error code is returned. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>pDataPlanStatus</i> is NULL. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td>
    ///    <td width="60%"> Determining the interface used to route to the destination </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The destination address specified by
    ///    <i>destIPAddr</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The request is not
    ///    supported. This error is returned if either an IPv4 or IPv6 stack is not present on the local computer but
    ///    either an IPv4 or IPv6 address was specified by<i>destIPAddr</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NO_NETWORK)</b></dt> </dl> </td> <td width="60%"> Network connectivity is
    ///    currently unavailable. </td> </tr> </table>
    ///    
    HRESULT GetDataPlanStatus(NLM_DATAPLAN_STATUS* pDataPlanStatus, NLM_SOCKADDR* pDestIPAddr);
    ///The <b>SetDestinationAddresses</b> method registers specified destination IPv4/IPv6 addresses to receive cost or
    ///data plan status change notifications.
    ///Params:
    ///    length = The number of destination IPv4/IPv6 addresses in the list.
    ///    pDestIPAddrList = A NLM_SOCKADDR structure containing a list of destination IPv4/IPv6 addresses to register for cost or data
    ///                      plan status change notification.
    ///    bAppend = If true, <i>pDestIPAddrList</i> will be appended to the existing address list; otherwise the existing list
    ///              will be overwritten.
    ///Returns:
    ///    Returns S_OK on success, otherwise an HRESULT error code is returned. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> Returned if one of the following occurs: <ul> <li><i>length</i> is 0.</li> <li><i>length</i> is
    ///    larger than NLM_MAX_ADDRESS_LIST_SIZE(10)</li> <li><i>bAppend</i> is VARIANT_TRUE, but including the number
    ///    of subscribed destinations in the existing list with the value of <i>length</i> exceeds
    ///    NLM_MAX_ADDRESS_SIZE.</li> <li>A destination address in the supplied list is invalid.</li> </ul> </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>destIPAddrList</i> is
    ///    NULL. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl>
    ///    </td> <td width="60%"> The request is not supported. This error is returned if either an IPv4 or IPv6 stack
    ///    is not present on the local computer but either an IPv4 or IPv6 address was specified by<i>destIPAddr</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_ALREADY_INITIALIZED)</b></dt> </dl>
    ///    </td> <td width="60%"> This method was called after registering for INetworkCostManagerEvents by calling
    ///    IConnectionPoint::Advise. See Remark for more information. </td> </tr> </table>
    ///    
    HRESULT SetDestinationAddresses(uint length, char* pDestIPAddrList, short bAppend);
}

///Use this interface to notify an application of machine-wide cost and data plan related events.
@GUID("DCB00009-570F-4A9B-8D69-199FDBA5723B")
interface INetworkCostManagerEvents : IUnknown
{
    ///The <b>CostChanged</b> method is called to indicates a cost change for either machine-wide Internet connectivity,
    ///or the first-hop of routing to a specific destination on a connection.
    ///Params:
    ///    newCost = A DWORD that represents the new cost of the connection. The lowest 16 bits represent the cost level, and the
    ///              highest 16 bits represent the flags. Possible values are defined by the NLM_CONNECTION_COST enumeration.
    ///    pDestAddr = An NLM_SOCKADDR structure containing an IPv4/IPv6 address that identifies the destination on which the event
    ///                occurred. If <i>destAddr</i> is NULL, the change is a machine-wide Internet connectivity change.
    ///Returns:
    ///    Returns S_OK on success.
    ///    
    HRESULT CostChanged(uint newCost, NLM_SOCKADDR* pDestAddr);
    ///The <b>DataPlanStatusChanged</b> method is called to indicate a change to the status of a data plan associated
    ///with either a connection used for machine-wide Internet connectivity, or the first-hop of routing to a specific
    ///destination on a connection.
    ///Params:
    ///    pDestAddr = An NLM_SOCKADDR structure containing an IPv4/IPv6 address that identifies the destination for which the event
    ///                occurred. If <i>destAddr</i> is NULL, the change is a machine-wide Internet connectivity change.
    ///Returns:
    ///    Returns S_OK on success.
    ///    
    HRESULT DataPlanStatusChanged(NLM_SOCKADDR* pDestAddr);
}

///Use this interface to query current network cost and data plan status associated with a connection.
@GUID("DCB0000A-570F-4A9B-8D69-199FDBA5723B")
interface INetworkConnectionCost : IUnknown
{
    ///The <b>GetCost</b> method retrieves the network cost associated with a connection.
    ///Params:
    ///    pCost = A DWORD value that represents the network cost of the connection. The lowest 16 bits represent the cost level
    ///            and the highest 16 bits represent the cost flags. Possible values are defined by the NLM_CONNECTION_COST
    ///            enumeration.
    ///Returns:
    ///    Returns S_OK on success. Otherwise an HRESULT error code is returned. Possible values include: <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pCost</i> is NULL </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NO_NETWORK)</b></dt> </dl> </td> <td width="60%"> Network connectivity is
    ///    currently unavailable. </td> </tr> </table>
    ///    
    HRESULT GetCost(uint* pCost);
    ///The <b>GetDataPlanStatus</b> method retrieves the status of the data plan associated with a connection.
    ///Params:
    ///    pDataPlanStatus = Pointer to an NLM_DATAPLAN_STATUS structure that describes the status of the data plan associated with the
    ///                      connection. The caller supplies the memory of this structure.
    ///Returns:
    ///    Returns S_OK on success. Otherwise, an HRESULT error code is returned. Possible values include: <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pDataPlanStatus</i> is NULL. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NO_NETWORK)</b></dt> </dl> </td> <td width="60%"> Network connectivity is
    ///    currently unavailable. </td> </tr> </table>
    ///    
    HRESULT GetDataPlanStatus(NLM_DATAPLAN_STATUS* pDataPlanStatus);
}

///Use this interface to notify an application of cost and data plan status change events for a connection.
@GUID("DCB0000B-570F-4A9B-8D69-199FDBA5723B")
interface INetworkConnectionCostEvents : IUnknown
{
    ///The <b>ConnectionCostChanged</b> method notifies an application of a network cost change for a connection.
    ///Params:
    ///    connectionId = A unique ID that identifies the connection on which the cost change event occurred.
    ///    newCost = A DWORD value that represents the new cost of the connection. The lowest 16 bits represent the cost level,
    ///              and the highest 16 bits represent the flags. Possible values are defined by the NLM_CONNECTION_COST
    ///              enumeration.
    ///Returns:
    ///    This method returns S_OK on success.
    ///    
    HRESULT ConnectionCostChanged(GUID connectionId, uint newCost);
    ///The <b>ConnectionDataPlanStatusChanged</b> method notifies an application of a data plan status change on a
    ///connection.
    ///Params:
    ///    connectionId = A unique ID that identifies the connection on which the data plan status change event occurred.
    ///Returns:
    ///    This method returns S_OK on success.
    ///    
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
