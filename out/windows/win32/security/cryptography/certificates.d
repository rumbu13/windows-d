// Written in the D programming language.

module windows.win32.security.cryptography.certificates;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, HRESULT, HWND, NTSTATUS, PWSTR,
                                         UNICODE_STRING, VARIANT_BOOL;
public import windows.win32.security.authentication.identity : LSA_TOKEN_INFORMATION_TYPE,
                                                               SecPkgContext_IssuerListInfoEx;
public import windows.win32.security.cryptography : CERT_CHAIN_CONTEXT, CERT_CONTEXT, CERT_EXTENSIONS,
                                                    CERT_RDN_ATTR_VALUE_TYPE,
                                                    CERT_SELECT_CRITERIA, CERT_USAGE_MATCH,
                                                    CRYPT_ATTRIBUTES, CRYPT_INTEGER_BLOB,
                                                    HCERTSTORE;
public import windows.win32.system.com : IDispatch, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias CERT_VIEW_COLUMN_INDEX = int;
enum : int
{
    CV_COLUMN_LOG_DEFAULT        = 0xfffffffe,
    CV_COLUMN_LOG_FAILED_DEFAULT = 0xfffffffd,
    CV_COLUMN_QUEUE_DEFAULT      = 0xffffffff,
}

alias CERT_DELETE_ROW_FLAGS = int;
enum : int
{
    CDR_EXPIRED              = 0x00000001,
    CDR_REQUEST_LAST_CHANGED = 0x00000002,
}

alias FULL_RESPONSE_PROPERTY_ID = int;
enum : int
{
    FR_PROP_NONE                          = 0x00000000,
    FR_PROP_FULLRESPONSE                  = 0x00000001,
    FR_PROP_STATUSINFOCOUNT               = 0x00000002,
    FR_PROP_BODYPARTSTRING                = 0x00000003,
    FR_PROP_STATUS                        = 0x00000004,
    FR_PROP_STATUSSTRING                  = 0x00000005,
    FR_PROP_OTHERINFOCHOICE               = 0x00000006,
    FR_PROP_FAILINFO                      = 0x00000007,
    FR_PROP_PENDINFOTOKEN                 = 0x00000008,
    FR_PROP_PENDINFOTIME                  = 0x00000009,
    FR_PROP_ISSUEDCERTIFICATEHASH         = 0x0000000a,
    FR_PROP_ISSUEDCERTIFICATE             = 0x0000000b,
    FR_PROP_ISSUEDCERTIFICATECHAIN        = 0x0000000c,
    FR_PROP_ISSUEDCERTIFICATECRLCHAIN     = 0x0000000d,
    FR_PROP_ENCRYPTEDKEYHASH              = 0x0000000e,
    FR_PROP_FULLRESPONSENOPKCS7           = 0x0000000f,
    FR_PROP_CAEXCHANGECERTIFICATEHASH     = 0x00000010,
    FR_PROP_CAEXCHANGECERTIFICATE         = 0x00000011,
    FR_PROP_CAEXCHANGECERTIFICATECHAIN    = 0x00000012,
    FR_PROP_CAEXCHANGECERTIFICATECRLCHAIN = 0x00000013,
    FR_PROP_ATTESTATIONCHALLENGE          = 0x00000014,
    FR_PROP_ATTESTATIONPROVIDERNAME       = 0x00000015,
}

alias CVRC_COLUMN = int;
enum : int
{
    CVRC_COLUMN_SCHEMA = 0x00000000,
    CVRC_COLUMN_RESULT = 0x00000001,
    CVRC_COLUMN_VALUE  = 0x00000002,
    CVRC_COLUMN_MASK   = 0x00000fff,
}

alias CERT_IMPORT_FLAGS = int;
enum : int
{
    CR_IN_BASE64HEADER = 0x00000000,
    CR_IN_BASE64       = 0x00000001,
    CR_IN_BINARY       = 0x00000002,
}

alias CERT_GET_CONFIG_FLAGS = int;
enum : int
{
    CC_DEFAULTCONFIG           = 0x00000000,
    CC_FIRSTCONFIG             = 0x00000002,
    CC_LOCALACTIVECONFIG       = 0x00000004,
    CC_LOCALCONFIG             = 0x00000003,
    CC_UIPICKCONFIG            = 0x00000001,
    CC_UIPICKCONFIGSKIPLOCALCA = 0x00000005,
}

alias ENUM_CERT_COLUMN_VALUE_FLAGS = int;
enum : int
{
    CV_OUT_BASE64              = 0x00000001,
    CV_OUT_BASE64HEADER        = 0x00000000,
    CV_OUT_BASE64REQUESTHEADER = 0x00000003,
    CV_OUT_BASE64X509CRLHEADER = 0x00000009,
    CV_OUT_BINARY              = 0x00000002,
    CV_OUT_HEX                 = 0x00000004,
    CV_OUT_HEXADDR             = 0x0000000a,
    CV_OUT_HEXASCII            = 0x00000005,
    CV_OUT_HEXASCIIADDR        = 0x0000000b,
}

alias PENDING_REQUEST_DESIRED_PROPERTY = int;
enum : int
{
    XEPR_CADNS          = 0x00000001,
    XEPR_CAFRIENDLYNAME = 0x00000003,
    XEPR_CANAME         = 0x00000002,
    XEPR_HASH           = 0x00000008,
    XEPR_REQUESTID      = 0x00000004,
}

alias CERTADMIN_GET_ROLES_FLAGS = uint;
enum : uint
{
    CA_ACCESS_ADMIN    = 0x00000001U,
    CA_ACCESS_AUDITOR  = 0x00000004U,
    CA_ACCESS_ENROLL   = 0x00000200U,
    CA_ACCESS_OFFICER  = 0x00000002U,
    CA_ACCESS_OPERATOR = 0x00000008U,
    CA_ACCESS_READ     = 0x00000100U,
}

alias CR_DISP = uint;
enum : uint
{
    CR_DISP_DENIED             = 0x00000002U,
    CR_DISP_ERROR              = 0x00000001U,
    CR_DISP_INCOMPLETE         = 0x00000000U,
    CR_DISP_ISSUED             = 0x00000003U,
    CR_DISP_ISSUED_OUT_OF_BAND = 0x00000004U,
    CR_DISP_UNDER_SUBMISSION   = 0x00000005U,
}

alias XEKL_KEYSIZE = int;
enum : int
{
    XEKL_KEYSIZE_MIN = 0x00000001,
    XEKL_KEYSIZE_MAX = 0x00000002,
    XEKL_KEYSIZE_INC = 0x00000003,
}

alias CERT_CREATE_REQUEST_FLAGS = int;
enum : int
{
    XECR_CMC         = 0x00000003,
    XECR_PKCS10_V1_5 = 0x00000004,
    XECR_PKCS10_V2_0 = 0x00000001,
    XECR_PKCS7       = 0x00000002,
}

alias CERT_EXIT_EVENT_MASK = uint;
enum : uint
{
    EXITEVENT_CERTDENIED          = 0x00000004U,
    EXITEVENT_CERTISSUED          = 0x00000001U,
    EXITEVENT_CERTPENDING         = 0x00000002U,
    EXITEVENT_CERTRETRIEVEPENDING = 0x00000010U,
    EXITEVENT_CERTREVOKED         = 0x00000008U,
    EXITEVENT_CRLISSUED           = 0x00000020U,
    EXITEVENT_SHUTDOWN            = 0x00000040U,
}

alias ADDED_CERT_TYPE = int;
enum : int
{
    XECT_EXTENSION_V1 = 0x00000001,
    XECT_EXTENSION_V2 = 0x00000002,
}

alias CVRC_TABLE = int;
enum : int
{
    CVRC_TABLE_ATTRIBUTES = 0x00004000,
    CVRC_TABLE_CRL        = 0x00005000,
    CVRC_TABLE_EXTENSIONS = 0x00003000,
    CVRC_TABLE_REQCERT    = 0x00000000,
}

alias CERT_PROPERTY_TYPE = int;
enum : int
{
    PROPTYPE_BINARY = 0x00000003,
    PROPTYPE_DATE   = 0x00000002,
    PROPTYPE_LONG   = 0x00000001,
    PROPTYPE_STRING = 0x00000004,
}

alias CERT_ALT_NAME = int;
enum : int
{
    CERT_ALT_NAME_RFC822_NAME    = 0x00000002,
    CERT_ALT_NAME_DNS_NAME       = 0x00000003,
    CERT_ALT_NAME_URL            = 0x00000007,
    CERT_ALT_NAME_REGISTERED_ID  = 0x00000009,
    CERT_ALT_NAME_DIRECTORY_NAME = 0x00000005,
    CERT_ALT_NAME_IP_ADDRESS     = 0x00000008,
    CERT_ALT_NAME_OTHER_NAME     = 0x00000001,
}

alias CSBACKUP_TYPE = uint;
enum : uint
{
    CSBACKUP_TYPE_FULL      = 0x00000001U,
    CSBACKUP_TYPE_LOGS_ONLY = 0x00000002U,
}

alias XEKL_KEYSPEC = int;
enum : int
{
    XEKL_KEYSPEC_KEYX = 0x00000001,
    XEKL_KEYSPEC_SIG  = 0x00000002,
}

alias CERT_REQUEST_OUT_TYPE = int;
enum : int
{
    CR_OUT_BASE64HEADER = 0x00000000,
    CR_OUT_BASE64       = 0x00000001,
    CR_OUT_BINARY       = 0x00000002,
}

alias CERT_VIEW_SEEK_OPERATOR_FLAGS = int;
enum : int
{
    CVR_SEEK_EQ = 0x00000001,
    CVR_SEEK_LE = 0x00000004,
    CVR_SEEK_LT = 0x00000002,
    CVR_SEEK_GE = 0x00000008,
    CVR_SEEK_GT = 0x00000010,
}

enum OCSPSigningFlag : int
{
    OCSP_SF_SILENT                           = 0x00000001,
    OCSP_SF_USE_CACERT                       = 0x00000002,
    OCSP_SF_ALLOW_SIGNINGCERT_AUTORENEWAL    = 0x00000004,
    OCSP_SF_FORCE_SIGNINGCERT_ISSUER_ISCA    = 0x00000008,
    OCSP_SF_AUTODISCOVER_SIGNINGCERT         = 0x00000010,
    OCSP_SF_MANUAL_ASSIGN_SIGNINGCERT        = 0x00000020,
    OCSP_SF_RESPONDER_ID_KEYHASH             = 0x00000040,
    OCSP_SF_RESPONDER_ID_NAME                = 0x00000080,
    OCSP_SF_ALLOW_NONCE_EXTENSION            = 0x00000100,
    OCSP_SF_ALLOW_SIGNINGCERT_AUTOENROLLMENT = 0x00000200,
}

enum OCSPRequestFlag : int
{
    OCSP_RF_REJECT_SIGNED_REQUESTS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/ne-certcli-x509enrollmentauthflags
enum X509EnrollmentAuthFlags : int
{
    X509AuthNone        = 0x00000000,
    X509AuthAnonymous   = 0x00000001,
    X509AuthKerberos    = 0x00000002,
    X509AuthUsername    = 0x00000004,
    X509AuthCertificate = 0x00000008,
}

enum X509SCEPMessageType : int
{
    SCEPMessageUnknown              = 0xffffffff,
    SCEPMessageCertResponse         = 0x00000003,
    SCEPMessagePKCSRequest          = 0x00000013,
    SCEPMessageGetCertInitial       = 0x00000014,
    SCEPMessageGetCert              = 0x00000015,
    SCEPMessageGetCRL               = 0x00000016,
    SCEPMessageClaimChallengeAnswer = 0x00000029,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/ne-certpol-x509scepdisposition
enum X509SCEPDisposition : int
{
    SCEPDispositionUnknown          = 0xffffffff,
    SCEPDispositionSuccess          = 0x00000000,
    SCEPDispositionFailure          = 0x00000002,
    SCEPDispositionPending          = 0x00000003,
    SCEPDispositionPendingChallenge = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/ne-certpol-x509scepfailinfo
alias X509SCEPFailInfo = int;
enum : int
{
    SCEPFailUnknown         = 0xffffffff,
    SCEPFailBadAlgorithm    = 0x00000000,
    SCEPFailBadMessageCheck = 0x00000001,
    SCEPFailBadRequest      = 0x00000002,
    SCEPFailBadTime         = 0x00000003,
    SCEPFailBadCertId       = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-certenroll_objectid
alias CERTENROLL_OBJECTID = int;
enum : int
{
    XCN_OID_NONE                                          = 0x00000000,
    XCN_OID_RSA                                           = 0x00000001,
    XCN_OID_PKCS                                          = 0x00000002,
    XCN_OID_RSA_HASH                                      = 0x00000003,
    XCN_OID_RSA_ENCRYPT                                   = 0x00000004,
    XCN_OID_PKCS_1                                        = 0x00000005,
    XCN_OID_PKCS_2                                        = 0x00000006,
    XCN_OID_PKCS_3                                        = 0x00000007,
    XCN_OID_PKCS_4                                        = 0x00000008,
    XCN_OID_PKCS_5                                        = 0x00000009,
    XCN_OID_PKCS_6                                        = 0x0000000a,
    XCN_OID_PKCS_7                                        = 0x0000000b,
    XCN_OID_PKCS_8                                        = 0x0000000c,
    XCN_OID_PKCS_9                                        = 0x0000000d,
    XCN_OID_PKCS_10                                       = 0x0000000e,
    XCN_OID_PKCS_12                                       = 0x0000000f,
    XCN_OID_RSA_RSA                                       = 0x00000010,
    XCN_OID_RSA_MD2RSA                                    = 0x00000011,
    XCN_OID_RSA_MD4RSA                                    = 0x00000012,
    XCN_OID_RSA_MD5RSA                                    = 0x00000013,
    XCN_OID_RSA_SHA1RSA                                   = 0x00000014,
    XCN_OID_RSA_SETOAEP_RSA                               = 0x00000015,
    XCN_OID_RSA_DH                                        = 0x00000016,
    XCN_OID_RSA_data                                      = 0x00000017,
    XCN_OID_RSA_signedData                                = 0x00000018,
    XCN_OID_RSA_envelopedData                             = 0x00000019,
    XCN_OID_RSA_signEnvData                               = 0x0000001a,
    XCN_OID_RSA_digestedData                              = 0x0000001b,
    XCN_OID_RSA_hashedData                                = 0x0000001c,
    XCN_OID_RSA_encryptedData                             = 0x0000001d,
    XCN_OID_RSA_emailAddr                                 = 0x0000001e,
    XCN_OID_RSA_unstructName                              = 0x0000001f,
    XCN_OID_RSA_contentType                               = 0x00000020,
    XCN_OID_RSA_messageDigest                             = 0x00000021,
    XCN_OID_RSA_signingTime                               = 0x00000022,
    XCN_OID_RSA_counterSign                               = 0x00000023,
    XCN_OID_RSA_challengePwd                              = 0x00000024,
    XCN_OID_RSA_unstructAddr                              = 0x00000025,
    XCN_OID_RSA_extCertAttrs                              = 0x00000026,
    XCN_OID_RSA_certExtensions                            = 0x00000027,
    XCN_OID_RSA_SMIMECapabilities                         = 0x00000028,
    XCN_OID_RSA_preferSignedData                          = 0x00000029,
    XCN_OID_RSA_SMIMEalg                                  = 0x0000002a,
    XCN_OID_RSA_SMIMEalgESDH                              = 0x0000002b,
    XCN_OID_RSA_SMIMEalgCMS3DESwrap                       = 0x0000002c,
    XCN_OID_RSA_SMIMEalgCMSRC2wrap                        = 0x0000002d,
    XCN_OID_RSA_MD2                                       = 0x0000002e,
    XCN_OID_RSA_MD4                                       = 0x0000002f,
    XCN_OID_RSA_MD5                                       = 0x00000030,
    XCN_OID_RSA_RC2CBC                                    = 0x00000031,
    XCN_OID_RSA_RC4                                       = 0x00000032,
    XCN_OID_RSA_DES_EDE3_CBC                              = 0x00000033,
    XCN_OID_RSA_RC5_CBCPad                                = 0x00000034,
    XCN_OID_ANSI_X942                                     = 0x00000035,
    XCN_OID_ANSI_X942_DH                                  = 0x00000036,
    XCN_OID_X957                                          = 0x00000037,
    XCN_OID_X957_DSA                                      = 0x00000038,
    XCN_OID_X957_SHA1DSA                                  = 0x00000039,
    XCN_OID_DS                                            = 0x0000003a,
    XCN_OID_DSALG                                         = 0x0000003b,
    XCN_OID_DSALG_CRPT                                    = 0x0000003c,
    XCN_OID_DSALG_HASH                                    = 0x0000003d,
    XCN_OID_DSALG_SIGN                                    = 0x0000003e,
    XCN_OID_DSALG_RSA                                     = 0x0000003f,
    XCN_OID_OIW                                           = 0x00000040,
    XCN_OID_OIWSEC                                        = 0x00000041,
    XCN_OID_OIWSEC_md4RSA                                 = 0x00000042,
    XCN_OID_OIWSEC_md5RSA                                 = 0x00000043,
    XCN_OID_OIWSEC_md4RSA2                                = 0x00000044,
    XCN_OID_OIWSEC_desECB                                 = 0x00000045,
    XCN_OID_OIWSEC_desCBC                                 = 0x00000046,
    XCN_OID_OIWSEC_desOFB                                 = 0x00000047,
    XCN_OID_OIWSEC_desCFB                                 = 0x00000048,
    XCN_OID_OIWSEC_desMAC                                 = 0x00000049,
    XCN_OID_OIWSEC_rsaSign                                = 0x0000004a,
    XCN_OID_OIWSEC_dsa                                    = 0x0000004b,
    XCN_OID_OIWSEC_shaDSA                                 = 0x0000004c,
    XCN_OID_OIWSEC_mdc2RSA                                = 0x0000004d,
    XCN_OID_OIWSEC_shaRSA                                 = 0x0000004e,
    XCN_OID_OIWSEC_dhCommMod                              = 0x0000004f,
    XCN_OID_OIWSEC_desEDE                                 = 0x00000050,
    XCN_OID_OIWSEC_sha                                    = 0x00000051,
    XCN_OID_OIWSEC_mdc2                                   = 0x00000052,
    XCN_OID_OIWSEC_dsaComm                                = 0x00000053,
    XCN_OID_OIWSEC_dsaCommSHA                             = 0x00000054,
    XCN_OID_OIWSEC_rsaXchg                                = 0x00000055,
    XCN_OID_OIWSEC_keyHashSeal                            = 0x00000056,
    XCN_OID_OIWSEC_md2RSASign                             = 0x00000057,
    XCN_OID_OIWSEC_md5RSASign                             = 0x00000058,
    XCN_OID_OIWSEC_sha1                                   = 0x00000059,
    XCN_OID_OIWSEC_dsaSHA1                                = 0x0000005a,
    XCN_OID_OIWSEC_dsaCommSHA1                            = 0x0000005b,
    XCN_OID_OIWSEC_sha1RSASign                            = 0x0000005c,
    XCN_OID_OIWDIR                                        = 0x0000005d,
    XCN_OID_OIWDIR_CRPT                                   = 0x0000005e,
    XCN_OID_OIWDIR_HASH                                   = 0x0000005f,
    XCN_OID_OIWDIR_SIGN                                   = 0x00000060,
    XCN_OID_OIWDIR_md2                                    = 0x00000061,
    XCN_OID_OIWDIR_md2RSA                                 = 0x00000062,
    XCN_OID_INFOSEC                                       = 0x00000063,
    XCN_OID_INFOSEC_sdnsSignature                         = 0x00000064,
    XCN_OID_INFOSEC_mosaicSignature                       = 0x00000065,
    XCN_OID_INFOSEC_sdnsConfidentiality                   = 0x00000066,
    XCN_OID_INFOSEC_mosaicConfidentiality                 = 0x00000067,
    XCN_OID_INFOSEC_sdnsIntegrity                         = 0x00000068,
    XCN_OID_INFOSEC_mosaicIntegrity                       = 0x00000069,
    XCN_OID_INFOSEC_sdnsTokenProtection                   = 0x0000006a,
    XCN_OID_INFOSEC_mosaicTokenProtection                 = 0x0000006b,
    XCN_OID_INFOSEC_sdnsKeyManagement                     = 0x0000006c,
    XCN_OID_INFOSEC_mosaicKeyManagement                   = 0x0000006d,
    XCN_OID_INFOSEC_sdnsKMandSig                          = 0x0000006e,
    XCN_OID_INFOSEC_mosaicKMandSig                        = 0x0000006f,
    XCN_OID_INFOSEC_SuiteASignature                       = 0x00000070,
    XCN_OID_INFOSEC_SuiteAConfidentiality                 = 0x00000071,
    XCN_OID_INFOSEC_SuiteAIntegrity                       = 0x00000072,
    XCN_OID_INFOSEC_SuiteATokenProtection                 = 0x00000073,
    XCN_OID_INFOSEC_SuiteAKeyManagement                   = 0x00000074,
    XCN_OID_INFOSEC_SuiteAKMandSig                        = 0x00000075,
    XCN_OID_INFOSEC_mosaicUpdatedSig                      = 0x00000076,
    XCN_OID_INFOSEC_mosaicKMandUpdSig                     = 0x00000077,
    XCN_OID_INFOSEC_mosaicUpdatedInteg                    = 0x00000078,
    XCN_OID_COMMON_NAME                                   = 0x00000079,
    XCN_OID_SUR_NAME                                      = 0x0000007a,
    XCN_OID_DEVICE_SERIAL_NUMBER                          = 0x0000007b,
    XCN_OID_COUNTRY_NAME                                  = 0x0000007c,
    XCN_OID_LOCALITY_NAME                                 = 0x0000007d,
    XCN_OID_STATE_OR_PROVINCE_NAME                        = 0x0000007e,
    XCN_OID_STREET_ADDRESS                                = 0x0000007f,
    XCN_OID_ORGANIZATION_NAME                             = 0x00000080,
    XCN_OID_ORGANIZATIONAL_UNIT_NAME                      = 0x00000081,
    XCN_OID_TITLE                                         = 0x00000082,
    XCN_OID_DESCRIPTION                                   = 0x00000083,
    XCN_OID_SEARCH_GUIDE                                  = 0x00000084,
    XCN_OID_BUSINESS_CATEGORY                             = 0x00000085,
    XCN_OID_POSTAL_ADDRESS                                = 0x00000086,
    XCN_OID_POSTAL_CODE                                   = 0x00000087,
    XCN_OID_POST_OFFICE_BOX                               = 0x00000088,
    XCN_OID_PHYSICAL_DELIVERY_OFFICE_NAME                 = 0x00000089,
    XCN_OID_TELEPHONE_NUMBER                              = 0x0000008a,
    XCN_OID_TELEX_NUMBER                                  = 0x0000008b,
    XCN_OID_TELETEXT_TERMINAL_IDENTIFIER                  = 0x0000008c,
    XCN_OID_FACSIMILE_TELEPHONE_NUMBER                    = 0x0000008d,
    XCN_OID_X21_ADDRESS                                   = 0x0000008e,
    XCN_OID_INTERNATIONAL_ISDN_NUMBER                     = 0x0000008f,
    XCN_OID_REGISTERED_ADDRESS                            = 0x00000090,
    XCN_OID_DESTINATION_INDICATOR                         = 0x00000091,
    XCN_OID_PREFERRED_DELIVERY_METHOD                     = 0x00000092,
    XCN_OID_PRESENTATION_ADDRESS                          = 0x00000093,
    XCN_OID_SUPPORTED_APPLICATION_CONTEXT                 = 0x00000094,
    XCN_OID_MEMBER                                        = 0x00000095,
    XCN_OID_OWNER                                         = 0x00000096,
    XCN_OID_ROLE_OCCUPANT                                 = 0x00000097,
    XCN_OID_SEE_ALSO                                      = 0x00000098,
    XCN_OID_USER_PASSWORD                                 = 0x00000099,
    XCN_OID_USER_CERTIFICATE                              = 0x0000009a,
    XCN_OID_CA_CERTIFICATE                                = 0x0000009b,
    XCN_OID_AUTHORITY_REVOCATION_LIST                     = 0x0000009c,
    XCN_OID_CERTIFICATE_REVOCATION_LIST                   = 0x0000009d,
    XCN_OID_CROSS_CERTIFICATE_PAIR                        = 0x0000009e,
    XCN_OID_GIVEN_NAME                                    = 0x0000009f,
    XCN_OID_INITIALS                                      = 0x000000a0,
    XCN_OID_DN_QUALIFIER                                  = 0x000000a1,
    XCN_OID_DOMAIN_COMPONENT                              = 0x000000a2,
    XCN_OID_PKCS_12_FRIENDLY_NAME_ATTR                    = 0x000000a3,
    XCN_OID_PKCS_12_LOCAL_KEY_ID                          = 0x000000a4,
    XCN_OID_PKCS_12_KEY_PROVIDER_NAME_ATTR                = 0x000000a5,
    XCN_OID_LOCAL_MACHINE_KEYSET                          = 0x000000a6,
    XCN_OID_PKCS_12_EXTENDED_ATTRIBUTES                   = 0x000000a7,
    XCN_OID_KEYID_RDN                                     = 0x000000a8,
    XCN_OID_AUTHORITY_KEY_IDENTIFIER                      = 0x000000a9,
    XCN_OID_KEY_ATTRIBUTES                                = 0x000000aa,
    XCN_OID_CERT_POLICIES_95                              = 0x000000ab,
    XCN_OID_KEY_USAGE_RESTRICTION                         = 0x000000ac,
    XCN_OID_SUBJECT_ALT_NAME                              = 0x000000ad,
    XCN_OID_ISSUER_ALT_NAME                               = 0x000000ae,
    XCN_OID_BASIC_CONSTRAINTS                             = 0x000000af,
    XCN_OID_KEY_USAGE                                     = 0x000000b0,
    XCN_OID_PRIVATEKEY_USAGE_PERIOD                       = 0x000000b1,
    XCN_OID_BASIC_CONSTRAINTS2                            = 0x000000b2,
    XCN_OID_CERT_POLICIES                                 = 0x000000b3,
    XCN_OID_ANY_CERT_POLICY                               = 0x000000b4,
    XCN_OID_AUTHORITY_KEY_IDENTIFIER2                     = 0x000000b5,
    XCN_OID_SUBJECT_KEY_IDENTIFIER                        = 0x000000b6,
    XCN_OID_SUBJECT_ALT_NAME2                             = 0x000000b7,
    XCN_OID_ISSUER_ALT_NAME2                              = 0x000000b8,
    XCN_OID_CRL_REASON_CODE                               = 0x000000b9,
    XCN_OID_REASON_CODE_HOLD                              = 0x000000ba,
    XCN_OID_CRL_DIST_POINTS                               = 0x000000bb,
    XCN_OID_ENHANCED_KEY_USAGE                            = 0x000000bc,
    XCN_OID_CRL_NUMBER                                    = 0x000000bd,
    XCN_OID_DELTA_CRL_INDICATOR                           = 0x000000be,
    XCN_OID_ISSUING_DIST_POINT                            = 0x000000bf,
    XCN_OID_FRESHEST_CRL                                  = 0x000000c0,
    XCN_OID_NAME_CONSTRAINTS                              = 0x000000c1,
    XCN_OID_POLICY_MAPPINGS                               = 0x000000c2,
    XCN_OID_LEGACY_POLICY_MAPPINGS                        = 0x000000c3,
    XCN_OID_POLICY_CONSTRAINTS                            = 0x000000c4,
    XCN_OID_RENEWAL_CERTIFICATE                           = 0x000000c5,
    XCN_OID_ENROLLMENT_NAME_VALUE_PAIR                    = 0x000000c6,
    XCN_OID_ENROLLMENT_CSP_PROVIDER                       = 0x000000c7,
    XCN_OID_OS_VERSION                                    = 0x000000c8,
    XCN_OID_ENROLLMENT_AGENT                              = 0x000000c9,
    XCN_OID_PKIX                                          = 0x000000ca,
    XCN_OID_PKIX_PE                                       = 0x000000cb,
    XCN_OID_AUTHORITY_INFO_ACCESS                         = 0x000000cc,
    XCN_OID_BIOMETRIC_EXT                                 = 0x000000cd,
    XCN_OID_LOGOTYPE_EXT                                  = 0x000000ce,
    XCN_OID_CERT_EXTENSIONS                               = 0x000000cf,
    XCN_OID_NEXT_UPDATE_LOCATION                          = 0x000000d0,
    XCN_OID_REMOVE_CERTIFICATE                            = 0x000000d1,
    XCN_OID_CROSS_CERT_DIST_POINTS                        = 0x000000d2,
    XCN_OID_CTL                                           = 0x000000d3,
    XCN_OID_SORTED_CTL                                    = 0x000000d4,
    XCN_OID_SERIALIZED                                    = 0x000000d5,
    XCN_OID_NT_PRINCIPAL_NAME                             = 0x000000d6,
    XCN_OID_PRODUCT_UPDATE                                = 0x000000d7,
    XCN_OID_ANY_APPLICATION_POLICY                        = 0x000000d8,
    XCN_OID_AUTO_ENROLL_CTL_USAGE                         = 0x000000d9,
    XCN_OID_ENROLL_CERTTYPE_EXTENSION                     = 0x000000da,
    XCN_OID_CERT_MANIFOLD                                 = 0x000000db,
    XCN_OID_CERTSRV_CA_VERSION                            = 0x000000dc,
    XCN_OID_CERTSRV_PREVIOUS_CERT_HASH                    = 0x000000dd,
    XCN_OID_CRL_VIRTUAL_BASE                              = 0x000000de,
    XCN_OID_CRL_NEXT_PUBLISH                              = 0x000000df,
    XCN_OID_KP_CA_EXCHANGE                                = 0x000000e0,
    XCN_OID_KP_KEY_RECOVERY_AGENT                         = 0x000000e1,
    XCN_OID_CERTIFICATE_TEMPLATE                          = 0x000000e2,
    XCN_OID_ENTERPRISE_OID_ROOT                           = 0x000000e3,
    XCN_OID_RDN_DUMMY_SIGNER                              = 0x000000e4,
    XCN_OID_APPLICATION_CERT_POLICIES                     = 0x000000e5,
    XCN_OID_APPLICATION_POLICY_MAPPINGS                   = 0x000000e6,
    XCN_OID_APPLICATION_POLICY_CONSTRAINTS                = 0x000000e7,
    XCN_OID_ARCHIVED_KEY_ATTR                             = 0x000000e8,
    XCN_OID_CRL_SELF_CDP                                  = 0x000000e9,
    XCN_OID_REQUIRE_CERT_CHAIN_POLICY                     = 0x000000ea,
    XCN_OID_ARCHIVED_KEY_CERT_HASH                        = 0x000000eb,
    XCN_OID_ISSUED_CERT_HASH                              = 0x000000ec,
    XCN_OID_DS_EMAIL_REPLICATION                          = 0x000000ed,
    XCN_OID_REQUEST_CLIENT_INFO                           = 0x000000ee,
    XCN_OID_ENCRYPTED_KEY_HASH                            = 0x000000ef,
    XCN_OID_CERTSRV_CROSSCA_VERSION                       = 0x000000f0,
    XCN_OID_NTDS_REPLICATION                              = 0x000000f1,
    XCN_OID_SUBJECT_DIR_ATTRS                             = 0x000000f2,
    XCN_OID_PKIX_KP                                       = 0x000000f3,
    XCN_OID_PKIX_KP_SERVER_AUTH                           = 0x000000f4,
    XCN_OID_PKIX_KP_CLIENT_AUTH                           = 0x000000f5,
    XCN_OID_PKIX_KP_CODE_SIGNING                          = 0x000000f6,
    XCN_OID_PKIX_KP_EMAIL_PROTECTION                      = 0x000000f7,
    XCN_OID_PKIX_KP_IPSEC_END_SYSTEM                      = 0x000000f8,
    XCN_OID_PKIX_KP_IPSEC_TUNNEL                          = 0x000000f9,
    XCN_OID_PKIX_KP_IPSEC_USER                            = 0x000000fa,
    XCN_OID_PKIX_KP_TIMESTAMP_SIGNING                     = 0x000000fb,
    XCN_OID_PKIX_KP_OCSP_SIGNING                          = 0x000000fc,
    XCN_OID_PKIX_OCSP_NOCHECK                             = 0x000000fd,
    XCN_OID_IPSEC_KP_IKE_INTERMEDIATE                     = 0x000000fe,
    XCN_OID_KP_CTL_USAGE_SIGNING                          = 0x000000ff,
    XCN_OID_KP_TIME_STAMP_SIGNING                         = 0x00000100,
    XCN_OID_SERVER_GATED_CRYPTO                           = 0x00000101,
    XCN_OID_SGC_NETSCAPE                                  = 0x00000102,
    XCN_OID_KP_EFS                                        = 0x00000103,
    XCN_OID_EFS_RECOVERY                                  = 0x00000104,
    XCN_OID_WHQL_CRYPTO                                   = 0x00000105,
    XCN_OID_NT5_CRYPTO                                    = 0x00000106,
    XCN_OID_OEM_WHQL_CRYPTO                               = 0x00000107,
    XCN_OID_EMBEDDED_NT_CRYPTO                            = 0x00000108,
    XCN_OID_ROOT_LIST_SIGNER                              = 0x00000109,
    XCN_OID_KP_QUALIFIED_SUBORDINATION                    = 0x0000010a,
    XCN_OID_KP_KEY_RECOVERY                               = 0x0000010b,
    XCN_OID_KP_DOCUMENT_SIGNING                           = 0x0000010c,
    XCN_OID_KP_LIFETIME_SIGNING                           = 0x0000010d,
    XCN_OID_KP_MOBILE_DEVICE_SOFTWARE                     = 0x0000010e,
    XCN_OID_KP_SMART_DISPLAY                              = 0x0000010f,
    XCN_OID_KP_CSP_SIGNATURE                              = 0x00000110,
    XCN_OID_DRM                                           = 0x00000111,
    XCN_OID_DRM_INDIVIDUALIZATION                         = 0x00000112,
    XCN_OID_LICENSES                                      = 0x00000113,
    XCN_OID_LICENSE_SERVER                                = 0x00000114,
    XCN_OID_KP_SMARTCARD_LOGON                            = 0x00000115,
    XCN_OID_YESNO_TRUST_ATTR                              = 0x00000116,
    XCN_OID_PKIX_POLICY_QUALIFIER_CPS                     = 0x00000117,
    XCN_OID_PKIX_POLICY_QUALIFIER_USERNOTICE              = 0x00000118,
    XCN_OID_CERT_POLICIES_95_QUALIFIER1                   = 0x00000119,
    XCN_OID_PKIX_ACC_DESCR                                = 0x0000011a,
    XCN_OID_PKIX_OCSP                                     = 0x0000011b,
    XCN_OID_PKIX_CA_ISSUERS                               = 0x0000011c,
    XCN_OID_VERISIGN_PRIVATE_6_9                          = 0x0000011d,
    XCN_OID_VERISIGN_ONSITE_JURISDICTION_HASH             = 0x0000011e,
    XCN_OID_VERISIGN_BITSTRING_6_13                       = 0x0000011f,
    XCN_OID_VERISIGN_ISS_STRONG_CRYPTO                    = 0x00000120,
    XCN_OID_NETSCAPE                                      = 0x00000121,
    XCN_OID_NETSCAPE_CERT_EXTENSION                       = 0x00000122,
    XCN_OID_NETSCAPE_CERT_TYPE                            = 0x00000123,
    XCN_OID_NETSCAPE_BASE_URL                             = 0x00000124,
    XCN_OID_NETSCAPE_REVOCATION_URL                       = 0x00000125,
    XCN_OID_NETSCAPE_CA_REVOCATION_URL                    = 0x00000126,
    XCN_OID_NETSCAPE_CERT_RENEWAL_URL                     = 0x00000127,
    XCN_OID_NETSCAPE_CA_POLICY_URL                        = 0x00000128,
    XCN_OID_NETSCAPE_SSL_SERVER_NAME                      = 0x00000129,
    XCN_OID_NETSCAPE_COMMENT                              = 0x0000012a,
    XCN_OID_NETSCAPE_DATA_TYPE                            = 0x0000012b,
    XCN_OID_NETSCAPE_CERT_SEQUENCE                        = 0x0000012c,
    XCN_OID_CT_PKI_DATA                                   = 0x0000012d,
    XCN_OID_CT_PKI_RESPONSE                               = 0x0000012e,
    XCN_OID_PKIX_NO_SIGNATURE                             = 0x0000012f,
    XCN_OID_CMC                                           = 0x00000130,
    XCN_OID_CMC_STATUS_INFO                               = 0x00000131,
    XCN_OID_CMC_IDENTIFICATION                            = 0x00000132,
    XCN_OID_CMC_IDENTITY_PROOF                            = 0x00000133,
    XCN_OID_CMC_DATA_RETURN                               = 0x00000134,
    XCN_OID_CMC_TRANSACTION_ID                            = 0x00000135,
    XCN_OID_CMC_SENDER_NONCE                              = 0x00000136,
    XCN_OID_CMC_RECIPIENT_NONCE                           = 0x00000137,
    XCN_OID_CMC_ADD_EXTENSIONS                            = 0x00000138,
    XCN_OID_CMC_ENCRYPTED_POP                             = 0x00000139,
    XCN_OID_CMC_DECRYPTED_POP                             = 0x0000013a,
    XCN_OID_CMC_LRA_POP_WITNESS                           = 0x0000013b,
    XCN_OID_CMC_GET_CERT                                  = 0x0000013c,
    XCN_OID_CMC_GET_CRL                                   = 0x0000013d,
    XCN_OID_CMC_REVOKE_REQUEST                            = 0x0000013e,
    XCN_OID_CMC_REG_INFO                                  = 0x0000013f,
    XCN_OID_CMC_RESPONSE_INFO                             = 0x00000140,
    XCN_OID_CMC_QUERY_PENDING                             = 0x00000141,
    XCN_OID_CMC_ID_POP_LINK_RANDOM                        = 0x00000142,
    XCN_OID_CMC_ID_POP_LINK_WITNESS                       = 0x00000143,
    XCN_OID_CMC_ID_CONFIRM_CERT_ACCEPTANCE                = 0x00000144,
    XCN_OID_CMC_ADD_ATTRIBUTES                            = 0x00000145,
    XCN_OID_LOYALTY_OTHER_LOGOTYPE                        = 0x00000146,
    XCN_OID_BACKGROUND_OTHER_LOGOTYPE                     = 0x00000147,
    XCN_OID_PKIX_OCSP_BASIC_SIGNED_RESPONSE               = 0x00000148,
    XCN_OID_PKCS_7_DATA                                   = 0x00000149,
    XCN_OID_PKCS_7_SIGNED                                 = 0x0000014a,
    XCN_OID_PKCS_7_ENVELOPED                              = 0x0000014b,
    XCN_OID_PKCS_7_SIGNEDANDENVELOPED                     = 0x0000014c,
    XCN_OID_PKCS_7_DIGESTED                               = 0x0000014d,
    XCN_OID_PKCS_7_ENCRYPTED                              = 0x0000014e,
    XCN_OID_PKCS_9_CONTENT_TYPE                           = 0x0000014f,
    XCN_OID_PKCS_9_MESSAGE_DIGEST                         = 0x00000150,
    XCN_OID_CERT_PROP_ID_PREFIX                           = 0x00000151,
    XCN_OID_CERT_KEY_IDENTIFIER_PROP_ID                   = 0x00000152,
    XCN_OID_CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID    = 0x00000153,
    XCN_OID_CERT_SUBJECT_NAME_MD5_HASH_PROP_ID            = 0x00000154,
    XCN_OID_CERT_MD5_HASH_PROP_ID                         = 0x00000155,
    XCN_OID_RSA_SHA256RSA                                 = 0x00000156,
    XCN_OID_RSA_SHA384RSA                                 = 0x00000157,
    XCN_OID_RSA_SHA512RSA                                 = 0x00000158,
    XCN_OID_NIST_sha256                                   = 0x00000159,
    XCN_OID_NIST_sha384                                   = 0x0000015a,
    XCN_OID_NIST_sha512                                   = 0x0000015b,
    XCN_OID_RSA_MGF1                                      = 0x0000015c,
    XCN_OID_ECC_PUBLIC_KEY                                = 0x0000015d,
    XCN_OID_ECDSA_SHA1                                    = 0x0000015e,
    XCN_OID_ECDSA_SPECIFIED                               = 0x0000015f,
    XCN_OID_ANY_ENHANCED_KEY_USAGE                        = 0x00000160,
    XCN_OID_RSA_SSA_PSS                                   = 0x00000161,
    XCN_OID_ATTR_SUPPORTED_ALGORITHMS                     = 0x00000163,
    XCN_OID_ATTR_TPM_SECURITY_ASSERTIONS                  = 0x00000164,
    XCN_OID_ATTR_TPM_SPECIFICATION                        = 0x00000165,
    XCN_OID_CERT_DISALLOWED_FILETIME_PROP_ID              = 0x00000166,
    XCN_OID_CERT_SIGNATURE_HASH_PROP_ID                   = 0x00000167,
    XCN_OID_CERT_STRONG_KEY_OS_1                          = 0x00000168,
    XCN_OID_CERT_STRONG_KEY_OS_CURRENT                    = 0x00000169,
    XCN_OID_CERT_STRONG_KEY_OS_PREFIX                     = 0x0000016a,
    XCN_OID_CERT_STRONG_SIGN_OS_1                         = 0x0000016b,
    XCN_OID_CERT_STRONG_SIGN_OS_CURRENT                   = 0x0000016c,
    XCN_OID_CERT_STRONG_SIGN_OS_PREFIX                    = 0x0000016d,
    XCN_OID_DH_SINGLE_PASS_STDDH_SHA1_KDF                 = 0x0000016e,
    XCN_OID_DH_SINGLE_PASS_STDDH_SHA256_KDF               = 0x0000016f,
    XCN_OID_DH_SINGLE_PASS_STDDH_SHA384_KDF               = 0x00000170,
    XCN_OID_DISALLOWED_HASH                               = 0x00000171,
    XCN_OID_DISALLOWED_LIST                               = 0x00000172,
    XCN_OID_ECC_CURVE_P256                                = 0x00000173,
    XCN_OID_ECC_CURVE_P384                                = 0x00000174,
    XCN_OID_ECC_CURVE_P521                                = 0x00000175,
    XCN_OID_ECDSA_SHA256                                  = 0x00000176,
    XCN_OID_ECDSA_SHA384                                  = 0x00000177,
    XCN_OID_ECDSA_SHA512                                  = 0x00000178,
    XCN_OID_ENROLL_CAXCHGCERT_HASH                        = 0x00000179,
    XCN_OID_ENROLL_EK_INFO                                = 0x0000017a,
    XCN_OID_ENROLL_EKPUB_CHALLENGE                        = 0x0000017b,
    XCN_OID_ENROLL_EKVERIFYCERT                           = 0x0000017c,
    XCN_OID_ENROLL_EKVERIFYCREDS                          = 0x0000017d,
    XCN_OID_ENROLL_EKVERIFYKEY                            = 0x0000017e,
    XCN_OID_EV_RDN_COUNTRY                                = 0x0000017f,
    XCN_OID_EV_RDN_LOCALE                                 = 0x00000180,
    XCN_OID_EV_RDN_STATE_OR_PROVINCE                      = 0x00000181,
    XCN_OID_INHIBIT_ANY_POLICY                            = 0x00000182,
    XCN_OID_INTERNATIONALIZED_EMAIL_ADDRESS               = 0x00000183,
    XCN_OID_KP_KERNEL_MODE_CODE_SIGNING                   = 0x00000184,
    XCN_OID_KP_KERNEL_MODE_HAL_EXTENSION_SIGNING          = 0x00000185,
    XCN_OID_KP_KERNEL_MODE_TRUSTED_BOOT_SIGNING           = 0x00000186,
    XCN_OID_KP_TPM_AIK_CERTIFICATE                        = 0x00000187,
    XCN_OID_KP_TPM_EK_CERTIFICATE                         = 0x00000188,
    XCN_OID_KP_TPM_PLATFORM_CERTIFICATE                   = 0x00000189,
    XCN_OID_NIST_AES128_CBC                               = 0x0000018a,
    XCN_OID_NIST_AES128_WRAP                              = 0x0000018b,
    XCN_OID_NIST_AES192_CBC                               = 0x0000018c,
    XCN_OID_NIST_AES192_WRAP                              = 0x0000018d,
    XCN_OID_NIST_AES256_CBC                               = 0x0000018e,
    XCN_OID_NIST_AES256_WRAP                              = 0x0000018f,
    XCN_OID_PKCS_12_PbeIds                                = 0x00000190,
    XCN_OID_PKCS_12_pbeWithSHA1And128BitRC2               = 0x00000191,
    XCN_OID_PKCS_12_pbeWithSHA1And128BitRC4               = 0x00000192,
    XCN_OID_PKCS_12_pbeWithSHA1And2KeyTripleDES           = 0x00000193,
    XCN_OID_PKCS_12_pbeWithSHA1And3KeyTripleDES           = 0x00000194,
    XCN_OID_PKCS_12_pbeWithSHA1And40BitRC2                = 0x00000195,
    XCN_OID_PKCS_12_pbeWithSHA1And40BitRC4                = 0x00000196,
    XCN_OID_PKCS_12_PROTECTED_PASSWORD_SECRET_BAG_TYPE_ID = 0x00000197,
    XCN_OID_PKINIT_KP_KDC                                 = 0x00000198,
    XCN_OID_PKIX_CA_REPOSITORY                            = 0x00000199,
    XCN_OID_PKIX_OCSP_NONCE                               = 0x0000019a,
    XCN_OID_PKIX_TIME_STAMPING                            = 0x0000019b,
    XCN_OID_QC_EU_COMPLIANCE                              = 0x0000019c,
    XCN_OID_QC_SSCD                                       = 0x0000019d,
    XCN_OID_QC_STATEMENTS_EXT                             = 0x0000019e,
    XCN_OID_RDN_TPM_MANUFACTURER                          = 0x0000019f,
    XCN_OID_RDN_TPM_MODEL                                 = 0x000001a0,
    XCN_OID_RDN_TPM_VERSION                               = 0x000001a1,
    XCN_OID_REVOKED_LIST_SIGNER                           = 0x000001a2,
    XCN_OID_RFC3161_counterSign                           = 0x000001a3,
    XCN_OID_ROOT_PROGRAM_AUTO_UPDATE_CA_REVOCATION        = 0x000001a4,
    XCN_OID_ROOT_PROGRAM_AUTO_UPDATE_END_REVOCATION       = 0x000001a5,
    XCN_OID_ROOT_PROGRAM_FLAGS                            = 0x000001a6,
    XCN_OID_ROOT_PROGRAM_NO_OCSP_FAILOVER_TO_CRL          = 0x000001a7,
    XCN_OID_RSA_PSPECIFIED                                = 0x000001a8,
    XCN_OID_RSAES_OAEP                                    = 0x000001a9,
    XCN_OID_SUBJECT_INFO_ACCESS                           = 0x000001aa,
    XCN_OID_TIMESTAMP_TOKEN                               = 0x000001ab,
    XCN_OID_ENROLL_SCEP_ERROR                             = 0x000001ac,
    XCN_OIDVerisign_MessageType                           = 0x000001ad,
    XCN_OIDVerisign_PkiStatus                             = 0x000001ae,
    XCN_OIDVerisign_FailInfo                              = 0x000001af,
    XCN_OIDVerisign_SenderNonce                           = 0x000001b0,
    XCN_OIDVerisign_RecipientNonce                        = 0x000001b1,
    XCN_OIDVerisign_TransactionID                         = 0x000001b2,
    XCN_OID_ENROLL_ATTESTATION_CHALLENGE                  = 0x000001b3,
    XCN_OID_ENROLL_ATTESTATION_STATEMENT                  = 0x000001b4,
    XCN_OID_ENROLL_ENCRYPTION_ALGORITHM                   = 0x000001b5,
    XCN_OID_ENROLL_KSP_NAME                               = 0x000001b6,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-websecuritylevel
enum WebSecurityLevel : int
{
    LevelUnsafe = 0x00000000,
    LevelSafe   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-encodingtype
enum EncodingType : int
{
    XCN_CRYPT_STRING_BASE64HEADER        = 0x00000000,
    XCN_CRYPT_STRING_BASE64              = 0x00000001,
    XCN_CRYPT_STRING_BINARY              = 0x00000002,
    XCN_CRYPT_STRING_BASE64REQUESTHEADER = 0x00000003,
    XCN_CRYPT_STRING_HEX                 = 0x00000004,
    XCN_CRYPT_STRING_HEXASCII            = 0x00000005,
    XCN_CRYPT_STRING_BASE64_ANY          = 0x00000006,
    XCN_CRYPT_STRING_ANY                 = 0x00000007,
    XCN_CRYPT_STRING_HEX_ANY             = 0x00000008,
    XCN_CRYPT_STRING_BASE64X509CRLHEADER = 0x00000009,
    XCN_CRYPT_STRING_HEXADDR             = 0x0000000a,
    XCN_CRYPT_STRING_HEXASCIIADDR        = 0x0000000b,
    XCN_CRYPT_STRING_HEXRAW              = 0x0000000c,
    XCN_CRYPT_STRING_BASE64URI           = 0x0000000d,
    XCN_CRYPT_STRING_ENCODEMASK          = 0x000000ff,
    XCN_CRYPT_STRING_CHAIN               = 0x00000100,
    XCN_CRYPT_STRING_TEXT                = 0x00000200,
    XCN_CRYPT_STRING_PERCENTESCAPE       = 0x08000000,
    XCN_CRYPT_STRING_HASHDATA            = 0x10000000,
    XCN_CRYPT_STRING_STRICT              = 0x20000000,
    XCN_CRYPT_STRING_NOCRLF              = 0x40000000,
    XCN_CRYPT_STRING_NOCR                = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-pfxexportoptions
enum PFXExportOptions : int
{
    PFXExportEEOnly        = 0x00000000,
    PFXExportChainNoRoot   = 0x00000001,
    PFXExportChainWithRoot = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-objectidgroupid
enum ObjectIdGroupId : int
{
    XCN_CRYPT_ANY_GROUP_ID                     = 0x00000000,
    XCN_CRYPT_HASH_ALG_OID_GROUP_ID            = 0x00000001,
    XCN_CRYPT_ENCRYPT_ALG_OID_GROUP_ID         = 0x00000002,
    XCN_CRYPT_PUBKEY_ALG_OID_GROUP_ID          = 0x00000003,
    XCN_CRYPT_SIGN_ALG_OID_GROUP_ID            = 0x00000004,
    XCN_CRYPT_RDN_ATTR_OID_GROUP_ID            = 0x00000005,
    XCN_CRYPT_EXT_OR_ATTR_OID_GROUP_ID         = 0x00000006,
    XCN_CRYPT_ENHKEY_USAGE_OID_GROUP_ID        = 0x00000007,
    XCN_CRYPT_POLICY_OID_GROUP_ID              = 0x00000008,
    XCN_CRYPT_TEMPLATE_OID_GROUP_ID            = 0x00000009,
    XCN_CRYPT_KDF_OID_GROUP_ID                 = 0x0000000a,
    XCN_CRYPT_LAST_OID_GROUP_ID                = 0x0000000a,
    XCN_CRYPT_FIRST_ALG_OID_GROUP_ID           = 0x00000001,
    XCN_CRYPT_LAST_ALG_OID_GROUP_ID            = 0x00000004,
    XCN_CRYPT_GROUP_ID_MASK                    = 0x0000ffff,
    XCN_CRYPT_OID_PREFER_CNG_ALGID_FLAG        = 0x40000000,
    XCN_CRYPT_OID_DISABLE_SEARCH_DS_FLAG       = 0x80000000,
    XCN_CRYPT_OID_INFO_OID_GROUP_BIT_LEN_MASK  = 0x0fff0000,
    XCN_CRYPT_OID_INFO_OID_GROUP_BIT_LEN_SHIFT = 0x00000010,
    XCN_CRYPT_KEY_LENGTH_MASK                  = 0x0fff0000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-objectidpublickeyflags
enum ObjectIdPublicKeyFlags : int
{
    XCN_CRYPT_OID_INFO_PUBKEY_ANY              = 0x00000000,
    XCN_CRYPT_OID_INFO_PUBKEY_SIGN_KEY_FLAG    = 0x80000000,
    XCN_CRYPT_OID_INFO_PUBKEY_ENCRYPT_KEY_FLAG = 0x40000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-algorithmflags
enum AlgorithmFlags : int
{
    AlgorithmFlagsNone = 0x00000000,
    AlgorithmFlagsWrap = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x500nameflags
enum X500NameFlags : int
{
    XCN_CERT_NAME_STR_NONE                      = 0x00000000,
    XCN_CERT_SIMPLE_NAME_STR                    = 0x00000001,
    XCN_CERT_OID_NAME_STR                       = 0x00000002,
    XCN_CERT_X500_NAME_STR                      = 0x00000003,
    XCN_CERT_XML_NAME_STR                       = 0x00000004,
    XCN_CERT_NAME_STR_SEMICOLON_FLAG            = 0x40000000,
    XCN_CERT_NAME_STR_NO_PLUS_FLAG              = 0x20000000,
    XCN_CERT_NAME_STR_NO_QUOTING_FLAG           = 0x10000000,
    XCN_CERT_NAME_STR_CRLF_FLAG                 = 0x08000000,
    XCN_CERT_NAME_STR_COMMA_FLAG                = 0x04000000,
    XCN_CERT_NAME_STR_REVERSE_FLAG              = 0x02000000,
    XCN_CERT_NAME_STR_FORWARD_FLAG              = 0x01000000,
    XCN_CERT_NAME_STR_AMBIGUOUS_SEPARATOR_FLAGS = 0x4c000000,
    XCN_CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG     = 0x00010000,
    XCN_CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG   = 0x00020000,
    XCN_CERT_NAME_STR_ENABLE_UTF8_UNICODE_FLAG  = 0x00040000,
    XCN_CERT_NAME_STR_FORCE_UTF8_DIR_STR_FLAG   = 0x00080000,
    XCN_CERT_NAME_STR_DISABLE_UTF8_DIR_STR_FLAG = 0x00100000,
    XCN_CERT_NAME_STR_ENABLE_PUNYCODE_FLAG      = 0x00200000,
    XCN_CERT_NAME_STR_DS_ESCAPED                = 0x00800000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509certificateenrollmentcontext
enum X509CertificateEnrollmentContext : int
{
    ContextNone                      = 0x00000000,
    ContextUser                      = 0x00000001,
    ContextMachine                   = 0x00000002,
    ContextAdministratorForceMachine = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-enrollmentenrollstatus
enum EnrollmentEnrollStatus : int
{
    Enrolled                           = 0x00000001,
    EnrollPended                       = 0x00000002,
    EnrollUIDeferredEnrollmentRequired = 0x00000004,
    EnrollError                        = 0x00000010,
    EnrollUnknown                      = 0x00000020,
    EnrollSkipped                      = 0x00000040,
    EnrollDenied                       = 0x00000100,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-enrollmentselectionstatus
enum EnrollmentSelectionStatus : int
{
    SelectedNo  = 0x00000000,
    SelectedYes = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-enrollmentdisplaystatus
enum EnrollmentDisplayStatus : int
{
    DisplayNo  = 0x00000000,
    DisplayYes = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509providertype
enum X509ProviderType : int
{
    XCN_PROV_NONE          = 0x00000000,
    XCN_PROV_RSA_FULL      = 0x00000001,
    XCN_PROV_RSA_SIG       = 0x00000002,
    XCN_PROV_DSS           = 0x00000003,
    XCN_PROV_FORTEZZA      = 0x00000004,
    XCN_PROV_MS_EXCHANGE   = 0x00000005,
    XCN_PROV_SSL           = 0x00000006,
    XCN_PROV_RSA_SCHANNEL  = 0x0000000c,
    XCN_PROV_DSS_DH        = 0x0000000d,
    XCN_PROV_EC_ECDSA_SIG  = 0x0000000e,
    XCN_PROV_EC_ECNRA_SIG  = 0x0000000f,
    XCN_PROV_EC_ECDSA_FULL = 0x00000010,
    XCN_PROV_EC_ECNRA_FULL = 0x00000011,
    XCN_PROV_DH_SCHANNEL   = 0x00000012,
    XCN_PROV_SPYRUS_LYNKS  = 0x00000014,
    XCN_PROV_RNG           = 0x00000015,
    XCN_PROV_INTEL_SEC     = 0x00000016,
    XCN_PROV_REPLACE_OWF   = 0x00000017,
    XCN_PROV_RSA_AES       = 0x00000018,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-algorithmtype
enum AlgorithmType : int
{
    XCN_BCRYPT_UNKNOWN_INTERFACE               = 0x00000000,
    XCN_BCRYPT_CIPHER_INTERFACE                = 0x00000001,
    XCN_BCRYPT_HASH_INTERFACE                  = 0x00000002,
    XCN_BCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE = 0x00000003,
    XCN_BCRYPT_SIGNATURE_INTERFACE             = 0x00000005,
    XCN_BCRYPT_SECRET_AGREEMENT_INTERFACE      = 0x00000004,
    XCN_BCRYPT_RNG_INTERFACE                   = 0x00000006,
    XCN_BCRYPT_KEY_DERIVATION_INTERFACE        = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-algorithmoperationflags
enum AlgorithmOperationFlags : int
{
    XCN_NCRYPT_NO_OPERATION                    = 0x00000000,
    XCN_NCRYPT_CIPHER_OPERATION                = 0x00000001,
    XCN_NCRYPT_HASH_OPERATION                  = 0x00000002,
    XCN_NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION = 0x00000004,
    XCN_NCRYPT_SECRET_AGREEMENT_OPERATION      = 0x00000008,
    XCN_NCRYPT_SIGNATURE_OPERATION             = 0x00000010,
    XCN_NCRYPT_RNG_OPERATION                   = 0x00000020,
    XCN_NCRYPT_KEY_DERIVATION_OPERATION        = 0x00000040,
    XCN_NCRYPT_KEY_ENCAPSULATION_OPERATION     = 0x00000080,
    XCN_NCRYPT_ANY_ASYMMETRIC_OPERATION        = 0x0000009c,
    XCN_NCRYPT_PREFER_SIGNATURE_ONLY_OPERATION = 0x00200000,
    XCN_NCRYPT_PREFER_NON_SIGNATURE_OPERATION  = 0x00400000,
    XCN_NCRYPT_EXACT_MATCH_OPERATION           = 0x00800000,
    XCN_NCRYPT_PREFERENCE_MASK_OPERATION       = 0x00e00000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509keyspec
enum X509KeySpec : int
{
    XCN_AT_NONE        = 0x00000000,
    XCN_AT_KEYEXCHANGE = 0x00000001,
    XCN_AT_SIGNATURE   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-keyidentifierhashalgorithm
enum KeyIdentifierHashAlgorithm : int
{
    SKIHashDefault  = 0x00000000,
    SKIHashSha1     = 0x00000001,
    SKIHashCapiSha1 = 0x00000002,
    SKIHashSha256   = 0x00000003,
    SKIHashHPKP     = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509privatekeyexportflags
enum X509PrivateKeyExportFlags : int
{
    XCN_NCRYPT_ALLOW_EXPORT_NONE              = 0x00000000,
    XCN_NCRYPT_ALLOW_EXPORT_FLAG              = 0x00000001,
    XCN_NCRYPT_ALLOW_PLAINTEXT_EXPORT_FLAG    = 0x00000002,
    XCN_NCRYPT_ALLOW_ARCHIVING_FLAG           = 0x00000004,
    XCN_NCRYPT_ALLOW_PLAINTEXT_ARCHIVING_FLAG = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509privatekeyusageflags
enum X509PrivateKeyUsageFlags : int
{
    XCN_NCRYPT_ALLOW_USAGES_NONE        = 0x00000000,
    XCN_NCRYPT_ALLOW_DECRYPT_FLAG       = 0x00000001,
    XCN_NCRYPT_ALLOW_SIGNING_FLAG       = 0x00000002,
    XCN_NCRYPT_ALLOW_KEY_AGREEMENT_FLAG = 0x00000004,
    XCN_NCRYPT_ALLOW_KEY_IMPORT_FLAG    = 0x00000008,
    XCN_NCRYPT_ALLOW_ALL_USAGES         = 0x00ffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509privatekeyprotection
enum X509PrivateKeyProtection : int
{
    XCN_NCRYPT_UI_NO_PROTECTION_FLAG              = 0x00000000,
    XCN_NCRYPT_UI_PROTECT_KEY_FLAG                = 0x00000001,
    XCN_NCRYPT_UI_FORCE_HIGH_PROTECTION_FLAG      = 0x00000002,
    XCN_NCRYPT_UI_FINGERPRINT_PROTECTION_FLAG     = 0x00000004,
    XCN_NCRYPT_UI_APPCONTAINER_ACCESS_MEDIUM_FLAG = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509privatekeyverify
enum X509PrivateKeyVerify : int
{
    VerifyNone            = 0x00000000,
    VerifySilent          = 0x00000001,
    VerifySmartCardNone   = 0x00000002,
    VerifySmartCardSilent = 0x00000003,
    VerifyAllowUI         = 0x00000004,
}

enum X509HardwareKeyUsageFlags : int
{
    XCN_NCRYPT_PCP_NONE           = 0x00000000,
    XCN_NCRYPT_TPM12_PROVIDER     = 0x00010000,
    XCN_NCRYPT_PCP_SIGNATURE_KEY  = 0x00000001,
    XCN_NCRYPT_PCP_ENCRYPTION_KEY = 0x00000002,
    XCN_NCRYPT_PCP_GENERIC_KEY    = 0x00000003,
    XCN_NCRYPT_PCP_STORAGE_KEY    = 0x00000004,
    XCN_NCRYPT_PCP_IDENTITY_KEY   = 0x00000008,
}

enum X509KeyParametersExportType : int
{
    XCN_CRYPT_OID_USE_CURVE_NONE                       = 0x00000000,
    XCN_CRYPT_OID_USE_CURVE_NAME_FOR_ENCODE_FLAG       = 0x20000000,
    XCN_CRYPT_OID_USE_CURVE_PARAMETERS_FOR_ENCODE_FLAG = 0x10000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509keyusageflags
enum X509KeyUsageFlags : int
{
    XCN_CERT_NO_KEY_USAGE                = 0x00000000,
    XCN_CERT_DIGITAL_SIGNATURE_KEY_USAGE = 0x00000080,
    XCN_CERT_NON_REPUDIATION_KEY_USAGE   = 0x00000040,
    XCN_CERT_KEY_ENCIPHERMENT_KEY_USAGE  = 0x00000020,
    XCN_CERT_DATA_ENCIPHERMENT_KEY_USAGE = 0x00000010,
    XCN_CERT_KEY_AGREEMENT_KEY_USAGE     = 0x00000008,
    XCN_CERT_KEY_CERT_SIGN_KEY_USAGE     = 0x00000004,
    XCN_CERT_OFFLINE_CRL_SIGN_KEY_USAGE  = 0x00000002,
    XCN_CERT_CRL_SIGN_KEY_USAGE          = 0x00000002,
    XCN_CERT_ENCIPHER_ONLY_KEY_USAGE     = 0x00000001,
    XCN_CERT_DECIPHER_ONLY_KEY_USAGE     = 0x00008000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-alternativenametype
enum AlternativeNameType : int
{
    XCN_CERT_ALT_NAME_UNKNOWN             = 0x00000000,
    XCN_CERT_ALT_NAME_OTHER_NAME          = 0x00000001,
    XCN_CERT_ALT_NAME_RFC822_NAME         = 0x00000002,
    XCN_CERT_ALT_NAME_DNS_NAME            = 0x00000003,
    XCN_CERT_ALT_NAME_X400_ADDRESS        = 0x00000004,
    XCN_CERT_ALT_NAME_DIRECTORY_NAME      = 0x00000005,
    XCN_CERT_ALT_NAME_EDI_PARTY_NAME      = 0x00000006,
    XCN_CERT_ALT_NAME_URL                 = 0x00000007,
    XCN_CERT_ALT_NAME_IP_ADDRESS          = 0x00000008,
    XCN_CERT_ALT_NAME_REGISTERED_ID       = 0x00000009,
    XCN_CERT_ALT_NAME_GUID                = 0x0000000a,
    XCN_CERT_ALT_NAME_USER_PRINCIPLE_NAME = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-policyqualifiertype
enum PolicyQualifierType : int
{
    PolicyQualifierTypeUnknown    = 0x00000000,
    PolicyQualifierTypeUrl        = 0x00000001,
    PolicyQualifierTypeUserNotice = 0x00000002,
    PolicyQualifierTypeFlags      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-requestclientinfoclientid
enum RequestClientInfoClientId : int
{
    ClientIdNone           = 0x00000000,
    ClientIdXEnroll2003    = 0x00000001,
    ClientIdAutoEnroll2003 = 0x00000002,
    ClientIdWizard2003     = 0x00000003,
    ClientIdCertReq2003    = 0x00000004,
    ClientIdDefaultRequest = 0x00000005,
    ClientIdAutoEnroll     = 0x00000006,
    ClientIdRequestWizard  = 0x00000007,
    ClientIdEOBO           = 0x00000008,
    ClientIdCertReq        = 0x00000009,
    ClientIdTest           = 0x0000000a,
    ClientIdWinRT          = 0x0000000b,
    ClientIdUserStart      = 0x000003e8,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-certenroll_propertyid
alias CERTENROLL_PROPERTYID = int;
enum : int
{
    XCN_PROPERTYID_NONE                                      = 0x00000000,
    XCN_CERT_KEY_PROV_HANDLE_PROP_ID                         = 0x00000001,
    XCN_CERT_KEY_PROV_INFO_PROP_ID                           = 0x00000002,
    XCN_CERT_SHA1_HASH_PROP_ID                               = 0x00000003,
    XCN_CERT_MD5_HASH_PROP_ID                                = 0x00000004,
    XCN_CERT_HASH_PROP_ID                                    = 0x00000003,
    XCN_CERT_KEY_CONTEXT_PROP_ID                             = 0x00000005,
    XCN_CERT_KEY_SPEC_PROP_ID                                = 0x00000006,
    XCN_CERT_IE30_RESERVED_PROP_ID                           = 0x00000007,
    XCN_CERT_PUBKEY_HASH_RESERVED_PROP_ID                    = 0x00000008,
    XCN_CERT_ENHKEY_USAGE_PROP_ID                            = 0x00000009,
    XCN_CERT_CTL_USAGE_PROP_ID                               = 0x00000009,
    XCN_CERT_NEXT_UPDATE_LOCATION_PROP_ID                    = 0x0000000a,
    XCN_CERT_FRIENDLY_NAME_PROP_ID                           = 0x0000000b,
    XCN_CERT_PVK_FILE_PROP_ID                                = 0x0000000c,
    XCN_CERT_DESCRIPTION_PROP_ID                             = 0x0000000d,
    XCN_CERT_ACCESS_STATE_PROP_ID                            = 0x0000000e,
    XCN_CERT_SIGNATURE_HASH_PROP_ID                          = 0x0000000f,
    XCN_CERT_SMART_CARD_DATA_PROP_ID                         = 0x00000010,
    XCN_CERT_EFS_PROP_ID                                     = 0x00000011,
    XCN_CERT_FORTEZZA_DATA_PROP_ID                           = 0x00000012,
    XCN_CERT_ARCHIVED_PROP_ID                                = 0x00000013,
    XCN_CERT_KEY_IDENTIFIER_PROP_ID                          = 0x00000014,
    XCN_CERT_AUTO_ENROLL_PROP_ID                             = 0x00000015,
    XCN_CERT_PUBKEY_ALG_PARA_PROP_ID                         = 0x00000016,
    XCN_CERT_CROSS_CERT_DIST_POINTS_PROP_ID                  = 0x00000017,
    XCN_CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID              = 0x00000018,
    XCN_CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID             = 0x00000019,
    XCN_CERT_ENROLLMENT_PROP_ID                              = 0x0000001a,
    XCN_CERT_DATE_STAMP_PROP_ID                              = 0x0000001b,
    XCN_CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID           = 0x0000001c,
    XCN_CERT_SUBJECT_NAME_MD5_HASH_PROP_ID                   = 0x0000001d,
    XCN_CERT_EXTENDED_ERROR_INFO_PROP_ID                     = 0x0000001e,
    XCN_CERT_RENEWAL_PROP_ID                                 = 0x00000040,
    XCN_CERT_ARCHIVED_KEY_HASH_PROP_ID                       = 0x00000041,
    XCN_CERT_AUTO_ENROLL_RETRY_PROP_ID                       = 0x00000042,
    XCN_CERT_AIA_URL_RETRIEVED_PROP_ID                       = 0x00000043,
    XCN_CERT_AUTHORITY_INFO_ACCESS_PROP_ID                   = 0x00000044,
    XCN_CERT_BACKED_UP_PROP_ID                               = 0x00000045,
    XCN_CERT_OCSP_RESPONSE_PROP_ID                           = 0x00000046,
    XCN_CERT_REQUEST_ORIGINATOR_PROP_ID                      = 0x00000047,
    XCN_CERT_SOURCE_LOCATION_PROP_ID                         = 0x00000048,
    XCN_CERT_SOURCE_URL_PROP_ID                              = 0x00000049,
    XCN_CERT_NEW_KEY_PROP_ID                                 = 0x0000004a,
    XCN_CERT_OCSP_CACHE_PREFIX_PROP_ID                       = 0x0000004b,
    XCN_CERT_SMART_CARD_ROOT_INFO_PROP_ID                    = 0x0000004c,
    XCN_CERT_NO_AUTO_EXPIRE_CHECK_PROP_ID                    = 0x0000004d,
    XCN_CERT_NCRYPT_KEY_HANDLE_PROP_ID                       = 0x0000004e,
    XCN_CERT_HCRYPTPROV_OR_NCRYPT_KEY_HANDLE_PROP_ID         = 0x0000004f,
    XCN_CERT_SUBJECT_INFO_ACCESS_PROP_ID                     = 0x00000050,
    XCN_CERT_CA_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID           = 0x00000051,
    XCN_CERT_CA_DISABLE_CRL_PROP_ID                          = 0x00000052,
    XCN_CERT_ROOT_PROGRAM_CERT_POLICIES_PROP_ID              = 0x00000053,
    XCN_CERT_ROOT_PROGRAM_NAME_CONSTRAINTS_PROP_ID           = 0x00000054,
    XCN_CERT_SUBJECT_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID      = 0x00000055,
    XCN_CERT_SUBJECT_DISABLE_CRL_PROP_ID                     = 0x00000056,
    XCN_CERT_CEP_PROP_ID                                     = 0x00000057,
    XCN_CERT_SIGN_HASH_CNG_ALG_PROP_ID                       = 0x00000059,
    XCN_CERT_SCARD_PIN_ID_PROP_ID                            = 0x0000005a,
    XCN_CERT_SCARD_PIN_INFO_PROP_ID                          = 0x0000005b,
    XCN_CERT_SUBJECT_PUB_KEY_BIT_LENGTH_PROP_ID              = 0x0000005c,
    XCN_CERT_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID              = 0x0000005d,
    XCN_CERT_ISSUER_PUB_KEY_BIT_LENGTH_PROP_ID               = 0x0000005e,
    XCN_CERT_ISSUER_CHAIN_SIGN_HASH_CNG_ALG_PROP_ID          = 0x0000005f,
    XCN_CERT_ISSUER_CHAIN_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID = 0x00000060,
    XCN_CERT_NO_EXPIRE_NOTIFICATION_PROP_ID                  = 0x00000061,
    XCN_CERT_AUTH_ROOT_SHA256_HASH_PROP_ID                   = 0x00000062,
    XCN_CERT_NCRYPT_KEY_HANDLE_TRANSFER_PROP_ID              = 0x00000063,
    XCN_CERT_HCRYPTPROV_TRANSFER_PROP_ID                     = 0x00000064,
    XCN_CERT_SMART_CARD_READER_PROP_ID                       = 0x00000065,
    XCN_CERT_SEND_AS_TRUSTED_ISSUER_PROP_ID                  = 0x00000066,
    XCN_CERT_KEY_REPAIR_ATTEMPTED_PROP_ID                    = 0x00000067,
    XCN_CERT_DISALLOWED_FILETIME_PROP_ID                     = 0x00000068,
    XCN_CERT_ROOT_PROGRAM_CHAIN_POLICIES_PROP_ID             = 0x00000069,
    XCN_CERT_SMART_CARD_READER_NON_REMOVABLE_PROP_ID         = 0x0000006a,
    XCN_CERT_SHA256_HASH_PROP_ID                             = 0x0000006b,
    XCN_CERT_SCEP_SERVER_CERTS_PROP_ID                       = 0x0000006c,
    XCN_CERT_SCEP_RA_SIGNATURE_CERT_PROP_ID                  = 0x0000006d,
    XCN_CERT_SCEP_RA_ENCRYPTION_CERT_PROP_ID                 = 0x0000006e,
    XCN_CERT_SCEP_CA_CERT_PROP_ID                            = 0x0000006f,
    XCN_CERT_SCEP_SIGNER_CERT_PROP_ID                        = 0x00000070,
    XCN_CERT_SCEP_NONCE_PROP_ID                              = 0x00000071,
    XCN_CERT_SCEP_ENCRYPT_HASH_CNG_ALG_PROP_ID               = 0x00000072,
    XCN_CERT_SCEP_FLAGS_PROP_ID                              = 0x00000073,
    XCN_CERT_SCEP_GUID_PROP_ID                               = 0x00000074,
    XCN_CERT_SERIALIZABLE_KEY_CONTEXT_PROP_ID                = 0x00000075,
    XCN_CERT_ISOLATED_KEY_PROP_ID                            = 0x00000076,
    XCN_CERT_SERIAL_CHAIN_PROP_ID                            = 0x00000077,
    XCN_CERT_KEY_CLASSIFICATION_PROP_ID                      = 0x00000078,
    XCN_CERT_DISALLOWED_ENHKEY_USAGE_PROP_ID                 = 0x0000007a,
    XCN_CERT_NONCOMPLIANT_ROOT_URL_PROP_ID                   = 0x0000007b,
    XCN_CERT_PIN_SHA256_HASH_PROP_ID                         = 0x0000007c,
    XCN_CERT_CLR_DELETE_KEY_PROP_ID                          = 0x0000007d,
    XCN_CERT_NOT_BEFORE_FILETIME_PROP_ID                     = 0x0000007e,
    XCN_CERT_CERT_NOT_BEFORE_ENHKEY_USAGE_PROP_ID            = 0x0000007f,
    XCN_CERT_FIRST_RESERVED_PROP_ID                          = 0x00000082,
    XCN_CERT_LAST_RESERVED_PROP_ID                           = 0x00007fff,
    XCN_CERT_FIRST_USER_PROP_ID                              = 0x00008000,
    XCN_CERT_LAST_USER_PROP_ID                               = 0x0000ffff,
    XCN_CERT_STORE_LOCALIZED_NAME_PROP_ID                    = 0x00001000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-enrollmentpolicyserverpropertyflags
enum EnrollmentPolicyServerPropertyFlags : int
{
    DefaultNone         = 0x00000000,
    DefaultPolicyServer = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-policyserverurlflags
enum PolicyServerUrlFlags : int
{
    PsfNone                  = 0x00000000,
    PsfLocationGroupPolicy   = 0x00000001,
    PsfLocationRegistry      = 0x00000002,
    PsfUseClientId           = 0x00000004,
    PsfAutoEnrollmentEnabled = 0x00000010,
    PsfAllowUnTrustedCA      = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-enrollmenttemplateproperty
enum EnrollmentTemplateProperty : int
{
    TemplatePropCommonName            = 0x00000001,
    TemplatePropFriendlyName          = 0x00000002,
    TemplatePropEKUs                  = 0x00000003,
    TemplatePropCryptoProviders       = 0x00000004,
    TemplatePropMajorRevision         = 0x00000005,
    TemplatePropDescription           = 0x00000006,
    TemplatePropKeySpec               = 0x00000007,
    TemplatePropSchemaVersion         = 0x00000008,
    TemplatePropMinorRevision         = 0x00000009,
    TemplatePropRASignatureCount      = 0x0000000a,
    TemplatePropMinimumKeySize        = 0x0000000b,
    TemplatePropOID                   = 0x0000000c,
    TemplatePropSupersede             = 0x0000000d,
    TemplatePropRACertificatePolicies = 0x0000000e,
    TemplatePropRAEKUs                = 0x0000000f,
    TemplatePropCertificatePolicies   = 0x00000010,
    TemplatePropV1ApplicationPolicy   = 0x00000011,
    TemplatePropAsymmetricAlgorithm   = 0x00000012,
    TemplatePropKeySecurityDescriptor = 0x00000013,
    TemplatePropSymmetricAlgorithm    = 0x00000014,
    TemplatePropSymmetricKeyLength    = 0x00000015,
    TemplatePropHashAlgorithm         = 0x00000016,
    TemplatePropKeyUsage              = 0x00000017,
    TemplatePropEnrollmentFlags       = 0x00000018,
    TemplatePropSubjectNameFlags      = 0x00000019,
    TemplatePropPrivateKeyFlags       = 0x0000001a,
    TemplatePropGeneralFlags          = 0x0000001b,
    TemplatePropSecurityDescriptor    = 0x0000001c,
    TemplatePropExtensions            = 0x0000001d,
    TemplatePropValidityPeriod        = 0x0000001e,
    TemplatePropRenewalPeriod         = 0x0000001f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-committemplateflags
enum CommitTemplateFlags : int
{
    CommitFlagSaveTemplateGenerateOID   = 0x00000001,
    CommitFlagSaveTemplateUseCurrentOID = 0x00000002,
    CommitFlagSaveTemplateOverwrite     = 0x00000003,
    CommitFlagDeleteTemplate            = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-enrollmentcaproperty
enum EnrollmentCAProperty : int
{
    CAPropCommonName         = 0x00000001,
    CAPropDistinguishedName  = 0x00000002,
    CAPropSanitizedName      = 0x00000003,
    CAPropSanitizedShortName = 0x00000004,
    CAPropDNSName            = 0x00000005,
    CAPropCertificateTypes   = 0x00000006,
    CAPropCertificate        = 0x00000007,
    CAPropDescription        = 0x00000008,
    CAPropWebServers         = 0x00000009,
    CAPropSiteName           = 0x0000000a,
    CAPropSecurity           = 0x0000000b,
    CAPropRenewalOnly        = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509enrollmentpolicyloadoption
enum X509EnrollmentPolicyLoadOption : int
{
    LoadOptionDefault              = 0x00000000,
    LoadOptionCacheOnly            = 0x00000001,
    LoadOptionReload               = 0x00000002,
    LoadOptionRegisterForADChanges = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-enrollmentpolicyflags
enum EnrollmentPolicyFlags : int
{
    DisableGroupPolicyList = 0x00000002,
    DisableUserServerList  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-policyserverurlpropertyid
alias PolicyServerUrlPropertyID = int;
enum : int
{
    PsPolicyID     = 0x00000000,
    PsFriendlyName = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509enrollmentpolicyexportflags
enum X509EnrollmentPolicyExportFlags : int
{
    ExportTemplates = 0x00000001,
    ExportOIDs      = 0x00000002,
    ExportCAs       = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509requesttype
enum X509RequestType : int
{
    TypeAny         = 0x00000000,
    TypePkcs10      = 0x00000001,
    TypePkcs7       = 0x00000002,
    TypeCmc         = 0x00000003,
    TypeCertificate = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509requestinheritoptions
enum X509RequestInheritOptions : int
{
    InheritDefault                = 0x00000000,
    InheritNewDefaultKey          = 0x00000001,
    InheritNewSimilarKey          = 0x00000002,
    InheritPrivateKey             = 0x00000003,
    InheritPublicKey              = 0x00000004,
    InheritKeyMask                = 0x0000000f,
    InheritNone                   = 0x00000010,
    InheritRenewalCertificateFlag = 0x00000020,
    InheritTemplateFlag           = 0x00000040,
    InheritSubjectFlag            = 0x00000080,
    InheritExtensionsFlag         = 0x00000100,
    InheritSubjectAltNameFlag     = 0x00000200,
    InheritValidityPeriodFlag     = 0x00000400,
    InheritReserved80000000       = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-innerrequestlevel
enum InnerRequestLevel : int
{
    LevelInnermost = 0x00000000,
    LevelNext      = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-pkcs10allowedsignaturetypes
enum Pkcs10AllowedSignatureTypes : int
{
    AllowedKeySignature  = 0x00000001,
    AllowedNullSignature = 0x00000002,
}

enum KeyAttestationClaimType : int
{
    XCN_NCRYPT_CLAIM_NONE                  = 0x00000000,
    XCN_NCRYPT_CLAIM_AUTHORITY_AND_SUBJECT = 0x00000003,
    XCN_NCRYPT_CLAIM_AUTHORITY_ONLY        = 0x00000001,
    XCN_NCRYPT_CLAIM_SUBJECT_ONLY          = 0x00000002,
    XCN_NCRYPT_CLAIM_UNKNOWN               = 0x00001000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-installresponserestrictionflags
enum InstallResponseRestrictionFlags : int
{
    AllowNone                 = 0x00000000,
    AllowNoOutstandingRequest = 0x00000001,
    AllowUntrustedCertificate = 0x00000002,
    AllowUntrustedRoot        = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-webenrollmentflags
enum WebEnrollmentFlags : int
{
    EnrollPrompt = 0x00000001,
}

enum CRLRevocationReason : int
{
    XCN_CRL_REASON_UNSPECIFIED            = 0x00000000,
    XCN_CRL_REASON_KEY_COMPROMISE         = 0x00000001,
    XCN_CRL_REASON_CA_COMPROMISE          = 0x00000002,
    XCN_CRL_REASON_AFFILIATION_CHANGED    = 0x00000003,
    XCN_CRL_REASON_SUPERSEDED             = 0x00000004,
    XCN_CRL_REASON_CESSATION_OF_OPERATION = 0x00000005,
    XCN_CRL_REASON_CERTIFICATE_HOLD       = 0x00000006,
    XCN_CRL_REASON_REMOVE_FROM_CRL        = 0x00000008,
    XCN_CRL_REASON_PRIVILEGE_WITHDRAWN    = 0x00000009,
    XCN_CRL_REASON_AA_COMPROMISE          = 0x0000000a,
}

enum X509SCEPProcessMessageFlags : int
{
    SCEPProcessDefault         = 0x00000000,
    SCEPProcessSkipCertInstall = 0x00000001,
}

enum DelayRetryAction : int
{
    DelayRetryUnknown     = 0x00000000,
    DelayRetryNone        = 0x00000001,
    DelayRetryShort       = 0x00000002,
    DelayRetryLong        = 0x00000003,
    DelayRetrySuccess     = 0x00000004,
    DelayRetryPastSuccess = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509certificatetemplategeneralflag
enum X509CertificateTemplateGeneralFlag : int
{
    GeneralMachineType  = 0x00000040,
    GeneralCA           = 0x00000080,
    GeneralCrossCA      = 0x00000800,
    GeneralDefault      = 0x00010000,
    GeneralModified     = 0x00020000,
    GeneralDonotPersist = 0x00001000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509certificatetemplateenrollmentflag
enum X509CertificateTemplateEnrollmentFlag : int
{
    EnrollmentIncludeSymmetricAlgorithms                   = 0x00000001,
    EnrollmentPendAllRequests                              = 0x00000002,
    EnrollmentPublishToKRAContainer                        = 0x00000004,
    EnrollmentPublishToDS                                  = 0x00000008,
    EnrollmentAutoEnrollmentCheckUserDSCertificate         = 0x00000010,
    EnrollmentAutoEnrollment                               = 0x00000020,
    EnrollmentDomainAuthenticationNotRequired              = 0x00000080,
    EnrollmentPreviousApprovalValidateReenrollment         = 0x00000040,
    EnrollmentUserInteractionRequired                      = 0x00000100,
    EnrollmentAddTemplateName                              = 0x00000200,
    EnrollmentRemoveInvalidCertificateFromPersonalStore    = 0x00000400,
    EnrollmentAllowEnrollOnBehalfOf                        = 0x00000800,
    EnrollmentAddOCSPNoCheck                               = 0x00001000,
    EnrollmentReuseKeyOnFullSmartCard                      = 0x00002000,
    EnrollmentNoRevocationInfoInCerts                      = 0x00004000,
    EnrollmentIncludeBasicConstraintsForEECerts            = 0x00008000,
    EnrollmentPreviousApprovalKeyBasedValidateReenrollment = 0x00010000,
    EnrollmentCertificateIssuancePoliciesFromRequest       = 0x00020000,
    EnrollmentSkipAutoRenewal                              = 0x00040000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509certificatetemplatesubjectnameflag
enum X509CertificateTemplateSubjectNameFlag : int
{
    SubjectNameEnrolleeSupplies                  = 0x00000001,
    SubjectNameRequireDirectoryPath              = 0x80000000,
    SubjectNameRequireCommonName                 = 0x40000000,
    SubjectNameRequireEmail                      = 0x20000000,
    SubjectNameRequireDNS                        = 0x10000000,
    SubjectNameAndAlternativeNameOldCertSupplies = 0x00000008,
    SubjectAlternativeNameEnrolleeSupplies       = 0x00010000,
    SubjectAlternativeNameRequireDirectoryGUID   = 0x01000000,
    SubjectAlternativeNameRequireUPN             = 0x02000000,
    SubjectAlternativeNameRequireEmail           = 0x04000000,
    SubjectAlternativeNameRequireSPN             = 0x00800000,
    SubjectAlternativeNameRequireDNS             = 0x08000000,
    SubjectAlternativeNameRequireDomainDNS       = 0x00400000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-x509certificatetemplateprivatekeyflag
enum X509CertificateTemplatePrivateKeyFlag : int
{
    PrivateKeyRequireArchival                    = 0x00000001,
    PrivateKeyExportable                         = 0x00000010,
    PrivateKeyRequireStrongKeyProtection         = 0x00000020,
    PrivateKeyRequireAlternateSignatureAlgorithm = 0x00000040,
    PrivateKeyRequireSameKeyRenewal              = 0x00000080,
    PrivateKeyUseLegacyProvider                  = 0x00000100,
    PrivateKeyEKTrustOnUse                       = 0x00000200,
    PrivateKeyEKValidateCert                     = 0x00000400,
    PrivateKeyEKValidateKey                      = 0x00000800,
    PrivateKeyAttestNone                         = 0x00000000,
    PrivateKeyAttestPreferred                    = 0x00001000,
    PrivateKeyAttestRequired                     = 0x00002000,
    PrivateKeyAttestMask                         = 0x00003000,
    PrivateKeyAttestWithoutPolicy                = 0x00004000,
    PrivateKeyServerVersionMask                  = 0x000f0000,
    PrivateKeyServerVersionShift                 = 0x00000010,
    PrivateKeyHelloKspKey                        = 0x00100000,
    PrivateKeyHelloLogonKey                      = 0x00200000,
    PrivateKeyClientVersionMask                  = 0x0f000000,
    PrivateKeyClientVersionShift                 = 0x00000018,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/ne-certenroll-importpfxflags
enum ImportPFXFlags : int
{
    ImportNone                = 0x00000000,
    ImportMachineContext      = 0x00000001,
    ImportForceOverwrite      = 0x00000002,
    ImportSilent              = 0x00000004,
    ImportSaveProperties      = 0x00000008,
    ImportExportable          = 0x00000010,
    ImportExportableEncrypted = 0x00000020,
    ImportNoUserProtected     = 0x00000040,
    ImportUserProtected       = 0x00000080,
    ImportUserProtectedHigh   = 0x00000100,
    ImportInstallCertificate  = 0x00000200,
    ImportInstallChain        = 0x00000400,
    ImportInstallChainAndRoot = 0x00000800,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certsrv/ne-certsrv-enum_catypes
alias ENUM_CATYPES = int;
enum : int
{
    ENUM_ENTERPRISE_ROOTCA = 0x00000000,
    ENUM_ENTERPRISE_SUBCA  = 0x00000001,
    ENUM_STANDALONE_ROOTCA = 0x00000003,
    ENUM_STANDALONE_SUBCA  = 0x00000004,
    ENUM_UNKNOWN_CA        = 0x00000005,
}

// Constants


enum const(wchar)* wszREGKEYNOSYSTEMCERTSVCPATH = "CurrentControlSet\\Services\\CertSvc";
enum const(wchar)* wszREGKEYCERTSVCPATH = "SYSTEM\\CurrentControlSet\\Services\\CertSvc";

enum : uint
{
    CA_DISP_INCOMPLETE       = 0x00000000U,
    CA_DISP_ERROR            = 0x00000001U,
    CA_DISP_REVOKED          = 0x00000002U,
    CA_DISP_VALID            = 0x00000003U,
    CA_DISP_INVALID          = 0x00000004U,
    CA_DISP_UNDER_SUBMISSION = 0x00000005U,
}

enum : uint
{
    KRA_DISP_EXPIRED   = 0x00000000U,
    KRA_DISP_NOTFOUND  = 0x00000001U,
    KRA_DISP_REVOKED   = 0x00000002U,
    KRA_DISP_VALID     = 0x00000003U,
    KRA_DISP_INVALID   = 0x00000004U,
    KRA_DISP_UNTRUSTED = 0x00000005U,
    KRA_DISP_NOTLOADED = 0x00000006U,
}

enum uint CA_ACCESS_MASKROLES = 0x000000ffU;

enum : uint
{
    CA_CRL_BASE      = 0x00000001U,
    CA_CRL_DELTA     = 0x00000002U,
    CA_CRL_REPUBLISH = 0x00000010U,
}

enum uint ICF_ALLOWFOREIGN = 0x00010000U;
enum uint ICF_EXISTINGROW = 0x00020000U;
enum uint IKF_OVERWRITE = 0x00010000U;

enum : const(wchar)*
{
    wszOCSPCAPROP_CACERTIFICATE              = "CACertificate",
    wszOCSPCAPROP_HASHALGORITHMID            = "HashAlgorithmId",
    wszOCSPCAPROP_SIGNINGFLAGS               = "SigningFlags",
    wszOCSPCAPROP_REMINDERDURATION           = "ReminderDuration",
    wszOCSPCAPROP_SIGNINGCERTIFICATE         = "SigningCertificate",
    wszOCSPCAPROP_CSPNAME                    = "CSPName",
    wszOCSPCAPROP_KEYSPEC                    = "KeySpec",
    wszOCSPCAPROP_ERRORCODE                  = "ErrorCode",
    wszOCSPCAPROP_PROVIDERCLSID              = "ProviderCLSID",
    wszOCSPCAPROP_PROVIDERPROPERTIES         = "Provider",
    wszOCSPCAPROP_LOCALREVOCATIONINFORMATION = "LocalRevocationInformation",
}

enum const(wchar)* wszOCSPCAPROP_SIGNINGCERTIFICATETEMPLATE = "SigningCertificateTemplate";
enum const(wchar)* wszOCSPCAPROP_CACONFIG = "CAConfig";

enum : const(wchar)*
{
    wszOCSPPROP_LOGLEVEL           = "LogLevel",
    wszOCSPPROP_DEBUG              = "Debug",
    wszOCSPPROP_AUDITFILTER        = "AuditFilter",
    wszOCSPPROP_ARRAYCONTROLLER    = "ArrayController",
    wszOCSPPROP_ARRAYMEMBERS       = "ArrayMembers",
    wszOCSPPROP_ENROLLPOLLINTERVAL = "EnrollPollInterval",
}

enum : const(wchar)*
{
    wszOCSPISAPIPROP_VIRTUALROOTNAME         = "VirtualRootName",
    wszOCSPISAPIPROP_NUMOFTHREADS            = "NumOfThreads",
    wszOCSPISAPIPROP_NUMOFBACKENDCONNECTIONS = "NumOfBackendConnections",
    wszOCSPISAPIPROP_REFRESHRATE             = "RefreshRate",
    wszOCSPISAPIPROP_MAXNUMOFCACHEENTRIES    = "MaxNumOfCacheEntries",
    wszOCSPISAPIPROP_MAXAGE                  = "MaxAge",
    wszOCSPISAPIPROP_DEBUG                   = "ISAPIDebug",
}

enum : const(wchar)*
{
    wszOCSPCOMMONPROP_REQFLAGS               = "RequestFlags",
    wszOCSPCOMMONPROP_MAXINCOMINGMESSAGESIZE = "MaxIncomingMessageSize",
    wszOCSPCOMMONPROP_MAXNUMOFREQUESTENTRIES = "MaxNumOfRequestEntries",
}

enum : const(wchar)*
{
    wszOCSPREVPROP_CRLURLTIMEOUT     = "CrlUrlTimeOut",
    wszOCSPREVPROP_BASECRLURLS       = "BaseCrlUrls",
    wszOCSPREVPROP_SERIALNUMBERSDIRS = "IssuedSerialNumbersDirectories",
    wszOCSPREVPROP_BASECRL           = "BaseCrl",
    wszOCSPREVPROP_DELTACRLURLS      = "DeltaCrlUrls",
    wszOCSPREVPROP_DELTACRL          = "DeltaCrl",
    wszOCSPREVPROP_REFRESHTIMEOUT    = "RefreshTimeOut",
    wszOCSPREVPROP_ERRORCODE         = "RevocationErrorCode",
    wszOCSPREVPROP_ALLOWUSERONLYCRLS = "AllowUserOnlyCrls",
    wszOCSPREVPROP_ALLOWCAONLYCRLS   = "AllowCAOnlyCrls",
}

// Native encoding: ansi
enum const(wchar)* szBACKUPANNOTATION = "Cert Server Backup Interface";
// Native encoding: ansi
enum const(wchar)* szRESTOREANNOTATION = "Cert Server Restore Interface";
enum uint CSBACKUP_TYPE_MASK = 0x00000003U;

enum : uint
{
    CSRESTORE_TYPE_FULL    = 0x00000001U,
    CSRESTORE_TYPE_ONLINE  = 0x00000002U,
    CSRESTORE_TYPE_CATCHUP = 0x00000004U,
    CSRESTORE_TYPE_MASK    = 0x00000005U,
}

enum uint CSBACKUP_DISABLE_INCREMENTAL = 0xffffffffU;

enum : uint
{
    CSBFT_DIRECTORY          = 0x00000080U,
    CSBFT_DATABASE_DIRECTORY = 0x00000040U,
}

enum uint CSBFT_LOG_DIRECTORY = 0x00000020U;

enum : ulong
{
    CSCONTROL_SHUTDOWN = 0x0000000000000001UL,
    CSCONTROL_SUSPEND  = 0x0000000000000002UL,
    CSCONTROL_RESTART  = 0x0000000000000003UL,
}

enum : const(wchar)*
{
    wszCONFIG_COMMONNAME          = "CommonName",
    wszCONFIG_ORGUNIT             = "OrgUnit",
    wszCONFIG_ORGANIZATION        = "Organization",
    wszCONFIG_LOCALITY            = "Locality",
    wszCONFIG_STATE               = "State",
    wszCONFIG_COUNTRY             = "Country",
    wszCONFIG_CONFIG              = "Config",
    wszCONFIG_EXCHANGECERTIFICATE = "ExchangeCertificate",
}

enum const(wchar)* wszCONFIG_SIGNATURECERTIFICATE = "SignatureCertificate";

enum : const(wchar)*
{
    wszCONFIG_DESCRIPTION        = "Description",
    wszCONFIG_COMMENT            = "Comment",
    wszCONFIG_SERVER             = "Server",
    wszCONFIG_AUTHORITY          = "Authority",
    wszCONFIG_SANITIZEDNAME      = "SanitizedName",
    wszCONFIG_SHORTNAME          = "ShortName",
    wszCONFIG_SANITIZEDSHORTNAME = "SanitizedShortName",
}

enum : const(wchar)*
{
    wszCONFIG_FLAGS                = "Flags",
    wszCONFIG_WEBENROLLMENTSERVERS = "WebEnrollmentServers",
}

enum : uint
{
    CAIF_DSENTRY           = 0x00000001U,
    CAIF_SHAREDFOLDERENTRY = 0x00000002U,
}

enum uint CAIF_REGISTRY = 0x00000004U;

enum : uint
{
    CAIF_LOCAL          = 0x00000008U,
    CAIF_REGISTRYPARENT = 0x00000010U,
}

enum : uint
{
    CR_IN_ENCODEANY  = 0x000000ffU,
    CR_IN_ENCODEMASK = 0x000000ffU,
}

enum uint CR_IN_FORMATANY = 0x00000000U;

enum : uint
{
    CR_IN_PKCS10            = 0x00000100U,
    CR_IN_KEYGEN            = 0x00000200U,
    CR_IN_PKCS7             = 0x00000300U,
    CR_IN_CMC               = 0x00000400U,
    CR_IN_CHALLENGERESPONSE = 0x00000500U,
}

enum uint CR_IN_SIGNEDCERTIFICATETIMESTAMPLIST = 0x00000600U;
enum uint CR_IN_FORMATMASK = 0x0000ff00U;

enum : uint
{
    CR_IN_SCEP         = 0x00010000U,
    CR_IN_RPC          = 0x00020000U,
    CR_IN_HTTP         = 0x00030000U,
    CR_IN_FULLRESPONSE = 0x00040000U,
}

enum : uint
{
    CR_IN_CRLS         = 0x00080000U,
    CR_IN_MACHINE      = 0x00100000U,
    CR_IN_ROBO         = 0x00200000U,
    CR_IN_CLIENTIDNONE = 0x00400000U,
}

enum uint CR_IN_CONNECTONLY = 0x00800000U;
enum uint CR_IN_RETURNCHALLENGE = 0x01000000U;

enum : uint
{
    CR_IN_SCEPPOST                = 0x02000000U,
    CR_IN_CERTIFICATETRANSPARENCY = 0x04000000U,
}

enum uint CR_IN_PRESIGN = 0x08000000U;
enum uint CR_DISP_REVOKED = 0x00000006U;
enum uint CR_OUT_BASE64REQUESTHEADER = 0x00000003U;

enum : uint
{
    CR_OUT_HEX                 = 0x00000004U,
    CR_OUT_HEXASCII            = 0x00000005U,
    CR_OUT_BASE64X509CRLHEADER = 0x00000009U,
}

enum : uint
{
    CR_OUT_HEXADDR      = 0x0000000aU,
    CR_OUT_HEXASCIIADDR = 0x0000000bU,
    CR_OUT_HEXRAW       = 0x0000000cU,
    CR_OUT_ENCODEMASK   = 0x000000ffU,
    CR_OUT_CHAIN        = 0x00000100U,
    CR_OUT_CRLS         = 0x00000200U,
    CR_OUT_NOCRLF       = 0x40000000U,
    CR_OUT_NOCR         = 0x80000000U,
}

enum : uint
{
    CR_GEMT_DEFAULT        = 0x00000000U,
    CR_GEMT_HRESULT_STRING = 0x00000001U,
    CR_GEMT_HTTP_ERROR     = 0x00000002U,
}

enum : uint
{
    CR_PROP_NONE           = 0x00000000U,
    CR_PROP_FILEVERSION    = 0x00000001U,
    CR_PROP_PRODUCTVERSION = 0x00000002U,
}

enum : uint
{
    CR_PROP_EXITCOUNT       = 0x00000003U,
    CR_PROP_EXITDESCRIPTION = 0x00000004U,
}

enum uint CR_PROP_POLICYDESCRIPTION = 0x00000005U;

enum : uint
{
    CR_PROP_CANAME          = 0x00000006U,
    CR_PROP_SANITIZEDCANAME = 0x00000007U,
}

enum uint CR_PROP_SHAREDFOLDER = 0x00000008U;

enum : uint
{
    CR_PROP_PARENTCA        = 0x00000009U,
    CR_PROP_CATYPE          = 0x0000000aU,
    CR_PROP_CASIGCERTCOUNT  = 0x0000000bU,
    CR_PROP_CASIGCERT       = 0x0000000cU,
    CR_PROP_CASIGCERTCHAIN  = 0x0000000dU,
    CR_PROP_CAXCHGCERTCOUNT = 0x0000000eU,
    CR_PROP_CAXCHGCERT      = 0x0000000fU,
    CR_PROP_CAXCHGCERTCHAIN = 0x00000010U,
}

enum : uint
{
    CR_PROP_BASECRL               = 0x00000011U,
    CR_PROP_DELTACRL              = 0x00000012U,
    CR_PROP_CACERTSTATE           = 0x00000013U,
    CR_PROP_CRLSTATE              = 0x00000014U,
    CR_PROP_CAPROPIDMAX           = 0x00000015U,
    CR_PROP_DNSNAME               = 0x00000016U,
    CR_PROP_ROLESEPARATIONENABLED = 0x00000017U,
}

enum : uint
{
    CR_PROP_KRACERTUSEDCOUNT = 0x00000018U,
    CR_PROP_KRACERTCOUNT     = 0x00000019U,
    CR_PROP_KRACERT          = 0x0000001aU,
    CR_PROP_KRACERTSTATE     = 0x0000001bU,
}

enum uint CR_PROP_ADVANCEDSERVER = 0x0000001cU;

enum : uint
{
    CR_PROP_TEMPLATES            = 0x0000001dU,
    CR_PROP_BASECRLPUBLISHSTATUS = 0x0000001eU,
}

enum uint CR_PROP_DELTACRLPUBLISHSTATUS = 0x0000001fU;
enum uint CR_PROP_CASIGCERTCRLCHAIN = 0x00000020U;
enum uint CR_PROP_CAXCHGCERTCRLCHAIN = 0x00000021U;

enum : uint
{
    CR_PROP_CACERTSTATUSCODE   = 0x00000022U,
    CR_PROP_CAFORWARDCROSSCERT = 0x00000023U,
}

enum uint CR_PROP_CABACKWARDCROSSCERT = 0x00000024U;
enum uint CR_PROP_CAFORWARDCROSSCERTSTATE = 0x00000025U;
enum uint CR_PROP_CABACKWARDCROSSCERTSTATE = 0x00000026U;
enum uint CR_PROP_CACERTVERSION = 0x00000027U;
enum uint CR_PROP_SANITIZEDCASHORTNAME = 0x00000028U;

enum : uint
{
    CR_PROP_CERTCDPURLS     = 0x00000029U,
    CR_PROP_CERTAIAURLS     = 0x0000002aU,
    CR_PROP_CERTAIAOCSPURLS = 0x0000002bU,
}

enum : uint
{
    CR_PROP_LOCALENAME           = 0x0000002cU,
    CR_PROP_SUBJECTTEMPLATE_OIDS = 0x0000002dU,
}

enum uint CR_PROP_CRLPARTITIONCOUNT = 0x0000002eU;

enum : uint
{
    CR_PROP_PARTITIONED_BASECRL               = 0x0000002fU,
    CR_PROP_PARTITIONED_DELTACRL              = 0x00000030U,
    CR_PROP_PARTITIONED_BASECRLPUBLISHSTATUS  = 0x00000031U,
    CR_PROP_PARTITIONED_DELTACRLPUBLISHSTATUS = 0x00000032U,
}

enum : uint
{
    CR_PROP_SCEPSERVERCERTS        = 0x000003e8U,
    CR_PROP_SCEPSERVERCAPABILITIES = 0x000003e9U,
    CR_PROP_SCEPSERVERCERTSCHAIN   = 0x000003eaU,
    CR_PROP_SCEPMIN                = 0x000003e8U,
    CR_PROP_SCEPMAX                = 0x000003eaU,
}

enum uint FR_PROP_CLAIMCHALLENGE = 0x00000016U;
enum uint EAN_NAMEOBJECTID = 0x80000000U;
enum uint EANR_SUPPRESS_IA5CONVERSION = 0x80000000U;
enum uint CERTENROLL_INDEX_BASE = 0x00000000U;

enum : uint
{
    EXITEVENT_INVALID      = 0x00000000U,
    EXITEVENT_STARTUP      = 0x00000080U,
    EXITEVENT_CERTIMPORTED = 0x00000200U,
}

enum uint ENUMEXT_OBJECTID = 0x00000001U;
enum uint CMM_REFRESHONLY = 0x00000001U;
enum uint CMM_READONLY = 0x00000002U;
enum uint DBG_CERTSRV = 0x00000001U;
enum const(wchar)* wszSERVICE_NAME = "CertSvc";

enum : const(wchar)*
{
    wszREGKEYBASE   = "SYSTEM\\CurrentControlSet\\Services\\CertSvc",
    wszREGKEYCONFIG = "Configuration",
}

enum : const(wchar)*
{
    wszREGACTIVE         = "Active",
    wszREGDIRECTORY      = "ConfigurationDirectory",
    wszREGDBDIRECTORY    = "DBDirectory",
    wszREGDBLOGDIRECTORY = "DBLogDirectory",
}

enum const(wchar)* wszREGDBSYSDIRECTORY = "DBSystemDirectory";
enum const(wchar)* wszREGDBTEMPDIRECTORY = "DBTempDirectory";
enum const(wchar)* wszREGDBSESSIONCOUNT = "DBSessionCount";
enum const(wchar)* wszREGDBMAXREADSESSIONCOUNT = "DBMaxReadSessionCount";

enum : const(wchar)*
{
    wszREGDBFLAGS                 = "DBFlags",
    wszREGDBLASTFULLBACKUP        = "DBLastFullBackup",
    wszREGDBLASTINCREMENTALBACKUP = "DBLastIncrementalBackup",
    wszREGDBLASTRECOVERY          = "DBLastRecovery",
}

enum const(wchar)* wszREGWEBCLIENTCAMACHINE = "WebClientCAMachine";

enum : const(wchar)*
{
    wszREGVERSION         = "Version",
    wszREGWEBCLIENTCANAME = "WebClientCAName",
    wszREGWEBCLIENTCATYPE = "WebClientCAType",
}

enum const(wchar)* wszREGLDAPFLAGS = "LDAPFlags";
enum const(wchar)* wszREGCERTSRVDEBUG = "Debug";
enum uint DBSESSIONCOUNTDEFAULT = 0x00000064U;

enum : uint
{
    DBFLAGS_READONLY        = 0x00000001U,
    DBFLAGS_CREATEIFNEEDED  = 0x00000002U,
    DBFLAGS_CIRCULARLOGGING = 0x00000004U,
}

enum : uint
{
    DBFLAGS_LAZYFLUSH        = 0x00000008U,
    DBFLAGS_MAXCACHESIZEX100 = 0x00000010U,
}

enum uint DBFLAGS_CHECKPOINTDEPTH60MB = 0x00000020U;

enum : uint
{
    DBFLAGS_LOGBUFFERSLARGE = 0x00000040U,
    DBFLAGS_LOGBUFFERSHUGE  = 0x00000080U,
    DBFLAGS_LOGFILESIZE16MB = 0x00000100U,
}

enum uint DBFLAGS_MULTITHREADTRANSACTIONS = 0x00000200U;
enum uint DBFLAGS_DISABLESNAPSHOTBACKUP = 0x00000400U;
enum uint DBFLAGS_ENABLEVOLATILEREQUESTS = 0x00000800U;

enum : uint
{
    LDAPF_SSLENABLE   = 0x00000001U,
    LDAPF_SIGNDISABLE = 0x00000002U,
}

enum : uint
{
    CSVER_MAJOR_WIN2K    = 0x00000001U,
    CSVER_MINOR_WIN2K    = 0x00000001U,
    CSVER_MAJOR_WHISTLER = 0x00000002U,
}

enum : uint
{
    CSVER_MINOR_WHISTLER_BETA2 = 0x00000001U,
    CSVER_MINOR_WHISTLER_BETA3 = 0x00000002U,
}

enum uint CSVER_MAJOR_LONGHORN = 0x00000003U;
enum uint CSVER_MINOR_LONGHORN_BETA1 = 0x00000001U;

enum : uint
{
    CSVER_MAJOR_WIN7    = 0x00000004U,
    CSVER_MINOR_WIN7    = 0x00000001U,
    CSVER_MAJOR_WIN8    = 0x00000005U,
    CSVER_MINOR_WIN8    = 0x00000001U,
    CSVER_MAJOR_WINBLUE = 0x00000006U,
}

enum uint CSVER_MINOR_WINBLUE = 0x00000001U;
enum uint CSVER_MAJOR_THRESHOLD = 0x00000007U;
enum uint CSVER_MINOR_THRESHOLD = 0x00000001U;

enum : uint
{
    CSVER_MAJOR = 0x00000007U,
    CSVER_MINOR = 0x00000001U,
}

enum const(wchar)* wszREGKEYRESTOREINPROGRESS = "RestoreInProgress";
enum const(wchar)* wszREGKEYDBPARAMETERS = "DBParameters";

enum : const(wchar)*
{
    wszREGCADESCRIPTION  = "CADescription",
    wszREGCACERTHASH     = "CACertHash",
    wszREGCASERIALNUMBER = "CACertSerialNumber",
}

enum const(wchar)* wszREGCAXCHGCERTHASH = "CAXchgCertHash";

enum : const(wchar)*
{
    wszREGKRACERTHASH          = "KRACertHash",
    wszREGKRACERTCOUNT         = "KRACertCount",
    wszREGKRAFLAGS             = "KRAFlags",
    wszREGCATYPE               = "CAType",
    wszREGCERTENROLLCOMPATIBLE = "CertEnrollCompatible",
}

enum const(wchar)* wszREGENFORCEX500NAMELENGTHS = "EnforceX500NameLengths";

enum : const(wchar)*
{
    wszREGCOMMONNAME       = "CommonName",
    wszREGCLOCKSKEWMINUTES = "ClockSkewMinutes",
}

enum : const(wchar)*
{
    wszREGCRLNEXTPUBLISH         = "CRLNextPublish",
    wszREGCRLPERIODSTRING        = "CRLPeriod",
    wszREGCRLPERIODCOUNT         = "CRLPeriodUnits",
    wszREGCRLOVERLAPPERIODSTRING = "CRLOverlapPeriod",
    wszREGCRLOVERLAPPERIODCOUNT  = "CRLOverlapUnits",
}

enum : const(wchar)*
{
    wszREGCRLDELTANEXTPUBLISH         = "CRLDeltaNextPublish",
    wszREGCRLDELTAPERIODSTRING        = "CRLDeltaPeriod",
    wszREGCRLDELTAPERIODCOUNT         = "CRLDeltaPeriodUnits",
    wszREGCRLDELTAOVERLAPPERIODSTRING = "CRLDeltaOverlapPeriod",
    wszREGCRLDELTAOVERLAPPERIODCOUNT  = "CRLDeltaOverlapUnits",
}

enum const(wchar)* wszREGCRLPUBLICATIONURLS = "CRLPublicationURLs";
enum const(wchar)* wszREGCACERTPUBLICATIONURLS = "CACertPublicationURLs";

enum : const(wchar)*
{
    wszREGCRLMAXPARTITIONS       = "CRLMaxPartitions",
    wszREGCRLSUSPENDEDPARTITIONS = "CRLSuspendedPartitions",
}

enum const(wchar)* wszREGCRLCURRENTPARTITION = "CRLCurrentPartition";

enum : const(wchar)*
{
    wszREGCAXCHGVALIDITYPERIODSTRING = "CAXchgValidityPeriod",
    wszREGCAXCHGVALIDITYPERIODCOUNT  = "CAXchgValidityPeriodUnits",
}

enum : const(wchar)*
{
    wszREGCAXCHGOVERLAPPERIODSTRING = "CAXchgOverlapPeriod",
    wszREGCAXCHGOVERLAPPERIODCOUNT  = "CAXchgOverlapPeriodUnits",
}

enum : const(wchar)*
{
    wszREGCRLPATH_OLD         = "CRLPath",
    wszREGCRLEDITFLAGS        = "CRLEditFlags",
    wszREGCRLFLAGS            = "CRLFlags",
    wszREGCRLATTEMPTREPUBLISH = "CRLAttemptRepublish",
}

enum : const(wchar)*
{
    wszREGENABLED      = "Enabled",
    wszREGFORCETELETEX = "ForceTeletex",
}

enum : const(wchar)*
{
    wszREGLOGLEVEL   = "LogLevel",
    wszREGHIGHSERIAL = "HighSerial",
}

enum const(wchar)* wszREGPOLICYFLAGS = "PolicyFlags";
enum const(wchar)* wszREGNAMESEPARATOR = "SubjectNameSeparator";
enum const(wchar)* wszREGSUBJECTTEMPLATE = "SubjectTemplate";

enum : const(wchar)*
{
    wszREGCAUSEDS              = "UseDS",
    wszREGVALIDITYPERIODSTRING = "ValidityPeriod",
    wszREGVALIDITYPERIODCOUNT  = "ValidityPeriodUnits",
}

enum : const(wchar)*
{
    wszREGPARENTCAMACHINE = "ParentCAMachine",
    wszREGPARENTCANAME    = "ParentCAName",
}

enum : const(wchar)*
{
    wszREGREQUESTFILENAME     = "RequestFileName",
    wszREGREQUESTID           = "RequestId",
    wszREGREQUESTKEYCONTAINER = "RequestKeyContainer",
    wszREGREQUESTKEYINDEX     = "RequestKeyIndex",
}

enum : const(wchar)*
{
    wszREGCASERVERNAME   = "CAServerName",
    wszREGCACERTFILENAME = "CACertFileName",
}

enum const(wchar)* wszREGCASECURITY = "Security";
enum const(wchar)* wszREGAUDITFILTER = "AuditFilter";
enum const(wchar)* wszREGOFFICERRIGHTS = "OfficerRights";
enum const(wchar)* wszENROLLMENTAGENTRIGHTS = "EnrollmentAgentRights";

enum : const(wchar)*
{
    wszREGMAXINCOMINGMESSAGESIZE = "MaxIncomingMessageSize",
    wszREGMAXINCOMINGALLOCSIZE   = "MaxIncomingAllocSize",
}

enum const(wchar)* wszREGROLESEPARATIONENABLED = "RoleSeparationEnabled";
enum const(wchar)* wszREGALTERNATEPUBLISHDOMAINS = "AlternatePublishDomains";
enum const(wchar)* wszREGSETUPSTATUS = "SetupStatus";
enum const(wchar)* wszREGINTERFACEFLAGS = "InterfaceFlags";

enum : const(wchar)*
{
    wszREGDSCONFIGDN = "DSConfigDN",
    wszREGDSDOMAINDN = "DSDomainDN",
}

enum : const(wchar)*
{
    wszREGVIEWAGEMINUTES  = "ViewAgeMinutes",
    wszREGVIEWIDLEMINUTES = "ViewIdleMinutes",
}

enum const(wchar)* wszREGEKPUBLISTDIRECTORIES = "EndorsementKeyListDirectories";
enum const(wchar)* wszCERTIFICATETRANSPARENCYFLAGS = "CertificateTransparencyFlags";
enum const(wchar)* wszREGMAXSCTLISTSIZE = "MaxSCTListSize";
enum const(wchar)* wszREGCERTIFICATETRANSPARENCYINFOOID = "CTInformationExtensionOid";
enum const(wchar)* wszREGPROCESSINGFLAGS = "ProcessingFlags";
enum const(wchar)* wszREGUSEDEFINEDCACERTINREQ = "UseDefinedCACertInRequest";
enum const(wchar)* wszREGENABLEDEKUFORDEFINEDCACERT = "EnabledEKUForDefinedCACert";
enum const(wchar)* wszREGEKUOIDSFORPUBLISHEXPIREDCERTINCRL = "EKUOIDsForPublishExpiredCertInCRL";
enum const(wchar)* wszCRTFILENAMEEXT = ".crt";
enum const(wchar)* wszPFXFILENAMEEXT = ".p12";
enum const(wchar)* wszDATFILENAMEEXT = ".dat";
enum const(wchar)* wszLOGFILENAMEEXT = ".log";
enum const(wchar)* wszDBFILENAMEEXT = ".edb";
// Native encoding: ansi
enum const(wchar)* szDBBASENAMEPARM = "edb";
enum const(wchar)* wszLOGPATH = "CertLog";

enum : const(wchar)*
{
    wszDBBACKUPSUBDIR      = "DataBase",
    wszDBBACKUPCERTBACKDAT = "certbkxp.dat",
}

enum uint CCLOCKSKEWMINUTESDEFAULT = 0x0000000aU;
enum uint CVIEWAGEMINUTESDEFAULT = 0x00000010U;

enum : uint
{
    dwVALIDITYPERIODCOUNTDEFAULT_ROOT       = 0x00000005U,
    dwVALIDITYPERIODCOUNTDEFAULT_ENTERPRISE = 0x00000002U,
    dwVALIDITYPERIODCOUNTDEFAULT_STANDALONE = 0x00000001U,
}

enum uint dwCAXCHGVALIDITYPERIODCOUNTDEFAULT = 0x00000001U;
enum uint dwCAXCHGOVERLAPPERIODCOUNTDEFAULT = 0x00000001U;
enum uint dwCRLPERIODCOUNTDEFAULT = 0x00000001U;
enum uint dwCRLOVERLAPPERIODCOUNTDEFAULT = 0x00000000U;
enum uint dwCRLDELTAPERIODCOUNTDEFAULT = 0x00000001U;
enum uint dwCRLDELTAOVERLAPPERIODCOUNTDEFAULT = 0x00000000U;
enum uint SETUP_SERVER_FLAG = 0x00000001U;
enum uint SETUP_CLIENT_FLAG = 0x00000002U;
enum uint SETUP_SUSPEND_FLAG = 0x00000004U;
enum uint SETUP_REQUEST_FLAG = 0x00000008U;
enum uint SETUP_ONLINE_FLAG = 0x00000010U;
enum uint SETUP_DENIED_FLAG = 0x00000020U;
enum uint SETUP_CREATEDB_FLAG = 0x00000040U;
enum uint SETUP_ATTEMPT_VROOT_CREATE = 0x00000080U;
enum uint SETUP_FORCECRL_FLAG = 0x00000100U;
enum uint SETUP_UPDATE_CAOBJECT_SVRTYPE = 0x00000200U;
enum uint SETUP_SERVER_UPGRADED_FLAG = 0x00000400U;
enum uint SETUP_W2K_SECURITY_NOT_UPGRADED_FLAG = 0x00000800U;
enum uint SETUP_SECURITY_CHANGED = 0x00001000U;
enum uint SETUP_DCOM_SECURITY_UPDATED_FLAG = 0x00002000U;
enum uint SETUP_SERVER_IS_UP_TO_DATE_FLAG = 0x00004000U;
enum uint CRLF_DELTA_USE_OLDEST_UNEXPIRED_BASE = 0x00000001U;
enum uint CRLF_DELETE_EXPIRED_CRLS = 0x00000002U;
enum uint CRLF_CRLNUMBER_CRITICAL = 0x00000004U;
enum uint CRLF_REVCHECK_IGNORE_OFFLINE = 0x00000008U;
enum uint CRLF_IGNORE_INVALID_POLICIES = 0x00000010U;
enum uint CRLF_REBUILD_MODIFIED_SUBJECT_ONLY = 0x00000020U;
enum uint CRLF_SAVE_FAILED_CERTS = 0x00000040U;
enum uint CRLF_IGNORE_UNKNOWN_CMC_ATTRIBUTES = 0x00000080U;
enum uint CRLF_IGNORE_CROSS_CERT_TRUST_ERROR = 0x00000100U;
enum uint CRLF_PUBLISH_EXPIRED_CERT_CRLS = 0x00000200U;
enum uint CRLF_ENFORCE_ENROLLMENT_AGENT = 0x00000400U;

enum : uint
{
    CRLF_DISABLE_RDN_REORDER      = 0x00000800U,
    CRLF_DISABLE_ROOT_CROSS_CERTS = 0x00001000U,
}

enum uint CRLF_LOG_FULL_RESPONSE = 0x00002000U;
enum uint CRLF_USE_XCHG_CERT_TEMPLATE = 0x00004000U;
enum uint CRLF_USE_CROSS_CERT_TEMPLATE = 0x00008000U;
enum uint CRLF_ALLOW_REQUEST_ATTRIBUTE_SUBJECT = 0x00010000U;
enum uint CRLF_REVCHECK_IGNORE_NOREVCHECK = 0x00020000U;

enum : uint
{
    CRLF_PRESERVE_EXPIRED_CA_CERTS = 0x00040000U,
    CRLF_PRESERVE_REVOKED_CA_CERTS = 0x00080000U,
}

enum uint CRLF_DISABLE_CHAIN_VERIFICATION = 0x00100000U;
enum uint CRLF_BUILD_ROOTCA_CRLENTRIES_BASEDONKEY = 0x00200000U;
enum uint CRLF_ENABLE_CRL_PARTITION = 0x00400000U;
enum uint CRLF_PARTITION_ZERO_EXCLUSIVE = 0x00800000U;

enum : uint
{
    CRLF_CONTAINS_ONLY_CACERTS   = 0x01000000U,
    CRLF_CONTAINS_ONLY_USERCERTS = 0x02000000U,
}

enum uint KRAF_ENABLEFOREIGN = 0x00000001U;
enum uint KRAF_SAVEBADREQUESTKEY = 0x00000002U;
enum uint KRAF_ENABLEARCHIVEALL = 0x00000004U;
enum uint KRAF_DISABLEUSEDEFAULTPROVIDER = 0x00000008U;
enum uint IF_LOCKICERTREQUEST = 0x00000001U;
enum uint IF_NOREMOTEICERTREQUEST = 0x00000002U;
enum uint IF_NOLOCALICERTREQUEST = 0x00000004U;
enum uint IF_NORPCICERTREQUEST = 0x00000008U;
enum uint IF_NOREMOTEICERTADMIN = 0x00000010U;
enum uint IF_NOLOCALICERTADMIN = 0x00000020U;
enum uint IF_NOREMOTEICERTADMINBACKUP = 0x00000040U;
enum uint IF_NOLOCALICERTADMINBACKUP = 0x00000080U;
enum uint IF_NOSNAPSHOTBACKUP = 0x00000100U;

enum : uint
{
    IF_ENFORCEENCRYPTICERTREQUEST = 0x00000200U,
    IF_ENFORCEENCRYPTICERTADMIN   = 0x00000400U,
}

enum uint IF_ENABLEEXITKEYRETRIEVAL = 0x00000800U;
enum uint IF_ENABLEADMINASAUDITOR = 0x00001000U;
enum uint IF_ENABLEPRESIGNSUPPORT = 0x00002000U;

enum : uint
{
    PROCFLG_NONE            = 0x00000000U,
    PROCFLG_ENFORCEGOODKEYS = 0x00000001U,
}

enum uint CSURL_SERVERPUBLISH = 0x00000001U;

enum : uint
{
    CSURL_ADDTOCERTCDP     = 0x00000002U,
    CSURL_ADDTOFRESHESTCRL = 0x00000004U,
    CSURL_ADDTOCRLCDP      = 0x00000008U,
}

enum uint CSURL_PUBLISHRETRY = 0x00000010U;
enum uint CSURL_ADDTOCERTOCSP = 0x00000020U;
enum uint CSURL_SERVERPUBLISHDELTA = 0x00000040U;
enum uint CSURL_ADDTOIDP = 0x00000080U;

enum : const(wchar)*
{
    wszREGKEYCSP           = "CSP",
    wszREGKEYENCRYPTIONCSP = "EncryptionCSP",
    wszREGKEYEXITMODULES   = "ExitModules",
    wszREGKEYPOLICYMODULES = "PolicyModules",
}

enum const(wchar)* wszSECUREDATTRIBUTES = "SignedAttributes";
enum const(wchar)* wszzDEFAULTSIGNEDATTRIBUTES = "RequesterName\0";
enum const(wchar)* wszREGBACKUPLOGDIRECTORY = "BackupLogDirectory";
enum const(wchar)* wszREGCHECKPOINTFILE = "CheckPointFile";
enum const(wchar)* wszREGHIGHLOGNUMBER = "HighLogNumber";

enum : const(wchar)*
{
    wszREGLOWLOGNUMBER    = "LowLogNumber",
    wszREGLOGPATH         = "LogPath",
    wszREGRESTOREMAPCOUNT = "RestoreMapCount",
    wszREGRESTOREMAP      = "RestoreMap",
}

enum const(wchar)* wszREGDATABASERECOVERED = "DatabaseRecovered";
enum const(wchar)* wszREGRESTORESTATUS = "RestoreStatus";
enum const(wchar)* wszREGB2ICERTMANAGEMODULE = "ICertManageModule";
enum const(wchar)* wszREGSP4DEFAULTCONFIGURATION = "DefaultConfiguration";

enum : const(wchar)*
{
    wszREGSP4KEYSETNAME           = "KeySetName",
    wszREGSP4SUBJECTNAMESEPARATOR = "SubjectNameSeparator",
}

enum : const(wchar)*
{
    wszREGSP4NAMES   = "Names",
    wszREGSP4QUERIES = "Queries",
}

enum const(wchar)* wszREGNETSCAPECERTTYPE = "NetscapeCertType";
enum const(wchar)* wszNETSCAPEREVOCATIONTYPE = "Netscape";

enum : const(wchar)*
{
    wszREGPROVIDERTYPE = "ProviderType",
    wszREGPROVIDER     = "Provider",
}

enum const(wchar)* wszHASHALGORITHM = "HashAlgorithm";
enum const(wchar)* wszENCRYPTIONALGORITHM = "EncryptionAlgorithm";
enum const(wchar)* wszMACHINEKEYSET = "MachineKeyset";

enum : const(wchar)*
{
    wszREGKEYSIZE          = "KeySize",
    wszREGSYMMETRICKEYSIZE = "SymmetricKeySize",
}

enum const(wchar)* wszCNGPUBLICKEYALGORITHM = "CNGPublicKeyAlgorithm";
enum const(wchar)* wszCNGHASHALGORITHM = "CNGHashAlgorithm";
enum const(wchar)* wszCNGENCRYPTIONALGORITHM = "CNGEncryptionAlgorithm";
enum const(wchar)* wszREGALTERNATESIGNATUREALGORITHM = "AlternateSignatureAlgorithm";
// Native encoding: ansi
enum const(wchar)* szNAMESEPARATORDEFAULT = "
";

enum : const(wchar)*
{
    wszPERIODYEARS   = "Years",
    wszPERIODMONTHS  = "Months",
    wszPERIODWEEKS   = "Weeks",
    wszPERIODDAYS    = "Days",
    wszPERIODHOURS   = "Hours",
    wszPERIODMINUTES = "Minutes",
    wszPERIODSECONDS = "Seconds",
}

enum const(wchar)* wszREGISSUERCERTURLFLAGS = "IssuerCertURLFlags";
enum const(wchar)* wszREGEDITFLAGS = "EditFlags";

enum : const(wchar)*
{
    wszREGUPNMAP          = "UPNMap",
    wszREGSUBJECTALTNAME  = "SubjectAltName",
    wszREGSUBJECTALTNAME2 = "SubjectAltName2",
}

enum const(wchar)* wszREGREQUESTDISPOSITION = "RequestDisposition";
enum const(wchar)* wszREGCAPATHLENGTH = "CAPathLength";
enum const(wchar)* wszREGREVOCATIONTYPE = "RevocationType";
enum const(wchar)* wszREGLDAPREVOCATIONCRLURL_OLD = "LDAPRevocationCRLURL";
enum const(wchar)* wszREGREVOCATIONCRLURL_OLD = "RevocationCRLURL";
enum const(wchar)* wszREGFTPREVOCATIONCRLURL_OLD = "FTPRevocationCRLURL";
enum const(wchar)* wszREGFILEREVOCATIONCRLURL_OLD = "FileRevocationCRLURL";
enum const(wchar)* wszREGREVOCATIONURL = "RevocationURL";
enum const(wchar)* wszREGLDAPISSUERCERTURL_OLD = "LDAPIssuerCertURL";
enum const(wchar)* wszREGISSUERCERTURL_OLD = "IssuerCertURL";
enum const(wchar)* wszREGFTPISSUERCERTURL_OLD = "FTPIssuerCertURL";
enum const(wchar)* wszREGFILEISSUERCERTURL_OLD = "FileIssuerCertURL";
enum const(wchar)* wszREGENABLEREQUESTEXTENSIONLIST = "EnableRequestExtensionList";
enum const(wchar)* wszREGENABLEENROLLEEREQUESTEXTENSIONLIST = "EnableEnrolleeRequestExtensionList";
enum const(wchar)* wszREGDISABLEEXTENSIONLIST = "DisableExtensionList";
enum const(wchar)* wszREGEKUOIDSFORVOLATILEREQUESTS = "EKUOIDsforVolatileRequests";
enum const(wchar)* wszREGLDAPSESSIONOPTIONS = "LDAPSessionOptions";
enum const(wchar)* wszLDAPSESSIONOPTIONVALUE = "LDAPSessionOptionValue";
enum const(wchar)* wszREGDEFAULTSMIME = "DefaultSMIME";
enum uint CAPATHLENGTH_INFINITE = 0xffffffffU;

enum : uint
{
    REQDISP_PENDING             = 0x00000000U,
    REQDISP_ISSUE               = 0x00000001U,
    REQDISP_DENY                = 0x00000002U,
    REQDISP_USEREQUESTATTRIBUTE = 0x00000003U,
}

enum : uint
{
    REQDISP_MASK         = 0x000000ffU,
    REQDISP_PENDINGFIRST = 0x00000100U,
}

enum uint REQDISP_DEFAULT_ENTERPRISE = 0x00000001U;

enum : uint
{
    REVEXT_CDPLDAPURL_OLD = 0x00000001U,
    REVEXT_CDPHTTPURL_OLD = 0x00000002U,
    REVEXT_CDPFTPURL_OLD  = 0x00000004U,
    REVEXT_CDPFILEURL_OLD = 0x00000008U,
    REVEXT_CDPURLMASK_OLD = 0x000000ffU,
    REVEXT_CDPENABLE      = 0x00000100U,
    REVEXT_ASPENABLE      = 0x00000200U,
    REVEXT_DEFAULT_NODS   = 0x00000100U,
    REVEXT_DEFAULT_DS     = 0x00000100U,
}

enum : uint
{
    ISSCERT_LDAPURL_OLD  = 0x00000001U,
    ISSCERT_HTTPURL_OLD  = 0x00000002U,
    ISSCERT_FTPURL_OLD   = 0x00000004U,
    ISSCERT_FILEURL_OLD  = 0x00000008U,
    ISSCERT_URLMASK_OLD  = 0x000000ffU,
    ISSCERT_ENABLE       = 0x00000100U,
    ISSCERT_DEFAULT_NODS = 0x00000100U,
    ISSCERT_DEFAULT_DS   = 0x00000100U,
}

enum uint EDITF_ENABLEREQUESTEXTENSIONS = 0x00000001U;
enum uint EDITF_REQUESTEXTENSIONLIST = 0x00000002U;
enum uint EDITF_DISABLEEXTENSIONLIST = 0x00000004U;

enum : uint
{
    EDITF_ADDOLDKEYUSAGE = 0x00000008U,
    EDITF_ADDOLDCERTTYPE = 0x00000010U,
}

enum uint EDITF_ATTRIBUTEENDDATE = 0x00000020U;

enum : uint
{
    EDITF_BASICCONSTRAINTSCRITICAL = 0x00000040U,
    EDITF_BASICCONSTRAINTSCA       = 0x00000080U,
}

enum uint EDITF_ENABLEAKIKEYID = 0x00000100U;
enum uint EDITF_ATTRIBUTECA = 0x00000200U;
enum uint EDITF_IGNOREREQUESTERGROUP = 0x00000400U;

enum : uint
{
    EDITF_ENABLEAKIISSUERNAME   = 0x00000800U,
    EDITF_ENABLEAKIISSUERSERIAL = 0x00001000U,
    EDITF_ENABLEAKICRITICAL     = 0x00002000U,
}

enum uint EDITF_SERVERUPGRADED = 0x00004000U;
enum uint EDITF_ATTRIBUTEEKU = 0x00008000U;
enum uint EDITF_ENABLEDEFAULTSMIME = 0x00010000U;
enum uint EDITF_EMAILOPTIONAL = 0x00020000U;
enum uint EDITF_ATTRIBUTESUBJECTALTNAME2 = 0x00040000U;

enum : uint
{
    EDITF_ENABLELDAPREFERRALS = 0x00080000U,
    EDITF_ENABLECHASECLIENTDC = 0x00100000U,
}

enum uint EDITF_AUDITCERTTEMPLATELOAD = 0x00200000U;

enum : uint
{
    EDITF_DISABLEOLDOSCNUPN      = 0x00400000U,
    EDITF_DISABLELDAPPACKAGELIST = 0x00800000U,
}

enum : uint
{
    EDITF_ENABLEUPNMAP                = 0x01000000U,
    EDITF_ENABLEOCSPREVNOCHECK        = 0x02000000U,
    EDITF_ENABLERENEWONBEHALFOF       = 0x04000000U,
    EDITF_ENABLEKEYENCIPHERMENTCACERT = 0x08000000U,
}

enum : const(wchar)*
{
    wszREGLDAPREVOCATIONDN_OLD         = "LDAPRevocationDN",
    wszREGLDAPREVOCATIONDNTEMPLATE_OLD = "LDAPRevocationDNTemplate",
}

enum const(wchar)* wszCRLPUBLISHRETRYCOUNT = "CRLPublishRetryCount";
enum const(wchar)* wszREGCERTPUBLISHFLAGS = "PublishCertFlags";

enum : uint
{
    EXITPUB_FILE            = 0x00000001U,
    EXITPUB_ACTIVEDIRECTORY = 0x00000002U,
}

enum uint EXITPUB_REMOVEOLDCERTS = 0x00000010U;

enum : uint
{
    EXITPUB_DEFAULT_ENTERPRISE = 0x00000002U,
    EXITPUB_DEFAULT_STANDALONE = 0x00000001U,
}

enum : const(wchar)*
{
    wszCLASS_CERTADMIN        = "CertificateAuthority.Admin",
    wszCLASS_CERTCONFIG       = "CertificateAuthority.Config",
    wszCLASS_CERTGETCONFIG    = "CertificateAuthority.GetConfig",
    wszCLASS_CERTENCODE       = "CertificateAuthority.Encode",
    wszCLASS_CERTDBMEM        = "CertificateAuthority.DBMem",
    wszCLASS_CERTREQUEST      = "CertificateAuthority.Request",
    wszCLASS_CERTSERVEREXIT   = "CertificateAuthority.ServerExit",
    wszCLASS_CERTSERVERPOLICY = "CertificateAuthority.ServerPolicy",
    wszCLASS_CERTVIEW         = "CertificateAuthority.View",
}

enum const(wchar)* wszMICROSOFTCERTMODULE_PREFIX = "CertificateAuthority_MicrosoftDefault";
enum const(wchar)* wszCERTMANAGE_SUFFIX = "Manage";
enum const(wchar)* wszCERTEXITMODULE_POSTFIX = ".Exit";
enum const(wchar)* wszCERTPOLICYMODULE_POSTFIX = ".Policy";
enum const(wchar)* wszCAPOLICYFILE = "CAPolicy.inf";

enum : const(wchar)*
{
    wszINFSECTION_CDP        = "CRLDistributionPoint",
    wszINFSECTION_AIA        = "AuthorityInformationAccess",
    wszINFSECTION_EKU        = "EnhancedKeyUsageExtension",
    wszINFSECTION_CCDP       = "CrossCertificateDistributionPointsExtension",
    wszINFSECTION_CERTSERVER = "certsrv_server",
}

enum : const(wchar)*
{
    wszINFKEY_RENEWALKEYLENGTH            = "RenewalKeyLength",
    wszINFKEY_RENEWALVALIDITYPERIODSTRING = "RenewalValidityPeriod",
    wszINFKEY_RENEWALVALIDITYPERIODCOUNT  = "RenewalValidityPeriodUnits",
}

enum : const(wchar)*
{
    wszINFKEY_UTF8                 = "UTF8",
    wszINFKEY_CRLPERIODSTRING      = "CRLPeriod",
    wszINFKEY_CRLPERIODCOUNT       = "CRLPeriodUnits",
    wszINFKEY_CRLDELTAPERIODSTRING = "CRLDeltaPeriod",
    wszINFKEY_CRLDELTAPERIODCOUNT  = "CRLDeltaPeriodUnits",
}

enum const(wchar)* wszINFKEY_LOADDEFAULTTEMPLATES = "LoadDefaultTemplates";
enum const(wchar)* wszINFKEY_ENABLEKEYCOUNTING = "EnableKeyCounting";

enum : const(wchar)*
{
    wszINFKEY_FORCEUTF8                   = "ForceUTF8",
    wszINFKEY_ALTERNATESIGNATUREALGORITHM = "AlternateSignatureAlgorithm",
}

enum : const(wchar)*
{
    wszINFKEY_SHOWALLCSPS       = "ShowAllCSPs",
    wszINFKEY_CRITICAL          = "Critical",
    wszINFKEY_EMPTY             = "Empty",
    wszINFKEY_CCDPSYNCDELTATIME = "SyncDeltaTime",
}

enum : const(wchar)*
{
    wszINFSECTION_CAPOLICY                   = "CAPolicy",
    wszINFSECTION_POLICYSTATEMENT            = "PolicyStatementExtension",
    wszINFSECTION_APPLICATIONPOLICYSTATEMENT = "ApplicationPolicyStatementExtension",
}

enum : const(wchar)*
{
    wszINFKEY_POLICIES = "Policies",
    wszINFKEY_OID      = "OID",
    wszINFKEY_NOTICE   = "Notice",
    wszINFKEY_FLAGS    = "Flags",
}

enum : const(wchar)*
{
    wszINFSECTION_REQUESTATTRIBUTES = "RequestAttributes",
    wszINFSECTION_NAMECONSTRAINTS   = "NameConstraintsExtension",
}

enum : const(wchar)*
{
    wszINFKEY_INCLUDE       = "Include",
    wszINFKEY_EXCLUDE       = "Exclude",
    wszINFKEY_SUBTREE       = "SubTree",
    wszINFKEY_UPN           = "UPN",
    wszINFKEY_EMAIL         = "EMail",
    wszINFKEY_DNS           = "DNS",
    wszINFKEY_DIRECTORYNAME = "DirectoryName",
    wszINFKEY_URL           = "URL",
    wszINFKEY_IPADDRESS     = "IPAddress",
    wszINFKEY_REGISTEREDID  = "RegisteredId",
    wszINFKEY_OTHERNAME     = "OtherName",
}

enum : const(wchar)*
{
    wszINFSECTION_POLICYMAPPINGS            = "PolicyMappingsExtension",
    wszINFSECTION_APPLICATIONPOLICYMAPPINGS = "ApplicationPolicyMappingsExtension",
}

enum : const(wchar)*
{
    wszINFSECTION_POLICYCONSTRAINTS            = "PolicyConstraintsExtension",
    wszINFSECTION_APPLICATIONPOLICYCONSTRAINTS = "ApplicationPolicyConstraintsExtension",
}

enum const(wchar)* wszINFKEY_REQUIREEXPLICITPOLICY = "RequireExplicitPolicy";
enum const(wchar)* wszINFKEY_INHIBITPOLICYMAPPING = "InhibitPolicyMapping";
enum const(wchar)* wszINFSECTION_BASICCONSTRAINTS = "BasicConstraintsExtension";
enum const(wchar)* wszINFKEY_PATHLENGTH = "PathLength";

enum : const(wchar)*
{
    wszINFSECTION_EXTENSIONS = "Extensions",
    wszINFSECTION_PROPERTIES = "Properties",
}

enum const(wchar)* wszINFKEY_CONTINUE = "_continue_";
enum const(wchar)* wszINFSECTION_NEWREQUEST = "NewRequest";

enum : const(wchar)*
{
    wszINFKEY_SUBJECT          = "Subject",
    wszINFKEY_SUBJECTNAMEFLAGS = "SubjectNameFlags",
}

enum : const(wchar)*
{
    wszINFKEY_X500NAMEFLAGS       = "X500NameFlags",
    wszINFKEY_EXPORTABLE          = "Exportable",
    wszINFKEY_EXPORTABLEENCRYPTED = "ExportableEncrypted",
}

enum : const(wchar)*
{
    wszINFKEY_HASHALGORITHM         = "HashAlgorithm",
    wszINFKEY_KEYALGORITHM          = "KeyAlgorithm",
    wszINFKEY_KEYALGORITHMPARMETERS = "KeyAlgorithmParameters",
    wszINFKEY_KEYCONTAINER          = "KeyContainer",
    wszINFKEY_READERNAME            = "ReaderName",
    wszINFKEY_KEYLENGTH             = "KeyLength",
    wszINFKEY_LEGACYKEYSPEC         = "KeySpec",
    wszINFKEY_KEYUSAGEEXTENSION     = "KeyUsage",
    wszINFKEY_KEYUSAGEPROPERTY      = "KeyUsageProperty",
}

enum : const(wchar)*
{
    wszINFKEY_MACHINEKEYSET     = "MachineKeySet",
    wszINFKEY_PRIVATEKEYARCHIVE = "PrivateKeyArchive",
}

enum : const(wchar)*
{
    wszINFKEY_ENCRYPTIONALGORITHM = "EncryptionAlgorithm",
    wszINFKEY_ENCRYPTIONLENGTH    = "EncryptionLength",
}

enum : const(wchar)*
{
    wszINFKEY_PROVIDERNAME       = "ProviderName",
    wszINFKEY_PROVIDERTYPE       = "ProviderType",
    wszINFKEY_RENEWALCERT        = "RenewalCert",
    wszINFKEY_REQUESTTYPE        = "RequestType",
    wszINFKEY_SECURITYDESCRIPTOR = "SecurityDescriptor",
}

enum : const(wchar)*
{
    wszINFKEY_SILENT           = "Silent",
    wszINFKEY_SMIME            = "SMIME",
    wszINFKEY_SUPPRESSDEFAULTS = "SuppressDefaults",
}

enum : const(wchar)*
{
    wszINFKEY_USEEXISTINGKEY   = "UseExistingKeySet",
    wszINFKEY_USERPROTECTED    = "UserProtected",
    wszINFKEY_KEYPROTECTION    = "KeyProtection",
    wszINFKEY_UICONTEXTMESSAGE = "UIContextMessage",
}

enum : const(wchar)*
{
    wszINFKEY_FRIENDLYNAME     = "FriendlyName",
    wszINFKEY_NOTBEFORE        = "NotBefore",
    wszINFKEY_NOTAFTER         = "NotAfter",
    wszINFKEY_ATTESTPRIVATEKEY = "AttestPrivateKey",
}

enum : const(wchar)*
{
    wszINFKEY_PUBLICKEY           = "PublicKey",
    wszINFKEY_PUBLICKEYPARAMETERS = "PublicKeyParameters",
}

enum : const(wchar)*
{
    wszINFKEY_ECCKEYPARAMETERS          = "EccKeyParameters",
    wszINFKEY_ECCKEYPARAMETERS_P        = "EccKeyParameters_P",
    wszINFKEY_ECCKEYPARAMETERS_A        = "EccKeyParameters_A",
    wszINFKEY_ECCKEYPARAMETERS_B        = "EccKeyParameters_B",
    wszINFKEY_ECCKEYPARAMETERS_SEED     = "EccKeyParameters_Seed",
    wszINFKEY_ECCKEYPARAMETERS_BASE     = "EccKeyParameters_Base",
    wszINFKEY_ECCKEYPARAMETERS_ORDER    = "EccKeyParameters_Order",
    wszINFKEY_ECCKEYPARAMETERS_COFACTOR = "EccKeyParameters_Cofactor",
    wszINFKEY_ECCKEYPARAMETERSTYPE      = "EccKeyParametersType",
}

enum : const(wchar)*
{
    wszINFKEY_SERIALNUMBER      = "SerialNumber",
    wszINFKEY_CATHUMBPRINT      = "CAThumbprint",
    wszINFKEY_CACERTS           = "CACerts",
    wszINFKEY_CACAPABILITIES    = "CACapabilities",
    wszINFKEY_CHALLENGEPASSWORD = "ChallengePassword",
}

enum : const(wchar)*
{
    wszINFVALUE_REQUESTTYPE_PKCS10 = "PKCS10",
    wszINFVALUE_REQUESTTYPE_PKCS7  = "PKCS7",
    wszINFVALUE_REQUESTTYPE_CMC    = "CMC",
    wszINFVALUE_REQUESTTYPE_CERT   = "Cert",
    wszINFVALUE_REQUESTTYPE_SCEP   = "SCEP",
    wszINFVALUE_ENDORSEMENTKEY     = "EndorsementKey",
}

enum : const(wchar)*
{
    wszREGEXITSMTPKEY          = "SMTP",
    wszREGEXITSMTPTEMPLATES    = "Templates",
    wszREGEXITSMTPEVENTFILTER  = "EventFilter",
    wszREGEXITSMTPSERVER       = "SMTPServer",
    wszREGEXITSMTPAUTHENTICATE = "SMTPAuthenticate",
}

enum : const(wchar)*
{
    wszREGEXITDENIEDKEY    = "Denied",
    wszREGEXITISSUEDKEY    = "Issued",
    wszREGEXITPENDINGKEY   = "Pending",
    wszREGEXITREVOKEDKEY   = "Revoked",
    wszREGEXITCRLISSUEDKEY = "CRLIssued",
    wszREGEXITSHUTDOWNKEY  = "Shutdown",
    wszREGEXITSTARTUPKEY   = "Startup",
    wszREGEXITIMPORTEDKEY  = "Imported",
    wszREGEXITSMTPFROM     = "From",
    wszREGEXITSMTPTO       = "To",
    wszREGEXITSMTPCC       = "Cc",
    wszREGEXITTITLEFORMAT  = "TitleFormat",
    wszREGEXITTITLEARG     = "TitleArg",
    wszREGEXITBODYFORMAT   = "BodyFormat",
    wszREGEXITBODYARG      = "BodyArg",
    wszREGEXITPROPNOTFOUND = "???",
}

enum : const(wchar)*
{
    wszREGKEYENROLLMENT            = "Software\\Microsoft\\Cryptography\\AutoEnrollment",
    wszREGKEYGROUPPOLICYENROLLMENT = "Software\\Policies\\Microsoft\\Cryptography\\AutoEnrollment",
}

enum const(wchar)* wszREGMAXPENDINGREQUESTDAYS = "MaxPendingRequestDays";
enum const(wchar)* wszREGAELOGLEVEL_OLD = "AEEventLogLevel";
enum const(wchar)* wszREGENROLLFLAGS = "EnrollFlags";
enum const(wchar)* wszREGVERIFYFLAGS = "VerifyFlags";

enum : const(wchar)*
{
    wszREGUNICODE         = "Unicode",
    wszREGAIKCLOUDCAURL   = "AIKCloudCAURL",
    wszREGAIKKEYALGORITHM = "AIKKeyAlgorithm",
    wszREGAIKKEYLENGTH    = "AIKKeyLength",
}

enum const(wchar)* wszREGPRESERVESCEPDUMMYCERTS = "PreserveSCEPDummyCerts";
enum const(wchar)* wszREGALLPROVIDERS = "All";
enum uint TP_MACHINEPOLICY = 0x00000001U;
enum const(wchar)* wszREGKEYREPAIR = "KeyRepair";

enum : uint
{
    KR_ENABLE_MACHINE = 0x00000001U,
    KR_ENABLE_USER    = 0x00000002U,
}

enum : const(wchar)*
{
    CONFIGURATION_STATUS_PARENT_REG_PATH = "Software\\Microsoft\\ADCS",
    CONFIGURATION_STATUS_REG_VALUE_NAME  = "ConfigurationStatus",
}

enum const(wchar)* CONFIGURATION_REG_EPTOKENCHECKVALUE = "EPTokenCheckValue";
enum uint EP_TOKENCHECK_DEFAULT_VALUE = 0x00000002U;
enum const(wchar)* CONFIGURATION_REG_DISABLE_HTTPSONLY = "DisableHTTPSOnly";
enum const(wchar)* wszPROPDISTINGUISHEDNAME = "DistinguishedName";

enum : const(wchar)*
{
    wszPROPRAWNAME         = "RawName",
    wszPROPCOUNTRY         = "Country",
    wszPROPORGANIZATION    = "Organization",
    wszPROPORGUNIT         = "OrgUnit",
    wszPROPCOMMONNAME      = "CommonName",
    wszPROPLOCALITY        = "Locality",
    wszPROPSTATE           = "State",
    wszPROPTITLE           = "Title",
    wszPROPGIVENNAME       = "GivenName",
    wszPROPINITIALS        = "Initials",
    wszPROPSURNAME         = "SurName",
    wszPROPDOMAINCOMPONENT = "DomainComponent",
}

enum : const(wchar)*
{
    wszPROPEMAIL         = "EMail",
    wszPROPSTREETADDRESS = "StreetAddress",
}

enum : const(wchar)*
{
    wszPROPUNSTRUCTUREDNAME    = "UnstructuredName",
    wszPROPUNSTRUCTUREDADDRESS = "UnstructuredAddress",
}

enum const(wchar)* wszPROPDEVICESERIALNUMBER = "DeviceSerialNumber";

enum : const(wchar)*
{
    wszPROPSUBJECTDOT                  = "Subject.",
    wszPROPREQUESTDOT                  = "Request.",
    wszPROPREQUESTREQUESTID            = "RequestID",
    wszPROPREQUESTRAWREQUEST           = "RawRequest",
    wszPROPREQUESTRAWARCHIVEDKEY       = "RawArchivedKey",
    wszPROPREQUESTARCHIVEDKEY          = "ArchivedKey",
    wszPROPREQUESTKEYRECOVERYHASHES    = "KeyRecoveryHashes",
    wszPROPREQUESTRAWOLDCERTIFICATE    = "RawOldCertificate",
    wszPROPREQUESTATTRIBUTES           = "RequestAttributes",
    wszPROPREQUESTTYPE                 = "RequestType",
    wszPROPREQUESTFLAGS                = "RequestFlags",
    wszPROPREQUESTSTATUSCODE           = "StatusCode",
    wszPROPREQUESTDISPOSITION          = "Disposition",
    wszPROPREQUESTDISPOSITIONMESSAGE   = "DispositionMessage",
    wszPROPREQUESTSUBMITTEDWHEN        = "SubmittedWhen",
    wszPROPREQUESTRESOLVEDWHEN         = "ResolvedWhen",
    wszPROPREQUESTREVOKEDWHEN          = "RevokedWhen",
    wszPROPREQUESTREVOKEDEFFECTIVEWHEN = "RevokedEffectiveWhen",
    wszPROPREQUESTREVOKEDREASON        = "RevokedReason",
    wszPROPREQUESTERNAME               = "RequesterName",
}

enum : const(wchar)*
{
    wszPROPCALLERNAME                = "CallerName",
    wszPROPSIGNERPOLICIES            = "SignerPolicies",
    wszPROPSIGNERAPPLICATIONPOLICIES = "SignerApplicationPolicies",
}

enum : const(wchar)*
{
    wszPROPOFFICER                 = "Officer",
    wszPROPPUBLISHEXPIREDCERTINCRL = "PublishExpiredCertInCRL",
}

enum const(wchar)* wszPROPREQUESTERNAMEFROMOLDCERTIFICATE = "RequesterNameFromOldCertificate";
enum const(wchar)* wszPROPATTESTATIONCHALLENGE = "AttestationChallenge";

enum : const(wchar)*
{
    wszPROPENDORSEMENTKEYHASH         = "EndorsementKeyHash",
    wszPROPENDORSEMENTCERTIFICATEHASH = "EndorsementCertificateHash",
}

enum const(wchar)* wszPROPRAWPRECERTIFICATE = "RawPrecertificate";
enum const(wchar)* wszPROPCRLPARTITIONINDEX = "CRLPartitionIndex";
enum const(wchar)* wszPROPLINTERCERTIFICATE = "LinterCertificate";

enum : const(wchar)*
{
    wszPROPCHALLENGE         = "Challenge",
    wszPROPEXPECTEDCHALLENGE = "ExpectedChallenge",
}

enum : const(wchar)*
{
    wszPROPDISPOSITION        = "Disposition",
    wszPROPDISPOSITIONDENY    = "Deny",
    wszPROPDISPOSITIONPENDING = "Pending",
}

enum : const(wchar)*
{
    wszPROPVALIDITYPERIODSTRING = "ValidityPeriod",
    wszPROPVALIDITYPERIODCOUNT  = "ValidityPeriodUnits",
}

enum const(wchar)* wszPROPEXPIRATIONDATE = "ExpirationDate";

enum : const(wchar)*
{
    wszPROPCERTTYPE           = "CertType",
    wszPROPCERTTEMPLATE       = "CertificateTemplate",
    wszPROPCERTUSAGE          = "CertificateUsage",
    wszPROPREQUESTOSVERSION   = "RequestOSVersion",
    wszPROPREQUESTCSPPROVIDER = "RequestCSPProvider",
}

enum const(wchar)* wszPROPEXITCERTFILE = "CertFile";
enum const(wchar)* wszPROPCLIENTBROWSERMACHINE = "cbm";
enum const(wchar)* wszPROPCERTCLIENTMACHINE = "ccm";
enum const(wchar)* wszPROPCLIENTDCDNS = "cdc";
enum const(wchar)* wszPROPREQUESTMACHINEDNS = "rmd";
enum const(wchar)* wszPROPSUBJECTALTNAME2 = "san";

enum : const(wchar)*
{
    wszPROPDNS       = "dns",
    wszPROPDN        = "dn",
    wszPROPURL       = "url",
    wszPROPIPADDRESS = "ipaddress",
    wszPROPGUID      = "guid",
    wszPROPOID       = "oid",
    wszPROPUPN       = "upn",
}

// Native encoding: ansi
enum const(wchar)* szPROPASNTAG = "{asn}";
enum const(wchar)* wszPROPCRITICALTAG = "{critical}";

enum : const(wchar)*
{
    wszPROPUTF8TAG    = "{utf8}",
    wszPROPOCTETTAG   = "{octet}",
    wszPROPHEXTAG     = "{hex}",
    wszPROPTEXTTAG    = "{text}",
    wszPROPDECIMALTAG = "{decimal}",
    wszPROPFILETAG    = "{file}",
}

enum const(wchar)* wszAT_EKCERTINF = "@EKCert";
enum const(wchar)* wszAT_TESTROOT = "@TestRoot";
enum const(wchar)* wszPROPLINTCERTIFICATE = "LintCertificate";

enum : const(wchar)*
{
    wszPROPCATYPE             = "CAType",
    wszPROPSANITIZEDCANAME    = "SanitizedCAName",
    wszPROPSANITIZEDSHORTNAME = "SanitizedShortName",
}

enum const(wchar)* wszPROPMACHINEDNSNAME = "MachineDNSName";
enum const(wchar)* wszPROPMODULEREGLOC = "ModuleRegistryLocation";

enum : const(wchar)*
{
    wszPROPUSEDS             = "fUseDS",
    wszPROPDELTACRLSDISABLED = "fDeltaCRLsDisabled",
}

enum const(wchar)* wszPROPSERVERUPGRADED = "fServerUpgraded";

enum : const(wchar)*
{
    wszPROPCONFIGDN     = "ConfigDN",
    wszPROPDOMAINDN     = "DomainDN",
    wszPROPLOGLEVEL     = "LogLevel",
    wszPROPSESSIONCOUNT = "SessionCount",
}

enum const(wchar)* wszPROPTEMPLATECHANGESEQUENCENUMBER = "TemplateChangeSequenceNumber";
enum const(wchar)* wszPROPVOLATILEMODE = "VolatileMode";
enum const(wchar)* wszLOCALIZEDTIMEPERIODUNITS = "LocalizedTimePeriodUnits";
enum const(wchar)* wszPROPREQUESTERCAACCESS = "RequesterCAAccess";

enum : const(wchar)*
{
    wszPROPUSERDN      = "UserDN",
    wszPROPKEYARCHIVED = "KeyArchived",
}

enum : const(wchar)*
{
    wszPROPCERTCOUNT        = "CertCount",
    wszPROPRAWCACERTIFICATE = "RawCACertificate",
}

enum : const(wchar)*
{
    wszPROPCERTSTATE   = "CertState",
    wszPROPCERTSUFFIX  = "CertSuffix",
    wszPROPRAWCRL      = "RawCRL",
    wszPROPRAWDELTACRL = "RawDeltaCRL",
}

enum : const(wchar)*
{
    wszPROPCRLINDEX           = "CRLIndex",
    wszPROPCRLSTATE           = "CRLState",
    wszPROPCRLSUFFIX          = "CRLSuffix",
    wszPROPEVENTLOGTERSE      = "EventLogTerse",
    wszPROPEVENTLOGERROR      = "EventLogError",
    wszPROPEVENTLOGWARNING    = "EventLogWarning",
    wszPROPEVENTLOGVERBOSE    = "EventLogVerbose",
    wszPROPEVENTLOGEXHAUSTIVE = "EventLogExhaustive",
}

enum : const(wchar)*
{
    wszPROPDCNAME      = "DCName",
    wszPROPCROSSFOREST = "CrossForest",
}

enum : const(wchar)*
{
    wszPROPREQUESTERSAMNAME = "RequesterSAMName",
    wszPROPREQUESTERUPN     = "RequesterUPN",
    wszPROPREQUESTERDN      = "RequesterDN",
}

enum : const(wchar)*
{
    wszPROPSEAUDITID     = "SEAuditId",
    wszPROPSEAUDITFILTER = "SEAuditFilter",
}

enum const(wchar)* wszPROPCERTIFICATEREQUESTID = "RequestID";
enum const(wchar)* wszPROPRAWCERTIFICATE = "RawCertificate";

enum : const(wchar)*
{
    wszPROPCERTIFICATEHASH                            = "CertificateHash",
    wszPROPCERTIFICATETEMPLATE                        = "CertificateTemplate",
    wszPROPCERTIFICATEENROLLMENTFLAGS                 = "EnrollmentFlags",
    wszPROPCERTIFICATEGENERALFLAGS                    = "GeneralFlags",
    wszPROPCERTIFICATEPRIVATEKEYFLAGS                 = "PrivatekeyFlags",
    wszPROPCERTIFICATESERIALNUMBER                    = "SerialNumber",
    wszPROPCERTIFICATENOTBEFOREDATE                   = "NotBefore",
    wszPROPCERTIFICATENOTAFTERDATE                    = "NotAfter",
    wszPROPCERTIFICATESUBJECTKEYIDENTIFIER            = "SubjectKeyIdentifier",
    wszPROPCERTIFICATERAWPUBLICKEY                    = "RawPublicKey",
    wszPROPCERTIFICATEPUBLICKEYLENGTH                 = "PublicKeyLength",
    wszPROPCERTIFICATEPUBLICKEYALGORITHM              = "PublicKeyAlgorithm",
    wszPROPCERTIFICATERAWPUBLICKEYALGORITHMPARAMETERS = "RawPublicKeyAlgorithmParameters",
}

enum : const(wchar)*
{
    wszPROPCERTIFICATEUPN                  = "UPN",
    wszPROPCERTIFICATETYPE                 = "CertificateType",
    wszPROPCERTIFICATERAWSMIMECAPABILITIES = "RawSMIMECapabilities",
}

enum const(wchar)* wszPROPNAMETYPE = "NameType";

enum : uint
{
    EXTENSION_CRITICAL_FLAG       = 0x00000001U,
    EXTENSION_DISABLE_FLAG        = 0x00000002U,
    EXTENSION_DELETE_FLAG         = 0x00000004U,
    EXTENSION_POLICY_MASK         = 0x0000ffffU,
    EXTENSION_ORIGIN_REQUEST      = 0x00010000U,
    EXTENSION_ORIGIN_POLICY       = 0x00020000U,
    EXTENSION_ORIGIN_ADMIN        = 0x00030000U,
    EXTENSION_ORIGIN_SERVER       = 0x00040000U,
    EXTENSION_ORIGIN_RENEWALCERT  = 0x00050000U,
    EXTENSION_ORIGIN_IMPORTEDCERT = 0x00060000U,
    EXTENSION_ORIGIN_PKCS7        = 0x00070000U,
    EXTENSION_ORIGIN_CMC          = 0x00080000U,
    EXTENSION_ORIGIN_CACERT       = 0x00090000U,
    EXTENSION_ORIGIN_MASK         = 0x000f0000U,
}

enum : const(wchar)*
{
    wszPROPEXTREQUESTID = "ExtensionRequestId",
    wszPROPEXTNAME      = "ExtensionName",
    wszPROPEXTFLAGS     = "ExtensionFlags",
    wszPROPEXTRAWVALUE  = "ExtensionRawValue",
}

enum : const(wchar)*
{
    wszPROPATTRIBREQUESTID = "AttributeRequestId",
    wszPROPATTRIBNAME      = "AttributeName",
    wszPROPATTRIBVALUE     = "AttributeValue",
}

enum : const(wchar)*
{
    wszPROPCRLROWID               = "CRLRowId",
    wszPROPCRLNUMBER              = "CRLNumber",
    wszPROPCRLMINBASE             = "CRLMinBase",
    wszPROPCRLNAMEID              = "CRLNameId",
    wszPROPCRLCOUNT               = "CRLCount",
    wszPROPCRLTHISUPDATE          = "CRLThisUpdate",
    wszPROPCRLNEXTUPDATE          = "CRLNextUpdate",
    wszPROPCRLTHISPUBLISH         = "CRLThisPublish",
    wszPROPCRLNEXTPUBLISH         = "CRLNextPublish",
    wszPROPCRLEFFECTIVE           = "CRLEffective",
    wszPROPCRLPROPAGATIONCOMPLETE = "CRLPropagationComplete",
}

enum : const(wchar)*
{
    wszPROPCRLLASTPUBLISHED     = "CRLLastPublished",
    wszPROPCRLPUBLISHATTEMPTS   = "CRLPublishAttempts",
    wszPROPCRLPUBLISHFLAGS      = "CRLPublishFlags",
    wszPROPCRLPUBLISHSTATUSCODE = "CRLPublishStatusCode",
    wszPROPCRLPUBLISHERROR      = "CRLPublishError",
    wszPROPCRLRAWCRL            = "CRLRawCRL",
}

enum : uint
{
    CPF_BASE     = 0x00000001U,
    CPF_DELTA    = 0x00000002U,
    CPF_COMPLETE = 0x00000004U,
}

enum uint CPF_SHADOW = 0x00000008U;
enum uint CPF_CASTORE_ERROR = 0x00000010U;
enum uint CPF_BADURL_ERROR = 0x00000020U;
enum uint CPF_MANUAL = 0x00000040U;
enum uint CPF_SIGNATURE_ERROR = 0x00000080U;
enum uint CPF_LDAP_ERROR = 0x00000100U;
enum uint CPF_FILE_ERROR = 0x00000200U;
enum uint CPF_FTP_ERROR = 0x00000400U;
enum uint CPF_HTTP_ERROR = 0x00000800U;

enum : uint
{
    CPF_POSTPONED_BASE_LDAP_ERROR = 0x00001000U,
    CPF_POSTPONED_BASE_FILE_ERROR = 0x00002000U,
}

enum uint PROPTYPE_MASK = 0x000000ffU;

enum : uint
{
    PROPCALLER_SERVER  = 0x00000100U,
    PROPCALLER_POLICY  = 0x00000200U,
    PROPCALLER_EXIT    = 0x00000300U,
    PROPCALLER_ADMIN   = 0x00000400U,
    PROPCALLER_REQUEST = 0x00000500U,
    PROPCALLER_MASK    = 0x00000f00U,
}

enum uint PROPFLAGS_INDEXED = 0x00010000U;
enum uint CR_FLG_FORCETELETEX = 0x00000001U;

enum : uint
{
    CR_FLG_RENEWAL          = 0x00000002U,
    CR_FLG_FORCEUTF8        = 0x00000004U,
    CR_FLG_CAXCHGCERT       = 0x00000008U,
    CR_FLG_ENROLLONBEHALFOF = 0x00000010U,
}

enum uint CR_FLG_SUBJECTUNMODIFIED = 0x00000020U;
enum uint CR_FLG_VALIDENCRYPTEDKEYHASH = 0x00000040U;
enum uint CR_FLG_CACROSSCERT = 0x00000080U;
enum uint CR_FLG_ENFORCEUTF8 = 0x00000100U;
enum uint CR_FLG_DEFINEDCACERT = 0x00000200U;

enum : uint
{
    CR_FLG_CHALLENGEPENDING   = 0x00000400U,
    CR_FLG_CHALLENGESATISFIED = 0x00000800U,
}

enum : uint
{
    CR_FLG_TRUSTONUSE   = 0x00001000U,
    CR_FLG_TRUSTEKCERT  = 0x00002000U,
    CR_FLG_TRUSTEKKEY   = 0x00004000U,
    CR_FLG_PUBLISHERROR = 0x80000000U,
}

enum : uint
{
    DB_DISP_ACTIVE        = 0x00000008U,
    DB_DISP_PENDING       = 0x00000009U,
    DB_DISP_QUEUE_MAX     = 0x00000009U,
    DB_DISP_FOREIGN       = 0x0000000cU,
    DB_DISP_CA_CERT       = 0x0000000fU,
    DB_DISP_CA_CERT_CHAIN = 0x00000010U,
}

enum : uint
{
    DB_DISP_KRA_CERT       = 0x00000011U,
    DB_DISP_LOG_MIN        = 0x00000014U,
    DB_DISP_ISSUED         = 0x00000014U,
    DB_DISP_REVOKED        = 0x00000015U,
    DB_DISP_LOG_FAILED_MIN = 0x0000001eU,
}

enum : uint
{
    DB_DISP_ERROR  = 0x0000001eU,
    DB_DISP_DENIED = 0x0000001fU,
}

enum uint VR_PENDING = 0x00000000U;

enum : uint
{
    VR_INSTANT_OK  = 0x00000001U,
    VR_INSTANT_BAD = 0x00000002U,
}

enum : const(wchar)*
{
    wszCERT_TYPE          = "RequestType",
    wszCERT_TYPE_CLIENT   = "Client",
    wszCERT_TYPE_SERVER   = "Server",
    wszCERT_TYPE_CODESIGN = "CodeSign",
    wszCERT_TYPE_CUSTOMER = "SetCustomer",
    wszCERT_TYPE_MERCHANT = "SetMerchant",
    wszCERT_TYPE_PAYMENT  = "SetPayment",
}

enum : const(wchar)*
{
    wszCERT_VERSION   = "Version",
    wszCERT_VERSION_1 = "1",
    wszCERT_VERSION_2 = "2",
    wszCERT_VERSION_3 = "3",
}

enum : uint
{
    CV_OUT_HEXRAW     = 0x0000000cU,
    CV_OUT_ENCODEMASK = 0x000000ffU,
    CV_OUT_NOCRLF     = 0x40000000U,
    CV_OUT_NOCR       = 0x80000000U,
}

enum : uint
{
    CVR_SEEK_NONE    = 0x00000000U,
    CVR_SEEK_MASK    = 0x000000ffU,
    CVR_SEEK_NODELTA = 0x00001000U,
}

enum : uint
{
    CVR_SORT_NONE    = 0x00000000U,
    CVR_SORT_ASCEND  = 0x00000001U,
    CVR_SORT_DESCEND = 0x00000002U,
}

enum int CV_COLUMN_EXTENSION_DEFAULT = 0xfffffffc;
enum int CV_COLUMN_ATTRIBUTE_DEFAULT = 0xfffffffb;

enum : int
{
    CV_COLUMN_CRL_DEFAULT         = 0xfffffffa,
    CV_COLUMN_LOG_REVOKED_DEFAULT = 0xfffffff9,
}

enum : uint
{
    CVRC_TABLE_MASK  = 0x0000f000U,
    CVRC_TABLE_SHIFT = 0x0000000cU,
}

enum uint CRYPT_ENUM_ALL_PROVIDERS = 0x00000001U;
enum int XEPR_ENUM_FIRST = 0xffffffff;

enum : uint
{
    XEPR_DATE         = 0x00000005U,
    XEPR_TEMPLATENAME = 0x00000006U,
}

enum : uint
{
    XEPR_VERSION        = 0x00000007U,
    XEPR_V1TEMPLATENAME = 0x00000009U,
}

enum uint XEPR_V2TEMPLATEOID = 0x00000010U;
enum uint XEKL_KEYSIZE_DEFAULT = 0x00000004U;
enum uint XECP_STRING_PROPERTY = 0x00000001U;

enum : uint
{
    XECI_DISABLE    = 0x00000000U,
    XECI_XENROLL    = 0x00000001U,
    XECI_AUTOENROLL = 0x00000002U,
}

enum uint XECI_REQWIZARD = 0x00000003U;
enum uint XECI_CERTREQ = 0x00000004U;

enum : const(wchar)*
{
    wszCMM_PROP_NAME            = "Name",
    wszCMM_PROP_DESCRIPTION     = "Description",
    wszCMM_PROP_COPYRIGHT       = "Copyright",
    wszCMM_PROP_FILEVER         = "File Version",
    wszCMM_PROP_PRODUCTVER      = "Product Version",
    wszCMM_PROP_DISPLAY_HWND    = "HWND",
    wszCMM_PROP_ISMULTITHREADED = "IsMultiThreaded",
}

// Callbacks

alias FNCERTSRVISSERVERONLINEW = HRESULT function(const(PWSTR) pwszServerName, BOOL* pfServerOnline);
alias FNCERTSRVBACKUPGETDYNAMICFILELISTW = HRESULT function(void* hbc, ushort** ppwszzFileList, uint* pcbSize);
alias FNCERTSRVBACKUPPREPAREW = HRESULT function(const(PWSTR) pwszServerName, uint grbitJet, uint dwBackupFlags, 
                                                 void** phbc);
alias FNCERTSRVBACKUPGETDATABASENAMESW = HRESULT function(void* hbc, ushort** ppwszzAttachmentInformation, 
                                                          uint* pcbSize);
alias FNCERTSRVBACKUPOPENFILEW = HRESULT function(void* hbc, const(PWSTR) pwszAttachmentName, uint cbReadHintSize, 
                                                  long* pliFileSize);
alias FNCERTSRVBACKUPREAD = HRESULT function(void* hbc, void* pvBuffer, uint cbBuffer, uint* pcbRead);
alias FNCERTSRVBACKUPCLOSE = HRESULT function(void* hbc);
alias FNCERTSRVBACKUPGETBACKUPLOGSW = HRESULT function(void* hbc, ushort** ppwszzBackupLogFiles, uint* pcbSize);
alias FNCERTSRVBACKUPTRUNCATELOGS = HRESULT function(void* hbc);
alias FNCERTSRVBACKUPEND = HRESULT function(void* hbc);
alias FNCERTSRVBACKUPFREE = void function(void* pv);
alias FNCERTSRVRESTOREGETDATABASELOCATIONSW = HRESULT function(void* hbc, ushort** ppwszzDatabaseLocationList, 
                                                               uint* pcbSize);
alias FNCERTSRVRESTOREPREPAREW = HRESULT function(const(PWSTR) pwszServerName, uint dwRestoreFlags, void** phbc);
alias FNCERTSRVRESTOREREGISTERW = HRESULT function(void* hbc, const(PWSTR) pwszCheckPointFilePath, 
                                                   const(PWSTR) pwszLogPath, CSEDB_RSTMAPW* rgrstmap, int crstmap, 
                                                   const(PWSTR) pwszBackupLogPath, uint genLow, uint genHigh);
alias FNCERTSRVRESTOREREGISTERCOMPLETE = HRESULT function(void* hbc, HRESULT hrRestoreState);
alias FNCERTSRVRESTOREEND = HRESULT function(void* hbc);
alias FNCERTSRVSERVERCONTROLW = HRESULT function(const(PWSTR) pwszServerName, uint dwControlFlags, uint* pcbOut, 
                                                 ubyte** ppbOut);
alias FNIMPORTPFXTOPROVIDER = HRESULT function(/*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/HWND hWndParent, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/const(ubyte)* pbPFX, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/uint cbPFX, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/ImportPFXFlags ImportFlags, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/const(PWSTR) pwszPassword, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/const(PWSTR) pwszProviderName, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/const(PWSTR) pwszReaderName, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/const(PWSTR) pwszContainerNamePrefix, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/const(PWSTR) pwszPin, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/const(PWSTR) pwszFriendlyName, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/uint* pcCertOut, 
                                               /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoprovider))], [])*/CERT_CONTEXT*** prgpCertOut);
alias FNIMPORTPFXTOPROVIDERFREEDATA = void function(/*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoproviderfreedata))], [])*/uint cCert, 
                                                    /*PARAM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/certenroll/nc-certenroll-importpfxtoproviderfreedata))], [])*/CERT_CONTEXT** rgpCert);

// Structs


struct CSEDB_RSTMAPW
{
    PWSTR pwszDatabaseName;
    PWSTR pwszNewDatabaseName;
}

struct CERTTRANSBLOB
{
    uint   cb;
    ubyte* pb;
}

struct CERTVIEWRESTRICTION
{
    uint   ColumnIndex;
    int    SeekOperator;
    int    SortOrder;
    ubyte* pbValue;
    uint   cbValue;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CAINFO
{
    uint         cbSize;
    ENUM_CATYPES CAType;
    uint         cCASignatureCerts;
    uint         cCAExchangeCerts;
    uint         cExitModules;
    int          lPropIdMax;
    int          lRoleSeparationEnabled;
    uint         cKRACertUsedCount;
    uint         cKRACertCount;
    uint         fAdvancedServer;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvIsServerOnlineW(const(PWSTR) pwszServerName, BOOL* pfServerOnline);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvBackupGetDynamicFileListW(void* hbc, PWSTR* ppwszzFileList, uint* pcbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvBackupPrepareW(const(PWSTR) pwszServerName, uint grbitJet, CSBACKUP_TYPE dwBackupFlags, void** phbc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvBackupGetDatabaseNamesW(void* hbc, PWSTR* ppwszzAttachmentInformation, uint* pcbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvBackupOpenFileW(void* hbc, const(PWSTR) pwszAttachmentName, uint cbReadHintSize, long* pliFileSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvBackupRead(void* hbc, void* pvBuffer, uint cbBuffer, uint* pcbRead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvBackupClose(void* hbc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvBackupGetBackupLogsW(void* hbc, PWSTR* ppwszzBackupLogFiles, uint* pcbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvBackupTruncateLogs(void* hbc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvBackupEnd(void* hbc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
void CertSrvBackupFree(void* pv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvRestoreGetDatabaseLocationsW(void* hbc, PWSTR* ppwszzDatabaseLocationList, uint* pcbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvRestorePrepareW(const(PWSTR) pwszServerName, uint dwRestoreFlags, void** phbc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvRestoreRegisterW(void* hbc, const(PWSTR) pwszCheckPointFilePath, const(PWSTR) pwszLogPath, 
                                CSEDB_RSTMAPW* rgrstmap, int crstmap, const(PWSTR) pwszBackupLogPath, uint genLow, 
                                uint genHigh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvRestoreRegisterThroughFile(void* hbc, const(PWSTR) pwszCheckPointFilePath, const(PWSTR) pwszLogPath, 
                                          CSEDB_RSTMAPW* rgrstmap, int crstmap, const(PWSTR) pwszBackupLogPath, 
                                          uint genLow, uint genHigh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvRestoreRegisterComplete(void* hbc, HRESULT hrRestoreState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvRestoreEnd(void* hbc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("certadm.dll")
HRESULT CertSrvServerControlW(const(PWSTR) pwszServerName, uint dwControlFlags, uint* pcbOut, ubyte** ppbOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("certpoleng.dll")
NTSTATUS PstGetTrustAnchors(UNICODE_STRING* pTargetName, uint cCriteria, CERT_SELECT_CRITERIA* rgpCriteria, 
                            SecPkgContext_IssuerListInfoEx** ppTrustedIssuers);

@DllImport("certpoleng.dll")
NTSTATUS PstGetTrustAnchorsEx(UNICODE_STRING* pTargetName, uint cCriteria, CERT_SELECT_CRITERIA* rgpCriteria, 
                              const(CERT_CONTEXT)* pCertContext, SecPkgContext_IssuerListInfoEx** ppTrustedIssuers);

@DllImport("certpoleng.dll")
NTSTATUS PstGetCertificateChain(const(CERT_CONTEXT)* pCert, SecPkgContext_IssuerListInfoEx* pTrustedIssuers, 
                                CERT_CHAIN_CONTEXT** ppCertChainContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("certpoleng.dll")
NTSTATUS PstGetCertificates(UNICODE_STRING* pTargetName, uint cCriteria, CERT_SELECT_CRITERIA* rgpCriteria, 
                            BOOL bIsClient, uint* pdwCertChainContextCount, 
                            CERT_CHAIN_CONTEXT*** ppCertChainContexts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("certpoleng.dll")
NTSTATUS PstAcquirePrivateKey(const(CERT_CONTEXT)* pCert);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("certpoleng.dll")
NTSTATUS PstValidate(UNICODE_STRING* pTargetName, BOOL bIsClient, CERT_USAGE_MATCH* pRequestedIssuancePolicy, 
                     HCERTSTORE* phAdditionalCertStore, const(CERT_CONTEXT)* pCert, GUID* pProvGUID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("certpoleng.dll")
NTSTATUS PstMapCertificate(const(CERT_CONTEXT)* pCert, LSA_TOKEN_INFORMATION_TYPE* pTokenInformationType, 
                           void** ppTokenInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("certpoleng.dll")
NTSTATUS PstGetUserNameForCertificate(const(CERT_CONTEXT)* pCertContext, UNICODE_STRING* UserName);


// Interfaces

@GUID("37eabaf0-7fb6-11d0-8817-00a0c903b83c")
struct CCertAdmin;

@GUID("a12d0f7a-1e84-11d1-9bd6-00c04fb683fa")
struct CCertView;

@GUID("f935a528-ba8a-4dd9-ba79-f283275cb2de")
struct OCSPPropertyCollection;

@GUID("d3f73511-92c9-47cb-8ff2-8d891a7c4de4")
struct OCSPAdmin;

@GUID("c6cc49b0-ce17-11d0-8833-00a0c903b83c")
struct CCertGetConfig;

@GUID("372fce38-4324-11d0-8810-00a0c903b83c")
struct CCertConfig;

@GUID("98aff3f0-5524-11d0-8812-00a0c903b83c")
struct CCertRequest;

@GUID("aa000926-ffbe-11cf-8800-00a0c903b83c")
struct CCertServerPolicy;

@GUID("4c4a5e40-732c-11d0-8816-00a0c903b83c")
struct CCertServerExit;

@GUID("884e2000-217d-11da-b2a4-000e7bbb2b09")
struct CObjectId;

@GUID("884e2001-217d-11da-b2a4-000e7bbb2b09")
struct CObjectIds;

@GUID("884e2002-217d-11da-b2a4-000e7bbb2b09")
struct CBinaryConverter;

@GUID("884e2003-217d-11da-b2a4-000e7bbb2b09")
struct CX500DistinguishedName;

@GUID("884e2007-217d-11da-b2a4-000e7bbb2b09")
struct CCspInformation;

@GUID("884e2008-217d-11da-b2a4-000e7bbb2b09")
struct CCspInformations;

@GUID("884e2009-217d-11da-b2a4-000e7bbb2b09")
struct CCspStatus;

@GUID("884e200b-217d-11da-b2a4-000e7bbb2b09")
struct CX509PublicKey;

@GUID("884e200c-217d-11da-b2a4-000e7bbb2b09")
struct CX509PrivateKey;

@GUID("11a25a1d-b9a3-4edd-af83-3b59adbed361")
struct CX509EndorsementKey;

@GUID("884e200d-217d-11da-b2a4-000e7bbb2b09")
struct CX509Extension;

@GUID("884e200e-217d-11da-b2a4-000e7bbb2b09")
struct CX509Extensions;

@GUID("884e200f-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionKeyUsage;

@GUID("884e2010-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionEnhancedKeyUsage;

@GUID("884e2011-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionTemplateName;

@GUID("884e2012-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionTemplate;

@GUID("884e2013-217d-11da-b2a4-000e7bbb2b09")
struct CAlternativeName;

@GUID("884e2014-217d-11da-b2a4-000e7bbb2b09")
struct CAlternativeNames;

@GUID("884e2015-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionAlternativeNames;

@GUID("884e2016-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionBasicConstraints;

@GUID("884e2017-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionSubjectKeyIdentifier;

@GUID("884e2018-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionAuthorityKeyIdentifier;

@GUID("884e2019-217d-11da-b2a4-000e7bbb2b09")
struct CSmimeCapability;

@GUID("884e201a-217d-11da-b2a4-000e7bbb2b09")
struct CSmimeCapabilities;

@GUID("884e201b-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionSmimeCapabilities;

@GUID("884e201c-217d-11da-b2a4-000e7bbb2b09")
struct CPolicyQualifier;

@GUID("884e201d-217d-11da-b2a4-000e7bbb2b09")
struct CPolicyQualifiers;

@GUID("884e201e-217d-11da-b2a4-000e7bbb2b09")
struct CCertificatePolicy;

@GUID("884e201f-217d-11da-b2a4-000e7bbb2b09")
struct CCertificatePolicies;

@GUID("884e2020-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionCertificatePolicies;

@GUID("884e2021-217d-11da-b2a4-000e7bbb2b09")
struct CX509ExtensionMSApplicationPolicies;

@GUID("884e2022-217d-11da-b2a4-000e7bbb2b09")
struct CX509Attribute;

@GUID("884e2023-217d-11da-b2a4-000e7bbb2b09")
struct CX509Attributes;

@GUID("884e2024-217d-11da-b2a4-000e7bbb2b09")
struct CX509AttributeExtensions;

@GUID("884e2025-217d-11da-b2a4-000e7bbb2b09")
struct CX509AttributeClientId;

@GUID("884e2026-217d-11da-b2a4-000e7bbb2b09")
struct CX509AttributeRenewalCertificate;

@GUID("884e2027-217d-11da-b2a4-000e7bbb2b09")
struct CX509AttributeArchiveKey;

@GUID("884e2028-217d-11da-b2a4-000e7bbb2b09")
struct CX509AttributeArchiveKeyHash;

@GUID("884e202a-217d-11da-b2a4-000e7bbb2b09")
struct CX509AttributeOSVersion;

@GUID("884e202b-217d-11da-b2a4-000e7bbb2b09")
struct CX509AttributeCspProvider;

@GUID("884e202c-217d-11da-b2a4-000e7bbb2b09")
struct CCryptAttribute;

@GUID("884e202d-217d-11da-b2a4-000e7bbb2b09")
struct CCryptAttributes;

@GUID("884e202e-217d-11da-b2a4-000e7bbb2b09")
struct CCertProperty;

@GUID("884e202f-217d-11da-b2a4-000e7bbb2b09")
struct CCertProperties;

@GUID("884e2030-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyFriendlyName;

@GUID("884e2031-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyDescription;

@GUID("884e2032-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyAutoEnroll;

@GUID("884e2033-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyRequestOriginator;

@GUID("884e2034-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertySHA1Hash;

@GUID("884e2036-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyKeyProvInfo;

@GUID("884e2037-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyArchived;

@GUID("884e2038-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyBackedUp;

@GUID("884e2039-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyEnrollment;

@GUID("884e203a-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyRenewal;

@GUID("884e203b-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyArchivedKeyHash;

@GUID("884e204c-217d-11da-b2a4-000e7bbb2b09")
struct CCertPropertyEnrollmentPolicyServer;

@GUID("884e203d-217d-11da-b2a4-000e7bbb2b09")
struct CSignerCertificate;

@GUID("884e203f-217d-11da-b2a4-000e7bbb2b09")
struct CX509NameValuePair;

@GUID("1362ada1-eb60-456a-b6e1-118050db741b")
struct CCertificateAttestationChallenge;

@GUID("884e2042-217d-11da-b2a4-000e7bbb2b09")
struct CX509CertificateRequestPkcs10;

@GUID("884e2043-217d-11da-b2a4-000e7bbb2b09")
struct CX509CertificateRequestCertificate;

@GUID("884e2044-217d-11da-b2a4-000e7bbb2b09")
struct CX509CertificateRequestPkcs7;

@GUID("884e2045-217d-11da-b2a4-000e7bbb2b09")
struct CX509CertificateRequestCmc;

@GUID("884e2046-217d-11da-b2a4-000e7bbb2b09")
struct CX509Enrollment;

@GUID("884e2049-217d-11da-b2a4-000e7bbb2b09")
struct CX509EnrollmentWebClassFactory;

@GUID("884e2050-217d-11da-b2a4-000e7bbb2b09")
struct CX509EnrollmentHelper;

@GUID("884e2051-217d-11da-b2a4-000e7bbb2b09")
struct CX509MachineEnrollmentFactory;

@GUID("91f39027-217f-11da-b2a4-000e7bbb2b09")
struct CX509EnrollmentPolicyActiveDirectory;

@GUID("91f39028-217f-11da-b2a4-000e7bbb2b09")
struct CX509EnrollmentPolicyWebService;

@GUID("91f39029-217f-11da-b2a4-000e7bbb2b09")
struct CX509PolicyServerListManager;

@GUID("91f3902a-217f-11da-b2a4-000e7bbb2b09")
struct CX509PolicyServerUrl;

@GUID("8336e323-2e6a-4a04-937c-548f681839b3")
struct CX509CertificateTemplateADWritable;

@GUID("884e205e-217d-11da-b2a4-000e7bbb2b09")
struct CX509CertificateRevocationListEntry;

@GUID("884e205f-217d-11da-b2a4-000e7bbb2b09")
struct CX509CertificateRevocationListEntries;

@GUID("884e2060-217d-11da-b2a4-000e7bbb2b09")
struct CX509CertificateRevocationList;

@GUID("884e2061-217d-11da-b2a4-000e7bbb2b09")
struct CX509SCEPEnrollment;

@GUID("884e2062-217d-11da-b2a4-000e7bbb2b09")
struct CX509SCEPEnrollmentHelper;

@GUID("19a76fe0-7494-11d0-8816-00a0c903b83c")
struct CCertEncodeStringArray;

@GUID("4e0680a0-a0a2-11d0-8821-00a0c903b83c")
struct CCertEncodeLongArray;

@GUID("301f77b0-a470-11d0-8821-00a0c903b83c")
struct CCertEncodeDateArray;

@GUID("01fa60a0-bbff-11d0-8825-00a0c903b83c")
struct CCertEncodeCRLDistInfo;

@GUID("1cfc4cda-1271-11d1-9bd4-00c04fb683fa")
struct CCertEncodeAltName;

@GUID("6d6b3cd8-1278-11d1-9bd4-00c04fb683fa")
struct CCertEncodeBitString;

@GUID("127698e4-e730-4e5c-a2b1-21490a70c8a1")
struct CEnroll2;

@GUID("43f8f289-7a20-11d0-8f06-00c04fc295e1")
struct CEnroll;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nn-certview-ienumcertviewcolumn
@GUID("9c735be2-57a5-11d1-9bdb-00c04fb683fa")
interface IEnumCERTVIEWCOLUMN : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewcolumn-next
    HRESULT Next(int* pIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewcolumn-getname
    HRESULT GetName(BSTR* pstrOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewcolumn-getdisplayname
    HRESULT GetDisplayName(BSTR* pstrOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewcolumn-gettype
    HRESULT GetType(int* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewcolumn-isindexed
    HRESULT IsIndexed(int* pIndexed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewcolumn-getmaxlength
    HRESULT GetMaxLength(int* pMaxLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewcolumn-getvalue
    HRESULT GetValue(ENUM_CERT_COLUMN_VALUE_FLAGS Flags, VARIANT* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewcolumn-skip
    HRESULT Skip(int celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewcolumn-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewcolumn-clone
    HRESULT Clone(IEnumCERTVIEWCOLUMN* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nn-certview-ienumcertviewattribute
@GUID("e77db656-7653-11d1-9bde-00c04fb683fa")
interface IEnumCERTVIEWATTRIBUTE : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewattribute-next
    HRESULT Next(int* pIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewattribute-getname
    HRESULT GetName(BSTR* pstrOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewattribute-getvalue
    HRESULT GetValue(BSTR* pstrOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewattribute-skip
    HRESULT Skip(int celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewattribute-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewattribute-clone
    HRESULT Clone(IEnumCERTVIEWATTRIBUTE* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nn-certview-ienumcertviewextension
@GUID("e7dd1466-7653-11d1-9bde-00c04fb683fa")
interface IEnumCERTVIEWEXTENSION : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewextension-next
    HRESULT Next(int* pIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewextension-getname
    HRESULT GetName(BSTR* pstrOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewextension-getflags
    HRESULT GetFlags(int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewextension-getvalue
    HRESULT GetValue(CERT_PROPERTY_TYPE Type, ENUM_CERT_COLUMN_VALUE_FLAGS Flags, VARIANT* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewextension-skip
    HRESULT Skip(int celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewextension-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewextension-clone
    HRESULT Clone(IEnumCERTVIEWEXTENSION* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nn-certview-ienumcertviewrow
@GUID("d1157f4c-5af2-11d1-9bdc-00c04fb683fa")
interface IEnumCERTVIEWROW : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewrow-next
    HRESULT Next(int* pIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewrow-enumcertviewcolumn
    HRESULT EnumCertViewColumn(IEnumCERTVIEWCOLUMN* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewrow-enumcertviewattribute
    HRESULT EnumCertViewAttribute(int Flags, IEnumCERTVIEWATTRIBUTE* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewrow-enumcertviewextension
    HRESULT EnumCertViewExtension(int Flags, IEnumCERTVIEWEXTENSION* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewrow-skip
    HRESULT Skip(int celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewrow-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nn-certview-ienumcertviewrow
    HRESULT Clone(IEnumCERTVIEWROW* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-ienumcertviewrow-getmaxindex
    HRESULT GetMaxIndex(int* pIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nn-certview-icertview
@GUID("c3fac344-1e84-11d1-9bd6-00c04fb683fa")
interface ICertView : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-icertview-openconnection
    HRESULT OpenConnection(const(BSTR) strConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-icertview-enumcertviewcolumn
    HRESULT EnumCertViewColumn(CVRC_COLUMN fResultColumn, IEnumCERTVIEWCOLUMN* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-icertview-getcolumncount
    HRESULT GetColumnCount(CVRC_COLUMN fResultColumn, int* pcColumn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-icertview-getcolumnindex
    HRESULT GetColumnIndex(CVRC_COLUMN fResultColumn, const(BSTR) strColumnName, int* pColumnIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-icertview-setresultcolumncount
    HRESULT SetResultColumnCount(int cResultColumn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-icertview-setresultcolumn
    HRESULT SetResultColumn(int ColumnIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-icertview-setrestriction
    HRESULT SetRestriction(CERT_VIEW_COLUMN_INDEX ColumnIndex, CERT_VIEW_SEEK_OPERATOR_FLAGS SeekOperator, 
                           int SortOrder, const(VARIANT)* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-icertview-openview
    HRESULT OpenView(IEnumCERTVIEWROW* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nn-certview-icertview2
@GUID("d594b282-8851-4b61-9c66-3edadf848863")
interface ICertView2 : ICertView
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certview/nf-certview-icertview2-settable
    HRESULT SetTable(CVRC_TABLE Table);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nn-certadm-icertadmin
@GUID("34df6950-7fb6-11d0-8817-00a0c903b83c")
interface ICertAdmin : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin-isvalidcertificate
    HRESULT IsValidCertificate(const(BSTR) strConfig, const(BSTR) strSerialNumber, int* pDisposition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin-getrevocationreason
    HRESULT GetRevocationReason(int* pReason);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin-revokecertificate
    HRESULT RevokeCertificate(const(BSTR) strConfig, const(BSTR) strSerialNumber, int Reason, double Date);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin-setrequestattributes
    HRESULT SetRequestAttributes(const(BSTR) strConfig, int RequestId, const(BSTR) strAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin-setcertificateextension
    HRESULT SetCertificateExtension(const(BSTR) strConfig, int RequestId, const(BSTR) strExtensionName, 
                                    CERT_PROPERTY_TYPE Type, int Flags, const(VARIANT)* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin-denyrequest
    HRESULT DenyRequest(const(BSTR) strConfig, int RequestId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin-resubmitrequest
    HRESULT ResubmitRequest(const(BSTR) strConfig, int RequestId, int* pDisposition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin-publishcrl
    HRESULT PublishCRL(const(BSTR) strConfig, double Date);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin-getcrl
    HRESULT GetCRL(const(BSTR) strConfig, int Flags, BSTR* pstrCRL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin-importcertificate
    HRESULT ImportCertificate(const(BSTR) strConfig, const(BSTR) strCertificate, CERT_IMPORT_FLAGS Flags, 
                              int* pRequestId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nn-certadm-icertadmin2
@GUID("f7c3ac41-b8ce-4fb4-aa58-3d1dc0e36b39")
interface ICertAdmin2 : ICertAdmin
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-publishcrls
    HRESULT PublishCRLs(const(BSTR) strConfig, double Date, int CRLFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-getcaproperty
    HRESULT GetCAProperty(const(BSTR) strConfig, int PropId, int PropIndex, int PropType, int Flags, 
                          VARIANT* pvarPropertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-setcaproperty
    HRESULT SetCAProperty(const(BSTR) strConfig, int PropId, int PropIndex, CERT_PROPERTY_TYPE PropType, 
                          VARIANT* pvarPropertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-getcapropertyflags
    HRESULT GetCAPropertyFlags(const(BSTR) strConfig, int PropId, int* pPropFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-getcapropertydisplayname
    HRESULT GetCAPropertyDisplayName(const(BSTR) strConfig, int PropId, BSTR* pstrDisplayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-getarchivedkey
    HRESULT GetArchivedKey(const(BSTR) strConfig, int RequestId, int Flags, BSTR* pstrArchivedKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-getconfigentry
    HRESULT GetConfigEntry(const(BSTR) strConfig, const(BSTR) strNodePath, const(BSTR) strEntryName, 
                           VARIANT* pvarEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-setconfigentry
    HRESULT SetConfigEntry(const(BSTR) strConfig, const(BSTR) strNodePath, const(BSTR) strEntryName, 
                           VARIANT* pvarEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-importkey
    HRESULT ImportKey(const(BSTR) strConfig, int RequestId, const(BSTR) strCertHash, CERT_IMPORT_FLAGS Flags, 
                      const(BSTR) strKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-getmyroles
    HRESULT GetMyRoles(const(BSTR) strConfig, CERTADMIN_GET_ROLES_FLAGS* pRoles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-icertadmin2-deleterow
    HRESULT DeleteRow(const(BSTR) strConfig, CERT_DELETE_ROW_FLAGS Flags, double Date, CVRC_TABLE Table, int RowId, 
                      int* pcDeleted);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nn-certadm-iocspproperty
@GUID("66fb7839-5f04-4c25-ad18-9ff1a8376ee0")
interface IOCSPProperty : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspproperty-get_name
    HRESULT get_Name(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspproperty-get_value
    HRESULT get_Value(VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspproperty-put_value
    HRESULT put_Value(VARIANT newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspproperty-get_modified
    HRESULT get_Modified(VARIANT_BOOL* pVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nn-certadm-iocsppropertycollection
@GUID("2597c18d-54e6-4b74-9fa9-a6bfda99cbbe")
interface IOCSPPropertyCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocsppropertycollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocsppropertycollection-get_item
    HRESULT get_Item(int Index, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocsppropertycollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocsppropertycollection-get_itembyname
    HRESULT get_ItemByName(const(BSTR) bstrPropName, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocsppropertycollection-createproperty
    HRESULT CreateProperty(const(BSTR) bstrPropName, const(VARIANT)* pVarPropValue, IOCSPProperty* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocsppropertycollection-deleteproperty
    HRESULT DeleteProperty(const(BSTR) bstrPropName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocsppropertycollection-initializefromproperties
    HRESULT InitializeFromProperties(const(VARIANT)* pVarProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocsppropertycollection-getallproperties
    HRESULT GetAllProperties(VARIANT* pVarProperties);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nn-certadm-iocspcaconfiguration
@GUID("aec92b40-3d46-433f-87d1-b84d5c1e790d")
interface IOCSPCAConfiguration : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_identifier
    HRESULT get_Identifier(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_cacertificate
    HRESULT get_CACertificate(VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_hashalgorithm
    HRESULT get_HashAlgorithm(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-put_hashalgorithm
    HRESULT put_HashAlgorithm(const(BSTR) newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_signingflags
    HRESULT get_SigningFlags(uint* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-put_signingflags
    HRESULT put_SigningFlags(uint newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_signingcertificate
    HRESULT get_SigningCertificate(VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-put_signingcertificate
    HRESULT put_SigningCertificate(VARIANT newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_reminderduration
    HRESULT get_ReminderDuration(uint* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-put_reminderduration
    HRESULT put_ReminderDuration(uint newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_errorcode
    HRESULT get_ErrorCode(uint* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_cspname
    HRESULT get_CSPName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_keyspec
    HRESULT get_KeySpec(uint* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_providerclsid
    HRESULT get_ProviderCLSID(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-put_providerclsid
    HRESULT put_ProviderCLSID(const(BSTR) newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_providerproperties
    HRESULT get_ProviderProperties(VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-put_providerproperties
    HRESULT put_ProviderProperties(VARIANT newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_modified
    HRESULT get_Modified(VARIANT_BOOL* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_localrevocationinformation
    HRESULT get_LocalRevocationInformation(VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-put_localrevocationinformation
    HRESULT put_LocalRevocationInformation(VARIANT newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_signingcertificatetemplate
    HRESULT get_SigningCertificateTemplate(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-put_signingcertificatetemplate
    HRESULT put_SigningCertificateTemplate(const(BSTR) newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-get_caconfig
    HRESULT get_CAConfig(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfiguration-put_caconfig
    HRESULT put_CAConfig(const(BSTR) newVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nn-certadm-iocspcaconfigurationcollection
@GUID("2bebea0b-5ece-4f28-a91c-86b4bb20f0d3")
interface IOCSPCAConfigurationCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfigurationcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfigurationcollection-get_item
    HRESULT get_Item(int Index, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfigurationcollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfigurationcollection-get_itembyname
    HRESULT get_ItemByName(const(BSTR) bstrIdentifier, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfigurationcollection-createcaconfiguration
    HRESULT CreateCAConfiguration(const(BSTR) bstrIdentifier, VARIANT varCACert, IOCSPCAConfiguration* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspcaconfigurationcollection-deletecaconfiguration
    HRESULT DeleteCAConfiguration(const(BSTR) bstrIdentifier);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nn-certadm-iocspadmin
@GUID("322e830d-67db-4fe9-9577-4596d9f09294")
interface IOCSPAdmin : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspadmin-get_ocspserviceproperties
    HRESULT get_OCSPServiceProperties(IOCSPPropertyCollection* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspadmin-get_ocspcaconfigurationcollection
    HRESULT get_OCSPCAConfigurationCollection(IOCSPCAConfigurationCollection* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspadmin-getconfiguration
    HRESULT GetConfiguration(const(BSTR) bstrServerName, VARIANT_BOOL bForce);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspadmin-setconfiguration
    HRESULT SetConfiguration(const(BSTR) bstrServerName, VARIANT_BOOL bForce);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspadmin-getmyroles
    HRESULT GetMyRoles(const(BSTR) bstrServerName, int* pRoles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspadmin-ping
    HRESULT Ping(const(BSTR) bstrServerName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspadmin-setsecurity
    HRESULT SetSecurity(const(BSTR) bstrServerName, const(BSTR) bstrVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspadmin-getsecurity
    HRESULT GetSecurity(const(BSTR) bstrServerName, BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspadmin-getsigningcertificates
    HRESULT GetSigningCertificates(const(BSTR) bstrServerName, const(VARIANT)* pCACertVar, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certadm/nf-certadm-iocspadmin-gethashalgorithms
    HRESULT GetHashAlgorithms(const(BSTR) bstrServerName, const(BSTR) bstrCAId, VARIANT* pVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nn-certif-icertserverpolicy
@GUID("aa000922-ffbe-11cf-8800-00a0c903b83c")
interface ICertServerPolicy : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-setcontext
    HRESULT SetContext(int Context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-getrequestproperty
    HRESULT GetRequestProperty(const(BSTR) strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-getrequestattribute
    HRESULT GetRequestAttribute(const(BSTR) strAttributeName, BSTR* pstrAttributeValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-getcertificateproperty
    HRESULT GetCertificateProperty(const(BSTR) strPropertyName, CERT_PROPERTY_TYPE PropertyType, 
                                   VARIANT* pvarPropertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-setcertificateproperty
    HRESULT SetCertificateProperty(const(BSTR) strPropertyName, int PropertyType, 
                                   const(VARIANT)* pvarPropertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-getcertificateextension
    HRESULT GetCertificateExtension(const(BSTR) strExtensionName, CERT_PROPERTY_TYPE Type, VARIANT* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-getcertificateextensionflags
    HRESULT GetCertificateExtensionFlags(int* pExtFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-setcertificateextension
    HRESULT SetCertificateExtension(const(BSTR) strExtensionName, int Type, int ExtFlags, 
                                    const(VARIANT)* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-enumerateextensionssetup
    HRESULT EnumerateExtensionsSetup(int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-enumerateextensions
    HRESULT EnumerateExtensions(BSTR* pstrExtensionName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-enumerateextensionsclose
    HRESULT EnumerateExtensionsClose();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-enumerateattributessetup
    HRESULT EnumerateAttributesSetup(int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-enumerateattributes
    HRESULT EnumerateAttributes(BSTR* pstrAttributeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverpolicy-enumerateattributesclose
    HRESULT EnumerateAttributesClose();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nn-certif-icertserverexit
@GUID("4ba9eb90-732c-11d0-8816-00a0c903b83c")
interface ICertServerExit : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-setcontext
    HRESULT SetContext(int Context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-getrequestproperty
    HRESULT GetRequestProperty(const(BSTR) strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-getrequestattribute
    HRESULT GetRequestAttribute(const(BSTR) strAttributeName, BSTR* pstrAttributeValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-getcertificateproperty
    HRESULT GetCertificateProperty(const(BSTR) strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-getcertificateextension
    HRESULT GetCertificateExtension(const(BSTR) strExtensionName, int Type, VARIANT* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-getcertificateextensionflags
    HRESULT GetCertificateExtensionFlags(int* pExtFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-enumerateextensionssetup
    HRESULT EnumerateExtensionsSetup(int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-enumerateextensions
    HRESULT EnumerateExtensions(BSTR* pstrExtensionName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-enumerateextensionsclose
    HRESULT EnumerateExtensionsClose();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-enumerateattributessetup
    HRESULT EnumerateAttributesSetup(int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-enumerateattributes
    HRESULT EnumerateAttributes(BSTR* pstrAttributeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certif/nf-certif-icertserverexit-enumerateattributesclose
    HRESULT EnumerateAttributesClose();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nn-certcli-icertgetconfig
@GUID("c7ea09c0-ce17-11d0-8833-00a0c903b83c")
interface ICertGetConfig : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertgetconfig-getconfig
    HRESULT GetConfig(CERT_GET_CONFIG_FLAGS Flags, BSTR* pstrOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nn-certcli-icertconfig
@GUID("372fce34-4324-11d0-8810-00a0c903b83c")
interface ICertConfig : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertconfig-reset
    HRESULT Reset(int Index, int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertconfig-next
    HRESULT Next(int* pIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertconfig-getfield
    HRESULT GetField(const(BSTR) strFieldName, BSTR* pstrOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertconfig-getconfig
    HRESULT GetConfig(int Flags, BSTR* pstrOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nn-certcli-icertconfig2
@GUID("7a18edde-7e78-4163-8ded-78e2c9cee924")
interface ICertConfig2 : ICertConfig
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertconfig2-setsharedfolder
    HRESULT SetSharedFolder(const(BSTR) strSharedFolder);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nn-certcli-icertrequest
@GUID("014e4840-5523-11d0-8812-00a0c903b83c")
interface ICertRequest : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest-submit
    HRESULT Submit(int Flags, const(BSTR) strRequest, const(BSTR) strAttributes, const(BSTR) strConfig, 
                   int* pDisposition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest-retrievepending
    HRESULT RetrievePending(int RequestId, const(BSTR) strConfig, int* pDisposition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest-getlaststatus
    HRESULT GetLastStatus(int* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest-getrequestid
    HRESULT GetRequestId(int* pRequestId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest-getdispositionmessage
    HRESULT GetDispositionMessage(BSTR* pstrDispositionMessage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest-getcacertificate
    HRESULT GetCACertificate(int fExchangeCertificate, const(BSTR) strConfig, int Flags, BSTR* pstrCertificate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest-getcertificate
    HRESULT GetCertificate(int Flags, BSTR* pstrCertificate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nn-certcli-icertrequest2
@GUID("a4772988-4a85-4fa9-824e-b5cf5c16405a")
interface ICertRequest2 : ICertRequest
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest2-getissuedcertificate
    HRESULT GetIssuedCertificate(const(BSTR) strConfig, int RequestId, const(BSTR) strSerialNumber, 
                                 CR_DISP* pDisposition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest2-geterrormessagetext
    HRESULT GetErrorMessageText(int hrMessage, int Flags, BSTR* pstrErrorMessageText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest2-getcaproperty
    HRESULT GetCAProperty(const(BSTR) strConfig, int PropId, int PropIndex, int PropType, int Flags, 
                          VARIANT* pvarPropertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest2-getcapropertyflags
    HRESULT GetCAPropertyFlags(const(BSTR) strConfig, int PropId, int* pPropFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest2-getcapropertydisplayname
    HRESULT GetCAPropertyDisplayName(const(BSTR) strConfig, int PropId, BSTR* pstrDisplayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest2-getfullresponseproperty
    HRESULT GetFullResponseProperty(FULL_RESPONSE_PROPERTY_ID PropId, int PropIndex, CERT_PROPERTY_TYPE PropType, 
                                    CERT_REQUEST_OUT_TYPE Flags, VARIANT* pvarPropertyValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nn-certcli-icertrequest3
@GUID("afc8f92b-33a2-4861-bf36-2933b7cd67b3")
interface ICertRequest3 : ICertRequest2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest3-setcredential
    HRESULT SetCredential(int hWnd, X509EnrollmentAuthFlags AuthType, BSTR strCredential, BSTR strPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest3-getrequestidstring
    HRESULT GetRequestIdString(BSTR* pstrRequestId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest3-getissuedcertificate2
    HRESULT GetIssuedCertificate2(BSTR strConfig, BSTR strRequestId, BSTR strSerialNumber, CR_DISP* pDisposition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certcli/nf-certcli-icertrequest3-getrefreshpolicy
    HRESULT GetRefreshPolicy(VARIANT_BOOL* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certmod/nn-certmod-icertmanagemodule
@GUID("e7d7ad42-bd3d-11d1-9a4d-00c04fc297eb")
interface ICertManageModule : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certmod/nf-certmod-icertmanagemodule-getproperty
    HRESULT GetProperty(const(BSTR) strConfig, BSTR strStorageLocation, BSTR strPropertyName, int Flags, 
                        VARIANT* pvarProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certmod/nf-certmod-icertmanagemodule-setproperty
    HRESULT SetProperty(const(BSTR) strConfig, BSTR strStorageLocation, BSTR strPropertyName, int Flags, 
                        const(VARIANT)* pvarProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certmod/nf-certmod-icertmanagemodule-configure
    HRESULT Configure(const(BSTR) strConfig, BSTR strStorageLocation, int Flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nn-certpol-icertpolicy
@GUID("38bb5a00-7636-11d0-b413-00a0c91bbf8c")
interface ICertPolicy : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nf-certpol-icertpolicy-initialize
    HRESULT Initialize(const(BSTR) strConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nf-certpol-icertpolicy-verifyrequest
    HRESULT VerifyRequest(const(BSTR) strConfig, int Context, int bNewRequest, int Flags, int* pDisposition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nf-certpol-icertpolicy-getdescription
    HRESULT GetDescription(BSTR* pstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nf-certpol-icertpolicy-shutdown
    HRESULT ShutDown();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nn-certpol-icertpolicy2
@GUID("3db4910e-8001-4bf1-aa1b-f43a808317a0")
interface ICertPolicy2 : ICertPolicy
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nf-certpol-icertpolicy2-getmanagemodule
    HRESULT GetManageModule(ICertManageModule* ppManageModule);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nn-certpol-indespolicy
@GUID("13ca515d-431d-46cc-8c2e-1da269bbd625")
interface INDESPolicy : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nf-certpol-indespolicy-initialize
    HRESULT Initialize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nf-certpol-indespolicy-uninitialize
    HRESULT Uninitialize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nf-certpol-indespolicy-generatechallenge
    HRESULT GenerateChallenge(const(PWSTR) pwszTemplate, const(PWSTR) pwszParams, PWSTR* ppwszResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nf-certpol-indespolicy-verifyrequest
    HRESULT VerifyRequest(CERTTRANSBLOB* pctbRequest, CERTTRANSBLOB* pctbSigningCertEncoded, 
                          const(PWSTR) pwszTemplate, const(PWSTR) pwszTransactionId, BOOL* pfVerified);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certpol/nf-certpol-indespolicy-notify
    HRESULT Notify(const(PWSTR) pwszChallenge, const(PWSTR) pwszTransactionId, X509SCEPDisposition disposition, 
                   int lastHResult, CERTTRANSBLOB* pctbIssuedCertEncoded);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-iobjectid
@GUID("728ab300-217d-11da-b2a4-000e7bbb2b09")
interface IObjectId : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectid-initializefromname
    HRESULT InitializeFromName(CERTENROLL_OBJECTID Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectid-initializefromvalue
    HRESULT InitializeFromValue(BSTR strValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectid-initializefromalgorithmname
    HRESULT InitializeFromAlgorithmName(ObjectIdGroupId GroupId, ObjectIdPublicKeyFlags KeyFlags, 
                                        AlgorithmFlags AlgFlags, BSTR strAlgorithmName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectid-get_name
    HRESULT get_Name(CERTENROLL_OBJECTID* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectid-get_friendlyname
    HRESULT get_FriendlyName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectid-put_friendlyname
    HRESULT put_FriendlyName(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectid-get_value
    HRESULT get_Value(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectid-getalgorithmname
    HRESULT GetAlgorithmName(ObjectIdGroupId GroupId, ObjectIdPublicKeyFlags KeyFlags, BSTR* pstrAlgorithmName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-iobjectids
@GUID("728ab301-217d-11da-b2a4-000e7bbb2b09")
interface IObjectIds : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectids-get_itembyindex
    HRESULT get_ItemByIndex(int Index, IObjectId* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectids-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectids-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectids-add
    HRESULT Add(IObjectId pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectids-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectids-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-iobjectids-addrange
    HRESULT AddRange(IObjectIds pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ibinaryconverter
@GUID("728ab302-217d-11da-b2a4-000e7bbb2b09")
interface IBinaryConverter : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ibinaryconverter-stringtostring
    HRESULT StringToString(BSTR strEncodedIn, EncodingType EncodingIn, EncodingType Encoding, BSTR* pstrEncoded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ibinaryconverter-variantbytearraytostring
    HRESULT VariantByteArrayToString(VARIANT* pvarByteArray, EncodingType Encoding, BSTR* pstrEncoded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ibinaryconverter-stringtovariantbytearray
    HRESULT StringToVariantByteArray(BSTR strEncoded, EncodingType Encoding, VARIANT* pvarByteArray);
}

@GUID("8d7928b4-4e17-428d-9a17-728df00d1b2b")
interface IBinaryConverter2 : IBinaryConverter
{
    HRESULT StringArrayToVariantArray(VARIANT* pvarStringArray, VARIANT* pvarVariantArray);
    HRESULT VariantArrayToStringArray(VARIANT* pvarVariantArray, VARIANT* pvarStringArray);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix500distinguishedname
@GUID("728ab303-217d-11da-b2a4-000e7bbb2b09")
interface IX500DistinguishedName : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix500distinguishedname-decode
    HRESULT Decode(BSTR strEncodedName, EncodingType Encoding, X500NameFlags NameFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix500distinguishedname-encode
    HRESULT Encode(BSTR strName, X500NameFlags NameFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix500distinguishedname-get_name
    HRESULT get_Name(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix500distinguishedname-get_encodedname
    HRESULT get_EncodedName(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509enrollmentstatus
@GUID("728ab304-217d-11da-b2a4-000e7bbb2b09")
interface IX509EnrollmentStatus : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-appendtext
    HRESULT AppendText(BSTR strText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-get_text
    HRESULT get_Text(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-put_text
    HRESULT put_Text(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-get_selected
    HRESULT get_Selected(EnrollmentSelectionStatus* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-put_selected
    HRESULT put_Selected(EnrollmentSelectionStatus Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-get_display
    HRESULT get_Display(EnrollmentDisplayStatus* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-put_display
    HRESULT put_Display(EnrollmentDisplayStatus Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-get_status
    HRESULT get_Status(EnrollmentEnrollStatus* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-put_status
    HRESULT put_Status(EnrollmentEnrollStatus Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-get_error
    HRESULT get_Error(HRESULT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-put_error
    HRESULT put_Error(HRESULT Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentstatus-get_errortext
    HRESULT get_ErrorText(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icspalgorithm
@GUID("728ab305-217d-11da-b2a4-000e7bbb2b09")
interface ICspAlgorithm : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithm-getalgorithmoid
    HRESULT GetAlgorithmOid(int Length, AlgorithmFlags AlgFlags, IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithm-get_defaultlength
    HRESULT get_DefaultLength(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithm-get_incrementlength
    HRESULT get_IncrementLength(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithm-get_longname
    HRESULT get_LongName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithm-get_valid
    HRESULT get_Valid(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithm-get_maxlength
    HRESULT get_MaxLength(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithm-get_minlength
    HRESULT get_MinLength(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithm-get_name
    HRESULT get_Name(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithm-get_type
    HRESULT get_Type(AlgorithmType* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithm-get_operations
    HRESULT get_Operations(AlgorithmOperationFlags* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icspalgorithms
@GUID("728ab306-217d-11da-b2a4-000e7bbb2b09")
interface ICspAlgorithms : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithms-get_itembyindex
    HRESULT get_ItemByIndex(int Index, ICspAlgorithm* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithms-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithms-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithms-add
    HRESULT Add(ICspAlgorithm pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithms-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithms-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithms-get_itembyname
    HRESULT get_ItemByName(BSTR strName, ICspAlgorithm* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspalgorithms-get_indexbyobjectid
    HRESULT get_IndexByObjectId(IObjectId pObjectId, int* pIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icspinformation
@GUID("728ab307-217d-11da-b2a4-000e7bbb2b09")
interface ICspInformation : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-initializefromname
    HRESULT InitializeFromName(BSTR strName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-initializefromtype
    HRESULT InitializeFromType(X509ProviderType Type, IObjectId pAlgorithm, VARIANT_BOOL MachineContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_cspalgorithms
    HRESULT get_CspAlgorithms(ICspAlgorithms* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_hashardwarerandomnumbergenerator
    HRESULT get_HasHardwareRandomNumberGenerator(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_ishardwaredevice
    HRESULT get_IsHardwareDevice(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_isremovable
    HRESULT get_IsRemovable(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_issoftwaredevice
    HRESULT get_IsSoftwareDevice(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_valid
    HRESULT get_Valid(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_maxkeycontainernamelength
    HRESULT get_MaxKeyContainerNameLength(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_name
    HRESULT get_Name(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_type
    HRESULT get_Type(X509ProviderType* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_version
    HRESULT get_Version(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_keyspec
    HRESULT get_KeySpec(X509KeySpec* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_issmartcard
    HRESULT get_IsSmartCard(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-getdefaultsecuritydescriptor
    HRESULT GetDefaultSecurityDescriptor(VARIANT_BOOL MachineContext, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-get_legacycsp
    HRESULT get_LegacyCsp(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformation-getcspstatusfromoperations
    HRESULT GetCspStatusFromOperations(IObjectId pAlgorithm, AlgorithmOperationFlags Operations, 
                                       ICspStatus* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icspinformations
@GUID("728ab308-217d-11da-b2a4-000e7bbb2b09")
interface ICspInformations : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-get_itembyindex
    HRESULT get_ItemByIndex(int Index, ICspInformation* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-add
    HRESULT Add(ICspInformation pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-addavailablecsps
    HRESULT AddAvailableCsps();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-get_itembyname
    HRESULT get_ItemByName(BSTR strName, ICspInformation* ppCspInformation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-getcspstatusfromprovidername
    HRESULT GetCspStatusFromProviderName(BSTR strProviderName, X509KeySpec LegacyKeySpec, ICspStatus* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-getcspstatusesfromoperations
    HRESULT GetCspStatusesFromOperations(AlgorithmOperationFlags Operations, ICspInformation pCspInformation, 
                                         ICspStatuses* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-getencryptioncspalgorithms
    HRESULT GetEncryptionCspAlgorithms(ICspInformation pCspInformation, ICspAlgorithms* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspinformations-gethashalgorithms
    HRESULT GetHashAlgorithms(ICspInformation pCspInformation, IObjectIds* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icspstatus
@GUID("728ab309-217d-11da-b2a4-000e7bbb2b09")
interface ICspStatus : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatus-initialize
    HRESULT Initialize(ICspInformation pCsp, ICspAlgorithm pAlgorithm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatus-get_ordinal
    HRESULT get_Ordinal(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatus-put_ordinal
    HRESULT put_Ordinal(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatus-get_cspalgorithm
    HRESULT get_CspAlgorithm(ICspAlgorithm* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatus-get_cspinformation
    HRESULT get_CspInformation(ICspInformation* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatus-get_enrollmentstatus
    HRESULT get_EnrollmentStatus(IX509EnrollmentStatus* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatus-get_displayname
    HRESULT get_DisplayName(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icspstatuses
@GUID("728ab30a-217d-11da-b2a4-000e7bbb2b09")
interface ICspStatuses : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatuses-get_itembyindex
    HRESULT get_ItemByIndex(int Index, ICspStatus* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatuses-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatuses-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatuses-add
    HRESULT Add(ICspStatus pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatuses-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatuses-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatuses-get_itembyname
    HRESULT get_ItemByName(BSTR strCspName, BSTR strAlgorithmName, ICspStatus* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatuses-get_itembyordinal
    HRESULT get_ItemByOrdinal(int Ordinal, ICspStatus* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatuses-get_itembyoperations
    HRESULT get_ItemByOperations(BSTR strCspName, BSTR strAlgorithmName, AlgorithmOperationFlags Operations, 
                                 ICspStatus* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icspstatuses-get_itembyprovider
    HRESULT get_ItemByProvider(ICspStatus pCspStatus, ICspStatus* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509publickey
@GUID("728ab30b-217d-11da-b2a4-000e7bbb2b09")
interface IX509PublicKey : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509publickey-initialize
    HRESULT Initialize(IObjectId pObjectId, BSTR strEncodedKey, BSTR strEncodedParameters, EncodingType Encoding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509publickey-initializefromencodedpublickeyinfo
    HRESULT InitializeFromEncodedPublicKeyInfo(BSTR strEncodedPublicKeyInfo, EncodingType Encoding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509publickey-get_algorithm
    HRESULT get_Algorithm(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509publickey-get_length
    HRESULT get_Length(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509publickey-get_encodedkey
    HRESULT get_EncodedKey(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509publickey-get_encodedparameters
    HRESULT get_EncodedParameters(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509publickey-computekeyidentifier
    HRESULT ComputeKeyIdentifier(KeyIdentifierHashAlgorithm Algorithm, EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509privatekey
@GUID("728ab30c-217d-11da-b2a4-000e7bbb2b09")
interface IX509PrivateKey : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-open
    HRESULT Open();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-create
    HRESULT Create();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-delete
    HRESULT Delete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-verify
    HRESULT Verify(X509PrivateKeyVerify VerifyType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-import
    HRESULT Import(BSTR strExportType, BSTR strEncodedKey, EncodingType Encoding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-export
    HRESULT Export(BSTR strExportType, EncodingType Encoding, BSTR* pstrEncodedKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-exportpublickey
    HRESULT ExportPublicKey(IX509PublicKey* ppPublicKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_containername
    HRESULT get_ContainerName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_containername
    HRESULT put_ContainerName(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_containernameprefix
    HRESULT get_ContainerNamePrefix(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_containernameprefix
    HRESULT put_ContainerNamePrefix(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_readername
    HRESULT get_ReaderName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_readername
    HRESULT put_ReaderName(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_cspinformations
    HRESULT get_CspInformations(ICspInformations* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_cspinformations
    HRESULT put_CspInformations(ICspInformations pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_cspstatus
    HRESULT get_CspStatus(ICspStatus* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_cspstatus
    HRESULT put_CspStatus(ICspStatus pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_providername
    HRESULT get_ProviderName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_providername
    HRESULT put_ProviderName(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_providertype
    HRESULT get_ProviderType(X509ProviderType* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_providertype
    HRESULT put_ProviderType(X509ProviderType Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_legacycsp
    HRESULT get_LegacyCsp(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_legacycsp
    HRESULT put_LegacyCsp(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_algorithm
    HRESULT get_Algorithm(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_algorithm
    HRESULT put_Algorithm(IObjectId pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_keyspec
    HRESULT get_KeySpec(X509KeySpec* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_keyspec
    HRESULT put_KeySpec(X509KeySpec Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_length
    HRESULT get_Length(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_length
    HRESULT put_Length(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_exportpolicy
    HRESULT get_ExportPolicy(X509PrivateKeyExportFlags* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_exportpolicy
    HRESULT put_ExportPolicy(X509PrivateKeyExportFlags Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_keyusage
    HRESULT get_KeyUsage(X509PrivateKeyUsageFlags* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_keyusage
    HRESULT put_KeyUsage(X509PrivateKeyUsageFlags Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_keyprotection
    HRESULT get_KeyProtection(X509PrivateKeyProtection* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_keyprotection
    HRESULT put_KeyProtection(X509PrivateKeyProtection Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_machinecontext
    HRESULT get_MachineContext(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_machinecontext
    HRESULT put_MachineContext(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_securitydescriptor
    HRESULT get_SecurityDescriptor(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_securitydescriptor
    HRESULT put_SecurityDescriptor(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_certificate
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_certificate
    HRESULT put_Certificate(EncodingType Encoding, BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_uniquecontainername
    HRESULT get_UniqueContainerName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_opened
    HRESULT get_Opened(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_defaultcontainer
    HRESULT get_DefaultContainer(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_existing
    HRESULT get_Existing(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_existing
    HRESULT put_Existing(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_silent
    HRESULT get_Silent(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_silent
    HRESULT put_Silent(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_parentwindow
    HRESULT get_ParentWindow(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_parentwindow
    HRESULT put_ParentWindow(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_uicontextmessage
    HRESULT get_UIContextMessage(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_uicontextmessage
    HRESULT put_UIContextMessage(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_pin
    HRESULT put_Pin(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_friendlyname
    HRESULT get_FriendlyName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_friendlyname
    HRESULT put_FriendlyName(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-get_description
    HRESULT get_Description(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509privatekey-put_description
    HRESULT put_Description(BSTR Value);
}

@GUID("728ab362-217d-11da-b2a4-000e7bbb2b09")
interface IX509PrivateKey2 : IX509PrivateKey
{
    HRESULT get_HardwareKeyUsage(X509HardwareKeyUsageFlags* pValue);
    HRESULT put_HardwareKeyUsage(X509HardwareKeyUsageFlags Value);
    HRESULT get_AlternateStorageLocation(BSTR* pValue);
    HRESULT put_AlternateStorageLocation(BSTR Value);
    HRESULT get_AlgorithmName(BSTR* pValue);
    HRESULT put_AlgorithmName(BSTR Value);
    HRESULT get_AlgorithmParameters(EncodingType Encoding, BSTR* pValue);
    HRESULT put_AlgorithmParameters(EncodingType Encoding, BSTR Value);
    HRESULT get_ParametersExportType(X509KeyParametersExportType* pValue);
    HRESULT put_ParametersExportType(X509KeyParametersExportType Value);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509endorsementkey
@GUID("b11cd855-f4c4-4fc6-b710-4422237f09e9")
interface IX509EndorsementKey : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-get_providername
    HRESULT get_ProviderName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-put_providername
    HRESULT put_ProviderName(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-get_length
    HRESULT get_Length(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-get_opened
    HRESULT get_Opened(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-addcertificate
    HRESULT AddCertificate(EncodingType Encoding, BSTR strCertificate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-removecertificate
    HRESULT RemoveCertificate(EncodingType Encoding, BSTR strCertificate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-getcertificatebyindex
    HRESULT GetCertificateByIndex(VARIANT_BOOL ManufacturerOnly, int dwIndex, EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-getcertificatecount
    HRESULT GetCertificateCount(VARIANT_BOOL ManufacturerOnly, int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-exportpublickey
    HRESULT ExportPublicKey(IX509PublicKey* ppPublicKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-open
    HRESULT Open();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509endorsementkey-close
    HRESULT Close();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extension
@GUID("728ab30d-217d-11da-b2a4-000e7bbb2b09")
interface IX509Extension : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extension-initialize
    HRESULT Initialize(IObjectId pObjectId, EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extension-get_objectid
    HRESULT get_ObjectId(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extension-get_rawdata
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extension-get_critical
    HRESULT get_Critical(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extension-put_critical
    HRESULT put_Critical(VARIANT_BOOL Value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensions
@GUID("728ab30e-217d-11da-b2a4-000e7bbb2b09")
interface IX509Extensions : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensions-get_itembyindex
    HRESULT get_ItemByIndex(int Index, IX509Extension* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensions-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensions-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensions-add
    HRESULT Add(IX509Extension pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensions-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensions-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensions-get_indexbyobjectid
    HRESULT get_IndexByObjectId(IObjectId pObjectId, int* pIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensions-addrange
    HRESULT AddRange(IX509Extensions pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensionkeyusage
@GUID("728ab30f-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionKeyUsage : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionkeyusage-initializeencode
    HRESULT InitializeEncode(X509KeyUsageFlags UsageFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionkeyusage-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionkeyusage-get_keyusage
    HRESULT get_KeyUsage(X509KeyUsageFlags* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensionenhancedkeyusage
@GUID("728ab310-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionEnhancedKeyUsage : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionenhancedkeyusage-initializeencode
    HRESULT InitializeEncode(IObjectIds pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionenhancedkeyusage-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionenhancedkeyusage-get_enhancedkeyusage
    HRESULT get_EnhancedKeyUsage(IObjectIds* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensiontemplatename
@GUID("728ab311-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionTemplateName : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensiontemplatename-initializeencode
    HRESULT InitializeEncode(BSTR strTemplateName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensiontemplatename-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensiontemplatename-get_templatename
    HRESULT get_TemplateName(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensiontemplate
@GUID("728ab312-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionTemplate : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensiontemplate-initializeencode
    HRESULT InitializeEncode(IObjectId pTemplateOid, int MajorVersion, int MinorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensiontemplate-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensiontemplate-get_templateoid
    HRESULT get_TemplateOid(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensiontemplate-get_majorversion
    HRESULT get_MajorVersion(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensiontemplate-get_minorversion
    HRESULT get_MinorVersion(int* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ialternativename
@GUID("728ab313-217d-11da-b2a4-000e7bbb2b09")
interface IAlternativeName : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativename-initializefromstring
    HRESULT InitializeFromString(AlternativeNameType Type, BSTR strValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativename-initializefromrawdata
    HRESULT InitializeFromRawData(AlternativeNameType Type, EncodingType Encoding, BSTR strRawData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativename-initializefromothername
    HRESULT InitializeFromOtherName(IObjectId pObjectId, EncodingType Encoding, BSTR strRawData, 
                                    VARIANT_BOOL ToBeWrapped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativename-get_type
    HRESULT get_Type(AlternativeNameType* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativename-get_strvalue
    HRESULT get_StrValue(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativename-get_objectid
    HRESULT get_ObjectId(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativename-get_rawdata
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ialternativenames
@GUID("728ab314-217d-11da-b2a4-000e7bbb2b09")
interface IAlternativeNames : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativenames-get_itembyindex
    HRESULT get_ItemByIndex(int Index, IAlternativeName* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativenames-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativenames-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativenames-add
    HRESULT Add(IAlternativeName pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativenames-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ialternativenames-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensionalternativenames
@GUID("728ab315-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionAlternativeNames : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionalternativenames-initializeencode
    HRESULT InitializeEncode(IAlternativeNames pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionalternativenames-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionalternativenames-get_alternativenames
    HRESULT get_AlternativeNames(IAlternativeNames* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensionbasicconstraints
@GUID("728ab316-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionBasicConstraints : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionbasicconstraints-initializeencode
    HRESULT InitializeEncode(VARIANT_BOOL IsCA, int PathLenConstraint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionbasicconstraints-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionbasicconstraints-get_isca
    HRESULT get_IsCA(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionbasicconstraints-get_pathlenconstraint
    HRESULT get_PathLenConstraint(int* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensionsubjectkeyidentifier
@GUID("728ab317-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionSubjectKeyIdentifier : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionsubjectkeyidentifier-initializeencode
    HRESULT InitializeEncode(EncodingType Encoding, BSTR strKeyIdentifier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionsubjectkeyidentifier-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionsubjectkeyidentifier-get_subjectkeyidentifier
    HRESULT get_SubjectKeyIdentifier(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensionauthoritykeyidentifier
@GUID("728ab318-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionAuthorityKeyIdentifier : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionauthoritykeyidentifier-initializeencode
    HRESULT InitializeEncode(EncodingType Encoding, BSTR strKeyIdentifier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionauthoritykeyidentifier-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionauthoritykeyidentifier-get_authoritykeyidentifier
    HRESULT get_AuthorityKeyIdentifier(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ismimecapability
@GUID("728ab319-217d-11da-b2a4-000e7bbb2b09")
interface ISmimeCapability : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapability-initialize
    HRESULT Initialize(IObjectId pObjectId, int BitCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapability-get_objectid
    HRESULT get_ObjectId(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapability-get_bitcount
    HRESULT get_BitCount(int* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ismimecapabilities
@GUID("728ab31a-217d-11da-b2a4-000e7bbb2b09")
interface ISmimeCapabilities : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapabilities-get_itembyindex
    HRESULT get_ItemByIndex(int Index, ISmimeCapability* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapabilities-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapabilities-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapabilities-add
    HRESULT Add(ISmimeCapability pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapabilities-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapabilities-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapabilities-addfromcsp
    HRESULT AddFromCsp(ICspInformation pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ismimecapabilities-addavailablesmimecapabilities
    HRESULT AddAvailableSmimeCapabilities(VARIANT_BOOL MachineContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensionsmimecapabilities
@GUID("728ab31b-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionSmimeCapabilities : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionsmimecapabilities-initializeencode
    HRESULT InitializeEncode(ISmimeCapabilities pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionsmimecapabilities-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionsmimecapabilities-get_smimecapabilities
    HRESULT get_SmimeCapabilities(ISmimeCapabilities* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ipolicyqualifier
@GUID("728ab31c-217d-11da-b2a4-000e7bbb2b09")
interface IPolicyQualifier : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifier-initializeencode
    HRESULT InitializeEncode(BSTR strQualifier, PolicyQualifierType Type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifier-get_objectid
    HRESULT get_ObjectId(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifier-get_qualifier
    HRESULT get_Qualifier(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifier-get_type
    HRESULT get_Type(PolicyQualifierType* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifier-get_rawdata
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ipolicyqualifiers
@GUID("728ab31d-217d-11da-b2a4-000e7bbb2b09")
interface IPolicyQualifiers : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifiers-get_itembyindex
    HRESULT get_ItemByIndex(int Index, IPolicyQualifier* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifiers-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifiers-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifiers-add
    HRESULT Add(IPolicyQualifier pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifiers-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ipolicyqualifiers-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertificatepolicy
@GUID("728ab31e-217d-11da-b2a4-000e7bbb2b09")
interface ICertificatePolicy : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificatepolicy-initialize
    HRESULT Initialize(IObjectId pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificatepolicy-get_objectid
    HRESULT get_ObjectId(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificatepolicy-get_policyqualifiers
    HRESULT get_PolicyQualifiers(IPolicyQualifiers* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertificatepolicies
@GUID("728ab31f-217d-11da-b2a4-000e7bbb2b09")
interface ICertificatePolicies : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificatepolicies-get_itembyindex
    HRESULT get_ItemByIndex(int Index, ICertificatePolicy* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificatepolicies-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificatepolicies-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificatepolicies-add
    HRESULT Add(ICertificatePolicy pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificatepolicies-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificatepolicies-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensioncertificatepolicies
@GUID("728ab320-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionCertificatePolicies : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensioncertificatepolicies-initializeencode
    HRESULT InitializeEncode(ICertificatePolicies pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensioncertificatepolicies-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensioncertificatepolicies-get_policies
    HRESULT get_Policies(ICertificatePolicies* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509extensionmsapplicationpolicies
@GUID("728ab321-217d-11da-b2a4-000e7bbb2b09")
interface IX509ExtensionMSApplicationPolicies : IX509Extension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionmsapplicationpolicies-initializeencode
    HRESULT InitializeEncode(ICertificatePolicies pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionmsapplicationpolicies-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509extensionmsapplicationpolicies-get_policies
    HRESULT get_Policies(ICertificatePolicies* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509attribute
@GUID("728ab322-217d-11da-b2a4-000e7bbb2b09")
interface IX509Attribute : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attribute-initialize
    HRESULT Initialize(IObjectId pObjectId, EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attribute-get_objectid
    HRESULT get_ObjectId(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attribute-get_rawdata
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509attributes
@GUID("728ab323-217d-11da-b2a4-000e7bbb2b09")
interface IX509Attributes : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributes-get_itembyindex
    HRESULT get_ItemByIndex(int Index, IX509Attribute* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributes-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributes-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributes-add
    HRESULT Add(IX509Attribute pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributes-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributes-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509attributeextensions
@GUID("728ab324-217d-11da-b2a4-000e7bbb2b09")
interface IX509AttributeExtensions : IX509Attribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeextensions-initializeencode
    HRESULT InitializeEncode(IX509Extensions pExtensions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeextensions-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeextensions-get_x509extensions
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509attributeclientid
@GUID("728ab325-217d-11da-b2a4-000e7bbb2b09")
interface IX509AttributeClientId : IX509Attribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeclientid-initializeencode
    HRESULT InitializeEncode(RequestClientInfoClientId ClientId, BSTR strMachineDnsName, BSTR strUserSamName, 
                             BSTR strProcessName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeclientid-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeclientid-get_clientid
    HRESULT get_ClientId(RequestClientInfoClientId* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeclientid-get_machinednsname
    HRESULT get_MachineDnsName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeclientid-get_usersamname
    HRESULT get_UserSamName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeclientid-get_processname
    HRESULT get_ProcessName(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509attributerenewalcertificate
@GUID("728ab326-217d-11da-b2a4-000e7bbb2b09")
interface IX509AttributeRenewalCertificate : IX509Attribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributerenewalcertificate-initializeencode
    HRESULT InitializeEncode(EncodingType Encoding, BSTR strCert);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributerenewalcertificate-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributerenewalcertificate-get_renewalcertificate
    HRESULT get_RenewalCertificate(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509attributearchivekey
@GUID("728ab327-217d-11da-b2a4-000e7bbb2b09")
interface IX509AttributeArchiveKey : IX509Attribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributearchivekey-initializeencode
    HRESULT InitializeEncode(IX509PrivateKey pKey, EncodingType Encoding, BSTR strCAXCert, IObjectId pAlgorithm, 
                             int EncryptionStrength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributearchivekey-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributearchivekey-get_encryptedkeyblob
    HRESULT get_EncryptedKeyBlob(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributearchivekey-get_encryptionalgorithm
    HRESULT get_EncryptionAlgorithm(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributearchivekey-get_encryptionstrength
    HRESULT get_EncryptionStrength(int* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509attributearchivekeyhash
@GUID("728ab328-217d-11da-b2a4-000e7bbb2b09")
interface IX509AttributeArchiveKeyHash : IX509Attribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributearchivekeyhash-initializeencodefromencryptedkeyblob
    HRESULT InitializeEncodeFromEncryptedKeyBlob(EncodingType Encoding, BSTR strEncryptedKeyBlob);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributearchivekeyhash-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributearchivekeyhash-get_encryptedkeyhashblob
    HRESULT get_EncryptedKeyHashBlob(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509attributeosversion
@GUID("728ab32a-217d-11da-b2a4-000e7bbb2b09")
interface IX509AttributeOSVersion : IX509Attribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeosversion-initializeencode
    HRESULT InitializeEncode(BSTR strOSVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeosversion-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributeosversion-get_osversion
    HRESULT get_OSVersion(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509attributecspprovider
@GUID("728ab32b-217d-11da-b2a4-000e7bbb2b09")
interface IX509AttributeCspProvider : IX509Attribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributecspprovider-initializeencode
    HRESULT InitializeEncode(X509KeySpec KeySpec, BSTR strProviderName, EncodingType Encoding, BSTR strSignature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributecspprovider-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributecspprovider-get_keyspec
    HRESULT get_KeySpec(X509KeySpec* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributecspprovider-get_providername
    HRESULT get_ProviderName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509attributecspprovider-get_signature
    HRESULT get_Signature(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icryptattribute
@GUID("728ab32c-217d-11da-b2a4-000e7bbb2b09")
interface ICryptAttribute : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattribute-initializefromobjectid
    HRESULT InitializeFromObjectId(IObjectId pObjectId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattribute-initializefromvalues
    HRESULT InitializeFromValues(IX509Attributes pAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattribute-get_objectid
    HRESULT get_ObjectId(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattribute-get_values
    HRESULT get_Values(IX509Attributes* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icryptattributes
@GUID("728ab32d-217d-11da-b2a4-000e7bbb2b09")
interface ICryptAttributes : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattributes-get_itembyindex
    HRESULT get_ItemByIndex(int Index, ICryptAttribute* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattributes-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattributes-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattributes-add
    HRESULT Add(ICryptAttribute pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattributes-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattributes-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattributes-get_indexbyobjectid
    HRESULT get_IndexByObjectId(IObjectId pObjectId, int* pIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icryptattributes-addrange
    HRESULT AddRange(ICryptAttributes pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertproperty
@GUID("728ab32e-217d-11da-b2a4-000e7bbb2b09")
interface ICertProperty : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperty-initializefromcertificate
    HRESULT InitializeFromCertificate(VARIANT_BOOL MachineContext, EncodingType Encoding, BSTR strCertificate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperty-initializedecode
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperty-get_propertyid
    HRESULT get_PropertyId(CERTENROLL_PROPERTYID* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperty-put_propertyid
    HRESULT put_PropertyId(CERTENROLL_PROPERTYID Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperty-get_rawdata
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperty-removefromcertificate
    HRESULT RemoveFromCertificate(VARIANT_BOOL MachineContext, EncodingType Encoding, BSTR strCertificate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperty-setvalueoncertificate
    HRESULT SetValueOnCertificate(VARIANT_BOOL MachineContext, EncodingType Encoding, BSTR strCertificate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertproperties
@GUID("728ab32f-217d-11da-b2a4-000e7bbb2b09")
interface ICertProperties : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperties-get_itembyindex
    HRESULT get_ItemByIndex(int Index, ICertProperty* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperties-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperties-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperties-add
    HRESULT Add(ICertProperty pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperties-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperties-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertproperties-initializefromcertificate
    HRESULT InitializeFromCertificate(VARIANT_BOOL MachineContext, EncodingType Encoding, BSTR strCertificate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertyfriendlyname
@GUID("728ab330-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyFriendlyName : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyfriendlyname-initialize
    HRESULT Initialize(BSTR strFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyfriendlyname-get_friendlyname
    HRESULT get_FriendlyName(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertydescription
@GUID("728ab331-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyDescription : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertydescription-initialize
    HRESULT Initialize(BSTR strDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertydescription-get_description
    HRESULT get_Description(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertyautoenroll
@GUID("728ab332-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyAutoEnroll : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyautoenroll-initialize
    HRESULT Initialize(BSTR strTemplateName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyautoenroll-get_templatename
    HRESULT get_TemplateName(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertyrequestoriginator
@GUID("728ab333-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyRequestOriginator : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyrequestoriginator-initialize
    HRESULT Initialize(BSTR strRequestOriginator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyrequestoriginator-initializefromlocalrequestoriginator
    HRESULT InitializeFromLocalRequestOriginator();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyrequestoriginator-get_requestoriginator
    HRESULT get_RequestOriginator(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertysha1hash
@GUID("728ab334-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertySHA1Hash : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertysha1hash-initialize
    HRESULT Initialize(EncodingType Encoding, BSTR strRenewalValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertysha1hash-get_sha1hash
    HRESULT get_SHA1Hash(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertykeyprovinfo
@GUID("728ab336-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyKeyProvInfo : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertykeyprovinfo-initialize
    HRESULT Initialize(IX509PrivateKey pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertykeyprovinfo-get_privatekey
    HRESULT get_PrivateKey(IX509PrivateKey* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertyarchived
@GUID("728ab337-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyArchived : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyarchived-initialize
    HRESULT Initialize(VARIANT_BOOL ArchivedValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyarchived-get_archived
    HRESULT get_Archived(VARIANT_BOOL* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertybackedup
@GUID("728ab338-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyBackedUp : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertybackedup-initializefromcurrenttime
    HRESULT InitializeFromCurrentTime(VARIANT_BOOL BackedUpValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertybackedup-initialize
    HRESULT Initialize(VARIANT_BOOL BackedUpValue, double Date);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertybackedup-get_backedupvalue
    HRESULT get_BackedUpValue(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertybackedup-get_backeduptime
    HRESULT get_BackedUpTime(double* pDate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertyenrollment
@GUID("728ab339-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyEnrollment : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollment-initialize
    HRESULT Initialize(int RequestId, BSTR strCADnsName, BSTR strCAName, BSTR strFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollment-get_requestid
    HRESULT get_RequestId(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollment-get_cadnsname
    HRESULT get_CADnsName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollment-get_caname
    HRESULT get_CAName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollment-get_friendlyname
    HRESULT get_FriendlyName(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertyrenewal
@GUID("728ab33a-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyRenewal : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyrenewal-initialize
    HRESULT Initialize(EncodingType Encoding, BSTR strRenewalValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyrenewal-initializefromcertificatehash
    HRESULT InitializeFromCertificateHash(VARIANT_BOOL MachineContext, EncodingType Encoding, BSTR strCertificate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyrenewal-get_renewal
    HRESULT get_Renewal(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertyarchivedkeyhash
@GUID("728ab33b-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyArchivedKeyHash : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyarchivedkeyhash-initialize
    HRESULT Initialize(EncodingType Encoding, BSTR strArchivedKeyHashValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyarchivedkeyhash-get_archivedkeyhash
    HRESULT get_ArchivedKeyHash(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertpropertyenrollmentpolicyserver
@GUID("728ab34a-217d-11da-b2a4-000e7bbb2b09")
interface ICertPropertyEnrollmentPolicyServer : ICertProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollmentpolicyserver-initialize
    HRESULT Initialize(EnrollmentPolicyServerPropertyFlags PropertyFlags, X509EnrollmentAuthFlags AuthFlags, 
                       X509EnrollmentAuthFlags EnrollmentServerAuthFlags, PolicyServerUrlFlags UrlFlags, 
                       BSTR strRequestId, BSTR strUrl, BSTR strId, BSTR strEnrollmentServerUrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollmentpolicyserver-getpolicyserverurl
    HRESULT GetPolicyServerUrl(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollmentpolicyserver-getpolicyserverid
    HRESULT GetPolicyServerId(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollmentpolicyserver-getenrollmentserverurl
    HRESULT GetEnrollmentServerUrl(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollmentpolicyserver-getrequestidstring
    HRESULT GetRequestIdString(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollmentpolicyserver-getpropertyflags
    HRESULT GetPropertyFlags(EnrollmentPolicyServerPropertyFlags* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollmentpolicyserver-geturlflags
    HRESULT GetUrlFlags(PolicyServerUrlFlags* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollmentpolicyserver-getauthentication
    HRESULT GetAuthentication(X509EnrollmentAuthFlags* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertpropertyenrollmentpolicyserver-getenrollmentserverauthentication
    HRESULT GetEnrollmentServerAuthentication(X509EnrollmentAuthFlags* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509signatureinformation
@GUID("728ab33c-217d-11da-b2a4-000e7bbb2b09")
interface IX509SignatureInformation : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-get_hashalgorithm
    HRESULT get_HashAlgorithm(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-put_hashalgorithm
    HRESULT put_HashAlgorithm(IObjectId pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-get_publickeyalgorithm
    HRESULT get_PublicKeyAlgorithm(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-put_publickeyalgorithm
    HRESULT put_PublicKeyAlgorithm(IObjectId pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-get_parameters
    HRESULT get_Parameters(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-put_parameters
    HRESULT put_Parameters(EncodingType Encoding, BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-get_alternatesignaturealgorithm
    HRESULT get_AlternateSignatureAlgorithm(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-put_alternatesignaturealgorithm
    HRESULT put_AlternateSignatureAlgorithm(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-get_alternatesignaturealgorithmset
    HRESULT get_AlternateSignatureAlgorithmSet(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-get_nullsigned
    HRESULT get_NullSigned(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-put_nullsigned
    HRESULT put_NullSigned(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-getsignaturealgorithm
    HRESULT GetSignatureAlgorithm(VARIANT_BOOL Pkcs7Signature, VARIANT_BOOL SignatureKey, IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509signatureinformation-setdefaultvalues
    HRESULT SetDefaultValues();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-isignercertificate
@GUID("728ab33d-217d-11da-b2a4-000e7bbb2b09")
interface ISignerCertificate : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-initialize
    HRESULT Initialize(VARIANT_BOOL MachineContext, X509PrivateKeyVerify VerifyType, EncodingType Encoding, 
                       BSTR strCertificate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-get_certificate
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-get_privatekey
    HRESULT get_PrivateKey(IX509PrivateKey* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-get_silent
    HRESULT get_Silent(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-put_silent
    HRESULT put_Silent(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-get_parentwindow
    HRESULT get_ParentWindow(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-put_parentwindow
    HRESULT put_ParentWindow(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-get_uicontextmessage
    HRESULT get_UIContextMessage(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-put_uicontextmessage
    HRESULT put_UIContextMessage(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-put_pin
    HRESULT put_Pin(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificate-get_signatureinformation
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-isignercertificates
@GUID("728ab33e-217d-11da-b2a4-000e7bbb2b09")
interface ISignerCertificates : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificates-get_itembyindex
    HRESULT get_ItemByIndex(int Index, ISignerCertificate* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificates-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificates-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificates-add
    HRESULT Add(ISignerCertificate pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificates-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificates-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-isignercertificates-find
    HRESULT Find(ISignerCertificate pSignerCert, int* piSignerCert);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509namevaluepair
@GUID("728ab33f-217d-11da-b2a4-000e7bbb2b09")
interface IX509NameValuePair : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509namevaluepair-initialize
    HRESULT Initialize(BSTR strName, BSTR strValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509namevaluepair-get_value
    HRESULT get_Value(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509namevaluepair-get_name
    HRESULT get_Name(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509namevaluepairs
@GUID("728ab340-217d-11da-b2a4-000e7bbb2b09")
interface IX509NameValuePairs : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509namevaluepairs-get_itembyindex
    HRESULT get_ItemByIndex(int Index, IX509NameValuePair* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509namevaluepairs-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509namevaluepairs-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509namevaluepairs-add
    HRESULT Add(IX509NameValuePair pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509namevaluepairs-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509namevaluepairs-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificatetemplate
@GUID("54244a13-555a-4e22-896d-1b0e52f76406")
interface IX509CertificateTemplate : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplate-get_property
    HRESULT get_Property(EnrollmentTemplateProperty property, VARIANT* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificatetemplates
@GUID("13b79003-2181-11da-b2a4-000e7bbb2b09")
interface IX509CertificateTemplates : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplates-get_itembyindex
    HRESULT get_ItemByIndex(int Index, IX509CertificateTemplate* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplates-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplates-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplates-add
    HRESULT Add(IX509CertificateTemplate pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplates-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplates-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplates-get_itembyname
    HRESULT get_ItemByName(BSTR bstrName, IX509CertificateTemplate* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplates-get_itembyoid
    HRESULT get_ItemByOid(IObjectId pOid, IX509CertificateTemplate* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificatetemplatewritable
@GUID("f49466a7-395a-4e9e-b6e7-32b331600dc0")
interface IX509CertificateTemplateWritable : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplatewritable-initialize
    HRESULT Initialize(IX509CertificateTemplate pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplatewritable-commit
    HRESULT Commit(CommitTemplateFlags commitFlags, BSTR strServerContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplatewritable-get_property
    HRESULT get_Property(EnrollmentTemplateProperty property, VARIANT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplatewritable-put_property
    HRESULT put_Property(EnrollmentTemplateProperty property, VARIANT value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificatetemplatewritable-get_template
    HRESULT get_Template(IX509CertificateTemplate* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertificationauthority
@GUID("835d1f61-1e95-4bc8-b4d3-976c42b968f7")
interface ICertificationAuthority : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificationauthority-get_property
    HRESULT get_Property(EnrollmentCAProperty property, VARIANT* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertificationauthorities
@GUID("13b79005-2181-11da-b2a4-000e7bbb2b09")
interface ICertificationAuthorities : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificationauthorities-get_itembyindex
    HRESULT get_ItemByIndex(int Index, ICertificationAuthority* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificationauthorities-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificationauthorities-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificationauthorities-add
    HRESULT Add(ICertificationAuthority pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificationauthorities-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificationauthorities-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificationauthorities-computesitecosts
    HRESULT ComputeSiteCosts();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificationauthorities-get_itembyname
    HRESULT get_ItemByName(BSTR strName, ICertificationAuthority* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509enrollmentpolicyserver
@GUID("13b79026-2181-11da-b2a4-000e7bbb2b09")
interface IX509EnrollmentPolicyServer : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-initialize
    HRESULT Initialize(BSTR bstrPolicyServerUrl, BSTR bstrPolicyServerId, X509EnrollmentAuthFlags authFlags, 
                       VARIANT_BOOL fIsUnTrusted, X509CertificateEnrollmentContext context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-loadpolicy
    HRESULT LoadPolicy(X509EnrollmentPolicyLoadOption option);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-gettemplates
    HRESULT GetTemplates(IX509CertificateTemplates* pTemplates);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getcasfortemplate
    HRESULT GetCAsForTemplate(IX509CertificateTemplate pTemplate, ICertificationAuthorities* ppCAs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getcas
    HRESULT GetCAs(ICertificationAuthorities* ppCAs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-validate
    HRESULT Validate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getcustomoids
    HRESULT GetCustomOids(IObjectIds* ppObjectIds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getnextupdatetime
    HRESULT GetNextUpdateTime(double* pDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getlastupdatetime
    HRESULT GetLastUpdateTime(double* pDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getpolicyserverurl
    HRESULT GetPolicyServerUrl(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getpolicyserverid
    HRESULT GetPolicyServerId(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getfriendlyname
    HRESULT GetFriendlyName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getisdefaultcep
    HRESULT GetIsDefaultCEP(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getuseclientid
    HRESULT GetUseClientId(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getallowuntrustedca
    HRESULT GetAllowUnTrustedCA(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getcachepath
    HRESULT GetCachePath(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getcachedir
    HRESULT GetCacheDir(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-getauthflags
    HRESULT GetAuthFlags(X509EnrollmentAuthFlags* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-setcredential
    HRESULT SetCredential(int hWndParent, X509EnrollmentAuthFlags flag, BSTR strCredential, BSTR strPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-querychanges
    HRESULT QueryChanges(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-initializeimport
    HRESULT InitializeImport(VARIANT val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-export
    HRESULT Export(X509EnrollmentPolicyExportFlags exportFlags, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-get_cost
    HRESULT get_Cost(uint* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentpolicyserver-put_cost
    HRESULT put_Cost(uint value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509policyserverurl
@GUID("884e204a-217d-11da-b2a4-000e7bbb2b09")
interface IX509PolicyServerUrl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-initialize
    HRESULT Initialize(X509CertificateEnrollmentContext context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-get_url
    HRESULT get_Url(BSTR* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-put_url
    HRESULT put_Url(BSTR pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-get_default
    HRESULT get_Default(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-put_default
    HRESULT put_Default(VARIANT_BOOL value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-get_flags
    HRESULT get_Flags(PolicyServerUrlFlags* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-put_flags
    HRESULT put_Flags(PolicyServerUrlFlags Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-get_authflags
    HRESULT get_AuthFlags(X509EnrollmentAuthFlags* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-put_authflags
    HRESULT put_AuthFlags(X509EnrollmentAuthFlags Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-get_cost
    HRESULT get_Cost(uint* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-put_cost
    HRESULT put_Cost(uint value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-getstringproperty
    HRESULT GetStringProperty(PolicyServerUrlPropertyID propertyId, BSTR* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-setstringproperty
    HRESULT SetStringProperty(PolicyServerUrlPropertyID propertyId, BSTR pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-updateregistry
    HRESULT UpdateRegistry(X509CertificateEnrollmentContext context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverurl-removefromregistry
    HRESULT RemoveFromRegistry(X509CertificateEnrollmentContext context);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509policyserverlistmanager
@GUID("884e204b-217d-11da-b2a4-000e7bbb2b09")
interface IX509PolicyServerListManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverlistmanager-get_itembyindex
    HRESULT get_ItemByIndex(int Index, IX509PolicyServerUrl* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverlistmanager-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverlistmanager-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverlistmanager-add
    HRESULT Add(IX509PolicyServerUrl pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverlistmanager-remove
    HRESULT Remove(int Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverlistmanager-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509policyserverlistmanager-initialize
    HRESULT Initialize(X509CertificateEnrollmentContext context, PolicyServerUrlFlags Flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificaterequest
@GUID("728ab341-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRequest : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-initialize
    HRESULT Initialize(X509CertificateEnrollmentContext Context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-encode
    HRESULT Encode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-resetforencode
    HRESULT ResetForEncode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-getinnerrequest
    HRESULT GetInnerRequest(InnerRequestLevel Level, IX509CertificateRequest* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_type
    HRESULT get_Type(X509RequestType* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_enrollmentcontext
    HRESULT get_EnrollmentContext(X509CertificateEnrollmentContext* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_silent
    HRESULT get_Silent(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-put_silent
    HRESULT put_Silent(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_parentwindow
    HRESULT get_ParentWindow(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-put_parentwindow
    HRESULT put_ParentWindow(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_uicontextmessage
    HRESULT get_UIContextMessage(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-put_uicontextmessage
    HRESULT put_UIContextMessage(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_suppressdefaults
    HRESULT get_SuppressDefaults(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-put_suppressdefaults
    HRESULT put_SuppressDefaults(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_renewalcertificate
    HRESULT get_RenewalCertificate(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-put_renewalcertificate
    HRESULT put_RenewalCertificate(EncodingType Encoding, BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_clientid
    HRESULT get_ClientId(RequestClientInfoClientId* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-put_clientid
    HRESULT put_ClientId(RequestClientInfoClientId Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_cspinformations
    HRESULT get_CspInformations(ICspInformations* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-put_cspinformations
    HRESULT put_CspInformations(ICspInformations pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_hashalgorithm
    HRESULT get_HashAlgorithm(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-put_hashalgorithm
    HRESULT put_HashAlgorithm(IObjectId pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_alternatesignaturealgorithm
    HRESULT get_AlternateSignatureAlgorithm(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-put_alternatesignaturealgorithm
    HRESULT put_AlternateSignatureAlgorithm(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequest-get_rawdata
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificaterequestpkcs10
@GUID("728ab342-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRequestPkcs10 : IX509CertificateRequest
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-initializefromtemplatename
    HRESULT InitializeFromTemplateName(X509CertificateEnrollmentContext Context, BSTR strTemplateName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-initializefromprivatekey
    HRESULT InitializeFromPrivateKey(X509CertificateEnrollmentContext Context, IX509PrivateKey pPrivateKey, 
                                     BSTR strTemplateName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-initializefrompublickey
    HRESULT InitializeFromPublicKey(X509CertificateEnrollmentContext Context, IX509PublicKey pPublicKey, 
                                    BSTR strTemplateName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-initializefromcertificate
    HRESULT InitializeFromCertificate(X509CertificateEnrollmentContext Context, BSTR strCertificate, 
                                      EncodingType Encoding, X509RequestInheritOptions InheritOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-initializedecode
    HRESULT InitializeDecode(BSTR strEncodedData, EncodingType Encoding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-checksignature
    HRESULT CheckSignature(Pkcs10AllowedSignatureTypes AllowedSignatureTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-issmartcard
    HRESULT IsSmartCard(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_templateobjectid
    HRESULT get_TemplateObjectId(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_publickey
    HRESULT get_PublicKey(IX509PublicKey* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_privatekey
    HRESULT get_PrivateKey(IX509PrivateKey* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_nullsigned
    HRESULT get_NullSigned(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_reusekey
    HRESULT get_ReuseKey(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_oldcertificate
    HRESULT get_OldCertificate(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_subject
    HRESULT get_Subject(IX500DistinguishedName* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-put_subject
    HRESULT put_Subject(IX500DistinguishedName pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_cspstatuses
    HRESULT get_CspStatuses(ICspStatuses* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_smimecapabilities
    HRESULT get_SmimeCapabilities(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-put_smimecapabilities
    HRESULT put_SmimeCapabilities(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_signatureinformation
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_keycontainernameprefix
    HRESULT get_KeyContainerNamePrefix(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-put_keycontainernameprefix
    HRESULT put_KeyContainerNamePrefix(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_cryptattributes
    HRESULT get_CryptAttributes(ICryptAttributes* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_x509extensions
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_criticalextensions
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_suppressoids
    HRESULT get_SuppressOids(IObjectIds* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_rawdatatobesigned
    HRESULT get_RawDataToBeSigned(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-get_signature
    HRESULT get_Signature(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10-getcspstatuses
    HRESULT GetCspStatuses(X509KeySpec KeySpec, ICspStatuses* ppCspStatuses);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificaterequestpkcs10v2
@GUID("728ab35b-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRequestPkcs10V2 : IX509CertificateRequestPkcs10
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v2-initializefromtemplate
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, 
                                   IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v2-initializefromprivatekeytemplate
    HRESULT InitializeFromPrivateKeyTemplate(X509CertificateEnrollmentContext Context, IX509PrivateKey pPrivateKey, 
                                             IX509EnrollmentPolicyServer pPolicyServer, 
                                             IX509CertificateTemplate pTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v2-initializefrompublickeytemplate
    HRESULT InitializeFromPublicKeyTemplate(X509CertificateEnrollmentContext Context, IX509PublicKey pPublicKey, 
                                            IX509EnrollmentPolicyServer pPolicyServer, 
                                            IX509CertificateTemplate pTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v2-get_policyserver
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v2-get_template
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificaterequestpkcs10v3
@GUID("54ea9942-3d66-4530-b76e-7c9170d3ec52")
interface IX509CertificateRequestPkcs10V3 : IX509CertificateRequestPkcs10V2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-get_attestprivatekey
    HRESULT get_AttestPrivateKey(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-put_attestprivatekey
    HRESULT put_AttestPrivateKey(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-get_attestationencryptioncertificate
    HRESULT get_AttestationEncryptionCertificate(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-put_attestationencryptioncertificate
    HRESULT put_AttestationEncryptionCertificate(EncodingType Encoding, BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-get_encryptionalgorithm
    HRESULT get_EncryptionAlgorithm(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-put_encryptionalgorithm
    HRESULT put_EncryptionAlgorithm(IObjectId pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-get_encryptionstrength
    HRESULT get_EncryptionStrength(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-put_encryptionstrength
    HRESULT put_EncryptionStrength(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-get_challengepassword
    HRESULT get_ChallengePassword(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-put_challengepassword
    HRESULT put_ChallengePassword(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs10v3-get_namevaluepairs
    HRESULT get_NameValuePairs(IX509NameValuePairs* ppValue);
}

@GUID("728ab363-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRequestPkcs10V4 : IX509CertificateRequestPkcs10V3
{
    HRESULT get_ClaimType(KeyAttestationClaimType* pValue);
    HRESULT put_ClaimType(KeyAttestationClaimType Value);
    HRESULT get_AttestPrivateKeyPreferred(VARIANT_BOOL* pValue);
    HRESULT put_AttestPrivateKeyPreferred(VARIANT_BOOL Value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificaterequestcertificate
@GUID("728ab343-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRequestCertificate : IX509CertificateRequestPkcs10
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-checkpublickeysignature
    HRESULT CheckPublicKeySignature(IX509PublicKey pPublicKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-get_issuer
    HRESULT get_Issuer(IX500DistinguishedName* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-put_issuer
    HRESULT put_Issuer(IX500DistinguishedName pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-get_notbefore
    HRESULT get_NotBefore(double* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-put_notbefore
    HRESULT put_NotBefore(double Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-get_notafter
    HRESULT get_NotAfter(double* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-put_notafter
    HRESULT put_NotAfter(double Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-get_serialnumber
    HRESULT get_SerialNumber(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-put_serialnumber
    HRESULT put_SerialNumber(EncodingType Encoding, BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-get_signercertificate
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate-put_signercertificate
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificaterequestcertificate2
@GUID("728ab35a-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRequestCertificate2 : IX509CertificateRequestCertificate
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate2-initializefromtemplate
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, 
                                   IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate2-initializefromprivatekeytemplate
    HRESULT InitializeFromPrivateKeyTemplate(X509CertificateEnrollmentContext Context, IX509PrivateKey pPrivateKey, 
                                             IX509EnrollmentPolicyServer pPolicyServer, 
                                             IX509CertificateTemplate pTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate2-get_policyserver
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcertificate2-get_template
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificaterequestpkcs7
@GUID("728ab344-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRequestPkcs7 : IX509CertificateRequest
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7-initializefromtemplatename
    HRESULT InitializeFromTemplateName(X509CertificateEnrollmentContext Context, BSTR strTemplateName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7-initializefromcertificate
    HRESULT InitializeFromCertificate(X509CertificateEnrollmentContext Context, VARIANT_BOOL RenewalRequest, 
                                      BSTR strCertificate, EncodingType Encoding, 
                                      X509RequestInheritOptions InheritOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7-initializefrominnerrequest
    HRESULT InitializeFromInnerRequest(IX509CertificateRequest pInnerRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7-initializedecode
    HRESULT InitializeDecode(BSTR strEncodedData, EncodingType Encoding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7-get_requestername
    HRESULT get_RequesterName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7-put_requestername
    HRESULT put_RequesterName(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7-get_signercertificate
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7-put_signercertificate
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificaterequestpkcs7v2
@GUID("728ab35c-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRequestPkcs7V2 : IX509CertificateRequestPkcs7
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7v2-initializefromtemplate
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, 
                                   IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7v2-get_policyserver
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7v2-get_template
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestpkcs7v2-checkcertificatesignature
    HRESULT CheckCertificateSignature(VARIANT_BOOL ValidateCertificateChain);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificaterequestcmc
@GUID("728ab345-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRequestCmc : IX509CertificateRequestPkcs7
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-initializefrominnerrequesttemplatename
    HRESULT InitializeFromInnerRequestTemplateName(IX509CertificateRequest pInnerRequest, BSTR strTemplateName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_templateobjectid
    HRESULT get_TemplateObjectId(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_nullsigned
    HRESULT get_NullSigned(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_cryptattributes
    HRESULT get_CryptAttributes(ICryptAttributes* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_namevaluepairs
    HRESULT get_NameValuePairs(IX509NameValuePairs* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_x509extensions
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_criticalextensions
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_suppressoids
    HRESULT get_SuppressOids(IObjectIds* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_transactionid
    HRESULT get_TransactionId(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-put_transactionid
    HRESULT put_TransactionId(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_sendernonce
    HRESULT get_SenderNonce(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-put_sendernonce
    HRESULT put_SenderNonce(EncodingType Encoding, BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_signatureinformation
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_archiveprivatekey
    HRESULT get_ArchivePrivateKey(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-put_archiveprivatekey
    HRESULT put_ArchivePrivateKey(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_keyarchivalcertificate
    HRESULT get_KeyArchivalCertificate(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-put_keyarchivalcertificate
    HRESULT put_KeyArchivalCertificate(EncodingType Encoding, BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_encryptionalgorithm
    HRESULT get_EncryptionAlgorithm(IObjectId* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-put_encryptionalgorithm
    HRESULT put_EncryptionAlgorithm(IObjectId pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_encryptionstrength
    HRESULT get_EncryptionStrength(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-put_encryptionstrength
    HRESULT put_EncryptionStrength(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_encryptedkeyhash
    HRESULT get_EncryptedKeyHash(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc-get_signercertificates
    HRESULT get_SignerCertificates(ISignerCertificates* ppValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509certificaterequestcmc2
@GUID("728ab35d-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRequestCmc2 : IX509CertificateRequestCmc
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc2-initializefromtemplate
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, 
                                   IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc2-initializefrominnerrequesttemplate
    HRESULT InitializeFromInnerRequestTemplate(IX509CertificateRequest pInnerRequest, 
                                               IX509EnrollmentPolicyServer pPolicyServer, 
                                               IX509CertificateTemplate pTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc2-get_policyserver
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc2-get_template
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc2-checksignature
    HRESULT CheckSignature(Pkcs10AllowedSignatureTypes AllowedSignatureTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509certificaterequestcmc2-checkcertificatesignature
    HRESULT CheckCertificateSignature(ISignerCertificate pSignerCertificate, VARIANT_BOOL ValidateCertificateChain);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509enrollment
@GUID("728ab346-217d-11da-b2a4-000e7bbb2b09")
interface IX509Enrollment : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-initialize
    HRESULT Initialize(X509CertificateEnrollmentContext Context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-initializefromtemplatename
    HRESULT InitializeFromTemplateName(X509CertificateEnrollmentContext Context, BSTR strTemplateName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-initializefromrequest
    HRESULT InitializeFromRequest(IX509CertificateRequest pRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-createrequest
    HRESULT CreateRequest(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-enroll
    HRESULT Enroll();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-installresponse
    HRESULT InstallResponse(InstallResponseRestrictionFlags Restrictions, BSTR strResponse, EncodingType Encoding, 
                            BSTR strPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-createpfx
    HRESULT CreatePFX(BSTR strPassword, PFXExportOptions ExportOptions, EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_request
    HRESULT get_Request(IX509CertificateRequest* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_silent
    HRESULT get_Silent(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-put_silent
    HRESULT put_Silent(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_parentwindow
    HRESULT get_ParentWindow(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-put_parentwindow
    HRESULT put_ParentWindow(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_namevaluepairs
    HRESULT get_NameValuePairs(IX509NameValuePairs* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_enrollmentcontext
    HRESULT get_EnrollmentContext(X509CertificateEnrollmentContext* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_status
    HRESULT get_Status(IX509EnrollmentStatus* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_certificate
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_response
    HRESULT get_Response(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_certificatefriendlyname
    HRESULT get_CertificateFriendlyName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-put_certificatefriendlyname
    HRESULT put_CertificateFriendlyName(BSTR strValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_certificatedescription
    HRESULT get_CertificateDescription(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-put_certificatedescription
    HRESULT put_CertificateDescription(BSTR strValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_requestid
    HRESULT get_RequestId(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-get_caconfigstring
    HRESULT get_CAConfigString(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509enrollment2
@GUID("728ab350-217d-11da-b2a4-000e7bbb2b09")
interface IX509Enrollment2 : IX509Enrollment
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment2-initializefromtemplate
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, 
                                   IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment2-installresponse2
    HRESULT InstallResponse2(InstallResponseRestrictionFlags Restrictions, BSTR strResponse, EncodingType Encoding, 
                             BSTR strPassword, BSTR strEnrollmentPolicyServerUrl, BSTR strEnrollmentPolicyServerID, 
                             PolicyServerUrlFlags EnrollmentPolicyServerFlags, X509EnrollmentAuthFlags authFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment2-get_policyserver
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment2-get_template
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollment2-get_requestidstring
    HRESULT get_RequestIdString(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509enrollmenthelper
@GUID("728ab351-217d-11da-b2a4-000e7bbb2b09")
interface IX509EnrollmentHelper : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmenthelper-addpolicyserver
    HRESULT AddPolicyServer(BSTR strEnrollmentPolicyServerURI, BSTR strEnrollmentPolicyID, 
                            PolicyServerUrlFlags EnrollmentPolicyServerFlags, X509EnrollmentAuthFlags authFlags, 
                            BSTR strCredential, BSTR strPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmenthelper-addenrollmentserver
    HRESULT AddEnrollmentServer(BSTR strEnrollmentServerURI, X509EnrollmentAuthFlags authFlags, BSTR strCredential, 
                                BSTR strPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmenthelper-enroll
    HRESULT Enroll(BSTR strEnrollmentPolicyServerURI, BSTR strTemplateName, EncodingType Encoding, 
                   WebEnrollmentFlags enrollFlags, BSTR* pstrCertificate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmenthelper-initialize
    HRESULT Initialize(X509CertificateEnrollmentContext Context);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509enrollmentwebclassfactory
@GUID("728ab349-217d-11da-b2a4-000e7bbb2b09")
interface IX509EnrollmentWebClassFactory : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509enrollmentwebclassfactory-createobject
    HRESULT CreateObject(BSTR strProgID, IUnknown* ppIUnknown);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509machineenrollmentfactory
@GUID("728ab352-217d-11da-b2a4-000e7bbb2b09")
interface IX509MachineEnrollmentFactory : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509machineenrollmentfactory-createobject
    HRESULT CreateObject(BSTR strProgID, IX509EnrollmentHelper* ppIHelper);
}

@GUID("728ab35e-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRevocationListEntry : IDispatch
{
    HRESULT Initialize(EncodingType Encoding, BSTR SerialNumber, double RevocationDate);
    HRESULT get_SerialNumber(EncodingType Encoding, BSTR* pValue);
    HRESULT get_RevocationDate(double* pValue);
    HRESULT get_RevocationReason(CRLRevocationReason* pValue);
    HRESULT put_RevocationReason(CRLRevocationReason Value);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
}

@GUID("728ab35f-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRevocationListEntries : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509CertificateRevocationListEntry* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509CertificateRevocationListEntry pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_IndexBySerialNumber(EncodingType Encoding, BSTR SerialNumber, int* pIndex);
    HRESULT AddRange(IX509CertificateRevocationListEntries pValue);
}

@GUID("728ab360-217d-11da-b2a4-000e7bbb2b09")
interface IX509CertificateRevocationList : IDispatch
{
    HRESULT Initialize();
    HRESULT InitializeDecode(BSTR strEncodedData, EncodingType Encoding);
    HRESULT Encode();
    HRESULT ResetForEncode();
    HRESULT CheckPublicKeySignature(IX509PublicKey pPublicKey);
    HRESULT CheckSignature();
    HRESULT get_Issuer(IX500DistinguishedName* ppValue);
    HRESULT put_Issuer(IX500DistinguishedName pValue);
    HRESULT get_ThisUpdate(double* pValue);
    HRESULT put_ThisUpdate(double Value);
    HRESULT get_NextUpdate(double* pValue);
    HRESULT put_NextUpdate(double Value);
    HRESULT get_X509CRLEntries(IX509CertificateRevocationListEntries* ppValue);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
    HRESULT get_CRLNumber(EncodingType Encoding, BSTR* pValue);
    HRESULT put_CRLNumber(EncodingType Encoding, BSTR Value);
    HRESULT get_CAVersion(int* pValue);
    HRESULT put_CAVersion(int pValue);
    HRESULT get_BaseCRL(VARIANT_BOOL* pValue);
    HRESULT get_NullSigned(VARIANT_BOOL* pValue);
    HRESULT get_HashAlgorithm(IObjectId* ppValue);
    HRESULT put_HashAlgorithm(IObjectId pValue);
    HRESULT get_AlternateSignatureAlgorithm(VARIANT_BOOL* pValue);
    HRESULT put_AlternateSignatureAlgorithm(VARIANT_BOOL Value);
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
    HRESULT get_RawDataToBeSigned(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Signature(EncodingType Encoding, BSTR* pValue);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-icertificateattestationchallenge
@GUID("6f175a7c-4a3a-40ae-9dba-592fd6bbf9b8")
interface ICertificateAttestationChallenge : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificateattestationchallenge-initialize
    HRESULT Initialize(EncodingType Encoding, BSTR strPendingFullCmcResponseWithChallenge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificateattestationchallenge-decryptchallenge
    HRESULT DecryptChallenge(EncodingType Encoding, BSTR* pstrEnvelopedPkcs7ReencryptedToCA);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-icertificateattestationchallenge-get_requestid
    HRESULT get_RequestID(BSTR* pstrRequestID);
}

@GUID("4631334d-e266-47d6-bd79-be53cb2e2753")
interface ICertificateAttestationChallenge2 : ICertificateAttestationChallenge
{
    HRESULT put_KeyContainerName(BSTR Value);
    HRESULT put_KeyBlob(EncodingType Encoding, BSTR Value);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nn-certenroll-ix509scepenrollment
@GUID("728ab361-217d-11da-b2a4-000e7bbb2b09")
interface IX509SCEPEnrollment : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-initialize
    HRESULT Initialize(IX509CertificateRequestPkcs10 pRequest, BSTR strThumbprint, EncodingType ThumprintEncoding, 
                       BSTR strServerCertificates, EncodingType Encoding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-initializeforpending
    HRESULT InitializeForPending(X509CertificateEnrollmentContext Context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-createrequestmessage
    HRESULT CreateRequestMessage(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-createretrievependingmessage
    HRESULT CreateRetrievePendingMessage(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-createretrievecertificatemessage
    HRESULT CreateRetrieveCertificateMessage(X509CertificateEnrollmentContext Context, BSTR strIssuer, 
                                             EncodingType IssuerEncoding, BSTR strSerialNumber, 
                                             EncodingType SerialNumberEncoding, EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-processresponsemessage
    HRESULT ProcessResponseMessage(BSTR strResponse, EncodingType Encoding, X509SCEPDisposition* pDisposition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-put_servercapabilities
    HRESULT put_ServerCapabilities(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-get_failinfo
    HRESULT get_FailInfo(X509SCEPFailInfo* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-get_signercertificate
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-put_signercertificate
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-get_oldcertificate
    HRESULT get_OldCertificate(ISignerCertificate* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-put_oldcertificate
    HRESULT put_OldCertificate(ISignerCertificate pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-get_transactionid
    HRESULT get_TransactionId(EncodingType Encoding, BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-put_transactionid
    HRESULT put_TransactionId(EncodingType Encoding, BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-get_request
    HRESULT get_Request(IX509CertificateRequestPkcs10* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-get_certificatefriendlyname
    HRESULT get_CertificateFriendlyName(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-put_certificatefriendlyname
    HRESULT put_CertificateFriendlyName(BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-get_status
    HRESULT get_Status(IX509EnrollmentStatus* ppValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-get_certificate
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Silent(VARIANT_BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-put_silent
    HRESULT put_Silent(VARIANT_BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenroll/nf-certenroll-ix509scepenrollment-deleterequest
    HRESULT DeleteRequest();
}

@GUID("728ab364-217d-11da-b2a4-000e7bbb2b09")
interface IX509SCEPEnrollment2 : IX509SCEPEnrollment
{
    HRESULT CreateChallengeAnswerMessage(EncodingType Encoding, BSTR* pValue);
    HRESULT ProcessResponseMessage2(X509SCEPProcessMessageFlags Flags, BSTR strResponse, EncodingType Encoding, 
                                    X509SCEPDisposition* pDisposition);
    HRESULT get_ResultMessageText(BSTR* pValue);
    HRESULT get_DelayRetry(DelayRetryAction* pValue);
    HRESULT get_ActivityId(BSTR* pValue);
    HRESULT put_ActivityId(BSTR Value);
}

@GUID("728ab365-217d-11da-b2a4-000e7bbb2b09")
interface IX509SCEPEnrollmentHelper : IDispatch
{
    HRESULT Initialize(BSTR strServerUrl, BSTR strRequestHeaders, IX509CertificateRequestPkcs10 pRequest, 
                       BSTR strCACertificateThumbprint);
    HRESULT InitializeForPending(BSTR strServerUrl, BSTR strRequestHeaders, 
                                 X509CertificateEnrollmentContext Context, BSTR strTransactionId);
    HRESULT Enroll(X509SCEPProcessMessageFlags ProcessFlags, X509SCEPDisposition* pDisposition);
    HRESULT FetchPending(X509SCEPProcessMessageFlags ProcessFlags, X509SCEPDisposition* pDisposition);
    HRESULT get_X509SCEPEnrollment(IX509SCEPEnrollment* ppValue);
    HRESULT get_ResultMessageText(BSTR* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nn-certenc-icertencodestringarray
@GUID("12a88820-7494-11d0-8816-00a0c903b83c")
interface ICertEncodeStringArray : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodestringarray-decode
    HRESULT Decode(const(BSTR) strBinary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodestringarray-getstringtype
    HRESULT GetStringType(int* pStringType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodestringarray-getcount
    HRESULT GetCount(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodestringarray-getvalue
    HRESULT GetValue(int Index, BSTR* pstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodestringarray-reset
    HRESULT Reset(int Count, CERT_RDN_ATTR_VALUE_TYPE StringType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodestringarray-setvalue
    HRESULT SetValue(int Index, const(BSTR) str);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodestringarray-encode
    HRESULT Encode(BSTR* pstrBinary);
}

@GUID("9c680d93-9b7d-4e95-9018-4ffe10ba5ada")
interface ICertEncodeStringArray2 : ICertEncodeStringArray
{
    HRESULT DecodeBlob(const(BSTR) strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nn-certenc-icertencodelongarray
@GUID("15e2f230-a0a2-11d0-8821-00a0c903b83c")
interface ICertEncodeLongArray : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodelongarray-decode
    HRESULT Decode(const(BSTR) strBinary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodelongarray-getcount
    HRESULT GetCount(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodelongarray-getvalue
    HRESULT GetValue(int Index, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodelongarray-reset
    HRESULT Reset(int Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodelongarray-setvalue
    HRESULT SetValue(int Index, int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodelongarray-encode
    HRESULT Encode(BSTR* pstrBinary);
}

@GUID("4efde84a-bd9b-4fc2-a108-c347d478840f")
interface ICertEncodeLongArray2 : ICertEncodeLongArray
{
    HRESULT DecodeBlob(const(BSTR) strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nn-certenc-icertencodedatearray
@GUID("2f9469a0-a470-11d0-8821-00a0c903b83c")
interface ICertEncodeDateArray : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodedatearray-decode
    HRESULT Decode(const(BSTR) strBinary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodedatearray-getcount
    HRESULT GetCount(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodedatearray-getvalue
    HRESULT GetValue(int Index, double* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodedatearray-reset
    HRESULT Reset(int Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodedatearray-setvalue
    HRESULT SetValue(int Index, double Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodedatearray-encode
    HRESULT Encode(BSTR* pstrBinary);
}

@GUID("99a4edb5-2b8e-448d-bf95-bba8d7789dc8")
interface ICertEncodeDateArray2 : ICertEncodeDateArray
{
    HRESULT DecodeBlob(const(BSTR) strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nn-certenc-icertencodecrldistinfo
@GUID("01958640-bbff-11d0-8825-00a0c903b83c")
interface ICertEncodeCRLDistInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodecrldistinfo-decode
    HRESULT Decode(const(BSTR) strBinary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodecrldistinfo-getdistpointcount
    HRESULT GetDistPointCount(int* pDistPointCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodecrldistinfo-getnamecount
    HRESULT GetNameCount(int DistPointIndex, int* pNameCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodecrldistinfo-getnamechoice
    HRESULT GetNameChoice(int DistPointIndex, int NameIndex, int* pNameChoice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodecrldistinfo-getname
    HRESULT GetName(int DistPointIndex, int NameIndex, BSTR* pstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodecrldistinfo-reset
    HRESULT Reset(int DistPointCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodecrldistinfo-setnamecount
    HRESULT SetNameCount(int DistPointIndex, int NameCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodecrldistinfo-setnameentry
    HRESULT SetNameEntry(int DistPointIndex, int NameIndex, CERT_ALT_NAME NameChoice, const(BSTR) strName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodecrldistinfo-encode
    HRESULT Encode(BSTR* pstrBinary);
}

@GUID("b4275d4b-3e30-446f-ad36-09d03120b078")
interface ICertEncodeCRLDistInfo2 : ICertEncodeCRLDistInfo
{
    HRESULT DecodeBlob(const(BSTR) strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nn-certenc-icertencodealtname
@GUID("1c9a8c70-1271-11d1-9bd4-00c04fb683fa")
interface ICertEncodeAltName : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodealtname-decode
    HRESULT Decode(const(BSTR) strBinary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodealtname-getnamecount
    HRESULT GetNameCount(int* pNameCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodealtname-getnamechoice
    HRESULT GetNameChoice(int NameIndex, int* pNameChoice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodealtname-getname
    HRESULT GetName(int NameIndex, BSTR* pstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodealtname-reset
    HRESULT Reset(int NameCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodealtname-setnameentry
    HRESULT SetNameEntry(int NameIndex, CERT_ALT_NAME NameChoice, const(BSTR) strName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodealtname-encode
    HRESULT Encode(BSTR* pstrBinary);
}

@GUID("f67fe177-5ef1-4535-b4ce-29df15e2e0c3")
interface ICertEncodeAltName2 : ICertEncodeAltName
{
    HRESULT DecodeBlob(const(BSTR) strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
    HRESULT GetNameBlob(int NameIndex, EncodingType Encoding, BSTR* pstrName);
    HRESULT SetNameEntryBlob(int NameIndex, int NameChoice, const(BSTR) strName, EncodingType Encoding);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nn-certenc-icertencodebitstring
@GUID("6db525be-1278-11d1-9bd4-00c04fb683fa")
interface ICertEncodeBitString : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodebitstring-decode
    HRESULT Decode(const(BSTR) strBinary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodebitstring-getbitcount
    HRESULT GetBitCount(int* pBitCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodebitstring-getbitstring
    HRESULT GetBitString(BSTR* pstrBitString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certenc/nf-certenc-icertencodebitstring-encode
    HRESULT Encode(int BitCount, BSTR strBitString, BSTR* pstrBinary);
}

@GUID("e070d6e7-23ef-4dd2-8242-ebd9c928cb30")
interface ICertEncodeBitString2 : ICertEncodeBitString
{
    HRESULT DecodeBlob(const(BSTR) strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(int BitCount, const(BSTR) strBitString, EncodingType EncodingIn, EncodingType Encoding, 
                       BSTR* pstrEncodedData);
    HRESULT GetBitStringBlob(EncodingType Encoding, BSTR* pstrBitString);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certexit/nn-certexit-icertexit
@GUID("e19ae1a0-7364-11d0-8816-00a0c903b83c")
interface ICertExit : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certexit/nf-certexit-icertexit-initialize
    HRESULT Initialize(const(BSTR) strConfig, CERT_EXIT_EVENT_MASK* pEventMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certexit/nf-certexit-icertexit-notify
    HRESULT Notify(int ExitEvent, int Context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certexit/nf-certexit-icertexit-getdescription
    HRESULT GetDescription(BSTR* pstrDescription);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certexit/nn-certexit-icertexit2
@GUID("0abf484b-d049-464d-a7ed-552e7529b0ff")
interface ICertExit2 : ICertExit
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/certexit/nf-certexit-icertexit2-getmanagemodule
    HRESULT GetManageModule(ICertManageModule* ppManageModule);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nn-xenroll-icenroll
@GUID("43f8f288-7a20-11d0-8f06-00c04fc295e1")
interface ICEnroll : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-createfilepkcs10
    HRESULT createFilePKCS10(BSTR DNName, BSTR Usage, BSTR wszPKCS10FileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-acceptfilepkcs7
    HRESULT acceptFilePKCS7(BSTR wszPKCS7FileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-createpkcs10
    HRESULT createPKCS10(BSTR DNName, BSTR Usage, BSTR* pPKCS10);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-acceptpkcs7
    HRESULT acceptPKCS7(BSTR PKCS7);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-getcertfrompkcs7
    HRESULT getCertFromPKCS7(BSTR wszPKCS7, BSTR* pbstrCert);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-enumproviders
    HRESULT enumProviders(int dwIndex, int dwFlags, BSTR* pbstrProvName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-enumcontainers
    HRESULT enumContainers(int dwIndex, BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-freerequestinfo
    HRESULT freeRequestInfo(BSTR PKCS7OrPKCS10);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_mystorename
    HRESULT get_MyStoreName(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_mystorename
    HRESULT put_MyStoreName(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_mystoretype
    HRESULT get_MyStoreType(BSTR* pbstrType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_mystoretype
    HRESULT put_MyStoreType(BSTR bstrType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_mystoreflags
    HRESULT get_MyStoreFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_mystoreflags
    HRESULT put_MyStoreFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_castorename
    HRESULT get_CAStoreName(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_castorename
    HRESULT put_CAStoreName(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_castoretype
    HRESULT get_CAStoreType(BSTR* pbstrType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_castoretype
    HRESULT put_CAStoreType(BSTR bstrType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_castoreflags
    HRESULT get_CAStoreFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_castoreflags
    HRESULT put_CAStoreFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_rootstorename
    HRESULT get_RootStoreName(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_rootstorename
    HRESULT put_RootStoreName(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_rootstoretype
    HRESULT get_RootStoreType(BSTR* pbstrType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_rootstoretype
    HRESULT put_RootStoreType(BSTR bstrType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_rootstoreflags
    HRESULT get_RootStoreFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_rootstoreflags
    HRESULT put_RootStoreFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_requeststorename
    HRESULT get_RequestStoreName(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_requeststorename
    HRESULT put_RequestStoreName(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_requeststoretype
    HRESULT get_RequestStoreType(BSTR* pbstrType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_requeststoretype
    HRESULT put_RequestStoreType(BSTR bstrType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_requeststoreflags
    HRESULT get_RequestStoreFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_requeststoreflags
    HRESULT put_RequestStoreFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_containername
    HRESULT get_ContainerName(BSTR* pbstrContainer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_containername
    HRESULT put_ContainerName(BSTR bstrContainer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_providername
    HRESULT get_ProviderName(BSTR* pbstrProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_providername
    HRESULT put_ProviderName(BSTR bstrProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_providertype
    HRESULT get_ProviderType(int* pdwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_providertype
    HRESULT put_ProviderType(int dwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_keyspec
    HRESULT get_KeySpec(int* pdw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_keyspec
    HRESULT put_KeySpec(int dw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_providerflags
    HRESULT get_ProviderFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_providerflags
    HRESULT put_ProviderFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_useexistingkeyset
    HRESULT get_UseExistingKeySet(BOOL* fUseExistingKeys);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_useexistingkeyset
    HRESULT put_UseExistingKeySet(BOOL fUseExistingKeys);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_genkeyflags
    HRESULT get_GenKeyFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_genkeyflags
    HRESULT put_GenKeyFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_deleterequestcert
    HRESULT get_DeleteRequestCert(BOOL* fDelete);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_deleterequestcert
    HRESULT put_DeleteRequestCert(BOOL fDelete);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_writecerttocsp
    HRESULT get_WriteCertToCSP(BOOL* fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_writecerttocsp
    HRESULT put_WriteCertToCSP(BOOL fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_spcfilename
    HRESULT get_SPCFileName(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_spcfilename
    HRESULT put_SPCFileName(BSTR bstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_pvkfilename
    HRESULT get_PVKFileName(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_pvkfilename
    HRESULT put_PVKFileName(BSTR bstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-get_hashalgorithm
    HRESULT get_HashAlgorithm(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll-put_hashalgorithm
    HRESULT put_HashAlgorithm(BSTR bstr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nn-xenroll-icenroll2
@GUID("704ca730-c90b-11d1-9bec-00c04fc295e1")
interface ICEnroll2 : ICEnroll
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll2-addcerttypetorequest
    HRESULT addCertTypeToRequest(BSTR CertType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll2-addnamevaluepairtosignature
    HRESULT addNameValuePairToSignature(BSTR Name, BSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll2-get_writecerttouserds
    HRESULT get_WriteCertToUserDS(BOOL* fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll2-put_writecerttouserds
    HRESULT put_WriteCertToUserDS(BOOL fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll2-get_enablet61dnencoding
    HRESULT get_EnableT61DNEncoding(BOOL* fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll2-put_enablet61dnencoding
    HRESULT put_EnableT61DNEncoding(BOOL fBool);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nn-xenroll-icenroll3
@GUID("c28c2d95-b7de-11d2-a421-00c04f79fe8e")
interface ICEnroll3 : ICEnroll2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-installpkcs7
    HRESULT InstallPKCS7(BSTR PKCS7);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-getsupportedkeyspec
    HRESULT GetSupportedKeySpec(int* pdwKeySpec);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-getkeylen
    HRESULT GetKeyLen(BOOL fMin, BOOL fExchange, int* pdwKeySize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-enumalgs
    HRESULT EnumAlgs(int dwIndex, int algClass, int* pdwAlgID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-getalgname
    HRESULT GetAlgName(int algID, BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-put_reusehardwarekeyifunabletogennew
    HRESULT put_ReuseHardwareKeyIfUnableToGenNew(BOOL fReuseHardwareKeyIfUnableToGenNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-get_reusehardwarekeyifunabletogennew
    HRESULT get_ReuseHardwareKeyIfUnableToGenNew(BOOL* fReuseHardwareKeyIfUnableToGenNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-put_hashalgid
    HRESULT put_HashAlgID(int hashAlgID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-get_hashalgid
    HRESULT get_HashAlgID(int* hashAlgID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-put_limitexchangekeytoencipherment
    HRESULT put_LimitExchangeKeyToEncipherment(BOOL fLimitExchangeKeyToEncipherment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-get_limitexchangekeytoencipherment
    HRESULT get_LimitExchangeKeyToEncipherment(BOOL* fLimitExchangeKeyToEncipherment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-put_enablesmimecapabilities
    HRESULT put_EnableSMIMECapabilities(BOOL fEnableSMIMECapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll3-get_enablesmimecapabilities
    HRESULT get_EnableSMIMECapabilities(BOOL* fEnableSMIMECapabilities);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nn-xenroll-icenroll4
@GUID("c1f1188a-2eb5-4a80-841b-7e729a356d90")
interface ICEnroll4 : ICEnroll3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-put_privatekeyarchivecertificate
    HRESULT put_PrivateKeyArchiveCertificate(BSTR bstrCert);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-get_privatekeyarchivecertificate
    HRESULT get_PrivateKeyArchiveCertificate(BSTR* pbstrCert);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-put_thumbprint
    HRESULT put_ThumbPrint(BSTR bstrThumbPrint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-get_thumbprint
    HRESULT get_ThumbPrint(BSTR* pbstrThumbPrint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-binarytostring
    HRESULT binaryToString(int Flags, BSTR strBinary, BSTR* pstrEncoded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-stringtobinary
    HRESULT stringToBinary(int Flags, BSTR strEncoded, BSTR* pstrBinary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-addextensiontorequest
    HRESULT addExtensionToRequest(int Flags, BSTR strName, BSTR strValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-addattributetorequest
    HRESULT addAttributeToRequest(int Flags, BSTR strName, BSTR strValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-addnamevaluepairtorequest
    HRESULT addNameValuePairToRequest(int Flags, BSTR strName, BSTR strValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-resetextensions
    HRESULT resetExtensions();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-resetattributes
    HRESULT resetAttributes();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-createrequest
    HRESULT createRequest(CERT_CREATE_REQUEST_FLAGS Flags, BSTR strDNName, BSTR Usage, BSTR* pstrRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-createfilerequest
    HRESULT createFileRequest(CERT_CREATE_REQUEST_FLAGS Flags, BSTR strDNName, BSTR strUsage, 
                              BSTR strRequestFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-acceptresponse
    HRESULT acceptResponse(BSTR strResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-acceptfileresponse
    HRESULT acceptFileResponse(BSTR strResponseFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-getcertfromresponse
    HRESULT getCertFromResponse(BSTR strResponse, BSTR* pstrCert);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-getcertfromfileresponse
    HRESULT getCertFromFileResponse(BSTR strResponseFileName, BSTR* pstrCert);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-createpfx
    HRESULT createPFX(BSTR strPassword, BSTR* pstrPFX);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-createfilepfx
    HRESULT createFilePFX(BSTR strPassword, BSTR strPFXFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-setpendingrequestinfo
    HRESULT setPendingRequestInfo(int lRequestID, BSTR strCADNS, BSTR strCAName, BSTR strFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-enumpendingrequest
    HRESULT enumPendingRequest(int lIndex, PENDING_REQUEST_DESIRED_PROPERTY lDesiredProperty, 
                               VARIANT* pvarProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-removependingrequest
    HRESULT removePendingRequest(BSTR strThumbprint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-getkeylenex
    HRESULT GetKeyLenEx(XEKL_KEYSIZE lSizeSpec, XEKL_KEYSPEC lKeySpec, int* pdwKeySize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-installpkcs7ex
    HRESULT InstallPKCS7Ex(BSTR PKCS7, int* plCertInstalled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-addcerttypetorequestex
    HRESULT addCertTypeToRequestEx(ADDED_CERT_TYPE lType, BSTR bstrOIDOrName, int lMajorVersion, 
                                   BOOL fMinorVersion, int lMinorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-getprovidertype
    HRESULT getProviderType(BSTR strProvName, int* plProvType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-put_signercertificate
    HRESULT put_SignerCertificate(BSTR bstrCert);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-put_clientid
    HRESULT put_ClientId(int lClientId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-get_clientid
    HRESULT get_ClientId(int* plClientId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-addblobpropertytocertificate
    HRESULT addBlobPropertyToCertificate(int lPropertyId, int lReserved, BSTR bstrProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-resetblobproperties
    HRESULT resetBlobProperties();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-put_includesubjectkeyid
    HRESULT put_IncludeSubjectKeyID(BOOL fInclude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-icenroll4-get_includesubjectkeyid
    HRESULT get_IncludeSubjectKeyID(BOOL* pfInclude);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nn-xenroll-ienroll
@GUID("acaa7838-4585-11d1-ab57-00c04fc295e1")
interface IEnroll : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-createfilepkcs10wstr
    HRESULT createFilePKCS10WStr(const(PWSTR) DNName, const(PWSTR) Usage, const(PWSTR) wszPKCS10FileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-acceptfilepkcs7wstr
    HRESULT acceptFilePKCS7WStr(const(PWSTR) wszPKCS7FileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-createpkcs10wstr
    HRESULT createPKCS10WStr(const(PWSTR) DNName, const(PWSTR) Usage, CRYPT_INTEGER_BLOB* pPkcs10Blob);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-acceptpkcs7blob
    HRESULT acceptPKCS7Blob(CRYPT_INTEGER_BLOB* pBlobPKCS7);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-getcertcontextfrompkcs7
    CERT_CONTEXT* getCertContextFromPKCS7(CRYPT_INTEGER_BLOB* pBlobPKCS7);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-getmystore
    HCERTSTORE getMyStore();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-getcastore
    HCERTSTORE getCAStore();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-getroothstore
    HCERTSTORE getROOTHStore();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-enumproviderswstr
    HRESULT enumProvidersWStr(int dwIndex, int dwFlags, PWSTR* pbstrProvName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-enumcontainerswstr
    HRESULT enumContainersWStr(int dwIndex, PWSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-freerequestinfoblob
    HRESULT freeRequestInfoBlob(CRYPT_INTEGER_BLOB pkcs7OrPkcs10);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_mystorenamewstr
    HRESULT get_MyStoreNameWStr(PWSTR* szwName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_mystorenamewstr
    HRESULT put_MyStoreNameWStr(PWSTR szwName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_mystoretypewstr
    HRESULT get_MyStoreTypeWStr(PWSTR* szwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_mystoretypewstr
    HRESULT put_MyStoreTypeWStr(PWSTR szwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_mystoreflags
    HRESULT get_MyStoreFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_mystoreflags
    HRESULT put_MyStoreFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_castorenamewstr
    HRESULT get_CAStoreNameWStr(PWSTR* szwName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_castorenamewstr
    HRESULT put_CAStoreNameWStr(PWSTR szwName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_castoretypewstr
    HRESULT get_CAStoreTypeWStr(PWSTR* szwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_castoretypewstr
    HRESULT put_CAStoreTypeWStr(PWSTR szwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_castoreflags
    HRESULT get_CAStoreFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_castoreflags
    HRESULT put_CAStoreFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_rootstorenamewstr
    HRESULT get_RootStoreNameWStr(PWSTR* szwName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_rootstorenamewstr
    HRESULT put_RootStoreNameWStr(PWSTR szwName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_rootstoretypewstr
    HRESULT get_RootStoreTypeWStr(PWSTR* szwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_rootstoretypewstr
    HRESULT put_RootStoreTypeWStr(PWSTR szwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_rootstoreflags
    HRESULT get_RootStoreFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_rootstoreflags
    HRESULT put_RootStoreFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_requeststorenamewstr
    HRESULT get_RequestStoreNameWStr(PWSTR* szwName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_requeststorenamewstr
    HRESULT put_RequestStoreNameWStr(PWSTR szwName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_requeststoretypewstr
    HRESULT get_RequestStoreTypeWStr(PWSTR* szwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_requeststoretypewstr
    HRESULT put_RequestStoreTypeWStr(PWSTR szwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_requeststoreflags
    HRESULT get_RequestStoreFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_requeststoreflags
    HRESULT put_RequestStoreFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_containernamewstr
    HRESULT get_ContainerNameWStr(PWSTR* szwContainer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_containernamewstr
    HRESULT put_ContainerNameWStr(PWSTR szwContainer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_providernamewstr
    HRESULT get_ProviderNameWStr(PWSTR* szwProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_providernamewstr
    HRESULT put_ProviderNameWStr(PWSTR szwProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_providertype
    HRESULT get_ProviderType(int* pdwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_providertype
    HRESULT put_ProviderType(int dwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_keyspec
    HRESULT get_KeySpec(int* pdw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_keyspec
    HRESULT put_KeySpec(int dw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_providerflags
    HRESULT get_ProviderFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_providerflags
    HRESULT put_ProviderFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_useexistingkeyset
    HRESULT get_UseExistingKeySet(BOOL* fUseExistingKeys);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_useexistingkeyset
    HRESULT put_UseExistingKeySet(BOOL fUseExistingKeys);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_genkeyflags
    HRESULT get_GenKeyFlags(int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_genkeyflags
    HRESULT put_GenKeyFlags(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_deleterequestcert
    HRESULT get_DeleteRequestCert(BOOL* fDelete);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_deleterequestcert
    HRESULT put_DeleteRequestCert(BOOL fDelete);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_writecerttouserds
    HRESULT get_WriteCertToUserDS(BOOL* fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_writecerttouserds
    HRESULT put_WriteCertToUserDS(BOOL fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_enablet61dnencoding
    HRESULT get_EnableT61DNEncoding(BOOL* fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_enablet61dnencoding
    HRESULT put_EnableT61DNEncoding(BOOL fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_writecerttocsp
    HRESULT get_WriteCertToCSP(BOOL* fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_writecerttocsp
    HRESULT put_WriteCertToCSP(BOOL fBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_spcfilenamewstr
    HRESULT get_SPCFileNameWStr(PWSTR* szw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_spcfilenamewstr
    HRESULT put_SPCFileNameWStr(PWSTR szw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_pvkfilenamewstr
    HRESULT get_PVKFileNameWStr(PWSTR* szw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_pvkfilenamewstr
    HRESULT put_PVKFileNameWStr(PWSTR szw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_hashalgorithmwstr
    HRESULT get_HashAlgorithmWStr(PWSTR* szw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_hashalgorithmwstr
    HRESULT put_HashAlgorithmWStr(PWSTR szw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-get_renewalcertificate
    HRESULT get_RenewalCertificate(CERT_CONTEXT** ppCertContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-put_renewalcertificate
    HRESULT put_RenewalCertificate(const(CERT_CONTEXT)* pCertContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-addcerttypetorequestwstr
    HRESULT AddCertTypeToRequestWStr(PWSTR szw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-addnamevaluepairtosignaturewstr
    HRESULT AddNameValuePairToSignatureWStr(PWSTR Name, PWSTR Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-addextensionstorequest
    HRESULT AddExtensionsToRequest(CERT_EXTENSIONS* pCertExtensions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-addauthenticatedattributestopkcs7request
    HRESULT AddAuthenticatedAttributesToPKCS7Request(CRYPT_ATTRIBUTES* pAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll-createpkcs7requestfromrequest
    HRESULT CreatePKCS7RequestFromRequest(CRYPT_INTEGER_BLOB* pRequest, const(CERT_CONTEXT)* pSigningCertContext, 
                                          CRYPT_INTEGER_BLOB* pPkcs7Blob);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nn-xenroll-ienroll2
@GUID("c080e199-b7df-11d2-a421-00c04f79fe8e")
interface IEnroll2 : IEnroll
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-installpkcs7blob
    HRESULT InstallPKCS7Blob(CRYPT_INTEGER_BLOB* pBlobPKCS7);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-getsupportedkeyspec
    HRESULT GetSupportedKeySpec(int* pdwKeySpec);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-getkeylen
    HRESULT GetKeyLen(BOOL fMin, BOOL fExchange, int* pdwKeySize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-enumalgs
    HRESULT EnumAlgs(int dwIndex, int algClass, int* pdwAlgID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-getalgnamewstr
    HRESULT GetAlgNameWStr(int algID, PWSTR* ppwsz);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-put_reusehardwarekeyifunabletogennew
    HRESULT put_ReuseHardwareKeyIfUnableToGenNew(BOOL fReuseHardwareKeyIfUnableToGenNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-get_reusehardwarekeyifunabletogennew
    HRESULT get_ReuseHardwareKeyIfUnableToGenNew(BOOL* fReuseHardwareKeyIfUnableToGenNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-put_hashalgid
    HRESULT put_HashAlgID(int hashAlgID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-get_hashalgid
    HRESULT get_HashAlgID(int* hashAlgID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-sethstoremy
    HRESULT SetHStoreMy(HCERTSTORE hStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-sethstoreca
    HRESULT SetHStoreCA(HCERTSTORE hStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-sethstoreroot
    HRESULT SetHStoreROOT(HCERTSTORE hStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-sethstorerequest
    HRESULT SetHStoreRequest(HCERTSTORE hStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-put_limitexchangekeytoencipherment
    HRESULT put_LimitExchangeKeyToEncipherment(BOOL fLimitExchangeKeyToEncipherment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-get_limitexchangekeytoencipherment
    HRESULT get_LimitExchangeKeyToEncipherment(BOOL* fLimitExchangeKeyToEncipherment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-put_enablesmimecapabilities
    HRESULT put_EnableSMIMECapabilities(BOOL fEnableSMIMECapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll2-get_enablesmimecapabilities
    HRESULT get_EnableSMIMECapabilities(BOOL* fEnableSMIMECapabilities);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nn-xenroll-ienroll4
@GUID("f8053fe5-78f4-448f-a0db-41d61b73446b")
interface IEnroll4 : IEnroll2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-put_thumbprintwstr
    HRESULT put_ThumbPrintWStr(CRYPT_INTEGER_BLOB thumbPrintBlob);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-get_thumbprintwstr
    HRESULT get_ThumbPrintWStr(CRYPT_INTEGER_BLOB* thumbPrintBlob);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-setprivatekeyarchivecertificate
    HRESULT SetPrivateKeyArchiveCertificate(const(CERT_CONTEXT)* pPrivateKeyArchiveCert);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-getprivatekeyarchivecertificate
    CERT_CONTEXT* GetPrivateKeyArchiveCertificate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-binaryblobtostring
    HRESULT binaryBlobToString(int Flags, CRYPT_INTEGER_BLOB* pblobBinary, PWSTR* ppwszString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-stringtobinaryblob
    HRESULT stringToBinaryBlob(int Flags, const(PWSTR) pwszString, CRYPT_INTEGER_BLOB* pblobBinary, int* pdwSkip, 
                               int* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-addextensiontorequestwstr
    HRESULT addExtensionToRequestWStr(int Flags, const(PWSTR) pwszName, CRYPT_INTEGER_BLOB* pblobValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-addattributetorequestwstr
    HRESULT addAttributeToRequestWStr(int Flags, const(PWSTR) pwszName, CRYPT_INTEGER_BLOB* pblobValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-addnamevaluepairtorequestwstr
    HRESULT addNameValuePairToRequestWStr(int Flags, const(PWSTR) pwszName, const(PWSTR) pwszValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-resetextensions
    HRESULT resetExtensions();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-resetattributes
    HRESULT resetAttributes();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-createrequestwstr
    HRESULT createRequestWStr(CERT_CREATE_REQUEST_FLAGS Flags, const(PWSTR) pwszDNName, const(PWSTR) pwszUsage, 
                              CRYPT_INTEGER_BLOB* pblobRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-createfilerequestwstr
    HRESULT createFileRequestWStr(CERT_CREATE_REQUEST_FLAGS Flags, const(PWSTR) pwszDNName, const(PWSTR) pwszUsage, 
                                  const(PWSTR) pwszRequestFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-acceptresponseblob
    HRESULT acceptResponseBlob(CRYPT_INTEGER_BLOB* pblobResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-acceptfileresponsewstr
    HRESULT acceptFileResponseWStr(const(PWSTR) pwszResponseFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-getcertcontextfromresponseblob
    HRESULT getCertContextFromResponseBlob(CRYPT_INTEGER_BLOB* pblobResponse, CERT_CONTEXT** ppCertContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-getcertcontextfromfileresponsewstr
    HRESULT getCertContextFromFileResponseWStr(const(PWSTR) pwszResponseFileName, CERT_CONTEXT** ppCertContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-createpfxwstr
    HRESULT createPFXWStr(const(PWSTR) pwszPassword, CRYPT_INTEGER_BLOB* pblobPFX);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-createfilepfxwstr
    HRESULT createFilePFXWStr(const(PWSTR) pwszPassword, const(PWSTR) pwszPFXFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-setpendingrequestinfowstr
    HRESULT setPendingRequestInfoWStr(int lRequestID, const(PWSTR) pwszCADNS, const(PWSTR) pwszCAName, 
                                      const(PWSTR) pwszFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-enumpendingrequestwstr
    HRESULT enumPendingRequestWStr(int lIndex, PENDING_REQUEST_DESIRED_PROPERTY lDesiredProperty, void* ppProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-removependingrequestwstr
    HRESULT removePendingRequestWStr(CRYPT_INTEGER_BLOB thumbPrintBlob);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-getkeylenex
    HRESULT GetKeyLenEx(XEKL_KEYSIZE lSizeSpec, XEKL_KEYSPEC lKeySpec, int* pdwKeySize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-installpkcs7blobex
    HRESULT InstallPKCS7BlobEx(CRYPT_INTEGER_BLOB* pBlobPKCS7, int* plCertInstalled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-addcerttypetorequestwstrex
    HRESULT AddCertTypeToRequestWStrEx(ADDED_CERT_TYPE lType, const(PWSTR) pwszOIDOrName, int lMajorVersion, 
                                       BOOL fMinorVersion, int lMinorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-getprovidertypewstr
    HRESULT getProviderTypeWStr(const(PWSTR) pwszProvName, int* plProvType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-addblobpropertytocertificatewstr
    HRESULT addBlobPropertyToCertificateWStr(int lPropertyId, int lReserved, CRYPT_INTEGER_BLOB* pBlobProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-setsignercertificate
    HRESULT SetSignerCertificate(const(CERT_CONTEXT)* pSignerCert);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-put_clientid
    HRESULT put_ClientId(int lClientId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-get_clientid
    HRESULT get_ClientId(int* plClientId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-put_includesubjectkeyid
    HRESULT put_IncludeSubjectKeyID(BOOL fInclude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xenroll/nf-xenroll-ienroll4-get_includesubjectkeyid
    HRESULT get_IncludeSubjectKeyID(BOOL* pfInclude);
}

@GUID("d99e6e70-fc88-11d0-b498-00a0c90312f3")
interface ICertRequestD : IUnknown
{
    HRESULT Request(uint dwFlags, const(PWSTR) pwszAuthority, uint* pdwRequestId, uint* pdwDisposition, 
                    const(PWSTR) pwszAttributes, const(CERTTRANSBLOB)* pctbRequest, CERTTRANSBLOB* pctbCertChain, 
                    CERTTRANSBLOB* pctbEncodedCert, CERTTRANSBLOB* pctbDispositionMessage);
    HRESULT GetCACert(uint fchain, const(PWSTR) pwszAuthority, CERTTRANSBLOB* pctbOut);
    HRESULT Ping(const(PWSTR) pwszAuthority);
}

@GUID("5422fd3a-d4b8-4cef-a12e-e87d4ca22e90")
interface ICertRequestD2 : ICertRequestD
{
    HRESULT Request2(const(PWSTR) pwszAuthority, uint dwFlags, const(PWSTR) pwszSerialNumber, uint* pdwRequestId, 
                     uint* pdwDisposition, const(PWSTR) pwszAttributes, const(CERTTRANSBLOB)* pctbRequest, 
                     CERTTRANSBLOB* pctbFullResponse, CERTTRANSBLOB* pctbEncodedCert, 
                     CERTTRANSBLOB* pctbDispositionMessage);
    HRESULT GetCAProperty(const(PWSTR) pwszAuthority, int PropId, int PropIndex, int PropType, 
                          CERTTRANSBLOB* pctbPropertyValue);
    HRESULT GetCAPropertyInfo(const(PWSTR) pwszAuthority, int* pcProperty, CERTTRANSBLOB* pctbPropInfo);
    HRESULT Ping2(const(PWSTR) pwszAuthority);
}


// GUIDs

const GUID CLSID_CAlternativeName                      = GUIDOF!CAlternativeName;
const GUID CLSID_CAlternativeNames                     = GUIDOF!CAlternativeNames;
const GUID CLSID_CBinaryConverter                      = GUIDOF!CBinaryConverter;
const GUID CLSID_CCertAdmin                            = GUIDOF!CCertAdmin;
const GUID CLSID_CCertConfig                           = GUIDOF!CCertConfig;
const GUID CLSID_CCertEncodeAltName                    = GUIDOF!CCertEncodeAltName;
const GUID CLSID_CCertEncodeBitString                  = GUIDOF!CCertEncodeBitString;
const GUID CLSID_CCertEncodeCRLDistInfo                = GUIDOF!CCertEncodeCRLDistInfo;
const GUID CLSID_CCertEncodeDateArray                  = GUIDOF!CCertEncodeDateArray;
const GUID CLSID_CCertEncodeLongArray                  = GUIDOF!CCertEncodeLongArray;
const GUID CLSID_CCertEncodeStringArray                = GUIDOF!CCertEncodeStringArray;
const GUID CLSID_CCertGetConfig                        = GUIDOF!CCertGetConfig;
const GUID CLSID_CCertProperties                       = GUIDOF!CCertProperties;
const GUID CLSID_CCertProperty                         = GUIDOF!CCertProperty;
const GUID CLSID_CCertPropertyArchived                 = GUIDOF!CCertPropertyArchived;
const GUID CLSID_CCertPropertyArchivedKeyHash          = GUIDOF!CCertPropertyArchivedKeyHash;
const GUID CLSID_CCertPropertyAutoEnroll               = GUIDOF!CCertPropertyAutoEnroll;
const GUID CLSID_CCertPropertyBackedUp                 = GUIDOF!CCertPropertyBackedUp;
const GUID CLSID_CCertPropertyDescription              = GUIDOF!CCertPropertyDescription;
const GUID CLSID_CCertPropertyEnrollment               = GUIDOF!CCertPropertyEnrollment;
const GUID CLSID_CCertPropertyEnrollmentPolicyServer   = GUIDOF!CCertPropertyEnrollmentPolicyServer;
const GUID CLSID_CCertPropertyFriendlyName             = GUIDOF!CCertPropertyFriendlyName;
const GUID CLSID_CCertPropertyKeyProvInfo              = GUIDOF!CCertPropertyKeyProvInfo;
const GUID CLSID_CCertPropertyRenewal                  = GUIDOF!CCertPropertyRenewal;
const GUID CLSID_CCertPropertyRequestOriginator        = GUIDOF!CCertPropertyRequestOriginator;
const GUID CLSID_CCertPropertySHA1Hash                 = GUIDOF!CCertPropertySHA1Hash;
const GUID CLSID_CCertRequest                          = GUIDOF!CCertRequest;
const GUID CLSID_CCertServerExit                       = GUIDOF!CCertServerExit;
const GUID CLSID_CCertServerPolicy                     = GUIDOF!CCertServerPolicy;
const GUID CLSID_CCertView                             = GUIDOF!CCertView;
const GUID CLSID_CCertificateAttestationChallenge      = GUIDOF!CCertificateAttestationChallenge;
const GUID CLSID_CCertificatePolicies                  = GUIDOF!CCertificatePolicies;
const GUID CLSID_CCertificatePolicy                    = GUIDOF!CCertificatePolicy;
const GUID CLSID_CCryptAttribute                       = GUIDOF!CCryptAttribute;
const GUID CLSID_CCryptAttributes                      = GUIDOF!CCryptAttributes;
const GUID CLSID_CCspInformation                       = GUIDOF!CCspInformation;
const GUID CLSID_CCspInformations                      = GUIDOF!CCspInformations;
const GUID CLSID_CCspStatus                            = GUIDOF!CCspStatus;
const GUID CLSID_CEnroll                               = GUIDOF!CEnroll;
const GUID CLSID_CEnroll2                              = GUIDOF!CEnroll2;
const GUID CLSID_CObjectId                             = GUIDOF!CObjectId;
const GUID CLSID_CObjectIds                            = GUIDOF!CObjectIds;
const GUID CLSID_CPolicyQualifier                      = GUIDOF!CPolicyQualifier;
const GUID CLSID_CPolicyQualifiers                     = GUIDOF!CPolicyQualifiers;
const GUID CLSID_CSignerCertificate                    = GUIDOF!CSignerCertificate;
const GUID CLSID_CSmimeCapabilities                    = GUIDOF!CSmimeCapabilities;
const GUID CLSID_CSmimeCapability                      = GUIDOF!CSmimeCapability;
const GUID CLSID_CX500DistinguishedName                = GUIDOF!CX500DistinguishedName;
const GUID CLSID_CX509Attribute                        = GUIDOF!CX509Attribute;
const GUID CLSID_CX509AttributeArchiveKey              = GUIDOF!CX509AttributeArchiveKey;
const GUID CLSID_CX509AttributeArchiveKeyHash          = GUIDOF!CX509AttributeArchiveKeyHash;
const GUID CLSID_CX509AttributeClientId                = GUIDOF!CX509AttributeClientId;
const GUID CLSID_CX509AttributeCspProvider             = GUIDOF!CX509AttributeCspProvider;
const GUID CLSID_CX509AttributeExtensions              = GUIDOF!CX509AttributeExtensions;
const GUID CLSID_CX509AttributeOSVersion               = GUIDOF!CX509AttributeOSVersion;
const GUID CLSID_CX509AttributeRenewalCertificate      = GUIDOF!CX509AttributeRenewalCertificate;
const GUID CLSID_CX509Attributes                       = GUIDOF!CX509Attributes;
const GUID CLSID_CX509CertificateRequestCertificate    = GUIDOF!CX509CertificateRequestCertificate;
const GUID CLSID_CX509CertificateRequestCmc            = GUIDOF!CX509CertificateRequestCmc;
const GUID CLSID_CX509CertificateRequestPkcs10         = GUIDOF!CX509CertificateRequestPkcs10;
const GUID CLSID_CX509CertificateRequestPkcs7          = GUIDOF!CX509CertificateRequestPkcs7;
const GUID CLSID_CX509CertificateRevocationList        = GUIDOF!CX509CertificateRevocationList;
const GUID CLSID_CX509CertificateRevocationListEntries = GUIDOF!CX509CertificateRevocationListEntries;
const GUID CLSID_CX509CertificateRevocationListEntry   = GUIDOF!CX509CertificateRevocationListEntry;
const GUID CLSID_CX509CertificateTemplateADWritable    = GUIDOF!CX509CertificateTemplateADWritable;
const GUID CLSID_CX509EndorsementKey                   = GUIDOF!CX509EndorsementKey;
const GUID CLSID_CX509Enrollment                       = GUIDOF!CX509Enrollment;
const GUID CLSID_CX509EnrollmentHelper                 = GUIDOF!CX509EnrollmentHelper;
const GUID CLSID_CX509EnrollmentPolicyActiveDirectory  = GUIDOF!CX509EnrollmentPolicyActiveDirectory;
const GUID CLSID_CX509EnrollmentPolicyWebService       = GUIDOF!CX509EnrollmentPolicyWebService;
const GUID CLSID_CX509EnrollmentWebClassFactory        = GUIDOF!CX509EnrollmentWebClassFactory;
const GUID CLSID_CX509Extension                        = GUIDOF!CX509Extension;
const GUID CLSID_CX509ExtensionAlternativeNames        = GUIDOF!CX509ExtensionAlternativeNames;
const GUID CLSID_CX509ExtensionAuthorityKeyIdentifier  = GUIDOF!CX509ExtensionAuthorityKeyIdentifier;
const GUID CLSID_CX509ExtensionBasicConstraints        = GUIDOF!CX509ExtensionBasicConstraints;
const GUID CLSID_CX509ExtensionCertificatePolicies     = GUIDOF!CX509ExtensionCertificatePolicies;
const GUID CLSID_CX509ExtensionEnhancedKeyUsage        = GUIDOF!CX509ExtensionEnhancedKeyUsage;
const GUID CLSID_CX509ExtensionKeyUsage                = GUIDOF!CX509ExtensionKeyUsage;
const GUID CLSID_CX509ExtensionMSApplicationPolicies   = GUIDOF!CX509ExtensionMSApplicationPolicies;
const GUID CLSID_CX509ExtensionSmimeCapabilities       = GUIDOF!CX509ExtensionSmimeCapabilities;
const GUID CLSID_CX509ExtensionSubjectKeyIdentifier    = GUIDOF!CX509ExtensionSubjectKeyIdentifier;
const GUID CLSID_CX509ExtensionTemplate                = GUIDOF!CX509ExtensionTemplate;
const GUID CLSID_CX509ExtensionTemplateName            = GUIDOF!CX509ExtensionTemplateName;
const GUID CLSID_CX509Extensions                       = GUIDOF!CX509Extensions;
const GUID CLSID_CX509MachineEnrollmentFactory         = GUIDOF!CX509MachineEnrollmentFactory;
const GUID CLSID_CX509NameValuePair                    = GUIDOF!CX509NameValuePair;
const GUID CLSID_CX509PolicyServerListManager          = GUIDOF!CX509PolicyServerListManager;
const GUID CLSID_CX509PolicyServerUrl                  = GUIDOF!CX509PolicyServerUrl;
const GUID CLSID_CX509PrivateKey                       = GUIDOF!CX509PrivateKey;
const GUID CLSID_CX509PublicKey                        = GUIDOF!CX509PublicKey;
const GUID CLSID_CX509SCEPEnrollment                   = GUIDOF!CX509SCEPEnrollment;
const GUID CLSID_CX509SCEPEnrollmentHelper             = GUIDOF!CX509SCEPEnrollmentHelper;
const GUID CLSID_OCSPAdmin                             = GUIDOF!OCSPAdmin;
const GUID CLSID_OCSPPropertyCollection                = GUIDOF!OCSPPropertyCollection;

const GUID IID_IAlternativeName                      = GUIDOF!IAlternativeName;
const GUID IID_IAlternativeNames                     = GUIDOF!IAlternativeNames;
const GUID IID_IBinaryConverter                      = GUIDOF!IBinaryConverter;
const GUID IID_IBinaryConverter2                     = GUIDOF!IBinaryConverter2;
const GUID IID_ICEnroll                              = GUIDOF!ICEnroll;
const GUID IID_ICEnroll2                             = GUIDOF!ICEnroll2;
const GUID IID_ICEnroll3                             = GUIDOF!ICEnroll3;
const GUID IID_ICEnroll4                             = GUIDOF!ICEnroll4;
const GUID IID_ICertAdmin                            = GUIDOF!ICertAdmin;
const GUID IID_ICertAdmin2                           = GUIDOF!ICertAdmin2;
const GUID IID_ICertConfig                           = GUIDOF!ICertConfig;
const GUID IID_ICertConfig2                          = GUIDOF!ICertConfig2;
const GUID IID_ICertEncodeAltName                    = GUIDOF!ICertEncodeAltName;
const GUID IID_ICertEncodeAltName2                   = GUIDOF!ICertEncodeAltName2;
const GUID IID_ICertEncodeBitString                  = GUIDOF!ICertEncodeBitString;
const GUID IID_ICertEncodeBitString2                 = GUIDOF!ICertEncodeBitString2;
const GUID IID_ICertEncodeCRLDistInfo                = GUIDOF!ICertEncodeCRLDistInfo;
const GUID IID_ICertEncodeCRLDistInfo2               = GUIDOF!ICertEncodeCRLDistInfo2;
const GUID IID_ICertEncodeDateArray                  = GUIDOF!ICertEncodeDateArray;
const GUID IID_ICertEncodeDateArray2                 = GUIDOF!ICertEncodeDateArray2;
const GUID IID_ICertEncodeLongArray                  = GUIDOF!ICertEncodeLongArray;
const GUID IID_ICertEncodeLongArray2                 = GUIDOF!ICertEncodeLongArray2;
const GUID IID_ICertEncodeStringArray                = GUIDOF!ICertEncodeStringArray;
const GUID IID_ICertEncodeStringArray2               = GUIDOF!ICertEncodeStringArray2;
const GUID IID_ICertExit                             = GUIDOF!ICertExit;
const GUID IID_ICertExit2                            = GUIDOF!ICertExit2;
const GUID IID_ICertGetConfig                        = GUIDOF!ICertGetConfig;
const GUID IID_ICertManageModule                     = GUIDOF!ICertManageModule;
const GUID IID_ICertPolicy                           = GUIDOF!ICertPolicy;
const GUID IID_ICertPolicy2                          = GUIDOF!ICertPolicy2;
const GUID IID_ICertProperties                       = GUIDOF!ICertProperties;
const GUID IID_ICertProperty                         = GUIDOF!ICertProperty;
const GUID IID_ICertPropertyArchived                 = GUIDOF!ICertPropertyArchived;
const GUID IID_ICertPropertyArchivedKeyHash          = GUIDOF!ICertPropertyArchivedKeyHash;
const GUID IID_ICertPropertyAutoEnroll               = GUIDOF!ICertPropertyAutoEnroll;
const GUID IID_ICertPropertyBackedUp                 = GUIDOF!ICertPropertyBackedUp;
const GUID IID_ICertPropertyDescription              = GUIDOF!ICertPropertyDescription;
const GUID IID_ICertPropertyEnrollment               = GUIDOF!ICertPropertyEnrollment;
const GUID IID_ICertPropertyEnrollmentPolicyServer   = GUIDOF!ICertPropertyEnrollmentPolicyServer;
const GUID IID_ICertPropertyFriendlyName             = GUIDOF!ICertPropertyFriendlyName;
const GUID IID_ICertPropertyKeyProvInfo              = GUIDOF!ICertPropertyKeyProvInfo;
const GUID IID_ICertPropertyRenewal                  = GUIDOF!ICertPropertyRenewal;
const GUID IID_ICertPropertyRequestOriginator        = GUIDOF!ICertPropertyRequestOriginator;
const GUID IID_ICertPropertySHA1Hash                 = GUIDOF!ICertPropertySHA1Hash;
const GUID IID_ICertRequest                          = GUIDOF!ICertRequest;
const GUID IID_ICertRequest2                         = GUIDOF!ICertRequest2;
const GUID IID_ICertRequest3                         = GUIDOF!ICertRequest3;
const GUID IID_ICertRequestD                         = GUIDOF!ICertRequestD;
const GUID IID_ICertRequestD2                        = GUIDOF!ICertRequestD2;
const GUID IID_ICertServerExit                       = GUIDOF!ICertServerExit;
const GUID IID_ICertServerPolicy                     = GUIDOF!ICertServerPolicy;
const GUID IID_ICertView                             = GUIDOF!ICertView;
const GUID IID_ICertView2                            = GUIDOF!ICertView2;
const GUID IID_ICertificateAttestationChallenge      = GUIDOF!ICertificateAttestationChallenge;
const GUID IID_ICertificateAttestationChallenge2     = GUIDOF!ICertificateAttestationChallenge2;
const GUID IID_ICertificatePolicies                  = GUIDOF!ICertificatePolicies;
const GUID IID_ICertificatePolicy                    = GUIDOF!ICertificatePolicy;
const GUID IID_ICertificationAuthorities             = GUIDOF!ICertificationAuthorities;
const GUID IID_ICertificationAuthority               = GUIDOF!ICertificationAuthority;
const GUID IID_ICryptAttribute                       = GUIDOF!ICryptAttribute;
const GUID IID_ICryptAttributes                      = GUIDOF!ICryptAttributes;
const GUID IID_ICspAlgorithm                         = GUIDOF!ICspAlgorithm;
const GUID IID_ICspAlgorithms                        = GUIDOF!ICspAlgorithms;
const GUID IID_ICspInformation                       = GUIDOF!ICspInformation;
const GUID IID_ICspInformations                      = GUIDOF!ICspInformations;
const GUID IID_ICspStatus                            = GUIDOF!ICspStatus;
const GUID IID_ICspStatuses                          = GUIDOF!ICspStatuses;
const GUID IID_IEnroll                               = GUIDOF!IEnroll;
const GUID IID_IEnroll2                              = GUIDOF!IEnroll2;
const GUID IID_IEnroll4                              = GUIDOF!IEnroll4;
const GUID IID_IEnumCERTVIEWATTRIBUTE                = GUIDOF!IEnumCERTVIEWATTRIBUTE;
const GUID IID_IEnumCERTVIEWCOLUMN                   = GUIDOF!IEnumCERTVIEWCOLUMN;
const GUID IID_IEnumCERTVIEWEXTENSION                = GUIDOF!IEnumCERTVIEWEXTENSION;
const GUID IID_IEnumCERTVIEWROW                      = GUIDOF!IEnumCERTVIEWROW;
const GUID IID_INDESPolicy                           = GUIDOF!INDESPolicy;
const GUID IID_IOCSPAdmin                            = GUIDOF!IOCSPAdmin;
const GUID IID_IOCSPCAConfiguration                  = GUIDOF!IOCSPCAConfiguration;
const GUID IID_IOCSPCAConfigurationCollection        = GUIDOF!IOCSPCAConfigurationCollection;
const GUID IID_IOCSPProperty                         = GUIDOF!IOCSPProperty;
const GUID IID_IOCSPPropertyCollection               = GUIDOF!IOCSPPropertyCollection;
const GUID IID_IObjectId                             = GUIDOF!IObjectId;
const GUID IID_IObjectIds                            = GUIDOF!IObjectIds;
const GUID IID_IPolicyQualifier                      = GUIDOF!IPolicyQualifier;
const GUID IID_IPolicyQualifiers                     = GUIDOF!IPolicyQualifiers;
const GUID IID_ISignerCertificate                    = GUIDOF!ISignerCertificate;
const GUID IID_ISignerCertificates                   = GUIDOF!ISignerCertificates;
const GUID IID_ISmimeCapabilities                    = GUIDOF!ISmimeCapabilities;
const GUID IID_ISmimeCapability                      = GUIDOF!ISmimeCapability;
const GUID IID_IX500DistinguishedName                = GUIDOF!IX500DistinguishedName;
const GUID IID_IX509Attribute                        = GUIDOF!IX509Attribute;
const GUID IID_IX509AttributeArchiveKey              = GUIDOF!IX509AttributeArchiveKey;
const GUID IID_IX509AttributeArchiveKeyHash          = GUIDOF!IX509AttributeArchiveKeyHash;
const GUID IID_IX509AttributeClientId                = GUIDOF!IX509AttributeClientId;
const GUID IID_IX509AttributeCspProvider             = GUIDOF!IX509AttributeCspProvider;
const GUID IID_IX509AttributeExtensions              = GUIDOF!IX509AttributeExtensions;
const GUID IID_IX509AttributeOSVersion               = GUIDOF!IX509AttributeOSVersion;
const GUID IID_IX509AttributeRenewalCertificate      = GUIDOF!IX509AttributeRenewalCertificate;
const GUID IID_IX509Attributes                       = GUIDOF!IX509Attributes;
const GUID IID_IX509CertificateRequest               = GUIDOF!IX509CertificateRequest;
const GUID IID_IX509CertificateRequestCertificate    = GUIDOF!IX509CertificateRequestCertificate;
const GUID IID_IX509CertificateRequestCertificate2   = GUIDOF!IX509CertificateRequestCertificate2;
const GUID IID_IX509CertificateRequestCmc            = GUIDOF!IX509CertificateRequestCmc;
const GUID IID_IX509CertificateRequestCmc2           = GUIDOF!IX509CertificateRequestCmc2;
const GUID IID_IX509CertificateRequestPkcs10         = GUIDOF!IX509CertificateRequestPkcs10;
const GUID IID_IX509CertificateRequestPkcs10V2       = GUIDOF!IX509CertificateRequestPkcs10V2;
const GUID IID_IX509CertificateRequestPkcs10V3       = GUIDOF!IX509CertificateRequestPkcs10V3;
const GUID IID_IX509CertificateRequestPkcs10V4       = GUIDOF!IX509CertificateRequestPkcs10V4;
const GUID IID_IX509CertificateRequestPkcs7          = GUIDOF!IX509CertificateRequestPkcs7;
const GUID IID_IX509CertificateRequestPkcs7V2        = GUIDOF!IX509CertificateRequestPkcs7V2;
const GUID IID_IX509CertificateRevocationList        = GUIDOF!IX509CertificateRevocationList;
const GUID IID_IX509CertificateRevocationListEntries = GUIDOF!IX509CertificateRevocationListEntries;
const GUID IID_IX509CertificateRevocationListEntry   = GUIDOF!IX509CertificateRevocationListEntry;
const GUID IID_IX509CertificateTemplate              = GUIDOF!IX509CertificateTemplate;
const GUID IID_IX509CertificateTemplateWritable      = GUIDOF!IX509CertificateTemplateWritable;
const GUID IID_IX509CertificateTemplates             = GUIDOF!IX509CertificateTemplates;
const GUID IID_IX509EndorsementKey                   = GUIDOF!IX509EndorsementKey;
const GUID IID_IX509Enrollment                       = GUIDOF!IX509Enrollment;
const GUID IID_IX509Enrollment2                      = GUIDOF!IX509Enrollment2;
const GUID IID_IX509EnrollmentHelper                 = GUIDOF!IX509EnrollmentHelper;
const GUID IID_IX509EnrollmentPolicyServer           = GUIDOF!IX509EnrollmentPolicyServer;
const GUID IID_IX509EnrollmentStatus                 = GUIDOF!IX509EnrollmentStatus;
const GUID IID_IX509EnrollmentWebClassFactory        = GUIDOF!IX509EnrollmentWebClassFactory;
const GUID IID_IX509Extension                        = GUIDOF!IX509Extension;
const GUID IID_IX509ExtensionAlternativeNames        = GUIDOF!IX509ExtensionAlternativeNames;
const GUID IID_IX509ExtensionAuthorityKeyIdentifier  = GUIDOF!IX509ExtensionAuthorityKeyIdentifier;
const GUID IID_IX509ExtensionBasicConstraints        = GUIDOF!IX509ExtensionBasicConstraints;
const GUID IID_IX509ExtensionCertificatePolicies     = GUIDOF!IX509ExtensionCertificatePolicies;
const GUID IID_IX509ExtensionEnhancedKeyUsage        = GUIDOF!IX509ExtensionEnhancedKeyUsage;
const GUID IID_IX509ExtensionKeyUsage                = GUIDOF!IX509ExtensionKeyUsage;
const GUID IID_IX509ExtensionMSApplicationPolicies   = GUIDOF!IX509ExtensionMSApplicationPolicies;
const GUID IID_IX509ExtensionSmimeCapabilities       = GUIDOF!IX509ExtensionSmimeCapabilities;
const GUID IID_IX509ExtensionSubjectKeyIdentifier    = GUIDOF!IX509ExtensionSubjectKeyIdentifier;
const GUID IID_IX509ExtensionTemplate                = GUIDOF!IX509ExtensionTemplate;
const GUID IID_IX509ExtensionTemplateName            = GUIDOF!IX509ExtensionTemplateName;
const GUID IID_IX509Extensions                       = GUIDOF!IX509Extensions;
const GUID IID_IX509MachineEnrollmentFactory         = GUIDOF!IX509MachineEnrollmentFactory;
const GUID IID_IX509NameValuePair                    = GUIDOF!IX509NameValuePair;
const GUID IID_IX509NameValuePairs                   = GUIDOF!IX509NameValuePairs;
const GUID IID_IX509PolicyServerListManager          = GUIDOF!IX509PolicyServerListManager;
const GUID IID_IX509PolicyServerUrl                  = GUIDOF!IX509PolicyServerUrl;
const GUID IID_IX509PrivateKey                       = GUIDOF!IX509PrivateKey;
const GUID IID_IX509PrivateKey2                      = GUIDOF!IX509PrivateKey2;
const GUID IID_IX509PublicKey                        = GUIDOF!IX509PublicKey;
const GUID IID_IX509SCEPEnrollment                   = GUIDOF!IX509SCEPEnrollment;
const GUID IID_IX509SCEPEnrollment2                  = GUIDOF!IX509SCEPEnrollment2;
const GUID IID_IX509SCEPEnrollmentHelper             = GUIDOF!IX509SCEPEnrollmentHelper;
const GUID IID_IX509SignatureInformation             = GUIDOF!IX509SignatureInformation;
