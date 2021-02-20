// Written in the D programming language.

module windows.mobilebroadband;

public import windows.core;
public import windows.automation : BSTR, SAFEARRAY;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///THE <b>MBN_SIGNAL_CONSTANTS</b> enumerated type contains specific values used by IMbnSignal interface operations.
alias MBN_SIGNAL_CONSTANTS = int;
enum : int
{
    ///Use the default value for signal state reporting.
    MBN_RSSI_DEFAULT       = 0xffffffff,
    ///Disable signal state reporting.
    MBN_RSSI_DISABLE       = 0x00000000,
    ///Signal strength is unknown.
    MBN_RSSI_UNKNOWN       = 0x00000063,
    MBN_ERROR_RATE_UNKNOWN = 0x00000063,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_CELLULAR_CLASS</b> enumerated type defines the type of cellular device.
alias MBN_CELLULAR_CLASS = int;
enum : int
{
    ///No cellular class.
    MBN_CELLULAR_CLASS_NONE = 0x00000000,
    ///GSM cellular class.
    MBN_CELLULAR_CLASS_GSM  = 0x00000001,
    MBN_CELLULAR_CLASS_CDMA = 0x00000002,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_VOICE_CLASS</b> enumerated type specifies a device's voice capabilities and how they interact with the
///data service.
alias MBN_VOICE_CLASS = int;
enum : int
{
    ///The device voice class is unknown.
    MBN_VOICE_CLASS_NONE                    = 0x00000000,
    ///The device does not support voice calls.
    MBN_VOICE_CLASS_NO_VOICE                = 0x00000001,
    ///The device supports voice calls, but does not support simultaneous voice and data.
    MBN_VOICE_CLASS_SEPARATE_VOICE_DATA     = 0x00000002,
    MBN_VOICE_CLASS_SIMULTANEOUS_VOICE_DATA = 0x00000003,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_PROVIDER_STATE</b> enumerated type specifies the various states with which a provider entry can be tagged.
///These values are intended to be used together in a bitwise OR combination.
alias MBN_PROVIDER_STATE = int;
enum : int
{
    ///Unknown provider state.
    MBN_PROVIDER_STATE_NONE                   = 0x00000000,
    ///The provider is a home operator.
    MBN_PROVIDER_STATE_HOME                   = 0x00000001,
    ///The provider is on the forbidden list.
    MBN_PROVIDER_STATE_FORBIDDEN              = 0x00000002,
    ///The provider is on the preferred list.
    MBN_PROVIDER_STATE_PREFERRED              = 0x00000004,
    ///The provider is visible.
    MBN_PROVIDER_STATE_VISIBLE                = 0x00000008,
    ///Windows 8 or later: The provider is currently registered by the device.
    MBN_PROVIDER_STATE_REGISTERED             = 0x00000010,
    ///Windows 8 or later: The provider is currently on the preferred multi-carrier list.
    MBN_PROVIDER_STATE_PREFERRED_MULTICARRIER = 0x00000020,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_PROVIDER_CONSTANTS</b> enumerated type contains values that define the buffer lengths of MBN_PROVIDER
///members.
alias MBN_PROVIDER_CONSTANTS = int;
enum : int
{
    ///The maximum length of the <b>providerName</b> member of the MBN_PROVIDER structure.
    MBN_PROVIDERNAME_LEN = 0x00000014,
    MBN_PROVIDERID_LEN   = 0x00000006,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_INTERFACE_CAPS_CONSTANTS</b> enumerated type defines the maximum length of string values used by assorted
///elements of the MBN_INTERFACE_CAPS structure.
alias MBN_INTERFACE_CAPS_CONSTANTS = int;
enum : int
{
    ///This constant defines the maximum string size of the <b>deviceID</b> member of the MBN_INTERFACE_CAPS structure.
    MBN_DEVICEID_LEN     = 0x00000012,
    ///This constant defines the maximum string size of the <b>manufacturer</b> member of the MBN_INTERFACE_CAPS
    ///structure.
    MBN_MANUFACTURER_LEN = 0x00000020,
    ///This constant defines the maximum string size of the <b>model</b> member of the MBN_INTERFACE_CAPS structure.
    MBN_MODEL_LEN        = 0x00000020,
    MBN_FIRMWARE_LEN     = 0x00000020,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_DATA_CLASS</b> enumerated type specifies the data classes that a provider supports.
alias MBN_DATA_CLASS = int;
enum : int
{
    ///No data class.
    MBN_DATA_CLASS_NONE        = 0x00000000,
    ///The GPRS data class implemented by GSM providers.
    MBN_DATA_CLASS_GPRS        = 0x00000001,
    ///The EDGE data class implemented by GSM providers.
    MBN_DATA_CLASS_EDGE        = 0x00000002,
    ///The UMTS data class implemented by mobile radio providers.
    MBN_DATA_CLASS_UMTS        = 0x00000004,
    ///The HSDPA data class implemented by mobile radio providers.
    MBN_DATA_CLASS_HSDPA       = 0x00000008,
    ///The HSUPA (High Speed Uplink Packet Access) data class.
    MBN_DATA_CLASS_HSUPA       = 0x00000010,
    ///The LTE data class implemented by mobile radio providers.
    MBN_DATA_CLASS_LTE         = 0x00000020,
    MBN_DATA_CLASS_5G_NSA      = 0x00000040,
    MBN_DATA_CLASS_5G_SA       = 0x00000080,
    ///The 1xRTT data class implemented by CDMA providers.
    MBN_DATA_CLASS_1XRTT       = 0x00010000,
    ///The IxEV-DO data class implemented by CDMA providers.
    MBN_DATA_CLASS_1XEVDO      = 0x00020000,
    ///The IxEV-DO RevA data class implemented by CDMA providers.
    MBN_DATA_CLASS_1XEVDO_REVA = 0x00040000,
    ///The 1xXEV-DV data class.
    MBN_DATA_CLASS_1XEVDV      = 0x00080000,
    ///The 3xRTT data class.
    MBN_DATA_CLASS_3XRTT       = 0x00100000,
    ///The 1xEV-DO RevB data class, which is defined for future use.
    MBN_DATA_CLASS_1XEVDO_REVB = 0x00200000,
    ///The UMB data class.
    MBN_DATA_CLASS_UMB         = 0x00400000,
    MBN_DATA_CLASS_CUSTOM      = 0x80000000,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_CTRL_CAPS</b> enumerated type represents all of the Mobile Broadband device control capabilities as bit
///fields.
alias MBN_CTRL_CAPS = int;
enum : int
{
    ///Device control capabilities are unavailable.
    MBN_CTRL_CAPS_NONE                = 0x00000000,
    ///Manual selection is allowed for the interface. This field will not be set for CDMA type interfaces.
    MBN_CTRL_CAPS_REG_MANUAL          = 0x00000001,
    ///Hardware radio switch functionality is supported.
    MBN_CTRL_CAPS_HW_RADIO_SWITCH     = 0x00000002,
    ///The Mobile Broadband device is configured for Mobile IP support. This field is applicable only to CDMA devices.
    MBN_CTRL_CAPS_CDMA_MOBILE_IP      = 0x00000004,
    ///The Mobile Broadband device is configured for Simple IP support. This field is applicable only to CDMA devices.
    ///If this field is set in conjunction with <b>MBN_CTRL_CAPS_MOBILE_IP</b>, then this indicates that the device is
    ///configured for Mobile IP with Simple IP as a fallback option.
    MBN_CTRL_CAPS_CDMA_SIMPLE_IP      = 0x00000008,
    ///In some countries or regions, showing the International Mobile Subscriber Identity (IMSI) to the user is not
    ///allowed. When this flag is set, the application should not display the IMSI to users.
    MBN_CTRL_CAPS_PROTECT_UNIQUEID    = 0x00000010,
    ///Windows 8 or later: The Mobile Broadband device supports multi-carrier functionality and is not restricted by a
    ///Network Service Provider (NSP).
    MBN_CTRL_CAPS_MODEL_MULTI_CARRIER = 0x00000020,
    ///Windows 8 or later: The Mobile Broadband device supports the USSD protocol. This flag applies only to GSM-based
    ///devices.
    MBN_CTRL_CAPS_USSD                = 0x00000040,
    MBN_CTRL_CAPS_MULTI_MODE          = 0x00000080,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_SMS_CAPS</b> enumerated type contains bitfield values that specify SMS capabilities. These enumerated
///values are used by the <b>smsCaps</b> member of the MBN_INTERFACE_CAPS structure.
alias MBN_SMS_CAPS = int;
enum : int
{
    ///The device does not support SMS.
    MBN_SMS_CAPS_NONE         = 0x00000000,
    ///For GSM devices, this indicates that the device is capable of receiving PDU-type SMS. For CDMA devices, this
    ///indicates that the device is capable of reading the SMS in binary format as defined in â€œsection 3.4.2.1 SMS
    ///Point-to-Point Messageâ€ in 3GPP2 specification C.S0015-A â€œShort Message Service (SMS) for Wideband
    ///Spread Spectrum Systemsâ€.
    MBN_SMS_CAPS_PDU_RECEIVE  = 0x00000001,
    ///For GSM devices, this indicates that the device is capable of sending PDU-type SMS. For CDMA devices, this
    ///indicates that the device is capable of sending the SMS in binary format as defined in â€œsection 3.4.2.1 SMS
    ///Point-to-Point Messageâ€ in 3GPP2 specification C.S0015-A â€œShort Message Service (SMS) for Wideband
    ///Spread Spectrum Systemsâ€.
    MBN_SMS_CAPS_PDU_SEND     = 0x00000002,
    ///The device supports receiving text-type SMS messages. This is applicable only to CDMA devices.
    MBN_SMS_CAPS_TEXT_RECEIVE = 0x00000004,
    MBN_SMS_CAPS_TEXT_SEND    = 0x00000008,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_BAND_CLASS</b> enumerated type defines the frequency band classes.
alias MBN_BAND_CLASS = int;
enum : int
{
    ///Unknown band class.
    MBN_BAND_CLASS_NONE   = 0x00000000,
    ///Band class 0.
    MBN_BAND_CLASS_0      = 0x00000001,
    ///Band class 1.
    MBN_BAND_CLASS_I      = 0x00000002,
    ///Band class 2.
    MBN_BAND_CLASS_II     = 0x00000004,
    ///Band class 3.
    MBN_BAND_CLASS_III    = 0x00000008,
    ///Band class 4.
    MBN_BAND_CLASS_IV     = 0x00000010,
    ///Band class 5.
    MBN_BAND_CLASS_V      = 0x00000020,
    ///Band class 6.
    MBN_BAND_CLASS_VI     = 0x00000040,
    ///Band class 7.
    MBN_BAND_CLASS_VII    = 0x00000080,
    ///Band class 8.
    MBN_BAND_CLASS_VIII   = 0x00000100,
    ///Band class 9.
    MBN_BAND_CLASS_IX     = 0x00000200,
    ///Band class 10.
    MBN_BAND_CLASS_X      = 0x00000400,
    ///Band class 11.
    MBN_BAND_CLASS_XI     = 0x00000800,
    ///Band class 12.
    MBN_BAND_CLASS_XII    = 0x00001000,
    ///Band class 13.
    MBN_BAND_CLASS_XIII   = 0x00002000,
    ///Band class 14.
    MBN_BAND_CLASS_XIV    = 0x00004000,
    ///Band class 15.
    MBN_BAND_CLASS_XV     = 0x00008000,
    ///Band class 16.
    MBN_BAND_CLASS_XVI    = 0x00010000,
    ///Band class 17.
    MBN_BAND_CLASS_XVII   = 0x00020000,
    ///Custom band class.
    MBN_BAND_CLASS_CUSTOM = 0x80000000,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_READY_STATE</b> enumerated type contains values that indicate the readiness of a Mobile Broadband device
///to engage in cellular network traffic operations. These values are returned by the GetReadyState method of
///IMbnInterface. For a device with a SIM card, this is to signal that the SIM has been initialized and is ready for
///access.
alias MBN_READY_STATE = int;
enum : int
{
    ///The mobile broadband device stack is off.
    MBN_READY_STATE_OFF              = 0x00000000,
    ///The card and stack is powered up and ready to be used for mobile broadband operations.
    MBN_READY_STATE_INITIALIZED      = 0x00000001,
    ///The SIM is not inserted.
    MBN_READY_STATE_SIM_NOT_INSERTED = 0x00000002,
    ///The SIM is invalid (PIN Unblock Key retrials have exceeded the limit).
    MBN_READY_STATE_BAD_SIM          = 0x00000003,
    ///General device failure.
    MBN_READY_STATE_FAILURE          = 0x00000004,
    ///The subscription is not activated.
    MBN_READY_STATE_NOT_ACTIVATED    = 0x00000005,
    ///The device is locked by a PIN or password which is preventing the device from initializing and registering onto
    ///the network. The calling application can call the GetPinState method of the IMbnPinManager interface to get the
    ///type of PIN needed to be entered to unlock the device.
    MBN_READY_STATE_DEVICE_LOCKED    = 0x00000006,
    ///The device is blocked by a PIN or password which is preventing the device from initializing and registering onto
    ///the network. The calling application should call the Unblock method of the IMbnPin interface to unblock the
    ///device.
    MBN_READY_STATE_DEVICE_BLOCKED   = 0x00000007,
    MBN_READY_STATE_NO_ESIM_PROFILE  = 0x00000008,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_ACTIVATION_STATE</b> enumerated type indicates the current data connection state.
alias MBN_ACTIVATION_STATE = int;
enum : int
{
    ///The connection state is unknown.
    MBN_ACTIVATION_STATE_NONE         = 0x00000000,
    ///The connection has been established.
    MBN_ACTIVATION_STATE_ACTIVATED    = 0x00000001,
    ///The device is establishing the connection.
    MBN_ACTIVATION_STATE_ACTIVATING   = 0x00000002,
    ///There is no connection.
    MBN_ACTIVATION_STATE_DEACTIVATED  = 0x00000003,
    MBN_ACTIVATION_STATE_DEACTIVATING = 0x00000004,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_CONNECTION_MODE</b> enumerated type specifies the mode of connection requested.
alias MBN_CONNECTION_MODE = int;
enum : int
{
    ///Profile name is used for connection.
    MBN_CONNECTION_MODE_PROFILE     = 0x00000000,
    MBN_CONNECTION_MODE_TMP_PROFILE = 0x00000001,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_VOICE_CALL_STATE</b> enumerated type specifies the current voice call state of the device.
alias MBN_VOICE_CALL_STATE = int;
enum : int
{
    ///Voice call state is unknown.
    MBN_VOICE_CALL_STATE_NONE        = 0x00000000,
    ///An active voice call is in progress.
    MBN_VOICE_CALL_STATE_IN_PROGRESS = 0x00000001,
    MBN_VOICE_CALL_STATE_HANGUP      = 0x00000002,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_REGISTRATION_CONSTANTS</b> enumerated type contains specific values used by IMbnRegistration interface
///operations.
alias MBN_REGISTRATION_CONSTANTS = int;
enum : int
{
    ///The maximum string size of the <i>roamingText</i> parameter in the GetRoamingText method of the IMbnRegistration
    ///interface.
    MBN_ROAMTEXT_LEN             = 0x00000040,
    MBN_CDMA_DEFAULT_PROVIDER_ID = 0x00000000,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_REGISTER_STATE</b> enumerated type indicates the network registration state of a Mobile Broadband device.
alias MBN_REGISTER_STATE = int;
enum : int
{
    ///The device registration state is unknown. This state may be set upon failure of registration mode change
    ///requests.
    MBN_REGISTER_STATE_NONE         = 0x00000000,
    ///The device is not registered and not searching for a provider.
    MBN_REGISTER_STATE_DEREGISTERED = 0x00000001,
    ///The device is not registered and is searching for a provider.
    MBN_REGISTER_STATE_SEARCHING    = 0x00000002,
    ///The device is on a home provider.
    MBN_REGISTER_STATE_HOME         = 0x00000003,
    ///The device is on a roaming provider.
    MBN_REGISTER_STATE_ROAMING      = 0x00000004,
    ///The device is on a roaming partner.
    MBN_REGISTER_STATE_PARTNER      = 0x00000005,
    MBN_REGISTER_STATE_DENIED       = 0x00000006,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_REGISTER_MODE</b> enumerated type indicates the network selection mode of a device.
alias MBN_REGISTER_MODE = int;
enum : int
{
    ///No network selection mode is defined.
    MBN_REGISTER_MODE_NONE      = 0x00000000,
    ///The device automatically selects the network to which to register .
    MBN_REGISTER_MODE_AUTOMATIC = 0x00000001,
    MBN_REGISTER_MODE_MANUAL    = 0x00000002,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_PIN_CONSTANTS</b> enumerated type defines constant values used by the MBN_PIN_INFO structure.
alias MBN_PIN_CONSTANTS = int;
enum : int
{
    ///Indicates that there is no available information available on the number of attempts remaining to enter a valid
    ///PIN.
    MBN_ATTEMPTS_REMAINING_UNKNOWN = 0xffffffff,
    MBN_PIN_LENGTH_UNKNOWN         = 0xffffffff,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_PIN_STATE</b> enumerated type indicates the current PIN state of the Mobile Broadband device.
alias MBN_PIN_STATE = int;
enum : int
{
    ///Indicates that no PIN is currently required. This state can occur when the device does not require a PIN. It can
    ///also occur after repeated PIN entry attempts have exhausted the allowable quota and the device does not allow the
    ///PIN to be unblocked programmatically
    MBN_PIN_STATE_NONE    = 0x00000000,
    ///Indicates that the device is currently locked and requires a PIN to be entered to unlock it The caller can unlock
    ///the device by calling the Enter method of the IMbnPin interface.
    MBN_PIN_STATE_ENTER   = 0x00000001,
    MBN_PIN_STATE_UNBLOCK = 0x00000002,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_PIN_TYPE</b> enumerated type indicates the type of password required for unlocking the information stored
///on the interface.
alias MBN_PIN_TYPE = int;
enum : int
{
    ///Indicates that no PIN is pending to be entered.
    MBN_PIN_TYPE_NONE                 = 0x00000000,
    ///Indicates a custom PIN code.
    MBN_PIN_TYPE_CUSTOM               = 0x00000001,
    ///Indicates a PIN1 code. For CDMA devices, PIN1 represents the power-on device lock code. For GSM devices, PIN1
    ///represents the SIM lock, also referred to as PIN in GSM terminology.
    MBN_PIN_TYPE_PIN1                 = 0x00000002,
    ///Indicates a PIN2 code.
    MBN_PIN_TYPE_PIN2                 = 0x00000003,
    ///Indicates a device to SIM password.
    MBN_PIN_TYPE_DEVICE_SIM_PIN       = 0x00000004,
    ///Indicates a device to very first SIM password.
    MBN_PIN_TYPE_DEVICE_FIRST_SIM_PIN = 0x00000005,
    ///Indicates a network personalization password.
    MBN_PIN_TYPE_NETWORK_PIN          = 0x00000006,
    ///Indicates a network subset personalization password.
    MBN_PIN_TYPE_NETWORK_SUBSET_PIN   = 0x00000007,
    ///Indicates a Service Provider (SP) personalization password.
    MBN_PIN_TYPE_SVC_PROVIDER_PIN     = 0x00000008,
    ///Indicates a corporate personalization password.
    MBN_PIN_TYPE_CORPORATE_PIN        = 0x00000009,
    MBN_PIN_TYPE_SUBSIDY_LOCK         = 0x0000000a,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_PIN_MODE</b> enumerated type indicates if the PIN type is enabled.
alias MBN_PIN_MODE = int;
enum : int
{
    ///The PIN type is currently enabled.
    MBN_PIN_MODE_ENABLED  = 0x00000001,
    MBN_PIN_MODE_DISABLED = 0x00000002,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_PIN_FORMAT</b> enumerated type indicates whether a PIN is numeric or alphanumeric.
alias MBN_PIN_FORMAT = int;
enum : int
{
    ///Indicates that the PIN format is not known.
    MBN_PIN_FORMAT_NONE         = 0x00000000,
    ///Indicates that the PIN is in numeric format. The only allowed characters are 0-9.
    MBN_PIN_FORMAT_NUMERIC      = 0x00000001,
    ///Indicates that the PIN is in alphanumeric format. Allowed characters are a-z, A-Z, 0-9, *, and
    MBN_PIN_FORMAT_ALPHANUMERIC = 0x00000002,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_CONTEXT_CONSTANTS</b> enumerated type specifies the maximum string lengths supported by members of the
///MBN_CONTEXT structure.
alias MBN_CONTEXT_CONSTANTS = int;
enum : int
{
    ///Maximum string length of the <b>accessString</b> member of the MBN_CONTEXT structure.
    MBN_ACCESSSTRING_LEN  = 0x00000064,
    ///Maximum string length of the <b>userName</b> member of the MBN_CONTEXT structure.
    MBN_USERNAME_LEN      = 0x000000ff,
    ///Maximum string length of the <b>password</b> member of the MBN_CONTEXT structure.
    MBN_PASSWORD_LEN      = 0x000000ff,
    MBN_CONTEXT_ID_APPEND = 0xffffffff,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_AUTH_PROTOCOL</b> enumerated type specifies the authentication protocol used for Packet Data Protocol
///(PDP) activation. This type is applicable only for GSM devices.
alias MBN_AUTH_PROTOCOL = int;
enum : int
{
    ///No authentication protocol is used.
    MBN_AUTH_PROTOCOL_NONE     = 0x00000000,
    ///Password Authentication Protocol (PAP) is used for authentication. PAP authentication is unencrypted.
    MBN_AUTH_PROTOCOL_PAP      = 0x00000001,
    ///Challenge Handshake Authentication Protocol (CHAP) is used for authentication.
    MBN_AUTH_PROTOCOL_CHAP     = 0x00000002,
    MBN_AUTH_PROTOCOL_MSCHAPV2 = 0x00000003,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_COMPRESSION</b> enumerated type specifies whether compression is to be used in the data link for header
///and data. This type is applicable only for GSM devices.
alias MBN_COMPRESSION = int;
enum : int
{
    ///Data headers are not compressed.
    MBN_COMPRESSION_NONE   = 0x00000000,
    MBN_COMPRESSION_ENABLE = 0x00000001,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_CONTEXT_TYPE</b> enumerated type specifies the represented context type.
alias MBN_CONTEXT_TYPE = int;
enum : int
{
    ///Context has not yet provisioned for this ID.
    MBN_CONTEXT_TYPE_NONE        = 0x00000000,
    ///Context represents a connection to the internet.
    MBN_CONTEXT_TYPE_INTERNET    = 0x00000001,
    ///Context represents a connection to a VPN or corporate network.
    MBN_CONTEXT_TYPE_VPN         = 0x00000002,
    ///Context represents a connection to VoIP service.
    MBN_CONTEXT_TYPE_VOICE       = 0x00000003,
    ///Context represents a connection to a video share service.
    MBN_CONTEXT_TYPE_VIDEO_SHARE = 0x00000004,
    ///Context represents a connection to a custom service.
    MBN_CONTEXT_TYPE_CUSTOM      = 0x00000005,
    MBN_CONTEXT_TYPE_PURCHASE    = 0x00000006,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_SMS_CONSTANTS</b> enumerated type contains SMS constant values.
alias WWAEXT_SMS_CONSTANTS = int;
enum : int
{
    ///The message is not stored in device memory. This constant is used by IMbnSmsReadMsgPdu and
    ///IMbnSmsReadMsgTextCdma.
    MBN_MESSAGE_INDEX_NONE          = 0x00000000,
    ///The device does not support SMS. This constant is used by IMbnSmsConfiguration.
    MBN_CDMA_SHORT_MSG_SIZE_UNKNOWN = 0x00000000,
    MBN_CDMA_SHORT_MSG_SIZE_MAX     = 0x000000a0,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_MSG_STATUS</b> enumerated type defines the type of message being handled.
alias MBN_MSG_STATUS = int;
enum : int
{
    ///The received message is newly arrived or unread.
    MBN_MSG_STATUS_NEW   = 0x00000000,
    ///The received message is old and read.
    MBN_MSG_STATUS_OLD   = 0x00000001,
    ///The outgoing message is unsent and stored in the device.
    MBN_MSG_STATUS_DRAFT = 0x00000002,
    MBN_MSG_STATUS_SENT  = 0x00000003,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_SMS_CDMA_LANG</b> enumerated type represents the different languages that can be used in a CDMA message.
alias MBN_SMS_CDMA_LANG = int;
enum : int
{
    ///None.
    MBN_SMS_CDMA_LANG_NONE     = 0x00000000,
    ///English.
    MBN_SMS_CDMA_LANG_ENGLISH  = 0x00000001,
    ///French.
    MBN_SMS_CDMA_LANG_FRENCH   = 0x00000002,
    ///Spanish.
    MBN_SMS_CDMA_LANG_SPANISH  = 0x00000003,
    ///Japanese.
    MBN_SMS_CDMA_LANG_JAPANESE = 0x00000004,
    ///Korean.
    MBN_SMS_CDMA_LANG_KOREAN   = 0x00000005,
    ///Chinese.
    MBN_SMS_CDMA_LANG_CHINESE  = 0x00000006,
    MBN_SMS_CDMA_LANG_HEBREW   = 0x00000007,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_SMS_CDMA_ENCODING</b> enumerated type specifies character encoding types for CDMA.
alias MBN_SMS_CDMA_ENCODING = int;
enum : int
{
    ///Octet encoding.
    MBN_SMS_CDMA_ENCODING_OCTET        = 0x00000000,
    ///EPM encoding.
    MBN_SMS_CDMA_ENCODING_EPM          = 0x00000001,
    ///7 bit ASCII encoding.
    MBN_SMS_CDMA_ENCODING_7BIT_ASCII   = 0x00000002,
    ///IA5 encoding.
    MBN_SMS_CDMA_ENCODING_IA5          = 0x00000003,
    ///Unicode encoding.
    MBN_SMS_CDMA_ENCODING_UNICODE      = 0x00000004,
    ///Shift JIS encoding for the Japanese Language.
    MBN_SMS_CDMA_ENCODING_SHIFT_JIS    = 0x00000005,
    ///Korean encoding.
    MBN_SMS_CDMA_ENCODING_KOREAN       = 0x00000006,
    ///Latin Hebrew encoding.
    MBN_SMS_CDMA_ENCODING_LATIN_HEBREW = 0x00000007,
    ///Latin encoding.
    MBN_SMS_CDMA_ENCODING_LATIN        = 0x00000008,
    ///GSM 7 bit encoding.
    MBN_SMS_CDMA_ENCODING_GSM_7BIT     = 0x00000009,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_SMS_FLAG</b> enumerated type specifies the SMS message class. These enumerated values are used in the
///MBN_SMS_FILTER structure.
alias MBN_SMS_FLAG = int;
enum : int
{
    ///Refers to all the messages in the device message store.
    MBN_SMS_FLAG_ALL   = 0x00000000,
    ///Refers to a single message in the device message store.
    MBN_SMS_FLAG_INDEX = 0x00000001,
    ///Refers to all new received and unread messages.
    MBN_SMS_FLAG_NEW   = 0x00000002,
    ///Refers to all old and read messages.
    MBN_SMS_FLAG_OLD   = 0x00000003,
    ///Refers to all sent and saved messages.
    MBN_SMS_FLAG_SENT  = 0x00000004,
    MBN_SMS_FLAG_DRAFT = 0x00000005,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_SMS_STATUS_FLAG</b> enumerated type indicates the status of a device's SMS message store. These enumerated
///values are used in a bitfield by the MBN_SMS_STATUS_INFO structure.
alias MBN_SMS_STATUS_FLAG = int;
enum : int
{
    ///There is no SMS status information to report.
    MBN_SMS_FLAG_NONE               = 0x00000000,
    ///The message store is full.
    MBN_SMS_FLAG_MESSAGE_STORE_FULL = 0x00000001,
    MBN_SMS_FLAG_NEW_MESSAGE        = 0x00000002,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_SMS_FORMAT</b> enumerated type specifies the format of SMS messages.
alias MBN_SMS_FORMAT = int;
enum : int
{
    ///No SMS format.
    MBN_SMS_FORMAT_NONE = 0x00000000,
    ///For GSM devices, SMS, messages will be read in PDU format. For CDMA devices, SMS messages will be read in binary
    ///CDMA format.
    MBN_SMS_FORMAT_PDU  = 0x00000001,
    MBN_SMS_FORMAT_TEXT = 0x00000002,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The MBN_RADIO enumerated type indicates whether the device radio is on or off.
alias MBN_RADIO = int;
enum : int
{
    ///The device radio is off.
    MBN_RADIO_OFF = 0x00000000,
    MBN_RADIO_ON  = 0x00000001,
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_DEVICE_SERVICES_INTERFACE_STATE</b> structure provides information about the state of device services
///capable Mobile Broadband devices.
alias MBN_DEVICE_SERVICES_INTERFACE_STATE = int;
enum : int
{
    ///A Mobile Broadband device capable of supporting device service functionality has arrived.
    MBN_DEVICE_SERVICES_CAPABLE_INTERFACE_ARRIVAL = 0x00000000,
    ///A Mobile Broadband device capable of supporting device services functionality has been removed.
    MBN_DEVICE_SERVICES_CAPABLE_INTERFACE_REMOVAL = 0x00000001,
}

// Callbacks

alias LPMAPILOGON = uint function();
alias LPMAPILOGOFF = uint function();
alias LPMAPISENDMAIL = uint function();
alias LPMAPISENDMAILW = uint function();
alias LPMAPISENDDOCUMENTS = uint function();
alias LPMAPIFINDNEXT = uint function();
alias LPMAPIREADMAIL = uint function();
alias LPMAPISAVEMAIL = uint function();
alias LPMAPIDELETEMAIL = uint function();
alias LPMAPIFREEBUFFER = uint function(void* pv);
alias LPMAPIADDRESS = uint function();
alias LPMAPIDETAILS = uint function();
alias LPMAPIRESOLVENAME = uint function();

// Structs


///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_INTERFACE_CAPS</b> structure represents the interface capabilities. This structure is returned by the
///GetInterfaceCapability method of IMbnInterface.
struct MBN_INTERFACE_CAPS
{
    ///An MBN_CELLULAR_CLASS value that specifies the cellular technology used by the device.
    MBN_CELLULAR_CLASS cellularClass;
    ///An MBN_VOICE_CLASS value that specifies how voice calls are handled.
    MBN_VOICE_CLASS    voiceClass;
    ///A bitwise OR combination of MBN_DATA_CLASS values that specifies which data services are supported. For GSM
    ///devices, only the GSM-based data services can be present, that is, only GPRS, EDGE, UMTS, LTE, and HSDPA are
    ///valid values for GSM devices. For CDMA devices, only the CDMA-related data services will be present, that is,
    ///only 1xRTT, 1xEV-DO, and 1xEV-DO RevA are valid values for CDMA devices. 1xEV-DO RevB is reserved for future use.
    ///This field has the bit value <b>MBN_DATA_CLASS_CUSTOM</b> set if the data class some other data class which is
    ///not defined in the enumeration is also supported by device. If <b>MBN_DATA_CLASS_CUSTOM</b> is set then
    ///information regarding custom data class is available in <i>customDataClass</i> field.
    uint               dataClass;
    ///Contains the name of the custom data class. If the <b>MBN_DATA_CLASS_CUSTOM</b> bit of <b>dataClass</b> is not
    ///set, then the string is <b>NULL</b>. Otherwise, the caller must free this string by calling SysFreeString.
    BSTR               customDataClass;
    ///A bit field that specifies the frequency bands supported by the GSM device. <b>MBN_BAND_CLASS_I</b> through
    ///<b>MBN_BAND_CLASS_X</b> and <b>MBN_BAND_CLASS_CUSTOM</b> are valid values. These values are defined by
    ///MBN_BAND_CLASS. If <b>gsmBandClass</b> is set to <b>MBN_BAND_CLASS_CUSTOM</b>, additional information about the
    ///band class appears in <b>customBandClass</b>. The following table provides additional information about the
    ///MBN_BAND_CLASS values. <table> <tr> <th>MBN_BAND_CLASS Value</th> <th>Designated spectrum</th> <th>Industry
    ///name</th> <th>Uplink (MS to BTS)</th> <th>Downlink (BTS to MS)</th> <th>Regions</th> </tr> <tr>
    ///<td><b>MBN_BAND_CLASS_I</b></td> <td>UMTS2100</td> <td>IMT</td> <td>1920-1980</td> <td>2110-2170</td> <td>Europe,
    ///Korea, Japan China</td> </tr> <tr> <td><b>MBN_BAND_CLASS_II</b></td> <td>UMT21900</td> <td>PCS1900</td>
    ///<td>1850-1910</td> <td>1930-1990</td> <td>North America, Latin America</td> </tr> <tr>
    ///<td><b>MBN_BAND_CLASS_III</b></td> <td>UMTS1800</td> <td>DCS1800</td> <td>1710-1785</td> <td>1805-1880</td>
    ///<td>Europe, China</td> </tr> <tr> <td><b>MBN_BAND_CLASS_IV</b></td> <td>AWS</td> <td>AWS, 1.7/2.1</td>
    ///<td>1710-1785</td> <td>2110-2155</td> <td>North America, Latin America</td> </tr> <tr>
    ///<td><b>MBN_BAND_CLASS_V</b></td> <td>UMTS850</td> <td>GSM850</td> <td>824-849</td> <td>869-894</td> <td>North
    ///America, Latin America</td> </tr> <tr> <td><b>MBN_BAND_CLASS_VI</b></td> <td>UMTS800</td> <td>UMTS800</td>
    ///<td>830-840</td> <td>875-885</td> <td>Japan</td> </tr> <tr> <td><b>MBN_BAND_CLASS_VII</b></td> <td>UMTS2600</td>
    ///<td>UMTS2600</td> <td>2500-2570</td> <td>2620-2690</td> <td>Europe</td> </tr> <tr>
    ///<td><b>MBN_BAND_CLASS_VIII</b></td> <td>UMTS900</td> <td>EGSM900</td> <td>880-915</td> <td>925-960</td>
    ///<td>Europe, China</td> </tr> <tr> <td><b>MBN_BAND_CLASS_IX</b></td> <td>UMTS1700</td> <td>UMTS1700</td>
    ///<td>1750-1770</td> <td>1845-1880</td> <td>Japan</td> </tr> <tr> <td><b>MBN_BAND_CLASS_X</b></td> <td></td>
    ///<td></td> <td>1710-1770</td> <td>2110-2170</td> <td></td> </tr> </table>
    uint               gsmBandClass;
    ///A bit field that specifies the frequency bands supported by the CDMA device. <b>MBN_BAND_CLASS_0</b> through
    ///<b>MBN_BAND_CLASS_XVII</b>, <b>MBN_BAND_CLASS_NONE</b>, and <b>MBN_BAND_CLASS_CUSTOM</b> are valid values. These
    ///values are defined by MBN_BAND_CLASS. If <b>cdmaBandClass</b> is set to <b>MBN_BAND_CLASS_CUSTOM</b>, additional
    ///information about the band class appears in <b>customBandClass</b>. The following table provides additional
    ///information about MBN_BAND_CLASS values. <table> <tr> <th>MBN_BAND_CLASS Value</th> <th>Industry Name</th>
    ///<th>Uplink (MS to BTS)</th> <th>Downlink (BTS to MS)</th> </tr> <tr> <td><b>MBN_BAND_CLASS_0</b></td> <td>800MHx
    ///Cellular</td> <td>824.025.844.995</td> <td>869.025.889.995</td> </tr> <tr> <td><b>MBN_BAND_CLASS_I</b></td>
    ///<td>1900MHz Band</td> <td>1850-1910</td> <td>1930-1990</td> </tr> <tr> <td><b>MBN_BAND_CLASS_II</b></td> <td>TACS
    ///Band</td> <td>872.025.914.9875</td> <td>917.0125.959.9875</td> </tr> <tr> <td><b>MBN_BAND_CLASS_III</b></td>
    ///<td>JTACS Band</td> <td>887.0125.924.9875</td> <td>832.0125.869.9875</td> </tr> <tr>
    ///<td><b>MBN_BAND_CLASS_IV</b></td> <td>Korean PCS Band</td> <td>1750-1780</td> <td>1840-1870</td> </tr> <tr>
    ///<td><b>MBN_BAND_CLASS_V</b></td> <td>450 MHz Band</td> <td>410-483.475</td> <td>420-493.475</td> </tr> <tr>
    ///<td><b>MBN_BAND_CLASS_VI</b></td> <td>2 GHz Band</td> <td>1920-1979.950</td> <td>2110-2169.950</td> </tr> <tr>
    ///<td><b>MBN_BAND_CLASS_VII</b></td> <td>700 MHz Band</td> <td>776-794</td> <td>746-764</td> </tr> <tr>
    ///<td><b>MBN_BAND_CLASS_VIII</b></td> <td>1800 MHz Band</td> <td>1710-1784.950</td> <td>1805-1879.95</td> </tr>
    ///<tr> <td><b>MBN_BAND_CLASS_IX</b></td> <td>900 MHz Band</td> <td>880-914-950</td> <td>925-959.950</td> </tr> <tr>
    ///<td><b>MBN_BAND_CLASS_X</b></td> <td>Secondary 800 MHz Band</td> <td>806-900.975</td> <td>851-939.975</td> </tr>
    ///<tr> <td><b>MBN_BAND_CLASS_XI</b></td> <td>400 MHz European PAMR Band</td> <td>410-483.475</td>
    ///<td>420-493.475</td> </tr> <tr> <td><b>MBN_BAND_CLASS_XII</b></td> <td>800 MHz PAMR Band</td>
    ///<td>870.125-875.9875</td> <td>915.0125-920.9875</td> </tr> <tr> <td><b>MBN_BAND_CLASS_XIII</b></td> <td>2.5 GHz
    ///IMT200 Extension Band</td> <td>2500-2570</td> <td>2620-2690</td> </tr> <tr> <td><b>MBN_BAND_CLASS_XIV</b></td>
    ///<td>US PCS 1.9 GHz Band</td> <td>1850-1915</td> <td>1930-1995</td> </tr> <tr> <td><b>MBN_BAND_CLASS_XV</b></td>
    ///<td>AWS Band</td> <td>1710-1755</td> <td>2110-2155</td> </tr> <tr> <td><b>MBN_BAND_CLASS_XVI</b></td> <td>US 2.5
    ///GHz Band</td> <td>2502-2568</td> <td>2624-2690</td> </tr> <tr> <td><b>MBN_BAND_CLASS_XVII</b></td> <td>US 2.5 GHz
    ///Forward Link Only Band</td> <td></td> <td>2624-2690</td> </tr> </table>
    uint               cdmaBandClass;
    ///Contains the name of the custom band class. If the <b>MBN_BAND_CLASS_CUSTOM</b> bit of <b>cdmaBandClass</b> and
    ///<b>gsmBandClass</b> is not set, then the string is <b>NULL</b>. Otherwise, the caller must free this string by
    ///calling SysFreeString.
    BSTR               customBandClass;
    ///A bitwise OR combination of MBN_SMS_CAPS values that specifies the SMS capabilities.
    uint               smsCaps;
    ///A bitwise OR combination of MBN_CTRL_CAPS values that represents the Mobile Broadband control capabilities for
    ///this interface.
    uint               controlCaps;
    ///Contains the device ID. For GSM devices, this must be the IMEI (up to 15 digits). For CDMA devices, this must be
    ///the ESN (11 digits) / MEID (17 digits). The maximum length of the string is <b>MBN_DEVICEID_LEN</b>. For the
    ///definition of <b>MBN_DEVICEID_LEN</b>, see MBN_INTERFACE_CAPS_CONSTANTS. The caller must free this string by
    ///calling SysFreeString.
    BSTR               deviceID;
    ///Contains the name of the device manufacturer. This string can be empty. The maximum length of the string is
    ///<b>MBN_MANUFACTURER_LEN</b>. For the definition of <b>MBN_MANUFACTURER_LEN</b>, see MBN_INTERFACE_CAPS_CONSTANTS.
    ///The caller must free this string by calling SysFreeString.
    BSTR               manufacturer;
    ///Contains the device model. This string can be empty. The maximum length of this string is <b>MBN_MODEL_LEN</b>.
    ///For the definition of <b>MBN_MODEL_LEN</b>, see MBN_INTERFACE_CAPS_CONSTANTS. The caller must free this string by
    ///calling SysFreeString.
    BSTR               model;
    BSTR               firmwareInfo;
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_PROVIDER</b> structure represents a network service provider. It is used by many of the provider-specific
///methods of IMbnInterface.
struct MBN_PROVIDER
{
    ///Contains the provider ID. For GSM networks, this string is a concatenation of a 3-digit mobile country code (MCC)
    ///and a 2- or 3-digit mobile network code (MNC). For CDMA networks, this string is a 5-digit SID. The maximum
    ///length of this string is defined by <b>MBN_PROVIDERID_LEN</b> from MBN_PROVIDER_CONSTANTS. The caller must free
    ///this string by calling SysFreeString.
    BSTR providerID;
    ///Contains a bitwise OR combination of MBN_PROVIDER_STATE values that represent the provider state.
    uint providerState;
    ///Contains the provider name. The contents of this member should be ignored when setting the preferred provider
    ///list. The maximum length of this string is defined by <b>MBN_PROVIDERNAME_LEN</b> from MBN_PROVIDER_CONSTANTS.
    ///The string can be empty. The caller must free this string by calling SysFreeString.
    BSTR providerName;
    ///Contains a bitwise OR combination of MBN_DATA_CLASS values that indicate which data services are applicable or
    ///available for transfer. This member should be ignored when queried for the home provider.
    uint dataClass;
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_PROVIDER2</b> structure represents a network service provider. It is used by many of the provider-specific
///methods of the IMbnMultiCarrier interface and provides an extension to MBN_PROVIDER to support multi-carrier. This
///extension contains the signal strength of each provider, which helps to determine which provider a user should
///connect to.
struct MBN_PROVIDER2
{
    ///Contains a single-carrier MBN_PROVIDER structure.
    MBN_PROVIDER       provider;
    ///Contains a MBN_CELLULAR_CLASS that specifies which cellular class the provider uses.
    MBN_CELLULAR_CLASS cellularClass;
    ///Contains the signal quality received by the device as defined by GetSignalStrength.
    uint               signalStrength;
    ///Contains the signal error rate as defined by GetSignalError.
    uint               signalError;
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_PIN_INFO</b> structure represents the current PIN state of the device. It indicates if some PIN is
///expected by the device and the PIN type expected. Optionally, it also conveys remaining allowed attempts to enter a
///valid PIN. This structure can be obtained by either calling the GetPinState method of IMbnPinManager or supplied as
///an input parameter to the OnEnterComplete method of IMbnPinEvents.
struct MBN_PIN_INFO
{
    ///An MBN_PIN_STATE value that indicates the current PIN state of the device.
    MBN_PIN_STATE pinState;
    ///An MBN_PIN_TYPE value that indicates the type of PIN expected. This field is valid only when <b>pinState</b> is
    ///either <b>MBN_PIN_STATE_ENTER</b> or <b>MBN_PIN_STATE_UNBLOCK</b>.
    MBN_PIN_TYPE  pinType;
    uint          attemptsRemaining;
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_CONTEXT</b> structure stores information about the connection context.
struct MBN_CONTEXT
{
    ///Contains the unique identifier for this context. This represents the context index in the device or SIM memory.
    ///If it is set to <b>MBN_CONTEXT_ID_APPEND</b>, then the device will find the appropriate index to store the
    ///context.
    uint              contextID;
    ///An MBN_CONTEXT_TYPE value that specifies the context type. An application can use this member to modify the
    ///context stored at a particular index using the SetProvisionedContext method of IMbnConnectionContext.
    MBN_CONTEXT_TYPE  contextType;
    ///Contains connection-specific access information. In GSM networks, this would be an access point name (APN) such
    ///as "data.thephone-company.com". In CDMA networks, this might be a special dial code such as "
    BSTR              accessString;
    ///Contains the user name that is used for authentication. The string must not exceed <b>MBN_USERNAME_LEN</b>
    ///characters. The calling application must free this string by calling SysFreeString. For the definition of
    ///<b>MBN_USERNAME_LEN</b>, see MBN_CONTEXT_CONSTANTS. The calling application must free this string by calling
    ///SysFreeString.
    BSTR              userName;
    ///Contains the password that is used for authentication. The string must not exceed <b>MBN_PASSWORD_LEN</b>
    ///characters. This string can be empty. For the definition of <b>MBN_PASSWORD_LEN</b>, see MBN_CONTEXT_CONSTANTS.
    ///The calling application must free this string by calling SysFreeString.
    BSTR              password;
    ///An MBN_COMPRESSION value that specifies whether compression is used in the data link for header and data. This
    ///member is applicable only for GSM devices.
    MBN_COMPRESSION   compression;
    MBN_AUTH_PROTOCOL authType;
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_SMS_FILTER</b> structure contains the values that describe a set of SMS messages.
struct MBN_SMS_FILTER
{
    ///An MBN_SMS_FLAG value that specifies the message class.
    MBN_SMS_FLAG flag;
    uint         messageIndex;
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_SMS_STATUS_INFO</b> structure contains the status of the SMS message store of a device.
struct MBN_SMS_STATUS_INFO
{
    ///A bitwise OR combination of MBN_SMS_STATUS_FLAG values that specify the state of the message store.
    uint flag;
    uint messageIndex;
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>MBN_DEVICE_SERVICE</b> structure provides information about a Mobile Broadband device service
struct MBN_DEVICE_SERVICE
{
    ///A string that represents the unique ID of a Mobile Broadband device service. This matches the Device Service UUID
    ///reported by the Mobile Broadband device.
    BSTR  deviceServiceID;
    ///if <b>TRUE</b>, this device service supports write on bulk data sessions. Otherwise, <b>FALSE</b>.
    short dataWriteSupported;
    ///if <b>TRUE</b>, this device service supports read on bulk data sessions. Otherwise, <b>FALSE</b>.
    short dataReadSupported;
}

// Interfaces

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Represents the network connectivity of a device.
@GUID("DCBBBAB6-200D-4BBB-AAEE-338E368AF6FA")
interface IMbnConnection : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the unique identifier for the connection. This property is read-only.
    HRESULT get_ConnectionID(BSTR* ConnectionID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the interface identifier. This property is read-only.
    HRESULT get_InterfaceID(BSTR* InterfaceID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Establishes a data connection.
    ///Params:
    ///    connectionMode = An MBN_CONNECTION_MODE value that specifies the mode of the connection.
    ///    strProfile = Contains the profile designator.
    ///    requestID = A pointer to a unique request ID returned by the Mobile Broadband service to identify this asynchronous
    ///                request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl> </td> <td
    ///    width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most likely the Mobile
    ///    Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most
    ///    likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid profile name was specified or the
    ///    <i>strProfile</i> argument is not compliant to XML profile schema </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_MAX_ACTIVATED_CONTEXTS</b></dt> </dl> </td> <td width="60%"> There is already an active Mobile
    ///    Broadband context. Multiple active contexts are not supported. </td> </tr> </table>
    ///    
    HRESULT Connect(MBN_CONNECTION_MODE connectionMode, const(PWSTR) strProfile, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Disconnects a data connection.
    ///Params:
    ///    requestID = A pointer to a unique request ID assigned by the Mobile Broadband service to identify this asynchronous
    ///                request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td
    ///    width="60%"> The connection has already been disconnected. </td> </tr> </table>
    ///    
    HRESULT Disconnect(uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the current connection state of the device.
    ///Params:
    ///    ConnectionState = A pointer to an MBN_ACTIVATION_STATE structure that contains the state of the connection.
    ///    ProfileName = A pointer to a string that contains the name of the connection profile. This parameter is valid only when
    ///                  <i>ConnectionState</i> is <b>MBN_ACTIVATION_STATE_ACTIVATED</b>. When this string is not <b>NULL</b>, the
    ///                  calling application must free this string by calling SysFreeString.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    <div class="alert"><b>Note</b> This method can return S_OK when <i>ProfileName</i> is <b>NULL</b>. Make sure
    ///    that your client is capable of handling a <b>NULL</b> <i>ProfileName</i> even if the call is
    ///    successful.</div> <div> </div> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td>
    ///    <td width="60%"> The activation state not available. The Mobile Broadband service is probing the device for
    ///    the information. The calling application can be notified when the activation state is available by
    ///    registering for the OnConnectStateChange method of IMbnConnectionEvents. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is required to get the call state.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> A
    ///    SIM is not inserted in the device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl>
    ///    </td> <td width="60%"> A bad SIM is inserted in the device. </td> </tr> </table>
    ///    
    HRESULT GetConnectionState(MBN_ACTIVATION_STATE* ConnectionState, BSTR* ProfileName);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the voice call state of the device.
    ///Params:
    ///    voiceCallState = A pointer to a MBN_VOICE_CALL_STATE value that specifies the voice call state. If the method returns anything
    ///                     other than <b>S_OK</b>, the contents of this pointer are not set.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The call state
    ///    not available. The Mobile Broadband service is probing the device for the information. The calling
    ///    application can be notified when the call state is available by registering for the OnVoiceCallStateChange
    ///    method of IMbnConnectionEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt>
    ///    </dl> </td> <td width="60%"> A PIN is required to get the call state. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> A SIM is not inserted in the device.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM
    ///    is inserted in the device. </td> </tr> </table>
    ///    
    HRESULT GetVoiceCallState(MBN_VOICE_CALL_STATE* voiceCallState);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the network error returned in a Packet Data Protocol (PDP) context activation failure.
    ///Params:
    ///    networkError = The error code returned by the network from the last connection context activation operation. The value is
    ///                   meaningful only if the method returns <b>S_OK</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetActivationNetworkError(uint* networkError);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This notification interface signals an application about change and completion status of asynchronous connection
///requests.
@GUID("DCBBBAB6-200E-4BBB-AAEE-338E368AF6FA")
interface IMbnConnectionEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that signals the completion of a connection operation.
    ///Params:
    ///    newConnection = An IMbnConnection interface that represents the device on which the connection operation has completed.
    ///    requestID = The request ID assigned by the Mobile Broadband service to identify the connection operation.
    ///    status = The completion status. A calling application can expect one of the following values. <table> <tr>
    ///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a id="s_ok"></a><dl>
    ///             <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td
    ///             width="40%"><a id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a id="e_mbn_pin_required"></a><dl>
    ///             <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is required for the operation to
    ///             complete. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SERVICE_NOT_ACTIVATED"></a><a
    ///             id="e_mbn_service_not_activated"></a><dl> <dt><b>E_MBN_SERVICE_NOT_ACTIVATED</b></dt> </dl> </td> <td
    ///             width="60%"> The network service subscription has expired. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_PROVIDER_NOT_VISIBLE"></a><a id="e_mbn_provider_not_visible"></a><dl>
    ///             <dt><b>E_MBN_PROVIDER_NOT_VISIBLE</b></dt> </dl> </td> <td width="60%"> The provider is not visible. This
    ///             applies only to manual registration mode. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_INVALID_ACCESS_STRING"></a><a id="e_mbn_invalid_access_string"></a><dl>
    ///             <dt><b>E_MBN_INVALID_ACCESS_STRING</b></dt> </dl> </td> <td width="60%"> The connection access string is not
    ///             correct. </td> </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_INVALID_PASSWORD_"></a><a
    ///             id="hresult_from_win32_error_invalid_password_"></a><dl>
    ///             <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_PASSWORD)</b></dt> </dl> </td> <td width="60%"> The name or password
    ///             using in the connection profile is not correct. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_VOICE_CALL_IN_PROGRESS"></a><a id="e_mbn_voice_call_in_progress"></a><dl>
    ///             <dt><b>E_MBN_VOICE_CALL_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> An active voice call is in
    ///             progress. </td> </tr> <tr> <td width="40%"><a id="E_MBN_MAX_ACTIVATED_CONTEXTS"></a><a
    ///             id="e_mbn_max_activated_contexts"></a><dl> <dt><b>E_MBN_MAX_ACTIVATED_CONTEXTS</b></dt> </dl> </td> <td
    ///             width="60%"> There is already an Mobile Broadband context active. The Mobile Broadband service does not
    ///             currently support multiple active contexts. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_RADIO_POWER_OFF"></a><a id="e_mbn_radio_power_off"></a><dl> <dt><b>E_MBN_RADIO_POWER_OFF</b></dt>
    ///             </dl> </td> <td width="60%"> The device radio is off. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_PACKET_SVC_DETACHED"></a><a id="e_mbn_packet_svc_detached"></a><dl>
    ///             <dt><b>E_MBN_PACKET_SVC_DETACHED</b></dt> </dl> </td> <td width="60%"> No active attached packet service is
    ///             available. </td> </tr> <tr> <td width="40%"><a id="E_MBN_ACTIVE_CONNECTION"></a><a
    ///             id="e_mbn_active_connection"></a><dl> <dt><b>E_MBN_ACTIVE_CONNECTION</b></dt> </dl> </td> <td width="60%">
    ///             The device is already connected to the network. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnConnectComplete(IMbnConnection newConnection, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that indicates that a disconnection operation has been performed.
    ///Params:
    ///    newConnection = An IMbnConnection interface that represents the connection that has been disconnected.
    ///    requestID = The request ID assigned by the Mobile Broadband service to identify the disconnection operation.
    ///    status = The operation completion status. This can only be <b>S_OK</b>.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnDisconnectComplete(IMbnConnection newConnection, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that indicates whether the connection state of the device has changed.
    ///Params:
    ///    newConnection = An IMbnConnection interface that represents the connection on which the state has changed due to a system or
    ///                    network initiated change.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnConnectStateChange(IMbnConnection newConnection);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that indicates a change in the voice call state of a device.
    ///Params:
    ///    newConnection = An IMbnConnection interface that represents the connection for which the voice call state has changed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnVoiceCallStateChange(IMbnConnection newConnection);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Represents a Mobile Broadband device. The properties and methods of <b>IMbnInterface</b> return the state of the
///device. Applications should register for change event notifications by implementing IMbnInterfaceEvents.
@GUID("DCBBBAB6-2001-4BBB-AAEE-338E368AF6FA")
interface IMbnInterface : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The interface ID. This property is read-only.
    HRESULT get_InterfaceID(BSTR* InterfaceID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the capabilities of the device.
    ///Params:
    ///    interfaceCaps = A pointer to an MBN_INTERFACE_CAPS structure that contains the interface capabilities. If this method returns
    ///                    any value other than <b>S_OK</b>, this parameter is <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    <i>interfaceCaps</i> contains valid values. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt>
    ///    </dl> </td> <td width="60%"> The information is not available. The Mobile Broadband service is currently
    ///    probing for the device capabilities. The calling application can get notified when the device capabilities
    ///    are available by registering for the OnInterfaceCapabilityAvailable method of IMbnInterfaceEvents. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetInterfaceCapability(MBN_INTERFACE_CAPS* interfaceCaps);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the subscriber information.
    ///Params:
    ///    subscriberInformation = A pointer to the address of an IMbnSubscriberInformation interface that contains subscriber information for
    ///                            the device. If this method returns any value other than <b>S_OK</b>, this parameter is <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    <i>subscriberInformation</i> contains a valid interface. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The information is not available. The Mobile Broadband
    ///    service is currently probing for the information. The calling application can get notified when the
    ///    information is available by registering for the OnSubscriberInformationChange method of IMbnInterfaceEvents.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSubscriberInformation(IMbnSubscriberInformation* subscriberInformation);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the ready state.
    ///Params:
    ///    readyState = A pointer to an MBN_READY_STATE structure. If this method returns any value other than <b>S_OK</b>, this
    ///                 parameter is <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    <i>readyState</i> contains valid values. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt>
    ///    </dl> </td> <td width="60%"> The information is not available. The Mobile Broadband service is currently
    ///    probing for the ready state. The calling application can get notified when the ready state is available by
    ///    registering for the OnReadyStateChange method of IMbnInterfaceEvents. </td> </tr> </table>
    ///    
    HRESULT GetReadyState(MBN_READY_STATE* readyState);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Determines whether the device is in emergency mode.
    ///Params:
    ///    emergencyMode = Points to VARIANT_TRUE if the device is in emergency mode, and VARIANT_FALSE if it is not.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The information
    ///    is not available. The Mobile Broadband service is currently probing for this information. The calling
    ///    application can be notified when the data is available by registering for the OnEmergencyModeChange method of
    ///    IMbnInterfaceEvents. </td> </tr> </table>
    ///    
    HRESULT InEmergencyMode(short* emergencyMode);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the home provider.
    ///Params:
    ///    homeProvider = A pointer to an MBN_PROVIDER structure that represents the home provider. If this method returns any value
    ///                   other than <b>S_OK</b>, this parameter is <b>NULL</b>. Upon completion, the calling application must free the
    ///                   memory allocated to the <b>providerID</b> and <b>providerName</b> members of <b>MBN_PROVIDER</b> by calling
    ///                   SysFreeString
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    <i>homeProvider</i> contains valid values. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt>
    ///    </dl> </td> <td width="60%"> The information is not available. The Mobile Broadband service is currently
    ///    probing to get the home provider. The calling application can get notified when the home provider is
    ///    available by registering for the OnHomeProviderAvailable method of IMbnInterfaceEvents. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> The device requires that a
    ///    PIN must be entered for this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> The SIM is not inserted. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM is inserted in the
    ///    device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_READ_FAULT)</b></dt> </dl>
    ///    </td> <td width="60%"> Unable to read from the SIM or device memory. For example, the SIM does not have home
    ///    provider information provisioned. </td> </tr> </table>
    ///    
    HRESULT GetHomeProvider(MBN_PROVIDER* homeProvider);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the list of preferred providers.
    ///Params:
    ///    preferredProviders = Pointer to an array of MBN_PROVIDER structures that contains the list of preferred providers. If this method
    ///                         returns any value other than <b>S_OK</b>, this parameter is <b>NULL</b>. When <b>GetPreferredProviders</b>
    ///                         returns <b>S_OK</b>, the calling application must free the allocated memory by calling SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    <i>preferredProviders</i> contains valid values. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The information is not available. The Mobile Broadband
    ///    service is currently probing for the list of preferred providers. The calling application can get notified
    ///    when the data is available by registering for the OnPreferredProvidersChange method of IMbnInterfaceEvents.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> The
    ///    device requires that a PIN must be entered for this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> The SIM is not inserted. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM is inserted in the
    ///    device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_READ_FAULT)</b></dt> </dl>
    ///    </td> <td width="60%"> Unable to read from the SIM or device memory. For example, the SIM does not have
    ///    preferred provider information provisioned. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The device does not
    ///    support this operation. CDMA devices will always return this value. </td> </tr> </table>
    ///    
    HRESULT GetPreferredProviders(SAFEARRAY** preferredProviders);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Updates the preferred providers list for the device.
    ///Params:
    ///    preferredProviders = An array of MBN_PROVIDER structures that contains the list of preferred providers.
    ///    requestID = Pointer to the request ID set by the operating system for this request. The asynchronous response will
    ///                contain this same <i>requestID</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid, most likely
    ///    because the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely because the Mobile Broadband device has been removed from the system. </td> </tr> </table>
    ///    
    HRESULT SetPreferredProviders(SAFEARRAY* preferredProviders, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the list of visible providers.
    ///Params:
    ///    age = A pointer to the time in seconds since the last refresh of the visible provider list from the device.
    ///    visibleProviders = Pointer to an array of MBN_PROVIDER structures that contains the list of providers for the interface. If this
    ///                       method returns any value other than <b>S_OK</b>, this parameter is <b>NULL</b>. Otherwise, upon completion,
    ///                       the calling program must free the allocated memory by calling SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    <i>visibleProviders</i> contains valid values. Based on the age of the information, the calling application
    ///    can decide to issue a new call to ScanNetwork. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The information is not available. An active network
    ///    scan is in progress. The calling application can get notified when the device capabilities are available by
    ///    registering for the OnScanNetworkComplete method of IMbnInterfaceEvents. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_MBN_INVALID_CACHE</b></dt> </dl> </td> <td width="60%"> Mobile Broadband's cache of the visible
    ///    network list is invalid. The calling application should call ScanNetwork to populate the cache. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetVisibleProviders(uint* age, SAFEARRAY** visibleProviders);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Asynchronously scans the network to get a list of visible providers.
    ///Params:
    ///    requestID = Pointer to the request ID set by the operating system for this request. The asynchronous response will
    ///                contain this same <i>requestID</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid. Most likely
    ///    because the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely because the Mobile Broadband device has been removed from the system. </td> </tr> </table>
    ///    
    HRESULT ScanNetwork(uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the IMbnConnection object associated with this interface.
    ///Params:
    ///    mbnConnection = The IMbnConnection object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    <i>mbnConnection</i> contains a valid object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Either there is no available
    ///    connection or the device is not registered to a network. </td> </tr> </table>
    ///    
    HRESULT GetConnection(IMbnConnection* mbnConnection);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This interface is a notification interface used to handle asynchronous IMbnInterface method calls as well as changes
///in the device state.
@GUID("DCBBBAB6-2002-4BBB-AAEE-338E368AF6FA")
interface IMbnInterfaceEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate that interface
    ///capability information is available.
    ///Params:
    ///    newInterface = An IMbnInterface whose capability information has become available.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnInterfaceCapabilityAvailable(IMbnInterface newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate that the subscriber
    ///information for the device has changed.
    ///Params:
    ///    newInterface = An IMbnInterface that represents a device on which the subscriber information has changed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSubscriberInformationChange(IMbnInterface newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate a change in an
    ///interface's ready state.
    ///Params:
    ///    newInterface = An IMbnInterface that represents the Mobile Broadband device whose ready state has changed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnReadyStateChange(IMbnInterface newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate that the emergency mode
    ///has changed.
    ///Params:
    ///    newInterface = An IMbnInterface that represents the device whose emergency mode has changed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnEmergencyModeChange(IMbnInterface newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate that home provider
    ///information for the device is available.
    ///Params:
    ///    newInterface = An IMbnInterface that represents the device whose home provider information has become available.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnHomeProviderAvailable(IMbnInterface newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate a change in a device's
    ///preferred provider list.
    ///Params:
    ///    newInterface = An IMbnInterface that represents the Mobile Broadband device whose preferred provider list has changed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnPreferredProvidersChange(IMbnInterface newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate the completion of a
    ///SetPreferredProviders operation.
    ///Params:
    ///    newInterface = An IMbnInterface that represents a device on which this operation was performed.
    ///    requestID = The request ID assigned by the Mobile Broadband service for this asynchronous operation.
    ///    status = The operation completion status. The following table lists the valid values for this status. <table> <tr>
    ///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a id="s_ok"></a><dl>
    ///             <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td
    ///             width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a id="e_mbn_pin_required"></a><dl>
    ///             <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> The device requires a PIN to be entered for
    ///             this operation to complete. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SIM_NOT_INSERTED"></a><a
    ///             id="e_mbn_sim_not_inserted"></a><dl> <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> The
    ///             SIM is not inserted. </td> </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a
    ///             id="e_mbn_bad_sim"></a><dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM is inserted
    ///             in the device. </td> </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The device does not support this operation. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSetPreferredProvidersComplete(IMbnInterface newInterface, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate the completion of a
    ///network scan.
    ///Params:
    ///    newInterface = An IMbnInterface that represents a device on which this operation was performed.
    ///    requestID = The request ID assigned by the Mobile Broadband service for this notification.
    ///    status = The operation completion status A calling application can expect one of the following values. **S_OK** The
    ///             operation was successful. **E_MBN_RADIO_POWER_OFF** Can't get a visible network list because the device radio
    ///             is off. The application can issue a network scan request when it gets the radio-turned-on notification.
    ///             **E_MBN_DEVICE_BUSY** The device is busy and can't currently perform a network scan operation. This is
    ///             returned by devices which don't support a network scan operation when it has a data connection established.
    ///             **E_MBN_ALREADY_ACTIVE** A network scan operation is already in progress.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnScanNetworkComplete(IMbnInterface newInterface, uint requestID, HRESULT status);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Provides access to IMbnInterface objects and notifications.
@GUID("DCBBBAB6-201B-4BBB-AAEE-338E368AF6FA")
interface IMbnInterfaceManager : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets a specific interface.
    ///Params:
    ///    interfaceID = A string that contains the ID of the interface to retrieve.
    ///    mbnInterface = Pointer to the address of the IMbnInterface specified by <i>interfaceID</i> or <b>NULL</b> if there is no
    ///                   matching interface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td
    ///    width="60%"> There is no available interface matching the specified interface ID. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>mbnInterface</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Could not allocate the required memory. </td> </tr> </table>
    ///    
    HRESULT GetInterface(const(PWSTR) interfaceID, IMbnInterface* mbnInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets a list of all available IMbnInterface objects.
    ///Params:
    ///    mbnInterfaces = An array of IMbnInterface interfaces that are associated with the device. If this method returns anything
    ///                    other than <b>S_OK</b>, then this is <b>NULL</b>. Otherwise the calling application must free the allocated
    ///                    memory by calling SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>mbnInterfaces</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Could not allocate the required memory. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetInterfaces(SAFEARRAY** mbnInterfaces);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This notification interface signals an application about the arrival and removal of devices in the system.
@GUID("DCBBBAB6-201C-4BBB-AAEE-338E368AF6FA")
interface IMbnInterfaceManagerEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that signals that a device has been added to the system.
    ///Params:
    ///    newInterface = An IMbnInterface that represents the new device.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnInterfaceArrival(IMbnInterface newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that signals that a device has been removed from the system.
    ///Params:
    ///    oldInterface = An IMbnInterface that represents the device that was removed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnInterfaceRemoval(IMbnInterface oldInterface);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Provides access to network registration data.
@GUID("DCBBBAB6-2009-4BBB-AAEE-338E368AF6FA")
interface IMbnRegistration : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the registration state.
    ///Params:
    ///    registerState = A pointer an MBN_REGISTER_STATE value that specifies to the current registration state of the device. The
    ///                    value is meaningful only if the method returned <b>S_OK</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The registration
    ///    state is not available. The Mobile Broadband service is currently probing the device for the information.
    ///    When the registration state is available, the Mobile Broadband service will call the OnRegisterStateChange
    ///    method of IMbnRegistrationEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt>
    ///    </dl> </td> <td width="60%"> A PIN is required to get the registration state. </td> </tr> </table>
    ///    
    HRESULT GetRegisterState(MBN_REGISTER_STATE* registerState);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the network registration mode of a Mobile Broadband device.
    ///Params:
    ///    registerMode = A pointer to a MBN_REGISTER_MODE value that specifies the current network registration mode of the device.
    ///                   The value is meaningful only if the method returns <b>S_OK</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The registration mode
    ///    is not available. The Mobile Broadband service is currently probing the device for the information. When the
    ///    registration mode is available, the Mobile Broadband service will call the OnRegisterModeAvailable method of
    ///    IMbnRegistrationEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> E_MBN_PIN_REQUIRED</b></dt> </dl>
    ///    </td> <td width="60%"> A PIN is required to get the register mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> A SIM is not inserted in the device.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM
    ///    is inserted in the device. </td> </tr> </table>
    ///    
    HRESULT GetRegisterMode(MBN_REGISTER_MODE* registerMode);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the provider ID for the currently registered network.
    ///Params:
    ///    providerID = Pointer to a string that contains the ID of the currently registered provider. The maximum length is
    ///                 <b>MBN_PROVIDERID_LEN</b> characters. The string is filled only when the method returns <b>S_OK</b> for
    ///                 success. Upon success, the calling application must free the allocated memory by calling SysFreeString.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The provider ID is
    ///    not available. The Mobile Broadband service is currently probing the device for the information. When the
    ///    provider ID is available, the Mobile Broadband service will call the OnRegisterModeAvailable method of
    ///    IMbnRegistrationEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td>
    ///    <td width="60%"> A PIN is required to get the provider ID. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> A SIM is not inserted in the device. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM is
    ///    inserted in the device. </td> </tr> </table>
    ///    
    HRESULT GetProviderID(BSTR* providerID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the provider name for the currently registered network.
    ///Params:
    ///    providerName = Pointer to a string that contains the name of the currently registered provider. The maximum length of this
    ///                   string is <b>MBN_PROVIDERNAME_LEN</b> characters. The string is filled only when the method returns
    ///                   <b>S_OK</b> for success. Upon success, the calling application must free the allocated memory by calling
    ///                   SysFreeString.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The provider name is
    ///    not available. The Mobile Broadband service is currently probing the device for the information. When the
    ///    provider name is available, the Mobile Broadband service will call the OnRegisterModeAvailable method of
    ///    IMbnRegistrationEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td>
    ///    <td width="60%"> A PIN is required to get the provider name. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> A SIM is not inserted in the device.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM
    ///    is inserted in the device. </td> </tr> </table>
    ///    
    HRESULT GetProviderName(BSTR* providerName);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the roaming text describing the roaming provider.
    ///Params:
    ///    roamingText = Pointer to a string that contains additional information about a network with which the device is roaming.
    ///                  The maximum length is <b>MBN_ROAMTEXT_LEN</b> characters. The string is filled only when the method returns
    ///                  <b>S_OK</b> for success. Upon success, the calling application must free the allocated memory by calling
    ///                  SysFreeString.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The roaming text is
    ///    not available. The Mobile Broadband service is currently probing the device for the information. When the
    ///    roaming text is available, the Mobile Broadband service will call the OnRegisterModeAvailable method of
    ///    IMbnRegistrationEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td>
    ///    <td width="60%"> A PIN is required to get the roaming text. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> A SIM is not inserted in the device.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM
    ///    is inserted in the device. </td> </tr> </table>
    ///    
    HRESULT GetRoamingText(BSTR* roamingText);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the available data classes in the current network.
    ///Params:
    ///    availableDataClasses = A pointer to a bitwise OR combination of MBN_DATA_CLASS values. This parameter is meaningful only if the
    ///                           function returns <b>S_OK</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The data classes are
    ///    not available. the Mobile Broadband service is currently probing the device for the information. When the
    ///    data classes are available, the Mobile Broadband service will call the OnPacketServiceStateChange method of
    ///    IMbnRegistrationEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td>
    ///    <td width="60%"> A PIN is required to get the data classes. </td> </tr> </table>
    ///    
    HRESULT GetAvailableDataClasses(uint* availableDataClasses);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the current data class in the current network.
    ///Params:
    ///    currentDataClass = A pointer to a MBN_DATA_CLASS value. This parameter is meaningful only if the function returns <b>S_OK</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The data classes are
    ///    not available. the Mobile Broadband service is currently probing the device for the information. When the
    ///    data classes are available, the Mobile Broadband service will call the OnPacketServiceStateChange method of
    ///    IMbnRegistrationEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td>
    ///    <td width="60%"> A PIN is required to get the data classes. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> A SIM is not inserted in the device.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM
    ///    is inserted in the device. </td> </tr> </table>
    ///    
    HRESULT GetCurrentDataClass(uint* currentDataClass);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the network error from a registration operation.
    ///Params:
    ///    registrationNetworkError = A pointer to an error code returned by the last failed network registration operation. This is set to 0 if
    ///                               there is no error or if the error code is unknown.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRegistrationNetworkError(uint* registrationNetworkError);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the network error from a packet attach operation.
    ///Params:
    ///    packetAttachNetworkError = A pointer to an error code returned by the last failed network packet attach operation. This is set to 0 if
    ///                               there is no error or if the error code is unknown.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPacketAttachNetworkError(uint* packetAttachNetworkError);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Sets the registration mode for the device.
    ///Params:
    ///    registerMode = An MBN_REGISTER_MODE value that specifies the new registration mode.
    ///    providerID = A string that specifies the provider ID of the network provider to which to register. Must be <b>NULL</b>
    ///                 when <i>registerMode</i> is <b>MBN_REGISTER_MODE_AUTOMATIC</b>.
    ///    dataClass = A bitwise combination of OR MBN_DATA_CLASS values that specify the preferred data access technologies for the
    ///                connection. The Mobile Broadband service will register the highest available data class technology from this
    ///                list. If no data class from this list can be registered to, then the Mobile Broadband service will register
    ///                to the best available data class.
    ///    requestID = A request ID set by the Mobile Broadband service to identify this asynchronous request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid, most likely
    ///    because the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_STATE)</b></dt> </dl> </td> <td width="60%"> There is already an
    ///    active network connection. The registration mode cannot be changed while there is an already established data
    ///    connection. The calling application should first disconnect the connection and then try changing registration
    ///    mode. If the device is already in the requested mode and connected to the requested provider, then the return
    ///    code will be <b>S_OK</b>. </td> </tr> </table>
    ///    
    HRESULT SetRegisterMode(MBN_REGISTER_MODE registerMode, const(PWSTR) providerID, uint dataClass, 
                            uint* requestID);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Notification interface used to indicate when registration events have occurred.
@GUID("DCBBBAB6-200A-4BBB-AAEE-338E368AF6FA")
interface IMbnRegistrationEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that registration mode
    ///information is available.
    ///Params:
    ///    newInterface = Pointer to an IMbnRegistration interface that represents the applicable device.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnRegisterModeAvailable(IMbnRegistration newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate a change in the device's
    ///registration state.
    ///Params:
    ///    newInterface = Pointer to an IMbnRegistration interface that represents the applicable device.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnRegisterStateChange(IMbnRegistration newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate a change in the device packet
    ///service state.
    ///Params:
    ///    newInterface = Pointer to an IMbnRegistration interface that represents the device whose packet service state has changed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnPacketServiceStateChange(IMbnRegistration newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that it has completed a set
    ///registration operation.
    ///Params:
    ///    newInterface = Pointer to an IMbnRegistration interface that represents the applicable device. The handling application can
    ///                   use this interface to get the current registration state of the device.
    ///    requestID = The request ID assigned by the Mobile Broadband service to track the set registration operation.
    ///    status = A status code that indicates the outcome of the operation. A calling application can expect one of the
    ///             possible values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///             id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///             </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_INVALID_STATE_"></a><a
    ///             id="hresult_from_win32_error_invalid_state_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_STATE)</b></dt>
    ///             </dl> </td> <td width="60%"> There is already an active network connection. The registration mode cannot be
    ///             changed when there is an already established data connection. The application should first disconnect the
    ///             connection and then try changing registration mode. If the device is already in the requested mode and
    ///             connected to requested provider, then the return code will be <b>S_OK</b>. </td> </tr> <tr> <td
    ///             width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The operation is not supported by the device. This may be returned by devices
    ///             which do not support the requested registration mode. For example, a CDMA device will return this error when
    ///             requested to switch to manual registration mode. </td> </tr> <tr> <td width="40%"><a id="E_FAIL"></a><a
    ///             id="e_fail"></a><dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The operation could not be
    ///             completed. More information is available in the network error code. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_INVALIDARG"></a><a id="e_invalidarg"></a><dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///             Invalid registration mode input or the provider ID provided as input is longer than maximum length 7
    ///             characters or data class provided is invalid. the Mobile Broadband service will not send the request to the
    ///             device when invalid arguments are provided in the input. In manual registration mode, this indicates that the
    ///             requested provider is forbidden. </td> </tr> <tr> <td width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a
    ///             id="e_mbn_pin_required"></a><dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is
    ///             needed for the operation to complete. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SERVICE_NOT_ACTIVATED"></a><a id="e_mbn_service_not_activated"></a><dl>
    ///             <dt><b>E_MBN_SERVICE_NOT_ACTIVATED</b></dt> </dl> </td> <td width="60%"> The network service subscription has
    ///             expired. </td> </tr> <tr> <td width="40%"><a id="E_MBN_PROVIDER_NOT_VISIBLE"></a><a
    ///             id="e_mbn_provider_not_visible"></a><dl> <dt><b>E_MBN_PROVIDER_NOT_VISIBLE</b></dt> </dl> </td> <td
    ///             width="60%"> This occurs only when switching to manual registration mode. The switch is successful but the
    ///             requested provider is not visible. The device will register to the requested provider when it is visible.
    ///             </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSetRegisterModeComplete(IMbnRegistration newInterface, uint requestID, HRESULT status);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Provides access to IMbnConnection objects and connection notifications.
@GUID("DCBBBAB6-201D-4BBB-AAEE-338E368AF6FA")
interface IMbnConnectionManager : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets a connection.
    ///Params:
    ///    connectionID = A string containing the connection ID.
    ///    mbnConnection = A pointer to an IMbnConnection interface that represents the requested connection. If the method returns
    ///                    anything other than S_OK, then this is <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>mbnConnection</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Could not allocate the required memory. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetConnection(const(PWSTR) connectionID, IMbnConnection* mbnConnection);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets a list of available connections.
    ///Params:
    ///    mbnConnections = An array of IMbnConnection interfaces representing connections that are associated with the devices. If this
    ///                     method returns anything other than <b>S_OK</b>, then this is <b>NULL</b>. Otherwise the calling application
    ///                     must free the allocated memory by calling SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>mbnConnections</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Could not allocate the required memory. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetConnections(SAFEARRAY** mbnConnections);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This notification interface signals an application about the arrival and removal of IMbnConnection interfaces in the
///system.
@GUID("DCBBBAB6-201E-4BBB-AAEE-338E368AF6FA")
interface IMbnConnectionManagerEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that indicates a new connection was added to the system.
    ///Params:
    ///    newConnection = An IMbnConnection interface that represents the device added to the system.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnConnectionArrival(IMbnConnection newConnection);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that indicates a connection was removed from the system.
    ///Params:
    ///    oldConnection = An IMbnConnection interface that represents the device removed from the system.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnConnectionRemoval(IMbnConnection oldConnection);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Provides important details about the device PIN.
@GUID("DCBBBAB6-2005-4BBB-AAEE-338E368AF6FA")
interface IMbnPinManager : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets a list of different PIN types supported by the device.
    ///Params:
    ///    pinList = A pointer to a list of MBN_PIN_TYPE values that represent the PIN types supported by the device. When
    ///              <b>GetPinList</b> returns anything other than <b>S_OK</b>, <i>pinList</i> is <b>NULL</b>, otherwise the
    ///              calling application must free the allocated memory by calling SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The PIN types
    ///    are not available. The Mobile Broadband service is currently probing the device to get the information. When
    ///    the PIN types are available, the Mobile Broadband service will call the OnPinListAvailable method of
    ///    IMbnPinManagerEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td>
    ///    <td width="60%"> The device requires that a PIN must be entered for this operation. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> The SIM is not
    ///    inserted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A
    ///    bad SIM is inserted in the device. </td> </tr> </table>
    ///    
    HRESULT GetPinList(SAFEARRAY** pinList);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets a specific type of PIN.
    ///Params:
    ///    pinType = An MBN_PIN_TYPE value that represents the requested PIN type.
    ///    pin = Pointer to the address of the IMbnPin for the requested PIN type. If this method returns any value other than
    ///          <b>S_OK</b>, this parameter is <b>NULL</b>. Otherwise, the calling application must release this interface
    ///          when it is done using it.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The PIN type is
    ///    not available. The Mobile Broadband service is currently probing the device to retrieve this information.
    ///    When the PIN type is available, the Mobile Broadband service will call the OnPinListAvailable method of
    ///    IMbnPinManagerEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td>
    ///    <td width="60%"> A PIN is required for the operation to complete. The calling Application can retry this
    ///    operation when device is PIN unlocked </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad
    ///    SIM in the device. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The requested PIN type
    ///    is not supported by the device. </td> </tr> </table>
    ///    
    HRESULT GetPin(MBN_PIN_TYPE pinType, IMbnPin* pin);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the current PIN state of the device.
    ///Params:
    ///    requestID = A pointer to the request ID set by the Mobile Broadband service for this asynchronous request. The response
    ///                will contain the same request ID.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid, most likely
    ///    because the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely the Mobile Broadband device has been removed from the system. </td> </tr> </table>
    ///    
    HRESULT GetPinState(uint* requestID);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Notification interface used to indicate when PIN Manager events have occurred.
@GUID("DCBBBAB6-2006-4BBB-AAEE-338E368AF6FA")
interface IMbnPinManagerEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that the list of device PINs is
    ///available.
    ///Params:
    ///    pinManager = Pointer to an IMbnPinManager interface that represents the Mobile Broadband device for which the PIN list is
    ///                 available.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnPinListAvailable(IMbnPinManager pinManager);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate the completion of an
    ///asynchronous operation triggered by a call to the GetPinState method of IMbnPinManager.
    ///Params:
    ///    pinManager = Pointer to an IMbnPinManager interface that represents the Mobile Broadband device for which the operation
    ///                 was performed.
    ///    pinInfo = A MBN_PIN_INFO structure that contains the device PIN information. If <b>pinInfo.pinState</b> is set to
    ///              <b>MBN_PIN_STATE_NONE</b> then no PIN is expected to be entered by device. If <b>pinInfo.pinState</b> is set
    ///              to <b>MBN_PIN_STATE_ENTER</b> then the device is expecting a PIN to be entered and <b>pinInfo.pinType</b>
    ///              represents the type of PIN expected by device. If <b>pinInfo.pinState</b> is set to
    ///              <b>MBN_PIN_STATE_UNBLOCK</b> then the device is PIN blocked and a PIN unblock operation should be tried to
    ///              unblock the device. In this case, <b>pinInfo.pinType</b> represents the PIN type on which the unblock
    ///              operation should be performed. If <b>pinInfo.pinState</b> is set to <b>MBN_PIN_STATE_ENTER</b> or
    ///              <b>MBN_PIN_STATE_UNBLOCK</b>, then <b>pinInfo.attemptsRemaining</b> contains the number of attempts remaining
    ///              to enter a valid PIN or PIN unblock key (PUK). If the number of attempts remaining is unknown then
    ///              <b>pinInfo.attemptsRemaining</b> is set to <b>MBN_ATTEMPTS_REMAINING_UNKNOWN</b>.
    ///    requestID = The request ID assigned by the Mobile Broadband service to identify this operation.
    ///    status = The operation completion status. A calling application can expect one of the following values. <table> <tr>
    ///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a id="s_ok"></a><dl>
    ///             <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td
    ///             width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The device does not support PIN operations. </td> </tr> <tr> <td width="40%"><a
    ///             id="_E_MBN_SIM_NOT_INSERTED"></a><a id="_e_mbn_sim_not_inserted"></a><dl> <dt><b>
    ///             E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> The operation could not complete because a SIM
    ///             is not in the device. </td> </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a
    ///             id="e_mbn_bad_sim"></a><dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> The operation could
    ///             not complete because a bad SIM was detected in the device. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnGetPinStateComplete(IMbnPinManager pinManager, MBN_PIN_INFO pinInfo, uint requestID, HRESULT status);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This interface is a notification interface used to indicate when asynchronous PIN requests have completed.
@GUID("DCBBBAB6-2008-4BBB-AAEE-338E368AF6FA")
interface IMbnPinEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that a PIN enable operation has
    ///completed.
    ///Params:
    ///    pin = An IMbnPin interface that represents the PIN type.
    ///    pinInfo = A pointer to a MBN_PIN_INFO structure that contains information on remaining attempts, in case of failure
    ///              operations. The contents of <i>pinInfo</i> are meaningful only when <i>status</i> is <b>E_MBN_FAILURE</b>.
    ///    requestID = A request ID set by the Mobile Broadband service to identify the PIN enable request.
    ///    status = A status code that indicates the outcome of the operation. A calling application can expect one of the
    ///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///             id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///             </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The device does not support this operation. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_FAIL"></a><a id="e_fail"></a><dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The operation
    ///             could not be completed. </td> </tr> <tr> <td width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a
    ///             id="e_mbn_pin_required"></a><dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is
    ///             required for the operation to complete. The calling application can call the GetPinState method of
    ///             IMbnPinManager to discover the type of expected PIN. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl>
    ///             <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad SIM in the device. </td> </tr> <tr>
    ///             <td width="40%"><a id="E_MBN_FAILURE"></a><a id="e_mbn_failure"></a><dl> <dt><b>E_MBN_FAILURE</b></dt> </dl>
    ///             </td> <td width="60%"> There is a failed attempt to use the PIN. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnEnableComplete(IMbnPin pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that a PIN disable operation
    ///has completed.
    ///Params:
    ///    pin = An IMbnPin interface that the PIN type.
    ///    pinInfo = A pointer to a MBN_PIN_INFO structure that contains information on remaining attempts, in case of failure
    ///              operations. The contents of <i>pinInfo</i> are meaningful only when <i>status</i> is <b>E_MBN_FAILURE</b>.
    ///    requestID = A request ID set by the Mobile Broadband service to identify the PIN disable request.
    ///    status = A status code that indicates the outcome of the operation. A calling application can expect one of the
    ///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///             id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///             </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The device does not support this operation. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_FAIL"></a><a id="e_fail"></a><dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The operation
    ///             could not be completed. </td> </tr> <tr> <td width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a
    ///             id="e_mbn_pin_required"></a><dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is
    ///             required for the operation to complete. The calling application can call the GetPinState method of
    ///             IMbnPinManager to discover the type of expected PIN. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl>
    ///             <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad SIM in the device. </td> </tr> <tr>
    ///             <td width="40%"><a id="E_MBN_FAILURE"></a><a id="e_mbn_failure"></a><dl> <dt><b>E_MBN_FAILURE</b></dt> </dl>
    ///             </td> <td width="60%"> There is a failed attempt to use the PIN. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnDisableComplete(IMbnPin pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that a PIN enter operation has
    ///completed
    ///Params:
    ///    Pin = An IMbnPin interface that represents the PIN type.
    ///    pinInfo = A pointer to a MBN_PIN_INFO structure that contains information on remaining attempts, in case of failure
    ///              operations. The contents of <i>pinInfo</i> are meaningful only when <i>status</i> is <b>E_MBN_FAILURE</b>.
    ///    requestID = A request ID set by the Mobile Broadband service to identify the PIN enter request.
    ///    status = A status code that indicates the outcome of the operation. A calling application can expect one of the
    ///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///             id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///             </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The device does not support this operation. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_FAIL"></a><a id="e_fail"></a><dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The operation
    ///             could not be completed. </td> </tr> <tr> <td width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a
    ///             id="e_mbn_pin_required"></a><dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is
    ///             required for the operation to complete. The calling application can call the GetPinState method of
    ///             IMbnPinManager to discover the type of expected PIN. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl>
    ///             <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad SIM in the device. </td> </tr>
    ///             </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnEnterComplete(IMbnPin Pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that a PIN change operation has
    ///completed.
    ///Params:
    ///    Pin = An IMbnPin interface that represents the PIN type.
    ///    pinInfo = A pointer to an MBN_PIN_INFO structure that contains information on remaining attempts, in case of failure
    ///              operations. The contents of <i>pinInfo</i> are meaningful only when <i>status</i> is <b>E_MBN_FAILURE</b>.
    ///    requestID = A request ID set by the Mobile Broadband service to identify the PIN change request.
    ///    status = A status code that indicates the outcome of the PIN change operation. A calling application can expect one of
    ///             the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///             id="S_OK"></a><a id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was
    ///             successful. </td> </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The device does not support this operation. </td> </tr> <tr> <td width="40%"><a
    ///             id="_E_FAIL"></a><a id="_e_fail"></a><dl> <dt><b> E_FAIL</b></dt> </dl> </td> <td width="60%"> The operation
    ///             could not be completed. </td> </tr> <tr> <td width="40%"><a id="___E_MBN_PIN_REQUIRED"></a><a
    ///             id="___e_mbn_pin_required"></a><dl> <dt><b> E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is
    ///             required for the operation to complete. The calling application can call the GetPinState method of
    ///             IMbnPinManager to discover the type of expected PIN. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl>
    ///             <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad SIM in the device. </td> </tr> <tr>
    ///             <td width="40%"><a id="E_MBN_PIN_DISABLED"></a><a id="e_mbn_pin_disabled"></a><dl>
    ///             <dt><b>E_MBN_PIN_DISABLED</b></dt> </dl> </td> <td width="60%"> The PIN change operation is not supported for
    ///             the disabled PIN. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnChangeComplete(IMbnPin Pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that a PIN unblock operation
    ///has completed
    ///Params:
    ///    Pin = An IMbnPin interface that represents the PIN type.
    ///    pinInfo = A pointer to a MBN_PIN_INFO structure that contains information on remaining attempts, in case of failure
    ///              operations. The contents of <i>pinInfo</i> are meaningful only when <i>status</i> is <b>E_MBN_FAILURE</b>.
    ///    requestID = A request ID set by the Mobile Broadband service to identify the PIN unblock request.
    ///    status = A status code that indicates the outcome of the operation. A calling application can expect one of the
    ///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///             id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///             </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The device does not support this operation. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_FAIL"></a><a id="e_fail"></a><dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The operation
    ///             could not be completed. </td> </tr> <tr> <td width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a
    ///             id="e_mbn_pin_required"></a><dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is
    ///             required for the operation to complete. The calling application can call the GetPinState method of
    ///             IMbnPinManager to discover the type of expected PIN. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl>
    ///             <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad SIM in the device. </td> </tr>
    ///             </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnUnblockComplete(IMbnPin Pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Provides access to subscriber information.
@GUID("459ECC43-BCF5-11DC-A8A8-001321F1405F")
interface IMbnSubscriberInformation : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The subscriber ID of the device. This property is read-only.
    HRESULT get_SubscriberID(BSTR* SubscriberID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The SIM International circuit card number (SimICCID) for the device. This property is read-only.
    HRESULT get_SimIccID(BSTR* SimIccID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The telephone numbers associated with the device. This property is read-only.
    HRESULT get_TelephoneNumbers(SAFEARRAY** TelephoneNumbers);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Get radio signal quality of a Mobile Broadband connection.
@GUID("DCBBBAB6-2003-4BBB-AAEE-338E368AF6FA")
interface IMbnSignal : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the signal strength received by the device.
    ///Params:
    ///    signalStrength = Pointer to the signal quality received by the device. When the signal strength is not known or it is not
    ///                     detectable by the device then this is set to <b>MBN_RSSI_UNKNOWN</b>. If this method returns any value other
    ///                     than S_OK, this parameter is 0.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The signal
    ///    quality is not available. The Mobile Broadband service is currently probing the device to retrieve this
    ///    information. When the signal quality is available, the Mobile Broadband service will call the
    ///    OnSignalStateChange method of IMbnSignalEvents. </td> </tr> </table>
    ///    
    HRESULT GetSignalStrength(uint* signalStrength);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the received signal error rate.
    ///Params:
    ///    signalError = Pointer to the error rate in the received signal. Mobile Broadband Interfaces report the signal error rate as
    ///                  a coded value that maps to the percentage range of error rates. This is the Channel Bit Error Rate for GSM
    ///                  and Frame Error Rate for CDMA. In both the cases, MBN_ERROR_RATE_UNKNOWN specifies an unknown error rate. The
    ///                  following table shows the values for the error rate codes. <table> <tr> <th>Bit error rate (in %)</th>
    ///                  <th>Frame error rate (in %)</th> <th>Coded value (0-7)</th> </tr> <tr> <td>&lt; 0.2</td> <td>&lt; 0.01</td>
    ///                  <td>0</td> </tr> <tr> <td>0.2 - 0.4</td> <td>0.01 - 0.1</td> <td>1</td> </tr> <tr> <td>0.4 - 0.8</td> <td>0.1
    ///                  - 0.5</td> <td>2</td> </tr> <tr> <td>0.8 - 1.6</td> <td>0.5 - 1.0</td> <td>3</td> </tr> <tr> <td>1.6 -
    ///                  3.2</td> <td>1.0 - 2.0</td> <td>4</td> </tr> <tr> <td>3.2 - 6.4</td> <td>2.0 - 4.0</td> <td>5</td> </tr> <tr>
    ///                  <td>6.4 - 12.8</td> <td>4.0 - 8.0</td> <td>6</td> </tr> <tr> <td>&gt; 12.8</td> <td>&gt; 8.0</td> <td>7</td>
    ///                  </tr> <tr> <td>unknown</td> <td>unknown</td> <td>MBN_ERROR_RATE_UNKNOWN</td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully .
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The error rate
    ///    is not yet available. The Mobile Broadband service is current probing the device to retrieve the information.
    ///    When the error rate is available, the Mobile Broadband service will call the OnSignalStateChange method of
    ///    IMbnSignalEvents. </td> </tr> </table>
    ///    
    HRESULT GetSignalError(uint* signalError);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Notification interface used to indicate that a signal event has occurred.
@GUID("DCBBBAB6-2004-4BBB-AAEE-338E368AF6FA")
interface IMbnSignalEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate that a signal quality
    ///update is available.
    ///Params:
    ///    newInterface = Pointer to an IMbnSignal interface for which the signal quality update was received.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSignalStateChange(IMbnSignal newInterface);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Manages connection contexts. A connection context is an abstraction of a specific set of network configuration
///parameters for setting up a virtual circuit or flow on top of the physical Mobile Broadband connection.
@GUID("DCBBBAB6-200B-4BBB-AAEE-338E368AF6FA")
interface IMbnConnectionContext : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets a list of connection contexts.
    ///Params:
    ///    provisionedContexts = A list of MBN_CONTEXT values that represent connection contexts stored in the device. On error, this array is
    ///                          <b>NULL</b>. When successful, the calling application must free the allocated memory by calling
    ///                          SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The connection
    ///    contexts are not available. The Mobile Broadband service is probing the device for the information. The
    ///    calling application can get notified when the connection contexts are available by registering for the
    ///    OnProvisionedContextListChange method of IMbnConnectionContextEvents. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is required to get the connection
    ///    contexts. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td
    ///    width="60%"> A SIM is not inserted in the device. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM is inserted in the device. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td
    ///    width="60%"> The device does not support retrieval of provisioned contexts. </td> </tr> </table>
    ///    
    HRESULT GetProvisionedContexts(SAFEARRAY** provisionedContexts);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Adds or updates a provisioned context.
    ///Params:
    ///    provisionedContexts = An MBN_CONTEXT structure that specifies the provisioned context to be stored in the device or SIM.
    ///    providerID = A string that represents the network provider ID for which the provisioned context should be stored. The
    ///                 device should return the added provisioned context in response to any subsequent query when a SIM with this
    ///                 home provider ID is in the device.
    ///    requestID = A request ID set by the Mobile Broadband service to identify this asynchronous request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid
    ///    interface. Most likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Invalid
    ///    interface. Most likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl> </td> <td width="60%">
    ///    The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> <i>providerID</i> is not valid. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetProvisionedContext(MBN_CONTEXT provisionedContexts, const(PWSTR) providerID, uint* requestID);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This notification interface is used to handle asynchronous provisioned context events.
@GUID("DCBBBAB6-200C-4BBB-AAEE-338E368AF6FA")
interface IMbnConnectionContextEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that a provisioned context
    ///stored in the device is available or updated.
    ///Params:
    ///    newInterface = An IMbnConnectionContext interface that represents the device for which the context is available or updated.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnProvisionedContextListChange(IMbnConnectionContext newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that the provisioned context in
    ///the device has been set.
    ///Params:
    ///    newInterface = An IMbnConnectionContext interface that represents the device for which the context has been set.
    ///    requestID = A request ID set by the Mobile Broadband service to identify the operation that set the context.
    ///    status = A status code that indicates the outcome of the operation. A calling application can expect one of the
    ///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///             id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///             </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The device does not support this operation. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_PIN_REQUIRED"></a><a id="e_mbn_pin_required"></a><dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl>
    ///             </td> <td width="60%"> A PIN is required for the operation to complete. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_INVALIDARG"></a><a id="e_invalidarg"></a><dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///             The context ID or provider ID given in the request is not valid. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td
    ///             width="60%"> There is a bad SIM in the device. </td> </tr> <tr> <td width="40%"><a
    ///             id="HRESULT_FROM_WIN32_ERROR_WRITE_FAULT_"></a><a id="hresult_from_win32_error_write_fault_"></a><dl>
    ///             <dt><b>HRESULT_FROM_WIN32(ERROR_WRITE_FAULT)</b></dt> </dl> </td> <td width="60%"> An update in either SIM or
    ///             device memory failed. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSetProvisionedContextComplete(IMbnConnectionContext newInterface, uint requestID, HRESULT status);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Provides access to connection profiles and connection notifications.
@GUID("DCBBBAB6-200F-4BBB-AAEE-338E368AF6FA")
interface IMbnConnectionProfileManager : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets a list of connection profiles associated with the device.
    ///Params:
    ///    mbnInterface = An IMbnInterface that represents the device for which the profile request applies. If this is <b>NULL</b>,
    ///                   the function will return all of the profiles that are present in the system.
    ///    connectionProfiles = An array of IMbnConnectionProfile interfaces that represent all the available connection profiles for the
    ///                         device. If this method returns anything other than <b>S_OK</b>, the array pointer is <b>NULL</b>, otherwise
    ///                         the calling application must eventually free the allocated memory by calling SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is
    ///    invalid, most likely because the Mobile Broadband device has been removed from the system. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_READY)</b></dt> </dl> </td> <td width="60%"> The
    ///    device is not ready. Unable to obtain the subscriber ID because the device is not
    ///    <b>MBN_READY_STATE_INITIALIZED</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl> </td> <td width="60%"> The Mobile
    ///    Broadband service is not running on this system. </td> </tr> </table>
    ///    
    HRESULT GetConnectionProfiles(IMbnInterface mbnInterface, SAFEARRAY** connectionProfiles);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets a specific connection profile associated with the given Mobile Broadband device.
    ///Params:
    ///    mbnInterface = An IMbnInterface that represents the device for which the profile request applies. If <i>mbnInterface</i> is
    ///                   <b>NULL</b>, then this function will return the profile of the given name associated with any device in the
    ///                   system.
    ///    profileName = A null-terminated string that contains the name of the connection profile.
    ///    connectionProfile = An IMbnConnectionProfile interface that represents the desired connection profile. If this method returns
    ///                        anything other than <b>S_OK</b>, this is <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is
    ///    invalid, most likely because the Mobile Broadband device has been removed from the system. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> A
    ///    profile with the given name does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_READY)</b></dt> </dl> </td> <td width="60%"> The device is not ready.
    ///    Unable to obtain the subscriber ID because the device is not <b>MBN_READY_STATE_INITIALIZED</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> A
    ///    profile with the given name does not exist. </td> </tr> </table>
    ///    
    HRESULT GetConnectionProfile(IMbnInterface mbnInterface, const(PWSTR) profileName, 
                                 IMbnConnectionProfile* connectionProfile);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Creates a new connection profile for the device.
    ///Params:
    ///    xmlProfile = A null-terminated string that contains the profile data in XML format compliant with the Mobile Broadband
    ///                 Profile Schema Reference.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_ALREADY_EXISTS)</b></dt> </dl> </td>
    ///    <td width="60%"> A profile with the given name already exists. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_INVALID_PROFILE</b></dt> </dl> </td> <td width="60%"> The profile does not conform to the Mobile
    ///    Broadband profile schema. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The icon file location
    ///    passed in the profile is not valid or not accessible. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_DEFAULT_PROFILE_EXIST</b></dt> </dl> </td> <td width="60%"> The calling application specified
    ///    the default profile flag in the XML data, however the default profile already exists for the Mobile Broadband
    ///    device. </td> </tr> </table>
    ///    
    HRESULT CreateConnectionProfile(const(PWSTR) xmlProfile);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This interface accesses connection parameters and preferences stored in Mobile Broadband profiles.
@GUID("DCBBBAB6-2010-4BBB-AAEE-338E368AF6FA")
interface IMbnConnectionProfile : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the XML data of the current profile.
    ///Params:
    ///    profileData = A pointer to a string containing the profile in XML format. If the method returns S_OK, the calling
    ///                  application must free the allocated memory by calling SysFreeString.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetProfileXmlData(BSTR* profileData);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Updates the contents of the profile.
    ///Params:
    ///    strProfile = A string that contains the profile data in XML format compliant with the Mobile Broadband Profile Schema
    ///                 Reference.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The profile is
    ///    invalid and likely has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR _NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The profile is invalid and
    ///    has likely been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The profile data
    ///    specifies an icon file that cannot be found at the indicated location. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl> </td> <td width="60%"> The Mobile
    ///    Broadband service is not running on this system. </td> </tr> </table>
    ///    
    HRESULT UpdateProfile(const(PWSTR) strProfile);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Deletes the profile from the system.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The profile is
    ///    invalid and likely has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR _NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The profile is invalid and
    ///    has likely been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl> </td> <td width="60%"> The Mobile
    ///    Broadband service is not running on this system. </td> </tr> </table>
    ///    
    HRESULT Delete();
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This notification interface signals an application when IMbnConnectionProfile methods change the Mobile Broadband
///profile state.
@GUID("DCBBBAB6-2011-4BBB-AAEE-338E368AF6FA")
interface IMbnConnectionProfileEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. A notification method that indicates that profile update operation has completed.
    ///Params:
    ///    newProfile = An IMbnConnectionProfile interface that represents the profile that has changed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnProfileUpdate(IMbnConnectionProfile newProfile);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Provides access to the SMS configuration of a device.
@GUID("DCBBBAB6-2012-4BBB-AAEE-338E368AF6FA")
interface IMbnSmsConfiguration : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. SMS default Service Center address. This property is read/write.
    HRESULT get_ServiceCenterAddress(BSTR* scAddress);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. SMS default Service Center address. This property is read/write.
    HRESULT put_ServiceCenterAddress(const(PWSTR) scAddress);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. SMS message memory capacity. This property is read-only.
    HRESULT get_MaxMessageIndex(uint* index);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Maximum CDMA short message character length. This property is read-only.
    HRESULT get_CdmaShortMsgSize(uint* shortMsgSize);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Format in which newly received SMS should be reported by the device. This property is read/write.
    HRESULT get_SmsFormat(MBN_SMS_FORMAT* smsFormat);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Format in which newly received SMS should be reported by the device. This property is read/write.
    HRESULT put_SmsFormat(MBN_SMS_FORMAT smsFormat);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace. A
///collection of properties that represent an SMS message read from the device memory.
@GUID("DCBBBAB6-2013-4BBB-AAEE-338E368AF6FA")
interface IMbnSmsReadMsgPdu : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The index of the message in the device SMS store. This property is read-only.
    HRESULT get_Index(uint* Index);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The type of message. This property is read-only.
    HRESULT get_Status(MBN_MSG_STATUS* Status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The PDU message in hexadecimal format as used by GSM devices. This property is read-only.
    HRESULT get_PduData(BSTR* PduData);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The message in WMT format as used by CDMA devices. This property is read-only.
    HRESULT get_Message(SAFEARRAY** Message);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace. A
///collection of properties that represent a CDMA format SMS message read from the device memory.
@GUID("DCBBBAB6-2014-4BBB-AAEE-338E368AF6FA")
interface IMbnSmsReadMsgTextCdma : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The index of the message in device SMS memory. This property is read-only.
    HRESULT get_Index(uint* Index);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The type of message. This property is read-only.
    HRESULT get_Status(MBN_MSG_STATUS* Status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The mobile number associated with a message. This property is read-only.
    HRESULT get_Address(BSTR* Address);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The timestamp of a message. This property is read-only.
    HRESULT get_Timestamp(BSTR* Timestamp);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The data encoding used in the message. This property is read-only.
    HRESULT get_EncodingID(MBN_SMS_CDMA_ENCODING* EncodingID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The language used in the message. This property is read-only.
    HRESULT get_LanguageID(MBN_SMS_CDMA_LANG* LanguageID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The size in characters of the message. This property is read-only.
    HRESULT get_SizeInCharacters(uint* SizeInCharacters);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The contents of the message. This property is read-only.
    HRESULT get_Message(SAFEARRAY** Message);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///SMS interface for sending and receiving messages as well as controlling the messaging configuration.
@GUID("DCBBBAB6-2015-4BBB-AAEE-338E368AF6FA")
interface IMbnSms : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the SMS configuration of a device.
    ///Params:
    ///    smsConfiguration = An IMbnSmsConfiguration interface representing the SMS configuration of the device.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The SMS
    ///    configuration is not available. The Mobile Broadband service is probing the device for the information. The
    ///    calling application can be notified when the SMS configuration is available by registering for the
    ///    OnSmsConfigurationChange method of the IMbnSmsEvents interface. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is required to get this information.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%">
    ///    There is no SIM in the device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl>
    ///    </td> <td width="60%"> There is a bad SIM in the device. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> SMS is not supported by
    ///    the device. </td> </tr> </table>
    ///    
    HRESULT GetSmsConfiguration(IMbnSmsConfiguration* smsConfiguration);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Updates the SMS configuration for a device.
    ///Params:
    ///    smsConfiguration = An IMbnSmsConfiguration interface representing the new SMS configuration to update the device with.
    ///    requestID = A pointer to a request ID issued by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on the system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid, most likely
    ///    because the device was removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely the Mobile Broadband device has been removed from the system. </td> </tr> </table>
    ///    
    HRESULT SetSmsConfiguration(IMbnSmsConfiguration smsConfiguration, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Sends a message in PDU format.
    ///Params:
    ///    pduData = A string representing the PDU message in hexadecimal format.
    ///    size = The size of PDU message in number of bytes before converting to hexadecimal string format and excluding the
    ///           service center address length.
    ///    requestID = A pointer to a request ID issued by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pduData</i> or <i>size</i> are invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl> </td> <td width="60%"> The Mobile
    ///    Broadband service is not running on this system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid, most likely because the
    ///    device was removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The device does not
    ///    support sending SMS messages in the requested format. For example, if this function is called for a CDMA
    ///    device. </td> </tr> </table>
    ///    
    HRESULT SmsSendPdu(const(PWSTR) pduData, ubyte size, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Sends a message in CDMA format.
    ///Params:
    ///    address = A null terminated string that contains the receiver's phone number. The maximum size of the string is 15
    ///              digits.
    ///    encoding = A MBN_SMS_CDMA_ENCODING value that specifies the data encoding.
    ///    language = An MBN_SMS_CDMA_LANG value that specifies the language.
    ///    sizeInCharacters = The number of encoded characters in the message. This can be different from the size of the message array.
    ///    message = An array of bytes containing the encoded CDMA message. The maximum size of this array is the CdmaShortMsgSize
    ///              property of IMbnSmsConfiguration, however this can be no larger than <b>MBN_CDMA_SHORT_MSG_SIZE_MAX</b>
    ///              (160).
    ///    requestID = A pointer to a request ID issued by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid, most likely
    ///    because the device was removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The device does not
    ///    support sending SMS messages in the requested format. For example, if this function is called for a GSM
    ///    device. </td> </tr> </table>
    ///    
    HRESULT SmsSendCdma(const(PWSTR) address, MBN_SMS_CDMA_ENCODING encoding, MBN_SMS_CDMA_LANG language, 
                        uint sizeInCharacters, SAFEARRAY* message, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Sends a message in CDMA binary format.
    ///Params:
    ///    message = Byte array representing the encoded CMDA message as per section 3.4.2.1 "SMS Point-to-Point Message” in
    ///              3GPP2 specification C.S0015-A “Short Message Service (SMS) for Wideband Spread Spectrum Systems”. SMS
    ///              will only support the Wireless Messaging Teleservice (WMT) format.
    ///    requestID = A pointer to a request ID issued by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid, most likely
    ///    because the device was removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>message</i> is invalid. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%">
    ///    The device does not support sending SMS messages in the requested format. For example, if this function is
    ///    called for a GSM device. </td> </tr> </table>
    ///    
    HRESULT SmsSendCdmaPdu(SAFEARRAY* message, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Reads a set of SMS messages from a device.
    ///Params:
    ///    smsFilter = A pointer to a MBN_SMS_FILTER structure that defines the set of messages to read.
    ///    smsFormat = An MBN_SMS_FORMAT value that specifies the format in which an SMS message should be read. For GSM devices, it
    ///                should always be <b>MBN_SMS_FORMAT_PDU</b>. For CDMA devices, if this is specified as MBN_SMS_FORMAT_PDU,
    ///                then the device will read a binary mode CDMA message. If it is specified as MBN_SMS_FORMAT_TEXT, then the
    ///                device will read a text mode CDMA message. If the device doesn’t support the specified format then it can
    ///                return an error code.
    ///    requestID = A pointer to a request ID issued by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid, most likely
    ///    because the device was removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>smsFormat</i> or <i>smsFilter</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT SmsRead(MBN_SMS_FILTER* smsFilter, MBN_SMS_FORMAT smsFormat, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Deletes a set of SMS messages from a device.
    ///Params:
    ///    smsFilter = A pointer to a MBN_SMS_FILTER structure that defines the set of messages to delete.
    ///    requestID = A pointer to a request ID issued by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid, most likely
    ///    because the device was removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely the Mobile Broadband device has been removed from the system. </td> </tr> </table>
    ///    
    HRESULT SmsDelete(MBN_SMS_FILTER* smsFilter, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the SMS status for a device.
    ///Params:
    ///    smsStatusInfo = A pointer to a MBN_SMS_STATUS_INFO structure, containing the status information for the device.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The SMS status
    ///    is not available. The Mobile Broadband service is probing the device for the information. The calling
    ///    application can be notified when the SMS status is available by registering for the OnSmsStatusChange method
    ///    of the IMbnSmsEvents interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt>
    ///    </dl> </td> <td width="60%"> A PIN is required to get this information. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> A SIM is not inserted in the device.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A bad SIM
    ///    is inserted in the device. </td> </tr> </table>
    ///    
    HRESULT GetSmsStatus(MBN_SMS_STATUS_INFO* smsStatusInfo);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This notification interface signals an application with the completion status of SMS operations and changes in the
///device SMS status.
@GUID("DCBBBAB6-2016-4BBB-AAEE-338E368AF6FA")
interface IMbnSmsEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that indicates that SMS configuration has changed or is available.
    ///Params:
    ///    sms = A pointer to an IMbnSms interface representing the Mobile Broadband device for which the SMS configuration is
    ///          now available.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSmsConfigurationChange(IMbnSms sms);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method signaling that a set SMS configuration operation has completed, or that the SMS
    ///subsystem is initialized and ready for operation.
    ///Params:
    ///    sms = A pointer to an IMbnSms interface representing the Mobile Broadband device for which the SMS configuration
    ///          has been updated.
    ///    requestID = A request ID assigned by the Mobile Broadband service to identify the operation.
    ///    status = A status code that indicates the outcome of the operation. A calling application can expect one of the
    ///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///             id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl>
    ///             <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad SIM in the device. </td> </tr> <tr>
    ///             <td width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a id="e_mbn_pin_required"></a><dl>
    ///             <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is required for the operation to
    ///             complete. </td> </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The SMS format is not supported by the device. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSetSmsConfigurationComplete(IMbnSms sms, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that indicates the completion of a message send operation.
    ///Params:
    ///    sms = An IMbnSms interface representing the Mobile Broadband device from which the operation completed.
    ///    requestID = A request ID assigned by the Mobile Broadband service to identify the operation.
    ///    status = A status code that indicates the outcome of the operation. A calling application can expect one of the
    ///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///             id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl>
    ///             <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad SIM in the device. </td> </tr> <tr>
    ///             <td width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a id="e_mbn_pin_required"></a><dl>
    ///             <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is required for the operation to
    ///             complete. </td> </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> Either the SMS operation or the particular SMS format is not supported by the
    ///             device. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SMS_MEMORY_FAILURE"></a><a
    ///             id="e_mbn_sms_memory_failure"></a><dl> <dt><b>E_MBN_SMS_MEMORY_FAILURE</b></dt> </dl> </td> <td width="60%">
    ///             SMS memory failure. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SMS_UNKNOWN_SMSC_ADDRESS"></a><a
    ///             id="e_mbn_sms_unknown_smsc_address"></a><dl> <dt><b>E_MBN_SMS_UNKNOWN_SMSC_ADDRESS</b></dt> </dl> </td> <td
    ///             width="60%"> Unknown or incomplete SMS service center address. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SERVICE_NOT_ACTIVATED"></a><a id="e_mbn_service_not_activated"></a><dl>
    ///             <dt><b>E_MBN_SERVICE_NOT_ACTIVATED</b></dt> </dl> </td> <td width="60%"> Cellular service is not activated on
    ///             the device. </td> </tr> <tr> <td width="40%"><a id="E_INVALIDARG"></a><a id="e_invalidarg"></a><dl>
    ///             <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The device detected invalid parameters in the send
    ///             request. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SMS_NETWORK_TIMEOUT"></a><a
    ///             id="e_mbn_sms_network_timeout"></a><dl> <dt><b>E_MBN_SMS_NETWORK_TIMEOUT</b></dt> </dl> </td> <td
    ///             width="60%"> There was a network timeout. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_NOT_REGISTERED"></a><a id="e_mbn_not_registered"></a><dl> <dt><b>E_MBN_NOT_REGISTERED</b></dt>
    ///             </dl> </td> <td width="60%"> The device is not registered to any network. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SMS_LANG_NOT_SUPPORTED"></a><a id="e_mbn_sms_lang_not_supported"></a><dl>
    ///             <dt><b>E_MBN_SMS_LANG_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The CDMA device does not support
    ///             the language. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SMS_ENCODING_NOT_SUPPORTED"></a><a
    ///             id="e_mbn_sms_encoding_not_supported"></a><dl> <dt><b>E_MBN_SMS_ENCODING_NOT_SUPPORTED</b></dt> </dl> </td>
    ///             <td width="60%"> The CDMA device does not support the requested encoding. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SMS_OPERATION_NOT_ALLOWED"></a><a id="e_mbn_sms_operation_not_allowed"></a><dl>
    ///             <dt><b>E_MBN_SMS_OPERATION_NOT_ALLOWED</b></dt> </dl> </td> <td width="60%"> The requested SMS operation is
    ///             not allowed by the SIM. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SMS_MEMORY_FULL"></a><a
    ///             id="e_mbn_sms_memory_full"></a><dl> <dt><b>E_MBN_SMS_MEMORY_FULL</b></dt> </dl> </td> <td width="60%"> The
    ///             device/SIM memory is full. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSmsSendComplete(IMbnSms sms, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating the completion of a message read operation.
    ///Params:
    ///    sms = An IMbnSms interface representing the message store that completed the operation.
    ///    smsFormat = An MBN_SMS_FORMAT value that defines the format of the SMS message.
    ///    readMsgs = An array of messages read from the device.
    ///    moreMsgs = A Boolean value that indicates whether there are more messages still being processed. If this is <b>TRUE</b>,
    ///               then <b>OnSmsReadComplete</b> will be called repeatedly until there are not more messages and <i>moreMsgs</i>
    ///               is <b>FALSE</b>.
    ///    requestID = A request ID assigned by the Mobile Broadband service to identify the message read operation.
    ///    status = A status code that indicates the outcome of the operation. A calling application can expect one of the
    ///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///             id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl>
    ///             <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad SIM in the device. </td> </tr> <tr>
    ///             <td width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a id="e_mbn_pin_required"></a><dl>
    ///             <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is required for the operation to
    ///             complete. </td> </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> Either the SMS operation or the particular SMS format is not supported by the
    ///             device. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SMS_MEMORY_FAILURE"></a><a
    ///             id="e_mbn_sms_memory_failure"></a><dl> <dt><b>E_MBN_SMS_MEMORY_FAILURE</b></dt> </dl> </td> <td width="60%">
    ///             SMS memory failure. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SMS_INVALID_MEMORY_INDEX"></a><a
    ///             id="e_mbn_sms_invalid_memory_index"></a><dl> <dt><b>E_MBN_SMS_INVALID_MEMORY_INDEX</b></dt> </dl> </td> <td
    ///             width="60%"> There is no memory index with the requested value. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SMS_FILTER_NOT_SUPPORTED"></a><a id="e_mbn_sms_filter_not_supported"></a><dl>
    ///             <dt><b>E_MBN_SMS_FILTER_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The device does not support the
    ///             requested filter. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSmsReadComplete(IMbnSms sms, MBN_SMS_FORMAT smsFormat, SAFEARRAY* readMsgs, short moreMsgs, 
                              uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method signaling the arrival of a new class 0/flash message.
    ///Params:
    ///    sms = An IMbnSms interface representing the Mobile Broadband device that received the new message(s).
    ///    smsFormat = An MBN_SMS_FORMAT value that defines the format of the new SMS message.
    ///    readMsgs = An array of new messages.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSmsNewClass0Message(IMbnSms sms, MBN_SMS_FORMAT smsFormat, SAFEARRAY* readMsgs);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that signals the completion of an SMS deletion operation.
    ///Params:
    ///    sms = An IMbnSms interface representing the Mobile Broadband device from which the messages were deleted.
    ///    requestID = A request ID assigned by the Mobile Broadband service to identify the operation.
    ///    status = A status code that indicates the outcome of the operation. A calling application can expect one of the
    ///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///             id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl>
    ///             <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad SIM in the device. </td> </tr> <tr>
    ///             <td width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a id="e_mbn_pin_required"></a><dl>
    ///             <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is required for the operation to
    ///             complete. </td> </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> Either the SMS operation or the particular SMS format is not supported by the
    ///             device. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SMS_MEMORY_FAILURE"></a><a
    ///             id="e_mbn_sms_memory_failure"></a><dl> <dt><b>E_MBN_SMS_MEMORY_FAILURE</b></dt> </dl> </td> <td width="60%">
    ///             SMS memory failure. </td> </tr> <tr> <td width="40%"><a id="E_MBN_SMS_INVALID_MEMORY_INDEX"></a><a
    ///             id="e_mbn_sms_invalid_memory_index"></a><dl> <dt><b>E_MBN_SMS_INVALID_MEMORY_INDEX</b></dt> </dl> </td> <td
    ///             width="60%"> There is no memory index with the requested value. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_SMS_FILTER_NOT_SUPPORTED"></a><a id="e_mbn_sms_filter_not_supported"></a><dl>
    ///             <dt><b>E_MBN_SMS_FILTER_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The device does not support the
    ///             requested filter. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSmsDeleteComplete(IMbnSms sms, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating a change in the status of the message store.
    ///Params:
    ///    sms = An IMbnSms interface representing the Mobile Broadband device for which the message store status has changed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSmsStatusChange(IMbnSms sms);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Pass-through mechanism for cellular service activation.
@GUID("DCBBBAB6-2017-4BBB-AAEE-338E368AF6FA")
interface IMbnServiceActivation : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Send the service activation request to the network.
    ///Params:
    ///    vendorSpecificData = A vendor-specific array of bytes passed in a service activation operation. This data will be passed by the
    ///                         Mobile Broadband service in a SET OID_WWAN_SERVICE_ACTIVATION OID request to the miniport driver.
    ///    requestID = The request ID for this operation.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most likely the
    ///    device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely the Mobile Broadband device has been removed from the system. Invalid interface. Most likely the
    ///    device has been removed from the system. </td> </tr> </table>
    ///    
    HRESULT Activate(SAFEARRAY* vendorSpecificData, uint* requestID);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This notification interface signals an application about the completion of a service activation request.
@GUID("DCBBBAB6-2018-4BBB-AAEE-338E368AF6FA")
interface IMbnServiceActivationEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method called by the Mobile Broadband service to indicate that a service activation
    ///request ahs completed.
    ///Params:
    ///    serviceActivation = Pointer to an IMbnServiceActivation interface representing the device on which the request was performed.
    ///    vendorSpecificData = A byte array containing the data returned by the underlying Mobile Broadband miniport driver in
    ///                         NDIS_STATUS_WWAN_SERVICE_ACTIVATION.
    ///    requestID = The request ID assigned by the Mobile Broadband service when the request was initialized.
    ///    status = The completion status. A calling application can expect one of the following values. <table> <tr>
    ///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="S_OK"></a><a id="s_ok"></a><dl>
    ///             <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td
    ///             width="40%"><a id="E_INVALIDARG"></a><a id="e_invalidarg"></a><dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
    ///             <td width="60%"> The miniport driver detected incorrect input data in the request. </td> </tr> <tr> <td
    ///             width="40%"><a id="E_MBN_PIN_REQUIRED"></a><a id="e_mbn_pin_required"></a><dl>
    ///             <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td> <td width="60%"> A PIN is required for the operation to
    ///             complete. </td> </tr> <tr> <td width="40%"><a id="E_MBN_RADIO_POWER_OFF"></a><a
    ///             id="e_mbn_radio_power_off"></a><dl> <dt><b>E_MBN_RADIO_POWER_OFF</b></dt> </dl> </td> <td width="60%"> The
    ///             Mobile Broadband device is not powered up. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_PROVIDER_NOT_VISIBLE"></a><a id="e_mbn_provider_not_visible"></a><dl>
    ///             <dt><b>E_MBN_PROVIDER_NOT_VISIBLE</b></dt> </dl> </td> <td width="60%"> The service provider is not visible.
    ///             </td> </tr> <tr> <td width="40%"><a id="E_MBN_SIM_NOT_INSERTED"></a><a id="e_mbn_sim_not_inserted"></a><dl>
    ///             <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> There is no SIM in the device. </td>
    ///             </tr> <tr> <td width="40%"><a id="E_MBN_BAD_SIM"></a><a id="e_mbn_bad_sim"></a><dl>
    ///             <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> There is a bad SIM in the device. </td> </tr> <tr>
    ///             <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The device does not support this operation. </td> </tr> </table>
    ///    networkError = The error code returned by the network during the activation operation. This value is meaningful only when
    ///                   <i>status</i> is not S_OK. The exact value of <i>networkError</i> is driver/network dependent.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnActivationComplete(IMbnServiceActivation serviceActivation, SAFEARRAY* vendorSpecificData, 
                                 uint requestID, HRESULT status, uint networkError);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Interface to pass requests from an application to the underlying Mobile Broadband miniport drivers.
@GUID("DCBBBAB6-2019-4BBB-AAEE-338E368AF6FA")
interface IMbnVendorSpecificOperation : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Sends a request to the underlying Mobile Broadband device miniport driver.
    ///Params:
    ///    vendorSpecificData = A byte array that is passed in to the miniport driver.
    ///    requestID = A unique request ID assigned by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetVendorSpecific(SAFEARRAY* vendorSpecificData, uint* requestID);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This notification interface signals an application of the completion status of vendor-specific operations and other
///vendor-specific changes in the device state.
@GUID("DCBBBAB6-201A-4BBB-AAEE-338E368AF6FA")
interface IMbnVendorSpecificEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method signaling a change event from the underlying Mobile Broadband device miniport
    ///driver.
    ///Params:
    ///    vendorOperation = A IMbnVendorSpecificOperation interface representing the device on which the event has occurred.
    ///    vendorSpecificData = A byte array containing the data returned by underlying miniport driver.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnEventNotification(IMbnVendorSpecificOperation vendorOperation, SAFEARRAY* vendorSpecificData);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating that a vendor-specific operation has completed.
    ///Params:
    ///    vendorOperation = An IMbnVendorSpecificOperation interface representing the operation that completed.
    ///    vendorSpecificData = A byte array containing the data returned by underlying miniport driver.
    ///    requestID = A request ID assigned by the Mobile Broadband service to identify the vendor-specific operation request.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSetVendorSpecificComplete(IMbnVendorSpecificOperation vendorOperation, SAFEARRAY* vendorSpecificData, 
                                        uint requestID);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This notification interface signals an application about the arrival and removal of IMbnConnectionProfile interfaces
///in the system.
@GUID("DCBBBAB6-201F-4BBB-AAEE-338E368AF6FA")
interface IMbnConnectionProfileManagerEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that indicates a new connection profile has been added to the system.
    ///Params:
    ///    newConnectionProfile = An IMbnConnectionProfile interface that represents a connection profile that has been added.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnConnectionProfileArrival(IMbnConnectionProfile newConnectionProfile);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that indicates a connection profile has been removed from the system.
    ///Params:
    ///    oldConnectionProfile = An IMbnConnectionProfile interface that represents a connection profile that has been removed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnConnectionProfileRemoval(IMbnConnectionProfile oldConnectionProfile);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///The <b>IMbnRadio</b> interface is used to query and update the radio state of Mobile Broadband devices.
@GUID("DCCCCAB6-201F-4BBB-AAEE-338E368AF6FA")
interface IMbnRadio : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The software radio state of a Mobile Broadband device. This property is read-only.
    HRESULT get_SoftwareRadioState(MBN_RADIO* SoftwareRadioState);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The hardware radio state of a Mobile Broadband device. This property is read-only.
    HRESULT get_HardwareRadioState(MBN_RADIO* HardwareRadioState);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Sets the software radio state of a Mobile Broadband device.
    ///Params:
    ///    radioState = A MBN_RADIO value that specifies the new software radio state.
    ///    requestID = A pointer to a request ID assigned by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is
    ///    invalid. Most likely,the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The
    ///    interface is invalid. Most likely the Mobile Broadband device has been removed from the system. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl> </td> <td
    ///    width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> </table>
    ///    
    HRESULT SetSoftwareRadioState(MBN_RADIO radioState, uint* requestID);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Notification interface used to indicate a change in the radio state as well as the completion of a programatic change
///in the state .
@GUID("DCDDDAB6-201F-4BBB-AAEE-338E368AF6FA")
interface IMbnRadioEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. A notification signaling that the radio state of the device has changed.
    ///Params:
    ///    newInterface = Pointer to an IMbnRadio interface representing the device for which the radio state has changed.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnRadioStateChange(IMbnRadio newInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification that a set software radio state operation has completed.
    ///Params:
    ///    newInterface = Pointer to an IMbnRadio interface representing the device for which a set radio state operation has
    ///                   completed.
    ///    requestID = The request ID set by the Mobile Broadband service to identify the request.
    ///    status = A status code that indicates the outcome of the set radio state operation. A calling application can expect
    ///             one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///             id="S_OK"></a><a id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was
    ///             successful. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSetSoftwareRadioStateComplete(IMbnRadio newInterface, uint requestID, HRESULT status);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This interface exposes the multi-carrier functionality of a capable Mobile Broadband device.
@GUID("DCBBBAB6-2020-4BBB-AAEE-338E368AF6FA")
interface IMbnMultiCarrier : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Updates the home provider for a multi-carrier device.
    ///Params:
    ///    homeProvider = An MBN_PROVIDER2 structure that contains the home provider. <div class="alert"><b>Note</b> <p
    ///                   class="note">The <b>SignalStrength</b> and <b>SignalError</b> members must be 0. </div> <div> </div>
    ///    requestID = A pointer to the request ID set by the operating system for this request. The asynchronous response from
    ///                OnSetHomeProviderComplete will contain this same <i>requestID</i>. Pointer to the request ID set by the
    ///                operating system for this request. The asynchronous response will contain this same requestID.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface. The Mobile
    ///    Broadband device has probably been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most
    ///    likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The operation is not
    ///    supported by the device. This may be returned by devices which do not support multi-carrier. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetHomeProvider(MBN_PROVIDER2* homeProvider, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the list of subscribed providers visible in the current area for a multi-carrier device minus the
    ///current registered provider.
    ///Params:
    ///    preferredMulticarrierProviders = Pointer to an array of MBN_PROVIDER2 structures that contain the list of preferred providers. If this method
    ///                                     returns any value other than <b>S_OK</b>, <i>preferredMultiCarrierProviders</i> is <b>NULL</b>. When
    ///                                     <b>GetPreferredProviders</b> returns <b>S_OK</b>, the calling application must free the allocated memory by
    ///                                     calling SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    <i>preferredMultiCarrierProviders</i> contains valid values. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The information is not available. The Mobile Broadband
    ///    service is currently probing for the list of preferred providers. The calling application can get notified
    ///    when the data is available by registering for the OnPreferredProvidersChange method of
    ///    IMbnMultiCarrierEvents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_PIN_REQUIRED</b></dt> </dl> </td>
    ///    <td width="60%"> The device requires that a PIN must be entered for this operation. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_MBN_SIM_NOT_INSERTED</b></dt> </dl> </td> <td width="60%"> The SIM is not
    ///    inserted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_MBN_BAD_SIM</b></dt> </dl> </td> <td width="60%"> A
    ///    bad SIM is inserted in the device. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_READ_FAULT)</b></dt> </dl> </td> <td width="60%"> Unable to read from the SIM
    ///    or device memory. For example, the SIM does not have preferred provider information provisioned. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td
    ///    width="60%"> The device does not support this operation. CDMA devices will always return this value. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td
    ///    width="60%"> The operation is not supported by the device. This may be returned by devices which do not
    ///    support multi-carrier. </td> </tr> </table>
    ///    
    HRESULT GetPreferredProviders(SAFEARRAY** preferredMulticarrierProviders);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the list of visible providers in the current area for a multi-carrier device minus preferred and
    ///registered providers.
    ///Params:
    ///    age = A pointer to the time, in seconds, since the last refresh of the visible provider list for the device.
    ///    visibleProviders = Pointer to an array of MBN_PROVIDER2 structures that contains the list of providers for the interface. If
    ///                       this method returns any value other than <b>S_OK</b>, <i>visibleProviders</i> is <b>NULL</b>. When
    ///                       <b>GetVisibleProviders</b> returns <b>S_OK</b>, the calling application must free the allocated memory by
    ///                       calling SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    <i>visibleProviders</i> contains valid values. Based on the age of the information, the calling application
    ///    can decide to issue a new call to ScanNetwork </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The information is not available. An active network
    ///    scan is in progress. The calling application can get notified when the device capabilities are available by
    ///    registering for the OnScanNetworkComplete method of IMbnMultiCarrierEvents </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_MBN_INVALID_CACHE</b></dt> </dl> </td> <td width="60%"> Mobile Broadband's cache of the visible
    ///    network list is invalid. The calling application should call ScanNetwork to populate the cache. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td
    ///    width="60%"> The operation is not supported by the device. This may be returned by devices which do not
    ///    support multi-carrier. </td> </tr> </table>
    ///    
    HRESULT GetVisibleProviders(uint* age, SAFEARRAY** visibleProviders);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the list of supported cellular classes for a multi-carrier device.
    ///Params:
    ///    cellularClasses = Pointer to an array of MBN_CELLULAR_CLASS enumerations that contain the list of supported cellular classes.
    ///                      If this method returns any value other than <b>S_OK</b>, <i>cellularClass</i> is <b>NULL</b>. When
    ///                      <b>GetSupportedCellularClasses</b> returns <b>S_OK</b>, the calling application must free the allocated
    ///                      memory by calling SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface. The Mobile
    ///    Broadband device has probably been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most
    ///    likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The operation is not
    ///    supported by the device. This may be returned by devices which do not support multi-carrier. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSupportedCellularClasses(SAFEARRAY** cellularClasses);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the current cellular classes for a multi-carrier device.
    ///Params:
    ///    currentCellularClass = MBN_CELLULAR_CLASS Pointer to an MBN_CELLULAR_CLASS enumeration that specifies the current cellular class. If
    ///                           this method returns any value other than <b>S_OK</b>, <i>currentCellularClass</i> is <b>NULL</b>. When
    ///                           <b>GetCurrentCellularClass</b> returns <b>S_OK</b>, the calling application must free the allocated memory by
    ///                           calling SafeArrayDestroy.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface. The Mobile
    ///    Broadband device has probably been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most
    ///    likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The operation is not
    ///    supported by the device. This may be returned by devices which do not support multi-carrier. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetCurrentCellularClass(MBN_CELLULAR_CLASS* currentCellularClass);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Scans the network to get a list of visible providers for a multi-carrier device.
    ///Params:
    ///    requestID = Pointer to the request ID set by the operating system for this request. The asynchronous response from
    ///                OnScanNetworkComplete will contain this same <i>requestID</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface is invalid. Most likely
    ///    because the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The interface is invalid.
    ///    Most likely because the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The
    ///    operation is not supported by the device. This may be returned by devices which do not support multi-carrier.
    ///    </td> </tr> </table>
    ///    
    HRESULT ScanNetwork(uint* requestID);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///This interface is a notification interface used to handle asynchronous IMbnMultiCarrier method calls.
@GUID("DCDDDAB6-2021-4BBB-AAEE-338E368AF6FA")
interface IMbnMultiCarrierEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate the completion of a
    ///SetHomeProvider operation.
    ///Params:
    ///    mbnInterface = An IMbnMultiCarrier object that represents the Mobile Broadband device SetHomeProvider operation.
    ///    requestID = The request ID assigned by the Mobile Broadband service to the SetHomeProvider operation.
    ///    status = A status code that indicates the outcome of SetHomeProvider. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///             </tr> <tr> <td width="40%"><a id="S_OK"></a><a id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///             width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_PROVIDER_NOT_VISIBLE"></a><a id="e_mbn_provider_not_visible"></a><dl>
    ///             <dt><b>E_MBN_PROVIDER_NOT_VISIBLE</b></dt> </dl> </td> <td width="60%"> The requested provider is not
    ///             visible. </td> </tr> <tr> <td width="40%"><a id="E_INVALIDARG"></a><a id="e_invalidarg"></a><dl>
    ///             <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid registration mode input, the provider ID
    ///             provided as input is longer than the maximum length 7 characters, or data class provided is invalid. The
    ///             Mobile Broadband service will not send the request to the device when invalid arguments are provided in the
    ///             input. In manual registration mode, this indicates that the requested provider is forbidden. </td> </tr> <tr>
    ///             <td width="40%"><a id="E_FAIL"></a><a id="e_fail"></a><dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///             width="60%"> The operation could not be completed. More information is available in the network error code.
    ///             </td> </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The operation is not supported by the device. This may be returned by devices
    ///             which do not support multi-carrier. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnSetHomeProviderComplete(IMbnMultiCarrier mbnInterface, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate the completion of a
    ///GetCurrentCellularClass operation.
    ///Params:
    ///    mbnInterface = An IMbnMultiCarrier object that represents the Mobile Broadband device GetCurrentCellularClass operation.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
    ///    </tr> </table>
    ///    
    HRESULT OnCurrentCellularClassChange(IMbnMultiCarrier mbnInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate the completion of a
    ///GetPreferredProviders operation and a change in a device's preferred provider list.
    ///Params:
    ///    mbnInterface = IMbnMultiCarrier An IMbnMultiCarrier object that represents the Mobile Broadband device GetPreferredProviders
    ///                   operation.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnPreferredProvidersChange(IMbnMultiCarrier mbnInterface);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate the completion of a
    ///ScanNetwork operation.
    ///Params:
    ///    mbnInterface = An IMbnMultiCarrier object that represents the Mobile Broadband device ScanNetwork operation.
    ///    requestID = The request ID assigned by the Mobile Broadband service to the ScanNetwork operation.
    ///    status = A status code that indicates the outcome of ScanNetwork. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///             <tr> <td width="40%"><a id="S_OK"></a><a id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///             The operation was successful. </td> </tr> <tr> <td width="40%"><a id="E_MBN_RADIO_POWER_OFF"></a><a
    ///             id="e_mbn_radio_power_off"></a><dl> <dt><b>E_MBN_RADIO_POWER_OFF</b></dt> </dl> </td> <td width="60%"> Can't
    ///             get a visible network list because the device radio is off. The application can issue a network scan request
    ///             when it gets the radio-turned-on notification. </td> </tr> <tr> <td width="40%"><a
    ///             id="E_MBN_DEVICE_BUSY"></a><a id="e_mbn_device_busy"></a><dl> <dt><b>E_MBN_DEVICE_BUSY</b></dt> </dl> </td>
    ///             <td width="60%"> The device is busy and can't currently perform a network scan operation. This is returned by
    ///             devices which don't support a network scan operation when it has a data connection established. </td> </tr>
    ///             <tr> <td width="40%"><a id="E_MBN_ALREADY_ACTIVE"></a><a id="e_mbn_already_active"></a><dl>
    ///             <dt><b>E_MBN_ALREADY_ACTIVE</b></dt> </dl> </td> <td width="60%"> A network scan operation is already in
    ///             progress. </td> </tr> <tr> <td width="40%"><a id="HRESULT_FROM_WIN32_ERROR_NOT_SUPPORTED_"></a><a
    ///             id="hresult_from_win32_error_not_supported_"></a><dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///             </dl> </td> <td width="60%"> The operation is not supported by the device. This may be returned by devices
    ///             which do not support multi-carrier. </td> </tr> </table>
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnScanNetworkComplete(IMbnMultiCarrier mbnInterface, uint requestID, HRESULT status);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. This notification method is called by the Mobile Broadband service to indicate the completion of a
    ///SetHomeProvider operation that updates the interface capabilities.
    ///Params:
    ///    mbnInterface = An IMbnMultiCarrier object that represents the Mobile Broadband device.
    ///Returns:
    ///    This method must return <b>S_OK</b>.
    ///    
    HRESULT OnInterfaceCapabilityChange(IMbnMultiCarrier mbnInterface);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Provides access to IMbnDeviceServicesContext objects and Mobile Broadband device service notifications.
@GUID("20A26258-6811-4478-AC1D-13324E45E41C")
interface IMbnDeviceServicesManager : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the IMbnDeviceServicesContext interface for a specific Mobile Broadband device
    ///Params:
    ///    networkInterfaceID = A string that contains the ID of the Mobile Broadband device. The ID can be obtained using the InterfaceID
    ///                         property
    ///    mbnDevicesContext = Pointer to the address of the IMbnDeviceServicesContext for the device specified by <i>networkInterfaceID</i>
    ///                        or <b>NULL</b> if there is no matching interface.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt>
    ///    </dl> </td> <td width="60%"> There is no available device matching the specified interface ID. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>mbnDeviceServicesContext</i> parameter is NULL. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Could not allocate the required memory. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetDeviceServicesContext(BSTR networkInterfaceID, IMbnDeviceServicesContext* mbnDevicesContext);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Allows for enumerating and retrieving Mobile Broadband device objects on the system.
@GUID("FC5AC347-1592-4068-80BB-6A57580150D8")
interface IMbnDeviceServicesContext : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the list of supported device services by the Mobile Broadband device.
    ///Params:
    ///    deviceServices = Pointer to an array of MBN_DEVICE_SERVICE structures that contains the list of device service supported by
    ///                     the device. If <b>EnumerateDeviceServices</b> returns any value other than <b>S_OK</b>, <i>deviceServices</i>
    ///                     is <b>NULL</b>. Otherwise, upon completion, the calling program must free the allocated memory. Before
    ///                     freeing the array by calling SafeArrayDestroy, the calling program must also free all the <b>BSTRs</b> in
    ///                     the<b>MBN_DEVICE_SERVICE</b> structure by calling SysFreeString.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///    </dl> </td> <td width="60%"> The device does not support any device services. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The information is not available.
    ///    The Mobile Broadband service is currently probing the device to retrieve this information. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error was encountered when
    ///    executing this method. </td> </tr> </table>
    ///    
    HRESULT EnumerateDeviceServices(SAFEARRAY** deviceServices);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the IMbnDeviceService object that can be used for communicating with a device service on the
    ///Mobile Broadband device.
    ///Params:
    ///    deviceServiceID = The deviceServiceID of the Mobile Broadband device.
    ///    mbnDeviceService = The IMbnDeviceService object.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An
    ///    error was encountered when executing this method. </td> </tr> </table>
    ///    
    HRESULT GetDeviceService(BSTR deviceServiceID, IMbnDeviceService* mbnDeviceService);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The maximum length, in bytes, of data that can be associated with a device service <b>SET</b> or
    ///<b>QUERY</b> command. This property is read-only.
    HRESULT get_MaxCommandSize(uint* maxCommandSize);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The maximum length, in bytes, of data that can be written to or read from a device service session.
    ///This property is read-only.
    HRESULT get_MaxDataSize(uint* maxDataSize);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Signals an application about notification events related to Mobile Broadband device services on the system.
@GUID("0A900C19-6824-4E97-B76E-CF239D0CA642")
interface IMbnDeviceServicesEvents : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating that a query for the messages supported on a device service has
    ///completed.
    ///Params:
    ///    deviceService = The IMbnDeviceService object on which the query was requested.
    ///    commandIDList = An array that contains the list of command IDs supported by the device service. This field is valid only if
    ///                    the status is <b>S_OK</b>.
    ///    status = A status code that indicates the outcome of the operation.
    ///    requestID = The request ID that was assigned by the Mobile Broadband service to the query operation request.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnQuerySupportedCommandsComplete(IMbnDeviceService deviceService, SAFEARRAY* commandIDList, 
                                             HRESULT status, uint requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating that a device service <b>CommandSessionOpen</b> request has completed.
    ///Params:
    ///    deviceService = The IMbnDeviceService object on which the <b>CommandSessionOpen</b> was requested.
    ///    status = A status code that indicates the outcome of the operation.
    ///    requestID = The request ID that was assigned by the Mobile Broadband service to the <b>CommandSessionOpen</b> request.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnOpenCommandSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating that a device service <b>CloseCommandSession</b> request has completed.
    ///Params:
    ///    deviceService = The IMbnDeviceService object on which the <b>CloseCommandSession</b> was requested.
    ///    status = A status code that indicates the outcome of the operation.
    ///    requestID = The request ID that was assigned by the Mobile Broadband service to the close request.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnCloseCommandSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating that a device service <b>SET</b> request has completed.
    ///Params:
    ///    deviceService = The IMbnDeviceService object on which the operation was requested.
    ///    responseID = An identifier for the response.
    ///    deviceServiceData = A byte array containing the data returned by the device. If the response is fragmented across multiple
    ///                        indications, this only contains the information for one fragment. This field is valid only if the status is
    ///                        <b>S_OK</b>.
    ///    status = A status code that indicates the outcome of the operation.
    ///    requestID = The request ID that was assigned by the Mobile Broadband service to the set operation request.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnSetCommandComplete(IMbnDeviceService deviceService, uint responseID, SAFEARRAY* deviceServiceData, 
                                 HRESULT status, uint requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating that a device service <b>QUERY</b> request has completed.
    ///Params:
    ///    deviceService = The IMbnDeviceService object on which the operation was requested.
    ///    responseID = A identifier for the response.
    ///    deviceServiceData = A byte array containing the data returned by the device. If the response is fragmented across multiple
    ///                        indications, this only contains the information for one fragment. This field is valid only if the status is
    ///                        <b>S_OK</b>.
    ///    status = A status code that indicates the outcome of the operation.
    ///    requestID = The request ID that was assigned by the Mobile Broadband service to the query operation request.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnQueryCommandComplete(IMbnDeviceService deviceService, uint responseID, SAFEARRAY* deviceServiceData, 
                                   HRESULT status, uint requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method signaling a device service state change event from the Mobile Broadband device.
    ///Params:
    ///    deviceService = The IMbnDeviceService object for which the event notification was received.
    ///    eventID = An identifier for the event.
    ///    deviceServiceData = A byte array containing the data returned by underlying device.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnEventNotification(IMbnDeviceService deviceService, uint eventID, SAFEARRAY* deviceServiceData);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating that a device service <b>OpenDataSession</b> request has completed.
    ///Params:
    ///    deviceService = The IMbnDeviceService object on which the <b>OpenDataSession</b> was requested.
    ///    status = A status code that indicates the outcome of the operation.
    ///    requestID = The request ID that was assigned by the Mobile Broadband service to the <b>OpenDataSession</b> request.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnOpenDataSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating that a device service session <b>CloseDataSession</b> request has
    ///completed.
    ///Params:
    ///    deviceService = The IMbnDeviceService session object on which the <b>CloseDataSession</b> was requested.
    ///    status = A status code that indicates the outcome of the operation.
    ///    requestID = The request ID that was assigned by the Mobile Broadband service to the <b>CloseDataSession</b> request.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnCloseDataSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method indicating that a device service session <b>Write</b> request has completed.
    ///Params:
    ///    deviceService = The IMbnDeviceService session object on which the <b>Write</b> was requested.
    ///    status = A status code that indicates the outcome of the operation.
    ///    requestID = The request ID that was assigned by the Mobile Broadband service to the <b>Write</b> request.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnWriteDataComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification for data being read from a device service data session.
    ///Params:
    ///    deviceService = The IMbnDeviceService session object on which the data was read.
    ///    deviceServiceData = A byte array containing the data read from the underlying device service session.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnReadData(IMbnDeviceService deviceService, SAFEARRAY* deviceServiceData);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Notification method that signals a change in the state of device services on the system.
    ///Params:
    ///    interfaceID = The InterfaceID of the device for which the device services state change notification is sent.
    ///    stateChange = A MBN_DEVICE_SERVICES_INTERFACE_STATE enumeration that specifies whether the device service capable device is
    ///                  available or unavailable.
    ///Returns:
    ///    The method must return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnInterfaceStateChange(BSTR interfaceID, MBN_DEVICE_SERVICES_INTERFACE_STATE stateChange);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Allows for communicating with a device service on a particular Mobile Broadband device.
@GUID("B3BB9A71-DC70-4BE9-A4DA-7886AE8B191B")
interface IMbnDeviceService : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the list of commands IDs supported by the Mobile Broadband device service.
    ///Params:
    ///    requestID = A unique request ID assigned by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> This device service command is not allowed for calling process privileges. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error was encountered when executing
    ///    this method. </td> </tr> </table>
    ///    
    HRESULT QuerySupportedCommands(uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Opens a command session to a device service on a Mobile Broadband device.
    ///Params:
    ///    requestID = A unique request ID assigned by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> This device service command is not allowed for calling process privileges. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error was encountered when executing
    ///    this method. </td> </tr> </table>
    ///    
    HRESULT OpenCommandSession(uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Closes a command session to a device service on a Mobile Broadband device.
    ///Params:
    ///    requestID = A unique request ID assigned by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> This device service command is not allowed for calling process privileges. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error was encountered when executing
    ///    this method. </td> </tr> </table>
    ///    
    HRESULT CloseCommandSession(uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Sends a <b>SET</b> control command to the device service of a Mobile Broadband device.
    ///Params:
    ///    commandID = An identifier for the command.
    ///    deviceServiceData = A byte array that is passed in to the device.
    ///    requestID = A unique request ID assigned by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> This device service command is not allowed for calling process privileges. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error was encountered when executing
    ///    this method. </td> </tr> </table>
    ///    
    HRESULT SetCommand(uint commandID, SAFEARRAY* deviceServiceData, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Sends a <b>QUERY</b> control command to the device service of a Mobile Broadband device.
    ///Params:
    ///    commandID = An identifier for the command.
    ///    deviceServiceData = A byte array that is passed in to the device.
    ///    requestID = A unique request ID assigned by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> This device service command is not allowed for calling process privileges. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error was encountered when executing
    ///    this method. </td> </tr> </table>
    ///    
    HRESULT QueryCommand(uint commandID, SAFEARRAY* deviceServiceData, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Open a data session to the device service on a Mobile Broadband device.
    ///Params:
    ///    requestID = A unique request ID assigned by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> This device service command is not allowed for calling process privileges. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_TOO_MANY_SESS)</b></dt> </dl> </td> <td width="60%"> The
    ///    device service has reached the maximum number of sessions it can support </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error was encountered when executing this method.
    ///    </td> </tr> </table>
    ///    
    HRESULT OpenDataSession(uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Closes the data session to a device service on a Mobile Broadband device.
    ///Params:
    ///    requestID = A unique request ID assigned by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> This device service command is not allowed for calling process privileges. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error was encountered when executing
    ///    this method. </td> </tr> </table>
    ///    
    HRESULT CloseDataSession(uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Write data to a device service data session.
    ///Params:
    ///    deviceServiceData = A byte array that is passed in to the device to write.
    ///    requestID = A unique request ID assigned by the Mobile Broadband service to identify this request.
    ///Returns:
    ///    The method can return one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> This device service command is not allowed for calling process privileges. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_BUFFER_OVERFLOW)</b></dt> </dl> </td> <td width="60%"> The
    ///    length of the <i>deviceServiceData</i> is greater than the supported MaxDataSize. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_OPEN_FAILED)</b></dt> </dl> </td> <td width="60%"> The
    ///    device service session is not open. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td>
    ///    <td width="60%"> An error was encountered when executing this method. </td> </tr> </table>
    ///    
    HRESULT WriteData(SAFEARRAY* deviceServiceData, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The interface ID of the Mobile Broadband device to which this object is associated. This property is
    ///read-only.
    HRESULT get_InterfaceID(BSTR* InterfaceID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The ID of the device service to which this object is associated. This property is read-only.
    HRESULT get_DeviceServiceID(BSTR* DeviceServiceID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Reports if the device service command session is open. This property is read-only.
    HRESULT get_IsCommandSessionOpen(BOOL* value);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Reports if the device service data session is open. This property is read-only.
    HRESULT get_IsDataSessionOpen(BOOL* value);
}

///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by the
///Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity) namespace.
///Represents the device PIN.
@GUID("DCBBBAB6-2007-4BBB-AAEE-338E368AF6FA")
interface IMbnPin : IUnknown
{
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The PIN type. This property is read-only.
    HRESULT get_PinType(MBN_PIN_TYPE* PinType);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The PIN format. This property is read-only.
    HRESULT get_PinFormat(MBN_PIN_FORMAT* PinFormat);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The minimum length of the PIN. This property is read-only.
    HRESULT get_PinLengthMin(uint* PinLengthMin);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The maximum length of the PIN. This property is read-only.
    HRESULT get_PinLengthMax(uint* PinLengthMax);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. The PIN mode. This property is read-only.
    HRESULT get_PinMode(MBN_PIN_MODE* PinMode);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Enables a PIN.
    ///Params:
    ///    pin = The PIN value for the PIN type to be enabled.
    ///    requestID = A request ID set by the Mobile Broadband service to identify this asynchronous request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface. The Mobile
    ///    Broadband device has probably been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most
    ///    likely the Mobile Broadband device has been removed from the system. </td> </tr> </table>
    ///    
    HRESULT Enable(const(PWSTR) pin, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Disables a PIN.
    ///Params:
    ///    pin = The PIN value for the PIN type to be disabled.
    ///    requestID = A request ID set by the Mobile Broadband service to identify this asynchronous request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface. The Mobile
    ///    Broadband device has probably been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most
    ///    likely the Mobile Broadband device has been removed from the system. </td> </tr> </table>
    ///    
    HRESULT Disable(const(PWSTR) pin, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Enters a PIN.
    ///Params:
    ///    pin = The PIN value for the PIN type.
    ///    requestID = A request ID set by the Mobile Broadband service to identify this asynchronous request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface. The Mobile
    ///    Broadband device has probably been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most
    ///    likely the Mobile Broadband device has been removed from the system. </td> </tr> </table>
    ///    
    HRESULT Enter(const(PWSTR) pin, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Changes the PIN.
    ///Params:
    ///    pin = The current PIN for this PIN type.
    ///    newPin = The new PIN for this PIN type.
    ///    requestID = A request ID set by the Mobile Broadband service to identify this asynchronous request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface. The Mobile
    ///    Broadband device has probably been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most
    ///    likely the Mobile Broadband device has been removed from the system. </td> </tr> </table>
    ///    
    HRESULT Change(const(PWSTR) pin, const(PWSTR) newPin, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Unblocks a blocked PIN.
    ///Params:
    ///    puk = The password unblock key (PUK) value for this PIN type.
    ///    newPin = A new PIN to be set for this PIN type.
    ///    requestID = A request ID set by the Mobile Broadband service to identify this asynchronous request.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)</b></dt> </dl>
    ///    </td> <td width="60%"> The Mobile Broadband service is not running on this system. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface. The Mobile
    ///    Broadband device has probably been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Invalid interface. Most
    ///    likely the Mobile Broadband device has been removed from the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This method is not allowed for calling process
    ///    privileges. </td> </tr> </table>
    ///    
    HRESULT Unblock(const(PWSTR) puk, const(PWSTR) newPin, uint* requestID);
    ///> [!IMPORTANT] > Starting in Windows 10, version 1803, the Win32 APIs described in this section are replaced by
    ///the Windows Runtime APIs in the [Windows.Networking.Connectivity](/uwp/api/windows.networking.connectivity)
    ///namespace. Gets the IMbnPinManager.
    ///Params:
    ///    pinManager = Pointer to the address of an IMbnPinManager to manage the PIN type. When this function returns anything other
    ///                 than S_OK, this value is <b>NULL</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPinManager(IMbnPinManager* pinManager);
}


// GUIDs


const GUID IID_IMbnConnection                     = GUIDOF!IMbnConnection;
const GUID IID_IMbnConnectionContext              = GUIDOF!IMbnConnectionContext;
const GUID IID_IMbnConnectionContextEvents        = GUIDOF!IMbnConnectionContextEvents;
const GUID IID_IMbnConnectionEvents               = GUIDOF!IMbnConnectionEvents;
const GUID IID_IMbnConnectionManager              = GUIDOF!IMbnConnectionManager;
const GUID IID_IMbnConnectionManagerEvents        = GUIDOF!IMbnConnectionManagerEvents;
const GUID IID_IMbnConnectionProfile              = GUIDOF!IMbnConnectionProfile;
const GUID IID_IMbnConnectionProfileEvents        = GUIDOF!IMbnConnectionProfileEvents;
const GUID IID_IMbnConnectionProfileManager       = GUIDOF!IMbnConnectionProfileManager;
const GUID IID_IMbnConnectionProfileManagerEvents = GUIDOF!IMbnConnectionProfileManagerEvents;
const GUID IID_IMbnDeviceService                  = GUIDOF!IMbnDeviceService;
const GUID IID_IMbnDeviceServicesContext          = GUIDOF!IMbnDeviceServicesContext;
const GUID IID_IMbnDeviceServicesEvents           = GUIDOF!IMbnDeviceServicesEvents;
const GUID IID_IMbnDeviceServicesManager          = GUIDOF!IMbnDeviceServicesManager;
const GUID IID_IMbnInterface                      = GUIDOF!IMbnInterface;
const GUID IID_IMbnInterfaceEvents                = GUIDOF!IMbnInterfaceEvents;
const GUID IID_IMbnInterfaceManager               = GUIDOF!IMbnInterfaceManager;
const GUID IID_IMbnInterfaceManagerEvents         = GUIDOF!IMbnInterfaceManagerEvents;
const GUID IID_IMbnMultiCarrier                   = GUIDOF!IMbnMultiCarrier;
const GUID IID_IMbnMultiCarrierEvents             = GUIDOF!IMbnMultiCarrierEvents;
const GUID IID_IMbnPin                            = GUIDOF!IMbnPin;
const GUID IID_IMbnPinEvents                      = GUIDOF!IMbnPinEvents;
const GUID IID_IMbnPinManager                     = GUIDOF!IMbnPinManager;
const GUID IID_IMbnPinManagerEvents               = GUIDOF!IMbnPinManagerEvents;
const GUID IID_IMbnRadio                          = GUIDOF!IMbnRadio;
const GUID IID_IMbnRadioEvents                    = GUIDOF!IMbnRadioEvents;
const GUID IID_IMbnRegistration                   = GUIDOF!IMbnRegistration;
const GUID IID_IMbnRegistrationEvents             = GUIDOF!IMbnRegistrationEvents;
const GUID IID_IMbnServiceActivation              = GUIDOF!IMbnServiceActivation;
const GUID IID_IMbnServiceActivationEvents        = GUIDOF!IMbnServiceActivationEvents;
const GUID IID_IMbnSignal                         = GUIDOF!IMbnSignal;
const GUID IID_IMbnSignalEvents                   = GUIDOF!IMbnSignalEvents;
const GUID IID_IMbnSms                            = GUIDOF!IMbnSms;
const GUID IID_IMbnSmsConfiguration               = GUIDOF!IMbnSmsConfiguration;
const GUID IID_IMbnSmsEvents                      = GUIDOF!IMbnSmsEvents;
const GUID IID_IMbnSmsReadMsgPdu                  = GUIDOF!IMbnSmsReadMsgPdu;
const GUID IID_IMbnSmsReadMsgTextCdma             = GUIDOF!IMbnSmsReadMsgTextCdma;
const GUID IID_IMbnSubscriberInformation          = GUIDOF!IMbnSubscriberInformation;
const GUID IID_IMbnVendorSpecificEvents           = GUIDOF!IMbnVendorSpecificEvents;
const GUID IID_IMbnVendorSpecificOperation        = GUIDOF!IMbnVendorSpecificOperation;
