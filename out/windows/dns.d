// Written in the D programming language.

module windows.dns;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


///The <b>DNS_CONFIG_TYPE</b> enumeration provides DNS configuration type information.
alias DNS_CONFIG_TYPE = int;
enum : int
{
    ///For use with Unicode on Windows 2000.
    DnsConfigPrimaryDomainName_W                = 0x00000000,
    ///For use with ANSI on Windows 2000.
    DnsConfigPrimaryDomainName_A                = 0x00000001,
    ///For use with UTF8 on Windows 2000.
    DnsConfigPrimaryDomainName_UTF8             = 0x00000002,
    ///Not currently available.
    DnsConfigAdapterDomainName_W                = 0x00000003,
    ///Not currently available.
    DnsConfigAdapterDomainName_A                = 0x00000004,
    ///Not currently available.
    DnsConfigAdapterDomainName_UTF8             = 0x00000005,
    ///For configuring a DNS Server list on Windows 2000.
    DnsConfigDnsServerList                      = 0x00000006,
    ///Not currently available.
    DnsConfigSearchList                         = 0x00000007,
    ///Not currently available.
    DnsConfigAdapterInfo                        = 0x00000008,
    ///Specifies that primary host name registration is enabled on Windows 2000.
    DnsConfigPrimaryHostNameRegistrationEnabled = 0x00000009,
    ///Specifies that adapter host name registration is enabled on Windows 2000.
    DnsConfigAdapterHostNameRegistrationEnabled = 0x0000000a,
    ///Specifies configuration of the maximum number of address registrations on Windows 2000.
    DnsConfigAddressRegistrationMaxCount        = 0x0000000b,
    ///Specifies configuration of the host name in Unicode on Windows XP, Windows Server 2003, and later versions of
    ///Windows.
    DnsConfigHostName_W                         = 0x0000000c,
    ///Specifies configuration of the host name in ANSI on Windows XP, Windows Server 2003, and later versions of
    ///Windows.
    DnsConfigHostName_A                         = 0x0000000d,
    ///Specifies configuration of the host name in UTF8 on Windows XP, Windows Server 2003, and later versions of
    ///Windows.
    DnsConfigHostName_UTF8                      = 0x0000000e,
    ///Specifies configuration of the full host name (fully qualified domain name) in Unicode on Windows XP, Windows
    ///Server 2003, and later versions of Windows.
    DnsConfigFullHostName_W                     = 0x0000000f,
    ///Specifies configuration of the full host name (fully qualified domain name) in ANSI on Windows XP, Windows Server
    ///2003, and later versions of Windows.
    DnsConfigFullHostName_A                     = 0x00000010,
    ///Specifies configuration of the full host name (fully qualified domain name) in UTF8 on Windows XP, Windows Server
    ///2003, and later versions of Windows.
    DnsConfigFullHostName_UTF8                  = 0x00000011,
    DnsConfigNameServer                         = 0x00000012,
}

///The <b>DNS_SECTION</b> enumeration is used in record flags, and as an index into DNS wire message header section
///counts.
alias DNS_SECTION = int;
enum : int
{
    ///The DNS section specified is a DNS question.
    DnsSectionQuestion  = 0x00000000,
    ///The DNS section specified is a DNS answer.
    DnsSectionAnswer    = 0x00000001,
    ///The DNS section specified indicates a DNS authority.
    DnsSectionAuthority = 0x00000002,
    ///The DNS section specified is additional DNS information.
    DnsSectionAddtional = 0x00000003,
}

///The <b>DNS_PROXY_INFORMATION_TYPE</b> enumeration defines the proxy information type in the DNS_PROXY_INFORMATION
///structure.
alias DNS_PROXY_INFORMATION_TYPE = int;
enum : int
{
    ///The type is bypass proxy information.
    DNS_PROXY_INFORMATION_DIRECT           = 0x00000000,
    ///The type is the user's default browser proxy settings.
    DNS_PROXY_INFORMATION_DEFAULT_SETTINGS = 0x00000001,
    ///The type is defined by the <b>proxyName</b> member of the DNS_PROXY_INFORMATION structure.
    DNS_PROXY_INFORMATION_PROXY_NAME       = 0x00000002,
    ///The type does not exist. DNS policy does not have proxy information for this name space. This type is used if no
    ///wildcard policy exists and there is no default proxy information.
    DNS_PROXY_INFORMATION_DOES_NOT_EXIST   = 0x00000003,
}

///The <b>DNS_CHARSET</b> enumeration specifies the character set used.
alias DNS_CHARSET = int;
enum : int
{
    ///The character set is unknown.
    DnsCharSetUnknown = 0x00000000,
    ///The character set is Unicode.
    DnsCharSetUnicode = 0x00000001,
    ///The character set is UTF8.
    DnsCharSetUtf8    = 0x00000002,
    ///The character set is ANSI.
    DnsCharSetAnsi    = 0x00000003,
}

///The <b>DNS_FREE_TYPE</b> enumeration specifies the type of data to free.
alias DNS_FREE_TYPE = int;
enum : int
{
    ///The data freed is a flat structure.
    DnsFreeFlat                = 0x00000000,
    ///The data freed is a Resource Record list, and includes subfields of the DNS_RECORD structure. Resources freed
    ///include structures returned by the DnsQuery and DnsRecordSetCopyEx functions.
    DnsFreeRecordList          = 0x00000001,
    ///The data freed is a parsed message field.
    DnsFreeParsedMessageFields = 0x00000002,
}

///The <b>DNS_NAME_FORMAT</b> enumeration specifies name format information for DNS.
alias DNS_NAME_FORMAT = int;
enum : int
{
    ///The name format is a DNS domain.
    DnsNameDomain        = 0x00000000,
    ///The name format is a DNS domain label.
    DnsNameDomainLabel   = 0x00000001,
    ///The name format is a full DNS host name.
    DnsNameHostnameFull  = 0x00000002,
    ///The name format is a DNS host label.
    DnsNameHostnameLabel = 0x00000003,
    ///The name format is a DNS wildcard.
    DnsNameWildcard      = 0x00000004,
    ///The name format is a DNS SRV record.
    DnsNameSrvRecord     = 0x00000005,
    ///Windows 7 or later: The name format is a DNS domain or a full DNS host name.
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

// Callbacks

alias DNS_PROXY_COMPLETION_ROUTINE = void function(void* completionContext, int status);
///The <b>DNS_QUERY_COMPLETION_ROUTINE</b> callback is used to asynchronously return the results of a DNS query.
///Params:
///    pQueryContext = A pointer to a user context.
///    pQueryResults = A pointer to a DNS_QUERY_RESULT structure that contains the DNS query results from a call to DnsQueryEx.
alias DNS_QUERY_COMPLETION_ROUTINE = void function(void* pQueryContext, DNS_QUERY_RESULT* pQueryResults);
alias PDNS_QUERY_COMPLETION_ROUTINE = void function();
///Used to asynchronously return the results of a DNS-SD query.
///Params:
///    Status = A value that contains the status associated with this particular set of results.
///    pQueryContext = A pointer to the user context that was passed to [DnsServiceBrowse](nf-windns-dnsservicebrowse.md).
///    pDnsRecord = A pointer to a [DNS_RECORD](./ns-windns-dns_recordw.md) structure that contains a list of records describing a
///                 discovered service on the network. If not `nullptr`, then you are responsible for freeing the returned RR sets
///                 using [DnsRecordListFree](/windows/desktop/api/windns/nf-windns-dnsrecordlistfree).
alias DNS_SERVICE_BROWSE_CALLBACK = void function(uint Status, void* pQueryContext, DNS_RECORDA* pDnsRecord);
alias PDNS_SERVICE_BROWSE_CALLBACK = void function();
///Used to asynchronously return the results of a service resolve operation.
///Params:
///    Status = A value that contains the status associated with this particular set of results.
///    pQueryContext = A pointer to the user context that was passed to [DnsServiceResolve](nf-windns-dnsserviceresolve.md).
///    pInstance = A pointer to a [DNS_SERVICE_INSTANCE](ns-windns-dns_service_instance.md) structure that contains detailed
///                information about a service on the network. If not `nullptr`, then you are responsible for freeing the data using
///                [DnsServiceFreeInstance](nf-windns-dnsservicefreeinstance.md).
alias DNS_SERVICE_RESOLVE_COMPLETE = void function(uint Status, void* pQueryContext, 
                                                   DNS_SERVICE_INSTANCE* pInstance);
alias PDNS_SERVICE_RESOLVE_COMPLETE = void function();
///Used to notify your application that service registration has completed.
///Params:
///    Status = A value that contains the status of the registration.
///    pQueryContext = A pointer to the user context that was passed to [DnsServiceRegister](nf-windns-dnsserviceregister.md).
///    pInstance = A pointer to a [DNS_SERVICE_INSTANCE](ns-windns-dns_service_instance.md) structure that describes the service
///                that was registered. If not `nullptr`, then you are responsible for freeing the data using
///                [DnsServiceFreeInstance](nf-windns-dnsservicefreeinstance.md).
alias DNS_SERVICE_REGISTER_COMPLETE = void function(uint Status, void* pQueryContext, 
                                                    DNS_SERVICE_INSTANCE* pInstance);
alias PDNS_SERVICE_REGISTER_COMPLETE = void function();
///Used to asynchronously return the results of an mDNS query.
///Params:
///    pQueryContext = A pointer to the user context that was passed to [DnsStartMulticastQuery](nf-windns-dnsstartmulticastquery.md).
///    pQueryHandle = A pointer to the [MDNS_QUERY_HANDLE](ns-windns-mdns_query_handle.md) structure that was passed to
///                   [DnsStartMulticastQuery](nf-windns-dnsstartmulticastquery.md).
///    pQueryResults = A pointer to a [DNS_QUERY_RESULT](/windows/desktop/api/windns/ns-windns-dns_query_result) structure that contains
///                    the query results. Your application is responsible for freeing the `pQueryRecords` contained in this structure
///                    using [DnsRecordListFree](/windows/desktop/api/windns/nf-windns-dnsrecordlistfree).
alias MDNS_QUERY_CALLBACK = void function(void* pQueryContext, MDNS_QUERY_HANDLE* pQueryHandle, 
                                          DNS_QUERY_RESULT* pQueryResults);
alias PMDNS_QUERY_CALLBACK = void function();

// Structs


///The <b>IP4_ARRAY</b> structure stores an array of IPv4 addresses.
struct IP4_ARRAY
{
    ///The number of IPv4 addresses in <b>AddrArray</b>.
    uint    AddrCount;
    uint[1] AddrArray;
}

///The <b>IP6_ADDRESS</b> structure stores an IPv6 address.
union IP6_ADDRESS
{
    uint[4]   IP6Dword;
    ushort[8] IP6Word;
    ubyte[16] IP6Byte;
}

///A <b>DNS_ADDR</b> structure stores an IPv4 or IPv6 address.
struct DNS_ADDR
{
    ///A value that contains the socket IP address. It is a sockaddr_in structure if the address is IPv4 and a
    ///sockaddr_in6 structure if the address is IPv6.
    byte[32] MaxSa;
    union Data
    {
    align (1):
        uint[8] DnsAddrUserDword;
    }
}

///The <b>DNS_ADDR_ARRAY</b> structure stores an array of IPv4 or IPv6 addresses.
struct DNS_ADDR_ARRAY
{
align (1):
    ///Indicates, the size, in bytes, of this structure.
    uint        MaxCount;
    ///Indicates the number of DNS_ADDR structures contained in the <b>AddrArray</b> member.
    uint        AddrCount;
    ///Reserved. Do not use.
    uint        Tag;
    ///A value that specifies the IP family. Possible values are: <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> </dl> </td> <td
    ///width="60%"> IPv6 </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl>
    ///<dt><b>AF_INET</b></dt> </dl> </td> <td width="60%"> IPv4 </td> </tr> </table>
    ushort      Family;
    ///Reserved. Do not use.
    ushort      WordReserved;
    ///Reserved. Do not use.
    uint        Flags;
    ///Reserved. Do not use.
    uint        MatchFlag;
    ///Reserved. Do not use.
    uint        Reserved1;
    ///Reserved. Do not use.
    uint        Reserved2;
    ///An array of DNS_ADDR structures that each contain an IP address.
    DNS_ADDR[1] AddrArray;
}

///The <b>DNS_HEADER</b> structure contains DNS header information used when sending DNS messages as specified in
///section 4.1.1 of RFC 1035.
struct DNS_HEADER
{
align (1):
    ///A value that specifies the unique DNS message identifier.
    ushort Xid;
    ubyte  _bitfield1;
    ubyte  _bitfield2;
    ///The number of queries contained in the question section of the DNS message.
    ushort QuestionCount;
    ///The number of resource records (RRs) contained in the answer section of the DNS message.
    ushort AnswerCount;
    ///The number of DNS name server RRs contained in the authority section of the DNS message. This value is the number
    ///of DNS name servers the message has traversed in its search for resolution.
    ushort NameServerCount;
    ///Reserved. Do not use.
    ushort AdditionalCount;
}

struct DNS_HEADER_EXT
{
align (1):
    ushort _bitfield34;
    ubyte  chRcode;
    ubyte  chVersion;
}

///The <b>DNS_WIRE_QUESTION</b> structure contains information about a DNS question transmitted across the network as
///specified in section 4.1.2 of RFC 1035..
struct DNS_WIRE_QUESTION
{
align (1):
    ///A value that represents the question section's DNS Question Type.
    ushort QuestionType;
    ///A value that represents the question section's DNS Question Class.
    ushort QuestionClass;
}

///The <b>DNS_WIRE_RECORD</b> structure contains information about a DNS wire record transmitted across the network as
///specified in section 4.1.3 of RFC 1035.
struct DNS_WIRE_RECORD
{
align (1):
    ///A value that represents the RR DNS Response Type. <b>RecordType</b> determines the format of record data that
    ///follows the <b>DNS_WIRE_RECORD</b> structure. For example, if the value of <b>RecordType</b> is
    ///<b>DNS_TYPE_A</b>, the data type of record data is DNS_A_DATA.
    ushort RecordType;
    ///A value that represents the RR DNS Record Class.
    ushort RecordClass;
    ///The DNS Resource Record's Time To Live value (TTL), in seconds.
    uint   TimeToLive;
    ///The length, in bytes, of the DNS record data that follows the <b>DNS_WIRE_RECORD</b>.
    ushort DataLength;
}

///The <b>DNS_A_DATA</b> structure represents a DNS address (A) record as specified in section 3.4.1 of RFC 1035.
struct DNS_A_DATA
{
    ///An IP4_ADDRESS data type that contains an IPv4 address.
    uint IpAddress;
}

///The <b>DNS_PTR_DATA</b> structure represents a DNS pointer (PTR) record as specified in section 3.3.12 of RFC 1035.
struct DNS_PTR_DATAW
{
    ///A pointer to a string that represents the pointer (PTR) record data.
    const(wchar)* pNameHost;
}

///The <b>DNS_PTR_DATA</b> structure represents a DNS pointer (PTR) record as specified in section 3.3.12 of RFC 1035.
struct DNS_PTR_DATAA
{
    ///A pointer to a string that represents the pointer (PTR) record data.
    const(char)* pNameHost;
}

///The <b>DNS_SOA_DATA</b> structure represents a DNS start of authority (SOA) record as specified in section 3.3.13 of
///RFC 1035.
struct DNS_SOA_DATAW
{
    ///A pointer to a string that represents the name of the authoritative DNS server for the zone to which the record
    ///belongs.
    const(wchar)* pNamePrimaryServer;
    ///A pointer to a string that represents the name of the responsible party for the zone to which the record belongs.
    const(wchar)* pNameAdministrator;
    ///The serial number of the SOA record.
    uint          dwSerialNo;
    ///The time, in seconds, before the zone containing this record should be refreshed.
    uint          dwRefresh;
    ///The time, in seconds, before retrying a failed refresh of the zone to which this record belongs.
    uint          dwRetry;
    ///The time, in seconds, before an unresponsive zone is no longer authoritative.
    uint          dwExpire;
    ///The lower limit on the time, in seconds, that a DNS server or caching resolver are allowed to cache any resource
    ///records (RR) from the zone to which this record belongs.
    uint          dwDefaultTtl;
}

///The <b>DNS_SOA_DATA</b> structure represents a DNS start of authority (SOA) record as specified in section 3.3.13 of
///RFC 1035.
struct DNS_SOA_DATAA
{
    ///A pointer to a string that represents the name of the authoritative DNS server for the zone to which the record
    ///belongs.
    const(char)* pNamePrimaryServer;
    ///A pointer to a string that represents the name of the responsible party for the zone to which the record belongs.
    const(char)* pNameAdministrator;
    ///The serial number of the SOA record.
    uint         dwSerialNo;
    ///The time, in seconds, before the zone containing this record should be refreshed.
    uint         dwRefresh;
    ///The time, in seconds, before retrying a failed refresh of the zone to which this record belongs.
    uint         dwRetry;
    ///The time, in seconds, before an unresponsive zone is no longer authoritative.
    uint         dwExpire;
    ///The lower limit on the time, in seconds, that a DNS server or caching resolver are allowed to cache any resource
    ///records (RR) from the zone to which this record belongs.
    uint         dwDefaultTtl;
}

///The <b>DNS_MINFO_DATA</b> structure represents a DNS mail information (MINFO) record as specified in section 3.3.7 of
///RFC 1035.
struct DNS_MINFO_DATAW
{
    ///A pointer to a string that represents the fully qualified domain name (FQDN) of the mailbox responsible for the
    ///mailing list or mailbox specified in the record's owner name.
    const(wchar)* pNameMailbox;
    ///A pointer to a string that represents the FQDN of the mailbox to receive error messages related to the mailing
    ///list.
    const(wchar)* pNameErrorsMailbox;
}

///The <b>DNS_MINFO_DATA</b> structure represents a DNS mail information (MINFO) record as specified in section 3.3.7 of
///RFC 1035.
struct DNS_MINFO_DATAA
{
    ///A pointer to a string that represents the fully qualified domain name (FQDN) of the mailbox responsible for the
    ///mailing list or mailbox specified in the record's owner name.
    const(char)* pNameMailbox;
    ///A pointer to a string that represents the FQDN of the mailbox to receive error messages related to the mailing
    ///list.
    const(char)* pNameErrorsMailbox;
}

///The <b>DNS_MX_DATA</b> structure represents a DNS mail exchanger (MX) record as specified in section 3.3.9 of RFC
///1035.
struct DNS_MX_DATAW
{
    ///A pointer to a string that represents the fully qualified domain name (FQDN) of the host willing to act as a mail
    ///exchange.
    const(wchar)* pNameExchange;
    ///A preference given to this resource record among others of the same owner. Lower values are preferred.
    ushort        wPreference;
    ///Reserved for padding. Do not use.
    ushort        Pad;
}

///The <b>DNS_MX_DATA</b> structure represents a DNS mail exchanger (MX) record as specified in section 3.3.9 of RFC
///1035.
struct DNS_MX_DATAA
{
    ///A pointer to a string that represents the fully qualified domain name (FQDN) of the host willing to act as a mail
    ///exchange.
    const(char)* pNameExchange;
    ///A preference given to this resource record among others of the same owner. Lower values are preferred.
    ushort       wPreference;
    ///Reserved for padding. Do not use.
    ushort       Pad;
}

///The <b>DNS_TXT_DATA</b> structure represents a DNS text (TXT) record as specified in section 3.3.14 of RFC 1035.
struct DNS_TXT_DATAW
{
    ///The number of strings represented in <b>pStringArray</b>.
    uint       dwStringCount;
    ///An array of strings representing the descriptive text of the TXT resource record.
    ushort[1]* pStringArray;
}

///The <b>DNS_TXT_DATA</b> structure represents a DNS text (TXT) record as specified in section 3.3.14 of RFC 1035.
struct DNS_TXT_DATAA
{
    ///The number of strings represented in <b>pStringArray</b>.
    uint     dwStringCount;
    ///An array of strings representing the descriptive text of the TXT resource record.
    byte[1]* pStringArray;
}

///The <b>DNS_NULL_DATA</b> structure represents NULL data for a DNS resource record as specified in section 3.3.10 of
///RFC 1035.
struct DNS_NULL_DATA
{
    ///The number of bytes represented in <b>Data</b>.
    uint     dwByteCount;
    ///Null data.
    ubyte[1] Data;
}

///The <b>DNS_WKS_DATA</b> structure represents a DNS well-known services (WKS) record as specified in section 3.4.2 of
///RFC 1035.
struct DNS_WKS_DATA
{
    ///An IP4_ADDRESS data type that contains the IPv4 address for this resource record (RR).
    uint     IpAddress;
    ///A value that represents the IP protocol for this RR as defined in RFC 1010.
    ubyte    chProtocol;
    ///A variable-length bitmask whose bits correspond to the port number of well known services offered by the protocol
    ///specified in <b>chProtocol</b>. The bitmask has one bit for every port of the supported protocol, but must be a
    ///multiple of a <b>BYTE</b>. Bit 0 corresponds to port 1, bit 1 corresponds to port 2, and so forth for a maximum
    ///of 1024 bits.
    ubyte[1] BitMask;
}

///The <b>DNS_AAAA_DATA</b> structure represents a DNS IPv6 (AAAA) record as specified in RFC 3596.
struct DNS_AAAA_DATA
{
    ///An IP6_ADDRESS data type that contains an IPv6 address.
    IP6_ADDRESS Ip6Address;
}

///The <b>DNS_RRSIG_DATA</b> structure represents a DNS Security Extensions (DNSSEC) cryptographic signature (SIG)
///resource record (RR) as specified in RFC 4034.
struct DNS_SIG_DATAW
{
    ///The DNS Record Type of the signed RRs.
    ushort        wTypeCovered;
    ///A value that specifies the algorithm used to generate <b>Signature</b>. The possible values are shown in the
    ///following table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl>
    ///<dt><b>1</b></dt> </dl> </td> <td width="60%"> RSA/MD5 (RFC 2537) </td> </tr> <tr> <td width="40%"><a
    ///id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> Diffie-Hellman (RFC 2539) </td> </tr> <tr> <td
    ///width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> DSA (RFC 2536) </td> </tr> <tr> <td
    ///width="40%"><a id="4"></a><dl> <dt><b>4</b></dt> </dl> </td> <td width="60%"> Elliptic curve cryptography </td>
    ///</tr> <tr> <td width="40%"><a id="5"></a><dl> <dt><b>5</b></dt> </dl> </td> <td width="60%"> RSA/SHA-1 (RFC 3110)
    ///</td> </tr> </table>
    ubyte         chAlgorithm;
    ///The number of labels in the original signature RR owner name as specified in section 3.1.3 of RFC 4034.
    ubyte         chLabelCount;
    ///The Time-to-Live (TTL) value of the RR set signed by <b>Signature</b>.
    uint          dwOriginalTtl;
    ///The expiration date of <b>Signature</b>, expressed in seconds since the beginning of January 1, 1970, Greenwich
    ///Mean Time (GMT), excluding leap seconds.
    uint          dwExpiration;
    ///The date and time at which <b>Signature</b> becomes valid, expressed in seconds since the beginning of January 1,
    ///1970, Greenwich Mean Time (GMT), excluding leap seconds.
    uint          dwTimeSigned;
    ///A value that represents the method to choose which public key is used to verify <b>Signature</b> as specified
    ///Appendix B of RFC 4034.
    ushort        wKeyTag;
    ushort        wSignatureLength;
    ///A pointer to a string that represents the name of the <b>Signature</b> generator.
    const(wchar)* pNameSigner;
    ///A <b>BYTE</b> array that contains the RR set signature as specified in section 3.1.8 of RFC 4034.
    ubyte[1]      Signature;
}

///The <b>DNS_RRSIG_DATA</b> structure represents a DNS Security Extensions (DNSSEC) cryptographic signature (SIG)
///resource record (RR) as specified in RFC 4034.
struct DNS_SIG_DATAA
{
    ///The DNS Record Type of the signed RRs.
    ushort       wTypeCovered;
    ///A value that specifies the algorithm used to generate <b>Signature</b>. The possible values are shown in the
    ///following table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl>
    ///<dt><b>1</b></dt> </dl> </td> <td width="60%"> RSA/MD5 (RFC 2537) </td> </tr> <tr> <td width="40%"><a
    ///id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> Diffie-Hellman (RFC 2539) </td> </tr> <tr> <td
    ///width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> DSA (RFC 2536) </td> </tr> <tr> <td
    ///width="40%"><a id="4"></a><dl> <dt><b>4</b></dt> </dl> </td> <td width="60%"> Elliptic curve cryptography </td>
    ///</tr> <tr> <td width="40%"><a id="5"></a><dl> <dt><b>5</b></dt> </dl> </td> <td width="60%"> RSA/SHA-1 (RFC 3110)
    ///</td> </tr> </table>
    ubyte        chAlgorithm;
    ///The number of labels in the original signature RR owner name as specified in section 3.1.3 of RFC 4034.
    ubyte        chLabelCount;
    ///The Time-to-Live (TTL) value of the RR set signed by <b>Signature</b>.
    uint         dwOriginalTtl;
    ///The expiration date of <b>Signature</b>, expressed in seconds since the beginning of January 1, 1970, Greenwich
    ///Mean Time (GMT), excluding leap seconds.
    uint         dwExpiration;
    ///The date and time at which <b>Signature</b> becomes valid, expressed in seconds since the beginning of January 1,
    ///1970, Greenwich Mean Time (GMT), excluding leap seconds.
    uint         dwTimeSigned;
    ///A value that represents the method to choose which public key is used to verify <b>Signature</b> as specified
    ///Appendix B of RFC 4034.
    ushort       wKeyTag;
    ushort       wSignatureLength;
    ///A pointer to a string that represents the name of the <b>Signature</b> generator.
    const(char)* pNameSigner;
    ///A <b>BYTE</b> array that contains the RR set signature as specified in section 3.1.8 of RFC 4034.
    ubyte[1]     Signature;
}

///The <b>DNS_KEY_DATA</b> structure represents a DNS key (KEY) resource record (RR) as specified in RFC 3445.
struct DNS_KEY_DATA
{
    ///A set of flags that specify whether this is a zone key as described in section 4 of RFC 3445.
    ushort   wFlags;
    ///A value that specifies the protocol with which <b>Key</b> can be used. The possible values are shown in the
    ///following table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="3"></a><dl>
    ///<dt><b>3</b></dt> </dl> </td> <td width="60%"> Domain Name System Security Extensions (DNSSEC) </td> </tr>
    ///</table>
    ubyte    chProtocol;
    ///A value that specifies the algorithm to use with <b>Key</b>. The possible values are shown in the following
    ///table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl>
    ///<dt><b>1</b></dt> </dl> </td> <td width="60%"> RSA/MD5 (RFC 2537) </td> </tr> <tr> <td width="40%"><a
    ///id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> Diffie-Hellman (RFC 2539) </td> </tr> <tr> <td
    ///width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> DSA (RFC 2536) </td> </tr> <tr> <td
    ///width="40%"><a id="4"></a><dl> <dt><b>4</b></dt> </dl> </td> <td width="60%"> Elliptic curve cryptography </td>
    ///</tr> <tr> <td width="40%"><a id="5"></a><dl> <dt><b>5</b></dt> </dl> </td> <td width="60%"> RSA/SHA-1 (RFC
    ///3110). DNS_DNSKEY_DATA only. </td> </tr> </table>
    ubyte    chAlgorithm;
    ///The length, in bytes, of <b>Key</b>. This value is determined by the algorithm type in <b>chAlgorithm</b>.
    ushort   wKeyLength;
    ///Reserved. Do not use.
    ushort   wPad;
    ///A <b>BYTE</b> array that contains the public key for the algorithm in <b>chAlgorithm</b>, represented in base 64,
    ///as described in Appendix A of RFC 2535.
    ubyte[1] Key;
}

///The <b>DNS_DHCID_DATA</b> structure represents a DNS Dynamic Host Configuration Protocol Information (DHCID) resource
///record (RR) as specified in section 3 of RFC 4701.
struct DNS_DHCID_DATA
{
    ///The length, in bytes, of <b>DHCID</b>.
    uint     dwByteCount;
    ///A <b>BYTE</b> array that contains the DHCID client, domain, and SHA-256 digest information as specified in
    ///section 4 of RFC 2671.
    ubyte[1] DHCID;
}

///The <b>DNS_NSEC_DATA</b> structure represents an NSEC resource record (RR) as specified in section 4 of RFC 4034.
struct DNS_NSEC_DATAW
{
    ///A pointer to a string that represents the authoritative owner name of the next domain in the canonical ordering
    ///of the zone as specified in section 4.1.1 of RFC 4034.
    const(wchar)* pNextDomainName;
    ///The length, in bytes, of <b>TypeBitMaps</b>.
    ushort        wTypeBitMapsLength;
    ///Reserved. Do not use.
    ushort        wPad;
    ///A <b>BYTE</b> array that contains a bitmap that specifies which RR types are supported by the NSEC RR owner. Each
    ///bit in the array corresponds to a DNS Record Type as defined in section in section 4.1.2 of RFC 4034.
    ubyte[1]      TypeBitMaps;
}

///The <b>DNS_NSEC_DATA</b> structure represents an NSEC resource record (RR) as specified in section 4 of RFC 4034.
struct DNS_NSEC_DATAA
{
    ///A pointer to a string that represents the authoritative owner name of the next domain in the canonical ordering
    ///of the zone as specified in section 4.1.1 of RFC 4034.
    const(char)* pNextDomainName;
    ///The length, in bytes, of <b>TypeBitMaps</b>.
    ushort       wTypeBitMapsLength;
    ///Reserved. Do not use.
    ushort       wPad;
    ///A <b>BYTE</b> array that contains a bitmap that specifies which RR types are supported by the NSEC RR owner. Each
    ///bit in the array corresponds to a DNS Record Type as defined in section in section 4.1.2 of RFC 4034.
    ubyte[1]     TypeBitMaps;
}

struct DNS_NSEC3_DATA
{
    ubyte    chAlgorithm;
    ubyte    bFlags;
    ushort   wIterations;
    ubyte    bSaltLength;
    ubyte    bHashLength;
    ushort   wTypeBitMapsLength;
    ubyte[1] chData;
}

struct DNS_NSEC3PARAM_DATA
{
    ubyte    chAlgorithm;
    ubyte    bFlags;
    ushort   wIterations;
    ubyte    bSaltLength;
    ubyte[3] bPad;
    ubyte[1] pbSalt;
}

struct DNS_TLSA_DATA
{
    ubyte    bCertUsage;
    ubyte    bSelector;
    ubyte    bMatchingType;
    ushort   bCertificateAssociationDataLength;
    ubyte[3] bPad;
    ubyte[1] bCertificateAssociationData;
}

///The <b>DNS_DS_DATA</b> structure represents a DS resource record (RR) as specified in section 2 of RFC 4034 and is
///used to verify the contents of DNS_DNSKEY_DATA.
struct DNS_DS_DATA
{
    ///A value that represents the method to choose which public key is used to verify <b>Signature</b> in
    ///DNS_RRSIG_DATA as specified in Appendix B of RFC 4034. This value is identical to the <b>wKeyTag</b> field in
    ///<b>DNS_RRSIG_DATA</b>.
    ushort   wKeyTag;
    ///A value that specifies the algorithm defined by DNS_DNSKEY_DATA. The possible values are shown in the following
    ///table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl>
    ///<dt><b>1</b></dt> </dl> </td> <td width="60%"> RSA/MD5 (RFC 2537) </td> </tr> <tr> <td width="40%"><a
    ///id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> Diffie-Hellman (RFC 2539) </td> </tr> <tr> <td
    ///width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> DSA (RFC 2536) </td> </tr> <tr> <td
    ///width="40%"><a id="4"></a><dl> <dt><b>4</b></dt> </dl> </td> <td width="60%"> Elliptic curve cryptography </td>
    ///</tr> <tr> <td width="40%"><a id="5"></a><dl> <dt><b>5</b></dt> </dl> </td> <td width="60%"> RSA/SHA-1 (RFC 3110)
    ///</td> </tr> </table>
    ubyte    chAlgorithm;
    ///A value that specifies the cryptographic algorithm used to generate <b>Digest</b>. The possible values are shown
    ///in the following table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> SHA-1 (RFC 3174) </td> </tr> </table>
    ubyte    chDigestType;
    ///The length, in bytes. of the message digest in <b>Digest</b>. This value is determined by the algorithm type in
    ///<b>chDigestType</b>.
    ushort   wDigestLength;
    ///Reserved for padding. Do not use.
    ushort   wPad;
    ///A <b>BYTE</b> array that contains a cryptographic digest of the DNSKEY RR and RDATA as specified in section 5.1.4
    ///of RFC 4034. Its length is determined by <b>wDigestLength</b>.
    ubyte[1] Digest;
}

///The <b>DNS_OPT_DATA</b> structure represents a DNS Option (OPT) resource record (RR) as specified in section 4 of RFC
///2671.
struct DNS_OPT_DATA
{
    ///The length, in bytes, of <b>Data</b>.
    ushort   wDataLength;
    ///Reserved. Do not use.
    ushort   wPad;
    ///A <b>BYTE</b> array that contains variable transport level information as specified in section 4 of RFC 2671.
    ubyte[1] Data;
}

///The <b>DNS_LOC_DATA</b> structure represents a DNS location (LOC) resource record (RR) as specified in RFC 1876.
struct DNS_LOC_DATA
{
    ///The version number of the representation. Must be zero.
    ushort wVersion;
    ///The diameter of a sphere enclosing the described entity, defined as "SIZE" in section 2 of RFC 1876.
    ushort wSize;
    ///The horizontal data precision, defined as "HORIZ PRE" in section 2 of RFC 1876.
    ushort wHorPrec;
    ///The vertical data precision, defined as "VERT PRE" in section 2 of RFC 1876.
    ushort wVerPrec;
    ///The latitude of the center of the sphere, defined as "LATITUDE" in section 2 of RFC 1876.
    uint   dwLatitude;
    ///The longitude of the center of the sphere, defined as "LONGITUDE" in section 2 of RFC 1876.
    uint   dwLongitude;
    ///The altitude of the center of the sphere, defined as "ALTITUDE" in section 2 of RFC 1876.
    uint   dwAltitude;
}

///The <b>DNS_NXT_DATA</b> structure represents a DNS next (NXT) resource record (RR) as specified in section 5 of RFC
///2535.
struct DNS_NXT_DATAW
{
    ///A pointer to a string that represents the name of the next domain.
    const(wchar)* pNameNext;
    ///The number of elements in the <b>wTypes</b> array. <b>wNumTypes</b> must be 2 or greater but cannot exceed 8.
    ushort        wNumTypes;
    ///A <b>BYTE</b> array that contains a bitmap which specifies the RR types that are present in the next domain. Each
    ///bit in the array corresponds to a DNS Record Type as defined in section 5.2 of RFC 2535.
    ushort[1]     wTypes;
}

///The <b>DNS_NXT_DATA</b> structure represents a DNS next (NXT) resource record (RR) as specified in section 5 of RFC
///2535.
struct DNS_NXT_DATAA
{
    ///A pointer to a string that represents the name of the next domain.
    const(char)* pNameNext;
    ///The number of elements in the <b>wTypes</b> array. <b>wNumTypes</b> must be 2 or greater but cannot exceed 8.
    ushort       wNumTypes;
    ///A <b>BYTE</b> array that contains a bitmap which specifies the RR types that are present in the next domain. Each
    ///bit in the array corresponds to a DNS Record Type as defined in section 5.2 of RFC 2535.
    ushort[1]    wTypes;
}

///The <b>DNS_SRV_DATA</b> structure represents a DNS service (SRV) record as specified in RFC 2782.
struct DNS_SRV_DATAW
{
    ///A pointer to a string that represents the target host.
    const(wchar)* pNameTarget;
    ///The priority of the target host specified in <b>pNameTarget</b>. Lower numbers imply higher priority to clients
    ///attempting to use this service.
    ushort        wPriority;
    ///The relative weight of the target host in <b>pNameTarget</b> to other hosts with the same <b>wPriority</b>. The
    ///chances of using this host should be proportional to its weight.
    ushort        wWeight;
    ///The port used on the target host for this service.
    ushort        wPort;
    ///Reserved for padding. Do not use.
    ushort        Pad;
}

///The <b>DNS_SRV_DATA</b> structure represents a DNS service (SRV) record as specified in RFC 2782.
struct DNS_SRV_DATAA
{
    ///A pointer to a string that represents the target host.
    const(char)* pNameTarget;
    ///The priority of the target host specified in <b>pNameTarget</b>. Lower numbers imply higher priority to clients
    ///attempting to use this service.
    ushort       wPriority;
    ///The relative weight of the target host in <b>pNameTarget</b> to other hosts with the same <b>wPriority</b>. The
    ///chances of using this host should be proportional to its weight.
    ushort       wWeight;
    ///The port used on the target host for this service.
    ushort       wPort;
    ///Reserved for padding. Do not use.
    ushort       Pad;
}

///The <b>DNS_NAPTR_DATA</b> structure represents a Naming Authority Pointer (NAPTR) DNS Resource Record (RR) as
///specified in RFC 2915.
struct DNS_NAPTR_DATAW
{
    ///A value that determines the NAPTR RR processing order as defined in section 2 of RFC 2915.
    ushort        wOrder;
    ///A value that determines the NAPTR RR processing order for records with the same <b>wOrder</b> value as defined in
    ///section 2 of RFC 2915.
    ushort        wPreference;
    ///A pointer to a string that represents a set of NAPTR RR flags which determine the interpretation and processing
    ///of NAPTR record fields as defined in section 2 of RFC 2915.
    const(wchar)* pFlags;
    ///A pointer to a string that represents the available services in this rewrite path as defined in section 2 of RFC
    ///2915.
    const(wchar)* pService;
    ///A pointer to a string that represents a substitution expression as defined in sections 2 and 3 of RFC 2915.
    const(wchar)* pRegularExpression;
    ///A pointer to a string that represents the next NAPTR query name as defined in section 2 of RFC 2915.
    const(wchar)* pReplacement;
}

///The <b>DNS_NAPTR_DATA</b> structure represents a Naming Authority Pointer (NAPTR) DNS Resource Record (RR) as
///specified in RFC 2915.
struct DNS_NAPTR_DATAA
{
    ///A value that determines the NAPTR RR processing order as defined in section 2 of RFC 2915.
    ushort       wOrder;
    ///A value that determines the NAPTR RR processing order for records with the same <b>wOrder</b> value as defined in
    ///section 2 of RFC 2915.
    ushort       wPreference;
    ///A pointer to a string that represents a set of NAPTR RR flags which determine the interpretation and processing
    ///of NAPTR record fields as defined in section 2 of RFC 2915.
    const(char)* pFlags;
    ///A pointer to a string that represents the available services in this rewrite path as defined in section 2 of RFC
    ///2915.
    const(char)* pService;
    ///A pointer to a string that represents a substitution expression as defined in sections 2 and 3 of RFC 2915.
    const(char)* pRegularExpression;
    ///A pointer to a string that represents the next NAPTR query name as defined in section 2 of RFC 2915.
    const(char)* pReplacement;
}

///The <b>DNS_ATMA_DATA</b> structure represents a DNS ATM address (ATMA) resource record (RR).
struct DNS_ATMA_DATA
{
    ///The format of the ATM address in <b>Address</b>. The possible values for <b>AddressType</b> are: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DNS_ATMA_FORMAT_AESA"></a><a
    ///id="dns_atma_format_aesa"></a><dl> <dt><b>DNS_ATMA_FORMAT_AESA</b></dt> </dl> </td> <td width="60%"> An address
    ///of the form: 39.246f.123456789abcdefa0123.00123456789a.00. It is a 40 hex character address mapped to 20 octets
    ///with arbitrarily placed "." separators. Its length is exactly <b>DNS_ATMA_AESA_ADDR_LENGTH</b> bytes. </td> </tr>
    ///<tr> <td width="40%"><a id="DNS_ATMA_FORMAT_E164"></a><a id="dns_atma_format_e164"></a><dl>
    ///<dt><b>DNS_ATMA_FORMAT_E164</b></dt> </dl> </td> <td width="60%"> An address of the form: +358.400.1234567\0. The
    ///null-terminated hex characters map one-to-one into the ATM address with arbitrarily placed "." separators. The
    ///'+' indicates it is an E.164 format address. Its length is less than <b>DNS_ATMA_MAX_ADDR_LENGTH</b> bytes. </td>
    ///</tr> </table>
    ubyte     AddressType;
    ///A <b>BYTE</b> array that contains the ATM address whose format is specified by <b>AddressType</b>.
    ubyte[20] Address;
}

///The <b>DNS_TKEY_DATA</b> structure represents a DNS TKEY resource record, used to establish and delete an algorithm's
///shared-secret keys between a DNS resolver and server as specified in RFC 2930.
struct DNS_TKEY_DATAW
{
    ///A pointer to a string that represents the name of the key as defined in section 2.1 of RFC 2930.
    const(wchar)* pNameAlgorithm;
    ///A pointer to a string representing the name of the algorithm as defined in section 2.3 of RFC 2930. <b>pKey</b>
    ///is used to derive the algorithm specific keys.
    ubyte*        pAlgorithmPacket;
    ///A pointer to the variable-length shared-secret key.
    ubyte*        pKey;
    ///Reserved. Do not use.
    ubyte*        pOtherData;
    ///The date and time at which the key was created, expressed in seconds since the beginning of January 1, 1970,
    ///Greenwich Mean Time (GMT), excluding leap seconds.
    uint          dwCreateTime;
    ///The expiration date of the key, expressed in seconds since the beginning of January 1, 1970, Greenwich Mean Time
    ///(GMT), excluding leap seconds.
    uint          dwExpireTime;
    ///A scheme used for key agreement or the purpose of the TKEY DNS Message. Possible values for <b>wMode</b> are
    ///listed below: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="DNS_TKEY_MODE_SERVER_ASSIGN"></a><a id="dns_tkey_mode_server_assign"></a><dl>
    ///<dt><b>DNS_TKEY_MODE_SERVER_ASSIGN</b></dt> </dl> </td> <td width="60%"> The key is assigned by the DNS server
    ///and is not negotiated. </td> </tr> <tr> <td width="40%"><a id="DNS_TKEY_MODE_DIFFIE_HELLMAN"></a><a
    ///id="dns_tkey_mode_diffie_hellman"></a><dl> <dt><b>DNS_TKEY_MODE_DIFFIE_HELLMAN</b></dt> </dl> </td> <td
    ///width="60%"> The Diffie-Hellman key exchange algorithm is used to negotiate the key. </td> </tr> <tr> <td
    ///width="40%"><a id="DNS_TKEY_MODE_GSS_"></a><a id="dns_tkey_mode_gss_"></a><dl> <dt><b>DNS_TKEY_MODE_GSS </b></dt>
    ///</dl> </td> <td width="60%"> The key is exchanged through Generic Security Services-Application Program Interface
    ///(GSS-API) negotiation. </td> </tr> <tr> <td width="40%"><a id="DNS_TKEY_MODE_RESOLVER_ASSIGN"></a><a
    ///id="dns_tkey_mode_resolver_assign"></a><dl> <dt><b>DNS_TKEY_MODE_RESOLVER_ASSIGN</b></dt> </dl> </td> <td
    ///width="60%"> The key is assigned by the DNS resolver and is not negotiated. </td> </tr> </table>
    ushort        wMode;
    ///An error, expressed in expanded RCODE format that covers TSIG and TKEY RR processing. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="DNS_RCODE_BADSIG"></a><a id="dns_rcode_badsig"></a><dl>
    ///<dt><b>DNS_RCODE_BADSIG</b></dt> </dl> </td> <td width="60%"> The <b>pSignature</b> of the DNS_TSIG_DATA RR is
    ///bad. </td> </tr> <tr> <td width="40%"><a id="DNS_RCODE_BADKEY"></a><a id="dns_rcode_badkey"></a><dl>
    ///<dt><b>DNS_RCODE_BADKEY</b></dt> </dl> </td> <td width="60%"> The <b>pKey</b> field is bad. </td> </tr> <tr> <td
    ///width="40%"><a id="DNS_RCODE_BADTIME"></a><a id="dns_rcode_badtime"></a><dl> <dt><b>DNS_RCODE_BADTIME</b></dt>
    ///</dl> </td> <td width="60%"> A timestamp is bad. </td> </tr> </table>
    ushort        wError;
    ///Length, in bytes, of the <b>pKey</b> member.
    ushort        wKeyLength;
    ///The length, in bytes, of the <b>pOtherData</b> member.
    ushort        wOtherLength;
    ///The length, in bytes, of the <b>pNameAlgorithm</b> member.
    ubyte         cAlgNameLength;
    ///Reserved. Do not use.
    BOOL          bPacketPointers;
}

///The <b>DNS_TKEY_DATA</b> structure represents a DNS TKEY resource record, used to establish and delete an algorithm's
///shared-secret keys between a DNS resolver and server as specified in RFC 2930.
struct DNS_TKEY_DATAA
{
    ///A pointer to a string that represents the name of the key as defined in section 2.1 of RFC 2930.
    const(char)* pNameAlgorithm;
    ///A pointer to a string representing the name of the algorithm as defined in section 2.3 of RFC 2930. <b>pKey</b>
    ///is used to derive the algorithm specific keys.
    ubyte*       pAlgorithmPacket;
    ///A pointer to the variable-length shared-secret key.
    ubyte*       pKey;
    ///Reserved. Do not use.
    ubyte*       pOtherData;
    ///The date and time at which the key was created, expressed in seconds since the beginning of January 1, 1970,
    ///Greenwich Mean Time (GMT), excluding leap seconds.
    uint         dwCreateTime;
    ///The expiration date of the key, expressed in seconds since the beginning of January 1, 1970, Greenwich Mean Time
    ///(GMT), excluding leap seconds.
    uint         dwExpireTime;
    ///A scheme used for key agreement or the purpose of the TKEY DNS Message. Possible values for <b>wMode</b> are
    ///listed below: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="DNS_TKEY_MODE_SERVER_ASSIGN"></a><a id="dns_tkey_mode_server_assign"></a><dl>
    ///<dt><b>DNS_TKEY_MODE_SERVER_ASSIGN</b></dt> </dl> </td> <td width="60%"> The key is assigned by the DNS server
    ///and is not negotiated. </td> </tr> <tr> <td width="40%"><a id="DNS_TKEY_MODE_DIFFIE_HELLMAN"></a><a
    ///id="dns_tkey_mode_diffie_hellman"></a><dl> <dt><b>DNS_TKEY_MODE_DIFFIE_HELLMAN</b></dt> </dl> </td> <td
    ///width="60%"> The Diffie-Hellman key exchange algorithm is used to negotiate the key. </td> </tr> <tr> <td
    ///width="40%"><a id="DNS_TKEY_MODE_GSS_"></a><a id="dns_tkey_mode_gss_"></a><dl> <dt><b>DNS_TKEY_MODE_GSS </b></dt>
    ///</dl> </td> <td width="60%"> The key is exchanged through Generic Security Services-Application Program Interface
    ///(GSS-API) negotiation. </td> </tr> <tr> <td width="40%"><a id="DNS_TKEY_MODE_RESOLVER_ASSIGN"></a><a
    ///id="dns_tkey_mode_resolver_assign"></a><dl> <dt><b>DNS_TKEY_MODE_RESOLVER_ASSIGN</b></dt> </dl> </td> <td
    ///width="60%"> The key is assigned by the DNS resolver and is not negotiated. </td> </tr> </table>
    ushort       wMode;
    ///An error, expressed in expanded RCODE format that covers TSIG and TKEY RR processing. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="DNS_RCODE_BADSIG"></a><a id="dns_rcode_badsig"></a><dl>
    ///<dt><b>DNS_RCODE_BADSIG</b></dt> </dl> </td> <td width="60%"> The <b>pSignature</b> of the DNS_TSIG_DATA RR is
    ///bad. </td> </tr> <tr> <td width="40%"><a id="DNS_RCODE_BADKEY"></a><a id="dns_rcode_badkey"></a><dl>
    ///<dt><b>DNS_RCODE_BADKEY</b></dt> </dl> </td> <td width="60%"> The <b>pKey</b> field is bad. </td> </tr> <tr> <td
    ///width="40%"><a id="DNS_RCODE_BADTIME"></a><a id="dns_rcode_badtime"></a><dl> <dt><b>DNS_RCODE_BADTIME</b></dt>
    ///</dl> </td> <td width="60%"> A timestamp is bad. </td> </tr> </table>
    ushort       wError;
    ///Length, in bytes, of the <b>pKey</b> member.
    ushort       wKeyLength;
    ///The length, in bytes, of the <b>pOtherData</b> member.
    ushort       wOtherLength;
    ///The length, in bytes, of the <b>pNameAlgorithm</b> member.
    ubyte        cAlgNameLength;
    ///Reserved. Do not use.
    BOOL         bPacketPointers;
}

///The <b>DNS_TSIG_DATA</b> structure represents a secret key transaction authentication (TSIG) resource record (RR) as
///specified in RFC 2845 and RFC 3645.
struct DNS_TSIG_DATAW
{
    ///A pointer to a string that represents the name of the key used to generate <b>pSignature</b> as defined in
    ///section 2.3 of RFC 2845.
    const(wchar)* pNameAlgorithm;
    ///A pointer to a string that represents the name of the algorithm used to generate <b>pSignature</b> as defined in
    ///section 2.3 of RFC 2845. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="gss.microsoft.com"></a><a id="GSS.MICROSOFT.COM"></a><dl> <dt><b>"gss.microsoft.com"</b></dt> </dl> </td> <td
    ///width="60%"> Windows 2000 Server only: Generic Security Service Algorithm for Secret Key Transaction
    ///Authentication for DNS (GSS-API) as defined in RFC 3645. </td> </tr> <tr> <td width="40%"><a id="gss-tsig"></a><a
    ///id="GSS-TSIG"></a><dl> <dt><b>"gss-tsig"</b></dt> </dl> </td> <td width="60%"> Generic Security Service Algorithm
    ///for Secret Key Transaction Authentication for DNS (GSS-API) as defined in RFC 3645. </td> </tr> </table>
    ubyte*        pAlgorithmPacket;
    ///A pointer to the Message Authentication Code (MAC) generated by the algorithm in <b>pAlgorithmPacket</b>. The
    ///length, in bytes, and composition of <b>pSignature</b> are determined by <b>pAlgorithmPacket</b>.
    ubyte*        pSignature;
    ///If <b>wError</b> contains the RCODE, <b>BADTIME</b>, <b>pOtherData</b> is a BYTE array that contains the server's
    ///current time, otherwise it is <b>NULL</b>. Time is expressed in seconds since the beginning of January 1, 1970,
    ///Greenwich Mean Time (GMT), excluding leap seconds.
    ubyte*        pOtherData;
    ///The time <b>pSignature</b> was generated, expressed in seconds since the beginning of January 1, 1970, Greenwich
    ///Mean Time (GMT), excluding leap seconds.
    long          i64CreateTime;
    ///The time, in seconds, <b>i64CreateTime</b> may be in error.
    ushort        wFudgeTime;
    ///The Xid identifier of the original message.
    ushort        wOriginalXid;
    ///An error, expressed in expanded RCODE format that covers TSIG and TKEY RR processing. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="DNS_RCODE_BADSIG"></a><a id="dns_rcode_badsig"></a><dl>
    ///<dt><b>DNS_RCODE_BADSIG</b></dt> </dl> </td> <td width="60%"> The <b>pSignature</b> field is bad. </td> </tr>
    ///<tr> <td width="40%"><a id="DNS_RCODE_BADKEY"></a><a id="dns_rcode_badkey"></a><dl>
    ///<dt><b>DNS_RCODE_BADKEY</b></dt> </dl> </td> <td width="60%"> The <b>pKey</b> field of the DNS_TKEY_DATA RR is
    ///bad. </td> </tr> <tr> <td width="40%"><a id="DNS_RCODE_BADTIME"></a><a id="dns_rcode_badtime"></a><dl>
    ///<dt><b>DNS_RCODE_BADTIME</b></dt> </dl> </td> <td width="60%"> A timestamp is bad. </td> </tr> </table>
    ushort        wError;
    ///The length, in bytes, of the <b>pSignature</b> member.
    ushort        wSigLength;
    ///The length, in bytes, of the <b>pOtherData</b> member.
    ushort        wOtherLength;
    ///The length, in bytes, of the <b>pAlgorithmPacket</b> member.
    ubyte         cAlgNameLength;
    ///Reserved for future use. Do not use.
    BOOL          bPacketPointers;
}

///The <b>DNS_TSIG_DATA</b> structure represents a secret key transaction authentication (TSIG) resource record (RR) as
///specified in RFC 2845 and RFC 3645.
struct DNS_TSIG_DATAA
{
    ///A pointer to a string that represents the name of the key used to generate <b>pSignature</b> as defined in
    ///section 2.3 of RFC 2845.
    const(char)* pNameAlgorithm;
    ///A pointer to a string that represents the name of the algorithm used to generate <b>pSignature</b> as defined in
    ///section 2.3 of RFC 2845. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="gss.microsoft.com"></a><a id="GSS.MICROSOFT.COM"></a><dl> <dt><b>"gss.microsoft.com"</b></dt> </dl> </td> <td
    ///width="60%"> Windows 2000 Server only: Generic Security Service Algorithm for Secret Key Transaction
    ///Authentication for DNS (GSS-API) as defined in RFC 3645. </td> </tr> <tr> <td width="40%"><a id="gss-tsig"></a><a
    ///id="GSS-TSIG"></a><dl> <dt><b>"gss-tsig"</b></dt> </dl> </td> <td width="60%"> Generic Security Service Algorithm
    ///for Secret Key Transaction Authentication for DNS (GSS-API) as defined in RFC 3645. </td> </tr> </table>
    ubyte*       pAlgorithmPacket;
    ///A pointer to the Message Authentication Code (MAC) generated by the algorithm in <b>pAlgorithmPacket</b>. The
    ///length, in bytes, and composition of <b>pSignature</b> are determined by <b>pAlgorithmPacket</b>.
    ubyte*       pSignature;
    ///If <b>wError</b> contains the RCODE, <b>BADTIME</b>, <b>pOtherData</b> is a BYTE array that contains the server's
    ///current time, otherwise it is <b>NULL</b>. Time is expressed in seconds since the beginning of January 1, 1970,
    ///Greenwich Mean Time (GMT), excluding leap seconds.
    ubyte*       pOtherData;
    ///The time <b>pSignature</b> was generated, expressed in seconds since the beginning of January 1, 1970, Greenwich
    ///Mean Time (GMT), excluding leap seconds.
    long         i64CreateTime;
    ///The time, in seconds, <b>i64CreateTime</b> may be in error.
    ushort       wFudgeTime;
    ///The Xid identifier of the original message.
    ushort       wOriginalXid;
    ///An error, expressed in expanded RCODE format that covers TSIG and TKEY RR processing. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="DNS_RCODE_BADSIG"></a><a id="dns_rcode_badsig"></a><dl>
    ///<dt><b>DNS_RCODE_BADSIG</b></dt> </dl> </td> <td width="60%"> The <b>pSignature</b> field is bad. </td> </tr>
    ///<tr> <td width="40%"><a id="DNS_RCODE_BADKEY"></a><a id="dns_rcode_badkey"></a><dl>
    ///<dt><b>DNS_RCODE_BADKEY</b></dt> </dl> </td> <td width="60%"> The <b>pKey</b> field of the DNS_TKEY_DATA RR is
    ///bad. </td> </tr> <tr> <td width="40%"><a id="DNS_RCODE_BADTIME"></a><a id="dns_rcode_badtime"></a><dl>
    ///<dt><b>DNS_RCODE_BADTIME</b></dt> </dl> </td> <td width="60%"> A timestamp is bad. </td> </tr> </table>
    ushort       wError;
    ///The length, in bytes, of the <b>pSignature</b> member.
    ushort       wSigLength;
    ///The length, in bytes, of the <b>pOtherData</b> member.
    ushort       wOtherLength;
    ///The length, in bytes, of the <b>pAlgorithmPacket</b> member.
    ubyte        cAlgNameLength;
    ///Reserved for future use. Do not use.
    BOOL         bPacketPointers;
}

struct DNS_UNKNOWN_DATA
{
    uint     dwByteCount;
    ubyte[1] bData;
}

///The <b>DNS_WINS_DATA</b> structure represents a DNS Windows Internet Name Service (WINS) record.
struct DNS_WINS_DATA
{
    ///The WINS mapping flag that specifies whether the record must be included in zone replication.
    ///<b>dwMappingFlag</b> must be one of these mutually exclusive values: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="DNS_WINS_FLAG_SCOPE"></a><a id="dns_wins_flag_scope"></a><dl>
    ///<dt><b>DNS_WINS_FLAG_SCOPE</b></dt> </dl> </td> <td width="60%"> Record is not local, replicate across zones.
    ///</td> </tr> <tr> <td width="40%"><a id="DNS_WINS_FLAG_LOCAL"></a><a id="dns_wins_flag_local"></a><dl>
    ///<dt><b>DNS_WINS_FLAG_LOCAL</b></dt> </dl> </td> <td width="60%"> Record is local, do not replicate. </td> </tr>
    ///</table>
    uint    dwMappingFlag;
    ///The time, in seconds, that a DNS Server attempts resolution using WINS lookup.
    uint    dwLookupTimeout;
    ///The time, in seconds, that a DNS Server using WINS lookup may cache the WINS Server's response.
    uint    dwCacheTimeout;
    ///The number of WINS Servers listed in <b>WinsServers</b>.
    uint    cWinsServerCount;
    ///An array of IP4_ARRAY structures that contain the IPv4 address of the WINS lookup Servers.
    uint[1] WinsServers;
}

///The <b>DNS_WINSR_DATA</b> structure represents a DNS Windows Internet Name Service reverse-lookup (WINSR) record.
struct DNS_WINSR_DATAW
{
    ///The WINS mapping flag that specifies whether the record must be included into the zone replication.
    ///<b>dwMappingFlag</b> must be one of these mutually exclusive values: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="DNS_WINS_FLAG_SCOPE"></a><a id="dns_wins_flag_scope"></a><dl>
    ///<dt><b>DNS_WINS_FLAG_SCOPE</b></dt> </dl> </td> <td width="60%"> Record is not local, replicate across zones.
    ///</td> </tr> <tr> <td width="40%"><a id="DNS_WINS_FLAG_LOCAL"></a><a id="dns_wins_flag_local"></a><dl>
    ///<dt><b>DNS_WINS_FLAG_LOCAL</b></dt> </dl> </td> <td width="60%"> Record is local, do not replicate. </td> </tr>
    ///</table>
    uint          dwMappingFlag;
    ///The time, in seconds, that a DNS Server attempts resolution using WINS lookup.
    uint          dwLookupTimeout;
    ///The time, in seconds, that a DNS Server using WINS lookup may cache the WINS Server's response.
    uint          dwCacheTimeout;
    ///A pointer to a string that represents the domain name to append to the name returned by a WINS reverse-lookup.
    const(wchar)* pNameResultDomain;
}

///The <b>DNS_WINSR_DATA</b> structure represents a DNS Windows Internet Name Service reverse-lookup (WINSR) record.
struct DNS_WINSR_DATAA
{
    ///The WINS mapping flag that specifies whether the record must be included into the zone replication.
    ///<b>dwMappingFlag</b> must be one of these mutually exclusive values: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="DNS_WINS_FLAG_SCOPE"></a><a id="dns_wins_flag_scope"></a><dl>
    ///<dt><b>DNS_WINS_FLAG_SCOPE</b></dt> </dl> </td> <td width="60%"> Record is not local, replicate across zones.
    ///</td> </tr> <tr> <td width="40%"><a id="DNS_WINS_FLAG_LOCAL"></a><a id="dns_wins_flag_local"></a><dl>
    ///<dt><b>DNS_WINS_FLAG_LOCAL</b></dt> </dl> </td> <td width="60%"> Record is local, do not replicate. </td> </tr>
    ///</table>
    uint         dwMappingFlag;
    ///The time, in seconds, that a DNS Server attempts resolution using WINS lookup.
    uint         dwLookupTimeout;
    ///The time, in seconds, that a DNS Server using WINS lookup may cache the WINS Server's response.
    uint         dwCacheTimeout;
    ///A pointer to a string that represents the domain name to append to the name returned by a WINS reverse-lookup.
    const(char)* pNameResultDomain;
}

///The <b>DNS_RECORD_FLAGS</b> structure is used to set flags for use in the DNS_RECORD structure.
struct DNS_RECORD_FLAGS
{
    uint _bitfield35;
}

///The <b>DNS_RECORD</b> structure stores a DNS resource record (RR).
struct DNS_RECORDW
{
    ///A pointer to the next <b>DNS_RECORD</b> structure.
    DNS_RECORDW*  pNext;
    ///A pointer to a string that represents the domain name of the record set. This must be in the string format that
    ///corresponds to the function called, such as ANSI, Unicode, or UTF8.
    const(wchar)* pName;
    ///A value that represents the RR DNS Record Type. <b>wType</b> determines the format of <b>Data</b>. For example,
    ///if the value of <b>wType</b> is <b>DNS_TYPE_A</b>, the data type of <b>Data</b> is DNS_A_DATA.
    ushort        wType;
    ///The length, in bytes, of <b>Data</b>. For fixed-length data types, this value is the size of the corresponding
    ///data type, such as <b>sizeof(DNS_A_DATA)</b>. For the non-fixed data types, use one of the following macros to
    ///determine the length of the data: <div class="code"><span codelanguage="ManagedCPlusPlus"><table> <tr>
    ///<th>C++</th> </tr> <tr> <td> <pre>
    ushort        wDataLength;
    union Flags
    {
        uint             DW;
        DNS_RECORD_FLAGS S;
    }
    ///The DNS RR's Time To Live value (TTL), in seconds.
    uint          dwTtl;
    ///Reserved. Do not use.
    uint          dwReserved;
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
        DNS_UNKNOWN_DATA    UNKNOWN;
        DNS_UNKNOWN_DATA    Unknown;
        ubyte*              pDataPtr;
    }
}

struct _DnsRecordOptW
{
    DNS_RECORDW*   pNext;
    const(wchar)*  pName;
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

///The <b>DNS_RECORD</b> structure stores a DNS resource record (RR).
struct DNS_RECORDA
{
    ///A pointer to the next <b>DNS_RECORD</b> structure.
    DNS_RECORDA* pNext;
    ///A pointer to a string that represents the domain name of the record set. This must be in the string format that
    ///corresponds to the function called, such as ANSI, Unicode, or UTF8.
    const(char)* pName;
    ///A value that represents the RR DNS Record Type. <b>wType</b> determines the format of <b>Data</b>. For example,
    ///if the value of <b>wType</b> is <b>DNS_TYPE_A</b>, the data type of <b>Data</b> is DNS_A_DATA.
    ushort       wType;
    ///The length, in bytes, of <b>Data</b>. For fixed-length data types, this value is the size of the corresponding
    ///data type, such as <b>sizeof(DNS_A_DATA)</b>. For the non-fixed data types, use one of the following macros to
    ///determine the length of the data: <div class="code"><span codelanguage="ManagedCPlusPlus"><table> <tr>
    ///<th>C++</th> </tr> <tr> <td> <pre>
    ushort       wDataLength;
    union Flags
    {
        uint             DW;
        DNS_RECORD_FLAGS S;
    }
    ///The DNS RR's Time To Live value (TTL), in seconds.
    uint         dwTtl;
    ///Reserved. Do not use.
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
        DNS_UNKNOWN_DATA    UNKNOWN;
        DNS_UNKNOWN_DATA    Unknown;
        ubyte*              pDataPtr;
    }
}

struct _DnsRecordOptA
{
    DNS_RECORDA*   pNext;
    const(char)*   pName;
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

///The <b>DNS_RRSET</b> structure contains information about a DNS Resource Record (RR) set.
struct DNS_RRSET
{
    ///A pointer to a DNS_RECORD structure that contains the first DNS RR in the set.
    DNS_RECORDA* pFirstRR;
    ///A pointer to a DNS_RECORD structure that contains the last DNS RR in the set.
    DNS_RECORDA* pLastRR;
}

///The <b>DNS_PROXY_INFORMATION</b> structure contains the proxy information for a DNS server's name resolution policy
///table.
struct DNS_PROXY_INFORMATION
{
    ///A value that specifies the structure version. This value must be 1.
    uint          version_;
    ///A DNS_PROXY_INFORMATION_TYPE enumeration that contains the proxy information type.
    DNS_PROXY_INFORMATION_TYPE proxyInformationType;
    ///A pointer to a string that contains the proxy server name if <b>proxyInformationType</b> is
    ///<b>DNS_PROXY_INFORMATION_PROXY_NAME</b>. Otherwise, this member is ignored. <div class="alert"><b>Note</b> To
    ///free this string, use the DnsFreeProxyName function.</div> <div> </div>
    const(wchar)* proxyName;
}

///A <b>DNS_QUERY_RESULT</b> structure contains the DNS query results returned from a call to DnsQueryEx.
struct DNS_QUERY_RESULT
{
    ///The structure version must be one of the following:
    uint         Version;
    ///The return status of the call to DnsQueryEx. If the query was completed asynchronously and this structure was
    ///returned directly from DnsQueryEx, <b>QueryStatus</b> contains <b>DNS_REQUEST_PENDING</b>. If the query was
    ///completed synchronously or if this structure was returned by the DNS_QUERY_COMPLETION_ROUTINE DNS callback,
    ///<b>QueryStatus</b> contains ERROR_SUCCESS if successful or the appropriate DNS-specific error code as defined in
    ///Winerror.h.
    int          QueryStatus;
    ///A value that contains a bitmap of DNS Query Options that were used in the DNS query. Options can be combined and
    ///all options override <b>DNS_QUERY_STANDARD</b>
    ulong        QueryOptions;
    ///A pointer to a DNS_RECORD structure. If the query was completed asynchronously and this structure was returned
    ///directly from DnsQueryEx, <b>pQueryRecords</b> is NULL. If the query was completed synchronously or if this
    ///structure was returned by the DNS_QUERY_COMPLETION_ROUTINE DNS callback, <b>pQueryRecords</b> contains a list of
    ///Resource Records (RR) that comprise the response. <div class="alert"><b>Note</b> Applications must free returned
    ///RR sets with the DnsRecordListFree function.</div> <div> </div>
    DNS_RECORDA* pQueryRecords;
    void*        Reserved;
}

///The <b>DNS_QUERY_REQUEST</b> structure contains the DNS query parameters used in a call to DnsQueryEx.
struct DNS_QUERY_REQUEST
{
    ///The structure version must be one of the following:
    uint            Version;
    ///A pointer to a string that represents the DNS name to query. <div class="alert"><b>Note</b> If <b>QueryName</b>
    ///is NULL, the query is for the local machine name.</div> <div> </div>
    const(wchar)*   QueryName;
    ///A value that represents the Resource Record (RR) DNS Record Type that is queried. <b>QueryType</b> determines the
    ///format of data pointed to by <b>pQueryRecords</b> returned in the DNS_QUERY_RESULT structure. For example, if the
    ///value of <b>wType</b> is <b>DNS_TYPE_A</b>, the format of data pointed to by <b>pQueryRecords</b> is DNS_A_DATA.
    ushort          QueryType;
    ///A value that contains a bitmap of DNS Query Options to use in the DNS query. Options can be combined and all
    ///options override <b>DNS_QUERY_STANDARD</b>
    ulong           QueryOptions;
    ///A pointer to a DNS_ADDR_ARRAY structure that contains a list of DNS servers to use in the query.
    DNS_ADDR_ARRAY* pDnsServerList;
    ///A value that contains the interface index over which the query is sent. If <b>InterfaceIndex</b> is 0, all
    ///interfaces will be considered.
    uint            InterfaceIndex;
    ///A pointer to a DNS_QUERY_COMPLETION_ROUTINE callback that is used to return the results of an asynchronous query
    ///from a call to DnsQueryEx. <div class="alert"><b>Note</b> If NULL, DnsQueryEx is called synchronously.</div>
    ///<div> </div>
    PDNS_QUERY_COMPLETION_ROUTINE pQueryCompletionCallback;
    ///A pointer to a user context.
    void*           pQueryContext;
}

///A <b>DNS_QUERY_CANCEL</b> structure can be used to cancel an asynchronous DNS query.
struct DNS_QUERY_CANCEL
{
    ///Contains a handle to the asynchronous query to cancel. Applications must not modify this value.
    byte[32] Reserved;
}

///The <b>DNS_MESSAGE_BUFFER</b> structure stores message information for DNS queries.
struct DNS_MESSAGE_BUFFER
{
    ///A DNS_HEADER structure that contains the header for the DNS message.
    DNS_HEADER MessageHead;
    ///An array of characters that comprises the DNS query or resource records (RR).
    byte[1]    MessageBody;
}

struct DNS_CONNECTION_PROXY_INFO
{
    uint    Version;
    ushort* pwszFriendlyName;
    uint    Flags;
    DNS_CONNECTION_PROXY_INFO_SWITCH Switch;
    union
    {
        struct Config
        {
            ushort* pwszServer;
            ushort* pwszUsername;
            ushort* pwszPassword;
            ushort* pwszException;
            ushort* pwszExtraInfo;
            ushort  Port;
        }
        struct Script
        {
            ushort* pwszScript;
            ushort* pwszUsername;
            ushort* pwszPassword;
        }
    }
}

struct DNS_CONNECTION_PROXY_INFO_EX
{
    DNS_CONNECTION_PROXY_INFO ProxyInfo;
    uint    dwInterfaceIndex;
    ushort* pwszConnectionName;
    BOOL    fDirectConfiguration;
    HANDLE  hConnection;
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
    ushort[65] wszName;
}

struct DNS_CONNECTION_NAME_LIST
{
    uint                 cNames;
    DNS_CONNECTION_NAME* pNames;
}

struct DNS_CONNECTION_IFINDEX_ENTRY
{
    const(wchar)* pwszConnectionName;
    uint          dwIfIndex;
}

struct DNS_CONNECTION_IFINDEX_LIST
{
    DNS_CONNECTION_IFINDEX_ENTRY* pConnectionIfIndexEntries;
    uint nEntries;
}

struct DNS_CONNECTION_POLICY_ENTRY
{
    const(wchar)* pwszHost;
    const(wchar)* pwszAppId;
    uint          cbAppSid;
    ubyte*        pbAppSid;
    uint          nConnections;
    ushort**      ppwszConnections;
    uint          dwPolicyEntryFlags;
}

struct DNS_CONNECTION_POLICY_ENTRY_LIST
{
    DNS_CONNECTION_POLICY_ENTRY* pPolicyEntries;
    uint nEntries;
}

///Represents a DNS service running on the network.
struct DNS_SERVICE_INSTANCE
{
    ///A string that represents the service name. This is a fully qualified domain name that begins with a service name,
    ///and ends with ".local". It takes the generalized form
    ///"\<ServiceName\>.\_\<ServiceType\>.\_\<TransportProtocol\>.local". For example, "MyMusicServer._http._tcp.local".
    const(wchar)* pszInstanceName;
    ///A string that represents the name of the host of the service.
    const(wchar)* pszHostName;
    ///A pointer to an **IP4_ADDRESS** structure that represents the service-associated IPv4 address.
    uint*         ip4Address;
    ///A pointer to an [IP6_ADDRESS](/windows/desktop/api/windns/ns-windns-ip6_address_1) structure that represents the
    ///service-associated IPv6 address.
    IP6_ADDRESS*  ip6Address;
    ///A value that represents the port on which the service is running.
    ushort        wPort;
    ///A value that represents the service priority.
    ushort        wPriority;
    ///A value that represents the service weight.
    ushort        wWeight;
    ///The number of properties&mdash;defines the number of elements in the arrays of the `keys` and `values`
    ///parameters.
    uint          dwPropertyCount;
    ushort**      keys;
    ushort**      values;
    ///A value that contains the interface index on which the service was discovered.
    uint          dwInterfaceIndex;
}

///Used to cancel an asynchronous DNS-SD operation.
struct DNS_SERVICE_CANCEL
{
    ///Contains a handle associated with the asynchronous operation to cancel. Your application must not modify this
    ///value.
    void* reserved;
}

///Contains the query parameters used in a call to [DnsServiceBrowse](nf-windns-dnsservicebrowse.md).
struct DNS_SERVICE_BROWSE_REQUEST
{
    ///The structure version must be either **DNS_QUERY_REQUEST_VERSION1** or **DNS_QUERY_REQUEST_VERSION2**. The value
    ///determines which of `pBrowseCallback` or `pBrowseCallbackV2` is active.
    uint          Version;
    ///A value that contains the interface index over which the query is sent. If `InterfaceIndex` is 0, then all
    ///interfaces will be considered.
    uint          InterfaceIndex;
    ///A pointer to a string that represents the service type whose matching services you wish to browse for. It takes
    ///the generalized form "\_\<ServiceType\>.\_\<TransportProtocol\>.local". For example, "_http._tcp.local", which
    ///defines a query to browse for http services on the local link.
    const(wchar)* QueryName;
    union
    {
        PDNS_SERVICE_BROWSE_CALLBACK pBrowseCallback;
        DNS_QUERY_COMPLETION_ROUTINE* pBrowseCallbackV2;
    }
    ///A pointer to a user context.
    void*         pQueryContext;
}

///Contains the query parameters used in a call to [DnsServiceResolve](nf-windns-dnsserviceresolve.md). Use that
///function, and this structure, after you've found a specific service name that you'd like to connect to.
struct DNS_SERVICE_RESOLVE_REQUEST
{
    ///The structure version must be **DNS_QUERY_REQUEST_VERSION1**.
    uint          Version;
    ///A value that contains the interface index over which the query is sent. If `InterfaceIndex` is 0, then all
    ///interfaces will be considered.
    uint          InterfaceIndex;
    ///A pointer to a string that represents the service name. This is a fully qualified domain name that begins with a
    ///service name, and ends with ".local". It takes the generalized form
    ///"\<ServiceName\>.\_\<ServiceType\>.\_\<TransportProtocol\>.local". For example, "MyMusicServer._http._tcp.local".
    const(wchar)* QueryName;
    ///A pointer to a function (of type [DNS_SERVICE_RESOLVE_COMPLETE](nc-windns-dns_service_resolve_complete.md)) that
    ///represents the callback to be invoked asynchronously.
    PDNS_SERVICE_RESOLVE_COMPLETE pResolveCompletionCallback;
    ///A pointer to a user context.
    void*         pQueryContext;
}

///Contains the information necessary to advertise a service using
///[DnsServiceRegister](nf-windns-dnsserviceregister.md), or to stop advertising it using
///[DnsServiceDeRegister](nf-windns-dnsservicederegister.md).
struct DNS_SERVICE_REGISTER_REQUEST
{
    ///The structure version must be **DNS_QUERY_REQUEST_VERSION1**.
    uint   Version;
    ///A value that contains the interface index over which the service is to be advertised. If `InterfaceIndex` is 0,
    ///then all interfaces will be considered.
    uint   InterfaceIndex;
    ///A pointer to a [DNS_SERVICE_INSTANCE](ns-windns-dns_service_instance.md) structure that describes the service to
    ///be registered.
    DNS_SERVICE_INSTANCE* pServiceInstance;
    ///A pointer to a function (of type [DNS_SERVICE_REGISTER_COMPLETE](nc-windns-dns_service_register_complete.md))
    ///that represents the callback to be invoked asynchronously.
    PDNS_SERVICE_REGISTER_COMPLETE pRegisterCompletionCallback;
    ///A pointer to a user context.
    void*  pQueryContext;
    ///Not used.
    HANDLE hCredentials;
    ///`true` if the DNS protocol should be used to advertise the service; `false` if the mDNS protocol should be used.
    BOOL   unicastEnabled;
}

///Contains information related to an ongoing MDNS query. Your application must not modify its contents.
struct MDNS_QUERY_HANDLE
{
    ///A value representing the queried name.
    ushort[256] nameBuf;
    ///A value representing the type of the query.
    ushort      wType;
    ///Reserved. Do not use.
    void*       pSubscription;
    ///Reserved. Do not use.
    void*       pWnfCallbackParams;
    ///Reserved. Do not use.
    uint[2]     stateNameData;
}

///Contains the necessary information to perform an mDNS query.
struct MDNS_QUERY_REQUEST
{
    ///The structure version must be **DNS_QUERY_REQUEST_VERSION1**.
    uint                 Version;
    ///Reserved. Do not use.
    uint                 ulRefCount;
    ///A string representing the name to be queried over mDNS.
    const(wchar)*        Query;
    ///A value representing the type of the records to be queried. See
    ///[DNS_RECORD_TYPE](/openspecs/windows_protocols/ms-dnsp/39b03b89-2264-4063-8198-d62f62a6441a) for possible values.
    ushort               QueryType;
    ///A value representing the query options. **DNS_QUERY_STANDARD** is the only supported value.
    ulong                QueryOptions;
    ///A value that contains the interface index over which the service is to be advertised. If `InterfaceIndex` is 0,
    ///then all interfaces will be considered.
    uint                 InterfaceIndex;
    ///A pointer to a function (of type [MDNS_QUERY_CALLBACK](nc-windns-mdns_query_callback.md)) that represents the
    ///callback to be invoked asynchronously whenever mDNS results are available.
    PMDNS_QUERY_CALLBACK pQueryCallback;
    ///A pointer to a user context.
    void*                pQueryContext;
    ///Reserved. Do not use.
    BOOL                 fAnswerReceived;
    ///Reserved. Do not use.
    uint                 ulResendCount;
}

alias DnsContextHandle = ptrdiff_t;

// Functions

///The <b>DnsQueryConfig</b> function enables application programmers to query for the configuration of the local
///computer or a specific adapter.
///Params:
///    Config = A DNS_CONFIG_TYPE value that specifies the configuration type of the information to be queried.
///    Flag = A value that specifies whether to allocate memory for the configuration information. Set <i>Flag</i> to
///           <b>DNS_CONFIG_FLAG_ALLOC </b> to allocate memory; otherwise, set it to 0. <div class="alert"><b>Note</b> Free the
///           allocated memory with LocalFree.</div> <div> </div>
///    pwsAdapterName = A pointer to a string that represents the adapter name against which the query is run.
///    pReserved = Reserved for future use.
///    pBuffer = A pointer to a buffer that receives the query response. The following table shows the data type of the buffer for
///              each of the <i>Config</i> parameter values. <table> <tr> <th><i>Config</i> parameter</th> <th>Data type of
///              buffer</th> </tr> <tr> <td>DnsConfigPrimaryDomainName_W</td> <td>PWCHAR</td> </tr> <tr>
///              <td>DnsConfigPrimaryDomainName_A</td> <td>PCHAR</td> </tr> <tr> <td>DnsConfigPrimaryDomainName_UTF8</td>
///              <td>PCHAR</td> </tr> <tr> <td>DnsConfigAdapterDomainName_W</td> <td>Not implemented</td> </tr> <tr>
///              <td>DnsConfigAdapterDomainName_A</td> <td>Not implemented</td> </tr> <tr>
///              <td>DnsConfigAdapterDomainName_UTF8</td> <td>Not implemented</td> </tr> <tr> <td>DnsConfigDnsServerList</td>
///              <td>IP4_ARRAY</td> </tr> <tr> <td>DnsConfigSearchList</td> <td>Not implemented</td> </tr> <tr>
///              <td>DnsConfigAdapterInfo</td> <td>Not implemented</td> </tr> <tr>
///              <td>DnsConfigPrimaryHostNameRegistrationEnabled</td> <td>DWORD</td> </tr> <tr>
///              <td>DnsConfigAdapterHostNameRegistrationEnabled</td> <td>DWORD</td> </tr> <tr>
///              <td>DnsConfigAddressRegistrationMaxCount</td> <td>DWORD</td> </tr> <tr> <td>DnsConfigHostName_W</td>
///              <td>PWCHAR</td> </tr> <tr> <td>DnsConfigHostName_A</td> <td>PCHAR</td> </tr> <tr> <td>DnsConfigHostName_UTF8</td>
///              <td>PCHAR</td> </tr> <tr> <td>DnsConfigFullHostName_W</td> <td>PWCHAR</td> </tr> <tr>
///              <td>DnsConfigFullHostName_A</td> <td>PCHAR</td> </tr> <tr> <td>DnsConfigFullHostName_UTF8</td> <td>PCHAR</td>
///              </tr> </table>
///    pBufLen = The length of the buffer, in bytes. If the buffer provided is not sufficient, an error is returned and
///              <i>pBufferLength</i> contains the minimum necessary buffer size. Ignored on input if <i>Flag</i> is set to
///              <b>TRUE</b>.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsQueryConfig(DNS_CONFIG_TYPE Config, uint Flag, const(wchar)* pwsAdapterName, void* pReserved, char* pBuffer, 
                   uint* pBufLen);

///The <b>DnsRecordCopyEx</b> function creates a copy of a specified resource record (RR). The <b>DnsRecordCopyEx</b>
///function is also capable of converting the character encoding during the copy operation.
///Params:
///    pRecord = A pointer to a DNS_RECORD structure that contains the RR to be copied.
///    CharSetIn = A DNS_CHARSET value that specifies the character encoding of the source RR.
///    CharSetOut = A DNS_CHARSET value that specifies the character encoding required of the destination record.
///Returns:
///    Successful execution returns a pointer to the (newly created) destination record. Otherwise, returns null.
///    
@DllImport("DNSAPI")
DNS_RECORDA* DnsRecordCopyEx(DNS_RECORDA* pRecord, DNS_CHARSET CharSetIn, DNS_CHARSET CharSetOut);

///The <b>DnsRecordSetCopyEx</b> function creates a copy of a specified resource record set. The
///<b>DnsRecordSetCopyEx</b> function is also capable of converting the character encoding during the copy operation.
///Params:
///    pRecordSet = A pointer to a DNS_RECORD structure that contains the resource record set to be copied.
///    CharSetIn = A DNS_CHARSET value that specifies the character encoding of the source resource record set.
///    CharSetOut = A DNS_CHARSET value that specifies the character encoding required of the destination record set.
///Returns:
///    Successful execution returns a pointer to the newly created destination record set. Otherwise, it returns null.
///    
@DllImport("DNSAPI")
DNS_RECORDA* DnsRecordSetCopyEx(DNS_RECORDA* pRecordSet, DNS_CHARSET CharSetIn, DNS_CHARSET CharSetOut);

///The <b>DnsRecordCompare</b> function compares two DNS resource records (RR).
///Params:
///    pRecord1 = A pointer to a DNS_RECORD structure that contains the first DNS RR of the comparison pair.
///    pRecord2 = A pointer to a DNS_RECORD structure that contains the second DNS RR of the comparison pair.
///Returns:
///    Returns <b>TRUE</b> if the compared records are equivalent, <b>FALSE</b> if they are not.
///    
@DllImport("DNSAPI")
BOOL DnsRecordCompare(DNS_RECORDA* pRecord1, DNS_RECORDA* pRecord2);

///The <b>DnsRecordSetCompare</b> function compares two RR sets.
///Params:
///    pRR1 = A pointer to a DNS_RECORD structure that contains the first DNS RR set of the comparison pair.
///    pRR2 = A pointer to a DNS_RECORD structure that contains the second DNS resource record set of the comparison pair.
///    ppDiff1 = A pointer to a DNS_RECORD pointer that contains the list of resource records built as a result of the arithmetic
///              performed on them: <b>pRRSet1</b> minus <b>pRRSet2</b>.
///    ppDiff2 = A pointer to a DNS_RECORD pointer that contains the list of resource records built as a result of the arithmetic
///              performed on them: <b>pRRSet2</b> minus <b>pRRSet1</b>.
///Returns:
///    Returns <b>TRUE</b> if the compared record sets are equivalent, <b>FALSE</b> if they are not.
///    
@DllImport("DNSAPI")
BOOL DnsRecordSetCompare(DNS_RECORDA* pRR1, DNS_RECORDA* pRR2, DNS_RECORDA** ppDiff1, DNS_RECORDA** ppDiff2);

///The <b>DnsRecordSetDetach</b> function detaches the first record set from a specified list of DNS records.
///Params:
///    pRecordList = A pointer, on input, to a DNS_RECORD structure that contains the list prior to the detachment of the first DNS
///                  record in the list of DNS records. A pointer, on output to a <b>DNS_RECORD</b> structure that contains the list
///                  subsequent to the detachment of the DNS record.
///Returns:
///    On return, the <b>DnsRecordSetDetach</b> function points to the detached DNS record set.
///    
@DllImport("DNSAPI")
DNS_RECORDA* DnsRecordSetDetach(DNS_RECORDA* pRecordList);

///The <b>DnsFree</b> function frees memory allocated for DNS records that was obtained using the DnsQuery function.
///Params:
///    pData = A pointer to the DNS data to be freed.
///    FreeType = A value that specifies the type of DNS data in <i>pData</i>. For more information and a list of values, see the
///               DNS_FREE_TYPE enumeration.
@DllImport("DNSAPI")
void DnsFree(void* pData, DNS_FREE_TYPE FreeType);

///The <b>DnsQuery</b> function type is the generic query interface to the DNS namespace, and provides application
///developers with a DNS query resolution interface. Like many DNS functions, the <b>DnsQuery</b> function type is
///implemented in multiple forms to facilitate different character encoding. Based on the character encoding involved,
///use one of the following functions: <ul> <li><b>DnsQuery_A</b> (for ANSI encoding)</li> <li><b>DnsQuery_W</b> (for
///Unicode encoding)</li> <li><b>DnsQuery_UTF8</b> (for UTF-8 encoding)</li> </ul>Windows 8: The DnsQueryEx function
///should be used if an application requires asynchronous querries to the DNS namespace.
///Params:
///    pszName = A pointer to a string that represents the DNS name to query.
///    wType = A value that represents the Resource Record (RR)DNS Record Type that is queried. <b>wType</b> determines the
///            format of data pointed to by <b>ppQueryResultsSet</b>. For example, if the value of <b>wType</b> is
///            <b>DNS_TYPE_A</b>, the format of data pointed to by <b>ppQueryResultsSet</b> is DNS_A_DATA.
///    Options = A value that contains a bitmap of DNS Query Options to use in the DNS query. Options can be combined and all
///              options override <b>DNS_QUERY_STANDARD</b>.
///    pExtra = This parameter is reserved for future use and must be set to <b>NULL</b>.
///    ppQueryResults = Optional. A pointer to a pointer that points to the list of RRs that comprise the response. For more information,
///                     see the Remarks section.
///    pReserved = This parameter is reserved for future use and must be set to <b>NULL</b>.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsQuery_A(const(char)* pszName, ushort wType, uint Options, void* pExtra, DNS_RECORDA** ppQueryResults, 
               void** pReserved);

///The <b>DnsQuery</b> function type is the generic query interface to the DNS namespace, and provides application
///developers with a DNS query resolution interface. Like many DNS functions, the <b>DnsQuery</b> function type is
///implemented in multiple forms to facilitate different character encoding. Based on the character encoding involved,
///use one of the following functions: <ul> <li><b>DnsQuery_A</b> (for ANSI encoding)</li> <li><b>DnsQuery_W</b> (for
///Unicode encoding)</li> <li><b>DnsQuery_UTF8</b> (for UTF-8 encoding)</li> </ul>Windows 8: The DnsQueryEx function
///should be used if an application requires asynchronous querries to the DNS namespace.
///Params:
///    pszName = A pointer to a string that represents the DNS name to query.
///    wType = A value that represents the Resource Record (RR)DNS Record Type that is queried. <b>wType</b> determines the
///            format of data pointed to by <b>ppQueryResultsSet</b>. For example, if the value of <b>wType</b> is
///            <b>DNS_TYPE_A</b>, the format of data pointed to by <b>ppQueryResultsSet</b> is DNS_A_DATA.
///    Options = A value that contains a bitmap of DNS Query Options to use in the DNS query. Options can be combined and all
///              options override <b>DNS_QUERY_STANDARD</b>.
///    pExtra = This parameter is reserved for future use and must be set to <b>NULL</b>.
///    ppQueryResults = Optional. A pointer to a pointer that points to the list of RRs that comprise the response. For more information,
///                     see the Remarks section.
///    pReserved = This parameter is reserved for future use and must be set to <b>NULL</b>.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsQuery_UTF8(const(char)* pszName, ushort wType, uint Options, void* pExtra, DNS_RECORDA** ppQueryResults, 
                  void** pReserved);

///The <b>DnsQuery</b> function type is the generic query interface to the DNS namespace, and provides application
///developers with a DNS query resolution interface. Like many DNS functions, the <b>DnsQuery</b> function type is
///implemented in multiple forms to facilitate different character encoding. Based on the character encoding involved,
///use one of the following functions: <ul> <li><b>DnsQuery_A</b> (for ANSI encoding)</li> <li><b>DnsQuery_W</b> (for
///Unicode encoding)</li> <li><b>DnsQuery_UTF8</b> (for UTF-8 encoding)</li> </ul>Windows 8: The DnsQueryEx function
///should be used if an application requires asynchronous querries to the DNS namespace.
///Params:
///    pszName = A pointer to a string that represents the DNS name to query.
///    wType = A value that represents the Resource Record (RR)DNS Record Type that is queried. <b>wType</b> determines the
///            format of data pointed to by <b>ppQueryResultsSet</b>. For example, if the value of <b>wType</b> is
///            <b>DNS_TYPE_A</b>, the format of data pointed to by <b>ppQueryResultsSet</b> is DNS_A_DATA.
///    Options = A value that contains a bitmap of DNS Query Options to use in the DNS query. Options can be combined and all
///              options override <b>DNS_QUERY_STANDARD</b>.
///    pExtra = This parameter is reserved for future use and must be set to <b>NULL</b>.
///    ppQueryResults = Optional. A pointer to a pointer that points to the list of RRs that comprise the response. For more information,
///                     see the Remarks section.
///    pReserved = This parameter is reserved for future use and must be set to <b>NULL</b>.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsQuery_W(const(wchar)* pszName, ushort wType, uint Options, void* pExtra, DNS_RECORDA** ppQueryResults, 
               void** pReserved);

///The <b>DnsQueryEx</b> function is the asynchronous generic query interface to the DNS namespace, and provides
///application developers with a DNS query resolution interface. Like DnsQuery, <b>DnsQueryEx</b> can be used to make
///synchronous queries to the DNS namespace as well.
///Params:
///    pQueryRequest = A pointer to a DNS_QUERY_REQUEST structure that contains the query request information. <div
///                    class="alert"><b>Note</b> By omitting the DNS_QUERY_COMPLETION_ROUTINE callback from the
///                    <b>pQueryCompleteCallback</b> member of this structure, <b>DnsQueryEx</b> is called synchronously.</div> <div>
///                    </div>
///    pQueryResults = A pointer to a DNS_QUERY_RESULT structure that contains the results of the query. On input, the <b>version</b>
///                    member of <i>pQueryResults</i> must be <b>DNS_QUERY_REQUEST_VERSION1</b> and all other members should be
///                    <b>NULL</b>. On output, the remaining members will be filled as part of the query complete. <div
///                    class="alert"><b>Note</b> For asynchronous queries, an application should not free this structure until the
///                    DNS_QUERY_COMPLETION_ROUTINE callback is invoked. When the query completes, the DNS_QUERY_RESULT structure
///                    contains a pointer to a list of DNS_RECORDS that should be freed using DnsRecordListFree.</div> <div> </div>
///    pCancelHandle = A pointer to a DNS_QUERY_CANCEL structure that can be used to cancel a pending asynchronous query. <div
///                    class="alert"><b>Note</b> An application should not free this structure until the DNS_QUERY_COMPLETION_ROUTINE
///                    callback is invoked.</div> <div> </div>
///Returns:
///    The <b>DnsQueryEx</b> function has the following possible return values: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The call was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> Either the <i>pQueryRequest</i> or <i>pQueryRequest</i> parameters are uninitialized or
///    contain the wrong version. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DNS RCODE</b></dt> </dl> </td> <td
///    width="60%"> The call resulted in an RCODE error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DNS_INFO_NO_RECORDS</b></dt> </dl> </td> <td width="60%"> No records in the response. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DNS_REQUEST_PENDING</b></dt> </dl> </td> <td width="60%"> The query will be completed
///    asynchronously. </td> </tr> </table>
///    
@DllImport("DNSAPI")
int DnsQueryEx(DNS_QUERY_REQUEST* pQueryRequest, DNS_QUERY_RESULT* pQueryResults, DNS_QUERY_CANCEL* pCancelHandle);

///The <b>DnsCancelQuery</b> function can be used to cancel a pending query to the DNS namespace.
///Params:
///    pCancelHandle = A pointer to a DNS_QUERY_CANCEL structure used to cancel an asynchronous DNS query. The structure must have been
///                    returned in the <i>pCancelHandle</i> parameter of a previous call to DnsQueryEx.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, it returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsCancelQuery(DNS_QUERY_CANCEL* pCancelHandle);

///The <b>DnsAcquireContextHandle</b> function type acquires a context handle to a set of credentials. Like many DNS
///functions, the <b>DnsAcquireContextHandle</b> function type is implemented in multiple forms to facilitate different
///character encoding. Based on the character encoding involved, use one of the following functions: <ul> <li>
///<b>DnsAcquireContextHandle_A</b> (_A for ANSI encoding) </li> <li> <b>DnsAcquireContextHandle_W</b> (_W for Unicode
///encoding) </li> </ul>
///Params:
///    CredentialFlags = A flag that indicates the character encoding. Set to <b>TRUE</b> for Unicode, <b>FALSE</b> for ANSI.
///    Credentials = A pointer to a SEC_WINNT_AUTH_IDENTITY_W structure or a <b>SEC_WINNT_AUTH_IDENTITY_A</b> structure that contains
///                  the name, domain, and password of the account to be used in a secure dynamic update. If <i>CredentialFlags</i> is
///                  set to <b>TRUE</b>, <i>Credentials</i> points to a <b>SEC_WINNT_AUTH_IDENTITY_W</b> structure; otherwise,
///                  <i>Credentials</i> points to a <b>SEC_WINNT_AUTH_IDENTITY_A</b> structure. If not specified, the credentials of
///                  the calling service are used. This parameter is optional.
///    pContext = A pointer to a handle pointing to the returned credentials.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsAcquireContextHandle_W(uint CredentialFlags, void* Credentials, DnsContextHandle* pContext);

///The <b>DnsAcquireContextHandle</b> function type acquires a context handle to a set of credentials. Like many DNS
///functions, the <b>DnsAcquireContextHandle</b> function type is implemented in multiple forms to facilitate different
///character encoding. Based on the character encoding involved, use one of the following functions: <ul> <li>
///<b>DnsAcquireContextHandle_A</b> (_A for ANSI encoding) </li> <li> <b>DnsAcquireContextHandle_W</b> (_W for Unicode
///encoding) </li> </ul>
///Params:
///    CredentialFlags = A flag that indicates the character encoding. Set to <b>TRUE</b> for Unicode, <b>FALSE</b> for ANSI.
///    Credentials = A pointer to a SEC_WINNT_AUTH_IDENTITY_W structure or a <b>SEC_WINNT_AUTH_IDENTITY_A</b> structure that contains
///                  the name, domain, and password of the account to be used in a secure dynamic update. If <i>CredentialFlags</i> is
///                  set to <b>TRUE</b>, <i>Credentials</i> points to a <b>SEC_WINNT_AUTH_IDENTITY_W</b> structure; otherwise,
///                  <i>Credentials</i> points to a <b>SEC_WINNT_AUTH_IDENTITY_A</b> structure. If not specified, the credentials of
///                  the calling service are used. This parameter is optional.
///    pContext = A pointer to a handle pointing to the returned credentials.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsAcquireContextHandle_A(uint CredentialFlags, void* Credentials, DnsContextHandle* pContext);

///The <b>DnsReleaseContextHandle</b> function releases memory used to store the credentials of a specific account.
///Params:
///    hContext = The credentials handle of a specific account.
@DllImport("DNSAPI")
void DnsReleaseContextHandle(HANDLE hContext);

///The <b>DnsModifyRecordsInSet</b>function adds, modifies or removes a Resource Record (RR) set that may have been
///previously registered with DNS servers. Like many DNS functions, the <b>DnsModifyRecordsInSet</b> function type is
///implemented in multiple forms to facilitate different character encoding. Based on the character encoding involved,
///use one of the following functions: <ul> <li><b>DnsModifyRecordsInSet_A</b> (_A for ANSI encoding)</li>
///<li><b>DnsModifyRecordsInSet_W</b> (_W for Unicode encoding)</li> <li><b>DnsModifyRecordsInSet_UTF8</b> (_UTF8 for
///UTF 8 encoding)</li> </ul>
///Params:
///    pAddRecords = A pointer to the DNS_RECORD structure that contains the RRs to be added to the RR set.
///    pDeleteRecords = A pointer to the DNS_RECORD structure that contains the RRs to be deleted from the RR set.
///    Options = A value that contains a bitmap of DNS Update Options. Options can be combined and all options override
///              <b>DNS_UPDATE_SECURITY_USE_DEFAULT</b>.
///    hCredentials = A handle to the credentials of a specific account. Used when secure dynamic update is required. This parameter is
///                   optional.
///    pExtraList = This parameter is reserved for future use and must be set to <b>NULL</b>.
///    pReserved = This parameter is reserved for future use and must be set to <b>NULL</b>.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, it returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsModifyRecordsInSet_W(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, 
                            HANDLE hCredentials, void* pExtraList, void* pReserved);

///The <b>DnsModifyRecordsInSet</b>function adds, modifies or removes a Resource Record (RR) set that may have been
///previously registered with DNS servers. Like many DNS functions, the <b>DnsModifyRecordsInSet</b> function type is
///implemented in multiple forms to facilitate different character encoding. Based on the character encoding involved,
///use one of the following functions: <ul> <li><b>DnsModifyRecordsInSet_A</b> (_A for ANSI encoding)</li>
///<li><b>DnsModifyRecordsInSet_W</b> (_W for Unicode encoding)</li> <li><b>DnsModifyRecordsInSet_UTF8</b> (_UTF8 for
///UTF 8 encoding)</li> </ul>
///Params:
///    pAddRecords = A pointer to the DNS_RECORD structure that contains the RRs to be added to the RR set.
///    pDeleteRecords = A pointer to the DNS_RECORD structure that contains the RRs to be deleted from the RR set.
///    Options = A value that contains a bitmap of DNS Update Options. Options can be combined and all options override
///              <b>DNS_UPDATE_SECURITY_USE_DEFAULT</b>.
///    hCredentials = A handle to the credentials of a specific account. Used when secure dynamic update is required. This parameter is
///                   optional.
///    pExtraList = This parameter is reserved for future use and must be set to <b>NULL</b>.
///    pReserved = This parameter is reserved for future use and must be set to <b>NULL</b>.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, it returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsModifyRecordsInSet_A(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, 
                            HANDLE hCredentials, void* pExtraList, void* pReserved);

///The <b>DnsModifyRecordsInSet</b>function adds, modifies or removes a Resource Record (RR) set that may have been
///previously registered with DNS servers. Like many DNS functions, the <b>DnsModifyRecordsInSet</b> function type is
///implemented in multiple forms to facilitate different character encoding. Based on the character encoding involved,
///use one of the following functions: <ul> <li><b>DnsModifyRecordsInSet_A</b> (_A for ANSI encoding)</li>
///<li><b>DnsModifyRecordsInSet_W</b> (_W for Unicode encoding)</li> <li><b>DnsModifyRecordsInSet_UTF8</b> (_UTF8 for
///UTF 8 encoding)</li> </ul>
///Params:
///    pAddRecords = A pointer to the DNS_RECORD structure that contains the RRs to be added to the RR set.
///    pDeleteRecords = A pointer to the DNS_RECORD structure that contains the RRs to be deleted from the RR set.
///    Options = A value that contains a bitmap of DNS Update Options. Options can be combined and all options override
///              <b>DNS_UPDATE_SECURITY_USE_DEFAULT</b>.
///    hCredentials = A handle to the credentials of a specific account. Used when secure dynamic update is required. This parameter is
///                   optional.
///    pExtraList = This parameter is reserved for future use and must be set to <b>NULL</b>.
///    pReserved = This parameter is reserved for future use and must be set to <b>NULL</b>.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, it returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsModifyRecordsInSet_UTF8(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, 
                               HANDLE hCredentials, void* pExtraList, void* pReserved);

///The <b>DnsReplaceRecordSet</b> function type replaces an existing resource record (RR) set. Like many DNS functions,
///the <b>DnsReplaceRecordSet</b> function type is implemented in multiple forms to facilitate different character
///encoding, which is indicated by a suffix. Based on the character encoding involved, use one of the following
///functions: <b>DnsReplaceRecordSetA</b> (_A for ANSI encoding) <b>DnsReplaceRecordSetW</b> (_W for Unicode encoding)
///<b>DnsReplaceRecordSetUTF8</b> (_UTF8 for UTF 8 encoding) Be aware of the lack of an underscore between the function
///type name and its suffix. If the <b>DnsReplaceRecordSet</b> function type is called without its suffix (A, W, or
///UTF8), a compiler error will occur.
///Params:
///    pReplaceSet = A pointer to a DNS_RECORD structure that contains the RR set that replaces the existing set. The specified RR set
///                  is replaced with the contents of <i>pNewSet</i>. To delete a RR set, specify the set in <i>pNewSet</i>, but set
///                  <i>RDATA</i> to <b>NULL</b>.
///    Options = A value that contains a bitmap of DNS Update Options. Options can be combined and all options override
///              <b>DNS_UPDATE_SECURITY_USE_DEFAULT</b>.
///    hContext = The handle to the credentials of a specific account. Used when secure dynamic update is required. This parameter
///               is optional.
///    pExtraInfo = This parameter is reserved for future use and must be set to <b>NULL</b>.
///    pReserved = This parameter is reserved for future use and must be set to <b>NULL</b>.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsReplaceRecordSetW(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, 
                         void* pReserved);

///The <b>DnsReplaceRecordSet</b> function type replaces an existing resource record (RR) set. Like many DNS functions,
///the <b>DnsReplaceRecordSet</b> function type is implemented in multiple forms to facilitate different character
///encoding, which is indicated by a suffix. Based on the character encoding involved, use one of the following
///functions: <b>DnsReplaceRecordSetA</b> (_A for ANSI encoding) <b>DnsReplaceRecordSetW</b> (_W for Unicode encoding)
///<b>DnsReplaceRecordSetUTF8</b> (_UTF8 for UTF 8 encoding) Be aware of the lack of an underscore between the function
///type name and its suffix. If the <b>DnsReplaceRecordSet</b> function type is called without its suffix (A, W, or
///UTF8), a compiler error will occur.
///Params:
///    pReplaceSet = A pointer to a DNS_RECORD structure that contains the RR set that replaces the existing set. The specified RR set
///                  is replaced with the contents of <i>pNewSet</i>. To delete a RR set, specify the set in <i>pNewSet</i>, but set
///                  <i>RDATA</i> to <b>NULL</b>.
///    Options = A value that contains a bitmap of DNS Update Options. Options can be combined and all options override
///              <b>DNS_UPDATE_SECURITY_USE_DEFAULT</b>.
///    hContext = The handle to the credentials of a specific account. Used when secure dynamic update is required. This parameter
///               is optional.
///    pExtraInfo = This parameter is reserved for future use and must be set to <b>NULL</b>.
///    pReserved = This parameter is reserved for future use and must be set to <b>NULL</b>.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsReplaceRecordSetA(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, 
                         void* pReserved);

///The <b>DnsReplaceRecordSet</b> function type replaces an existing resource record (RR) set. Like many DNS functions,
///the <b>DnsReplaceRecordSet</b> function type is implemented in multiple forms to facilitate different character
///encoding, which is indicated by a suffix. Based on the character encoding involved, use one of the following
///functions: <b>DnsReplaceRecordSetA</b> (_A for ANSI encoding) <b>DnsReplaceRecordSetW</b> (_W for Unicode encoding)
///<b>DnsReplaceRecordSetUTF8</b> (_UTF8 for UTF 8 encoding) Be aware of the lack of an underscore between the function
///type name and its suffix. If the <b>DnsReplaceRecordSet</b> function type is called without its suffix (A, W, or
///UTF8), a compiler error will occur.
///Params:
///    pReplaceSet = A pointer to a DNS_RECORD structure that contains the RR set that replaces the existing set. The specified RR set
///                  is replaced with the contents of <i>pNewSet</i>. To delete a RR set, specify the set in <i>pNewSet</i>, but set
///                  <i>RDATA</i> to <b>NULL</b>.
///    Options = A value that contains a bitmap of DNS Update Options. Options can be combined and all options override
///              <b>DNS_UPDATE_SECURITY_USE_DEFAULT</b>.
///    hContext = The handle to the credentials of a specific account. Used when secure dynamic update is required. This parameter
///               is optional.
///    pExtraInfo = This parameter is reserved for future use and must be set to <b>NULL</b>.
///    pReserved = This parameter is reserved for future use and must be set to <b>NULL</b>.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsReplaceRecordSetUTF8(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, 
                            void* pReserved);

///The <b>DnsValidateName</b> function validates the status of a specified DNS name. Like many DNS functions, the
///<b>DnsValidateName</b> function type is implemented in multiple forms to facilitate different character encoding.
///Based on the character encoding involved, use one of the following functions: <ul> <li> <b>DnsValidateName_A</b> (_A
///for ANSI encoding) </li> <li> <b>DnsValidateName_W</b> (_W for Unicode encoding) </li> <li>
///<b>DnsValidateName_UTF8</b> (_UTF8 for UTF-8 encoding) </li> </ul>
///Params:
///    pszName = A pointer to a string that represents the DNS name to be examined.
///    Format = A DNS_NAME_FORMAT value that specifies the format of the name to be examined.
///Returns:
///    The <b>DnsValidateName</b> function has the following possible return values:
///    
@DllImport("DNSAPI")
int DnsValidateName_W(const(wchar)* pszName, DNS_NAME_FORMAT Format);

///The <b>DnsValidateName</b> function validates the status of a specified DNS name. Like many DNS functions, the
///<b>DnsValidateName</b> function type is implemented in multiple forms to facilitate different character encoding.
///Based on the character encoding involved, use one of the following functions: <ul> <li> <b>DnsValidateName_A</b> (_A
///for ANSI encoding) </li> <li> <b>DnsValidateName_W</b> (_W for Unicode encoding) </li> <li>
///<b>DnsValidateName_UTF8</b> (_UTF8 for UTF-8 encoding) </li> </ul>
///Params:
///    pszName = A pointer to a string that represents the DNS name to be examined.
///    Format = A DNS_NAME_FORMAT value that specifies the format of the name to be examined.
///Returns:
///    The <b>DnsValidateName</b> function has the following possible return values:
///    
@DllImport("DNSAPI")
int DnsValidateName_A(const(char)* pszName, DNS_NAME_FORMAT Format);

///The <b>DnsValidateName</b> function validates the status of a specified DNS name. Like many DNS functions, the
///<b>DnsValidateName</b> function type is implemented in multiple forms to facilitate different character encoding.
///Based on the character encoding involved, use one of the following functions: <ul> <li> <b>DnsValidateName_A</b> (_A
///for ANSI encoding) </li> <li> <b>DnsValidateName_W</b> (_W for Unicode encoding) </li> <li>
///<b>DnsValidateName_UTF8</b> (_UTF8 for UTF-8 encoding) </li> </ul>
///Params:
///    pszName = A pointer to a string that represents the DNS name to be examined.
///    Format = A DNS_NAME_FORMAT value that specifies the format of the name to be examined.
///Returns:
///    The <b>DnsValidateName</b> function has the following possible return values:
///    
@DllImport("DNSAPI")
int DnsValidateName_UTF8(const(char)* pszName, DNS_NAME_FORMAT Format);

///The <b>DnsNameCompare</b> function compares two DNS names. Like many DNS functions, the <b>DnsNameCompare</b>
///function type is implemented in multiple forms to facilitate different character encoding. Based on the character
///encoding involved, use one of the following functions: <ul> <li> <b>DnsNameCompare_A</b> (_A for ANSI encoding) </li>
///<li> <b>DnsNameCompare_W</b> (_W for Unicode encoding) </li> <li> <b>DnsNameCompare_UTF8</b> (_UTF8 for Unicode
///encoding) </li> </ul>
///Params:
///    pName1 = A pointer to a string that represents the first DNS name of the comparison pair.
///    pName2 = A pointer to a string that represents the second DNS name of the comparison pair.
///Returns:
///    Returns <b>TRUE</b> if the compared names are equivalent, <b>FALSE</b> if they are not.
///    
@DllImport("DNSAPI")
BOOL DnsNameCompare_A(const(char)* pName1, const(char)* pName2);

///The <b>DnsNameCompare</b> function compares two DNS names. Like many DNS functions, the <b>DnsNameCompare</b>
///function type is implemented in multiple forms to facilitate different character encoding. Based on the character
///encoding involved, use one of the following functions: <ul> <li> <b>DnsNameCompare_A</b> (_A for ANSI encoding) </li>
///<li> <b>DnsNameCompare_W</b> (_W for Unicode encoding) </li> <li> <b>DnsNameCompare_UTF8</b> (_UTF8 for Unicode
///encoding) </li> </ul>
///Params:
///    pName1 = A pointer to a string that represents the first DNS name of the comparison pair.
///    pName2 = A pointer to a string that represents the second DNS name of the comparison pair.
///Returns:
///    Returns <b>TRUE</b> if the compared names are equivalent, <b>FALSE</b> if they are not.
///    
@DllImport("DNSAPI")
BOOL DnsNameCompare_W(const(wchar)* pName1, const(wchar)* pName2);

///The <b>DnsWriteQuestionToBuffer</b> function type creates a DNS query message and stores it in a DNS_MESSAGE_BUFFER
///structure. Like many DNS functions, the <b>DnsWriteQuestionToBuffer</b> function type is implemented in multiple
///forms to facilitate different character encoding. Based on the character encoding involved, use one of the following
///functions: <ul> <li> <b>DnsWriteQuestionToBuffer_W</b> (_W for Unicode encoding) </li> <li>
///<b>DnsWriteQuestionToBuffer_UTF8</b> (_UTF8 for UTF-8 encoding) </li> </ul>If the <b>DnsWriteQuestionToBuffer</b>
///function type is used without its suffix (either _W or _UTF8), a compiler error will occur.
///Params:
///    pDnsBuffer = A pointer to a DNS_MESSAGE_BUFFER structure that contains a DNS query message stored in a buffer.
///    pdwBufferSize = The size, in bytes, of the buffer allocated to store <i>pDnsBuffer</i>. If the buffer size is insufficient to
///                    contain the message, <b>FALSE</b> is returned and <i>pdwBufferSize</i> contains the minimum required buffer size.
///    pszName = A pointer to a string that represents the name of the owner of the record set being queried.
///    wType = A value that represents the RR DNS Record Type. <b>wType</b> determines the format of <b>Data</b>. For example,
///            if the value of <b>wType</b> is <b>DNS_TYPE_A</b>, the data type of <b>Data</b> is DNS_A_DATA.
///    Xid = A value that specifies the unique DNS query identifier.
///    fRecursionDesired = A BOOL that specifies whether recursive name query should be used by the DNS name server. Set to <b>TRUE</b> to
///                        request recursive name query, <b>FALSE</b> to request iterative name query.
///Returns:
///    Returns <b>TRUE</b> upon successful execution, otherwise <b>FALSE</b>.
///    
@DllImport("DNSAPI")
BOOL DnsWriteQuestionToBuffer_W(DNS_MESSAGE_BUFFER* pDnsBuffer, uint* pdwBufferSize, const(wchar)* pszName, 
                                ushort wType, ushort Xid, BOOL fRecursionDesired);

///The <b>DnsWriteQuestionToBuffer</b> function type creates a DNS query message and stores it in a DNS_MESSAGE_BUFFER
///structure. Like many DNS functions, the <b>DnsWriteQuestionToBuffer</b> function type is implemented in multiple
///forms to facilitate different character encoding. Based on the character encoding involved, use one of the following
///functions: <ul> <li> <b>DnsWriteQuestionToBuffer_W</b> (_W for Unicode encoding) </li> <li>
///<b>DnsWriteQuestionToBuffer_UTF8</b> (_UTF8 for UTF-8 encoding) </li> </ul>If the <b>DnsWriteQuestionToBuffer</b>
///function type is used without its suffix (either _W or _UTF8), a compiler error will occur.
///Params:
///    pDnsBuffer = A pointer to a DNS_MESSAGE_BUFFER structure that contains a DNS query message stored in a buffer.
///    pdwBufferSize = The size, in bytes, of the buffer allocated to store <i>pDnsBuffer</i>. If the buffer size is insufficient to
///                    contain the message, <b>FALSE</b> is returned and <i>pdwBufferSize</i> contains the minimum required buffer size.
///    pszName = A pointer to a string that represents the name of the owner of the record set being queried.
///    wType = A value that represents the RR DNS Record Type. <b>wType</b> determines the format of <b>Data</b>. For example,
///            if the value of <b>wType</b> is <b>DNS_TYPE_A</b>, the data type of <b>Data</b> is DNS_A_DATA.
///    Xid = A value that specifies the unique DNS query identifier.
///    fRecursionDesired = A BOOL that specifies whether recursive name query should be used by the DNS name server. Set to <b>TRUE</b> to
///                        request recursive name query, <b>FALSE</b> to request iterative name query.
///Returns:
///    Returns <b>TRUE</b> upon successful execution, otherwise <b>FALSE</b>.
///    
@DllImport("DNSAPI")
BOOL DnsWriteQuestionToBuffer_UTF8(DNS_MESSAGE_BUFFER* pDnsBuffer, uint* pdwBufferSize, const(char)* pszName, 
                                   ushort wType, ushort Xid, BOOL fRecursionDesired);

///The <b>DnsExtractRecordsFromMessage</b> function type extracts resource records (RR) from a DNS message, and stores
///those records in a DNS_RECORD structure. Like many DNS functions, the <b>DnsExtractRecordsFromMessage</b> function
///type is implemented in multiple forms to facilitate different character encoding. Based on the character encoding
///involved, use one of the following functions: <ul> <li> <b>DnsExtractRecordsFromMessage_W</b> (_W for Unicode
///encoding) </li> <li> <b>DnsExtractRecordsFromMessage_UTF8</b> (_UTF8 for UTF-8 encoding) </li> </ul>If the
///<b>DnsExtractRecordsFromMessage</b> function type is used without its suffix (either _W or _UTF8), a compiler error
///will occur.
///Params:
///    pDnsBuffer = A pointer to a DNS_MESSAGE_BUFFER structure that contains the DNS response message.
///    wMessageLength = The size, in bytes, of the message in <i>pDnsBuffer</i>.
///    ppRecord = A pointer to a DNS_RECORD structure that contains the list of extracted RRs. To free these records, use the
///               DnsRecordListFree function.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsExtractRecordsFromMessage_W(DNS_MESSAGE_BUFFER* pDnsBuffer, ushort wMessageLength, DNS_RECORDA** ppRecord);

///The <b>DnsExtractRecordsFromMessage</b> function type extracts resource records (RR) from a DNS message, and stores
///those records in a DNS_RECORD structure. Like many DNS functions, the <b>DnsExtractRecordsFromMessage</b> function
///type is implemented in multiple forms to facilitate different character encoding. Based on the character encoding
///involved, use one of the following functions: <ul> <li> <b>DnsExtractRecordsFromMessage_W</b> (_W for Unicode
///encoding) </li> <li> <b>DnsExtractRecordsFromMessage_UTF8</b> (_UTF8 for UTF-8 encoding) </li> </ul>If the
///<b>DnsExtractRecordsFromMessage</b> function type is used without its suffix (either _W or _UTF8), a compiler error
///will occur.
///Params:
///    pDnsBuffer = A pointer to a DNS_MESSAGE_BUFFER structure that contains the DNS response message.
///    wMessageLength = The size, in bytes, of the message in <i>pDnsBuffer</i>.
///    ppRecord = A pointer to a DNS_RECORD structure that contains the list of extracted RRs. To free these records, use the
///               DnsRecordListFree function.
///Returns:
///    Returns success confirmation upon successful completion. Otherwise, returns the appropriate DNS-specific error
///    code as defined in Winerror.h.
///    
@DllImport("DNSAPI")
int DnsExtractRecordsFromMessage_UTF8(DNS_MESSAGE_BUFFER* pDnsBuffer, ushort wMessageLength, 
                                      DNS_RECORDA** ppRecord);

///The <b>DnsGetProxyInformation</b> function returns the proxy information for a DNS server's name resolution policy
///table.
///Params:
///    hostName = A pointer to a string that represents the name of the DNS server whose proxy information is returned.
///    proxyInformation = A pointer to a DNS_PROXY_INFORMATION structure that contains the proxy information for <i>hostName</i>.
///    defaultProxyInformation = A pointer to a DNS_PROXY_INFORMATION structure that contains the default proxy information for <i>hostName</i>.
///                              This proxy information is for the wildcard DNS policy.
///    completionRoutine = Reserved. Do not use.
///    completionContext = Reserved. Do not use.
///Returns:
///    The <b>DnsGetProxyInformation</b> function returns the appropriate DNS-specific error code as defined in
///    Winerror.h. The following are possible return values:
///    
@DllImport("DNSAPI")
uint DnsGetProxyInformation(const(wchar)* hostName, DNS_PROXY_INFORMATION* proxyInformation, 
                            DNS_PROXY_INFORMATION* defaultProxyInformation, 
                            DNS_PROXY_COMPLETION_ROUTINE completionRoutine, void* completionContext);

///The <b>DnsFreeProxyName</b> function frees memory allocated for the <b>proxyName</b> member of a
///DNS_PROXY_INFORMATION structure obtained using the DnsGetProxyInformation function.
///Params:
///    proxyName = A pointer to the <b>proxyName</b> string to be freed.
@DllImport("DNSAPI")
void DnsFreeProxyName(const(wchar)* proxyName);

@DllImport("DNSAPI")
uint DnsConnectionGetProxyInfoForHostUrl(const(wchar)* pwszHostUrl, char* pSelectionContext, 
                                         uint dwSelectionContextLength, uint dwExplicitInterfaceIndex, 
                                         DNS_CONNECTION_PROXY_INFO_EX* pProxyInfoEx);

@DllImport("DNSAPI")
void DnsConnectionFreeProxyInfoEx(DNS_CONNECTION_PROXY_INFO_EX* pProxyInfoEx);

@DllImport("DNSAPI")
uint DnsConnectionGetProxyInfo(const(wchar)* pwszConnectionName, DNS_CONNECTION_PROXY_TYPE Type, 
                               DNS_CONNECTION_PROXY_INFO* pProxyInfo);

@DllImport("DNSAPI")
void DnsConnectionFreeProxyInfo(DNS_CONNECTION_PROXY_INFO* pProxyInfo);

@DllImport("DNSAPI")
uint DnsConnectionSetProxyInfo(const(wchar)* pwszConnectionName, DNS_CONNECTION_PROXY_TYPE Type, 
                               const(DNS_CONNECTION_PROXY_INFO)* pProxyInfo);

@DllImport("DNSAPI")
uint DnsConnectionDeleteProxyInfo(const(wchar)* pwszConnectionName, DNS_CONNECTION_PROXY_TYPE Type);

@DllImport("DNSAPI")
uint DnsConnectionGetProxyList(const(wchar)* pwszConnectionName, DNS_CONNECTION_PROXY_LIST* pProxyList);

@DllImport("DNSAPI")
void DnsConnectionFreeProxyList(DNS_CONNECTION_PROXY_LIST* pProxyList);

@DllImport("DNSAPI")
uint DnsConnectionGetNameList(DNS_CONNECTION_NAME_LIST* pNameList);

@DllImport("DNSAPI")
void DnsConnectionFreeNameList(DNS_CONNECTION_NAME_LIST* pNameList);

@DllImport("DNSAPI")
uint DnsConnectionUpdateIfIndexTable(DNS_CONNECTION_IFINDEX_LIST* pConnectionIfIndexEntries);

@DllImport("DNSAPI")
uint DnsConnectionSetPolicyEntries(DNS_CONNECTION_POLICY_TAG PolicyEntryTag, 
                                   DNS_CONNECTION_POLICY_ENTRY_LIST* pPolicyEntryList);

@DllImport("DNSAPI")
uint DnsConnectionDeletePolicyEntries(DNS_CONNECTION_POLICY_TAG PolicyEntryTag);

///Used to build a [DNS_SERVICE_INSTANCE](ns-windns-dns_service_instance.md) structure from data that describes it.
///Params:
///    pServiceName = A string that represents the name of the service.
///    pHostName = A string that represents the name of the host of the service.
///    pIp4 = A pointer to an **IP4_ADDRESS** structure that represents the service-associated IPv4 address.
///    pIp6 = A pointer to an [IP6_ADDRESS](/windows/desktop/api/windns/ns-windns-ip6_address_1) structure that represents the
///           service-associated IPv6 address.
///    wPort = A value that represents the port on which the service is running.
///    wPriority = A value that represents the service priority.
///    wWeight = A value that represents the service weight.
///    dwPropertiesCount = The number of properties&mdash;defines the number of elements in the arrays of the `keys` and `values`
///                        parameters.
///    keys = A pointer to an array of string values that represent the property keys.
///    values = A pointer to an array of string values that represent the corresponding property values.
///Returns:
///    A pointer to a newly allocated [DNS_SERVICE_INSTANCE](ns-windns-dns_service_instance.md) structure, built from
///    the passed-in parameters. Your application is responsible for freeing the associated memory by calling
///    [DnsServiceFreeInstance](nf-windns-dnsservicefreeinstance.md).
///    
@DllImport("DNSAPI")
DNS_SERVICE_INSTANCE* DnsServiceConstructInstance(const(wchar)* pServiceName, const(wchar)* pHostName, uint* pIp4, 
                                                  IP6_ADDRESS* pIp6, ushort wPort, ushort wPriority, ushort wWeight, 
                                                  uint dwPropertiesCount, char* keys, char* values);

///Used to copy a [DNS_SERVICE_INSTANCE](ns-windns-dns_service_instance.md) structure.
///Params:
///    pOrig = A pointer to the [DNS_SERVICE_INSTANCE](ns-windns-dns_service_instance.md) structure that is to be copied.
///Returns:
///    A pointer to a newly allocated [DNS_SERVICE_INSTANCE](ns-windns-dns_service_instance.md) structure that's a copy
///    of `pOrig`. Your application is responsible for freeing the associated memory by calling
///    [DnsServiceFreeInstance](nf-windns-dnsservicefreeinstance.md).
///    
@DllImport("DNSAPI")
DNS_SERVICE_INSTANCE* DnsServiceCopyInstance(DNS_SERVICE_INSTANCE* pOrig);

///Used to free the resources associated with a [DNS_SERVICE_INSTANCE](ns-windns-dns_service_instance.md) structure.
///Params:
///    pInstance = A pointer to the [DNS_SERVICE_INSTANCE](ns-windns-dns_service_instance.md) structure that is to be freed.
@DllImport("DNSAPI")
void DnsServiceFreeInstance(DNS_SERVICE_INSTANCE* pInstance);

///Used to initiate a DNS-SD discovery for services running on the local network.
///Params:
///    pRequest = A pointer to a [DNS_SERVICE_BROWSE_REQUEST](ns-windns-dns_service_browse_request.md) structure that contains the
///               browse request information.
///    pCancel = A pointer to a [DNS_SERVICE_CANCEL](ns-windns-dns_service_cancel.md) structure that can be used to cancel a
///              pending asynchronous browsing operation. This handle must remain valid until the query is canceled.
///Returns:
///    If successful, returns **DNS_REQUEST_PENDING**; otherwise, returns the appropriate DNS-specific error code as
///    defined in `Winerror.h`. For extended error information, call
///    [GetLastError](/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("DNSAPI")
int DnsServiceBrowse(DNS_SERVICE_BROWSE_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

///Used to cancel a running DNS-SD discovery query.
///Params:
///    pCancelHandle = A pointer to the [DNS_SERVICE_CANCEL](ns-windns-dns_service_cancel.md) structure that was passed to the
///                    [DnsServiceBrowse](nf-windns-dnsservicebrowse.md) call that is to be cancelled.
///Returns:
///    If successful, returns **ERROR_SUCCESS**; otherwise, returns the appropriate DNS-specific error code as defined
///    in `Winerror.h`. For extended error information, call
///    [GetLastError](/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("DNSAPI")
int DnsServiceBrowseCancel(DNS_SERVICE_CANCEL* pCancelHandle);

///Used to obtain more information about a service advertised on the local network.
///Params:
///    pRequest = A pointer to a [DNS_SERVICE_RESOLVE_REQUEST](ns-windns-dns_service_resolve_request.md) structure that contains
///               the resolve request information.
///    pCancel = A pointer to a [DNS_SERVICE_CANCEL](ns-windns-dns_service_cancel.md) structure that can be used to cancel a
///              pending asynchronous resolve operation. This handle must remain valid until the query is canceled.
///Returns:
///    If successful, returns **DNS_REQUEST_PENDING**; otherwise, returns the appropriate DNS-specific error code as
///    defined in `Winerror.h`. For extended error information, call
///    [GetLastError](/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("DNSAPI")
int DnsServiceResolve(DNS_SERVICE_RESOLVE_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

///Used to cancel a running DNS-SD resolve query.
///Params:
///    pCancelHandle = A pointer to the [DNS_SERVICE_CANCEL](ns-windns-dns_service_cancel.md) structure that was passed to the
///                    [DnsServiceResolve](nf-windns-dnsserviceresolve.md) call that is to be cancelled.
///Returns:
///    If successful, returns **ERROR_SUCCESS**; otherwise, returns the appropriate DNS-specific error code as defined
///    in `Winerror.h`. For extended error information, call
///    [GetLastError](/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("DNSAPI")
int DnsServiceResolveCancel(DNS_SERVICE_CANCEL* pCancelHandle);

///Used to register a discoverable service on this device.
///Params:
///    pRequest = A pointer to a [DNS_SERVICE_REGISTER_REQUEST](ns-windns-dns_service_register_request.md) structure that contains
///               information about the service to be registered.
///    pCancel = An optional (it can be `nullptr`) pointer to a [DNS_SERVICE_CANCEL](ns-windns-dns_service_cancel.md) structure
///              that can be used to cancel a pending asynchronous registration operation. If not `nullptr`, then this handle must
///              remain valid until the registration is canceled.
///Returns:
///    If successful, returns **DNS_REQUEST_PENDING**; otherwise, returns the appropriate DNS-specific error code as
///    defined in `Winerror.h`. For extended error information, call
///    [GetLastError](/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("DNSAPI")
uint DnsServiceRegister(DNS_SERVICE_REGISTER_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

///Used to remove a registered service.
///Params:
///    pRequest = A pointer to the [DNS_SERVICE_REGISTER_REQUEST](ns-windns-dns_service_register_request.md) structure that was
///               used to register the service.
///    pCancel = Must be `nullptr`.
///Returns:
///    If successful, returns **DNS_REQUEST_PENDING**; otherwise, returns the appropriate DNS-specific error code as
///    defined in `Winerror.h`. For extended error information, call
///    [GetLastError](/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("DNSAPI")
uint DnsServiceDeRegister(DNS_SERVICE_REGISTER_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

///Used to cancel a pending registration operation.
///Params:
///    pCancelHandle = A pointer to the [DNS_SERVICE_CANCEL](ns-windns-dns_service_cancel.md) structure that was passed to the
///                    [DnsServiceRegister](nf-windns-dnsserviceregister.md) call that is to be cancelled.
///Returns:
///    If successful, returns **ERROR_SUCCESS**. Returns **ERROR_CANCELLED** if the operation was already cancelled, or
///    **ERROR_INVALID_PARAMETER** if the handle is invalid.
///    
@DllImport("DNSAPI")
uint DnsServiceRegisterCancel(DNS_SERVICE_CANCEL* pCancelHandle);

///Used to register a discoverable service on this device.
///Params:
///    pQueryRequest = A pointer to an [MDNS_QUERY_REQUEST](ns-windns-mdns_query_request.md) structure that contains information about
///                    the query to be performed.
///    pHandle = A pointer to an [MDNS_QUERY_HANDLE](ns-windns-mdns_query_handle.md) structure that will be populated with the
///              necessary data. This structure is to be passed later to
///              [DnsStopMulticastQuery](nf-windns-dnsstopmulticastquery.md) to stop the query.
///Returns:
///    If successful, returns **ERROR_SUCCESS**; otherwise, returns the appropriate DNS-specific error code as defined
///    in `Winerror.h`. For extended error information, call
///    [GetLastError](/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("DNSAPI")
int DnsStartMulticastQuery(MDNS_QUERY_REQUEST* pQueryRequest, MDNS_QUERY_HANDLE* pHandle);

///Used to stop a running [DnsStartMulticastQuery](nf-windns-dnsstartmulticastquery.md) operation.
///Params:
///    pHandle = A pointer to the [MDNS_QUERY_HANDLE](ns-windns-mdns_query_handle.md) structure that was passed to the
///              [DnsStartMulticastQuery](nf-windns-dnsstartmulticastquery.md) call that is to be stopped.
///Returns:
///    If successful, returns **ERROR_SUCCESS**; otherwise, returns the appropriate DNS-specific error code as defined
///    in `Winerror.h`. For extended error information, call
///    [GetLastError](/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("DNSAPI")
int DnsStopMulticastQuery(MDNS_QUERY_HANDLE* pHandle);


