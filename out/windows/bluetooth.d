module windows.bluetooth;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows):


// Enums


enum NodeContainerType : int
{
    NodeContainerTypeSequence    = 0x00000000,
    NodeContainerTypeAlternative = 0x00000001,
}

enum : int
{
    SDP_TYPE_NIL         = 0x00000000,
    SDP_TYPE_UINT        = 0x00000001,
    SDP_TYPE_INT         = 0x00000002,
    SDP_TYPE_UUID        = 0x00000003,
    SDP_TYPE_STRING      = 0x00000004,
    SDP_TYPE_BOOLEAN     = 0x00000005,
    SDP_TYPE_SEQUENCE    = 0x00000006,
    SDP_TYPE_ALTERNATIVE = 0x00000007,
    SDP_TYPE_URL         = 0x00000008,
    SDP_TYPE_CONTAINER   = 0x00000020,
}
alias SDP_TYPE = int;

enum : int
{
    SDP_ST_NONE    = 0x00000000,
    SDP_ST_UINT8   = 0x00000010,
    SDP_ST_UINT16  = 0x00000110,
    SDP_ST_UINT32  = 0x00000210,
    SDP_ST_UINT64  = 0x00000310,
    SDP_ST_UINT128 = 0x00000410,
    SDP_ST_INT8    = 0x00000020,
    SDP_ST_INT16   = 0x00000120,
    SDP_ST_INT32   = 0x00000220,
    SDP_ST_INT64   = 0x00000320,
    SDP_ST_INT128  = 0x00000420,
    SDP_ST_UUID16  = 0x00000130,
    SDP_ST_UUID32  = 0x00000220,
    SDP_ST_UUID128 = 0x00000430,
}
alias SDP_SPECIFICTYPE = int;

enum : int
{
    IoCaps_DisplayOnly     = 0x00000000,
    IoCaps_DisplayYesNo    = 0x00000001,
    IoCaps_KeyboardOnly    = 0x00000002,
    IoCaps_NoInputNoOutput = 0x00000003,
    IoCaps_Undefined       = 0x000000ff,
}
alias IO_CAPABILITY = int;

enum : int
{
    MITMProtectionNotRequired               = 0x00000000,
    MITMProtectionRequired                  = 0x00000001,
    MITMProtectionNotRequiredBonding        = 0x00000002,
    MITMProtectionRequiredBonding           = 0x00000003,
    MITMProtectionNotRequiredGeneralBonding = 0x00000004,
    MITMProtectionRequiredGeneralBonding    = 0x00000005,
    MITMProtectionNotDefined                = 0x000000ff,
}
alias AUTHENTICATION_REQUIREMENTS = int;

enum : int
{
    BLUETOOTH_AUTHENTICATION_METHOD_LEGACY               = 0x00000001,
    BLUETOOTH_AUTHENTICATION_METHOD_OOB                  = 0x00000002,
    BLUETOOTH_AUTHENTICATION_METHOD_NUMERIC_COMPARISON   = 0x00000003,
    BLUETOOTH_AUTHENTICATION_METHOD_PASSKEY_NOTIFICATION = 0x00000004,
    BLUETOOTH_AUTHENTICATION_METHOD_PASSKEY              = 0x00000005,
}
alias BLUETOOTH_AUTHENTICATION_METHOD = int;

enum : int
{
    BLUETOOTH_IO_CAPABILITY_DISPLAYONLY     = 0x00000000,
    BLUETOOTH_IO_CAPABILITY_DISPLAYYESNO    = 0x00000001,
    BLUETOOTH_IO_CAPABILITY_KEYBOARDONLY    = 0x00000002,
    BLUETOOTH_IO_CAPABILITY_NOINPUTNOOUTPUT = 0x00000003,
    BLUETOOTH_IO_CAPABILITY_UNDEFINED       = 0x000000ff,
}
alias BLUETOOTH_IO_CAPABILITY = int;

enum : int
{
    BLUETOOTH_MITM_ProtectionNotRequired               = 0x00000000,
    BLUETOOTH_MITM_ProtectionRequired                  = 0x00000001,
    BLUETOOTH_MITM_ProtectionNotRequiredBonding        = 0x00000002,
    BLUETOOTH_MITM_ProtectionRequiredBonding           = 0x00000003,
    BLUETOOTH_MITM_ProtectionNotRequiredGeneralBonding = 0x00000004,
    BLUETOOTH_MITM_ProtectionRequiredGeneralBonding    = 0x00000005,
    BLUETOOTH_MITM_ProtectionNotDefined                = 0x000000ff,
}
alias BLUETOOTH_AUTHENTICATION_REQUIREMENTS = int;

// Callbacks

alias PFN_DEVICE_CALLBACK = BOOL function(void* pvParam, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pDevice);
alias PFN_AUTHENTICATION_CALLBACK = BOOL function(void* pvParam, BLUETOOTH_DEVICE_INFO_STRUCT* pDevice);
alias PFN_AUTHENTICATION_CALLBACK_EX = BOOL function(void* pvParam, 
                                                     BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS* pAuthCallbackParams);
alias PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK = BOOL function(uint uAttribId, char* pValueStream, uint cbStreamSize, 
                                                             void* pvParam);

// Structs


struct SDP_LARGE_INTEGER_16
{
    ulong LowPart;
    long  HighPart;
}

struct SDP_ULARGE_INTEGER_16
{
    ulong LowPart;
    ulong HighPart;
}

struct SdpAttributeRange
{
    ushort minAttribute;
    ushort maxAttribute;
}

union SdpQueryUuidUnion
{
    GUID   uuid128;
    uint   uuid32;
    ushort uuid16;
}

struct SdpQueryUuid
{
    SdpQueryUuidUnion u;
    ushort            uuidType;
}

struct BTH_DEVICE_INFO
{
    uint      flags;
    ulong     address;
    uint      classOfDevice;
    byte[248] name;
}

struct BTH_RADIO_IN_RANGE
{
    BTH_DEVICE_INFO deviceInfo;
    uint            previousDeviceFlags;
}

struct BTH_L2CAP_EVENT_INFO
{
    ulong  bthAddress;
    ushort psm;
    ubyte  connected;
    ubyte  initiated;
}

struct BTH_HCI_EVENT_INFO
{
    ulong bthAddress;
    ubyte connectionType;
    ubyte connected;
}

struct BLUETOOTH_ADDRESS_STRUCT
{
    union
    {
        ulong    ullLong;
        ubyte[6] rgBytes;
    }
}

struct BLUETOOTH_LOCAL_SERVICE_INFO_STRUCT
{
    BOOL        Enabled;
    BLUETOOTH_ADDRESS_STRUCT btAddr;
    ushort[256] szName;
    ushort[256] szDeviceString;
}

struct BLUETOOTH_FIND_RADIO_PARAMS
{
    uint dwSize;
}

struct BLUETOOTH_RADIO_INFO
{
    uint        dwSize;
    BLUETOOTH_ADDRESS_STRUCT address;
    ushort[248] szName;
    uint        ulClassofDevice;
    ushort      lmpSubversion;
    ushort      manufacturer;
}

struct BLUETOOTH_DEVICE_INFO_STRUCT
{
    uint        dwSize;
    BLUETOOTH_ADDRESS_STRUCT Address;
    uint        ulClassofDevice;
    BOOL        fConnected;
    BOOL        fRemembered;
    BOOL        fAuthenticated;
    SYSTEMTIME  stLastSeen;
    SYSTEMTIME  stLastUsed;
    ushort[248] szName;
}

struct BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS
{
    BLUETOOTH_DEVICE_INFO_STRUCT deviceInfo;
    BLUETOOTH_AUTHENTICATION_METHOD authenticationMethod;
    BLUETOOTH_IO_CAPABILITY ioCapability;
    BLUETOOTH_AUTHENTICATION_REQUIREMENTS authenticationRequirements;
    union
    {
        uint Numeric_Value;
        uint Passkey;
    }
}

struct BLUETOOTH_DEVICE_SEARCH_PARAMS
{
    uint   dwSize;
    BOOL   fReturnAuthenticated;
    BOOL   fReturnRemembered;
    BOOL   fReturnUnknown;
    BOOL   fReturnConnected;
    BOOL   fIssueInquiry;
    ubyte  cTimeoutMultiplier;
    HANDLE hRadio;
}

struct BLUETOOTH_COD_PAIRS
{
    uint          ulCODMask;
    const(wchar)* pcszDescription;
}

struct BLUETOOTH_SELECT_DEVICE_PARAMS
{
    uint                 dwSize;
    uint                 cNumOfClasses;
    BLUETOOTH_COD_PAIRS* prgClassOfDevices;
    const(wchar)*        pszInfo;
    HWND                 hwndParent;
    BOOL                 fForceAuthentication;
    BOOL                 fShowAuthenticated;
    BOOL                 fShowRemembered;
    BOOL                 fShowUnknown;
    BOOL                 fAddNewDeviceWizard;
    BOOL                 fSkipServicesPage;
    PFN_DEVICE_CALLBACK  pfnDeviceCallback;
    void*                pvParam;
    uint                 cNumDevices;
    BLUETOOTH_DEVICE_INFO_STRUCT* pDevices;
}

struct BLUETOOTH_PIN_INFO
{
    ubyte[16] pin;
    ubyte     pinLength;
}

struct BLUETOOTH_OOB_DATA_INFO
{
    ubyte[16] C;
    ubyte[16] R;
}

struct BLUETOOTH_NUMERIC_COMPARISON_INFO
{
    uint NumericValue;
}

struct BLUETOOTH_PASSKEY_INFO
{
    uint passkey;
}

struct BLUETOOTH_AUTHENTICATE_RESPONSE
{
    BLUETOOTH_ADDRESS_STRUCT bthAddressRemote;
    BLUETOOTH_AUTHENTICATION_METHOD authMethod;
    union
    {
        BLUETOOTH_PIN_INFO pinInfo;
        BLUETOOTH_OOB_DATA_INFO oobInfo;
        BLUETOOTH_NUMERIC_COMPARISON_INFO numericCompInfo;
        BLUETOOTH_PASSKEY_INFO passkeyInfo;
    }
    ubyte negativeResponse;
}

struct SDP_ELEMENT_DATA
{
    SDP_TYPE         type;
    SDP_SPECIFICTYPE specificType;
    union data
    {
        SDP_LARGE_INTEGER_16 int128;
        long                 int64;
        int                  int32;
        short                int16;
        byte                 int8;
        SDP_ULARGE_INTEGER_16 uint128;
        ulong                uint64;
        uint                 uint32;
        ushort               uint16;
        ubyte                uint8;
        ubyte                booleanVal;
        GUID                 uuid128;
        uint                 uuid32;
        ushort               uuid16;
        struct string
        {
            ubyte* value;
            uint   length;
        }
        struct url
        {
            ubyte* value;
            uint   length;
        }
        struct sequence
        {
            ubyte* value;
            uint   length;
        }
        struct alternative
        {
            ubyte* value;
            uint   length;
        }
    }
}

struct SDP_STRING_TYPE_DATA
{
    ushort encoding;
    ushort mibeNum;
    ushort attributeId;
}

struct SOCKADDR_BTH
{
align (1):
    ushort addressFamily;
    ulong  btAddr;
    GUID   serviceClassId;
    uint   port;
}

struct BTH_SET_SERVICE
{
align (1):
    uint*    pSdpVersion;
    HANDLE*  pRecordHandle;
    uint     fCodService;
    uint[5]  Reserved;
    uint     ulRecordLength;
    ubyte[1] pRecord;
}

struct BTH_QUERY_DEVICE
{
align (1):
    uint  LAP;
    ubyte length;
}

struct BTH_QUERY_SERVICE
{
align (1):
    uint                 type;
    uint                 serviceHandle;
    SdpQueryUuid[12]     uuids;
    uint                 numRange;
    SdpAttributeRange[1] pRange;
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
align (1):
    uint CmdType;
    union Data
    {
        RFCOMM_MSC_DATA MSC;
        RFCOMM_RLS_DATA RLS;
        RFCOMM_RPN_DATA RPN;
    }
}

struct BTH_PING_REQ
{
align (1):
    ulong     btAddr;
    ubyte     dataLen;
    ubyte[44] data;
}

struct BTH_PING_RSP
{
    ubyte     dataLen;
    ubyte[44] data;
}

struct BTH_INFO_REQ
{
align (1):
    ulong  btAddr;
    ushort infoType;
}

struct BTH_INFO_RSP
{
align (1):
    ushort result;
    ubyte  dataLen;
    union
    {
    align (1):
        ushort    connectionlessMTU;
        ubyte[44] data;
    }
}

// Functions

@DllImport("BluetoothApis")
ptrdiff_t BluetoothFindFirstRadio(const(BLUETOOTH_FIND_RADIO_PARAMS)* pbtfrp, HANDLE* phRadio);

@DllImport("BluetoothApis")
BOOL BluetoothFindNextRadio(ptrdiff_t hFind, HANDLE* phRadio);

@DllImport("BluetoothApis")
BOOL BluetoothFindRadioClose(ptrdiff_t hFind);

@DllImport("BluetoothApis")
uint BluetoothGetRadioInfo(HANDLE hRadio, BLUETOOTH_RADIO_INFO* pRadioInfo);

@DllImport("BluetoothApis")
ptrdiff_t BluetoothFindFirstDevice(const(BLUETOOTH_DEVICE_SEARCH_PARAMS)* pbtsp, 
                                   BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

@DllImport("BluetoothApis")
BOOL BluetoothFindNextDevice(ptrdiff_t hFind, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

@DllImport("BluetoothApis")
BOOL BluetoothFindDeviceClose(ptrdiff_t hFind);

@DllImport("BluetoothApis")
uint BluetoothGetDeviceInfo(HANDLE hRadio, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

@DllImport("BluetoothApis")
uint BluetoothUpdateDeviceRecord(const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi);

@DllImport("BluetoothApis")
uint BluetoothRemoveDevice(const(BLUETOOTH_ADDRESS_STRUCT)* pAddress);

@DllImport("bthprops")
BOOL BluetoothSelectDevices(BLUETOOTH_SELECT_DEVICE_PARAMS* pbtsdp);

@DllImport("bthprops")
BOOL BluetoothSelectDevicesFree(BLUETOOTH_SELECT_DEVICE_PARAMS* pbtsdp);

@DllImport("bthprops")
BOOL BluetoothDisplayDeviceProperties(HWND hwndParent, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

@DllImport("bthprops")
uint BluetoothAuthenticateDevice(HWND hwndParent, HANDLE hRadio, BLUETOOTH_DEVICE_INFO_STRUCT* pbtbi, 
                                 const(wchar)* pszPasskey, uint ulPasskeyLength);

@DllImport("bthprops")
uint BluetoothAuthenticateDeviceEx(HWND hwndParentIn, HANDLE hRadioIn, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdiInout, 
                                   BLUETOOTH_OOB_DATA_INFO* pbtOobData, 
                                   AUTHENTICATION_REQUIREMENTS authenticationRequirement);

@DllImport("bthprops")
uint BluetoothAuthenticateMultipleDevices(HWND hwndParent, HANDLE hRadio, uint cDevices, char* rgbtdi);

@DllImport("BluetoothApis")
uint BluetoothSetServiceState(HANDLE hRadio, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, const(GUID)* pGuidService, 
                              uint dwServiceFlags);

@DllImport("BluetoothApis")
uint BluetoothEnumerateInstalledServices(HANDLE hRadio, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, 
                                         uint* pcServiceInout, char* pGuidServices);

@DllImport("BluetoothApis")
BOOL BluetoothEnableDiscovery(HANDLE hRadio, BOOL fEnabled);

@DllImport("BluetoothApis")
BOOL BluetoothIsDiscoverable(HANDLE hRadio);

@DllImport("BluetoothApis")
BOOL BluetoothEnableIncomingConnections(HANDLE hRadio, BOOL fEnabled);

@DllImport("BluetoothApis")
BOOL BluetoothIsConnectable(HANDLE hRadio);

@DllImport("BluetoothApis")
uint BluetoothRegisterForAuthentication(const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, ptrdiff_t* phRegHandle, 
                                        PFN_AUTHENTICATION_CALLBACK pfnCallback, void* pvParam);

@DllImport("BluetoothApis")
uint BluetoothRegisterForAuthenticationEx(const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdiIn, ptrdiff_t* phRegHandleOut, 
                                          PFN_AUTHENTICATION_CALLBACK_EX pfnCallbackIn, void* pvParam);

@DllImport("BluetoothApis")
BOOL BluetoothUnregisterAuthentication(ptrdiff_t hRegHandle);

@DllImport("BluetoothApis")
uint BluetoothSendAuthenticationResponse(HANDLE hRadio, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, 
                                         const(wchar)* pszPasskey);

@DllImport("BluetoothApis")
uint BluetoothSendAuthenticationResponseEx(HANDLE hRadioIn, BLUETOOTH_AUTHENTICATE_RESPONSE* pauthResponse);

@DllImport("BluetoothApis")
uint BluetoothSdpGetElementData(char* pSdpStream, uint cbSdpStreamLength, SDP_ELEMENT_DATA* pData);

@DllImport("BluetoothApis")
uint BluetoothSdpGetContainerElementData(char* pContainerStream, uint cbContainerLength, ptrdiff_t* pElement, 
                                         SDP_ELEMENT_DATA* pData);

@DllImport("BluetoothApis")
uint BluetoothSdpGetAttributeValue(char* pRecordStream, uint cbRecordLength, ushort usAttributeId, 
                                   SDP_ELEMENT_DATA* pAttributeData);

@DllImport("BluetoothApis")
uint BluetoothSdpGetString(char* pRecordStream, uint cbRecordLength, const(SDP_STRING_TYPE_DATA)* pStringData, 
                           ushort usStringOffset, const(wchar)* pszString, uint* pcchStringLength);

@DllImport("BluetoothApis")
BOOL BluetoothSdpEnumAttributes(char* pSDPStream, uint cbStreamSize, 
                                PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK pfnCallback, void* pvParam);

@DllImport("BluetoothApis")
uint BluetoothSetLocalServiceInfo(HANDLE hRadioIn, const(GUID)* pClassGuid, uint ulInstance, 
                                  const(BLUETOOTH_LOCAL_SERVICE_INFO_STRUCT)* pServiceInfoIn);

@DllImport("BluetoothApis")
BOOL BluetoothIsVersionAvailable(ubyte MajorVersion, ubyte MinorVersion);


