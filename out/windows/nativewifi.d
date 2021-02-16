module windows.nativewifi;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.extensibleauthenticationprotocol : EAP_METHOD_TYPE;
public import windows.iphelper : NET_LUID_LH;
public import windows.networkdrivers : L2_NOTIFICATION_DATA, NET_IF_DIRECTION_TYPE, NET_IF_MEDIA_CONNECT_STATE,
                                       NET_IF_MEDIA_DUPLEX_STATE, NET_IF_OPER_STATUS;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    dot11_BSS_type_infrastructure = 0x00000001,
    dot11_BSS_type_independent    = 0x00000002,
    dot11_BSS_type_any            = 0x00000003,
}
alias DOT11_BSS_TYPE = int;

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
alias DOT11_AUTH_ALGORITHM = int;

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
alias DOT11_CIPHER_ALGORITHM = int;

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
alias NDIS_REQUEST_TYPE = int;

enum : int
{
    NdisInterruptModerationUnknown      = 0x00000000,
    NdisInterruptModerationNotSupported = 0x00000001,
    NdisInterruptModerationEnabled      = 0x00000002,
    NdisInterruptModerationDisabled     = 0x00000003,
}
alias NDIS_INTERRUPT_MODERATION = int;

enum : int
{
    Ndis802_11StatusType_Authentication      = 0x00000000,
    Ndis802_11StatusType_MediaStreamMode     = 0x00000001,
    Ndis802_11StatusType_PMKID_CandidateList = 0x00000002,
    Ndis802_11StatusTypeMax                  = 0x00000003,
}
alias NDIS_802_11_STATUS_TYPE = int;

enum : int
{
    Ndis802_11FH             = 0x00000000,
    Ndis802_11DS             = 0x00000001,
    Ndis802_11OFDM5          = 0x00000002,
    Ndis802_11OFDM24         = 0x00000003,
    Ndis802_11Automode       = 0x00000004,
    Ndis802_11NetworkTypeMax = 0x00000005,
}
alias NDIS_802_11_NETWORK_TYPE = int;

enum : int
{
    Ndis802_11PowerModeCAM      = 0x00000000,
    Ndis802_11PowerModeMAX_PSP  = 0x00000001,
    Ndis802_11PowerModeFast_PSP = 0x00000002,
    Ndis802_11PowerModeMax      = 0x00000003,
}
alias NDIS_802_11_POWER_MODE = int;

enum : int
{
    Ndis802_11IBSS              = 0x00000000,
    Ndis802_11Infrastructure    = 0x00000001,
    Ndis802_11AutoUnknown       = 0x00000002,
    Ndis802_11InfrastructureMax = 0x00000003,
}
alias NDIS_802_11_NETWORK_INFRASTRUCTURE = int;

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
alias NDIS_802_11_AUTHENTICATION_MODE = int;

enum : int
{
    Ndis802_11PrivFilterAcceptAll = 0x00000000,
    Ndis802_11PrivFilter8021xWEP  = 0x00000001,
}
alias NDIS_802_11_PRIVACY_FILTER = int;

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
alias NDIS_802_11_WEP_STATUS = int;

enum : int
{
    Ndis802_11ReloadWEPKeys = 0x00000000,
}
alias NDIS_802_11_RELOAD_DEFAULTS = int;

enum : int
{
    Ndis802_11MediaStreamOff = 0x00000000,
    Ndis802_11MediaStreamOn  = 0x00000001,
}
alias NDIS_802_11_MEDIA_STREAM_MODE = int;

enum : int
{
    Ndis802_11RadioStatusOn                  = 0x00000000,
    Ndis802_11RadioStatusHardwareOff         = 0x00000001,
    Ndis802_11RadioStatusSoftwareOff         = 0x00000002,
    Ndis802_11RadioStatusHardwareSoftwareOff = 0x00000003,
    Ndis802_11RadioStatusMax                 = 0x00000004,
}
alias NDIS_802_11_RADIO_STATUS = int;

enum : int
{
    AUTHENTICATE = 0x00000001,
    ENCRYPT      = 0x00000002,
}
alias OFFLOAD_OPERATION_E = int;

enum : int
{
    OFFLOAD_IPSEC_CONF_NONE     = 0x00000000,
    OFFLOAD_IPSEC_CONF_DES      = 0x00000001,
    OFFLOAD_IPSEC_CONF_RESERVED = 0x00000002,
    OFFLOAD_IPSEC_CONF_3_DES    = 0x00000003,
    OFFLOAD_IPSEC_CONF_MAX      = 0x00000004,
}
alias OFFLOAD_CONF_ALGO = int;

enum : int
{
    OFFLOAD_IPSEC_INTEGRITY_NONE = 0x00000000,
    OFFLOAD_IPSEC_INTEGRITY_MD5  = 0x00000001,
    OFFLOAD_IPSEC_INTEGRITY_SHA  = 0x00000002,
    OFFLOAD_IPSEC_INTEGRITY_MAX  = 0x00000003,
}
alias OFFLOAD_INTEGRITY_ALGO = int;

enum : int
{
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_IKE   = 0x00000000,
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_OTHER = 0x00000001,
}
alias UDP_ENCAP_TYPE = int;

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
alias NDIS_MEDIUM = int;

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
alias NDIS_PHYSICAL_MEDIUM = int;

enum : int
{
    NdisHardwareStatusReady        = 0x00000000,
    NdisHardwareStatusInitializing = 0x00000001,
    NdisHardwareStatusReset        = 0x00000002,
    NdisHardwareStatusClosing      = 0x00000003,
    NdisHardwareStatusNotReady     = 0x00000004,
}
alias NDIS_HARDWARE_STATUS = int;

enum : int
{
    NdisDeviceStateUnspecified = 0x00000000,
    NdisDeviceStateD0          = 0x00000001,
    NdisDeviceStateD1          = 0x00000002,
    NdisDeviceStateD2          = 0x00000003,
    NdisDeviceStateD3          = 0x00000004,
    NdisDeviceStateMaximum     = 0x00000005,
}
alias NDIS_DEVICE_POWER_STATE = int;

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
alias NDIS_FDDI_ATTACHMENT_TYPE = int;

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
alias NDIS_FDDI_RING_MGT_STATE = int;

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
alias NDIS_FDDI_LCONNECTION_STATE = int;

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
alias NDIS_WAN_MEDIUM_SUBTYPE = int;

enum : int
{
    NdisWanHeaderNative   = 0x00000000,
    NdisWanHeaderEthernet = 0x00000001,
}
alias NDIS_WAN_HEADER_FORMAT = int;

enum : int
{
    NdisWanRaw          = 0x00000000,
    NdisWanErrorControl = 0x00000001,
    NdisWanReliable     = 0x00000002,
}
alias NDIS_WAN_QUALITY = int;

enum : int
{
    NdisRingStateOpened      = 0x00000001,
    NdisRingStateClosed      = 0x00000002,
    NdisRingStateOpening     = 0x00000003,
    NdisRingStateClosing     = 0x00000004,
    NdisRingStateOpenFailure = 0x00000005,
    NdisRingStateRingFailure = 0x00000006,
}
alias NDIS_802_5_RING_STATE = int;

enum : int
{
    NdisMediaStateConnected    = 0x00000000,
    NdisMediaStateDisconnected = 0x00000001,
}
alias NDIS_MEDIA_STATE = int;

enum : int
{
    NdisPauseFunctionsUnsupported    = 0x00000000,
    NdisPauseFunctionsSendOnly       = 0x00000001,
    NdisPauseFunctionsReceiveOnly    = 0x00000002,
    NdisPauseFunctionsSendAndReceive = 0x00000003,
    NdisPauseFunctionsUnknown        = 0x00000004,
}
alias NDIS_SUPPORTED_PAUSE_FUNCTIONS = int;

enum : int
{
    NdisPortTypeUndefined       = 0x00000000,
    NdisPortTypeBridge          = 0x00000001,
    NdisPortTypeRasConnection   = 0x00000002,
    NdisPortType8021xSupplicant = 0x00000003,
    NdisPortTypeMax             = 0x00000004,
}
alias NDIS_PORT_TYPE = int;

enum : int
{
    NdisPortAuthorizationUnknown = 0x00000000,
    NdisPortAuthorized           = 0x00000001,
    NdisPortUnauthorized         = 0x00000002,
    NdisPortReauthorizing        = 0x00000003,
}
alias NDIS_PORT_AUTHORIZATION_STATE = int;

enum : int
{
    NdisPortControlStateUnknown      = 0x00000000,
    NdisPortControlStateControlled   = 0x00000001,
    NdisPortControlStateUncontrolled = 0x00000002,
}
alias NDIS_PORT_CONTROL_STATE = int;

enum : int
{
    NdisPossibleNetworkChange         = 0x00000001,
    NdisDefinitelyNetworkChange       = 0x00000002,
    NdisNetworkChangeFromMediaConnect = 0x00000003,
    NdisNetworkChangeMax              = 0x00000004,
}
alias NDIS_NETWORK_CHANGE_TYPE = int;

enum : int
{
    NdisProcessorVendorUnknown      = 0x00000000,
    NdisProcessorVendorGenuinIntel  = 0x00000001,
    NdisProcessorVendorGenuineIntel = 0x00000001,
    NdisProcessorVendorAuthenticAMD = 0x00000002,
}
alias NDIS_PROCESSOR_VENDOR = int;

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
alias DOT11_PHY_TYPE = int;

enum : int
{
    dot11_offload_type_wep  = 0x00000001,
    dot11_offload_type_auth = 0x00000002,
}
alias DOT11_OFFLOAD_TYPE = int;

enum : int
{
    dot11_key_direction_both     = 0x00000001,
    dot11_key_direction_inbound  = 0x00000002,
    dot11_key_direction_outbound = 0x00000003,
}
alias DOT11_KEY_DIRECTION = int;

enum : int
{
    dot11_scan_type_active  = 0x00000001,
    dot11_scan_type_passive = 0x00000002,
    dot11_scan_type_auto    = 0x00000003,
    dot11_scan_type_forced  = 0x80000000,
}
alias DOT11_SCAN_TYPE = int;

enum : int
{
    ch_description_type_logical          = 0x00000001,
    ch_description_type_center_frequency = 0x00000002,
    ch_description_type_phy_specific     = 0x00000003,
}
alias CH_DESCRIPTION_TYPE = int;

enum : int
{
    dot11_update_ie_op_create_replace = 0x00000001,
    dot11_update_ie_op_delete         = 0x00000002,
}
alias DOT11_UPDATE_IE_OP = int;

enum : int
{
    dot11_reset_type_phy         = 0x00000001,
    dot11_reset_type_mac         = 0x00000002,
    dot11_reset_type_phy_and_mac = 0x00000003,
}
alias DOT11_RESET_TYPE = int;

enum : int
{
    dot11_power_mode_unknown   = 0x00000000,
    dot11_power_mode_active    = 0x00000001,
    dot11_power_mode_powersave = 0x00000002,
}
alias DOT11_POWER_MODE = int;

enum : int
{
    dot11_temp_type_unknown = 0x00000000,
    dot11_temp_type_1       = 0x00000001,
    dot11_temp_type_2       = 0x00000002,
}
alias DOT11_TEMP_TYPE = int;

enum : int
{
    dot11_diversity_support_unknown      = 0x00000000,
    dot11_diversity_support_fixedlist    = 0x00000001,
    dot11_diversity_support_notsupported = 0x00000002,
    dot11_diversity_support_dynamic      = 0x00000003,
}
alias DOT11_DIVERSITY_SUPPORT = int;

enum : int
{
    dot11_hop_algo_current   = 0x00000000,
    dot11_hop_algo_hop_index = 0x00000001,
    dot11_hop_algo_hcc       = 0x00000002,
}
alias DOT11_HOP_ALGO_ADOPTED = int;

enum : int
{
    dot11_AC_param_BE  = 0x00000000,
    dot11_AC_param_BK  = 0x00000001,
    dot11_AC_param_VI  = 0x00000002,
    dot11_AC_param_VO  = 0x00000003,
    dot11_AC_param_max = 0x00000004,
}
alias DOT11_AC_PARAM = int;

enum : int
{
    DOT11_DIR_INBOUND  = 0x00000001,
    DOT11_DIR_OUTBOUND = 0x00000002,
    DOT11_DIR_BOTH     = 0x00000003,
}
alias DOT11_DIRECTION = int;

enum : int
{
    dot11_assoc_state_zero           = 0x00000000,
    dot11_assoc_state_unauth_unassoc = 0x00000001,
    dot11_assoc_state_auth_unassoc   = 0x00000002,
    dot11_assoc_state_auth_assoc     = 0x00000003,
}
alias DOT11_ASSOCIATION_STATE = int;

enum : int
{
    DOT11_DS_CHANGED   = 0x00000000,
    DOT11_DS_UNCHANGED = 0x00000001,
    DOT11_DS_UNKNOWN   = 0x00000002,
}
alias DOT11_DS_INFO = int;

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
alias DOT11_WPS_CONFIG_METHOD = int;

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
alias DOT11_WPS_DEVICE_PASSWORD_ID = int;

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
alias DOT11_ANQP_QUERY_RESULT = int;

enum : int
{
    dot11_wfd_discover_type_scan_only            = 0x00000001,
    dot11_wfd_discover_type_find_only            = 0x00000002,
    dot11_wfd_discover_type_auto                 = 0x00000003,
    dot11_wfd_discover_type_scan_social_channels = 0x00000004,
    dot11_wfd_discover_type_forced               = 0x80000000,
}
alias DOT11_WFD_DISCOVER_TYPE = int;

enum : int
{
    dot11_wfd_scan_type_active  = 0x00000001,
    dot11_wfd_scan_type_passive = 0x00000002,
    dot11_wfd_scan_type_auto    = 0x00000003,
}
alias DOT11_WFD_SCAN_TYPE = int;

enum : int
{
    dot11_power_mode_reason_no_change            = 0x00000000,
    dot11_power_mode_reason_noncompliant_AP      = 0x00000001,
    dot11_power_mode_reason_legacy_WFD_device    = 0x00000002,
    dot11_power_mode_reason_compliant_AP         = 0x00000003,
    dot11_power_mode_reason_compliant_WFD_device = 0x00000004,
    dot11_power_mode_reason_others               = 0x00000005,
}
alias DOT11_POWER_MODE_REASON = int;

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
alias DOT11_MANUFACTURING_TEST_TYPE = int;

enum : int
{
    DOT11_MANUFACTURING_SELF_TEST_TYPE_INTERFACE      = 0x00000001,
    DOT11_MANUFACTURING_SELF_TEST_TYPE_RF_INTERFACE   = 0x00000002,
    DOT11_MANUFACTURING_SELF_TEST_TYPE_BT_COEXISTENCE = 0x00000003,
}
alias DOT11_MANUFACTURING_SELF_TEST_TYPE = int;

enum : int
{
    dot11_band_2p4g = 0x00000001,
    dot11_band_4p9g = 0x00000002,
    dot11_band_5g   = 0x00000003,
}
alias DOT11_BAND = int;

enum : int
{
    dot11_manufacturing_callback_unknown            = 0x00000000,
    dot11_manufacturing_callback_self_test_complete = 0x00000001,
    dot11_manufacturing_callback_sleep_complete     = 0x00000002,
    dot11_manufacturing_callback_IHV_start          = 0x80000000,
    dot11_manufacturing_callback_IHV_end            = 0xffffffff,
}
alias DOT11_MANUFACTURING_CALLBACK_TYPE = int;

enum : int
{
    wlan_connection_mode_profile            = 0x00000000,
    wlan_connection_mode_temporary_profile  = 0x00000001,
    wlan_connection_mode_discovery_secure   = 0x00000002,
    wlan_connection_mode_discovery_unsecure = 0x00000003,
    wlan_connection_mode_auto               = 0x00000004,
    wlan_connection_mode_invalid            = 0x00000005,
}
alias WLAN_CONNECTION_MODE = int;

enum : int
{
    wlan_interface_state_not_ready             = 0x00000000,
    wlan_interface_state_connected             = 0x00000001,
    wlan_interface_state_ad_hoc_network_formed = 0x00000002,
    wlan_interface_state_disconnecting         = 0x00000003,
    wlan_interface_state_disconnected          = 0x00000004,
    wlan_interface_state_associating           = 0x00000005,
    wlan_interface_state_discovering           = 0x00000006,
    wlan_interface_state_authenticating        = 0x00000007,
}
alias WLAN_INTERFACE_STATE = int;

enum : int
{
    wlan_adhoc_network_state_formed    = 0x00000000,
    wlan_adhoc_network_state_connected = 0x00000001,
}
alias WLAN_ADHOC_NETWORK_STATE = int;

enum : int
{
    dot11_radio_state_unknown = 0x00000000,
    dot11_radio_state_on      = 0x00000001,
    dot11_radio_state_off     = 0x00000002,
}
alias DOT11_RADIO_STATE = int;

enum : int
{
    wlan_operational_state_unknown   = 0x00000000,
    wlan_operational_state_off       = 0x00000001,
    wlan_operational_state_on        = 0x00000002,
    wlan_operational_state_going_off = 0x00000003,
    wlan_operational_state_going_on  = 0x00000004,
}
alias WLAN_OPERATIONAL_STATE = int;

enum : int
{
    wlan_interface_type_emulated_802_11 = 0x00000000,
    wlan_interface_type_native_802_11   = 0x00000001,
    wlan_interface_type_invalid         = 0x00000002,
}
alias WLAN_INTERFACE_TYPE = int;

enum : int
{
    wlan_power_setting_no_saving      = 0x00000000,
    wlan_power_setting_low_saving     = 0x00000001,
    wlan_power_setting_medium_saving  = 0x00000002,
    wlan_power_setting_maximum_saving = 0x00000003,
    wlan_power_setting_invalid        = 0x00000004,
}
alias WLAN_POWER_SETTING = int;

enum : int
{
    wlan_notification_acm_start                      = 0x00000000,
    wlan_notification_acm_autoconf_enabled           = 0x00000001,
    wlan_notification_acm_autoconf_disabled          = 0x00000002,
    wlan_notification_acm_background_scan_enabled    = 0x00000003,
    wlan_notification_acm_background_scan_disabled   = 0x00000004,
    wlan_notification_acm_bss_type_change            = 0x00000005,
    wlan_notification_acm_power_setting_change       = 0x00000006,
    wlan_notification_acm_scan_complete              = 0x00000007,
    wlan_notification_acm_scan_fail                  = 0x00000008,
    wlan_notification_acm_connection_start           = 0x00000009,
    wlan_notification_acm_connection_complete        = 0x0000000a,
    wlan_notification_acm_connection_attempt_fail    = 0x0000000b,
    wlan_notification_acm_filter_list_change         = 0x0000000c,
    wlan_notification_acm_interface_arrival          = 0x0000000d,
    wlan_notification_acm_interface_removal          = 0x0000000e,
    wlan_notification_acm_profile_change             = 0x0000000f,
    wlan_notification_acm_profile_name_change        = 0x00000010,
    wlan_notification_acm_profiles_exhausted         = 0x00000011,
    wlan_notification_acm_network_not_available      = 0x00000012,
    wlan_notification_acm_network_available          = 0x00000013,
    wlan_notification_acm_disconnecting              = 0x00000014,
    wlan_notification_acm_disconnected               = 0x00000015,
    wlan_notification_acm_adhoc_network_state_change = 0x00000016,
    wlan_notification_acm_profile_unblocked          = 0x00000017,
    wlan_notification_acm_screen_power_change        = 0x00000018,
    wlan_notification_acm_profile_blocked            = 0x00000019,
    wlan_notification_acm_scan_list_refresh          = 0x0000001a,
    wlan_notification_acm_operational_state_change   = 0x0000001b,
    wlan_notification_acm_end                        = 0x0000001c,
}
alias WLAN_NOTIFICATION_ACM = int;

enum : int
{
    wlan_notification_msm_start                         = 0x00000000,
    wlan_notification_msm_associating                   = 0x00000001,
    wlan_notification_msm_associated                    = 0x00000002,
    wlan_notification_msm_authenticating                = 0x00000003,
    wlan_notification_msm_connected                     = 0x00000004,
    wlan_notification_msm_roaming_start                 = 0x00000005,
    wlan_notification_msm_roaming_end                   = 0x00000006,
    wlan_notification_msm_radio_state_change            = 0x00000007,
    wlan_notification_msm_signal_quality_change         = 0x00000008,
    wlan_notification_msm_disassociating                = 0x00000009,
    wlan_notification_msm_disconnected                  = 0x0000000a,
    wlan_notification_msm_peer_join                     = 0x0000000b,
    wlan_notification_msm_peer_leave                    = 0x0000000c,
    wlan_notification_msm_adapter_removal               = 0x0000000d,
    wlan_notification_msm_adapter_operation_mode_change = 0x0000000e,
    wlan_notification_msm_link_degraded                 = 0x0000000f,
    wlan_notification_msm_link_improved                 = 0x00000010,
    wlan_notification_msm_end                           = 0x00000011,
}
alias WLAN_NOTIFICATION_MSM = int;

enum : int
{
    wlan_notification_security_start = 0x00000000,
    wlan_notification_security_end   = 0x00000001,
}
alias WLAN_NOTIFICATION_SECURITY = int;

enum : int
{
    wlan_opcode_value_type_query_only          = 0x00000000,
    wlan_opcode_value_type_set_by_group_policy = 0x00000001,
    wlan_opcode_value_type_set_by_user         = 0x00000002,
    wlan_opcode_value_type_invalid             = 0x00000003,
}
alias WLAN_OPCODE_VALUE_TYPE = int;

enum : int
{
    wlan_intf_opcode_autoconf_start                             = 0x00000000,
    wlan_intf_opcode_autoconf_enabled                           = 0x00000001,
    wlan_intf_opcode_background_scan_enabled                    = 0x00000002,
    wlan_intf_opcode_media_streaming_mode                       = 0x00000003,
    wlan_intf_opcode_radio_state                                = 0x00000004,
    wlan_intf_opcode_bss_type                                   = 0x00000005,
    wlan_intf_opcode_interface_state                            = 0x00000006,
    wlan_intf_opcode_current_connection                         = 0x00000007,
    wlan_intf_opcode_channel_number                             = 0x00000008,
    wlan_intf_opcode_supported_infrastructure_auth_cipher_pairs = 0x00000009,
    wlan_intf_opcode_supported_adhoc_auth_cipher_pairs          = 0x0000000a,
    wlan_intf_opcode_supported_country_or_region_string_list    = 0x0000000b,
    wlan_intf_opcode_current_operation_mode                     = 0x0000000c,
    wlan_intf_opcode_supported_safe_mode                        = 0x0000000d,
    wlan_intf_opcode_certified_safe_mode                        = 0x0000000e,
    wlan_intf_opcode_hosted_network_capable                     = 0x0000000f,
    wlan_intf_opcode_management_frame_protection_capable        = 0x00000010,
    wlan_intf_opcode_autoconf_end                               = 0x0fffffff,
    wlan_intf_opcode_msm_start                                  = 0x10000100,
    wlan_intf_opcode_statistics                                 = 0x10000101,
    wlan_intf_opcode_rssi                                       = 0x10000102,
    wlan_intf_opcode_msm_end                                    = 0x1fffffff,
    wlan_intf_opcode_security_start                             = 0x20010000,
    wlan_intf_opcode_security_end                               = 0x2fffffff,
    wlan_intf_opcode_ihv_start                                  = 0x30000000,
    wlan_intf_opcode_ihv_end                                    = 0x3fffffff,
}
alias WLAN_INTF_OPCODE = int;

enum : int
{
    wlan_autoconf_opcode_start                                     = 0x00000000,
    wlan_autoconf_opcode_show_denied_networks                      = 0x00000001,
    wlan_autoconf_opcode_power_setting                             = 0x00000002,
    wlan_autoconf_opcode_only_use_gp_profiles_for_allowed_networks = 0x00000003,
    wlan_autoconf_opcode_allow_explicit_creds                      = 0x00000004,
    wlan_autoconf_opcode_block_period                              = 0x00000005,
    wlan_autoconf_opcode_allow_virtual_station_extensibility       = 0x00000006,
    wlan_autoconf_opcode_end                                       = 0x00000007,
}
alias WLAN_AUTOCONF_OPCODE = int;

enum : int
{
    wlan_ihv_control_type_service = 0x00000000,
    wlan_ihv_control_type_driver  = 0x00000001,
}
alias WLAN_IHV_CONTROL_TYPE = int;

enum : int
{
    wlan_filter_list_type_gp_permit   = 0x00000000,
    wlan_filter_list_type_gp_deny     = 0x00000001,
    wlan_filter_list_type_user_permit = 0x00000002,
    wlan_filter_list_type_user_deny   = 0x00000003,
}
alias WLAN_FILTER_LIST_TYPE = int;

enum : int
{
    wlan_secure_permit_list                    = 0x00000000,
    wlan_secure_deny_list                      = 0x00000001,
    wlan_secure_ac_enabled                     = 0x00000002,
    wlan_secure_bc_scan_enabled                = 0x00000003,
    wlan_secure_bss_type                       = 0x00000004,
    wlan_secure_show_denied                    = 0x00000005,
    wlan_secure_interface_properties           = 0x00000006,
    wlan_secure_ihv_control                    = 0x00000007,
    wlan_secure_all_user_profiles_order        = 0x00000008,
    wlan_secure_add_new_all_user_profiles      = 0x00000009,
    wlan_secure_add_new_per_user_profiles      = 0x0000000a,
    wlan_secure_media_streaming_mode_enabled   = 0x0000000b,
    wlan_secure_current_operation_mode         = 0x0000000c,
    wlan_secure_get_plaintext_key              = 0x0000000d,
    wlan_secure_hosted_network_elevated_access = 0x0000000e,
    wlan_secure_virtual_station_extensibility  = 0x0000000f,
    wlan_secure_wfd_elevated_access            = 0x00000010,
    WLAN_SECURABLE_OBJECT_COUNT                = 0x00000011,
}
alias WLAN_SECURABLE_OBJECT = int;

enum : int
{
    WFD_ROLE_TYPE_NONE        = 0x00000000,
    WFD_ROLE_TYPE_DEVICE      = 0x00000001,
    WFD_ROLE_TYPE_GROUP_OWNER = 0x00000002,
    WFD_ROLE_TYPE_CLIENT      = 0x00000004,
    WFD_ROLE_TYPE_MAX         = 0x00000005,
}
alias WFD_ROLE_TYPE = int;

enum : int
{
    WLConnectionPage = 0x00000000,
    WLSecurityPage   = 0x00000001,
    WLAdvPage        = 0x00000002,
}
alias WL_DISPLAY_PAGES = int;

enum : int
{
    wlan_hosted_network_unavailable = 0x00000000,
    wlan_hosted_network_idle        = 0x00000001,
    wlan_hosted_network_active      = 0x00000002,
}
alias WLAN_HOSTED_NETWORK_STATE = int;

enum : int
{
    wlan_hosted_network_reason_success                              = 0x00000000,
    wlan_hosted_network_reason_unspecified                          = 0x00000001,
    wlan_hosted_network_reason_bad_parameters                       = 0x00000002,
    wlan_hosted_network_reason_service_shutting_down                = 0x00000003,
    wlan_hosted_network_reason_insufficient_resources               = 0x00000004,
    wlan_hosted_network_reason_elevation_required                   = 0x00000005,
    wlan_hosted_network_reason_read_only                            = 0x00000006,
    wlan_hosted_network_reason_persistence_failed                   = 0x00000007,
    wlan_hosted_network_reason_crypt_error                          = 0x00000008,
    wlan_hosted_network_reason_impersonation                        = 0x00000009,
    wlan_hosted_network_reason_stop_before_start                    = 0x0000000a,
    wlan_hosted_network_reason_interface_available                  = 0x0000000b,
    wlan_hosted_network_reason_interface_unavailable                = 0x0000000c,
    wlan_hosted_network_reason_miniport_stopped                     = 0x0000000d,
    wlan_hosted_network_reason_miniport_started                     = 0x0000000e,
    wlan_hosted_network_reason_incompatible_connection_started      = 0x0000000f,
    wlan_hosted_network_reason_incompatible_connection_stopped      = 0x00000010,
    wlan_hosted_network_reason_user_action                          = 0x00000011,
    wlan_hosted_network_reason_client_abort                         = 0x00000012,
    wlan_hosted_network_reason_ap_start_failed                      = 0x00000013,
    wlan_hosted_network_reason_peer_arrived                         = 0x00000014,
    wlan_hosted_network_reason_peer_departed                        = 0x00000015,
    wlan_hosted_network_reason_peer_timeout                         = 0x00000016,
    wlan_hosted_network_reason_gp_denied                            = 0x00000017,
    wlan_hosted_network_reason_service_unavailable                  = 0x00000018,
    wlan_hosted_network_reason_device_change                        = 0x00000019,
    wlan_hosted_network_reason_properties_change                    = 0x0000001a,
    wlan_hosted_network_reason_virtual_station_blocking_use         = 0x0000001b,
    wlan_hosted_network_reason_service_available_on_virtual_station = 0x0000001c,
}
alias WLAN_HOSTED_NETWORK_REASON = int;

enum : int
{
    wlan_hosted_network_peer_state_invalid       = 0x00000000,
    wlan_hosted_network_peer_state_authenticated = 0x00000001,
}
alias WLAN_HOSTED_NETWORK_PEER_AUTH_STATE = int;

enum : int
{
    wlan_hosted_network_state_change       = 0x00001000,
    wlan_hosted_network_peer_state_change  = 0x00001001,
    wlan_hosted_network_radio_state_change = 0x00001002,
}
alias WLAN_HOSTED_NETWORK_NOTIFICATION_CODE = int;

enum : int
{
    wlan_hosted_network_opcode_connection_settings = 0x00000000,
    wlan_hosted_network_opcode_security_settings   = 0x00000001,
    wlan_hosted_network_opcode_station_profile     = 0x00000002,
    wlan_hosted_network_opcode_enable              = 0x00000003,
}
alias WLAN_HOSTED_NETWORK_OPCODE = int;

enum : int
{
    OneXAuthIdentityNone         = 0x00000000,
    OneXAuthIdentityMachine      = 0x00000001,
    OneXAuthIdentityUser         = 0x00000002,
    OneXAuthIdentityExplicitUser = 0x00000003,
    OneXAuthIdentityGuest        = 0x00000004,
    OneXAuthIdentityInvalid      = 0x00000005,
}
alias ONEX_AUTH_IDENTITY = int;

enum : int
{
    OneXAuthNotStarted           = 0x00000000,
    OneXAuthInProgress           = 0x00000001,
    OneXAuthNoAuthenticatorFound = 0x00000002,
    OneXAuthSuccess              = 0x00000003,
    OneXAuthFailure              = 0x00000004,
    OneXAuthInvalid              = 0x00000005,
}
alias ONEX_AUTH_STATUS = int;

enum : int
{
    ONEX_REASON_CODE_SUCCESS                       = 0x00000000,
    ONEX_REASON_START                              = 0x00050000,
    ONEX_UNABLE_TO_IDENTIFY_USER                   = 0x00050001,
    ONEX_IDENTITY_NOT_FOUND                        = 0x00050002,
    ONEX_UI_DISABLED                               = 0x00050003,
    ONEX_UI_FAILURE                                = 0x00050004,
    ONEX_EAP_FAILURE_RECEIVED                      = 0x00050005,
    ONEX_AUTHENTICATOR_NO_LONGER_PRESENT           = 0x00050006,
    ONEX_NO_RESPONSE_TO_IDENTITY                   = 0x00050007,
    ONEX_PROFILE_VERSION_NOT_SUPPORTED             = 0x00050008,
    ONEX_PROFILE_INVALID_LENGTH                    = 0x00050009,
    ONEX_PROFILE_DISALLOWED_EAP_TYPE               = 0x0005000a,
    ONEX_PROFILE_INVALID_EAP_TYPE_OR_FLAG          = 0x0005000b,
    ONEX_PROFILE_INVALID_ONEX_FLAGS                = 0x0005000c,
    ONEX_PROFILE_INVALID_TIMER_VALUE               = 0x0005000d,
    ONEX_PROFILE_INVALID_SUPPLICANT_MODE           = 0x0005000e,
    ONEX_PROFILE_INVALID_AUTH_MODE                 = 0x0005000f,
    ONEX_PROFILE_INVALID_EAP_CONNECTION_PROPERTIES = 0x00050010,
    ONEX_UI_CANCELLED                              = 0x00050011,
    ONEX_PROFILE_INVALID_EXPLICIT_CREDENTIALS      = 0x00050012,
    ONEX_PROFILE_EXPIRED_EXPLICIT_CREDENTIALS      = 0x00050013,
    ONEX_UI_NOT_PERMITTED                          = 0x00050014,
}
alias ONEX_REASON_CODE = int;

enum : int
{
    OneXPublicNotificationBase        = 0x00000000,
    OneXNotificationTypeResultUpdate  = 0x00000001,
    OneXNotificationTypeAuthRestarted = 0x00000002,
    OneXNotificationTypeEventInvalid  = 0x00000003,
    OneXNumNotifications              = 0x00000003,
}
alias ONEX_NOTIFICATION_TYPE = int;

enum : int
{
    OneXRestartReasonPeerInitiated            = 0x00000000,
    OneXRestartReasonMsmInitiated             = 0x00000001,
    OneXRestartReasonOneXHeldStateTimeout     = 0x00000002,
    OneXRestartReasonOneXAuthTimeout          = 0x00000003,
    OneXRestartReasonOneXConfigurationChanged = 0x00000004,
    OneXRestartReasonOneXUserChanged          = 0x00000005,
    OneXRestartReasonQuarantineStateChanged   = 0x00000006,
    OneXRestartReasonAltCredsTrial            = 0x00000007,
    OneXRestartReasonInvalid                  = 0x00000008,
}
alias ONEX_AUTH_RESTART_REASON = int;

enum : int
{
    OneXEapMethodBackendSupportUnknown = 0x00000000,
    OneXEapMethodBackendSupported      = 0x00000001,
    OneXEapMethodBackendUnsupported    = 0x00000002,
}
alias ONEX_EAP_METHOD_BACKEND_SUPPORT = int;

enum : int
{
    DOT11_ADHOC_CIPHER_ALGO_INVALID = 0xffffffff,
    DOT11_ADHOC_CIPHER_ALGO_NONE    = 0x00000000,
    DOT11_ADHOC_CIPHER_ALGO_CCMP    = 0x00000004,
    DOT11_ADHOC_CIPHER_ALGO_WEP     = 0x00000101,
}
alias DOT11_ADHOC_CIPHER_ALGORITHM = int;

enum : int
{
    DOT11_ADHOC_AUTH_ALGO_INVALID    = 0xffffffff,
    DOT11_ADHOC_AUTH_ALGO_80211_OPEN = 0x00000001,
    DOT11_ADHOC_AUTH_ALGO_RSNA_PSK   = 0x00000007,
}
alias DOT11_ADHOC_AUTH_ALGORITHM = int;

enum : int
{
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_INVALID      = 0x00000000,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_DISCONNECTED = 0x0000000b,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_CONNECTING   = 0x0000000c,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_CONNECTED    = 0x0000000d,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_FORMED       = 0x0000000e,
}
alias DOT11_ADHOC_NETWORK_CONNECTION_STATUS = int;

enum : int
{
    DOT11_ADHOC_CONNECT_FAIL_DOMAIN_MISMATCH     = 0x00000000,
    DOT11_ADHOC_CONNECT_FAIL_PASSPHRASE_MISMATCH = 0x00000001,
    DOT11_ADHOC_CONNECT_FAIL_OTHER               = 0x00000002,
}
alias DOT11_ADHOC_CONNECT_FAIL_REASON = int;

// Callbacks

alias WLAN_NOTIFICATION_CALLBACK = void function(L2_NOTIFICATION_DATA* param0, void* param1);
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

struct WLAN_PROFILE_INFO
{
    ushort[256] strProfileName;
    uint        dwFlags;
}

struct DOT11_NETWORK
{
    DOT11_SSID     dot11Ssid;
    DOT11_BSS_TYPE dot11BssType;
}

struct WLAN_RAW_DATA
{
    uint     dwDataSize;
    ubyte[1] DataBlob;
}

struct WLAN_RAW_DATA_LIST
{
    uint dwTotalSize;
    uint dwNumberOfItems;
    struct
    {
        uint dwDataOffset;
        uint dwDataSize;
    }
}

struct WLAN_RATE_SET
{
    uint        uRateSetLength;
    ushort[126] usRateSet;
}

struct WLAN_AVAILABLE_NETWORK
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

struct WLAN_BSS_ENTRY
{
    DOT11_SSID     dot11Ssid;
    uint           uPhyId;
    ubyte[6]       dot11Bssid;
    DOT11_BSS_TYPE dot11BssType;
    DOT11_PHY_TYPE dot11BssPhyType;
    int            lRssi;
    uint           uLinkQuality;
    ubyte          bInRegDomain;
    ushort         usBeaconPeriod;
    ulong          ullTimestamp;
    ulong          ullHostTimestamp;
    ushort         usCapabilityInformation;
    uint           ulChCenterFrequency;
    WLAN_RATE_SET  wlanRateSet;
    uint           ulIeOffset;
    uint           ulIeSize;
}

struct WLAN_BSS_LIST
{
    uint              dwTotalSize;
    uint              dwNumberOfItems;
    WLAN_BSS_ENTRY[1] wlanBssEntries;
}

struct WLAN_INTERFACE_INFO
{
    GUID                 InterfaceGuid;
    ushort[256]          strInterfaceDescription;
    WLAN_INTERFACE_STATE isState;
}

struct WLAN_ASSOCIATION_ATTRIBUTES
{
    DOT11_SSID     dot11Ssid;
    DOT11_BSS_TYPE dot11BssType;
    ubyte[6]       dot11Bssid;
    DOT11_PHY_TYPE dot11PhyType;
    uint           uDot11PhyIndex;
    uint           wlanSignalQuality;
    uint           ulRxRate;
    uint           ulTxRate;
}

struct WLAN_SECURITY_ATTRIBUTES
{
    BOOL                 bSecurityEnabled;
    BOOL                 bOneXEnabled;
    DOT11_AUTH_ALGORITHM dot11AuthAlgorithm;
    DOT11_CIPHER_ALGORITHM dot11CipherAlgorithm;
}

struct WLAN_CONNECTION_ATTRIBUTES
{
    WLAN_INTERFACE_STATE isState;
    WLAN_CONNECTION_MODE wlanConnectionMode;
    ushort[256]          strProfileName;
    WLAN_ASSOCIATION_ATTRIBUTES wlanAssociationAttributes;
    WLAN_SECURITY_ATTRIBUTES wlanSecurityAttributes;
}

struct WLAN_PHY_RADIO_STATE
{
    uint              dwPhyIndex;
    DOT11_RADIO_STATE dot11SoftwareRadioState;
    DOT11_RADIO_STATE dot11HardwareRadioState;
}

struct WLAN_RADIO_STATE
{
    uint dwNumberOfPhys;
    WLAN_PHY_RADIO_STATE[64] PhyRadioState;
}

struct WLAN_INTERFACE_CAPABILITY
{
    WLAN_INTERFACE_TYPE interfaceType;
    BOOL                bDot11DSupported;
    uint                dwMaxDesiredSsidListSize;
    uint                dwMaxDesiredBssidListSize;
    uint                dwNumberOfSupportedPhys;
    DOT11_PHY_TYPE[64]  dot11PhyTypes;
}

struct WLAN_AUTH_CIPHER_PAIR_LIST
{
    uint dwNumberOfItems;
    DOT11_AUTH_CIPHER_PAIR[1] pAuthCipherPairList;
}

struct WLAN_COUNTRY_OR_REGION_STRING_LIST
{
    uint     dwNumberOfItems;
    ubyte[3] pCountryOrRegionStringList;
}

struct WLAN_PROFILE_INFO_LIST
{
    uint                 dwNumberOfItems;
    uint                 dwIndex;
    WLAN_PROFILE_INFO[1] ProfileInfo;
}

struct WLAN_AVAILABLE_NETWORK_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    WLAN_AVAILABLE_NETWORK[1] Network;
}

struct WLAN_AVAILABLE_NETWORK_LIST_V2
{
    uint dwNumberOfItems;
    uint dwIndex;
    WLAN_AVAILABLE_NETWORK_V2[1] Network;
}

struct WLAN_INTERFACE_INFO_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    WLAN_INTERFACE_INFO[1] InterfaceInfo;
}

struct DOT11_NETWORK_LIST
{
    uint             dwNumberOfItems;
    uint             dwIndex;
    DOT11_NETWORK[1] Network;
}

struct WLAN_CONNECTION_PARAMETERS
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    const(wchar)*        strProfile;
    DOT11_SSID*          pDot11Ssid;
    DOT11_BSSID_LIST*    pDesiredBssidList;
    DOT11_BSS_TYPE       dot11BssType;
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

struct WLAN_MSM_NOTIFICATION_DATA
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    ushort[256]          strProfileName;
    DOT11_SSID           dot11Ssid;
    DOT11_BSS_TYPE       dot11BssType;
    ubyte[6]             dot11MacAddr;
    BOOL                 bSecurityEnabled;
    BOOL                 bFirstPeer;
    BOOL                 bLastPeer;
    uint                 wlanReasonCode;
}

struct WLAN_CONNECTION_NOTIFICATION_DATA
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    ushort[256]          strProfileName;
    DOT11_SSID           dot11Ssid;
    DOT11_BSS_TYPE       dot11BssType;
    BOOL                 bSecurityEnabled;
    uint                 wlanReasonCode;
    uint                 dwFlags;
    ushort[1]            strProfileXml;
}

struct WLAN_DEVICE_SERVICE_NOTIFICATION_DATA
{
    GUID     DeviceService;
    uint     dwOpCode;
    uint     dwDataSize;
    ubyte[1] DataBlob;
}

struct WLAN_PHY_FRAME_STATISTICS
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

struct WLAN_MAC_FRAME_STATISTICS
{
    ulong ullTransmittedFrameCount;
    ulong ullReceivedFrameCount;
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

struct WLAN_STATISTICS
{
    ulong ullFourWayHandshakeFailures;
    ulong ullTKIPCounterMeasuresInvoked;
    ulong ullReserved;
    WLAN_MAC_FRAME_STATISTICS MacUcastCounters;
    WLAN_MAC_FRAME_STATISTICS MacMcastCounters;
    uint  dwNumberOfPhys;
    WLAN_PHY_FRAME_STATISTICS[1] PhyCounters;
}

struct WLAN_DEVICE_SERVICE_GUID_LIST
{
    uint    dwNumberOfItems;
    uint    dwIndex;
    GUID[1] DeviceService;
}

struct WFD_GROUP_ID
{
    ubyte[6]   DeviceAddress;
    DOT11_SSID GroupSSID;
}

struct WLAN_HOSTED_NETWORK_PEER_STATE
{
    ubyte[6] PeerMacAddress;
    WLAN_HOSTED_NETWORK_PEER_AUTH_STATE PeerAuthState;
}

struct WLAN_HOSTED_NETWORK_RADIO_STATE
{
    DOT11_RADIO_STATE dot11SoftwareRadioState;
    DOT11_RADIO_STATE dot11HardwareRadioState;
}

struct WLAN_HOSTED_NETWORK_STATE_CHANGE
{
    WLAN_HOSTED_NETWORK_STATE OldState;
    WLAN_HOSTED_NETWORK_STATE NewState;
    WLAN_HOSTED_NETWORK_REASON StateChangeReason;
}

struct WLAN_HOSTED_NETWORK_DATA_PEER_STATE_CHANGE
{
    WLAN_HOSTED_NETWORK_PEER_STATE OldState;
    WLAN_HOSTED_NETWORK_PEER_STATE NewState;
    WLAN_HOSTED_NETWORK_REASON PeerStateChangeReason;
}

struct WLAN_HOSTED_NETWORK_CONNECTION_SETTINGS
{
    DOT11_SSID hostedNetworkSSID;
    uint       dwMaxNumberOfPeers;
}

struct WLAN_HOSTED_NETWORK_SECURITY_SETTINGS
{
    DOT11_AUTH_ALGORITHM dot11AuthAlgo;
    DOT11_CIPHER_ALGORITHM dot11CipherAlgo;
}

struct WLAN_HOSTED_NETWORK_STATUS
{
    WLAN_HOSTED_NETWORK_STATE HostedNetworkState;
    GUID           IPDeviceID;
    ubyte[6]       wlanHostedNetworkBSSID;
    DOT11_PHY_TYPE dot11PhyType;
    uint           ulChannelFrequency;
    uint           dwNumberOfPeers;
    WLAN_HOSTED_NETWORK_PEER_STATE[1] PeerList;
}

struct ONEX_VARIABLE_BLOB
{
    uint dwSize;
    uint dwOffset;
}

struct ONEX_AUTH_PARAMS
{
    BOOL               fUpdatePending;
    ONEX_VARIABLE_BLOB oneXConnProfile;
    ONEX_AUTH_IDENTITY authIdentity;
    uint               dwQuarantineState;
    uint               _bitfield86;
    uint               dwSessionId;
    HANDLE             hUserToken;
    ONEX_VARIABLE_BLOB OneXUserProfile;
    ONEX_VARIABLE_BLOB Identity;
    ONEX_VARIABLE_BLOB UserName;
    ONEX_VARIABLE_BLOB Domain;
}

struct ONEX_EAP_ERROR
{
    uint               dwWinError;
    EAP_METHOD_TYPE    type;
    uint               dwReasonCode;
    GUID               rootCauseGuid;
    GUID               repairGuid;
    GUID               helpLinkGuid;
    uint               _bitfield87;
    ONEX_VARIABLE_BLOB RootCauseString;
    ONEX_VARIABLE_BLOB RepairString;
}

struct ONEX_STATUS
{
    ONEX_AUTH_STATUS authStatus;
    uint             dwReason;
    uint             dwError;
}

struct ONEX_RESULT_UPDATE_DATA
{
    ONEX_STATUS        oneXStatus;
    ONEX_EAP_METHOD_BACKEND_SUPPORT BackendSupport;
    BOOL               fBackendEngaged;
    uint               _bitfield88;
    ONEX_VARIABLE_BLOB authParams;
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

@DllImport("wlanapi")
uint WlanOpenHandle(uint dwClientVersion, void* pReserved, uint* pdwNegotiatedVersion, ptrdiff_t* phClientHandle);

@DllImport("wlanapi")
uint WlanCloseHandle(HANDLE hClientHandle, void* pReserved);

@DllImport("wlanapi")
uint WlanEnumInterfaces(HANDLE hClientHandle, void* pReserved, WLAN_INTERFACE_INFO_LIST** ppInterfaceList);

@DllImport("wlanapi")
uint WlanSetAutoConfigParameter(HANDLE hClientHandle, WLAN_AUTOCONF_OPCODE OpCode, uint dwDataSize, char* pData, 
                                void* pReserved);

@DllImport("wlanapi")
uint WlanQueryAutoConfigParameter(HANDLE hClientHandle, WLAN_AUTOCONF_OPCODE OpCode, void* pReserved, 
                                  uint* pdwDataSize, void** ppData, WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType);

@DllImport("wlanapi")
uint WlanGetInterfaceCapability(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, void* pReserved, 
                                WLAN_INTERFACE_CAPABILITY** ppCapability);

@DllImport("wlanapi")
uint WlanSetInterface(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, WLAN_INTF_OPCODE OpCode, uint dwDataSize, 
                      char* pData, void* pReserved);

@DllImport("wlanapi")
uint WlanQueryInterface(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, WLAN_INTF_OPCODE OpCode, 
                        void* pReserved, uint* pdwDataSize, void** ppData, 
                        WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType);

@DllImport("wlanapi")
uint WlanIhvControl(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, WLAN_IHV_CONTROL_TYPE Type, 
                    uint dwInBufferSize, char* pInBuffer, uint dwOutBufferSize, char* pOutBuffer, 
                    uint* pdwBytesReturned);

@DllImport("wlanapi")
uint WlanScan(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(DOT11_SSID)* pDot11Ssid, 
              const(WLAN_RAW_DATA)* pIeData, void* pReserved);

@DllImport("wlanapi")
uint WlanGetAvailableNetworkList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwFlags, void* pReserved, 
                                 WLAN_AVAILABLE_NETWORK_LIST** ppAvailableNetworkList);

@DllImport("wlanapi")
uint WlanGetAvailableNetworkList2(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwFlags, void* pReserved, 
                                  WLAN_AVAILABLE_NETWORK_LIST_V2** ppAvailableNetworkList);

@DllImport("wlanapi")
uint WlanGetNetworkBssList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(DOT11_SSID)* pDot11Ssid, 
                           DOT11_BSS_TYPE dot11BssType, BOOL bSecurityEnabled, void* pReserved, 
                           WLAN_BSS_LIST** ppWlanBssList);

@DllImport("wlanapi")
uint WlanConnect(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                 const(WLAN_CONNECTION_PARAMETERS)* pConnectionParameters, void* pReserved);

@DllImport("wlanapi")
uint WlanConnect2(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                  const(WLAN_CONNECTION_PARAMETERS_V2)* pConnectionParameters, void* pReserved);

@DllImport("wlanapi")
uint WlanDisconnect(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, void* pReserved);

@DllImport("wlanapi")
uint WlanRegisterNotification(HANDLE hClientHandle, uint dwNotifSource, BOOL bIgnoreDuplicate, 
                              WLAN_NOTIFICATION_CALLBACK funcCallback, void* pCallbackContext, void* pReserved, 
                              uint* pdwPrevNotifSource);

@DllImport("wlanapi")
uint WlanGetProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                    void* pReserved, ushort** pstrProfileXml, uint* pdwFlags, uint* pdwGrantedAccess);

@DllImport("wlanapi")
uint WlanSetProfileEapUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                               EAP_METHOD_TYPE eapType, uint dwFlags, uint dwEapUserDataSize, char* pbEapUserData, 
                               void* pReserved);

@DllImport("wlanapi")
uint WlanSetProfileEapXmlUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                                  uint dwFlags, const(wchar)* strEapXmlUserData, void* pReserved);

@DllImport("wlanapi")
uint WlanSetProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwFlags, const(wchar)* strProfileXml, 
                    const(wchar)* strAllUserProfileSecurity, BOOL bOverwrite, void* pReserved, uint* pdwReasonCode);

@DllImport("wlanapi")
uint WlanDeleteProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                       void* pReserved);

@DllImport("wlanapi")
uint WlanRenameProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strOldProfileName, 
                       const(wchar)* strNewProfileName, void* pReserved);

@DllImport("wlanapi")
uint WlanGetProfileList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, void* pReserved, 
                        WLAN_PROFILE_INFO_LIST** ppProfileList);

@DllImport("wlanapi")
uint WlanSetProfileList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwItems, char* strProfileNames, 
                        void* pReserved);

@DllImport("wlanapi")
uint WlanSetProfilePosition(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                            uint dwPosition, void* pReserved);

@DllImport("wlanapi")
uint WlanSetProfileCustomUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                                  uint dwDataSize, char* pData, void* pReserved);

@DllImport("wlanapi")
uint WlanGetProfileCustomUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                                  void* pReserved, uint* pdwDataSize, ubyte** ppData);

@DllImport("wlanapi")
uint WlanSetFilterList(HANDLE hClientHandle, WLAN_FILTER_LIST_TYPE wlanFilterListType, 
                       const(DOT11_NETWORK_LIST)* pNetworkList, void* pReserved);

@DllImport("wlanapi")
uint WlanGetFilterList(HANDLE hClientHandle, WLAN_FILTER_LIST_TYPE wlanFilterListType, void* pReserved, 
                       DOT11_NETWORK_LIST** ppNetworkList);

@DllImport("wlanapi")
uint WlanSetPsdIEDataList(HANDLE hClientHandle, const(wchar)* strFormat, const(WLAN_RAW_DATA_LIST)* pPsdIEDataList, 
                          void* pReserved);

@DllImport("wlanapi")
uint WlanSaveTemporaryProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(wchar)* strProfileName, 
                              const(wchar)* strAllUserProfileSecurity, uint dwFlags, BOOL bOverWrite, 
                              void* pReserved);

@DllImport("wlanapi")
uint WlanDeviceServiceCommand(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, GUID* pDeviceServiceGuid, 
                              uint dwOpCode, uint dwInBufferSize, char* pInBuffer, uint dwOutBufferSize, 
                              char* pOutBuffer, uint* pdwBytesReturned);

@DllImport("wlanapi")
uint WlanGetSupportedDeviceServices(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                                    WLAN_DEVICE_SERVICE_GUID_LIST** ppDevSvcGuidList);

@DllImport("wlanapi")
uint WlanRegisterDeviceServiceNotification(HANDLE hClientHandle, 
                                           const(WLAN_DEVICE_SERVICE_GUID_LIST)* pDevSvcGuidList);

@DllImport("wlanapi")
uint WlanExtractPsdIEDataList(HANDLE hClientHandle, uint dwIeDataSize, char* pRawIeData, const(wchar)* strFormat, 
                              void* pReserved, WLAN_RAW_DATA_LIST** ppPsdIEDataList);

@DllImport("wlanapi")
uint WlanReasonCodeToString(uint dwReasonCode, uint dwBufferSize, const(wchar)* pStringBuffer, void* pReserved);

@DllImport("wlanapi")
void* WlanAllocateMemory(uint dwMemorySize);

@DllImport("wlanapi")
void WlanFreeMemory(void* pMemory);

@DllImport("wlanapi")
uint WlanSetSecuritySettings(HANDLE hClientHandle, WLAN_SECURABLE_OBJECT SecurableObject, 
                             const(wchar)* strModifiedSDDL);

@DllImport("wlanapi")
uint WlanGetSecuritySettings(HANDLE hClientHandle, WLAN_SECURABLE_OBJECT SecurableObject, 
                             WLAN_OPCODE_VALUE_TYPE* pValueType, ushort** pstrCurrentSDDL, uint* pdwGrantedAccess);

@DllImport("wlanapi")
uint WlanUIEditProfile(uint dwClientVersion, const(wchar)* wstrProfileName, GUID* pInterfaceGuid, HWND hWnd, 
                       WL_DISPLAY_PAGES wlStartPage, void* pReserved, uint* pWlanReasonCode);

@DllImport("wlanapi")
uint WlanHostedNetworkStartUsing(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi")
uint WlanHostedNetworkStopUsing(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi")
uint WlanHostedNetworkForceStart(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi")
uint WlanHostedNetworkForceStop(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi")
uint WlanHostedNetworkQueryProperty(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_OPCODE OpCode, uint* pdwDataSize, 
                                    void** ppvData, WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType, void* pvReserved);

@DllImport("wlanapi")
uint WlanHostedNetworkSetProperty(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_OPCODE OpCode, uint dwDataSize, 
                                  char* pvData, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi")
uint WlanHostedNetworkInitSettings(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi")
uint WlanHostedNetworkRefreshSecuritySettings(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                              void* pvReserved);

@DllImport("wlanapi")
uint WlanHostedNetworkQueryStatus(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_STATUS** ppWlanHostedNetworkStatus, 
                                  void* pvReserved);

@DllImport("wlanapi")
uint WlanHostedNetworkSetSecondaryKey(HANDLE hClientHandle, uint dwKeyLength, char* pucKeyData, BOOL bIsPassPhrase, 
                                      BOOL bPersistent, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi")
uint WlanHostedNetworkQuerySecondaryKey(HANDLE hClientHandle, uint* pdwKeyLength, ubyte** ppucKeyData, 
                                        int* pbIsPassPhrase, int* pbPersistent, 
                                        WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi")
uint WlanRegisterVirtualStationNotification(HANDLE hClientHandle, BOOL bRegister, void* pReserved);

@DllImport("wlanapi")
uint WFDOpenHandle(uint dwClientVersion, uint* pdwNegotiatedVersion, ptrdiff_t* phClientHandle);

@DllImport("wlanapi")
uint WFDCloseHandle(HANDLE hClientHandle);

@DllImport("wlanapi")
uint WFDStartOpenSession(HANDLE hClientHandle, ubyte** pDeviceAddress, void* pvContext, 
                         WFD_OPEN_SESSION_COMPLETE_CALLBACK pfnCallback, ptrdiff_t* phSessionHandle);

@DllImport("wlanapi")
uint WFDCancelOpenSession(HANDLE hSessionHandle);

@DllImport("wlanapi")
uint WFDOpenLegacySession(HANDLE hClientHandle, ubyte** pLegacyMacAddress, HANDLE* phSessionHandle, 
                          GUID* pGuidSessionInterface);

@DllImport("wlanapi")
uint WFDCloseSession(HANDLE hSessionHandle);

@DllImport("wlanapi")
uint WFDUpdateDeviceVisibility(ubyte** pDeviceAddress);


// Interfaces

@GUID("DD06A84F-83BD-4D01-8AB9-2389FEA0869E")
struct Dot11AdHocManager;

@GUID("8F10CC26-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocManager : IUnknown
{
    HRESULT CreateNetwork(const(wchar)* Name, const(wchar)* Password, int GeographicalId, 
                          IDot11AdHocInterface pInterface, IDot11AdHocSecuritySettings pSecurity, GUID* pContextGuid, 
                          IDot11AdHocNetwork* pIAdHoc);
    HRESULT CommitCreatedNetwork(IDot11AdHocNetwork pIAdHoc, ubyte fSaveProfile, 
                                 ubyte fMakeSavedProfileUserSpecific);
    HRESULT GetIEnumDot11AdHocNetworks(GUID* pContextGuid, IEnumDot11AdHocNetworks* ppEnum);
    HRESULT GetIEnumDot11AdHocInterfaces(IEnumDot11AdHocInterfaces* ppEnum);
    HRESULT GetNetwork(GUID* NetworkSignature, IDot11AdHocNetwork* pNetwork);
}

@GUID("8F10CC27-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocManagerNotificationSink : IUnknown
{
    HRESULT OnNetworkAdd(IDot11AdHocNetwork pIAdHocNetwork);
    HRESULT OnNetworkRemove(GUID* Signature);
    HRESULT OnInterfaceAdd(IDot11AdHocInterface pIAdHocInterface);
    HRESULT OnInterfaceRemove(GUID* Signature);
}

@GUID("8F10CC28-CF0D-42A0-ACBE-E2DE7007384D")
interface IEnumDot11AdHocNetworks : IUnknown
{
    HRESULT Next(uint cElt, IDot11AdHocNetwork* rgElt, uint* pcEltFetched);
    HRESULT Skip(uint cElt);
    HRESULT Reset();
    HRESULT Clone(IEnumDot11AdHocNetworks* ppEnum);
}

@GUID("8F10CC29-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocNetwork : IUnknown
{
    HRESULT GetStatus(DOT11_ADHOC_NETWORK_CONNECTION_STATUS* eStatus);
    HRESULT GetSSID(ushort** ppszwSSID);
    HRESULT HasProfile(ubyte* pf11d);
    HRESULT GetProfileName(ushort** ppszwProfileName);
    HRESULT DeleteProfile();
    HRESULT GetSignalQuality(uint* puStrengthValue, uint* puStrengthMax);
    HRESULT GetSecuritySetting(IDot11AdHocSecuritySettings* pAdHocSecuritySetting);
    HRESULT GetContextGuid(GUID* pContextGuid);
    HRESULT GetSignature(GUID* pSignature);
    HRESULT GetInterface(IDot11AdHocInterface* pAdHocInterface);
    HRESULT Connect(const(wchar)* Passphrase, int GeographicalId, ubyte fSaveProfile, 
                    ubyte fMakeSavedProfileUserSpecific);
    HRESULT Disconnect();
}

@GUID("8F10CC2A-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocNetworkNotificationSink : IUnknown
{
    HRESULT OnStatusChange(DOT11_ADHOC_NETWORK_CONNECTION_STATUS eStatus);
    HRESULT OnConnectFail(DOT11_ADHOC_CONNECT_FAIL_REASON eFailReason);
}

@GUID("8F10CC2B-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocInterface : IUnknown
{
    HRESULT GetDeviceSignature(GUID* pSignature);
    HRESULT GetFriendlyName(ushort** ppszName);
    HRESULT IsDot11d(ubyte* pf11d);
    HRESULT IsAdHocCapable(ubyte* pfAdHocCapable);
    HRESULT IsRadioOn(ubyte* pfIsRadioOn);
    HRESULT GetActiveNetwork(IDot11AdHocNetwork* ppNetwork);
    HRESULT GetIEnumSecuritySettings(IEnumDot11AdHocSecuritySettings* ppEnum);
    HRESULT GetIEnumDot11AdHocNetworks(GUID* pFilterGuid, IEnumDot11AdHocNetworks* ppEnum);
    HRESULT GetStatus(DOT11_ADHOC_NETWORK_CONNECTION_STATUS* pState);
}

@GUID("8F10CC2C-CF0D-42A0-ACBE-E2DE7007384D")
interface IEnumDot11AdHocInterfaces : IUnknown
{
    HRESULT Next(uint cElt, IDot11AdHocInterface* rgElt, uint* pcEltFetched);
    HRESULT Skip(uint cElt);
    HRESULT Reset();
    HRESULT Clone(IEnumDot11AdHocInterfaces* ppEnum);
}

@GUID("8F10CC2D-CF0D-42A0-ACBE-E2DE7007384D")
interface IEnumDot11AdHocSecuritySettings : IUnknown
{
    HRESULT Next(uint cElt, IDot11AdHocSecuritySettings* rgElt, uint* pcEltFetched);
    HRESULT Skip(uint cElt);
    HRESULT Reset();
    HRESULT Clone(IEnumDot11AdHocSecuritySettings* ppEnum);
}

@GUID("8F10CC2E-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocSecuritySettings : IUnknown
{
    HRESULT GetDot11AuthAlgorithm(DOT11_ADHOC_AUTH_ALGORITHM* pAuth);
    HRESULT GetDot11CipherAlgorithm(DOT11_ADHOC_CIPHER_ALGORITHM* pCipher);
}

@GUID("8F10CC2F-CF0D-42A0-ACBE-E2DE7007384D")
interface IDot11AdHocInterfaceNotificationSink : IUnknown
{
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
