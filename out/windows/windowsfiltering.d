module windows.windowsfiltering;

public import windows.core;
public import windows.kernel : COMPARTMENT_ID, LUID;
public import windows.security : ACL, SEC_WINNT_AUTH_IDENTITY_W, SID, SID_AND_ATTRIBUTES;
public import windows.systemservices : BOOL, HANDLE;
public import windows.winsock : SCOPE_ID, in6_addr, in_addr;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    FWP_DIRECTION_OUTBOUND = 0x00000000,
    FWP_DIRECTION_INBOUND  = 0x00000001,
    FWP_DIRECTION_MAX      = 0x00000002,
}
alias FWP_DIRECTION = int;

enum : int
{
    FWP_IP_VERSION_V4   = 0x00000000,
    FWP_IP_VERSION_V6   = 0x00000001,
    FWP_IP_VERSION_NONE = 0x00000002,
    FWP_IP_VERSION_MAX  = 0x00000003,
}
alias FWP_IP_VERSION = int;

enum : int
{
    FWP_AF_INET  = 0x00000000,
    FWP_AF_INET6 = 0x00000001,
    FWP_AF_ETHER = 0x00000002,
    FWP_AF_NONE  = 0x00000003,
}
alias FWP_AF = int;

enum : int
{
    FWP_ETHER_ENCAP_METHOD_ETHER_V2        = 0x00000000,
    FWP_ETHER_ENCAP_METHOD_SNAP            = 0x00000001,
    FWP_ETHER_ENCAP_METHOD_SNAP_W_OUI_ZERO = 0x00000003,
}
alias FWP_ETHER_ENCAP_METHOD = int;

enum : int
{
    FWP_EMPTY                         = 0x00000000,
    FWP_UINT8                         = 0x00000001,
    FWP_UINT16                        = 0x00000002,
    FWP_UINT32                        = 0x00000003,
    FWP_UINT64                        = 0x00000004,
    FWP_INT8                          = 0x00000005,
    FWP_INT16                         = 0x00000006,
    FWP_INT32                         = 0x00000007,
    FWP_INT64                         = 0x00000008,
    FWP_FLOAT                         = 0x00000009,
    FWP_DOUBLE                        = 0x0000000a,
    FWP_BYTE_ARRAY16_TYPE             = 0x0000000b,
    FWP_BYTE_BLOB_TYPE                = 0x0000000c,
    FWP_SID                           = 0x0000000d,
    FWP_SECURITY_DESCRIPTOR_TYPE      = 0x0000000e,
    FWP_TOKEN_INFORMATION_TYPE        = 0x0000000f,
    FWP_TOKEN_ACCESS_INFORMATION_TYPE = 0x00000010,
    FWP_UNICODE_STRING_TYPE           = 0x00000011,
    FWP_BYTE_ARRAY6_TYPE              = 0x00000012,
    FWP_BITMAP_INDEX_TYPE             = 0x00000013,
    FWP_BITMAP_ARRAY64_TYPE           = 0x00000014,
    FWP_SINGLE_DATA_TYPE_MAX          = 0x000000ff,
    FWP_V4_ADDR_MASK                  = 0x00000100,
    FWP_V6_ADDR_MASK                  = 0x00000101,
    FWP_RANGE_TYPE                    = 0x00000102,
    FWP_DATA_TYPE_MAX                 = 0x00000103,
}
alias FWP_DATA_TYPE = int;

enum : int
{
    FWP_MATCH_EQUAL                  = 0x00000000,
    FWP_MATCH_GREATER                = 0x00000001,
    FWP_MATCH_LESS                   = 0x00000002,
    FWP_MATCH_GREATER_OR_EQUAL       = 0x00000003,
    FWP_MATCH_LESS_OR_EQUAL          = 0x00000004,
    FWP_MATCH_RANGE                  = 0x00000005,
    FWP_MATCH_FLAGS_ALL_SET          = 0x00000006,
    FWP_MATCH_FLAGS_ANY_SET          = 0x00000007,
    FWP_MATCH_FLAGS_NONE_SET         = 0x00000008,
    FWP_MATCH_EQUAL_CASE_INSENSITIVE = 0x00000009,
    FWP_MATCH_NOT_EQUAL              = 0x0000000a,
    FWP_MATCH_PREFIX                 = 0x0000000b,
    FWP_MATCH_NOT_PREFIX             = 0x0000000c,
    FWP_MATCH_TYPE_MAX               = 0x0000000d,
}
alias FWP_MATCH_TYPE = int;

enum : int
{
    FWP_CLASSIFY_OPTION_MULTICAST_STATE                    = 0x00000000,
    FWP_CLASSIFY_OPTION_LOOSE_SOURCE_MAPPING               = 0x00000001,
    FWP_CLASSIFY_OPTION_UNICAST_LIFETIME                   = 0x00000002,
    FWP_CLASSIFY_OPTION_MCAST_BCAST_LIFETIME               = 0x00000003,
    FWP_CLASSIFY_OPTION_SECURE_SOCKET_SECURITY_FLAGS       = 0x00000004,
    FWP_CLASSIFY_OPTION_SECURE_SOCKET_AUTHIP_MM_POLICY_KEY = 0x00000005,
    FWP_CLASSIFY_OPTION_SECURE_SOCKET_AUTHIP_QM_POLICY_KEY = 0x00000006,
    FWP_CLASSIFY_OPTION_LOCAL_ONLY_MAPPING                 = 0x00000007,
    FWP_CLASSIFY_OPTION_MAX                                = 0x00000008,
}
alias FWP_CLASSIFY_OPTION_TYPE = int;

enum : int
{
    FWP_VSWITCH_NETWORK_TYPE_UNKNOWN  = 0x00000000,
    FWP_VSWITCH_NETWORK_TYPE_PRIVATE  = 0x00000001,
    FWP_VSWITCH_NETWORK_TYPE_INTERNAL = 0x00000002,
    FWP_VSWITCH_NETWORK_TYPE_EXTERNAL = 0x00000003,
}
alias FWP_VSWITCH_NETWORK_TYPE = int;

enum : int
{
    FWP_FILTER_ENUM_FULLY_CONTAINED = 0x00000000,
    FWP_FILTER_ENUM_OVERLAPPING     = 0x00000001,
    FWP_FILTER_ENUM_TYPE_MAX        = 0x00000002,
}
alias FWP_FILTER_ENUM_TYPE = int;

enum : int
{
    IKEEXT_KEY_MODULE_IKE    = 0x00000000,
    IKEEXT_KEY_MODULE_AUTHIP = 0x00000001,
    IKEEXT_KEY_MODULE_IKEV2  = 0x00000002,
    IKEEXT_KEY_MODULE_MAX    = 0x00000003,
}
alias IKEEXT_KEY_MODULE_TYPE = int;

enum : int
{
    IKEEXT_PRESHARED_KEY                  = 0x00000000,
    IKEEXT_CERTIFICATE                    = 0x00000001,
    IKEEXT_KERBEROS                       = 0x00000002,
    IKEEXT_ANONYMOUS                      = 0x00000003,
    IKEEXT_SSL                            = 0x00000004,
    IKEEXT_NTLM_V2                        = 0x00000005,
    IKEEXT_IPV6_CGA                       = 0x00000006,
    IKEEXT_CERTIFICATE_ECDSA_P256         = 0x00000007,
    IKEEXT_CERTIFICATE_ECDSA_P384         = 0x00000008,
    IKEEXT_SSL_ECDSA_P256                 = 0x00000009,
    IKEEXT_SSL_ECDSA_P384                 = 0x0000000a,
    IKEEXT_EAP                            = 0x0000000b,
    IKEEXT_RESERVED                       = 0x0000000c,
    IKEEXT_AUTHENTICATION_METHOD_TYPE_MAX = 0x0000000d,
}
alias IKEEXT_AUTHENTICATION_METHOD_TYPE = int;

enum : int
{
    IKEEXT_IMPERSONATION_NONE             = 0x00000000,
    IKEEXT_IMPERSONATION_SOCKET_PRINCIPAL = 0x00000001,
    IKEEXT_IMPERSONATION_MAX              = 0x00000002,
}
alias IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE = int;

enum : int
{
    IKEEXT_CERT_CONFIG_EXPLICIT_TRUST_LIST = 0x00000000,
    IKEEXT_CERT_CONFIG_ENTERPRISE_STORE    = 0x00000001,
    IKEEXT_CERT_CONFIG_TRUSTED_ROOT_STORE  = 0x00000002,
    IKEEXT_CERT_CONFIG_UNSPECIFIED         = 0x00000003,
    IKEEXT_CERT_CONFIG_TYPE_MAX            = 0x00000004,
}
alias IKEEXT_CERT_CONFIG_TYPE = int;

enum : int
{
    IKEEXT_CERT_CRITERIA_DNS           = 0x00000000,
    IKEEXT_CERT_CRITERIA_UPN           = 0x00000001,
    IKEEXT_CERT_CRITERIA_RFC822        = 0x00000002,
    IKEEXT_CERT_CRITERIA_CN            = 0x00000003,
    IKEEXT_CERT_CRITERIA_OU            = 0x00000004,
    IKEEXT_CERT_CRITERIA_O             = 0x00000005,
    IKEEXT_CERT_CRITERIA_DC            = 0x00000006,
    IKEEXT_CERT_CRITERIA_NAME_TYPE_MAX = 0x00000007,
}
alias IKEEXT_CERT_CRITERIA_NAME_TYPE = int;

enum : int
{
    IKEEXT_CIPHER_DES               = 0x00000000,
    IKEEXT_CIPHER_3DES              = 0x00000001,
    IKEEXT_CIPHER_AES_128           = 0x00000002,
    IKEEXT_CIPHER_AES_192           = 0x00000003,
    IKEEXT_CIPHER_AES_256           = 0x00000004,
    IKEEXT_CIPHER_AES_GCM_128_16ICV = 0x00000005,
    IKEEXT_CIPHER_AES_GCM_256_16ICV = 0x00000006,
    IKEEXT_CIPHER_TYPE_MAX          = 0x00000007,
}
alias IKEEXT_CIPHER_TYPE = int;

enum : int
{
    IKEEXT_INTEGRITY_MD5      = 0x00000000,
    IKEEXT_INTEGRITY_SHA1     = 0x00000001,
    IKEEXT_INTEGRITY_SHA_256  = 0x00000002,
    IKEEXT_INTEGRITY_SHA_384  = 0x00000003,
    IKEEXT_INTEGRITY_TYPE_MAX = 0x00000004,
}
alias IKEEXT_INTEGRITY_TYPE = int;

enum : int
{
    IKEEXT_DH_GROUP_NONE = 0x00000000,
    IKEEXT_DH_GROUP_1    = 0x00000001,
    IKEEXT_DH_GROUP_2    = 0x00000002,
    IKEEXT_DH_GROUP_14   = 0x00000003,
    IKEEXT_DH_GROUP_2048 = 0x00000003,
    IKEEXT_DH_ECP_256    = 0x00000004,
    IKEEXT_DH_ECP_384    = 0x00000005,
    IKEEXT_DH_GROUP_24   = 0x00000006,
    IKEEXT_DH_GROUP_MAX  = 0x00000007,
}
alias IKEEXT_DH_GROUP = int;

enum : int
{
    IKEEXT_MM_SA_STATE_NONE       = 0x00000000,
    IKEEXT_MM_SA_STATE_SA_SENT    = 0x00000001,
    IKEEXT_MM_SA_STATE_SSPI_SENT  = 0x00000002,
    IKEEXT_MM_SA_STATE_FINAL      = 0x00000003,
    IKEEXT_MM_SA_STATE_FINAL_SENT = 0x00000004,
    IKEEXT_MM_SA_STATE_COMPLETE   = 0x00000005,
    IKEEXT_MM_SA_STATE_MAX        = 0x00000006,
}
alias IKEEXT_MM_SA_STATE = int;

enum : int
{
    IKEEXT_QM_SA_STATE_NONE     = 0x00000000,
    IKEEXT_QM_SA_STATE_INITIAL  = 0x00000001,
    IKEEXT_QM_SA_STATE_FINAL    = 0x00000002,
    IKEEXT_QM_SA_STATE_COMPLETE = 0x00000003,
    IKEEXT_QM_SA_STATE_MAX      = 0x00000004,
}
alias IKEEXT_QM_SA_STATE = int;

enum : int
{
    IKEEXT_EM_SA_STATE_NONE          = 0x00000000,
    IKEEXT_EM_SA_STATE_SENT_ATTS     = 0x00000001,
    IKEEXT_EM_SA_STATE_SSPI_SENT     = 0x00000002,
    IKEEXT_EM_SA_STATE_AUTH_COMPLETE = 0x00000003,
    IKEEXT_EM_SA_STATE_FINAL         = 0x00000004,
    IKEEXT_EM_SA_STATE_COMPLETE      = 0x00000005,
    IKEEXT_EM_SA_STATE_MAX           = 0x00000006,
}
alias IKEEXT_EM_SA_STATE = int;

enum : int
{
    IKEEXT_SA_ROLE_INITIATOR = 0x00000000,
    IKEEXT_SA_ROLE_RESPONDER = 0x00000001,
    IKEEXT_SA_ROLE_MAX       = 0x00000002,
}
alias IKEEXT_SA_ROLE = int;

enum : int
{
    IPSEC_TRANSFORM_AH                  = 0x00000001,
    IPSEC_TRANSFORM_ESP_AUTH            = 0x00000002,
    IPSEC_TRANSFORM_ESP_CIPHER          = 0x00000003,
    IPSEC_TRANSFORM_ESP_AUTH_AND_CIPHER = 0x00000004,
    IPSEC_TRANSFORM_ESP_AUTH_FW         = 0x00000005,
    IPSEC_TRANSFORM_TYPE_MAX            = 0x00000006,
}
alias IPSEC_TRANSFORM_TYPE = int;

enum : int
{
    IPSEC_AUTH_MD5     = 0x00000000,
    IPSEC_AUTH_SHA_1   = 0x00000001,
    IPSEC_AUTH_SHA_256 = 0x00000002,
    IPSEC_AUTH_AES_128 = 0x00000003,
    IPSEC_AUTH_AES_192 = 0x00000004,
    IPSEC_AUTH_AES_256 = 0x00000005,
    IPSEC_AUTH_MAX     = 0x00000006,
}
alias IPSEC_AUTH_TYPE = int;

enum : int
{
    IPSEC_CIPHER_TYPE_DES     = 0x00000001,
    IPSEC_CIPHER_TYPE_3DES    = 0x00000002,
    IPSEC_CIPHER_TYPE_AES_128 = 0x00000003,
    IPSEC_CIPHER_TYPE_AES_192 = 0x00000004,
    IPSEC_CIPHER_TYPE_AES_256 = 0x00000005,
    IPSEC_CIPHER_TYPE_MAX     = 0x00000006,
}
alias IPSEC_CIPHER_TYPE = int;

enum : int
{
    IPSEC_PFS_NONE    = 0x00000000,
    IPSEC_PFS_1       = 0x00000001,
    IPSEC_PFS_2       = 0x00000002,
    IPSEC_PFS_2048    = 0x00000003,
    IPSEC_PFS_14      = 0x00000003,
    IPSEC_PFS_ECP_256 = 0x00000004,
    IPSEC_PFS_ECP_384 = 0x00000005,
    IPSEC_PFS_MM      = 0x00000006,
    IPSEC_PFS_24      = 0x00000007,
    IPSEC_PFS_MAX     = 0x00000008,
}
alias IPSEC_PFS_GROUP = int;

enum : int
{
    IPSEC_TOKEN_TYPE_MACHINE       = 0x00000000,
    IPSEC_TOKEN_TYPE_IMPERSONATION = 0x00000001,
    IPSEC_TOKEN_TYPE_MAX           = 0x00000002,
}
alias IPSEC_TOKEN_TYPE = int;

enum : int
{
    IPSEC_TOKEN_PRINCIPAL_LOCAL = 0x00000000,
    IPSEC_TOKEN_PRINCIPAL_PEER  = 0x00000001,
    IPSEC_TOKEN_PRINCIPAL_MAX   = 0x00000002,
}
alias IPSEC_TOKEN_PRINCIPAL = int;

enum : int
{
    IPSEC_TOKEN_MODE_MAIN     = 0x00000000,
    IPSEC_TOKEN_MODE_EXTENDED = 0x00000001,
    IPSEC_TOKEN_MODE_MAX      = 0x00000002,
}
alias IPSEC_TOKEN_MODE = int;

enum : int
{
    IPSEC_TRAFFIC_TYPE_TRANSPORT = 0x00000000,
    IPSEC_TRAFFIC_TYPE_TUNNEL    = 0x00000001,
    IPSEC_TRAFFIC_TYPE_MAX       = 0x00000002,
}
alias IPSEC_TRAFFIC_TYPE = int;

enum : int
{
    IPSEC_SA_CONTEXT_EVENT_ADD    = 0x00000001,
    IPSEC_SA_CONTEXT_EVENT_DELETE = 0x00000002,
    IPSEC_SA_CONTEXT_EVENT_MAX    = 0x00000003,
}
alias IPSEC_SA_CONTEXT_EVENT_TYPE0 = int;

enum : int
{
    IPSEC_FAILURE_NONE      = 0x00000000,
    IPSEC_FAILURE_ME        = 0x00000001,
    IPSEC_FAILURE_PEER      = 0x00000002,
    IPSEC_FAILURE_POINT_MAX = 0x00000003,
}
alias IPSEC_FAILURE_POINT = int;

enum : int
{
    DlUnicast   = 0x00000000,
    DlMulticast = 0x00000001,
    DlBroadcast = 0x00000002,
}
alias DL_ADDRESS_TYPE = int;

enum : int
{
    FWPM_CHANGE_ADD      = 0x00000001,
    FWPM_CHANGE_DELETE   = 0x00000002,
    FWPM_CHANGE_TYPE_MAX = 0x00000003,
}
alias FWPM_CHANGE_TYPE = int;

enum : int
{
    FWPM_SERVICE_STOPPED       = 0x00000000,
    FWPM_SERVICE_START_PENDING = 0x00000001,
    FWPM_SERVICE_STOP_PENDING  = 0x00000002,
    FWPM_SERVICE_RUNNING       = 0x00000003,
    FWPM_SERVICE_STATE_MAX     = 0x00000004,
}
alias FWPM_SERVICE_STATE = int;

enum : int
{
    FWPM_ENGINE_COLLECT_NET_EVENTS           = 0x00000000,
    FWPM_ENGINE_NET_EVENT_MATCH_ANY_KEYWORDS = 0x00000001,
    FWPM_ENGINE_NAME_CACHE                   = 0x00000002,
    FWPM_ENGINE_MONITOR_IPSEC_CONNECTIONS    = 0x00000003,
    FWPM_ENGINE_PACKET_QUEUING               = 0x00000004,
    FWPM_ENGINE_TXN_WATCHDOG_TIMEOUT_IN_MSEC = 0x00000005,
    FWPM_ENGINE_OPTION_MAX                   = 0x00000006,
}
alias FWPM_ENGINE_OPTION = int;

enum : int
{
    FWPM_IPSEC_KEYING_CONTEXT              = 0x00000000,
    FWPM_IPSEC_IKE_QM_TRANSPORT_CONTEXT    = 0x00000001,
    FWPM_IPSEC_IKE_QM_TUNNEL_CONTEXT       = 0x00000002,
    FWPM_IPSEC_AUTHIP_QM_TRANSPORT_CONTEXT = 0x00000003,
    FWPM_IPSEC_AUTHIP_QM_TUNNEL_CONTEXT    = 0x00000004,
    FWPM_IPSEC_IKE_MM_CONTEXT              = 0x00000005,
    FWPM_IPSEC_AUTHIP_MM_CONTEXT           = 0x00000006,
    FWPM_CLASSIFY_OPTIONS_CONTEXT          = 0x00000007,
    FWPM_GENERAL_CONTEXT                   = 0x00000008,
    FWPM_IPSEC_IKEV2_QM_TUNNEL_CONTEXT     = 0x00000009,
    FWPM_IPSEC_IKEV2_MM_CONTEXT            = 0x0000000a,
    FWPM_IPSEC_DOSP_CONTEXT                = 0x0000000b,
    FWPM_IPSEC_IKEV2_QM_TRANSPORT_CONTEXT  = 0x0000000c,
    FWPM_PROVIDER_CONTEXT_TYPE_MAX         = 0x0000000d,
}
alias FWPM_PROVIDER_CONTEXT_TYPE = int;

enum : int
{
    FWPM_FIELD_RAW_DATA   = 0x00000000,
    FWPM_FIELD_IP_ADDRESS = 0x00000001,
    FWPM_FIELD_FLAGS      = 0x00000002,
    FWPM_FIELD_TYPE_MAX   = 0x00000003,
}
alias FWPM_FIELD_TYPE = int;

enum : int
{
    FWPM_NET_EVENT_TYPE_IKEEXT_MM_FAILURE  = 0x00000000,
    FWPM_NET_EVENT_TYPE_IKEEXT_QM_FAILURE  = 0x00000001,
    FWPM_NET_EVENT_TYPE_IKEEXT_EM_FAILURE  = 0x00000002,
    FWPM_NET_EVENT_TYPE_CLASSIFY_DROP      = 0x00000003,
    FWPM_NET_EVENT_TYPE_IPSEC_KERNEL_DROP  = 0x00000004,
    FWPM_NET_EVENT_TYPE_IPSEC_DOSP_DROP    = 0x00000005,
    FWPM_NET_EVENT_TYPE_CLASSIFY_ALLOW     = 0x00000006,
    FWPM_NET_EVENT_TYPE_CAPABILITY_DROP    = 0x00000007,
    FWPM_NET_EVENT_TYPE_CAPABILITY_ALLOW   = 0x00000008,
    FWPM_NET_EVENT_TYPE_CLASSIFY_DROP_MAC  = 0x00000009,
    FWPM_NET_EVENT_TYPE_LPM_PACKET_ARRIVAL = 0x0000000a,
    FWPM_NET_EVENT_TYPE_MAX                = 0x0000000b,
}
alias FWPM_NET_EVENT_TYPE = int;

enum : int
{
    FWPM_APPC_NETWORK_CAPABILITY_INTERNET_CLIENT          = 0x00000000,
    FWPM_APPC_NETWORK_CAPABILITY_INTERNET_CLIENT_SERVER   = 0x00000001,
    FWPM_APPC_NETWORK_CAPABILITY_INTERNET_PRIVATE_NETWORK = 0x00000002,
}
alias FWPM_APPC_NETWORK_CAPABILITY_TYPE = int;

enum : int
{
    FWPM_SYSTEM_PORT_RPC_EPMAP   = 0x00000000,
    FWPM_SYSTEM_PORT_TEREDO      = 0x00000001,
    FWPM_SYSTEM_PORT_IPHTTPS_IN  = 0x00000002,
    FWPM_SYSTEM_PORT_IPHTTPS_OUT = 0x00000003,
    FWPM_SYSTEM_PORT_TYPE_MAX    = 0x00000004,
}
alias FWPM_SYSTEM_PORT_TYPE = int;

enum : int
{
    FWPM_CONNECTION_EVENT_ADD    = 0x00000000,
    FWPM_CONNECTION_EVENT_DELETE = 0x00000001,
    FWPM_CONNECTION_EVENT_MAX    = 0x00000002,
}
alias FWPM_CONNECTION_EVENT_TYPE = int;

enum : int
{
    FWPM_VSWITCH_EVENT_FILTER_ADD_TO_INCOMPLETE_LAYER         = 0x00000000,
    FWPM_VSWITCH_EVENT_FILTER_ENGINE_NOT_IN_REQUIRED_POSITION = 0x00000001,
    FWPM_VSWITCH_EVENT_ENABLED_FOR_INSPECTION                 = 0x00000002,
    FWPM_VSWITCH_EVENT_DISABLED_FOR_INSPECTION                = 0x00000003,
    FWPM_VSWITCH_EVENT_FILTER_ENGINE_REORDER                  = 0x00000004,
    FWPM_VSWITCH_EVENT_MAX                                    = 0x00000005,
}
alias FWPM_VSWITCH_EVENT_TYPE = int;

enum : int
{
    IP_OPT_EOL          = 0x00000000,
    IP_OPT_NOP          = 0x00000001,
    IP_OPT_SECURITY     = 0x00000082,
    IP_OPT_LSRR         = 0x00000083,
    IP_OPT_TS           = 0x00000044,
    IP_OPT_RR           = 0x00000007,
    IP_OPT_SSRR         = 0x00000089,
    IP_OPT_SID          = 0x00000088,
    IP_OPT_ROUTER_ALERT = 0x00000094,
    IP_OPT_MULTIDEST    = 0x00000095,
}
alias IPV4_OPTION_TYPE = int;

enum : int
{
    IP_OPTION_TIMESTAMP_ONLY             = 0x00000000,
    IP_OPTION_TIMESTAMP_ADDRESS          = 0x00000001,
    IP_OPTION_TIMESTAMP_SPECIFIC_ADDRESS = 0x00000003,
}
alias IP_OPTION_TIMESTAMP_FLAGS = int;

enum : int
{
    ICMP4_UNREACH_NET                = 0x00000000,
    ICMP4_UNREACH_HOST               = 0x00000001,
    ICMP4_UNREACH_PROTOCOL           = 0x00000002,
    ICMP4_UNREACH_PORT               = 0x00000003,
    ICMP4_UNREACH_FRAG_NEEDED        = 0x00000004,
    ICMP4_UNREACH_SOURCEROUTE_FAILED = 0x00000005,
    ICMP4_UNREACH_NET_UNKNOWN        = 0x00000006,
    ICMP4_UNREACH_HOST_UNKNOWN       = 0x00000007,
    ICMP4_UNREACH_ISOLATED           = 0x00000008,
    ICMP4_UNREACH_NET_ADMIN          = 0x00000009,
    ICMP4_UNREACH_HOST_ADMIN         = 0x0000000a,
    ICMP4_UNREACH_NET_TOS            = 0x0000000b,
    ICMP4_UNREACH_HOST_TOS           = 0x0000000c,
    ICMP4_UNREACH_ADMIN              = 0x0000000d,
}
alias ICMP4_UNREACH_CODE = int;

enum : int
{
    ICMP4_TIME_EXCEED_TRANSIT    = 0x00000000,
    ICMP4_TIME_EXCEED_REASSEMBLY = 0x00000001,
}
alias ICMP4_TIME_EXCEED_CODE = int;

enum : int
{
    ARP_REQUEST  = 0x00000001,
    ARP_RESPONSE = 0x00000002,
}
alias ARP_OPCODE = int;

enum : int
{
    ARP_HW_ENET = 0x00000001,
    ARP_HW_802  = 0x00000006,
}
alias ARP_HARDWARE_TYPE = int;

enum : int
{
    IGMP_MAX_RESP_CODE_TYPE_NORMAL = 0x00000000,
    IGMP_MAX_RESP_CODE_TYPE_FLOAT  = 0x00000001,
}
alias IGMP_MAX_RESP_CODE_TYPE = int;

enum : int
{
    IP6OPT_PAD1         = 0x00000000,
    IP6OPT_PADN         = 0x00000001,
    IP6OPT_TUNNEL_LIMIT = 0x00000004,
    IP6OPT_ROUTER_ALERT = 0x00000005,
    IP6OPT_JUMBO        = 0x000000c2,
    IP6OPT_NSAP_ADDR    = 0x000000c3,
}
alias IPV6_OPTION_TYPE = int;

enum : int
{
    ND_OPT_SOURCE_LINKADDR        = 0x00000001,
    ND_OPT_TARGET_LINKADDR        = 0x00000002,
    ND_OPT_PREFIX_INFORMATION     = 0x00000003,
    ND_OPT_REDIRECTED_HEADER      = 0x00000004,
    ND_OPT_MTU                    = 0x00000005,
    ND_OPT_NBMA_SHORTCUT_LIMIT    = 0x00000006,
    ND_OPT_ADVERTISEMENT_INTERVAL = 0x00000007,
    ND_OPT_HOME_AGENT_INFORMATION = 0x00000008,
    ND_OPT_SOURCE_ADDR_LIST       = 0x00000009,
    ND_OPT_TARGET_ADDR_LIST       = 0x0000000a,
    ND_OPT_ROUTE_INFO             = 0x00000018,
    ND_OPT_RDNSS                  = 0x00000019,
    ND_OPT_DNSSL                  = 0x0000001f,
}
alias ND_OPTION_TYPE = int;

enum : int
{
    MLD_MAX_RESP_CODE_TYPE_NORMAL = 0x00000000,
    MLD_MAX_RESP_CODE_TYPE_FLOAT  = 0x00000001,
}
alias MLD_MAX_RESP_CODE_TYPE = int;

enum : int
{
    TUNNEL_SUB_TYPE_NONE  = 0x00000000,
    TUNNEL_SUB_TYPE_CP    = 0x00000001,
    TUNNEL_SUB_TYPE_IPTLS = 0x00000002,
    TUNNEL_SUB_TYPE_HA    = 0x00000003,
}
alias TUNNEL_SUB_TYPE = int;

enum : int
{
    MIT_GUID    = 0x00000001,
    MIT_IF_LUID = 0x00000002,
}
alias NPI_MODULEID_TYPE = int;

enum : int
{
    FallbackIndexTcpFastopen = 0x00000000,
    FallbackIndexMax         = 0x00000001,
}
alias FALLBACK_INDEX = int;

// Callbacks

alias FWPM_PROVIDER_CHANGE_CALLBACK0 = void function(void* context, const(FWPM_PROVIDER_CHANGE0)* change);
alias FWPM_PROVIDER_CONTEXT_CHANGE_CALLBACK0 = void function(void* context, 
                                                             const(FWPM_PROVIDER_CONTEXT_CHANGE0)* change);
alias FWPM_SUBLAYER_CHANGE_CALLBACK0 = void function(void* context, const(FWPM_SUBLAYER_CHANGE0)* change);
alias FWPM_CALLOUT_CHANGE_CALLBACK0 = void function(void* context, const(FWPM_CALLOUT_CHANGE0)* change);
alias FWPM_FILTER_CHANGE_CALLBACK0 = void function(void* context, const(FWPM_FILTER_CHANGE0)* change);
alias IPSEC_SA_CONTEXT_CALLBACK0 = void function(void* context, const(IPSEC_SA_CONTEXT_CHANGE0)* change);
alias IPSEC_KEY_MANAGER_KEY_DICTATION_CHECK0 = void function(const(IKEEXT_TRAFFIC0)* ikeTraffic, 
                                                             int* willDictateKey, uint* weight);
alias IPSEC_KEY_MANAGER_DICTATE_KEY0 = uint function(IPSEC_SA_DETAILS1* inboundSaDetails, 
                                                     IPSEC_SA_DETAILS1* outboundSaDetails, int* keyingModuleGenKey);
alias IPSEC_KEY_MANAGER_NOTIFY_KEY0 = void function(const(IPSEC_SA_DETAILS1)* inboundSa, 
                                                    const(IPSEC_SA_DETAILS1)* outboundSa);
alias FWPM_NET_EVENT_CALLBACK0 = void function(void* context, const(FWPM_NET_EVENT1)* event);
alias FWPM_NET_EVENT_CALLBACK1 = void function(void* context, const(FWPM_NET_EVENT2)* event);
alias FWPM_NET_EVENT_CALLBACK2 = void function(void* context, const(FWPM_NET_EVENT3)* event);
alias FWPM_NET_EVENT_CALLBACK3 = void function(void* context, const(FWPM_NET_EVENT4_)* event);
alias FWPM_NET_EVENT_CALLBACK4 = void function(void* context, const(FWPM_NET_EVENT5_)* event);
alias FWPM_SYSTEM_PORTS_CALLBACK0 = void function(void* context, const(FWPM_SYSTEM_PORTS0)* sysPorts);
alias FWPM_CONNECTION_CALLBACK0 = void function(void* context, FWPM_CONNECTION_EVENT_TYPE eventType, 
                                                const(FWPM_CONNECTION0)* connection);
alias FWPM_VSWITCH_EVENT_CALLBACK0 = uint function(void* context, const(FWPM_VSWITCH_EVENT0)* vSwitchEvent);

// Structs


struct FWP_BITMAP_ARRAY64_
{
    ubyte[8] bitmapArray64;
}

struct FWP_BYTE_ARRAY6
{
    ubyte[6] byteArray6;
}

struct FWP_BYTE_ARRAY16
{
    ubyte[16] byteArray16;
}

struct FWP_BYTE_BLOB
{
    uint   size;
    ubyte* data;
}

struct FWP_TOKEN_INFORMATION
{
    uint                sidCount;
    SID_AND_ATTRIBUTES* sids;
    uint                restrictedSidCount;
    SID_AND_ATTRIBUTES* restrictedSids;
}

struct FWP_VALUE0
{
    FWP_DATA_TYPE type;
    union
    {
        ubyte                uint8;
        ushort               uint16;
        uint                 uint32;
        ulong*               uint64;
        byte                 int8;
        short                int16;
        int                  int32;
        long*                int64;
        float                float32;
        double*              double64;
        FWP_BYTE_ARRAY16*    byteArray16;
        FWP_BYTE_BLOB*       byteBlob;
        SID*                 sid;
        FWP_BYTE_BLOB*       sd;
        FWP_TOKEN_INFORMATION* tokenInformation;
        FWP_BYTE_BLOB*       tokenAccessInformation;
        const(wchar)*        unicodeString;
        FWP_BYTE_ARRAY6*     byteArray6;
        FWP_BITMAP_ARRAY64_* bitmapArray64;
    }
}

struct FWP_V4_ADDR_AND_MASK
{
    uint addr;
    uint mask;
}

struct FWP_V6_ADDR_AND_MASK
{
    ubyte[16] addr;
    ubyte     prefixLength;
}

struct FWP_RANGE0
{
    FWP_VALUE0 valueLow;
    FWP_VALUE0 valueHigh;
}

struct FWP_CONDITION_VALUE0
{
    FWP_DATA_TYPE type;
    union
    {
        ubyte                uint8;
        ushort               uint16;
        uint                 uint32;
        ulong*               uint64;
        byte                 int8;
        short                int16;
        int                  int32;
        long*                int64;
        float                float32;
        double*              double64;
        FWP_BYTE_ARRAY16*    byteArray16;
        FWP_BYTE_BLOB*       byteBlob;
        SID*                 sid;
        FWP_BYTE_BLOB*       sd;
        FWP_TOKEN_INFORMATION* tokenInformation;
        FWP_BYTE_BLOB*       tokenAccessInformation;
        const(wchar)*        unicodeString;
        FWP_BYTE_ARRAY6*     byteArray6;
        FWP_BITMAP_ARRAY64_* bitmapArray64;
        FWP_V4_ADDR_AND_MASK* v4AddrMask;
        FWP_V6_ADDR_AND_MASK* v6AddrMask;
        FWP_RANGE0*          rangeValue;
    }
}

struct FWPM_DISPLAY_DATA0
{
    ushort* name;
    ushort* description;
}

struct IPSEC_VIRTUAL_IF_TUNNEL_INFO0
{
    ulong virtualIfTunnelId;
    ulong trafficSelectorId;
}

struct IKEEXT_PRESHARED_KEY_AUTHENTICATION0
{
    FWP_BYTE_BLOB presharedKey;
}

struct IKEEXT_PRESHARED_KEY_AUTHENTICATION1
{
    FWP_BYTE_BLOB presharedKey;
    uint          flags;
}

struct IKEEXT_CERT_ROOT_CONFIG0
{
    FWP_BYTE_BLOB certData;
    uint          flags;
}

struct IKEEXT_CERTIFICATE_AUTHENTICATION0
{
    IKEEXT_CERT_CONFIG_TYPE inboundConfigType;
    union
    {
        struct
        {
            uint inboundRootArraySize;
            IKEEXT_CERT_ROOT_CONFIG0* inboundRootArray;
        }
        IKEEXT_CERT_ROOT_CONFIG0* inboundEnterpriseStoreConfig;
        IKEEXT_CERT_ROOT_CONFIG0* inboundTrustedRootStoreConfig;
    }
    IKEEXT_CERT_CONFIG_TYPE outboundConfigType;
    union
    {
        struct
        {
            uint outboundRootArraySize;
            IKEEXT_CERT_ROOT_CONFIG0* outboundRootArray;
        }
        IKEEXT_CERT_ROOT_CONFIG0* outboundEnterpriseStoreConfig;
        IKEEXT_CERT_ROOT_CONFIG0* outboundTrustedRootStoreConfig;
    }
    uint flags;
}

struct IKEEXT_CERTIFICATE_AUTHENTICATION1
{
    IKEEXT_CERT_CONFIG_TYPE inboundConfigType;
    union
    {
        struct
        {
            uint inboundRootArraySize;
            IKEEXT_CERT_ROOT_CONFIG0* inboundRootArray;
        }
        IKEEXT_CERT_ROOT_CONFIG0* inboundEnterpriseStoreConfig;
        IKEEXT_CERT_ROOT_CONFIG0* inboundTrustedRootStoreConfig;
    }
    IKEEXT_CERT_CONFIG_TYPE outboundConfigType;
    union
    {
        struct
        {
            uint outboundRootArraySize;
            IKEEXT_CERT_ROOT_CONFIG0* outboundRootArray;
        }
        IKEEXT_CERT_ROOT_CONFIG0* outboundEnterpriseStoreConfig;
        IKEEXT_CERT_ROOT_CONFIG0* outboundTrustedRootStoreConfig;
    }
    uint          flags;
    FWP_BYTE_BLOB localCertLocationUrl;
}

struct IKEEXT_CERT_EKUS0
{
    uint   numEku;
    byte** eku;
}

struct IKEEXT_CERT_NAME0
{
    IKEEXT_CERT_CRITERIA_NAME_TYPE nameType;
    const(wchar)* certName;
}

struct IKEEXT_CERTIFICATE_CRITERIA0
{
    FWP_BYTE_BLOB      certData;
    FWP_BYTE_BLOB      certHash;
    IKEEXT_CERT_EKUS0* eku;
    IKEEXT_CERT_NAME0* name;
    uint               flags;
}

struct IKEEXT_CERTIFICATE_AUTHENTICATION2
{
    IKEEXT_CERT_CONFIG_TYPE inboundConfigType;
    union
    {
        struct
        {
            uint inboundRootArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* inboundRootCriteria;
        }
        struct
        {
            uint inboundEnterpriseStoreArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* inboundEnterpriseStoreCriteria;
        }
        struct
        {
            uint inboundRootStoreArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* inboundTrustedRootStoreCriteria;
        }
    }
    IKEEXT_CERT_CONFIG_TYPE outboundConfigType;
    union
    {
        struct
        {
            uint outboundRootArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* outboundRootCriteria;
        }
        struct
        {
            uint outboundEnterpriseStoreArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* outboundEnterpriseStoreCriteria;
        }
        struct
        {
            uint outboundRootStoreArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* outboundTrustedRootStoreCriteria;
        }
    }
    uint          flags;
    FWP_BYTE_BLOB localCertLocationUrl;
}

struct IKEEXT_IPV6_CGA_AUTHENTICATION0
{
    ushort*          keyContainerName;
    ushort*          cspName;
    uint             cspType;
    FWP_BYTE_ARRAY16 cgaModifier;
    ubyte            cgaCollisionCount;
}

struct IKEEXT_KERBEROS_AUTHENTICATION0
{
    uint flags;
}

struct IKEEXT_KERBEROS_AUTHENTICATION1
{
    uint    flags;
    ushort* proxyServer;
}

struct IKEEXT_RESERVED_AUTHENTICATION0
{
    uint flags;
}

struct IKEEXT_NTLM_V2_AUTHENTICATION0
{
    uint flags;
}

struct IKEEXT_EAP_AUTHENTICATION0
{
    uint flags;
}

struct IKEEXT_AUTHENTICATION_METHOD0
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION0 presharedKeyAuthentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION0 certificateAuthentication;
        IKEEXT_KERBEROS_AUTHENTICATION0 kerberosAuthentication;
        IKEEXT_NTLM_V2_AUTHENTICATION0 ntlmV2Authentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION0 sslAuthentication;
        IKEEXT_IPV6_CGA_AUTHENTICATION0 cgaAuthentication;
    }
}

struct IKEEXT_AUTHENTICATION_METHOD1
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION1 presharedKeyAuthentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION1 certificateAuthentication;
        IKEEXT_KERBEROS_AUTHENTICATION0 kerberosAuthentication;
        IKEEXT_NTLM_V2_AUTHENTICATION0 ntlmV2Authentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION1 sslAuthentication;
        IKEEXT_IPV6_CGA_AUTHENTICATION0 cgaAuthentication;
        IKEEXT_EAP_AUTHENTICATION0 eapAuthentication;
    }
}

struct IKEEXT_AUTHENTICATION_METHOD2
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION1 presharedKeyAuthentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION2 certificateAuthentication;
        IKEEXT_KERBEROS_AUTHENTICATION1 kerberosAuthentication;
        IKEEXT_RESERVED_AUTHENTICATION0 reservedAuthentication;
        IKEEXT_NTLM_V2_AUTHENTICATION0 ntlmV2Authentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION2 sslAuthentication;
        IKEEXT_IPV6_CGA_AUTHENTICATION0 cgaAuthentication;
        IKEEXT_EAP_AUTHENTICATION0 eapAuthentication;
    }
}

struct IKEEXT_CIPHER_ALGORITHM0
{
    IKEEXT_CIPHER_TYPE algoIdentifier;
    uint               keyLen;
    uint               rounds;
}

struct IKEEXT_INTEGRITY_ALGORITHM0
{
    IKEEXT_INTEGRITY_TYPE algoIdentifier;
}

struct IKEEXT_PROPOSAL0
{
    IKEEXT_CIPHER_ALGORITHM0 cipherAlgorithm;
    IKEEXT_INTEGRITY_ALGORITHM0 integrityAlgorithm;
    uint            maxLifetimeSeconds;
    IKEEXT_DH_GROUP dhGroup;
    uint            quickModeLimit;
}

struct IKEEXT_POLICY0
{
    uint              softExpirationTime;
    uint              numAuthenticationMethods;
    IKEEXT_AUTHENTICATION_METHOD0* authenticationMethods;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
    uint              numIkeProposals;
    IKEEXT_PROPOSAL0* ikeProposals;
    uint              flags;
    uint              maxDynamicFilters;
}

struct IKEEXT_POLICY1
{
    uint              softExpirationTime;
    uint              numAuthenticationMethods;
    IKEEXT_AUTHENTICATION_METHOD1* authenticationMethods;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
    uint              numIkeProposals;
    IKEEXT_PROPOSAL0* ikeProposals;
    uint              flags;
    uint              maxDynamicFilters;
    uint              retransmitDurationSecs;
}

struct IKEEXT_POLICY2
{
    uint              softExpirationTime;
    uint              numAuthenticationMethods;
    IKEEXT_AUTHENTICATION_METHOD2* authenticationMethods;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
    uint              numIkeProposals;
    IKEEXT_PROPOSAL0* ikeProposals;
    uint              flags;
    uint              maxDynamicFilters;
    uint              retransmitDurationSecs;
}

struct IKEEXT_EM_POLICY0
{
    uint numAuthenticationMethods;
    IKEEXT_AUTHENTICATION_METHOD0* authenticationMethods;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
}

struct IKEEXT_EM_POLICY1
{
    uint numAuthenticationMethods;
    IKEEXT_AUTHENTICATION_METHOD1* authenticationMethods;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
}

struct IKEEXT_EM_POLICY2
{
    uint numAuthenticationMethods;
    IKEEXT_AUTHENTICATION_METHOD2* authenticationMethods;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
}

struct IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0
{
    uint currentActiveMainModes;
    uint totalMainModesStarted;
    uint totalSuccessfulMainModes;
    uint totalFailedMainModes;
    uint totalResponderMainModes;
    uint currentNewResponderMainModes;
    uint currentActiveQuickModes;
    uint totalQuickModesStarted;
    uint totalSuccessfulQuickModes;
    uint totalFailedQuickModes;
    uint totalAcquires;
    uint totalReinitAcquires;
    uint currentActiveExtendedModes;
    uint totalExtendedModesStarted;
    uint totalSuccessfulExtendedModes;
    uint totalFailedExtendedModes;
    uint totalImpersonationExtendedModes;
    uint totalImpersonationMainModes;
}

struct IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1
{
    uint currentActiveMainModes;
    uint totalMainModesStarted;
    uint totalSuccessfulMainModes;
    uint totalFailedMainModes;
    uint totalResponderMainModes;
    uint currentNewResponderMainModes;
    uint currentActiveQuickModes;
    uint totalQuickModesStarted;
    uint totalSuccessfulQuickModes;
    uint totalFailedQuickModes;
    uint totalAcquires;
    uint totalReinitAcquires;
    uint currentActiveExtendedModes;
    uint totalExtendedModesStarted;
    uint totalSuccessfulExtendedModes;
    uint totalFailedExtendedModes;
    uint totalImpersonationExtendedModes;
    uint totalImpersonationMainModes;
}

struct IKEEXT_KEYMODULE_STATISTICS0
{
    IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0 v4Statistics;
    IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0 v6Statistics;
    uint[97] errorFrequencyTable;
    uint     mainModeNegotiationTime;
    uint     quickModeNegotiationTime;
    uint     extendedModeNegotiationTime;
}

struct IKEEXT_KEYMODULE_STATISTICS1
{
    IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1 v4Statistics;
    IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1 v6Statistics;
    uint[97] errorFrequencyTable;
    uint     mainModeNegotiationTime;
    uint     quickModeNegotiationTime;
    uint     extendedModeNegotiationTime;
}

struct IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0
{
    uint totalSocketReceiveFailures;
    uint totalSocketSendFailures;
}

struct IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1
{
    uint totalSocketReceiveFailures;
    uint totalSocketSendFailures;
}

struct IKEEXT_COMMON_STATISTICS0
{
    IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0 v4Statistics;
    IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0 v6Statistics;
    uint totalPacketsReceived;
    uint totalInvalidPacketsReceived;
    uint currentQueuedWorkitems;
}

struct IKEEXT_COMMON_STATISTICS1
{
    IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1 v4Statistics;
    IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1 v6Statistics;
    uint totalPacketsReceived;
    uint totalInvalidPacketsReceived;
    uint currentQueuedWorkitems;
}

struct IKEEXT_STATISTICS0
{
    IKEEXT_KEYMODULE_STATISTICS0 ikeStatistics;
    IKEEXT_KEYMODULE_STATISTICS0 authipStatistics;
    IKEEXT_COMMON_STATISTICS0 commonStatistics;
}

struct IKEEXT_STATISTICS1
{
    IKEEXT_KEYMODULE_STATISTICS1 ikeStatistics;
    IKEEXT_KEYMODULE_STATISTICS1 authipStatistics;
    IKEEXT_KEYMODULE_STATISTICS1 ikeV2Statistics;
    IKEEXT_COMMON_STATISTICS1 commonStatistics;
}

struct IKEEXT_TRAFFIC0
{
    FWP_IP_VERSION ipVersion;
    union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
    union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    ulong          authIpFilterId;
}

struct IKEEXT_COOKIE_PAIR0
{
    ulong initiator;
    ulong responder;
}

struct IKEEXT_CERTIFICATE_CREDENTIAL0
{
    FWP_BYTE_BLOB subjectName;
    FWP_BYTE_BLOB certHash;
    uint          flags;
}

struct IKEEXT_NAME_CREDENTIAL0
{
    ushort* principalName;
}

struct IKEEXT_CREDENTIAL0
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE impersonationType;
    union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION0* presharedKey;
        IKEEXT_CERTIFICATE_CREDENTIAL0* certificate;
        IKEEXT_NAME_CREDENTIAL0* name;
    }
}

struct IKEEXT_CREDENTIAL_PAIR0
{
    IKEEXT_CREDENTIAL0 localCredentials;
    IKEEXT_CREDENTIAL0 peerCredentials;
}

struct IKEEXT_CREDENTIALS0
{
    uint numCredentials;
    IKEEXT_CREDENTIAL_PAIR0* credentials;
}

struct IKEEXT_SA_DETAILS0
{
    ulong               saId;
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    FWP_IP_VERSION      ipVersion;
    union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* v4UdpEncapsulation;
    }
    IKEEXT_TRAFFIC0     ikeTraffic;
    IKEEXT_PROPOSAL0    ikeProposal;
    IKEEXT_COOKIE_PAIR0 cookiePair;
    IKEEXT_CREDENTIALS0 ikeCredentials;
    GUID                ikePolicyKey;
    ulong               virtualIfTunnelId;
}

struct IKEEXT_CERTIFICATE_CREDENTIAL1
{
    FWP_BYTE_BLOB subjectName;
    FWP_BYTE_BLOB certHash;
    uint          flags;
    FWP_BYTE_BLOB certificate;
}

struct IKEEXT_CREDENTIAL1
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE impersonationType;
    union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION1* presharedKey;
        IKEEXT_CERTIFICATE_CREDENTIAL1* certificate;
        IKEEXT_NAME_CREDENTIAL0* name;
    }
}

struct IKEEXT_CREDENTIAL_PAIR1
{
    IKEEXT_CREDENTIAL1 localCredentials;
    IKEEXT_CREDENTIAL1 peerCredentials;
}

struct IKEEXT_CREDENTIALS1
{
    uint numCredentials;
    IKEEXT_CREDENTIAL_PAIR1* credentials;
}

struct IKEEXT_SA_DETAILS1
{
    ulong               saId;
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    FWP_IP_VERSION      ipVersion;
    union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* v4UdpEncapsulation;
    }
    IKEEXT_TRAFFIC0     ikeTraffic;
    IKEEXT_PROPOSAL0    ikeProposal;
    IKEEXT_COOKIE_PAIR0 cookiePair;
    IKEEXT_CREDENTIALS1 ikeCredentials;
    GUID                ikePolicyKey;
    ulong               virtualIfTunnelId;
    FWP_BYTE_BLOB       correlationKey;
}

struct IKEEXT_CREDENTIAL2
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE impersonationType;
    union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION1* presharedKey;
        IKEEXT_CERTIFICATE_CREDENTIAL1* certificate;
        IKEEXT_NAME_CREDENTIAL0* name;
    }
}

struct IKEEXT_CREDENTIAL_PAIR2
{
    IKEEXT_CREDENTIAL2 localCredentials;
    IKEEXT_CREDENTIAL2 peerCredentials;
}

struct IKEEXT_CREDENTIALS2
{
    uint numCredentials;
    IKEEXT_CREDENTIAL_PAIR2* credentials;
}

struct IKEEXT_SA_DETAILS2
{
    ulong               saId;
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    FWP_IP_VERSION      ipVersion;
    union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* v4UdpEncapsulation;
    }
    IKEEXT_TRAFFIC0     ikeTraffic;
    IKEEXT_PROPOSAL0    ikeProposal;
    IKEEXT_COOKIE_PAIR0 cookiePair;
    IKEEXT_CREDENTIALS2 ikeCredentials;
    GUID                ikePolicyKey;
    ulong               virtualIfTunnelId;
    FWP_BYTE_BLOB       correlationKey;
}

struct IKEEXT_SA_ENUM_TEMPLATE0
{
    FWP_CONDITION_VALUE0 localSubNet;
    FWP_CONDITION_VALUE0 remoteSubNet;
    FWP_BYTE_BLOB        localMainModeCertHash;
}

struct IPSEC_SA_LIFETIME0
{
    uint lifetimeSeconds;
    uint lifetimeKilobytes;
    uint lifetimePackets;
}

struct IPSEC_AUTH_TRANSFORM_ID0
{
    IPSEC_AUTH_TYPE authType;
    ubyte           authConfig;
}

struct IPSEC_AUTH_TRANSFORM0
{
    IPSEC_AUTH_TRANSFORM_ID0 authTransformId;
    GUID* cryptoModuleId;
}

struct IPSEC_CIPHER_TRANSFORM_ID0
{
    IPSEC_CIPHER_TYPE cipherType;
    ubyte             cipherConfig;
}

struct IPSEC_CIPHER_TRANSFORM0
{
    IPSEC_CIPHER_TRANSFORM_ID0 cipherTransformId;
    GUID* cryptoModuleId;
}

struct IPSEC_AUTH_AND_CIPHER_TRANSFORM0
{
    IPSEC_AUTH_TRANSFORM0 authTransform;
    IPSEC_CIPHER_TRANSFORM0 cipherTransform;
}

struct IPSEC_SA_TRANSFORM0
{
    IPSEC_TRANSFORM_TYPE ipsecTransformType;
    union
    {
        IPSEC_AUTH_TRANSFORM0* ahTransform;
        IPSEC_AUTH_TRANSFORM0* espAuthTransform;
        IPSEC_CIPHER_TRANSFORM0* espCipherTransform;
        IPSEC_AUTH_AND_CIPHER_TRANSFORM0* espAuthAndCipherTransform;
        IPSEC_AUTH_TRANSFORM0* espAuthFwTransform;
    }
}

struct IPSEC_PROPOSAL0
{
    IPSEC_SA_LIFETIME0   lifetime;
    uint                 numSaTransforms;
    IPSEC_SA_TRANSFORM0* saTransforms;
    IPSEC_PFS_GROUP      pfsGroup;
}

struct IPSEC_SA_IDLE_TIMEOUT0
{
    uint idleTimeoutSeconds;
    uint idleTimeoutSecondsFailOver;
}

struct IPSEC_TRAFFIC_SELECTOR0_
{
    ubyte          protocolId;
    ushort         portStart;
    ushort         portEnd;
    FWP_IP_VERSION ipVersion;
    union
    {
        uint      startV4Address;
        ubyte[16] startV6Address;
    }
    union
    {
        uint      endV4Address;
        ubyte[16] endV6Address;
    }
}

struct IPSEC_TRAFFIC_SELECTOR_POLICY0_
{
    uint flags;
    uint numLocalTrafficSelectors;
    IPSEC_TRAFFIC_SELECTOR0_* localTrafficSelectors;
    uint numRemoteTrafficSelectors;
    IPSEC_TRAFFIC_SELECTOR0_* remoteTrafficSelectors;
}

struct IPSEC_TRANSPORT_POLICY0
{
    uint               numIpsecProposals;
    IPSEC_PROPOSAL0*   ipsecProposals;
    uint               flags;
    uint               ndAllowClearTimeoutSeconds;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY0* emPolicy;
}

struct IPSEC_TRANSPORT_POLICY1
{
    uint               numIpsecProposals;
    IPSEC_PROPOSAL0*   ipsecProposals;
    uint               flags;
    uint               ndAllowClearTimeoutSeconds;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY1* emPolicy;
}

struct IPSEC_TRANSPORT_POLICY2
{
    uint               numIpsecProposals;
    IPSEC_PROPOSAL0*   ipsecProposals;
    uint               flags;
    uint               ndAllowClearTimeoutSeconds;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY2* emPolicy;
}

struct IPSEC_TUNNEL_ENDPOINTS0
{
    FWP_IP_VERSION ipVersion;
    union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
    union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
}

struct IPSEC_TUNNEL_ENDPOINT0
{
    FWP_IP_VERSION ipVersion;
    union
    {
        uint      v4Address;
        ubyte[16] v6Address;
    }
}

struct IPSEC_TUNNEL_ENDPOINTS2
{
    FWP_IP_VERSION ipVersion;
    union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
    union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    ulong          localIfLuid;
    ushort*        remoteFqdn;
    uint           numAddresses;
    IPSEC_TUNNEL_ENDPOINT0* remoteAddresses;
}

struct IPSEC_TUNNEL_ENDPOINTS1
{
    FWP_IP_VERSION ipVersion;
    union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
    union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    ulong          localIfLuid;
}

struct IPSEC_TUNNEL_POLICY0
{
    uint               flags;
    uint               numIpsecProposals;
    IPSEC_PROPOSAL0*   ipsecProposals;
    IPSEC_TUNNEL_ENDPOINTS0 tunnelEndpoints;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY0* emPolicy;
}

struct IPSEC_TUNNEL_POLICY1
{
    uint               flags;
    uint               numIpsecProposals;
    IPSEC_PROPOSAL0*   ipsecProposals;
    IPSEC_TUNNEL_ENDPOINTS1 tunnelEndpoints;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY1* emPolicy;
}

struct IPSEC_TUNNEL_POLICY2
{
    uint               flags;
    uint               numIpsecProposals;
    IPSEC_PROPOSAL0*   ipsecProposals;
    IPSEC_TUNNEL_ENDPOINTS2 tunnelEndpoints;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY2* emPolicy;
    uint               fwdPathSaLifetime;
}

struct IPSEC_TUNNEL_POLICY3_
{
    uint               flags;
    uint               numIpsecProposals;
    IPSEC_PROPOSAL0*   ipsecProposals;
    IPSEC_TUNNEL_ENDPOINTS2 tunnelEndpoints;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY2* emPolicy;
    uint               fwdPathSaLifetime;
    uint               compartmentId;
    uint               numTrafficSelectorPolicy;
    IPSEC_TRAFFIC_SELECTOR_POLICY0_* trafficSelectorPolicies;
}

struct IPSEC_KEYING_POLICY0
{
    uint  numKeyMods;
    GUID* keyModKeys;
}

struct IPSEC_KEYING_POLICY1
{
    uint  numKeyMods;
    GUID* keyModKeys;
    uint  flags;
}

struct IPSEC_AGGREGATE_SA_STATISTICS0
{
    uint activeSas;
    uint pendingSaNegotiations;
    uint totalSasAdded;
    uint totalSasDeleted;
    uint successfulRekeys;
    uint activeTunnels;
    uint offloadedSas;
}

struct IPSEC_ESP_DROP_PACKET_STATISTICS0
{
    uint invalidSpisOnInbound;
    uint decryptionFailuresOnInbound;
    uint authenticationFailuresOnInbound;
    uint replayCheckFailuresOnInbound;
    uint saNotInitializedOnInbound;
}

struct IPSEC_AH_DROP_PACKET_STATISTICS0
{
    uint invalidSpisOnInbound;
    uint authenticationFailuresOnInbound;
    uint replayCheckFailuresOnInbound;
    uint saNotInitializedOnInbound;
}

struct IPSEC_AGGREGATE_DROP_PACKET_STATISTICS0
{
    uint invalidSpisOnInbound;
    uint decryptionFailuresOnInbound;
    uint authenticationFailuresOnInbound;
    uint udpEspValidationFailuresOnInbound;
    uint replayCheckFailuresOnInbound;
    uint invalidClearTextInbound;
    uint saNotInitializedOnInbound;
    uint receiveOverIncorrectSaInbound;
    uint secureReceivesNotMatchingFilters;
}

struct IPSEC_AGGREGATE_DROP_PACKET_STATISTICS1
{
    uint invalidSpisOnInbound;
    uint decryptionFailuresOnInbound;
    uint authenticationFailuresOnInbound;
    uint udpEspValidationFailuresOnInbound;
    uint replayCheckFailuresOnInbound;
    uint invalidClearTextInbound;
    uint saNotInitializedOnInbound;
    uint receiveOverIncorrectSaInbound;
    uint secureReceivesNotMatchingFilters;
    uint totalDropPacketsInbound;
}

struct IPSEC_TRAFFIC_STATISTICS0
{
    ulong encryptedByteCount;
    ulong authenticatedAHByteCount;
    ulong authenticatedESPByteCount;
    ulong transportByteCount;
    ulong tunnelByteCount;
    ulong offloadByteCount;
}

struct IPSEC_TRAFFIC_STATISTICS1
{
    ulong encryptedByteCount;
    ulong authenticatedAHByteCount;
    ulong authenticatedESPByteCount;
    ulong transportByteCount;
    ulong tunnelByteCount;
    ulong offloadByteCount;
    ulong totalSuccessfulPackets;
}

struct IPSEC_STATISTICS0
{
    IPSEC_AGGREGATE_SA_STATISTICS0 aggregateSaStatistics;
    IPSEC_ESP_DROP_PACKET_STATISTICS0 espDropPacketStatistics;
    IPSEC_AH_DROP_PACKET_STATISTICS0 ahDropPacketStatistics;
    IPSEC_AGGREGATE_DROP_PACKET_STATISTICS0 aggregateDropPacketStatistics;
    IPSEC_TRAFFIC_STATISTICS0 inboundTrafficStatistics;
    IPSEC_TRAFFIC_STATISTICS0 outboundTrafficStatistics;
}

struct IPSEC_STATISTICS1
{
    IPSEC_AGGREGATE_SA_STATISTICS0 aggregateSaStatistics;
    IPSEC_ESP_DROP_PACKET_STATISTICS0 espDropPacketStatistics;
    IPSEC_AH_DROP_PACKET_STATISTICS0 ahDropPacketStatistics;
    IPSEC_AGGREGATE_DROP_PACKET_STATISTICS1 aggregateDropPacketStatistics;
    IPSEC_TRAFFIC_STATISTICS1 inboundTrafficStatistics;
    IPSEC_TRAFFIC_STATISTICS1 outboundTrafficStatistics;
}

struct IPSEC_SA_AUTH_INFORMATION0
{
    IPSEC_AUTH_TRANSFORM0 authTransform;
    FWP_BYTE_BLOB authKey;
}

struct IPSEC_SA_CIPHER_INFORMATION0
{
    IPSEC_CIPHER_TRANSFORM0 cipherTransform;
    FWP_BYTE_BLOB cipherKey;
}

struct IPSEC_SA_AUTH_AND_CIPHER_INFORMATION0
{
    IPSEC_SA_CIPHER_INFORMATION0 saCipherInformation;
    IPSEC_SA_AUTH_INFORMATION0 saAuthInformation;
}

struct IPSEC_SA0
{
    uint                 spi;
    IPSEC_TRANSFORM_TYPE saTransformType;
    union
    {
        IPSEC_SA_AUTH_INFORMATION0* ahInformation;
        IPSEC_SA_AUTH_INFORMATION0* espAuthInformation;
        IPSEC_SA_CIPHER_INFORMATION0* espCipherInformation;
        IPSEC_SA_AUTH_AND_CIPHER_INFORMATION0* espAuthAndCipherInformation;
        IPSEC_SA_AUTH_INFORMATION0* espAuthFwInformation;
    }
}

struct IPSEC_KEYMODULE_STATE0
{
    GUID          keyModuleKey;
    FWP_BYTE_BLOB stateBlob;
}

struct IPSEC_TOKEN0
{
    IPSEC_TOKEN_TYPE type;
    IPSEC_TOKEN_PRINCIPAL principal;
    IPSEC_TOKEN_MODE mode;
    ulong            token;
}

struct IPSEC_ID0
{
    ushort*       mmTargetName;
    ushort*       emTargetName;
    uint          numTokens;
    IPSEC_TOKEN0* tokens;
    ulong         explicitCredentials;
    ulong         logonId;
}

struct IPSEC_SA_BUNDLE0
{
    uint               flags;
    IPSEC_SA_LIFETIME0 lifetime;
    uint               idleTimeoutSeconds;
    uint               ndAllowClearTimeoutSeconds;
    IPSEC_ID0*         ipsecId;
    uint               napContext;
    uint               qmSaId;
    uint               numSAs;
    IPSEC_SA0*         saList;
    IPSEC_KEYMODULE_STATE0* keyModuleState;
    FWP_IP_VERSION     ipVersion;
    union
    {
        uint peerV4PrivateAddress;
    }
    ulong              mmSaId;
    IPSEC_PFS_GROUP    pfsGroup;
}

struct IPSEC_SA_BUNDLE1
{
    uint               flags;
    IPSEC_SA_LIFETIME0 lifetime;
    uint               idleTimeoutSeconds;
    uint               ndAllowClearTimeoutSeconds;
    IPSEC_ID0*         ipsecId;
    uint               napContext;
    uint               qmSaId;
    uint               numSAs;
    IPSEC_SA0*         saList;
    IPSEC_KEYMODULE_STATE0* keyModuleState;
    FWP_IP_VERSION     ipVersion;
    union
    {
        uint peerV4PrivateAddress;
    }
    ulong              mmSaId;
    IPSEC_PFS_GROUP    pfsGroup;
    GUID               saLookupContext;
    ulong              qmFilterId;
}

struct IPSEC_TRAFFIC0
{
    FWP_IP_VERSION     ipVersion;
    union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
    union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    IPSEC_TRAFFIC_TYPE trafficType;
    union
    {
        ulong ipsecFilterId;
        ulong tunnelPolicyId;
    }
    ushort             remotePort;
}

struct IPSEC_TRAFFIC1
{
    FWP_IP_VERSION     ipVersion;
    union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
    union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    IPSEC_TRAFFIC_TYPE trafficType;
    union
    {
        ulong ipsecFilterId;
        ulong tunnelPolicyId;
    }
    ushort             remotePort;
    ushort             localPort;
    ubyte              ipProtocol;
    ulong              localIfLuid;
    uint               realIfProfileId;
}

struct IPSEC_V4_UDP_ENCAPSULATION0
{
    ushort localUdpEncapPort;
    ushort remoteUdpEncapPort;
}

struct IPSEC_GETSPI0
{
    IPSEC_TRAFFIC0 inboundIpsecTraffic;
    FWP_IP_VERSION ipVersion;
    union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* inboundUdpEncapsulation;
    }
    GUID*          rngCryptoModuleID;
}

struct IPSEC_GETSPI1
{
    IPSEC_TRAFFIC1 inboundIpsecTraffic;
    FWP_IP_VERSION ipVersion;
    union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* inboundUdpEncapsulation;
    }
    GUID*          rngCryptoModuleID;
}

struct IPSEC_SA_DETAILS0
{
    FWP_IP_VERSION   ipVersion;
    FWP_DIRECTION    saDirection;
    IPSEC_TRAFFIC0   traffic;
    IPSEC_SA_BUNDLE0 saBundle;
    union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* udpEncapsulation;
    }
    FWPM_FILTER0*    transportFilter;
}

struct IPSEC_SA_DETAILS1
{
    FWP_IP_VERSION   ipVersion;
    FWP_DIRECTION    saDirection;
    IPSEC_TRAFFIC1   traffic;
    IPSEC_SA_BUNDLE1 saBundle;
    union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* udpEncapsulation;
    }
    FWPM_FILTER0*    transportFilter;
    IPSEC_VIRTUAL_IF_TUNNEL_INFO0 virtualIfTunnelInfo;
}

struct IPSEC_SA_CONTEXT0
{
    ulong              saContextId;
    IPSEC_SA_DETAILS0* inboundSa;
    IPSEC_SA_DETAILS0* outboundSa;
}

struct IPSEC_SA_CONTEXT1
{
    ulong              saContextId;
    IPSEC_SA_DETAILS1* inboundSa;
    IPSEC_SA_DETAILS1* outboundSa;
}

struct IPSEC_SA_CONTEXT_ENUM_TEMPLATE0
{
    FWP_CONDITION_VALUE0 localSubNet;
    FWP_CONDITION_VALUE0 remoteSubNet;
}

struct IPSEC_SA_ENUM_TEMPLATE0
{
    FWP_DIRECTION saDirection;
}

struct IPSEC_SA_CONTEXT_SUBSCRIPTION0
{
    IPSEC_SA_CONTEXT_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    GUID sessionKey;
}

struct IPSEC_SA_CONTEXT_CHANGE0
{
    IPSEC_SA_CONTEXT_EVENT_TYPE0 changeType;
    ulong saContextId;
}

struct IPSEC_ADDRESS_INFO0
{
    uint              numV4Addresses;
    uint*             v4Addresses;
    uint              numV6Addresses;
    FWP_BYTE_ARRAY16* v6Addresses;
}

struct IPSEC_DOSP_OPTIONS0
{
    uint                 stateIdleTimeoutSeconds;
    uint                 perIPRateLimitQueueIdleTimeoutSeconds;
    ubyte                ipV6IPsecUnauthDscp;
    uint                 ipV6IPsecUnauthRateLimitBytesPerSec;
    uint                 ipV6IPsecUnauthPerIPRateLimitBytesPerSec;
    ubyte                ipV6IPsecAuthDscp;
    uint                 ipV6IPsecAuthRateLimitBytesPerSec;
    ubyte                icmpV6Dscp;
    uint                 icmpV6RateLimitBytesPerSec;
    ubyte                ipV6FilterExemptDscp;
    uint                 ipV6FilterExemptRateLimitBytesPerSec;
    ubyte                defBlockExemptDscp;
    uint                 defBlockExemptRateLimitBytesPerSec;
    uint                 maxStateEntries;
    uint                 maxPerIPRateLimitQueues;
    uint                 flags;
    uint                 numPublicIFLuids;
    ulong*               publicIFLuids;
    uint                 numInternalIFLuids;
    ulong*               internalIFLuids;
    FWP_V6_ADDR_AND_MASK publicV6AddrMask;
    FWP_V6_ADDR_AND_MASK internalV6AddrMask;
}

struct IPSEC_DOSP_STATISTICS0
{
    ulong totalStateEntriesCreated;
    ulong currentStateEntries;
    ulong totalInboundAllowedIPv6IPsecUnauthPkts;
    ulong totalInboundRatelimitDiscardedIPv6IPsecUnauthPkts;
    ulong totalInboundPerIPRatelimitDiscardedIPv6IPsecUnauthPkts;
    ulong totalInboundOtherDiscardedIPv6IPsecUnauthPkts;
    ulong totalInboundAllowedIPv6IPsecAuthPkts;
    ulong totalInboundRatelimitDiscardedIPv6IPsecAuthPkts;
    ulong totalInboundOtherDiscardedIPv6IPsecAuthPkts;
    ulong totalInboundAllowedICMPv6Pkts;
    ulong totalInboundRatelimitDiscardedICMPv6Pkts;
    ulong totalInboundAllowedIPv6FilterExemptPkts;
    ulong totalInboundRatelimitDiscardedIPv6FilterExemptPkts;
    ulong totalInboundDiscardedIPv6FilterBlockPkts;
    ulong totalInboundAllowedDefBlockExemptPkts;
    ulong totalInboundRatelimitDiscardedDefBlockExemptPkts;
    ulong totalInboundDiscardedDefBlockPkts;
    ulong currentInboundIPv6IPsecUnauthPerIPRateLimitQueues;
}

struct IPSEC_DOSP_STATE0
{
    ubyte[16] publicHostV6Addr;
    ubyte[16] internalHostV6Addr;
    ulong     totalInboundIPv6IPsecAuthPackets;
    ulong     totalOutboundIPv6IPsecAuthPackets;
    uint      durationSecs;
}

struct IPSEC_DOSP_STATE_ENUM_TEMPLATE0
{
    FWP_V6_ADDR_AND_MASK publicV6AddrMask;
    FWP_V6_ADDR_AND_MASK internalV6AddrMask;
}

struct IPSEC_KEY_MANAGER0
{
    GUID               keyManagerKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    ubyte              keyDictationTimeoutHint;
}

struct FWPM_SESSION0
{
    GUID               sessionKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    uint               txnWaitTimeoutInMSec;
    uint               processId;
    SID*               sid;
    ushort*            username;
    BOOL               kernelMode;
}

struct FWPM_SESSION_ENUM_TEMPLATE0
{
    ulong reserved;
}

struct FWPM_PROVIDER0
{
    GUID               providerKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    FWP_BYTE_BLOB      providerData;
    ushort*            serviceName;
}

struct FWPM_PROVIDER_ENUM_TEMPLATE0
{
    ulong reserved;
}

struct FWPM_PROVIDER_CHANGE0
{
    FWPM_CHANGE_TYPE changeType;
    GUID             providerKey;
}

struct FWPM_PROVIDER_SUBSCRIPTION0
{
    FWPM_PROVIDER_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    GUID sessionKey;
}

struct FWPM_CLASSIFY_OPTION0
{
    FWP_CLASSIFY_OPTION_TYPE type;
    FWP_VALUE0 value;
}

struct FWPM_CLASSIFY_OPTIONS0
{
    uint numOptions;
    FWPM_CLASSIFY_OPTION0* options;
}

struct FWPM_PROVIDER_CONTEXT0
{
    GUID               providerContextKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    GUID*              providerKey;
    FWP_BYTE_BLOB      providerData;
    FWPM_PROVIDER_CONTEXT_TYPE type;
    union
    {
        IPSEC_KEYING_POLICY0* keyingPolicy;
        IPSEC_TRANSPORT_POLICY0* ikeQmTransportPolicy;
        IPSEC_TUNNEL_POLICY0* ikeQmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY0* authipQmTransportPolicy;
        IPSEC_TUNNEL_POLICY0* authipQmTunnelPolicy;
        IKEEXT_POLICY0* ikeMmPolicy;
        IKEEXT_POLICY0* authIpMmPolicy;
        FWP_BYTE_BLOB*  dataBuffer;
        FWPM_CLASSIFY_OPTIONS0* classifyOptions;
    }
    ulong              providerContextId;
}

struct FWPM_PROVIDER_CONTEXT1
{
    GUID               providerContextKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    GUID*              providerKey;
    FWP_BYTE_BLOB      providerData;
    FWPM_PROVIDER_CONTEXT_TYPE type;
    union
    {
        IPSEC_KEYING_POLICY0* keyingPolicy;
        IPSEC_TRANSPORT_POLICY1* ikeQmTransportPolicy;
        IPSEC_TUNNEL_POLICY1* ikeQmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY1* authipQmTransportPolicy;
        IPSEC_TUNNEL_POLICY1* authipQmTunnelPolicy;
        IKEEXT_POLICY1*      ikeMmPolicy;
        IKEEXT_POLICY1*      authIpMmPolicy;
        FWP_BYTE_BLOB*       dataBuffer;
        FWPM_CLASSIFY_OPTIONS0* classifyOptions;
        IPSEC_TUNNEL_POLICY1* ikeV2QmTunnelPolicy;
        IKEEXT_POLICY1*      ikeV2MmPolicy;
        IPSEC_DOSP_OPTIONS0* idpOptions;
    }
    ulong              providerContextId;
}

struct FWPM_PROVIDER_CONTEXT2
{
    GUID               providerContextKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    GUID*              providerKey;
    FWP_BYTE_BLOB      providerData;
    FWPM_PROVIDER_CONTEXT_TYPE type;
    union
    {
        IPSEC_KEYING_POLICY1* keyingPolicy;
        IPSEC_TRANSPORT_POLICY2* ikeQmTransportPolicy;
        IPSEC_TUNNEL_POLICY2* ikeQmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY2* authipQmTransportPolicy;
        IPSEC_TUNNEL_POLICY2* authipQmTunnelPolicy;
        IKEEXT_POLICY2*      ikeMmPolicy;
        IKEEXT_POLICY2*      authIpMmPolicy;
        FWP_BYTE_BLOB*       dataBuffer;
        FWPM_CLASSIFY_OPTIONS0* classifyOptions;
        IPSEC_TUNNEL_POLICY2* ikeV2QmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY2* ikeV2QmTransportPolicy;
        IKEEXT_POLICY2*      ikeV2MmPolicy;
        IPSEC_DOSP_OPTIONS0* idpOptions;
    }
    ulong              providerContextId;
}

struct FWPM_PROVIDER_CONTEXT3_
{
    GUID               providerContextKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    GUID*              providerKey;
    FWP_BYTE_BLOB      providerData;
    FWPM_PROVIDER_CONTEXT_TYPE type;
    union
    {
        IPSEC_KEYING_POLICY1* keyingPolicy;
        IPSEC_TRANSPORT_POLICY2* ikeQmTransportPolicy;
        IPSEC_TUNNEL_POLICY3_* ikeQmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY2* authipQmTransportPolicy;
        IPSEC_TUNNEL_POLICY3_* authipQmTunnelPolicy;
        IKEEXT_POLICY2*      ikeMmPolicy;
        IKEEXT_POLICY2*      authIpMmPolicy;
        FWP_BYTE_BLOB*       dataBuffer;
        FWPM_CLASSIFY_OPTIONS0* classifyOptions;
        IPSEC_TUNNEL_POLICY3_* ikeV2QmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY2* ikeV2QmTransportPolicy;
        IKEEXT_POLICY2*      ikeV2MmPolicy;
        IPSEC_DOSP_OPTIONS0* idpOptions;
    }
    ulong              providerContextId;
}

struct FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0
{
    GUID* providerKey;
    FWPM_PROVIDER_CONTEXT_TYPE providerContextType;
}

struct FWPM_PROVIDER_CONTEXT_CHANGE0
{
    FWPM_CHANGE_TYPE changeType;
    GUID             providerContextKey;
    ulong            providerContextId;
}

struct FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0
{
    FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    GUID sessionKey;
}

struct FWPM_SUBLAYER0
{
    GUID               subLayerKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    GUID*              providerKey;
    FWP_BYTE_BLOB      providerData;
    ushort             weight;
}

struct FWPM_SUBLAYER_ENUM_TEMPLATE0
{
    GUID* providerKey;
}

struct FWPM_SUBLAYER_CHANGE0
{
    FWPM_CHANGE_TYPE changeType;
    GUID             subLayerKey;
}

struct FWPM_SUBLAYER_SUBSCRIPTION0
{
    FWPM_SUBLAYER_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    GUID sessionKey;
}

struct FWPM_FIELD0
{
    GUID*           fieldKey;
    FWPM_FIELD_TYPE type;
    FWP_DATA_TYPE   dataType;
}

struct FWPM_LAYER0
{
    GUID               layerKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    uint               numFields;
    FWPM_FIELD0*       field;
    GUID               defaultSubLayerKey;
    ushort             layerId;
}

struct FWPM_LAYER_ENUM_TEMPLATE0
{
    ulong reserved;
}

struct FWPM_CALLOUT0
{
    GUID               calloutKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    GUID*              providerKey;
    FWP_BYTE_BLOB      providerData;
    GUID               applicableLayer;
    uint               calloutId;
}

struct FWPM_CALLOUT_ENUM_TEMPLATE0
{
    GUID* providerKey;
    GUID  layerKey;
}

struct FWPM_CALLOUT_CHANGE0
{
    FWPM_CHANGE_TYPE changeType;
    GUID             calloutKey;
    uint             calloutId;
}

struct FWPM_CALLOUT_SUBSCRIPTION0
{
    FWPM_CALLOUT_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    GUID sessionKey;
}

struct FWPM_ACTION0
{
    uint type;
    union
    {
        GUID  filterType;
        GUID  calloutKey;
        ubyte bitmapIndex;
    }
}

struct FWPM_FILTER_CONDITION0
{
    GUID                 fieldKey;
    FWP_MATCH_TYPE       matchType;
    FWP_CONDITION_VALUE0 conditionValue;
}

struct FWPM_FILTER0
{
    GUID               filterKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    GUID*              providerKey;
    FWP_BYTE_BLOB      providerData;
    GUID               layerKey;
    GUID               subLayerKey;
    FWP_VALUE0         weight;
    uint               numFilterConditions;
    FWPM_FILTER_CONDITION0* filterCondition;
    FWPM_ACTION0       action;
    union
    {
        ulong rawContext;
        GUID  providerContextKey;
    }
    GUID*              reserved;
    ulong              filterId;
    FWP_VALUE0         effectiveWeight;
}

struct FWPM_FILTER_ENUM_TEMPLATE0
{
    GUID*                providerKey;
    GUID                 layerKey;
    FWP_FILTER_ENUM_TYPE enumType;
    uint                 flags;
    FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0* providerContextTemplate;
    uint                 numFilterConditions;
    FWPM_FILTER_CONDITION0* filterCondition;
    uint                 actionMask;
    GUID*                calloutKey;
}

struct FWPM_FILTER_CHANGE0
{
    FWPM_CHANGE_TYPE changeType;
    GUID             filterKey;
    ulong            filterId;
}

struct FWPM_FILTER_SUBSCRIPTION0
{
    FWPM_FILTER_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    GUID sessionKey;
}

struct FWPM_LAYER_STATISTICS0
{
    GUID layerId;
    uint classifyPermitCount;
    uint classifyBlockCount;
    uint classifyVetoCount;
    uint numCacheEntries;
}

struct FWPM_STATISTICS0
{
    uint  numLayerStatistics;
    FWPM_LAYER_STATISTICS0* layerStatistics;
    uint  inboundAllowedConnectionsV4;
    uint  inboundBlockedConnectionsV4;
    uint  outboundAllowedConnectionsV4;
    uint  outboundBlockedConnectionsV4;
    uint  inboundAllowedConnectionsV6;
    uint  inboundBlockedConnectionsV6;
    uint  outboundAllowedConnectionsV6;
    uint  outboundBlockedConnectionsV6;
    uint  inboundActiveConnectionsV4;
    uint  outboundActiveConnectionsV4;
    uint  inboundActiveConnectionsV6;
    uint  outboundActiveConnectionsV6;
    ulong reauthDirInbound;
    ulong reauthDirOutbound;
    ulong reauthFamilyV4;
    ulong reauthFamilyV6;
    ulong reauthProtoOther;
    ulong reauthProtoIPv4;
    ulong reauthProtoIPv6;
    ulong reauthProtoICMP;
    ulong reauthProtoICMP6;
    ulong reauthProtoUDP;
    ulong reauthProtoTCP;
    ulong reauthReasonPolicyChange;
    ulong reauthReasonNewArrivalInterface;
    ulong reauthReasonNewNextHopInterface;
    ulong reauthReasonProfileCrossing;
    ulong reauthReasonClassifyCompletion;
    ulong reauthReasonIPSecPropertiesChanged;
    ulong reauthReasonMidStreamInspection;
    ulong reauthReasonSocketPropertyChanged;
    ulong reauthReasonNewInboundMCastBCastPacket;
    ulong reauthReasonEDPPolicyChanged;
    ulong reauthReasonPreclassifyLocalAddrLayerChange;
    ulong reauthReasonPreclassifyRemoteAddrLayerChange;
    ulong reauthReasonPreclassifyLocalPortLayerChange;
    ulong reauthReasonPreclassifyRemotePortLayerChange;
    ulong reauthReasonProxyHandleChanged;
}

struct FWPM_NET_EVENT_HEADER0
{
    FILETIME       timeStamp;
    uint           flags;
    FWP_IP_VERSION ipVersion;
    ubyte          ipProtocol;
    union
    {
        uint             localAddrV4;
        FWP_BYTE_ARRAY16 localAddrV6;
    }
    union
    {
        uint             remoteAddrV4;
        FWP_BYTE_ARRAY16 remoteAddrV6;
    }
    ushort         localPort;
    ushort         remotePort;
    uint           scopeId;
    FWP_BYTE_BLOB  appId;
    SID*           userId;
}

struct FWPM_NET_EVENT_HEADER1
{
    FILETIME       timeStamp;
    uint           flags;
    FWP_IP_VERSION ipVersion;
    ubyte          ipProtocol;
    union
    {
        uint             localAddrV4;
        FWP_BYTE_ARRAY16 localAddrV6;
    }
    union
    {
        uint             remoteAddrV4;
        FWP_BYTE_ARRAY16 remoteAddrV6;
    }
    ushort         localPort;
    ushort         remotePort;
    uint           scopeId;
    FWP_BYTE_BLOB  appId;
    SID*           userId;
    union
    {
        struct
        {
            FWP_AF reserved1;
            union
            {
                struct
                {
                    FWP_BYTE_ARRAY6 reserved2;
                    FWP_BYTE_ARRAY6 reserved3;
                    uint            reserved4;
                    uint            reserved5;
                    ushort          reserved6;
                    uint            reserved7;
                    uint            reserved8;
                    ushort          reserved9;
                    ulong           reserved10;
                }
            }
        }
    }
}

struct FWPM_NET_EVENT_HEADER2
{
    FILETIME       timeStamp;
    uint           flags;
    FWP_IP_VERSION ipVersion;
    ubyte          ipProtocol;
    union
    {
        uint             localAddrV4;
        FWP_BYTE_ARRAY16 localAddrV6;
    }
    union
    {
        uint             remoteAddrV4;
        FWP_BYTE_ARRAY16 remoteAddrV6;
    }
    ushort         localPort;
    ushort         remotePort;
    uint           scopeId;
    FWP_BYTE_BLOB  appId;
    SID*           userId;
    FWP_AF         addressFamily;
    SID*           packageSid;
}

struct FWPM_NET_EVENT_HEADER3
{
    FILETIME       timeStamp;
    uint           flags;
    FWP_IP_VERSION ipVersion;
    ubyte          ipProtocol;
    union
    {
        uint             localAddrV4;
        FWP_BYTE_ARRAY16 localAddrV6;
    }
    union
    {
        uint             remoteAddrV4;
        FWP_BYTE_ARRAY16 remoteAddrV6;
    }
    ushort         localPort;
    ushort         remotePort;
    uint           scopeId;
    FWP_BYTE_BLOB  appId;
    SID*           userId;
    FWP_AF         addressFamily;
    SID*           packageSid;
    ushort*        enterpriseId;
    ulong          policyFlags;
    FWP_BYTE_BLOB  effectiveName;
}

struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE0
{
    uint                failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint                flags;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_MM_SA_STATE  mmState;
    IKEEXT_SA_ROLE      saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE mmAuthMethod;
    ubyte[20]           endCertHash;
    ulong               mmId;
    ulong               mmFilterId;
}

struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE1
{
    uint                failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint                flags;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_MM_SA_STATE  mmState;
    IKEEXT_SA_ROLE      saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE mmAuthMethod;
    ubyte[20]           endCertHash;
    ulong               mmId;
    ulong               mmFilterId;
    ushort*             localPrincipalNameForAuth;
    ushort*             remotePrincipalNameForAuth;
    uint                numLocalPrincipalGroupSids;
    ushort**            localPrincipalGroupSids;
    uint                numRemotePrincipalGroupSids;
    ushort**            remotePrincipalGroupSids;
}

struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE2_
{
    uint                failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint                flags;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_MM_SA_STATE  mmState;
    IKEEXT_SA_ROLE      saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE mmAuthMethod;
    ubyte[20]           endCertHash;
    ulong               mmId;
    ulong               mmFilterId;
    ushort*             localPrincipalNameForAuth;
    ushort*             remotePrincipalNameForAuth;
    uint                numLocalPrincipalGroupSids;
    ushort**            localPrincipalGroupSids;
    uint                numRemotePrincipalGroupSids;
    ushort**            remotePrincipalGroupSids;
    GUID*               providerContextKey;
}

struct FWPM_NET_EVENT_IKEEXT_QM_FAILURE0
{
    uint                failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_QM_SA_STATE  qmState;
    IKEEXT_SA_ROLE      saRole;
    IPSEC_TRAFFIC_TYPE  saTrafficType;
    union
    {
        FWP_CONDITION_VALUE0 localSubNet;
    }
    union
    {
        FWP_CONDITION_VALUE0 remoteSubNet;
    }
    ulong               qmFilterId;
}

struct FWPM_NET_EVENT_IKEEXT_QM_FAILURE1_
{
    uint                failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_QM_SA_STATE  qmState;
    IKEEXT_SA_ROLE      saRole;
    IPSEC_TRAFFIC_TYPE  saTrafficType;
    union
    {
        FWP_CONDITION_VALUE0 localSubNet;
    }
    union
    {
        FWP_CONDITION_VALUE0 remoteSubNet;
    }
    ulong               qmFilterId;
    ulong               mmSaLuid;
    GUID                mmProviderContextKey;
}

struct FWPM_NET_EVENT_IKEEXT_EM_FAILURE0
{
    uint                failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint                flags;
    IKEEXT_EM_SA_STATE  emState;
    IKEEXT_SA_ROLE      saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE emAuthMethod;
    ubyte[20]           endCertHash;
    ulong               mmId;
    ulong               qmFilterId;
}

struct FWPM_NET_EVENT_IKEEXT_EM_FAILURE1
{
    uint                failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint                flags;
    IKEEXT_EM_SA_STATE  emState;
    IKEEXT_SA_ROLE      saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE emAuthMethod;
    ubyte[20]           endCertHash;
    ulong               mmId;
    ulong               qmFilterId;
    ushort*             localPrincipalNameForAuth;
    ushort*             remotePrincipalNameForAuth;
    uint                numLocalPrincipalGroupSids;
    ushort**            localPrincipalGroupSids;
    uint                numRemotePrincipalGroupSids;
    ushort**            remotePrincipalGroupSids;
    IPSEC_TRAFFIC_TYPE  saTrafficType;
}

struct FWPM_NET_EVENT_CLASSIFY_DROP0
{
    ulong  filterId;
    ushort layerId;
}

struct FWPM_NET_EVENT_CLASSIFY_DROP1
{
    ulong  filterId;
    ushort layerId;
    uint   reauthReason;
    uint   originalProfile;
    uint   currentProfile;
    uint   msFwpDirection;
    BOOL   isLoopback;
}

struct FWPM_NET_EVENT_CLASSIFY_DROP2
{
    ulong         filterId;
    ushort        layerId;
    uint          reauthReason;
    uint          originalProfile;
    uint          currentProfile;
    uint          msFwpDirection;
    BOOL          isLoopback;
    FWP_BYTE_BLOB vSwitchId;
    uint          vSwitchSourcePort;
    uint          vSwitchDestinationPort;
}

struct FWPM_NET_EVENT_CLASSIFY_DROP_MAC0
{
    FWP_BYTE_ARRAY6 localMacAddr;
    FWP_BYTE_ARRAY6 remoteMacAddr;
    uint            mediaType;
    uint            ifType;
    ushort          etherType;
    uint            ndisPortNumber;
    uint            reserved;
    ushort          vlanTag;
    ulong           ifLuid;
    ulong           filterId;
    ushort          layerId;
    uint            reauthReason;
    uint            originalProfile;
    uint            currentProfile;
    uint            msFwpDirection;
    BOOL            isLoopback;
    FWP_BYTE_BLOB   vSwitchId;
    uint            vSwitchSourcePort;
    uint            vSwitchDestinationPort;
}

struct FWPM_NET_EVENT_CLASSIFY_ALLOW0
{
    ulong  filterId;
    ushort layerId;
    uint   reauthReason;
    uint   originalProfile;
    uint   currentProfile;
    uint   msFwpDirection;
    BOOL   isLoopback;
}

struct FWPM_NET_EVENT_IPSEC_KERNEL_DROP0
{
    int           failureStatus;
    FWP_DIRECTION direction;
    uint          spi;
    ulong         filterId;
    ushort        layerId;
}

struct FWPM_NET_EVENT_IPSEC_DOSP_DROP0
{
    FWP_IP_VERSION ipVersion;
    union
    {
        uint      publicHostV4Addr;
        ubyte[16] publicHostV6Addr;
    }
    union
    {
        uint      internalHostV4Addr;
        ubyte[16] internalHostV6Addr;
    }
    int            failureStatus;
    FWP_DIRECTION  direction;
}

struct FWPM_NET_EVENT_CAPABILITY_DROP0
{
    FWPM_APPC_NETWORK_CAPABILITY_TYPE networkCapabilityId;
    ulong filterId;
    BOOL  isLoopback;
}

struct FWPM_NET_EVENT_CAPABILITY_ALLOW0
{
    FWPM_APPC_NETWORK_CAPABILITY_TYPE networkCapabilityId;
    ulong filterId;
    BOOL  isLoopback;
}

struct FWPM_NET_EVENT_LPM_PACKET_ARRIVAL0_
{
    uint spi;
}

struct FWPM_NET_EVENT0
{
    FWPM_NET_EVENT_HEADER0 header;
    FWPM_NET_EVENT_TYPE type;
    union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE0* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE0* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE0* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP0* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
    }
}

struct FWPM_NET_EVENT1
{
    FWPM_NET_EVENT_HEADER1 header;
    FWPM_NET_EVENT_TYPE type;
    union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE1* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE0* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE1* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP1* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
    }
}

struct FWPM_NET_EVENT2
{
    FWPM_NET_EVENT_HEADER2 header;
    FWPM_NET_EVENT_TYPE type;
    union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE1* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE0* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE1* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP2* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
        FWPM_NET_EVENT_CLASSIFY_ALLOW0* classifyAllow;
        FWPM_NET_EVENT_CAPABILITY_DROP0* capabilityDrop;
        FWPM_NET_EVENT_CAPABILITY_ALLOW0* capabilityAllow;
        FWPM_NET_EVENT_CLASSIFY_DROP_MAC0* classifyDropMac;
    }
}

struct FWPM_NET_EVENT3
{
    FWPM_NET_EVENT_HEADER3 header;
    FWPM_NET_EVENT_TYPE type;
    union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE1* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE0* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE1* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP2* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
        FWPM_NET_EVENT_CLASSIFY_ALLOW0* classifyAllow;
        FWPM_NET_EVENT_CAPABILITY_DROP0* capabilityDrop;
        FWPM_NET_EVENT_CAPABILITY_ALLOW0* capabilityAllow;
        FWPM_NET_EVENT_CLASSIFY_DROP_MAC0* classifyDropMac;
    }
}

struct FWPM_NET_EVENT4_
{
    FWPM_NET_EVENT_HEADER3 header;
    FWPM_NET_EVENT_TYPE type;
    union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE2_* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE1_* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE1* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP2* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
        FWPM_NET_EVENT_CLASSIFY_ALLOW0* classifyAllow;
        FWPM_NET_EVENT_CAPABILITY_DROP0* capabilityDrop;
        FWPM_NET_EVENT_CAPABILITY_ALLOW0* capabilityAllow;
        FWPM_NET_EVENT_CLASSIFY_DROP_MAC0* classifyDropMac;
    }
}

struct FWPM_NET_EVENT5_
{
    FWPM_NET_EVENT_HEADER3 header;
    FWPM_NET_EVENT_TYPE type;
    union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE2_* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE1_* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE1* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP2* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
        FWPM_NET_EVENT_CLASSIFY_ALLOW0* classifyAllow;
        FWPM_NET_EVENT_CAPABILITY_DROP0* capabilityDrop;
        FWPM_NET_EVENT_CAPABILITY_ALLOW0* capabilityAllow;
        FWPM_NET_EVENT_CLASSIFY_DROP_MAC0* classifyDropMac;
        FWPM_NET_EVENT_LPM_PACKET_ARRIVAL0_* lpmPacketArrival;
    }
}

struct FWPM_NET_EVENT_ENUM_TEMPLATE0
{
    FILETIME startTime;
    FILETIME endTime;
    uint     numFilterConditions;
    FWPM_FILTER_CONDITION0* filterCondition;
}

struct FWPM_NET_EVENT_SUBSCRIPTION0
{
    FWPM_NET_EVENT_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    GUID sessionKey;
}

struct FWPM_SYSTEM_PORTS_BY_TYPE0
{
    FWPM_SYSTEM_PORT_TYPE type;
    uint    numPorts;
    ushort* ports;
}

struct FWPM_SYSTEM_PORTS0
{
    uint numTypes;
    FWPM_SYSTEM_PORTS_BY_TYPE0* types;
}

struct FWPM_CONNECTION0
{
    ulong              connectionId;
    FWP_IP_VERSION     ipVersion;
    union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
    union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    GUID*              providerKey;
    IPSEC_TRAFFIC_TYPE ipsecTrafficModeType;
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    IKEEXT_PROPOSAL0   mmCrypto;
    IKEEXT_CREDENTIAL2 mmPeer;
    IKEEXT_CREDENTIAL2 emPeer;
    ulong              bytesTransferredIn;
    ulong              bytesTransferredOut;
    ulong              bytesTransferredTotal;
    FILETIME           startSysTime;
}

struct FWPM_CONNECTION_ENUM_TEMPLATE0
{
    ulong connectionId;
    uint  flags;
}

struct FWPM_CONNECTION_SUBSCRIPTION0
{
    FWPM_CONNECTION_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    GUID sessionKey;
}

struct FWPM_VSWITCH_EVENT0
{
    FWPM_VSWITCH_EVENT_TYPE eventType;
    ushort* vSwitchId;
    union
    {
        struct positionInfo
        {
            uint     numvSwitchFilterExtensions;
            ushort** vSwitchFilterExtensions;
        }
        struct reorderInfo
        {
            BOOL     inRequiredPosition;
            uint     numvSwitchFilterExtensions;
            ushort** vSwitchFilterExtensions;
        }
    }
}

struct FWPM_VSWITCH_EVENT_SUBSCRIPTION0
{
    uint flags;
    GUID sessionKey;
}

struct IPSEC_KEY_MANAGER_CALLBACKS0
{
    GUID reserved;
    uint flags;
    IPSEC_KEY_MANAGER_KEY_DICTATION_CHECK0 keyDictationCheck;
    IPSEC_KEY_MANAGER_DICTATE_KEY0 keyDictation;
    IPSEC_KEY_MANAGER_NOTIFY_KEY0 keyNotify;
}

union DL_OUI
{
    ubyte[3] Byte;
    struct
    {
        ubyte _bitfield207;
    }
}

union DL_EI48
{
    ubyte[3] Byte;
}

union DL_EUI48
{
    ubyte[6] Byte;
    struct
    {
        DL_OUI  Oui;
        DL_EI48 Ei48;
    }
}

union DL_EI64
{
    ubyte[5] Byte;
}

union DL_EUI64
{
    ubyte[8] Byte;
    ulong    Value;
    struct
    {
        DL_OUI Oui;
        union
        {
            DL_EI64 Ei64;
            struct
            {
                ubyte   Type;
                ubyte   Tse;
                DL_EI48 Ei48;
            }
        }
    }
}

struct SNAP_HEADER
{
    ubyte    Dsap;
    ubyte    Ssap;
    ubyte    Control;
    ubyte[3] Oui;
    ushort   Type;
}

struct ETHERNET_HEADER
{
    DL_EUI48 Destination;
    DL_EUI48 Source;
    union
    {
        ushort Type;
        ushort Length;
    }
}

struct VLAN_TAG
{
    union
    {
        ushort Tag;
        struct
        {
            ushort _bitfield208;
        }
    }
    ushort Type;
}

struct ICMP_HEADER
{
    ubyte  Type;
    ubyte  Code;
    ushort Checksum;
}

struct ICMP_MESSAGE
{
    ICMP_HEADER Header;
    union Data
    {
        uint[1]   Data32;
        ushort[2] Data16;
        ubyte[4]  Data8;
    }
}

struct IPV4_HEADER
{
    union
    {
        ubyte VersionAndHeaderLength;
        struct
        {
            ubyte _bitfield209;
        }
    }
    union
    {
        ubyte TypeOfServiceAndEcnField;
        struct
        {
            ubyte _bitfield210;
        }
    }
    ushort  TotalLength;
    ushort  Identification;
    union
    {
        ushort FlagsAndOffset;
        struct
        {
            ushort _bitfield211;
        }
    }
    ubyte   TimeToLive;
    ubyte   Protocol;
    ushort  HeaderChecksum;
    in_addr SourceAddress;
    in_addr DestinationAddress;
}

struct IPV4_OPTION_HEADER
{
    union
    {
        ubyte OptionType;
        struct
        {
            ubyte _bitfield212;
        }
    }
    ubyte OptionLength;
}

struct IPV4_TIMESTAMP_OPTION
{
    IPV4_OPTION_HEADER OptionHeader;
    ubyte              Pointer;
    union
    {
        ubyte FlagsOverflow;
        struct
        {
            ubyte _bitfield213;
        }
    }
}

struct IPV4_ROUTING_HEADER
{
    IPV4_OPTION_HEADER OptionHeader;
    ubyte              Pointer;
}

struct ICMPV4_ROUTER_SOLICIT
{
    ICMP_MESSAGE RsHeader;
}

struct ICMPV4_ROUTER_ADVERT_HEADER
{
    ICMP_MESSAGE RaHeader;
}

struct ICMPV4_ROUTER_ADVERT_ENTRY
{
    in_addr RouterAdvertAddr;
    int     PreferenceLevel;
}

struct ICMPV4_TIMESTAMP_MESSAGE
{
    ICMP_MESSAGE Header;
    uint         OriginateTimestamp;
    uint         ReceiveTimestamp;
    uint         TransmitTimestamp;
}

struct ICMPV4_ADDRESS_MASK_MESSAGE
{
    ICMP_MESSAGE Header;
    uint         AddressMask;
}

struct ARP_HEADER
{
    ushort   HardwareAddressSpace;
    ushort   ProtocolAddressSpace;
    ubyte    HardwareAddressLength;
    ubyte    ProtocolAddressLength;
    ushort   Opcode;
    ubyte[1] SenderHardwareAddress;
}

struct IGMP_HEADER
{
    union
    {
        struct
        {
            ubyte _bitfield214;
        }
        ubyte VersionType;
    }
    union
    {
        ubyte Reserved;
        ubyte MaxRespTime;
        ubyte Code;
    }
    ushort  Checksum;
    in_addr MulticastAddress;
}

struct IGMPV3_QUERY_HEADER
{
    ubyte   Type;
    union
    {
        ubyte MaxRespCode;
        struct
        {
            ubyte _bitfield215;
        }
    }
    ushort  Checksum;
    in_addr MulticastAddress;
    ubyte   _bitfield216;
    union
    {
        ubyte QueriersQueryInterfaceCode;
        struct
        {
            ubyte _bitfield217;
        }
    }
    ushort  SourceCount;
}

struct IGMPV3_REPORT_RECORD_HEADER
{
    ubyte   Type;
    ubyte   AuxillaryDataLength;
    ushort  SourceCount;
    in_addr MulticastAddress;
}

struct IGMPV3_REPORT_HEADER
{
    ubyte  Type;
    ubyte  Reserved;
    ushort Checksum;
    ushort Reserved2;
    ushort RecordCount;
}

struct IPV6_HEADER
{
    union
    {
        uint VersionClassFlow;
        struct
        {
            uint _bitfield218;
        }
    }
    ushort   PayloadLength;
    ubyte    NextHeader;
    ubyte    HopLimit;
    in6_addr SourceAddress;
    in6_addr DestinationAddress;
}

struct IPV6_FRAGMENT_HEADER
{
    ubyte NextHeader;
    ubyte Reserved;
    union
    {
        struct
        {
            ushort _bitfield219;
        }
        ushort OffsetAndFlags;
    }
    uint  Id;
}

struct IPV6_EXTENSION_HEADER
{
    ubyte NextHeader;
    ubyte Length;
}

struct IPV6_OPTION_HEADER
{
    ubyte Type;
    ubyte DataLength;
}

struct IPV6_OPTION_JUMBOGRAM
{
    IPV6_OPTION_HEADER Header;
    ubyte[4]           JumbogramLength;
}

struct IPV6_OPTION_ROUTER_ALERT
{
    IPV6_OPTION_HEADER Header;
    ubyte[2]           Value;
}

struct IPV6_ROUTING_HEADER
{
    ubyte    NextHeader;
    ubyte    Length;
    ubyte    RoutingType;
    ubyte    SegmentsLeft;
    ubyte[4] Reserved;
}

struct nd_router_solicit
{
    ICMP_MESSAGE nd_rs_hdr;
}

struct nd_router_advert
{
    ICMP_MESSAGE nd_ra_hdr;
    uint         nd_ra_reachable;
    uint         nd_ra_retransmit;
}

union IPV6_ROUTER_ADVERTISEMENT_FLAGS
{
    struct
    {
        ubyte _bitfield220;
    }
    ubyte Value;
}

struct nd_neighbor_solicit
{
    ICMP_MESSAGE nd_ns_hdr;
    in6_addr     nd_ns_target;
}

struct nd_neighbor_advert
{
    ICMP_MESSAGE nd_na_hdr;
    in6_addr     nd_na_target;
}

union IPV6_NEIGHBOR_ADVERTISEMENT_FLAGS
{
    struct
    {
        ubyte    _bitfield221;
        ubyte[3] Reserved2;
    }
    uint Value;
}

struct nd_redirect
{
    ICMP_MESSAGE nd_rd_hdr;
    in6_addr     nd_rd_target;
    in6_addr     nd_rd_dst;
}

struct nd_opt_hdr
{
    ubyte nd_opt_type;
    ubyte nd_opt_len;
}

struct nd_opt_prefix_info
{
    ubyte    nd_opt_pi_type;
    ubyte    nd_opt_pi_len;
    ubyte    nd_opt_pi_prefix_len;
    union
    {
        ubyte nd_opt_pi_flags_reserved;
        struct Flags
        {
            ubyte _bitfield222;
        }
    }
    uint     nd_opt_pi_valid_time;
    uint     nd_opt_pi_preferred_time;
    union
    {
        uint nd_opt_pi_reserved2;
        struct
        {
            ubyte[3] nd_opt_pi_reserved3;
            ubyte    nd_opt_pi_site_prefix_len;
        }
    }
    in6_addr nd_opt_pi_prefix;
}

struct nd_opt_rd_hdr
{
    ubyte  nd_opt_rh_type;
    ubyte  nd_opt_rh_len;
    ushort nd_opt_rh_reserved1;
    uint   nd_opt_rh_reserved2;
}

struct nd_opt_mtu
{
    ubyte  nd_opt_mtu_type;
    ubyte  nd_opt_mtu_len;
    ushort nd_opt_mtu_reserved;
    uint   nd_opt_mtu_mtu;
}

struct nd_opt_route_info
{
    ubyte    nd_opt_ri_type;
    ubyte    nd_opt_ri_len;
    ubyte    nd_opt_ri_prefix_len;
    union
    {
        ubyte nd_opt_ri_flags_reserved;
        struct Flags
        {
            ubyte _bitfield223;
        }
    }
    uint     nd_opt_ri_route_lifetime;
    in6_addr nd_opt_ri_prefix;
}

struct nd_opt_rdnss
{
    ubyte  nd_opt_rdnss_type;
    ubyte  nd_opt_rdnss_len;
    ushort nd_opt_rdnss_reserved;
    uint   nd_opt_rdnss_lifetime;
}

struct nd_opt_dnssl
{
    ubyte  nd_opt_dnssl_type;
    ubyte  nd_opt_dnssl_len;
    ushort nd_opt_dnssl_reserved;
    uint   nd_opt_dnssl_lifetime;
}

struct MLD_HEADER
{
    ICMP_HEADER IcmpHeader;
    ushort      MaxRespTime;
    ushort      Reserved;
    in6_addr    MulticastAddress;
}

struct MLDV2_QUERY_HEADER
{
    ICMP_HEADER IcmpHeader;
    union
    {
        ushort MaxRespCode;
        struct
        {
            ushort _bitfield224;
        }
    }
    ushort      Reserved;
    in6_addr    MulticastAddress;
    ubyte       _bitfield225;
    union
    {
        ubyte QueriersQueryInterfaceCode;
        struct
        {
            ubyte _bitfield226;
        }
    }
    ushort      SourceCount;
}

struct MLDV2_REPORT_RECORD_HEADER
{
    ubyte    Type;
    ubyte    AuxillaryDataLength;
    ushort   SourceCount;
    in6_addr MulticastAddress;
}

struct MLDV2_REPORT_HEADER
{
    ICMP_HEADER IcmpHeader;
    ushort      Reserved;
    ushort      RecordCount;
}

struct tcp_hdr
{
align (1):
    ushort th_sport;
    ushort th_dport;
    uint   th_seq;
    uint   th_ack;
    ubyte  _bitfield227;
    ubyte  th_flags;
    ushort th_win;
    ushort th_sum;
    ushort th_urp;
}

struct tcp_opt_mss
{
align (1):
    ubyte  Kind;
    ubyte  Length;
    ushort Mss;
}

struct tcp_opt_ws
{
    ubyte Kind;
    ubyte Length;
    ubyte ShiftCnt;
}

struct tcp_opt_sack_permitted
{
    ubyte Kind;
    ubyte Length;
}

struct tcp_opt_sack
{
    ubyte Kind;
    ubyte Length;
    struct Block
    {
    align (1):
        uint Left;
        uint Right;
    }
}

struct tcp_opt_ts
{
align (1):
    ubyte Kind;
    ubyte Length;
    uint  Val;
    uint  EcR;
}

struct tcp_opt_unknown
{
    ubyte Kind;
    ubyte Length;
}

struct tcp_opt_fastopen
{
    ubyte    Kind;
    ubyte    Length;
    ubyte[1] Cookie;
}

struct DL_TUNNEL_ADDRESS
{
    COMPARTMENT_ID CompartmentId;
    SCOPE_ID       ScopeId;
    ubyte[1]       IpAddress;
}

struct DL_TEREDO_ADDRESS
{
    ubyte[6] Reserved;
    union
    {
    align (1):
        DL_EUI64 Eui64;
        struct
        {
        align (1):
            ushort  Flags;
            ushort  MappedPort;
            in_addr MappedAddress;
        }
    }
}

struct DL_TEREDO_ADDRESS_PRV
{
    ubyte[6] Reserved;
    union
    {
    align (1):
        DL_EUI64 Eui64;
        struct
        {
        align (1):
            ushort   Flags;
            ushort   MappedPort;
            in_addr  MappedAddress;
            in_addr  LocalAddress;
            uint     InterfaceIndex;
            ushort   LocalPort;
            DL_EUI48 DlDestination;
        }
    }
}

struct IPTLS_METADATA
{
align (1):
    ulong SequenceNumber;
}

struct NPI_MODULEID
{
    ushort            Length;
    NPI_MODULEID_TYPE Type;
    union
    {
        GUID Guid;
        LUID IfLuid;
    }
}

// Functions

@DllImport("fwpuclnt")
void FwpmFreeMemory0(void** p);

@DllImport("fwpuclnt")
uint FwpmEngineOpen0(const(ushort)* serverName, uint authnService, SEC_WINNT_AUTH_IDENTITY_W* authIdentity, 
                     const(FWPM_SESSION0)* session, HANDLE* engineHandle);

@DllImport("fwpuclnt")
uint FwpmEngineClose0(HANDLE engineHandle);

@DllImport("fwpuclnt")
uint FwpmEngineGetOption0(HANDLE engineHandle, FWPM_ENGINE_OPTION option, FWP_VALUE0** value);

@DllImport("fwpuclnt")
uint FwpmEngineSetOption0(HANDLE engineHandle, FWPM_ENGINE_OPTION option, const(FWP_VALUE0)* newValue);

@DllImport("fwpuclnt")
uint FwpmEngineGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                                ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint FwpmEngineSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, 
                                const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt")
uint FwpmSessionCreateEnumHandle0(HANDLE engineHandle, const(FWPM_SESSION_ENUM_TEMPLATE0)* enumTemplate, 
                                  HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint FwpmSessionEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_SESSION0*** entries, 
                      uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmSessionDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint FwpmTransactionBegin0(HANDLE engineHandle, uint flags);

@DllImport("fwpuclnt")
uint FwpmTransactionCommit0(HANDLE engineHandle);

@DllImport("fwpuclnt")
uint FwpmTransactionAbort0(HANDLE engineHandle);

@DllImport("fwpuclnt")
uint FwpmProviderAdd0(HANDLE engineHandle, const(FWPM_PROVIDER0)* provider, void* sd);

@DllImport("fwpuclnt")
uint FwpmProviderDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

@DllImport("fwpuclnt")
uint FwpmProviderGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_PROVIDER0** provider);

@DllImport("fwpuclnt")
uint FwpmProviderCreateEnumHandle0(HANDLE engineHandle, const(FWPM_PROVIDER_ENUM_TEMPLATE0)* enumTemplate, 
                                   HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint FwpmProviderEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_PROVIDER0*** entries, 
                       uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmProviderDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint FwpmProviderGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, void** sidOwner, 
                                       void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint FwpmProviderSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                       const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, 
                                       const(ACL)* sacl);

@DllImport("fwpuclnt")
uint FwpmProviderSubscribeChanges0(HANDLE engineHandle, const(FWPM_PROVIDER_SUBSCRIPTION0)* subscription, 
                                   FWPM_PROVIDER_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

@DllImport("fwpuclnt")
uint FwpmProviderUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

@DllImport("fwpuclnt")
uint FwpmProviderSubscriptionsGet0(HANDLE engineHandle, FWPM_PROVIDER_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt")
uint FwpmProviderContextAdd0(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT0)* providerContext, void* sd, 
                             ulong* id);

@DllImport("fwpuclnt")
uint FwpmProviderContextAdd1(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT1)* providerContext, void* sd, 
                             ulong* id);

@DllImport("fwpuclnt")
uint FwpmProviderContextAdd2(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT2)* providerContext, void* sd, 
                             ulong* id);

@DllImport("fwpuclnt")
uint FwpmProviderContextAdd3(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT3_)* providerContext, void* sd, 
                             ulong* id);

@DllImport("fwpuclnt")
uint FwpmProviderContextDeleteById0(HANDLE engineHandle, ulong id);

@DllImport("fwpuclnt")
uint FwpmProviderContextDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetById0(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT0** providerContext);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetById1(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT1** providerContext);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetById2(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT2** providerContext);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetById3(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT3_** providerContext);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_PROVIDER_CONTEXT0** providerContext);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetByKey1(HANDLE engineHandle, const(GUID)* key, FWPM_PROVIDER_CONTEXT1** providerContext);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetByKey2(HANDLE engineHandle, const(GUID)* key, FWPM_PROVIDER_CONTEXT2** providerContext);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetByKey3(HANDLE engineHandle, const(GUID)* key, FWPM_PROVIDER_CONTEXT3_** providerContext);

@DllImport("fwpuclnt")
uint FwpmProviderContextCreateEnumHandle0(HANDLE engineHandle, 
                                          const(FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0)* enumTemplate, 
                                          HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint FwpmProviderContextEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                              FWPM_PROVIDER_CONTEXT0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmProviderContextEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                              FWPM_PROVIDER_CONTEXT1*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmProviderContextEnum2(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                              FWPM_PROVIDER_CONTEXT2*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmProviderContextEnum3(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                              FWPM_PROVIDER_CONTEXT3_*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmProviderContextDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                              void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, 
                                              void** securityDescriptor);

@DllImport("fwpuclnt")
uint FwpmProviderContextSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                              const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, 
                                              const(ACL)* sacl);

@DllImport("fwpuclnt")
uint FwpmProviderContextSubscribeChanges0(HANDLE engineHandle, 
                                          const(FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0)* subscription, 
                                          FWPM_PROVIDER_CONTEXT_CHANGE_CALLBACK0 callback, void* context, 
                                          HANDLE* changeHandle);

@DllImport("fwpuclnt")
uint FwpmProviderContextUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

@DllImport("fwpuclnt")
uint FwpmProviderContextSubscriptionsGet0(HANDLE engineHandle, FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0*** entries, 
                                          uint* numEntries);

@DllImport("fwpuclnt")
uint FwpmSubLayerAdd0(HANDLE engineHandle, const(FWPM_SUBLAYER0)* subLayer, void* sd);

@DllImport("fwpuclnt")
uint FwpmSubLayerDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

@DllImport("fwpuclnt")
uint FwpmSubLayerGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_SUBLAYER0** subLayer);

@DllImport("fwpuclnt")
uint FwpmSubLayerCreateEnumHandle0(HANDLE engineHandle, const(FWPM_SUBLAYER_ENUM_TEMPLATE0)* enumTemplate, 
                                   HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint FwpmSubLayerEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_SUBLAYER0*** entries, 
                       uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmSubLayerDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint FwpmSubLayerGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, void** sidOwner, 
                                       void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint FwpmSubLayerSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                       const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, 
                                       const(ACL)* sacl);

@DllImport("fwpuclnt")
uint FwpmSubLayerSubscribeChanges0(HANDLE engineHandle, const(FWPM_SUBLAYER_SUBSCRIPTION0)* subscription, 
                                   FWPM_SUBLAYER_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

@DllImport("fwpuclnt")
uint FwpmSubLayerUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

@DllImport("fwpuclnt")
uint FwpmSubLayerSubscriptionsGet0(HANDLE engineHandle, FWPM_SUBLAYER_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt")
uint FwpmLayerGetById0(HANDLE engineHandle, ushort id, FWPM_LAYER0** layer);

@DllImport("fwpuclnt")
uint FwpmLayerGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_LAYER0** layer);

@DllImport("fwpuclnt")
uint FwpmLayerCreateEnumHandle0(HANDLE engineHandle, const(FWPM_LAYER_ENUM_TEMPLATE0)* enumTemplate, 
                                HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint FwpmLayerEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_LAYER0*** entries, 
                    uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmLayerDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint FwpmLayerGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, void** sidOwner, 
                                    void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint FwpmLayerSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, const(SID)* sidOwner, 
                                    const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt")
uint FwpmCalloutAdd0(HANDLE engineHandle, const(FWPM_CALLOUT0)* callout, void* sd, uint* id);

@DllImport("fwpuclnt")
uint FwpmCalloutDeleteById0(HANDLE engineHandle, uint id);

@DllImport("fwpuclnt")
uint FwpmCalloutDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

@DllImport("fwpuclnt")
uint FwpmCalloutGetById0(HANDLE engineHandle, uint id, FWPM_CALLOUT0** callout);

@DllImport("fwpuclnt")
uint FwpmCalloutGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_CALLOUT0** callout);

@DllImport("fwpuclnt")
uint FwpmCalloutCreateEnumHandle0(HANDLE engineHandle, const(FWPM_CALLOUT_ENUM_TEMPLATE0)* enumTemplate, 
                                  HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint FwpmCalloutEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_CALLOUT0*** entries, 
                      uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmCalloutDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint FwpmCalloutGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, void** sidOwner, 
                                      void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint FwpmCalloutSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                      const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt")
uint FwpmCalloutSubscribeChanges0(HANDLE engineHandle, const(FWPM_CALLOUT_SUBSCRIPTION0)* subscription, 
                                  FWPM_CALLOUT_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

@DllImport("fwpuclnt")
uint FwpmCalloutUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

@DllImport("fwpuclnt")
uint FwpmCalloutSubscriptionsGet0(HANDLE engineHandle, FWPM_CALLOUT_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt")
uint FwpmFilterAdd0(HANDLE engineHandle, const(FWPM_FILTER0)* filter, void* sd, ulong* id);

@DllImport("fwpuclnt")
uint FwpmFilterDeleteById0(HANDLE engineHandle, ulong id);

@DllImport("fwpuclnt")
uint FwpmFilterDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

@DllImport("fwpuclnt")
uint FwpmFilterGetById0(HANDLE engineHandle, ulong id, FWPM_FILTER0** filter);

@DllImport("fwpuclnt")
uint FwpmFilterGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_FILTER0** filter);

@DllImport("fwpuclnt")
uint FwpmFilterCreateEnumHandle0(HANDLE engineHandle, const(FWPM_FILTER_ENUM_TEMPLATE0)* enumTemplate, 
                                 HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint FwpmFilterEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_FILTER0*** entries, 
                     uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmFilterDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint FwpmFilterGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, void** sidOwner, 
                                     void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint FwpmFilterSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                     const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt")
uint FwpmFilterSubscribeChanges0(HANDLE engineHandle, const(FWPM_FILTER_SUBSCRIPTION0)* subscription, 
                                 FWPM_FILTER_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

@DllImport("fwpuclnt")
uint FwpmFilterUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

@DllImport("fwpuclnt")
uint FwpmFilterSubscriptionsGet0(HANDLE engineHandle, FWPM_FILTER_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt")
uint FwpmGetAppIdFromFileName0(const(wchar)* fileName, FWP_BYTE_BLOB** appId);

@DllImport("fwpuclnt")
uint FwpmBitmapIndexGet0(HANDLE engineHandle, const(GUID)* fieldId, ubyte* idx);

@DllImport("fwpuclnt")
uint FwpmBitmapIndexFree0(HANDLE engineHandle, const(GUID)* fieldId, ubyte* idx);

@DllImport("fwpuclnt")
uint FwpmIPsecTunnelAdd0(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT0)* mainModePolicy, 
                         const(FWPM_PROVIDER_CONTEXT0)* tunnelPolicy, uint numFilterConditions, 
                         char* filterConditions, void* sd);

@DllImport("fwpuclnt")
uint FwpmIPsecTunnelAdd1(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT1)* mainModePolicy, 
                         const(FWPM_PROVIDER_CONTEXT1)* tunnelPolicy, uint numFilterConditions, 
                         char* filterConditions, const(GUID)* keyModKey, void* sd);

@DllImport("fwpuclnt")
uint FwpmIPsecTunnelAdd2(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT2)* mainModePolicy, 
                         const(FWPM_PROVIDER_CONTEXT2)* tunnelPolicy, uint numFilterConditions, 
                         char* filterConditions, const(GUID)* keyModKey, void* sd);

@DllImport("fwpuclnt")
uint FwpmIPsecTunnelAdd3(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT3_)* mainModePolicy, 
                         const(FWPM_PROVIDER_CONTEXT3_)* tunnelPolicy, uint numFilterConditions, 
                         char* filterConditions, const(GUID)* keyModKey, void* sd);

@DllImport("fwpuclnt")
uint FwpmIPsecTunnelDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

@DllImport("fwpuclnt")
uint IPsecGetStatistics0(HANDLE engineHandle, IPSEC_STATISTICS0* ipsecStatistics);

@DllImport("fwpuclnt")
uint IPsecGetStatistics1(HANDLE engineHandle, IPSEC_STATISTICS1* ipsecStatistics);

@DllImport("fwpuclnt")
uint IPsecSaContextCreate0(HANDLE engineHandle, const(IPSEC_TRAFFIC0)* outboundTraffic, ulong* inboundFilterId, 
                           ulong* id);

@DllImport("fwpuclnt")
uint IPsecSaContextCreate1(HANDLE engineHandle, const(IPSEC_TRAFFIC1)* outboundTraffic, 
                           const(IPSEC_VIRTUAL_IF_TUNNEL_INFO0)* virtualIfTunnelInfo, ulong* inboundFilterId, 
                           ulong* id);

@DllImport("fwpuclnt")
uint IPsecSaContextDeleteById0(HANDLE engineHandle, ulong id);

@DllImport("fwpuclnt")
uint IPsecSaContextGetById0(HANDLE engineHandle, ulong id, IPSEC_SA_CONTEXT0** saContext);

@DllImport("fwpuclnt")
uint IPsecSaContextGetById1(HANDLE engineHandle, ulong id, IPSEC_SA_CONTEXT1** saContext);

@DllImport("fwpuclnt")
uint IPsecSaContextGetSpi0(HANDLE engineHandle, ulong id, const(IPSEC_GETSPI0)* getSpi, uint* inboundSpi);

@DllImport("fwpuclnt")
uint IPsecSaContextGetSpi1(HANDLE engineHandle, ulong id, const(IPSEC_GETSPI1)* getSpi, uint* inboundSpi);

@DllImport("fwpuclnt")
uint IPsecSaContextSetSpi0(HANDLE engineHandle, ulong id, const(IPSEC_GETSPI1)* getSpi, uint inboundSpi);

@DllImport("fwpuclnt")
uint IPsecSaContextAddInbound0(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE0)* inboundBundle);

@DllImport("fwpuclnt")
uint IPsecSaContextAddOutbound0(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE0)* outboundBundle);

@DllImport("fwpuclnt")
uint IPsecSaContextAddInbound1(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE1)* inboundBundle);

@DllImport("fwpuclnt")
uint IPsecSaContextAddOutbound1(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE1)* outboundBundle);

@DllImport("fwpuclnt")
uint IPsecSaContextExpire0(HANDLE engineHandle, ulong id);

@DllImport("fwpuclnt")
uint IPsecSaContextUpdate0(HANDLE engineHandle, ulong flags, const(IPSEC_SA_CONTEXT1)* newValues);

@DllImport("fwpuclnt")
uint IPsecSaContextCreateEnumHandle0(HANDLE engineHandle, const(IPSEC_SA_CONTEXT_ENUM_TEMPLATE0)* enumTemplate, 
                                     HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint IPsecSaContextEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                         IPSEC_SA_CONTEXT0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint IPsecSaContextEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                         IPSEC_SA_CONTEXT1*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint IPsecSaContextDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint IPsecSaContextSubscribe0(HANDLE engineHandle, const(IPSEC_SA_CONTEXT_SUBSCRIPTION0)* subscription, 
                              IPSEC_SA_CONTEXT_CALLBACK0 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt")
uint IPsecSaContextUnsubscribe0(HANDLE engineHandle, HANDLE eventsHandle);

@DllImport("fwpuclnt")
uint IPsecSaContextSubscriptionsGet0(HANDLE engineHandle, IPSEC_SA_CONTEXT_SUBSCRIPTION0*** entries, 
                                     uint* numEntries);

@DllImport("fwpuclnt")
uint IPsecSaCreateEnumHandle0(HANDLE engineHandle, const(IPSEC_SA_ENUM_TEMPLATE0)* enumTemplate, 
                              HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint IPsecSaEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IPSEC_SA_DETAILS0*** entries, 
                  uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint IPsecSaEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IPSEC_SA_DETAILS1*** entries, 
                  uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint IPsecSaDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint IPsecSaDbGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                               ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint IPsecSaDbSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, 
                               const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt")
uint IPsecDospGetStatistics0(HANDLE engineHandle, IPSEC_DOSP_STATISTICS0* idpStatistics);

@DllImport("fwpuclnt")
uint IPsecDospStateCreateEnumHandle0(HANDLE engineHandle, const(IPSEC_DOSP_STATE_ENUM_TEMPLATE0)* enumTemplate, 
                                     HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint IPsecDospStateEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                         IPSEC_DOSP_STATE0*** entries, uint* numEntries);

@DllImport("fwpuclnt")
uint IPsecDospStateDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint IPsecDospGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                               ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint IPsecDospSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, 
                               const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt")
uint IPsecKeyManagerAddAndRegister0(HANDLE engineHandle, const(IPSEC_KEY_MANAGER0)* keyManager, 
                                    const(IPSEC_KEY_MANAGER_CALLBACKS0)* keyManagerCallbacks, HANDLE* keyMgmtHandle);

@DllImport("fwpuclnt")
uint IPsecKeyManagerUnregisterAndDelete0(HANDLE engineHandle, HANDLE keyMgmtHandle);

@DllImport("fwpuclnt")
uint IPsecKeyManagersGet0(HANDLE engineHandle, IPSEC_KEY_MANAGER0*** entries, uint* numEntries);

@DllImport("fwpuclnt")
uint IPsecKeyManagerGetSecurityInfoByKey0(HANDLE engineHandle, const(void)* reserved, uint securityInfo, 
                                          void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, 
                                          void** securityDescriptor);

@DllImport("fwpuclnt")
uint IPsecKeyManagerSetSecurityInfoByKey0(HANDLE engineHandle, const(void)* reserved, uint securityInfo, 
                                          const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, 
                                          const(ACL)* sacl);

@DllImport("fwpuclnt")
uint IkeextGetStatistics0(HANDLE engineHandle, IKEEXT_STATISTICS0* ikeextStatistics);

@DllImport("fwpuclnt")
uint IkeextGetStatistics1(HANDLE engineHandle, IKEEXT_STATISTICS1* ikeextStatistics);

@DllImport("fwpuclnt")
uint IkeextSaDeleteById0(HANDLE engineHandle, ulong id);

@DllImport("fwpuclnt")
uint IkeextSaGetById0(HANDLE engineHandle, ulong id, IKEEXT_SA_DETAILS0** sa);

@DllImport("fwpuclnt")
uint IkeextSaGetById1(HANDLE engineHandle, ulong id, GUID* saLookupContext, IKEEXT_SA_DETAILS1** sa);

@DllImport("fwpuclnt")
uint IkeextSaGetById2(HANDLE engineHandle, ulong id, GUID* saLookupContext, IKEEXT_SA_DETAILS2** sa);

@DllImport("fwpuclnt")
uint IkeextSaCreateEnumHandle0(HANDLE engineHandle, const(IKEEXT_SA_ENUM_TEMPLATE0)* enumTemplate, 
                               HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint IkeextSaEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IKEEXT_SA_DETAILS0*** entries, 
                   uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint IkeextSaEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IKEEXT_SA_DETAILS1*** entries, 
                   uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint IkeextSaEnum2(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IKEEXT_SA_DETAILS2*** entries, 
                   uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint IkeextSaDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint IkeextSaDbGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                                ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint IkeextSaDbSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, 
                                const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt")
uint FwpmNetEventCreateEnumHandle0(HANDLE engineHandle, const(FWPM_NET_EVENT_ENUM_TEMPLATE0)* enumTemplate, 
                                   HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint FwpmNetEventEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmNetEventEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT1*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmNetEventEnum2(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT2*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmNetEventEnum3(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT3*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmNetEventEnum4(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT4_*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmNetEventEnum5(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT5_*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmNetEventDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint FwpmNetEventsGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                                   ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint FwpmNetEventsSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, 
                                   const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt")
uint FwpmNetEventSubscribe0(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, 
                            FWPM_NET_EVENT_CALLBACK0 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt")
uint FwpmNetEventUnsubscribe0(HANDLE engineHandle, HANDLE eventsHandle);

@DllImport("fwpuclnt")
uint FwpmNetEventSubscriptionsGet0(HANDLE engineHandle, FWPM_NET_EVENT_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt")
uint FwpmNetEventSubscribe1(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, 
                            FWPM_NET_EVENT_CALLBACK1 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt")
uint FwpmNetEventSubscribe2(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, 
                            FWPM_NET_EVENT_CALLBACK2 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt")
uint FwpmNetEventSubscribe3(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, 
                            FWPM_NET_EVENT_CALLBACK3 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt")
uint FwpmNetEventSubscribe4(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, 
                            FWPM_NET_EVENT_CALLBACK4 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt")
uint FwpmSystemPortsGet0(HANDLE engineHandle, FWPM_SYSTEM_PORTS0** sysPorts);

@DllImport("fwpuclnt")
uint FwpmSystemPortsSubscribe0(HANDLE engineHandle, void* reserved, FWPM_SYSTEM_PORTS_CALLBACK0 callback, 
                               void* context, HANDLE* sysPortsHandle);

@DllImport("fwpuclnt")
uint FwpmSystemPortsUnsubscribe0(HANDLE engineHandle, HANDLE sysPortsHandle);

@DllImport("fwpuclnt")
uint FwpmConnectionGetById0(HANDLE engineHandle, ulong id, FWPM_CONNECTION0** connection);

@DllImport("fwpuclnt")
uint FwpmConnectionEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                         FWPM_CONNECTION0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmConnectionCreateEnumHandle0(HANDLE engineHandle, const(FWPM_CONNECTION_ENUM_TEMPLATE0)* enumTemplate, 
                                     HANDLE* enumHandle);

@DllImport("fwpuclnt")
uint FwpmConnectionDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt")
uint FwpmConnectionGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                                    ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint FwpmConnectionSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, 
                                    const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt")
uint FwpmConnectionSubscribe0(HANDLE engineHandle, const(FWPM_CONNECTION_SUBSCRIPTION0)* subscription, 
                              FWPM_CONNECTION_CALLBACK0 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt")
uint FwpmConnectionUnsubscribe0(HANDLE engineHandle, HANDLE eventsHandle);

@DllImport("fwpuclnt")
uint FwpmvSwitchEventSubscribe0(HANDLE engineHandle, const(FWPM_VSWITCH_EVENT_SUBSCRIPTION0)* subscription, 
                                FWPM_VSWITCH_EVENT_CALLBACK0 callback, void* context, HANDLE* subscriptionHandle);

@DllImport("fwpuclnt")
uint FwpmvSwitchEventUnsubscribe0(HANDLE engineHandle, HANDLE subscriptionHandle);

@DllImport("fwpuclnt")
uint FwpmvSwitchEventsGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                                       ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt")
uint FwpmvSwitchEventsSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, 
                                       const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);


