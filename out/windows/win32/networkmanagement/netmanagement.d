// Written in the D programming language.

module windows.win32.networkmanagement.netmanagement;

public import windows.core;
public import windows.win32.data.xml.msxml : IXMLDOMNodeList;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, CHAR, FILETIME, HANDLE,
                                         HRESULT, HWND, NTSTATUS, PSTR, PWSTR;
public import windows.win32.security.cryptography : CERT_CONTEXT;
public import windows.win32.security : PSID, SID_NAME_USE;
public import windows.win32.system.com : IUnknown;
public import windows.win32.system.registry : HKEY;

extern(Windows) @nogc nothrow:


// Enums


alias NET_REQUEST_PROVISION_OPTIONS = uint;
enum : uint
{
    NETSETUP_PROVISION_ONLINE_CALLER = 0x40000000U,
}

alias NET_JOIN_DOMAIN_JOIN_OPTIONS = uint;
enum : uint
{
    NETSETUP_JOIN_DOMAIN              = 0x00000001U,
    NETSETUP_ACCT_CREATE              = 0x00000002U,
    NETSETUP_WIN9X_UPGRADE            = 0x00000010U,
    NETSETUP_DOMAIN_JOIN_IF_JOINED    = 0x00000020U,
    NETSETUP_JOIN_UNSECURE            = 0x00000040U,
    NETSETUP_MACHINE_PWD_PASSED       = 0x00000080U,
    NETSETUP_DEFER_SPN_SET            = 0x00000100U,
    NETSETUP_JOIN_DC_ACCOUNT          = 0x00000200U,
    NETSETUP_JOIN_WITH_NEW_NAME       = 0x00000400U,
    NETSETUP_JOIN_READONLY            = 0x00000800U,
    NETSETUP_AMBIGUOUS_DC             = 0x00001000U,
    NETSETUP_NO_NETLOGON_CACHE        = 0x00002000U,
    NETSETUP_DONT_CONTROL_SERVICES    = 0x00004000U,
    NETSETUP_SET_MACHINE_NAME         = 0x00008000U,
    NETSETUP_FORCE_SPN_SET            = 0x00010000U,
    NETSETUP_NO_ACCT_REUSE            = 0x00020000U,
    NETSETUP_IGNORE_UNSUPPORTED_FLAGS = 0x10000000U,
}

alias NET_REMOTE_COMPUTER_SUPPORTS_OPTIONS = uint;
enum : uint
{
    SUPPORTS_REMOTE_ADMIN_PROTOCOL = 0x00000002U,
    SUPPORTS_RPC                   = 0x00000004U,
    SUPPORTS_SAM_PROTOCOL          = 0x00000008U,
    SUPPORTS_UNICODE               = 0x00000010U,
    SUPPORTS_LOCAL                 = 0x00000020U,
}

alias FORCE_LEVEL_FLAGS = uint;
enum : uint
{
    USE_NOFORCE       = 0x00000000U,
    USE_FORCE         = 0x00000001U,
    USE_LOTS_OF_FORCE = 0x00000002U,
}

alias NET_SERVER_TYPE = uint;
enum : uint
{
    SV_TYPE_WORKSTATION       = 0x00000001U,
    SV_TYPE_SERVER            = 0x00000002U,
    SV_TYPE_SQLSERVER         = 0x00000004U,
    SV_TYPE_DOMAIN_CTRL       = 0x00000008U,
    SV_TYPE_DOMAIN_BAKCTRL    = 0x00000010U,
    SV_TYPE_TIME_SOURCE       = 0x00000020U,
    SV_TYPE_AFP               = 0x00000040U,
    SV_TYPE_NOVELL            = 0x00000080U,
    SV_TYPE_DOMAIN_MEMBER     = 0x00000100U,
    SV_TYPE_PRINTQ_SERVER     = 0x00000200U,
    SV_TYPE_DIALIN_SERVER     = 0x00000400U,
    SV_TYPE_XENIX_SERVER      = 0x00000800U,
    SV_TYPE_SERVER_UNIX       = 0x00000800U,
    SV_TYPE_NT                = 0x00001000U,
    SV_TYPE_WFW               = 0x00002000U,
    SV_TYPE_SERVER_MFPN       = 0x00004000U,
    SV_TYPE_SERVER_NT         = 0x00008000U,
    SV_TYPE_POTENTIAL_BROWSER = 0x00010000U,
    SV_TYPE_BACKUP_BROWSER    = 0x00020000U,
    SV_TYPE_MASTER_BROWSER    = 0x00040000U,
    SV_TYPE_DOMAIN_MASTER     = 0x00080000U,
    SV_TYPE_SERVER_OSF        = 0x00100000U,
    SV_TYPE_SERVER_VMS        = 0x00200000U,
    SV_TYPE_WINDOWS           = 0x00400000U,
    SV_TYPE_DFS               = 0x00800000U,
    SV_TYPE_CLUSTER_NT        = 0x01000000U,
    SV_TYPE_TERMINALSERVER    = 0x02000000U,
    SV_TYPE_CLUSTER_VS_NT     = 0x04000000U,
    SV_TYPE_DCE               = 0x10000000U,
    SV_TYPE_ALTERNATE_XPORT   = 0x20000000U,
    SV_TYPE_LOCAL_LIST_ONLY   = 0x40000000U,
    SV_TYPE_DOMAIN_ENUM       = 0x80000000U,
    SV_TYPE_ALL               = 0xffffffffU,
}

alias NET_USER_ENUM_FILTER_FLAGS = uint;
enum : uint
{
    FILTER_TEMP_DUPLICATE_ACCOUNT    = 0x00000001U,
    FILTER_NORMAL_ACCOUNT            = 0x00000002U,
    FILTER_INTERDOMAIN_TRUST_ACCOUNT = 0x00000008U,
    FILTER_WORKSTATION_TRUST_ACCOUNT = 0x00000010U,
    FILTER_SERVER_TRUST_ACCOUNT      = 0x00000020U,
}

alias NETSETUP_PROVISION = uint;
enum : uint
{
    NETSETUP_PROVISION_DOWNLEVEL_PRIV_SUPPORT = 0x00000001U,
    NETSETUP_PROVISION_REUSE_ACCOUNT          = 0x00000002U,
    NETSETUP_PROVISION_USE_DEFAULT_PASSWORD   = 0x00000004U,
    NETSETUP_PROVISION_SKIP_ACCOUNT_SEARCH    = 0x00000008U,
    NETSETUP_PROVISION_ROOT_CA_CERTS          = 0x00000010U,
}

alias USER_ACCOUNT_FLAGS = uint;
enum : uint
{
    UF_SCRIPT                                 = 0x00000001U,
    UF_ACCOUNTDISABLE                         = 0x00000002U,
    UF_HOMEDIR_REQUIRED                       = 0x00000008U,
    UF_PASSWD_NOTREQD                         = 0x00000020U,
    UF_PASSWD_CANT_CHANGE                     = 0x00000040U,
    UF_LOCKOUT                                = 0x00000010U,
    UF_DONT_EXPIRE_PASSWD                     = 0x00010000U,
    UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED        = 0x00000080U,
    UF_NOT_DELEGATED                          = 0x00100000U,
    UF_SMARTCARD_REQUIRED                     = 0x00040000U,
    UF_USE_DES_KEY_ONLY                       = 0x00200000U,
    UF_DONT_REQUIRE_PREAUTH                   = 0x00400000U,
    UF_TRUSTED_FOR_DELEGATION                 = 0x00080000U,
    UF_PASSWORD_EXPIRED                       = 0x00800000U,
    UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION = 0x01000000U,
}

alias AF_OP = uint;
enum : uint
{
    AF_OP_PRINT    = 0x00000001U,
    AF_OP_COMM     = 0x00000002U,
    AF_OP_SERVER   = 0x00000004U,
    AF_OP_ACCOUNTS = 0x00000008U,
}

alias SERVER_INFO_SECURITY = uint;
enum : uint
{
    SV_SHARESECURITY = 0x00000000U,
    SV_USERSECURITY  = 0x00000001U,
}

alias USER_PRIV = uint;
enum : uint
{
    USER_PRIV_GUEST = 0x00000000U,
    USER_PRIV_USER  = 0x00000001U,
    USER_PRIV_ADMIN = 0x00000002U,
}

alias USE_INFO_ASG_TYPE = uint;
enum : uint
{
    USE_WILDCARD = 0xffffffffU,
    USE_DISKDEV  = 0x00000000U,
    USE_SPOOLDEV = 0x00000001U,
    USE_IPC      = 0x00000003U,
}

alias SERVER_INFO_HIDDEN = int;
enum : int
{
    SV_VISIBLE = 0x00000000,
    SV_HIDDEN  = 0x00000001,
}

alias USER_MODALS_ROLES = uint;
enum : uint
{
    UAS_ROLE_STANDALONE = 0x00000000U,
    UAS_ROLE_MEMBER     = 0x00000001U,
    UAS_ROLE_BACKUP     = 0x00000002U,
    UAS_ROLE_PRIMARY    = 0x00000003U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ne-lmaccess-msa_info_level
alias MSA_INFO_LEVEL = int;
enum : int
{
    MsaInfoLevel0   = 0x00000000,
    MsaInfoLevel1   = 0x00000001,
    MsaInfoLevelMax = 0x00000002,
}

alias MSA_INFO_ACCOUNT_TYPE = int;
enum : int
{
    MsaAccountFalse                 = 0x00000000,
    StandAloneManagedServiceAccount = 0x00000001,
    GroupManagedServiceAccount      = 0x00000002,
    DelegatedManagedServiceAccount  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ne-lmaccess-msa_info_state
alias MSA_INFO_STATE = int;
enum : int
{
    MsaInfoNotExist      = 0x00000001,
    MsaInfoNotService    = 0x00000002,
    MsaInfoCannotInstall = 0x00000003,
    MsaInfoCanInstall    = 0x00000004,
    MsaInfoInstalled     = 0x00000005,
}

alias NET_VALIDATE_PASSWORD_TYPE = int;
enum : int
{
    NetValidateAuthentication = 0x00000001,
    NetValidatePasswordChange = 0x00000002,
    NetValidatePasswordReset  = 0x00000003,
}

alias TRANSPORT_TYPE = int;
enum : int
{
    UseTransportType_None = 0x00000000,
    UseTransportType_Wsk  = 0x00000001,
    UseTransportType_Quic = 0x00000002,
}

alias TRANSPORT_INFO_FLAG = int;
enum : int
{
    NoneFlag        = 0x00000000,
    TcpPortSetFlag  = 0x00000001,
    QuicPortSetFlag = 0x00000002,
    RdmaPortSetFlag = 0x00000004,
}

alias NETSETUP_NAME_TYPE = int;
enum : int
{
    NetSetupUnknown           = 0x00000000,
    NetSetupMachine           = 0x00000001,
    NetSetupWorkgroup         = 0x00000002,
    NetSetupDomain            = 0x00000003,
    NetSetupNonExistentDomain = 0x00000004,
    NetSetupDnsMachine        = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmjoin/ne-lmjoin-dsreg_join_type
alias DSREG_JOIN_TYPE = int;
enum : int
{
    DSREG_UNKNOWN_JOIN   = 0x00000000,
    DSREG_DEVICE_JOIN    = 0x00000001,
    DSREG_WORKPLACE_JOIN = 0x00000002,
}

alias NET_COMPUTER_NAME_TYPE = int;
enum : int
{
    NetPrimaryComputerName    = 0x00000000,
    NetAlternateComputerNames = 0x00000001,
    NetAllComputerNames       = 0x00000002,
    NetComputerNameTypeMax    = 0x00000003,
}

alias NETSETUP_JOIN_STATUS = int;
enum : int
{
    NetSetupUnknownStatus = 0x00000000,
    NetSetupUnjoined      = 0x00000001,
    NetSetupWorkgroupName = 0x00000002,
    NetSetupDomainName    = 0x00000003,
}

alias OBO_TOKEN_TYPE = int;
enum : int
{
    OBO_USER      = 0x00000001,
    OBO_COMPONENT = 0x00000002,
    OBO_SOFTWARE  = 0x00000003,
}

alias COMPONENT_CHARACTERISTICS = int;
enum : int
{
    NCF_VIRTUAL                     = 0x00000001,
    NCF_SOFTWARE_ENUMERATED         = 0x00000002,
    NCF_PHYSICAL                    = 0x00000004,
    NCF_HIDDEN                      = 0x00000008,
    NCF_NO_SERVICE                  = 0x00000010,
    NCF_NOT_USER_REMOVABLE          = 0x00000020,
    NCF_MULTIPORT_INSTANCED_ADAPTER = 0x00000040,
    NCF_HAS_UI                      = 0x00000080,
    NCF_SINGLE_INSTANCE             = 0x00000100,
    NCF_FILTER                      = 0x00000400,
    NCF_DONTEXPOSELOWER             = 0x00001000,
    NCF_HIDE_BINDING                = 0x00002000,
    NCF_NDIS_PROTOCOL               = 0x00004000,
    NCF_FIXED_BINDING               = 0x00020000,
    NCF_LW_FILTER                   = 0x00040000,
}

alias NCRP_FLAGS = int;
enum : int
{
    NCRP_QUERY_PROPERTY_UI = 0x00000001,
    NCRP_SHOW_PROPERTY_UI  = 0x00000002,
}

alias SUPPORTS_BINDING_INTERFACE_FLAGS = int;
enum : int
{
    NCF_LOWER = 0x00000001,
    NCF_UPPER = 0x00000002,
}

alias ENUM_BINDING_PATHS_FLAGS = int;
enum : int
{
    EBP_ABOVE = 0x00000001,
    EBP_BELOW = 0x00000002,
}

alias NCPNP_RECONFIG_LAYER = int;
enum : int
{
    NCRL_NDIS = 0x00000001,
    NCRL_TDI  = 0x00000002,
}

alias NETWORK_INSTALL_TIME = int;
enum : int
{
    NSF_PRIMARYINSTALL = 0x00000001,
    NSF_POSTSYSINSTALL = 0x00000002,
}

alias NETWORK_UPGRADE_TYPE = int;
enum : int
{
    NSF_WIN16_UPGRADE     = 0x00000010,
    NSF_WIN95_UPGRADE     = 0x00000020,
    NSF_WINNT_WKS_UPGRADE = 0x00000040,
    NSF_WINNT_SVR_UPGRADE = 0x00000080,
    NSF_WINNT_SBS_UPGRADE = 0x00000100,
    NSF_COMPONENT_UPDATE  = 0x00000200,
}

alias DEFAULT_PAGES = int;
enum : int
{
    DPP_ADVANCED = 0x00000001,
}

alias BIND_FLAGS1 = int;
enum : int
{
    NCN_ADD            = 0x00000001,
    NCN_REMOVE         = 0x00000002,
    NCN_UPDATE         = 0x00000004,
    NCN_ENABLE         = 0x00000010,
    NCN_DISABLE        = 0x00000020,
    NCN_BINDING_PATH   = 0x00000100,
    NCN_PROPERTYCHANGE = 0x00000200,
    NCN_NET            = 0x00010000,
    NCN_NETTRANS       = 0x00020000,
    NCN_NETCLIENT      = 0x00040000,
    NCN_NETSERVICE     = 0x00080000,
}

alias RASCON_UIINFO_FLAGS = int;
enum : int
{
    RCUIF_VPN                       = 0x00000001,
    RCUIF_DEMAND_DIAL               = 0x00000002,
    RCUIF_NOT_ADMIN                 = 0x00000004,
    RCUIF_USE_IPv4_STATICADDRESS    = 0x00000008,
    RCUIF_USE_IPv4_NAME_SERVERS     = 0x00000010,
    RCUIF_USE_IPv4_REMOTE_GATEWAY   = 0x00000020,
    RCUIF_USE_IPv4_EXPLICIT_METRIC  = 0x00000040,
    RCUIF_USE_HEADER_COMPRESSION    = 0x00000080,
    RCUIF_USE_DISABLE_REGISTER_DNS  = 0x00000100,
    RCUIF_USE_PRIVATE_DNS_SUFFIX    = 0x00000200,
    RCUIF_ENABLE_NBT                = 0x00000400,
    RCUIF_USE_IPv6_STATICADDRESS    = 0x00000800,
    RCUIF_USE_IPv6_NAME_SERVERS     = 0x00001000,
    RCUIF_USE_IPv6_REMOTE_GATEWAY   = 0x00002000,
    RCUIF_USE_IPv6_EXPLICIT_METRIC  = 0x00004000,
    RCUIF_DISABLE_CLASS_BASED_ROUTE = 0x00008000,
}

// Constants


enum : uint
{
    NERR_BASE            = 0x00000834U,
    NERR_PasswordExpired = 0x000008c2U,
}

enum uint CNLEN = 0x0000000fU;
enum uint LM20_CNLEN = 0x0000000fU;
enum uint DNLEN = 0x0000000fU;
enum uint LM20_DNLEN = 0x0000000fU;
enum uint UNCLEN = 0x00000011U;

enum : uint
{
    LM20_UNCLEN = 0x00000011U,
    LM20_NNLEN  = 0x0000000cU,
}

enum uint SNLEN = 0x00000050U;
enum uint LM20_SNLEN = 0x0000000fU;
enum uint STXTLEN = 0x00000100U;
enum uint LM20_STXTLEN = 0x0000003fU;
enum uint PATHLEN = 0x00000100U;
enum uint LM20_PATHLEN = 0x00000100U;
enum uint DEVLEN = 0x00000050U;
enum uint LM20_DEVLEN = 0x00000008U;
enum uint EVLEN = 0x00000010U;
enum uint UNLEN = 0x00000100U;
enum uint LM20_UNLEN = 0x00000014U;
enum uint GNLEN = 0x00000100U;
enum uint LM20_GNLEN = 0x00000014U;
enum uint PWLEN = 0x00000100U;
enum uint LM20_PWLEN = 0x0000000eU;
enum uint SHPWLEN = 0x00000008U;
enum uint CLTYPE_LEN = 0x0000000cU;
enum uint MAXCOMMENTSZ = 0x00000100U;
enum uint LM20_MAXCOMMENTSZ = 0x00000030U;
enum uint QNLEN = 0x00000050U;
enum uint LM20_QNLEN = 0x0000000cU;
enum uint ALERTSZ = 0x00000080U;
enum uint NETBIOS_NAME_LEN = 0x00000010U;
enum uint MAX_PREFERRED_LENGTH = 0xffffffffU;
enum uint LM_DNS_MAX_NAME_LENGTH = 0x000000ffU;

enum : uint
{
    CRYPT_KEY_LEN = 0x00000007U,
    CRYPT_TXT_LEN = 0x00000008U,
}

enum uint ENCRYPTED_PWLEN = 0x00000010U;

enum : uint
{
    SESSION_PWLEN      = 0x00000018U,
    SESSION_CRYPT_KLEN = 0x00000015U,
}

enum uint PARMNUM_ALL = 0x00000000U;

enum : uint
{
    PARM_ERROR_UNKNOWN = 0xffffffffU,
    PARM_ERROR_NONE    = 0x00000000U,
}

enum uint PARMNUM_BASE_INFOLEVEL = 0x000003e8U;
enum const(wchar)* MESSAGE_FILENAME = "NETMSG";
enum const(wchar)* OS2MSG_FILENAME = "BASE";
enum const(wchar)* HELP_MSG_FILENAME = "NETH";
enum const(wchar)* BACKUP_MSG_FILENAME = "BAK.MSG";

enum : uint
{
    PLATFORM_ID_DOS = 0x0000012cU,
    PLATFORM_ID_OS2 = 0x00000190U,
    PLATFORM_ID_NT  = 0x000001f4U,
    PLATFORM_ID_OSF = 0x00000258U,
    PLATFORM_ID_VMS = 0x000002bcU,
}

enum uint MIN_LANMAN_MESSAGE_ID = 0x00000834U;
enum uint MAX_LANMAN_MESSAGE_ID = 0x0000170bU;

enum : uint
{
    NERR_Success       = 0x00000000U,
    NERR_NetNotStarted = 0x00000836U,
}

enum uint NERR_UnknownServer = 0x00000837U;
enum uint NERR_ShareMem = 0x00000838U;
enum uint NERR_NoNetworkResource = 0x00000839U;
enum uint NERR_RemoteOnly = 0x0000083aU;
enum uint NERR_DevNotRedirected = 0x0000083bU;
enum uint NERR_ServerNotStarted = 0x00000842U;
enum uint NERR_ItemNotFound = 0x00000843U;
enum uint NERR_UnknownDevDir = 0x00000844U;
enum uint NERR_RedirectedPath = 0x00000845U;
enum uint NERR_DuplicateShare = 0x00000846U;

enum : uint
{
    NERR_NoRoom       = 0x00000847U,
    NERR_TooManyItems = 0x00000849U,
}

enum uint NERR_InvalidMaxUsers = 0x0000084aU;
enum uint NERR_BufTooSmall = 0x0000084bU;
enum uint NERR_RemoteErr = 0x0000084fU;
enum uint NERR_LanmanIniError = 0x00000853U;
enum uint NERR_NetworkError = 0x00000858U;
enum uint NERR_WkstaInconsistentState = 0x00000859U;
enum uint NERR_WkstaNotStarted = 0x0000085aU;
enum uint NERR_BrowserNotStarted = 0x0000085bU;
enum uint NERR_InternalError = 0x0000085cU;
enum uint NERR_BadTransactConfig = 0x0000085dU;
enum uint NERR_InvalidAPI = 0x0000085eU;
enum uint NERR_BadEventName = 0x0000085fU;
enum uint NERR_DupNameReboot = 0x00000860U;
enum uint NERR_CfgCompNotFound = 0x00000862U;
enum uint NERR_CfgParamNotFound = 0x00000863U;
enum uint NERR_LineTooLong = 0x00000865U;
enum uint NERR_QNotFound = 0x00000866U;
enum uint NERR_JobNotFound = 0x00000867U;

enum : uint
{
    NERR_DestNotFound = 0x00000868U,
    NERR_DestExists   = 0x00000869U,
}

enum : uint
{
    NERR_QExists   = 0x0000086aU,
    NERR_QNoRoom   = 0x0000086bU,
    NERR_JobNoRoom = 0x0000086cU,
}

enum : uint
{
    NERR_DestNoRoom    = 0x0000086dU,
    NERR_DestIdle      = 0x0000086eU,
    NERR_DestInvalidOp = 0x0000086fU,
}

enum uint NERR_ProcNoRespond = 0x00000870U;
enum uint NERR_SpoolerNotLoaded = 0x00000871U;
enum uint NERR_DestInvalidState = 0x00000872U;
enum uint NERR_QInvalidState = 0x00000873U;
enum uint NERR_JobInvalidState = 0x00000874U;
enum uint NERR_SpoolNoMemory = 0x00000875U;
enum uint NERR_DriverNotFound = 0x00000876U;
enum uint NERR_DataTypeInvalid = 0x00000877U;
enum uint NERR_ProcNotFound = 0x00000878U;

enum : uint
{
    NERR_ServiceTableLocked  = 0x00000884U,
    NERR_ServiceTableFull    = 0x00000885U,
    NERR_ServiceInstalled    = 0x00000886U,
    NERR_ServiceEntryLocked  = 0x00000887U,
    NERR_ServiceNotInstalled = 0x00000888U,
}

enum uint NERR_BadServiceName = 0x00000889U;

enum : uint
{
    NERR_ServiceCtlTimeout = 0x0000088aU,
    NERR_ServiceCtlBusy    = 0x0000088bU,
}

enum uint NERR_BadServiceProgName = 0x0000088cU;

enum : uint
{
    NERR_ServiceNotCtrl     = 0x0000088dU,
    NERR_ServiceKillProc    = 0x0000088eU,
    NERR_ServiceCtlNotValid = 0x0000088fU,
}

enum uint NERR_NotInDispatchTbl = 0x00000890U;
enum uint NERR_BadControlRecv = 0x00000891U;
enum uint NERR_ServiceNotStarting = 0x00000892U;
enum uint NERR_AlreadyLoggedOn = 0x00000898U;
enum uint NERR_NotLoggedOn = 0x00000899U;

enum : uint
{
    NERR_BadUsername = 0x0000089aU,
    NERR_BadPassword = 0x0000089bU,
}

enum : uint
{
    NERR_UnableToAddName_W = 0x0000089cU,
    NERR_UnableToAddName_F = 0x0000089dU,
    NERR_UnableToDelName_W = 0x0000089eU,
    NERR_UnableToDelName_F = 0x0000089fU,
}

enum : uint
{
    NERR_LogonsPaused        = 0x000008a1U,
    NERR_LogonServerConflict = 0x000008a2U,
    NERR_LogonNoUserPath     = 0x000008a3U,
    NERR_LogonScriptError    = 0x000008a4U,
}

enum uint NERR_StandaloneLogon = 0x000008a6U;

enum : uint
{
    NERR_LogonServerNotFound = 0x000008a7U,
    NERR_LogonDomainExists   = 0x000008a8U,
}

enum uint NERR_NonValidatedLogon = 0x000008a9U;
enum uint NERR_ACFNotFound = 0x000008abU;
enum uint NERR_GroupNotFound = 0x000008acU;
enum uint NERR_UserNotFound = 0x000008adU;
enum uint NERR_ResourceNotFound = 0x000008aeU;
enum uint NERR_GroupExists = 0x000008afU;
enum uint NERR_UserExists = 0x000008b0U;
enum uint NERR_ResourceExists = 0x000008b1U;
enum uint NERR_NotPrimary = 0x000008b2U;

enum : uint
{
    NERR_ACFNotLoaded    = 0x000008b3U,
    NERR_ACFNoRoom       = 0x000008b4U,
    NERR_ACFFileIOFail   = 0x000008b5U,
    NERR_ACFTooManyLists = 0x000008b6U,
}

enum uint NERR_UserLogon = 0x000008b7U;
enum uint NERR_ACFNoParent = 0x000008b8U;
enum uint NERR_CanNotGrowSegment = 0x000008b9U;
enum uint NERR_SpeGroupOp = 0x000008baU;
enum uint NERR_NotInCache = 0x000008bbU;

enum : uint
{
    NERR_UserInGroup    = 0x000008bcU,
    NERR_UserNotInGroup = 0x000008bdU,
}

enum : uint
{
    NERR_AccountUndefined = 0x000008beU,
    NERR_AccountExpired   = 0x000008bfU,
}

enum : uint
{
    NERR_InvalidWorkstation = 0x000008c0U,
    NERR_InvalidLogonHours  = 0x000008c1U,
}

enum : uint
{
    NERR_PasswordCantChange   = 0x000008c3U,
    NERR_PasswordHistConflict = 0x000008c4U,
    NERR_PasswordTooShort     = 0x000008c5U,
    NERR_PasswordTooRecent    = 0x000008c6U,
}

enum uint NERR_InvalidDatabase = 0x000008c7U;
enum uint NERR_DatabaseUpToDate = 0x000008c8U;
enum uint NERR_SyncRequired = 0x000008c9U;
enum uint NERR_UseNotFound = 0x000008caU;
enum uint NERR_BadAsgType = 0x000008cbU;
enum uint NERR_DeviceIsShared = 0x000008ccU;
enum uint NERR_SameAsComputerName = 0x000008cdU;
enum uint NERR_NoComputerName = 0x000008deU;
enum uint NERR_MsgAlreadyStarted = 0x000008dfU;
enum uint NERR_MsgInitFailed = 0x000008e0U;
enum uint NERR_NameNotFound = 0x000008e1U;
enum uint NERR_AlreadyForwarded = 0x000008e2U;
enum uint NERR_AddForwarded = 0x000008e3U;
enum uint NERR_AlreadyExists = 0x000008e4U;
enum uint NERR_TooManyNames = 0x000008e5U;
enum uint NERR_DelComputerName = 0x000008e6U;
enum uint NERR_LocalForward = 0x000008e7U;
enum uint NERR_GrpMsgProcessor = 0x000008e8U;
enum uint NERR_PausedRemote = 0x000008e9U;
enum uint NERR_BadReceive = 0x000008eaU;
enum uint NERR_NameInUse = 0x000008ebU;
enum uint NERR_MsgNotStarted = 0x000008ecU;

enum : uint
{
    NERR_NotLocalName  = 0x000008edU,
    NERR_NoForwardName = 0x000008eeU,
}

enum uint NERR_RemoteFull = 0x000008efU;
enum uint NERR_NameNotForwarded = 0x000008f0U;
enum uint NERR_TruncatedBroadcast = 0x000008f1U;
enum uint NERR_InvalidDevice = 0x000008f6U;
enum uint NERR_WriteFault = 0x000008f7U;
enum uint NERR_DuplicateName = 0x000008f9U;
enum uint NERR_DeleteLater = 0x000008faU;
enum uint NERR_IncompleteDel = 0x000008fbU;
enum uint NERR_MultipleNets = 0x000008fcU;
enum uint NERR_NetNameNotFound = 0x00000906U;
enum uint NERR_DeviceNotShared = 0x00000907U;
enum uint NERR_ClientNameNotFound = 0x00000908U;
enum uint NERR_FileIdNotFound = 0x0000090aU;
enum uint NERR_ExecFailure = 0x0000090bU;

enum : uint
{
    NERR_TmpFile     = 0x0000090cU,
    NERR_TooMuchData = 0x0000090dU,
}

enum uint NERR_DeviceShareConflict = 0x0000090eU;
enum uint NERR_BrowserTableIncomplete = 0x0000090fU;
enum uint NERR_NotLocalDomain = 0x00000910U;
enum uint NERR_IsDfsShare = 0x00000911U;
enum uint NERR_DevInvalidOpCode = 0x0000091bU;

enum : uint
{
    NERR_DevNotFound = 0x0000091cU,
    NERR_DevNotOpen  = 0x0000091dU,
}

enum : uint
{
    NERR_BadQueueDevString = 0x0000091eU,
    NERR_BadQueuePriority  = 0x0000091fU,
}

enum uint NERR_NoCommDevs = 0x00000921U;
enum uint NERR_QueueNotFound = 0x00000922U;

enum : uint
{
    NERR_BadDevString   = 0x00000924U,
    NERR_BadDev         = 0x00000925U,
    NERR_InUseBySpooler = 0x00000926U,
}

enum uint NERR_CommDevInUse = 0x00000927U;
enum uint NERR_InvalidComputer = 0x0000092fU;
enum uint NERR_MaxLenExceeded = 0x00000932U;
enum uint NERR_BadComponent = 0x00000934U;
enum uint NERR_CantType = 0x00000935U;
enum uint NERR_TooManyEntries = 0x0000093aU;

enum : uint
{
    NERR_ProfileFileTooBig = 0x00000942U,
    NERR_ProfileOffset     = 0x00000943U,
    NERR_ProfileCleanup    = 0x00000944U,
    NERR_ProfileUnknownCmd = 0x00000945U,
    NERR_ProfileLoadErr    = 0x00000946U,
    NERR_ProfileSaveErr    = 0x00000947U,
}

enum : uint
{
    NERR_LogOverflow    = 0x00000949U,
    NERR_LogFileChanged = 0x0000094aU,
    NERR_LogFileCorrupt = 0x0000094bU,
}

enum uint NERR_SourceIsDir = 0x0000094cU;

enum : uint
{
    NERR_BadSource        = 0x0000094dU,
    NERR_BadDest          = 0x0000094eU,
    NERR_DifferentServers = 0x0000094fU,
}

enum uint NERR_RunSrvPaused = 0x00000951U;

enum : uint
{
    NERR_ErrCommRunSrv     = 0x00000955U,
    NERR_ErrorExecingGhost = 0x00000957U,
}

enum uint NERR_ShareNotFound = 0x00000958U;
enum uint NERR_InvalidLana = 0x00000960U;
enum uint NERR_OpenFiles = 0x00000961U;
enum uint NERR_ActiveConns = 0x00000962U;
enum uint NERR_BadPasswordCore = 0x00000963U;
enum uint NERR_DevInUse = 0x00000964U;
enum uint NERR_LocalDrive = 0x00000965U;
enum uint NERR_AlertExists = 0x0000097eU;
enum uint NERR_TooManyAlerts = 0x0000097fU;
enum uint NERR_NoSuchAlert = 0x00000980U;
enum uint NERR_BadRecipient = 0x00000981U;
enum uint NERR_AcctLimitExceeded = 0x00000982U;
enum uint NERR_InvalidLogSeek = 0x00000988U;
enum uint NERR_BadUasConfig = 0x00000992U;
enum uint NERR_InvalidUASOp = 0x00000993U;
enum uint NERR_LastAdmin = 0x00000994U;
enum uint NERR_DCNotFound = 0x00000995U;
enum uint NERR_LogonTrackingError = 0x00000996U;
enum uint NERR_NetlogonNotStarted = 0x00000997U;
enum uint NERR_CanNotGrowUASFile = 0x00000998U;
enum uint NERR_TimeDiffAtDC = 0x00000999U;
enum uint NERR_PasswordMismatch = 0x0000099aU;

enum : uint
{
    NERR_NoSuchServer     = 0x0000099cU,
    NERR_NoSuchSession    = 0x0000099dU,
    NERR_NoSuchConnection = 0x0000099eU,
}

enum : uint
{
    NERR_TooManyServers     = 0x0000099fU,
    NERR_TooManySessions    = 0x000009a0U,
    NERR_TooManyConnections = 0x000009a1U,
    NERR_TooManyFiles       = 0x000009a2U,
}

enum uint NERR_NoAlternateServers = 0x000009a3U;
enum uint NERR_TryDownLevel = 0x000009a6U;
enum uint NERR_UPSDriverNotStarted = 0x000009b0U;

enum : uint
{
    NERR_UPSInvalidConfig   = 0x000009b1U,
    NERR_UPSInvalidCommPort = 0x000009b2U,
}

enum : uint
{
    NERR_UPSSignalAsserted = 0x000009b3U,
    NERR_UPSShutdownFailed = 0x000009b4U,
}

enum uint NERR_BadDosRetCode = 0x000009c4U;
enum uint NERR_ProgNeedsExtraMem = 0x000009c5U;
enum uint NERR_BadDosFunction = 0x000009c6U;
enum uint NERR_RemoteBootFailed = 0x000009c7U;
enum uint NERR_BadFileCheckSum = 0x000009c8U;
enum uint NERR_NoRplBootSystem = 0x000009c9U;

enum : uint
{
    NERR_RplLoadrNetBiosErr = 0x000009caU,
    NERR_RplLoadrDiskErr    = 0x000009cbU,
}

enum uint NERR_ImageParamErr = 0x000009ccU;
enum uint NERR_TooManyImageParams = 0x000009cdU;
enum uint NERR_NonDosFloppyUsed = 0x000009ceU;

enum : uint
{
    NERR_RplBootRestart    = 0x000009cfU,
    NERR_RplSrvrCallFailed = 0x000009d0U,
}

enum uint NERR_CantConnectRplSrvr = 0x000009d1U;
enum uint NERR_CantOpenImageFile = 0x000009d2U;
enum uint NERR_CallingRplSrvr = 0x000009d3U;
enum uint NERR_StartingRplBoot = 0x000009d4U;

enum : uint
{
    NERR_RplBootServiceTerm = 0x000009d5U,
    NERR_RplBootStartFailed = 0x000009d6U,
}

enum uint NERR_RPL_CONNECTED = 0x000009d7U;
enum uint NERR_BrowserConfiguredToNotRun = 0x000009f6U;
enum uint NERR_RplNoAdaptersStarted = 0x00000a32U;

enum : uint
{
    NERR_RplBadRegistry   = 0x00000a33U,
    NERR_RplBadDatabase   = 0x00000a34U,
    NERR_RplRplfilesShare = 0x00000a35U,
}

enum uint NERR_RplNotRplServer = 0x00000a36U;

enum : uint
{
    NERR_RplCannotEnum           = 0x00000a37U,
    NERR_RplWkstaInfoCorrupted   = 0x00000a38U,
    NERR_RplWkstaNotFound        = 0x00000a39U,
    NERR_RplWkstaNameUnavailable = 0x00000a3aU,
}

enum : uint
{
    NERR_RplProfileInfoCorrupted   = 0x00000a3bU,
    NERR_RplProfileNotFound        = 0x00000a3cU,
    NERR_RplProfileNameUnavailable = 0x00000a3dU,
    NERR_RplProfileNotEmpty        = 0x00000a3eU,
}

enum : uint
{
    NERR_RplConfigInfoCorrupted = 0x00000a3fU,
    NERR_RplConfigNotFound      = 0x00000a40U,
}

enum uint NERR_RplAdapterInfoCorrupted = 0x00000a41U;

enum : uint
{
    NERR_RplInternal            = 0x00000a42U,
    NERR_RplVendorInfoCorrupted = 0x00000a43U,
}

enum uint NERR_RplBootInfoCorrupted = 0x00000a44U;
enum uint NERR_RplWkstaNeedsUserAcct = 0x00000a45U;
enum uint NERR_RplNeedsRPLUSERAcct = 0x00000a46U;
enum uint NERR_RplBootNotFound = 0x00000a47U;
enum uint NERR_RplIncompatibleProfile = 0x00000a48U;
enum uint NERR_RplAdapterNameUnavailable = 0x00000a49U;
enum uint NERR_RplConfigNotEmpty = 0x00000a4aU;

enum : uint
{
    NERR_RplBootInUse      = 0x00000a4bU,
    NERR_RplBackupDatabase = 0x00000a4cU,
}

enum uint NERR_RplAdapterNotFound = 0x00000a4dU;

enum : uint
{
    NERR_RplVendorNotFound        = 0x00000a4eU,
    NERR_RplVendorNameUnavailable = 0x00000a4fU,
}

enum uint NERR_RplBootNameUnavailable = 0x00000a50U;
enum uint NERR_RplConfigNameUnavailable = 0x00000a51U;
enum uint NERR_DfsInternalCorruption = 0x00000a64U;
enum uint NERR_DfsVolumeDataCorrupt = 0x00000a65U;
enum uint NERR_DfsNoSuchVolume = 0x00000a66U;
enum uint NERR_DfsVolumeAlreadyExists = 0x00000a67U;
enum uint NERR_DfsAlreadyShared = 0x00000a68U;

enum : uint
{
    NERR_DfsNoSuchShare    = 0x00000a69U,
    NERR_DfsNotALeafVolume = 0x00000a6aU,
}

enum : uint
{
    NERR_DfsLeafVolume               = 0x00000a6bU,
    NERR_DfsVolumeHasMultipleServers = 0x00000a6cU,
}

enum uint NERR_DfsCantCreateJunctionPoint = 0x00000a6dU;
enum uint NERR_DfsServerNotDfsAware = 0x00000a6eU;
enum uint NERR_DfsBadRenamePath = 0x00000a6fU;
enum uint NERR_DfsVolumeIsOffline = 0x00000a70U;
enum uint NERR_DfsNoSuchServer = 0x00000a71U;
enum uint NERR_DfsCyclicalName = 0x00000a72U;
enum uint NERR_DfsNotSupportedInServerDfs = 0x00000a73U;
enum uint NERR_DfsDuplicateService = 0x00000a74U;
enum uint NERR_DfsCantRemoveLastServerShare = 0x00000a75U;
enum uint NERR_DfsVolumeIsInterDfs = 0x00000a76U;
enum uint NERR_DfsInconsistent = 0x00000a77U;
enum uint NERR_DfsServerUpgraded = 0x00000a78U;
enum uint NERR_DfsDataIsIdentical = 0x00000a79U;
enum uint NERR_DfsCantRemoveDfsRoot = 0x00000a7aU;
enum uint NERR_DfsChildOrParentInDfs = 0x00000a7bU;
enum uint NERR_DfsInternalError = 0x00000a82U;

enum : uint
{
    NERR_SetupAlreadyJoined    = 0x00000a83U,
    NERR_SetupNotJoined        = 0x00000a84U,
    NERR_SetupDomainController = 0x00000a85U,
}

enum uint NERR_DefaultJoinRequired = 0x00000a86U;
enum uint NERR_InvalidWorkgroupName = 0x00000a87U;
enum uint NERR_NameUsesIncompatibleCodePage = 0x00000a88U;
enum uint NERR_ComputerAccountNotFound = 0x00000a89U;
enum uint NERR_PersonalSku = 0x00000a8aU;
enum uint NERR_SetupCheckDNSConfig = 0x00000a8bU;
enum uint NERR_AlreadyCloudDomainJoined = 0x00000a8cU;
enum uint NERR_PasswordMustChange = 0x00000a8dU;
enum uint NERR_AccountLockedOut = 0x00000a8eU;

enum : uint
{
    NERR_PasswordTooLong          = 0x00000a8fU,
    NERR_PasswordNotComplexEnough = 0x00000a90U,
    NERR_PasswordFilterError      = 0x00000a91U,
}

enum uint NERR_NoOfflineJoinInfo = 0x00000a95U;
enum uint NERR_BadOfflineJoinInfo = 0x00000a96U;
enum uint NERR_CantCreateJoinInfo = 0x00000a97U;
enum uint NERR_BadDomainJoinInfo = 0x00000a98U;
enum uint NERR_JoinPerformedMustRestart = 0x00000a99U;
enum uint NERR_NoJoinPending = 0x00000a9aU;
enum uint NERR_ValuesNotSet = 0x00000a9bU;
enum uint NERR_CantVerifyHostname = 0x00000a9cU;
enum uint NERR_CantLoadOfflineHive = 0x00000a9dU;
enum uint NERR_ConnectionInsecure = 0x00000a9eU;
enum uint NERR_ProvisioningBlobUnsupported = 0x00000a9fU;
enum uint NERR_DS8DCRequired = 0x00000aa0U;
enum uint NERR_LDAPCapableDCRequired = 0x00000aa1U;
enum uint NERR_DS8DCNotFound = 0x00000aa2U;
enum uint NERR_TargetVersionUnsupported = 0x00000aa3U;
enum uint NERR_InvalidMachineNameForJoin = 0x00000aa4U;
enum uint NERR_DS9DCNotFound = 0x00000aa5U;
enum uint NERR_PlainTextSecretsRequired = 0x00000aa6U;

enum : uint
{
    NERR_CannotUnjoinAadDomain   = 0x00000aa7U,
    NERR_CannotUpdateAadHostName = 0x00000aa8U,
}

enum uint NERR_DuplicateHostName = 0x00000aa9U;
enum uint NERR_HostNameTooLong = 0x00000aaaU;
enum uint NERR_TooManyHostNames = 0x00000aabU;
enum uint NERR_AccountReuseBlockedByPolicy = 0x00000aacU;
enum uint MAX_NERR = 0x00000bb7U;
enum uint UF_TEMP_DUPLICATE_ACCOUNT = 0x00000100U;
enum uint UF_NORMAL_ACCOUNT = 0x00000200U;
enum uint UF_INTERDOMAIN_TRUST_ACCOUNT = 0x00000800U;
enum uint UF_WORKSTATION_TRUST_ACCOUNT = 0x00001000U;
enum uint UF_SERVER_TRUST_ACCOUNT = 0x00002000U;
enum uint UF_MNS_LOGON_ACCOUNT = 0x00020000U;
enum uint UF_NO_AUTH_DATA_REQUIRED = 0x02000000U;
enum uint UF_PARTIAL_SECRETS_ACCOUNT = 0x04000000U;
enum uint UF_USE_AES_KEYS = 0x08000000U;
enum uint LG_INCLUDE_INDIRECT = 0x00000001U;
enum uint USER_NAME_PARMNUM = 0x00000001U;

enum : uint
{
    USER_PASSWORD_PARMNUM     = 0x00000003U,
    USER_PASSWORD_AGE_PARMNUM = 0x00000004U,
}

enum uint USER_PRIV_PARMNUM = 0x00000005U;
enum uint USER_HOME_DIR_PARMNUM = 0x00000006U;
enum uint USER_COMMENT_PARMNUM = 0x00000007U;
enum uint USER_FLAGS_PARMNUM = 0x00000008U;
enum uint USER_SCRIPT_PATH_PARMNUM = 0x00000009U;
enum uint USER_AUTH_FLAGS_PARMNUM = 0x0000000aU;
enum uint USER_FULL_NAME_PARMNUM = 0x0000000bU;
enum uint USER_USR_COMMENT_PARMNUM = 0x0000000cU;
enum uint USER_PARMS_PARMNUM = 0x0000000dU;
enum uint USER_WORKSTATIONS_PARMNUM = 0x0000000eU;

enum : uint
{
    USER_LAST_LOGON_PARMNUM  = 0x0000000fU,
    USER_LAST_LOGOFF_PARMNUM = 0x00000010U,
}

enum uint USER_ACCT_EXPIRES_PARMNUM = 0x00000011U;
enum uint USER_MAX_STORAGE_PARMNUM = 0x00000012U;
enum uint USER_UNITS_PER_WEEK_PARMNUM = 0x00000013U;
enum uint USER_LOGON_HOURS_PARMNUM = 0x00000014U;
enum uint USER_PAD_PW_COUNT_PARMNUM = 0x00000015U;
enum uint USER_NUM_LOGONS_PARMNUM = 0x00000016U;
enum uint USER_LOGON_SERVER_PARMNUM = 0x00000017U;
enum uint USER_COUNTRY_CODE_PARMNUM = 0x00000018U;
enum uint USER_CODE_PAGE_PARMNUM = 0x00000019U;
enum uint USER_PRIMARY_GROUP_PARMNUM = 0x00000033U;

enum : uint
{
    USER_PROFILE         = 0x00000034U,
    USER_PROFILE_PARMNUM = 0x00000034U,
}

enum uint USER_HOME_DIR_DRIVE_PARMNUM = 0x00000035U;
// Native encoding: ansi
enum const(wchar)* NULL_USERSETINFO_PASSWD = "              ";
enum uint UNITS_PER_DAY = 0x00000018U;
enum uint USER_PRIV_MASK = 0x00000003U;
enum uint MAX_PASSWD_LEN = 0x00000100U;
enum uint DEF_MIN_PWLEN = 0x00000006U;
enum uint DEF_PWUNIQUENESS = 0x00000005U;

enum : uint
{
    DEF_MAX_PWHIST = 0x00000008U,
    DEF_MAX_BADPW  = 0x00000000U,
}

enum uint VALIDATED_LOGON = 0x00000000U;
enum uint PASSWORD_EXPIRED = 0x00000002U;
enum uint NON_VALIDATED_LOGON = 0x00000003U;
enum uint VALID_LOGOFF = 0x00000001U;
enum uint MODALS_MIN_PASSWD_LEN_PARMNUM = 0x00000001U;
enum uint MODALS_MAX_PASSWD_AGE_PARMNUM = 0x00000002U;
enum uint MODALS_MIN_PASSWD_AGE_PARMNUM = 0x00000003U;
enum uint MODALS_FORCE_LOGOFF_PARMNUM = 0x00000004U;
enum uint MODALS_PASSWD_HIST_LEN_PARMNUM = 0x00000005U;
enum uint MODALS_ROLE_PARMNUM = 0x00000006U;
enum uint MODALS_PRIMARY_PARMNUM = 0x00000007U;

enum : uint
{
    MODALS_DOMAIN_NAME_PARMNUM = 0x00000008U,
    MODALS_DOMAIN_ID_PARMNUM   = 0x00000009U,
}

enum : uint
{
    MODALS_LOCKOUT_DURATION_PARMNUM           = 0x0000000aU,
    MODALS_LOCKOUT_OBSERVATION_WINDOW_PARMNUM = 0x0000000bU,
}

enum uint MODALS_LOCKOUT_THRESHOLD_PARMNUM = 0x0000000cU;
enum uint GROUPIDMASK = 0x00008000U;

enum : const(wchar)*
{
    GROUP_SPECIALGRP_USERS  = "USERS",
    GROUP_SPECIALGRP_ADMINS = "ADMINS",
    GROUP_SPECIALGRP_GUESTS = "GUESTS",
    GROUP_SPECIALGRP_LOCAL  = "LOCAL",
}

enum uint GROUP_ALL_PARMNUM = 0x00000000U;
enum uint GROUP_NAME_PARMNUM = 0x00000001U;
enum uint GROUP_COMMENT_PARMNUM = 0x00000002U;
enum uint GROUP_ATTRIBUTES_PARMNUM = 0x00000003U;

enum : uint
{
    LOCALGROUP_NAME_PARMNUM    = 0x00000001U,
    LOCALGROUP_COMMENT_PARMNUM = 0x00000002U,
}

enum uint MAXPERMENTRIES = 0x00000040U;

enum : uint
{
    ACCESS_NONE           = 0x00000000U,
    ACCESS_GROUP          = 0x00008000U,
    ACCESS_AUDIT          = 0x00000001U,
    ACCESS_SUCCESS_OPEN   = 0x00000010U,
    ACCESS_SUCCESS_WRITE  = 0x00000020U,
    ACCESS_SUCCESS_DELETE = 0x00000040U,
    ACCESS_SUCCESS_ACL    = 0x00000080U,
    ACCESS_SUCCESS_MASK   = 0x000000f0U,
}

enum : uint
{
    ACCESS_FAIL_OPEN             = 0x00000100U,
    ACCESS_FAIL_WRITE            = 0x00000200U,
    ACCESS_FAIL_DELETE           = 0x00000400U,
    ACCESS_FAIL_ACL              = 0x00000800U,
    ACCESS_FAIL_MASK             = 0x00000f00U,
    ACCESS_FAIL_SHIFT            = 0x00000004U,
    ACCESS_RESOURCE_NAME_PARMNUM = 0x00000001U,
}

enum uint ACCESS_ATTR_PARMNUM = 0x00000002U;
enum uint ACCESS_COUNT_PARMNUM = 0x00000003U;
enum uint ACCESS_ACCESS_LIST_PARMNUM = 0x00000004U;
// Native encoding: ansi
enum const(wchar)* ACCESS_LETTERS = "RWCXDAP         ";

enum : uint
{
    NET_VALIDATE_PASSWORD_LAST_SET       = 0x00000001U,
    NET_VALIDATE_BAD_PASSWORD_TIME       = 0x00000002U,
    NET_VALIDATE_LOCKOUT_TIME            = 0x00000004U,
    NET_VALIDATE_BAD_PASSWORD_COUNT      = 0x00000008U,
    NET_VALIDATE_PASSWORD_HISTORY_LENGTH = 0x00000010U,
    NET_VALIDATE_PASSWORD_HISTORY        = 0x00000020U,
}

enum : uint
{
    NETLOGON_CONTROL_QUERY               = 0x00000001U,
    NETLOGON_CONTROL_REPLICATE           = 0x00000002U,
    NETLOGON_CONTROL_SYNCHRONIZE         = 0x00000003U,
    NETLOGON_CONTROL_PDC_REPLICATE       = 0x00000004U,
    NETLOGON_CONTROL_REDISCOVER          = 0x00000005U,
    NETLOGON_CONTROL_TC_QUERY            = 0x00000006U,
    NETLOGON_CONTROL_TRANSPORT_NOTIFY    = 0x00000007U,
    NETLOGON_CONTROL_FIND_USER           = 0x00000008U,
    NETLOGON_CONTROL_CHANGE_PASSWORD     = 0x00000009U,
    NETLOGON_CONTROL_TC_VERIFY           = 0x0000000aU,
    NETLOGON_CONTROL_FORCE_DNS_REG       = 0x0000000bU,
    NETLOGON_CONTROL_QUERY_DNS_REG       = 0x0000000cU,
    NETLOGON_CONTROL_QUERY_ENC_TYPES     = 0x0000000dU,
    NETLOGON_CONTROL_UNLOAD_NETLOGON_DLL = 0x0000fffbU,
    NETLOGON_CONTROL_BACKUP_CHANGE_LOG   = 0x0000fffcU,
    NETLOGON_CONTROL_TRUNCATE_LOG        = 0x0000fffdU,
    NETLOGON_CONTROL_SET_DBFLAG          = 0x0000fffeU,
    NETLOGON_CONTROL_BREAKPOINT          = 0x0000ffffU,
}

enum : uint
{
    NETLOGON_REPLICATION_NEEDED      = 0x00000001U,
    NETLOGON_REPLICATION_IN_PROGRESS = 0x00000002U,
}

enum uint NETLOGON_FULL_SYNC_REPLICATION = 0x00000004U;

enum : uint
{
    NETLOGON_REDO_NEEDED        = 0x00000008U,
    NETLOGON_HAS_IP             = 0x00000010U,
    NETLOGON_HAS_TIMESERV       = 0x00000020U,
    NETLOGON_DNS_UPDATE_FAILURE = 0x00000040U,
}

enum uint NETLOGON_VERIFY_STATUS_RETURNED = 0x00000080U;

enum : const(wchar)*
{
    SERVICE_ACCOUNT_PASSWORD      = "_SA_{262E99C9-6160-4871-ACEC-4E61736B6F21}",
    SERVICE_ACCOUNT_SECRET_PREFIX = "_SC_{262E99C9-6160-4871-ACEC-4E61736B6F21}_",
}

enum const(wchar)* DELEGATED_MANAGED_SERVICE_ACCOUNT_PASSWORD = "_SA_{F8262F4C-499B-4770-88B4-A75C91D0D8E9}";
enum GUID ServiceAccountPasswordGUID = GUID("262e99c9-6160-4871-acec-4e61736b6f21");

enum : int
{
    SERVICE_ACCOUNT_FLAG_LINK_TO_HOST_ONLY     = 0x00000001,
    SERVICE_ACCOUNT_FLAG_ADD_AGAINST_RODC      = 0x00000002,
    SERVICE_ACCOUNT_FLAG_UNLINK_FROM_HOST_ONLY = 0x00000001,
    SERVICE_ACCOUNT_FLAG_REMOVE_OFFLINE        = 0x00000002,
}

enum const(wchar)* ALERTER_MAILSLOT = "\\\\.\\MAILSLOT\\Alerter";
enum const(wchar)* ALERT_PRINT_EVENT = "PRINTING";
enum const(wchar)* ALERT_MESSAGE_EVENT = "MESSAGE";
enum const(wchar)* ALERT_ERRORLOG_EVENT = "ERRORLOG";
enum const(wchar)* ALERT_ADMIN_EVENT = "ADMIN";
enum const(wchar)* ALERT_USER_EVENT = "USER";

enum : uint
{
    PRJOB_QSTATUS   = 0x00000003U,
    PRJOB_DEVSTATUS = 0x000001fcU,
}

enum : uint
{
    PRJOB_COMPLETE    = 0x00000004U,
    PRJOB_INTERV      = 0x00000008U,
    PRJOB_ERROR       = 0x00000010U,
    PRJOB_DESTOFFLINE = 0x00000020U,
    PRJOB_DESTPAUSED  = 0x00000040U,
}

enum : uint
{
    PRJOB_NOTIFY      = 0x00000080U,
    PRJOB_DESTNOPAPER = 0x00000100U,
    PRJOB_DELETED     = 0x00008000U,
    PRJOB_QS_QUEUED   = 0x00000000U,
    PRJOB_QS_PAUSED   = 0x00000001U,
    PRJOB_QS_SPOOLING = 0x00000002U,
    PRJOB_QS_PRINTING = 0x00000003U,
}

enum uint JOB_RUN_PERIODICALLY = 0x00000001U;
enum uint JOB_EXEC_ERROR = 0x00000002U;
enum uint JOB_RUNS_TODAY = 0x00000004U;
enum uint JOB_ADD_CURRENT_DATE = 0x00000008U;
enum uint JOB_NONINTERACTIVE = 0x00000010U;

enum : uint
{
    LOGFLAGS_FORWARD  = 0x00000000U,
    LOGFLAGS_BACKWARD = 0x00000001U,
    LOGFLAGS_SEEK     = 0x00000002U,
}

enum : uint
{
    ACTION_LOCKOUT     = 0x00000000U,
    ACTION_ADMINUNLOCK = 0x00000001U,
}

enum uint AE_SRVSTATUS_ = 0x00000000U;

enum : uint
{
    AE_SESSLOGON_ = 0x00000001U,
    AE_SESSLOGOFF_ = 0x00000002U,
    AE_SESSPWERR_ = 0x00000003U,
}

enum : uint
{
    AE_CONNSTART_ = 0x00000004U,
    AE_CONNSTOP_ = 0x00000005U,
    AE_CONNREJ_  = 0x00000006U,
}

enum : uint
{
    AE_RESACCESS_   = 0x00000007U,
    AE_RESACCESSREJ_ = 0x00000008U,
}

enum uint AE_CLOSEFILE_ = 0x00000009U;
enum uint AE_SERVICESTAT_ = 0x0000000bU;
enum uint AE_ACLMOD_ = 0x0000000cU;
enum uint AE_UASMOD_ = 0x0000000dU;

enum : uint
{
    AE_NETLOGON_    = 0x0000000eU,
    AE_NETLOGOFF_   = 0x0000000fU,
    AE_NETLOGDENIED = 0x00000010U,
}

enum uint AE_ACCLIMITEXCD = 0x00000011U;
enum uint AE_RESACCESS2 = 0x00000012U;
enum uint AE_ACLMODFAIL = 0x00000013U;
enum uint AE_LOCKOUT_ = 0x00000014U;
enum uint AE_GENERIC_TYPE = 0x00000015U;

enum : uint
{
    AE_SRVSTART  = 0x00000000U,
    AE_SRVPAUSED = 0x00000001U,
    AE_SRVCONT   = 0x00000002U,
    AE_SRVSTOP   = 0x00000003U,
}

enum uint AE_GUEST = 0x00000000U;

enum : uint
{
    AE_USER  = 0x00000001U,
    AE_ADMIN = 0x00000002U,
}

enum uint AE_NORMAL = 0x00000000U;
enum uint AE_USERLIMIT = 0x00000000U;
enum uint AE_GENERAL = 0x00000000U;
enum uint AE_ERROR = 0x00000001U;
enum uint AE_SESSDIS = 0x00000001U;
enum uint AE_BADPW = 0x00000001U;
enum uint AE_AUTODIS = 0x00000002U;
enum uint AE_UNSHARE = 0x00000002U;

enum : uint
{
    AE_ADMINPRIVREQD = 0x00000002U,
    AE_ADMINDIS      = 0x00000003U,
}

enum uint AE_NOACCESSPERM = 0x00000003U;
enum uint AE_ACCRESTRICT = 0x00000004U;
enum uint AE_NORMAL_CLOSE = 0x00000000U;
enum uint AE_SES_CLOSE = 0x00000001U;
enum uint AE_ADMIN_CLOSE = 0x00000002U;

enum : uint
{
    AE_LIM_UNKNOWN     = 0x00000000U,
    AE_LIM_LOGONHOURS  = 0x00000001U,
    AE_LIM_EXPIRED     = 0x00000002U,
    AE_LIM_INVAL_WKSTA = 0x00000003U,
}

enum : uint
{
    AE_LIM_DISABLED = 0x00000004U,
    AE_LIM_DELETED  = 0x00000005U,
}

enum : uint
{
    AE_MOD    = 0x00000000U,
    AE_DELETE = 0x00000001U,
}

enum : uint
{
    AE_ADD        = 0x00000002U,
    AE_UAS_USER   = 0x00000000U,
    AE_UAS_GROUP  = 0x00000001U,
    AE_UAS_MODALS = 0x00000002U,
}

enum : uint
{
    SVAUD_SERVICE       = 0x00000001U,
    SVAUD_GOODSESSLOGON = 0x00000006U,
}

enum uint SVAUD_BADSESSLOGON = 0x00000018U;
enum uint SVAUD_GOODNETLOGON = 0x00000060U;
enum uint SVAUD_BADNETLOGON = 0x00000180U;

enum : uint
{
    SVAUD_GOODUSE     = 0x00000600U,
    SVAUD_BADUSE      = 0x00001800U,
    SVAUD_USERLIST    = 0x00002000U,
    SVAUD_PERMISSIONS = 0x00004000U,
}

enum : uint
{
    SVAUD_RESOURCE = 0x00008000U,
    SVAUD_LOGONLIM = 0x00010000U,
}

enum uint AA_AUDIT_ALL = 0x00000001U;
enum uint AA_A_OWNER = 0x00000004U;
enum uint AA_CLOSE = 0x00000008U;

enum : uint
{
    AA_S_OPEN   = 0x00000010U,
    AA_S_WRITE  = 0x00000020U,
    AA_S_CREATE = 0x00000020U,
    AA_S_DELETE = 0x00000040U,
    AA_S_ACL    = 0x00000080U,
}

enum : uint
{
    AA_F_OPEN   = 0x00000100U,
    AA_F_WRITE  = 0x00000200U,
    AA_F_CREATE = 0x00000200U,
    AA_F_DELETE = 0x00000400U,
    AA_F_ACL    = 0x00000800U,
}

enum : uint
{
    AA_A_OPEN   = 0x00001000U,
    AA_A_WRITE  = 0x00002000U,
    AA_A_CREATE = 0x00002000U,
    AA_A_DELETE = 0x00004000U,
    AA_A_ACL    = 0x00008000U,
}

enum uint ERRLOG_BASE = 0x00000c1cU;
enum uint NELOG_Internal_Error = 0x00000c1cU;
enum uint NELOG_Resource_Shortage = 0x00000c1dU;

enum : uint
{
    NELOG_Unable_To_Lock_Segment   = 0x00000c1eU,
    NELOG_Unable_To_Unlock_Segment = 0x00000c1fU,
}

enum uint NELOG_Uninstall_Service = 0x00000c20U;
enum uint NELOG_Init_Exec_Fail = 0x00000c21U;

enum : uint
{
    NELOG_Ncb_Error       = 0x00000c22U,
    NELOG_Net_Not_Started = 0x00000c23U,
}

enum uint NELOG_Ioctl_Error = 0x00000c24U;
enum uint NELOG_System_Semaphore = 0x00000c25U;
enum uint NELOG_Init_OpenCreate_Err = 0x00000c26U;

enum : uint
{
    NELOG_NetBios      = 0x00000c27U,
    NELOG_SMB_Illegal  = 0x00000c28U,
    NELOG_Service_Fail = 0x00000c29U,
}

enum uint NELOG_Entries_Lost = 0x00000c2aU;
enum uint NELOG_Init_Seg_Overflow = 0x00000c30U;
enum uint NELOG_Srv_No_Mem_Grow = 0x00000c31U;
enum uint NELOG_Access_File_Bad = 0x00000c32U;
enum uint NELOG_Srvnet_Not_Started = 0x00000c33U;
enum uint NELOG_Init_Chardev_Err = 0x00000c34U;
enum uint NELOG_Remote_API = 0x00000c35U;
enum uint NELOG_Ncb_TooManyErr = 0x00000c36U;
enum uint NELOG_Mailslot_err = 0x00000c37U;
enum uint NELOG_ReleaseMem_Alert = 0x00000c38U;
enum uint NELOG_AT_cannot_write = 0x00000c39U;
enum uint NELOG_Cant_Make_Msg_File = 0x00000c3aU;
enum uint NELOG_Exec_Netservr_NoMem = 0x00000c3bU;
enum uint NELOG_Server_Lock_Failure = 0x00000c3cU;

enum : uint
{
    NELOG_Msg_Shutdown     = 0x00000c44U,
    NELOG_Msg_Sem_Shutdown = 0x00000c45U,
    NELOG_Msg_Log_Err      = 0x00000c4eU,
}

enum uint NELOG_VIO_POPUP_ERR = 0x00000c4fU;
enum uint NELOG_Msg_Unexpected_SMB_Type = 0x00000c50U;

enum : uint
{
    NELOG_Wksta_Infoseg           = 0x00000c58U,
    NELOG_Wksta_Compname          = 0x00000c59U,
    NELOG_Wksta_BiosThreadFailure = 0x00000c5aU,
    NELOG_Wksta_IniSeg            = 0x00000c5bU,
    NELOG_Wksta_HostTab_Full      = 0x00000c5cU,
    NELOG_Wksta_Bad_Mailslot_SMB  = 0x00000c5dU,
    NELOG_Wksta_UASInit           = 0x00000c5eU,
    NELOG_Wksta_SSIRelogon        = 0x00000c5fU,
}

enum uint NELOG_Build_Name = 0x00000c62U;
enum uint NELOG_Name_Expansion = 0x00000c63U;
enum uint NELOG_Message_Send = 0x00000c64U;
enum uint NELOG_Mail_Slt_Err = 0x00000c65U;

enum : uint
{
    NELOG_AT_cannot_read           = 0x00000c66U,
    NELOG_AT_sched_err             = 0x00000c67U,
    NELOG_AT_schedule_file_created = 0x00000c68U,
}

enum uint NELOG_Srvnet_NB_Open = 0x00000c69U;
enum uint NELOG_AT_Exec_Err = 0x00000c6aU;
enum uint NELOG_Lazy_Write_Err = 0x00000c6cU;

enum : uint
{
    NELOG_HotFix              = 0x00000c6dU,
    NELOG_HardErr_From_Server = 0x00000c6eU,
}

enum : uint
{
    NELOG_LocalSecFail1       = 0x00000c6fU,
    NELOG_LocalSecFail2       = 0x00000c70U,
    NELOG_LocalSecFail3       = 0x00000c71U,
    NELOG_LocalSecGeneralFail = 0x00000c72U,
}

enum : uint
{
    NELOG_NetWkSta_Internal_Error   = 0x00000c76U,
    NELOG_NetWkSta_No_Resource      = 0x00000c77U,
    NELOG_NetWkSta_SMB_Err          = 0x00000c78U,
    NELOG_NetWkSta_VC_Err           = 0x00000c79U,
    NELOG_NetWkSta_Stuck_VC_Err     = 0x00000c7aU,
    NELOG_NetWkSta_NCB_Err          = 0x00000c7bU,
    NELOG_NetWkSta_Write_Behind_Err = 0x00000c7cU,
    NELOG_NetWkSta_Reset_Err        = 0x00000c7dU,
    NELOG_NetWkSta_Too_Many         = 0x00000c7eU,
}

enum : uint
{
    NELOG_Srv_Thread_Failure = 0x00000c84U,
    NELOG_Srv_Close_Failure  = 0x00000c85U,
}

enum : uint
{
    NELOG_ReplUserCurDir      = 0x00000c86U,
    NELOG_ReplCannotMasterDir = 0x00000c87U,
}

enum : uint
{
    NELOG_ReplUpdateError = 0x00000c88U,
    NELOG_ReplLostMaster  = 0x00000c89U,
}

enum uint NELOG_NetlogonAuthDCFail = 0x00000c8aU;

enum : uint
{
    NELOG_ReplLogonFailed   = 0x00000c8bU,
    NELOG_ReplNetErr        = 0x00000c8cU,
    NELOG_ReplMaxFiles      = 0x00000c8dU,
    NELOG_ReplMaxTreeDepth  = 0x00000c8eU,
    NELOG_ReplBadMsg        = 0x00000c8fU,
    NELOG_ReplSysErr        = 0x00000c90U,
    NELOG_ReplUserLoged     = 0x00000c91U,
    NELOG_ReplBadImport     = 0x00000c92U,
    NELOG_ReplBadExport     = 0x00000c93U,
    NELOG_ReplSignalFileErr = 0x00000c94U,
}

enum : uint
{
    NELOG_DiskFT           = 0x00000c95U,
    NELOG_ReplAccessDenied = 0x00000c96U,
}

enum : uint
{
    NELOG_NetlogonFailedPrimary          = 0x00000c97U,
    NELOG_NetlogonPasswdSetFailed        = 0x00000c98U,
    NELOG_NetlogonTrackingError          = 0x00000c99U,
    NELOG_NetlogonSyncError              = 0x00000c9aU,
    NELOG_NetlogonRequireSignOrSealError = 0x00000c9bU,
}

enum : uint
{
    NELOG_UPS_PowerOut         = 0x00000c9eU,
    NELOG_UPS_Shutdown         = 0x00000c9fU,
    NELOG_UPS_CmdFileError     = 0x00000ca0U,
    NELOG_UPS_CannotOpenDriver = 0x00000ca1U,
}

enum : uint
{
    NELOG_UPS_PowerBack     = 0x00000ca2U,
    NELOG_UPS_CmdFileConfig = 0x00000ca3U,
    NELOG_UPS_CmdFileExec   = 0x00000ca4U,
}

enum uint NELOG_Missing_Parameter = 0x00000cb2U;

enum : uint
{
    NELOG_Invalid_Config_Line = 0x00000cb3U,
    NELOG_Invalid_Config_File = 0x00000cb4U,
}

enum : uint
{
    NELOG_File_Changed   = 0x00000cb5U,
    NELOG_Files_Dont_Fit = 0x00000cb6U,
}

enum uint NELOG_Wrong_DLL_Version = 0x00000cb7U;
enum uint NELOG_Error_in_DLL = 0x00000cb8U;
enum uint NELOG_System_Error = 0x00000cb9U;
enum uint NELOG_FT_ErrLog_Too_Large = 0x00000cbaU;
enum uint NELOG_FT_Update_In_Progress = 0x00000cbbU;

enum : uint
{
    NELOG_Joined_Domain    = 0x00000cbcU,
    NELOG_Joined_Workgroup = 0x00000cbdU,
}

enum uint NELOG_OEM_Code = 0x00000ce3U;
enum uint ERRLOG2_BASE = 0x00001644U;

enum : uint
{
    NELOG_NetlogonSSIInitError            = 0x00001644U,
    NELOG_NetlogonFailedToUpdateTrustList = 0x00001645U,
    NELOG_NetlogonFailedToAddRpcInterface = 0x00001646U,
    NELOG_NetlogonFailedToReadMailslot    = 0x00001647U,
    NELOG_NetlogonFailedToRegisterSC      = 0x00001648U,
    NELOG_NetlogonChangeLogCorrupt        = 0x00001649U,
    NELOG_NetlogonFailedToCreateShare     = 0x0000164aU,
    NELOG_NetlogonDownLevelLogonFailed    = 0x0000164bU,
    NELOG_NetlogonDownLevelLogoffFailed   = 0x0000164cU,
}

enum : uint
{
    NELOG_NetlogonNTLogonFailed          = 0x0000164dU,
    NELOG_NetlogonNTLogoffFailed         = 0x0000164eU,
    NELOG_NetlogonPartialSyncCallSuccess = 0x0000164fU,
    NELOG_NetlogonPartialSyncCallFailed  = 0x00001650U,
}

enum : uint
{
    NELOG_NetlogonFullSyncCallSuccess    = 0x00001651U,
    NELOG_NetlogonFullSyncCallFailed     = 0x00001652U,
    NELOG_NetlogonPartialSyncSuccess     = 0x00001653U,
    NELOG_NetlogonPartialSyncFailed      = 0x00001654U,
    NELOG_NetlogonFullSyncSuccess        = 0x00001655U,
    NELOG_NetlogonFullSyncFailed         = 0x00001656U,
    NELOG_NetlogonAuthNoDomainController = 0x00001657U,
    NELOG_NetlogonAuthNoTrustLsaSecret   = 0x00001658U,
    NELOG_NetlogonAuthNoTrustSamAccount  = 0x00001659U,
}

enum : uint
{
    NELOG_NetlogonServerAuthFailed            = 0x0000165aU,
    NELOG_NetlogonServerAuthNoTrustSamAccount = 0x0000165bU,
}

enum : uint
{
    NELOG_FailedToRegisterSC       = 0x0000165cU,
    NELOG_FailedToSetServiceStatus = 0x0000165dU,
    NELOG_FailedToGetComputerName  = 0x0000165eU,
}

enum uint NELOG_DriverNotLoaded = 0x0000165fU;
enum uint NELOG_NoTranportLoaded = 0x00001660U;

enum : uint
{
    NELOG_NetlogonFailedDomainDelta        = 0x00001661U,
    NELOG_NetlogonFailedGlobalGroupDelta   = 0x00001662U,
    NELOG_NetlogonFailedLocalGroupDelta    = 0x00001663U,
    NELOG_NetlogonFailedUserDelta          = 0x00001664U,
    NELOG_NetlogonFailedPolicyDelta        = 0x00001665U,
    NELOG_NetlogonFailedTrustedDomainDelta = 0x00001666U,
    NELOG_NetlogonFailedAccountDelta       = 0x00001667U,
    NELOG_NetlogonFailedSecretDelta        = 0x00001668U,
    NELOG_NetlogonSystemError              = 0x00001669U,
    NELOG_NetlogonDuplicateMachineAccounts = 0x0000166aU,
}

enum : uint
{
    NELOG_NetlogonTooManyGlobalGroups = 0x0000166bU,
    NELOG_NetlogonBrowserDriver       = 0x0000166cU,
    NELOG_NetlogonAddNameFailure      = 0x0000166dU,
}

enum : uint
{
    NELOG_RplMessages           = 0x0000166eU,
    NELOG_RplXnsBoot            = 0x0000166fU,
    NELOG_RplSystem             = 0x00001670U,
    NELOG_RplWkstaTimeout       = 0x00001671U,
    NELOG_RplWkstaFileOpen      = 0x00001672U,
    NELOG_RplWkstaFileRead      = 0x00001673U,
    NELOG_RplWkstaMemory        = 0x00001674U,
    NELOG_RplWkstaFileChecksum  = 0x00001675U,
    NELOG_RplWkstaFileLineCount = 0x00001676U,
    NELOG_RplWkstaBbcFile       = 0x00001677U,
    NELOG_RplWkstaFileSize      = 0x00001678U,
    NELOG_RplWkstaInternal      = 0x00001679U,
    NELOG_RplWkstaWrongVersion  = 0x0000167aU,
    NELOG_RplWkstaNetwork       = 0x0000167bU,
    NELOG_RplAdapterResource    = 0x0000167cU,
}

enum : uint
{
    NELOG_RplFileCopy       = 0x0000167dU,
    NELOG_RplFileDelete     = 0x0000167eU,
    NELOG_RplFilePerms      = 0x0000167fU,
    NELOG_RplCheckConfigs   = 0x00001680U,
    NELOG_RplCreateProfiles = 0x00001681U,
}

enum : uint
{
    NELOG_RplRegistry       = 0x00001682U,
    NELOG_RplReplaceRPLDISK = 0x00001683U,
}

enum : uint
{
    NELOG_RplCheckSecurity  = 0x00001684U,
    NELOG_RplBackupDatabase = 0x00001685U,
}

enum : uint
{
    NELOG_RplInitDatabase           = 0x00001686U,
    NELOG_RplRestoreDatabaseFailure = 0x00001687U,
    NELOG_RplRestoreDatabaseSuccess = 0x00001688U,
}

enum uint NELOG_RplInitRestoredDatabase = 0x00001689U;
enum uint NELOG_NetlogonSessionTypeWrong = 0x0000168aU;
enum uint NELOG_RplUpgradeDBTo40 = 0x0000168bU;

enum : uint
{
    NELOG_NetlogonLanmanBdcsNotAllowed        = 0x0000168cU,
    NELOG_NetlogonNoDynamicDns                = 0x0000168dU,
    NELOG_NetlogonDynamicDnsRegisterFailure   = 0x0000168eU,
    NELOG_NetlogonDynamicDnsDeregisterFailure = 0x0000168fU,
}

enum : uint
{
    NELOG_NetlogonFailedFileCreate        = 0x00001690U,
    NELOG_NetlogonGetSubnetToSite         = 0x00001691U,
    NELOG_NetlogonNoSiteForClient         = 0x00001692U,
    NELOG_NetlogonBadSiteName             = 0x00001693U,
    NELOG_NetlogonBadSubnetName           = 0x00001694U,
    NELOG_NetlogonDynamicDnsServerFailure = 0x00001695U,
    NELOG_NetlogonDynamicDnsFailure       = 0x00001696U,
    NELOG_NetlogonRpcCallCancelled        = 0x00001697U,
    NELOG_NetlogonDcSiteCovered           = 0x00001698U,
    NELOG_NetlogonDcSiteNotCovered        = 0x00001699U,
    NELOG_NetlogonGcSiteCovered           = 0x0000169aU,
    NELOG_NetlogonGcSiteNotCovered        = 0x0000169bU,
    NELOG_NetlogonFailedSpnUpdate         = 0x0000169cU,
    NELOG_NetlogonFailedDnsHostNameUpdate = 0x0000169dU,
}

enum : uint
{
    NELOG_NetlogonAuthNoUplevelDomainController = 0x0000169eU,
    NELOG_NetlogonAuthDomainDowngraded          = 0x0000169fU,
    NELOG_NetlogonNdncSiteCovered               = 0x000016a0U,
    NELOG_NetlogonNdncSiteNotCovered            = 0x000016a1U,
    NELOG_NetlogonDcOldSiteCovered              = 0x000016a2U,
    NELOG_NetlogonDcSiteNotCoveredAuto          = 0x000016a3U,
    NELOG_NetlogonGcOldSiteCovered              = 0x000016a4U,
    NELOG_NetlogonGcSiteNotCoveredAuto          = 0x000016a5U,
    NELOG_NetlogonNdncOldSiteCovered            = 0x000016a6U,
    NELOG_NetlogonNdncSiteNotCoveredAuto        = 0x000016a7U,
}

enum : uint
{
    NELOG_NetlogonSpnMultipleSamAccountNames = 0x000016a8U,
    NELOG_NetlogonSpnCrackNamesFailure       = 0x000016a9U,
    NELOG_NetlogonNoAddressToSiteMapping     = 0x000016aaU,
}

enum : uint
{
    NELOG_NetlogonInvalidGenericParameterValue = 0x000016abU,
    NELOG_NetlogonInvalidDwordParameterValue   = 0x000016acU,
}

enum uint NELOG_NetlogonServerAuthFailedNoAccount = 0x000016adU;

enum : uint
{
    NELOG_NetlogonNoDynamicDnsManual    = 0x000016aeU,
    NELOG_NetlogonNoSiteForClients      = 0x000016afU,
    NELOG_NetlogonDnsDeregAborted       = 0x000016b0U,
    NELOG_NetlogonRpcPortRequestFailure = 0x000016b1U,
}

enum uint NELOG_NetlogonPartialSiteMappingForClients = 0x000016b2U;

enum : uint
{
    NELOG_NetlogonRemoteDynamicDnsRegisterFailure   = 0x000016b3U,
    NELOG_NetlogonRemoteDynamicDnsDeregisterFailure = 0x000016b4U,
}

enum : uint
{
    NELOG_NetlogonRejectedRemoteDynamicDnsRegister   = 0x000016b5U,
    NELOG_NetlogonRejectedRemoteDynamicDnsDeregister = 0x000016b6U,
}

enum uint NELOG_NetlogonRemoteDynamicDnsUpdateRequestFailure = 0x000016b7U;

enum : uint
{
    NELOG_NetlogonUserValidationReqInitialTimeOut       = 0x000016b8U,
    NELOG_NetlogonUserValidationReqRecurringTimeOut     = 0x000016b9U,
    NELOG_NetlogonUserValidationReqWaitInitialWarning   = 0x000016baU,
    NELOG_NetlogonUserValidationReqWaitRecurringWarning = 0x000016bbU,
}

enum uint NELOG_NetlogonFailedToAddAuthzRpcInterface = 0x000016bcU;

enum : uint
{
    NELOG_NetLogonFailedToInitializeAuthzRm = 0x000016bdU,
    NELOG_NetLogonFailedToInitializeRPCSD   = 0x000016beU,
}

enum uint NELOG_NetlogonMachinePasswdSetSucceeded = 0x000016bfU;
enum uint NELOG_NetlogonMsaPasswdSetSucceeded = 0x000016c0U;
enum uint NELOG_NetlogonDnsHostNameLowerCasingFailed = 0x000016c1U;
enum uint NETLOG_NetlogonNonWindowsSupportsSecureRpc = 0x000016c2U;

enum : uint
{
    NETLOG_NetlogonUnsecureRpcClient                     = 0x000016c3U,
    NETLOG_NetlogonUnsecureRpcTrust                      = 0x000016c4U,
    NETLOG_NetlogonUnsecuredRpcMachineTemporarilyAllowed = 0x000016c5U,
    NETLOG_NetlogonUnsecureRpcMachineAllowedBySsdl       = 0x000016c6U,
    NETLOG_NetlogonUnsecureRpcTrustAllowedBySsdl         = 0x000016c7U,
}

enum : uint
{
    NETLOG_PassThruFilterError_Summary_AdminOverride = 0x000016c8U,
    NETLOG_PassThruFilterError_Summary_Blocked       = 0x000016c9U,
    NETLOG_PassThruFilterError_Request_AdminOverride = 0x000016caU,
    NETLOG_PassThruFilterError_Request_Blocked       = 0x000016cbU,
}

enum : uint
{
    NETLOG_NetlogonRpcBacklogLimitSet     = 0x000016ccU,
    NETLOG_NetlogonRpcBacklogLimitFailure = 0x000016cdU,
}

enum : uint
{
    NETSETUP_ACCT_DELETE           = 0x00000004U,
    NETSETUP_DNS_NAME_CHANGES_ONLY = 0x00001000U,
}

enum uint NETSETUP_INSTALL_INVOCATION = 0x00040000U;
enum uint NETSETUP_ALT_SAMACCOUNTNAME = 0x00020000U;
enum uint NET_IGNORE_UNSUPPORTED_FLAGS = 0x00000001U;

enum : uint
{
    NETSETUP_PROVISION_PERSISTENTSITE            = 0x00000020U,
    NETSETUP_PROVISION_CHECK_PWD_ONLY            = 0x80000000U,
    NETSETUP_PROVISIONING_PARAMS_WIN8_VERSION    = 0x00000001U,
    NETSETUP_PROVISIONING_PARAMS_CURRENT_VERSION = 0x00000002U,
}

enum uint MSGNAME_NOT_FORWARDED = 0x00000000U;

enum : uint
{
    MSGNAME_FORWARDED_TO   = 0x00000004U,
    MSGNAME_FORWARDED_FROM = 0x00000010U,
}

enum int SUPPORTS_ANY = 0xffffffff;
enum uint NO_PERMISSION_REQUIRED = 0x00000001U;
enum uint ALLOCATE_RESPONSE = 0x00000002U;
enum uint USE_SPECIFIC_TRANSPORT = 0x80000000U;

enum : uint
{
    SV_PLATFORM_ID_OS2 = 0x00000190U,
    SV_PLATFORM_ID_NT  = 0x000001f4U,
}

enum uint MAJOR_VERSION_MASK = 0x0000000fU;
enum int SV_NODISC = 0xffffffff;
enum uint SV_PLATFORM_ID_PARMNUM = 0x00000065U;
enum uint SV_NAME_PARMNUM = 0x00000066U;

enum : uint
{
    SV_VERSION_MAJOR_PARMNUM = 0x00000067U,
    SV_VERSION_MINOR_PARMNUM = 0x00000068U,
}

enum uint SV_TYPE_PARMNUM = 0x00000069U;
enum uint SV_COMMENT_PARMNUM = 0x00000005U;
enum uint SV_USERS_PARMNUM = 0x0000006bU;
enum uint SV_DISC_PARMNUM = 0x0000000aU;
enum uint SV_HIDDEN_PARMNUM = 0x00000010U;
enum uint SV_ANNOUNCE_PARMNUM = 0x00000011U;
enum uint SV_ANNDELTA_PARMNUM = 0x00000012U;
enum uint SV_USERPATH_PARMNUM = 0x00000070U;
enum uint SV_ULIST_MTIME_PARMNUM = 0x00000191U;
enum uint SV_GLIST_MTIME_PARMNUM = 0x00000192U;
enum uint SV_ALIST_MTIME_PARMNUM = 0x00000193U;
enum uint SV_ALERTS_PARMNUM = 0x0000000bU;
enum uint SV_SECURITY_PARMNUM = 0x00000195U;
enum uint SV_NUMADMIN_PARMNUM = 0x00000196U;
enum uint SV_LANMASK_PARMNUM = 0x00000197U;
enum uint SV_GUESTACC_PARMNUM = 0x00000198U;

enum : uint
{
    SV_CHDEVQ_PARMNUM    = 0x0000019aU,
    SV_CHDEVJOBS_PARMNUM = 0x0000019bU,
}

enum uint SV_CONNECTIONS_PARMNUM = 0x0000019cU;
enum uint SV_SHARES_PARMNUM = 0x0000019dU;
enum uint SV_OPENFILES_PARMNUM = 0x0000019eU;
enum uint SV_SESSREQS_PARMNUM = 0x000001a1U;
enum uint SV_ACTIVELOCKS_PARMNUM = 0x000001a3U;
enum uint SV_NUMREQBUF_PARMNUM = 0x000001a4U;
enum uint SV_NUMBIGBUF_PARMNUM = 0x000001a6U;
enum uint SV_NUMFILETASKS_PARMNUM = 0x000001a7U;
enum uint SV_ALERTSCHED_PARMNUM = 0x00000025U;
enum uint SV_ERRORALERT_PARMNUM = 0x00000026U;
enum uint SV_LOGONALERT_PARMNUM = 0x00000027U;
enum uint SV_ACCESSALERT_PARMNUM = 0x00000028U;
enum uint SV_DISKALERT_PARMNUM = 0x00000029U;
enum uint SV_NETIOALERT_PARMNUM = 0x0000002aU;
enum uint SV_MAXAUDITSZ_PARMNUM = 0x0000002bU;
enum uint SV_SRVHEURISTICS_PARMNUM = 0x000001afU;
enum uint SV_SESSOPENS_PARMNUM = 0x000001f5U;
enum uint SV_SESSVCS_PARMNUM = 0x000001f6U;
enum uint SV_OPENSEARCH_PARMNUM = 0x000001f7U;
enum uint SV_SIZREQBUF_PARMNUM = 0x000001f8U;
enum uint SV_INITWORKITEMS_PARMNUM = 0x000001f9U;
enum uint SV_MAXWORKITEMS_PARMNUM = 0x000001faU;
enum uint SV_RAWWORKITEMS_PARMNUM = 0x000001fbU;
enum uint SV_IRPSTACKSIZE_PARMNUM = 0x000001fcU;
enum uint SV_MAXRAWBUFLEN_PARMNUM = 0x000001fdU;
enum uint SV_SESSUSERS_PARMNUM = 0x000001feU;
enum uint SV_SESSCONNS_PARMNUM = 0x000001ffU;
enum uint SV_MAXNONPAGEDMEMORYUSAGE_PARMNUM = 0x00000200U;
enum uint SV_MAXPAGEDMEMORYUSAGE_PARMNUM = 0x00000201U;
enum uint SV_ENABLESOFTCOMPAT_PARMNUM = 0x00000202U;
enum uint SV_ENABLEFORCEDLOGOFF_PARMNUM = 0x00000203U;
enum uint SV_TIMESOURCE_PARMNUM = 0x00000204U;
enum uint SV_ACCEPTDOWNLEVELAPIS_PARMNUM = 0x00000205U;
enum uint SV_LMANNOUNCE_PARMNUM = 0x00000206U;
enum uint SV_DOMAIN_PARMNUM = 0x00000207U;
enum uint SV_MAXCOPYREADLEN_PARMNUM = 0x00000208U;
enum uint SV_MAXCOPYWRITELEN_PARMNUM = 0x00000209U;
enum uint SV_MINKEEPSEARCH_PARMNUM = 0x0000020aU;
enum uint SV_MAXKEEPSEARCH_PARMNUM = 0x0000020bU;
enum uint SV_MINKEEPCOMPLSEARCH_PARMNUM = 0x0000020cU;
enum uint SV_MAXKEEPCOMPLSEARCH_PARMNUM = 0x0000020dU;
enum uint SV_THREADCOUNTADD_PARMNUM = 0x0000020eU;
enum uint SV_NUMBLOCKTHREADS_PARMNUM = 0x0000020fU;
enum uint SV_SCAVTIMEOUT_PARMNUM = 0x00000210U;
enum uint SV_MINRCVQUEUE_PARMNUM = 0x00000211U;
enum uint SV_MINFREEWORKITEMS_PARMNUM = 0x00000212U;
enum uint SV_XACTMEMSIZE_PARMNUM = 0x00000213U;
enum uint SV_THREADPRIORITY_PARMNUM = 0x00000214U;
enum uint SV_MAXMPXCT_PARMNUM = 0x00000215U;

enum : uint
{
    SV_OPLOCKBREAKWAIT_PARMNUM         = 0x00000216U,
    SV_OPLOCKBREAKRESPONSEWAIT_PARMNUM = 0x00000217U,
}

enum : uint
{
    SV_ENABLEOPLOCKS_PARMNUM          = 0x00000218U,
    SV_ENABLEOPLOCKFORCECLOSE_PARMNUM = 0x00000219U,
}

enum uint SV_ENABLEFCBOPENS_PARMNUM = 0x0000021aU;

enum : uint
{
    SV_ENABLERAW_PARMNUM             = 0x0000021bU,
    SV_ENABLESHAREDNETDRIVES_PARMNUM = 0x0000021cU,
}

enum uint SV_MINFREECONNECTIONS_PARMNUM = 0x0000021dU;
enum uint SV_MAXFREECONNECTIONS_PARMNUM = 0x0000021eU;
enum uint SV_INITSESSTABLE_PARMNUM = 0x0000021fU;
enum uint SV_INITCONNTABLE_PARMNUM = 0x00000220U;
enum uint SV_INITFILETABLE_PARMNUM = 0x00000221U;
enum uint SV_INITSEARCHTABLE_PARMNUM = 0x00000222U;
enum uint SV_ALERTSCHEDULE_PARMNUM = 0x00000223U;
enum uint SV_ERRORTHRESHOLD_PARMNUM = 0x00000224U;
enum uint SV_NETWORKERRORTHRESHOLD_PARMNUM = 0x00000225U;
enum uint SV_DISKSPACETHRESHOLD_PARMNUM = 0x00000226U;
enum uint SV_MAXLINKDELAY_PARMNUM = 0x00000228U;
enum uint SV_MINLINKTHROUGHPUT_PARMNUM = 0x00000229U;
enum uint SV_LINKINFOVALIDTIME_PARMNUM = 0x0000022aU;
enum uint SV_SCAVQOSINFOUPDATETIME_PARMNUM = 0x0000022bU;
enum uint SV_MAXWORKITEMIDLETIME_PARMNUM = 0x0000022cU;
enum uint SV_MAXRAWWORKITEMS_PARMNUM = 0x0000022dU;
enum uint SV_PRODUCTTYPE_PARMNUM = 0x00000230U;
enum uint SV_SERVERSIZE_PARMNUM = 0x00000231U;
enum uint SV_CONNECTIONLESSAUTODISC_PARMNUM = 0x00000232U;

enum : uint
{
    SV_SHARINGVIOLATIONRETRIES_PARMNUM = 0x00000233U,
    SV_SHARINGVIOLATIONDELAY_PARMNUM   = 0x00000234U,
}

enum uint SV_MAXGLOBALOPENSEARCH_PARMNUM = 0x00000235U;
enum uint SV_REMOVEDUPLICATESEARCHES_PARMNUM = 0x00000236U;

enum : uint
{
    SV_LOCKVIOLATIONRETRIES_PARMNUM = 0x00000237U,
    SV_LOCKVIOLATIONOFFSET_PARMNUM  = 0x00000238U,
    SV_LOCKVIOLATIONDELAY_PARMNUM   = 0x00000239U,
}

enum uint SV_MDLREADSWITCHOVER_PARMNUM = 0x0000023aU;
enum uint SV_CACHEDOPENLIMIT_PARMNUM = 0x0000023bU;
enum uint SV_CRITICALTHREADS_PARMNUM = 0x0000023cU;
enum uint SV_RESTRICTNULLSESSACCESS_PARMNUM = 0x0000023dU;
enum uint SV_ENABLEWFW311DIRECTIPX_PARMNUM = 0x0000023eU;
enum uint SV_OTHERQUEUEAFFINITY_PARMNUM = 0x0000023fU;
enum uint SV_QUEUESAMPLESECS_PARMNUM = 0x00000240U;
enum uint SV_BALANCECOUNT_PARMNUM = 0x00000241U;
enum uint SV_PREFERREDAFFINITY_PARMNUM = 0x00000242U;

enum : uint
{
    SV_MAXFREERFCBS_PARMNUM           = 0x00000243U,
    SV_MAXFREEMFCBS_PARMNUM           = 0x00000244U,
    SV_MAXFREELFCBS_PARMNUM           = 0x00000245U,
    SV_MAXFREEPAGEDPOOLCHUNKS_PARMNUM = 0x00000246U,
}

enum uint SV_MINPAGEDPOOLCHUNKSIZE_PARMNUM = 0x00000247U;
enum uint SV_MAXPAGEDPOOLCHUNKSIZE_PARMNUM = 0x00000248U;
enum uint SV_SENDSFROMPREFERREDPROCESSOR_PARMNUM = 0x00000249U;
enum uint SV_MAXTHREADSPERQUEUE_PARMNUM = 0x0000024aU;
enum uint SV_CACHEDDIRECTORYLIMIT_PARMNUM = 0x0000024bU;
enum uint SV_MAXCOPYLENGTH_PARMNUM = 0x0000024cU;
enum uint SV_ENABLECOMPRESSION_PARMNUM = 0x0000024eU;

enum : uint
{
    SV_AUTOSHAREWKS_PARMNUM    = 0x0000024fU,
    SV_AUTOSHARESERVER_PARMNUM = 0x00000250U,
}

enum uint SV_ENABLESECURITYSIGNATURE_PARMNUM = 0x00000251U;
enum uint SV_REQUIRESECURITYSIGNATURE_PARMNUM = 0x00000252U;
enum uint SV_MINCLIENTBUFFERSIZE_PARMNUM = 0x00000253U;
enum uint SV_CONNECTIONNOSESSIONSTIMEOUT_PARMNUM = 0x00000254U;
enum uint SV_IDLETHREADTIMEOUT_PARMNUM = 0x00000255U;
enum uint SV_ENABLEW9XSECURITYSIGNATURE_PARMNUM = 0x00000256U;
enum uint SV_ENFORCEKERBEROSREAUTHENTICATION_PARMNUM = 0x00000257U;
enum uint SV_DISABLEDOS_PARMNUM = 0x00000258U;
enum uint SV_LOWDISKSPACEMINIMUM_PARMNUM = 0x00000259U;
enum uint SV_DISABLESTRICTNAMECHECKING_PARMNUM = 0x0000025aU;
enum uint SV_ENABLEAUTHENTICATEUSERSHARING_PARMNUM = 0x0000025bU;
enum uint SVI1_NUM_ELEMENTS = 0x00000005U;
enum uint SVI2_NUM_ELEMENTS = 0x00000028U;
enum uint SVI3_NUM_ELEMENTS = 0x0000002cU;
enum uint SV_MAX_CMD_LEN = 0x00000100U;

enum : uint
{
    SW_AUTOPROF_LOAD_MASK = 0x00000001U,
    SW_AUTOPROF_SAVE_MASK = 0x00000002U,
}

enum uint SV_MAX_SRV_HEUR_LEN = 0x00000020U;
enum uint SV_USERS_PER_LICENSE = 0x00000005U;
enum uint SVTI2_REMAP_PIPE_NAMES = 0x00000002U;
enum uint SVTI2_SCOPED_NAME = 0x00000004U;

enum : uint
{
    SVTI2_CLUSTER_NAME     = 0x00000008U,
    SVTI2_CLUSTER_DNN_NAME = 0x00000010U,
}

enum uint SVTI2_UNICODE_TRANSPORT_ADDRESS = 0x00000020U;

enum : uint
{
    SVTI2_RESERVED1 = 0x00001000U,
    SVTI2_RESERVED2 = 0x00002000U,
    SVTI2_RESERVED3 = 0x00004000U,
}

enum uint SRV_SUPPORT_HASH_GENERATION = 0x00000001U;
enum uint SRV_HASH_GENERATION_ACTIVE = 0x00000002U;
enum uint SERVICE_INSTALL_STATE = 0x00000003U;

enum : uint
{
    SERVICE_UNINSTALLED     = 0x00000000U,
    SERVICE_INSTALL_PENDING = 0x00000001U,
}

enum uint SERVICE_UNINSTALL_PENDING = 0x00000002U;

enum : uint
{
    SERVICE_INSTALLED   = 0x00000003U,
    SERVICE_PAUSE_STATE = 0x0000000cU,
}

enum : uint
{
    LM20_SERVICE_ACTIVE           = 0x00000000U,
    LM20_SERVICE_CONTINUE_PENDING = 0x00000004U,
    LM20_SERVICE_PAUSE_PENDING    = 0x00000008U,
    LM20_SERVICE_PAUSED           = 0x0000000cU,
}

enum uint SERVICE_NOT_UNINSTALLABLE = 0x00000000U;
enum uint SERVICE_UNINSTALLABLE = 0x00000010U;
enum uint SERVICE_NOT_PAUSABLE = 0x00000000U;

enum : uint
{
    SERVICE_PAUSABLE           = 0x00000020U,
    SERVICE_REDIR_PAUSED       = 0x00000700U,
    SERVICE_REDIR_DISK_PAUSED  = 0x00000100U,
    SERVICE_REDIR_PRINT_PAUSED = 0x00000200U,
    SERVICE_REDIR_COMM_PAUSED  = 0x00000400U,
}

enum const(wchar)* SERVICE_DOS_ENCRYPTION = "ENCRYPT";

enum : uint
{
    SERVICE_CTRL_INTERROGATE = 0x00000000U,
    SERVICE_CTRL_PAUSE       = 0x00000001U,
    SERVICE_CTRL_CONTINUE    = 0x00000002U,
    SERVICE_CTRL_UNINSTALL   = 0x00000003U,
    SERVICE_CTRL_REDIR_DISK  = 0x00000001U,
    SERVICE_CTRL_REDIR_PRINT = 0x00000002U,
    SERVICE_CTRL_REDIR_COMM  = 0x00000004U,
}

enum : uint
{
    SERVICE_IP_NO_HINT    = 0x00000000U,
    SERVICE_CCP_NO_HINT   = 0x00000000U,
    SERVICE_IP_QUERY_HINT = 0x00010000U,
}

enum uint SERVICE_CCP_QUERY_HINT = 0x00010000U;
enum uint SERVICE_IP_CHKPT_NUM = 0x000000ffU;
enum uint SERVICE_CCP_CHKPT_NUM = 0x000000ffU;
enum uint SERVICE_IP_WAIT_TIME = 0x0000ff00U;
enum uint SERVICE_CCP_WAIT_TIME = 0x0000ff00U;
enum uint SERVICE_IP_WAITTIME_SHIFT = 0x00000008U;
enum uint SERVICE_NTIP_WAITTIME_SHIFT = 0x0000000cU;
enum uint UPPER_HINT_MASK = 0x0000ff00U;
enum uint LOWER_HINT_MASK = 0x000000ffU;
enum uint UPPER_GET_HINT_MASK = 0x0ff00000U;
enum uint LOWER_GET_HINT_MASK = 0x0000ff00U;

enum : uint
{
    SERVICE_NT_MAXTIME              = 0x0000ffffU,
    SERVICE_RESRV_MASK              = 0x0001ffffU,
    SERVICE_MAXTIME                 = 0x000000ffU,
    SERVICE_BASE                    = 0x00000beaU,
    SERVICE_UIC_NORMAL              = 0x00000000U,
    SERVICE_UIC_BADPARMVAL          = 0x00000bebU,
    SERVICE_UIC_MISSPARM            = 0x00000becU,
    SERVICE_UIC_UNKPARM             = 0x00000bedU,
    SERVICE_UIC_RESOURCE            = 0x00000beeU,
    SERVICE_UIC_CONFIG              = 0x00000befU,
    SERVICE_UIC_SYSTEM              = 0x00000bf0U,
    SERVICE_UIC_INTERNAL            = 0x00000bf1U,
    SERVICE_UIC_AMBIGPARM           = 0x00000bf2U,
    SERVICE_UIC_DUPPARM             = 0x00000bf3U,
    SERVICE_UIC_KILL                = 0x00000bf4U,
    SERVICE_UIC_EXEC                = 0x00000bf5U,
    SERVICE_UIC_SUBSERV             = 0x00000bf6U,
    SERVICE_UIC_CONFLPARM           = 0x00000bf7U,
    SERVICE_UIC_FILE                = 0x00000bf8U,
    SERVICE_UIC_M_NULL              = 0x00000000U,
    SERVICE_UIC_M_MEMORY            = 0x00000bfeU,
    SERVICE_UIC_M_DISK              = 0x00000bffU,
    SERVICE_UIC_M_THREADS           = 0x00000c00U,
    SERVICE_UIC_M_PROCESSES         = 0x00000c01U,
    SERVICE_UIC_M_SECURITY          = 0x00000c02U,
    SERVICE_UIC_M_LANROOT           = 0x00000c03U,
    SERVICE_UIC_M_REDIR             = 0x00000c04U,
    SERVICE_UIC_M_SERVER            = 0x00000c05U,
    SERVICE_UIC_M_SEC_FILE_ERR      = 0x00000c06U,
    SERVICE_UIC_M_FILES             = 0x00000c07U,
    SERVICE_UIC_M_LOGS              = 0x00000c08U,
    SERVICE_UIC_M_LANGROUP          = 0x00000c09U,
    SERVICE_UIC_M_MSGNAME           = 0x00000c0aU,
    SERVICE_UIC_M_ANNOUNCE          = 0x00000c0bU,
    SERVICE_UIC_M_UAS               = 0x00000c0cU,
    SERVICE_UIC_M_SERVER_SEC_ERR    = 0x00000c0dU,
    SERVICE_UIC_M_WKSTA             = 0x00000c0fU,
    SERVICE_UIC_M_ERRLOG            = 0x00000c10U,
    SERVICE_UIC_M_FILE_UW           = 0x00000c11U,
    SERVICE_UIC_M_ADDPAK            = 0x00000c12U,
    SERVICE_UIC_M_LAZY              = 0x00000c13U,
    SERVICE_UIC_M_UAS_MACHINE_ACCT  = 0x00000c14U,
    SERVICE_UIC_M_UAS_SERVERS_NMEMB = 0x00000c15U,
    SERVICE_UIC_M_UAS_SERVERS_NOGRP = 0x00000c16U,
    SERVICE_UIC_M_UAS_INVALID_ROLE  = 0x00000c17U,
    SERVICE_UIC_M_NETLOGON_NO_DC    = 0x00000c18U,
    SERVICE_UIC_M_NETLOGON_DC_CFLCT = 0x00000c19U,
    SERVICE_UIC_M_NETLOGON_AUTH     = 0x00000c1aU,
    SERVICE_UIC_M_UAS_PROLOG        = 0x00000c1bU,
}

enum : uint
{
    SERVICE2_BASE                  = 0x000015e0U,
    SERVICE_UIC_M_NETLOGON_MPATH   = 0x000015e0U,
    SERVICE_UIC_M_LSA_MACHINE_ACCT = 0x000015e1U,
    SERVICE_UIC_M_DATABASE_ERROR   = 0x000015e2U,
}

enum uint USE_FLAG_GLOBAL_MAPPING = 0x00010000U;
enum uint USE_LOCAL_PARMNUM = 0x00000001U;
enum uint USE_REMOTE_PARMNUM = 0x00000002U;
enum uint USE_PASSWORD_PARMNUM = 0x00000003U;
enum uint USE_ASGTYPE_PARMNUM = 0x00000004U;
enum uint USE_USERNAME_PARMNUM = 0x00000005U;
enum uint USE_DOMAINNAME_PARMNUM = 0x00000006U;
enum uint USE_FLAGS_PARMNUM = 0x00000007U;
enum uint USE_AUTHIDENTITY_PARMNUM = 0x00000008U;
enum uint USE_SD_PARMNUM = 0x00000009U;
enum uint USE_OPTIONS_PARMNUM = 0x0000000aU;

enum : uint
{
    USE_OK     = 0x00000000U,
    USE_PAUSED = 0x00000001U,
}

enum uint USE_SESSLOST = 0x00000002U;
enum uint USE_DISCONN = 0x00000002U;
enum uint USE_NETERR = 0x00000003U;

enum : uint
{
    USE_CONN   = 0x00000004U,
    USE_RECONN = 0x00000005U,
}

enum uint USE_CHARDEV = 0x00000002U;

enum : uint
{
    CREATE_NO_CONNECT = 0x00000001U,
    CREATE_BYPASS_CSC = 0x00000002U,
    CREATE_CRED_RESET = 0x00000004U,
}

enum uint USE_DEFAULT_CREDENTIALS = 0x00000004U;

enum : uint
{
    CREATE_REQUIRE_CONNECTION_INTEGRITY = 0x00000008U,
    CREATE_REQUIRE_CONNECTION_PRIVACY   = 0x00000010U,
}

enum uint CREATE_PERSIST_MAPPING = 0x00000020U;
enum uint CREATE_WRITE_THROUGH_SEMANTICS = 0x00000040U;
enum uint CREATE_GLOBAL_MAPPING = 0x00000100U;
enum uint WKSTA_PLATFORM_ID_PARMNUM = 0x00000064U;
enum uint WKSTA_COMPUTERNAME_PARMNUM = 0x00000001U;
enum uint WKSTA_LANGROUP_PARMNUM = 0x00000002U;

enum : uint
{
    WKSTA_VER_MAJOR_PARMNUM = 0x00000004U,
    WKSTA_VER_MINOR_PARMNUM = 0x00000005U,
}

enum uint WKSTA_LOGGED_ON_USERS_PARMNUM = 0x00000006U;
enum uint WKSTA_LANROOT_PARMNUM = 0x00000007U;

enum : uint
{
    WKSTA_LOGON_DOMAIN_PARMNUM = 0x00000008U,
    WKSTA_LOGON_SERVER_PARMNUM = 0x00000009U,
}

enum : uint
{
    WKSTA_CHARWAIT_PARMNUM  = 0x0000000aU,
    WKSTA_CHARTIME_PARMNUM  = 0x0000000bU,
    WKSTA_CHARCOUNT_PARMNUM = 0x0000000cU,
}

enum : uint
{
    WKSTA_KEEPCONN_PARMNUM   = 0x0000000dU,
    WKSTA_KEEPSEARCH_PARMNUM = 0x0000000eU,
}

enum uint WKSTA_MAXCMDS_PARMNUM = 0x0000000fU;
enum uint WKSTA_NUMWORKBUF_PARMNUM = 0x00000010U;
enum uint WKSTA_MAXWRKCACHE_PARMNUM = 0x00000011U;
enum uint WKSTA_SESSTIMEOUT_PARMNUM = 0x00000012U;
enum uint WKSTA_SIZERROR_PARMNUM = 0x00000013U;
enum uint WKSTA_NUMALERTS_PARMNUM = 0x00000014U;
enum uint WKSTA_NUMSERVICES_PARMNUM = 0x00000015U;
enum uint WKSTA_NUMCHARBUF_PARMNUM = 0x00000016U;
enum uint WKSTA_SIZCHARBUF_PARMNUM = 0x00000017U;
enum uint WKSTA_ERRLOGSZ_PARMNUM = 0x0000001bU;
enum uint WKSTA_PRINTBUFTIME_PARMNUM = 0x0000001cU;
enum uint WKSTA_SIZWORKBUF_PARMNUM = 0x0000001dU;
enum uint WKSTA_MAILSLOTS_PARMNUM = 0x0000001eU;
enum uint WKSTA_NUMDGRAMBUF_PARMNUM = 0x0000001fU;
enum uint WKSTA_WRKHEURISTICS_PARMNUM = 0x00000020U;
enum uint WKSTA_MAXTHREADS_PARMNUM = 0x00000021U;

enum : uint
{
    WKSTA_LOCKQUOTA_PARMNUM     = 0x00000029U,
    WKSTA_LOCKINCREMENT_PARMNUM = 0x0000002aU,
}

enum uint WKSTA_LOCKMAXIMUM_PARMNUM = 0x0000002bU;
enum uint WKSTA_PIPEINCREMENT_PARMNUM = 0x0000002cU;
enum uint WKSTA_PIPEMAXIMUM_PARMNUM = 0x0000002dU;
enum uint WKSTA_DORMANTFILELIMIT_PARMNUM = 0x0000002eU;
enum uint WKSTA_CACHEFILETIMEOUT_PARMNUM = 0x0000002fU;
enum uint WKSTA_USEOPPORTUNISTICLOCKING_PARMNUM = 0x00000030U;
enum uint WKSTA_USEUNLOCKBEHIND_PARMNUM = 0x00000031U;
enum uint WKSTA_USECLOSEBEHIND_PARMNUM = 0x00000032U;
enum uint WKSTA_BUFFERNAMEDPIPES_PARMNUM = 0x00000033U;
enum uint WKSTA_USELOCKANDREADANDUNLOCK_PARMNUM = 0x00000034U;
enum uint WKSTA_UTILIZENTCACHING_PARMNUM = 0x00000035U;

enum : uint
{
    WKSTA_USERAWREAD_PARMNUM  = 0x00000036U,
    WKSTA_USERAWWRITE_PARMNUM = 0x00000037U,
}

enum uint WKSTA_USEWRITERAWWITHDATA_PARMNUM = 0x00000038U;
enum uint WKSTA_USEENCRYPTION_PARMNUM = 0x00000039U;
enum uint WKSTA_BUFFILESWITHDENYWRITE_PARMNUM = 0x0000003aU;
enum uint WKSTA_BUFFERREADONLYFILES_PARMNUM = 0x0000003bU;
enum uint WKSTA_FORCECORECREATEMODE_PARMNUM = 0x0000003cU;
enum uint WKSTA_USE512BYTESMAXTRANSFER_PARMNUM = 0x0000003dU;
enum uint WKSTA_READAHEADTHRUPUT_PARMNUM = 0x0000003eU;
enum uint WKSTA_OTH_DOMAINS_PARMNUM = 0x00000065U;
enum uint TRANSPORT_QUALITYOFSERVICE_PARMNUM = 0x000000c9U;
enum uint TRANSPORT_NAME_PARMNUM = 0x000000caU;

enum : int
{
    EVENT_SRV_SERVICE_FAILED    = 0xc00007d0,
    EVENT_SRV_RESOURCE_SHORTAGE = 0xc00007d1,
}

enum : int
{
    EVENT_SRV_CANT_CREATE_DEVICE  = 0xc00007d2,
    EVENT_SRV_CANT_CREATE_PROCESS = 0xc00007d3,
    EVENT_SRV_CANT_CREATE_THREAD  = 0xc00007d4,
}

enum int EVENT_SRV_UNEXPECTED_DISC = 0xc00007d5;
enum int EVENT_SRV_INVALID_REQUEST = 0xc00007d6;

enum : int
{
    EVENT_SRV_CANT_OPEN_NPFS       = 0xc00007d7,
    EVENT_SRV_CANT_GROW_TABLE      = 0x800007d9,
    EVENT_SRV_CANT_START_SCAVENGER = 0xc00007da,
}

enum : int
{
    EVENT_SRV_IRP_STACK_SIZE      = 0xc00007db,
    EVENT_SRV_NETWORK_ERROR       = 0x800007dc,
    EVENT_SRV_DISK_FULL           = 0x800007dd,
    EVENT_SRV_NO_VIRTUAL_MEMORY   = 0xc00007e0,
    EVENT_SRV_NONPAGED_POOL_LIMIT = 0xc00007e1,
}

enum int EVENT_SRV_PAGED_POOL_LIMIT = 0xc00007e2;

enum : int
{
    EVENT_SRV_NO_NONPAGED_POOL      = 0xc00007e3,
    EVENT_SRV_NO_PAGED_POOL         = 0xc00007e4,
    EVENT_SRV_NO_WORK_ITEM          = 0x800007e5,
    EVENT_SRV_NO_FREE_CONNECTIONS   = 0x800007e6,
    EVENT_SRV_NO_FREE_RAW_WORK_ITEM = 0x800007e7,
    EVENT_SRV_NO_BLOCKING_IO        = 0x800007e8,
    EVENT_SRV_DOS_ATTACK_DETECTED   = 0x800007e9,
}

enum : int
{
    EVENT_SRV_TOO_MANY_DOS         = 0x800007ea,
    EVENT_SRV_OUT_OF_WORK_ITEM_DOS = 0x800007eb,
}

enum : int
{
    EVENT_SRV_KEY_NOT_FOUND   = 0xc00009c5,
    EVENT_SRV_KEY_NOT_CREATED = 0xc00009c6,
}

enum int EVENT_SRV_NO_TRANSPORTS_BOUND = 0xc00009c7;

enum : int
{
    EVENT_SRV_CANT_BIND_TO_TRANSPORT = 0x800009c8,
    EVENT_SRV_CANT_BIND_DUP_NAME     = 0xc00009c9,
}

enum : int
{
    EVENT_SRV_INVALID_REGISTRY_VALUE  = 0x800009ca,
    EVENT_SRV_INVALID_SD              = 0x800009cb,
    EVENT_SRV_CANT_LOAD_DRIVER        = 0x800009cc,
    EVENT_SRV_CANT_UNLOAD_DRIVER      = 0x800009cd,
    EVENT_SRV_CANT_MAP_ERROR          = 0x800009ce,
    EVENT_SRV_CANT_RECREATE_SHARE     = 0x800009cf,
    EVENT_SRV_CANT_CHANGE_DOMAIN_NAME = 0x800009d0,
}

enum int EVENT_SRV_TXF_INIT_FAILED = 0x800009d1;
enum int EVENT_RDR_RESOURCE_SHORTAGE = 0x80000bb9;

enum : int
{
    EVENT_RDR_CANT_CREATE_DEVICE = 0x80000bba,
    EVENT_RDR_CANT_CREATE_THREAD = 0x80000bbb,
    EVENT_RDR_CANT_SET_THREAD    = 0x80000bbc,
}

enum : int
{
    EVENT_RDR_INVALID_REPLY      = 0x80000bbd,
    EVENT_RDR_INVALID_SMB        = 0x80000bbe,
    EVENT_RDR_INVALID_LOCK_REPLY = 0x80000bbf,
}

enum : int
{
    EVENT_RDR_FAILED_UNLOCK    = 0x80000bc1,
    EVENT_RDR_CLOSE_BEHIND     = 0x80000bc3,
    EVENT_RDR_UNEXPECTED_ERROR = 0x80000bc4,
}

enum : int
{
    EVENT_RDR_TIMEOUT              = 0x80000bc5,
    EVENT_RDR_INVALID_OPLOCK       = 0x80000bc6,
    EVENT_RDR_CONNECTION_REFERENCE = 0x80000bc7,
}

enum : int
{
    EVENT_RDR_SERVER_REFERENCE          = 0x80000bc8,
    EVENT_RDR_SMB_REFERENCE             = 0x80000bc9,
    EVENT_RDR_ENCRYPT                   = 0x80000bca,
    EVENT_RDR_CONNECTION                = 0x80000bcb,
    EVENT_RDR_MAXCMDS                   = 0x80000bcd,
    EVENT_RDR_OPLOCK_SMB                = 0x80000bce,
    EVENT_RDR_DISPOSITION               = 0x80000bcf,
    EVENT_RDR_CONTEXTS                  = 0x80000bd0,
    EVENT_RDR_WRITE_BEHIND_FLUSH_FAILED = 0x80000bd1,
}

enum : int
{
    EVENT_RDR_AT_THREAD_MAX      = 0x80000bd2,
    EVENT_RDR_CANT_READ_REGISTRY = 0x80000bd3,
}

enum int EVENT_RDR_TIMEZONE_BIAS_TOO_LARGE = 0x80000bd4;
enum int EVENT_RDR_PRIMARY_TRANSPORT_CONNECT_FAILED = 0x80000bd5;
enum int EVENT_RDR_DELAYED_SET_ATTRIBUTES_FAILED = 0x80000bd6;
enum int EVENT_RDR_DELETEONCLOSE_FAILED = 0x80000bd7;

enum : int
{
    EVENT_RDR_CANT_BIND_TRANSPORT       = 0x80000bd8,
    EVENT_RDR_CANT_REGISTER_ADDRESS     = 0x80000bd9,
    EVENT_RDR_CANT_GET_SECURITY_CONTEXT = 0x80000bda,
    EVENT_RDR_CANT_BUILD_SMB_HEADER     = 0x80000bdb,
}

enum int EVENT_RDR_SECURITY_SIGNATURE_MISMATCH = 0x80000bdc;
enum int EVENT_TCPIP6_STARTED = 0x40000c1c;

enum : int
{
    EVENT_STREAMS_STRLOG               = 0xc0000fa0,
    EVENT_STREAMS_ALLOCB_FAILURE       = 0x80000fa1,
    EVENT_STREAMS_ALLOCB_FAILURE_CNT   = 0x80000fa2,
    EVENT_STREAMS_ESBALLOC_FAILURE     = 0x80000fa3,
    EVENT_STREAMS_ESBALLOC_FAILURE_CNT = 0x80000fa4,
}

enum int EVENT_TCPIP_CREATE_DEVICE_FAILED = 0xc0001004;
enum int EVENT_TCPIP_NO_RESOURCES_FOR_INIT = 0xc0001005;

enum : int
{
    EVENT_TCPIP_TOO_MANY_NETS        = 0xc0001059,
    EVENT_TCPIP_NO_MASK              = 0xc000105a,
    EVENT_TCPIP_INVALID_ADDRESS      = 0xc000105b,
    EVENT_TCPIP_INVALID_MASK         = 0xc000105c,
    EVENT_TCPIP_NO_ADAPTER_RESOURCES = 0xc000105d,
}

enum : int
{
    EVENT_TCPIP_DHCP_INIT_FAILED    = 0x8000105e,
    EVENT_TCPIP_ADAPTER_REG_FAILURE = 0xc000105f,
}

enum int EVENT_TCPIP_INVALID_DEFAULT_GATEWAY = 0x80001060;

enum : int
{
    EVENT_TCPIP_NO_ADDRESS_LIST          = 0xc0001061,
    EVENT_TCPIP_NO_MASK_LIST             = 0xc0001062,
    EVENT_TCPIP_NO_BINDINGS              = 0xc0001063,
    EVENT_TCPIP_IP_INIT_FAILED           = 0xc0001064,
    EVENT_TCPIP_TOO_MANY_GATEWAYS        = 0x80001065,
    EVENT_TCPIP_ADDRESS_CONFLICT1        = 0xc0001066,
    EVENT_TCPIP_ADDRESS_CONFLICT2        = 0xc0001067,
    EVENT_TCPIP_NTE_CONTEXT_LIST_FAILURE = 0xc0001068,
}

enum : int
{
    EVENT_TCPIP_MEDIA_CONNECT                        = 0x40001069,
    EVENT_TCPIP_MEDIA_DISCONNECT                     = 0x4000106a,
    EVENT_TCPIP_IPV4_UNINSTALLED                     = 0x4000106b,
    EVENT_TCPIP_AUTOCONFIGURED_ADDRESS_LIMIT_REACHED = 0x8000106c,
    EVENT_TCPIP_AUTOCONFIGURED_ROUTE_LIMIT_REACHED   = 0x8000106d,
}

enum int EVENT_TCPIP_OUT_OF_ORDER_FRAGMENTS_EXCEEDED = 0x8000106e;
enum int EVENT_TCPIP_INTERFACE_BIND_FAILURE = 0xc000106f;

enum : int
{
    EVENT_TCPIP_TCP_INIT_FAILED               = 0xc0001081,
    EVENT_TCPIP_TCP_CONNECT_LIMIT_REACHED     = 0x80001082,
    EVENT_TCPIP_TCP_TIME_WAIT_COLLISION       = 0x80001083,
    EVENT_TCPIP_TCP_WSD_WS_RESTRICTED         = 0x80001084,
    EVENT_TCPIP_TCP_MPP_ATTACKS_DETECTED      = 0x80001085,
    EVENT_TCPIP_TCP_CONNECTIONS_PERF_IMPACTED = 0x80001086,
}

enum int EVENT_TCPIP_TCP_GLOBAL_EPHEMERAL_PORT_SPACE_EXHAUSTED = 0x80001087;

enum : int
{
    EVENT_TCPIP_UDP_LIMIT_REACHED                         = 0x800010a9,
    EVENT_TCPIP_UDP_GLOBAL_EPHEMERAL_PORT_SPACE_EXHAUSTED = 0x800010aa,
}

enum : int
{
    EVENT_TCPIP_PCF_MULTICAST_OID_ISSUE  = 0x800010c2,
    EVENT_TCPIP_PCF_MISSING_CAPABILITY   = 0x800010c3,
    EVENT_TCPIP_PCF_SET_FILTER_FAILURE   = 0x800010c4,
    EVENT_TCPIP_PCF_NO_ARP_FILTER        = 0x800010c5,
    EVENT_TCPIP_PCF_CLEAR_FILTER_FAILURE = 0xc00010c6,
}

enum : int
{
    EVENT_NBT_CREATE_DRIVER   = 0xc00010cc,
    EVENT_NBT_OPEN_REG_PARAMS = 0xc00010cd,
}

enum : int
{
    EVENT_NBT_NO_BACKUP_WINS        = 0x800010ce,
    EVENT_NBT_NO_WINS               = 0x800010cf,
    EVENT_NBT_BAD_BACKUP_WINS_ADDR  = 0x800010d0,
    EVENT_NBT_BAD_PRIMARY_WINS_ADDR = 0x800010d1,
}

enum int EVENT_NBT_NAME_SERVER_ADDRS = 0xc00010d2;

enum : int
{
    EVENT_NBT_CREATE_ADDRESS    = 0xc00010d3,
    EVENT_NBT_CREATE_CONNECTION = 0xc00010d4,
}

enum : int
{
    EVENT_NBT_NON_OS_INIT      = 0xc00010d5,
    EVENT_NBT_TIMERS           = 0xc00010d6,
    EVENT_NBT_CREATE_DEVICE    = 0x400010d7,
    EVENT_NBT_NO_DEVICES       = 0x800010d8,
    EVENT_NBT_OPEN_REG_LINKAGE = 0xc00010d9,
}

enum : int
{
    EVENT_NBT_READ_BIND           = 0xc00010da,
    EVENT_NBT_READ_EXPORT         = 0xc00010db,
    EVENT_NBT_OPEN_REG_NAMESERVER = 0x800010dc,
}

enum : int
{
    EVENT_SCOPE_LABEL_TOO_LONG = 0x800010dd,
    EVENT_SCOPE_TOO_LONG       = 0x800010de,
}

enum : int
{
    EVENT_NBT_DUPLICATE_NAME       = 0xc00010df,
    EVENT_NBT_NAME_RELEASE         = 0xc00010e0,
    EVENT_NBT_DUPLICATE_NAME_ERROR = 0xc00010e1,
}

enum int EVENT_NBT_NO_RESOURCES = 0xc00010e2;
enum int EVENT_NDIS_RESOURCE_CONFLICT = 0xc0001388;

enum : int
{
    EVENT_NDIS_OUT_OF_RESOURCE   = 0xc0001389,
    EVENT_NDIS_HARDWARE_FAILURE  = 0xc000138a,
    EVENT_NDIS_ADAPTER_NOT_FOUND = 0xc000138b,
}

enum int EVENT_NDIS_INTERRUPT_CONNECT = 0xc000138c;

enum : int
{
    EVENT_NDIS_DRIVER_FAILURE            = 0xc000138d,
    EVENT_NDIS_BAD_VERSION               = 0xc000138e,
    EVENT_NDIS_TIMEOUT                   = 0x8000138f,
    EVENT_NDIS_NETWORK_ADDRESS           = 0xc0001390,
    EVENT_NDIS_UNSUPPORTED_CONFIGURATION = 0xc0001391,
}

enum int EVENT_NDIS_INVALID_VALUE_FROM_ADAPTER = 0xc0001392;
enum int EVENT_NDIS_MISSING_CONFIGURATION_PARAMETER = 0xc0001393;
enum int EVENT_NDIS_BAD_IO_BASE_ADDRESS = 0xc0001394;
enum int EVENT_NDIS_RECEIVE_SPACE_SMALL = 0x40001395;

enum : int
{
    EVENT_NDIS_ADAPTER_DISABLED     = 0x80001396,
    EVENT_NDIS_IO_PORT_CONFLICT     = 0x80001397,
    EVENT_NDIS_PORT_OR_DMA_CONFLICT = 0x80001398,
}

enum : int
{
    EVENT_NDIS_MEMORY_CONFLICT    = 0x80001399,
    EVENT_NDIS_INTERRUPT_CONFLICT = 0x8000139a,
}

enum : int
{
    EVENT_NDIS_DMA_CONFLICT                = 0x8000139b,
    EVENT_NDIS_INVALID_DOWNLOAD_FILE_ERROR = 0xc000139c,
}

enum : int
{
    EVENT_NDIS_MAXRECEIVES_ERROR     = 0x8000139d,
    EVENT_NDIS_MAXTRANSMITS_ERROR    = 0x8000139e,
    EVENT_NDIS_MAXFRAMESIZE_ERROR    = 0x8000139f,
    EVENT_NDIS_MAXINTERNALBUFS_ERROR = 0x800013a0,
    EVENT_NDIS_MAXMULTICAST_ERROR    = 0x800013a1,
}

enum : int
{
    EVENT_NDIS_PRODUCTID_ERROR   = 0x800013a2,
    EVENT_NDIS_LOBE_FAILUE_ERROR = 0x800013a3,
}

enum int EVENT_NDIS_SIGNAL_LOSS_ERROR = 0x800013a4;
enum int EVENT_NDIS_REMOVE_RECEIVED_ERROR = 0x800013a5;
enum int EVENT_NDIS_TOKEN_RING_CORRECTION = 0x400013a6;
enum int EVENT_NDIS_ADAPTER_CHECK_ERROR = 0xc00013a7;
enum int EVENT_NDIS_RESET_FAILURE_ERROR = 0x800013a8;
enum int EVENT_NDIS_CABLE_DISCONNECTED_ERROR = 0x800013a9;
enum int EVENT_NDIS_RESET_FAILURE_CORRECTION = 0x800013aa;

enum : int
{
    EVENT_EventlogStarted          = 0x80001775,
    EVENT_EventlogStopped          = 0x80001776,
    EVENT_EventlogAbnormalShutdown = 0x80001778,
}

enum int EVENT_EventLogProductInfo = 0x80001779;
enum int EVENT_ComputerNameChange = 0x8000177b;
enum int EVENT_DNSDomainNameChange = 0x8000177c;
enum int EVENT_EventlogUptime = 0x8000177d;
enum int EVENT_UP_DRIVER_ON_MP = 0xc00017d4;

enum : int
{
    EVENT_SERVICE_START_FAILED       = 0xc0001b58,
    EVENT_SERVICE_START_FAILED_II    = 0xc0001b59,
    EVENT_SERVICE_START_FAILED_GROUP = 0xc0001b5a,
    EVENT_SERVICE_START_FAILED_NONE  = 0xc0001b5b,
}

enum : int
{
    EVENT_CALL_TO_FUNCTION_FAILED    = 0xc0001b5d,
    EVENT_CALL_TO_FUNCTION_FAILED_II = 0xc0001b5e,
}

enum int EVENT_REVERTED_TO_LASTKNOWNGOOD = 0xc0001b5f;
enum int EVENT_BAD_ACCOUNT_NAME = 0xc0001b60;
enum int EVENT_CONNECTION_TIMEOUT = 0xc0001b61;
enum int EVENT_READFILE_TIMEOUT = 0xc0001b62;

enum : int
{
    EVENT_TRANSACT_TIMEOUT = 0xc0001b63,
    EVENT_TRANSACT_INVALID = 0xc0001b64,
}

enum int EVENT_FIRST_LOGON_FAILED = 0xc0001b65;
enum int EVENT_SECOND_LOGON_FAILED = 0xc0001b66;
enum int EVENT_INVALID_DRIVER_DEPENDENCY = 0xc0001b67;
enum int EVENT_BAD_SERVICE_STATE = 0xc0001b68;

enum : int
{
    EVENT_CIRCULAR_DEPENDENCY_DEMAND = 0xc0001b69,
    EVENT_CIRCULAR_DEPENDENCY_AUTO   = 0xc0001b6a,
}

enum : int
{
    EVENT_DEPEND_ON_LATER_SERVICE = 0xc0001b6b,
    EVENT_DEPEND_ON_LATER_GROUP   = 0xc0001b6c,
}

enum int EVENT_SEVERE_SERVICE_FAILED = 0xc0001b6d;

enum : int
{
    EVENT_SERVICE_START_HUNG           = 0xc0001b6e,
    EVENT_SERVICE_EXIT_FAILED          = 0xc0001b6f,
    EVENT_SERVICE_EXIT_FAILED_SPECIFIC = 0xc0001b70,
    EVENT_SERVICE_START_AT_BOOT_FAILED = 0xc0001b71,
}

enum int EVENT_BOOT_SYSTEM_DRIVERS_FAILED = 0xc0001b72;
enum int EVENT_RUNNING_LASTKNOWNGOOD = 0xc0001b73;
enum int EVENT_TAKE_OWNERSHIP = 0xc0001b74;
enum int TITLE_SC_MESSAGE_BOX = 0xc0001b75;

enum : int
{
    EVENT_SERVICE_NOT_INTERACTIVE       = 0xc0001b76,
    EVENT_SERVICE_CRASH                 = 0xc0001b77,
    EVENT_SERVICE_RECOVERY_FAILED       = 0xc0001b78,
    EVENT_SERVICE_SCESRV_FAILED         = 0xc0001b79,
    EVENT_SERVICE_CRASH_NO_ACTION       = 0xc0001b7a,
    EVENT_SERVICE_CONTROL_SUCCESS       = 0x40001b7b,
    EVENT_SERVICE_STATUS_SUCCESS        = 0x40001b7c,
    EVENT_SERVICE_CONFIG_BACKOUT_FAILED = 0xc0001b7d,
}

enum int EVENT_FIRST_LOGON_FAILED_II = 0xc0001b7e;
enum int EVENT_SERVICE_DIFFERENT_PID_CONNECTED = 0x80001b7f;

enum : int
{
    EVENT_SERVICE_START_TYPE_CHANGED     = 0x40001b80,
    EVENT_SERVICE_LOGON_TYPE_NOT_GRANTED = 0xc0001b81,
}

enum int EVENT_SERVICE_STOP_SUCCESS_WITH_REASON = 0x40001b82;
enum int EVENT_SERVICE_SHUTDOWN_FAILED = 0xc0001b83;

enum : int
{
    EVENT_COMMAND_NOT_INTERACTIVE = 0xc0001edc,
    EVENT_COMMAND_START_FAILED    = 0xc0001edd,
}

enum : int
{
    EVENT_BOWSER_OTHER_MASTER_ON_NET           = 0xc0001f43,
    EVENT_BOWSER_PROMOTED_WHILE_ALREADY_MASTER = 0x80001f44,
}

enum int EVENT_BOWSER_NON_MASTER_MASTER_ANNOUNCE = 0x80001f45;
enum int EVENT_BOWSER_ILLEGAL_DATAGRAM = 0x80001f46;
enum int EVENT_BROWSER_STATUS_BITS_UPDATE_FAILED = 0xc0001f47;

enum : int
{
    EVENT_BROWSER_ROLE_CHANGE_FAILED      = 0xc0001f48,
    EVENT_BROWSER_MASTER_PROMOTION_FAILED = 0xc0001f49,
}

enum int EVENT_BOWSER_NAME_CONVERSION_FAILED = 0xc0001f4a;
enum int EVENT_BROWSER_OTHERDOMAIN_ADD_FAILED = 0xc0001f4b;

enum : int
{
    EVENT_BOWSER_ELECTION_RECEIVED                = 0x00001f4c,
    EVENT_BOWSER_ELECTION_SENT_GETBLIST_FAILED    = 0x40001f4d,
    EVENT_BOWSER_ELECTION_SENT_FIND_MASTER_FAILED = 0x40001f4e,
}

enum int EVENT_BROWSER_ELECTION_SENT_LANMAN_NT_STARTED = 0x40001f4f;
enum int EVENT_BOWSER_ILLEGAL_DATAGRAM_THRESHOLD = 0xc0001f50;
enum int EVENT_BROWSER_DEPENDANT_SERVICE_FAILED = 0xc0001f51;

enum : int
{
    EVENT_BROWSER_MASTER_PROMOTION_FAILED_STOPPING  = 0xc0001f53,
    EVENT_BROWSER_MASTER_PROMOTION_FAILED_NO_MASTER = 0xc0001f54,
}

enum : int
{
    EVENT_BROWSER_SERVER_LIST_FAILED = 0x80001f55,
    EVENT_BROWSER_DOMAIN_LIST_FAILED = 0x80001f56,
    EVENT_BROWSER_ILLEGAL_CONFIG     = 0x80001f57,
}

enum int EVENT_BOWSER_OLD_BACKUP_FOUND = 0x40001f58;
enum int EVENT_BROWSER_SERVER_LIST_RETRIEVED = 0x00001f59;
enum int EVENT_BROWSER_DOMAIN_LIST_RETRIEVED = 0x00001f5a;

enum : int
{
    EVENT_BOWSER_PDC_LOST_ELECTION    = 0x40001f5b,
    EVENT_BOWSER_NON_PDC_WON_ELECTION = 0x40001f5c,
}

enum : int
{
    EVENT_BOWSER_CANT_READ_REGISTRY                   = 0x40001f5d,
    EVENT_BOWSER_MAILSLOT_DATAGRAM_THRESHOLD_EXCEEDED = 0x40001f5e,
}

enum int EVENT_BOWSER_GETBROWSERLIST_THRESHOLD_EXCEEDED = 0x40001f5f;

enum : int
{
    EVENT_BROWSER_BACKUP_STOPPED                  = 0xc0001f60,
    EVENT_BROWSER_ELECTION_SENT_LANMAN_NT_STOPPED = 0x40001f61,
}

enum int EVENT_BROWSER_GETBLIST_RECEIVED_NOT_MASTER = 0xc0001f62;
enum int EVENT_BROWSER_ELECTION_SENT_ROLE_CHANGED = 0x40001f63;
enum int EVENT_BROWSER_NOT_STARTED_IPX_CONFIG_MISMATCH = 0xc0001f64;

enum : int
{
    EVENT_BROWSER_REMOTE_MAILSLOTS_ENABLED            = 0x80001f65,
    EVENT_BROWSER_REMOTE_MAILSLOTS_DISABLED           = 0x40001f66,
    EVENT_BROWSER_REMOTE_MAILSLOTS_ENABLED_BY_POLICY  = 0x80001f67,
    EVENT_BROWSER_REMOTE_MAILSLOTS_DISABLED_BY_POLICY = 0x40001f68,
}

enum : int
{
    NWSAP_EVENT_KEY_NOT_FOUND      = 0xc0002134,
    NWSAP_EVENT_WSASTARTUP_FAILED  = 0xc0002135,
    NWSAP_EVENT_SOCKET_FAILED      = 0xc0002136,
    NWSAP_EVENT_SETOPTBCAST_FAILED = 0xc0002137,
}

enum : int
{
    NWSAP_EVENT_BIND_FAILED        = 0xc0002138,
    NWSAP_EVENT_GETSOCKNAME_FAILED = 0xc0002139,
}

enum : int
{
    NWSAP_EVENT_OPTEXTENDEDADDR_FAILED = 0xc000213a,
    NWSAP_EVENT_OPTBCASTINADDR_FAILED  = 0xc000213b,
}

enum : int
{
    NWSAP_EVENT_CARDMALLOC_FAILED   = 0xc000213c,
    NWSAP_EVENT_NOCARDS             = 0xc000213d,
    NWSAP_EVENT_THREADEVENT_FAIL    = 0xc000213e,
    NWSAP_EVENT_RECVSEM_FAIL        = 0xc000213f,
    NWSAP_EVENT_SENDEVENT_FAIL      = 0xc0002140,
    NWSAP_EVENT_STARTRECEIVE_ERROR  = 0xc0002141,
    NWSAP_EVENT_STARTWORKER_ERROR   = 0xc0002142,
    NWSAP_EVENT_TABLE_MALLOC_FAILED = 0xc0002143,
}

enum int NWSAP_EVENT_HASHTABLE_MALLOC_FAILED = 0xc0002144;
enum int NWSAP_EVENT_STARTLPCWORKER_ERROR = 0xc0002145;

enum : int
{
    NWSAP_EVENT_CREATELPCPORT_ERROR  = 0xc0002146,
    NWSAP_EVENT_CREATELPCEVENT_ERROR = 0xc0002147,
}

enum : int
{
    NWSAP_EVENT_LPCLISTENMEMORY_ERROR = 0xc0002148,
    NWSAP_EVENT_LPCHANDLEMEMORY_ERROR = 0xc0002149,
}

enum int NWSAP_EVENT_BADWANFILTER_VALUE = 0xc000214a;
enum int NWSAP_EVENT_CARDLISTEVENT_FAIL = 0xc000214b;

enum : int
{
    NWSAP_EVENT_SDMDEVENT_FAIL     = 0xc000214c,
    NWSAP_EVENT_INVALID_FILTERNAME = 0x8000214d,
}

enum : int
{
    NWSAP_EVENT_WANSEM_FAIL          = 0xc000214e,
    NWSAP_EVENT_WANSOCKET_FAILED     = 0xc000214f,
    NWSAP_EVENT_WANBIND_FAILED       = 0xc0002150,
    NWSAP_EVENT_STARTWANWORKER_ERROR = 0xc0002151,
    NWSAP_EVENT_STARTWANCHECK_ERROR  = 0xc0002152,
}

enum int NWSAP_EVENT_OPTMAXADAPTERNUM_ERROR = 0xc0002153;

enum : int
{
    NWSAP_EVENT_WANHANDLEMEMORY_ERROR = 0xc0002154,
    NWSAP_EVENT_WANEVENT_ERROR        = 0xc0002155,
}

enum : int
{
    EVENT_TRANSPORT_RESOURCE_POOL     = 0x80002329,
    EVENT_TRANSPORT_RESOURCE_LIMIT    = 0x8000232a,
    EVENT_TRANSPORT_RESOURCE_SPECIFIC = 0x8000232b,
    EVENT_TRANSPORT_REGISTER_FAILED   = 0xc000232c,
    EVENT_TRANSPORT_BINDING_FAILED    = 0xc000232d,
    EVENT_TRANSPORT_ADAPTER_NOT_FOUND = 0xc000232e,
    EVENT_TRANSPORT_SET_OID_FAILED    = 0xc000232f,
    EVENT_TRANSPORT_QUERY_OID_FAILED  = 0xc0002330,
    EVENT_TRANSPORT_TRANSFER_DATA     = 0x40002331,
    EVENT_TRANSPORT_TOO_MANY_LINKS    = 0x40002332,
    EVENT_TRANSPORT_BAD_PROTOCOL      = 0x40002333,
}

enum int EVENT_IPX_NEW_DEFAULT_TYPE = 0x4000251d;

enum : int
{
    EVENT_IPX_SAP_ANNOUNCE         = 0x8000251e,
    EVENT_IPX_ILLEGAL_CONFIG       = 0x8000251f,
    EVENT_IPX_INTERNAL_NET_INVALID = 0xc0002520,
}

enum : int
{
    EVENT_IPX_NO_FRAME_TYPES = 0xc0002521,
    EVENT_IPX_CREATE_DEVICE  = 0xc0002522,
    EVENT_IPX_NO_ADAPTERS    = 0xc0002523,
}

enum int EVENT_RPCSS_CREATEPROCESS_FAILURE = 0xc0002710;
enum int EVENT_RPCSS_RUNAS_CREATEPROCESS_FAILURE = 0xc0002711;
enum int EVENT_RPCSS_LAUNCH_ACCESS_DENIED = 0xc0002712;
enum int EVENT_RPCSS_DEFAULT_LAUNCH_ACCESS_DENIED = 0xc0002713;

enum : int
{
    EVENT_RPCSS_RUNAS_CANT_LOGIN      = 0xc0002714,
    EVENT_RPCSS_START_SERVICE_FAILURE = 0xc0002715,
}

enum : int
{
    EVENT_RPCSS_REMOTE_SIDE_ERROR           = 0xc0002716,
    EVENT_RPCSS_ACTIVATION_ERROR            = 0xc0002717,
    EVENT_RPCSS_REMOTE_SIDE_ERROR_WITH_FILE = 0xc0002718,
    EVENT_RPCSS_REMOTE_SIDE_UNAVAILABLE     = 0xc0002719,
}

enum : int
{
    EVENT_RPCSS_SERVER_START_TIMEOUT  = 0xc000271a,
    EVENT_RPCSS_SERVER_NOT_RESPONDING = 0xc000271b,
}

enum int EVENT_DCOM_ASSERTION_FAILURE = 0xc000271c;
enum int EVENT_DCOM_INVALID_ENDPOINT_DATA = 0xc000271d;
enum int EVENT_DCOM_COMPLUS_DISABLED = 0xc000271e;
enum int EVENT_RPCSS_STOP_SERVICE_FAILURE = 0xc000272d;
enum int EVENT_RPCSS_CREATEDEBUGGERPROCESS_FAILURE = 0xc000272e;

enum : int
{
    EVENT_DNS_CACHE_START_FAILURE_NO_DLL             = 0xc0002af8,
    EVENT_DNS_CACHE_START_FAILURE_NO_ENTRY           = 0xc0002af9,
    EVENT_DNS_CACHE_START_FAILURE_NO_CONTROL         = 0xc0002afa,
    EVENT_DNS_CACHE_START_FAILURE_NO_DONE_EVENT      = 0xc0002afb,
    EVENT_DNS_CACHE_START_FAILURE_NO_RPC             = 0xc0002afc,
    EVENT_DNS_CACHE_START_FAILURE_NO_SHUTDOWN_NOTIFY = 0xc0002afd,
    EVENT_DNS_CACHE_START_FAILURE_NO_UPDATE          = 0xc0002afe,
    EVENT_DNS_CACHE_START_FAILURE_LOW_MEMORY         = 0xc0002aff,
}

enum : int
{
    EVENT_DNS_CACHE_NETWORK_PERF_WARNING           = 0x80002b2a,
    EVENT_DNS_CACHE_UNABLE_TO_REACH_SERVER_WARNING = 0x80002b2b,
}

enum : int
{
    EVENT_DNSAPI_REGISTRATION_FAILED_TIMEOUT    = 0x80002b8e,
    EVENT_DNSAPI_REGISTRATION_FAILED_SERVERFAIL = 0x80002b8f,
    EVENT_DNSAPI_REGISTRATION_FAILED_NOTSUPP    = 0x80002b90,
    EVENT_DNSAPI_REGISTRATION_FAILED_REFUSED    = 0x80002b91,
    EVENT_DNSAPI_REGISTRATION_FAILED_SECURITY   = 0x80002b92,
    EVENT_DNSAPI_REGISTRATION_FAILED_OTHER      = 0x80002b93,
}

enum : int
{
    EVENT_DNSAPI_PTR_REGISTRATION_FAILED_TIMEOUT    = 0x80002b94,
    EVENT_DNSAPI_PTR_REGISTRATION_FAILED_SERVERFAIL = 0x80002b95,
    EVENT_DNSAPI_PTR_REGISTRATION_FAILED_NOTSUPP    = 0x80002b96,
    EVENT_DNSAPI_PTR_REGISTRATION_FAILED_REFUSED    = 0x80002b97,
    EVENT_DNSAPI_PTR_REGISTRATION_FAILED_SECURITY   = 0x80002b98,
    EVENT_DNSAPI_PTR_REGISTRATION_FAILED_OTHER      = 0x80002b99,
}

enum : int
{
    EVENT_DNSAPI_REGISTRATION_FAILED_TIMEOUT_PRIMARY_DN    = 0x80002b9a,
    EVENT_DNSAPI_REGISTRATION_FAILED_SERVERFAIL_PRIMARY_DN = 0x80002b9b,
    EVENT_DNSAPI_REGISTRATION_FAILED_NOTSUPP_PRIMARY_DN    = 0x80002b9c,
    EVENT_DNSAPI_REGISTRATION_FAILED_REFUSED_PRIMARY_DN    = 0x80002b9d,
    EVENT_DNSAPI_REGISTRATION_FAILED_SECURITY_PRIMARY_DN   = 0x80002b9e,
    EVENT_DNSAPI_REGISTRATION_FAILED_OTHER_PRIMARY_DN      = 0x80002b9f,
}

enum : int
{
    EVENT_DNSAPI_DEREGISTRATION_FAILED_TIMEOUT    = 0x80002bac,
    EVENT_DNSAPI_DEREGISTRATION_FAILED_SERVERFAIL = 0x80002bad,
    EVENT_DNSAPI_DEREGISTRATION_FAILED_NOTSUPP    = 0x80002bae,
    EVENT_DNSAPI_DEREGISTRATION_FAILED_REFUSED    = 0x80002baf,
    EVENT_DNSAPI_DEREGISTRATION_FAILED_SECURITY   = 0x80002bb0,
    EVENT_DNSAPI_DEREGISTRATION_FAILED_OTHER      = 0x80002bb1,
}

enum : int
{
    EVENT_DNSAPI_PTR_DEREGISTRATION_FAILED_TIMEOUT    = 0x80002bb2,
    EVENT_DNSAPI_PTR_DEREGISTRATION_FAILED_SERVERFAIL = 0x80002bb3,
    EVENT_DNSAPI_PTR_DEREGISTRATION_FAILED_NOTSUPP    = 0x80002bb4,
    EVENT_DNSAPI_PTR_DEREGISTRATION_FAILED_REFUSED    = 0x80002bb5,
    EVENT_DNSAPI_PTR_DEREGISTRATION_FAILED_SECURITY   = 0x80002bb6,
    EVENT_DNSAPI_PTR_DEREGISTRATION_FAILED_OTHER      = 0x80002bb7,
}

enum : int
{
    EVENT_DNSAPI_DEREGISTRATION_FAILED_TIMEOUT_PRIMARY_DN    = 0x80002bb8,
    EVENT_DNSAPI_DEREGISTRATION_FAILED_SERVERFAIL_PRIMARY_DN = 0x80002bb9,
    EVENT_DNSAPI_DEREGISTRATION_FAILED_NOTSUPP_PRIMARY_DN    = 0x80002bba,
    EVENT_DNSAPI_DEREGISTRATION_FAILED_REFUSED_PRIMARY_DN    = 0x80002bbb,
    EVENT_DNSAPI_DEREGISTRATION_FAILED_SECURITY_PRIMARY_DN   = 0x80002bbc,
    EVENT_DNSAPI_DEREGISTRATION_FAILED_OTHER_PRIMARY_DN      = 0x80002bbd,
}

enum : int
{
    EVENT_DNSAPI_REGISTERED_ADAPTER            = 0x40002bc0,
    EVENT_DNSAPI_REGISTERED_PTR                = 0x40002bc1,
    EVENT_DNSAPI_REGISTERED_ADAPTER_PRIMARY_DN = 0x40002bc2,
}

enum : int
{
    EVENT_TRK_INTERNAL_ERROR              = 0xc00030d4,
    EVENT_TRK_SERVICE_START_SUCCESS       = 0x400030d5,
    EVENT_TRK_SERVICE_START_FAILURE       = 0xc00030d6,
    EVENT_TRK_SERVICE_CORRUPT_LOG         = 0xc00030d7,
    EVENT_TRK_SERVICE_VOL_QUOTA_EXCEEDED  = 0x800030d8,
    EVENT_TRK_SERVICE_VOLUME_CREATE       = 0x400030d9,
    EVENT_TRK_SERVICE_VOLUME_CLAIM        = 0x400030da,
    EVENT_TRK_SERVICE_DUPLICATE_VOLIDS    = 0x400030db,
    EVENT_TRK_SERVICE_MOVE_QUOTA_EXCEEDED = 0x800030dc,
}

enum : int
{
    EVENT_FRS_ERROR                = 0xc00034bc,
    EVENT_FRS_STARTING             = 0x400034bd,
    EVENT_FRS_STOPPING             = 0x400034be,
    EVENT_FRS_STOPPED              = 0x400034bf,
    EVENT_FRS_STOPPED_FORCE        = 0xc00034c0,
    EVENT_FRS_STOPPED_ASSERT       = 0xc00034c1,
    EVENT_FRS_ASSERT               = 0xc00034c2,
    EVENT_FRS_VOLUME_NOT_SUPPORTED = 0xc00034c3,
}

enum : int
{
    EVENT_FRS_LONG_JOIN          = 0x800034c4,
    EVENT_FRS_LONG_JOIN_DONE     = 0x800034c5,
    EVENT_FRS_CANNOT_COMMUNICATE = 0xc00034c6,
}

enum : int
{
    EVENT_FRS_DATABASE_SPACE           = 0xc00034c7,
    EVENT_FRS_DISK_WRITE_CACHE_ENABLED = 0x800034c8,
}

enum : int
{
    EVENT_FRS_JET_1414                     = 0xc00034c9,
    EVENT_FRS_SYSVOL_NOT_READY             = 0x800034ca,
    EVENT_FRS_SYSVOL_NOT_READY_PRIMARY     = 0x800034cb,
    EVENT_FRS_SYSVOL_READY                 = 0x400034cc,
    EVENT_FRS_ACCESS_CHECKS_DISABLED       = 0x800034cd,
    EVENT_FRS_ACCESS_CHECKS_FAILED_USER    = 0x800034ce,
    EVENT_FRS_ACCESS_CHECKS_FAILED_UNKNOWN = 0xc00034cf,
}

enum int EVENT_FRS_MOVED_PREEXISTING = 0x800034d0;
enum int EVENT_FRS_CANNOT_START_BACKUP_RESTORE_IN_PROGRESS = 0xc00034d1;
enum int EVENT_FRS_STAGING_AREA_FULL = 0x800034d2;

enum : int
{
    EVENT_FRS_HUGE_FILE          = 0x800034d3,
    EVENT_FRS_CANNOT_CREATE_UUID = 0xc00034d4,
}

enum : int
{
    EVENT_FRS_NO_DNS_ATTRIBUTE = 0x800034d5,
    EVENT_FRS_NO_SID           = 0xc00034d6,
}

enum : int
{
    NTFRSPRF_OPEN_RPC_BINDING_ERROR_SET  = 0xc00034d7,
    NTFRSPRF_OPEN_RPC_BINDING_ERROR_CONN = 0xc00034d8,
    NTFRSPRF_OPEN_RPC_CALL_ERROR_SET     = 0xc00034d9,
    NTFRSPRF_OPEN_RPC_CALL_ERROR_CONN    = 0xc00034da,
}

enum : int
{
    NTFRSPRF_COLLECT_RPC_BINDING_ERROR_SET  = 0xc00034db,
    NTFRSPRF_COLLECT_RPC_BINDING_ERROR_CONN = 0xc00034dc,
    NTFRSPRF_COLLECT_RPC_CALL_ERROR_SET     = 0xc00034dd,
    NTFRSPRF_COLLECT_RPC_CALL_ERROR_CONN    = 0xc00034de,
}

enum : int
{
    NTFRSPRF_VIRTUALALLOC_ERROR_SET  = 0xc00034df,
    NTFRSPRF_VIRTUALALLOC_ERROR_CONN = 0xc00034e0,
}

enum : int
{
    NTFRSPRF_REGISTRY_ERROR_SET  = 0xc00034e1,
    NTFRSPRF_REGISTRY_ERROR_CONN = 0xc00034e2,
}

enum : int
{
    EVENT_FRS_ROOT_NOT_VALID  = 0xc00034e3,
    EVENT_FRS_STAGE_NOT_VALID = 0xc00034e4,
}

enum : int
{
    EVENT_FRS_OVERLAPS_LOGGING     = 0xc00034e5,
    EVENT_FRS_OVERLAPS_WORKING     = 0xc00034e6,
    EVENT_FRS_OVERLAPS_STAGE       = 0xc00034e7,
    EVENT_FRS_OVERLAPS_ROOT        = 0xc00034e8,
    EVENT_FRS_OVERLAPS_OTHER_STAGE = 0xc00034e9,
}

enum int EVENT_FRS_PREPARE_ROOT_FAILED = 0xc00034ea;

enum : int
{
    EVENT_FRS_BAD_REG_DATA        = 0x800034eb,
    EVENT_FRS_JOIN_FAIL_TIME_SKEW = 0xc00034ec,
}

enum int EVENT_FRS_RMTCO_TIME_SKEW = 0xc00034ed;

enum : int
{
    EVENT_FRS_CANT_OPEN_STAGE      = 0xc00034ee,
    EVENT_FRS_CANT_OPEN_PREINSTALL = 0xc00034ef,
}

enum : int
{
    EVENT_FRS_REPLICA_SET_CREATE_FAIL = 0xc00034f0,
    EVENT_FRS_REPLICA_SET_CREATE_OK   = 0x400034f1,
    EVENT_FRS_REPLICA_SET_CXTIONS     = 0x400034f2,
}

enum : int
{
    EVENT_FRS_IN_ERROR_STATE         = 0xc00034f3,
    EVENT_FRS_REPLICA_NO_ROOT_CHANGE = 0xc00034f4,
}

enum : int
{
    EVENT_FRS_DUPLICATE_IN_CXTION_SYSVOL = 0xc00034f5,
    EVENT_FRS_DUPLICATE_IN_CXTION        = 0xc00034f6,
}

enum : int
{
    EVENT_FRS_ROOT_HAS_MOVED            = 0xc00034f7,
    EVENT_FRS_ERROR_REPLICA_SET_DELETED = 0x800034f8,
}

enum int EVENT_FRS_REPLICA_IN_JRNL_WRAP_ERROR = 0xc00034f9;
enum int EVENT_FRS_DS_POLL_ERROR_SUMMARY = 0x800034fa;
enum int EVENT_PS_GPC_REGISTER_FAILED = 0xc00036b0;
enum int EVENT_PS_NO_RESOURCES_FOR_INIT = 0xc00036b1;

enum : int
{
    EVENT_PS_REGISTER_PROTOCOL_FAILED = 0xc00036b2,
    EVENT_PS_REGISTER_MINIPORT_FAILED = 0xc00036b3,
}

enum int EVENT_PS_BAD_BESTEFFORT_LIMIT = 0x80003714;

enum : int
{
    EVENT_PS_QUERY_OID_GEN_MAXIMUM_FRAME_SIZE = 0xc0003715,
    EVENT_PS_QUERY_OID_GEN_MAXIMUM_TOTAL_SIZE = 0xc0003716,
    EVENT_PS_QUERY_OID_GEN_LINK_SPEED         = 0xc0003717,
}

enum int EVENT_PS_BINDING_FAILED = 0xc0003718;
enum int EVENT_PS_MISSING_ADAPTER_REGISTRY_DATA = 0xc0003719;
enum int EVENT_PS_REGISTER_ADDRESS_FAMILY_FAILED = 0xc000371a;
enum int EVENT_PS_INIT_DEVICE_FAILED = 0xc000371b;
enum int EVENT_PS_WMI_INSTANCE_NAME_FAILED = 0xc000371c;
enum int EVENT_PS_WAN_LIMITED_BESTEFFORT = 0x8000371d;

enum : int
{
    EVENT_PS_RESOURCE_POOL             = 0xc000371e,
    EVENT_PS_ADMISSIONCONTROL_OVERFLOW = 0x8000371f,
}

enum int EVENT_PS_NETWORK_ADDRESS_FAIL = 0xc0003720;
enum int EXTRA_EXIT_POINT = 0xc00037dc;

enum : int
{
    MISSING_EXIT_POINT = 0xc00037dd,
    MISSING_VOLUME     = 0xc00037de,
}

enum : int
{
    EXTRA_VOLUME                 = 0xc00037df,
    EXTRA_EXIT_POINT_DELETED     = 0xc00037e0,
    EXTRA_EXIT_POINT_NOT_DELETED = 0xc00037e1,
}

enum : int
{
    MISSING_EXIT_POINT_CREATED     = 0xc00037e2,
    MISSING_EXIT_POINT_NOT_CREATED = 0xc00037e3,
}

enum : int
{
    MISSING_VOLUME_CREATED     = 0xc00037e4,
    MISSING_VOLUME_NOT_CREATED = 0xc00037e5,
}

enum : int
{
    EXTRA_VOLUME_DELETED     = 0xc00037e6,
    EXTRA_VOLUME_NOT_DELETED = 0xc00037e7,
}

enum int COULD_NOT_VERIFY_VOLUMES = 0xc00037e8;
enum int KNOWLEDGE_INCONSISTENCY_DETECTED = 0xc00037e9;

enum : int
{
    PREFIX_MISMATCH           = 0xc00037ea,
    PREFIX_MISMATCH_FIXED     = 0xc00037eb,
    PREFIX_MISMATCH_NOT_FIXED = 0xc00037ec,
}

enum int MACHINE_UNJOINED = 0xc00037ed;
enum int DFS_REFERRAL_REQUEST = 0x400037ee;
enum int NOT_A_DFS_PATH = 0x40003840;
enum int LM_REDIR_FAILURE = 0x40003841;
enum int DFS_CONNECTION_FAILURE = 0x40003842;

enum : int
{
    DFS_REFERRAL_FAILURE = 0x40003843,
    DFS_REFERRAL_SUCCESS = 0x40003844,
}

enum int DFS_MAX_DNR_ATTEMPTS = 0x40003845;
enum int DFS_SPECIAL_REFERRAL_FAILURE = 0x40003846;
enum int DFS_OPEN_FAILURE = 0x40003847;

enum : int
{
    NET_DFS_ENUM   = 0x400038a4,
    NET_DFS_ENUMEX = 0x400038a5,
}

enum int DFS_ERROR_CREATE_REPARSEPOINT_FAILURE = 0xc00038a7;
enum int DFS_ERROR_UNSUPPORTED_FILESYSTEM = 0xc00038a8;
enum int DFS_ERROR_OVERLAPPING_DIRECTORIES = 0xc00038a9;
enum int DFS_INFO_ACTIVEDIRECTORY_ONLINE = 0x400038ac;
enum int DFS_ERROR_TOO_MANY_ERRORS = 0xc00038ad;
enum int DFS_ERROR_WINSOCKINIT_FAILED = 0xc00038ae;
enum int DFS_ERROR_SECURITYINIT_FAILED = 0xc00038af;
enum int DFS_ERROR_THREADINIT_FAILED = 0xc00038b0;
enum int DFS_ERROR_SITECACHEINIT_FAILED = 0xc00038b1;
enum int DFS_ERROR_ROOTSYNCINIT_FAILED = 0xc00038b2;
enum int DFS_ERROR_CREATEEVENT_FAILED = 0xc00038b3;
enum int DFS_ERROR_COMPUTERINFO_FAILED = 0xc00038b4;
enum int DFS_ERROR_CLUSTERINFO_FAILED = 0xc00038b5;

enum : int
{
    DFS_ERROR_DCINFO_FAILED      = 0xc00038b6,
    DFS_ERROR_PREFIXTABLE_FAILED = 0xc00038b7,
}

enum int DFS_ERROR_HANDLENAMESPACE_FAILED = 0xc00038b8;
enum int DFS_ERROR_REGISTERSTORE_FAILED = 0xc00038b9;
enum int DFS_ERROR_REFLECTIONENGINE_FAILED = 0xc00038ba;
enum int DFS_ERROR_ACTIVEDIRECTORY_OFFLINE = 0xc00038bb;
enum int DFS_ERROR_SITESUPPOR_FAILED = 0xc00038bc;
enum int DFS_ERROR_DSCONNECT_FAILED = 0x800038be;
enum int DFS_INFO_DS_RECONNECTED = 0x400038c1;
enum int DFS_ERROR_NO_DFS_DATA = 0xc00038c2;

enum : int
{
    DFS_INFO_FINISH_INIT    = 0x400038c3,
    DFS_INFO_RECONNECT_DATA = 0x400038c4,
}

enum int DFS_INFO_FINISH_BUILDING_NAMESPACE = 0x400038c5;

enum : int
{
    DFS_ERROR_ON_ROOT                      = 0x800038c6,
    DFS_ERROR_MUTLIPLE_ROOTS_NOT_SUPPORTED = 0xc00038c7,
}

enum int DFS_WARN_DOMAIN_REFERRAL_OVERFLOW = 0x800038c8;
enum int DFS_INFO_DOMAIN_REFERRAL_MIN_OVERFLOW = 0x400038c9;
enum int DFS_WARN_INCOMPLETE_MOVE = 0x800038ca;
enum int DFS_ERROR_RESYNCHRONIZE_FAILED = 0xc00038cb;
enum int DFS_ERROR_REMOVE_LINK_FAILED = 0xc00038cc;

enum : int
{
    DFS_WARN_METADATA_LINK_TYPE_INCORRECT = 0x800038cd,
    DFS_WARN_METADATA_LINK_INFO_INVALID   = 0x800038ce,
}

enum int DFS_ERROR_TARGET_LIST_INCORRECT = 0xc00038cf;

enum : int
{
    DFS_ERROR_LINKS_OVERLAP               = 0xc00038d0,
    DFS_ERROR_LINK_OVERLAP                = 0xc00038d1,
    DFS_ERROR_CREATE_REPARSEPOINT_SUCCESS = 0x400038d2,
}

enum : int
{
    DFS_ERROR_DUPLICATE_LINK             = 0xc00038d3,
    DFS_ERROR_TRUSTED_DOMAIN_INFO_FAILED = 0xc00038d4,
}

enum int DFS_INFO_TRUSTED_DOMAIN_INFO_SUCCESS = 0x400038d5;
enum int DFS_ERROR_CROSS_FOREST_TRUST_INFO_FAILED = 0xc00038d6;
enum int DFS_INFO_CROSS_FOREST_TRUST_INFO_SUCCESS = 0x400038d7;
enum int DFS_INIT_SUCCESS = 0x400038d8;

enum : int
{
    DFS_ROOT_SHARE_ACQUIRE_FAILED  = 0x800038d9,
    DFS_ROOT_SHARE_ACQUIRE_SUCCESS = 0x400038da,
}

enum int EVENT_BRIDGE_PROTOCOL_REGISTER_FAILED = 0xc0003908;

enum : int
{
    EVENT_BRIDGE_MINIPROT_DEVNAME_MISSING = 0xc0003909,
    EVENT_BRIDGE_MINIPORT_REGISTER_FAILED = 0xc000390a,
}

enum int EVENT_BRIDGE_DEVICE_CREATION_FAILED = 0xc000390b;

enum : int
{
    EVENT_BRIDGE_NO_BRIDGE_MAC_ADDR   = 0xc000390c,
    EVENT_BRIDGE_MINIPORT_INIT_FAILED = 0xc000390d,
}

enum int EVENT_BRIDGE_ETHERNET_NOT_OFFERED = 0xc000390e;

enum : int
{
    EVENT_BRIDGE_THREAD_CREATION_FAILED      = 0xc000390f,
    EVENT_BRIDGE_THREAD_REF_FAILED           = 0xc0003910,
    EVENT_BRIDGE_PACKET_POOL_CREATION_FAILED = 0xc0003911,
}

enum int EVENT_BRIDGE_BUFFER_POOL_CREATION_FAILED = 0xc0003912;

enum : int
{
    EVENT_BRIDGE_INIT_MALLOC_FAILED              = 0xc0003913,
    EVENT_BRIDGE_ADAPTER_LINK_SPEED_QUERY_FAILED = 0xc000396c,
    EVENT_BRIDGE_ADAPTER_MAC_ADDR_QUERY_FAILED   = 0xc000396d,
    EVENT_BRIDGE_ADAPTER_FILTER_FAILED           = 0xc000396e,
    EVENT_BRIDGE_ADAPTER_NAME_QUERY_FAILED       = 0xc000396f,
    EVENT_BRIDGE_ADAPTER_BIND_FAILED             = 0xc0003970,
}

enum int EVENT_DAV_REDIR_DELAYED_WRITE_FAILED = 0x800039d0;

enum : int
{
    EVENT_WEBCLIENT_CLOSE_PUT_FAILED         = 0x80003a35,
    EVENT_WEBCLIENT_CLOSE_DELETE_FAILED      = 0x80003a36,
    EVENT_WEBCLIENT_CLOSE_PROPPATCH_FAILED   = 0x80003a37,
    EVENT_WEBCLIENT_SETINFO_PROPPATCH_FAILED = 0x80003a38,
}

enum int EVENT_WSK_OWNINGTHREAD_PARAMETER_IGNORED = 0xc0003e80;

enum : int
{
    EVENT_WINSOCK_TDI_FILTER_DETECTED = 0x80003e81,
    EVENT_WINSOCK_CLOSESOCKET_STUCK   = 0x80003e82,
}

enum : int
{
    EVENT_EQOS_INFO_MACHINE_POLICY_REFRESH_NO_CHANGE   = 0x40004074,
    EVENT_EQOS_INFO_MACHINE_POLICY_REFRESH_WITH_CHANGE = 0x40004075,
}

enum : int
{
    EVENT_EQOS_INFO_USER_POLICY_REFRESH_NO_CHANGE   = 0x40004076,
    EVENT_EQOS_INFO_USER_POLICY_REFRESH_WITH_CHANGE = 0x40004077,
}

enum : int
{
    EVENT_EQOS_INFO_TCP_AUTOTUNING_NOT_CONFIGURED    = 0x40004078,
    EVENT_EQOS_INFO_TCP_AUTOTUNING_OFF               = 0x40004079,
    EVENT_EQOS_INFO_TCP_AUTOTUNING_HIGHLY_RESTRICTED = 0x4000407a,
    EVENT_EQOS_INFO_TCP_AUTOTUNING_RESTRICTED        = 0x4000407b,
    EVENT_EQOS_INFO_TCP_AUTOTUNING_NORMAL            = 0x4000407c,
    EVENT_EQOS_INFO_APP_MARKING_NOT_CONFIGURED       = 0x4000407d,
    EVENT_EQOS_INFO_APP_MARKING_IGNORED              = 0x4000407e,
    EVENT_EQOS_INFO_APP_MARKING_ALLOWED              = 0x4000407f,
    EVENT_EQOS_INFO_LOCAL_SETTING_DONT_USE_NLA       = 0x40004080,
}

enum int EVENT_EQOS_URL_QOS_APPLICATION_CONFLICT = 0x40004081;

enum : int
{
    EVENT_EQOS_WARNING_TEST_1                               = 0x800040d8,
    EVENT_EQOS_WARNING_TEST_2                               = 0x800040d9,
    EVENT_EQOS_WARNING_MACHINE_POLICY_VERSION               = 0x800040da,
    EVENT_EQOS_WARNING_USER_POLICY_VERSION                  = 0x800040db,
    EVENT_EQOS_WARNING_MACHINE_POLICY_PROFILE_NOT_SPECIFIED = 0x800040dc,
}

enum int EVENT_EQOS_WARNING_USER_POLICY_PROFILE_NOT_SPECIFIED = 0x800040dd;
enum int EVENT_EQOS_WARNING_MACHINE_POLICY_QUOTA_EXCEEDED = 0x800040de;

enum : int
{
    EVENT_EQOS_WARNING_USER_POLICY_QUOTA_EXCEEDED         = 0x800040df,
    EVENT_EQOS_WARNING_MACHINE_POLICY_CONFLICT            = 0x800040e0,
    EVENT_EQOS_WARNING_USER_POLICY_CONFLICT               = 0x800040e1,
    EVENT_EQOS_WARNING_MACHINE_POLICY_NO_FULLPATH_APPNAME = 0x800040e2,
}

enum int EVENT_EQOS_WARNING_USER_POLICY_NO_FULLPATH_APPNAME = 0x800040e3;

enum : int
{
    EVENT_EQOS_ERROR_MACHINE_POLICY_REFERESH         = 0xc000413c,
    EVENT_EQOS_ERROR_USER_POLICY_REFERESH            = 0xc000413d,
    EVENT_EQOS_ERROR_OPENING_MACHINE_POLICY_ROOT_KEY = 0xc000413e,
    EVENT_EQOS_ERROR_OPENING_USER_POLICY_ROOT_KEY    = 0xc000413f,
}

enum int EVENT_EQOS_ERROR_MACHINE_POLICY_KEYNAME_TOO_LONG = 0xc0004140;
enum int EVENT_EQOS_ERROR_USER_POLICY_KEYNAME_TOO_LONG = 0xc0004141;
enum int EVENT_EQOS_ERROR_MACHINE_POLICY_KEYNAME_SIZE_ZERO = 0xc0004142;
enum int EVENT_EQOS_ERROR_USER_POLICY_KEYNAME_SIZE_ZERO = 0xc0004143;

enum : int
{
    EVENT_EQOS_ERROR_OPENING_MACHINE_POLICY_SUBKEY = 0xc0004144,
    EVENT_EQOS_ERROR_OPENING_USER_POLICY_SUBKEY    = 0xc0004145,
}

enum : int
{
    EVENT_EQOS_ERROR_PROCESSING_MACHINE_POLICY_FIELD = 0xc0004146,
    EVENT_EQOS_ERROR_PROCESSING_USER_POLICY_FIELD    = 0xc0004147,
}

enum : int
{
    EVENT_EQOS_ERROR_SETTING_TCP_AUTOTUNING = 0xc0004148,
    EVENT_EQOS_ERROR_SETTING_APP_MARKING    = 0xc0004149,
}

enum int EVENT_WINNAT_SESSION_LIMIT_REACHED = 0x80004268;
enum uint HARDWARE_ADDRESS_LENGTH = 0x00000006U;

enum : uint
{
    NETMAN_VARTYPE_ULONG            = 0x00000000U,
    NETMAN_VARTYPE_HARDWARE_ADDRESS = 0x00000001U,
    NETMAN_VARTYPE_STRING           = 0x00000002U,
}

enum : uint
{
    REPL_ROLE_EXPORT = 0x00000001U,
    REPL_ROLE_IMPORT = 0x00000002U,
    REPL_ROLE_BOTH   = 0x00000003U,
}

enum uint REPL_INTERVAL_INFOLEVEL = 0x000003e8U;
enum uint REPL_PULSE_INFOLEVEL = 0x000003e9U;
enum uint REPL_GUARDTIME_INFOLEVEL = 0x000003eaU;
enum uint REPL_RANDOM_INFOLEVEL = 0x000003ebU;

enum : uint
{
    REPL_INTEGRITY_FILE = 0x00000001U,
    REPL_INTEGRITY_TREE = 0x00000002U,
}

enum : uint
{
    REPL_EXTENT_FILE                = 0x00000001U,
    REPL_EXTENT_TREE                = 0x00000002U,
    REPL_EXPORT_INTEGRITY_INFOLEVEL = 0x000003e8U,
}

enum uint REPL_EXPORT_EXTENT_INFOLEVEL = 0x000003e9U;

enum : uint
{
    REPL_UNLOCK_NOFORCE = 0x00000000U,
    REPL_UNLOCK_FORCE   = 0x00000001U,
}

enum : uint
{
    REPL_STATE_OK               = 0x00000000U,
    REPL_STATE_NO_MASTER        = 0x00000001U,
    REPL_STATE_NO_SYNC          = 0x00000002U,
    REPL_STATE_NEVER_REPLICATED = 0x00000003U,
}

enum : const(wchar)*
{
    SERVICE_WORKSTATION      = "LanmanWorkstation",
    SERVICE_LM20_WORKSTATION = "WORKSTATION",
}

enum const(wchar)* WORKSTATION_DISPLAY_NAME = "Workstation";

enum : const(wchar)*
{
    SERVICE_SERVER      = "LanmanServer",
    SERVICE_LM20_SERVER = "SERVER",
}

enum const(wchar)* SERVER_DISPLAY_NAME = "Server";

enum : const(wchar)*
{
    SERVICE_BROWSER      = "BROWSER",
    SERVICE_LM20_BROWSER = "BROWSER",
}

enum : const(wchar)*
{
    SERVICE_MESSENGER      = "MESSENGER",
    SERVICE_LM20_MESSENGER = "MESSENGER",
}

enum : const(wchar)*
{
    SERVICE_NETRUN       = "NETRUN",
    SERVICE_LM20_NETRUN  = "NETRUN",
    SERVICE_SPOOLER      = "SPOOLER",
    SERVICE_LM20_SPOOLER = "SPOOLER",
}

enum : const(wchar)*
{
    SERVICE_ALERTER      = "ALERTER",
    SERVICE_LM20_ALERTER = "ALERTER",
}

enum : const(wchar)*
{
    SERVICE_NETLOGON      = "NETLOGON",
    SERVICE_LM20_NETLOGON = "NETLOGON",
}

enum : const(wchar)*
{
    SERVICE_NETPOPUP      = "NETPOPUP",
    SERVICE_LM20_NETPOPUP = "NETPOPUP",
}

enum : const(wchar)*
{
    SERVICE_SQLSERVER      = "SQLSERVER",
    SERVICE_LM20_SQLSERVER = "SQLSERVER",
}

enum : const(wchar)*
{
    SERVICE_REPL            = "REPLICATOR",
    SERVICE_LM20_REPL       = "REPLICATOR",
    SERVICE_RIPL            = "REMOTEBOOT",
    SERVICE_LM20_RIPL       = "REMOTEBOOT",
    SERVICE_TIMESOURCE      = "TIMESOURCE",
    SERVICE_LM20_TIMESOURCE = "TIMESOURCE",
}

enum : const(wchar)*
{
    SERVICE_AFP          = "AFP",
    SERVICE_LM20_AFP     = "AFP",
    SERVICE_UPS          = "UPS",
    SERVICE_LM20_UPS     = "UPS",
    SERVICE_XACTSRV      = "XACTSRV",
    SERVICE_LM20_XACTSRV = "XACTSRV",
}

enum : const(wchar)*
{
    SERVICE_TCPIP        = "TCPIP",
    SERVICE_LM20_TCPIP   = "TCPIP",
    SERVICE_NBT          = "NBT",
    SERVICE_LM20_NBT     = "NBT",
    SERVICE_LMHOSTS      = "LMHOSTS",
    SERVICE_LM20_LMHOSTS = "LMHOSTS",
}

enum : const(wchar)*
{
    SERVICE_TELNET        = "Telnet",
    SERVICE_LM20_TELNET   = "Telnet",
    SERVICE_SCHEDULE      = "Schedule",
    SERVICE_LM20_SCHEDULE = "Schedule",
}

enum : const(wchar)*
{
    SERVICE_NTLMSSP    = "NtLmSsp",
    SERVICE_DHCP       = "DHCP",
    SERVICE_LM20_DHCP  = "DHCP",
    SERVICE_NWSAP      = "NwSapAgent",
    SERVICE_LM20_NWSAP = "NwSapAgent",
}

enum const(wchar)* NWSAP_DISPLAY_NAME = "NW Sap Agent";

enum : const(wchar)*
{
    SERVICE_NWCS      = "NWCWorkstation",
    SERVICE_DNS_CACHE = "DnsCache",
    SERVICE_W32TIME   = "w32time",
}

enum const(wchar)* SERVCE_LM20_W32TIME = "w32time";

enum : const(wchar)*
{
    SERVICE_KDC           = "kdc",
    SERVICE_LM20_KDC      = "kdc",
    SERVICE_LOCALKDC      = "localkdc",
    SERVICE_LM20_LOCALKDC = "localkdc",
}

enum : const(wchar)*
{
    SERVICE_RPCLOCATOR      = "RPCLOCATOR",
    SERVICE_LM20_RPCLOCATOR = "RPCLOCATOR",
}

enum : const(wchar)*
{
    SERVICE_TRKSVR       = "TrkSvr",
    SERVICE_LM20_TRKSVR  = "TrkSvr",
    SERVICE_TRKWKS       = "TrkWks",
    SERVICE_LM20_TRKWKS  = "TrkWks",
    SERVICE_NTFRS        = "NtFrs",
    SERVICE_LM20_NTFRS   = "NtFrs",
    SERVICE_ISMSERV      = "IsmServ",
    SERVICE_LM20_ISMSERV = "IsmServ",
}

enum : const(wchar)*
{
    SERVICE_NTDS        = "NTDS",
    SERVICE_LM20_NTDS   = "NTDS",
    SERVICE_ADWS        = "ADWS",
    SERVICE_DSROLE      = "DsRoleSvc",
    SERVICE_LM20_DSROLE = "DsRoleSvc",
}

enum HRESULT NETCFG_E_ALREADY_INITIALIZED = HRESULT(0x8004a020);
enum HRESULT NETCFG_E_NOT_INITIALIZED = HRESULT(0x8004a021);

enum : HRESULT
{
    NETCFG_E_IN_USE                 = HRESULT(0x8004a022),
    NETCFG_E_NO_WRITE_LOCK          = HRESULT(0x8004a024),
    NETCFG_E_NEED_REBOOT            = HRESULT(0x8004a025),
    NETCFG_E_ACTIVE_RAS_CONNECTIONS = HRESULT(0x8004a026),
}

enum HRESULT NETCFG_E_ADAPTER_NOT_FOUND = HRESULT(0x8004a027);
enum HRESULT NETCFG_E_COMPONENT_REMOVED_PENDING_REBOOT = HRESULT(0x8004a028);
enum HRESULT NETCFG_E_MAX_FILTER_LIMIT = HRESULT(0x8004a029);
enum HRESULT NETCFG_E_VMSWITCH_ACTIVE_OVER_ADAPTER = HRESULT(0x8004a02a);
enum HRESULT NETCFG_E_DUPLICATE_INSTANCEID = HRESULT(0x8004a02b);

enum : HRESULT
{
    NETCFG_S_REBOOT           = HRESULT(0x0004a020),
    NETCFG_S_DISABLE_QUERY    = HRESULT(0x0004a022),
    NETCFG_S_STILL_REFERENCED = HRESULT(0x0004a023),
}

enum HRESULT NETCFG_S_CAUSED_SETUP_CHANGE = HRESULT(0x0004a024);
enum HRESULT NETCFG_S_COMMIT_NOW = HRESULT(0x0004a025);
enum const(wchar)* NETCFG_CLIENT_CID_MS_MSClient = "ms_msclient";

enum : const(wchar)*
{
    NETCFG_SERVICE_CID_MS_SERVER  = "ms_server",
    NETCFG_SERVICE_CID_MS_NETBIOS = "ms_netbios",
    NETCFG_SERVICE_CID_MS_PSCHED  = "ms_pschedpc",
    NETCFG_SERVICE_CID_MS_WLBS    = "ms_wlbs",
}

enum : const(wchar)*
{
    NETCFG_TRANS_CID_MS_APPLETALK = "ms_appletalk",
    NETCFG_TRANS_CID_MS_NETBEUI   = "ms_netbeui",
    NETCFG_TRANS_CID_MS_NETMON    = "ms_netmon",
    NETCFG_TRANS_CID_MS_NWIPX     = "ms_nwipx",
    NETCFG_TRANS_CID_MS_NWSPX     = "ms_nwspx",
    NETCFG_TRANS_CID_MS_TCPIP     = "ms_tcpip",
}

enum : uint
{
    WZC_PROFILE_SUCCESS                              = 0x00000000U,
    WZC_PROFILE_XML_ERROR_NO_VERSION                 = 0x00000001U,
    WZC_PROFILE_XML_ERROR_BAD_VERSION                = 0x00000002U,
    WZC_PROFILE_XML_ERROR_UNSUPPORTED_VERSION        = 0x00000003U,
    WZC_PROFILE_XML_ERROR_SSID_NOT_FOUND             = 0x00000004U,
    WZC_PROFILE_XML_ERROR_BAD_SSID                   = 0x00000005U,
    WZC_PROFILE_XML_ERROR_CONNECTION_TYPE            = 0x00000006U,
    WZC_PROFILE_XML_ERROR_AUTHENTICATION             = 0x00000007U,
    WZC_PROFILE_XML_ERROR_ENCRYPTION                 = 0x00000008U,
    WZC_PROFILE_XML_ERROR_KEY_PROVIDED_AUTOMATICALLY = 0x00000009U,
    WZC_PROFILE_XML_ERROR_1X_ENABLED                 = 0x0000000aU,
    WZC_PROFILE_XML_ERROR_EAP_METHOD                 = 0x0000000bU,
    WZC_PROFILE_XML_ERROR_BAD_KEY_INDEX              = 0x0000000cU,
    WZC_PROFILE_XML_ERROR_KEY_INDEX_RANGE            = 0x0000000dU,
    WZC_PROFILE_XML_ERROR_BAD_NETWORK_KEY            = 0x0000000eU,
}

enum : uint
{
    WZC_PROFILE_CONFIG_ERROR_INVALID_AUTH_FOR_CONNECTION_TYPE = 0x0000000fU,
    WZC_PROFILE_CONFIG_ERROR_INVALID_ENCRYPTION_FOR_AUTHMODE  = 0x00000010U,
    WZC_PROFILE_CONFIG_ERROR_KEY_REQUIRED                     = 0x00000011U,
    WZC_PROFILE_CONFIG_ERROR_KEY_INDEX_REQUIRED               = 0x00000012U,
    WZC_PROFILE_CONFIG_ERROR_KEY_INDEX_NOT_APPLICABLE         = 0x00000013U,
    WZC_PROFILE_CONFIG_ERROR_1X_NOT_ALLOWED                   = 0x00000014U,
    WZC_PROFILE_CONFIG_ERROR_1X_NOT_ALLOWED_KEY_REQUIRED      = 0x00000015U,
    WZC_PROFILE_CONFIG_ERROR_1X_NOT_ENABLED_KEY_PROVIDED      = 0x00000016U,
    WZC_PROFILE_CONFIG_ERROR_EAP_METHOD_REQUIRED              = 0x00000017U,
    WZC_PROFILE_CONFIG_ERROR_EAP_METHOD_NOT_APPLICABLE        = 0x00000018U,
    WZC_PROFILE_CONFIG_ERROR_WPA_NOT_SUPPORTED                = 0x00000019U,
    WZC_PROFILE_CONFIG_ERROR_WPA_ENCRYPTION_NOT_SUPPORTED     = 0x0000001aU,
}

enum : uint
{
    WZC_PROFILE_SET_ERROR_DUPLICATE_NETWORK = 0x0000001bU,
    WZC_PROFILE_SET_ERROR_MEMORY_ALLOCATION = 0x0000001cU,
    WZC_PROFILE_SET_ERROR_READING_1X_CONFIG = 0x0000001dU,
    WZC_PROFILE_SET_ERROR_WRITING_1X_CONFIG = 0x0000001eU,
    WZC_PROFILE_SET_ERROR_WRITING_WZC_CFG   = 0x0000001fU,
}

enum : uint
{
    WZC_PROFILE_API_ERROR_NOT_SUPPORTED         = 0x00000020U,
    WZC_PROFILE_API_ERROR_FAILED_TO_LOAD_XML    = 0x00000021U,
    WZC_PROFILE_API_ERROR_FAILED_TO_LOAD_SCHEMA = 0x00000022U,
    WZC_PROFILE_API_ERROR_XML_VALIDATION_FAILED = 0x00000023U,
    WZC_PROFILE_API_ERROR_INTERNAL              = 0x00000024U,
}

enum : uint
{
    RF_ROUTING   = 0x00000001U,
    RF_ROUTINGV6 = 0x00000002U,
}

enum uint RF_DEMAND_UPDATE_ROUTES = 0x00000004U;
enum uint RF_ADD_ALL_INTERFACES = 0x00000010U;
enum uint RF_MULTICAST = 0x00000020U;
enum uint RF_POWER = 0x00000040U;
enum uint MS_ROUTER_VERSION = 0x00000600U;
enum uint ROUTING_DOMAIN_INFO_REVISION_1 = 0x00000001U;
enum uint INTERFACE_INFO_REVISION_1 = 0x00000001U;

enum : uint
{
    IR_PROMISCUOUS           = 0x00000000U,
    IR_PROMISCUOUS_MULTICAST = 0x00000001U,
}

enum : uint
{
    PROTO_IP_MSDP           = 0x00000009U,
    PROTO_IP_IGMP           = 0x0000000aU,
    PROTO_IP_BGMP           = 0x0000000bU,
    PROTO_IP_VRRP           = 0x00000070U,
    PROTO_IP_BOOTP          = 0x0000270fU,
    PROTO_IPV6_DHCP         = 0x000003e7U,
    PROTO_IP_DNS_PROXY      = 0x00002713U,
    PROTO_IP_DHCP_ALLOCATOR = 0x00002714U,
}

enum : uint
{
    PROTO_IP_NAT      = 0x00002715U,
    PROTO_IP_DIFFSERV = 0x00002718U,
    PROTO_IP_MGM      = 0x00002719U,
    PROTO_IP_ALG      = 0x0000271aU,
    PROTO_IP_H323     = 0x0000271bU,
    PROTO_IP_FTP      = 0x0000271cU,
    PROTO_IP_DTP      = 0x0000271dU,
    PROTO_TYPE_UCAST  = 0x00000000U,
    PROTO_TYPE_MCAST  = 0x00000001U,
    PROTO_TYPE_MS0    = 0x00000002U,
    PROTO_TYPE_MS1    = 0x00000003U,
    PROTO_VENDOR_MS0  = 0x00000000U,
    PROTO_VENDOR_MS1  = 0x00000137U,
    PROTO_VENDOR_MS2  = 0x00003fffU,
}

enum : uint
{
    IPX_PROTOCOL_BASE = 0x0001ffffU,
    IPX_PROTOCOL_RIP  = 0x00020000U,
}

enum : uint
{
    RIS_INTERFACE_ADDRESS_CHANGE = 0x00000000U,
    RIS_INTERFACE_ENABLED        = 0x00000001U,
    RIS_INTERFACE_DISABLED       = 0x00000002U,
    RIS_INTERFACE_MEDIA_PRESENT  = 0x00000003U,
    RIS_INTERFACE_MEDIA_ABSENT   = 0x00000004U,
}

enum uint MRINFO_TUNNEL_FLAG = 0x00000001U;

enum : uint
{
    MRINFO_PIM_FLAG      = 0x00000004U,
    MRINFO_DOWN_FLAG     = 0x00000010U,
    MRINFO_DISABLED_FLAG = 0x00000020U,
}

enum uint MRINFO_QUERIER_FLAG = 0x00000040U;
enum uint MRINFO_LEAF_FLAG = 0x00000080U;
enum uint MFE_NO_ERROR = 0x00000000U;
enum uint MFE_REACHED_CORE = 0x00000001U;
enum uint MFE_OIF_PRUNED = 0x00000005U;
enum uint MFE_PRUNED_UPSTREAM = 0x00000004U;
enum uint MFE_OLD_ROUTER = 0x0000000bU;
enum uint MFE_NOT_FORWARDING = 0x00000002U;
enum uint MFE_WRONG_IF = 0x00000003U;
enum uint MFE_BOUNDARY_REACHED = 0x00000006U;
enum uint MFE_NO_MULTICAST = 0x00000007U;

enum : uint
{
    MFE_IIF          = 0x00000008U,
    MFE_NO_ROUTE     = 0x00000009U,
    MFE_NOT_LAST_HOP = 0x0000000aU,
}

enum uint MFE_PROHIBITED = 0x0000000cU;
enum uint MFE_NO_SPACE = 0x0000000dU;
// Native encoding: ansi
enum const(wchar)* REGISTER_PROTOCOL_ENTRY_POINT_STRING = "RegisterProtocol";

enum : uint
{
    ALIGN_SIZE  = 0x00000008U,
    ALIGN_SHIFT = 0x00000007U,
}

enum uint RTR_INFO_BLOCK_VERSION = 0x00000001U;

enum : uint
{
    TRACE_USE_FILE    = 0x00000001U,
    TRACE_USE_CONSOLE = 0x00000002U,
}

enum : uint
{
    TRACE_NO_SYNCH   = 0x00000004U,
    TRACE_NO_STDINFO = 0x00000001U,
}

enum : uint
{
    TRACE_USE_MASK = 0x00000002U,
    TRACE_USE_MSEC = 0x00000004U,
    TRACE_USE_DATE = 0x00000008U,
}

enum uint INVALID_TRACEID = 0xffffffffU;

enum : uint
{
    RTUTILS_MAX_PROTOCOL_NAME_LEN = 0x00000028U,
    RTUTILS_MAX_PROTOCOL_DLL_LEN  = 0x00000030U,
}

enum : uint
{
    MAX_PROTOCOL_NAME_LEN = 0x00000028U,
    MAX_PROTOCOL_DLL_LEN  = 0x00000030U,
}

// Callbacks

alias WORKERFUNCTION = void function(void* param0);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_0
struct USER_INFO_0
{
    PWSTR usri0_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1
struct USER_INFO_1
{
    PWSTR              usri1_name;
    PWSTR              usri1_password;
    uint               usri1_password_age;
    USER_PRIV          usri1_priv;
    PWSTR              usri1_home_dir;
    PWSTR              usri1_comment;
    USER_ACCOUNT_FLAGS usri1_flags;
    PWSTR              usri1_script_path;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_2
struct USER_INFO_2
{
    PWSTR              usri2_name;
    PWSTR              usri2_password;
    uint               usri2_password_age;
    USER_PRIV          usri2_priv;
    PWSTR              usri2_home_dir;
    PWSTR              usri2_comment;
    USER_ACCOUNT_FLAGS usri2_flags;
    PWSTR              usri2_script_path;
    AF_OP              usri2_auth_flags;
    PWSTR              usri2_full_name;
    PWSTR              usri2_usr_comment;
    PWSTR              usri2_parms;
    PWSTR              usri2_workstations;
    uint               usri2_last_logon;
    uint               usri2_last_logoff;
    uint               usri2_acct_expires;
    uint               usri2_max_storage;
    uint               usri2_units_per_week;
    ubyte*             usri2_logon_hours;
    uint               usri2_bad_pw_count;
    uint               usri2_num_logons;
    PWSTR              usri2_logon_server;
    uint               usri2_country_code;
    uint               usri2_code_page;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_3
struct USER_INFO_3
{
    PWSTR              usri3_name;
    PWSTR              usri3_password;
    uint               usri3_password_age;
    USER_PRIV          usri3_priv;
    PWSTR              usri3_home_dir;
    PWSTR              usri3_comment;
    USER_ACCOUNT_FLAGS usri3_flags;
    PWSTR              usri3_script_path;
    AF_OP              usri3_auth_flags;
    PWSTR              usri3_full_name;
    PWSTR              usri3_usr_comment;
    PWSTR              usri3_parms;
    PWSTR              usri3_workstations;
    uint               usri3_last_logon;
    uint               usri3_last_logoff;
    uint               usri3_acct_expires;
    uint               usri3_max_storage;
    uint               usri3_units_per_week;
    ubyte*             usri3_logon_hours;
    uint               usri3_bad_pw_count;
    uint               usri3_num_logons;
    PWSTR              usri3_logon_server;
    uint               usri3_country_code;
    uint               usri3_code_page;
    uint               usri3_user_id;
    uint               usri3_primary_group_id;
    PWSTR              usri3_profile;
    PWSTR              usri3_home_dir_drive;
    uint               usri3_password_expired;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_4
struct USER_INFO_4
{
    PWSTR              usri4_name;
    PWSTR              usri4_password;
    uint               usri4_password_age;
    USER_PRIV          usri4_priv;
    PWSTR              usri4_home_dir;
    PWSTR              usri4_comment;
    USER_ACCOUNT_FLAGS usri4_flags;
    PWSTR              usri4_script_path;
    AF_OP              usri4_auth_flags;
    PWSTR              usri4_full_name;
    PWSTR              usri4_usr_comment;
    PWSTR              usri4_parms;
    PWSTR              usri4_workstations;
    uint               usri4_last_logon;
    uint               usri4_last_logoff;
    uint               usri4_acct_expires;
    uint               usri4_max_storage;
    uint               usri4_units_per_week;
    ubyte*             usri4_logon_hours;
    uint               usri4_bad_pw_count;
    uint               usri4_num_logons;
    PWSTR              usri4_logon_server;
    uint               usri4_country_code;
    uint               usri4_code_page;
    PSID               usri4_user_sid;
    uint               usri4_primary_group_id;
    PWSTR              usri4_profile;
    PWSTR              usri4_home_dir_drive;
    uint               usri4_password_expired;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_10
struct USER_INFO_10
{
    PWSTR usri10_name;
    PWSTR usri10_comment;
    PWSTR usri10_usr_comment;
    PWSTR usri10_full_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_11
struct USER_INFO_11
{
    PWSTR     usri11_name;
    PWSTR     usri11_comment;
    PWSTR     usri11_usr_comment;
    PWSTR     usri11_full_name;
    USER_PRIV usri11_priv;
    AF_OP     usri11_auth_flags;
    uint      usri11_password_age;
    PWSTR     usri11_home_dir;
    PWSTR     usri11_parms;
    uint      usri11_last_logon;
    uint      usri11_last_logoff;
    uint      usri11_bad_pw_count;
    uint      usri11_num_logons;
    PWSTR     usri11_logon_server;
    uint      usri11_country_code;
    PWSTR     usri11_workstations;
    uint      usri11_max_storage;
    uint      usri11_units_per_week;
    ubyte*    usri11_logon_hours;
    uint      usri11_code_page;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_20
struct USER_INFO_20
{
    PWSTR              usri20_name;
    PWSTR              usri20_full_name;
    PWSTR              usri20_comment;
    USER_ACCOUNT_FLAGS usri20_flags;
    uint               usri20_user_id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_21
struct USER_INFO_21
{
    ubyte[16] usri21_password;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_22
struct USER_INFO_22
{
    PWSTR              usri22_name;
    ubyte[16]          usri22_password;
    uint               usri22_password_age;
    USER_PRIV          usri22_priv;
    PWSTR              usri22_home_dir;
    PWSTR              usri22_comment;
    USER_ACCOUNT_FLAGS usri22_flags;
    PWSTR              usri22_script_path;
    AF_OP              usri22_auth_flags;
    PWSTR              usri22_full_name;
    PWSTR              usri22_usr_comment;
    PWSTR              usri22_parms;
    PWSTR              usri22_workstations;
    uint               usri22_last_logon;
    uint               usri22_last_logoff;
    uint               usri22_acct_expires;
    uint               usri22_max_storage;
    uint               usri22_units_per_week;
    ubyte*             usri22_logon_hours;
    uint               usri22_bad_pw_count;
    uint               usri22_num_logons;
    PWSTR              usri22_logon_server;
    uint               usri22_country_code;
    uint               usri22_code_page;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_23
struct USER_INFO_23
{
    PWSTR              usri23_name;
    PWSTR              usri23_full_name;
    PWSTR              usri23_comment;
    USER_ACCOUNT_FLAGS usri23_flags;
    PSID               usri23_user_sid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_24
struct USER_INFO_24
{
    BOOL  usri24_internet_identity;
    uint  usri24_flags;
    PWSTR usri24_internet_provider_name;
    PWSTR usri24_internet_principal_name;
    PSID  usri24_user_sid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1003
struct USER_INFO_1003
{
    PWSTR usri1003_password;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1005
struct USER_INFO_1005
{
    USER_PRIV usri1005_priv;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1006
struct USER_INFO_1006
{
    PWSTR usri1006_home_dir;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1007
struct USER_INFO_1007
{
    PWSTR usri1007_comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1008
struct USER_INFO_1008
{
    USER_ACCOUNT_FLAGS usri1008_flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1009
struct USER_INFO_1009
{
    PWSTR usri1009_script_path;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1010
struct USER_INFO_1010
{
    AF_OP usri1010_auth_flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1011
struct USER_INFO_1011
{
    PWSTR usri1011_full_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1012
struct USER_INFO_1012
{
    PWSTR usri1012_usr_comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1013
struct USER_INFO_1013
{
    PWSTR usri1013_parms;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1014
struct USER_INFO_1014
{
    PWSTR usri1014_workstations;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1017
struct USER_INFO_1017
{
    uint usri1017_acct_expires;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1018
struct USER_INFO_1018
{
    uint usri1018_max_storage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1020
struct USER_INFO_1020
{
    uint   usri1020_units_per_week;
    ubyte* usri1020_logon_hours;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1023
struct USER_INFO_1023
{
    PWSTR usri1023_logon_server;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1024
struct USER_INFO_1024
{
    uint usri1024_country_code;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1025
struct USER_INFO_1025
{
    uint usri1025_code_page;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1051
struct USER_INFO_1051
{
    uint usri1051_primary_group_id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1052
struct USER_INFO_1052
{
    PWSTR usri1052_profile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_info_1053
struct USER_INFO_1053
{
    PWSTR usri1053_home_dir_drive;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_0
struct USER_MODALS_INFO_0
{
    uint usrmod0_min_passwd_len;
    uint usrmod0_max_passwd_age;
    uint usrmod0_min_passwd_age;
    uint usrmod0_force_logoff;
    uint usrmod0_password_hist_len;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_1
struct USER_MODALS_INFO_1
{
    uint  usrmod1_role;
    PWSTR usrmod1_primary;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_2
struct USER_MODALS_INFO_2
{
    PWSTR usrmod2_domain_name;
    PSID  usrmod2_domain_id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_3
struct USER_MODALS_INFO_3
{
    uint usrmod3_lockout_duration;
    uint usrmod3_lockout_observation_window;
    uint usrmod3_lockout_threshold;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_1001
struct USER_MODALS_INFO_1001
{
    uint usrmod1001_min_passwd_len;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_1002
struct USER_MODALS_INFO_1002
{
    uint usrmod1002_max_passwd_age;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_1003
struct USER_MODALS_INFO_1003
{
    uint usrmod1003_min_passwd_age;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_1004
struct USER_MODALS_INFO_1004
{
    uint usrmod1004_force_logoff;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_1005
struct USER_MODALS_INFO_1005
{
    uint usrmod1005_password_hist_len;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_1006
struct USER_MODALS_INFO_1006
{
    USER_MODALS_ROLES usrmod1006_role;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-user_modals_info_1007
struct USER_MODALS_INFO_1007
{
    PWSTR usrmod1007_primary;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-msa_info_0
struct MSA_INFO_0
{
    MSA_INFO_STATE State;
}

struct MSA_INFO_1
{
    MSA_INFO_STATE State;
    MSA_INFO_ACCOUNT_TYPE AccountType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-group_info_0
struct GROUP_INFO_0
{
    PWSTR grpi0_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-group_info_1
struct GROUP_INFO_1
{
    PWSTR grpi1_name;
    PWSTR grpi1_comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-group_info_2
struct GROUP_INFO_2
{
    PWSTR grpi2_name;
    PWSTR grpi2_comment;
    uint  grpi2_group_id;
    uint  grpi2_attributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-group_info_3
struct GROUP_INFO_3
{
    PWSTR grpi3_name;
    PWSTR grpi3_comment;
    PSID  grpi3_group_sid;
    uint  grpi3_attributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-group_info_1002
struct GROUP_INFO_1002
{
    PWSTR grpi1002_comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-group_info_1005
struct GROUP_INFO_1005
{
    uint grpi1005_attributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-group_users_info_0
struct GROUP_USERS_INFO_0
{
    PWSTR grui0_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-group_users_info_1
struct GROUP_USERS_INFO_1
{
    PWSTR grui1_name;
    uint  grui1_attributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-localgroup_info_0
struct LOCALGROUP_INFO_0
{
    PWSTR lgrpi0_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-localgroup_info_1
struct LOCALGROUP_INFO_1
{
    PWSTR lgrpi1_name;
    PWSTR lgrpi1_comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-localgroup_info_1002
struct LOCALGROUP_INFO_1002
{
    PWSTR lgrpi1002_comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-localgroup_members_info_0
struct LOCALGROUP_MEMBERS_INFO_0
{
    PSID lgrmi0_sid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-localgroup_members_info_1
struct LOCALGROUP_MEMBERS_INFO_1
{
    PSID         lgrmi1_sid;
    SID_NAME_USE lgrmi1_sidusage;
    PWSTR        lgrmi1_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-localgroup_members_info_2
struct LOCALGROUP_MEMBERS_INFO_2
{
    PSID         lgrmi2_sid;
    SID_NAME_USE lgrmi2_sidusage;
    PWSTR        lgrmi2_domainandname;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-localgroup_members_info_3
struct LOCALGROUP_MEMBERS_INFO_3
{
    PWSTR lgrmi3_domainandname;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-localgroup_users_info_0
struct LOCALGROUP_USERS_INFO_0
{
    PWSTR lgrui0_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-net_display_user
struct NET_DISPLAY_USER
{
    PWSTR              usri1_name;
    PWSTR              usri1_comment;
    USER_ACCOUNT_FLAGS usri1_flags;
    PWSTR              usri1_full_name;
    uint               usri1_user_id;
    uint               usri1_next_index;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-net_display_machine
struct NET_DISPLAY_MACHINE
{
    PWSTR              usri2_name;
    PWSTR              usri2_comment;
    USER_ACCOUNT_FLAGS usri2_flags;
    uint               usri2_user_id;
    uint               usri2_next_index;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-net_display_group
struct NET_DISPLAY_GROUP
{
    PWSTR grpi3_name;
    PWSTR grpi3_comment;
    uint  grpi3_group_id;
    uint  grpi3_attributes;
    uint  grpi3_next_index;
}

struct ACCESS_INFO_0
{
    PWSTR acc0_resource_name;
}

struct ACCESS_INFO_1
{
    PWSTR acc1_resource_name;
    uint  acc1_attr;
    uint  acc1_count;
}

struct ACCESS_INFO_1002
{
    uint acc1002_attr;
}

struct ACCESS_LIST
{
    PWSTR acl_ugname;
    uint  acl_access;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-net_validate_password_hash
struct NET_VALIDATE_PASSWORD_HASH
{
    uint   Length;
    ubyte* Hash;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-net_validate_persisted_fields
struct NET_VALIDATE_PERSISTED_FIELDS
{
    uint     PresentFields;
    FILETIME PasswordLastSet;
    FILETIME BadPasswordTime;
    FILETIME LockoutTime;
    uint     BadPasswordCount;
    uint     PasswordHistoryLength;
    NET_VALIDATE_PASSWORD_HASH* PasswordHistory;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-net_validate_output_arg
struct NET_VALIDATE_OUTPUT_ARG
{
    NET_VALIDATE_PERSISTED_FIELDS ChangedPersistedFields;
    uint ValidationStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-net_validate_authentication_input_arg
struct NET_VALIDATE_AUTHENTICATION_INPUT_ARG
{
    NET_VALIDATE_PERSISTED_FIELDS InputPersistedFields;
    BOOLEAN PasswordMatched;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-net_validate_password_change_input_arg
struct NET_VALIDATE_PASSWORD_CHANGE_INPUT_ARG
{
    NET_VALIDATE_PERSISTED_FIELDS InputPersistedFields;
    PWSTR   ClearPassword;
    PWSTR   UserAccountName;
    NET_VALIDATE_PASSWORD_HASH HashedPassword;
    BOOLEAN PasswordMatch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-net_validate_password_reset_input_arg
struct NET_VALIDATE_PASSWORD_RESET_INPUT_ARG
{
    NET_VALIDATE_PERSISTED_FIELDS InputPersistedFields;
    PWSTR   ClearPassword;
    PWSTR   UserAccountName;
    NET_VALIDATE_PASSWORD_HASH HashedPassword;
    BOOLEAN PasswordMustChangeAtNextLogon;
    BOOLEAN ClearLockout;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-netlogon_info_1
struct NETLOGON_INFO_1
{
    uint netlog1_flags;
    uint netlog1_pdc_connection_status;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-netlogon_info_2
struct NETLOGON_INFO_2
{
    uint  netlog2_flags;
    uint  netlog2_pdc_connection_status;
    PWSTR netlog2_trusted_dc_name;
    uint  netlog2_tc_connection_status;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-netlogon_info_3
struct NETLOGON_INFO_3
{
    uint netlog3_flags;
    uint netlog3_logon_attempts;
    uint netlog3_reserved1;
    uint netlog3_reserved2;
    uint netlog3_reserved3;
    uint netlog3_reserved4;
    uint netlog3_reserved5;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/ns-lmaccess-netlogon_info_4
struct NETLOGON_INFO_4
{
    PWSTR netlog4_trusted_dc_name;
    PWSTR netlog4_trusted_domain_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmalert/ns-lmalert-std_alert
struct STD_ALERT
{
    uint      alrt_timestamp;
    wchar[17] alrt_eventname;
    wchar[81] alrt_servicename;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmalert/ns-lmalert-admin_other_info
struct ADMIN_OTHER_INFO
{
    uint alrtad_errcode;
    uint alrtad_numstrings;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmalert/ns-lmalert-errlog_other_info
struct ERRLOG_OTHER_INFO
{
    uint alrter_errcode;
    uint alrter_offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmalert/ns-lmalert-print_other_info
struct PRINT_OTHER_INFO
{
    uint alrtpr_jobid;
    uint alrtpr_status;
    uint alrtpr_submitted;
    uint alrtpr_size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmalert/ns-lmalert-user_other_info
struct USER_OTHER_INFO
{
    uint alrtus_errcode;
    uint alrtus_numstrings;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmmsg/ns-lmmsg-msg_info_0
struct MSG_INFO_0
{
    PWSTR msgi0_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmmsg/ns-lmmsg-msg_info_1
struct MSG_INFO_1
{
    PWSTR msgi1_name;
    uint  msgi1_forward_flag;
    PWSTR msgi1_forward;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmremutl/ns-lmremutl-time_of_day_info
struct TIME_OF_DAY_INFO
{
    uint tod_elapsedt;
    uint tod_msecs;
    uint tod_hours;
    uint tod_mins;
    uint tod_secs;
    uint tod_hunds;
    int  tod_timezone;
    uint tod_tinterval;
    uint tod_day;
    uint tod_month;
    uint tod_year;
    uint tod_weekday;
}

struct REPL_INFO_0
{
    uint  rp0_role;
    PWSTR rp0_exportpath;
    PWSTR rp0_exportlist;
    PWSTR rp0_importpath;
    PWSTR rp0_importlist;
    PWSTR rp0_logonusername;
    uint  rp0_interval;
    uint  rp0_pulse;
    uint  rp0_guardtime;
    uint  rp0_random;
}

struct REPL_INFO_1000
{
    uint rp1000_interval;
}

struct REPL_INFO_1001
{
    uint rp1001_pulse;
}

struct REPL_INFO_1002
{
    uint rp1002_guardtime;
}

struct REPL_INFO_1003
{
    uint rp1003_random;
}

struct REPL_EDIR_INFO_0
{
    PWSTR rped0_dirname;
}

struct REPL_EDIR_INFO_1
{
    PWSTR rped1_dirname;
    uint  rped1_integrity;
    uint  rped1_extent;
}

struct REPL_EDIR_INFO_2
{
    PWSTR rped2_dirname;
    uint  rped2_integrity;
    uint  rped2_extent;
    uint  rped2_lockcount;
    uint  rped2_locktime;
}

struct REPL_EDIR_INFO_1000
{
    uint rped1000_integrity;
}

struct REPL_EDIR_INFO_1001
{
    uint rped1001_extent;
}

struct REPL_IDIR_INFO_0
{
    PWSTR rpid0_dirname;
}

struct REPL_IDIR_INFO_1
{
    PWSTR rpid1_dirname;
    uint  rpid1_state;
    PWSTR rpid1_mastername;
    uint  rpid1_last_update_time;
    uint  rpid1_lockcount;
    uint  rpid1_locktime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_100
struct SERVER_INFO_100
{
    uint  sv100_platform_id;
    PWSTR sv100_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_101
struct SERVER_INFO_101
{
    uint            sv101_platform_id;
    PWSTR           sv101_name;
    uint            sv101_version_major;
    uint            sv101_version_minor;
    NET_SERVER_TYPE sv101_type;
    PWSTR           sv101_comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_102
struct SERVER_INFO_102
{
    uint               sv102_platform_id;
    PWSTR              sv102_name;
    uint               sv102_version_major;
    uint               sv102_version_minor;
    NET_SERVER_TYPE    sv102_type;
    PWSTR              sv102_comment;
    uint               sv102_users;
    int                sv102_disc;
    SERVER_INFO_HIDDEN sv102_hidden;
    uint               sv102_announce;
    uint               sv102_anndelta;
    uint               sv102_licenses;
    PWSTR              sv102_userpath;
}

struct SERVER_INFO_103
{
    uint  sv103_platform_id;
    PWSTR sv103_name;
    uint  sv103_version_major;
    uint  sv103_version_minor;
    uint  sv103_type;
    PWSTR sv103_comment;
    uint  sv103_users;
    int   sv103_disc;
    BOOL  sv103_hidden;
    uint  sv103_announce;
    uint  sv103_anndelta;
    uint  sv103_licenses;
    PWSTR sv103_userpath;
    uint  sv103_capabilities;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_402
struct SERVER_INFO_402
{
    uint                 sv402_ulist_mtime;
    uint                 sv402_glist_mtime;
    uint                 sv402_alist_mtime;
    PWSTR                sv402_alerts;
    SERVER_INFO_SECURITY sv402_security;
    uint                 sv402_numadmin;
    uint                 sv402_lanmask;
    PWSTR                sv402_guestacct;
    uint                 sv402_chdevs;
    uint                 sv402_chdevq;
    uint                 sv402_chdevjobs;
    uint                 sv402_connections;
    uint                 sv402_shares;
    uint                 sv402_openfiles;
    uint                 sv402_sessopens;
    uint                 sv402_sessvcs;
    uint                 sv402_sessreqs;
    uint                 sv402_opensearch;
    uint                 sv402_activelocks;
    uint                 sv402_numreqbuf;
    uint                 sv402_sizreqbuf;
    uint                 sv402_numbigbuf;
    uint                 sv402_numfiletasks;
    uint                 sv402_alertsched;
    uint                 sv402_erroralert;
    uint                 sv402_logonalert;
    uint                 sv402_accessalert;
    uint                 sv402_diskalert;
    uint                 sv402_netioalert;
    uint                 sv402_maxauditsz;
    PWSTR                sv402_srvheuristics;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_403
struct SERVER_INFO_403
{
    uint                 sv403_ulist_mtime;
    uint                 sv403_glist_mtime;
    uint                 sv403_alist_mtime;
    PWSTR                sv403_alerts;
    SERVER_INFO_SECURITY sv403_security;
    uint                 sv403_numadmin;
    uint                 sv403_lanmask;
    PWSTR                sv403_guestacct;
    uint                 sv403_chdevs;
    uint                 sv403_chdevq;
    uint                 sv403_chdevjobs;
    uint                 sv403_connections;
    uint                 sv403_shares;
    uint                 sv403_openfiles;
    uint                 sv403_sessopens;
    uint                 sv403_sessvcs;
    uint                 sv403_sessreqs;
    uint                 sv403_opensearch;
    uint                 sv403_activelocks;
    uint                 sv403_numreqbuf;
    uint                 sv403_sizreqbuf;
    uint                 sv403_numbigbuf;
    uint                 sv403_numfiletasks;
    uint                 sv403_alertsched;
    uint                 sv403_erroralert;
    uint                 sv403_logonalert;
    uint                 sv403_accessalert;
    uint                 sv403_diskalert;
    uint                 sv403_netioalert;
    uint                 sv403_maxauditsz;
    PWSTR                sv403_srvheuristics;
    uint                 sv403_auditedevents;
    uint                 sv403_autoprofile;
    PWSTR                sv403_autopath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_502
struct SERVER_INFO_502
{
    uint sv502_sessopens;
    uint sv502_sessvcs;
    uint sv502_opensearch;
    uint sv502_sizreqbuf;
    uint sv502_initworkitems;
    uint sv502_maxworkitems;
    uint sv502_rawworkitems;
    uint sv502_irpstacksize;
    uint sv502_maxrawbuflen;
    uint sv502_sessusers;
    uint sv502_sessconns;
    uint sv502_maxpagedmemoryusage;
    uint sv502_maxnonpagedmemoryusage;
    BOOL sv502_enablesoftcompat;
    BOOL sv502_enableforcedlogoff;
    BOOL sv502_timesource;
    BOOL sv502_acceptdownlevelapis;
    BOOL sv502_lmannounce;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_503
struct SERVER_INFO_503
{
    uint  sv503_sessopens;
    uint  sv503_sessvcs;
    uint  sv503_opensearch;
    uint  sv503_sizreqbuf;
    uint  sv503_initworkitems;
    uint  sv503_maxworkitems;
    uint  sv503_rawworkitems;
    uint  sv503_irpstacksize;
    uint  sv503_maxrawbuflen;
    uint  sv503_sessusers;
    uint  sv503_sessconns;
    uint  sv503_maxpagedmemoryusage;
    uint  sv503_maxnonpagedmemoryusage;
    BOOL  sv503_enablesoftcompat;
    BOOL  sv503_enableforcedlogoff;
    BOOL  sv503_timesource;
    BOOL  sv503_acceptdownlevelapis;
    BOOL  sv503_lmannounce;
    PWSTR sv503_domain;
    uint  sv503_maxcopyreadlen;
    uint  sv503_maxcopywritelen;
    uint  sv503_minkeepsearch;
    uint  sv503_maxkeepsearch;
    uint  sv503_minkeepcomplsearch;
    uint  sv503_maxkeepcomplsearch;
    uint  sv503_threadcountadd;
    uint  sv503_numblockthreads;
    uint  sv503_scavtimeout;
    uint  sv503_minrcvqueue;
    uint  sv503_minfreeworkitems;
    uint  sv503_xactmemsize;
    uint  sv503_threadpriority;
    uint  sv503_maxmpxct;
    uint  sv503_oplockbreakwait;
    uint  sv503_oplockbreakresponsewait;
    BOOL  sv503_enableoplocks;
    BOOL  sv503_enableoplockforceclose;
    BOOL  sv503_enablefcbopens;
    BOOL  sv503_enableraw;
    BOOL  sv503_enablesharednetdrives;
    uint  sv503_minfreeconnections;
    uint  sv503_maxfreeconnections;
}

struct SERVER_INFO_599
{
    uint  sv599_sessopens;
    uint  sv599_sessvcs;
    uint  sv599_opensearch;
    uint  sv599_sizreqbuf;
    uint  sv599_initworkitems;
    uint  sv599_maxworkitems;
    uint  sv599_rawworkitems;
    uint  sv599_irpstacksize;
    uint  sv599_maxrawbuflen;
    uint  sv599_sessusers;
    uint  sv599_sessconns;
    uint  sv599_maxpagedmemoryusage;
    uint  sv599_maxnonpagedmemoryusage;
    BOOL  sv599_enablesoftcompat;
    BOOL  sv599_enableforcedlogoff;
    BOOL  sv599_timesource;
    BOOL  sv599_acceptdownlevelapis;
    BOOL  sv599_lmannounce;
    PWSTR sv599_domain;
    uint  sv599_maxcopyreadlen;
    uint  sv599_maxcopywritelen;
    uint  sv599_minkeepsearch;
    uint  sv599_maxkeepsearch;
    uint  sv599_minkeepcomplsearch;
    uint  sv599_maxkeepcomplsearch;
    uint  sv599_threadcountadd;
    uint  sv599_numblockthreads;
    uint  sv599_scavtimeout;
    uint  sv599_minrcvqueue;
    uint  sv599_minfreeworkitems;
    uint  sv599_xactmemsize;
    uint  sv599_threadpriority;
    uint  sv599_maxmpxct;
    uint  sv599_oplockbreakwait;
    uint  sv599_oplockbreakresponsewait;
    BOOL  sv599_enableoplocks;
    BOOL  sv599_enableoplockforceclose;
    BOOL  sv599_enablefcbopens;
    BOOL  sv599_enableraw;
    BOOL  sv599_enablesharednetdrives;
    uint  sv599_minfreeconnections;
    uint  sv599_maxfreeconnections;
    uint  sv599_initsesstable;
    uint  sv599_initconntable;
    uint  sv599_initfiletable;
    uint  sv599_initsearchtable;
    uint  sv599_alertschedule;
    uint  sv599_errorthreshold;
    uint  sv599_networkerrorthreshold;
    uint  sv599_diskspacethreshold;
    uint  sv599_reserved;
    uint  sv599_maxlinkdelay;
    uint  sv599_minlinkthroughput;
    uint  sv599_linkinfovalidtime;
    uint  sv599_scavqosinfoupdatetime;
    uint  sv599_maxworkitemidletime;
}

struct SERVER_INFO_598
{
    uint sv598_maxrawworkitems;
    uint sv598_maxthreadsperqueue;
    uint sv598_producttype;
    uint sv598_serversize;
    uint sv598_connectionlessautodisc;
    uint sv598_sharingviolationretries;
    uint sv598_sharingviolationdelay;
    uint sv598_maxglobalopensearch;
    uint sv598_removeduplicatesearches;
    uint sv598_lockviolationoffset;
    uint sv598_lockviolationdelay;
    uint sv598_mdlreadswitchover;
    uint sv598_cachedopenlimit;
    uint sv598_otherqueueaffinity;
    BOOL sv598_restrictnullsessaccess;
    BOOL sv598_enablewfw311directipx;
    uint sv598_queuesamplesecs;
    uint sv598_balancecount;
    uint sv598_preferredaffinity;
    uint sv598_maxfreerfcbs;
    uint sv598_maxfreemfcbs;
    uint sv598_maxfreelfcbs;
    uint sv598_maxfreepagedpoolchunks;
    uint sv598_minpagedpoolchunksize;
    uint sv598_maxpagedpoolchunksize;
    BOOL sv598_sendsfrompreferredprocessor;
    uint sv598_cacheddirectorylimit;
    uint sv598_maxcopylength;
    BOOL sv598_enablecompression;
    BOOL sv598_autosharewks;
    BOOL sv598_autoshareserver;
    BOOL sv598_enablesecuritysignature;
    BOOL sv598_requiresecuritysignature;
    uint sv598_minclientbuffersize;
    GUID sv598_serverguid;
    uint sv598_ConnectionNoSessionsTimeout;
    uint sv598_IdleThreadTimeOut;
    BOOL sv598_enableW9xsecuritysignature;
    BOOL sv598_enforcekerberosreauthentication;
    BOOL sv598_disabledos;
    uint sv598_lowdiskspaceminimum;
    BOOL sv598_disablestrictnamechecking;
    BOOL sv598_enableauthenticateusersharing;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1005
struct SERVER_INFO_1005
{
    PWSTR sv1005_comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1107
struct SERVER_INFO_1107
{
    uint sv1107_users;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1010
struct SERVER_INFO_1010
{
    int sv1010_disc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1016
struct SERVER_INFO_1016
{
    SERVER_INFO_HIDDEN sv1016_hidden;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1017
struct SERVER_INFO_1017
{
    uint sv1017_announce;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1018
struct SERVER_INFO_1018
{
    uint sv1018_anndelta;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1501
struct SERVER_INFO_1501
{
    uint sv1501_sessopens;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1502
struct SERVER_INFO_1502
{
    uint sv1502_sessvcs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1503
struct SERVER_INFO_1503
{
    uint sv1503_opensearch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1506
struct SERVER_INFO_1506
{
    uint sv1506_maxworkitems;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1509
struct SERVER_INFO_1509
{
    uint sv1509_maxrawbuflen;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1510
struct SERVER_INFO_1510
{
    uint sv1510_sessusers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1511
struct SERVER_INFO_1511
{
    uint sv1511_sessconns;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1512
struct SERVER_INFO_1512
{
    uint sv1512_maxnonpagedmemoryusage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1513
struct SERVER_INFO_1513
{
    uint sv1513_maxpagedmemoryusage;
}

struct SERVER_INFO_1514
{
    BOOL sv1514_enablesoftcompat;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1515
struct SERVER_INFO_1515
{
    BOOL sv1515_enableforcedlogoff;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1516
struct SERVER_INFO_1516
{
    BOOL sv1516_timesource;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1518
struct SERVER_INFO_1518
{
    BOOL sv1518_lmannounce;
}

struct SERVER_INFO_1520
{
    uint sv1520_maxcopyreadlen;
}

struct SERVER_INFO_1521
{
    uint sv1521_maxcopywritelen;
}

struct SERVER_INFO_1522
{
    uint sv1522_minkeepsearch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1523
struct SERVER_INFO_1523
{
    uint sv1523_maxkeepsearch;
}

struct SERVER_INFO_1524
{
    uint sv1524_minkeepcomplsearch;
}

struct SERVER_INFO_1525
{
    uint sv1525_maxkeepcomplsearch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1528
struct SERVER_INFO_1528
{
    uint sv1528_scavtimeout;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1529
struct SERVER_INFO_1529
{
    uint sv1529_minrcvqueue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1530
struct SERVER_INFO_1530
{
    uint sv1530_minfreeworkitems;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1533
struct SERVER_INFO_1533
{
    uint sv1533_maxmpxct;
}

struct SERVER_INFO_1534
{
    uint sv1534_oplockbreakwait;
}

struct SERVER_INFO_1535
{
    uint sv1535_oplockbreakresponsewait;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1536
struct SERVER_INFO_1536
{
    BOOL sv1536_enableoplocks;
}

struct SERVER_INFO_1537
{
    BOOL sv1537_enableoplockforceclose;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1538
struct SERVER_INFO_1538
{
    BOOL sv1538_enablefcbopens;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1539
struct SERVER_INFO_1539
{
    BOOL sv1539_enableraw;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1540
struct SERVER_INFO_1540
{
    BOOL sv1540_enablesharednetdrives;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1541
struct SERVER_INFO_1541
{
    BOOL sv1541_minfreeconnections;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1542
struct SERVER_INFO_1542
{
    BOOL sv1542_maxfreeconnections;
}

struct SERVER_INFO_1543
{
    uint sv1543_initsesstable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1544
struct SERVER_INFO_1544
{
    uint sv1544_initconntable;
}

struct SERVER_INFO_1545
{
    uint sv1545_initfiletable;
}

struct SERVER_INFO_1546
{
    uint sv1546_initsearchtable;
}

struct SERVER_INFO_1547
{
    uint sv1547_alertschedule;
}

struct SERVER_INFO_1548
{
    uint sv1548_errorthreshold;
}

struct SERVER_INFO_1549
{
    uint sv1549_networkerrorthreshold;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1550
struct SERVER_INFO_1550
{
    uint sv1550_diskspacethreshold;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_info_1552
struct SERVER_INFO_1552
{
    uint sv1552_maxlinkdelay;
}

struct SERVER_INFO_1553
{
    uint sv1553_minlinkthroughput;
}

struct SERVER_INFO_1554
{
    uint sv1554_linkinfovalidtime;
}

struct SERVER_INFO_1555
{
    uint sv1555_scavqosinfoupdatetime;
}

struct SERVER_INFO_1556
{
    uint sv1556_maxworkitemidletime;
}

struct SERVER_INFO_1557
{
    uint sv1557_maxrawworkitems;
}

struct SERVER_INFO_1560
{
    uint sv1560_producttype;
}

struct SERVER_INFO_1561
{
    uint sv1561_serversize;
}

struct SERVER_INFO_1562
{
    uint sv1562_connectionlessautodisc;
}

struct SERVER_INFO_1563
{
    uint sv1563_sharingviolationretries;
}

struct SERVER_INFO_1564
{
    uint sv1564_sharingviolationdelay;
}

struct SERVER_INFO_1565
{
    uint sv1565_maxglobalopensearch;
}

struct SERVER_INFO_1566
{
    BOOL sv1566_removeduplicatesearches;
}

struct SERVER_INFO_1567
{
    uint sv1567_lockviolationretries;
}

struct SERVER_INFO_1568
{
    uint sv1568_lockviolationoffset;
}

struct SERVER_INFO_1569
{
    uint sv1569_lockviolationdelay;
}

struct SERVER_INFO_1570
{
    uint sv1570_mdlreadswitchover;
}

struct SERVER_INFO_1571
{
    uint sv1571_cachedopenlimit;
}

struct SERVER_INFO_1572
{
    uint sv1572_criticalthreads;
}

struct SERVER_INFO_1573
{
    uint sv1573_restrictnullsessaccess;
}

struct SERVER_INFO_1574
{
    uint sv1574_enablewfw311directipx;
}

struct SERVER_INFO_1575
{
    uint sv1575_otherqueueaffinity;
}

struct SERVER_INFO_1576
{
    uint sv1576_queuesamplesecs;
}

struct SERVER_INFO_1577
{
    uint sv1577_balancecount;
}

struct SERVER_INFO_1578
{
    uint sv1578_preferredaffinity;
}

struct SERVER_INFO_1579
{
    uint sv1579_maxfreerfcbs;
}

struct SERVER_INFO_1580
{
    uint sv1580_maxfreemfcbs;
}

struct SERVER_INFO_1581
{
    uint sv1581_maxfreemlcbs;
}

struct SERVER_INFO_1582
{
    uint sv1582_maxfreepagedpoolchunks;
}

struct SERVER_INFO_1583
{
    uint sv1583_minpagedpoolchunksize;
}

struct SERVER_INFO_1584
{
    uint sv1584_maxpagedpoolchunksize;
}

struct SERVER_INFO_1585
{
    BOOL sv1585_sendsfrompreferredprocessor;
}

struct SERVER_INFO_1586
{
    uint sv1586_maxthreadsperqueue;
}

struct SERVER_INFO_1587
{
    uint sv1587_cacheddirectorylimit;
}

struct SERVER_INFO_1588
{
    uint sv1588_maxcopylength;
}

struct SERVER_INFO_1590
{
    uint sv1590_enablecompression;
}

struct SERVER_INFO_1591
{
    uint sv1591_autosharewks;
}

struct SERVER_INFO_1592
{
    uint sv1592_autosharewks;
}

struct SERVER_INFO_1593
{
    uint sv1593_enablesecuritysignature;
}

struct SERVER_INFO_1594
{
    uint sv1594_requiresecuritysignature;
}

struct SERVER_INFO_1595
{
    uint sv1595_minclientbuffersize;
}

struct SERVER_INFO_1596
{
    uint sv1596_ConnectionNoSessionsTimeout;
}

struct SERVER_INFO_1597
{
    uint sv1597_IdleThreadTimeOut;
}

struct SERVER_INFO_1598
{
    uint sv1598_enableW9xsecuritysignature;
}

struct SERVER_INFO_1599
{
    BOOLEAN sv1598_enforcekerberosreauthentication;
}

struct SERVER_INFO_1600
{
    BOOLEAN sv1598_disabledos;
}

struct SERVER_INFO_1601
{
    uint sv1598_lowdiskspaceminimum;
}

struct SERVER_INFO_1602
{
    BOOL sv_1598_disablestrictnamechecking;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_transport_info_0
struct SERVER_TRANSPORT_INFO_0
{
    uint   svti0_numberofvcs;
    PWSTR  svti0_transportname;
    ubyte* svti0_transportaddress;
    uint   svti0_transportaddresslength;
    PWSTR  svti0_networkaddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_transport_info_1
struct SERVER_TRANSPORT_INFO_1
{
    uint   svti1_numberofvcs;
    PWSTR  svti1_transportname;
    ubyte* svti1_transportaddress;
    uint   svti1_transportaddresslength;
    PWSTR  svti1_networkaddress;
    PWSTR  svti1_domain;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_transport_info_2
struct SERVER_TRANSPORT_INFO_2
{
    uint   svti2_numberofvcs;
    PWSTR  svti2_transportname;
    ubyte* svti2_transportaddress;
    uint   svti2_transportaddresslength;
    PWSTR  svti2_networkaddress;
    PWSTR  svti2_domain;
    uint   svti2_flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmserver/ns-lmserver-server_transport_info_3
struct SERVER_TRANSPORT_INFO_3
{
    uint       svti3_numberofvcs;
    PWSTR      svti3_transportname;
    ubyte*     svti3_transportaddress;
    uint       svti3_transportaddresslength;
    PWSTR      svti3_networkaddress;
    PWSTR      svti3_domain;
    uint       svti3_flags;
    uint       svti3_passwordlength;
    ubyte[256] svti3_password;
}

struct SERVICE_INFO_0
{
    PWSTR svci0_name;
}

struct SERVICE_INFO_1
{
    PWSTR svci1_name;
    uint  svci1_status;
    uint  svci1_code;
    uint  svci1_pid;
}

struct SERVICE_INFO_2
{
    PWSTR svci2_name;
    uint  svci2_status;
    uint  svci2_code;
    uint  svci2_pid;
    PWSTR svci2_text;
    uint  svci2_specific_error;
    PWSTR svci2_display_name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmuse/ns-lmuse-use_info_0
struct USE_INFO_0
{
    PWSTR ui0_local;
    PWSTR ui0_remote;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmuse/ns-lmuse-use_info_1
struct USE_INFO_1
{
    PWSTR             ui1_local;
    PWSTR             ui1_remote;
    PWSTR             ui1_password;
    uint              ui1_status;
    USE_INFO_ASG_TYPE ui1_asg_type;
    uint              ui1_refcount;
    uint              ui1_usecount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmuse/ns-lmuse-use_info_2
struct USE_INFO_2
{
    PWSTR             ui2_local;
    PWSTR             ui2_remote;
    PWSTR             ui2_password;
    uint              ui2_status;
    USE_INFO_ASG_TYPE ui2_asg_type;
    uint              ui2_refcount;
    uint              ui2_usecount;
    PWSTR             ui2_username;
    PWSTR             ui2_domainname;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmuse/ns-lmuse-use_info_3
struct USE_INFO_3
{
    USE_INFO_2 ui3_ui2;
    uint       ui3_flags;
}

struct USE_INFO_4
{
    USE_INFO_3 ui4_ui3;
    uint       ui4_auth_identity_length;
    ubyte*     ui4_auth_identity;
}

struct USE_INFO_5
{
    USE_INFO_3 ui4_ui3;
    uint       ui4_auth_identity_length;
    ubyte*     ui4_auth_identity;
    uint       ui5_security_descriptor_length;
    ubyte*     ui5_security_descriptor;
    uint       ui5_use_options_length;
    ubyte*     ui5_use_options;
}

struct USE_OPTION_GENERIC
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

struct USE_OPTION_DEFERRED_CONNECTION_PARAMETERS
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

struct TRANSPORT_INFO
{
    TRANSPORT_TYPE Type;
    BOOLEAN        SkipCertificateCheck;
    ushort         TcpPort;
    ushort         QuicPort;
    ushort         RdmaPort;
    uint           Flags;
}

struct USE_OPTION_TRANSPORT_PARAMETERS
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

struct SMB_COMPRESSION_INFO
{
    BOOLEAN Switch;
    ubyte   Reserved1;
    ushort  Reserved2;
    uint    Reserved3;
}

struct SMB_USE_OPTION_COMPRESSION_PARAMETERS
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

struct BLOCK_NTLM_INFO
{
    BOOLEAN BlockNTLM;
    ubyte   Reserved1;
    ushort  Reserved2;
    uint    Reserved3;
}

struct USE_OPTION_BLOCK_NTLM_PARAMETERS
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

struct SMB_TREE_CONNECT_PARAMETERS
{
    uint EABufferOffset;
    uint EABufferLen;
    uint CreateOptions;
    uint TreeConnectAttributes;
}

struct USE_OPTION_PROPERTIES
{
    uint   Tag;
    void*  pInfo;
    size_t Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmwksta/ns-lmwksta-wksta_info_100
struct WKSTA_INFO_100
{
    uint  wki100_platform_id;
    PWSTR wki100_computername;
    PWSTR wki100_langroup;
    uint  wki100_ver_major;
    uint  wki100_ver_minor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmwksta/ns-lmwksta-wksta_info_101
struct WKSTA_INFO_101
{
    uint  wki101_platform_id;
    PWSTR wki101_computername;
    PWSTR wki101_langroup;
    uint  wki101_ver_major;
    uint  wki101_ver_minor;
    PWSTR wki101_lanroot;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmwksta/ns-lmwksta-wksta_info_102
struct WKSTA_INFO_102
{
    uint  wki102_platform_id;
    PWSTR wki102_computername;
    PWSTR wki102_langroup;
    uint  wki102_ver_major;
    uint  wki102_ver_minor;
    PWSTR wki102_lanroot;
    uint  wki102_logged_on_users;
}

struct WKSTA_INFO_302
{
    uint  wki302_char_wait;
    uint  wki302_collection_time;
    uint  wki302_maximum_collection_count;
    uint  wki302_keep_conn;
    uint  wki302_keep_search;
    uint  wki302_max_cmds;
    uint  wki302_num_work_buf;
    uint  wki302_siz_work_buf;
    uint  wki302_max_wrk_cache;
    uint  wki302_sess_timeout;
    uint  wki302_siz_error;
    uint  wki302_num_alerts;
    uint  wki302_num_services;
    uint  wki302_errlog_sz;
    uint  wki302_print_buf_time;
    uint  wki302_num_char_buf;
    uint  wki302_siz_char_buf;
    PWSTR wki302_wrk_heuristics;
    uint  wki302_mailslots;
    uint  wki302_num_dgram_buf;
}

struct WKSTA_INFO_402
{
    uint  wki402_char_wait;
    uint  wki402_collection_time;
    uint  wki402_maximum_collection_count;
    uint  wki402_keep_conn;
    uint  wki402_keep_search;
    uint  wki402_max_cmds;
    uint  wki402_num_work_buf;
    uint  wki402_siz_work_buf;
    uint  wki402_max_wrk_cache;
    uint  wki402_sess_timeout;
    uint  wki402_siz_error;
    uint  wki402_num_alerts;
    uint  wki402_num_services;
    uint  wki402_errlog_sz;
    uint  wki402_print_buf_time;
    uint  wki402_num_char_buf;
    uint  wki402_siz_char_buf;
    PWSTR wki402_wrk_heuristics;
    uint  wki402_mailslots;
    uint  wki402_num_dgram_buf;
    uint  wki402_max_threads;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmwksta/ns-lmwksta-wksta_info_502
struct WKSTA_INFO_502
{
    uint wki502_char_wait;
    uint wki502_collection_time;
    uint wki502_maximum_collection_count;
    uint wki502_keep_conn;
    uint wki502_max_cmds;
    uint wki502_sess_timeout;
    uint wki502_siz_char_buf;
    uint wki502_max_threads;
    uint wki502_lock_quota;
    uint wki502_lock_increment;
    uint wki502_lock_maximum;
    uint wki502_pipe_increment;
    uint wki502_pipe_maximum;
    uint wki502_cache_file_timeout;
    uint wki502_dormant_file_limit;
    uint wki502_read_ahead_throughput;
    uint wki502_num_mailslot_buffers;
    uint wki502_num_srv_announce_buffers;
    uint wki502_max_illegal_datagram_events;
    uint wki502_illegal_datagram_event_reset_frequency;
    BOOL wki502_log_election_packets;
    BOOL wki502_use_opportunistic_locking;
    BOOL wki502_use_unlock_behind;
    BOOL wki502_use_close_behind;
    BOOL wki502_buf_named_pipes;
    BOOL wki502_use_lock_read_unlock;
    BOOL wki502_utilize_nt_caching;
    BOOL wki502_use_raw_read;
    BOOL wki502_use_raw_write;
    BOOL wki502_use_write_raw_data;
    BOOL wki502_use_encryption;
    BOOL wki502_buf_files_deny_write;
    BOOL wki502_buf_read_only_files;
    BOOL wki502_force_core_create_mode;
    BOOL wki502_use_512_byte_max_transfer;
}

struct WKSTA_INFO_1010
{
    uint wki1010_char_wait;
}

struct WKSTA_INFO_1011
{
    uint wki1011_collection_time;
}

struct WKSTA_INFO_1012
{
    uint wki1012_maximum_collection_count;
}

struct WKSTA_INFO_1027
{
    uint wki1027_errlog_sz;
}

struct WKSTA_INFO_1028
{
    uint wki1028_print_buf_time;
}

struct WKSTA_INFO_1032
{
    uint wki1032_wrk_heuristics;
}

struct WKSTA_INFO_1013
{
    uint wki1013_keep_conn;
}

struct WKSTA_INFO_1018
{
    uint wki1018_sess_timeout;
}

struct WKSTA_INFO_1023
{
    uint wki1023_siz_char_buf;
}

struct WKSTA_INFO_1033
{
    uint wki1033_max_threads;
}

struct WKSTA_INFO_1041
{
    uint wki1041_lock_quota;
}

struct WKSTA_INFO_1042
{
    uint wki1042_lock_increment;
}

struct WKSTA_INFO_1043
{
    uint wki1043_lock_maximum;
}

struct WKSTA_INFO_1044
{
    uint wki1044_pipe_increment;
}

struct WKSTA_INFO_1045
{
    uint wki1045_pipe_maximum;
}

struct WKSTA_INFO_1046
{
    uint wki1046_dormant_file_limit;
}

struct WKSTA_INFO_1047
{
    uint wki1047_cache_file_timeout;
}

struct WKSTA_INFO_1048
{
    BOOL wki1048_use_opportunistic_locking;
}

struct WKSTA_INFO_1049
{
    BOOL wki1049_use_unlock_behind;
}

struct WKSTA_INFO_1050
{
    BOOL wki1050_use_close_behind;
}

struct WKSTA_INFO_1051
{
    BOOL wki1051_buf_named_pipes;
}

struct WKSTA_INFO_1052
{
    BOOL wki1052_use_lock_read_unlock;
}

struct WKSTA_INFO_1053
{
    BOOL wki1053_utilize_nt_caching;
}

struct WKSTA_INFO_1054
{
    BOOL wki1054_use_raw_read;
}

struct WKSTA_INFO_1055
{
    BOOL wki1055_use_raw_write;
}

struct WKSTA_INFO_1056
{
    BOOL wki1056_use_write_raw_data;
}

struct WKSTA_INFO_1057
{
    BOOL wki1057_use_encryption;
}

struct WKSTA_INFO_1058
{
    BOOL wki1058_buf_files_deny_write;
}

struct WKSTA_INFO_1059
{
    BOOL wki1059_buf_read_only_files;
}

struct WKSTA_INFO_1060
{
    BOOL wki1060_force_core_create_mode;
}

struct WKSTA_INFO_1061
{
    BOOL wki1061_use_512_byte_max_transfer;
}

struct WKSTA_INFO_1062
{
    uint wki1062_read_ahead_throughput;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmwksta/ns-lmwksta-wksta_user_info_0
struct WKSTA_USER_INFO_0
{
    PWSTR wkui0_username;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmwksta/ns-lmwksta-wksta_user_info_1
struct WKSTA_USER_INFO_1
{
    PWSTR wkui1_username;
    PWSTR wkui1_logon_domain;
    PWSTR wkui1_oth_domains;
    PWSTR wkui1_logon_server;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmwksta/ns-lmwksta-wksta_user_info_1101
struct WKSTA_USER_INFO_1101
{
    PWSTR wkui1101_oth_domains;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmwksta/ns-lmwksta-wksta_transport_info_0
struct WKSTA_TRANSPORT_INFO_0
{
    uint  wkti0_quality_of_service;
    uint  wkti0_number_of_vcs;
    PWSTR wkti0_transport_name;
    PWSTR wkti0_transport_address;
    BOOL  wkti0_wan_ish;
}

struct ERROR_LOG
{
    uint   el_len;
    uint   el_reserved;
    uint   el_time;
    uint   el_error;
    PWSTR  el_name;
    PWSTR  el_text;
    ubyte* el_data;
    uint   el_data_size;
    uint   el_nstrings;
}

struct HLOG
{
    uint time;
    uint last_flags;
    uint offset;
    uint rec_offset;
}

struct CONFIG_INFO_0
{
    PWSTR cfgi0_key;
    PWSTR cfgi0_data;
}

struct AUDIT_ENTRY
{
    uint ae_len;
    uint ae_reserved;
    uint ae_time;
    uint ae_type;
    uint ae_data_offset;
    uint ae_data_size;
}

struct AE_SRVSTATUS
{
    uint ae_sv_status;
}

struct AE_SESSLOGON
{
    uint ae_so_compname;
    uint ae_so_username;
    uint ae_so_privilege;
}

struct AE_SESSLOGOFF
{
    uint ae_sf_compname;
    uint ae_sf_username;
    uint ae_sf_reason;
}

struct AE_SESSPWERR
{
    uint ae_sp_compname;
    uint ae_sp_username;
}

struct AE_CONNSTART
{
    uint ae_ct_compname;
    uint ae_ct_username;
    uint ae_ct_netname;
    uint ae_ct_connid;
}

struct AE_CONNSTOP
{
    uint ae_cp_compname;
    uint ae_cp_username;
    uint ae_cp_netname;
    uint ae_cp_connid;
    uint ae_cp_reason;
}

struct AE_CONNREJ
{
    uint ae_cr_compname;
    uint ae_cr_username;
    uint ae_cr_netname;
    uint ae_cr_reason;
}

struct AE_RESACCESS
{
    uint ae_ra_compname;
    uint ae_ra_username;
    uint ae_ra_resname;
    uint ae_ra_operation;
    uint ae_ra_returncode;
    uint ae_ra_restype;
    uint ae_ra_fileid;
}

struct AE_RESACCESSREJ
{
    uint ae_rr_compname;
    uint ae_rr_username;
    uint ae_rr_resname;
    uint ae_rr_operation;
}

struct AE_CLOSEFILE
{
    uint ae_cf_compname;
    uint ae_cf_username;
    uint ae_cf_resname;
    uint ae_cf_fileid;
    uint ae_cf_duration;
    uint ae_cf_reason;
}

struct AE_SERVICESTAT
{
    uint ae_ss_compname;
    uint ae_ss_username;
    uint ae_ss_svcname;
    uint ae_ss_status;
    uint ae_ss_code;
    uint ae_ss_text;
    uint ae_ss_returnval;
}

struct AE_ACLMOD
{
    uint ae_am_compname;
    uint ae_am_username;
    uint ae_am_resname;
    uint ae_am_action;
    uint ae_am_datalen;
}

struct AE_UASMOD
{
    uint ae_um_compname;
    uint ae_um_username;
    uint ae_um_resname;
    uint ae_um_rectype;
    uint ae_um_action;
    uint ae_um_datalen;
}

struct AE_NETLOGON
{
    uint ae_no_compname;
    uint ae_no_username;
    uint ae_no_privilege;
    uint ae_no_authflags;
}

struct AE_NETLOGOFF
{
    uint ae_nf_compname;
    uint ae_nf_username;
    uint ae_nf_reserved1;
    uint ae_nf_reserved2;
}

struct AE_ACCLIM
{
    uint ae_al_compname;
    uint ae_al_username;
    uint ae_al_resname;
    uint ae_al_limit;
}

struct AE_LOCKOUT
{
    uint ae_lk_compname;
    uint ae_lk_username;
    uint ae_lk_action;
    uint ae_lk_bad_pw_count;
}

struct AE_GENERIC
{
    uint ae_ge_msgfile;
    uint ae_ge_msgnum;
    uint ae_ge_params;
    uint ae_ge_param1;
    uint ae_ge_param2;
    uint ae_ge_param3;
    uint ae_ge_param4;
    uint ae_ge_param5;
    uint ae_ge_param6;
    uint ae_ge_param7;
    uint ae_ge_param8;
    uint ae_ge_param9;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmjoin/ns-lmjoin-dsreg_user_info
struct DSREG_USER_INFO
{
    PWSTR pszUserEmail;
    PWSTR pszUserKeyId;
    PWSTR pszUserKeyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmjoin/ns-lmjoin-dsreg_join_info
struct DSREG_JOIN_INFO
{
    DSREG_JOIN_TYPE      joinType;
    const(CERT_CONTEXT)* pJoinCertificate;
    PWSTR                pszDeviceId;
    PWSTR                pszIdpDomain;
    PWSTR                pszTenantId;
    PWSTR                pszJoinUserEmail;
    PWSTR                pszTenantDisplayName;
    PWSTR                pszMdmEnrollmentUrl;
    PWSTR                pszMdmTermsOfUseUrl;
    PWSTR                pszMdmComplianceUrl;
    PWSTR                pszUserSettingSyncUrl;
    DSREG_USER_INFO*     pUserInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmjoin/ns-lmjoin-netsetup_provisioning_params
struct NETSETUP_PROVISIONING_PARAMS
{
    uint               dwVersion;
    const(PWSTR)       lpDomain;
    const(PWSTR)       lpHostName;
    const(PWSTR)       lpMachineAccountOU;
    const(PWSTR)       lpDcName;
    NETSETUP_PROVISION dwProvisionOptions;
    const(PWSTR)*      aCertTemplateNames;
    uint               cCertTemplateNames;
    const(PWSTR)*      aMachinePolicyNames;
    uint               cMachinePolicyNames;
    const(PWSTR)*      aMachinePolicyPaths;
    uint               cMachinePolicyPaths;
    PWSTR              lpNetbiosName;
    PWSTR              lpSiteName;
    PWSTR              lpPrimaryDNSDomain;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmat/ns-lmat-at_info
struct AT_INFO
{
    size_t JobTime;
    uint   DaysOfMonth;
    ubyte  DaysOfWeek;
    ubyte  Flags;
    PWSTR  Command;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmat/ns-lmat-at_enum
struct AT_ENUM
{
    uint   JobId;
    size_t JobTime;
    uint   DaysOfMonth;
    ubyte  DaysOfWeek;
    ubyte  Flags;
    PWSTR  Command;
}

struct FLAT_STRING
{
    short   MaximumLength;
    short   Length;
    CHAR[1] Buffer; // Flexible array
}

struct NETWORK_NAME
{
    FLAT_STRING Name;
}

struct HARDWARE_ADDRESS
{
    ubyte[6] Address;
}

struct OBO_TOKEN
{
    OBO_TOKEN_TYPE   Type;
    INetCfgComponent pncc;
    const(PWSTR)     pszwManufacturer;
    const(PWSTR)     pszwProduct;
    const(PWSTR)     pszwDisplayName;
    BOOL             fRegistered;
}

struct RASCON_IPUI
{
    GUID       guidConnection;
    BOOL       fIPv6Cfg;
    uint       dwFlags;
    wchar[16]  pszwIpAddr;
    wchar[16]  pszwDnsAddr;
    wchar[16]  pszwDns2Addr;
    wchar[16]  pszwWinsAddr;
    wchar[16]  pszwWins2Addr;
    wchar[256] pszwDnsSuffix;
    wchar[65]  pszwIpv6Addr;
    uint       dwIpv6PrefixLength;
    wchar[65]  pszwIpv6DnsAddr;
    wchar[65]  pszwIpv6Dns2Addr;
    uint       dwIPv4InfMetric;
    uint       dwIPv6InfMetric;
}

struct RTR_TOC_ENTRY
{
    uint InfoType;
    uint InfoSize;
    uint Count;
    uint Offset;
}

struct RTR_INFO_BLOCK_HEADER
{
    uint             Version;
    uint             Size;
    uint             TocEntriesCount;
    RTR_TOC_ENTRY[1] TocEntry; // Flexible array
}

struct MPR_PROTOCOL_0
{
    uint      dwProtocolId;
    wchar[41] wszProtocol;
    wchar[49] wszDLLName;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUserAdd(const(PWSTR) servername, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUserEnum(const(PWSTR) servername, uint level, NET_USER_ENUM_FILTER_FLAGS filter, ubyte** bufptr, 
                 uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetUserGetInfo(const(PWSTR) servername, const(PWSTR) username, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUserSetInfo(const(PWSTR) servername, const(PWSTR) username, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUserDel(const(PWSTR) servername, const(PWSTR) username);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUserGetGroups(const(PWSTR) servername, const(PWSTR) username, uint level, ubyte** bufptr, uint prefmaxlen, 
                      uint* entriesread, uint* totalentries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUserSetGroups(const(PWSTR) servername, const(PWSTR) username, uint level, ubyte* buf, uint num_entries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUserGetLocalGroups(const(PWSTR) servername, const(PWSTR) username, uint level, uint flags, ubyte** bufptr, 
                           uint prefmaxlen, uint* entriesread, uint* totalentries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUserModalsGet(const(PWSTR) servername, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUserModalsSet(const(PWSTR) servername, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUserChangePassword(const(PWSTR) domainname, const(PWSTR) username, const(PWSTR) oldpassword, 
                           const(PWSTR) newpassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGroupAdd(const(PWSTR) servername, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGroupAddUser(const(PWSTR) servername, const(PWSTR) GroupName, const(PWSTR) username);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGroupEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                  uint* totalentries, size_t* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGroupGetInfo(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGroupSetInfo(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGroupDel(const(PWSTR) servername, const(PWSTR) groupname);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGroupDelUser(const(PWSTR) servername, const(PWSTR) GroupName, const(PWSTR) Username);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGroupGetUsers(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte** bufptr, uint prefmaxlen, 
                      uint* entriesread, uint* totalentries, size_t* ResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGroupSetUsers(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, uint totalentries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetLocalGroupAdd(const(PWSTR) servername, uint level, ubyte* buf, uint* parm_err);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/nf-lmaccess-netlocalgroupaddmember
@DllImport("NETAPI32.dll")
uint NetLocalGroupAddMember(const(PWSTR) servername, const(PWSTR) groupname, PSID membersid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetLocalGroupEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                       uint* totalentries, size_t* resumehandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetLocalGroupGetInfo(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetLocalGroupSetInfo(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetLocalGroupDel(const(PWSTR) servername, const(PWSTR) groupname);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/nf-lmaccess-netlocalgroupdelmember
@DllImport("NETAPI32.dll")
uint NetLocalGroupDelMember(const(PWSTR) servername, const(PWSTR) groupname, PSID membersid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetLocalGroupGetMembers(const(PWSTR) servername, const(PWSTR) localgroupname, uint level, ubyte** bufptr, 
                             uint prefmaxlen, uint* entriesread, uint* totalentries, size_t* resumehandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetLocalGroupSetMembers(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, 
                             uint totalentries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetLocalGroupAddMembers(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, 
                             uint totalentries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetLocalGroupDelMembers(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, 
                             uint totalentries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetQueryDisplayInformation(const(PWSTR) ServerName, uint Level, uint Index, uint EntriesRequested, 
                                uint PreferredMaximumLength, uint* ReturnedEntryCount, void** SortedBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGetDisplayInformationIndex(const(PWSTR) ServerName, uint Level, const(PWSTR) Prefix, uint* Index);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetAccessAdd(const(PWSTR) servername, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetAccessEnum(const(PWSTR) servername, const(PWSTR) BasePath, uint Recursive, uint level, ubyte** bufptr, 
                   uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetAccessGetInfo(const(PWSTR) servername, const(PWSTR) resource, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetAccessSetInfo(const(PWSTR) servername, const(PWSTR) resource, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetAccessDel(const(PWSTR) servername, const(PWSTR) resource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetAccessGetUserPerms(const(PWSTR) servername, const(PWSTR) UGname, const(PWSTR) resource, uint* Perms);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("NETAPI32.dll")
uint NetValidatePasswordPolicy(const(PWSTR) ServerName, void* Qualifier, NET_VALIDATE_PASSWORD_TYPE ValidationType, 
                               void* InputArg, void** OutputArg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("NETAPI32.dll")
uint NetValidatePasswordPolicyFree(void** OutputArg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGetDCName(const(PWSTR) ServerName, const(PWSTR) DomainName, ubyte** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGetAnyDCName(const(PWSTR) ServerName, const(PWSTR) DomainName, ubyte** Buffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmaccess/nf-lmaccess-i_netlogoncontrol2
@DllImport("NETAPI32.dll")
uint I_NetLogonControl2(const(PWSTR) ServerName, uint FunctionCode, uint QueryLevel, ubyte* Data, ubyte** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NETAPI32.dll")
NTSTATUS NetAddServiceAccount(PWSTR ServerName, PWSTR AccountName, PWSTR Password, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NETAPI32.dll")
NTSTATUS NetRemoveServiceAccount(PWSTR ServerName, PWSTR AccountName, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NETAPI32.dll")
NTSTATUS NetEnumerateServiceAccounts(PWSTR ServerName, uint Flags, uint* AccountsCount, ushort*** Accounts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NETAPI32.dll")
NTSTATUS NetIsServiceAccount(PWSTR ServerName, PWSTR AccountName, BOOL* IsService);

@DllImport("NETAPI32.dll")
NTSTATUS NetIsServiceAccount2(PWSTR ServerName, PWSTR AccountName, BOOL* IsService, 
                              MSA_INFO_ACCOUNT_TYPE* AccountType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NETAPI32.dll")
NTSTATUS NetQueryServiceAccount(PWSTR ServerName, PWSTR AccountName, uint InfoLevel, ubyte** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetAlertRaise(const(PWSTR) AlertType, void* Buffer, uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetAlertRaiseEx(const(PWSTR) AlertType, void* VariableInfo, uint VariableInfoSize, const(PWSTR) ServiceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetMessageNameAdd(const(PWSTR) servername, const(PWSTR) msgname);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetMessageNameEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                        uint* totalentries, uint* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetMessageNameGetInfo(const(PWSTR) servername, const(PWSTR) msgname, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetMessageNameDel(const(PWSTR) servername, const(PWSTR) msgname);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetMessageBufferSend(const(PWSTR) servername, const(PWSTR) msgname, const(PWSTR) fromname, ubyte* buf, 
                          uint buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetRemoteTOD(const(PWSTR) UncServerName, ubyte** BufferPtr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetRemoteComputerSupports(const(PWSTR) UncServerName, NET_REMOTE_COMPUTER_SUPPORTS_OPTIONS OptionsWanted, 
                               uint* OptionsSupported);

@DllImport("NETAPI32.dll")
uint NetReplGetInfo(const(PWSTR) servername, uint level, ubyte** bufptr);

@DllImport("NETAPI32.dll")
uint NetReplSetInfo(const(PWSTR) servername, uint level, const(ubyte)* buf, uint* parm_err);

@DllImport("NETAPI32.dll")
uint NetReplExportDirAdd(const(PWSTR) servername, uint level, const(ubyte)* buf, uint* parm_err);

@DllImport("NETAPI32.dll")
uint NetReplExportDirDel(const(PWSTR) servername, const(PWSTR) dirname);

@DllImport("NETAPI32.dll")
uint NetReplExportDirEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                          uint* totalentries, uint* resumehandle);

@DllImport("NETAPI32.dll")
uint NetReplExportDirGetInfo(const(PWSTR) servername, const(PWSTR) dirname, uint level, ubyte** bufptr);

@DllImport("NETAPI32.dll")
uint NetReplExportDirSetInfo(const(PWSTR) servername, const(PWSTR) dirname, uint level, const(ubyte)* buf, 
                             uint* parm_err);

@DllImport("NETAPI32.dll")
uint NetReplExportDirLock(const(PWSTR) servername, const(PWSTR) dirname);

@DllImport("NETAPI32.dll")
uint NetReplExportDirUnlock(const(PWSTR) servername, const(PWSTR) dirname, uint unlockforce);

@DllImport("NETAPI32.dll")
uint NetReplImportDirAdd(const(PWSTR) servername, uint level, const(ubyte)* buf, uint* parm_err);

@DllImport("NETAPI32.dll")
uint NetReplImportDirDel(const(PWSTR) servername, const(PWSTR) dirname);

@DllImport("NETAPI32.dll")
uint NetReplImportDirEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                          uint* totalentries, uint* resumehandle);

@DllImport("NETAPI32.dll")
uint NetReplImportDirGetInfo(const(PWSTR) servername, const(PWSTR) dirname, uint level, ubyte** bufptr);

@DllImport("NETAPI32.dll")
uint NetReplImportDirLock(const(PWSTR) servername, const(PWSTR) dirname);

@DllImport("NETAPI32.dll")
uint NetReplImportDirUnlock(const(PWSTR) servername, const(PWSTR) dirname, uint unlockforce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetServerEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                   uint* totalentries, NET_SERVER_TYPE servertype, const(PWSTR) domain, uint* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetServerGetInfo(PWSTR servername, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetServerSetInfo(PWSTR servername, uint level, ubyte* buf, uint* ParmError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetServerDiskEnum(PWSTR servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                       uint* totalentries, uint* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetServerComputerNameAdd(PWSTR ServerName, PWSTR EmulatedDomainName, PWSTR EmulatedServerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetServerComputerNameDel(PWSTR ServerName, PWSTR EmulatedServerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetServerTransportAdd(PWSTR servername, uint level, ubyte* bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetServerTransportAddEx(PWSTR servername, uint level, ubyte* bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetServerTransportDel(PWSTR servername, uint level, ubyte* bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetServerTransportEnum(PWSTR servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                            uint* totalentries, uint* resume_handle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/NetMgmt/netservicecontrol
@DllImport("NETAPI32.dll")
uint NetServiceControl(const(PWSTR) servername, const(PWSTR) service, uint opcode, uint arg, ubyte** bufptr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/NetMgmt/netserviceenum
@DllImport("NETAPI32.dll")
uint NetServiceEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                    uint* totalentries, uint* resume_handle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/NetMgmt/netservicegetinfo
@DllImport("NETAPI32.dll")
uint NetServiceGetInfo(const(PWSTR) servername, const(PWSTR) service, uint level, ubyte** bufptr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/NetMgmt/netserviceinstall
@DllImport("NETAPI32.dll")
uint NetServiceInstall(const(PWSTR) servername, const(PWSTR) service, uint argc, const(PWSTR)* argv, 
                       ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUseAdd(byte* servername, uint LevelFlags, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUseDel(PWSTR UncServerName, PWSTR UseName, FORCE_LEVEL_FLAGS ForceLevelFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUseEnum(PWSTR UncServerName, uint LevelFlags, ubyte** BufPtr, uint PreferedMaximumSize, uint* EntriesRead, 
                uint* TotalEntries, uint* ResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUseGetInfo(PWSTR UncServerName, PWSTR UseName, uint LevelFlags, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetWkstaGetInfo(PWSTR servername, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetWkstaSetInfo(PWSTR servername, uint level, ubyte* buffer, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetWkstaUserGetInfo(PWSTR reserved, uint level, ubyte** bufptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetWkstaUserSetInfo(PWSTR reserved, uint level, ubyte* buf, uint* parm_err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetWkstaUserEnum(PWSTR servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                      uint* totalentries, uint* resumehandle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmwksta/nf-lmwksta-netwkstatransportadd
@DllImport("NETAPI32.dll")
uint NetWkstaTransportAdd(byte* servername, uint level, ubyte* buf, uint* parm_err);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmwksta/nf-lmwksta-netwkstatransportdel
@DllImport("NETAPI32.dll")
uint NetWkstaTransportDel(PWSTR servername, PWSTR transportname, FORCE_LEVEL_FLAGS ucond);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetWkstaTransportEnum(byte* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                           uint* totalentries, uint* resume_handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetApiBufferAllocate(uint ByteCount, void** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetApiBufferFree(void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetApiBufferReallocate(void* OldBuffer, uint NewByteCount, void** NewBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetApiBufferSize(void* Buffer, uint* ByteCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmerrlog/nf-lmerrlog-neterrorlogclear
@DllImport("NETAPI32.dll")
uint NetErrorLogClear(const(PWSTR) UncServerName, const(PWSTR) BackupFile, ubyte* Reserved);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmerrlog/nf-lmerrlog-neterrorlogread
@DllImport("NETAPI32.dll")
uint NetErrorLogRead(const(PWSTR) UncServerName, PWSTR Reserved1, HLOG* ErrorLogHandle, uint Offset, 
                     uint* Reserved2, uint Reserved3, uint OffsetFlag, ubyte** BufPtr, uint PrefMaxSize, 
                     uint* BytesRead, uint* TotalAvailable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmerrlog/nf-lmerrlog-neterrorlogwrite
@DllImport("NETAPI32.dll")
uint NetErrorLogWrite(ubyte* Reserved1, uint Code, const(PWSTR) Component, ubyte* Buffer, uint NumBytes, 
                      ubyte* MsgBuf, uint StrCount, ubyte* Reserved2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmconfig/nf-lmconfig-netconfigget
@DllImport("NETAPI32.dll")
uint NetConfigGet(const(PWSTR) server, const(PWSTR) component, const(PWSTR) parameter, ubyte** bufptr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmconfig/nf-lmconfig-netconfiggetall
@DllImport("NETAPI32.dll")
uint NetConfigGetAll(const(PWSTR) server, const(PWSTR) component, ubyte** bufptr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lmconfig/nf-lmconfig-netconfigset
@DllImport("NETAPI32.dll")
uint NetConfigSet(const(PWSTR) server, const(PWSTR) reserved1, const(PWSTR) component, uint level, uint reserved2, 
                  ubyte* buf, uint reserved3);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/NetMgmt/netauditclear
@DllImport("NETAPI32.dll")
uint NetAuditClear(const(PWSTR) server, const(PWSTR) backupfile, const(PWSTR) service);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/NetMgmt/netauditread
@DllImport("NETAPI32.dll")
uint NetAuditRead(const(PWSTR) server, const(PWSTR) service, HLOG* auditloghandle, uint offset, uint* reserved1, 
                  uint reserved2, uint offsetflag, ubyte** bufptr, uint prefmaxlen, uint* bytesread, 
                  uint* totalavailable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/NetMgmt/netauditwrite
@DllImport("NETAPI32.dll")
uint NetAuditWrite(uint type, ubyte* buf, uint numbytes, const(PWSTR) service, ubyte* reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetJoinDomain(const(PWSTR) lpServer, const(PWSTR) lpDomain, const(PWSTR) lpMachineAccountOU, 
                   const(PWSTR) lpAccount, const(PWSTR) lpPassword, NET_JOIN_DOMAIN_JOIN_OPTIONS fJoinOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetUnjoinDomain(const(PWSTR) lpServer, const(PWSTR) lpAccount, const(PWSTR) lpPassword, uint fUnjoinOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetRenameMachineInDomain(const(PWSTR) lpServer, const(PWSTR) lpNewMachineName, const(PWSTR) lpAccount, 
                              const(PWSTR) lpPassword, uint fRenameOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetValidateName(const(PWSTR) lpServer, const(PWSTR) lpName, const(PWSTR) lpAccount, const(PWSTR) lpPassword, 
                     NETSETUP_NAME_TYPE NameType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGetJoinableOUs(const(PWSTR) lpServer, const(PWSTR) lpDomain, const(PWSTR) lpAccount, 
                       const(PWSTR) lpPassword, uint* OUCount, PWSTR** OUs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetAddAlternateComputerName(const(PWSTR) Server, const(PWSTR) AlternateName, const(PWSTR) DomainAccount, 
                                 const(PWSTR) DomainAccountPassword, uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetRemoveAlternateComputerName(const(PWSTR) Server, const(PWSTR) AlternateName, const(PWSTR) DomainAccount, 
                                    const(PWSTR) DomainAccountPassword, uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetSetPrimaryComputerName(const(PWSTR) Server, const(PWSTR) PrimaryName, const(PWSTR) DomainAccount, 
                               const(PWSTR) DomainAccountPassword, uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETAPI32.dll")
uint NetEnumerateComputerNames(const(PWSTR) Server, NET_COMPUTER_NAME_TYPE NameType, uint Reserved, 
                               uint* EntryCount, PWSTR** ComputerNames);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NETAPI32.dll")
uint NetProvisionComputerAccount(const(PWSTR) lpDomain, const(PWSTR) lpMachineName, 
                                 const(PWSTR) lpMachineAccountOU, const(PWSTR) lpDcName, 
                                 NETSETUP_PROVISION dwOptions, ubyte** pProvisionBinData, 
                                 uint* pdwProvisionBinDataSize, PWSTR* pProvisionTextData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NETAPI32.dll")
uint NetRequestOfflineDomainJoin(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pProvisionBinData, 
                                 uint cbProvisionBinDataSize, NET_REQUEST_PROVISION_OPTIONS dwOptions, 
                                 const(PWSTR) lpWindowsPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NETAPI32.dll")
uint NetCreateProvisioningPackage(NETSETUP_PROVISIONING_PARAMS* pProvisioningParams, ubyte** ppPackageBinData, 
                                  uint* pdwPackageBinDataSize, PWSTR* ppPackageTextData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NETAPI32.dll")
uint NetRequestProvisioningPackageInstall(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pPackageBinData, 
                                          uint dwPackageBinDataSize, 
                                          NET_REQUEST_PROVISION_OPTIONS dwProvisionOptions, 
                                          const(PWSTR) lpWindowsPath, 
                                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("NETAPI32.dll")
HRESULT NetGetAadJoinInformation(const(PWSTR) pcszTenantId, DSREG_JOIN_INFO** ppJoinInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("NETAPI32.dll")
void NetFreeAadJoinInformation(DSREG_JOIN_INFO* pJoinInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetGetJoinInformation(const(PWSTR) lpServer, PWSTR* lpNameBuffer, NETSETUP_JOIN_STATUS* BufferType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("mstask.dll")
HRESULT GetNetScheduleAccountInformation(const(PWSTR) pwszServerName, uint ccAccount, PWSTR wszAccount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("mstask.dll")
HRESULT SetNetScheduleAccountInformation(const(PWSTR) pwszServerName, const(PWSTR) pwszAccount, 
                                         const(PWSTR) pwszPassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetScheduleJobAdd(const(PWSTR) Servername, ubyte* Buffer, uint* JobId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetScheduleJobDel(const(PWSTR) Servername, uint MinJobId, uint MaxJobId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetScheduleJobEnum(const(PWSTR) Servername, ubyte** PointerToBuffer, uint PrefferedMaximumLength, 
                        uint* EntriesRead, uint* TotalEntries, uint* ResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
uint NetScheduleJobGetInfo(const(PWSTR) Servername, uint JobId, ubyte** PointerToBuffer);

@DllImport("rtutils.dll")
uint TraceRegisterExA(const(PSTR) lpszCallerName, uint dwFlags);

@DllImport("rtutils.dll")
uint TraceDeregisterA(uint dwTraceID);

@DllImport("rtutils.dll")
uint TraceDeregisterExA(uint dwTraceID, uint dwFlags);

@DllImport("rtutils.dll")
uint TraceGetConsoleA(uint dwTraceID, HANDLE* lphConsole);

@DllImport("rtutils.dll")
uint TracePrintfA(uint dwTraceID, const(PSTR) lpszFormat);

@DllImport("rtutils.dll")
uint TracePrintfExA(uint dwTraceID, uint dwFlags, const(PSTR) lpszFormat);

@DllImport("rtutils.dll")
uint TraceVprintfExA(uint dwTraceID, uint dwFlags, const(PSTR) lpszFormat, byte* arglist);

@DllImport("rtutils.dll")
uint TracePutsExA(uint dwTraceID, uint dwFlags, const(PSTR) lpszString);

@DllImport("rtutils.dll")
uint TraceDumpExA(uint dwTraceID, uint dwFlags, ubyte* lpbBytes, uint dwByteCount, uint dwGroupSize, 
                  BOOL bAddressPrefix, const(PSTR) lpszPrefix);

@DllImport("rtutils.dll")
uint TraceRegisterExW(const(PWSTR) lpszCallerName, uint dwFlags);

@DllImport("rtutils.dll")
uint TraceDeregisterW(uint dwTraceID);

@DllImport("rtutils.dll")
uint TraceDeregisterExW(uint dwTraceID, uint dwFlags);

@DllImport("rtutils.dll")
uint TraceGetConsoleW(uint dwTraceID, HANDLE* lphConsole);

@DllImport("rtutils.dll")
uint TracePrintfW(uint dwTraceID, const(PWSTR) lpszFormat);

@DllImport("rtutils.dll")
uint TracePrintfExW(uint dwTraceID, uint dwFlags, const(PWSTR) lpszFormat);

@DllImport("rtutils.dll")
uint TraceVprintfExW(uint dwTraceID, uint dwFlags, const(PWSTR) lpszFormat, byte* arglist);

@DllImport("rtutils.dll")
uint TracePutsExW(uint dwTraceID, uint dwFlags, const(PWSTR) lpszString);

@DllImport("rtutils.dll")
uint TraceDumpExW(uint dwTraceID, uint dwFlags, ubyte* lpbBytes, uint dwByteCount, uint dwGroupSize, 
                  BOOL bAddressPrefix, const(PWSTR) lpszPrefix);

@DllImport("rtutils.dll")
void LogErrorA(uint dwMessageId, uint cNumberOfSubStrings, PSTR* plpwsSubStrings, uint dwErrorCode);

@DllImport("rtutils.dll")
void LogEventA(uint wEventType, uint dwMessageId, uint cNumberOfSubStrings, PSTR* plpwsSubStrings);

@DllImport("rtutils.dll")
void LogErrorW(uint dwMessageId, uint cNumberOfSubStrings, PWSTR* plpwsSubStrings, uint dwErrorCode);

@DllImport("rtutils.dll")
void LogEventW(uint wEventType, uint dwMessageId, uint cNumberOfSubStrings, PWSTR* plpwsSubStrings);

@DllImport("rtutils.dll")
HANDLE RouterLogRegisterA(const(PSTR) lpszSource);

@DllImport("rtutils.dll")
void RouterLogDeregisterA(HANDLE hLogHandle);

@DllImport("rtutils.dll")
void RouterLogEventA(HANDLE hLogHandle, uint dwEventType, uint dwMessageId, uint dwSubStringCount, 
                     PSTR* plpszSubStringArray, uint dwErrorCode);

@DllImport("rtutils.dll")
void RouterLogEventDataA(HANDLE hLogHandle, uint dwEventType, uint dwMessageId, uint dwSubStringCount, 
                         PSTR* plpszSubStringArray, uint dwDataBytes, ubyte* lpDataBytes);

@DllImport("rtutils.dll")
void RouterLogEventStringA(HANDLE hLogHandle, uint dwEventType, uint dwMessageId, uint dwSubStringCount, 
                           PSTR* plpszSubStringArray, uint dwErrorCode, uint dwErrorIndex);

@DllImport("rtutils.dll")
void RouterLogEventExA(HANDLE hLogHandle, uint dwEventType, uint dwErrorCode, uint dwMessageId, 
                       const(PSTR) ptszFormat);

@DllImport("rtutils.dll")
void RouterLogEventValistExA(HANDLE hLogHandle, uint dwEventType, uint dwErrorCode, uint dwMessageId, 
                             const(PSTR) ptszFormat, byte* arglist);

@DllImport("rtutils.dll")
uint RouterGetErrorStringA(uint dwErrorCode, PSTR* lplpszErrorString);

@DllImport("rtutils.dll")
HANDLE RouterLogRegisterW(const(PWSTR) lpszSource);

@DllImport("rtutils.dll")
void RouterLogDeregisterW(HANDLE hLogHandle);

@DllImport("rtutils.dll")
void RouterLogEventW(HANDLE hLogHandle, uint dwEventType, uint dwMessageId, uint dwSubStringCount, 
                     PWSTR* plpszSubStringArray, uint dwErrorCode);

@DllImport("rtutils.dll")
void RouterLogEventDataW(HANDLE hLogHandle, uint dwEventType, uint dwMessageId, uint dwSubStringCount, 
                         PWSTR* plpszSubStringArray, uint dwDataBytes, ubyte* lpDataBytes);

@DllImport("rtutils.dll")
void RouterLogEventStringW(HANDLE hLogHandle, uint dwEventType, uint dwMessageId, uint dwSubStringCount, 
                           PWSTR* plpszSubStringArray, uint dwErrorCode, uint dwErrorIndex);

@DllImport("rtutils.dll")
void RouterLogEventExW(HANDLE hLogHandle, uint dwEventType, uint dwErrorCode, uint dwMessageId, 
                       const(PWSTR) ptszFormat);

@DllImport("rtutils.dll")
void RouterLogEventValistExW(HANDLE hLogHandle, uint dwEventType, uint dwErrorCode, uint dwMessageId, 
                             const(PWSTR) ptszFormat, byte* arglist);

@DllImport("rtutils.dll")
uint RouterGetErrorStringW(uint dwErrorCode, PWSTR* lplpwszErrorString);

@DllImport("rtutils.dll")
void RouterAssert(PSTR pszFailedAssertion, PSTR pszFileName, uint dwLineNumber, PSTR pszMessage);

@DllImport("rtutils.dll")
uint MprSetupProtocolEnum(uint dwTransportId, ubyte** lplpBuffer, uint* lpdwEntriesRead);

@DllImport("rtutils.dll")
uint MprSetupProtocolFree(void* lpBuffer);


// Interfaces

@GUID("2aa2b5fe-b846-4d07-810c-b21ee45320e3")
struct NetProvisioning;

@GUID("c0e8ae90-306e-11d1-aacf-00805fc1270e")
interface IEnumNetCfgBindingInterface : IUnknown
{
    HRESULT Next(uint celt, INetCfgBindingInterface* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/IEnumNetCfgBindingInterface* ppenum);
}

@GUID("c0e8ae91-306e-11d1-aacf-00805fc1270e")
interface IEnumNetCfgBindingPath : IUnknown
{
    HRESULT Next(uint celt, INetCfgBindingPath* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/IEnumNetCfgBindingPath* ppenum);
}

@GUID("c0e8ae92-306e-11d1-aacf-00805fc1270e")
interface IEnumNetCfgComponent : IUnknown
{
    HRESULT Next(uint celt, INetCfgComponent* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/IEnumNetCfgComponent* ppenum);
}

@GUID("c0e8ae93-306e-11d1-aacf-00805fc1270e")
interface INetCfg : IUnknown
{
    HRESULT Initialize(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);
    HRESULT Uninitialize();
    HRESULT Apply();
    HRESULT Cancel();
    HRESULT EnumComponents(const(GUID)* pguidClass, IEnumNetCfgComponent* ppenumComponent);
    HRESULT FindComponent(const(PWSTR) pszwInfId, INetCfgComponent* pComponent);
    HRESULT QueryNetCfgClass(const(GUID)* pguidClass, const(GUID)* riid, void** ppvObject);
}

@GUID("c0e8ae9f-306e-11d1-aacf-00805fc1270e")
interface INetCfgLock : IUnknown
{
    HRESULT AcquireWriteLock(uint cmsTimeout, const(PWSTR) pszwClientDescription, PWSTR* ppszwClientDescription);
    HRESULT ReleaseWriteLock();
    HRESULT IsWriteLocked(PWSTR* ppszwClientDescription);
}

@GUID("c0e8ae94-306e-11d1-aacf-00805fc1270e")
interface INetCfgBindingInterface : IUnknown
{
    HRESULT GetName(PWSTR* ppszwInterfaceName);
    HRESULT GetUpperComponent(INetCfgComponent* ppnccItem);
    HRESULT GetLowerComponent(INetCfgComponent* ppnccItem);
}

@GUID("c0e8ae96-306e-11d1-aacf-00805fc1270e")
interface INetCfgBindingPath : IUnknown
{
    HRESULT IsSamePathAs(INetCfgBindingPath pPath);
    HRESULT IsSubPathOf(INetCfgBindingPath pPath);
    HRESULT IsEnabled();
    HRESULT Enable(BOOL fEnable);
    HRESULT GetPathToken(PWSTR* ppszwPathToken);
    HRESULT GetOwner(INetCfgComponent* ppComponent);
    HRESULT GetDepth(uint* pcInterfaces);
    HRESULT EnumBindingInterfaces(IEnumNetCfgBindingInterface* ppenumInterface);
}

@GUID("c0e8ae97-306e-11d1-aacf-00805fc1270e")
interface INetCfgClass : IUnknown
{
    HRESULT FindComponent(const(PWSTR) pszwInfId, INetCfgComponent* ppnccItem);
    HRESULT EnumComponents(IEnumNetCfgComponent* ppenumComponent);
}

@GUID("c0e8ae9d-306e-11d1-aacf-00805fc1270e")
interface INetCfgClassSetup : IUnknown
{
    HRESULT SelectAndInstall(HWND hwndParent, OBO_TOKEN* pOboToken, INetCfgComponent* ppnccItem);
    HRESULT Install(const(PWSTR) pszwInfId, OBO_TOKEN* pOboToken, uint dwSetupFlags, uint dwUpgradeFromBuildNo, 
                    const(PWSTR) pszwAnswerFile, const(PWSTR) pszwAnswerSections, INetCfgComponent* ppnccItem);
    HRESULT DeInstall(INetCfgComponent pComponent, OBO_TOKEN* pOboToken, PWSTR* pmszwRefs);
}

@GUID("c0e8aea0-306e-11d1-aacf-00805fc1270e")
interface INetCfgClassSetup2 : INetCfgClassSetup
{
    HRESULT UpdateNonEnumeratedComponent(INetCfgComponent pIComp, 
                                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwSetupFlags, 
                                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwUpgradeFromBuildNo);
}

@GUID("c0e8ae99-306e-11d1-aacf-00805fc1270e")
interface INetCfgComponent : IUnknown
{
    HRESULT GetDisplayName(PWSTR* ppszwDisplayName);
    HRESULT SetDisplayName(const(PWSTR) pszwDisplayName);
    HRESULT GetHelpText(PWSTR* pszwHelpText);
    HRESULT GetId(PWSTR* ppszwId);
    HRESULT GetCharacteristics(uint* pdwCharacteristics);
    HRESULT GetInstanceGuid(GUID* pGuid);
    HRESULT GetPnpDevNodeId(PWSTR* ppszwDevNodeId);
    HRESULT GetClassGuid(GUID* pGuid);
    HRESULT GetBindName(PWSTR* ppszwBindName);
    HRESULT GetDeviceStatus(uint* pulStatus);
    HRESULT OpenParamKey(HKEY* phkey);
    HRESULT RaisePropertyUi(HWND hwndParent, uint dwFlags, IUnknown punkContext);
}

@GUID("c0e8ae9e-306e-11d1-aacf-00805fc1270e")
interface INetCfgComponentBindings : IUnknown
{
    HRESULT BindTo(INetCfgComponent pnccItem);
    HRESULT UnbindFrom(INetCfgComponent pnccItem);
    HRESULT SupportsBindingInterface(uint dwFlags, const(PWSTR) pszwInterfaceName);
    HRESULT IsBoundTo(INetCfgComponent pnccItem);
    HRESULT IsBindableTo(INetCfgComponent pnccItem);
    HRESULT EnumBindingPaths(uint dwFlags, IEnumNetCfgBindingPath* ppIEnum);
    HRESULT MoveBefore(INetCfgBindingPath pncbItemSrc, INetCfgBindingPath pncbItemDest);
    HRESULT MoveAfter(INetCfgBindingPath pncbItemSrc, INetCfgBindingPath pncbItemDest);
}

@GUID("c0e8ae98-306e-11d1-aacf-00805fc1270e")
interface INetCfgSysPrep : IUnknown
{
    HRESULT HrSetupSetFirstDword(const(PWSTR) pwszSection, const(PWSTR) pwszKey, uint dwValue);
    HRESULT HrSetupSetFirstString(const(PWSTR) pwszSection, const(PWSTR) pwszKey, const(PWSTR) pwszValue);
    HRESULT HrSetupSetFirstStringAsBool(const(PWSTR) pwszSection, const(PWSTR) pwszKey, BOOL fValue);
    HRESULT HrSetupSetFirstMultiSzField(const(PWSTR) pwszSection, const(PWSTR) pwszKey, const(PWSTR) pmszValue);
}

@GUID("8d84bd35-e227-11d2-b700-00a0c98a6a85")
interface INetCfgPnpReconfigCallback : IUnknown
{
    HRESULT SendPnpReconfig(NCPNP_RECONFIG_LAYER Layer, const(PWSTR) pszwUpper, const(PWSTR) pszwLower, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvData, 
                            uint dwSizeOfData);
}

@GUID("932238df-bea1-11d0-9298-00c04fc99dcf")
interface INetCfgComponentControl : IUnknown
{
    HRESULT Initialize(INetCfgComponent pIComp, INetCfg pINetCfg, BOOL fInstalling);
    HRESULT ApplyRegistryChanges();
    HRESULT ApplyPnpChanges(INetCfgPnpReconfigCallback pICallback);
    HRESULT CancelChanges();
}

@GUID("932238e3-bea1-11d0-9298-00c04fc99dcf")
interface INetCfgComponentSetup : IUnknown
{
    HRESULT Install(uint dwSetupFlags);
    HRESULT Upgrade(uint dwSetupFlags, uint dwUpgradeFomBuildNo);
    HRESULT ReadAnswerFile(const(PWSTR) pszwAnswerFile, const(PWSTR) pszwAnswerSections);
    HRESULT Removing();
}

@GUID("932238e0-bea1-11d0-9298-00c04fc99dcf")
interface INetCfgComponentPropertyUi : IUnknown
{
    HRESULT QueryPropertyUi(IUnknown pUnkReserved);
    HRESULT SetContext(IUnknown pUnkReserved);
    HRESULT MergePropPages(uint* pdwDefPages, ubyte** pahpspPrivate, uint* pcPages, HWND hwndParent, 
                           const(PWSTR)* pszStartPage);
    HRESULT ValidateProperties(HWND hwndSheet);
    HRESULT ApplyProperties();
    HRESULT CancelProperties();
}

@GUID("932238e1-bea1-11d0-9298-00c04fc99dcf")
interface INetCfgComponentNotifyBinding : IUnknown
{
    HRESULT QueryBindingPath(uint dwChangeFlag, INetCfgBindingPath pIPath);
    HRESULT NotifyBindingPath(uint dwChangeFlag, INetCfgBindingPath pIPath);
}

@GUID("932238e2-bea1-11d0-9298-00c04fc99dcf")
interface INetCfgComponentNotifyGlobal : IUnknown
{
    HRESULT GetSupportedNotifications(uint* dwNotifications);
    HRESULT SysQueryBindingPath(uint dwChangeFlag, INetCfgBindingPath pIPath);
    HRESULT SysNotifyBindingPath(uint dwChangeFlag, INetCfgBindingPath pIPath);
    HRESULT SysNotifyComponent(uint dwChangeFlag, INetCfgComponent pIComp);
}

@GUID("932238e4-bea1-11d0-9298-00c04fc99dcf")
interface INetCfgComponentUpperEdge : IUnknown
{
    HRESULT GetInterfaceIdsForAdapter(INetCfgComponent pAdapter, uint* pdwNumInterfaces, GUID** ppguidInterfaceIds);
    HRESULT AddInterfacesToAdapter(INetCfgComponent pAdapter, uint dwNumInterfaces);
    HRESULT RemoveInterfacesFromAdapter(INetCfgComponent pAdapter, uint dwNumInterfaces, 
                                        const(GUID)* pguidInterfaceIds);
}

@GUID("c08956a6-1cd3-11d1-b1c5-00805fc1270e")
interface INetLanConnectionUiInfo : IUnknown
{
    HRESULT GetDeviceGuid(GUID* pguid);
}

@GUID("faedcf58-31fe-11d1-aad2-00805fc1270e")
interface INetRasConnectionIpUiInfo : IUnknown
{
    HRESULT GetUiInfo(RASCON_IPUI* pInfo);
}

@GUID("c0e8ae9a-306e-11d1-aacf-00805fc1270e")
interface INetCfgComponentSysPrep : IUnknown
{
    HRESULT SaveAdapterParameters(INetCfgSysPrep pncsp, const(PWSTR) pszwAnswerSections, 
                                  GUID* pAdapterInstanceGuid);
    HRESULT RestoreAdapterParameters(const(PWSTR) pszwAnswerFile, const(PWSTR) pszwAnswerSection, 
                                     GUID* pAdapterInstanceGuid);
}

@GUID("c96fbd50-24dd-11d8-89fb-00904b2ea9c6")
interface IProvisioningDomain : IUnknown
{
    HRESULT Add(const(PWSTR) pszwPathToFolder);
    HRESULT Query(const(PWSTR) pszwDomain, const(PWSTR) pszwLanguage, const(PWSTR) pszwXPathQuery, 
                  IXMLDOMNodeList* Nodes);
}

@GUID("c96fbd51-24dd-11d8-89fb-00904b2ea9c6")
interface IProvisioningProfileWireless : IUnknown
{
    HRESULT CreateProfile(BSTR bstrXMLWirelessConfigProfile, BSTR bstrXMLConnectionConfigProfile, 
                          GUID* pAdapterInstanceGuid, uint* pulStatus);
}


// GUIDs

const GUID CLSID_NetProvisioning = GUIDOF!NetProvisioning;

const GUID IID_IEnumNetCfgBindingInterface   = GUIDOF!IEnumNetCfgBindingInterface;
const GUID IID_IEnumNetCfgBindingPath        = GUIDOF!IEnumNetCfgBindingPath;
const GUID IID_IEnumNetCfgComponent          = GUIDOF!IEnumNetCfgComponent;
const GUID IID_INetCfg                       = GUIDOF!INetCfg;
const GUID IID_INetCfgBindingInterface       = GUIDOF!INetCfgBindingInterface;
const GUID IID_INetCfgBindingPath            = GUIDOF!INetCfgBindingPath;
const GUID IID_INetCfgClass                  = GUIDOF!INetCfgClass;
const GUID IID_INetCfgClassSetup             = GUIDOF!INetCfgClassSetup;
const GUID IID_INetCfgClassSetup2            = GUIDOF!INetCfgClassSetup2;
const GUID IID_INetCfgComponent              = GUIDOF!INetCfgComponent;
const GUID IID_INetCfgComponentBindings      = GUIDOF!INetCfgComponentBindings;
const GUID IID_INetCfgComponentControl       = GUIDOF!INetCfgComponentControl;
const GUID IID_INetCfgComponentNotifyBinding = GUIDOF!INetCfgComponentNotifyBinding;
const GUID IID_INetCfgComponentNotifyGlobal  = GUIDOF!INetCfgComponentNotifyGlobal;
const GUID IID_INetCfgComponentPropertyUi    = GUIDOF!INetCfgComponentPropertyUi;
const GUID IID_INetCfgComponentSetup         = GUIDOF!INetCfgComponentSetup;
const GUID IID_INetCfgComponentSysPrep       = GUIDOF!INetCfgComponentSysPrep;
const GUID IID_INetCfgComponentUpperEdge     = GUIDOF!INetCfgComponentUpperEdge;
const GUID IID_INetCfgLock                   = GUIDOF!INetCfgLock;
const GUID IID_INetCfgPnpReconfigCallback    = GUIDOF!INetCfgPnpReconfigCallback;
const GUID IID_INetCfgSysPrep                = GUIDOF!INetCfgSysPrep;
const GUID IID_INetLanConnectionUiInfo       = GUIDOF!INetLanConnectionUiInfo;
const GUID IID_INetRasConnectionIpUiInfo     = GUIDOF!INetRasConnectionIpUiInfo;
const GUID IID_IProvisioningDomain           = GUIDOF!IProvisioningDomain;
const GUID IID_IProvisioningProfileWireless  = GUIDOF!IProvisioningProfileWireless;
