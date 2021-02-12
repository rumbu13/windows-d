module windows.mobilebroadband;

public import windows.automation;
public import windows.com;

extern(Windows):

alias LPMAPILOGON = extern(Windows) uint function();
alias LPMAPILOGOFF = extern(Windows) uint function();
alias LPMAPISENDMAIL = extern(Windows) uint function();
alias LPMAPISENDMAILW = extern(Windows) uint function();
alias LPMAPISENDDOCUMENTS = extern(Windows) uint function();
alias LPMAPIFINDNEXT = extern(Windows) uint function();
alias LPMAPIREADMAIL = extern(Windows) uint function();
alias LPMAPISAVEMAIL = extern(Windows) uint function();
alias LPMAPIDELETEMAIL = extern(Windows) uint function();
alias LPMAPIFREEBUFFER = extern(Windows) uint function(void* pv);
alias LPMAPIADDRESS = extern(Windows) uint function();
alias LPMAPIDETAILS = extern(Windows) uint function();
alias LPMAPIRESOLVENAME = extern(Windows) uint function();
enum MBN_SIGNAL_CONSTANTS
{
    MBN_RSSI_DEFAULT = -1,
    MBN_RSSI_DISABLE = 0,
    MBN_RSSI_UNKNOWN = 99,
    MBN_ERROR_RATE_UNKNOWN = 99,
}

enum MBN_CELLULAR_CLASS
{
    MBN_CELLULAR_CLASS_NONE = 0,
    MBN_CELLULAR_CLASS_GSM = 1,
    MBN_CELLULAR_CLASS_CDMA = 2,
}

enum MBN_VOICE_CLASS
{
    MBN_VOICE_CLASS_NONE = 0,
    MBN_VOICE_CLASS_NO_VOICE = 1,
    MBN_VOICE_CLASS_SEPARATE_VOICE_DATA = 2,
    MBN_VOICE_CLASS_SIMULTANEOUS_VOICE_DATA = 3,
}

enum MBN_PROVIDER_STATE
{
    MBN_PROVIDER_STATE_NONE = 0,
    MBN_PROVIDER_STATE_HOME = 1,
    MBN_PROVIDER_STATE_FORBIDDEN = 2,
    MBN_PROVIDER_STATE_PREFERRED = 4,
    MBN_PROVIDER_STATE_VISIBLE = 8,
    MBN_PROVIDER_STATE_REGISTERED = 16,
    MBN_PROVIDER_STATE_PREFERRED_MULTICARRIER = 32,
}

enum MBN_PROVIDER_CONSTANTS
{
    MBN_PROVIDERNAME_LEN = 20,
    MBN_PROVIDERID_LEN = 6,
}

enum MBN_INTERFACE_CAPS_CONSTANTS
{
    MBN_DEVICEID_LEN = 18,
    MBN_MANUFACTURER_LEN = 32,
    MBN_MODEL_LEN = 32,
    MBN_FIRMWARE_LEN = 32,
}

enum MBN_DATA_CLASS
{
    MBN_DATA_CLASS_NONE = 0,
    MBN_DATA_CLASS_GPRS = 1,
    MBN_DATA_CLASS_EDGE = 2,
    MBN_DATA_CLASS_UMTS = 4,
    MBN_DATA_CLASS_HSDPA = 8,
    MBN_DATA_CLASS_HSUPA = 16,
    MBN_DATA_CLASS_LTE = 32,
    MBN_DATA_CLASS_5G_NSA = 64,
    MBN_DATA_CLASS_5G_SA = 128,
    MBN_DATA_CLASS_1XRTT = 65536,
    MBN_DATA_CLASS_1XEVDO = 131072,
    MBN_DATA_CLASS_1XEVDO_REVA = 262144,
    MBN_DATA_CLASS_1XEVDV = 524288,
    MBN_DATA_CLASS_3XRTT = 1048576,
    MBN_DATA_CLASS_1XEVDO_REVB = 2097152,
    MBN_DATA_CLASS_UMB = 4194304,
    MBN_DATA_CLASS_CUSTOM = -2147483648,
}

enum MBN_CTRL_CAPS
{
    MBN_CTRL_CAPS_NONE = 0,
    MBN_CTRL_CAPS_REG_MANUAL = 1,
    MBN_CTRL_CAPS_HW_RADIO_SWITCH = 2,
    MBN_CTRL_CAPS_CDMA_MOBILE_IP = 4,
    MBN_CTRL_CAPS_CDMA_SIMPLE_IP = 8,
    MBN_CTRL_CAPS_PROTECT_UNIQUEID = 16,
    MBN_CTRL_CAPS_MODEL_MULTI_CARRIER = 32,
    MBN_CTRL_CAPS_USSD = 64,
    MBN_CTRL_CAPS_MULTI_MODE = 128,
}

enum MBN_SMS_CAPS
{
    MBN_SMS_CAPS_NONE = 0,
    MBN_SMS_CAPS_PDU_RECEIVE = 1,
    MBN_SMS_CAPS_PDU_SEND = 2,
    MBN_SMS_CAPS_TEXT_RECEIVE = 4,
    MBN_SMS_CAPS_TEXT_SEND = 8,
}

enum MBN_BAND_CLASS
{
    MBN_BAND_CLASS_NONE = 0,
    MBN_BAND_CLASS_0 = 1,
    MBN_BAND_CLASS_I = 2,
    MBN_BAND_CLASS_II = 4,
    MBN_BAND_CLASS_III = 8,
    MBN_BAND_CLASS_IV = 16,
    MBN_BAND_CLASS_V = 32,
    MBN_BAND_CLASS_VI = 64,
    MBN_BAND_CLASS_VII = 128,
    MBN_BAND_CLASS_VIII = 256,
    MBN_BAND_CLASS_IX = 512,
    MBN_BAND_CLASS_X = 1024,
    MBN_BAND_CLASS_XI = 2048,
    MBN_BAND_CLASS_XII = 4096,
    MBN_BAND_CLASS_XIII = 8192,
    MBN_BAND_CLASS_XIV = 16384,
    MBN_BAND_CLASS_XV = 32768,
    MBN_BAND_CLASS_XVI = 65536,
    MBN_BAND_CLASS_XVII = 131072,
    MBN_BAND_CLASS_CUSTOM = -2147483648,
}

struct MBN_INTERFACE_CAPS
{
    MBN_CELLULAR_CLASS cellularClass;
    MBN_VOICE_CLASS voiceClass;
    uint dataClass;
    BSTR customDataClass;
    uint gsmBandClass;
    uint cdmaBandClass;
    BSTR customBandClass;
    uint smsCaps;
    uint controlCaps;
    BSTR deviceID;
    BSTR manufacturer;
    BSTR model;
    BSTR firmwareInfo;
}

struct MBN_PROVIDER
{
    BSTR providerID;
    uint providerState;
    BSTR providerName;
    uint dataClass;
}

struct MBN_PROVIDER2
{
    MBN_PROVIDER provider;
    MBN_CELLULAR_CLASS cellularClass;
    uint signalStrength;
    uint signalError;
}

enum MBN_READY_STATE
{
    MBN_READY_STATE_OFF = 0,
    MBN_READY_STATE_INITIALIZED = 1,
    MBN_READY_STATE_SIM_NOT_INSERTED = 2,
    MBN_READY_STATE_BAD_SIM = 3,
    MBN_READY_STATE_FAILURE = 4,
    MBN_READY_STATE_NOT_ACTIVATED = 5,
    MBN_READY_STATE_DEVICE_LOCKED = 6,
    MBN_READY_STATE_DEVICE_BLOCKED = 7,
    MBN_READY_STATE_NO_ESIM_PROFILE = 8,
}

enum MBN_ACTIVATION_STATE
{
    MBN_ACTIVATION_STATE_NONE = 0,
    MBN_ACTIVATION_STATE_ACTIVATED = 1,
    MBN_ACTIVATION_STATE_ACTIVATING = 2,
    MBN_ACTIVATION_STATE_DEACTIVATED = 3,
    MBN_ACTIVATION_STATE_DEACTIVATING = 4,
}

enum MBN_CONNECTION_MODE
{
    MBN_CONNECTION_MODE_PROFILE = 0,
    MBN_CONNECTION_MODE_TMP_PROFILE = 1,
}

enum MBN_VOICE_CALL_STATE
{
    MBN_VOICE_CALL_STATE_NONE = 0,
    MBN_VOICE_CALL_STATE_IN_PROGRESS = 1,
    MBN_VOICE_CALL_STATE_HANGUP = 2,
}

enum MBN_REGISTRATION_CONSTANTS
{
    MBN_ROAMTEXT_LEN = 64,
    MBN_CDMA_DEFAULT_PROVIDER_ID = 0,
}

enum MBN_REGISTER_STATE
{
    MBN_REGISTER_STATE_NONE = 0,
    MBN_REGISTER_STATE_DEREGISTERED = 1,
    MBN_REGISTER_STATE_SEARCHING = 2,
    MBN_REGISTER_STATE_HOME = 3,
    MBN_REGISTER_STATE_ROAMING = 4,
    MBN_REGISTER_STATE_PARTNER = 5,
    MBN_REGISTER_STATE_DENIED = 6,
}

enum MBN_REGISTER_MODE
{
    MBN_REGISTER_MODE_NONE = 0,
    MBN_REGISTER_MODE_AUTOMATIC = 1,
    MBN_REGISTER_MODE_MANUAL = 2,
}

enum MBN_PIN_CONSTANTS
{
    MBN_ATTEMPTS_REMAINING_UNKNOWN = -1,
    MBN_PIN_LENGTH_UNKNOWN = -1,
}

enum MBN_PIN_STATE
{
    MBN_PIN_STATE_NONE = 0,
    MBN_PIN_STATE_ENTER = 1,
    MBN_PIN_STATE_UNBLOCK = 2,
}

enum MBN_PIN_TYPE
{
    MBN_PIN_TYPE_NONE = 0,
    MBN_PIN_TYPE_CUSTOM = 1,
    MBN_PIN_TYPE_PIN1 = 2,
    MBN_PIN_TYPE_PIN2 = 3,
    MBN_PIN_TYPE_DEVICE_SIM_PIN = 4,
    MBN_PIN_TYPE_DEVICE_FIRST_SIM_PIN = 5,
    MBN_PIN_TYPE_NETWORK_PIN = 6,
    MBN_PIN_TYPE_NETWORK_SUBSET_PIN = 7,
    MBN_PIN_TYPE_SVC_PROVIDER_PIN = 8,
    MBN_PIN_TYPE_CORPORATE_PIN = 9,
    MBN_PIN_TYPE_SUBSIDY_LOCK = 10,
}

struct MBN_PIN_INFO
{
    MBN_PIN_STATE pinState;
    MBN_PIN_TYPE pinType;
    uint attemptsRemaining;
}

enum MBN_PIN_MODE
{
    MBN_PIN_MODE_ENABLED = 1,
    MBN_PIN_MODE_DISABLED = 2,
}

enum MBN_PIN_FORMAT
{
    MBN_PIN_FORMAT_NONE = 0,
    MBN_PIN_FORMAT_NUMERIC = 1,
    MBN_PIN_FORMAT_ALPHANUMERIC = 2,
}

enum MBN_CONTEXT_CONSTANTS
{
    MBN_ACCESSSTRING_LEN = 100,
    MBN_USERNAME_LEN = 255,
    MBN_PASSWORD_LEN = 255,
    MBN_CONTEXT_ID_APPEND = -1,
}

enum MBN_AUTH_PROTOCOL
{
    MBN_AUTH_PROTOCOL_NONE = 0,
    MBN_AUTH_PROTOCOL_PAP = 1,
    MBN_AUTH_PROTOCOL_CHAP = 2,
    MBN_AUTH_PROTOCOL_MSCHAPV2 = 3,
}

enum MBN_COMPRESSION
{
    MBN_COMPRESSION_NONE = 0,
    MBN_COMPRESSION_ENABLE = 1,
}

enum MBN_CONTEXT_TYPE
{
    MBN_CONTEXT_TYPE_NONE = 0,
    MBN_CONTEXT_TYPE_INTERNET = 1,
    MBN_CONTEXT_TYPE_VPN = 2,
    MBN_CONTEXT_TYPE_VOICE = 3,
    MBN_CONTEXT_TYPE_VIDEO_SHARE = 4,
    MBN_CONTEXT_TYPE_CUSTOM = 5,
    MBN_CONTEXT_TYPE_PURCHASE = 6,
}

struct MBN_CONTEXT
{
    uint contextID;
    MBN_CONTEXT_TYPE contextType;
    BSTR accessString;
    BSTR userName;
    BSTR password;
    MBN_COMPRESSION compression;
    MBN_AUTH_PROTOCOL authType;
}

enum WWAEXT_SMS_CONSTANTS
{
    MBN_MESSAGE_INDEX_NONE = 0,
    MBN_CDMA_SHORT_MSG_SIZE_UNKNOWN = 0,
    MBN_CDMA_SHORT_MSG_SIZE_MAX = 160,
}

enum MBN_MSG_STATUS
{
    MBN_MSG_STATUS_NEW = 0,
    MBN_MSG_STATUS_OLD = 1,
    MBN_MSG_STATUS_DRAFT = 2,
    MBN_MSG_STATUS_SENT = 3,
}

enum MBN_SMS_CDMA_LANG
{
    MBN_SMS_CDMA_LANG_NONE = 0,
    MBN_SMS_CDMA_LANG_ENGLISH = 1,
    MBN_SMS_CDMA_LANG_FRENCH = 2,
    MBN_SMS_CDMA_LANG_SPANISH = 3,
    MBN_SMS_CDMA_LANG_JAPANESE = 4,
    MBN_SMS_CDMA_LANG_KOREAN = 5,
    MBN_SMS_CDMA_LANG_CHINESE = 6,
    MBN_SMS_CDMA_LANG_HEBREW = 7,
}

enum MBN_SMS_CDMA_ENCODING
{
    MBN_SMS_CDMA_ENCODING_OCTET = 0,
    MBN_SMS_CDMA_ENCODING_EPM = 1,
    MBN_SMS_CDMA_ENCODING_7BIT_ASCII = 2,
    MBN_SMS_CDMA_ENCODING_IA5 = 3,
    MBN_SMS_CDMA_ENCODING_UNICODE = 4,
    MBN_SMS_CDMA_ENCODING_SHIFT_JIS = 5,
    MBN_SMS_CDMA_ENCODING_KOREAN = 6,
    MBN_SMS_CDMA_ENCODING_LATIN_HEBREW = 7,
    MBN_SMS_CDMA_ENCODING_LATIN = 8,
    MBN_SMS_CDMA_ENCODING_GSM_7BIT = 9,
}

enum MBN_SMS_FLAG
{
    MBN_SMS_FLAG_ALL = 0,
    MBN_SMS_FLAG_INDEX = 1,
    MBN_SMS_FLAG_NEW = 2,
    MBN_SMS_FLAG_OLD = 3,
    MBN_SMS_FLAG_SENT = 4,
    MBN_SMS_FLAG_DRAFT = 5,
}

struct MBN_SMS_FILTER
{
    MBN_SMS_FLAG flag;
    uint messageIndex;
}

enum MBN_SMS_STATUS_FLAG
{
    MBN_SMS_FLAG_NONE = 0,
    MBN_SMS_FLAG_MESSAGE_STORE_FULL = 1,
    MBN_SMS_FLAG_NEW_MESSAGE = 2,
}

struct MBN_SMS_STATUS_INFO
{
    uint flag;
    uint messageIndex;
}

enum MBN_SMS_FORMAT
{
    MBN_SMS_FORMAT_NONE = 0,
    MBN_SMS_FORMAT_PDU = 1,
    MBN_SMS_FORMAT_TEXT = 2,
}

enum MBN_RADIO
{
    MBN_RADIO_OFF = 0,
    MBN_RADIO_ON = 1,
}

struct MBN_DEVICE_SERVICE
{
    BSTR deviceServiceID;
    short dataWriteSupported;
    short dataReadSupported;
}

enum MBN_DEVICE_SERVICES_INTERFACE_STATE
{
    MBN_DEVICE_SERVICES_CAPABLE_INTERFACE_ARRIVAL = 0,
    MBN_DEVICE_SERVICES_CAPABLE_INTERFACE_REMOVAL = 1,
}

const GUID IID_IMbnConnection = {0xDCBBBAB6, 0x200D, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x200D, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnConnection : IUnknown
{
    HRESULT get_ConnectionID(BSTR* ConnectionID);
    HRESULT get_InterfaceID(BSTR* InterfaceID);
    HRESULT Connect(MBN_CONNECTION_MODE connectionMode, const(wchar)* strProfile, uint* requestID);
    HRESULT Disconnect(uint* requestID);
    HRESULT GetConnectionState(MBN_ACTIVATION_STATE* ConnectionState, BSTR* ProfileName);
    HRESULT GetVoiceCallState(MBN_VOICE_CALL_STATE* voiceCallState);
    HRESULT GetActivationNetworkError(uint* networkError);
}

const GUID IID_IMbnConnectionEvents = {0xDCBBBAB6, 0x200E, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x200E, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnConnectionEvents : IUnknown
{
    HRESULT OnConnectComplete(IMbnConnection newConnection, uint requestID, HRESULT status);
    HRESULT OnDisconnectComplete(IMbnConnection newConnection, uint requestID, HRESULT status);
    HRESULT OnConnectStateChange(IMbnConnection newConnection);
    HRESULT OnVoiceCallStateChange(IMbnConnection newConnection);
}

const GUID IID_IMbnInterface = {0xDCBBBAB6, 0x2001, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2001, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnInterface : IUnknown
{
    HRESULT get_InterfaceID(BSTR* InterfaceID);
    HRESULT GetInterfaceCapability(MBN_INTERFACE_CAPS* interfaceCaps);
    HRESULT GetSubscriberInformation(IMbnSubscriberInformation* subscriberInformation);
    HRESULT GetReadyState(MBN_READY_STATE* readyState);
    HRESULT InEmergencyMode(short* emergencyMode);
    HRESULT GetHomeProvider(MBN_PROVIDER* homeProvider);
    HRESULT GetPreferredProviders(SAFEARRAY** preferredProviders);
    HRESULT SetPreferredProviders(SAFEARRAY* preferredProviders, uint* requestID);
    HRESULT GetVisibleProviders(uint* age, SAFEARRAY** visibleProviders);
    HRESULT ScanNetwork(uint* requestID);
    HRESULT GetConnection(IMbnConnection* mbnConnection);
}

const GUID IID_IMbnInterfaceEvents = {0xDCBBBAB6, 0x2002, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2002, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnInterfaceEvents : IUnknown
{
    HRESULT OnInterfaceCapabilityAvailable(IMbnInterface newInterface);
    HRESULT OnSubscriberInformationChange(IMbnInterface newInterface);
    HRESULT OnReadyStateChange(IMbnInterface newInterface);
    HRESULT OnEmergencyModeChange(IMbnInterface newInterface);
    HRESULT OnHomeProviderAvailable(IMbnInterface newInterface);
    HRESULT OnPreferredProvidersChange(IMbnInterface newInterface);
    HRESULT OnSetPreferredProvidersComplete(IMbnInterface newInterface, uint requestID, HRESULT status);
    HRESULT OnScanNetworkComplete(IMbnInterface newInterface, uint requestID, HRESULT status);
}

const GUID IID_IMbnInterfaceManager = {0xDCBBBAB6, 0x201B, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x201B, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnInterfaceManager : IUnknown
{
    HRESULT GetInterface(const(wchar)* interfaceID, IMbnInterface* mbnInterface);
    HRESULT GetInterfaces(SAFEARRAY** mbnInterfaces);
}

const GUID IID_IMbnInterfaceManagerEvents = {0xDCBBBAB6, 0x201C, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x201C, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnInterfaceManagerEvents : IUnknown
{
    HRESULT OnInterfaceArrival(IMbnInterface newInterface);
    HRESULT OnInterfaceRemoval(IMbnInterface oldInterface);
}

const GUID IID_IMbnRegistration = {0xDCBBBAB6, 0x2009, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2009, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnRegistration : IUnknown
{
    HRESULT GetRegisterState(MBN_REGISTER_STATE* registerState);
    HRESULT GetRegisterMode(MBN_REGISTER_MODE* registerMode);
    HRESULT GetProviderID(BSTR* providerID);
    HRESULT GetProviderName(BSTR* providerName);
    HRESULT GetRoamingText(BSTR* roamingText);
    HRESULT GetAvailableDataClasses(uint* availableDataClasses);
    HRESULT GetCurrentDataClass(uint* currentDataClass);
    HRESULT GetRegistrationNetworkError(uint* registrationNetworkError);
    HRESULT GetPacketAttachNetworkError(uint* packetAttachNetworkError);
    HRESULT SetRegisterMode(MBN_REGISTER_MODE registerMode, const(wchar)* providerID, uint dataClass, uint* requestID);
}

const GUID IID_IMbnRegistrationEvents = {0xDCBBBAB6, 0x200A, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x200A, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnRegistrationEvents : IUnknown
{
    HRESULT OnRegisterModeAvailable(IMbnRegistration newInterface);
    HRESULT OnRegisterStateChange(IMbnRegistration newInterface);
    HRESULT OnPacketServiceStateChange(IMbnRegistration newInterface);
    HRESULT OnSetRegisterModeComplete(IMbnRegistration newInterface, uint requestID, HRESULT status);
}

const GUID IID_IMbnConnectionManager = {0xDCBBBAB6, 0x201D, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x201D, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnConnectionManager : IUnknown
{
    HRESULT GetConnection(const(wchar)* connectionID, IMbnConnection* mbnConnection);
    HRESULT GetConnections(SAFEARRAY** mbnConnections);
}

const GUID IID_IMbnConnectionManagerEvents = {0xDCBBBAB6, 0x201E, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x201E, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnConnectionManagerEvents : IUnknown
{
    HRESULT OnConnectionArrival(IMbnConnection newConnection);
    HRESULT OnConnectionRemoval(IMbnConnection oldConnection);
}

const GUID IID_IMbnPinManager = {0xDCBBBAB6, 0x2005, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2005, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnPinManager : IUnknown
{
    HRESULT GetPinList(SAFEARRAY** pinList);
    HRESULT GetPin(MBN_PIN_TYPE pinType, IMbnPin* pin);
    HRESULT GetPinState(uint* requestID);
}

const GUID IID_IMbnPinManagerEvents = {0xDCBBBAB6, 0x2006, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2006, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnPinManagerEvents : IUnknown
{
    HRESULT OnPinListAvailable(IMbnPinManager pinManager);
    HRESULT OnGetPinStateComplete(IMbnPinManager pinManager, MBN_PIN_INFO pinInfo, uint requestID, HRESULT status);
}

const GUID IID_IMbnPinEvents = {0xDCBBBAB6, 0x2008, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2008, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnPinEvents : IUnknown
{
    HRESULT OnEnableComplete(IMbnPin pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    HRESULT OnDisableComplete(IMbnPin pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    HRESULT OnEnterComplete(IMbnPin Pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    HRESULT OnChangeComplete(IMbnPin Pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    HRESULT OnUnblockComplete(IMbnPin Pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
}

const GUID IID_IMbnSubscriberInformation = {0x459ECC43, 0xBCF5, 0x11DC, [0xA8, 0xA8, 0x00, 0x13, 0x21, 0xF1, 0x40, 0x5F]};
@GUID(0x459ECC43, 0xBCF5, 0x11DC, [0xA8, 0xA8, 0x00, 0x13, 0x21, 0xF1, 0x40, 0x5F]);
interface IMbnSubscriberInformation : IUnknown
{
    HRESULT get_SubscriberID(BSTR* SubscriberID);
    HRESULT get_SimIccID(BSTR* SimIccID);
    HRESULT get_TelephoneNumbers(SAFEARRAY** TelephoneNumbers);
}

const GUID IID_IMbnSignal = {0xDCBBBAB6, 0x2003, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2003, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnSignal : IUnknown
{
    HRESULT GetSignalStrength(uint* signalStrength);
    HRESULT GetSignalError(uint* signalError);
}

const GUID IID_IMbnSignalEvents = {0xDCBBBAB6, 0x2004, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2004, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnSignalEvents : IUnknown
{
    HRESULT OnSignalStateChange(IMbnSignal newInterface);
}

const GUID IID_IMbnConnectionContext = {0xDCBBBAB6, 0x200B, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x200B, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnConnectionContext : IUnknown
{
    HRESULT GetProvisionedContexts(SAFEARRAY** provisionedContexts);
    HRESULT SetProvisionedContext(MBN_CONTEXT provisionedContexts, const(wchar)* providerID, uint* requestID);
}

const GUID IID_IMbnConnectionContextEvents = {0xDCBBBAB6, 0x200C, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x200C, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnConnectionContextEvents : IUnknown
{
    HRESULT OnProvisionedContextListChange(IMbnConnectionContext newInterface);
    HRESULT OnSetProvisionedContextComplete(IMbnConnectionContext newInterface, uint requestID, HRESULT status);
}

const GUID IID_IMbnConnectionProfileManager = {0xDCBBBAB6, 0x200F, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x200F, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnConnectionProfileManager : IUnknown
{
    HRESULT GetConnectionProfiles(IMbnInterface mbnInterface, SAFEARRAY** connectionProfiles);
    HRESULT GetConnectionProfile(IMbnInterface mbnInterface, const(wchar)* profileName, IMbnConnectionProfile* connectionProfile);
    HRESULT CreateConnectionProfile(const(wchar)* xmlProfile);
}

const GUID IID_IMbnConnectionProfile = {0xDCBBBAB6, 0x2010, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2010, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnConnectionProfile : IUnknown
{
    HRESULT GetProfileXmlData(BSTR* profileData);
    HRESULT UpdateProfile(const(wchar)* strProfile);
    HRESULT Delete();
}

const GUID IID_IMbnConnectionProfileEvents = {0xDCBBBAB6, 0x2011, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2011, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnConnectionProfileEvents : IUnknown
{
    HRESULT OnProfileUpdate(IMbnConnectionProfile newProfile);
}

const GUID IID_IMbnSmsConfiguration = {0xDCBBBAB6, 0x2012, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2012, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnSmsConfiguration : IUnknown
{
    HRESULT get_ServiceCenterAddress(BSTR* scAddress);
    HRESULT put_ServiceCenterAddress(const(wchar)* scAddress);
    HRESULT get_MaxMessageIndex(uint* index);
    HRESULT get_CdmaShortMsgSize(uint* shortMsgSize);
    HRESULT get_SmsFormat(MBN_SMS_FORMAT* smsFormat);
    HRESULT put_SmsFormat(MBN_SMS_FORMAT smsFormat);
}

const GUID IID_IMbnSmsReadMsgPdu = {0xDCBBBAB6, 0x2013, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2013, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnSmsReadMsgPdu : IUnknown
{
    HRESULT get_Index(uint* Index);
    HRESULT get_Status(MBN_MSG_STATUS* Status);
    HRESULT get_PduData(BSTR* PduData);
    HRESULT get_Message(SAFEARRAY** Message);
}

const GUID IID_IMbnSmsReadMsgTextCdma = {0xDCBBBAB6, 0x2014, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2014, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnSmsReadMsgTextCdma : IUnknown
{
    HRESULT get_Index(uint* Index);
    HRESULT get_Status(MBN_MSG_STATUS* Status);
    HRESULT get_Address(BSTR* Address);
    HRESULT get_Timestamp(BSTR* Timestamp);
    HRESULT get_EncodingID(MBN_SMS_CDMA_ENCODING* EncodingID);
    HRESULT get_LanguageID(MBN_SMS_CDMA_LANG* LanguageID);
    HRESULT get_SizeInCharacters(uint* SizeInCharacters);
    HRESULT get_Message(SAFEARRAY** Message);
}

const GUID IID_IMbnSms = {0xDCBBBAB6, 0x2015, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2015, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnSms : IUnknown
{
    HRESULT GetSmsConfiguration(IMbnSmsConfiguration* smsConfiguration);
    HRESULT SetSmsConfiguration(IMbnSmsConfiguration smsConfiguration, uint* requestID);
    HRESULT SmsSendPdu(const(wchar)* pduData, ubyte size, uint* requestID);
    HRESULT SmsSendCdma(const(wchar)* address, MBN_SMS_CDMA_ENCODING encoding, MBN_SMS_CDMA_LANG language, uint sizeInCharacters, SAFEARRAY* message, uint* requestID);
    HRESULT SmsSendCdmaPdu(SAFEARRAY* message, uint* requestID);
    HRESULT SmsRead(MBN_SMS_FILTER* smsFilter, MBN_SMS_FORMAT smsFormat, uint* requestID);
    HRESULT SmsDelete(MBN_SMS_FILTER* smsFilter, uint* requestID);
    HRESULT GetSmsStatus(MBN_SMS_STATUS_INFO* smsStatusInfo);
}

const GUID IID_IMbnSmsEvents = {0xDCBBBAB6, 0x2016, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2016, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnSmsEvents : IUnknown
{
    HRESULT OnSmsConfigurationChange(IMbnSms sms);
    HRESULT OnSetSmsConfigurationComplete(IMbnSms sms, uint requestID, HRESULT status);
    HRESULT OnSmsSendComplete(IMbnSms sms, uint requestID, HRESULT status);
    HRESULT OnSmsReadComplete(IMbnSms sms, MBN_SMS_FORMAT smsFormat, SAFEARRAY* readMsgs, short moreMsgs, uint requestID, HRESULT status);
    HRESULT OnSmsNewClass0Message(IMbnSms sms, MBN_SMS_FORMAT smsFormat, SAFEARRAY* readMsgs);
    HRESULT OnSmsDeleteComplete(IMbnSms sms, uint requestID, HRESULT status);
    HRESULT OnSmsStatusChange(IMbnSms sms);
}

const GUID IID_IMbnServiceActivation = {0xDCBBBAB6, 0x2017, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2017, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnServiceActivation : IUnknown
{
    HRESULT Activate(SAFEARRAY* vendorSpecificData, uint* requestID);
}

const GUID IID_IMbnServiceActivationEvents = {0xDCBBBAB6, 0x2018, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2018, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnServiceActivationEvents : IUnknown
{
    HRESULT OnActivationComplete(IMbnServiceActivation serviceActivation, SAFEARRAY* vendorSpecificData, uint requestID, HRESULT status, uint networkError);
}

const GUID IID_IMbnVendorSpecificOperation = {0xDCBBBAB6, 0x2019, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2019, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnVendorSpecificOperation : IUnknown
{
    HRESULT SetVendorSpecific(SAFEARRAY* vendorSpecificData, uint* requestID);
}

const GUID IID_IMbnVendorSpecificEvents = {0xDCBBBAB6, 0x201A, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x201A, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnVendorSpecificEvents : IUnknown
{
    HRESULT OnEventNotification(IMbnVendorSpecificOperation vendorOperation, SAFEARRAY* vendorSpecificData);
    HRESULT OnSetVendorSpecificComplete(IMbnVendorSpecificOperation vendorOperation, SAFEARRAY* vendorSpecificData, uint requestID);
}

const GUID IID_IMbnConnectionProfileManagerEvents = {0xDCBBBAB6, 0x201F, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x201F, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnConnectionProfileManagerEvents : IUnknown
{
    HRESULT OnConnectionProfileArrival(IMbnConnectionProfile newConnectionProfile);
    HRESULT OnConnectionProfileRemoval(IMbnConnectionProfile oldConnectionProfile);
}

const GUID IID_IMbnRadio = {0xDCCCCAB6, 0x201F, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCCCCAB6, 0x201F, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnRadio : IUnknown
{
    HRESULT get_SoftwareRadioState(MBN_RADIO* SoftwareRadioState);
    HRESULT get_HardwareRadioState(MBN_RADIO* HardwareRadioState);
    HRESULT SetSoftwareRadioState(MBN_RADIO radioState, uint* requestID);
}

const GUID IID_IMbnRadioEvents = {0xDCDDDAB6, 0x201F, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCDDDAB6, 0x201F, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnRadioEvents : IUnknown
{
    HRESULT OnRadioStateChange(IMbnRadio newInterface);
    HRESULT OnSetSoftwareRadioStateComplete(IMbnRadio newInterface, uint requestID, HRESULT status);
}

const GUID IID_IMbnMultiCarrier = {0xDCBBBAB6, 0x2020, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2020, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnMultiCarrier : IUnknown
{
    HRESULT SetHomeProvider(MBN_PROVIDER2* homeProvider, uint* requestID);
    HRESULT GetPreferredProviders(SAFEARRAY** preferredMulticarrierProviders);
    HRESULT GetVisibleProviders(uint* age, SAFEARRAY** visibleProviders);
    HRESULT GetSupportedCellularClasses(SAFEARRAY** cellularClasses);
    HRESULT GetCurrentCellularClass(MBN_CELLULAR_CLASS* currentCellularClass);
    HRESULT ScanNetwork(uint* requestID);
}

const GUID IID_IMbnMultiCarrierEvents = {0xDCDDDAB6, 0x2021, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCDDDAB6, 0x2021, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnMultiCarrierEvents : IUnknown
{
    HRESULT OnSetHomeProviderComplete(IMbnMultiCarrier mbnInterface, uint requestID, HRESULT status);
    HRESULT OnCurrentCellularClassChange(IMbnMultiCarrier mbnInterface);
    HRESULT OnPreferredProvidersChange(IMbnMultiCarrier mbnInterface);
    HRESULT OnScanNetworkComplete(IMbnMultiCarrier mbnInterface, uint requestID, HRESULT status);
    HRESULT OnInterfaceCapabilityChange(IMbnMultiCarrier mbnInterface);
}

const GUID IID_IMbnDeviceServicesManager = {0x20A26258, 0x6811, 0x4478, [0xAC, 0x1D, 0x13, 0x32, 0x4E, 0x45, 0xE4, 0x1C]};
@GUID(0x20A26258, 0x6811, 0x4478, [0xAC, 0x1D, 0x13, 0x32, 0x4E, 0x45, 0xE4, 0x1C]);
interface IMbnDeviceServicesManager : IUnknown
{
    HRESULT GetDeviceServicesContext(BSTR networkInterfaceID, IMbnDeviceServicesContext* mbnDevicesContext);
}

const GUID IID_IMbnDeviceServicesContext = {0xFC5AC347, 0x1592, 0x4068, [0x80, 0xBB, 0x6A, 0x57, 0x58, 0x01, 0x50, 0xD8]};
@GUID(0xFC5AC347, 0x1592, 0x4068, [0x80, 0xBB, 0x6A, 0x57, 0x58, 0x01, 0x50, 0xD8]);
interface IMbnDeviceServicesContext : IUnknown
{
    HRESULT EnumerateDeviceServices(SAFEARRAY** deviceServices);
    HRESULT GetDeviceService(BSTR deviceServiceID, IMbnDeviceService* mbnDeviceService);
    HRESULT get_MaxCommandSize(uint* maxCommandSize);
    HRESULT get_MaxDataSize(uint* maxDataSize);
}

const GUID IID_IMbnDeviceServicesEvents = {0x0A900C19, 0x6824, 0x4E97, [0xB7, 0x6E, 0xCF, 0x23, 0x9D, 0x0C, 0xA6, 0x42]};
@GUID(0x0A900C19, 0x6824, 0x4E97, [0xB7, 0x6E, 0xCF, 0x23, 0x9D, 0x0C, 0xA6, 0x42]);
interface IMbnDeviceServicesEvents : IUnknown
{
    HRESULT OnQuerySupportedCommandsComplete(IMbnDeviceService deviceService, SAFEARRAY* commandIDList, HRESULT status, uint requestID);
    HRESULT OnOpenCommandSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    HRESULT OnCloseCommandSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    HRESULT OnSetCommandComplete(IMbnDeviceService deviceService, uint responseID, SAFEARRAY* deviceServiceData, HRESULT status, uint requestID);
    HRESULT OnQueryCommandComplete(IMbnDeviceService deviceService, uint responseID, SAFEARRAY* deviceServiceData, HRESULT status, uint requestID);
    HRESULT OnEventNotification(IMbnDeviceService deviceService, uint eventID, SAFEARRAY* deviceServiceData);
    HRESULT OnOpenDataSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    HRESULT OnCloseDataSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    HRESULT OnWriteDataComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    HRESULT OnReadData(IMbnDeviceService deviceService, SAFEARRAY* deviceServiceData);
    HRESULT OnInterfaceStateChange(BSTR interfaceID, MBN_DEVICE_SERVICES_INTERFACE_STATE stateChange);
}

const GUID IID_IMbnDeviceService = {0xB3BB9A71, 0xDC70, 0x4BE9, [0xA4, 0xDA, 0x78, 0x86, 0xAE, 0x8B, 0x19, 0x1B]};
@GUID(0xB3BB9A71, 0xDC70, 0x4BE9, [0xA4, 0xDA, 0x78, 0x86, 0xAE, 0x8B, 0x19, 0x1B]);
interface IMbnDeviceService : IUnknown
{
    HRESULT QuerySupportedCommands(uint* requestID);
    HRESULT OpenCommandSession(uint* requestID);
    HRESULT CloseCommandSession(uint* requestID);
    HRESULT SetCommand(uint commandID, SAFEARRAY* deviceServiceData, uint* requestID);
    HRESULT QueryCommand(uint commandID, SAFEARRAY* deviceServiceData, uint* requestID);
    HRESULT OpenDataSession(uint* requestID);
    HRESULT CloseDataSession(uint* requestID);
    HRESULT WriteData(SAFEARRAY* deviceServiceData, uint* requestID);
    HRESULT get_InterfaceID(BSTR* InterfaceID);
    HRESULT get_DeviceServiceID(BSTR* DeviceServiceID);
    HRESULT get_IsCommandSessionOpen(int* value);
    HRESULT get_IsDataSessionOpen(int* value);
}

const GUID IID_IMbnPin = {0xDCBBBAB6, 0x2007, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]};
@GUID(0xDCBBBAB6, 0x2007, 0x4BBB, [0xAA, 0xEE, 0x33, 0x8E, 0x36, 0x8A, 0xF6, 0xFA]);
interface IMbnPin : IUnknown
{
    HRESULT get_PinType(MBN_PIN_TYPE* PinType);
    HRESULT get_PinFormat(MBN_PIN_FORMAT* PinFormat);
    HRESULT get_PinLengthMin(uint* PinLengthMin);
    HRESULT get_PinLengthMax(uint* PinLengthMax);
    HRESULT get_PinMode(MBN_PIN_MODE* PinMode);
    HRESULT Enable(const(wchar)* pin, uint* requestID);
    HRESULT Disable(const(wchar)* pin, uint* requestID);
    HRESULT Enter(const(wchar)* pin, uint* requestID);
    HRESULT Change(const(wchar)* pin, const(wchar)* newPin, uint* requestID);
    HRESULT Unblock(const(wchar)* puk, const(wchar)* newPin, uint* requestID);
    HRESULT GetPinManager(IMbnPinManager* pinManager);
}

