module windows.windowsfiltering;

public import system;
public import windows.kernel;
public import windows.security;
public import windows.systemservices;
public import windows.winsock;
public import windows.windowsprogramming;

extern(Windows):

enum FWP_DIRECTION
{
    FWP_DIRECTION_OUTBOUND = 0,
    FWP_DIRECTION_INBOUND = 1,
    FWP_DIRECTION_MAX = 2,
}

enum FWP_IP_VERSION
{
    FWP_IP_VERSION_V4 = 0,
    FWP_IP_VERSION_V6 = 1,
    FWP_IP_VERSION_NONE = 2,
    FWP_IP_VERSION_MAX = 3,
}

enum FWP_AF
{
    FWP_AF_INET = 0,
    FWP_AF_INET6 = 1,
    FWP_AF_ETHER = 2,
    FWP_AF_NONE = 3,
}

enum FWP_ETHER_ENCAP_METHOD
{
    FWP_ETHER_ENCAP_METHOD_ETHER_V2 = 0,
    FWP_ETHER_ENCAP_METHOD_SNAP = 1,
    FWP_ETHER_ENCAP_METHOD_SNAP_W_OUI_ZERO = 3,
}

enum FWP_DATA_TYPE
{
    FWP_EMPTY = 0,
    FWP_UINT8 = 1,
    FWP_UINT16 = 2,
    FWP_UINT32 = 3,
    FWP_UINT64 = 4,
    FWP_INT8 = 5,
    FWP_INT16 = 6,
    FWP_INT32 = 7,
    FWP_INT64 = 8,
    FWP_FLOAT = 9,
    FWP_DOUBLE = 10,
    FWP_BYTE_ARRAY16_TYPE = 11,
    FWP_BYTE_BLOB_TYPE = 12,
    FWP_SID = 13,
    FWP_SECURITY_DESCRIPTOR_TYPE = 14,
    FWP_TOKEN_INFORMATION_TYPE = 15,
    FWP_TOKEN_ACCESS_INFORMATION_TYPE = 16,
    FWP_UNICODE_STRING_TYPE = 17,
    FWP_BYTE_ARRAY6_TYPE = 18,
    FWP_BITMAP_INDEX_TYPE = 19,
    FWP_BITMAP_ARRAY64_TYPE = 20,
    FWP_SINGLE_DATA_TYPE_MAX = 255,
    FWP_V4_ADDR_MASK = 256,
    FWP_V6_ADDR_MASK = 257,
    FWP_RANGE_TYPE = 258,
    FWP_DATA_TYPE_MAX = 259,
}

struct FWP_BITMAP_ARRAY64_
{
    ubyte bitmapArray64;
}

struct FWP_BYTE_ARRAY6
{
    ubyte byteArray6;
}

struct FWP_BYTE_ARRAY16
{
    ubyte byteArray16;
}

struct FWP_BYTE_BLOB
{
    uint size;
    ubyte* data;
}

struct FWP_TOKEN_INFORMATION
{
    uint sidCount;
    SID_AND_ATTRIBUTES* sids;
    uint restrictedSidCount;
    SID_AND_ATTRIBUTES* restrictedSids;
}

struct FWP_VALUE0
{
    FWP_DATA_TYPE type;
    _Anonymous_e__Union Anonymous;
}

enum FWP_MATCH_TYPE
{
    FWP_MATCH_EQUAL = 0,
    FWP_MATCH_GREATER = 1,
    FWP_MATCH_LESS = 2,
    FWP_MATCH_GREATER_OR_EQUAL = 3,
    FWP_MATCH_LESS_OR_EQUAL = 4,
    FWP_MATCH_RANGE = 5,
    FWP_MATCH_FLAGS_ALL_SET = 6,
    FWP_MATCH_FLAGS_ANY_SET = 7,
    FWP_MATCH_FLAGS_NONE_SET = 8,
    FWP_MATCH_EQUAL_CASE_INSENSITIVE = 9,
    FWP_MATCH_NOT_EQUAL = 10,
    FWP_MATCH_PREFIX = 11,
    FWP_MATCH_NOT_PREFIX = 12,
    FWP_MATCH_TYPE_MAX = 13,
}

struct FWP_V4_ADDR_AND_MASK
{
    uint addr;
    uint mask;
}

struct FWP_V6_ADDR_AND_MASK
{
    ubyte addr;
    ubyte prefixLength;
}

struct FWP_RANGE0
{
    FWP_VALUE0 valueLow;
    FWP_VALUE0 valueHigh;
}

struct FWP_CONDITION_VALUE0
{
    FWP_DATA_TYPE type;
    _Anonymous_e__Union Anonymous;
}

enum FWP_CLASSIFY_OPTION_TYPE
{
    FWP_CLASSIFY_OPTION_MULTICAST_STATE = 0,
    FWP_CLASSIFY_OPTION_LOOSE_SOURCE_MAPPING = 1,
    FWP_CLASSIFY_OPTION_UNICAST_LIFETIME = 2,
    FWP_CLASSIFY_OPTION_MCAST_BCAST_LIFETIME = 3,
    FWP_CLASSIFY_OPTION_SECURE_SOCKET_SECURITY_FLAGS = 4,
    FWP_CLASSIFY_OPTION_SECURE_SOCKET_AUTHIP_MM_POLICY_KEY = 5,
    FWP_CLASSIFY_OPTION_SECURE_SOCKET_AUTHIP_QM_POLICY_KEY = 6,
    FWP_CLASSIFY_OPTION_LOCAL_ONLY_MAPPING = 7,
    FWP_CLASSIFY_OPTION_MAX = 8,
}

enum FWP_VSWITCH_NETWORK_TYPE
{
    FWP_VSWITCH_NETWORK_TYPE_UNKNOWN = 0,
    FWP_VSWITCH_NETWORK_TYPE_PRIVATE = 1,
    FWP_VSWITCH_NETWORK_TYPE_INTERNAL = 2,
    FWP_VSWITCH_NETWORK_TYPE_EXTERNAL = 3,
}

enum FWP_FILTER_ENUM_TYPE
{
    FWP_FILTER_ENUM_FULLY_CONTAINED = 0,
    FWP_FILTER_ENUM_OVERLAPPING = 1,
    FWP_FILTER_ENUM_TYPE_MAX = 2,
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

enum IKEEXT_KEY_MODULE_TYPE
{
    IKEEXT_KEY_MODULE_IKE = 0,
    IKEEXT_KEY_MODULE_AUTHIP = 1,
    IKEEXT_KEY_MODULE_IKEV2 = 2,
    IKEEXT_KEY_MODULE_MAX = 3,
}

enum IKEEXT_AUTHENTICATION_METHOD_TYPE
{
    IKEEXT_PRESHARED_KEY = 0,
    IKEEXT_CERTIFICATE = 1,
    IKEEXT_KERBEROS = 2,
    IKEEXT_ANONYMOUS = 3,
    IKEEXT_SSL = 4,
    IKEEXT_NTLM_V2 = 5,
    IKEEXT_IPV6_CGA = 6,
    IKEEXT_CERTIFICATE_ECDSA_P256 = 7,
    IKEEXT_CERTIFICATE_ECDSA_P384 = 8,
    IKEEXT_SSL_ECDSA_P256 = 9,
    IKEEXT_SSL_ECDSA_P384 = 10,
    IKEEXT_EAP = 11,
    IKEEXT_RESERVED = 12,
    IKEEXT_AUTHENTICATION_METHOD_TYPE_MAX = 13,
}

enum IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE
{
    IKEEXT_IMPERSONATION_NONE = 0,
    IKEEXT_IMPERSONATION_SOCKET_PRINCIPAL = 1,
    IKEEXT_IMPERSONATION_MAX = 2,
}

struct IKEEXT_PRESHARED_KEY_AUTHENTICATION0
{
    FWP_BYTE_BLOB presharedKey;
}

struct IKEEXT_PRESHARED_KEY_AUTHENTICATION1
{
    FWP_BYTE_BLOB presharedKey;
    uint flags;
}

struct IKEEXT_CERT_ROOT_CONFIG0
{
    FWP_BYTE_BLOB certData;
    uint flags;
}

enum IKEEXT_CERT_CONFIG_TYPE
{
    IKEEXT_CERT_CONFIG_EXPLICIT_TRUST_LIST = 0,
    IKEEXT_CERT_CONFIG_ENTERPRISE_STORE = 1,
    IKEEXT_CERT_CONFIG_TRUSTED_ROOT_STORE = 2,
    IKEEXT_CERT_CONFIG_UNSPECIFIED = 3,
    IKEEXT_CERT_CONFIG_TYPE_MAX = 4,
}

struct IKEEXT_CERTIFICATE_AUTHENTICATION0
{
    IKEEXT_CERT_CONFIG_TYPE inboundConfigType;
    _Anonymous1_e__Union Anonymous1;
    IKEEXT_CERT_CONFIG_TYPE outboundConfigType;
    _Anonymous2_e__Union Anonymous2;
    uint flags;
}

struct IKEEXT_CERTIFICATE_AUTHENTICATION1
{
    IKEEXT_CERT_CONFIG_TYPE inboundConfigType;
    _Anonymous1_e__Union Anonymous1;
    IKEEXT_CERT_CONFIG_TYPE outboundConfigType;
    _Anonymous2_e__Union Anonymous2;
    uint flags;
    FWP_BYTE_BLOB localCertLocationUrl;
}

enum IKEEXT_CERT_CRITERIA_NAME_TYPE
{
    IKEEXT_CERT_CRITERIA_DNS = 0,
    IKEEXT_CERT_CRITERIA_UPN = 1,
    IKEEXT_CERT_CRITERIA_RFC822 = 2,
    IKEEXT_CERT_CRITERIA_CN = 3,
    IKEEXT_CERT_CRITERIA_OU = 4,
    IKEEXT_CERT_CRITERIA_O = 5,
    IKEEXT_CERT_CRITERIA_DC = 6,
    IKEEXT_CERT_CRITERIA_NAME_TYPE_MAX = 7,
}

struct IKEEXT_CERT_EKUS0
{
    uint numEku;
    byte** eku;
}

struct IKEEXT_CERT_NAME0
{
    IKEEXT_CERT_CRITERIA_NAME_TYPE nameType;
    const(wchar)* certName;
}

struct IKEEXT_CERTIFICATE_CRITERIA0
{
    FWP_BYTE_BLOB certData;
    FWP_BYTE_BLOB certHash;
    IKEEXT_CERT_EKUS0* eku;
    IKEEXT_CERT_NAME0* name;
    uint flags;
}

struct IKEEXT_CERTIFICATE_AUTHENTICATION2
{
    IKEEXT_CERT_CONFIG_TYPE inboundConfigType;
    _Anonymous1_e__Union Anonymous1;
    IKEEXT_CERT_CONFIG_TYPE outboundConfigType;
    _Anonymous2_e__Union Anonymous2;
    uint flags;
    FWP_BYTE_BLOB localCertLocationUrl;
}

struct IKEEXT_IPV6_CGA_AUTHENTICATION0
{
    ushort* keyContainerName;
    ushort* cspName;
    uint cspType;
    FWP_BYTE_ARRAY16 cgaModifier;
    ubyte cgaCollisionCount;
}

struct IKEEXT_KERBEROS_AUTHENTICATION0
{
    uint flags;
}

struct IKEEXT_KERBEROS_AUTHENTICATION1
{
    uint flags;
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
    _Anonymous_e__Union Anonymous;
}

struct IKEEXT_AUTHENTICATION_METHOD1
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    _Anonymous_e__Union Anonymous;
}

struct IKEEXT_AUTHENTICATION_METHOD2
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    _Anonymous_e__Union Anonymous;
}

enum IKEEXT_CIPHER_TYPE
{
    IKEEXT_CIPHER_DES = 0,
    IKEEXT_CIPHER_3DES = 1,
    IKEEXT_CIPHER_AES_128 = 2,
    IKEEXT_CIPHER_AES_192 = 3,
    IKEEXT_CIPHER_AES_256 = 4,
    IKEEXT_CIPHER_AES_GCM_128_16ICV = 5,
    IKEEXT_CIPHER_AES_GCM_256_16ICV = 6,
    IKEEXT_CIPHER_TYPE_MAX = 7,
}

struct IKEEXT_CIPHER_ALGORITHM0
{
    IKEEXT_CIPHER_TYPE algoIdentifier;
    uint keyLen;
    uint rounds;
}

enum IKEEXT_INTEGRITY_TYPE
{
    IKEEXT_INTEGRITY_MD5 = 0,
    IKEEXT_INTEGRITY_SHA1 = 1,
    IKEEXT_INTEGRITY_SHA_256 = 2,
    IKEEXT_INTEGRITY_SHA_384 = 3,
    IKEEXT_INTEGRITY_TYPE_MAX = 4,
}

struct IKEEXT_INTEGRITY_ALGORITHM0
{
    IKEEXT_INTEGRITY_TYPE algoIdentifier;
}

enum IKEEXT_DH_GROUP
{
    IKEEXT_DH_GROUP_NONE = 0,
    IKEEXT_DH_GROUP_1 = 1,
    IKEEXT_DH_GROUP_2 = 2,
    IKEEXT_DH_GROUP_14 = 3,
    IKEEXT_DH_GROUP_2048 = 3,
    IKEEXT_DH_ECP_256 = 4,
    IKEEXT_DH_ECP_384 = 5,
    IKEEXT_DH_GROUP_24 = 6,
    IKEEXT_DH_GROUP_MAX = 7,
}

struct IKEEXT_PROPOSAL0
{
    IKEEXT_CIPHER_ALGORITHM0 cipherAlgorithm;
    IKEEXT_INTEGRITY_ALGORITHM0 integrityAlgorithm;
    uint maxLifetimeSeconds;
    IKEEXT_DH_GROUP dhGroup;
    uint quickModeLimit;
}

struct IKEEXT_POLICY0
{
    uint softExpirationTime;
    uint numAuthenticationMethods;
    IKEEXT_AUTHENTICATION_METHOD0* authenticationMethods;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
    uint numIkeProposals;
    IKEEXT_PROPOSAL0* ikeProposals;
    uint flags;
    uint maxDynamicFilters;
}

struct IKEEXT_POLICY1
{
    uint softExpirationTime;
    uint numAuthenticationMethods;
    IKEEXT_AUTHENTICATION_METHOD1* authenticationMethods;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
    uint numIkeProposals;
    IKEEXT_PROPOSAL0* ikeProposals;
    uint flags;
    uint maxDynamicFilters;
    uint retransmitDurationSecs;
}

struct IKEEXT_POLICY2
{
    uint softExpirationTime;
    uint numAuthenticationMethods;
    IKEEXT_AUTHENTICATION_METHOD2* authenticationMethods;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
    uint numIkeProposals;
    IKEEXT_PROPOSAL0* ikeProposals;
    uint flags;
    uint maxDynamicFilters;
    uint retransmitDurationSecs;
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
    uint errorFrequencyTable;
    uint mainModeNegotiationTime;
    uint quickModeNegotiationTime;
    uint extendedModeNegotiationTime;
}

struct IKEEXT_KEYMODULE_STATISTICS1
{
    IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1 v4Statistics;
    IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1 v6Statistics;
    uint errorFrequencyTable;
    uint mainModeNegotiationTime;
    uint quickModeNegotiationTime;
    uint extendedModeNegotiationTime;
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
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ulong authIpFilterId;
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
    uint flags;
}

struct IKEEXT_NAME_CREDENTIAL0
{
    ushort* principalName;
}

struct IKEEXT_CREDENTIAL0
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE impersonationType;
    _Anonymous_e__Union Anonymous;
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
    ulong saId;
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    FWP_IP_VERSION ipVersion;
    _Anonymous_e__Union Anonymous;
    IKEEXT_TRAFFIC0 ikeTraffic;
    IKEEXT_PROPOSAL0 ikeProposal;
    IKEEXT_COOKIE_PAIR0 cookiePair;
    IKEEXT_CREDENTIALS0 ikeCredentials;
    Guid ikePolicyKey;
    ulong virtualIfTunnelId;
}

struct IKEEXT_CERTIFICATE_CREDENTIAL1
{
    FWP_BYTE_BLOB subjectName;
    FWP_BYTE_BLOB certHash;
    uint flags;
    FWP_BYTE_BLOB certificate;
}

struct IKEEXT_CREDENTIAL1
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE impersonationType;
    _Anonymous_e__Union Anonymous;
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
    ulong saId;
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    FWP_IP_VERSION ipVersion;
    _Anonymous_e__Union Anonymous;
    IKEEXT_TRAFFIC0 ikeTraffic;
    IKEEXT_PROPOSAL0 ikeProposal;
    IKEEXT_COOKIE_PAIR0 cookiePair;
    IKEEXT_CREDENTIALS1 ikeCredentials;
    Guid ikePolicyKey;
    ulong virtualIfTunnelId;
    FWP_BYTE_BLOB correlationKey;
}

struct IKEEXT_CREDENTIAL2
{
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE impersonationType;
    _Anonymous_e__Union Anonymous;
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
    ulong saId;
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    FWP_IP_VERSION ipVersion;
    _Anonymous_e__Union Anonymous;
    IKEEXT_TRAFFIC0 ikeTraffic;
    IKEEXT_PROPOSAL0 ikeProposal;
    IKEEXT_COOKIE_PAIR0 cookiePair;
    IKEEXT_CREDENTIALS2 ikeCredentials;
    Guid ikePolicyKey;
    ulong virtualIfTunnelId;
    FWP_BYTE_BLOB correlationKey;
}

struct IKEEXT_SA_ENUM_TEMPLATE0
{
    FWP_CONDITION_VALUE0 localSubNet;
    FWP_CONDITION_VALUE0 remoteSubNet;
    FWP_BYTE_BLOB localMainModeCertHash;
}

enum IKEEXT_MM_SA_STATE
{
    IKEEXT_MM_SA_STATE_NONE = 0,
    IKEEXT_MM_SA_STATE_SA_SENT = 1,
    IKEEXT_MM_SA_STATE_SSPI_SENT = 2,
    IKEEXT_MM_SA_STATE_FINAL = 3,
    IKEEXT_MM_SA_STATE_FINAL_SENT = 4,
    IKEEXT_MM_SA_STATE_COMPLETE = 5,
    IKEEXT_MM_SA_STATE_MAX = 6,
}

enum IKEEXT_QM_SA_STATE
{
    IKEEXT_QM_SA_STATE_NONE = 0,
    IKEEXT_QM_SA_STATE_INITIAL = 1,
    IKEEXT_QM_SA_STATE_FINAL = 2,
    IKEEXT_QM_SA_STATE_COMPLETE = 3,
    IKEEXT_QM_SA_STATE_MAX = 4,
}

enum IKEEXT_EM_SA_STATE
{
    IKEEXT_EM_SA_STATE_NONE = 0,
    IKEEXT_EM_SA_STATE_SENT_ATTS = 1,
    IKEEXT_EM_SA_STATE_SSPI_SENT = 2,
    IKEEXT_EM_SA_STATE_AUTH_COMPLETE = 3,
    IKEEXT_EM_SA_STATE_FINAL = 4,
    IKEEXT_EM_SA_STATE_COMPLETE = 5,
    IKEEXT_EM_SA_STATE_MAX = 6,
}

enum IKEEXT_SA_ROLE
{
    IKEEXT_SA_ROLE_INITIATOR = 0,
    IKEEXT_SA_ROLE_RESPONDER = 1,
    IKEEXT_SA_ROLE_MAX = 2,
}

struct IPSEC_SA_LIFETIME0
{
    uint lifetimeSeconds;
    uint lifetimeKilobytes;
    uint lifetimePackets;
}

enum IPSEC_TRANSFORM_TYPE
{
    IPSEC_TRANSFORM_AH = 1,
    IPSEC_TRANSFORM_ESP_AUTH = 2,
    IPSEC_TRANSFORM_ESP_CIPHER = 3,
    IPSEC_TRANSFORM_ESP_AUTH_AND_CIPHER = 4,
    IPSEC_TRANSFORM_ESP_AUTH_FW = 5,
    IPSEC_TRANSFORM_TYPE_MAX = 6,
}

enum IPSEC_AUTH_TYPE
{
    IPSEC_AUTH_MD5 = 0,
    IPSEC_AUTH_SHA_1 = 1,
    IPSEC_AUTH_SHA_256 = 2,
    IPSEC_AUTH_AES_128 = 3,
    IPSEC_AUTH_AES_192 = 4,
    IPSEC_AUTH_AES_256 = 5,
    IPSEC_AUTH_MAX = 6,
}

struct IPSEC_AUTH_TRANSFORM_ID0
{
    IPSEC_AUTH_TYPE authType;
    ubyte authConfig;
}

struct IPSEC_AUTH_TRANSFORM0
{
    IPSEC_AUTH_TRANSFORM_ID0 authTransformId;
    Guid* cryptoModuleId;
}

enum IPSEC_CIPHER_TYPE
{
    IPSEC_CIPHER_TYPE_DES = 1,
    IPSEC_CIPHER_TYPE_3DES = 2,
    IPSEC_CIPHER_TYPE_AES_128 = 3,
    IPSEC_CIPHER_TYPE_AES_192 = 4,
    IPSEC_CIPHER_TYPE_AES_256 = 5,
    IPSEC_CIPHER_TYPE_MAX = 6,
}

struct IPSEC_CIPHER_TRANSFORM_ID0
{
    IPSEC_CIPHER_TYPE cipherType;
    ubyte cipherConfig;
}

struct IPSEC_CIPHER_TRANSFORM0
{
    IPSEC_CIPHER_TRANSFORM_ID0 cipherTransformId;
    Guid* cryptoModuleId;
}

struct IPSEC_AUTH_AND_CIPHER_TRANSFORM0
{
    IPSEC_AUTH_TRANSFORM0 authTransform;
    IPSEC_CIPHER_TRANSFORM0 cipherTransform;
}

struct IPSEC_SA_TRANSFORM0
{
    IPSEC_TRANSFORM_TYPE ipsecTransformType;
    _Anonymous_e__Union Anonymous;
}

enum IPSEC_PFS_GROUP
{
    IPSEC_PFS_NONE = 0,
    IPSEC_PFS_1 = 1,
    IPSEC_PFS_2 = 2,
    IPSEC_PFS_2048 = 3,
    IPSEC_PFS_14 = 3,
    IPSEC_PFS_ECP_256 = 4,
    IPSEC_PFS_ECP_384 = 5,
    IPSEC_PFS_MM = 6,
    IPSEC_PFS_24 = 7,
    IPSEC_PFS_MAX = 8,
}

struct IPSEC_PROPOSAL0
{
    IPSEC_SA_LIFETIME0 lifetime;
    uint numSaTransforms;
    IPSEC_SA_TRANSFORM0* saTransforms;
    IPSEC_PFS_GROUP pfsGroup;
}

struct IPSEC_SA_IDLE_TIMEOUT0
{
    uint idleTimeoutSeconds;
    uint idleTimeoutSecondsFailOver;
}

struct IPSEC_TRAFFIC_SELECTOR0_
{
    ubyte protocolId;
    ushort portStart;
    ushort portEnd;
    FWP_IP_VERSION ipVersion;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
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
    uint numIpsecProposals;
    IPSEC_PROPOSAL0* ipsecProposals;
    uint flags;
    uint ndAllowClearTimeoutSeconds;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY0* emPolicy;
}

struct IPSEC_TRANSPORT_POLICY1
{
    uint numIpsecProposals;
    IPSEC_PROPOSAL0* ipsecProposals;
    uint flags;
    uint ndAllowClearTimeoutSeconds;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY1* emPolicy;
}

struct IPSEC_TRANSPORT_POLICY2
{
    uint numIpsecProposals;
    IPSEC_PROPOSAL0* ipsecProposals;
    uint flags;
    uint ndAllowClearTimeoutSeconds;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY2* emPolicy;
}

struct IPSEC_TUNNEL_ENDPOINTS0
{
    FWP_IP_VERSION ipVersion;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct IPSEC_TUNNEL_ENDPOINT0
{
    FWP_IP_VERSION ipVersion;
    _Anonymous_e__Union Anonymous;
}

struct IPSEC_TUNNEL_ENDPOINTS2
{
    FWP_IP_VERSION ipVersion;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ulong localIfLuid;
    ushort* remoteFqdn;
    uint numAddresses;
    IPSEC_TUNNEL_ENDPOINT0* remoteAddresses;
}

struct IPSEC_TUNNEL_ENDPOINTS1
{
    FWP_IP_VERSION ipVersion;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ulong localIfLuid;
}

struct IPSEC_TUNNEL_POLICY0
{
    uint flags;
    uint numIpsecProposals;
    IPSEC_PROPOSAL0* ipsecProposals;
    IPSEC_TUNNEL_ENDPOINTS0 tunnelEndpoints;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY0* emPolicy;
}

struct IPSEC_TUNNEL_POLICY1
{
    uint flags;
    uint numIpsecProposals;
    IPSEC_PROPOSAL0* ipsecProposals;
    IPSEC_TUNNEL_ENDPOINTS1 tunnelEndpoints;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY1* emPolicy;
}

struct IPSEC_TUNNEL_POLICY2
{
    uint flags;
    uint numIpsecProposals;
    IPSEC_PROPOSAL0* ipsecProposals;
    IPSEC_TUNNEL_ENDPOINTS2 tunnelEndpoints;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY2* emPolicy;
    uint fwdPathSaLifetime;
}

struct IPSEC_TUNNEL_POLICY3_
{
    uint flags;
    uint numIpsecProposals;
    IPSEC_PROPOSAL0* ipsecProposals;
    IPSEC_TUNNEL_ENDPOINTS2 tunnelEndpoints;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY2* emPolicy;
    uint fwdPathSaLifetime;
    uint compartmentId;
    uint numTrafficSelectorPolicy;
    IPSEC_TRAFFIC_SELECTOR_POLICY0_* trafficSelectorPolicies;
}

struct IPSEC_KEYING_POLICY0
{
    uint numKeyMods;
    Guid* keyModKeys;
}

struct IPSEC_KEYING_POLICY1
{
    uint numKeyMods;
    Guid* keyModKeys;
    uint flags;
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
    uint spi;
    IPSEC_TRANSFORM_TYPE saTransformType;
    _Anonymous_e__Union Anonymous;
}

struct IPSEC_KEYMODULE_STATE0
{
    Guid keyModuleKey;
    FWP_BYTE_BLOB stateBlob;
}

enum IPSEC_TOKEN_TYPE
{
    IPSEC_TOKEN_TYPE_MACHINE = 0,
    IPSEC_TOKEN_TYPE_IMPERSONATION = 1,
    IPSEC_TOKEN_TYPE_MAX = 2,
}

enum IPSEC_TOKEN_PRINCIPAL
{
    IPSEC_TOKEN_PRINCIPAL_LOCAL = 0,
    IPSEC_TOKEN_PRINCIPAL_PEER = 1,
    IPSEC_TOKEN_PRINCIPAL_MAX = 2,
}

enum IPSEC_TOKEN_MODE
{
    IPSEC_TOKEN_MODE_MAIN = 0,
    IPSEC_TOKEN_MODE_EXTENDED = 1,
    IPSEC_TOKEN_MODE_MAX = 2,
}

struct IPSEC_TOKEN0
{
    IPSEC_TOKEN_TYPE type;
    IPSEC_TOKEN_PRINCIPAL principal;
    IPSEC_TOKEN_MODE mode;
    ulong token;
}

struct IPSEC_ID0
{
    ushort* mmTargetName;
    ushort* emTargetName;
    uint numTokens;
    IPSEC_TOKEN0* tokens;
    ulong explicitCredentials;
    ulong logonId;
}

struct IPSEC_SA_BUNDLE0
{
    uint flags;
    IPSEC_SA_LIFETIME0 lifetime;
    uint idleTimeoutSeconds;
    uint ndAllowClearTimeoutSeconds;
    IPSEC_ID0* ipsecId;
    uint napContext;
    uint qmSaId;
    uint numSAs;
    IPSEC_SA0* saList;
    IPSEC_KEYMODULE_STATE0* keyModuleState;
    FWP_IP_VERSION ipVersion;
    _Anonymous_e__Union Anonymous;
    ulong mmSaId;
    IPSEC_PFS_GROUP pfsGroup;
}

struct IPSEC_SA_BUNDLE1
{
    uint flags;
    IPSEC_SA_LIFETIME0 lifetime;
    uint idleTimeoutSeconds;
    uint ndAllowClearTimeoutSeconds;
    IPSEC_ID0* ipsecId;
    uint napContext;
    uint qmSaId;
    uint numSAs;
    IPSEC_SA0* saList;
    IPSEC_KEYMODULE_STATE0* keyModuleState;
    FWP_IP_VERSION ipVersion;
    _Anonymous_e__Union Anonymous;
    ulong mmSaId;
    IPSEC_PFS_GROUP pfsGroup;
    Guid saLookupContext;
    ulong qmFilterId;
}

enum IPSEC_TRAFFIC_TYPE
{
    IPSEC_TRAFFIC_TYPE_TRANSPORT = 0,
    IPSEC_TRAFFIC_TYPE_TUNNEL = 1,
    IPSEC_TRAFFIC_TYPE_MAX = 2,
}

struct IPSEC_TRAFFIC0
{
    FWP_IP_VERSION ipVersion;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    IPSEC_TRAFFIC_TYPE trafficType;
    _Anonymous3_e__Union Anonymous3;
    ushort remotePort;
}

struct IPSEC_TRAFFIC1
{
    FWP_IP_VERSION ipVersion;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    IPSEC_TRAFFIC_TYPE trafficType;
    _Anonymous3_e__Union Anonymous3;
    ushort remotePort;
    ushort localPort;
    ubyte ipProtocol;
    ulong localIfLuid;
    uint realIfProfileId;
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
    _Anonymous_e__Union Anonymous;
    Guid* rngCryptoModuleID;
}

struct IPSEC_GETSPI1
{
    IPSEC_TRAFFIC1 inboundIpsecTraffic;
    FWP_IP_VERSION ipVersion;
    _Anonymous_e__Union Anonymous;
    Guid* rngCryptoModuleID;
}

struct IPSEC_SA_DETAILS0
{
    FWP_IP_VERSION ipVersion;
    FWP_DIRECTION saDirection;
    IPSEC_TRAFFIC0 traffic;
    IPSEC_SA_BUNDLE0 saBundle;
    _Anonymous_e__Union Anonymous;
    FWPM_FILTER0* transportFilter;
}

struct IPSEC_SA_DETAILS1
{
    FWP_IP_VERSION ipVersion;
    FWP_DIRECTION saDirection;
    IPSEC_TRAFFIC1 traffic;
    IPSEC_SA_BUNDLE1 saBundle;
    _Anonymous_e__Union Anonymous;
    FWPM_FILTER0* transportFilter;
    IPSEC_VIRTUAL_IF_TUNNEL_INFO0 virtualIfTunnelInfo;
}

struct IPSEC_SA_CONTEXT0
{
    ulong saContextId;
    IPSEC_SA_DETAILS0* inboundSa;
    IPSEC_SA_DETAILS0* outboundSa;
}

struct IPSEC_SA_CONTEXT1
{
    ulong saContextId;
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
    Guid sessionKey;
}

enum IPSEC_SA_CONTEXT_EVENT_TYPE0
{
    IPSEC_SA_CONTEXT_EVENT_ADD = 1,
    IPSEC_SA_CONTEXT_EVENT_DELETE = 2,
    IPSEC_SA_CONTEXT_EVENT_MAX = 3,
}

struct IPSEC_SA_CONTEXT_CHANGE0
{
    IPSEC_SA_CONTEXT_EVENT_TYPE0 changeType;
    ulong saContextId;
}

enum IPSEC_FAILURE_POINT
{
    IPSEC_FAILURE_NONE = 0,
    IPSEC_FAILURE_ME = 1,
    IPSEC_FAILURE_PEER = 2,
    IPSEC_FAILURE_POINT_MAX = 3,
}

struct IPSEC_ADDRESS_INFO0
{
    uint numV4Addresses;
    uint* v4Addresses;
    uint numV6Addresses;
    FWP_BYTE_ARRAY16* v6Addresses;
}

struct IPSEC_DOSP_OPTIONS0
{
    uint stateIdleTimeoutSeconds;
    uint perIPRateLimitQueueIdleTimeoutSeconds;
    ubyte ipV6IPsecUnauthDscp;
    uint ipV6IPsecUnauthRateLimitBytesPerSec;
    uint ipV6IPsecUnauthPerIPRateLimitBytesPerSec;
    ubyte ipV6IPsecAuthDscp;
    uint ipV6IPsecAuthRateLimitBytesPerSec;
    ubyte icmpV6Dscp;
    uint icmpV6RateLimitBytesPerSec;
    ubyte ipV6FilterExemptDscp;
    uint ipV6FilterExemptRateLimitBytesPerSec;
    ubyte defBlockExemptDscp;
    uint defBlockExemptRateLimitBytesPerSec;
    uint maxStateEntries;
    uint maxPerIPRateLimitQueues;
    uint flags;
    uint numPublicIFLuids;
    ulong* publicIFLuids;
    uint numInternalIFLuids;
    ulong* internalIFLuids;
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
    ubyte publicHostV6Addr;
    ubyte internalHostV6Addr;
    ulong totalInboundIPv6IPsecAuthPackets;
    ulong totalOutboundIPv6IPsecAuthPackets;
    uint durationSecs;
}

struct IPSEC_DOSP_STATE_ENUM_TEMPLATE0
{
    FWP_V6_ADDR_AND_MASK publicV6AddrMask;
    FWP_V6_ADDR_AND_MASK internalV6AddrMask;
}

struct IPSEC_KEY_MANAGER0
{
    Guid keyManagerKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    ubyte keyDictationTimeoutHint;
}

enum DL_ADDRESS_TYPE
{
    DlUnicast = 0,
    DlMulticast = 1,
    DlBroadcast = 2,
}

enum FWPM_CHANGE_TYPE
{
    FWPM_CHANGE_ADD = 1,
    FWPM_CHANGE_DELETE = 2,
    FWPM_CHANGE_TYPE_MAX = 3,
}

enum FWPM_SERVICE_STATE
{
    FWPM_SERVICE_STOPPED = 0,
    FWPM_SERVICE_START_PENDING = 1,
    FWPM_SERVICE_STOP_PENDING = 2,
    FWPM_SERVICE_RUNNING = 3,
    FWPM_SERVICE_STATE_MAX = 4,
}

enum FWPM_ENGINE_OPTION
{
    FWPM_ENGINE_COLLECT_NET_EVENTS = 0,
    FWPM_ENGINE_NET_EVENT_MATCH_ANY_KEYWORDS = 1,
    FWPM_ENGINE_NAME_CACHE = 2,
    FWPM_ENGINE_MONITOR_IPSEC_CONNECTIONS = 3,
    FWPM_ENGINE_PACKET_QUEUING = 4,
    FWPM_ENGINE_TXN_WATCHDOG_TIMEOUT_IN_MSEC = 5,
    FWPM_ENGINE_OPTION_MAX = 6,
}

struct FWPM_SESSION0
{
    Guid sessionKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    uint txnWaitTimeoutInMSec;
    uint processId;
    SID* sid;
    ushort* username;
    BOOL kernelMode;
}

struct FWPM_SESSION_ENUM_TEMPLATE0
{
    ulong reserved;
}

struct FWPM_PROVIDER0
{
    Guid providerKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    FWP_BYTE_BLOB providerData;
    ushort* serviceName;
}

struct FWPM_PROVIDER_ENUM_TEMPLATE0
{
    ulong reserved;
}

struct FWPM_PROVIDER_CHANGE0
{
    FWPM_CHANGE_TYPE changeType;
    Guid providerKey;
}

struct FWPM_PROVIDER_SUBSCRIPTION0
{
    FWPM_PROVIDER_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    Guid sessionKey;
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

enum FWPM_PROVIDER_CONTEXT_TYPE
{
    FWPM_IPSEC_KEYING_CONTEXT = 0,
    FWPM_IPSEC_IKE_QM_TRANSPORT_CONTEXT = 1,
    FWPM_IPSEC_IKE_QM_TUNNEL_CONTEXT = 2,
    FWPM_IPSEC_AUTHIP_QM_TRANSPORT_CONTEXT = 3,
    FWPM_IPSEC_AUTHIP_QM_TUNNEL_CONTEXT = 4,
    FWPM_IPSEC_IKE_MM_CONTEXT = 5,
    FWPM_IPSEC_AUTHIP_MM_CONTEXT = 6,
    FWPM_CLASSIFY_OPTIONS_CONTEXT = 7,
    FWPM_GENERAL_CONTEXT = 8,
    FWPM_IPSEC_IKEV2_QM_TUNNEL_CONTEXT = 9,
    FWPM_IPSEC_IKEV2_MM_CONTEXT = 10,
    FWPM_IPSEC_DOSP_CONTEXT = 11,
    FWPM_IPSEC_IKEV2_QM_TRANSPORT_CONTEXT = 12,
    FWPM_PROVIDER_CONTEXT_TYPE_MAX = 13,
}

struct FWPM_PROVIDER_CONTEXT0
{
    Guid providerContextKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    Guid* providerKey;
    FWP_BYTE_BLOB providerData;
    FWPM_PROVIDER_CONTEXT_TYPE type;
    _Anonymous_e__Union Anonymous;
    ulong providerContextId;
}

struct FWPM_PROVIDER_CONTEXT1
{
    Guid providerContextKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    Guid* providerKey;
    FWP_BYTE_BLOB providerData;
    FWPM_PROVIDER_CONTEXT_TYPE type;
    _Anonymous_e__Union Anonymous;
    ulong providerContextId;
}

struct FWPM_PROVIDER_CONTEXT2
{
    Guid providerContextKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    Guid* providerKey;
    FWP_BYTE_BLOB providerData;
    FWPM_PROVIDER_CONTEXT_TYPE type;
    _Anonymous_e__Union Anonymous;
    ulong providerContextId;
}

struct FWPM_PROVIDER_CONTEXT3_
{
    Guid providerContextKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    Guid* providerKey;
    FWP_BYTE_BLOB providerData;
    FWPM_PROVIDER_CONTEXT_TYPE type;
    _Anonymous_e__Union Anonymous;
    ulong providerContextId;
}

struct FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0
{
    Guid* providerKey;
    FWPM_PROVIDER_CONTEXT_TYPE providerContextType;
}

struct FWPM_PROVIDER_CONTEXT_CHANGE0
{
    FWPM_CHANGE_TYPE changeType;
    Guid providerContextKey;
    ulong providerContextId;
}

struct FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0
{
    FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    Guid sessionKey;
}

struct FWPM_SUBLAYER0
{
    Guid subLayerKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    Guid* providerKey;
    FWP_BYTE_BLOB providerData;
    ushort weight;
}

struct FWPM_SUBLAYER_ENUM_TEMPLATE0
{
    Guid* providerKey;
}

struct FWPM_SUBLAYER_CHANGE0
{
    FWPM_CHANGE_TYPE changeType;
    Guid subLayerKey;
}

struct FWPM_SUBLAYER_SUBSCRIPTION0
{
    FWPM_SUBLAYER_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    Guid sessionKey;
}

enum FWPM_FIELD_TYPE
{
    FWPM_FIELD_RAW_DATA = 0,
    FWPM_FIELD_IP_ADDRESS = 1,
    FWPM_FIELD_FLAGS = 2,
    FWPM_FIELD_TYPE_MAX = 3,
}

struct FWPM_FIELD0
{
    Guid* fieldKey;
    FWPM_FIELD_TYPE type;
    FWP_DATA_TYPE dataType;
}

struct FWPM_LAYER0
{
    Guid layerKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    uint numFields;
    FWPM_FIELD0* field;
    Guid defaultSubLayerKey;
    ushort layerId;
}

struct FWPM_LAYER_ENUM_TEMPLATE0
{
    ulong reserved;
}

struct FWPM_CALLOUT0
{
    Guid calloutKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    Guid* providerKey;
    FWP_BYTE_BLOB providerData;
    Guid applicableLayer;
    uint calloutId;
}

struct FWPM_CALLOUT_ENUM_TEMPLATE0
{
    Guid* providerKey;
    Guid layerKey;
}

struct FWPM_CALLOUT_CHANGE0
{
    FWPM_CHANGE_TYPE changeType;
    Guid calloutKey;
    uint calloutId;
}

struct FWPM_CALLOUT_SUBSCRIPTION0
{
    FWPM_CALLOUT_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    Guid sessionKey;
}

struct FWPM_ACTION0
{
    uint type;
    _Anonymous_e__Union Anonymous;
}

struct FWPM_FILTER_CONDITION0
{
    Guid fieldKey;
    FWP_MATCH_TYPE matchType;
    FWP_CONDITION_VALUE0 conditionValue;
}

struct FWPM_FILTER0
{
    Guid filterKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint flags;
    Guid* providerKey;
    FWP_BYTE_BLOB providerData;
    Guid layerKey;
    Guid subLayerKey;
    FWP_VALUE0 weight;
    uint numFilterConditions;
    FWPM_FILTER_CONDITION0* filterCondition;
    FWPM_ACTION0 action;
    _Anonymous_e__Union Anonymous;
    Guid* reserved;
    ulong filterId;
    FWP_VALUE0 effectiveWeight;
}

struct FWPM_FILTER_ENUM_TEMPLATE0
{
    Guid* providerKey;
    Guid layerKey;
    FWP_FILTER_ENUM_TYPE enumType;
    uint flags;
    FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0* providerContextTemplate;
    uint numFilterConditions;
    FWPM_FILTER_CONDITION0* filterCondition;
    uint actionMask;
    Guid* calloutKey;
}

struct FWPM_FILTER_CHANGE0
{
    FWPM_CHANGE_TYPE changeType;
    Guid filterKey;
    ulong filterId;
}

struct FWPM_FILTER_SUBSCRIPTION0
{
    FWPM_FILTER_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    Guid sessionKey;
}

struct FWPM_LAYER_STATISTICS0
{
    Guid layerId;
    uint classifyPermitCount;
    uint classifyBlockCount;
    uint classifyVetoCount;
    uint numCacheEntries;
}

struct FWPM_STATISTICS0
{
    uint numLayerStatistics;
    FWPM_LAYER_STATISTICS0* layerStatistics;
    uint inboundAllowedConnectionsV4;
    uint inboundBlockedConnectionsV4;
    uint outboundAllowedConnectionsV4;
    uint outboundBlockedConnectionsV4;
    uint inboundAllowedConnectionsV6;
    uint inboundBlockedConnectionsV6;
    uint outboundAllowedConnectionsV6;
    uint outboundBlockedConnectionsV6;
    uint inboundActiveConnectionsV4;
    uint outboundActiveConnectionsV4;
    uint inboundActiveConnectionsV6;
    uint outboundActiveConnectionsV6;
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
    FILETIME timeStamp;
    uint flags;
    FWP_IP_VERSION ipVersion;
    ubyte ipProtocol;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ushort localPort;
    ushort remotePort;
    uint scopeId;
    FWP_BYTE_BLOB appId;
    SID* userId;
}

struct FWPM_NET_EVENT_HEADER1
{
    FILETIME timeStamp;
    uint flags;
    FWP_IP_VERSION ipVersion;
    ubyte ipProtocol;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ushort localPort;
    ushort remotePort;
    uint scopeId;
    FWP_BYTE_BLOB appId;
    SID* userId;
    _Anonymous3_e__Union Anonymous3;
}

struct FWPM_NET_EVENT_HEADER2
{
    FILETIME timeStamp;
    uint flags;
    FWP_IP_VERSION ipVersion;
    ubyte ipProtocol;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ushort localPort;
    ushort remotePort;
    uint scopeId;
    FWP_BYTE_BLOB appId;
    SID* userId;
    FWP_AF addressFamily;
    SID* packageSid;
}

struct FWPM_NET_EVENT_HEADER3
{
    FILETIME timeStamp;
    uint flags;
    FWP_IP_VERSION ipVersion;
    ubyte ipProtocol;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ushort localPort;
    ushort remotePort;
    uint scopeId;
    FWP_BYTE_BLOB appId;
    SID* userId;
    FWP_AF addressFamily;
    SID* packageSid;
    ushort* enterpriseId;
    ulong policyFlags;
    FWP_BYTE_BLOB effectiveName;
}

enum FWPM_NET_EVENT_TYPE
{
    FWPM_NET_EVENT_TYPE_IKEEXT_MM_FAILURE = 0,
    FWPM_NET_EVENT_TYPE_IKEEXT_QM_FAILURE = 1,
    FWPM_NET_EVENT_TYPE_IKEEXT_EM_FAILURE = 2,
    FWPM_NET_EVENT_TYPE_CLASSIFY_DROP = 3,
    FWPM_NET_EVENT_TYPE_IPSEC_KERNEL_DROP = 4,
    FWPM_NET_EVENT_TYPE_IPSEC_DOSP_DROP = 5,
    FWPM_NET_EVENT_TYPE_CLASSIFY_ALLOW = 6,
    FWPM_NET_EVENT_TYPE_CAPABILITY_DROP = 7,
    FWPM_NET_EVENT_TYPE_CAPABILITY_ALLOW = 8,
    FWPM_NET_EVENT_TYPE_CLASSIFY_DROP_MAC = 9,
    FWPM_NET_EVENT_TYPE_LPM_PACKET_ARRIVAL = 10,
    FWPM_NET_EVENT_TYPE_MAX = 11,
}

struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE0
{
    uint failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint flags;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_MM_SA_STATE mmState;
    IKEEXT_SA_ROLE saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE mmAuthMethod;
    ubyte endCertHash;
    ulong mmId;
    ulong mmFilterId;
}

struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE1
{
    uint failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint flags;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_MM_SA_STATE mmState;
    IKEEXT_SA_ROLE saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE mmAuthMethod;
    ubyte endCertHash;
    ulong mmId;
    ulong mmFilterId;
    ushort* localPrincipalNameForAuth;
    ushort* remotePrincipalNameForAuth;
    uint numLocalPrincipalGroupSids;
    ushort** localPrincipalGroupSids;
    uint numRemotePrincipalGroupSids;
    ushort** remotePrincipalGroupSids;
}

struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE2_
{
    uint failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint flags;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_MM_SA_STATE mmState;
    IKEEXT_SA_ROLE saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE mmAuthMethod;
    ubyte endCertHash;
    ulong mmId;
    ulong mmFilterId;
    ushort* localPrincipalNameForAuth;
    ushort* remotePrincipalNameForAuth;
    uint numLocalPrincipalGroupSids;
    ushort** localPrincipalGroupSids;
    uint numRemotePrincipalGroupSids;
    ushort** remotePrincipalGroupSids;
    Guid* providerContextKey;
}

struct FWPM_NET_EVENT_IKEEXT_QM_FAILURE0
{
    uint failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_QM_SA_STATE qmState;
    IKEEXT_SA_ROLE saRole;
    IPSEC_TRAFFIC_TYPE saTrafficType;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ulong qmFilterId;
}

struct FWPM_NET_EVENT_IKEEXT_QM_FAILURE1_
{
    uint failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_QM_SA_STATE qmState;
    IKEEXT_SA_ROLE saRole;
    IPSEC_TRAFFIC_TYPE saTrafficType;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ulong qmFilterId;
    ulong mmSaLuid;
    Guid mmProviderContextKey;
}

struct FWPM_NET_EVENT_IKEEXT_EM_FAILURE0
{
    uint failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint flags;
    IKEEXT_EM_SA_STATE emState;
    IKEEXT_SA_ROLE saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE emAuthMethod;
    ubyte endCertHash;
    ulong mmId;
    ulong qmFilterId;
}

struct FWPM_NET_EVENT_IKEEXT_EM_FAILURE1
{
    uint failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint flags;
    IKEEXT_EM_SA_STATE emState;
    IKEEXT_SA_ROLE saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE emAuthMethod;
    ubyte endCertHash;
    ulong mmId;
    ulong qmFilterId;
    ushort* localPrincipalNameForAuth;
    ushort* remotePrincipalNameForAuth;
    uint numLocalPrincipalGroupSids;
    ushort** localPrincipalGroupSids;
    uint numRemotePrincipalGroupSids;
    ushort** remotePrincipalGroupSids;
    IPSEC_TRAFFIC_TYPE saTrafficType;
}

struct FWPM_NET_EVENT_CLASSIFY_DROP0
{
    ulong filterId;
    ushort layerId;
}

struct FWPM_NET_EVENT_CLASSIFY_DROP1
{
    ulong filterId;
    ushort layerId;
    uint reauthReason;
    uint originalProfile;
    uint currentProfile;
    uint msFwpDirection;
    BOOL isLoopback;
}

struct FWPM_NET_EVENT_CLASSIFY_DROP2
{
    ulong filterId;
    ushort layerId;
    uint reauthReason;
    uint originalProfile;
    uint currentProfile;
    uint msFwpDirection;
    BOOL isLoopback;
    FWP_BYTE_BLOB vSwitchId;
    uint vSwitchSourcePort;
    uint vSwitchDestinationPort;
}

struct FWPM_NET_EVENT_CLASSIFY_DROP_MAC0
{
    FWP_BYTE_ARRAY6 localMacAddr;
    FWP_BYTE_ARRAY6 remoteMacAddr;
    uint mediaType;
    uint ifType;
    ushort etherType;
    uint ndisPortNumber;
    uint reserved;
    ushort vlanTag;
    ulong ifLuid;
    ulong filterId;
    ushort layerId;
    uint reauthReason;
    uint originalProfile;
    uint currentProfile;
    uint msFwpDirection;
    BOOL isLoopback;
    FWP_BYTE_BLOB vSwitchId;
    uint vSwitchSourcePort;
    uint vSwitchDestinationPort;
}

struct FWPM_NET_EVENT_CLASSIFY_ALLOW0
{
    ulong filterId;
    ushort layerId;
    uint reauthReason;
    uint originalProfile;
    uint currentProfile;
    uint msFwpDirection;
    BOOL isLoopback;
}

struct FWPM_NET_EVENT_IPSEC_KERNEL_DROP0
{
    int failureStatus;
    FWP_DIRECTION direction;
    uint spi;
    ulong filterId;
    ushort layerId;
}

struct FWPM_NET_EVENT_IPSEC_DOSP_DROP0
{
    FWP_IP_VERSION ipVersion;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    int failureStatus;
    FWP_DIRECTION direction;
}

enum FWPM_APPC_NETWORK_CAPABILITY_TYPE
{
    FWPM_APPC_NETWORK_CAPABILITY_INTERNET_CLIENT = 0,
    FWPM_APPC_NETWORK_CAPABILITY_INTERNET_CLIENT_SERVER = 1,
    FWPM_APPC_NETWORK_CAPABILITY_INTERNET_PRIVATE_NETWORK = 2,
}

struct FWPM_NET_EVENT_CAPABILITY_DROP0
{
    FWPM_APPC_NETWORK_CAPABILITY_TYPE networkCapabilityId;
    ulong filterId;
    BOOL isLoopback;
}

struct FWPM_NET_EVENT_CAPABILITY_ALLOW0
{
    FWPM_APPC_NETWORK_CAPABILITY_TYPE networkCapabilityId;
    ulong filterId;
    BOOL isLoopback;
}

struct FWPM_NET_EVENT_LPM_PACKET_ARRIVAL0_
{
    uint spi;
}

struct FWPM_NET_EVENT0
{
    FWPM_NET_EVENT_HEADER0 header;
    FWPM_NET_EVENT_TYPE type;
    _Anonymous_e__Union Anonymous;
}

struct FWPM_NET_EVENT1
{
    FWPM_NET_EVENT_HEADER1 header;
    FWPM_NET_EVENT_TYPE type;
    _Anonymous_e__Union Anonymous;
}

struct FWPM_NET_EVENT2
{
    FWPM_NET_EVENT_HEADER2 header;
    FWPM_NET_EVENT_TYPE type;
    _Anonymous_e__Union Anonymous;
}

struct FWPM_NET_EVENT3
{
    FWPM_NET_EVENT_HEADER3 header;
    FWPM_NET_EVENT_TYPE type;
    _Anonymous_e__Union Anonymous;
}

struct FWPM_NET_EVENT4_
{
    FWPM_NET_EVENT_HEADER3 header;
    FWPM_NET_EVENT_TYPE type;
    _Anonymous_e__Union Anonymous;
}

struct FWPM_NET_EVENT5_
{
    FWPM_NET_EVENT_HEADER3 header;
    FWPM_NET_EVENT_TYPE type;
    _Anonymous_e__Union Anonymous;
}

struct FWPM_NET_EVENT_ENUM_TEMPLATE0
{
    FILETIME startTime;
    FILETIME endTime;
    uint numFilterConditions;
    FWPM_FILTER_CONDITION0* filterCondition;
}

struct FWPM_NET_EVENT_SUBSCRIPTION0
{
    FWPM_NET_EVENT_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    Guid sessionKey;
}

enum FWPM_SYSTEM_PORT_TYPE
{
    FWPM_SYSTEM_PORT_RPC_EPMAP = 0,
    FWPM_SYSTEM_PORT_TEREDO = 1,
    FWPM_SYSTEM_PORT_IPHTTPS_IN = 2,
    FWPM_SYSTEM_PORT_IPHTTPS_OUT = 3,
    FWPM_SYSTEM_PORT_TYPE_MAX = 4,
}

struct FWPM_SYSTEM_PORTS_BY_TYPE0
{
    FWPM_SYSTEM_PORT_TYPE type;
    uint numPorts;
    ushort* ports;
}

struct FWPM_SYSTEM_PORTS0
{
    uint numTypes;
    FWPM_SYSTEM_PORTS_BY_TYPE0* types;
}

struct FWPM_CONNECTION0
{
    ulong connectionId;
    FWP_IP_VERSION ipVersion;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    Guid* providerKey;
    IPSEC_TRAFFIC_TYPE ipsecTrafficModeType;
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    IKEEXT_PROPOSAL0 mmCrypto;
    IKEEXT_CREDENTIAL2 mmPeer;
    IKEEXT_CREDENTIAL2 emPeer;
    ulong bytesTransferredIn;
    ulong bytesTransferredOut;
    ulong bytesTransferredTotal;
    FILETIME startSysTime;
}

struct FWPM_CONNECTION_ENUM_TEMPLATE0
{
    ulong connectionId;
    uint flags;
}

struct FWPM_CONNECTION_SUBSCRIPTION0
{
    FWPM_CONNECTION_ENUM_TEMPLATE0* enumTemplate;
    uint flags;
    Guid sessionKey;
}

enum FWPM_CONNECTION_EVENT_TYPE
{
    FWPM_CONNECTION_EVENT_ADD = 0,
    FWPM_CONNECTION_EVENT_DELETE = 1,
    FWPM_CONNECTION_EVENT_MAX = 2,
}

enum FWPM_VSWITCH_EVENT_TYPE
{
    FWPM_VSWITCH_EVENT_FILTER_ADD_TO_INCOMPLETE_LAYER = 0,
    FWPM_VSWITCH_EVENT_FILTER_ENGINE_NOT_IN_REQUIRED_POSITION = 1,
    FWPM_VSWITCH_EVENT_ENABLED_FOR_INSPECTION = 2,
    FWPM_VSWITCH_EVENT_DISABLED_FOR_INSPECTION = 3,
    FWPM_VSWITCH_EVENT_FILTER_ENGINE_REORDER = 4,
    FWPM_VSWITCH_EVENT_MAX = 5,
}

struct FWPM_VSWITCH_EVENT0
{
    FWPM_VSWITCH_EVENT_TYPE eventType;
    ushort* vSwitchId;
    _Anonymous_e__Union Anonymous;
}

struct FWPM_VSWITCH_EVENT_SUBSCRIPTION0
{
    uint flags;
    Guid sessionKey;
}

alias FWPM_PROVIDER_CHANGE_CALLBACK0 = extern(Windows) void function(void* context, const(FWPM_PROVIDER_CHANGE0)* change);
alias FWPM_PROVIDER_CONTEXT_CHANGE_CALLBACK0 = extern(Windows) void function(void* context, const(FWPM_PROVIDER_CONTEXT_CHANGE0)* change);
alias FWPM_SUBLAYER_CHANGE_CALLBACK0 = extern(Windows) void function(void* context, const(FWPM_SUBLAYER_CHANGE0)* change);
alias FWPM_CALLOUT_CHANGE_CALLBACK0 = extern(Windows) void function(void* context, const(FWPM_CALLOUT_CHANGE0)* change);
alias FWPM_FILTER_CHANGE_CALLBACK0 = extern(Windows) void function(void* context, const(FWPM_FILTER_CHANGE0)* change);
alias IPSEC_SA_CONTEXT_CALLBACK0 = extern(Windows) void function(void* context, const(IPSEC_SA_CONTEXT_CHANGE0)* change);
alias IPSEC_KEY_MANAGER_KEY_DICTATION_CHECK0 = extern(Windows) void function(const(IKEEXT_TRAFFIC0)* ikeTraffic, int* willDictateKey, uint* weight);
alias IPSEC_KEY_MANAGER_DICTATE_KEY0 = extern(Windows) uint function(IPSEC_SA_DETAILS1* inboundSaDetails, IPSEC_SA_DETAILS1* outboundSaDetails, int* keyingModuleGenKey);
alias IPSEC_KEY_MANAGER_NOTIFY_KEY0 = extern(Windows) void function(const(IPSEC_SA_DETAILS1)* inboundSa, const(IPSEC_SA_DETAILS1)* outboundSa);
struct IPSEC_KEY_MANAGER_CALLBACKS0
{
    Guid reserved;
    uint flags;
    IPSEC_KEY_MANAGER_KEY_DICTATION_CHECK0 keyDictationCheck;
    IPSEC_KEY_MANAGER_DICTATE_KEY0 keyDictation;
    IPSEC_KEY_MANAGER_NOTIFY_KEY0 keyNotify;
}

alias FWPM_NET_EVENT_CALLBACK0 = extern(Windows) void function(void* context, const(FWPM_NET_EVENT1)* event);
alias FWPM_NET_EVENT_CALLBACK1 = extern(Windows) void function(void* context, const(FWPM_NET_EVENT2)* event);
alias FWPM_NET_EVENT_CALLBACK2 = extern(Windows) void function(void* context, const(FWPM_NET_EVENT3)* event);
alias FWPM_NET_EVENT_CALLBACK3 = extern(Windows) void function(void* context, const(FWPM_NET_EVENT4_)* event);
alias FWPM_NET_EVENT_CALLBACK4 = extern(Windows) void function(void* context, const(FWPM_NET_EVENT5_)* event);
alias FWPM_SYSTEM_PORTS_CALLBACK0 = extern(Windows) void function(void* context, const(FWPM_SYSTEM_PORTS0)* sysPorts);
alias FWPM_CONNECTION_CALLBACK0 = extern(Windows) void function(void* context, FWPM_CONNECTION_EVENT_TYPE eventType, const(FWPM_CONNECTION0)* connection);
alias FWPM_VSWITCH_EVENT_CALLBACK0 = extern(Windows) uint function(void* context, const(FWPM_VSWITCH_EVENT0)* vSwitchEvent);
struct DL_OUI
{
    ubyte Byte;
    _Anonymous_e__Struct Anonymous;
}

struct DL_EI48
{
    ubyte Byte;
}

struct DL_EUI48
{
    ubyte Byte;
    _Anonymous_e__Struct Anonymous;
}

struct DL_EI64
{
    ubyte Byte;
}

struct DL_EUI64
{
    ubyte Byte;
    ulong Value;
    _Anonymous_e__Struct Anonymous;
}

struct SNAP_HEADER
{
    ubyte Dsap;
    ubyte Ssap;
    ubyte Control;
    ubyte Oui;
    ushort Type;
}

struct ETHERNET_HEADER
{
    DL_EUI48 Destination;
    DL_EUI48 Source;
    _Anonymous_e__Union Anonymous;
}

struct VLAN_TAG
{
    _Anonymous_e__Union Anonymous;
    ushort Type;
}

struct ICMP_HEADER
{
    ubyte Type;
    ubyte Code;
    ushort Checksum;
}

struct ICMP_MESSAGE
{
    ICMP_HEADER Header;
    _Data_e__Union Data;
}

struct IPV4_HEADER
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ushort TotalLength;
    ushort Identification;
    _Anonymous3_e__Union Anonymous3;
    ubyte TimeToLive;
    ubyte Protocol;
    ushort HeaderChecksum;
    in_addr SourceAddress;
    in_addr DestinationAddress;
}

struct IPV4_OPTION_HEADER
{
    _Anonymous_e__Union Anonymous;
    ubyte OptionLength;
}

enum IPV4_OPTION_TYPE
{
    IP_OPT_EOL = 0,
    IP_OPT_NOP = 1,
    IP_OPT_SECURITY = 130,
    IP_OPT_LSRR = 131,
    IP_OPT_TS = 68,
    IP_OPT_RR = 7,
    IP_OPT_SSRR = 137,
    IP_OPT_SID = 136,
    IP_OPT_ROUTER_ALERT = 148,
    IP_OPT_MULTIDEST = 149,
}

struct IPV4_TIMESTAMP_OPTION
{
    IPV4_OPTION_HEADER OptionHeader;
    ubyte Pointer;
    _Anonymous_e__Union Anonymous;
}

enum IP_OPTION_TIMESTAMP_FLAGS
{
    IP_OPTION_TIMESTAMP_ONLY = 0,
    IP_OPTION_TIMESTAMP_ADDRESS = 1,
    IP_OPTION_TIMESTAMP_SPECIFIC_ADDRESS = 3,
}

struct IPV4_ROUTING_HEADER
{
    IPV4_OPTION_HEADER OptionHeader;
    ubyte Pointer;
}

enum ICMP4_UNREACH_CODE
{
    ICMP4_UNREACH_NET = 0,
    ICMP4_UNREACH_HOST = 1,
    ICMP4_UNREACH_PROTOCOL = 2,
    ICMP4_UNREACH_PORT = 3,
    ICMP4_UNREACH_FRAG_NEEDED = 4,
    ICMP4_UNREACH_SOURCEROUTE_FAILED = 5,
    ICMP4_UNREACH_NET_UNKNOWN = 6,
    ICMP4_UNREACH_HOST_UNKNOWN = 7,
    ICMP4_UNREACH_ISOLATED = 8,
    ICMP4_UNREACH_NET_ADMIN = 9,
    ICMP4_UNREACH_HOST_ADMIN = 10,
    ICMP4_UNREACH_NET_TOS = 11,
    ICMP4_UNREACH_HOST_TOS = 12,
    ICMP4_UNREACH_ADMIN = 13,
}

enum ICMP4_TIME_EXCEED_CODE
{
    ICMP4_TIME_EXCEED_TRANSIT = 0,
    ICMP4_TIME_EXCEED_REASSEMBLY = 1,
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
    int PreferenceLevel;
}

struct ICMPV4_TIMESTAMP_MESSAGE
{
    ICMP_MESSAGE Header;
    uint OriginateTimestamp;
    uint ReceiveTimestamp;
    uint TransmitTimestamp;
}

struct ICMPV4_ADDRESS_MASK_MESSAGE
{
    ICMP_MESSAGE Header;
    uint AddressMask;
}

struct ARP_HEADER
{
    ushort HardwareAddressSpace;
    ushort ProtocolAddressSpace;
    ubyte HardwareAddressLength;
    ubyte ProtocolAddressLength;
    ushort Opcode;
    ubyte SenderHardwareAddress;
}

enum ARP_OPCODE
{
    ARP_REQUEST = 1,
    ARP_RESPONSE = 2,
}

enum ARP_HARDWARE_TYPE
{
    ARP_HW_ENET = 1,
    ARP_HW_802 = 6,
}

struct IGMP_HEADER
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ushort Checksum;
    in_addr MulticastAddress;
}

enum IGMP_MAX_RESP_CODE_TYPE
{
    IGMP_MAX_RESP_CODE_TYPE_NORMAL = 0,
    IGMP_MAX_RESP_CODE_TYPE_FLOAT = 1,
}

struct IGMPV3_QUERY_HEADER
{
    ubyte Type;
    _Anonymous1_e__Union Anonymous1;
    ushort Checksum;
    in_addr MulticastAddress;
    ubyte _bitfield;
    _Anonymous2_e__Union Anonymous2;
    ushort SourceCount;
}

struct IGMPV3_REPORT_RECORD_HEADER
{
    ubyte Type;
    ubyte AuxillaryDataLength;
    ushort SourceCount;
    in_addr MulticastAddress;
}

struct IGMPV3_REPORT_HEADER
{
    ubyte Type;
    ubyte Reserved;
    ushort Checksum;
    ushort Reserved2;
    ushort RecordCount;
}

struct IPV6_HEADER
{
    _Anonymous_e__Union Anonymous;
    ushort PayloadLength;
    ubyte NextHeader;
    ubyte HopLimit;
    in6_addr SourceAddress;
    in6_addr DestinationAddress;
}

struct IPV6_FRAGMENT_HEADER
{
    ubyte NextHeader;
    ubyte Reserved;
    _Anonymous_e__Union Anonymous;
    uint Id;
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

enum IPV6_OPTION_TYPE
{
    IP6OPT_PAD1 = 0,
    IP6OPT_PADN = 1,
    IP6OPT_TUNNEL_LIMIT = 4,
    IP6OPT_ROUTER_ALERT = 5,
    IP6OPT_JUMBO = 194,
    IP6OPT_NSAP_ADDR = 195,
}

struct IPV6_OPTION_JUMBOGRAM
{
    IPV6_OPTION_HEADER Header;
    ubyte JumbogramLength;
}

struct IPV6_OPTION_ROUTER_ALERT
{
    IPV6_OPTION_HEADER Header;
    ubyte Value;
}

struct IPV6_ROUTING_HEADER
{
    ubyte NextHeader;
    ubyte Length;
    ubyte RoutingType;
    ubyte SegmentsLeft;
    ubyte Reserved;
}

struct nd_router_solicit
{
    ICMP_MESSAGE nd_rs_hdr;
}

struct nd_router_advert
{
    ICMP_MESSAGE nd_ra_hdr;
    uint nd_ra_reachable;
    uint nd_ra_retransmit;
}

struct IPV6_ROUTER_ADVERTISEMENT_FLAGS
{
    _Anonymous_e__Struct Anonymous;
    ubyte Value;
}

struct nd_neighbor_solicit
{
    ICMP_MESSAGE nd_ns_hdr;
    in6_addr nd_ns_target;
}

struct nd_neighbor_advert
{
    ICMP_MESSAGE nd_na_hdr;
    in6_addr nd_na_target;
}

struct IPV6_NEIGHBOR_ADVERTISEMENT_FLAGS
{
    _Anonymous_e__Struct Anonymous;
    uint Value;
}

struct nd_redirect
{
    ICMP_MESSAGE nd_rd_hdr;
    in6_addr nd_rd_target;
    in6_addr nd_rd_dst;
}

struct nd_opt_hdr
{
    ubyte nd_opt_type;
    ubyte nd_opt_len;
}

enum ND_OPTION_TYPE
{
    ND_OPT_SOURCE_LINKADDR = 1,
    ND_OPT_TARGET_LINKADDR = 2,
    ND_OPT_PREFIX_INFORMATION = 3,
    ND_OPT_REDIRECTED_HEADER = 4,
    ND_OPT_MTU = 5,
    ND_OPT_NBMA_SHORTCUT_LIMIT = 6,
    ND_OPT_ADVERTISEMENT_INTERVAL = 7,
    ND_OPT_HOME_AGENT_INFORMATION = 8,
    ND_OPT_SOURCE_ADDR_LIST = 9,
    ND_OPT_TARGET_ADDR_LIST = 10,
    ND_OPT_ROUTE_INFO = 24,
    ND_OPT_RDNSS = 25,
    ND_OPT_DNSSL = 31,
}

struct nd_opt_prefix_info
{
    ubyte nd_opt_pi_type;
    ubyte nd_opt_pi_len;
    ubyte nd_opt_pi_prefix_len;
    _Anonymous1_e__Union Anonymous1;
    uint nd_opt_pi_valid_time;
    uint nd_opt_pi_preferred_time;
    _Anonymous2_e__Union Anonymous2;
    in6_addr nd_opt_pi_prefix;
}

struct nd_opt_rd_hdr
{
    ubyte nd_opt_rh_type;
    ubyte nd_opt_rh_len;
    ushort nd_opt_rh_reserved1;
    uint nd_opt_rh_reserved2;
}

struct nd_opt_mtu
{
    ubyte nd_opt_mtu_type;
    ubyte nd_opt_mtu_len;
    ushort nd_opt_mtu_reserved;
    uint nd_opt_mtu_mtu;
}

struct nd_opt_route_info
{
    ubyte nd_opt_ri_type;
    ubyte nd_opt_ri_len;
    ubyte nd_opt_ri_prefix_len;
    _Anonymous_e__Union Anonymous;
    uint nd_opt_ri_route_lifetime;
    in6_addr nd_opt_ri_prefix;
}

struct nd_opt_rdnss
{
    ubyte nd_opt_rdnss_type;
    ubyte nd_opt_rdnss_len;
    ushort nd_opt_rdnss_reserved;
    uint nd_opt_rdnss_lifetime;
}

struct nd_opt_dnssl
{
    ubyte nd_opt_dnssl_type;
    ubyte nd_opt_dnssl_len;
    ushort nd_opt_dnssl_reserved;
    uint nd_opt_dnssl_lifetime;
}

struct MLD_HEADER
{
    ICMP_HEADER IcmpHeader;
    ushort MaxRespTime;
    ushort Reserved;
    in6_addr MulticastAddress;
}

enum MLD_MAX_RESP_CODE_TYPE
{
    MLD_MAX_RESP_CODE_TYPE_NORMAL = 0,
    MLD_MAX_RESP_CODE_TYPE_FLOAT = 1,
}

struct MLDV2_QUERY_HEADER
{
    ICMP_HEADER IcmpHeader;
    _Anonymous1_e__Union Anonymous1;
    ushort Reserved;
    in6_addr MulticastAddress;
    ubyte _bitfield;
    _Anonymous2_e__Union Anonymous2;
    ushort SourceCount;
}

struct MLDV2_REPORT_RECORD_HEADER
{
    ubyte Type;
    ubyte AuxillaryDataLength;
    ushort SourceCount;
    in6_addr MulticastAddress;
}

struct MLDV2_REPORT_HEADER
{
    ICMP_HEADER IcmpHeader;
    ushort Reserved;
    ushort RecordCount;
}

struct tcp_hdr
{
    ushort th_sport;
    ushort th_dport;
    uint th_seq;
    uint th_ack;
    ubyte _bitfield;
    ubyte th_flags;
    ushort th_win;
    ushort th_sum;
    ushort th_urp;
}

struct tcp_opt_mss
{
    ubyte Kind;
    ubyte Length;
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
    tcp_opt_sack_block Block;
}

struct tcp_opt_ts
{
    ubyte Kind;
    ubyte Length;
    uint Val;
    uint EcR;
}

struct tcp_opt_unknown
{
    ubyte Kind;
    ubyte Length;
}

struct tcp_opt_fastopen
{
    ubyte Kind;
    ubyte Length;
    ubyte Cookie;
}

struct DL_TUNNEL_ADDRESS
{
    COMPARTMENT_ID CompartmentId;
    SCOPE_ID ScopeId;
    ubyte IpAddress;
}

enum TUNNEL_SUB_TYPE
{
    TUNNEL_SUB_TYPE_NONE = 0,
    TUNNEL_SUB_TYPE_CP = 1,
    TUNNEL_SUB_TYPE_IPTLS = 2,
    TUNNEL_SUB_TYPE_HA = 3,
}

struct DL_TEREDO_ADDRESS
{
    ubyte Reserved;
    _Anonymous_e__Union Anonymous;
}

struct DL_TEREDO_ADDRESS_PRV
{
    ubyte Reserved;
    _Anonymous_e__Union Anonymous;
}

struct IPTLS_METADATA
{
    ulong SequenceNumber;
}

enum NPI_MODULEID_TYPE
{
    MIT_GUID = 1,
    MIT_IF_LUID = 2,
}

struct NPI_MODULEID
{
    ushort Length;
    NPI_MODULEID_TYPE Type;
    _Anonymous_e__Union Anonymous;
}

enum FALLBACK_INDEX
{
    FallbackIndexTcpFastopen = 0,
    FallbackIndexMax = 1,
}

@DllImport("fwpuclnt.dll")
void FwpmFreeMemory0(void** p);

@DllImport("fwpuclnt.dll")
uint FwpmEngineOpen0(const(ushort)* serverName, uint authnService, SEC_WINNT_AUTH_IDENTITY_W* authIdentity, const(FWPM_SESSION0)* session, HANDLE* engineHandle);

@DllImport("fwpuclnt.dll")
uint FwpmEngineClose0(HANDLE engineHandle);

@DllImport("fwpuclnt.dll")
uint FwpmEngineGetOption0(HANDLE engineHandle, FWPM_ENGINE_OPTION option, FWP_VALUE0** value);

@DllImport("fwpuclnt.dll")
uint FwpmEngineSetOption0(HANDLE engineHandle, FWPM_ENGINE_OPTION option, const(FWP_VALUE0)* newValue);

@DllImport("fwpuclnt.dll")
uint FwpmEngineGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint FwpmEngineSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint FwpmSessionCreateEnumHandle0(HANDLE engineHandle, const(FWPM_SESSION_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmSessionEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_SESSION0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmSessionDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmTransactionBegin0(HANDLE engineHandle, uint flags);

@DllImport("fwpuclnt.dll")
uint FwpmTransactionCommit0(HANDLE engineHandle);

@DllImport("fwpuclnt.dll")
uint FwpmTransactionAbort0(HANDLE engineHandle);

@DllImport("fwpuclnt.dll")
uint FwpmProviderAdd0(HANDLE engineHandle, const(FWPM_PROVIDER0)* provider, void* sd);

@DllImport("fwpuclnt.dll")
uint FwpmProviderDeleteByKey0(HANDLE engineHandle, const(Guid)* key);

@DllImport("fwpuclnt.dll")
uint FwpmProviderGetByKey0(HANDLE engineHandle, const(Guid)* key, FWPM_PROVIDER0** provider);

@DllImport("fwpuclnt.dll")
uint FwpmProviderCreateEnumHandle0(HANDLE engineHandle, const(FWPM_PROVIDER_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmProviderEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_PROVIDER0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmProviderDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmProviderGetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint FwpmProviderSetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint FwpmProviderSubscribeChanges0(HANDLE engineHandle, const(FWPM_PROVIDER_SUBSCRIPTION0)* subscription, FWPM_PROVIDER_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

@DllImport("fwpuclnt.dll")
uint FwpmProviderUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

@DllImport("fwpuclnt.dll")
uint FwpmProviderSubscriptionsGet0(HANDLE engineHandle, FWPM_PROVIDER_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextAdd0(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT0)* providerContext, void* sd, ulong* id);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextAdd1(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT1)* providerContext, void* sd, ulong* id);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextAdd2(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT2)* providerContext, void* sd, ulong* id);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextAdd3(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT3_)* providerContext, void* sd, ulong* id);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextDeleteById0(HANDLE engineHandle, ulong id);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextDeleteByKey0(HANDLE engineHandle, const(Guid)* key);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextGetById0(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT0** providerContext);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextGetById1(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT1** providerContext);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextGetById2(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT2** providerContext);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextGetById3(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT3_** providerContext);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextGetByKey0(HANDLE engineHandle, const(Guid)* key, FWPM_PROVIDER_CONTEXT0** providerContext);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextGetByKey1(HANDLE engineHandle, const(Guid)* key, FWPM_PROVIDER_CONTEXT1** providerContext);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextGetByKey2(HANDLE engineHandle, const(Guid)* key, FWPM_PROVIDER_CONTEXT2** providerContext);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextGetByKey3(HANDLE engineHandle, const(Guid)* key, FWPM_PROVIDER_CONTEXT3_** providerContext);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextCreateEnumHandle0(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_PROVIDER_CONTEXT0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_PROVIDER_CONTEXT1*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextEnum2(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_PROVIDER_CONTEXT2*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextEnum3(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_PROVIDER_CONTEXT3_*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextGetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextSetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextSubscribeChanges0(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0)* subscription, FWPM_PROVIDER_CONTEXT_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

@DllImport("fwpuclnt.dll")
uint FwpmProviderContextSubscriptionsGet0(HANDLE engineHandle, FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerAdd0(HANDLE engineHandle, const(FWPM_SUBLAYER0)* subLayer, void* sd);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerDeleteByKey0(HANDLE engineHandle, const(Guid)* key);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerGetByKey0(HANDLE engineHandle, const(Guid)* key, FWPM_SUBLAYER0** subLayer);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerCreateEnumHandle0(HANDLE engineHandle, const(FWPM_SUBLAYER_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_SUBLAYER0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerGetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerSetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerSubscribeChanges0(HANDLE engineHandle, const(FWPM_SUBLAYER_SUBSCRIPTION0)* subscription, FWPM_SUBLAYER_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

@DllImport("fwpuclnt.dll")
uint FwpmSubLayerSubscriptionsGet0(HANDLE engineHandle, FWPM_SUBLAYER_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt.dll")
uint FwpmLayerGetById0(HANDLE engineHandle, ushort id, FWPM_LAYER0** layer);

@DllImport("fwpuclnt.dll")
uint FwpmLayerGetByKey0(HANDLE engineHandle, const(Guid)* key, FWPM_LAYER0** layer);

@DllImport("fwpuclnt.dll")
uint FwpmLayerCreateEnumHandle0(HANDLE engineHandle, const(FWPM_LAYER_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmLayerEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_LAYER0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmLayerDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmLayerGetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint FwpmLayerSetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutAdd0(HANDLE engineHandle, const(FWPM_CALLOUT0)* callout, void* sd, uint* id);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutDeleteById0(HANDLE engineHandle, uint id);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutDeleteByKey0(HANDLE engineHandle, const(Guid)* key);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutGetById0(HANDLE engineHandle, uint id, FWPM_CALLOUT0** callout);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutGetByKey0(HANDLE engineHandle, const(Guid)* key, FWPM_CALLOUT0** callout);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutCreateEnumHandle0(HANDLE engineHandle, const(FWPM_CALLOUT_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_CALLOUT0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutGetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutSetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutSubscribeChanges0(HANDLE engineHandle, const(FWPM_CALLOUT_SUBSCRIPTION0)* subscription, FWPM_CALLOUT_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

@DllImport("fwpuclnt.dll")
uint FwpmCalloutSubscriptionsGet0(HANDLE engineHandle, FWPM_CALLOUT_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt.dll")
uint FwpmFilterAdd0(HANDLE engineHandle, const(FWPM_FILTER0)* filter, void* sd, ulong* id);

@DllImport("fwpuclnt.dll")
uint FwpmFilterDeleteById0(HANDLE engineHandle, ulong id);

@DllImport("fwpuclnt.dll")
uint FwpmFilterDeleteByKey0(HANDLE engineHandle, const(Guid)* key);

@DllImport("fwpuclnt.dll")
uint FwpmFilterGetById0(HANDLE engineHandle, ulong id, FWPM_FILTER0** filter);

@DllImport("fwpuclnt.dll")
uint FwpmFilterGetByKey0(HANDLE engineHandle, const(Guid)* key, FWPM_FILTER0** filter);

@DllImport("fwpuclnt.dll")
uint FwpmFilterCreateEnumHandle0(HANDLE engineHandle, const(FWPM_FILTER_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmFilterEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_FILTER0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmFilterDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmFilterGetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint FwpmFilterSetSecurityInfoByKey0(HANDLE engineHandle, const(Guid)* key, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint FwpmFilterSubscribeChanges0(HANDLE engineHandle, const(FWPM_FILTER_SUBSCRIPTION0)* subscription, FWPM_FILTER_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

@DllImport("fwpuclnt.dll")
uint FwpmFilterUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

@DllImport("fwpuclnt.dll")
uint FwpmFilterSubscriptionsGet0(HANDLE engineHandle, FWPM_FILTER_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt.dll")
uint FwpmGetAppIdFromFileName0(const(wchar)* fileName, FWP_BYTE_BLOB** appId);

@DllImport("fwpuclnt.dll")
uint FwpmBitmapIndexGet0(HANDLE engineHandle, const(Guid)* fieldId, ubyte* idx);

@DllImport("fwpuclnt.dll")
uint FwpmBitmapIndexFree0(HANDLE engineHandle, const(Guid)* fieldId, ubyte* idx);

@DllImport("fwpuclnt.dll")
uint FwpmIPsecTunnelAdd0(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT0)* mainModePolicy, const(FWPM_PROVIDER_CONTEXT0)* tunnelPolicy, uint numFilterConditions, char* filterConditions, void* sd);

@DllImport("fwpuclnt.dll")
uint FwpmIPsecTunnelAdd1(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT1)* mainModePolicy, const(FWPM_PROVIDER_CONTEXT1)* tunnelPolicy, uint numFilterConditions, char* filterConditions, const(Guid)* keyModKey, void* sd);

@DllImport("fwpuclnt.dll")
uint FwpmIPsecTunnelAdd2(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT2)* mainModePolicy, const(FWPM_PROVIDER_CONTEXT2)* tunnelPolicy, uint numFilterConditions, char* filterConditions, const(Guid)* keyModKey, void* sd);

@DllImport("fwpuclnt.dll")
uint FwpmIPsecTunnelAdd3(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT3_)* mainModePolicy, const(FWPM_PROVIDER_CONTEXT3_)* tunnelPolicy, uint numFilterConditions, char* filterConditions, const(Guid)* keyModKey, void* sd);

@DllImport("fwpuclnt.dll")
uint FwpmIPsecTunnelDeleteByKey0(HANDLE engineHandle, const(Guid)* key);

@DllImport("fwpuclnt.dll")
uint IPsecGetStatistics0(HANDLE engineHandle, IPSEC_STATISTICS0* ipsecStatistics);

@DllImport("fwpuclnt.dll")
uint IPsecGetStatistics1(HANDLE engineHandle, IPSEC_STATISTICS1* ipsecStatistics);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextCreate0(HANDLE engineHandle, const(IPSEC_TRAFFIC0)* outboundTraffic, ulong* inboundFilterId, ulong* id);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextCreate1(HANDLE engineHandle, const(IPSEC_TRAFFIC1)* outboundTraffic, const(IPSEC_VIRTUAL_IF_TUNNEL_INFO0)* virtualIfTunnelInfo, ulong* inboundFilterId, ulong* id);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextDeleteById0(HANDLE engineHandle, ulong id);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextGetById0(HANDLE engineHandle, ulong id, IPSEC_SA_CONTEXT0** saContext);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextGetById1(HANDLE engineHandle, ulong id, IPSEC_SA_CONTEXT1** saContext);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextGetSpi0(HANDLE engineHandle, ulong id, const(IPSEC_GETSPI0)* getSpi, uint* inboundSpi);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextGetSpi1(HANDLE engineHandle, ulong id, const(IPSEC_GETSPI1)* getSpi, uint* inboundSpi);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextSetSpi0(HANDLE engineHandle, ulong id, const(IPSEC_GETSPI1)* getSpi, uint inboundSpi);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextAddInbound0(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE0)* inboundBundle);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextAddOutbound0(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE0)* outboundBundle);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextAddInbound1(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE1)* inboundBundle);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextAddOutbound1(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE1)* outboundBundle);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextExpire0(HANDLE engineHandle, ulong id);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextUpdate0(HANDLE engineHandle, ulong flags, const(IPSEC_SA_CONTEXT1)* newValues);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextCreateEnumHandle0(HANDLE engineHandle, const(IPSEC_SA_CONTEXT_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IPSEC_SA_CONTEXT0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IPSEC_SA_CONTEXT1*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextSubscribe0(HANDLE engineHandle, const(IPSEC_SA_CONTEXT_SUBSCRIPTION0)* subscription, IPSEC_SA_CONTEXT_CALLBACK0 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextUnsubscribe0(HANDLE engineHandle, HANDLE eventsHandle);

@DllImport("fwpuclnt.dll")
uint IPsecSaContextSubscriptionsGet0(HANDLE engineHandle, IPSEC_SA_CONTEXT_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt.dll")
uint IPsecSaCreateEnumHandle0(HANDLE engineHandle, const(IPSEC_SA_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint IPsecSaEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IPSEC_SA_DETAILS0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint IPsecSaEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IPSEC_SA_DETAILS1*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint IPsecSaDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint IPsecSaDbGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint IPsecSaDbSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint IPsecDospGetStatistics0(HANDLE engineHandle, IPSEC_DOSP_STATISTICS0* idpStatistics);

@DllImport("fwpuclnt.dll")
uint IPsecDospStateCreateEnumHandle0(HANDLE engineHandle, const(IPSEC_DOSP_STATE_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint IPsecDospStateEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IPSEC_DOSP_STATE0*** entries, uint* numEntries);

@DllImport("fwpuclnt.dll")
uint IPsecDospStateDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint IPsecDospGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint IPsecDospSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint IPsecKeyManagerAddAndRegister0(HANDLE engineHandle, const(IPSEC_KEY_MANAGER0)* keyManager, const(IPSEC_KEY_MANAGER_CALLBACKS0)* keyManagerCallbacks, HANDLE* keyMgmtHandle);

@DllImport("fwpuclnt.dll")
uint IPsecKeyManagerUnregisterAndDelete0(HANDLE engineHandle, HANDLE keyMgmtHandle);

@DllImport("fwpuclnt.dll")
uint IPsecKeyManagersGet0(HANDLE engineHandle, IPSEC_KEY_MANAGER0*** entries, uint* numEntries);

@DllImport("fwpuclnt.dll")
uint IPsecKeyManagerGetSecurityInfoByKey0(HANDLE engineHandle, const(void)* reserved, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint IPsecKeyManagerSetSecurityInfoByKey0(HANDLE engineHandle, const(void)* reserved, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint IkeextGetStatistics0(HANDLE engineHandle, IKEEXT_STATISTICS0* ikeextStatistics);

@DllImport("fwpuclnt.dll")
uint IkeextGetStatistics1(HANDLE engineHandle, IKEEXT_STATISTICS1* ikeextStatistics);

@DllImport("fwpuclnt.dll")
uint IkeextSaDeleteById0(HANDLE engineHandle, ulong id);

@DllImport("fwpuclnt.dll")
uint IkeextSaGetById0(HANDLE engineHandle, ulong id, IKEEXT_SA_DETAILS0** sa);

@DllImport("fwpuclnt.dll")
uint IkeextSaGetById1(HANDLE engineHandle, ulong id, Guid* saLookupContext, IKEEXT_SA_DETAILS1** sa);

@DllImport("fwpuclnt.dll")
uint IkeextSaGetById2(HANDLE engineHandle, ulong id, Guid* saLookupContext, IKEEXT_SA_DETAILS2** sa);

@DllImport("fwpuclnt.dll")
uint IkeextSaCreateEnumHandle0(HANDLE engineHandle, const(IKEEXT_SA_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint IkeextSaEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IKEEXT_SA_DETAILS0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint IkeextSaEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IKEEXT_SA_DETAILS1*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint IkeextSaEnum2(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IKEEXT_SA_DETAILS2*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint IkeextSaDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint IkeextSaDbGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint IkeextSaDbSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventCreateEnumHandle0(HANDLE engineHandle, const(FWPM_NET_EVENT_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_NET_EVENT0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_NET_EVENT1*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventEnum2(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_NET_EVENT2*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventEnum3(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_NET_EVENT3*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventEnum4(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_NET_EVENT4_*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventEnum5(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_NET_EVENT5_*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventsGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventsSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventSubscribe0(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, FWPM_NET_EVENT_CALLBACK0 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventUnsubscribe0(HANDLE engineHandle, HANDLE eventsHandle);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventSubscriptionsGet0(HANDLE engineHandle, FWPM_NET_EVENT_SUBSCRIPTION0*** entries, uint* numEntries);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventSubscribe1(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, FWPM_NET_EVENT_CALLBACK1 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventSubscribe2(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, FWPM_NET_EVENT_CALLBACK2 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventSubscribe3(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, FWPM_NET_EVENT_CALLBACK3 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt.dll")
uint FwpmNetEventSubscribe4(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, FWPM_NET_EVENT_CALLBACK4 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt.dll")
uint FwpmSystemPortsGet0(HANDLE engineHandle, FWPM_SYSTEM_PORTS0** sysPorts);

@DllImport("fwpuclnt.dll")
uint FwpmSystemPortsSubscribe0(HANDLE engineHandle, void* reserved, FWPM_SYSTEM_PORTS_CALLBACK0 callback, void* context, HANDLE* sysPortsHandle);

@DllImport("fwpuclnt.dll")
uint FwpmSystemPortsUnsubscribe0(HANDLE engineHandle, HANDLE sysPortsHandle);

@DllImport("fwpuclnt.dll")
uint FwpmConnectionGetById0(HANDLE engineHandle, ulong id, FWPM_CONNECTION0** connection);

@DllImport("fwpuclnt.dll")
uint FwpmConnectionEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_CONNECTION0*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt.dll")
uint FwpmConnectionCreateEnumHandle0(HANDLE engineHandle, const(FWPM_CONNECTION_ENUM_TEMPLATE0)* enumTemplate, HANDLE* enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmConnectionDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

@DllImport("fwpuclnt.dll")
uint FwpmConnectionGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint FwpmConnectionSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

@DllImport("fwpuclnt.dll")
uint FwpmConnectionSubscribe0(HANDLE engineHandle, const(FWPM_CONNECTION_SUBSCRIPTION0)* subscription, FWPM_CONNECTION_CALLBACK0 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt.dll")
uint FwpmConnectionUnsubscribe0(HANDLE engineHandle, HANDLE eventsHandle);

@DllImport("fwpuclnt.dll")
uint FwpmvSwitchEventSubscribe0(HANDLE engineHandle, const(FWPM_VSWITCH_EVENT_SUBSCRIPTION0)* subscription, FWPM_VSWITCH_EVENT_CALLBACK0 callback, void* context, HANDLE* subscriptionHandle);

@DllImport("fwpuclnt.dll")
uint FwpmvSwitchEventUnsubscribe0(HANDLE engineHandle, HANDLE subscriptionHandle);

@DllImport("fwpuclnt.dll")
uint FwpmvSwitchEventsGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

@DllImport("fwpuclnt.dll")
uint FwpmvSwitchEventsSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

