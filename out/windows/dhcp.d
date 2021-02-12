module windows.dhcp;

public import windows.systemservices;

extern(Windows):

struct DHCPV6CAPI_PARAMS
{
    uint Flags;
    uint OptionId;
    BOOL IsVendor;
    ubyte* Data;
    uint nBytesData;
}

struct DHCPV6CAPI_PARAMS_ARRAY
{
    uint nParams;
    DHCPV6CAPI_PARAMS* Params;
}

struct DHCPV6CAPI_CLASSID
{
    uint Flags;
    ubyte* Data;
    uint nBytesData;
}

enum StatusCode
{
    STATUS_NO_ERROR = 0,
    STATUS_UNSPECIFIED_FAILURE = 1,
    STATUS_NO_BINDING = 3,
    STATUS_NOPREFIX_AVAIL = 6,
}

struct DHCPV6Prefix
{
    ubyte prefix;
    uint prefixLength;
    uint preferredLifeTime;
    uint validLifeTime;
    StatusCode status;
}

struct DHCPV6PrefixLeaseInformation
{
    uint nPrefixes;
    DHCPV6Prefix* prefixArray;
    uint iaid;
    long T1;
    long T2;
    long MaxLeaseExpirationTime;
    long LastRenewalTime;
    StatusCode status;
    ubyte* ServerId;
    uint ServerIdLen;
}

struct DHCPAPI_PARAMS
{
    uint Flags;
    uint OptionId;
    BOOL IsVendor;
    ubyte* Data;
    uint nBytesData;
}

struct DHCPCAPI_PARAMS_ARRAY
{
    uint nParams;
    DHCPAPI_PARAMS* Params;
}

struct DHCPCAPI_CLASSID
{
    uint Flags;
    ubyte* Data;
    uint nBytesData;
}

struct DHCP_SERVER_OPTIONS
{
    ubyte* MessageType;
    uint* SubnetMask;
    uint* RequestedAddress;
    uint* RequestLeaseTime;
    ubyte* OverlayFields;
    uint* RouterAddress;
    uint* Server;
    ubyte* ParameterRequestList;
    uint ParameterRequestListLength;
    byte* MachineName;
    uint MachineNameLength;
    ubyte ClientHardwareAddressType;
    ubyte ClientHardwareAddressLength;
    ubyte* ClientHardwareAddress;
    byte* ClassIdentifier;
    uint ClassIdentifierLength;
    ubyte* VendorClass;
    uint VendorClassLength;
    uint DNSFlags;
    uint DNSNameLength;
    ubyte* DNSName;
    ubyte DSDomainNameRequested;
    byte* DSDomainName;
    uint DSDomainNameLen;
    uint* ScopeId;
}

alias LPDHCP_CONTROL = extern(Windows) uint function(uint dwControlCode, void* lpReserved);
alias LPDHCP_NEWPKT = extern(Windows) uint function(ubyte** Packet, uint* PacketSize, uint IpAddress, void* Reserved, void** PktContext, int* ProcessIt);
alias LPDHCP_DROP_SEND = extern(Windows) uint function(ubyte** Packet, uint* PacketSize, uint ControlCode, uint IpAddress, void* Reserved, void* PktContext);
alias LPDHCP_PROB = extern(Windows) uint function(ubyte* Packet, uint PacketSize, uint ControlCode, uint IpAddress, uint AltAddress, void* Reserved, void* PktContext);
alias LPDHCP_GIVE_ADDRESS = extern(Windows) uint function(ubyte* Packet, uint PacketSize, uint ControlCode, uint IpAddress, uint AltAddress, uint AddrType, uint LeaseTime, void* Reserved, void* PktContext);
alias LPDHCP_HANDLE_OPTIONS = extern(Windows) uint function(ubyte* Packet, uint PacketSize, void* Reserved, void* PktContext, DHCP_SERVER_OPTIONS* ServerOptions);
alias LPDHCP_DELETE_CLIENT = extern(Windows) uint function(uint IpAddress, ubyte* HwAddress, uint HwAddressLength, uint Reserved, uint ClientType);
struct DHCP_CALLOUT_TABLE
{
    LPDHCP_CONTROL DhcpControlHook;
    LPDHCP_NEWPKT DhcpNewPktHook;
    LPDHCP_DROP_SEND DhcpPktDropHook;
    LPDHCP_DROP_SEND DhcpPktSendHook;
    LPDHCP_PROB DhcpAddressDelHook;
    LPDHCP_GIVE_ADDRESS DhcpAddressOfferHook;
    LPDHCP_HANDLE_OPTIONS DhcpHandleOptionsHook;
    LPDHCP_DELETE_CLIENT DhcpDeleteClientHook;
    void* DhcpExtensionHook;
    void* DhcpReservedHook;
}

alias LPDHCP_ENTRY_POINT_FUNC = extern(Windows) uint function(const(wchar)* ChainDlls, uint CalloutVersion, DHCP_CALLOUT_TABLE* CalloutTbl);
struct DATE_TIME
{
    uint dwLowDateTime;
    uint dwHighDateTime;
}

struct DHCP_IP_RANGE
{
    uint StartAddress;
    uint EndAddress;
}

struct DHCP_BINARY_DATA
{
    uint DataLength;
    ubyte* Data;
}

struct DHCP_HOST_INFO
{
    uint IpAddress;
    const(wchar)* NetBiosName;
    const(wchar)* HostName;
}

enum DHCP_FORCE_FLAG
{
    DhcpFullForce = 0,
    DhcpNoForce = 1,
    DhcpFailoverForce = 2,
}

struct DWORD_DWORD
{
    uint DWord1;
    uint DWord2;
}

enum DHCP_SUBNET_STATE
{
    DhcpSubnetEnabled = 0,
    DhcpSubnetDisabled = 1,
    DhcpSubnetEnabledSwitched = 2,
    DhcpSubnetDisabledSwitched = 3,
    DhcpSubnetInvalidState = 4,
}

struct DHCP_SUBNET_INFO
{
    uint SubnetAddress;
    uint SubnetMask;
    const(wchar)* SubnetName;
    const(wchar)* SubnetComment;
    DHCP_HOST_INFO PrimaryHost;
    DHCP_SUBNET_STATE SubnetState;
}

struct DHCP_SUBNET_INFO_VQ
{
    uint SubnetAddress;
    uint SubnetMask;
    const(wchar)* SubnetName;
    const(wchar)* SubnetComment;
    DHCP_HOST_INFO PrimaryHost;
    DHCP_SUBNET_STATE SubnetState;
    uint QuarantineOn;
    uint Reserved1;
    uint Reserved2;
    long Reserved3;
    long Reserved4;
}

struct DHCP_IP_ARRAY
{
    uint NumElements;
    uint* Elements;
}

struct DHCP_IP_CLUSTER
{
    uint ClusterAddress;
    uint ClusterMask;
}

struct DHCP_IP_RESERVATION
{
    uint ReservedIpAddress;
    DHCP_BINARY_DATA* ReservedForClient;
}

enum DHCP_SUBNET_ELEMENT_TYPE
{
    DhcpIpRanges = 0,
    DhcpSecondaryHosts = 1,
    DhcpReservedIps = 2,
    DhcpExcludedIpRanges = 3,
    DhcpIpUsedClusters = 4,
    DhcpIpRangesDhcpOnly = 5,
    DhcpIpRangesDhcpBootp = 6,
    DhcpIpRangesBootpOnly = 7,
}

struct DHCP_SUBNET_ELEMENT_DATA
{
    DHCP_SUBNET_ELEMENT_TYPE ElementType;
    DHCP_SUBNET_ELEMENT_UNION Element;
}

struct DHCP_SUBNET_ELEMENT_UNION
{
}

struct DHCP_SUBNET_ELEMENT_INFO_ARRAY
{
    uint NumElements;
    DHCP_SUBNET_ELEMENT_DATA* Elements;
}

struct DHCP_IPV6_ADDRESS
{
    ulong HighOrderBits;
    ulong LowOrderBits;
}

enum DHCP_FILTER_LIST_TYPE
{
    Deny = 0,
    Allow = 1,
}

struct DHCP_ADDR_PATTERN
{
    BOOL MatchHWType;
    ubyte HWType;
    BOOL IsWildcard;
    ubyte Length;
    ubyte Pattern;
}

struct DHCP_FILTER_ADD_INFO
{
    DHCP_ADDR_PATTERN AddrPatt;
    const(wchar)* Comment;
    DHCP_FILTER_LIST_TYPE ListType;
}

struct DHCP_FILTER_GLOBAL_INFO
{
    BOOL EnforceAllowList;
    BOOL EnforceDenyList;
}

struct DHCP_FILTER_RECORD
{
    DHCP_ADDR_PATTERN AddrPatt;
    const(wchar)* Comment;
}

struct DHCP_FILTER_ENUM_INFO
{
    uint NumElements;
    DHCP_FILTER_RECORD* pEnumRecords;
}

enum DHCP_OPTION_DATA_TYPE
{
    DhcpByteOption = 0,
    DhcpWordOption = 1,
    DhcpDWordOption = 2,
    DhcpDWordDWordOption = 3,
    DhcpIpAddressOption = 4,
    DhcpStringDataOption = 5,
    DhcpBinaryDataOption = 6,
    DhcpEncapsulatedDataOption = 7,
    DhcpIpv6AddressOption = 8,
}

struct DHCP_OPTION_DATA_ELEMENT
{
    DHCP_OPTION_DATA_TYPE OptionType;
    DHCP_OPTION_ELEMENT_UNION Element;
}

struct DHCP_OPTION_ELEMENT_UNION
{
}

struct DHCP_OPTION_DATA
{
    uint NumElements;
    DHCP_OPTION_DATA_ELEMENT* Elements;
}

enum DHCP_OPTION_TYPE
{
    DhcpUnaryElementTypeOption = 0,
    DhcpArrayTypeOption = 1,
}

struct DHCP_OPTION
{
    uint OptionID;
    const(wchar)* OptionName;
    const(wchar)* OptionComment;
    DHCP_OPTION_DATA DefaultValue;
    DHCP_OPTION_TYPE OptionType;
}

struct DHCP_OPTION_ARRAY
{
    uint NumElements;
    DHCP_OPTION* Options;
}

struct DHCP_OPTION_VALUE
{
    uint OptionID;
    DHCP_OPTION_DATA Value;
}

struct DHCP_OPTION_VALUE_ARRAY
{
    uint NumElements;
    DHCP_OPTION_VALUE* Values;
}

enum DHCP_OPTION_SCOPE_TYPE
{
    DhcpDefaultOptions = 0,
    DhcpGlobalOptions = 1,
    DhcpSubnetOptions = 2,
    DhcpReservedOptions = 3,
    DhcpMScopeOptions = 4,
}

struct DHCP_RESERVED_SCOPE
{
    uint ReservedIpAddress;
    uint ReservedIpSubnetAddress;
}

struct DHCP_OPTION_SCOPE_INFO
{
    DHCP_OPTION_SCOPE_TYPE ScopeType;
    _DHCP_OPTION_SCOPE_UNION ScopeInfo;
}

enum DHCP_OPTION_SCOPE_TYPE6
{
    DhcpDefaultOptions6 = 0,
    DhcpScopeOptions6 = 1,
    DhcpReservedOptions6 = 2,
    DhcpGlobalOptions6 = 3,
}

struct DHCP_RESERVED_SCOPE6
{
    DHCP_IPV6_ADDRESS ReservedIpAddress;
    DHCP_IPV6_ADDRESS ReservedIpSubnetAddress;
}

struct DHCP_OPTION_SCOPE_INFO6
{
    DHCP_OPTION_SCOPE_TYPE6 ScopeType;
    DHCP_OPTION_SCOPE_UNION6 ScopeInfo;
}

struct DHCP_OPTION_SCOPE_UNION6
{
}

struct DHCP_OPTION_LIST
{
    uint NumOptions;
    DHCP_OPTION_VALUE* Options;
}

struct DHCP_CLIENT_INFO
{
    uint ClientIpAddress;
    uint SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)* ClientName;
    const(wchar)* ClientComment;
    DATE_TIME ClientLeaseExpires;
    DHCP_HOST_INFO OwnerHost;
}

struct DHCP_CLIENT_INFO_ARRAY
{
    uint NumElements;
    DHCP_CLIENT_INFO** Clients;
}

enum QuarantineStatus
{
    NOQUARANTINE = 0,
    RESTRICTEDACCESS = 1,
    DROPPACKET = 2,
    PROBATION = 3,
    EXEMPT = 4,
    DEFAULTQUARSETTING = 5,
    NOQUARINFO = 6,
}

struct DHCP_CLIENT_INFO_VQ
{
    uint ClientIpAddress;
    uint SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)* ClientName;
    const(wchar)* ClientComment;
    DATE_TIME ClientLeaseExpires;
    DHCP_HOST_INFO OwnerHost;
    ubyte bClientType;
    ubyte AddressState;
    QuarantineStatus Status;
    DATE_TIME ProbationEnds;
    BOOL QuarantineCapable;
}

struct DHCP_CLIENT_INFO_ARRAY_VQ
{
    uint NumElements;
    DHCP_CLIENT_INFO_VQ** Clients;
}

struct DHCP_CLIENT_FILTER_STATUS_INFO
{
    uint ClientIpAddress;
    uint SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)* ClientName;
    const(wchar)* ClientComment;
    DATE_TIME ClientLeaseExpires;
    DHCP_HOST_INFO OwnerHost;
    ubyte bClientType;
    ubyte AddressState;
    QuarantineStatus Status;
    DATE_TIME ProbationEnds;
    BOOL QuarantineCapable;
    uint FilterStatus;
}

struct DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY
{
    uint NumElements;
    DHCP_CLIENT_FILTER_STATUS_INFO** Clients;
}

struct DHCP_CLIENT_INFO_PB
{
    uint ClientIpAddress;
    uint SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)* ClientName;
    const(wchar)* ClientComment;
    DATE_TIME ClientLeaseExpires;
    DHCP_HOST_INFO OwnerHost;
    ubyte bClientType;
    ubyte AddressState;
    QuarantineStatus Status;
    DATE_TIME ProbationEnds;
    BOOL QuarantineCapable;
    uint FilterStatus;
    const(wchar)* PolicyName;
}

struct DHCP_CLIENT_INFO_PB_ARRAY
{
    uint NumElements;
    DHCP_CLIENT_INFO_PB** Clients;
}

enum DHCP_SEARCH_INFO_TYPE
{
    DhcpClientIpAddress = 0,
    DhcpClientHardwareAddress = 1,
    DhcpClientName = 2,
}

struct DHCP_SEARCH_INFO
{
    DHCP_SEARCH_INFO_TYPE SearchType;
    DHCP_CLIENT_SEARCH_UNION SearchInfo;
}

struct DHCP_CLIENT_SEARCH_UNION
{
}

enum DHCP_PROPERTY_TYPE
{
    DhcpPropTypeByte = 0,
    DhcpPropTypeWord = 1,
    DhcpPropTypeDword = 2,
    DhcpPropTypeString = 3,
    DhcpPropTypeBinary = 4,
}

enum DHCP_PROPERTY_ID
{
    DhcpPropIdPolicyDnsSuffix = 0,
    DhcpPropIdClientAddressStateEx = 1,
}

struct DHCP_PROPERTY
{
    DHCP_PROPERTY_ID ID;
    DHCP_PROPERTY_TYPE Type;
    _DHCP_PROPERTY_VALUE_UNION Value;
}

struct DHCP_PROPERTY_ARRAY
{
    uint NumElements;
    DHCP_PROPERTY* Elements;
}

struct DHCP_CLIENT_INFO_EX
{
    uint ClientIpAddress;
    uint SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)* ClientName;
    const(wchar)* ClientComment;
    DATE_TIME ClientLeaseExpires;
    DHCP_HOST_INFO OwnerHost;
    ubyte bClientType;
    ubyte AddressState;
    QuarantineStatus Status;
    DATE_TIME ProbationEnds;
    BOOL QuarantineCapable;
    uint FilterStatus;
    const(wchar)* PolicyName;
    DHCP_PROPERTY_ARRAY* Properties;
}

struct DHCP_CLIENT_INFO_EX_ARRAY
{
    uint NumElements;
    DHCP_CLIENT_INFO_EX** Clients;
}

struct SCOPE_MIB_INFO
{
    uint Subnet;
    uint NumAddressesInuse;
    uint NumAddressesFree;
    uint NumPendingOffers;
}

struct DHCP_MIB_INFO
{
    uint Discovers;
    uint Offers;
    uint Requests;
    uint Acks;
    uint Naks;
    uint Declines;
    uint Releases;
    DATE_TIME ServerStartTime;
    uint Scopes;
    SCOPE_MIB_INFO* ScopeInfo;
}

struct SCOPE_MIB_INFO_VQ
{
    uint Subnet;
    uint NumAddressesInuse;
    uint NumAddressesFree;
    uint NumPendingOffers;
    uint QtnNumLeases;
    uint QtnPctQtnLeases;
    uint QtnProbationLeases;
    uint QtnNonQtnLeases;
    uint QtnExemptLeases;
    uint QtnCapableClients;
}

struct DHCP_MIB_INFO_VQ
{
    uint Discovers;
    uint Offers;
    uint Requests;
    uint Acks;
    uint Naks;
    uint Declines;
    uint Releases;
    DATE_TIME ServerStartTime;
    uint QtnNumLeases;
    uint QtnPctQtnLeases;
    uint QtnProbationLeases;
    uint QtnNonQtnLeases;
    uint QtnExemptLeases;
    uint QtnCapableClients;
    uint QtnIASErrors;
    uint Scopes;
    SCOPE_MIB_INFO_VQ* ScopeInfo;
}

struct SCOPE_MIB_INFO_V5
{
    uint Subnet;
    uint NumAddressesInuse;
    uint NumAddressesFree;
    uint NumPendingOffers;
}

struct DHCP_MIB_INFO_V5
{
    uint Discovers;
    uint Offers;
    uint Requests;
    uint Acks;
    uint Naks;
    uint Declines;
    uint Releases;
    DATE_TIME ServerStartTime;
    uint QtnNumLeases;
    uint QtnPctQtnLeases;
    uint QtnProbationLeases;
    uint QtnNonQtnLeases;
    uint QtnExemptLeases;
    uint QtnCapableClients;
    uint QtnIASErrors;
    uint DelayedOffers;
    uint ScopesWithDelayedOffers;
    uint Scopes;
    SCOPE_MIB_INFO_V5* ScopeInfo;
}

struct DHCP_SERVER_CONFIG_INFO
{
    uint APIProtocolSupport;
    const(wchar)* DatabaseName;
    const(wchar)* DatabasePath;
    const(wchar)* BackupPath;
    uint BackupInterval;
    uint DatabaseLoggingFlag;
    uint RestoreFlag;
    uint DatabaseCleanupInterval;
    uint DebugFlag;
}

enum DHCP_SCAN_FLAG
{
    DhcpRegistryFix = 0,
    DhcpDatabaseFix = 1,
}

struct DHCP_SCAN_ITEM
{
    uint IpAddress;
    DHCP_SCAN_FLAG ScanFlag;
}

struct DHCP_SCAN_LIST
{
    uint NumScanItems;
    DHCP_SCAN_ITEM* ScanItems;
}

struct DHCP_CLASS_INFO
{
    const(wchar)* ClassName;
    const(wchar)* ClassComment;
    uint ClassDataLength;
    BOOL IsVendor;
    uint Flags;
    ubyte* ClassData;
}

struct DHCP_CLASS_INFO_ARRAY
{
    uint NumElements;
    DHCP_CLASS_INFO* Classes;
}

struct DHCP_CLASS_INFO_V6
{
    const(wchar)* ClassName;
    const(wchar)* ClassComment;
    uint ClassDataLength;
    BOOL IsVendor;
    uint EnterpriseNumber;
    uint Flags;
    ubyte* ClassData;
}

struct DHCP_CLASS_INFO_ARRAY_V6
{
    uint NumElements;
    DHCP_CLASS_INFO_V6* Classes;
}

struct DHCP_SERVER_SPECIFIC_STRINGS
{
    const(wchar)* DefaultVendorClassName;
    const(wchar)* DefaultUserClassName;
}

struct DHCP_IP_RESERVATION_V4
{
    uint ReservedIpAddress;
    DHCP_BINARY_DATA* ReservedForClient;
    ubyte bAllowedClientTypes;
}

struct DHCP_IP_RESERVATION_INFO
{
    uint ReservedIpAddress;
    DHCP_BINARY_DATA ReservedForClient;
    const(wchar)* ReservedClientName;
    const(wchar)* ReservedClientDesc;
    ubyte bAllowedClientTypes;
    ubyte fOptionsPresent;
}

struct DHCP_RESERVATION_INFO_ARRAY
{
    uint NumElements;
    DHCP_IP_RESERVATION_INFO** Elements;
}

struct DHCP_SUBNET_ELEMENT_DATA_V4
{
    DHCP_SUBNET_ELEMENT_TYPE ElementType;
    DHCP_SUBNET_ELEMENT_UNION_V4 Element;
}

struct DHCP_SUBNET_ELEMENT_UNION_V4
{
}

struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4
{
    uint NumElements;
    DHCP_SUBNET_ELEMENT_DATA_V4* Elements;
}

struct DHCP_CLIENT_INFO_V4
{
    uint ClientIpAddress;
    uint SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)* ClientName;
    const(wchar)* ClientComment;
    DATE_TIME ClientLeaseExpires;
    DHCP_HOST_INFO OwnerHost;
    ubyte bClientType;
}

struct DHCP_CLIENT_INFO_ARRAY_V4
{
    uint NumElements;
    DHCP_CLIENT_INFO_V4** Clients;
}

struct DHCP_SERVER_CONFIG_INFO_V4
{
    uint APIProtocolSupport;
    const(wchar)* DatabaseName;
    const(wchar)* DatabasePath;
    const(wchar)* BackupPath;
    uint BackupInterval;
    uint DatabaseLoggingFlag;
    uint RestoreFlag;
    uint DatabaseCleanupInterval;
    uint DebugFlag;
    uint dwPingRetries;
    uint cbBootTableString;
    ushort* wszBootTableString;
    BOOL fAuditLog;
}

struct DHCP_SERVER_CONFIG_INFO_VQ
{
    uint APIProtocolSupport;
    const(wchar)* DatabaseName;
    const(wchar)* DatabasePath;
    const(wchar)* BackupPath;
    uint BackupInterval;
    uint DatabaseLoggingFlag;
    uint RestoreFlag;
    uint DatabaseCleanupInterval;
    uint DebugFlag;
    uint dwPingRetries;
    uint cbBootTableString;
    ushort* wszBootTableString;
    BOOL fAuditLog;
    BOOL QuarantineOn;
    uint QuarDefFail;
    BOOL QuarRuntimeStatus;
}

struct DHCP_SERVER_CONFIG_INFO_V6
{
    BOOL UnicastFlag;
    BOOL RapidCommitFlag;
    uint PreferredLifetime;
    uint ValidLifetime;
    uint T1;
    uint T2;
    uint PreferredLifetimeIATA;
    uint ValidLifetimeIATA;
    BOOL fAuditLog;
}

struct DHCP_SUPER_SCOPE_TABLE_ENTRY
{
    uint SubnetAddress;
    uint SuperScopeNumber;
    uint NextInSuperScope;
    const(wchar)* SuperScopeName;
}

struct DHCP_SUPER_SCOPE_TABLE
{
    uint cEntries;
    DHCP_SUPER_SCOPE_TABLE_ENTRY* pEntries;
}

struct DHCP_CLIENT_INFO_V5
{
    uint ClientIpAddress;
    uint SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)* ClientName;
    const(wchar)* ClientComment;
    DATE_TIME ClientLeaseExpires;
    DHCP_HOST_INFO OwnerHost;
    ubyte bClientType;
    ubyte AddressState;
}

struct DHCP_CLIENT_INFO_ARRAY_V5
{
    uint NumElements;
    DHCP_CLIENT_INFO_V5** Clients;
}

struct DHCP_ALL_OPTIONS
{
    uint Flags;
    DHCP_OPTION_ARRAY* NonVendorOptions;
    uint NumVendorOptions;
    _Anonymous_e__Struct* VendorOptions;
}

struct DHCP_ALL_OPTION_VALUES
{
    uint Flags;
    uint NumElements;
    _Anonymous_e__Struct* Options;
}

struct DHCP_ALL_OPTION_VALUES_PB
{
    uint Flags;
    uint NumElements;
    _Anonymous_e__Struct* Options;
}

struct DHCPDS_SERVER
{
    uint Version;
    const(wchar)* ServerName;
    uint ServerAddress;
    uint Flags;
    uint State;
    const(wchar)* DsLocation;
    uint DsLocType;
}

struct DHCPDS_SERVERS
{
    uint Flags;
    uint NumElements;
    DHCPDS_SERVER* Servers;
}

struct DHCP_ATTRIB
{
    uint DhcpAttribId;
    uint DhcpAttribType;
    _Anonymous_e__Union Anonymous;
}

struct DHCP_ATTRIB_ARRAY
{
    uint NumElements;
    DHCP_ATTRIB* DhcpAttribs;
}

struct DHCP_BOOTP_IP_RANGE
{
    uint StartAddress;
    uint EndAddress;
    uint BootpAllocated;
    uint MaxBootpAllowed;
}

struct DHCP_SUBNET_ELEMENT_DATA_V5
{
    DHCP_SUBNET_ELEMENT_TYPE ElementType;
    _DHCP_SUBNET_ELEMENT_UNION_V5 Element;
}

struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V5
{
    uint NumElements;
    DHCP_SUBNET_ELEMENT_DATA_V5* Elements;
}

struct DHCP_PERF_STATS
{
    uint dwNumPacketsReceived;
    uint dwNumPacketsDuplicate;
    uint dwNumPacketsExpired;
    uint dwNumMilliSecondsProcessed;
    uint dwNumPacketsInActiveQueue;
    uint dwNumPacketsInPingQueue;
    uint dwNumDiscoversReceived;
    uint dwNumOffersSent;
    uint dwNumRequestsReceived;
    uint dwNumInformsReceived;
    uint dwNumAcksSent;
    uint dwNumNacksSent;
    uint dwNumDeclinesReceived;
    uint dwNumReleasesReceived;
    uint dwNumDelayedOfferInQueue;
    uint dwNumPacketsProcessed;
    uint dwNumPacketsInQuarWaitingQueue;
    uint dwNumPacketsInQuarReadyQueue;
    uint dwNumPacketsInQuarDecisionQueue;
}

struct DHCP_BIND_ELEMENT
{
    uint Flags;
    BOOL fBoundToDHCPServer;
    uint AdapterPrimaryAddress;
    uint AdapterSubnetAddress;
    const(wchar)* IfDescription;
    uint IfIdSize;
    ubyte* IfId;
}

struct DHCP_BIND_ELEMENT_ARRAY
{
    uint NumElements;
    DHCP_BIND_ELEMENT* Elements;
}

struct DHCPV6_BIND_ELEMENT
{
    uint Flags;
    BOOL fBoundToDHCPServer;
    DHCP_IPV6_ADDRESS AdapterPrimaryAddress;
    DHCP_IPV6_ADDRESS AdapterSubnetAddress;
    const(wchar)* IfDescription;
    uint IpV6IfIndex;
    uint IfIdSize;
    ubyte* IfId;
}

struct DHCPV6_BIND_ELEMENT_ARRAY
{
    uint NumElements;
    DHCPV6_BIND_ELEMENT* Elements;
}

struct DHCP_IP_RANGE_V6
{
    DHCP_IPV6_ADDRESS StartAddress;
    DHCP_IPV6_ADDRESS EndAddress;
}

struct DHCP_HOST_INFO_V6
{
    DHCP_IPV6_ADDRESS IpAddress;
    const(wchar)* NetBiosName;
    const(wchar)* HostName;
}

struct DHCP_SUBNET_INFO_V6
{
    DHCP_IPV6_ADDRESS SubnetAddress;
    uint Prefix;
    ushort Preference;
    const(wchar)* SubnetName;
    const(wchar)* SubnetComment;
    uint State;
    uint ScopeId;
}

struct SCOPE_MIB_INFO_V6
{
    DHCP_IPV6_ADDRESS Subnet;
    ulong NumAddressesInuse;
    ulong NumAddressesFree;
    ulong NumPendingAdvertises;
}

struct DHCP_MIB_INFO_V6
{
    uint Solicits;
    uint Advertises;
    uint Requests;
    uint Renews;
    uint Rebinds;
    uint Replies;
    uint Confirms;
    uint Declines;
    uint Releases;
    uint Informs;
    DATE_TIME ServerStartTime;
    uint Scopes;
    SCOPE_MIB_INFO_V6* ScopeInfo;
}

struct DHCP_IP_RESERVATION_V6
{
    DHCP_IPV6_ADDRESS ReservedIpAddress;
    DHCP_BINARY_DATA* ReservedForClient;
    uint InterfaceId;
}

enum DHCP_SUBNET_ELEMENT_TYPE_V6
{
    Dhcpv6IpRanges = 0,
    Dhcpv6ReservedIps = 1,
    Dhcpv6ExcludedIpRanges = 2,
}

struct DHCP_SUBNET_ELEMENT_DATA_V6
{
    DHCP_SUBNET_ELEMENT_TYPE_V6 ElementType;
    DHCP_SUBNET_ELEMENT_UNION_V6 Element;
}

struct DHCP_SUBNET_ELEMENT_UNION_V6
{
}

struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V6
{
    uint NumElements;
    DHCP_SUBNET_ELEMENT_DATA_V6* Elements;
}

struct DHCP_CLIENT_INFO_V6
{
    DHCP_IPV6_ADDRESS ClientIpAddress;
    DHCP_BINARY_DATA ClientDUID;
    uint AddressType;
    uint IAID;
    const(wchar)* ClientName;
    const(wchar)* ClientComment;
    DATE_TIME ClientValidLeaseExpires;
    DATE_TIME ClientPrefLeaseExpires;
    DHCP_HOST_INFO_V6 OwnerHost;
}

struct DHCPV6_IP_ARRAY
{
    uint NumElements;
    DHCP_IPV6_ADDRESS* Elements;
}

struct DHCP_CLIENT_INFO_ARRAY_V6
{
    uint NumElements;
    DHCP_CLIENT_INFO_V6** Clients;
}

enum DHCP_SEARCH_INFO_TYPE_V6
{
    Dhcpv6ClientIpAddress = 0,
    Dhcpv6ClientDUID = 1,
    Dhcpv6ClientName = 2,
}

struct DHCP_SEARCH_INFO_V6
{
    DHCP_SEARCH_INFO_TYPE_V6 SearchType;
    _DHCP_CLIENT_SEARCH_UNION_V6 SearchInfo;
}

enum DHCP_POL_ATTR_TYPE
{
    DhcpAttrHWAddr = 0,
    DhcpAttrOption = 1,
    DhcpAttrSubOption = 2,
    DhcpAttrFqdn = 3,
    DhcpAttrFqdnSingleLabel = 4,
}

enum DHCP_POL_COMPARATOR
{
    DhcpCompEqual = 0,
    DhcpCompNotEqual = 1,
    DhcpCompBeginsWith = 2,
    DhcpCompNotBeginWith = 3,
    DhcpCompEndsWith = 4,
    DhcpCompNotEndWith = 5,
}

enum DHCP_POL_LOGIC_OPER
{
    DhcpLogicalOr = 0,
    DhcpLogicalAnd = 1,
}

enum DHCP_POLICY_FIELDS_TO_UPDATE
{
    DhcpUpdatePolicyName = 1,
    DhcpUpdatePolicyOrder = 2,
    DhcpUpdatePolicyExpr = 4,
    DhcpUpdatePolicyRanges = 8,
    DhcpUpdatePolicyDescr = 16,
    DhcpUpdatePolicyStatus = 32,
    DhcpUpdatePolicyDnsSuffix = 64,
}

struct DHCP_POL_COND
{
    uint ParentExpr;
    DHCP_POL_ATTR_TYPE Type;
    uint OptionID;
    uint SubOptionID;
    const(wchar)* VendorName;
    DHCP_POL_COMPARATOR Operator;
    ubyte* Value;
    uint ValueLength;
}

struct DHCP_POL_COND_ARRAY
{
    uint NumElements;
    DHCP_POL_COND* Elements;
}

struct DHCP_POL_EXPR
{
    uint ParentExpr;
    DHCP_POL_LOGIC_OPER Operator;
}

struct DHCP_POL_EXPR_ARRAY
{
    uint NumElements;
    DHCP_POL_EXPR* Elements;
}

struct DHCP_IP_RANGE_ARRAY
{
    uint NumElements;
    DHCP_IP_RANGE* Elements;
}

struct DHCP_POLICY
{
    const(wchar)* PolicyName;
    BOOL IsGlobalPolicy;
    uint Subnet;
    uint ProcessingOrder;
    DHCP_POL_COND_ARRAY* Conditions;
    DHCP_POL_EXPR_ARRAY* Expressions;
    DHCP_IP_RANGE_ARRAY* Ranges;
    const(wchar)* Description;
    BOOL Enabled;
}

struct DHCP_POLICY_ARRAY
{
    uint NumElements;
    DHCP_POLICY* Elements;
}

struct DHCP_POLICY_EX
{
    const(wchar)* PolicyName;
    BOOL IsGlobalPolicy;
    uint Subnet;
    uint ProcessingOrder;
    DHCP_POL_COND_ARRAY* Conditions;
    DHCP_POL_EXPR_ARRAY* Expressions;
    DHCP_IP_RANGE_ARRAY* Ranges;
    const(wchar)* Description;
    BOOL Enabled;
    DHCP_PROPERTY_ARRAY* Properties;
}

struct DHCP_POLICY_EX_ARRAY
{
    uint NumElements;
    DHCP_POLICY_EX* Elements;
}

enum DHCPV6_STATELESS_PARAM_TYPE
{
    DhcpStatelessPurgeInterval = 1,
    DhcpStatelessStatus = 2,
}

struct DHCPV6_STATELESS_PARAMS
{
    BOOL Status;
    uint PurgeInterval;
}

struct DHCPV6_STATELESS_SCOPE_STATS
{
    DHCP_IPV6_ADDRESS SubnetAddress;
    ulong NumStatelessClientsAdded;
    ulong NumStatelessClientsRemoved;
}

struct DHCPV6_STATELESS_STATS
{
    uint NumScopes;
    DHCPV6_STATELESS_SCOPE_STATS* ScopeStats;
}

enum DHCP_FAILOVER_MODE
{
    LoadBalance = 0,
    HotStandby = 1,
}

enum DHCP_FAILOVER_SERVER
{
    PrimaryServer = 0,
    SecondaryServer = 1,
}

enum FSM_STATE
{
    NO_STATE = 0,
    INIT = 1,
    STARTUP = 2,
    NORMAL = 3,
    COMMUNICATION_INT = 4,
    PARTNER_DOWN = 5,
    POTENTIAL_CONFLICT = 6,
    CONFLICT_DONE = 7,
    RESOLUTION_INT = 8,
    RECOVER = 9,
    RECOVER_WAIT = 10,
    RECOVER_DONE = 11,
    PAUSED = 12,
    SHUTDOWN = 13,
}

struct DHCP_FAILOVER_RELATIONSHIP
{
    uint PrimaryServer;
    uint SecondaryServer;
    DHCP_FAILOVER_MODE Mode;
    DHCP_FAILOVER_SERVER ServerType;
    FSM_STATE State;
    FSM_STATE PrevState;
    uint Mclt;
    uint SafePeriod;
    const(wchar)* RelationshipName;
    const(wchar)* PrimaryServerName;
    const(wchar)* SecondaryServerName;
    DHCP_IP_ARRAY* pScopes;
    ubyte Percentage;
    const(wchar)* SharedSecret;
}

struct DHCP_FAILOVER_RELATIONSHIP_ARRAY
{
    uint NumElements;
    DHCP_FAILOVER_RELATIONSHIP* pRelationships;
}

struct DHCPV4_FAILOVER_CLIENT_INFO
{
    uint ClientIpAddress;
    uint SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)* ClientName;
    const(wchar)* ClientComment;
    DATE_TIME ClientLeaseExpires;
    DHCP_HOST_INFO OwnerHost;
    ubyte bClientType;
    ubyte AddressState;
    QuarantineStatus Status;
    DATE_TIME ProbationEnds;
    BOOL QuarantineCapable;
    uint SentPotExpTime;
    uint AckPotExpTime;
    uint RecvPotExpTime;
    uint StartTime;
    uint CltLastTransTime;
    uint LastBndUpdTime;
    uint BndMsgStatus;
    const(wchar)* PolicyName;
    ubyte Flags;
}

struct DHCPV4_FAILOVER_CLIENT_INFO_ARRAY
{
    uint NumElements;
    DHCPV4_FAILOVER_CLIENT_INFO** Clients;
}

struct DHCPV4_FAILOVER_CLIENT_INFO_EX
{
    uint ClientIpAddress;
    uint SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)* ClientName;
    const(wchar)* ClientComment;
    DATE_TIME ClientLeaseExpires;
    DHCP_HOST_INFO OwnerHost;
    ubyte bClientType;
    ubyte AddressState;
    QuarantineStatus Status;
    DATE_TIME ProbationEnds;
    BOOL QuarantineCapable;
    uint SentPotExpTime;
    uint AckPotExpTime;
    uint RecvPotExpTime;
    uint StartTime;
    uint CltLastTransTime;
    uint LastBndUpdTime;
    uint BndMsgStatus;
    const(wchar)* PolicyName;
    ubyte Flags;
    uint AddressStateEx;
}

struct DHCP_FAILOVER_STATISTICS
{
    uint NumAddr;
    uint AddrFree;
    uint AddrInUse;
    uint PartnerAddrFree;
    uint ThisAddrFree;
    uint PartnerAddrInUse;
    uint ThisAddrInUse;
}

@DllImport("dhcpcsvc6.dll")
void Dhcpv6CApiInitialize(uint* Version);

@DllImport("dhcpcsvc6.dll")
void Dhcpv6CApiCleanup();

@DllImport("dhcpcsvc6.dll")
uint Dhcpv6RequestParams(BOOL forceNewInform, void* reserved, const(wchar)* adapterName, DHCPV6CAPI_CLASSID* classId, DHCPV6CAPI_PARAMS_ARRAY recdParams, ubyte* buffer, uint* pSize);

@DllImport("dhcpcsvc6.dll")
uint Dhcpv6RequestPrefix(const(wchar)* adapterName, DHCPV6CAPI_CLASSID* pclassId, DHCPV6PrefixLeaseInformation* prefixleaseInfo, uint* pdwTimeToWait);

@DllImport("dhcpcsvc6.dll")
uint Dhcpv6RenewPrefix(const(wchar)* adapterName, DHCPV6CAPI_CLASSID* pclassId, DHCPV6PrefixLeaseInformation* prefixleaseInfo, uint* pdwTimeToWait, uint bValidatePrefix);

@DllImport("dhcpcsvc6.dll")
uint Dhcpv6ReleasePrefix(const(wchar)* adapterName, DHCPV6CAPI_CLASSID* classId, DHCPV6PrefixLeaseInformation* leaseInfo);

@DllImport("dhcpcsvc.dll")
uint DhcpCApiInitialize(uint* Version);

@DllImport("dhcpcsvc.dll")
void DhcpCApiCleanup();

@DllImport("dhcpcsvc.dll")
uint DhcpRequestParams(uint Flags, void* Reserved, const(wchar)* AdapterName, DHCPCAPI_CLASSID* ClassId, DHCPCAPI_PARAMS_ARRAY SendParams, DHCPCAPI_PARAMS_ARRAY RecdParams, char* Buffer, uint* pSize, const(wchar)* RequestIdStr);

@DllImport("dhcpcsvc.dll")
uint DhcpUndoRequestParams(uint Flags, void* Reserved, const(wchar)* AdapterName, const(wchar)* RequestIdStr);

@DllImport("dhcpcsvc.dll")
uint DhcpRegisterParamChange(uint Flags, void* Reserved, const(wchar)* AdapterName, DHCPCAPI_CLASSID* ClassId, DHCPCAPI_PARAMS_ARRAY Params, void* Handle);

@DllImport("dhcpcsvc.dll")
uint DhcpDeRegisterParamChange(uint Flags, void* Reserved, void* Event);

@DllImport("dhcpcsvc.dll")
uint DhcpRemoveDNSRegistrations();

@DllImport("dhcpcsvc.dll")
uint DhcpGetOriginalSubnetMask(const(wchar)* sAdapterName, uint* dwSubnetMask);

@DllImport("DHCPSAPI.dll")
uint DhcpAddFilterV4(const(wchar)* ServerIpAddress, DHCP_FILTER_ADD_INFO* AddFilterInfo, BOOL ForceFlag);

@DllImport("DHCPSAPI.dll")
uint DhcpDeleteFilterV4(const(wchar)* ServerIpAddress, DHCP_ADDR_PATTERN* DeleteFilterInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetFilterV4(const(wchar)* ServerIpAddress, DHCP_FILTER_GLOBAL_INFO* GlobalFilterInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetFilterV4(const(wchar)* ServerIpAddress, DHCP_FILTER_GLOBAL_INFO* GlobalFilterInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumFilterV4(const(wchar)* ServerIpAddress, DHCP_ADDR_PATTERN* ResumeHandle, uint PreferredMaximum, DHCP_FILTER_LIST_TYPE ListType, DHCP_FILTER_ENUM_INFO** EnumFilterInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateSubnet(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO)* SubnetInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetSubnetInfo(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO)* SubnetInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetSubnetInfo(const(wchar)* ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_INFO** SubnetInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnets(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_IP_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpAddSubnetElement(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_ELEMENT_DATA)* AddElementInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetElements(const(wchar)* ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, DHCP_SUBNET_ELEMENT_INFO_ARRAY** EnumElementInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpRemoveSubnetElement(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_ELEMENT_DATA)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI.dll")
uint DhcpDeleteSubnet(const(wchar)* ServerIpAddress, uint SubnetAddress, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateOption(const(wchar)* ServerIpAddress, uint OptionID, const(DHCP_OPTION)* OptionInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionInfo(const(wchar)* ServerIpAddress, uint OptionID, const(DHCP_OPTION)* OptionInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionInfo(const(wchar)* ServerIpAddress, uint OptionID, DHCP_OPTION** OptionInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptions(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOption(const(wchar)* ServerIpAddress, uint OptionID);

@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionValue(const(wchar)* ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, const(DHCP_OPTION_DATA)* OptionValue);

@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionValues(const(wchar)* ServerIpAddress, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, const(DHCP_OPTION_VALUE_ARRAY)* OptionValues);

@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionValue(const(wchar)* ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, DHCP_OPTION_VALUE** OptionValue);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptionValues(const(wchar)* ServerIpAddress, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, uint* ResumeHandle, uint PreferredMaximum, DHCP_OPTION_VALUE_ARRAY** OptionValues, uint* OptionsRead, uint* OptionsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOptionValue(const(wchar)* ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateClientInfoVQ(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_VQ)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetClientInfoVQ(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_VQ)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetClientInfoVQ(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, DHCP_CLIENT_INFO_VQ** ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClientsVQ(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_VQ** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClientsFilterStatusInfo(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateClientInfo(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetClientInfo(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetClientInfo(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, DHCP_CLIENT_INFO** ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpDeleteClientInfo(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClients(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpGetClientOptions(const(wchar)* ServerIpAddress, uint ClientIpAddress, uint ClientSubnetMask, DHCP_OPTION_LIST** ClientOptions);

@DllImport("DHCPSAPI.dll")
uint DhcpGetMibInfo(const(wchar)* ServerIpAddress, DHCP_MIB_INFO** MibInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpServerSetConfig(const(wchar)* ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO* ConfigInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpServerGetConfig(const(wchar)* ServerIpAddress, DHCP_SERVER_CONFIG_INFO** ConfigInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpScanDatabase(const(wchar)* ServerIpAddress, uint SubnetAddress, uint FixFlag, DHCP_SCAN_LIST** ScanList);

@DllImport("DHCPSAPI.dll")
void DhcpRpcFreeMemory(void* BufferPointer);

@DllImport("DHCPSAPI.dll")
uint DhcpGetVersion(const(wchar)* ServerIpAddress, uint* MajorVersion, uint* MinorVersion);

@DllImport("DHCPSAPI.dll")
uint DhcpAddSubnetElementV4(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_ELEMENT_DATA_V4)* AddElementInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetElementsV4(const(wchar)* ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4** EnumElementInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpRemoveSubnetElementV4(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_ELEMENT_DATA_V4)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateClientInfoV4(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_V4)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetClientInfoV4(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_V4)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetClientInfoV4(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, DHCP_CLIENT_INFO_V4** ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClientsV4(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_V4** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpServerSetConfigV4(const(wchar)* ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO_V4* ConfigInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpServerGetConfigV4(const(wchar)* ServerIpAddress, DHCP_SERVER_CONFIG_INFO_V4** ConfigInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetSuperScopeV4(const(wchar)* ServerIpAddress, const(uint) SubnetAddress, const(ushort)* SuperScopeName, const(int) ChangeExisting);

@DllImport("DHCPSAPI.dll")
uint DhcpDeleteSuperScopeV4(const(wchar)* ServerIpAddress, const(ushort)* SuperScopeName);

@DllImport("DHCPSAPI.dll")
uint DhcpGetSuperScopeInfoV4(const(wchar)* ServerIpAddress, DHCP_SUPER_SCOPE_TABLE** SuperScopeTable);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClientsV5(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_V5** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateOptionV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionId, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION* OptionInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionInfoV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION* OptionInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionInfoV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION** OptionInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptionsV5(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* ClassName, const(wchar)* VendorName, uint* ResumeHandle, uint PreferredMaximum, DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOptionV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, const(wchar)* VendorName);

@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionValueV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionId, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionValuesV5(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE_ARRAY* OptionValues);

@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionValueV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE** OptionValue);

@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionValueV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, DHCP_OPTION_VALUE** OptionValue);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptionValuesV5(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, uint* ResumeHandle, uint PreferredMaximum, DHCP_OPTION_VALUE_ARRAY** OptionValues, uint* OptionsRead, uint* OptionsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOptionValueV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateClass(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* ClassInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpModifyClass(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* ClassInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpDeleteClass(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, const(wchar)* ClassName);

@DllImport("DHCPSAPI.dll")
uint DhcpGetClassInfo(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* PartialClassInfo, DHCP_CLASS_INFO** FilledClassInfo);

@DllImport("dhcpcsvc.dll")
uint DhcpEnumClasses(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, uint* ResumeHandle, uint PreferredMaximum, DHCP_CLASS_INFO_ARRAY** ClassInfoArray, uint* nRead, uint* nTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpGetAllOptions(const(wchar)* ServerIpAddress, uint Flags, DHCP_ALL_OPTIONS** OptionStruct);

@DllImport("DHCPSAPI.dll")
uint DhcpGetAllOptionsV6(const(wchar)* ServerIpAddress, uint Flags, DHCP_ALL_OPTIONS** OptionStruct);

@DllImport("DHCPSAPI.dll")
uint DhcpGetAllOptionValues(const(wchar)* ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_ALL_OPTION_VALUES** Values);

@DllImport("DHCPSAPI.dll")
uint DhcpGetAllOptionValuesV6(const(wchar)* ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, DHCP_ALL_OPTION_VALUES** Values);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumServers(uint Flags, void* IdInfo, DHCPDS_SERVERS** Servers, void* CallbackFn, void* CallbackData);

@DllImport("DHCPSAPI.dll")
uint DhcpAddServer(uint Flags, void* IdInfo, DHCPDS_SERVER* NewServer, void* CallbackFn, void* CallbackData);

@DllImport("DHCPSAPI.dll")
uint DhcpDeleteServer(uint Flags, void* IdInfo, DHCPDS_SERVER* NewServer, void* CallbackFn, void* CallbackData);

@DllImport("DHCPSAPI.dll")
uint DhcpGetServerBindingInfo(const(wchar)* ServerIpAddress, uint Flags, DHCP_BIND_ELEMENT_ARRAY** BindElementsInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetServerBindingInfo(const(wchar)* ServerIpAddress, uint Flags, DHCP_BIND_ELEMENT_ARRAY* BindElementInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpAddSubnetElementV5(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_ELEMENT_DATA_V5)* AddElementInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetElementsV5(const(wchar)* ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, DHCP_SUBNET_ELEMENT_INFO_ARRAY_V5** EnumElementInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpRemoveSubnetElementV5(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_ELEMENT_DATA_V5)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI.dll")
uint DhcpV4EnumSubnetReservations(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_RESERVATION_INFO_ARRAY** EnumElementInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateOptionV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionId, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION* OptionInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOptionV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, const(wchar)* VendorName);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptionsV6(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* ClassName, const(wchar)* VendorName, uint* ResumeHandle, uint PreferredMaximum, DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOptionValueV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO6* ScopeInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionInfoV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION** OptionInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionInfoV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION* OptionInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionValueV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionId, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

@DllImport("DHCPSAPI.dll")
uint DhcpGetSubnetInfoVQ(const(wchar)* ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_INFO_VQ** SubnetInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateSubnetVQ(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO_VQ)* SubnetInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetSubnetInfoVQ(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO_VQ)* SubnetInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptionValuesV6(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* ClassName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, uint* ResumeHandle, uint PreferredMaximum, DHCP_OPTION_VALUE_ARRAY** OptionValues, uint* OptionsRead, uint* OptionsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpDsInit();

@DllImport("DHCPSAPI.dll")
void DhcpDsCleanup();

@DllImport("DHCPSAPI.dll")
uint DhcpSetThreadOptions(uint Flags, void* Reserved);

@DllImport("DHCPSAPI.dll")
uint DhcpGetThreadOptions(uint* pFlags, void* Reserved);

@DllImport("DHCPSAPI.dll")
uint DhcpServerQueryAttribute(const(wchar)* ServerIpAddr, uint dwReserved, uint DhcpAttribId, DHCP_ATTRIB** pDhcpAttrib);

@DllImport("DHCPSAPI.dll")
uint DhcpServerQueryAttributes(const(wchar)* ServerIpAddr, uint dwReserved, uint dwAttribCount, uint* pDhcpAttribs, DHCP_ATTRIB_ARRAY** pDhcpAttribArr);

@DllImport("DHCPSAPI.dll")
uint DhcpServerRedoAuthorization(const(wchar)* ServerIpAddr, uint dwReserved);

@DllImport("DHCPSAPI.dll")
uint DhcpAuditLogSetParams(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* AuditLogDir, uint DiskCheckInterval, uint MaxLogFilesSize, uint MinSpaceOnDisk);

@DllImport("DHCPSAPI.dll")
uint DhcpAuditLogGetParams(const(wchar)* ServerIpAddress, uint Flags, ushort** AuditLogDir, uint* DiskCheckInterval, uint* MaxLogFilesSize, uint* MinSpaceOnDisk);

@DllImport("DHCPSAPI.dll")
uint DhcpServerQueryDnsRegCredentials(const(wchar)* ServerIpAddress, uint UnameSize, const(wchar)* Uname, uint DomainSize, const(wchar)* Domain);

@DllImport("DHCPSAPI.dll")
uint DhcpServerSetDnsRegCredentials(const(wchar)* ServerIpAddress, const(wchar)* Uname, const(wchar)* Domain, const(wchar)* Passwd);

@DllImport("DHCPSAPI.dll")
uint DhcpServerSetDnsRegCredentialsV5(const(wchar)* ServerIpAddress, const(wchar)* Uname, const(wchar)* Domain, const(wchar)* Passwd);

@DllImport("DHCPSAPI.dll")
uint DhcpServerBackupDatabase(const(wchar)* ServerIpAddress, const(wchar)* Path);

@DllImport("DHCPSAPI.dll")
uint DhcpServerRestoreDatabase(const(wchar)* ServerIpAddress, const(wchar)* Path);

@DllImport("DHCPSAPI.dll")
uint DhcpServerSetConfigVQ(const(wchar)* ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO_VQ* ConfigInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpServerGetConfigVQ(const(wchar)* ServerIpAddress, DHCP_SERVER_CONFIG_INFO_VQ** ConfigInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetServerSpecificStrings(const(wchar)* ServerIpAddress, DHCP_SERVER_SPECIFIC_STRINGS** ServerSpecificStrings);

@DllImport("DHCPSAPI.dll")
void DhcpServerAuditlogParamsFree(DHCP_SERVER_CONFIG_INFO_VQ* ConfigInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateSubnetV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_SUBNET_INFO_V6* SubnetInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpDeleteSubnetV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetsV6(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, DHCPV6_IP_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpAddSubnetElementV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_SUBNET_ELEMENT_DATA_V6* AddElementInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpRemoveSubnetElementV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_SUBNET_ELEMENT_DATA_V6* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetElementsV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_SUBNET_ELEMENT_TYPE_V6 EnumElementType, uint* ResumeHandle, uint PreferredMaximum, DHCP_SUBNET_ELEMENT_INFO_ARRAY_V6** EnumElementInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpGetSubnetInfoV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_SUBNET_INFO_V6** SubnetInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClientsV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_IPV6_ADDRESS* ResumeHandle, uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_V6** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpServerGetConfigV6(const(wchar)* ServerIpAddress, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, DHCP_SERVER_CONFIG_INFO_V6** ConfigInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpServerSetConfigV6(const(wchar)* ServerIpAddress, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO_V6* ConfigInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetSubnetInfoV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_SUBNET_INFO_V6* SubnetInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetMibInfoV6(const(wchar)* ServerIpAddress, DHCP_MIB_INFO_V6** MibInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetServerBindingInfoV6(const(wchar)* ServerIpAddress, uint Flags, DHCPV6_BIND_ELEMENT_ARRAY** BindElementsInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetServerBindingInfoV6(const(wchar)* ServerIpAddress, uint Flags, DHCPV6_BIND_ELEMENT_ARRAY* BindElementInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpSetClientInfoV6(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_V6)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpGetClientInfoV6(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO_V6)* SearchInfo, DHCP_CLIENT_INFO_V6** ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpDeleteClientInfoV6(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO_V6)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpCreateClassV6(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO_V6* ClassInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpModifyClassV6(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO_V6* ClassInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpDeleteClassV6(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, const(wchar)* ClassName);

@DllImport("DHCPSAPI.dll")
uint DhcpEnumClassesV6(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, uint* ResumeHandle, uint PreferredMaximum, DHCP_CLASS_INFO_ARRAY_V6** ClassInfoArray, uint* nRead, uint* nTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpSetSubnetDelayOffer(const(wchar)* ServerIpAddress, uint SubnetAddress, ushort TimeDelayInMilliseconds);

@DllImport("DHCPSAPI.dll")
uint DhcpGetSubnetDelayOffer(const(wchar)* ServerIpAddress, uint SubnetAddress, ushort* TimeDelayInMilliseconds);

@DllImport("DHCPSAPI.dll")
uint DhcpGetMibInfoV5(const(wchar)* ServerIpAddress, DHCP_MIB_INFO_V5** MibInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpAddSecurityGroup(const(wchar)* pServer);

@DllImport("DHCPSAPI.dll")
uint DhcpV4GetOptionValue(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* PolicyName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE** OptionValue);

@DllImport("DHCPSAPI.dll")
uint DhcpV4SetOptionValue(const(wchar)* ServerIpAddress, uint Flags, uint OptionId, const(wchar)* PolicyName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

@DllImport("DHCPSAPI.dll")
uint DhcpV4SetOptionValues(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* PolicyName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE_ARRAY* OptionValues);

@DllImport("DHCPSAPI.dll")
uint DhcpV4RemoveOptionValue(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* PolicyName, const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpV4GetAllOptionValues(const(wchar)* ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_ALL_OPTION_VALUES_PB** Values);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverCreateRelationship(const(wchar)* ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverSetRelationship(const(wchar)* ServerIpAddress, uint Flags, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverDeleteRelationship(const(wchar)* ServerIpAddress, const(wchar)* pRelationshipName);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetRelationship(const(wchar)* ServerIpAddress, const(wchar)* pRelationshipName, DHCP_FAILOVER_RELATIONSHIP** pRelationship);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverEnumRelationship(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_FAILOVER_RELATIONSHIP_ARRAY** pRelationship, uint* RelationshipRead, uint* RelationshipTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverAddScopeToRelationship(const(wchar)* ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverDeleteScopeFromRelationship(const(wchar)* ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetScopeRelationship(const(wchar)* ServerIpAddress, uint ScopeId, DHCP_FAILOVER_RELATIONSHIP** pRelationship);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetScopeStatistics(const(wchar)* ServerIpAddress, uint ScopeId, DHCP_FAILOVER_STATISTICS** pStats);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetClientInfo(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, DHCPV4_FAILOVER_CLIENT_INFO** ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetSystemTime(const(wchar)* ServerIpAddress, uint* pTime, uint* pMaxAllowedDeltaTime);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetAddressStatus(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* pStatus);

@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverTriggerAddrAllocation(const(wchar)* ServerIpAddress, const(wchar)* pFailRelName);

@DllImport("DHCPSAPI.dll")
uint DhcpHlprCreateV4Policy(const(wchar)* PolicyName, BOOL fGlobalPolicy, uint Subnet, uint ProcessingOrder, DHCP_POL_LOGIC_OPER RootOperator, const(wchar)* Description, BOOL Enabled, DHCP_POLICY** Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpHlprCreateV4PolicyEx(const(wchar)* PolicyName, BOOL fGlobalPolicy, uint Subnet, uint ProcessingOrder, DHCP_POL_LOGIC_OPER RootOperator, const(wchar)* Description, BOOL Enabled, DHCP_POLICY_EX** Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpHlprAddV4PolicyExpr(DHCP_POLICY* Policy, uint ParentExpr, DHCP_POL_LOGIC_OPER Operator, uint* ExprIndex);

@DllImport("DHCPSAPI.dll")
uint DhcpHlprAddV4PolicyCondition(DHCP_POLICY* Policy, uint ParentExpr, DHCP_POL_ATTR_TYPE Type, uint OptionID, uint SubOptionID, const(wchar)* VendorName, DHCP_POL_COMPARATOR Operator, char* Value, uint ValueLength, uint* ConditionIndex);

@DllImport("DHCPSAPI.dll")
uint DhcpHlprAddV4PolicyRange(DHCP_POLICY* Policy, DHCP_IP_RANGE* Range);

@DllImport("DHCPSAPI.dll")
uint DhcpHlprResetV4PolicyExpr(DHCP_POLICY* Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpHlprModifyV4PolicyExpr(DHCP_POLICY* Policy, DHCP_POL_LOGIC_OPER Operator);

@DllImport("DHCPSAPI.dll")
void DhcpHlprFreeV4Policy(DHCP_POLICY* Policy);

@DllImport("DHCPSAPI.dll")
void DhcpHlprFreeV4PolicyArray(DHCP_POLICY_ARRAY* PolicyArray);

@DllImport("DHCPSAPI.dll")
void DhcpHlprFreeV4PolicyEx(DHCP_POLICY_EX* PolicyEx);

@DllImport("DHCPSAPI.dll")
void DhcpHlprFreeV4PolicyExArray(DHCP_POLICY_EX_ARRAY* PolicyExArray);

@DllImport("DHCPSAPI.dll")
void DhcpHlprFreeV4DhcpProperty(DHCP_PROPERTY* Property);

@DllImport("DHCPSAPI.dll")
void DhcpHlprFreeV4DhcpPropertyArray(DHCP_PROPERTY_ARRAY* PropertyArray);

@DllImport("DHCPSAPI.dll")
DHCP_PROPERTY* DhcpHlprFindV4DhcpProperty(DHCP_PROPERTY_ARRAY* PropertyArray, DHCP_PROPERTY_ID ID, DHCP_PROPERTY_TYPE Type);

@DllImport("DHCPSAPI.dll")
BOOL DhcpHlprIsV4PolicySingleUC(DHCP_POLICY* Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpV4QueryPolicyEnforcement(const(wchar)* ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, int* Enabled);

@DllImport("DHCPSAPI.dll")
uint DhcpV4SetPolicyEnforcement(const(wchar)* ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, BOOL Enable);

@DllImport("DHCPSAPI.dll")
BOOL DhcpHlprIsV4PolicyWellFormed(DHCP_POLICY* pPolicy);

@DllImport("DHCPSAPI.dll")
uint DhcpHlprIsV4PolicyValid(DHCP_POLICY* pPolicy);

@DllImport("DHCPSAPI.dll")
uint DhcpV4CreatePolicy(const(wchar)* ServerIpAddress, DHCP_POLICY* pPolicy);

@DllImport("DHCPSAPI.dll")
uint DhcpV4GetPolicy(const(wchar)* ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, const(wchar)* PolicyName, DHCP_POLICY** Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpV4SetPolicy(const(wchar)* ServerIpAddress, uint FieldsModified, BOOL fGlobalPolicy, uint SubnetAddress, const(wchar)* PolicyName, DHCP_POLICY* Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpV4DeletePolicy(const(wchar)* ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, const(wchar)* PolicyName);

@DllImport("DHCPSAPI.dll")
uint DhcpV4EnumPolicies(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, BOOL fGlobalPolicy, uint SubnetAddress, DHCP_POLICY_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpV4AddPolicyRange(const(wchar)* ServerIpAddress, uint SubnetAddress, const(wchar)* PolicyName, DHCP_IP_RANGE* Range);

@DllImport("DHCPSAPI.dll")
uint DhcpV4RemovePolicyRange(const(wchar)* ServerIpAddress, uint SubnetAddress, const(wchar)* PolicyName, DHCP_IP_RANGE* Range);

@DllImport("DHCPSAPI.dll")
uint DhcpV6SetStatelessStoreParams(const(wchar)* ServerIpAddress, BOOL fServerLevel, DHCP_IPV6_ADDRESS SubnetAddress, uint FieldModified, DHCPV6_STATELESS_PARAMS* Params);

@DllImport("DHCPSAPI.dll")
uint DhcpV6GetStatelessStoreParams(const(wchar)* ServerIpAddress, BOOL fServerLevel, DHCP_IPV6_ADDRESS SubnetAddress, DHCPV6_STATELESS_PARAMS** Params);

@DllImport("DHCPSAPI.dll")
uint DhcpV6GetStatelessStatistics(const(wchar)* ServerIpAddress, DHCPV6_STATELESS_STATS** StatelessStats);

@DllImport("DHCPSAPI.dll")
uint DhcpV4CreateClientInfo(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_PB)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpV4EnumSubnetClients(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_CLIENT_INFO_PB_ARRAY** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpV4GetClientInfo(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, DHCP_CLIENT_INFO_PB** ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpV6CreateClientInfo(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_V6)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpV4GetFreeIPAddress(const(wchar)* ServerIpAddress, uint ScopeId, uint StartIP, uint EndIP, uint NumFreeAddrReq, DHCP_IP_ARRAY** IPAddrList);

@DllImport("DHCPSAPI.dll")
uint DhcpV6GetFreeIPAddress(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS ScopeId, DHCP_IPV6_ADDRESS StartIP, DHCP_IPV6_ADDRESS EndIP, uint NumFreeAddrReq, DHCPV6_IP_ARRAY** IPAddrList);

@DllImport("DHCPSAPI.dll")
uint DhcpV4CreateClientInfoEx(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_EX)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpV4EnumSubnetClientsEx(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, uint PreferredMaximum, DHCP_CLIENT_INFO_EX_ARRAY** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpV4GetClientInfoEx(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, DHCP_CLIENT_INFO_EX** ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpV4CreatePolicyEx(const(wchar)* ServerIpAddress, DHCP_POLICY_EX* PolicyEx);

@DllImport("DHCPSAPI.dll")
uint DhcpV4GetPolicyEx(const(wchar)* ServerIpAddress, BOOL GlobalPolicy, uint SubnetAddress, const(wchar)* PolicyName, DHCP_POLICY_EX** Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpV4SetPolicyEx(const(wchar)* ServerIpAddress, uint FieldsModified, BOOL GlobalPolicy, uint SubnetAddress, const(wchar)* PolicyName, DHCP_POLICY_EX* Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpV4EnumPoliciesEx(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, BOOL GlobalPolicy, uint SubnetAddress, DHCP_POLICY_EX_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

