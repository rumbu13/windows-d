module windows.dns;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


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
alias DNS_CONFIG_TYPE = int;

enum : int
{
    DnsSectionQuestion  = 0x00000000,
    DnsSectionAnswer    = 0x00000001,
    DnsSectionAuthority = 0x00000002,
    DnsSectionAddtional = 0x00000003,
}
alias DNS_SECTION = int;

enum : int
{
    DNS_PROXY_INFORMATION_DIRECT           = 0x00000000,
    DNS_PROXY_INFORMATION_DEFAULT_SETTINGS = 0x00000001,
    DNS_PROXY_INFORMATION_PROXY_NAME       = 0x00000002,
    DNS_PROXY_INFORMATION_DOES_NOT_EXIST   = 0x00000003,
}
alias DNS_PROXY_INFORMATION_TYPE = int;

enum : int
{
    DnsCharSetUnknown = 0x00000000,
    DnsCharSetUnicode = 0x00000001,
    DnsCharSetUtf8    = 0x00000002,
    DnsCharSetAnsi    = 0x00000003,
}
alias DNS_CHARSET = int;

enum : int
{
    DnsFreeFlat                = 0x00000000,
    DnsFreeRecordList          = 0x00000001,
    DnsFreeParsedMessageFields = 0x00000002,
}
alias DNS_FREE_TYPE = int;

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
alias DNS_NAME_FORMAT = int;

enum : int
{
    DNS_CONNECTION_PROXY_TYPE_NULL   = 0x00000000,
    DNS_CONNECTION_PROXY_TYPE_HTTP   = 0x00000001,
    DNS_CONNECTION_PROXY_TYPE_WAP    = 0x00000002,
    DNS_CONNECTION_PROXY_TYPE_SOCKS4 = 0x00000004,
    DNS_CONNECTION_PROXY_TYPE_SOCKS5 = 0x00000005,
}
alias DNS_CONNECTION_PROXY_TYPE = int;

enum : int
{
    DNS_CONNECTION_PROXY_INFO_SWITCH_CONFIG = 0x00000000,
    DNS_CONNECTION_PROXY_INFO_SWITCH_SCRIPT = 0x00000001,
    DNS_CONNECTION_PROXY_INFO_SWITCH_WPAD   = 0x00000002,
}
alias DNS_CONNECTION_PROXY_INFO_SWITCH = int;

enum : int
{
    TAG_DNS_CONNECTION_POLICY_TAG_DEFAULT            = 0x00000000,
    TAG_DNS_CONNECTION_POLICY_TAG_CONNECTION_MANAGER = 0x00000001,
    TAG_DNS_CONNECTION_POLICY_TAG_WWWPT              = 0x00000002,
}
alias DNS_CONNECTION_POLICY_TAG = int;

// Callbacks

alias DNS_PROXY_COMPLETION_ROUTINE = void function(void* completionContext, int status);
alias DNS_QUERY_COMPLETION_ROUTINE = void function(void* pQueryContext, DNS_QUERY_RESULT* pQueryResults);
alias PDNS_QUERY_COMPLETION_ROUTINE = void function();
alias DNS_SERVICE_BROWSE_CALLBACK = void function(uint Status, void* pQueryContext, DNS_RECORDA* pDnsRecord);
alias PDNS_SERVICE_BROWSE_CALLBACK = void function();
alias DNS_SERVICE_RESOLVE_COMPLETE = void function(uint Status, void* pQueryContext, 
                                                   DNS_SERVICE_INSTANCE* pInstance);
alias PDNS_SERVICE_RESOLVE_COMPLETE = void function();
alias DNS_SERVICE_REGISTER_COMPLETE = void function(uint Status, void* pQueryContext, 
                                                    DNS_SERVICE_INSTANCE* pInstance);
alias PDNS_SERVICE_REGISTER_COMPLETE = void function();
alias MDNS_QUERY_CALLBACK = void function(void* pQueryContext, MDNS_QUERY_HANDLE* pQueryHandle, 
                                          DNS_QUERY_RESULT* pQueryResults);
alias PMDNS_QUERY_CALLBACK = void function();

// Structs


struct IP4_ARRAY
{
    uint    AddrCount;
    uint[1] AddrArray;
}

union IP6_ADDRESS
{
    uint[4]   IP6Dword;
    ushort[8] IP6Word;
    ubyte[16] IP6Byte;
}

struct DNS_ADDR
{
    byte[32] MaxSa;
    union Data
    {
    align (1):
        uint[8] DnsAddrUserDword;
    }
}

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
    DNS_ADDR[1] AddrArray;
}

struct DNS_HEADER
{
align (1):
    ushort Xid;
    ubyte  _bitfield1;
    ubyte  _bitfield2;
    ushort QuestionCount;
    ushort AnswerCount;
    ushort NameServerCount;
    ushort AdditionalCount;
}

struct DNS_HEADER_EXT
{
align (1):
    ushort _bitfield34;
    ubyte  chRcode;
    ubyte  chVersion;
}

struct DNS_WIRE_QUESTION
{
align (1):
    ushort QuestionType;
    ushort QuestionClass;
}

struct DNS_WIRE_RECORD
{
align (1):
    ushort RecordType;
    ushort RecordClass;
    uint   TimeToLive;
    ushort DataLength;
}

struct DNS_A_DATA
{
    uint IpAddress;
}

struct DNS_PTR_DATAW
{
    const(wchar)* pNameHost;
}

struct DNS_PTR_DATAA
{
    const(char)* pNameHost;
}

struct DNS_SOA_DATAW
{
    const(wchar)* pNamePrimaryServer;
    const(wchar)* pNameAdministrator;
    uint          dwSerialNo;
    uint          dwRefresh;
    uint          dwRetry;
    uint          dwExpire;
    uint          dwDefaultTtl;
}

struct DNS_SOA_DATAA
{
    const(char)* pNamePrimaryServer;
    const(char)* pNameAdministrator;
    uint         dwSerialNo;
    uint         dwRefresh;
    uint         dwRetry;
    uint         dwExpire;
    uint         dwDefaultTtl;
}

struct DNS_MINFO_DATAW
{
    const(wchar)* pNameMailbox;
    const(wchar)* pNameErrorsMailbox;
}

struct DNS_MINFO_DATAA
{
    const(char)* pNameMailbox;
    const(char)* pNameErrorsMailbox;
}

struct DNS_MX_DATAW
{
    const(wchar)* pNameExchange;
    ushort        wPreference;
    ushort        Pad;
}

struct DNS_MX_DATAA
{
    const(char)* pNameExchange;
    ushort       wPreference;
    ushort       Pad;
}

struct DNS_TXT_DATAW
{
    uint       dwStringCount;
    ushort[1]* pStringArray;
}

struct DNS_TXT_DATAA
{
    uint     dwStringCount;
    byte[1]* pStringArray;
}

struct DNS_NULL_DATA
{
    uint     dwByteCount;
    ubyte[1] Data;
}

struct DNS_WKS_DATA
{
    uint     IpAddress;
    ubyte    chProtocol;
    ubyte[1] BitMask;
}

struct DNS_AAAA_DATA
{
    IP6_ADDRESS Ip6Address;
}

struct DNS_SIG_DATAW
{
    ushort        wTypeCovered;
    ubyte         chAlgorithm;
    ubyte         chLabelCount;
    uint          dwOriginalTtl;
    uint          dwExpiration;
    uint          dwTimeSigned;
    ushort        wKeyTag;
    ushort        wSignatureLength;
    const(wchar)* pNameSigner;
    ubyte[1]      Signature;
}

struct DNS_SIG_DATAA
{
    ushort       wTypeCovered;
    ubyte        chAlgorithm;
    ubyte        chLabelCount;
    uint         dwOriginalTtl;
    uint         dwExpiration;
    uint         dwTimeSigned;
    ushort       wKeyTag;
    ushort       wSignatureLength;
    const(char)* pNameSigner;
    ubyte[1]     Signature;
}

struct DNS_KEY_DATA
{
    ushort   wFlags;
    ubyte    chProtocol;
    ubyte    chAlgorithm;
    ushort   wKeyLength;
    ushort   wPad;
    ubyte[1] Key;
}

struct DNS_DHCID_DATA
{
    uint     dwByteCount;
    ubyte[1] DHCID;
}

struct DNS_NSEC_DATAW
{
    const(wchar)* pNextDomainName;
    ushort        wTypeBitMapsLength;
    ushort        wPad;
    ubyte[1]      TypeBitMaps;
}

struct DNS_NSEC_DATAA
{
    const(char)* pNextDomainName;
    ushort       wTypeBitMapsLength;
    ushort       wPad;
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

struct DNS_DS_DATA
{
    ushort   wKeyTag;
    ubyte    chAlgorithm;
    ubyte    chDigestType;
    ushort   wDigestLength;
    ushort   wPad;
    ubyte[1] Digest;
}

struct DNS_OPT_DATA
{
    ushort   wDataLength;
    ushort   wPad;
    ubyte[1] Data;
}

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

struct DNS_NXT_DATAW
{
    const(wchar)* pNameNext;
    ushort        wNumTypes;
    ushort[1]     wTypes;
}

struct DNS_NXT_DATAA
{
    const(char)* pNameNext;
    ushort       wNumTypes;
    ushort[1]    wTypes;
}

struct DNS_SRV_DATAW
{
    const(wchar)* pNameTarget;
    ushort        wPriority;
    ushort        wWeight;
    ushort        wPort;
    ushort        Pad;
}

struct DNS_SRV_DATAA
{
    const(char)* pNameTarget;
    ushort       wPriority;
    ushort       wWeight;
    ushort       wPort;
    ushort       Pad;
}

struct DNS_NAPTR_DATAW
{
    ushort        wOrder;
    ushort        wPreference;
    const(wchar)* pFlags;
    const(wchar)* pService;
    const(wchar)* pRegularExpression;
    const(wchar)* pReplacement;
}

struct DNS_NAPTR_DATAA
{
    ushort       wOrder;
    ushort       wPreference;
    const(char)* pFlags;
    const(char)* pService;
    const(char)* pRegularExpression;
    const(char)* pReplacement;
}

struct DNS_ATMA_DATA
{
    ubyte     AddressType;
    ubyte[20] Address;
}

struct DNS_TKEY_DATAW
{
    const(wchar)* pNameAlgorithm;
    ubyte*        pAlgorithmPacket;
    ubyte*        pKey;
    ubyte*        pOtherData;
    uint          dwCreateTime;
    uint          dwExpireTime;
    ushort        wMode;
    ushort        wError;
    ushort        wKeyLength;
    ushort        wOtherLength;
    ubyte         cAlgNameLength;
    BOOL          bPacketPointers;
}

struct DNS_TKEY_DATAA
{
    const(char)* pNameAlgorithm;
    ubyte*       pAlgorithmPacket;
    ubyte*       pKey;
    ubyte*       pOtherData;
    uint         dwCreateTime;
    uint         dwExpireTime;
    ushort       wMode;
    ushort       wError;
    ushort       wKeyLength;
    ushort       wOtherLength;
    ubyte        cAlgNameLength;
    BOOL         bPacketPointers;
}

struct DNS_TSIG_DATAW
{
    const(wchar)* pNameAlgorithm;
    ubyte*        pAlgorithmPacket;
    ubyte*        pSignature;
    ubyte*        pOtherData;
    long          i64CreateTime;
    ushort        wFudgeTime;
    ushort        wOriginalXid;
    ushort        wError;
    ushort        wSigLength;
    ushort        wOtherLength;
    ubyte         cAlgNameLength;
    BOOL          bPacketPointers;
}

struct DNS_TSIG_DATAA
{
    const(char)* pNameAlgorithm;
    ubyte*       pAlgorithmPacket;
    ubyte*       pSignature;
    ubyte*       pOtherData;
    long         i64CreateTime;
    ushort       wFudgeTime;
    ushort       wOriginalXid;
    ushort       wError;
    ushort       wSigLength;
    ushort       wOtherLength;
    ubyte        cAlgNameLength;
    BOOL         bPacketPointers;
}

struct DNS_UNKNOWN_DATA
{
    uint     dwByteCount;
    ubyte[1] bData;
}

struct DNS_WINS_DATA
{
    uint    dwMappingFlag;
    uint    dwLookupTimeout;
    uint    dwCacheTimeout;
    uint    cWinsServerCount;
    uint[1] WinsServers;
}

struct DNS_WINSR_DATAW
{
    uint          dwMappingFlag;
    uint          dwLookupTimeout;
    uint          dwCacheTimeout;
    const(wchar)* pNameResultDomain;
}

struct DNS_WINSR_DATAA
{
    uint         dwMappingFlag;
    uint         dwLookupTimeout;
    uint         dwCacheTimeout;
    const(char)* pNameResultDomain;
}

struct DNS_RECORD_FLAGS
{
    uint _bitfield35;
}

struct DNS_RECORDW
{
    DNS_RECORDW*  pNext;
    const(wchar)* pName;
    ushort        wType;
    ushort        wDataLength;
    union Flags
    {
        uint             DW;
        DNS_RECORD_FLAGS S;
    }
    uint          dwTtl;
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

struct DNS_RECORDA
{
    DNS_RECORDA* pNext;
    const(char)* pName;
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

struct DNS_RRSET
{
    DNS_RECORDA* pFirstRR;
    DNS_RECORDA* pLastRR;
}

struct DNS_PROXY_INFORMATION
{
    uint          version_;
    DNS_PROXY_INFORMATION_TYPE proxyInformationType;
    const(wchar)* proxyName;
}

struct DNS_QUERY_RESULT
{
    uint         Version;
    int          QueryStatus;
    ulong        QueryOptions;
    DNS_RECORDA* pQueryRecords;
    void*        Reserved;
}

struct DNS_QUERY_REQUEST
{
    uint            Version;
    const(wchar)*   QueryName;
    ushort          QueryType;
    ulong           QueryOptions;
    DNS_ADDR_ARRAY* pDnsServerList;
    uint            InterfaceIndex;
    PDNS_QUERY_COMPLETION_ROUTINE pQueryCompletionCallback;
    void*           pQueryContext;
}

struct DNS_QUERY_CANCEL
{
    byte[32] Reserved;
}

struct DNS_MESSAGE_BUFFER
{
    DNS_HEADER MessageHead;
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

struct DNS_SERVICE_INSTANCE
{
    const(wchar)* pszInstanceName;
    const(wchar)* pszHostName;
    uint*         ip4Address;
    IP6_ADDRESS*  ip6Address;
    ushort        wPort;
    ushort        wPriority;
    ushort        wWeight;
    uint          dwPropertyCount;
    ushort**      keys;
    ushort**      values;
    uint          dwInterfaceIndex;
}

struct DNS_SERVICE_CANCEL
{
    void* reserved;
}

struct DNS_SERVICE_BROWSE_REQUEST
{
    uint          Version;
    uint          InterfaceIndex;
    const(wchar)* QueryName;
    union
    {
        PDNS_SERVICE_BROWSE_CALLBACK pBrowseCallback;
        DNS_QUERY_COMPLETION_ROUTINE* pBrowseCallbackV2;
    }
    void*         pQueryContext;
}

struct DNS_SERVICE_RESOLVE_REQUEST
{
    uint          Version;
    uint          InterfaceIndex;
    const(wchar)* QueryName;
    PDNS_SERVICE_RESOLVE_COMPLETE pResolveCompletionCallback;
    void*         pQueryContext;
}

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

struct MDNS_QUERY_HANDLE
{
    ushort[256] nameBuf;
    ushort      wType;
    void*       pSubscription;
    void*       pWnfCallbackParams;
    uint[2]     stateNameData;
}

struct MDNS_QUERY_REQUEST
{
    uint                 Version;
    uint                 ulRefCount;
    const(wchar)*        Query;
    ushort               QueryType;
    ulong                QueryOptions;
    uint                 InterfaceIndex;
    PMDNS_QUERY_CALLBACK pQueryCallback;
    void*                pQueryContext;
    BOOL                 fAnswerReceived;
    uint                 ulResendCount;
}

alias DnsContextHandle = ptrdiff_t;

// Functions

@DllImport("DNSAPI")
int DnsQueryConfig(DNS_CONFIG_TYPE Config, uint Flag, const(wchar)* pwsAdapterName, void* pReserved, char* pBuffer, 
                   uint* pBufLen);

@DllImport("DNSAPI")
DNS_RECORDA* DnsRecordCopyEx(DNS_RECORDA* pRecord, DNS_CHARSET CharSetIn, DNS_CHARSET CharSetOut);

@DllImport("DNSAPI")
DNS_RECORDA* DnsRecordSetCopyEx(DNS_RECORDA* pRecordSet, DNS_CHARSET CharSetIn, DNS_CHARSET CharSetOut);

@DllImport("DNSAPI")
BOOL DnsRecordCompare(DNS_RECORDA* pRecord1, DNS_RECORDA* pRecord2);

@DllImport("DNSAPI")
BOOL DnsRecordSetCompare(DNS_RECORDA* pRR1, DNS_RECORDA* pRR2, DNS_RECORDA** ppDiff1, DNS_RECORDA** ppDiff2);

@DllImport("DNSAPI")
DNS_RECORDA* DnsRecordSetDetach(DNS_RECORDA* pRecordList);

@DllImport("DNSAPI")
void DnsFree(void* pData, DNS_FREE_TYPE FreeType);

@DllImport("DNSAPI")
int DnsQuery_A(const(char)* pszName, ushort wType, uint Options, void* pExtra, DNS_RECORDA** ppQueryResults, 
               void** pReserved);

@DllImport("DNSAPI")
int DnsQuery_UTF8(const(char)* pszName, ushort wType, uint Options, void* pExtra, DNS_RECORDA** ppQueryResults, 
                  void** pReserved);

@DllImport("DNSAPI")
int DnsQuery_W(const(wchar)* pszName, ushort wType, uint Options, void* pExtra, DNS_RECORDA** ppQueryResults, 
               void** pReserved);

@DllImport("DNSAPI")
int DnsQueryEx(DNS_QUERY_REQUEST* pQueryRequest, DNS_QUERY_RESULT* pQueryResults, DNS_QUERY_CANCEL* pCancelHandle);

@DllImport("DNSAPI")
int DnsCancelQuery(DNS_QUERY_CANCEL* pCancelHandle);

@DllImport("DNSAPI")
int DnsAcquireContextHandle_W(uint CredentialFlags, void* Credentials, DnsContextHandle* pContext);

@DllImport("DNSAPI")
int DnsAcquireContextHandle_A(uint CredentialFlags, void* Credentials, DnsContextHandle* pContext);

@DllImport("DNSAPI")
void DnsReleaseContextHandle(HANDLE hContext);

@DllImport("DNSAPI")
int DnsModifyRecordsInSet_W(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, 
                            HANDLE hCredentials, void* pExtraList, void* pReserved);

@DllImport("DNSAPI")
int DnsModifyRecordsInSet_A(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, 
                            HANDLE hCredentials, void* pExtraList, void* pReserved);

@DllImport("DNSAPI")
int DnsModifyRecordsInSet_UTF8(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, 
                               HANDLE hCredentials, void* pExtraList, void* pReserved);

@DllImport("DNSAPI")
int DnsReplaceRecordSetW(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, 
                         void* pReserved);

@DllImport("DNSAPI")
int DnsReplaceRecordSetA(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, 
                         void* pReserved);

@DllImport("DNSAPI")
int DnsReplaceRecordSetUTF8(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, 
                            void* pReserved);

@DllImport("DNSAPI")
int DnsValidateName_W(const(wchar)* pszName, DNS_NAME_FORMAT Format);

@DllImport("DNSAPI")
int DnsValidateName_A(const(char)* pszName, DNS_NAME_FORMAT Format);

@DllImport("DNSAPI")
int DnsValidateName_UTF8(const(char)* pszName, DNS_NAME_FORMAT Format);

@DllImport("DNSAPI")
BOOL DnsNameCompare_A(const(char)* pName1, const(char)* pName2);

@DllImport("DNSAPI")
BOOL DnsNameCompare_W(const(wchar)* pName1, const(wchar)* pName2);

@DllImport("DNSAPI")
BOOL DnsWriteQuestionToBuffer_W(DNS_MESSAGE_BUFFER* pDnsBuffer, uint* pdwBufferSize, const(wchar)* pszName, 
                                ushort wType, ushort Xid, BOOL fRecursionDesired);

@DllImport("DNSAPI")
BOOL DnsWriteQuestionToBuffer_UTF8(DNS_MESSAGE_BUFFER* pDnsBuffer, uint* pdwBufferSize, const(char)* pszName, 
                                   ushort wType, ushort Xid, BOOL fRecursionDesired);

@DllImport("DNSAPI")
int DnsExtractRecordsFromMessage_W(DNS_MESSAGE_BUFFER* pDnsBuffer, ushort wMessageLength, DNS_RECORDA** ppRecord);

@DllImport("DNSAPI")
int DnsExtractRecordsFromMessage_UTF8(DNS_MESSAGE_BUFFER* pDnsBuffer, ushort wMessageLength, 
                                      DNS_RECORDA** ppRecord);

@DllImport("DNSAPI")
uint DnsGetProxyInformation(const(wchar)* hostName, DNS_PROXY_INFORMATION* proxyInformation, 
                            DNS_PROXY_INFORMATION* defaultProxyInformation, 
                            DNS_PROXY_COMPLETION_ROUTINE completionRoutine, void* completionContext);

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

@DllImport("DNSAPI")
DNS_SERVICE_INSTANCE* DnsServiceConstructInstance(const(wchar)* pServiceName, const(wchar)* pHostName, uint* pIp4, 
                                                  IP6_ADDRESS* pIp6, ushort wPort, ushort wPriority, ushort wWeight, 
                                                  uint dwPropertiesCount, char* keys, char* values);

@DllImport("DNSAPI")
DNS_SERVICE_INSTANCE* DnsServiceCopyInstance(DNS_SERVICE_INSTANCE* pOrig);

@DllImport("DNSAPI")
void DnsServiceFreeInstance(DNS_SERVICE_INSTANCE* pInstance);

@DllImport("DNSAPI")
int DnsServiceBrowse(DNS_SERVICE_BROWSE_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

@DllImport("DNSAPI")
int DnsServiceBrowseCancel(DNS_SERVICE_CANCEL* pCancelHandle);

@DllImport("DNSAPI")
int DnsServiceResolve(DNS_SERVICE_RESOLVE_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

@DllImport("DNSAPI")
int DnsServiceResolveCancel(DNS_SERVICE_CANCEL* pCancelHandle);

@DllImport("DNSAPI")
uint DnsServiceRegister(DNS_SERVICE_REGISTER_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

@DllImport("DNSAPI")
uint DnsServiceDeRegister(DNS_SERVICE_REGISTER_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

@DllImport("DNSAPI")
uint DnsServiceRegisterCancel(DNS_SERVICE_CANCEL* pCancelHandle);

@DllImport("DNSAPI")
int DnsStartMulticastQuery(MDNS_QUERY_REQUEST* pQueryRequest, MDNS_QUERY_HANDLE* pHandle);

@DllImport("DNSAPI")
int DnsStopMulticastQuery(MDNS_QUERY_HANDLE* pHandle);


