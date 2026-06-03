// Written in the D programming language.

module windows.win32.networkmanagement.dns;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, HANDLE, PSTR, PWSTR, WIN32_ERROR;

extern(Windows) @nogc nothrow:


// Enums


alias DNS_QUERY_OPTIONS = uint;
enum : uint
{
    DNS_QUERY_PARSE_ALL_RECORDS            = 0x00000000U,
    DNS_QUERY_STANDARD                     = 0x00000000U,
    DNS_QUERY_ACCEPT_TRUNCATED_RESPONSE    = 0x00000001U,
    DNS_QUERY_USE_TCP_ONLY                 = 0x00000002U,
    DNS_QUERY_NO_RECURSION                 = 0x00000004U,
    DNS_QUERY_BYPASS_CACHE                 = 0x00000008U,
    DNS_QUERY_NO_WIRE_QUERY                = 0x00000010U,
    DNS_QUERY_NO_LOCAL_NAME                = 0x00000020U,
    DNS_QUERY_NO_HOSTS_FILE                = 0x00000040U,
    DNS_QUERY_NO_NETBT                     = 0x00000080U,
    DNS_QUERY_WIRE_ONLY                    = 0x00000100U,
    DNS_QUERY_RETURN_MESSAGE               = 0x00000200U,
    DNS_QUERY_MULTICAST_ONLY               = 0x00000400U,
    DNS_QUERY_NO_MULTICAST                 = 0x00000800U,
    DNS_QUERY_TREAT_AS_FQDN                = 0x00001000U,
    DNS_QUERY_ADDRCONFIG                   = 0x00002000U,
    DNS_QUERY_DUAL_ADDR                    = 0x00004000U,
    DNS_QUERY_DONT_RESET_TTL_VALUES        = 0x00100000U,
    DNS_QUERY_DISABLE_IDN_ENCODING         = 0x00200000U,
    DNS_QUERY_APPEND_MULTILABEL            = 0x00800000U,
    DNS_QUERY_DNSSEC_OK                    = 0x01000000U,
    DNS_QUERY_DNSSEC_CHECKING_DISABLED     = 0x02000000U,
    DNS_QUERY_DNSSEC_REQUIRED              = 0x04000000U,
    DNS_QUERY_RESERVED                     = 0xf0000000U,
    DNS_QUERY_CACHE_ONLY                   = 0x00000010U,
    DNS_QUERY_REQUEST_VERSION1             = 0x00000001U,
    DNS_QUERY_REQUEST_VERSION2             = 0x00000002U,
    DNS_QUERY_RESULTS_VERSION1             = 0x00000001U,
    DNS_QUERY_REQUEST_VERSION3             = 0x00000003U,
    DNS_QUERY_RAW_RESULTS_VERSION1         = 0x00000001U,
    DNS_QUERY_RAW_REQUEST_VERSION1         = 0x00000001U,
    DNS_QUERY_RAW_OPTION_BEST_EFFORT_PARSE = 0x00000001U,
}

alias DNS_SVCB_PARAM_TYPE = int;
enum : int
{
    DnsSvcbParamMandatory      = 0x00000000,
    DnsSvcbParamAlpn           = 0x00000001,
    DnsSvcbParamNoDefaultAlpn  = 0x00000002,
    DnsSvcbParamPort           = 0x00000003,
    DnsSvcbParamIpv4Hint       = 0x00000004,
    DnsSvcbParamEch            = 0x00000005,
    DnsSvcbParamIpv6Hint       = 0x00000006,
    DnsSvcbParamDohPath        = 0x00000007,
    DnsSvcbParamDohPathOpenDns = 0x0000ff98,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ne-windns-dns_section
alias DNS_SECTION = int;
enum : int
{
    DnsSectionQuestion  = 0x00000000,
    DnsSectionAnswer    = 0x00000001,
    DnsSectionAuthority = 0x00000002,
    DnsSectionAddtional = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ne-windns-dns_charset
alias DNS_CHARSET = int;
enum : int
{
    DnsCharSetUnknown = 0x00000000,
    DnsCharSetUnicode = 0x00000001,
    DnsCharSetUtf8    = 0x00000002,
    DnsCharSetAnsi    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ne-windns-dns_config_type
alias DNS_CONFIG_TYPE = int;
enum : int
{
    DnsConfigPrimaryDomainName_W                = 0x00000000,
    DnsConfigPrimaryDomainName_A                = 0x00000001,
    DnsConfigPrimaryDomainName_UTF8             = 0x00000002,
    DnsConfigAdapterDomainName_W                = 0x00000003,
    DnsConfigAdapterDomainName_A                = 0x00000004,
    DnsConfigAdapterDomainName_UTF8             = 0x00000005,
    DnsConfigDnsServerList                      = 0x00000006,
    DnsConfigSearchList                         = 0x00000007,
    DnsConfigAdapterInfo                        = 0x00000008,
    DnsConfigPrimaryHostNameRegistrationEnabled = 0x00000009,
    DnsConfigAdapterHostNameRegistrationEnabled = 0x0000000a,
    DnsConfigAddressRegistrationMaxCount        = 0x0000000b,
    DnsConfigHostName_W                         = 0x0000000c,
    DnsConfigHostName_A                         = 0x0000000d,
    DnsConfigHostName_UTF8                      = 0x0000000e,
    DnsConfigFullHostName_W                     = 0x0000000f,
    DnsConfigFullHostName_A                     = 0x00000010,
    DnsConfigFullHostName_UTF8                  = 0x00000011,
    DnsConfigNameServer                         = 0x00000012,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ne-windns-dns_proxy_information_type
alias DNS_PROXY_INFORMATION_TYPE = int;
enum : int
{
    DNS_PROXY_INFORMATION_DIRECT           = 0x00000000,
    DNS_PROXY_INFORMATION_DEFAULT_SETTINGS = 0x00000001,
    DNS_PROXY_INFORMATION_PROXY_NAME       = 0x00000002,
    DNS_PROXY_INFORMATION_DOES_NOT_EXIST   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ne-windns-dns_free_type
alias DNS_FREE_TYPE = int;
enum : int
{
    DnsFreeFlat                = 0x00000000,
    DnsFreeRecordList          = 0x00000001,
    DnsFreeParsedMessageFields = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ne-windns-dns_name_format
alias DNS_NAME_FORMAT = int;
enum : int
{
    DnsNameDomain        = 0x00000000,
    DnsNameDomainLabel   = 0x00000001,
    DnsNameHostnameFull  = 0x00000002,
    DnsNameHostnameLabel = 0x00000003,
    DnsNameWildcard      = 0x00000004,
    DnsNameSrvRecord     = 0x00000005,
    DnsNameValidateTld   = 0x00000006,
}

alias DNS_CONNECTION_PROXY_TYPE = int;
enum : int
{
    DNS_CONNECTION_PROXY_TYPE_NULL   = 0x00000000,
    DNS_CONNECTION_PROXY_TYPE_HTTP   = 0x00000001,
    DNS_CONNECTION_PROXY_TYPE_WAP    = 0x00000002,
    DNS_CONNECTION_PROXY_TYPE_SOCKS4 = 0x00000004,
    DNS_CONNECTION_PROXY_TYPE_SOCKS5 = 0x00000005,
}

alias DNS_CONNECTION_PROXY_INFO_SWITCH = int;
enum : int
{
    DNS_CONNECTION_PROXY_INFO_SWITCH_CONFIG = 0x00000000,
    DNS_CONNECTION_PROXY_INFO_SWITCH_SCRIPT = 0x00000001,
    DNS_CONNECTION_PROXY_INFO_SWITCH_WPAD   = 0x00000002,
}

alias DNS_CONNECTION_POLICY_TAG = int;
enum : int
{
    TAG_DNS_CONNECTION_POLICY_TAG_DEFAULT            = 0x00000000,
    TAG_DNS_CONNECTION_POLICY_TAG_CONNECTION_MANAGER = 0x00000001,
    TAG_DNS_CONNECTION_POLICY_TAG_WWWPT              = 0x00000002,
}

// Constants


enum uint SIZEOF_IP4_ADDRESS = 0x00000004U;

enum : uint
{
    IP4_ADDRESS_STRING_LENGTH        = 0x00000010U,
    IP4_ADDRESS_STRING_BUFFER_LENGTH = 0x00000010U,
}

enum uint DNS_ADDR_MAX_SOCKADDR_LENGTH = 0x00000020U;

enum : uint
{
    DNS_TYPE_ZERO       = 0x00000000U,
    DNS_TYPE_A          = 0x00000001U,
    DNS_TYPE_NS         = 0x00000002U,
    DNS_TYPE_MD         = 0x00000003U,
    DNS_TYPE_MF         = 0x00000004U,
    DNS_TYPE_CNAME      = 0x00000005U,
    DNS_TYPE_SOA        = 0x00000006U,
    DNS_TYPE_MB         = 0x00000007U,
    DNS_TYPE_MG         = 0x00000008U,
    DNS_TYPE_MR         = 0x00000009U,
    DNS_TYPE_NULL       = 0x0000000aU,
    DNS_TYPE_WKS        = 0x0000000bU,
    DNS_TYPE_PTR        = 0x0000000cU,
    DNS_TYPE_HINFO      = 0x0000000dU,
    DNS_TYPE_MINFO      = 0x0000000eU,
    DNS_TYPE_MX         = 0x0000000fU,
    DNS_TYPE_TEXT       = 0x00000010U,
    DNS_TYPE_RP         = 0x00000011U,
    DNS_TYPE_AFSDB      = 0x00000012U,
    DNS_TYPE_X25        = 0x00000013U,
    DNS_TYPE_ISDN       = 0x00000014U,
    DNS_TYPE_RT         = 0x00000015U,
    DNS_TYPE_NSAP       = 0x00000016U,
    DNS_TYPE_NSAPPTR    = 0x00000017U,
    DNS_TYPE_SIG        = 0x00000018U,
    DNS_TYPE_KEY        = 0x00000019U,
    DNS_TYPE_PX         = 0x0000001aU,
    DNS_TYPE_GPOS       = 0x0000001bU,
    DNS_TYPE_AAAA       = 0x0000001cU,
    DNS_TYPE_LOC        = 0x0000001dU,
    DNS_TYPE_NXT        = 0x0000001eU,
    DNS_TYPE_EID        = 0x0000001fU,
    DNS_TYPE_NIMLOC     = 0x00000020U,
    DNS_TYPE_SRV        = 0x00000021U,
    DNS_TYPE_ATMA       = 0x00000022U,
    DNS_TYPE_NAPTR      = 0x00000023U,
    DNS_TYPE_KX         = 0x00000024U,
    DNS_TYPE_CERT       = 0x00000025U,
    DNS_TYPE_A6         = 0x00000026U,
    DNS_TYPE_DNAME      = 0x00000027U,
    DNS_TYPE_SINK       = 0x00000028U,
    DNS_TYPE_OPT        = 0x00000029U,
    DNS_TYPE_DS         = 0x0000002bU,
    DNS_TYPE_RRSIG      = 0x0000002eU,
    DNS_TYPE_NSEC       = 0x0000002fU,
    DNS_TYPE_DNSKEY     = 0x00000030U,
    DNS_TYPE_DHCID      = 0x00000031U,
    DNS_TYPE_NSEC3      = 0x00000032U,
    DNS_TYPE_NSEC3PARAM = 0x00000033U,
    DNS_TYPE_TLSA       = 0x00000034U,
    DNS_TYPE_SVCB       = 0x00000040U,
    DNS_TYPE_HTTPS      = 0x00000041U,
    DNS_TYPE_UINFO      = 0x00000064U,
    DNS_TYPE_UID        = 0x00000065U,
    DNS_TYPE_GID        = 0x00000066U,
    DNS_TYPE_UNSPEC     = 0x00000067U,
    DNS_TYPE_ADDRS      = 0x000000f8U,
    DNS_TYPE_TKEY       = 0x000000f9U,
    DNS_TYPE_TSIG       = 0x000000faU,
    DNS_TYPE_IXFR       = 0x000000fbU,
    DNS_TYPE_AXFR       = 0x000000fcU,
    DNS_TYPE_MAILB      = 0x000000fdU,
    DNS_TYPE_MAILA      = 0x000000feU,
    DNS_TYPE_ALL        = 0x000000ffU,
    DNS_TYPE_ANY        = 0x000000ffU,
    DNS_TYPE_WINS       = 0x0000ff01U,
    DNS_TYPE_WINSR      = 0x0000ff02U,
    DNS_TYPE_NBSTAT     = 0x0000ff02U,
}

enum : uint
{
    DNS_RTYPE_A          = 0x00000100U,
    DNS_RTYPE_NS         = 0x00000200U,
    DNS_RTYPE_MD         = 0x00000300U,
    DNS_RTYPE_MF         = 0x00000400U,
    DNS_RTYPE_CNAME      = 0x00000500U,
    DNS_RTYPE_SOA        = 0x00000600U,
    DNS_RTYPE_MB         = 0x00000700U,
    DNS_RTYPE_MG         = 0x00000800U,
    DNS_RTYPE_MR         = 0x00000900U,
    DNS_RTYPE_NULL       = 0x00000a00U,
    DNS_RTYPE_WKS        = 0x00000b00U,
    DNS_RTYPE_PTR        = 0x00000c00U,
    DNS_RTYPE_HINFO      = 0x00000d00U,
    DNS_RTYPE_MINFO      = 0x00000e00U,
    DNS_RTYPE_MX         = 0x00000f00U,
    DNS_RTYPE_TEXT       = 0x00001000U,
    DNS_RTYPE_RP         = 0x00001100U,
    DNS_RTYPE_AFSDB      = 0x00001200U,
    DNS_RTYPE_X25        = 0x00001300U,
    DNS_RTYPE_ISDN       = 0x00001400U,
    DNS_RTYPE_RT         = 0x00001500U,
    DNS_RTYPE_NSAP       = 0x00001600U,
    DNS_RTYPE_NSAPPTR    = 0x00001700U,
    DNS_RTYPE_SIG        = 0x00001800U,
    DNS_RTYPE_KEY        = 0x00001900U,
    DNS_RTYPE_PX         = 0x00001a00U,
    DNS_RTYPE_GPOS       = 0x00001b00U,
    DNS_RTYPE_AAAA       = 0x00001c00U,
    DNS_RTYPE_LOC        = 0x00001d00U,
    DNS_RTYPE_NXT        = 0x00001e00U,
    DNS_RTYPE_EID        = 0x00001f00U,
    DNS_RTYPE_NIMLOC     = 0x00002000U,
    DNS_RTYPE_SRV        = 0x00002100U,
    DNS_RTYPE_ATMA       = 0x00002200U,
    DNS_RTYPE_NAPTR      = 0x00002300U,
    DNS_RTYPE_KX         = 0x00002400U,
    DNS_RTYPE_CERT       = 0x00002500U,
    DNS_RTYPE_A6         = 0x00002600U,
    DNS_RTYPE_DNAME      = 0x00002700U,
    DNS_RTYPE_SINK       = 0x00002800U,
    DNS_RTYPE_OPT        = 0x00002900U,
    DNS_RTYPE_DS         = 0x00002b00U,
    DNS_RTYPE_RRSIG      = 0x00002e00U,
    DNS_RTYPE_NSEC       = 0x00002f00U,
    DNS_RTYPE_DNSKEY     = 0x00003000U,
    DNS_RTYPE_DHCID      = 0x00003100U,
    DNS_RTYPE_NSEC3      = 0x00003200U,
    DNS_RTYPE_NSEC3PARAM = 0x00003300U,
    DNS_RTYPE_TLSA       = 0x00003400U,
    DNS_RTYPE_UINFO      = 0x00006400U,
    DNS_RTYPE_UID        = 0x00006500U,
    DNS_RTYPE_GID        = 0x00006600U,
    DNS_RTYPE_UNSPEC     = 0x00006700U,
    DNS_RTYPE_TKEY       = 0x0000f900U,
    DNS_RTYPE_TSIG       = 0x0000fa00U,
    DNS_RTYPE_IXFR       = 0x0000fb00U,
    DNS_RTYPE_AXFR       = 0x0000fc00U,
    DNS_RTYPE_MAILB      = 0x0000fd00U,
    DNS_RTYPE_MAILA      = 0x0000fe00U,
    DNS_RTYPE_ALL        = 0x0000ff00U,
    DNS_RTYPE_ANY        = 0x0000ff00U,
    DNS_RTYPE_WINS       = 0x000001ffU,
    DNS_RTYPE_WINSR      = 0x000002ffU,
}

enum : uint
{
    DNS_ATMA_FORMAT_E164     = 0x00000001U,
    DNS_ATMA_FORMAT_AESA     = 0x00000002U,
    DNS_ATMA_MAX_ADDR_LENGTH = 0x00000014U,
}

enum uint DNS_ATMA_AESA_ADDR_LENGTH = 0x00000014U;
enum uint DNS_ATMA_MAX_RECORD_LENGTH = 0x00000015U;

enum : uint
{
    DNSSEC_ALGORITHM_RSAMD5           = 0x00000001U,
    DNSSEC_ALGORITHM_RSASHA1          = 0x00000005U,
    DNSSEC_ALGORITHM_RSASHA1_NSEC3    = 0x00000007U,
    DNSSEC_ALGORITHM_RSASHA256        = 0x00000008U,
    DNSSEC_ALGORITHM_RSASHA512        = 0x0000000aU,
    DNSSEC_ALGORITHM_ECDSAP256_SHA256 = 0x0000000dU,
    DNSSEC_ALGORITHM_ECDSAP384_SHA384 = 0x0000000eU,
    DNSSEC_ALGORITHM_NULL             = 0x000000fdU,
    DNSSEC_ALGORITHM_PRIVATE          = 0x000000feU,
}

enum : uint
{
    DNSSEC_DIGEST_ALGORITHM_SHA1   = 0x00000001U,
    DNSSEC_DIGEST_ALGORITHM_SHA256 = 0x00000002U,
    DNSSEC_DIGEST_ALGORITHM_SHA384 = 0x00000004U,
}

enum : uint
{
    DNSSEC_PROTOCOL_NONE   = 0x00000000U,
    DNSSEC_PROTOCOL_TLS    = 0x00000001U,
    DNSSEC_PROTOCOL_EMAIL  = 0x00000002U,
    DNSSEC_PROTOCOL_DNSSEC = 0x00000003U,
    DNSSEC_PROTOCOL_IPSEC  = 0x00000004U,
}

enum : uint
{
    DNSSEC_KEY_FLAG_NOAUTH = 0x00000001U,
    DNSSEC_KEY_FLAG_NOCONF = 0x00000002U,
    DNSSEC_KEY_FLAG_FLAG2  = 0x00000004U,
    DNSSEC_KEY_FLAG_EXTEND = 0x00000008U,
    DNSSEC_KEY_FLAG_FLAG4  = 0x00000010U,
    DNSSEC_KEY_FLAG_FLAG5  = 0x00000020U,
    DNSSEC_KEY_FLAG_USER   = 0x00000000U,
    DNSSEC_KEY_FLAG_ZONE   = 0x00000040U,
    DNSSEC_KEY_FLAG_HOST   = 0x00000080U,
    DNSSEC_KEY_FLAG_NTPE3  = 0x000000c0U,
    DNSSEC_KEY_FLAG_FLAG8  = 0x00000100U,
    DNSSEC_KEY_FLAG_FLAG9  = 0x00000200U,
    DNSSEC_KEY_FLAG_FLAG10 = 0x00000400U,
    DNSSEC_KEY_FLAG_FLAG11 = 0x00000800U,
    DNSSEC_KEY_FLAG_SIG0   = 0x00000000U,
    DNSSEC_KEY_FLAG_SIG1   = 0x00001000U,
    DNSSEC_KEY_FLAG_SIG2   = 0x00002000U,
    DNSSEC_KEY_FLAG_SIG3   = 0x00003000U,
    DNSSEC_KEY_FLAG_SIG4   = 0x00004000U,
    DNSSEC_KEY_FLAG_SIG5   = 0x00005000U,
    DNSSEC_KEY_FLAG_SIG6   = 0x00006000U,
    DNSSEC_KEY_FLAG_SIG7   = 0x00007000U,
    DNSSEC_KEY_FLAG_SIG8   = 0x00008000U,
    DNSSEC_KEY_FLAG_SIG9   = 0x00009000U,
    DNSSEC_KEY_FLAG_SIG10  = 0x0000a000U,
    DNSSEC_KEY_FLAG_SIG11  = 0x0000b000U,
    DNSSEC_KEY_FLAG_SIG12  = 0x0000c000U,
    DNSSEC_KEY_FLAG_SIG13  = 0x0000d000U,
    DNSSEC_KEY_FLAG_SIG14  = 0x0000e000U,
    DNSSEC_KEY_FLAG_SIG15  = 0x0000f000U,
}

enum : uint
{
    DNS_TKEY_MODE_SERVER_ASSIGN   = 0x00000001U,
    DNS_TKEY_MODE_DIFFIE_HELLMAN  = 0x00000002U,
    DNS_TKEY_MODE_GSS             = 0x00000003U,
    DNS_TKEY_MODE_RESOLVER_ASSIGN = 0x00000004U,
}

enum uint DDR_MAX_IP_HINTS = 0x00000004U;

enum : uint
{
    DNSREC_SECTION    = 0x00000003U,
    DNSREC_QUESTION   = 0x00000000U,
    DNSREC_ANSWER     = 0x00000001U,
    DNSREC_AUTHORITY  = 0x00000002U,
    DNSREC_ADDITIONAL = 0x00000003U,
    DNSREC_ZONE       = 0x00000000U,
    DNSREC_PREREQ     = 0x00000001U,
    DNSREC_UPDATE     = 0x00000002U,
    DNSREC_DELETE     = 0x00000004U,
    DNSREC_NOEXIST    = 0x00000004U,
}

enum uint DNS_RFC_MAX_UDP_PACKET_LENGTH = 0x00000200U;

enum : uint
{
    DNS_MAX_NAME_LENGTH  = 0x000000ffU,
    DNS_MAX_LABEL_LENGTH = 0x0000003fU,
}

enum uint DNS_MAX_NAME_BUFFER_LENGTH = 0x00000100U;
enum uint DNS_MAX_LABEL_BUFFER_LENGTH = 0x00000040U;

enum : uint
{
    DNS_CUSTOM_SERVER_TYPE_UDP                        = 0x00000001U,
    DNS_CUSTOM_SERVER_TYPE_DOH                        = 0x00000002U,
    DNS_CUSTOM_SERVER_TYPE_DOT                        = 0x00000003U,
    DNS_CUSTOM_SERVER_UDP_FALLBACK                    = 0x00000001U,
    DNS_CUSTOM_SERVER_UPGRADE_FROM_WELL_KNOWN_SERVERS = 0x00000002U,
}

enum : uint
{
    IP6_ADDRESS_STRING_LENGTH        = 0x00000041U,
    IP6_ADDRESS_STRING_BUFFER_LENGTH = 0x00000041U,
}

enum uint DNS_ADDRESS_STRING_LENGTH = 0x00000041U;

enum : uint
{
    DNS_PORT_HOST_ORDER = 0x00000035U,
    DNS_PORT_NET_ORDER  = 0x00003500U,
}

enum : uint
{
    INTERNET_DEFAULT_DNS_PORT = 0x00000035U,
    INTERNET_DEFAULT_DOT_PORT = 0x00000355U,
}

enum uint DNS_MAX_IP4_REVERSE_NAME_LENGTH = 0x0000001fU;
enum uint DNS_MAX_IP6_REVERSE_NAME_LENGTH = 0x0000004bU;
enum uint DNS_MAX_REVERSE_NAME_LENGTH = 0x0000004bU;
enum uint DNS_MAX_IP4_REVERSE_NAME_BUFFER_LENGTH = 0x0000001fU;
enum uint DNS_MAX_IP6_REVERSE_NAME_BUFFER_LENGTH = 0x0000004bU;
enum uint DNS_MAX_REVERSE_NAME_BUFFER_LENGTH = 0x0000004bU;
enum uint DNS_MAX_TEXT_STRING_LENGTH = 0x000000ffU;
enum uint DNS_COMPRESSED_QUESTION_NAME = 0x0000c00cU;

enum : uint
{
    DNS_OPCODE_QUERY         = 0x00000000U,
    DNS_OPCODE_IQUERY        = 0x00000001U,
    DNS_OPCODE_SERVER_STATUS = 0x00000002U,
    DNS_OPCODE_UNKNOWN       = 0x00000003U,
    DNS_OPCODE_NOTIFY        = 0x00000004U,
    DNS_OPCODE_UPDATE        = 0x00000005U,
}

enum : uint
{
    DNS_RCODE_NOERROR         = 0x00000000U,
    DNS_RCODE_FORMERR         = 0x00000001U,
    DNS_RCODE_SERVFAIL        = 0x00000002U,
    DNS_RCODE_NXDOMAIN        = 0x00000003U,
    DNS_RCODE_NOTIMPL         = 0x00000004U,
    DNS_RCODE_REFUSED         = 0x00000005U,
    DNS_RCODE_YXDOMAIN        = 0x00000006U,
    DNS_RCODE_YXRRSET         = 0x00000007U,
    DNS_RCODE_NXRRSET         = 0x00000008U,
    DNS_RCODE_NOTAUTH         = 0x00000009U,
    DNS_RCODE_NOTZONE         = 0x0000000aU,
    DNS_RCODE_MAX             = 0x0000000fU,
    DNS_RCODE_BADVERS         = 0x00000010U,
    DNS_RCODE_BADSIG          = 0x00000010U,
    DNS_RCODE_BADKEY          = 0x00000011U,
    DNS_RCODE_BADTIME         = 0x00000012U,
    DNS_RCODE_NO_ERROR        = 0x00000000U,
    DNS_RCODE_FORMAT_ERROR    = 0x00000001U,
    DNS_RCODE_SERVER_FAILURE  = 0x00000002U,
    DNS_RCODE_NAME_ERROR      = 0x00000003U,
    DNS_RCODE_NOT_IMPLEMENTED = 0x00000004U,
}

enum : uint
{
    DNS_CLASS_INTERNET         = 0x00000001U,
    DNS_CLASS_CSNET            = 0x00000002U,
    DNS_CLASS_CHAOS            = 0x00000003U,
    DNS_CLASS_HESIOD           = 0x00000004U,
    DNS_CLASS_NONE             = 0x000000feU,
    DNS_CLASS_ALL              = 0x000000ffU,
    DNS_CLASS_ANY              = 0x000000ffU,
    DNS_CLASS_UNICAST_RESPONSE = 0x00008000U,
}

enum : uint
{
    DNS_RCLASS_INTERNET         = 0x00000100U,
    DNS_RCLASS_CSNET            = 0x00000200U,
    DNS_RCLASS_CHAOS            = 0x00000300U,
    DNS_RCLASS_HESIOD           = 0x00000400U,
    DNS_RCLASS_NONE             = 0x0000fe00U,
    DNS_RCLASS_ALL              = 0x0000ff00U,
    DNS_RCLASS_ANY              = 0x0000ff00U,
    DNS_RCLASS_UNICAST_RESPONSE = 0x00000080U,
    DNS_RCLASS_MDNS_CACHE_FLUSH = 0x00000080U,
}

enum : uint
{
    DNS_WINS_FLAG_SCOPE = 0x80000000U,
    DNS_WINS_FLAG_LOCAL = 0x00010000U,
}

enum uint DNS_CONFIG_FLAG_ALLOC = 0x00000001U;

enum : uint
{
    DNS_APP_SETTINGS_VERSION1          = 0x00000001U,
    DNS_APP_SETTINGS_EXCLUSIVE_SERVERS = 0x00000001U,
}

enum : uint
{
    DNS_PROTOCOL_UNSPECIFIED = 0x00000000U,
    DNS_PROTOCOL_UDP         = 0x00000001U,
    DNS_PROTOCOL_TCP         = 0x00000002U,
    DNS_PROTOCOL_DOH         = 0x00000003U,
    DNS_PROTOCOL_DOT         = 0x00000004U,
    DNS_PROTOCOL_NO_WIRE     = 0x00000005U,
}

enum : uint
{
    DNS_UPDATE_SECURITY_USE_DEFAULT   = 0x00000000U,
    DNS_UPDATE_SECURITY_OFF           = 0x00000010U,
    DNS_UPDATE_SECURITY_ON            = 0x00000020U,
    DNS_UPDATE_SECURITY_ONLY          = 0x00000100U,
    DNS_UPDATE_CACHE_SECURITY_CONTEXT = 0x00000200U,
}

enum uint DNS_UPDATE_TEST_USE_LOCAL_SYS_ACCT = 0x00000400U;
enum uint DNS_UPDATE_FORCE_SECURITY_NEGO = 0x00000800U;
enum uint DNS_UPDATE_TRY_ALL_MASTER_SERVERS = 0x00001000U;
enum uint DNS_UPDATE_SKIP_NO_UPDATE_ADAPTERS = 0x00002000U;

enum : uint
{
    DNS_UPDATE_REMOTE_SERVER = 0x00004000U,
    DNS_UPDATE_RESERVED      = 0xffff0000U,
}

enum : uint
{
    DNS_VALSVR_ERROR_INVALID_ADDR = 0x00000001U,
    DNS_VALSVR_ERROR_INVALID_NAME = 0x00000002U,
    DNS_VALSVR_ERROR_UNREACHABLE  = 0x00000003U,
    DNS_VALSVR_ERROR_NO_RESPONSE  = 0x00000004U,
    DNS_VALSVR_ERROR_NO_AUTH      = 0x00000005U,
    DNS_VALSVR_ERROR_REFUSED      = 0x00000006U,
    DNS_VALSVR_ERROR_NO_TCP       = 0x00000010U,
    DNS_VALSVR_ERROR_UNKNOWN      = 0x000000ffU,
}

enum : uint
{
    DNS_CONNECTION_NAME_MAX_LENGTH                     = 0x00000040U,
    DNS_CONNECTION_PROXY_INFO_CURRENT_VERSION          = 0x00000001U,
    DNS_CONNECTION_PROXY_INFO_SERVER_MAX_LENGTH        = 0x00000100U,
    DNS_CONNECTION_PROXY_INFO_FRIENDLY_NAME_MAX_LENGTH = 0x00000040U,
    DNS_CONNECTION_PROXY_INFO_USERNAME_MAX_LENGTH      = 0x00000080U,
    DNS_CONNECTION_PROXY_INFO_PASSWORD_MAX_LENGTH      = 0x00000080U,
    DNS_CONNECTION_PROXY_INFO_EXCEPTION_MAX_LENGTH     = 0x00000400U,
    DNS_CONNECTION_PROXY_INFO_EXTRA_INFO_MAX_LENGTH    = 0x00000400U,
    DNS_CONNECTION_PROXY_INFO_FLAG_DISABLED            = 0x00000001U,
    DNS_CONNECTION_PROXY_INFO_FLAG_BYPASSLOCAL         = 0x00000002U,
}

enum uint DNS_CONNECTION_POLICY_ENTRY_ONDEMAND = 0x00000001U;

// Callbacks

alias DNS_PROXY_COMPLETION_ROUTINE = void function(void* completionContext, int status);
alias PDNS_QUERY_COMPLETION_ROUTINE = void function(void* pQueryContext, DNS_QUERY_RESULT* pQueryResults);
alias DNS_QUERY_RAW_COMPLETION_ROUTINE = void function(void* queryContext, DNS_QUERY_RAW_RESULT* queryResults);
alias PDNS_SERVICE_BROWSE_CALLBACK = void function(uint Status, void* pQueryContext, DNS_RECORDW* pDnsRecord);
alias PDNS_SERVICE_RESOLVE_COMPLETE = void function(uint Status, void* pQueryContext, 
                                                    DNS_SERVICE_INSTANCE* pInstance);
alias PDNS_SERVICE_REGISTER_COMPLETE = void function(uint Status, void* pQueryContext, 
                                                     DNS_SERVICE_INSTANCE* pInstance);
alias PMDNS_QUERY_CALLBACK = void function(void* pQueryContext, MDNS_QUERY_HANDLE* pQueryHandle, 
                                           DNS_QUERY_RESULT* pQueryResults);

// Structs


version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-ip6_address
    union IP6_ADDRESS
    {
        ulong[2]  IP6Qword;
        uint[4]   IP6Dword;
        ushort[8] IP6Word;
        ubyte[16] IP6Byte;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-ip6_address
    union IP6_ADDRESS
    {
        ulong[2]  IP6Qword;
        uint[4]   IP6Dword;
        ushort[8] IP6Word;
        ubyte[16] IP6Byte;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-ip6_address
    union IP6_ADDRESS
    {
        uint[4]   IP6Dword;
        ushort[8] IP6Word;
        ubyte[16] IP6Byte;
    }
}

struct DNS_HEADER_EXT
{
    // Native bit field: Reserved: [0-14], DnssecOk: [15]
    ushort _bitfield0;
    ubyte  chRcode;
    ubyte  chVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_a_data
struct DNS_A_DATA
{
    uint IpAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_ptr_dataw
struct DNS_PTR_DATAW
{
    PWSTR pNameHost;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_ptr_dataa
struct DNS_PTR_DATAA
{
    PSTR pNameHost;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_soa_dataw
struct DNS_SOA_DATAW
{
    PWSTR pNamePrimaryServer;
    PWSTR pNameAdministrator;
    uint  dwSerialNo;
    uint  dwRefresh;
    uint  dwRetry;
    uint  dwExpire;
    uint  dwDefaultTtl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_soa_dataa
struct DNS_SOA_DATAA
{
    PSTR pNamePrimaryServer;
    PSTR pNameAdministrator;
    uint dwSerialNo;
    uint dwRefresh;
    uint dwRetry;
    uint dwExpire;
    uint dwDefaultTtl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_minfo_dataw
struct DNS_MINFO_DATAW
{
    PWSTR pNameMailbox;
    PWSTR pNameErrorsMailbox;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_minfo_dataa
struct DNS_MINFO_DATAA
{
    PSTR pNameMailbox;
    PSTR pNameErrorsMailbox;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_mx_dataw
struct DNS_MX_DATAW
{
    PWSTR  pNameExchange;
    ushort wPreference;
    ushort Pad;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_mx_dataa
struct DNS_MX_DATAA
{
    PSTR   pNameExchange;
    ushort wPreference;
    ushort Pad;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_txt_dataw
struct DNS_TXT_DATAW
{
    uint     dwStringCount;
    PWSTR[1] pStringArray; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_txt_dataa
struct DNS_TXT_DATAA
{
    uint    dwStringCount;
    PSTR[1] pStringArray; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_null_data
struct DNS_NULL_DATA
{
    uint     dwByteCount;
    ubyte[1] Data; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_wks_data
struct DNS_WKS_DATA
{
    uint     IpAddress;
    ubyte    chProtocol;
    ubyte[1] BitMask; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_aaaa_data
struct DNS_AAAA_DATA
{
    IP6_ADDRESS Ip6Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_sig_dataw
struct DNS_SIG_DATAW
{
    ushort   wTypeCovered;
    ubyte    chAlgorithm;
    ubyte    chLabelCount;
    uint     dwOriginalTtl;
    uint     dwExpiration;
    uint     dwTimeSigned;
    ushort   wKeyTag;
    ushort   wSignatureLength;
    PWSTR    pNameSigner;
    ubyte[1] Signature; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_sig_dataa
struct DNS_SIG_DATAA
{
    ushort   wTypeCovered;
    ubyte    chAlgorithm;
    ubyte    chLabelCount;
    uint     dwOriginalTtl;
    uint     dwExpiration;
    uint     dwTimeSigned;
    ushort   wKeyTag;
    ushort   wSignatureLength;
    PSTR     pNameSigner;
    ubyte[1] Signature; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_key_data
struct DNS_KEY_DATA
{
    ushort   wFlags;
    ubyte    chProtocol;
    ubyte    chAlgorithm;
    ushort   wKeyLength;
    ushort   wPad;
    ubyte[1] Key; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_dhcid_data
struct DNS_DHCID_DATA
{
    uint     dwByteCount;
    ubyte[1] DHCID; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_nsec_dataw
struct DNS_NSEC_DATAW
{
    PWSTR    pNextDomainName;
    ushort   wTypeBitMapsLength;
    ushort   wPad;
    ubyte[1] TypeBitMaps; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_nsec_dataa
struct DNS_NSEC_DATAA
{
    PSTR     pNextDomainName;
    ushort   wTypeBitMapsLength;
    ushort   wPad;
    ubyte[1] TypeBitMaps; // Flexible array
}

struct DNS_NSEC3_DATA
{
    ubyte    chAlgorithm;
    ubyte    bFlags;
    ushort   wIterations;
    ubyte    bSaltLength;
    ubyte    bHashLength;
    ushort   wTypeBitMapsLength;
    ubyte[1] chData; // Flexible array
}

struct DNS_NSEC3PARAM_DATA
{
    ubyte    chAlgorithm;
    ubyte    bFlags;
    ushort   wIterations;
    ubyte    bSaltLength;
    ubyte[3] bPad;
    ubyte[1] pbSalt; // Flexible array
}

struct DNS_TLSA_DATA
{
    ubyte    bCertUsage;
    ubyte    bSelector;
    ubyte    bMatchingType;
    ushort   bCertificateAssociationDataLength;
    ubyte[3] bPad;
    ubyte[1] bCertificateAssociationData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_ds_data
struct DNS_DS_DATA
{
    ushort   wKeyTag;
    ubyte    chAlgorithm;
    ubyte    chDigestType;
    ushort   wDigestLength;
    ushort   wPad;
    ubyte[1] Digest; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_opt_data
struct DNS_OPT_DATA
{
    ushort   wDataLength;
    ushort   wPad;
    ubyte[1] Data; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_loc_data
struct DNS_LOC_DATA
{
    ushort wVersion;
    ushort wSize;
    ushort wHorPrec;
    ushort wVerPrec;
    uint   dwLatitude;
    uint   dwLongitude;
    uint   dwAltitude;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_nxt_dataw
struct DNS_NXT_DATAW
{
    PWSTR     pNameNext;
    ushort    wNumTypes;
    ushort[1] wTypes; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_nxt_dataa
struct DNS_NXT_DATAA
{
    PSTR      pNameNext;
    ushort    wNumTypes;
    ushort[1] wTypes; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_srv_dataw
struct DNS_SRV_DATAW
{
    PWSTR  pNameTarget;
    ushort wPriority;
    ushort wWeight;
    ushort wPort;
    ushort Pad;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_srv_dataa
struct DNS_SRV_DATAA
{
    PSTR   pNameTarget;
    ushort wPriority;
    ushort wWeight;
    ushort wPort;
    ushort Pad;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_naptr_dataw
struct DNS_NAPTR_DATAW
{
    ushort wOrder;
    ushort wPreference;
    PWSTR  pFlags;
    PWSTR  pService;
    PWSTR  pRegularExpression;
    PWSTR  pReplacement;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_naptr_dataa
struct DNS_NAPTR_DATAA
{
    ushort wOrder;
    ushort wPreference;
    PSTR   pFlags;
    PSTR   pService;
    PSTR   pRegularExpression;
    PSTR   pReplacement;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_atma_data
struct DNS_ATMA_DATA
{
    ubyte     AddressType;
    ubyte[20] Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_tkey_dataw
struct DNS_TKEY_DATAW
{
    PWSTR  pNameAlgorithm;
    ubyte* pAlgorithmPacket;
    ubyte* pKey;
    ubyte* pOtherData;
    uint   dwCreateTime;
    uint   dwExpireTime;
    ushort wMode;
    ushort wError;
    ushort wKeyLength;
    ushort wOtherLength;
    ubyte  cAlgNameLength;
    BOOL   bPacketPointers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_tkey_dataa
struct DNS_TKEY_DATAA
{
    PSTR   pNameAlgorithm;
    ubyte* pAlgorithmPacket;
    ubyte* pKey;
    ubyte* pOtherData;
    uint   dwCreateTime;
    uint   dwExpireTime;
    ushort wMode;
    ushort wError;
    ushort wKeyLength;
    ushort wOtherLength;
    ubyte  cAlgNameLength;
    BOOL   bPacketPointers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_tsig_dataw
struct DNS_TSIG_DATAW
{
    PWSTR  pNameAlgorithm;
    ubyte* pAlgorithmPacket;
    ubyte* pSignature;
    ubyte* pOtherData;
    long   i64CreateTime;
    ushort wFudgeTime;
    ushort wOriginalXid;
    ushort wError;
    ushort wSigLength;
    ushort wOtherLength;
    ubyte  cAlgNameLength;
    BOOL   bPacketPointers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_tsig_dataa
struct DNS_TSIG_DATAA
{
    PSTR   pNameAlgorithm;
    ubyte* pAlgorithmPacket;
    ubyte* pSignature;
    ubyte* pOtherData;
    long   i64CreateTime;
    ushort wFudgeTime;
    ushort wOriginalXid;
    ushort wError;
    ushort wSigLength;
    ushort wOtherLength;
    ubyte  cAlgNameLength;
    BOOL   bPacketPointers;
}

struct DNS_UNKNOWN_DATA
{
    uint     dwByteCount;
    ubyte[1] bData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_wins_data
struct DNS_WINS_DATA
{
    uint    dwMappingFlag;
    uint    dwLookupTimeout;
    uint    dwCacheTimeout;
    uint    cWinsServerCount;
    uint[1] WinsServers; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_winsr_dataw
struct DNS_WINSR_DATAW
{
    uint  dwMappingFlag;
    uint  dwLookupTimeout;
    uint  dwCacheTimeout;
    PWSTR pNameResultDomain;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_winsr_dataa
struct DNS_WINSR_DATAA
{
    uint dwMappingFlag;
    uint dwLookupTimeout;
    uint dwCacheTimeout;
    PSTR pNameResultDomain;
}

struct DNS_SVCB_PARAM_MANDATORY
{
    ushort    cMandatoryKeys;
    ushort[1] rgwMandatoryKeys; // Flexible array
}

struct DNS_SVCB_PARAM_ALPN_ID
{
    ubyte  cBytes;
    ubyte* pbId;
}

struct DNS_SVCB_PARAM_ALPN
{
    ushort cIds;
    DNS_SVCB_PARAM_ALPN_ID[1] rgIds; // Flexible array
}

struct DNS_SVCB_PARAM_IPV4
{
    ushort  cIps;
    uint[1] rgIps; // Flexible array
}

struct DNS_SVCB_PARAM_IPV6
{
    ushort         cIps;
    IP6_ADDRESS[1] rgIps; // Flexible array
}

struct DNS_SVCB_PARAM_UNKNOWN
{
    ushort   cBytes;
    ubyte[1] pbSvcParamValue; // Flexible array
}

struct DNS_SVCB_PARAM
{
    ushort wSvcParamKey;
    union
    {
        DNS_SVCB_PARAM_IPV4* pIpv4Hints;
        DNS_SVCB_PARAM_IPV6* pIpv6Hints;
        DNS_SVCB_PARAM_MANDATORY* pMandatory;
        DNS_SVCB_PARAM_ALPN* pAlpn;
        ushort               wPort;
        DNS_SVCB_PARAM_UNKNOWN* pUnknown;
        PSTR                 pszDohPath;
        void*                pReserved;
    }
}

struct DNS_SVCB_DATA
{
    ushort          wSvcPriority;
    PSTR            pszTargetName;
    ushort          cSvcParams;
    DNS_SVCB_PARAM* pSvcParams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_record_flags
struct DNS_RECORD_FLAGS
{
    // Native bit field: Section: [0-1], Delete: [2], CharSet: [3-4], Unused: [5-7], Reserved: [8-31]
    uint _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_recordw
struct DNS_RECORDW
{
    DNS_RECORDW* pNext;
    PWSTR        pName;
    ushort       wType;
    ushort       wDataLength;
    union Flags
    {
        uint             DW;
        DNS_RECORD_FLAGS S;
    }
    uint         dwTtl;
    uint         dwReserved;
    union Data
    {
        DNS_A_DATA          A;
        DNS_SOA_DATAW       SOA;
        DNS_SOA_DATAW       Soa;
        DNS_PTR_DATAW       PTR;
        DNS_PTR_DATAW       Ptr;
        DNS_PTR_DATAW       NS;
        DNS_PTR_DATAW       Ns;
        DNS_PTR_DATAW       CNAME;
        DNS_PTR_DATAW       Cname;
        DNS_PTR_DATAW       DNAME;
        DNS_PTR_DATAW       Dname;
        DNS_PTR_DATAW       MB;
        DNS_PTR_DATAW       Mb;
        DNS_PTR_DATAW       MD;
        DNS_PTR_DATAW       Md;
        DNS_PTR_DATAW       MF;
        DNS_PTR_DATAW       Mf;
        DNS_PTR_DATAW       MG;
        DNS_PTR_DATAW       Mg;
        DNS_PTR_DATAW       MR;
        DNS_PTR_DATAW       Mr;
        DNS_MINFO_DATAW     MINFO;
        DNS_MINFO_DATAW     Minfo;
        DNS_MINFO_DATAW     RP;
        DNS_MINFO_DATAW     Rp;
        DNS_MX_DATAW        MX;
        DNS_MX_DATAW        Mx;
        DNS_MX_DATAW        AFSDB;
        DNS_MX_DATAW        Afsdb;
        DNS_MX_DATAW        RT;
        DNS_MX_DATAW        Rt;
        DNS_TXT_DATAW       HINFO;
        DNS_TXT_DATAW       Hinfo;
        DNS_TXT_DATAW       ISDN;
        DNS_TXT_DATAW       Isdn;
        DNS_TXT_DATAW       TXT;
        DNS_TXT_DATAW       Txt;
        DNS_TXT_DATAW       X25;
        DNS_NULL_DATA       Null;
        DNS_WKS_DATA        WKS;
        DNS_WKS_DATA        Wks;
        DNS_AAAA_DATA       AAAA;
        DNS_KEY_DATA        KEY;
        DNS_KEY_DATA        Key;
        DNS_SIG_DATAW       SIG;
        DNS_SIG_DATAW       Sig;
        DNS_ATMA_DATA       ATMA;
        DNS_ATMA_DATA       Atma;
        DNS_NXT_DATAW       NXT;
        DNS_NXT_DATAW       Nxt;
        DNS_SRV_DATAW       SRV;
        DNS_SRV_DATAW       Srv;
        DNS_NAPTR_DATAW     NAPTR;
        DNS_NAPTR_DATAW     Naptr;
        DNS_OPT_DATA        OPT;
        DNS_OPT_DATA        Opt;
        DNS_DS_DATA         DS;
        DNS_DS_DATA         Ds;
        DNS_SIG_DATAW       RRSIG;
        DNS_SIG_DATAW       Rrsig;
        DNS_NSEC_DATAW      NSEC;
        DNS_NSEC_DATAW      Nsec;
        DNS_KEY_DATA        DNSKEY;
        DNS_KEY_DATA        Dnskey;
        DNS_TKEY_DATAW      TKEY;
        DNS_TKEY_DATAW      Tkey;
        DNS_TSIG_DATAW      TSIG;
        DNS_TSIG_DATAW      Tsig;
        DNS_WINS_DATA       WINS;
        DNS_WINS_DATA       Wins;
        DNS_WINSR_DATAW     WINSR;
        DNS_WINSR_DATAW     WinsR;
        DNS_WINSR_DATAW     NBSTAT;
        DNS_WINSR_DATAW     Nbstat;
        DNS_DHCID_DATA      DHCID;
        DNS_NSEC3_DATA      NSEC3;
        DNS_NSEC3_DATA      Nsec3;
        DNS_NSEC3PARAM_DATA NSEC3PARAM;
        DNS_NSEC3PARAM_DATA Nsec3Param;
        DNS_TLSA_DATA       TLSA;
        DNS_TLSA_DATA       Tlsa;
        DNS_SVCB_DATA       SVCB;
        DNS_SVCB_DATA       Svcb;
        DNS_UNKNOWN_DATA    UNKNOWN;
        DNS_UNKNOWN_DATA    Unknown;
        ubyte*              pDataPtr;
    }
}

struct DNS_RECORD_OPTW
{
    DNS_RECORDW*   pNext;
    PWSTR          pName;
    ushort         wType;
    ushort         wDataLength;
    union Flags
    {
        uint             DW;
        DNS_RECORD_FLAGS S;
    }
    DNS_HEADER_EXT ExtHeader;
    ushort         wPayloadSize;
    ushort         wReserved;
    union Data
    {
        DNS_OPT_DATA OPT;
        DNS_OPT_DATA Opt;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_recorda
struct DNS_RECORDA
{
    DNS_RECORDA* pNext;
    PSTR         pName;
    ushort       wType;
    ushort       wDataLength;
    union Flags
    {
        uint             DW;
        DNS_RECORD_FLAGS S;
    }
    uint         dwTtl;
    uint         dwReserved;
    union Data
    {
        DNS_A_DATA          A;
        DNS_SOA_DATAA       SOA;
        DNS_SOA_DATAA       Soa;
        DNS_PTR_DATAA       PTR;
        DNS_PTR_DATAA       Ptr;
        DNS_PTR_DATAA       NS;
        DNS_PTR_DATAA       Ns;
        DNS_PTR_DATAA       CNAME;
        DNS_PTR_DATAA       Cname;
        DNS_PTR_DATAA       DNAME;
        DNS_PTR_DATAA       Dname;
        DNS_PTR_DATAA       MB;
        DNS_PTR_DATAA       Mb;
        DNS_PTR_DATAA       MD;
        DNS_PTR_DATAA       Md;
        DNS_PTR_DATAA       MF;
        DNS_PTR_DATAA       Mf;
        DNS_PTR_DATAA       MG;
        DNS_PTR_DATAA       Mg;
        DNS_PTR_DATAA       MR;
        DNS_PTR_DATAA       Mr;
        DNS_MINFO_DATAA     MINFO;
        DNS_MINFO_DATAA     Minfo;
        DNS_MINFO_DATAA     RP;
        DNS_MINFO_DATAA     Rp;
        DNS_MX_DATAA        MX;
        DNS_MX_DATAA        Mx;
        DNS_MX_DATAA        AFSDB;
        DNS_MX_DATAA        Afsdb;
        DNS_MX_DATAA        RT;
        DNS_MX_DATAA        Rt;
        DNS_TXT_DATAA       HINFO;
        DNS_TXT_DATAA       Hinfo;
        DNS_TXT_DATAA       ISDN;
        DNS_TXT_DATAA       Isdn;
        DNS_TXT_DATAA       TXT;
        DNS_TXT_DATAA       Txt;
        DNS_TXT_DATAA       X25;
        DNS_NULL_DATA       Null;
        DNS_WKS_DATA        WKS;
        DNS_WKS_DATA        Wks;
        DNS_AAAA_DATA       AAAA;
        DNS_KEY_DATA        KEY;
        DNS_KEY_DATA        Key;
        DNS_SIG_DATAA       SIG;
        DNS_SIG_DATAA       Sig;
        DNS_ATMA_DATA       ATMA;
        DNS_ATMA_DATA       Atma;
        DNS_NXT_DATAA       NXT;
        DNS_NXT_DATAA       Nxt;
        DNS_SRV_DATAA       SRV;
        DNS_SRV_DATAA       Srv;
        DNS_NAPTR_DATAA     NAPTR;
        DNS_NAPTR_DATAA     Naptr;
        DNS_OPT_DATA        OPT;
        DNS_OPT_DATA        Opt;
        DNS_DS_DATA         DS;
        DNS_DS_DATA         Ds;
        DNS_SIG_DATAA       RRSIG;
        DNS_SIG_DATAA       Rrsig;
        DNS_NSEC_DATAA      NSEC;
        DNS_NSEC_DATAA      Nsec;
        DNS_KEY_DATA        DNSKEY;
        DNS_KEY_DATA        Dnskey;
        DNS_TKEY_DATAA      TKEY;
        DNS_TKEY_DATAA      Tkey;
        DNS_TSIG_DATAA      TSIG;
        DNS_TSIG_DATAA      Tsig;
        DNS_WINS_DATA       WINS;
        DNS_WINS_DATA       Wins;
        DNS_WINSR_DATAA     WINSR;
        DNS_WINSR_DATAA     WinsR;
        DNS_WINSR_DATAA     NBSTAT;
        DNS_WINSR_DATAA     Nbstat;
        DNS_DHCID_DATA      DHCID;
        DNS_NSEC3_DATA      NSEC3;
        DNS_NSEC3_DATA      Nsec3;
        DNS_NSEC3PARAM_DATA NSEC3PARAM;
        DNS_NSEC3PARAM_DATA Nsec3Param;
        DNS_TLSA_DATA       TLSA;
        DNS_TLSA_DATA       Tlsa;
        DNS_SVCB_DATA       SVCB;
        DNS_SVCB_DATA       Svcb;
        DNS_UNKNOWN_DATA    UNKNOWN;
        DNS_UNKNOWN_DATA    Unknown;
        ubyte*              pDataPtr;
    }
}

struct _DnsRecordOptA
{
    DNS_RECORDA*   pNext;
    PSTR           pName;
    ushort         wType;
    ushort         wDataLength;
    union Flags
    {
        uint             DW;
        DNS_RECORD_FLAGS S;
    }
    DNS_HEADER_EXT ExtHeader;
    ushort         wPayloadSize;
    ushort         wReserved;
    union Data
    {
        DNS_OPT_DATA OPT;
        DNS_OPT_DATA Opt;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_addr
struct DNS_ADDR
{
    CHAR[32] MaxSa;
    union Data
    {
    align (1):
        uint[8] DnsAddrUserDword;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_addr_array
struct DNS_ADDR_ARRAY
{
align (1):
    uint        MaxCount;
    uint        AddrCount;
    uint        Tag;
    ushort      Family;
    ushort      WordReserved;
    uint        Flags;
    uint        MatchFlag;
    uint        Reserved1;
    uint        Reserved2;
    DNS_ADDR[1] AddrArray; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_header
struct DNS_HEADER
{
align (1):
    ushort Xid;
    // Native bit field: RecursionDesired: [0], Truncation: [1], Authoritative: [2], Opcode: [3-6], IsResponse: [7]
    ubyte  _bitfield1;
    // Native bit field: ResponseCode: [0-3], CheckingDisabled: [4], AuthenticatedData: [5], Reserved: [6], RecursionAvailable: [7]
    ubyte  _bitfield2;
    ushort QuestionCount;
    ushort AnswerCount;
    ushort NameServerCount;
    ushort AdditionalCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_message_buffer
struct DNS_MESSAGE_BUFFER
{
    DNS_HEADER MessageHead;
    CHAR[1]    MessageBody; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_custom_server
struct DNS_CUSTOM_SERVER
{
    uint  dwServerType;
    ulong ullFlags;
    union
    {
        PWSTR pwszTemplate;
        PWSTR pwszHostname;
    }
    union
    {
        CHAR[32] MaxSa;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-ip4_array
struct IP4_ARRAY
{
    uint    AddrCount;
    uint[1] AddrArray; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_wire_question
struct DNS_WIRE_QUESTION
{
align (1):
    ushort QuestionType;
    ushort QuestionClass;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_wire_record
struct DNS_WIRE_RECORD
{
align (1):
    ushort RecordType;
    ushort RecordClass;
    uint   TimeToLive;
    ushort DataLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_rrset
struct DNS_RRSET
{
    DNS_RECORDA* pFirstRR;
    DNS_RECORDA* pLastRR;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_proxy_information
struct DNS_PROXY_INFORMATION
{
    uint  version_;
    DNS_PROXY_INFORMATION_TYPE proxyInformationType;
    PWSTR proxyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_query_result
struct DNS_QUERY_RESULT
{
    uint         Version;
    int          QueryStatus;
    ulong        QueryOptions;
    DNS_RECORDA* pQueryRecords;
    void*        Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_application_settings
struct DNS_APPLICATION_SETTINGS
{
    uint  Version;
    ulong Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_query_request
struct DNS_QUERY_REQUEST
{
    uint            Version;
    const(PWSTR)    QueryName;
    ushort          QueryType;
    ulong           QueryOptions;
    DNS_ADDR_ARRAY* pDnsServerList;
    uint            InterfaceIndex;
    PDNS_QUERY_COMPLETION_ROUTINE pQueryCompletionCallback;
    void*           pQueryContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_query_cancel
struct DNS_QUERY_CANCEL
{
    CHAR[32] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_query_request3
struct DNS_QUERY_REQUEST3
{
    uint               Version;
    const(PWSTR)       QueryName;
    ushort             QueryType;
    ulong              QueryOptions;
    DNS_ADDR_ARRAY*    pDnsServerList;
    uint               InterfaceIndex;
    PDNS_QUERY_COMPLETION_ROUTINE pQueryCompletionCallback;
    void*              pQueryContext;
    BOOL               IsNetworkQueryRequired;
    uint               RequiredNetworkIndex;
    uint               cCustomServers;
    DNS_CUSTOM_SERVER* pCustomServers;
}

struct DNS_QUERY_RAW_RESULT
{
    uint         version_;
    int          queryStatus;
    ulong        queryOptions;
    ulong        queryRawOptions;
    ulong        responseFlags;
    uint         queryRawResponseSize;
    ubyte*       queryRawResponse;
    DNS_RECORDA* queryRecords;
    uint         protocol;
    union
    {
        CHAR[32] maxSa;
    }
}

struct DNS_QUERY_RAW_REQUEST
{
    uint               version_;
    uint               resultsVersion;
    uint               dnsQueryRawSize;
    ubyte*             dnsQueryRaw;
    PWSTR              dnsQueryName;
    ushort             dnsQueryType;
    ulong              queryOptions;
    uint               interfaceIndex;
    DNS_QUERY_RAW_COMPLETION_ROUTINE queryCompletionCallback;
    void*              queryContext;
    ulong              queryRawOptions;
    uint               customServersSize;
    DNS_CUSTOM_SERVER* customServers;
    uint               protocol;
    union
    {
        CHAR[32] maxSa;
    }
}

struct DNS_QUERY_RAW_CANCEL
{
    CHAR[32] reserved;
}

struct DNS_CONNECTION_PROXY_INFO
{
    uint  Version;
    PWSTR pwszFriendlyName;
    uint  Flags;
    DNS_CONNECTION_PROXY_INFO_SWITCH Switch;
    union
    {
        struct Config
        {
            PWSTR  pwszServer;
            PWSTR  pwszUsername;
            PWSTR  pwszPassword;
            PWSTR  pwszException;
            PWSTR  pwszExtraInfo;
            ushort Port;
        }
        struct Script
        {
            PWSTR pwszScript;
            PWSTR pwszUsername;
            PWSTR pwszPassword;
        }
    }
}

struct DNS_CONNECTION_PROXY_INFO_EX
{
    DNS_CONNECTION_PROXY_INFO ProxyInfo;
    uint   dwInterfaceIndex;
    PWSTR  pwszConnectionName;
    BOOL   fDirectConfiguration;
    HANDLE hConnection;
}

struct DNS_CONNECTION_PROXY_ELEMENT
{
    DNS_CONNECTION_PROXY_TYPE Type;
    DNS_CONNECTION_PROXY_INFO Info;
}

struct DNS_CONNECTION_PROXY_LIST
{
    uint cProxies;
    DNS_CONNECTION_PROXY_ELEMENT* pProxies;
}

struct DNS_CONNECTION_NAME
{
    wchar[65] wszName;
}

struct DNS_CONNECTION_NAME_LIST
{
    uint                 cNames;
    DNS_CONNECTION_NAME* pNames;
}

struct DNS_CONNECTION_IFINDEX_ENTRY
{
    const(PWSTR) pwszConnectionName;
    uint         dwIfIndex;
}

struct DNS_CONNECTION_IFINDEX_LIST
{
    DNS_CONNECTION_IFINDEX_ENTRY* pConnectionIfIndexEntries;
    uint nEntries;
}

struct DNS_CONNECTION_POLICY_ENTRY
{
    const(PWSTR)  pwszHost;
    const(PWSTR)  pwszAppId;
    uint          cbAppSid;
    ubyte*        pbAppSid;
    uint          nConnections;
    const(PWSTR)* ppwszConnections;
    uint          dwPolicyEntryFlags;
}

struct DNS_CONNECTION_POLICY_ENTRY_LIST
{
    DNS_CONNECTION_POLICY_ENTRY* pPolicyEntries;
    uint nEntries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_service_instance
struct DNS_SERVICE_INSTANCE
{
    PWSTR        pszInstanceName;
    PWSTR        pszHostName;
    uint*        ip4Address;
    IP6_ADDRESS* ip6Address;
    ushort       wPort;
    ushort       wPriority;
    ushort       wWeight;
    uint         dwPropertyCount;
    PWSTR*       keys;
    PWSTR*       values;
    uint         dwInterfaceIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_service_cancel
struct DNS_SERVICE_CANCEL
{
    void* reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_service_browse_request
struct DNS_SERVICE_BROWSE_REQUEST
{
    uint         Version;
    uint         InterfaceIndex;
    const(PWSTR) QueryName;
    union
    {
        PDNS_SERVICE_BROWSE_CALLBACK pBrowseCallback;
        PDNS_QUERY_COMPLETION_ROUTINE pBrowseCallbackV2;
    }
    void*        pQueryContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_service_resolve_request
struct DNS_SERVICE_RESOLVE_REQUEST
{
    uint  Version;
    uint  InterfaceIndex;
    PWSTR QueryName;
    PDNS_SERVICE_RESOLVE_COMPLETE pResolveCompletionCallback;
    void* pQueryContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-dns_service_register_request
struct DNS_SERVICE_REGISTER_REQUEST
{
    uint   Version;
    uint   InterfaceIndex;
    DNS_SERVICE_INSTANCE* pServiceInstance;
    PDNS_SERVICE_REGISTER_COMPLETE pRegisterCompletionCallback;
    void*  pQueryContext;
    HANDLE hCredentials;
    BOOL   unicastEnabled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-mdns_query_handle
struct MDNS_QUERY_HANDLE
{
    wchar[256] nameBuf;
    ushort     wType;
    void*      pSubscription;
    void*      pWnfCallbackParams;
    uint[2]    stateNameData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/ns-windns-mdns_query_request
struct MDNS_QUERY_REQUEST
{
    uint                 Version;
    uint                 ulRefCount;
    const(PWSTR)         Query;
    ushort               QueryType;
    ulong                QueryOptions;
    uint                 InterfaceIndex;
    PMDNS_QUERY_CALLBACK pQueryCallback;
    void*                pQueryContext;
    BOOL                 fAnswerReceived;
    uint                 ulResendCount;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsQueryConfig(DNS_CONFIG_TYPE Config, uint Flag, const(PWSTR) pwsAdapterName, void* pReserved, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pBuffer, 
                   uint* pBufLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
DNS_RECORDA* DnsRecordCopyEx(DNS_RECORDA* pRecord, DNS_CHARSET CharSetIn, DNS_CHARSET CharSetOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
DNS_RECORDA* DnsRecordSetCopyEx(DNS_RECORDA* pRecordSet, DNS_CHARSET CharSetIn, DNS_CHARSET CharSetOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
BOOL DnsRecordCompare(DNS_RECORDA* pRecord1, DNS_RECORDA* pRecord2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
BOOL DnsRecordSetCompare(DNS_RECORDA* pRR1, DNS_RECORDA* pRR2, DNS_RECORDA** ppDiff1, DNS_RECORDA** ppDiff2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
DNS_RECORDA* DnsRecordSetDetach(DNS_RECORDA* pRecordList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("DNSAPI.dll")
void DnsFree(void* pData, DNS_FREE_TYPE FreeType);

@DllImport("DNSAPI.dll")
int DnsIsFlatRecord(DNS_RECORDA* pRecord, ulong ullFlags, BOOL* pfFlat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
WIN32_ERROR DnsQuery_A(const(PSTR) pszName, ushort wType, DNS_QUERY_OPTIONS Options, void* pExtra, 
                       DNS_RECORDA** ppQueryResults, void** pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
WIN32_ERROR DnsQuery_UTF8(const(PSTR) pszName, ushort wType, DNS_QUERY_OPTIONS Options, void* pExtra, 
                          DNS_RECORDA** ppQueryResults, void** pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
WIN32_ERROR DnsQuery_W(const(PWSTR) pszName, ushort wType, DNS_QUERY_OPTIONS Options, void* pExtra, 
                       DNS_RECORDA** ppQueryResults, void** pReserved);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/nf-windns-dnsfreecustomservers
@DllImport("DNSAPI.dll")
void DnsFreeCustomServers(uint* pcServers, DNS_CUSTOM_SERVER** ppServers);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/nf-windns-dnsgetapplicationsettings
@DllImport("DNSAPI.dll")
uint DnsGetApplicationSettings(uint* pcServers, DNS_CUSTOM_SERVER** ppDefaultServers, 
                               DNS_APPLICATION_SETTINGS* pSettings);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windns/nf-windns-dnssetapplicationsettings
@DllImport("DNSAPI.dll")
uint DnsSetApplicationSettings(uint cServers, const(DNS_CUSTOM_SERVER)* pServers, 
                               const(DNS_APPLICATION_SETTINGS)* pSettings);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("DNSAPI.dll")
int DnsQueryEx(DNS_QUERY_REQUEST* pQueryRequest, DNS_QUERY_RESULT* pQueryResults, DNS_QUERY_CANCEL* pCancelHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("DNSAPI.dll")
int DnsCancelQuery(DNS_QUERY_CANCEL* pCancelHandle);

@DllImport("DNSAPI.dll")
void DnsQueryRawResultFree(DNS_QUERY_RAW_RESULT* queryResults);

@DllImport("DNSAPI.dll")
int DnsQueryRaw(DNS_QUERY_RAW_REQUEST* queryRequest, DNS_QUERY_RAW_CANCEL* cancelHandle);

@DllImport("DNSAPI.dll")
int DnsCancelQueryRaw(DNS_QUERY_RAW_CANCEL* cancelHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsAcquireContextHandle_W(uint CredentialFlags, void* Credentials, 
                              /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DnsReleaseContextHandle))], [])*/HANDLE* pContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsAcquireContextHandle_A(uint CredentialFlags, void* Credentials, 
                              /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DnsReleaseContextHandle))], [])*/HANDLE* pContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
void DnsReleaseContextHandle(HANDLE hContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsModifyRecordsInSet_W(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, 
                            HANDLE hCredentials, void* pExtraList, void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsModifyRecordsInSet_A(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, 
                            HANDLE hCredentials, void* pExtraList, void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsModifyRecordsInSet_UTF8(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, 
                               HANDLE hCredentials, void* pExtraList, void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsReplaceRecordSetW(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, 
                         void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsReplaceRecordSetA(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, 
                         void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsReplaceRecordSetUTF8(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, 
                            void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsValidateName_W(const(PWSTR) pszName, DNS_NAME_FORMAT Format);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsValidateName_A(const(PSTR) pszName, DNS_NAME_FORMAT Format);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsValidateName_UTF8(const(PSTR) pszName, DNS_NAME_FORMAT Format);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
BOOL DnsNameCompare_A(const(PSTR) pName1, const(PSTR) pName2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
BOOL DnsNameCompare_W(const(PWSTR) pName1, const(PWSTR) pName2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
BOOL DnsWriteQuestionToBuffer_W(DNS_MESSAGE_BUFFER* pDnsBuffer, uint* pdwBufferSize, const(PWSTR) pszName, 
                                ushort wType, ushort Xid, BOOL fRecursionDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
BOOL DnsWriteQuestionToBuffer_UTF8(DNS_MESSAGE_BUFFER* pDnsBuffer, uint* pdwBufferSize, const(PSTR) pszName, 
                                   ushort wType, ushort Xid, BOOL fRecursionDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsExtractRecordsFromMessage_W(DNS_MESSAGE_BUFFER* pDnsBuffer, ushort wMessageLength, DNS_RECORDA** ppRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DNSAPI.dll")
int DnsExtractRecordsFromMessage_UTF8(DNS_MESSAGE_BUFFER* pDnsBuffer, ushort wMessageLength, 
                                      DNS_RECORDA** ppRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("DNSAPI.dll")
uint DnsGetProxyInformation(const(PWSTR) hostName, DNS_PROXY_INFORMATION* proxyInformation, 
                            DNS_PROXY_INFORMATION* defaultProxyInformation, 
                            DNS_PROXY_COMPLETION_ROUTINE completionRoutine, void* completionContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("DNSAPI.dll")
void DnsFreeProxyName(PWSTR proxyName);

@DllImport("DNSAPI.dll")
uint DnsConnectionGetProxyInfoForHostUrl(const(PWSTR) pwszHostUrl, ubyte* pSelectionContext, 
                                         uint dwSelectionContextLength, uint dwExplicitInterfaceIndex, 
                                         DNS_CONNECTION_PROXY_INFO_EX* pProxyInfoEx);

@DllImport("DNSAPI.dll")
uint DnsConnectionGetProxyInfoForHostUrlEx(const(PWSTR) pwszHostUrl, ubyte* pSelectionContext, 
                                           uint dwSelectionContextLength, uint dwExplicitInterfaceIndex, 
                                           const(PWSTR) pwszConnectionName, 
                                           DNS_CONNECTION_PROXY_INFO_EX* pProxyInfoEx);

@DllImport("DNSAPI.dll")
void DnsConnectionFreeProxyInfoEx(DNS_CONNECTION_PROXY_INFO_EX* pProxyInfoEx);

@DllImport("DNSAPI.dll")
uint DnsConnectionGetProxyInfo(const(PWSTR) pwszConnectionName, DNS_CONNECTION_PROXY_TYPE Type, 
                               DNS_CONNECTION_PROXY_INFO* pProxyInfo);

@DllImport("DNSAPI.dll")
void DnsConnectionFreeProxyInfo(DNS_CONNECTION_PROXY_INFO* pProxyInfo);

@DllImport("DNSAPI.dll")
uint DnsConnectionSetProxyInfo(const(PWSTR) pwszConnectionName, DNS_CONNECTION_PROXY_TYPE Type, 
                               const(DNS_CONNECTION_PROXY_INFO)* pProxyInfo);

@DllImport("DNSAPI.dll")
uint DnsConnectionDeleteProxyInfo(const(PWSTR) pwszConnectionName, DNS_CONNECTION_PROXY_TYPE Type);

@DllImport("DNSAPI.dll")
uint DnsConnectionGetProxyList(const(PWSTR) pwszConnectionName, DNS_CONNECTION_PROXY_LIST* pProxyList);

@DllImport("DNSAPI.dll")
void DnsConnectionFreeProxyList(DNS_CONNECTION_PROXY_LIST* pProxyList);

@DllImport("DNSAPI.dll")
uint DnsConnectionGetNameList(DNS_CONNECTION_NAME_LIST* pNameList);

@DllImport("DNSAPI.dll")
void DnsConnectionFreeNameList(DNS_CONNECTION_NAME_LIST* pNameList);

@DllImport("DNSAPI.dll")
uint DnsConnectionUpdateIfIndexTable(DNS_CONNECTION_IFINDEX_LIST* pConnectionIfIndexEntries);

@DllImport("DNSAPI.dll")
uint DnsConnectionSetPolicyEntries(DNS_CONNECTION_POLICY_TAG PolicyEntryTag, 
                                   DNS_CONNECTION_POLICY_ENTRY_LIST* pPolicyEntryList);

@DllImport("DNSAPI.dll")
uint DnsConnectionDeletePolicyEntries(DNS_CONNECTION_POLICY_TAG PolicyEntryTag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
DNS_SERVICE_INSTANCE* DnsServiceConstructInstance(const(PWSTR) pServiceName, const(PWSTR) pHostName, uint* pIp4, 
                                                  IP6_ADDRESS* pIp6, ushort wPort, ushort wPriority, ushort wWeight, 
                                                  uint dwPropertiesCount, const(PWSTR)* keys, const(PWSTR)* values);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
DNS_SERVICE_INSTANCE* DnsServiceCopyInstance(DNS_SERVICE_INSTANCE* pOrig);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
void DnsServiceFreeInstance(DNS_SERVICE_INSTANCE* pInstance);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
int DnsServiceBrowse(DNS_SERVICE_BROWSE_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
int DnsServiceBrowseCancel(DNS_SERVICE_CANCEL* pCancelHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
int DnsServiceResolve(DNS_SERVICE_RESOLVE_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
int DnsServiceResolveCancel(DNS_SERVICE_CANCEL* pCancelHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
uint DnsServiceRegister(DNS_SERVICE_REGISTER_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
uint DnsServiceDeRegister(DNS_SERVICE_REGISTER_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
uint DnsServiceRegisterCancel(DNS_SERVICE_CANCEL* pCancelHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
int DnsStartMulticastQuery(MDNS_QUERY_REQUEST* pQueryRequest, MDNS_QUERY_HANDLE* pHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DNSAPI.dll")
int DnsStopMulticastQuery(MDNS_QUERY_HANDLE* pHandle);


