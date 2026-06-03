// Written in the D programming language.

module windows.win32.security.credentials;

public import windows.core;
public import windows.win32.foundation : BOOL, FILETIME, HANDLE, HRESULT, HWND,
                                         NTSTATUS, PSTR, PWSTR, WIN32_ERROR;
public import windows.win32.graphics.gdi : HBITMAP;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums


alias CRED_FLAGS = uint;
enum : uint
{
    CRED_FLAGS_PASSWORD_FOR_CERT    = 0x00000001U,
    CRED_FLAGS_PROMPT_NOW           = 0x00000002U,
    CRED_FLAGS_USERNAME_TARGET      = 0x00000004U,
    CRED_FLAGS_OWF_CRED_BLOB        = 0x00000008U,
    CRED_FLAGS_REQUIRE_CONFIRMATION = 0x00000010U,
    CRED_FLAGS_WILDCARD_MATCH       = 0x00000020U,
    CRED_FLAGS_VSM_PROTECTED        = 0x00000040U,
    CRED_FLAGS_NGC_CERT             = 0x00000080U,
    CRED_FLAGS_VALID_FLAGS          = 0x0000f0ffU,
    CRED_FLAGS_VALID_INPUT_FLAGS    = 0x0000f09fU,
}

alias CRED_TYPE = uint;
enum : uint
{
    CRED_TYPE_GENERIC                 = 0x00000001U,
    CRED_TYPE_DOMAIN_PASSWORD         = 0x00000002U,
    CRED_TYPE_DOMAIN_CERTIFICATE      = 0x00000003U,
    CRED_TYPE_DOMAIN_VISIBLE_PASSWORD = 0x00000004U,
    CRED_TYPE_GENERIC_CERTIFICATE     = 0x00000005U,
    CRED_TYPE_DOMAIN_EXTENDED         = 0x00000006U,
    CRED_TYPE_MAXIMUM                 = 0x00000007U,
    CRED_TYPE_MAXIMUM_EX              = 0x000003efU,
}

alias CRED_PERSIST = uint;
enum : uint
{
    CRED_PERSIST_NONE          = 0x00000000U,
    CRED_PERSIST_SESSION       = 0x00000001U,
    CRED_PERSIST_LOCAL_MACHINE = 0x00000002U,
    CRED_PERSIST_ENTERPRISE    = 0x00000003U,
}

alias CREDUI_FLAGS = uint;
enum : uint
{
    CREDUI_FLAGS_ALWAYS_SHOW_UI              = 0x00000080U,
    CREDUI_FLAGS_COMPLETE_USERNAME           = 0x00000800U,
    CREDUI_FLAGS_DO_NOT_PERSIST              = 0x00000002U,
    CREDUI_FLAGS_EXCLUDE_CERTIFICATES        = 0x00000008U,
    CREDUI_FLAGS_EXPECT_CONFIRMATION         = 0x00020000U,
    CREDUI_FLAGS_GENERIC_CREDENTIALS         = 0x00040000U,
    CREDUI_FLAGS_INCORRECT_PASSWORD          = 0x00000001U,
    CREDUI_FLAGS_KEEP_USERNAME               = 0x00100000U,
    CREDUI_FLAGS_PASSWORD_ONLY_OK            = 0x00000200U,
    CREDUI_FLAGS_PERSIST                     = 0x00001000U,
    CREDUI_FLAGS_REQUEST_ADMINISTRATOR       = 0x00000004U,
    CREDUI_FLAGS_REQUIRE_CERTIFICATE         = 0x00000010U,
    CREDUI_FLAGS_REQUIRE_SMARTCARD           = 0x00000100U,
    CREDUI_FLAGS_SERVER_CREDENTIAL           = 0x00004000U,
    CREDUI_FLAGS_SHOW_SAVE_CHECK_BOX         = 0x00000040U,
    CREDUI_FLAGS_USERNAME_TARGET_CREDENTIALS = 0x00080000U,
    CREDUI_FLAGS_VALIDATE_USERNAME           = 0x00000400U,
}

alias SCARD_SCOPE = uint;
enum : uint
{
    SCARD_SCOPE_USER   = 0x00000000U,
    SCARD_SCOPE_SYSTEM = 0x00000002U,
}

alias CRED_ENUMERATE_FLAGS = uint;
enum : uint
{
    CRED_ENUMERATE_ALL_CREDENTIALS = 0x00000001U,
}

alias CREDUIWIN_FLAGS = uint;
enum : uint
{
    CREDUIWIN_GENERIC                = 0x00000001U,
    CREDUIWIN_CHECKBOX               = 0x00000002U,
    CREDUIWIN_AUTHPACKAGE_ONLY       = 0x00000010U,
    CREDUIWIN_IN_CRED_ONLY           = 0x00000020U,
    CREDUIWIN_ENUMERATE_ADMINS       = 0x00000100U,
    CREDUIWIN_ENUMERATE_CURRENT_USER = 0x00000200U,
    CREDUIWIN_SECURE_PROMPT          = 0x00001000U,
    CREDUIWIN_PREPROMPTING           = 0x00002000U,
    CREDUIWIN_PACK_32_WOW            = 0x10000000U,
}

alias SCARD_STATE = uint;
enum : uint
{
    SCARD_STATE_UNAWARE     = 0x00000000U,
    SCARD_STATE_IGNORE      = 0x00000001U,
    SCARD_STATE_UNAVAILABLE = 0x00000008U,
    SCARD_STATE_EMPTY       = 0x00000010U,
    SCARD_STATE_PRESENT     = 0x00000020U,
    SCARD_STATE_ATRMATCH    = 0x00000040U,
    SCARD_STATE_EXCLUSIVE   = 0x00000080U,
    SCARD_STATE_INUSE       = 0x00000100U,
    SCARD_STATE_MUTE        = 0x00000200U,
    SCARD_STATE_CHANGED     = 0x00000002U,
    SCARD_STATE_UNKNOWN     = 0x00000004U,
}

alias CRED_PACK_FLAGS = uint;
enum : uint
{
    CRED_PACK_PROTECTED_CREDENTIALS   = 0x00000001U,
    CRED_PACK_WOW_BUFFER              = 0x00000002U,
    CRED_PACK_GENERIC_CREDENTIALS     = 0x00000004U,
    CRED_PACK_ID_PROVIDER_CREDENTIALS = 0x00000008U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/keycredmgr/ne-keycredmgr-keycredentialmanageroperationerrorstates
enum KeyCredentialManagerOperationErrorStates : int
{
    KeyCredentialManagerOperationErrorStateNone                 = 0x00000000,
    KeyCredentialManagerOperationErrorStateDeviceJoinFailure    = 0x00000001,
    KeyCredentialManagerOperationErrorStateTokenFailure         = 0x00000002,
    KeyCredentialManagerOperationErrorStateCertificateFailure   = 0x00000004,
    KeyCredentialManagerOperationErrorStateRemoteSessionFailure = 0x00000008,
    KeyCredentialManagerOperationErrorStatePolicyFailure        = 0x00000010,
    KeyCredentialManagerOperationErrorStateHardwareFailure      = 0x00000020,
    KeyCredentialManagerOperationErrorStatePinExistsFailure     = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/keycredmgr/ne-keycredmgr-keycredentialmanageroperationtype
enum KeyCredentialManagerOperationType : int
{
    KeyCredentialManagerProvisioning = 0x00000000,
    KeyCredentialManagerPinChange    = 0x00000001,
    KeyCredentialManagerPinReset     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ne-wincred-cred_marshal_type
alias CRED_MARSHAL_TYPE = int;
enum : int
{
    CertCredential               = 0x00000001,
    UsernameTargetCredential     = 0x00000002,
    BinaryBlobCredential         = 0x00000003,
    UsernameForPackedCredentials = 0x00000004,
    BinaryBlobForSystem          = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ne-wincred-cred_protection_type
alias CRED_PROTECTION_TYPE = int;
enum : int
{
    CredUnprotected         = 0x00000000,
    CredUserProtection      = 0x00000001,
    CredTrustedProtection   = 0x00000002,
    CredForSystemProtection = 0x00000003,
}

alias READER_SEL_REQUEST_MATCH_TYPE = int;
enum : int
{
    RSR_MATCH_TYPE_READER_AND_CONTAINER = 0x00000001,
    RSR_MATCH_TYPE_SERIAL_NUMBER        = 0x00000002,
    RSR_MATCH_TYPE_ALL_CARDS            = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credssp/ne-credssp-credspp_submit_type
alias CREDSPP_SUBMIT_TYPE = int;
enum : int
{
    CredsspPasswordCreds       = 0x00000002,
    CredsspSchannelCreds       = 0x00000004,
    CredsspCertificateCreds    = 0x0000000d,
    CredsspSubmitBufferBoth    = 0x00000032,
    CredsspSubmitBufferBothOld = 0x00000033,
    CredsspCredEx              = 0x00000064,
}

// Constants


enum uint CRED_MAX_CREDENTIAL_BLOB_SIZE = 0x00000a00U;
enum uint CRED_MAX_USERNAME_LENGTH = 0x00000201U;
enum uint CRED_MAX_DOMAIN_TARGET_NAME_LENGTH = 0x00000151U;
enum uint FILE_DEVICE_SMARTCARD = 0x00000031U;
enum GUID GUID_DEVINTERFACE_SMARTCARD_READER = GUID("50dd5230-ba8a-11d1-bf5d-0000f805f530");
enum uint SCARD_ATR_LENGTH = 0x00000021U;

enum : uint
{
    SCARD_PROTOCOL_UNDEFINED = 0x00000000U,
    SCARD_PROTOCOL_T0        = 0x00000001U,
    SCARD_PROTOCOL_T1        = 0x00000002U,
    SCARD_PROTOCOL_RAW       = 0x00010000U,
    SCARD_PROTOCOL_DEFAULT   = 0x80000000U,
    SCARD_PROTOCOL_OPTIMAL   = 0x00000000U,
}

enum uint SCARD_POWER_DOWN = 0x00000000U;
enum uint SCARD_COLD_RESET = 0x00000001U;
enum uint SCARD_WARM_RESET = 0x00000002U;
enum uint MAXIMUM_ATTR_STRING_LENGTH = 0x00000020U;
enum uint MAXIMUM_SMARTCARD_READERS = 0x0000000aU;

enum : uint
{
    SCARD_CLASS_VENDOR_INFO    = 0x00000001U,
    SCARD_CLASS_COMMUNICATIONS = 0x00000002U,
    SCARD_CLASS_PROTOCOL       = 0x00000003U,
    SCARD_CLASS_POWER_MGMT     = 0x00000004U,
    SCARD_CLASS_SECURITY       = 0x00000005U,
    SCARD_CLASS_MECHANICAL     = 0x00000006U,
    SCARD_CLASS_VENDOR_DEFINED = 0x00000007U,
    SCARD_CLASS_IFD_PROTOCOL   = 0x00000008U,
    SCARD_CLASS_ICC_STATE      = 0x00000009U,
    SCARD_CLASS_PERF           = 0x00007ffeU,
    SCARD_CLASS_SYSTEM         = 0x00007fffU,
}

enum : uint
{
    SCARD_T0_HEADER_LENGTH = 0x00000007U,
    SCARD_T0_CMD_LENGTH    = 0x00000005U,
}

enum uint SCARD_T1_PROLOGUE_LENGTH = 0x00000003U;

enum : uint
{
    SCARD_T1_EPILOGUE_LENGTH     = 0x00000002U,
    SCARD_T1_EPILOGUE_LENGTH_LRC = 0x00000001U,
}

enum uint SCARD_T1_MAX_IFS = 0x000000feU;

enum : uint
{
    SCARD_UNKNOWN   = 0x00000000U,
    SCARD_ABSENT    = 0x00000001U,
    SCARD_PRESENT   = 0x00000002U,
    SCARD_SWALLOWED = 0x00000003U,
}

enum : uint
{
    SCARD_POWERED    = 0x00000004U,
    SCARD_NEGOTIABLE = 0x00000005U,
}

enum : uint
{
    SCARD_SPECIFIC               = 0x00000006U,
    SCARD_READER_SWALLOWS        = 0x00000001U,
    SCARD_READER_EJECTS          = 0x00000002U,
    SCARD_READER_CONFISCATES     = 0x00000004U,
    SCARD_READER_CONTACTLESS     = 0x00000008U,
    SCARD_READER_TYPE_SERIAL     = 0x00000001U,
    SCARD_READER_TYPE_PARALELL   = 0x00000002U,
    SCARD_READER_TYPE_KEYBOARD   = 0x00000004U,
    SCARD_READER_TYPE_SCSI       = 0x00000008U,
    SCARD_READER_TYPE_IDE        = 0x00000010U,
    SCARD_READER_TYPE_USB        = 0x00000020U,
    SCARD_READER_TYPE_PCMCIA     = 0x00000040U,
    SCARD_READER_TYPE_TPM        = 0x00000080U,
    SCARD_READER_TYPE_NFC        = 0x00000100U,
    SCARD_READER_TYPE_UICC       = 0x00000200U,
    SCARD_READER_TYPE_NGC        = 0x00000400U,
    SCARD_READER_TYPE_EMBEDDEDSE = 0x00000800U,
    SCARD_READER_TYPE_VENDOR     = 0x000000f0U,
}

enum NTSTATUS STATUS_LOGON_FAILURE = NTSTATUS(0xc000006d);
enum NTSTATUS STATUS_WRONG_PASSWORD = NTSTATUS(0xc000006a);

enum : NTSTATUS
{
    STATUS_PASSWORD_EXPIRED     = NTSTATUS(0xc0000071),
    STATUS_PASSWORD_MUST_CHANGE = NTSTATUS(0xc0000224),
}

enum NTSTATUS STATUS_DOWNGRADE_DETECTED = NTSTATUS(0xc0000388);
enum NTSTATUS STATUS_AUTHENTICATION_FIREWALL_FAILED = NTSTATUS(0xc0000413);

enum : NTSTATUS
{
    STATUS_ACCOUNT_DISABLED    = NTSTATUS(0xc0000072),
    STATUS_ACCOUNT_RESTRICTION = NTSTATUS(0xc000006e),
    STATUS_ACCOUNT_LOCKED_OUT  = NTSTATUS(0xc0000234),
    STATUS_ACCOUNT_EXPIRED     = NTSTATUS(0xc0000193),
}

enum NTSTATUS STATUS_LOGON_TYPE_NOT_GRANTED = NTSTATUS(0xc000015b);

enum : NTSTATUS
{
    STATUS_NO_SUCH_LOGON_SESSION = NTSTATUS(0xc000005f),
    STATUS_NO_SUCH_USER          = NTSTATUS(0xc0000064),
}

enum : uint
{
    CRED_MAX_STRING_LENGTH              = 0x00000100U,
    CRED_MAX_GENERIC_TARGET_NAME_LENGTH = 0x00007fffU,
}

enum : uint
{
    CRED_MAX_TARGETNAME_NAMESPACE_LENGTH = 0x00000100U,
    CRED_MAX_TARGETNAME_ATTRIBUTE_LENGTH = 0x00000100U,
}

enum : uint
{
    CRED_MAX_VALUE_SIZE = 0x00000100U,
    CRED_MAX_ATTRIBUTES = 0x00000040U,
}

enum : const(wchar)*
{
    CRED_SESSION_WILDCARD_NAME_W = "*Session",
    // Native encoding: ansi
    CRED_SESSION_WILDCARD_NAME_A = "*Session",
}

enum : const(wchar)*
{
    CRED_TARGETNAME_DOMAIN_NAMESPACE_W        = "Domain",
    // Native encoding: ansi
    CRED_TARGETNAME_DOMAIN_NAMESPACE_A        = "Domain",
    CRED_TARGETNAME_LEGACYGENERIC_NAMESPACE_W = "LegacyGeneric",
    // Native encoding: ansi
    CRED_TARGETNAME_LEGACYGENERIC_NAMESPACE_A = "LegacyGeneric",
}

enum : const(wchar)*
{
    CRED_TARGETNAME_ATTRIBUTE_TARGET_W            = "target",
    // Native encoding: ansi
    CRED_TARGETNAME_ATTRIBUTE_TARGET_A            = "target",
    CRED_TARGETNAME_ATTRIBUTE_NAME_W              = "name",
    // Native encoding: ansi
    CRED_TARGETNAME_ATTRIBUTE_NAME_A              = "name",
    CRED_TARGETNAME_ATTRIBUTE_BATCH_W             = "batch",
    // Native encoding: ansi
    CRED_TARGETNAME_ATTRIBUTE_BATCH_A             = "batch",
    CRED_TARGETNAME_ATTRIBUTE_INTERACTIVE_W       = "interactive",
    // Native encoding: ansi
    CRED_TARGETNAME_ATTRIBUTE_INTERACTIVE_A       = "interactive",
    CRED_TARGETNAME_ATTRIBUTE_SERVICE_W           = "service",
    // Native encoding: ansi
    CRED_TARGETNAME_ATTRIBUTE_SERVICE_A           = "service",
    CRED_TARGETNAME_ATTRIBUTE_NETWORK_W           = "network",
    // Native encoding: ansi
    CRED_TARGETNAME_ATTRIBUTE_NETWORK_A           = "network",
    CRED_TARGETNAME_ATTRIBUTE_NETWORKCLEARTEXT_W  = "networkcleartext",
    // Native encoding: ansi
    CRED_TARGETNAME_ATTRIBUTE_NETWORKCLEARTEXT_A  = "networkcleartext",
    CRED_TARGETNAME_ATTRIBUTE_REMOTEINTERACTIVE_W = "remoteinteractive",
    // Native encoding: ansi
    CRED_TARGETNAME_ATTRIBUTE_REMOTEINTERACTIVE_A = "remoteinteractive",
    CRED_TARGETNAME_ATTRIBUTE_CACHEDINTERACTIVE_W = "cachedinteractive",
    // Native encoding: ansi
    CRED_TARGETNAME_ATTRIBUTE_CACHEDINTERACTIVE_A = "cachedinteractive",
}

enum const(wchar)* CRED_SESSION_WILDCARD_NAME = "*Session";

enum : const(wchar)*
{
    CRED_TARGETNAME_DOMAIN_NAMESPACE            = "Domain",
    CRED_TARGETNAME_ATTRIBUTE_NAME              = "name",
    CRED_TARGETNAME_ATTRIBUTE_TARGET            = "target",
    CRED_TARGETNAME_ATTRIBUTE_BATCH             = "batch",
    CRED_TARGETNAME_ATTRIBUTE_INTERACTIVE       = "interactive",
    CRED_TARGETNAME_ATTRIBUTE_SERVICE           = "service",
    CRED_TARGETNAME_ATTRIBUTE_NETWORK           = "network",
    CRED_TARGETNAME_ATTRIBUTE_NETWORKCLEARTEXT  = "networkcleartext",
    CRED_TARGETNAME_ATTRIBUTE_REMOTEINTERACTIVE = "remoteinteractive",
    CRED_TARGETNAME_ATTRIBUTE_CACHEDINTERACTIVE = "cachedinteractive",
}

enum uint CRED_LOGON_TYPES_MASK = 0x0000f000U;
enum uint CRED_TI_SERVER_FORMAT_UNKNOWN = 0x00000001U;
enum uint CRED_TI_DOMAIN_FORMAT_UNKNOWN = 0x00000002U;
enum uint CRED_TI_ONLY_PASSWORD_REQUIRED = 0x00000004U;
enum uint CRED_TI_USERNAME_TARGET = 0x00000008U;
enum uint CRED_TI_CREATE_EXPLICIT_CRED = 0x00000010U;
enum uint CRED_TI_WORKGROUP_MEMBER = 0x00000020U;
enum uint CRED_TI_DNSTREE_IS_DFS_SERVER = 0x00000040U;
enum uint CRED_TI_VALID_FLAGS = 0x0000f07fU;
enum uint CERT_HASH_LENGTH = 0x00000014U;

enum : uint
{
    CREDUI_MAX_MESSAGE_LENGTH        = 0x00000400U,
    CREDUI_MAX_CAPTION_LENGTH        = 0x00000080U,
    CREDUI_MAX_GENERIC_TARGET_LENGTH = 0x00007fffU,
}

enum uint CREDUI_MAX_DOMAIN_TARGET_LENGTH = 0x00000151U;
enum uint CREDUI_MAX_USERNAME_LENGTH = 0x00000201U;

enum : uint
{
    CREDUIWIN_USE_V2                     = 0x00000040U,
    CREDUIWIN_IGNORE_CLOUDAUTHORITY_NAME = 0x00040000U,
}

enum uint CREDUIWIN_DOWNLEVEL_HELLO_AS_SMART_CARD = 0x80000000U;
enum uint BACK_BUTTON_IDENTIFY_AUTH_PACKAGE = 0xcad00001U;
enum uint CREDUI_FOOTER_LINK_AUTHPACKAGE_ID = 0x0cad0002U;
enum uint CREDUI_PICKERSCREEN_AUTHPACKAGE_ID = 0x0cad0003U;
enum uint CRED_PRESERVE_CREDENTIAL_BLOB = 0x00000001U;
enum uint CRED_CACHE_TARGET_INFORMATION = 0x00000001U;
enum uint CRED_ALLOW_NAME_RESOLUTION = 0x00000001U;

enum : uint
{
    CRED_PROTECT_AS_SELF   = 0x00000001U,
    CRED_PROTECT_TO_SYSTEM = 0x00000002U,
}

enum : uint
{
    CRED_UNPROTECT_AS_SELF         = 0x00000001U,
    CRED_UNPROTECT_ALLOW_TO_SYSTEM = 0x00000002U,
}

enum uint SCARD_SCOPE_TERMINAL = 0x00000001U;
enum const(wchar)* SCARD_ALL_READERS = "SCard$AllReaders\000";
enum const(wchar)* SCARD_DEFAULT_READERS = "SCard$DefaultReaders\000";
enum const(wchar)* SCARD_LOCAL_READERS = "SCard$LocalReaders\000";
enum const(wchar)* SCARD_SYSTEM_READERS = "SCard$SystemReaders\000";

enum : uint
{
    SCARD_PROVIDER_PRIMARY = 0x00000001U,
    SCARD_PROVIDER_CSP     = 0x00000002U,
    SCARD_PROVIDER_KSP     = 0x00000003U,
}

enum uint SCARD_STATE_UNPOWERED = 0x00000400U;

enum : uint
{
    SCARD_SHARE_EXCLUSIVE = 0x00000001U,
    SCARD_SHARE_SHARED    = 0x00000002U,
    SCARD_SHARE_DIRECT    = 0x00000003U,
}

enum uint SCARD_LEAVE_CARD = 0x00000000U;
enum uint SCARD_RESET_CARD = 0x00000001U;
enum uint SCARD_UNPOWER_CARD = 0x00000002U;
enum uint SCARD_EJECT_CARD = 0x00000003U;

enum : uint
{
    SC_DLG_MINIMAL_UI = 0x00000001U,
    SC_DLG_NO_UI      = 0x00000002U,
    SC_DLG_FORCE_UI   = 0x00000004U,
}

enum : uint
{
    SCERR_NOCARDNAME = 0x00004000U,
    SCERR_NOGUIDS    = 0x00008000U,
}

enum : uint
{
    SCARD_AUDIT_CHV_FAILURE = 0x00000000U,
    SCARD_AUDIT_CHV_SUCCESS = 0x00000001U,
}

enum const(wchar)* CREDSSP_NAME = "CREDSSP";

enum : const(wchar)*
{
    // Native encoding: ansi
    TS_SSP_NAME_A = "TSSSP",
    TS_SSP_NAME   = "TSSSP",
}

// Native encoding: ansi
enum const(wchar)* szOID_TS_KP_TS_SERVER_AUTH = "1.3.6.1.4.1.311.54.1.2";

enum : uint
{
    CREDSSP_SERVER_AUTH_NEGOTIATE   = 0x00000001U,
    CREDSSP_SERVER_AUTH_CERTIFICATE = 0x00000002U,
    CREDSSP_SERVER_AUTH_LOOPBACK    = 0x00000004U,
}

enum : uint
{
    SECPKG_ALT_ATTR                = 0x80000000U,
    SECPKG_ATTR_C_FULL_IDENT_TOKEN = 0x80000085U,
}

enum uint CREDSSP_CRED_EX_VERSION = 0x00000000U;
enum uint CREDSSP_FLAG_REDIRECT = 0x00000001U;

// Callbacks

alias LPOCNCONNPROCA = size_t function(size_t param0, PSTR param1, PSTR param2, void* param3);
alias LPOCNCONNPROCW = size_t function(size_t param0, PWSTR param1, PWSTR param2, void* param3);
alias LPOCNCHKPROC = BOOL function(size_t param0, size_t param1, void* param2);
alias LPOCNDSCPROC = void function(size_t param0, size_t param1, void* param2);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/keycredmgr/ns-keycredmgr-keycredentialmanagerinfo
struct KeyCredentialManagerInfo
{
    GUID containerId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sechandle
struct SecHandle
{
    size_t dwLower;
    size_t dwUpper;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ns-wincred-credential_attributea
struct CREDENTIAL_ATTRIBUTEA
{
    PSTR   Keyword;
    uint   Flags;
    uint   ValueSize;
    ubyte* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ns-wincred-credential_attributew
struct CREDENTIAL_ATTRIBUTEW
{
    PWSTR  Keyword;
    uint   Flags;
    uint   ValueSize;
    ubyte* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ns-wincred-credentiala
struct CREDENTIALA
{
    CRED_FLAGS   Flags;
    CRED_TYPE    Type;
    PSTR         TargetName;
    PSTR         Comment;
    FILETIME     LastWritten;
    uint         CredentialBlobSize;
    ubyte*       CredentialBlob;
    CRED_PERSIST Persist;
    uint         AttributeCount;
    CREDENTIAL_ATTRIBUTEA* Attributes;
    PSTR         TargetAlias;
    PSTR         UserName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ns-wincred-credentialw
struct CREDENTIALW
{
    CRED_FLAGS   Flags;
    CRED_TYPE    Type;
    PWSTR        TargetName;
    PWSTR        Comment;
    FILETIME     LastWritten;
    uint         CredentialBlobSize;
    ubyte*       CredentialBlob;
    CRED_PERSIST Persist;
    uint         AttributeCount;
    CREDENTIAL_ATTRIBUTEW* Attributes;
    PWSTR        TargetAlias;
    PWSTR        UserName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ns-wincred-credential_target_informationa
struct CREDENTIAL_TARGET_INFORMATIONA
{
    PSTR  TargetName;
    PSTR  NetbiosServerName;
    PSTR  DnsServerName;
    PSTR  NetbiosDomainName;
    PSTR  DnsDomainName;
    PSTR  DnsTreeName;
    PSTR  PackageName;
    uint  Flags;
    uint  CredTypeCount;
    uint* CredTypes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ns-wincred-credential_target_informationw
struct CREDENTIAL_TARGET_INFORMATIONW
{
    PWSTR TargetName;
    PWSTR NetbiosServerName;
    PWSTR DnsServerName;
    PWSTR NetbiosDomainName;
    PWSTR DnsDomainName;
    PWSTR DnsTreeName;
    PWSTR PackageName;
    uint  Flags;
    uint  CredTypeCount;
    uint* CredTypes;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ns-wincred-cert_credential_info
struct CERT_CREDENTIAL_INFO
{
    uint      cbSize;
    ubyte[20] rgbHashOfCert;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ns-wincred-username_target_credential_info
struct USERNAME_TARGET_CREDENTIAL_INFO
{
    PWSTR UserName;
}

struct BINARY_BLOB_CREDENTIAL_INFO
{
    uint   cbBlob;
    ubyte* pbBlob;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ns-wincred-credui_infoa
struct CREDUI_INFOA
{
    uint        cbSize;
    HWND        hwndParent;
    const(PSTR) pszMessageText;
    const(PSTR) pszCaptionText;
    HBITMAP     hbmBanner;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincred/ns-wincred-credui_infow
struct CREDUI_INFOW
{
    uint         cbSize;
    HWND         hwndParent;
    const(PWSTR) pszMessageText;
    const(PWSTR) pszCaptionText;
    HBITMAP      hbmBanner;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecAuthN/scard-io-request
struct SCARD_IO_REQUEST
{
    uint dwProtocol;
    uint cbPciLength;
}

struct SCARD_T0_COMMAND
{
    ubyte bCla;
    ubyte bIns;
    ubyte bP1;
    ubyte bP2;
    ubyte bP3;
}

struct SCARD_T0_REQUEST
{
    SCARD_IO_REQUEST ioRequest;
    ubyte            bSw1;
    ubyte            bSw2;
    union
    {
        SCARD_T0_COMMAND CmdBytes;
        ubyte[5]         rgbHeader;
    }
}

struct SCARD_T1_REQUEST
{
    SCARD_IO_REQUEST ioRequest;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winscard/ns-winscard-scard_readerstatea
struct SCARD_READERSTATEA
{
    const(PSTR) szReader;
    void*       pvUserData;
    SCARD_STATE dwCurrentState;
    SCARD_STATE dwEventState;
    uint        cbAtr;
    ubyte[36]   rgbAtr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winscard/ns-winscard-scard_readerstatew
struct SCARD_READERSTATEW
{
    const(PWSTR) szReader;
    void*        pvUserData;
    SCARD_STATE  dwCurrentState;
    SCARD_STATE  dwEventState;
    uint         cbAtr;
    ubyte[36]    rgbAtr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winscard/ns-winscard-scard_atrmask
struct SCARD_ATRMASK
{
    uint      cbAtr;
    ubyte[36] rgbAtr;
    ubyte[36] rgbMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winscard/ns-winscard-opencard_search_criteriaa
struct OPENCARD_SEARCH_CRITERIAA
{
    uint           dwStructSize;
    PSTR           lpstrGroupNames;
    uint           nMaxGroupNames;
    const(GUID)*   rgguidInterfaces;
    uint           cguidInterfaces;
    PSTR           lpstrCardNames;
    uint           nMaxCardNames;
    LPOCNCHKPROC   lpfnCheck;
    LPOCNCONNPROCA lpfnConnect;
    LPOCNDSCPROC   lpfnDisconnect;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winscard/ns-winscard-opencard_search_criteriaw
struct OPENCARD_SEARCH_CRITERIAW
{
    uint           dwStructSize;
    PWSTR          lpstrGroupNames;
    uint           nMaxGroupNames;
    const(GUID)*   rgguidInterfaces;
    uint           cguidInterfaces;
    PWSTR          lpstrCardNames;
    uint           nMaxCardNames;
    LPOCNCHKPROC   lpfnCheck;
    LPOCNCONNPROCW lpfnConnect;
    LPOCNDSCPROC   lpfnDisconnect;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winscard/ns-winscard-opencardname_exa
struct OPENCARDNAME_EXA
{
    uint           dwStructSize;
    size_t         hSCardContext;
    HWND           hwndOwner;
    uint           dwFlags;
    const(PSTR)    lpstrTitle;
    const(PSTR)    lpstrSearchDesc;
    HICON          hIcon;
    OPENCARD_SEARCH_CRITERIAA* pOpenCardSearchCriteria;
    LPOCNCONNPROCA lpfnConnect;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
    PSTR           lpstrRdr;
    uint           nMaxRdr;
    PSTR           lpstrCard;
    uint           nMaxCard;
    uint           dwActiveProtocol;
    size_t         hCardHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winscard/ns-winscard-opencardname_exw
struct OPENCARDNAME_EXW
{
    uint           dwStructSize;
    size_t         hSCardContext;
    HWND           hwndOwner;
    uint           dwFlags;
    const(PWSTR)   lpstrTitle;
    const(PWSTR)   lpstrSearchDesc;
    HICON          hIcon;
    OPENCARD_SEARCH_CRITERIAW* pOpenCardSearchCriteria;
    LPOCNCONNPROCW lpfnConnect;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
    PWSTR          lpstrRdr;
    uint           nMaxRdr;
    PWSTR          lpstrCard;
    uint           nMaxCard;
    uint           dwActiveProtocol;
    size_t         hCardHandle;
}

struct READER_SEL_REQUEST
{
    uint dwShareMode;
    uint dwPreferredProtocols;
    READER_SEL_REQUEST_MATCH_TYPE MatchType;
    union
    {
        struct ReaderAndContainerParameter
        {
            uint cbReaderNameOffset;
            uint cchReaderNameLength;
            uint cbContainerNameOffset;
            uint cchContainerNameLength;
            uint dwDesiredCardModuleVersion;
            uint dwCspFlags;
        }
        struct SerialNumberParameter
        {
            uint cbSerialNumberOffset;
            uint cbSerialNumberLength;
            uint dwDesiredCardModuleVersion;
        }
    }
}

struct READER_SEL_RESPONSE
{
    uint cbReaderNameOffset;
    uint cchReaderNameLength;
    uint cbCardNameOffset;
    uint cchCardNameLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winscard/ns-winscard-opencardnamea
struct OPENCARDNAMEA
{
    uint           dwStructSize;
    HWND           hwndOwner;
    size_t         hSCardContext;
    PSTR           lpstrGroupNames;
    uint           nMaxGroupNames;
    PSTR           lpstrCardNames;
    uint           nMaxCardNames;
    const(GUID)*   rgguidInterfaces;
    uint           cguidInterfaces;
    PSTR           lpstrRdr;
    uint           nMaxRdr;
    PSTR           lpstrCard;
    uint           nMaxCard;
    const(PSTR)    lpstrTitle;
    uint           dwFlags;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
    uint           dwActiveProtocol;
    LPOCNCONNPROCA lpfnConnect;
    LPOCNCHKPROC   lpfnCheck;
    LPOCNDSCPROC   lpfnDisconnect;
    size_t         hCardHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winscard/ns-winscard-opencardnamew
struct OPENCARDNAMEW
{
    uint           dwStructSize;
    HWND           hwndOwner;
    size_t         hSCardContext;
    PWSTR          lpstrGroupNames;
    uint           nMaxGroupNames;
    PWSTR          lpstrCardNames;
    uint           nMaxCardNames;
    const(GUID)*   rgguidInterfaces;
    uint           cguidInterfaces;
    PWSTR          lpstrRdr;
    uint           nMaxRdr;
    PWSTR          lpstrCard;
    uint           nMaxCard;
    const(PWSTR)   lpstrTitle;
    uint           dwFlags;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
    uint           dwActiveProtocol;
    LPOCNCONNPROCW lpfnConnect;
    LPOCNCHKPROC   lpfnCheck;
    LPOCNDSCPROC   lpfnDisconnect;
    size_t         hCardHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credssp/ns-credssp-secpkgcontext_clientcreds
struct SecPkgContext_ClientCreds
{
    uint   AuthBufferLen;
    ubyte* AuthBuffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credssp/ns-credssp-credssp_cred
struct CREDSSP_CRED
{
    CREDSPP_SUBMIT_TYPE Type;
    void*               pSchannelCred;
    void*               pSpnegoCred;
}

struct CREDSSP_CRED_EX
{
    CREDSPP_SUBMIT_TYPE Type;
    uint                Version;
    uint                Flags;
    uint                Reserved;
    CREDSSP_CRED        Cred;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/keycredmgr/nf-keycredmgr-keycredentialmanagergetoperationerrorstates
@DllImport("KeyCredMgr.dll")
HRESULT KeyCredentialManagerGetOperationErrorStates(KeyCredentialManagerOperationType keyCredentialManagerOperationType, 
                                                    BOOL* isReady, 
                                                    KeyCredentialManagerOperationErrorStates* keyCredentialManagerOperationErrorStates);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/keycredmgr/nf-keycredmgr-keycredentialmanagershowuioperation
@DllImport("KeyCredMgr.dll")
HRESULT KeyCredentialManagerShowUIOperation(HWND hWndOwner, 
                                            KeyCredentialManagerOperationType keyCredentialManagerOperationType);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/keycredmgr/nf-keycredmgr-keycredentialmanagergetinformation
@DllImport("KeyCredMgr.dll")
HRESULT KeyCredentialManagerGetInformation(KeyCredentialManagerInfo** keyCredentialManagerInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/keycredmgr/nf-keycredmgr-keycredentialmanagerfreeinformation
@DllImport("KeyCredMgr.dll")
void KeyCredentialManagerFreeInformation(KeyCredentialManagerInfo* keyCredentialManagerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredWriteW(CREDENTIALW* Credential, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredWriteA(CREDENTIALA* Credential, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredReadW(const(PWSTR) TargetName, CRED_TYPE Type, 
               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags, CREDENTIALW** Credential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredReadA(const(PSTR) TargetName, CRED_TYPE Type, 
               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags, CREDENTIALA** Credential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredEnumerateW(const(PWSTR) Filter, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/CRED_ENUMERATE_FLAGS Flags, 
                    uint* Count, CREDENTIALW*** Credential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredEnumerateA(const(PSTR) Filter, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/CRED_ENUMERATE_FLAGS Flags, 
                    uint* Count, CREDENTIALA*** Credential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredWriteDomainCredentialsW(CREDENTIAL_TARGET_INFORMATIONW* TargetInfo, CREDENTIALW* Credential, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredWriteDomainCredentialsA(CREDENTIAL_TARGET_INFORMATIONA* TargetInfo, CREDENTIALA* Credential, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredReadDomainCredentialsW(CREDENTIAL_TARGET_INFORMATIONW* TargetInfo, uint Flags, uint* Count, 
                                CREDENTIALW*** Credential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredReadDomainCredentialsA(CREDENTIAL_TARGET_INFORMATIONA* TargetInfo, uint Flags, uint* Count, 
                                CREDENTIALA*** Credential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredDeleteW(const(PWSTR) TargetName, CRED_TYPE Type, 
                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredDeleteA(const(PSTR) TargetName, CRED_TYPE Type, 
                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredRenameW(const(PWSTR) OldTargetName, const(PWSTR) NewTargetName, CRED_TYPE Type, 
                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredRenameA(const(PSTR) OldTargetName, const(PSTR) NewTargetName, CRED_TYPE Type, 
                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredGetTargetInfoW(const(PWSTR) TargetName, uint Flags, CREDENTIAL_TARGET_INFORMATIONW** TargetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredGetTargetInfoA(const(PSTR) TargetName, uint Flags, CREDENTIAL_TARGET_INFORMATIONA** TargetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredMarshalCredentialW(CRED_MARSHAL_TYPE CredType, void* Credential, PWSTR* MarshaledCredential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredMarshalCredentialA(CRED_MARSHAL_TYPE CredType, void* Credential, PSTR* MarshaledCredential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredUnmarshalCredentialW(const(PWSTR) MarshaledCredential, CRED_MARSHAL_TYPE* CredType, void** Credential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredUnmarshalCredentialA(const(PSTR) MarshaledCredential, CRED_MARSHAL_TYPE* CredType, void** Credential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredIsMarshaledCredentialW(const(PWSTR) MarshaledCredential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredIsMarshaledCredentialA(const(PSTR) MarshaledCredential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("credui.dll")
BOOL CredUnPackAuthenticationBufferW(CRED_PACK_FLAGS dwFlags, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pAuthBuffer, 
                                     uint cbAuthBuffer, PWSTR pszUserName, uint* pcchMaxUserName, 
                                     PWSTR pszDomainName, uint* pcchMaxDomainName, PWSTR pszPassword, 
                                     uint* pcchMaxPassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("credui.dll")
BOOL CredUnPackAuthenticationBufferA(CRED_PACK_FLAGS dwFlags, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pAuthBuffer, 
                                     uint cbAuthBuffer, PSTR pszUserName, uint* pcchlMaxUserName, PSTR pszDomainName, 
                                     uint* pcchMaxDomainName, PSTR pszPassword, uint* pcchMaxPassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("credui.dll")
BOOL CredPackAuthenticationBufferW(CRED_PACK_FLAGS dwFlags, PWSTR pszUserName, PWSTR pszPassword, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pPackedCredentials, 
                                   uint* pcbPackedCredentials);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("credui.dll")
BOOL CredPackAuthenticationBufferA(CRED_PACK_FLAGS dwFlags, PSTR pszUserName, PSTR pszPassword, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pPackedCredentials, 
                                   uint* pcbPackedCredentials);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL CredProtectW(BOOL fAsSelf, PWSTR pszCredentials, uint cchCredentials, PWSTR pszProtectedCredentials, 
                  uint* pcchMaxChars, CRED_PROTECTION_TYPE* ProtectionType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL CredProtectA(BOOL fAsSelf, PSTR pszCredentials, uint cchCredentials, PSTR pszProtectedCredentials, 
                  uint* pcchMaxChars, CRED_PROTECTION_TYPE* ProtectionType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL CredUnprotectW(BOOL fAsSelf, PWSTR pszProtectedCredentials, uint cchProtectedCredentials, 
                    PWSTR pszCredentials, uint* pcchMaxChars);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL CredUnprotectA(BOOL fAsSelf, PSTR pszProtectedCredentials, uint cchProtectedCredentials, PSTR pszCredentials, 
                    uint* pcchMaxChars);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL CredIsProtectedW(PWSTR pszProtectedCredentials, CRED_PROTECTION_TYPE* pProtectionType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL CredIsProtectedA(PSTR pszProtectedCredentials, CRED_PROTECTION_TYPE* pProtectionType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL CredFindBestCredentialW(const(PWSTR) TargetName, uint Type, uint Flags, CREDENTIALW** Credential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL CredFindBestCredentialA(const(PSTR) TargetName, uint Type, uint Flags, CREDENTIALA** Credential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CredGetSessionTypes(uint MaximumPersistCount, uint* MaximumPersist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void CredFree(void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("credui.dll")
WIN32_ERROR CredUIPromptForCredentialsW(CREDUI_INFOW* pUiInfo, const(PWSTR) pszTargetName, 
                                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/SecHandle* pContext, 
                                        uint dwAuthError, PWSTR pszUserName, uint ulUserNameBufferSize, 
                                        PWSTR pszPassword, uint ulPasswordBufferSize, BOOL* save, 
                                        CREDUI_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("credui.dll")
WIN32_ERROR CredUIPromptForCredentialsA(CREDUI_INFOA* pUiInfo, const(PSTR) pszTargetName, 
                                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/SecHandle* pContext, 
                                        uint dwAuthError, PSTR pszUserName, uint ulUserNameBufferSize, 
                                        PSTR pszPassword, uint ulPasswordBufferSize, BOOL* save, 
                                        CREDUI_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("credui.dll")
uint CredUIPromptForWindowsCredentialsW(CREDUI_INFOW* pUiInfo, uint dwAuthError, uint* pulAuthPackage, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* pvInAuthBuffer, 
                                        uint ulInAuthBufferSize, void** ppvOutAuthBuffer, uint* pulOutAuthBufferSize, 
                                        BOOL* pfSave, CREDUIWIN_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("credui.dll")
uint CredUIPromptForWindowsCredentialsA(CREDUI_INFOA* pUiInfo, uint dwAuthError, uint* pulAuthPackage, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* pvInAuthBuffer, 
                                        uint ulInAuthBufferSize, void** ppvOutAuthBuffer, uint* pulOutAuthBufferSize, 
                                        BOOL* pfSave, CREDUIWIN_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("credui.dll")
WIN32_ERROR CredUIParseUserNameW(const(PWSTR) UserName, PWSTR user, uint userBufferSize, PWSTR domain, 
                                 uint domainBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("credui.dll")
WIN32_ERROR CredUIParseUserNameA(const(PSTR) userName, PSTR user, uint userBufferSize, PSTR domain, 
                                 uint domainBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("credui.dll")
uint CredUICmdLinePromptForCredentialsW(const(PWSTR) pszTargetName, 
                                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/SecHandle* pContext, 
                                        uint dwAuthError, PWSTR UserName, uint ulUserBufferSize, PWSTR pszPassword, 
                                        uint ulPasswordBufferSize, BOOL* pfSave, CREDUI_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("credui.dll")
uint CredUICmdLinePromptForCredentialsA(const(PSTR) pszTargetName, 
                                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/SecHandle* pContext, 
                                        uint dwAuthError, PSTR UserName, uint ulUserBufferSize, PSTR pszPassword, 
                                        uint ulPasswordBufferSize, BOOL* pfSave, CREDUI_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("credui.dll")
uint CredUIConfirmCredentialsW(const(PWSTR) pszTargetName, BOOL bConfirm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("credui.dll")
uint CredUIConfirmCredentialsA(const(PSTR) pszTargetName, BOOL bConfirm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("credui.dll")
uint CredUIStoreSSOCredW(const(PWSTR) pszRealm, const(PWSTR) pszUsername, const(PWSTR) pszPassword, BOOL bPersist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("credui.dll")
uint CredUIReadSSOCredW(const(PWSTR) pszRealm, PWSTR* ppszUsername);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardEstablishContext(SCARD_SCOPE dwScope, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(void)* pvReserved1, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(void)* pvReserved2, 
                          size_t* phContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardReleaseContext(size_t hContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardIsValidContext(size_t hContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardListReaderGroupsA(size_t hContext, PSTR mszGroups, uint* pcchGroups);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardListReaderGroupsW(size_t hContext, PWSTR mszGroups, uint* pcchGroups);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardListReadersA(size_t hContext, const(PSTR) mszGroups, PSTR mszReaders, uint* pcchReaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardListReadersW(size_t hContext, const(PWSTR) mszGroups, PWSTR mszReaders, uint* pcchReaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardListCardsA(size_t hContext, ubyte* pbAtr, const(GUID)* rgquidInterfaces, uint cguidInterfaceCount, 
                    PSTR mszCards, uint* pcchCards);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardListCardsW(size_t hContext, ubyte* pbAtr, const(GUID)* rgquidInterfaces, uint cguidInterfaceCount, 
                    PWSTR mszCards, uint* pcchCards);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardListInterfacesA(size_t hContext, const(PSTR) szCard, GUID* pguidInterfaces, uint* pcguidInterfaces);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardListInterfacesW(size_t hContext, const(PWSTR) szCard, GUID* pguidInterfaces, uint* pcguidInterfaces);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardGetProviderIdA(size_t hContext, const(PSTR) szCard, GUID* pguidProviderId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardGetProviderIdW(size_t hContext, const(PWSTR) szCard, GUID* pguidProviderId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardGetCardTypeProviderNameA(size_t hContext, const(PSTR) szCardName, uint dwProviderId, PSTR szProvider, 
                                  uint* pcchProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardGetCardTypeProviderNameW(size_t hContext, const(PWSTR) szCardName, uint dwProviderId, PWSTR szProvider, 
                                  uint* pcchProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardIntroduceReaderGroupA(size_t hContext, const(PSTR) szGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardIntroduceReaderGroupW(size_t hContext, const(PWSTR) szGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardForgetReaderGroupA(size_t hContext, const(PSTR) szGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardForgetReaderGroupW(size_t hContext, const(PWSTR) szGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardIntroduceReaderA(size_t hContext, const(PSTR) szReaderName, const(PSTR) szDeviceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardIntroduceReaderW(size_t hContext, const(PWSTR) szReaderName, const(PWSTR) szDeviceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardForgetReaderA(size_t hContext, const(PSTR) szReaderName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardForgetReaderW(size_t hContext, const(PWSTR) szReaderName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardAddReaderToGroupA(size_t hContext, const(PSTR) szReaderName, const(PSTR) szGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardAddReaderToGroupW(size_t hContext, const(PWSTR) szReaderName, const(PWSTR) szGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardRemoveReaderFromGroupA(size_t hContext, const(PSTR) szReaderName, const(PSTR) szGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardRemoveReaderFromGroupW(size_t hContext, const(PWSTR) szReaderName, const(PWSTR) szGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardIntroduceCardTypeA(size_t hContext, const(PSTR) szCardName, const(GUID)* pguidPrimaryProvider, 
                            const(GUID)* rgguidInterfaces, uint dwInterfaceCount, ubyte* pbAtr, ubyte* pbAtrMask, 
                            uint cbAtrLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardIntroduceCardTypeW(size_t hContext, const(PWSTR) szCardName, const(GUID)* pguidPrimaryProvider, 
                            const(GUID)* rgguidInterfaces, uint dwInterfaceCount, ubyte* pbAtr, ubyte* pbAtrMask, 
                            uint cbAtrLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardSetCardTypeProviderNameA(size_t hContext, const(PSTR) szCardName, uint dwProviderId, 
                                  const(PSTR) szProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardSetCardTypeProviderNameW(size_t hContext, const(PWSTR) szCardName, uint dwProviderId, 
                                  const(PWSTR) szProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardForgetCardTypeA(size_t hContext, const(PSTR) szCardName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardForgetCardTypeW(size_t hContext, const(PWSTR) szCardName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardFreeMemory(size_t hContext, const(void)* pvMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
HANDLE SCardAccessStartedEvent();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
void SCardReleaseStartedEvent();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardLocateCardsA(size_t hContext, const(PSTR) mszCards, SCARD_READERSTATEA* rgReaderStates, uint cReaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardLocateCardsW(size_t hContext, const(PWSTR) mszCards, SCARD_READERSTATEW* rgReaderStates, uint cReaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardLocateCardsByATRA(size_t hContext, SCARD_ATRMASK* rgAtrMasks, uint cAtrs, 
                           SCARD_READERSTATEA* rgReaderStates, uint cReaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardLocateCardsByATRW(size_t hContext, SCARD_ATRMASK* rgAtrMasks, uint cAtrs, 
                           SCARD_READERSTATEW* rgReaderStates, uint cReaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardGetStatusChangeA(size_t hContext, uint dwTimeout, SCARD_READERSTATEA* rgReaderStates, uint cReaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardGetStatusChangeW(size_t hContext, uint dwTimeout, SCARD_READERSTATEW* rgReaderStates, uint cReaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardCancel(size_t hContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardConnectA(size_t hContext, const(PSTR) szReader, uint dwShareMode, uint dwPreferredProtocols, 
                  size_t* phCard, uint* pdwActiveProtocol);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardConnectW(size_t hContext, const(PWSTR) szReader, uint dwShareMode, uint dwPreferredProtocols, 
                  size_t* phCard, uint* pdwActiveProtocol);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardReconnect(size_t hCard, uint dwShareMode, uint dwPreferredProtocols, uint dwInitialization, 
                   uint* pdwActiveProtocol);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardDisconnect(size_t hCard, uint dwDisposition);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardBeginTransaction(size_t hCard);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardEndTransaction(size_t hCard, uint dwDisposition);

@DllImport("WinSCard.dll")
int SCardState(size_t hCard, uint* pdwState, uint* pdwProtocol, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pbAtr, 
               uint* pcbAtrLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardStatusA(size_t hCard, PSTR mszReaderNames, uint* pcchReaderLen, uint* pdwState, uint* pdwProtocol, 
                 ubyte* pbAtr, uint* pcbAtrLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardStatusW(size_t hCard, PWSTR mszReaderNames, uint* pcchReaderLen, uint* pdwState, uint* pdwProtocol, 
                 ubyte* pbAtr, uint* pcbAtrLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardTransmit(size_t hCard, SCARD_IO_REQUEST* pioSendPci, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbSendBuffer, 
                  uint cbSendLength, SCARD_IO_REQUEST* pioRecvPci, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* pbRecvBuffer, 
                  uint* pcbRecvLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WinSCard.dll")
int SCardGetTransmitCount(size_t hCard, uint* pcTransmitCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardControl(size_t hCard, uint dwControlCode, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* lpInBuffer, 
                 uint cbInBufferSize, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpOutBuffer, 
                 uint cbOutBufferSize, uint* lpBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardGetAttrib(size_t hCard, uint dwAttrId, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbAttr, 
                   uint* pcbAttrLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WinSCard.dll")
int SCardSetAttrib(size_t hCard, uint dwAttrId, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbAttr, 
                   uint cbAttrLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SCARDDLG.dll")
int SCardUIDlgSelectCardA(OPENCARDNAME_EXA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SCARDDLG.dll")
int SCardUIDlgSelectCardW(OPENCARDNAME_EXW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SCARDDLG.dll")
int GetOpenCardNameA(OPENCARDNAMEA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SCARDDLG.dll")
int GetOpenCardNameW(OPENCARDNAMEW* param0);

@DllImport("SCARDDLG.dll")
int SCardDlgExtendedError();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WinSCard.dll")
int SCardReadCacheA(size_t hContext, GUID* CardIdentifier, uint FreshnessCounter, PSTR LookupName, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Data, 
                    uint* DataLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WinSCard.dll")
int SCardReadCacheW(size_t hContext, GUID* CardIdentifier, uint FreshnessCounter, PWSTR LookupName, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Data, 
                    uint* DataLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WinSCard.dll")
int SCardWriteCacheA(size_t hContext, GUID* CardIdentifier, uint FreshnessCounter, PSTR LookupName, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Data, 
                     uint DataLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WinSCard.dll")
int SCardWriteCacheW(size_t hContext, GUID* CardIdentifier, uint FreshnessCounter, PWSTR LookupName, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Data, 
                     uint DataLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WinSCard.dll")
int SCardGetReaderIconA(size_t hContext, const(PSTR) szReaderName, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbIcon, 
                        uint* pcbIcon);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WinSCard.dll")
int SCardGetReaderIconW(size_t hContext, const(PWSTR) szReaderName, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbIcon, 
                        uint* pcbIcon);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WinSCard.dll")
int SCardGetDeviceTypeIdA(size_t hContext, const(PSTR) szReaderName, uint* pdwDeviceTypeId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WinSCard.dll")
int SCardGetDeviceTypeIdW(size_t hContext, const(PWSTR) szReaderName, uint* pdwDeviceTypeId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WinSCard.dll")
int SCardGetReaderDeviceInstanceIdA(size_t hContext, const(PSTR) szReaderName, PSTR szDeviceInstanceId, 
                                    uint* pcchDeviceInstanceId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WinSCard.dll")
int SCardGetReaderDeviceInstanceIdW(size_t hContext, const(PWSTR) szReaderName, PWSTR szDeviceInstanceId, 
                                    uint* pcchDeviceInstanceId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WinSCard.dll")
int SCardListReadersWithDeviceInstanceIdA(size_t hContext, const(PSTR) szDeviceInstanceId, PSTR mszReaders, 
                                          uint* pcchReaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WinSCard.dll")
int SCardListReadersWithDeviceInstanceIdW(size_t hContext, const(PWSTR) szDeviceInstanceId, PWSTR mszReaders, 
                                          uint* pcchReaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WinSCard.dll")
int SCardAudit(size_t hContext, uint dwEvent);


