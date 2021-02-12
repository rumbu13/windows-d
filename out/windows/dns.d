module windows.dns;

public import windows.systemservices;

extern(Windows):

struct IP4_ARRAY
{
    uint AddrCount;
    uint AddrArray;
}

struct IP6_ADDRESS
{
    uint IP6Dword;
    ushort IP6Word;
    ubyte IP6Byte;
}

struct DNS_ADDR
{
    byte MaxSa;
    _Data_e__Union Data;
}

struct DNS_ADDR_ARRAY
{
    uint MaxCount;
    uint AddrCount;
    uint Tag;
    ushort Family;
    ushort WordReserved;
    uint Flags;
    uint MatchFlag;
    uint Reserved1;
    uint Reserved2;
    DNS_ADDR AddrArray;
}

struct DNS_HEADER
{
    ushort Xid;
    ubyte _bitfield1;
    ubyte _bitfield2;
    ushort QuestionCount;
    ushort AnswerCount;
    ushort NameServerCount;
    ushort AdditionalCount;
}

struct DNS_HEADER_EXT
{
    ushort _bitfield;
    ubyte chRcode;
    ubyte chVersion;
}

struct DNS_WIRE_QUESTION
{
    ushort QuestionType;
    ushort QuestionClass;
}

struct DNS_WIRE_RECORD
{
    ushort RecordType;
    ushort RecordClass;
    uint TimeToLive;
    ushort DataLength;
}

enum DNS_CONFIG_TYPE
{
    DnsConfigPrimaryDomainName_W = 0,
    DnsConfigPrimaryDomainName_A = 1,
    DnsConfigPrimaryDomainName_UTF8 = 2,
    DnsConfigAdapterDomainName_W = 3,
    DnsConfigAdapterDomainName_A = 4,
    DnsConfigAdapterDomainName_UTF8 = 5,
    DnsConfigDnsServerList = 6,
    DnsConfigSearchList = 7,
    DnsConfigAdapterInfo = 8,
    DnsConfigPrimaryHostNameRegistrationEnabled = 9,
    DnsConfigAdapterHostNameRegistrationEnabled = 10,
    DnsConfigAddressRegistrationMaxCount = 11,
    DnsConfigHostName_W = 12,
    DnsConfigHostName_A = 13,
    DnsConfigHostName_UTF8 = 14,
    DnsConfigFullHostName_W = 15,
    DnsConfigFullHostName_A = 16,
    DnsConfigFullHostName_UTF8 = 17,
    DnsConfigNameServer = 18,
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
    uint dwSerialNo;
    uint dwRefresh;
    uint dwRetry;
    uint dwExpire;
    uint dwDefaultTtl;
}

struct DNS_SOA_DATAA
{
    const(char)* pNamePrimaryServer;
    const(char)* pNameAdministrator;
    uint dwSerialNo;
    uint dwRefresh;
    uint dwRetry;
    uint dwExpire;
    uint dwDefaultTtl;
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
    ushort wPreference;
    ushort Pad;
}

struct DNS_MX_DATAA
{
    const(char)* pNameExchange;
    ushort wPreference;
    ushort Pad;
}

struct DNS_TXT_DATAW
{
    uint dwStringCount;
    ushort* pStringArray;
}

struct DNS_TXT_DATAA
{
    uint dwStringCount;
    byte* pStringArray;
}

struct DNS_NULL_DATA
{
    uint dwByteCount;
    ubyte Data;
}

struct DNS_WKS_DATA
{
    uint IpAddress;
    ubyte chProtocol;
    ubyte BitMask;
}

struct DNS_AAAA_DATA
{
    IP6_ADDRESS Ip6Address;
}

struct DNS_SIG_DATAW
{
    ushort wTypeCovered;
    ubyte chAlgorithm;
    ubyte chLabelCount;
    uint dwOriginalTtl;
    uint dwExpiration;
    uint dwTimeSigned;
    ushort wKeyTag;
    ushort wSignatureLength;
    const(wchar)* pNameSigner;
    ubyte Signature;
}

struct DNS_SIG_DATAA
{
    ushort wTypeCovered;
    ubyte chAlgorithm;
    ubyte chLabelCount;
    uint dwOriginalTtl;
    uint dwExpiration;
    uint dwTimeSigned;
    ushort wKeyTag;
    ushort wSignatureLength;
    const(char)* pNameSigner;
    ubyte Signature;
}

struct DNS_KEY_DATA
{
    ushort wFlags;
    ubyte chProtocol;
    ubyte chAlgorithm;
    ushort wKeyLength;
    ushort wPad;
    ubyte Key;
}

struct DNS_DHCID_DATA
{
    uint dwByteCount;
    ubyte DHCID;
}

struct DNS_NSEC_DATAW
{
    const(wchar)* pNextDomainName;
    ushort wTypeBitMapsLength;
    ushort wPad;
    ubyte TypeBitMaps;
}

struct DNS_NSEC_DATAA
{
    const(char)* pNextDomainName;
    ushort wTypeBitMapsLength;
    ushort wPad;
    ubyte TypeBitMaps;
}

struct DNS_NSEC3_DATA
{
    ubyte chAlgorithm;
    ubyte bFlags;
    ushort wIterations;
    ubyte bSaltLength;
    ubyte bHashLength;
    ushort wTypeBitMapsLength;
    ubyte chData;
}

struct DNS_NSEC3PARAM_DATA
{
    ubyte chAlgorithm;
    ubyte bFlags;
    ushort wIterations;
    ubyte bSaltLength;
    ubyte bPad;
    ubyte pbSalt;
}

struct DNS_TLSA_DATA
{
    ubyte bCertUsage;
    ubyte bSelector;
    ubyte bMatchingType;
    ushort bCertificateAssociationDataLength;
    ubyte bPad;
    ubyte bCertificateAssociationData;
}

struct DNS_DS_DATA
{
    ushort wKeyTag;
    ubyte chAlgorithm;
    ubyte chDigestType;
    ushort wDigestLength;
    ushort wPad;
    ubyte Digest;
}

struct DNS_OPT_DATA
{
    ushort wDataLength;
    ushort wPad;
    ubyte Data;
}

struct DNS_LOC_DATA
{
    ushort wVersion;
    ushort wSize;
    ushort wHorPrec;
    ushort wVerPrec;
    uint dwLatitude;
    uint dwLongitude;
    uint dwAltitude;
}

struct DNS_NXT_DATAW
{
    const(wchar)* pNameNext;
    ushort wNumTypes;
    ushort wTypes;
}

struct DNS_NXT_DATAA
{
    const(char)* pNameNext;
    ushort wNumTypes;
    ushort wTypes;
}

struct DNS_SRV_DATAW
{
    const(wchar)* pNameTarget;
    ushort wPriority;
    ushort wWeight;
    ushort wPort;
    ushort Pad;
}

struct DNS_SRV_DATAA
{
    const(char)* pNameTarget;
    ushort wPriority;
    ushort wWeight;
    ushort wPort;
    ushort Pad;
}

struct DNS_NAPTR_DATAW
{
    ushort wOrder;
    ushort wPreference;
    const(wchar)* pFlags;
    const(wchar)* pService;
    const(wchar)* pRegularExpression;
    const(wchar)* pReplacement;
}

struct DNS_NAPTR_DATAA
{
    ushort wOrder;
    ushort wPreference;
    const(char)* pFlags;
    const(char)* pService;
    const(char)* pRegularExpression;
    const(char)* pReplacement;
}

struct DNS_ATMA_DATA
{
    ubyte AddressType;
    ubyte Address;
}

struct DNS_TKEY_DATAW
{
    const(wchar)* pNameAlgorithm;
    ubyte* pAlgorithmPacket;
    ubyte* pKey;
    ubyte* pOtherData;
    uint dwCreateTime;
    uint dwExpireTime;
    ushort wMode;
    ushort wError;
    ushort wKeyLength;
    ushort wOtherLength;
    ubyte cAlgNameLength;
    BOOL bPacketPointers;
}

struct DNS_TKEY_DATAA
{
    const(char)* pNameAlgorithm;
    ubyte* pAlgorithmPacket;
    ubyte* pKey;
    ubyte* pOtherData;
    uint dwCreateTime;
    uint dwExpireTime;
    ushort wMode;
    ushort wError;
    ushort wKeyLength;
    ushort wOtherLength;
    ubyte cAlgNameLength;
    BOOL bPacketPointers;
}

struct DNS_TSIG_DATAW
{
    const(wchar)* pNameAlgorithm;
    ubyte* pAlgorithmPacket;
    ubyte* pSignature;
    ubyte* pOtherData;
    long i64CreateTime;
    ushort wFudgeTime;
    ushort wOriginalXid;
    ushort wError;
    ushort wSigLength;
    ushort wOtherLength;
    ubyte cAlgNameLength;
    BOOL bPacketPointers;
}

struct DNS_TSIG_DATAA
{
    const(char)* pNameAlgorithm;
    ubyte* pAlgorithmPacket;
    ubyte* pSignature;
    ubyte* pOtherData;
    long i64CreateTime;
    ushort wFudgeTime;
    ushort wOriginalXid;
    ushort wError;
    ushort wSigLength;
    ushort wOtherLength;
    ubyte cAlgNameLength;
    BOOL bPacketPointers;
}

struct DNS_UNKNOWN_DATA
{
    uint dwByteCount;
    ubyte bData;
}

struct DNS_WINS_DATA
{
    uint dwMappingFlag;
    uint dwLookupTimeout;
    uint dwCacheTimeout;
    uint cWinsServerCount;
    uint WinsServers;
}

struct DNS_WINSR_DATAW
{
    uint dwMappingFlag;
    uint dwLookupTimeout;
    uint dwCacheTimeout;
    const(wchar)* pNameResultDomain;
}

struct DNS_WINSR_DATAA
{
    uint dwMappingFlag;
    uint dwLookupTimeout;
    uint dwCacheTimeout;
    const(char)* pNameResultDomain;
}

struct DNS_RECORD_FLAGS
{
    uint _bitfield;
}

enum DNS_SECTION
{
    DnsSectionQuestion = 0,
    DnsSectionAnswer = 1,
    DnsSectionAuthority = 2,
    DnsSectionAddtional = 3,
}

struct DNS_RECORDW
{
    DNS_RECORDW* pNext;
    const(wchar)* pName;
    ushort wType;
    ushort wDataLength;
    _Flags_e__Union Flags;
    uint dwTtl;
    uint dwReserved;
    _Data_e__Union Data;
}

struct _DnsRecordOptW
{
    DNS_RECORDW* pNext;
    const(wchar)* pName;
    ushort wType;
    ushort wDataLength;
    _Flags_e__Union Flags;
    DNS_HEADER_EXT ExtHeader;
    ushort wPayloadSize;
    ushort wReserved;
    _Data_e__Union Data;
}

struct DNS_RECORDA
{
    DNS_RECORDA* pNext;
    const(char)* pName;
    ushort wType;
    ushort wDataLength;
    _Flags_e__Union Flags;
    uint dwTtl;
    uint dwReserved;
    _Data_e__Union Data;
}

struct _DnsRecordOptA
{
    DNS_RECORDA* pNext;
    const(char)* pName;
    ushort wType;
    ushort wDataLength;
    _Flags_e__Union Flags;
    DNS_HEADER_EXT ExtHeader;
    ushort wPayloadSize;
    ushort wReserved;
    _Data_e__Union Data;
}

struct DNS_RRSET
{
    DNS_RECORDA* pFirstRR;
    DNS_RECORDA* pLastRR;
}

alias DNS_PROXY_COMPLETION_ROUTINE = extern(Windows) void function(void* completionContext, int status);
enum DNS_PROXY_INFORMATION_TYPE
{
    DNS_PROXY_INFORMATION_DIRECT = 0,
    DNS_PROXY_INFORMATION_DEFAULT_SETTINGS = 1,
    DNS_PROXY_INFORMATION_PROXY_NAME = 2,
    DNS_PROXY_INFORMATION_DOES_NOT_EXIST = 3,
}

struct DNS_PROXY_INFORMATION
{
    uint version;
    DNS_PROXY_INFORMATION_TYPE proxyInformationType;
    const(wchar)* proxyName;
}

enum DNS_CHARSET
{
    DnsCharSetUnknown = 0,
    DnsCharSetUnicode = 1,
    DnsCharSetUtf8 = 2,
    DnsCharSetAnsi = 3,
}

enum DNS_FREE_TYPE
{
    DnsFreeFlat = 0,
    DnsFreeRecordList = 1,
    DnsFreeParsedMessageFields = 2,
}

struct DNS_QUERY_RESULT
{
    uint Version;
    int QueryStatus;
    ulong QueryOptions;
    DNS_RECORDA* pQueryRecords;
    void* Reserved;
}

alias DNS_QUERY_COMPLETION_ROUTINE = extern(Windows) void function(void* pQueryContext, DNS_QUERY_RESULT* pQueryResults);
alias PDNS_QUERY_COMPLETION_ROUTINE = extern(Windows) void function();
struct DNS_QUERY_REQUEST
{
    uint Version;
    const(wchar)* QueryName;
    ushort QueryType;
    ulong QueryOptions;
    DNS_ADDR_ARRAY* pDnsServerList;
    uint InterfaceIndex;
    PDNS_QUERY_COMPLETION_ROUTINE pQueryCompletionCallback;
    void* pQueryContext;
}

struct DNS_QUERY_CANCEL
{
    byte Reserved;
}

enum DNS_NAME_FORMAT
{
    DnsNameDomain = 0,
    DnsNameDomainLabel = 1,
    DnsNameHostnameFull = 2,
    DnsNameHostnameLabel = 3,
    DnsNameWildcard = 4,
    DnsNameSrvRecord = 5,
    DnsNameValidateTld = 6,
}

struct DNS_MESSAGE_BUFFER
{
    DNS_HEADER MessageHead;
    byte MessageBody;
}

enum DNS_CONNECTION_PROXY_TYPE
{
    DNS_CONNECTION_PROXY_TYPE_NULL = 0,
    DNS_CONNECTION_PROXY_TYPE_HTTP = 1,
    DNS_CONNECTION_PROXY_TYPE_WAP = 2,
    DNS_CONNECTION_PROXY_TYPE_SOCKS4 = 4,
    DNS_CONNECTION_PROXY_TYPE_SOCKS5 = 5,
}

enum DNS_CONNECTION_PROXY_INFO_SWITCH
{
    DNS_CONNECTION_PROXY_INFO_SWITCH_CONFIG = 0,
    DNS_CONNECTION_PROXY_INFO_SWITCH_SCRIPT = 1,
    DNS_CONNECTION_PROXY_INFO_SWITCH_WPAD = 2,
}

struct DNS_CONNECTION_PROXY_INFO
{
    uint Version;
    ushort* pwszFriendlyName;
    uint Flags;
    DNS_CONNECTION_PROXY_INFO_SWITCH Switch;
    _Anonymous_e__Union Anonymous;
}

struct DNS_CONNECTION_PROXY_INFO_EX
{
    DNS_CONNECTION_PROXY_INFO ProxyInfo;
    uint dwInterfaceIndex;
    ushort* pwszConnectionName;
    BOOL fDirectConfiguration;
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
    ushort wszName;
}

struct DNS_CONNECTION_NAME_LIST
{
    uint cNames;
    DNS_CONNECTION_NAME* pNames;
}

struct DNS_CONNECTION_IFINDEX_ENTRY
{
    const(wchar)* pwszConnectionName;
    uint dwIfIndex;
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
    uint cbAppSid;
    ubyte* pbAppSid;
    uint nConnections;
    ushort** ppwszConnections;
    uint dwPolicyEntryFlags;
}

struct DNS_CONNECTION_POLICY_ENTRY_LIST
{
    DNS_CONNECTION_POLICY_ENTRY* pPolicyEntries;
    uint nEntries;
}

enum DNS_CONNECTION_POLICY_TAG
{
    TAG_DNS_CONNECTION_POLICY_TAG_DEFAULT = 0,
    TAG_DNS_CONNECTION_POLICY_TAG_CONNECTION_MANAGER = 1,
    TAG_DNS_CONNECTION_POLICY_TAG_WWWPT = 2,
}

struct DNS_SERVICE_INSTANCE
{
    const(wchar)* pszInstanceName;
    const(wchar)* pszHostName;
    uint* ip4Address;
    IP6_ADDRESS* ip6Address;
    ushort wPort;
    ushort wPriority;
    ushort wWeight;
    uint dwPropertyCount;
    ushort** keys;
    ushort** values;
    uint dwInterfaceIndex;
}

struct DNS_SERVICE_CANCEL
{
    void* reserved;
}

alias DNS_SERVICE_BROWSE_CALLBACK = extern(Windows) void function(uint Status, void* pQueryContext, DNS_RECORDA* pDnsRecord);
alias PDNS_SERVICE_BROWSE_CALLBACK = extern(Windows) void function();
struct DNS_SERVICE_BROWSE_REQUEST
{
    uint Version;
    uint InterfaceIndex;
    const(wchar)* QueryName;
    _Anonymous_e__Union Anonymous;
    void* pQueryContext;
}

alias DNS_SERVICE_RESOLVE_COMPLETE = extern(Windows) void function(uint Status, void* pQueryContext, DNS_SERVICE_INSTANCE* pInstance);
alias PDNS_SERVICE_RESOLVE_COMPLETE = extern(Windows) void function();
struct DNS_SERVICE_RESOLVE_REQUEST
{
    uint Version;
    uint InterfaceIndex;
    const(wchar)* QueryName;
    PDNS_SERVICE_RESOLVE_COMPLETE pResolveCompletionCallback;
    void* pQueryContext;
}

alias DNS_SERVICE_REGISTER_COMPLETE = extern(Windows) void function(uint Status, void* pQueryContext, DNS_SERVICE_INSTANCE* pInstance);
alias PDNS_SERVICE_REGISTER_COMPLETE = extern(Windows) void function();
struct DNS_SERVICE_REGISTER_REQUEST
{
    uint Version;
    uint InterfaceIndex;
    DNS_SERVICE_INSTANCE* pServiceInstance;
    PDNS_SERVICE_REGISTER_COMPLETE pRegisterCompletionCallback;
    void* pQueryContext;
    HANDLE hCredentials;
    BOOL unicastEnabled;
}

struct MDNS_QUERY_HANDLE
{
    ushort nameBuf;
    ushort wType;
    void* pSubscription;
    void* pWnfCallbackParams;
    uint stateNameData;
}

alias MDNS_QUERY_CALLBACK = extern(Windows) void function(void* pQueryContext, MDNS_QUERY_HANDLE* pQueryHandle, DNS_QUERY_RESULT* pQueryResults);
alias PMDNS_QUERY_CALLBACK = extern(Windows) void function();
struct MDNS_QUERY_REQUEST
{
    uint Version;
    uint ulRefCount;
    const(wchar)* Query;
    ushort QueryType;
    ulong QueryOptions;
    uint InterfaceIndex;
    PMDNS_QUERY_CALLBACK pQueryCallback;
    void* pQueryContext;
    BOOL fAnswerReceived;
    uint ulResendCount;
}

@DllImport("DNSAPI.dll")
int DnsQueryConfig(DNS_CONFIG_TYPE Config, uint Flag, const(wchar)* pwsAdapterName, void* pReserved, char* pBuffer, uint* pBufLen);

@DllImport("DNSAPI.dll")
DNS_RECORDA* DnsRecordCopyEx(DNS_RECORDA* pRecord, DNS_CHARSET CharSetIn, DNS_CHARSET CharSetOut);

@DllImport("DNSAPI.dll")
DNS_RECORDA* DnsRecordSetCopyEx(DNS_RECORDA* pRecordSet, DNS_CHARSET CharSetIn, DNS_CHARSET CharSetOut);

@DllImport("DNSAPI.dll")
BOOL DnsRecordCompare(DNS_RECORDA* pRecord1, DNS_RECORDA* pRecord2);

@DllImport("DNSAPI.dll")
BOOL DnsRecordSetCompare(DNS_RECORDA* pRR1, DNS_RECORDA* pRR2, DNS_RECORDA** ppDiff1, DNS_RECORDA** ppDiff2);

@DllImport("DNSAPI.dll")
DNS_RECORDA* DnsRecordSetDetach(DNS_RECORDA* pRecordList);

@DllImport("DNSAPI.dll")
void DnsFree(void* pData, DNS_FREE_TYPE FreeType);

@DllImport("DNSAPI.dll")
int DnsQuery_A(const(char)* pszName, ushort wType, uint Options, void* pExtra, DNS_RECORDA** ppQueryResults, void** pReserved);

@DllImport("DNSAPI.dll")
int DnsQuery_UTF8(const(char)* pszName, ushort wType, uint Options, void* pExtra, DNS_RECORDA** ppQueryResults, void** pReserved);

@DllImport("DNSAPI.dll")
int DnsQuery_W(const(wchar)* pszName, ushort wType, uint Options, void* pExtra, DNS_RECORDA** ppQueryResults, void** pReserved);

@DllImport("DNSAPI.dll")
int DnsQueryEx(DNS_QUERY_REQUEST* pQueryRequest, DNS_QUERY_RESULT* pQueryResults, DNS_QUERY_CANCEL* pCancelHandle);

@DllImport("DNSAPI.dll")
int DnsCancelQuery(DNS_QUERY_CANCEL* pCancelHandle);

@DllImport("DNSAPI.dll")
int DnsAcquireContextHandle_W(uint CredentialFlags, void* Credentials, DnsContextHandle* pContext);

@DllImport("DNSAPI.dll")
int DnsAcquireContextHandle_A(uint CredentialFlags, void* Credentials, DnsContextHandle* pContext);

@DllImport("DNSAPI.dll")
void DnsReleaseContextHandle(HANDLE hContext);

@DllImport("DNSAPI.dll")
int DnsModifyRecordsInSet_W(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, HANDLE hCredentials, void* pExtraList, void* pReserved);

@DllImport("DNSAPI.dll")
int DnsModifyRecordsInSet_A(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, HANDLE hCredentials, void* pExtraList, void* pReserved);

@DllImport("DNSAPI.dll")
int DnsModifyRecordsInSet_UTF8(DNS_RECORDA* pAddRecords, DNS_RECORDA* pDeleteRecords, uint Options, HANDLE hCredentials, void* pExtraList, void* pReserved);

@DllImport("DNSAPI.dll")
int DnsReplaceRecordSetW(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, void* pReserved);

@DllImport("DNSAPI.dll")
int DnsReplaceRecordSetA(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, void* pReserved);

@DllImport("DNSAPI.dll")
int DnsReplaceRecordSetUTF8(DNS_RECORDA* pReplaceSet, uint Options, HANDLE hContext, void* pExtraInfo, void* pReserved);

@DllImport("DNSAPI.dll")
int DnsValidateName_W(const(wchar)* pszName, DNS_NAME_FORMAT Format);

@DllImport("DNSAPI.dll")
int DnsValidateName_A(const(char)* pszName, DNS_NAME_FORMAT Format);

@DllImport("DNSAPI.dll")
int DnsValidateName_UTF8(const(char)* pszName, DNS_NAME_FORMAT Format);

@DllImport("DNSAPI.dll")
BOOL DnsNameCompare_A(const(char)* pName1, const(char)* pName2);

@DllImport("DNSAPI.dll")
BOOL DnsNameCompare_W(const(wchar)* pName1, const(wchar)* pName2);

@DllImport("DNSAPI.dll")
BOOL DnsWriteQuestionToBuffer_W(DNS_MESSAGE_BUFFER* pDnsBuffer, uint* pdwBufferSize, const(wchar)* pszName, ushort wType, ushort Xid, BOOL fRecursionDesired);

@DllImport("DNSAPI.dll")
BOOL DnsWriteQuestionToBuffer_UTF8(DNS_MESSAGE_BUFFER* pDnsBuffer, uint* pdwBufferSize, const(char)* pszName, ushort wType, ushort Xid, BOOL fRecursionDesired);

@DllImport("DNSAPI.dll")
int DnsExtractRecordsFromMessage_W(DNS_MESSAGE_BUFFER* pDnsBuffer, ushort wMessageLength, DNS_RECORDA** ppRecord);

@DllImport("DNSAPI.dll")
int DnsExtractRecordsFromMessage_UTF8(DNS_MESSAGE_BUFFER* pDnsBuffer, ushort wMessageLength, DNS_RECORDA** ppRecord);

@DllImport("DNSAPI.dll")
uint DnsGetProxyInformation(const(wchar)* hostName, DNS_PROXY_INFORMATION* proxyInformation, DNS_PROXY_INFORMATION* defaultProxyInformation, DNS_PROXY_COMPLETION_ROUTINE completionRoutine, void* completionContext);

@DllImport("DNSAPI.dll")
void DnsFreeProxyName(const(wchar)* proxyName);

@DllImport("DNSAPI.dll")
uint DnsConnectionGetProxyInfoForHostUrl(const(wchar)* pwszHostUrl, char* pSelectionContext, uint dwSelectionContextLength, uint dwExplicitInterfaceIndex, DNS_CONNECTION_PROXY_INFO_EX* pProxyInfoEx);

@DllImport("DNSAPI.dll")
void DnsConnectionFreeProxyInfoEx(DNS_CONNECTION_PROXY_INFO_EX* pProxyInfoEx);

@DllImport("DNSAPI.dll")
uint DnsConnectionGetProxyInfo(const(wchar)* pwszConnectionName, DNS_CONNECTION_PROXY_TYPE Type, DNS_CONNECTION_PROXY_INFO* pProxyInfo);

@DllImport("DNSAPI.dll")
void DnsConnectionFreeProxyInfo(DNS_CONNECTION_PROXY_INFO* pProxyInfo);

@DllImport("DNSAPI.dll")
uint DnsConnectionSetProxyInfo(const(wchar)* pwszConnectionName, DNS_CONNECTION_PROXY_TYPE Type, const(DNS_CONNECTION_PROXY_INFO)* pProxyInfo);

@DllImport("DNSAPI.dll")
uint DnsConnectionDeleteProxyInfo(const(wchar)* pwszConnectionName, DNS_CONNECTION_PROXY_TYPE Type);

@DllImport("DNSAPI.dll")
uint DnsConnectionGetProxyList(const(wchar)* pwszConnectionName, DNS_CONNECTION_PROXY_LIST* pProxyList);

@DllImport("DNSAPI.dll")
void DnsConnectionFreeProxyList(DNS_CONNECTION_PROXY_LIST* pProxyList);

@DllImport("DNSAPI.dll")
uint DnsConnectionGetNameList(DNS_CONNECTION_NAME_LIST* pNameList);

@DllImport("DNSAPI.dll")
void DnsConnectionFreeNameList(DNS_CONNECTION_NAME_LIST* pNameList);

@DllImport("DNSAPI.dll")
uint DnsConnectionUpdateIfIndexTable(DNS_CONNECTION_IFINDEX_LIST* pConnectionIfIndexEntries);

@DllImport("DNSAPI.dll")
uint DnsConnectionSetPolicyEntries(DNS_CONNECTION_POLICY_TAG PolicyEntryTag, DNS_CONNECTION_POLICY_ENTRY_LIST* pPolicyEntryList);

@DllImport("DNSAPI.dll")
uint DnsConnectionDeletePolicyEntries(DNS_CONNECTION_POLICY_TAG PolicyEntryTag);

@DllImport("DNSAPI.dll")
DNS_SERVICE_INSTANCE* DnsServiceConstructInstance(const(wchar)* pServiceName, const(wchar)* pHostName, uint* pIp4, IP6_ADDRESS* pIp6, ushort wPort, ushort wPriority, ushort wWeight, uint dwPropertiesCount, char* keys, char* values);

@DllImport("DNSAPI.dll")
DNS_SERVICE_INSTANCE* DnsServiceCopyInstance(DNS_SERVICE_INSTANCE* pOrig);

@DllImport("DNSAPI.dll")
void DnsServiceFreeInstance(DNS_SERVICE_INSTANCE* pInstance);

@DllImport("DNSAPI.dll")
int DnsServiceBrowse(DNS_SERVICE_BROWSE_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

@DllImport("DNSAPI.dll")
int DnsServiceBrowseCancel(DNS_SERVICE_CANCEL* pCancelHandle);

@DllImport("DNSAPI.dll")
int DnsServiceResolve(DNS_SERVICE_RESOLVE_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

@DllImport("DNSAPI.dll")
int DnsServiceResolveCancel(DNS_SERVICE_CANCEL* pCancelHandle);

@DllImport("DNSAPI.dll")
uint DnsServiceRegister(DNS_SERVICE_REGISTER_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

@DllImport("DNSAPI.dll")
uint DnsServiceDeRegister(DNS_SERVICE_REGISTER_REQUEST* pRequest, DNS_SERVICE_CANCEL* pCancel);

@DllImport("DNSAPI.dll")
uint DnsServiceRegisterCancel(DNS_SERVICE_CANCEL* pCancelHandle);

@DllImport("DNSAPI.dll")
int DnsStartMulticastQuery(MDNS_QUERY_REQUEST* pQueryRequest, MDNS_QUERY_HANDLE* pHandle);

@DllImport("DNSAPI.dll")
int DnsStopMulticastQuery(MDNS_QUERY_HANDLE* pHandle);

alias DnsContextHandle = int;
