module windows.networkpolicyserver;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


enum : uint
{
    ATTRIBUTE_UNDEFINED                                  = 0x00000000,
    ATTRIBUTE_MIN_VALUE                                  = 0x00000001,
    RADIUS_ATTRIBUTE_USER_NAME                           = 0x00000001,
    RADIUS_ATTRIBUTE_USER_PASSWORD                       = 0x00000002,
    RADIUS_ATTRIBUTE_CHAP_PASSWORD                       = 0x00000003,
    RADIUS_ATTRIBUTE_NAS_IP_ADDRESS                      = 0x00000004,
    RADIUS_ATTRIBUTE_NAS_PORT                            = 0x00000005,
    RADIUS_ATTRIBUTE_SERVICE_TYPE                        = 0x00000006,
    RADIUS_ATTRIBUTE_FRAMED_PROTOCOL                     = 0x00000007,
    RADIUS_ATTRIBUTE_FRAMED_IP_ADDRESS                   = 0x00000008,
    RADIUS_ATTRIBUTE_FRAMED_IP_NETMASK                   = 0x00000009,
    RADIUS_ATTRIBUTE_FRAMED_ROUTING                      = 0x0000000a,
    RADIUS_ATTRIBUTE_FILTER_ID                           = 0x0000000b,
    RADIUS_ATTRIBUTE_FRAMED_MTU                          = 0x0000000c,
    RADIUS_ATTRIBUTE_FRAMED_COMPRESSION                  = 0x0000000d,
    RADIUS_ATTRIBUTE_LOGIN_IP_HOST                       = 0x0000000e,
    RADIUS_ATTRIBUTE_LOGIN_SERVICE                       = 0x0000000f,
    RADIUS_ATTRIBUTE_LOGIN_TCP_PORT                      = 0x00000010,
    RADIUS_ATTRIBUTE_UNASSIGNED1                         = 0x00000011,
    RADIUS_ATTRIBUTE_REPLY_MESSAGE                       = 0x00000012,
    RADIUS_ATTRIBUTE_CALLBACK_NUMBER                     = 0x00000013,
    RADIUS_ATTRIBUTE_CALLBACK_ID                         = 0x00000014,
    RADIUS_ATTRIBUTE_UNASSIGNED2                         = 0x00000015,
    RADIUS_ATTRIBUTE_FRAMED_ROUTE                        = 0x00000016,
    RADIUS_ATTRIBUTE_FRAMED_IPX_NETWORK                  = 0x00000017,
    RADIUS_ATTRIBUTE_STATE                               = 0x00000018,
    RADIUS_ATTRIBUTE_CLASS                               = 0x00000019,
    RADIUS_ATTRIBUTE_VENDOR_SPECIFIC                     = 0x0000001a,
    RADIUS_ATTRIBUTE_SESSION_TIMEOUT                     = 0x0000001b,
    RADIUS_ATTRIBUTE_IDLE_TIMEOUT                        = 0x0000001c,
    RADIUS_ATTRIBUTE_TERMINATION_ACTION                  = 0x0000001d,
    RADIUS_ATTRIBUTE_CALLED_STATION_ID                   = 0x0000001e,
    RADIUS_ATTRIBUTE_CALLING_STATION_ID                  = 0x0000001f,
    RADIUS_ATTRIBUTE_NAS_IDENTIFIER                      = 0x00000020,
    RADIUS_ATTRIBUTE_PROXY_STATE                         = 0x00000021,
    RADIUS_ATTRIBUTE_LOGIN_LAT_SERVICE                   = 0x00000022,
    RADIUS_ATTRIBUTE_LOGIN_LAT_NODE                      = 0x00000023,
    RADIUS_ATTRIBUTE_LOGIN_LAT_GROUP                     = 0x00000024,
    RADIUS_ATTRIBUTE_FRAMED_APPLETALK_LINK               = 0x00000025,
    RADIUS_ATTRIBUTE_FRAMED_APPLETALK_NET                = 0x00000026,
    RADIUS_ATTRIBUTE_FRAMED_APPLETALK_ZONE               = 0x00000027,
    RADIUS_ATTRIBUTE_ACCT_STATUS_TYPE                    = 0x00000028,
    RADIUS_ATTRIBUTE_ACCT_DELAY_TIME                     = 0x00000029,
    RADIUS_ATTRIBUTE_ACCT_INPUT_OCTETS                   = 0x0000002a,
    RADIUS_ATTRIBUTE_ACCT_OUTPUT_OCTETS                  = 0x0000002b,
    RADIUS_ATTRIBUTE_ACCT_SESSION_ID                     = 0x0000002c,
    RADIUS_ATTRIBUTE_ACCT_AUTHENTIC                      = 0x0000002d,
    RADIUS_ATTRIBUTE_ACCT_SESSION_TIME                   = 0x0000002e,
    RADIUS_ATTRIBUTE_ACCT_INPUT_PACKETS                  = 0x0000002f,
    RADIUS_ATTRIBUTE_ACCT_OUTPUT_PACKETS                 = 0x00000030,
    RADIUS_ATTRIBUTE_ACCT_TERMINATE_CAUSE                = 0x00000031,
    RADIUS_ATTRIBUTE_ACCT_MULTI_SSN_ID                   = 0x00000032,
    RADIUS_ATTRIBUTE_ACCT_LINK_COUNT                     = 0x00000033,
    RADIUS_ATTRIBUTE_CHAP_CHALLENGE                      = 0x0000003c,
    RADIUS_ATTRIBUTE_NAS_PORT_TYPE                       = 0x0000003d,
    RADIUS_ATTRIBUTE_PORT_LIMIT                          = 0x0000003e,
    RADIUS_ATTRIBUTE_LOGIN_LAT_PORT                      = 0x0000003f,
    RADIUS_ATTRIBUTE_TUNNEL_TYPE                         = 0x00000040,
    RADIUS_ATTRIBUTE_TUNNEL_MEDIUM_TYPE                  = 0x00000041,
    RADIUS_ATTRIBUTE_TUNNEL_CLIENT_ENDPT                 = 0x00000042,
    RADIUS_ATTRIBUTE_TUNNEL_SERVER_ENDPT                 = 0x00000043,
    RADIUS_ATTRIBUTE_ACCT_TUNNEL_CONN                    = 0x00000044,
    RADIUS_ATTRIBUTE_TUNNEL_PASSWORD                     = 0x00000045,
    RADIUS_ATTRIBUTE_ARAP_PASSWORD                       = 0x00000046,
    RADIUS_ATTRIBUTE_ARAP_FEATURES                       = 0x00000047,
    RADIUS_ATTRIBUTE_ARAP_ZONE_ACCESS                    = 0x00000048,
    RADIUS_ATTRIBUTE_ARAP_SECURITY                       = 0x00000049,
    RADIUS_ATTRIBUTE_ARAP_SECURITY_DATA                  = 0x0000004a,
    RADIUS_ATTRIBUTE_PASSWORD_RETRY                      = 0x0000004b,
    RADIUS_ATTRIBUTE_PROMPT                              = 0x0000004c,
    RADIUS_ATTRIBUTE_CONNECT_INFO                        = 0x0000004d,
    RADIUS_ATTRIBUTE_CONFIGURATION_TOKEN                 = 0x0000004e,
    RADIUS_ATTRIBUTE_EAP_MESSAGE                         = 0x0000004f,
    RADIUS_ATTRIBUTE_SIGNATURE                           = 0x00000050,
    RADIUS_ATTRIBUTE_TUNNEL_PVT_GROUP_ID                 = 0x00000051,
    RADIUS_ATTRIBUTE_TUNNEL_ASSIGNMENT_ID                = 0x00000052,
    RADIUS_ATTRIBUTE_TUNNEL_PREFERENCE                   = 0x00000053,
    RADIUS_ATTRIBUTE_ARAP_CHALLENGE_RESPONSE             = 0x00000054,
    RADIUS_ATTRIBUTE_ACCT_INTERIM_INTERVAL               = 0x00000055,
    RADIUS_ATTRIBUTE_NAS_IPv6_ADDRESS                    = 0x0000005f,
    RADIUS_ATTRIBUTE_FRAMED_INTERFACE_ID                 = 0x00000060,
    RADIUS_ATTRIBUTE_FRAMED_IPv6_PREFIX                  = 0x00000061,
    RADIUS_ATTRIBUTE_LOGIN_IPv6_HOST                     = 0x00000062,
    RADIUS_ATTRIBUTE_FRAMED_IPv6_ROUTE                   = 0x00000063,
    RADIUS_ATTRIBUTE_FRAMED_IPv6_POOL                    = 0x00000064,
    IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_IP_ADDRESS         = 0x00001000,
    IAS_ATTRIBUTE_SAVED_RADIUS_CALLBACK_NUMBER           = 0x00001001,
    IAS_ATTRIBUTE_NP_CALLING_STATION_ID                  = 0x00001002,
    IAS_ATTRIBUTE_SAVED_NP_CALLING_STATION_ID            = 0x00001003,
    IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_ROUTE              = 0x00001004,
    IAS_ATTRIBUTE_IGNORE_USER_DIALIN_PROPERTIES          = 0x00001005,
    IAS_ATTRIBUTE_NP_TIME_OF_DAY                         = 0x00001006,
    IAS_ATTRIBUTE_NP_CALLED_STATION_ID                   = 0x00001007,
    IAS_ATTRIBUTE_NP_ALLOWED_PORT_TYPES                  = 0x00001008,
    IAS_ATTRIBUTE_NP_AUTHENTICATION_TYPE                 = 0x00001009,
    IAS_ATTRIBUTE_NP_ALLOWED_EAP_TYPE                    = 0x0000100a,
    IAS_ATTRIBUTE_SHARED_SECRET                          = 0x0000100b,
    IAS_ATTRIBUTE_CLIENT_IP_ADDRESS                      = 0x0000100c,
    IAS_ATTRIBUTE_CLIENT_PACKET_HEADER                   = 0x0000100d,
    IAS_ATTRIBUTE_TOKEN_GROUPS                           = 0x0000100e,
    IAS_ATTRIBUTE_ALLOW_DIALIN                           = 0x0000100f,
    IAS_ATTRIBUTE_REQUEST_ID                             = 0x00001010,
    IAS_ATTRIBUTE_MANIPULATION_TARGET                    = 0x00001011,
    IAS_ATTRIBUTE_MANIPULATION_RULE                      = 0x00001012,
    IAS_ATTRIBUTE_ORIGINAL_USER_NAME                     = 0x00001013,
    IAS_ATTRIBUTE_CLIENT_VENDOR_TYPE                     = 0x00001014,
    IAS_ATTRIBUTE_CLIENT_UDP_PORT                        = 0x00001015,
    MS_ATTRIBUTE_CHAP_CHALLENGE                          = 0x00001016,
    MS_ATTRIBUTE_CHAP_RESPONSE                           = 0x00001017,
    MS_ATTRIBUTE_CHAP_DOMAIN                             = 0x00001018,
    MS_ATTRIBUTE_CHAP_ERROR                              = 0x00001019,
    MS_ATTRIBUTE_CHAP_CPW1                               = 0x0000101a,
    MS_ATTRIBUTE_CHAP_CPW2                               = 0x0000101b,
    MS_ATTRIBUTE_CHAP_LM_ENC_PW                          = 0x0000101c,
    MS_ATTRIBUTE_CHAP_NT_ENC_PW                          = 0x0000101d,
    MS_ATTRIBUTE_CHAP_MPPE_KEYS                          = 0x0000101e,
    IAS_ATTRIBUTE_AUTHENTICATION_TYPE                    = 0x0000101f,
    IAS_ATTRIBUTE_CLIENT_NAME                            = 0x00001020,
    IAS_ATTRIBUTE_NT4_ACCOUNT_NAME                       = 0x00001021,
    IAS_ATTRIBUTE_FULLY_QUALIFIED_USER_NAME              = 0x00001022,
    IAS_ATTRIBUTE_NTGROUPS                               = 0x00001023,
    IAS_ATTRIBUTE_EAP_FRIENDLY_NAME                      = 0x00001024,
    IAS_ATTRIBUTE_AUTH_PROVIDER_TYPE                     = 0x00001025,
    MS_ATTRIBUTE_ACCT_AUTH_TYPE                          = 0x00001026,
    MS_ATTRIBUTE_ACCT_EAP_TYPE                           = 0x00001027,
    IAS_ATTRIBUTE_PACKET_TYPE                            = 0x00001028,
    IAS_ATTRIBUTE_AUTH_PROVIDER_NAME                     = 0x00001029,
    IAS_ATTRIBUTE_ACCT_PROVIDER_TYPE                     = 0x0000102a,
    IAS_ATTRIBUTE_ACCT_PROVIDER_NAME                     = 0x0000102b,
    MS_ATTRIBUTE_MPPE_SEND_KEY                           = 0x0000102c,
    MS_ATTRIBUTE_MPPE_RECV_KEY                           = 0x0000102d,
    IAS_ATTRIBUTE_REASON_CODE                            = 0x0000102e,
    MS_ATTRIBUTE_FILTER                                  = 0x0000102f,
    MS_ATTRIBUTE_CHAP2_RESPONSE                          = 0x00001030,
    MS_ATTRIBUTE_CHAP2_SUCCESS                           = 0x00001031,
    MS_ATTRIBUTE_CHAP2_CPW                               = 0x00001032,
    MS_ATTRIBUTE_RAS_VENDOR                              = 0x00001033,
    MS_ATTRIBUTE_RAS_VERSION                             = 0x00001034,
    IAS_ATTRIBUTE_NP_NAME                                = 0x00001035,
    MS_ATTRIBUTE_PRIMARY_DNS_SERVER                      = 0x00001036,
    MS_ATTRIBUTE_SECONDARY_DNS_SERVER                    = 0x00001037,
    MS_ATTRIBUTE_PRIMARY_NBNS_SERVER                     = 0x00001038,
    MS_ATTRIBUTE_SECONDARY_NBNS_SERVER                   = 0x00001039,
    IAS_ATTRIBUTE_PROXY_POLICY_NAME                      = 0x0000103a,
    IAS_ATTRIBUTE_PROVIDER_TYPE                          = 0x0000103b,
    IAS_ATTRIBUTE_PROVIDER_NAME                          = 0x0000103c,
    IAS_ATTRIBUTE_REMOTE_SERVER_ADDRESS                  = 0x0000103d,
    IAS_ATTRIBUTE_GENERATE_CLASS_ATTRIBUTE               = 0x0000103e,
    MS_ATTRIBUTE_RAS_CLIENT_NAME                         = 0x0000103f,
    MS_ATTRIBUTE_RAS_CLIENT_VERSION                      = 0x00001040,
    IAS_ATTRIBUTE_ALLOWED_CERTIFICATE_EKU                = 0x00001041,
    IAS_ATTRIBUTE_EXTENSION_STATE                        = 0x00001042,
    IAS_ATTRIBUTE_GENERATE_SESSION_TIMEOUT               = 0x00001043,
    IAS_ATTRIBUTE_SESSION_TIMEOUT                        = 0x00001044,
    MS_ATTRIBUTE_QUARANTINE_IPFILTER                     = 0x00001045,
    MS_ATTRIBUTE_QUARANTINE_SESSION_TIMEOUT              = 0x00001046,
    MS_ATTRIBUTE_USER_SECURITY_IDENTITY                  = 0x00001047,
    IAS_ATTRIBUTE_REMOTE_RADIUS_TO_WINDOWS_USER_MAPPING  = 0x00001048,
    IAS_ATTRIBUTE_PASSPORT_USER_MAPPING_UPN_SUFFIX       = 0x00001049,
    IAS_ATTRIBUTE_TUNNEL_TAG                             = 0x0000104a,
    IAS_ATTRIBUTE_NP_PEAPUPFRONT_ENABLED                 = 0x0000104b,
    IAS_ATTRIBUTE_CERTIFICATE_EKU                        = 0x00001fa1,
    IAS_ATTRIBUTE_EAP_CONFIG                             = 0x00001fa2,
    IAS_ATTRIBUTE_PEAP_EMBEDDED_EAP_TYPEID               = 0x00001fa3,
    IAS_ATTRIBUTE_PEAP_FAST_ROAMED_SESSION               = 0x00001fa4,
    IAS_ATTRIBUTE_EAP_TYPEID                             = 0x00001fa5,
    MS_ATTRIBUTE_EAP_TLV                                 = 0x00001fa6,
    IAS_ATTRIBUTE_REJECT_REASON_CODE                     = 0x00001fa7,
    IAS_ATTRIBUTE_PROXY_EAP_CONFIG                       = 0x00001fa8,
    IAS_ATTRIBUTE_EAP_SESSION                            = 0x00001fa9,
    IAS_ATTRIBUTE_IS_REPLAY                              = 0x00001faa,
    IAS_ATTRIBUTE_CLEAR_TEXT_PASSWORD                    = 0x00001fab,
    MS_ATTRIBUTE_IDENTITY_TYPE                           = 0x00001fac,
    MS_ATTRIBUTE_SERVICE_CLASS                           = 0x00001fad,
    MS_ATTRIBUTE_QUARANTINE_USER_CLASS                   = 0x00001fae,
    MS_ATTRIBUTE_QUARANTINE_STATE                        = 0x00001faf,
    IAS_ATTRIBUTE_OVERRIDE_RAP_AUTH                      = 0x00001fb0,
    IAS_ATTRIBUTE_PEAP_CHANNEL_UP                        = 0x00001fb1,
    IAS_ATTRIBUTE_NAME_MAPPED                            = 0x00001fb2,
    IAS_ATTRIBUTE_POLICY_ENFORCED                        = 0x00001fb3,
    IAS_ATTRIBUTE_MACHINE_NTGROUPS                       = 0x00001fb4,
    IAS_ATTRIBUTE_USER_NTGROUPS                          = 0x00001fb5,
    IAS_ATTRIBUTE_MACHINE_TOKEN_GROUPS                   = 0x00001fb6,
    IAS_ATTRIBUTE_USER_TOKEN_GROUPS                      = 0x00001fb7,
    MS_ATTRIBUTE_QUARANTINE_GRACE_TIME                   = 0x00001fb8,
    IAS_ATTRIBUTE_QUARANTINE_URL                         = 0x00001fb9,
    IAS_ATTRIBUTE_QUARANTINE_FIXUP_SERVERS               = 0x00001fba,
    MS_ATTRIBUTE_NOT_QUARANTINE_CAPABLE                  = 0x00001fbb,
    IAS_ATTRIBUTE_QUARANTINE_SYSTEM_HEALTH_RESULT        = 0x00001fbc,
    IAS_ATTRIBUTE_QUARANTINE_SYSTEM_HEALTH_VALIDATORS    = 0x00001fbd,
    IAS_ATTRIBUTE_MACHINE_NAME                           = 0x00001fbe,
    IAS_ATTRIBUTE_NT4_MACHINE_NAME                       = 0x00001fbf,
    IAS_ATTRIBUTE_QUARANTINE_SESSION_HANDLE              = 0x00001fc0,
    IAS_ATTRIBUTE_FULLY_QUALIFIED_MACHINE_NAME           = 0x00001fc1,
    IAS_ATTRIBUTE_QUARANTINE_FIXUP_SERVERS_CONFIGURATION = 0x00001fc2,
    IAS_ATTRIBUTE_CLIENT_QUARANTINE_COMPATIBLE           = 0x00001fc3,
    MS_ATTRIBUTE_NETWORK_ACCESS_SERVER_TYPE              = 0x00001fc4,
    IAS_ATTRIBUTE_QUARANTINE_SESSION_ID                  = 0x00001fc5,
    MS_ATTRIBUTE_AFW_QUARANTINE_ZONE                     = 0x00001fc6,
    MS_ATTRIBUTE_AFW_PROTECTION_LEVEL                    = 0x00001fc7,
    IAS_ATTRIBUTE_QUARANTINE_UPDATE_NON_COMPLIANT        = 0x00001fc8,
    IAS_ATTRIBUTE_REQUEST_START_TIME                     = 0x00001fc9,
    MS_ATTRIBUTE_MACHINE_NAME                            = 0x00001fca,
    IAS_ATTRIBUTE_CLIENT_IPv6_ADDRESS                    = 0x00001fcb,
    IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_INTERFACE_ID       = 0x00001fcc,
    IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_IPv6_PREFIX        = 0x00001fcd,
    IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_IPv6_ROUTE         = 0x00001fce,
    MS_ATTRIBUTE_QUARANTINE_GRACE_TIME_CONFIGURATION     = 0x00001fcf,
    MS_ATTRIBUTE_IPv6_FILTER                             = 0x00001fd0,
    MS_ATTRIBUTE_IPV4_REMEDIATION_SERVERS                = 0x00001fd1,
    MS_ATTRIBUTE_IPV6_REMEDIATION_SERVERS                = 0x00001fd2,
    IAS_ATTRIBUTE_PROXY_RETRY_COUNT                      = 0x00001fd3,
    IAS_ATTRIBUTE_MACHINE_INVENTORY                      = 0x00001fd4,
    IAS_ATTRIBUTE_ABSOLUTE_TIME                          = 0x00001fd5,
    MS_ATTRIBUTE_QUARANTINE_SOH                          = 0x00001fd6,
    IAS_ATTRIBUTE_EAP_TYPES_CONFIGURED_IN_PROXYPOLICY    = 0x00001fd7,
    MS_ATTRIBUTE_HCAP_LOCATION_GROUP_NAME                = 0x00001fd8,
    MS_ATTRIBUTE_EXTENDED_QUARANTINE_STATE               = 0x00001fd9,
    IAS_ATTRIBUTE_SOH_CARRIER_EAPTLV                     = 0x00001fda,
    MS_ATTRIBUTE_HCAP_USER_GROUPS                        = 0x00001fdb,
    IAS_ATTRIBUTE_SAVED_MACHINE_HEALTHCHECK_ONLY         = 0x00001fdc,
    IAS_ATTRIBUTE_POLICY_EVALUATED_SHV                   = 0x00001fdd,
    MS_ATTRIBUTE_RAS_CORRELATION_ID                      = 0x00001fde,
    MS_ATTRIBUTE_HCAP_USER_NAME                          = 0x00001fdf,
    IAS_ATTRIBUTE_NT4_HCAP_ACCOUNT_NAME                  = 0x00001fe0,
    IAS_ATTRIBUTE_USER_TOKEN_SID                         = 0x00001fe1,
    IAS_ATTRIBUTE_MACHINE_TOKEN_SID                      = 0x00001fe2,
    IAS_ATTRIBUTE_MACHINE_VALIDATED                      = 0x00001fe3,
    MS_ATTRIBUTE_USER_IPv4_ADDRESS                       = 0x00001fe4,
    MS_ATTRIBUTE_USER_IPv6_ADDRESS                       = 0x00001fe5,
    MS_ATTRIBUTE_TSG_DEVICE_REDIRECTION                  = 0x00001fe6,
    IAS_ATTRIBUTE_ACCEPT_REASON_CODE                     = 0x00001fe7,
    IAS_ATTRIBUTE_LOGGING_RESULT                         = 0x00001fe8,
    IAS_ATTRIBUTE_SERVER_IP_ADDRESS                      = 0x00001fe9,
    IAS_ATTRIBUTE_SERVER_IPv6_ADDRESS                    = 0x00001fea,
    IAS_ATTRIBUTE_RADIUS_USERNAME_ENCODING_ASCII         = 0x00001feb,
    MS_ATTRIBUTE_RAS_ROUTING_DOMAIN_ID                   = 0x00001fec,
    IAS_ATTRIBUTE_CERTIFICATE_THUMBPRINT                 = 0x0000203a,
    RAS_ATTRIBUTE_ENCRYPTION_TYPE                        = 0xffffffa6,
    RAS_ATTRIBUTE_ENCRYPTION_POLICY                      = 0xffffffa7,
    RAS_ATTRIBUTE_BAP_REQUIRED                           = 0xffffffa8,
    RAS_ATTRIBUTE_BAP_LINE_DOWN_TIME                     = 0xffffffa9,
    RAS_ATTRIBUTE_BAP_LINE_DOWN_LIMIT                    = 0xffffffaa,
}
alias ATTRIBUTEID = uint;

enum : int
{
    IAS_LOGGING_UNLIMITED_SIZE         = 0x00000000,
    IAS_LOGGING_DAILY                  = 0x00000001,
    IAS_LOGGING_WEEKLY                 = 0x00000002,
    IAS_LOGGING_MONTHLY                = 0x00000003,
    IAS_LOGGING_WHEN_FILE_SIZE_REACHES = 0x00000004,
}
alias NEW_LOG_FILE_FREQUENCY = int;

enum : int
{
    IAS_AUTH_INVALID     = 0x00000000,
    IAS_AUTH_PAP         = 0x00000001,
    IAS_AUTH_MD5CHAP     = 0x00000002,
    IAS_AUTH_MSCHAP      = 0x00000003,
    IAS_AUTH_MSCHAP2     = 0x00000004,
    IAS_AUTH_EAP         = 0x00000005,
    IAS_AUTH_ARAP        = 0x00000006,
    IAS_AUTH_NONE        = 0x00000007,
    IAS_AUTH_CUSTOM      = 0x00000008,
    IAS_AUTH_MSCHAP_CPW  = 0x00000009,
    IAS_AUTH_MSCHAP2_CPW = 0x0000000a,
    IAS_AUTH_PEAP        = 0x0000000b,
}
alias AUTHENTICATION_TYPE = int;

enum : int
{
    IAS_IDENTITY_NO_DEFAULT = 0x00000001,
}
alias IDENTITY_TYPE = int;

enum : int
{
    IAS_SYNTAX_BOOLEAN          = 0x00000001,
    IAS_SYNTAX_INTEGER          = 0x00000002,
    IAS_SYNTAX_ENUMERATOR       = 0x00000003,
    IAS_SYNTAX_INETADDR         = 0x00000004,
    IAS_SYNTAX_STRING           = 0x00000005,
    IAS_SYNTAX_OCTETSTRING      = 0x00000006,
    IAS_SYNTAX_UTCTIME          = 0x00000007,
    IAS_SYNTAX_PROVIDERSPECIFIC = 0x00000008,
    IAS_SYNTAX_UNSIGNEDINTEGER  = 0x00000009,
    IAS_SYNTAX_INETADDR6        = 0x0000000a,
}
alias ATTRIBUTESYNTAX = int;

enum : int
{
    MULTIVALUED             = 0x00000001,
    ALLOWEDINPROFILE        = 0x00000002,
    ALLOWEDINCONDITION      = 0x00000004,
    ALLOWEDINPROXYPROFILE   = 0x00000008,
    ALLOWEDINPROXYCONDITION = 0x00000010,
    ALLOWEDINVPNDIALUP      = 0x00000020,
    ALLOWEDIN8021X          = 0x00000040,
}
alias ATTRIBUTERESTRICTIONS = int;

enum : int
{
    ATTRIBUTE_FILTER_NONE        = 0x00000000,
    ATTRIBUTE_FILTER_VPN_DIALUP  = 0x00000001,
    ATTRIBUTE_FILTER_IEEE_802_1x = 0x00000002,
}
alias ATTRIBUTEFILTER = int;

enum : int
{
    NAME         = 0x00000001,
    SYNTAX       = 0x00000002,
    RESTRICTIONS = 0x00000003,
    DESCRIPTION  = 0x00000004,
    VENDORID     = 0x00000005,
    LDAPNAME     = 0x00000006,
    VENDORTYPE   = 0x00000007,
}
alias ATTRIBUTEINFO = int;

enum : int
{
    PROPERTY_SDO_RESERVED       = 0x00000000,
    PROPERTY_SDO_CLASS          = 0x00000001,
    PROPERTY_SDO_NAME           = 0x00000002,
    PROPERTY_SDO_DESCRIPTION    = 0x00000003,
    PROPERTY_SDO_ID             = 0x00000004,
    PROPERTY_SDO_DATASTORE_NAME = 0x00000005,
    PROPERTY_SDO_TEMPLATE_GUID  = 0x00000006,
    PROPERTY_SDO_OPAQUE         = 0x00000007,
    PROPERTY_SDO_START          = 0x00000400,
}
alias IASCOMMONPROPERTIES = int;

enum : int
{
    PROPERTY_USER_CALLING_STATION_ID               = 0x00000400,
    PROPERTY_USER_SAVED_CALLING_STATION_ID         = 0x00000401,
    PROPERTY_USER_RADIUS_CALLBACK_NUMBER           = 0x00000402,
    PROPERTY_USER_RADIUS_FRAMED_ROUTE              = 0x00000403,
    PROPERTY_USER_RADIUS_FRAMED_IP_ADDRESS         = 0x00000404,
    PROPERTY_USER_SAVED_RADIUS_CALLBACK_NUMBER     = 0x00000405,
    PROPERTY_USER_SAVED_RADIUS_FRAMED_ROUTE        = 0x00000406,
    PROPERTY_USER_SAVED_RADIUS_FRAMED_IP_ADDRESS   = 0x00000407,
    PROPERTY_USER_ALLOW_DIALIN                     = 0x00000408,
    PROPERTY_USER_SERVICE_TYPE                     = 0x00000409,
    PROPERTY_USER_RADIUS_FRAMED_IPV6_ROUTE         = 0x0000040a,
    PROPERTY_USER_SAVED_RADIUS_FRAMED_IPV6_ROUTE   = 0x0000040b,
    PROPERTY_USER_RADIUS_FRAMED_INTERFACE_ID       = 0x0000040c,
    PROPERTY_USER_SAVED_RADIUS_FRAMED_INTERFACE_ID = 0x0000040d,
    PROPERTY_USER_RADIUS_FRAMED_IPV6_PREFIX        = 0x0000040e,
    PROPERTY_USER_SAVED_RADIUS_FRAMED_IPV6_PREFIX  = 0x0000040f,
}
alias USERPROPERTIES = int;

enum : int
{
    PROPERTY_DICTIONARY_ATTRIBUTES_COLLECTION = 0x00000400,
    PROPERTY_DICTIONARY_LOCATION              = 0x00000401,
}
alias DICTIONARYPROPERTIES = int;

enum : int
{
    PROPERTY_ATTRIBUTE_ID                       = 0x00000400,
    PROPERTY_ATTRIBUTE_VENDOR_ID                = 0x00000401,
    PROPERTY_ATTRIBUTE_VENDOR_TYPE_ID           = 0x00000402,
    PROPERTY_ATTRIBUTE_IS_ENUMERABLE            = 0x00000403,
    PROPERTY_ATTRIBUTE_ENUM_NAMES               = 0x00000404,
    PROPERTY_ATTRIBUTE_ENUM_VALUES              = 0x00000405,
    PROPERTY_ATTRIBUTE_SYNTAX                   = 0x00000406,
    PROPERTY_ATTRIBUTE_ALLOW_MULTIPLE           = 0x00000407,
    PROPERTY_ATTRIBUTE_ALLOW_LOG_ORDINAL        = 0x00000408,
    PROPERTY_ATTRIBUTE_ALLOW_IN_PROFILE         = 0x00000409,
    PROPERTY_ATTRIBUTE_ALLOW_IN_CONDITION       = 0x0000040a,
    PROPERTY_ATTRIBUTE_DISPLAY_NAME             = 0x0000040b,
    PROPERTY_ATTRIBUTE_VALUE                    = 0x0000040c,
    PROPERTY_ATTRIBUTE_ALLOW_IN_PROXY_PROFILE   = 0x0000040d,
    PROPERTY_ATTRIBUTE_ALLOW_IN_PROXY_CONDITION = 0x0000040e,
    PROPERTY_ATTRIBUTE_ALLOW_IN_VPNDIALUP       = 0x0000040f,
    PROPERTY_ATTRIBUTE_ALLOW_IN_8021X           = 0x00000410,
    PROPERTY_ATTRIBUTE_ENUM_FILTERS             = 0x00000411,
}
alias ATTRIBUTEPROPERTIES = int;

enum : int
{
    PROPERTY_IAS_RADIUSSERVERGROUPS_COLLECTION      = 0x00000400,
    PROPERTY_IAS_POLICIES_COLLECTION                = 0x00000401,
    PROPERTY_IAS_PROFILES_COLLECTION                = 0x00000402,
    PROPERTY_IAS_PROTOCOLS_COLLECTION               = 0x00000403,
    PROPERTY_IAS_AUDITORS_COLLECTION                = 0x00000404,
    PROPERTY_IAS_REQUESTHANDLERS_COLLECTION         = 0x00000405,
    PROPERTY_IAS_PROXYPOLICIES_COLLECTION           = 0x00000406,
    PROPERTY_IAS_PROXYPROFILES_COLLECTION           = 0x00000407,
    PROPERTY_IAS_REMEDIATIONSERVERGROUPS_COLLECTION = 0x00000408,
    PROPERTY_IAS_SHVTEMPLATES_COLLECTION            = 0x00000409,
}
alias IASPROPERTIES = int;

enum : int
{
    PROPERTY_TEMPLATES_POLICIES_TEMPLATES                = 0x00000400,
    PROPERTY_TEMPLATES_PROFILES_TEMPLATES                = 0x00000401,
    PROPERTY_TEMPLATES_PROFILES_COLLECTION               = 0x00000402,
    PROPERTY_TEMPLATES_PROXYPOLICIES_TEMPLATES           = 0x00000403,
    PROPERTY_TEMPLATES_PROXYPROFILES_TEMPLATES           = 0x00000404,
    PROPERTY_TEMPLATES_PROXYPROFILES_COLLECTION          = 0x00000405,
    PROPERTY_TEMPLATES_REMEDIATIONSERVERGROUPS_TEMPLATES = 0x00000406,
    PROPERTY_TEMPLATES_SHVTEMPLATES_TEMPLATES            = 0x00000407,
    PROPERTY_TEMPLATES_CLIENTS_TEMPLATES                 = 0x00000408,
    PROPERTY_TEMPLATES_RADIUSSERVERS_TEMPLATES           = 0x00000409,
    PROPERTY_TEMPLATES_SHAREDSECRETS_TEMPLATES           = 0x0000040a,
    PROPERTY_TEMPLATES_IPFILTERS_TEMPLATES               = 0x0000040b,
}
alias TEMPLATESPROPERTIES = int;

enum : int
{
    PROPERTY_CLIENT_REQUIRE_SIGNATURE     = 0x00000400,
    PROPERTY_CLIENT_UNUSED                = 0x00000401,
    PROPERTY_CLIENT_SHARED_SECRET         = 0x00000402,
    PROPERTY_CLIENT_NAS_MANUFACTURER      = 0x00000403,
    PROPERTY_CLIENT_ADDRESS               = 0x00000404,
    PROPERTY_CLIENT_QUARANTINE_COMPATIBLE = 0x00000405,
    PROPERTY_CLIENT_ENABLED               = 0x00000406,
    PROPERTY_CLIENT_SECRET_TEMPLATE_GUID  = 0x00000407,
}
alias CLIENTPROPERTIES = int;

enum : int
{
    PROPERTY_NAS_VENDOR_ID = 0x00000400,
}
alias VENDORPROPERTIES = int;

enum : int
{
    PROPERTY_PROFILE_ATTRIBUTES_COLLECTION  = 0x00000400,
    PROPERTY_PROFILE_IPFILTER_TEMPLATE_GUID = 0x00000401,
}
alias PROFILEPROPERTIES = int;

enum : int
{
    PROPERTY_POLICY_CONSTRAINT            = 0x00000400,
    PROPERTY_POLICY_MERIT                 = 0x00000401,
    PROPERTY_POLICY_UNUSED0               = 0x00000402,
    PROPERTY_POLICY_UNUSED1               = 0x00000403,
    PROPERTY_POLICY_PROFILE_NAME          = 0x00000404,
    PROPERTY_POLICY_ACTION                = 0x00000405,
    PROPERTY_POLICY_CONDITIONS_COLLECTION = 0x00000406,
    PROPERTY_POLICY_ENABLED               = 0x00000407,
    PROPERTY_POLICY_SOURCETAG             = 0x00000408,
}
alias POLICYPROPERTIES = int;

enum : int
{
    PROPERTY_CONDITION_TEXT = 0x00000400,
}
alias CONDITIONPROPERTIES = int;

enum : int
{
    PROPERTY_RADIUSSERVERGROUP_SERVERS_COLLECTION = 0x00000400,
}
alias RADIUSSERVERGROUPPROPERTIES = int;

enum : int
{
    PROPERTY_RADIUSSERVER_AUTH_PORT                 = 0x00000400,
    PROPERTY_RADIUSSERVER_AUTH_SECRET               = 0x00000401,
    PROPERTY_RADIUSSERVER_ACCT_PORT                 = 0x00000402,
    PROPERTY_RADIUSSERVER_ACCT_SECRET               = 0x00000403,
    PROPERTY_RADIUSSERVER_ADDRESS                   = 0x00000404,
    PROPERTY_RADIUSSERVER_FORWARD_ACCT_ONOFF        = 0x00000405,
    PROPERTY_RADIUSSERVER_PRIORITY                  = 0x00000406,
    PROPERTY_RADIUSSERVER_WEIGHT                    = 0x00000407,
    PROPERTY_RADIUSSERVER_TIMEOUT                   = 0x00000408,
    PROPERTY_RADIUSSERVER_MAX_LOST                  = 0x00000409,
    PROPERTY_RADIUSSERVER_BLACKOUT                  = 0x0000040a,
    PROPERTY_RADIUSSERVER_SEND_SIGNATURE            = 0x0000040b,
    PROPERTY_RADIUSSERVER_AUTH_SECRET_TEMPLATE_GUID = 0x0000040c,
    PROPERTY_RADIUSSERVER_ACCT_SECRET_TEMPLATE_GUID = 0x0000040d,
}
alias RADIUSSERVERPROPERTIES = int;

enum : int
{
    PROPERTY_REMEDIATIONSERVERGROUP_SERVERS_COLLECTION = 0x00000400,
}
alias REMEDIATIONSERVERGROUPPROPERTIES = int;

enum : int
{
    PROPERTY_REMEDIATIONSERVER_ADDRESS       = 0x00000400,
    PROPERTY_REMEDIATIONSERVER_FRIENDLY_NAME = 0x00000401,
}
alias REMEDIATIONSERVERPROPERTIES = int;

enum : int
{
    PROPERTY_SHV_COMBINATION_TYPE = 0x00000400,
    PROPERTY_SHV_LIST             = 0x00000401,
    PROPERTY_SHVCONFIG_LIST       = 0x00000402,
}
alias SHVTEMPLATEPROPERTIES = int;

enum : int
{
    PROPERTY_IPFILTER_ATTRIBUTES_COLLECTION = 0x00000400,
}
alias IPFILTERPROPERTIES = int;

enum : int
{
    PROPERTY_SHAREDSECRET_STRING = 0x00000400,
}
alias SHAREDSECRETPROPERTIES = int;

enum : int
{
    PROPERTY_COMPONENT_ID      = 0x00000400,
    PROPERTY_COMPONENT_PROG_ID = 0x00000401,
    PROPERTY_COMPONENT_START   = 0x00000402,
}
alias IASCOMPONENTPROPERTIES = int;

enum : int
{
    PROPERTY_PROTOCOL_REQUEST_HANDLER = 0x00000402,
    PROPERTY_PROTOCOL_START           = 0x00000403,
}
alias PROTOCOLPROPERTIES = int;

enum : int
{
    PROPERTY_RADIUS_ACCOUNTING_PORT     = 0x00000403,
    PROPERTY_RADIUS_AUTHENTICATION_PORT = 0x00000404,
    PROPERTY_RADIUS_CLIENTS_COLLECTION  = 0x00000405,
    PROPERTY_RADIUS_VENDORS_COLLECTION  = 0x00000406,
}
alias RADIUSPROPERTIES = int;

enum : int
{
    PROPERTY_EVENTLOG_LOG_APPLICATION_EVENTS = 0x00000402,
    PROPERTY_EVENTLOG_LOG_MALFORMED          = 0x00000403,
    PROPERTY_EVENTLOG_LOG_DEBUG              = 0x00000404,
}
alias NTEVENTLOGPROPERTIES = int;

enum : int
{
    PROPERTY_NAMES_REALMS = 0x00000402,
}
alias NAMESPROPERTIES = int;

enum : int
{
    PROPERTY_NTSAM_ALLOW_LM_AUTHENTICATION = 0x00000402,
}
alias NTSAMPROPERTIES = int;

enum : int
{
    PROPERTY_ACCOUNTING_LOG_ACCOUNTING             = 0x00000402,
    PROPERTY_ACCOUNTING_LOG_ACCOUNTING_INTERIM     = 0x00000403,
    PROPERTY_ACCOUNTING_LOG_AUTHENTICATION         = 0x00000404,
    PROPERTY_ACCOUNTING_LOG_OPEN_NEW_FREQUENCY     = 0x00000405,
    PROPERTY_ACCOUNTING_LOG_OPEN_NEW_SIZE          = 0x00000406,
    PROPERTY_ACCOUNTING_LOG_FILE_DIRECTORY         = 0x00000407,
    PROPERTY_ACCOUNTING_LOG_IAS1_FORMAT            = 0x00000408,
    PROPERTY_ACCOUNTING_LOG_ENABLE_LOGGING         = 0x00000409,
    PROPERTY_ACCOUNTING_LOG_DELETE_IF_FULL         = 0x0000040a,
    PROPERTY_ACCOUNTING_SQL_MAX_SESSIONS           = 0x0000040b,
    PROPERTY_ACCOUNTING_LOG_AUTHENTICATION_INTERIM = 0x0000040c,
    PROPERTY_ACCOUNTING_LOG_FILE_IS_BACKUP         = 0x0000040d,
    PROPERTY_ACCOUNTING_DISCARD_REQUEST_ON_FAILURE = 0x0000040e,
}
alias ACCOUNTINGPROPERTIES = int;

enum : int
{
    PROPERTY_NAP_POLICIES_COLLECTION  = 0x00000402,
    PROPERTY_SHV_TEMPLATES_COLLECTION = 0x00000403,
}
alias NAPPROPERTIES = int;

enum : int
{
    PROPERTY_RADIUSPROXY_SERVERGROUPS = 0x00000402,
}
alias RADIUSPROXYPROPERTIES = int;

enum : int
{
    PROPERTY_REMEDIATIONSERVERS_SERVERGROUPS = 0x00000402,
}
alias REMEDIATIONSERVERSPROPERTIES = int;

enum : int
{
    SHV_COMBINATION_TYPE_ALL_PASS                 = 0x00000000,
    SHV_COMBINATION_TYPE_ALL_FAIL                 = 0x00000001,
    SHV_COMBINATION_TYPE_ONE_OR_MORE_PASS         = 0x00000002,
    SHV_COMBINATION_TYPE_ONE_OR_MORE_FAIL         = 0x00000003,
    SHV_COMBINATION_TYPE_ONE_OR_MORE_INFECTED     = 0x00000004,
    SHV_COMBINATION_TYPE_ONE_OR_MORE_TRANSITIONAL = 0x00000005,
    SHV_COMBINATION_TYPE_ONE_OR_MORE_UNKNOWN      = 0x00000006,
    SHV_COMBINATION_TYPE_MAX                      = 0x00000007,
}
alias SHV_COMBINATION_TYPE = int;

enum : int
{
    SERVICE_TYPE_IAS       = 0x00000000,
    SERVICE_TYPE_RAS       = 0x00000001,
    SERVICE_TYPE_RAMGMTSVC = 0x00000002,
    SERVICE_TYPE_MAX       = 0x00000003,
}
alias SERVICE_TYPE = int;

enum : int
{
    SYSTEM_TYPE_NT4_WORKSTATION    = 0x00000000,
    SYSTEM_TYPE_NT5_WORKSTATION    = 0x00000001,
    SYSTEM_TYPE_NT6_WORKSTATION    = 0x00000002,
    SYSTEM_TYPE_NT6_1_WORKSTATION  = 0x00000003,
    SYSTEM_TYPE_NT6_2_WORKSTATION  = 0x00000004,
    SYSTEM_TYPE_NT6_3_WORKSTATION  = 0x00000005,
    SYSTEM_TYPE_NT10_0_WORKSTATION = 0x00000006,
    SYSTEM_TYPE_NT4_SERVER         = 0x00000007,
    SYSTEM_TYPE_NT5_SERVER         = 0x00000008,
    SYSTEM_TYPE_NT6_SERVER         = 0x00000009,
    SYSTEM_TYPE_NT6_1_SERVER       = 0x0000000a,
    SYSTEM_TYPE_NT6_2_SERVER       = 0x0000000b,
    SYSTEM_TYPE_NT6_3_SERVER       = 0x0000000c,
    SYSTEM_TYPE_NT10_0_SERVER      = 0x0000000d,
}
alias IASOSTYPE = int;

enum : int
{
    DOMAIN_TYPE_NONE  = 0x00000000,
    DOMAIN_TYPE_NT4   = 0x00000001,
    DOMAIN_TYPE_NT5   = 0x00000002,
    DOMAIN_TYPE_MIXED = 0x00000003,
}
alias IASDOMAINTYPE = int;

enum : int
{
    DATA_STORE_LOCAL     = 0x00000000,
    DATA_STORE_DIRECTORY = 0x00000001,
}
alias IASDATASTORE = int;

enum : int
{
    ratMinimum                = 0x00000000,
    ratUserName               = 0x00000001,
    ratUserPassword           = 0x00000002,
    ratCHAPPassword           = 0x00000003,
    ratNASIPAddress           = 0x00000004,
    ratNASPort                = 0x00000005,
    ratServiceType            = 0x00000006,
    ratFramedProtocol         = 0x00000007,
    ratFramedIPAddress        = 0x00000008,
    ratFramedIPNetmask        = 0x00000009,
    ratFramedRouting          = 0x0000000a,
    ratFilterId               = 0x0000000b,
    ratFramedMTU              = 0x0000000c,
    ratFramedCompression      = 0x0000000d,
    ratLoginIPHost            = 0x0000000e,
    ratLoginService           = 0x0000000f,
    ratLoginPort              = 0x00000010,
    ratReplyMessage           = 0x00000012,
    ratCallbackNumber         = 0x00000013,
    ratCallbackId             = 0x00000014,
    ratFramedRoute            = 0x00000016,
    ratFramedIPXNetwork       = 0x00000017,
    ratState                  = 0x00000018,
    ratClass                  = 0x00000019,
    ratVendorSpecific         = 0x0000001a,
    ratSessionTimeout         = 0x0000001b,
    ratIdleTimeout            = 0x0000001c,
    ratTerminationAction      = 0x0000001d,
    ratCalledStationId        = 0x0000001e,
    ratCallingStationId       = 0x0000001f,
    ratNASIdentifier          = 0x00000020,
    ratProxyState             = 0x00000021,
    ratLoginLATService        = 0x00000022,
    ratLoginLATNode           = 0x00000023,
    ratLoginLATGroup          = 0x00000024,
    ratFramedAppleTalkLink    = 0x00000025,
    ratFramedAppleTalkNetwork = 0x00000026,
    ratFramedAppleTalkZone    = 0x00000027,
    ratAcctStatusType         = 0x00000028,
    ratAcctDelayTime          = 0x00000029,
    ratAcctInputOctets        = 0x0000002a,
    ratAcctOutputOctets       = 0x0000002b,
    ratAcctSessionId          = 0x0000002c,
    ratAcctAuthentic          = 0x0000002d,
    ratAcctSessionTime        = 0x0000002e,
    ratAcctInputPackets       = 0x0000002f,
    ratAcctOutputPackets      = 0x00000030,
    ratAcctTerminationCause   = 0x00000031,
    ratCHAPChallenge          = 0x0000003c,
    ratNASPortType            = 0x0000003d,
    ratPortLimit              = 0x0000003e,
    ratTunnelType             = 0x00000040,
    ratMediumType             = 0x00000041,
    ratTunnelPassword         = 0x00000045,
    ratTunnelPrivateGroupID   = 0x00000051,
    ratNASIPv6Address         = 0x0000005f,
    ratFramedInterfaceId      = 0x00000060,
    ratFramedIPv6Prefix       = 0x00000061,
    ratLoginIPv6Host          = 0x00000062,
    ratFramedIPv6Route        = 0x00000063,
    ratFramedIPv6Pool         = 0x00000064,
    ratCode                   = 0x00000106,
    ratIdentifier             = 0x00000107,
    ratAuthenticator          = 0x00000108,
    ratSrcIPAddress           = 0x00000109,
    ratSrcPort                = 0x0000010a,
    ratProvider               = 0x0000010b,
    ratStrippedUserName       = 0x0000010c,
    ratFQUserName             = 0x0000010d,
    ratPolicyName             = 0x0000010e,
    ratUniqueId               = 0x0000010f,
    ratExtensionState         = 0x00000110,
    ratEAPTLV                 = 0x00000111,
    ratRejectReasonCode       = 0x00000112,
    ratCRPPolicyName          = 0x00000113,
    ratProviderName           = 0x00000114,
    ratClearTextPassword      = 0x00000115,
    ratSrcIPv6Address         = 0x00000116,
    ratCertificateThumbprint  = 0x00000117,
}
alias RADIUS_ATTRIBUTE_TYPE = int;

enum : int
{
    rcUnknown            = 0x00000000,
    rcAccessRequest      = 0x00000001,
    rcAccessAccept       = 0x00000002,
    rcAccessReject       = 0x00000003,
    rcAccountingRequest  = 0x00000004,
    rcAccountingResponse = 0x00000005,
    rcAccessChallenge    = 0x0000000b,
    rcDiscard            = 0x00000100,
}
alias RADIUS_CODE = int;

enum : int
{
    rapUnknown   = 0x00000000,
    rapUsersFile = 0x00000001,
    rapProxy     = 0x00000002,
    rapWindowsNT = 0x00000003,
    rapMCIS      = 0x00000004,
    rapODBC      = 0x00000005,
    rapNone      = 0x00000006,
}
alias RADIUS_AUTHENTICATION_PROVIDER = int;

enum : int
{
    rrrcUndefined             = 0x00000000,
    rrrcAccountUnknown        = 0x00000001,
    rrrcAccountDisabled       = 0x00000002,
    rrrcAccountExpired        = 0x00000003,
    rrrcAuthenticationFailure = 0x00000004,
}
alias RADIUS_REJECT_REASON_CODE = int;

enum : int
{
    rdtUnknown     = 0x00000000,
    rdtString      = 0x00000001,
    rdtAddress     = 0x00000002,
    rdtInteger     = 0x00000003,
    rdtTime        = 0x00000004,
    rdtIpv6Address = 0x00000005,
}
alias RADIUS_DATA_TYPE = int;

enum : int
{
    raContinue = 0x00000000,
    raReject   = 0x00000001,
    raAccept   = 0x00000002,
}
alias RADIUS_ACTION = int;

enum : int
{
    repAuthentication = 0x00000000,
    repAuthorization  = 0x00000001,
}
alias RADIUS_EXTENSION_POINT = int;

// Callbacks

alias PRADIUS_EXTENSION_INIT = uint function();
alias PRADIUS_EXTENSION_TERM = void function();
alias PRADIUS_EXTENSION_PROCESS = uint function(const(RADIUS_ATTRIBUTE)* pAttrs, RADIUS_ACTION* pfAction);
alias PRADIUS_EXTENSION_PROCESS_EX = uint function(const(RADIUS_ATTRIBUTE)* pInAttrs, RADIUS_ATTRIBUTE** pOutAttrs, 
                                                   RADIUS_ACTION* pfAction);
alias PRADIUS_EXTENSION_FREE_ATTRIBUTES = void function(RADIUS_ATTRIBUTE* pAttrs);
alias PRADIUS_EXTENSION_PROCESS_2 = uint function(RADIUS_EXTENSION_CONTROL_BLOCK* pECB);

// Structs


struct RADIUS_ATTRIBUTE
{
    uint             dwAttrType;
    RADIUS_DATA_TYPE fDataType;
    uint             cbDataLength;
    union
    {
        uint          dwValue;
        const(ubyte)* lpValue;
    }
}

struct RADIUS_VSA_FORMAT
{
    ubyte[4] VendorId;
    ubyte    VendorType;
    ubyte    VendorLength;
    ubyte[1] AttributeSpecific;
}

struct RADIUS_ATTRIBUTE_ARRAY
{
    uint             cbSize;
    ptrdiff_t        Add;
    const(ptrdiff_t) AttributeAt;
    ptrdiff_t        GetSize;
    ptrdiff_t        InsertAt;
    ptrdiff_t        RemoveAt;
    ptrdiff_t        SetAt;
}

struct RADIUS_EXTENSION_CONTROL_BLOCK
{
    uint        cbSize;
    uint        dwVersion;
    RADIUS_EXTENSION_POINT repPoint;
    RADIUS_CODE rcRequestType;
    RADIUS_CODE rcResponseType;
    ptrdiff_t   GetRequest;
    ptrdiff_t   GetResponse;
    ptrdiff_t   SetResponseType;
}

// Interfaces

@GUID("E9218AE7-9E91-11D1-BF60-0080C7846BC0")
struct SdoMachine;

@GUID("479F6E75-49A2-11D2-8ECA-00C04FC2F519")
interface ISdoMachine : IDispatch
{
    HRESULT Attach(BSTR bstrComputerName);
    HRESULT GetDictionarySDO(IUnknown* ppDictionarySDO);
    HRESULT GetServiceSDO(IASDATASTORE eDataStore, BSTR bstrServiceName, IUnknown* ppServiceSDO);
    HRESULT GetUserSDO(IASDATASTORE eDataStore, BSTR bstrUserName, IUnknown* ppUserSDO);
    HRESULT GetOSType(IASOSTYPE* eOSType);
    HRESULT GetDomainType(IASDOMAINTYPE* eDomainType);
    HRESULT IsDirectoryAvailable(short* boolDirectoryAvailable);
    HRESULT GetAttachedComputer(BSTR* bstrComputerName);
    HRESULT GetSDOSchema(IUnknown* ppSDOSchema);
}

@GUID("518E5FFE-D8CE-4F7E-A5DB-B40A35419D3B")
interface ISdoMachine2 : ISdoMachine
{
    HRESULT GetTemplatesSDO(BSTR bstrServiceName, IUnknown* ppTemplatesSDO);
    HRESULT EnableTemplates();
    HRESULT SyncConfigAgainstTemplates(BSTR bstrServiceName, IUnknown* ppConfigRoot, IUnknown* ppTemplatesRoot, 
                                       short bForcedSync);
    HRESULT ImportRemoteTemplates(IUnknown pLocalTemplatesRoot, BSTR bstrRemoteMachineName);
    HRESULT Reload();
}

@GUID("479F6E74-49A2-11D2-8ECA-00C04FC2F519")
interface ISdoServiceControl : IDispatch
{
    HRESULT StartServiceA();
    HRESULT StopService();
    HRESULT GetServiceStatus(int* status);
    HRESULT ResetService();
}

@GUID("56BC53DE-96DB-11D1-BF3F-000000000000")
interface ISdo : IDispatch
{
    HRESULT GetPropertyInfo(int Id, IUnknown* ppPropertyInfo);
    HRESULT GetProperty(int Id, VARIANT* pValue);
    HRESULT PutProperty(int Id, VARIANT* pValue);
    HRESULT ResetProperty(int Id);
    HRESULT Apply();
    HRESULT Restore();
    HRESULT get__NewEnum(IUnknown* ppEnumVARIANT);
}

@GUID("56BC53E2-96DB-11D1-BF3F-000000000000")
interface ISdoCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT Add(BSTR bstrName, IDispatch* ppItem);
    HRESULT Remove(IDispatch pItem);
    HRESULT RemoveAll();
    HRESULT Reload();
    HRESULT IsNameUnique(BSTR bstrName, short* pBool);
    HRESULT Item(VARIANT* Name, IDispatch* pItem);
    HRESULT get__NewEnum(IUnknown* ppEnumVARIANT);
}

@GUID("8AA85302-D2E2-4E20-8B1F-A571E437D6C9")
interface ITemplateSdo : ISdo
{
    HRESULT AddToCollection(BSTR bstrName, IDispatch pCollection, IDispatch* ppItem);
    HRESULT AddToSdo(BSTR bstrName, IDispatch pSdoTarget, IDispatch* ppItem);
    HRESULT AddToSdoAsProperty(IDispatch pSdoTarget, int id);
}

@GUID("D432E5F4-53D8-11D2-9A3A-00C04FB998AC")
interface ISdoDictionaryOld : IDispatch
{
    HRESULT EnumAttributes(VARIANT* Id, VARIANT* pValues);
    HRESULT GetAttributeInfo(ATTRIBUTEID Id, VARIANT* pInfoIDs, VARIANT* pInfoValues);
    HRESULT EnumAttributeValues(ATTRIBUTEID Id, VARIANT* pValueIds, VARIANT* pValuesDesc);
    HRESULT CreateAttribute(ATTRIBUTEID Id, IDispatch* ppAttributeObject);
    HRESULT GetAttributeID(BSTR bstrAttributeName, ATTRIBUTEID* pId);
}


// GUIDs

const GUID CLSID_SdoMachine = GUIDOF!SdoMachine;

const GUID IID_ISdo               = GUIDOF!ISdo;
const GUID IID_ISdoCollection     = GUIDOF!ISdoCollection;
const GUID IID_ISdoDictionaryOld  = GUIDOF!ISdoDictionaryOld;
const GUID IID_ISdoMachine        = GUIDOF!ISdoMachine;
const GUID IID_ISdoMachine2       = GUIDOF!ISdoMachine2;
const GUID IID_ISdoServiceControl = GUIDOF!ISdoServiceControl;
const GUID IID_ITemplateSdo       = GUIDOF!ITemplateSdo;
