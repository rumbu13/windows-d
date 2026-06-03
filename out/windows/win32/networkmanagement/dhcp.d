// Written in the D programming language.

module windows.win32.networkmanagement.dhcp;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpv6csdk/ne-dhcpv6csdk-statuscode
enum StatusCode : int
{
    STATUS_NO_ERROR            = 0x00000000,
    STATUS_UNSPECIFIED_FAILURE = 0x00000001,
    STATUS_NO_BINDING          = 0x00000003,
    STATUS_NOPREFIX_AVAIL      = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_force_flag
alias DHCP_FORCE_FLAG = int;
enum : int
{
    DhcpFullForce     = 0x00000000,
    DhcpNoForce       = 0x00000001,
    DhcpFailoverForce = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_subnet_state
alias DHCP_SUBNET_STATE = int;
enum : int
{
    DhcpSubnetEnabled          = 0x00000000,
    DhcpSubnetDisabled         = 0x00000001,
    DhcpSubnetEnabledSwitched  = 0x00000002,
    DhcpSubnetDisabledSwitched = 0x00000003,
    DhcpSubnetInvalidState     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_subnet_element_type
alias DHCP_SUBNET_ELEMENT_TYPE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_filter_list_type
alias DHCP_FILTER_LIST_TYPE = int;
enum : int
{
    Deny    = 0x00000000,
    Allow   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_option_data_type
alias DHCP_OPTION_DATA_TYPE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_option_type
alias DHCP_OPTION_TYPE = int;
enum : int
{
    DhcpUnaryElementTypeOption = 0x00000000,
    DhcpArrayTypeOption        = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_option_scope_type
alias DHCP_OPTION_SCOPE_TYPE = int;
enum : int
{
    DhcpDefaultOptions  = 0x00000000,
    DhcpGlobalOptions   = 0x00000001,
    DhcpSubnetOptions   = 0x00000002,
    DhcpReservedOptions = 0x00000003,
    DhcpMScopeOptions   = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_option_scope_type6
alias DHCP_OPTION_SCOPE_TYPE6 = int;
enum : int
{
    DhcpDefaultOptions6  = 0x00000000,
    DhcpScopeOptions6    = 0x00000001,
    DhcpReservedOptions6 = 0x00000002,
    DhcpGlobalOptions6   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-quarantinestatus
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_search_info_type
alias DHCP_SEARCH_INFO_TYPE = int;
enum : int
{
    DhcpClientIpAddress       = 0x00000000,
    DhcpClientHardwareAddress = 0x00000001,
    DhcpClientName            = 0x00000002,
}

alias DHCP_PROPERTY_TYPE = int;
enum : int
{
    DhcpPropTypeByte   = 0x00000000,
    DhcpPropTypeWord   = 0x00000001,
    DhcpPropTypeDword  = 0x00000002,
    DhcpPropTypeString = 0x00000003,
    DhcpPropTypeBinary = 0x00000004,
}

alias DHCP_PROPERTY_ID = int;
enum : int
{
    DhcpPropIdPolicyDnsSuffix      = 0x00000000,
    DhcpPropIdClientAddressStateEx = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_scan_flag
alias DHCP_SCAN_FLAG = int;
enum : int
{
    DhcpRegistryFix = 0x00000000,
    DhcpDatabaseFix = 0x00000001,
}

alias DHCP_SUBNET_ELEMENT_TYPE_V6 = int;
enum : int
{
    Dhcpv6IpRanges         = 0x00000000,
    Dhcpv6ReservedIps      = 0x00000001,
    Dhcpv6ExcludedIpRanges = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_search_info_type_v6
alias DHCP_SEARCH_INFO_TYPE_V6 = int;
enum : int
{
    Dhcpv6ClientIpAddress = 0x00000000,
    Dhcpv6ClientDUID      = 0x00000001,
    Dhcpv6ClientName      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_pol_attr_type
alias DHCP_POL_ATTR_TYPE = int;
enum : int
{
    DhcpAttrHWAddr          = 0x00000000,
    DhcpAttrOption          = 0x00000001,
    DhcpAttrSubOption       = 0x00000002,
    DhcpAttrFqdn            = 0x00000003,
    DhcpAttrFqdnSingleLabel = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_pol_comparator
alias DHCP_POL_COMPARATOR = int;
enum : int
{
    DhcpCompEqual        = 0x00000000,
    DhcpCompNotEqual     = 0x00000001,
    DhcpCompBeginsWith   = 0x00000002,
    DhcpCompNotBeginWith = 0x00000003,
    DhcpCompEndsWith     = 0x00000004,
    DhcpCompNotEndWith   = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_pol_logic_oper
alias DHCP_POL_LOGIC_OPER = int;
enum : int
{
    DhcpLogicalOr  = 0x00000000,
    DhcpLogicalAnd = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_policy_fields_to_update
alias DHCP_POLICY_FIELDS_TO_UPDATE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcpv6_stateless_param_type
alias DHCPV6_STATELESS_PARAM_TYPE = int;
enum : int
{
    DhcpStatelessPurgeInterval = 0x00000001,
    DhcpStatelessStatus        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_failover_mode
alias DHCP_FAILOVER_MODE = int;
enum : int
{
    LoadBalance = 0x00000000,
    HotStandby  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-dhcp_failover_server
alias DHCP_FAILOVER_SERVER = int;
enum : int
{
    PrimaryServer   = 0x00000000,
    SecondaryServer = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ne-dhcpsapi-fsm_state
alias FSM_STATE = int;
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

// Constants


enum : uint
{
    OPTION_PAD         = 0x00000000U,
    OPTION_SUBNET_MASK = 0x00000001U,
}

enum uint OPTION_TIME_OFFSET = 0x00000002U;
enum uint OPTION_ROUTER_ADDRESS = 0x00000003U;
enum uint OPTION_TIME_SERVERS = 0x00000004U;
enum uint OPTION_IEN116_NAME_SERVERS = 0x00000005U;
enum uint OPTION_DOMAIN_NAME_SERVERS = 0x00000006U;
enum uint OPTION_LOG_SERVERS = 0x00000007U;
enum uint OPTION_COOKIE_SERVERS = 0x00000008U;
enum uint OPTION_LPR_SERVERS = 0x00000009U;
enum uint OPTION_IMPRESS_SERVERS = 0x0000000aU;
enum uint OPTION_RLP_SERVERS = 0x0000000bU;

enum : uint
{
    OPTION_HOST_NAME      = 0x0000000cU,
    OPTION_BOOT_FILE_SIZE = 0x0000000dU,
}

enum uint OPTION_MERIT_DUMP_FILE = 0x0000000eU;
enum uint OPTION_DOMAIN_NAME = 0x0000000fU;
enum uint OPTION_SWAP_SERVER = 0x00000010U;

enum : uint
{
    OPTION_ROOT_DISK       = 0x00000011U,
    OPTION_EXTENSIONS_PATH = 0x00000012U,
}

enum uint OPTION_BE_A_ROUTER = 0x00000013U;
enum uint OPTION_NON_LOCAL_SOURCE_ROUTING = 0x00000014U;
enum uint OPTION_POLICY_FILTER_FOR_NLSR = 0x00000015U;
enum uint OPTION_MAX_REASSEMBLY_SIZE = 0x00000016U;
enum uint OPTION_DEFAULT_TTL = 0x00000017U;

enum : uint
{
    OPTION_PMTU_AGING_TIMEOUT = 0x00000018U,
    OPTION_PMTU_PLATEAU_TABLE = 0x00000019U,
}

enum : uint
{
    OPTION_MTU             = 0x0000001aU,
    OPTION_ALL_SUBNETS_MTU = 0x0000001bU,
}

enum uint OPTION_BROADCAST_ADDRESS = 0x0000001cU;
enum uint OPTION_PERFORM_MASK_DISCOVERY = 0x0000001dU;
enum uint OPTION_BE_A_MASK_SUPPLIER = 0x0000001eU;
enum uint OPTION_PERFORM_ROUTER_DISCOVERY = 0x0000001fU;
enum uint OPTION_ROUTER_SOLICITATION_ADDR = 0x00000020U;
enum uint OPTION_STATIC_ROUTES = 0x00000021U;

enum : uint
{
    OPTION_TRAILERS          = 0x00000022U,
    OPTION_ARP_CACHE_TIMEOUT = 0x00000023U,
}

enum uint OPTION_ETHERNET_ENCAPSULATION = 0x00000024U;

enum : uint
{
    OPTION_TTL                  = 0x00000025U,
    OPTION_KEEP_ALIVE_INTERVAL  = 0x00000026U,
    OPTION_KEEP_ALIVE_DATA_SIZE = 0x00000027U,
}

enum : uint
{
    OPTION_NETWORK_INFO_SERVICE_DOM = 0x00000028U,
    OPTION_NETWORK_INFO_SERVERS     = 0x00000029U,
    OPTION_NETWORK_TIME_SERVERS     = 0x0000002aU,
}

enum uint OPTION_VENDOR_SPEC_INFO = 0x0000002bU;

enum : uint
{
    OPTION_NETBIOS_NAME_SERVER     = 0x0000002cU,
    OPTION_NETBIOS_DATAGRAM_SERVER = 0x0000002dU,
    OPTION_NETBIOS_NODE_TYPE       = 0x0000002eU,
    OPTION_NETBIOS_SCOPE_OPTION    = 0x0000002fU,
}

enum : uint
{
    OPTION_XWINDOW_FONT_SERVER     = 0x00000030U,
    OPTION_XWINDOW_DISPLAY_MANAGER = 0x00000031U,
}

enum uint OPTION_REQUESTED_ADDRESS = 0x00000032U;

enum : uint
{
    OPTION_LEASE_TIME    = 0x00000033U,
    OPTION_OK_TO_OVERLAY = 0x00000034U,
}

enum uint OPTION_MESSAGE_TYPE = 0x00000035U;
enum uint OPTION_SERVER_IDENTIFIER = 0x00000036U;
enum uint OPTION_PARAMETER_REQUEST_LIST = 0x00000037U;

enum : uint
{
    OPTION_MESSAGE        = 0x00000038U,
    OPTION_MESSAGE_LENGTH = 0x00000039U,
}

enum : uint
{
    OPTION_RENEWAL_TIME = 0x0000003aU,
    OPTION_REBIND_TIME  = 0x0000003bU,
}

enum : uint
{
    OPTION_CLIENT_CLASS_INFO = 0x0000003cU,
    OPTION_CLIENT_ID         = 0x0000003dU,
    OPTION_TFTP_SERVER_NAME  = 0x00000042U,
}

enum uint OPTION_BOOTFILE_NAME = 0x00000043U;
enum uint OPTION_IPV6_ONLY_PREFERRED = 0x0000006cU;

enum : uint
{
    OPTION_DNR           = 0x000000a2U,
    OPTION_MSFT_IE_PROXY = 0x000000fcU,
}

enum uint OPTION_END = 0x000000ffU;

enum : uint
{
    DHCPCAPI_REQUEST_PERSISTENT    = 0x00000001U,
    DHCPCAPI_REQUEST_SYNCHRONOUS   = 0x00000002U,
    DHCPCAPI_REQUEST_ASYNCHRONOUS  = 0x00000004U,
    DHCPCAPI_REQUEST_CANCEL        = 0x00000008U,
    DHCPCAPI_REQUEST_MASK          = 0x0000000fU,
    DHCPCAPI_REGISTER_HANDLE_EVENT = 0x00000001U,
}

enum uint DHCPCAPI_DEREGISTER_HANDLE_EVENT = 0x00000001U;
enum uint ERROR_DHCP_REGISTRY_INIT_FAILED = 0x00004e20U;
enum uint ERROR_DHCP_DATABASE_INIT_FAILED = 0x00004e21U;

enum : uint
{
    ERROR_DHCP_RPC_INIT_FAILED     = 0x00004e22U,
    ERROR_DHCP_NETWORK_INIT_FAILED = 0x00004e23U,
}

enum : uint
{
    ERROR_DHCP_SUBNET_EXITS       = 0x00004e24U,
    ERROR_DHCP_SUBNET_NOT_PRESENT = 0x00004e25U,
}

enum uint ERROR_DHCP_PRIMARY_NOT_FOUND = 0x00004e26U;
enum uint ERROR_DHCP_ELEMENT_CANT_REMOVE = 0x00004e27U;

enum : uint
{
    ERROR_DHCP_OPTION_EXITS       = 0x00004e29U,
    ERROR_DHCP_OPTION_NOT_PRESENT = 0x00004e2aU,
}

enum uint ERROR_DHCP_ADDRESS_NOT_AVAILABLE = 0x00004e2bU;

enum : uint
{
    ERROR_DHCP_RANGE_FULL           = 0x00004e2cU,
    ERROR_DHCP_JET_ERROR            = 0x00004e2dU,
    ERROR_DHCP_CLIENT_EXISTS        = 0x00004e2eU,
    ERROR_DHCP_INVALID_DHCP_MESSAGE = 0x00004e2fU,
    ERROR_DHCP_INVALID_DHCP_CLIENT  = 0x00004e30U,
}

enum : uint
{
    ERROR_DHCP_SERVICE_PAUSED      = 0x00004e31U,
    ERROR_DHCP_NOT_RESERVED_CLIENT = 0x00004e32U,
}

enum : uint
{
    ERROR_DHCP_RESERVED_CLIENT  = 0x00004e33U,
    ERROR_DHCP_RANGE_TOO_SMALL  = 0x00004e34U,
    ERROR_DHCP_IPRANGE_EXITS    = 0x00004e35U,
    ERROR_DHCP_RESERVEDIP_EXITS = 0x00004e36U,
    ERROR_DHCP_INVALID_RANGE    = 0x00004e37U,
    ERROR_DHCP_RANGE_EXTENDED   = 0x00004e38U,
}

enum uint ERROR_EXTEND_TOO_SMALL = 0x00004e39U;
enum int WARNING_EXTENDED_LESS = 0x00004e3a;
enum uint ERROR_DHCP_JET_CONV_REQUIRED = 0x00004e3bU;
enum uint ERROR_SERVER_INVALID_BOOT_FILE_TABLE = 0x00004e3cU;
enum uint ERROR_SERVER_UNKNOWN_BOOT_FILE_NAME = 0x00004e3dU;
enum uint ERROR_DHCP_SUPER_SCOPE_NAME_TOO_LONG = 0x00004e3eU;
enum uint ERROR_DHCP_IP_ADDRESS_IN_USE = 0x00004e40U;
enum uint ERROR_DHCP_LOG_FILE_PATH_TOO_LONG = 0x00004e41U;
enum uint ERROR_DHCP_UNSUPPORTED_CLIENT = 0x00004e42U;
enum uint ERROR_DHCP_JET97_CONV_REQUIRED = 0x00004e44U;

enum : uint
{
    ERROR_DHCP_ROGUE_INIT_FAILED        = 0x00004e45U,
    ERROR_DHCP_ROGUE_SAMSHUTDOWN        = 0x00004e46U,
    ERROR_DHCP_ROGUE_NOT_AUTHORIZED     = 0x00004e47U,
    ERROR_DHCP_ROGUE_DS_UNREACHABLE     = 0x00004e48U,
    ERROR_DHCP_ROGUE_DS_CONFLICT        = 0x00004e49U,
    ERROR_DHCP_ROGUE_NOT_OUR_ENTERPRISE = 0x00004e4aU,
    ERROR_DHCP_ROGUE_STANDALONE_IN_DS   = 0x00004e4bU,
}

enum : uint
{
    ERROR_DHCP_CLASS_NOT_FOUND      = 0x00004e4cU,
    ERROR_DHCP_CLASS_ALREADY_EXISTS = 0x00004e4dU,
}

enum uint ERROR_DHCP_SCOPE_NAME_TOO_LONG = 0x00004e4eU;
enum uint ERROR_DHCP_DEFAULT_SCOPE_EXITS = 0x00004e4fU;
enum uint ERROR_DHCP_CANT_CHANGE_ATTRIBUTE = 0x00004e50U;
enum uint ERROR_DHCP_IPRANGE_CONV_ILLEGAL = 0x00004e51U;

enum : uint
{
    ERROR_DHCP_NETWORK_CHANGED        = 0x00004e52U,
    ERROR_DHCP_CANNOT_MODIFY_BINDINGS = 0x00004e53U,
}

enum : uint
{
    ERROR_DHCP_SUBNET_EXISTS = 0x00004e54U,
    ERROR_DHCP_MSCOPE_EXISTS = 0x00004e55U,
}

enum uint ERROR_MSCOPE_RANGE_TOO_SMALL = 0x00004e56U;

enum : uint
{
    ERROR_DHCP_EXEMPTION_EXISTS      = 0x00004e57U,
    ERROR_DHCP_EXEMPTION_NOT_PRESENT = 0x00004e58U,
}

enum uint ERROR_DHCP_INVALID_PARAMETER_OPTION32 = 0x00004e59U;

enum : uint
{
    ERROR_DDS_NO_DS_AVAILABLE  = 0x00004e66U,
    ERROR_DDS_NO_DHCP_ROOT     = 0x00004e67U,
    ERROR_DDS_UNEXPECTED_ERROR = 0x00004e68U,
}

enum uint ERROR_DDS_TOO_MANY_ERRORS = 0x00004e69U;
enum uint ERROR_DDS_DHCP_SERVER_NOT_FOUND = 0x00004e6aU;

enum : uint
{
    ERROR_DDS_OPTION_ALREADY_EXISTS = 0x00004e6bU,
    ERROR_DDS_OPTION_DOES_NOT_EXIST = 0x00004e6cU,
}

enum : uint
{
    ERROR_DDS_CLASS_EXISTS         = 0x00004e6dU,
    ERROR_DDS_CLASS_DOES_NOT_EXIST = 0x00004e6eU,
}

enum : uint
{
    ERROR_DDS_SERVER_ALREADY_EXISTS   = 0x00004e6fU,
    ERROR_DDS_SERVER_DOES_NOT_EXIST   = 0x00004e70U,
    ERROR_DDS_SERVER_ADDRESS_MISMATCH = 0x00004e71U,
}

enum : uint
{
    ERROR_DDS_SUBNET_EXISTS          = 0x00004e72U,
    ERROR_DDS_SUBNET_HAS_DIFF_SSCOPE = 0x00004e73U,
    ERROR_DDS_SUBNET_NOT_PRESENT     = 0x00004e74U,
}

enum : uint
{
    ERROR_DDS_RESERVATION_NOT_PRESENT = 0x00004e75U,
    ERROR_DDS_RESERVATION_CONFLICT    = 0x00004e76U,
}

enum uint ERROR_DDS_POSSIBLE_RANGE_CONFLICT = 0x00004e77U;
enum uint ERROR_DDS_RANGE_DOES_NOT_EXIST = 0x00004e78U;
enum uint ERROR_DHCP_DELETE_BUILTIN_CLASS = 0x00004e79U;

enum : uint
{
    ERROR_DHCP_INVALID_SUBNET_PREFIX                = 0x00004e7bU,
    ERROR_DHCP_INVALID_DELAY                        = 0x00004e7cU,
    ERROR_DHCP_LINKLAYER_ADDRESS_EXISTS             = 0x00004e7dU,
    ERROR_DHCP_LINKLAYER_ADDRESS_RESERVATION_EXISTS = 0x00004e7eU,
    ERROR_DHCP_LINKLAYER_ADDRESS_DOES_NOT_EXIST     = 0x00004e7fU,
}

enum uint ERROR_DHCP_HARDWARE_ADDRESS_TYPE_ALREADY_EXEMPT = 0x00004e85U;
enum uint ERROR_DHCP_UNDEFINED_HARDWARE_ADDRESS_TYPE = 0x00004e86U;
enum uint ERROR_DHCP_OPTION_TYPE_MISMATCH = 0x00004e87U;

enum : uint
{
    ERROR_DHCP_POLICY_BAD_PARENT_EXPR         = 0x00004e88U,
    ERROR_DHCP_POLICY_EXISTS                  = 0x00004e89U,
    ERROR_DHCP_POLICY_RANGE_EXISTS            = 0x00004e8aU,
    ERROR_DHCP_POLICY_RANGE_BAD               = 0x00004e8bU,
    ERROR_DHCP_RANGE_INVALID_IN_SERVER_POLICY = 0x00004e8cU,
}

enum : uint
{
    ERROR_DHCP_INVALID_POLICY_EXPRESSION = 0x00004e8dU,
    ERROR_DHCP_INVALID_PROCESSING_ORDER  = 0x00004e8eU,
}

enum uint ERROR_DHCP_POLICY_NOT_FOUND = 0x00004e8fU;
enum uint ERROR_SCOPE_RANGE_POLICY_RANGE_CONFLICT = 0x00004e90U;
enum uint ERROR_DHCP_FO_SCOPE_ALREADY_IN_RELATIONSHIP = 0x00004e91U;

enum : uint
{
    ERROR_DHCP_FO_RELATIONSHIP_EXISTS         = 0x00004e92U,
    ERROR_DHCP_FO_RELATIONSHIP_DOES_NOT_EXIST = 0x00004e93U,
}

enum uint ERROR_DHCP_FO_SCOPE_NOT_IN_RELATIONSHIP = 0x00004e94U;
enum uint ERROR_DHCP_FO_RELATION_IS_SECONDARY = 0x00004e95U;

enum : uint
{
    ERROR_DHCP_FO_NOT_SUPPORTED    = 0x00004e96U,
    ERROR_DHCP_FO_TIME_OUT_OF_SYNC = 0x00004e97U,
    ERROR_DHCP_FO_STATE_NOT_NORMAL = 0x00004e98U,
}

enum uint ERROR_DHCP_NO_ADMIN_PERMISSION = 0x00004e99U;

enum : uint
{
    ERROR_DHCP_SERVER_NOT_REACHABLE     = 0x00004e9aU,
    ERROR_DHCP_SERVER_NOT_RUNNING       = 0x00004e9bU,
    ERROR_DHCP_SERVER_NAME_NOT_RESOLVED = 0x00004e9cU,
}

enum uint ERROR_DHCP_FO_RELATIONSHIP_NAME_TOO_LONG = 0x00004e9dU;
enum uint ERROR_DHCP_REACHED_END_OF_SELECTION = 0x00004e9eU;
enum uint ERROR_DHCP_FO_ADDSCOPE_LEASES_NOT_SYNCED = 0x00004e9fU;

enum : uint
{
    ERROR_DHCP_FO_MAX_RELATIONSHIPS         = 0x00004ea0U,
    ERROR_DHCP_FO_IPRANGE_TYPE_CONV_ILLEGAL = 0x00004ea1U,
}

enum : uint
{
    ERROR_DHCP_FO_MAX_ADD_SCOPES         = 0x00004ea2U,
    ERROR_DHCP_FO_BOOT_NOT_SUPPORTED     = 0x00004ea3U,
    ERROR_DHCP_FO_RANGE_PART_OF_REL      = 0x00004ea4U,
    ERROR_DHCP_FO_SCOPE_SYNC_IN_PROGRESS = 0x00004ea5U,
}

enum uint ERROR_DHCP_FO_FEATURE_NOT_SUPPORTED = 0x00004ea6U;

enum : uint
{
    ERROR_DHCP_POLICY_FQDN_RANGE_UNSUPPORTED  = 0x00004ea7U,
    ERROR_DHCP_POLICY_FQDN_OPTION_UNSUPPORTED = 0x00004ea8U,
    ERROR_DHCP_POLICY_EDIT_FQDN_UNSUPPORTED   = 0x00004ea9U,
}

enum uint ERROR_DHCP_NAP_NOT_SUPPORTED = 0x00004eaaU;
enum uint ERROR_LAST_DHCP_SERVER_ERROR = 0x00004eabU;
enum uint DHCP_SUBNET_INFO_VQ_FLAG_QUARANTINE = 0x00000001U;
enum uint MAX_PATTERN_LENGTH = 0x000000ffU;
enum uint MAC_ADDRESS_LENGTH = 0x00000006U;
enum uint HWTYPE_ETHERNET_10MB = 0x00000001U;

enum : uint
{
    FILTER_STATUS_NONE                     = 0x00000001U,
    FILTER_STATUS_FULL_MATCH_IN_ALLOW_LIST = 0x00000002U,
    FILTER_STATUS_FULL_MATCH_IN_DENY_LIST  = 0x00000004U,
}

enum : uint
{
    FILTER_STATUS_WILDCARD_MATCH_IN_ALLOW_LIST = 0x00000008U,
    FILTER_STATUS_WILDCARD_MATCH_IN_DENY_LIST  = 0x00000010U,
}

enum uint Set_APIProtocolSupport = 0x00000001U;

enum : uint
{
    Set_DatabaseName = 0x00000002U,
    Set_DatabasePath = 0x00000004U,
}

enum : uint
{
    Set_BackupPath     = 0x00000008U,
    Set_BackupInterval = 0x00000010U,
}

enum uint Set_DatabaseLoggingFlag = 0x00000020U;
enum uint Set_RestoreFlag = 0x00000040U;
enum uint Set_DatabaseCleanupInterval = 0x00000080U;
enum uint Set_DebugFlag = 0x00000100U;
enum uint Set_PingRetries = 0x00000200U;
enum uint Set_BootFileTable = 0x00000400U;
enum uint Set_AuditLogState = 0x00000800U;

enum : uint
{
    Set_QuarantineON      = 0x00001000U,
    Set_QuarantineDefFail = 0x00002000U,
}

enum : uint
{
    CLIENT_TYPE_UNSPECIFIED      = 0x00000000U,
    CLIENT_TYPE_DHCP             = 0x00000001U,
    CLIENT_TYPE_BOOTP            = 0x00000002U,
    CLIENT_TYPE_RESERVATION_FLAG = 0x00000004U,
    CLIENT_TYPE_NONE             = 0x00000064U,
}

enum uint Set_UnicastFlag = 0x00000001U;
enum uint Set_RapidCommitFlag = 0x00000002U;
enum uint Set_PreferredLifetime = 0x00000004U;
enum uint Set_ValidLifetime = 0x00000008U;

enum : uint
{
    Set_T1                    = 0x00000010U,
    Set_T2                    = 0x00000020U,
    Set_PreferredLifetimeIATA = 0x00000040U,
}

enum uint Set_ValidLifetimeIATA = 0x00000080U;

enum : uint
{
    V5_ADDRESS_STATE_OFFERED         = 0x00000000U,
    V5_ADDRESS_STATE_ACTIVE          = 0x00000001U,
    V5_ADDRESS_STATE_DECLINED        = 0x00000002U,
    V5_ADDRESS_STATE_DOOM            = 0x00000003U,
    V5_ADDRESS_BIT_DELETED           = 0x00000080U,
    V5_ADDRESS_BIT_UNREGISTERED      = 0x00000040U,
    V5_ADDRESS_BIT_BOTH_REC          = 0x00000020U,
    V5_ADDRESS_EX_BIT_DISABLE_PTR_RR = 0x00000001U,
}

enum : uint
{
    DNS_FLAG_ENABLED          = 0x00000001U,
    DNS_FLAG_UPDATE_DOWNLEVEL = 0x00000002U,
}

enum uint DNS_FLAG_CLEANUP_EXPIRED = 0x00000004U;

enum : uint
{
    DNS_FLAG_UPDATE_BOTH_ALWAYS = 0x00000010U,
    DNS_FLAG_UPDATE_DHCID       = 0x00000020U,
    DNS_FLAG_DISABLE_PTR_UPDATE = 0x00000040U,
}

enum uint DNS_FLAG_HAS_DNS_SUFFIX = 0x00000080U;

enum : uint
{
    DHCP_OPT_ENUM_IGNORE_VENDOR = 0x00000001U,
    DHCP_OPT_ENUM_USE_CLASSNAME = 0x00000002U,
}

enum : uint
{
    DHCP_FLAGS_DONT_ACCESS_DS   = 0x00000001U,
    DHCP_FLAGS_DONT_DO_RPC      = 0x00000002U,
    DHCP_FLAGS_OPTION_IS_VENDOR = 0x00000003U,
}

enum : uint
{
    DHCP_ATTRIB_BOOL_IS_ROGUE         = 0x00000001U,
    DHCP_ATTRIB_BOOL_IS_DYNBOOTP      = 0x00000002U,
    DHCP_ATTRIB_BOOL_IS_PART_OF_DSDC  = 0x00000003U,
    DHCP_ATTRIB_BOOL_IS_BINDING_AWARE = 0x00000004U,
    DHCP_ATTRIB_BOOL_IS_ADMIN         = 0x00000005U,
    DHCP_ATTRIB_ULONG_RESTORE_STATUS  = 0x00000006U,
}

enum : uint
{
    DHCP_ATTRIB_TYPE_BOOL  = 0x00000001U,
    DHCP_ATTRIB_TYPE_ULONG = 0x00000002U,
}

enum uint DHCP_ENDPOINT_FLAG_CANT_MODIFY = 0x00000001U;

enum : uint
{
    QUARANTIN_OPTION_BASE               = 0x0000a8d4U,
    QUARANTINE_SCOPE_QUARPROFILE_OPTION = 0x0000a8d5U,
}

enum uint QUARANTINE_CONFIG_OPTION = 0x0000a8d6U;

enum : uint
{
    ADDRESS_TYPE_IANA = 0x00000000U,
    ADDRESS_TYPE_IATA = 0x00000001U,
}

enum : uint
{
    DHCP_MIN_DELAY = 0x00000000U,
    DHCP_MAX_DELAY = 0x000003e8U,
}

enum : uint
{
    DHCP_FAILOVER_DELETE_SCOPES      = 0x00000001U,
    DHCP_FAILOVER_MAX_NUM_ADD_SCOPES = 0x00000190U,
    DHCP_FAILOVER_MAX_NUM_REL        = 0x0000001fU,
}

enum uint MCLT = 0x00000001U;
enum uint SAFEPERIOD = 0x00000002U;
enum uint CHANGESTATE = 0x00000004U;
enum uint PERCENTAGE = 0x00000008U;
enum uint MODE = 0x00000010U;
enum uint PREVSTATE = 0x00000020U;
enum uint SHAREDSECRET = 0x00000040U;

enum : const(wchar)*
{
    DHCP_CALLOUT_LIST_KEY    = "System\\CurrentControlSet\\Services\\DHCPServer\\Parameters",
    DHCP_CALLOUT_LIST_VALUE  = "CalloutDlls",
    // Native encoding: ansi
    DHCP_CALLOUT_ENTRY_POINT = "DhcpServerCalloutEntry",
}

enum : uint
{
    DHCP_CONTROL_START    = 0x00000001U,
    DHCP_CONTROL_STOP     = 0x00000002U,
    DHCP_CONTROL_PAUSE    = 0x00000003U,
    DHCP_CONTROL_CONTINUE = 0x00000004U,
}

enum : uint
{
    DHCP_DROP_DUPLICATE      = 0x00000001U,
    DHCP_DROP_NOMEM          = 0x00000002U,
    DHCP_DROP_INTERNAL_ERROR = 0x00000003U,
    DHCP_DROP_TIMEOUT        = 0x00000004U,
    DHCP_DROP_UNAUTH         = 0x00000005U,
    DHCP_DROP_PAUSED         = 0x00000006U,
    DHCP_DROP_NO_SUBNETS     = 0x00000007U,
    DHCP_DROP_INVALID        = 0x00000008U,
    DHCP_DROP_WRONG_SERVER   = 0x00000009U,
    DHCP_DROP_NOADDRESS      = 0x0000000aU,
    DHCP_DROP_PROCESSED      = 0x0000000bU,
    DHCP_DROP_GEN_FAILURE    = 0x00000100U,
}

enum uint DHCP_SEND_PACKET = 0x10000000U;

enum : uint
{
    DHCP_PROB_CONFLICT = 0x20000001U,
    DHCP_PROB_DECLINE  = 0x20000002U,
    DHCP_PROB_RELEASE  = 0x20000003U,
    DHCP_PROB_NACKED   = 0x20000004U,
}

enum : uint
{
    DHCP_GIVE_ADDRESS_NEW = 0x30000001U,
    DHCP_GIVE_ADDRESS_OLD = 0x30000002U,
}

enum : uint
{
    DHCP_CLIENT_BOOTP = 0x30000003U,
    DHCP_CLIENT_DHCP  = 0x30000004U,
}

enum : uint
{
    DHCPV6_OPTION_CLIENTID          = 0x00000001U,
    DHCPV6_OPTION_SERVERID          = 0x00000002U,
    DHCPV6_OPTION_IA_NA             = 0x00000003U,
    DHCPV6_OPTION_IA_TA             = 0x00000004U,
    DHCPV6_OPTION_ORO               = 0x00000006U,
    DHCPV6_OPTION_PREFERENCE        = 0x00000007U,
    DHCPV6_OPTION_UNICAST           = 0x0000000cU,
    DHCPV6_OPTION_RAPID_COMMIT      = 0x0000000eU,
    DHCPV6_OPTION_USER_CLASS        = 0x0000000fU,
    DHCPV6_OPTION_VENDOR_CLASS      = 0x00000010U,
    DHCPV6_OPTION_VENDOR_OPTS       = 0x00000011U,
    DHCPV6_OPTION_RECONF_MSG        = 0x00000013U,
    DHCPV6_OPTION_SIP_SERVERS_NAMES = 0x00000015U,
    DHCPV6_OPTION_SIP_SERVERS_ADDRS = 0x00000016U,
    DHCPV6_OPTION_DNS_SERVERS       = 0x00000017U,
    DHCPV6_OPTION_DOMAIN_LIST       = 0x00000018U,
    DHCPV6_OPTION_IA_PD             = 0x00000019U,
    DHCPV6_OPTION_NIS_SERVERS       = 0x0000001bU,
    DHCPV6_OPTION_NISP_SERVERS      = 0x0000001cU,
    DHCPV6_OPTION_NIS_DOMAIN_NAME   = 0x0000001dU,
    DHCPV6_OPTION_NISP_DOMAIN_NAME  = 0x0000001eU,
    DHCPV6_OPTION_DNR               = 0x00000090U,
}

// Callbacks

alias LPDHCP_CONTROL = uint function(uint dwControlCode, void* lpReserved);
alias LPDHCP_NEWPKT = uint function(ubyte** Packet, uint* PacketSize, uint IpAddress, void* Reserved, 
                                    void** PktContext, BOOL* ProcessIt);
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
alias LPDHCP_ENTRY_POINT_FUNC = uint function(PWSTR ChainDlls, uint CalloutVersion, DHCP_CALLOUT_TABLE* CalloutTbl);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpv6csdk/ns-dhcpv6csdk-dhcpv6capi_params
struct DHCPV6CAPI_PARAMS
{
    uint   Flags;
    uint   OptionId;
    BOOL   IsVendor;
    ubyte* Data;
    uint   nBytesData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpv6csdk/ns-dhcpv6csdk-dhcpv6capi_params_array
struct DHCPV6CAPI_PARAMS_ARRAY
{
    uint               nParams;
    DHCPV6CAPI_PARAMS* Params;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpv6csdk/ns-dhcpv6csdk-dhcpv6capi_classid
struct DHCPV6CAPI_CLASSID
{
    uint   Flags;
    ubyte* Data;
    uint   nBytesData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpv6csdk/ns-dhcpv6csdk-dhcpv6prefix
struct DHCPV6Prefix
{
    ubyte[16]  prefix;
    uint       prefixLength;
    uint       preferredLifeTime;
    uint       validLifeTime;
    StatusCode status;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpv6csdk/ns-dhcpv6csdk-dhcpv6prefixleaseinformation
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpcsdk/ns-dhcpcsdk-dhcpapi_params
struct DHCPAPI_PARAMS
{
    uint   Flags;
    uint   OptionId;
    BOOL   IsVendor;
    ubyte* Data;
    uint   nBytesData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpcsdk/ns-dhcpcsdk-dhcpcapi_params_array
struct DHCPCAPI_PARAMS_ARRAY
{
    uint            nParams;
    DHCPAPI_PARAMS* Params;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpcsdk/ns-dhcpcsdk-dhcpcapi_classid
struct DHCPCAPI_CLASSID
{
    uint   Flags;
    ubyte* Data;
    uint   nBytesData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpssdk/ns-dhcpssdk-dhcp_server_options
struct DHCP_SERVER_OPTIONS
{
    ubyte*  MessageType;
    uint*   SubnetMask;
    uint*   RequestedAddress;
    uint*   RequestLeaseTime;
    ubyte*  OverlayFields;
    uint*   RouterAddress;
    uint*   Server;
    ubyte*  ParameterRequestList;
    uint    ParameterRequestListLength;
    PSTR    MachineName;
    uint    MachineNameLength;
    ubyte   ClientHardwareAddressType;
    ubyte   ClientHardwareAddressLength;
    ubyte*  ClientHardwareAddress;
    PSTR    ClassIdentifier;
    uint    ClassIdentifierLength;
    ubyte*  VendorClass;
    uint    VendorClassLength;
    uint    DNSFlags;
    uint    DNSNameLength;
    ubyte*  DNSName;
    BOOLEAN DSDomainNameRequested;
    PSTR    DSDomainName;
    uint    DSDomainNameLen;
    uint*   ScopeId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpssdk/ns-dhcpssdk-dhcp_callout_table
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-date_time
struct DATE_TIME
{
    uint dwLowDateTime;
    uint dwHighDateTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_ip_range
struct DHCP_IP_RANGE
{
    uint StartAddress;
    uint EndAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_binary_data
struct DHCP_BINARY_DATA
{
    uint   DataLength;
    ubyte* Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_host_info
struct DHCP_HOST_INFO
{
    uint  IpAddress;
    PWSTR NetBiosName;
    PWSTR HostName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dword_dword
struct DWORD_DWORD
{
    uint DWord1;
    uint DWord2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_info
struct DHCP_SUBNET_INFO
{
    uint              SubnetAddress;
    uint              SubnetMask;
    PWSTR             SubnetName;
    PWSTR             SubnetComment;
    DHCP_HOST_INFO    PrimaryHost;
    DHCP_SUBNET_STATE SubnetState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_info_vq
struct DHCP_SUBNET_INFO_VQ
{
    uint              SubnetAddress;
    uint              SubnetMask;
    PWSTR             SubnetName;
    PWSTR             SubnetComment;
    DHCP_HOST_INFO    PrimaryHost;
    DHCP_SUBNET_STATE SubnetState;
    uint              QuarantineOn;
    uint              Reserved1;
    uint              Reserved2;
    long              Reserved3;
    long              Reserved4;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_ip_array
struct DHCP_IP_ARRAY
{
    uint  NumElements;
    uint* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_ip_cluster
struct DHCP_IP_CLUSTER
{
    uint ClusterAddress;
    uint ClusterMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_ip_reservation
struct DHCP_IP_RESERVATION
{
    uint              ReservedIpAddress;
    DHCP_BINARY_DATA* ReservedForClient;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_element_data
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_element_info_array
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY
{
    uint NumElements;
    DHCP_SUBNET_ELEMENT_DATA* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_ipv6_address
struct DHCP_IPV6_ADDRESS
{
    ulong HighOrderBits;
    ulong LowOrderBits;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_addr_pattern
struct DHCP_ADDR_PATTERN
{
    BOOL       MatchHWType;
    ubyte      HWType;
    BOOL       IsWildcard;
    ubyte      Length;
    ubyte[255] Pattern;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_filter_add_info
struct DHCP_FILTER_ADD_INFO
{
    DHCP_ADDR_PATTERN AddrPatt;
    PWSTR             Comment;
    DHCP_FILTER_LIST_TYPE ListType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_filter_global_info
struct DHCP_FILTER_GLOBAL_INFO
{
    BOOL EnforceAllowList;
    BOOL EnforceDenyList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_filter_record
struct DHCP_FILTER_RECORD
{
    DHCP_ADDR_PATTERN AddrPatt;
    PWSTR             Comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_filter_enum_info
struct DHCP_FILTER_ENUM_INFO
{
    uint                NumElements;
    DHCP_FILTER_RECORD* pEnumRecords;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_option_data_element
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
        PWSTR            StringDataOption;
        DHCP_BINARY_DATA BinaryDataOption;
        DHCP_BINARY_DATA EncapsulatedDataOption;
        PWSTR            Ipv6AddressDataOption;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_option_data
struct DHCP_OPTION_DATA
{
    uint NumElements;
    DHCP_OPTION_DATA_ELEMENT* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_option
struct DHCP_OPTION
{
    uint             OptionID;
    PWSTR            OptionName;
    PWSTR            OptionComment;
    DHCP_OPTION_DATA DefaultValue;
    DHCP_OPTION_TYPE OptionType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_option_array
struct DHCP_OPTION_ARRAY
{
    uint         NumElements;
    DHCP_OPTION* Options;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_option_value
struct DHCP_OPTION_VALUE
{
    uint             OptionID;
    DHCP_OPTION_DATA Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_option_value_array
struct DHCP_OPTION_VALUE_ARRAY
{
    uint               NumElements;
    DHCP_OPTION_VALUE* Values;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_reserved_scope
struct DHCP_RESERVED_SCOPE
{
    uint ReservedIpAddress;
    uint ReservedIpSubnetAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_option_scope_info
struct DHCP_OPTION_SCOPE_INFO
{
    DHCP_OPTION_SCOPE_TYPE ScopeType;
    union ScopeInfo
    {
        void*               DefaultScopeInfo;
        void*               GlobalScopeInfo;
        uint                SubnetScopeInfo;
        DHCP_RESERVED_SCOPE ReservedScopeInfo;
        PWSTR               MScopeInfo;
    }
}

struct DHCP_RESERVED_SCOPE6
{
    DHCP_IPV6_ADDRESS ReservedIpAddress;
    DHCP_IPV6_ADDRESS ReservedIpSubnetAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_option_scope_info6
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_option_list
struct DHCP_OPTION_LIST
{
    uint               NumOptions;
    DHCP_OPTION_VALUE* Options;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info
struct DHCP_CLIENT_INFO
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    PWSTR            ClientName;
    PWSTR            ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_array
struct DHCP_CLIENT_INFO_ARRAY
{
    uint               NumElements;
    DHCP_CLIENT_INFO** Clients;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_vq
struct DHCP_CLIENT_INFO_VQ
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    PWSTR            ClientName;
    PWSTR            ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
    QuarantineStatus Status;
    DATE_TIME        ProbationEnds;
    BOOL             QuarantineCapable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_array_vq
struct DHCP_CLIENT_INFO_ARRAY_VQ
{
    uint NumElements;
    DHCP_CLIENT_INFO_VQ** Clients;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_filter_status_info
struct DHCP_CLIENT_FILTER_STATUS_INFO
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    PWSTR            ClientName;
    PWSTR            ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
    QuarantineStatus Status;
    DATE_TIME        ProbationEnds;
    BOOL             QuarantineCapable;
    uint             FilterStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_filter_status_info_array
struct DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY
{
    uint NumElements;
    DHCP_CLIENT_FILTER_STATUS_INFO** Clients;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_pb
struct DHCP_CLIENT_INFO_PB
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    PWSTR            ClientName;
    PWSTR            ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
    QuarantineStatus Status;
    DATE_TIME        ProbationEnds;
    BOOL             QuarantineCapable;
    uint             FilterStatus;
    PWSTR            PolicyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_pb_array
struct DHCP_CLIENT_INFO_PB_ARRAY
{
    uint NumElements;
    DHCP_CLIENT_INFO_PB** Clients;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_search_info
struct DHCP_SEARCH_INFO
{
    DHCP_SEARCH_INFO_TYPE SearchType;
    union SearchInfo
    {
        uint             ClientIpAddress;
        DHCP_BINARY_DATA ClientHardwareAddress;
        PWSTR            ClientName;
    }
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
        PWSTR            StringValue;
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
    PWSTR                ClientName;
    PWSTR                ClientComment;
    DATE_TIME            ClientLeaseExpires;
    DHCP_HOST_INFO       OwnerHost;
    ubyte                bClientType;
    ubyte                AddressState;
    QuarantineStatus     Status;
    DATE_TIME            ProbationEnds;
    BOOL                 QuarantineCapable;
    uint                 FilterStatus;
    PWSTR                PolicyName;
    DHCP_PROPERTY_ARRAY* Properties;
}

struct DHCP_CLIENT_INFO_EX_ARRAY
{
    uint NumElements;
    DHCP_CLIENT_INFO_EX** Clients;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-scope_mib_info
struct SCOPE_MIB_INFO
{
    uint Subnet;
    uint NumAddressesInuse;
    uint NumAddressesFree;
    uint NumPendingOffers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_mib_info
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-scope_mib_info_v5
struct SCOPE_MIB_INFO_V5
{
    uint Subnet;
    uint NumAddressesInuse;
    uint NumAddressesFree;
    uint NumPendingOffers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_mib_info_v5
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_server_config_info
struct DHCP_SERVER_CONFIG_INFO
{
    uint  APIProtocolSupport;
    PWSTR DatabaseName;
    PWSTR DatabasePath;
    PWSTR BackupPath;
    uint  BackupInterval;
    uint  DatabaseLoggingFlag;
    uint  RestoreFlag;
    uint  DatabaseCleanupInterval;
    uint  DebugFlag;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_scan_item
struct DHCP_SCAN_ITEM
{
    uint           IpAddress;
    DHCP_SCAN_FLAG ScanFlag;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_scan_list
struct DHCP_SCAN_LIST
{
    uint            NumScanItems;
    DHCP_SCAN_ITEM* ScanItems;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_class_info
struct DHCP_CLASS_INFO
{
    PWSTR  ClassName;
    PWSTR  ClassComment;
    uint   ClassDataLength;
    BOOL   IsVendor;
    uint   Flags;
    ubyte* ClassData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_class_info_array
struct DHCP_CLASS_INFO_ARRAY
{
    uint             NumElements;
    DHCP_CLASS_INFO* Classes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_class_info_v6
struct DHCP_CLASS_INFO_V6
{
    PWSTR  ClassName;
    PWSTR  ClassComment;
    uint   ClassDataLength;
    BOOL   IsVendor;
    uint   EnterpriseNumber;
    uint   Flags;
    ubyte* ClassData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_class_info_array_v6
struct DHCP_CLASS_INFO_ARRAY_V6
{
    uint                NumElements;
    DHCP_CLASS_INFO_V6* Classes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_server_specific_strings
struct DHCP_SERVER_SPECIFIC_STRINGS
{
    PWSTR DefaultVendorClassName;
    PWSTR DefaultUserClassName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_ip_reservation_v4
struct DHCP_IP_RESERVATION_V4
{
    uint              ReservedIpAddress;
    DHCP_BINARY_DATA* ReservedForClient;
    ubyte             bAllowedClientTypes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_ip_reservation_info
struct DHCP_IP_RESERVATION_INFO
{
    uint             ReservedIpAddress;
    DHCP_BINARY_DATA ReservedForClient;
    PWSTR            ReservedClientName;
    PWSTR            ReservedClientDesc;
    ubyte            bAllowedClientTypes;
    ubyte            fOptionsPresent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_reservation_info_array
struct DHCP_RESERVATION_INFO_ARRAY
{
    uint NumElements;
    DHCP_IP_RESERVATION_INFO** Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_element_data_v4
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_element_info_array_v4
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4
{
    uint NumElements;
    DHCP_SUBNET_ELEMENT_DATA_V4* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_v4
struct DHCP_CLIENT_INFO_V4
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    PWSTR            ClientName;
    PWSTR            ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_array_v4
struct DHCP_CLIENT_INFO_ARRAY_V4
{
    uint NumElements;
    DHCP_CLIENT_INFO_V4** Clients;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_server_config_info_v4
struct DHCP_SERVER_CONFIG_INFO_V4
{
    uint  APIProtocolSupport;
    PWSTR DatabaseName;
    PWSTR DatabasePath;
    PWSTR BackupPath;
    uint  BackupInterval;
    uint  DatabaseLoggingFlag;
    uint  RestoreFlag;
    uint  DatabaseCleanupInterval;
    uint  DebugFlag;
    uint  dwPingRetries;
    uint  cbBootTableString;
    PWSTR wszBootTableString;
    BOOL  fAuditLog;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_server_config_info_vq
struct DHCP_SERVER_CONFIG_INFO_VQ
{
    uint  APIProtocolSupport;
    PWSTR DatabaseName;
    PWSTR DatabasePath;
    PWSTR BackupPath;
    uint  BackupInterval;
    uint  DatabaseLoggingFlag;
    uint  RestoreFlag;
    uint  DatabaseCleanupInterval;
    uint  DebugFlag;
    uint  dwPingRetries;
    uint  cbBootTableString;
    PWSTR wszBootTableString;
    BOOL  fAuditLog;
    BOOL  QuarantineOn;
    uint  QuarDefFail;
    BOOL  QuarRuntimeStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_server_config_info_v6
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_super_scope_table_entry
struct DHCP_SUPER_SCOPE_TABLE_ENTRY
{
    uint  SubnetAddress;
    uint  SuperScopeNumber;
    uint  NextInSuperScope;
    PWSTR SuperScopeName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_super_scope_table
struct DHCP_SUPER_SCOPE_TABLE
{
    uint cEntries;
    DHCP_SUPER_SCOPE_TABLE_ENTRY* pEntries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_v5
struct DHCP_CLIENT_INFO_V5
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    PWSTR            ClientName;
    PWSTR            ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_array_v5
struct DHCP_CLIENT_INFO_ARRAY_V5
{
    uint NumElements;
    DHCP_CLIENT_INFO_V5** Clients;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_all_options
struct DHCP_ALL_OPTIONS
{
    uint               Flags;
    DHCP_OPTION_ARRAY* NonVendorOptions;
    uint               NumVendorOptions;
    struct
    {
        DHCP_OPTION Option;
        PWSTR       VendorName;
        PWSTR       ClassName;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_all_option_values
struct DHCP_ALL_OPTION_VALUES
{
    uint Flags;
    uint NumElements;
    struct
    {
        PWSTR ClassName;
        PWSTR VendorName;
        BOOL  IsVendor;
        DHCP_OPTION_VALUE_ARRAY* OptionsArray;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_all_option_values_pb
struct DHCP_ALL_OPTION_VALUES_PB
{
    uint Flags;
    uint NumElements;
    struct
    {
        PWSTR PolicyName;
        PWSTR VendorName;
        BOOL  IsVendor;
        DHCP_OPTION_VALUE_ARRAY* OptionsArray;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcpds_server
struct DHCPDS_SERVER
{
    uint  Version;
    PWSTR ServerName;
    uint  ServerAddress;
    uint  Flags;
    uint  State;
    PWSTR DsLocation;
    uint  DsLocType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcpds_servers
struct DHCPDS_SERVERS
{
    uint           Flags;
    uint           NumElements;
    DHCPDS_SERVER* Servers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_attrib
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_attrib_array
struct DHCP_ATTRIB_ARRAY
{
    uint         NumElements;
    DHCP_ATTRIB* DhcpAttribs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_bootp_ip_range
struct DHCP_BOOTP_IP_RANGE
{
    uint StartAddress;
    uint EndAddress;
    uint BootpAllocated;
    uint MaxBootpAllowed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_element_data_v5
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_element_info_array_v5
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_bind_element
struct DHCP_BIND_ELEMENT
{
    uint   Flags;
    BOOL   fBoundToDHCPServer;
    uint   AdapterPrimaryAddress;
    uint   AdapterSubnetAddress;
    PWSTR  IfDescription;
    uint   IfIdSize;
    ubyte* IfId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_bind_element_array
struct DHCP_BIND_ELEMENT_ARRAY
{
    uint               NumElements;
    DHCP_BIND_ELEMENT* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcpv6_bind_element
struct DHCPV6_BIND_ELEMENT
{
    uint              Flags;
    BOOL              fBoundToDHCPServer;
    DHCP_IPV6_ADDRESS AdapterPrimaryAddress;
    DHCP_IPV6_ADDRESS AdapterSubnetAddress;
    PWSTR             IfDescription;
    uint              IpV6IfIndex;
    uint              IfIdSize;
    ubyte*            IfId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcpv6_bind_element_array
struct DHCPV6_BIND_ELEMENT_ARRAY
{
    uint                 NumElements;
    DHCPV6_BIND_ELEMENT* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_ip_range_v6
struct DHCP_IP_RANGE_V6
{
    DHCP_IPV6_ADDRESS StartAddress;
    DHCP_IPV6_ADDRESS EndAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_host_info_v6
struct DHCP_HOST_INFO_V6
{
    DHCP_IPV6_ADDRESS IpAddress;
    PWSTR             NetBiosName;
    PWSTR             HostName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_info_v6
struct DHCP_SUBNET_INFO_V6
{
    DHCP_IPV6_ADDRESS SubnetAddress;
    uint              Prefix;
    ushort            Preference;
    PWSTR             SubnetName;
    PWSTR             SubnetComment;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_mib_info_v6
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_ip_reservation_v6
struct DHCP_IP_RESERVATION_V6
{
    DHCP_IPV6_ADDRESS ReservedIpAddress;
    DHCP_BINARY_DATA* ReservedForClient;
    uint              InterfaceId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_element_data_v6
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_subnet_element_info_array_v6
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V6
{
    uint NumElements;
    DHCP_SUBNET_ELEMENT_DATA_V6* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_v6
struct DHCP_CLIENT_INFO_V6
{
    DHCP_IPV6_ADDRESS ClientIpAddress;
    DHCP_BINARY_DATA  ClientDUID;
    uint              AddressType;
    uint              IAID;
    PWSTR             ClientName;
    PWSTR             ClientComment;
    DATE_TIME         ClientValidLeaseExpires;
    DATE_TIME         ClientPrefLeaseExpires;
    DHCP_HOST_INFO_V6 OwnerHost;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcpv6_ip_array
struct DHCPV6_IP_ARRAY
{
    uint               NumElements;
    DHCP_IPV6_ADDRESS* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_client_info_array_v6
struct DHCP_CLIENT_INFO_ARRAY_V6
{
    uint NumElements;
    DHCP_CLIENT_INFO_V6** Clients;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_search_info_v6
struct DHCP_SEARCH_INFO_V6
{
    DHCP_SEARCH_INFO_TYPE_V6 SearchType;
    union SearchInfo
    {
        DHCP_IPV6_ADDRESS ClientIpAddress;
        DHCP_BINARY_DATA  ClientDUID;
        PWSTR             ClientName;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_pol_cond
struct DHCP_POL_COND
{
    uint                ParentExpr;
    DHCP_POL_ATTR_TYPE  Type;
    uint                OptionID;
    uint                SubOptionID;
    PWSTR               VendorName;
    DHCP_POL_COMPARATOR Operator;
    ubyte*              Value;
    uint                ValueLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_pol_cond_array
struct DHCP_POL_COND_ARRAY
{
    uint           NumElements;
    DHCP_POL_COND* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_pol_expr
struct DHCP_POL_EXPR
{
    uint                ParentExpr;
    DHCP_POL_LOGIC_OPER Operator;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_pol_expr_array
struct DHCP_POL_EXPR_ARRAY
{
    uint           NumElements;
    DHCP_POL_EXPR* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_ip_range_array
struct DHCP_IP_RANGE_ARRAY
{
    uint           NumElements;
    DHCP_IP_RANGE* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_policy
struct DHCP_POLICY
{
    PWSTR                PolicyName;
    BOOL                 IsGlobalPolicy;
    uint                 Subnet;
    uint                 ProcessingOrder;
    DHCP_POL_COND_ARRAY* Conditions;
    DHCP_POL_EXPR_ARRAY* Expressions;
    DHCP_IP_RANGE_ARRAY* Ranges;
    PWSTR                Description;
    BOOL                 Enabled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_policy_array
struct DHCP_POLICY_ARRAY
{
    uint         NumElements;
    DHCP_POLICY* Elements;
}

struct DHCP_POLICY_EX
{
    PWSTR                PolicyName;
    BOOL                 IsGlobalPolicy;
    uint                 Subnet;
    uint                 ProcessingOrder;
    DHCP_POL_COND_ARRAY* Conditions;
    DHCP_POL_EXPR_ARRAY* Expressions;
    DHCP_IP_RANGE_ARRAY* Ranges;
    PWSTR                Description;
    BOOL                 Enabled;
    DHCP_PROPERTY_ARRAY* Properties;
}

struct DHCP_POLICY_EX_ARRAY
{
    uint            NumElements;
    DHCP_POLICY_EX* Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcpv6_stateless_params
struct DHCPV6_STATELESS_PARAMS
{
    BOOL Status;
    uint PurgeInterval;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcpv6_stateless_scope_stats
struct DHCPV6_STATELESS_SCOPE_STATS
{
    DHCP_IPV6_ADDRESS SubnetAddress;
    ulong             NumStatelessClientsAdded;
    ulong             NumStatelessClientsRemoved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcpv6_stateless_stats
struct DHCPV6_STATELESS_STATS
{
    uint NumScopes;
    DHCPV6_STATELESS_SCOPE_STATS* ScopeStats;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_failover_relationship
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
    PWSTR                RelationshipName;
    PWSTR                PrimaryServerName;
    PWSTR                SecondaryServerName;
    DHCP_IP_ARRAY*       pScopes;
    ubyte                Percentage;
    PWSTR                SharedSecret;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_failover_relationship_array
struct DHCP_FAILOVER_RELATIONSHIP_ARRAY
{
    uint NumElements;
    DHCP_FAILOVER_RELATIONSHIP* pRelationships;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcpv4_failover_client_info
struct DHCPV4_FAILOVER_CLIENT_INFO
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    PWSTR            ClientName;
    PWSTR            ClientComment;
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
    PWSTR            PolicyName;
    ubyte            Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcpv4_failover_client_info_array
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
    PWSTR            ClientName;
    PWSTR            ClientComment;
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
    PWSTR            PolicyName;
    ubyte            Flags;
    uint             AddressStateEx;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dhcpsapi/ns-dhcpsapi-dhcp_failover_statistics
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

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dhcpcsvc6.dll")
void Dhcpv6CApiInitialize(uint* Version);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dhcpcsvc6.dll")
void Dhcpv6CApiCleanup();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dhcpcsvc6.dll")
uint Dhcpv6RequestParams(BOOL forceNewInform, void* reserved, PWSTR adapterName, DHCPV6CAPI_CLASSID* classId, 
                         DHCPV6CAPI_PARAMS_ARRAY recdParams, ubyte* buffer, uint* pSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dhcpcsvc6.dll")
uint Dhcpv6RequestPrefix(PWSTR adapterName, DHCPV6CAPI_CLASSID* pclassId, 
                         DHCPV6PrefixLeaseInformation* prefixleaseInfo, uint* pdwTimeToWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dhcpcsvc6.dll")
uint Dhcpv6RenewPrefix(PWSTR adapterName, DHCPV6CAPI_CLASSID* pclassId, 
                       DHCPV6PrefixLeaseInformation* prefixleaseInfo, uint* pdwTimeToWait, uint bValidatePrefix);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dhcpcsvc6.dll")
uint Dhcpv6ReleasePrefix(PWSTR adapterName, DHCPV6CAPI_CLASSID* classId, DHCPV6PrefixLeaseInformation* leaseInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint DhcpCApiInitialize(uint* Version);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
void DhcpCApiCleanup();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint DhcpRequestParams(uint Flags, void* Reserved, PWSTR AdapterName, DHCPCAPI_CLASSID* ClassId, 
                       DHCPCAPI_PARAMS_ARRAY SendParams, DHCPCAPI_PARAMS_ARRAY RecdParams, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/ubyte* Buffer, 
                       uint* pSize, PWSTR RequestIdStr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint DhcpUndoRequestParams(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved, 
                           PWSTR AdapterName, PWSTR RequestIdStr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint DhcpRegisterParamChange(uint Flags, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved, 
                             PWSTR AdapterName, DHCPCAPI_CLASSID* ClassId, DHCPCAPI_PARAMS_ARRAY Params, 
                             void* Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint DhcpDeRegisterParamChange(uint Flags, void* Reserved, void* Event);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint DhcpRemoveDNSRegistrations();

@DllImport("dhcpcsvc.dll")
uint DhcpGetOriginalSubnetMask(const(PWSTR) sAdapterName, uint* dwSubnetMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpAddFilterV4(const(PWSTR) ServerIpAddress, DHCP_FILTER_ADD_INFO* AddFilterInfo, BOOL ForceFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpDeleteFilterV4(const(PWSTR) ServerIpAddress, DHCP_ADDR_PATTERN* DeleteFilterInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetFilterV4(const(PWSTR) ServerIpAddress, DHCP_FILTER_GLOBAL_INFO* GlobalFilterInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetFilterV4(const(PWSTR) ServerIpAddress, DHCP_FILTER_GLOBAL_INFO* GlobalFilterInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumFilterV4(const(PWSTR) ServerIpAddress, DHCP_ADDR_PATTERN* ResumeHandle, uint PreferredMaximum, 
                      DHCP_FILTER_LIST_TYPE ListType, DHCP_FILTER_ENUM_INFO** EnumFilterInfo, uint* ElementsRead, 
                      uint* ElementsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateSubnet(const(PWSTR) ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO)* SubnetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetSubnetInfo(const(PWSTR) ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO)* SubnetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetSubnetInfo(const(PWSTR) ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_INFO** SubnetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnets(const(PWSTR) ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                     DHCP_IP_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpAddSubnetElement(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                          const(DHCP_SUBNET_ELEMENT_DATA)* AddElementInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetElements(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                            DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                            DHCP_SUBNET_ELEMENT_INFO_ARRAY** EnumElementInfo, uint* ElementsRead, 
                            uint* ElementsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpRemoveSubnetElement(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                             const(DHCP_SUBNET_ELEMENT_DATA)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpDeleteSubnet(const(PWSTR) ServerIpAddress, uint SubnetAddress, DHCP_FORCE_FLAG ForceFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateOption(const(PWSTR) ServerIpAddress, uint OptionID, const(DHCP_OPTION)* OptionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionInfo(const(PWSTR) ServerIpAddress, uint OptionID, const(DHCP_OPTION)* OptionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionInfo(const(PWSTR) ServerIpAddress, uint OptionID, DHCP_OPTION** OptionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptions(const(PWSTR) ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                     DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOption(const(PWSTR) ServerIpAddress, uint OptionID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionValue(const(PWSTR) ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                        const(DHCP_OPTION_DATA)* OptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionValues(const(PWSTR) ServerIpAddress, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                         const(DHCP_OPTION_VALUE_ARRAY)* OptionValues);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionValue(const(PWSTR) ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                        DHCP_OPTION_VALUE** OptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptionValues(const(PWSTR) ServerIpAddress, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                          uint* ResumeHandle, uint PreferredMaximum, DHCP_OPTION_VALUE_ARRAY** OptionValues, 
                          uint* OptionsRead, uint* OptionsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOptionValue(const(PWSTR) ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateClientInfoVQ(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_VQ)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetClientInfoVQ(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_VQ)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetClientInfoVQ(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                         DHCP_CLIENT_INFO_VQ** ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClientsVQ(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_VQ** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClientsFilterStatusInfo(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                                           uint PreferredMaximum, DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY** ClientInfo, 
                                           uint* ClientsRead, uint* ClientsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                       DHCP_CLIENT_INFO** ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpDeleteClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClients(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                           uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY** ClientInfo, uint* ClientsRead, 
                           uint* ClientsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetClientOptions(const(PWSTR) ServerIpAddress, uint ClientIpAddress, uint ClientSubnetMask, 
                          DHCP_OPTION_LIST** ClientOptions);

@DllImport("DHCPSAPI.dll")
uint DhcpGetMibInfo(const(PWSTR) ServerIpAddress, DHCP_MIB_INFO** MibInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerSetConfig(const(PWSTR) ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO* ConfigInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerGetConfig(const(PWSTR) ServerIpAddress, DHCP_SERVER_CONFIG_INFO** ConfigInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpScanDatabase(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint FixFlag, DHCP_SCAN_LIST** ScanList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
void DhcpRpcFreeMemory(void* BufferPointer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetVersion(PWSTR ServerIpAddress, uint* MajorVersion, uint* MinorVersion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpAddSubnetElementV4(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                            const(DHCP_SUBNET_ELEMENT_DATA_V4)* AddElementInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetElementsV4(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                              DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                              DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4** EnumElementInfo, uint* ElementsRead, 
                              uint* ElementsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpRemoveSubnetElementV4(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                               const(DHCP_SUBNET_ELEMENT_DATA_V4)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateClientInfoV4(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_V4)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetClientInfoV4(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_V4)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetClientInfoV4(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                         DHCP_CLIENT_INFO_V4** ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClientsV4(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_V4** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerSetConfigV4(const(PWSTR) ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO_V4* ConfigInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerGetConfigV4(const(PWSTR) ServerIpAddress, DHCP_SERVER_CONFIG_INFO_V4** ConfigInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetSuperScopeV4(const(PWSTR) ServerIpAddress, const(uint) SubnetAddress, const(PWSTR) SuperScopeName, 
                         const(BOOL) ChangeExisting);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpDeleteSuperScopeV4(const(PWSTR) ServerIpAddress, const(PWSTR) SuperScopeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetSuperScopeInfoV4(const(PWSTR) ServerIpAddress, DHCP_SUPER_SCOPE_TABLE** SuperScopeTable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClientsV5(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_V5** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateOptionV5(PWSTR ServerIpAddress, uint Flags, uint OptionId, PWSTR ClassName, PWSTR VendorName, 
                        DHCP_OPTION* OptionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionInfoV5(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                         DHCP_OPTION* OptionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionInfoV5(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                         DHCP_OPTION** OptionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptionsV5(PWSTR ServerIpAddress, uint Flags, PWSTR ClassName, PWSTR VendorName, uint* ResumeHandle, 
                       uint PreferredMaximum, DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOptionV5(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionValueV5(PWSTR ServerIpAddress, uint Flags, uint OptionId, PWSTR ClassName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionValuesV5(PWSTR ServerIpAddress, uint Flags, PWSTR ClassName, PWSTR VendorName, 
                           DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE_ARRAY* OptionValues);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionValueV5(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE** OptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionValueV6(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO6* ScopeInfo, DHCP_OPTION_VALUE** OptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptionValuesV5(PWSTR ServerIpAddress, uint Flags, PWSTR ClassName, PWSTR VendorName, 
                            DHCP_OPTION_SCOPE_INFO* ScopeInfo, uint* ResumeHandle, uint PreferredMaximum, 
                            DHCP_OPTION_VALUE_ARRAY** OptionValues, uint* OptionsRead, uint* OptionsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOptionValueV5(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                             DHCP_OPTION_SCOPE_INFO* ScopeInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateClass(PWSTR ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* ClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpModifyClass(PWSTR ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* ClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpDeleteClass(PWSTR ServerIpAddress, uint ReservedMustBeZero, PWSTR ClassName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetClassInfo(PWSTR ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* PartialClassInfo, 
                      DHCP_CLASS_INFO** FilledClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumClasses(PWSTR ServerIpAddress, uint ReservedMustBeZero, uint* ResumeHandle, uint PreferredMaximum, 
                     DHCP_CLASS_INFO_ARRAY** ClassInfoArray, uint* nRead, uint* nTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetAllOptions(PWSTR ServerIpAddress, uint Flags, DHCP_ALL_OPTIONS** OptionStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetAllOptionsV6(PWSTR ServerIpAddress, uint Flags, DHCP_ALL_OPTIONS** OptionStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetAllOptionValues(PWSTR ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO* ScopeInfo, 
                            DHCP_ALL_OPTION_VALUES** Values);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetAllOptionValuesV6(PWSTR ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, 
                              DHCP_ALL_OPTION_VALUES** Values);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumServers(uint Flags, void* IdInfo, DHCPDS_SERVERS** Servers, void* CallbackFn, void* CallbackData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpAddServer(uint Flags, void* IdInfo, DHCPDS_SERVER* NewServer, void* CallbackFn, void* CallbackData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpDeleteServer(uint Flags, void* IdInfo, DHCPDS_SERVER* NewServer, void* CallbackFn, void* CallbackData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetServerBindingInfo(const(PWSTR) ServerIpAddress, uint Flags, DHCP_BIND_ELEMENT_ARRAY** BindElementsInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetServerBindingInfo(const(PWSTR) ServerIpAddress, uint Flags, DHCP_BIND_ELEMENT_ARRAY* BindElementInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpAddSubnetElementV5(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                            const(DHCP_SUBNET_ELEMENT_DATA_V5)* AddElementInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetElementsV5(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                              DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                              DHCP_SUBNET_ELEMENT_INFO_ARRAY_V5** EnumElementInfo, uint* ElementsRead, 
                              uint* ElementsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpRemoveSubnetElementV5(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                               const(DHCP_SUBNET_ELEMENT_DATA_V5)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4EnumSubnetReservations(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                                  uint PreferredMaximum, DHCP_RESERVATION_INFO_ARRAY** EnumElementInfo, 
                                  uint* ElementsRead, uint* ElementsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateOptionV6(PWSTR ServerIpAddress, uint Flags, uint OptionId, PWSTR ClassName, PWSTR VendorName, 
                        DHCP_OPTION* OptionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOptionV6(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptionsV6(PWSTR ServerIpAddress, uint Flags, PWSTR ClassName, PWSTR VendorName, uint* ResumeHandle, 
                       uint PreferredMaximum, DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpRemoveOptionValueV6(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                             DHCP_OPTION_SCOPE_INFO6* ScopeInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetOptionInfoV6(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                         DHCP_OPTION** OptionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionInfoV6(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                         DHCP_OPTION* OptionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetOptionValueV6(PWSTR ServerIpAddress, uint Flags, uint OptionId, PWSTR ClassName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO6* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetSubnetInfoVQ(const(PWSTR) ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_INFO_VQ** SubnetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateSubnetVQ(const(PWSTR) ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO_VQ)* SubnetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetSubnetInfoVQ(const(PWSTR) ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO_VQ)* SubnetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumOptionValuesV6(const(PWSTR) ServerIpAddress, uint Flags, PWSTR ClassName, PWSTR VendorName, 
                            DHCP_OPTION_SCOPE_INFO6* ScopeInfo, uint* ResumeHandle, uint PreferredMaximum, 
                            DHCP_OPTION_VALUE_ARRAY** OptionValues, uint* OptionsRead, uint* OptionsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpDsInit();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
void DhcpDsCleanup();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetThreadOptions(uint Flags, void* Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetThreadOptions(uint* pFlags, void* Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerQueryAttribute(PWSTR ServerIpAddr, uint dwReserved, uint DhcpAttribId, DHCP_ATTRIB** pDhcpAttrib);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerQueryAttributes(PWSTR ServerIpAddr, uint dwReserved, uint dwAttribCount, uint* pDhcpAttribs, 
                               DHCP_ATTRIB_ARRAY** pDhcpAttribArr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerRedoAuthorization(PWSTR ServerIpAddr, uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpAuditLogSetParams(PWSTR ServerIpAddress, uint Flags, PWSTR AuditLogDir, uint DiskCheckInterval, 
                           uint MaxLogFilesSize, uint MinSpaceOnDisk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpAuditLogGetParams(PWSTR ServerIpAddress, uint Flags, PWSTR* AuditLogDir, uint* DiskCheckInterval, 
                           uint* MaxLogFilesSize, uint* MinSpaceOnDisk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerQueryDnsRegCredentials(PWSTR ServerIpAddress, uint UnameSize, PWSTR Uname, uint DomainSize, 
                                      PWSTR Domain);

@DllImport("DHCPSAPI.dll")
uint DhcpServerSetDnsRegCredentials(PWSTR ServerIpAddress, PWSTR Uname, PWSTR Domain, PWSTR Passwd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerSetDnsRegCredentialsV5(PWSTR ServerIpAddress, PWSTR Uname, PWSTR Domain, PWSTR Passwd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerBackupDatabase(PWSTR ServerIpAddress, PWSTR Path);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerRestoreDatabase(PWSTR ServerIpAddress, PWSTR Path);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerSetConfigVQ(const(PWSTR) ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO_VQ* ConfigInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerGetConfigVQ(const(PWSTR) ServerIpAddress, DHCP_SERVER_CONFIG_INFO_VQ** ConfigInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetServerSpecificStrings(const(PWSTR) ServerIpAddress, 
                                  DHCP_SERVER_SPECIFIC_STRINGS** ServerSpecificStrings);

@DllImport("DHCPSAPI.dll")
void DhcpServerAuditlogParamsFree(DHCP_SERVER_CONFIG_INFO_VQ* ConfigInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateSubnetV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_SUBNET_INFO_V6* SubnetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpDeleteSubnetV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_FORCE_FLAG ForceFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetsV6(const(PWSTR) ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                       DHCPV6_IP_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpAddSubnetElementV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                            DHCP_SUBNET_ELEMENT_DATA_V6* AddElementInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpRemoveSubnetElementV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                               DHCP_SUBNET_ELEMENT_DATA_V6* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetElementsV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                              DHCP_SUBNET_ELEMENT_TYPE_V6 EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                              DHCP_SUBNET_ELEMENT_INFO_ARRAY_V6** EnumElementInfo, uint* ElementsRead, 
                              uint* ElementsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetSubnetInfoV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_SUBNET_INFO_V6** SubnetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumSubnetClientsV6(const(PWSTR) ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                             DHCP_IPV6_ADDRESS* ResumeHandle, uint PreferredMaximum, 
                             DHCP_CLIENT_INFO_ARRAY_V6** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerGetConfigV6(const(PWSTR) ServerIpAddress, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, 
                           DHCP_SERVER_CONFIG_INFO_V6** ConfigInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpServerSetConfigV6(const(PWSTR) ServerIpAddress, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, uint FieldsToSet, 
                           DHCP_SERVER_CONFIG_INFO_V6* ConfigInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetSubnetInfoV6(const(PWSTR) ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                         DHCP_SUBNET_INFO_V6* SubnetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetMibInfoV6(const(PWSTR) ServerIpAddress, DHCP_MIB_INFO_V6** MibInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetServerBindingInfoV6(const(PWSTR) ServerIpAddress, uint Flags, 
                                DHCPV6_BIND_ELEMENT_ARRAY** BindElementsInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetServerBindingInfoV6(const(PWSTR) ServerIpAddress, uint Flags, 
                                DHCPV6_BIND_ELEMENT_ARRAY* BindElementInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetClientInfoV6(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_V6)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetClientInfoV6(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO_V6)* SearchInfo, 
                         DHCP_CLIENT_INFO_V6** ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpDeleteClientInfoV6(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO_V6)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpCreateClassV6(PWSTR ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO_V6* ClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpModifyClassV6(PWSTR ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO_V6* ClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpDeleteClassV6(PWSTR ServerIpAddress, uint ReservedMustBeZero, PWSTR ClassName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpEnumClassesV6(PWSTR ServerIpAddress, uint ReservedMustBeZero, uint* ResumeHandle, uint PreferredMaximum, 
                       DHCP_CLASS_INFO_ARRAY_V6** ClassInfoArray, uint* nRead, uint* nTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpSetSubnetDelayOffer(PWSTR ServerIpAddress, uint SubnetAddress, ushort TimeDelayInMilliseconds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetSubnetDelayOffer(PWSTR ServerIpAddress, uint SubnetAddress, ushort* TimeDelayInMilliseconds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpGetMibInfoV5(const(PWSTR) ServerIpAddress, DHCP_MIB_INFO_V5** MibInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpAddSecurityGroup(PWSTR pServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4GetOptionValue(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR PolicyName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE** OptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4SetOptionValue(PWSTR ServerIpAddress, uint Flags, uint OptionId, PWSTR PolicyName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4SetOptionValues(PWSTR ServerIpAddress, uint Flags, PWSTR PolicyName, PWSTR VendorName, 
                           DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE_ARRAY* OptionValues);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4RemoveOptionValue(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR PolicyName, PWSTR VendorName, 
                             DHCP_OPTION_SCOPE_INFO* ScopeInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4GetAllOptionValues(PWSTR ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO* ScopeInfo, 
                              DHCP_ALL_OPTION_VALUES_PB** Values);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverCreateRelationship(PWSTR ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverSetRelationship(PWSTR ServerIpAddress, uint Flags, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverDeleteRelationship(PWSTR ServerIpAddress, PWSTR pRelationshipName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetRelationship(PWSTR ServerIpAddress, PWSTR pRelationshipName, 
                                   DHCP_FAILOVER_RELATIONSHIP** pRelationship);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverEnumRelationship(PWSTR ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                                    DHCP_FAILOVER_RELATIONSHIP_ARRAY** pRelationship, uint* RelationshipRead, 
                                    uint* RelationshipTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverAddScopeToRelationship(PWSTR ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverDeleteScopeFromRelationship(PWSTR ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetScopeRelationship(PWSTR ServerIpAddress, uint ScopeId, 
                                        DHCP_FAILOVER_RELATIONSHIP** pRelationship);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetScopeStatistics(PWSTR ServerIpAddress, uint ScopeId, DHCP_FAILOVER_STATISTICS** pStats);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetClientInfo(PWSTR ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                                 DHCPV4_FAILOVER_CLIENT_INFO** ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetSystemTime(PWSTR ServerIpAddress, uint* pTime, uint* pMaxAllowedDeltaTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverGetAddressStatus(PWSTR ServerIpAddress, uint SubnetAddress, uint* pStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4FailoverTriggerAddrAllocation(PWSTR ServerIpAddress, PWSTR pFailRelName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpHlprCreateV4Policy(PWSTR PolicyName, BOOL fGlobalPolicy, uint Subnet, uint ProcessingOrder, 
                            DHCP_POL_LOGIC_OPER RootOperator, PWSTR Description, BOOL Enabled, DHCP_POLICY** Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpHlprCreateV4PolicyEx(PWSTR PolicyName, BOOL fGlobalPolicy, uint Subnet, uint ProcessingOrder, 
                              DHCP_POL_LOGIC_OPER RootOperator, PWSTR Description, BOOL Enabled, 
                              DHCP_POLICY_EX** Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpHlprAddV4PolicyExpr(DHCP_POLICY* Policy, uint ParentExpr, DHCP_POL_LOGIC_OPER Operator, uint* ExprIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpHlprAddV4PolicyCondition(DHCP_POLICY* Policy, uint ParentExpr, DHCP_POL_ATTR_TYPE Type, uint OptionID, 
                                  uint SubOptionID, PWSTR VendorName, DHCP_POL_COMPARATOR Operator, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/ubyte* Value, 
                                  uint ValueLength, uint* ConditionIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpHlprAddV4PolicyRange(DHCP_POLICY* Policy, DHCP_IP_RANGE* Range);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpHlprResetV4PolicyExpr(DHCP_POLICY* Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpHlprModifyV4PolicyExpr(DHCP_POLICY* Policy, DHCP_POL_LOGIC_OPER Operator);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
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
DHCP_PROPERTY* DhcpHlprFindV4DhcpProperty(DHCP_PROPERTY_ARRAY* PropertyArray, DHCP_PROPERTY_ID ID, 
                                          DHCP_PROPERTY_TYPE Type);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
BOOL DhcpHlprIsV4PolicySingleUC(DHCP_POLICY* Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4QueryPolicyEnforcement(PWSTR ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, BOOL* Enabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4SetPolicyEnforcement(PWSTR ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, BOOL Enable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
BOOL DhcpHlprIsV4PolicyWellFormed(DHCP_POLICY* pPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpHlprIsV4PolicyValid(DHCP_POLICY* pPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4CreatePolicy(PWSTR ServerIpAddress, DHCP_POLICY* pPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4GetPolicy(PWSTR ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, PWSTR PolicyName, 
                     DHCP_POLICY** Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4SetPolicy(PWSTR ServerIpAddress, uint FieldsModified, BOOL fGlobalPolicy, uint SubnetAddress, 
                     PWSTR PolicyName, DHCP_POLICY* Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4DeletePolicy(PWSTR ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, PWSTR PolicyName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4EnumPolicies(PWSTR ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, BOOL fGlobalPolicy, 
                        uint SubnetAddress, DHCP_POLICY_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4AddPolicyRange(PWSTR ServerIpAddress, uint SubnetAddress, PWSTR PolicyName, DHCP_IP_RANGE* Range);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4RemovePolicyRange(PWSTR ServerIpAddress, uint SubnetAddress, PWSTR PolicyName, DHCP_IP_RANGE* Range);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV6SetStatelessStoreParams(PWSTR ServerIpAddress, BOOL fServerLevel, DHCP_IPV6_ADDRESS SubnetAddress, 
                                   uint FieldModified, DHCPV6_STATELESS_PARAMS* Params);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV6GetStatelessStoreParams(PWSTR ServerIpAddress, BOOL fServerLevel, DHCP_IPV6_ADDRESS SubnetAddress, 
                                   DHCPV6_STATELESS_PARAMS** Params);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV6GetStatelessStatistics(PWSTR ServerIpAddress, DHCPV6_STATELESS_STATS** StatelessStats);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4CreateClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_PB)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4EnumSubnetClients(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_PB_ARRAY** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4GetClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                         DHCP_CLIENT_INFO_PB** ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV6CreateClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_V6)* ClientInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV4GetFreeIPAddress(PWSTR ServerIpAddress, uint ScopeId, uint StartIP, uint EndIP, uint NumFreeAddrReq, 
                            DHCP_IP_ARRAY** IPAddrList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("DHCPSAPI.dll")
uint DhcpV6GetFreeIPAddress(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS ScopeId, DHCP_IPV6_ADDRESS StartIP, 
                            DHCP_IPV6_ADDRESS EndIP, uint NumFreeAddrReq, DHCPV6_IP_ARRAY** IPAddrList);

@DllImport("DHCPSAPI.dll")
uint DhcpV4CreateClientInfoEx(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_EX)* ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpV4EnumSubnetClientsEx(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                               uint PreferredMaximum, DHCP_CLIENT_INFO_EX_ARRAY** ClientInfo, uint* ClientsRead, 
                               uint* ClientsTotal);

@DllImport("DHCPSAPI.dll")
uint DhcpV4GetClientInfoEx(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                           DHCP_CLIENT_INFO_EX** ClientInfo);

@DllImport("DHCPSAPI.dll")
uint DhcpV4CreatePolicyEx(PWSTR ServerIpAddress, DHCP_POLICY_EX* PolicyEx);

@DllImport("DHCPSAPI.dll")
uint DhcpV4GetPolicyEx(PWSTR ServerIpAddress, BOOL GlobalPolicy, uint SubnetAddress, PWSTR PolicyName, 
                       DHCP_POLICY_EX** Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpV4SetPolicyEx(PWSTR ServerIpAddress, uint FieldsModified, BOOL GlobalPolicy, uint SubnetAddress, 
                       PWSTR PolicyName, DHCP_POLICY_EX* Policy);

@DllImport("DHCPSAPI.dll")
uint DhcpV4EnumPoliciesEx(PWSTR ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, BOOL GlobalPolicy, 
                          uint SubnetAddress, DHCP_POLICY_EX_ARRAY** EnumInfo, uint* ElementsRead, 
                          uint* ElementsTotal);


