module windows.multicast;

public import windows.core;
public import windows.security : UNICODE_STRING;
public import windows.systemservices : BOOL;

extern(Windows):


// Constants


enum : int
{
    MCAST_API_VERSION_0 = 0x00000000,
    MCAST_API_VERSION_1 = 0x00000001,
}

// Structs


union IPNG_ADDRESS
{
    uint      IpAddrV4;
    ubyte[16] IpAddrV6;
}

struct MCAST_CLIENT_UID
{
    ubyte* ClientUID;
    uint   ClientUIDLength;
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
    IPNG_ADDRESS    LastAddr;
    uint            TTL;
    UNICODE_STRING  ScopeDesc;
}

struct MCAST_LEASE_REQUEST
{
    int          LeaseStartTime;
    int          MaxLeaseStartTime;
    uint         LeaseDuration;
    uint         MinLeaseDuration;
    IPNG_ADDRESS ServerAddress;
    ushort       MinAddrCount;
    ushort       AddrCount;
    ubyte*       pAddrBuf;
}

struct MCAST_LEASE_RESPONSE
{
    int          LeaseStartTime;
    int          LeaseEndTime;
    IPNG_ADDRESS ServerAddress;
    ushort       AddrCount;
    ubyte*       pAddrBuf;
}

// Functions

@DllImport("dhcpcsvc")
uint McastApiStartup(uint* Version);

@DllImport("dhcpcsvc")
void McastApiCleanup();

@DllImport("dhcpcsvc")
uint McastGenUID(MCAST_CLIENT_UID* pRequestID);

@DllImport("dhcpcsvc")
uint McastEnumerateScopes(ushort AddrFamily, BOOL ReQuery, MCAST_SCOPE_ENTRY* pScopeList, uint* pScopeLen, 
                          uint* pScopeCount);

@DllImport("dhcpcsvc")
uint McastRequestAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_SCOPE_CTX* pScopeCtx, 
                         MCAST_LEASE_REQUEST* pAddrRequest, MCAST_LEASE_RESPONSE* pAddrResponse);

@DllImport("dhcpcsvc")
uint McastRenewAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_LEASE_REQUEST* pRenewRequest, 
                       MCAST_LEASE_RESPONSE* pRenewResponse);

@DllImport("dhcpcsvc")
uint McastReleaseAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_LEASE_REQUEST* pReleaseRequest);


