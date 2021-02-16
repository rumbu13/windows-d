module windows.remotedesktopservices;

public import windows.core;
public import windows.automation : BSTR, IDispatch, IPropertyBag, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : RECT;
public import windows.multimedia : WAVEFORMATEX;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    BUFFER_INVALID = 0x00000000,
    BUFFER_VALID   = 0x00000001,
    BUFFER_SILENT  = 0x00000002,
}
alias APO_BUFFER_FLAGS = int;

enum : int
{
    POSITION_INVALID       = 0x00000000,
    POSITION_DISCONTINUOUS = 0x00000001,
    POSITION_CONTINUOUS    = 0x00000002,
    POSITION_QPC_ERROR     = 0x00000004,
}
alias AE_POSITION_FLAGS = int;

enum AAAuthSchemes : int
{
    AA_AUTH_MIN                 = 0x00000000,
    AA_AUTH_BASIC               = 0x00000001,
    AA_AUTH_NTLM                = 0x00000002,
    AA_AUTH_SC                  = 0x00000003,
    AA_AUTH_LOGGEDONCREDENTIALS = 0x00000004,
    AA_AUTH_NEGOTIATE           = 0x00000005,
    AA_AUTH_ANY                 = 0x00000006,
    AA_AUTH_COOKIE              = 0x00000007,
    AA_AUTH_DIGEST              = 0x00000008,
    AA_AUTH_ORGID               = 0x00000009,
    AA_AUTH_CONID               = 0x0000000a,
    AA_AUTH_SSPI_NTLM           = 0x0000000b,
    AA_AUTH_MAX                 = 0x0000000c,
}

enum AAAccountingDataType : int
{
    AA_MAIN_SESSION_CREATION = 0x00000000,
    AA_SUB_SESSION_CREATION  = 0x00000001,
    AA_SUB_SESSION_CLOSED    = 0x00000002,
    AA_MAIN_SESSION_CLOSED   = 0x00000003,
}

enum : int
{
    SESSION_TIMEOUT_ACTION_DISCONNECT    = 0x00000000,
    SESSION_TIMEOUT_ACTION_SILENT_REAUTH = 0x00000001,
}
alias __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0004 = int;

enum PolicyAttributeType : int
{
    EnableAllRedirections        = 0x00000000,
    DisableAllRedirections       = 0x00000001,
    DriveRedirectionDisabled     = 0x00000002,
    PrinterRedirectionDisabled   = 0x00000003,
    PortRedirectionDisabled      = 0x00000004,
    ClipboardRedirectionDisabled = 0x00000005,
    PnpRedirectionDisabled       = 0x00000006,
    AllowOnlySDRServers          = 0x00000007,
}

enum : int
{
    AA_UNTRUSTED                   = 0x00000000,
    AA_TRUSTEDUSER_UNTRUSTEDCLIENT = 0x00000001,
    AA_TRUSTEDUSER_TRUSTEDCLIENT   = 0x00000002,
}
alias __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0006 = int;

enum : int
{
    WTSActive       = 0x00000000,
    WTSConnected    = 0x00000001,
    WTSConnectQuery = 0x00000002,
    WTSShadow       = 0x00000003,
    WTSDisconnected = 0x00000004,
    WTSIdle         = 0x00000005,
    WTSListen       = 0x00000006,
    WTSReset        = 0x00000007,
    WTSDown         = 0x00000008,
    WTSInit         = 0x00000009,
}
alias WTS_CONNECTSTATE_CLASS = int;

enum : int
{
    WTSInitialProgram     = 0x00000000,
    WTSApplicationName    = 0x00000001,
    WTSWorkingDirectory   = 0x00000002,
    WTSOEMId              = 0x00000003,
    WTSSessionId          = 0x00000004,
    WTSUserName           = 0x00000005,
    WTSWinStationName     = 0x00000006,
    WTSDomainName         = 0x00000007,
    WTSConnectState       = 0x00000008,
    WTSClientBuildNumber  = 0x00000009,
    WTSClientName         = 0x0000000a,
    WTSClientDirectory    = 0x0000000b,
    WTSClientProductId    = 0x0000000c,
    WTSClientHardwareId   = 0x0000000d,
    WTSClientAddress      = 0x0000000e,
    WTSClientDisplay      = 0x0000000f,
    WTSClientProtocolType = 0x00000010,
    WTSIdleTime           = 0x00000011,
    WTSLogonTime          = 0x00000012,
    WTSIncomingBytes      = 0x00000013,
    WTSOutgoingBytes      = 0x00000014,
    WTSIncomingFrames     = 0x00000015,
    WTSOutgoingFrames     = 0x00000016,
    WTSClientInfo         = 0x00000017,
    WTSSessionInfo        = 0x00000018,
    WTSSessionInfoEx      = 0x00000019,
    WTSConfigInfo         = 0x0000001a,
    WTSValidationInfo     = 0x0000001b,
    WTSSessionAddressV4   = 0x0000001c,
    WTSIsRemoteSession    = 0x0000001d,
}
alias WTS_INFO_CLASS = int;

enum : int
{
    WTSUserConfigInitialProgram                = 0x00000000,
    WTSUserConfigWorkingDirectory              = 0x00000001,
    WTSUserConfigfInheritInitialProgram        = 0x00000002,
    WTSUserConfigfAllowLogonTerminalServer     = 0x00000003,
    WTSUserConfigTimeoutSettingsConnections    = 0x00000004,
    WTSUserConfigTimeoutSettingsDisconnections = 0x00000005,
    WTSUserConfigTimeoutSettingsIdle           = 0x00000006,
    WTSUserConfigfDeviceClientDrives           = 0x00000007,
    WTSUserConfigfDeviceClientPrinters         = 0x00000008,
    WTSUserConfigfDeviceClientDefaultPrinter   = 0x00000009,
    WTSUserConfigBrokenTimeoutSettings         = 0x0000000a,
    WTSUserConfigReconnectSettings             = 0x0000000b,
    WTSUserConfigModemCallbackSettings         = 0x0000000c,
    WTSUserConfigModemCallbackPhoneNumber      = 0x0000000d,
    WTSUserConfigShadowingSettings             = 0x0000000e,
    WTSUserConfigTerminalServerProfilePath     = 0x0000000f,
    WTSUserConfigTerminalServerHomeDir         = 0x00000010,
    WTSUserConfigTerminalServerHomeDirDrive    = 0x00000011,
    WTSUserConfigfTerminalServerRemoteHomeDir  = 0x00000012,
    WTSUserConfigUser                          = 0x00000013,
}
alias WTS_CONFIG_CLASS = int;

enum : int
{
    WTSUserConfigSourceSAM = 0x00000000,
}
alias WTS_CONFIG_SOURCE = int;

enum : int
{
    WTSVirtualClientData = 0x00000000,
    WTSVirtualFileHandle = 0x00000001,
}
alias WTS_VIRTUAL_CLASS = int;

enum : int
{
    WTSTypeProcessInfoLevel0 = 0x00000000,
    WTSTypeProcessInfoLevel1 = 0x00000001,
    WTSTypeSessionInfoLevel1 = 0x00000002,
}
alias WTS_TYPE_CLASS = int;

enum : int
{
    WTSSBX_MACHINE_DRAIN_UNSPEC = 0x00000000,
    WTSSBX_MACHINE_DRAIN_OFF    = 0x00000001,
    WTSSBX_MACHINE_DRAIN_ON     = 0x00000002,
}
alias WTSSBX_MACHINE_DRAIN = int;

enum : int
{
    WTSSBX_MACHINE_SESSION_MODE_UNSPEC   = 0x00000000,
    WTSSBX_MACHINE_SESSION_MODE_SINGLE   = 0x00000001,
    WTSSBX_MACHINE_SESSION_MODE_MULTIPLE = 0x00000002,
}
alias WTSSBX_MACHINE_SESSION_MODE = int;

enum : int
{
    WTSSBX_ADDRESS_FAMILY_AF_UNSPEC  = 0x00000000,
    WTSSBX_ADDRESS_FAMILY_AF_INET    = 0x00000001,
    WTSSBX_ADDRESS_FAMILY_AF_INET6   = 0x00000002,
    WTSSBX_ADDRESS_FAMILY_AF_IPX     = 0x00000003,
    WTSSBX_ADDRESS_FAMILY_AF_NETBIOS = 0x00000004,
}
alias WTSSBX_ADDRESS_FAMILY = int;

enum : int
{
    WTSSBX_MACHINE_STATE_UNSPEC        = 0x00000000,
    WTSSBX_MACHINE_STATE_READY         = 0x00000001,
    WTSSBX_MACHINE_STATE_SYNCHRONIZING = 0x00000002,
}
alias WTSSBX_MACHINE_STATE = int;

enum : int
{
    WTSSBX_SESSION_STATE_UNSPEC       = 0x00000000,
    WTSSBX_SESSION_STATE_ACTIVE       = 0x00000001,
    WTSSBX_SESSION_STATE_DISCONNECTED = 0x00000002,
}
alias WTSSBX_SESSION_STATE = int;

enum : int
{
    WTSSBX_NOTIFICATION_REMOVED = 0x00000001,
    WTSSBX_NOTIFICATION_CHANGED = 0x00000002,
    WTSSBX_NOTIFICATION_ADDED   = 0x00000004,
    WTSSBX_NOTIFICATION_RESYNC  = 0x00000008,
}
alias WTSSBX_NOTIFICATION_TYPE = int;

enum : int
{
    TSSD_ADDR_UNDEFINED = 0x00000000,
    TSSD_ADDR_IPv4      = 0x00000004,
    TSSD_ADDR_IPv6      = 0x00000006,
}
alias TSSD_AddrV46Type = int;

enum : int
{
    TSSB_NOTIFY_INVALID                   = 0x00000000,
    TSSB_NOTIFY_TARGET_CHANGE             = 0x00000001,
    TSSB_NOTIFY_SESSION_CHANGE            = 0x00000002,
    TSSB_NOTIFY_CONNECTION_REQUEST_CHANGE = 0x00000004,
}
alias TSSB_NOTIFICATION_TYPE = int;

enum : int
{
    TARGET_UNKNOWN      = 0x00000001,
    TARGET_INITIALIZING = 0x00000002,
    TARGET_RUNNING      = 0x00000003,
    TARGET_DOWN         = 0x00000004,
    TARGET_HIBERNATED   = 0x00000005,
    TARGET_CHECKED_OUT  = 0x00000006,
    TARGET_STOPPED      = 0x00000007,
    TARGET_INVALID      = 0x00000008,
    TARGET_STARTING     = 0x00000009,
    TARGET_STOPPING     = 0x0000000a,
    TARGET_MAXSTATE     = 0x0000000b,
}
alias TARGET_STATE = int;

enum : int
{
    TARGET_CHANGE_UNSPEC           = 0x00000001,
    TARGET_EXTERNALIP_CHANGED      = 0x00000002,
    TARGET_INTERNALIP_CHANGED      = 0x00000004,
    TARGET_JOINED                  = 0x00000008,
    TARGET_REMOVED                 = 0x00000010,
    TARGET_STATE_CHANGED           = 0x00000020,
    TARGET_IDLE                    = 0x00000040,
    TARGET_PENDING                 = 0x00000080,
    TARGET_INUSE                   = 0x00000100,
    TARGET_PATCH_STATE_CHANGED     = 0x00000200,
    TARGET_FARM_MEMBERSHIP_CHANGED = 0x00000400,
}
alias TARGET_CHANGE_TYPE = int;

enum : int
{
    UNKNOWN = 0x00000000,
    FARM    = 0x00000001,
    NONFARM = 0x00000002,
}
alias TARGET_TYPE = int;

enum : int
{
    TARGET_PATCH_UNKNOWN     = 0x00000000,
    TARGET_PATCH_NOT_STARTED = 0x00000001,
    TARGET_PATCH_IN_PROGRESS = 0x00000002,
    TARGET_PATCH_COMPLETED   = 0x00000003,
    TARGET_PATCH_FAILED      = 0x00000004,
}
alias TARGET_PATCH_STATE = int;

enum : int
{
    CLIENT_MESSAGE_CONNECTION_INVALID = 0x00000000,
    CLIENT_MESSAGE_CONNECTION_STATUS  = 0x00000001,
    CLIENT_MESSAGE_CONNECTION_ERROR   = 0x00000002,
}
alias CLIENT_MESSAGE_TYPE = int;

enum : int
{
    CONNECTION_REQUEST_INVALID            = 0x00000000,
    CONNECTION_REQUEST_PENDING            = 0x00000001,
    CONNECTION_REQUEST_FAILED             = 0x00000002,
    CONNECTION_REQUEST_TIMEDOUT           = 0x00000003,
    CONNECTION_REQUEST_SUCCEEDED          = 0x00000004,
    CONNECTION_REQUEST_CANCELLED          = 0x00000005,
    CONNECTION_REQUEST_LB_COMPLETED       = 0x00000006,
    CONNECTION_REQUEST_QUERY_PL_COMPLETED = 0x00000007,
    CONNECTION_REQUEST_ORCH_COMPLETED     = 0x00000008,
}
alias CONNECTION_CHANGE_NOTIFICATION = int;

enum : int
{
    RD_FARM_RDSH                 = 0x00000000,
    RD_FARM_TEMP_VM              = 0x00000001,
    RD_FARM_MANUAL_PERSONAL_VM   = 0x00000002,
    RD_FARM_AUTO_PERSONAL_VM     = 0x00000003,
    RD_FARM_MANUAL_PERSONAL_RDSH = 0x00000004,
    RD_FARM_AUTO_PERSONAL_RDSH   = 0x00000005,
    RD_FARM_TYPE_UNKNOWN         = 0xffffffff,
}
alias RD_FARM_TYPE = int;

enum : int
{
    UNKNOWN_PLUGIN        = 0x00000000,
    POLICY_PLUGIN         = 0x00000001,
    RESOURCE_PLUGIN       = 0x00000002,
    LOAD_BALANCING_PLUGIN = 0x00000004,
    PLACEMENT_PLUGIN      = 0x00000008,
    ORCHESTRATION_PLUGIN  = 0x00000010,
    PROVISIONING_PLUGIN   = 0x00000020,
    TASK_PLUGIN           = 0x00000040,
}
alias PLUGIN_TYPE = int;

enum : int
{
    STATE_INVALID      = 0xffffffff,
    STATE_ACTIVE       = 0x00000000,
    STATE_CONNECTED    = 0x00000001,
    STATE_CONNECTQUERY = 0x00000002,
    STATE_SHADOW       = 0x00000003,
    STATE_DISCONNECTED = 0x00000004,
    STATE_IDLE         = 0x00000005,
    STATE_LISTEN       = 0x00000006,
    STATE_RESET        = 0x00000007,
    STATE_DOWN         = 0x00000008,
    STATE_INIT         = 0x00000009,
    STATE_MAX          = 0x0000000a,
}
alias TSSESSION_STATE = int;

enum : int
{
    OWNER_UNKNOWN      = 0x00000000,
    OWNER_MS_TS_PLUGIN = 0x00000001,
    OWNER_MS_VM_PLUGIN = 0x00000002,
}
alias TARGET_OWNER = int;

enum : int
{
    VM_NOTIFY_STATUS_PENDING     = 0x00000000,
    VM_NOTIFY_STATUS_IN_PROGRESS = 0x00000001,
    VM_NOTIFY_STATUS_COMPLETE    = 0x00000002,
    VM_NOTIFY_STATUS_FAILED      = 0x00000003,
    VM_NOTIFY_STATUS_CANCELED    = 0x00000004,
}
alias VM_NOTIFY_STATUS = int;

enum : int
{
    VM_HOST_STATUS_INIT_PENDING     = 0x00000000,
    VM_HOST_STATUS_INIT_IN_PROGRESS = 0x00000001,
    VM_HOST_STATUS_INIT_COMPLETE    = 0x00000002,
    VM_HOST_STATUS_INIT_FAILED      = 0x00000003,
}
alias VM_HOST_NOTIFY_STATUS = int;

enum : int
{
    RDV_TASK_STATUS_UNKNOWN     = 0x00000000,
    RDV_TASK_STATUS_SEARCHING   = 0x00000001,
    RDV_TASK_STATUS_DOWNLOADING = 0x00000002,
    RDV_TASK_STATUS_APPLYING    = 0x00000003,
    RDV_TASK_STATUS_REBOOTING   = 0x00000004,
    RDV_TASK_STATUS_REBOOTED    = 0x00000005,
    RDV_TASK_STATUS_SUCCESS     = 0x00000006,
    RDV_TASK_STATUS_FAILED      = 0x00000007,
    RDV_TASK_STATUS_TIMEOUT     = 0x00000008,
}
alias RDV_TASK_STATUS = int;

enum : int
{
    TS_SB_SORT_BY_NONE = 0x00000000,
    TS_SB_SORT_BY_NAME = 0x00000001,
    TS_SB_SORT_BY_PROP = 0x00000002,
}
alias TS_SB_SORT_BY = int;

enum : int
{
    TSPUB_PLUGIN_PD_QUERY_OR_CREATE = 0x00000000,
    TSPUB_PLUGIN_PD_QUERY_EXISTING  = 0x00000001,
}
alias TSPUB_PLUGIN_PD_RESOLUTION_TYPE = int;

enum : int
{
    TSPUB_PLUGIN_PD_ASSIGNMENT_NEW      = 0x00000000,
    TSPUB_PLUGIN_PD_ASSIGNMENT_EXISTING = 0x00000001,
}
alias TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE = int;

enum WRdsGraphicsChannelType : int
{
    WRdsGraphicsChannelType_GuaranteedDelivery = 0x00000000,
    WRdsGraphicsChannelType_BestEffortDelivery = 0x00000001,
}

enum : int
{
    WTS_SERVICE_NONE  = 0x00000000,
    WTS_SERVICE_START = 0x00000001,
    WTS_SERVICE_STOP  = 0x00000002,
}
alias WTS_RCM_SERVICE_STATE = int;

enum : int
{
    WTS_DRAIN_STATE_NONE   = 0x00000000,
    WTS_DRAIN_IN_DRAIN     = 0x00000001,
    WTS_DRAIN_NOT_IN_DRAIN = 0x00000002,
}
alias WTS_RCM_DRAIN_STATE = int;

enum : int
{
    WTS_LOGON_ERR_INVALID                      = 0x00000000,
    WTS_LOGON_ERR_NOT_HANDLED                  = 0x00000001,
    WTS_LOGON_ERR_HANDLED_SHOW                 = 0x00000002,
    WTS_LOGON_ERR_HANDLED_DONT_SHOW            = 0x00000003,
    WTS_LOGON_ERR_HANDLED_DONT_SHOW_START_OVER = 0x00000004,
}
alias WTS_LOGON_ERROR_REDIRECTOR_RESPONSE = int;

enum : int
{
    WTS_CERT_TYPE_INVALID     = 0x00000000,
    WTS_CERT_TYPE_PROPRIETORY = 0x00000001,
    WTS_CERT_TYPE_X509        = 0x00000002,
}
alias WTS_CERT_TYPE = int;

enum : int
{
    WRDS_CONNECTION_SETTING_LEVEL_INVALID = 0x00000000,
    WRDS_CONNECTION_SETTING_LEVEL_1       = 0x00000001,
}
alias WRDS_CONNECTION_SETTING_LEVEL = int;

enum : int
{
    WRDS_LISTENER_SETTING_LEVEL_INVALID = 0x00000000,
    WRDS_LISTENER_SETTING_LEVEL_1       = 0x00000001,
}
alias WRDS_LISTENER_SETTING_LEVEL = int;

enum : int
{
    WRDS_SETTING_TYPE_INVALID = 0x00000000,
    WRDS_SETTING_TYPE_MACHINE = 0x00000001,
    WRDS_SETTING_TYPE_USER    = 0x00000002,
    WRDS_SETTING_TYPE_SAM     = 0x00000003,
}
alias WRDS_SETTING_TYPE = int;

enum : int
{
    WRDS_SETTING_STATUS_NOTAPPLICABLE = 0xffffffff,
    WRDS_SETTING_STATUS_DISABLED      = 0x00000000,
    WRDS_SETTING_STATUS_ENABLED       = 0x00000001,
    WRDS_SETTING_STATUS_NOTCONFIGURED = 0x00000002,
}
alias WRDS_SETTING_STATUS = int;

enum : int
{
    WRDS_SETTING_LEVEL_INVALID = 0x00000000,
    WRDS_SETTING_LEVEL_1       = 0x00000001,
}
alias WRDS_SETTING_LEVEL = int;

enum : int
{
    PasswordEncodingUTF8    = 0x00000000,
    PasswordEncodingUTF16LE = 0x00000001,
    PasswordEncodingUTF16BE = 0x00000002,
}
alias __MIDL_IRemoteDesktopClientSettings_0001 = int;

enum RemoteActionType : int
{
    RemoteActionCharms      = 0x00000000,
    RemoteActionAppbar      = 0x00000001,
    RemoteActionSnap        = 0x00000002,
    RemoteActionStartScreen = 0x00000003,
    RemoteActionAppSwitch   = 0x00000004,
}

enum SnapshotEncodingType : int
{
    SnapshotEncodingDataUri = 0x00000000,
}

enum SnapshotFormatType : int
{
    SnapshotFormatPng  = 0x00000000,
    SnapshotFormatJpeg = 0x00000001,
    SnapshotFormatBmp  = 0x00000002,
}

enum : int
{
    KeyCombinationHome   = 0x00000000,
    KeyCombinationLeft   = 0x00000001,
    KeyCombinationUp     = 0x00000002,
    KeyCombinationRight  = 0x00000003,
    KeyCombinationDown   = 0x00000004,
    KeyCombinationScroll = 0x00000005,
}
alias __MIDL_IRemoteDesktopClient_0001 = int;

// Callbacks

alias CHANNEL_INIT_EVENT_FN = void function(void* pInitHandle, uint event, void* pData, uint dataLength);
alias PCHANNEL_INIT_EVENT_FN = void function();
alias CHANNEL_OPEN_EVENT_FN = void function(uint openHandle, uint event, void* pData, uint dataLength, 
                                            uint totalLength, uint dataFlags);
alias PCHANNEL_OPEN_EVENT_FN = void function();
alias VIRTUALCHANNELINIT = uint function(void** ppInitHandle, CHANNEL_DEF* pChannel, int channelCount, 
                                         uint versionRequested, PCHANNEL_INIT_EVENT_FN pChannelInitEventProc);
alias PVIRTUALCHANNELINIT = uint function();
alias VIRTUALCHANNELOPEN = uint function(void* pInitHandle, uint* pOpenHandle, const(char)* pChannelName, 
                                         PCHANNEL_OPEN_EVENT_FN pChannelOpenEventProc);
alias PVIRTUALCHANNELOPEN = uint function();
alias VIRTUALCHANNELCLOSE = uint function(uint openHandle);
alias PVIRTUALCHANNELCLOSE = uint function();
alias VIRTUALCHANNELWRITE = uint function(uint openHandle, void* pData, uint dataLength, void* pUserData);
alias PVIRTUALCHANNELWRITE = uint function();
alias VIRTUALCHANNELENTRY = BOOL function(CHANNEL_ENTRY_POINTS* pEntryPoints);
alias PVIRTUALCHANNELENTRY = BOOL function();

// Structs


alias HwtsVirtualChannelHandle = ptrdiff_t;

struct APO_CONNECTION_PROPERTY
{
    size_t           pBuffer;
    uint             u32ValidFrameCount;
    APO_BUFFER_FLAGS u32BufferFlags;
    uint             u32Signature;
}

struct AE_CURRENT_POSITION
{
    ulong             u64DevicePosition;
    ulong             u64StreamPosition;
    ulong             u64PaddingFrames;
    long              hnsQPCPosition;
    float             f32FramesPerSecond;
    AE_POSITION_FLAGS Flag;
}

struct WTSSESSION_NOTIFICATION
{
    uint cbSize;
    uint dwSessionId;
}

struct AAAccountingData
{
    BSTR          userName;
    BSTR          clientName;
    AAAuthSchemes authType;
    BSTR          resourceName;
    int           portNumber;
    BSTR          protocolName;
    int           numberOfBytesReceived;
    int           numberOfBytesTransfered;
    BSTR          reasonForDisconnect;
    GUID          mainSessionId;
    int           subSessionId;
}

struct WTS_SERVER_INFOW
{
    const(wchar)* pServerName;
}

struct WTS_SERVER_INFOA
{
    const(char)* pServerName;
}

struct WTS_SESSION_INFOW
{
    uint          SessionId;
    const(wchar)* pWinStationName;
    WTS_CONNECTSTATE_CLASS State;
}

struct WTS_SESSION_INFOA
{
    uint         SessionId;
    const(char)* pWinStationName;
    WTS_CONNECTSTATE_CLASS State;
}

struct WTS_SESSION_INFO_1W
{
    uint          ExecEnvId;
    WTS_CONNECTSTATE_CLASS State;
    uint          SessionId;
    const(wchar)* pSessionName;
    const(wchar)* pHostName;
    const(wchar)* pUserName;
    const(wchar)* pDomainName;
    const(wchar)* pFarmName;
}

struct WTS_SESSION_INFO_1A
{
    uint         ExecEnvId;
    WTS_CONNECTSTATE_CLASS State;
    uint         SessionId;
    const(char)* pSessionName;
    const(char)* pHostName;
    const(char)* pUserName;
    const(char)* pDomainName;
    const(char)* pFarmName;
}

struct WTS_PROCESS_INFOW
{
    uint          SessionId;
    uint          ProcessId;
    const(wchar)* pProcessName;
    void*         pUserSid;
}

struct WTS_PROCESS_INFOA
{
    uint         SessionId;
    uint         ProcessId;
    const(char)* pProcessName;
    void*        pUserSid;
}

struct WTSCONFIGINFOW
{
    uint        version_;
    uint        fConnectClientDrivesAtLogon;
    uint        fConnectPrinterAtLogon;
    uint        fDisablePrinterRedirection;
    uint        fDisableDefaultMainClientPrinter;
    uint        ShadowSettings;
    ushort[21]  LogonUserName;
    ushort[18]  LogonDomain;
    ushort[261] WorkDirectory;
    ushort[261] InitialProgram;
    ushort[261] ApplicationName;
}

struct WTSCONFIGINFOA
{
    uint      version_;
    uint      fConnectClientDrivesAtLogon;
    uint      fConnectPrinterAtLogon;
    uint      fDisablePrinterRedirection;
    uint      fDisableDefaultMainClientPrinter;
    uint      ShadowSettings;
    byte[21]  LogonUserName;
    byte[18]  LogonDomain;
    byte[261] WorkDirectory;
    byte[261] InitialProgram;
    byte[261] ApplicationName;
}

struct WTSINFOW
{
    WTS_CONNECTSTATE_CLASS State;
    uint          SessionId;
    uint          IncomingBytes;
    uint          OutgoingBytes;
    uint          IncomingFrames;
    uint          OutgoingFrames;
    uint          IncomingCompressedBytes;
    uint          OutgoingCompressedBytes;
    ushort[32]    WinStationName;
    ushort[17]    Domain;
    ushort[21]    UserName;
    LARGE_INTEGER ConnectTime;
    LARGE_INTEGER DisconnectTime;
    LARGE_INTEGER LastInputTime;
    LARGE_INTEGER LogonTime;
    LARGE_INTEGER CurrentTime;
}

struct WTSINFOA
{
    WTS_CONNECTSTATE_CLASS State;
    uint          SessionId;
    uint          IncomingBytes;
    uint          OutgoingBytes;
    uint          IncomingFrames;
    uint          OutgoingFrames;
    uint          IncomingCompressedBytes;
    uint          OutgoingCompressedBy;
    byte[32]      WinStationName;
    byte[17]      Domain;
    byte[21]      UserName;
    LARGE_INTEGER ConnectTime;
    LARGE_INTEGER DisconnectTime;
    LARGE_INTEGER LastInputTime;
    LARGE_INTEGER LogonTime;
    LARGE_INTEGER CurrentTime;
}

struct WTSINFOEX_LEVEL1_W
{
    uint          SessionId;
    WTS_CONNECTSTATE_CLASS SessionState;
    int           SessionFlags;
    ushort[33]    WinStationName;
    ushort[21]    UserName;
    ushort[18]    DomainName;
    LARGE_INTEGER LogonTime;
    LARGE_INTEGER ConnectTime;
    LARGE_INTEGER DisconnectTime;
    LARGE_INTEGER LastInputTime;
    LARGE_INTEGER CurrentTime;
    uint          IncomingBytes;
    uint          OutgoingBytes;
    uint          IncomingFrames;
    uint          OutgoingFrames;
    uint          IncomingCompressedBytes;
    uint          OutgoingCompressedBytes;
}

struct WTSINFOEX_LEVEL1_A
{
    uint          SessionId;
    WTS_CONNECTSTATE_CLASS SessionState;
    int           SessionFlags;
    byte[33]      WinStationName;
    byte[21]      UserName;
    byte[18]      DomainName;
    LARGE_INTEGER LogonTime;
    LARGE_INTEGER ConnectTime;
    LARGE_INTEGER DisconnectTime;
    LARGE_INTEGER LastInputTime;
    LARGE_INTEGER CurrentTime;
    uint          IncomingBytes;
    uint          OutgoingBytes;
    uint          IncomingFrames;
    uint          OutgoingFrames;
    uint          IncomingCompressedBytes;
    uint          OutgoingCompressedBytes;
}

union WTSINFOEX_LEVEL_W
{
    WTSINFOEX_LEVEL1_W WTSInfoExLevel1;
}

union WTSINFOEX_LEVEL_A
{
    WTSINFOEX_LEVEL1_A WTSInfoExLevel1;
}

struct WTSINFOEXW
{
    uint              Level;
    WTSINFOEX_LEVEL_W Data;
}

struct WTSINFOEXA
{
    uint              Level;
    WTSINFOEX_LEVEL_A Data;
}

struct WTSCLIENTW
{
    ushort[21]  ClientName;
    ushort[18]  Domain;
    ushort[21]  UserName;
    ushort[261] WorkDirectory;
    ushort[261] InitialProgram;
    ubyte       EncryptionLevel;
    uint        ClientAddressFamily;
    ushort[31]  ClientAddress;
    ushort      HRes;
    ushort      VRes;
    ushort      ColorDepth;
    ushort[261] ClientDirectory;
    uint        ClientBuildNumber;
    uint        ClientHardwareId;
    ushort      ClientProductId;
    ushort      OutBufCountHost;
    ushort      OutBufCountClient;
    ushort      OutBufLength;
    ushort[261] DeviceId;
}

struct WTSCLIENTA
{
    byte[21]   ClientName;
    byte[18]   Domain;
    byte[21]   UserName;
    byte[261]  WorkDirectory;
    byte[261]  InitialProgram;
    ubyte      EncryptionLevel;
    uint       ClientAddressFamily;
    ushort[31] ClientAddress;
    ushort     HRes;
    ushort     VRes;
    ushort     ColorDepth;
    byte[261]  ClientDirectory;
    uint       ClientBuildNumber;
    uint       ClientHardwareId;
    ushort     ClientProductId;
    ushort     OutBufCountHost;
    ushort     OutBufCountClient;
    ushort     OutBufLength;
    byte[261]  DeviceId;
}

struct _WTS_PRODUCT_INFOA
{
    byte[256] CompanyName;
    byte[4]   ProductID;
}

struct _WTS_PRODUCT_INFOW
{
    ushort[256] CompanyName;
    ushort[4]   ProductID;
}

struct WTS_VALIDATION_INFORMATIONA
{
    _WTS_PRODUCT_INFOA ProductInfo;
    ubyte[16384]       License;
    uint               LicenseLength;
    ubyte[20]          HardwareID;
    uint               HardwareIDLength;
}

struct WTS_VALIDATION_INFORMATIONW
{
    _WTS_PRODUCT_INFOW ProductInfo;
    ubyte[16384]       License;
    uint               LicenseLength;
    ubyte[20]          HardwareID;
    uint               HardwareIDLength;
}

struct WTS_CLIENT_ADDRESS
{
    uint      AddressFamily;
    ubyte[20] Address;
}

struct WTS_CLIENT_DISPLAY
{
    uint HorizontalResolution;
    uint VerticalResolution;
    uint ColorDepth;
}

struct WTSUSERCONFIGA
{
    uint      Source;
    uint      InheritInitialProgram;
    uint      AllowLogonTerminalServer;
    uint      TimeoutSettingsConnections;
    uint      TimeoutSettingsDisconnections;
    uint      TimeoutSettingsIdle;
    uint      DeviceClientDrives;
    uint      DeviceClientPrinters;
    uint      ClientDefaultPrinter;
    uint      BrokenTimeoutSettings;
    uint      ReconnectSettings;
    uint      ShadowingSettings;
    uint      TerminalServerRemoteHomeDir;
    byte[261] InitialProgram;
    byte[261] WorkDirectory;
    byte[261] TerminalServerProfilePath;
    byte[261] TerminalServerHomeDir;
    byte[4]   TerminalServerHomeDirDrive;
}

struct WTSUSERCONFIGW
{
    uint        Source;
    uint        InheritInitialProgram;
    uint        AllowLogonTerminalServer;
    uint        TimeoutSettingsConnections;
    uint        TimeoutSettingsDisconnections;
    uint        TimeoutSettingsIdle;
    uint        DeviceClientDrives;
    uint        DeviceClientPrinters;
    uint        ClientDefaultPrinter;
    uint        BrokenTimeoutSettings;
    uint        ReconnectSettings;
    uint        ShadowingSettings;
    uint        TerminalServerRemoteHomeDir;
    ushort[261] InitialProgram;
    ushort[261] WorkDirectory;
    ushort[261] TerminalServerProfilePath;
    ushort[261] TerminalServerHomeDir;
    ushort[4]   TerminalServerHomeDirDrive;
}

struct WTS_SESSION_ADDRESS
{
    uint      AddressFamily;
    ubyte[20] Address;
}

struct WTS_PROCESS_INFO_EXW
{
    uint          SessionId;
    uint          ProcessId;
    const(wchar)* pProcessName;
    void*         pUserSid;
    uint          NumberOfThreads;
    uint          HandleCount;
    uint          PagefileUsage;
    uint          PeakPagefileUsage;
    uint          WorkingSetSize;
    uint          PeakWorkingSetSize;
    LARGE_INTEGER UserTime;
    LARGE_INTEGER KernelTime;
}

struct WTS_PROCESS_INFO_EXA
{
    uint          SessionId;
    uint          ProcessId;
    const(char)*  pProcessName;
    void*         pUserSid;
    uint          NumberOfThreads;
    uint          HandleCount;
    uint          PagefileUsage;
    uint          PeakPagefileUsage;
    uint          WorkingSetSize;
    uint          PeakWorkingSetSize;
    LARGE_INTEGER UserTime;
    LARGE_INTEGER KernelTime;
}

struct WTSLISTENERCONFIGW
{
    uint        version_;
    uint        fEnableListener;
    uint        MaxConnectionCount;
    uint        fPromptForPassword;
    uint        fInheritColorDepth;
    uint        ColorDepth;
    uint        fInheritBrokenTimeoutSettings;
    uint        BrokenTimeoutSettings;
    uint        fDisablePrinterRedirection;
    uint        fDisableDriveRedirection;
    uint        fDisableComPortRedirection;
    uint        fDisableLPTPortRedirection;
    uint        fDisableClipboardRedirection;
    uint        fDisableAudioRedirection;
    uint        fDisablePNPRedirection;
    uint        fDisableDefaultMainClientPrinter;
    uint        LanAdapter;
    uint        PortNumber;
    uint        fInheritShadowSettings;
    uint        ShadowSettings;
    uint        TimeoutSettingsConnection;
    uint        TimeoutSettingsDisconnection;
    uint        TimeoutSettingsIdle;
    uint        SecurityLayer;
    uint        MinEncryptionLevel;
    uint        UserAuthentication;
    ushort[61]  Comment;
    ushort[21]  LogonUserName;
    ushort[18]  LogonDomain;
    ushort[261] WorkDirectory;
    ushort[261] InitialProgram;
}

struct WTSLISTENERCONFIGA
{
    uint      version_;
    uint      fEnableListener;
    uint      MaxConnectionCount;
    uint      fPromptForPassword;
    uint      fInheritColorDepth;
    uint      ColorDepth;
    uint      fInheritBrokenTimeoutSettings;
    uint      BrokenTimeoutSettings;
    uint      fDisablePrinterRedirection;
    uint      fDisableDriveRedirection;
    uint      fDisableComPortRedirection;
    uint      fDisableLPTPortRedirection;
    uint      fDisableClipboardRedirection;
    uint      fDisableAudioRedirection;
    uint      fDisablePNPRedirection;
    uint      fDisableDefaultMainClientPrinter;
    uint      LanAdapter;
    uint      PortNumber;
    uint      fInheritShadowSettings;
    uint      ShadowSettings;
    uint      TimeoutSettingsConnection;
    uint      TimeoutSettingsDisconnection;
    uint      TimeoutSettingsIdle;
    uint      SecurityLayer;
    uint      MinEncryptionLevel;
    uint      UserAuthentication;
    byte[61]  Comment;
    byte[21]  LogonUserName;
    byte[18]  LogonDomain;
    byte[261] WorkDirectory;
    byte[261] InitialProgram;
}

struct WTSSBX_IP_ADDRESS
{
    WTSSBX_ADDRESS_FAMILY AddressFamily;
    ubyte[16] Address;
    ushort    PortNumber;
    uint      dwScope;
}

struct WTSSBX_MACHINE_CONNECT_INFO
{
    ushort[257] wczMachineFQDN;
    ushort[17]  wczMachineNetBiosName;
    uint        dwNumOfIPAddr;
    WTSSBX_IP_ADDRESS[12] IPaddr;
}

struct WTSSBX_MACHINE_INFO
{
    WTSSBX_MACHINE_CONNECT_INFO ClientConnectInfo;
    ushort[257]          wczFarmName;
    WTSSBX_IP_ADDRESS    InternalIPAddress;
    uint                 dwMaxSessionsLimit;
    uint                 ServerWeight;
    WTSSBX_MACHINE_SESSION_MODE SingleSessionMode;
    WTSSBX_MACHINE_DRAIN InDrain;
    WTSSBX_MACHINE_STATE MachineState;
}

struct WTSSBX_SESSION_INFO
{
    ushort[105]          wszUserName;
    ushort[257]          wszDomainName;
    ushort[257]          ApplicationType;
    uint                 dwSessionId;
    FILETIME             CreateTime;
    FILETIME             DisconnectTime;
    WTSSBX_SESSION_STATE SessionState;
}

struct CHANNEL_DEF
{
align (1):
    byte[8] name;
    uint    options;
}

struct CHANNEL_PDU_HEADER
{
    uint length;
    uint flags;
}

struct CHANNEL_ENTRY_POINTS
{
    uint                 cbSize;
    uint                 protocolVersion;
    PVIRTUALCHANNELINIT  pVirtualChannelInit;
    PVIRTUALCHANNELOPEN  pVirtualChannelOpen;
    PVIRTUALCHANNELCLOSE pVirtualChannelClose;
    PVIRTUALCHANNELWRITE pVirtualChannelWrite;
}

struct CLIENT_DISPLAY
{
    uint HorizontalResolution;
    uint VerticalResolution;
    uint ColorDepth;
}

struct TSSD_ConnectionPoint
{
    ubyte[16]        ServerAddressB;
    TSSD_AddrV46Type AddressType;
    ushort           PortNumber;
    uint             AddressScope;
}

struct VM_NOTIFY_ENTRY
{
    ushort[128] VmName;
    ushort[128] VmHost;
}

struct VM_PATCH_INFO
{
    uint     dwNumEntries;
    ushort** pVmNames;
}

struct VM_NOTIFY_INFO
{
    uint              dwNumEntries;
    VM_NOTIFY_ENTRY** ppVmEntries;
}

struct pluginResource
{
    ushort[256] alias_;
    ushort[256] name;
    ushort*     resourceFileContents;
    ushort[256] fileExtension;
    ushort[256] resourcePluginType;
    ubyte       isDiscoverable;
    int         resourceType;
    uint        pceIconSize;
    ubyte*      iconContents;
    uint        pcePluginBlobSize;
    ubyte*      blobContents;
}

struct pluginResource2FileAssociation
{
    ushort[256] extName;
    ubyte       primaryHandler;
    uint        pceIconSize;
    ubyte*      iconContents;
}

struct pluginResource2
{
    pluginResource resourceV1;
    uint           pceFileAssocListSize;
    pluginResource2FileAssociation* fileAssocList;
    ushort*        securityDescriptor;
    uint           pceFolderListSize;
    ushort**       folderList;
}

struct BITMAP_RENDERER_STATISTICS
{
    uint dwFramesDelivered;
    uint dwFramesDropped;
}

struct RFX_GFX_RECT
{
align (1):
    int left;
    int top;
    int right;
    int bottom;
}

struct RFX_GFX_MSG_HEADER
{
align (1):
    ushort uMSGType;
    ushort cbSize;
}

struct RFX_GFX_MONITOR_INFO
{
align (1):
    int  left;
    int  top;
    int  right;
    int  bottom;
    uint physicalWidth;
    uint physicalHeight;
    uint orientation;
    BOOL primary;
}

struct RFX_GFX_MSG_CLIENT_DESKTOP_INFO_REQUEST
{
    RFX_GFX_MSG_HEADER channelHdr;
}

struct RFX_GFX_MSG_CLIENT_DESKTOP_INFO_RESPONSE
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               reserved;
    uint               monitorCount;
    RFX_GFX_MONITOR_INFO[16] MonitorData;
    ushort[32]         clientUniqueId;
}

struct RFX_GFX_MSG_DESKTOP_CONFIG_CHANGE_NOTIFY
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               ulWidth;
    uint               ulHeight;
    uint               ulBpp;
    uint               Reserved;
}

struct RFX_GFX_MSG_DESKTOP_CONFIG_CHANGE_CONFIRM
{
    RFX_GFX_MSG_HEADER channelHdr;
}

struct RFX_GFX_MSG_DESKTOP_INPUT_RESET
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               ulWidth;
    uint               ulHeight;
}

struct RFX_GFX_MSG_DISCONNECT_NOTIFY
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               DisconnectReason;
}

struct RFX_GFX_MSG_DESKTOP_RESEND_REQUEST
{
    RFX_GFX_MSG_HEADER channelHdr;
    RFX_GFX_RECT       RedrawRect;
}

struct RFX_GFX_MSG_RDP_DATA
{
    RFX_GFX_MSG_HEADER channelHdr;
    ubyte[1]           rdpData;
}

struct WTS_SOCKADDR
{
    ushort sin_family;
    union u
    {
        struct ipv4
        {
            ushort   sin_port;
            uint     in_addr;
            ubyte[8] sin_zero;
        }
        struct ipv6
        {
            ushort    sin6_port;
            uint      sin6_flowinfo;
            ushort[8] sin6_addr;
            uint      sin6_scope_id;
        }
    }
}

struct WTS_SMALL_RECT
{
    short Left;
    short Top;
    short Right;
    short Bottom;
}

struct WTS_SERVICE_STATE
{
    WTS_RCM_SERVICE_STATE RcmServiceState;
    WTS_RCM_DRAIN_STATE RcmDrainState;
}

struct WTS_SESSION_ID
{
    GUID SessionUniqueGuid;
    uint SessionId;
}

struct WTS_USER_CREDENTIAL
{
    ushort[256] UserName;
    ushort[256] Password;
    ushort[256] Domain;
}

struct WTS_SYSTEMTIME
{
    ushort wYear;
    ushort wMonth;
    ushort wDayOfWeek;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wMilliseconds;
}

struct WTS_TIME_ZONE_INFORMATION
{
    int            Bias;
    ushort[32]     StandardName;
    WTS_SYSTEMTIME StandardDate;
    int            StandardBias;
    ushort[32]     DaylightName;
    WTS_SYSTEMTIME DaylightDate;
    int            DaylightBias;
}

struct WRDS_DYNAMIC_TIME_ZONE_INFORMATION
{
    int            Bias;
    ushort[32]     StandardName;
    WTS_SYSTEMTIME StandardDate;
    int            StandardBias;
    ushort[32]     DaylightName;
    WTS_SYSTEMTIME DaylightDate;
    int            DaylightBias;
    ushort[128]    TimeZoneKeyName;
    ushort         DynamicDaylightTimeDisabled;
}

struct WTS_CLIENT_DATA
{
    ubyte        fDisableCtrlAltDel;
    ubyte        fDoubleClickDetect;
    ubyte        fEnableWindowsKey;
    ubyte        fHideTitleBar;
    BOOL         fInheritAutoLogon;
    ubyte        fPromptForPassword;
    ubyte        fUsingSavedCreds;
    ushort[256]  Domain;
    ushort[256]  UserName;
    ushort[256]  Password;
    ubyte        fPasswordIsScPin;
    BOOL         fInheritInitialProgram;
    ushort[257]  WorkDirectory;
    ushort[257]  InitialProgram;
    ubyte        fMaximizeShell;
    ubyte        EncryptionLevel;
    uint         PerformanceFlags;
    ushort[9]    ProtocolName;
    ushort       ProtocolType;
    BOOL         fInheritColorDepth;
    ushort       HRes;
    ushort       VRes;
    ushort       ColorDepth;
    ushort[9]    DisplayDriverName;
    ushort[20]   DisplayDeviceName;
    ubyte        fMouse;
    uint         KeyboardLayout;
    uint         KeyboardType;
    uint         KeyboardSubType;
    uint         KeyboardFunctionKey;
    ushort[33]   imeFileName;
    uint         ActiveInputLocale;
    ubyte        fNoAudioPlayback;
    ubyte        fRemoteConsoleAudio;
    ushort[9]    AudioDriverName;
    WTS_TIME_ZONE_INFORMATION ClientTimeZone;
    ushort[21]   ClientName;
    uint         SerialNumber;
    uint         ClientAddressFamily;
    ushort[31]   ClientAddress;
    WTS_SOCKADDR ClientSockAddress;
    ushort[257]  ClientDirectory;
    uint         ClientBuildNumber;
    ushort       ClientProductId;
    ushort       OutBufCountHost;
    ushort       OutBufCountClient;
    ushort       OutBufLength;
    uint         ClientSessionId;
    ushort[33]   ClientDigProductId;
    ubyte        fDisableCpm;
    ubyte        fDisableCdm;
    ubyte        fDisableCcm;
    ubyte        fDisableLPT;
    ubyte        fDisableClip;
    ubyte        fDisablePNP;
}

struct WTS_USER_DATA
{
    ushort[257] WorkDirectory;
    ushort[257] InitialProgram;
    WTS_TIME_ZONE_INFORMATION UserTimeZone;
}

struct WTS_POLICY_DATA
{
    ubyte fDisableEncryption;
    ubyte fDisableAutoReconnect;
    uint  ColorDepth;
    ubyte MinEncryptionLevel;
    ubyte fDisableCpm;
    ubyte fDisableCdm;
    ubyte fDisableCcm;
    ubyte fDisableLPT;
    ubyte fDisableClip;
    ubyte fDisablePNPRedir;
}

struct WTS_PROTOCOL_CACHE
{
    uint CacheReads;
    uint CacheHits;
}

union WTS_CACHE_STATS_UN
{
    WTS_PROTOCOL_CACHE[4] ProtocolCache;
    uint     TShareCacheStats;
    uint[20] Reserved;
}

struct WTS_CACHE_STATS
{
    uint               Specific;
    WTS_CACHE_STATS_UN Data;
    ushort             ProtocolType;
    ushort             Length;
}

struct WTS_PROTOCOL_COUNTERS
{
    uint      WdBytes;
    uint      WdFrames;
    uint      WaitForOutBuf;
    uint      Frames;
    uint      Bytes;
    uint      CompressedBytes;
    uint      CompressFlushes;
    uint      Errors;
    uint      Timeouts;
    uint      AsyncFramingError;
    uint      AsyncOverrunError;
    uint      AsyncOverflowError;
    uint      AsyncParityError;
    uint      TdErrors;
    ushort    ProtocolType;
    ushort    Length;
    ushort    Specific;
    uint[100] Reserved;
}

struct WTS_PROTOCOL_STATUS
{
    WTS_PROTOCOL_COUNTERS Output;
    WTS_PROTOCOL_COUNTERS Input;
    WTS_CACHE_STATS    Cache;
    uint               AsyncSignal;
    uint               AsyncSignalMask;
    LARGE_INTEGER[100] Counters;
}

struct WTS_DISPLAY_IOCTL
{
    ubyte[256] pDisplayIOCtlData;
    uint       cbDisplayIOCtlData;
}

struct WTS_PROPERTY_VALUE
{
    ushort Type;
    union u
    {
        uint ulVal;
        struct strVal
        {
            uint    size;
            ushort* pstrVal;
        }
        struct bVal
        {
            uint  size;
            byte* pbVal;
        }
        GUID guidVal;
    }
}

struct WTS_LICENSE_CAPABILITIES
{
    uint          KeyExchangeAlg;
    uint          ProtocolVer;
    BOOL          fAuthenticateServer;
    WTS_CERT_TYPE CertType;
    uint          cbClientName;
    ubyte[42]     rgbClientName;
}

struct WRDS_LISTENER_SETTINGS_1
{
    uint   MaxProtocolListenerConnectionCount;
    uint   SecurityDescriptorSize;
    ubyte* pSecurityDescriptor;
}

union WRDS_LISTENER_SETTING
{
    WRDS_LISTENER_SETTINGS_1 WRdsListenerSettings1;
}

struct WRDS_LISTENER_SETTINGS
{
    WRDS_LISTENER_SETTING_LEVEL WRdsListenerSettingLevel;
    WRDS_LISTENER_SETTING WRdsListenerSetting;
}

struct WRDS_CONNECTION_SETTINGS_1
{
    ubyte        fInheritInitialProgram;
    ubyte        fInheritColorDepth;
    ubyte        fHideTitleBar;
    ubyte        fInheritAutoLogon;
    ubyte        fMaximizeShell;
    ubyte        fDisablePNP;
    ubyte        fPasswordIsScPin;
    ubyte        fPromptForPassword;
    ubyte        fDisableCpm;
    ubyte        fDisableCdm;
    ubyte        fDisableCcm;
    ubyte        fDisableLPT;
    ubyte        fDisableClip;
    ubyte        fResetBroken;
    ubyte        fDisableEncryption;
    ubyte        fDisableAutoReconnect;
    ubyte        fDisableCtrlAltDel;
    ubyte        fDoubleClickDetect;
    ubyte        fEnableWindowsKey;
    ubyte        fUsingSavedCreds;
    ubyte        fMouse;
    ubyte        fNoAudioPlayback;
    ubyte        fRemoteConsoleAudio;
    ubyte        EncryptionLevel;
    ushort       ColorDepth;
    ushort       ProtocolType;
    ushort       HRes;
    ushort       VRes;
    ushort       ClientProductId;
    ushort       OutBufCountHost;
    ushort       OutBufCountClient;
    ushort       OutBufLength;
    uint         KeyboardLayout;
    uint         MaxConnectionTime;
    uint         MaxDisconnectionTime;
    uint         MaxIdleTime;
    uint         PerformanceFlags;
    uint         KeyboardType;
    uint         KeyboardSubType;
    uint         KeyboardFunctionKey;
    uint         ActiveInputLocale;
    uint         SerialNumber;
    uint         ClientAddressFamily;
    uint         ClientBuildNumber;
    uint         ClientSessionId;
    ushort[257]  WorkDirectory;
    ushort[257]  InitialProgram;
    ushort[256]  UserName;
    ushort[256]  Domain;
    ushort[256]  Password;
    ushort[9]    ProtocolName;
    ushort[9]    DisplayDriverName;
    ushort[20]   DisplayDeviceName;
    ushort[33]   imeFileName;
    ushort[9]    AudioDriverName;
    ushort[21]   ClientName;
    ushort[31]   ClientAddress;
    ushort[257]  ClientDirectory;
    ushort[33]   ClientDigProductId;
    WTS_SOCKADDR ClientSockAddress;
    WTS_TIME_ZONE_INFORMATION ClientTimeZone;
    WRDS_LISTENER_SETTINGS WRdsListenerSettings;
    GUID         EventLogActivityId;
    uint         ContextSize;
    ubyte*       ContextData;
}

struct WRDS_SETTINGS_1
{
    WRDS_SETTING_STATUS WRdsDisableClipStatus;
    uint                WRdsDisableClipValue;
    WRDS_SETTING_STATUS WRdsDisableLPTStatus;
    uint                WRdsDisableLPTValue;
    WRDS_SETTING_STATUS WRdsDisableCcmStatus;
    uint                WRdsDisableCcmValue;
    WRDS_SETTING_STATUS WRdsDisableCdmStatus;
    uint                WRdsDisableCdmValue;
    WRDS_SETTING_STATUS WRdsDisableCpmStatus;
    uint                WRdsDisableCpmValue;
    WRDS_SETTING_STATUS WRdsDisablePnpStatus;
    uint                WRdsDisablePnpValue;
    WRDS_SETTING_STATUS WRdsEncryptionLevelStatus;
    uint                WRdsEncryptionValue;
    WRDS_SETTING_STATUS WRdsColorDepthStatus;
    uint                WRdsColorDepthValue;
    WRDS_SETTING_STATUS WRdsDisableAutoReconnecetStatus;
    uint                WRdsDisableAutoReconnecetValue;
    WRDS_SETTING_STATUS WRdsDisableEncryptionStatus;
    uint                WRdsDisableEncryptionValue;
    WRDS_SETTING_STATUS WRdsResetBrokenStatus;
    uint                WRdsResetBrokenValue;
    WRDS_SETTING_STATUS WRdsMaxIdleTimeStatus;
    uint                WRdsMaxIdleTimeValue;
    WRDS_SETTING_STATUS WRdsMaxDisconnectTimeStatus;
    uint                WRdsMaxDisconnectTimeValue;
    WRDS_SETTING_STATUS WRdsMaxConnectTimeStatus;
    uint                WRdsMaxConnectTimeValue;
    WRDS_SETTING_STATUS WRdsKeepAliveStatus;
    ubyte               WRdsKeepAliveStartValue;
    uint                WRdsKeepAliveIntervalValue;
}

union WRDS_CONNECTION_SETTING
{
    WRDS_CONNECTION_SETTINGS_1 WRdsConnectionSettings1;
}

struct WRDS_CONNECTION_SETTINGS
{
    WRDS_CONNECTION_SETTING_LEVEL WRdsConnectionSettingLevel;
    WRDS_CONNECTION_SETTING WRdsConnectionSetting;
}

union WRDS_SETTING
{
    WRDS_SETTINGS_1 WRdsSettings1;
}

struct WRDS_SETTINGS
{
    WRDS_SETTING_TYPE  WRdsSettingType;
    WRDS_SETTING_LEVEL WRdsSettingLevel;
    WRDS_SETTING       WRdsSetting;
}

// Functions

@DllImport("KERNEL32")
BOOL ProcessIdToSessionId(uint dwProcessId, uint* pSessionId);

@DllImport("KERNEL32")
uint WTSGetActiveConsoleSessionId();

@DllImport("WTSAPI32")
BOOL WTSStopRemoteControlSession(uint LogonId);

@DllImport("WTSAPI32")
BOOL WTSStartRemoteControlSessionW(const(wchar)* pTargetServerName, uint TargetLogonId, ubyte HotkeyVk, 
                                   ushort HotkeyModifiers);

@DllImport("WTSAPI32")
BOOL WTSStartRemoteControlSessionA(const(char)* pTargetServerName, uint TargetLogonId, ubyte HotkeyVk, 
                                   ushort HotkeyModifiers);

@DllImport("WTSAPI32")
BOOL WTSConnectSessionA(uint LogonId, uint TargetLogonId, const(char)* pPassword, BOOL bWait);

@DllImport("WTSAPI32")
BOOL WTSConnectSessionW(uint LogonId, uint TargetLogonId, const(wchar)* pPassword, BOOL bWait);

@DllImport("WTSAPI32")
BOOL WTSEnumerateServersW(const(wchar)* pDomainName, uint Reserved, uint Version, WTS_SERVER_INFOW** ppServerInfo, 
                          uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSEnumerateServersA(const(char)* pDomainName, uint Reserved, uint Version, WTS_SERVER_INFOA** ppServerInfo, 
                          uint* pCount);

@DllImport("WTSAPI32")
HANDLE WTSOpenServerW(const(wchar)* pServerName);

@DllImport("WTSAPI32")
HANDLE WTSOpenServerA(const(char)* pServerName);

@DllImport("WTSAPI32")
HANDLE WTSOpenServerExW(const(wchar)* pServerName);

@DllImport("WTSAPI32")
HANDLE WTSOpenServerExA(const(char)* pServerName);

@DllImport("WTSAPI32")
void WTSCloseServer(HANDLE hServer);

@DllImport("WTSAPI32")
BOOL WTSEnumerateSessionsW(HANDLE hServer, uint Reserved, uint Version, WTS_SESSION_INFOW** ppSessionInfo, 
                           uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSEnumerateSessionsA(HANDLE hServer, uint Reserved, uint Version, WTS_SESSION_INFOA** ppSessionInfo, 
                           uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSEnumerateSessionsExW(HANDLE hServer, uint* pLevel, uint Filter, WTS_SESSION_INFO_1W** ppSessionInfo, 
                             uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSEnumerateSessionsExA(HANDLE hServer, uint* pLevel, uint Filter, WTS_SESSION_INFO_1A** ppSessionInfo, 
                             uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSEnumerateProcessesW(HANDLE hServer, uint Reserved, uint Version, WTS_PROCESS_INFOW** ppProcessInfo, 
                            uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSEnumerateProcessesA(HANDLE hServer, uint Reserved, uint Version, WTS_PROCESS_INFOA** ppProcessInfo, 
                            uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSTerminateProcess(HANDLE hServer, uint ProcessId, uint ExitCode);

@DllImport("WTSAPI32")
BOOL WTSQuerySessionInformationW(HANDLE hServer, uint SessionId, WTS_INFO_CLASS WTSInfoClass, ushort** ppBuffer, 
                                 uint* pBytesReturned);

@DllImport("WTSAPI32")
BOOL WTSQuerySessionInformationA(HANDLE hServer, uint SessionId, WTS_INFO_CLASS WTSInfoClass, byte** ppBuffer, 
                                 uint* pBytesReturned);

@DllImport("WTSAPI32")
BOOL WTSQueryUserConfigW(const(wchar)* pServerName, const(wchar)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, 
                         ushort** ppBuffer, uint* pBytesReturned);

@DllImport("WTSAPI32")
BOOL WTSQueryUserConfigA(const(char)* pServerName, const(char)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, 
                         byte** ppBuffer, uint* pBytesReturned);

@DllImport("WTSAPI32")
BOOL WTSSetUserConfigW(const(wchar)* pServerName, const(wchar)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, 
                       const(wchar)* pBuffer, uint DataLength);

@DllImport("WTSAPI32")
BOOL WTSSetUserConfigA(const(char)* pServerName, const(char)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, 
                       const(char)* pBuffer, uint DataLength);

@DllImport("WTSAPI32")
BOOL WTSSendMessageW(HANDLE hServer, uint SessionId, const(wchar)* pTitle, uint TitleLength, 
                     const(wchar)* pMessage, uint MessageLength, uint Style, uint Timeout, uint* pResponse, 
                     BOOL bWait);

@DllImport("WTSAPI32")
BOOL WTSSendMessageA(HANDLE hServer, uint SessionId, const(char)* pTitle, uint TitleLength, const(char)* pMessage, 
                     uint MessageLength, uint Style, uint Timeout, uint* pResponse, BOOL bWait);

@DllImport("WTSAPI32")
BOOL WTSDisconnectSession(HANDLE hServer, uint SessionId, BOOL bWait);

@DllImport("WTSAPI32")
BOOL WTSLogoffSession(HANDLE hServer, uint SessionId, BOOL bWait);

@DllImport("WTSAPI32")
BOOL WTSShutdownSystem(HANDLE hServer, uint ShutdownFlag);

@DllImport("WTSAPI32")
BOOL WTSWaitSystemEvent(HANDLE hServer, uint EventMask, uint* pEventFlags);

@DllImport("WTSAPI32")
HwtsVirtualChannelHandle WTSVirtualChannelOpen(HANDLE hServer, uint SessionId, const(char)* pVirtualName);

@DllImport("WTSAPI32")
HwtsVirtualChannelHandle WTSVirtualChannelOpenEx(uint SessionId, const(char)* pVirtualName, uint flags);

@DllImport("WTSAPI32")
BOOL WTSVirtualChannelClose(HANDLE hChannelHandle);

@DllImport("WTSAPI32")
BOOL WTSVirtualChannelRead(HANDLE hChannelHandle, uint TimeOut, const(char)* Buffer, uint BufferSize, 
                           uint* pBytesRead);

@DllImport("WTSAPI32")
BOOL WTSVirtualChannelWrite(HANDLE hChannelHandle, const(char)* Buffer, uint Length, uint* pBytesWritten);

@DllImport("WTSAPI32")
BOOL WTSVirtualChannelPurgeInput(HANDLE hChannelHandle);

@DllImport("WTSAPI32")
BOOL WTSVirtualChannelPurgeOutput(HANDLE hChannelHandle);

@DllImport("WTSAPI32")
BOOL WTSVirtualChannelQuery(HANDLE hChannelHandle, WTS_VIRTUAL_CLASS param1, void** ppBuffer, uint* pBytesReturned);

@DllImport("WTSAPI32")
void WTSFreeMemory(void* pMemory);

@DllImport("WTSAPI32")
BOOL WTSRegisterSessionNotification(HWND hWnd, uint dwFlags);

@DllImport("WTSAPI32")
BOOL WTSUnRegisterSessionNotification(HWND hWnd);

@DllImport("WINSTA")
BOOL WTSRegisterSessionNotificationEx(HANDLE hServer, HWND hWnd, uint dwFlags);

@DllImport("WINSTA")
BOOL WTSUnRegisterSessionNotificationEx(HANDLE hServer, HWND hWnd);

@DllImport("WTSAPI32")
BOOL WTSQueryUserToken(uint SessionId, ptrdiff_t* phToken);

@DllImport("WTSAPI32")
BOOL WTSFreeMemoryExW(WTS_TYPE_CLASS WTSTypeClass, void* pMemory, uint NumberOfEntries);

@DllImport("WTSAPI32")
BOOL WTSFreeMemoryExA(WTS_TYPE_CLASS WTSTypeClass, void* pMemory, uint NumberOfEntries);

@DllImport("WTSAPI32")
BOOL WTSEnumerateProcessesExW(HANDLE hServer, uint* pLevel, uint SessionId, ushort** ppProcessInfo, uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSEnumerateProcessesExA(HANDLE hServer, uint* pLevel, uint SessionId, byte** ppProcessInfo, uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSEnumerateListenersW(HANDLE hServer, void* pReserved, uint Reserved, char* pListeners, uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSEnumerateListenersA(HANDLE hServer, void* pReserved, uint Reserved, char* pListeners, uint* pCount);

@DllImport("WTSAPI32")
BOOL WTSQueryListenerConfigW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, 
                             WTSLISTENERCONFIGW* pBuffer);

@DllImport("WTSAPI32")
BOOL WTSQueryListenerConfigA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, 
                             WTSLISTENERCONFIGA* pBuffer);

@DllImport("WTSAPI32")
BOOL WTSCreateListenerW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, 
                        WTSLISTENERCONFIGW* pBuffer, uint flag);

@DllImport("WTSAPI32")
BOOL WTSCreateListenerA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, 
                        WTSLISTENERCONFIGA* pBuffer, uint flag);

@DllImport("WTSAPI32")
BOOL WTSSetListenerSecurityW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, 
                             uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("WTSAPI32")
BOOL WTSSetListenerSecurityA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, 
                             uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("WTSAPI32")
BOOL WTSGetListenerSecurityW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, 
                             uint SecurityInformation, void* pSecurityDescriptor, uint nLength, 
                             uint* lpnLengthNeeded);

@DllImport("WTSAPI32")
BOOL WTSGetListenerSecurityA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, 
                             uint SecurityInformation, void* pSecurityDescriptor, uint nLength, 
                             uint* lpnLengthNeeded);

@DllImport("WTSAPI32")
BOOL WTSEnableChildSessions(BOOL bEnable);

@DllImport("WTSAPI32")
BOOL WTSIsChildSessionsEnabled(int* pbEnabled);

@DllImport("WTSAPI32")
BOOL WTSGetChildSessionId(uint* pSessionId);

@DllImport("WTSAPI32")
HRESULT WTSSetRenderHint(ulong* pRenderHintID, HWND hwndOwner, uint renderHintType, uint cbHintDataLength, 
                         char* pHintData);


// Interfaces

@GUID("0910DD01-DF8C-11D1-AE27-00C04FA35813")
struct TSUserExInterfaces;

@GUID("E2E9CAE6-1E7B-4B8E-BABD-E9BF6292AC29")
struct ADsTSUserEx;

@GUID("4F1DFCA6-3AAD-48E1-8406-4BC21A501D7C")
struct Workspace;

@GUID("30A99515-1527-4451-AF9F-00C5F0234DAF")
interface IAudioEndpoint : IUnknown
{
    HRESULT GetFrameFormat(WAVEFORMATEX** ppFormat);
    HRESULT GetFramesPerPacket(uint* pFramesPerPacket);
    HRESULT GetLatency(long* pLatency);
    HRESULT SetStreamFlags(uint streamFlags);
    HRESULT SetEventHandle(HANDLE eventHandle);
}

@GUID("DFD2005F-A6E5-4D39-A265-939ADA9FBB4D")
interface IAudioEndpointRT : IUnknown
{
    void    GetCurrentPadding(long* pPadding, AE_CURRENT_POSITION* pAeCurrentPosition);
    void    ProcessingComplete();
    HRESULT SetPinInactive();
    HRESULT SetPinActive();
}

@GUID("8026AB61-92B2-43C1-A1DF-5C37EBD08D82")
interface IAudioInputEndpointRT : IUnknown
{
    void GetInputDataPointer(APO_CONNECTION_PROPERTY* pConnectionProperty, AE_CURRENT_POSITION* pAeTimeStamp);
    void ReleaseInputDataPointer(uint u32FrameCount, size_t pDataPointer);
    void PulseEndpoint();
}

@GUID("8FA906E4-C31C-4E31-932E-19A66385E9AA")
interface IAudioOutputEndpointRT : IUnknown
{
    size_t GetOutputDataPointer(uint u32FrameCount, AE_CURRENT_POSITION* pAeTimeStamp);
    void   ReleaseOutputDataPointer(const(APO_CONNECTION_PROPERTY)* pConnectionProperty);
    void   PulseEndpoint();
}

@GUID("D4952F5A-A0B2-4CC4-8B82-9358488DD8AC")
interface IAudioDeviceEndpoint : IUnknown
{
    HRESULT SetBuffer(long MaxPeriod, uint u32LatencyCoefficient);
    HRESULT GetRTCaps(int* pbIsRTCapable);
    HRESULT GetEventDrivenCapable(int* pbisEventCapable);
    HRESULT WriteExclusiveModeParametersToSharedMemory(size_t hTargetProcess, long hnsPeriod, 
                                                       long hnsBufferDuration, uint u32LatencyCoefficient, 
                                                       uint* pu32SharedMemorySize, size_t* phSharedMemory);
}

@GUID("C684B72A-6DF4-4774-BDF9-76B77509B653")
interface IAudioEndpointControl : IUnknown
{
    HRESULT Start();
    HRESULT Reset();
    HRESULT Stop();
}

@GUID("C4930E79-2989-4462-8A60-2FCF2F2955EF")
interface IADsTSUserEx : IDispatch
{
    HRESULT get_TerminalServicesProfilePath(BSTR* pVal);
    HRESULT put_TerminalServicesProfilePath(BSTR pNewVal);
    HRESULT get_TerminalServicesHomeDirectory(BSTR* pVal);
    HRESULT put_TerminalServicesHomeDirectory(BSTR pNewVal);
    HRESULT get_TerminalServicesHomeDrive(BSTR* pVal);
    HRESULT put_TerminalServicesHomeDrive(BSTR pNewVal);
    HRESULT get_AllowLogon(int* pVal);
    HRESULT put_AllowLogon(int NewVal);
    HRESULT get_EnableRemoteControl(int* pVal);
    HRESULT put_EnableRemoteControl(int NewVal);
    HRESULT get_MaxDisconnectionTime(int* pVal);
    HRESULT put_MaxDisconnectionTime(int NewVal);
    HRESULT get_MaxConnectionTime(int* pVal);
    HRESULT put_MaxConnectionTime(int NewVal);
    HRESULT get_MaxIdleTime(int* pVal);
    HRESULT put_MaxIdleTime(int NewVal);
    HRESULT get_ReconnectionAction(int* pNewVal);
    HRESULT put_ReconnectionAction(int NewVal);
    HRESULT get_BrokenConnectionAction(int* pNewVal);
    HRESULT put_BrokenConnectionAction(int NewVal);
    HRESULT get_ConnectClientDrivesAtLogon(int* pNewVal);
    HRESULT put_ConnectClientDrivesAtLogon(int NewVal);
    HRESULT get_ConnectClientPrintersAtLogon(int* pVal);
    HRESULT put_ConnectClientPrintersAtLogon(int NewVal);
    HRESULT get_DefaultToMainPrinter(int* pVal);
    HRESULT put_DefaultToMainPrinter(int NewVal);
    HRESULT get_TerminalServicesWorkDirectory(BSTR* pVal);
    HRESULT put_TerminalServicesWorkDirectory(BSTR pNewVal);
    HRESULT get_TerminalServicesInitialProgram(BSTR* pVal);
    HRESULT put_TerminalServicesInitialProgram(BSTR pNewVal);
}

@GUID("C27ECE33-7781-4318-98EF-1CF2DA7B7005")
interface ITSGAuthorizeConnectionSink : IUnknown
{
    HRESULT OnConnectionAuthorized(HRESULT hrIn, GUID mainSessionId, uint cbSoHResponse, char* pbSoHResponse, 
                                   uint idleTimeout, uint sessionTimeout, 
                                   __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0004 sessionTimeoutAction, 
                                   __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0006 trustClass, 
                                   char* policyAttributes);
}

@GUID("FEDDFCD4-FA12-4435-AE55-7AD1A9779AF7")
interface ITSGAuthorizeResourceSink : IUnknown
{
    HRESULT OnChannelAuthorized(HRESULT hrIn, GUID mainSessionId, int subSessionId, char* allowedResourceNames, 
                                uint numAllowedResourceNames, char* failedResourceNames, uint numFailedResourceNames);
}

@GUID("8BC24F08-6223-42F4-A5B4-8E37CD135BBD")
interface ITSGPolicyEngine : IUnknown
{
    HRESULT AuthorizeConnection(GUID mainSessionId, BSTR username, AAAuthSchemes authType, BSTR clientMachineIP, 
                                BSTR clientMachineName, char* sohData, uint numSOHBytes, char* cookieData, 
                                uint numCookieBytes, size_t userToken, ITSGAuthorizeConnectionSink pSink);
    HRESULT AuthorizeResource(GUID mainSessionId, int subSessionId, BSTR username, char* resourceNames, 
                              uint numResources, char* alternateResourceNames, uint numAlternateResourceName, 
                              uint portNumber, BSTR operation, char* cookie, uint numBytesInCookie, 
                              ITSGAuthorizeResourceSink pSink);
    HRESULT Refresh();
    HRESULT IsQuarantineEnabled(int* quarantineEnabled);
}

@GUID("4CE2A0C9-E874-4F1A-86F4-06BBB9115338")
interface ITSGAccountingEngine : IUnknown
{
    HRESULT DoAccounting(AAAccountingDataType accountingDataType, AAAccountingData accountingData);
}

@GUID("2C3E2E73-A782-47F9-8DFB-77EE1ED27A03")
interface ITSGAuthenticateUserSink : IUnknown
{
    HRESULT OnUserAuthenticated(BSTR userName, BSTR userDomain, size_t context, size_t userToken);
    HRESULT OnUserAuthenticationFailed(size_t context, HRESULT genericErrorCode, HRESULT specificErrorCode);
    HRESULT ReauthenticateUser(size_t context);
    HRESULT DisconnectUser(size_t context);
}

@GUID("9EE3E5BF-04AB-4691-998C-D7F622321A56")
interface ITSGAuthenticationEngine : IUnknown
{
    HRESULT AuthenticateUser(GUID mainSessionId, ubyte* cookieData, uint numCookieBytes, size_t context, 
                             ITSGAuthenticateUserSink pSink);
    HRESULT CancelAuthentication(GUID mainSessionId, size_t context);
}

@GUID("DC44BE78-B18D-4399-B210-641BF67A002C")
interface IWTSSBPlugin : IUnknown
{
    HRESULT Initialize(uint* PluginCapabilities);
    HRESULT WTSSBX_MachineChangeNotification(WTSSBX_NOTIFICATION_TYPE NotificationType, int MachineId, 
                                             WTSSBX_MACHINE_INFO* pMachineInfo);
    HRESULT WTSSBX_SessionChangeNotification(WTSSBX_NOTIFICATION_TYPE NotificationType, int MachineId, 
                                             uint NumOfSessions, char* SessionInfo);
    HRESULT WTSSBX_GetMostSuitableServer(ushort* UserName, ushort* DomainName, ushort* ApplicationType, 
                                         ushort* FarmName, int* pMachineId);
    HRESULT Terminated();
    HRESULT WTSSBX_GetUserExternalSession(ushort* UserName, ushort* DomainName, ushort* ApplicationType, 
                                          WTSSBX_IP_ADDRESS* RedirectorInternalIP, uint* pSessionId, 
                                          WTSSBX_MACHINE_CONNECT_INFO* pMachineConnectInfo);
}

@GUID("12B952F4-41CA-4F21-A829-A6D07D9A16E5")
interface IWorkspaceClientExt : IUnknown
{
    HRESULT GetResourceId(BSTR* bstrWorkspaceId);
    HRESULT GetResourceDisplayName(BSTR* bstrWorkspaceDisplayName);
    HRESULT IssueDisconnect();
}

@GUID("B922BBB8-4C55-4FEA-8496-BEB0B44285E5")
interface IWorkspace : IUnknown
{
    HRESULT GetWorkspaceNames(SAFEARRAY** psaWkspNames);
    HRESULT StartRemoteApplication(BSTR bstrWorkspaceId, SAFEARRAY* psaParams);
    HRESULT GetProcessId(uint* pulProcessId);
}

@GUID("96D8D7CF-783E-4286-834C-EBC0E95F783C")
interface IWorkspace2 : IWorkspace
{
    HRESULT StartRemoteApplicationEx(BSTR bstrWorkspaceId, BSTR bstrRequestingAppId, 
                                     BSTR bstrRequestingAppFamilyName, short bLaunchIntoImmersiveClient, 
                                     BSTR bstrImmersiveClientActivationContext, SAFEARRAY* psaParams);
}

@GUID("1BECBE4A-D654-423B-AFEB-BE8D532C13C6")
interface IWorkspace3 : IWorkspace2
{
    HRESULT GetClaimsToken2(BSTR bstrClaimsHint, BSTR bstrUserHint, uint claimCookie, uint hwndCredUiParent, 
                            RECT rectCredUiParent, BSTR* pbstrAccessToken);
    HRESULT SetClaimsToken(BSTR bstrAccessToken, ulong ullAccessTokenExpiration, BSTR bstrRefreshToken);
}

@GUID("B922BBB8-4C55-4FEA-8496-BEB0B44285E6")
interface IWorkspaceRegistration : IUnknown
{
    HRESULT AddResource(IWorkspaceClientExt pUnk, uint* pdwCookie);
    HRESULT RemoveResource(uint dwCookieConnection);
}

@GUID("CF59F654-39BB-44D8-94D0-4635728957E9")
interface IWorkspaceRegistration2 : IWorkspaceRegistration
{
    HRESULT AddResourceEx(IWorkspaceClientExt pUnk, BSTR bstrEventLogUploadAddress, uint* pdwCookie, 
                          GUID correlationId);
    HRESULT RemoveResourceEx(uint dwCookieConnection, GUID correlationId);
}

@GUID("EFEA49A2-DDA5-429D-8F42-B23B92C4C347")
interface IWorkspaceScriptable : IDispatch
{
    HRESULT DisconnectWorkspace(BSTR bstrWorkspaceId);
    HRESULT StartWorkspace(BSTR bstrWorkspaceId, BSTR bstrUserName, BSTR bstrPassword, BSTR bstrWorkspaceParams, 
                           int lTimeout, int lFlags);
    HRESULT IsWorkspaceCredentialSpecified(BSTR bstrWorkspaceId, short bCountUnauthenticatedCredentials, 
                                           short* pbCredExist);
    HRESULT IsWorkspaceSSOEnabled(short* pbSSOEnabled);
    HRESULT ClearWorkspaceCredential(BSTR bstrWorkspaceId);
    HRESULT OnAuthenticated(BSTR bstrWorkspaceId, BSTR bstrUserName);
    HRESULT DisconnectWorkspaceByFriendlyName(BSTR bstrWorkspaceFriendlyName);
}

@GUID("EFEA49A2-DDA5-429D-8F42-B33BA2C4C348")
interface IWorkspaceScriptable2 : IWorkspaceScriptable
{
    HRESULT StartWorkspaceEx(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName, BSTR bstrRedirectorName, 
                             BSTR bstrUserName, BSTR bstrPassword, BSTR bstrAppContainer, BSTR bstrWorkspaceParams, 
                             int lTimeout, int lFlags);
    HRESULT ResourceDismissed(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName);
}

@GUID("531E6512-2CBF-4BD2-80A5-D90A71636A9A")
interface IWorkspaceScriptable3 : IWorkspaceScriptable2
{
    HRESULT StartWorkspaceEx2(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName, BSTR bstrRedirectorName, 
                              BSTR bstrUserName, BSTR bstrPassword, BSTR bstrAppContainer, BSTR bstrWorkspaceParams, 
                              int lTimeout, int lFlags, BSTR bstrEventLogUploadAddress, GUID correlationId);
}

@GUID("A7C06739-500F-4E8C-99A8-2BD6955899EB")
interface IWorkspaceReportMessage : IUnknown
{
    HRESULT RegisterErrorLogMessage(BSTR bstrMessage);
    HRESULT IsErrorMessageRegistered(BSTR bstrWkspId, uint dwErrorType, BSTR bstrErrorMessageType, 
                                     uint dwErrorCode, short* pfErrorExist);
    HRESULT RegisterErrorEvent(BSTR bstrWkspId, uint dwErrorType, BSTR bstrErrorMessageType, uint dwErrorCode);
}

@GUID("B922BBB8-4C55-4FEA-8496-BEB0B44285E9")
interface _ITSWkspEvents : IDispatch
{
}

@GUID("48CD7406-CAAB-465F-A5D6-BAA863B9EA4F")
interface ITsSbPlugin : IUnknown
{
    HRESULT Initialize(ITsSbProvider pProvider, ITsSbPluginNotifySink pNotifySink, 
                       ITsSbPluginPropertySet pPropertySet);
    HRESULT Terminate(HRESULT hr);
}

@GUID("EA8DB42C-98ED-4535-A88B-2A164F35490F")
interface ITsSbResourcePlugin : ITsSbPlugin
{
}

@GUID("86CB68AE-86E0-4F57-8A64-BB7406BC5550")
interface ITsSbServiceNotification : IUnknown
{
    HRESULT NotifyServiceFailure();
    HRESULT NotifyServiceSuccess();
}

@GUID("24329274-9EB7-11DC-AE98-F2B456D89593")
interface ITsSbLoadBalancing : ITsSbPlugin
{
    HRESULT GetMostSuitableTarget(ITsSbClientConnection pConnection, ITsSbLoadBalancingNotifySink pLBSink);
}

@GUID("DAADEE5F-6D32-480E-9E36-DDAB2329F06D")
interface ITsSbPlacement : ITsSbPlugin
{
    HRESULT QueryEnvironmentForTarget(ITsSbClientConnection pConnection, ITsSbPlacementNotifySink pPlacementSink);
}

@GUID("64FC1172-9EB7-11DC-8B00-3ABA56D89593")
interface ITsSbOrchestration : ITsSbPlugin
{
    HRESULT PrepareTargetForConnect(ITsSbClientConnection pConnection, 
                                    ITsSbOrchestrationNotifySink pOrchestrationNotifySink);
}

@GUID("8C87F7F7-BF51-4A5C-87BF-8E94FB6E2256")
interface ITsSbEnvironment : IUnknown
{
    HRESULT get_Name(BSTR* pVal);
    HRESULT get_ServerWeight(uint* pVal);
    HRESULT get_EnvironmentPropertySet(ITsSbEnvironmentPropertySet* ppPropertySet);
    HRESULT put_EnvironmentPropertySet(ITsSbEnvironmentPropertySet pVal);
}

@GUID("24FDB7AC-FEA6-11DC-9672-9A8956D89593")
interface ITsSbLoadBalanceResult : IUnknown
{
    HRESULT get_TargetName(BSTR* pVal);
}

@GUID("16616ECC-272D-411D-B324-126893033856")
interface ITsSbTarget : IUnknown
{
    HRESULT get_TargetName(BSTR* pVal);
    HRESULT put_TargetName(BSTR Val);
    HRESULT get_FarmName(BSTR* pVal);
    HRESULT put_FarmName(BSTR Val);
    HRESULT get_TargetFQDN(BSTR* TargetFqdnName);
    HRESULT put_TargetFQDN(BSTR Val);
    HRESULT get_TargetNetbios(BSTR* TargetNetbiosName);
    HRESULT put_TargetNetbios(BSTR Val);
    HRESULT get_IpAddresses(char* SOCKADDR, uint* numAddresses);
    HRESULT put_IpAddresses(char* SOCKADDR, uint numAddresses);
    HRESULT get_TargetState(TARGET_STATE* pState);
    HRESULT put_TargetState(TARGET_STATE State);
    HRESULT get_TargetPropertySet(ITsSbTargetPropertySet* ppPropertySet);
    HRESULT put_TargetPropertySet(ITsSbTargetPropertySet pVal);
    HRESULT get_EnvironmentName(BSTR* pVal);
    HRESULT put_EnvironmentName(BSTR Val);
    HRESULT get_NumSessions(uint* pNumSessions);
    HRESULT get_NumPendingConnections(uint* pNumPendingConnections);
    HRESULT get_TargetLoad(uint* pTargetLoad);
}

@GUID("D453AAC7-B1D8-4C5E-BA34-9AFB4C8C5510")
interface ITsSbSession : IUnknown
{
    HRESULT get_SessionId(uint* pVal);
    HRESULT get_TargetName(BSTR* targetName);
    HRESULT put_TargetName(BSTR targetName);
    HRESULT get_Username(BSTR* userName);
    HRESULT get_Domain(BSTR* domain);
    HRESULT get_State(TSSESSION_STATE* pState);
    HRESULT put_State(TSSESSION_STATE State);
    HRESULT get_CreateTime(FILETIME* pTime);
    HRESULT put_CreateTime(FILETIME Time);
    HRESULT get_DisconnectTime(FILETIME* pTime);
    HRESULT put_DisconnectTime(FILETIME Time);
    HRESULT get_InitialProgram(BSTR* app);
    HRESULT put_InitialProgram(BSTR Application);
    HRESULT get_ClientDisplay(CLIENT_DISPLAY* pClientDisplay);
    HRESULT put_ClientDisplay(CLIENT_DISPLAY pClientDisplay);
    HRESULT get_ProtocolType(uint* pVal);
    HRESULT put_ProtocolType(uint Val);
}

@GUID("65D3E85A-C39B-11DC-B92D-3CD255D89593")
interface ITsSbResourceNotification : IUnknown
{
    HRESULT NotifySessionChange(TSSESSION_STATE changeType, ITsSbSession pSession);
    HRESULT NotifyTargetChange(uint TargetChangeType, ITsSbTarget pTarget);
    HRESULT NotifyClientConnectionStateChange(CONNECTION_CHANGE_NOTIFICATION ChangeType, 
                                              ITsSbClientConnection pConnection);
}

@GUID("A8A47FDE-CA91-44D2-B897-3AA28A43B2B7")
interface ITsSbResourceNotificationEx : IUnknown
{
    HRESULT NotifySessionChangeEx(BSTR targetName, BSTR userName, BSTR domain, uint sessionId, 
                                  TSSESSION_STATE sessionState);
    HRESULT NotifyTargetChangeEx(BSTR targetName, uint targetChangeType);
    HRESULT NotifyClientConnectionStateChangeEx(BSTR userName, BSTR domain, BSTR initialProgram, BSTR poolName, 
                                                BSTR targetName, CONNECTION_CHANGE_NOTIFICATION connectionChangeType);
}

@GUID("523D1083-89BE-48DD-99EA-04E82FFA7265")
interface ITsSbTaskInfo : IUnknown
{
    HRESULT get_TargetId(BSTR* pName);
    HRESULT get_StartTime(FILETIME* pStartTime);
    HRESULT get_EndTime(FILETIME* pEndTime);
    HRESULT get_Deadline(FILETIME* pDeadline);
    HRESULT get_Identifier(BSTR* pIdentifier);
    HRESULT get_Label(BSTR* pLabel);
    HRESULT get_Context(SAFEARRAY** pContext);
    HRESULT get_Plugin(BSTR* pPlugin);
    HRESULT get_Status(RDV_TASK_STATUS* pStatus);
}

@GUID("FA22EF0F-8705-41BE-93BC-44BDBCF1C9C4")
interface ITsSbTaskPlugin : ITsSbPlugin
{
    HRESULT InitializeTaskPlugin(ITsSbTaskPluginNotifySink pITsSbTaskPluginNotifySink);
    HRESULT SetTaskQueue(BSTR pszHostName, uint SbTaskInfoSize, char* pITsSbTaskInfo);
}

@GUID("5C025171-BB1E-4BAF-A212-6D5E9774B33B")
interface ITsSbPropertySet : IPropertyBag
{
}

@GUID("95006E34-7EFF-4B6C-BB40-49A4FDA7CEA6")
interface ITsSbPluginPropertySet : ITsSbPropertySet
{
}

@GUID("E51995B0-46D6-11DD-AA21-CEDC55D89593")
interface ITsSbClientConnectionPropertySet : ITsSbPropertySet
{
}

@GUID("F7BDA5D6-994C-4E11-A079-2763B61830AC")
interface ITsSbTargetPropertySet : ITsSbPropertySet
{
}

@GUID("D0D1BF7E-7ACF-11DD-A243-E51156D89593")
interface ITsSbEnvironmentPropertySet : ITsSbPropertySet
{
}

@GUID("808A6537-1282-4989-9E09-F43938B71722")
interface ITsSbBaseNotifySink : IUnknown
{
    HRESULT OnError(HRESULT hrError);
    HRESULT OnReportStatus(CLIENT_MESSAGE_TYPE messageType, uint messageID);
}

@GUID("44DFE30B-C3BE-40F5-BF82-7A95BB795ADF")
interface ITsSbPluginNotifySink : ITsSbBaseNotifySink
{
    HRESULT OnInitialized(HRESULT hr);
    HRESULT OnTerminated();
}

@GUID("5F8A8297-3244-4E6A-958A-27C822C1E141")
interface ITsSbLoadBalancingNotifySink : ITsSbBaseNotifySink
{
    HRESULT OnGetMostSuitableTarget(ITsSbLoadBalanceResult pLBResult, BOOL fIsNewConnection);
}

@GUID("68A0C487-2B4F-46C2-94A1-6CE685183634")
interface ITsSbPlacementNotifySink : ITsSbBaseNotifySink
{
    HRESULT OnQueryEnvironmentCompleted(ITsSbEnvironment pEnvironment);
}

@GUID("36C37D61-926B-442F-BCA5-118C6D50DCF2")
interface ITsSbOrchestrationNotifySink : ITsSbBaseNotifySink
{
    HRESULT OnReadyToConnect(ITsSbTarget pTarget);
}

@GUID("6AAF899E-C2EC-45EE-AA37-45E60895261A")
interface ITsSbTaskPluginNotifySink : ITsSbBaseNotifySink
{
    HRESULT OnSetTaskTime(BSTR szTargetName, FILETIME TaskStartTime, FILETIME TaskEndTime, FILETIME TaskDeadline, 
                          BSTR szTaskLabel, BSTR szTaskIdentifier, BSTR szTaskPlugin, uint dwTaskStatus, 
                          SAFEARRAY* saContext);
    HRESULT OnDeleteTaskTime(BSTR szTargetName, BSTR szTaskIdentifier);
    HRESULT OnUpdateTaskStatus(BSTR szTargetName, BSTR TaskIdentifier, RDV_TASK_STATUS TaskStatus);
    HRESULT OnReportTasks(BSTR szHostName);
}

@GUID("18857499-AD61-4B1B-B7DF-CBCD41FB8338")
interface ITsSbClientConnection : IUnknown
{
    HRESULT get_UserName(BSTR* pVal);
    HRESULT get_Domain(BSTR* pVal);
    HRESULT get_InitialProgram(BSTR* pVal);
    HRESULT get_LoadBalanceResult(ITsSbLoadBalanceResult* ppVal);
    HRESULT get_FarmName(BSTR* pVal);
    HRESULT PutContext(BSTR contextId, VARIANT context, VARIANT* existingContext);
    HRESULT GetContext(BSTR contextId, VARIANT* context);
    HRESULT get_Environment(ITsSbEnvironment* ppEnvironment);
    HRESULT get_ConnectionError();
    HRESULT get_SamUserAccount(BSTR* pVal);
    HRESULT get_ClientConnectionPropertySet(ITsSbClientConnectionPropertySet* ppPropertySet);
    HRESULT get_IsFirstAssignment(int* ppVal);
    HRESULT get_RdFarmType(RD_FARM_TYPE* pRdFarmType);
    HRESULT get_UserSidString(byte** pszUserSidString);
    HRESULT GetDisconnectedSession(ITsSbSession* ppSession);
}

@GUID("87A4098F-6D7B-44DD-BC17-8CE44E370D52")
interface ITsSbProvider : IUnknown
{
    HRESULT CreateTargetObject(BSTR TargetName, BSTR EnvironmentName, ITsSbTarget* ppTarget);
    HRESULT CreateLoadBalanceResultObject(BSTR TargetName, ITsSbLoadBalanceResult* ppLBResult);
    HRESULT CreateSessionObject(BSTR TargetName, BSTR UserName, BSTR Domain, uint SessionId, 
                                ITsSbSession* ppSession);
    HRESULT CreatePluginPropertySet(ITsSbPluginPropertySet* ppPropertySet);
    HRESULT CreateTargetPropertySetObject(ITsSbTargetPropertySet* ppPropertySet);
    HRESULT CreateEnvironmentObject(BSTR Name, uint ServerWeight, ITsSbEnvironment* ppEnvironment);
    HRESULT GetResourcePluginStore(ITsSbResourcePluginStore* ppStore);
    HRESULT GetFilterPluginStore(ITsSbFilterPluginStore* ppStore);
    HRESULT RegisterForNotification(uint notificationType, BSTR ResourceToMonitor, 
                                    ITsSbResourceNotification pPluginNotification);
    HRESULT UnRegisterForNotification(uint notificationType, BSTR ResourceToMonitor);
    HRESULT GetInstanceOfGlobalStore(ITsSbGlobalStore* ppGlobalStore);
    HRESULT CreateEnvironmentPropertySetObject(ITsSbEnvironmentPropertySet* ppPropertySet);
}

@GUID("5C38F65F-BCF1-4036-A6BF-9E3CCCAE0B63")
interface ITsSbResourcePluginStore : IUnknown
{
    HRESULT QueryTarget(BSTR TargetName, BSTR FarmName, ITsSbTarget* ppTarget);
    HRESULT QuerySessionBySessionId(uint dwSessionId, BSTR TargetName, ITsSbSession* ppSession);
    HRESULT AddTargetToStore(ITsSbTarget pTarget);
    HRESULT AddSessionToStore(ITsSbSession pSession);
    HRESULT AddEnvironmentToStore(ITsSbEnvironment pEnvironment);
    HRESULT RemoveEnvironmentFromStore(BSTR EnvironmentName, BOOL bIgnoreOwner);
    HRESULT EnumerateFarms(uint* pdwCount, SAFEARRAY** pVal);
    HRESULT QueryEnvironment(BSTR EnvironmentName, ITsSbEnvironment* ppEnvironment);
    HRESULT EnumerateEnvironments(uint* pdwCount, char* pVal);
    HRESULT SaveTarget(ITsSbTarget pTarget, BOOL bForceWrite);
    HRESULT SaveEnvironment(ITsSbEnvironment pEnvironment, BOOL bForceWrite);
    HRESULT SaveSession(ITsSbSession pSession);
    HRESULT SetTargetProperty(BSTR TargetName, BSTR PropertyName, VARIANT* pProperty);
    HRESULT SetEnvironmentProperty(BSTR EnvironmentName, BSTR PropertyName, VARIANT* pProperty);
    HRESULT SetTargetState(BSTR targetName, TARGET_STATE newState, TARGET_STATE* pOldState);
    HRESULT SetSessionState(ITsSbSession sbSession);
    HRESULT EnumerateTargets(BSTR FarmName, BSTR EnvName, TS_SB_SORT_BY sortByFieldId, BSTR sortyByPropName, 
                             uint* pdwCount, char* pVal);
    HRESULT EnumerateSessions(BSTR targetName, BSTR userName, BSTR userDomain, BSTR poolName, BSTR initialProgram, 
                              TSSESSION_STATE* pSessionState, uint* pdwCount, char* ppVal);
    HRESULT GetFarmProperty(BSTR farmName, BSTR propertyName, VARIANT* pVarValue);
    HRESULT DeleteTarget(BSTR targetName, BSTR hostName);
    HRESULT SetTargetPropertyWithVersionCheck(ITsSbTarget pTarget, BSTR PropertyName, VARIANT* pProperty);
    HRESULT SetEnvironmentPropertyWithVersionCheck(ITsSbEnvironment pEnvironment, BSTR PropertyName, 
                                                   VARIANT* pProperty);
    HRESULT AcquireTargetLock(BSTR targetName, uint dwTimeout, IUnknown* ppContext);
    HRESULT ReleaseTargetLock(IUnknown pContext);
    HRESULT TestAndSetServerState(BSTR PoolName, BSTR ServerFQDN, TARGET_STATE NewState, TARGET_STATE TestState, 
                                  TARGET_STATE* pInitState);
    HRESULT SetServerWaitingToStart(BSTR PoolName, BSTR serverName);
    HRESULT GetServerState(BSTR PoolName, BSTR ServerFQDN, TARGET_STATE* pState);
    HRESULT SetServerDrainMode(BSTR ServerFQDN, uint DrainMode);
}

@GUID("85B44B0F-ED78-413F-9702-FA6D3B5EE755")
interface ITsSbFilterPluginStore : IUnknown
{
    HRESULT SaveProperties(ITsSbPropertySet pPropertySet);
    HRESULT EnumerateProperties(ITsSbPropertySet* ppPropertySet);
    HRESULT DeleteProperties(BSTR propertyName);
}

@GUID("9AB60F7B-BD72-4D9F-8A3A-A0EA5574E635")
interface ITsSbGlobalStore : IUnknown
{
    HRESULT QueryTarget(BSTR ProviderName, BSTR TargetName, BSTR FarmName, ITsSbTarget* ppTarget);
    HRESULT QuerySessionBySessionId(BSTR ProviderName, uint dwSessionId, BSTR TargetName, ITsSbSession* ppSession);
    HRESULT EnumerateFarms(BSTR ProviderName, uint* pdwCount, SAFEARRAY** pVal);
    HRESULT EnumerateTargets(BSTR ProviderName, BSTR FarmName, BSTR EnvName, uint* pdwCount, char* pVal);
    HRESULT EnumerateEnvironmentsByProvider(BSTR ProviderName, uint* pdwCount, char* ppVal);
    HRESULT EnumerateSessions(BSTR ProviderName, BSTR targetName, BSTR userName, BSTR userDomain, BSTR poolName, 
                              BSTR initialProgram, TSSESSION_STATE* pSessionState, uint* pdwCount, char* ppVal);
    HRESULT GetFarmProperty(BSTR farmName, BSTR propertyName, VARIANT* pVarValue);
}

@GUID("ACA87A8E-818B-4581-A032-49C3DFB9C701")
interface ITsSbProvisioningPluginNotifySink : IUnknown
{
    HRESULT OnJobCreated(VM_NOTIFY_INFO* pVmNotifyInfo);
    HRESULT OnVirtualMachineStatusChanged(VM_NOTIFY_ENTRY* pVmNotifyEntry, VM_NOTIFY_STATUS VmNotifyStatus, 
                                          HRESULT ErrorCode, BSTR ErrorDescr);
    HRESULT OnJobCompleted(HRESULT ResultCode, BSTR ResultDescription);
    HRESULT OnJobCancelled();
    HRESULT LockVirtualMachine(VM_NOTIFY_ENTRY* pVmNotifyEntry);
    HRESULT OnVirtualMachineHostStatusChanged(BSTR VmHost, VM_HOST_NOTIFY_STATUS VmHostNotifyStatus, 
                                              HRESULT ErrorCode, BSTR ErrorDescr);
}

@GUID("2F6F0DBB-9E4F-462B-9C3F-FCCC3DCB6232")
interface ITsSbProvisioning : ITsSbPlugin
{
    HRESULT CreateVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink);
    HRESULT PatchVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink, 
                                 VM_PATCH_INFO* pVMPatchInfo);
    HRESULT DeleteVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink);
    HRESULT CancelJob(BSTR JobGuid);
}

@GUID("4C4C8C4F-300B-46AD-9164-8468A7E7568C")
interface ITsSbGenericNotifySink : IUnknown
{
    HRESULT OnCompleted(HRESULT Status);
    HRESULT GetWaitTimeout(FILETIME* pftTimeout);
}

@GUID("70C04B05-F347-412B-822F-36C99C54CA45")
interface ItsPubPlugin : IUnknown
{
    HRESULT GetResourceList(const(wchar)* userID, int* pceAppListSize, pluginResource** resourceList);
    HRESULT GetResource(const(wchar)* alias_, int flags, pluginResource* resource);
    HRESULT GetCacheLastUpdateTime(ulong* lastUpdateTime);
    HRESULT get_pluginName(BSTR* pVal);
    HRESULT get_pluginVersion(BSTR* pVal);
    HRESULT ResolveResource(uint* resourceType, char* resourceLocation, char* endPointName, ushort* userID, 
                            ushort* alias_);
}

@GUID("FA4CE418-AAD7-4EC6-BAD1-0A321BA465D5")
interface ItsPubPlugin2 : ItsPubPlugin
{
    HRESULT GetResource2List(const(wchar)* userID, int* pceAppListSize, pluginResource2** resourceList);
    HRESULT GetResource2(const(wchar)* alias_, int flags, pluginResource2* resource);
    HRESULT ResolvePersonalDesktop(const(ushort)* userId, const(ushort)* poolId, 
                                   TSPUB_PLUGIN_PD_RESOLUTION_TYPE ePdResolutionType, 
                                   TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE* pPdAssignmentType, char* endPointName);
    HRESULT DeletePersonalDesktopAssignment(const(ushort)* userId, const(ushort)* poolId, 
                                            const(ushort)* endpointName);
}

@GUID("1D428C79-6E2E-4351-A361-C0401A03A0BA")
interface IWorkspaceResTypeRegistry : IDispatch
{
    HRESULT AddResourceType(short fMachineWide, BSTR bstrFileExtension, BSTR bstrLauncher);
    HRESULT DeleteResourceType(short fMachineWide, BSTR bstrFileExtension);
    HRESULT GetRegisteredFileExtensions(short fMachineWide, SAFEARRAY** psaFileExtensions);
    HRESULT GetResourceTypeInfo(short fMachineWide, BSTR bstrFileExtension, BSTR* pbstrLauncher);
    HRESULT ModifyResourceType(short fMachineWide, BSTR bstrFileExtension, BSTR bstrLauncher);
}

@GUID("A1230201-1439-4E62-A414-190D0AC3D40E")
interface IWTSPlugin : IUnknown
{
    HRESULT Initialize(IWTSVirtualChannelManager pChannelMgr);
    HRESULT Connected();
    HRESULT Disconnected(uint dwDisconnectCode);
    HRESULT Terminated();
}

@GUID("A1230206-9A39-4D58-8674-CDB4DFF4E73B")
interface IWTSListener : IUnknown
{
    HRESULT GetConfiguration(IPropertyBag* ppPropertyBag);
}

@GUID("A1230203-D6A7-11D8-B9FD-000BDBD1F198")
interface IWTSListenerCallback : IUnknown
{
    HRESULT OnNewChannelConnection(IWTSVirtualChannel pChannel, BSTR data, int* pbAccept, 
                                   IWTSVirtualChannelCallback* ppCallback);
}

@GUID("A1230204-D6A7-11D8-B9FD-000BDBD1F198")
interface IWTSVirtualChannelCallback : IUnknown
{
    HRESULT OnDataReceived(uint cbSize, char* pBuffer);
    HRESULT OnClose();
}

@GUID("A1230205-D6A7-11D8-B9FD-000BDBD1F198")
interface IWTSVirtualChannelManager : IUnknown
{
    HRESULT CreateListener(const(byte)* pszChannelName, uint uFlags, IWTSListenerCallback pListenerCallback, 
                           IWTSListener* ppListener);
}

@GUID("A1230207-D6A7-11D8-B9FD-000BDBD1F198")
interface IWTSVirtualChannel : IUnknown
{
    HRESULT Write(uint cbSize, char* pBuffer, IUnknown pReserved);
    HRESULT Close();
}

@GUID("D3E07363-087C-476C-86A7-DBB15F46DDB4")
interface IWTSPluginServiceProvider : IUnknown
{
    HRESULT GetService(GUID ServiceId, IUnknown* ppunkObject);
}

@GUID("5B7ACC97-F3C9-46F7-8C5B-FA685D3441B1")
interface IWTSBitmapRenderer : IUnknown
{
    HRESULT Render(GUID imageFormat, uint dwWidth, uint dwHeight, int cbStride, uint cbImageBuffer, 
                   char* pImageBuffer);
    HRESULT GetRendererStatistics(BITMAP_RENDERER_STATISTICS* pStatistics);
    HRESULT RemoveMapping();
}

@GUID("D782928E-FE4E-4E77-AE90-9CD0B3E3B353")
interface IWTSBitmapRendererCallback : IUnknown
{
    HRESULT OnTargetSizeChanged(RECT rcNewSize);
}

@GUID("EA326091-05FE-40C1-B49C-3D2EF4626A0E")
interface IWTSBitmapRenderService : IUnknown
{
    HRESULT GetMappedRenderer(ulong mappingId, IWTSBitmapRendererCallback pMappedRendererCallback, 
                              IWTSBitmapRenderer* ppMappedRenderer);
}

@GUID("67F2368C-D674-4FAE-66A5-D20628A640D2")
interface IWRdsGraphicsChannelEvents : IUnknown
{
    HRESULT OnDataReceived(uint cbSize, ubyte* pBuffer);
    HRESULT OnClose();
    HRESULT OnChannelOpened(HRESULT OpenResult, IUnknown pOpenContext);
    HRESULT OnDataSent(IUnknown pWriteContext, BOOL bCancelled, ubyte* pBuffer, uint cbBuffer);
    HRESULT OnMetricsUpdate(uint bandwidth, uint RTT, ulong lastSentByteIndex);
}

@GUID("684B7A0B-EDFF-43AD-D5A2-4A8D5388F401")
interface IWRdsGraphicsChannel : IUnknown
{
    HRESULT Write(uint cbSize, ubyte* pBuffer, IUnknown pContext);
    HRESULT Close();
    HRESULT Open(IWRdsGraphicsChannelEvents pChannelEvents, IUnknown pOpenContext);
}

@GUID("0FD57159-E83E-476A-A8B9-4A7976E71E18")
interface IWRdsGraphicsChannelManager : IUnknown
{
    HRESULT CreateChannel(const(byte)* pszChannelName, WRdsGraphicsChannelType channelType, 
                          IWRdsGraphicsChannel* ppVirtualChannel);
}

@GUID("F9EAF6CC-ED79-4F01-821D-1F881B9F66CC")
interface IWTSProtocolManager : IUnknown
{
    HRESULT CreateListener(ushort* wszListenerName, IWTSProtocolListener* pProtocolListener);
    HRESULT NotifyServiceStateChange(WTS_SERVICE_STATE* pTSServiceStateChange);
    HRESULT NotifySessionOfServiceStart(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionOfServiceStop(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionStateChange(WTS_SESSION_ID* SessionId, uint EventId);
}

@GUID("23083765-45F0-4394-8F69-32B2BC0EF4CA")
interface IWTSProtocolListener : IUnknown
{
    HRESULT StartListen(IWTSProtocolListenerCallback pCallback);
    HRESULT StopListen();
}

@GUID("23083765-1A2D-4DE2-97DE-4A35F260F0B3")
interface IWTSProtocolListenerCallback : IUnknown
{
    HRESULT OnConnected(IWTSProtocolConnection pConnection, IWTSProtocolConnectionCallback* pCallback);
}

@GUID("23083765-9095-4648-98BF-EF81C914032D")
interface IWTSProtocolConnection : IUnknown
{
    HRESULT GetLogonErrorRedirector(IWTSProtocolLogonErrorRedirector* ppLogonErrorRedir);
    HRESULT SendPolicyData(WTS_POLICY_DATA* pPolicyData);
    HRESULT AcceptConnection();
    HRESULT GetClientData(WTS_CLIENT_DATA* pClientData);
    HRESULT GetUserCredentials(WTS_USER_CREDENTIAL* pUserCreds);
    HRESULT GetLicenseConnection(IWTSProtocolLicenseConnection* ppLicenseConnection);
    HRESULT AuthenticateClientToSession(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionId(WTS_SESSION_ID* SessionId);
    HRESULT GetProtocolHandles(size_t* pKeyboardHandle, size_t* pMouseHandle, size_t* pBeepHandle, 
                               size_t* pVideoHandle);
    HRESULT ConnectNotify(uint SessionId);
    HRESULT IsUserAllowedToLogon(uint SessionId, size_t UserToken, ushort* pDomainName, ushort* pUserName);
    HRESULT SessionArbitrationEnumeration(size_t hUserToken, BOOL bSingleSessionPerUserEnabled, 
                                          char* pSessionIdArray, uint* pdwSessionIdentifierCount);
    HRESULT LogonNotify(size_t hClientToken, ushort* wszUserName, ushort* wszDomainName, WTS_SESSION_ID* SessionId);
    HRESULT GetUserData(WTS_POLICY_DATA* pPolicyData, WTS_USER_DATA* pClientData);
    HRESULT DisconnectNotify();
    HRESULT Close();
    HRESULT GetProtocolStatus(WTS_PROTOCOL_STATUS* pProtocolStatus);
    HRESULT GetLastInputTime(ulong* pLastInputTime);
    HRESULT SetErrorInfo(uint ulError);
    HRESULT SendBeep(uint Frequency, uint Duration);
    HRESULT CreateVirtualChannel(byte* szEndpointName, BOOL bStatic, uint RequestedPriority, size_t* phChannel);
    HRESULT QueryProperty(GUID QueryType, uint ulNumEntriesIn, uint ulNumEntriesOut, char* pPropertyEntriesIn, 
                          char* pPropertyEntriesOut);
    HRESULT GetShadowConnection(IWTSProtocolShadowConnection* ppShadowConnection);
}

@GUID("23083765-75EB-41FE-B4FB-E086242AFA0F")
interface IWTSProtocolConnectionCallback : IUnknown
{
    HRESULT OnReady();
    HRESULT BrokenConnection(uint Reason, uint Source);
    HRESULT StopScreenUpdates();
    HRESULT RedrawWindow(WTS_SMALL_RECT* rect);
    HRESULT DisplayIOCtl(WTS_DISPLAY_IOCTL* DisplayIOCtl);
}

@GUID("EE3B0C14-37FB-456B-BAB3-6D6CD51E13BF")
interface IWTSProtocolShadowConnection : IUnknown
{
    HRESULT Start(ushort* pTargetServerName, uint TargetSessionId, ubyte HotKeyVk, ushort HotkeyModifiers, 
                  IWTSProtocolShadowCallback pShadowCallback);
    HRESULT Stop();
    HRESULT DoTarget(char* pParam1, uint Param1Size, char* pParam2, uint Param2Size, char* pParam3, 
                     uint Param3Size, char* pParam4, uint Param4Size, ushort* pClientName);
}

@GUID("503A2504-AAE5-4AB1-93E0-6D1C4BC6F71A")
interface IWTSProtocolShadowCallback : IUnknown
{
    HRESULT StopShadow();
    HRESULT InvokeTargetShadow(ushort* pTargetServerName, uint TargetSessionId, char* pParam1, uint Param1Size, 
                               char* pParam2, uint Param2Size, char* pParam3, uint Param3Size, char* pParam4, 
                               uint Param4Size, ushort* pClientName);
}

@GUID("23083765-178C-4079-8E4A-FEA6496A4D70")
interface IWTSProtocolLicenseConnection : IUnknown
{
    HRESULT RequestLicensingCapabilities(WTS_LICENSE_CAPABILITIES* ppLicenseCapabilities, 
                                         uint* pcbLicenseCapabilities);
    HRESULT SendClientLicense(char* pClientLicense, uint cbClientLicense);
    HRESULT RequestClientLicense(char* Reserve1, uint Reserve2, char* ppClientLicense, uint* pcbClientLicense);
    HRESULT ProtocolComplete(uint ulComplete);
}

@GUID("FD9B61A7-2916-4627-8DEE-4328711AD6CB")
interface IWTSProtocolLogonErrorRedirector : IUnknown
{
    HRESULT OnBeginPainting();
    HRESULT RedirectStatus(const(wchar)* pszMessage, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    HRESULT RedirectMessage(const(wchar)* pszCaption, const(wchar)* pszMessage, uint uType, 
                            WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    HRESULT RedirectLogonError(int ntsStatus, int ntsSubstatus, const(wchar)* pszCaption, const(wchar)* pszMessage, 
                               uint uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
}

@GUID("0FAD5DCF-C6D3-423C-B097-163D6A676151")
interface IWRdsRemoteFXGraphicsConnection : IUnknown
{
    HRESULT EnableRemoteFXGraphics(int* pEnableRemoteFXGraphics);
    HRESULT GetVirtualChannelTransport(IUnknown* ppTransport);
}

@GUID("654A5A6A-2550-47EB-B6F7-EBD637475265")
interface IWRdsProtocolSettings : IUnknown
{
    HRESULT GetSettings(WRDS_SETTING_TYPE WRdsSettingType, WRDS_SETTING_LEVEL WRdsSettingLevel, 
                        WRDS_SETTINGS* pWRdsSettings);
    HRESULT MergeSettings(WRDS_SETTINGS* pWRdsSettings, WRDS_CONNECTION_SETTING_LEVEL WRdsConnectionSettingLevel, 
                          WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings);
}

@GUID("DC796967-3ABB-40CD-A446-105276B58950")
interface IWRdsProtocolManager : IUnknown
{
    HRESULT Initialize(IWRdsProtocolSettings pIWRdsSettings, WRDS_SETTINGS* pWRdsSettings);
    HRESULT CreateListener(ushort* wszListenerName, IWRdsProtocolListener* pProtocolListener);
    HRESULT NotifyServiceStateChange(WTS_SERVICE_STATE* pTSServiceStateChange);
    HRESULT NotifySessionOfServiceStart(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionOfServiceStop(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionStateChange(WTS_SESSION_ID* SessionId, uint EventId);
    HRESULT NotifySettingsChange(WRDS_SETTINGS* pWRdsSettings);
    HRESULT Uninitialize();
}

@GUID("FCBC131B-C686-451D-A773-E279E230F540")
interface IWRdsProtocolListener : IUnknown
{
    HRESULT GetSettings(WRDS_LISTENER_SETTING_LEVEL WRdsListenerSettingLevel, 
                        WRDS_LISTENER_SETTINGS* pWRdsListenerSettings);
    HRESULT StartListen(IWRdsProtocolListenerCallback pCallback);
    HRESULT StopListen();
}

@GUID("3AB27E5B-4449-4DC1-B74A-91621D4FE984")
interface IWRdsProtocolListenerCallback : IUnknown
{
    HRESULT OnConnected(IWRdsProtocolConnection pConnection, WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings, 
                        IWRdsProtocolConnectionCallback* pCallback);
}

@GUID("324ED94F-FDAF-4FF6-81A8-42ABE755830B")
interface IWRdsProtocolConnection : IUnknown
{
    HRESULT GetLogonErrorRedirector(IWRdsProtocolLogonErrorRedirector* ppLogonErrorRedir);
    HRESULT AcceptConnection();
    HRESULT GetClientData(WTS_CLIENT_DATA* pClientData);
    HRESULT GetClientMonitorData(uint* pNumMonitors, uint* pPrimaryMonitor);
    HRESULT GetUserCredentials(WTS_USER_CREDENTIAL* pUserCreds);
    HRESULT GetLicenseConnection(IWRdsProtocolLicenseConnection* ppLicenseConnection);
    HRESULT AuthenticateClientToSession(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionId(WTS_SESSION_ID* SessionId, size_t SessionHandle);
    HRESULT GetInputHandles(size_t* pKeyboardHandle, size_t* pMouseHandle, size_t* pBeepHandle);
    HRESULT GetVideoHandle(size_t* pVideoHandle);
    HRESULT ConnectNotify(uint SessionId);
    HRESULT IsUserAllowedToLogon(uint SessionId, size_t UserToken, ushort* pDomainName, ushort* pUserName);
    HRESULT SessionArbitrationEnumeration(size_t hUserToken, BOOL bSingleSessionPerUserEnabled, 
                                          char* pSessionIdArray, uint* pdwSessionIdentifierCount);
    HRESULT LogonNotify(size_t hClientToken, ushort* wszUserName, ushort* wszDomainName, WTS_SESSION_ID* SessionId, 
                        WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings);
    HRESULT PreDisconnect(uint DisconnectReason);
    HRESULT DisconnectNotify();
    HRESULT Close();
    HRESULT GetProtocolStatus(WTS_PROTOCOL_STATUS* pProtocolStatus);
    HRESULT GetLastInputTime(ulong* pLastInputTime);
    HRESULT SetErrorInfo(uint ulError);
    HRESULT CreateVirtualChannel(byte* szEndpointName, BOOL bStatic, uint RequestedPriority, size_t* phChannel);
    HRESULT QueryProperty(GUID QueryType, uint ulNumEntriesIn, uint ulNumEntriesOut, char* pPropertyEntriesIn, 
                          char* pPropertyEntriesOut);
    HRESULT GetShadowConnection(IWRdsProtocolShadowConnection* ppShadowConnection);
    HRESULT NotifyCommandProcessCreated(uint SessionId);
}

@GUID("F1D70332-D070-4EF1-A088-78313536C2D6")
interface IWRdsProtocolConnectionCallback : IUnknown
{
    HRESULT OnReady();
    HRESULT BrokenConnection(uint Reason, uint Source);
    HRESULT StopScreenUpdates();
    HRESULT RedrawWindow(WTS_SMALL_RECT* rect);
    HRESULT GetConnectionId(uint* pConnectionId);
}

@GUID("9AE85CE6-CADE-4548-8FEB-99016597F60A")
interface IWRdsProtocolShadowConnection : IUnknown
{
    HRESULT Start(ushort* pTargetServerName, uint TargetSessionId, ubyte HotKeyVk, ushort HotkeyModifiers, 
                  IWRdsProtocolShadowCallback pShadowCallback);
    HRESULT Stop();
    HRESULT DoTarget(char* pParam1, uint Param1Size, char* pParam2, uint Param2Size, char* pParam3, 
                     uint Param3Size, char* pParam4, uint Param4Size, ushort* pClientName);
}

@GUID("E0667CE0-0372-40D6-ADB2-A0F3322674D6")
interface IWRdsProtocolShadowCallback : IUnknown
{
    HRESULT StopShadow();
    HRESULT InvokeTargetShadow(ushort* pTargetServerName, uint TargetSessionId, char* pParam1, uint Param1Size, 
                               char* pParam2, uint Param2Size, char* pParam3, uint Param3Size, char* pParam4, 
                               uint Param4Size, ushort* pClientName);
}

@GUID("1D6A145F-D095-4424-957A-407FAE822D84")
interface IWRdsProtocolLicenseConnection : IUnknown
{
    HRESULT RequestLicensingCapabilities(WTS_LICENSE_CAPABILITIES* ppLicenseCapabilities, 
                                         uint* pcbLicenseCapabilities);
    HRESULT SendClientLicense(char* pClientLicense, uint cbClientLicense);
    HRESULT RequestClientLicense(char* Reserve1, uint Reserve2, char* ppClientLicense, uint* pcbClientLicense);
    HRESULT ProtocolComplete(uint ulComplete);
}

@GUID("519FE83B-142A-4120-A3D5-A405D315281A")
interface IWRdsProtocolLogonErrorRedirector : IUnknown
{
    HRESULT OnBeginPainting();
    HRESULT RedirectStatus(const(wchar)* pszMessage, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    HRESULT RedirectMessage(const(wchar)* pszCaption, const(wchar)* pszMessage, uint uType, 
                            WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    HRESULT RedirectLogonError(int ntsStatus, int ntsSubstatus, const(wchar)* pszCaption, const(wchar)* pszMessage, 
                               uint uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
}

@GUID("1382DF4D-A289-43D1-A184-144726F9AF90")
interface IWRdsWddmIddProps : IUnknown
{
    HRESULT GetHardwareId(char* pDisplayDriverHardwareId, uint Count);
    HRESULT OnDriverLoad(uint SessionId, size_t DriverHandle);
    HRESULT OnDriverUnload(uint SessionId);
    HRESULT EnableWddmIdd(BOOL Enabled);
}

@GUID("83FCF5D3-F6F4-EA94-9CD2-32F280E1E510")
interface IWRdsProtocolConnectionSettings : IUnknown
{
    HRESULT SetConnectionSetting(GUID PropertyID, WTS_PROPERTY_VALUE* pPropertyEntriesIn);
    HRESULT GetConnectionSetting(GUID PropertyID, WTS_PROPERTY_VALUE* pPropertyEntriesOut);
}

@GUID("48A0F2A7-2713-431F-BBAC-6F4558E7D64D")
interface IRemoteDesktopClientSettings : IDispatch
{
    HRESULT ApplySettings(BSTR rdpFileContents);
    HRESULT RetrieveSettings(BSTR* rdpFileContents);
    HRESULT GetRdpProperty(BSTR propertyName, VARIANT* value);
    HRESULT SetRdpProperty(BSTR propertyName, VARIANT value);
}

@GUID("7D54BC4E-1028-45D4-8B0A-B9B6BFFBA176")
interface IRemoteDesktopClientActions : IDispatch
{
    HRESULT SuspendScreenUpdates();
    HRESULT ResumeScreenUpdates();
    HRESULT ExecuteRemoteAction(RemoteActionType remoteAction);
    HRESULT GetSnapshot(SnapshotEncodingType snapshotEncoding, SnapshotFormatType snapshotFormat, 
                        uint snapshotWidth, uint snapshotHeight, BSTR* snapshotData);
}

@GUID("260EC22D-8CBC-44B5-9E88-2A37F6C93AE9")
interface IRemoteDesktopClientTouchPointer : IDispatch
{
    HRESULT put_Enabled(short enabled);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_EventsEnabled(short eventsEnabled);
    HRESULT get_EventsEnabled(short* eventsEnabled);
    HRESULT put_PointerSpeed(uint pointerSpeed);
    HRESULT get_PointerSpeed(uint* pointerSpeed);
}

@GUID("57D25668-625A-4905-BE4E-304CAA13F89C")
interface IRemoteDesktopClient : IDispatch
{
    HRESULT Connect();
    HRESULT Disconnect();
    HRESULT Reconnect(uint width, uint height);
    HRESULT get_Settings(IRemoteDesktopClientSettings* settings);
    HRESULT get_Actions(IRemoteDesktopClientActions* actions);
    HRESULT get_TouchPointer(IRemoteDesktopClientTouchPointer* touchPointer);
    HRESULT DeleteSavedCredentials(BSTR serverName);
    HRESULT UpdateSessionDisplaySettings(uint width, uint height);
    HRESULT attachEvent(BSTR eventName, IDispatch callback);
    HRESULT detachEvent(BSTR eventName, IDispatch callback);
}


// GUIDs

const GUID CLSID_ADsTSUserEx        = GUIDOF!ADsTSUserEx;
const GUID CLSID_TSUserExInterfaces = GUIDOF!TSUserExInterfaces;
const GUID CLSID_Workspace          = GUIDOF!Workspace;

const GUID IID_IADsTSUserEx                      = GUIDOF!IADsTSUserEx;
const GUID IID_IAudioDeviceEndpoint              = GUIDOF!IAudioDeviceEndpoint;
const GUID IID_IAudioEndpoint                    = GUIDOF!IAudioEndpoint;
const GUID IID_IAudioEndpointControl             = GUIDOF!IAudioEndpointControl;
const GUID IID_IAudioEndpointRT                  = GUIDOF!IAudioEndpointRT;
const GUID IID_IAudioInputEndpointRT             = GUIDOF!IAudioInputEndpointRT;
const GUID IID_IAudioOutputEndpointRT            = GUIDOF!IAudioOutputEndpointRT;
const GUID IID_IRemoteDesktopClient              = GUIDOF!IRemoteDesktopClient;
const GUID IID_IRemoteDesktopClientActions       = GUIDOF!IRemoteDesktopClientActions;
const GUID IID_IRemoteDesktopClientSettings      = GUIDOF!IRemoteDesktopClientSettings;
const GUID IID_IRemoteDesktopClientTouchPointer  = GUIDOF!IRemoteDesktopClientTouchPointer;
const GUID IID_ITSGAccountingEngine              = GUIDOF!ITSGAccountingEngine;
const GUID IID_ITSGAuthenticateUserSink          = GUIDOF!ITSGAuthenticateUserSink;
const GUID IID_ITSGAuthenticationEngine          = GUIDOF!ITSGAuthenticationEngine;
const GUID IID_ITSGAuthorizeConnectionSink       = GUIDOF!ITSGAuthorizeConnectionSink;
const GUID IID_ITSGAuthorizeResourceSink         = GUIDOF!ITSGAuthorizeResourceSink;
const GUID IID_ITSGPolicyEngine                  = GUIDOF!ITSGPolicyEngine;
const GUID IID_ITsSbBaseNotifySink               = GUIDOF!ITsSbBaseNotifySink;
const GUID IID_ITsSbClientConnection             = GUIDOF!ITsSbClientConnection;
const GUID IID_ITsSbClientConnectionPropertySet  = GUIDOF!ITsSbClientConnectionPropertySet;
const GUID IID_ITsSbEnvironment                  = GUIDOF!ITsSbEnvironment;
const GUID IID_ITsSbEnvironmentPropertySet       = GUIDOF!ITsSbEnvironmentPropertySet;
const GUID IID_ITsSbFilterPluginStore            = GUIDOF!ITsSbFilterPluginStore;
const GUID IID_ITsSbGenericNotifySink            = GUIDOF!ITsSbGenericNotifySink;
const GUID IID_ITsSbGlobalStore                  = GUIDOF!ITsSbGlobalStore;
const GUID IID_ITsSbLoadBalanceResult            = GUIDOF!ITsSbLoadBalanceResult;
const GUID IID_ITsSbLoadBalancing                = GUIDOF!ITsSbLoadBalancing;
const GUID IID_ITsSbLoadBalancingNotifySink      = GUIDOF!ITsSbLoadBalancingNotifySink;
const GUID IID_ITsSbOrchestration                = GUIDOF!ITsSbOrchestration;
const GUID IID_ITsSbOrchestrationNotifySink      = GUIDOF!ITsSbOrchestrationNotifySink;
const GUID IID_ITsSbPlacement                    = GUIDOF!ITsSbPlacement;
const GUID IID_ITsSbPlacementNotifySink          = GUIDOF!ITsSbPlacementNotifySink;
const GUID IID_ITsSbPlugin                       = GUIDOF!ITsSbPlugin;
const GUID IID_ITsSbPluginNotifySink             = GUIDOF!ITsSbPluginNotifySink;
const GUID IID_ITsSbPluginPropertySet            = GUIDOF!ITsSbPluginPropertySet;
const GUID IID_ITsSbPropertySet                  = GUIDOF!ITsSbPropertySet;
const GUID IID_ITsSbProvider                     = GUIDOF!ITsSbProvider;
const GUID IID_ITsSbProvisioning                 = GUIDOF!ITsSbProvisioning;
const GUID IID_ITsSbProvisioningPluginNotifySink = GUIDOF!ITsSbProvisioningPluginNotifySink;
const GUID IID_ITsSbResourceNotification         = GUIDOF!ITsSbResourceNotification;
const GUID IID_ITsSbResourceNotificationEx       = GUIDOF!ITsSbResourceNotificationEx;
const GUID IID_ITsSbResourcePlugin               = GUIDOF!ITsSbResourcePlugin;
const GUID IID_ITsSbResourcePluginStore          = GUIDOF!ITsSbResourcePluginStore;
const GUID IID_ITsSbServiceNotification          = GUIDOF!ITsSbServiceNotification;
const GUID IID_ITsSbSession                      = GUIDOF!ITsSbSession;
const GUID IID_ITsSbTarget                       = GUIDOF!ITsSbTarget;
const GUID IID_ITsSbTargetPropertySet            = GUIDOF!ITsSbTargetPropertySet;
const GUID IID_ITsSbTaskInfo                     = GUIDOF!ITsSbTaskInfo;
const GUID IID_ITsSbTaskPlugin                   = GUIDOF!ITsSbTaskPlugin;
const GUID IID_ITsSbTaskPluginNotifySink         = GUIDOF!ITsSbTaskPluginNotifySink;
const GUID IID_IWRdsGraphicsChannel              = GUIDOF!IWRdsGraphicsChannel;
const GUID IID_IWRdsGraphicsChannelEvents        = GUIDOF!IWRdsGraphicsChannelEvents;
const GUID IID_IWRdsGraphicsChannelManager       = GUIDOF!IWRdsGraphicsChannelManager;
const GUID IID_IWRdsProtocolConnection           = GUIDOF!IWRdsProtocolConnection;
const GUID IID_IWRdsProtocolConnectionCallback   = GUIDOF!IWRdsProtocolConnectionCallback;
const GUID IID_IWRdsProtocolConnectionSettings   = GUIDOF!IWRdsProtocolConnectionSettings;
const GUID IID_IWRdsProtocolLicenseConnection    = GUIDOF!IWRdsProtocolLicenseConnection;
const GUID IID_IWRdsProtocolListener             = GUIDOF!IWRdsProtocolListener;
const GUID IID_IWRdsProtocolListenerCallback     = GUIDOF!IWRdsProtocolListenerCallback;
const GUID IID_IWRdsProtocolLogonErrorRedirector = GUIDOF!IWRdsProtocolLogonErrorRedirector;
const GUID IID_IWRdsProtocolManager              = GUIDOF!IWRdsProtocolManager;
const GUID IID_IWRdsProtocolSettings             = GUIDOF!IWRdsProtocolSettings;
const GUID IID_IWRdsProtocolShadowCallback       = GUIDOF!IWRdsProtocolShadowCallback;
const GUID IID_IWRdsProtocolShadowConnection     = GUIDOF!IWRdsProtocolShadowConnection;
const GUID IID_IWRdsRemoteFXGraphicsConnection   = GUIDOF!IWRdsRemoteFXGraphicsConnection;
const GUID IID_IWRdsWddmIddProps                 = GUIDOF!IWRdsWddmIddProps;
const GUID IID_IWTSBitmapRenderService           = GUIDOF!IWTSBitmapRenderService;
const GUID IID_IWTSBitmapRenderer                = GUIDOF!IWTSBitmapRenderer;
const GUID IID_IWTSBitmapRendererCallback        = GUIDOF!IWTSBitmapRendererCallback;
const GUID IID_IWTSListener                      = GUIDOF!IWTSListener;
const GUID IID_IWTSListenerCallback              = GUIDOF!IWTSListenerCallback;
const GUID IID_IWTSPlugin                        = GUIDOF!IWTSPlugin;
const GUID IID_IWTSPluginServiceProvider         = GUIDOF!IWTSPluginServiceProvider;
const GUID IID_IWTSProtocolConnection            = GUIDOF!IWTSProtocolConnection;
const GUID IID_IWTSProtocolConnectionCallback    = GUIDOF!IWTSProtocolConnectionCallback;
const GUID IID_IWTSProtocolLicenseConnection     = GUIDOF!IWTSProtocolLicenseConnection;
const GUID IID_IWTSProtocolListener              = GUIDOF!IWTSProtocolListener;
const GUID IID_IWTSProtocolListenerCallback      = GUIDOF!IWTSProtocolListenerCallback;
const GUID IID_IWTSProtocolLogonErrorRedirector  = GUIDOF!IWTSProtocolLogonErrorRedirector;
const GUID IID_IWTSProtocolManager               = GUIDOF!IWTSProtocolManager;
const GUID IID_IWTSProtocolShadowCallback        = GUIDOF!IWTSProtocolShadowCallback;
const GUID IID_IWTSProtocolShadowConnection      = GUIDOF!IWTSProtocolShadowConnection;
const GUID IID_IWTSSBPlugin                      = GUIDOF!IWTSSBPlugin;
const GUID IID_IWTSVirtualChannel                = GUIDOF!IWTSVirtualChannel;
const GUID IID_IWTSVirtualChannelCallback        = GUIDOF!IWTSVirtualChannelCallback;
const GUID IID_IWTSVirtualChannelManager         = GUIDOF!IWTSVirtualChannelManager;
const GUID IID_IWorkspace                        = GUIDOF!IWorkspace;
const GUID IID_IWorkspace2                       = GUIDOF!IWorkspace2;
const GUID IID_IWorkspace3                       = GUIDOF!IWorkspace3;
const GUID IID_IWorkspaceClientExt               = GUIDOF!IWorkspaceClientExt;
const GUID IID_IWorkspaceRegistration            = GUIDOF!IWorkspaceRegistration;
const GUID IID_IWorkspaceRegistration2           = GUIDOF!IWorkspaceRegistration2;
const GUID IID_IWorkspaceReportMessage           = GUIDOF!IWorkspaceReportMessage;
const GUID IID_IWorkspaceResTypeRegistry         = GUIDOF!IWorkspaceResTypeRegistry;
const GUID IID_IWorkspaceScriptable              = GUIDOF!IWorkspaceScriptable;
const GUID IID_IWorkspaceScriptable2             = GUIDOF!IWorkspaceScriptable2;
const GUID IID_IWorkspaceScriptable3             = GUIDOF!IWorkspaceScriptable3;
const GUID IID_ItsPubPlugin                      = GUIDOF!ItsPubPlugin;
const GUID IID_ItsPubPlugin2                     = GUIDOF!ItsPubPlugin2;
const GUID IID__ITSWkspEvents                    = GUIDOF!_ITSWkspEvents;
