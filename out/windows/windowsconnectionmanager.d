module windows.windowsconnectionmanager;

public import system;
public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

enum WCM_PROPERTY
{
    wcm_global_property_domain_policy = 0,
    wcm_global_property_minimize_policy = 1,
    wcm_global_property_roaming_policy = 2,
    wcm_global_property_powermanagement_policy = 3,
    wcm_intf_property_connection_cost = 4,
    wcm_intf_property_dataplan_status = 5,
    wcm_intf_property_hotspot_profile = 6,
}

enum WCM_MEDIA_TYPE
{
    wcm_media_unknown = 0,
    wcm_media_ethernet = 1,
    wcm_media_wlan = 2,
    wcm_media_mbn = 3,
    wcm_media_invalid = 4,
    wcm_media_max = 5,
}

struct WCM_POLICY_VALUE
{
    BOOL fValue;
    BOOL fIsGroupPolicy;
}

struct WCM_PROFILE_INFO
{
    ushort strProfileName;
    Guid AdapterGUID;
    WCM_MEDIA_TYPE Media;
}

struct WCM_PROFILE_INFO_LIST
{
    uint dwNumberOfItems;
    WCM_PROFILE_INFO ProfileInfo;
}

enum WCM_CONNECTION_COST
{
    WCM_CONNECTION_COST_UNKNOWN = 0,
    WCM_CONNECTION_COST_UNRESTRICTED = 1,
    WCM_CONNECTION_COST_FIXED = 2,
    WCM_CONNECTION_COST_VARIABLE = 4,
    WCM_CONNECTION_COST_OVERDATALIMIT = 65536,
    WCM_CONNECTION_COST_CONGESTED = 131072,
    WCM_CONNECTION_COST_ROAMING = 262144,
    WCM_CONNECTION_COST_APPROACHINGDATALIMIT = 524288,
}

enum WCM_CONNECTION_COST_SOURCE
{
    WCM_CONNECTION_COST_SOURCE_DEFAULT = 0,
    WCM_CONNECTION_COST_SOURCE_GP = 1,
    WCM_CONNECTION_COST_SOURCE_USER = 2,
    WCM_CONNECTION_COST_SOURCE_OPERATOR = 3,
}

struct WCM_CONNECTION_COST_DATA
{
    uint ConnectionCost;
    WCM_CONNECTION_COST_SOURCE CostSource;
}

struct WCM_TIME_INTERVAL
{
    ushort wYear;
    ushort wMonth;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wMilliseconds;
}

struct WCM_USAGE_DATA
{
    uint UsageInMegabytes;
    FILETIME LastSyncTime;
}

struct WCM_BILLING_CYCLE_INFO
{
    FILETIME StartDate;
    WCM_TIME_INTERVAL Duration;
    BOOL Reset;
}

struct WCM_DATAPLAN_STATUS
{
    WCM_USAGE_DATA UsageData;
    uint DataLimitInMegabytes;
    uint InboundBandwidthInKbps;
    uint OutboundBandwidthInKbps;
    WCM_BILLING_CYCLE_INFO BillingCycle;
    uint MaxTransferSizeInMegabytes;
    uint Reserved;
}

@DllImport("wcmapi.dll")
uint WcmQueryProperty(const(Guid)* pInterface, const(wchar)* strProfileName, WCM_PROPERTY Property, void* pReserved, uint* pdwDataSize, ubyte** ppData);

@DllImport("wcmapi.dll")
uint WcmSetProperty(const(Guid)* pInterface, const(wchar)* strProfileName, WCM_PROPERTY Property, void* pReserved, uint dwDataSize, char* pbData);

@DllImport("wcmapi.dll")
uint WcmGetProfileList(void* pReserved, WCM_PROFILE_INFO_LIST** ppProfileList);

@DllImport("wcmapi.dll")
uint WcmSetProfileList(WCM_PROFILE_INFO_LIST* pProfileList, uint dwPosition, BOOL fIgnoreUnknownProfiles, void* pReserved);

@DllImport("wcmapi.dll")
void WcmFreeMemory(void* pMemory);

