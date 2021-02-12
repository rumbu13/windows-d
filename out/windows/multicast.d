module windows.multicast;

public import windows.security;
public import windows.systemservices;

extern(Windows):

struct IPNG_ADDRESS
{
    uint IpAddrV4;
    ubyte IpAddrV6;
}

struct MCAST_CLIENT_UID
{
    ubyte* ClientUID;
    uint ClientUIDLength;
}

struct MCAST_SCOPE_CTX
{
    IPNG_ADDRESS ScopeID;
    IPNG_ADDRESS Interface;
    IPNG_ADDRESS ServerID;
}

struct MCAST_SCOPE_ENTRY
{
    MCAST_SCOPE_CTX ScopeCtx;
    IPNG_ADDRESS LastAddr;
    uint TTL;
    UNICODE_STRING ScopeDesc;
}

struct MCAST_LEASE_REQUEST
{
    int LeaseStartTime;
    int MaxLeaseStartTime;
    uint LeaseDuration;
    uint MinLeaseDuration;
    IPNG_ADDRESS ServerAddress;
    ushort MinAddrCount;
    ushort AddrCount;
    ubyte* pAddrBuf;
}

struct MCAST_LEASE_RESPONSE
{
    int LeaseStartTime;
    int LeaseEndTime;
    IPNG_ADDRESS ServerAddress;
    ushort AddrCount;
    ubyte* pAddrBuf;
}

@DllImport("dhcpcsvc.dll")
uint McastApiStartup(uint* Version);

@DllImport("dhcpcsvc.dll")
void McastApiCleanup();

@DllImport("dhcpcsvc.dll")
uint McastGenUID(MCAST_CLIENT_UID* pRequestID);

@DllImport("dhcpcsvc.dll")
uint McastEnumerateScopes(ushort AddrFamily, BOOL ReQuery, MCAST_SCOPE_ENTRY* pScopeList, uint* pScopeLen, uint* pScopeCount);

@DllImport("dhcpcsvc.dll")
uint McastRequestAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_SCOPE_CTX* pScopeCtx, MCAST_LEASE_REQUEST* pAddrRequest, MCAST_LEASE_RESPONSE* pAddrResponse);

@DllImport("dhcpcsvc.dll")
uint McastRenewAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_LEASE_REQUEST* pRenewRequest, MCAST_LEASE_RESPONSE* pRenewResponse);

@DllImport("dhcpcsvc.dll")
uint McastReleaseAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_LEASE_REQUEST* pReleaseRequest);

