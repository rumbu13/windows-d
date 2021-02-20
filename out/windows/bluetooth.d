// Written in the D programming language.

module windows.bluetooth;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, PWSTR;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


enum NodeContainerType : int
{
    NodeContainerTypeSequence    = 0x00000000,
    NodeContainerTypeAlternative = 0x00000001,
}

alias SDP_TYPE = int;
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

alias SDP_SPECIFICTYPE = int;
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

alias IO_CAPABILITY = int;
enum : int
{
    IoCaps_DisplayOnly     = 0x00000000,
    IoCaps_DisplayYesNo    = 0x00000001,
    IoCaps_KeyboardOnly    = 0x00000002,
    IoCaps_NoInputNoOutput = 0x00000003,
    IoCaps_Undefined       = 0x000000ff,
}

alias AUTHENTICATION_REQUIREMENTS = int;
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

///The <b>BLUETOOTH_AUTHENTICATION_METHOD</b> enumeration defines the supported authentication types during device
///pairing.
alias BLUETOOTH_AUTHENTICATION_METHOD = int;
enum : int
{
    ///The Bluetooth device supports authentication via a PIN.
    BLUETOOTH_AUTHENTICATION_METHOD_LEGACY               = 0x00000001,
    ///The Bluetooth device supports authentication via out-of-band data.
    BLUETOOTH_AUTHENTICATION_METHOD_OOB                  = 0x00000002,
    ///The Bluetooth device supports authentication via numeric comparison.
    BLUETOOTH_AUTHENTICATION_METHOD_NUMERIC_COMPARISON   = 0x00000003,
    ///The Bluetooth device supports authentication via passkey notification.
    BLUETOOTH_AUTHENTICATION_METHOD_PASSKEY_NOTIFICATION = 0x00000004,
    BLUETOOTH_AUTHENTICATION_METHOD_PASSKEY              = 0x00000005,
}

///The <b>BLUETOOTH_IO_CAPABILITY</b> enumeration defines the input/output capabilities of a Bluetooth Device.
alias BLUETOOTH_IO_CAPABILITY = int;
enum : int
{
    ///The Bluetooth device is capable of output via display only.
    BLUETOOTH_IO_CAPABILITY_DISPLAYONLY     = 0x00000000,
    ///The Bluetooth device is capable of output via a display, and has the additional capability to presenting a yes/no
    ///question to the user.
    BLUETOOTH_IO_CAPABILITY_DISPLAYYESNO    = 0x00000001,
    ///The Bluetooth device is capable of input via keyboard.
    BLUETOOTH_IO_CAPABILITY_KEYBOARDONLY    = 0x00000002,
    ///The Bluetooth device is not capable of input/output.
    BLUETOOTH_IO_CAPABILITY_NOINPUTNOOUTPUT = 0x00000003,
    ///The input/output capabilities for the Bluetooth device are undefined.
    BLUETOOTH_IO_CAPABILITY_UNDEFINED       = 0x000000ff,
}

///The <b>BLUETOOTH_AUTHENTICATION_REQUIREMENTS</b> enumeration specifies the 'Man in the Middle' protection required
///for authentication. <div class="alert"><b>Note</b> This enumeration is supported in Windows Vista SP2 and Windows
///7.</div><div> </div>
alias BLUETOOTH_AUTHENTICATION_REQUIREMENTS = int;
enum : int
{
    ///Protection against a "Man in the Middle" attack is not required for authentication.
    BLUETOOTH_MITM_ProtectionNotRequired               = 0x00000000,
    ///Protection against a "Man in the Middle" attack is required for authentication.
    BLUETOOTH_MITM_ProtectionRequired                  = 0x00000001,
    ///Protection against a "Man in the Middle" attack is not required for bonding.
    BLUETOOTH_MITM_ProtectionNotRequiredBonding        = 0x00000002,
    ///Protection against a "Man in the Middle" attack is required for bonding.
    BLUETOOTH_MITM_ProtectionRequiredBonding           = 0x00000003,
    ///Protection against a "Man in the Middle" attack is not required for General Bonding.
    BLUETOOTH_MITM_ProtectionNotRequiredGeneralBonding = 0x00000004,
    ///Protection against a "Man in the Middle" attack is required for General Bonding.
    BLUETOOTH_MITM_ProtectionRequiredGeneralBonding    = 0x00000005,
    ///Protection against "Man in the Middle" attack is not defined.
    BLUETOOTH_MITM_ProtectionNotDefined                = 0x000000ff,
}

// Callbacks

///The <b>PFN_DEVICE_CALLBACK</b> function is a callback prototype used in association with selecting Bluetooth devices.
///The <b>PFN_DEVICE_CALLBACK</b> function can be set to <b>NULL</b> if no specialized filtering is required.
///Params:
///    pvParam = A parameter passed in from the <b>pvParam</b> member of the BLUETOOTH_SELECT_DEVICE_PARAMS structure through the
///              BluetoothSelectDevices function.
///    pDevice = Remote Bluetooth address queried; this is the address inserted into the user-presented list of Bluetooth devices.
///Returns:
///    Returning <b>FALSE</b> prevents the device from being added to the list view of Bluetooth devices.
///    
alias PFN_DEVICE_CALLBACK = BOOL function(void* pvParam, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pDevice);
///The <b>PFN_AUTHENTICATION_CALLBACK</b> function is a callback function prototype used in conjunction with the
///BluetoothRegisterForAuthentication function. <div class="alert"><b>Note</b> When developing for Windows Vista SP2 and
///Windows 7 the use of PFN_AUTHENTICATION_CALLBACK_EX is recommended.</div><div> </div>
///Params:
///    pvParam = Optional. A context pointer previously passed into the BluetoothRegisterForAuthentication function.
///    pDevice = A remote Bluetooth device requesting authentication. The remote address is the same address used to register the
///              callback during the previous call to the BluetoothRegisterForAuthentication function.
///Returns:
///    The return value from this function is ignored by the system.
///    
alias PFN_AUTHENTICATION_CALLBACK = BOOL function(void* pvParam, BLUETOOTH_DEVICE_INFO_STRUCT* pDevice);
///The <i>PFN_AUTHENTICATION_CALLBACK_EX</i> function is a callback function prototype used in conjunction with the
///BluetoothRegisterForAuthenticationEx function. <div class="alert"><b>Note</b> This structure is supported in Windows
///Vista SP2 and Windows 7.</div><div> </div>
///Params:
///    pvParam = Optional. A context pointer previously passed into the BluetoothRegisterForAuthentication function.
///    pAuthCallbackParams = A BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS structure that contains device and authentication configuration
///                          information specific to the Bluetooth device responding to an authentication request.
///Returns:
///    The return value from this function is ignored by the system.
///    
alias PFN_AUTHENTICATION_CALLBACK_EX = BOOL function(void* pvParam, 
                                                     BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS* pAuthCallbackParams);
///The <i>PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK</i> is a callback function prototype that is called once for each
///attribute found in the <b>pSDPStream</b> parameter passed to the BluetoothSdpEnumAttributes function call.
///Params:
///    uAttribId = The current attribute identifier in the SDP stream.
///    pValueStream = The raw SDP stream for the attribute value associated with <b>uAttribId</b>. Use the BluetoothSdpGetElementData
///                   function to parse the raw results into computer-readable data.
///    cbStreamSize = The size, in bytes, of <b>pValueStream</b>.
///    pvParam = The context passed in from a previous call to the BluetoothSdpEnumAttributes function.
///Returns:
///    Should return <b>TRUE</b> when the enumeration continues to the next attribute identifier found in the stream.
///    Should return <b>FALSE</b> when enumeration of the record attribute identifiers should immediately stop.
///    
alias PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK = BOOL function(uint uAttribId, ubyte* pValueStream, 
                                                             uint cbStreamSize, void* pvParam);

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

///The <b>SdpAttributeRange</b> structure is used in a Bluetooth query to constrain the set of attributes to return in
///the query.
struct SdpAttributeRange
{
    ///Minimum attribute value for which to search.
    ushort minAttribute;
    ///Maximum attribute value for which to search.
    ushort maxAttribute;
}

///The <b>SdpQueryUuidUnion</b> union contains the UUID on which to perform an SDP query. Used in conjunction with the
///<b>SdpQueryUuid</b> structure.
union SdpQueryUuidUnion
{
    ///UUID in 128-bit format.
    GUID   uuid128;
    ///UUID in 32-bit format.
    uint   uuid32;
    ///UUID in 16-bit format.
    ushort uuid16;
}

///The <b>SdpQueryUuid</b> structure facilitates searching for UUIDs.
struct SdpQueryUuid
{
    ///Union containing the UUID on which to search.
    SdpQueryUuidUnion u;
    ///Type of UUID being searched. Must be one of the three valid values from the SDP_SPECIFICTYPE enumeration: <ul>
    ///<li>SDP_ST_UUID16 - indicates u.uuid16 will be used in the search.</li> <li>SDP_ST_UUID32 - indicates u.uuid32
    ///will be used in the search.</li> <li>SDP_ST_UUID128 - indicates u.uuid128 will be used in the search.</li> </ul>
    ushort            uuidType;
}

///The <b>BTH_DEVICE_INFO</b> structure stores information about a Bluetooth device.
struct BTH_DEVICE_INFO
{
    ///A combination of one or more of the flags listed in the following table. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="BDIF_ADDRESS"></a><a id="bdif_address"></a><dl>
    ///<dt><b>BDIF_ADDRESS</b></dt> </dl> </td> <td width="60%"> The <b>address</b> member contains valid data. </td>
    ///</tr> <tr> <td width="40%"><a id="BDIF_COD"></a><a id="bdif_cod"></a><dl> <dt><b>BDIF_COD</b></dt> </dl> </td>
    ///<td width="60%"> The <b>classOfDevice</b> member contains valid data. </td> </tr> <tr> <td width="40%"><a
    ///id="BDIF_NAME"></a><a id="bdif_name"></a><dl> <dt><b>BDIF_NAME</b></dt> </dl> </td> <td width="60%"> The
    ///<b>name</b> member contains valid data. </td> </tr> <tr> <td width="40%"><a id="BDIF_PAIRED"></a><a
    ///id="bdif_paired"></a><dl> <dt><b>BDIF_PAIRED</b></dt> </dl> </td> <td width="60%"> The device is a remembered and
    ///authenticated device. The <b>BDIF_PERSONAL</b> flag is always set when this flag is set. </td> </tr> <tr> <td
    ///width="40%"><a id="BDIF_PERSONAL"></a><a id="bdif_personal"></a><dl> <dt><b>BDIF_PERSONAL</b></dt> </dl> </td>
    ///<td width="60%"> The device is a remembered device. If this flag is set and the <b>BDIF_PAIRED</b> flag is not
    ///set, the device is not authenticated. </td> </tr> <tr> <td width="40%"><a id="BDIF_CONNECTED"></a><a
    ///id="bdif_connected"></a><dl> <dt><b>BDIF_CONNECTED</b></dt> </dl> </td> <td width="60%"> The remote Bluetooth
    ///device is currently connected to the local radio. </td> </tr> <tr> <td width="40%"><a
    ///id="BDIF_SSP_SUPPORTED"></a><a id="bdif_ssp_supported"></a><dl> <dt><b>BDIF_SSP_SUPPORTED</b></dt> </dl> </td>
    ///<td width="60%"> The device supports the use of Secure Simple Pairing (SSP). </td> </tr> <tr> <td width="40%"><a
    ///id="BDIF_SSP_PAIRED"></a><a id="bdif_ssp_paired"></a><dl> <dt><b>BDIF_SSP_PAIRED</b></dt> </dl> </td> <td
    ///width="60%"> The device is remembered and is authenticated using Secure Simple Pairing (SSP). </td> </tr> <tr>
    ///<td width="40%"><a id="BDIF_SSP_MITM_PROTECTED"></a><a id="bdif_ssp_mitm_protected"></a><dl>
    ///<dt><b>BDIF_SSP_MITM_PROTECTED</b></dt> </dl> </td> <td width="60%"> The device supports the use of Secure Simple
    ///Pairing (SSP) to protect against "Man in the Middle" attacks. </td> </tr> </table>
    uint      flags;
    ///Address of the remote Bluetooth device.
    ulong     address;
    ///Bit field that describes the device class of device (COD) of the remote device. The COD consists of the following
    ///four fields: Format: retrieved using GET_COD_FORMAT(<b>classOfDevice</b>). The only format currently supported is
    ///COD_VERSION. Major: retrieved using the GET_COD_MAJOR(<b>classOfDevice</b>). The following values are currently
    ///defined, but the list is expected to expand. Do not use the major class field to determine to which remote device
    ///to connect. A remote device may only have one major class code, and may not be the appropriate code for the given
    ///profile. <a id="COD_MAJOR_MISCELLANEOUS"></a> <a id="cod_major_miscellaneous"></a>
    uint      classOfDevice;
    ///Name of the remote Bluetooth device, as reported by the device, encoded in UTF8. The user may have locally
    ///provided a display name for the remote Bluetooth device; that name is overridden, and does not appear in this
    ///member; it is accessible only with a call to the BluetoothGetDeviceInfo function.
    byte[248] name;
}

///The <b>BTH_RADIO_IN_RANGE</b> structure stores data about Bluetooth devices within communication range.
struct BTH_RADIO_IN_RANGE
{
    ///Current set of attributes associated with the remote device, in the form of a BTH_DEVICE_INFO structure.
    BTH_DEVICE_INFO deviceInfo;
    ///Previous flags for the <b>flags</b> member of the BTH_DEVICE_INFO structure pointed to by the <b>deviceInfo</b>
    ///member. Used to determine which attributes associated with the remote device have changed.
    uint            previousDeviceFlags;
}

///The <b>BTH_L2CAP_EVENT_INFO</b> structure contains data about events associated with an L2CAP channel.
struct BTH_L2CAP_EVENT_INFO
{
    ///Remote radio address with which the L2CAP event is associated, in the form of a BTH_ADDR structure.
    ulong  bthAddress;
    ///Channel number established or terminated.
    ushort psm;
    ///Status of the connection. If nonzero, the channel has been established. If zero, the channel has been terminated.
    ubyte  connected;
    ///Provides connection information. If nonzero, the local radio initiated the L2CAP connection. If zero, the remote
    ///Bluetooth device initiated the L2CAP connection. If <b>connected</b> is zero, this member is undefined and not
    ///applicable.
    ubyte  initiated;
}

///The <b>BTH_HCI_EVENT_INFO</b> structure is used in connection with obtaining WM_DEVICECHANGE messages for Bluetooth.
struct BTH_HCI_EVENT_INFO
{
    ///Address of the remote device, in the form of a BTH_ADDR structure.
    ulong bthAddress;
    ///Type of connection. Valid values are <b>HCI_CONNECTION_TYPE_ACL</b> or <b>HCI_CONNECTION_TYPE_SCO</b>.
    ubyte connectionType;
    ///Status of the connection. If nonzero, the connection has been established. If zero, the connection has been
    ///terminated.
    ubyte connected;
}

///The <b>BLUETOOTH_ADDRESS</b> structure provides the address of a Bluetooth device.
struct BLUETOOTH_ADDRESS_STRUCT
{
union
    {
        ulong    ullLong;
        ubyte[6] rgBytes;
    }
}

///The <b>BLUETOOTH_LOCAL_SERVICE_INFO</b> structure contains local service information for a Bluetooth device. This
///structure is used by the BluetoothSetLocalServiceInfo function.
struct BLUETOOTH_LOCAL_SERVICE_INFO_STRUCT
{
    ///If <b>TRUE</b>, specifies that the advertised services are enabled; otherwise the advertised services are
    ///disabled.
    BOOL        Enabled;
    ///A BLUETOOTH_ADDRESS structure that contains the address of a remote device. This address is used when advertising
    ///services to a device.
    BLUETOOTH_ADDRESS_STRUCT btAddr;
    ///The service name. The maximum length of this string, including the null terminator, is
    ///<b>BLUETOOTH_MAX_SERVICE_NAME_SIZE</b> (256).
    ushort[256] szName;
    ///The local device name, if any, such as COM4 or LPT1. The maximum length of this string, including the null
    ///terminator, is <b>BLUETOOTH_DEVICE_NAME_SIZE</b> (256).
    ushort[256] szDeviceString;
}

///The <b>BLUETOOTH_FIND_RADIO_PARAMS</b> structure facilitates enumerating installed Bluetooth radios.
struct BLUETOOTH_FIND_RADIO_PARAMS
{
    ///Size of the <b>BLUETOOTH_FIND_RADIO_PARAMS</b> structure, in bytes.
    uint dwSize;
}

///The <b>BLUETOOTH_RADIO_INFO</b> structure contains information about a Bluetooth radio.
struct BLUETOOTH_RADIO_INFO
{
    ///Size, in bytes, of the structure.
    uint        dwSize;
    ///Address of the local Bluetooth radio.
    BLUETOOTH_ADDRESS_STRUCT address;
    ///Name of the local Bluetooth radio.
    ushort[248] szName;
    ///Device class for the local Bluetooth radio.
    uint        ulClassofDevice;
    ///This member contains data specific to individual Bluetooth device manufacturers.
    ushort      lmpSubversion;
    ///Manufacturer of the Bluetooth radio, expressed as a <b>BTH_MFG_Xxx</b> value. For more information about the
    ///Bluetooth assigned numbers document and a current list of values, see the Bluetooth specification at
    ///www.bluetooth.com.
    ushort      manufacturer;
}

///The <b>BLUETOOTH_DEVICE_INFO</b> structure provides information about a Bluetooth device.
struct BLUETOOTH_DEVICE_INFO_STRUCT
{
    ///Size of the <b>BLUETOOTH_DEVICE_INFO</b> structure, in bytes.
    uint        dwSize;
    ///Address of the device.
    BLUETOOTH_ADDRESS_STRUCT Address;
    ///Class of the device.
    uint        ulClassofDevice;
    ///Specifies whether the device is connected.
    BOOL        fConnected;
    ///Specifies whether the device is a remembered device. Not all remembered devices are authenticated.
    BOOL        fRemembered;
    ///Specifies whether the device is authenticated, paired, or bonded. All authenticated devices are remembered.
    BOOL        fAuthenticated;
    ///Last time the device was seen, in the form of a SYSTEMTIME structure.
    SYSTEMTIME  stLastSeen;
    ///Last time the device was used, in the form of a SYSTEMTIME structure.
    SYSTEMTIME  stLastUsed;
    ///Name of the device.
    ushort[248] szName;
}

///The <b>BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS</b> structure contains specific configuration information about the
///Bluetooth device responding to an authentication request.
struct BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS
{
    ///A BLUETOOTH_DEVICE_INFO structure that contains information about a Bluetooth device.
    BLUETOOTH_DEVICE_INFO_STRUCT deviceInfo;
    ///A BLUETOOTH_AUTHENTICATION_METHOD enumeration that defines the authentication method utilized by the Bluetooth
    ///device.
    BLUETOOTH_AUTHENTICATION_METHOD authenticationMethod;
    ///A BLUETOOTH_IO_CAPABILITY enumeration that defines the input/output capabilities of the Bluetooth device.
    BLUETOOTH_IO_CAPABILITY ioCapability;
    ///A BLUETOOTH_AUTHENTICATION_REQUIREMENTS specifies the 'Man in the Middle' protection required for authentication.
    BLUETOOTH_AUTHENTICATION_REQUIREMENTS authenticationRequirements;
union
    {
        uint Numeric_Value;
        uint Passkey;
    }
}

///The <b>BLUETOOTH_DEVICE_SEARCH_PARAMS</b> structure specifies search criteria for Bluetooth device searches.
struct BLUETOOTH_DEVICE_SEARCH_PARAMS
{
    ///The size, in bytes, of the structure.
    uint   dwSize;
    ///A value that specifies that the search should return authenticated Bluetooth devices.
    BOOL   fReturnAuthenticated;
    ///A value that specifies that the search should return remembered Bluetooth devices.
    BOOL   fReturnRemembered;
    ///A value that specifies that the search should return unknown Bluetooth devices.
    BOOL   fReturnUnknown;
    ///A value that specifies that the search should return connected Bluetooth devices.
    BOOL   fReturnConnected;
    ///A value that specifies that a new inquiry should be issued.
    BOOL   fIssueInquiry;
    ///A value that indicates the time out for the inquiry, expressed in increments of 1.28 seconds. For example, an
    ///inquiry of 12.8 seconds has a <b>cTimeoutMultiplier</b> value of 10. The maximum value for this member is 48.
    ///When a value greater than 48 is used, the calling function immediately fails and returns <b>E_INVALIDARG</b>.
    ubyte  cTimeoutMultiplier;
    ///A handle for the radio on which to perform the inquiry. Set to <b>NULL</b> to perform the inquiry on all local
    ///Bluetooth radios.
    HANDLE hRadio;
}

///The <b>BLUETOOTH_COD_PAIRS</b> structure provides for specification and retrieval of Bluetooth Class Of Device (COD)
///information.
struct BLUETOOTH_COD_PAIRS
{
    ///A mask to compare to determine the class of device. The major and minor codes of <b>ulCODMask</b> are used to
    ///compare the class of device found. If a major code is provided it must match the major code returned by the
    ///remote device, such that GET_COD_MAJOR(ulCODMask) is equal to GET_COD_MAJOR([class of device of the remote
    ///device]).
    uint         ulCODMask;
    ///Descriptive string of the mask.
    const(PWSTR) pcszDescription;
}

///The <b>BLUETOOTH_SELECT_DEVICE_PARAMS</b> structure facilitates and manages the visibility, authentication, and
///selection of Bluetooth devices and services.
struct BLUETOOTH_SELECT_DEVICE_PARAMS
{
    ///Size, in bytes, of the <b>BLUETOOTH_SELECT_DEVICE_PARAMS</b> structure.
    uint                 dwSize;
    ///Number of classes in <b>prgClassOfDevices</b>. Set to zero to search for all devices.
    uint                 cNumOfClasses;
    ///Array of class of devices to find.
    BLUETOOTH_COD_PAIRS* prgClassOfDevices;
    ///Sets the information text when not <b>NULL</b>.
    PWSTR                pszInfo;
    ///Handle to the parent window. Set to <b>NULL</b> for no parent.
    HWND                 hwndParent;
    ///If <b>TRUE</b>, forces authentication before returning.
    BOOL                 fForceAuthentication;
    ///If <b>TRUE</b>, authenticated devices are shown in the picker.
    BOOL                 fShowAuthenticated;
    ///If <b>TRUE</b>, remembered devices are shown in the picker.
    BOOL                 fShowRemembered;
    ///If <b>TRUE</b>, unknown devices that are not authenticated or remembered are shown in the picker.
    BOOL                 fShowUnknown;
    ///If <b>TRUE</b>, starts the Add New Device wizard.
    BOOL                 fAddNewDeviceWizard;
    ///If <b>TRUE</b>, skips the Services page in the Add New Device wizard.
    BOOL                 fSkipServicesPage;
    ///A pointer to a callback function that is called for each device. If the callback function returns <b>TRUE</b>,
    ///the item is added. If the callback function returns <b>FALSE</b>, the item is not shown. Set
    ///<b>pfnDeviceCallback</b> to null for no callback. For more information, see PFN_DEVICE_CALLBACK.
    PFN_DEVICE_CALLBACK  pfnDeviceCallback;
    ///Parameter to be passed as <b>pvParam</b> to the callback function pointed to in <b>pfnDeviceCallback</b>.
    void*                pvParam;
    ///On input, specifies the number of desired calls. Set to zero for no limit. On output, returns the number of
    ///devices returned.
    uint                 cNumDevices;
    ///Pointer to an array of BLUETOOTH_DEVICE_INFO structures.
    BLUETOOTH_DEVICE_INFO_STRUCT* pDevices;
}

///The <b>BLUETOOTH_PIN_INFO</b> structure contains information used for authentication via PIN.
struct BLUETOOTH_PIN_INFO
{
    ///The PIN used for authentication.
    ubyte[16] pin;
    ///The length of <i>pin</i>.
    ubyte     pinLength;
}

///The <b>BLUETOOTH_OOB_DATA_INFO</b> structure contains data used to authenticate prior to establishing an Out-of-Band
///device pairing.
struct BLUETOOTH_OOB_DATA_INFO
{
    ///A 128-bit cryptographic key used for two-way authentication.
    ubyte[16] C;
    ///A randomly generated number used for one-way authentication. If this number is not provided by the device
    ///initiating the OOB session, this value is 0.
    ubyte[16] R;
}

///The <b>BLUETOOTH_NUMERIC_COMPARISON_INFO</b> structure contains the numeric value used for authentication via numeric
///comparison.
struct BLUETOOTH_NUMERIC_COMPARISON_INFO
{
    ///The numeric value.
    uint NumericValue;
}

///The <b>BLUETOOTH_PASSKEY_INFO</b> structure contains a passkey value used for authentication. A passkey is similar to
///a password, except that a passkey value is used for authentication only once.
struct BLUETOOTH_PASSKEY_INFO
{
    ///The passkey used for authentication.
    uint passkey;
}

///The <b>BLUETOOTH_AUTHENTICATE_RESPONSE</b> structure contains information passed in response to a
///BTH_REMOTE_AUTHENTICATE_REQUEST event.
struct BLUETOOTH_AUTHENTICATE_RESPONSE
{
    ///A BLUETOOTH_ADDRESS structure that contains the address of the device requesting the authentication response.
    ///<div class="alert"><b>Note</b> This information can be found in the PBLUETOOTH_AUTHENTICATION_CALLBACK PARAMS
    ///structure retrieved from the callback.</div> <div> </div>
    BLUETOOTH_ADDRESS_STRUCT bthAddressRemote;
    ///A BLUETOOTH_AUTHENTICATION_METHOD enumeration that defines the supported authentication method. <div
    ///class="alert"><b>Note</b> This information can be found in the PBLUETOOTH_AUTHENTICATION_CALLBACK PARAMS
    ///structure retrieved from the callback.</div> <div> </div>
    BLUETOOTH_AUTHENTICATION_METHOD authMethod;
union
    {
        BLUETOOTH_PIN_INFO pinInfo;
        BLUETOOTH_OOB_DATA_INFO oobInfo;
        BLUETOOTH_NUMERIC_COMPARISON_INFO numericCompInfo;
        BLUETOOTH_PASSKEY_INFO passkeyInfo;
    }
    ///<b>TRUE</b> if the authentication request was rejected; otherwise <b>FALSE</b>.
    ubyte negativeResponse;
}

///The <b>SDP_ELEMENT_DATA</b> structure stores SDP element data.
struct SDP_ELEMENT_DATA
{
    ///Enumeration of SDP element types. Generic element types have a <b>specificType</b> value different from
    ///SDP_ST_NONE. The generic SDP element types are the following: <ul> <li>SDP_TYPE_UINT</li> <li>SDP_TYPE_INT</li>
    ///<li>SDP_TYPE_UUID</li> </ul> The following element types do not have corresponding <b>specificType</b> values:
    ///<ul> <li>SDP_TYPE_STRING</li> <li>SDP_TYPE_URL</li> <li>SDP_TYPE_SEQUENCE</li> <li>SDP_TYPE_ALTERNATIVE</li>
    ///<li>SDP_TYPE_BOOLEAN</li> <li>SDP_TYPE_NIL</li> </ul> There is no associated data value with the type
    ///SDP_TYPE_NIL.
    SDP_TYPE         type;
    ///Specific type of SDP element, used to further specify generic element types.
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

///The <b>SDP_STRING_TYPE_DATA</b> structure stores information about SDP string types.
struct SDP_STRING_TYPE_DATA
{
    ///Specifies how the string is encoded according to ISO 639:1988 (E/F): Code for the representation of the names of
    ///languages.
    ushort encoding;
    ///MIBE number from the IANA database.
    ushort mibeNum;
    ///Identifier of the base attribute in which the string is to be found in the record.
    ushort attributeId;
}

///The <b>SOCKADDR_BTH</b> structure is used in conjunction with Bluetooth socket operations, defined by address family
///AF_BTH.
struct SOCKADDR_BTH
{
align (1):
    ///Address family of the socket. This member is always AF_BTH.
    ushort addressFamily;
    ///Address of the target Bluetooth device. When used with the bind function, must be zero or a valid local radio
    ///address. If zero, a valid local Bluetooth device address is assigned when the connect or accept function is
    ///called. When used with the <b>connect</b> function, a valid remote radio address must be specified.
    ulong  btAddr;
    ///Service Class Identifier of the socket. When used with the bind function, <i>serviceClassId</i> is ignored. Also
    ///ignored if the port is specified. For the connect function, specifies the unique Bluetooth service class ID of
    ///the service to which it wants to connect. If the peer device has more than one port that corresponds to the
    ///service class identifier, the <b>connect</b> function attempts to connect to the first valid service; this
    ///mechanism can be used without prior SDP queries.
    GUID   serviceClassId;
    ///RFCOMM channel associated with the socket. See Remarks.
    uint   port;
}

///The <b>BTH_SET_SERVICE</b> structure provides service information for the specified Bluetooth service.
struct BTH_SET_SERVICE
{
align (1):
    ///Version of the SDP. Clients set this member to BTH_SDP_VERSION.
    uint*    pSdpVersion;
    ///Handle to the SDP record. Corresponds to SDP ServiceRecordHandle. Returned by the add record operations, and
    ///subsequently used to delete the record.
    HANDLE*  pRecordHandle;
    ///Class of device (COD) information. A 32-bit field of COD_SERVICE_* class of device bits associated with this SDP
    ///record. The system combines these bits with COD bits from other service records and system characteristics. The
    ///resulting class of device for the local radio is advertised when the radio is found during device inquiry. When
    ///the last SDP record associated with a particular service bit is deleted, that service bit is no longer reported
    ///in responses to future device inquiries. The format and possible values for the COD field are defined in the
    ///<i>Bluetooth Assigned Numbers 1.1</i> portion of the Bluetooth specification, Section 1.2. (This resource may not
    ///be available in some languages and countries.) Corresponding macros and definitions for COD_SERVICE_* bits used
    ///by Windows are defined in Bthdef.h. For more information about class of device (COD), see BTH_DEVICE_INFO.
    uint     fCodService;
    ///Reserved. Must be set to zero.
    uint[5]  Reserved;
    ///Size, in bytes, of <b>pRecord</b>.
    uint     ulRecordLength;
    ///SDP record, as defined by the Bluetooth specification.
    ubyte[1] pRecord;
}

///The <b>BTH_QUERY_DEVICE</b> structure is used when querying for the presence of a Bluetooth device.
struct BTH_QUERY_DEVICE
{
align (1):
    ///Reserved. Must be set to zero.
    uint  LAP;
    ///Requested length of the inquiry, in seconds.
    ubyte length;
}

///The <b>BTH_QUERY_SERVICE</b> structure is used to query a Bluetooth service.
struct BTH_QUERY_SERVICE
{
align (1):
    ///Type of service to perform. Choose from the following: <ul> <li>SDP_SERVICE_SEARCH_REQUEST</li>
    ///<li>SDP_SERVICE_ATTRIBUTE_REQUEST</li> <li>SDP_SERVICE_SEARCH_ATTRIBUTE_REQUEST</li> </ul>
    uint                 type;
    ///Service handle on which to query the attributes specified in the <b>pRange</b> member. Used only for attribute
    ///searches.
    uint                 serviceHandle;
    ///UUIDs that a record must contain to match the search. Used for service and service attribute searches. When
    ///querying less than MAX_UUIDS_IN_QUERY UUIDs, set the <b>SdpQueryUuid</b> element immediately following the last
    ///valid UUID to all zeros. Used only for attribute and service attribute searches.
    SdpQueryUuid[12]     uuids;
    ///Number of elements in <b>pRange</b>. Used only for attribute and service attribute searches.
    uint                 numRange;
    ///Attribute values to retrieve for any matching records, in the form of an array of <b>SdpAttributeRange</b>
    ///structures. Attributes are defined in the Bluetooth specification. See Remarks.
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

///The <b>BluetoothFindFirstRadio</b> function begins the enumeration of local Bluetooth radios.
///Params:
///    pbtfrp = Pointer to a BLUETOOTH_FIND_RADIO_PARAMS structure. The <b>dwSize</b> member of the
///             <b>BLUETOOTH_FIND_RADIO_PARAMS</b> structure pointed to by <i>pbtfrp</i> must match the size of the structure.
///    phRadio = Pointer to where the first enumerated radio handle will be returned. When no longer needed, this handle must be
///              closed via CloseHandle.
///Returns:
///    In addition to the handle indicated by <i>phRadio</i>, calling this function will also create a
///    HBLUETOOTH_RADIO_FIND handle for use with the BluetoothFindNextRadio function. When this handle is no longer
///    needed, it must be closed via the BluetoothFindRadioClose. Returns <b>NULL</b> upon failure. Call the
///    GetLastError function for more information on the error. The following table describe common errors: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt>
///    </dl> </td> <td width="60%"> No Bluetooth radios found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pbtfrp</i> parameter is <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_REVISION_MISMATCH</b></dt> </dl> </td> <td width="60%"> The
///    structure pointed to by <i>pbtfrp</i> is not the correct size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
ptrdiff_t BluetoothFindFirstRadio(const(BLUETOOTH_FIND_RADIO_PARAMS)* pbtfrp, HANDLE* phRadio);

///The <b>BluetoothFindNextRadio</b> function finds the next Bluetooth radio.
///Params:
///    hFind = Handle returned by a previous call to the BluetoothFindFirstRadio function. Use BluetoothFindRadioClose to close
///            this handle when it is no longer needed.
///    phRadio = Pointer to where the next enumerated radio handle will be returned. When no longer needed, this handle must be
///              released via CloseHandle.
///Returns:
///    Returns <b>TRUE</b> when the next available radio is found. Returns <b>FALSE</b> when no new radios are found.
///    Call the GetLastError function for more information on the error. The following table describe common errors:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> No more radios were found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Out of
///    memory. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
BOOL BluetoothFindNextRadio(ptrdiff_t hFind, HANDLE* phRadio);

///The <b>BluetoothFindRadioClose</b> function closes the enumeration handle associated with finding Bluetooth radios.
///Params:
///    hFind = Enumeration handle to close, obtained with a previous call to the BluetoothFindFirstRadio function.
///Returns:
///    Returns <b>TRUE</b> when the handle is successfully closed. Returns <b>FALSE</b> if the attempt fails to close
///    the enumeration handle. For additional information on possible errors associated with closing the handle, call
///    the GetLastError function.
///    
@DllImport("BluetoothApis")
BOOL BluetoothFindRadioClose(ptrdiff_t hFind);

///The <b>BluetoothGetRadioInfo</b> function obtains information about a Bluetooth radio.
///Params:
///    hRadio = A handle to a local Bluetooth radio, obtained by calling the BluetoothFindFirstRadio or similar functions, or the
///             <b>SetupDiEnumerateDeviceInterfances</b> function.
///    pRadioInfo = A pointer to a BLUETOOTH_RADIO_INFO structure into which information about the radio will be placed. The
///                 <b>dwSize</b> member of the <b>BLUETOOTH_RADIO_INFO</b> structure must match the size of the structure.
///Returns:
///    The following table lists common return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The radio information was
///    retrieved successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> The <i>hRadio</i> or <i>pRadioInfo</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_REVISION_MISMATCH</b></dt> </dl> </td> <td width="60%"> The <b>dwSize</b> member
///    of the BLUETOOTH_RADIO_INFO structure pointed to by <i>pRadioInfo</i> is not valid. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothGetRadioInfo(HANDLE hRadio, BLUETOOTH_RADIO_INFO* pRadioInfo);

///The <b>BluetoothFindFirstDevice</b> function begins the enumeration Bluetooth devices.
///Params:
///    pbtsp = Pointer to a BLUETOOTH_DEVICE_SEARCH_PARAMS structure. The <b>dwSize</b> member of the
///            <b>BLUETOOTH_DEVICE_SEARCH_PARAMS</b> structure pointed to by <i>pbtsp</i> must match the size of the structure.
///    pbtdi = Pointer to a BLUETOOTH_DEVICE_INFO structure into which information about the first Bluetooth device found is
///            placed. The <b>dwSize</b> member of the <b>BLUETOOTH_DEVICE_INFO</b> structure pointed to by <i>pbtdi</i> must
///            match the size of the structure, or the call to the <b>BluetoothFindFirstDevice</b> function fails.
///Returns:
///    Returns a valid handle to the first Bluetooth device upon successful completion, and the <i>pbtdi</i> parameter
///    points to information about the device. When this handle is no longer needed, it must be closed via the
///    BluetoothFindDeviceClose. Returns <b>NULL</b> upon failure. Call the GetLastError function for more information
///    on the error. The following table describe common errors: <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    <i>pbtsp</i> or <i>pbtdi</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_REVISION_MISMATCH</b></dt> </dl> </td> <td width="60%"> The structure pointed to by <i>pbtsp</i> or
///    <i>pbtdi</i> is not the correct size. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
ptrdiff_t BluetoothFindFirstDevice(const(BLUETOOTH_DEVICE_SEARCH_PARAMS)* pbtsp, 
                                   BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

///The <b>BluetoothFindNextDevice</b> function finds the next Bluetooth device.
///Params:
///    hFind = Handle for the query obtained in a previous call to the BluetoothFindFirstDevice function.
///    pbtdi = Pointer to a BLUETOOTH_DEVICE_INFO structure into which information about the next Bluetooth device found is
///            placed. The <b>dwSize</b> member of the <b>BLUETOOTH_DEVICE_INFO</b> structure pointed to by <i>pbtdi</i> must
///            match the size of the structure, or the call to <b>BluetoothFindNextDevice</b> fails.
///Returns:
///    Returns <b>TRUE</b> when the next device is successfully found, and the <i>pbtdi</i> parameter points to
///    information about the device. Returns <b>FALSE</b> upon error. Call the GetLastError function for more
///    information on the error. The following table describe common errors: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The handle is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> No more devices were found. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr>
///    </table>
///    
@DllImport("BluetoothApis")
BOOL BluetoothFindNextDevice(ptrdiff_t hFind, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

///The <b>BluetoothFindDeviceClose</b> function closes an enumeration handle associated with a device query.
///Params:
///    hFind = Handle for the query to be closed. Obtained in a previous call to the BluetoothFindFirstDevice function.
///Returns:
///    Returns <b>TRUE</b> when the handle is successfully closed. Returns <b>FALSE</b> upon error. Call the
///    GetLastError function for more information on the failure.
///    
@DllImport("BluetoothApis")
BOOL BluetoothFindDeviceClose(ptrdiff_t hFind);

///The <b>BluetoothGetDeviceInfo</b> function retrieves information about a remote Bluetooth device. The Bluetooth
///device must have been previously identified through a successful device inquiry function call.
///Params:
///    hRadio = A handle to a local radio, obtained from a call to the BluetoothFindFirstRadio or similar functions, or from a
///             call to the <b>SetupDiEnumerateDeviceInterfaces</b> function.
///    pbtdi = A pointer to a BLUETOOTH_DEVICE_INFO structure into which data about the first Bluetooth device will be placed.
///            For more information, see Remarks.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> upon success, indicating that data about the remote Bluetooth device was retrieved.
///    Returns error codes upon failure. The following table lists common error codes associated with the
///    <b>BluetoothGetDeviceInfo</b> function. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_REVISION_MISMATCH</b></dt> </dl> </td> <td width="60%"> The size of the
///    BLUETOOTH_DEVICE_INFO is not compatible. Check the <b>dwSize</b> member of the BLUETOOTH_DEVICE_INFO structure.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The radio is
///    not known by the system, or the <b>Address</b> member of the BLUETOOTH_DEVICE_INFO structure is all zeros. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    <i>pbtdi</i> parameter is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothGetDeviceInfo(HANDLE hRadio, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

///The <b>BluetoothUpdateDeviceRecord</b> function updates the local computer cache about a Bluetooth device.
///Params:
///    pbtdi = A pointer to the BLUETOOTH_DEVICE_INFO structure to update. For more information, see the Remarks section.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> upon success. The following table lists common errors. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> The <i>pbtdi</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_REVISION_MISMATCH</b></dt> </dl> </td> <td width="60%"> The <b>dwSize</b> member of the structure
///    pointed to in the <i>pbtdi</i> parameter is not valid. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothUpdateDeviceRecord(const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi);

///The <b>BluetoothRemoveDevice</b> function removes authentication between a Bluetooth device and the computer and
///clears cached service information for the device.
///Params:
///    pAddress = A pointer to the address of the Bluetooth device to be removed.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> upon successful removal of the Bluetooth device. Returns <b>ERROR_NOT_FOUND</b> if
///    the device was not found.
///    
@DllImport("BluetoothApis")
uint BluetoothRemoveDevice(const(BLUETOOTH_ADDRESS_STRUCT)* pAddress);

///The <b>BluetoothSelectDevices</b> function enables Bluetooth device selection.
///Params:
///    pbtsdp = A pointer to a BLUETOOTH_SELECT_DEVICE_PARAMS structure that identifies Bluetooth devices.
///Returns:
///    Returns <b>TRUE</b> if a user selected a device. Returns <b>FALSE</b> if no valid data was returned. Call the
///    GetLastError function to retrieve error information. The following conditions apply to returned error
///    information. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The user canceled the request. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pbtsdp</i>
///    parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_REVISION_MISMATCH</b></dt> </dl>
///    </td> <td width="60%"> The structure passed in <i>pbtsdp</i> is of unknown size. </td> </tr> </table>
///    
@DllImport("bthprops")
BOOL BluetoothSelectDevices(BLUETOOTH_SELECT_DEVICE_PARAMS* pbtsdp);

///The <b>BluetoothSelectDevicesFree</b> function frees resources associated with a previous call to
///BluetoothSelectDevices.
///Params:
///    pbtsdp = A pointer to a BLUETOOTH_SELECT_DEVICE_PARAMS structure that identifies the Bluetooth device resources to free.
///Returns:
///    Returns <b>TRUE</b> upon success. Returns <b>FALSE</b> if there are no resources to free.
///    
@DllImport("bthprops")
BOOL BluetoothSelectDevicesFree(BLUETOOTH_SELECT_DEVICE_PARAMS* pbtsdp);

///The <b>BluetoothDisplayDeviceProperties</b> function starts Control Panel device information property sheet.
///Params:
///    hwndParent = A handle to the parent window of the property sheet.
///    pbtdi = A pointer to the BLUETOOTH_DEVICE_INFO structure that contains information about the Bluetooth device.
///Returns:
///    Returns <b>TRUE</b> if the property sheet is successfully displayed. Returns <b>FALSE</b> if the property sheet
///    was not displayed successfully; call the GetLastError function for additional error information.
///    
@DllImport("bthprops")
BOOL BluetoothDisplayDeviceProperties(HWND hwndParent, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdi);

///The <b>BluetoothAuthenticateDevice</b> function sends an authentication request to a remote Bluetooth device. <div
///class="alert"><b>Note</b> When developing for Windows Vista SP2 and Windows 7 the use of
///BluetoothAuthenticateDeviceEx is recommended.</div><div> </div>
///Params:
///    hwndParent = A window to be the parent of the Authentication wizard. If set to <b>NULL</b>, the wizard is removed from the
///                 desktop.
///    hRadio = A valid local radio handle, or <b>NULL</b>. If <b>NULL</b>, authentication is attempted on all local radios; if
///             any radio succeeds, the function call succeeds.
///    pbtbi = A structure of type BLUETOOTH_DEVICE_INFO that contains the record of the Bluetooth device to be authenticated.
///    pszPasskey = A Personal Identification Number (PIN) to be used for device authentication. If set to <b>NULL</b>, the user
///                 interface is displayed and the user must follow the authentication process provided in the user interface. If
///                 <i>pszPasskey</i> is not <b>NULL</b>, no user interface is displayed. If the passkey is not <b>NULL</b>, it must
///                 be a <b>NULL</b>-terminated string. For more information, see the Remarks section.
///    ulPasskeyLength = The size, in characters, of <i>pszPasskey</i>. The size of <i>pszPasskey</i> must be less than or equal to
///                      <b>BLUETOOTH_MAX_PASSKEY_SIZE</b>.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> upon successful completion. Common errors are listed in the following table. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt>
///    </dl> </td> <td width="60%"> The user canceled the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The device structure in the <i>pbtdi</i>
///    parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td>
///    <td width="60%"> The device pointed to by <i>pbtdi</i> is already marked as authenticated. </td> </tr> </table>
///    
@DllImport("bthprops")
uint BluetoothAuthenticateDevice(HWND hwndParent, HANDLE hRadio, BLUETOOTH_DEVICE_INFO_STRUCT* pbtbi, 
                                 PWSTR pszPasskey, uint ulPasskeyLength);

///The <b>BluetoothAuthenticateDeviceEx</b> function sends an authentication request to a remote Bluetooth device.
///Additionally, this function allows for out-of-band data to be passed into the function call for the device being
///authenticated. <div class="alert"><b>Note</b> This API is supported in Windows Vista SP2 and Windows 7.</div><div>
///</div>
///Params:
///    hwndParentIn = The window to parent the authentication wizard. If <b>NULL</b>, the wizard will be parented off the desktop.
///    hRadioIn = A valid local radio handle or <b>NULL</b>. If <b>NULL</b>, then all radios will be tried. If any of the radios
///               succeed, then the call will succeed.
///    pbtdiInout = A pointer to a BLUETOOTH_DEVICE_INFO structure describing the device being authenticated.
///    pbtOobData = Pointer to device specific out-of-band data to be provided with this API call. If <b>NULL</b>, then a UI is
///                 displayed to continue the authentication process. If not <b>NULL</b>, no UI is displayed. <div
///                 class="alert"><b>Note</b> If a callback is registered using BluetoothRegisterForAuthenticationEx, then a UI will
///                 not be displayed.</div> <div> </div>
///    authenticationRequirement = An BLUETOOTH_AUTHENTICATION_REQUIREMENTSvalue that specifies the protection required for authentication.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion; returns the following error codes upon failure: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt> </dl>
///    </td> <td width="60%"> The user aborted the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The device structure specified in
///    <i>pbdti</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td>
///    <td width="60%"> The device in pbtdi is already been marked as authenticated. </td> </tr> </table>
///    
@DllImport("bthprops")
uint BluetoothAuthenticateDeviceEx(HWND hwndParentIn, HANDLE hRadioIn, BLUETOOTH_DEVICE_INFO_STRUCT* pbtdiInout, 
                                   BLUETOOTH_OOB_DATA_INFO* pbtOobData, 
                                   AUTHENTICATION_REQUIREMENTS authenticationRequirement);

///The <b>BluetoothAuthenticateMultipleDevices</b> function enables the caller to prompt for multiple devices to be
///authenticated during a single instance of the Bluetooth Connection wizard.<div class="alert"><b>Note</b>
///<b>BluetoothAuthenticateMultipleDevices</b> has been deprecated. Implementation of this API is not recommended.
///</div> <div> </div>
///Params:
///    hwndParent = A window to be the parent of the Authentication wizard. If set to <b>NULL</b>, the wizard is parented off the
///                 desktop.
///    hRadio = The valid local radio handle, or <b>NULL</b>. If <b>NULL</b>, authentication is attempted on all local radios; if
///             any radio succeeds, the function call succeeds.
///    cDevices = The number of devices in the <i>pbtdi</i> array of BLUETOOTH_DEVICE_INFO structures.
///    rgbtdi = An array of BLUETOOTH_DEVICE_INFO structures that contain records for the Bluetooth devices to be authenticated.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> upon successful completion; check the <b>fAuthenticate</b> flag for each device. The
///    following table lists common errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The user canceled the operation.
///    Check the <b>fAuthenticate</b> flag for each Bluetooth device to determine whether any devices were authenticated
///    before the user canceled the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the devices in the
///    <i>pbtdi</i> array was not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt>
///    </dl> </td> <td width="60%"> All devices pointed to by <i>pbtdi</i> are already marked as authenticated. </td>
///    </tr> </table>
///    
@DllImport("bthprops")
uint BluetoothAuthenticateMultipleDevices(HWND hwndParent, HANDLE hRadio, uint cDevices, 
                                          BLUETOOTH_DEVICE_INFO_STRUCT* rgbtdi);

///The <b>BluetoothSetServiceState</b> function enables or disables services for a Bluetooth device.
///Params:
///    hRadio = A handle of the local Bluetooth radio.
///    pbtdi = A pointer to a BLUETOOTH_DEVICE_INFO structure. Must be a previously found radio address.
///    pGuidService = A pointer to the service GUID on the remote device.
///    dwServiceFlags = The flags that adjust the service. To disable the service, set to <b>BLUETOOTH_SERVICE_DISABLE</b>; to enable the
///                     service, set to <b>BLUETOOTH_SERVICE_ENABLE</b>.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> upon successful completion. The following table lists common errors. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>dwServiceFlags</i> are not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%">
///    The GUID specified in <i>pGuidService</i> is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwServiceFlags</i> is set to
///    <b>BLUETOOTH_SERVICE_DISABLE</b> and the service is already disabled, or <i>dwServiceFlags</i> is set to
///    <b>BLUETOOTH_SERVICE_ENABLE</b> and the service is already enabled. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothSetServiceState(HANDLE hRadio, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, const(GUID)* pGuidService, 
                              uint dwServiceFlags);

///The <b>BluetoothEnumerateInstalledServices</b> function enumerates the services GUIDs (Globally Unique Identifiers)
///enabled on a Bluetooth device.
///Params:
///    hRadio = Handle of the local Bluetooth radio device. If <b>NULL</b>, all local radios are searched for enabled services
///             that match the radio address in <i>pbtdi</i>.
///    pbtdi = Pointer to a BLUETOOTH_DEVICE_INFO structure.
///    pcServiceInout = On input, the number of records pointed to by the <i>pGuidServices</i> parameter. On output, the number of valid
///                     records returned in the <i>pGuidServices</i> parameter. If pGuidServices is <b>NULL</b>, on output
///                     <i>pcServices</i> contains the number of services enabled.
///    pGuidServices = Pointer to a buffer in memory to receive GUIDs for installed services. The buffer must be at least
///                    *<i>pcServices</i> *<b>sizeof</b>(GUID) bytes.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion, and the pGuidServices parameter contains a complete list of
///    enabled service GUIDs. The following table describes a common error: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The call succeeded. The <i>pGuidServices</i> parameter contains an incomplete list of enabled
///    service GUIDs. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothEnumerateInstalledServices(HANDLE hRadio, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, 
                                         uint* pcServiceInout, GUID* pGuidServices);

///The <b>BluetoothEnableDiscovery</b> function changes the discovery state of a local Bluetooth radio or radios.
///Params:
///    hRadio = Valid local radio handle, or <b>NULL</b>. If <b>NULL</b>, discovery is modified on all local radios; if any radio
///             is modified by the call, the function call succeeds.
///    fEnabled = Flag specifying whether discovery is to be enabled or disabled. Set to <b>TRUE</b> to enable discovery, set to
///               <b>FALSE</b> to disable discovery.
///Returns:
///    Returns <b>TRUE</b> if the discovery state was successfully changed. If <i>hRadio</i> is <b>NULL</b>, a return
///    value of <b>TRUE</b> indicates that at least one local radio state was successfully changed. Returns <b>FALSE</b>
///    if discovery state was not changed; if <i>hRadio</i> was <b>NULL</b>, no radio accepted the state change.
///    
@DllImport("BluetoothApis")
BOOL BluetoothEnableDiscovery(HANDLE hRadio, BOOL fEnabled);

///The <b>BluetoothIsDiscoverable</b> function determines whether a Bluetooth radio or radios is discoverable.
///Params:
///    hRadio = Valid local radio handle, or <b>NULL</b>. If <b>NULL</b>, discovery is determined for all local radios; if any
///             radio is discoverable, the function call succeeds.
///Returns:
///    Returns <b>TRUE</b> if at least one Bluetooth radio is discoverable. Returns <b>FALSE</b> if no Bluetooth radios
///    are discoverable.
///    
@DllImport("BluetoothApis")
BOOL BluetoothIsDiscoverable(HANDLE hRadio);

///The <b>BluetoothEnableIncomingConnections</b> function modifies whether a local Bluetooth radio accepts incoming
///connections.
///Params:
///    hRadio = Valid local radio handle for which to change whether incoming connections are enabled, or <b>NULL</b>. If
///             <b>NULL</b>, the attempt to modify incoming connection acceptance iterates through all local radios; if any radio
///             is modified by the call, the function call succeeds.
///    fEnabled = Flag specifying whether incoming connection acceptance is to be enabled or disabled. Set to <b>TRUE</b> to enable
///               incoming connections, set to <b>FALSE</b> to disable incoming connections.
///Returns:
///    Returns <b>TRUE</b> if the incoming connection state was successfully changed. If <i>hRadio</i> is <b>NULL</b>, a
///    return value of <b>TRUE</b> indicates that at least one local radio state was successfully changed. Returns
///    <b>FALSE</b> if incoming connection state was not changed; if <i>hRadio</i> was <b>NULL</b>, no radio accepted
///    the state change.
///    
@DllImport("BluetoothApis")
BOOL BluetoothEnableIncomingConnections(HANDLE hRadio, BOOL fEnabled);

///The <b>BluetoothIsConnectable</b> function determines whether a Bluetooth radio or radios is connectable.
///Params:
///    hRadio = Valid local radio handle, or <b>NULL</b>. If <b>NULL</b>, all local radios are checked for connectability; if any
///             radio is connectable, the function call succeeds.
///Returns:
///    Returns <b>TRUE</b> if at least one Bluetooth radio is accepting incoming connections. Returns <b>FALSE</b> if no
///    radios are accepting incoming connections.
///    
@DllImport("BluetoothApis")
BOOL BluetoothIsConnectable(HANDLE hRadio);

///The <b>BluetoothRegisterForAuthentication</b> function registers a callback function that is called when a particular
///Bluetooth device requests authentication. <div class="alert"><b>Note</b> When developing for Windows Vista SP2 and
///Windows 7 the use of BluetoothRegisterForAuthenticationEx is recommended.</div><div> </div>
///Params:
///    pbtdi = Pointer to a BLUETOOTH_DEVICE_INFO structure. The Address member is used for comparison.
///    phRegHandle = Pointer to a structure in which the registration HANDLE is stored. Call the BluetoothUnregisterAuthentication to
///                  close the handle.
///    pfnCallback = Function to be called when the authentication event occurs. The function should match the prototype described in
///                  PFN_AUTHENTICATION_CALLBACK.
///    pvParam = Optional parameter to be passed through the callback function.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion, and a valid registration handle was returned in
///    <i>phRegHandle</i>. Any other return value indicates failure. Call the GetLastError function to obtain more
///    information about the error. The following table describes a common error: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> </dl> </td> <td
///    width="60%"> Out of memory. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothRegisterForAuthentication(const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, ptrdiff_t* phRegHandle, 
                                        PFN_AUTHENTICATION_CALLBACK pfnCallback, void* pvParam);

///The <b>BluetoothRegisterForAuthenticationEx</b> function registers an application for a pin request, numeric
///comparison and callback function. <div class="alert"><b>Note</b> This API is supported in Windows Vista SP2 and
///Windows 7.</div><div> </div>
///Params:
///    pbtdiIn = A pointer to a BLUETOOTH_DEVICE_INFO structure that specifies the bluetooth address to be utilized for
///              comparison.
///    phRegHandleOut = A pointer to a <b>HBLUETOOTH_AUTHENTICATION_REGISTRATION</b> handle associated with the registered application.
///                     Call BluetoothUnregisterAuthentication to close the handle.
///    pfnCallbackIn = The function that will be called when the authentication event occurs. This function should match the prototype
///                    of PFN_AUTHENTICATION_CALLBACK_EX.
///    pvParam = Optional parameter to be passed through to the callback function specified by <i>pfnCallbackIn</i>. This
///              parameter can be anything the application is required to define.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion; returns the following error codes upon failure: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt>
///    </dl> </td> <td width="60%"> Out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Win32 Error</b></dt>
///    </dl> </td> <td width="60%"> The registration handle that was provided is invalid. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothRegisterForAuthenticationEx(const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdiIn, ptrdiff_t* phRegHandleOut, 
                                          PFN_AUTHENTICATION_CALLBACK_EX pfnCallbackIn, void* pvParam);

///The <b>BluetoothUnregisterAuthentication</b> function removes registration for a callback routine that was previously
///registered with a call to the BluetoothRegisterForAuthentication function.
///Params:
///    hRegHandle = Handle returned by a previous call to the BluetoothRegisterForAuthentication function.
///Returns:
///    Returns <b>TRUE</b> when the authentication registration is successfully removed. Returns <b>FALSE</b> if the
///    specified handle is not successfully closed. Call the GetLastError function to obtain more information about the
///    error. The following table describes a common error: <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is
///    <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
BOOL BluetoothUnregisterAuthentication(ptrdiff_t hRegHandle);

///The <b>BluetoothSendAuthenticationResponse</b> function is called when an authentication request to send the passkey
///response is received. <div class="alert"><b>Note</b> When developing for Windows Vista SP2 and Windows 7 the use of
///BluetoothSendAuthenticationResponseEx is recommended.</div><div> </div>
///Params:
///    hRadio = Optional handle to the local radio handle, or <b>NULL</b>. If <b>NULL</b>, the function attempts to send an
///             authentication response on all local radios.
///    pbtdi = Pointer to a BLUETOOTH_DEVICE_INFO structure describing the Bluetooth device being authenticated. This can be the
///            same structure passed to the callback function.
///    pszPasskey = Pointer to a UNICODE zero-terminated string of the passkey response to be sent back to the authenticating device.
///                 the <i>pszPasskey</i> parameter can be no larger than BLUETOOTH_MAX_PASSKEY_SIZE, excluding <b>NULL</b>. If
///                 translation to ANSI is performed, the <i>pszPasskey</i> parameter cannot be larger than 16 bytes, excluding
///                 <b>NULL</b>.
///Returns:
///    Returns ERROR_SUCCESS when the device accepts the passkey response; the device is authenticated. Any other return
///    value indicates failure. The following table describes common errors: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td
///    width="60%"> The Bluetooth device denied the passkey response. This error is also returned if a communication
///    problem exists with the local radio. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
///    <td width="60%"> The device returned a failure code during authentication. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothSendAuthenticationResponse(HANDLE hRadio, const(BLUETOOTH_DEVICE_INFO_STRUCT)* pbtdi, 
                                         const(PWSTR) pszPasskey);

///The <b>BluetoothSendAuthenticationResponseEx</b> function is called when an authentication request to send the
///passkey or a Numeric Comparison response is made. <div class="alert"><b>Note</b> This API is supported in Windows
///Vista SP2 and Windows 7.</div><div> </div>
///Params:
///    hRadioIn = A handle of the Bluetooth radio device to specify local service information for.
///    pauthResponse = Pointer to a BLUETOOTH_AUTHENTICATE_RESPONSE structure containing the response to the
///                    <b>BTH_REMOTE_AUTHENTICATE_REQUEST</b> event.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion; returns the following error codes upon failure: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt> </dl>
///    </td> <td width="60%"> The device was denied the passkey response. This may also indicate a communications
///    problem with the local radio device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
///    <td width="60%"> The device returned a failure code during authentication. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothSendAuthenticationResponseEx(HANDLE hRadioIn, BLUETOOTH_AUTHENTICATE_RESPONSE* pauthResponse);

///The <b>BluetoothSdpGetElementData</b> function retrieves and parses a single element from an SDP stream.
///Params:
///    pSdpStream = A pointer to a valid SDP stream.
///    cbSdpStreamLength = The length, in bytes, of <i>pSdpStream</i>.
///    pData = A pointer to a buffer to be filled with the data of the SDP element found at the beginning of the
///            <i>pSdpStream</i> SDP stream.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> when the SDP element is parsed correctly. Returns <b>ERROR_INVALID_PARAMETER</b> if
///    one of the required parameters is <b>NULL</b>, or if the SDP stream pointed to by <i>pSdpStream</i> is not valid.
///    
@DllImport("BluetoothApis")
uint BluetoothSdpGetElementData(ubyte* pSdpStream, uint cbSdpStreamLength, SDP_ELEMENT_DATA* pData);

///The <b>BluetoothSdpGetContainerElementData</b> function iterates a container stream and returns each element
///contained within the container element.
///Params:
///    pContainerStream = A pointer to valid SDP stream. The first element in the stream must be a sequence or an alternative.
///    cbContainerLength = The size, in bytes, of the <i>pContainerStream</i> parameter.
///    pElement = A value used to track the location in the stream. The first time the <b>BluetoothSdpGetContainerElementData</b>
///               function is called for a container, *<i>pElement</i>should be <b>NULL</b>. For subsequent calls, the value should
///               be unmodified.
///    pData = A pointer to a buffer filled with data from the current SDP element of <i>pContainerStream</i>.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> upon success, indicating that the <i>pData</i> parameter contains the data. Returns
///    error codes upon failure. The following table describes common error codes associated with the
///    <b>BluetoothSdpGetContainerElementData</b> function: <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more
///    items in the list. The caller should stop calling the BluetoothSdpGetContainerElementData function for this
///    container. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A required pointer is <b>NULL</b>, or the container is not a valid SDP stream. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothSdpGetContainerElementData(ubyte* pContainerStream, uint cbContainerLength, ptrdiff_t* pElement, 
                                         SDP_ELEMENT_DATA* pData);

///The <b>BluetoothSdpGetAttributeValue</b> function retrieves the attribute value for an attribute identifier.
///Params:
///    pRecordStream = Pointer to a valid record stream that is formatted as a single SDP record.
///    cbRecordLength = Length of <i>pRecordStream</i>, in bytes.
///    usAttributeId = Attribute identifier to search for. See Remarks.
///    pAttributeData = Pointer to an SDP_ELEMENT_DATA structure into which the attribute's identifier value is placed.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion; the <i>pAddributeData</i> parameter contains the attribute
///    value. Any other return value indicates error. The following table describes common error codes associated with
///    the <b>BluetoothSdpGetAttributeValue</b> function: <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Either one of the
///    required pointers was <b>NULL</b>, the <i>pRecordStream</i> parameter was not a valid SDP stream, or the
///    <i>pRecordStream</i> parameter was not a properly formatted SDP record. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The identifier provided in <i>usAttributeId</i>
///    was not found in the record. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothSdpGetAttributeValue(ubyte* pRecordStream, uint cbRecordLength, ushort usAttributeId, 
                                   SDP_ELEMENT_DATA* pAttributeData);

///The <b>BluetoothSdpGetString</b> function converts a raw string embedded in the SDP record into a Unicode string.
///Params:
///    pRecordStream = A pointer to a valid record stream formatted as a single SDP record.
///    cbRecordLength = The length, in bytes, of <i>pRecordStream</i>.
///    pStringData = When set to <b>NULL</b>, the calling thread locale is used to search for a matching string in the SDP record. If
///                  not <b>NULL</b>, the <b>mibeNum</b> and <b>attributeId</b> members of the SDP_STRING_TYPE_DATA structure are used
///                  to find the string to convert.
///    usStringOffset = SDP string type offset to convert. The <i>usStringOffset</i> is added to the base attribute identifier of the
///                     string. SDP specification-defined offsets are: STRING_NAME_OFFSET, STRING_DESCRIPTION_OFFSET, and
///                     STRING_PROVIDER_NAME_OFFSET. These offsets can be found in the bthdef.h header file.
///    pszString = If not <b>NULL</b>, contains the converted string on output. When set to <b>NULL</b>, the <i>pcchStringLength</i>
///                parameter is filled with the required number of characters, not bytes, to retrieve the converted string.
///    pcchStringLength = On input, contains the length of <i>pszString</i> if <i>pszString</i> is not <b>NULL</b>, in characters. Upon
///                       output, contains the number of required characters including <b>NULL</b> if an error is returned, or the number
///                       of characters written to <i>pszString</i>, including <b>NULL</b>.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion; the <i>pszString</i> parameter contains the converted string.
///    Returns error codes upon failure. Common errors are listed in the following table. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The <i>pszString</i> parameter was <b>NULL</b> or too small to contain the converted string; the
///    <i>pcchStringLength</i> parameter contains, in characters, the required length. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The conversion cannot be performed. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%"> The
///    system cannot allocate memory internally to perform the conversion. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the required pointers was
///    <b>NULL</b>, the <i>pRecordStream</i> parameter was not a valid SDP stream, the <i>pRecordStream</i> was not a
///    properly formatted record, or the requested attribute plus offset was not a string. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothSdpGetString(ubyte* pRecordStream, uint cbRecordLength, const(SDP_STRING_TYPE_DATA)* pStringData, 
                           ushort usStringOffset, PWSTR pszString, uint* pcchStringLength);

///The <b>BluetoothSdpEnumAttributes</b> function enumerates through the SDP record stream, and calls the callback
///function for each attribute in the record.
///Params:
///    pSDPStream = Pointer to a valid record stream that is formatted as a single SDP record.
///    cbStreamSize = Size of the stream pointed to by <i>pSDPStream</i>, in bytes.
///    pfnCallback = Pointer to the callback routine. See PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK for more information about the
///                  callback.
///    pvParam = Optional parameter to be passed to the callback routine.
///Returns:
///    Returns <b>TRUE</b> if an enumeration occurred. Returns <b>FALSE</b> upon failure. Call the GetLastError function
///    for more information. The following table describes common error codes associated with the
///    <b>BluetoothSdpEnumAttributes</b> function: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pSDPStream</i> or
///    <i>pfnCallback</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The SDP stream is corrupt. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
BOOL BluetoothSdpEnumAttributes(ubyte* pSDPStream, uint cbStreamSize, 
                                PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK pfnCallback, void* pvParam);

///The <b>BluetoothSetLocalServiceInfo</b> function sets local service information for a specific Bluetooth radio.
///Params:
///    hRadioIn = A handle of the Bluetooth radio device to specify local service information for. If <b>NULL</b>,
///               <b>BluetoothSetLocalServiceInfo</b> searches for the first available local Bluetooth radio.
///    pClassGuid = The GUID of the service to expose. This should match the <b>GUID</b> in the server-side INF file.
///    ulInstance = An instance ID for the device node of the Plug and Play (PnP) ID.
///    pServiceInfoIn = A pointer to a BLUETOOTH_LOCAL_SERVICE_INFO structure that describes the local service to set.
///Returns:
///    The <b>BluetoothSetLocalServiceInfo</b> function returns the following values: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The specified Bluetooth radio was not detected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_UNIT</b></dt> </dl> </td> <td width="60%"> No Bluetooth radios were detected. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>STATUS_INSUFFICIENT_RESOURCES</b></dt> </dl> </td> <td width="60%"> Sufficient
///    resources were not available to complete the operation. You can receive this error when more than 100 local
///    physical device objects (PDOs) correspond to Bluetooth services. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>STATUS_PRIVILEGE_NOT_HELD</b></dt> </dl> </td> <td width="60%"> The caller does not have the required
///    privileges. See the Remarks section for information about how to elevate privileges. </td> </tr> </table>
///    
@DllImport("BluetoothApis")
uint BluetoothSetLocalServiceInfo(HANDLE hRadioIn, const(GUID)* pClassGuid, uint ulInstance, 
                                  const(BLUETOOTH_LOCAL_SERVICE_INFO_STRUCT)* pServiceInfoIn);

///The <b>BluetoothIsVersionAvailable</b> function indicates if the installed Bluetooth binary set supports the
///requested version.
///Params:
///    MajorVersion = The major version number.
///    MinorVersion = The minor version number.
///Returns:
///    <b>TRUE</b> if the installed bluetooth binaries support the specified <i>MajorVersion</i> and
///    <i>MinorVersion</i>; otherwise, <b>FALSE</b>.
///    
@DllImport("BluetoothApis")
BOOL BluetoothIsVersionAvailable(ubyte MajorVersion, ubyte MinorVersion);


