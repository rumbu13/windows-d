module windows.nativewifi;

public import system;
public import windows.com;
public import windows.eauthprotocol;
public import windows.iphelper;
public import windows.networkdrivers;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

enum DOT11_BSS_TYPE
{
    dot11_BSS_type_infrastructure = 1,
    dot11_BSS_type_independent = 2,
    dot11_BSS_type_any = 3,
}

struct DOT11_SSID
{
    uint uSSIDLength;
    ubyte ucSSID;
}

enum DOT11_AUTH_ALGORITHM
{
    DOT11_AUTH_ALGO_80211_OPEN = 1,
    DOT11_AUTH_ALGO_80211_SHARED_KEY = 2,
    DOT11_AUTH_ALGO_WPA = 3,
    DOT11_AUTH_ALGO_WPA_PSK = 4,
    DOT11_AUTH_ALGO_WPA_NONE = 5,
    DOT11_AUTH_ALGO_RSNA = 6,
    DOT11_AUTH_ALGO_RSNA_PSK = 7,
    DOT11_AUTH_ALGO_WPA3 = 8,
    DOT11_AUTH_ALGO_WPA3_SAE = 9,
    DOT11_AUTH_ALGO_OWE = 10,
    DOT11_AUTH_ALGO_IHV_START = -2147483648,
    DOT11_AUTH_ALGO_IHV_END = -1,
}

enum DOT11_CIPHER_ALGORITHM
{
    DOT11_CIPHER_ALGO_NONE = 0,
    DOT11_CIPHER_ALGO_WEP40 = 1,
    DOT11_CIPHER_ALGO_TKIP = 2,
    DOT11_CIPHER_ALGO_CCMP = 4,
    DOT11_CIPHER_ALGO_WEP104 = 5,
    DOT11_CIPHER_ALGO_BIP = 6,
    DOT11_CIPHER_ALGO_GCMP = 8,
    DOT11_CIPHER_ALGO_GCMP_256 = 9,
    DOT11_CIPHER_ALGO_CCMP_256 = 10,
    DOT11_CIPHER_ALGO_BIP_GMAC_128 = 11,
    DOT11_CIPHER_ALGO_BIP_GMAC_256 = 12,
    DOT11_CIPHER_ALGO_BIP_CMAC_256 = 13,
    DOT11_CIPHER_ALGO_WPA_USE_GROUP = 256,
    DOT11_CIPHER_ALGO_RSN_USE_GROUP = 256,
    DOT11_CIPHER_ALGO_WEP = 257,
    DOT11_CIPHER_ALGO_IHV_START = -2147483648,
    DOT11_CIPHER_ALGO_IHV_END = -1,
}

struct DOT11_AUTH_CIPHER_PAIR
{
    DOT11_AUTH_ALGORITHM AuthAlgoId;
    DOT11_CIPHER_ALGORITHM CipherAlgoId;
}

struct DOT11_OI
{
    ushort OILength;
    ubyte OI;
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
    uint Oid;
    uint DataLength;
    ubyte Data;
}

struct NDIS_STATISTICS_VALUE_EX
{
    uint Oid;
    uint DataLength;
    uint Length;
    ubyte Data;
}

struct NDIS_VAR_DATA_DESC
{
    ushort Length;
    ushort MaximumLength;
    uint Offset;
}

struct NDIS_OBJECT_HEADER
{
    ubyte Type;
    ubyte Revision;
    ushort Size;
}

enum NDIS_REQUEST_TYPE
{
    NdisRequestQueryInformation = 0,
    NdisRequestSetInformation = 1,
    NdisRequestQueryStatistics = 2,
    NdisRequestOpen = 3,
    NdisRequestClose = 4,
    NdisRequestSend = 5,
    NdisRequestTransferData = 6,
    NdisRequestReset = 7,
    NdisRequestGeneric1 = 8,
    NdisRequestGeneric2 = 9,
    NdisRequestGeneric3 = 10,
    NdisRequestGeneric4 = 11,
}

struct NDIS_STATISTICS_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint SupportedStatistics;
    ulong ifInDiscards;
    ulong ifInErrors;
    ulong ifHCInOctets;
    ulong ifHCInUcastPkts;
    ulong ifHCInMulticastPkts;
    ulong ifHCInBroadcastPkts;
    ulong ifHCOutOctets;
    ulong ifHCOutUcastPkts;
    ulong ifHCOutMulticastPkts;
    ulong ifHCOutBroadcastPkts;
    ulong ifOutErrors;
    ulong ifOutDiscards;
    ulong ifHCInUcastOctets;
    ulong ifHCInMulticastOctets;
    ulong ifHCInBroadcastOctets;
    ulong ifHCOutUcastOctets;
    ulong ifHCOutMulticastOctets;
    ulong ifHCOutBroadcastOctets;
}

enum NDIS_INTERRUPT_MODERATION
{
    NdisInterruptModerationUnknown = 0,
    NdisInterruptModerationNotSupported = 1,
    NdisInterruptModerationEnabled = 2,
    NdisInterruptModerationDisabled = 3,
}

struct NDIS_INTERRUPT_MODERATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint Flags;
    NDIS_INTERRUPT_MODERATION InterruptModeration;
}

struct NDIS_TIMEOUT_DPC_REQUEST_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    uint Flags;
    uint TimeoutArrayLength;
    uint TimeoutArray;
}

struct NDIS_PCI_DEVICE_CUSTOM_PROPERTIES
{
    NDIS_OBJECT_HEADER Header;
    uint DeviceType;
    uint CurrentSpeedAndMode;
    uint CurrentPayloadSize;
    uint MaxPayloadSize;
    uint MaxReadRequestSize;
    uint CurrentLinkSpeed;
    uint CurrentLinkWidth;
    uint MaxLinkSpeed;
    uint MaxLinkWidth;
    uint PciExpressVersion;
    uint InterruptType;
    uint MaxInterruptMessages;
}

enum NDIS_802_11_STATUS_TYPE
{
    Ndis802_11StatusType_Authentication = 0,
    Ndis802_11StatusType_MediaStreamMode = 1,
    Ndis802_11StatusType_PMKID_CandidateList = 2,
    Ndis802_11StatusTypeMax = 3,
}

struct NDIS_802_11_STATUS_INDICATION
{
    NDIS_802_11_STATUS_TYPE StatusType;
}

struct NDIS_802_11_AUTHENTICATION_REQUEST
{
    uint Length;
    ubyte Bssid;
    uint Flags;
}

struct PMKID_CANDIDATE
{
    ubyte BSSID;
    uint Flags;
}

struct NDIS_802_11_PMKID_CANDIDATE_LIST
{
    uint Version;
    uint NumCandidates;
    PMKID_CANDIDATE CandidateList;
}

enum NDIS_802_11_NETWORK_TYPE
{
    Ndis802_11FH = 0,
    Ndis802_11DS = 1,
    Ndis802_11OFDM5 = 2,
    Ndis802_11OFDM24 = 3,
    Ndis802_11Automode = 4,
    Ndis802_11NetworkTypeMax = 5,
}

struct NDIS_802_11_NETWORK_TYPE_LIST
{
    uint NumberOfItems;
    NDIS_802_11_NETWORK_TYPE NetworkType;
}

enum NDIS_802_11_POWER_MODE
{
    Ndis802_11PowerModeCAM = 0,
    Ndis802_11PowerModeMAX_PSP = 1,
    Ndis802_11PowerModeFast_PSP = 2,
    Ndis802_11PowerModeMax = 3,
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
    uint Length;
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
    uint Length;
    uint KeyIndex;
    uint KeyLength;
    ubyte BSSID;
    ulong KeyRSC;
    ubyte KeyMaterial;
}

struct NDIS_802_11_REMOVE_KEY
{
    uint Length;
    uint KeyIndex;
    ubyte BSSID;
}

struct NDIS_802_11_WEP
{
    uint Length;
    uint KeyIndex;
    uint KeyLength;
    ubyte KeyMaterial;
}

enum NDIS_802_11_NETWORK_INFRASTRUCTURE
{
    Ndis802_11IBSS = 0,
    Ndis802_11Infrastructure = 1,
    Ndis802_11AutoUnknown = 2,
    Ndis802_11InfrastructureMax = 3,
}

enum NDIS_802_11_AUTHENTICATION_MODE
{
    Ndis802_11AuthModeOpen = 0,
    Ndis802_11AuthModeShared = 1,
    Ndis802_11AuthModeAutoSwitch = 2,
    Ndis802_11AuthModeWPA = 3,
    Ndis802_11AuthModeWPAPSK = 4,
    Ndis802_11AuthModeWPANone = 5,
    Ndis802_11AuthModeWPA2 = 6,
    Ndis802_11AuthModeWPA2PSK = 7,
    Ndis802_11AuthModeWPA3 = 8,
    Ndis802_11AuthModeWPA3SAE = 9,
    Ndis802_11AuthModeMax = 10,
}

struct NDIS_802_11_SSID
{
    uint SsidLength;
    ubyte Ssid;
}

struct NDIS_WLAN_BSSID
{
    uint Length;
    ubyte MacAddress;
    ubyte Reserved;
    NDIS_802_11_SSID Ssid;
    uint Privacy;
    int Rssi;
    NDIS_802_11_NETWORK_TYPE NetworkTypeInUse;
    NDIS_802_11_CONFIGURATION Configuration;
    NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode;
    ubyte SupportedRates;
}

struct NDIS_802_11_BSSID_LIST
{
    uint NumberOfItems;
    NDIS_WLAN_BSSID Bssid;
}

struct NDIS_WLAN_BSSID_EX
{
    uint Length;
    ubyte MacAddress;
    ubyte Reserved;
    NDIS_802_11_SSID Ssid;
    uint Privacy;
    int Rssi;
    NDIS_802_11_NETWORK_TYPE NetworkTypeInUse;
    NDIS_802_11_CONFIGURATION Configuration;
    NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode;
    ubyte SupportedRates;
    uint IELength;
    ubyte IEs;
}

struct NDIS_802_11_BSSID_LIST_EX
{
    uint NumberOfItems;
    NDIS_WLAN_BSSID_EX Bssid;
}

struct NDIS_802_11_FIXED_IEs
{
    ubyte Timestamp;
    ushort BeaconInterval;
    ushort Capabilities;
}

struct NDIS_802_11_VARIABLE_IEs
{
    ubyte ElementID;
    ubyte Length;
    ubyte data;
}

enum NDIS_802_11_PRIVACY_FILTER
{
    Ndis802_11PrivFilterAcceptAll = 0,
    Ndis802_11PrivFilter8021xWEP = 1,
}

enum NDIS_802_11_WEP_STATUS
{
    Ndis802_11WEPEnabled = 0,
    Ndis802_11Encryption1Enabled = 0,
    Ndis802_11WEPDisabled = 1,
    Ndis802_11EncryptionDisabled = 1,
    Ndis802_11WEPKeyAbsent = 2,
    Ndis802_11Encryption1KeyAbsent = 2,
    Ndis802_11WEPNotSupported = 3,
    Ndis802_11EncryptionNotSupported = 3,
    Ndis802_11Encryption2Enabled = 4,
    Ndis802_11Encryption2KeyAbsent = 5,
    Ndis802_11Encryption3Enabled = 6,
    Ndis802_11Encryption3KeyAbsent = 7,
}

enum NDIS_802_11_RELOAD_DEFAULTS
{
    Ndis802_11ReloadWEPKeys = 0,
}

struct NDIS_802_11_AI_REQFI
{
    ushort Capabilities;
    ushort ListenInterval;
    ubyte CurrentAPAddress;
}

struct NDIS_802_11_AI_RESFI
{
    ushort Capabilities;
    ushort StatusCode;
    ushort AssociationId;
}

struct NDIS_802_11_ASSOCIATION_INFORMATION
{
    uint Length;
    ushort AvailableRequestFixedIEs;
    NDIS_802_11_AI_REQFI RequestFixedIEs;
    uint RequestIELength;
    uint OffsetRequestIEs;
    ushort AvailableResponseFixedIEs;
    NDIS_802_11_AI_RESFI ResponseFixedIEs;
    uint ResponseIELength;
    uint OffsetResponseIEs;
}

struct NDIS_802_11_AUTHENTICATION_EVENT
{
    NDIS_802_11_STATUS_INDICATION Status;
    NDIS_802_11_AUTHENTICATION_REQUEST Request;
}

struct NDIS_802_11_TEST
{
    uint Length;
    uint Type;
    _Anonymous_e__Union Anonymous;
}

enum NDIS_802_11_MEDIA_STREAM_MODE
{
    Ndis802_11MediaStreamOff = 0,
    Ndis802_11MediaStreamOn = 1,
}

struct BSSID_INFO
{
    ubyte BSSID;
    ubyte PMKID;
}

struct NDIS_802_11_PMKID
{
    uint Length;
    uint BSSIDInfoCount;
    BSSID_INFO BSSIDInfo;
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
    NDIS_802_11_AUTHENTICATION_ENCRYPTION AuthenticationEncryptionSupported;
}

struct NDIS_802_11_NON_BCAST_SSID_LIST
{
    uint NumberOfItems;
    NDIS_802_11_SSID Non_Bcast_Ssid;
}

enum NDIS_802_11_RADIO_STATUS
{
    Ndis802_11RadioStatusOn = 0,
    Ndis802_11RadioStatusHardwareOff = 1,
    Ndis802_11RadioStatusSoftwareOff = 2,
    Ndis802_11RadioStatusHardwareSoftwareOff = 3,
    Ndis802_11RadioStatusMax = 4,
}

struct NDIS_CO_DEVICE_PROFILE
{
    NDIS_VAR_DATA_DESC DeviceDescription;
    NDIS_VAR_DATA_DESC DevSpecificInfo;
    uint ulTAPISupplementaryPassThru;
    uint ulAddressModes;
    uint ulNumAddresses;
    uint ulBearerModes;
    uint ulMaxTxRate;
    uint ulMinTxRate;
    uint ulMaxRxRate;
    uint ulMinRxRate;
    uint ulMediaModes;
    uint ulGenerateToneModes;
    uint ulGenerateToneMaxNumFreq;
    uint ulGenerateDigitModes;
    uint ulMonitorToneMaxNumFreq;
    uint ulMonitorToneMaxNumEntries;
    uint ulMonitorDigitModes;
    uint ulGatherDigitsMinTimeout;
    uint ulGatherDigitsMaxTimeout;
    uint ulDevCapFlags;
    uint ulMaxNumActiveCalls;
    uint ulAnswerMode;
    uint ulUUIAcceptSize;
    uint ulUUIAnswerSize;
    uint ulUUIMakeCallSize;
    uint ulUUIDropSize;
    uint ulUUISendUserUserInfoSize;
    uint ulUUICallInfoSize;
}

enum OFFLOAD_OPERATION_E
{
    AUTHENTICATE = 1,
    ENCRYPT = 2,
}

struct OFFLOAD_ALGO_INFO
{
    uint algoIdentifier;
    uint algoKeylen;
    uint algoRounds;
}

enum OFFLOAD_CONF_ALGO
{
    OFFLOAD_IPSEC_CONF_NONE = 0,
    OFFLOAD_IPSEC_CONF_DES = 1,
    OFFLOAD_IPSEC_CONF_RESERVED = 2,
    OFFLOAD_IPSEC_CONF_3_DES = 3,
    OFFLOAD_IPSEC_CONF_MAX = 4,
}

enum OFFLOAD_INTEGRITY_ALGO
{
    OFFLOAD_IPSEC_INTEGRITY_NONE = 0,
    OFFLOAD_IPSEC_INTEGRITY_MD5 = 1,
    OFFLOAD_IPSEC_INTEGRITY_SHA = 2,
    OFFLOAD_IPSEC_INTEGRITY_MAX = 3,
}

struct OFFLOAD_SECURITY_ASSOCIATION
{
    OFFLOAD_OPERATION_E Operation;
    uint SPI;
    OFFLOAD_ALGO_INFO IntegrityAlgo;
    OFFLOAD_ALGO_INFO ConfAlgo;
    OFFLOAD_ALGO_INFO Reserved;
}

struct OFFLOAD_IPSEC_ADD_SA
{
    uint SrcAddr;
    uint SrcMask;
    uint DestAddr;
    uint DestMask;
    uint Protocol;
    ushort SrcPort;
    ushort DestPort;
    uint SrcTunnelAddr;
    uint DestTunnelAddr;
    ushort Flags;
    short NumSAs;
    OFFLOAD_SECURITY_ASSOCIATION SecAssoc;
    HANDLE OffloadHandle;
    uint KeyLen;
    ubyte KeyMat;
}

struct OFFLOAD_IPSEC_DELETE_SA
{
    HANDLE OffloadHandle;
}

enum UDP_ENCAP_TYPE
{
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_IKE = 0,
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_OTHER = 1,
}

struct OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY
{
    UDP_ENCAP_TYPE UdpEncapType;
    ushort DstEncapPort;
}

struct OFFLOAD_IPSEC_ADD_UDPESP_SA
{
    uint SrcAddr;
    uint SrcMask;
    uint DstAddr;
    uint DstMask;
    uint Protocol;
    ushort SrcPort;
    ushort DstPort;
    uint SrcTunnelAddr;
    uint DstTunnelAddr;
    ushort Flags;
    short NumSAs;
    OFFLOAD_SECURITY_ASSOCIATION SecAssoc;
    HANDLE OffloadHandle;
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY EncapTypeEntry;
    HANDLE EncapTypeEntryOffldHandle;
    uint KeyLen;
    ubyte KeyMat;
}

struct OFFLOAD_IPSEC_DELETE_UDPESP_SA
{
    HANDLE OffloadHandle;
    HANDLE EncapTypeEntryOffldHandle;
}

enum NDIS_MEDIUM
{
    NdisMedium802_3 = 0,
    NdisMedium802_5 = 1,
    NdisMediumFddi = 2,
    NdisMediumWan = 3,
    NdisMediumLocalTalk = 4,
    NdisMediumDix = 5,
    NdisMediumArcnetRaw = 6,
    NdisMediumArcnet878_2 = 7,
    NdisMediumAtm = 8,
    NdisMediumWirelessWan = 9,
    NdisMediumIrda = 10,
    NdisMediumBpc = 11,
    NdisMediumCoWan = 12,
    NdisMedium1394 = 13,
    NdisMediumInfiniBand = 14,
    NdisMediumTunnel = 15,
    NdisMediumNative802_11 = 16,
    NdisMediumLoopback = 17,
    NdisMediumWiMAX = 18,
    NdisMediumIP = 19,
    NdisMediumMax = 20,
}

enum NDIS_PHYSICAL_MEDIUM
{
    NdisPhysicalMediumUnspecified = 0,
    NdisPhysicalMediumWirelessLan = 1,
    NdisPhysicalMediumCableModem = 2,
    NdisPhysicalMediumPhoneLine = 3,
    NdisPhysicalMediumPowerLine = 4,
    NdisPhysicalMediumDSL = 5,
    NdisPhysicalMediumFibreChannel = 6,
    NdisPhysicalMedium1394 = 7,
    NdisPhysicalMediumWirelessWan = 8,
    NdisPhysicalMediumNative802_11 = 9,
    NdisPhysicalMediumBluetooth = 10,
    NdisPhysicalMediumInfiniband = 11,
    NdisPhysicalMediumWiMax = 12,
    NdisPhysicalMediumUWB = 13,
    NdisPhysicalMedium802_3 = 14,
    NdisPhysicalMedium802_5 = 15,
    NdisPhysicalMediumIrda = 16,
    NdisPhysicalMediumWiredWAN = 17,
    NdisPhysicalMediumWiredCoWan = 18,
    NdisPhysicalMediumOther = 19,
    NdisPhysicalMediumNative802_15_4 = 20,
    NdisPhysicalMediumMax = 21,
}

struct TRANSPORT_HEADER_OFFSET
{
    ushort ProtocolType;
    ushort HeaderOffset;
}

struct NETWORK_ADDRESS
{
    ushort AddressLength;
    ushort AddressType;
    ubyte Address;
}

struct NETWORK_ADDRESS_LIST
{
    int AddressCount;
    ushort AddressType;
    NETWORK_ADDRESS Address;
}

struct NETWORK_ADDRESS_IP
{
    ushort sin_port;
    uint in_addr;
    ubyte sin_zero;
}

struct NETWORK_ADDRESS_IP6
{
    ushort sin6_port;
    uint sin6_flowinfo;
    ushort sin6_addr;
    uint sin6_scope_id;
}

struct NETWORK_ADDRESS_IPX
{
    uint NetworkAddress;
    ubyte NodeAddress;
    ushort Socket;
}

enum NDIS_HARDWARE_STATUS
{
    NdisHardwareStatusReady = 0,
    NdisHardwareStatusInitializing = 1,
    NdisHardwareStatusReset = 2,
    NdisHardwareStatusClosing = 3,
    NdisHardwareStatusNotReady = 4,
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

enum NDIS_DEVICE_POWER_STATE
{
    NdisDeviceStateUnspecified = 0,
    NdisDeviceStateD0 = 1,
    NdisDeviceStateD1 = 2,
    NdisDeviceStateD2 = 3,
    NdisDeviceStateD3 = 4,
    NdisDeviceStateMaximum = 5,
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

enum NDIS_FDDI_ATTACHMENT_TYPE
{
    NdisFddiTypeIsolated = 1,
    NdisFddiTypeLocalA = 2,
    NdisFddiTypeLocalB = 3,
    NdisFddiTypeLocalAB = 4,
    NdisFddiTypeLocalS = 5,
    NdisFddiTypeWrapA = 6,
    NdisFddiTypeWrapB = 7,
    NdisFddiTypeWrapAB = 8,
    NdisFddiTypeWrapS = 9,
    NdisFddiTypeCWrapA = 10,
    NdisFddiTypeCWrapB = 11,
    NdisFddiTypeCWrapS = 12,
    NdisFddiTypeThrough = 13,
}

enum NDIS_FDDI_RING_MGT_STATE
{
    NdisFddiRingIsolated = 1,
    NdisFddiRingNonOperational = 2,
    NdisFddiRingOperational = 3,
    NdisFddiRingDetect = 4,
    NdisFddiRingNonOperationalDup = 5,
    NdisFddiRingOperationalDup = 6,
    NdisFddiRingDirected = 7,
    NdisFddiRingTrace = 8,
}

enum NDIS_FDDI_LCONNECTION_STATE
{
    NdisFddiStateOff = 1,
    NdisFddiStateBreak = 2,
    NdisFddiStateTrace = 3,
    NdisFddiStateConnect = 4,
    NdisFddiStateNext = 5,
    NdisFddiStateSignal = 6,
    NdisFddiStateJoin = 7,
    NdisFddiStateVerify = 8,
    NdisFddiStateActive = 9,
    NdisFddiStateMaintenance = 10,
}

enum NDIS_WAN_MEDIUM_SUBTYPE
{
    NdisWanMediumHub = 0,
    NdisWanMediumX_25 = 1,
    NdisWanMediumIsdn = 2,
    NdisWanMediumSerial = 3,
    NdisWanMediumFrameRelay = 4,
    NdisWanMediumAtm = 5,
    NdisWanMediumSonet = 6,
    NdisWanMediumSW56K = 7,
    NdisWanMediumPPTP = 8,
    NdisWanMediumL2TP = 9,
    NdisWanMediumIrda = 10,
    NdisWanMediumParallel = 11,
    NdisWanMediumPppoe = 12,
    NdisWanMediumSSTP = 13,
    NdisWanMediumAgileVPN = 14,
    NdisWanMediumGre = 15,
    NdisWanMediumSubTypeMax = 16,
}

enum NDIS_WAN_HEADER_FORMAT
{
    NdisWanHeaderNative = 0,
    NdisWanHeaderEthernet = 1,
}

enum NDIS_WAN_QUALITY
{
    NdisWanRaw = 0,
    NdisWanErrorControl = 1,
    NdisWanReliable = 2,
}

struct NDIS_WAN_PROTOCOL_CAPS
{
    uint Flags;
    uint Reserved;
}

enum NDIS_802_5_RING_STATE
{
    NdisRingStateOpened = 1,
    NdisRingStateClosed = 2,
    NdisRingStateOpening = 3,
    NdisRingStateClosing = 4,
    NdisRingStateOpenFailure = 5,
    NdisRingStateRingFailure = 6,
}

enum NDIS_MEDIA_STATE
{
    NdisMediaStateConnected = 0,
    NdisMediaStateDisconnected = 1,
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
    Guid Guid;
    _Anonymous_e__Union Anonymous;
    uint Size;
    uint Flags;
}

struct NDIS_IRDA_PACKET_INFO
{
    uint ExtraBOFs;
    uint MinTurnAroundTime;
}

enum NDIS_SUPPORTED_PAUSE_FUNCTIONS
{
    NdisPauseFunctionsUnsupported = 0,
    NdisPauseFunctionsSendOnly = 1,
    NdisPauseFunctionsReceiveOnly = 2,
    NdisPauseFunctionsSendAndReceive = 3,
    NdisPauseFunctionsUnknown = 4,
}

struct NDIS_LINK_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    ulong XmitLinkSpeed;
    ulong RcvLinkSpeed;
    NDIS_SUPPORTED_PAUSE_FUNCTIONS PauseFunctions;
    uint AutoNegotiationFlags;
}

struct NDIS_LINK_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    ulong XmitLinkSpeed;
    ulong RcvLinkSpeed;
    NDIS_SUPPORTED_PAUSE_FUNCTIONS PauseFunctions;
    uint AutoNegotiationFlags;
}

struct NDIS_OPER_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_OPER_STATUS OperationalStatus;
    uint OperationalStatusFlags;
}

struct NDIS_IP_OPER_STATUS
{
    uint AddressFamily;
    NET_IF_OPER_STATUS OperationalStatus;
    uint OperationalStatusFlags;
}

struct NDIS_IP_OPER_STATUS_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint Flags;
    uint NumberofAddressFamiliesReturned;
    NDIS_IP_OPER_STATUS IpOperationalStatus;
}

struct NDIS_IP_OPER_STATE
{
    NDIS_OBJECT_HEADER Header;
    uint Flags;
    NDIS_IP_OPER_STATUS IpOperationalStatus;
}

struct NDIS_OFFLOAD_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte IPv4Checksum;
    ubyte TCPIPv4Checksum;
    ubyte UDPIPv4Checksum;
    ubyte TCPIPv6Checksum;
    ubyte UDPIPv6Checksum;
    ubyte LsoV1;
    ubyte IPsecV1;
    ubyte LsoV2IPv4;
    ubyte LsoV2IPv6;
    ubyte TcpConnectionIPv4;
    ubyte TcpConnectionIPv6;
    uint Flags;
}

struct NDIS_TCP_LARGE_SEND_OFFLOAD_V1
{
    _IPv4_e__Struct IPv4;
}

struct NDIS_TCP_IP_CHECKSUM_OFFLOAD
{
    _IPv4Transmit_e__Struct IPv4Transmit;
    _IPv4Receive_e__Struct IPv4Receive;
    _IPv6Transmit_e__Struct IPv6Transmit;
    _IPv6Receive_e__Struct IPv6Receive;
}

struct NDIS_IPSEC_OFFLOAD_V1
{
    _Supported_e__Struct Supported;
    _IPv4AH_e__Struct IPv4AH;
    _IPv4ESP_e__Struct IPv4ESP;
}

struct NDIS_TCP_LARGE_SEND_OFFLOAD_V2
{
    _IPv4_e__Struct IPv4;
    _IPv6_e__Struct IPv6;
}

struct NDIS_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    NDIS_TCP_IP_CHECKSUM_OFFLOAD Checksum;
    NDIS_TCP_LARGE_SEND_OFFLOAD_V1 LsoV1;
    NDIS_IPSEC_OFFLOAD_V1 IPsecV1;
    NDIS_TCP_LARGE_SEND_OFFLOAD_V2 LsoV2;
    uint Flags;
}

struct NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1
{
    _IPv4_e__Struct IPv4;
}

struct NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD
{
    _IPv4Transmit_e__Struct IPv4Transmit;
    _IPv4Receive_e__Struct IPv4Receive;
    _IPv6Transmit_e__Struct IPv6Transmit;
    _IPv6Receive_e__Struct IPv6Receive;
}

struct NDIS_WMI_IPSEC_OFFLOAD_V1
{
    _Supported_e__Struct Supported;
    _IPv4AH_e__Struct IPv4AH;
    _IPv4ESP_e__Struct IPv4ESP;
}

struct NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2
{
    _IPv4_e__Struct IPv4;
    _IPv6_e__Struct IPv6;
}

struct NDIS_WMI_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD Checksum;
    NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1 LsoV1;
    NDIS_WMI_IPSEC_OFFLOAD_V1 IPsecV1;
    NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2 LsoV2;
    uint Flags;
}

struct NDIS_TCP_CONNECTION_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    uint Encapsulation;
    uint _bitfield;
    uint TcpConnectionOffloadCapacity;
    uint Flags;
}

struct NDIS_WMI_TCP_CONNECTION_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    uint Encapsulation;
    uint SupportIPv4;
    uint SupportIPv6;
    uint SupportIPv6ExtensionHeaders;
    uint SupportSack;
    uint TcpConnectionOffloadCapacity;
    uint Flags;
}

enum NDIS_PORT_TYPE
{
    NdisPortTypeUndefined = 0,
    NdisPortTypeBridge = 1,
    NdisPortTypeRasConnection = 2,
    NdisPortType8021xSupplicant = 3,
    NdisPortTypeMax = 4,
}

enum NDIS_PORT_AUTHORIZATION_STATE
{
    NdisPortAuthorizationUnknown = 0,
    NdisPortAuthorized = 1,
    NdisPortUnauthorized = 2,
    NdisPortReauthorizing = 3,
}

enum NDIS_PORT_CONTROL_STATE
{
    NdisPortControlStateUnknown = 0,
    NdisPortControlStateControlled = 1,
    NdisPortControlStateUncontrolled = 2,
}

struct NDIS_PORT_AUTHENTICATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
}

enum NDIS_NETWORK_CHANGE_TYPE
{
    NdisPossibleNetworkChange = 1,
    NdisDefinitelyNetworkChange = 2,
    NdisNetworkChangeFromMediaConnect = 3,
    NdisNetworkChangeMax = 4,
}

struct NDIS_WMI_METHOD_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint PortNumber;
    NET_LUID_LH NetLuid;
    ulong RequestId;
    uint Timeout;
    ubyte Padding;
}

struct NDIS_WMI_SET_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint PortNumber;
    NET_LUID_LH NetLuid;
    ulong RequestId;
    uint Timeout;
    ubyte Padding;
}

struct NDIS_WMI_EVENT_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint IfIndex;
    NET_LUID_LH NetLuid;
    ulong RequestId;
    uint PortNumber;
    uint DeviceNameLength;
    uint DeviceNameOffset;
    ubyte Padding;
}

struct NDIS_WMI_ENUM_ADAPTER
{
    NDIS_OBJECT_HEADER Header;
    uint IfIndex;
    NET_LUID_LH NetLuid;
    ushort DeviceNameLength;
    byte DeviceName;
}

struct NDIS_WMI_OUTPUT_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint Flags;
    ubyte SupportedRevision;
    uint DataOffset;
}

struct NDIS_RECEIVE_SCALE_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    uint CapabilitiesFlags;
    uint NumberOfInterruptMessages;
    uint NumberOfReceiveQueues;
}

struct NDIS_RECEIVE_SCALE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ushort Flags;
    ushort BaseCpuNumber;
    uint HashInformation;
    ushort IndirectionTableSize;
    uint IndirectionTableOffset;
    ushort HashSecretKeySize;
    uint HashSecretKeyOffset;
}

struct NDIS_RECEIVE_HASH_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint Flags;
    uint HashInformation;
    ushort HashSecretKeySize;
    uint HashSecretKeyOffset;
}

enum NDIS_PROCESSOR_VENDOR
{
    NdisProcessorVendorUnknown = 0,
    NdisProcessorVendorGenuinIntel = 1,
    NdisProcessorVendorGenuineIntel = 1,
    NdisProcessorVendorAuthenticAMD = 2,
}

struct NDIS_PORT_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    ulong XmitLinkSpeed;
    ulong RcvLinkSpeed;
    NET_IF_DIRECTION_TYPE Direction;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
    uint Flags;
}

struct NDIS_PORT_CHARACTERISTICS
{
    NDIS_OBJECT_HEADER Header;
    uint PortNumber;
    uint Flags;
    NDIS_PORT_TYPE Type;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    ulong XmitLinkSpeed;
    ulong RcvLinkSpeed;
    NET_IF_DIRECTION_TYPE Direction;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
}

struct NDIS_PORT
{
    NDIS_PORT* Next;
    void* NdisReserved;
    void* MiniportReserved;
    void* ProtocolReserved;
    NDIS_PORT_CHARACTERISTICS PortCharacteristics;
}

struct NDIS_PORT_ARRAY
{
    NDIS_OBJECT_HEADER Header;
    uint NumberOfPorts;
    uint OffsetFirstPort;
    uint ElementSize;
    NDIS_PORT_CHARACTERISTICS Ports;
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
    ulong HardwareClockFrequencyHz;
    ubyte CrossTimestamp;
    ulong Reserved1;
    ulong Reserved2;
    NDIS_TIMESTAMP_CAPABILITY_FLAGS TimestampFlags;
}

struct NDIS_HARDWARE_CROSSTIMESTAMP
{
    NDIS_OBJECT_HEADER Header;
    uint Flags;
    ulong SystemTimestamp1;
    ulong HardwareClockTimestamp;
    ulong SystemTimestamp2;
}

struct DOT11_BSSID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    ubyte BSSIDs;
}

enum DOT11_PHY_TYPE
{
    dot11_phy_type_unknown = 0,
    dot11_phy_type_any = 0,
    dot11_phy_type_fhss = 1,
    dot11_phy_type_dsss = 2,
    dot11_phy_type_irbaseband = 3,
    dot11_phy_type_ofdm = 4,
    dot11_phy_type_hrdsss = 5,
    dot11_phy_type_erp = 6,
    dot11_phy_type_ht = 7,
    dot11_phy_type_vht = 8,
    dot11_phy_type_dmg = 9,
    dot11_phy_type_he = 10,
    dot11_phy_type_IHV_start = -2147483648,
    dot11_phy_type_IHV_end = -1,
}

struct DOT11_RATE_SET
{
    uint uRateSetLength;
    ubyte ucRateSet;
}

struct DOT11_WFD_SESSION_INFO
{
    ushort uSessionInfoLength;
    ubyte ucSessionInfo;
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

enum DOT11_OFFLOAD_TYPE
{
    dot11_offload_type_wep = 1,
    dot11_offload_type_auth = 2,
}

struct DOT11_IV48_COUNTER
{
    uint uIV32Counter;
    ushort usIV16Counter;
}

struct DOT11_WEP_OFFLOAD
{
    uint uReserved;
    HANDLE hOffloadContext;
    HANDLE hOffload;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    uint dwAlgorithm;
    ubyte bRowIsOutbound;
    ubyte bUseDefault;
    uint uFlags;
    ubyte ucMacAddress;
    uint uNumOfRWsOnPeer;
    uint uNumOfRWsOnMe;
    DOT11_IV48_COUNTER dot11IV48Counters;
    ushort usDot11RWBitMaps;
    ushort usKeyLength;
    ubyte ucKey;
}

struct DOT11_WEP_UPLOAD
{
    uint uReserved;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    HANDLE hOffload;
    uint uNumOfRWsUsed;
    DOT11_IV48_COUNTER dot11IV48Counters;
    ushort usDot11RWBitMaps;
}

enum DOT11_KEY_DIRECTION
{
    dot11_key_direction_both = 1,
    dot11_key_direction_inbound = 2,
    dot11_key_direction_outbound = 3,
}

struct DOT11_DEFAULT_WEP_OFFLOAD
{
    uint uReserved;
    HANDLE hOffloadContext;
    HANDLE hOffload;
    uint dwIndex;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    uint dwAlgorithm;
    uint uFlags;
    DOT11_KEY_DIRECTION dot11KeyDirection;
    ubyte ucMacAddress;
    uint uNumOfRWsOnMe;
    DOT11_IV48_COUNTER dot11IV48Counters;
    ushort usDot11RWBitMaps;
    ushort usKeyLength;
    ubyte ucKey;
}

struct DOT11_DEFAULT_WEP_UPLOAD
{
    uint uReserved;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    HANDLE hOffload;
    uint uNumOfRWsUsed;
    DOT11_IV48_COUNTER dot11IV48Counters;
    ushort usDot11RWBitMaps;
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

enum DOT11_SCAN_TYPE
{
    dot11_scan_type_active = 1,
    dot11_scan_type_passive = 2,
    dot11_scan_type_auto = 3,
    dot11_scan_type_forced = -2147483648,
}

struct DOT11_SCAN_REQUEST
{
    DOT11_BSS_TYPE dot11BSSType;
    ubyte dot11BSSID;
    DOT11_SSID dot11SSID;
    DOT11_SCAN_TYPE dot11ScanType;
    ubyte bRestrictedScan;
    ubyte bUseRequestIE;
    uint uRequestIDsOffset;
    uint uNumOfRequestIDs;
    uint uPhyTypesOffset;
    uint uNumOfPhyTypes;
    uint uIEsOffset;
    uint uIEsLength;
    ubyte ucBuffer;
}

enum CH_DESCRIPTION_TYPE
{
    ch_description_type_logical = 1,
    ch_description_type_center_frequency = 2,
    ch_description_type_phy_specific = 3,
}

struct DOT11_PHY_TYPE_INFO
{
    DOT11_PHY_TYPE dot11PhyType;
    ubyte bUseParameters;
    uint uProbeDelay;
    uint uMinChannelTime;
    uint uMaxChannelTime;
    CH_DESCRIPTION_TYPE ChDescriptionType;
    uint uChannelListSize;
    ubyte ucChannelListBuffer;
}

struct DOT11_SCAN_REQUEST_V2
{
    DOT11_BSS_TYPE dot11BSSType;
    ubyte dot11BSSID;
    DOT11_SCAN_TYPE dot11ScanType;
    ubyte bRestrictedScan;
    uint udot11SSIDsOffset;
    uint uNumOfdot11SSIDs;
    ubyte bUseRequestIE;
    uint uRequestIDsOffset;
    uint uNumOfRequestIDs;
    uint uPhyTypeInfosOffset;
    uint uNumOfPhyTypeInfos;
    uint uIEsOffset;
    uint uIEsLength;
    ubyte ucBuffer;
}

struct DOT11_PHY_TYPE_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_PHY_TYPE dot11PhyType;
}

struct DOT11_BSS_DESCRIPTION
{
    uint uReserved;
    ubyte dot11BSSID;
    DOT11_BSS_TYPE dot11BSSType;
    ushort usBeaconPeriod;
    ulong ullTimestamp;
    ushort usCapabilityInformation;
    uint uBufferLength;
    ubyte ucBuffer;
}

struct DOT11_JOIN_REQUEST
{
    uint uJoinFailureTimeout;
    DOT11_RATE_SET OperationalRateSet;
    uint uChCenterFrequency;
    DOT11_BSS_DESCRIPTION dot11BSSDescription;
}

struct DOT11_START_REQUEST
{
    uint uStartFailureTimeout;
    DOT11_RATE_SET OperationalRateSet;
    uint uChCenterFrequency;
    DOT11_BSS_DESCRIPTION dot11BSSDescription;
}

enum DOT11_UPDATE_IE_OP
{
    dot11_update_ie_op_create_replace = 1,
    dot11_update_ie_op_delete = 2,
}

struct DOT11_UPDATE_IE
{
    DOT11_UPDATE_IE_OP dot11UpdateIEOp;
    uint uBufferLength;
    ubyte ucBuffer;
}

enum DOT11_RESET_TYPE
{
    dot11_reset_type_phy = 1,
    dot11_reset_type_mac = 2,
    dot11_reset_type_phy_and_mac = 3,
}

struct DOT11_RESET_REQUEST
{
    DOT11_RESET_TYPE dot11ResetType;
    ubyte dot11MacAddress;
    ubyte bSetDefaultMIB;
}

struct DOT11_OPTIONAL_CAPABILITY
{
    uint uReserved;
    ubyte bDot11PCF;
    ubyte bDot11PCFMPDUTransferToPC;
    ubyte bStrictlyOrderedServiceClass;
}

struct DOT11_CURRENT_OPTIONAL_CAPABILITY
{
    uint uReserved;
    ubyte bDot11CFPollable;
    ubyte bDot11PCF;
    ubyte bDot11PCFMPDUTransferToPC;
    ubyte bStrictlyOrderedServiceClass;
}

enum DOT11_POWER_MODE
{
    dot11_power_mode_unknown = 0,
    dot11_power_mode_active = 1,
    dot11_power_mode_powersave = 2,
}

struct DOT11_POWER_MGMT_MODE
{
    DOT11_POWER_MODE dot11PowerMode;
    uint uPowerSaveLevel;
    ushort usListenInterval;
    ushort usAID;
    ubyte bReceiveDTIMs;
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
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_PHY_TYPE dot11PHYType;
}

enum DOT11_TEMP_TYPE
{
    dot11_temp_type_unknown = 0,
    dot11_temp_type_1 = 1,
    dot11_temp_type_2 = 2,
}

enum DOT11_DIVERSITY_SUPPORT
{
    dot11_diversity_support_unknown = 0,
    dot11_diversity_support_fixedlist = 1,
    dot11_diversity_support_notsupported = 2,
    dot11_diversity_support_dynamic = 3,
}

struct DOT11_SUPPORTED_POWER_LEVELS
{
    uint uNumOfSupportedPowerLevels;
    uint uTxPowerLevelValues;
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
    DOT11_REG_DOMAIN_VALUE dot11RegDomainValue;
}

struct DOT11_SUPPORTED_ANTENNA
{
    uint uAntennaListIndex;
    ubyte bSupportedAntenna;
}

struct DOT11_SUPPORTED_ANTENNA_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_SUPPORTED_ANTENNA dot11SupportedAntenna;
}

struct DOT11_DIVERSITY_SELECTION_RX
{
    uint uAntennaListIndex;
    ubyte bDiversitySelectionRX;
}

struct DOT11_DIVERSITY_SELECTION_RX_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_DIVERSITY_SELECTION_RX dot11DiversitySelectionRx;
}

struct DOT11_SUPPORTED_DATA_RATES_VALUE
{
    ubyte ucSupportedTxDataRatesValue;
    ubyte ucSupportedRxDataRatesValue;
}

struct DOT11_SUPPORTED_DATA_RATES_VALUE_V2
{
    ubyte ucSupportedTxDataRatesValue;
    ubyte ucSupportedRxDataRatesValue;
}

struct DOT11_MULTI_DOMAIN_CAPABILITY_ENTRY
{
    uint uMultiDomainCapabilityIndex;
    uint uFirstChannelNumber;
    uint uNumberOfChannels;
    int lMaximumTransmitPowerLevel;
}

struct DOT11_MD_CAPABILITY_ENTRY_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_MULTI_DOMAIN_CAPABILITY_ENTRY dot11MDCapabilityEntry;
}

enum DOT11_HOP_ALGO_ADOPTED
{
    dot11_hop_algo_current = 0,
    dot11_hop_algo_hop_index = 1,
    dot11_hop_algo_hcc = 2,
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
    DOT11_HOPPING_PATTERN_ENTRY dot11HoppingPatternEntry;
}

struct DOT11_WPA_TSC
{
    uint uReserved;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    HANDLE hOffload;
    DOT11_IV48_COUNTER dot11IV48Counter;
}

struct DOT11_RSSI_RANGE
{
    DOT11_PHY_TYPE dot11PhyType;
    uint uRSSIMin;
    uint uRSSIMax;
}

struct DOT11_NIC_SPECIFIC_EXTENSION
{
    uint uBufferLength;
    uint uTotalBufferLength;
    ubyte ucBuffer;
}

struct DOT11_AP_JOIN_REQUEST
{
    uint uJoinFailureTimeout;
    DOT11_RATE_SET OperationalRateSet;
    uint uChCenterFrequency;
    DOT11_BSS_DESCRIPTION dot11BSSDescription;
}

struct DOT11_RECV_SENSITIVITY
{
    ubyte ucDataRate;
    int lRSSIMin;
    int lRSSIMax;
}

struct DOT11_RECV_SENSITIVITY_LIST
{
    _Anonymous_e__Union Anonymous;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_RECV_SENSITIVITY dot11RecvSensitivity;
}

enum DOT11_AC_PARAM
{
    dot11_AC_param_BE = 0,
    dot11_AC_param_BK = 1,
    dot11_AC_param_VI = 2,
    dot11_AC_param_VO = 3,
    dot11_AC_param_max = 4,
}

struct DOT11_WME_AC_PARAMETERS
{
    ubyte ucAccessCategoryIndex;
    ubyte ucAIFSN;
    ubyte ucECWmin;
    ubyte ucECWmax;
    ushort usTXOPLimit;
}

struct _DOT11_WME_AC_PARAMTERS_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_WME_AC_PARAMETERS dot11WMEACParameters;
}

struct DOT11_WME_UPDATE_IE
{
    uint uParamElemMinBeaconIntervals;
    uint uWMEInfoElemOffset;
    uint uWMEInfoElemLength;
    uint uWMEParamElemOffset;
    uint uWMEParamElemLength;
    ubyte ucBuffer;
}

struct DOT11_QOS_TX_DURATION
{
    uint uNominalMSDUSize;
    uint uMinPHYRate;
    uint uDuration;
}

struct DOT11_QOS_TX_MEDIUM_TIME
{
    ubyte dot11PeerAddress;
    ubyte ucQoSPriority;
    uint uMediumTimeAdmited;
}

struct DOT11_SUPPORTED_OFDM_FREQUENCY
{
    uint uCenterFrequency;
}

struct DOT11_SUPPORTED_OFDM_FREQUENCY_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_SUPPORTED_OFDM_FREQUENCY dot11SupportedOFDMFrequency;
}

struct DOT11_SUPPORTED_DSSS_CHANNEL
{
    uint uChannel;
}

struct DOT11_SUPPORTED_DSSS_CHANNEL_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_SUPPORTED_DSSS_CHANNEL dot11SupportedDSSSChannel;
}

struct DOT11_BYTE_ARRAY
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfBytes;
    uint uTotalNumOfBytes;
    ubyte ucBuffer;
}

struct DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO
{
    uint uChCenterFrequency;
    _FHSS_e__Struct FHSS;
}

struct DOT11_BSS_ENTRY
{
    uint uPhyId;
    DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO PhySpecificInfo;
    ubyte dot11BSSID;
    DOT11_BSS_TYPE dot11BSSType;
    int lRSSI;
    uint uLinkQuality;
    ubyte bInRegDomain;
    ushort usBeaconPeriod;
    ulong ullTimestamp;
    ulong ullHostTimestamp;
    ushort usCapabilityInformation;
    uint uBufferLength;
    ubyte ucBuffer;
}

struct DOT11_SSID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_SSID SSIDs;
}

struct DOT11_MAC_ADDRESS_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    ubyte MacAddrs;
}

struct DOT11_PMKID_ENTRY
{
    ubyte BSSID;
    ubyte PMKID;
    uint uFlags;
}

struct DOT11_PMKID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_PMKID_ENTRY PMKIDs;
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
    ulong ullFourWayHandshakeFailures;
    ulong ullTKIPCounterMeasuresInvoked;
    ulong ullReserved;
    DOT11_MAC_FRAME_STATISTICS MacUcastCounters;
    DOT11_MAC_FRAME_STATISTICS MacMcastCounters;
    DOT11_PHY_FRAME_STATISTICS PhyCounters;
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
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_PRIVACY_EXEMPTION PrivacyExemptionEntries;
}

struct DOT11_AUTH_ALGORITHM_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_AUTH_ALGORITHM AlgorithmIds;
}

struct DOT11_AUTH_CIPHER_PAIR_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_AUTH_CIPHER_PAIR AuthCipherPairs;
}

struct DOT11_CIPHER_ALGORITHM_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_CIPHER_ALGORITHM AlgorithmIds;
}

struct DOT11_CIPHER_DEFAULT_KEY_VALUE
{
    NDIS_OBJECT_HEADER Header;
    uint uKeyIndex;
    DOT11_CIPHER_ALGORITHM AlgorithmId;
    ubyte MacAddr;
    ubyte bDelete;
    ubyte bStatic;
    ushort usKeyLength;
    ubyte ucKey;
}

struct DOT11_KEY_ALGO_TKIP_MIC
{
    ubyte ucIV48Counter;
    uint ulTKIPKeyLength;
    uint ulMICKeyLength;
    ubyte ucTKIPMICKeys;
}

struct DOT11_KEY_ALGO_CCMP
{
    ubyte ucIV48Counter;
    uint ulCCMPKeyLength;
    ubyte ucCCMPKey;
}

struct DOT11_KEY_ALGO_GCMP
{
    ubyte ucIV48Counter;
    uint ulGCMPKeyLength;
    ubyte ucGCMPKey;
}

struct DOT11_KEY_ALGO_GCMP_256
{
    ubyte ucIV48Counter;
    uint ulGCMP256KeyLength;
    ubyte ucGCMP256Key;
}

struct DOT11_KEY_ALGO_BIP
{
    ubyte ucIPN;
    uint ulBIPKeyLength;
    ubyte ucBIPKey;
}

struct DOT11_KEY_ALGO_BIP_GMAC_256
{
    ubyte ucIPN;
    uint ulBIPGmac256KeyLength;
    ubyte ucBIPGmac256Key;
}

enum DOT11_DIRECTION
{
    DOT11_DIR_INBOUND = 1,
    DOT11_DIR_OUTBOUND = 2,
    DOT11_DIR_BOTH = 3,
}

struct DOT11_CIPHER_KEY_MAPPING_KEY_VALUE
{
    ubyte PeerMacAddr;
    DOT11_CIPHER_ALGORITHM AlgorithmId;
    DOT11_DIRECTION Direction;
    ubyte bDelete;
    ubyte bStatic;
    ushort usKeyLength;
    ubyte ucKey;
}

enum DOT11_ASSOCIATION_STATE
{
    dot11_assoc_state_zero = 0,
    dot11_assoc_state_unauth_unassoc = 1,
    dot11_assoc_state_auth_unassoc = 2,
    dot11_assoc_state_auth_assoc = 3,
}

struct DOT11_ASSOCIATION_INFO_EX
{
    ubyte PeerMacAddress;
    ubyte BSSID;
    ushort usCapabilityInformation;
    ushort usListenInterval;
    ubyte ucPeerSupportedRates;
    ushort usAssociationID;
    DOT11_ASSOCIATION_STATE dot11AssociationState;
    DOT11_POWER_MODE dot11PowerMode;
    LARGE_INTEGER liAssociationUpTime;
    ulong ullNumOfTxPacketSuccesses;
    ulong ullNumOfTxPacketFailures;
    ulong ullNumOfRxPacketSuccesses;
    ulong ullNumOfRxPacketFailures;
}

struct DOT11_ASSOCIATION_INFO_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_ASSOCIATION_INFO_EX dot11AssocInfo;
}

struct DOT11_PHY_ID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    uint dot11PhyId;
}

struct DOT11_EXTSTA_CAPABILITY
{
    NDIS_OBJECT_HEADER Header;
    uint uScanSSIDListSize;
    uint uDesiredBSSIDListSize;
    uint uDesiredSSIDListSize;
    uint uExcludedMacAddressListSize;
    uint uPrivacyExemptionListSize;
    uint uKeyMappingTableSize;
    uint uDefaultKeyTableSize;
    uint uWEPKeyValueMaxLength;
    uint uPMKIDCacheSize;
    uint uMaxNumPerSTADefaultKeyTables;
}

struct DOT11_DATA_RATE_MAPPING_ENTRY
{
    ubyte ucDataRateIndex;
    ubyte ucDataRateFlag;
    ushort usDataRateValue;
}

struct DOT11_DATA_RATE_MAPPING_TABLE
{
    NDIS_OBJECT_HEADER Header;
    uint uDataRateMappingLength;
    DOT11_DATA_RATE_MAPPING_ENTRY DataRateMappingEntries;
}

struct DOT11_COUNTRY_OR_REGION_STRING_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    ubyte CountryOrRegionStrings;
}

struct DOT11_PORT_STATE_NOTIFICATION
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerMac;
    ubyte bOpen;
}

struct DOT11_IBSS_PARAMS
{
    NDIS_OBJECT_HEADER Header;
    ubyte bJoinOnly;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_QOS_PARAMS
{
    NDIS_OBJECT_HEADER Header;
    ubyte ucEnabledQoSProtocolFlags;
}

struct DOT11_ASSOCIATION_PARAMS
{
    NDIS_OBJECT_HEADER Header;
    ubyte BSSID;
    uint uAssocRequestIEsOffset;
    uint uAssocRequestIEsLength;
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
    uint uHRCCAModeSupported;
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
    DOT11_PHY_TYPE PhyType;
    ubyte bHardwarePhyState;
    ubyte bSoftwarePhyState;
    ubyte bCFPollable;
    uint uMPDUMaxLength;
    DOT11_TEMP_TYPE TempType;
    DOT11_DIVERSITY_SUPPORT DiversitySupport;
    _PhySpecificAttributes_e__Union PhySpecificAttributes;
    uint uNumberSupportedPowerLevels;
    uint TxPowerLevels;
    uint uNumDataRateMappingEntries;
    DOT11_DATA_RATE_MAPPING_ENTRY DataRateMappingEntries;
    DOT11_SUPPORTED_DATA_RATES_VALUE_V2 SupportedDataRatesValue;
}

struct DOT11_EXTSTA_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint uScanSSIDListSize;
    uint uDesiredBSSIDListSize;
    uint uDesiredSSIDListSize;
    uint uExcludedMacAddressListSize;
    uint uPrivacyExemptionListSize;
    uint uKeyMappingTableSize;
    uint uDefaultKeyTableSize;
    uint uWEPKeyValueMaxLength;
    uint uPMKIDCacheSize;
    uint uMaxNumPerSTADefaultKeyTables;
    ubyte bStrictlyOrderedServiceClassImplemented;
    ubyte ucSupportedQoSProtocolFlags;
    ubyte bSafeModeImplemented;
    uint uNumSupportedCountryOrRegionStrings;
    ubyte* pSupportedCountryOrRegionStrings;
    uint uInfraNumSupportedUcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedUcastAlgoPairs;
    uint uInfraNumSupportedMcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedMcastAlgoPairs;
    uint uAdhocNumSupportedUcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pAdhocSupportedUcastAlgoPairs;
    uint uAdhocNumSupportedMcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pAdhocSupportedMcastAlgoPairs;
    ubyte bAutoPowerSaveMode;
    uint uMaxNetworkOffloadListSize;
    ubyte bMFPCapable;
    uint uInfraNumSupportedMcastMgmtAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedMcastMgmtAlgoPairs;
    ubyte bNeighborReportSupported;
    ubyte bAPChannelReportSupported;
    ubyte bActionFramesSupported;
    ubyte bANQPQueryOffloadSupported;
    ubyte bHESSIDConnectionSupported;
}

struct DOT11_RECV_EXTENSION_INFO
{
    uint uVersion;
    void* pvReserved;
    DOT11_PHY_TYPE dot11PhyType;
    uint uChCenterFrequency;
    int lRSSI;
    int lRSSIMin;
    int lRSSIMax;
    uint uRSSI;
    ubyte ucPriority;
    ubyte ucDataRate;
    ubyte ucPeerMacAddress;
    uint dwExtendedStatus;
    HANDLE hWEPOffloadContext;
    HANDLE hAuthOffloadContext;
    ushort usWEPAppliedMask;
    ushort usWPAMSDUPriority;
    DOT11_IV48_COUNTER dot11LowestIV48Counter;
    ushort usDot11LeftRWBitMap;
    DOT11_IV48_COUNTER dot11HighestIV48Counter;
    ushort usDot11RightRWBitMap;
    ushort usNumberOfMPDUsReceived;
    ushort usNumberOfFragments;
    void* pNdisPackets;
}

struct DOT11_RECV_EXTENSION_INFO_V2
{
    uint uVersion;
    void* pvReserved;
    DOT11_PHY_TYPE dot11PhyType;
    uint uChCenterFrequency;
    int lRSSI;
    uint uRSSI;
    ubyte ucPriority;
    ubyte ucDataRate;
    ubyte ucPeerMacAddress;
    uint dwExtendedStatus;
    HANDLE hWEPOffloadContext;
    HANDLE hAuthOffloadContext;
    ushort usWEPAppliedMask;
    ushort usWPAMSDUPriority;
    DOT11_IV48_COUNTER dot11LowestIV48Counter;
    ushort usDot11LeftRWBitMap;
    DOT11_IV48_COUNTER dot11HighestIV48Counter;
    ushort usDot11RightRWBitMap;
    ushort usNumberOfMPDUsReceived;
    ushort usNumberOfFragments;
    void* pNdisPackets;
}

struct DOT11_STATUS_INDICATION
{
    uint uStatusType;
    int ndisStatus;
}

struct DOT11_MPDU_MAX_LENGTH_INDICATION
{
    NDIS_OBJECT_HEADER Header;
    uint uPhyId;
    uint uMPDUMaxLength;
}

struct DOT11_ASSOCIATION_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte MacAddr;
    DOT11_SSID SSID;
    uint uIHVDataOffset;
    uint uIHVDataSize;
}

struct DOT11_ENCAP_ENTRY
{
    ushort usEtherType;
    ushort usEncapType;
}

enum DOT11_DS_INFO
{
    DOT11_DS_CHANGED = 0,
    DOT11_DS_UNCHANGED = 1,
    DOT11_DS_UNKNOWN = 2,
}

struct DOT11_ASSOCIATION_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte MacAddr;
    uint uStatus;
    ubyte bReAssocReq;
    ubyte bReAssocResp;
    uint uAssocReqOffset;
    uint uAssocReqSize;
    uint uAssocRespOffset;
    uint uAssocRespSize;
    uint uBeaconOffset;
    uint uBeaconSize;
    uint uIHVDataOffset;
    uint uIHVDataSize;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CIPHER_ALGORITHM UnicastCipher;
    DOT11_CIPHER_ALGORITHM MulticastCipher;
    uint uActivePhyListOffset;
    uint uActivePhyListSize;
    ubyte bFourAddressSupported;
    ubyte bPortAuthorized;
    ubyte ucActiveQoSProtocol;
    DOT11_DS_INFO DSInfo;
    uint uEncapTableOffset;
    uint uEncapTableSize;
    DOT11_CIPHER_ALGORITHM MulticastMgmtCipher;
    uint uAssocComebackTime;
}

struct DOT11_CONNECTION_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_BSS_TYPE BSSType;
    ubyte AdhocBSSID;
    DOT11_SSID AdhocSSID;
}

struct DOT11_CONNECTION_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint uStatus;
}

struct DOT11_ROAMING_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte AdhocBSSID;
    DOT11_SSID AdhocSSID;
    uint uRoamingReason;
}

struct DOT11_ROAMING_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint uStatus;
}

struct DOT11_DISASSOCIATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte MacAddr;
    uint uReason;
    uint uIHVDataOffset;
    uint uIHVDataSize;
}

struct DOT11_TKIPMIC_FAILURE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte bDefaultKeyFailure;
    uint uKeyIndex;
    ubyte PeerMac;
}

struct DOT11_PMKID_CANDIDATE_LIST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint uCandidateListSize;
    uint uCandidateListOffset;
}

struct DOT11_BSSID_CANDIDATE
{
    ubyte BSSID;
    uint uFlags;
}

struct DOT11_PHY_STATE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint uPhyId;
    ubyte bHardwarePhyState;
    ubyte bSoftwarePhyState;
}

struct DOT11_LINK_QUALITY_ENTRY
{
    ubyte PeerMacAddr;
    ubyte ucLinkQuality;
}

struct DOT11_LINK_QUALITY_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint uLinkQualityListSize;
    uint uLinkQualityListOffset;
}

struct DOT11_EXTSTA_SEND_CONTEXT
{
    NDIS_OBJECT_HEADER Header;
    ushort usExemptionActionType;
    uint uPhyId;
    uint uDelayedSleepValue;
    void* pvMediaSpecificInfo;
    uint uSendFlags;
}

struct DOT11_EXTSTA_RECV_CONTEXT
{
    NDIS_OBJECT_HEADER Header;
    uint uReceiveFlags;
    uint uPhyId;
    uint uChCenterFrequency;
    ushort usNumberOfMPDUsReceived;
    int lRSSI;
    ubyte ucDataRate;
    uint uSizeMediaSpecificInfo;
    void* pvMediaSpecificInfo;
    ulong ullTimestamp;
}

struct DOT11_EXTAP_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint uScanSSIDListSize;
    uint uDesiredSSIDListSize;
    uint uPrivacyExemptionListSize;
    uint uAssociationTableSize;
    uint uDefaultKeyTableSize;
    uint uWEPKeyValueMaxLength;
    ubyte bStrictlyOrderedServiceClassImplemented;
    uint uNumSupportedCountryOrRegionStrings;
    ubyte* pSupportedCountryOrRegionStrings;
    uint uInfraNumSupportedUcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedUcastAlgoPairs;
    uint uInfraNumSupportedMcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedMcastAlgoPairs;
}

struct DOT11_INCOMING_ASSOC_STARTED_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerMacAddr;
}

struct DOT11_INCOMING_ASSOC_REQUEST_RECEIVED_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerMacAddr;
    ubyte bReAssocReq;
    uint uAssocReqOffset;
    uint uAssocReqSize;
}

struct DOT11_INCOMING_ASSOC_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerMacAddr;
    uint uStatus;
    ubyte ucErrorSource;
    ubyte bReAssocReq;
    ubyte bReAssocResp;
    uint uAssocReqOffset;
    uint uAssocReqSize;
    uint uAssocRespOffset;
    uint uAssocRespSize;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CIPHER_ALGORITHM UnicastCipher;
    DOT11_CIPHER_ALGORITHM MulticastCipher;
    uint uActivePhyListOffset;
    uint uActivePhyListSize;
    uint uBeaconOffset;
    uint uBeaconSize;
}

struct DOT11_STOP_AP_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint ulReason;
}

struct DOT11_PHY_FREQUENCY_ADOPTED_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint ulPhyId;
    _Anonymous_e__Union Anonymous;
}

struct DOT11_CAN_SUSTAIN_AP_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint ulReason;
}

struct DOT11_AVAILABLE_CHANNEL_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    uint uChannelNumber;
}

struct DOT11_AVAILABLE_FREQUENCY_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    uint uFrequencyValue;
}

struct DOT11_DISASSOCIATE_PEER_REQUEST
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerMacAddr;
    ushort usReason;
}

struct DOT11_INCOMING_ASSOC_DECISION
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerMacAddr;
    ubyte bAccept;
    ushort usReasonCode;
    uint uAssocResponseIEsOffset;
    uint uAssocResponseIEsLength;
}

struct DOT11_INCOMING_ASSOC_DECISION_V2
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerMacAddr;
    ubyte bAccept;
    ushort usReasonCode;
    uint uAssocResponseIEsOffset;
    uint uAssocResponseIEsLength;
    ubyte WFDStatus;
}

struct DOT11_ADDITIONAL_IE
{
    NDIS_OBJECT_HEADER Header;
    uint uBeaconIEsOffset;
    uint uBeaconIEsLength;
    uint uResponseIEsOffset;
    uint uResponseIEsLength;
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
    ubyte MacAddress;
    ushort usCapabilityInformation;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CIPHER_ALGORITHM UnicastCipherAlgo;
    DOT11_CIPHER_ALGORITHM MulticastCipherAlgo;
    ubyte bWpsEnabled;
    ushort usListenInterval;
    ubyte ucSupportedRates;
    ushort usAssociationID;
    DOT11_ASSOCIATION_STATE AssociationState;
    DOT11_POWER_MODE PowerMode;
    LARGE_INTEGER liAssociationUpTime;
    DOT11_PEER_STATISTICS Statistics;
}

struct DOT11_PEER_INFO_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_PEER_INFO PeerInfo;
}

struct DOT11_VWIFI_COMBINATION
{
    NDIS_OBJECT_HEADER Header;
    uint uNumInfrastructure;
    uint uNumAdhoc;
    uint uNumSoftAP;
}

struct DOT11_VWIFI_COMBINATION_V2
{
    NDIS_OBJECT_HEADER Header;
    uint uNumInfrastructure;
    uint uNumAdhoc;
    uint uNumSoftAP;
    uint uNumVirtualStation;
}

struct DOT11_VWIFI_COMBINATION_V3
{
    NDIS_OBJECT_HEADER Header;
    uint uNumInfrastructure;
    uint uNumAdhoc;
    uint uNumSoftAP;
    uint uNumVirtualStation;
    uint uNumWFDGroup;
}

struct DOT11_VWIFI_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint uTotalNumOfEntries;
    DOT11_VWIFI_COMBINATION Combinations;
}

struct DOT11_MAC_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint uOpmodeMask;
}

struct DOT11_MAC_INFO
{
    uint uReserved;
    uint uNdisPortNumber;
    ubyte MacAddr;
}

struct DOT11_WFD_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint uNumConcurrentGORole;
    uint uNumConcurrentClientRole;
    uint WPSVersionsSupported;
    ubyte bServiceDiscoverySupported;
    ubyte bClientDiscoverabilitySupported;
    ubyte bInfrastructureManagementSupported;
    uint uMaxSecondaryDeviceTypeListSize;
    ubyte DeviceAddress;
    uint uInterfaceAddressListCount;
    ubyte* pInterfaceAddressList;
    uint uNumSupportedCountryOrRegionStrings;
    ubyte* pSupportedCountryOrRegionStrings;
    uint uDiscoveryFilterListSize;
    uint uGORoleClientTableSize;
}

struct DOT11_WFD_DEVICE_TYPE
{
    ushort CategoryID;
    ushort SubCategoryID;
    ubyte OUI;
}

struct DOT11_WPS_DEVICE_NAME
{
    uint uDeviceNameLength;
    ubyte ucDeviceName;
}

struct DOT11_WFD_CONFIGURATION_TIMEOUT
{
    ubyte GOTimeout;
    ubyte ClientTimeout;
}

struct DOT11_WFD_GROUP_ID
{
    ubyte DeviceAddress;
    DOT11_SSID SSID;
}

struct DOT11_WFD_GO_INTENT
{
    ubyte _bitfield;
}

struct DOT11_WFD_CHANNEL
{
    ubyte CountryRegionString;
    ubyte OperatingClass;
    ubyte ChannelNumber;
}

enum DOT11_WPS_CONFIG_METHOD
{
    DOT11_WPS_CONFIG_METHOD_NULL = 0,
    DOT11_WPS_CONFIG_METHOD_DISPLAY = 8,
    DOT11_WPS_CONFIG_METHOD_NFC_TAG = 32,
    DOT11_WPS_CONFIG_METHOD_NFC_INTERFACE = 64,
    DOT11_WPS_CONFIG_METHOD_PUSHBUTTON = 128,
    DOT11_WPS_CONFIG_METHOD_KEYPAD = 256,
    DOT11_WPS_CONFIG_METHOD_WFDS_DEFAULT = 4096,
}

enum DOT11_WPS_DEVICE_PASSWORD_ID
{
    DOT11_WPS_PASSWORD_ID_DEFAULT = 0,
    DOT11_WPS_PASSWORD_ID_USER_SPECIFIED = 1,
    DOT11_WPS_PASSWORD_ID_MACHINE_SPECIFIED = 2,
    DOT11_WPS_PASSWORD_ID_REKEY = 3,
    DOT11_WPS_PASSWORD_ID_PUSHBUTTON = 4,
    DOT11_WPS_PASSWORD_ID_REGISTRAR_SPECIFIED = 5,
    DOT11_WPS_PASSWORD_ID_NFC_CONNECTION_HANDOVER = 7,
    DOT11_WPS_PASSWORD_ID_WFD_SERVICES = 8,
    DOT11_WPS_PASSWORD_ID_OOB_RANGE_MIN = 16,
    DOT11_WPS_PASSWORD_ID_OOB_RANGE_MAX = 65535,
}

struct WFDSVC_CONNECTION_CAPABILITY
{
    ubyte bNew;
    ubyte bClient;
    ubyte bGO;
}

struct DOT11_WFD_SERVICE_HASH_LIST
{
    ushort ServiceHashCount;
    ubyte ServiceHash;
}

struct DOT11_WFD_ADVERTISEMENT_ID
{
    uint AdvertisementID;
    ubyte ServiceAddress;
}

struct DOT11_WFD_SESSION_ID
{
    uint SessionID;
    ubyte SessionAddress;
}

struct DOT11_WFD_ADVERTISED_SERVICE_DESCRIPTOR
{
    uint AdvertisementID;
    ushort ConfigMethods;
    ubyte ServiceNameLength;
    ubyte ServiceName;
}

struct DOT11_WFD_ADVERTISED_SERVICE_LIST
{
    ushort ServiceCount;
    DOT11_WFD_ADVERTISED_SERVICE_DESCRIPTOR AdvertisedService;
}

struct DOT11_WFD_DISCOVER_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    int Status;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    uint uListOffset;
    uint uListLength;
}

struct DOT11_GO_NEGOTIATION_REQUEST_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte DialogToken;
    int Status;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_RECEIVED_GO_NEGOTIATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte DialogToken;
    void* RequestContext;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_GO_NEGOTIATION_RESPONSE_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte DialogToken;
    int Status;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_RECEIVED_GO_NEGOTIATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte DialogToken;
    void* ResponseContext;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_GO_NEGOTIATION_CONFIRMATION_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte DialogToken;
    int Status;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_RECEIVED_GO_NEGOTIATION_CONFIRMATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte DialogToken;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_INVITATION_REQUEST_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte ReceiverAddress;
    ubyte DialogToken;
    int Status;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_RECEIVED_INVITATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte TransmitterDeviceAddress;
    ubyte BSSID;
    ubyte DialogToken;
    void* RequestContext;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_INVITATION_RESPONSE_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte ReceiverDeviceAddress;
    ubyte DialogToken;
    int Status;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_RECEIVED_INVITATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte TransmitterDeviceAddress;
    ubyte BSSID;
    ubyte DialogToken;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_PROVISION_DISCOVERY_REQUEST_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte ReceiverAddress;
    ubyte DialogToken;
    int Status;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_RECEIVED_PROVISION_DISCOVERY_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte TransmitterDeviceAddress;
    ubyte BSSID;
    ubyte DialogToken;
    void* RequestContext;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_PROVISION_DISCOVERY_RESPONSE_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte ReceiverDeviceAddress;
    ubyte DialogToken;
    int Status;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_RECEIVED_PROVISION_DISCOVERY_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte TransmitterDeviceAddress;
    ubyte BSSID;
    ubyte DialogToken;
    uint uIEsOffset;
    uint uIEsLength;
}

enum DOT11_ANQP_QUERY_RESULT
{
    dot11_ANQP_query_result_success = 0,
    dot11_ANQP_query_result_failure = 1,
    dot11_ANQP_query_result_timed_out = 2,
    dot11_ANQP_query_result_resources = 3,
    dot11_ANQP_query_result_advertisement_protocol_not_supported_on_remote = 4,
    dot11_ANQP_query_result_gas_protocol_failure = 5,
    dot11_ANQP_query_result_advertisement_server_not_responding = 6,
    dot11_ANQP_query_result_access_issues = 7,
}

struct DOT11_ANQP_QUERY_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_ANQP_QUERY_RESULT Status;
    HANDLE hContext;
    uint uResponseLength;
}

struct DOT11_WFD_DEVICE_CAPABILITY_CONFIG
{
    NDIS_OBJECT_HEADER Header;
    ubyte bServiceDiscoveryEnabled;
    ubyte bClientDiscoverabilityEnabled;
    ubyte bConcurrentOperationSupported;
    ubyte bInfrastructureManagementEnabled;
    ubyte bDeviceLimitReached;
    ubyte bInvitationProcedureEnabled;
    uint WPSVersionsEnabled;
}

struct DOT11_WFD_GROUP_OWNER_CAPABILITY_CONFIG
{
    NDIS_OBJECT_HEADER Header;
    ubyte bPersistentGroupEnabled;
    ubyte bIntraBSSDistributionSupported;
    ubyte bCrossConnectionSupported;
    ubyte bPersistentReconnectSupported;
    ubyte bGroupFormationEnabled;
    uint uMaximumGroupLimit;
}

struct DOT11_WFD_GROUP_OWNER_CAPABILITY_CONFIG_V2
{
    NDIS_OBJECT_HEADER Header;
    ubyte bPersistentGroupEnabled;
    ubyte bIntraBSSDistributionSupported;
    ubyte bCrossConnectionSupported;
    ubyte bPersistentReconnectSupported;
    ubyte bGroupFormationEnabled;
    uint uMaximumGroupLimit;
    ubyte bEapolKeyIpAddressAllocationSupported;
}

struct DOT11_WFD_DEVICE_INFO
{
    NDIS_OBJECT_HEADER Header;
    ubyte DeviceAddress;
    ushort ConfigMethods;
    DOT11_WFD_DEVICE_TYPE PrimaryDeviceType;
    DOT11_WPS_DEVICE_NAME DeviceName;
}

struct DOT11_WFD_SECONDARY_DEVICE_TYPE_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    DOT11_WFD_DEVICE_TYPE SecondaryDeviceTypes;
}

enum DOT11_WFD_DISCOVER_TYPE
{
    dot11_wfd_discover_type_scan_only = 1,
    dot11_wfd_discover_type_find_only = 2,
    dot11_wfd_discover_type_auto = 3,
    dot11_wfd_discover_type_scan_social_channels = 4,
    dot11_wfd_discover_type_forced = -2147483648,
}

enum DOT11_WFD_SCAN_TYPE
{
    dot11_wfd_scan_type_active = 1,
    dot11_wfd_scan_type_passive = 2,
    dot11_wfd_scan_type_auto = 3,
}

struct DOT11_WFD_DISCOVER_DEVICE_FILTER
{
    ubyte DeviceID;
    ubyte ucBitmask;
    DOT11_SSID GroupSSID;
}

struct DOT11_WFD_DISCOVER_REQUEST
{
    NDIS_OBJECT_HEADER Header;
    DOT11_WFD_DISCOVER_TYPE DiscoverType;
    DOT11_WFD_SCAN_TYPE ScanType;
    uint uDiscoverTimeout;
    uint uDeviceFilterListOffset;
    uint uNumDeviceFilters;
    uint uIEsOffset;
    uint uIEsLength;
    ubyte bForceScanLegacyNetworks;
}

struct DOT11_WFD_DEVICE_ENTRY
{
    uint uPhyId;
    DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO PhySpecificInfo;
    ubyte dot11BSSID;
    DOT11_BSS_TYPE dot11BSSType;
    ubyte TransmitterAddress;
    int lRSSI;
    uint uLinkQuality;
    ushort usBeaconPeriod;
    ulong ullTimestamp;
    ulong ullBeaconHostTimestamp;
    ulong ullProbeResponseHostTimestamp;
    ushort usCapabilityInformation;
    uint uBeaconIEsOffset;
    uint uBeaconIEsLength;
    uint uProbeResponseIEsOffset;
    uint uProbeResponseIEsLength;
}

struct DOT11_WFD_ADDITIONAL_IE
{
    NDIS_OBJECT_HEADER Header;
    uint uBeaconIEsOffset;
    uint uBeaconIEsLength;
    uint uProbeResponseIEsOffset;
    uint uProbeResponseIEsLength;
    uint uDefaultRequestIEsOffset;
    uint uDefaultRequestIEsLength;
}

struct DOT11_SEND_GO_NEGOTIATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte DialogToken;
    uint uSendTimeout;
    DOT11_WFD_GO_INTENT GroupOwnerIntent;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    ubyte IntendedInterfaceAddress;
    ubyte GroupCapability;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_SEND_GO_NEGOTIATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte DialogToken;
    void* RequestContext;
    uint uSendTimeout;
    ubyte Status;
    DOT11_WFD_GO_INTENT GroupOwnerIntent;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    ubyte IntendedInterfaceAddress;
    ubyte GroupCapability;
    DOT11_WFD_GROUP_ID GroupID;
    ubyte bUseGroupID;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_SEND_GO_NEGOTIATION_CONFIRMATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte PeerDeviceAddress;
    ubyte DialogToken;
    void* ResponseContext;
    uint uSendTimeout;
    ubyte Status;
    ubyte GroupCapability;
    DOT11_WFD_GROUP_ID GroupID;
    ubyte bUseGroupID;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_WFD_INVITATION_FLAGS
{
    ubyte _bitfield;
}

struct DOT11_SEND_INVITATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte DialogToken;
    ubyte PeerDeviceAddress;
    uint uSendTimeout;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    DOT11_WFD_INVITATION_FLAGS InvitationFlags;
    ubyte GroupBSSID;
    ubyte bUseGroupBSSID;
    DOT11_WFD_CHANNEL OperatingChannel;
    ubyte bUseSpecifiedOperatingChannel;
    DOT11_WFD_GROUP_ID GroupID;
    ubyte bLocalGO;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_SEND_INVITATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte ReceiverDeviceAddress;
    ubyte DialogToken;
    void* RequestContext;
    uint uSendTimeout;
    ubyte Status;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    ubyte GroupBSSID;
    ubyte bUseGroupBSSID;
    DOT11_WFD_CHANNEL OperatingChannel;
    ubyte bUseSpecifiedOperatingChannel;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_SEND_PROVISION_DISCOVERY_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte DialogToken;
    ubyte PeerDeviceAddress;
    uint uSendTimeout;
    ubyte GroupCapability;
    DOT11_WFD_GROUP_ID GroupID;
    ubyte bUseGroupID;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_SEND_PROVISION_DISCOVERY_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte ReceiverDeviceAddress;
    ubyte DialogToken;
    void* RequestContext;
    uint uSendTimeout;
    uint uIEsOffset;
    uint uIEsLength;
}

struct DOT11_WFD_DEVICE_LISTEN_CHANNEL
{
    NDIS_OBJECT_HEADER Header;
    ubyte ChannelNumber;
}

struct DOT11_WFD_GROUP_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_WFD_CHANNEL AdvertisedOperatingChannel;
}

struct DOT11_WFD_GROUP_JOIN_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_WFD_CHANNEL GOOperatingChannel;
    uint GOConfigTime;
    ubyte bInGroupFormation;
    ubyte bWaitForWPSReady;
}

struct DOT11_POWER_MGMT_AUTO_MODE_ENABLED_INFO
{
    NDIS_OBJECT_HEADER Header;
    ubyte bEnabled;
}

enum DOT11_POWER_MODE_REASON
{
    dot11_power_mode_reason_no_change = 0,
    dot11_power_mode_reason_noncompliant_AP = 1,
    dot11_power_mode_reason_legacy_WFD_device = 2,
    dot11_power_mode_reason_compliant_AP = 3,
    dot11_power_mode_reason_compliant_WFD_device = 4,
    dot11_power_mode_reason_others = 5,
}

struct DOT11_POWER_MGMT_MODE_STATUS_INFO
{
    NDIS_OBJECT_HEADER Header;
    DOT11_POWER_MODE PowerSaveMode;
    uint uPowerSaveLevel;
    DOT11_POWER_MODE_REASON Reason;
}

struct DOT11_CHANNEL_HINT
{
    DOT11_PHY_TYPE Dot11PhyType;
    uint uChannelNumber;
}

struct DOT11_OFFLOAD_NETWORK
{
    DOT11_SSID Ssid;
    DOT11_CIPHER_ALGORITHM UnicastCipher;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CHANNEL_HINT Dot11ChannelHints;
}

struct DOT11_OFFLOAD_NETWORK_LIST_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint ulFlags;
    uint FastScanPeriod;
    uint FastScanIterations;
    uint SlowScanPeriod;
    uint uNumOfEntries;
    DOT11_OFFLOAD_NETWORK offloadNetworkList;
}

struct DOT11_OFFLOAD_NETWORK_STATUS_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    int Status;
}

enum DOT11_MANUFACTURING_TEST_TYPE
{
    dot11_manufacturing_test_unknown = 0,
    dot11_manufacturing_test_self_start = 1,
    dot11_manufacturing_test_self_query_result = 2,
    dot11_manufacturing_test_rx = 3,
    dot11_manufacturing_test_tx = 4,
    dot11_manufacturing_test_query_adc = 5,
    dot11_manufacturing_test_set_data = 6,
    dot11_manufacturing_test_query_data = 7,
    dot11_manufacturing_test_sleep = 8,
    dot11_manufacturing_test_awake = 9,
    dot11_manufacturing_test_IHV_start = -2147483648,
    dot11_manufacturing_test_IHV_end = -1,
}

struct DOT11_MANUFACTURING_TEST
{
    DOT11_MANUFACTURING_TEST_TYPE dot11ManufacturingTestType;
    uint uBufferLength;
    ubyte ucBuffer;
}

enum DOT11_MANUFACTURING_SELF_TEST_TYPE
{
    DOT11_MANUFACTURING_SELF_TEST_TYPE_INTERFACE = 1,
    DOT11_MANUFACTURING_SELF_TEST_TYPE_RF_INTERFACE = 2,
    DOT11_MANUFACTURING_SELF_TEST_TYPE_BT_COEXISTENCE = 3,
}

struct DOT11_MANUFACTURING_SELF_TEST_SET_PARAMS
{
    DOT11_MANUFACTURING_SELF_TEST_TYPE SelfTestType;
    uint uTestID;
    uint uPinBitMask;
    void* pvContext;
    uint uBufferLength;
    ubyte ucBufferIn;
}

struct DOT11_MANUFACTURING_SELF_TEST_QUERY_RESULTS
{
    DOT11_MANUFACTURING_SELF_TEST_TYPE SelfTestType;
    uint uTestID;
    ubyte bResult;
    uint uPinFailedBitMask;
    void* pvContext;
    uint uBytesWrittenOut;
    ubyte ucBufferOut;
}

enum DOT11_BAND
{
    dot11_band_2p4g = 1,
    dot11_band_4p9g = 2,
    dot11_band_5g = 3,
}

struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_RX
{
    ubyte bEnabled;
    DOT11_BAND Dot11Band;
    uint uChannel;
    int PowerLevel;
}

struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_TX
{
    ubyte bEnable;
    ubyte bOpenLoop;
    DOT11_BAND Dot11Band;
    uint uChannel;
    uint uSetPowerLevel;
    int ADCPowerLevel;
}

struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_QUERY_ADC
{
    DOT11_BAND Dot11Band;
    uint uChannel;
    int ADCPowerLevel;
}

struct DOT11_MANUFACTURING_TEST_SET_DATA
{
    uint uKey;
    uint uOffset;
    uint uBufferLength;
    ubyte ucBufferIn;
}

struct DOT11_MANUFACTURING_TEST_QUERY_DATA
{
    uint uKey;
    uint uOffset;
    uint uBufferLength;
    uint uBytesRead;
    ubyte ucBufferOut;
}

struct DOT11_MANUFACTURING_TEST_SLEEP
{
    uint uSleepTime;
    void* pvContext;
}

enum DOT11_MANUFACTURING_CALLBACK_TYPE
{
    dot11_manufacturing_callback_unknown = 0,
    dot11_manufacturing_callback_self_test_complete = 1,
    dot11_manufacturing_callback_sleep_complete = 2,
    dot11_manufacturing_callback_IHV_start = -2147483648,
    dot11_manufacturing_callback_IHV_end = -1,
}

struct DOT11_MANUFACTURING_CALLBACK_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_MANUFACTURING_CALLBACK_TYPE dot11ManufacturingCallbackType;
    uint uStatus;
    void* pvContext;
}

struct WLAN_PROFILE_INFO
{
    ushort strProfileName;
    uint dwFlags;
}

struct DOT11_NETWORK
{
    DOT11_SSID dot11Ssid;
    DOT11_BSS_TYPE dot11BssType;
}

struct WLAN_RAW_DATA
{
    uint dwDataSize;
    ubyte DataBlob;
}

struct WLAN_RAW_DATA_LIST
{
    uint dwTotalSize;
    uint dwNumberOfItems;
    _Anonymous_e__Struct DataList;
}

enum WLAN_CONNECTION_MODE
{
    wlan_connection_mode_profile = 0,
    wlan_connection_mode_temporary_profile = 1,
    wlan_connection_mode_discovery_secure = 2,
    wlan_connection_mode_discovery_unsecure = 3,
    wlan_connection_mode_auto = 4,
    wlan_connection_mode_invalid = 5,
}

struct WLAN_RATE_SET
{
    uint uRateSetLength;
    ushort usRateSet;
}

struct WLAN_AVAILABLE_NETWORK
{
    ushort strProfileName;
    DOT11_SSID dot11Ssid;
    DOT11_BSS_TYPE dot11BssType;
    uint uNumberOfBssids;
    BOOL bNetworkConnectable;
    uint wlanNotConnectableReason;
    uint uNumberOfPhyTypes;
    DOT11_PHY_TYPE dot11PhyTypes;
    BOOL bMorePhyTypes;
    uint wlanSignalQuality;
    BOOL bSecurityEnabled;
    DOT11_AUTH_ALGORITHM dot11DefaultAuthAlgorithm;
    DOT11_CIPHER_ALGORITHM dot11DefaultCipherAlgorithm;
    uint dwFlags;
    uint dwReserved;
}

struct WLAN_AVAILABLE_NETWORK_V2
{
    ushort strProfileName;
    DOT11_SSID dot11Ssid;
    DOT11_BSS_TYPE dot11BssType;
    uint uNumberOfBssids;
    BOOL bNetworkConnectable;
    uint wlanNotConnectableReason;
    uint uNumberOfPhyTypes;
    DOT11_PHY_TYPE dot11PhyTypes;
    BOOL bMorePhyTypes;
    uint wlanSignalQuality;
    BOOL bSecurityEnabled;
    DOT11_AUTH_ALGORITHM dot11DefaultAuthAlgorithm;
    DOT11_CIPHER_ALGORITHM dot11DefaultCipherAlgorithm;
    uint dwFlags;
    DOT11_ACCESSNETWORKOPTIONS AccessNetworkOptions;
    ubyte dot11HESSID;
    DOT11_VENUEINFO VenueInfo;
    uint dwReserved;
}

struct WLAN_BSS_ENTRY
{
    DOT11_SSID dot11Ssid;
    uint uPhyId;
    ubyte dot11Bssid;
    DOT11_BSS_TYPE dot11BssType;
    DOT11_PHY_TYPE dot11BssPhyType;
    int lRssi;
    uint uLinkQuality;
    ubyte bInRegDomain;
    ushort usBeaconPeriod;
    ulong ullTimestamp;
    ulong ullHostTimestamp;
    ushort usCapabilityInformation;
    uint ulChCenterFrequency;
    WLAN_RATE_SET wlanRateSet;
    uint ulIeOffset;
    uint ulIeSize;
}

struct WLAN_BSS_LIST
{
    uint dwTotalSize;
    uint dwNumberOfItems;
    WLAN_BSS_ENTRY wlanBssEntries;
}

enum WLAN_INTERFACE_STATE
{
    wlan_interface_state_not_ready = 0,
    wlan_interface_state_connected = 1,
    wlan_interface_state_ad_hoc_network_formed = 2,
    wlan_interface_state_disconnecting = 3,
    wlan_interface_state_disconnected = 4,
    wlan_interface_state_associating = 5,
    wlan_interface_state_discovering = 6,
    wlan_interface_state_authenticating = 7,
}

enum WLAN_ADHOC_NETWORK_STATE
{
    wlan_adhoc_network_state_formed = 0,
    wlan_adhoc_network_state_connected = 1,
}

struct WLAN_INTERFACE_INFO
{
    Guid InterfaceGuid;
    ushort strInterfaceDescription;
    WLAN_INTERFACE_STATE isState;
}

struct WLAN_ASSOCIATION_ATTRIBUTES
{
    DOT11_SSID dot11Ssid;
    DOT11_BSS_TYPE dot11BssType;
    ubyte dot11Bssid;
    DOT11_PHY_TYPE dot11PhyType;
    uint uDot11PhyIndex;
    uint wlanSignalQuality;
    uint ulRxRate;
    uint ulTxRate;
}

struct WLAN_SECURITY_ATTRIBUTES
{
    BOOL bSecurityEnabled;
    BOOL bOneXEnabled;
    DOT11_AUTH_ALGORITHM dot11AuthAlgorithm;
    DOT11_CIPHER_ALGORITHM dot11CipherAlgorithm;
}

struct WLAN_CONNECTION_ATTRIBUTES
{
    WLAN_INTERFACE_STATE isState;
    WLAN_CONNECTION_MODE wlanConnectionMode;
    ushort strProfileName;
    WLAN_ASSOCIATION_ATTRIBUTES wlanAssociationAttributes;
    WLAN_SECURITY_ATTRIBUTES wlanSecurityAttributes;
}

enum DOT11_RADIO_STATE
{
    dot11_radio_state_unknown = 0,
    dot11_radio_state_on = 1,
    dot11_radio_state_off = 2,
}

struct WLAN_PHY_RADIO_STATE
{
    uint dwPhyIndex;
    DOT11_RADIO_STATE dot11SoftwareRadioState;
    DOT11_RADIO_STATE dot11HardwareRadioState;
}

struct WLAN_RADIO_STATE
{
    uint dwNumberOfPhys;
    WLAN_PHY_RADIO_STATE PhyRadioState;
}

enum WLAN_OPERATIONAL_STATE
{
    wlan_operational_state_unknown = 0,
    wlan_operational_state_off = 1,
    wlan_operational_state_on = 2,
    wlan_operational_state_going_off = 3,
    wlan_operational_state_going_on = 4,
}

enum WLAN_INTERFACE_TYPE
{
    wlan_interface_type_emulated_802_11 = 0,
    wlan_interface_type_native_802_11 = 1,
    wlan_interface_type_invalid = 2,
}

struct WLAN_INTERFACE_CAPABILITY
{
    WLAN_INTERFACE_TYPE interfaceType;
    BOOL bDot11DSupported;
    uint dwMaxDesiredSsidListSize;
    uint dwMaxDesiredBssidListSize;
    uint dwNumberOfSupportedPhys;
    DOT11_PHY_TYPE dot11PhyTypes;
}

struct WLAN_AUTH_CIPHER_PAIR_LIST
{
    uint dwNumberOfItems;
    DOT11_AUTH_CIPHER_PAIR pAuthCipherPairList;
}

struct WLAN_COUNTRY_OR_REGION_STRING_LIST
{
    uint dwNumberOfItems;
    ubyte pCountryOrRegionStringList;
}

struct WLAN_PROFILE_INFO_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    WLAN_PROFILE_INFO ProfileInfo;
}

struct WLAN_AVAILABLE_NETWORK_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    WLAN_AVAILABLE_NETWORK Network;
}

struct WLAN_AVAILABLE_NETWORK_LIST_V2
{
    uint dwNumberOfItems;
    uint dwIndex;
    WLAN_AVAILABLE_NETWORK_V2 Network;
}

struct WLAN_INTERFACE_INFO_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    WLAN_INTERFACE_INFO InterfaceInfo;
}

struct DOT11_NETWORK_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    DOT11_NETWORK Network;
}

enum WLAN_POWER_SETTING
{
    wlan_power_setting_no_saving = 0,
    wlan_power_setting_low_saving = 1,
    wlan_power_setting_medium_saving = 2,
    wlan_power_setting_maximum_saving = 3,
    wlan_power_setting_invalid = 4,
}

struct WLAN_CONNECTION_PARAMETERS
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    const(wchar)* strProfile;
    DOT11_SSID* pDot11Ssid;
    DOT11_BSSID_LIST* pDesiredBssidList;
    DOT11_BSS_TYPE dot11BssType;
    uint dwFlags;
}

struct WLAN_CONNECTION_PARAMETERS_V2
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    const(wchar)* strProfile;
    DOT11_SSID* pDot11Ssid;
    ubyte* pDot11Hessid;
    DOT11_BSSID_LIST* pDesiredBssidList;
    DOT11_BSS_TYPE dot11BssType;
    uint dwFlags;
    DOT11_ACCESSNETWORKOPTIONS* pDot11AccessNetworkOptions;
}

struct WLAN_MSM_NOTIFICATION_DATA
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    ushort strProfileName;
    DOT11_SSID dot11Ssid;
    DOT11_BSS_TYPE dot11BssType;
    ubyte dot11MacAddr;
    BOOL bSecurityEnabled;
    BOOL bFirstPeer;
    BOOL bLastPeer;
    uint wlanReasonCode;
}

struct WLAN_CONNECTION_NOTIFICATION_DATA
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    ushort strProfileName;
    DOT11_SSID dot11Ssid;
    DOT11_BSS_TYPE dot11BssType;
    BOOL bSecurityEnabled;
    uint wlanReasonCode;
    uint dwFlags;
    ushort strProfileXml;
}

struct WLAN_DEVICE_SERVICE_NOTIFICATION_DATA
{
    Guid DeviceService;
    uint dwOpCode;
    uint dwDataSize;
    ubyte DataBlob;
}

enum WLAN_NOTIFICATION_ACM
{
    wlan_notification_acm_start = 0,
    wlan_notification_acm_autoconf_enabled = 1,
    wlan_notification_acm_autoconf_disabled = 2,
    wlan_notification_acm_background_scan_enabled = 3,
    wlan_notification_acm_background_scan_disabled = 4,
    wlan_notification_acm_bss_type_change = 5,
    wlan_notification_acm_power_setting_change = 6,
    wlan_notification_acm_scan_complete = 7,
    wlan_notification_acm_scan_fail = 8,
    wlan_notification_acm_connection_start = 9,
    wlan_notification_acm_connection_complete = 10,
    wlan_notification_acm_connection_attempt_fail = 11,
    wlan_notification_acm_filter_list_change = 12,
    wlan_notification_acm_interface_arrival = 13,
    wlan_notification_acm_interface_removal = 14,
    wlan_notification_acm_profile_change = 15,
    wlan_notification_acm_profile_name_change = 16,
    wlan_notification_acm_profiles_exhausted = 17,
    wlan_notification_acm_network_not_available = 18,
    wlan_notification_acm_network_available = 19,
    wlan_notification_acm_disconnecting = 20,
    wlan_notification_acm_disconnected = 21,
    wlan_notification_acm_adhoc_network_state_change = 22,
    wlan_notification_acm_profile_unblocked = 23,
    wlan_notification_acm_screen_power_change = 24,
    wlan_notification_acm_profile_blocked = 25,
    wlan_notification_acm_scan_list_refresh = 26,
    wlan_notification_acm_operational_state_change = 27,
    wlan_notification_acm_end = 28,
}

enum WLAN_NOTIFICATION_MSM
{
    wlan_notification_msm_start = 0,
    wlan_notification_msm_associating = 1,
    wlan_notification_msm_associated = 2,
    wlan_notification_msm_authenticating = 3,
    wlan_notification_msm_connected = 4,
    wlan_notification_msm_roaming_start = 5,
    wlan_notification_msm_roaming_end = 6,
    wlan_notification_msm_radio_state_change = 7,
    wlan_notification_msm_signal_quality_change = 8,
    wlan_notification_msm_disassociating = 9,
    wlan_notification_msm_disconnected = 10,
    wlan_notification_msm_peer_join = 11,
    wlan_notification_msm_peer_leave = 12,
    wlan_notification_msm_adapter_removal = 13,
    wlan_notification_msm_adapter_operation_mode_change = 14,
    wlan_notification_msm_link_degraded = 15,
    wlan_notification_msm_link_improved = 16,
    wlan_notification_msm_end = 17,
}

enum WLAN_NOTIFICATION_SECURITY
{
    wlan_notification_security_start = 0,
    wlan_notification_security_end = 1,
}

alias WLAN_NOTIFICATION_CALLBACK = extern(Windows) void function(L2_NOTIFICATION_DATA* param0, void* param1);
enum WLAN_OPCODE_VALUE_TYPE
{
    wlan_opcode_value_type_query_only = 0,
    wlan_opcode_value_type_set_by_group_policy = 1,
    wlan_opcode_value_type_set_by_user = 2,
    wlan_opcode_value_type_invalid = 3,
}

enum WLAN_INTF_OPCODE
{
    wlan_intf_opcode_autoconf_start = 0,
    wlan_intf_opcode_autoconf_enabled = 1,
    wlan_intf_opcode_background_scan_enabled = 2,
    wlan_intf_opcode_media_streaming_mode = 3,
    wlan_intf_opcode_radio_state = 4,
    wlan_intf_opcode_bss_type = 5,
    wlan_intf_opcode_interface_state = 6,
    wlan_intf_opcode_current_connection = 7,
    wlan_intf_opcode_channel_number = 8,
    wlan_intf_opcode_supported_infrastructure_auth_cipher_pairs = 9,
    wlan_intf_opcode_supported_adhoc_auth_cipher_pairs = 10,
    wlan_intf_opcode_supported_country_or_region_string_list = 11,
    wlan_intf_opcode_current_operation_mode = 12,
    wlan_intf_opcode_supported_safe_mode = 13,
    wlan_intf_opcode_certified_safe_mode = 14,
    wlan_intf_opcode_hosted_network_capable = 15,
    wlan_intf_opcode_management_frame_protection_capable = 16,
    wlan_intf_opcode_autoconf_end = 268435455,
    wlan_intf_opcode_msm_start = 268435712,
    wlan_intf_opcode_statistics = 268435713,
    wlan_intf_opcode_rssi = 268435714,
    wlan_intf_opcode_msm_end = 536870911,
    wlan_intf_opcode_security_start = 536936448,
    wlan_intf_opcode_security_end = 805306367,
    wlan_intf_opcode_ihv_start = 805306368,
    wlan_intf_opcode_ihv_end = 1073741823,
}

enum WLAN_AUTOCONF_OPCODE
{
    wlan_autoconf_opcode_start = 0,
    wlan_autoconf_opcode_show_denied_networks = 1,
    wlan_autoconf_opcode_power_setting = 2,
    wlan_autoconf_opcode_only_use_gp_profiles_for_allowed_networks = 3,
    wlan_autoconf_opcode_allow_explicit_creds = 4,
    wlan_autoconf_opcode_block_period = 5,
    wlan_autoconf_opcode_allow_virtual_station_extensibility = 6,
    wlan_autoconf_opcode_end = 7,
}

enum WLAN_IHV_CONTROL_TYPE
{
    wlan_ihv_control_type_service = 0,
    wlan_ihv_control_type_driver = 1,
}

enum WLAN_FILTER_LIST_TYPE
{
    wlan_filter_list_type_gp_permit = 0,
    wlan_filter_list_type_gp_deny = 1,
    wlan_filter_list_type_user_permit = 2,
    wlan_filter_list_type_user_deny = 3,
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
    uint dwNumberOfPhys;
    WLAN_PHY_FRAME_STATISTICS PhyCounters;
}

enum WLAN_SECURABLE_OBJECT
{
    wlan_secure_permit_list = 0,
    wlan_secure_deny_list = 1,
    wlan_secure_ac_enabled = 2,
    wlan_secure_bc_scan_enabled = 3,
    wlan_secure_bss_type = 4,
    wlan_secure_show_denied = 5,
    wlan_secure_interface_properties = 6,
    wlan_secure_ihv_control = 7,
    wlan_secure_all_user_profiles_order = 8,
    wlan_secure_add_new_all_user_profiles = 9,
    wlan_secure_add_new_per_user_profiles = 10,
    wlan_secure_media_streaming_mode_enabled = 11,
    wlan_secure_current_operation_mode = 12,
    wlan_secure_get_plaintext_key = 13,
    wlan_secure_hosted_network_elevated_access = 14,
    wlan_secure_virtual_station_extensibility = 15,
    wlan_secure_wfd_elevated_access = 16,
    WLAN_SECURABLE_OBJECT_COUNT = 17,
}

struct WLAN_DEVICE_SERVICE_GUID_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    Guid DeviceService;
}

enum WFD_ROLE_TYPE
{
    WFD_ROLE_TYPE_NONE = 0,
    WFD_ROLE_TYPE_DEVICE = 1,
    WFD_ROLE_TYPE_GROUP_OWNER = 2,
    WFD_ROLE_TYPE_CLIENT = 4,
    WFD_ROLE_TYPE_MAX = 5,
}

struct WFD_GROUP_ID
{
    ubyte DeviceAddress;
    DOT11_SSID GroupSSID;
}

enum WL_DISPLAY_PAGES
{
    WLConnectionPage = 0,
    WLSecurityPage = 1,
    WLAdvPage = 2,
}

enum WLAN_HOSTED_NETWORK_STATE
{
    wlan_hosted_network_unavailable = 0,
    wlan_hosted_network_idle = 1,
    wlan_hosted_network_active = 2,
}

enum WLAN_HOSTED_NETWORK_REASON
{
    wlan_hosted_network_reason_success = 0,
    wlan_hosted_network_reason_unspecified = 1,
    wlan_hosted_network_reason_bad_parameters = 2,
    wlan_hosted_network_reason_service_shutting_down = 3,
    wlan_hosted_network_reason_insufficient_resources = 4,
    wlan_hosted_network_reason_elevation_required = 5,
    wlan_hosted_network_reason_read_only = 6,
    wlan_hosted_network_reason_persistence_failed = 7,
    wlan_hosted_network_reason_crypt_error = 8,
    wlan_hosted_network_reason_impersonation = 9,
    wlan_hosted_network_reason_stop_before_start = 10,
    wlan_hosted_network_reason_interface_available = 11,
    wlan_hosted_network_reason_interface_unavailable = 12,
    wlan_hosted_network_reason_miniport_stopped = 13,
    wlan_hosted_network_reason_miniport_started = 14,
    wlan_hosted_network_reason_incompatible_connection_started = 15,
    wlan_hosted_network_reason_incompatible_connection_stopped = 16,
    wlan_hosted_network_reason_user_action = 17,
    wlan_hosted_network_reason_client_abort = 18,
    wlan_hosted_network_reason_ap_start_failed = 19,
    wlan_hosted_network_reason_peer_arrived = 20,
    wlan_hosted_network_reason_peer_departed = 21,
    wlan_hosted_network_reason_peer_timeout = 22,
    wlan_hosted_network_reason_gp_denied = 23,
    wlan_hosted_network_reason_service_unavailable = 24,
    wlan_hosted_network_reason_device_change = 25,
    wlan_hosted_network_reason_properties_change = 26,
    wlan_hosted_network_reason_virtual_station_blocking_use = 27,
    wlan_hosted_network_reason_service_available_on_virtual_station = 28,
}

enum WLAN_HOSTED_NETWORK_PEER_AUTH_STATE
{
    wlan_hosted_network_peer_state_invalid = 0,
    wlan_hosted_network_peer_state_authenticated = 1,
}

struct WLAN_HOSTED_NETWORK_PEER_STATE
{
    ubyte PeerMacAddress;
    WLAN_HOSTED_NETWORK_PEER_AUTH_STATE PeerAuthState;
}

struct WLAN_HOSTED_NETWORK_RADIO_STATE
{
    DOT11_RADIO_STATE dot11SoftwareRadioState;
    DOT11_RADIO_STATE dot11HardwareRadioState;
}

enum WLAN_HOSTED_NETWORK_NOTIFICATION_CODE
{
    wlan_hosted_network_state_change = 4096,
    wlan_hosted_network_peer_state_change = 4097,
    wlan_hosted_network_radio_state_change = 4098,
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

enum WLAN_HOSTED_NETWORK_OPCODE
{
    wlan_hosted_network_opcode_connection_settings = 0,
    wlan_hosted_network_opcode_security_settings = 1,
    wlan_hosted_network_opcode_station_profile = 2,
    wlan_hosted_network_opcode_enable = 3,
}

struct WLAN_HOSTED_NETWORK_CONNECTION_SETTINGS
{
    DOT11_SSID hostedNetworkSSID;
    uint dwMaxNumberOfPeers;
}

struct WLAN_HOSTED_NETWORK_SECURITY_SETTINGS
{
    DOT11_AUTH_ALGORITHM dot11AuthAlgo;
    DOT11_CIPHER_ALGORITHM dot11CipherAlgo;
}

struct WLAN_HOSTED_NETWORK_STATUS
{
    WLAN_HOSTED_NETWORK_STATE HostedNetworkState;
    Guid IPDeviceID;
    ubyte wlanHostedNetworkBSSID;
    DOT11_PHY_TYPE dot11PhyType;
    uint ulChannelFrequency;
    uint dwNumberOfPeers;
    WLAN_HOSTED_NETWORK_PEER_STATE PeerList;
}

alias WFD_OPEN_SESSION_COMPLETE_CALLBACK = extern(Windows) void function(HANDLE hSessionHandle, void* pvContext, Guid guidSessionInterface, uint dwError, uint dwReasonCode);
enum ONEX_AUTH_IDENTITY
{
    OneXAuthIdentityNone = 0,
    OneXAuthIdentityMachine = 1,
    OneXAuthIdentityUser = 2,
    OneXAuthIdentityExplicitUser = 3,
    OneXAuthIdentityGuest = 4,
    OneXAuthIdentityInvalid = 5,
}

enum ONEX_AUTH_STATUS
{
    OneXAuthNotStarted = 0,
    OneXAuthInProgress = 1,
    OneXAuthNoAuthenticatorFound = 2,
    OneXAuthSuccess = 3,
    OneXAuthFailure = 4,
    OneXAuthInvalid = 5,
}

enum ONEX_REASON_CODE
{
    ONEX_REASON_CODE_SUCCESS = 0,
    ONEX_REASON_START = 327680,
    ONEX_UNABLE_TO_IDENTIFY_USER = 327681,
    ONEX_IDENTITY_NOT_FOUND = 327682,
    ONEX_UI_DISABLED = 327683,
    ONEX_UI_FAILURE = 327684,
    ONEX_EAP_FAILURE_RECEIVED = 327685,
    ONEX_AUTHENTICATOR_NO_LONGER_PRESENT = 327686,
    ONEX_NO_RESPONSE_TO_IDENTITY = 327687,
    ONEX_PROFILE_VERSION_NOT_SUPPORTED = 327688,
    ONEX_PROFILE_INVALID_LENGTH = 327689,
    ONEX_PROFILE_DISALLOWED_EAP_TYPE = 327690,
    ONEX_PROFILE_INVALID_EAP_TYPE_OR_FLAG = 327691,
    ONEX_PROFILE_INVALID_ONEX_FLAGS = 327692,
    ONEX_PROFILE_INVALID_TIMER_VALUE = 327693,
    ONEX_PROFILE_INVALID_SUPPLICANT_MODE = 327694,
    ONEX_PROFILE_INVALID_AUTH_MODE = 327695,
    ONEX_PROFILE_INVALID_EAP_CONNECTION_PROPERTIES = 327696,
    ONEX_UI_CANCELLED = 327697,
    ONEX_PROFILE_INVALID_EXPLICIT_CREDENTIALS = 327698,
    ONEX_PROFILE_EXPIRED_EXPLICIT_CREDENTIALS = 327699,
    ONEX_UI_NOT_PERMITTED = 327700,
}

enum ONEX_NOTIFICATION_TYPE
{
    OneXPublicNotificationBase = 0,
    OneXNotificationTypeResultUpdate = 1,
    OneXNotificationTypeAuthRestarted = 2,
    OneXNotificationTypeEventInvalid = 3,
    OneXNumNotifications = 3,
}

enum ONEX_AUTH_RESTART_REASON
{
    OneXRestartReasonPeerInitiated = 0,
    OneXRestartReasonMsmInitiated = 1,
    OneXRestartReasonOneXHeldStateTimeout = 2,
    OneXRestartReasonOneXAuthTimeout = 3,
    OneXRestartReasonOneXConfigurationChanged = 4,
    OneXRestartReasonOneXUserChanged = 5,
    OneXRestartReasonQuarantineStateChanged = 6,
    OneXRestartReasonAltCredsTrial = 7,
    OneXRestartReasonInvalid = 8,
}

struct ONEX_VARIABLE_BLOB
{
    uint dwSize;
    uint dwOffset;
}

struct ONEX_AUTH_PARAMS
{
    BOOL fUpdatePending;
    ONEX_VARIABLE_BLOB oneXConnProfile;
    ONEX_AUTH_IDENTITY authIdentity;
    uint dwQuarantineState;
    uint _bitfield;
    uint dwSessionId;
    HANDLE hUserToken;
    ONEX_VARIABLE_BLOB OneXUserProfile;
    ONEX_VARIABLE_BLOB Identity;
    ONEX_VARIABLE_BLOB UserName;
    ONEX_VARIABLE_BLOB Domain;
}

struct ONEX_EAP_ERROR
{
    uint dwWinError;
    EAP_METHOD_TYPE type;
    uint dwReasonCode;
    Guid rootCauseGuid;
    Guid repairGuid;
    Guid helpLinkGuid;
    uint _bitfield;
    ONEX_VARIABLE_BLOB RootCauseString;
    ONEX_VARIABLE_BLOB RepairString;
}

struct ONEX_STATUS
{
    ONEX_AUTH_STATUS authStatus;
    uint dwReason;
    uint dwError;
}

enum ONEX_EAP_METHOD_BACKEND_SUPPORT
{
    OneXEapMethodBackendSupportUnknown = 0,
    OneXEapMethodBackendSupported = 1,
    OneXEapMethodBackendUnsupported = 2,
}

struct ONEX_RESULT_UPDATE_DATA
{
    ONEX_STATUS oneXStatus;
    ONEX_EAP_METHOD_BACKEND_SUPPORT BackendSupport;
    BOOL fBackendEngaged;
    uint _bitfield;
    ONEX_VARIABLE_BLOB authParams;
    ONEX_VARIABLE_BLOB eapError;
}

struct ONEX_USER_INFO
{
    ONEX_AUTH_IDENTITY authIdentity;
    uint _bitfield;
    ONEX_VARIABLE_BLOB UserName;
    ONEX_VARIABLE_BLOB DomainName;
}

const GUID CLSID_Dot11AdHocManager = {0xDD06A84F, 0x83BD, 0x4D01, [0x8A, 0xB9, 0x23, 0x89, 0xFE, 0xA0, 0x86, 0x9E]};
@GUID(0xDD06A84F, 0x83BD, 0x4D01, [0x8A, 0xB9, 0x23, 0x89, 0xFE, 0xA0, 0x86, 0x9E]);
struct Dot11AdHocManager;

enum DOT11_ADHOC_CIPHER_ALGORITHM
{
    DOT11_ADHOC_CIPHER_ALGO_INVALID = -1,
    DOT11_ADHOC_CIPHER_ALGO_NONE = 0,
    DOT11_ADHOC_CIPHER_ALGO_CCMP = 4,
    DOT11_ADHOC_CIPHER_ALGO_WEP = 257,
}

enum DOT11_ADHOC_AUTH_ALGORITHM
{
    DOT11_ADHOC_AUTH_ALGO_INVALID = -1,
    DOT11_ADHOC_AUTH_ALGO_80211_OPEN = 1,
    DOT11_ADHOC_AUTH_ALGO_RSNA_PSK = 7,
}

enum DOT11_ADHOC_NETWORK_CONNECTION_STATUS
{
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_INVALID = 0,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_DISCONNECTED = 11,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_CONNECTING = 12,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_CONNECTED = 13,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_FORMED = 14,
}

enum DOT11_ADHOC_CONNECT_FAIL_REASON
{
    DOT11_ADHOC_CONNECT_FAIL_DOMAIN_MISMATCH = 0,
    DOT11_ADHOC_CONNECT_FAIL_PASSPHRASE_MISMATCH = 1,
    DOT11_ADHOC_CONNECT_FAIL_OTHER = 2,
}

const GUID IID_IDot11AdHocManager = {0x8F10CC26, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]};
@GUID(0x8F10CC26, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]);
interface IDot11AdHocManager : IUnknown
{
    HRESULT CreateNetwork(const(wchar)* Name, const(wchar)* Password, int GeographicalId, IDot11AdHocInterface pInterface, IDot11AdHocSecuritySettings pSecurity, Guid* pContextGuid, IDot11AdHocNetwork* pIAdHoc);
    HRESULT CommitCreatedNetwork(IDot11AdHocNetwork pIAdHoc, ubyte fSaveProfile, ubyte fMakeSavedProfileUserSpecific);
    HRESULT GetIEnumDot11AdHocNetworks(Guid* pContextGuid, IEnumDot11AdHocNetworks* ppEnum);
    HRESULT GetIEnumDot11AdHocInterfaces(IEnumDot11AdHocInterfaces* ppEnum);
    HRESULT GetNetwork(Guid* NetworkSignature, IDot11AdHocNetwork* pNetwork);
}

const GUID IID_IDot11AdHocManagerNotificationSink = {0x8F10CC27, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]};
@GUID(0x8F10CC27, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]);
interface IDot11AdHocManagerNotificationSink : IUnknown
{
    HRESULT OnNetworkAdd(IDot11AdHocNetwork pIAdHocNetwork);
    HRESULT OnNetworkRemove(Guid* Signature);
    HRESULT OnInterfaceAdd(IDot11AdHocInterface pIAdHocInterface);
    HRESULT OnInterfaceRemove(Guid* Signature);
}

const GUID IID_IEnumDot11AdHocNetworks = {0x8F10CC28, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]};
@GUID(0x8F10CC28, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]);
interface IEnumDot11AdHocNetworks : IUnknown
{
    HRESULT Next(uint cElt, IDot11AdHocNetwork* rgElt, uint* pcEltFetched);
    HRESULT Skip(uint cElt);
    HRESULT Reset();
    HRESULT Clone(IEnumDot11AdHocNetworks* ppEnum);
}

const GUID IID_IDot11AdHocNetwork = {0x8F10CC29, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]};
@GUID(0x8F10CC29, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]);
interface IDot11AdHocNetwork : IUnknown
{
    HRESULT GetStatus(DOT11_ADHOC_NETWORK_CONNECTION_STATUS* eStatus);
    HRESULT GetSSID(ushort** ppszwSSID);
    HRESULT HasProfile(ubyte* pf11d);
    HRESULT GetProfileName(ushort** ppszwProfileName);
    HRESULT DeleteProfile();
    HRESULT GetSignalQuality(uint* puStrengthValue, uint* puStrengthMax);
    HRESULT GetSecuritySetting(IDot11AdHocSecuritySettings* pAdHocSecuritySetting);
    HRESULT GetContextGuid(Guid* pContextGuid);
    HRESULT GetSignature(Guid* pSignature);
    HRESULT GetInterface(IDot11AdHocInterface* pAdHocInterface);
    HRESULT Connect(const(wchar)* Passphrase, int GeographicalId, ubyte fSaveProfile, ubyte fMakeSavedProfileUserSpecific);
    HRESULT Disconnect();
}

const GUID IID_IDot11AdHocNetworkNotificationSink = {0x8F10CC2A, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]};
@GUID(0x8F10CC2A, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]);
interface IDot11AdHocNetworkNotificationSink : IUnknown
{
    HRESULT OnStatusChange(DOT11_ADHOC_NETWORK_CONNECTION_STATUS eStatus);
    HRESULT OnConnectFail(DOT11_ADHOC_CONNECT_FAIL_REASON eFailReason);
}

const GUID IID_IDot11AdHocInterface = {0x8F10CC2B, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]};
@GUID(0x8F10CC2B, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]);
interface IDot11AdHocInterface : IUnknown
{
    HRESULT GetDeviceSignature(Guid* pSignature);
    HRESULT GetFriendlyName(ushort** ppszName);
    HRESULT IsDot11d(ubyte* pf11d);
    HRESULT IsAdHocCapable(ubyte* pfAdHocCapable);
    HRESULT IsRadioOn(ubyte* pfIsRadioOn);
    HRESULT GetActiveNetwork(IDot11AdHocNetwork* ppNetwork);
    HRESULT GetIEnumSecuritySettings(IEnumDot11AdHocSecuritySettings* ppEnum);
    HRESULT GetIEnumDot11AdHocNetworks(Guid* pFilterGuid, IEnumDot11AdHocNetworks* ppEnum);
    HRESULT GetStatus(DOT11_ADHOC_NETWORK_CONNECTION_STATUS* pState);
}

const GUID IID_IEnumDot11AdHocInterfaces = {0x8F10CC2C, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]};
@GUID(0x8F10CC2C, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]);
interface IEnumDot11AdHocInterfaces : IUnknown
{
    HRESULT Next(uint cElt, IDot11AdHocInterface* rgElt, uint* pcEltFetched);
    HRESULT Skip(uint cElt);
    HRESULT Reset();
    HRESULT Clone(IEnumDot11AdHocInterfaces* ppEnum);
}

const GUID IID_IEnumDot11AdHocSecuritySettings = {0x8F10CC2D, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]};
@GUID(0x8F10CC2D, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]);
interface IEnumDot11AdHocSecuritySettings : IUnknown
{
    HRESULT Next(uint cElt, IDot11AdHocSecuritySettings* rgElt, uint* pcEltFetched);
    HRESULT Skip(uint cElt);
    HRESULT Reset();
    HRESULT Clone(IEnumDot11AdHocSecuritySettings* ppEnum);
}

const GUID IID_IDot11AdHocSecuritySettings = {0x8F10CC2E, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]};
@GUID(0x8F10CC2E, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]);
interface IDot11AdHocSecuritySettings : IUnknown
{
    HRESULT GetDot11AuthAlgorithm(DOT11_ADHOC_AUTH_ALGORITHM* pAuth);
    HRESULT GetDot11CipherAlgorithm(DOT11_ADHOC_CIPHER_ALGORITHM* pCipher);
}

const GUID IID_IDot11AdHocInterfaceNotificationSink = {0x8F10CC2F, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]};
@GUID(0x8F10CC2F, 0xCF0D, 0x42A0, [0xAC, 0xBE, 0xE2, 0xDE, 0x70, 0x07, 0x38, 0x4D]);
interface IDot11AdHocInterfaceNotificationSink : IUnknown
{
    HRESULT OnConnectionStatusChange(DOT11_ADHOC_NETWORK_CONNECTION_STATUS eStatus);
}

@DllImport("wlanapi.dll")
uint WlanOpenHandle(uint dwClientVersion, void* pReserved, uint* pdwNegotiatedVersion, int* phClientHandle);

@DllImport("wlanapi.dll")
uint WlanCloseHandle(HANDLE hClientHandle, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanEnumInterfaces(HANDLE hClientHandle, void* pReserved, WLAN_INTERFACE_INFO_LIST** ppInterfaceList);

@DllImport("wlanapi.dll")
uint WlanSetAutoConfigParameter(HANDLE hClientHandle, WLAN_AUTOCONF_OPCODE OpCode, uint dwDataSize, char* pData, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanQueryAutoConfigParameter(HANDLE hClientHandle, WLAN_AUTOCONF_OPCODE OpCode, void* pReserved, uint* pdwDataSize, void** ppData, WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType);

@DllImport("wlanapi.dll")
uint WlanGetInterfaceCapability(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, void* pReserved, WLAN_INTERFACE_CAPABILITY** ppCapability);

@DllImport("wlanapi.dll")
uint WlanSetInterface(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, WLAN_INTF_OPCODE OpCode, uint dwDataSize, char* pData, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanQueryInterface(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, WLAN_INTF_OPCODE OpCode, void* pReserved, uint* pdwDataSize, void** ppData, WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType);

@DllImport("wlanapi.dll")
uint WlanIhvControl(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, WLAN_IHV_CONTROL_TYPE Type, uint dwInBufferSize, char* pInBuffer, uint dwOutBufferSize, char* pOutBuffer, uint* pdwBytesReturned);

@DllImport("wlanapi.dll")
uint WlanScan(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(DOT11_SSID)* pDot11Ssid, const(WLAN_RAW_DATA)* pIeData, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanGetAvailableNetworkList(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, uint dwFlags, void* pReserved, WLAN_AVAILABLE_NETWORK_LIST** ppAvailableNetworkList);

@DllImport("wlanapi.dll")
uint WlanGetAvailableNetworkList2(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, uint dwFlags, void* pReserved, WLAN_AVAILABLE_NETWORK_LIST_V2** ppAvailableNetworkList);

@DllImport("wlanapi.dll")
uint WlanGetNetworkBssList(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(DOT11_SSID)* pDot11Ssid, DOT11_BSS_TYPE dot11BssType, BOOL bSecurityEnabled, void* pReserved, WLAN_BSS_LIST** ppWlanBssList);

@DllImport("wlanapi.dll")
uint WlanConnect(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(WLAN_CONNECTION_PARAMETERS)* pConnectionParameters, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanConnect2(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(WLAN_CONNECTION_PARAMETERS_V2)* pConnectionParameters, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanDisconnect(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanRegisterNotification(HANDLE hClientHandle, uint dwNotifSource, BOOL bIgnoreDuplicate, WLAN_NOTIFICATION_CALLBACK funcCallback, void* pCallbackContext, void* pReserved, uint* pdwPrevNotifSource);

@DllImport("wlanapi.dll")
uint WlanGetProfile(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(wchar)* strProfileName, void* pReserved, ushort** pstrProfileXml, uint* pdwFlags, uint* pdwGrantedAccess);

@DllImport("wlanapi.dll")
uint WlanSetProfileEapUserData(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(wchar)* strProfileName, EAP_METHOD_TYPE eapType, uint dwFlags, uint dwEapUserDataSize, char* pbEapUserData, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanSetProfileEapXmlUserData(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(wchar)* strProfileName, uint dwFlags, const(wchar)* strEapXmlUserData, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanSetProfile(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, uint dwFlags, const(wchar)* strProfileXml, const(wchar)* strAllUserProfileSecurity, BOOL bOverwrite, void* pReserved, uint* pdwReasonCode);

@DllImport("wlanapi.dll")
uint WlanDeleteProfile(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(wchar)* strProfileName, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanRenameProfile(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(wchar)* strOldProfileName, const(wchar)* strNewProfileName, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanGetProfileList(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, void* pReserved, WLAN_PROFILE_INFO_LIST** ppProfileList);

@DllImport("wlanapi.dll")
uint WlanSetProfileList(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, uint dwItems, char* strProfileNames, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanSetProfilePosition(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(wchar)* strProfileName, uint dwPosition, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanSetProfileCustomUserData(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(wchar)* strProfileName, uint dwDataSize, char* pData, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanGetProfileCustomUserData(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(wchar)* strProfileName, void* pReserved, uint* pdwDataSize, ubyte** ppData);

@DllImport("wlanapi.dll")
uint WlanSetFilterList(HANDLE hClientHandle, WLAN_FILTER_LIST_TYPE wlanFilterListType, const(DOT11_NETWORK_LIST)* pNetworkList, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanGetFilterList(HANDLE hClientHandle, WLAN_FILTER_LIST_TYPE wlanFilterListType, void* pReserved, DOT11_NETWORK_LIST** ppNetworkList);

@DllImport("wlanapi.dll")
uint WlanSetPsdIEDataList(HANDLE hClientHandle, const(wchar)* strFormat, const(WLAN_RAW_DATA_LIST)* pPsdIEDataList, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanSaveTemporaryProfile(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, const(wchar)* strProfileName, const(wchar)* strAllUserProfileSecurity, uint dwFlags, BOOL bOverWrite, void* pReserved);

@DllImport("wlanapi.dll")
uint WlanDeviceServiceCommand(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, Guid* pDeviceServiceGuid, uint dwOpCode, uint dwInBufferSize, char* pInBuffer, uint dwOutBufferSize, char* pOutBuffer, uint* pdwBytesReturned);

@DllImport("wlanapi.dll")
uint WlanGetSupportedDeviceServices(HANDLE hClientHandle, const(Guid)* pInterfaceGuid, WLAN_DEVICE_SERVICE_GUID_LIST** ppDevSvcGuidList);

@DllImport("wlanapi.dll")
uint WlanRegisterDeviceServiceNotification(HANDLE hClientHandle, const(WLAN_DEVICE_SERVICE_GUID_LIST)* pDevSvcGuidList);

@DllImport("wlanapi.dll")
uint WlanExtractPsdIEDataList(HANDLE hClientHandle, uint dwIeDataSize, char* pRawIeData, const(wchar)* strFormat, void* pReserved, WLAN_RAW_DATA_LIST** ppPsdIEDataList);

@DllImport("wlanapi.dll")
uint WlanReasonCodeToString(uint dwReasonCode, uint dwBufferSize, const(wchar)* pStringBuffer, void* pReserved);

@DllImport("wlanapi.dll")
void* WlanAllocateMemory(uint dwMemorySize);

@DllImport("wlanapi.dll")
void WlanFreeMemory(void* pMemory);

@DllImport("wlanapi.dll")
uint WlanSetSecuritySettings(HANDLE hClientHandle, WLAN_SECURABLE_OBJECT SecurableObject, const(wchar)* strModifiedSDDL);

@DllImport("wlanapi.dll")
uint WlanGetSecuritySettings(HANDLE hClientHandle, WLAN_SECURABLE_OBJECT SecurableObject, WLAN_OPCODE_VALUE_TYPE* pValueType, ushort** pstrCurrentSDDL, uint* pdwGrantedAccess);

@DllImport("wlanapi.dll")
uint WlanUIEditProfile(uint dwClientVersion, const(wchar)* wstrProfileName, Guid* pInterfaceGuid, HWND hWnd, WL_DISPLAY_PAGES wlStartPage, void* pReserved, uint* pWlanReasonCode);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkStartUsing(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkStopUsing(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkForceStart(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkForceStop(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkQueryProperty(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_OPCODE OpCode, uint* pdwDataSize, void** ppvData, WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkSetProperty(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_OPCODE OpCode, uint dwDataSize, char* pvData, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkInitSettings(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkRefreshSecuritySettings(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkQueryStatus(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_STATUS** ppWlanHostedNetworkStatus, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkSetSecondaryKey(HANDLE hClientHandle, uint dwKeyLength, char* pucKeyData, BOOL bIsPassPhrase, BOOL bPersistent, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanHostedNetworkQuerySecondaryKey(HANDLE hClientHandle, uint* pdwKeyLength, ubyte** ppucKeyData, int* pbIsPassPhrase, int* pbPersistent, WLAN_HOSTED_NETWORK_REASON* pFailReason, void* pvReserved);

@DllImport("wlanapi.dll")
uint WlanRegisterVirtualStationNotification(HANDLE hClientHandle, BOOL bRegister, void* pReserved);

@DllImport("wlanapi.dll")
uint WFDOpenHandle(uint dwClientVersion, uint* pdwNegotiatedVersion, int* phClientHandle);

@DllImport("wlanapi.dll")
uint WFDCloseHandle(HANDLE hClientHandle);

@DllImport("wlanapi.dll")
uint WFDStartOpenSession(HANDLE hClientHandle, ubyte** pDeviceAddress, void* pvContext, WFD_OPEN_SESSION_COMPLETE_CALLBACK pfnCallback, int* phSessionHandle);

@DllImport("wlanapi.dll")
uint WFDCancelOpenSession(HANDLE hSessionHandle);

@DllImport("wlanapi.dll")
uint WFDOpenLegacySession(HANDLE hClientHandle, ubyte** pLegacyMacAddress, HANDLE* phSessionHandle, Guid* pGuidSessionInterface);

@DllImport("wlanapi.dll")
uint WFDCloseSession(HANDLE hSessionHandle);

@DllImport("wlanapi.dll")
uint WFDUpdateDeviceVisibility(ubyte** pDeviceAddress);

