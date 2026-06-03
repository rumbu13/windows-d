// Written in the D programming language.

module windows.win32.security.authentication.webauthn;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT, HWND, PWSTR;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias EXPERIMENTAL_PLUGIN_AUTHENTICATOR_STATE = int;
enum : int
{
    PluginAuthenticatorState_Unknown  = 0x00000000,
    PluginAuthenticatorState_Disabled = 0x00000001,
    PluginAuthenticatorState_Enabled  = 0x00000002,
}

alias EXPERIMENTAL_WEBAUTHN_PLUGIN_PERFORM_UV_OPERATION_TYPE = int;
enum : int
{
    PerformUv  = 0x00000001,
    GetUvCount = 0x00000002,
    GetPubKey  = 0x00000003,
}

alias AUTHENTICATOR_STATE = int;
enum : int
{
    AuthenticatorState_Disabled = 0x00000000,
    AuthenticatorState_Enabled  = 0x00000001,
}

alias WEBAUTHN_PLUGIN_PERFORM_UV_OPERATION_TYPE = int;
enum : int
{
    PerformUserVerification  = 0x00000001,
    GetUserVerificationCount = 0x00000002,
    GetPublicKey             = 0x00000003,
}

alias WEBAUTHN_PLUGIN_REQUEST_TYPE = int;
enum : int
{
    WEBAUTHN_PLUGIN_REQUEST_TYPE_CTAP2_CBOR = 0x00000001,
}

alias PLUGIN_LOCK_STATUS = int;
enum : int
{
    PluginLocked   = 0x00000000,
    PluginUnlocked = 0x00000001,
}

// Constants


enum : uint
{
    WEBAUTHN_API_VERSION_1       = 0x00000001U,
    WEBAUTHN_API_VERSION_2       = 0x00000002U,
    WEBAUTHN_API_VERSION_3       = 0x00000003U,
    WEBAUTHN_API_VERSION_4       = 0x00000004U,
    WEBAUTHN_API_VERSION_5       = 0x00000005U,
    WEBAUTHN_API_VERSION_6       = 0x00000006U,
    WEBAUTHN_API_VERSION_7       = 0x00000007U,
    WEBAUTHN_API_VERSION_8       = 0x00000008U,
    WEBAUTHN_API_VERSION_9       = 0x00000009U,
    WEBAUTHN_API_CURRENT_VERSION = 0x00000009U,
}

enum : uint
{
    WEBAUTHN_RP_ENTITY_INFORMATION_VERSION_1       = 0x00000001U,
    WEBAUTHN_RP_ENTITY_INFORMATION_CURRENT_VERSION = 0x00000001U,
}

enum uint WEBAUTHN_MAX_USER_ID_LENGTH = 0x00000040U;

enum : uint
{
    WEBAUTHN_USER_ENTITY_INFORMATION_VERSION_1       = 0x00000001U,
    WEBAUTHN_USER_ENTITY_INFORMATION_CURRENT_VERSION = 0x00000001U,
}

enum : const(wchar)*
{
    WEBAUTHN_HASH_ALGORITHM_SHA_256 = "SHA-256",
    WEBAUTHN_HASH_ALGORITHM_SHA_384 = "SHA-384",
    WEBAUTHN_HASH_ALGORITHM_SHA_512 = "SHA-512",
}

enum uint WEBAUTHN_CLIENT_DATA_CURRENT_VERSION = 0x00000001U;
enum const(wchar)* WEBAUTHN_CREDENTIAL_TYPE_PUBLIC_KEY = "public-key";

enum : int
{
    WEBAUTHN_COSE_ALGORITHM_ECDSA_P256_WITH_SHA256        = 0xfffffff9,
    WEBAUTHN_COSE_ALGORITHM_ECDSA_P384_WITH_SHA384        = 0xffffffdd,
    WEBAUTHN_COSE_ALGORITHM_ECDSA_P521_WITH_SHA512        = 0xffffffdc,
    WEBAUTHN_COSE_ALGORITHM_RSASSA_PKCS1_V1_5_WITH_SHA256 = 0xfffffeff,
    WEBAUTHN_COSE_ALGORITHM_RSASSA_PKCS1_V1_5_WITH_SHA384 = 0xfffffefe,
    WEBAUTHN_COSE_ALGORITHM_RSASSA_PKCS1_V1_5_WITH_SHA512 = 0xfffffefd,
    WEBAUTHN_COSE_ALGORITHM_RSA_PSS_WITH_SHA256           = 0xffffffdb,
    WEBAUTHN_COSE_ALGORITHM_RSA_PSS_WITH_SHA384           = 0xffffffda,
    WEBAUTHN_COSE_ALGORITHM_RSA_PSS_WITH_SHA512           = 0xffffffd9,
}

enum uint WEBAUTHN_COSE_CREDENTIAL_PARAMETER_CURRENT_VERSION = 0x00000001U;
enum uint WEBAUTHN_CREDENTIAL_CURRENT_VERSION = 0x00000001U;

enum : uint
{
    WEBAUTHN_CTAP_TRANSPORT_USB        = 0x00000001U,
    WEBAUTHN_CTAP_TRANSPORT_NFC        = 0x00000002U,
    WEBAUTHN_CTAP_TRANSPORT_BLE        = 0x00000004U,
    WEBAUTHN_CTAP_TRANSPORT_TEST       = 0x00000008U,
    WEBAUTHN_CTAP_TRANSPORT_INTERNAL   = 0x00000010U,
    WEBAUTHN_CTAP_TRANSPORT_HYBRID     = 0x00000020U,
    WEBAUTHN_CTAP_TRANSPORT_SMART_CARD = 0x00000040U,
    WEBAUTHN_CTAP_TRANSPORT_FLAGS_MASK = 0x0000007fU,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    WEBAUTHN_CTAP_TRANSPORT_USB_STRING        = "usb",
    // Native encoding: ansi
    WEBAUTHN_CTAP_TRANSPORT_NFC_STRING        = "nfc",
    // Native encoding: ansi
    WEBAUTHN_CTAP_TRANSPORT_BLE_STRING        = "ble",
    // Native encoding: ansi
    WEBAUTHN_CTAP_TRANSPORT_SMART_CARD_STRING = "smart-card",
    // Native encoding: ansi
    WEBAUTHN_CTAP_TRANSPORT_HYBRID_STRING     = "hybrid",
    // Native encoding: ansi
    WEBAUTHN_CTAP_TRANSPORT_INTERNAL_STRING   = "internal",
}

enum uint WEBAUTHN_CREDENTIAL_EX_CURRENT_VERSION = 0x00000001U;

enum : uint
{
    CTAPCBOR_HYBRID_STORAGE_LINKED_DATA_VERSION_1       = 0x00000001U,
    CTAPCBOR_HYBRID_STORAGE_LINKED_DATA_CURRENT_VERSION = 0x00000001U,
}

enum : uint
{
    WEBAUTHN_AUTHENTICATOR_DETAILS_OPTIONS_VERSION_1       = 0x00000001U,
    WEBAUTHN_AUTHENTICATOR_DETAILS_OPTIONS_CURRENT_VERSION = 0x00000001U,
    WEBAUTHN_AUTHENTICATOR_DETAILS_VERSION_1               = 0x00000001U,
    WEBAUTHN_AUTHENTICATOR_DETAILS_CURRENT_VERSION         = 0x00000001U,
}

enum : uint
{
    WEBAUTHN_CREDENTIAL_DETAILS_VERSION_1       = 0x00000001U,
    WEBAUTHN_CREDENTIAL_DETAILS_VERSION_2       = 0x00000002U,
    WEBAUTHN_CREDENTIAL_DETAILS_VERSION_3       = 0x00000003U,
    WEBAUTHN_CREDENTIAL_DETAILS_VERSION_4       = 0x00000004U,
    WEBAUTHN_CREDENTIAL_DETAILS_CURRENT_VERSION = 0x00000004U,
}

enum : uint
{
    WEBAUTHN_GET_CREDENTIALS_OPTIONS_VERSION_1       = 0x00000001U,
    WEBAUTHN_GET_CREDENTIALS_OPTIONS_CURRENT_VERSION = 0x00000001U,
}

enum uint WEBAUTHN_CTAP_ONE_HMAC_SECRET_LENGTH = 0x00000020U;
enum const(wchar)* WEBAUTHN_EXTENSIONS_IDENTIFIER_HMAC_SECRET = "hmac-secret";

enum : uint
{
    WEBAUTHN_USER_VERIFICATION_ANY                              = 0x00000000U,
    WEBAUTHN_USER_VERIFICATION_OPTIONAL                         = 0x00000001U,
    WEBAUTHN_USER_VERIFICATION_OPTIONAL_WITH_CREDENTIAL_ID_LIST = 0x00000002U,
    WEBAUTHN_USER_VERIFICATION_REQUIRED                         = 0x00000003U,
}

enum : const(wchar)*
{
    WEBAUTHN_EXTENSIONS_IDENTIFIER_CRED_PROTECT   = "credProtect",
    WEBAUTHN_EXTENSIONS_IDENTIFIER_CRED_BLOB      = "credBlob",
    WEBAUTHN_EXTENSIONS_IDENTIFIER_MIN_PIN_LENGTH = "minPinLength",
}

enum : uint
{
    WEBAUTHN_AUTHENTICATOR_ATTACHMENT_ANY                   = 0x00000000U,
    WEBAUTHN_AUTHENTICATOR_ATTACHMENT_PLATFORM              = 0x00000001U,
    WEBAUTHN_AUTHENTICATOR_ATTACHMENT_CROSS_PLATFORM        = 0x00000002U,
    WEBAUTHN_AUTHENTICATOR_ATTACHMENT_CROSS_PLATFORM_U2F_V2 = 0x00000003U,
}

enum : uint
{
    WEBAUTHN_USER_VERIFICATION_REQUIREMENT_ANY         = 0x00000000U,
    WEBAUTHN_USER_VERIFICATION_REQUIREMENT_REQUIRED    = 0x00000001U,
    WEBAUTHN_USER_VERIFICATION_REQUIREMENT_PREFERRED   = 0x00000002U,
    WEBAUTHN_USER_VERIFICATION_REQUIREMENT_DISCOURAGED = 0x00000003U,
}

enum : uint
{
    WEBAUTHN_ATTESTATION_CONVEYANCE_PREFERENCE_ANY      = 0x00000000U,
    WEBAUTHN_ATTESTATION_CONVEYANCE_PREFERENCE_NONE     = 0x00000001U,
    WEBAUTHN_ATTESTATION_CONVEYANCE_PREFERENCE_INDIRECT = 0x00000002U,
    WEBAUTHN_ATTESTATION_CONVEYANCE_PREFERENCE_DIRECT   = 0x00000003U,
}

enum : uint
{
    WEBAUTHN_ENTERPRISE_ATTESTATION_NONE               = 0x00000000U,
    WEBAUTHN_ENTERPRISE_ATTESTATION_VENDOR_FACILITATED = 0x00000001U,
    WEBAUTHN_ENTERPRISE_ATTESTATION_PLATFORM_MANAGED   = 0x00000002U,
}

enum : uint
{
    WEBAUTHN_LARGE_BLOB_SUPPORT_NONE      = 0x00000000U,
    WEBAUTHN_LARGE_BLOB_SUPPORT_REQUIRED  = 0x00000001U,
    WEBAUTHN_LARGE_BLOB_SUPPORT_PREFERRED = 0x00000002U,
}

enum : const(wchar)*
{
    WEBAUTHN_CREDENTIAL_HINT_SECURITY_KEY  = "security-key",
    WEBAUTHN_CREDENTIAL_HINT_CLIENT_DEVICE = "client-device",
    WEBAUTHN_CREDENTIAL_HINT_HYBRID        = "hybrid",
}

enum : uint
{
    WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS_VERSION_1       = 0x00000001U,
    WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS_VERSION_2       = 0x00000002U,
    WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS_VERSION_3       = 0x00000003U,
    WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS_VERSION_4       = 0x00000004U,
    WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS_VERSION_5       = 0x00000005U,
    WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS_VERSION_6       = 0x00000006U,
    WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS_VERSION_7       = 0x00000007U,
    WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS_VERSION_8       = 0x00000008U,
    WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS_VERSION_9       = 0x00000009U,
    WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS_CURRENT_VERSION = 0x00000009U,
}

enum : uint
{
    WEBAUTHN_CRED_LARGE_BLOB_OPERATION_NONE   = 0x00000000U,
    WEBAUTHN_CRED_LARGE_BLOB_OPERATION_GET    = 0x00000001U,
    WEBAUTHN_CRED_LARGE_BLOB_OPERATION_SET    = 0x00000002U,
    WEBAUTHN_CRED_LARGE_BLOB_OPERATION_DELETE = 0x00000003U,
}

enum : uint
{
    WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS_VERSION_1       = 0x00000001U,
    WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS_VERSION_2       = 0x00000002U,
    WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS_VERSION_3       = 0x00000003U,
    WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS_VERSION_4       = 0x00000004U,
    WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS_VERSION_5       = 0x00000005U,
    WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS_VERSION_6       = 0x00000006U,
    WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS_VERSION_7       = 0x00000007U,
    WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS_VERSION_8       = 0x00000008U,
    WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS_VERSION_9       = 0x00000009U,
    WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS_CURRENT_VERSION = 0x00000009U,
}

enum uint WEBAUTHN_AUTHENTICATOR_HMAC_SECRET_VALUES_FLAG = 0x00100000U;

enum : uint
{
    WEBAUTHN_ATTESTATION_DECODE_NONE   = 0x00000000U,
    WEBAUTHN_ATTESTATION_DECODE_COMMON = 0x00000001U,
}

enum const(wchar)* WEBAUTHN_ATTESTATION_VER_TPM_2_0 = "2.0";
enum uint WEBAUTHN_COMMON_ATTESTATION_CURRENT_VERSION = 0x00000001U;

enum : const(wchar)*
{
    WEBAUTHN_ATTESTATION_TYPE_PACKED = "packed",
    WEBAUTHN_ATTESTATION_TYPE_U2F    = "fido-u2f",
    WEBAUTHN_ATTESTATION_TYPE_TPM    = "tpm",
    WEBAUTHN_ATTESTATION_TYPE_NONE   = "none",
}

enum : uint
{
    WEBAUTHN_CREDENTIAL_ATTESTATION_VERSION_1       = 0x00000001U,
    WEBAUTHN_CREDENTIAL_ATTESTATION_VERSION_2       = 0x00000002U,
    WEBAUTHN_CREDENTIAL_ATTESTATION_VERSION_3       = 0x00000003U,
    WEBAUTHN_CREDENTIAL_ATTESTATION_VERSION_4       = 0x00000004U,
    WEBAUTHN_CREDENTIAL_ATTESTATION_VERSION_5       = 0x00000005U,
    WEBAUTHN_CREDENTIAL_ATTESTATION_VERSION_6       = 0x00000006U,
    WEBAUTHN_CREDENTIAL_ATTESTATION_VERSION_7       = 0x00000007U,
    WEBAUTHN_CREDENTIAL_ATTESTATION_VERSION_8       = 0x00000008U,
    WEBAUTHN_CREDENTIAL_ATTESTATION_CURRENT_VERSION = 0x00000008U,
}

enum : uint
{
    WEBAUTHN_CRED_LARGE_BLOB_STATUS_NONE                 = 0x00000000U,
    WEBAUTHN_CRED_LARGE_BLOB_STATUS_SUCCESS              = 0x00000001U,
    WEBAUTHN_CRED_LARGE_BLOB_STATUS_NOT_SUPPORTED        = 0x00000002U,
    WEBAUTHN_CRED_LARGE_BLOB_STATUS_INVALID_DATA         = 0x00000003U,
    WEBAUTHN_CRED_LARGE_BLOB_STATUS_INVALID_PARAMETER    = 0x00000004U,
    WEBAUTHN_CRED_LARGE_BLOB_STATUS_NOT_FOUND            = 0x00000005U,
    WEBAUTHN_CRED_LARGE_BLOB_STATUS_MULTIPLE_CREDENTIALS = 0x00000006U,
    WEBAUTHN_CRED_LARGE_BLOB_STATUS_LACK_OF_SPACE        = 0x00000007U,
    WEBAUTHN_CRED_LARGE_BLOB_STATUS_PLATFORM_ERROR       = 0x00000008U,
    WEBAUTHN_CRED_LARGE_BLOB_STATUS_AUTHENTICATOR_ERROR  = 0x00000009U,
}

enum : uint
{
    WEBAUTHN_ASSERTION_VERSION_1       = 0x00000001U,
    WEBAUTHN_ASSERTION_VERSION_2       = 0x00000002U,
    WEBAUTHN_ASSERTION_VERSION_3       = 0x00000003U,
    WEBAUTHN_ASSERTION_VERSION_4       = 0x00000004U,
    WEBAUTHN_ASSERTION_VERSION_5       = 0x00000005U,
    WEBAUTHN_ASSERTION_VERSION_6       = 0x00000006U,
    WEBAUTHN_ASSERTION_CURRENT_VERSION = 0x00000006U,
}

enum : uint
{
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS_VERSION_1         = 0x00000001U,
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS_CURRENT_VERSION   = 0x00000001U,
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY_VERSION_1                = 0x00000001U,
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY_CURRENT_VERSION          = 0x00000001U,
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION_VERSION_1           = 0x00000001U,
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION_CURRENT_VERSION     = 0x00000001U,
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_MAKE_CREDENTIAL_REQUEST_VERSION_1       = 0x00000001U,
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_MAKE_CREDENTIAL_REQUEST_CURRENT_VERSION = 0x00000001U,
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_GET_ASSERTION_REQUEST_VERSION_1         = 0x00000001U,
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_GET_ASSERTION_REQUEST_CURRENT_VERSION   = 0x00000001U,
}

enum : uint
{
    WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS_VERSION_1       = 0x00000001U,
    WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS_CURRENT_VERSION = 0x00000001U,
}

enum : uint
{
    WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY_VERSION_1       = 0x00000001U,
    WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY_CURRENT_VERSION = 0x00000001U,
}

enum : uint
{
    WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION_VERSION_1       = 0x00000001U,
    WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION_CURRENT_VERSION = 0x00000001U,
}

enum : uint
{
    WEBAUTHN_CTAPCBOR_MAKE_CREDENTIAL_REQUEST_VERSION_1       = 0x00000001U,
    WEBAUTHN_CTAPCBOR_MAKE_CREDENTIAL_REQUEST_CURRENT_VERSION = 0x00000001U,
}

enum : uint
{
    WEBAUTHN_CTAPCBOR_GET_ASSERTION_REQUEST_VERSION_1       = 0x00000001U,
    WEBAUTHN_CTAPCBOR_GET_ASSERTION_REQUEST_CURRENT_VERSION = 0x00000001U,
}

// Callbacks

alias EXPERIMENTAL_WEBAUTHN_PLUGIN_STATUS_CHANGE_CALLBACK = void function(void* context);
alias WEBAUTHN_PLUGIN_STATUS_CHANGE_CALLBACK = void function(void* context);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_rp_entity_information
struct WEBAUTHN_RP_ENTITY_INFORMATION
{
    uint         dwVersion;
    const(PWSTR) pwszId;
    const(PWSTR) pwszName;
    const(PWSTR) pwszIcon;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_user_entity_information
struct WEBAUTHN_USER_ENTITY_INFORMATION
{
    uint         dwVersion;
    uint         cbId;
    ubyte*       pbId;
    const(PWSTR) pwszName;
    const(PWSTR) pwszIcon;
    const(PWSTR) pwszDisplayName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_client_data
struct WEBAUTHN_CLIENT_DATA
{
    uint         dwVersion;
    uint         cbClientDataJSON;
    ubyte*       pbClientDataJSON;
    const(PWSTR) pwszHashAlgId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_cose_credential_parameter
struct WEBAUTHN_COSE_CREDENTIAL_PARAMETER
{
    uint         dwVersion;
    const(PWSTR) pwszCredentialType;
    int          lAlg;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_cose_credential_parameters
struct WEBAUTHN_COSE_CREDENTIAL_PARAMETERS
{
    uint cCredentialParameters;
    WEBAUTHN_COSE_CREDENTIAL_PARAMETER* pCredentialParameters;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_credential
struct WEBAUTHN_CREDENTIAL
{
    uint         dwVersion;
    uint         cbId;
    ubyte*       pbId;
    const(PWSTR) pwszCredentialType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_credentials
struct WEBAUTHN_CREDENTIALS
{
    uint                 cCredentials;
    WEBAUTHN_CREDENTIAL* pCredentials;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_credential_ex
struct WEBAUTHN_CREDENTIAL_EX
{
    uint         dwVersion;
    uint         cbId;
    ubyte*       pbId;
    const(PWSTR) pwszCredentialType;
    uint         dwTransports;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_credential_list
struct WEBAUTHN_CREDENTIAL_LIST
{
    uint cCredentials;
    WEBAUTHN_CREDENTIAL_EX** ppCredentials;
}

struct CTAPCBOR_HYBRID_STORAGE_LINKED_DATA
{
    uint         dwVersion;
    uint         cbContactId;
    ubyte*       pbContactId;
    uint         cbLinkId;
    ubyte*       pbLinkId;
    uint         cbLinkSecret;
    ubyte*       pbLinkSecret;
    uint         cbPublicKey;
    ubyte*       pbPublicKey;
    const(PWSTR) pwszAuthenticatorName;
    ushort       wEncodedTunnelServerDomain;
}

struct WEBAUTHN_AUTHENTICATOR_DETAILS_OPTIONS
{
    uint dwVersion;
}

struct WEBAUTHN_AUTHENTICATOR_DETAILS
{
    uint         dwVersion;
    uint         cbAuthenticatorId;
    ubyte*       pbAuthenticatorId;
    const(PWSTR) pwszAuthenticatorName;
    uint         cbAuthenticatorLogo;
    ubyte*       pbAuthenticatorLogo;
    BOOL         bLocked;
}

struct WEBAUTHN_AUTHENTICATOR_DETAILS_LIST
{
    uint cAuthenticatorDetails;
    WEBAUTHN_AUTHENTICATOR_DETAILS** ppAuthenticatorDetails;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_credential_details
struct WEBAUTHN_CREDENTIAL_DETAILS
{
    uint         dwVersion;
    uint         cbCredentialID;
    ubyte*       pbCredentialID;
    WEBAUTHN_RP_ENTITY_INFORMATION* pRpInformation;
    WEBAUTHN_USER_ENTITY_INFORMATION* pUserInformation;
    BOOL         bRemovable;
    BOOL         bBackedUp;
    const(PWSTR) pwszAuthenticatorName;
    uint         cbAuthenticatorLogo;
    ubyte*       pbAuthenticatorLogo;
    BOOL         bThirdPartyPayment;
    uint         dwTransports;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_credential_details_list
struct WEBAUTHN_CREDENTIAL_DETAILS_LIST
{
    uint cCredentialDetails;
    WEBAUTHN_CREDENTIAL_DETAILS** ppCredentialDetails;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_get_credentials_options
struct WEBAUTHN_GET_CREDENTIALS_OPTIONS
{
    uint         dwVersion;
    const(PWSTR) pwszRpId;
    BOOL         bBrowserInPrivateMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_hmac_secret_salt
struct WEBAUTHN_HMAC_SECRET_SALT
{
    uint   cbFirst;
    ubyte* pbFirst;
    uint   cbSecond;
    ubyte* pbSecond;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_cred_with_hmac_secret_salt
struct WEBAUTHN_CRED_WITH_HMAC_SECRET_SALT
{
    uint   cbCredID;
    ubyte* pbCredID;
    WEBAUTHN_HMAC_SECRET_SALT* pHmacSecretSalt;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_hmac_secret_salt_values
struct WEBAUTHN_HMAC_SECRET_SALT_VALUES
{
    WEBAUTHN_HMAC_SECRET_SALT* pGlobalHmacSalt;
    uint cCredWithHmacSecretSaltList;
    WEBAUTHN_CRED_WITH_HMAC_SECRET_SALT* pCredWithHmacSecretSaltList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_cred_protect_extension_in
struct WEBAUTHN_CRED_PROTECT_EXTENSION_IN
{
    uint dwCredProtect;
    BOOL bRequireCredProtect;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_cred_blob_extension
struct WEBAUTHN_CRED_BLOB_EXTENSION
{
    uint   cbCredBlob;
    ubyte* pbCredBlob;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_extension
struct WEBAUTHN_EXTENSION
{
    const(PWSTR) pwszExtensionIdentifier;
    uint         cbExtension;
    void*        pvExtension;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_extensions
struct WEBAUTHN_EXTENSIONS
{
    uint                cExtensions;
    WEBAUTHN_EXTENSION* pExtensions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_authenticator_make_credential_options
struct WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS
{
    uint                 dwVersion;
    uint                 dwTimeoutMilliseconds;
    WEBAUTHN_CREDENTIALS CredentialList;
    WEBAUTHN_EXTENSIONS  Extensions;
    uint                 dwAuthenticatorAttachment;
    BOOL                 bRequireResidentKey;
    uint                 dwUserVerificationRequirement;
    uint                 dwAttestationConveyancePreference;
    uint                 dwFlags;
    GUID*                pCancellationId;
    WEBAUTHN_CREDENTIAL_LIST* pExcludeCredentialList;
    uint                 dwEnterpriseAttestation;
    uint                 dwLargeBlobSupport;
    BOOL                 bPreferResidentKey;
    BOOL                 bBrowserInPrivateMode;
    BOOL                 bEnablePrf;
    CTAPCBOR_HYBRID_STORAGE_LINKED_DATA* pLinkedDevice;
    uint                 cbJsonExt;
    ubyte*               pbJsonExt;
    WEBAUTHN_HMAC_SECRET_SALT* pPRFGlobalEval;
    uint                 cCredentialHints;
    const(PWSTR)*        ppwszCredentialHints;
    BOOL                 bThirdPartyPayment;
    const(PWSTR)         pwszRemoteWebOrigin;
    uint                 cbPublicKeyCredentialCreationOptionsJSON;
    ubyte*               pbPublicKeyCredentialCreationOptionsJSON;
    uint                 cbAuthenticatorId;
    ubyte*               pbAuthenticatorId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_authenticator_get_assertion_options
struct WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS
{
    uint                 dwVersion;
    uint                 dwTimeoutMilliseconds;
    WEBAUTHN_CREDENTIALS CredentialList;
    WEBAUTHN_EXTENSIONS  Extensions;
    uint                 dwAuthenticatorAttachment;
    uint                 dwUserVerificationRequirement;
    uint                 dwFlags;
    const(PWSTR)         pwszU2fAppId;
    BOOL*                pbU2fAppId;
    GUID*                pCancellationId;
    WEBAUTHN_CREDENTIAL_LIST* pAllowCredentialList;
    uint                 dwCredLargeBlobOperation;
    uint                 cbCredLargeBlob;
    ubyte*               pbCredLargeBlob;
    WEBAUTHN_HMAC_SECRET_SALT_VALUES* pHmacSecretSaltValues;
    BOOL                 bBrowserInPrivateMode;
    CTAPCBOR_HYBRID_STORAGE_LINKED_DATA* pLinkedDevice;
    BOOL                 bAutoFill;
    uint                 cbJsonExt;
    ubyte*               pbJsonExt;
    uint                 cCredentialHints;
    const(PWSTR)*        ppwszCredentialHints;
    const(PWSTR)         pwszRemoteWebOrigin;
    uint                 cbPublicKeyCredentialRequestOptionsJSON;
    ubyte*               pbPublicKeyCredentialRequestOptionsJSON;
    uint                 cbAuthenticatorId;
    ubyte*               pbAuthenticatorId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_x5c
struct WEBAUTHN_X5C
{
    uint   cbData;
    ubyte* pbData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_common_attestation
struct WEBAUTHN_COMMON_ATTESTATION
{
    uint          dwVersion;
    const(PWSTR)  pwszAlg;
    int           lAlg;
    uint          cbSignature;
    ubyte*        pbSignature;
    uint          cX5c;
    WEBAUTHN_X5C* pX5c;
    const(PWSTR)  pwszVer;
    uint          cbCertInfo;
    ubyte*        pbCertInfo;
    uint          cbPubArea;
    ubyte*        pbPubArea;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_credential_attestation
struct WEBAUTHN_CREDENTIAL_ATTESTATION
{
    uint                dwVersion;
    const(PWSTR)        pwszFormatType;
    uint                cbAuthenticatorData;
    ubyte*              pbAuthenticatorData;
    uint                cbAttestation;
    ubyte*              pbAttestation;
    uint                dwAttestationDecodeType;
    void*               pvAttestationDecode;
    uint                cbAttestationObject;
    ubyte*              pbAttestationObject;
    uint                cbCredentialId;
    ubyte*              pbCredentialId;
    WEBAUTHN_EXTENSIONS Extensions;
    uint                dwUsedTransport;
    BOOL                bEpAtt;
    BOOL                bLargeBlobSupported;
    BOOL                bResidentKey;
    BOOL                bPrfEnabled;
    uint                cbUnsignedExtensionOutputs;
    ubyte*              pbUnsignedExtensionOutputs;
    WEBAUTHN_HMAC_SECRET_SALT* pHmacSecret;
    BOOL                bThirdPartyPayment;
    uint                dwTransports;
    uint                cbClientDataJSON;
    ubyte*              pbClientDataJSON;
    uint                cbRegistrationResponseJSON;
    ubyte*              pbRegistrationResponseJSON;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/ns-webauthn-webauthn_assertion
struct WEBAUTHN_ASSERTION
{
    uint                dwVersion;
    uint                cbAuthenticatorData;
    ubyte*              pbAuthenticatorData;
    uint                cbSignature;
    ubyte*              pbSignature;
    WEBAUTHN_CREDENTIAL Credential;
    uint                cbUserId;
    ubyte*              pbUserId;
    WEBAUTHN_EXTENSIONS Extensions;
    uint                cbCredLargeBlob;
    ubyte*              pbCredLargeBlob;
    uint                dwCredLargeBlobStatus;
    WEBAUTHN_HMAC_SECRET_SALT* pHmacSecret;
    uint                dwUsedTransport;
    uint                cbUnsignedExtensionOutputs;
    ubyte*              pbUnsignedExtensionOutputs;
    uint                cbClientDataJSON;
    ubyte*              pbClientDataJSON;
    uint                cbAuthenticationResponseJSON;
    ubyte*              pbAuthenticationResponseJSON;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_ADD_AUTHENTICATOR_OPTIONS
{
    const(PWSTR) pwszAuthenticatorName;
    const(PWSTR) pwszPluginClsId;
    const(PWSTR) pwszPluginRpId;
    const(PWSTR) pwszLightThemeLogo;
    const(PWSTR) pwszDarkThemeLogo;
    uint         cbAuthenticatorInfo;
    ubyte*       pbAuthenticatorInfo;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_ADD_AUTHENTICATOR_RESPONSE
{
    uint   cbOpSignPubKey;
    ubyte* pbOpSignPubKey;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_UPDATE_AUTHENTICATOR_DETAILS
{
    const(PWSTR) pwszAuthenticatorName;
    const(PWSTR) pwszPluginClsId;
    const(PWSTR) pwszNewPluginClsId;
    const(PWSTR) pwszLightThemeLogo;
    const(PWSTR) pwszDarkThemeLogo;
    uint         cbAuthenticatorInfo;
    ubyte*       pbAuthenticatorInfo;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_CREDENTIAL_DETAILS
{
    uint   cbCredentialId;
    ubyte* pbCredentialId;
    PWSTR  pwszRpId;
    PWSTR  pwszRpName;
    uint   cbUserId;
    ubyte* pbUserId;
    PWSTR  pwszUserName;
    PWSTR  pwszUserDisplayName;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_CREDENTIAL_DETAILS_LIST
{
    PWSTR pwszPluginClsId;
    uint  cCredentialDetails;
    EXPERIMENTAL_WEBAUTHN_PLUGIN_CREDENTIAL_DETAILS** pCredentialDetails;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_PERFORM_UV
{
    HWND         hwnd;
    GUID*        transactionId;
    EXPERIMENTAL_WEBAUTHN_PLUGIN_PERFORM_UV_OPERATION_TYPE type;
    const(PWSTR) pwszUsername;
    const(PWSTR) pwszContext;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_PERFORM_UV_RESPONSE
{
    uint   cbResponse;
    ubyte* pbResponse;
}

struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS
{
    uint dwVersion;
    int  lUp;
    int  lUv;
    int  lRequireResidentKey;
}

struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY
{
    uint   dwVersion;
    int    lKty;
    int    lAlg;
    int    lCrv;
    uint   cbX;
    ubyte* pbX;
    uint   cbY;
    ubyte* pbY;
}

struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION
{
    uint   dwVersion;
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY* pKeyAgreement;
    uint   cbEncryptedSalt;
    ubyte* pbEncryptedSalt;
    uint   cbSaltAuth;
    ubyte* pbSaltAuth;
}

struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_MAKE_CREDENTIAL_REQUEST
{
    uint   dwVersion;
    uint   cbRpId;
    ubyte* pbRpId;
    uint   cbClientDataHash;
    ubyte* pbClientDataHash;
    WEBAUTHN_RP_ENTITY_INFORMATION* pRpInformation;
    WEBAUTHN_USER_ENTITY_INFORMATION* pUserInformation;
    WEBAUTHN_COSE_CREDENTIAL_PARAMETERS WebAuthNCredentialParameters;
    WEBAUTHN_CREDENTIAL_LIST CredentialList;
    uint   cbCborExtensionsMap;
    ubyte* pbCborExtensionsMap;
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS* pAuthenticatorOptions;
    BOOL   fEmptyPinAuth;
    uint   cbPinAuth;
    ubyte* pbPinAuth;
    int    lHmacSecretExt;
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION* pHmacSecretMcExtension;
    int    lPrfExt;
    uint   cbHmacSecretSaltValues;
    ubyte* pbHmacSecretSaltValues;
    uint   dwCredProtect;
    uint   dwPinProtocol;
    uint   dwEnterpriseAttestation;
    uint   cbCredBlobExt;
    ubyte* pbCredBlobExt;
    int    lLargeBlobKeyExt;
    uint   dwLargeBlobSupport;
    int    lMinPinLengthExt;
    uint   cbJsonExt;
    ubyte* pbJsonExt;
}

struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_GET_ASSERTION_REQUEST
{
    uint         dwVersion;
    const(PWSTR) pwszRpId;
    uint         cbRpId;
    ubyte*       pbRpId;
    uint         cbClientDataHash;
    ubyte*       pbClientDataHash;
    WEBAUTHN_CREDENTIAL_LIST CredentialList;
    uint         cbCborExtensionsMap;
    ubyte*       pbCborExtensionsMap;
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS* pAuthenticatorOptions;
    BOOL         fEmptyPinAuth;
    uint         cbPinAuth;
    ubyte*       pbPinAuth;
    EXPERIMENTAL_WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION* pHmacSaltExtension;
    uint         cbHmacSecretSaltValues;
    ubyte*       pbHmacSecretSaltValues;
    uint         dwPinProtocol;
    int          lCredBlobExt;
    int          lLargeBlobKeyExt;
    uint         dwCredLargeBlobOperation;
    uint         cbCredLargeBlobCompressed;
    ubyte*       pbCredLargeBlobCompressed;
    uint         dwCredLargeBlobOriginalSize;
    uint         cbJsonExt;
    ubyte*       pbJsonExt;
}

struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_GET_ASSERTION_RESPONSE
{
    WEBAUTHN_ASSERTION WebAuthNAssertion;
    WEBAUTHN_USER_ENTITY_INFORMATION* pUserInformation;
    uint               dwNumberOfCredentials;
    int                lUserSelected;
    uint               cbLargeBlobKey;
    ubyte*             pbLargeBlobKey;
    uint               cbUnsignedExtensionOutputs;
    ubyte*             pbUnsignedExtensionOutputs;
}

struct WEBAUTHN_PLUGIN_ADD_AUTHENTICATOR_OPTIONS
{
    const(PWSTR)  pwszAuthenticatorName;
    const(GUID)*  rclsid;
    const(PWSTR)  pwszPluginRpId;
    const(PWSTR)  pwszLightThemeLogoSvg;
    const(PWSTR)  pwszDarkThemeLogoSvg;
    uint          cbAuthenticatorInfo;
    const(ubyte)* pbAuthenticatorInfo;
    uint          cSupportedRpIds;
    const(PWSTR)* ppwszSupportedRpIds;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_ADD_AUTHENTICATOR_OPTIONS_2
{
    const(PWSTR)  pwszAuthenticatorName;
    const(GUID)*  pClsid;
    const(PWSTR)  pwszPluginRpId;
    const(PWSTR)  pwszLightThemeLogoSvg;
    const(PWSTR)  pwszDarkThemeLogoSvg;
    uint          cbAuthenticatorInfo;
    const(ubyte)* pbAuthenticatorInfo;
    uint          cSupportedRpIds;
    const(PWSTR)* ppwszSupportedRpIds;
    const(PWSTR)  pwszUserVerificationKeyName;
}

struct WEBAUTHN_PLUGIN_ADD_AUTHENTICATOR_RESPONSE
{
    uint   cbOpSignPubKey;
    ubyte* pbOpSignPubKey;
}

struct WEBAUTHN_PLUGIN_UPDATE_AUTHENTICATOR_DETAILS
{
    const(PWSTR)  pwszAuthenticatorName;
    const(GUID)*  rclsid;
    const(GUID)*  rclsidNew;
    const(PWSTR)  pwszLightThemeLogoSvg;
    const(PWSTR)  pwszDarkThemeLogoSvg;
    uint          cbAuthenticatorInfo;
    const(ubyte)* pbAuthenticatorInfo;
    uint          cSupportedRpIds;
    const(PWSTR)* ppwszSupportedRpIds;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_UPDATE_AUTHENTICATOR_DETAILS_2
{
    const(PWSTR)  pwszAuthenticatorName;
    const(GUID)*  pClsid;
    const(GUID)*  pClsidNew;
    const(PWSTR)  pwszLightThemeLogoSvg;
    const(PWSTR)  pwszDarkThemeLogoSvg;
    uint          cbAuthenticatorInfo;
    const(ubyte)* pbAuthenticatorInfo;
    uint          cSupportedRpIds;
    const(PWSTR)* ppwszSupportedRpIds;
    const(PWSTR)  pwszUserVerificationKeyName;
}

struct WEBAUTHN_PLUGIN_CREDENTIAL_DETAILS
{
    uint          cbCredentialId;
    const(ubyte)* pbCredentialId;
    const(PWSTR)  pwszRpId;
    const(PWSTR)  pwszRpName;
    uint          cbUserId;
    const(ubyte)* pbUserId;
    const(PWSTR)  pwszUserName;
    const(PWSTR)  pwszUserDisplayName;
}

struct WEBAUTHN_PLUGIN_USER_VERIFICATION_REQUEST
{
    HWND         hwnd;
    const(GUID)* rguidTransactionId;
    const(PWSTR) pwszUsername;
    const(PWSTR) pwszDisplayHint;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_USER_VERIFICATION_REQUEST_2
{
    HWND         hwnd;
    const(GUID)* pGuidTransactionId;
    const(PWSTR) pwszUsername;
    const(PWSTR) pwszDisplayHint;
    uint         cbBufferToSign;
    ubyte*       pbBufferToSign;
}

struct WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS
{
    uint dwVersion;
    int  lUp;
    int  lUv;
    int  lRequireResidentKey;
}

struct WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY
{
    uint   dwVersion;
    int    lKty;
    int    lAlg;
    int    lCrv;
    uint   cbX;
    ubyte* pbX;
    uint   cbY;
    ubyte* pbY;
}

struct WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION
{
    uint   dwVersion;
    WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY* pKeyAgreement;
    uint   cbEncryptedSalt;
    ubyte* pbEncryptedSalt;
    uint   cbSaltAuth;
    ubyte* pbSaltAuth;
}

struct WEBAUTHN_CTAPCBOR_MAKE_CREDENTIAL_REQUEST
{
    uint   dwVersion;
    uint   cbRpId;
    ubyte* pbRpId;
    uint   cbClientDataHash;
    ubyte* pbClientDataHash;
    WEBAUTHN_RP_ENTITY_INFORMATION* pRpInformation;
    WEBAUTHN_USER_ENTITY_INFORMATION* pUserInformation;
    WEBAUTHN_COSE_CREDENTIAL_PARAMETERS WebAuthNCredentialParameters;
    WEBAUTHN_CREDENTIAL_LIST CredentialList;
    uint   cbCborExtensionsMap;
    ubyte* pbCborExtensionsMap;
    WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS* pAuthenticatorOptions;
    BOOL   fEmptyPinAuth;
    uint   cbPinAuth;
    ubyte* pbPinAuth;
    int    lHmacSecretExt;
    WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION* pHmacSecretMcExtension;
    int    lPrfExt;
    uint   cbHmacSecretSaltValues;
    ubyte* pbHmacSecretSaltValues;
    uint   dwCredProtect;
    uint   dwPinProtocol;
    uint   dwEnterpriseAttestation;
    uint   cbCredBlobExt;
    ubyte* pbCredBlobExt;
    int    lLargeBlobKeyExt;
    uint   dwLargeBlobSupport;
    int    lMinPinLengthExt;
    uint   cbJsonExt;
    ubyte* pbJsonExt;
}

struct WEBAUTHN_CTAPCBOR_GET_ASSERTION_REQUEST
{
    uint         dwVersion;
    const(PWSTR) pwszRpId;
    uint         cbRpId;
    ubyte*       pbRpId;
    uint         cbClientDataHash;
    ubyte*       pbClientDataHash;
    WEBAUTHN_CREDENTIAL_LIST CredentialList;
    uint         cbCborExtensionsMap;
    ubyte*       pbCborExtensionsMap;
    WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS* pAuthenticatorOptions;
    BOOL         fEmptyPinAuth;
    uint         cbPinAuth;
    ubyte*       pbPinAuth;
    WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION* pHmacSaltExtension;
    uint         cbHmacSecretSaltValues;
    ubyte*       pbHmacSecretSaltValues;
    uint         dwPinProtocol;
    int          lCredBlobExt;
    int          lLargeBlobKeyExt;
    uint         dwCredLargeBlobOperation;
    uint         cbCredLargeBlobCompressed;
    ubyte*       pbCredLargeBlobCompressed;
    uint         dwCredLargeBlobOriginalSize;
    uint         cbJsonExt;
    ubyte*       pbJsonExt;
}

struct WEBAUTHN_CTAPCBOR_GET_ASSERTION_RESPONSE
{
    WEBAUTHN_ASSERTION WebAuthNAssertion;
    WEBAUTHN_USER_ENTITY_INFORMATION* pUserInformation;
    uint               dwNumberOfCredentials;
    int                lUserSelected;
    uint               cbLargeBlobKey;
    ubyte*             pbLargeBlobKey;
    uint               cbUnsignedExtensionOutputs;
    ubyte*             pbUnsignedExtensionOutputs;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_REQUEST
{
    HWND   hWnd;
    GUID   transactionId;
    uint   cbRequestSignature;
    ubyte* pbRequestSignature;
    uint   cbEncodedRequest;
    ubyte* pbEncodedRequest;
}

struct WEBAUTHN_PLUGIN_OPERATION_REQUEST
{
    HWND   hWnd;
    GUID   transactionId;
    uint   cbRequestSignature;
    ubyte* pbRequestSignature;
    WEBAUTHN_PLUGIN_REQUEST_TYPE requestType;
    uint   cbEncodedRequest;
    ubyte* pbEncodedRequest;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_RESPONSE
{
    uint   cbEncodedResponse;
    ubyte* pbEncodedResponse;
}

struct WEBAUTHN_PLUGIN_OPERATION_RESPONSE
{
    uint   cbEncodedResponse;
    ubyte* pbEncodedResponse;
}

struct EXPERIMENTAL_WEBAUTHN_PLUGIN_CANCEL_OPERATION_REQUEST
{
    GUID   transactionId;
    uint   cbRequestSignature;
    ubyte* pbRequestSignature;
}

struct WEBAUTHN_PLUGIN_CANCEL_OPERATION_REQUEST
{
    GUID   transactionId;
    uint   cbRequestSignature;
    ubyte* pbRequestSignature;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthngetapiversionnumber
@DllImport("webauthn.dll")
uint WebAuthNGetApiVersionNumber();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthnisuserverifyingplatformauthenticatoravailable
@DllImport("webauthn.dll")
HRESULT WebAuthNIsUserVerifyingPlatformAuthenticatorAvailable(BOOL* pbIsUserVerifyingPlatformAuthenticatorAvailable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthnauthenticatormakecredential
@DllImport("webauthn.dll")
HRESULT WebAuthNAuthenticatorMakeCredential(HWND hWnd, WEBAUTHN_RP_ENTITY_INFORMATION* pRpInformation, 
                                            WEBAUTHN_USER_ENTITY_INFORMATION* pUserInformation, 
                                            WEBAUTHN_COSE_CREDENTIAL_PARAMETERS* pPubKeyCredParams, 
                                            WEBAUTHN_CLIENT_DATA* pWebAuthNClientData, 
                                            WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS* pWebAuthNMakeCredentialOptions, 
                                            WEBAUTHN_CREDENTIAL_ATTESTATION** ppWebAuthNCredentialAttestation);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthnauthenticatorgetassertion
@DllImport("webauthn.dll")
HRESULT WebAuthNAuthenticatorGetAssertion(HWND hWnd, const(PWSTR) pwszRpId, 
                                          WEBAUTHN_CLIENT_DATA* pWebAuthNClientData, 
                                          WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS* pWebAuthNGetAssertionOptions, 
                                          WEBAUTHN_ASSERTION** ppWebAuthNAssertion);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthnfreecredentialattestation
@DllImport("webauthn.dll")
void WebAuthNFreeCredentialAttestation(WEBAUTHN_CREDENTIAL_ATTESTATION* pWebAuthNCredentialAttestation);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthnfreeassertion
@DllImport("webauthn.dll")
void WebAuthNFreeAssertion(WEBAUTHN_ASSERTION* pWebAuthNAssertion);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthngetcancellationid
@DllImport("webauthn.dll")
HRESULT WebAuthNGetCancellationId(GUID* pCancellationId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthncancelcurrentoperation
@DllImport("webauthn.dll")
HRESULT WebAuthNCancelCurrentOperation(const(GUID)* pCancellationId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthngetplatformcredentiallist
@DllImport("webauthn.dll")
HRESULT WebAuthNGetPlatformCredentialList(WEBAUTHN_GET_CREDENTIALS_OPTIONS* pGetCredentialsOptions, 
                                          WEBAUTHN_CREDENTIAL_DETAILS_LIST** ppCredentialDetailsList);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthnfreeplatformcredentiallist
@DllImport("webauthn.dll")
void WebAuthNFreePlatformCredentialList(WEBAUTHN_CREDENTIAL_DETAILS_LIST* pCredentialDetailsList);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthndeleteplatformcredential
@DllImport("webauthn.dll")
HRESULT WebAuthNDeletePlatformCredential(uint cbCredentialId, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/const(ubyte)* pbCredentialId);

@DllImport("webauthn.dll")
HRESULT WebAuthNGetAuthenticatorList(WEBAUTHN_AUTHENTICATOR_DETAILS_OPTIONS* pWebAuthNGetAuthenticatorListOptions, 
                                     WEBAUTHN_AUTHENTICATOR_DETAILS_LIST** ppAuthenticatorDetailsList);

@DllImport("webauthn.dll")
void WebAuthNFreeAuthenticatorList(WEBAUTHN_AUTHENTICATOR_DETAILS_LIST* pAuthenticatorDetailsList);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthngeterrorname
@DllImport("webauthn.dll")
PWSTR WebAuthNGetErrorName(HRESULT hr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthn/nf-webauthn-webauthngetw3cexceptiondomerror
@DllImport("webauthn.dll")
HRESULT WebAuthNGetW3CExceptionDOMError(HRESULT hr);


// Interfaces

@GUID("e6466e9a-b2f3-47c5-b88d-89bc14a8d998")
interface EXPERIMENTAL_IPluginAuthenticator : IUnknown
{
    HRESULT EXPERIMENTAL_PluginMakeCredential(EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_REQUEST* request, 
                                              EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_RESPONSE** response);
    HRESULT EXPERIMENTAL_PluginGetAssertion(EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_REQUEST* request, 
                                            EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_RESPONSE** response);
    HRESULT EXPERIMENTAL_PluginCancelOperation(EXPERIMENTAL_WEBAUTHN_PLUGIN_CANCEL_OPERATION_REQUEST* request);
}

@GUID("d26bcf6f-b54c-43ff-9f06-d5bf148625f7")
interface IPluginAuthenticator : IUnknown
{
    HRESULT MakeCredential(WEBAUTHN_PLUGIN_OPERATION_REQUEST* request, 
                           WEBAUTHN_PLUGIN_OPERATION_RESPONSE* response);
    HRESULT GetAssertion(WEBAUTHN_PLUGIN_OPERATION_REQUEST* request, WEBAUTHN_PLUGIN_OPERATION_RESPONSE* response);
    HRESULT CancelOperation(WEBAUTHN_PLUGIN_CANCEL_OPERATION_REQUEST* request);
    HRESULT GetLockStatus(PLUGIN_LOCK_STATUS* lockStatus);
}


// GUIDs


const GUID IID_EXPERIMENTAL_IPluginAuthenticator = GUIDOF!EXPERIMENTAL_IPluginAuthenticator;
const GUID IID_IPluginAuthenticator              = GUIDOF!IPluginAuthenticator;
