// Written in the D programming language.

module windows.windowsconnectionmanager;

public import windows.core;
public import windows.systemservices : BOOL;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


///The <b>WCM_PROPERTY</b> enumerated type specifies a property of a connection.
alias WCM_PROPERTY = int;
enum : int
{
    ///Domain policy.
    wcm_global_property_domain_policy          = 0x00000000,
    ///Minimize policy.
    wcm_global_property_minimize_policy        = 0x00000001,
    ///Roaming policy.
    wcm_global_property_roaming_policy         = 0x00000002,
    ///Power management policy.
    wcm_global_property_powermanagement_policy = 0x00000003,
    ///The cost level and flags for the connection
    wcm_intf_property_connection_cost          = 0x00000004,
    ///The plan data associated with the new cost.
    wcm_intf_property_dataplan_status          = 0x00000005,
    wcm_intf_property_hotspot_profile          = 0x00000006,
}

///The <b>WCM_MEDIA_TYPE</b> enumerated type specifies the type of media for a connection.
alias WCM_MEDIA_TYPE = int;
enum : int
{
    ///Unknown media.
    wcm_media_unknown  = 0x00000000,
    ///Ethernet.
    wcm_media_ethernet = 0x00000001,
    ///WLAN.
    wcm_media_wlan     = 0x00000002,
    ///Mobile broadband.
    wcm_media_mbn      = 0x00000003,
    ///Invalid type.
    wcm_media_invalid  = 0x00000004,
    wcm_media_max      = 0x00000005,
}

///The <b>WCM_CONNECTION_COST</b> enumerated type determines the connection cost type and flags.
alias WCM_CONNECTION_COST = int;
enum : int
{
    ///Connection cost information is not available.
    WCM_CONNECTION_COST_UNKNOWN              = 0x00000000,
    ///The connection is unlimited and has unrestricted usage constraints.
    WCM_CONNECTION_COST_UNRESTRICTED         = 0x00000001,
    ///Usage counts toward a fixed allotment of data which the user has already paid for (or agreed to pay for).
    WCM_CONNECTION_COST_FIXED                = 0x00000002,
    ///The connection cost is on a per-byte basis.
    WCM_CONNECTION_COST_VARIABLE             = 0x00000004,
    ///The connection has exceeded its data limit.
    WCM_CONNECTION_COST_OVERDATALIMIT        = 0x00010000,
    ///The connection is throttled due to high traffic.
    WCM_CONNECTION_COST_CONGESTED            = 0x00020000,
    ///The connection is outside of the home network. <div class="alert"><b>Note</b> The
    ///<b>WCM_CONNECTION_COST_ROAMING</b> value comes directly from the connection source. Attempts to set it directly
    ///will fail.</div> <div> </div>
    WCM_CONNECTION_COST_ROAMING              = 0x00040000,
    WCM_CONNECTION_COST_APPROACHINGDATALIMIT = 0x00080000,
}

///The <b>WCM_CONNECTION_COST_SOURCE</b> enumerated type specifies the source that provides connection cost information.
alias WCM_CONNECTION_COST_SOURCE = int;
enum : int
{
    ///Default source.
    WCM_CONNECTION_COST_SOURCE_DEFAULT  = 0x00000000,
    ///The source for the connection cost is Group Policy.
    WCM_CONNECTION_COST_SOURCE_GP       = 0x00000001,
    ///The source for the connection cost is the user.
    WCM_CONNECTION_COST_SOURCE_USER     = 0x00000002,
    WCM_CONNECTION_COST_SOURCE_OPERATOR = 0x00000003,
}

// Structs


///The <b>WCM_POLICY_VALUE</b> structure contains information about the current value of a policy.
struct WCM_POLICY_VALUE
{
    ///Type: <b>BOOL</b> True if the policy is enabled; otherwise, false.
    BOOL fValue;
    BOOL fIsGroupPolicy;
}

///The <b>WCM_PROFILE_INFO</b> structure contains information about a specific profile.
struct WCM_PROFILE_INFO
{
    ///Type: <b>WCHAR[WCM_MAX_PROFILE_NAME]</b> The profile name.
    ushort[256]    strProfileName;
    ///Type: <b>GUID</b> The GUID of the adapter.
    GUID           AdapterGUID;
    ///Type: <b>WCM_MEDIA_TYPE</b> The media type for the profile.
    WCM_MEDIA_TYPE Media;
}

///The <b>WCM_PROFILE_INFO_LIST</b> structure contains a list of profiles in preferred order.
struct WCM_PROFILE_INFO_LIST
{
    ///Type: <b>DWORD</b> The number of profiles in the list.
    uint                dwNumberOfItems;
    WCM_PROFILE_INFO[1] ProfileInfo;
}

///The <b>WCM_CONNECTION_COST_DATA</b> structure specifies information about a connection cost.
struct WCM_CONNECTION_COST_DATA
{
    ///Type: <b>DWORD</b> Specifies the connection cost type. This must include one (and only one) of the following
    ///flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="WCM_CONNECTION_COST_UNKNOWN"></a><a id="wcm_connection_cost_unknown"></a><dl>
    ///<dt><b>WCM_CONNECTION_COST_UNKNOWN</b></dt> <dt>0x0</dt> </dl> </td> <td width="60%"> Connection cost information
    ///is not available. </td> </tr> <tr> <td width="40%"><a id="WCM_CONNECTION_COST_UNRESTRICTED"></a><a
    ///id="wcm_connection_cost_unrestricted"></a><dl> <dt><b>WCM_CONNECTION_COST_UNRESTRICTED</b></dt> <dt>0x1</dt>
    ///</dl> </td> <td width="60%"> The connection is unlimited and has unrestricted usage constraints. </td> </tr> <tr>
    ///<td width="40%"><a id="WCM_CONNECTION_COST_FIXED"></a><a id="wcm_connection_cost_fixed"></a><dl>
    ///<dt><b>WCM_CONNECTION_COST_FIXED</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> Usage counts toward a fixed
    ///allotment of data which the user has already paid for (or agreed to pay for). </td> </tr> <tr> <td width="40%"><a
    ///id="WCM_CONNECTION_COST_VARIABLE"></a><a id="wcm_connection_cost_variable"></a><dl>
    ///<dt><b>WCM_CONNECTION_COST_VARIABLE</b></dt> <dt>0x4</dt> </dl> </td> <td width="60%"> The connection cost is on
    ///a per-byte basis. </td> </tr> </table> And may include any combination of the following flags: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WCM_CONNECTION_COST_OVERDATALIMIT"></a><a
    ///id="wcm_connection_cost_overdatalimit"></a><dl> <dt><b>WCM_CONNECTION_COST_OVERDATALIMIT</b></dt>
    ///<dt>0x10000</dt> </dl> </td> <td width="60%"> The connection has exceeded its data limit. </td> </tr> <tr> <td
    ///width="40%"><a id="WCM_CONNECTION_COST_CONGESTED"></a><a id="wcm_connection_cost_congested"></a><dl>
    ///<dt><b>WCM_CONNECTION_COST_CONGESTED</b></dt> <dt>0x20000</dt> </dl> </td> <td width="60%"> The connection is
    ///throttled due to high traffic. </td> </tr> <tr> <td width="40%"><a id="WCM_CONNECTION_COST_ROAMING"></a><a
    ///id="wcm_connection_cost_roaming"></a><dl> <dt><b>WCM_CONNECTION_COST_ROAMING</b></dt> <dt>0x40000</dt> </dl>
    ///</td> <td width="60%"> The connection is outside of the home network. </td> </tr> </table>
    uint ConnectionCost;
    ///Type: <b>WCM_CONNECTION_COST_SOURCE</b> Specifies the cost source.
    WCM_CONNECTION_COST_SOURCE CostSource;
}

///The <b>WCM_TIME_INTERVAL</b> structure defines a time interval.
struct WCM_TIME_INTERVAL
{
    ///Type: <b>WORD</b> Years.
    ushort wYear;
    ///Type: <b>WORD</b> Months.
    ushort wMonth;
    ///Type: <b>WORD</b> Days.
    ushort wDay;
    ///Type: <b>WORD</b> Hours.
    ushort wHour;
    ///Type: <b>WORD</b> Minutes.
    ushort wMinute;
    ///Type: <b>WORD</b> Seconds.
    ushort wSecond;
    ushort wMilliseconds;
}

///The <b>WCM_USAGE_DATA</b> structure contains information related to connection usage.
struct WCM_USAGE_DATA
{
    ///Type: <b>DWORD</b> The connection usage, in megabytes.
    uint     UsageInMegabytes;
    FILETIME LastSyncTime;
}

///The <b>WCM_BILLING_CYCLE_INFO</b> structure specifies information about the billing cycle.
struct WCM_BILLING_CYCLE_INFO
{
    ///Type: <b>FILETIME</b> Specifies the start date of the cycle.
    FILETIME          StartDate;
    ///Type: <b>WCM_TIME_INTERVAL</b> Specifies the billing cycle duration.
    WCM_TIME_INTERVAL Duration;
    ///Type: <b>BOOL</b> True if at the end of the billing cycle, a new billing cycle of the same duration will start.
    ///False if the service will terminate at the end of the billing cycle.
    BOOL              Reset;
}

///The <b>WCM_DATAPLAN_STATUS</b> structure specifies subscription information for a network connection.
struct WCM_DATAPLAN_STATUS
{
    ///Type: <b>WCM_USAGE_DATA</b> Contains usage data.
    WCM_USAGE_DATA UsageData;
    ///Type: <b>DWORD</b> Specifies the data limit, in megabytes.
    uint           DataLimitInMegabytes;
    ///Type: <b>DWORD</b> Specifies the inbound bandwidth, in kilobits per second.
    uint           InboundBandwidthInKbps;
    ///Type: <b>DWORD</b> Specifies the outbound bandwidth, in kilobits per second.
    uint           OutboundBandwidthInKbps;
    ///Type: <b>WCM_BILLING_CYCLE_INFO</b> Contains information about the billing cycle.
    WCM_BILLING_CYCLE_INFO BillingCycle;
    ///Type: <b>DWORD</b> Specifies the maximum size of a file that can be transferred, in megabytes.
    uint           MaxTransferSizeInMegabytes;
    ///Type: <b>DWORD</b> Reserved.
    uint           Reserved;
}

// Functions

///The <b>WcmQueryProperty</b> function retrieves the value of a specified WCM property.
///Params:
///    pInterface = Type: <b>const GUID*</b> The interface to query. For global properties, this parameter is NULL.
///    strProfileName = Type: <b>LPCWSTR</b> The name of the profile. If querying a non-global property (<b>connection_cost</b>,
///                     <b>dataplan_status</b>, or <b>hotspot_profile</b>), the profile must be specified or the call will fail.
///    Property = Type: <b>WCM_PROPERTY</b> The WCM property to query.
///    pReserved = Type: <b>PVOID</b> Reserved.
///    pdwDataSize = Type: <b>PDWORD</b> The size of the returned property value.
///    ppData = Type: <b>PBYTE*</b> The returned property value.
///Returns:
///    Type: <b>DWORD</b> Returns ERROR_SUCCESS if successful, or an error value otherwise.
///    
@DllImport("wcmapi")
uint WcmQueryProperty(const(GUID)* pInterface, const(wchar)* strProfileName, WCM_PROPERTY Property, 
                      void* pReserved, uint* pdwDataSize, ubyte** ppData);

///The <b>WcmSetProperty</b> function sets the value of a WCM property.
///Params:
///    pInterface = Type: <b>const GUID*</b> The interface to set. For global properties, this parameter is NULL.
///    strProfileName = Type: <b>LPCWSTR</b> The profile name.
///    Property = Type: <b>WCM_PROPERTY</b> The WCM property to set.
///    pReserved = Type: <b>PVOID</b> Reserved.
///    dwDataSize = Type: <b>DWORD</b> The size of the new property value.
///    pbData = Type: <b>const BYTE*</b> The new property value.
///Returns:
///    Type: <b>DWORD</b> Returns ERROR_SUCCESS if successful, or an error value otherwise.
///    
@DllImport("wcmapi")
uint WcmSetProperty(const(GUID)* pInterface, const(wchar)* strProfileName, WCM_PROPERTY Property, void* pReserved, 
                    uint dwDataSize, char* pbData);

///The <b>WcmGetProfileList</b> function retrieves a list of profiles in preferred order, descending from the most
///preferred to the least preferred. The list includes all WCM-managed auto-connect profiles across all WCM-managed
///media types.
///Params:
///    pReserved = Type: <b>PVOID</b> Reserved.
///    ppProfileList = Type: <b>PWCM_PROFILE_INFO_LIST*</b> The list of profiles.
///Returns:
///    Type: <b>DWORD</b> Returns ERROR_SUCCESS if successful, or an error value otherwise.
///    
@DllImport("wcmapi")
uint WcmGetProfileList(void* pReserved, WCM_PROFILE_INFO_LIST** ppProfileList);

///The <b>WcmSetProfileList</b> function reorders a profile list or a subset of a profile list.
///Params:
///    pProfileList = Type: <b>WCM_PROFILE_INFO_LIST*</b> The list of profiles to be reordered, provided in the preferred order
///                   (descending from the most preferred to the least preferred).
///    dwPosition = Type: <b>DWORD</b> Specifies the position in the list to start the reorder.
///    fIgnoreUnknownProfiles = Type: <b>BOOL</b> True if any profiles in <i>pProfileList</i> which do not exist should be ignored; the call will
///                             proceed with the remainder of the list. False if the call should fail without modifying the profile order if any
///                             profiles in <i>pProfileList</i> do not exist.
///    pReserved = Type: <b>PVOID</b> Reserved.
///Returns:
///    Type: <b>DWORD</b> Returns ERROR_SUCCESS if successful, or an error value otherwise.
///    
@DllImport("wcmapi")
uint WcmSetProfileList(WCM_PROFILE_INFO_LIST* pProfileList, uint dwPosition, BOOL fIgnoreUnknownProfiles, 
                       void* pReserved);

///The <b>WcmFreeMemory</b> function is used to release memory resources allocated by the WCM functions.
@DllImport("wcmapi")
void WcmFreeMemory(void* pMemory);


