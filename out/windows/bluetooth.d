module windows.bluetooth;

public import system;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct SDP_LARGE_INTEGER_16
{
    ulong LowPart;
    long HighPart;
}

struct SDP_ULARGE_INTEGER_16
{
    ulong LowPart;
    ulong HighPart;
}

enum NodeContainerType
{
    NodeContainerTypeSequence = 0,
    NodeContainerTypeAlternative = 1,
}

enum SDP_TYPE
{
    SDP_TYPE_NIL = 0,
    SDP_TYPE_UINT = 1,
    SDP_TYPE_INT = 2,
    SDP_TYPE_UUID = 3,
    SDP_TYPE_STRING = 4,
    SDP_TYPE_BOOLEAN = 5,
    SDP_TYPE_SEQUENCE = 6,
    SDP_TYPE_ALTERNATIVE = 7,
    SDP_TYPE_URL = 8,
    SDP_TYPE_CONTAINER = 32,
}

enum SDP_SPECIFICTYPE
{
    SDP_ST_NONE = 0,
    SDP_ST_UINT8 = 16,
    SDP_ST_UINT16 = 272,
    SDP_ST_UINT32 = 528,
    SDP_ST_UINT64 = 784,
    SDP_ST_UINT128 = 1040,
    SDP_ST_INT8 = 32,
    SDP_ST_INT16 = 288,
    SDP_ST_INT32 = 544,
    SDP_ST_INT64 = 800,
    SDP_ST_INT128 = 1056,
    SDP_ST_UUID16 = 304,
    SDP_ST_UUID32 = 544,
    SDP_ST_UUID128 = 1072,
}

struct SdpAttributeRange
{
    ushort minAttribute;
    ushort maxAttribute;
}

struct SdpQueryUuidUnion
{
    Guid uuid128;
    uint uuid32;
    ushort uuid16;
}

struct SdpQueryUuid
{
    SdpQueryUuidUnion u;
    ushort uuidType;
}

struct BTH_DEVICE_INFO
{
    uint flags;
    ulong address;
    uint classOfDevice;
    byte name;
}

struct BTH_RADIO_IN_RANGE
{
    BTH_DEVICE_INFO deviceInfo;
    uint previousDeviceFlags;
}

struct BTH_L2CAP_EVENT_INFO
{
    ulong bthAddress;
    ushort psm;
    ubyte connected;
    ubyte initiated;
}

struct BTH_HCI_EVENT_INFO
{
    ulong bthAddress;
    ubyte connectionType;
    ubyte connected;
}

enum IO_CAPABILITY
{
    IoCaps_DisplayOnly = 0,
    IoCaps_DisplayYesNo = 1,
    IoCaps_KeyboardOnly = 2,
    IoCaps_NoInputNoOutput = 3,
    IoCaps_Undefined = 255,
}

enum AUTHENTICATION_REQUIREMENTS
{
    MITMProtectionNotRequired = 0,
    MITMProtectionRequired = 1,
    MITMProtectionNotRequiredBonding = 2,
    MITMProtectionRequiredBonding = 3,
    MITMProtectionNotRequiredGeneralBonding = 4,
    MITMProtectionRequiredGeneralBonding = 5,
    MITMProtectionNotDefined = 255,
}

struct BLUETOOTH_ADDRESS_STRUCT
{
    _Anonymous_e__Union Anonymous;
}

struct BLUETOOTH_LOCAL_SERVICE_INFO_STRUCT
{
    BOOL Enabled;
    BLUETOOTH_ADDRESS_STRUCT btAddr;
    ushort szName;
    ushort szDeviceString;
}

struct BLUETOOTH_FIND_RADIO_PARAMS
{
    uint dwSize;
}

struct BLUETOOTH_RADIO_INFO
{
    uint dwSize;
    BLUETOOTH_ADDRESS_STRUCT address;
    ushort szName;
    uint ulClassofDevice;
    ushort lmpSubversion;
    ushort manufacturer;
}

struct BLUETOOTH_DEVICE_INFO_STRUCT
{
    uint dwSize;
    BLUETOOTH_ADDRESS_STRUCT Address;
    uint ulClassofDevice;
    BOOL fConnected;
    BOOL fRemembered;
    BOOL fAuthenticated;
    SYSTEMTIME stLastSeen;
    SYSTEMTIME stLastUsed;
    ushort szName;
}

enum BLUETOOTH_AUTHENTICATION_METHOD
{
    BLUETOOTH_AUTHENTICATION_METHOD_LEGACY = 1,
    BLUETOOTH_AUTHENTICATION_METHOD_OOB = 2,
    BLUETOOTH_AUTHENTICATION_METHOD_NUMERIC_COMPARISON = 3,
    BLUETOOTH_AUTHENTICATION_METHOD_PASSKEY_NOTIFICATION = 4,
    BLUETOOTH_AUTHENTICATION_METHOD_PASSKEY = 5,
}

enum BLUETOOTH_IO_CAPABILITY
{
    BLUETOOTH_IO_CAPABILITY_DISPLAYONLY = 0,
    BLUETOOTH_IO_CAPABILITY_DISPLAYYESNO = 1,
    BLUETOOTH_IO_CAPABILITY_KEYBOARDONLY = 2,
    BLUETOOTH_IO_CAPABILITY_NOINPUTNOOUTPUT = 3,
    BLUETOOTH_IO_CAPABILITY_UNDEFINED = 255,
}

enum BLUETOOTH_AUTHENTICATION_REQUIREMENTS
{
    BLUETOOTH_MITM_ProtectionNotRequired = 0,
    BLUETOOTH_MITM_ProtectionRequired = 1,
    BLUETOOTH_MITM_ProtectionNotRequiredBonding = 2,
    BLUETOOTH_MITM_ProtectionRequiredBonding = 3,
    BLUETOOTH_MITM_ProtectionNotRequiredGeneralBonding = 4,
    BLUETOOTH_MITM_ProtectionRequiredGeneralBonding = 5,
    BLUETOOTH_MITM_ProtectionNotDefined = 255,
}

struct BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS
{
    BLUETOOTH_DEVICE_INFO_STRUCT deviceInfo;
    BLUETOOTH_AUTHENTICATION_METHOD authenticationMethod;
    BLUETOOTH_IO_CAPABILITY ioCapability;
    BLUETOOTH_AUTHENTICATION_REQUIREMENTS authenticationRequirements;
    _Anonymous_e__Union Anonymous;
}

struct BLUETOOTH_DEVICE_SEARCH_PARAMS
{
    uint dwSize;
    BOOL fReturnAuthenticated;
    BOOL fReturnRemembered;
    BOOL fReturnUnknown;
    BOOL fReturnConnected;
    BOOL fIssueInquiry;
    ubyte cTimeoutMultiplier;
    HANDLE hRadio;
}

struct BLUETOOTH_COD_PAIRS
{
    uint ulCODMask;
    const(wchar)* pcszDescription;
}

alias PFN_DEVICE_CALLBACK = extern(Windows) BOOL function(void* pvParam, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pDevice);
struct BLUETOOTH_SELECT_DEVICE_PARAMS
{
    uint dwSize;
    uint cNumOfClasses;
    BLUETOOTH_COD_PAIRS* prgClassOfDevices;
    const(wchar)* pszInfo;
    HWND hwndParent;
    BOOL fForceAuthentication;
    BOOL fShowAuthenticated;
    BOOL fShowRemembered;
    BOOL fShowUnknown;
    BOOL fAddNewDeviceWizard;
    BOOL fSkipServicesPage;
    PFN_DEVICE_CALLBACK pfnDeviceCallback;
    void* pvParam;
    uint cNumDevices;
    BLUETOOTH_DEVICE_INFO_STRUCT* pDevices;
}

struct BLUETOOTH_PIN_INFO
{
    ubyte pin;
    ubyte pinLength;
}

struct BLUETOOTH_OOB_DATA_INFO
{
    ubyte C;
    ubyte R;
}

struct BLUETOOTH_NUMERIC_COMPARISON_INFO
{
    uint NumericValue;
}

struct BLUETOOTH_PASSKEY_INFO
{
    uint passkey;
}

alias PFN_AUTHENTICATION_CALLBACK = extern(Windows) BOOL function(void* pvParam, BLUETOOTH_DEVICE_INFO_STRUCT* pDevice);
alias PFN_AUTHENTICATION_CALLBACK_EX = extern(Windows) BOOL function(void* pvParam, BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS* pAuthCallbackParams);
struct BLUETOOTH_AUTHENTICATE_RESPONSE
{
    BLUETOOTH_ADDRESS_STRUCT bthAddressRemote;
    BLUETOOTH_AUTHENTICATION_METHOD authMethod;
    _Anonymous_e__Union Anonymous;
    ubyte negativeResponse;
}

struct SDP_ELEMENT_DATA
{
    SDP_TYPE type;
    SDP_SPECIFICTYPE specificType;
    _data_e__Union data;
}

struct SDP_STRING_TYPE_DATA
{
    ushort encoding;
    ushort mibeNum;
    ushort attributeId;
}

alias PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK = extern(Windows) BOOL function(uint uAttribId, char* pValueStream, uint cbStreamSize, void* pvParam);
struct SOCKADDR_BTH
{
    ushort addressFamily;
    ulong btAddr;
    Guid serviceClassId;
    uint port;
}

struct BTH_SET_SERVICE
{
    uint* pSdpVersion;
    HANDLE* pRecordHandle;
    uint fCodService;
    uint Reserved;
    uint ulRecordLength;
    ubyte pRecord;
}

struct BTH_QUERY_DEVICE
{
    uint LAP;
    ubyte length;
}

struct BTH_QUERY_SERVICE
{
    uint type;
    uint serviceHandle;
    SdpQueryUuid uuids;
    uint numRange;
    SdpAttributeRange pRange;
}

struct RFCOMM_MSC_DATA
{
    ubyte Signals;
    ubyte Break;
}

struct RFCOMM_RLS_DATA
{
    ubyte LineStatus;
}

struct RFCOMM_RPN_DATA
{
    ubyte Baud;
    ubyte Data;
    ubyte FlowControl;
    ubyte XonChar;
    ubyte XoffChar;
    ubyte ParameterMask1;
    ubyte ParameterMask2;
}

struct RFCOMM_COMMAND
{
    uint CmdType;
    _Data_e__Union Data;
}

struct BTH_PING_REQ
{
    ulong btAddr;
    ubyte dataLen;
    ubyte data;
}

struct BTH_PING_RSP
{
    ubyte dataLen;
    ubyte data;
}

struct BTH_INFO_REQ
{
    ulong btAddr;
    ushort infoType;
}

struct BTH_INFO_RSP
{
    ushort result;
    ubyte dataLen;
    _Anonymous_e__Union Anonymous;
}

@DllImport("BluetoothApis.dll")
int BluetoothFindFirstRadio(const(BLUETOOTH_FIND_RADIO_PARAMS)* pbtfrp, HANDLE* phRadio);

@DllImport("BluetoothApis.dll")
BOOL BluetoothFindNextRadio(int hFind, HANDLE* phRadio);

@DllImport("BluetoothApis.dll")
BOOL BluetoothFindRadioClose(int hFind);

@DllImport("BluetoothApis.dll")
uint BluetoothGetRadioInfo(HANDLE hRadio, BLUETOOTH_RADIO_INFO* pRadioInfo);

@DllImport("BluetoothApis.dll")
int BluetoothFindFirstDevice(const(BLUETOOTH_DEVICE_SEARCH_PARAMS)* pbtsp, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

@DllImport("BluetoothApis.dll")
BOOL BluetoothFindNextDevice(int hFind, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

@DllImport("BluetoothApis.dll")
BOOL BluetoothFindDeviceClose(int hFind);

@DllImport("BluetoothApis.dll")
uint BluetoothGetDeviceInfo(HANDLE hRadio, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

@DllImport("BluetoothApis.dll")
uint BluetoothUpdateDeviceRecord(const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi);

@DllImport("BluetoothApis.dll")
uint BluetoothRemoveDevice(const(BLUETOOTH_ADDRESS_STRUCT)* pAddress);

@DllImport("bthprops.dll")
BOOL BluetoothSelectDevices(BLUETOOTH_SELECT_DEVICE_PARAMS* pbtsdp);

@DllImport("bthprops.dll")
BOOL BluetoothSelectDevicesFree(BLUETOOTH_SELECT_DEVICE_PARAMS* pbtsdp);

@DllImport("bthprops.dll")
BOOL BluetoothDisplayDeviceProperties(HWND hwndParent, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

@DllImport("bthprops.dll")
uint BluetoothAuthenticateDevice(HWND hwndParent, HANDLE hRadio, BLUETOOTH_DEVICE_INFO_STRUCT* pbtbi, const(wchar)* pszPasskey, uint ulPasskeyLength);

@DllImport("bthprops.dll")
uint BluetoothAuthenticateDeviceEx(HWND hwndParentIn, HANDLE hRadioIn, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdiInout, BLUETOOTH_OOB_DATA_INFO* pbtOobData, AUTHENTICATION_REQUIREMENTS authenticationRequirement);

@DllImport("bthprops.dll")
uint BluetoothAuthenticateMultipleDevices(HWND hwndParent, HANDLE hRadio, uint cDevices, char* rgbtdi);

@DllImport("BluetoothApis.dll")
uint BluetoothSetServiceState(HANDLE hRadio, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, const(Guid)* pGuidService, uint dwServiceFlags);

@DllImport("BluetoothApis.dll")
uint BluetoothEnumerateInstalledServices(HANDLE hRadio, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, uint* pcServiceInout, char* pGuidServices);

@DllImport("BluetoothApis.dll")
BOOL BluetoothEnableDiscovery(HANDLE hRadio, BOOL fEnabled);

@DllImport("BluetoothApis.dll")
BOOL BluetoothIsDiscoverable(HANDLE hRadio);

@DllImport("BluetoothApis.dll")
BOOL BluetoothEnableIncomingConnections(HANDLE hRadio, BOOL fEnabled);

@DllImport("BluetoothApis.dll")
BOOL BluetoothIsConnectable(HANDLE hRadio);

@DllImport("BluetoothApis.dll")
uint BluetoothRegisterForAuthentication(const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, int* phRegHandle, PFN_AUTHENTICATION_CALLBACK pfnCallback, void* pvParam);

@DllImport("BluetoothApis.dll")
uint BluetoothRegisterForAuthenticationEx(const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdiIn, int* phRegHandleOut, PFN_AUTHENTICATION_CALLBACK_EX pfnCallbackIn, void* pvParam);

@DllImport("BluetoothApis.dll")
BOOL BluetoothUnregisterAuthentication(int hRegHandle);

@DllImport("BluetoothApis.dll")
uint BluetoothSendAuthenticationResponse(HANDLE hRadio, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, const(wchar)* pszPasskey);

@DllImport("BluetoothApis.dll")
uint BluetoothSendAuthenticationResponseEx(HANDLE hRadioIn, BLUETOOTH_AUTHENTICATE_RESPONSE* pauthResponse);

@DllImport("BluetoothApis.dll")
uint BluetoothSdpGetElementData(char* pSdpStream, uint cbSdpStreamLength, SDP_ELEMENT_DATA* pData);

@DllImport("BluetoothApis.dll")
uint BluetoothSdpGetContainerElementData(char* pContainerStream, uint cbContainerLength, int* pElement, SDP_ELEMENT_DATA* pData);

@DllImport("BluetoothApis.dll")
uint BluetoothSdpGetAttributeValue(char* pRecordStream, uint cbRecordLength, ushort usAttributeId, SDP_ELEMENT_DATA* pAttributeData);

@DllImport("BluetoothApis.dll")
uint BluetoothSdpGetString(char* pRecordStream, uint cbRecordLength, const(SDP_STRING_TYPE_DATA)* pStringData, ushort usStringOffset, const(wchar)* pszString, uint* pcchStringLength);

@DllImport("BluetoothApis.dll")
BOOL BluetoothSdpEnumAttributes(char* pSDPStream, uint cbStreamSize, PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK pfnCallback, void* pvParam);

@DllImport("BluetoothApis.dll")
uint BluetoothSetLocalServiceInfo(HANDLE hRadioIn, const(Guid)* pClassGuid, uint ulInstance, const(BLUETOOTH_LOCAL_SERVICE_INFO_STRUCT)* pServiceInfoIn);

@DllImport("BluetoothApis.dll")
BOOL BluetoothIsVersionAvailable(ubyte MajorVersion, ubyte MinorVersion);

