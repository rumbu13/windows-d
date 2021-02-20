// Written in the D programming language.

module windows.multicast;

public import windows.core;
public import windows.security : UNICODE_STRING;
public import windows.systemservices : BOOL;

extern(Windows) @nogc nothrow:


// Constants


enum : int
{
    MCAST_API_VERSION_0 = 0x00000000,
    MCAST_API_VERSION_1 = 0x00000001,
}

// Structs


///The <b>IPNG_ADDRESS</b> union provides Internet Protocol version 4 (IPv4) and Internet Protocol version 6 (IPv6)
///addresses.
union IPNG_ADDRESS
{
    ///Internet Protocol (IP) address, in version 4 format (IPv4).
    uint      IpAddrV4;
    ///Internet Protocol (IP) address, in version 6 format (IPv6).
    ubyte[16] IpAddrV6;
}

///The <b>MCAST_CLIENT_UID</b> structure describes the unique client identifier for each multicast request.
struct MCAST_CLIENT_UID
{
    ///Buffer containing the unique client identifier.
    ubyte* ClientUID;
    ///Size of the <b>ClientUID</b> member, in bytes.
    uint   ClientUIDLength;
}

///The <b>MCAST_SCOPE_CTX</b> structure defines the scope context for programmatic interaction with multicast addresses.
///The <b>MCAST_SCOPE_CTX</b> structure is used by various MADCAP functions as a handle for allocating, renewing, or
///releasing MADCAP addresses.
struct MCAST_SCOPE_CTX
{
    ///Identifier for the multicast scope, in the form of an IPNG_ADDRESS structure.
    IPNG_ADDRESS ScopeID;
    ///Interface on which the multicast scope is available, in the form of an IPNG_ADDRESS structure.
    IPNG_ADDRESS Interface;
    ///Internet Protocol (IP) address of the MADCAP server, in the form of an IPNG_ADDRESS structure.
    IPNG_ADDRESS ServerID;
}

///The <b>MCAST_SCOPE_ENTRY</b> structure provides a complete set of information about a given multicast scope.
struct MCAST_SCOPE_ENTRY
{
    ///Handle for the multicast scope, in the form of an MCAST_SCOPE_CTX structure.
    MCAST_SCOPE_CTX ScopeCtx;
    ///Internet Protocol (IP) address of the last address in the scope, in the form of an IPNG_ADDRESS structure.
    IPNG_ADDRESS    LastAddr;
    ///Time To Live (TTL) value of the scope.
    uint            TTL;
    ///Description of the scope, in human readable, user-friendly format.
    UNICODE_STRING  ScopeDesc;
}

///The <b>MCAST_LEASE_REQUEST</b> structure defines the request, renew, or release parameters for a given multicast
///scope. In the MCAST_API_VERSION_1 implementation, only one IP address may be allocated at a time.
struct MCAST_LEASE_REQUEST
{
    ///Requested start time, in seconds, for the multicast scope lease elapsed since midnight of January 1, 1970,
    ///coordinated universal time. To request the current time as the lease start time, set <b>LeaseStartTime</b> to
    ///zero.
    int          LeaseStartTime;
    ///Maximum start time, in seconds, elapsed since midnight of January 1, 1970, coordinated universal time, that the
    ///client is willing to accept.
    int          MaxLeaseStartTime;
    ///Duration of the lease request, in seconds. To request the default lease duration, set both <b>LeaseDuration</b>
    ///and <b>MinLeaseDuration</b> to zero.
    uint         LeaseDuration;
    ///Minimum lease duration, in seconds, that the client is willing to accept.
    uint         MinLeaseDuration;
    ///Internet Protocol (IP) address of the server on which the lease is to be requested or renewed, in the form of an
    ///IPNG_ADDRESS structure. If the IP address of the server is unknown, such as when using this structure in an
    ///McastRequestAddress function call, set <b>ServerAddress</b> to zero.
    IPNG_ADDRESS ServerAddress;
    ///Minimum number of IP addresses the client is willing to accept.
    ushort       MinAddrCount;
    ///Number of requested IP addresses. Note that the value of this member dictates the size of <b>pAddrBuf</b>.
    ushort       AddrCount;
    ///Pointer to a buffer containing the requested IP addresses. For IPv4 addresses, the <b>pAddrBuf</b> member points
    ///to 4-byte addresses; for IPv6 addresses, the <b>pAddrBuf</b> member points to 16-byte addresses. If no specific
    ///addresses are requested, set <b>pAddrBuf</b> to <b>NULL</b>.
    ubyte*       pAddrBuf;
}

///The <b>MCAST_LEASE_RESPONSE</b> structure is used to respond to multicast lease requests.
struct MCAST_LEASE_RESPONSE
{
    ///Start time, in seconds, for the multicast scope lease elapsed since midnight of January 1, 1970, coordinated
    ///universal time.
    int          LeaseStartTime;
    ///Expiration time, in seconds of the multicast scope lease elapsed since midnight of January 1, 1970, coordinated
    ///universal time.
    int          LeaseEndTime;
    ///Internet Protocol (IP) address of the server on which the lease request has been granted or renewed, in the form
    ///of an IPNG_ADDRESS structure.
    IPNG_ADDRESS ServerAddress;
    ///Number of IP addresses that are granted or renewed with the lease. Note that the value of this member dictates
    ///the size of <b>pAddrBuf</b>.
    ushort       AddrCount;
    ///Pointer to a buffer containing the granted IP addresses. For IPv4 addresses, the <b>pAddrBuf</b> member points to
    ///4-byte addresses; for IPv6 addresses, the <b>pAddrBuf</b> member points to 16-byte addresses.
    ubyte*       pAddrBuf;
}

// Functions

///The <b>McastApiStartup</b> function facilitates MADCAP-version negotiation between requesting clients and the version
///of MADCAP implemented on the system. Calling <b>McastApiStartup</b> allocates necessary resources; it must be called
///before any other MADCAP client functions are called.
///Params:
///    Version = Pointer to the version of multicast (MCAST) that the client wishes to use. [out] Pointer to the version of MCAST
///              implemented on the system.
///Returns:
///    If the client requests a version of MADCAP that is not supported by the system, the <b>McastApiStartup</b>
///    function returns ERROR_NOT_SUPPORTED. If resources fail to be allocated for the function call,
///    ERROR_NO_SYSTEM_RESOURCES is returned.
///    
@DllImport("dhcpcsvc")
uint McastApiStartup(uint* Version);

///The <b>McastApiCleanup</b> function deallocates resources that are allocated with McastApiStartup. The
///<b>McastApiCleanup</b> function must only be called after a successful call to <b>McastApiStartup</b>.
@DllImport("dhcpcsvc")
void McastApiCleanup();

///The <b>McastGenUID</b> function generates a unique identifier, subsequently used by clients to request and renew
///addresses.
///Params:
///    pRequestID = Pointer to the MCAST_CLIENT_UID structure into which the unique identifier is stored. The size of the buffer to
///                 which <i>pRequestID</i> points must be at least MCAST_CLIENT_ID_LEN in size.
///Returns:
///    The <b>McastGenUID</b> function returns the status of the operation.
///    
@DllImport("dhcpcsvc")
uint McastGenUID(MCAST_CLIENT_UID* pRequestID);

///The <b>McastEnumerateScopes</b> function enumerates multicast scopes available on the network.
///Params:
///    AddrFamily = Specifies the address family to be used in enumeration, in the form of an IPNG_ADDRESS structure. Use AF_INET for
///                 IPv4 addresses and AF_INET6 for IPv6 addresses.
///    ReQuery = Enables a caller to query a list again. Set this parameter to <b>TRUE</b> if the list is to be queried more than
///              once. Otherwise, set it to <b>FALSE</b>.
///    pScopeList = Pointer to a buffer used for storing scope list information, in the form of an MCAST_SCOPE_ENTRY structure. The
///                 return value of <i>pScopeList</i> depends on its input value, and on the value of the buffer to which it points:
///                 If <i>pScopeList</i> is a valid pointer on input, the scope list is returned. If <i>pScopeList</i> is <b>NULL</b>
///                 on input, the length of the buffer required to hold the scope list is returned. If the buffer pointed to in
///                 <i>pScopeList</i> is <b>NULL</b> on input, <b>McastEnumerateScopes</b> forces a repeat querying of scope lists
///                 from MCAST servers. To determine the size of buffer required to hold scope list data, set <i>pScopeList</i> to
///                 <b>NULL</b> and <i>pScopeLen</i> to a non-<b>NULL</b> value. The <b>McastEnumerateScopes</b> function will then
///                 return ERROR_SUCCESS and store the size of the scope list data, in bytes, in <i>pScopeLen</i>.
///    pScopeLen = Pointer to a value used to communicate the size of data or buffer space in <i>pScopeList</i>. On input,
///                <i>pScopeLen</i> points to the size, in bytes, of the buffer pointed to by <i>pScopeList</i>. On return,
///                <i>pScopeLen</i> points to the size of the data copied to <i>pScopeList</i>. The <i>pScopeLen</i> parameter
///                cannot be <b>NULL</b>. If the buffer pointed to by <i>pScopeList</i> is not large enough to hold the scope list
///                data, <b>McastEnumerateScopes</b> returns ERROR_MORE_DATA and stores the required buffer size, in bytes, in
///                <i>pScopeLen</i>. To determine the size of buffer required to hold scope list data, set <i>pScopeList</i> to
///                <b>NULL</b> and <i>pScopeLen</i> to a non-<b>NULL</b> value. The <b>McastEnumerateScopes</b> function will then
///                return ERROR_SUCCESS and store the size of the scope list data, in bytes, in <i>pScopeLen</i>.
///    pScopeCount = Pointer to the number of scopes returned in <i>pScopeList</i>.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the buffer pointed to by <i>pScopeList</i> is too small to
///    hold the scope list, the <b>McastEnumerateScopes</b> function returns ERROR_MORE_DATA, and stores the required
///    buffer size, in bytes, in <i>pScopeLen</i>. If the McastApiStartup function has not been called (it must be
///    called before any other MADCAP client functions may be called), the <b>McastEnumerateScopes</b> function returns
///    ERROR_NOT_READY.
///    
@DllImport("dhcpcsvc")
uint McastEnumerateScopes(ushort AddrFamily, BOOL ReQuery, MCAST_SCOPE_ENTRY* pScopeList, uint* pScopeLen, 
                          uint* pScopeCount);

///The <b>McastRequestAddress</b> function requests one or more multicast addresses from a MADCAP server.
///Params:
///    AddrFamily = Specifies the address family to be used in the request, in the form of an IPNG_ADDRESS structure. Use AF_INET for
///                 IPv4 addresses and AF_INET6 for IPv6 addresses.
///    pRequestID = Pointer to a unique identifier for the request, in the form of an MCAST_CLIENT_UID structure. Clients are
///                 responsible for ensuring that each request contains a unique identifier; unique identifiers can be obtained by
///                 calling the McastGenUID function.
///    pScopeCtx = Pointer to the context of the scope from which the address is to be allocated, in the form of an MCAST_SCOPE_CTX
///                structure. The scope context must be retrieved by calling the McastEnumerateScopes function prior to calling the
///                <b>McastRequestAddress</b> function.
///    pAddrRequest = Pointer to the MCAST_LEASE_REQUEST structure containing multicast lease–request parameters.
///    pAddrResponse = Pointer to a buffer containing response parameters for the multicast address request, in the form of an
///                    MCAST_LEASE_RESPONSE structure. The caller is responsible for allocating sufficient buffer space for the
///                    <i>pAddrBuf</i> member of the <b>MCAST_LEASE_RESPONSE</b> structure to hold the requested number of addresses;
///                    the caller is also responsible for setting the pointer to that buffer.
///Returns:
///    The <b>McastRequestAddress</b> function returns the status of the operation.
///    
@DllImport("dhcpcsvc")
uint McastRequestAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_SCOPE_CTX* pScopeCtx, 
                         MCAST_LEASE_REQUEST* pAddrRequest, MCAST_LEASE_RESPONSE* pAddrResponse);

///The <b>McastRenewAddress</b> function renews one or more multicast addresses from a MADCAP server.
///Params:
///    AddrFamily = Designates the address family. Use AF_INET for Internet Protocol version 4 (IPv4), and AF_INET6 for Internet
///                 Protocol version 6 (IPv6).
///    pRequestID = Unique identifier used when the address or addresses were initially obtained.
///    pRenewRequest = Pointer to the MCAST_LEASE_REQUEST structure containing multicast renew–request parameters.
///    pRenewResponse = Pointer to a buffer containing response parameters for the multicast address–renew request, in the form of an
///                     MCAST_LEASE_RESPONSE structure. The caller is responsible for allocating sufficient buffer space for the
///                     <b>pAddrBuf</b> member of the <b>MCAST_LEASE_RESPONSE</b> structure to hold the requested number of addresses;
///                     the caller is also responsible for setting the pointer to that buffer.
///Returns:
///    The <b>McastRenewAddress</b> function returns the status of the operation.
///    
@DllImport("dhcpcsvc")
uint McastRenewAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_LEASE_REQUEST* pRenewRequest, 
                       MCAST_LEASE_RESPONSE* pRenewResponse);

///The <b>McastReleaseAddress</b> function releases leased multicast addresses from the MCAST server.
///Params:
///    AddrFamily = Designates the address family. Use AF_INET for Internet Protocol version 4 (IPv4), and AF_INET6 for Internet
///                 Protocol version 6 (IPv6).
///    pRequestID = Unique identifier used when the address or addresses were initially obtained.
///    pReleaseRequest = Pointer to the MCAST_LEASE_REQUEST structure containing multicast parameters associated with the release request.
///Returns:
///    The <b>McastReleaseAddress</b> function returns the status of the operation.
///    
@DllImport("dhcpcsvc")
uint McastReleaseAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_LEASE_REQUEST* pReleaseRequest);


