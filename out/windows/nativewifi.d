// Written in the D programming language.

module windows.nativewifi;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.extensibleauthenticationprotocol : EAP_METHOD_TYPE;
public import windows.iphelper : NET_LUID_LH;
public import windows.networkdrivers : L2_NOTIFICATION_DATA, NET_IF_DIRECTION_TYPE,
                                       NET_IF_MEDIA_CONNECT_STATE,
                                       NET_IF_MEDIA_DUPLEX_STATE, NET_IF_OPER_STATUS;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


alias DOT11_BSS_TYPE = int;
enum : int
{
    dot11_BSS_type_infrastructure = 0x00000001,
    dot11_BSS_type_independent    = 0x00000002,
    dot11_BSS_type_any            = 0x00000003,
}

alias DOT11_AUTH_ALGORITHM = int;
enum : int
{
    DOT11_AUTH_ALGO_80211_OPEN       = 0x00000001,
    DOT11_AUTH_ALGO_80211_SHARED_KEY = 0x00000002,
    DOT11_AUTH_ALGO_WPA              = 0x00000003,
    DOT11_AUTH_ALGO_WPA_PSK          = 0x00000004,
    DOT11_AUTH_ALGO_WPA_NONE         = 0x00000005,
    DOT11_AUTH_ALGO_RSNA             = 0x00000006,
    DOT11_AUTH_ALGO_RSNA_PSK         = 0x00000007,
    DOT11_AUTH_ALGO_WPA3             = 0x00000008,
    DOT11_AUTH_ALGO_WPA3_SAE         = 0x00000009,
    DOT11_AUTH_ALGO_OWE              = 0x0000000a,
    DOT11_AUTH_ALGO_IHV_START        = 0x80000000,
    DOT11_AUTH_ALGO_IHV_END          = 0xffffffff,
}

alias DOT11_CIPHER_ALGORITHM = int;
enum : int
{
    DOT11_CIPHER_ALGO_NONE          = 0x00000000,
    DOT11_CIPHER_ALGO_WEP40         = 0x00000001,
    DOT11_CIPHER_ALGO_TKIP          = 0x00000002,
    DOT11_CIPHER_ALGO_CCMP          = 0x00000004,
    DOT11_CIPHER_ALGO_WEP104        = 0x00000005,
    DOT11_CIPHER_ALGO_BIP           = 0x00000006,
    DOT11_CIPHER_ALGO_GCMP          = 0x00000008,
    DOT11_CIPHER_ALGO_GCMP_256      = 0x00000009,
    DOT11_CIPHER_ALGO_CCMP_256      = 0x0000000a,
    DOT11_CIPHER_ALGO_BIP_GMAC_128  = 0x0000000b,
    DOT11_CIPHER_ALGO_BIP_GMAC_256  = 0x0000000c,
    DOT11_CIPHER_ALGO_BIP_CMAC_256  = 0x0000000d,
    DOT11_CIPHER_ALGO_WPA_USE_GROUP = 0x00000100,
    DOT11_CIPHER_ALGO_RSN_USE_GROUP = 0x00000100,
    DOT11_CIPHER_ALGO_WEP           = 0x00000101,
    DOT11_CIPHER_ALGO_IHV_START     = 0x80000000,
    DOT11_CIPHER_ALGO_IHV_END       = 0xffffffff,
}

alias NDIS_REQUEST_TYPE = int;
enum : int
{
    NdisRequestQueryInformation = 0x00000000,
    NdisRequestSetInformation   = 0x00000001,
    NdisRequestQueryStatistics  = 0x00000002,
    NdisRequestOpen             = 0x00000003,
    NdisRequestClose            = 0x00000004,
    NdisRequestSend             = 0x00000005,
    NdisRequestTransferData     = 0x00000006,
    NdisRequestReset            = 0x00000007,
    NdisRequestGeneric1         = 0x00000008,
    NdisRequestGeneric2         = 0x00000009,
    NdisRequestGeneric3         = 0x0000000a,
    NdisRequestGeneric4         = 0x0000000b,
}

alias NDIS_INTERRUPT_MODERATION = int;
enum : int
{
    NdisInterruptModerationUnknown      = 0x00000000,
    NdisInterruptModerationNotSupported = 0x00000001,
    NdisInterruptModerationEnabled      = 0x00000002,
    NdisInterruptModerationDisabled     = 0x00000003,
}

alias NDIS_802_11_STATUS_TYPE = int;
enum : int
{
    Ndis802_11StatusType_Authentication      = 0x00000000,
    Ndis802_11StatusType_MediaStreamMode     = 0x00000001,
    Ndis802_11StatusType_PMKID_CandidateList = 0x00000002,
    Ndis802_11StatusTypeMax                  = 0x00000003,
}

alias NDIS_802_11_NETWORK_TYPE = int;
enum : int
{
    Ndis802_11FH             = 0x00000000,
    Ndis802_11DS             = 0x00000001,
    Ndis802_11OFDM5          = 0x00000002,
    Ndis802_11OFDM24         = 0x00000003,
    Ndis802_11Automode       = 0x00000004,
    Ndis802_11NetworkTypeMax = 0x00000005,
}

alias NDIS_802_11_POWER_MODE = int;
enum : int
{
    Ndis802_11PowerModeCAM      = 0x00000000,
    Ndis802_11PowerModeMAX_PSP  = 0x00000001,
    Ndis802_11PowerModeFast_PSP = 0x00000002,
    Ndis802_11PowerModeMax      = 0x00000003,
}

alias NDIS_802_11_NETWORK_INFRASTRUCTURE = int;
enum : int
{
    Ndis802_11IBSS              = 0x00000000,
    Ndis802_11Infrastructure    = 0x00000001,
    Ndis802_11AutoUnknown       = 0x00000002,
    Ndis802_11InfrastructureMax = 0x00000003,
}

alias NDIS_802_11_AUTHENTICATION_MODE = int;
enum : int
{
    Ndis802_11AuthModeOpen       = 0x00000000,
    Ndis802_11AuthModeShared     = 0x00000001,
    Ndis802_11AuthModeAutoSwitch = 0x00000002,
    Ndis802_11AuthModeWPA        = 0x00000003,
    Ndis802_11AuthModeWPAPSK     = 0x00000004,
    Ndis802_11AuthModeWPANone    = 0x00000005,
    Ndis802_11AuthModeWPA2       = 0x00000006,
    Ndis802_11AuthModeWPA2PSK    = 0x00000007,
    Ndis802_11AuthModeWPA3       = 0x00000008,
    Ndis802_11AuthModeWPA3SAE    = 0x00000009,
    Ndis802_11AuthModeMax        = 0x0000000a,
}

alias NDIS_802_11_PRIVACY_FILTER = int;
enum : int
{
    Ndis802_11PrivFilterAcceptAll = 0x00000000,
    Ndis802_11PrivFilter8021xWEP  = 0x00000001,
}

alias NDIS_802_11_WEP_STATUS = int;
enum : int
{
    Ndis802_11WEPEnabled             = 0x00000000,
    Ndis802_11Encryption1Enabled     = 0x00000000,
    Ndis802_11WEPDisabled            = 0x00000001,
    Ndis802_11EncryptionDisabled     = 0x00000001,
    Ndis802_11WEPKeyAbsent           = 0x00000002,
    Ndis802_11Encryption1KeyAbsent   = 0x00000002,
    Ndis802_11WEPNotSupported        = 0x00000003,
    Ndis802_11EncryptionNotSupported = 0x00000003,
    Ndis802_11Encryption2Enabled     = 0x00000004,
    Ndis802_11Encryption2KeyAbsent   = 0x00000005,
    Ndis802_11Encryption3Enabled     = 0x00000006,
    Ndis802_11Encryption3KeyAbsent   = 0x00000007,
}

alias NDIS_802_11_RELOAD_DEFAULTS = int;
enum : int
{
    Ndis802_11ReloadWEPKeys = 0x00000000,
}

alias NDIS_802_11_MEDIA_STREAM_MODE = int;
enum : int
{
    Ndis802_11MediaStreamOff = 0x00000000,
    Ndis802_11MediaStreamOn  = 0x00000001,
}

alias NDIS_802_11_RADIO_STATUS = int;
enum : int
{
    Ndis802_11RadioStatusOn                  = 0x00000000,
    Ndis802_11RadioStatusHardwareOff         = 0x00000001,
    Ndis802_11RadioStatusSoftwareOff         = 0x00000002,
    Ndis802_11RadioStatusHardwareSoftwareOff = 0x00000003,
    Ndis802_11RadioStatusMax                 = 0x00000004,
}

alias OFFLOAD_OPERATION_E = int;
enum : int
{
    AUTHENTICATE = 0x00000001,
    ENCRYPT      = 0x00000002,
}

alias OFFLOAD_CONF_ALGO = int;
enum : int
{
    OFFLOAD_IPSEC_CONF_NONE     = 0x00000000,
    OFFLOAD_IPSEC_CONF_DES      = 0x00000001,
    OFFLOAD_IPSEC_CONF_RESERVED = 0x00000002,
    OFFLOAD_IPSEC_CONF_3_DES    = 0x00000003,
    OFFLOAD_IPSEC_CONF_MAX      = 0x00000004,
}

alias OFFLOAD_INTEGRITY_ALGO = int;
enum : int
{
    OFFLOAD_IPSEC_INTEGRITY_NONE = 0x00000000,
    OFFLOAD_IPSEC_INTEGRITY_MD5  = 0x00000001,
    OFFLOAD_IPSEC_INTEGRITY_SHA  = 0x00000002,
    OFFLOAD_IPSEC_INTEGRITY_MAX  = 0x00000003,
}

alias UDP_ENCAP_TYPE = int;
enum : int
{
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_IKE   = 0x00000000,
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_OTHER = 0x00000001,
}

alias NDIS_MEDIUM = int;
enum : int
{
    NdisMedium802_3        = 0x00000000,
    NdisMedium802_5        = 0x00000001,
    NdisMediumFddi         = 0x00000002,
    NdisMediumWan          = 0x00000003,
    NdisMediumLocalTalk    = 0x00000004,
    NdisMediumDix          = 0x00000005,
    NdisMediumArcnetRaw    = 0x00000006,
    NdisMediumArcnet878_2  = 0x00000007,
    NdisMediumAtm          = 0x00000008,
    NdisMediumWirelessWan  = 0x00000009,
    NdisMediumIrda         = 0x0000000a,
    NdisMediumBpc          = 0x0000000b,
    NdisMediumCoWan        = 0x0000000c,
    NdisMedium1394         = 0x0000000d,
    NdisMediumInfiniBand   = 0x0000000e,
    NdisMediumTunnel       = 0x0000000f,
    NdisMediumNative802_11 = 0x00000010,
    NdisMediumLoopback     = 0x00000011,
    NdisMediumWiMAX        = 0x00000012,
    NdisMediumIP           = 0x00000013,
    NdisMediumMax          = 0x00000014,
}

alias NDIS_PHYSICAL_MEDIUM = int;
enum : int
{
    NdisPhysicalMediumUnspecified    = 0x00000000,
    NdisPhysicalMediumWirelessLan    = 0x00000001,
    NdisPhysicalMediumCableModem     = 0x00000002,
    NdisPhysicalMediumPhoneLine      = 0x00000003,
    NdisPhysicalMediumPowerLine      = 0x00000004,
    NdisPhysicalMediumDSL            = 0x00000005,
    NdisPhysicalMediumFibreChannel   = 0x00000006,
    NdisPhysicalMedium1394           = 0x00000007,
    NdisPhysicalMediumWirelessWan    = 0x00000008,
    NdisPhysicalMediumNative802_11   = 0x00000009,
    NdisPhysicalMediumBluetooth      = 0x0000000a,
    NdisPhysicalMediumInfiniband     = 0x0000000b,
    NdisPhysicalMediumWiMax          = 0x0000000c,
    NdisPhysicalMediumUWB            = 0x0000000d,
    NdisPhysicalMedium802_3          = 0x0000000e,
    NdisPhysicalMedium802_5          = 0x0000000f,
    NdisPhysicalMediumIrda           = 0x00000010,
    NdisPhysicalMediumWiredWAN       = 0x00000011,
    NdisPhysicalMediumWiredCoWan     = 0x00000012,
    NdisPhysicalMediumOther          = 0x00000013,
    NdisPhysicalMediumNative802_15_4 = 0x00000014,
    NdisPhysicalMediumMax            = 0x00000015,
}

alias NDIS_HARDWARE_STATUS = int;
enum : int
{
    NdisHardwareStatusReady        = 0x00000000,
    NdisHardwareStatusInitializing = 0x00000001,
    NdisHardwareStatusReset        = 0x00000002,
    NdisHardwareStatusClosing      = 0x00000003,
    NdisHardwareStatusNotReady     = 0x00000004,
}

alias NDIS_DEVICE_POWER_STATE = int;
enum : int
{
    NdisDeviceStateUnspecified = 0x00000000,
    NdisDeviceStateD0          = 0x00000001,
    NdisDeviceStateD1          = 0x00000002,
    NdisDeviceStateD2          = 0x00000003,
    NdisDeviceStateD3          = 0x00000004,
    NdisDeviceStateMaximum     = 0x00000005,
}

alias NDIS_FDDI_ATTACHMENT_TYPE = int;
enum : int
{
    NdisFddiTypeIsolated = 0x00000001,
    NdisFddiTypeLocalA   = 0x00000002,
    NdisFddiTypeLocalB   = 0x00000003,
    NdisFddiTypeLocalAB  = 0x00000004,
    NdisFddiTypeLocalS   = 0x00000005,
    NdisFddiTypeWrapA    = 0x00000006,
    NdisFddiTypeWrapB    = 0x00000007,
    NdisFddiTypeWrapAB   = 0x00000008,
    NdisFddiTypeWrapS    = 0x00000009,
    NdisFddiTypeCWrapA   = 0x0000000a,
    NdisFddiTypeCWrapB   = 0x0000000b,
    NdisFddiTypeCWrapS   = 0x0000000c,
    NdisFddiTypeThrough  = 0x0000000d,
}

alias NDIS_FDDI_RING_MGT_STATE = int;
enum : int
{
    NdisFddiRingIsolated          = 0x00000001,
    NdisFddiRingNonOperational    = 0x00000002,
    NdisFddiRingOperational       = 0x00000003,
    NdisFddiRingDetect            = 0x00000004,
    NdisFddiRingNonOperationalDup = 0x00000005,
    NdisFddiRingOperationalDup    = 0x00000006,
    NdisFddiRingDirected          = 0x00000007,
    NdisFddiRingTrace             = 0x00000008,
}

alias NDIS_FDDI_LCONNECTION_STATE = int;
enum : int
{
    NdisFddiStateOff         = 0x00000001,
    NdisFddiStateBreak       = 0x00000002,
    NdisFddiStateTrace       = 0x00000003,
    NdisFddiStateConnect     = 0x00000004,
    NdisFddiStateNext        = 0x00000005,
    NdisFddiStateSignal      = 0x00000006,
    NdisFddiStateJoin        = 0x00000007,
    NdisFddiStateVerify      = 0x00000008,
    NdisFddiStateActive      = 0x00000009,
    NdisFddiStateMaintenance = 0x0000000a,
}

alias NDIS_WAN_MEDIUM_SUBTYPE = int;
enum : int
{
    NdisWanMediumHub        = 0x00000000,
    NdisWanMediumX_25       = 0x00000001,
    NdisWanMediumIsdn       = 0x00000002,
    NdisWanMediumSerial     = 0x00000003,
    NdisWanMediumFrameRelay = 0x00000004,
    NdisWanMediumAtm        = 0x00000005,
    NdisWanMediumSonet      = 0x00000006,
    NdisWanMediumSW56K      = 0x00000007,
    NdisWanMediumPPTP       = 0x00000008,
    NdisWanMediumL2TP       = 0x00000009,
    NdisWanMediumIrda       = 0x0000000a,
    NdisWanMediumParallel   = 0x0000000b,
    NdisWanMediumPppoe      = 0x0000000c,
    NdisWanMediumSSTP       = 0x0000000d,
    NdisWanMediumAgileVPN   = 0x0000000e,
    NdisWanMediumGre        = 0x0000000f,
    NdisWanMediumSubTypeMax = 0x00000010,
}

alias NDIS_WAN_HEADER_FORMAT = int;
enum : int
{
    NdisWanHeaderNative   = 0x00000000,
    NdisWanHeaderEthernet = 0x00000001,
}

alias NDIS_WAN_QUALITY = int;
enum : int
{
    NdisWanRaw          = 0x00000000,
    NdisWanErrorControl = 0x00000001,
    NdisWanReliable     = 0x00000002,
}

alias NDIS_802_5_RING_STATE = int;
enum : int
{
    NdisRingStateOpened      = 0x00000001,
    NdisRingStateClosed      = 0x00000002,
    NdisRingStateOpening     = 0x00000003,
    NdisRingStateClosing     = 0x00000004,
    NdisRingStateOpenFailure = 0x00000005,
    NdisRingStateRingFailure = 0x00000006,
}

alias NDIS_MEDIA_STATE = int;
enum : int
{
    NdisMediaStateConnected    = 0x00000000,
    NdisMediaStateDisconnected = 0x00000001,
}

alias NDIS_SUPPORTED_PAUSE_FUNCTIONS = int;
enum : int
{
    NdisPauseFunctionsUnsupported    = 0x00000000,
    NdisPauseFunctionsSendOnly       = 0x00000001,
    NdisPauseFunctionsReceiveOnly    = 0x00000002,
    NdisPauseFunctionsSendAndReceive = 0x00000003,
    NdisPauseFunctionsUnknown        = 0x00000004,
}

alias NDIS_PORT_TYPE = int;
enum : int
{
    NdisPortTypeUndefined       = 0x00000000,
    NdisPortTypeBridge          = 0x00000001,
    NdisPortTypeRasConnection   = 0x00000002,
    NdisPortType8021xSupplicant = 0x00000003,
    NdisPortTypeMax             = 0x00000004,
}

alias NDIS_PORT_AUTHORIZATION_STATE = int;
enum : int
{
    NdisPortAuthorizationUnknown = 0x00000000,
    NdisPortAuthorized           = 0x00000001,
    NdisPortUnauthorized         = 0x00000002,
    NdisPortReauthorizing        = 0x00000003,
}

alias NDIS_PORT_CONTROL_STATE = int;
enum : int
{
    NdisPortControlStateUnknown      = 0x00000000,
    NdisPortControlStateControlled   = 0x00000001,
    NdisPortControlStateUncontrolled = 0x00000002,
}

alias NDIS_NETWORK_CHANGE_TYPE = int;
enum : int
{
    NdisPossibleNetworkChange         = 0x00000001,
    NdisDefinitelyNetworkChange       = 0x00000002,
    NdisNetworkChangeFromMediaConnect = 0x00000003,
    NdisNetworkChangeMax              = 0x00000004,
}

alias NDIS_PROCESSOR_VENDOR = int;
enum : int
{
    NdisProcessorVendorUnknown      = 0x00000000,
    NdisProcessorVendorGenuinIntel  = 0x00000001,
    NdisProcessorVendorGenuineIntel = 0x00000001,
    NdisProcessorVendorAuthenticAMD = 0x00000002,
}

alias DOT11_PHY_TYPE = int;
enum : int
{
    dot11_phy_type_unknown    = 0x00000000,
    dot11_phy_type_any        = 0x00000000,
    dot11_phy_type_fhss       = 0x00000001,
    dot11_phy_type_dsss       = 0x00000002,
    dot11_phy_type_irbaseband = 0x00000003,
    dot11_phy_type_ofdm       = 0x00000004,
    dot11_phy_type_hrdsss     = 0x00000005,
    dot11_phy_type_erp        = 0x00000006,
    dot11_phy_type_ht         = 0x00000007,
    dot11_phy_type_vht        = 0x00000008,
    dot11_phy_type_dmg        = 0x00000009,
    dot11_phy_type_he         = 0x0000000a,
    dot11_phy_type_IHV_start  = 0x80000000,
    dot11_phy_type_IHV_end    = 0xffffffff,
}

alias DOT11_OFFLOAD_TYPE = int;
enum : int
{
    dot11_offload_type_wep  = 0x00000001,
    dot11_offload_type_auth = 0x00000002,
}

alias DOT11_KEY_DIRECTION = int;
enum : int
{
    dot11_key_direction_both     = 0x00000001,
    dot11_key_direction_inbound  = 0x00000002,
    dot11_key_direction_outbound = 0x00000003,
}

alias DOT11_SCAN_TYPE = int;
enum : int
{
    dot11_scan_type_active  = 0x00000001,
    dot11_scan_type_passive = 0x00000002,
    dot11_scan_type_auto    = 0x00000003,
    dot11_scan_type_forced  = 0x80000000,
}

alias CH_DESCRIPTION_TYPE = int;
enum : int
{
    ch_description_type_logical          = 0x00000001,
    ch_description_type_center_frequency = 0x00000002,
    ch_description_type_phy_specific     = 0x00000003,
}

alias DOT11_UPDATE_IE_OP = int;
enum : int
{
    dot11_update_ie_op_create_replace = 0x00000001,
    dot11_update_ie_op_delete         = 0x00000002,
}

alias DOT11_RESET_TYPE = int;
enum : int
{
    dot11_reset_type_phy         = 0x00000001,
    dot11_reset_type_mac         = 0x00000002,
    dot11_reset_type_phy_and_mac = 0x00000003,
}

alias DOT11_POWER_MODE = int;
enum : int
{
    dot11_power_mode_unknown   = 0x00000000,
    dot11_power_mode_active    = 0x00000001,
    dot11_power_mode_powersave = 0x00000002,
}

alias DOT11_TEMP_TYPE = int;
enum : int
{
    dot11_temp_type_unknown = 0x00000000,
    dot11_temp_type_1       = 0x00000001,
    dot11_temp_type_2       = 0x00000002,
}

alias DOT11_DIVERSITY_SUPPORT = int;
enum : int
{
    dot11_diversity_support_unknown      = 0x00000000,
    dot11_diversity_support_fixedlist    = 0x00000001,
    dot11_diversity_support_notsupported = 0x00000002,
    dot11_diversity_support_dynamic      = 0x00000003,
}

alias DOT11_HOP_ALGO_ADOPTED = int;
enum : int
{
    dot11_hop_algo_current   = 0x00000000,
    dot11_hop_algo_hop_index = 0x00000001,
    dot11_hop_algo_hcc       = 0x00000002,
}

alias DOT11_AC_PARAM = int;
enum : int
{
    dot11_AC_param_BE  = 0x00000000,
    dot11_AC_param_BK  = 0x00000001,
    dot11_AC_param_VI  = 0x00000002,
    dot11_AC_param_VO  = 0x00000003,
    dot11_AC_param_max = 0x00000004,
}

alias DOT11_DIRECTION = int;
enum : int
{
    DOT11_DIR_INBOUND  = 0x00000001,
    DOT11_DIR_OUTBOUND = 0x00000002,
    DOT11_DIR_BOTH     = 0x00000003,
}

alias DOT11_ASSOCIATION_STATE = int;
enum : int
{
    dot11_assoc_state_zero           = 0x00000000,
    dot11_assoc_state_unauth_unassoc = 0x00000001,
    dot11_assoc_state_auth_unassoc   = 0x00000002,
    dot11_assoc_state_auth_assoc     = 0x00000003,
}

alias DOT11_DS_INFO = int;
enum : int
{
    DOT11_DS_CHANGED   = 0x00000000,
    DOT11_DS_UNCHANGED = 0x00000001,
    DOT11_DS_UNKNOWN   = 0x00000002,
}

alias DOT11_WPS_CONFIG_METHOD = int;
enum : int
{
    DOT11_WPS_CONFIG_METHOD_NULL          = 0x00000000,
    DOT11_WPS_CONFIG_METHOD_DISPLAY       = 0x00000008,
    DOT11_WPS_CONFIG_METHOD_NFC_TAG       = 0x00000020,
    DOT11_WPS_CONFIG_METHOD_NFC_INTERFACE = 0x00000040,
    DOT11_WPS_CONFIG_METHOD_PUSHBUTTON    = 0x00000080,
    DOT11_WPS_CONFIG_METHOD_KEYPAD        = 0x00000100,
    DOT11_WPS_CONFIG_METHOD_WFDS_DEFAULT  = 0x00001000,
}

alias DOT11_WPS_DEVICE_PASSWORD_ID = int;
enum : int
{
    DOT11_WPS_PASSWORD_ID_DEFAULT                 = 0x00000000,
    DOT11_WPS_PASSWORD_ID_USER_SPECIFIED          = 0x00000001,
    DOT11_WPS_PASSWORD_ID_MACHINE_SPECIFIED       = 0x00000002,
    DOT11_WPS_PASSWORD_ID_REKEY                   = 0x00000003,
    DOT11_WPS_PASSWORD_ID_PUSHBUTTON              = 0x00000004,
    DOT11_WPS_PASSWORD_ID_REGISTRAR_SPECIFIED     = 0x00000005,
    DOT11_WPS_PASSWORD_ID_NFC_CONNECTION_HANDOVER = 0x00000007,
    DOT11_WPS_PASSWORD_ID_WFD_SERVICES            = 0x00000008,
    DOT11_WPS_PASSWORD_ID_OOB_RANGE_MIN           = 0x00000010,
    DOT11_WPS_PASSWORD_ID_OOB_RANGE_MAX           = 0x0000ffff,
}

alias DOT11_ANQP_QUERY_RESULT = int;
enum : int
{
    dot11_ANQP_query_result_success                                        = 0x00000000,
    dot11_ANQP_query_result_failure                                        = 0x00000001,
    dot11_ANQP_query_result_timed_out                                      = 0x00000002,
    dot11_ANQP_query_result_resources                                      = 0x00000003,
    dot11_ANQP_query_result_advertisement_protocol_not_supported_on_remote = 0x00000004,
    dot11_ANQP_query_result_gas_protocol_failure                           = 0x00000005,
    dot11_ANQP_query_result_advertisement_server_not_responding            = 0x00000006,
    dot11_ANQP_query_result_access_issues                                  = 0x00000007,
}

alias DOT11_WFD_DISCOVER_TYPE = int;
enum : int
{
    dot11_wfd_discover_type_scan_only            = 0x00000001,
    dot11_wfd_discover_type_find_only            = 0x00000002,
    dot11_wfd_discover_type_auto                 = 0x00000003,
    dot11_wfd_discover_type_scan_social_channels = 0x00000004,
    dot11_wfd_discover_type_forced               = 0x80000000,
}

alias DOT11_WFD_SCAN_TYPE = int;
enum : int
{
    dot11_wfd_scan_type_active  = 0x00000001,
    dot11_wfd_scan_type_passive = 0x00000002,
    dot11_wfd_scan_type_auto    = 0x00000003,
}

alias DOT11_POWER_MODE_REASON = int;
enum : int
{
    dot11_power_mode_reason_no_change            = 0x00000000,
    dot11_power_mode_reason_noncompliant_AP      = 0x00000001,
    dot11_power_mode_reason_legacy_WFD_device    = 0x00000002,
    dot11_power_mode_reason_compliant_AP         = 0x00000003,
    dot11_power_mode_reason_compliant_WFD_device = 0x00000004,
    dot11_power_mode_reason_others               = 0x00000005,
}

alias DOT11_MANUFACTURING_TEST_TYPE = int;
enum : int
{
    dot11_manufacturing_test_unknown           = 0x00000000,
    dot11_manufacturing_test_self_start        = 0x00000001,
    dot11_manufacturing_test_self_query_result = 0x00000002,
    dot11_manufacturing_test_rx                = 0x00000003,
    dot11_manufacturing_test_tx                = 0x00000004,
    dot11_manufacturing_test_query_adc         = 0x00000005,
    dot11_manufacturing_test_set_data          = 0x00000006,
    dot11_manufacturing_test_query_data        = 0x00000007,
    dot11_manufacturing_test_sleep             = 0x00000008,
    dot11_manufacturing_test_awake             = 0x00000009,
    dot11_manufacturing_test_IHV_start         = 0x80000000,
    dot11_manufacturing_test_IHV_end           = 0xffffffff,
}

alias DOT11_MANUFACTURING_SELF_TEST_TYPE = int;
enum : int
{
    DOT11_MANUFACTURING_SELF_TEST_TYPE_INTERFACE      = 0x00000001,
    DOT11_MANUFACTURING_SELF_TEST_TYPE_RF_INTERFACE   = 0x00000002,
    DOT11_MANUFACTURING_SELF_TEST_TYPE_BT_COEXISTENCE = 0x00000003,
}

alias DOT11_BAND = int;
enum : int
{
    dot11_band_2p4g = 0x00000001,
    dot11_band_4p9g = 0x00000002,
    dot11_band_5g   = 0x00000003,
}

alias DOT11_MANUFACTURING_CALLBACK_TYPE = int;
enum : int
{
    dot11_manufacturing_callback_unknown            = 0x00000000,
    dot11_manufacturing_callback_self_test_complete = 0x00000001,
    dot11_manufacturing_callback_sleep_complete     = 0x00000002,
    dot11_manufacturing_callback_IHV_start          = 0x80000000,
    dot11_manufacturing_callback_IHV_end            = 0xffffffff,
}

///The <b>WLAN_CONNECTION_MODE</b> enumerated type defines the mode of connection.<b>Windows XP with SP3 and Wireless
///LAN API for Windows XP with SP2: </b>Only the <b>wlan_connection_mode_profile</b> value is supported.
alias WLAN_CONNECTION_MODE = int;
enum : int
{
    ///A profile will be used to make the connection.
    wlan_connection_mode_profile            = 0x00000000,
    ///A temporary profile will be used to make the connection.
    wlan_connection_mode_temporary_profile  = 0x00000001,
    ///Secure discovery will be used to make the connection.
    wlan_connection_mode_discovery_secure   = 0x00000002,
    ///Unsecure discovery will be used to make the connection.
    wlan_connection_mode_discovery_unsecure = 0x00000003,
    ///The connection is initiated by the wireless service automatically using a persistent profile.
    wlan_connection_mode_auto               = 0x00000004,
    ///Not used.
    wlan_connection_mode_invalid            = 0x00000005,
}

///The <b>WLAN_INTERFACE_STATE</b> enumerated type indicates the state of an interface. <b>Windows XP with SP3 and
///Wireless LAN API for Windows XP with SP2: </b>Only the <b>wlan_interface_state_connected</b>,
///<b>wlan_interface_state_disconnected</b>, and <b>wlan_interface_state_authenticating</b> values are supported.
alias WLAN_INTERFACE_STATE = int;
enum : int
{
    ///The interface is not ready to operate.
    wlan_interface_state_not_ready             = 0x00000000,
    ///The interface is connected to a network.
    wlan_interface_state_connected             = 0x00000001,
    ///The interface is the first node in an ad hoc network. No peer has connected.
    wlan_interface_state_ad_hoc_network_formed = 0x00000002,
    ///The interface is disconnecting from the current network.
    wlan_interface_state_disconnecting         = 0x00000003,
    ///The interface is not connected to any network.
    wlan_interface_state_disconnected          = 0x00000004,
    ///The interface is attempting to associate with a network.
    wlan_interface_state_associating           = 0x00000005,
    ///Auto configuration is discovering the settings for the network.
    wlan_interface_state_discovering           = 0x00000006,
    ///The interface is in the process of authenticating.
    wlan_interface_state_authenticating        = 0x00000007,
}

///The <b>WLAN_ADHOC_NETWORK_STATE</b> enumerated type specifies the connection state of an ad hoc network.
alias WLAN_ADHOC_NETWORK_STATE = int;
enum : int
{
    ///The ad hoc network has been formed, but no client or host is connected to the network.
    wlan_adhoc_network_state_formed    = 0x00000000,
    ///A client or host is connected to the ad hoc network.
    wlan_adhoc_network_state_connected = 0x00000001,
}

///The <b>DOT11_RADIO_STATE</b> enumeration specifies an 802.11 radio state.
alias DOT11_RADIO_STATE = int;
enum : int
{
    ///The radio state is unknown.
    dot11_radio_state_unknown = 0x00000000,
    ///The radio is on.
    dot11_radio_state_on      = 0x00000001,
    ///The radio is off.
    dot11_radio_state_off     = 0x00000002,
}

alias WLAN_OPERATIONAL_STATE = int;
enum : int
{
    wlan_operational_state_unknown   = 0x00000000,
    wlan_operational_state_off       = 0x00000001,
    wlan_operational_state_on        = 0x00000002,
    wlan_operational_state_going_off = 0x00000003,
    wlan_operational_state_going_on  = 0x00000004,
}

///The <b>WLAN_INTERFACE_TYPE</b> enumeration specifies the wireless interface type.
alias WLAN_INTERFACE_TYPE = int;
enum : int
{
    ///Specifies an emulated 802.11 interface.
    wlan_interface_type_emulated_802_11 = 0x00000000,
    ///Specifies a native 802.11 interface.
    wlan_interface_type_native_802_11   = 0x00000001,
    ///The interface specified is invalid.
    wlan_interface_type_invalid         = 0x00000002,
}

///The <b>WLAN_POWER_SETTING</b> enumerated type specifies the power setting of an interface.
alias WLAN_POWER_SETTING = int;
enum : int
{
    ///Specifies no power-saving activity performed by the 802.11 station.
    wlan_power_setting_no_saving      = 0x00000000,
    ///Specifies a power save polling (PSP) mode that uses the fastest power-saving mode. This power mode must provide
    ///the best combination of network performance and power usage.
    wlan_power_setting_low_saving     = 0x00000001,
    ///Specifies a PSP mode that uses the maximum (MAX) power saving capabilities. The MAX power save mode results in
    ///the greatest power savings for the radio on the 802.11 station.
    wlan_power_setting_medium_saving  = 0x00000002,
    ///Specifies a proprietary PSP mode implemented by the independent hardware vendor (IHV) that exceeds the
    ///wlan_power_setting_medium_saving power-saving level.
    wlan_power_setting_maximum_saving = 0x00000003,
    ///The supplied power setting is invalid.
    wlan_power_setting_invalid        = 0x00000004,
}

///The <b>WLAN_NOTIFICATION_ACM</b> enumerated type specifies the possible values of the <b>NotificationCode</b> member
///of the WLAN_NOTIFICATION_DATA structure for Auto Configuration Module (ACM) notifications.
alias WLAN_NOTIFICATION_ACM = int;
enum : int
{
    ///Indicates the beginning of the range that specifies the possible values for ACM notifications.
    wlan_notification_acm_start                      = 0x00000000,
    ///Autoconfiguration is enabled.
    wlan_notification_acm_autoconf_enabled           = 0x00000001,
    ///Autoconfiguration is disabled.
    wlan_notification_acm_autoconf_disabled          = 0x00000002,
    ///Background scans are enabled.
    wlan_notification_acm_background_scan_enabled    = 0x00000003,
    ///Background scans are disabled.
    wlan_notification_acm_background_scan_disabled   = 0x00000004,
    ///The BSS type for an interface has changed. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA structure points
    ///to a DOT11_BSS_TYPE enumeration value that identifies the new basic service set (BSS) type.
    wlan_notification_acm_bss_type_change            = 0x00000005,
    ///The power setting for an interface has changed. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA structure
    ///points to a WLAN_POWER_SETTING enumeration value that identifies the new power setting of an interface.
    wlan_notification_acm_power_setting_change       = 0x00000006,
    ///A scan for networks has completed.
    wlan_notification_acm_scan_complete              = 0x00000007,
    ///A scan for connectable networks failed. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA structure points to
    ///a WLAN_REASON_CODE data type value that identifies the reason the WLAN operation failed.
    wlan_notification_acm_scan_fail                  = 0x00000008,
    ///A connection has started to a network in range. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA structure
    ///points to a WLAN_CONNECTION_NOTIFICATION_DATA structure that identifies the network information for the
    ///connection attempt.
    wlan_notification_acm_connection_start           = 0x00000009,
    ///A connection has completed. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA structure points to a
    ///WLAN_CONNECTION_NOTIFICATION_DATA structure that identifies the network information for the connection attempt
    ///that completed. The connection succeeded if the <b>wlanReasonCode</b> in <b>WLAN_CONNECTION_NOTIFICATION_DATA</b>
    ///is <b>WLAN_REASON_CODE_SUCCESS</b>. Otherwise, the connection has failed.
    wlan_notification_acm_connection_complete        = 0x0000000a,
    ///A connection attempt has failed. A connection consists of one or more connection attempts. An application may
    ///receive zero or more <b>wlan_notification_acm_connection_attempt_fail </b>notifications between receiving the
    ///<b>wlan_notification_acm_connection_start</b> notification and the
    ///<b>wlan_notification_acm_connection_complete</b> notification. The <b>pData</b> member of the
    ///WLAN_NOTIFICATION_DATA structure points to a WLAN_CONNECTION_NOTIFICATION_DATA structure that identifies the
    ///network information for the connection attempt that failed.
    wlan_notification_acm_connection_attempt_fail    = 0x0000000b,
    ///A change in the filter list has occurred, either through group policy or a call to the WlanSetFilterList
    ///function. An application can call the WlanGetFilterList function to retrieve the new filter list.
    wlan_notification_acm_filter_list_change         = 0x0000000c,
    ///A wireless LAN interface is been added to or enabled on the local computer.
    wlan_notification_acm_interface_arrival          = 0x0000000d,
    ///A wireless LAN interface is been removed from or disabled on the local computer.
    wlan_notification_acm_interface_removal          = 0x0000000e,
    ///A change in a profile or the profile list has occurred, either through group policy or by calls to Native Wifi
    ///functions. An application can call the WlanGetProfileList and WlanGetProfile functions to retrieve the updated
    ///profiles. The interface on which the profile list changes is identified by the <b>InterfaceGuid</b> member of the
    ///WLAN_NOTIFICATION_DATA structure.
    wlan_notification_acm_profile_change             = 0x0000000f,
    ///A profile name has changed, either through group policy or by calls to Native Wifi functions. The <b>pData</b>
    ///member of the WLAN_NOTIFICATION_DATA structure points to a buffer that contains two NULL-terminated WCHAR
    ///strings, the old profile name followed by the new profile name.
    wlan_notification_acm_profile_name_change        = 0x00000010,
    ///All profiles were exhausted in an attempt to autoconnect.
    wlan_notification_acm_profiles_exhausted         = 0x00000011,
    ///The wireless service cannot find any connectable network after a scan. The interface on which no connectable
    ///network is found is identified by identified by the <b>InterfaceGuid</b> member of the WLAN_NOTIFICATION_DATA
    ///structure.
    wlan_notification_acm_network_not_available      = 0x00000012,
    ///The wireless service found a connectable network after a scan, the interface was in the disconnected state, and
    ///there is no compatible auto-connect profile that the wireless service can use to connect . The interface on which
    ///connectable networks are found is identified by the <b>InterfaceGuid</b> member of the WLAN_NOTIFICATION_DATA
    ///structure.
    wlan_notification_acm_network_available          = 0x00000013,
    ///The wireless service is disconnecting from a connectable network. The <b>pData</b> member of the
    ///WLAN_NOTIFICATION_DATA structure points to a WLAN_CONNECTION_NOTIFICATION_DATA structure that identifies the
    ///network information for the connection that is disconnecting.
    wlan_notification_acm_disconnecting              = 0x00000014,
    ///The wireless service has disconnected from a connectable network. The <b>pData</b> member of the
    ///WLAN_NOTIFICATION_DATA structure points to a WLAN_CONNECTION_NOTIFICATION_DATA structure that identifies the
    ///network information for the connection that disconnected.
    wlan_notification_acm_disconnected               = 0x00000015,
    ///A state change has occurred for an adhoc network. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA structure
    ///points to a WLAN_ADHOC_NETWORK_STATE enumeration value that identifies the new adhoc network state.
    wlan_notification_acm_adhoc_network_state_change = 0x00000016,
    ///This value is supported on Windows 8 and later.
    wlan_notification_acm_profile_unblocked          = 0x00000017,
    ///The screen power has changed. The <b>pData</b> member points to a <b>BOOL</b> value that indicates the value of
    ///the screen power change. When this value is <b>TRUE</b>, the screen changed to on. When this value is
    ///<b>FALSE</b>, the screen changed to off. This value is supported on Windows 8 and later.
    wlan_notification_acm_screen_power_change        = 0x00000018,
    ///This value is supported on Windows 8 and later.
    wlan_notification_acm_profile_blocked            = 0x00000019,
    ///This value is supported on Windows 8 and later.
    wlan_notification_acm_scan_list_refresh          = 0x0000001a,
    wlan_notification_acm_operational_state_change   = 0x0000001b,
    ///Indicates the end of the range that specifies the possible values for ACM notifications.
    wlan_notification_acm_end                        = 0x0000001c,
}

///The <b>WLAN_NOTIFICATION_MSM</b> enumerated type specifies the possible values of the <b>NotificationCode</b> member
///of the WLAN_NOTIFICATION_DATA structure for Media Specific Module (MSM) notifications.
alias WLAN_NOTIFICATION_MSM = int;
enum : int
{
    ///The beginning of the range that specifies the possible values for ACM notifications.
    wlan_notification_msm_start                         = 0x00000000,
    ///A wireless device is in the process of associating with an access point or a peer station. The <b>pData</b>
    ///member of the WLAN_NOTIFICATION_DATA structure points to a WLAN_MSM_NOTIFICATION_DATA structure that contains
    ///connection-related information.
    wlan_notification_msm_associating                   = 0x00000001,
    ///The wireless device has associated with an access point or a peer station. The <b>pData</b> member of the
    ///WLAN_NOTIFICATION_DATA structure points to a WLAN_MSM_NOTIFICATION_DATA structure that contains
    ///connection-related information.
    wlan_notification_msm_associated                    = 0x00000002,
    ///The wireless device is in the process of authenticating. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA
    ///structure points to a WLAN_MSM_NOTIFICATION_DATA structure that contains connection-related information.
    wlan_notification_msm_authenticating                = 0x00000003,
    ///The wireless device is associated with an access point or a peer station, keys have been exchanged, and the
    ///wireless device is available to send data. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA structure points
    ///to a WLAN_MSM_NOTIFICATION_DATA structure that contains connection-related information.
    wlan_notification_msm_connected                     = 0x00000004,
    ///The wireless device is connected to an access point and has initiated roaming to another access point. The
    ///<b>pData</b> member of the WLAN_NOTIFICATION_DATA structure points to a WLAN_MSM_NOTIFICATION_DATA structure that
    ///contains connection-related information.
    wlan_notification_msm_roaming_start                 = 0x00000005,
    ///The wireless device was connected to an access point and has completed roaming to another access point. The
    ///<b>pData</b> member of the WLAN_NOTIFICATION_DATA structure points to a WLAN_MSM_NOTIFICATION_DATA structure that
    ///contains connection-related information.
    wlan_notification_msm_roaming_end                   = 0x00000006,
    ///The radio state for an adapter has changed. Each physical layer (PHY) has its own radio state. The radio for an
    ///adapter is switched off when the radio state of every PHY is off. The <b>pData</b> member of the
    ///WLAN_NOTIFICATION_DATA structure points to a WLAN_PHY_RADIO_STATE structure that identifies the new radio state.
    wlan_notification_msm_radio_state_change            = 0x00000007,
    ///A signal quality change for the currently associated access point or peer station. The <b>pData</b> member of the
    ///WLAN_NOTIFICATION_DATA structure points to a ULONG WLAN_SIGNAL_QUALITY that identifies the new signal quality.
    wlan_notification_msm_signal_quality_change         = 0x00000008,
    ///A wireless device is in the process of disassociating from an access point or a peer station. The <b>pData</b>
    ///member of the WLAN_NOTIFICATION_DATA structure points to a WLAN_MSM_NOTIFICATION_DATA structure that contains
    ///connection-related information.
    wlan_notification_msm_disassociating                = 0x00000009,
    ///The wireless device is not associated with an access point or a peer station. The <b>pData</b> member of the
    ///WLAN_NOTIFICATION_DATA structure points to a WLAN_MSM_NOTIFICATION_DATA structure that contains
    ///connection-related information. The <b>wlanReasonCode</b> member of the <b>WLAN_MSM_NOTIFICATION_DATA</b>
    ///structure indicates the reason for the disconnect.
    wlan_notification_msm_disconnected                  = 0x0000000a,
    ///A peer has joined an adhoc network. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA structure points to a
    ///WLAN_MSM_NOTIFICATION_DATA structure that contains connection-related information.
    wlan_notification_msm_peer_join                     = 0x0000000b,
    ///A peer has left an adhoc network. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA structure points to a
    ///WLAN_MSM_NOTIFICATION_DATA structure that contains connection-related information.
    wlan_notification_msm_peer_leave                    = 0x0000000c,
    ///A wireless adapter has been removed from the local computer. The <b>pData</b> member of the
    ///WLAN_NOTIFICATION_DATA structure points to a WLAN_MSM_NOTIFICATION_DATA structure that contains
    ///connection-related information.
    wlan_notification_msm_adapter_removal               = 0x0000000d,
    ///The operation mode of the wireless device has changed. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA
    ///structure points to a ULONG that identifies the new operation mode.
    wlan_notification_msm_adapter_operation_mode_change = 0x0000000e,
    wlan_notification_msm_link_degraded                 = 0x0000000f,
    wlan_notification_msm_link_improved                 = 0x00000010,
    ///Indicates the end of the range that specifies the possible values for MSM notifications.
    wlan_notification_msm_end                           = 0x00000011,
}

alias WLAN_NOTIFICATION_SECURITY = int;
enum : int
{
    wlan_notification_security_start = 0x00000000,
    wlan_notification_security_end   = 0x00000001,
}

///The <b>WLAN_OPCODE_VALUE_TYPE</b> enumeration specifies the origin of automatic configuration (auto config) settings.
alias WLAN_OPCODE_VALUE_TYPE = int;
enum : int
{
    ///The auto config settings were queried, but the origin of the settings was not determined.
    wlan_opcode_value_type_query_only          = 0x00000000,
    ///The auto config settings were set by group policy.
    wlan_opcode_value_type_set_by_group_policy = 0x00000001,
    ///The auto config settings were set by the user.
    wlan_opcode_value_type_set_by_user         = 0x00000002,
    ///The auto config settings are invalid.
    wlan_opcode_value_type_invalid             = 0x00000003,
}

///The <b>WLAN_INTF_OPCODE</b> enumerated type defines various opcodes used to set and query parameters on a wireless
///interface.
alias WLAN_INTF_OPCODE = int;
enum : int
{
    ///Not used.
    wlan_intf_opcode_autoconf_start                             = 0x00000000,
    ///The opcode used to set or query whether auto config is enabled.
    wlan_intf_opcode_autoconf_enabled                           = 0x00000001,
    ///The opcode used to set or query whether background scan is enabled. Background scan can only be disabled when the
    ///interface is in the connected state. Background scan is disabled if at least one client disables it. If the
    ///interface gets disconnected, background scan will be enabled automatically.
    wlan_intf_opcode_background_scan_enabled                    = 0x00000002,
    ///The opcode used to set or query the media streaming mode of the driver. The media streaming mode can only be set
    ///when the interface is in the connected state. The media streaming mode is enabled if at least one client enables
    ///it. If the interface gets disconnected, the media streaming mode is disabled automatically
    wlan_intf_opcode_media_streaming_mode                       = 0x00000003,
    ///The opcode used to set or query the radio state.
    wlan_intf_opcode_radio_state                                = 0x00000004,
    ///The opcode used to set or query the BSS type of the interface.
    wlan_intf_opcode_bss_type                                   = 0x00000005,
    ///The opcode used to query the state of the interface. This opcode can only be used in a query operation with the
    ///WlanQueryInterface function.
    wlan_intf_opcode_interface_state                            = 0x00000006,
    ///The opcode used to query information about the current connection of the interface. This opcode can only be used
    ///in a query operation with the WlanQueryInterface function. If the interface is in disconnected or disconnecting
    ///state, <b>WlanQueryInterface</b> function returns <b>ERROR_INVALID_STATE</b>.
    wlan_intf_opcode_current_connection                         = 0x00000007,
    ///The opcose used to query the current channel on which the wireless interface is operating. This opcode can only
    ///be used in a query operation with the WlanQueryInterface function.
    wlan_intf_opcode_channel_number                             = 0x00000008,
    ///The opcode used to query the supported auth/cipher pairs for infrastructure mode. This opcode can only be used in
    ///a query operation with the WlanQueryInterface function.
    wlan_intf_opcode_supported_infrastructure_auth_cipher_pairs = 0x00000009,
    ///The opcode used to query the supported auth/cipher pairs for ad hoc mode. This opcode can only be used in a query
    ///operation with the WlanQueryInterface function.
    wlan_intf_opcode_supported_adhoc_auth_cipher_pairs          = 0x0000000a,
    ///The opcode used to query the list of supported country or region strings. This opcode can only be used in a query
    ///operation with the WlanQueryInterface function.
    wlan_intf_opcode_supported_country_or_region_string_list    = 0x0000000b,
    ///The opcode used to set or query the current operation mode of the wireless interface. For more information about
    ///operation modes, see Native 802.11 Operation Modes.
    wlan_intf_opcode_current_operation_mode                     = 0x0000000c,
    ///The opcode used to query whether the miniport/NIC combination supports Federal Information Processing Standards
    ///(FIPS) mode. This opcode can only be used in a query operation with the WlanQueryInterface function. FIPS mode is
    ///also known as safe mode. This wireless safe mode is different than the operating system safe mode.
    wlan_intf_opcode_supported_safe_mode                        = 0x0000000d,
    ///The opcode used to query whether the miniport/NIC combination is FIPS certified. This opcode can only be used in
    ///a query operation with the WlanQueryInterface function.
    wlan_intf_opcode_certified_safe_mode                        = 0x0000000e,
    ///The opcode used to query for Hosted Network support in the device driver associated with the Wireless interface.
    ///This opcode can only be used in a query operation with the WlanQueryInterface function. The data type returned
    ///for this opcode by a query is a Boolean. A value returned of <b>TRUE</b> indicates Hosted Network is supported. A
    ///value of <b>FALSE</b> indicates Hosted Network is not supported. This value is an extension to native wireless
    ///APIs added to support the wireless Hosted Network on Windows 7 and on Windows Server 2008 R2 with the Wireless
    ///LAN Service installed.
    wlan_intf_opcode_hosted_network_capable                     = 0x0000000f,
    ///The opcode used to query whether Managememt Frame Protection (MFP) is supported in the device driver associated
    ///with the Wireless interface. This opcode can only be used in a query operation with the WlanQueryInterface
    ///function. MFP is defined in the IEEE 802.11w-2009 amendment to 802.11 standard. This value is supported on
    ///Windows 8 and on Windows Server 2012.
    wlan_intf_opcode_management_frame_protection_capable        = 0x00000010,
    ///Not used.
    wlan_intf_opcode_autoconf_end                               = 0x0fffffff,
    ///Not used.
    wlan_intf_opcode_msm_start                                  = 0x10000100,
    ///The opcode used to query driver statistics. This opcode can only be used in a query operation with the
    ///WlanQueryInterface function.
    wlan_intf_opcode_statistics                                 = 0x10000101,
    ///Opcode used to query the received signal strength. This opcode can only be used in a query operation with the
    ///WlanQueryInterface function.
    wlan_intf_opcode_rssi                                       = 0x10000102,
    ///Not used.
    wlan_intf_opcode_msm_end                                    = 0x1fffffff,
    ///Not used.
    wlan_intf_opcode_security_start                             = 0x20010000,
    ///Not used.
    wlan_intf_opcode_security_end                               = 0x2fffffff,
    ///Not used.
    wlan_intf_opcode_ihv_start                                  = 0x30000000,
    wlan_intf_opcode_ihv_end                                    = 0x3fffffff,
}

///The <b>WLAN_AUTOCONF_OPCODE</b> enumerated type specifies an automatic configuration parameter.
alias WLAN_AUTOCONF_OPCODE = int;
enum : int
{
    ///Not used.
    wlan_autoconf_opcode_start                                     = 0x00000000,
    ///The opcode used to set or query the parameter specifying whether user and group policy denied networks will be
    ///included in the available networks list.
    wlan_autoconf_opcode_show_denied_networks                      = 0x00000001,
    ///The opcode used to query the power settings.
    wlan_autoconf_opcode_power_setting                             = 0x00000002,
    ///The opcode used to query whether profiles not created by group policy can be used to connect to an allowed
    ///network with a matching group policy profile.
    wlan_autoconf_opcode_only_use_gp_profiles_for_allowed_networks = 0x00000003,
    ///The opcode used to set or query whether the current wireless interface has shared user credentials allowed.
    wlan_autoconf_opcode_allow_explicit_creds                      = 0x00000004,
    ///The opcode used to set or query the blocked period setting for the current wireless interface. The blocked period
    ///is the amount of time, in seconds, for which automatic connection to a wireless network will not be attempted
    ///after a previous failure.
    wlan_autoconf_opcode_block_period                              = 0x00000005,
    ///The opcode used to set or query whether extensibility on a virtual station is allowed. By default, extensibility
    ///on a virtual station is allowed. The value for this opcode is persisted across reboots. This enumeration value is
    ///supported on Windows 7 and on Windows Server 2008 R2 with the Wireless LAN Service installed.
    wlan_autoconf_opcode_allow_virtual_station_extensibility       = 0x00000006,
    ///Not used.
    wlan_autoconf_opcode_end                                       = 0x00000007,
}

///The <b>WLAN_IHV_CONTROL_TYPE</b> enumeration specifies the type of software bypassed by a vendor-specific method.
alias WLAN_IHV_CONTROL_TYPE = int;
enum : int
{
    ///Bypasses a WLAN service.
    wlan_ihv_control_type_service = 0x00000000,
    ///Bypasses a WLAN driver.
    wlan_ihv_control_type_driver  = 0x00000001,
}

///The <b>WLAN_FILTER_LIST_TYPE</b> enumerated type indicates types of filter lists.
alias WLAN_FILTER_LIST_TYPE = int;
enum : int
{
    ///Group policy permit list.
    wlan_filter_list_type_gp_permit   = 0x00000000,
    ///Group policy deny list.
    wlan_filter_list_type_gp_deny     = 0x00000001,
    ///User permit list.
    wlan_filter_list_type_user_permit = 0x00000002,
    ///User deny list.
    wlan_filter_list_type_user_deny   = 0x00000003,
}

///The <b>WLAN_SECURABLE_OBJECT</b> enumerated type defines the securable objects used by Native Wifi Functions. These
///objects can be secured using WlanSetSecuritySettings. The current permissions associated with these objects can be
///retrieved using WlanGetSecuritySettings. For more information about the use of securable objects, see How DACLs
///Control Access to an Object.
alias WLAN_SECURABLE_OBJECT = int;
enum : int
{
    ///The permissions for modifying the permit list for user profiles. The discretionary access control lists (DACL)
    ///associated with this securable object is retrieved when either WlanGetFilterList or WlanSetFilterList is called
    ///with <i>wlanFilterListType</i> set to <b>wlan_filter_list_type_user_permit</b>. For the <b>WlanGetFilterList</b>
    ///call to succeed, the DACL must contain an access control entry (ACE) that grants WLAN_READ_ACCESS permission to
    ///the access token of the calling thread. For the <b>WlanSetFilterList</b> call to succeed, the DACL must contain
    ///an ACE that grants WLAN_WRITE_ACCESS permission to the access token of the calling thread.
    wlan_secure_permit_list                    = 0x00000000,
    ///The permissions for modifying the deny list for user profiles. The auto config service will not establish a
    ///connection to a network on the deny list. The DACL associated with this securable object is retrieved when either
    ///WlanGetFilterList or WlanSetFilterList is called with <i>wlanFilterListType</i> set to
    ///<b>wlan_filter_list_type_user_deny</b>. For the <b>WlanGetFilterList</b> call to succeed, the DACL must contain
    ///an ACE that grants WLAN_READ_ACCESS permission to the access token of the calling thread. For the
    ///<b>WlanSetFilterList</b> call to succeed, the DACL must contain an ACE that grants WLAN_WRITE_ACCESS permission
    ///to the access token of the calling thread.
    wlan_secure_deny_list                      = 0x00000001,
    ///The permissions for enabling the auto config service. The DACL associated with this securable object is retrieved
    ///when either WlanQueryInterface or WlanSetInterface is called with <i>OpCode</i> set to
    ///<b>wlan_intf_opcode_autoconf_enabled</b>. For the <b>WlanQueryInterface</b> call to succeed, the DACL must
    ///contain an ACE that grants WLAN_READ_ACCESS permission to the access token of the calling thread. For the
    ///<b>WlanSetInterface</b> call to succeed, the DACL must contain an ACE that grants WLAN_WRITE_ACCESS permission to
    ///the access token of the calling thread.
    wlan_secure_ac_enabled                     = 0x00000002,
    ///The permissions for enabling background scans. The DACL associated with this securable object is retrieved when
    ///either WlanQueryInterface or WlanSetInterface is called with <i>OpCode</i> set to
    ///<b>wlan_intf_opcode_background_scan_enabled</b>. For the <b>WlanQueryInterface</b> call to succeed, the DACL must
    ///contain an ACE that grants WLAN_READ_ACCESS permission to the access token of the calling thread. For the
    ///<b>WlanSetInterface</b> call to succeed, the DACL must contain an ACE that grants WLAN_WRITE_ACCESS permission to
    ///the access token of the calling thread.
    wlan_secure_bc_scan_enabled                = 0x00000003,
    ///The permissions for altering the basic service set type. The DACL associated with this securable object is
    ///retrieved when either WlanQueryInterface or WlanSetInterface is called with <i>OpCode</i> set to
    ///<b>wlan_intf_opcode_bss_type</b>. For the <b>WlanQueryInterface</b> call to succeed, the DACL must contain an ACE
    ///that grants WLAN_READ_ACCESS permission to the access token of the calling thread. For the
    ///<b>WlanSetInterface</b> call to succeed, the DACL must contain an ACE that grants WLAN_WRITE_ACCESS permission to
    ///the access token of the calling thread.
    wlan_secure_bss_type                       = 0x00000004,
    ///The permissions for modifying whether networks on the deny list appear in the available networks list. The DACL
    ///associated with this securable object is retrieved when either WlanQueryAutoConfigParameter or
    ///WlanSetAutoConfigParameter is called with <i>OpCode</i> set to <b>wlan_autoconf_opcode_show_denied_networks</b>.
    ///For the <b>WlanQueryAutoConfigParameter</b> call to succeed, the DACL must contain an ACE that grants
    ///WLAN_READ_ACCESS permission to the access token of the calling thread. For the <b>WlanSetAutoConfigParameter</b>
    ///call to succeed, the DACL must contain an ACE that grants WLAN_WRITE_ACCESS permission to the access token of the
    ///calling thread.
    wlan_secure_show_denied                    = 0x00000005,
    ///The permissions for changing interface properties. This is the generic securable object used by
    ///WlanQueryInterface or WlanSetInterface when another more specific securable object is not used. Its DACL is
    ///retrieved whenever <b>WlanQueryInterface</b> or <b>WlanSetInterface</b> is access token of the calling thread and
    ///the <i>OpCode</i> is set to a value other than <b>wlan_intf_opcode_autoconf_enabled</b>,
    ///<b>wlan_intf_opcode_background_scan_enabled</b>, <b>wlan_intf_opcode_media_streaming_mode</b>,
    ///<b>wlan_intf_opcode_bss_type</b>, or <b>wlan_intf_opcode_current_operation_mode</b>. The DACL is also not
    ///retrieved when <i>OpCode</i> is set to <b>wlan_intf_opcode_radio_state</b> and the caller is the console user.
    ///For the WlanQueryInterface call to succeed, the DACL must contain an ACE that grants WLAN_READ_ACCESS permission
    ///to the access token of the calling thread. For the WlanSetInterface call to succeed, the DACL must contain an ACE
    ///that grants WLAN_WRITE_ACCESS permission to the access token of the calling thread.
    wlan_secure_interface_properties           = 0x00000006,
    ///The permissions for using the WlanIhvControl function for independent hardware vendor (IHV) control of WLAN
    ///drivers or services. The DACL associated with this securable object is retrieved when WlanIhvControl is called.
    ///For the call to succeed, the DACL must contain an ACE that grants WLAN_WRITE_ACCESS permission to the access
    ///token of the calling thread.
    wlan_secure_ihv_control                    = 0x00000007,
    ///The permissions for modifying the order of all-user profiles. The DACL associated with this securable object is
    ///retrieved before WlanSetProfileList or WlanSetProfilePosition performs an operation that changes the relative
    ///order of all-user profiles in the profile list or moves an all-user profile to a lower position in the profile
    ///list. For either call to succeed, the DACL must contain an ACE that grants WLAN_WRITE_ACCESS permission to the
    ///access token of the calling thread.
    wlan_secure_all_user_profiles_order        = 0x00000008,
    ///The permissions for adding new all-user profiles. <div class="alert"><b>Note</b> The security descriptor
    ///associated with this object is applied to new all-user profiles created.</div> <div> </div> The DACL associated
    ///with this securable object is retrieved when WlanSetProfile is called with <i>dwFlags</i> set to 0. For the call
    ///to succeed, the DACL must contain an ACE that grants WLAN_WRITE_ACCESS permission to the access token of the
    ///calling thread.
    wlan_secure_add_new_all_user_profiles      = 0x00000009,
    ///The permissions for adding new per-user profiles. The DACL associated with this securable object is retrieved
    ///when WlanSetProfile is called with <i>dwFlags</i> set to WLAN_PROFILE_USER. For the call to succeed, the DACL
    ///must contain an ACE that grants WLAN_WRITE_ACCESS permission to the access token of the calling thread.
    wlan_secure_add_new_per_user_profiles      = 0x0000000a,
    ///The permissions for setting or querying the media streaming mode. The DACL associated with this securable object
    ///is retrieved when either WlanQueryInterface or WlanSetInterface is called with <i>OpCode</i> set to
    ///<b>wlan_intf_opcode_media_streaming_mode</b>. For the <b>WlanQueryInterface</b> call to succeed, the DACL must
    ///contain an ACE that grants WLAN_READ_ACCESS permission to the access token of the calling thread. For the
    ///<b>WlanSetInterface</b> call to succeed, the DACL must contain an ACE that grants WLAN_WRITE_ACCESS permission to
    ///the access token of the calling thread.
    wlan_secure_media_streaming_mode_enabled   = 0x0000000b,
    ///The permissions for setting or querying the operation mode of the wireless interface. The DACL associated with
    ///this securable object is retrieved when either WlanQueryInterface or WlanSetInterface is called with
    ///<i>OpCode</i> set to <b>wlan_intf_opcode_current_operation_mode</b>. For the <b>WlanQueryInterface</b> call to
    ///succeed, the DACL must contain an ACE that grants WLAN_READ_ACCESS permission to the access token of the calling
    ///thread. For the <b>WlanSetInterface</b> call to succeed, the DACL must contain an ACE that grants
    ///WLAN_WRITE_ACCESS permission to the access token of the calling thread.
    wlan_secure_current_operation_mode         = 0x0000000c,
    ///The permissions for retrieving the plain text key from a wireless profile. The DACL associated with this
    ///securable object is retrieved when the WlanGetProfile function is called with the
    ///<b>WLAN_PROFILE_GET_PLAINTEXT_KEY</b> flag set in the value pointed to by the <i>pdwFlags</i> parameter on input.
    ///For the <b>WlanGetProfile</b> call to succeed, the DACL must contain an ACE that grants <b>WLAN_READ_ACCESS</b>
    ///permission to the access token of the calling thread. By default, the permissions for retrieving the plain text
    ///key is allowed only to the members of the Administrators group on a local computer. <b>Windows 7: </b>This value
    ///is an extension to native wireless APIs added on Windows 7 and later.
    wlan_secure_get_plaintext_key              = 0x0000000d,
    ///The permissions that have elevated access to call the privileged Hosted Network functions. The DACL associated
    ///with this securable object is retrieved when the WlanHostedNetworkSetProperty function is called with the
    ///<i>OpCode</i> parameter set to <b>wlan_hosted_network_opcode_enable</b>. For the
    ///<b>WlanHostedNetworkSetProperty</b> call to succeed, the DACL must contain an ACE that grants WLAN_WRITE_ACCESS
    ///permission to the access token of the calling thread. By default, the permission to set the wireless Hosted
    ///Network property to <b>wlan_hosted_network_opcode_enable</b> is allowed only to the members of the Administrators
    ///group on a local computer. The DACL associated with this securable object is retrieved when the
    ///WlanHostedNetworkForceStart function is called. For the <b>WlanHostedNetworkForceStart</b> call to succeed, the
    ///DACL must contain an ACE that grants <b>WLAN_WRITE_ACCESS</b> permission to the access token of the calling
    ///thread. By default, the permission to force start the wireless Hosted Network is allowed only to the members of
    ///the Administrators group on a local computer. <b>Windows 7: </b>This value is an extension to native wireless
    ///APIs added on Windows 7 and later.
    wlan_secure_hosted_network_elevated_access = 0x0000000e,
    ///<b>Windows 7: </b>This value is an extension to native wireless APIs added on Windows 7 and later.
    wlan_secure_virtual_station_extensibility  = 0x0000000f,
    ///This value is reserved for internal use by the Wi-Fi Direct service. <b>Windows 8: </b>This value is an extension
    ///to native wireless APIs added on Windows 8 and later.
    wlan_secure_wfd_elevated_access            = 0x00000010,
    WLAN_SECURABLE_OBJECT_COUNT                = 0x00000011,
}

alias WFD_ROLE_TYPE = int;
enum : int
{
    WFD_ROLE_TYPE_NONE        = 0x00000000,
    WFD_ROLE_TYPE_DEVICE      = 0x00000001,
    WFD_ROLE_TYPE_GROUP_OWNER = 0x00000002,
    WFD_ROLE_TYPE_CLIENT      = 0x00000004,
    WFD_ROLE_TYPE_MAX         = 0x00000005,
}

///Specifies the active tab when the wireless profile user interface dialog box appears.
alias WL_DISPLAY_PAGES = int;
enum : int
{
    ///Displays the <b>Connection</b> tab.
    WLConnectionPage = 0x00000000,
    ///Displays the <b>Security</b> tab.
    WLSecurityPage   = 0x00000001,
    WLAdvPage        = 0x00000002,
}

///The <b>WLAN_HOSTED_NETWORK_STATE</b> enumerated type specifies the possible values for the network state of the
///wireless Hosted Network.
alias WLAN_HOSTED_NETWORK_STATE = int;
enum : int
{
    ///The wireless Hosted Network is unavailable.
    wlan_hosted_network_unavailable = 0x00000000,
    ///The wireless Hosted Network is idle.
    wlan_hosted_network_idle        = 0x00000001,
    ///The wireless Hosted Network is active.
    wlan_hosted_network_active      = 0x00000002,
}

///The <b>WLAN_HOSTED_NETWORK_REASON</b> enumerated type specifies the possible values for the result of a wireless
///Hosted Network function call.
alias WLAN_HOSTED_NETWORK_REASON = int;
enum : int
{
    ///The operation was successful.
    wlan_hosted_network_reason_success                              = 0x00000000,
    ///Unknown error.
    wlan_hosted_network_reason_unspecified                          = 0x00000001,
    ///Bad parameters. For example, this reason code is returned if an application failed to reference the client
    ///context from the correct handle (the handle returned by the WlanOpenHandle function).
    wlan_hosted_network_reason_bad_parameters                       = 0x00000002,
    ///Service is shutting down.
    wlan_hosted_network_reason_service_shutting_down                = 0x00000003,
    ///Service is out of resources.
    wlan_hosted_network_reason_insufficient_resources               = 0x00000004,
    ///This operation requires elevation.
    wlan_hosted_network_reason_elevation_required                   = 0x00000005,
    ///An attempt was made to write read-only data.
    wlan_hosted_network_reason_read_only                            = 0x00000006,
    ///Data persistence failed.
    wlan_hosted_network_reason_persistence_failed                   = 0x00000007,
    ///A cryptographic error occurred.
    wlan_hosted_network_reason_crypt_error                          = 0x00000008,
    ///User impersonation failed.
    wlan_hosted_network_reason_impersonation                        = 0x00000009,
    ///An incorrect function call sequence was made.
    wlan_hosted_network_reason_stop_before_start                    = 0x0000000a,
    ///A wireless interface has become available.
    wlan_hosted_network_reason_interface_available                  = 0x0000000b,
    ///A wireless interface has become unavailable. This reason code is returned by the wireless Hosted Network
    ///functions any time the network state of the wireless Hosted Network is <b>wlan_hosted_network_unavailable</b>.
    ///For example if the wireless Hosted Network is disabled by group policy on a domain, then the network state of the
    ///wireless Hosted Network is <b>wlan_hosted_network_unavailable</b>. In this case, any calls to the
    ///WlanHostedNetworkStartUsing or WlanHostedNetworkForceStart function would return this reason code.
    wlan_hosted_network_reason_interface_unavailable                = 0x0000000c,
    ///The wireless miniport driver stopped the Hosted Network.
    wlan_hosted_network_reason_miniport_stopped                     = 0x0000000d,
    ///The wireless miniport driver status changed.
    wlan_hosted_network_reason_miniport_started                     = 0x0000000e,
    ///An incompatible connection started. An incompatible connection refers to one of the following cases:<ul> <li>An
    ///ad hoc wireless connection is started on the primary station adapter.</li> <li>Network monitoring is started on
    ///the primary station adapter by an application (Network Monitor, for example) that calls the WlanSetInterface
    ///function with the <i>OpCode</i> parameter set to <b>wlan_intf_opcode_current_operation_mode</b> and the
    ///<i>pData</i> parameter points to a ULONG that contains <b>DOT11_OPERATION_MODE_NETWORK_MONITOR</b>. </li> <li>A
    ///wireless connection is started in FIPS safe mode on the primary station adapter. FIPS safe mode is specified in
    ///the profile of the wireless connection. For more information, see the FIPSMode Element . </li> </ul> Windows will
    ///stop the wireless Hosted Network on the software-based wireless access point (AP) adapter when an incompatible
    ///connection starts on the primary station adapter. The network state of the wireless Hosted Network state would
    ///become <b>wlan_hosted_network_unavailable</b>.
    wlan_hosted_network_reason_incompatible_connection_started      = 0x0000000f,
    ///An incompatible connection stopped. An incompatible connection previously started on the primary station adapter
    ///(wlan_hosted_network_reason_incompatible_connection_started), but the incompatible connection has stopped. If the
    ///wireless Hosted Network was previously stopped as a result of an incompatible connection being started, Windows
    ///will not automatically restart the wireless Hosted Network. Applications can restart the wireless Hosted Network
    ///on the AP adapter by calling the WlanHostedNetworkStartUsing or WlanHostedNetworkForceStart function.
    wlan_hosted_network_reason_incompatible_connection_stopped      = 0x00000010,
    ///A state change occurred that was caused by explicit user action.
    wlan_hosted_network_reason_user_action                          = 0x00000011,
    ///A state change occurred that was caused by client abort.
    wlan_hosted_network_reason_client_abort                         = 0x00000012,
    ///The driver for the wireless Hosted Network failed to start.
    wlan_hosted_network_reason_ap_start_failed                      = 0x00000013,
    ///A peer connected to the wireless Hosted Network.
    wlan_hosted_network_reason_peer_arrived                         = 0x00000014,
    ///A peer disconnected from the wireless Hosted Network.
    wlan_hosted_network_reason_peer_departed                        = 0x00000015,
    ///A peer timed out.
    wlan_hosted_network_reason_peer_timeout                         = 0x00000016,
    ///The operation was denied by group policy.
    wlan_hosted_network_reason_gp_denied                            = 0x00000017,
    ///The Wireless LAN service is not running.
    wlan_hosted_network_reason_service_unavailable                  = 0x00000018,
    ///The wireless adapter used by the wireless Hosted Network changed.
    wlan_hosted_network_reason_device_change                        = 0x00000019,
    ///The properties of the wireless Hosted Network changed.
    wlan_hosted_network_reason_properties_change                    = 0x0000001a,
    ///A virtual station is active and blocking operation.
    wlan_hosted_network_reason_virtual_station_blocking_use         = 0x0000001b,
    ///An identical service is available on a virtual station.
    wlan_hosted_network_reason_service_available_on_virtual_station = 0x0000001c,
}

///The <b>WLAN_HOSTED_NETWORK_PEER_AUTH_STATE</b> enumerated type specifies the possible values for the authentication
///state of a peer on the wireless Hosted Network.
alias WLAN_HOSTED_NETWORK_PEER_AUTH_STATE = int;
enum : int
{
    ///An invalid peer state.
    wlan_hosted_network_peer_state_invalid       = 0x00000000,
    ///The peer is authenticated.
    wlan_hosted_network_peer_state_authenticated = 0x00000001,
}

///The <b>WLAN_HOSTED_NETWORK_NOTIFICATION_CODE</b> enumerated type specifies the possible values of the
///NotificationCode parameter for received notifications on the wireless Hosted Network.
alias WLAN_HOSTED_NETWORK_NOTIFICATION_CODE = int;
enum : int
{
    ///The Hosted Network state has changed.
    wlan_hosted_network_state_change       = 0x00001000,
    ///The Hosted Network peer state has changed.
    wlan_hosted_network_peer_state_change  = 0x00001001,
    ///The Hosted Network radio state has changed.
    wlan_hosted_network_radio_state_change = 0x00001002,
}

///The <b>WLAN_HOSTED_NETWORK_OPCODE</b> enumerated type specifies the possible values of the operation code for the
///properties to query or set on the wireless Hosted Network.
alias WLAN_HOSTED_NETWORK_OPCODE = int;
enum : int
{
    ///The opcode used to query or set the wireless Hosted Network connection settings.
    wlan_hosted_network_opcode_connection_settings = 0x00000000,
    ///The opcode used to query the wireless Hosted Network security settings.
    wlan_hosted_network_opcode_security_settings   = 0x00000001,
    ///The opcode used to query the wireless Hosted Network station profile.
    wlan_hosted_network_opcode_station_profile     = 0x00000002,
    ///The opcode used to query or set the wireless Hosted Network enabled flag.
    wlan_hosted_network_opcode_enable              = 0x00000003,
}

///The <b>ONEX_AUTH_IDENTITY</b> enumerated type specifies the possible values of the identity used for 802.1X
///authentication status.
alias ONEX_AUTH_IDENTITY = int;
enum : int
{
    ///No identity is specified in the profile used for 802.1X authentication.
    OneXAuthIdentityNone         = 0x00000000,
    ///The identity of the local machine account is used for 802.1X authentication.
    OneXAuthIdentityMachine      = 0x00000001,
    ///The identity of the logged-on user is used for 802.1X authentication.
    OneXAuthIdentityUser         = 0x00000002,
    ///The identity of an explicit user as specified in the profile is used for 802.1X authentication. This value is
    ///used when performing single signon or when credentials are saved with the profile.
    OneXAuthIdentityExplicitUser = 0x00000003,
    ///The identity of the Guest account as specified in the profile is used for 802.1X authentication.
    OneXAuthIdentityGuest        = 0x00000004,
    ///The identity is not valid as specified in the profile used for 802.1X authentication.
    OneXAuthIdentityInvalid      = 0x00000005,
}

///The <b>ONEX_AUTH_STATUS</b> enumerated type specifies the possible values for the 802.1X authentication status.
alias ONEX_AUTH_STATUS = int;
enum : int
{
    ///802.1X authentication was not started.
    OneXAuthNotStarted           = 0x00000000,
    ///802.1X authentication is in progress.
    OneXAuthInProgress           = 0x00000001,
    ///No 802.1X authenticator was found. The 802.1X authentication was attempted, but no 802.1X peer was found. In this
    ///case, either the network does not support or is not configured to support the 802.1X standard.
    OneXAuthNoAuthenticatorFound = 0x00000002,
    ///802.1X authentication was successful.
    OneXAuthSuccess              = 0x00000003,
    ///802.1X authentication was a failure.
    OneXAuthFailure              = 0x00000004,
    ///Indicates the end of the range that specifies the possible values for 802.1X authentication status.
    OneXAuthInvalid              = 0x00000005,
}

///The <b>ONEX_REASON_CODE</b> enumerated type specifies the possible values that indicate the reason that 802.1X
///authentication failed.
alias ONEX_REASON_CODE = int;
enum : int
{
    ///Indicates the 802.1X authentication was a success.
    ONEX_REASON_CODE_SUCCESS                       = 0x00000000,
    ///Indicates the start of the range that specifies the possible values for 802.1X reason code.
    ONEX_REASON_START                              = 0x00050000,
    ///The 802.1X module was unable to identify a set of credentials to be used. An example is when the authentication
    ///mode is set to user, but no user is logged on.
    ONEX_UNABLE_TO_IDENTIFY_USER                   = 0x00050001,
    ///The EAP module was unable to acquire an identity for the user. Thus value is not currently used. All EAP-specific
    ///errors are returned as <b>ONEX_EAP_FAILURE_RECEIVED</b>.
    ONEX_IDENTITY_NOT_FOUND                        = 0x00050002,
    ///To proceed with 802.1X authentication, the system needs to request user input, but the user interface is
    ///disabled. On Windows Vista and on Windows Server 2008, this value can be returned if an EAP method requested user
    ///input for a profile for Guest or local machine authentication. On Windows 7 and on Windows Server 2008 R2 with
    ///the Wireless LAN Service installed, this value should not be returned.
    ONEX_UI_DISABLED                               = 0x00050003,
    ///The 802.1X authentication module was unable to return the requested user input. On Windows 7 and on Windows
    ///Server 2008 R2 with the Wireless LAN Service installed, this value can be returned if an EAP method requested
    ///user input, but the UI could not be displayed (the network icon was configured to not show in the taskbar, for
    ///example).
    ONEX_UI_FAILURE                                = 0x00050004,
    ///The EAP module returned an error code. The ONEX_EAP_ERROR structure may contain additional information about the
    ///specific EAP error (a certificate not found, for example).
    ONEX_EAP_FAILURE_RECEIVED                      = 0x00050005,
    ///The peer with which the 802.1X module was negotiating is no longer present or is not responding (a laptop client
    ///moved out of range of the wireless access point, for example).
    ONEX_AUTHENTICATOR_NO_LONGER_PRESENT           = 0x00050006,
    ///No response was received to an EAP identity response packet. This value indicates a problem with the
    ///infrastructure (a link between the wireless access point and the authentication server is not functioning, for
    ///example).
    ONEX_NO_RESPONSE_TO_IDENTITY                   = 0x00050007,
    ///The 802.1X module does not support this version of the profile.
    ONEX_PROFILE_VERSION_NOT_SUPPORTED             = 0x00050008,
    ///The length member specified in the 802.1X profile is invalid.
    ONEX_PROFILE_INVALID_LENGTH                    = 0x00050009,
    ///The EAP type specified in the 802.1X profile is not allowed for this media. An example is when the keyed MD5
    ///algorithm is used for wireless transmission.
    ONEX_PROFILE_DISALLOWED_EAP_TYPE               = 0x0005000a,
    ///The EAP type or EAP flags specified in the 802.1X profile are not valid. An example is when EAP type is not
    ///installed on the system.
    ONEX_PROFILE_INVALID_EAP_TYPE_OR_FLAG          = 0x0005000b,
    ///The 802.1X flags specified in the 802.1X profile are not valid.
    ONEX_PROFILE_INVALID_ONEX_FLAGS                = 0x0005000c,
    ///One or more timer values specified in the 802.1X profile is out of its valid range.
    ONEX_PROFILE_INVALID_TIMER_VALUE               = 0x0005000d,
    ///The supplicant mode specified in the 802.1X profile is not valid.
    ONEX_PROFILE_INVALID_SUPPLICANT_MODE           = 0x0005000e,
    ///The authentication mode specified in the 802.1X profile is not valid.
    ONEX_PROFILE_INVALID_AUTH_MODE                 = 0x0005000f,
    ///The EAP connection properties specified in the 802.1X profile are not valid.
    ONEX_PROFILE_INVALID_EAP_CONNECTION_PROPERTIES = 0x00050010,
    ///User input was canceled. This value can be returned if an EAP method requested user input, but the user hit the
    ///Cancel button or dismissed the user input dialog. This value is supported on Windows 7 and on Windows Server 2008
    ///R2 with the Wireless LAN Service installed.
    ONEX_UI_CANCELLED                              = 0x00050011,
    ///The saved user credentials are not valid. This value can be returned if a profile was saved with bad credentials
    ///(an incorrect password, for example), since the credentials are not tested until the profile is actually used to
    ///establish a connection. This value is supported on Windows 7 and on Windows Server 2008 R2 with the Wireless LAN
    ///Service installed.
    ONEX_PROFILE_INVALID_EXPLICIT_CREDENTIALS      = 0x00050012,
    ///The saved user credentials have expired. This value can be returned if a profile was saved with credentials and
    ///the credentials subsequently expired (password expiration after some period of time, for example). This value is
    ///supported on Windows 7 and on Windows Server 2008 R2 with the Wireless LAN Service installed.
    ONEX_PROFILE_EXPIRED_EXPLICIT_CREDENTIALS      = 0x00050013,
    ///User interface is not permitted. On Windows 7 and on Windows Server 2008 R2 with the Wireless LAN Service
    ///installed, this value can be returned if an EAP method requested user input and the profile is configured with
    ///user credentials saved by another user and not the currently logged in user. This value is supported on Windows 7
    ///and on Windows Server 2008 R2 with the Wireless LAN Service installed.
    ONEX_UI_NOT_PERMITTED                          = 0x00050014,
}

///The <b>ONEX_NOTIFICATION_TYPE</b> enumerated type specifies the possible values of the <b>NotificationCode</b> member
///of the WLAN_NOTIFICATION_DATA structure for 802.1X module notifications.
alias ONEX_NOTIFICATION_TYPE = int;
enum : int
{
    ///Indicates the beginning of the range that specifies the possible values for 802.1X notifications.
    OneXPublicNotificationBase        = 0x00000000,
    ///Indicates that 802.1X authentication has a status change. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA
    ///structure points to a ONEX_RESULT_UPDATE_DATA structure that contains 802.1X update data.
    OneXNotificationTypeResultUpdate  = 0x00000001,
    ///Indicates that 802.1X authentication restarted. The <b>pData</b> member of the WLAN_NOTIFICATION_DATA structure
    ///points to an ONEX_AUTH_RESTART_REASON enumeration value that identifies the reason the authentication was
    ///restarted.
    OneXNotificationTypeAuthRestarted = 0x00000002,
    ///Indicates the end of the range that specifies the possible values for 802.1X notifications.
    OneXNotificationTypeEventInvalid  = 0x00000003,
    ///Indicates the end of the range that specifies the possible values for 802.1X notifications.
    OneXNumNotifications              = 0x00000003,
}

///The <b>ONEX_AUTH_RESTART_REASON</b> enumerated type specifies the possible reasons that 802.1X authentication was
///restarted.
alias ONEX_AUTH_RESTART_REASON = int;
enum : int
{
    ///The EAPHost component (the peer) requested the 802.1x module to restart 802.1X authentication. This results from
    ///a EapHostPeerProcessReceivedPacket function call that returns an EapHostPeerResponseAction enumeration value of
    ///<b>EapHostPeerResponseStartAuthentication</b> in the <i>pEapOutput</i> parameter.
    OneXRestartReasonPeerInitiated            = 0x00000000,
    ///The Media Specific Module (MSM) initiated the 802.1X authentication restart.
    OneXRestartReasonMsmInitiated             = 0x00000001,
    ///The 802.1X authentication restart was the result of a state timeout. The timer expiring is the heldWhile timer of
    ///the 802.1X supplicant state machine defined in IEEE 802.1X - 2004 standard for Port-Based Network Access Control.
    ///The heldWhile timer is used by the supplicant state machine to define periods of time during which it will not
    ///attempt to acquire an authenticator.
    OneXRestartReasonOneXHeldStateTimeout     = 0x00000002,
    ///The 802.1X authentication restart was the result of an state timeout. The timer expiring is the authWhile timer
    ///of the 802.1X supplicant port access entity defined in IEEE 802.1X - 2004 standard for Port-Based Network Access
    ///Control. The authWhile timer is used by the supplicant port access entity to determine how long to wait for a
    ///request from the authenticator before timing it out.
    OneXRestartReasonOneXAuthTimeout          = 0x00000003,
    ///The 802.1X authentication restart was the result of a configuration change to the current profile.
    OneXRestartReasonOneXConfigurationChanged = 0x00000004,
    ///The 802.1X authentication restart was the result of a change of user. This could occur if the current user logs
    ///off and new user logs on to the local computer.
    OneXRestartReasonOneXUserChanged          = 0x00000005,
    ///The 802.1X authentication restart was the result of receiving a notification from the EAP quarantine enforcement
    ///client (QEC) due to a network health change. If an EAPHost supplicant is participating in network access
    ///protection (NAP), the supplicant will respond to changes in the state of its network health. If that state
    ///changes, the supplicant must then initiate a re-authentication session. For more information, see the
    ///EapHostPeerBeginSession function.
    OneXRestartReasonQuarantineStateChanged   = 0x00000006,
    ///The 802.1X authentication restart was caused by a new authentication attempt with alternate user credentials. EAP
    ///methods like MSCHAPv2 prefer to use logged-on user credentials for 802.1X authentication. If these user
    ///credentials do not work, then a dialog will be displayed to the user that asks permission to use alternate
    ///credentials for 802.1X authentication. For more information, see the EapHostPeerBeginSession function and
    ///EAP_FLAG_PREFER_ALT_CREDENTIALS flag in the <i>dwflags</i> parameter.
    OneXRestartReasonAltCredsTrial            = 0x00000007,
    ///Indicates the end of the range that specifies the possible reasons that 802.1X authentication was restarted.
    OneXRestartReasonInvalid                  = 0x00000008,
}

///The <b>ONEX_EAP_METHOD_BACKEND_SUPPORT</b> enumerated type specifies the possible values for whether the EAP method
///configured on the supplicant for 802.1X authentication is supported on the authentication server.
alias ONEX_EAP_METHOD_BACKEND_SUPPORT = int;
enum : int
{
    ///It is not known whether the EAP method configured on the supplicant for 802.1X authentication is supported on the
    ///authentication server. This value can be returned if the 802.1X authentication process is in the initial state.
    OneXEapMethodBackendSupportUnknown = 0x00000000,
    ///The EAP method configured on the supplicant for 802.1X authentication is supported on the authentication server.
    ///The 802.1X handshake is used to decide what is an acceptable EAP method to use.
    OneXEapMethodBackendSupported      = 0x00000001,
    ///The EAP method configured on the supplicant for 802.1X authentication is not supported on the authentication
    ///server.
    OneXEapMethodBackendUnsupported    = 0x00000002,
}

///Specifies a cipher algorithm used to encrypt and decrypt information on an ad hoc network.
alias DOT11_ADHOC_CIPHER_ALGORITHM = int;
enum : int
{
    ///The cipher algorithm specified is invalid.
    DOT11_ADHOC_CIPHER_ALGO_INVALID = 0xffffffff,
    ///Specifies that no cipher algorithm is enabled or supported.
    DOT11_ADHOC_CIPHER_ALGO_NONE    = 0x00000000,
    ///Specifies a Counter Mode with Cipher Block Chaining Message Authentication Code Protocol (CCMP) algorithm. The
    ///CCMP algorithm is specified in the IEEE 802.11i-2004 standard and RFC 3610. CCMP is used with the Advanced
    ///Encryption Standard (AES) encryption algorithm, as defined in FIPS PUB 197.
    DOT11_ADHOC_CIPHER_ALGO_CCMP    = 0x00000004,
    ///Specifies a Wired Equivalent Privacy (WEP) algorithm of any length.
    DOT11_ADHOC_CIPHER_ALGO_WEP     = 0x00000101,
}

///Specifies the authentication algorithm for user or machine authentication on an ad hoc network.
alias DOT11_ADHOC_AUTH_ALGORITHM = int;
enum : int
{
    ///The authentication algorithm specified is invalid.
    DOT11_ADHOC_AUTH_ALGO_INVALID    = 0xffffffff,
    ///Specifies an IEEE 802.11 Open System authentication algorithm.
    DOT11_ADHOC_AUTH_ALGO_80211_OPEN = 0x00000001,
    ///Specifies an IEEE 802.11i Robust Security Network Association (RSNA) algorithm that uses the pre-shared key (PSK)
    ///mode. IEEE 802.1X port authorization is performed by the supplicant and authenticator. Cipher keys are
    ///dynamically derived through a pre-shared key that is used on both the supplicant and authenticator.
    DOT11_ADHOC_AUTH_ALGO_RSNA_PSK   = 0x00000007,
}

///Specifies the connection state of an ad hoc network.
alias DOT11_ADHOC_NETWORK_CONNECTION_STATUS = int;
enum : int
{
    ///The connection status cannot be determined. A network with this status should not be used.
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_INVALID      = 0x00000000,
    ///There are no hosts or clients connected to the network. There are also no pending connection requests for this
    ///network.
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_DISCONNECTED = 0x0000000b,
    ///There is an outstanding connection request. Once the client or host succeeds or fails in its connection attempt,
    ///the connection status is updated.
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_CONNECTING   = 0x0000000c,
    ///A client or host is connected to the network.
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_CONNECTED    = 0x0000000d,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_FORMED       = 0x0000000e,
}

///Specifies the reason why a connection attempt failed.
alias DOT11_ADHOC_CONNECT_FAIL_REASON = int;
enum : int
{
    ///The local host's configuration is incompatible with the target network. This occurs when the local host is
    ///802.11d compliant and the regulatory domain of the local host is not compatible with the regulatory domain of the
    ///target network. For more information about regulatory domains, see the IEEE 802.11d-2001 standard. The standard
    ///can be downloaded from the IEEE website.
    DOT11_ADHOC_CONNECT_FAIL_DOMAIN_MISMATCH     = 0x00000000,
    ///The passphrase supplied to authenticate the local machine or user on the target network is incorrect.
    DOT11_ADHOC_CONNECT_FAIL_PASSPHRASE_MISMATCH = 0x00000001,
    DOT11_ADHOC_CONNECT_FAIL_OTHER               = 0x00000002,
}

// Callbacks

///The <b>WLAN_NOTIFICATION_CALLBACK</b> callback function prototype defines the type of notification callback function.
///Params:
///    Arg1 = A pointer to a WLAN_NOTIFICATION_DATA structure that contains the notification information. <b>Windows XP with
///           SP3 and Wireless LAN API for Windows XP with SP2: </b>Only the wlan_notification_acm_connection_complete and
///           wlan_notification_acm_disconnected notifications are available.
///    Arg2 = A pointer to the context information provided by the client when it registered for the notification.
alias WLAN_NOTIFICATION_CALLBACK = void function(L2_NOTIFICATION_DATA* param0, void* param1);
///The <b>WFD_OPEN_SESSION_COMPLETE_CALLBACK</b> function defines the callback function that is called by the
///WFDStartOpenSession function when the <b>WFDStartOpenSession</b> operation completes.
///Params:
///    hSessionHandle = A session handle to a Wi-Fi Direct session. This is a session handle previously returned by the
///                     WFDStartOpenSession function.
///    pvContext = An context pointer passed to the callback function from the WFDStartOpenSession function.
///    guidSessionInterface = The interface GUID of the local network interface on which this Wi-Fi Direct device has an open session. This
///                           parameter is useful if higher-layer protocols need to determine which network interface a Wi-Fi Direct session is
///                           bound to. This value is only returned if the <i>dwError</i> parameter is ERROR_SUCCESS.
///    dwError = A value that specifies whether there was an error encountered during the call to the WFDStartOpenSession
///              function. If this value is ERROR_SUCCESS, then no error occurred and the operation to open the session completed
///              successfully. The following other values are possible: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="ERROR_INVALID_PARAMETER"></a><a id="error_invalid_parameter"></a><dl>
///              <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The parameter is incorrect. This error is
///              returned if the <i>hClientHandle</i> parameter is <b>NULL</b> or not valid. </td> </tr> <tr> <td width="40%"><a
///              id="ERROR_INVALID_STATE"></a><a id="error_invalid_state"></a><dl> <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td>
///              <td width="60%"> The group or resource is not in the correct state to perform the requested operation. This error
///              is returned if the Wi-Fi Direct service is disabled by group policy on a domain. </td> </tr> <tr> <td
///              width="40%"><a id="ERROR_SERVICE_NOT_ACTIVE"></a><a id="error_service_not_active"></a><dl>
///              <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td width="60%"> The service has not been started. This
///              error is returned if the WLAN AutoConfig Service is not running. </td> </tr> <tr> <td width="40%"><a
///              id="RPC_STATUS"></a><a id="rpc_status"></a><dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various
///              RPC and other error codes. Use <b>FormatMessage</b> to obtain the message string for the returned error. </td>
///              </tr> </table>
///    dwReasonCode = A value that specifies the more detail if an error occurred during WFDStartOpenSession.
alias WFD_OPEN_SESSION_COMPLETE_CALLBACK = void function(HANDLE hSessionHandle, void* pvContext, 
                                                         GUID guidSessionInterface, uint dwError, uint dwReasonCode);

// Structs


struct DOT11_SSID
{
    uint      uSSIDLength;
    ubyte[32] ucSSID;
}

struct DOT11_AUTH_CIPHER_PAIR
{
    DOT11_AUTH_ALGORITHM AuthAlgoId;
    DOT11_CIPHER_ALGORITHM CipherAlgoId;
}

struct DOT11_OI
{
    ushort   OILength;
    ubyte[5] OI;
}

struct DOT11_ACCESSNETWORKOPTIONS
{
    ubyte AccessNetworkType;
    ubyte Internet;
    ubyte ASRA;
    ubyte ESR;
    ubyte UESA;
}

struct DOT11_VENUEINFO
{
    ubyte VenueGroup;
    ubyte VenueType;
}

struct NDIS_STATISTICS_VALUE
{
    uint     Oid;
    uint     DataLength;
    ubyte[1] Data;
}

struct NDIS_STATISTICS_VALUE_EX
{
    uint     Oid;
    uint     DataLength;
    uint     Length;
    ubyte[1] Data;
}

struct NDIS_VAR_DATA_DESC
{
    ushort Length;
    ushort MaximumLength;
    size_t Offset;
}

struct NDIS_OBJECT_HEADER
{
    ubyte  Type;
    ubyte  Revision;
    ushort Size;
}

struct NDIS_STATISTICS_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               SupportedStatistics;
    ulong              ifInDiscards;
    ulong              ifInErrors;
    ulong              ifHCInOctets;
    ulong              ifHCInUcastPkts;
    ulong              ifHCInMulticastPkts;
    ulong              ifHCInBroadcastPkts;
    ulong              ifHCOutOctets;
    ulong              ifHCOutUcastPkts;
    ulong              ifHCOutMulticastPkts;
    ulong              ifHCOutBroadcastPkts;
    ulong              ifOutErrors;
    ulong              ifOutDiscards;
    ulong              ifHCInUcastOctets;
    ulong              ifHCInMulticastOctets;
    ulong              ifHCInBroadcastOctets;
    ulong              ifHCOutUcastOctets;
    ulong              ifHCOutMulticastOctets;
    ulong              ifHCOutBroadcastOctets;
}

struct NDIS_INTERRUPT_MODERATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    NDIS_INTERRUPT_MODERATION InterruptModeration;
}

struct NDIS_TIMEOUT_DPC_REQUEST_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    uint               TimeoutArrayLength;
    uint[1]            TimeoutArray;
}

struct NDIS_PCI_DEVICE_CUSTOM_PROPERTIES
{
    NDIS_OBJECT_HEADER Header;
    uint               DeviceType;
    uint               CurrentSpeedAndMode;
    uint               CurrentPayloadSize;
    uint               MaxPayloadSize;
    uint               MaxReadRequestSize;
    uint               CurrentLinkSpeed;
    uint               CurrentLinkWidth;
    uint               MaxLinkSpeed;
    uint               MaxLinkWidth;
    uint               PciExpressVersion;
    uint               InterruptType;
    uint               MaxInterruptMessages;
}

struct NDIS_802_11_STATUS_INDICATION
{
    NDIS_802_11_STATUS_TYPE StatusType;
}

struct NDIS_802_11_AUTHENTICATION_REQUEST
{
    uint     Length;
    ubyte[6] Bssid;
    uint     Flags;
}

struct PMKID_CANDIDATE
{
    ubyte[6] BSSID;
    uint     Flags;
}

struct NDIS_802_11_PMKID_CANDIDATE_LIST
{
    uint               Version;
    uint               NumCandidates;
    PMKID_CANDIDATE[1] CandidateList;
}

struct NDIS_802_11_NETWORK_TYPE_LIST
{
    uint NumberOfItems;
    NDIS_802_11_NETWORK_TYPE[1] NetworkType;
}

struct NDIS_802_11_CONFIGURATION_FH
{
    uint Length;
    uint HopPattern;
    uint HopSet;
    uint DwellTime;
}

struct NDIS_802_11_CONFIGURATION
{
    uint Length;
    uint BeaconPeriod;
    uint ATIMWindow;
    uint DSConfig;
    NDIS_802_11_CONFIGURATION_FH FHConfig;
}

struct NDIS_802_11_STATISTICS
{
    uint          Length;
    LARGE_INTEGER TransmittedFragmentCount;
    LARGE_INTEGER MulticastTransmittedFrameCount;
    LARGE_INTEGER FailedCount;
    LARGE_INTEGER RetryCount;
    LARGE_INTEGER MultipleRetryCount;
    LARGE_INTEGER RTSSuccessCount;
    LARGE_INTEGER RTSFailureCount;
    LARGE_INTEGER ACKFailureCount;
    LARGE_INTEGER FrameDuplicateCount;
    LARGE_INTEGER ReceivedFragmentCount;
    LARGE_INTEGER MulticastReceivedFrameCount;
    LARGE_INTEGER FCSErrorCount;
    LARGE_INTEGER TKIPLocalMICFailures;
    LARGE_INTEGER TKIPICVErrorCount;
    LARGE_INTEGER TKIPCounterMeasuresInvoked;
    LARGE_INTEGER TKIPReplays;
    LARGE_INTEGER CCMPFormatErrors;
    LARGE_INTEGER CCMPReplays;
    LARGE_INTEGER CCMPDecryptErrors;
    LARGE_INTEGER FourWayHandshakeFailures;
    LARGE_INTEGER WEPUndecryptableCount;
    LARGE_INTEGER WEPICVErrorCount;
    LARGE_INTEGER DecryptSuccessCount;
    LARGE_INTEGER DecryptFailureCount;
}

struct NDIS_802_11_KEY
{
    uint     Length;
    uint     KeyIndex;
    uint     KeyLength;
    ubyte[6] BSSID;
    ulong    KeyRSC;
    ubyte[1] KeyMaterial;
}

struct NDIS_802_11_REMOVE_KEY
{
    uint     Length;
    uint     KeyIndex;
    ubyte[6] BSSID;
}

struct NDIS_802_11_WEP
{
    uint     Length;
    uint     KeyIndex;
    uint     KeyLength;
    ubyte[1] KeyMaterial;
}

struct NDIS_802_11_SSID
{
    uint      SsidLength;
    ubyte[32] Ssid;
}

struct NDIS_WLAN_BSSID
{
    uint             Length;
    ubyte[6]         MacAddress;
    ubyte[2]         Reserved;
    NDIS_802_11_SSID Ssid;
    uint             Privacy;
    int              Rssi;
    NDIS_802_11_NETWORK_TYPE NetworkTypeInUse;
    NDIS_802_11_CONFIGURATION Configuration;
    NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode;
    ubyte[8]         SupportedRates;
}

struct NDIS_802_11_BSSID_LIST
{
    uint               NumberOfItems;
    NDIS_WLAN_BSSID[1] Bssid;
}

struct NDIS_WLAN_BSSID_EX
{
    uint             Length;
    ubyte[6]         MacAddress;
    ubyte[2]         Reserved;
    NDIS_802_11_SSID Ssid;
    uint             Privacy;
    int              Rssi;
    NDIS_802_11_NETWORK_TYPE NetworkTypeInUse;
    NDIS_802_11_CONFIGURATION Configuration;
    NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode;
    ubyte[16]        SupportedRates;
    uint             IELength;
    ubyte[1]         IEs;
}

struct NDIS_802_11_BSSID_LIST_EX
{
    uint NumberOfItems;
    NDIS_WLAN_BSSID_EX[1] Bssid;
}

struct NDIS_802_11_FIXED_IEs
{
    ubyte[8] Timestamp;
    ushort   BeaconInterval;
    ushort   Capabilities;
}

struct NDIS_802_11_VARIABLE_IEs
{
    ubyte    ElementID;
    ubyte    Length;
    ubyte[1] data;
}

struct NDIS_802_11_AI_REQFI
{
    ushort   Capabilities;
    ushort   ListenInterval;
    ubyte[6] CurrentAPAddress;
}

struct NDIS_802_11_AI_RESFI
{
    ushort Capabilities;
    ushort StatusCode;
    ushort AssociationId;
}

struct NDIS_802_11_ASSOCIATION_INFORMATION
{
    uint                 Length;
    ushort               AvailableRequestFixedIEs;
    NDIS_802_11_AI_REQFI RequestFixedIEs;
    uint                 RequestIELength;
    uint                 OffsetRequestIEs;
    ushort               AvailableResponseFixedIEs;
    NDIS_802_11_AI_RESFI ResponseFixedIEs;
    uint                 ResponseIELength;
    uint                 OffsetResponseIEs;
}

struct NDIS_802_11_AUTHENTICATION_EVENT
{
    NDIS_802_11_STATUS_INDICATION Status;
    NDIS_802_11_AUTHENTICATION_REQUEST[1] Request;
}

struct NDIS_802_11_TEST
{
    uint Length;
    uint Type;
    union
    {
        NDIS_802_11_AUTHENTICATION_EVENT AuthenticationEvent;
        int RssiTrigger;
    }
}

struct BSSID_INFO
{
    ubyte[6]  BSSID;
    ubyte[16] PMKID;
}

struct NDIS_802_11_PMKID
{
    uint          Length;
    uint          BSSIDInfoCount;
    BSSID_INFO[1] BSSIDInfo;
}

struct NDIS_802_11_AUTHENTICATION_ENCRYPTION
{
    NDIS_802_11_AUTHENTICATION_MODE AuthModeSupported;
    NDIS_802_11_WEP_STATUS EncryptStatusSupported;
}

struct NDIS_802_11_CAPABILITY
{
    uint Length;
    uint Version;
    uint NoOfPMKIDs;
    uint NoOfAuthEncryptPairsSupported;
    NDIS_802_11_AUTHENTICATION_ENCRYPTION[1] AuthenticationEncryptionSupported;
}

struct NDIS_802_11_NON_BCAST_SSID_LIST
{
    uint                NumberOfItems;
    NDIS_802_11_SSID[1] Non_Bcast_Ssid;
}

struct NDIS_CO_DEVICE_PROFILE
{
    NDIS_VAR_DATA_DESC DeviceDescription;
    NDIS_VAR_DATA_DESC DevSpecificInfo;
    uint               ulTAPISupplementaryPassThru;
    uint               ulAddressModes;
    uint               ulNumAddresses;
    uint               ulBearerModes;
    uint               ulMaxTxRate;
    uint               ulMinTxRate;
    uint               ulMaxRxRate;
    uint               ulMinRxRate;
    uint               ulMediaModes;
    uint               ulGenerateToneModes;
    uint               ulGenerateToneMaxNumFreq;
    uint               ulGenerateDigitModes;
    uint               ulMonitorToneMaxNumFreq;
    uint               ulMonitorToneMaxNumEntries;
    uint               ulMonitorDigitModes;
    uint               ulGatherDigitsMinTimeout;
    uint               ulGatherDigitsMaxTimeout;
    uint               ulDevCapFlags;
    uint               ulMaxNumActiveCalls;
    uint               ulAnswerMode;
    uint               ulUUIAcceptSize;
    uint               ulUUIAnswerSize;
    uint               ulUUIMakeCallSize;
    uint               ulUUIDropSize;
    uint               ulUUISendUserUserInfoSize;
    uint               ulUUICallInfoSize;
}

struct OFFLOAD_ALGO_INFO
{
    uint algoIdentifier;
    uint algoKeylen;
    uint algoRounds;
}

struct OFFLOAD_SECURITY_ASSOCIATION
{
    OFFLOAD_OPERATION_E Operation;
    uint                SPI;
    OFFLOAD_ALGO_INFO   IntegrityAlgo;
    OFFLOAD_ALGO_INFO   ConfAlgo;
    OFFLOAD_ALGO_INFO   Reserved;
}

struct OFFLOAD_IPSEC_ADD_SA
{
    uint     SrcAddr;
    uint     SrcMask;
    uint     DestAddr;
    uint     DestMask;
    uint     Protocol;
    ushort   SrcPort;
    ushort   DestPort;
    uint     SrcTunnelAddr;
    uint     DestTunnelAddr;
    ushort   Flags;
    short    NumSAs;
    OFFLOAD_SECURITY_ASSOCIATION[3] SecAssoc;
    HANDLE   OffloadHandle;
    uint     KeyLen;
    ubyte[1] KeyMat;
}

struct OFFLOAD_IPSEC_DELETE_SA
{
    HANDLE OffloadHandle;
}

struct OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY
{
    UDP_ENCAP_TYPE UdpEncapType;
    ushort         DstEncapPort;
}

struct OFFLOAD_IPSEC_ADD_UDPESP_SA
{
    uint     SrcAddr;
    uint     SrcMask;
    uint     DstAddr;
    uint     DstMask;
    uint     Protocol;
    ushort   SrcPort;
    ushort   DstPort;
    uint     SrcTunnelAddr;
    uint     DstTunnelAddr;
    ushort   Flags;
    short    NumSAs;
    OFFLOAD_SECURITY_ASSOCIATION[3] SecAssoc;
    HANDLE   OffloadHandle;
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY EncapTypeEntry;
    HANDLE   EncapTypeEntryOffldHandle;
    uint     KeyLen;
    ubyte[1] KeyMat;
}

struct OFFLOAD_IPSEC_DELETE_UDPESP_SA
{
    HANDLE OffloadHandle;
    HANDLE EncapTypeEntryOffldHandle;
}

struct TRANSPORT_HEADER_OFFSET
{
    ushort ProtocolType;
    ushort HeaderOffset;
}

struct NETWORK_ADDRESS
{
    ushort   AddressLength;
    ushort   AddressType;
    ubyte[1] Address;
}

struct NETWORK_ADDRESS_LIST
{
    int                AddressCount;
    ushort             AddressType;
    NETWORK_ADDRESS[1] Address;
}

struct NETWORK_ADDRESS_IP
{
    ushort   sin_port;
    uint     in_addr;
    ubyte[8] sin_zero;
}

struct NETWORK_ADDRESS_IP6
{
    ushort    sin6_port;
    uint      sin6_flowinfo;
    ushort[8] sin6_addr;
    uint      sin6_scope_id;
}

struct NETWORK_ADDRESS_IPX
{
    uint     NetworkAddress;
    ubyte[6] NodeAddress;
    ushort   Socket;
}

struct GEN_GET_TIME_CAPS
{
    uint Flags;
    uint ClockPrecision;
}

struct GEN_GET_NETCARD_TIME
{
    ulong ReadTime;
}

struct NDIS_PM_PACKET_PATTERN
{
    uint Priority;
    uint Reserved;
    uint MaskSize;
    uint PatternOffset;
    uint PatternSize;
    uint PatternFlags;
}

struct NDIS_PM_WAKE_UP_CAPABILITIES
{
    NDIS_DEVICE_POWER_STATE MinMagicPacketWakeUp;
    NDIS_DEVICE_POWER_STATE MinPatternWakeUp;
    NDIS_DEVICE_POWER_STATE MinLinkChangeWakeUp;
}

struct NDIS_PNP_CAPABILITIES
{
    uint Flags;
    NDIS_PM_WAKE_UP_CAPABILITIES WakeUpCapabilities;
}

struct NDIS_WAN_PROTOCOL_CAPS
{
    uint Flags;
    uint Reserved;
}

struct NDIS_CO_LINK_SPEED
{
    uint Outbound;
    uint Inbound;
}

struct NDIS_LINK_SPEED
{
    ulong XmitLinkSpeed;
    ulong RcvLinkSpeed;
}

struct NDIS_GUID
{
    GUID Guid;
    union
    {
        uint Oid;
        int  Status;
    }
    uint Size;
    uint Flags;
}

struct NDIS_IRDA_PACKET_INFO
{
    uint ExtraBOFs;
    uint MinTurnAroundTime;
}

struct NDIS_LINK_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NDIS_SUPPORTED_PAUSE_FUNCTIONS PauseFunctions;
    uint               AutoNegotiationFlags;
}

struct NDIS_LINK_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NDIS_SUPPORTED_PAUSE_FUNCTIONS PauseFunctions;
    uint               AutoNegotiationFlags;
}

struct NDIS_OPER_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_OPER_STATUS OperationalStatus;
    uint               OperationalStatusFlags;
}

struct NDIS_IP_OPER_STATUS
{
    uint               AddressFamily;
    NET_IF_OPER_STATUS OperationalStatus;
    uint               OperationalStatusFlags;
}

struct NDIS_IP_OPER_STATUS_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    uint               NumberofAddressFamiliesReturned;
    NDIS_IP_OPER_STATUS[32] IpOperationalStatus;
}

struct NDIS_IP_OPER_STATE
{
    NDIS_OBJECT_HEADER  Header;
    uint                Flags;
    NDIS_IP_OPER_STATUS IpOperationalStatus;
}

struct NDIS_OFFLOAD_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              IPv4Checksum;
    ubyte              TCPIPv4Checksum;
    ubyte              UDPIPv4Checksum;
    ubyte              TCPIPv6Checksum;
    ubyte              UDPIPv6Checksum;
    ubyte              LsoV1;
    ubyte              IPsecV1;
    ubyte              LsoV2IPv4;
    ubyte              LsoV2IPv6;
    ubyte              TcpConnectionIPv4;
    ubyte              TcpConnectionIPv6;
    uint               Flags;
}

struct NDIS_TCP_LARGE_SEND_OFFLOAD_V1
{
    struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        uint _bitfield75;
    }
}

struct NDIS_TCP_IP_CHECKSUM_OFFLOAD
{
    struct IPv4Transmit
    {
        uint Encapsulation;
        uint _bitfield76;
    }
    struct IPv4Receive
    {
        uint Encapsulation;
        uint _bitfield77;
    }
    struct IPv6Transmit
    {
        uint Encapsulation;
        uint _bitfield78;
    }
    struct IPv6Receive
    {
        uint Encapsulation;
        uint _bitfield79;
    }
}

struct NDIS_IPSEC_OFFLOAD_V1
{
    struct Supported
    {
        uint Encapsulation;
        uint AhEspCombined;
        uint TransportTunnelCombined;
        uint IPv4Options;
        uint Flags;
    }
    struct IPv4AH
    {
        uint _bitfield80;
    }
    struct IPv4ESP
    {
        uint _bitfield81;
    }
}

struct NDIS_TCP_LARGE_SEND_OFFLOAD_V2
{
    struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
    }
    struct IPv6
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        uint _bitfield82;
    }
}

struct NDIS_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    NDIS_TCP_IP_CHECKSUM_OFFLOAD Checksum;
    NDIS_TCP_LARGE_SEND_OFFLOAD_V1 LsoV1;
    NDIS_IPSEC_OFFLOAD_V1 IPsecV1;
    NDIS_TCP_LARGE_SEND_OFFLOAD_V2 LsoV2;
    uint               Flags;
}

struct NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1
{
    struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        uint TcpOptions;
        uint IpOptions;
    }
}

struct NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD
{
    struct IPv4Transmit
    {
        uint Encapsulation;
        uint IpOptionsSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
        uint IpChecksum;
    }
    struct IPv4Receive
    {
        uint Encapsulation;
        uint IpOptionsSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
        uint IpChecksum;
    }
    struct IPv6Transmit
    {
        uint Encapsulation;
        uint IpExtensionHeadersSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
    }
    struct IPv6Receive
    {
        uint Encapsulation;
        uint IpExtensionHeadersSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
    }
}

struct NDIS_WMI_IPSEC_OFFLOAD_V1
{
    struct Supported
    {
        uint Encapsulation;
        uint AhEspCombined;
        uint TransportTunnelCombined;
        uint IPv4Options;
        uint Flags;
    }
    struct IPv4AH
    {
        uint Md5;
        uint Sha_1;
        uint Transport;
        uint Tunnel;
        uint Send;
        uint Receive;
    }
    struct IPv4ESP
    {
        uint Des;
        uint Reserved;
        uint TripleDes;
        uint NullEsp;
        uint Transport;
        uint Tunnel;
        uint Send;
        uint Receive;
    }
}

struct NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2
{
    struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
    }
    struct IPv6
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        uint IpExtensionHeadersSupported;
        uint TcpOptionsSupported;
    }
}

struct NDIS_WMI_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD Checksum;
    NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1 LsoV1;
    NDIS_WMI_IPSEC_OFFLOAD_V1 IPsecV1;
    NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2 LsoV2;
    uint               Flags;
}

struct NDIS_TCP_CONNECTION_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    uint               Encapsulation;
    uint               _bitfield83;
    uint               TcpConnectionOffloadCapacity;
    uint               Flags;
}

struct NDIS_WMI_TCP_CONNECTION_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    uint               Encapsulation;
    uint               SupportIPv4;
    uint               SupportIPv6;
    uint               SupportIPv6ExtensionHeaders;
    uint               SupportSack;
    uint               TcpConnectionOffloadCapacity;
    uint               Flags;
}

struct NDIS_PORT_AUTHENTICATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
}

struct NDIS_WMI_METHOD_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint               PortNumber;
    NET_LUID_LH        NetLuid;
    ulong              RequestId;
    uint               Timeout;
    ubyte[4]           Padding;
}

struct NDIS_WMI_SET_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint               PortNumber;
    NET_LUID_LH        NetLuid;
    ulong              RequestId;
    uint               Timeout;
    ubyte[4]           Padding;
}

struct NDIS_WMI_EVENT_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint               IfIndex;
    NET_LUID_LH        NetLuid;
    ulong              RequestId;
    uint               PortNumber;
    uint               DeviceNameLength;
    uint               DeviceNameOffset;
    ubyte[4]           Padding;
}

struct NDIS_WMI_ENUM_ADAPTER
{
    NDIS_OBJECT_HEADER Header;
    uint               IfIndex;
    NET_LUID_LH        NetLuid;
    ushort             DeviceNameLength;
    byte[1]            DeviceName;
}

struct NDIS_WMI_OUTPUT_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    ubyte              SupportedRevision;
    uint               DataOffset;
}

struct NDIS_RECEIVE_SCALE_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    uint               CapabilitiesFlags;
    uint               NumberOfInterruptMessages;
    uint               NumberOfReceiveQueues;
}

struct NDIS_RECEIVE_SCALE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ushort             Flags;
    ushort             BaseCpuNumber;
    uint               HashInformation;
    ushort             IndirectionTableSize;
    uint               IndirectionTableOffset;
    ushort             HashSecretKeySize;
    uint               HashSecretKeyOffset;
}

struct NDIS_RECEIVE_HASH_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    uint               HashInformation;
    ushort             HashSecretKeySize;
    uint               HashSecretKeyOffset;
}

struct NDIS_PORT_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NET_IF_DIRECTION_TYPE Direction;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
    uint               Flags;
}

struct NDIS_PORT_CHARACTERISTICS
{
    NDIS_OBJECT_HEADER Header;
    uint               PortNumber;
    uint               Flags;
    NDIS_PORT_TYPE     Type;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NET_IF_DIRECTION_TYPE Direction;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
}

struct NDIS_PORT
{
    NDIS_PORT* Next;
    void*      NdisReserved;
    void*      MiniportReserved;
    void*      ProtocolReserved;
    NDIS_PORT_CHARACTERISTICS PortCharacteristics;
}

struct NDIS_PORT_ARRAY
{
    NDIS_OBJECT_HEADER Header;
    uint               NumberOfPorts;
    uint               OffsetFirstPort;
    uint               ElementSize;
    NDIS_PORT_CHARACTERISTICS[1] Ports;
}

struct NDIS_TIMESTAMP_CAPABILITY_FLAGS
{
    ubyte PtpV2OverUdpIPv4EventMsgReceiveHw;
    ubyte PtpV2OverUdpIPv4AllMsgReceiveHw;
    ubyte PtpV2OverUdpIPv4EventMsgTransmitHw;
    ubyte PtpV2OverUdpIPv4AllMsgTransmitHw;
    ubyte PtpV2OverUdpIPv6EventMsgReceiveHw;
    ubyte PtpV2OverUdpIPv6AllMsgReceiveHw;
    ubyte PtpV2OverUdpIPv6EventMsgTransmitHw;
    ubyte PtpV2OverUdpIPv6AllMsgTransmitHw;
    ubyte AllReceiveHw;
    ubyte AllTransmitHw;
    ubyte TaggedTransmitHw;
    ubyte AllReceiveSw;
    ubyte AllTransmitSw;
    ubyte TaggedTransmitSw;
}

struct NDIS_TIMESTAMP_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    ulong              HardwareClockFrequencyHz;
    ubyte              CrossTimestamp;
    ulong              Reserved1;
    ulong              Reserved2;
    NDIS_TIMESTAMP_CAPABILITY_FLAGS TimestampFlags;
}

struct NDIS_HARDWARE_CROSSTIMESTAMP
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    ulong              SystemTimestamp1;
    ulong              HardwareClockTimestamp;
    ulong              SystemTimestamp2;
}

struct DOT11_BSSID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    ubyte[6]           BSSIDs;
}

struct DOT11_RATE_SET
{
    uint       uRateSetLength;
    ubyte[126] ucRateSet;
}

struct DOT11_WFD_SESSION_INFO
{
    ushort     uSessionInfoLength;
    ubyte[144] ucSessionInfo;
}

struct DOT11_OFFLOAD_CAPABILITY
{
    uint uReserved;
    uint uFlags;
    uint uSupportedWEPAlgorithms;
    uint uNumOfReplayWindows;
    uint uMaxWEPKeyMappingLength;
    uint uSupportedAuthAlgorithms;
    uint uMaxAuthKeyMappingLength;
}

struct DOT11_CURRENT_OFFLOAD_CAPABILITY
{
    uint uReserved;
    uint uFlags;
}

struct DOT11_IV48_COUNTER
{
    uint   uIV32Counter;
    ushort usIV16Counter;
}

struct DOT11_WEP_OFFLOAD
{
    uint               uReserved;
    HANDLE             hOffloadContext;
    HANDLE             hOffload;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    uint               dwAlgorithm;
    ubyte              bRowIsOutbound;
    ubyte              bUseDefault;
    uint               uFlags;
    ubyte[6]           ucMacAddress;
    uint               uNumOfRWsOnPeer;
    uint               uNumOfRWsOnMe;
    DOT11_IV48_COUNTER[16] dot11IV48Counters;
    ushort[16]         usDot11RWBitMaps;
    ushort             usKeyLength;
    ubyte[1]           ucKey;
}

struct DOT11_WEP_UPLOAD
{
    uint               uReserved;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    HANDLE             hOffload;
    uint               uNumOfRWsUsed;
    DOT11_IV48_COUNTER[16] dot11IV48Counters;
    ushort[16]         usDot11RWBitMaps;
}

struct DOT11_DEFAULT_WEP_OFFLOAD
{
    uint                uReserved;
    HANDLE              hOffloadContext;
    HANDLE              hOffload;
    uint                dwIndex;
    DOT11_OFFLOAD_TYPE  dot11OffloadType;
    uint                dwAlgorithm;
    uint                uFlags;
    DOT11_KEY_DIRECTION dot11KeyDirection;
    ubyte[6]            ucMacAddress;
    uint                uNumOfRWsOnMe;
    DOT11_IV48_COUNTER[16] dot11IV48Counters;
    ushort[16]          usDot11RWBitMaps;
    ushort              usKeyLength;
    ubyte[1]            ucKey;
}

struct DOT11_DEFAULT_WEP_UPLOAD
{
    uint               uReserved;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    HANDLE             hOffload;
    uint               uNumOfRWsUsed;
    DOT11_IV48_COUNTER[16] dot11IV48Counters;
    ushort[16]         usDot11RWBitMaps;
}

struct DOT11_OPERATION_MODE_CAPABILITY
{
    uint uReserved;
    uint uMajorVersion;
    uint uMinorVersion;
    uint uNumOfTXBuffers;
    uint uNumOfRXBuffers;
    uint uOpModeCapability;
}

struct DOT11_CURRENT_OPERATION_MODE
{
    uint uReserved;
    uint uCurrentOpMode;
}

struct DOT11_SCAN_REQUEST
{
    DOT11_BSS_TYPE  dot11BSSType;
    ubyte[6]        dot11BSSID;
    DOT11_SSID      dot11SSID;
    DOT11_SCAN_TYPE dot11ScanType;
    ubyte           bRestrictedScan;
    ubyte           bUseRequestIE;
    uint            uRequestIDsOffset;
    uint            uNumOfRequestIDs;
    uint            uPhyTypesOffset;
    uint            uNumOfPhyTypes;
    uint            uIEsOffset;
    uint            uIEsLength;
    ubyte[1]        ucBuffer;
}

struct DOT11_PHY_TYPE_INFO
{
    DOT11_PHY_TYPE      dot11PhyType;
    ubyte               bUseParameters;
    uint                uProbeDelay;
    uint                uMinChannelTime;
    uint                uMaxChannelTime;
    CH_DESCRIPTION_TYPE ChDescriptionType;
    uint                uChannelListSize;
    ubyte[1]            ucChannelListBuffer;
}

struct DOT11_SCAN_REQUEST_V2
{
    DOT11_BSS_TYPE  dot11BSSType;
    ubyte[6]        dot11BSSID;
    DOT11_SCAN_TYPE dot11ScanType;
    ubyte           bRestrictedScan;
    uint            udot11SSIDsOffset;
    uint            uNumOfdot11SSIDs;
    ubyte           bUseRequestIE;
    uint            uRequestIDsOffset;
    uint            uNumOfRequestIDs;
    uint            uPhyTypeInfosOffset;
    uint            uNumOfPhyTypeInfos;
    uint            uIEsOffset;
    uint            uIEsLength;
    ubyte[1]        ucBuffer;
}

struct DOT11_PHY_TYPE_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    DOT11_PHY_TYPE[1]  dot11PhyType;
}

struct DOT11_BSS_DESCRIPTION
{
    uint           uReserved;
    ubyte[6]       dot11BSSID;
    DOT11_BSS_TYPE dot11BSSType;
    ushort         usBeaconPeriod;
    ulong          ullTimestamp;
    ushort         usCapabilityInformation;
    uint           uBufferLength;
    ubyte[1]       ucBuffer;
}

struct DOT11_JOIN_REQUEST
{
    uint           uJoinFailureTimeout;
    DOT11_RATE_SET OperationalRateSet;
    uint           uChCenterFrequency;
    DOT11_BSS_DESCRIPTION dot11BSSDescription;
}

struct DOT11_START_REQUEST
{
    uint           uStartFailureTimeout;
    DOT11_RATE_SET OperationalRateSet;
    uint           uChCenterFrequency;
    DOT11_BSS_DESCRIPTION dot11BSSDescription;
}

struct DOT11_UPDATE_IE
{
    DOT11_UPDATE_IE_OP dot11UpdateIEOp;
    uint               uBufferLength;
    ubyte[1]           ucBuffer;
}

struct DOT11_RESET_REQUEST
{
    DOT11_RESET_TYPE dot11ResetType;
    ubyte[6]         dot11MacAddress;
    ubyte            bSetDefaultMIB;
}

struct DOT11_OPTIONAL_CAPABILITY
{
    uint  uReserved;
    ubyte bDot11PCF;
    ubyte bDot11PCFMPDUTransferToPC;
    ubyte bStrictlyOrderedServiceClass;
}

struct DOT11_CURRENT_OPTIONAL_CAPABILITY
{
    uint  uReserved;
    ubyte bDot11CFPollable;
    ubyte bDot11PCF;
    ubyte bDot11PCFMPDUTransferToPC;
    ubyte bStrictlyOrderedServiceClass;
}

struct DOT11_POWER_MGMT_MODE
{
    DOT11_POWER_MODE dot11PowerMode;
    uint             uPowerSaveLevel;
    ushort           usListenInterval;
    ushort           usAID;
    ubyte            bReceiveDTIMs;
}

struct DOT11_COUNTERS_ENTRY
{
    uint uTransmittedFragmentCount;
    uint uMulticastTransmittedFrameCount;
    uint uFailedCount;
    uint uRetryCount;
    uint uMultipleRetryCount;
    uint uFrameDuplicateCount;
    uint uRTSSuccessCount;
    uint uRTSFailureCount;
    uint uACKFailureCount;
    uint uReceivedFragmentCount;
    uint uMulticastReceivedFrameCount;
    uint uFCSErrorCount;
    uint uTransmittedFrameCount;
}

struct DOT11_SUPPORTED_PHY_TYPES
{
    uint              uNumOfEntries;
    uint              uTotalNumOfEntries;
    DOT11_PHY_TYPE[1] dot11PHYType;
}

struct DOT11_SUPPORTED_POWER_LEVELS
{
    uint    uNumOfSupportedPowerLevels;
    uint[8] uTxPowerLevelValues;
}

struct DOT11_REG_DOMAIN_VALUE
{
    uint uRegDomainsSupportIndex;
    uint uRegDomainsSupportValue;
}

struct DOT11_REG_DOMAINS_SUPPORT_VALUE
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_REG_DOMAIN_VALUE[1] dot11RegDomainValue;
}

struct DOT11_SUPPORTED_ANTENNA
{
    uint  uAntennaListIndex;
    ubyte bSupportedAntenna;
}

struct DOT11_SUPPORTED_ANTENNA_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_SUPPORTED_ANTENNA[1] dot11SupportedAntenna;
}

struct DOT11_DIVERSITY_SELECTION_RX
{
    uint  uAntennaListIndex;
    ubyte bDiversitySelectionRX;
}

struct DOT11_DIVERSITY_SELECTION_RX_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_DIVERSITY_SELECTION_RX[1] dot11DiversitySelectionRx;
}

struct DOT11_SUPPORTED_DATA_RATES_VALUE
{
    ubyte[8] ucSupportedTxDataRatesValue;
    ubyte[8] ucSupportedRxDataRatesValue;
}

struct DOT11_SUPPORTED_DATA_RATES_VALUE_V2
{
    ubyte[255] ucSupportedTxDataRatesValue;
    ubyte[255] ucSupportedRxDataRatesValue;
}

struct DOT11_MULTI_DOMAIN_CAPABILITY_ENTRY
{
    uint uMultiDomainCapabilityIndex;
    uint uFirstChannelNumber;
    uint uNumberOfChannels;
    int  lMaximumTransmitPowerLevel;
}

struct DOT11_MD_CAPABILITY_ENTRY_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_MULTI_DOMAIN_CAPABILITY_ENTRY[1] dot11MDCapabilityEntry;
}

struct DOT11_HOPPING_PATTERN_ENTRY
{
    uint uHoppingPatternIndex;
    uint uRandomTableFieldNumber;
}

struct DOT11_HOPPING_PATTERN_ENTRY_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_HOPPING_PATTERN_ENTRY[1] dot11HoppingPatternEntry;
}

struct DOT11_WPA_TSC
{
    uint               uReserved;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    HANDLE             hOffload;
    DOT11_IV48_COUNTER dot11IV48Counter;
}

struct DOT11_RSSI_RANGE
{
    DOT11_PHY_TYPE dot11PhyType;
    uint           uRSSIMin;
    uint           uRSSIMax;
}

struct DOT11_NIC_SPECIFIC_EXTENSION
{
    uint     uBufferLength;
    uint     uTotalBufferLength;
    ubyte[1] ucBuffer;
}

struct DOT11_AP_JOIN_REQUEST
{
    uint           uJoinFailureTimeout;
    DOT11_RATE_SET OperationalRateSet;
    uint           uChCenterFrequency;
    DOT11_BSS_DESCRIPTION dot11BSSDescription;
}

struct DOT11_RECV_SENSITIVITY
{
    ubyte ucDataRate;
    int   lRSSIMin;
    int   lRSSIMax;
}

struct DOT11_RECV_SENSITIVITY_LIST
{
    union
    {
        DOT11_PHY_TYPE dot11PhyType;
        uint           uPhyId;
    }
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_RECV_SENSITIVITY[1] dot11RecvSensitivity;
}

struct DOT11_WME_AC_PARAMETERS
{
    ubyte  ucAccessCategoryIndex;
    ubyte  ucAIFSN;
    ubyte  ucECWmin;
    ubyte  ucECWmax;
    ushort usTXOPLimit;
}

struct _DOT11_WME_AC_PARAMTERS_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_WME_AC_PARAMETERS[1] dot11WMEACParameters;
}

struct DOT11_WME_UPDATE_IE
{
    uint     uParamElemMinBeaconIntervals;
    uint     uWMEInfoElemOffset;
    uint     uWMEInfoElemLength;
    uint     uWMEParamElemOffset;
    uint     uWMEParamElemLength;
    ubyte[1] ucBuffer;
}

struct DOT11_QOS_TX_DURATION
{
    uint uNominalMSDUSize;
    uint uMinPHYRate;
    uint uDuration;
}

struct DOT11_QOS_TX_MEDIUM_TIME
{
    ubyte[6] dot11PeerAddress;
    ubyte    ucQoSPriority;
    uint     uMediumTimeAdmited;
}

struct DOT11_SUPPORTED_OFDM_FREQUENCY
{
    uint uCenterFrequency;
}

struct DOT11_SUPPORTED_OFDM_FREQUENCY_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_SUPPORTED_OFDM_FREQUENCY[1] dot11SupportedOFDMFrequency;
}

struct DOT11_SUPPORTED_DSSS_CHANNEL
{
    uint uChannel;
}

struct DOT11_SUPPORTED_DSSS_CHANNEL_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_SUPPORTED_DSSS_CHANNEL[1] dot11SupportedDSSSChannel;
}

struct DOT11_BYTE_ARRAY
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfBytes;
    uint               uTotalNumOfBytes;
    ubyte[1]           ucBuffer;
}

union DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO
{
    uint uChCenterFrequency;
    struct FHSS
    {
        uint uHopPattern;
        uint uHopSet;
        uint uDwellTime;
    }
}

struct DOT11_BSS_ENTRY
{
    uint           uPhyId;
    DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO PhySpecificInfo;
    ubyte[6]       dot11BSSID;
    DOT11_BSS_TYPE dot11BSSType;
    int            lRSSI;
    uint           uLinkQuality;
    ubyte          bInRegDomain;
    ushort         usBeaconPeriod;
    ulong          ullTimestamp;
    ulong          ullHostTimestamp;
    ushort         usCapabilityInformation;
    uint           uBufferLength;
    ubyte[1]       ucBuffer;
}

struct DOT11_SSID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    DOT11_SSID[1]      SSIDs;
}

struct DOT11_MAC_ADDRESS_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    ubyte[6]           MacAddrs;
}

struct DOT11_PMKID_ENTRY
{
    ubyte[6]  BSSID;
    ubyte[16] PMKID;
    uint      uFlags;
}

struct DOT11_PMKID_LIST
{
    NDIS_OBJECT_HEADER   Header;
    uint                 uNumOfEntries;
    uint                 uTotalNumOfEntries;
    DOT11_PMKID_ENTRY[1] PMKIDs;
}

struct DOT11_PHY_FRAME_STATISTICS
{
    ulong ullTransmittedFrameCount;
    ulong ullMulticastTransmittedFrameCount;
    ulong ullFailedCount;
    ulong ullRetryCount;
    ulong ullMultipleRetryCount;
    ulong ullMaxTXLifetimeExceededCount;
    ulong ullTransmittedFragmentCount;
    ulong ullRTSSuccessCount;
    ulong ullRTSFailureCount;
    ulong ullACKFailureCount;
    ulong ullReceivedFrameCount;
    ulong ullMulticastReceivedFrameCount;
    ulong ullPromiscuousReceivedFrameCount;
    ulong ullMaxRXLifetimeExceededCount;
    ulong ullFrameDuplicateCount;
    ulong ullReceivedFragmentCount;
    ulong ullPromiscuousReceivedFragmentCount;
    ulong ullFCSErrorCount;
}

struct DOT11_MAC_FRAME_STATISTICS
{
    ulong ullTransmittedFrameCount;
    ulong ullReceivedFrameCount;
    ulong ullTransmittedFailureFrameCount;
    ulong ullReceivedFailureFrameCount;
    ulong ullWEPExcludedCount;
    ulong ullTKIPLocalMICFailures;
    ulong ullTKIPReplays;
    ulong ullTKIPICVErrorCount;
    ulong ullCCMPReplays;
    ulong ullCCMPDecryptErrors;
    ulong ullWEPUndecryptableCount;
    ulong ullWEPICVErrorCount;
    ulong ullDecryptSuccessCount;
    ulong ullDecryptFailureCount;
}

struct DOT11_STATISTICS
{
    NDIS_OBJECT_HEADER Header;
    ulong              ullFourWayHandshakeFailures;
    ulong              ullTKIPCounterMeasuresInvoked;
    ulong              ullReserved;
    DOT11_MAC_FRAME_STATISTICS MacUcastCounters;
    DOT11_MAC_FRAME_STATISTICS MacMcastCounters;
    DOT11_PHY_FRAME_STATISTICS[1] PhyCounters;
}

struct DOT11_PRIVACY_EXEMPTION
{
    ushort usEtherType;
    ushort usExemptionActionType;
    ushort usExemptionPacketType;
}

struct DOT11_PRIVACY_EXEMPTION_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    DOT11_PRIVACY_EXEMPTION[1] PrivacyExemptionEntries;
}

struct DOT11_AUTH_ALGORITHM_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    DOT11_AUTH_ALGORITHM[1] AlgorithmIds;
}

struct DOT11_AUTH_CIPHER_PAIR_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    DOT11_AUTH_CIPHER_PAIR[1] AuthCipherPairs;
}

struct DOT11_CIPHER_ALGORITHM_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    DOT11_CIPHER_ALGORITHM[1] AlgorithmIds;
}

struct DOT11_CIPHER_DEFAULT_KEY_VALUE
{
    NDIS_OBJECT_HEADER Header;
    uint               uKeyIndex;
    DOT11_CIPHER_ALGORITHM AlgorithmId;
    ubyte[6]           MacAddr;
    ubyte              bDelete;
    ubyte              bStatic;
    ushort             usKeyLength;
    ubyte[1]           ucKey;
}

struct DOT11_KEY_ALGO_TKIP_MIC
{
    ubyte[6] ucIV48Counter;
    uint     ulTKIPKeyLength;
    uint     ulMICKeyLength;
    ubyte[1] ucTKIPMICKeys;
}

struct DOT11_KEY_ALGO_CCMP
{
    ubyte[6] ucIV48Counter;
    uint     ulCCMPKeyLength;
    ubyte[1] ucCCMPKey;
}

struct DOT11_KEY_ALGO_GCMP
{
    ubyte[6] ucIV48Counter;
    uint     ulGCMPKeyLength;
    ubyte[1] ucGCMPKey;
}

struct DOT11_KEY_ALGO_GCMP_256
{
    ubyte[6] ucIV48Counter;
    uint     ulGCMP256KeyLength;
    ubyte[1] ucGCMP256Key;
}

struct DOT11_KEY_ALGO_BIP
{
    ubyte[6] ucIPN;
    uint     ulBIPKeyLength;
    ubyte[1] ucBIPKey;
}

struct DOT11_KEY_ALGO_BIP_GMAC_256
{
    ubyte[6] ucIPN;
    uint     ulBIPGmac256KeyLength;
    ubyte[1] ucBIPGmac256Key;
}

struct DOT11_CIPHER_KEY_MAPPING_KEY_VALUE
{
    ubyte[6]        PeerMacAddr;
    DOT11_CIPHER_ALGORITHM AlgorithmId;
    DOT11_DIRECTION Direction;
    ubyte           bDelete;
    ubyte           bStatic;
    ushort          usKeyLength;
    ubyte[1]        ucKey;
}

struct DOT11_ASSOCIATION_INFO_EX
{
    ubyte[6]         PeerMacAddress;
    ubyte[6]         BSSID;
    ushort           usCapabilityInformation;
    ushort           usListenInterval;
    ubyte[255]       ucPeerSupportedRates;
    ushort           usAssociationID;
    DOT11_ASSOCIATION_STATE dot11AssociationState;
    DOT11_POWER_MODE dot11PowerMode;
    LARGE_INTEGER    liAssociationUpTime;
    ulong            ullNumOfTxPacketSuccesses;
    ulong            ullNumOfTxPacketFailures;
    ulong            ullNumOfRxPacketSuccesses;
    ulong            ullNumOfRxPacketFailures;
}

struct DOT11_ASSOCIATION_INFO_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    DOT11_ASSOCIATION_INFO_EX[1] dot11AssocInfo;
}

struct DOT11_PHY_ID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    uint[1]            dot11PhyId;
}

struct DOT11_EXTSTA_CAPABILITY
{
    NDIS_OBJECT_HEADER Header;
    uint               uScanSSIDListSize;
    uint               uDesiredBSSIDListSize;
    uint               uDesiredSSIDListSize;
    uint               uExcludedMacAddressListSize;
    uint               uPrivacyExemptionListSize;
    uint               uKeyMappingTableSize;
    uint               uDefaultKeyTableSize;
    uint               uWEPKeyValueMaxLength;
    uint               uPMKIDCacheSize;
    uint               uMaxNumPerSTADefaultKeyTables;
}

struct DOT11_DATA_RATE_MAPPING_ENTRY
{
    ubyte  ucDataRateIndex;
    ubyte  ucDataRateFlag;
    ushort usDataRateValue;
}

struct DOT11_DATA_RATE_MAPPING_TABLE
{
    NDIS_OBJECT_HEADER Header;
    uint               uDataRateMappingLength;
    DOT11_DATA_RATE_MAPPING_ENTRY[126] DataRateMappingEntries;
}

struct DOT11_COUNTRY_OR_REGION_STRING_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    ubyte[3]           CountryOrRegionStrings;
}

struct DOT11_PORT_STATE_NOTIFICATION
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMac;
    ubyte              bOpen;
}

struct DOT11_IBSS_PARAMS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              bJoinOnly;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_QOS_PARAMS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              ucEnabledQoSProtocolFlags;
}

struct DOT11_ASSOCIATION_PARAMS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           BSSID;
    uint               uAssocRequestIEsOffset;
    uint               uAssocRequestIEsLength;
}

struct DOT11_FRAGMENT_DESCRIPTOR
{
    uint uOffset;
    uint uLength;
}

struct DOT11_PER_MSDU_COUNTERS
{
    uint uTransmittedFragmentCount;
    uint uRetryCount;
    uint uRTSSuccessCount;
    uint uRTSFailureCount;
    uint uACKFailureCount;
}

struct DOT11_HRDSSS_PHY_ATTRIBUTES
{
    ubyte bShortPreambleOptionImplemented;
    ubyte bPBCCOptionImplemented;
    ubyte bChannelAgilityPresent;
    uint  uHRCCAModeSupported;
}

struct DOT11_OFDM_PHY_ATTRIBUTES
{
    uint uFrequencyBandsSupported;
}

struct DOT11_ERP_PHY_ATTRIBUTES
{
    DOT11_HRDSSS_PHY_ATTRIBUTES HRDSSSAttributes;
    ubyte bERPPBCCOptionImplemented;
    ubyte bDSSSOFDMOptionImplemented;
    ubyte bShortSlotTimeOptionImplemented;
}

struct DOT11_PHY_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    DOT11_PHY_TYPE     PhyType;
    ubyte              bHardwarePhyState;
    ubyte              bSoftwarePhyState;
    ubyte              bCFPollable;
    uint               uMPDUMaxLength;
    DOT11_TEMP_TYPE    TempType;
    DOT11_DIVERSITY_SUPPORT DiversitySupport;
    union PhySpecificAttributes
    {
        DOT11_HRDSSS_PHY_ATTRIBUTES HRDSSSAttributes;
        DOT11_OFDM_PHY_ATTRIBUTES OFDMAttributes;
        DOT11_ERP_PHY_ATTRIBUTES ERPAttributes;
    }
    uint               uNumberSupportedPowerLevels;
    uint[8]            TxPowerLevels;
    uint               uNumDataRateMappingEntries;
    DOT11_DATA_RATE_MAPPING_ENTRY[126] DataRateMappingEntries;
    DOT11_SUPPORTED_DATA_RATES_VALUE_V2 SupportedDataRatesValue;
}

struct DOT11_EXTSTA_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint               uScanSSIDListSize;
    uint               uDesiredBSSIDListSize;
    uint               uDesiredSSIDListSize;
    uint               uExcludedMacAddressListSize;
    uint               uPrivacyExemptionListSize;
    uint               uKeyMappingTableSize;
    uint               uDefaultKeyTableSize;
    uint               uWEPKeyValueMaxLength;
    uint               uPMKIDCacheSize;
    uint               uMaxNumPerSTADefaultKeyTables;
    ubyte              bStrictlyOrderedServiceClassImplemented;
    ubyte              ucSupportedQoSProtocolFlags;
    ubyte              bSafeModeImplemented;
    uint               uNumSupportedCountryOrRegionStrings;
    ubyte*             pSupportedCountryOrRegionStrings;
    uint               uInfraNumSupportedUcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedUcastAlgoPairs;
    uint               uInfraNumSupportedMcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedMcastAlgoPairs;
    uint               uAdhocNumSupportedUcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pAdhocSupportedUcastAlgoPairs;
    uint               uAdhocNumSupportedMcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pAdhocSupportedMcastAlgoPairs;
    ubyte              bAutoPowerSaveMode;
    uint               uMaxNetworkOffloadListSize;
    ubyte              bMFPCapable;
    uint               uInfraNumSupportedMcastMgmtAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedMcastMgmtAlgoPairs;
    ubyte              bNeighborReportSupported;
    ubyte              bAPChannelReportSupported;
    ubyte              bActionFramesSupported;
    ubyte              bANQPQueryOffloadSupported;
    ubyte              bHESSIDConnectionSupported;
}

struct DOT11_RECV_EXTENSION_INFO
{
    uint               uVersion;
    void*              pvReserved;
    DOT11_PHY_TYPE     dot11PhyType;
    uint               uChCenterFrequency;
    int                lRSSI;
    int                lRSSIMin;
    int                lRSSIMax;
    uint               uRSSI;
    ubyte              ucPriority;
    ubyte              ucDataRate;
    ubyte[6]           ucPeerMacAddress;
    uint               dwExtendedStatus;
    HANDLE             hWEPOffloadContext;
    HANDLE             hAuthOffloadContext;
    ushort             usWEPAppliedMask;
    ushort             usWPAMSDUPriority;
    DOT11_IV48_COUNTER dot11LowestIV48Counter;
    ushort             usDot11LeftRWBitMap;
    DOT11_IV48_COUNTER dot11HighestIV48Counter;
    ushort             usDot11RightRWBitMap;
    ushort             usNumberOfMPDUsReceived;
    ushort             usNumberOfFragments;
    void[1]*           pNdisPackets;
}

struct DOT11_RECV_EXTENSION_INFO_V2
{
    uint               uVersion;
    void*              pvReserved;
    DOT11_PHY_TYPE     dot11PhyType;
    uint               uChCenterFrequency;
    int                lRSSI;
    uint               uRSSI;
    ubyte              ucPriority;
    ubyte              ucDataRate;
    ubyte[6]           ucPeerMacAddress;
    uint               dwExtendedStatus;
    HANDLE             hWEPOffloadContext;
    HANDLE             hAuthOffloadContext;
    ushort             usWEPAppliedMask;
    ushort             usWPAMSDUPriority;
    DOT11_IV48_COUNTER dot11LowestIV48Counter;
    ushort             usDot11LeftRWBitMap;
    DOT11_IV48_COUNTER dot11HighestIV48Counter;
    ushort             usDot11RightRWBitMap;
    ushort             usNumberOfMPDUsReceived;
    ushort             usNumberOfFragments;
    void[1]*           pNdisPackets;
}

struct DOT11_STATUS_INDICATION
{
    uint uStatusType;
    int  ndisStatus;
}

struct DOT11_MPDU_MAX_LENGTH_INDICATION
{
    NDIS_OBJECT_HEADER Header;
    uint               uPhyId;
    uint               uMPDUMaxLength;
}

struct DOT11_ASSOCIATION_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           MacAddr;
    DOT11_SSID         SSID;
    uint               uIHVDataOffset;
    uint               uIHVDataSize;
}

struct DOT11_ENCAP_ENTRY
{
    ushort usEtherType;
    ushort usEncapType;
}

struct DOT11_ASSOCIATION_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER   Header;
    ubyte[6]             MacAddr;
    uint                 uStatus;
    ubyte                bReAssocReq;
    ubyte                bReAssocResp;
    uint                 uAssocReqOffset;
    uint                 uAssocReqSize;
    uint                 uAssocRespOffset;
    uint                 uAssocRespSize;
    uint                 uBeaconOffset;
    uint                 uBeaconSize;
    uint                 uIHVDataOffset;
    uint                 uIHVDataSize;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CIPHER_ALGORITHM UnicastCipher;
    DOT11_CIPHER_ALGORITHM MulticastCipher;
    uint                 uActivePhyListOffset;
    uint                 uActivePhyListSize;
    ubyte                bFourAddressSupported;
    ubyte                bPortAuthorized;
    ubyte                ucActiveQoSProtocol;
    DOT11_DS_INFO        DSInfo;
    uint                 uEncapTableOffset;
    uint                 uEncapTableSize;
    DOT11_CIPHER_ALGORITHM MulticastMgmtCipher;
    uint                 uAssocComebackTime;
}

struct DOT11_CONNECTION_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_BSS_TYPE     BSSType;
    ubyte[6]           AdhocBSSID;
    DOT11_SSID         AdhocSSID;
}

struct DOT11_CONNECTION_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uStatus;
}

struct DOT11_ROAMING_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           AdhocBSSID;
    DOT11_SSID         AdhocSSID;
    uint               uRoamingReason;
}

struct DOT11_ROAMING_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uStatus;
}

struct DOT11_DISASSOCIATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           MacAddr;
    uint               uReason;
    uint               uIHVDataOffset;
    uint               uIHVDataSize;
}

struct DOT11_TKIPMIC_FAILURE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              bDefaultKeyFailure;
    uint               uKeyIndex;
    ubyte[6]           PeerMac;
}

struct DOT11_PMKID_CANDIDATE_LIST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uCandidateListSize;
    uint               uCandidateListOffset;
}

struct DOT11_BSSID_CANDIDATE
{
    ubyte[6] BSSID;
    uint     uFlags;
}

struct DOT11_PHY_STATE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uPhyId;
    ubyte              bHardwarePhyState;
    ubyte              bSoftwarePhyState;
}

struct DOT11_LINK_QUALITY_ENTRY
{
    ubyte[6] PeerMacAddr;
    ubyte    ucLinkQuality;
}

struct DOT11_LINK_QUALITY_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uLinkQualityListSize;
    uint               uLinkQualityListOffset;
}

struct DOT11_EXTSTA_SEND_CONTEXT
{
    NDIS_OBJECT_HEADER Header;
    ushort             usExemptionActionType;
    uint               uPhyId;
    uint               uDelayedSleepValue;
    void*              pvMediaSpecificInfo;
    uint               uSendFlags;
}

struct DOT11_EXTSTA_RECV_CONTEXT
{
    NDIS_OBJECT_HEADER Header;
    uint               uReceiveFlags;
    uint               uPhyId;
    uint               uChCenterFrequency;
    ushort             usNumberOfMPDUsReceived;
    int                lRSSI;
    ubyte              ucDataRate;
    uint               uSizeMediaSpecificInfo;
    void*              pvMediaSpecificInfo;
    ulong              ullTimestamp;
}

struct DOT11_EXTAP_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint               uScanSSIDListSize;
    uint               uDesiredSSIDListSize;
    uint               uPrivacyExemptionListSize;
    uint               uAssociationTableSize;
    uint               uDefaultKeyTableSize;
    uint               uWEPKeyValueMaxLength;
    ubyte              bStrictlyOrderedServiceClassImplemented;
    uint               uNumSupportedCountryOrRegionStrings;
    ubyte*             pSupportedCountryOrRegionStrings;
    uint               uInfraNumSupportedUcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedUcastAlgoPairs;
    uint               uInfraNumSupportedMcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedMcastAlgoPairs;
}

struct DOT11_INCOMING_ASSOC_STARTED_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMacAddr;
}

struct DOT11_INCOMING_ASSOC_REQUEST_RECEIVED_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMacAddr;
    ubyte              bReAssocReq;
    uint               uAssocReqOffset;
    uint               uAssocReqSize;
}

struct DOT11_INCOMING_ASSOC_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER   Header;
    ubyte[6]             PeerMacAddr;
    uint                 uStatus;
    ubyte                ucErrorSource;
    ubyte                bReAssocReq;
    ubyte                bReAssocResp;
    uint                 uAssocReqOffset;
    uint                 uAssocReqSize;
    uint                 uAssocRespOffset;
    uint                 uAssocRespSize;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CIPHER_ALGORITHM UnicastCipher;
    DOT11_CIPHER_ALGORITHM MulticastCipher;
    uint                 uActivePhyListOffset;
    uint                 uActivePhyListSize;
    uint                 uBeaconOffset;
    uint                 uBeaconSize;
}

struct DOT11_STOP_AP_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               ulReason;
}

struct DOT11_PHY_FREQUENCY_ADOPTED_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               ulPhyId;
    union
    {
        uint ulChannel;
        uint ulFrequency;
    }
}

struct DOT11_CAN_SUSTAIN_AP_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               ulReason;
}

struct DOT11_AVAILABLE_CHANNEL_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    uint[1]            uChannelNumber;
}

struct DOT11_AVAILABLE_FREQUENCY_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    uint[1]            uFrequencyValue;
}

struct DOT11_DISASSOCIATE_PEER_REQUEST
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMacAddr;
    ushort             usReason;
}

struct DOT11_INCOMING_ASSOC_DECISION
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMacAddr;
    ubyte              bAccept;
    ushort             usReasonCode;
    uint               uAssocResponseIEsOffset;
    uint               uAssocResponseIEsLength;
}

struct DOT11_INCOMING_ASSOC_DECISION_V2
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMacAddr;
    ubyte              bAccept;
    ushort             usReasonCode;
    uint               uAssocResponseIEsOffset;
    uint               uAssocResponseIEsLength;
    ubyte              WFDStatus;
}

struct DOT11_ADDITIONAL_IE
{
    NDIS_OBJECT_HEADER Header;
    uint               uBeaconIEsOffset;
    uint               uBeaconIEsLength;
    uint               uResponseIEsOffset;
    uint               uResponseIEsLength;
}

struct DOT11_PEER_STATISTICS
{
    ulong ullDecryptSuccessCount;
    ulong ullDecryptFailureCount;
    ulong ullTxPacketSuccessCount;
    ulong ullTxPacketFailureCount;
    ulong ullRxPacketSuccessCount;
    ulong ullRxPacketFailureCount;
}

struct DOT11_PEER_INFO
{
    ubyte[6]             MacAddress;
    ushort               usCapabilityInformation;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CIPHER_ALGORITHM UnicastCipherAlgo;
    DOT11_CIPHER_ALGORITHM MulticastCipherAlgo;
    ubyte                bWpsEnabled;
    ushort               usListenInterval;
    ubyte[255]           ucSupportedRates;
    ushort               usAssociationID;
    DOT11_ASSOCIATION_STATE AssociationState;
    DOT11_POWER_MODE     PowerMode;
    LARGE_INTEGER        liAssociationUpTime;
    DOT11_PEER_STATISTICS Statistics;
}

struct DOT11_PEER_INFO_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    DOT11_PEER_INFO[1] PeerInfo;
}

struct DOT11_VWIFI_COMBINATION
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumInfrastructure;
    uint               uNumAdhoc;
    uint               uNumSoftAP;
}

struct DOT11_VWIFI_COMBINATION_V2
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumInfrastructure;
    uint               uNumAdhoc;
    uint               uNumSoftAP;
    uint               uNumVirtualStation;
}

struct DOT11_VWIFI_COMBINATION_V3
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumInfrastructure;
    uint               uNumAdhoc;
    uint               uNumSoftAP;
    uint               uNumVirtualStation;
    uint               uNumWFDGroup;
}

struct DOT11_VWIFI_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint               uTotalNumOfEntries;
    DOT11_VWIFI_COMBINATION[1] Combinations;
}

struct DOT11_MAC_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uOpmodeMask;
}

struct DOT11_MAC_INFO
{
    uint     uReserved;
    uint     uNdisPortNumber;
    ubyte[6] MacAddr;
}

struct DOT11_WFD_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumConcurrentGORole;
    uint               uNumConcurrentClientRole;
    uint               WPSVersionsSupported;
    ubyte              bServiceDiscoverySupported;
    ubyte              bClientDiscoverabilitySupported;
    ubyte              bInfrastructureManagementSupported;
    uint               uMaxSecondaryDeviceTypeListSize;
    ubyte[6]           DeviceAddress;
    uint               uInterfaceAddressListCount;
    ubyte*             pInterfaceAddressList;
    uint               uNumSupportedCountryOrRegionStrings;
    ubyte*             pSupportedCountryOrRegionStrings;
    uint               uDiscoveryFilterListSize;
    uint               uGORoleClientTableSize;
}

struct DOT11_WFD_DEVICE_TYPE
{
    ushort   CategoryID;
    ushort   SubCategoryID;
    ubyte[4] OUI;
}

struct DOT11_WPS_DEVICE_NAME
{
    uint      uDeviceNameLength;
    ubyte[32] ucDeviceName;
}

struct DOT11_WFD_CONFIGURATION_TIMEOUT
{
    ubyte GOTimeout;
    ubyte ClientTimeout;
}

struct DOT11_WFD_GROUP_ID
{
    ubyte[6]   DeviceAddress;
    DOT11_SSID SSID;
}

struct DOT11_WFD_GO_INTENT
{
    ubyte _bitfield84;
}

struct DOT11_WFD_CHANNEL
{
    ubyte[3] CountryRegionString;
    ubyte    OperatingClass;
    ubyte    ChannelNumber;
}

struct WFDSVC_CONNECTION_CAPABILITY
{
    ubyte bNew;
    ubyte bClient;
    ubyte bGO;
}

struct DOT11_WFD_SERVICE_HASH_LIST
{
    ushort   ServiceHashCount;
    ubyte[6] ServiceHash;
}

struct DOT11_WFD_ADVERTISEMENT_ID
{
    uint     AdvertisementID;
    ubyte[6] ServiceAddress;
}

struct DOT11_WFD_SESSION_ID
{
    uint     SessionID;
    ubyte[6] SessionAddress;
}

struct DOT11_WFD_ADVERTISED_SERVICE_DESCRIPTOR
{
    uint       AdvertisementID;
    ushort     ConfigMethods;
    ubyte      ServiceNameLength;
    ubyte[255] ServiceName;
}

struct DOT11_WFD_ADVERTISED_SERVICE_LIST
{
    ushort ServiceCount;
    DOT11_WFD_ADVERTISED_SERVICE_DESCRIPTOR[1] AdvertisedService;
}

struct DOT11_WFD_DISCOVER_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    int                Status;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    uint               uListOffset;
    uint               uListLength;
}

struct DOT11_GO_NEGOTIATION_REQUEST_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_GO_NEGOTIATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    void*              RequestContext;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_GO_NEGOTIATION_RESPONSE_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_GO_NEGOTIATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    void*              ResponseContext;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_GO_NEGOTIATION_CONFIRMATION_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_GO_NEGOTIATION_CONFIRMATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_INVITATION_REQUEST_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte[6]           ReceiverAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_INVITATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           TransmitterDeviceAddress;
    ubyte[6]           BSSID;
    ubyte              DialogToken;
    void*              RequestContext;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_INVITATION_RESPONSE_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           ReceiverDeviceAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_INVITATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           TransmitterDeviceAddress;
    ubyte[6]           BSSID;
    ubyte              DialogToken;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_PROVISION_DISCOVERY_REQUEST_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte[6]           ReceiverAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_PROVISION_DISCOVERY_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           TransmitterDeviceAddress;
    ubyte[6]           BSSID;
    ubyte              DialogToken;
    void*              RequestContext;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_PROVISION_DISCOVERY_RESPONSE_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           ReceiverDeviceAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_PROVISION_DISCOVERY_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           TransmitterDeviceAddress;
    ubyte[6]           BSSID;
    ubyte              DialogToken;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_ANQP_QUERY_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_ANQP_QUERY_RESULT Status;
    HANDLE             hContext;
    uint               uResponseLength;
}

struct DOT11_WFD_DEVICE_CAPABILITY_CONFIG
{
    NDIS_OBJECT_HEADER Header;
    ubyte              bServiceDiscoveryEnabled;
    ubyte              bClientDiscoverabilityEnabled;
    ubyte              bConcurrentOperationSupported;
    ubyte              bInfrastructureManagementEnabled;
    ubyte              bDeviceLimitReached;
    ubyte              bInvitationProcedureEnabled;
    uint               WPSVersionsEnabled;
}

struct DOT11_WFD_GROUP_OWNER_CAPABILITY_CONFIG
{
    NDIS_OBJECT_HEADER Header;
    ubyte              bPersistentGroupEnabled;
    ubyte              bIntraBSSDistributionSupported;
    ubyte              bCrossConnectionSupported;
    ubyte              bPersistentReconnectSupported;
    ubyte              bGroupFormationEnabled;
    uint               uMaximumGroupLimit;
}

struct DOT11_WFD_GROUP_OWNER_CAPABILITY_CONFIG_V2
{
    NDIS_OBJECT_HEADER Header;
    ubyte              bPersistentGroupEnabled;
    ubyte              bIntraBSSDistributionSupported;
    ubyte              bCrossConnectionSupported;
    ubyte              bPersistentReconnectSupported;
    ubyte              bGroupFormationEnabled;
    uint               uMaximumGroupLimit;
    ubyte              bEapolKeyIpAddressAllocationSupported;
}

struct DOT11_WFD_DEVICE_INFO
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           DeviceAddress;
    ushort             ConfigMethods;
    DOT11_WFD_DEVICE_TYPE PrimaryDeviceType;
    DOT11_WPS_DEVICE_NAME DeviceName;
}

struct DOT11_WFD_SECONDARY_DEVICE_TYPE_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    DOT11_WFD_DEVICE_TYPE[1] SecondaryDeviceTypes;
}

struct DOT11_WFD_DISCOVER_DEVICE_FILTER
{
    ubyte[6]   DeviceID;
    ubyte      ucBitmask;
    DOT11_SSID GroupSSID;
}

struct DOT11_WFD_DISCOVER_REQUEST
{
    NDIS_OBJECT_HEADER  Header;
    DOT11_WFD_DISCOVER_TYPE DiscoverType;
    DOT11_WFD_SCAN_TYPE ScanType;
    uint                uDiscoverTimeout;
    uint                uDeviceFilterListOffset;
    uint                uNumDeviceFilters;
    uint                uIEsOffset;
    uint                uIEsLength;
    ubyte               bForceScanLegacyNetworks;
}

struct DOT11_WFD_DEVICE_ENTRY
{
    uint           uPhyId;
    DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO PhySpecificInfo;
    ubyte[6]       dot11BSSID;
    DOT11_BSS_TYPE dot11BSSType;
    ubyte[6]       TransmitterAddress;
    int            lRSSI;
    uint           uLinkQuality;
    ushort         usBeaconPeriod;
    ulong          ullTimestamp;
    ulong          ullBeaconHostTimestamp;
    ulong          ullProbeResponseHostTimestamp;
    ushort         usCapabilityInformation;
    uint           uBeaconIEsOffset;
    uint           uBeaconIEsLength;
    uint           uProbeResponseIEsOffset;
    uint           uProbeResponseIEsLength;
}

struct DOT11_WFD_ADDITIONAL_IE
{
    NDIS_OBJECT_HEADER Header;
    uint               uBeaconIEsOffset;
    uint               uBeaconIEsLength;
    uint               uProbeResponseIEsOffset;
    uint               uProbeResponseIEsLength;
    uint               uDefaultRequestIEsOffset;
    uint               uDefaultRequestIEsLength;
}

struct DOT11_SEND_GO_NEGOTIATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER  Header;
    ubyte[6]            PeerDeviceAddress;
    ubyte               DialogToken;
    uint                uSendTimeout;
    DOT11_WFD_GO_INTENT GroupOwnerIntent;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    ubyte[6]            IntendedInterfaceAddress;
    ubyte               GroupCapability;
    uint                uIEsOffset;
    uint                uIEsLength;
}

struct DOT11_SEND_GO_NEGOTIATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER  Header;
    ubyte[6]            PeerDeviceAddress;
    ubyte               DialogToken;
    void*               RequestContext;
    uint                uSendTimeout;
    ubyte               Status;
    DOT11_WFD_GO_INTENT GroupOwnerIntent;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    ubyte[6]            IntendedInterfaceAddress;
    ubyte               GroupCapability;
    DOT11_WFD_GROUP_ID  GroupID;
    ubyte               bUseGroupID;
    uint                uIEsOffset;
    uint                uIEsLength;
}

struct DOT11_SEND_GO_NEGOTIATION_CONFIRMATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    void*              ResponseContext;
    uint               uSendTimeout;
    ubyte              Status;
    ubyte              GroupCapability;
    DOT11_WFD_GROUP_ID GroupID;
    ubyte              bUseGroupID;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_WFD_INVITATION_FLAGS
{
    ubyte _bitfield85;
}

struct DOT11_SEND_INVITATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              DialogToken;
    ubyte[6]           PeerDeviceAddress;
    uint               uSendTimeout;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    DOT11_WFD_INVITATION_FLAGS InvitationFlags;
    ubyte[6]           GroupBSSID;
    ubyte              bUseGroupBSSID;
    DOT11_WFD_CHANNEL  OperatingChannel;
    ubyte              bUseSpecifiedOperatingChannel;
    DOT11_WFD_GROUP_ID GroupID;
    ubyte              bLocalGO;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_SEND_INVITATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           ReceiverDeviceAddress;
    ubyte              DialogToken;
    void*              RequestContext;
    uint               uSendTimeout;
    ubyte              Status;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    ubyte[6]           GroupBSSID;
    ubyte              bUseGroupBSSID;
    DOT11_WFD_CHANNEL  OperatingChannel;
    ubyte              bUseSpecifiedOperatingChannel;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_SEND_PROVISION_DISCOVERY_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              DialogToken;
    ubyte[6]           PeerDeviceAddress;
    uint               uSendTimeout;
    ubyte              GroupCapability;
    DOT11_WFD_GROUP_ID GroupID;
    ubyte              bUseGroupID;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_SEND_PROVISION_DISCOVERY_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           ReceiverDeviceAddress;
    ubyte              DialogToken;
    void*              RequestContext;
    uint               uSendTimeout;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_WFD_DEVICE_LISTEN_CHANNEL
{
    NDIS_OBJECT_HEADER Header;
    ubyte              ChannelNumber;
}

struct DOT11_WFD_GROUP_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_WFD_CHANNEL  AdvertisedOperatingChannel;
}

struct DOT11_WFD_GROUP_JOIN_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_WFD_CHANNEL  GOOperatingChannel;
    uint               GOConfigTime;
    ubyte              bInGroupFormation;
    ubyte              bWaitForWPSReady;
}

struct DOT11_POWER_MGMT_AUTO_MODE_ENABLED_INFO
{
    NDIS_OBJECT_HEADER Header;
    ubyte              bEnabled;
}

struct DOT11_POWER_MGMT_MODE_STATUS_INFO
{
    NDIS_OBJECT_HEADER Header;
    DOT11_POWER_MODE   PowerSaveMode;
    uint               uPowerSaveLevel;
    DOT11_POWER_MODE_REASON Reason;
}

struct DOT11_CHANNEL_HINT
{
    DOT11_PHY_TYPE Dot11PhyType;
    uint           uChannelNumber;
}

struct DOT11_OFFLOAD_NETWORK
{
    DOT11_SSID           Ssid;
    DOT11_CIPHER_ALGORITHM UnicastCipher;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CHANNEL_HINT[4] Dot11ChannelHints;
}

struct DOT11_OFFLOAD_NETWORK_LIST_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               ulFlags;
    uint               FastScanPeriod;
    uint               FastScanIterations;
    uint               SlowScanPeriod;
    uint               uNumOfEntries;
    DOT11_OFFLOAD_NETWORK[1] offloadNetworkList;
}

struct DOT11_OFFLOAD_NETWORK_STATUS_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    int                Status;
}

struct DOT11_MANUFACTURING_TEST
{
    DOT11_MANUFACTURING_TEST_TYPE dot11ManufacturingTestType;
    uint     uBufferLength;
    ubyte[1] ucBuffer;
}

struct DOT11_MANUFACTURING_SELF_TEST_SET_PARAMS
{
    DOT11_MANUFACTURING_SELF_TEST_TYPE SelfTestType;
    uint     uTestID;
    uint     uPinBitMask;
    void*    pvContext;
    uint     uBufferLength;
    ubyte[1] ucBufferIn;
}

struct DOT11_MANUFACTURING_SELF_TEST_QUERY_RESULTS
{
    DOT11_MANUFACTURING_SELF_TEST_TYPE SelfTestType;
    uint     uTestID;
    ubyte    bResult;
    uint     uPinFailedBitMask;
    void*    pvContext;
    uint     uBytesWrittenOut;
    ubyte[1] ucBufferOut;
}

struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_RX
{
    ubyte      bEnabled;
    DOT11_BAND Dot11Band;
    uint       uChannel;
    int        PowerLevel;
}

struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_TX
{
    ubyte      bEnable;
    ubyte      bOpenLoop;
    DOT11_BAND Dot11Band;
    uint       uChannel;
    uint       uSetPowerLevel;
    int        ADCPowerLevel;
}

struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_QUERY_ADC
{
    DOT11_BAND Dot11Band;
    uint       uChannel;
    int        ADCPowerLevel;
}

struct DOT11_MANUFACTURING_TEST_SET_DATA
{
    uint     uKey;
    uint     uOffset;
    uint     uBufferLength;
    ubyte[1] ucBufferIn;
}

struct DOT11_MANUFACTURING_TEST_QUERY_DATA
{
    uint     uKey;
    uint     uOffset;
    uint     uBufferLength;
    uint     uBytesRead;
    ubyte[1] ucBufferOut;
}

struct DOT11_MANUFACTURING_TEST_SLEEP
{
    uint  uSleepTime;
    void* pvContext;
}

struct DOT11_MANUFACTURING_CALLBACK_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_MANUFACTURING_CALLBACK_TYPE dot11ManufacturingCallbackType;
    uint               uStatus;
    void*              pvContext;
}

///The <b>WLAN_PROFILE_INFO</b> structure contains basic information about a profile.
struct WLAN_PROFILE_INFO
{
    ///The name of the profile. This value may be the name of a domain if the profile is for provisioning. Profile names
    ///are case-sensitive. This string must be NULL-terminated. <b>Windows XP with SP3 and Wireless LAN API for Windows
    ///XP with SP2: </b>The name of the profile is derived automatically from the SSID of the wireless network. For
    ///infrastructure network profiles, the name of the profile is the SSID of the network. For ad hoc network profiles,
    ///the name of the profile is the SSID of the ad hoc network followed by <code>-adhoc</code>.
    ushort[256] strProfileName;
    ///A set of flags specifying settings for wireless profile. These values are defined in the <i>Wlanapi.h</i> header
    ///file. <b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2: </b><i>dwFlags</i> must be 0. Per-user
    ///profiles are not supported. Combinations of these flag bits are possible <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="WLAN_PROFILE_GROUP_POLICY"></a><a
    ///id="wlan_profile_group_policy"></a><dl> <dt><b>WLAN_PROFILE_GROUP_POLICY</b></dt> </dl> </td> <td width="60%">
    ///This flag indicates that this profile was created by group policy. A group policy profile is read-only. Neither
    ///the content nor the preference order of the profile can be changed. </td> </tr> <tr> <td width="40%"><a
    ///id="WLAN_PROFILE_USER"></a><a id="wlan_profile_user"></a><dl> <dt><b>WLAN_PROFILE_USER</b></dt> </dl> </td> <td
    ///width="60%"> This flag indicates that the profile is a per-user profile. If not set, this profile is an all-user
    ///profile. </td> </tr> </table>
    uint        dwFlags;
}

///The <b>DOT11_NETWORK</b> structure contains information about an available wireless network.
struct DOT11_NETWORK
{
    ///A DOT11_SSID structure that contains the SSID of a visible wireless network.
    DOT11_SSID     dot11Ssid;
    ///A DOT11_BSS_TYPE value that indicates the BSS type of the network.
    DOT11_BSS_TYPE dot11BssType;
}

///The <b>WLAN_RAW_DATA</b> structure contains raw data in the form of a blob that is used by some Native Wifi
///functions.
struct WLAN_RAW_DATA
{
    ///The size, in bytes, of the <b>DataBlob</b> member. The maximum value of the <b>dwDataSize</b> may be restricted
    ///by type of data that is stored in the <b>WLAN_RAW_DATA</b> structure.
    uint     dwDataSize;
    ubyte[1] DataBlob;
}

///The <b>WLAN_RAW_DATA_LIST</b> structure contains raw data in the form of an array of data blobs that are used by some
///Native Wifi functions.
struct WLAN_RAW_DATA_LIST
{
    ///The total size, in bytes, of the <b>WLAN_RAW_DATA_LIST</b> structure.
    uint dwTotalSize;
    ///The number of raw data entries or blobs in the <b>WLAN_RAW_DATA_LIST</b> structure. The maximum value of the
    ///<b>dwNumberOfItems</b> may be restricted by the type of data that is stored in the <b>WLAN_RAW_DATA_LIST</b>
    ///structure.
    uint dwNumberOfItems;
    struct
    {
        uint dwDataOffset;
        uint dwDataSize;
    }
}

///The set of supported data rates.
struct WLAN_RATE_SET
{
    ///The length, in bytes, of <b>usRateSet</b>.
    uint        uRateSetLength;
    ///An array of supported data transfer rates. DOT11_RATE_SET_MAX_LENGTH is defined in windot11.h to have a value of
    ///126. Each supported data transfer rate is stored as a USHORT. The first bit of the USHORT specifies whether the
    ///rate is a basic rate. A <i>basic rate</i> is the data transfer rate that all stations in a basic service set
    ///(BSS) can use to receive frames from the wireless medium. If the rate is a basic rate, the first bit of the
    ///USHORT is set to 1. To calculate the data transfer rate in Mbps for an arbitrary array entry rateSet[i], use the
    ///following equation: <code>rate_in_mbps = (rateSet[i] &amp; 0x7FFF) * 0.5</code>
    ushort[126] usRateSet;
}

///The <b>WLAN_AVAILABLE_NETWORK</b> structure contains information about an available wireless network.
struct WLAN_AVAILABLE_NETWORK
{
    ///Contains the profile name associated with the network. If the network does not have a profile, this member will
    ///be empty. If multiple profiles are associated with the network, there will be multiple entries with the same SSID
    ///in the visible network list. Profile names are case-sensitive. This string must be NULL-terminated.
    ushort[256]          strProfileName;
    ///A DOT11_SSID structure that contains the SSID of the visible wireless network.
    DOT11_SSID           dot11Ssid;
    ///A DOT11_BSS_TYPE value that specifies whether the network is infrastructure or ad hoc.
    DOT11_BSS_TYPE       dot11BssType;
    ///Indicates the number of BSSIDs in the network. <b>Windows XP with SP3 and Wireless LAN API for Windows XP with
    ///SP2: </b><b>uNumberofBssids</b> is at most 1, regardless of the number of access points broadcasting the SSID.
    uint                 uNumberOfBssids;
    ///Indicates whether the network is connectable or not. If set to <b>TRUE</b>, the network is connectable, otherwise
    ///the network cannot be connected to.
    BOOL                 bNetworkConnectable;
    ///A WLAN_REASON_CODE value that indicates why a network cannot be connected to. This member is only valid when
    ///<b>bNetworkConnectable</b> is <b>FALSE</b>.
    uint                 wlanNotConnectableReason;
    ///The number of PHY types supported on available networks. The maximum value of <i>uNumberOfPhyTypes</i> is
    ///<b>WLAN_MAX_PHY_TYPE_NUMBER</b>, which has a value of 8. If more than <b>WLAN_MAX_PHY_TYPE_NUMBER</b> PHY types
    ///are supported, <i>bMorePhyTypes</i> must be set to <b>TRUE</b>.
    uint                 uNumberOfPhyTypes;
    ///Contains an array of DOT11_PHY_TYPE values that represent the PHY types supported by the available networks. When
    ///<i>uNumberOfPhyTypes</i> is greater than <b>WLAN_MAX_PHY_TYPE_NUMBER</b>, this array contains only the first
    ///<b>WLAN_MAX_PHY_TYPE_NUMBER</b> PHY types. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="dot11_phy_type_unknown"></a><a id="DOT11_PHY_TYPE_UNKNOWN"></a><dl>
    ///<dt><b>dot11_phy_type_unknown</b></dt> </dl> </td> <td width="60%"> Specifies an unknown or uninitialized PHY
    ///type. </td> </tr> <tr> <td width="40%"><a id="dot11_phy_type_any"></a><a id="DOT11_PHY_TYPE_ANY"></a><dl>
    ///<dt><b>dot11_phy_type_any</b></dt> </dl> </td> <td width="60%"> Specifies any PHY type. </td> </tr> <tr> <td
    ///width="40%"><a id="dot11_phy_type_fhss"></a><a id="DOT11_PHY_TYPE_FHSS"></a><dl>
    ///<dt><b>dot11_phy_type_fhss</b></dt> </dl> </td> <td width="60%"> Specifies a frequency-hopping spread-spectrum
    ///(FHSS) PHY. Bluetooth devices can use FHSS or an adaptation of FHSS. </td> </tr> <tr> <td width="40%"><a
    ///id="dot11_phy_type_dsss"></a><a id="DOT11_PHY_TYPE_DSSS"></a><dl> <dt><b>dot11_phy_type_dsss</b></dt> </dl> </td>
    ///<td width="60%"> Specifies a direct sequence spread spectrum (DSSS) PHY. </td> </tr> <tr> <td width="40%"><a
    ///id="dot11_phy_type_irbaseband"></a><a id="DOT11_PHY_TYPE_IRBASEBAND"></a><dl>
    ///<dt><b>dot11_phy_type_irbaseband</b></dt> </dl> </td> <td width="60%"> Specifies an infrared (IR) baseband PHY.
    ///</td> </tr> <tr> <td width="40%"><a id="dot11_phy_type_ofdm"></a><a id="DOT11_PHY_TYPE_OFDM"></a><dl>
    ///<dt><b>dot11_phy_type_ofdm</b></dt> </dl> </td> <td width="60%"> Specifies an orthogonal frequency division
    ///multiplexing (OFDM) PHY. 802.11a devices can use OFDM. </td> </tr> <tr> <td width="40%"><a
    ///id="dot11_phy_type_hrdsss"></a><a id="DOT11_PHY_TYPE_HRDSSS"></a><dl> <dt><b>dot11_phy_type_hrdsss</b></dt> </dl>
    ///</td> <td width="60%"> Specifies a high-rate DSSS (HRDSSS) PHY. </td> </tr> <tr> <td width="40%"><a
    ///id="dot11_phy_type_erp"></a><a id="DOT11_PHY_TYPE_ERP"></a><dl> <dt><b>dot11_phy_type_erp</b></dt> </dl> </td>
    ///<td width="60%"> Specifies an extended rate PHY (ERP). 802.11g devices can use ERP. </td> </tr> <tr> <td
    ///width="40%"><a id="dot11_phy_type_ht"></a><a id="DOT11_PHY_TYPE_HT"></a><dl> <dt><b>dot11_phy_type_ht</b></dt>
    ///</dl> </td> <td width="60%"> Specifies an 802.11n PHY type. </td> </tr> <tr> <td width="40%"><a
    ///id="dot11_phy_type_vht"></a><a id="DOT11_PHY_TYPE_VHT"></a><dl> <dt><b>dot11_phy_type_vht</b></dt> </dl> </td>
    ///<td width="60%"> Specifies the 802.11ac PHY type. This is the very high throughput PHY type specified in IEEE
    ///802.11ac. This value is supported on Windows 8.1, Windows Server 2012 R2, and later. </td> </tr> <tr> <td
    ///width="40%"><a id="dot11_phy_type_IHV_start"></a><a id="dot11_phy_type_ihv_start"></a><a
    ///id="DOT11_PHY_TYPE_IHV_START"></a><dl> <dt><b>dot11_phy_type_IHV_start</b></dt> </dl> </td> <td width="60%">
    ///Specifies the start of the range that is used to define PHY types that are developed by an independent hardware
    ///vendor (IHV). </td> </tr> <tr> <td width="40%"><a id="dot11_phy_type_IHV_end"></a><a
    ///id="dot11_phy_type_ihv_end"></a><a id="DOT11_PHY_TYPE_IHV_END"></a><dl> <dt><b>dot11_phy_type_IHV_end</b></dt>
    ///</dl> </td> <td width="60%"> Specifies the end of the range that is used to define PHY types that are developed
    ///by an independent hardware vendor (IHV). </td> </tr> </table>
    DOT11_PHY_TYPE[8]    dot11PhyTypes;
    ///Specifies if there are more than <b>WLAN_MAX_PHY_TYPE_NUMBER</b> PHY types supported. When this member is set to
    ///<b>TRUE</b>, an application must call WlanGetNetworkBssList to get the complete list of PHY types. The returned
    ///WLAN_BSS_LIST structure has an array of WLAN_BSS_ENTRY structures. The <i>uPhyId</i> member of the
    ///<b>WLAN_BSS_ENTRY</b> structure contains the PHY type for an entry.
    BOOL                 bMorePhyTypes;
    ///A percentage value that represents the signal quality of the network. <b>WLAN_SIGNAL_QUALITY</b> is of type
    ///<b>ULONG</b>. This member contains a value between 0 and 100. A value of 0 implies an actual RSSI signal strength
    ///of -100 dbm. A value of 100 implies an actual RSSI signal strength of -50 dbm. You can calculate the RSSI signal
    ///strength value for <b>wlanSignalQuality</b> values between 1 and 99 using linear interpolation.
    uint                 wlanSignalQuality;
    ///Indicates whether security is enabled on the network. A value of <b>TRUE</b> indicates that security is enabled,
    ///otherwise it is not.
    BOOL                 bSecurityEnabled;
    ///A DOT11_AUTH_ALGORITHM value that indicates the default authentication algorithm used to join this network for
    ///the first time.
    DOT11_AUTH_ALGORITHM dot11DefaultAuthAlgorithm;
    ///A DOT11_CIPHER_ALGORITHM value that indicates the default cipher algorithm to be used when joining this network.
    DOT11_CIPHER_ALGORITHM dot11DefaultCipherAlgorithm;
    ///Contains various flags for the network. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="WLAN_AVAILABLE_NETWORK_CONNECTED"></a><a id="wlan_available_network_connected"></a><dl>
    ///<dt><b>WLAN_AVAILABLE_NETWORK_CONNECTED</b></dt> </dl> </td> <td width="60%"> This network is currently
    ///connected. </td> </tr> <tr> <td width="40%"><a id="WLAN_AVAILABLE_NETWORK_HAS_PROFILE"></a><a
    ///id="wlan_available_network_has_profile"></a><dl> <dt><b>WLAN_AVAILABLE_NETWORK_HAS_PROFILE</b></dt> </dl> </td>
    ///<td width="60%"> There is a profile for this network. </td> </tr> </table>
    uint                 dwFlags;
    ///Reserved for future use. Must be set to <b>NULL</b>.
    uint                 dwReserved;
}

struct WLAN_AVAILABLE_NETWORK_V2
{
    ushort[256]          strProfileName;
    DOT11_SSID           dot11Ssid;
    DOT11_BSS_TYPE       dot11BssType;
    uint                 uNumberOfBssids;
    BOOL                 bNetworkConnectable;
    uint                 wlanNotConnectableReason;
    uint                 uNumberOfPhyTypes;
    DOT11_PHY_TYPE[8]    dot11PhyTypes;
    BOOL                 bMorePhyTypes;
    uint                 wlanSignalQuality;
    BOOL                 bSecurityEnabled;
    DOT11_AUTH_ALGORITHM dot11DefaultAuthAlgorithm;
    DOT11_CIPHER_ALGORITHM dot11DefaultCipherAlgorithm;
    uint                 dwFlags;
    DOT11_ACCESSNETWORKOPTIONS AccessNetworkOptions;
    ubyte[6]             dot11HESSID;
    DOT11_VENUEINFO      VenueInfo;
    uint                 dwReserved;
}

///The <b>WLAN_BSS_ENTRY</b> structure contains information about a basic service set (BSS).
struct WLAN_BSS_ENTRY
{
    ///The SSID of the access point (AP) or peer station associated with the BSS. The data type for this member is a
    ///DOT11_SSID structure.
    DOT11_SSID     dot11Ssid;
    ///The identifier (ID) of the PHY that the wireless LAN interface used to detect the BSS network.
    uint           uPhyId;
    ///The media access control (MAC) address of the access point for infrastructure BSS networks or the peer station
    ///for independent BSS networks (ad hoc networks) that sent the 802.11 Beacon or Probe Response frame received by
    ///the wireless LAN interface while scanning. The data type for this member is a DOT11_MAC_ADDRESS structure.
    ubyte[6]       dot11Bssid;
    ///The BSS network type. The data type for this member is a DOT11_BSS_TYPE enumeration value. This member can be one
    ///of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="dot11_BSS_type_infrastructure"></a><a id="dot11_bss_type_infrastructure"></a><a
    ///id="DOT11_BSS_TYPE_INFRASTRUCTURE"></a><dl> <dt><b>dot11_BSS_type_infrastructure</b></dt> <dt>1</dt> </dl> </td>
    ///<td width="60%"> Specifies an infrastructure BSS network. </td> </tr> <tr> <td width="40%"><a
    ///id="dot11_BSS_type_independent"></a><a id="dot11_bss_type_independent"></a><a
    ///id="DOT11_BSS_TYPE_INDEPENDENT"></a><dl> <dt><b>dot11_BSS_type_independent</b></dt> <dt>2</dt> </dl> </td> <td
    ///width="60%"> Specifies an independent BSS (IBSS) network (an ad hoc network). </td> </tr> </table>
    DOT11_BSS_TYPE dot11BssType;
    ///The PHY type for this network. The data type for this member is a DOT11_PHY_TYPE enumeration value.
    DOT11_PHY_TYPE dot11BssPhyType;
    ///The received signal strength indicator (RSSI) value, in units of decibels referenced to 1.0 milliwatts (dBm), as
    ///detected by the wireless LAN interface driver for the AP or peer station.
    int            lRssi;
    ///The link quality reported by the wireless LAN interface driver. The link quality value ranges from 0 through 100.
    ///A value of 100 specifies the highest link quality.
    uint           uLinkQuality;
    ///A value that specifies whether the AP or peer station is operating within the regulatory domain as identified by
    ///the country/region. If the wireless LAN interface driver does not support multiple regulatory domains, this
    ///member is set to <b>TRUE</b>. If the 802.11 Beacon or Probe Response frame received from the AP or peer station
    ///does not include a Country information element (IE), this member is set to <b>TRUE</b>. If the 802.11 Beacon or
    ///Probe Response frame received from the AP or peer station does include a Country IE, this member is set to
    ///<b>FALSE</b> if the value of the Country String subfield does not equal the input country string.
    ubyte          bInRegDomain;
    ///The value of the Beacon Interval field from the 802.11 Beacon or Probe Response frame received by the wireless
    ///LAN interface. The interval is in 1,024 microsecond time units between target beacon transmission times. This
    ///information is retrieved from the beacon packet sent by an access point in an infrastructure BSS network or a
    ///probe response from an access point or peer station in response to a wireless LAN client sending a Probe Request.
    ///The IEEE 802.11 standard defines a unit of time as equal to 1,024 microseconds. This unit was defined so that it
    ///could be easily implemented in hardware.
    ushort         usBeaconPeriod;
    ///The value of the Timestamp field from the 802.11 Beacon or Probe Response frame received by the wireless LAN
    ///interface.
    ulong          ullTimestamp;
    ///The host timestamp value that records when wireless LAN interface received the Beacon or Probe Response frame.
    ///This member is a count of 100-nanosecond intervals since January 1, 1601. For more information, see the
    ///<b>NdisGetCurrentSystemTime</b> function documented in the WDK.
    ulong          ullHostTimestamp;
    ///The value of the Capability Information field from the 802.11 Beacon or Probe Response frame received by the
    ///wireless LAN interface. This value is a set of bit flags defining the capability. This member can be one or more
    ///of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="ESS"></a><a id="ess"></a><dl> <dt><b>ESS</b></dt> <dt>bit 0</dt> </dl> </td> <td width="60%"> An extended
    ///service set. A set of one or more interconnected basic service sets (BSSs) and integrated local area networks
    ///(LANs) that appears as a single BSS to the logical link control layer at any station associated with one of those
    ///BSSs. An AP set the ESS subfield to 1 and the IBSS subfield to 0 within transmitted Beacon or Probe Response
    ///frames. A peer station within an IBSS (ad hoc network) sets the ESS subfield to 0 and the IBSS subfield to 1 in
    ///transmitted Beacon or Probe Response frames. </td> </tr> <tr> <td width="40%"><a id="IBSS"></a><a
    ///id="ibss"></a><dl> <dt><b>IBSS</b></dt> <dt>bit 1</dt> </dl> </td> <td width="60%"> An independent basic service
    ///set. A BSS that forms a self-contained network, and in which no access to a distribution system (DS) is available
    ///(an ad hoc network). An AP sets the ESS subfield to 1 and the IBSS subfield to 0 within transmitted Beacon or
    ///Probe Response frames. A peer station within an IBSS (ad hoc network) sets the ESS subfield to 0 and the IBSS
    ///subfield to 1 in transmitted Beacon or Probe Response frames. </td> </tr> <tr> <td width="40%"><a
    ///id="CF-Pollable"></a><a id="cf-pollable"></a><a id="CF-POLLABLE"></a><dl> <dt><b>CF-Pollable</b></dt> <dt>bit
    ///2</dt> </dl> </td> <td width="60%"> A value that indicates if the AP or peer station is pollable. </td> </tr>
    ///<tr> <td width="40%"><a id="CF_Poll_Request"></a><a id="cf_poll_request"></a><a id="CF_POLL_REQUEST"></a><dl>
    ///<dt><b>CF Poll Request</b></dt> <dt>bit 3</dt> </dl> </td> <td width="60%"> A value that indicates how the AP or
    ///peer station handles poll requests. </td> </tr> <tr> <td width="40%"><a id="Privacy"></a><a id="privacy"></a><a
    ///id="PRIVACY"></a><dl> <dt><b>Privacy</b></dt> <dt>bit 4</dt> </dl> </td> <td width="60%"> A value that indicates
    ///if encryption is required for all data frames. An AP sets the Privacy subfield to 1 within transmitted Beacon and
    ///Probe Response frames if WEP, WPA, or WPA2 encryption is required for all data type frames exchanged within the
    ///BSS. If WEP, WPA, or WPA2 encryption is not required, the Privacy subfield is set to 0. A peer station within and
    ///IBSS sets the Privacy subfield to 1 within transmitted Beacon and Probe Response frames if WEP, WPA, or WPA2
    ///encryption is required for all data type frames exchanged within the IBSS. If WEP, WPA, or WPA2 encryption is not
    ///required, the Privacy subfield is set to 0. </td> </tr> </table>
    ushort         usCapabilityInformation;
    ///The channel center frequency of the band on which the 802.11 Beacon or Probe Response frame was received. The
    ///value of <b>ulChCenterFrequency</b> is in units of kilohertz (kHz). <div class="alert"><b>Note</b> This member is
    ///only valid for PHY types that are not frequency-hopping spread spectrum (FHSS). </div> <div> </div>
    uint           ulChCenterFrequency;
    ///A set of data transfer rates supported by the BSS. The data type for this member is a WLAN_RATE_SET structure.
    WLAN_RATE_SET  wlanRateSet;
    ///The offset, in bytes, of the information element (IE) data blob from the beginning of the <b>WLAN_BSS_ENTRY</b>
    ///structure. This member points to a buffer that contains variable-length information elements (IEs) from the
    ///802.11 Beacon or Probe Response frames. For each BSS, the IEs are from the last Beacon or Probe Response frame
    ///received from that BSS network. If an IE is available in only one frame, the wireless LAN interface driver merges
    ///the IE with the other IEs from the last received Beacon or Probe Response frame. Information elements are defined
    ///in the IEEE 802.11 specifications to have a common general format consisting of a 1-byte Element ID field, a
    ///1-byte Length field, and a variable-length element-specific information field. Each information element is
    ///assigned a unique Element ID value as defined in this IEEE 802.11 standards. The Length field specifies the
    ///number of bytes in the information field.
    uint           ulIeOffset;
    ///The size, in bytes, of the IE data blob in the <b>WLAN_BSS_ENTRY</b> structure. This is the exact length of the
    ///data in the buffer pointed to by <b>ulIeOffset</b> member and does not contain any padding for alignment. The
    ///maximum value for the size of the IE data blob is 2,324 bytes.
    uint           ulIeSize;
}

///The <b>WLAN_BSS_LIST</b> structure contains a list of basic service set (BSS) entries.
struct WLAN_BSS_LIST
{
    ///The total size of this structure, in bytes.
    uint              dwTotalSize;
    ///The number of items in the <b>wlanBssEntries</b> member.
    uint              dwNumberOfItems;
    ///An array of WLAN_BSS_ENTRY structures that contains information about a BSS.
    WLAN_BSS_ENTRY[1] wlanBssEntries;
}

///The <b>WLAN_INTERFACE_INFO</b> structure contains information about a wireless LAN interface.
struct WLAN_INTERFACE_INFO
{
    ///Contains the GUID of the interface.
    GUID                 InterfaceGuid;
    ///Contains the description of the interface.
    ushort[256]          strInterfaceDescription;
    ///Contains a WLAN_INTERFACE_STATE value that indicates the current state of the interface. <b>Windows XP with SP3
    ///and Wireless LAN API for Windows XP with SP2: </b>Only the <b>wlan_interface_state_connected</b>,
    ///<b>wlan_interface_state_disconnected</b>, and <b>wlan_interface_state_authenticating</b> values are supported.
    WLAN_INTERFACE_STATE isState;
}

///The <b>WLAN_ASSOCIATION_ATTRIBUTES</b> structure contains association attributes for a connection.
struct WLAN_ASSOCIATION_ATTRIBUTES
{
    ///A DOT11_SSID structure that contains the SSID of the association.
    DOT11_SSID     dot11Ssid;
    ///A DOT11_BSS_TYPE value that specifies whether the network is infrastructure or ad hoc.
    DOT11_BSS_TYPE dot11BssType;
    ///A DOT11_MAC_ADDRESS that contains the BSSID of the association.
    ubyte[6]       dot11Bssid;
    ///A DOT11_PHY_TYPE value that indicates the physical type of the association.
    DOT11_PHY_TYPE dot11PhyType;
    ///The position of the DOT11_PHY_TYPE value in the structure containing the list of PHY types.
    uint           uDot11PhyIndex;
    ///A percentage value that represents the signal quality of the network. <b>WLAN_SIGNAL_QUALITY</b> is of type
    ///<b>ULONG</b>. This member contains a value between 0 and 100. A value of 0 implies an actual RSSI signal strength
    ///of -100 dbm. A value of 100 implies an actual RSSI signal strength of -50 dbm. You can calculate the RSSI signal
    ///strength value for <b>wlanSignalQuality</b> values between 1 and 99 using linear interpolation.
    uint           wlanSignalQuality;
    ///Contains the receiving rate of the association.
    uint           ulRxRate;
    ///Contains the transmission rate of the association.
    uint           ulTxRate;
}

///The <b>WLAN_SECURITY_ATTRIBUTES</b> structure defines the security attributes for a wireless connection.
struct WLAN_SECURITY_ATTRIBUTES
{
    ///Indicates whether security is enabled for this connection.
    BOOL                 bSecurityEnabled;
    ///Indicates whether 802.1X is enabled for this connection.
    BOOL                 bOneXEnabled;
    ///A DOT11_AUTH_ALGORITHM value that identifies the authentication algorithm.
    DOT11_AUTH_ALGORITHM dot11AuthAlgorithm;
    ///A DOT11_CIPHER_ALGORITHM value that identifies the cipher algorithm.
    DOT11_CIPHER_ALGORITHM dot11CipherAlgorithm;
}

///The <b>WLAN_CONNECTION_ATTRIBUTES</b> structure defines the attributes of a wireless connection.
struct WLAN_CONNECTION_ATTRIBUTES
{
    ///A WLAN_INTERFACE_STATE value that indicates the state of the interface. <b>Windows XP with SP3 and Wireless LAN
    ///API for Windows XP with SP2: </b>Only the <b>wlan_interface_state_connected</b>,
    ///<b>wlan_interface_state_disconnected</b>, and <b>wlan_interface_state_authenticating</b> values are supported.
    WLAN_INTERFACE_STATE isState;
    ///A WLAN_CONNECTION_MODE value that indicates the mode of the connection. <b>Windows XP with SP3 and Wireless LAN
    ///API for Windows XP with SP2: </b>Only the <b>wlan_connection_mode_profile</b> value is supported.
    WLAN_CONNECTION_MODE wlanConnectionMode;
    ///The name of the profile used for the connection. Profile names are case-sensitive. This string must be
    ///NULL-terminated.
    ushort[256]          strProfileName;
    ///A WLAN_ASSOCIATION_ATTRIBUTES structure that contains the attributes of the association.
    WLAN_ASSOCIATION_ATTRIBUTES wlanAssociationAttributes;
    ///A WLAN_SECURITY_ATTRIBUTES structure that contains the security attributes of the connection.
    WLAN_SECURITY_ATTRIBUTES wlanSecurityAttributes;
}

///The <b>WLAN_PHY_RADIO_STATE</b> structure specifies the radio state on a specific physical layer (PHY) type.
struct WLAN_PHY_RADIO_STATE
{
    ///The index of the PHY type on which the radio state is being set or queried. The WlanGetInterfaceCapability
    ///function returns a list of valid PHY types.
    uint              dwPhyIndex;
    ///A DOT11_RADIO_STATE value that indicates the software radio state.
    DOT11_RADIO_STATE dot11SoftwareRadioState;
    ///A DOT11_RADIO_STATE value that indicates the hardware radio state.
    DOT11_RADIO_STATE dot11HardwareRadioState;
}

///The <b>WLAN_RADIO_STATE</b> structurespecifies the radio state on a list of physical layer (PHY) types.
struct WLAN_RADIO_STATE
{
    ///The number of valid PHY indices in the <b>PhyRadioState</b> member.
    uint dwNumberOfPhys;
    ///An array of WLAN_PHY_RADIO_STATE structures that specify the radio states of a number of PHY indices. Only the
    ///first <b>dwNumberOfPhys</b> entries in this array are valid.
    WLAN_PHY_RADIO_STATE[64] PhyRadioState;
}

///The <b>WLAN_INTERFACE_CAPABILITY</b> structure contains information about the capabilities of an interface.
struct WLAN_INTERFACE_CAPABILITY
{
    ///A WLAN_INTERFACE_TYPE value that indicates the type of the interface.
    WLAN_INTERFACE_TYPE interfaceType;
    ///Indicates whether 802.11d is supported by the interface. If <b>TRUE</b>, 802.11d is supported.
    BOOL                bDot11DSupported;
    ///The maximum size of the SSID list supported by this interface.
    uint                dwMaxDesiredSsidListSize;
    ///The maximum size of the basic service set (BSS) identifier list supported by this interface.
    uint                dwMaxDesiredBssidListSize;
    ///Contains the number of supported PHY types.
    uint                dwNumberOfSupportedPhys;
    ///An array of DOT11_PHY_TYPE values that specify the supported PHY types. WLAN_MAX_PHY_INDEX is set to 64.
    DOT11_PHY_TYPE[64]  dot11PhyTypes;
}

///The <b>WLAN_AUTH_CIPHER_PAIR_LIST</b> structure contains a list of authentication and cipher algorithm pairs.
struct WLAN_AUTH_CIPHER_PAIR_LIST
{
    ///Contains the number of supported auth-cipher pairs.
    uint dwNumberOfItems;
    DOT11_AUTH_CIPHER_PAIR[1] pAuthCipherPairList;
}

///A <b>WLAN_COUNTRY_OR_REGION_STRING_LIST</b> structure contains a list of supported country or region strings.
struct WLAN_COUNTRY_OR_REGION_STRING_LIST
{
    ///Indicates the number of supported country or region strings.
    uint     dwNumberOfItems;
    ubyte[3] pCountryOrRegionStringList;
}

///The <b>WLAN_PROFILE_INFO_LIST</b> structure contains a list of wireless profile information.
struct WLAN_PROFILE_INFO_LIST
{
    ///The number of wireless profile entries in the <b>ProfileInfo</b> member.
    uint                 dwNumberOfItems;
    ///The index of the current item. The index of the first item is 0. The <b>dwIndex</b> member must be less than the
    ///<b>dwNumberOfItems</b> member. This member is not used by the wireless service. Applications can use this member
    ///when processing individual profiles in the <b>WLAN_PROFILE_INFO_LIST</b> structure. When an application passes
    ///this structure from one function to another, it can set the value of <b>dwIndex</b> to the index of the item
    ///currently being processed. This can help an application maintain state. <b>dwIndex</b> should always be
    ///initialized before use.
    uint                 dwIndex;
    WLAN_PROFILE_INFO[1] ProfileInfo;
}

///The <b>WLAN_AVAILABLE_NETWORK_LIST</b> structure contains an array of information about available networks.
struct WLAN_AVAILABLE_NETWORK_LIST
{
    ///Contains the number of items in the <b>Network</b> member.
    uint dwNumberOfItems;
    ///The index of the current item. The index of the first item is 0. <b>dwIndex</b> must be less than
    ///<b>dwNumberOfItems</b>. This member is not used by the wireless service. Applications can use this member when
    ///processing individual networks in the <b>WLAN_AVAILABLE_NETWORK_LIST</b> structure. When an application passes
    ///this structure from one function to another, it can set the value of <b>dwIndex</b> to the index of the item
    ///currently being processed. This can help an application maintain state. <b>dwIndex</b> should always be
    ///initialized before use.
    uint dwIndex;
    WLAN_AVAILABLE_NETWORK[1] Network;
}

struct WLAN_AVAILABLE_NETWORK_LIST_V2
{
    uint dwNumberOfItems;
    uint dwIndex;
    WLAN_AVAILABLE_NETWORK_V2[1] Network;
}

///The <b>WLAN_INTERFACE_INFO_LIST</b> structure contains an array of NIC interface information.
struct WLAN_INTERFACE_INFO_LIST
{
    ///Contains the number of items in the <b>InterfaceInfo</b> member.
    uint dwNumberOfItems;
    ///The index of the current item. The index of the first item is 0. <b>dwIndex</b> must be less than
    ///<b>dwNumberOfItems</b>. This member is not used by the wireless service. Applications can use this member when
    ///processing individual interfaces in the <b>WLAN_INTERFACE_INFO_LIST</b> structure. When an application passes
    ///this structure from one function to another, it can set the value of <b>dwIndex</b> to the index of the item
    ///currently being processed. This can help an application maintain state. <b>dwIndex</b> should always be
    ///initialized before use.
    uint dwIndex;
    WLAN_INTERFACE_INFO[1] InterfaceInfo;
}

///The <b>DOT11_NETWORK_LIST</b> structure contains a list of 802.11 wireless networks.
struct DOT11_NETWORK_LIST
{
    ///Contains the number of items in the <b>Network</b> member.
    uint             dwNumberOfItems;
    ///The index of the current item. The index of the first item is 0. <b>dwIndex</b> must be less than
    ///<b>dwNumberOfItems</b>. This member is not used by the wireless service. Applications can use this member when
    ///processing individual networks in the <b>DOT11_NETWORK_LIST</b> structure. When an application passes this
    ///structure from one function to another, it can set the value of <b>dwIndex</b> to the index of the item currently
    ///being processed. This can help an application maintain state. <b>dwIndex</b> should always be initialized before
    ///use.
    uint             dwIndex;
    DOT11_NETWORK[1] Network;
}

///The <b>WLAN_CONNECTION_PARAMETERS</b> structure specifies the parameters used when using the WlanConnect function.
struct WLAN_CONNECTION_PARAMETERS
{
    ///A WLAN_CONNECTION_MODE value that specifies the mode of connection. <b>Windows XP with SP3 and Wireless LAN API
    ///for Windows XP with SP2: </b>Only the <b>wlan_connection_mode_profile</b> value is supported.
    WLAN_CONNECTION_MODE wlanConnectionMode;
    const(wchar)*        strProfile;
    ///Pointer to a DOT11_SSID structure that specifies the SSID of the network to connect to. This parameter is
    ///optional. When set to <b>NULL</b>, all SSIDs in the profile will be tried. This parameter must not be <b>NULL</b>
    ///if WLAN_CONNECTION_MODE is set to <b>wlan_connection_mode_discovery_secure</b> or
    ///<b>wlan_connection_mode_discovery_unsecure</b>.
    DOT11_SSID*          pDot11Ssid;
    ///Pointer to a DOT11_BSSID_LIST structure that contains the list of basic service set (BSS) identifiers desired for
    ///the connection. <b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2: </b>This member must be
    ///<b>NULL</b>.
    DOT11_BSSID_LIST*    pDesiredBssidList;
    ///A DOT11_BSS_TYPE value that indicates the BSS type of the network. If a profile is provided, this BSS type must
    ///be the same as the one in the profile.
    DOT11_BSS_TYPE       dot11BssType;
    ///The following table shows flags used to specify the connection parameters. <table> <tr> <th>Constant</th>
    ///<th>Value</th> <th>Description</th> </tr> <tr> <td>WLAN_CONNECTION_HIDDEN_NETWORK</td> <td>0x00000001</td>
    ///<td>Connect to the destination network even if the destination is a hidden network. A hidden network does not
    ///broadcast its SSID. Do not use this flag if the destination network is an ad-hoc network.If the profile specified
    ///by <b>strProfile</b> is not <b>NULL</b>, then this flag is ignored and the nonBroadcast profile element
    ///determines whether to connect to a hidden network. </td> </tr> <tr> <td>WLAN_CONNECTION_ADHOC_JOIN_ONLY</td>
    ///<td>0x00000002</td> <td>Do not form an ad-hoc network. Only join an ad-hoc network if the network already exists.
    ///Do not use this flag if the destination network is an infrastructure network.</td> </tr> <tr>
    ///<td>WLAN_CONNECTION_IGNORE_PRIVACY_BIT</td> <td>0x00000004</td> <td>Ignore the privacy bit when connecting to the
    ///network. Ignoring the privacy bit has the effect of ignoring whether packets are encrypted and ignoring the
    ///method of encryption used. Only use this flag when connecting to an infrastructure network using a temporary
    ///profile.</td> </tr> <tr> <td>WLAN_CONNECTION_EAPOL_PASSTHROUGH </td> <td>0x00000008</td> <td>Exempt EAPOL traffic
    ///from encryption and decryption. This flag is used when an application must send EAPOL traffic over an
    ///infrastructure network that uses Open authentication and WEP encryption. This flag must not be used to connect to
    ///networks that require 802.1X authentication. This flag is only valid when <b>wlanConnectionMode</b> is set to
    ///<b>wlan_connection_mode_temporary_profile</b>. Avoid using this flag whenever possible.</td> </tr> <tr>
    ///<td>WLAN_CONNECTION_PERSIST_DISCOVERY_PROFILE </td> <td>0x00000010</td> <td>Automatically persist discovery
    ///profile on successful connection completion. This flag is only valid for wlan_connection_mode_discovery_secure or
    ///wlan_connection_mode_discovery_unsecure. The profile will be saved as an all user profile, with the name
    ///generated from the SSID using WlanUtf8SsidToDisplayName. If there is already a profile with the same name, a
    ///number will be appended to the end of the profile name. The profile will be saved with manual connection mode,
    ///unless WLAN_CONNECTION_PERSIST_DISCOVERY_PROFILE_CONNECTION_MODE_AUTO is also specified.</td> </tr> <tr>
    ///<td>WLAN_CONNECTION_PERSIST_DISCOVERY_PROFILE_CONNECTION_MODE_AUTO </td> <td>0x00000020</td> <td>To be used in
    ///conjunction with WLAN_CONNECTION_PERSIST_DISCOVERY_PROFILE. The discovery profile will be persisted with
    ///automatic connection mode.</td> </tr> <tr> <td>WLAN_CONNECTION_PERSIST_DISCOVERY_PROFILE_OVERWRITE_EXISTING</td>
    ///<td>0x00000040</td> <td>To be used in conjunction with WLAN_CONNECTION_PERSIST_DISCOVERY_PROFILE. The discovery
    ///profile will be persisted and attempt to overwrite an existing profile with the same name.</td> </tr> </table>
    ///<b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2: </b>This member must be set to 0.
    uint                 dwFlags;
}

struct WLAN_CONNECTION_PARAMETERS_V2
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    const(wchar)*        strProfile;
    DOT11_SSID*          pDot11Ssid;
    ubyte*               pDot11Hessid;
    DOT11_BSSID_LIST*    pDesiredBssidList;
    DOT11_BSS_TYPE       dot11BssType;
    uint                 dwFlags;
    DOT11_ACCESSNETWORKOPTIONS* pDot11AccessNetworkOptions;
}

///The <b>WLAN_MSM_NOTIFICATION_DATA</b> structure contains information about media specific module (MSM) connection
///related notifications.
struct WLAN_MSM_NOTIFICATION_DATA
{
    ///A WLAN_CONNECTION_MODE value that specifies the mode of the connection.
    WLAN_CONNECTION_MODE wlanConnectionMode;
    ///The name of the profile used for the connection. WLAN_MAX_NAME_LENGTH is 256. Profile names are case-sensitive.
    ///This string must be NULL-terminated.
    ushort[256]          strProfileName;
    ///A DOT11_SSID structure that contains the SSID of the association.
    DOT11_SSID           dot11Ssid;
    ///A DOT11_BSS_TYPE value that indicates the BSS network type.
    DOT11_BSS_TYPE       dot11BssType;
    ///A DOT11_MAC_ADDRESS that specifies the MAC address of the peer or access point.
    ubyte[6]             dot11MacAddr;
    ///Indicates whether security is enabled for this connection. If <b>TRUE</b>, security is enabled.
    BOOL                 bSecurityEnabled;
    ///Indicates whether the peer is the first to join the ad hoc network created by the machine. If <b>TRUE</b>, the
    ///peer is the first to join. After the first peer joins the network, the interface state of the machine that
    ///created the ad hoc network changes from wlan_interface_state_ad_hoc_network_formed to
    ///wlan_interface_state_connected.
    BOOL                 bFirstPeer;
    ///Indicates whether the peer is the last to leave the ad hoc network created by the machine. If <b>TRUE</b>, the
    ///peer is the last to leave. After the last peer leaves the network, the interface state of the machine that
    ///created the ad hoc network changes from wlan_interface_state_connected to
    ///wlan_interface_state_ad_hoc_network_formed.
    BOOL                 bLastPeer;
    ///A WLAN_REASON_CODE that indicates the reason for an operation failure. If the operation succeeds, this field has
    ///a value of <b>WLAN_REASON_CODE_SUCCESS</b>. Otherwise, this field indicates the reason for the failure.
    uint                 wlanReasonCode;
}

///The <b>WLAN_CONNECTION_NOTIFICATION_DATA</b> structure contains information about connection related notifications.
struct WLAN_CONNECTION_NOTIFICATION_DATA
{
    ///A WLAN_CONNECTION_MODE value that specifies the mode of the connection. <b>Windows XP with SP3 and Wireless LAN
    ///API for Windows XP with SP2: </b>Only the <b>wlan_connection_mode_profile</b> value is supported.
    WLAN_CONNECTION_MODE wlanConnectionMode;
    ///The name of the profile used for the connection. WLAN_MAX_NAME_LENGTH is 256. Profile names are case-sensitive.
    ///This string must be NULL-terminated.
    ushort[256]          strProfileName;
    ///A DOT11_SSID structure that contains the SSID of the association.
    DOT11_SSID           dot11Ssid;
    ///A DOT11_BSS_TYPE value that indicates the BSS network type.
    DOT11_BSS_TYPE       dot11BssType;
    ///Indicates whether security is enabled for this connection. If <b>TRUE</b>, security is enabled.
    BOOL                 bSecurityEnabled;
    ///A WLAN_REASON_CODE that indicates the reason for an operation failure. This field has a value of
    ///<b>WLAN_REASON_CODE_SUCCESS</b> for all connection-related notifications except
    ///<b>wlan_notification_acm_connection_complete</b>. If the connection fails, this field indicates the reason for
    ///the failure.
    uint                 wlanReasonCode;
    ///A set of flags that provide additional information for the network connection. This member can be one of the
    ///following values defined in the <i>Wlanapi.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="WLAN_CONNECTION_NOTIFICATION_ADHOC_NETWORK_FORMED"></a><a
    ///id="wlan_connection_notification_adhoc_network_formed"></a><dl>
    ///<dt><b>WLAN_CONNECTION_NOTIFICATION_ADHOC_NETWORK_FORMED</b></dt> </dl> </td> <td width="60%"> Indicates that an
    ///adhoc network is formed. </td> </tr> <tr> <td width="40%"><a
    ///id="WLAN_CONNECTION_NOTIFICATION_CONSOLE_USER_PROFILE"></a><a
    ///id="wlan_connection_notification_console_user_profile"></a><dl>
    ///<dt><b>WLAN_CONNECTION_NOTIFICATION_CONSOLE_USER_PROFILE</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///connection uses a per-user profile owned by the console user. Non-console users will not be able to see the
    ///profile in their profile list. </td> </tr> </table>
    uint                 dwFlags;
    ///This field contains the XML presentation of the profile used for discovery, if the connection succeeds.
    ushort[1]            strProfileXml;
}

///A structure that represents a device service notification.
struct WLAN_DEVICE_SERVICE_NOTIFICATION_DATA
{
    ///Type: **[GUID](../guiddef/ns-guiddef-guid.md)** The **GUID** identifying the device service for this
    ///notification.
    GUID     DeviceService;
    ///Type: **[DWORD](/windows/win32/winprog/windows-data-types)** The opcode that identifies the operation under the
    ///device service for this notification.
    uint     dwOpCode;
    ///Type: **[DWORD](/windows/win32/winprog/windows-data-types)** The size, in bytes, of the *DataBlob* member. The
    ///maximum value of *dwDataSize* may be restricted by the type of data that is stored in the
    ///**WLAN_DEVICE_SERVICE_NOTIFICATION_DATA** structure.
    uint     dwDataSize;
    ///Type: **[BYTE](../guiddef/ns-guiddef-guid.md)\[1\]** A pointer to an array containing **BYTES**s, representing
    ///the data blob. This is the data that is received from the independent hardware vendor (IHV) driver, and is passed
    ///on to the client as an unformatted byte array blob.
    ubyte[1] DataBlob;
}

///The <b>WLAN_PHY_FRAME_STATISTICS</b> structure contains information about sent and received PHY frames
struct WLAN_PHY_FRAME_STATISTICS
{
    ///Contains the number of successfully transmitted MSDU/MMPDUs.
    ulong ullTransmittedFrameCount;
    ///Contains the number of successfully transmitted MSDU/MMPDUs in which the multicast bit is set as the destination
    ///MAC address.
    ulong ullMulticastTransmittedFrameCount;
    ///Contains the number of MSDU/MMPDUs transmission failures due to the number of transmit attempts exceeding the
    ///retry limit.
    ulong ullFailedCount;
    ///Contains the number of MSDU/MMPDUs successfully transmitted after one or more retransmissions.
    ulong ullRetryCount;
    ///Contains the number of MSDU/MMPDUs successfully transmitted after more than one retransmission.
    ulong ullMultipleRetryCount;
    ///Contains the number of fragmented MSDU/MMPDUs that failed to send due to timeout.
    ulong ullMaxTXLifetimeExceededCount;
    ///Contains the number of MPDUs with an individual address in the address 1 field and MPDUs that have a multicast
    ///address with types Data or Management.
    ulong ullTransmittedFragmentCount;
    ///Contains the number of times a CTS has been received in response to an RTS.
    ulong ullRTSSuccessCount;
    ///Contains the number of times a CTS has not been received in response to an RTS.
    ulong ullRTSFailureCount;
    ///Contains the number of times an expected ACK has not been received.
    ulong ullACKFailureCount;
    ///Contains the number of MSDU/MMPDUs successfully received.
    ulong ullReceivedFrameCount;
    ///Contains the number of successfully received MSDU/MMPDUs with the multicast bit set in the MAC address.
    ulong ullMulticastReceivedFrameCount;
    ///Contains the number of MSDU/MMPDUs successfully received only because promicscuous mode is enabled.
    ulong ullPromiscuousReceivedFrameCount;
    ///Contains the number of fragmented MSDU/MMPDUs dropped due to timeout.
    ulong ullMaxRXLifetimeExceededCount;
    ///Contains the number of frames received that the Sequence Control field indicates as a duplicate.
    ulong ullFrameDuplicateCount;
    ///Contains the number of successfully received Data or Management MPDUs.
    ulong ullReceivedFragmentCount;
    ///Contains the number of MPDUs successfully received only because promiscuous mode is enabled.
    ulong ullPromiscuousReceivedFragmentCount;
    ///Contains the number of times an FCS error has been detected in a received MPDU.
    ulong ullFCSErrorCount;
}

///The <b>WLAN_MAC_FRAME_STATISTICS</b> structure contains information about sent and received MAC frames.
struct WLAN_MAC_FRAME_STATISTICS
{
    ///Contains the number of successfully transmitted MSDU/MMPDUs.
    ulong ullTransmittedFrameCount;
    ///Contains the number of successfully received MSDU/MMPDUs.
    ulong ullReceivedFrameCount;
    ///Contains the number of frames discarded due to having a "Protected" status indicated in the frame control field.
    ulong ullWEPExcludedCount;
    ///Contains the number of MIC failures encountered while checking the integrity of packets received from the AP or
    ///peer station.
    ulong ullTKIPLocalMICFailures;
    ///Contains the number of TKIP replay errors detected.
    ulong ullTKIPReplays;
    ///Contains the number of TKIP protected packets that the NIC failed to decrypt.
    ulong ullTKIPICVErrorCount;
    ///Contains the number of received unicast fragments discarded by the replay mechanism.
    ulong ullCCMPReplays;
    ///Contains the number of received fragments discarded by the CCMP decryption algorithm.
    ulong ullCCMPDecryptErrors;
    ///Contains the number of WEP protected packets received for which a decryption key was not available on the NIC.
    ulong ullWEPUndecryptableCount;
    ///Contains the number of WEP protected packets the NIC failed to decrypt.
    ulong ullWEPICVErrorCount;
    ///Contains the number of encrypted packets that the NIC has successfully decrypted.
    ulong ullDecryptSuccessCount;
    ///Contains the number of encrypted packets that the NIC has failed to decrypt.
    ulong ullDecryptFailureCount;
}

///The <b>WLAN_STATISTICS</b> structure contains assorted statistics about an interface.
struct WLAN_STATISTICS
{
    ///Indicates the number of 4-way handshake failures. This member is only valid if IHV Service is being used as the
    ///authentication service for the current network.
    ulong ullFourWayHandshakeFailures;
    ///Indicates the number of TKIP countermeasures performed by an IHV Miniport driver. This count does not include
    ///TKIP countermeasures invoked by the operating system.
    ulong ullTKIPCounterMeasuresInvoked;
    ///Reserved for use by Microsoft.
    ulong ullReserved;
    ///A WLAN_MAC_FRAME_STATISTICS structure that contains MAC layer counters for unicast packets directed to the
    ///receiver of the NIC.
    WLAN_MAC_FRAME_STATISTICS MacUcastCounters;
    ///A WLAN_MAC_FRAME_STATISTICS structure that contains MAC layer counters for multicast packets directed to the
    ///current multicast address.
    WLAN_MAC_FRAME_STATISTICS MacMcastCounters;
    ///Contains the number of <b>WLAN_PHY_FRAME_STATISTICS</b> structures in the <b>PhyCounters</b> member.
    uint  dwNumberOfPhys;
    WLAN_PHY_FRAME_STATISTICS[1] PhyCounters;
}

///Contains an array of device service GUIDs.
struct WLAN_DEVICE_SERVICE_GUID_LIST
{
    ///Type: **[DWORD](/windows/win32/winprog/windows-data-types)** The number of items in the *DeviceService* argument.
    uint    dwNumberOfItems;
    ///Type: **[DWORD](/windows/win32/winprog/windows-data-types)** The index of the current item. The index of the
    ///first item is 0. *dwIndex* must be less than *dwNumberOfItems*. This member is not used by the wireless service.
    ///You can use this member when processing individual **GUID**s in the **WLAN_DEVICE_SERVICE_GUID_LIST** structure.
    ///When your application passes this structure from one function to another, it can set the value of *dwIndex* to
    ///the index of the item currently being processed. This can help your application maintain state. You should always
    ///initialize *dwIndex* before use.
    uint    dwIndex;
    ///Type: **[GUID](../guiddef/ns-guiddef-guid.md)\[1\]** A pointer to an array containing **GUID**s; each corresponds
    ///to a WLAN device service that the driver supports.
    GUID[1] DeviceService;
}

struct WFD_GROUP_ID
{
    ubyte[6]   DeviceAddress;
    DOT11_SSID GroupSSID;
}

///The <b>WLAN_HOSTED_NETWORK_PEER_STATE</b> structure contains information about the peer state for a peer on the
///wireless Hosted Network.
struct WLAN_HOSTED_NETWORK_PEER_STATE
{
    ///The MAC address of the peer being described.
    ubyte[6] PeerMacAddress;
    ///The current authentication state of this peer.
    WLAN_HOSTED_NETWORK_PEER_AUTH_STATE PeerAuthState;
}

///The <b>WLAN_HOSTED_NETWORK_RADIO_STATE</b> structure contains information about the radio state on the wireless
///Hosted Network.
struct WLAN_HOSTED_NETWORK_RADIO_STATE
{
    ///The software radio state of the wireless Hosted Network.
    DOT11_RADIO_STATE dot11SoftwareRadioState;
    ///The hardware radio state of the wireless Hosted Network.
    DOT11_RADIO_STATE dot11HardwareRadioState;
}

///The <b>WLAN_HOSTED_NETWORK_STATE_CHANGE</b> structure contains information about a network state change on the
///wireless Hosted Network.
struct WLAN_HOSTED_NETWORK_STATE_CHANGE
{
    ///The previous network state on the wireless Hosted Network.
    WLAN_HOSTED_NETWORK_STATE OldState;
    ///The current network state on the wireless Hosted Network.
    WLAN_HOSTED_NETWORK_STATE NewState;
    ///The reason for the network state change.
    WLAN_HOSTED_NETWORK_REASON StateChangeReason;
}

///The <b>WLAN_HOSTED_NETWORK_DATA_PEER_STATE_CHANGE</b> structure contains information about a network state change for
///a data peer on the wireless Hosted Network.
struct WLAN_HOSTED_NETWORK_DATA_PEER_STATE_CHANGE
{
    ///The previous network state for a data peer on the wireless Hosted Network.
    WLAN_HOSTED_NETWORK_PEER_STATE OldState;
    ///The current network state for a data peer on the wireless Hosted Network.
    WLAN_HOSTED_NETWORK_PEER_STATE NewState;
    ///The reason for the network state change for the data peer.
    WLAN_HOSTED_NETWORK_REASON PeerStateChangeReason;
}

///The <b>WLAN_HOSTED_NETWORK_CONNECTION_SETTINGS</b> structure contains information about the connection settings on
///the wireless Hosted Network.
struct WLAN_HOSTED_NETWORK_CONNECTION_SETTINGS
{
    ///The SSID associated with the wireless Hosted Network.
    DOT11_SSID hostedNetworkSSID;
    ///The maximum number of concurrent peers allowed by the wireless Hosted Network.
    uint       dwMaxNumberOfPeers;
}

///The <b>WLAN_HOSTED_NETWORK_SECURITY_SETTINGS</b> structure contains information about the security settings on the
///wireless Hosted Network.
struct WLAN_HOSTED_NETWORK_SECURITY_SETTINGS
{
    ///The authentication algorithm used by the wireless Hosted Network.
    DOT11_AUTH_ALGORITHM dot11AuthAlgo;
    ///The cipher algorithm used by the wireless Hosted Network.
    DOT11_CIPHER_ALGORITHM dot11CipherAlgo;
}

///The <b>WLAN_HOSTED_NETWORK_STATUS</b> structure contains information about the status of the wireless Hosted Network.
struct WLAN_HOSTED_NETWORK_STATUS
{
    ///The current state of the wireless Hosted Network. If the value of this member is
    ///<b>wlan_hosted_network_unavailable</b>, then the values of the other fields in this structure should not be used.
    WLAN_HOSTED_NETWORK_STATE HostedNetworkState;
    ///The actual network Device ID used for the wireless Hosted Network. This is member is the GUID of a virtual
    ///wireless device which would not be available through calls to the WlanEnumInterfaces function. This GUID can be
    ///used for calling other higher layer networking functions that use the device GUID (IP Helper functions, for
    ///example).
    GUID           IPDeviceID;
    ///The BSSID used by the wireless Hosted Network in packets, beacons, and probe responses.
    ubyte[6]       wlanHostedNetworkBSSID;
    ///The physical type of the network interface used by wireless Hosted Network. This is one of the types reported by
    ///the related physical interface. This value is correct only if the <b>HostedNetworkState</b> member is
    ///<b>wlan_hosted_network_active</b>.
    DOT11_PHY_TYPE dot11PhyType;
    ///The channel frequency of the network interface used by wireless Hosted Network. This value is correct only if
    ///<b>HostedNetworkState</b> is <b>wlan_hosted_network_active</b>.
    uint           ulChannelFrequency;
    ///The current number of authenticated peers on the wireless Hosted Network. This value is correct only if
    ///<b>HostedNetworkState</b> is <b>wlan_hosted_network_active</b>.
    uint           dwNumberOfPeers;
    WLAN_HOSTED_NETWORK_PEER_STATE[1] PeerList;
}

///The <b>ONEX_VARIABLE_BLOB</b> structure is used as a member of other 802.1X authentication structures to contain
///variable-sized members.
struct ONEX_VARIABLE_BLOB
{
    ///The size, in bytes, of this <b>ONEX_VARIABLE_BLOB</b> structure.
    uint dwSize;
    ///The offset, in bytes, from the beginning of the containing outer structure (where the <b>ONEX_VARIABLE_BLOB</b>
    ///structure is a member) to the data contained in the <b>ONEX_VARIABLE_BLOB</b> structure.
    uint dwOffset;
}

///The <b>ONEX_AUTH_PARAMS</b> structure contains 802.1X authentication parameters used for 802.1X authentication.
struct ONEX_AUTH_PARAMS
{
    ///Indicates if a status update is pending for 802.X authentication.
    BOOL               fUpdatePending;
    ///The 802.1X authentication connection profile. This member contains an embedded ONEX_CONNECTION_PROFILE structure
    ///starting at the <b>dwOffset</b> member of the ONEX_VARIABLE_BLOB.
    ONEX_VARIABLE_BLOB oneXConnProfile;
    ///The identity used for 802.1X authentication status. This member is a value from the ONEX_AUTH_IDENTITY
    ///enumeration.
    ONEX_AUTH_IDENTITY authIdentity;
    ///The quarantine isolation state value of the local computer. The isolation state determines its network
    ///connectivity. This member corresponds to a value from the EAPHost ISOLATION_STATE enumeration.
    uint               dwQuarantineState;
    uint               _bitfield86;
    ///The session ID of the user currently logged on to the console. This member corresponds to the value returned by
    ///the WTSGetActiveConsoleSessionId function. This member contains a session ID if the <b>fSessionId</b> bitfield
    ///member is set.
    uint               dwSessionId;
    ///The user token handle used for 802.1X authentication. This member contains a user token handle if the
    ///<b>fhUserToken</b> bitfield member is set. For security reasons, the <b>hUserToken</b> member of the
    ///<b>ONEX_AUTH_PARAMS</b> structure returned in the <b>authParams</b> member of the ONEX_RESULT_UPDATE_DATA
    ///structure is always set to <b>NULL</b>.
    HANDLE             hUserToken;
    ///The 802.1X user profile used for 802.1X authentication. This member contains an embedded user profile starting at
    ///the <b>dwOffset</b> member of the ONEX_VARIABLE_BLOB if the <b>fOneXUserProfile</b> bitfield member is set. For
    ///security reasons, the <b>OneXUserProfile</b> member of the <b>ONEX_AUTH_PARAMS</b> structure returned in the
    ///<b>authParams</b> member of the ONEX_RESULT_UPDATE_DATA structure is always set to <b>NULL</b>.
    ONEX_VARIABLE_BLOB OneXUserProfile;
    ///The 802.1X identity used for 802.1X authentication. This member contains a NULL-terminated Unicode string with
    ///the identity starting at the <b>dwOffset</b> member of the ONEX_VARIABLE_BLOB if the <b>fIdentity</b> bitfield
    ///member is set.
    ONEX_VARIABLE_BLOB Identity;
    ///The user name used for 802.1X authentication. This member contains a NULL-terminated Unicode string with the user
    ///name starting at the <b>dwOffset</b> member of the ONEX_VARIABLE_BLOB if the <b>fUserName</b> bitfield member is
    ///set.
    ONEX_VARIABLE_BLOB UserName;
    ///The domain used for 802.1X authentication. This member contains a NULL-terminated Unicode string with the domain
    ///starting at the <b>dwOffset</b> member of the ONEX_VARIABLE_BLOB if the <b>fDomain</b> bitfield member is set.
    ONEX_VARIABLE_BLOB Domain;
}

///The <b>ONEX_EAP_ERROR</b> structure contains 802.1X EAP error when an error occurs with 802.1X authentication.
struct ONEX_EAP_ERROR
{
    ///The error value defined in the <i>Winerror.h</i> header file. This member also sometimes contains the reason the
    ///EAP method failed. The existing values for this member for the reason the EAP method failed are defined in the
    ///<i>Eaphosterror.h</i> header file. Some possible values are listed below. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="ERROR_PATH_NOT_FOUND"></a><a
    ///id="error_path_not_found"></a><dl> <dt><b>ERROR_PATH_NOT_FOUND</b></dt> <dt>3L</dt> </dl> </td> <td width="60%">
    ///The system cannot find the path specified. </td> </tr> <tr> <td width="40%"><a id="ERROR_INVALID_DATA"></a><a
    ///id="error_invalid_data"></a><dl> <dt><b>ERROR_INVALID_DATA</b></dt> <dt>13L</dt> </dl> </td> <td width="60%"> The
    ///data is not valid. </td> </tr> <tr> <td width="40%"><a id="ERROR_INVALID_PARAMETER"></a><a
    ///id="error_invalid_parameter"></a><dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> <dt>87L</dt> </dl> </td> <td
    ///width="60%"> A parameter is incorrect. </td> </tr> <tr> <td width="40%"><a id="ERROR_BAD_ARGUMENTS"></a><a
    ///id="error_bad_arguments"></a><dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> <dt>160L</dt> </dl> </td> <td width="60%">
    ///One or more arguments are not correct. </td> </tr> <tr> <td width="40%"><a id="ERROR_CANTOPEN"></a><a
    ///id="error_cantopen"></a><dl> <dt><b>ERROR_CANTOPEN</b></dt> <dt>1011L</dt> </dl> </td> <td width="60%"> The
    ///configuration registry key could not be opened. </td> </tr> <tr> <td width="40%"><a
    ///id="ERROR_DATATYPE_MISMATCH"></a><a id="error_datatype_mismatch"></a><dl> <dt><b>ERROR_DATATYPE_MISMATCH</b></dt>
    ///<dt>1629L</dt> </dl> </td> <td width="60%"> The data supplied is of the wrong type. </td> </tr> <tr> <td
    ///width="40%"><a id="EAP_I_USER_ACCOUNT_OTHER_ERROR"></a><a id="eap_i_user_account_other_error"></a><dl>
    ///<dt><b>EAP_I_USER_ACCOUNT_OTHER_ERROR</b></dt> <dt>0x40420110</dt> </dl> </td> <td width="60%"> The EAPHost
    ///received EAP failure after the identity exchange. There is likely a problem with the authenticating user's
    ///account. </td> </tr> <tr> <td width="40%"><a id="E_UNEXPECTED"></a><a id="e_unexpected"></a><dl>
    ///<dt><b>E_UNEXPECTED</b></dt> <dt>0x8000FFFFL</dt> </dl> </td> <td width="60%"> A catastrophic failure occurred.
    ///</td> </tr> <tr> <td width="40%"><a id="EAP_E_CERT_STORE_INACCESSIBLE"></a><a
    ///id="eap_e_cert_store_inaccessible"></a><dl> <dt><b>EAP_E_CERT_STORE_INACCESSIBLE</b></dt> <dt>0x80420010</dt>
    ///</dl> </td> <td width="60%"> The certificate store can't be accessed on either the authenticator or the peer.
    ///</td> </tr> <tr> <td width="40%"><a id="EAP_E_EAPHOST_METHOD_NOT_INSTALLED"></a><a
    ///id="eap_e_eaphost_method_not_installed"></a><dl> <dt><b>EAP_E_EAPHOST_METHOD_NOT_INSTALLED</b></dt>
    ///<dt>0x80420011</dt> </dl> </td> <td width="60%"> The requested EAP method is not installed. </td> </tr> <tr> <td
    ///width="40%"><a id="EAP_E_EAPHOST_EAPQEC_INACCESSIBLE"></a><a id="eap_e_eaphost_eapqec_inaccessible"></a><dl>
    ///<dt><b>EAP_E_EAPHOST_EAPQEC_INACCESSIBLE</b></dt> <dt>0x80420013</dt> </dl> </td> <td width="60%"> The EAPHost is
    ///not able to communicate with the EAP quarantine enforcement client (QEC) on a client with Network Access
    ///Protection (NAP) enabled. </td> </tr> <tr> <td width="40%"><a id="EAP_E_EAPHOST_IDENTITY_UNKNOWN"></a><a
    ///id="eap_e_eaphost_identity_unknown"></a><dl> <dt><b>EAP_E_EAPHOST_IDENTITY_UNKNOWN</b></dt> <dt>0x80420014</dt>
    ///</dl> </td> <td width="60%"> The EAPHost returns this error if the authenticator fails the authentication after
    ///the peer sent its identity. </td> </tr> <tr> <td width="40%"><a id="EAP_E_AUTHENTICATION_FAILED"></a><a
    ///id="eap_e_authentication_failed"></a><dl> <dt><b>EAP_E_AUTHENTICATION_FAILED</b></dt> <dt>0x80420015</dt> </dl>
    ///</td> <td width="60%"> The EAPHost returns this error on authentication failure. </td> </tr> <tr> <td
    ///width="40%"><a id="EAP_I_EAPHOST_EAP_NEGOTIATION_FAILED"></a><a
    ///id="eap_i_eaphost_eap_negotiation_failed"></a><dl> <dt><b>EAP_I_EAPHOST_EAP_NEGOTIATION_FAILED</b></dt>
    ///<dt>0x80420016</dt> </dl> </td> <td width="60%"> The EAPHost returns this error when the client and the server
    ///aren't configured with compatible EAP types. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_EAPHOST_METHOD_INVALID_PACKET"></a><a id="eap_e_eaphost_method_invalid_packet"></a><dl>
    ///<dt><b>EAP_E_EAPHOST_METHOD_INVALID_PACKET</b></dt> <dt>0x80420017</dt> </dl> </td> <td width="60%"> The
    ///EAPMethod received an EAP packet that cannot be processed. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_EAPHOST_REMOTE_INVALID_PACKET"></a><a id="eap_e_eaphost_remote_invalid_packet"></a><dl>
    ///<dt><b>EAP_E_EAPHOST_REMOTE_INVALID_PACKET</b></dt> <dt>0x80420018</dt> </dl> </td> <td width="60%"> The EAPHost
    ///received a packet that cannot be processed. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_EAPHOST_XML_MALFORMED"></a><a id="eap_e_eaphost_xml_malformed"></a><dl>
    ///<dt><b>EAP_E_EAPHOST_XML_MALFORMED</b></dt> <dt>0x80420019</dt> </dl> </td> <td width="60%"> The EAPHost
    ///configuration schema validation failed. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_METHOD_CONFIG_DOES_NOT_SUPPORT_SSO"></a><a id="eap_e_method_config_does_not_support_sso"></a><dl>
    ///<dt><b>EAP_E_METHOD_CONFIG_DOES_NOT_SUPPORT_SSO</b></dt> <dt>0x8042001A</dt> </dl> </td> <td width="60%"> The EAP
    ///method does not support single signon for the provided configuration. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_EAPHOST_METHOD_OPERATION_NOT_SUPPORTED"></a><a
    ///id="eap_e_eaphost_method_operation_not_supported"></a><dl>
    ///<dt><b>EAP_E_EAPHOST_METHOD_OPERATION_NOT_SUPPORTED</b></dt> <dt>0x80420020</dt> </dl> </td> <td width="60%"> The
    ///EAPHost returns this error when a configured EAP method does not support a requested operation (procedure call).
    ///</td> </tr> <tr> <td width="40%"><a id="EAP_E_USER_CERT_NOT_FOUND"></a><a id="eap_e_user_cert_not_found"></a><dl>
    ///<dt><b>EAP_E_USER_CERT_NOT_FOUND</b></dt> <dt>0x80420100</dt> </dl> </td> <td width="60%"> The EAPHost could not
    ///find the user certificate for authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_USER_CERT_INVALID"></a><a id="eap_e_user_cert_invalid"></a><dl> <dt><b>EAP_E_USER_CERT_INVALID</b></dt>
    ///<dt>0x80420101</dt> </dl> </td> <td width="60%"> The user certificate being used for authentication does not have
    ///a proper extended key usage (EKU) set. </td> </tr> <tr> <td width="40%"><a id="EAP_E_USER_CERT_EXPIRED"></a><a
    ///id="eap_e_user_cert_expired"></a><dl> <dt><b>EAP_E_USER_CERT_EXPIRED</b></dt> <dt>0x80420102</dt> </dl> </td> <td
    ///width="60%"> The EAPhost found a user certificate which has expired. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_USER_CERT_REVOKED"></a><a id="eap_e_user_cert_revoked"></a><dl> <dt><b>EAP_E_USER_CERT_REVOKED</b></dt>
    ///<dt>0x80420103</dt> </dl> </td> <td width="60%"> The user certificate being used for authentication has been
    ///revoked. </td> </tr> <tr> <td width="40%"><a id="EAP_E_USER_CERT_OTHER_ERROR"></a><a
    ///id="eap_e_user_cert_other_error"></a><dl> <dt><b>EAP_E_USER_CERT_OTHER_ERROR</b></dt> <dt>0x80420104</dt> </dl>
    ///</td> <td width="60%"> An unknown error occurred with the user certificate being used for authentication. </td>
    ///</tr> <tr> <td width="40%"><a id="EAP_E_USER_CERT_REJECTED"></a><a id="eap_e_user_cert_rejected"></a><dl>
    ///<dt><b>EAP_E_USER_CERT_REJECTED</b></dt> <dt>0x80420105</dt> </dl> </td> <td width="60%"> The authenticator
    ///rejected the user certificate being used for authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_USER_CREDENTIALS_REJECTED"></a><a id="eap_e_user_credentials_rejected"></a><dl>
    ///<dt><b>EAP_E_USER_CREDENTIALS_REJECTED</b></dt> <dt>0x80420111</dt> </dl> </td> <td width="60%"> The
    ///authenticator rejected the user credentials for authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_USER_NAME_PASSWORD_REJECTED"></a><a id="eap_e_user_name_password_rejected"></a><dl>
    ///<dt><b>EAP_E_USER_NAME_PASSWORD_REJECTED</b></dt> <dt>0x80420112</dt> </dl> </td> <td width="60%"> The
    ///authenticator rejected the user credentials for authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_NO_SMART_CARD_READER"></a><a id="eap_e_no_smart_card_reader"></a><dl>
    ///<dt><b>EAP_E_NO_SMART_CARD_READER</b></dt> <dt>0x80420113</dt> </dl> </td> <td width="60%"> No smart card reader
    ///was present. </td> </tr> <tr> <td width="40%"><a id="EAP_E_SERVER_CERT_INVALID"></a><a
    ///id="eap_e_server_cert_invalid"></a><dl> <dt><b>EAP_E_SERVER_CERT_INVALID</b></dt> <dt>0x80420201</dt> </dl> </td>
    ///<td width="60%"> The server certificate being user for authentication does not have a proper EKU set . </td>
    ///</tr> <tr> <td width="40%"><a id="EAP_E_SERVER_CERT_EXPIRED"></a><a id="eap_e_server_cert_expired"></a><dl>
    ///<dt><b>EAP_E_SERVER_CERT_EXPIRED</b></dt> <dt>0x80420202</dt> </dl> </td> <td width="60%"> The EAPhost found a
    ///server certificate which has expired. </td> </tr> <tr> <td width="40%"><a id="EAP_E_SERVER_CERT_REVOKED"></a><a
    ///id="eap_e_server_cert_revoked"></a><dl> <dt><b>EAP_E_SERVER_CERT_REVOKED</b></dt> <dt>0x80420203</dt> </dl> </td>
    ///<td width="60%"> The server certificate being used for authentication has been revoked. </td> </tr> <tr> <td
    ///width="40%"><a id="EAP_E_SERVER_CERT_OTHER_ERROR"></a><a id="eap_e_server_cert_other_error"></a><dl>
    ///<dt><b>EAP_E_SERVER_CERT_OTHER_ERROR</b></dt> <dt>0x80420204</dt> </dl> </td> <td width="60%"> An unknown error
    ///occurred with the server certificate being used for authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_USER_ROOT_CERT_NOT_FOUND"></a><a id="eap_e_user_root_cert_not_found"></a><dl>
    ///<dt><b>EAP_E_USER_ROOT_CERT_NOT_FOUND</b></dt> <dt>0x80420300</dt> </dl> </td> <td width="60%"> The EAPHost could
    ///not find a certificate in trusted root certificate store for user certificate validation. </td> </tr> <tr> <td
    ///width="40%"><a id="EAP_E_USER_ROOT_CERT_INVALID"></a><a id="eap_e_user_root_cert_invalid"></a><dl>
    ///<dt><b>EAP_E_USER_ROOT_CERT_INVALID</b></dt> <dt>0x80420301</dt> </dl> </td> <td width="60%"> The authentication
    ///failed because the root certificate used for this network is not valid. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_USER_ROOT_CERT_EXPIRED"></a><a id="eap_e_user_root_cert_expired"></a><dl>
    ///<dt><b>EAP_E_USER_ROOT_CERT_EXPIRED</b></dt> <dt>0x80420302</dt> </dl> </td> <td width="60%"> The trusted root
    ///certificate needed for user certificate validation has expired. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_E_SERVER_ROOT_CERT_NOT_FOUND"></a><a id="eap_e_server_root_cert_not_found"></a><dl>
    ///<dt><b>EAP_E_SERVER_ROOT_CERT_NOT_FOUND</b></dt> <dt>0x80420400</dt> </dl> </td> <td width="60%"> The EAPHost
    ///could not find a root certificate in the trusted root certificate store for server certificate velidation. </td>
    ///</tr> </table>
    uint               dwWinError;
    ///The EAP method type that raised the error during 802.1X authentication. The EAP_METHOD_TYPE structure is defined
    ///in the <i>Eaptypes.h</i> header file.
    EAP_METHOD_TYPE    type;
    ///The reason the EAP method failed. Some of the values for this member are defined in the <i>Eaphosterror.h</i>
    ///header file and some are defined in in the <i>Winerror.h</i> header file, although other values are possible.
    ///Possible values are listed below. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="ERROR_BAD_ARGUMENTS"></a><a id="error_bad_arguments"></a><dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td>
    ///<td width="60%"> One or more arguments are not correct. </td> </tr> <tr> <td width="40%"><a
    ///id="ERROR_INVALID_DATA"></a><a id="error_invalid_data"></a><dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td>
    ///<td width="60%"> The data is not valid. </td> </tr> <tr> <td width="40%"><a id="ERROR_INVALID_PARAMETER"></a><a
    ///id="error_invalid_parameter"></a><dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A
    ///parameter is incorrect. </td> </tr> <tr> <td width="40%"><a id="EAP_I_USER_ACCOUNT_OTHER_ERROR"></a><a
    ///id="eap_i_user_account_other_error"></a><dl> <dt><b>EAP_I_USER_ACCOUNT_OTHER_ERROR</b></dt> </dl> </td> <td
    ///width="60%"> The EAPHost received EAP failure after the identity exchange. There is likely a problem with the
    ///authenticating user's account. </td> </tr> <tr> <td width="40%"><a id="Other"></a><a id="other"></a><a
    ///id="OTHER"></a><dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
    ///string for the returned error. </td> </tr> </table>
    uint               dwReasonCode;
    ///A unique ID that identifies cause of error in EAPHost. An EAP method can define a new GUID and associate the GUID
    ///with a specific root cause. The existing values for this member are defined in the <i>Eaphosterror.h</i> header
    ///file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Default"></a><a
    ///id="guid_eaphost_default"></a><a id="GUID_EAPHOST_DEFAULT"></a><dl> <dt><b>GUID_EapHost_Default</b></dt>
    ///<dt>{0x00000000, 0x0000, 0x0000, 0, 0, 0, 0, 0, 0, 0, 0}</dt> </dl> </td> <td width="60%"> The default error
    ///cause. This is not a fixed GUID when it reaches supplicant, but the first portion will be filled by a generic
    ///Win32/RAS error. This helps create a unique GUID for every unique error. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_MethodDLLNotFound"></a><a id="guid_eaphost_cause_methoddllnotfound"></a><a
    ///id="GUID_EAPHOST_CAUSE_METHODDLLNOTFOUND"></a><dl> <dt><b>GUID_EapHost_Cause_MethodDLLNotFound</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 1}}</dt> </dl> </td> <td width="60%"> EAPHost
    ///cannot locate the DLL for the EAP method. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_CertStoreInaccessible"></a><a id="guid_eaphost_cause_certstoreinaccessible"></a><a
    ///id="GUID_EAPHOST_CAUSE_CERTSTOREINACCESSIBLE"></a><dl> <dt><b>GUID_EapHost_Cause_CertStoreInaccessible</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 4}}</dt> </dl> </td> <td width="60%"> Both the
    ///authenticator and the peer are unable to access the certificate store. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_Server_CertExpired"></a><a id="guid_eaphost_cause_server_certexpired"></a><a
    ///id="GUID_EAPHOST_CAUSE_SERVER_CERTEXPIRED"></a><dl> <dt><b>GUID_EapHost_Cause_Server_CertExpired</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 5}}</dt> </dl> </td> <td width="60%"> EAPHost
    ///found an expired server certificate. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_Server_CertInvalid"></a><a id="guid_eaphost_cause_server_certinvalid"></a><a
    ///id="GUID_EAPHOST_CAUSE_SERVER_CERTINVALID"></a><dl> <dt><b>GUID_EapHost_Cause_Server_CertInvalid</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 6}}</dt> </dl> </td> <td width="60%"> The
    ///server certificate being user for authentication does not have a proper extended key usage (EKU) set. </td> </tr>
    ///<tr> <td width="40%"><a id="GUID_EapHost_Cause_Server_CertNotFound"></a><a
    ///id="guid_eaphost_cause_server_certnotfound"></a><a id="GUID_EAPHOST_CAUSE_SERVER_CERTNOTFOUND"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Server_CertNotFound</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8,
    ///0, 0, 0, 7}} </dt> </dl> </td> <td width="60%"> EAPHost could not find the server certificate for authentication.
    ///</td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_Server_CertRevoked"></a><a
    ///id="guid_eaphost_cause_server_certrevoked"></a><a id="GUID_EAPHOST_CAUSE_SERVER_CERTREVOKED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Server_CertRevoked</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8,
    ///0, 0, 0, 8}}</dt> </dl> </td> <td width="60%"> The server certificate being used for authentication has been
    ///revoked. </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_CertExpired"></a><a
    ///id="guid_eaphost_cause_user_certexpired"></a><a id="GUID_EAPHOST_CAUSE_USER_CERTEXPIRED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CertExpired</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0,
    ///0, 0, 9}}</dt> </dl> </td> <td width="60%"> EAPHost found an expired user certificate. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Cause_User_CertInvalid"></a><a id="guid_eaphost_cause_user_certinvalid"></a><a
    ///id="GUID_EAPHOST_CAUSE_USER_CERTINVALID"></a><dl> <dt><b>GUID_EapHost_Cause_User_CertInvalid</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0xA}}</dt> </dl> </td> <td width="60%"> The
    ///user certificate being user for authentication does not have proper extended key usage (EKU) set. </td> </tr>
    ///<tr> <td width="40%"><a id="GUID_EapHost_Cause_User_CertNotFound"></a><a
    ///id="guid_eaphost_cause_user_certnotfound"></a><a id="GUID_EAPHOST_CAUSE_USER_CERTNOTFOUND"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CertNotFound</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0,
    ///0, 0, 0xB}}</dt> </dl> </td> <td width="60%"> EAPHost could not find a user certificate for authentication. </td>
    ///</tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_CertOtherError"></a><a
    ///id="guid_eaphost_cause_user_certothererror"></a><a id="GUID_EAPHOST_CAUSE_USER_CERTOTHERERROR"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CertOtherError</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8,
    ///0, 0, 0, 0xC}}</dt> </dl> </td> <td width="60%"> An unknown error occurred with the user certification being used
    ///for authentication. </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_CertRejected"></a><a
    ///id="guid_eaphost_cause_user_certrejected"></a><a id="GUID_EAPHOST_CAUSE_USER_CERTREJECTED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CertRejected</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0,
    ///0, 0, 0xD}}</dt> </dl> </td> <td width="60%"> The authenticator rejected the user certification. </td> </tr> <tr>
    ///<td width="40%"><a id="GUID_EapHost_Cause_User_CertRevoked"></a><a
    ///id="guid_eaphost_cause_user_certrevoked"></a><a id="GUID_EAPHOST_CAUSE_USER_CERTREVOKED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CertRevoked</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0,
    ///0, 0, 0xE}}</dt> </dl> </td> <td width="60%"> The user certificate being used for authentication has been
    ///revoked. </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_Root_CertExpired"></a><a
    ///id="guid_eaphost_cause_user_root_certexpired"></a><a id="GUID_EAPHOST_CAUSE_USER_ROOT_CERTEXPIRED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_Root_CertExpired</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 0, 0xF}}</dt> </dl> </td> <td width="60%"> The trusted root certificate needed for user certificate
    ///validation has expired. </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_Root_CertInvalid"></a><a
    ///id="guid_eaphost_cause_user_root_certinvalid"></a><a id="GUID_EAPHOST_CAUSE_USER_ROOT_CERTINVALID"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_Root_CertInvalid</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 0, 0x10}}</dt> </dl> </td> <td width="60%"> The authentication failed because the root certificate
    ///used for this network is not valid. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_User_Root_CertNotFound"></a><a id="guid_eaphost_cause_user_root_certnotfound"></a><a
    ///id="GUID_EAPHOST_CAUSE_USER_ROOT_CERTNOTFOUND"></a><dl> <dt><b>GUID_EapHost_Cause_User_Root_CertNotFound</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x11}}</dt> </dl> </td> <td width="60%">
    ///EAPHost could not find a certificate in a trusted root certificate store for user certification validation. </td>
    ///</tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_Server_Root_CertNameRequired"></a><a
    ///id="guid_eaphost_cause_server_root_certnamerequired"></a><a
    ///id="GUID_EAPHOST_CAUSE_SERVER_ROOT_CERTNAMEREQUIRED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Server_Root_CertNameRequired</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x12}}</dt> </dl> </td> <td width="60%"> The authentication failed because the certificate
    ///on the server computer does not have a server name specified. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_EapNegotiationFailed"></a><a id="guid_eaphost_cause_eapnegotiationfailed"></a><a
    ///id="GUID_EAPHOST_CAUSE_EAPNEGOTIATIONFAILED"></a><dl> <dt><b>GUID_EapHost_Cause_EapNegotiationFailed</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x1C}}</dt> </dl> </td> <td width="60%"> The
    ///authentication failed because Windows does not have the authentication method required for this network. </td>
    ///</tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_XmlMalformed"></a><a
    ///id="guid_eaphost_cause_xmlmalformed"></a><a id="GUID_EAPHOST_CAUSE_XMLMALFORMED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_XmlMalformed</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0,
    ///0, 0x1D}}</dt> </dl> </td> <td width="60%"> The EAPHost configuration schema validation failed. </td> </tr> <tr>
    ///<td width="40%"><a id="GUID_EapHost_Cause_MethodDoesNotSupportOperation"></a><a
    ///id="guid_eaphost_cause_methoddoesnotsupportoperation"></a><a
    ///id="GUID_EAPHOST_CAUSE_METHODDOESNOTSUPPORTOPERATION"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_MethodDoesNotSupportOperation</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x1E}}</dt> </dl> </td> <td width="60%"> EAPHost returns this error when a configured EAP
    ///method does not support a requested operation (procedure call). </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_No_SmartCardReader_Found"></a><a id="guid_eaphost_cause_no_smartcardreader_found"></a><a
    ///id="GUID_EAPHOST_CAUSE_NO_SMARTCARDREADER_FOUND"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_No_SmartCardReader_Found</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 0, 0x2B}}</dt> </dl> </td> <td width="60%"> A valid smart card needs to be present for authentication
    ///to be proceed. This GUID is supported on Windows Server 2008 R2 with the Wireless LAN Service installed and on
    ///Windows 7 . </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_Generic_AuthFailure"></a><a
    ///id="guid_eaphost_cause_generic_authfailure"></a><a id="GUID_EAPHOST_CAUSE_GENERIC_AUTHFAILURE"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Generic_AuthFailure</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8,
    ///0, 0, 1, 4}}</dt> </dl> </td> <td width="60%"> EAPHost returns this error on a generic, unspecified
    ///authentication failure. </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_Server_CertOtherError"></a><a
    ///id="guid_eaphost_cause_server_certothererror"></a><a id="GUID_EAPHOST_CAUSE_SERVER_CERTOTHERERROR"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Server_CertOtherError</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 1, 8}}</dt> </dl> </td> <td width="60%"> An unknown error occurred with the server certificate. </td>
    ///</tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_Account_OtherProblem"></a><a
    ///id="guid_eaphost_cause_user_account_otherproblem"></a><a
    ///id="GUID_EAPHOST_CAUSE_USER_ACCOUNT_OTHERPROBLEM"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_Account_OtherProblem</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 1, 0xE}}</dt> </dl> </td> <td width="60%"> An EAP failure was received after an identity exchange,
    ///indicating the likelihood of a problem with the authenticating user's account. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Cause_Server_Root_CertNotFound"></a><a
    ///id="guid_eaphost_cause_server_root_certnotfound"></a><a id="GUID_EAPHOST_CAUSE_SERVER_ROOT_CERTNOTFOUND"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Server_Root_CertNotFound</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 1, 0x12}}</dt> </dl> </td> <td width="60%"> EAPHost could not find a root certificate in a trusted
    ///root certificate store for the server certification validation. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_IdentityUnknown"></a><a id="guid_eaphost_cause_identityunknown"></a><a
    ///id="GUID_EAPHOST_CAUSE_IDENTITYUNKNOWN"></a><dl> <dt><b>GUID_EapHost_Cause_IdentityUnknown</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 2, 4}}</dt> </dl> </td> <td width="60%"> EAPHost
    ///returns this error if the authenticator fails the authentication after the peer identity was submitted. </td>
    ///</tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_CredsRejected"></a><a
    ///id="guid_eaphost_cause_user_credsrejected"></a><a id="GUID_EAPHOST_CAUSE_USER_CREDSREJECTED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CredsRejected</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8,
    ///0, 0, 2, 0xE}}</dt> </dl> </td> <td width="60%"> The authenticator rejected user credentials for authentication.
    ///</td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_ThirdPartyMethod_Host_Reset"></a><a
    ///id="guid_eaphost_cause_thirdpartymethod_host_reset"></a><a
    ///id="GUID_EAPHOST_CAUSE_THIRDPARTYMETHOD_HOST_RESET"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_ThirdPartyMethod_Host_Reset</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 2, 0x12}}</dt> </dl> </td> <td width="60%"> The host of the third party method is not
    ///responding and was automatically restarted. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_EapQecInaccessible"></a><a id="guid_eaphost_cause_eapqecinaccessible"></a><a
    ///id="GUID_EAPHOST_CAUSE_EAPQECINACCESSIBLE"></a><dl> <dt><b>GUID_EapHost_Cause_EapQecInaccessible</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 3, 0x12}}</dt> </dl> </td> <td width="60%">
    ///EAPHost was not able to communicate with the EAP quarantine enforcement client (QEC) on a client with Network
    ///Access Protection (NAP) enabled. This error may occur when the NAP service is not responding. </td> </tr> <tr>
    ///<td width="40%"><a id="GUID_EapHost_Cause_Method_Config_Does_Not_Support_Sso"></a><a
    ///id="guid_eaphost_cause_method_config_does_not_support_sso"></a><a
    ///id="GUID_EAPHOST_CAUSE_METHOD_CONFIG_DOES_NOT_SUPPORT_SSO"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Method_Config_Does_Not_Support_Sso</b></dt> <dt>{0xda18bd32, 0x004f, 0x41fa, {0xae,
    ///0x08, 0x0b, 0xc8, 0x5e, 0x58, 0x45, 0xac}}</dt> </dl> </td> <td width="60%"> The EAP method does not support
    ///single signon for the provided configuration data. This GUID is supported on Windows Server 2008 R2 with the
    ///Wireless LAN Service installed and on Windows 7. </td> </tr> </table>
    GUID               rootCauseGuid;
    ///A unique ID that maps to a localizable string that identifies the repair action that can be taken to fix the
    ///reported error. The existing values for this member are defined in the <i>Eaphosterror.h</i> header file. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_ContactSysadmin"></a><a id="guid_eaphost_repair_contactsysadmin"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTSYSADMIN"></a><dl> <dt><b>GUID_EapHost_Repair_ContactSysadmin</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 2}}</dt> </dl> </td> <td width="60%"> The user
    ///should contact the network administrator. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_Server_ClientSelectServerCert"></a><a
    ///id="guid_eaphost_repair_server_clientselectservercert"></a><a
    ///id="GUID_EAPHOST_REPAIR_SERVER_CLIENTSELECTSERVERCERT"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_Server_ClientSelectServerCert</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x18}}</dt> </dl> </td> <td width="60%"> The user should choose a different and valid
    ///certificate for authentication with this network. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_User_AuthFailure"></a><a id="guid_eaphost_repair_user_authfailure"></a><a
    ///id="GUID_EAPHOST_REPAIR_USER_AUTHFAILURE"></a><dl> <dt><b>GUID_EapHost_Repair_User_AuthFailure</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x19}}</dt> </dl> </td> <td width="60%"> The
    ///user should contact your network administrator. Your administrator can verify your user name and password for
    ///network authentication. </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Repair_User_GetNewCert"></a><a
    ///id="guid_eaphost_repair_user_getnewcert"></a><a id="GUID_EAPHOST_REPAIR_USER_GETNEWCERT"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_User_GetNewCert</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0,
    ///0, 0, 0x1A}} </dt> </dl> </td> <td width="60%"> The user should obtain an updated certificate from the network
    ///administrator. The certificate required to connect to this network can't be found on your computer. </td> </tr>
    ///<tr> <td width="40%"><a id="GUID_EapHost_Repair_User_SelectValidCert"></a><a
    ///id="guid_eaphost_repair_user_selectvalidcert"></a><a id="GUID_EAPHOST_REPAIR_USER_SELECTVALIDCERT"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_User_SelectValidCert</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 0, 0x1B}} </dt> </dl> </td> <td width="60%"> The user should use a different and valid user
    ///certificate for authentication with the network. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_ContactAdmin_AuthFailure"></a><a id="guid_eaphost_repair_contactadmin_authfailure"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_AUTHFAILURE"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_AuthFailure</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 0, 0x1F}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator.
    ///Windows can't verify your identity for connection to this network. This GUID is supported on Windows Server 2008
    ///R2 with the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_ContactAdmin_IdentityUnknown"></a><a
    ///id="guid_eaphost_repair_contactadmin_identityunknown"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_IDENTITYUNKNOWN"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_IdentityUnknown</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x20}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator.
    ///Windows can't verify your identity for connection to this network. This GUID is supported on Windows Windows
    ///Server 2008 R2 with the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_ContactAdmin_NegotiationFailed"></a><a
    ///id="guid_eaphost_repair_contactadmin_negotiationfailed"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_NEGOTIATIONFAILED"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_NegotiationFailed</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x21}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator.
    ///Windows needs to be configured to use the authentication method required for this network. This GUID is supported
    ///on Windows Server 2008 R2 with the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Repair_ContactAdmin_MethodNotFound_"></a><a
    ///id="guid_eaphost_repair_contactadmin_methodnotfound_"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_METHODNOTFOUND_"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_MethodNotFound </b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x22}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator.
    ///Windows needs to be configured to use the authentication method required for this network. This GUID is supported
    ///on Windows Windows Server 2008 R2 with the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Repair_RestartNap"></a><a id="guid_eaphost_repair_restartnap"></a><a
    ///id="GUID_EAPHOST_REPAIR_RESTARTNAP"></a><dl> <dt><b>GUID_EapHost_Repair_RestartNap</b></dt> <dt>{0x9612fc67,
    ///0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x23}}</dt> </dl> </td> <td width="60%"> The user should start
    ///the Network Access Protection service. The Network Access Protection service is not responding. Start or restart
    ///the Network Access Protection service, and then try connecting again. This GUID is supported on Windows Server
    ///2008 R2 with the Wireless LAN Service installed and on Windows 7 . </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_ContactAdmin_CertStoreInaccessible"></a><a
    ///id="guid_eaphost_repair_contactadmin_certstoreinaccessible"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_CERTSTOREINACCESSIBLE"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_CertStoreInaccessible</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8,
    ///0x5e, 0xa8, 0xd8, 0, 0, 0, 0x24}}</dt> </dl> </td> <td width="60%"> The user should contact your network
    ///administrator. The certificate store on this computer needs to be repaired. This GUID is supported on Windows
    ///Windows Server 2008 R2 with the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Repair_ContactAdmin_InvalidUserAccount"></a><a
    ///id="guid_eaphost_repair_contactadmin_invaliduseraccount"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_INVALIDUSERACCOUNT"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_InvalidUserAccount</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x25}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator.
    ///A problem with your user account needs to be resolved. This GUID is supported on Windows Server 2008 R2 with the
    ///Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_ContactAdmin_RootCertInvalid"></a><a
    ///id="guid_eaphost_repair_contactadmin_rootcertinvalid"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_ROOTCERTINVALID"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_RootCertInvalid</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x26}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator.
    ///The root certificate used for this network needs to be repaired. This GUID is supported on Windows Server 2008 R2
    ///with the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_ContactAdmin_RootCertNotFound"></a><a
    ///id="guid_eaphost_repair_contactadmin_rootcertnotfound"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_ROOTCERTNOTFOUND"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_RootCertNotFound</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x27}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator.
    ///The certificate used by the server for this network needs to be properly installed on your computer. This GUID is
    ///supported on Windows Server 2008 R2 with the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr>
    ///<td width="40%"><a id="GUID_EapHost_Repair_ContactAdmin_RootExpired"></a><a
    ///id="guid_eaphost_repair_contactadmin_rootexpired"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_ROOTEXPIRED"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_RootExpired</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 0, 0x28}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator. The
    ///root certificate used for this network needs to be renewed. This GUID is supported on Windows Server 2008 R2 with
    ///the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_ContactAdmin_CertNameAbsent"></a><a
    ///id="guid_eaphost_repair_contactadmin_certnameabsent"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_CERTNAMEABSENT"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_CertNameAbsent</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x29}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator.
    ///A problem with the server certificate used for this network needs to be resolved. This GUID is supported on
    ///Windows Server 2008 R2 with the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Repair_ContactAdmin_NoSmartCardReader"></a><a
    ///id="guid_eaphost_repair_contactadmin_nosmartcardreader"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_NOSMARTCARDREADER"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_NoSmartCardReader</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x2A}}</dt> </dl> </td> <td width="60%"> The user should connect a smart card reader to your
    ///computer, insert a smart card, and attempt to connect again. This GUID is supported on Windows Server 2008 R2
    ///with the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_ContactAdmin_InvalidUserCert"></a><a
    ///id="guid_eaphost_repair_contactadmin_invalidusercert"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTADMIN_INVALIDUSERCERT"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_ContactAdmin_InvalidUserCert</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x2C}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator.
    ///The user certificate on this computer needs to be repaired. This GUID is supported on Windows Server 2008 R2 with
    ///the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_Method_Not_Support_Sso"></a><a id="guid_eaphost_repair_method_not_support_sso"></a><a
    ///id="GUID_EAPHOST_REPAIR_METHOD_NOT_SUPPORT_SSO"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_Method_Not_Support_Sso</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 0, 0x2D}}</dt> </dl> </td> <td width="60%"> The user should contact your network administrator.
    ///Windows needs to be configured to use the authentication method required for this network. This GUID is supported
    ///on Windows Server 2008 R2 with the Wireless LAN Service installed and on Windows 7. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Repair_Retry_Authentication"></a><a
    ///id="guid_eaphost_repair_retry_authentication"></a><a id="GUID_EAPHOST_REPAIR_RETRY_AUTHENTICATION"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_Retry_Authentication</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 1, 0x1B}}</dt> </dl> </td> <td width="60%"> The user should try to connect to the network again.
    ///</td> </tr> </table>
    GUID               repairGuid;
    ///A unique ID that maps to a localizable string that specifies an URL for a page that contains additional
    ///information about an error or repair message. An EAP method can potentially define a new GUID and associate with
    ///one specific help link. Some of the existing values for this member are defined in the <i>Eaphosterror.h</i>
    ///header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Help_Troubleshooting"></a><a id="guid_eaphost_help_troubleshooting"></a><a
    ///id="GUID_EAPHOST_HELP_TROUBLESHOOTING"></a><dl> <dt><b>GUID_EapHost_Help_Troubleshooting</b></dt>
    ///<dt>{0x33307acf, 0x0698, 0x41ba, {0xb0, 0x14, 0xea, 0x0a, 0x2e, 0xb8, 0xd0, 0xa8}}</dt> </dl> </td> <td
    ///width="60%"> The URL for the page with more information about troubleshooting. This currently is a generic
    ///networking troubleshooting help page, not EAP specific. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Help_EapConfigureTypes"></a><a id="guid_eaphost_help_eapconfiguretypes"></a><a
    ///id="GUID_EAPHOST_HELP_EAPCONFIGURETYPES"></a><dl> <dt><b>GUID_EapHost_Help_EapConfigureTypes</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x03}}</dt> </dl> </td> <td width="60%"> The
    ///URL for the page with more information about configuring EAP types. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Help_FailedAuth"></a><a id="guid_eaphost_help_failedauth"></a><a
    ///id="GUID_EAPHOST_HELP_FAILEDAUTH"></a><dl> <dt><b>GUID_EapHost_Help_FailedAuth</b></dt> <dt>{0x9612fc67, 0x6150,
    ///0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x13}}</dt> </dl> </td> <td width="60%"> The URL for the page with more
    ///information about authentication failures. This GUID is supported on Windows Vista </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Help_SelectingCerts"></a><a id="guid_eaphost_help_selectingcerts"></a><a
    ///id="GUID_EAPHOST_HELP_SELECTINGCERTS"></a><dl> <dt><b>GUID_EapHost_Help_SelectingCerts</b></dt> <dt>{0x9612fc67,
    ///0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x15}}</dt> </dl> </td> <td width="60%"> The URL for the page
    ///with more information about selecting the appropriate certificate to use for authentication. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Help_SetupEapServer"></a><a id="guid_eaphost_help_setupeapserver"></a><a
    ///id="GUID_EAPHOST_HELP_SETUPEAPSERVER"></a><dl> <dt><b>GUID_EapHost_Help_SetupEapServer</b></dt> <dt>{0x9612fc67,
    ///0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x16}}</dt> </dl> </td> <td width="60%"> The URL for the page
    ///with more information about setting up an EAP server. This GUID is supported on Windows Vista </td> </tr> <tr>
    ///<td width="40%"><a id="GUID_EapHost_Help_Troubleshooting"></a><a id="guid_eaphost_help_troubleshooting"></a><a
    ///id="GUID_EAPHOST_HELP_TROUBLESHOOTING"></a><dl> <dt><b>GUID_EapHost_Help_Troubleshooting</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x17}}</dt> </dl> </td> <td width="60%"> The
    ///URL for the page with more information about troubleshooting. This GUID is supported on Windows Vista </td> </tr>
    ///<tr> <td width="40%"><a id="GUID_EapHost_Help_ObtainingCerts"></a><a id="guid_eaphost_help_obtainingcerts"></a><a
    ///id="GUID_EAPHOST_HELP_OBTAININGCERTS"></a><dl> <dt><b>GUID_EapHost_Help_ObtainingCerts</b></dt> <dt>{0xf535eea3,
    ///0x1bdd, 0x46ca, {0xa2, 0xfc, 0xa6, 0x65, 0x59, 0x39, 0xb7, 0xe8}}</dt> </dl> </td> <td width="60%"> The URL for
    ///the page with more information about getting EAP certificates. </td> </tr> </table>
    GUID               helpLinkGuid;
    uint               _bitfield87;
    ///A localized and readable string that describes the root cause of the error. This member contains a
    ///NULL-terminated Unicode string starting at the <b>dwOffset</b> member of the ONEX_VARIABLE_BLOB if the
    ///<b>fRootCauseString</b> bitfield member is set.
    ONEX_VARIABLE_BLOB RootCauseString;
    ///A localized and readable string that describes the possible repair action. This member contains a NULL-terminated
    ///Unicode string starting at the <b>dwOffset</b> member of the ONEX_VARIABLE_BLOB if the <b>fRepairString</b>
    ///bitfield member is set.
    ONEX_VARIABLE_BLOB RepairString;
}

///The <b>ONEX_STATUS</b> structure contains the current 802.1X authentication status.
struct ONEX_STATUS
{
    ///The current status of the 802.1X authentication process. Any error that may have occurred during authentication
    ///is indicated below by the value of the <b>dwReason</b> and <b>dwError</b> members of the <b>ONEX_STATUS</b>
    ///structure. For more information, see the ONEX_AUTH_STATUS enumeration.
    ONEX_AUTH_STATUS authStatus;
    ///If an error occurred during 802.1X authentication, this member contains the reason for the error specified as a
    ///value from the ONEX_REASON_CODE enumeration. This member is normally <b>ONEX_REASON_CODE_SUCCESS</b> when 802.1X
    ///authentication is successful and no error occurs.
    uint             dwReason;
    ///If an error occurred during 802.1X authentication, this member contains the error. This member is normally
    ///NO_ERROR, except when an EAPHost error occurs.
    uint             dwError;
}

///The <b>ONEX_RESULT_UPDATE_DATA</b> structure contains information on a status change to 802.1X authentication.
struct ONEX_RESULT_UPDATE_DATA
{
    ///Specifies the current 802.1X authentication status. For more information, see the ONEX_STATUS structure.
    ONEX_STATUS        oneXStatus;
    ///Indicates if the configured EAP method on the supplicant is supported on the 802.1X authentication server. EAP
    ///permits the use of a backend authentication server, which may implement some or all authentication methods, with
    ///the authenticator acting as a pass-through for some or all methods and peers. For more information, see RFC 3748
    ///published by the IETF and the ONEX_EAP_METHOD_BACKEND_SUPPORT enumeration.
    ONEX_EAP_METHOD_BACKEND_SUPPORT BackendSupport;
    ///Indicates if a response was received from the 802.1X authentication server.
    BOOL               fBackendEngaged;
    uint               _bitfield88;
    ///The 802.1X authentication parameters. This member contains an embedded ONEX_AUTH_PARAMS structure starting at the
    ///<b>dwOffset</b> member of the ONEX_VARIABLE_BLOB if the <b>fOneXAuthParams</b> bitfield member is set.
    ONEX_VARIABLE_BLOB authParams;
    ///An EAP error value. This member contains an embedded ONEX_EAP_ERROR structure starting at the <b>dwOffset</b>
    ///member of the ONEX_VARIABLE_BLOB if the <b>fEapError</b> bitfield member is set.
    ONEX_VARIABLE_BLOB eapError;
}

struct ONEX_USER_INFO
{
    ONEX_AUTH_IDENTITY authIdentity;
    uint               _bitfield89;
    ONEX_VARIABLE_BLOB UserName;
    ONEX_VARIABLE_BLOB DomainName;
}

// Functions

///The <b>WlanOpenHandle</b> function opens a connection to the server.
///Params:
///    dwClientVersion = The highest version of the WLAN API that the client supports. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///                      <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Client version for Windows XP with SP3 and
///                      Wireless LAN API for Windows XP with SP2. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td
///                      width="60%"> Client version for Windows Vista and Windows Server 2008 </td> </tr> </table>
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    pdwNegotiatedVersion = The version of the WLAN API that will be used in this session. This value is usually the highest version
///                           supported by both the client and server.
///    phClientHandle = A handle for the client to use in this session. This handle is used by other functions throughout the session.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>pdwNegotiatedVersion</i> is
///    <b>NULL</b>, <i>phClientHandle</i> is <b>NULL</b>, or <i>pReserved</i> is not <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate memory
///    to create the client context. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_REMOTE_SESSION_LIMIT_EXCEEDED</b></dt> </dl> </td> <td width="60%"> Too many handles have been
///    issued by the server. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanOpenHandle(uint dwClientVersion, void* pReserved, uint* pdwNegotiatedVersion, ptrdiff_t* phClientHandle);

///The <b>WlanCloseHandle</b> function closes a connection to the server.
///Params:
///    hClientHandle = The client's session handle, which identifies the connection to be closed. This handle was obtained by a previous
///                    call to the WlanOpenHandle function.
///    pReserved = Reserved for future use. Set this parameter to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    invalid, or <i>pReserved</i> is not <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle <i>hClientHandle</i> was not found
///    in the handle table. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanCloseHandle(HANDLE hClientHandle, void* pReserved);

///The <b>WlanEnumInterfaces</b> function enumerates all of the wireless LAN interfaces currently enabled on the local
///computer.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pReserved = Reserved for future use. This parameter must be set to <b>NULL</b>.
///    ppInterfaceList = A pointer to storage for a pointer to receive the returned list of wireless LAN interfaces in a
///                      WLAN_INTERFACE_INFO_LIST structure. The buffer for the WLAN_INTERFACE_INFO_LIST returned is allocated by the
///                      <b>WlanEnumInterfaces</b> function if the call succeeds.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if the <i>hClientHandle</i> or <i>ppInterfaceList</i> parameter is <b>NULL</b>. This error is returned
///    if the <i>pReserved</i> is not <b>NULL</b>. This error is also returned if the <i>hClientHandle</i> parameter is
///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The handle <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is
///    available to process this request and allocate memory for the query results. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanEnumInterfaces(HANDLE hClientHandle, void* pReserved, WLAN_INTERFACE_INFO_LIST** ppInterfaceList);

///The <b>WlanSetAutoConfigParameter</b> function sets parameters for the automatic configuration service.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    OpCode = A WLAN_AUTOCONF_OPCODE value that specifies the parameter to be set. Only some of the opcodes in the
///             <b>WLAN_AUTOCONF_OPCODE</b> enumeration support set operations. <table> <tr> <th>Value</th> <th>Meaning</th>
///             </tr> <tr> <td width="40%"><a id="wlan_autoconf_opcode_show_denied_networks"></a><a
///             id="WLAN_AUTOCONF_OPCODE_SHOW_DENIED_NETWORKS"></a><dl> <dt><b>wlan_autoconf_opcode_show_denied_networks</b></dt>
///             </dl> </td> <td width="60%"> When set, the <i>pData</i> parameter will contain a <b>BOOL</b> value indicating
///             whether user and group policy-denied networks will be included in the available networks list. </td> </tr> <tr>
///             <td width="40%"><a id="wlan_autoconf_opcode_allow_explicit_creds"></a><a
///             id="WLAN_AUTOCONF_OPCODE_ALLOW_EXPLICIT_CREDS"></a><dl> <dt><b>wlan_autoconf_opcode_allow_explicit_creds</b></dt>
///             </dl> </td> <td width="60%"> When set, the <i>pData</i> parameter will contain a <b>BOOL</b> value indicating
///             whether the current wireless interface has shared user credentials allowed. </td> </tr> <tr> <td width="40%"><a
///             id="wlan_autoconf_opcode_block_period"></a><a id="WLAN_AUTOCONF_OPCODE_BLOCK_PERIOD"></a><dl>
///             <dt><b>wlan_autoconf_opcode_block_period</b></dt> </dl> </td> <td width="60%"> When set, the <i>pData</i>
///             parameter will contain a <b>DWORD</b> value for the blocked period setting for the current wireless interface.
///             The blocked period is the amount of time, in seconds, for which automatic connection to a wireless network will
///             not be attempted after a previous failure. </td> </tr> <tr> <td width="40%"><a
///             id="wlan_autoconf_opcode_allow_virtual_station_extensibility"></a><a
///             id="WLAN_AUTOCONF_OPCODE_ALLOW_VIRTUAL_STATION_EXTENSIBILITY"></a><dl>
///             <dt><b>wlan_autoconf_opcode_allow_virtual_station_extensibility</b></dt> </dl> </td> <td width="60%"> When set,
///             the <i>pData</i> parameter will contain a <b>BOOL</b> value indicating whether extensibility on a virtual station
///             is allowed. By default, extensibility on a virtual station is allowed. The value for this opcode is persisted
///             across restarts. This enumeration value is supported on Windows 7 and on Windows Server 2008 R2 with the Wireless
///             LAN Service installed. </td> </tr> </table>
///    dwDataSize = The size of the <i>pData</i> parameter, in bytes. This parameter must be set to <code>sizeof(BOOL)</code> for a
///                 BOOL or <code>sizeof(DWORD)</code> for a DWORD, depending on the value of the <i>OpCode</i> parameter.
///    pData = The value to be set for the parameter specified in <i>OpCode</i> parameter. The <i>pData</i> parameter must point
///            to a boolean or DWORD value, depending on the value of the <i>OpCode</i> parameter. The <i>pData</i> parameter
///            must not be <b>NULL</b>. <div class="alert"><b>Note</b> The <i>pData</i> parameter may point to an integer value
///            when a boolean is required. If <i>pData</i> points to 0, then the value is converted to <b>FALSE</b>. If
///            <i>pData</i> points to a nonzero integer, then the value is converted to <b>TRUE</b>. </div> <div> </div>
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned if
///    the caller does not have sufficient permissions to set the configuration parameter when the <i>OpCode</i>
///    parameter is wlan_autoconf_opcode_show_denied_networks or
///    wlan_autoconf_opcode_allow_virtual_station_extensibility. When the <i>OpCode</i> parameter is set to one of these
///    values, the WlanSetAutoConfigParameter function retrieves the discretionary access control list (DACL) stored for
///    opcode object. If the DACL does not contain an access control entry (ACE) that grants WLAN_WRITE_ACCESS
///    permission to the access token of the calling thread, then <b>WlanSetAutoConfigParameter</b> returns
///    <b>ERROR_ACCESS_DENIED</b>. This error is also returned if the configuration parameter is set by group policy on
///    a domain. When group policy is set for an opcode, applications are prevented from making changes. For the
///    following <i>OpCode</i> parameters may be set by group policy: wlan_autoconf_opcode_show_denied_networks,
///    wlan_autoconf_opcode_allow_explicit_creds, and wlan_autoconf_opcode_block_period </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter was bad. This
///    error is returned if the <i>hClientHandle</i> parameter is <b>NULL</b>, the <i>pData</i> parameter is
///    <b>NULL</b>, or the <i>pReserved</i> parameter is not <b>NULL</b>. This error is also returned if <i>OpCode</i>
///    parameter specified is not one of the WLAN_AUTOCONF_OPCODE values for a configuration parameter that can be set.
///    This error is also returned if the <i>dwDataSize</i> parameter is not set to <code>sizeof(BOOL)</code>, or the
///    <i>dwDataSize</i> is not set to <code>sizeof(BOOL)</code> depending on the value of the <i>OpCode</i> parameter.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    handle <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function was called from an unsupported
///    platform. This value will be returned if this function was called from a Windows XP with SP3 or Wireless LAN API
///    for Windows XP with SP2 client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanSetAutoConfigParameter(HANDLE hClientHandle, WLAN_AUTOCONF_OPCODE OpCode, uint dwDataSize, char* pData, 
                                void* pReserved);

///The <b>WlanQueryAutoConfigParameter</b> function queries for the parameters of the auto configuration service.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    OpCode = A value that specifies the configuration parameter to be queried. <table> <tr> <th>Value</th> <th>Meaning</th>
///             </tr> <tr> <td width="40%"><a id="wlan_autoconf_opcode_show_denied_networks"></a><a
///             id="WLAN_AUTOCONF_OPCODE_SHOW_DENIED_NETWORKS"></a><dl> <dt><b>wlan_autoconf_opcode_show_denied_networks</b></dt>
///             </dl> </td> <td width="60%"> When set, the <i>ppData</i> parameter will contain a <b>BOOL</b> value indicating
///             whether user and group policy-denied networks will be included in the available networks list. If the function
///             returns ERROR_SUCCESS and <i>ppData</i> points to <b>TRUE</b>, then user and group policy-denied networks will be
///             included in the available networks list; if <b>FALSE</b>, user and group policy-denied networks will not be
///             included in the available networks list. </td> </tr> <tr> <td width="40%"><a
///             id="wlan_autoconf_opcode_power_setting"></a><a id="WLAN_AUTOCONF_OPCODE_POWER_SETTING"></a><dl>
///             <dt><b>wlan_autoconf_opcode_power_setting</b></dt> </dl> </td> <td width="60%"> When set, the <i>ppData</i>
///             parameter will contain a WLAN_POWER_SETTING value specifying the power settings. </td> </tr> <tr> <td
///             width="40%"><a id="wlan_autoconf_opcode_only_use_gp_profiles_for_allowed_networks"></a><a
///             id="WLAN_AUTOCONF_OPCODE_ONLY_USE_GP_PROFILES_FOR_ALLOWED_NETWORKS"></a><dl>
///             <dt><b>wlan_autoconf_opcode_only_use_gp_profiles_for_allowed_networks</b></dt> </dl> </td> <td width="60%"> When
///             set, the <i>ppData</i> parameter will contain a <b>BOOL</b> value indicating whether profiles not created by
///             group policy can be used to connect to an allowed network with a matching group policy profile. If the function
///             returns ERROR_SUCCESS and <i>ppData</i> points to <b>TRUE</b>, then only profiles created by group policy can be
///             used; if <b>FALSE</b>, any profile can be used. </td> </tr> <tr> <td width="40%"><a
///             id="wlan_autoconf_opcode_allow_explicit_creds"></a><a id="WLAN_AUTOCONF_OPCODE_ALLOW_EXPLICIT_CREDS"></a><dl>
///             <dt><b>wlan_autoconf_opcode_allow_explicit_creds</b></dt> </dl> </td> <td width="60%"> When set, the
///             <i>ppData</i> parameter will contain a <b>BOOL</b> value indicating whether the current wireless interface has
///             shared user credentials allowed. If the function returns ERROR_SUCCESS and <i>ppData</i> points to <b>TRUE</b>,
///             then the current wireless interface has shared user credentials allowed; if <b>FALSE</b>, the current wireless
///             interface does not allow shared user credentials. </td> </tr> <tr> <td width="40%"><a
///             id="wlan_autoconf_opcode_block_period"></a><a id="WLAN_AUTOCONF_OPCODE_BLOCK_PERIOD"></a><dl>
///             <dt><b>wlan_autoconf_opcode_block_period</b></dt> </dl> </td> <td width="60%"> When set, the <i>ppData</i>
///             parameter will contain a <b>DWORD</b> value that indicates the blocked period setting for the current wireless
///             interface. The blocked period is the amount of time, in seconds, for which automatic connection to a wireless
///             network will not be attempted after a previous failure. </td> </tr> <tr> <td width="40%"><a
///             id="wlan_autoconf_opcode_allow_virtual_station_extensibility"></a><a
///             id="WLAN_AUTOCONF_OPCODE_ALLOW_VIRTUAL_STATION_EXTENSIBILITY"></a><dl>
///             <dt><b>wlan_autoconf_opcode_allow_virtual_station_extensibility</b></dt> </dl> </td> <td width="60%"> When set,
///             the <i>ppData</i> parameter will contain a <b>BOOL</b> value indicating whether extensibility on a virtual
///             station is allowed. By default, extensibility on a virtual station is allowed. The value for this opcode is
///             persisted across restarts. If the function returns ERROR_SUCCESS and <i>ppData</i> points to <b>TRUE</b>, then
///             extensibility on a virtual station is allowed; if <b>FALSE</b>, extensibility on a virtual station is not
///             allowed. </td> </tr> </table>
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    pdwDataSize = Specifies the size of the <i>ppData</i> parameter, in bytes.
///    ppData = Pointer to the memory that contains the queried value for the parameter specified in <i>OpCode</i>. <div
///             class="alert"><b>Note</b> If <i>OpCode</i> is set to <b>wlan_autoconf_opcode_show_denied_networks</b>, then the
///             pointer referenced by <i>ppData</i> may point to an integer value. If the pointer referenced by <i>ppData</i>
///             points to 0, then the integer value should be converted to the boolean value <b>FALSE</b>. If the pointer
///             referenced by <i>ppData</i> points to a nonzero integer, then the integer value should be converted to the
///             boolean value <b>TRUE</b>. </div> <div> </div>
///    pWlanOpcodeValueType = A WLAN_OPCODE_VALUE_TYPE value.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient
///    permissions to get configuration parameters. When called with <i>OpCode</i> set to
///    <b>wlan_autoconf_opcode_show_denied_networks</b>, WlanQueryAutoConfigParameter retrieves the discretionary access
///    control list (DACL) stored with the <b>wlan_secure_show_denied</b> object. If the DACL does not contain an access
///    control entry (ACE) that grants WLAN_READ_ACCESS permission to the access token of the calling thread, then
///    <b>WlanQueryAutoConfigParameter</b> returns <b>ERROR_ACCESS_DENIED</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    invalid, <i>pReserved</i> is not <b>NULL</b>, <i>ppData</i> is <b>NULL</b>, or <i>pdwDataSize</i> is <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    handle <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function was called from an unsupported
///    platform. This value will be returned if this function was called from a Windows XP with SP3 or Wireless LAN API
///    for Windows XP with SP2 client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanQueryAutoConfigParameter(HANDLE hClientHandle, WLAN_AUTOCONF_OPCODE OpCode, void* pReserved, 
                                  uint* pdwDataSize, void** ppData, WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType);

///The <b>WlanGetInterfaceCapability</b> function retrieves the capabilities of an interface.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of this interface.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    ppCapability = A WLAN_INTERFACE_CAPABILITY structure that contains information about the capabilities of the specified
///                   interface.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    invalid, <i>pInterfaceGuid</i> is <b>NULL</b>, <i>pReserved</i> is not <b>NULL</b>, or <i>ppCapability</i> is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The handle <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function was called from an
///    unsupported platform. This value will be returned if this function was called from a Windows XP with SP3 or
///    Wireless LAN API for Windows XP with SP2 client. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanGetInterfaceCapability(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, void* pReserved, 
                                WLAN_INTERFACE_CAPABILITY** ppCapability);

///The <b>WlanSetInterface</b> function sets user-configurable parameters for a specified interface.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface to be configured.
///    OpCode = A WLAN_INTF_OPCODE value that specifies the parameter to be set. The following table lists the valid constants
///             along with the data type of the parameter in <i>pData</i>. <table> <tr> <th><b>WLAN_INTF_OPCODE</b> value</th>
///             <th><i>pData</i> data type</th> <th>Description</th> </tr> <tr> <td> <b>wlan_intf_opcode_autoconf_enabled</b>
///             </td> <td><b>BOOL</b></td> <td> Enables or disables auto config for the indicated interface. </td> </tr> <tr>
///             <td> <b>wlan_intf_opcode_background_scan_enabled</b> </td> <td><b>BOOL</b></td> <td> Enables or disables
///             background scan for the indicated interface. </td> </tr> <tr> <td> <b>wlan_intf_opcode_radio_state</b> </td> <td>
///             WLAN_PHY_RADIO_STATE </td> <td> Sets the software radio state of a specific physical layer (PHY) for the
///             interface. </td> </tr> <tr> <td> <b>wlan_intf_opcode_bss_type</b> </td> <td> DOT11_BSS_TYPE </td> <td> Sets the
///             BSS type. </td> </tr> <tr> <td> <b>wlan_intf_opcode_media_streaming_mode</b> </td> <td><b>BOOL</b></td> <td> Sets
///             media streaming mode for the driver. </td> </tr> <tr> <td> <b>wlan_intf_opcode_current_operation_mode</b> </td>
///             <td><b>ULONG</b></td> <td> Sets the current operation mode for the interface. For more information, see Remarks.
///             </td> </tr> </table> <b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2: </b>Only the
///             <b>wlan_intf_opcode_autoconf_enabled</b> and <b>wlan_intf_opcode_bss_type</b> constants are valid.
///    dwDataSize = The size of the <i>pData</i> parameter, in bytes. If <i>dwDataSize</i> is larger than the actual amount of memory
///                 allocated to <i>pData</i>, then an access violation will occur in the calling program.
///    pData = The value to be set as specified by the <i>OpCode</i> parameter. The type of data pointed to by <i>pData</i> must
///            be appropriate for the specified <i>OpCode</i>. Use the table above to determine the type of data to use. <div
///            class="alert"><b>Note</b> If <i>OpCode</i> is set to <b>wlan_intf_opcode_autoconf_enabled</b>,
///            <b>wlan_intf_opcode_background_scan_enabled</b>, or <b>wlan_intf_opcode_media_streaming_mode</b>, then
///            <i>pData</i> may point to an integer value. If <i>pData</i> points to 0, then the value is converted to
///            <b>FALSE</b>. If <i>pData</i> points to a nonzero integer, then the value is converted to <b>TRUE</b>. </div>
///            <div> </div>
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes.
///    
@DllImport("wlanapi")
uint WlanSetInterface(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, WLAN_INTF_OPCODE OpCode, uint dwDataSize, 
                      char* pData, void* pReserved);

///The <b>WlanQueryInterface</b> function queries various parameters of a specified interface.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface to be queried.
///    OpCode = A WLAN_INTF_OPCODE value that specifies the parameter to be queried. The following table lists the valid
///             constants along with the data type of the parameter in <i>ppData</i>. <table> <tr> <th><b>WLAN_INTF_OPCODE</b>
///             value</th> <th><i>ppData</i> data type</th> </tr> <tr> <td>wlan_intf_opcode_autoconf_enabled</td> <td>BOOL</td>
///             </tr> <tr> <td>wlan_intf_opcode_background_scan_enabled </td> <td>BOOL</td> </tr> <tr>
///             <td>wlan_intf_opcode_radio_state </td> <td> WLAN_RADIO_STATE </td> </tr> <tr> <td>wlan_intf_opcode_bss_type </td>
///             <td> DOT11_BSS_TYPE </td> </tr> <tr> <td>wlan_intf_opcode_interface_state </td> <td> WLAN_INTERFACE_STATE </td>
///             </tr> <tr> <td>wlan_intf_opcode_current_connection </td> <td> WLAN_CONNECTION_ATTRIBUTES </td> </tr> <tr>
///             <td>wlan_intf_opcode_channel_number </td> <td>ULONG</td> </tr> <tr>
///             <td>wlan_intf_opcode_supported_infrastructure_auth_cipher_pairs </td> <td> WLAN_AUTH_CIPHER_PAIR_LIST </td> </tr>
///             <tr> <td>wlan_intf_opcode_supported_adhoc_auth_cipher_pairs </td> <td> WLAN_AUTH_CIPHER_PAIR_LIST </td> </tr>
///             <tr> <td>wlan_intf_opcode_supported_country_or_region_string_list </td> <td> WLAN_COUNTRY_OR_REGION_STRING_LIST
///             </td> </tr> <tr> <td>wlan_intf_opcode_media_streaming_mode </td> <td>BOOL</td> </tr> <tr>
///             <td>wlan_intf_opcode_statistics </td> <td> WLAN_STATISTICS </td> </tr> <tr> <td>wlan_intf_opcode_rssi</td>
///             <td>LONG</td> </tr> <tr> <td>wlan_intf_opcode_current_operation_mode </td> <td>ULONG</td> </tr> <tr>
///             <td>wlan_intf_opcode_supported_safe_mode</td> <td>BOOL</td> </tr> <tr>
///             <td>wlan_intf_opcode_certified_safe_mode</td> <td>BOOL</td> </tr> </table> <b>Windows XP with SP3 and Wireless
///             LAN API for Windows XP with SP2: </b>Only the <b>wlan_intf_opcode_autoconf_enabled</b>,
///             <b>wlan_intf_opcode_bss_type</b>, <b>wlan_intf_opcode_interface_state</b>, and
///             <b>wlan_intf_opcode_current_connection</b> constants are valid.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    pdwDataSize = The size of the <i>ppData</i> parameter, in bytes.
///    ppData = Pointer to the memory location that contains the queried value of the parameter specified by the <i>OpCode</i>
///             parameter. <div class="alert"><b>Note</b> If <i>OpCode</i> is set to <b>wlan_intf_opcode_autoconf_enabled</b>,
///             <b>wlan_intf_opcode_background_scan_enabled</b>, or <b>wlan_intf_opcode_media_streaming_mode</b>, then the
///             pointer referenced by <i>ppData</i> may point to an integer value. If the pointer referenced by <i>ppData</i>
///             points to 0, then the integer value should be converted to the boolean value <b>FALSE</b>. If the pointer
///             referenced by <i>ppData</i> points to a nonzero integer, then the integer value should be converted to the
///             boolean value <b>TRUE</b>. </div> <div> </div>
///    pWlanOpcodeValueType = If passed a non-<b>NULL</b> value, points to a WLAN_OPCODE_VALUE_TYPE value that specifies the type of opcode
///                           returned. This parameter may be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes.
///    
@DllImport("wlanapi")
uint WlanQueryInterface(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, WLAN_INTF_OPCODE OpCode, 
                        void* pReserved, uint* pdwDataSize, void** ppData, 
                        WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType);

///The <b>WlanIhvControl</b> function provides a mechanism for independent hardware vendor (IHV) control of WLAN drivers
///or services.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface.
///    Type = A WLAN_IHV_CONTROL_TYPE structure that specifies the type of software bypassed by the IHV control function.
///    dwInBufferSize = The size, in bytes, of the input buffer.
///    pInBuffer = A generic buffer for driver or service interface input.
///    dwOutBufferSize = The size, in bytes, of the output buffer.
///    pOutBuffer = A generic buffer for driver or service interface output.
///    pdwBytesReturned = The number of bytes returned.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient
///    permissions to perform this operation. When called, WlanIhvControl retrieves the discretionary access control
///    list (DACL) stored with the <b>wlan_secure_ihv_control</b> object. If the DACL does not contain an access control
///    entry (ACE) that grants WLAN_WRITE_ACCESS permission to the access token of the calling thread, then
///    <b>WlanIhvControl</b> returns <b>ERROR_ACCESS_DENIED</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    invalid, <i>pInterfaceGuid</i> is <b>NULL</b>, or <i>pdwBytesReturned</i> is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle
///    <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function was called from an unsupported
///    platform. This value will be returned if this function was called from a Windows XP with SP3 or Wireless LAN API
///    for Windows XP with SP2 client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanIhvControl(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, WLAN_IHV_CONTROL_TYPE Type, 
                    uint dwInBufferSize, char* pInBuffer, uint dwOutBufferSize, char* pOutBuffer, 
                    uint* pdwBytesReturned);

///The <b>WlanScan</b> function requests a scan for available networks on the indicated interface.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface to be queried. The GUID of each wireless LAN interface enabled on a local computer can
///                     be determined using the WlanEnumInterfaces function.
///    pDot11Ssid = A pointer to a DOT11_SSID structure that specifies the SSID of the network to be scanned. This parameter is
///                 optional. When set to <b>NULL</b>, the returned list contains all available networks. <b>Windows XP with SP3 and
///                 Wireless LAN API for Windows XP with SP2: </b>This parameter must be <b>NULL</b>.
///    pIeData = A pointer to an information element to include in probe requests. This parameter points to a WLAN_RAW_DATA
///              structure that may include client provisioning availability information and 802.1X authentication
///              requirements.<b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2: </b>This parameter must be
///              <b>NULL</b>.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    invalid, <i>pInterfaceGuid</i> is <b>NULL</b>, or <i>pReserved</i> is not <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle
///    <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate memory for the query
///    results. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanScan(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(DOT11_SSID)* pDot11Ssid, 
              const(WLAN_RAW_DATA)* pIeData, void* pReserved);

///The <b>WlanGetAvailableNetworkList</b> function retrieves the list of available networks on a wireless LAN interface.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = A pointer to the GUID of the wireless LAN interface to be queried. The GUID of each wireless LAN interface
///                     enabled on a local computer can be determined using the WlanEnumInterfaces function.
///    dwFlags = A set of flags that control the type of networks returned in the list. This parameter can be a combination of
///              these possible values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_ADHOC_PROFILES"></a><a
///              id="wlan_available_network_include_all_adhoc_profiles"></a><dl>
///              <dt><b>WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_ADHOC_PROFILES</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///              width="60%"> Include all ad hoc network profiles in the available network list, including profiles that are not
///              visible. <div class="alert"><b>Note</b> If this flag is specified on Windows XP with SP3 and Wireless LAN API for
///              Windows XP with SP2, it is consider considered an invalid parameter.</div> <div> </div> </td> </tr> <tr> <td
///              width="40%"><a id="WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_MANUAL_HIDDEN_PROFILES"></a><a
///              id="wlan_available_network_include_all_manual_hidden_profiles"></a><dl>
///              <dt><b>WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_MANUAL_HIDDEN_PROFILES</b></dt> <dt>0x00000002</dt> </dl> </td> <td
///              width="60%"> Include all hidden network profiles in the available network list, including profiles that are not
///              visible. <div class="alert"><b>Note</b> If this flag is specified on Windows XP with SP3 and Wireless LAN API for
///              Windows XP with SP2, it is consider considered an invalid parameter.</div> <div> </div> </td> </tr> </table>
///    pReserved = Reserved for future use. This parameter must be set to <b>NULL</b>.
///    ppAvailableNetworkList = A pointer to storage for a pointer to receive the returned list of visible networks in a
///                             WLAN_AVAILABLE_NETWORK_LIST structure. The buffer for the WLAN_AVAILABLE_NETWORK_LIST returned is allocated by
///                             the <b>WlanGetAvailableNetworkList</b> function if the call succeeds.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if the <i>hClientHandle</i>, <i>pInterfaceGuid</i>, or <i>ppAvailableNetworkList</i> parameter is
///    <b>NULL</b>. This error is returned if the <i>pReserved</i> is not <b>NULL</b>. This error is also returned if
///    the <i>dwFlags</i> parameter value is set to value that is not valid or the <i>hClientHandle</i> parameter is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%">
///    The handle <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NDIS_DOT11_POWER_STATE_INVALID</b></dt> </dl> </td> <td width="60%"> The radio associated with the
///    interface is turned off. There are no available networks when the radio is off. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is
///    available to process this request and allocate memory for the query results. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanGetAvailableNetworkList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwFlags, void* pReserved, 
                                 WLAN_AVAILABLE_NETWORK_LIST** ppAvailableNetworkList);

@DllImport("wlanapi")
uint WlanGetAvailableNetworkList2(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwFlags, void* pReserved, 
                                  WLAN_AVAILABLE_NETWORK_LIST_V2** ppAvailableNetworkList);

///The <b>WlanGetNetworkBssList</b> function retrieves a list of the basic service set (BSS) entries of the wireless
///network or networks on a given wireless LAN interface.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = A pointer to the GUID of the wireless LAN interface to be queried. The GUID of each wireless LAN interface
///                     enabled on a local computer can be determined using the WlanEnumInterfaces function.
///    pDot11Ssid = A pointer to a DOT11_SSID structure that specifies the SSID of the network from which the BSS list is requested.
///                 This parameter is optional. When set to <b>NULL</b>, the returned list contains all of available BSS entries on a
///                 wireless LAN interface. If a pointer to a DOT11_SSID structure is specified, the SSID length specified in the
///                 <b>uSSIDLength</b> member of <b>DOT11_SSID</b> structure must be less than or equal to
///                 <b>DOT11_SSID_MAX_LENGTH</b> defined in the <i>Wlantypes.h</i> header file. In addition, the <i>dot11BssType</i>
///                 parameter must be set to either <b>dot11_BSS_type_infrastructure</b> or <b>dot11_BSS_type_independent</b> and the
///                 <i>bSecurityEnabled</i> parameter must be specified.
///    dot11BssType = The BSS type of the network. This parameter is ignored if the SSID of the network for the BSS list is unspecified
///                   (the <i>pDot11Ssid</i> parameter is <b>NULL</b>). This parameter can be one of the following values defined in
///                   the DOT11_BSS_TYPE enumeration defined in the <i>Wlantypes.h</i> header file. <table> <tr> <th>Value</th>
///                   <th>Meaning</th> </tr> <tr> <td width="40%"><a id="dot11_BSS_type_infrastructure"></a><a
///                   id="dot11_bss_type_infrastructure"></a><a id="DOT11_BSS_TYPE_INFRASTRUCTURE"></a><dl>
///                   <dt><b>dot11_BSS_type_infrastructure</b></dt> </dl> </td> <td width="60%"> An infrastructure BSS network. </td>
///                   </tr> <tr> <td width="40%"><a id="dot11_BSS_type_independent_"></a><a id="dot11_bss_type_independent_"></a><a
///                   id="DOT11_BSS_TYPE_INDEPENDENT_"></a><dl> <dt><b>dot11_BSS_type_independent </b></dt> </dl> </td> <td
///                   width="60%"> An independent BSS (IBSS) network (an ad hoc network). </td> </tr> <tr> <td width="40%"><a
///                   id="dot11_BSS_type_any"></a><a id="dot11_bss_type_any"></a><a id="DOT11_BSS_TYPE_ANY"></a><dl>
///                   <dt><b>dot11_BSS_type_any</b></dt> </dl> </td> <td width="60%"> Any BSS network. </td> </tr> </table>
///    bSecurityEnabled = A value that indicates whether security is enabled on the network. This parameter is only valid when the SSID of
///                       the network for the BSS list is specified (the <i>pDot11Ssid</i> parameter is not <b>NULL</b>).
///    pReserved = Reserved for future use. This parameter must be set to <b>NULL</b>.
///    ppWlanBssList = A pointer to storage for a pointer to receive the returned list of of BSS entries in a WLAN_BSS_LIST structure.
///                    The buffer for the WLAN_BSS_LIST returned is allocated by the <b>WlanGetNetworkBssList</b> function if the call
///                    succeeds.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle <i>hClientHandle</i> was not
///    found in the handle table. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> A parameter is incorrect. This error is returned if the <i>hClientHandle</i>,
///    <i>pInterfaceGuid</i>, or <i>ppWlanBssList</i> parameter is <b>NULL</b>. This error is returned if the
///    <i>pReserved</i> is not <b>NULL</b>. This error is also returned if the <i>hClientHandle</i>, the SSID specified
///    in the <i>pDot11Ssid</i> parameter, or the BSS type specified in the <i>dot11BssType</i> parameter is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NDIS_DOT11_POWER_STATE_INVALID</b></dt> </dl> </td> <td
///    width="60%"> The radio associated with the interface is turned off. The BSS list is not available when the radio
///    is off. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Not enough memory is available to process this request and allocate memory for the query results.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The element
///    was not found. This error is returned if the GUID of the interface to be queried that was specified in the
///    <i>pInterfaceGuid</i> parameter could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if this function was called from a Windows XP with SP3 or Wireless LAN API for Windows XP with SP2
///    client. This error is also returned if the WLAN AutoConfig service is disabled. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td width="60%"> The WLAN AutoConfig service has not
///    been started. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%">
///    Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanGetNetworkBssList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(DOT11_SSID)* pDot11Ssid, 
                           DOT11_BSS_TYPE dot11BssType, BOOL bSecurityEnabled, void* pReserved, 
                           WLAN_BSS_LIST** ppWlanBssList);

///The <b>WlanConnect</b> function attempts to connect to a specific network.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface to use for the connection.
///    pConnectionParameters = Pointer to a WLAN_CONNECTION_PARAMETERS structure that specifies the connection type, mode, network profile, SSID
///                            that identifies the network, and other parameters. <b>Windows XP with SP3 and Wireless LAN API for Windows XP
///                            with SP2: </b>There are some constraints on the WLAN_CONNECTION_PARAMETERS members. This means that structures
///                            that are valid for Windows Server 2008 and Windows Vista may not be valid for Windows XP with SP3 or Wireless LAN
///                            API for Windows XP with SP2. For a list of constraints, see <b>WLAN_CONNECTION_PARAMETERS</b>.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following conditions
///    occurred: <ul> <li><i>hClientHandle</i> is <b>NULL</b> or invalid.</li> <li><i>pInterfaceGuid</i> is
///    <b>NULL</b>.</li> <li><i>pConnectionParameters</i> is <b>NULL</b>.</li> <li>The <b>dwFlags</b> member of the
///    structure pointed to by <i>pConnectionParameters</i> is not set to one of the values specified on the
///    WLAN_CONNECTION_PARAMETERS page.</li> <li>The <b>wlanConnectionMode</b> member of the structure pointed to by
///    <i>pConnectionParameters</i> is set to <b>wlan_connection_mode_discovery_secure</b> or
///    <b>wlan_connection_mode_discovery_unsecure</b>, and the <b>pDot11Ssid</b> member of the same structure is
///    <b>NULL</b>.</li> <li>The <b>wlanConnectionMode</b> member of the structure pointed to by
///    <i>pConnectionParameters</i> is set to <b>wlan_connection_mode_discovery_secure</b> or
///    <b>wlan_connection_mode_discovery_unsecure</b>, and the <b>dot11BssType</b> member of the same structure is set
///    to <b>dot11_BSS_type_any</b>.</li> <li>The <b>wlanConnectionMode</b> member of the structure pointed to by
///    <i>pConnectionParameters</i> is set to <b>wlan_connection_mode_profile</b>, and the <b>strProfile</b> member of
///    the same structure is <b>NULL</b> or the length of the profile exceeds WLAN_MAX_NAME_LENGTH.</li> <li>The
///    <b>wlanConnectionMode</b> member of the structure pointed to by <i>pConnectionParameters</i> is set to
///    <b>wlan_connection_mode_profile</b>, and the <b>strProfile</b> member of the same structure is <b>NULL</b> or the
///    length of the profile is zero.</li> <li>The <b>wlanConnectionMode</b> member of the structure pointed to by
///    <i>pConnectionParameters</i> is set to <b>wlan_connection_mode_invalid</b> or
///    <b>wlan_connection_mode_auto</b>.</li> <li>The <b>dot11BssType</b> member of the structure pointed to by
///    <i>pConnectionParameters</i> is set to <b>dot11_BSS_type_infrastructure</b>, and the <b>dwFlags</b> member of the
///    same structure is set to <b>WLAN_CONNECTION_ADHOC_JOIN_ONLY</b>.</li> <li>The <b>dot11BssType</b> member of the
///    structure pointed to by <i>pConnectionParameters</i> is set to <b>dot11_BSS_type_independent</b>, and the
///    <b>dwFlags</b> member of the same structure is set to <b>WLAN_CONNECTION_HIDDEN_NETWORK</b>.</li> <li>The
///    <b>dwFlags</b> member of the structure pointed to by <i>pConnectionParameters</i> is set to
///    <b>WLAN_CONNECTION_IGNORE_PRIVACY_BIT</b>, and either the <b>wlanConnectionMode</b> member of the same structure
///    is not set to <b>wlan_connection_mode_temporary_profile</b> or the <b>dot11BssType</b> member of the same
///    structure is set to <b>dot11_BSS_type_independent</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle <i>hClientHandle</i> was not found
///    in the handle table. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt>
///    </dl> </td> <td width="60%"> The caller does not have sufficient permissions. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanConnect(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                 const(WLAN_CONNECTION_PARAMETERS)* pConnectionParameters, void* pReserved);

@DllImport("wlanapi")
uint WlanConnect2(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                  const(WLAN_CONNECTION_PARAMETERS_V2)* pConnectionParameters, void* pReserved);

///The <b>WlanDisconnect</b> function disconnects an interface from its current network.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface to be disconnected.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    invalid, <i>pInterfaceGuid</i> is <b>NULL</b>, or <i>pReserved</i> is not <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle
///    <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate memory for the query
///    results. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%">
///    The caller does not have sufficient permissions. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanDisconnect(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, void* pReserved);

///The <b>WlanRegisterNotification</b> function is used to register and unregister notifications on all wireless
///interfaces.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    dwNotifSource = The notification sources to be registered. These flags may be combined. When this parameter is set to
///                    <b>WLAN_NOTIFICATION_SOURCE_NONE</b>, <b>WlanRegisterNotification</b> unregisters notifications on all wireless
///                    interfaces. The possible values for this parameter are defined in the <i>Wlanapi.h</i> and <i>L2cmn.h</i> header
///                    files. The following table shows possible values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                    width="40%"><a id="WLAN_NOTIFICATION_SOURCE_NONE"></a><a id="wlan_notification_source_none"></a><dl>
///                    <dt><b>WLAN_NOTIFICATION_SOURCE_NONE</b></dt> </dl> </td> <td width="60%"> Unregisters notifications. </td> </tr>
///                    <tr> <td width="40%"><a id="WLAN_NOTIFICATION_SOURCE_ALL"></a><a id="wlan_notification_source_all"></a><dl>
///                    <dt><b>WLAN_NOTIFICATION_SOURCE_ALL</b></dt> </dl> </td> <td width="60%"> Registers for all notifications
///                    available on the version of the operating system, including those generated by the 802.1X module. For Windows XP
///                    with SP3 and Wireless LAN API for Windows XP with SP2, setting <i>dwNotifSource</i> to
///                    <b>WLAN_NOTIFICATION_SOURCE_ALL</b> is functionally equivalent to setting <i>dwNotifSource</i> to
///                    <b>WLAN_NOTIFICATION_SOURCE_ACM</b>. </td> </tr> <tr> <td width="40%"><a id="WLAN_NOTIFICATION_SOURCE_ACM"></a><a
///                    id="wlan_notification_source_acm"></a><dl> <dt><b>WLAN_NOTIFICATION_SOURCE_ACM</b></dt> </dl> </td> <td
///                    width="60%"> Registers for notifications generated by the auto configuration module. <b>Windows XP with SP3 and
///                    Wireless LAN API for Windows XP with SP2: </b>Only the wlan_notification_acm_connection_complete and
///                    wlan_notification_acm_disconnected notifications are available. </td> </tr> <tr> <td width="40%"><a
///                    id="WLAN_NOTIFICATION_SOURCE_HNWK"></a><a id="wlan_notification_source_hnwk"></a><dl>
///                    <dt><b>WLAN_NOTIFICATION_SOURCE_HNWK</b></dt> </dl> </td> <td width="60%"> Registers for notifications generated
///                    by the wireless Hosted Network. This notification source is available on Windows 7 and on Windows Server 2008 R2
///                    with the Wireless LAN Service installed. </td> </tr> <tr> <td width="40%"><a
///                    id="WLAN_NOTIFICATION_SOURCE_ONEX"></a><a id="wlan_notification_source_onex"></a><dl>
///                    <dt><b>WLAN_NOTIFICATION_SOURCE_ONEX</b></dt> </dl> </td> <td width="60%"> Registers for notifications generated
///                    by 802.1X. </td> </tr> <tr> <td width="40%"><a id="WLAN_NOTIFICATION_SOURCE_MSM"></a><a
///                    id="wlan_notification_source_msm"></a><dl> <dt><b>WLAN_NOTIFICATION_SOURCE_MSM</b></dt> </dl> </td> <td
///                    width="60%"> Registers for notifications generated by MSM. <b>Windows XP with SP3 and Wireless LAN API for
///                    Windows XP with SP2: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
///                    id="WLAN_NOTIFICATION_SOURCE_SECURITY"></a><a id="wlan_notification_source_security"></a><dl>
///                    <dt><b>WLAN_NOTIFICATION_SOURCE_SECURITY</b></dt> </dl> </td> <td width="60%"> Registers for notifications
///                    generated by the security module. No notifications are currently defined for
///                    <b>WLAN_NOTIFICATION_SOURCE_SECURITY</b>. <b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2:
///                    </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a id="WLAN_NOTIFICATION_SOURCE_IHV"></a><a
///                    id="wlan_notification_source_ihv"></a><dl> <dt><b>WLAN_NOTIFICATION_SOURCE_IHV</b></dt> </dl> </td> <td
///                    width="60%"> Registers for notifications generated by independent hardware vendors (IHV). <b>Windows XP with SP3
///                    and Wireless LAN API for Windows XP with SP2: </b>This value is not supported. </td> </tr> <tr> <td
///                    width="40%"><a id="WLAN_NOTIFICATION_SOURCE_DEVICE_SERVICE"></a><a id="wlan_notification_source_ihv"></a><dl>
///                    <dt><b>WLAN_NOTIFICATION_SOURCE_DEVICE_SERVICE</b></dt> </dl> </td> <td width="60%">Registers for notifications
///                    generated by device services.</td> </tr> </table> <b>Windows XP with SP3 and Wireless LAN API for Windows XP with
///                    SP2: </b>This parameter must be set to WLAN_NOTIFICATION_SOURCE_NONE, WLAN_NOTIFICATION_SOURCE_ALL, or
///                    WLAN_NOTIFICATION_SOURCE_ACM.
///    bIgnoreDuplicate = Specifies whether duplicate notifications will be ignored. If set to <b>TRUE</b>, a notification will not be sent
///                       to the client if it is identical to the previous one. <b>Windows XP with SP3 and Wireless LAN API for Windows XP
///                       with SP2: </b>This parameter is ignored.
///    funcCallback = A WLAN_NOTIFICATION_CALLBACK type that defines the type of notification callback function. This parameter can be
///                   <b>NULL</b> if the <i>dwNotifSource</i> parameter is set to <b>WLAN_NOTIFICATION_SOURCE_NONE</b> to unregister
///                   notifications on all wireless interfaces,
///    pCallbackContext = A pointer to the client context that will be passed to the callback function with the notification.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    pdwPrevNotifSource = A pointer to the previously registered notification sources.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if <i>hClientHandle</i> is <b>NULL</b> or not valid or if <i>pReserved</i> is not <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle
///    <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate memory for the query
///    results. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various
///    error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanRegisterNotification(HANDLE hClientHandle, uint dwNotifSource, BOOL bIgnoreDuplicate, 
                              WLAN_NOTIFICATION_CALLBACK funcCallback, void* pCallbackContext, void* pReserved, 
                              uint* pdwPrevNotifSource);

///The <b>WlanGetProfile</b> function retrieves all information about a specified wireless profile.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the wireless interface. A list of the GUIDs for wireless interfaces on the local computer can be
///                     retrieved using the WlanEnumInterfaces function.
///    strProfileName = The name of the profile. Profile names are case-sensitive. This string must be NULL-terminated. The maximum
///                     length of the profile name is 255 characters. This means that the maximum length of this string, including the
///                     NULL terminator, is 256 characters. <b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2: </b>The
///                     name of the profile is derived automatically from the SSID of the network. For infrastructure network profiles,
///                     the name of the profile is the SSID of the network. For ad hoc network profiles, the name of the profile is the
///                     SSID of the ad hoc network followed by <code>-adhoc</code>.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    pstrProfileXml = A string that is the XML representation of the queried profile. There is no predefined maximum string length.
///    pdwFlags = On input, a pointer to the address location used to provide additional information about the request. If this
///               parameter is <b>NULL</b> on input, then no information on profile flags will be returned. On output, a pointer to
///               the address location used to receive profile flags. <b>Windows XP with SP3 and Wireless LAN API for Windows XP
///               with SP2: </b>Per-user profiles are not supported. Set this parameter to <b>NULL</b>. The <i>pdwFlags</i>
///               parameter can point to an address location that contains the following values: <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WLAN_PROFILE_GET_PLAINTEXT_KEY"></a><a
///               id="wlan_profile_get_plaintext_key"></a><dl> <dt><b>WLAN_PROFILE_GET_PLAINTEXT_KEY</b></dt> </dl> </td> <td
///               width="60%"> On input, this flag indicates that the caller wants to retrieve the plain text key from a wireless
///               profile. If the calling thread has the required permissions, the <b>WlanGetProfile</b> function returns the plain
///               text key in the keyMaterial element of the profile returned in the buffer pointed to by the <i>pstrProfileXml</i>
///               parameter. For the <b>WlanGetProfile</b> call to return the plain text key, the
///               <b>wlan_secure_get_plaintext_key</b> permissions from the WLAN_SECURABLE_OBJECT enumerated type must be set on
///               the calling thread. The DACL must also contain an ACE that grants <b>WLAN_READ_ACCESS</b> permission to the
///               access token of the calling thread. By default, the permissions for retrieving the plain text key is allowed only
///               to the members of the Administrators group on a local machine. If the calling thread lacks the required
///               permissions, the <b>WlanGetProfile</b> function returns the encrypted key in the keyMaterial element of the
///               profile returned in the buffer pointed to by the <i>pstrProfileXml</i> parameter. No error is returned if the
///               calling thread lacks the required permissions. <b>Windows 7: </b>This flag passed on input is an extension to
///               native wireless APIs added on Windows 7 and later. The <i>pdwFlags</i> parameter is an __inout_opt parameter on
///               Windows 7 and later. </td> </tr> <tr> <td width="40%"><a id="WLAN_PROFILE_GROUP_POLICY"></a><a
///               id="wlan_profile_group_policy"></a><dl> <dt><b>WLAN_PROFILE_GROUP_POLICY</b></dt> </dl> </td> <td width="60%"> On
///               output when the <b>WlanGetProfile</b> call is successful, this flag indicates that this profile was created by
///               group policy. A group policy profile is read-only. Neither the content nor the preference order of the profile
///               can be changed. </td> </tr> <tr> <td width="40%"><a id="WLAN_PROFILE_USER"></a><a id="wlan_profile_user"></a><dl>
///               <dt><b>WLAN_PROFILE_USER</b></dt> </dl> </td> <td width="60%"> On output when the <b>WlanGetProfile</b> call is
///               successful, this flag indicates that the profile is a user profile for the specific user in whose context the
///               calling thread resides. If not set, this profile is an all-user profile. </td> </tr> </table>
///    pdwGrantedAccess = The access mask of the all-user profile. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%">
///                       <dl> <dt>WLAN_READ_ACCESS</dt> </dl> </td> <td width="60%"> The user can view the contents of the profile. </td>
///                       </tr> <tr> <td width="40%"> <dl> <dt>WLAN_EXECUTE_ACCESS</dt> </dl> </td> <td width="60%"> The user has read
///                       access, and the user can also connect to and disconnect from a network using the profile. If a user has
///                       WLAN_EXECUTE_ACCESS, then the user also has WLAN_READ_ACCESS. </td> </tr> <tr> <td width="40%"> <dl>
///                       <dt>WLAN_WRITE_ACCESS</dt> </dl> </td> <td width="60%"> The user has execute access and the user can also modify
///                       the content of the profile or delete the profile. If a user has WLAN_WRITE_ACCESS, then the user also has
///                       WLAN_EXECUTE_ACCESS and WLAN_READ_ACCESS. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient
///    permissions. This error is returned if the <i>pstrProfileXml</i> parameter specifies an all-user profile, but the
///    caller does not have read access on the profile. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is returned if
///    the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is
///    incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li><i>pInterfaceGuid</i> is <b>NULL</b>.</li> <li><i>pstrProfileXml</i> is <b>NULL</b>.</li>
///    <li><i>pReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough storage is available to process
///    this command. This error is returned if the system was unable to allocate memory for the profile. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The profile specified by
///    <i>strProfileName</i> was not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Various RPC and other error codes. Use FormatMessage to obtain the message string for the returned
///    error. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanGetProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                    void* pReserved, ushort** pstrProfileXml, uint* pdwFlags, uint* pdwGrantedAccess);

///The <b>WlanSetProfileEapUserData</b> function sets the Extensible Authentication Protocol (EAP) user credentials as
///specified by raw EAP data. The user credentials apply to a profile on an interface.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface.
///    strProfileName = The name of the profile associated with the EAP user data. Profile names are case-sensitive. This string must be
///                     NULL-terminated.
///    eapType = An EAP_METHOD_TYPE structure that contains the method for which the caller is supplying EAP user credentials.
///    dwFlags = A set of flags that modify the behavior of the function. On Windows Vista and Windows Server 2008, this parameter
///              is reserved and should be set to zero. On Windows 7, Windows Server 2008 R2, and later, this parameter can be one
///              of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="WLAN_SET_EAPHOST_DATA_ALL_USERS"></a><a id="wlan_set_eaphost_data_all_users"></a><dl>
///              <dt><b>WLAN_SET_EAPHOST_DATA_ALL_USERS</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Set EAP host
///              data for all users of this profile. </td> </tr> </table>
///    dwEapUserDataSize = The size, in bytes, of the data pointed to by <i>pbEapUserData</i>.
///    pbEapUserData = A pointer to the raw EAP data used to set the user credentials. On Windows Vista and Windows Server 2008, this
///                    parameter must not be <b>NULL</b>. On Windows 7, Windows Server 2008 R2, and later, this parameter can be set to
///                    <b>NULL</b> to delete the stored credentials for this profile if the <i>dwFlags</i> parameter contains
///                    <b>WLAN_SET_EAPHOST_DATA_ALL_USERS</b> and the <i>dwEapUserDataSize</i> parameter is 0.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This value is returned if
///    the caller does not have write access to the profile. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This value is
///    returned if any of the following conditions occur: <ul> <li><i>hClientHandle</i> is <b>NULL</b>.</li>
///    <li><i>pInterfaceGuid</i> is <b>NULL</b>.</li> <li><i>strProfileName</i> is <b>NULL</b></li>
///    <li><i>pvReserved</i> is not <b>NULL</b>.</li> </ul> On Windows Vista and Windows Server 2008, this value is
///    returned if the <i>pbEapUserData</i> parameter is <b>NULL</b>. On Windows 7, Windows Server 2008 R2 , and later,
///    this error is returned if the <i>pbEapUserData</i> parameter is <b>NULL</b>, but the <i>dwEapUserDataSize</i>
///    parameter is not 0 or the <i>dwFlags</i> parameter does not contain <b>WLAN_SET_EAPHOST_DATA_ALL_USERS</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is
///    invalid. This error is returned if the handle <i>hClientHandle</i> was not found in the handle table. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough
///    storage is available to process this command. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This value is
///    returned when profile settings do not permit storage of user data. This can occur when single signon (SSO) is
///    enabled or when the request was to delete the stored credentials for this profile (the <i>pbEapUserData</i>
///    parameter was <b>NULL</b>, the <i>dwFlags</i> parameter contains <b>WLAN_SET_EAPHOST_DATA_ALL_USERS</b>, and the
///    <i>dwEapUserDataSize</i> parameter is 0). On Windows 10, Windows Server 2016 , and later, this value is returned
///    if the WlanSetProfileEapUserData function was called on a profile that uses a method other than 802.1X for
///    authentication. This value is also returned if this function was called from a Windows XP with SP3 or Wireless
///    LAN API for Windows XP with SP2 client. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td width="60%"> The service has not been started. This
///    value is returned if the Wireless LAN service is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanSetProfileEapUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                               EAP_METHOD_TYPE eapType, uint dwFlags, uint dwEapUserDataSize, char* pbEapUserData, 
                               void* pReserved);

///The <b>WlanSetProfileEapXmlUserData</b> function sets the Extensible Authentication Protocol (EAP) user credentials
///as specified by an XML string. The user credentials apply to a profile on an adapter. These credentials can only be
///used by the caller.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface.
///    strProfileName = The name of the profile associated with the EAP user data. Profile names are case-sensitive. This string must be
///                     NULL-terminated. <b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2: </b>The supplied name must
///                     match the profile name derived automatically from the SSID of the network. For an infrastructure network profile,
///                     the SSID must be supplied for the profile name. For an ad hoc network profile, the supplied name must be the SSID
///                     of the ad hoc network followed by <code>-adhoc</code>.
///    dwFlags = A set of flags that modify the behavior of the function. On Wireless LAN API for Windows XP with SP2, Windows XP
///              with SP3,Windows Vista, and Windows Server 2008, this parameter is reserved and should be set to zero. On Windows
///              7, Windows Server 2008 R2, and later, this parameter can be one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WLAN_SET_EAPHOST_DATA_ALL_USERS"></a><a
///              id="wlan_set_eaphost_data_all_users"></a><dl> <dt><b>WLAN_SET_EAPHOST_DATA_ALL_USERS</b></dt> <dt>0x00000001</dt>
///              </dl> </td> <td width="60%"> Set EAP host data for all users of this profile. </td> </tr> </table>
///    strEapXmlUserData = A pointer to XML data used to set the user credentials. The XML data must be based on the EAPHost User
///                        Credentials schema. To view sample user credential XML data, see EAPHost User Properties.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This value is returned if
///    the caller does not have write access to the profile. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The network connection profile is corrupted. This
///    error is returned if the profile specified in the <i>strProfileName</i> parameter could not be parsed. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter
///    is incorrect. This value is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li><i>pInterfaceGuid</i> is <b>NULL</b>.</li> <li><i>strProfileName</i> is <b>NULL</b>.</li>
///    <li><i>strEapXmlUserData</i> is <b>NULL</b>.</li> <li><i>pReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid.
///    This error is returned if the handle <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough storage is
///    available to process this command. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> The request is not supported. This value is returned when profile settings do not
///    permit storage of user data. This can occur when single signon (SSO) is enabled. On Windows 7, Windows Server
///    2008 R2 , and later, this value is returned if the WlanSetProfileEapXmlUserData function was called on a profile
///    that uses a method other than 802.1X for authentication. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td width="60%"> The service has not been started. This
///    value is returned if the Wireless LAN service is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanSetProfileEapXmlUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                                  uint dwFlags, const(wchar)* strEapXmlUserData, void* pReserved);

///The <b>WlanSetProfile</b> function sets the content of a specific profile.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface.
///    dwFlags = The flags to set on the profile. <b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2:
///              </b><i>dwFlags</i> must be 0. Per-user profiles are not supported. <table> <tr> <th>Value</th> <th>Meaning</th>
///              </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The profile
///              is an all-user profile. </td> </tr> <tr> <td width="40%"><a id="WLAN_PROFILE_GROUP_POLICY"></a><a
///              id="wlan_profile_group_policy"></a><dl> <dt><b>WLAN_PROFILE_GROUP_POLICY</b></dt> <dt>0x00000001</dt> </dl> </td>
///              <td width="60%"> The profile is a group policy profile. </td> </tr> <tr> <td width="40%"><a
///              id="WLAN_PROFILE_USER"></a><a id="wlan_profile_user"></a><dl> <dt><b>WLAN_PROFILE_USER</b></dt>
///              <dt>0x00000002</dt> </dl> </td> <td width="60%"> The profile is a per-user profile. </td> </tr> </table>
///    strProfileXml = Contains the XML representation of the profile. The WLANProfile element is the root profile element. To view
///                    sample profiles, see Wireless Profile Samples. There is no predefined maximum string length. <b>Windows XP with
///                    SP3 and Wireless LAN API for Windows XP with SP2: </b>The supplied profile must meet the compatibility criteria
///                    described in Wireless Profile Compatibility.
///    strAllUserProfileSecurity = Sets the security descriptor string on the all-user profile. For more information about profile permissions, see
///                                the Remarks section. If <i>dwFlags</i> is set to WLAN_PROFILE_USER, this parameter is ignored. If this parameter
///                                is set to <b>NULL</b> for a new all-user profile, the security descriptor associated with the
///                                wlan_secure_add_new_all_user_profiles object is used. If the security descriptor has not been modified by a
///                                WlanSetSecuritySettings call, all users have default permissions on a new all-user profile. Call
///                                WlanGetSecuritySettings to get the default permissions associated with the wlan_secure_add_new_all_user_profiles
///                                object. If this parameter is set to <b>NULL</b> for an existing all-user profile, the permissions of the profile
///                                are not changed. If this parameter is not <b>NULL</b> for an all-user profile, the security descriptor string
///                                associated with the profile is created or modified after the security descriptor object is created and parsed as
///                                a string. <b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2: </b>This parameter must be
///                                <b>NULL</b>.
///    bOverwrite = Specifies whether this profile is overwriting an existing profile. If this parameter is <b>FALSE</b> and the
///                 profile already exists, the existing profile will not be overwritten and an error will be returned.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    pdwReasonCode = A WLAN_REASON_CODE value that indicates why the profile is not valid.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient
///    permissions to set the profile. When called with <i>dwFlags</i> set to 0 - that is, when setting an all-user
///    profile - WlanSetProfile retrieves the discretionary access control list (DACL) stored with the
///    <b>wlan_secure_add_new_all_user_profiles</b> object. When called with <i>dwFlags</i> set to
///    <b>WLAN_PROFILE_USER</b> - that is, when setting a per-user profile - <b>WlanSetProfile</b> retrieves the
///    discretionary access control list (DACL) stored with the <b>wlan_secure_add_new_per_user_profiles</b> object. In
///    either case, if the DACL does not contain an access control entry (ACE) that grants WLAN_WRITE_ACCESS permission
///    to the access token of the calling thread, then <b>WlanSetProfile</b> returns <b>ERROR_ACCESS_DENIED</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%">
///    <i>strProfileXml</i> specifies a network that already exists. Typically, this return value is used when
///    <i>bOverwrite</i> is <b>FALSE</b>; however, if <i>bOverwrite</i> is <b>TRUE</b> and <i>dwFlags</i> specifies a
///    different profile type than the one used by the existing profile, then the existing profile will not be
///    overwritten and <b>ERROR_ALREADY_EXISTS</b> will be returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The profile specified by <i>strProfileXml</i> is
///    not valid. If this value is returned, <i>pdwReasonCode</i> specifies the reason the profile is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the
///    following conditions occurred: <ul> <li><i>hClientHandle</i> is <b>NULL</b> or invalid.</li>
///    <li><i>pInterfaceGuid</i> is <b>NULL</b>.</li> <li><i>pReserved</i> is not <b>NULL</b>.</li>
///    <li><i>strProfileXml</i> is <b>NULL</b>.</li>
///    [ConfigBlob](/windows/desktop/eaphost/eaphostconfigschema-configblob-eaphostconfig-element). If the profile must
///    have an empty <b>ConfigBlob</b>, use <code>&lt;ConfigBlob&gt;00&lt;/ConfigBlob&gt;</code> in the profile.</li>
///    <li><i>pdwReasonCode</i> is <b>NULL</b>.</li> <li><i>dwFlags</i> is not set to one of the specified values.</li>
///    <li><i>dwFlags</i> is set to WLAN_PROFILE_GROUP_POLICY and <i>bOverwrite</i> is set to <b>FALSE</b>.</li> </ul>
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The interface
///    does not support one or more of the capabilities specified in the profile. For example, if a profile specifies
///    the use of WPA2 when the NIC only supports WPA, then this error code is returned. Also, if a profile specifies
///    the use of FIPS mode when the NIC does not support FIPS mode, then this error code is returned. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr>
///    </table>
///    
@DllImport("wlanapi")
uint WlanSetProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwFlags, const(wchar)* strProfileXml, 
                    const(wchar)* strAllUserProfileSecurity, BOOL bOverwrite, void* pReserved, uint* pdwReasonCode);

///The <b>WlanDeleteProfile</b> function deletes a wireless profile for a wireless interface on the local computer.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface from which to delete the profile.
///    strProfileName = The name of the profile to be deleted. Profile names are case-sensitive. This string must be NULL-terminated.
///                     <b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2: </b>The supplied name must match the profile
///                     name derived automatically from the SSID of the network. For an infrastructure network profile, the SSID must be
///                     supplied for the profile name. For an ad hoc network profile, the supplied name must be the SSID of the ad hoc
///                     network followed by <code>-adhoc</code>.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hClientHandle</i> parameter is
///    <b>NULL</b> or not valid, the <i>pInterfaceGuid</i> parameter is <b>NULL</b>, the <i>strProfileName</i> parameter
///    is <b>NULL</b>, or <i>pReserved</i> is not <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle specified in the
///    <i>hClientHandle</i> parameter was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The wireless profile specified by
///    <i>strProfileName</i> was not found in the profile store. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient permissions
///    to delete the profile. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanDeleteProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                       void* pReserved);

///The <b>WlanRenameProfile</b> function renames the specified profile.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface.
///    strOldProfileName = The profile name to be changed.
///    strNewProfileName = The new name of the profile.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    not valid, <i>pInterfaceGuid</i> is <b>NULL</b>, <i>strOldProfileName</i> is <b>NULL</b>,
///    <i>strNewProfileName</i> is <b>NULL</b>, or <i>pReserved</i> is not <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle
///    <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The profile specified by <i>strOldProfileName</i>
///    was not found in the profile store. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt>
///    </dl> </td> <td width="60%"> The caller does not have sufficient permissions to rename the profile. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function was
///    called from an unsupported platform. This value will be returned if this function was called from a Windows XP
///    with SP3 or Wireless LAN API for Windows XP with SP2 client. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanRenameProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strOldProfileName, 
                       const(wchar)* strNewProfileName, void* pReserved);

///The <b>WlanGetProfileList</b> function retrieves the list of profiles in preference order.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the wireless interface. A list of the GUIDs for wireless interfaces on the local computer can be
///                     retrieved using the WlanEnumInterfaces function.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    ppProfileList = A PWLAN_PROFILE_INFO_LIST structure that contains the list of profile information.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle <i>hClientHandle</i> was not
///    found in the handle table. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> A parameter is incorrect. This error is returned if any of the following conditions
///    occur:<ul> <li><i>hClientHandle</i> is <b>NULL</b>.</li> <li><i>pInterfaceGuid</i> is <b>NULL</b>.</li>
///    <li><i>ppProfileList</i> is <b>NULL</b>.</li> <li><i>pReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory
///    is available to process this request and allocate memory for the query results. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanGetProfileList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, void* pReserved, 
                        WLAN_PROFILE_INFO_LIST** ppProfileList);

///The <b>WlanSetProfileList</b> function sets the preference order of profiles for a given interface.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface.
///    dwItems = The number of profiles in the <i>strProfileNames</i> parameter.
///    strProfileNames = The names of the profiles in the desired order. Profile names are case-sensitive. This string must be
///                      NULL-terminated. <b>Windows XP with SP3 and Wireless LAN API for Windows XP with SP2: </b>The supplied names must
///                      match the profile names derived automatically from the SSID of the network. For infrastructure network profiles,
///                      the SSID must be supplied for the profile name. For ad hoc network profiles, the supplied name must be the SSID
///                      of the ad hoc network followed by <code>-adhoc</code>.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient
///    permissions to change the profile list. Before WlanSetProfileList performs an operation that changes the relative
///    order of all-user profiles in the profile list or moves an all-user profile to a lower position in the profile
///    list, <b>WlanSetProfileList</b> retrieves the discretionary access control list (DACL) stored with the
///    <b>wlan_secure_all_user_profiles_order</b> object. If the DACL does not contain an access control entry (ACE)
///    that grants WLAN_WRITE_ACCESS permission to the access token of the calling thread, then
///    <b>WlanSetProfileList</b> returns <b>ERROR_ACCESS_DENIED</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle <i>hClientHandle</i> was not found
///    in the handle table. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> One of the following conditions occurred: <ul> <li><i>hClientHandle</i> is <b>NULL</b> or
///    invalid.</li> <li><i>pInterfaceGuid</i> is <b>NULL</b>.</li> <li><i>dwItems</i> is 0.</li>
///    <li><i>strProfileNames</i> is <b>NULL</b>.</li> <li>The same profile name appears more than once in
///    <i>strProfileNames</i>.</li> <li><i>pReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> <i>strProfileNames</i> contains
///    the name of a profile that is not present in the profile store. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanSetProfileList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwItems, char* strProfileNames, 
                        void* pReserved);

///The <b>WlanSetProfilePosition</b> function sets the position of a single, specified profile in the preference list.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface.
///    strProfileName = The name of the profile. Profile names are case-sensitive. This string must be NULL-terminated. <b>Windows XP
///                     with SP3 and Wireless LAN API for Windows XP with SP2: </b>The supplied name must match the profile name derived
///                     automatically from the SSID of the network. For an infrastructure network profile, the SSID must be supplied for
///                     the profile name. For an ad hoc network profile, the supplied name must be the SSID of the ad hoc network
///                     followed by <code>-adhoc</code>.
///    dwPosition = Indicates the position in the preference list that the profile should be shifted to. 0 (zero) corresponds to the
///                 first profile in the list that is returned by the WlanGetProfileList function.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient
///    permissions to change the profile position. Before WlanSetProfilePosition performs an operation that changes the
///    relative order of all-user profiles in the profile list or moves an all-user profile to a lower position in the
///    profile list, <b>WlanSetProfilePosition</b> retrieves the discretionary access control list (DACL) stored with
///    the <b>wlan_secure_all_user_profiles_order</b> object. If the DACL does not contain an access control entry (ACE)
///    that grants WLAN_WRITE_ACCESS permission to the access token of the calling thread, then
///    <b>WlanSetProfilePosition</b> returns <b>ERROR_ACCESS_DENIED</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    invalid, <i>pInterfaceGuid</i> is <b>NULL</b>, <i>strProfileName</i> is <b>NULL</b>, or <i>pReserved</i> is not
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The handle <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanSetProfilePosition(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                            uint dwPosition, void* pReserved);

///The <b>WlanSetProfileCustomUserData</b> function sets the custom user data associated with a profile.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface.
///    strProfileName = The name of the profile associated with the custom user data. Profile names are case-sensitive. This string must
///                     be NULL-terminated.
///    dwDataSize = The size of <i>pData</i>, in bytes.
///    pData = A pointer to the user data to be set.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following conditions
///    occurred: <ul> <li><i>hClientHandle</i> is <b>NULL</b> or invalid.</li> <li><i>pInterfaceGuid</i> is
///    <b>NULL</b>.</li> <li><i>strProfileName</i> is <b>NULL</b>.</li> <li><i>pReserved</i> is not <b>NULL</b>.</li>
///    <li><i>dwDataSize</i> is not 0 and <i>pData</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle <i>hClientHandle</i> was not found
///    in the handle table. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> This function was called from an unsupported platform. This value will be returned if this function
///    was called from a Windows XP with SP3 or Wireless LAN API for Windows XP with SP2 client. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr>
///    </table>
///    
@DllImport("wlanapi")
uint WlanSetProfileCustomUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                                  uint dwDataSize, char* pData, void* pReserved);

///The <b>WlanGetProfileCustomUserData</b> function gets the custom user data associated with a wireless profile.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = A pointer to the GUID of the wireless LAN interface.
///    strProfileName = The name of the profile with which the custom user data is associated. Profile names are case-sensitive. This
///                     string must be NULL-terminated.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    pdwDataSize = The size, in bytes, of the user data buffer pointed to by the <i>ppData</i>parameter.
///    ppData = A pointer to the user data.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified.
///    This error is returned if no user custom data exists for the profile specified. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hClientHandle</i> parameter is
///    <b>NULL</b> or not valid, the <i>pInterfaceGuid</i> parameter is <b>NULL</b>, the <i>strProfileName</i> parameter
///    is <b>NULL</b>, the <i>pReserved</i> parameter is not <b>NULL</b>, the <i>pdwDataSize</i> parameter is 0, or the
///    <i>ppData</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned if no custom user data exists for the profile specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle <i>hClientHandle</i> was not found
///    in the handle table. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> This function was called from an unsupported platform. This value will be returned if this function
///    was called from a Windows XP with SP3 or Wireless LAN API for Windows XP with SP2 client. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr>
///    </table>
///    
@DllImport("wlanapi")
uint WlanGetProfileCustomUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                                  void* pReserved, uint* pdwDataSize, ubyte** ppData);

///The <b>WlanSetFilterList</b> function sets the permit/deny list.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    wlanFilterListType = A WLAN_FILTER_LIST_TYPE value that specifies the type of filter list. The value must be either
///                         <b>wlan_filter_list_type_user_permit</b> or <b>wlan_filter_list_type_user_deny</b>. Group policy-defined lists
///                         cannot be set using this function.
///    pNetworkList = Pointer to a DOT11_NETWORK_LIST structure that contains the list of networks to permit or deny. The
///                   <b>dwIndex</b> member of the structure must have a value less than the value of the <b>dwNumberOfItems</b> member
///                   of the structure; otherwise, an access violation may occur.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient
///    permissions to set the filter list. When called with <i>wlanFilterListType</i> set to
///    <b>wlan_filter_list_type_user_permit</b>, WlanSetFilterList retrieves the discretionary access control list
///    (DACL) stored with the <b>wlan_secure_permit_list</b> object. When called with <i>wlanFilterListType</i> set to
///    <b>wlan_filter_list_type_user_deny</b>, <b>WlanSetFilterList</b> retrieves the DACL stored with the
///    <b>wlan_secure_deny_list</b> object. In either of these cases, if the DACL does not contain an access control
///    entry (ACE) that grants WLAN_WRITE_ACCESS permission to the access token of the calling thread, then
///    <b>WlanSetFilterList</b> returns <b>ERROR_ACCESS_DENIED</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    invalid or <i>pReserved</i> is not <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle <i>hClientHandle</i> was not found
///    in the handle table. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> This function was called from an unsupported platform. This value will be returned if this function
///    was called from a Windows XP with SP3 or Wireless LAN API for Windows XP with SP2 client. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr>
///    </table>
///    
@DllImport("wlanapi")
uint WlanSetFilterList(HANDLE hClientHandle, WLAN_FILTER_LIST_TYPE wlanFilterListType, 
                       const(DOT11_NETWORK_LIST)* pNetworkList, void* pReserved);

///The <b>WlanGetFilterList</b> function retrieves a group policy or user permission list.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    wlanFilterListType = A WLAN_FILTER_LIST_TYPE value that specifies the type of filter list. All user defined and group policy filter
///                         lists can be queried.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    ppNetworkList = Pointer to a DOT11_NETWORK_LIST structure that contains the list of permitted or denied networks.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient
///    permissions to get the filter list. When called with <i>wlanFilterListType</i> set to
///    <b>wlan_filter_list_type_user_permit</b>, WlanGetFilterList retrieves the discretionary access control list
///    (DACL) stored with the <b>wlan_secure_permit_list</b> object. When called with <i>wlanFilterListType</i> set to
///    <b>wlan_filter_list_type_user_deny</b>, <b>WlanGetFilterList</b> retrieves the DACL stored with the
///    <b>wlan_secure_deny_list</b> object. In either of these cases, if the DACL does not contain an access control
///    entry (ACE) that grants WLAN_READ_ACCESS permission to the access token of the calling thread, then
///    <b>WlanGetFilterList</b> returns <b>ERROR_ACCESS_DENIED</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    invalid, <i>ppNetworkList</i> is <b>NULL</b>, or <i>pReserved</i> is not <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle
///    <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function was called from an unsupported
///    platform. This value will be returned if this function was called from a Windows XP with SP3 or Wireless LAN API
///    for Windows XP with SP2 client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanGetFilterList(HANDLE hClientHandle, WLAN_FILTER_LIST_TYPE wlanFilterListType, void* pReserved, 
                       DOT11_NETWORK_LIST** ppNetworkList);

///The <b>WlanSetPsdIeDataList</b> function sets the proximity service discovery (PSD) information element (IE) data
///list.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    strFormat = The format of a PSD IE in the PSD IE data list passed in the <i>pPsdIEDataList</i> parameter. This is a
///                NULL-terminated URI string that specifies the namespace of the protocol used for discovery.
///    pPsdIEDataList = A pointer to a WLAN_RAW_DATA_LIST structure that contains the PSD IE data list to be set.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if the <i>hClientHandle</i> is <b>NULL</b> or not valid or <i>pReserved</i> is not <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle
///    <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function was called from an unsupported
///    platform. This value is returned if the function was called from a Windows XP with SP3 or Wireless LAN API for
///    Windows XP with SP2 client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanSetPsdIEDataList(HANDLE hClientHandle, const(wchar)* strFormat, const(WLAN_RAW_DATA_LIST)* pPsdIEDataList, 
                          void* pReserved);

///The <b>WlanSaveTemporaryProfile</b> function saves a temporary profile to the profile store.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    pInterfaceGuid = The GUID of the interface.
///    strProfileName = The name of the profile to be saved. Profile names are case-sensitive. This string must be NULL-terminated.
///    strAllUserProfileSecurity = Sets the security descriptor string on the all-user profile. By default, for a new all-user profile, all users
///                                have write access on the profile. For more information about profile permissions, see the Remarks section. If
///                                <i>dwFlags</i> is set to WLAN_PROFILE_USER, this parameter is ignored. If this parameter is set to <b>NULL</b>
///                                for an all-user profile, the default permissions are used. If this parameter is not <b>NULL</b> for an all-user
///                                profile, the security descriptor string associated with the profile is created or modified after the security
///                                descriptor object is created and parsed as a string.
///    dwFlags = Specifies the flags to set on the profile. The flags can be combined. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>0</dt> </dl> </td> <td
///              width="60%"> The profile is an all-user profile. </td> </tr> <tr> <td width="40%"><a
///              id="WLAN_PROFILE_USER"></a><a id="wlan_profile_user"></a><dl> <dt><b>WLAN_PROFILE_USER</b></dt>
///              <dt>0x00000002</dt> </dl> </td> <td width="60%"> The profile is a per-user profile. </td> </tr> <tr> <td
///              width="40%"><a id="WLAN_PROFILE_CONNECTION_MODE_SET_BY_CLIENT"></a><a
///              id="wlan_profile_connection_mode_set_by_client"></a><dl>
///              <dt><b>WLAN_PROFILE_CONNECTION_MODE_SET_BY_CLIENT</b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%"> The
///              profile was created by the client. </td> </tr> <tr> <td width="40%"><a
///              id="WLAN_PROFILE_CONNECTION_MODE_AUTO"></a><a id="wlan_profile_connection_mode_auto"></a><dl>
///              <dt><b>WLAN_PROFILE_CONNECTION_MODE_AUTO</b></dt> <dt>0x00020000</dt> </dl> </td> <td width="60%"> The profile
///              was created by the automatic configuration module. </td> </tr> </table>
///    bOverWrite = Specifies whether this profile is overwriting an existing profile. If this parameter is <b>FALSE</b> and the
///                 profile already exists, the existing profile will not be overwritten and an error will be returned.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following conditions
///    occurred: <ul> <li><i>hClientHandle</i> is <b>NULL</b> or invalid.</li> <li><i>pInterfaceGuid</i> is
///    <b>NULL</b>.</li> <li><i>pReserved</i> is not <b>NULL</b>.</li> <li><i>dwFlags</i> is not set to a combination of
///    one or more of the values specified in the table above.</li> <li><i>dwFlags</i> is set to
///    WLAN_PROFILE_CONNECTION_MODE_AUTO and <i>strProfileName</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle
///    <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function was called from an unsupported
///    platform. This value will be returned if this function was called from a Windows XP with SP3 or Wireless LAN API
///    for Windows XP with SP2 client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_STATE</b></dt>
///    </dl> </td> <td width="60%"> The interface is not currently connected using a temporary profile. </td> </tr>
///    </table>
///    
@DllImport("wlanapi")
uint WlanSaveTemporaryProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                              const(wchar)* strAllUserProfileSecurity, uint dwFlags, BOOL bOverWrite, 
                              void* pReserved);

///Allows an original equipment manufacturer (OEM) or independent hardware vendor (IHV) component to communicate with a
///device service on a particular wireless LAN interface.
///Params:
///    hClientHandle = Type: **[HANDLE](/windows/win32/winprog/windows-data-types)** The client's session handle, obtained by a previous
///                    call to the [WlanOpenHandle](./nf-wlanapi-wlanopenhandle.md) function.
///    pInterfaceGuid = Type: **CONST [GUID](../guiddef/ns-guiddef-guid.md)\*** A pointer to the **GUID** of the wireless LAN interface
///                     to be queried. You can determine the **GUID** of each wireless LAN interface enabled on a local computer by using
///                     the [WlanEnumInterfaces](./nf-wlanapi-wlanenuminterfaces.md) function.
///    pDeviceServiceGuid = Type: **[GUID](../guiddef/ns-guiddef-guid.md)\*** The **GUID** identifying the device service for this command.
///    dwOpCode = Type: **[DWORD](/windows/win32/winprog/windows-data-types)** The operational code identifying the operation to be
///               performed on the device service.
///    dwInBufferSize = Type: **[DWORD](/windows/win32/winprog/windows-data-types)** The size, in bytes, of the input buffer.
///    pInBuffer = Type: **[PVOID](/windows/win32/winprog/windows-data-types)** A generic buffer for command input.
///    dwOutBufferSize = Type: **[DWORD](/windows/win32/winprog/windows-data-types)** The size, in bytes, of the output buffer.
///    pOutBuffer = Type: **[PVOID](/windows/win32/winprog/windows-data-types)** A generic buffer for command output.
///    pdwBytesReturned = Type: **[PDWORD](/windows/win32/winprog/windows-data-types)** The number of bytes returned.
///Returns:
///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, the return value
///    is **ERROR_SUCCESS**. If the function fails with **ERROR_ACCESS_DENIED**, then the caller doesn't have sufficient
///    permissions to perform this operation. The caller needs to either have admin privilege, or needs to be a UMDF
///    driver.
///    
@DllImport("wlanapi")
uint WlanDeviceServiceCommand(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, GUID* pDeviceServiceGuid, 
                              uint dwOpCode, uint dwInBufferSize, char* pInBuffer, uint dwOutBufferSize, 
                              char* pOutBuffer, uint* pdwBytesReturned);

///Retrieves a list of the supported device services on a given wireless LAN interface.
///Params:
///    hClientHandle = Type: **[HANDLE](/windows/win32/winprog/windows-data-types)** The client's session handle, obtained by a previous
///                    call to the [WlanOpenHandle](./nf-wlanapi-wlanopenhandle.md) function.
///    pInterfaceGuid = Type: **CONST [GUID](../guiddef/ns-guiddef-guid.md)\*** A pointer to the **GUID** of the wireless LAN interface
///                     to be queried. You can determine the **GUID** of each wireless LAN interface enabled on a local computer by using
///                     the [WlanEnumInterfaces](./nf-wlanapi-wlanenuminterfaces.md) function.
///    ppDevSvcGuidList = Type: **[PWLAN_DEVICE_SERVICE_GUID_LIST](./ns-wlanapi-wlan_device_service_guid_list.md)\*** A pointer to storage
///                       for a pointer to receive the returned list of device service **GUID**s in a
///                       [WLAN_DEVICE_SERVICE_GUID_LIST](./ns-wlanapi-wlan_device_service_guid_list.md) structure. If the call succeeds,
///                       then the buffer for the **WLAN_DEVICE_SERVICE_GUID_LIST** returned is allocated by the
///                       **WlanGetSupportedDeviceServices** function.
///Returns:
///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, the return value
///    is **ERROR_SUCCESS**. If the function fails with **ERROR_ACCESS_DENIED**, then the caller doesn't have sufficient
///    permissions to perform this operation. The caller needs to either have admin privilege, or needs to be a UMDF
///    driver.
///    
@DllImport("wlanapi")
uint WlanGetSupportedDeviceServices(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                                    WLAN_DEVICE_SERVICE_GUID_LIST** ppDevSvcGuidList);

///Allows user mode clients with admin privileges, or User-Mode Driver Framework (UMDF) drivers, to register for
///unsolicited notifications corresponding to device services that they're interested in.
///Params:
///    hClientHandle = Type: **[HANDLE](/windows/win32/winprog/windows-data-types)** The client's session handle, obtained by a previous
///                    call to the [WlanOpenHandle](./nf-wlanapi-wlanopenhandle.md) function.
///    pDevSvcGuidList = Type: **CONST [PWLAN_DEVICE_SERVICE_GUID_LIST](./ns-wlanapi-wlan_device_service_guid_list.md)** An optional
///                      pointer to a constant [WLAN_DEVICE_SERVICE_GUID_LIST](./ns-wlanapi-wlan_device_service_guid_list.md) structure
///                      representing the device service **GUID**s for which you're interested in receiving notifications. The *dwIndex*
///                      member of the structure must have a value less than the value of its *dwNumberOfItems* member; otherwise, an
///                      access violation may occur. Every time you call this API, the previous device services list is replaced by the
///                      new one. To unregister, set *pDevSvcGuidList* to `nullptr`, or pass a pointer to a
///                      **WLAN_DEVICE_SERVICE_GUID_LIST** structure that has the `dwNumberOfItems` member set to 0.
///Returns:
///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, the return value
///    is **ERROR_SUCCESS**. If the function fails with **ERROR_ACCESS_DENIED**, then the caller doesn't have sufficient
///    permissions to perform this operation. The caller needs to either have admin privilege, or needs to be a UMDF
///    driver.
///    
@DllImport("wlanapi")
uint WlanRegisterDeviceServiceNotification(HANDLE hClientHandle, 
                                           const(WLAN_DEVICE_SERVICE_GUID_LIST)* pDevSvcGuidList);

///The <b>WlanExtractPsdIEDataList</b> function extracts the proximity service discovery (PSD) information element (IE)
///data list from raw IE data included in a beacon.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    dwIeDataSize = The size, in bytes, of the <i>pRawIeData</i> parameter.
///    pRawIeData = The raw IE data for all IEs in the list.
///    strFormat = Describes the format of a PSD IE. Only IEs with a matching format are returned.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    ppPsdIEDataList = A pointer to a PWLAN_RAW_DATA_LIST structure that contains the formatted data list.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hClientHandle</i> is <b>NULL</b> or
///    invalid, <i>dwIeDataSize</i> is 0, <i>pRawIeData</i> is <b>NULL</b>, or <i>pReserved</i> is not <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    handle <i>hClientHandle</i> was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function was called from an unsupported
///    platform. This value will be returned if this function was called from a Windows XP with SP3 or Wireless LAN API
///    for Windows XP with SP2 client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanExtractPsdIEDataList(HANDLE hClientHandle, uint dwIeDataSize, char* pRawIeData, const(wchar)* strFormat, 
                              void* pReserved, WLAN_RAW_DATA_LIST** ppPsdIEDataList);

///The <b>WlanReasonCodeToString</b> function retrieves a string that describes a specified reason code.
///Params:
///    dwReasonCode = A WLAN_REASON_CODE value of which the string description is requested.
///    dwBufferSize = The size of the buffer used to store the string, in <b>WCHAR</b>. If the reason code string is longer than the
///                   buffer, it will be truncated and NULL-terminated. If <i>dwBufferSize</i> is larger than the actual amount of
///                   memory allocated to <i>pStringBuffer</i>, then an access violation will occur in the calling program.
///    pStringBuffer = Pointer to a buffer that will receive the string. The caller must allocate memory to <i>pStringBuffer</i> before
///                    calling <b>WlanReasonCodeToString</b>.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is a pointer to a constant string. If the function fails, the return
///    value may be one of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is
///    incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>dwBufferSize</i> is
///    0.</li> <li><i>pStringBuffer</i> is <b>NULL</b>.</li> <li><i>pReserved</i> is not <b>NULL</b>.</li> </ul> </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Various RPC and other error
///    codes. Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanReasonCodeToString(uint dwReasonCode, uint dwBufferSize, const(wchar)* pStringBuffer, void* pReserved);

///The <b>WlanAllocateMemory</b> function allocates memory. Any memory passed to other Native Wifi functions must be
///allocated with this function.
///Params:
///    dwMemorySize = Amount of memory being requested, in bytes.
///Returns:
///    If the call is successful, the function returns a pointer to the allocated memory. If the memory could not be
///    allocated for any reason or if the <i>dwMemorySize</i> parameter is 0, the returned pointer is <b>NULL</b>. An
///    application can call GetLastError to obtain extended error information.
///    
@DllImport("wlanapi")
void* WlanAllocateMemory(uint dwMemorySize);

///The <b>WlanFreeMemory</b> function frees memory. Any memory returned from Native Wifi functions must be freed.
///Params:
///    pMemory = Pointer to the memory to be freed.
@DllImport("wlanapi")
void WlanFreeMemory(void* pMemory);

///The WlanGetProfileList function sets the security settings for a configurable object.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    SecurableObject = A WLAN_SECURABLE_OBJECT value that specifies the object to which the security settings will be applied.
///    strModifiedSDDL = A security descriptor string that specifies the new security settings for the object. This string must be
///                      NULL-terminated. For more information, see the Remarks section.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is <b>NULL</b>.</li>
///    <li><i>strModifiedSDDL</i> is <b>NULL</b>.</li> <li><i>SecurableObject</i> is set to a value greater than or
///    equal to <b>WLAN_SECURABLE_OBJECT_COUNT</b> (12).</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is returned if
///    the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    sufficient permissions. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td>
///    <td width="60%"> This function was called from an unsupported platform. This value will be returned if this
///    function was called from a Windows XP with SP3 or Wireless LAN API for Windows XP with SP2 client. </td> </tr>
///    </table>
///    
@DllImport("wlanapi")
uint WlanSetSecuritySettings(HANDLE hClientHandle, WLAN_SECURABLE_OBJECT SecurableObject, 
                             const(wchar)* strModifiedSDDL);

///The <b>WlanGetSecuritySettings</b> function gets the security settings associated with a configurable object.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    SecurableObject = A WLAN_SECURABLE_OBJECT value that specifies the object to which the security settings apply.
///    pValueType = A pointer to a WLAN_OPCODE_VALUE_TYPE value that specifies the source of the security settings. <table> <tr>
///                 <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="wlan_opcode_value_type_set_by_group_policy"></a><a id="WLAN_OPCODE_VALUE_TYPE_SET_BY_GROUP_POLICY"></a><dl>
///                 <dt><b>wlan_opcode_value_type_set_by_group_policy</b></dt> </dl> </td> <td width="60%"> The security settings
///                 were set by group policy. </td> </tr> <tr> <td width="40%"><a id="wlan_opcode_value_type_set_by_user"></a><a
///                 id="WLAN_OPCODE_VALUE_TYPE_SET_BY_USER"></a><dl> <dt><b>wlan_opcode_value_type_set_by_user</b></dt> </dl> </td>
///                 <td width="60%"> The security settings were set by the user. A user can set security settings by calling
///                 WlanSetSecuritySettings. </td> </tr> </table>
///    pstrCurrentSDDL = On input, this parameter must be <b>NULL</b>. On output, this parameter receives a pointer to the security
///                      descriptor string that specifies the security settings for the object if the function call succeeds. For more
///                      information about this string, see WlanSetSecuritySettings function.
///    pdwGrantedAccess = The access mask of the object. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///                       <dt>WLAN_READ_ACCESS</dt> </dl> </td> <td width="60%"> The caller can view the object's permissions. </td> </tr>
///                       <tr> <td width="40%"> <dl> <dt>WLAN_EXECUTE_ACCESS</dt> </dl> </td> <td width="60%"> The caller can read from and
///                       execute the object. WLAN_EXECUTE_ACCESS has the same value as the bitwise OR combination WLAN_READ_ACCESS |
///                       WLAN_EXECUTE_ACCESS. </td> </tr> <tr> <td width="40%"> <dl> <dt>WLAN_WRITE_ACCESS</dt> </dl> </td> <td
///                       width="60%"> The caller can read from, execute, and write to the object. WLAN_WRITE_ACCESS has the same value as
///                       the bitwise OR combination WLAN_READ_ACCESS | WLAN_EXECUTE_ACCESS | WLAN_WRITE_ACCESS. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is <b>NULL</b>.</li>
///    <li><i>pstrCurrentSDDL</i> is <b>NULL</b>.</li> <li><i>pdwGrantedAccess</i> is <b>NULL</b>.</li>
///    <li><i>SecurableObject</i> is set to a value greater than or equal to <b>WLAN_SECURABLE_OBJECT_COUNT</b>
///    (12).</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> A handle is invalid. This error is returned if the handle specified in the <i>hClientHandle</i>
///    parameter was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient permissions.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This
///    function was called from an unsupported platform. This value will be returned if this function was called from a
///    Windows XP with SP3 or Wireless LAN API for Windows XP with SP2 client. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanGetSecuritySettings(HANDLE hClientHandle, WLAN_SECURABLE_OBJECT SecurableObject, 
                             WLAN_OPCODE_VALUE_TYPE* pValueType, ushort** pstrCurrentSDDL, uint* pdwGrantedAccess);

///Displays the wireless profile user interface (UI). This UI is used to view and edit advanced settings of a wireless
///network profile.
///Params:
///    dwClientVersion = Specifies the highest version of the WLAN API that the client supports. Values other than WLAN_UI_API_VERSION
///                      will be ignored.
///    wstrProfileName = Contains the name of the profile to be viewed or edited. Profile names are case-sensitive. This string must be
///                      NULL-terminated. The supplied profile must be present on the interface <i>pInterfaceGuid</i>. That means the
///                      profile must have been previously created and saved in the profile store and that the profile must be valid for
///                      the supplied interface.
///    pInterfaceGuid = The GUID of the interface.
///    hWnd = The handle of the application window requesting the UI display.
///    wlStartPage = A WL_DISPLAY_PAGES value that specifies the active tab when the UI dialog box appears.
///    pReserved = Reserved for future use. Must be set to <b>NULL</b>.
///    pWlanReasonCode = A pointer to a WLAN_REASON_CODE value that indicates why the UI display failed.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the supplied parameters is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%">
///    This function was called from an unsupported platform. This value will be returned if this function was called
///    from a Windows XP with SP3 or Wireless LAN API for Windows XP with SP2 client. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanUIEditProfile(uint dwClientVersion, const(wchar)* wstrProfileName, GUID* pInterfaceGuid, HWND hWnd, 
                       WL_DISPLAY_PAGES wlStartPage, void* pReserved, uint* pWlanReasonCode);

///The <b>WlanHostedNetworkStartUsing</b> function starts the wireless Hosted Network.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    pFailReason = An optional pointer to a value that receives the failure reason, if the call to the
///                  <b>WlanHostedNetworkStartUsing</b> function fails. Possible values for the failure reason are from the
///                  WLAN_HOSTED_NETWORK_REASON enumeration type defined in the <i>Wlanapi.h </i>header file.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is <b>NULL</b>.</li>
///    <li><i>pvReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is returned if
///    the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The resource is not in the
///    correct state to perform the requested operation. This error is returned if the wireless Hosted Network is
///    disabled by group policy on a domain. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td width="60%"> The service has not been started. This
///    error is returned if the WLAN AutoConfig Service is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Various RPC and other error codes. Use FormatMessage to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkStartUsing(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

///The <b>WlanHostedNetworkStopUsing</b> function stops the wireless Hosted Network.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    pFailReason = An optional pointer to a value that receives the failure reason if the call to the
///                  <b>WlanHostedNetworkStopUsing</b> function fails. Possible values for the failure reason are from the
///                  WLAN_HOSTED_NETWORK_REASON enumeration type defined in the <i>Wlanapi.h </i>header file.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is
///    returned if the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter
///    is incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li><i>pvReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The resource is not in the correct state to
///    perform the requested operation. This can occur if the wireless Hosted Network was in the process of shutting
///    down. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td
///    width="60%"> The service has not been started. This error is returned if the WLAN AutoConfig Service is not
///    running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Various RPC
///    and other error codes. Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkStopUsing(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

///The <b>WlanHostedNetworkForceStart</b> function transitions the wireless Hosted Network to the
///<b>wlan_hosted_network_active state</b> without associating the request with the application's calling handle.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    pFailReason = An optional pointer to a value that receives the failure reason if the call to the
///                  <b>WlanHostedNetworkForceStart</b> function fails. Possible values for the failure reason are from the
///                  WLAN_HOSTED_NETWORK_REASON enumeration type defined in the <i>Wlanapi.h </i>header file.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient
///    permissions. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> A handle is invalid. This error is returned if the handle specified in the <i>hClientHandle</i>
///    parameter was not found in the handle table. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is <b>NULL</b>.</li>
///    <li><i>pvReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The resource is not in the correct state to
///    perform the requested operation. This error is returned if the wireless Hosted Network is disabled by group
///    policy on a domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td>
///    <td width="60%"> The service has not been started. This error is returned if the WLAN AutoConfig Service is not
///    running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Various RPC
///    and other error codes. Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkForceStart(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

///The <b>WlanHostedNetworkForceStop</b> function transitions the wireless Hosted Network to the
///<b>wlan_hosted_network_idle</b> without associating the request with the application's calling handle.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    pFailReason = An optional pointer to a value that receives the failure reason, if the call to the
///                  <b>WlanHostedNetworkForceStop</b> function fails. Possible values for the failure reason are from the
///                  WLAN_HOSTED_NETWORK_REASON enumeration type defined in the <i>Wlanapi.h </i>header file.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is
///    returned if the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter
///    is incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li><i>pvReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The resource is not in the correct state to
///    perform the requested operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt>
///    </dl> </td> <td width="60%"> The service has not been started. This error is returned if the WLAN AutoConfig
///    Service is not running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    Various RPC and other error codes. Use FormatMessage to obtain the message string for the returned error. </td>
///    </tr> </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkForceStop(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

///The <b>WlanHostedNetworkQueryProperty</b> function queries the current static properties of the wireless Hosted
///Network.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    OpCode = The identifier for property to be queried. This identifier can be any of the values in the
///             WLAN_HOSTED_NETWORK_OPCODE enumeration defined in the <i>Wlanapi.h </i>header file.
///    pdwDataSize = A pointer to a value that specifies the size, in bytes, of the buffer returned in the <i>ppvData</i> parameter,
///                  if the call to the <b>WlanHostedNetworkQueryProperty</b> function succeeds.
///    ppvData = On input, this parameter must be <b>NULL</b>. On output, this parameter receives a pointer to a buffer returned
///              with the static property requested, if the call to the <b>WlanHostedNetworkQueryProperty</b> function succeeds.
///              The data type associated with this buffer depends upon the value of <i>OpCode</i> parameter.
///    pWlanOpcodeValueType = A pointer to a value that receives the value type of the wireless Hosted Network property, if the call to the
///                           <b>WlanHostedNetworkQueryProperty</b> function succeeds. The returned value is an enumerated type in the
///                           WLAN_OPCODE_VALUE_TYPE enumeration defined in the <i>Wlanapi.h </i>header file.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BAD_CONFIGURATION</b></dt> </dl> </td> <td width="60%"> The configuration data for the wireless
///    Hosted Network is unconfigured. This error is returned if the application calls the
///    WlanHostedNetworkQueryProperty function with the <i>OpCode</i> parameter set to
///    <b>wlan_hosted_network_opcode_station_profile</b> or <b>wlan_hosted_network_opcode_connection_settings</b> before
///    a SSID is configured in the wireless Hosted Network. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is returned if
///    the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is
///    incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li><i>OpCode</i> is not one of the enumerated values defined in the
///    WLAN_HOSTED_NETWORK_OPCODE.</li> <li><i>pdwDataSize</i> is <b>NULL</b>.</li> <li><i>ppvData</i> is
///    <b>NULL</b>.</li> <li><i>pWlanOpcodeValueType</i> is <b>NULL</b>.</li> <li><i>pvReserved</i> is not
///    <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td>
///    <td width="60%"> The resource is not in the correct state to perform the requested operation. This can occur if
///    the wireless Hosted Network was in the process of shutting down. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough storage is available to complete this
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td
///    width="60%"> The service has not been started. This error is returned if the WLAN AutoConfig Service is not
///    running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Various RPC
///    and other error codes. Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkQueryProperty(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_OPCODE OpCode, uint* pdwDataSize, 
                                    void** ppvData, WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType, void* pvReserved);

///The <b>WlanHostedNetworkSetProperty</b> function sets static properties of the wireless Hosted Network.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    OpCode = The identifier for the property to be set. This identifier can only be the following values in the
///             WLAN_HOSTED_NETWORK_OPCODE enumeration defined in the <i>Wlanapi.h </i>header file: *
///             **wlan_hosted_network_opcode_connection_settings** The Hosted Network connection settings. *
///             **wlan_hosted_network_opcode_enable** The Hosted Network enabled flag.
///    dwDataSize = A value that specifies the size, in bytes, of the buffer pointed to by the <i>pvData</i> parameter.
///    pvData = A pointer to a buffer with the static property to set. The data type associated with this buffer depends upon the
///             value of <i>OpCode</i> parameter.
///    pFailReason = An optional pointer to a value that receives the failure reason, if the call to the
///                  <b>WlanHostedNetworkSetProperty</b> function fails. Possible values for the failure reason are from the
///                  WLAN_HOSTED_NETWORK_REASON enumeration type defined in the <i>Wlanapi.h </i>header file.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient
///    permissions. This error is also returned if the <i>OpCode</i> parameter was
///    <b>wlan_hosted_network_opcode_enable</b> and the wireless Hosted Network is disabled by group policy on a domain.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The network
///    connection profile used by the wireless Hosted Network is corrupted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is returned if
///    the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is
///    incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li><i>OpCode</i> is not one of the enumerated values defined in the
///    WLAN_HOSTED_NETWORK_OPCODE.</li> <li><i>dwDataSize</i> is zero.</li> <li><i>pvData</i> is <b>NULL</b>.</li>
///    <li><i>pvData</i> does not point to a well- formed static property.</li> <li><i>pvReserved</i> is not
///    <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td>
///    <td width="60%"> The resource is not in the correct state to perform the requested operation. This can occur if
///    the wireless Hosted Network was in the process of shutting down. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if the application calls the WlanHostedNetworkSetProperty function with the <i>OpCode</i> parameter set
///    to <b>wlan_hosted_network_opcode_station_profile</b> or <b>wlan_hosted_network_opcode_security_settings</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td width="60%"> The
///    service has not been started. This error is returned if the WLAN AutoConfig Service is not running. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Various RPC and other error codes.
///    Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkSetProperty(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_OPCODE OpCode, uint dwDataSize, 
                                  char* pvData, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

///The <b>WlanHostedNetworkInitSettings</b> function configures and persists to storage the network connection settings
///(SSID and maximum number of peers, for example) on the wireless Hosted Network if these settings are not already
///configured.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    pFailReason = An optional pointer to a value that receives the failure reason if the call to the
///                  <b>WlanHostedNetworkInitSettings</b> function fails. Possible values for the failure reason are from the
///                  WLAN_HOSTED_NETWORK_REASON enumeration type defined in the <i>Wlanapi.h </i>header file.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is
///    returned if the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter
///    is incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li><i>pvReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The resource is not in the correct state to
///    perform the requested operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt>
///    </dl> </td> <td width="60%"> The service has not been started. This error is returned if the WLAN AutoConfig
///    Service is not running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    Various RPC and other error codes. Use FormatMessage to obtain the message string for the returned error. </td>
///    </tr> </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkInitSettings(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

///The <b>WlanHostedNetworkRefreshSecuritySettings</b> function refreshes the configurable and auto-generated parts of
///the wireless Hosted Network security settings.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    pFailReason = An optional pointer to a value that receives the failure reason, if the call to the
///                  <b>WlanHostedNetworkRefreshSecuritySettings</b> function fails. Possible values for the failure reason are from
///                  the WLAN_HOSTED_NETWORK_REASON enumeration type defined in the <i>Wlanapi.h </i>header file.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is
///    returned if the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter
///    is incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li><i>pvReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The resource is not in the correct state to
///    perform the requested operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt>
///    </dl> </td> <td width="60%"> The service has not been started. This error is returned if the WLAN AutoConfig
///    Service is not running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    Various RPC and other error codes. Use FormatMessage to obtain the message string for the returned error. </td>
///    </tr> </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkRefreshSecuritySettings(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                              void* pvReserved);

///The <b>WlanHostedNetworkQueryStatus</b> function queries the current status of the wireless Hosted Network.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    ppWlanHostedNetworkStatus = On input, this parameter must be <b>NULL</b>. On output, this parameter receives a pointer to the current status
///                                of the wireless Hosted Network, if the call to the <b>WlanHostedNetworkQueryStatus</b> function succeeds. The
///                                current status is returned in a WLAN_HOSTED_NETWORK_STATUS structure.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is
///    returned if the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter
///    is incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li>ppWlanHostedNetworkStatus is <b>NULL</b>.</li> <li><i>pvReserved</i> is not
///    <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td>
///    <td width="60%"> The resource is not in the correct state to perform the requested operation. This can occur if
///    the wireless Hosted Network was in the process of shutting down. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td width="60%"> The service has not been started. This
///    error is returned if the WLAN AutoConfig Service is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Various RPC and other error codes. Use FormatMessage to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkQueryStatus(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_STATUS** ppWlanHostedNetworkStatus, 
                                  void* pvReserved);

///The <b>WlanHostedNetworkSetSecondaryKey</b> function configures the secondary security key that will be used by the
///wireless Hosted Network.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    dwKeyLength = The number of valid data bytes in the key data array pointed to by the <i>pucKeyData</i> parameter. This key
///                  length should include the terminating ‘\0’ if the key is a passphrase.
///    pucKeyData = A pointer to a buffer that contains the key data. The number of valid data bytes in the buffer must be at least
///                 the value specified in <i>dwKeyLength</i> parameter.
///    bIsPassPhrase = A Boolean value that indicates if the key data array pointed to by the <i>pucKeyData</i> parameter is in
///                    passphrase format. If this parameter is <b>TRUE</b>, the key data array is in passphrase format. If this
///                    parameter is <b>FALSE</b>, the key data array is not in passphrase format.
///    bPersistent = A Boolean value that indicates if the key data array pointed to by the <i>pucKeyData</i> parameter is to be
///                  stored and reused later or is for one-time use only. If this parameter is <b>TRUE</b>, the key data array is to
///                  be stored and reused later. If this parameter is <b>FALSE</b>, the key data array is to be used for one session
///                  (either the current session or the next session if the Hosted Network is not started).
///    pFailReason = An optional pointer to a value that receives the failure reason, if the call to the
///                  <b>WlanHostedNetworkSetSecondaryKey</b> function fails. Possible values for the failure reason are from the
///                  WLAN_HOSTED_NETWORK_REASON enumeration type defined in the <i>Wlanapi.h </i>header file.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is
///    returned if the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter
///    is incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li><i>pucKeyData</i> is <b>NULL</b>.</li> <li><i>pucKeyData</i> does not point to a well-
///    formed valid key.</li> <li><i>pvReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The resource is not in the correct state to
///    perform the requested operation. This can occur if the wireless Hosted Network was in the process of shutting
///    down. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td
///    width="60%"> The service has not been started. This error is returned if the WLAN AutoConfig Service is not
///    running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Various RPC
///    and other error codes. Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkSetSecondaryKey(HANDLE hClientHandle, uint dwKeyLength, char* pucKeyData, BOOL bIsPassPhrase, 
                                      BOOL bPersistent, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

///The <b>WlanHostedNetworkQuerySecondaryKey</b> function queries the secondary security key that is configured to be
///used by the wireless Hosted Network.
///Params:
///    hClientHandle = The client's session handle, returned by a previous call to the WlanOpenHandle function.
///    pdwKeyLength = A pointer to a value that specifies number of valid data bytes in the key data array pointed to by the
///                   <i>ppucKeyData</i> parameter, if the call to the <b>WlanHostedNetworkQuerySecondaryKey</b> function succeeds.
///                   This key length includes the terminating ‘\0’ if the key is a passphrase.
///    ppucKeyData = A pointer to a value that receives a pointer to the buffer returned with the secondary security key data, if the
///                  call to the <b>WlanHostedNetworkQuerySecondaryKey</b> function succeeds.
///    pbIsPassPhrase = A pointer to a Boolean value that indicates if the key data array pointed to by the <i>ppucKeyData</i> parameter
///                     is in passphrase format. If this parameter is <b>TRUE</b>, the key data array is in passphrase format. If this
///                     parameter is <b>FALSE</b>, the key data array is not in passphrase format.
///    pbPersistent = A pointer to a Boolean value that indicates if the key data array pointed to by the <i>ppucKeyData</i> parameter
///                   is to be stored and reused later or is for one-time use only. If this parameter is <b>TRUE</b>, the key data
///                   array is to be stored and reused later. If this parameter is <b>FALSE</b>, the key data array is for one-time use
///                   only.
///    pFailReason = An optional pointer to a value that receives the failure reason, if the call to the
///                  WlanHostedNetworkSetSecondaryKey function fails. Possible values for the failure reason are from the
///                  WLAN_HOSTED_NETWORK_REASON enumeration type defined in the <i>Wlanapi.h </i>header file.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is
///    returned if the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter
///    is incorrect. This error is returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is
///    <b>NULL</b>.</li> <li><i>pdwKeyLength</i> is <b>NULL</b>.</li> <li><i>ppucKeyData</i> is <b>NULL</b> or
///    invalid.</li> <li><i>pbIsPassPhrase</i> is <b>NULL</b> or invalid.</li> <li><i>pbPersistent</i> is
///    <b>NULL</b>.</li> <li><i>pvReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The resource is not in the correct state to
///    perform the requested operation. This can occur if the wireless Hosted Network was in the process of shutting
///    down. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not
///    enough storage is available to complete this operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td width="60%"> The service has not been started. This
///    error is returned if the WLAN AutoConfig Service is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Various RPC and other error codes. Use FormatMessage to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanHostedNetworkQuerySecondaryKey(HANDLE hClientHandle, uint* pdwKeyLength, ubyte** ppucKeyData, 
                                        int* pbIsPassPhrase, int* pbPersistent, 
                                        WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

///The <b>WlanRegisterVirtualStationNotification</b> function is used to register and unregister notifications on a
///virtual station.
///Params:
///    hClientHandle = The client's session handle, obtained by a previous call to the WlanOpenHandle function.
///    bRegister = A value that specifies whether to receive notifications on a virtual station.
///    pReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if any of the following conditions occur:<ul> <li><i>hClientHandle</i> is <b>NULL</b>.</li>
///    <li><i>pvReserved</i> is not <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> A handle is invalid. This error is returned if
///    the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The resource is not in the
///    correct state to perform the requested operation. This error is returned if the wireless Hosted Network is
///    disabled by group policy on a domain. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td width="60%"> The service has not been started. This
///    error is returned if the WLAN AutoConfig Service is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Various RPC and other error codes. Use FormatMessage to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WlanRegisterVirtualStationNotification(HANDLE hClientHandle, BOOL bRegister, void* pReserved);

///The <b>WFDOpenHandle</b> function opens a handle to the Wi-Fi Direct service and negotiates a version of the Wi-FI
///Direct API to use.
///Params:
///    dwClientVersion = The highest version of the Wi-Fi Direct API the client supports. For Windows 8 and Windows Server 2012, this
///                      parameter should be set to <b>WFD_API_VERSION</b>, constant defined in the <i>Wlanapi.h</i> header file.
///    pdwNegotiatedVersion = A pointer to a <b>DWORD</b> to received the negotiated version. If the <b>WFDOpenHandle</b> function is
///                           successful, the version negotiated with the Wi-Fi Direct Service to be used by this session is returned. This
///                           value is usually the highest version supported by both the client and Wi-Fi Direct service.
///    phClientHandle = A pointer to a <b>HANDLE</b> to receive the handle to the Wi-Fi Direct service for this session. If the
///                     <b>WFDOpenHandle</b> function is successful, a handle to the Wi-Fi Direct service to use in this session is
///                     returned.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The parameter is incorrect. This error
///    is returned if the <i>pdwNegotiatedVersion</i> parameter is <b>NULL</b> or the <i>phClientHandle</i> parameter is
///    <b>NULL</b>. This value is also returned if the <i>dwClientVersion</i> parameter is not equal to
///    <b>WFD_API_VERSION</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> Not enough storage is available to process this command. This error is returned if the
///    system was unable to allocate memory to create the client context. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_REMOTE_SESSION_LIMIT_EXCEEDED</b></dt> </dl> </td> <td width="60%"> An attempt was made to establish
///    a session to a network server, but there are already too many sessions established to that server. This error is
///    returned if too many handles have been issued by the Wi-Fi Direct service. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WFDOpenHandle(uint dwClientVersion, uint* pdwNegotiatedVersion, ptrdiff_t* phClientHandle);

///The <b>WFDCloseHandle</b> function closes a handle to the Wi-Fi Direct service.
///Params:
///    hClientHandle = A client handle to the Wi-Fi Direct service. This handle was obtained by a previous call to the WFDOpenHandle
///                    function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. This error is
///    returned if the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    parameter is incorrect. This error is returned if the <i>hClientHandle</i> parameter is <b>NULL</b> or not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error
///    codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WFDCloseHandle(HANDLE hClientHandle);

///The <b>WFDStartOpenSession</b> function starts an on-demand connection to a specific Wi-Fi Direct device, which has
///been previously paired through the Windows Pairing experience.
///Params:
///    hClientHandle = A client handle to the Wi-Fi Direct service. This handle was obtained by a previous call to the WFDOpenHandle
///                    function.
///    pDeviceAddress = A pointer to the target device’s Wi-Fi Direct device address. This is the MAC address of the target Wi-Fi
///                     device.
///    pvContext = An optional context pointer which is passed to the callback function specified in the <i>pfnCallback</i>
///                parameter.
///    pfnCallback = A pointer to the callback function to be called once the <b>WFDStartOpenSession</b> request has completed.
///    phSessionHandle = A handle to this specific Wi-Fi Direct session.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. This error is
///    returned if the handle specified in the <i>hClientHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    parameter is incorrect. This error is returned if the <i>hClientHandle</i> parameter is <b>NULL</b> or not valid.
///    This error is also returned if the <i>pDeviceAddress</i> parameter is <b>NULL</b>, the <i>pfnCallback</i>
///    parameter is <b>NULL</b>, or the <i>phSessionHandle</i> parameter is <b>NULL</b>. This value is also returned if
///    the <i>dwClientVersion</i> parameter is not equal to <b>WFD_API_VERSION</b>. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The group or resource is not in the correct
///    state to perform the requested operation. This error is returned if the Wi-Fi Direct service is disabled by group
///    policy on a domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td>
///    <td width="60%"> The service has not been started. This error is returned if the WLAN AutoConfig Service is not
///    running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various
///    error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WFDStartOpenSession(HANDLE hClientHandle, ubyte** pDeviceAddress, void* pvContext, 
                         WFD_OPEN_SESSION_COMPLETE_CALLBACK pfnCallback, ptrdiff_t* phSessionHandle);

///The <b>WFDCancelOpenSession</b> function indicates that the application wants to cancel a pending WFDStartOpenSession
///function that has not completed.
///Params:
///    hSessionHandle = A session handle to a Wi-Fi Direct session to cancel. This is a session handle previously returned by the
///                     WFDStartOpenSession function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. This error is
///    returned if the handle specified in the <i>hSessionHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    parameter is incorrect. This error is returned if the <i>hSessionHandle</i> parameter is <b>NULL</b> or not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various
///    error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WFDCancelOpenSession(HANDLE hSessionHandle);

///The <b>WFDOpenLegacySession</b> function retrieves and applies a stored profile for a Wi-Fi Direct legacy device.
///Params:
///    hClientHandle = A <b>HANDLE</b> to the Wi-Fi Direct service for this session. This parameter is retrieved using the WFDOpenHandle
///                    function.
///    pLegacyMacAddress = A pointer to Wi-Fi Direct device address of the legacy client device.
///    phSessionHandle = A pointer to a <b>HANDLE</b> to receive the handle to the Wi-Fi Direct service for this session. If the
///                      <b>WFDOpenLegacySession</b> function is successful, a handle to the Wi-Fi Direct service to use in this session
///                      is returned.
///    pGuidSessionInterface = A pointer to the GUID of the network interface for this session. If the <b>WFDOpenLegacySession</b> function is
///                            successful, a GUID of the network interface on which Wi-Fi Direct session is returned.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The parameter is incorrect. This error
///    is returned if the <i>phClientHandle</i> or the <i>pLegacyMacAddress</i> parameter is <b>NULL</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough
///    storage is available to process this command. This error is returned if the system was unable to allocate memory
///    to create the client context. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td
///    width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WFDOpenLegacySession(HANDLE hClientHandle, ubyte** pLegacyMacAddress, HANDLE* phSessionHandle, 
                          GUID* pGuidSessionInterface);

///The <b>WFDCloseSession</b> function closes a session after a previously successful call to the WFDStartOpenSession
///function.
///Params:
///    hSessionHandle = A session handle to a Wi-Fi Direct session. This is a session handle previously returned by the
///                     WFDStartOpenSession function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. This error is
///    returned if the handle specified in the <i>hSessionHandle</i> parameter was not found in the handle table. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    parameter is incorrect. This error is returned if the <i>hSessionHandle</i> parameter is <b>NULL</b> or not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%">
///    The group or resource is not in the correct state to perform the requested operation. This error is returned if
///    the Wi-Fi Direct service is disabled by group policy on a domain. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%"> Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WFDCloseSession(HANDLE hSessionHandle);

///The <b>WFDUpdateDeviceVisibility</b> function updates device visibility for the Wi-Fi Direct device address for a
///given installed Wi-Fi Direct device node.
///Params:
///    pDeviceAddress = A pointer to the Wi-Fi Direct device address of the client device. This device address must be obtained from a
///                     Device Node created as a result of the Inbox pairing experience.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value may be one
///    of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The parameter is incorrect. This error
///    is returned if the <i>pDeviceAddress</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough storage is available to process
///    this command. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_STATUS</b></dt> </dl> </td> <td width="60%">
///    Various error codes. </td> </tr> </table>
///    
@DllImport("wlanapi")
uint WFDUpdateDeviceVisibility(ubyte** pDeviceAddress);


// Interfaces

@GUID("DD06A84F-83BD-4D01-8AB9-2389FEA0869E")
struct Dot11AdHocManager;

///The <b>IDot11AdHocManager</b> interface creates and manages 802.11 ad hoc networks. It is the top-level 802.11 ad hoc
///interface and the only ad hoc interface with a coclass. As such, it is the only ad hoc interface that can be
///instantiated by CoCreateInstance. <div class="alert"><b>Note</b> Ad hoc mode might not be available in future
///versions of Windows. Starting with Windows 8.1 and Windows Server 2012 R2, use Wi-Fi Direct instead.</div><div>
///</div>The <b>IDot11AdHocManager</b> coclass implements the IConnectionPoint interface. The Advise method can be used
///to register for network manager, network, and interface-related notifications. Notifications are implemented by the
///IDot11AdHocManagerNotificationSink interface. To register for notifications, call the <b>Advise</b> method with the
///appropriate notification sink interface as the <i>pUnk</i> parameter.
@GUID("8F10CC26-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocManager : IUnknown
{
    ///Creates a wireless ad hoc network. Other clients and hosts can connect to this network.
    ///Params:
    ///    Name = The friendly name of the network. This string should be limited to 32 characters. The SSID should be used as
    ///           the friendly name. This name is broadcasted in a beacon.
    ///    Password = The password used for machine or user authentication on the network. The length of the password string
    ///               depends on the security settings passed in the <i>pSecurity</i> parameter. The following table shows the
    ///               password length associated with various security settings. <table> <tr> <th>Security Settings</th>
    ///               <th>Password Length</th> </tr> <tr> <td>Open-None</td> <td>0</td> </tr> <tr> <td>Open-WEP</td> <td>5 or 13
    ///               characters; 10 or 26 hexadecimal digits</td> </tr> <tr> <td>WPA2PSK</td> <td>8 to 63 characters</td> </tr>
    ///               </table> For the enumerated values that correspond to the security settings pair above, see
    ///               DOT11_ADHOC_AUTH_ALGORITHM and DOT11_ADHOC_CIPHER_ALGORITHM
    ///    GeographicalId = The geographical location in which the network will be created. For a list of possible values, see Table of
    ///                     Geographical Locations. If the interface is not 802.11d conformant, this value is ignored. That means if
    ///                     IDot11AdHocInterface::IsDot11d returns <b>FALSE</b>, this value is ignored. If you are not sure which value
    ///                     to use, set <i>GeographicalId</i> to CTRY_DEFAULT. If you use CTRY_DEFAULT, 802.11d conformance is not
    ///                     enforced.
    ///    pInterface = An optional pointer to an IDot11AdHocInterface that specifies the network interface upon which the new
    ///                 network is created. If this parameter is <b>NULL</b>, the first unused interface is used. If all interfaces
    ///                 are in use, the first enumerated interface is used. In that case, the previous network on the interface is
    ///                 disconnected.
    ///    pSecurity = A pointer to an IDot11AdHocSecuritySettings interface that specifies the security settings used on the
    ///                network.
    ///    pContextGuid = An optional parameter that specifies the GUID of the application that created the network. An application can
    ///                   use this identifier to limit the networks enumerated by GetIEnumDot11AdHocNetworks to networks created by the
    ///                   application. For this filtering to work correctly, all instances of the application on all machines must use
    ///                   the same GUID.
    ///    pIAdHoc = A pointer to an IDot11AdHocNetwork interface that represents the created network.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_ALREADY_EXISTS)</b></dt> </dl> </td> <td
    ///    width="60%"> A network with the specified <i>Name</i> already exists. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_READY)</b></dt> </dl> </td> <td width="60%"> The <i>pInterface</i>
    ///    interface reports that its radio is turned off. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_CAPABLE)</b></dt> </dl> </td> <td width="60%"> The <i>pInterface</i>
    ///    interface reports that it is not capable of forming an ad hoc network. This condition can occur because the
    ///    NIC does not support ad hoc networks, or because the NIC does not support the security settings supplied by
    ///    <i>pSecurity</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> The <i>pSecurity</i>
    ///    settings are not supported by the <i>pInterface</i> interface. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_ILL_FORMED_PASSWORD)</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>Password</i> supplied is invalid. The password supplied may be an invalid length for the security settings
    ///    supplied by <i>pSecurity</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> A wireless network interface
    ///    card was not found on the machine. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_CURRENT_DOMAIN_NOT_ALLOWED)</b></dt> </dl> </td> <td width="60%"> Group
    ///    policy or administrative settings prohibit the creation of the network. </td> </tr> </table>
    ///    
    HRESULT CreateNetwork(const(wchar)* Name, const(wchar)* Password, int GeographicalId, 
                          IDot11AdHocInterface pInterface, IDot11AdHocSecuritySettings pSecurity, GUID* pContextGuid, 
                          IDot11AdHocNetwork* pIAdHoc);
    ///Initializes a created network and optionally commits the network's profile to the profile store. The network must
    ///be created using CreateNetwork before calling <b>CommitCreatedNetwork</b>.
    ///Params:
    ///    pIAdHoc = A pointer to a IDot11AdHocNetwork interface that specifies the network to be initialized and committed.
    ///    fSaveProfile = An optional parameter that specifies whether a wireless profile should be saved. If <b>TRUE</b>, the profile
    ///                   is saved to the profile store. Once a profile has been saved, the user can modify the profile using the
    ///                   <b>Manage Wireless Network</b> user interface. Profiles can also be modified using the Native Wifi Functions.
    ///                   Saving a profile modifies the network signature returned by IDot11AdHocNetwork::GetSignature.
    ///    fMakeSavedProfileUserSpecific = An optional parameter that specifies whether the profile to be saved is an all-user profile. If set to
    ///                                    <b>TRUE</b>, the profile is specific to the current user. If set to <b>FALSE</b>, the profile is an all-user
    ///                                    profile and can be used by any user logged into the machine. This parameter is ignored if <i>fSaveProfile</i>
    ///                                    is <b>FALSE</b>. By default, only members of the Administrators group can persist an all-user profile. These
    ///                                    security settings can be altered using the WlanSetSecuritySettings function. Your application must be
    ///                                    launched by a user with sufficient privileges for an all-user profile to be persisted successfully. If your
    ///                                    application is running in a Remote Desktop window, you can only save an all-user profile. User-specific
    ///                                    profiles cannot be saved from an application running remotely.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT CommitCreatedNetwork(IDot11AdHocNetwork pIAdHoc, ubyte fSaveProfile, 
                                 ubyte fMakeSavedProfileUserSpecific);
    ///Returns a list of available ad hoc network destinations within connection range. This list may be filtered.
    ///Params:
    ///    pContextGuid = An optional parameter that specifies the GUID of the application that created the network. An application can
    ///                   use this identifier to limit the networks enumerated to networks created by the application. For this
    ///                   filtering to work correctly, all instances of the application on all machines must use the same GUID.
    ///    ppEnum = A pointer to an IEnumDot11AdHocNetworks interface that contains the enumerated networks.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetIEnumDot11AdHocNetworks(GUID* pContextGuid, IEnumDot11AdHocNetworks* ppEnum);
    ///Returns the set of wireless network interface cards (NICs) available on the machine.
    ///Params:
    ///    ppEnum = A pointer to an IEnumDot11AdHocInterfaces interface that contains the list of NICs.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetIEnumDot11AdHocInterfaces(IEnumDot11AdHocInterfaces* ppEnum);
    ///Returns the network associated with a signature.
    ///Params:
    ///    NetworkSignature = A signature that uniquely identifies an ad hoc network. This signature is generated from certain network
    ///                       attributes.
    ///    pNetwork = A pointer to an IDot11AdHocNetwork interface that represents the network associated with the signature.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT GetNetwork(GUID* NetworkSignature, IDot11AdHocNetwork* pNetwork);
}

///The <b>IDot11AdHocManagerNotificationSink</b> interface defines the notifications supported by the IDot11AdHocManager
///interface. To register for notifications, call the Advise method on an instantiated IDot11AdHocManager object with
///the <b>IDot11AdHocManagerNotificationSink</b> interface passed as the <i>pUnk</i> parameter. To terminate
///notifications, call the Unadvise method. <div class="alert"><b>Note</b> Ad hoc mode might not be available in future
///versions of Windows. Starting with Windows 8.1 and Windows Server 2012 R2, use Wi-Fi Direct instead.</div><div>
///</div>
@GUID("8F10CC27-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocManagerNotificationSink : IUnknown
{
    ///Notifies the client that a new wireless ad hoc network destination is in range and available for connection.
    ///Params:
    ///    pIAdHocNetwork = A pointer to an IDot11AdHocNetwork interface that represents the new network.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT OnNetworkAdd(IDot11AdHocNetwork pIAdHocNetwork);
    ///Notifies the client that a wireless ad hoc network destination is no longer available for connection.
    ///Params:
    ///    Signature = A pointer to a signature that uniquely identifies the newly unavailable network. For more information about
    ///                signatures, see IDot11AdHocNetwork::GetSignature.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT OnNetworkRemove(GUID* Signature);
    ///Notifies the client that a new network interface card (NIC) is active.
    ///Params:
    ///    pIAdHocInterface = A pointer to an IDot11AdHocInterface interface that represents the activated NIC.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT OnInterfaceAdd(IDot11AdHocInterface pIAdHocInterface);
    ///Notifies the client that a network interface card (NIC) has become inactive.
    ///Params:
    ///    Signature = A pointer to a signature that uniquely identifies the inactive NIC. For more information about signatures,
    ///                see IDot11AdHocInterface::GetDeviceSignature.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT OnInterfaceRemove(GUID* Signature);
}

///This interface represents the collection of currently visible 802.11 ad hoc networks. It is a standard enumerator.
///<div class="alert"><b>Note</b> Ad hoc mode might not be available in future versions of Windows. Starting with
///Windows 8.1 and Windows Server 2012 R2, use Wi-Fi Direct instead.</div><div> </div>
@GUID("8F10CC28-CF0D-42A0-ACBE-E2DE7007384D")
interface IEnumDot11AdHocNetworks : IUnknown
{
    ///Gets the specified number of elements from the sequence and advances the current position by the number of items
    ///retrieved. If there are fewer than the requested number of elements left in the sequence, it retrieves the
    ///remaining elements.
    ///Params:
    ///    cElt = The number of elements requested.
    ///    rgElt = A pointer to the first element in an array of IDot11AdHocNetwork interfaces. The array is of size
    ///            <i>cElt</i>. The array must exist and be of size <i>cElt</i> (at a minimum) before the <b>Next</b> method is
    ///            called, although the array need not be initialized. Upon return, the previously existing array will contain
    ///            pointers to <b>IDot11AdHocNetwork</b> objects.
    ///    pcEltFetched = A pointer to a variable that specifies the number of elements returned in <i>rgElt</i>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT Next(uint cElt, IDot11AdHocNetwork* rgElt, uint* pcEltFetched);
    ///Skips over the next specified number of elements in the enumeration sequence.
    ///Params:
    ///    cElt = The number of elements to skip.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT Skip(uint cElt);
    ///Resets to the beginning of the enumeration sequence.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Creates a new enumeration interface.
    ///Params:
    ///    ppEnum = A pointer to a variable that, on successful return, points to an IEnumDot11AdHocNetworksinterface.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT Clone(IEnumDot11AdHocNetworks* ppEnum);
}

///The <b>IDot11AdHocNetwork</b> interface represents an available ad hoc network destination within connection range.
///Before an application can connect to a network, the network must have been created using
///IDot11AdHocManager::CreateNetwork and committed using IDot11AdHocManager::CommitCreatedNetwork. <div
///class="alert"><b>Note</b> Ad hoc mode might not be available in future versions of Windows. Starting with Windows 8.1
///and Windows Server 2012 R2, use Wi-Fi Direct instead.</div><div> </div>
@GUID("8F10CC29-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocNetwork : IUnknown
{
    ///Gets the connection status of the network.
    ///Params:
    ///    eStatus = A pointer to a DOT11_ADHOC_NETWORK_CONNECTION_STATUS value that specifies the connection state.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetStatus(DOT11_ADHOC_NETWORK_CONNECTION_STATUS* eStatus);
    ///Gets the SSID of the network.
    ///Params:
    ///    ppszwSSID = The SSID of the network. You must free this string using CoTaskMemFree.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetSSID(ushort** ppszwSSID);
    ///Returns a boolean value that specifies whether there is a saved profile associated with the network.
    ///Params:
    ///    pf11d = Specifies whether the network has a profile. This value is set to <b>TRUE</b> if the network has a profile
    ///            and <b>FALSE</b> otherwise.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT HasProfile(ubyte* pf11d);
    ///Gets the profile name associated with the network.
    ///Params:
    ///    ppszwProfileName = The name of the profile associated with the network. If the network has no profile, this parameter is
    ///                       <b>NULL</b>. You must free this string using CoTaskMemFree.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetProfileName(ushort** ppszwProfileName);
    ///Deletes any profile associated with the network.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> The method could not allocate the memory required to perform this operation. </td>
    ///    </tr> </table>
    ///    
    HRESULT DeleteProfile();
    ///Gets the signal quality values associated with the network's radio.
    ///Params:
    ///    puStrengthValue = The current signal strength. This parameter takes a ULONG value between 0 and <i>puStrengthMax</i>.
    ///    puStrengthMax = The maximum signal strength value. This parameter takes a ULONG value between 0 and 100. By default,
    ///                    <i>puStrengthMax</i> is set to 100.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetSignalQuality(uint* puStrengthValue, uint* puStrengthMax);
    ///Gets the security settings for the network.
    ///Params:
    ///    pAdHocSecuritySetting = A pointer to an IDot11AdHocSecuritySettings interface that contains the security settings for the network.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetSecuritySetting(IDot11AdHocSecuritySettings* pAdHocSecuritySetting);
    ///Gets the context identifier associated with the network. This GUID identifies the application that created the
    ///network.
    ///Params:
    ///    pContextGuid = The context identifier associated with the network. If no ContextGuid was specified when the CreateNetwork
    ///                   call was made, the GUID returned consists of all zeros.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetContextGuid(GUID* pContextGuid);
    ///Gets the unique signature associated with the ad hoc network. The signature uniquely identifies an
    ///IDot11AdHocNetworkobject with a particular set of attributes.
    ///Params:
    ///    pSignature = A signature that uniquely identifies an ad hoc network. This signature is generated from certain network
    ///                 attributes.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetSignature(GUID* pSignature);
    ///Gets the interface associated with a network.
    ///Params:
    ///    pAdHocInterface = A pointer to an IDot11AdHocInterface.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetInterface(IDot11AdHocInterface* pAdHocInterface);
    ///Connects to a previously created wireless ad hoc network. Before an application can connect to a network, the
    ///network must have been created using IDot11AdHocManager::CreateNetwork and committed using
    ///IDot11AdHocManager::CommitCreatedNetwork.
    ///Params:
    ///    Passphrase = The password string used to authenticate the user or machine on the network. The length of the password
    ///                 string depends on the security settings passed in the <i>pSecurity</i> parameter of the CreateNetwork call.
    ///                 The following table shows the password length associated with various security settings. <table> <tr>
    ///                 <th>Security Settings</th> <th>Password Length</th> </tr> <tr> <td>Open-None</td> <td>0</td> </tr> <tr>
    ///                 <td>Open-WEP</td> <td>5 or 13 characters; 10 or 26 hexadecimal digits</td> </tr> <tr> <td>WPA2PSK</td> <td>8
    ///                 to 63 characters</td> </tr> </table> For the enumerated values that correspond to the security settings pair
    ///                 above, see DOT11_ADHOC_AUTH_ALGORITHM and DOT11_ADHOC_CIPHER_ALGORITHM.
    ///    GeographicalId = The geographical location in which the network was created. For a list of possible values, see Table of
    ///                     Geographical Locations.
    ///    fSaveProfile = An optional parameter that specifies whether a wireless profile should be saved. If <b>TRUE</b>, the profile
    ///                   is saved to the profile store. Once a profile is saved, the user can modify the profile using the <b>Manage
    ///                   Wireless Network</b> user interface. Profiles can also be modified using the Native Wifi Functions. Saving a
    ///                   profile modifies the network signature returned by IDot11AdHocNetwork::GetSignature.
    ///    fMakeSavedProfileUserSpecific = An optional parameter that specifies whether the profile to be saved is an all-user profile. If set to
    ///                                    <b>TRUE</b>, the profile is specific to the current user. If set to <b>FALSE</b>, the profile is an all-user
    ///                                    profile and can be used by any user logged into the machine. This parameter is ignored if <i>fSaveProfile</i>
    ///                                    is <b>FALSE</b>. By default, only members of the Administrators group can save an all-user profile. These
    ///                                    security settings can be altered using the WlanSetSecuritySettings function. Your application must be
    ///                                    launched by a user with sufficient privileges for an all-user profile to be saved successfully. If your
    ///                                    application is running in a Remote Desktop window, you can only save an all-user profile. User-specific
    ///                                    profiles cannot be saved from an application running remotely.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT Connect(const(wchar)* Passphrase, int GeographicalId, ubyte fSaveProfile, 
                    ubyte fMakeSavedProfileUserSpecific);
    ///Disconnects from an ad hoc network.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT Disconnect();
}

///The <b>IDot11AdHocNetworkNotificationSink</b> interface defines the notifications supported by the IDot11AdHocNetwork
///interface. To register for notifications, call the Advise method on an instantiated IDot11AdHocManager object with
///the <b>IDot11AdHocNetworkNotificationSink</b> interface passed as the <i>pUnk</i> parameter. To terminate
///notifications, call the Unadvise method. <div class="alert"><b>Note</b> Ad hoc mode might not be available in future
///versions of Windows. Starting with Windows 8.1 and Windows Server 2012 R2, use Wi-Fi Direct instead.</div><div>
///</div>
@GUID("8F10CC2A-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocNetworkNotificationSink : IUnknown
{
    ///Notifies the client that the connection status of the network has changed.
    ///Params:
    ///    eStatus = A DOT11_ADHOC_NETWORK_CONNECTION_STATUS value that specifies the updated connection status.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT OnStatusChange(DOT11_ADHOC_NETWORK_CONNECTION_STATUS eStatus);
    ///Notifies the client that a connection attempt failed. The connection attempt may have been initiated by the
    ///client itself or by another application using the IDot11AdHocNetwork methods or the Native Wifi functions.
    ///Params:
    ///    eFailReason = A DOT11_ADHOC_CONNECT_FAIL_REASON value that specifies the reason the connection attempt failed.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT OnConnectFail(DOT11_ADHOC_CONNECT_FAIL_REASON eFailReason);
}

///Represents a wireless network interface card (NIC). <div class="alert"><b>Note</b> Ad hoc mode might not be available
///in future versions of Windows. Starting with Windows 8.1 and Windows Server 2012 R2, use Wi-Fi Direct
///instead.</div><div> </div>
@GUID("8F10CC2B-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocInterface : IUnknown
{
    ///Gets the signature of the NIC. This signature is stored in the registry and it is used by TCP/IP to uniquely
    ///identify the NIC.
    ///Params:
    ///    pSignature = The signature of the NIC.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetDeviceSignature(GUID* pSignature);
    ///Gets the friendly name of the NIC.
    ///Params:
    ///    ppszName = The friendly name of the NIC. The SSID of the network is used as the friendly name. You must free this string
    ///               using CoTaskMemFree.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetFriendlyName(ushort** ppszName);
    ///Specifies whether the NIC is 802.11d compliant.
    ///Params:
    ///    pf11d = A pointer to a boolean that specifies 802.11d compliance. The boolean value is set to <b>TRUE</b> if the NIC
    ///            is compliant and <b>FALSE</b> otherwise.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT IsDot11d(ubyte* pf11d);
    ///Specifies whether a NIC supports the creation or use of an ad hoc network.
    ///Params:
    ///    pfAdHocCapable = A pointer to a boolean that specifies the NIC's ad hoc network capabilities. The boolean value is set to
    ///                     <b>TRUE</b> if the NIC supports the creation and use of ad hoc networks and <b>FALSE</b> otherwise.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT IsAdHocCapable(ubyte* pfAdHocCapable);
    ///Specifies whether the radio is on.
    ///Params:
    ///    pfIsRadioOn = A pointer to a boolean that specifies the radio state. The value is set to <b>TRUE</b> if the radio is on.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT IsRadioOn(ubyte* pfIsRadioOn);
    ///Gets the network that is currently active on the interface.
    ///Params:
    ///    ppNetwork = A pointer to an IDot11AdHocNetwork object that represents the active network.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetActiveNetwork(IDot11AdHocNetwork* ppNetwork);
    ///Gets the collection of security settings associated with this NIC.
    ///Params:
    ///    ppEnum = A pointer to an IEnumDot11AdHocSecuritySettings interface that contains the collection of security settings.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetIEnumSecuritySettings(IEnumDot11AdHocSecuritySettings* ppEnum);
    ///Gets the collection of networks associated with this NIC.
    ///Params:
    ///    pFilterGuid = An optional parameter that specifies the GUID of the application that created the network. An application can
    ///                  use this identifier to limit the networks enumerated to networks created by the application. For this
    ///                  filtering to work correctly, all instances of the application on all machines must use the same GUID.
    ///    ppEnum = A pointer to a IEnumDot11AdHocNetworks interface that contains the enumerated networks.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetIEnumDot11AdHocNetworks(GUID* pFilterGuid, IEnumDot11AdHocNetworks* ppEnum);
    ///Gets the connection status of the active network associated with this NIC. You can determine the active network
    ///by calling IDot11AdHocInterface::GetActiveNetwork.
    ///Params:
    ///    pState = A pointer to a DOT11_ADHOC_NETWORK_CONNECTION_STATUS value that specifies the connection state.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory required
    ///    to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetStatus(DOT11_ADHOC_NETWORK_CONNECTION_STATUS* pState);
}

///This interface represents the collection of currently visible 802.11 ad hoc network interfaces. It is a standard
///enumerator. <div class="alert"><b>Note</b> Ad hoc mode might not be available in future versions of Windows. Starting
///with Windows 8.1 and Windows Server 2012 R2, use Wi-Fi Direct instead.</div><div> </div>
@GUID("8F10CC2C-CF0D-42A0-ACBE-E2DE7007384D")
interface IEnumDot11AdHocInterfaces : IUnknown
{
    ///Gets the specified number of elements from the sequence and advances the current position by the number of items
    ///retrieved. If there are fewer than the requested number of elements left in the sequence, it retrieves the
    ///remaining elements.
    ///Params:
    ///    cElt = The number of elements requested.
    ///    rgElt = A pointer to a variable that, on successful return, points to an array of pointers to IDot11AdHocInterface
    ///            interfaces. The array is of size <i>cElt</i>.
    ///    pcEltFetched = A pointer to a variable that specifies the number of elements returned in <i>rgElt</i>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT Next(uint cElt, IDot11AdHocInterface* rgElt, uint* pcEltFetched);
    ///Skips over the next specified number of elements in the enumeration sequence.
    ///Params:
    ///    cElt = The number of elements to skip.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT Skip(uint cElt);
    ///Resets to the beginning of the enumeration sequence.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Creates a new enumeration interface.
    ///Params:
    ///    ppEnum = A pointer that, on successful return, points to an IEnumDot11AdHocInterfacesinterface.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT Clone(IEnumDot11AdHocInterfaces* ppEnum);
}

///This interface represents the collection of security settings associated with each visible wireless ad hoc network.
///It is a standard enumerator. <div class="alert"><b>Note</b> Ad hoc mode might not be available in future versions of
///Windows. Starting with Windows 8.1 and Windows Server 2012 R2, use Wi-Fi Direct instead.</div><div> </div>
@GUID("8F10CC2D-CF0D-42A0-ACBE-E2DE7007384D")
interface IEnumDot11AdHocSecuritySettings : IUnknown
{
    ///Gets the specified number of elements from the sequence and advances the current position by the number of items
    ///retrieved. If there are fewer than the requested number of elements left in the sequence, it retrieves the
    ///remaining elements.
    ///Params:
    ///    cElt = The number of elements requested.
    ///    rgElt = A pointer to a variable that, on successful return, points an array of pointers to
    ///            IDot11AdHocSecuritySettings interfaces. The array is of size <i>cElt</i>.
    ///    pcEltFetched = A pointer to a variable that specifies the number of elements returned in <i>rgElt</i>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT Next(uint cElt, IDot11AdHocSecuritySettings* rgElt, uint* pcEltFetched);
    ///Skips over the next specified number of elements in the enumeration sequence.
    ///Params:
    ///    cElt = The number of elements to skip.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT Skip(uint cElt);
    ///Resets to the beginning of the enumeration sequence.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Creates a new enumeration interface.
    ///Params:
    ///    ppEnum = A pointer that, on successful return, points to an IEnumDot11AdHocSecuritySettingsinterface.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> A specified interface is not supported. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer passed as a parameter is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT Clone(IEnumDot11AdHocSecuritySettings* ppEnum);
}

///The <b>IDot11AdHocSecuritySettings</b> interface specifies the security settings for a wireless ad hoc network. <div
///class="alert"><b>Note</b> Ad hoc mode might not be available in future versions of Windows. Starting with Windows 8.1
///and Windows Server 2012 R2, use Wi-Fi Direct instead.</div><div> </div>
@GUID("8F10CC2E-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocSecuritySettings : IUnknown
{
    ///Gets the authentication algorithm associated with the security settings. The authentication algorithm is used to
    ///authenticate machines and users connecting to the ad hoc network associated with an interface.
    ///Params:
    ///    pAuth = A pointer to a DOT11_ADHOC_AUTH_ALGORITHM value that specifies the authentication algorithm.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The value pointed to by <i>pAuth</i> is invalid. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory
    ///    required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> The pointer <i>pAuth</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetDot11AuthAlgorithm(DOT11_ADHOC_AUTH_ALGORITHM* pAuth);
    ///Gets the cipher algorithm associated with the security settings. The cipher algorithm is used to encrypt and
    ///decrypt information sent on the ad hoc network associated with an interface.
    ///Params:
    ///    pCipher = A pointer to a DOT11_ADHOC_CIPHER_ALGORITHM value that specifies the cipher algorithm.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The value pointed to by <i>pCipher</i> is invalid. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate the memory
    ///    required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> The pointer <i>pCipher</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetDot11CipherAlgorithm(DOT11_ADHOC_CIPHER_ALGORITHM* pCipher);
}

///The <b>IDot11AdHocInterfaceNotificationSink</b> interface defines the notifications supported by
///IDot11AdHocInterface. To register for notifications, call the Advise method on an instantiated IDot11AdHocManager
///object with the <b>IDot11AdHocInterfaceNotificationSink</b> interface passed as the <i>pUnk</i> parameter. To
///terminate notifications, call the Unadvise method. <div class="alert"><b>Note</b> Ad hoc mode might not be available
///in future versions of Windows. Starting with Windows 8.1 and Windows Server 2012 R2, use Wi-Fi Direct
///instead.</div><div> </div>
@GUID("8F10CC2F-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocInterfaceNotificationSink : IUnknown
{
    ///Notifies the client that the connection status of the network associated with the NIC has changed.
    ///Params:
    ///    eStatus = A pointer to a DOT11_ADHOC_NETWORK_CONNECTION_STATUS value that specifies the new connection state.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT OnConnectionStatusChange(DOT11_ADHOC_NETWORK_CONNECTION_STATUS eStatus);
}


// GUIDs

const GUID CLSID_Dot11AdHocManager = GUIDOF!Dot11AdHocManager;

const GUID IID_IDot11AdHocInterface                 = GUIDOF!IDot11AdHocInterface;
const GUID IID_IDot11AdHocInterfaceNotificationSink = GUIDOF!IDot11AdHocInterfaceNotificationSink;
const GUID IID_IDot11AdHocManager                   = GUIDOF!IDot11AdHocManager;
const GUID IID_IDot11AdHocManagerNotificationSink   = GUIDOF!IDot11AdHocManagerNotificationSink;
const GUID IID_IDot11AdHocNetwork                   = GUIDOF!IDot11AdHocNetwork;
const GUID IID_IDot11AdHocNetworkNotificationSink   = GUIDOF!IDot11AdHocNetworkNotificationSink;
const GUID IID_IDot11AdHocSecuritySettings          = GUIDOF!IDot11AdHocSecuritySettings;
const GUID IID_IEnumDot11AdHocInterfaces            = GUIDOF!IEnumDot11AdHocInterfaces;
const GUID IID_IEnumDot11AdHocNetworks              = GUIDOF!IEnumDot11AdHocNetworks;
const GUID IID_IEnumDot11AdHocSecuritySettings      = GUIDOF!IEnumDot11AdHocSecuritySettings;
