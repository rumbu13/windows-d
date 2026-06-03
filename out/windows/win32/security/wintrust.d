// Written in the D programming language.

module windows.win32.security.wintrust;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, FILETIME, HANDLE, HRESULT,
                                         HWND, PSTR, PWSTR;
public import windows.win32.security.cryptography : CERT_CHAIN_CONTEXT, CERT_CHAIN_ELEMENT,
                                                    CERT_CHAIN_PARA, CERT_CONTEXT,
                                                    CERT_INFO, CERT_STRONG_SIGN_PARA,
                                                    CERT_USAGE_MATCH, CMSG_SIGNER_INFO,
                                                    CRYPT_ALGORITHM_IDENTIFIER,
                                                    CRYPT_ATTRIBUTE_TYPE_VALUE,
                                                    CRYPT_BIT_BLOB, CRYPT_INTEGER_BLOB,
                                                    CTL_CONTEXT, HCERTCHAINENGINE,
                                                    HCERTSTORE;
public import windows.win32.security.cryptography.sip : SIP_DISPATCH_INFO, SIP_INDIRECT_DATA,
                                                        SIP_SUBJECTINFO;

extern(Windows) @nogc nothrow:


// Enums


alias WINTRUST_GET_DEFAULT_FOR_USAGE_ACTION = uint;
enum : uint
{
    DWACTION_ALLOCANDFILL = 0x00000001U,
    DWACTION_FREE         = 0x00000002U,
}

alias WINTRUST_POLICY_FLAGS = uint;
enum : uint
{
    WTPF_TRUSTTEST            = 0x00000020U,
    WTPF_TESTCANBEVALID       = 0x00000080U,
    WTPF_IGNOREEXPIRATION     = 0x00000100U,
    WTPF_IGNOREREVOKATION     = 0x00000200U,
    WTPF_OFFLINEOK_IND        = 0x00000400U,
    WTPF_OFFLINEOK_COM        = 0x00000800U,
    WTPF_OFFLINEOKNBU_IND     = 0x00001000U,
    WTPF_OFFLINEOKNBU_COM     = 0x00002000U,
    WTPF_VERIFY_V1_OFF        = 0x00010000U,
    WTPF_IGNOREREVOCATIONONTS = 0x00020000U,
    WTPF_ALLOWONLYPERTRUST    = 0x00040000U,
}

alias WINTRUST_DATA_PROVIDER_FLAGS = uint;
enum : uint
{
    WTD_USE_IE4_TRUST_FLAG                  = 0x00000001U,
    WTD_NO_IE4_CHAIN_FLAG                   = 0x00000002U,
    WTD_NO_POLICY_USAGE_FLAG                = 0x00000004U,
    WTD_REVOCATION_CHECK_NONE               = 0x00000010U,
    WTD_REVOCATION_CHECK_END_CERT           = 0x00000020U,
    WTD_REVOCATION_CHECK_CHAIN              = 0x00000040U,
    WTD_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT = 0x00000080U,
    WTD_SAFER_FLAG                          = 0x00000100U,
    WTD_HASH_ONLY_FLAG                      = 0x00000200U,
    WTD_USE_DEFAULT_OSVER_CHECK             = 0x00000400U,
    WTD_LIFETIME_SIGNING_FLAG               = 0x00000800U,
    WTD_CACHE_ONLY_URL_RETRIEVAL            = 0x00001000U,
    WTD_DISABLE_MD2_MD4                     = 0x00002000U,
    WTD_MOTW                                = 0x00004000U,
}

alias WINTRUST_DATA_UICHOICE = uint;
enum : uint
{
    WTD_UI_ALL    = 0x00000001U,
    WTD_UI_NONE   = 0x00000002U,
    WTD_UI_NOBAD  = 0x00000003U,
    WTD_UI_NOGOOD = 0x00000004U,
}

alias WINTRUST_SIGNATURE_SETTINGS_FLAGS = uint;
enum : uint
{
    WSS_VERIFY_SPECIFIC         = 0x00000001U,
    WSS_GET_SECONDARY_SIG_COUNT = 0x00000002U,
}

alias WINTRUST_DATA_STATE_ACTION = uint;
enum : uint
{
    WTD_STATEACTION_IGNORE           = 0x00000000U,
    WTD_STATEACTION_VERIFY           = 0x00000001U,
    WTD_STATEACTION_CLOSE            = 0x00000002U,
    WTD_STATEACTION_AUTO_CACHE       = 0x00000003U,
    WTD_STATEACTION_AUTO_CACHE_FLUSH = 0x00000004U,
}

alias WINTRUST_DATA_UNION_CHOICE = uint;
enum : uint
{
    WTD_CHOICE_FILE    = 0x00000001U,
    WTD_CHOICE_CATALOG = 0x00000002U,
    WTD_CHOICE_BLOB    = 0x00000003U,
    WTD_CHOICE_SIGNER  = 0x00000004U,
    WTD_CHOICE_CERT    = 0x00000005U,
}

alias WINTRUST_DATA_REVOCATION_CHECKS = uint;
enum : uint
{
    WTD_REVOKE_NONE       = 0x00000000U,
    WTD_REVOKE_WHOLECHAIN = 0x00000001U,
}

alias WINTRUST_DATA_UICONTEXT = uint;
enum : uint
{
    WTD_UICONTEXT_EXECUTE = 0x00000000U,
    WTD_UICONTEXT_INSTALL = 0x00000001U,
}

// Constants


enum const(wchar)* WINTRUST_CONFIG_REGPATH = "Software\\Microsoft\\Cryptography\\Wintrust\\Config";
enum const(wchar)* WINTRUST_MAX_HEADER_BYTES_TO_MAP_VALUE_NAME = "MaxHeaderBytesToMap";
enum uint WINTRUST_MAX_HEADER_BYTES_TO_MAP_DEFAULT = 0x00a00000U;
enum const(wchar)* WINTRUST_MAX_HASH_BYTES_TO_MAP_VALUE_NAME = "MaxHashBytesToMap";
enum uint WINTRUST_MAX_HASH_BYTES_TO_MAP_DEFAULT = 0x00100000U;
enum uint WTD_CHOICE_DETACHED_SIG = 0x00000006U;
enum uint WTD_PROV_FLAGS_MASK = 0x0000ffffU;
enum uint WTD_USE_LOCAL_MACHINE_CERTS = 0x00000008U;
enum uint WTD_CODE_INTEGRITY_DRIVER_MODE = 0x00008000U;
enum uint WSS_VERIFY_SEALING = 0x00000004U;
enum uint WSS_INPUT_FLAG_MASK = 0x00000007U;
enum uint WSS_OUT_SEALING_STATUS_VERIFIED = 0x80000000U;
enum uint WSS_OUT_HAS_SEALING_INTENT = 0x40000000U;
enum uint WSS_OUT_FILE_SUPPORTS_SEAL = 0x20000000U;
enum uint WSS_OUTPUT_FLAG_MASK = 0xe0000000U;

enum : uint
{
    WINTRUST_DETACHED_SIG_CHOICE_HANDLE = 0x00000001U,
    WINTRUST_DETACHED_SIG_CHOICE_BLOB   = 0x00000002U,
}

enum uint WTCI_DONT_OPEN_STORES = 0x00000001U;
enum uint WTCI_OPEN_ONLY_ROOT = 0x00000002U;
enum uint WTCI_USE_LOCAL_MACHINE = 0x00000004U;

enum : uint
{
    TRUSTERROR_STEP_WVTPARAMS              = 0x00000000U,
    TRUSTERROR_STEP_FILEIO                 = 0x00000002U,
    TRUSTERROR_STEP_SIP                    = 0x00000003U,
    TRUSTERROR_STEP_SIPSUBJINFO            = 0x00000005U,
    TRUSTERROR_STEP_CATALOGFILE            = 0x00000006U,
    TRUSTERROR_STEP_CERTSTORE              = 0x00000007U,
    TRUSTERROR_STEP_MESSAGE                = 0x00000008U,
    TRUSTERROR_STEP_MSG_SIGNERCOUNT        = 0x00000009U,
    TRUSTERROR_STEP_MSG_INNERCNTTYPE       = 0x0000000aU,
    TRUSTERROR_STEP_MSG_INNERCNT           = 0x0000000bU,
    TRUSTERROR_STEP_MSG_STORE              = 0x0000000cU,
    TRUSTERROR_STEP_MSG_SIGNERINFO         = 0x0000000dU,
    TRUSTERROR_STEP_MSG_SIGNERCERT         = 0x0000000eU,
    TRUSTERROR_STEP_MSG_CERTCHAIN          = 0x0000000fU,
    TRUSTERROR_STEP_MSG_COUNTERSIGINFO     = 0x00000010U,
    TRUSTERROR_STEP_MSG_COUNTERSIGCERT     = 0x00000011U,
    TRUSTERROR_STEP_VERIFY_MSGHASH         = 0x00000012U,
    TRUSTERROR_STEP_VERIFY_MSGINDIRECTDATA = 0x00000013U,
    TRUSTERROR_STEP_FINAL_WVTINIT          = 0x0000001eU,
    TRUSTERROR_STEP_FINAL_INITPROV         = 0x0000001fU,
    TRUSTERROR_STEP_FINAL_OBJPROV          = 0x00000020U,
    TRUSTERROR_STEP_FINAL_SIGPROV          = 0x00000021U,
    TRUSTERROR_STEP_FINAL_CERTPROV         = 0x00000022U,
    TRUSTERROR_STEP_FINAL_CERTCHKPROV      = 0x00000023U,
    TRUSTERROR_STEP_FINAL_POLICYPROV       = 0x00000024U,
    TRUSTERROR_STEP_FINAL_UIPROV           = 0x00000025U,
}

enum uint TRUSTERROR_MAX_STEPS = 0x00000026U;
enum uint CPD_CHOICE_SIP = 0x00000001U;
enum uint CPD_USE_NT5_CHAIN_FLAG = 0x80000000U;

enum : uint
{
    CPD_REVOCATION_CHECK_NONE               = 0x00010000U,
    CPD_REVOCATION_CHECK_END_CERT           = 0x00020000U,
    CPD_REVOCATION_CHECK_CHAIN              = 0x00040000U,
    CPD_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT = 0x00080000U,
}

enum uint CPD_RETURN_LOWER_QUALITY_CHAINS = 0x00100000U;
enum uint CPD_RFC3161v21 = 0x00200000U;

enum : uint
{
    CPD_UISTATE_MODE_PROMPT = 0x00000000U,
    CPD_UISTATE_MODE_BLOCK  = 0x00000001U,
    CPD_UISTATE_MODE_ALLOW  = 0x00000002U,
    CPD_UISTATE_MODE_MASK   = 0x00000003U,
}

enum uint WSS_OBJTRUST_SUPPORT = 0x00000001U;
enum uint WSS_SIGTRUST_SUPPORT = 0x00000002U;
enum uint WSS_CERTTRUST_SUPPORT = 0x00000004U;
enum uint SGNR_TYPE_TIMESTAMP = 0x00000010U;

enum : uint
{
    CERT_CONFIDENCE_SIG       = 0x10000000U,
    CERT_CONFIDENCE_TIME      = 0x01000000U,
    CERT_CONFIDENCE_TIMENEST  = 0x00100000U,
    CERT_CONFIDENCE_AUTHIDEXT = 0x00010000U,
    CERT_CONFIDENCE_HYGIENE   = 0x00001000U,
    CERT_CONFIDENCE_HIGHEST   = 0x11111000U,
}

enum uint WT_CURRENT_VERSION = 0x00000200U;

enum : const(wchar)*
{
    WT_PROVIDER_DLL_NAME           = "WINTRUST.DLL",
    WT_PROVIDER_CERTTRUST_FUNCTION = "WintrustCertificateTrust",
}

enum uint WT_ADD_ACTION_ID_RET_RESULT_FLAG = 0x00000001U;

enum : const(wchar)*
{
    // Native encoding: ansi
    szOID_TRUSTED_CODESIGNING_CA_LIST = "1.3.6.1.4.1.311.2.2.1",
    // Native encoding: ansi
    szOID_TRUSTED_CLIENT_AUTH_CA_LIST = "1.3.6.1.4.1.311.2.2.2",
    // Native encoding: ansi
    szOID_TRUSTED_SERVER_AUTH_CA_LIST = "1.3.6.1.4.1.311.2.2.3",
}

enum const(wchar)* SPC_COMMON_NAME_OBJID = "2.5.4.3";
// Native encoding: ansi
enum const(wchar)* SPC_TIME_STAMP_REQUEST_OBJID = "1.3.6.1.4.1.311.3.2.1";
// Native encoding: ansi
enum const(wchar)* SPC_INDIRECT_DATA_OBJID = "1.3.6.1.4.1.311.2.1.4";
// Native encoding: ansi
enum const(wchar)* SPC_SP_AGENCY_INFO_OBJID = "1.3.6.1.4.1.311.2.1.10";
// Native encoding: ansi
enum const(wchar)* SPC_STATEMENT_TYPE_OBJID = "1.3.6.1.4.1.311.2.1.11";
// Native encoding: ansi
enum const(wchar)* SPC_SP_OPUS_INFO_OBJID = "1.3.6.1.4.1.311.2.1.12";
// Native encoding: ansi
enum const(wchar)* SPC_CERT_EXTENSIONS_OBJID = "1.3.6.1.4.1.311.2.1.14";
// Native encoding: ansi
enum const(wchar)* SPC_PE_IMAGE_DATA_OBJID = "1.3.6.1.4.1.311.2.1.15";
// Native encoding: ansi
enum const(wchar)* SPC_RAW_FILE_DATA_OBJID = "1.3.6.1.4.1.311.2.1.18";
// Native encoding: ansi
enum const(wchar)* SPC_STRUCTURED_STORAGE_DATA_OBJID = "1.3.6.1.4.1.311.2.1.19";
// Native encoding: ansi
enum const(wchar)* SPC_JAVA_CLASS_DATA_OBJID = "1.3.6.1.4.1.311.2.1.20";
// Native encoding: ansi
enum const(wchar)* SPC_INDIVIDUAL_SP_KEY_PURPOSE_OBJID = "1.3.6.1.4.1.311.2.1.21";
// Native encoding: ansi
enum const(wchar)* SPC_COMMERCIAL_SP_KEY_PURPOSE_OBJID = "1.3.6.1.4.1.311.2.1.22";
// Native encoding: ansi
enum const(wchar)* SPC_CAB_DATA_OBJID = "1.3.6.1.4.1.311.2.1.25";
// Native encoding: ansi
enum const(wchar)* SPC_GLUE_RDN_OBJID = "1.3.6.1.4.1.311.2.1.25";
// Native encoding: ansi
enum const(wchar)* SPC_MINIMAL_CRITERIA_OBJID = "1.3.6.1.4.1.311.2.1.26";
// Native encoding: ansi
enum const(wchar)* SPC_FINANCIAL_CRITERIA_OBJID = "1.3.6.1.4.1.311.2.1.27";
// Native encoding: ansi
enum const(wchar)* SPC_LINK_OBJID = "1.3.6.1.4.1.311.2.1.28";
// Native encoding: ansi
enum const(wchar)* SPC_SIGINFO_OBJID = "1.3.6.1.4.1.311.2.1.30";

enum : const(wchar)*
{
    // Native encoding: ansi
    SPC_PE_IMAGE_PAGE_HASHES_V1_OBJID = "1.3.6.1.4.1.311.2.3.1",
    // Native encoding: ansi
    SPC_PE_IMAGE_PAGE_HASHES_V2_OBJID = "1.3.6.1.4.1.311.2.3.2",
}

// Native encoding: ansi
enum const(wchar)* szOID_NESTED_SIGNATURE = "1.3.6.1.4.1.311.2.4.1";
// Native encoding: ansi
enum const(wchar)* szOID_INTENT_TO_SEAL = "1.3.6.1.4.1.311.2.4.2";

enum : const(wchar)*
{
    // Native encoding: ansi
    szOID_SEALING_SIGNATURE = "1.3.6.1.4.1.311.2.4.3",
    // Native encoding: ansi
    szOID_SEALING_TIMESTAMP = "1.3.6.1.4.1.311.2.4.4",
}

// Native encoding: ansi
enum const(wchar)* szOID_ENHANCED_HASH = "1.3.6.1.4.1.311.2.5.1";
// Native encoding: ansi
enum const(wchar)* SPC_RELAXED_PE_MARKER_CHECK_OBJID = "1.3.6.1.4.1.311.2.6.1";
// Native encoding: ansi
enum const(wchar)* SPC_ENCRYPTED_DIGEST_RETRY_COUNT_OBJID = "1.3.6.1.4.1.311.2.6.2";

enum : const(wchar)*
{
    // Native encoding: ansi
    szOID_SIGNED_ATTRIBUTE_INTERNAL_NAME     = "1.3.6.1.4.1.311.2.7.1",
    // Native encoding: ansi
    szOID_SIGNED_ATTRIBUTE_FILE_VERSION      = "1.3.6.1.4.1.311.2.7.2",
    // Native encoding: ansi
    szOID_SIGNED_ATTRIBUTE_FILE_DESCRIPTION  = "1.3.6.1.4.1.311.2.7.3",
    // Native encoding: ansi
    szOID_SIGNED_ATTRIBUTE_PRODUCT           = "1.3.6.1.4.1.311.2.7.4",
    // Native encoding: ansi
    szOID_SIGNED_ATTRIBUTE_PRODUCT_VERSION   = "1.3.6.1.4.1.311.2.7.5",
    // Native encoding: ansi
    szOID_SIGNED_ATTRIBUTE_ORIGINAL_FILENAME = "1.3.6.1.4.1.311.2.7.6",
    // Native encoding: ansi
    szOID_SIGNED_ATTRIBUTE_LANGUAGE          = "1.3.6.1.4.1.311.2.7.7",
    // Native encoding: ansi
    szOID_SIGNED_ATTRIBUTE_AUTHOR            = "1.3.6.1.4.1.311.2.7.8",
    // Native encoding: ansi
    szOID_SIGNED_ATTRIBUTE_PUBLISH_TIME      = "1.3.6.1.4.1.311.2.7.9",
    // Native encoding: ansi
    szOID_SIGNED_ATTRIBUTE_SOURCE_URL        = "1.3.6.1.4.1.311.2.7.10",
}

// Native encoding: ansi
enum const(wchar)* szOID_PKCS_9_SEQUENCE_NUMBER = "1.2.840.113549.1.9.25.4";
// Native encoding: ansi
enum const(wchar)* CAT_NAMEVALUE_OBJID = "1.3.6.1.4.1.311.12.2.1";

enum : const(wchar)*
{
    // Native encoding: ansi
    CAT_MEMBERINFO_OBJID  = "1.3.6.1.4.1.311.12.2.2",
    // Native encoding: ansi
    CAT_MEMBERINFO2_OBJID = "1.3.6.1.4.1.311.12.2.3",
}

// Native encoding: ansi
enum const(wchar)* SPC_WINDOWS_HELLO_COMPATIBILITY_OBJID = "1.3.6.1.4.1.311.10.41.1";
// Native encoding: ansi
enum const(wchar)* SPC_NATURAL_AUTH_PLUGIN_OBJID = "1.3.6.1.4.1.311.96.1.1";
enum PSTR SPC_SP_AGENCY_INFO_STRUCT = PSTR(cast(ubyte*) 0x000007d0);
enum PSTR SPC_MINIMAL_CRITERIA_STRUCT = PSTR(cast(ubyte*) 0x000007d1);
enum PSTR SPC_FINANCIAL_CRITERIA_STRUCT = PSTR(cast(ubyte*) 0x000007d2);
enum PSTR SPC_INDIRECT_DATA_CONTENT_STRUCT = PSTR(cast(ubyte*) 0x000007d3);
enum PSTR SPC_PE_IMAGE_DATA_STRUCT = PSTR(cast(ubyte*) 0x000007d4);
enum PSTR SPC_LINK_STRUCT = PSTR(cast(ubyte*) 0x000007d5);
enum PSTR SPC_STATEMENT_TYPE_STRUCT = PSTR(cast(ubyte*) 0x000007d6);
enum PSTR SPC_SP_OPUS_INFO_STRUCT = PSTR(cast(ubyte*) 0x000007d7);
enum PSTR SPC_CAB_DATA_STRUCT = PSTR(cast(ubyte*) 0x000007d8);
enum PSTR SPC_JAVA_CLASS_DATA_STRUCT = PSTR(cast(ubyte*) 0x000007d9);
enum PSTR INTENT_TO_SEAL_ATTRIBUTE_STRUCT = PSTR(cast(ubyte*) 0x000007da);
enum PSTR SEALING_SIGNATURE_ATTRIBUTE_STRUCT = PSTR(cast(ubyte*) 0x000007db);
enum PSTR SEALING_TIMESTAMP_ATTRIBUTE_STRUCT = PSTR(cast(ubyte*) 0x000007dc);
enum PSTR SPC_SIGINFO_STRUCT = PSTR(cast(ubyte*) 0x00000852);
enum PSTR CAT_NAMEVALUE_STRUCT = PSTR(cast(ubyte*) 0x000008ad);

enum : PSTR
{
    CAT_MEMBERINFO_STRUCT  = PSTR(cast(ubyte*) 0x000008ae),
    CAT_MEMBERINFO2_STRUCT = PSTR(cast(ubyte*) 0x000008af),
}

enum uint SPC_UUID_LENGTH = 0x00000010U;
enum uint SPC_URL_LINK_CHOICE = 0x00000001U;
enum uint SPC_MONIKER_LINK_CHOICE = 0x00000002U;
enum uint SPC_FILE_LINK_CHOICE = 0x00000003U;

enum : uint
{
    WIN_CERT_REVISION_1_0          = 0x00000100U,
    WIN_CERT_REVISION_2_0          = 0x00000200U,
    WIN_CERT_TYPE_X509             = 0x00000001U,
    WIN_CERT_TYPE_PKCS_SIGNED_DATA = 0x00000002U,
    WIN_CERT_TYPE_RESERVED_1       = 0x00000003U,
    WIN_CERT_TYPE_TS_STACK_SIGNED  = 0x00000004U,
}

enum : GUID
{
    WIN_TRUST_SUBJTYPE_RAW_FILE     = GUID("959dc450-8d9e-11cf-8736-00aa00a485eb"),
    WIN_TRUST_SUBJTYPE_PE_IMAGE     = GUID("43c9a1e0-8da0-11cf-8736-00aa00a485eb"),
    WIN_TRUST_SUBJTYPE_JAVA_CLASS   = GUID("08ad3990-8da1-11cf-8736-00aa00a485eb"),
    WIN_TRUST_SUBJTYPE_CABINET      = GUID("d17c5374-a392-11cf-9df5-00aa00c184e0"),
    WIN_TRUST_SUBJTYPE_RAW_FILEEX   = GUID("6f458110-c2f1-11cf-8a69-00aa006c3706"),
    WIN_TRUST_SUBJTYPE_PE_IMAGEEX   = GUID("6f458111-c2f1-11cf-8a69-00aa006c3706"),
    WIN_TRUST_SUBJTYPE_JAVA_CLASSEX = GUID("6f458113-c2f1-11cf-8a69-00aa006c3706"),
    WIN_TRUST_SUBJTYPE_CABINETEX    = GUID("6f458114-c2f1-11cf-8a69-00aa006c3706"),
    WIN_TRUST_SUBJTYPE_OLE_STORAGE  = GUID("c257e740-8da0-11cf-8736-00aa00a485eb"),
}

enum : GUID
{
    WIN_SPUB_ACTION_TRUSTED_PUBLISHER  = GUID("66426730-8da1-11cf-8736-00aa00a485eb"),
    WIN_SPUB_ACTION_NT_ACTIVATE_IMAGE  = GUID("8bc96b00-8da1-11cf-8736-00aa00a485eb"),
    WIN_SPUB_ACTION_PUBLISHED_SOFTWARE = GUID("64b9d180-8da2-11cf-8736-00aa00a485eb"),
}

enum : uint
{
    WT_TRUSTDBDIALOG_NO_UI_FLAG            = 0x00000001U,
    WT_TRUSTDBDIALOG_ONLY_PUB_TAB_FLAG     = 0x00000002U,
    WT_TRUSTDBDIALOG_WRITE_LEGACY_REG_FLAG = 0x00000100U,
    WT_TRUSTDBDIALOG_WRITE_IEAK_STORE_FLAG = 0x00000200U,
}

enum const(wchar)* SP_POLICY_PROVIDER_DLL_NAME = "WINTRUST.DLL";
enum GUID WINTRUST_ACTION_GENERIC_VERIFY_V2 = GUID("00aac56b-cd44-11d0-8cc2-00c04fc295ee");
enum const(wchar)* SP_INIT_FUNCTION = "SoftpubInitialize";
enum const(wchar)* SP_OBJTRUST_FUNCTION = "SoftpubLoadMessage";
enum const(wchar)* SP_SIGTRUST_FUNCTION = "SoftpubLoadSignature";
enum const(wchar)* SP_CHKCERT_FUNCTION = "SoftpubCheckCert";
enum const(wchar)* SP_FINALPOLICY_FUNCTION = "SoftpubAuthenticode";
enum const(wchar)* SP_CLEANUPPOLICY_FUNCTION = "SoftpubCleanup";
enum GUID WINTRUST_ACTION_TRUSTPROVIDER_TEST = GUID("573e31f8-ddba-11d0-8ccb-00c04fc295ee");
enum const(wchar)* SP_TESTDUMPPOLICY_FUNCTION_TEST = "SoftpubDumpStructure";
enum GUID WINTRUST_ACTION_GENERIC_CERT_VERIFY = GUID("189a3842-3041-11d1-85e1-00c04fc295ee");
enum const(wchar)* SP_GENERIC_CERT_INIT_FUNCTION = "SoftpubDefCertInit";
enum GUID WINTRUST_ACTION_GENERIC_CHAIN_VERIFY = GUID("fc451c16-ac75-11d1-b4b8-00c04fb66ea0");

enum : const(wchar)*
{
    GENERIC_CHAIN_FINALPOLICY_FUNCTION = "GenericChainFinalProv",
    GENERIC_CHAIN_CERTTRUST_FUNCTION   = "GenericChainCertificateTrust",
}

enum GUID HTTPSPROV_ACTION = GUID("573e31f8-aaba-11d0-8ccb-00c04fc295ee");
enum const(wchar)* HTTPS_FINALPOLICY_FUNCTION = "HTTPSFinalProv";
enum const(wchar)* HTTPS_CHKCERT_FUNCTION = "HTTPSCheckCertProv";
enum const(wchar)* HTTPS_CERTTRUST_FUNCTION = "HTTPSCertificateTrust";
enum GUID OFFICESIGN_ACTION_VERIFY = GUID("5555c2cd-17fb-11d1-85c4-00c04fc295ee");
enum const(wchar)* OFFICE_POLICY_PROVIDER_DLL_NAME = "WINTRUST.DLL";
enum const(wchar)* OFFICE_INITPROV_FUNCTION = "OfficeInitializePolicy";
enum const(wchar)* OFFICE_CLEANUPPOLICY_FUNCTION = "OfficeCleanupPolicy";
enum GUID DRIVER_ACTION_VERIFY = GUID("f750e6c3-38ee-11d1-85e5-00c04fc295ee");
enum const(wchar)* DRIVER_INITPROV_FUNCTION = "DriverInitializePolicy";
enum const(wchar)* DRIVER_FINALPOLPROV_FUNCTION = "DriverFinalPolicy";
enum const(wchar)* DRIVER_CLEANUPPOLICY_FUNCTION = "DriverCleanupPolicy";
enum GUID CONFIG_CI_ACTION_VERIFY = GUID("6078065b-8f22-4b13-bd9b-5b762776f386");

enum : uint
{
    CCPI_RESULT_ALLOW = 0x00000001U,
    CCPI_RESULT_DENY  = 0x00000002U,
    CCPI_RESULT_AUDIT = 0x00000003U,
}

// Callbacks

alias PFN_CPD_MEM_ALLOC = void* function(uint cbSize);
alias PFN_CPD_MEM_FREE = void function(void* pvMem2Free);
alias PFN_CPD_ADD_STORE = BOOL function(CRYPT_PROVIDER_DATA* pProvData, HCERTSTORE hStore2Add);
alias PFN_CPD_ADD_SGNR = BOOL function(CRYPT_PROVIDER_DATA* pProvData, BOOL fCounterSigner, uint idxSigner, 
                                       CRYPT_PROVIDER_SGNR* pSgnr2Add);
alias PFN_CPD_ADD_CERT = BOOL function(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, BOOL fCounterSigner, 
                                       uint idxCounterSigner, const(CERT_CONTEXT)* pCert2Add);
alias PFN_CPD_ADD_PRIVDATA = BOOL function(CRYPT_PROVIDER_DATA* pProvData, CRYPT_PROVIDER_PRIVDATA* pPrivData2Add);
alias PFN_PROVIDER_INIT_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_OBJTRUST_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_SIGTRUST_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CERTTRUST_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_FINALPOLICY_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_TESTFINALPOLICY_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CLEANUP_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CERTCHKPOLICY_CALL = BOOL function(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, 
                                                      BOOL fCounterSignerChain, uint idxCounterSigner);
alias PFN_PROVUI_CALL = BOOL function(HWND hWndSecurityDialog, CRYPT_PROVIDER_DATA* pProvData);
alias PFN_ALLOCANDFILLDEFUSAGE = BOOL function(const(PSTR) pszUsageOID, CRYPT_PROVIDER_DEFUSAGE* psDefUsage);
alias PFN_FREEDEFUSAGE = BOOL function(const(PSTR) pszUsageOID, CRYPT_PROVIDER_DEFUSAGE* psDefUsage);
alias PFN_WTD_GENERIC_CHAIN_POLICY_CALLBACK = HRESULT function(CRYPT_PROVIDER_DATA* pProvData, uint dwStepError, 
                                                               uint dwRegPolicySettings, uint cSigner, 
                                                               WTD_GENERIC_CHAIN_POLICY_SIGNER_INFO** rgpSigner, 
                                                               void* pvPolicyArg);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_data
struct WINTRUST_DATA
{
    uint   cbStruct;
    void*  pPolicyCallbackData;
    void*  pSIPClientData;
    WINTRUST_DATA_UICHOICE dwUIChoice;
    WINTRUST_DATA_REVOCATION_CHECKS fdwRevocationChecks;
    WINTRUST_DATA_UNION_CHOICE dwUnionChoice;
    union
    {
        WINTRUST_FILE_INFO* pFile;
        WINTRUST_CATALOG_INFO* pCatalog;
        WINTRUST_BLOB_INFO* pBlob;
        WINTRUST_SGNR_INFO* pSgnr;
        WINTRUST_CERT_INFO* pCert;
        WINTRUST_DETACHED_SIG_INFO* pDetachedSig;
    }
    WINTRUST_DATA_STATE_ACTION dwStateAction;
    HANDLE hWVTStateData;
    PWSTR  pwszURLReference;
    WINTRUST_DATA_PROVIDER_FLAGS dwProvFlags;
    WINTRUST_DATA_UICONTEXT dwUIContext;
    WINTRUST_SIGNATURE_SETTINGS* pSignatureSettings;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_signature_settings
struct WINTRUST_SIGNATURE_SETTINGS
{
    uint cbStruct;
    uint dwIndex;
    WINTRUST_SIGNATURE_SETTINGS_FLAGS dwFlags;
    uint cSecondarySigs;
    uint dwVerifiedSigIndex;
    CERT_STRONG_SIGN_PARA* pCryptoPolicy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_file_info
struct WINTRUST_FILE_INFO
{
    uint         cbStruct;
    const(PWSTR) pcwszFilePath;
    HANDLE       hFile;
    GUID*        pgKnownSubject;
}

struct WINTRUST_DETACHED_SIG_FILE_HANDLES
{
    HANDLE hContentFile;
    HANDLE hSignatureFile;
}

struct WINTRUST_DETACHED_SIG_BLOBS
{
    long   cbContentObject;
    ubyte* pbContentObject;
    uint   cbSignatureObject;
    ubyte* pbSignatureObject;
}

struct WINTRUST_DETACHED_SIG_INFO
{
    uint cbStruct;
    uint dwUnionChoice;
    union
    {
        WINTRUST_DETACHED_SIG_FILE_HANDLES* pDetachedSigHandles;
        WINTRUST_DETACHED_SIG_BLOBS* pDetachedSigBlobs;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_catalog_info
struct WINTRUST_CATALOG_INFO
{
    uint         cbStruct;
    uint         dwCatalogVersion;
    const(PWSTR) pcwszCatalogFilePath;
    const(PWSTR) pcwszMemberTag;
    const(PWSTR) pcwszMemberFilePath;
    HANDLE       hMemberFile;
    ubyte*       pbCalculatedFileHash;
    uint         cbCalculatedFileHash;
    CTL_CONTEXT* pcCatalogContext;
    ptrdiff_t    hCatAdmin;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_blob_info
struct WINTRUST_BLOB_INFO
{
    uint         cbStruct;
    GUID         gSubject;
    const(PWSTR) pcwszDisplayName;
    uint         cbMemObject;
    ubyte*       pbMemObject;
    uint         cbMemSignedMsg;
    ubyte*       pbMemSignedMsg;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_sgnr_info
struct WINTRUST_SGNR_INFO
{
    uint              cbStruct;
    const(PWSTR)      pcwszDisplayName;
    CMSG_SIGNER_INFO* psSignerInfo;
    uint              chStores;
    HCERTSTORE*       pahStores;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_cert_info
struct WINTRUST_CERT_INFO
{
    uint          cbStruct;
    const(PWSTR)  pcwszDisplayName;
    CERT_CONTEXT* psCertContext;
    uint          chStores;
    HCERTSTORE*   pahStores;
    uint          dwFlags;
    FILETIME*     psftVerifyAsOf;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_data
struct CRYPT_PROVIDER_DATA
{
    uint                 cbStruct;
    WINTRUST_DATA*       pWintrustData;
    BOOL                 fOpenedFile;
    HWND                 hWndParent;
    GUID*                pgActionID;
    size_t               hProv;
    uint                 dwError;
    uint                 dwRegSecuritySettings;
    uint                 dwRegPolicySettings;
    CRYPT_PROVIDER_FUNCTIONS* psPfns;
    uint                 cdwTrustStepErrors;
    uint*                padwTrustStepErrors;
    uint                 chStores;
    HCERTSTORE*          pahStores;
    uint                 dwEncoding;
    void*                hMsg;
    uint                 csSigners;
    CRYPT_PROVIDER_SGNR* pasSigners;
    uint                 csProvPrivData;
    CRYPT_PROVIDER_PRIVDATA* pasProvPrivData;
    uint                 dwSubjectChoice;
    union
    {
        PROVDATA_SIP* pPDSip;
    }
    PSTR                 pszUsageOID;
    BOOL                 fRecallWithState;
    FILETIME             sftSystemTime;
    PSTR                 pszCTLSignerUsageOID;
    uint                 dwProvFlags;
    uint                 dwFinalError;
    CERT_USAGE_MATCH*    pRequestUsage;
    uint                 dwTrustPubSettings;
    uint                 dwUIStateFlags;
    CRYPT_PROVIDER_SIGSTATE* pSigState;
    WINTRUST_SIGNATURE_SETTINGS* pSigSettings;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_sigstate
struct CRYPT_PROVIDER_SIGSTATE
{
    uint   cbStruct;
    void** rhSecondarySigs;
    void*  hPrimarySig;
    BOOL   fFirstAttemptMade;
    BOOL   fNoMoreSigs;
    uint   cSecondarySigs;
    uint   dwCurrentIndex;
    BOOL   fSupportMultiSig;
    uint   dwCryptoPolicySupport;
    uint   iAttemptCount;
    BOOL   fCheckedSealing;
    SEALING_SIGNATURE_ATTRIBUTE* pSealingSignature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_functions
struct CRYPT_PROVIDER_FUNCTIONS
{
    uint                 cbStruct;
    PFN_CPD_MEM_ALLOC    pfnAlloc;
    PFN_CPD_MEM_FREE     pfnFree;
    PFN_CPD_ADD_STORE    pfnAddStore2Chain;
    PFN_CPD_ADD_SGNR     pfnAddSgnr2Chain;
    PFN_CPD_ADD_CERT     pfnAddCert2Chain;
    PFN_CPD_ADD_PRIVDATA pfnAddPrivData2Chain;
    PFN_PROVIDER_INIT_CALL pfnInitialize;
    PFN_PROVIDER_OBJTRUST_CALL pfnObjectTrust;
    PFN_PROVIDER_SIGTRUST_CALL pfnSignatureTrust;
    PFN_PROVIDER_CERTTRUST_CALL pfnCertificateTrust;
    PFN_PROVIDER_FINALPOLICY_CALL pfnFinalPolicy;
    PFN_PROVIDER_CERTCHKPOLICY_CALL pfnCertCheckPolicy;
    PFN_PROVIDER_TESTFINALPOLICY_CALL pfnTestFinalPolicy;
    CRYPT_PROVUI_FUNCS*  psUIpfns;
    PFN_PROVIDER_CLEANUP_CALL pfnCleanupPolicy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provui_funcs
struct CRYPT_PROVUI_FUNCS
{
    uint               cbStruct;
    CRYPT_PROVUI_DATA* psUIData;
    PFN_PROVUI_CALL    pfnOnMoreInfoClick;
    PFN_PROVUI_CALL    pfnOnMoreInfoClickDefault;
    PFN_PROVUI_CALL    pfnOnAdvancedClick;
    PFN_PROVUI_CALL    pfnOnAdvancedClickDefault;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provui_data
struct CRYPT_PROVUI_DATA
{
    uint  cbStruct;
    uint  dwFinalError;
    PWSTR pYesButtonText;
    PWSTR pNoButtonText;
    PWSTR pMoreInfoButtonText;
    PWSTR pAdvancedLinkText;
    PWSTR pCopyActionText;
    PWSTR pCopyActionTextNoTS;
    PWSTR pCopyActionTextNotSigned;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_sgnr
struct CRYPT_PROVIDER_SGNR
{
    uint                 cbStruct;
    FILETIME             sftVerifyAsOf;
    uint                 csCertChain;
    CRYPT_PROVIDER_CERT* pasCertChain;
    uint                 dwSignerType;
    CMSG_SIGNER_INFO*    psSigner;
    uint                 dwError;
    uint                 csCounterSigners;
    CRYPT_PROVIDER_SGNR* pasCounterSigners;
    CERT_CHAIN_CONTEXT*  pChainContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_cert
struct CRYPT_PROVIDER_CERT
{
    uint                 cbStruct;
    const(CERT_CONTEXT)* pCert;
    BOOL                 fCommercial;
    BOOL                 fTrustedRoot;
    BOOL                 fSelfSigned;
    BOOL                 fTestCert;
    uint                 dwRevokedReason;
    uint                 dwConfidence;
    uint                 dwError;
    CTL_CONTEXT*         pTrustListContext;
    BOOL                 fTrustListSignerCert;
    CTL_CONTEXT*         pCtlContext;
    uint                 dwCtlError;
    BOOL                 fIsCyclic;
    CERT_CHAIN_ELEMENT*  pChainElement;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_privdata
struct CRYPT_PROVIDER_PRIVDATA
{
    uint  cbStruct;
    GUID  gProviderID;
    uint  cbProvData;
    void* pvProvData;
}

struct PROVDATA_SIP
{
    uint               cbStruct;
    GUID               gSubject;
    SIP_DISPATCH_INFO* pSip;
    SIP_DISPATCH_INFO* pCATSip;
    SIP_SUBJECTINFO*   psSipSubjectInfo;
    SIP_SUBJECTINFO*   psSipCATSubjectInfo;
    SIP_INDIRECT_DATA* psIndirectData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_trust_reg_entry
struct CRYPT_TRUST_REG_ENTRY
{
    uint  cbStruct;
    PWSTR pwszDLLName;
    PWSTR pwszFunctionName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_register_actionid
struct CRYPT_REGISTER_ACTIONID
{
    uint cbStruct;
    CRYPT_TRUST_REG_ENTRY sInitProvider;
    CRYPT_TRUST_REG_ENTRY sObjectProvider;
    CRYPT_TRUST_REG_ENTRY sSignatureProvider;
    CRYPT_TRUST_REG_ENTRY sCertificateProvider;
    CRYPT_TRUST_REG_ENTRY sCertificatePolicyProvider;
    CRYPT_TRUST_REG_ENTRY sFinalPolicyProvider;
    CRYPT_TRUST_REG_ENTRY sTestPolicyProvider;
    CRYPT_TRUST_REG_ENTRY sCleanupProvider;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_regdefusage
struct CRYPT_PROVIDER_REGDEFUSAGE
{
    uint  cbStruct;
    GUID* pgActionID;
    PWSTR pwszDllName;
    PSTR  pwszLoadCallbackDataFunctionName;
    PSTR  pwszFreeCallbackDataFunctionName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_defusage
struct CRYPT_PROVIDER_DEFUSAGE
{
    uint  cbStruct;
    GUID  gActionID;
    void* pDefPolicyCallbackData;
    void* pDefSIPClientData;
}

struct SPC_SERIALIZED_OBJECT
{
    ubyte[16]          ClassId;
    CRYPT_INTEGER_BLOB SerializedData;
}

struct SPC_SIGINFO
{
    uint dwSipVersion;
    GUID gSIPGuid;
    uint dwReserved1;
    uint dwReserved2;
    uint dwReserved3;
    uint dwReserved4;
    uint dwReserved5;
}

struct SPC_LINK
{
    uint dwLinkChoice;
    union
    {
        PWSTR pwszUrl;
        SPC_SERIALIZED_OBJECT Moniker;
        PWSTR pwszFile;
    }
}

struct SPC_PE_IMAGE_DATA
{
    CRYPT_BIT_BLOB Flags;
    SPC_LINK*      pFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-spc_indirect_data_content
struct SPC_INDIRECT_DATA_CONTENT
{
    CRYPT_ATTRIBUTE_TYPE_VALUE Data;
    CRYPT_ALGORITHM_IDENTIFIER DigestAlgorithm;
    CRYPT_INTEGER_BLOB Digest;
}

struct SPC_FINANCIAL_CRITERIA
{
    BOOL fFinancialInfoAvailable;
    BOOL fMeetsCriteria;
}

struct SPC_IMAGE
{
    SPC_LINK*          pImageLink;
    CRYPT_INTEGER_BLOB Bitmap;
    CRYPT_INTEGER_BLOB Metafile;
    CRYPT_INTEGER_BLOB EnhancedMetafile;
    CRYPT_INTEGER_BLOB GifFile;
}

struct SPC_SP_AGENCY_INFO
{
    SPC_LINK*  pPolicyInformation;
    PWSTR      pwszPolicyDisplayText;
    SPC_IMAGE* pLogoImage;
    SPC_LINK*  pLogoLink;
}

struct SPC_STATEMENT_TYPE
{
    uint  cKeyPurposeId;
    PSTR* rgpszKeyPurposeId;
}

struct SPC_SP_OPUS_INFO
{
    const(PWSTR) pwszProgramName;
    SPC_LINK*    pMoreInfo;
    SPC_LINK*    pPublisherInfo;
}

struct CAT_NAMEVALUE
{
    PWSTR              pwszTag;
    uint               fdwFlags;
    CRYPT_INTEGER_BLOB Value;
}

struct CAT_MEMBERINFO
{
    PWSTR pwszSubjGuid;
    uint  dwCertVersion;
}

struct CAT_MEMBERINFO2
{
    GUID SubjectGuid;
    uint dwCertVersion;
}

struct INTENT_TO_SEAL_ATTRIBUTE
{
    uint    version_;
    BOOLEAN seal;
}

struct SEALING_SIGNATURE_ATTRIBUTE
{
    uint               version_;
    uint               signerIndex;
    CRYPT_ALGORITHM_IDENTIFIER signatureAlgorithm;
    CRYPT_INTEGER_BLOB encryptedDigest;
}

struct SEALING_TIMESTAMP_ATTRIBUTE
{
    uint               version_;
    uint               signerIndex;
    CRYPT_INTEGER_BLOB sealTimeStampToken;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-win_certificate
struct WIN_CERTIFICATE
{
    uint     dwLength;
    ushort   wRevision;
    ushort   wCertificateType;
    ubyte[1] bCertificate; // Flexible array
}

struct WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT
{
    HANDLE hClientToken;
    GUID*  SubjectType;
    void*  Subject;
}

struct WIN_TRUST_ACTDATA_SUBJECT_ONLY
{
    GUID* SubjectType;
    void* Subject;
}

struct WIN_TRUST_SUBJECT_FILE
{
    HANDLE       hFile;
    const(PWSTR) lpPath;
}

struct WIN_TRUST_SUBJECT_FILE_AND_DISPLAY
{
    HANDLE       hFile;
    const(PWSTR) lpPath;
    const(PWSTR) lpDisplayName;
}

struct WIN_SPUB_TRUSTED_PUBLISHER_DATA
{
    HANDLE           hClientToken;
    WIN_CERTIFICATE* lpCertificate;
}

struct WTD_GENERIC_CHAIN_POLICY_SIGNER_INFO
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    union
    {
        uint cbStruct;
        uint cbSize;
    }
    CERT_CHAIN_CONTEXT* pChainContext;
    uint                dwSignerType;
    CMSG_SIGNER_INFO*   pMsgSignerInfo;
    uint                dwError;
    uint                cCounterSigner;
    WTD_GENERIC_CHAIN_POLICY_SIGNER_INFO** rgpCounterSigner;
}

struct WTD_GENERIC_CHAIN_POLICY_CREATE_INFO
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    union
    {
        uint cbStruct;
        uint cbSize;
    }
    HCERTCHAINENGINE hChainEngine;
    CERT_CHAIN_PARA* pChainPara;
    uint             dwFlags;
    void*            pvReserved;
}

struct WTD_GENERIC_CHAIN_POLICY_DATA
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    union
    {
        uint cbStruct;
        uint cbSize;
    }
    WTD_GENERIC_CHAIN_POLICY_CREATE_INFO* pSignerChainInfo;
    WTD_GENERIC_CHAIN_POLICY_CREATE_INFO* pCounterSignerChainInfo;
    PFN_WTD_GENERIC_CHAIN_POLICY_CALLBACK pfnPolicyCallback;
    void* pvPolicyArg;
}

struct DRIVER_VER_MAJORMINOR
{
    uint dwMajor;
    uint dwMinor;
}

struct DRIVER_VER_INFO
{
    uint                 cbStruct;
    size_t               dwReserved1;
    size_t               dwReserved2;
    uint                 dwPlatform;
    uint                 dwVersion;
    wchar[260]           wszVersion;
    wchar[260]           wszSignedBy;
    const(CERT_CONTEXT)* pcSignerCertContext;
    DRIVER_VER_MAJORMINOR sOSVersionLow;
    DRIVER_VER_MAJORMINOR sOSVersionHigh;
    uint                 dwBuildNumberLow;
    uint                 dwBuildNumberHigh;
}

struct CONFIG_CI_PROV_INFO_RESULT
{
    HRESULT hr;
    uint    dwResult;
    uint    dwPolicyIndex;
    BOOLEAN fIsExplicitDeny;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CONFIG_CI_PROV_INFO_RESULT2
{
    uint    cbSize;
    HRESULT hr;
    uint    dwResult;
    uint    dwPolicyIndex;
    BOOLEAN fIsExplicitDeny;
    uint    cbCalculatedFileHash;
    ubyte*  pbCalculatedFileHash;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CONFIG_CI_PROV_INFO
{
    uint                cbSize;
    uint                dwPolicies;
    CRYPT_INTEGER_BLOB* pPolicies;
    CONFIG_CI_PROV_INFO_RESULT result;
    uint                dwScenario;
    CONFIG_CI_PROV_INFO_RESULT2* result2;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
int WinVerifyTrust(HWND hwnd, GUID* pgActionID, void* pWVTData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
int WinVerifyTrustEx(HWND hwnd, GUID* pgActionID, WINTRUST_DATA* pWinTrustData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
void WintrustGetRegPolicyFlags(WINTRUST_POLICY_FLAGS* pdwPolicyFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustSetRegPolicyFlags(WINTRUST_POLICY_FLAGS dwPolicyFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustAddActionID(GUID* pgActionID, uint fdwFlags, CRYPT_REGISTER_ACTIONID* psProvInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustRemoveActionID(GUID* pgActionID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustLoadFunctionPointers(GUID* pgActionID, CRYPT_PROVIDER_FUNCTIONS* pPfns);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustAddDefaultForUsage(const(PSTR) pszUsageOID, CRYPT_PROVIDER_REGDEFUSAGE* psDefUsage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustGetDefaultForUsage(WINTRUST_GET_DEFAULT_FOR_USAGE_ACTION dwAction, const(PSTR) pszUsageOID, 
                                CRYPT_PROVIDER_DEFUSAGE* psUsage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_SGNR* WTHelperGetProvSignerFromChain(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, 
                                                    BOOL fCounterSigner, uint idxCounterSigner);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_CERT* WTHelperGetProvCertFromChain(CRYPT_PROVIDER_SGNR* pSgnr, uint idxCert);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_DATA* WTHelperProvDataFromStateData(HANDLE hStateData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_PRIVDATA* WTHelperGetProvPrivateDataFromChain(CRYPT_PROVIDER_DATA* pProvData, GUID* pgProviderID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL WTHelperCertIsSelfSigned(uint dwEncoding, CERT_INFO* pCert);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WINTRUST.dll")
HRESULT WTHelperCertCheckValidSignature(CRYPT_PROVIDER_DATA* pProvData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL OpenPersonalTrustDBDialogEx(HWND hwndParent, uint dwFlags, void** pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL OpenPersonalTrustDBDialog(HWND hwndParent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WINTRUST.dll")
void WintrustSetDefaultIncludePEPageHashes(BOOL fIncludePEPageHashes);


