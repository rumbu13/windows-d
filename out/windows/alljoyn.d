module windows.alljoyn;

public import windows.systemservices;

extern(Windows):

enum alljoyn_about_announceflag
{
    UNANNOUNCED = 0,
    ANNOUNCED = 1,
}

enum QStatus
{
    ER_OK = 0,
    ER_FAIL = 1,
    ER_UTF_CONVERSION_FAILED = 2,
    ER_BUFFER_TOO_SMALL = 3,
    ER_OS_ERROR = 4,
    ER_OUT_OF_MEMORY = 5,
    ER_SOCKET_BIND_ERROR = 6,
    ER_INIT_FAILED = 7,
    ER_WOULDBLOCK = 8,
    ER_NOT_IMPLEMENTED = 9,
    ER_TIMEOUT = 10,
    ER_SOCK_OTHER_END_CLOSED = 11,
    ER_BAD_ARG_1 = 12,
    ER_BAD_ARG_2 = 13,
    ER_BAD_ARG_3 = 14,
    ER_BAD_ARG_4 = 15,
    ER_BAD_ARG_5 = 16,
    ER_BAD_ARG_6 = 17,
    ER_BAD_ARG_7 = 18,
    ER_BAD_ARG_8 = 19,
    ER_INVALID_ADDRESS = 20,
    ER_INVALID_DATA = 21,
    ER_READ_ERROR = 22,
    ER_WRITE_ERROR = 23,
    ER_OPEN_FAILED = 24,
    ER_PARSE_ERROR = 25,
    ER_END_OF_DATA = 26,
    ER_CONN_REFUSED = 27,
    ER_BAD_ARG_COUNT = 28,
    ER_WARNING = 29,
    ER_EOF = 30,
    ER_DEADLOCK = 31,
    ER_COMMON_ERRORS = 4096,
    ER_STOPPING_THREAD = 4097,
    ER_ALERTED_THREAD = 4098,
    ER_XML_MALFORMED = 4099,
    ER_AUTH_FAIL = 4100,
    ER_AUTH_USER_REJECT = 4101,
    ER_NO_SUCH_ALARM = 4102,
    ER_TIMER_FALLBEHIND = 4103,
    ER_SSL_ERRORS = 4104,
    ER_SSL_INIT = 4105,
    ER_SSL_CONNECT = 4106,
    ER_SSL_VERIFY = 4107,
    ER_EXTERNAL_THREAD = 4108,
    ER_CRYPTO_ERROR = 4109,
    ER_CRYPTO_TRUNCATED = 4110,
    ER_CRYPTO_KEY_UNAVAILABLE = 4111,
    ER_BAD_HOSTNAME = 4112,
    ER_CRYPTO_KEY_UNUSABLE = 4113,
    ER_EMPTY_KEY_BLOB = 4114,
    ER_CORRUPT_KEYBLOB = 4115,
    ER_INVALID_KEY_ENCODING = 4116,
    ER_DEAD_THREAD = 4117,
    ER_THREAD_RUNNING = 4118,
    ER_THREAD_STOPPING = 4119,
    ER_BAD_STRING_ENCODING = 4120,
    ER_CRYPTO_INSUFFICIENT_SECURITY = 4121,
    ER_CRYPTO_ILLEGAL_PARAMETERS = 4122,
    ER_CRYPTO_HASH_UNINITIALIZED = 4123,
    ER_THREAD_NO_WAIT = 4124,
    ER_TIMER_EXITING = 4125,
    ER_INVALID_GUID = 4126,
    ER_THREADPOOL_EXHAUSTED = 4127,
    ER_THREADPOOL_STOPPING = 4128,
    ER_INVALID_STREAM = 4129,
    ER_TIMER_FULL = 4130,
    ER_IODISPATCH_STOPPING = 4131,
    ER_SLAP_INVALID_PACKET_LEN = 4132,
    ER_SLAP_HDR_CHECKSUM_ERROR = 4133,
    ER_SLAP_INVALID_PACKET_TYPE = 4134,
    ER_SLAP_LEN_MISMATCH = 4135,
    ER_SLAP_PACKET_TYPE_MISMATCH = 4136,
    ER_SLAP_CRC_ERROR = 4137,
    ER_SLAP_ERROR = 4138,
    ER_SLAP_OTHER_END_CLOSED = 4139,
    ER_TIMER_NOT_ALLOWED = 4140,
    ER_NOT_CONN = 4141,
    ER_XML_CONVERTER_ERROR = 8192,
    ER_XML_INVALID_RULES_COUNT = 8193,
    ER_XML_INTERFACE_MEMBERS_MISSING = 8194,
    ER_XML_INVALID_MEMBER_TYPE = 8195,
    ER_XML_INVALID_MEMBER_ACTION = 8196,
    ER_XML_MEMBER_DENY_ACTION_WITH_OTHER = 8197,
    ER_XML_INVALID_ANNOTATIONS_COUNT = 8198,
    ER_XML_INVALID_ELEMENT_NAME = 8199,
    ER_XML_INVALID_ATTRIBUTE_VALUE = 8200,
    ER_XML_INVALID_SECURITY_LEVEL_ANNOTATION_VALUE = 8201,
    ER_XML_INVALID_ELEMENT_CHILDREN_COUNT = 8202,
    ER_XML_INVALID_POLICY_VERSION = 8203,
    ER_XML_INVALID_POLICY_SERIAL_NUMBER = 8204,
    ER_XML_INVALID_ACL_PEER_TYPE = 8205,
    ER_XML_INVALID_ACL_PEER_CHILDREN_COUNT = 8206,
    ER_XML_ACL_ALL_TYPE_PEER_WITH_OTHERS = 8207,
    ER_XML_INVALID_ACL_PEER_PUBLIC_KEY = 8208,
    ER_XML_ACL_PEER_NOT_UNIQUE = 8209,
    ER_XML_ACL_PEER_PUBLIC_KEY_SET = 8210,
    ER_XML_ACLS_MISSING = 8211,
    ER_XML_ACL_PEERS_MISSING = 8212,
    ER_XML_INVALID_OBJECT_PATH = 8213,
    ER_XML_INVALID_INTERFACE_NAME = 8214,
    ER_XML_INVALID_MEMBER_NAME = 8215,
    ER_XML_INVALID_MANIFEST_VERSION = 8216,
    ER_XML_INVALID_OID = 8217,
    ER_XML_INVALID_BASE64 = 8218,
    ER_XML_INTERFACE_NAME_NOT_UNIQUE = 8219,
    ER_XML_MEMBER_NAME_NOT_UNIQUE = 8220,
    ER_XML_OBJECT_PATH_NOT_UNIQUE = 8221,
    ER_XML_ANNOTATION_NOT_UNIQUE = 8222,
    ER_NONE = 65535,
    ER_BUS_ERRORS = 36864,
    ER_BUS_READ_ERROR = 36865,
    ER_BUS_WRITE_ERROR = 36866,
    ER_BUS_BAD_VALUE_TYPE = 36867,
    ER_BUS_BAD_HEADER_FIELD = 36868,
    ER_BUS_BAD_SIGNATURE = 36869,
    ER_BUS_BAD_OBJ_PATH = 36870,
    ER_BUS_BAD_MEMBER_NAME = 36871,
    ER_BUS_BAD_INTERFACE_NAME = 36872,
    ER_BUS_BAD_ERROR_NAME = 36873,
    ER_BUS_BAD_BUS_NAME = 36874,
    ER_BUS_NAME_TOO_LONG = 36875,
    ER_BUS_BAD_LENGTH = 36876,
    ER_BUS_BAD_VALUE = 36877,
    ER_BUS_BAD_HDR_FLAGS = 36878,
    ER_BUS_BAD_BODY_LEN = 36879,
    ER_BUS_BAD_HEADER_LEN = 36880,
    ER_BUS_UNKNOWN_SERIAL = 36881,
    ER_BUS_UNKNOWN_PATH = 36882,
    ER_BUS_UNKNOWN_INTERFACE = 36883,
    ER_BUS_ESTABLISH_FAILED = 36884,
    ER_BUS_UNEXPECTED_SIGNATURE = 36885,
    ER_BUS_INTERFACE_MISSING = 36886,
    ER_BUS_PATH_MISSING = 36887,
    ER_BUS_MEMBER_MISSING = 36888,
    ER_BUS_REPLY_SERIAL_MISSING = 36889,
    ER_BUS_ERROR_NAME_MISSING = 36890,
    ER_BUS_INTERFACE_NO_SUCH_MEMBER = 36891,
    ER_BUS_NO_SUCH_OBJECT = 36892,
    ER_BUS_OBJECT_NO_SUCH_MEMBER = 36893,
    ER_BUS_OBJECT_NO_SUCH_INTERFACE = 36894,
    ER_BUS_NO_SUCH_INTERFACE = 36895,
    ER_BUS_MEMBER_NO_SUCH_SIGNATURE = 36896,
    ER_BUS_NOT_NUL_TERMINATED = 36897,
    ER_BUS_NO_SUCH_PROPERTY = 36898,
    ER_BUS_SET_WRONG_SIGNATURE = 36899,
    ER_BUS_PROPERTY_VALUE_NOT_SET = 36900,
    ER_BUS_PROPERTY_ACCESS_DENIED = 36901,
    ER_BUS_NO_TRANSPORTS = 36902,
    ER_BUS_BAD_TRANSPORT_ARGS = 36903,
    ER_BUS_NO_ROUTE = 36904,
    ER_BUS_NO_ENDPOINT = 36905,
    ER_BUS_BAD_SEND_PARAMETER = 36906,
    ER_BUS_UNMATCHED_REPLY_SERIAL = 36907,
    ER_BUS_BAD_SENDER_ID = 36908,
    ER_BUS_TRANSPORT_NOT_STARTED = 36909,
    ER_BUS_EMPTY_MESSAGE = 36910,
    ER_BUS_NOT_OWNER = 36911,
    ER_BUS_SET_PROPERTY_REJECTED = 36912,
    ER_BUS_CONNECT_FAILED = 36913,
    ER_BUS_REPLY_IS_ERROR_MESSAGE = 36914,
    ER_BUS_NOT_AUTHENTICATING = 36915,
    ER_BUS_NO_LISTENER = 36916,
    ER_BUS_NOT_ALLOWED = 36918,
    ER_BUS_WRITE_QUEUE_FULL = 36919,
    ER_BUS_ENDPOINT_CLOSING = 36920,
    ER_BUS_INTERFACE_MISMATCH = 36921,
    ER_BUS_MEMBER_ALREADY_EXISTS = 36922,
    ER_BUS_PROPERTY_ALREADY_EXISTS = 36923,
    ER_BUS_IFACE_ALREADY_EXISTS = 36924,
    ER_BUS_ERROR_RESPONSE = 36925,
    ER_BUS_BAD_XML = 36926,
    ER_BUS_BAD_CHILD_PATH = 36927,
    ER_BUS_OBJ_ALREADY_EXISTS = 36928,
    ER_BUS_OBJ_NOT_FOUND = 36929,
    ER_BUS_CANNOT_EXPAND_MESSAGE = 36930,
    ER_BUS_NOT_COMPRESSED = 36931,
    ER_BUS_ALREADY_CONNECTED = 36932,
    ER_BUS_NOT_CONNECTED = 36933,
    ER_BUS_ALREADY_LISTENING = 36934,
    ER_BUS_KEY_UNAVAILABLE = 36935,
    ER_BUS_TRUNCATED = 36936,
    ER_BUS_KEY_STORE_NOT_LOADED = 36937,
    ER_BUS_NO_AUTHENTICATION_MECHANISM = 36938,
    ER_BUS_BUS_ALREADY_STARTED = 36939,
    ER_BUS_BUS_NOT_STARTED = 36940,
    ER_BUS_KEYBLOB_OP_INVALID = 36941,
    ER_BUS_INVALID_HEADER_CHECKSUM = 36942,
    ER_BUS_MESSAGE_NOT_ENCRYPTED = 36943,
    ER_BUS_INVALID_HEADER_SERIAL = 36944,
    ER_BUS_TIME_TO_LIVE_EXPIRED = 36945,
    ER_BUS_HDR_EXPANSION_INVALID = 36946,
    ER_BUS_MISSING_COMPRESSION_TOKEN = 36947,
    ER_BUS_NO_PEER_GUID = 36948,
    ER_BUS_MESSAGE_DECRYPTION_FAILED = 36949,
    ER_BUS_SECURITY_FATAL = 36950,
    ER_BUS_KEY_EXPIRED = 36951,
    ER_BUS_CORRUPT_KEYSTORE = 36952,
    ER_BUS_NO_CALL_FOR_REPLY = 36953,
    ER_BUS_NOT_A_COMPLETE_TYPE = 36954,
    ER_BUS_POLICY_VIOLATION = 36955,
    ER_BUS_NO_SUCH_SERVICE = 36956,
    ER_BUS_TRANSPORT_NOT_AVAILABLE = 36957,
    ER_BUS_INVALID_AUTH_MECHANISM = 36958,
    ER_BUS_KEYSTORE_VERSION_MISMATCH = 36959,
    ER_BUS_BLOCKING_CALL_NOT_ALLOWED = 36960,
    ER_BUS_SIGNATURE_MISMATCH = 36961,
    ER_BUS_STOPPING = 36962,
    ER_BUS_METHOD_CALL_ABORTED = 36963,
    ER_BUS_CANNOT_ADD_INTERFACE = 36964,
    ER_BUS_CANNOT_ADD_HANDLER = 36965,
    ER_BUS_KEYSTORE_NOT_LOADED = 36966,
    ER_BUS_NO_SUCH_HANDLE = 36971,
    ER_BUS_HANDLES_NOT_ENABLED = 36972,
    ER_BUS_HANDLES_MISMATCH = 36973,
    ER_BUS_NO_SESSION = 36975,
    ER_BUS_ELEMENT_NOT_FOUND = 36976,
    ER_BUS_NOT_A_DICTIONARY = 36977,
    ER_BUS_WAIT_FAILED = 36978,
    ER_BUS_BAD_SESSION_OPTS = 36980,
    ER_BUS_CONNECTION_REJECTED = 36981,
    ER_DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER = 36982,
    ER_DBUS_REQUEST_NAME_REPLY_IN_QUEUE = 36983,
    ER_DBUS_REQUEST_NAME_REPLY_EXISTS = 36984,
    ER_DBUS_REQUEST_NAME_REPLY_ALREADY_OWNER = 36985,
    ER_DBUS_RELEASE_NAME_REPLY_RELEASED = 36986,
    ER_DBUS_RELEASE_NAME_REPLY_NON_EXISTENT = 36987,
    ER_DBUS_RELEASE_NAME_REPLY_NOT_OWNER = 36988,
    ER_DBUS_START_REPLY_ALREADY_RUNNING = 36990,
    ER_ALLJOYN_BINDSESSIONPORT_REPLY_ALREADY_EXISTS = 36992,
    ER_ALLJOYN_BINDSESSIONPORT_REPLY_FAILED = 36993,
    ER_ALLJOYN_JOINSESSION_REPLY_NO_SESSION = 36995,
    ER_ALLJOYN_JOINSESSION_REPLY_UNREACHABLE = 36996,
    ER_ALLJOYN_JOINSESSION_REPLY_CONNECT_FAILED = 36997,
    ER_ALLJOYN_JOINSESSION_REPLY_REJECTED = 36998,
    ER_ALLJOYN_JOINSESSION_REPLY_BAD_SESSION_OPTS = 36999,
    ER_ALLJOYN_JOINSESSION_REPLY_FAILED = 37000,
    ER_ALLJOYN_LEAVESESSION_REPLY_NO_SESSION = 37002,
    ER_ALLJOYN_LEAVESESSION_REPLY_FAILED = 37003,
    ER_ALLJOYN_ADVERTISENAME_REPLY_TRANSPORT_NOT_AVAILABLE = 37004,
    ER_ALLJOYN_ADVERTISENAME_REPLY_ALREADY_ADVERTISING = 37005,
    ER_ALLJOYN_ADVERTISENAME_REPLY_FAILED = 37006,
    ER_ALLJOYN_CANCELADVERTISENAME_REPLY_FAILED = 37008,
    ER_ALLJOYN_FINDADVERTISEDNAME_REPLY_TRANSPORT_NOT_AVAILABLE = 37009,
    ER_ALLJOYN_FINDADVERTISEDNAME_REPLY_ALREADY_DISCOVERING = 37010,
    ER_ALLJOYN_FINDADVERTISEDNAME_REPLY_FAILED = 37011,
    ER_ALLJOYN_CANCELFINDADVERTISEDNAME_REPLY_FAILED = 37013,
    ER_BUS_UNEXPECTED_DISPOSITION = 37014,
    ER_BUS_INTERFACE_ACTIVATED = 37015,
    ER_ALLJOYN_UNBINDSESSIONPORT_REPLY_BAD_PORT = 37016,
    ER_ALLJOYN_UNBINDSESSIONPORT_REPLY_FAILED = 37017,
    ER_ALLJOYN_BINDSESSIONPORT_REPLY_INVALID_OPTS = 37018,
    ER_ALLJOYN_JOINSESSION_REPLY_ALREADY_JOINED = 37019,
    ER_BUS_SELF_CONNECT = 37020,
    ER_BUS_SECURITY_NOT_ENABLED = 37021,
    ER_BUS_LISTENER_ALREADY_SET = 37022,
    ER_BUS_PEER_AUTH_VERSION_MISMATCH = 37023,
    ER_ALLJOYN_SETLINKTIMEOUT_REPLY_NOT_SUPPORTED = 37024,
    ER_ALLJOYN_SETLINKTIMEOUT_REPLY_NO_DEST_SUPPORT = 37025,
    ER_ALLJOYN_SETLINKTIMEOUT_REPLY_FAILED = 37026,
    ER_ALLJOYN_ACCESS_PERMISSION_WARNING = 37027,
    ER_ALLJOYN_ACCESS_PERMISSION_ERROR = 37028,
    ER_BUS_DESTINATION_NOT_AUTHENTICATED = 37029,
    ER_BUS_ENDPOINT_REDIRECTED = 37030,
    ER_BUS_AUTHENTICATION_PENDING = 37031,
    ER_BUS_NOT_AUTHORIZED = 37032,
    ER_PACKET_BUS_NO_SUCH_CHANNEL = 37033,
    ER_PACKET_BAD_FORMAT = 37034,
    ER_PACKET_CONNECT_TIMEOUT = 37035,
    ER_PACKET_CHANNEL_FAIL = 37036,
    ER_PACKET_TOO_LARGE = 37037,
    ER_PACKET_BAD_PARAMETER = 37038,
    ER_PACKET_BAD_CRC = 37039,
    ER_RENDEZVOUS_SERVER_DEACTIVATED_USER = 37067,
    ER_RENDEZVOUS_SERVER_UNKNOWN_USER = 37068,
    ER_UNABLE_TO_CONNECT_TO_RENDEZVOUS_SERVER = 37069,
    ER_NOT_CONNECTED_TO_RENDEZVOUS_SERVER = 37070,
    ER_UNABLE_TO_SEND_MESSAGE_TO_RENDEZVOUS_SERVER = 37071,
    ER_INVALID_RENDEZVOUS_SERVER_INTERFACE_MESSAGE = 37072,
    ER_INVALID_PERSISTENT_CONNECTION_MESSAGE_RESPONSE = 37073,
    ER_INVALID_ON_DEMAND_CONNECTION_MESSAGE_RESPONSE = 37074,
    ER_INVALID_HTTP_METHOD_USED_FOR_RENDEZVOUS_SERVER_INTERFACE_MESSAGE = 37075,
    ER_RENDEZVOUS_SERVER_ERR500_INTERNAL_ERROR = 37076,
    ER_RENDEZVOUS_SERVER_ERR503_STATUS_UNAVAILABLE = 37077,
    ER_RENDEZVOUS_SERVER_ERR401_UNAUTHORIZED_REQUEST = 37078,
    ER_RENDEZVOUS_SERVER_UNRECOVERABLE_ERROR = 37079,
    ER_RENDEZVOUS_SERVER_ROOT_CERTIFICATE_UNINITIALIZED = 37080,
    ER_BUS_NO_SUCH_ANNOTATION = 37081,
    ER_BUS_ANNOTATION_ALREADY_EXISTS = 37082,
    ER_SOCK_CLOSING = 37083,
    ER_NO_SUCH_DEVICE = 37084,
    ER_P2P = 37085,
    ER_P2P_TIMEOUT = 37086,
    ER_P2P_NOT_CONNECTED = 37087,
    ER_BAD_TRANSPORT_MASK = 37088,
    ER_PROXIMITY_CONNECTION_ESTABLISH_FAIL = 37089,
    ER_PROXIMITY_NO_PEERS_FOUND = 37090,
    ER_BUS_OBJECT_NOT_REGISTERED = 37091,
    ER_P2P_DISABLED = 37092,
    ER_P2P_BUSY = 37093,
    ER_BUS_INCOMPATIBLE_DAEMON = 37094,
    ER_P2P_NO_GO = 37095,
    ER_P2P_NO_STA = 37096,
    ER_P2P_FORBIDDEN = 37097,
    ER_ALLJOYN_ONAPPSUSPEND_REPLY_FAILED = 37098,
    ER_ALLJOYN_ONAPPSUSPEND_REPLY_UNSUPPORTED = 37099,
    ER_ALLJOYN_ONAPPRESUME_REPLY_FAILED = 37100,
    ER_ALLJOYN_ONAPPRESUME_REPLY_UNSUPPORTED = 37101,
    ER_BUS_NO_SUCH_MESSAGE = 37102,
    ER_ALLJOYN_REMOVESESSIONMEMBER_REPLY_NO_SESSION = 37103,
    ER_ALLJOYN_REMOVESESSIONMEMBER_NOT_BINDER = 37104,
    ER_ALLJOYN_REMOVESESSIONMEMBER_NOT_MULTIPOINT = 37105,
    ER_ALLJOYN_REMOVESESSIONMEMBER_NOT_FOUND = 37106,
    ER_ALLJOYN_REMOVESESSIONMEMBER_INCOMPATIBLE_REMOTE_DAEMON = 37107,
    ER_ALLJOYN_REMOVESESSIONMEMBER_REPLY_FAILED = 37108,
    ER_BUS_REMOVED_BY_BINDER = 37109,
    ER_BUS_MATCH_RULE_NOT_FOUND = 37110,
    ER_ALLJOYN_PING_FAILED = 37111,
    ER_ALLJOYN_PING_REPLY_UNREACHABLE = 37112,
    ER_UDP_MSG_TOO_LONG = 37113,
    ER_UDP_DEMUX_NO_ENDPOINT = 37114,
    ER_UDP_NO_NETWORK = 37115,
    ER_UDP_UNEXPECTED_LENGTH = 37116,
    ER_UDP_UNEXPECTED_FLOW = 37117,
    ER_UDP_DISCONNECT = 37118,
    ER_UDP_NOT_IMPLEMENTED = 37119,
    ER_UDP_NO_LISTENER = 37120,
    ER_UDP_STOPPING = 37121,
    ER_ARDP_BACKPRESSURE = 37122,
    ER_UDP_BACKPRESSURE = 37123,
    ER_ARDP_INVALID_STATE = 37124,
    ER_ARDP_TTL_EXPIRED = 37125,
    ER_ARDP_PERSIST_TIMEOUT = 37126,
    ER_ARDP_PROBE_TIMEOUT = 37127,
    ER_ARDP_REMOTE_CONNECTION_RESET = 37128,
    ER_UDP_BUSHELLO = 37129,
    ER_UDP_MESSAGE = 37130,
    ER_UDP_INVALID = 37131,
    ER_UDP_UNSUPPORTED = 37132,
    ER_UDP_ENDPOINT_STALLED = 37133,
    ER_ARDP_INVALID_RESPONSE = 37134,
    ER_ARDP_INVALID_CONNECTION = 37135,
    ER_UDP_LOCAL_DISCONNECT = 37136,
    ER_UDP_EARLY_EXIT = 37137,
    ER_UDP_LOCAL_DISCONNECT_FAIL = 37138,
    ER_ARDP_DISCONNECTING = 37139,
    ER_ALLJOYN_PING_REPLY_INCOMPATIBLE_REMOTE_ROUTING_NODE = 37140,
    ER_ALLJOYN_PING_REPLY_TIMEOUT = 37141,
    ER_ALLJOYN_PING_REPLY_UNKNOWN_NAME = 37142,
    ER_ALLJOYN_PING_REPLY_FAILED = 37143,
    ER_TCP_MAX_UNTRUSTED = 37144,
    ER_ALLJOYN_PING_REPLY_IN_PROGRESS = 37145,
    ER_LANGUAGE_NOT_SUPPORTED = 37146,
    ER_ABOUT_FIELD_ALREADY_SPECIFIED = 37147,
    ER_UDP_NOT_DISCONNECTED = 37148,
    ER_UDP_ENDPOINT_NOT_STARTED = 37149,
    ER_UDP_ENDPOINT_REMOVED = 37150,
    ER_ARDP_VERSION_NOT_SUPPORTED = 37151,
    ER_CONNECTION_LIMIT_EXCEEDED = 37152,
    ER_ARDP_WRITE_BLOCKED = 37153,
    ER_PERMISSION_DENIED = 37154,
    ER_ABOUT_DEFAULT_LANGUAGE_NOT_SPECIFIED = 37155,
    ER_ABOUT_SESSIONPORT_NOT_BOUND = 37156,
    ER_ABOUT_ABOUTDATA_MISSING_REQUIRED_FIELD = 37157,
    ER_ABOUT_INVALID_ABOUTDATA_LISTENER = 37158,
    ER_BUS_PING_GROUP_NOT_FOUND = 37159,
    ER_BUS_REMOVED_BY_BINDER_SELF = 37160,
    ER_INVALID_CONFIG = 37161,
    ER_ABOUT_INVALID_ABOUTDATA_FIELD_VALUE = 37162,
    ER_ABOUT_INVALID_ABOUTDATA_FIELD_APPID_SIZE = 37163,
    ER_BUS_TRANSPORT_ACCESS_DENIED = 37164,
    ER_INVALID_CERTIFICATE = 37165,
    ER_CERTIFICATE_NOT_FOUND = 37166,
    ER_DUPLICATE_CERTIFICATE = 37167,
    ER_UNKNOWN_CERTIFICATE = 37168,
    ER_MISSING_DIGEST_IN_CERTIFICATE = 37169,
    ER_DIGEST_MISMATCH = 37170,
    ER_DUPLICATE_KEY = 37171,
    ER_NO_COMMON_TRUST = 37172,
    ER_MANIFEST_NOT_FOUND = 37173,
    ER_INVALID_CERT_CHAIN = 37174,
    ER_NO_TRUST_ANCHOR = 37175,
    ER_INVALID_APPLICATION_STATE = 37176,
    ER_FEATURE_NOT_AVAILABLE = 37177,
    ER_KEY_STORE_ALREADY_INITIALIZED = 37178,
    ER_KEY_STORE_ID_NOT_YET_SET = 37179,
    ER_POLICY_NOT_NEWER = 37180,
    ER_MANIFEST_REJECTED = 37181,
    ER_INVALID_CERTIFICATE_USAGE = 37182,
    ER_INVALID_SIGNAL_EMISSION_TYPE = 37183,
    ER_APPLICATION_STATE_LISTENER_ALREADY_EXISTS = 37184,
    ER_APPLICATION_STATE_LISTENER_NO_SUCH_LISTENER = 37185,
    ER_MANAGEMENT_ALREADY_STARTED = 37186,
    ER_MANAGEMENT_NOT_STARTED = 37187,
    ER_BUS_DESCRIPTION_ALREADY_EXISTS = 37188,
}

struct _alljoyn_msgarg_handle
{
}

enum alljoyn_typeid
{
    ALLJOYN_INVALID = 0,
    ALLJOYN_ARRAY = 97,
    ALLJOYN_BOOLEAN = 98,
    ALLJOYN_DOUBLE = 100,
    ALLJOYN_DICT_ENTRY = 101,
    ALLJOYN_SIGNATURE = 103,
    ALLJOYN_HANDLE = 104,
    ALLJOYN_INT32 = 105,
    ALLJOYN_INT16 = 110,
    ALLJOYN_OBJECT_PATH = 111,
    ALLJOYN_UINT16 = 113,
    ALLJOYN_STRUCT = 114,
    ALLJOYN_STRING = 115,
    ALLJOYN_UINT64 = 116,
    ALLJOYN_UINT32 = 117,
    ALLJOYN_VARIANT = 118,
    ALLJOYN_INT64 = 120,
    ALLJOYN_BYTE = 121,
    ALLJOYN_STRUCT_OPEN = 40,
    ALLJOYN_STRUCT_CLOSE = 41,
    ALLJOYN_DICT_ENTRY_OPEN = 123,
    ALLJOYN_DICT_ENTRY_CLOSE = 125,
    ALLJOYN_BOOLEAN_ARRAY = 25185,
    ALLJOYN_DOUBLE_ARRAY = 25697,
    ALLJOYN_INT32_ARRAY = 26977,
    ALLJOYN_INT16_ARRAY = 28257,
    ALLJOYN_UINT16_ARRAY = 29025,
    ALLJOYN_UINT64_ARRAY = 29793,
    ALLJOYN_UINT32_ARRAY = 30049,
    ALLJOYN_INT64_ARRAY = 30817,
    ALLJOYN_BYTE_ARRAY = 31073,
    ALLJOYN_WILDCARD = 42,
}

struct _alljoyn_aboutdata_handle
{
}

struct _alljoyn_aboutdatalistener_handle
{
}

alias alljoyn_aboutdatalistener_getaboutdata_ptr = extern(Windows) QStatus function(const(void)* context, _alljoyn_msgarg_handle* msgArg, const(byte)* language);
alias alljoyn_aboutdatalistener_getannouncedaboutdata_ptr = extern(Windows) QStatus function(const(void)* context, _alljoyn_msgarg_handle* msgArg);
struct alljoyn_aboutdatalistener_callbacks
{
    alljoyn_aboutdatalistener_getaboutdata_ptr about_datalistener_getaboutdata;
    alljoyn_aboutdatalistener_getannouncedaboutdata_ptr about_datalistener_getannouncedaboutdata;
}

struct _alljoyn_permissionconfigurator_handle
{
}

enum alljoyn_applicationstate
{
    NOT_CLAIMABLE = 0,
    CLAIMABLE = 1,
    CLAIMED = 2,
    NEED_UPDATE = 3,
}

enum alljoyn_claimcapability_masks
{
    CAPABLE_ECDHE_NULL = 1,
    CAPABLE_ECDHE_ECDSA = 4,
    CAPABLE_ECDHE_SPEKE = 8,
}

enum alljoyn_claimcapabilityadditionalinfo_masks
{
    PASSWORD_GENERATED_BY_SECURITY_MANAGER = 1,
    PASSWORD_GENERATED_BY_APPLICATION = 2,
}

struct alljoyn_certificateid
{
    ubyte* serial;
    uint serialLen;
    byte* issuerPublicKey;
    ubyte* issuerAki;
    uint issuerAkiLen;
}

struct alljoyn_certificateidarray
{
    uint count;
    alljoyn_certificateid* ids;
}

struct alljoyn_manifestarray
{
    uint count;
    byte** xmls;
}

struct _alljoyn_applicationstatelistener_handle
{
}

alias alljoyn_applicationstatelistener_state_ptr = extern(Windows) void function(byte* busName, byte* publicKey, alljoyn_applicationstate applicationState, void* context);
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

alias alljoyn_keystorelistener_loadrequest_ptr = extern(Windows) QStatus function(const(void)* context, _alljoyn_keystorelistener_handle* listener, _alljoyn_keystore_handle* keyStore);
alias alljoyn_keystorelistener_storerequest_ptr = extern(Windows) QStatus function(const(void)* context, _alljoyn_keystorelistener_handle* listener, _alljoyn_keystore_handle* keyStore);
alias alljoyn_keystorelistener_acquireexclusivelock_ptr = extern(Windows) QStatus function(const(void)* context, _alljoyn_keystorelistener_handle* listener);
alias alljoyn_keystorelistener_releaseexclusivelock_ptr = extern(Windows) void function(const(void)* context, _alljoyn_keystorelistener_handle* listener);
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

enum alljoyn_messagetype
{
    ALLJOYN_MESSAGE_INVALID = 0,
    ALLJOYN_MESSAGE_METHOD_CALL = 1,
    ALLJOYN_MESSAGE_METHOD_RET = 2,
    ALLJOYN_MESSAGE_ERROR = 3,
    ALLJOYN_MESSAGE_SIGNAL = 4,
}

struct _alljoyn_authlistener_handle
{
}

struct _alljoyn_credentials_handle
{
}

alias alljoyn_authlistener_requestcredentials_ptr = extern(Windows) int function(const(void)* context, const(byte)* authMechanism, const(byte)* peerName, ushort authCount, const(byte)* userName, ushort credMask, _alljoyn_credentials_handle* credentials);
alias alljoyn_authlistener_requestcredentialsasync_ptr = extern(Windows) QStatus function(const(void)* context, _alljoyn_authlistener_handle* listener, const(byte)* authMechanism, const(byte)* peerName, ushort authCount, const(byte)* userName, ushort credMask, void* authContext);
alias alljoyn_authlistener_verifycredentials_ptr = extern(Windows) int function(const(void)* context, const(byte)* authMechanism, const(byte)* peerName, const(_alljoyn_credentials_handle)* credentials);
alias alljoyn_authlistener_verifycredentialsasync_ptr = extern(Windows) QStatus function(const(void)* context, _alljoyn_authlistener_handle* listener, const(byte)* authMechanism, const(byte)* peerName, const(_alljoyn_credentials_handle)* credentials, void* authContext);
alias alljoyn_authlistener_securityviolation_ptr = extern(Windows) void function(const(void)* context, QStatus status, const(_alljoyn_message_handle)* msg);
alias alljoyn_authlistener_authenticationcomplete_ptr = extern(Windows) void function(const(void)* context, const(byte)* authMechanism, const(byte)* peerName, int success);
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

alias alljoyn_buslistener_listener_registered_ptr = extern(Windows) void function(const(void)* context, _alljoyn_busattachment_handle* bus);
alias alljoyn_buslistener_listener_unregistered_ptr = extern(Windows) void function(const(void)* context);
alias alljoyn_buslistener_found_advertised_name_ptr = extern(Windows) void function(const(void)* context, const(byte)* name, ushort transport, const(byte)* namePrefix);
alias alljoyn_buslistener_lost_advertised_name_ptr = extern(Windows) void function(const(void)* context, const(byte)* name, ushort transport, const(byte)* namePrefix);
alias alljoyn_buslistener_name_owner_changed_ptr = extern(Windows) void function(const(void)* context, const(byte)* busName, const(byte)* previousOwner, const(byte)* newOwner);
alias alljoyn_buslistener_bus_stopping_ptr = extern(Windows) void function(const(void)* context);
alias alljoyn_buslistener_bus_disconnected_ptr = extern(Windows) void function(const(void)* context);
alias alljoyn_buslistener_bus_prop_changed_ptr = extern(Windows) void function(const(void)* context, const(byte)* prop_name, _alljoyn_msgarg_handle* prop_value);
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

enum alljoyn_interfacedescription_securitypolicy
{
    AJ_IFC_SECURITY_INHERIT = 0,
    AJ_IFC_SECURITY_REQUIRED = 1,
    AJ_IFC_SECURITY_OFF = 2,
}

struct alljoyn_interfacedescription_member
{
    _alljoyn_interfacedescription_handle* iface;
    alljoyn_messagetype memberType;
    const(byte)* name;
    const(byte)* signature;
    const(byte)* returnSignature;
    const(byte)* argNames;
    const(void)* internal_member;
}

alias alljoyn_interfacedescription_translation_callback_ptr = extern(Windows) byte* function(const(byte)* sourceLanguage, const(byte)* targetLanguage, const(byte)* sourceText);
struct alljoyn_interfacedescription_property
{
    const(byte)* name;
    const(byte)* signature;
    ubyte access;
    const(void)* internal_property;
}

struct _alljoyn_busobject_handle
{
}

alias alljoyn_messagereceiver_methodhandler_ptr = extern(Windows) void function(_alljoyn_busobject_handle* bus, const(alljoyn_interfacedescription_member)* member, _alljoyn_message_handle* message);
alias alljoyn_messagereceiver_replyhandler_ptr = extern(Windows) void function(_alljoyn_message_handle* message, void* context);
alias alljoyn_messagereceiver_signalhandler_ptr = extern(Windows) void function(const(alljoyn_interfacedescription_member)* member, const(byte)* srcPath, _alljoyn_message_handle* message);
alias alljoyn_busobject_prop_get_ptr = extern(Windows) QStatus function(const(void)* context, const(byte)* ifcName, const(byte)* propName, _alljoyn_msgarg_handle* val);
alias alljoyn_busobject_prop_set_ptr = extern(Windows) QStatus function(const(void)* context, const(byte)* ifcName, const(byte)* propName, _alljoyn_msgarg_handle* val);
alias alljoyn_busobject_object_registration_ptr = extern(Windows) void function(const(void)* context);
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

alias alljoyn_proxybusobject_listener_introspectcb_ptr = extern(Windows) void function(QStatus status, _alljoyn_proxybusobject_handle* obj, void* context);
alias alljoyn_proxybusobject_listener_getpropertycb_ptr = extern(Windows) void function(QStatus status, _alljoyn_proxybusobject_handle* obj, const(_alljoyn_msgarg_handle)* value, void* context);
alias alljoyn_proxybusobject_listener_getallpropertiescb_ptr = extern(Windows) void function(QStatus status, _alljoyn_proxybusobject_handle* obj, const(_alljoyn_msgarg_handle)* values, void* context);
alias alljoyn_proxybusobject_listener_setpropertycb_ptr = extern(Windows) void function(QStatus status, _alljoyn_proxybusobject_handle* obj, void* context);
alias alljoyn_proxybusobject_listener_propertieschanged_ptr = extern(Windows) void function(_alljoyn_proxybusobject_handle* obj, const(byte)* ifaceName, const(_alljoyn_msgarg_handle)* changed, const(_alljoyn_msgarg_handle)* invalidated, void* context);
struct _alljoyn_permissionconfigurationlistener_handle
{
}

alias alljoyn_permissionconfigurationlistener_factoryreset_ptr = extern(Windows) QStatus function(const(void)* context);
alias alljoyn_permissionconfigurationlistener_policychanged_ptr = extern(Windows) void function(const(void)* context);
alias alljoyn_permissionconfigurationlistener_startmanagement_ptr = extern(Windows) void function(const(void)* context);
alias alljoyn_permissionconfigurationlistener_endmanagement_ptr = extern(Windows) void function(const(void)* context);
struct alljoyn_permissionconfigurationlistener_callbacks
{
    alljoyn_permissionconfigurationlistener_factoryreset_ptr factory_reset;
    alljoyn_permissionconfigurationlistener_policychanged_ptr policy_changed;
    alljoyn_permissionconfigurationlistener_startmanagement_ptr start_management;
    alljoyn_permissionconfigurationlistener_endmanagement_ptr end_management;
}

enum alljoyn_sessionlostreason
{
    ALLJOYN_SESSIONLOST_INVALID = 0,
    ALLJOYN_SESSIONLOST_REMOTE_END_LEFT_SESSION = 1,
    ALLJOYN_SESSIONLOST_REMOTE_END_CLOSED_ABRUPTLY = 2,
    ALLJOYN_SESSIONLOST_REMOVED_BY_BINDER = 3,
    ALLJOYN_SESSIONLOST_LINK_TIMEOUT = 4,
    ALLJOYN_SESSIONLOST_REASON_OTHER = 5,
}

struct _alljoyn_sessionlistener_handle
{
}

alias alljoyn_sessionlistener_sessionlost_ptr = extern(Windows) void function(const(void)* context, uint sessionId, alljoyn_sessionlostreason reason);
alias alljoyn_sessionlistener_sessionmemberadded_ptr = extern(Windows) void function(const(void)* context, uint sessionId, const(byte)* uniqueName);
alias alljoyn_sessionlistener_sessionmemberremoved_ptr = extern(Windows) void function(const(void)* context, uint sessionId, const(byte)* uniqueName);
struct alljoyn_sessionlistener_callbacks
{
    alljoyn_sessionlistener_sessionlost_ptr session_lost;
    alljoyn_sessionlistener_sessionmemberadded_ptr session_member_added;
    alljoyn_sessionlistener_sessionmemberremoved_ptr session_member_removed;
}

struct _alljoyn_sessionportlistener_handle
{
}

alias alljoyn_sessionportlistener_acceptsessionjoiner_ptr = extern(Windows) int function(const(void)* context, ushort sessionPort, const(byte)* joiner, const(_alljoyn_sessionopts_handle)* opts);
alias alljoyn_sessionportlistener_sessionjoined_ptr = extern(Windows) void function(const(void)* context, ushort sessionPort, uint id, const(byte)* joiner);
struct alljoyn_sessionportlistener_callbacks
{
    alljoyn_sessionportlistener_acceptsessionjoiner_ptr accept_session_joiner;
    alljoyn_sessionportlistener_sessionjoined_ptr session_joined;
}

struct _alljoyn_aboutlistener_handle
{
}

alias alljoyn_about_announced_ptr = extern(Windows) void function(const(void)* context, const(byte)* busName, ushort version, ushort port, const(_alljoyn_msgarg_handle)* objectDescriptionArg, const(_alljoyn_msgarg_handle)* aboutDataArg);
struct alljoyn_aboutlistener_callback
{
    alljoyn_about_announced_ptr about_listener_announced;
}

alias alljoyn_busattachment_joinsessioncb_ptr = extern(Windows) void function(QStatus status, uint sessionId, const(_alljoyn_sessionopts_handle)* opts, void* context);
alias alljoyn_busattachment_setlinktimeoutcb_ptr = extern(Windows) void function(QStatus status, uint timeout, void* context);
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

alias alljoyn_autopinger_destination_lost_ptr = extern(Windows) void function(const(void)* context, const(byte)* group, const(byte)* destination);
alias alljoyn_autopinger_destination_found_ptr = extern(Windows) void function(const(void)* context, const(byte)* group, const(byte)* destination);
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

alias alljoyn_observer_object_discovered_ptr = extern(Windows) void function(const(void)* context, _alljoyn_proxybusobject_ref_handle* proxyref);
alias alljoyn_observer_object_lost_ptr = extern(Windows) void function(const(void)* context, _alljoyn_proxybusobject_ref_handle* proxyref);
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

@DllImport("MSAJApi.dll")
HANDLE AllJoynConnectToBus(const(wchar)* connectionSpec);

@DllImport("MSAJApi.dll")
BOOL AllJoynCloseBusHandle(HANDLE busHandle);

@DllImport("MSAJApi.dll")
BOOL AllJoynSendToBus(HANDLE connectedBusHandle, char* buffer, uint bytesToWrite, uint* bytesTransferred, void* reserved);

@DllImport("MSAJApi.dll")
BOOL AllJoynReceiveFromBus(HANDLE connectedBusHandle, char* buffer, uint bytesToRead, uint* bytesTransferred, void* reserved);

@DllImport("MSAJApi.dll")
BOOL AllJoynEventSelect(HANDLE connectedBusHandle, HANDLE eventHandle, uint eventTypes);

@DllImport("MSAJApi.dll")
BOOL AllJoynEnumEvents(HANDLE connectedBusHandle, HANDLE eventToReset, uint* eventTypes);

@DllImport("MSAJApi.dll")
HANDLE AllJoynCreateBus(uint outBufferSize, uint inBufferSize, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("MSAJApi.dll")
uint AllJoynAcceptBusConnection(HANDLE serverBusHandle, HANDLE abortEvent);

@DllImport("MSAJApi.dll")
int alljoyn_unity_deferred_callbacks_process();

@DllImport("MSAJApi.dll")
void alljoyn_unity_set_deferred_callback_mainthread_only(int mainthread_only);

@DllImport("MSAJApi.dll")
byte* QCC_StatusText(QStatus status);

@DllImport("MSAJApi.dll")
_alljoyn_msgarg_handle* alljoyn_msgarg_create();

@DllImport("MSAJApi.dll")
_alljoyn_msgarg_handle* alljoyn_msgarg_create_and_set(const(byte)* signature);

@DllImport("MSAJApi.dll")
void alljoyn_msgarg_destroy(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi.dll")
_alljoyn_msgarg_handle* alljoyn_msgarg_array_create(uint size);

@DllImport("MSAJApi.dll")
_alljoyn_msgarg_handle* alljoyn_msgarg_array_element(_alljoyn_msgarg_handle* arg, uint index);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set(_alljoyn_msgarg_handle* arg, const(byte)* signature);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get(_alljoyn_msgarg_handle* arg, const(byte)* signature);

@DllImport("MSAJApi.dll")
_alljoyn_msgarg_handle* alljoyn_msgarg_copy(const(_alljoyn_msgarg_handle)* source);

@DllImport("MSAJApi.dll")
void alljoyn_msgarg_clone(_alljoyn_msgarg_handle* destination, const(_alljoyn_msgarg_handle)* source);

@DllImport("MSAJApi.dll")
int alljoyn_msgarg_equal(_alljoyn_msgarg_handle* lhv, _alljoyn_msgarg_handle* rhv);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_array_set(_alljoyn_msgarg_handle* args, uint* numArgs, const(byte)* signature);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_array_get(const(_alljoyn_msgarg_handle)* args, uint numArgs, const(byte)* signature);

@DllImport("MSAJApi.dll")
uint alljoyn_msgarg_tostring(_alljoyn_msgarg_handle* arg, byte* str, uint buf, uint indent);

@DllImport("MSAJApi.dll")
uint alljoyn_msgarg_array_tostring(const(_alljoyn_msgarg_handle)* args, uint numArgs, byte* str, uint buf, uint indent);

@DllImport("MSAJApi.dll")
uint alljoyn_msgarg_signature(_alljoyn_msgarg_handle* arg, byte* str, uint buf);

@DllImport("MSAJApi.dll")
uint alljoyn_msgarg_array_signature(_alljoyn_msgarg_handle* values, uint numValues, byte* str, uint buf);

@DllImport("MSAJApi.dll")
int alljoyn_msgarg_hassignature(_alljoyn_msgarg_handle* arg, const(byte)* signature);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_getdictelement(_alljoyn_msgarg_handle* arg, const(byte)* elemSig);

@DllImport("MSAJApi.dll")
alljoyn_typeid alljoyn_msgarg_gettype(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi.dll")
void alljoyn_msgarg_clear(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi.dll")
void alljoyn_msgarg_stabilize(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_array_set_offset(_alljoyn_msgarg_handle* args, uint argOffset, uint* numArgs, const(byte)* signature);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_and_stabilize(_alljoyn_msgarg_handle* arg, const(byte)* signature);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_uint8(_alljoyn_msgarg_handle* arg, ubyte y);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_bool(_alljoyn_msgarg_handle* arg, int b);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_int16(_alljoyn_msgarg_handle* arg, short n);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_uint16(_alljoyn_msgarg_handle* arg, ushort q);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_int32(_alljoyn_msgarg_handle* arg, int i);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_uint32(_alljoyn_msgarg_handle* arg, uint u);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_int64(_alljoyn_msgarg_handle* arg, long x);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_uint64(_alljoyn_msgarg_handle* arg, ulong t);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_double(_alljoyn_msgarg_handle* arg, double d);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_string(_alljoyn_msgarg_handle* arg, const(byte)* s);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_objectpath(_alljoyn_msgarg_handle* arg, const(byte)* o);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_signature(_alljoyn_msgarg_handle* arg, const(byte)* g);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_uint8(const(_alljoyn_msgarg_handle)* arg, ubyte* y);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_bool(const(_alljoyn_msgarg_handle)* arg, int* b);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_int16(const(_alljoyn_msgarg_handle)* arg, short* n);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_uint16(const(_alljoyn_msgarg_handle)* arg, ushort* q);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_int32(const(_alljoyn_msgarg_handle)* arg, int* i);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_uint32(const(_alljoyn_msgarg_handle)* arg, uint* u);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_int64(const(_alljoyn_msgarg_handle)* arg, long* x);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_uint64(const(_alljoyn_msgarg_handle)* arg, ulong* t);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_double(const(_alljoyn_msgarg_handle)* arg, double* d);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_string(const(_alljoyn_msgarg_handle)* arg, byte** s);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_objectpath(const(_alljoyn_msgarg_handle)* arg, byte** o);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_signature(const(_alljoyn_msgarg_handle)* arg, byte** g);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_variant(const(_alljoyn_msgarg_handle)* arg, _alljoyn_msgarg_handle* v);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_uint8_array(_alljoyn_msgarg_handle* arg, uint length, ubyte* ay);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_bool_array(_alljoyn_msgarg_handle* arg, uint length, int* ab);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_int16_array(_alljoyn_msgarg_handle* arg, uint length, short* an);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_uint16_array(_alljoyn_msgarg_handle* arg, uint length, ushort* aq);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_int32_array(_alljoyn_msgarg_handle* arg, uint length, int* ai);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_uint32_array(_alljoyn_msgarg_handle* arg, uint length, uint* au);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_int64_array(_alljoyn_msgarg_handle* arg, uint length, long* ax);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_uint64_array(_alljoyn_msgarg_handle* arg, uint length, ulong* at);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_double_array(_alljoyn_msgarg_handle* arg, uint length, double* ad);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_string_array(_alljoyn_msgarg_handle* arg, uint length, const(byte)** as);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_objectpath_array(_alljoyn_msgarg_handle* arg, uint length, const(byte)** ao);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_set_signature_array(_alljoyn_msgarg_handle* arg, uint length, const(byte)** ag);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_uint8_array(const(_alljoyn_msgarg_handle)* arg, uint* length, ubyte* ay);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_bool_array(const(_alljoyn_msgarg_handle)* arg, uint* length, int* ab);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_int16_array(const(_alljoyn_msgarg_handle)* arg, uint* length, short* an);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_uint16_array(const(_alljoyn_msgarg_handle)* arg, uint* length, ushort* aq);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_int32_array(const(_alljoyn_msgarg_handle)* arg, uint* length, int* ai);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_uint32_array(const(_alljoyn_msgarg_handle)* arg, uint* length, uint* au);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_int64_array(const(_alljoyn_msgarg_handle)* arg, uint* length, long* ax);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_uint64_array(const(_alljoyn_msgarg_handle)* arg, uint* length, ulong* at);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_double_array(const(_alljoyn_msgarg_handle)* arg, uint* length, double* ad);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_get_variant_array(const(_alljoyn_msgarg_handle)* arg, const(byte)* signature, uint* length, _alljoyn_msgarg_handle** av);

@DllImport("MSAJApi.dll")
uint alljoyn_msgarg_get_array_numberofelements(const(_alljoyn_msgarg_handle)* arg);

@DllImport("MSAJApi.dll")
void alljoyn_msgarg_get_array_element(const(_alljoyn_msgarg_handle)* arg, uint index, _alljoyn_msgarg_handle** element);

@DllImport("MSAJApi.dll")
byte* alljoyn_msgarg_get_array_elementsignature(const(_alljoyn_msgarg_handle)* arg, uint index);

@DllImport("MSAJApi.dll")
_alljoyn_msgarg_handle* alljoyn_msgarg_getkey(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi.dll")
_alljoyn_msgarg_handle* alljoyn_msgarg_getvalue(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_setdictentry(_alljoyn_msgarg_handle* arg, _alljoyn_msgarg_handle* key, _alljoyn_msgarg_handle* value);

@DllImport("MSAJApi.dll")
QStatus alljoyn_msgarg_setstruct(_alljoyn_msgarg_handle* arg, _alljoyn_msgarg_handle* struct_members, uint num_members);

@DllImport("MSAJApi.dll")
uint alljoyn_msgarg_getnummembers(_alljoyn_msgarg_handle* arg);

@DllImport("MSAJApi.dll")
_alljoyn_msgarg_handle* alljoyn_msgarg_getmember(_alljoyn_msgarg_handle* arg, uint index);

@DllImport("MSAJApi.dll")
_alljoyn_aboutdata_handle* alljoyn_aboutdata_create_empty();

@DllImport("MSAJApi.dll")
_alljoyn_aboutdata_handle* alljoyn_aboutdata_create(const(byte)* defaultLanguage);

@DllImport("MSAJApi.dll")
_alljoyn_aboutdata_handle* alljoyn_aboutdata_create_full(const(_alljoyn_msgarg_handle)* arg, const(byte)* language);

@DllImport("MSAJApi.dll")
void alljoyn_aboutdata_destroy(_alljoyn_aboutdata_handle* data);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_createfromxml(_alljoyn_aboutdata_handle* data, const(byte)* aboutDataXml);

@DllImport("MSAJApi.dll")
ubyte alljoyn_aboutdata_isvalid(_alljoyn_aboutdata_handle* data, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_createfrommsgarg(_alljoyn_aboutdata_handle* data, const(_alljoyn_msgarg_handle)* arg, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setappid(_alljoyn_aboutdata_handle* data, const(ubyte)* appId, const(uint) num);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setappid_fromstring(_alljoyn_aboutdata_handle* data, const(byte)* appId);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getappid(_alljoyn_aboutdata_handle* data, ubyte** appId, uint* num);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setdefaultlanguage(_alljoyn_aboutdata_handle* data, const(byte)* defaultLanguage);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getdefaultlanguage(_alljoyn_aboutdata_handle* data, byte** defaultLanguage);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setdevicename(_alljoyn_aboutdata_handle* data, const(byte)* deviceName, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getdevicename(_alljoyn_aboutdata_handle* data, byte** deviceName, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setdeviceid(_alljoyn_aboutdata_handle* data, const(byte)* deviceId);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getdeviceid(_alljoyn_aboutdata_handle* data, byte** deviceId);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setappname(_alljoyn_aboutdata_handle* data, const(byte)* appName, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getappname(_alljoyn_aboutdata_handle* data, byte** appName, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setmanufacturer(_alljoyn_aboutdata_handle* data, const(byte)* manufacturer, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getmanufacturer(_alljoyn_aboutdata_handle* data, byte** manufacturer, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setmodelnumber(_alljoyn_aboutdata_handle* data, const(byte)* modelNumber);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getmodelnumber(_alljoyn_aboutdata_handle* data, byte** modelNumber);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setsupportedlanguage(_alljoyn_aboutdata_handle* data, const(byte)* language);

@DllImport("MSAJApi.dll")
uint alljoyn_aboutdata_getsupportedlanguages(_alljoyn_aboutdata_handle* data, const(byte)** languageTags, uint num);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setdescription(_alljoyn_aboutdata_handle* data, const(byte)* description, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getdescription(_alljoyn_aboutdata_handle* data, byte** description, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setdateofmanufacture(_alljoyn_aboutdata_handle* data, const(byte)* dateOfManufacture);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getdateofmanufacture(_alljoyn_aboutdata_handle* data, byte** dateOfManufacture);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setsoftwareversion(_alljoyn_aboutdata_handle* data, const(byte)* softwareVersion);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getsoftwareversion(_alljoyn_aboutdata_handle* data, byte** softwareVersion);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getajsoftwareversion(_alljoyn_aboutdata_handle* data, byte** ajSoftwareVersion);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_sethardwareversion(_alljoyn_aboutdata_handle* data, const(byte)* hardwareVersion);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_gethardwareversion(_alljoyn_aboutdata_handle* data, byte** hardwareVersion);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setsupporturl(_alljoyn_aboutdata_handle* data, const(byte)* supportUrl);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getsupporturl(_alljoyn_aboutdata_handle* data, byte** supportUrl);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_setfield(_alljoyn_aboutdata_handle* data, const(byte)* name, _alljoyn_msgarg_handle* value, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getfield(_alljoyn_aboutdata_handle* data, const(byte)* name, _alljoyn_msgarg_handle** value, const(byte)* language);

@DllImport("MSAJApi.dll")
uint alljoyn_aboutdata_getfields(_alljoyn_aboutdata_handle* data, const(byte)** fields, uint num_fields);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getaboutdata(_alljoyn_aboutdata_handle* data, _alljoyn_msgarg_handle* msgArg, const(byte)* language);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutdata_getannouncedaboutdata(_alljoyn_aboutdata_handle* data, _alljoyn_msgarg_handle* msgArg);

@DllImport("MSAJApi.dll")
ubyte alljoyn_aboutdata_isfieldrequired(_alljoyn_aboutdata_handle* data, const(byte)* fieldName);

@DllImport("MSAJApi.dll")
ubyte alljoyn_aboutdata_isfieldannounced(_alljoyn_aboutdata_handle* data, const(byte)* fieldName);

@DllImport("MSAJApi.dll")
ubyte alljoyn_aboutdata_isfieldlocalized(_alljoyn_aboutdata_handle* data, const(byte)* fieldName);

@DllImport("MSAJApi.dll")
byte* alljoyn_aboutdata_getfieldsignature(_alljoyn_aboutdata_handle* data, const(byte)* fieldName);

@DllImport("MSAJApi.dll")
_alljoyn_aboutdatalistener_handle* alljoyn_aboutdatalistener_create(const(alljoyn_aboutdatalistener_callbacks)* callbacks, const(void)* context);

@DllImport("MSAJApi.dll")
void alljoyn_aboutdatalistener_destroy(_alljoyn_aboutdatalistener_handle* listener);

@DllImport("MSAJApi.dll")
ushort alljoyn_permissionconfigurator_getdefaultclaimcapabilities();

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getapplicationstate(const(_alljoyn_permissionconfigurator_handle)* configurator, alljoyn_applicationstate* state);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_setapplicationstate(_alljoyn_permissionconfigurator_handle* configurator, alljoyn_applicationstate state);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getpublickey(_alljoyn_permissionconfigurator_handle* configurator, byte** publicKey);

@DllImport("MSAJApi.dll")
void alljoyn_permissionconfigurator_publickey_destroy(byte* publicKey);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getmanifesttemplate(_alljoyn_permissionconfigurator_handle* configurator, byte** manifestTemplateXml);

@DllImport("MSAJApi.dll")
void alljoyn_permissionconfigurator_manifesttemplate_destroy(byte* manifestTemplateXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_setmanifesttemplatefromxml(_alljoyn_permissionconfigurator_handle* configurator, byte* manifestTemplateXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getclaimcapabilities(const(_alljoyn_permissionconfigurator_handle)* configurator, ushort* claimCapabilities);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_setclaimcapabilities(_alljoyn_permissionconfigurator_handle* configurator, ushort claimCapabilities);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getclaimcapabilitiesadditionalinfo(const(_alljoyn_permissionconfigurator_handle)* configurator, ushort* additionalInfo);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_setclaimcapabilitiesadditionalinfo(_alljoyn_permissionconfigurator_handle* configurator, ushort additionalInfo);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_reset(_alljoyn_permissionconfigurator_handle* configurator);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_claim(_alljoyn_permissionconfigurator_handle* configurator, byte* caKey, byte* identityCertificateChain, const(ubyte)* groupId, uint groupSize, byte* groupAuthority, byte** manifestsXmls, uint manifestsCount);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_updateidentity(_alljoyn_permissionconfigurator_handle* configurator, byte* identityCertificateChain, byte** manifestsXmls, uint manifestsCount);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getidentity(_alljoyn_permissionconfigurator_handle* configurator, byte** identityCertificateChain);

@DllImport("MSAJApi.dll")
void alljoyn_permissionconfigurator_certificatechain_destroy(byte* certificateChain);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getmanifests(_alljoyn_permissionconfigurator_handle* configurator, alljoyn_manifestarray* manifestArray);

@DllImport("MSAJApi.dll")
void alljoyn_permissionconfigurator_manifestarray_cleanup(alljoyn_manifestarray* manifestArray);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_installmanifests(_alljoyn_permissionconfigurator_handle* configurator, byte** manifestsXmls, uint manifestsCount, int append);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getidentitycertificateid(_alljoyn_permissionconfigurator_handle* configurator, alljoyn_certificateid* certificateId);

@DllImport("MSAJApi.dll")
void alljoyn_permissionconfigurator_certificateid_cleanup(alljoyn_certificateid* certificateId);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_updatepolicy(_alljoyn_permissionconfigurator_handle* configurator, byte* policyXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getpolicy(_alljoyn_permissionconfigurator_handle* configurator, byte** policyXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getdefaultpolicy(_alljoyn_permissionconfigurator_handle* configurator, byte** policyXml);

@DllImport("MSAJApi.dll")
void alljoyn_permissionconfigurator_policy_destroy(byte* policyXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_resetpolicy(_alljoyn_permissionconfigurator_handle* configurator);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_getmembershipsummaries(_alljoyn_permissionconfigurator_handle* configurator, alljoyn_certificateidarray* certificateIds);

@DllImport("MSAJApi.dll")
void alljoyn_permissionconfigurator_certificateidarray_cleanup(alljoyn_certificateidarray* certificateIdArray);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_installmembership(_alljoyn_permissionconfigurator_handle* configurator, byte* membershipCertificateChain);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_removemembership(_alljoyn_permissionconfigurator_handle* configurator, const(ubyte)* serial, uint serialLen, byte* issuerPublicKey, const(ubyte)* issuerAki, uint issuerAkiLen);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_startmanagement(_alljoyn_permissionconfigurator_handle* configurator);

@DllImport("MSAJApi.dll")
QStatus alljoyn_permissionconfigurator_endmanagement(_alljoyn_permissionconfigurator_handle* configurator);

@DllImport("MSAJApi.dll")
_alljoyn_applicationstatelistener_handle* alljoyn_applicationstatelistener_create(const(alljoyn_applicationstatelistener_callbacks)* callbacks, void* context);

@DllImport("MSAJApi.dll")
void alljoyn_applicationstatelistener_destroy(_alljoyn_applicationstatelistener_handle* listener);

@DllImport("MSAJApi.dll")
_alljoyn_keystorelistener_handle* alljoyn_keystorelistener_create(const(alljoyn_keystorelistener_callbacks)* callbacks, const(void)* context);

@DllImport("MSAJApi.dll")
_alljoyn_keystorelistener_handle* alljoyn_keystorelistener_with_synchronization_create(const(alljoyn_keystorelistener_with_synchronization_callbacks)* callbacks, void* context);

@DllImport("MSAJApi.dll")
void alljoyn_keystorelistener_destroy(_alljoyn_keystorelistener_handle* listener);

@DllImport("MSAJApi.dll")
QStatus alljoyn_keystorelistener_putkeys(_alljoyn_keystorelistener_handle* listener, _alljoyn_keystore_handle* keyStore, const(byte)* source, const(byte)* password);

@DllImport("MSAJApi.dll")
QStatus alljoyn_keystorelistener_getkeys(_alljoyn_keystorelistener_handle* listener, _alljoyn_keystore_handle* keyStore, byte* sink, uint* sink_sz);

@DllImport("MSAJApi.dll")
_alljoyn_sessionopts_handle* alljoyn_sessionopts_create(ubyte traffic, int isMultipoint, ubyte proximity, ushort transports);

@DllImport("MSAJApi.dll")
void alljoyn_sessionopts_destroy(_alljoyn_sessionopts_handle* opts);

@DllImport("MSAJApi.dll")
ubyte alljoyn_sessionopts_get_traffic(const(_alljoyn_sessionopts_handle)* opts);

@DllImport("MSAJApi.dll")
void alljoyn_sessionopts_set_traffic(_alljoyn_sessionopts_handle* opts, ubyte traffic);

@DllImport("MSAJApi.dll")
int alljoyn_sessionopts_get_multipoint(const(_alljoyn_sessionopts_handle)* opts);

@DllImport("MSAJApi.dll")
void alljoyn_sessionopts_set_multipoint(_alljoyn_sessionopts_handle* opts, int isMultipoint);

@DllImport("MSAJApi.dll")
ubyte alljoyn_sessionopts_get_proximity(const(_alljoyn_sessionopts_handle)* opts);

@DllImport("MSAJApi.dll")
void alljoyn_sessionopts_set_proximity(_alljoyn_sessionopts_handle* opts, ubyte proximity);

@DllImport("MSAJApi.dll")
ushort alljoyn_sessionopts_get_transports(const(_alljoyn_sessionopts_handle)* opts);

@DllImport("MSAJApi.dll")
void alljoyn_sessionopts_set_transports(_alljoyn_sessionopts_handle* opts, ushort transports);

@DllImport("MSAJApi.dll")
int alljoyn_sessionopts_iscompatible(const(_alljoyn_sessionopts_handle)* one, const(_alljoyn_sessionopts_handle)* other);

@DllImport("MSAJApi.dll")
int alljoyn_sessionopts_cmp(const(_alljoyn_sessionopts_handle)* one, const(_alljoyn_sessionopts_handle)* other);

@DllImport("MSAJApi.dll")
_alljoyn_message_handle* alljoyn_message_create(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
void alljoyn_message_destroy(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
int alljoyn_message_isbroadcastsignal(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
int alljoyn_message_isglobalbroadcast(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
int alljoyn_message_issessionless(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
ubyte alljoyn_message_getflags(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
int alljoyn_message_isexpired(_alljoyn_message_handle* msg, uint* tillExpireMS);

@DllImport("MSAJApi.dll")
int alljoyn_message_isunreliable(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
int alljoyn_message_isencrypted(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
byte* alljoyn_message_getauthmechanism(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
alljoyn_messagetype alljoyn_message_gettype(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
void alljoyn_message_getargs(_alljoyn_message_handle* msg, uint* numArgs, _alljoyn_msgarg_handle** args);

@DllImport("MSAJApi.dll")
_alljoyn_msgarg_handle* alljoyn_message_getarg(_alljoyn_message_handle* msg, uint argN);

@DllImport("MSAJApi.dll")
QStatus alljoyn_message_parseargs(_alljoyn_message_handle* msg, const(byte)* signature);

@DllImport("MSAJApi.dll")
uint alljoyn_message_getcallserial(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
byte* alljoyn_message_getsignature(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
byte* alljoyn_message_getobjectpath(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
byte* alljoyn_message_getinterface(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
byte* alljoyn_message_getmembername(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
uint alljoyn_message_getreplyserial(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
byte* alljoyn_message_getsender(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
byte* alljoyn_message_getreceiveendpointname(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
byte* alljoyn_message_getdestination(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
uint alljoyn_message_getcompressiontoken(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
uint alljoyn_message_getsessionid(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
byte* alljoyn_message_geterrorname(_alljoyn_message_handle* msg, byte* errorMessage, uint* errorMessage_size);

@DllImport("MSAJApi.dll")
uint alljoyn_message_tostring(_alljoyn_message_handle* msg, byte* str, uint buf);

@DllImport("MSAJApi.dll")
uint alljoyn_message_description(_alljoyn_message_handle* msg, byte* str, uint buf);

@DllImport("MSAJApi.dll")
uint alljoyn_message_gettimestamp(_alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
int alljoyn_message_eql(const(_alljoyn_message_handle)* one, const(_alljoyn_message_handle)* other);

@DllImport("MSAJApi.dll")
void alljoyn_message_setendianess(const(byte) endian);

@DllImport("MSAJApi.dll")
QStatus alljoyn_authlistener_requestcredentialsresponse(_alljoyn_authlistener_handle* listener, void* authContext, int accept, _alljoyn_credentials_handle* credentials);

@DllImport("MSAJApi.dll")
QStatus alljoyn_authlistener_verifycredentialsresponse(_alljoyn_authlistener_handle* listener, void* authContext, int accept);

@DllImport("MSAJApi.dll")
_alljoyn_authlistener_handle* alljoyn_authlistener_create(const(alljoyn_authlistener_callbacks)* callbacks, const(void)* context);

@DllImport("MSAJApi.dll")
_alljoyn_authlistener_handle* alljoyn_authlistenerasync_create(const(alljoyn_authlistenerasync_callbacks)* callbacks, const(void)* context);

@DllImport("MSAJApi.dll")
void alljoyn_authlistener_destroy(_alljoyn_authlistener_handle* listener);

@DllImport("MSAJApi.dll")
void alljoyn_authlistenerasync_destroy(_alljoyn_authlistener_handle* listener);

@DllImport("MSAJApi.dll")
QStatus alljoyn_authlistener_setsharedsecret(_alljoyn_authlistener_handle* listener, const(ubyte)* sharedSecret, uint sharedSecretSize);

@DllImport("MSAJApi.dll")
_alljoyn_credentials_handle* alljoyn_credentials_create();

@DllImport("MSAJApi.dll")
void alljoyn_credentials_destroy(_alljoyn_credentials_handle* cred);

@DllImport("MSAJApi.dll")
int alljoyn_credentials_isset(const(_alljoyn_credentials_handle)* cred, ushort creds);

@DllImport("MSAJApi.dll")
void alljoyn_credentials_setpassword(_alljoyn_credentials_handle* cred, const(byte)* pwd);

@DllImport("MSAJApi.dll")
void alljoyn_credentials_setusername(_alljoyn_credentials_handle* cred, const(byte)* userName);

@DllImport("MSAJApi.dll")
void alljoyn_credentials_setcertchain(_alljoyn_credentials_handle* cred, const(byte)* certChain);

@DllImport("MSAJApi.dll")
void alljoyn_credentials_setprivatekey(_alljoyn_credentials_handle* cred, const(byte)* pk);

@DllImport("MSAJApi.dll")
void alljoyn_credentials_setlogonentry(_alljoyn_credentials_handle* cred, const(byte)* logonEntry);

@DllImport("MSAJApi.dll")
void alljoyn_credentials_setexpiration(_alljoyn_credentials_handle* cred, uint expiration);

@DllImport("MSAJApi.dll")
byte* alljoyn_credentials_getpassword(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi.dll")
byte* alljoyn_credentials_getusername(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi.dll")
byte* alljoyn_credentials_getcertchain(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi.dll")
byte* alljoyn_credentials_getprivateKey(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi.dll")
byte* alljoyn_credentials_getlogonentry(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi.dll")
uint alljoyn_credentials_getexpiration(const(_alljoyn_credentials_handle)* cred);

@DllImport("MSAJApi.dll")
void alljoyn_credentials_clear(_alljoyn_credentials_handle* cred);

@DllImport("MSAJApi.dll")
_alljoyn_buslistener_handle* alljoyn_buslistener_create(const(alljoyn_buslistener_callbacks)* callbacks, const(void)* context);

@DllImport("MSAJApi.dll")
void alljoyn_buslistener_destroy(_alljoyn_buslistener_handle* listener);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_member_getannotationscount(alljoyn_interfacedescription_member member);

@DllImport("MSAJApi.dll")
void alljoyn_interfacedescription_member_getannotationatindex(alljoyn_interfacedescription_member member, uint index, byte* name, uint* name_size, byte* value, uint* value_size);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_member_getannotation(alljoyn_interfacedescription_member member, const(byte)* name, byte* value, uint* value_size);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_member_getargannotationscount(alljoyn_interfacedescription_member member, const(byte)* argName);

@DllImport("MSAJApi.dll")
void alljoyn_interfacedescription_member_getargannotationatindex(alljoyn_interfacedescription_member member, const(byte)* argName, uint index, byte* name, uint* name_size, byte* value, uint* value_size);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_member_getargannotation(alljoyn_interfacedescription_member member, const(byte)* argName, const(byte)* name, byte* value, uint* value_size);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_property_getannotationscount(alljoyn_interfacedescription_property property);

@DllImport("MSAJApi.dll")
void alljoyn_interfacedescription_property_getannotationatindex(alljoyn_interfacedescription_property property, uint index, byte* name, uint* name_size, byte* value, uint* value_size);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_property_getannotation(alljoyn_interfacedescription_property property, const(byte)* name, byte* value, uint* value_size);

@DllImport("MSAJApi.dll")
void alljoyn_interfacedescription_activate(_alljoyn_interfacedescription_handle* iface);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_addannotation(_alljoyn_interfacedescription_handle* iface, const(byte)* name, const(byte)* value);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_getannotation(_alljoyn_interfacedescription_handle* iface, const(byte)* name, byte* value, uint* value_size);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_getannotationscount(_alljoyn_interfacedescription_handle* iface);

@DllImport("MSAJApi.dll")
void alljoyn_interfacedescription_getannotationatindex(_alljoyn_interfacedescription_handle* iface, uint index, byte* name, uint* name_size, byte* value, uint* value_size);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_getmember(const(_alljoyn_interfacedescription_handle)* iface, const(byte)* name, alljoyn_interfacedescription_member* member);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_addmember(_alljoyn_interfacedescription_handle* iface, alljoyn_messagetype type, const(byte)* name, const(byte)* inputSig, const(byte)* outSig, const(byte)* argNames, ubyte annotation);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_addmemberannotation(_alljoyn_interfacedescription_handle* iface, const(byte)* member, const(byte)* name, const(byte)* value);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_getmemberannotation(_alljoyn_interfacedescription_handle* iface, const(byte)* member, const(byte)* name, byte* value, uint* value_size);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_getmembers(const(_alljoyn_interfacedescription_handle)* iface, alljoyn_interfacedescription_member* members, uint numMembers);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_hasmember(_alljoyn_interfacedescription_handle* iface, const(byte)* name, const(byte)* inSig, const(byte)* outSig);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_addmethod(_alljoyn_interfacedescription_handle* iface, const(byte)* name, const(byte)* inputSig, const(byte)* outSig, const(byte)* argNames, ubyte annotation, const(byte)* accessPerms);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_getmethod(_alljoyn_interfacedescription_handle* iface, const(byte)* name, alljoyn_interfacedescription_member* member);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_addsignal(_alljoyn_interfacedescription_handle* iface, const(byte)* name, const(byte)* sig, const(byte)* argNames, ubyte annotation, const(byte)* accessPerms);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_getsignal(_alljoyn_interfacedescription_handle* iface, const(byte)* name, alljoyn_interfacedescription_member* member);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_getproperty(const(_alljoyn_interfacedescription_handle)* iface, const(byte)* name, alljoyn_interfacedescription_property* property);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_getproperties(const(_alljoyn_interfacedescription_handle)* iface, alljoyn_interfacedescription_property* props, uint numProps);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_addproperty(_alljoyn_interfacedescription_handle* iface, const(byte)* name, const(byte)* signature, ubyte access);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_addpropertyannotation(_alljoyn_interfacedescription_handle* iface, const(byte)* property, const(byte)* name, const(byte)* value);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_getpropertyannotation(_alljoyn_interfacedescription_handle* iface, const(byte)* property, const(byte)* name, byte* value, uint* str_size);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_hasproperty(const(_alljoyn_interfacedescription_handle)* iface, const(byte)* name);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_hasproperties(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi.dll")
byte* alljoyn_interfacedescription_getname(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_introspect(const(_alljoyn_interfacedescription_handle)* iface, byte* str, uint buf, uint indent);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_issecure(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi.dll")
alljoyn_interfacedescription_securitypolicy alljoyn_interfacedescription_getsecuritypolicy(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi.dll")
void alljoyn_interfacedescription_setdescriptionlanguage(_alljoyn_interfacedescription_handle* iface, const(byte)* language);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_getdescriptionlanguages(const(_alljoyn_interfacedescription_handle)* iface, const(byte)** languages, uint size);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_getdescriptionlanguages2(const(_alljoyn_interfacedescription_handle)* iface, byte* languages, uint languagesSize);

@DllImport("MSAJApi.dll")
void alljoyn_interfacedescription_setdescription(_alljoyn_interfacedescription_handle* iface, const(byte)* description);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_setdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, const(byte)* description, const(byte)* languageTag);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_getdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, byte* description, uint maxLanguageLength, const(byte)* languageTag);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_setmemberdescription(_alljoyn_interfacedescription_handle* iface, const(byte)* member, const(byte)* description);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_setmemberdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, const(byte)* member, const(byte)* description, const(byte)* languageTag);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_getmemberdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, const(byte)* member, byte* description, uint maxLanguageLength, const(byte)* languageTag);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_setargdescription(_alljoyn_interfacedescription_handle* iface, const(byte)* member, const(byte)* argName, const(byte)* description);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_setargdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, const(byte)* member, const(byte)* arg, const(byte)* description, const(byte)* languageTag);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_getargdescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, const(byte)* member, const(byte)* arg, byte* description, uint maxLanguageLength, const(byte)* languageTag);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_setpropertydescription(_alljoyn_interfacedescription_handle* iface, const(byte)* name, const(byte)* description);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_setpropertydescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, const(byte)* name, const(byte)* description, const(byte)* languageTag);

@DllImport("MSAJApi.dll")
uint alljoyn_interfacedescription_getpropertydescriptionforlanguage(_alljoyn_interfacedescription_handle* iface, const(byte)* property, byte* description, uint maxLanguageLength, const(byte)* languageTag);

@DllImport("MSAJApi.dll")
void alljoyn_interfacedescription_setdescriptiontranslationcallback(_alljoyn_interfacedescription_handle* iface, alljoyn_interfacedescription_translation_callback_ptr translationCallback);

@DllImport("MSAJApi.dll")
alljoyn_interfacedescription_translation_callback_ptr alljoyn_interfacedescription_getdescriptiontranslationcallback(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_hasdescription(const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi.dll")
QStatus alljoyn_interfacedescription_addargannotation(_alljoyn_interfacedescription_handle* iface, const(byte)* member, const(byte)* argName, const(byte)* name, const(byte)* value);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_getmemberargannotation(const(_alljoyn_interfacedescription_handle)* iface, const(byte)* member, const(byte)* argName, const(byte)* name, byte* value, uint* value_size);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_eql(const(_alljoyn_interfacedescription_handle)* one, const(_alljoyn_interfacedescription_handle)* other);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_member_eql(const(alljoyn_interfacedescription_member) one, const(alljoyn_interfacedescription_member) other);

@DllImport("MSAJApi.dll")
int alljoyn_interfacedescription_property_eql(const(alljoyn_interfacedescription_property) one, const(alljoyn_interfacedescription_property) other);

@DllImport("MSAJApi.dll")
_alljoyn_busobject_handle* alljoyn_busobject_create(const(byte)* path, int isPlaceholder, const(alljoyn_busobject_callbacks)* callbacks_in, const(void)* context_in);

@DllImport("MSAJApi.dll")
void alljoyn_busobject_destroy(_alljoyn_busobject_handle* bus);

@DllImport("MSAJApi.dll")
byte* alljoyn_busobject_getpath(_alljoyn_busobject_handle* bus);

@DllImport("MSAJApi.dll")
void alljoyn_busobject_emitpropertychanged(_alljoyn_busobject_handle* bus, const(byte)* ifcName, const(byte)* propName, _alljoyn_msgarg_handle* val, uint id);

@DllImport("MSAJApi.dll")
void alljoyn_busobject_emitpropertieschanged(_alljoyn_busobject_handle* bus, const(byte)* ifcName, const(byte)** propNames, uint numProps, uint id);

@DllImport("MSAJApi.dll")
uint alljoyn_busobject_getname(_alljoyn_busobject_handle* bus, byte* buffer, uint bufferSz);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_addinterface(_alljoyn_busobject_handle* bus, const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_addmethodhandler(_alljoyn_busobject_handle* bus, const(alljoyn_interfacedescription_member) member, alljoyn_messagereceiver_methodhandler_ptr handler, void* context);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_addmethodhandlers(_alljoyn_busobject_handle* bus, const(alljoyn_busobject_methodentry)* entries, uint numEntries);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_methodreply_args(_alljoyn_busobject_handle* bus, _alljoyn_message_handle* msg, const(_alljoyn_msgarg_handle)* args, uint numArgs);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_methodreply_err(_alljoyn_busobject_handle* bus, _alljoyn_message_handle* msg, const(byte)* error, const(byte)* errorMessage);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_methodreply_status(_alljoyn_busobject_handle* bus, _alljoyn_message_handle* msg, QStatus status);

@DllImport("MSAJApi.dll")
_alljoyn_busattachment_handle* alljoyn_busobject_getbusattachment(_alljoyn_busobject_handle* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_signal(_alljoyn_busobject_handle* bus, const(byte)* destination, uint sessionId, const(alljoyn_interfacedescription_member) signal, const(_alljoyn_msgarg_handle)* args, uint numArgs, ushort timeToLive, ubyte flags, _alljoyn_message_handle* msg);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_cancelsessionlessmessage_serial(_alljoyn_busobject_handle* bus, uint serialNumber);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_cancelsessionlessmessage(_alljoyn_busobject_handle* bus, const(_alljoyn_message_handle)* msg);

@DllImport("MSAJApi.dll")
int alljoyn_busobject_issecure(_alljoyn_busobject_handle* bus);

@DllImport("MSAJApi.dll")
uint alljoyn_busobject_getannouncedinterfacenames(_alljoyn_busobject_handle* bus, const(byte)** interfaces, uint numInterfaces);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_setannounceflag(_alljoyn_busobject_handle* bus, const(_alljoyn_interfacedescription_handle)* iface, alljoyn_about_announceflag isAnnounced);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busobject_addinterface_announced(_alljoyn_busobject_handle* bus, const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_handle* alljoyn_proxybusobject_create(_alljoyn_busattachment_handle* bus, const(byte)* service, const(byte)* path, uint sessionId);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_handle* alljoyn_proxybusobject_create_secure(_alljoyn_busattachment_handle* bus, const(byte)* service, const(byte)* path, uint sessionId);

@DllImport("MSAJApi.dll")
void alljoyn_proxybusobject_destroy(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_addinterface(_alljoyn_proxybusobject_handle* proxyObj, const(_alljoyn_interfacedescription_handle)* iface);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_addinterface_by_name(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* name);

@DllImport("MSAJApi.dll")
uint alljoyn_proxybusobject_getchildren(_alljoyn_proxybusobject_handle* proxyObj, _alljoyn_proxybusobject_handle** children, uint numChildren);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_handle* alljoyn_proxybusobject_getchild(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* path);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_addchild(_alljoyn_proxybusobject_handle* proxyObj, const(_alljoyn_proxybusobject_handle)* child);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_removechild(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* path);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_introspectremoteobject(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_introspectremoteobjectasync(_alljoyn_proxybusobject_handle* proxyObj, alljoyn_proxybusobject_listener_introspectcb_ptr callback, void* context);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_getproperty(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, const(byte)* property, _alljoyn_msgarg_handle* value);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_getpropertyasync(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, const(byte)* property, alljoyn_proxybusobject_listener_getpropertycb_ptr callback, uint timeout, void* context);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_getallproperties(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, _alljoyn_msgarg_handle* values);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_getallpropertiesasync(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, alljoyn_proxybusobject_listener_getallpropertiescb_ptr callback, uint timeout, void* context);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_setproperty(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, const(byte)* property, _alljoyn_msgarg_handle* value);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_registerpropertieschangedlistener(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, const(byte)** properties, uint numProperties, alljoyn_proxybusobject_listener_propertieschanged_ptr callback, void* context);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_unregisterpropertieschangedlistener(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, alljoyn_proxybusobject_listener_propertieschanged_ptr callback);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_setpropertyasync(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface, const(byte)* property, _alljoyn_msgarg_handle* value, alljoyn_proxybusobject_listener_setpropertycb_ptr callback, uint timeout, void* context);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_methodcall(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* ifaceName, const(byte)* methodName, const(_alljoyn_msgarg_handle)* args, uint numArgs, _alljoyn_message_handle* replyMsg, uint timeout, ubyte flags);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_methodcall_member(_alljoyn_proxybusobject_handle* proxyObj, const(alljoyn_interfacedescription_member) method, const(_alljoyn_msgarg_handle)* args, uint numArgs, _alljoyn_message_handle* replyMsg, uint timeout, ubyte flags);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_methodcall_noreply(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* ifaceName, const(byte)* methodName, const(_alljoyn_msgarg_handle)* args, uint numArgs, ubyte flags);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_methodcall_member_noreply(_alljoyn_proxybusobject_handle* proxyObj, const(alljoyn_interfacedescription_member) method, const(_alljoyn_msgarg_handle)* args, uint numArgs, ubyte flags);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_methodcallasync(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* ifaceName, const(byte)* methodName, alljoyn_messagereceiver_replyhandler_ptr replyFunc, const(_alljoyn_msgarg_handle)* args, uint numArgs, void* context, uint timeout, ubyte flags);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_methodcallasync_member(_alljoyn_proxybusobject_handle* proxyObj, const(alljoyn_interfacedescription_member) method, alljoyn_messagereceiver_replyhandler_ptr replyFunc, const(_alljoyn_msgarg_handle)* args, uint numArgs, void* context, uint timeout, ubyte flags);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_parsexml(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* xml, const(byte)* identifier);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_secureconnection(_alljoyn_proxybusobject_handle* proxyObj, int forceAuth);

@DllImport("MSAJApi.dll")
QStatus alljoyn_proxybusobject_secureconnectionasync(_alljoyn_proxybusobject_handle* proxyObj, int forceAuth);

@DllImport("MSAJApi.dll")
_alljoyn_interfacedescription_handle* alljoyn_proxybusobject_getinterface(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface);

@DllImport("MSAJApi.dll")
uint alljoyn_proxybusobject_getinterfaces(_alljoyn_proxybusobject_handle* proxyObj, const(_alljoyn_interfacedescription_handle)** ifaces, uint numIfaces);

@DllImport("MSAJApi.dll")
byte* alljoyn_proxybusobject_getpath(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi.dll")
byte* alljoyn_proxybusobject_getservicename(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi.dll")
byte* alljoyn_proxybusobject_getuniquename(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi.dll")
uint alljoyn_proxybusobject_getsessionid(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi.dll")
int alljoyn_proxybusobject_implementsinterface(_alljoyn_proxybusobject_handle* proxyObj, const(byte)* iface);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_handle* alljoyn_proxybusobject_copy(const(_alljoyn_proxybusobject_handle)* source);

@DllImport("MSAJApi.dll")
int alljoyn_proxybusobject_isvalid(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi.dll")
int alljoyn_proxybusobject_issecure(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi.dll")
void alljoyn_proxybusobject_enablepropertycaching(_alljoyn_proxybusobject_handle* proxyObj);

@DllImport("MSAJApi.dll")
_alljoyn_permissionconfigurationlistener_handle* alljoyn_permissionconfigurationlistener_create(const(alljoyn_permissionconfigurationlistener_callbacks)* callbacks, const(void)* context);

@DllImport("MSAJApi.dll")
void alljoyn_permissionconfigurationlistener_destroy(_alljoyn_permissionconfigurationlistener_handle* listener);

@DllImport("MSAJApi.dll")
_alljoyn_sessionlistener_handle* alljoyn_sessionlistener_create(const(alljoyn_sessionlistener_callbacks)* callbacks, const(void)* context);

@DllImport("MSAJApi.dll")
void alljoyn_sessionlistener_destroy(_alljoyn_sessionlistener_handle* listener);

@DllImport("MSAJApi.dll")
_alljoyn_sessionportlistener_handle* alljoyn_sessionportlistener_create(const(alljoyn_sessionportlistener_callbacks)* callbacks, const(void)* context);

@DllImport("MSAJApi.dll")
void alljoyn_sessionportlistener_destroy(_alljoyn_sessionportlistener_handle* listener);

@DllImport("MSAJApi.dll")
_alljoyn_aboutlistener_handle* alljoyn_aboutlistener_create(const(alljoyn_aboutlistener_callback)* callback, const(void)* context);

@DllImport("MSAJApi.dll")
void alljoyn_aboutlistener_destroy(_alljoyn_aboutlistener_handle* listener);

@DllImport("MSAJApi.dll")
_alljoyn_busattachment_handle* alljoyn_busattachment_create(const(byte)* applicationName, int allowRemoteMessages);

@DllImport("MSAJApi.dll")
_alljoyn_busattachment_handle* alljoyn_busattachment_create_concurrency(const(byte)* applicationName, int allowRemoteMessages, uint concurrency);

@DllImport("MSAJApi.dll")
void alljoyn_busattachment_destroy(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_start(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_stop(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_join(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
uint alljoyn_busattachment_getconcurrency(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
byte* alljoyn_busattachment_getconnectspec(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
void alljoyn_busattachment_enableconcurrentcallbacks(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_createinterface(_alljoyn_busattachment_handle* bus, const(byte)* name, _alljoyn_interfacedescription_handle** iface);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_createinterface_secure(_alljoyn_busattachment_handle* bus, const(byte)* name, _alljoyn_interfacedescription_handle** iface, alljoyn_interfacedescription_securitypolicy secPolicy);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_connect(_alljoyn_busattachment_handle* bus, const(byte)* connectSpec);

@DllImport("MSAJApi.dll")
void alljoyn_busattachment_registerbuslistener(_alljoyn_busattachment_handle* bus, _alljoyn_buslistener_handle* listener);

@DllImport("MSAJApi.dll")
void alljoyn_busattachment_unregisterbuslistener(_alljoyn_busattachment_handle* bus, _alljoyn_buslistener_handle* listener);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_findadvertisedname(_alljoyn_busattachment_handle* bus, const(byte)* namePrefix);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_findadvertisednamebytransport(_alljoyn_busattachment_handle* bus, const(byte)* namePrefix, ushort transports);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_cancelfindadvertisedname(_alljoyn_busattachment_handle* bus, const(byte)* namePrefix);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_cancelfindadvertisednamebytransport(_alljoyn_busattachment_handle* bus, const(byte)* namePrefix, ushort transports);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_advertisename(_alljoyn_busattachment_handle* bus, const(byte)* name, ushort transports);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_canceladvertisename(_alljoyn_busattachment_handle* bus, const(byte)* name, ushort transports);

@DllImport("MSAJApi.dll")
_alljoyn_interfacedescription_handle* alljoyn_busattachment_getinterface(_alljoyn_busattachment_handle* bus, const(byte)* name);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_joinsession(_alljoyn_busattachment_handle* bus, const(byte)* sessionHost, ushort sessionPort, _alljoyn_sessionlistener_handle* listener, uint* sessionId, _alljoyn_sessionopts_handle* opts);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_joinsessionasync(_alljoyn_busattachment_handle* bus, const(byte)* sessionHost, ushort sessionPort, _alljoyn_sessionlistener_handle* listener, const(_alljoyn_sessionopts_handle)* opts, alljoyn_busattachment_joinsessioncb_ptr callback, void* context);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_registerbusobject(_alljoyn_busattachment_handle* bus, _alljoyn_busobject_handle* obj);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_registerbusobject_secure(_alljoyn_busattachment_handle* bus, _alljoyn_busobject_handle* obj);

@DllImport("MSAJApi.dll")
void alljoyn_busattachment_unregisterbusobject(_alljoyn_busattachment_handle* bus, _alljoyn_busobject_handle* object);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_requestname(_alljoyn_busattachment_handle* bus, const(byte)* requestedName, uint flags);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_releasename(_alljoyn_busattachment_handle* bus, const(byte)* name);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_bindsessionport(_alljoyn_busattachment_handle* bus, ushort* sessionPort, const(_alljoyn_sessionopts_handle)* opts, _alljoyn_sessionportlistener_handle* listener);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_unbindsessionport(_alljoyn_busattachment_handle* bus, ushort sessionPort);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_enablepeersecurity(_alljoyn_busattachment_handle* bus, const(byte)* authMechanisms, _alljoyn_authlistener_handle* listener, const(byte)* keyStoreFileName, int isShared);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_enablepeersecuritywithpermissionconfigurationlistener(_alljoyn_busattachment_handle* bus, const(byte)* authMechanisms, _alljoyn_authlistener_handle* authListener, const(byte)* keyStoreFileName, int isShared, _alljoyn_permissionconfigurationlistener_handle* permissionConfigurationListener);

@DllImport("MSAJApi.dll")
int alljoyn_busattachment_ispeersecurityenabled(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_createinterfacesfromxml(_alljoyn_busattachment_handle* bus, const(byte)* xml);

@DllImport("MSAJApi.dll")
uint alljoyn_busattachment_getinterfaces(const(_alljoyn_busattachment_handle)* bus, const(_alljoyn_interfacedescription_handle)** ifaces, uint numIfaces);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_deleteinterface(_alljoyn_busattachment_handle* bus, _alljoyn_interfacedescription_handle* iface);

@DllImport("MSAJApi.dll")
int alljoyn_busattachment_isstarted(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
int alljoyn_busattachment_isstopping(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
int alljoyn_busattachment_isconnected(const(_alljoyn_busattachment_handle)* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_disconnect(_alljoyn_busattachment_handle* bus, const(byte)* unused);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_handle* alljoyn_busattachment_getdbusproxyobj(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_handle* alljoyn_busattachment_getalljoynproxyobj(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_handle* alljoyn_busattachment_getalljoyndebugobj(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
byte* alljoyn_busattachment_getuniquename(const(_alljoyn_busattachment_handle)* bus);

@DllImport("MSAJApi.dll")
byte* alljoyn_busattachment_getglobalguidstring(const(_alljoyn_busattachment_handle)* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_registersignalhandler(_alljoyn_busattachment_handle* bus, alljoyn_messagereceiver_signalhandler_ptr signal_handler, const(alljoyn_interfacedescription_member) member, const(byte)* srcPath);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_registersignalhandlerwithrule(_alljoyn_busattachment_handle* bus, alljoyn_messagereceiver_signalhandler_ptr signal_handler, const(alljoyn_interfacedescription_member) member, const(byte)* matchRule);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_unregistersignalhandler(_alljoyn_busattachment_handle* bus, alljoyn_messagereceiver_signalhandler_ptr signal_handler, const(alljoyn_interfacedescription_member) member, const(byte)* srcPath);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_unregistersignalhandlerwithrule(_alljoyn_busattachment_handle* bus, alljoyn_messagereceiver_signalhandler_ptr signal_handler, const(alljoyn_interfacedescription_member) member, const(byte)* matchRule);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_unregisterallhandlers(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_registerkeystorelistener(_alljoyn_busattachment_handle* bus, _alljoyn_keystorelistener_handle* listener);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_reloadkeystore(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
void alljoyn_busattachment_clearkeystore(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_clearkeys(_alljoyn_busattachment_handle* bus, const(byte)* guid);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_setkeyexpiration(_alljoyn_busattachment_handle* bus, const(byte)* guid, uint timeout);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_getkeyexpiration(_alljoyn_busattachment_handle* bus, const(byte)* guid, uint* timeout);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_addlogonentry(_alljoyn_busattachment_handle* bus, const(byte)* authMechanism, const(byte)* userName, const(byte)* password);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_addmatch(_alljoyn_busattachment_handle* bus, const(byte)* rule);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_removematch(_alljoyn_busattachment_handle* bus, const(byte)* rule);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_setsessionlistener(_alljoyn_busattachment_handle* bus, uint sessionId, _alljoyn_sessionlistener_handle* listener);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_leavesession(_alljoyn_busattachment_handle* bus, uint sessionId);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_secureconnection(_alljoyn_busattachment_handle* bus, const(byte)* name, int forceAuth);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_secureconnectionasync(_alljoyn_busattachment_handle* bus, const(byte)* name, int forceAuth);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_removesessionmember(_alljoyn_busattachment_handle* bus, uint sessionId, const(byte)* memberName);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_setlinktimeout(_alljoyn_busattachment_handle* bus, uint sessionid, uint* linkTimeout);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_setlinktimeoutasync(_alljoyn_busattachment_handle* bus, uint sessionid, uint linkTimeout, alljoyn_busattachment_setlinktimeoutcb_ptr callback, void* context);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_namehasowner(_alljoyn_busattachment_handle* bus, const(byte)* name, int* hasOwner);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_getpeerguid(_alljoyn_busattachment_handle* bus, const(byte)* name, byte* guid, uint* guidSz);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_setdaemondebug(_alljoyn_busattachment_handle* bus, const(byte)* module, uint level);

@DllImport("MSAJApi.dll")
uint alljoyn_busattachment_gettimestamp();

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_ping(_alljoyn_busattachment_handle* bus, const(byte)* name, uint timeout);

@DllImport("MSAJApi.dll")
void alljoyn_busattachment_registeraboutlistener(_alljoyn_busattachment_handle* bus, _alljoyn_aboutlistener_handle* aboutListener);

@DllImport("MSAJApi.dll")
void alljoyn_busattachment_unregisteraboutlistener(_alljoyn_busattachment_handle* bus, _alljoyn_aboutlistener_handle* aboutListener);

@DllImport("MSAJApi.dll")
void alljoyn_busattachment_unregisterallaboutlisteners(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_whoimplements_interfaces(_alljoyn_busattachment_handle* bus, const(byte)** implementsInterfaces, uint numberInterfaces);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_whoimplements_interface(_alljoyn_busattachment_handle* bus, const(byte)* implementsInterface);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_cancelwhoimplements_interfaces(_alljoyn_busattachment_handle* bus, const(byte)** implementsInterfaces, uint numberInterfaces);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_cancelwhoimplements_interface(_alljoyn_busattachment_handle* bus, const(byte)* implementsInterface);

@DllImport("MSAJApi.dll")
_alljoyn_permissionconfigurator_handle* alljoyn_busattachment_getpermissionconfigurator(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_registerapplicationstatelistener(_alljoyn_busattachment_handle* bus, _alljoyn_applicationstatelistener_handle* listener);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_unregisterapplicationstatelistener(_alljoyn_busattachment_handle* bus, _alljoyn_applicationstatelistener_handle* listener);

@DllImport("MSAJApi.dll")
QStatus alljoyn_busattachment_deletedefaultkeystore(const(byte)* applicationName);

@DllImport("MSAJApi.dll")
_alljoyn_aboutobj_handle* alljoyn_aboutobj_create(_alljoyn_busattachment_handle* bus, alljoyn_about_announceflag isAnnounced);

@DllImport("MSAJApi.dll")
void alljoyn_aboutobj_destroy(_alljoyn_aboutobj_handle* obj);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutobj_announce(_alljoyn_aboutobj_handle* obj, ushort sessionPort, _alljoyn_aboutdata_handle* aboutData);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutobj_announce_using_datalistener(_alljoyn_aboutobj_handle* obj, ushort sessionPort, _alljoyn_aboutdatalistener_handle* aboutListener);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutobj_unannounce(_alljoyn_aboutobj_handle* obj);

@DllImport("MSAJApi.dll")
_alljoyn_aboutobjectdescription_handle* alljoyn_aboutobjectdescription_create();

@DllImport("MSAJApi.dll")
_alljoyn_aboutobjectdescription_handle* alljoyn_aboutobjectdescription_create_full(const(_alljoyn_msgarg_handle)* arg);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutobjectdescription_createfrommsgarg(_alljoyn_aboutobjectdescription_handle* description, const(_alljoyn_msgarg_handle)* arg);

@DllImport("MSAJApi.dll")
void alljoyn_aboutobjectdescription_destroy(_alljoyn_aboutobjectdescription_handle* description);

@DllImport("MSAJApi.dll")
uint alljoyn_aboutobjectdescription_getpaths(_alljoyn_aboutobjectdescription_handle* description, const(byte)** paths, uint numPaths);

@DllImport("MSAJApi.dll")
uint alljoyn_aboutobjectdescription_getinterfaces(_alljoyn_aboutobjectdescription_handle* description, const(byte)* path, const(byte)** interfaces, uint numInterfaces);

@DllImport("MSAJApi.dll")
uint alljoyn_aboutobjectdescription_getinterfacepaths(_alljoyn_aboutobjectdescription_handle* description, const(byte)* interfaceName, const(byte)** paths, uint numPaths);

@DllImport("MSAJApi.dll")
void alljoyn_aboutobjectdescription_clear(_alljoyn_aboutobjectdescription_handle* description);

@DllImport("MSAJApi.dll")
ubyte alljoyn_aboutobjectdescription_haspath(_alljoyn_aboutobjectdescription_handle* description, const(byte)* path);

@DllImport("MSAJApi.dll")
ubyte alljoyn_aboutobjectdescription_hasinterface(_alljoyn_aboutobjectdescription_handle* description, const(byte)* interfaceName);

@DllImport("MSAJApi.dll")
ubyte alljoyn_aboutobjectdescription_hasinterfaceatpath(_alljoyn_aboutobjectdescription_handle* description, const(byte)* path, const(byte)* interfaceName);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutobjectdescription_getmsgarg(_alljoyn_aboutobjectdescription_handle* description, _alljoyn_msgarg_handle* msgArg);

@DllImport("MSAJApi.dll")
_alljoyn_aboutproxy_handle* alljoyn_aboutproxy_create(_alljoyn_busattachment_handle* bus, const(byte)* busName, uint sessionId);

@DllImport("MSAJApi.dll")
void alljoyn_aboutproxy_destroy(_alljoyn_aboutproxy_handle* proxy);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutproxy_getobjectdescription(_alljoyn_aboutproxy_handle* proxy, _alljoyn_msgarg_handle* objectDesc);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutproxy_getaboutdata(_alljoyn_aboutproxy_handle* proxy, const(byte)* language, _alljoyn_msgarg_handle* data);

@DllImport("MSAJApi.dll")
QStatus alljoyn_aboutproxy_getversion(_alljoyn_aboutproxy_handle* proxy, ushort* version);

@DllImport("MSAJApi.dll")
_alljoyn_pinglistener_handle* alljoyn_pinglistener_create(const(alljoyn_pinglistener_callback)* callback, const(void)* context);

@DllImport("MSAJApi.dll")
void alljoyn_pinglistener_destroy(_alljoyn_pinglistener_handle* listener);

@DllImport("MSAJApi.dll")
_alljoyn_autopinger_handle* alljoyn_autopinger_create(_alljoyn_busattachment_handle* bus);

@DllImport("MSAJApi.dll")
void alljoyn_autopinger_destroy(_alljoyn_autopinger_handle* autopinger);

@DllImport("MSAJApi.dll")
void alljoyn_autopinger_pause(_alljoyn_autopinger_handle* autopinger);

@DllImport("MSAJApi.dll")
void alljoyn_autopinger_resume(_alljoyn_autopinger_handle* autopinger);

@DllImport("MSAJApi.dll")
void alljoyn_autopinger_addpinggroup(_alljoyn_autopinger_handle* autopinger, const(byte)* group, _alljoyn_pinglistener_handle* listener, uint pinginterval);

@DllImport("MSAJApi.dll")
void alljoyn_autopinger_removepinggroup(_alljoyn_autopinger_handle* autopinger, const(byte)* group);

@DllImport("MSAJApi.dll")
QStatus alljoyn_autopinger_setpinginterval(_alljoyn_autopinger_handle* autopinger, const(byte)* group, uint pinginterval);

@DllImport("MSAJApi.dll")
QStatus alljoyn_autopinger_adddestination(_alljoyn_autopinger_handle* autopinger, const(byte)* group, const(byte)* destination);

@DllImport("MSAJApi.dll")
QStatus alljoyn_autopinger_removedestination(_alljoyn_autopinger_handle* autopinger, const(byte)* group, const(byte)* destination, int removeall);

@DllImport("MSAJApi.dll")
byte* alljoyn_getversion();

@DllImport("MSAJApi.dll")
byte* alljoyn_getbuildinfo();

@DllImport("MSAJApi.dll")
uint alljoyn_getnumericversion();

@DllImport("MSAJApi.dll")
QStatus alljoyn_init();

@DllImport("MSAJApi.dll")
QStatus alljoyn_shutdown();

@DllImport("MSAJApi.dll")
QStatus alljoyn_routerinit();

@DllImport("MSAJApi.dll")
QStatus alljoyn_routerinitwithconfig(byte* configXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_routershutdown();

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_ref_handle* alljoyn_proxybusobject_ref_create(_alljoyn_proxybusobject_handle* proxy);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_handle* alljoyn_proxybusobject_ref_get(_alljoyn_proxybusobject_ref_handle* ref);

@DllImport("MSAJApi.dll")
void alljoyn_proxybusobject_ref_incref(_alljoyn_proxybusobject_ref_handle* ref);

@DllImport("MSAJApi.dll")
void alljoyn_proxybusobject_ref_decref(_alljoyn_proxybusobject_ref_handle* ref);

@DllImport("MSAJApi.dll")
_alljoyn_observerlistener_handle* alljoyn_observerlistener_create(const(alljoyn_observerlistener_callback)* callback, const(void)* context);

@DllImport("MSAJApi.dll")
void alljoyn_observerlistener_destroy(_alljoyn_observerlistener_handle* listener);

@DllImport("MSAJApi.dll")
_alljoyn_observer_handle* alljoyn_observer_create(_alljoyn_busattachment_handle* bus, const(byte)** mandatoryInterfaces, uint numMandatoryInterfaces);

@DllImport("MSAJApi.dll")
void alljoyn_observer_destroy(_alljoyn_observer_handle* observer);

@DllImport("MSAJApi.dll")
void alljoyn_observer_registerlistener(_alljoyn_observer_handle* observer, _alljoyn_observerlistener_handle* listener, int triggerOnExisting);

@DllImport("MSAJApi.dll")
void alljoyn_observer_unregisterlistener(_alljoyn_observer_handle* observer, _alljoyn_observerlistener_handle* listener);

@DllImport("MSAJApi.dll")
void alljoyn_observer_unregisteralllisteners(_alljoyn_observer_handle* observer);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_ref_handle* alljoyn_observer_get(_alljoyn_observer_handle* observer, const(byte)* uniqueBusName, const(byte)* objectPath);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_ref_handle* alljoyn_observer_getfirst(_alljoyn_observer_handle* observer);

@DllImport("MSAJApi.dll")
_alljoyn_proxybusobject_ref_handle* alljoyn_observer_getnext(_alljoyn_observer_handle* observer, _alljoyn_proxybusobject_ref_handle* proxyref);

@DllImport("MSAJApi.dll")
ushort alljoyn_securityapplicationproxy_getpermissionmanagementsessionport();

@DllImport("MSAJApi.dll")
_alljoyn_securityapplicationproxy_handle* alljoyn_securityapplicationproxy_create(_alljoyn_busattachment_handle* bus, byte* appBusName, uint sessionId);

@DllImport("MSAJApi.dll")
void alljoyn_securityapplicationproxy_destroy(_alljoyn_securityapplicationproxy_handle* proxy);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_claim(_alljoyn_securityapplicationproxy_handle* proxy, byte* caKey, byte* identityCertificateChain, const(ubyte)* groupId, uint groupSize, byte* groupAuthority, byte** manifestsXmls, uint manifestsCount);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_getmanifesttemplate(_alljoyn_securityapplicationproxy_handle* proxy, byte** manifestTemplateXml);

@DllImport("MSAJApi.dll")
void alljoyn_securityapplicationproxy_manifesttemplate_destroy(byte* manifestTemplateXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_getapplicationstate(_alljoyn_securityapplicationproxy_handle* proxy, alljoyn_applicationstate* applicationState);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_getclaimcapabilities(_alljoyn_securityapplicationproxy_handle* proxy, ushort* capabilities);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_getclaimcapabilitiesadditionalinfo(_alljoyn_securityapplicationproxy_handle* proxy, ushort* additionalInfo);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_getpolicy(_alljoyn_securityapplicationproxy_handle* proxy, byte** policyXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_getdefaultpolicy(_alljoyn_securityapplicationproxy_handle* proxy, byte** policyXml);

@DllImport("MSAJApi.dll")
void alljoyn_securityapplicationproxy_policy_destroy(byte* policyXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_updatepolicy(_alljoyn_securityapplicationproxy_handle* proxy, byte* policyXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_updateidentity(_alljoyn_securityapplicationproxy_handle* proxy, byte* identityCertificateChain, byte** manifestsXmls, uint manifestsCount);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_installmembership(_alljoyn_securityapplicationproxy_handle* proxy, byte* membershipCertificateChain);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_reset(_alljoyn_securityapplicationproxy_handle* proxy);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_resetpolicy(_alljoyn_securityapplicationproxy_handle* proxy);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_startmanagement(_alljoyn_securityapplicationproxy_handle* proxy);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_endmanagement(_alljoyn_securityapplicationproxy_handle* proxy);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_geteccpublickey(_alljoyn_securityapplicationproxy_handle* proxy, byte** eccPublicKey);

@DllImport("MSAJApi.dll")
void alljoyn_securityapplicationproxy_eccpublickey_destroy(byte* eccPublicKey);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_signmanifest(byte* unsignedManifestXml, byte* identityCertificatePem, byte* signingPrivateKeyPem, byte** signedManifestXml);

@DllImport("MSAJApi.dll")
void alljoyn_securityapplicationproxy_manifest_destroy(byte* signedManifestXml);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_computemanifestdigest(byte* unsignedManifestXml, byte* identityCertificatePem, ubyte** digest, uint* digestSize);

@DllImport("MSAJApi.dll")
void alljoyn_securityapplicationproxy_digest_destroy(ubyte* digest);

@DllImport("MSAJApi.dll")
QStatus alljoyn_securityapplicationproxy_setmanifestsignature(byte* unsignedManifestXml, byte* identityCertificatePem, const(ubyte)* signature, uint signatureSize, byte** signedManifestXml);

