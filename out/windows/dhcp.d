module windows.dhcp;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum StatusCode : int
{
    STATUS_NO_ERROR            = 0x00000000,
    STATUS_UNSPECIFIED_FAILURE = 0x00000001,
    STATUS_NO_BINDING          = 0x00000003,
    STATUS_NOPREFIX_AVAIL      = 0x00000006,
}

enum : int
{
    DhcpFullForce     = 0x00000000,
    DhcpNoForce       = 0x00000001,
    DhcpFailoverForce = 0x00000002,
}
alias DHCP_FORCE_FLAG = int;

enum : int
{
    DhcpSubnetEnabled          = 0x00000000,
    DhcpSubnetDisabled         = 0x00000001,
    DhcpSubnetEnabledSwitched  = 0x00000002,
    DhcpSubnetDisabledSwitched = 0x00000003,
    DhcpSubnetInvalidState     = 0x00000004,
}
alias DHCP_SUBNET_STATE = int;

enum : int
{
    DhcpIpRanges          = 0x00000000,
    DhcpSecondaryHosts    = 0x00000001,
    DhcpReservedIps       = 0x00000002,
    DhcpExcludedIpRanges  = 0x00000003,
    DhcpIpUsedClusters    = 0x00000004,
    DhcpIpRangesDhcpOnly  = 0x00000005,
    DhcpIpRangesDhcpBootp = 0x00000006,
    DhcpIpRangesBootpOnly = 0x00000007,
}
alias DHCP_SUBNET_ELEMENT_TYPE = int;

enum : int
{
    Deny    = 0x00000000,
    Allow   = 0x00000001,
}
alias DHCP_FILTER_LIST_TYPE = int;

enum : int
{
    DhcpByteOption             = 0x00000000,
    DhcpWordOption             = 0x00000001,
    DhcpDWordOption            = 0x00000002,
    DhcpDWordDWordOption       = 0x00000003,
    DhcpIpAddressOption        = 0x00000004,
    DhcpStringDataOption       = 0x00000005,
    DhcpBinaryDataOption       = 0x00000006,
    DhcpEncapsulatedDataOption = 0x00000007,
    DhcpIpv6AddressOption      = 0x00000008,
}
alias DHCP_OPTION_DATA_TYPE = int;

enum : int
{
    DhcpUnaryElementTypeOption = 0x00000000,
    DhcpArrayTypeOption        = 0x00000001,
}
alias DHCP_OPTION_TYPE = int;

enum : int
{
    DhcpDefaultOptions  = 0x00000000,
    DhcpGlobalOptions   = 0x00000001,
    DhcpSubnetOptions   = 0x00000002,
    DhcpReservedOptions = 0x00000003,
    DhcpMScopeOptions   = 0x00000004,
}
alias DHCP_OPTION_SCOPE_TYPE = int;

enum : int
{
    DhcpDefaultOptions6  = 0x00000000,
    DhcpScopeOptions6    = 0x00000001,
    DhcpReservedOptions6 = 0x00000002,
    DhcpGlobalOptions6   = 0x00000003,
}
alias DHCP_OPTION_SCOPE_TYPE6 = int;

enum QuarantineStatus : int
{
    NOQUARANTINE       = 0x00000000,
    RESTRICTEDACCESS   = 0x00000001,
    DROPPACKET         = 0x00000002,
    PROBATION          = 0x00000003,
    EXEMPT             = 0x00000004,
    DEFAULTQUARSETTING = 0x00000005,
    NOQUARINFO         = 0x00000006,
}

enum : int
{
    DhcpClientIpAddress       = 0x00000000,
    DhcpClientHardwareAddress = 0x00000001,
    DhcpClientName            = 0x00000002,
}
alias DHCP_SEARCH_INFO_TYPE = int;

enum : int
{
    DhcpPropTypeByte   = 0x00000000,
    DhcpPropTypeWord   = 0x00000001,
    DhcpPropTypeDword  = 0x00000002,
    DhcpPropTypeString = 0x00000003,
    DhcpPropTypeBinary = 0x00000004,
}
alias DHCP_PROPERTY_TYPE = int;

enum : int
{
    DhcpPropIdPolicyDnsSuffix      = 0x00000000,
    DhcpPropIdClientAddressStateEx = 0x00000001,
}
alias DHCP_PROPERTY_ID = int;

enum : int
{
    DhcpRegistryFix = 0x00000000,
    DhcpDatabaseFix = 0x00000001,
}
alias DHCP_SCAN_FLAG = int;

enum : int
{
    Dhcpv6IpRanges         = 0x00000000,
    Dhcpv6ReservedIps      = 0x00000001,
    Dhcpv6ExcludedIpRanges = 0x00000002,
}
alias DHCP_SUBNET_ELEMENT_TYPE_V6 = int;

enum : int
{
    Dhcpv6ClientIpAddress = 0x00000000,
    Dhcpv6ClientDUID      = 0x00000001,
    Dhcpv6ClientName      = 0x00000002,
}
alias DHCP_SEARCH_INFO_TYPE_V6 = int;

enum : int
{
    DhcpAttrHWAddr          = 0x00000000,
    DhcpAttrOption          = 0x00000001,
    DhcpAttrSubOption       = 0x00000002,
    DhcpAttrFqdn            = 0x00000003,
    DhcpAttrFqdnSingleLabel = 0x00000004,
}
alias DHCP_POL_ATTR_TYPE = int;

enum : int
{
    DhcpCompEqual        = 0x00000000,
    DhcpCompNotEqual     = 0x00000001,
    DhcpCompBeginsWith   = 0x00000002,
    DhcpCompNotBeginWith = 0x00000003,
    DhcpCompEndsWith     = 0x00000004,
    DhcpCompNotEndWith   = 0x00000005,
}
alias DHCP_POL_COMPARATOR = int;

enum : int
{
    DhcpLogicalOr  = 0x00000000,
    DhcpLogicalAnd = 0x00000001,
}
alias DHCP_POL_LOGIC_OPER = int;

enum : int
{
    DhcpUpdatePolicyName      = 0x00000001,
    DhcpUpdatePolicyOrder     = 0x00000002,
    DhcpUpdatePolicyExpr      = 0x00000004,
    DhcpUpdatePolicyRanges    = 0x00000008,
    DhcpUpdatePolicyDescr     = 0x00000010,
    DhcpUpdatePolicyStatus    = 0x00000020,
    DhcpUpdatePolicyDnsSuffix = 0x00000040,
}
alias DHCP_POLICY_FIELDS_TO_UPDATE = int;

enum : int
{
    DhcpStatelessPurgeInterval = 0x00000001,
    DhcpStatelessStatus        = 0x00000002,
}
alias DHCPV6_STATELESS_PARAM_TYPE = int;

enum : int
{
    LoadBalance = 0x00000000,
    HotStandby  = 0x00000001,
}
alias DHCP_FAILOVER_MODE = int;

enum : int
{
    PrimaryServer   = 0x00000000,
    SecondaryServer = 0x00000001,
}
alias DHCP_FAILOVER_SERVER = int;

enum : int
{
    NO_STATE           = 0x00000000,
    INIT               = 0x00000001,
    STARTUP            = 0x00000002,
    NORMAL             = 0x00000003,
    COMMUNICATION_INT  = 0x00000004,
    PARTNER_DOWN       = 0x00000005,
    POTENTIAL_CONFLICT = 0x00000006,
    CONFLICT_DONE      = 0x00000007,
    RESOLUTION_INT     = 0x00000008,
    RECOVER            = 0x00000009,
    RECOVER_WAIT       = 0x0000000a,
    RECOVER_DONE       = 0x0000000b,
    PAUSED             = 0x0000000c,
    SHUTDOWN           = 0x0000000d,
}
alias FSM_STATE = int;

// Callbacks

alias LPDHCP_CONTROL = uint function(uint dwControlCode, void* lpReserved);
alias LPDHCP_NEWPKT = uint function(ubyte** Packet, uint* PacketSize, uint IpAddress, void* Reserved, 
                                    void** PktContext, int* ProcessIt);
alias LPDHCP_DROP_SEND = uint function(ubyte** Packet, uint* PacketSize, uint ControlCode, uint IpAddress, 
                                       void* Reserved, void* PktContext);
alias LPDHCP_PROB = uint function(ubyte* Packet, uint PacketSize, uint ControlCode, uint IpAddress, 
                                  uint AltAddress, void* Reserved, void* PktContext);
alias LPDHCP_GIVE_ADDRESS = uint function(ubyte* Packet, uint PacketSize, uint ControlCode, uint IpAddress, 
                                          uint AltAddress, uint AddrType, uint LeaseTime, void* Reserved, 
                                          void* PktContext);
alias LPDHCP_HANDLE_OPTIONS = uint function(ubyte* Packet, uint PacketSize, void* Reserved, void* PktContext, 
                                            DHCP_SERVER_OPTIONS* ServerOptions);
alias LPDHCP_DELETE_CLIENT = uint function(uint IpAddress, ubyte* HwAddress, uint HwAddressLength, uint Reserved, 
                                           uint ClientType);
alias LPDHCP_ENTRY_POINT_FUNC = uint function(const(wchar)* ChainDlls, uint CalloutVersion, 
                                              DHCP_CALLOUT_TABLE* CalloutTbl);

// Structs


struct DHCPV6CAPI_PARAMS
{
    uint   Flags;
    uint   OptionId;
    BOOL   IsVendor;
    ubyte* Data;
    uint   nBytesData;
}

struct DHCPV6CAPI_PARAMS_ARRAY
{
    uint               nParams;
    DHCPV6CAPI_PARAMS* Params;
}

struct DHCPV6CAPI_CLASSID
{
    uint   Flags;
    ubyte* Data;
    uint   nBytesData;
}

struct DHCPV6Prefix
{
    ubyte[16]  prefix;
    uint       prefixLength;
    uint       preferredLifeTime;
    uint       validLifeTime;
    StatusCode status;
}

struct DHCPV6PrefixLeaseInformation
{
    uint          nPrefixes;
    DHCPV6Prefix* prefixArray;
    uint          iaid;
    long          T1;
    long          T2;
    long          MaxLeaseExpirationTime;
    long          LastRenewalTime;
    StatusCode    status;
    ubyte*        ServerId;
    uint          ServerIdLen;
}

struct DHCPAPI_PARAMS
{
    uint   Flags;
    uint   OptionId;
    BOOL   IsVendor;
    ubyte* Data;
    uint   nBytesData;
}

struct DHCPCAPI_PARAMS_ARRAY
{
    uint            nParams;
    DHCPAPI_PARAMS* Params;
}

struct DHCPCAPI_CLASSID
{
    uint   Flags;
    ubyte* Data;
    uint   nBytesData;
}

struct DHCP_SERVER_OPTIONS
{
    ubyte* MessageType;
    uint*  SubnetMask;
    uint*  RequestedAddress;
    uint*  RequestLeaseTime;
    ubyte* OverlayFields;
    uint*  RouterAddress;
    uint*  Server;
    ubyte* ParameterRequestList;
    uint   ParameterRequestListLength;
    byte*  MachineName;
    uint   MachineNameLength;
    ubyte  ClientHardwareAddressType;
    ubyte  ClientHardwareAddressLength;
    ubyte* ClientHardwareAddress;
    byte*  ClassIdentifier;
    uint   ClassIdentifierLength;
    ubyte* VendorClass;
    uint   VendorClassLength;
    uint   DNSFlags;
    uint   DNSNameLength;
    ubyte* DNSName;
    ubyte  DSDomainNameRequested;
    byte*  DSDomainName;
    uint   DSDomainNameLen;
    uint*  ScopeId;
}

struct DHCP_CALLOUT_TABLE
{
    LPDHCP_CONTROL       DhcpControlHook;
    LPDHCP_NEWPKT        DhcpNewPktHook;
    LPDHCP_DROP_SEND     DhcpPktDropHook;
    LPDHCP_DROP_SEND     DhcpPktSendHook;
    LPDHCP_PROB          DhcpAddressDelHook;
    LPDHCP_GIVE_ADDRESS  DhcpAddressOfferHook;
    LPDHCP_HANDLE_OPTIONS DhcpHandleOptionsHook;
    LPDHCP_DELETE_CLIENT DhcpDeleteClientHook;
    void*                DhcpExtensionHook;
    void*                DhcpReservedHook;
}

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
    uint   DataLength;
    ubyte* Data;
}

struct DHCP_HOST_INFO
{
    uint          IpAddress;
    const(wchar)* NetBiosName;
    const(wchar)* HostName;
}

struct DWORD_DWORD
{
    uint DWord1;
    uint DWord2;
}

struct DHCP_SUBNET_INFO
{
    uint              SubnetAddress;
    uint              SubnetMask;
    const(wchar)*     SubnetName;
    const(wchar)*     SubnetComment;
    DHCP_HOST_INFO    PrimaryHost;
    DHCP_SUBNET_STATE SubnetState;
}

struct DHCP_SUBNET_INFO_VQ
{
    uint              SubnetAddress;
    uint              SubnetMask;
    const(wchar)*     SubnetName;
    const(wchar)*     SubnetComment;
    DHCP_HOST_INFO    PrimaryHost;
    DHCP_SUBNET_STATE SubnetState;
    uint              QuarantineOn;
    uint              Reserved1;
    uint              Reserved2;
    long              Reserved3;
    long              Reserved4;
}

struct DHCP_IP_ARRAY
{
    uint  NumElements;
    uint* Elements;
}

struct DHCP_IP_CLUSTER
{
    uint ClusterAddress;
    uint ClusterMask;
}

struct DHCP_IP_RESERVATION
{
    uint              ReservedIpAddress;
    DHCP_BINARY_DATA* ReservedForClient;
}

struct DHCP_SUBNET_ELEMENT_DATA
{
    DHCP_SUBNET_ELEMENT_TYPE ElementType;
    union Element
    {
        DHCP_IP_RANGE*       IpRange;
        DHCP_HOST_INFO*      SecondaryHost;
        DHCP_IP_RESERVATION* ReservedIp;
        DHCP_IP_RANGE*       ExcludeIpRange;
        DHCP_IP_CLUSTER*     IpUsedCluster;
    }
}

union DHCP_SUBNET_ELEMENT_UNION
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

struct DHCP_ADDR_PATTERN
{
    BOOL       MatchHWType;
    ubyte      HWType;
    BOOL       IsWildcard;
    ubyte      Length;
    ubyte[255] Pattern;
}

struct DHCP_FILTER_ADD_INFO
{
    DHCP_ADDR_PATTERN AddrPatt;
    const(wchar)*     Comment;
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
    const(wchar)*     Comment;
}

struct DHCP_FILTER_ENUM_INFO
{
    uint                NumElements;
    DHCP_FILTER_RECORD* pEnumRecords;
}

struct DHCP_OPTION_DATA_ELEMENT
{
    DHCP_OPTION_DATA_TYPE OptionType;
    union Element
    {
        ubyte            ByteOption;
        ushort           WordOption;
        uint             DWordOption;
        DWORD_DWORD      DWordDWordOption;
        uint             IpAddressOption;
        const(wchar)*    StringDataOption;
        DHCP_BINARY_DATA BinaryDataOption;
        DHCP_BINARY_DATA EncapsulatedDataOption;
        const(wchar)*    Ipv6AddressDataOption;
    }
}

union DHCP_OPTION_ELEMENT_UNION
{
}

struct DHCP_OPTION_DATA
{
    uint NumElements;
    DHCP_OPTION_DATA_ELEMENT* Elements;
}

struct DHCP_OPTION
{
    uint             OptionID;
    const(wchar)*    OptionName;
    const(wchar)*    OptionComment;
    DHCP_OPTION_DATA DefaultValue;
    DHCP_OPTION_TYPE OptionType;
}

struct DHCP_OPTION_ARRAY
{
    uint         NumElements;
    DHCP_OPTION* Options;
}

struct DHCP_OPTION_VALUE
{
    uint             OptionID;
    DHCP_OPTION_DATA Value;
}

struct DHCP_OPTION_VALUE_ARRAY
{
    uint               NumElements;
    DHCP_OPTION_VALUE* Values;
}

struct DHCP_RESERVED_SCOPE
{
    uint ReservedIpAddress;
    uint ReservedIpSubnetAddress;
}

struct DHCP_OPTION_SCOPE_INFO
{
    DHCP_OPTION_SCOPE_TYPE ScopeType;
    union ScopeInfo
    {
        void*               DefaultScopeInfo;
        void*               GlobalScopeInfo;
        uint                SubnetScopeInfo;
        DHCP_RESERVED_SCOPE ReservedScopeInfo;
        const(wchar)*       MScopeInfo;
    }
}

struct DHCP_RESERVED_SCOPE6
{
    DHCP_IPV6_ADDRESS ReservedIpAddress;
    DHCP_IPV6_ADDRESS ReservedIpSubnetAddress;
}

struct DHCP_OPTION_SCOPE_INFO6
{
    DHCP_OPTION_SCOPE_TYPE6 ScopeType;
    union ScopeInfo
    {
        void*                DefaultScopeInfo;
        DHCP_IPV6_ADDRESS    SubnetScopeInfo;
        DHCP_RESERVED_SCOPE6 ReservedScopeInfo;
    }
}

union DHCP_OPTION_SCOPE_UNION6
{
}

struct DHCP_OPTION_LIST
{
    uint               NumOptions;
    DHCP_OPTION_VALUE* Options;
}

struct DHCP_CLIENT_INFO
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)*    ClientName;
    const(wchar)*    ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
}

struct DHCP_CLIENT_INFO_ARRAY
{
    uint               NumElements;
    DHCP_CLIENT_INFO** Clients;
}

struct DHCP_CLIENT_INFO_VQ
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)*    ClientName;
    const(wchar)*    ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
    QuarantineStatus Status;
    DATE_TIME        ProbationEnds;
    BOOL             QuarantineCapable;
}

struct DHCP_CLIENT_INFO_ARRAY_VQ
{
    uint NumElements;
    DHCP_CLIENT_INFO_VQ** Clients;
}

struct DHCP_CLIENT_FILTER_STATUS_INFO
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)*    ClientName;
    const(wchar)*    ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
    QuarantineStatus Status;
    DATE_TIME        ProbationEnds;
    BOOL             QuarantineCapable;
    uint             FilterStatus;
}

struct DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY
{
    uint NumElements;
    DHCP_CLIENT_FILTER_STATUS_INFO** Clients;
}

struct DHCP_CLIENT_INFO_PB
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)*    ClientName;
    const(wchar)*    ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
    QuarantineStatus Status;
    DATE_TIME        ProbationEnds;
    BOOL             QuarantineCapable;
    uint             FilterStatus;
    const(wchar)*    PolicyName;
}

struct DHCP_CLIENT_INFO_PB_ARRAY
{
    uint NumElements;
    DHCP_CLIENT_INFO_PB** Clients;
}

struct DHCP_SEARCH_INFO
{
    DHCP_SEARCH_INFO_TYPE SearchType;
    union SearchInfo
    {
        uint             ClientIpAddress;
        DHCP_BINARY_DATA ClientHardwareAddress;
        const(wchar)*    ClientName;
    }
}

union DHCP_CLIENT_SEARCH_UNION
{
}

struct DHCP_PROPERTY
{
    DHCP_PROPERTY_ID   ID;
    DHCP_PROPERTY_TYPE Type;
    union Value
    {
        ubyte            ByteValue;
        ushort           WordValue;
        uint             DWordValue;
        const(wchar)*    StringValue;
        DHCP_BINARY_DATA BinaryValue;
    }
}

struct DHCP_PROPERTY_ARRAY
{
    uint           NumElements;
    DHCP_PROPERTY* Elements;
}

struct DHCP_CLIENT_INFO_EX
{
    uint                 ClientIpAddress;
    uint                 SubnetMask;
    DHCP_BINARY_DATA     ClientHardwareAddress;
    const(wchar)*        ClientName;
    const(wchar)*        ClientComment;
    DATE_TIME            ClientLeaseExpires;
    DHCP_HOST_INFO       OwnerHost;
    ubyte                bClientType;
    ubyte                AddressState;
    QuarantineStatus     Status;
    DATE_TIME            ProbationEnds;
    BOOL                 QuarantineCapable;
    uint                 FilterStatus;
    const(wchar)*        PolicyName;
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
    uint            Discovers;
    uint            Offers;
    uint            Requests;
    uint            Acks;
    uint            Naks;
    uint            Declines;
    uint            Releases;
    DATE_TIME       ServerStartTime;
    uint            Scopes;
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
    uint               Discovers;
    uint               Offers;
    uint               Requests;
    uint               Acks;
    uint               Naks;
    uint               Declines;
    uint               Releases;
    DATE_TIME          ServerStartTime;
    uint               QtnNumLeases;
    uint               QtnPctQtnLeases;
    uint               QtnProbationLeases;
    uint               QtnNonQtnLeases;
    uint               QtnExemptLeases;
    uint               QtnCapableClients;
    uint               QtnIASErrors;
    uint               Scopes;
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
    uint               Discovers;
    uint               Offers;
    uint               Requests;
    uint               Acks;
    uint               Naks;
    uint               Declines;
    uint               Releases;
    DATE_TIME          ServerStartTime;
    uint               QtnNumLeases;
    uint               QtnPctQtnLeases;
    uint               QtnProbationLeases;
    uint               QtnNonQtnLeases;
    uint               QtnExemptLeases;
    uint               QtnCapableClients;
    uint               QtnIASErrors;
    uint               DelayedOffers;
    uint               ScopesWithDelayedOffers;
    uint               Scopes;
    SCOPE_MIB_INFO_V5* ScopeInfo;
}

struct DHCP_SERVER_CONFIG_INFO
{
    uint          APIProtocolSupport;
    const(wchar)* DatabaseName;
    const(wchar)* DatabasePath;
    const(wchar)* BackupPath;
    uint          BackupInterval;
    uint          DatabaseLoggingFlag;
    uint          RestoreFlag;
    uint          DatabaseCleanupInterval;
    uint          DebugFlag;
}

struct DHCP_SCAN_ITEM
{
    uint           IpAddress;
    DHCP_SCAN_FLAG ScanFlag;
}

struct DHCP_SCAN_LIST
{
    uint            NumScanItems;
    DHCP_SCAN_ITEM* ScanItems;
}

struct DHCP_CLASS_INFO
{
    const(wchar)* ClassName;
    const(wchar)* ClassComment;
    uint          ClassDataLength;
    BOOL          IsVendor;
    uint          Flags;
    ubyte*        ClassData;
}

struct DHCP_CLASS_INFO_ARRAY
{
    uint             NumElements;
    DHCP_CLASS_INFO* Classes;
}

struct DHCP_CLASS_INFO_V6
{
    const(wchar)* ClassName;
    const(wchar)* ClassComment;
    uint          ClassDataLength;
    BOOL          IsVendor;
    uint          EnterpriseNumber;
    uint          Flags;
    ubyte*        ClassData;
}

struct DHCP_CLASS_INFO_ARRAY_V6
{
    uint                NumElements;
    DHCP_CLASS_INFO_V6* Classes;
}

struct DHCP_SERVER_SPECIFIC_STRINGS
{
    const(wchar)* DefaultVendorClassName;
    const(wchar)* DefaultUserClassName;
}

struct DHCP_IP_RESERVATION_V4
{
    uint              ReservedIpAddress;
    DHCP_BINARY_DATA* ReservedForClient;
    ubyte             bAllowedClientTypes;
}

struct DHCP_IP_RESERVATION_INFO
{
    uint             ReservedIpAddress;
    DHCP_BINARY_DATA ReservedForClient;
    const(wchar)*    ReservedClientName;
    const(wchar)*    ReservedClientDesc;
    ubyte            bAllowedClientTypes;
    ubyte            fOptionsPresent;
}

struct DHCP_RESERVATION_INFO_ARRAY
{
    uint NumElements;
    DHCP_IP_RESERVATION_INFO** Elements;
}

struct DHCP_SUBNET_ELEMENT_DATA_V4
{
    DHCP_SUBNET_ELEMENT_TYPE ElementType;
    union Element
    {
        DHCP_IP_RANGE*   IpRange;
        DHCP_HOST_INFO*  SecondaryHost;
        DHCP_IP_RESERVATION_V4* ReservedIp;
        DHCP_IP_RANGE*   ExcludeIpRange;
        DHCP_IP_CLUSTER* IpUsedCluster;
    }
}

union DHCP_SUBNET_ELEMENT_UNION_V4
{
}

struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4
{
    uint NumElements;
    DHCP_SUBNET_ELEMENT_DATA_V4* Elements;
}

struct DHCP_CLIENT_INFO_V4
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)*    ClientName;
    const(wchar)*    ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
}

struct DHCP_CLIENT_INFO_ARRAY_V4
{
    uint NumElements;
    DHCP_CLIENT_INFO_V4** Clients;
}

struct DHCP_SERVER_CONFIG_INFO_V4
{
    uint          APIProtocolSupport;
    const(wchar)* DatabaseName;
    const(wchar)* DatabasePath;
    const(wchar)* BackupPath;
    uint          BackupInterval;
    uint          DatabaseLoggingFlag;
    uint          RestoreFlag;
    uint          DatabaseCleanupInterval;
    uint          DebugFlag;
    uint          dwPingRetries;
    uint          cbBootTableString;
    ushort*       wszBootTableString;
    BOOL          fAuditLog;
}

struct DHCP_SERVER_CONFIG_INFO_VQ
{
    uint          APIProtocolSupport;
    const(wchar)* DatabaseName;
    const(wchar)* DatabasePath;
    const(wchar)* BackupPath;
    uint          BackupInterval;
    uint          DatabaseLoggingFlag;
    uint          RestoreFlag;
    uint          DatabaseCleanupInterval;
    uint          DebugFlag;
    uint          dwPingRetries;
    uint          cbBootTableString;
    ushort*       wszBootTableString;
    BOOL          fAuditLog;
    BOOL          QuarantineOn;
    uint          QuarDefFail;
    BOOL          QuarRuntimeStatus;
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
    uint          SubnetAddress;
    uint          SuperScopeNumber;
    uint          NextInSuperScope;
    const(wchar)* SuperScopeName;
}

struct DHCP_SUPER_SCOPE_TABLE
{
    uint cEntries;
    DHCP_SUPER_SCOPE_TABLE_ENTRY* pEntries;
}

struct DHCP_CLIENT_INFO_V5
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)*    ClientName;
    const(wchar)*    ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
}

struct DHCP_CLIENT_INFO_ARRAY_V5
{
    uint NumElements;
    DHCP_CLIENT_INFO_V5** Clients;
}

struct DHCP_ALL_OPTIONS
{
    uint               Flags;
    DHCP_OPTION_ARRAY* NonVendorOptions;
    uint               NumVendorOptions;
    struct
    {
        DHCP_OPTION   Option;
        const(wchar)* VendorName;
        const(wchar)* ClassName;
    }
}

struct DHCP_ALL_OPTION_VALUES
{
    uint Flags;
    uint NumElements;
    struct
    {
        const(wchar)* ClassName;
        const(wchar)* VendorName;
        BOOL          IsVendor;
        DHCP_OPTION_VALUE_ARRAY* OptionsArray;
    }
}

struct DHCP_ALL_OPTION_VALUES_PB
{
    uint Flags;
    uint NumElements;
    struct
    {
        const(wchar)* PolicyName;
        const(wchar)* VendorName;
        BOOL          IsVendor;
        DHCP_OPTION_VALUE_ARRAY* OptionsArray;
    }
}

struct DHCPDS_SERVER
{
    uint          Version;
    const(wchar)* ServerName;
    uint          ServerAddress;
    uint          Flags;
    uint          State;
    const(wchar)* DsLocation;
    uint          DsLocType;
}

struct DHCPDS_SERVERS
{
    uint           Flags;
    uint           NumElements;
    DHCPDS_SERVER* Servers;
}

struct DHCP_ATTRIB
{
    uint DhcpAttribId;
    uint DhcpAttribType;
    union
    {
        BOOL DhcpAttribBool;
        uint DhcpAttribUlong;
    }
}

struct DHCP_ATTRIB_ARRAY
{
    uint         NumElements;
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
    union Element
    {
        DHCP_BOOTP_IP_RANGE* IpRange;
        DHCP_HOST_INFO*      SecondaryHost;
        DHCP_IP_RESERVATION_V4* ReservedIp;
        DHCP_IP_RANGE*       ExcludeIpRange;
        DHCP_IP_CLUSTER*     IpUsedCluster;
    }
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
    uint          Flags;
    BOOL          fBoundToDHCPServer;
    uint          AdapterPrimaryAddress;
    uint          AdapterSubnetAddress;
    const(wchar)* IfDescription;
    uint          IfIdSize;
    ubyte*        IfId;
}

struct DHCP_BIND_ELEMENT_ARRAY
{
    uint               NumElements;
    DHCP_BIND_ELEMENT* Elements;
}

struct DHCPV6_BIND_ELEMENT
{
    uint              Flags;
    BOOL              fBoundToDHCPServer;
    DHCP_IPV6_ADDRESS AdapterPrimaryAddress;
    DHCP_IPV6_ADDRESS AdapterSubnetAddress;
    const(wchar)*     IfDescription;
    uint              IpV6IfIndex;
    uint              IfIdSize;
    ubyte*            IfId;
}

struct DHCPV6_BIND_ELEMENT_ARRAY
{
    uint                 NumElements;
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
    const(wchar)*     NetBiosName;
    const(wchar)*     HostName;
}

struct DHCP_SUBNET_INFO_V6
{
    DHCP_IPV6_ADDRESS SubnetAddress;
    uint              Prefix;
    ushort            Preference;
    const(wchar)*     SubnetName;
    const(wchar)*     SubnetComment;
    uint              State;
    uint              ScopeId;
}

struct SCOPE_MIB_INFO_V6
{
    DHCP_IPV6_ADDRESS Subnet;
    ulong             NumAddressesInuse;
    ulong             NumAddressesFree;
    ulong             NumPendingAdvertises;
}

struct DHCP_MIB_INFO_V6
{
    uint               Solicits;
    uint               Advertises;
    uint               Requests;
    uint               Renews;
    uint               Rebinds;
    uint               Replies;
    uint               Confirms;
    uint               Declines;
    uint               Releases;
    uint               Informs;
    DATE_TIME          ServerStartTime;
    uint               Scopes;
    SCOPE_MIB_INFO_V6* ScopeInfo;
}

struct DHCP_IP_RESERVATION_V6
{
    DHCP_IPV6_ADDRESS ReservedIpAddress;
    DHCP_BINARY_DATA* ReservedForClient;
    uint              InterfaceId;
}

struct DHCP_SUBNET_ELEMENT_DATA_V6
{
    DHCP_SUBNET_ELEMENT_TYPE_V6 ElementType;
    union Element
    {
        DHCP_IP_RANGE_V6* IpRange;
        DHCP_IP_RESERVATION_V6* ReservedIp;
        DHCP_IP_RANGE_V6* ExcludeIpRange;
    }
}

union DHCP_SUBNET_ELEMENT_UNION_V6
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
    DHCP_BINARY_DATA  ClientDUID;
    uint              AddressType;
    uint              IAID;
    const(wchar)*     ClientName;
    const(wchar)*     ClientComment;
    DATE_TIME         ClientValidLeaseExpires;
    DATE_TIME         ClientPrefLeaseExpires;
    DHCP_HOST_INFO_V6 OwnerHost;
}

struct DHCPV6_IP_ARRAY
{
    uint               NumElements;
    DHCP_IPV6_ADDRESS* Elements;
}

struct DHCP_CLIENT_INFO_ARRAY_V6
{
    uint NumElements;
    DHCP_CLIENT_INFO_V6** Clients;
}

struct DHCP_SEARCH_INFO_V6
{
    DHCP_SEARCH_INFO_TYPE_V6 SearchType;
    union SearchInfo
    {
        DHCP_IPV6_ADDRESS ClientIpAddress;
        DHCP_BINARY_DATA  ClientDUID;
        const(wchar)*     ClientName;
    }
}

struct DHCP_POL_COND
{
    uint                ParentExpr;
    DHCP_POL_ATTR_TYPE  Type;
    uint                OptionID;
    uint                SubOptionID;
    const(wchar)*       VendorName;
    DHCP_POL_COMPARATOR Operator;
    ubyte*              Value;
    uint                ValueLength;
}

struct DHCP_POL_COND_ARRAY
{
    uint           NumElements;
    DHCP_POL_COND* Elements;
}

struct DHCP_POL_EXPR
{
    uint                ParentExpr;
    DHCP_POL_LOGIC_OPER Operator;
}

struct DHCP_POL_EXPR_ARRAY
{
    uint           NumElements;
    DHCP_POL_EXPR* Elements;
}

struct DHCP_IP_RANGE_ARRAY
{
    uint           NumElements;
    DHCP_IP_RANGE* Elements;
}

struct DHCP_POLICY
{
    const(wchar)*        PolicyName;
    BOOL                 IsGlobalPolicy;
    uint                 Subnet;
    uint                 ProcessingOrder;
    DHCP_POL_COND_ARRAY* Conditions;
    DHCP_POL_EXPR_ARRAY* Expressions;
    DHCP_IP_RANGE_ARRAY* Ranges;
    const(wchar)*        Description;
    BOOL                 Enabled;
}

struct DHCP_POLICY_ARRAY
{
    uint         NumElements;
    DHCP_POLICY* Elements;
}

struct DHCP_POLICY_EX
{
    const(wchar)*        PolicyName;
    BOOL                 IsGlobalPolicy;
    uint                 Subnet;
    uint                 ProcessingOrder;
    DHCP_POL_COND_ARRAY* Conditions;
    DHCP_POL_EXPR_ARRAY* Expressions;
    DHCP_IP_RANGE_ARRAY* Ranges;
    const(wchar)*        Description;
    BOOL                 Enabled;
    DHCP_PROPERTY_ARRAY* Properties;
}

struct DHCP_POLICY_EX_ARRAY
{
    uint            NumElements;
    DHCP_POLICY_EX* Elements;
}

struct DHCPV6_STATELESS_PARAMS
{
    BOOL Status;
    uint PurgeInterval;
}

struct DHCPV6_STATELESS_SCOPE_STATS
{
    DHCP_IPV6_ADDRESS SubnetAddress;
    ulong             NumStatelessClientsAdded;
    ulong             NumStatelessClientsRemoved;
}

struct DHCPV6_STATELESS_STATS
{
    uint NumScopes;
    DHCPV6_STATELESS_SCOPE_STATS* ScopeStats;
}

struct DHCP_FAILOVER_RELATIONSHIP
{
    uint                 PrimaryServer;
    uint                 SecondaryServer;
    DHCP_FAILOVER_MODE   Mode;
    DHCP_FAILOVER_SERVER ServerType;
    FSM_STATE            State;
    FSM_STATE            PrevState;
    uint                 Mclt;
    uint                 SafePeriod;
    const(wchar)*        RelationshipName;
    const(wchar)*        PrimaryServerName;
    const(wchar)*        SecondaryServerName;
    DHCP_IP_ARRAY*       pScopes;
    ubyte                Percentage;
    const(wchar)*        SharedSecret;
}

struct DHCP_FAILOVER_RELATIONSHIP_ARRAY
{
    uint NumElements;
    DHCP_FAILOVER_RELATIONSHIP* pRelationships;
}

struct DHCPV4_FAILOVER_CLIENT_INFO
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)*    ClientName;
    const(wchar)*    ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
    QuarantineStatus Status;
    DATE_TIME        ProbationEnds;
    BOOL             QuarantineCapable;
    uint             SentPotExpTime;
    uint             AckPotExpTime;
    uint             RecvPotExpTime;
    uint             StartTime;
    uint             CltLastTransTime;
    uint             LastBndUpdTime;
    uint             BndMsgStatus;
    const(wchar)*    PolicyName;
    ubyte            Flags;
}

struct DHCPV4_FAILOVER_CLIENT_INFO_ARRAY
{
    uint NumElements;
    DHCPV4_FAILOVER_CLIENT_INFO** Clients;
}

struct DHCPV4_FAILOVER_CLIENT_INFO_EX
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    const(wchar)*    ClientName;
    const(wchar)*    ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
    QuarantineStatus Status;
    DATE_TIME        ProbationEnds;
    BOOL             QuarantineCapable;
    uint             SentPotExpTime;
    uint             AckPotExpTime;
    uint             RecvPotExpTime;
    uint             StartTime;
    uint             CltLastTransTime;
    uint             LastBndUpdTime;
    uint             BndMsgStatus;
    const(wchar)*    PolicyName;
    ubyte            Flags;
    uint             AddressStateEx;
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

// Functions

@DllImport("dhcpcsvc6")
void Dhcpv6CApiInitialize(uint* Version);

@DllImport("dhcpcsvc6")
void Dhcpv6CApiCleanup();

@DllImport("dhcpcsvc6")
uint Dhcpv6RequestParams(BOOL forceNewInform, void* reserved, const(wchar)* adapterName, 
                         DHCPV6CAPI_CLASSID* classId, DHCPV6CAPI_PARAMS_ARRAY recdParams, ubyte* buffer, uint* pSize);

@DllImport("dhcpcsvc6")
uint Dhcpv6RequestPrefix(const(wchar)* adapterName, DHCPV6CAPI_CLASSID* pclassId, 
                         DHCPV6PrefixLeaseInformation* prefixleaseInfo, uint* pdwTimeToWait);

@DllImport("dhcpcsvc6")
uint Dhcpv6RenewPrefix(const(wchar)* adapterName, DHCPV6CAPI_CLASSID* pclassId, 
                       DHCPV6PrefixLeaseInformation* prefixleaseInfo, uint* pdwTimeToWait, uint bValidatePrefix);

@DllImport("dhcpcsvc6")
uint Dhcpv6ReleasePrefix(const(wchar)* adapterName, DHCPV6CAPI_CLASSID* classId, 
                         DHCPV6PrefixLeaseInformation* leaseInfo);

@DllImport("dhcpcsvc")
uint DhcpCApiInitialize(uint* Version);

@DllImport("dhcpcsvc")
void DhcpCApiCleanup();

@DllImport("dhcpcsvc")
uint DhcpRequestParams(uint Flags, void* Reserved, const(wchar)* AdapterName, DHCPCAPI_CLASSID* ClassId, 
                       DHCPCAPI_PARAMS_ARRAY SendParams, DHCPCAPI_PARAMS_ARRAY RecdParams, char* Buffer, uint* pSize, 
                       const(wchar)* RequestIdStr);

@DllImport("dhcpcsvc")
uint DhcpUndoRequestParams(uint Flags, void* Reserved, const(wchar)* AdapterName, const(wchar)* RequestIdStr);

@DllImport("dhcpcsvc")
uint DhcpRegisterParamChange(uint Flags, void* Reserved, const(wchar)* AdapterName, DHCPCAPI_CLASSID* ClassId, 
                             DHCPCAPI_PARAMS_ARRAY Params, void* Handle);

@DllImport("dhcpcsvc")
uint DhcpDeRegisterParamChange(uint Flags, void* Reserved, void* Event);

@DllImport("dhcpcsvc")
uint DhcpRemoveDNSRegistrations();

@DllImport("dhcpcsvc")
uint DhcpGetOriginalSubnetMask(const(wchar)* sAdapterName, uint* dwSubnetMask);

@DllImport("DHCPSAPI")
uint DhcpAddFilterV4(const(wchar)* ServerIpAddress, DHCP_FILTER_ADD_INFO* AddFilterInfo, BOOL ForceFlag);

@DllImport("DHCPSAPI")
uint DhcpDeleteFilterV4(const(wchar)* ServerIpAddress, DHCP_ADDR_PATTERN* DeleteFilterInfo);

@DllImport("DHCPSAPI")
uint DhcpSetFilterV4(const(wchar)* ServerIpAddress, DHCP_FILTER_GLOBAL_INFO* GlobalFilterInfo);

@DllImport("DHCPSAPI")
uint DhcpGetFilterV4(const(wchar)* ServerIpAddress, DHCP_FILTER_GLOBAL_INFO* GlobalFilterInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumFilterV4(const(wchar)* ServerIpAddress, DHCP_ADDR_PATTERN* ResumeHandle, uint PreferredMaximum, 
                      DHCP_FILTER_LIST_TYPE ListType, DHCP_FILTER_ENUM_INFO** EnumFilterInfo, uint* ElementsRead, 
                      uint* ElementsTotal);

@DllImport("DHCPSAPI")
uint DhcpCreateSubnet(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO)* SubnetInfo);

@DllImport("DHCPSAPI")
uint DhcpSetSubnetInfo(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO)* SubnetInfo);

@DllImport("DHCPSAPI")
uint DhcpGetSubnetInfo(const(wchar)* ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_INFO** SubnetInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnets(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                     DHCP_IP_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI")
uint DhcpAddSubnetElement(const(wchar)* ServerIpAddress, uint SubnetAddress, 
                          const(DHCP_SUBNET_ELEMENT_DATA)* AddElementInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetElements(const(wchar)* ServerIpAddress, uint SubnetAddress, 
                            DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                            DHCP_SUBNET_ELEMENT_INFO_ARRAY** EnumElementInfo, uint* ElementsRead, 
                            uint* ElementsTotal);

@DllImport("DHCPSAPI")
uint DhcpRemoveSubnetElement(const(wchar)* ServerIpAddress, uint SubnetAddress, 
                             const(DHCP_SUBNET_ELEMENT_DATA)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI")
uint DhcpDeleteSubnet(const(wchar)* ServerIpAddress, uint SubnetAddress, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI")
uint DhcpCreateOption(const(wchar)* ServerIpAddress, uint OptionID, const(DHCP_OPTION)* OptionInfo);

@DllImport("DHCPSAPI")
uint DhcpSetOptionInfo(const(wchar)* ServerIpAddress, uint OptionID, const(DHCP_OPTION)* OptionInfo);

@DllImport("DHCPSAPI")
uint DhcpGetOptionInfo(const(wchar)* ServerIpAddress, uint OptionID, DHCP_OPTION** OptionInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumOptions(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                     DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

@DllImport("DHCPSAPI")
uint DhcpRemoveOption(const(wchar)* ServerIpAddress, uint OptionID);

@DllImport("DHCPSAPI")
uint DhcpSetOptionValue(const(wchar)* ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                        const(DHCP_OPTION_DATA)* OptionValue);

@DllImport("DHCPSAPI")
uint DhcpSetOptionValues(const(wchar)* ServerIpAddress, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                         const(DHCP_OPTION_VALUE_ARRAY)* OptionValues);

@DllImport("DHCPSAPI")
uint DhcpGetOptionValue(const(wchar)* ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                        DHCP_OPTION_VALUE** OptionValue);

@DllImport("DHCPSAPI")
uint DhcpEnumOptionValues(const(wchar)* ServerIpAddress, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                          uint* ResumeHandle, uint PreferredMaximum, DHCP_OPTION_VALUE_ARRAY** OptionValues, 
                          uint* OptionsRead, uint* OptionsTotal);

@DllImport("DHCPSAPI")
uint DhcpRemoveOptionValue(const(wchar)* ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo);

@DllImport("DHCPSAPI")
uint DhcpCreateClientInfoVQ(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_VQ)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpSetClientInfoVQ(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_VQ)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpGetClientInfoVQ(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                         DHCP_CLIENT_INFO_VQ** ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClientsVQ(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_VQ** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClientsFilterStatusInfo(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                                           uint PreferredMaximum, DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY** ClientInfo, 
                                           uint* ClientsRead, uint* ClientsTotal);

@DllImport("DHCPSAPI")
uint DhcpCreateClientInfo(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpSetClientInfo(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpGetClientInfo(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                       DHCP_CLIENT_INFO** ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpDeleteClientInfo(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClients(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                           uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY** ClientInfo, uint* ClientsRead, 
                           uint* ClientsTotal);

@DllImport("DHCPSAPI")
uint DhcpGetClientOptions(const(wchar)* ServerIpAddress, uint ClientIpAddress, uint ClientSubnetMask, 
                          DHCP_OPTION_LIST** ClientOptions);

@DllImport("DHCPSAPI")
uint DhcpGetMibInfo(const(wchar)* ServerIpAddress, DHCP_MIB_INFO** MibInfo);

@DllImport("DHCPSAPI")
uint DhcpServerSetConfig(const(wchar)* ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO* ConfigInfo);

@DllImport("DHCPSAPI")
uint DhcpServerGetConfig(const(wchar)* ServerIpAddress, DHCP_SERVER_CONFIG_INFO** ConfigInfo);

@DllImport("DHCPSAPI")
uint DhcpScanDatabase(const(wchar)* ServerIpAddress, uint SubnetAddress, uint FixFlag, DHCP_SCAN_LIST** ScanList);

@DllImport("DHCPSAPI")
void DhcpRpcFreeMemory(void* BufferPointer);

@DllImport("DHCPSAPI")
uint DhcpGetVersion(const(wchar)* ServerIpAddress, uint* MajorVersion, uint* MinorVersion);

@DllImport("DHCPSAPI")
uint DhcpAddSubnetElementV4(const(wchar)* ServerIpAddress, uint SubnetAddress, 
                            const(DHCP_SUBNET_ELEMENT_DATA_V4)* AddElementInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetElementsV4(const(wchar)* ServerIpAddress, uint SubnetAddress, 
                              DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                              DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4** EnumElementInfo, uint* ElementsRead, 
                              uint* ElementsTotal);

@DllImport("DHCPSAPI")
uint DhcpRemoveSubnetElementV4(const(wchar)* ServerIpAddress, uint SubnetAddress, 
                               const(DHCP_SUBNET_ELEMENT_DATA_V4)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI")
uint DhcpCreateClientInfoV4(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_V4)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpSetClientInfoV4(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_V4)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpGetClientInfoV4(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                         DHCP_CLIENT_INFO_V4** ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClientsV4(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_V4** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

@DllImport("DHCPSAPI")
uint DhcpServerSetConfigV4(const(wchar)* ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO_V4* ConfigInfo);

@DllImport("DHCPSAPI")
uint DhcpServerGetConfigV4(const(wchar)* ServerIpAddress, DHCP_SERVER_CONFIG_INFO_V4** ConfigInfo);

@DllImport("DHCPSAPI")
uint DhcpSetSuperScopeV4(const(wchar)* ServerIpAddress, const(uint) SubnetAddress, const(ushort)* SuperScopeName, 
                         const(int) ChangeExisting);

@DllImport("DHCPSAPI")
uint DhcpDeleteSuperScopeV4(const(wchar)* ServerIpAddress, const(ushort)* SuperScopeName);

@DllImport("DHCPSAPI")
uint DhcpGetSuperScopeInfoV4(const(wchar)* ServerIpAddress, DHCP_SUPER_SCOPE_TABLE** SuperScopeTable);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClientsV5(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_V5** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

@DllImport("DHCPSAPI")
uint DhcpCreateOptionV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionId, const(wchar)* ClassName, 
                        const(wchar)* VendorName, DHCP_OPTION* OptionInfo);

@DllImport("DHCPSAPI")
uint DhcpSetOptionInfoV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, 
                         const(wchar)* VendorName, DHCP_OPTION* OptionInfo);

@DllImport("DHCPSAPI")
uint DhcpGetOptionInfoV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, 
                         const(wchar)* VendorName, DHCP_OPTION** OptionInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumOptionsV5(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* ClassName, 
                       const(wchar)* VendorName, uint* ResumeHandle, uint PreferredMaximum, 
                       DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

@DllImport("DHCPSAPI")
uint DhcpRemoveOptionV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, 
                        const(wchar)* VendorName);

@DllImport("DHCPSAPI")
uint DhcpSetOptionValueV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionId, const(wchar)* ClassName, 
                          const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

@DllImport("DHCPSAPI")
uint DhcpSetOptionValuesV5(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* ClassName, 
                           const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, 
                           DHCP_OPTION_VALUE_ARRAY* OptionValues);

@DllImport("DHCPSAPI")
uint DhcpGetOptionValueV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, 
                          const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, 
                          DHCP_OPTION_VALUE** OptionValue);

@DllImport("DHCPSAPI")
uint DhcpGetOptionValueV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, 
                          const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, 
                          DHCP_OPTION_VALUE** OptionValue);

@DllImport("DHCPSAPI")
uint DhcpEnumOptionValuesV5(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* ClassName, 
                            const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, uint* ResumeHandle, 
                            uint PreferredMaximum, DHCP_OPTION_VALUE_ARRAY** OptionValues, uint* OptionsRead, 
                            uint* OptionsTotal);

@DllImport("DHCPSAPI")
uint DhcpRemoveOptionValueV5(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, 
                             const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo);

@DllImport("DHCPSAPI")
uint DhcpCreateClass(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* ClassInfo);

@DllImport("DHCPSAPI")
uint DhcpModifyClass(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* ClassInfo);

@DllImport("DHCPSAPI")
uint DhcpDeleteClass(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, const(wchar)* ClassName);

@DllImport("DHCPSAPI")
uint DhcpGetClassInfo(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* PartialClassInfo, 
                      DHCP_CLASS_INFO** FilledClassInfo);

@DllImport("dhcpcsvc")
uint DhcpEnumClasses(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, uint* ResumeHandle, 
                     uint PreferredMaximum, DHCP_CLASS_INFO_ARRAY** ClassInfoArray, uint* nRead, uint* nTotal);

@DllImport("DHCPSAPI")
uint DhcpGetAllOptions(const(wchar)* ServerIpAddress, uint Flags, DHCP_ALL_OPTIONS** OptionStruct);

@DllImport("DHCPSAPI")
uint DhcpGetAllOptionsV6(const(wchar)* ServerIpAddress, uint Flags, DHCP_ALL_OPTIONS** OptionStruct);

@DllImport("DHCPSAPI")
uint DhcpGetAllOptionValues(const(wchar)* ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO* ScopeInfo, 
                            DHCP_ALL_OPTION_VALUES** Values);

@DllImport("DHCPSAPI")
uint DhcpGetAllOptionValuesV6(const(wchar)* ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, 
                              DHCP_ALL_OPTION_VALUES** Values);

@DllImport("DHCPSAPI")
uint DhcpEnumServers(uint Flags, void* IdInfo, DHCPDS_SERVERS** Servers, void* CallbackFn, void* CallbackData);

@DllImport("DHCPSAPI")
uint DhcpAddServer(uint Flags, void* IdInfo, DHCPDS_SERVER* NewServer, void* CallbackFn, void* CallbackData);

@DllImport("DHCPSAPI")
uint DhcpDeleteServer(uint Flags, void* IdInfo, DHCPDS_SERVER* NewServer, void* CallbackFn, void* CallbackData);

@DllImport("DHCPSAPI")
uint DhcpGetServerBindingInfo(const(wchar)* ServerIpAddress, uint Flags, 
                              DHCP_BIND_ELEMENT_ARRAY** BindElementsInfo);

@DllImport("DHCPSAPI")
uint DhcpSetServerBindingInfo(const(wchar)* ServerIpAddress, uint Flags, DHCP_BIND_ELEMENT_ARRAY* BindElementInfo);

@DllImport("DHCPSAPI")
uint DhcpAddSubnetElementV5(const(wchar)* ServerIpAddress, uint SubnetAddress, 
                            const(DHCP_SUBNET_ELEMENT_DATA_V5)* AddElementInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetElementsV5(const(wchar)* ServerIpAddress, uint SubnetAddress, 
                              DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                              DHCP_SUBNET_ELEMENT_INFO_ARRAY_V5** EnumElementInfo, uint* ElementsRead, 
                              uint* ElementsTotal);

@DllImport("DHCPSAPI")
uint DhcpRemoveSubnetElementV5(const(wchar)* ServerIpAddress, uint SubnetAddress, 
                               const(DHCP_SUBNET_ELEMENT_DATA_V5)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI")
uint DhcpV4EnumSubnetReservations(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                                  uint PreferredMaximum, DHCP_RESERVATION_INFO_ARRAY** EnumElementInfo, 
                                  uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI")
uint DhcpCreateOptionV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionId, const(wchar)* ClassName, 
                        const(wchar)* VendorName, DHCP_OPTION* OptionInfo);

@DllImport("DHCPSAPI")
uint DhcpRemoveOptionV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, 
                        const(wchar)* VendorName);

@DllImport("DHCPSAPI")
uint DhcpEnumOptionsV6(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* ClassName, 
                       const(wchar)* VendorName, uint* ResumeHandle, uint PreferredMaximum, 
                       DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

@DllImport("DHCPSAPI")
uint DhcpRemoveOptionValueV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, 
                             const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO6* ScopeInfo);

@DllImport("DHCPSAPI")
uint DhcpGetOptionInfoV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, 
                         const(wchar)* VendorName, DHCP_OPTION** OptionInfo);

@DllImport("DHCPSAPI")
uint DhcpSetOptionInfoV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* ClassName, 
                         const(wchar)* VendorName, DHCP_OPTION* OptionInfo);

@DllImport("DHCPSAPI")
uint DhcpSetOptionValueV6(const(wchar)* ServerIpAddress, uint Flags, uint OptionId, const(wchar)* ClassName, 
                          const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, 
                          DHCP_OPTION_DATA* OptionValue);

@DllImport("DHCPSAPI")
uint DhcpGetSubnetInfoVQ(const(wchar)* ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_INFO_VQ** SubnetInfo);

@DllImport("DHCPSAPI")
uint DhcpCreateSubnetVQ(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO_VQ)* SubnetInfo);

@DllImport("DHCPSAPI")
uint DhcpSetSubnetInfoVQ(const(wchar)* ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO_VQ)* SubnetInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumOptionValuesV6(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* ClassName, 
                            const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, uint* ResumeHandle, 
                            uint PreferredMaximum, DHCP_OPTION_VALUE_ARRAY** OptionValues, uint* OptionsRead, 
                            uint* OptionsTotal);

@DllImport("DHCPSAPI")
uint DhcpDsInit();

@DllImport("DHCPSAPI")
void DhcpDsCleanup();

@DllImport("DHCPSAPI")
uint DhcpSetThreadOptions(uint Flags, void* Reserved);

@DllImport("DHCPSAPI")
uint DhcpGetThreadOptions(uint* pFlags, void* Reserved);

@DllImport("DHCPSAPI")
uint DhcpServerQueryAttribute(const(wchar)* ServerIpAddr, uint dwReserved, uint DhcpAttribId, 
                              DHCP_ATTRIB** pDhcpAttrib);

@DllImport("DHCPSAPI")
uint DhcpServerQueryAttributes(const(wchar)* ServerIpAddr, uint dwReserved, uint dwAttribCount, uint* pDhcpAttribs, 
                               DHCP_ATTRIB_ARRAY** pDhcpAttribArr);

@DllImport("DHCPSAPI")
uint DhcpServerRedoAuthorization(const(wchar)* ServerIpAddr, uint dwReserved);

@DllImport("DHCPSAPI")
uint DhcpAuditLogSetParams(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* AuditLogDir, 
                           uint DiskCheckInterval, uint MaxLogFilesSize, uint MinSpaceOnDisk);

@DllImport("DHCPSAPI")
uint DhcpAuditLogGetParams(const(wchar)* ServerIpAddress, uint Flags, ushort** AuditLogDir, 
                           uint* DiskCheckInterval, uint* MaxLogFilesSize, uint* MinSpaceOnDisk);

@DllImport("DHCPSAPI")
uint DhcpServerQueryDnsRegCredentials(const(wchar)* ServerIpAddress, uint UnameSize, const(wchar)* Uname, 
                                      uint DomainSize, const(wchar)* Domain);

@DllImport("DHCPSAPI")
uint DhcpServerSetDnsRegCredentials(const(wchar)* ServerIpAddress, const(wchar)* Uname, const(wchar)* Domain, 
                                    const(wchar)* Passwd);

@DllImport("DHCPSAPI")
uint DhcpServerSetDnsRegCredentialsV5(const(wchar)* ServerIpAddress, const(wchar)* Uname, const(wchar)* Domain, 
                                      const(wchar)* Passwd);

@DllImport("DHCPSAPI")
uint DhcpServerBackupDatabase(const(wchar)* ServerIpAddress, const(wchar)* Path);

@DllImport("DHCPSAPI")
uint DhcpServerRestoreDatabase(const(wchar)* ServerIpAddress, const(wchar)* Path);

@DllImport("DHCPSAPI")
uint DhcpServerSetConfigVQ(const(wchar)* ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO_VQ* ConfigInfo);

@DllImport("DHCPSAPI")
uint DhcpServerGetConfigVQ(const(wchar)* ServerIpAddress, DHCP_SERVER_CONFIG_INFO_VQ** ConfigInfo);

@DllImport("DHCPSAPI")
uint DhcpGetServerSpecificStrings(const(wchar)* ServerIpAddress, 
                                  DHCP_SERVER_SPECIFIC_STRINGS** ServerSpecificStrings);

@DllImport("DHCPSAPI")
void DhcpServerAuditlogParamsFree(DHCP_SERVER_CONFIG_INFO_VQ* ConfigInfo);

@DllImport("DHCPSAPI")
uint DhcpCreateSubnetV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                        DHCP_SUBNET_INFO_V6* SubnetInfo);

@DllImport("DHCPSAPI")
uint DhcpDeleteSubnetV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetsV6(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                       DHCPV6_IP_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

@DllImport("DHCPSAPI")
uint DhcpAddSubnetElementV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                            DHCP_SUBNET_ELEMENT_DATA_V6* AddElementInfo);

@DllImport("DHCPSAPI")
uint DhcpRemoveSubnetElementV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                               DHCP_SUBNET_ELEMENT_DATA_V6* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetElementsV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                              DHCP_SUBNET_ELEMENT_TYPE_V6 EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                              DHCP_SUBNET_ELEMENT_INFO_ARRAY_V6** EnumElementInfo, uint* ElementsRead, 
                              uint* ElementsTotal);

@DllImport("DHCPSAPI")
uint DhcpGetSubnetInfoV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                         DHCP_SUBNET_INFO_V6** SubnetInfo);

@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClientsV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                             DHCP_IPV6_ADDRESS* ResumeHandle, uint PreferredMaximum, 
                             DHCP_CLIENT_INFO_ARRAY_V6** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

@DllImport("DHCPSAPI")
uint DhcpServerGetConfigV6(const(wchar)* ServerIpAddress, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, 
                           DHCP_SERVER_CONFIG_INFO_V6** ConfigInfo);

@DllImport("DHCPSAPI")
uint DhcpServerSetConfigV6(const(wchar)* ServerIpAddress, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, uint FieldsToSet, 
                           DHCP_SERVER_CONFIG_INFO_V6* ConfigInfo);

@DllImport("DHCPSAPI")
uint DhcpSetSubnetInfoV6(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                         DHCP_SUBNET_INFO_V6* SubnetInfo);

@DllImport("DHCPSAPI")
uint DhcpGetMibInfoV6(const(wchar)* ServerIpAddress, DHCP_MIB_INFO_V6** MibInfo);

@DllImport("DHCPSAPI")
uint DhcpGetServerBindingInfoV6(const(wchar)* ServerIpAddress, uint Flags, 
                                DHCPV6_BIND_ELEMENT_ARRAY** BindElementsInfo);

@DllImport("DHCPSAPI")
uint DhcpSetServerBindingInfoV6(const(wchar)* ServerIpAddress, uint Flags, 
                                DHCPV6_BIND_ELEMENT_ARRAY* BindElementInfo);

@DllImport("DHCPSAPI")
uint DhcpSetClientInfoV6(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_V6)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpGetClientInfoV6(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO_V6)* SearchInfo, 
                         DHCP_CLIENT_INFO_V6** ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpDeleteClientInfoV6(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO_V6)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpCreateClassV6(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO_V6* ClassInfo);

@DllImport("DHCPSAPI")
uint DhcpModifyClassV6(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO_V6* ClassInfo);

@DllImport("DHCPSAPI")
uint DhcpDeleteClassV6(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, const(wchar)* ClassName);

@DllImport("DHCPSAPI")
uint DhcpEnumClassesV6(const(wchar)* ServerIpAddress, uint ReservedMustBeZero, uint* ResumeHandle, 
                       uint PreferredMaximum, DHCP_CLASS_INFO_ARRAY_V6** ClassInfoArray, uint* nRead, uint* nTotal);

@DllImport("DHCPSAPI")
uint DhcpSetSubnetDelayOffer(const(wchar)* ServerIpAddress, uint SubnetAddress, ushort TimeDelayInMilliseconds);

@DllImport("DHCPSAPI")
uint DhcpGetSubnetDelayOffer(const(wchar)* ServerIpAddress, uint SubnetAddress, ushort* TimeDelayInMilliseconds);

@DllImport("DHCPSAPI")
uint DhcpGetMibInfoV5(const(wchar)* ServerIpAddress, DHCP_MIB_INFO_V5** MibInfo);

@DllImport("DHCPSAPI")
uint DhcpAddSecurityGroup(const(wchar)* pServer);

@DllImport("DHCPSAPI")
uint DhcpV4GetOptionValue(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* PolicyName, 
                          const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, 
                          DHCP_OPTION_VALUE** OptionValue);

@DllImport("DHCPSAPI")
uint DhcpV4SetOptionValue(const(wchar)* ServerIpAddress, uint Flags, uint OptionId, const(wchar)* PolicyName, 
                          const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

@DllImport("DHCPSAPI")
uint DhcpV4SetOptionValues(const(wchar)* ServerIpAddress, uint Flags, const(wchar)* PolicyName, 
                           const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo, 
                           DHCP_OPTION_VALUE_ARRAY* OptionValues);

@DllImport("DHCPSAPI")
uint DhcpV4RemoveOptionValue(const(wchar)* ServerIpAddress, uint Flags, uint OptionID, const(wchar)* PolicyName, 
                             const(wchar)* VendorName, DHCP_OPTION_SCOPE_INFO* ScopeInfo);

@DllImport("DHCPSAPI")
uint DhcpV4GetAllOptionValues(const(wchar)* ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO* ScopeInfo, 
                              DHCP_ALL_OPTION_VALUES_PB** Values);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverCreateRelationship(const(wchar)* ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverSetRelationship(const(wchar)* ServerIpAddress, uint Flags, 
                                   DHCP_FAILOVER_RELATIONSHIP* pRelationship);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverDeleteRelationship(const(wchar)* ServerIpAddress, const(wchar)* pRelationshipName);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetRelationship(const(wchar)* ServerIpAddress, const(wchar)* pRelationshipName, 
                                   DHCP_FAILOVER_RELATIONSHIP** pRelationship);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverEnumRelationship(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                                    DHCP_FAILOVER_RELATIONSHIP_ARRAY** pRelationship, uint* RelationshipRead, 
                                    uint* RelationshipTotal);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverAddScopeToRelationship(const(wchar)* ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverDeleteScopeFromRelationship(const(wchar)* ServerIpAddress, 
                                               DHCP_FAILOVER_RELATIONSHIP* pRelationship);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetScopeRelationship(const(wchar)* ServerIpAddress, uint ScopeId, 
                                        DHCP_FAILOVER_RELATIONSHIP** pRelationship);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetScopeStatistics(const(wchar)* ServerIpAddress, uint ScopeId, 
                                      DHCP_FAILOVER_STATISTICS** pStats);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetClientInfo(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                                 DHCPV4_FAILOVER_CLIENT_INFO** ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetSystemTime(const(wchar)* ServerIpAddress, uint* pTime, uint* pMaxAllowedDeltaTime);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetAddressStatus(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* pStatus);

@DllImport("DHCPSAPI")
uint DhcpV4FailoverTriggerAddrAllocation(const(wchar)* ServerIpAddress, const(wchar)* pFailRelName);

@DllImport("DHCPSAPI")
uint DhcpHlprCreateV4Policy(const(wchar)* PolicyName, BOOL fGlobalPolicy, uint Subnet, uint ProcessingOrder, 
                            DHCP_POL_LOGIC_OPER RootOperator, const(wchar)* Description, BOOL Enabled, 
                            DHCP_POLICY** Policy);

@DllImport("DHCPSAPI")
uint DhcpHlprCreateV4PolicyEx(const(wchar)* PolicyName, BOOL fGlobalPolicy, uint Subnet, uint ProcessingOrder, 
                              DHCP_POL_LOGIC_OPER RootOperator, const(wchar)* Description, BOOL Enabled, 
                              DHCP_POLICY_EX** Policy);

@DllImport("DHCPSAPI")
uint DhcpHlprAddV4PolicyExpr(DHCP_POLICY* Policy, uint ParentExpr, DHCP_POL_LOGIC_OPER Operator, uint* ExprIndex);

@DllImport("DHCPSAPI")
uint DhcpHlprAddV4PolicyCondition(DHCP_POLICY* Policy, uint ParentExpr, DHCP_POL_ATTR_TYPE Type, uint OptionID, 
                                  uint SubOptionID, const(wchar)* VendorName, DHCP_POL_COMPARATOR Operator, 
                                  char* Value, uint ValueLength, uint* ConditionIndex);

@DllImport("DHCPSAPI")
uint DhcpHlprAddV4PolicyRange(DHCP_POLICY* Policy, DHCP_IP_RANGE* Range);

@DllImport("DHCPSAPI")
uint DhcpHlprResetV4PolicyExpr(DHCP_POLICY* Policy);

@DllImport("DHCPSAPI")
uint DhcpHlprModifyV4PolicyExpr(DHCP_POLICY* Policy, DHCP_POL_LOGIC_OPER Operator);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4Policy(DHCP_POLICY* Policy);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4PolicyArray(DHCP_POLICY_ARRAY* PolicyArray);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4PolicyEx(DHCP_POLICY_EX* PolicyEx);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4PolicyExArray(DHCP_POLICY_EX_ARRAY* PolicyExArray);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4DhcpProperty(DHCP_PROPERTY* Property);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4DhcpPropertyArray(DHCP_PROPERTY_ARRAY* PropertyArray);

@DllImport("DHCPSAPI")
DHCP_PROPERTY* DhcpHlprFindV4DhcpProperty(DHCP_PROPERTY_ARRAY* PropertyArray, DHCP_PROPERTY_ID ID, 
                                          DHCP_PROPERTY_TYPE Type);

@DllImport("DHCPSAPI")
BOOL DhcpHlprIsV4PolicySingleUC(DHCP_POLICY* Policy);

@DllImport("DHCPSAPI")
uint DhcpV4QueryPolicyEnforcement(const(wchar)* ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, 
                                  int* Enabled);

@DllImport("DHCPSAPI")
uint DhcpV4SetPolicyEnforcement(const(wchar)* ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, BOOL Enable);

@DllImport("DHCPSAPI")
BOOL DhcpHlprIsV4PolicyWellFormed(DHCP_POLICY* pPolicy);

@DllImport("DHCPSAPI")
uint DhcpHlprIsV4PolicyValid(DHCP_POLICY* pPolicy);

@DllImport("DHCPSAPI")
uint DhcpV4CreatePolicy(const(wchar)* ServerIpAddress, DHCP_POLICY* pPolicy);

@DllImport("DHCPSAPI")
uint DhcpV4GetPolicy(const(wchar)* ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, 
                     const(wchar)* PolicyName, DHCP_POLICY** Policy);

@DllImport("DHCPSAPI")
uint DhcpV4SetPolicy(const(wchar)* ServerIpAddress, uint FieldsModified, BOOL fGlobalPolicy, uint SubnetAddress, 
                     const(wchar)* PolicyName, DHCP_POLICY* Policy);

@DllImport("DHCPSAPI")
uint DhcpV4DeletePolicy(const(wchar)* ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, 
                        const(wchar)* PolicyName);

@DllImport("DHCPSAPI")
uint DhcpV4EnumPolicies(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                        BOOL fGlobalPolicy, uint SubnetAddress, DHCP_POLICY_ARRAY** EnumInfo, uint* ElementsRead, 
                        uint* ElementsTotal);

@DllImport("DHCPSAPI")
uint DhcpV4AddPolicyRange(const(wchar)* ServerIpAddress, uint SubnetAddress, const(wchar)* PolicyName, 
                          DHCP_IP_RANGE* Range);

@DllImport("DHCPSAPI")
uint DhcpV4RemovePolicyRange(const(wchar)* ServerIpAddress, uint SubnetAddress, const(wchar)* PolicyName, 
                             DHCP_IP_RANGE* Range);

@DllImport("DHCPSAPI")
uint DhcpV6SetStatelessStoreParams(const(wchar)* ServerIpAddress, BOOL fServerLevel, 
                                   DHCP_IPV6_ADDRESS SubnetAddress, uint FieldModified, 
                                   DHCPV6_STATELESS_PARAMS* Params);

@DllImport("DHCPSAPI")
uint DhcpV6GetStatelessStoreParams(const(wchar)* ServerIpAddress, BOOL fServerLevel, 
                                   DHCP_IPV6_ADDRESS SubnetAddress, DHCPV6_STATELESS_PARAMS** Params);

@DllImport("DHCPSAPI")
uint DhcpV6GetStatelessStatistics(const(wchar)* ServerIpAddress, DHCPV6_STATELESS_STATS** StatelessStats);

@DllImport("DHCPSAPI")
uint DhcpV4CreateClientInfo(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_PB)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpV4EnumSubnetClients(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_PB_ARRAY** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

@DllImport("DHCPSAPI")
uint DhcpV4GetClientInfo(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                         DHCP_CLIENT_INFO_PB** ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpV6CreateClientInfo(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_V6)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpV4GetFreeIPAddress(const(wchar)* ServerIpAddress, uint ScopeId, uint StartIP, uint EndIP, 
                            uint NumFreeAddrReq, DHCP_IP_ARRAY** IPAddrList);

@DllImport("DHCPSAPI")
uint DhcpV6GetFreeIPAddress(const(wchar)* ServerIpAddress, DHCP_IPV6_ADDRESS ScopeId, DHCP_IPV6_ADDRESS StartIP, 
                            DHCP_IPV6_ADDRESS EndIP, uint NumFreeAddrReq, DHCPV6_IP_ARRAY** IPAddrList);

@DllImport("DHCPSAPI")
uint DhcpV4CreateClientInfoEx(const(wchar)* ServerIpAddress, const(DHCP_CLIENT_INFO_EX)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpV4EnumSubnetClientsEx(const(wchar)* ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                               uint PreferredMaximum, DHCP_CLIENT_INFO_EX_ARRAY** ClientInfo, uint* ClientsRead, 
                               uint* ClientsTotal);

@DllImport("DHCPSAPI")
uint DhcpV4GetClientInfoEx(const(wchar)* ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                           DHCP_CLIENT_INFO_EX** ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpV4CreatePolicyEx(const(wchar)* ServerIpAddress, DHCP_POLICY_EX* PolicyEx);

@DllImport("DHCPSAPI")
uint DhcpV4GetPolicyEx(const(wchar)* ServerIpAddress, BOOL GlobalPolicy, uint SubnetAddress, 
                       const(wchar)* PolicyName, DHCP_POLICY_EX** Policy);

@DllImport("DHCPSAPI")
uint DhcpV4SetPolicyEx(const(wchar)* ServerIpAddress, uint FieldsModified, BOOL GlobalPolicy, uint SubnetAddress, 
                       const(wchar)* PolicyName, DHCP_POLICY_EX* Policy);

@DllImport("DHCPSAPI")
uint DhcpV4EnumPoliciesEx(const(wchar)* ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                          BOOL GlobalPolicy, uint SubnetAddress, DHCP_POLICY_EX_ARRAY** EnumInfo, uint* ElementsRead, 
                          uint* ElementsTotal);


