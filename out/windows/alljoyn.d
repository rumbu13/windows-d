module windows.alljoyn;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, SECURITY_ATTRIBUTES;

extern(Windows):


// Enums


enum : int
{
    UNANNOUNCED = 0x00000000,
    ANNOUNCED   = 0x00000001,
}
alias alljoyn_about_announceflag = int;

enum QStatus : int
{
    ER_OK                                                               = 0x00000000,
    ER_FAIL                                                             = 0x00000001,
    ER_UTF_CONVERSION_FAILED                                            = 0x00000002,
    ER_BUFFER_TOO_SMALL                                                 = 0x00000003,
    ER_OS_ERROR                                                         = 0x00000004,
    ER_OUT_OF_MEMORY                                                    = 0x00000005,
    ER_SOCKET_BIND_ERROR                                                = 0x00000006,
    ER_INIT_FAILED                                                      = 0x00000007,
    ER_WOULDBLOCK                                                       = 0x00000008,
    ER_NOT_IMPLEMENTED                                                  = 0x00000009,
    ER_TIMEOUT                                                          = 0x0000000a,
    ER_SOCK_OTHER_END_CLOSED                                            = 0x0000000b,
    ER_BAD_ARG_1                                                        = 0x0000000c,
    ER_BAD_ARG_2                                                        = 0x0000000d,
    ER_BAD_ARG_3                                                        = 0x0000000e,
    ER_BAD_ARG_4                                                        = 0x0000000f,
    ER_BAD_ARG_5                                                        = 0x00000010,
    ER_BAD_ARG_6                                                        = 0x00000011,
    ER_BAD_ARG_7                                                        = 0x00000012,
    ER_BAD_ARG_8                                                        = 0x00000013,
    ER_INVALID_ADDRESS                                                  = 0x00000014,
    ER_INVALID_DATA                                                     = 0x00000015,
    ER_READ_ERROR                                                       = 0x00000016,
    ER_WRITE_ERROR                                                      = 0x00000017,
    ER_OPEN_FAILED                                                      = 0x00000018,
    ER_PARSE_ERROR                                                      = 0x00000019,
    ER_END_OF_DATA                                                      = 0x0000001a,
    ER_CONN_REFUSED                                                     = 0x0000001b,
    ER_BAD_ARG_COUNT                                                    = 0x0000001c,
    ER_WARNING                                                          = 0x0000001d,
    ER_EOF                                                              = 0x0000001e,
    ER_DEADLOCK                                                         = 0x0000001f,
    ER_COMMON_ERRORS                                                    = 0x00001000,
    ER_STOPPING_THREAD                                                  = 0x00001001,
    ER_ALERTED_THREAD                                                   = 0x00001002,
    ER_XML_MALFORMED                                                    = 0x00001003,
    ER_AUTH_FAIL                                                        = 0x00001004,
    ER_AUTH_USER_REJECT                                                 = 0x00001005,
    ER_NO_SUCH_ALARM                                                    = 0x00001006,
    ER_TIMER_FALLBEHIND                                                 = 0x00001007,
    ER_SSL_ERRORS                                                       = 0x00001008,
    ER_SSL_INIT                                                         = 0x00001009,
    ER_SSL_CONNECT                                                      = 0x0000100a,
    ER_SSL_VERIFY                                                       = 0x0000100b,
    ER_EXTERNAL_THREAD                                                  = 0x0000100c,
    ER_CRYPTO_ERROR                                                     = 0x0000100d,
    ER_CRYPTO_TRUNCATED                                                 = 0x0000100e,
    ER_CRYPTO_KEY_UNAVAILABLE                                           = 0x0000100f,
    ER_BAD_HOSTNAME                                                     = 0x00001010,
    ER_CRYPTO_KEY_UNUSABLE                                              = 0x00001011,
    ER_EMPTY_KEY_BLOB                                                   = 0x00001012,
    ER_CORRUPT_KEYBLOB                                                  = 0x00001013,
    ER_INVALID_KEY_ENCODING                                             = 0x00001014,
    ER_DEAD_THREAD                                                      = 0x00001015,
    ER_THREAD_RUNNING                                                   = 0x00001016,
    ER_THREAD_STOPPING                                                  = 0x00001017,
    ER_BAD_STRING_ENCODING                                              = 0x00001018,
    ER_CRYPTO_INSUFFICIENT_SECURITY                                     = 0x00001019,
    ER_CRYPTO_ILLEGAL_PARAMETERS                                        = 0x0000101a,
    ER_CRYPTO_HASH_UNINITIALIZED                                        = 0x0000101b,
    ER_THREAD_NO_WAIT                                                   = 0x0000101c,
    ER_TIMER_EXITING                                                    = 0x0000101d,
    ER_INVALID_GUID                                                     = 0x0000101e,
    ER_THREADPOOL_EXHAUSTED                                             = 0x0000101f,
    ER_THREADPOOL_STOPPING                                              = 0x00001020,
    ER_INVALID_STREAM                                                   = 0x00001021,
    ER_TIMER_FULL                                                       = 0x00001022,
    ER_IODISPATCH_STOPPING                                              = 0x00001023,
    ER_SLAP_INVALID_PACKET_LEN                                          = 0x00001024,
    ER_SLAP_HDR_CHECKSUM_ERROR                                          = 0x00001025,
    ER_SLAP_INVALID_PACKET_TYPE                                         = 0x00001026,
    ER_SLAP_LEN_MISMATCH                                                = 0x00001027,
    ER_SLAP_PACKET_TYPE_MISMATCH                                        = 0x00001028,
    ER_SLAP_CRC_ERROR                                                   = 0x00001029,
    ER_SLAP_ERROR                                                       = 0x0000102a,
    ER_SLAP_OTHER_END_CLOSED                                            = 0x0000102b,
    ER_TIMER_NOT_ALLOWED                                                = 0x0000102c,
    ER_NOT_CONN                                                         = 0x0000102d,
    ER_XML_CONVERTER_ERROR                                              = 0x00002000,
    ER_XML_INVALID_RULES_COUNT                                          = 0x00002001,
    ER_XML_INTERFACE_MEMBERS_MISSING                                    = 0x00002002,
    ER_XML_INVALID_MEMBER_TYPE                                          = 0x00002003,
    ER_XML_INVALID_MEMBER_ACTION                                        = 0x00002004,
    ER_XML_MEMBER_DENY_ACTION_WITH_OTHER                                = 0x00002005,
    ER_XML_INVALID_ANNOTATIONS_COUNT                                    = 0x00002006,
    ER_XML_INVALID_ELEMENT_NAME                                         = 0x00002007,
    ER_XML_INVALID_ATTRIBUTE_VALUE                                      = 0x00002008,
    ER_XML_INVALID_SECURITY_LEVEL_ANNOTATION_VALUE                      = 0x00002009,
    ER_XML_INVALID_ELEMENT_CHILDREN_COUNT                               = 0x0000200a,
    ER_XML_INVALID_POLICY_VERSION                                       = 0x0000200b,
    ER_XML_INVALID_POLICY_SERIAL_NUMBER                                 = 0x0000200c,
    ER_XML_INVALID_ACL_PEER_TYPE                                        = 0x0000200d,
    ER_XML_INVALID_ACL_PEER_CHILDREN_COUNT                              = 0x0000200e,
    ER_XML_ACL_ALL_TYPE_PEER_WITH_OTHERS                                = 0x0000200f,
    ER_XML_INVALID_ACL_PEER_PUBLIC_KEY                                  = 0x00002010,
    ER_XML_ACL_PEER_NOT_UNIQUE                                          = 0x00002011,
    ER_XML_ACL_PEER_PUBLIC_KEY_SET                                      = 0x00002012,
    ER_XML_ACLS_MISSING                                                 = 0x00002013,
    ER_XML_ACL_PEERS_MISSING                                            = 0x00002014,
    ER_XML_INVALID_OBJECT_PATH                                          = 0x00002015,
    ER_XML_INVALID_INTERFACE_NAME                                       = 0x00002016,
    ER_XML_INVALID_MEMBER_NAME                                          = 0x00002017,
    ER_XML_INVALID_MANIFEST_VERSION                                     = 0x00002018,
    ER_XML_INVALID_OID                                                  = 0x00002019,
    ER_XML_INVALID_BASE64                                               = 0x0000201a,
    ER_XML_INTERFACE_NAME_NOT_UNIQUE                                    = 0x0000201b,
    ER_XML_MEMBER_NAME_NOT_UNIQUE                                       = 0x0000201c,
    ER_XML_OBJECT_PATH_NOT_UNIQUE                                       = 0x0000201d,
    ER_XML_ANNOTATION_NOT_UNIQUE                                        = 0x0000201e,
    ER_NONE                                                             = 0x0000ffff,
    ER_BUS_ERRORS                                                       = 0x00009000,
    ER_BUS_READ_ERROR                                                   = 0x00009001,
    ER_BUS_WRITE_ERROR                                                  = 0x00009002,
    ER_BUS_BAD_VALUE_TYPE                                               = 0x00009003,
    ER_BUS_BAD_HEADER_FIELD                                             = 0x00009004,
    ER_BUS_BAD_SIGNATURE                                                = 0x00009005,
    ER_BUS_BAD_OBJ_PATH                                                 = 0x00009006,
    ER_BUS_BAD_MEMBER_NAME                                              = 0x00009007,
    ER_BUS_BAD_INTERFACE_NAME                                           = 0x00009008,
    ER_BUS_BAD_ERROR_NAME                                               = 0x00009009,
    ER_BUS_BAD_BUS_NAME                                                 = 0x0000900a,
    ER_BUS_NAME_TOO_LONG                                                = 0x0000900b,
    ER_BUS_BAD_LENGTH                                                   = 0x0000900c,
    ER_BUS_BAD_VALUE                                                    = 0x0000900d,
    ER_BUS_BAD_HDR_FLAGS                                                = 0x0000900e,
    ER_BUS_BAD_BODY_LEN                                                 = 0x0000900f,
    ER_BUS_BAD_HEADER_LEN                                               = 0x00009010,
    ER_BUS_UNKNOWN_SERIAL                                               = 0x00009011,
    ER_BUS_UNKNOWN_PATH                                                 = 0x00009012,
    ER_BUS_UNKNOWN_INTERFACE                                            = 0x00009013,
    ER_BUS_ESTABLISH_FAILED                                             = 0x00009014,
    ER_BUS_UNEXPECTED_SIGNATURE                                         = 0x00009015,
    ER_BUS_INTERFACE_MISSING                                            = 0x00009016,
    ER_BUS_PATH_MISSING                                                 = 0x00009017,
    ER_BUS_MEMBER_MISSING                                               = 0x00009018,
    ER_BUS_REPLY_SERIAL_MISSING                                         = 0x00009019,
    ER_BUS_ERROR_NAME_MISSING                                           = 0x0000901a,
    ER_BUS_INTERFACE_NO_SUCH_MEMBER                                     = 0x0000901b,
    ER_BUS_NO_SUCH_OBJECT                                               = 0x0000901c,
    ER_BUS_OBJECT_NO_SUCH_MEMBER                                        = 0x0000901d,
    ER_BUS_OBJECT_NO_SUCH_INTERFACE                                     = 0x0000901e,
    ER_BUS_NO_SUCH_INTERFACE                                            = 0x0000901f,
    ER_BUS_MEMBER_NO_SUCH_SIGNATURE                                     = 0x00009020,
    ER_BUS_NOT_NUL_TERMINATED                                           = 0x00009021,
    ER_BUS_NO_SUCH_PROPERTY                                             = 0x00009022,
    ER_BUS_SET_WRONG_SIGNATURE                                          = 0x00009023,
    ER_BUS_PROPERTY_VALUE_NOT_SET                                       = 0x00009024,
    ER_BUS_PROPERTY_ACCESS_DENIED                                       = 0x00009025,
    ER_BUS_NO_TRANSPORTS                                                = 0x00009026,
    ER_BUS_BAD_TRANSPORT_ARGS                                           = 0x00009027,
    ER_BUS_NO_ROUTE                                                     = 0x00009028,
    ER_BUS_NO_ENDPOINT                                                  = 0x00009029,
    ER_BUS_BAD_SEND_PARAMETER                                           = 0x0000902a,
    ER_BUS_UNMATCHED_REPLY_SERIAL                                       = 0x0000902b,
    ER_BUS_BAD_SENDER_ID                                                = 0x0000902c,
    ER_BUS_TRANSPORT_NOT_STARTED                                        = 0x0000902d,
    ER_BUS_EMPTY_MESSAGE                                                = 0x0000902e,
    ER_BUS_NOT_OWNER                                                    = 0x0000902f,
    ER_BUS_SET_PROPERTY_REJECTED                                        = 0x00009030,
    ER_BUS_CONNECT_FAILED                                               = 0x00009031,
    ER_BUS_REPLY_IS_ERROR_MESSAGE                                       = 0x00009032,
    ER_BUS_NOT_AUTHENTICATING                                           = 0x00009033,
    ER_BUS_NO_LISTENER                                                  = 0x00009034,
    ER_BUS_NOT_ALLOWED                                                  = 0x00009036,
    ER_BUS_WRITE_QUEUE_FULL                                             = 0x00009037,
    ER_BUS_ENDPOINT_CLOSING                                             = 0x00009038,
    ER_BUS_INTERFACE_MISMATCH                                           = 0x00009039,
    ER_BUS_MEMBER_ALREADY_EXISTS                                        = 0x0000903a,
    ER_BUS_PROPERTY_ALREADY_EXISTS                                      = 0x0000903b,
    ER_BUS_IFACE_ALREADY_EXISTS                                         = 0x0000903c,
    ER_BUS_ERROR_RESPONSE                                               = 0x0000903d,
    ER_BUS_BAD_XML                                                      = 0x0000903e,
    ER_BUS_BAD_CHILD_PATH                                               = 0x0000903f,
    ER_BUS_OBJ_ALREADY_EXISTS                                           = 0x00009040,
    ER_BUS_OBJ_NOT_FOUND                                                = 0x00009041,
    ER_BUS_CANNOT_EXPAND_MESSAGE                                        = 0x00009042,
    ER_BUS_NOT_COMPRESSED                                               = 0x00009043,
    ER_BUS_ALREADY_CONNECTED                                            = 0x00009044,
    ER_BUS_NOT_CONNECTED                                                = 0x00009045,
    ER_BUS_ALREADY_LISTENING                                            = 0x00009046,
    ER_BUS_KEY_UNAVAILABLE                                              = 0x00009047,
    ER_BUS_TRUNCATED                                                    = 0x00009048,
    ER_BUS_KEY_STORE_NOT_LOADED                                         = 0x00009049,
    ER_BUS_NO_AUTHENTICATION_MECHANISM                                  = 0x0000904a,
    ER_BUS_BUS_ALREADY_STARTED                                          = 0x0000904b,
    ER_BUS_BUS_NOT_STARTED                                              = 0x0000904c,
    ER_BUS_KEYBLOB_OP_INVALID                                           = 0x0000904d,
    ER_BUS_INVALID_HEADER_CHECKSUM                                      = 0x0000904e,
    ER_BUS_MESSAGE_NOT_ENCRYPTED                                        = 0x0000904f,
    ER_BUS_INVALID_HEADER_SERIAL                                        = 0x00009050,
    ER_BUS_TIME_TO_LIVE_EXPIRED                                         = 0x00009051,
    ER_BUS_HDR_EXPANSION_INVALID                                        = 0x00009052,
    ER_BUS_MISSING_COMPRESSION_TOKEN                                    = 0x00009053,
    ER_BUS_NO_PEER_GUID                                                 = 0x00009054,
    ER_BUS_MESSAGE_DECRYPTION_FAILED                                    = 0x00009055,
    ER_BUS_SECURITY_FATAL                                               = 0x00009056,
    ER_BUS_KEY_EXPIRED                                                  = 0x00009057,
    ER_BUS_CORRUPT_KEYSTORE                                             = 0x00009058,
    ER_BUS_NO_CALL_FOR_REPLY                                            = 0x00009059,
    ER_BUS_NOT_A_COMPLETE_TYPE                                          = 0x0000905a,
    ER_BUS_POLICY_VIOLATION                                             = 0x0000905b,
    ER_BUS_NO_SUCH_SERVICE                                              = 0x0000905c,
    ER_BUS_TRANSPORT_NOT_AVAILABLE                                      = 0x0000905d,
    ER_BUS_INVALID_AUTH_MECHANISM                                       = 0x0000905e,
    ER_BUS_KEYSTORE_VERSION_MISMATCH                                    = 0x0000905f,
    ER_BUS_BLOCKING_CALL_NOT_ALLOWED                                    = 0x00009060,
    ER_BUS_SIGNATURE_MISMATCH                                           = 0x00009061,
    ER_BUS_STOPPING                                                     = 0x00009062,
    ER_BUS_METHOD_CALL_ABORTED                                          = 0x00009063,
    ER_BUS_CANNOT_ADD_INTERFACE                                         = 0x00009064,
    ER_BUS_CANNOT_ADD_HANDLER                                           = 0x00009065,
    ER_BUS_KEYSTORE_NOT_LOADED                                          = 0x00009066,
    ER_BUS_NO_SUCH_HANDLE                                               = 0x0000906b,
    ER_BUS_HANDLES_NOT_ENABLED                                          = 0x0000906c,
    ER_BUS_HANDLES_MISMATCH                                             = 0x0000906d,
    ER_BUS_NO_SESSION                                                   = 0x0000906f,
    ER_BUS_ELEMENT_NOT_FOUND                                            = 0x00009070,
    ER_BUS_NOT_A_DICTIONARY                                             = 0x00009071,
    ER_BUS_WAIT_FAILED                                                  = 0x00009072,
    ER_BUS_BAD_SESSION_OPTS                                             = 0x00009074,
    ER_BUS_CONNECTION_REJECTED                                          = 0x00009075,
    ER_DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER                            = 0x00009076,
    ER_DBUS_REQUEST_NAME_REPLY_IN_QUEUE                                 = 0x00009077,
    ER_DBUS_REQUEST_NAME_REPLY_EXISTS                                   = 0x00009078,
    ER_DBUS_REQUEST_NAME_REPLY_ALREADY_OWNER                            = 0x00009079,
    ER_DBUS_RELEASE_NAME_REPLY_RELEASED                                 = 0x0000907a,
    ER_DBUS_RELEASE_NAME_REPLY_NON_EXISTENT                             = 0x0000907b,
    ER_DBUS_RELEASE_NAME_REPLY_NOT_OWNER                                = 0x0000907c,
    ER_DBUS_START_REPLY_ALREADY_RUNNING                                 = 0x0000907e,
    ER_ALLJOYN_BINDSESSIONPORT_REPLY_ALREADY_EXISTS                     = 0x00009080,
    ER_ALLJOYN_BINDSESSIONPORT_REPLY_FAILED                             = 0x00009081,
    ER_ALLJOYN_JOINSESSION_REPLY_NO_SESSION                             = 0x00009083,
    ER_ALLJOYN_JOINSESSION_REPLY_UNREACHABLE                            = 0x00009084,
    ER_ALLJOYN_JOINSESSION_REPLY_CONNECT_FAILED                         = 0x00009085,
    ER_ALLJOYN_JOINSESSION_REPLY_REJECTED                               = 0x00009086,
    ER_ALLJOYN_JOINSESSION_REPLY_BAD_SESSION_OPTS                       = 0x00009087,
    ER_ALLJOYN_JOINSESSION_REPLY_FAILED                                 = 0x00009088,
    ER_ALLJOYN_LEAVESESSION_REPLY_NO_SESSION                            = 0x0000908a,
    ER_ALLJOYN_LEAVESESSION_REPLY_FAILED                                = 0x0000908b,
    ER_ALLJOYN_ADVERTISENAME_REPLY_TRANSPORT_NOT_AVAILABLE              = 0x0000908c,
    ER_ALLJOYN_ADVERTISENAME_REPLY_ALREADY_ADVERTISING                  = 0x0000908d,
    ER_ALLJOYN_ADVERTISENAME_REPLY_FAILED                               = 0x0000908e,
    ER_ALLJOYN_CANCELADVERTISENAME_REPLY_FAILED                         = 0x00009090,
    ER_ALLJOYN_FINDADVERTISEDNAME_REPLY_TRANSPORT_NOT_AVAILABLE         = 0x00009091,
    ER_ALLJOYN_FINDADVERTISEDNAME_REPLY_ALREADY_DISCOVERING             = 0x00009092,
    ER_ALLJOYN_FINDADVERTISEDNAME_REPLY_FAILED                          = 0x00009093,
    ER_ALLJOYN_CANCELFINDADVERTISEDNAME_REPLY_FAILED                    = 0x00009095,
    ER_BUS_UNEXPECTED_DISPOSITION                                       = 0x00009096,
    ER_BUS_INTERFACE_ACTIVATED                                          = 0x00009097,
    ER_ALLJOYN_UNBINDSESSIONPORT_REPLY_BAD_PORT                         = 0x00009098,
    ER_ALLJOYN_UNBINDSESSIONPORT_REPLY_FAILED                           = 0x00009099,
    ER_ALLJOYN_BINDSESSIONPORT_REPLY_INVALID_OPTS                       = 0x0000909a,
    ER_ALLJOYN_JOINSESSION_REPLY_ALREADY_JOINED                         = 0x0000909b,
    ER_BUS_SELF_CONNECT                                                 = 0x0000909c,
    ER_BUS_SECURITY_NOT_ENABLED                                         = 0x0000909d,
    ER_BUS_LISTENER_ALREADY_SET                                         = 0x0000909e,
    ER_BUS_PEER_AUTH_VERSION_MISMATCH                                   = 0x0000909f,
    ER_ALLJOYN_SETLINKTIMEOUT_REPLY_NOT_SUPPORTED                       = 0x000090a0,
    ER_ALLJOYN_SETLINKTIMEOUT_REPLY_NO_DEST_SUPPORT                     = 0x000090a1,
    ER_ALLJOYN_SETLINKTIMEOUT_REPLY_FAILED                              = 0x000090a2,
    ER_ALLJOYN_ACCESS_PERMISSION_WARNING                                = 0x000090a3,
    ER_ALLJOYN_ACCESS_PERMISSION_ERROR                                  = 0x000090a4,
    ER_BUS_DESTINATION_NOT_AUTHENTICATED                                = 0x000090a5,
    ER_BUS_ENDPOINT_REDIRECTED                                          = 0x000090a6,
    ER_BUS_AUTHENTICATION_PENDING                                       = 0x000090a7,
    ER_BUS_NOT_AUTHORIZED                                               = 0x000090a8,
    ER_PACKET_BUS_NO_SUCH_CHANNEL                                       = 0x000090a9,
    ER_PACKET_BAD_FORMAT                                                = 0x000090aa,
    ER_PACKET_CONNECT_TIMEOUT                                           = 0x000090ab,
    ER_PACKET_CHANNEL_FAIL                                              = 0x000090ac,
    ER_PACKET_TOO_LARGE                                                 = 0x000090ad,
    ER_PACKET_BAD_PARAMETER                                             = 0x000090ae,
    ER_PACKET_BAD_CRC                                                   = 0x000090af,
    ER_RENDEZVOUS_SERVER_DEACTIVATED_USER                               = 0x000090cb,
    ER_RENDEZVOUS_SERVER_UNKNOWN_USER                                   = 0x000090cc,
    ER_UNABLE_TO_CONNECT_TO_RENDEZVOUS_SERVER                           = 0x000090cd,
    ER_NOT_CONNECTED_TO_RENDEZVOUS_SERVER                               = 0x000090ce,
    ER_UNABLE_TO_SEND_MESSAGE_TO_RENDEZVOUS_SERVER                      = 0x000090cf,
    ER_INVALID_RENDEZVOUS_SERVER_INTERFACE_MESSAGE                      = 0x000090d0,
    ER_INVALID_PERSISTENT_CONNECTION_MESSAGE_RESPONSE                   = 0x000090d1,
    ER_INVALID_ON_DEMAND_CONNECTION_MESSAGE_RESPONSE                    = 0x000090d2,
    ER_INVALID_HTTP_METHOD_USED_FOR_RENDEZVOUS_SERVER_INTERFACE_MESSAGE = 0x000090d3,
    ER_RENDEZVOUS_SERVER_ERR500_INTERNAL_ERROR                          = 0x000090d4,
    ER_RENDEZVOUS_SERVER_ERR503_STATUS_UNAVAILABLE                      = 0x000090d5,
    ER_RENDEZVOUS_SERVER_ERR401_UNAUTHORIZED_REQUEST                    = 0x000090d6,
    ER_RENDEZVOUS_SERVER_UNRECOVERABLE_ERROR                            = 0x000090d7,
    ER_RENDEZVOUS_SERVER_ROOT_CERTIFICATE_UNINITIALIZED                 = 0x000090d8,
    ER_BUS_NO_SUCH_ANNOTATION                                           = 0x000090d9,
    ER_BUS_ANNOTATION_ALREADY_EXISTS                                    = 0x000090da,
    ER_SOCK_CLOSING                                                     = 0x000090db,
    ER_NO_SUCH_DEVICE                                                   = 0x000090dc,
    ER_P2P                                                              = 0x000090dd,
    ER_P2P_TIMEOUT                                                      = 0x000090de,
    ER_P2P_NOT_CONNECTED                                                = 0x000090df,
    ER_BAD_TRANSPORT_MASK                                               = 0x000090e0,
    ER_PROXIMITY_CONNECTION_ESTABLISH_FAIL                              = 0x000090e1,
    ER_PROXIMITY_NO_PEERS_FOUND                                         = 0x000090e2,
    ER_BUS_OBJECT_NOT_REGISTERED                                        = 0x000090e3,
    ER_P2P_DISABLED                                                     = 0x000090e4,
    ER_P2P_BUSY                                                         = 0x000090e5,
    ER_BUS_INCOMPATIBLE_DAEMON                                          = 0x000090e6,
    ER_P2P_NO_GO                                                        = 0x000090e7,
    ER_P2P_NO_STA                                                       = 0x000090e8,
    ER_P2P_FORBIDDEN                                                    = 0x000090e9,
    ER_ALLJOYN_ONAPPSUSPEND_REPLY_FAILED                                = 0x000090ea,
    ER_ALLJOYN_ONAPPSUSPEND_REPLY_UNSUPPORTED                           = 0x000090eb,
    ER_ALLJOYN_ONAPPRESUME_REPLY_FAILED                                 = 0x000090ec,
    ER_ALLJOYN_ONAPPRESUME_REPLY_UNSUPPORTED                            = 0x000090ed,
    ER_BUS_NO_SUCH_MESSAGE                                              = 0x000090ee,
    ER_ALLJOYN_REMOVESESSIONMEMBER_REPLY_NO_SESSION                     = 0x000090ef,
    ER_ALLJOYN_REMOVESESSIONMEMBER_NOT_BINDER                           = 0x000090f0,
    ER_ALLJOYN_REMOVESESSIONMEMBER_NOT_MULTIPOINT                       = 0x000090f1,
    ER_ALLJOYN_REMOVESESSIONMEMBER_NOT_FOUND                            = 0x000090f2,
    ER_ALLJOYN_REMOVESESSIONMEMBER_INCOMPATIBLE_REMOTE_DAEMON           = 0x000090f3,
    ER_ALLJOYN_REMOVESESSIONMEMBER_REPLY_FAILED                         = 0x000090f4,
    ER_BUS_REMOVED_BY_BINDER                                            = 0x000090f5,
    ER_BUS_MATCH_RULE_NOT_FOUND                                         = 0x000090f6,
    ER_ALLJOYN_PING_FAILED                                              = 0x000090f7,
    ER_ALLJOYN_PING_REPLY_UNREACHABLE                                   = 0x000090f8,
    ER_UDP_MSG_TOO_LONG                                                 = 0x000090f9,
    ER_UDP_DEMUX_NO_ENDPOINT                                            = 0x000090fa,
    ER_UDP_NO_NETWORK                                                   = 0x000090fb,
    ER_UDP_UNEXPECTED_LENGTH                                            = 0x000090fc,
    ER_UDP_UNEXPECTED_FLOW                                              = 0x000090fd,
    ER_UDP_DISCONNECT                                                   = 0x000090fe,
    ER_UDP_NOT_IMPLEMENTED                                              = 0x000090ff,
    ER_UDP_NO_LISTENER                                                  = 0x00009100,
    ER_UDP_STOPPING                                                     = 0x00009101,
    ER_ARDP_BACKPRESSURE                                                = 0x00009102,
    ER_UDP_BACKPRESSURE                                                 = 0x00009103,
    ER_ARDP_INVALID_STATE                                               = 0x00009104,
    ER_ARDP_TTL_EXPIRED                                                 = 0x00009105,
    ER_ARDP_PERSIST_TIMEOUT                                             = 0x00009106,
    ER_ARDP_PROBE_TIMEOUT                                               = 0x00009107,
    ER_ARDP_REMOTE_CONNECTION_RESET                                     = 0x00009108,
    ER_UDP_BUSHELLO                                                     = 0x00009109,
    ER_UDP_MESSAGE                                                      = 0x0000910a,
    ER_UDP_INVALID                                                      = 0x0000910b,
    ER_UDP_UNSUPPORTED                                                  = 0x0000910c,
    ER_UDP_ENDPOINT_STALLED                                             = 0x0000910d,
    ER_ARDP_INVALID_RESPONSE                                            = 0x0000910e,
    ER_ARDP_INVALID_CONNECTION                                          = 0x0000910f,
    ER_UDP_LOCAL_DISCONNECT                                             = 0x00009110,
    ER_UDP_EARLY_EXIT                                                   = 0x00009111,
    ER_UDP_LOCAL_DISCONNECT_FAIL                                        = 0x00009112,
    ER_ARDP_DISCONNECTING                                               = 0x00009113,
    ER_ALLJOYN_PING_REPLY_INCOMPATIBLE_REMOTE_ROUTING_NODE              = 0x00009114,
    ER_ALLJOYN_PING_REPLY_TIMEOUT                                       = 0x00009115,
    ER_ALLJOYN_PING_REPLY_UNKNOWN_NAME                                  = 0x00009116,
    ER_ALLJOYN_PING_REPLY_FAILED                                        = 0x00009117,
    ER_TCP_MAX_UNTRUSTED                                                = 0x00009118,
    ER_ALLJOYN_PING_REPLY_IN_PROGRESS                                   = 0x00009119,
    ER_LANGUAGE_NOT_SUPPORTED                                           = 0x0000911a,
    ER_ABOUT_FIELD_ALREADY_SPECIFIED                                    = 0x0000911b,
    ER_UDP_NOT_DISCONNECTED                                             = 0x0000911c,
    ER_UDP_ENDPOINT_NOT_STARTED                                         = 0x0000911d,
    ER_UDP_ENDPOINT_REMOVED                                             = 0x0000911e,
    ER_ARDP_VERSION_NOT_SUPPORTED                                       = 0x0000911f,
    ER_CONNECTION_LIMIT_EXCEEDED                                        = 0x00009120,
    ER_ARDP_WRITE_BLOCKED                                               = 0x00009121,
    ER_PERMISSION_DENIED                                                = 0x00009122,
    ER_ABOUT_DEFAULT_LANGUAGE_NOT_SPECIFIED                             = 0x00009123,
    ER_ABOUT_SESSIONPORT_NOT_BOUND                                      = 0x00009124,
    ER_ABOUT_ABOUTDATA_MISSING_REQUIRED_FIELD                           = 0x00009125,
    ER_ABOUT_INVALID_ABOUTDATA_LISTENER                                 = 0x00009126,
    ER_BUS_PING_GROUP_NOT_FOUND                                         = 0x00009127,
    ER_BUS_REMOVED_BY_BINDER_SELF                                       = 0x00009128,
    ER_INVALID_CONFIG                                                   = 0x00009129,
    ER_ABOUT_INVALID_ABOUTDATA_FIELD_VALUE                              = 0x0000912a,
    ER_ABOUT_INVALID_ABOUTDATA_FIELD_APPID_SIZE                         = 0x0000912b,
    ER_BUS_TRANSPORT_ACCESS_DENIED                                      = 0x0000912c,
    ER_INVALID_CERTIFICATE                                              = 0x0000912d,
    ER_CERTIFICATE_NOT_FOUND                                            = 0x0000912e,
    ER_DUPLICATE_CERTIFICATE                                            = 0x0000912f,
    ER_UNKNOWN_CERTIFICATE                                              = 0x00009130,
    ER_MISSING_DIGEST_IN_CERTIFICATE                                    = 0x00009131,
    ER_DIGEST_MISMATCH                                                  = 0x00009132,
    ER_DUPLICATE_KEY                                                    = 0x00009133,
    ER_NO_COMMON_TRUST                                                  = 0x00009134,
    ER_MANIFEST_NOT_FOUND                                               = 0x00009135,
    ER_INVALID_CERT_CHAIN                                               = 0x00009136,
    ER_NO_TRUST_ANCHOR                                                  = 0x00009137,
    ER_INVALID_APPLICATION_STATE                                        = 0x00009138,
    ER_FEATURE_NOT_AVAILABLE                                            = 0x00009139,
    ER_KEY_STORE_ALREADY_INITIALIZED                                    = 0x0000913a,
    ER_KEY_STORE_ID_NOT_YET_SET                                         = 0x0000913b,
    ER_POLICY_NOT_NEWER                                                 = 0x0000913c,
    ER_MANIFEST_REJECTED                                                = 0x0000913d,
    ER_INVALID_CERTIFICATE_USAGE                                        = 0x0000913e,
    ER_INVALID_SIGNAL_EMISSION_TYPE                                     = 0x0000913f,
    ER_APPLICATION_STATE_LISTENER_ALREADY_EXISTS                        = 0x00009140,
    ER_APPLICATION_STATE_LISTENER_NO_SUCH_LISTENER                      = 0x00009141,
    ER_MANAGEMENT_ALREADY_STARTED                                       = 0x00009142,
    ER_MANAGEMENT_NOT_STARTED                                           = 0x00009143,
    ER_BUS_DESCRIPTION_ALREADY_EXISTS                                   = 0x00009144,
}

enum : int
{
    ALLJOYN_INVALID          = 0x00000000,
    ALLJOYN_ARRAY            = 0x00000061,
    ALLJOYN_BOOLEAN          = 0x00000062,
    ALLJOYN_DOUBLE           = 0x00000064,
    ALLJOYN_DICT_ENTRY       = 0x00000065,
    ALLJOYN_SIGNATURE        = 0x00000067,
    ALLJOYN_HANDLE           = 0x00000068,
    ALLJOYN_INT32            = 0x00000069,
    ALLJOYN_INT16            = 0x0000006e,
    ALLJOYN_OBJECT_PATH      = 0x0000006f,
    ALLJOYN_UINT16           = 0x00000071,
    ALLJOYN_STRUCT           = 0x00000072,
    ALLJOYN_STRING           = 0x00000073,
    ALLJOYN_UINT64           = 0x00000074,
    ALLJOYN_UINT32           = 0x00000075,
    ALLJOYN_VARIANT          = 0x00000076,
    ALLJOYN_INT64            = 0x00000078,
    ALLJOYN_BYTE             = 0x00000079,
    ALLJOYN_STRUCT_OPEN      = 0x00000028,
    ALLJOYN_STRUCT_CLOSE     = 0x00000029,
    ALLJOYN_DICT_ENTRY_OPEN  = 0x0000007b,
    ALLJOYN_DICT_ENTRY_CLOSE = 0x0000007d,
    ALLJOYN_BOOLEAN_ARRAY    = 0x00006261,
    ALLJOYN_DOUBLE_ARRAY     = 0x00006461,
    ALLJOYN_INT32_ARRAY      = 0x00006961,
    ALLJOYN_INT16_ARRAY      = 0x00006e61,
    ALLJOYN_UINT16_ARRAY     = 0x00007161,
    ALLJOYN_UINT64_ARRAY     = 0x00007461,
    ALLJOYN_UINT32_ARRAY     = 0x00007561,
    ALLJOYN_INT64_ARRAY      = 0x00007861,
    ALLJOYN_BYTE_ARRAY       = 0x00007961,
    ALLJOYN_WILDCARD         = 0x0000002a,
}
alias alljoyn_typeid = int;

enum : int
{
    NOT_CLAIMABLE = 0x00000000,
    CLAIMABLE     = 0x00000001,
    CLAIMED       = 0x00000002,
    NEED_UPDATE   = 0x00000003,
}
alias alljoyn_applicationstate = int;

enum : int
{
    CAPABLE_ECDHE_NULL  = 0x00000001,
    CAPABLE_ECDHE_ECDSA = 0x00000004,
    CAPABLE_ECDHE_SPEKE = 0x00000008,
}
alias alljoyn_claimcapability_masks = int;

enum : int
{
    PASSWORD_GENERATED_BY_SECURITY_MANAGER = 0x00000001,
    PASSWORD_GENERATED_BY_APPLICATION      = 0x00000002,
}
alias alljoyn_claimcapabilityadditionalinfo_masks = int;

enum : int
{
    ALLJOYN_MESSAGE_INVALID     = 0x00000000,
    ALLJOYN_MESSAGE_METHOD_CALL = 0x00000001,
    ALLJOYN_MESSAGE_METHOD_RET  = 0x00000002,
    ALLJOYN_MESSAGE_ERROR       = 0x00000003,
    ALLJOYN_MESSAGE_SIGNAL      = 0x00000004,
}
alias alljoyn_messagetype = int;

enum : int
{
    AJ_IFC_SECURITY_INHERIT  = 0x00000000,
    AJ_IFC_SECURITY_REQUIRED = 0x00000001,
    AJ_IFC_SECURITY_OFF      = 0x00000002,
}
alias alljoyn_interfacedescription_securitypolicy = int;

enum : int
{
    ALLJOYN_SESSIONLOST_INVALID                    = 0x00000000,
    ALLJOYN_SESSIONLOST_REMOTE_END_LEFT_SESSION    = 0x00000001,
    ALLJOYN_SESSIONLOST_REMOTE_END_CLOSED_ABRUPTLY = 0x00000002,
    ALLJOYN_SESSIONLOST_REMOVED_BY_BINDER          = 0x00000003,
    ALLJOYN_SESSIONLOST_LINK_TIMEOUT               = 0x00000004,
    ALLJOYN_SESSIONLOST_REASON_OTHER               = 0x00000005,
}
alias alljoyn_sessionlostreason = int;

// Constants


enum ubyte ALLJOYN_LITTLE_ENDIAN = 0x6c;
enum uint ALLJOYN_MESSAGE_DEFAULT_TIMEOUT = 0x000061a8;

enum : ushort
{
    ALLJOYN_CRED_USER_NAME    = 0x0002,
    ALLJOYN_CRED_CERT_CHAIN   = 0x0004,
    ALLJOYN_CRED_PRIVATE_KEY  = 0x0008,
    ALLJOYN_CRED_LOGON_ENTRY  = 0x0010,
    ALLJOYN_CRED_EXPIRATION   = 0x0020,
    ALLJOYN_CRED_NEW_PASSWORD = 0x1001,
    ALLJOYN_CRED_ONE_TIME_PWD = 0x2001,
}

enum : ubyte
{
    ALLJOYN_PROP_ACCESS_WRITE = 0x02,
    ALLJOYN_PROP_ACCESS_RW    = 0x03,
}

enum : ubyte
{
    ALLJOYN_MEMBER_ANNOTATE_DEPRECATED       = 0x02,
    ALLJOYN_MEMBER_ANNOTATE_SESSIONCAST      = 0x04,
    ALLJOYN_MEMBER_ANNOTATE_SESSIONLESS      = 0x08,
    ALLJOYN_MEMBER_ANNOTATE_UNICAST          = 0x10,
    ALLJOYN_MEMBER_ANNOTATE_GLOBAL_BROADCAST = 0x20,
}

// Callbacks

alias alljoyn_aboutdatalistener_getaboutdata_ptr = QStatus function(const(void)* context, 
                                                                    _alljoyn_msgarg_handle* msgArg, 
                                                                    const(byte)* language);
alias alljoyn_aboutdatalistener_getannouncedaboutdata_ptr = QStatus function(const(void)* context, 
                                                                             _alljoyn_msgarg_handle* msgArg);
alias alljoyn_applicationstatelistener_state_ptr = void function(byte* busName, byte* publicKey, 
                                                                 alljoyn_applicationstate applicationState, 
                                                                 void* context);
alias alljoyn_keystorelistener_loadrequest_ptr = QStatus function(const(void)* context, 
                                                                  _alljoyn_keystorelistener_handle* listener, 
                                                                  _alljoyn_keystore_handle* keyStore);
alias alljoyn_keystorelistener_storerequest_ptr = QStatus function(const(void)* context, 
                                                                   _alljoyn_keystorelistener_handle* listener, 
                                                                   _alljoyn_keystore_handle* keyStore);
alias alljoyn_keystorelistener_acquireexclusivelock_ptr = QStatus function(const(void)* context, 
                                                                           _alljoyn_keystorelistener_handle* listener);
alias alljoyn_keystorelistener_releaseexclusivelock_ptr = void function(const(void)* context, 
                                                                        _alljoyn_keystorelistener_handle* listener);
alias alljoyn_authlistener_requestcredentials_ptr = int function(const(void)* context, const(byte)* authMechanism, 
                                                                 const(byte)* peerName, ushort authCount, 
                                                                 const(byte)* userName, ushort credMask, 
                                                                 _alljoyn_credentials_handle* credentials);
alias alljoyn_authlistener_requestcredentialsasync_ptr = QStatus function(const(void)* context, 
                                                                          _alljoyn_authlistener_handle* listener, 
                                                                          const(byte)* authMechanism, 
                                                                          const(byte)* peerName, ushort authCount, 
                                                                          const(byte)* userName, ushort credMask, 
                                                                          void* authContext);
alias alljoyn_authlistener_verifycredentials_ptr = int function(const(void)* context, const(byte)* authMechanism, 
                                                                const(byte)* peerName, 
                                                                const(_alljoyn_credentials_handle)* credentials);
alias alljoyn_authlistener_verifycredentialsasync_ptr = QStatus function(const(void)* context, 
                                                                         _alljoyn_authlistener_handle* listener, 
                                                                         const(byte)* authMechanism, 
                                                                         const(byte)* peerName, 
                                                                         const(_alljoyn_credentials_handle)* credentials, 
                                                                         void* authContext);
alias alljoyn_authlistener_securityviolation_ptr = void function(const(void)* context, QStatus status, 
                                                                 const(_alljoyn_message_handle)* msg);
alias alljoyn_authlistener_authenticationcomplete_ptr = void function(const(void)* context, 
                                                                      const(byte)* authMechanism, 
                                                                      const(byte)* peerName, int success);
alias alljoyn_buslistener_listener_registered_ptr = void function(const(void)* context, 
                                                                  _alljoyn_busattachment_handle* bus);
alias alljoyn_buslistener_listener_unregistered_ptr = void function(const(void)* context);
alias alljoyn_buslistener_found_advertised_name_ptr = void function(const(void)* context, const(byte)* name, 
                                                                    ushort transport, const(byte)* namePrefix);
alias alljoyn_buslistener_lost_advertised_name_ptr = void function(const(void)* context, const(byte)* name, 
                                                                   ushort transport, const(byte)* namePrefix);
alias alljoyn_buslistener_name_owner_changed_ptr = void function(const(void)* context, const(byte)* busName, 
                                                                 const(byte)* previousOwner, const(byte)* newOwner);
alias alljoyn_buslistener_bus_stopping_ptr = void function(const(void)* context);
alias alljoyn_buslistener_bus_disconnected_ptr = void function(const(void)* context);
alias alljoyn_buslistener_bus_prop_changed_ptr = void function(const(void)* context, const(byte)* prop_name, 
                                                               _alljoyn_msgarg_handle* prop_value);
alias alljoyn_interfacedescription_translation_callback_ptr = byte* function(const(byte)* sourceLanguage, 
                                                                             const(byte)* targetLanguage, 
                                                                             const(byte)* sourceText);
alias alljoyn_messagereceiver_methodhandler_ptr = void function(_alljoyn_busobject_handle* bus, 
                                                                const(alljoyn_interfacedescription_member)* member, 
                                                                _alljoyn_message_handle* message);
alias alljoyn_messagereceiver_replyhandler_ptr = void function(_alljoyn_message_handle* message, void* context);
alias alljoyn_messagereceiver_signalhandler_ptr = void function(const(alljoyn_interfacedescription_member)* member, 
                                                                const(byte)* srcPath, 
                                                                _alljoyn_message_handle* message);
alias alljoyn_busobject_prop_get_ptr = QStatus function(const(void)* context, const(byte)* ifcName, 
                                                        const(byte)* propName, _alljoyn_msgarg_handle* val);
alias alljoyn_busobject_prop_set_ptr = QStatus function(const(void)* context, const(byte)* ifcName, 
                                                        const(byte)* propName, _alljoyn_msgarg_handle* val);
alias alljoyn_busobject_object_registration_ptr = void function(const(void)* context);
alias alljoyn_proxybusobject_listener_introspectcb_ptr = void function(QStatus status, 
                                                                       _alljoyn_proxybusobject_handle* obj, 
                                                                       void* context);
alias alljoyn_proxybusobject_listener_getpropertycb_ptr = void function(QStatus status, 
                                                                        _alljoyn_proxybusobject_handle* obj, 
                                                                        const(_alljoyn_msgarg_handle)* value, 
                                                                        void* context);
alias alljoyn_proxybusobject_listener_getallpropertiescb_ptr = void function(QStatus status, 
                                                                             _alljoyn_proxybusobject_handle* obj, 
                                                                             const(_alljoyn_msgarg_handle)* values, 
                                                                             void* context);
alias alljoyn_proxybusobject_listener_setpropertycb_ptr = void function(QStatus status, 
                                                                        _alljoyn_proxybusobject_handle* obj, 
                                                                        void* context);
alias alljoyn_proxybusobject_listener_propertieschanged_ptr = void function(_alljoyn_proxybusobject_handle* obj, 
                                                                            const(byte)* ifaceName, 
                                                                            const(_alljoyn_msgarg_handle)* changed, 
                                                                            const(_alljoyn_msgarg_handle)* invalidated, 
                                                                            void* context);
alias alljoyn_permissionconfigurationlistener_factoryreset_ptr = QStatus function(const(void)* context);
alias alljoyn_permissionconfigurationlistener_policychanged_ptr = void function(const(void)* context);
alias alljoyn_permissionconfigurationlistener_startmanagement_ptr = void function(const(void)* context);
alias alljoyn_permissionconfigurationlistener_endmanagement_ptr = void function(const(void)* context);
alias alljoyn_sessionlistener_sessionlost_ptr = void function(const(void)* context, uint sessionId, 
                                                              alljoyn_sessionlostreason reason);
alias alljoyn_sessionlistener_sessionmemberadded_ptr = void function(const(void)* context, uint sessionId, 
                                                                     const(byte)* uniqueName);
alias alljoyn_sessionlistener_sessionmemberremoved_ptr = void function(const(void)* context, uint sessionId, 
                                                                       const(byte)* uniqueName);
alias alljoyn_sessionportlistener_acceptsessionjoiner_ptr = int function(const(void)* context, ushort sessionPort, 
                                                                         const(byte)* joiner, 
                                                                         const(_alljoyn_sessionopts_handle)* opts);
alias alljoyn_sessionportlistener_sessionjoined_ptr = void function(const(void)* context, ushort sessionPort, 
                                                                    uint id, const(byte)* joiner);
alias alljoyn_about_announced_ptr = void function(const(void)* context, const(byte)* busName, ushort version_, 
                                                  ushort port, const(_alljoyn_msgarg_handle)* objectDescriptionArg, 
                                                  const(_alljoyn_msgarg_handle)* aboutDataArg);
alias alljoyn_busattachment_joinsessioncb_ptr = void function(QStatus status, uint sessionId, 
                                                              const(_alljoyn_sessionopts_handle)* opts, 
                                                              void* context);
alias alljoyn_busattachment_setlinktimeoutcb_ptr = void function(QStatus status, uint timeout, void* context);
alias alljoyn_autopinger_destination_lost_ptr = void function(const(void)* context, const(byte)* group, 
                                                              const(byte)* destination);
alias alljoyn_autopinger_destination_found_ptr = void function(const(void)* context, const(byte)* group, 
                                                               const(byte)* destination);
alias alljoyn_observer_object_discovered_ptr = void function(const(void)* context, 
                                                             _alljoyn_proxybusobject_ref_handle* proxyref);
alias alljoyn_observer_object_lost_ptr = void function(const(void)* context, 
                                                       _alljoyn_proxybusobject_ref_handle* proxyref);

// Structs


struct _alljoyn_msgarg_handle
{
}

struct _alljoyn_aboutdata_handle
{
}

struct _alljoyn_aboutdatalistener_handle
{
}

struct alljoyn_aboutdatalistener_callbacks
{
    alljoyn_aboutdatalistener_getaboutdata_ptr about_datalistener_getaboutdata;
    alljoyn_aboutdatalistener_getannouncedaboutdata_ptr about_datalistener_getannouncedaboutdata;
}

struct _alljoyn_permissionconfigurator_handle
{
}

struct alljoyn_certificateid
{
    ubyte* serial;
    size_t serialLen;
    byte*  issuerPublicKey;
    ubyte* issuerAki;
    size_t issuerAkiLen;
}

struct alljoyn_certificateidarray
{
    size_t count;
    alljoyn_certificateid* ids;
}

struct alljoyn_manifestarray
{
    size_t count;
    byte** xmls;
}

struct _alljoyn_applicationstatelistener_handle
{
}

struct alljoyn_applicationstatelistener_callbacks
{
    alljoyn_applicationstatelistener_state_ptr state;
}

struct _alljoyn_keystore_handle
{
}

struct _alljoyn_keystorelistener_handle
{
}

struct alljoyn_keystorelistener_callbacks
{
    alljoyn_keystorelistener_loadrequest_ptr load_request;
    alljoyn_keystorelistener_storerequest_ptr store_request;
}

struct alljoyn_keystorelistener_with_synchronization_callbacks
{
    alljoyn_keystorelistener_loadrequest_ptr load_request;
    alljoyn_keystorelistener_storerequest_ptr store_request;
    alljoyn_keystorelistener_acquireexclusivelock_ptr acquire_exclusive_lock;
    alljoyn_keystorelistener_releaseexclusivelock_ptr release_exclusive_lock;
}

struct _alljoyn_sessionopts_handle
{
}

struct _alljoyn_message_handle
{
}

struct _alljoyn_busattachment_handle
{
}

struct _alljoyn_authlistener_handle
{
}

struct _alljoyn_credentials_handle
{
}

struct alljoyn_authlistener_callbacks
{
    alljoyn_authlistener_requestcredentials_ptr request_credentials;
    alljoyn_authlistener_verifycredentials_ptr verify_credentials;
    alljoyn_authlistener_securityviolation_ptr security_violation;
    alljoyn_authlistener_authenticationcomplete_ptr authentication_complete;
}

struct alljoyn_authlistenerasync_callbacks
{
    alljoyn_authlistener_requestcredentialsasync_ptr request_credentials;
    alljoyn_authlistener_verifycredentialsasync_ptr verify_credentials;
    alljoyn_authlistener_securityviolation_ptr security_violation;
    alljoyn_authlistener_authenticationcomplete_ptr authentication_complete;
}

struct _alljoyn_buslistener_handle
{
}

struct alljoyn_buslistener_callbacks
{
    alljoyn_buslistener_listener_registered_ptr listener_registered;
    alljoyn_buslistener_listener_unregistered_ptr listener_unregistered;
    alljoyn_buslistener_found_advertised_name_ptr found_advertised_name;
    alljoyn_buslistener_lost_advertised_name_ptr lost_advertised_name;
    alljoyn_buslistener_name_owner_changed_ptr name_owner_changed;
    alljoyn_buslistener_bus_stopping_ptr bus_stopping;
    alljoyn_buslistener_bus_disconnected_ptr bus_disconnected;
    alljoyn_buslistener_bus_prop_changed_ptr property_changed;
}

struct _alljoyn_interfacedescription_handle
{
}

struct alljoyn_interfacedescription_member
{
    _alljoyn_interfacedescription_handle* iface;
    alljoyn_messagetype memberType;
    const(byte)*        name;
    const(byte)*        signature;
    const(byte)*        returnSignature;
    const(byte)*        argNames;
    const(void)*        internal_member;
}

struct alljoyn_interfacedescription_property
{
    const(byte)* name;
    const(byte)* signature;
    ubyte        access;
    const(void)* internal_property;
}

struct _alljoyn_busobject_handle
{
}

struct alljoyn_busobject_callbacks
{
    alljoyn_busobject_prop_get_ptr property_get;
    alljoyn_busobject_prop_set_ptr property_set;
    alljoyn_busobject_object_registration_ptr object_registered;
    alljoyn_busobject_object_registration_ptr object_unregistered;
}

struct alljoyn_busobject_methodentry
{
    const(alljoyn_interfacedescription_member)* member;
    alljoyn_messagereceiver_methodhandler_ptr method_handler;
}

struct _alljoyn_proxybusobject_handle
{
}

struct _alljoyn_permissionconfigurationlistener_handle
{
}

struct alljoyn_permissionconfigurationlistener_callbacks
{
    alljoyn_permissionconfigurationlistener_factoryreset_ptr factory_reset;
    alljoyn_permissionconfigurationlistener_policychanged_ptr policy_changed;
    alljoyn_permissionconfigurationlistener_startmanagement_ptr start_management;
    alljoyn_permissionconfigurationlistener_endmanagement_ptr end_management;
}

struct _alljoyn_sessionlistener_handle
{
}

struct alljoyn_sessionlistener_callbacks
{
    alljoyn_sessionlistener_sessionlost_ptr session_lost;
    alljoyn_sessionlistener_sessionmemberadded_ptr session_member_added;
    alljoyn_sessionlistener_sessionmemberremoved_ptr session_member_removed;
}

struct _alljoyn_sessionportlistener_handle
{
}

struct alljoyn_sessionportlistener_callbacks
{
    alljoyn_sessionportlistener_acceptsessionjoiner_ptr accept_session_joiner;
    alljoyn_sessionportlistener_sessionjoined_ptr session_joined;
}

struct _alljoyn_aboutlistener_handle
{
}

struct alljoyn_aboutlistener_callback
{
    alljoyn_about_announced_ptr about_listener_announced;
}

struct _alljoyn_aboutobj_handle
{
}

struct _alljoyn_aboutobjectdescription_handle
{
}

struct _alljoyn_aboutproxy_handle
{
}

struct _alljoyn_pinglistener_handle
{
}

struct alljoyn_pinglistener_callback
{
    alljoyn_autopinger_destination_found_ptr destination_found;
    alljoyn_autopinger_destination_lost_ptr destination_lost;
}

struct _alljoyn_autopinger_handle
{
}

struct _alljoyn_proxybusobject_ref_handle
{
}

struct _alljoyn_observerlistener_handle
{
}

struct alljoyn_observerlistener_callback
{
    alljoyn_observer_object_discovered_ptr object_discovered;
    alljoyn_observer_object_lost_ptr object_lost;
}

struct _alljoyn_observer_handle
{
}

struct _alljoyn_securityapplicationproxy_handle
{
}

// Functions

@DllImport("MSAJApi")
HANDLE AllJoynConnectToBus(const(wchar)* connectionSpec);

@DllImport("MSAJApi")
BOOL AllJoynCloseBusHandle(HANDLE busHandle);

@DllImport("MSAJApi")
BOOL AllJoynSendToBus(HANDLE connectedBusHandle, char* buffer, uint bytesToWrite, uint* bytesTransferred, 
                      void* reserved);

@DllImport("MSAJApi")
BOOL AllJoynReceiveFromBus(HANDLE connectedBusHandle, char* buffer, uint bytesToRead, uint* bytesTransferred, 
                           void* reserved);

@DllImport("MSAJApi")
BOOL AllJoynEventSelect(HANDLE connectedBusHandle, HANDLE eventHandle, uint eventTypes);

@DllImport("MSAJApi")
BOOL AllJoynEnumEvents(HANDLE connectedBusHandle, HANDLE eventToReset, uint* eventTypes);

@DllImport("MSAJApi")
HANDLE AllJoynCreateBus(uint outBufferSize, uint inBufferSize, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("MSAJApi")
uint AllJoynAcceptBusConnection(HANDLE serverBusHandle, HANDLE abortEvent);

@DllImport("MSAJApi")
int alljoyn_unity_deferred_callbacks_process();

@DllImport("MSAJApi")
void alljoyn_unity_set_deferred_callback_mainthread_only(int mainthread_only);

@DllImport("MSAJApi")
byte* QCC_StatusText(QStatus status);

@DllImport("MSAJApi")
_alljoyn_msgarg_handle* alljoyn_msgarg_create();

@DllImport("MSAJApi")
_alljoyn_msgarg_handle* alljoyn_msgarg_create_and_set(const(byte)* signature);

@DllImport("MSAJApi")
void alljoyn_msgarg_destroy(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi")
_alljoyn_msgarg_handle* alljoyn_msgarg_array_create(size_t size);

@DllImport("MSAJApi")
_alljoyn_msgarg_handle* alljoyn_msgarg_array_element(_alljoyn_msgarg_handle* arg, size_t index);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set(_alljoyn_msgarg_handle* arg, const(byte)* signature);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get(_alljoyn_msgarg_handle* arg, const(byte)* signature);

@DllImport("MSAJApi")
_alljoyn_msgarg_handle* alljoyn_msgarg_copy(const(_alljoyn_msgarg_handle)* source);

@DllImport("MSAJApi")
void alljoyn_msgarg_clone(_alljoyn_msgarg_handle* destination, const(_alljoyn_msgarg_handle)* source);

@DllImport("MSAJApi")
int alljoyn_msgarg_equal(_alljoyn_msgarg_handle* lhv, _alljoyn_msgarg_handle* rhv);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_array_set(_alljoyn_msgarg_handle* args, size_t* numArgs, const(byte)* signature);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_array_get(const(_alljoyn_msgarg_handle)* args, size_t numArgs, const(byte)* signature);

@DllImport("MSAJApi")
size_t alljoyn_msgarg_tostring(_alljoyn_msgarg_handle* arg, byte* str, size_t buf, size_t indent);

@DllImport("MSAJApi")
size_t alljoyn_msgarg_array_tostring(const(_alljoyn_msgarg_handle)* args, size_t numArgs, byte* str, size_t buf, 
                                     size_t indent);

@DllImport("MSAJApi")
size_t alljoyn_msgarg_signature(_alljoyn_msgarg_handle* arg, byte* str, size_t buf);

@DllImport("MSAJApi")
size_t alljoyn_msgarg_array_signature(_alljoyn_msgarg_handle* values, size_t numValues, byte* str, size_t buf);

@DllImport("MSAJApi")
int alljoyn_msgarg_hassignature(_alljoyn_msgarg_handle* arg, const(byte)* signature);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_getdictelement(_alljoyn_msgarg_handle* arg, const(byte)* elemSig);

@DllImport("MSAJApi")
alljoyn_typeid alljoyn_msgarg_gettype(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi")
void alljoyn_msgarg_clear(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi")
void alljoyn_msgarg_stabilize(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_array_set_offset(_alljoyn_msgarg_handle* args, size_t argOffset, size_t* numArgs, 
                                        const(byte)* signature);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_and_stabilize(_alljoyn_msgarg_handle* arg, const(byte)* signature);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_uint8(_alljoyn_msgarg_handle* arg, ubyte y);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_bool(_alljoyn_msgarg_handle* arg, int b);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_int16(_alljoyn_msgarg_handle* arg, short n);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_uint16(_alljoyn_msgarg_handle* arg, ushort q);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_int32(_alljoyn_msgarg_handle* arg, int i);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_uint32(_alljoyn_msgarg_handle* arg, uint u);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_int64(_alljoyn_msgarg_handle* arg, long x);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_uint64(_alljoyn_msgarg_handle* arg, ulong t);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_double(_alljoyn_msgarg_handle* arg, double d);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_string(_alljoyn_msgarg_handle* arg, const(byte)* s);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_objectpath(_alljoyn_msgarg_handle* arg, const(byte)* o);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_signature(_alljoyn_msgarg_handle* arg, const(byte)* g);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_uint8(const(_alljoyn_msgarg_handle)* arg, ubyte* y);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_bool(const(_alljoyn_msgarg_handle)* arg, int* b);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_int16(const(_alljoyn_msgarg_handle)* arg, short* n);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_uint16(const(_alljoyn_msgarg_handle)* arg, ushort* q);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_int32(const(_alljoyn_msgarg_handle)* arg, int* i);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_uint32(const(_alljoyn_msgarg_handle)* arg, uint* u);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_int64(const(_alljoyn_msgarg_handle)* arg, long* x);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_uint64(const(_alljoyn_msgarg_handle)* arg, ulong* t);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_double(const(_alljoyn_msgarg_handle)* arg, double* d);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_string(const(_alljoyn_msgarg_handle)* arg, byte** s);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_objectpath(const(_alljoyn_msgarg_handle)* arg, byte** o);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_signature(const(_alljoyn_msgarg_handle)* arg, byte** g);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_variant(const(_alljoyn_msgarg_handle)* arg, _alljoyn_msgarg_handle* v);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_uint8_array(_alljoyn_msgarg_handle* arg, size_t length, ubyte* ay);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_bool_array(_alljoyn_msgarg_handle* arg, size_t length, int* ab);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_int16_array(_alljoyn_msgarg_handle* arg, size_t length, short* an);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_uint16_array(_alljoyn_msgarg_handle* arg, size_t length, ushort* aq);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_int32_array(_alljoyn_msgarg_handle* arg, size_t length, int* ai);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_uint32_array(_alljoyn_msgarg_handle* arg, size_t length, uint* au);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_int64_array(_alljoyn_msgarg_handle* arg, size_t length, long* ax);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_uint64_array(_alljoyn_msgarg_handle* arg, size_t length, ulong* at);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_double_array(_alljoyn_msgarg_handle* arg, size_t length, double* ad);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_string_array(_alljoyn_msgarg_handle* arg, size_t length, const(byte)** as);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_objectpath_array(_alljoyn_msgarg_handle* arg, size_t length, const(byte)** ao);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_set_signature_array(_alljoyn_msgarg_handle* arg, size_t length, const(byte)** ag);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_uint8_array(const(_alljoyn_msgarg_handle)* arg, size_t* length, ubyte* ay);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_bool_array(const(_alljoyn_msgarg_handle)* arg, size_t* length, int* ab);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_int16_array(const(_alljoyn_msgarg_handle)* arg, size_t* length, short* an);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_uint16_array(const(_alljoyn_msgarg_handle)* arg, size_t* length, ushort* aq);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_int32_array(const(_alljoyn_msgarg_handle)* arg, size_t* length, int* ai);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_uint32_array(const(_alljoyn_msgarg_handle)* arg, size_t* length, uint* au);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_int64_array(const(_alljoyn_msgarg_handle)* arg, size_t* length, long* ax);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_uint64_array(const(_alljoyn_msgarg_handle)* arg, size_t* length, ulong* at);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_double_array(const(_alljoyn_msgarg_handle)* arg, size_t* length, double* ad);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_get_variant_array(const(_alljoyn_msgarg_handle)* arg, const(byte)* signature, 
                                         size_t* length, _alljoyn_msgarg_handle** av);

@DllImport("MSAJApi")
size_t alljoyn_msgarg_get_array_numberofelements(const(_alljoyn_msgarg_handle)* arg);

@DllImport("MSAJApi")
void alljoyn_msgarg_get_array_element(const(_alljoyn_msgarg_handle)* arg, size_t index, 
                                      _alljoyn_msgarg_handle** element);

@DllImport("MSAJApi")
byte* alljoyn_msgarg_get_array_elementsignature(const(_alljoyn_msgarg_handle)* arg, size_t index);

@DllImport("MSAJApi")
_alljoyn_msgarg_handle* alljoyn_msgarg_getkey(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi")
_alljoyn_msgarg_handle* alljoyn_msgarg_getvalue(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_setdictentry(_alljoyn_msgarg_handle* arg, _alljoyn_msgarg_handle* key, 
                                    _alljoyn_msgarg_handle* value);

@DllImport("MSAJApi")
QStatus alljoyn_msgarg_setstruct(_alljoyn_msgarg_handle* arg, _alljoyn_msgarg_handle* struct_members, 
                                 size_t num_members);

@DllImport("MSAJApi")
size_t alljoyn_msgarg_getnummembers(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi")
_alljoyn_msgarg_handle* alljoyn_msgarg_getmember(_alljoyn_msgarg_handle* arg, size_t index);

@DllImport("MSAJApi")
_alljoyn_aboutdata_handle* alljoyn_aboutdata_create_empty();

@DllImport("MSAJApi")
_alljoyn_aboutdata_handle* alljoyn_aboutdata_create(const(byte)* defaultLanguage);

@DllImport("MSAJApi")
_alljoyn_aboutdata_handle* alljoyn_aboutdata_create_full(const(_alljoyn_msgarg_handle)* arg, const(byte)* language);

@DllImport("MSAJApi")
void alljoyn_aboutdata_destroy(_alljoyn_aboutdata_handle* data);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_createfromxml(_alljoyn_aboutdata_handle* data, const(byte)* aboutDataXml);

@DllImport("MSAJApi")
ubyte alljoyn_aboutdata_isvalid(_alljoyn_aboutdata_handle* data, const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_createfrommsgarg(_alljoyn_aboutdata_handle* data, const(_alljoyn_msgarg_handle)* arg, 
                                           const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setappid(_alljoyn_aboutdata_handle* data, const(ubyte)* appId, const(size_t) num);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setappid_fromstring(_alljoyn_aboutdata_handle* data, const(byte)* appId);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getappid(_alljoyn_aboutdata_handle* data, ubyte** appId, size_t* num);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setdefaultlanguage(_alljoyn_aboutdata_handle* data, const(byte)* defaultLanguage);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getdefaultlanguage(_alljoyn_aboutdata_handle* data, byte** defaultLanguage);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setdevicename(_alljoyn_aboutdata_handle* data, const(byte)* deviceName, 
                                        const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getdevicename(_alljoyn_aboutdata_handle* data, byte** deviceName, const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setdeviceid(_alljoyn_aboutdata_handle* data, const(byte)* deviceId);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getdeviceid(_alljoyn_aboutdata_handle* data, byte** deviceId);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setappname(_alljoyn_aboutdata_handle* data, const(byte)* appName, const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getappname(_alljoyn_aboutdata_handle* data, byte** appName, const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setmanufacturer(_alljoyn_aboutdata_handle* data, const(byte)* manufacturer, 
                                          const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getmanufacturer(_alljoyn_aboutdata_handle* data, byte** manufacturer, 
                                          const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setmodelnumber(_alljoyn_aboutdata_handle* data, const(byte)* modelNumber);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getmodelnumber(_alljoyn_aboutdata_handle* data, byte** modelNumber);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setsupportedlanguage(_alljoyn_aboutdata_handle* data, const(byte)* language);

@DllImport("MSAJApi")
size_t alljoyn_aboutdata_getsupportedlanguages(_alljoyn_aboutdata_handle* data, const(byte)** languageTags, 
                                               size_t num);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setdescription(_alljoyn_aboutdata_handle* data, const(byte)* description, 
                                         const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getdescription(_alljoyn_aboutdata_handle* data, byte** description, 
                                         const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setdateofmanufacture(_alljoyn_aboutdata_handle* data, const(byte)* dateOfManufacture);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getdateofmanufacture(_alljoyn_aboutdata_handle* data, byte** dateOfManufacture);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setsoftwareversion(_alljoyn_aboutdata_handle* data, const(byte)* softwareVersion);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getsoftwareversion(_alljoyn_aboutdata_handle* data, byte** softwareVersion);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getajsoftwareversion(_alljoyn_aboutdata_handle* data, byte** ajSoftwareVersion);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_sethardwareversion(_alljoyn_aboutdata_handle* data, const(byte)* hardwareVersion);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_gethardwareversion(_alljoyn_aboutdata_handle* data, byte** hardwareVersion);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setsupporturl(_alljoyn_aboutdata_handle* data, const(byte)* supportUrl);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getsupporturl(_alljoyn_aboutdata_handle* data, byte** supportUrl);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_setfield(_alljoyn_aboutdata_handle* data, const(byte)* name, 
                                   _alljoyn_msgarg_handle* value, const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getfield(_alljoyn_aboutdata_handle* data, const(byte)* name, 
                                   _alljoyn_msgarg_handle** value, const(byte)* language);

@DllImport("MSAJApi")
size_t alljoyn_aboutdata_getfields(_alljoyn_aboutdata_handle* data, const(byte)** fields, size_t num_fields);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getaboutdata(_alljoyn_aboutdata_handle* data, _alljoyn_msgarg_handle* msgArg, 
                                       const(byte)* language);

@DllImport("MSAJApi")
QStatus alljoyn_aboutdata_getannouncedaboutdata(_alljoyn_aboutdata_handle* data, _alljoyn_msgarg_handle* msgArg);

@DllImport("MSAJApi")
ubyte alljoyn_aboutdata_isfieldrequired(_alljoyn_aboutdata_handle* data, const(byte)* fieldName);

@DllImport("MSAJApi")
ubyte alljoyn_aboutdata_isfieldannounced(_alljoyn_aboutdata_handle* data, const(byte)* fieldName);

@DllImport("MSAJApi")
ubyte alljoyn_aboutdata_isfieldlocalized(_alljoyn_aboutdata_handle* data, const(byte)* fieldName);

@DllImport("MSAJApi")
byte* alljoyn_aboutdata_getfieldsignature(_alljoyn_aboutdata_handle* data, const(byte)* fieldName);

@DllImport("MSAJApi")
_alljoyn_aboutdatalistener_handle* alljoyn_aboutdatalistener_create(const(alljoyn_aboutdatalistener_callbacks)* callbacks, 
                                                                    const(void)* context);

@DllImport("MSAJApi")
void alljoyn_aboutdatalistener_destroy(_alljoyn_aboutdatalistener_handle* listener);

@DllImport("MSAJApi")
ushort alljoyn_permissionconfigurator_getdefaultclaimcapabilities();

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getapplicationstate(const(_alljoyn_permissionconfigurator_handle)* configurator, 
                                                           alljoyn_applicationstate* state);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_setapplicationstate(_alljoyn_permissionconfigurator_handle* configurator, 
                                                           alljoyn_applicationstate state);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getpublickey(_alljoyn_permissionconfigurator_handle* configurator, 
                                                    byte** publicKey);

@DllImport("MSAJApi")
void alljoyn_permissionconfigurator_publickey_destroy(byte* publicKey);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getmanifesttemplate(_alljoyn_permissionconfigurator_handle* configurator, 
                                                           byte** manifestTemplateXml);

@DllImport("MSAJApi")
void alljoyn_permissionconfigurator_manifesttemplate_destroy(byte* manifestTemplateXml);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_setmanifesttemplatefromxml(_alljoyn_permissionconfigurator_handle* configurator, 
                                                                  byte* manifestTemplateXml);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getclaimcapabilities(const(_alljoyn_permissionconfigurator_handle)* configurator, 
                                                            ushort* claimCapabilities);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_setclaimcapabilities(_alljoyn_permissionconfigurator_handle* configurator, 
                                                            ushort claimCapabilities);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getclaimcapabilitiesadditionalinfo(const(_alljoyn_permissionconfigurator_handle)* configurator, 
                                                                          ushort* additionalInfo);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_setclaimcapabilitiesadditionalinfo(_alljoyn_permissionconfigurator_handle* configurator, 
                                                                          ushort additionalInfo);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_reset(_alljoyn_permissionconfigurator_handle* configurator);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_claim(_alljoyn_permissionconfigurator_handle* configurator, byte* caKey, 
                                             byte* identityCertificateChain, const(ubyte)* groupId, size_t groupSize, 
                                             byte* groupAuthority, byte** manifestsXmls, size_t manifestsCount);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_updateidentity(_alljoyn_permissionconfigurator_handle* configurator, 
                                                      byte* identityCertificateChain, byte** manifestsXmls, 
                                                      size_t manifestsCount);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getidentity(_alljoyn_permissionconfigurator_handle* configurator, 
                                                   byte** identityCertificateChain);

@DllImport("MSAJApi")
void alljoyn_permissionconfigurator_certificatechain_destroy(byte* certificateChain);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getmanifests(_alljoyn_permissionconfigurator_handle* configurator, 
                                                    alljoyn_manifestarray* manifestArray);

@DllImport("MSAJApi")
void alljoyn_permissionconfigurator_manifestarray_cleanup(alljoyn_manifestarray* manifestArray);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_installmanifests(_alljoyn_permissionconfigurator_handle* configurator, 
                                                        byte** manifestsXmls, size_t manifestsCount, int append);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getidentitycertificateid(_alljoyn_permissionconfigurator_handle* configurator, 
                                                                alljoyn_certificateid* certificateId);

@DllImport("MSAJApi")
void alljoyn_permissionconfigurator_certificateid_cleanup(alljoyn_certificateid* certificateId);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_updatepolicy(_alljoyn_permissionconfigurator_handle* configurator, 
                                                    byte* policyXml);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getpolicy(_alljoyn_permissionconfigurator_handle* configurator, 
                                                 byte** policyXml);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getdefaultpolicy(_alljoyn_permissionconfigurator_handle* configurator, 
                                                        byte** policyXml);

@DllImport("MSAJApi")
void alljoyn_permissionconfigurator_policy_destroy(byte* policyXml);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_resetpolicy(_alljoyn_permissionconfigurator_handle* configurator);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_getmembershipsummaries(_alljoyn_permissionconfigurator_handle* configurator, 
                                                              alljoyn_certificateidarray* certificateIds);

@DllImport("MSAJApi")
void alljoyn_permissionconfigurator_certificateidarray_cleanup(alljoyn_certificateidarray* certificateIdArray);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_installmembership(_alljoyn_permissionconfigurator_handle* configurator, 
                                                         byte* membershipCertificateChain);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_removemembership(_alljoyn_permissionconfigurator_handle* configurator, 
                                                        const(ubyte)* serial, size_t serialLen, 
                                                        byte* issuerPublicKey, const(ubyte)* issuerAki, 
                                                        size_t issuerAkiLen);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_startmanagement(_alljoyn_permissionconfigurator_handle* configurator);

@DllImport("MSAJApi")
QStatus alljoyn_permissionconfigurator_endmanagement(_alljoyn_permissionconfigurator_handle* configurator);

@DllImport("MSAJApi")
_alljoyn_applicationstatelistener_handle* alljoyn_applicationstatelistener_create(const(alljoyn_applicationstatelistener_callbacks)* callbacks, 
                                                                                  void* context);

@DllImport("MSAJApi")
void alljoyn_applicationstatelistener_destroy(_alljoyn_applicationstatelistener_handle* listener);

@DllImport("MSAJApi")
_alljoyn_keystorelistener_handle* alljoyn_keystorelistener_create(const(alljoyn_keystorelistener_callbacks)* callbacks, 
                                                                  const(void)* context);

@DllImport("MSAJApi")
_alljoyn_keystorelistener_handle* alljoyn_keystorelistener_with_synchronization_create(const(alljoyn_keystorelistener_with_synchronization_callbacks)* callbacks, 
                                                                                       void* context);

@DllImport("MSAJApi")
void alljoyn_keystorelistener_destroy(_alljoyn_keystorelistener_handle* listener);

@DllImport("MSAJApi")
QStatus alljoyn_keystorelistener_putkeys(_alljoyn_keystorelistener_handle* listener, 
                                         _alljoyn_keystore_handle* keyStore, const(byte)* source, 
                                         const(byte)* password);

@DllImport("MSAJApi")
QStatus alljoyn_keystorelistener_getkeys(_alljoyn_keystorelistener_handle* listener, 
                                         _alljoyn_keystore_handle* keyStore, byte* sink, size_t* sink_sz);

@DllImport("MSAJApi")
_alljoyn_sessionopts_handle* alljoyn_sessionopts_create(ubyte traffic, int isMultipoint, ubyte proximity, 
                                                        ushort transports);

@DllImport("MSAJApi")
void alljoyn_sessionopts_destroy(_alljoyn_sessionopts_handle* opts);

@DllImport("MSAJApi")
ubyte alljoyn_sessionopts_get_traffic(const(_alljoyn_sessionopts_handle)* opts);

@DllImport("MSAJApi")
void alljoyn_sessionopts_set_traffic(_alljoyn_sessionopts_handle* opts, ubyte traffic);

@DllImport("MSAJApi")
int alljoyn_sessionopts_get_multipoint(const(_alljoyn_sessionopts_handle)* opts);

@DllImport("MSAJApi")
void alljoyn_sessionopts_set_multipoint(_alljoyn_sessionopts_handle* opts, int isMultipoint);

@DllImport("MSAJApi")
ubyte alljoyn_sessionopts_get_proximity(const(_alljoyn_sessionopts_handle)* opts);

@DllImport("MSAJApi")
void alljoyn_sessionopts_set_proximity(_alljoyn_sessionopts_handle* opts, ubyte proximity);

@DllImport("MSAJApi")
ushort alljoyn_sessionopts_get_transports(const(_alljoyn_sessionopts_handle)* opts);

@DllImport("MSAJApi")
void alljoyn_sessionopts_set_transports(_alljoyn_sessionopts_handle* opts, ushort transports);

@DllImport("MSAJApi")
int alljoyn_sessionopts_iscompatible(const(_alljoyn_sessionopts_handle)* one, 
                                     const(_alljoyn_sessionopts_handle)* other);

@DllImport("MSAJApi")
int alljoyn_sessionopts_cmp(const(_alljoyn_sessionopts_handle)* one, const(_alljoyn_sessionopts_handle)* other);

@DllImport("MSAJApi")
_alljoyn_message_handle* alljoyn_message_create(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
void alljoyn_message_destroy(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
int alljoyn_message_isbroadcastsignal(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
int alljoyn_message_isglobalbroadcast(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
int alljoyn_message_issessionless(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
ubyte alljoyn_message_getflags(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
int alljoyn_message_isexpired(_alljoyn_message_handle* msg, uint* tillExpireMS);

@DllImport("MSAJApi")
int alljoyn_message_isunreliable(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
int alljoyn_message_isencrypted(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
byte* alljoyn_message_getauthmechanism(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
alljoyn_messagetype alljoyn_message_gettype(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
void alljoyn_message_getargs(_alljoyn_message_handle* msg, size_t* numArgs, _alljoyn_msgarg_handle** args);

@DllImport("MSAJApi")
_alljoyn_msgarg_handle* alljoyn_message_getarg(_alljoyn_message_handle* msg, size_t argN);

@DllImport("MSAJApi")
QStatus alljoyn_message_parseargs(_alljoyn_message_handle* msg, const(byte)* signature);

@DllImport("MSAJApi")
uint alljoyn_message_getcallserial(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
byte* alljoyn_message_getsignature(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
byte* alljoyn_message_getobjectpath(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
byte* alljoyn_message_getinterface(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
byte* alljoyn_message_getmembername(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
uint alljoyn_message_getreplyserial(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
byte* alljoyn_message_getsender(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
byte* alljoyn_message_getreceiveendpointname(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
byte* alljoyn_message_getdestination(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
uint alljoyn_message_getcompressiontoken(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
uint alljoyn_message_getsessionid(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
byte* alljoyn_message_geterrorname(_alljoyn_message_handle* msg, byte* errorMessage, size_t* errorMessage_size);

@DllImport("MSAJApi")
size_t alljoyn_message_tostring(_alljoyn_message_handle* msg, byte* str, size_t buf);

@DllImport("MSAJApi")
size_t alljoyn_message_description(_alljoyn_message_handle* msg, byte* str, size_t buf);

@DllImport("MSAJApi")
uint alljoyn_message_gettimestamp(_alljoyn_message_handle* msg);

@DllImport("MSAJApi")
int alljoyn_message_eql(const(_alljoyn_message_handle)* one, const(_alljoyn_message_handle)* other);

@DllImport("MSAJApi")
void alljoyn_message_setendianess(const(byte) endian);

@DllImport("MSAJApi")
QStatus alljoyn_authlistener_requestcredentialsresponse(_alljoyn_authlistener_handle* listener, void* authContext, 
                                                        int accept, _alljoyn_credentials_handle* credentials);

@DllImport("MSAJApi")
QStatus alljoyn_authlistener_verifycredentialsresponse(_alljoyn_authlistener_handle* listener, void* authContext, 
                                                       int accept);

@DllImport("MSAJApi")
_alljoyn_authlistener_handle* alljoyn_authlistener_create(const(alljoyn_authlistener_callbacks)* callbacks, 
                                                          const(void)* context);

@DllImport("MSAJApi")
_alljoyn_authlistener_handle* alljoyn_authlistenerasync_create(const(alljoyn_authlistenerasync_callbacks)* callbacks, 
                                                               const(void)* context);

@DllImport("MSAJApi")
void alljoyn_authlistener_destroy(_alljoyn_authlistener_handle* listener);

@DllImport("MSAJApi")
void alljoyn_authlistenerasync_destroy(_alljoyn_authlistener_handle* listener);

@DllImport("MSAJApi")
QStatus alljoyn_authlistener_setsharedsecret(_alljoyn_authlistener_handle* listener, const(ubyte)* sharedSecret, 
                                             size_t sharedSecretSize);

@DllImport("MSAJApi")
_alljoyn_credentials_handle* alljoyn_credentials_create();

@DllImport("MSAJApi")
void alljoyn_credentials_destroy(_alljoyn_credentials_handle* cred);

@DllImport("MSAJApi")
int alljoyn_credentials_isset(const(_alljoyn_credentials_handle)* cred, ushort creds);

@DllImport("MSAJApi")
void alljoyn_credentials_setpassword(_alljoyn_credentials_handle* cred, const(byte)* pwd);

@DllImport("MSAJApi")
void alljoyn_credentials_setusername(_alljoyn_credentials_handle* cred, const(byte)* userName);

@DllImport("MSAJApi")
void alljoyn_credentials_setcertchain(_alljoyn_credentials_handle* cred, const(byte)* certChain);

@DllImport("MSAJApi")
void alljoyn_credentials_setprivatekey(_alljoyn_credentials_handle* cred, const(byte)* pk);

@DllImport("MSAJApi")
void alljoyn_credentials_setlogonentry(_alljoyn_credentials_handle* cred, const(byte)* logonEntry);

@DllImport("MSAJApi")
void alljoyn_credentials_setexpiration(_alljoyn_credentials_handle* cred, uint expiration);

@DllImport("MSAJApi")
byte* alljoyn_credentials_getpassword(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi")
byte* alljoyn_credentials_getusername(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi")
byte* alljoyn_credentials_getcertchain(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi")
byte* alljoyn_credentials_getprivateKey(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi")
byte* alljoyn_credentials_getlogonentry(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi")
uint alljoyn_credentials_getexpiration(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi")
void alljoyn_credentials_clear(_alljoyn_credentials_handle* cred);

@DllImport("MSAJApi")
_alljoyn_buslistener_handle* alljoyn_buslistener_create(const(alljoyn_buslistener_callbacks)* callbacks, 
                                                        const(void)* context);

@DllImport("MSAJApi")
void alljoyn_buslistener_destroy(_alljoyn_buslistener_handle* listener);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_member_getannotationscount(alljoyn_interfacedescription_member member);

@DllImport("MSAJApi")
void alljoyn_interfacedescription_member_getannotationatindex(alljoyn_interfacedescription_member member, 
                                                              size_t index, byte* name, size_t* name_size, 
                                                              byte* value, size_t* value_size);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_member_getannotation(alljoyn_interfacedescription_member member, 
                                                      const(byte)* name, byte* value, size_t* value_size);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_member_getargannotationscount(alljoyn_interfacedescription_member member, 
                                                                  const(byte)* argName);

@DllImport("MSAJApi")
void alljoyn_interfacedescription_member_getargannotationatindex(alljoyn_interfacedescription_member member, 
                                                                 const(byte)* argName, size_t index, byte* name, 
                                                                 size_t* name_size, byte* value, size_t* value_size);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_member_getargannotation(alljoyn_interfacedescription_member member, 
                                                         const(byte)* argName, const(byte)* name, byte* value, 
                                                         size_t* value_size);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_property_getannotationscount(alljoyn_interfacedescription_property property);

@DllImport("MSAJApi")
void alljoyn_interfacedescription_property_getannotationatindex(alljoyn_interfacedescription_property property, 
                                                                size_t index, byte* name, size_t* name_size, 
                                                                byte* value, size_t* value_size);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_property_getannotation(alljoyn_interfacedescription_property property, 
                                                        const(byte)* name, byte* value, size_t* value_size);

@DllImport("MSAJApi")
void alljoyn_interfacedescription_activate(_alljoyn_interfacedescription_handle* iface);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_addannotation(_alljoyn_interfacedescription_handle* iface, const(byte)* name, 
                                                   const(byte)* value);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_getannotation(_alljoyn_interfacedescription_handle* iface, const(byte)* name, 
                                               byte* value, size_t* value_size);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_getannotationscount(_alljoyn_interfacedescription_handle* iface);

@DllImport("MSAJApi")
void alljoyn_interfacedescription_getannotationatindex(_alljoyn_interfacedescription_handle* iface, size_t index, 
                                                       byte* name, size_t* name_size, byte* value, 
                                                       size_t* value_size);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_getmember(const(_alljoyn_interfacedescription_handle)* iface, const(byte)* name, 
                                           alljoyn_interfacedescription_member* member);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_addmember(_alljoyn_interfacedescription_handle* iface, 
                                               alljoyn_messagetype type, const(byte)* name, const(byte)* inputSig, 
                                               const(byte)* outSig, const(byte)* argNames, ubyte annotation);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_addmemberannotation(_alljoyn_interfacedescription_handle* iface, 
                                                         const(byte)* member, const(byte)* name, const(byte)* value);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_getmemberannotation(_alljoyn_interfacedescription_handle* iface, 
                                                     const(byte)* member, const(byte)* name, byte* value, 
                                                     size_t* value_size);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_getmembers(const(_alljoyn_interfacedescription_handle)* iface, 
                                               alljoyn_interfacedescription_member* members, size_t numMembers);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_hasmember(_alljoyn_interfacedescription_handle* iface, const(byte)* name, 
                                           const(byte)* inSig, const(byte)* outSig);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_addmethod(_alljoyn_interfacedescription_handle* iface, const(byte)* name, 
                                               const(byte)* inputSig, const(byte)* outSig, const(byte)* argNames, 
                                               ubyte annotation, const(byte)* accessPerms);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_getmethod(_alljoyn_interfacedescription_handle* iface, const(byte)* name, 
                                           alljoyn_interfacedescription_member* member);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_addsignal(_alljoyn_interfacedescription_handle* iface, const(byte)* name, 
                                               const(byte)* sig, const(byte)* argNames, ubyte annotation, 
                                               const(byte)* accessPerms);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_getsignal(_alljoyn_interfacedescription_handle* iface, const(byte)* name, 
                                           alljoyn_interfacedescription_member* member);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_getproperty(const(_alljoyn_interfacedescription_handle)* iface, const(byte)* name, 
                                             alljoyn_interfacedescription_property* property);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_getproperties(const(_alljoyn_interfacedescription_handle)* iface, 
                                                  alljoyn_interfacedescription_property* props, size_t numProps);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_addproperty(_alljoyn_interfacedescription_handle* iface, const(byte)* name, 
                                                 const(byte)* signature, ubyte access);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_addpropertyannotation(_alljoyn_interfacedescription_handle* iface, 
                                                           const(byte)* property, const(byte)* name, 
                                                           const(byte)* value);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_getpropertyannotation(_alljoyn_interfacedescription_handle* iface, 
                                                       const(byte)* property, const(byte)* name, byte* value, 
                                                       size_t* str_size);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_hasproperty(const(_alljoyn_interfacedescription_handle)* iface, const(byte)* name);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_hasproperties(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi")
byte* alljoyn_interfacedescription_getname(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_introspect(const(_alljoyn_interfacedescription_handle)* iface, byte* str, 
                                               size_t buf, size_t indent);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_issecure(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi")
alljoyn_interfacedescription_securitypolicy alljoyn_interfacedescription_getsecuritypolicy(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi")
void alljoyn_interfacedescription_setdescriptionlanguage(_alljoyn_interfacedescription_handle* iface, 
                                                         const(byte)* language);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_getdescriptionlanguages(const(_alljoyn_interfacedescription_handle)* iface, 
                                                            const(byte)** languages, size_t size);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_getdescriptionlanguages2(const(_alljoyn_interfacedescription_handle)* iface, 
                                                             byte* languages, size_t languagesSize);

@DllImport("MSAJApi")
void alljoyn_interfacedescription_setdescription(_alljoyn_interfacedescription_handle* iface, 
                                                 const(byte)* description);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_setdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, 
                                                               const(byte)* description, const(byte)* languageTag);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_getdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, 
                                                              byte* description, size_t maxLanguageLength, 
                                                              const(byte)* languageTag);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_setmemberdescription(_alljoyn_interfacedescription_handle* iface, 
                                                          const(byte)* member, const(byte)* description);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_setmemberdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, 
                                                                     const(byte)* member, const(byte)* description, 
                                                                     const(byte)* languageTag);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_getmemberdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, 
                                                                    const(byte)* member, byte* description, 
                                                                    size_t maxLanguageLength, 
                                                                    const(byte)* languageTag);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_setargdescription(_alljoyn_interfacedescription_handle* iface, 
                                                       const(byte)* member, const(byte)* argName, 
                                                       const(byte)* description);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_setargdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, 
                                                                  const(byte)* member, const(byte)* arg, 
                                                                  const(byte)* description, const(byte)* languageTag);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_getargdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, 
                                                                 const(byte)* member, const(byte)* arg, 
                                                                 byte* description, size_t maxLanguageLength, 
                                                                 const(byte)* languageTag);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_setpropertydescription(_alljoyn_interfacedescription_handle* iface, 
                                                            const(byte)* name, const(byte)* description);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_setpropertydescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, 
                                                                       const(byte)* name, const(byte)* description, 
                                                                       const(byte)* languageTag);

@DllImport("MSAJApi")
size_t alljoyn_interfacedescription_getpropertydescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, 
                                                                      const(byte)* property, byte* description, 
                                                                      size_t maxLanguageLength, 
                                                                      const(byte)* languageTag);

@DllImport("MSAJApi")
void alljoyn_interfacedescription_setdescriptiontranslationcallback(_alljoyn_interfacedescription_handle* iface, 
                                                                    alljoyn_interfacedescription_translation_callback_ptr translationCallback);

@DllImport("MSAJApi")
alljoyn_interfacedescription_translation_callback_ptr alljoyn_interfacedescription_getdescriptiontranslationcallback(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_hasdescription(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi")
QStatus alljoyn_interfacedescription_addargannotation(_alljoyn_interfacedescription_handle* iface, 
                                                      const(byte)* member, const(byte)* argName, const(byte)* name, 
                                                      const(byte)* value);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_getmemberargannotation(const(_alljoyn_interfacedescription_handle)* iface, 
                                                        const(byte)* member, const(byte)* argName, const(byte)* name, 
                                                        byte* value, size_t* value_size);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_eql(const(_alljoyn_interfacedescription_handle)* one, 
                                     const(_alljoyn_interfacedescription_handle)* other);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_member_eql(const(alljoyn_interfacedescription_member) one, 
                                            const(alljoyn_interfacedescription_member) other);

@DllImport("MSAJApi")
int alljoyn_interfacedescription_property_eql(const(alljoyn_interfacedescription_property) one, 
                                              const(alljoyn_interfacedescription_property) other);

@DllImport("MSAJApi")
_alljoyn_busobject_handle* alljoyn_busobject_create(const(byte)* path, int isPlaceholder, 
                                                    const(alljoyn_busobject_callbacks)* callbacks_in, 
                                                    const(void)* context_in);

@DllImport("MSAJApi")
void alljoyn_busobject_destroy(_alljoyn_busobject_handle* bus);

@DllImport("MSAJApi")
byte* alljoyn_busobject_getpath(_alljoyn_busobject_handle* bus);

@DllImport("MSAJApi")
void alljoyn_busobject_emitpropertychanged(_alljoyn_busobject_handle* bus, const(byte)* ifcName, 
                                           const(byte)* propName, _alljoyn_msgarg_handle* val, uint id);

@DllImport("MSAJApi")
void alljoyn_busobject_emitpropertieschanged(_alljoyn_busobject_handle* bus, const(byte)* ifcName, 
                                             const(byte)** propNames, size_t numProps, uint id);

@DllImport("MSAJApi")
size_t alljoyn_busobject_getname(_alljoyn_busobject_handle* bus, byte* buffer, size_t bufferSz);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_addinterface(_alljoyn_busobject_handle* bus, 
                                       const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_addmethodhandler(_alljoyn_busobject_handle* bus, 
                                           const(alljoyn_interfacedescription_member) member, 
                                           alljoyn_messagereceiver_methodhandler_ptr handler, void* context);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_addmethodhandlers(_alljoyn_busobject_handle* bus, 
                                            const(alljoyn_busobject_methodentry)* entries, size_t numEntries);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_methodreply_args(_alljoyn_busobject_handle* bus, _alljoyn_message_handle* msg, 
                                           const(_alljoyn_msgarg_handle)* args, size_t numArgs);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_methodreply_err(_alljoyn_busobject_handle* bus, _alljoyn_message_handle* msg, 
                                          const(byte)* error, const(byte)* errorMessage);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_methodreply_status(_alljoyn_busobject_handle* bus, _alljoyn_message_handle* msg, 
                                             QStatus status);

@DllImport("MSAJApi")
_alljoyn_busattachment_handle* alljoyn_busobject_getbusattachment(_alljoyn_busobject_handle* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_signal(_alljoyn_busobject_handle* bus, const(byte)* destination, uint sessionId, 
                                 const(alljoyn_interfacedescription_member) signal, 
                                 const(_alljoyn_msgarg_handle)* args, size_t numArgs, ushort timeToLive, ubyte flags, 
                                 _alljoyn_message_handle* msg);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_cancelsessionlessmessage_serial(_alljoyn_busobject_handle* bus, uint serialNumber);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_cancelsessionlessmessage(_alljoyn_busobject_handle* bus, 
                                                   const(_alljoyn_message_handle)* msg);

@DllImport("MSAJApi")
int alljoyn_busobject_issecure(_alljoyn_busobject_handle* bus);

@DllImport("MSAJApi")
size_t alljoyn_busobject_getannouncedinterfacenames(_alljoyn_busobject_handle* bus, const(byte)** interfaces, 
                                                    size_t numInterfaces);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_setannounceflag(_alljoyn_busobject_handle* bus, 
                                          const(_alljoyn_interfacedescription_handle)* iface, 
                                          alljoyn_about_announceflag isAnnounced);

@DllImport("MSAJApi")
QStatus alljoyn_busobject_addinterface_announced(_alljoyn_busobject_handle* bus, 
                                                 const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_handle* alljoyn_proxybusobject_create(_alljoyn_busattachment_handle* bus, 
                                                              const(byte)* service, const(byte)* path, 
                                                              uint sessionId);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_handle* alljoyn_proxybusobject_create_secure(_alljoyn_busattachment_handle* bus, 
                                                                     const(byte)* service, const(byte)* path, 
                                                                     uint sessionId);

@DllImport("MSAJApi")
void alljoyn_proxybusobject_destroy(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_addinterface(_alljoyn_proxybusobject_handle* proxyObj, 
                                            const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_addinterface_by_name(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* name);

@DllImport("MSAJApi")
size_t alljoyn_proxybusobject_getchildren(_alljoyn_proxybusobject_handle* proxyObj, 
                                          _alljoyn_proxybusobject_handle** children, size_t numChildren);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_handle* alljoyn_proxybusobject_getchild(_alljoyn_proxybusobject_handle* proxyObj, 
                                                                const(byte)* path);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_addchild(_alljoyn_proxybusobject_handle* proxyObj, 
                                        const(_alljoyn_proxybusobject_handle)* child);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_removechild(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* path);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_introspectremoteobject(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_introspectremoteobjectasync(_alljoyn_proxybusobject_handle* proxyObj, 
                                                           alljoyn_proxybusobject_listener_introspectcb_ptr callback, 
                                                           void* context);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_getproperty(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, 
                                           const(byte)* property, _alljoyn_msgarg_handle* value);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_getpropertyasync(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, 
                                                const(byte)* property, 
                                                alljoyn_proxybusobject_listener_getpropertycb_ptr callback, 
                                                uint timeout, void* context);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_getallproperties(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, 
                                                _alljoyn_msgarg_handle* values);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_getallpropertiesasync(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, 
                                                     alljoyn_proxybusobject_listener_getallpropertiescb_ptr callback, 
                                                     uint timeout, void* context);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_setproperty(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, 
                                           const(byte)* property, _alljoyn_msgarg_handle* value);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_registerpropertieschangedlistener(_alljoyn_proxybusobject_handle* proxyObj, 
                                                                 const(byte)* iface, const(byte)** properties, 
                                                                 size_t numProperties, 
                                                                 alljoyn_proxybusobject_listener_propertieschanged_ptr callback, 
                                                                 void* context);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_unregisterpropertieschangedlistener(_alljoyn_proxybusobject_handle* proxyObj, 
                                                                   const(byte)* iface, 
                                                                   alljoyn_proxybusobject_listener_propertieschanged_ptr callback);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_setpropertyasync(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, 
                                                const(byte)* property, _alljoyn_msgarg_handle* value, 
                                                alljoyn_proxybusobject_listener_setpropertycb_ptr callback, 
                                                uint timeout, void* context);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_methodcall(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* ifaceName, 
                                          const(byte)* methodName, const(_alljoyn_msgarg_handle)* args, 
                                          size_t numArgs, _alljoyn_message_handle* replyMsg, uint timeout, 
                                          ubyte flags);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_methodcall_member(_alljoyn_proxybusobject_handle* proxyObj, 
                                                 const(alljoyn_interfacedescription_member) method, 
                                                 const(_alljoyn_msgarg_handle)* args, size_t numArgs, 
                                                 _alljoyn_message_handle* replyMsg, uint timeout, ubyte flags);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_methodcall_noreply(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* ifaceName, 
                                                  const(byte)* methodName, const(_alljoyn_msgarg_handle)* args, 
                                                  size_t numArgs, ubyte flags);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_methodcall_member_noreply(_alljoyn_proxybusobject_handle* proxyObj, 
                                                         const(alljoyn_interfacedescription_member) method, 
                                                         const(_alljoyn_msgarg_handle)* args, size_t numArgs, 
                                                         ubyte flags);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_methodcallasync(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* ifaceName, 
                                               const(byte)* methodName, 
                                               alljoyn_messagereceiver_replyhandler_ptr replyFunc, 
                                               const(_alljoyn_msgarg_handle)* args, size_t numArgs, void* context, 
                                               uint timeout, ubyte flags);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_methodcallasync_member(_alljoyn_proxybusobject_handle* proxyObj, 
                                                      const(alljoyn_interfacedescription_member) method, 
                                                      alljoyn_messagereceiver_replyhandler_ptr replyFunc, 
                                                      const(_alljoyn_msgarg_handle)* args, size_t numArgs, 
                                                      void* context, uint timeout, ubyte flags);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_parsexml(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* xml, 
                                        const(byte)* identifier);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_secureconnection(_alljoyn_proxybusobject_handle* proxyObj, int forceAuth);

@DllImport("MSAJApi")
QStatus alljoyn_proxybusobject_secureconnectionasync(_alljoyn_proxybusobject_handle* proxyObj, int forceAuth);

@DllImport("MSAJApi")
_alljoyn_interfacedescription_handle* alljoyn_proxybusobject_getinterface(_alljoyn_proxybusobject_handle* proxyObj, 
                                                                          const(byte)* iface);

@DllImport("MSAJApi")
size_t alljoyn_proxybusobject_getinterfaces(_alljoyn_proxybusobject_handle* proxyObj, 
                                            const(_alljoyn_interfacedescription_handle)** ifaces, size_t numIfaces);

@DllImport("MSAJApi")
byte* alljoyn_proxybusobject_getpath(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi")
byte* alljoyn_proxybusobject_getservicename(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi")
byte* alljoyn_proxybusobject_getuniquename(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi")
uint alljoyn_proxybusobject_getsessionid(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi")
int alljoyn_proxybusobject_implementsinterface(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_handle* alljoyn_proxybusobject_copy(const(_alljoyn_proxybusobject_handle)* source);

@DllImport("MSAJApi")
int alljoyn_proxybusobject_isvalid(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi")
int alljoyn_proxybusobject_issecure(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi")
void alljoyn_proxybusobject_enablepropertycaching(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi")
_alljoyn_permissionconfigurationlistener_handle* alljoyn_permissionconfigurationlistener_create(const(alljoyn_permissionconfigurationlistener_callbacks)* callbacks, 
                                                                                                const(void)* context);

@DllImport("MSAJApi")
void alljoyn_permissionconfigurationlistener_destroy(_alljoyn_permissionconfigurationlistener_handle* listener);

@DllImport("MSAJApi")
_alljoyn_sessionlistener_handle* alljoyn_sessionlistener_create(const(alljoyn_sessionlistener_callbacks)* callbacks, 
                                                                const(void)* context);

@DllImport("MSAJApi")
void alljoyn_sessionlistener_destroy(_alljoyn_sessionlistener_handle* listener);

@DllImport("MSAJApi")
_alljoyn_sessionportlistener_handle* alljoyn_sessionportlistener_create(const(alljoyn_sessionportlistener_callbacks)* callbacks, 
                                                                        const(void)* context);

@DllImport("MSAJApi")
void alljoyn_sessionportlistener_destroy(_alljoyn_sessionportlistener_handle* listener);

@DllImport("MSAJApi")
_alljoyn_aboutlistener_handle* alljoyn_aboutlistener_create(const(alljoyn_aboutlistener_callback)* callback, 
                                                            const(void)* context);

@DllImport("MSAJApi")
void alljoyn_aboutlistener_destroy(_alljoyn_aboutlistener_handle* listener);

@DllImport("MSAJApi")
_alljoyn_busattachment_handle* alljoyn_busattachment_create(const(byte)* applicationName, int allowRemoteMessages);

@DllImport("MSAJApi")
_alljoyn_busattachment_handle* alljoyn_busattachment_create_concurrency(const(byte)* applicationName, 
                                                                        int allowRemoteMessages, uint concurrency);

@DllImport("MSAJApi")
void alljoyn_busattachment_destroy(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_start(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_stop(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_join(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
uint alljoyn_busattachment_getconcurrency(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
byte* alljoyn_busattachment_getconnectspec(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
void alljoyn_busattachment_enableconcurrentcallbacks(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_createinterface(_alljoyn_busattachment_handle* bus, const(byte)* name, 
                                              _alljoyn_interfacedescription_handle** iface);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_createinterface_secure(_alljoyn_busattachment_handle* bus, const(byte)* name, 
                                                     _alljoyn_interfacedescription_handle** iface, 
                                                     alljoyn_interfacedescription_securitypolicy secPolicy);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_connect(_alljoyn_busattachment_handle* bus, const(byte)* connectSpec);

@DllImport("MSAJApi")
void alljoyn_busattachment_registerbuslistener(_alljoyn_busattachment_handle* bus, 
                                               _alljoyn_buslistener_handle* listener);

@DllImport("MSAJApi")
void alljoyn_busattachment_unregisterbuslistener(_alljoyn_busattachment_handle* bus, 
                                                 _alljoyn_buslistener_handle* listener);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_findadvertisedname(_alljoyn_busattachment_handle* bus, const(byte)* namePrefix);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_findadvertisednamebytransport(_alljoyn_busattachment_handle* bus, 
                                                            const(byte)* namePrefix, ushort transports);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_cancelfindadvertisedname(_alljoyn_busattachment_handle* bus, const(byte)* namePrefix);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_cancelfindadvertisednamebytransport(_alljoyn_busattachment_handle* bus, 
                                                                  const(byte)* namePrefix, ushort transports);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_advertisename(_alljoyn_busattachment_handle* bus, const(byte)* name, 
                                            ushort transports);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_canceladvertisename(_alljoyn_busattachment_handle* bus, const(byte)* name, 
                                                  ushort transports);

@DllImport("MSAJApi")
_alljoyn_interfacedescription_handle* alljoyn_busattachment_getinterface(_alljoyn_busattachment_handle* bus, 
                                                                         const(byte)* name);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_joinsession(_alljoyn_busattachment_handle* bus, const(byte)* sessionHost, 
                                          ushort sessionPort, _alljoyn_sessionlistener_handle* listener, 
                                          uint* sessionId, _alljoyn_sessionopts_handle* opts);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_joinsessionasync(_alljoyn_busattachment_handle* bus, const(byte)* sessionHost, 
                                               ushort sessionPort, _alljoyn_sessionlistener_handle* listener, 
                                               const(_alljoyn_sessionopts_handle)* opts, 
                                               alljoyn_busattachment_joinsessioncb_ptr callback, void* context);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_registerbusobject(_alljoyn_busattachment_handle* bus, _alljoyn_busobject_handle* obj);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_registerbusobject_secure(_alljoyn_busattachment_handle* bus, 
                                                       _alljoyn_busobject_handle* obj);

@DllImport("MSAJApi")
void alljoyn_busattachment_unregisterbusobject(_alljoyn_busattachment_handle* bus, 
                                               _alljoyn_busobject_handle* object);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_requestname(_alljoyn_busattachment_handle* bus, const(byte)* requestedName, 
                                          uint flags);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_releasename(_alljoyn_busattachment_handle* bus, const(byte)* name);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_bindsessionport(_alljoyn_busattachment_handle* bus, ushort* sessionPort, 
                                              const(_alljoyn_sessionopts_handle)* opts, 
                                              _alljoyn_sessionportlistener_handle* listener);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_unbindsessionport(_alljoyn_busattachment_handle* bus, ushort sessionPort);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_enablepeersecurity(_alljoyn_busattachment_handle* bus, const(byte)* authMechanisms, 
                                                 _alljoyn_authlistener_handle* listener, 
                                                 const(byte)* keyStoreFileName, int isShared);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_enablepeersecuritywithpermissionconfigurationlistener(_alljoyn_busattachment_handle* bus, 
                                                                                    const(byte)* authMechanisms, 
                                                                                    _alljoyn_authlistener_handle* authListener, 
                                                                                    const(byte)* keyStoreFileName, 
                                                                                    int isShared, 
                                                                                    _alljoyn_permissionconfigurationlistener_handle* permissionConfigurationListener);

@DllImport("MSAJApi")
int alljoyn_busattachment_ispeersecurityenabled(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_createinterfacesfromxml(_alljoyn_busattachment_handle* bus, const(byte)* xml);

@DllImport("MSAJApi")
size_t alljoyn_busattachment_getinterfaces(const(_alljoyn_busattachment_handle)* bus, 
                                           const(_alljoyn_interfacedescription_handle)** ifaces, size_t numIfaces);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_deleteinterface(_alljoyn_busattachment_handle* bus, 
                                              _alljoyn_interfacedescription_handle* iface);

@DllImport("MSAJApi")
int alljoyn_busattachment_isstarted(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
int alljoyn_busattachment_isstopping(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
int alljoyn_busattachment_isconnected(const(_alljoyn_busattachment_handle)* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_disconnect(_alljoyn_busattachment_handle* bus, const(byte)* unused);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_handle* alljoyn_busattachment_getdbusproxyobj(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_handle* alljoyn_busattachment_getalljoynproxyobj(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_handle* alljoyn_busattachment_getalljoyndebugobj(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
byte* alljoyn_busattachment_getuniquename(const(_alljoyn_busattachment_handle)* bus);

@DllImport("MSAJApi")
byte* alljoyn_busattachment_getglobalguidstring(const(_alljoyn_busattachment_handle)* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_registersignalhandler(_alljoyn_busattachment_handle* bus, 
                                                    alljoyn_messagereceiver_signalhandler_ptr signal_handler, 
                                                    const(alljoyn_interfacedescription_member) member, 
                                                    const(byte)* srcPath);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_registersignalhandlerwithrule(_alljoyn_busattachment_handle* bus, 
                                                            alljoyn_messagereceiver_signalhandler_ptr signal_handler, 
                                                            const(alljoyn_interfacedescription_member) member, 
                                                            const(byte)* matchRule);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_unregistersignalhandler(_alljoyn_busattachment_handle* bus, 
                                                      alljoyn_messagereceiver_signalhandler_ptr signal_handler, 
                                                      const(alljoyn_interfacedescription_member) member, 
                                                      const(byte)* srcPath);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_unregistersignalhandlerwithrule(_alljoyn_busattachment_handle* bus, 
                                                              alljoyn_messagereceiver_signalhandler_ptr signal_handler, 
                                                              const(alljoyn_interfacedescription_member) member, 
                                                              const(byte)* matchRule);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_unregisterallhandlers(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_registerkeystorelistener(_alljoyn_busattachment_handle* bus, 
                                                       _alljoyn_keystorelistener_handle* listener);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_reloadkeystore(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
void alljoyn_busattachment_clearkeystore(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_clearkeys(_alljoyn_busattachment_handle* bus, const(byte)* guid);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_setkeyexpiration(_alljoyn_busattachment_handle* bus, const(byte)* guid, uint timeout);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_getkeyexpiration(_alljoyn_busattachment_handle* bus, const(byte)* guid, 
                                               uint* timeout);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_addlogonentry(_alljoyn_busattachment_handle* bus, const(byte)* authMechanism, 
                                            const(byte)* userName, const(byte)* password);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_addmatch(_alljoyn_busattachment_handle* bus, const(byte)* rule);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_removematch(_alljoyn_busattachment_handle* bus, const(byte)* rule);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_setsessionlistener(_alljoyn_busattachment_handle* bus, uint sessionId, 
                                                 _alljoyn_sessionlistener_handle* listener);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_leavesession(_alljoyn_busattachment_handle* bus, uint sessionId);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_secureconnection(_alljoyn_busattachment_handle* bus, const(byte)* name, 
                                               int forceAuth);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_secureconnectionasync(_alljoyn_busattachment_handle* bus, const(byte)* name, 
                                                    int forceAuth);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_removesessionmember(_alljoyn_busattachment_handle* bus, uint sessionId, 
                                                  const(byte)* memberName);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_setlinktimeout(_alljoyn_busattachment_handle* bus, uint sessionid, uint* linkTimeout);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_setlinktimeoutasync(_alljoyn_busattachment_handle* bus, uint sessionid, 
                                                  uint linkTimeout, 
                                                  alljoyn_busattachment_setlinktimeoutcb_ptr callback, void* context);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_namehasowner(_alljoyn_busattachment_handle* bus, const(byte)* name, int* hasOwner);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_getpeerguid(_alljoyn_busattachment_handle* bus, const(byte)* name, byte* guid, 
                                          size_t* guidSz);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_setdaemondebug(_alljoyn_busattachment_handle* bus, const(byte)* module_, uint level);

@DllImport("MSAJApi")
uint alljoyn_busattachment_gettimestamp();

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_ping(_alljoyn_busattachment_handle* bus, const(byte)* name, uint timeout);

@DllImport("MSAJApi")
void alljoyn_busattachment_registeraboutlistener(_alljoyn_busattachment_handle* bus, 
                                                 _alljoyn_aboutlistener_handle* aboutListener);

@DllImport("MSAJApi")
void alljoyn_busattachment_unregisteraboutlistener(_alljoyn_busattachment_handle* bus, 
                                                   _alljoyn_aboutlistener_handle* aboutListener);

@DllImport("MSAJApi")
void alljoyn_busattachment_unregisterallaboutlisteners(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_whoimplements_interfaces(_alljoyn_busattachment_handle* bus, 
                                                       const(byte)** implementsInterfaces, size_t numberInterfaces);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_whoimplements_interface(_alljoyn_busattachment_handle* bus, 
                                                      const(byte)* implementsInterface);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_cancelwhoimplements_interfaces(_alljoyn_busattachment_handle* bus, 
                                                             const(byte)** implementsInterfaces, 
                                                             size_t numberInterfaces);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_cancelwhoimplements_interface(_alljoyn_busattachment_handle* bus, 
                                                            const(byte)* implementsInterface);

@DllImport("MSAJApi")
_alljoyn_permissionconfigurator_handle* alljoyn_busattachment_getpermissionconfigurator(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_registerapplicationstatelistener(_alljoyn_busattachment_handle* bus, 
                                                               _alljoyn_applicationstatelistener_handle* listener);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_unregisterapplicationstatelistener(_alljoyn_busattachment_handle* bus, 
                                                                 _alljoyn_applicationstatelistener_handle* listener);

@DllImport("MSAJApi")
QStatus alljoyn_busattachment_deletedefaultkeystore(const(byte)* applicationName);

@DllImport("MSAJApi")
_alljoyn_aboutobj_handle* alljoyn_aboutobj_create(_alljoyn_busattachment_handle* bus, 
                                                  alljoyn_about_announceflag isAnnounced);

@DllImport("MSAJApi")
void alljoyn_aboutobj_destroy(_alljoyn_aboutobj_handle* obj);

@DllImport("MSAJApi")
QStatus alljoyn_aboutobj_announce(_alljoyn_aboutobj_handle* obj, ushort sessionPort, 
                                  _alljoyn_aboutdata_handle* aboutData);

@DllImport("MSAJApi")
QStatus alljoyn_aboutobj_announce_using_datalistener(_alljoyn_aboutobj_handle* obj, ushort sessionPort, 
                                                     _alljoyn_aboutdatalistener_handle* aboutListener);

@DllImport("MSAJApi")
QStatus alljoyn_aboutobj_unannounce(_alljoyn_aboutobj_handle* obj);

@DllImport("MSAJApi")
_alljoyn_aboutobjectdescription_handle* alljoyn_aboutobjectdescription_create();

@DllImport("MSAJApi")
_alljoyn_aboutobjectdescription_handle* alljoyn_aboutobjectdescription_create_full(const(_alljoyn_msgarg_handle)* arg);

@DllImport("MSAJApi")
QStatus alljoyn_aboutobjectdescription_createfrommsgarg(_alljoyn_aboutobjectdescription_handle* description, 
                                                        const(_alljoyn_msgarg_handle)* arg);

@DllImport("MSAJApi")
void alljoyn_aboutobjectdescription_destroy(_alljoyn_aboutobjectdescription_handle* description);

@DllImport("MSAJApi")
size_t alljoyn_aboutobjectdescription_getpaths(_alljoyn_aboutobjectdescription_handle* description, 
                                               const(byte)** paths, size_t numPaths);

@DllImport("MSAJApi")
size_t alljoyn_aboutobjectdescription_getinterfaces(_alljoyn_aboutobjectdescription_handle* description, 
                                                    const(byte)* path, const(byte)** interfaces, 
                                                    size_t numInterfaces);

@DllImport("MSAJApi")
size_t alljoyn_aboutobjectdescription_getinterfacepaths(_alljoyn_aboutobjectdescription_handle* description, 
                                                        const(byte)* interfaceName, const(byte)** paths, 
                                                        size_t numPaths);

@DllImport("MSAJApi")
void alljoyn_aboutobjectdescription_clear(_alljoyn_aboutobjectdescription_handle* description);

@DllImport("MSAJApi")
ubyte alljoyn_aboutobjectdescription_haspath(_alljoyn_aboutobjectdescription_handle* description, 
                                             const(byte)* path);

@DllImport("MSAJApi")
ubyte alljoyn_aboutobjectdescription_hasinterface(_alljoyn_aboutobjectdescription_handle* description, 
                                                  const(byte)* interfaceName);

@DllImport("MSAJApi")
ubyte alljoyn_aboutobjectdescription_hasinterfaceatpath(_alljoyn_aboutobjectdescription_handle* description, 
                                                        const(byte)* path, const(byte)* interfaceName);

@DllImport("MSAJApi")
QStatus alljoyn_aboutobjectdescription_getmsgarg(_alljoyn_aboutobjectdescription_handle* description, 
                                                 _alljoyn_msgarg_handle* msgArg);

@DllImport("MSAJApi")
_alljoyn_aboutproxy_handle* alljoyn_aboutproxy_create(_alljoyn_busattachment_handle* bus, const(byte)* busName, 
                                                      uint sessionId);

@DllImport("MSAJApi")
void alljoyn_aboutproxy_destroy(_alljoyn_aboutproxy_handle* proxy);

@DllImport("MSAJApi")
QStatus alljoyn_aboutproxy_getobjectdescription(_alljoyn_aboutproxy_handle* proxy, 
                                                _alljoyn_msgarg_handle* objectDesc);

@DllImport("MSAJApi")
QStatus alljoyn_aboutproxy_getaboutdata(_alljoyn_aboutproxy_handle* proxy, const(byte)* language, 
                                        _alljoyn_msgarg_handle* data);

@DllImport("MSAJApi")
QStatus alljoyn_aboutproxy_getversion(_alljoyn_aboutproxy_handle* proxy, ushort* version_);

@DllImport("MSAJApi")
_alljoyn_pinglistener_handle* alljoyn_pinglistener_create(const(alljoyn_pinglistener_callback)* callback, 
                                                          const(void)* context);

@DllImport("MSAJApi")
void alljoyn_pinglistener_destroy(_alljoyn_pinglistener_handle* listener);

@DllImport("MSAJApi")
_alljoyn_autopinger_handle* alljoyn_autopinger_create(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi")
void alljoyn_autopinger_destroy(_alljoyn_autopinger_handle* autopinger);

@DllImport("MSAJApi")
void alljoyn_autopinger_pause(_alljoyn_autopinger_handle* autopinger);

@DllImport("MSAJApi")
void alljoyn_autopinger_resume(_alljoyn_autopinger_handle* autopinger);

@DllImport("MSAJApi")
void alljoyn_autopinger_addpinggroup(_alljoyn_autopinger_handle* autopinger, const(byte)* group, 
                                     _alljoyn_pinglistener_handle* listener, uint pinginterval);

@DllImport("MSAJApi")
void alljoyn_autopinger_removepinggroup(_alljoyn_autopinger_handle* autopinger, const(byte)* group);

@DllImport("MSAJApi")
QStatus alljoyn_autopinger_setpinginterval(_alljoyn_autopinger_handle* autopinger, const(byte)* group, 
                                           uint pinginterval);

@DllImport("MSAJApi")
QStatus alljoyn_autopinger_adddestination(_alljoyn_autopinger_handle* autopinger, const(byte)* group, 
                                          const(byte)* destination);

@DllImport("MSAJApi")
QStatus alljoyn_autopinger_removedestination(_alljoyn_autopinger_handle* autopinger, const(byte)* group, 
                                             const(byte)* destination, int removeall);

@DllImport("MSAJApi")
byte* alljoyn_getversion();

@DllImport("MSAJApi")
byte* alljoyn_getbuildinfo();

@DllImport("MSAJApi")
uint alljoyn_getnumericversion();

@DllImport("MSAJApi")
QStatus alljoyn_init();

@DllImport("MSAJApi")
QStatus alljoyn_shutdown();

@DllImport("MSAJApi")
QStatus alljoyn_routerinit();

@DllImport("MSAJApi")
QStatus alljoyn_routerinitwithconfig(byte* configXml);

@DllImport("MSAJApi")
QStatus alljoyn_routershutdown();

@DllImport("MSAJApi")
_alljoyn_proxybusobject_ref_handle* alljoyn_proxybusobject_ref_create(_alljoyn_proxybusobject_handle* proxy);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_handle* alljoyn_proxybusobject_ref_get(_alljoyn_proxybusobject_ref_handle* ref_);

@DllImport("MSAJApi")
void alljoyn_proxybusobject_ref_incref(_alljoyn_proxybusobject_ref_handle* ref_);

@DllImport("MSAJApi")
void alljoyn_proxybusobject_ref_decref(_alljoyn_proxybusobject_ref_handle* ref_);

@DllImport("MSAJApi")
_alljoyn_observerlistener_handle* alljoyn_observerlistener_create(const(alljoyn_observerlistener_callback)* callback, 
                                                                  const(void)* context);

@DllImport("MSAJApi")
void alljoyn_observerlistener_destroy(_alljoyn_observerlistener_handle* listener);

@DllImport("MSAJApi")
_alljoyn_observer_handle* alljoyn_observer_create(_alljoyn_busattachment_handle* bus, 
                                                  const(byte)** mandatoryInterfaces, size_t numMandatoryInterfaces);

@DllImport("MSAJApi")
void alljoyn_observer_destroy(_alljoyn_observer_handle* observer);

@DllImport("MSAJApi")
void alljoyn_observer_registerlistener(_alljoyn_observer_handle* observer, 
                                       _alljoyn_observerlistener_handle* listener, int triggerOnExisting);

@DllImport("MSAJApi")
void alljoyn_observer_unregisterlistener(_alljoyn_observer_handle* observer, 
                                         _alljoyn_observerlistener_handle* listener);

@DllImport("MSAJApi")
void alljoyn_observer_unregisteralllisteners(_alljoyn_observer_handle* observer);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_ref_handle* alljoyn_observer_get(_alljoyn_observer_handle* observer, 
                                                         const(byte)* uniqueBusName, const(byte)* objectPath);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_ref_handle* alljoyn_observer_getfirst(_alljoyn_observer_handle* observer);

@DllImport("MSAJApi")
_alljoyn_proxybusobject_ref_handle* alljoyn_observer_getnext(_alljoyn_observer_handle* observer, 
                                                             _alljoyn_proxybusobject_ref_handle* proxyref);

@DllImport("MSAJApi")
ushort alljoyn_securityapplicationproxy_getpermissionmanagementsessionport();

@DllImport("MSAJApi")
_alljoyn_securityapplicationproxy_handle* alljoyn_securityapplicationproxy_create(_alljoyn_busattachment_handle* bus, 
                                                                                  byte* appBusName, uint sessionId);

@DllImport("MSAJApi")
void alljoyn_securityapplicationproxy_destroy(_alljoyn_securityapplicationproxy_handle* proxy);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_claim(_alljoyn_securityapplicationproxy_handle* proxy, byte* caKey, 
                                               byte* identityCertificateChain, const(ubyte)* groupId, 
                                               size_t groupSize, byte* groupAuthority, byte** manifestsXmls, 
                                               size_t manifestsCount);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_getmanifesttemplate(_alljoyn_securityapplicationproxy_handle* proxy, 
                                                             byte** manifestTemplateXml);

@DllImport("MSAJApi")
void alljoyn_securityapplicationproxy_manifesttemplate_destroy(byte* manifestTemplateXml);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_getapplicationstate(_alljoyn_securityapplicationproxy_handle* proxy, 
                                                             alljoyn_applicationstate* applicationState);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_getclaimcapabilities(_alljoyn_securityapplicationproxy_handle* proxy, 
                                                              ushort* capabilities);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_getclaimcapabilitiesadditionalinfo(_alljoyn_securityapplicationproxy_handle* proxy, 
                                                                            ushort* additionalInfo);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_getpolicy(_alljoyn_securityapplicationproxy_handle* proxy, 
                                                   byte** policyXml);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_getdefaultpolicy(_alljoyn_securityapplicationproxy_handle* proxy, 
                                                          byte** policyXml);

@DllImport("MSAJApi")
void alljoyn_securityapplicationproxy_policy_destroy(byte* policyXml);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_updatepolicy(_alljoyn_securityapplicationproxy_handle* proxy, 
                                                      byte* policyXml);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_updateidentity(_alljoyn_securityapplicationproxy_handle* proxy, 
                                                        byte* identityCertificateChain, byte** manifestsXmls, 
                                                        size_t manifestsCount);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_installmembership(_alljoyn_securityapplicationproxy_handle* proxy, 
                                                           byte* membershipCertificateChain);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_reset(_alljoyn_securityapplicationproxy_handle* proxy);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_resetpolicy(_alljoyn_securityapplicationproxy_handle* proxy);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_startmanagement(_alljoyn_securityapplicationproxy_handle* proxy);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_endmanagement(_alljoyn_securityapplicationproxy_handle* proxy);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_geteccpublickey(_alljoyn_securityapplicationproxy_handle* proxy, 
                                                         byte** eccPublicKey);

@DllImport("MSAJApi")
void alljoyn_securityapplicationproxy_eccpublickey_destroy(byte* eccPublicKey);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_signmanifest(byte* unsignedManifestXml, byte* identityCertificatePem, 
                                                      byte* signingPrivateKeyPem, byte** signedManifestXml);

@DllImport("MSAJApi")
void alljoyn_securityapplicationproxy_manifest_destroy(byte* signedManifestXml);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_computemanifestdigest(byte* unsignedManifestXml, 
                                                               byte* identityCertificatePem, ubyte** digest, 
                                                               size_t* digestSize);

@DllImport("MSAJApi")
void alljoyn_securityapplicationproxy_digest_destroy(ubyte* digest);

@DllImport("MSAJApi")
QStatus alljoyn_securityapplicationproxy_setmanifestsignature(byte* unsignedManifestXml, 
                                                              byte* identityCertificatePem, const(ubyte)* signature, 
                                                              size_t signatureSize, byte** signedManifestXml);


